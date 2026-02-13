using System.Runtime.InteropServices;
using System.Text;
using System.Reflection;

namespace ACBrLib.NFeMono;

public sealed class ACBrLibNFeBridgeMT
{


    private const string ACBrLibraryName = "ACBrNFe";

    static ACBrLibNFeBridgeMT()
    {
        NativeLibrary.SetDllImportResolver(typeof(ACBrLibNFeBridgeMT).Assembly, DllImportResolver);
    }

    private static IntPtr DllImportResolver(string libraryName, Assembly assembly, DllImportSearchPath? searchPath)
    {
        if (libraryName == ACBrLibraryName)
        {
            string actualLibraryName = GetPlatformSpecificLibraryName();

            // Try to load the library
            if (NativeLibrary.TryLoad(actualLibraryName, assembly, searchPath, out IntPtr handle))
            {
                return handle;
            }

            // If direct load fails, try with common paths
            string[] searchPaths = GetLibrarySearchPaths();
            foreach (string path in searchPaths)
            {
                string fullPath = Path.Combine(path, actualLibraryName);
                if (File.Exists(fullPath) && NativeLibrary.TryLoad(fullPath, out handle))
                {
                    updateEnvPath(path);
                    return handle;
                }
            }

            throw new DllNotFoundException($"Unable to load native library '{actualLibraryName}' for platform.");
        }

        return IntPtr.Zero; // Use default resolver for other libraries
    }

    private static void updateEnvPath(string currentValue)
    {
        var delimiter = RuntimeInformation.IsOSPlatform(OSPlatform.Windows) ? ";" : ":";
        var currentPath = Environment.GetEnvironmentVariable("PATH");
        var updatedPath = string.Concat(currentPath, delimiter, currentValue);
        Environment.SetEnvironmentVariable("PATH", updatedPath);

    }

    private static string GetPlatformSpecificLibraryName()
    {
        string libraryPrefix;
        string extension;
        string arch = Environment.Is64BitProcess ? "64" : "32";

        if (RuntimeInformation.IsOSPlatform(OSPlatform.Windows))
        {
            libraryPrefix = "ACBrNFe";
            extension = ".dll";
        }
        else if (RuntimeInformation.IsOSPlatform(OSPlatform.Linux))
        {
            libraryPrefix = "libacbrnfe";
            extension = ".so";
        }
        else if (RuntimeInformation.IsOSPlatform(OSPlatform.OSX))
        {
            libraryPrefix = "libacbrnfe";
            extension = ".dylib";
        }
        else
        {
            throw new PlatformNotSupportedException("Unsupported platform for ACBrNFe library");
        }

        return $"{libraryPrefix}{arch}{extension}";
    }

    private static string[] GetLibrarySearchPaths()
    {
        var paths = new List<string>();


        // Add current directory
        paths.Add(Environment.CurrentDirectory);


        // Add assembly directory
        string? assemblyLocation = Assembly.GetExecutingAssembly().Location;
        if (!string.IsNullOrEmpty(assemblyLocation))
        {
            string? assemblyDir = Path.GetDirectoryName(assemblyLocation);
            if (!string.IsNullOrEmpty(assemblyDir))
            {
                //Add ACBrLib/[Arch] subfolder ...

                var acbrlibPath = Path.Combine(assemblyDir, "ACBrLib", Environment.Is64BitProcess ? "x64" : "x86");
                paths.Add(assemblyDir);
                paths.Add(acbrlibPath);
            }
        }

        // Add platform-specific paths
        if (RuntimeInformation.IsOSPlatform(OSPlatform.Linux))
        {
            paths.AddRange(new[] { "/usr/lib", "/usr/local/lib", "/lib" });
        }
        else if (RuntimeInformation.IsOSPlatform(OSPlatform.Windows))
        {
            paths.Add(Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.System)));
        }

        return paths.ToArray();
    }

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFE_Inicializar(ref IntPtr handle, string eArqConfig, string eChaveCrypt);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFE_Finalizar(IntPtr handle);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFE_Nome(IntPtr handle, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFE_Versao(IntPtr handle, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFE_OpenSSLInfo(IntPtr handle, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFE_UltimoRetorno(IntPtr handle, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFE_ConfigImportar(IntPtr handle, string eArqConfig);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFE_ConfigExportar(IntPtr handle, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFE_ConfigLer(IntPtr handle, string eArqConfig);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFE_ConfigGravar(IntPtr handle, string eArqConfig);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFE_ConfigLerValor(IntPtr handle, string eSessao, string eChave, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFE_ConfigGravarValor(IntPtr handle, string eSessao, string eChave, string valor);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFE_CarregarXML(IntPtr handle, string eArquivoOuXml);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFE_CarregarINI(IntPtr handle, string eArquivoOuIni);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFE_ObterXml(IntPtr handle, int AIndex, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFE_GravarXml(IntPtr handle, int AIndex, string eNomeArquivo, string ePathArquivo);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFE_ObterIni(IntPtr handle, int AIndex, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFE_GravarIni(IntPtr handle, int AIndex, string eNomeArquivo, string ePathArquivo);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFE_CarregarEventoXML(IntPtr handle, string eArquivoOuXml);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFE_CarregarEventoINI(IntPtr handle, string eArquivoOuIni);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFE_LimparLista(IntPtr handle);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFE_LimparListaEventos(IntPtr handle);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFE_Assinar(IntPtr handle);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFE_Validar(IntPtr handle);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFE_ValidarRegrasdeNegocios(IntPtr handle, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFE_VerificarAssinatura(IntPtr handle, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFE_GerarChave(IntPtr handle, int ACodigoUF, int ACodigoNumerico, int AModelo, int ASerie, int ANumero,
        int ATpEmi, string AEmissao, string CPFCNPJ, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFE_ObterCertificados(IntPtr handle, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFE_GetPath(IntPtr handle, int tipo, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFE_GetPathEvento(IntPtr handle, string aCodEvento, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFE_StatusServico(IntPtr handle, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFE_Consultar(IntPtr handle, string eChaveOuNFe, bool AExtrairEventos, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFE_ConsultaCadastro(IntPtr handle, string cUF, string nDocumento, bool nIE, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFE_Inutilizar(IntPtr handle, string acnpj, string aJustificativa, int ano, int modelo,
        int serie, int numeroInicial, int numeroFinal, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFE_Enviar(IntPtr handle, int aLote, bool imprimir, bool sincrono, bool zipado, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFE_ConsultarRecibo(IntPtr handle, string aRecibo, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFE_Cancelar(IntPtr handle, string eChave, string eJustificativa, string eCNPJ, int aLote,
        StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFE_EnviarEvento(IntPtr handle, int alote, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFE_DistribuicaoDFePorUltNSU(IntPtr handle, int acUFAutor, string eCnpjcpf, string eultNsu, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFE_DistribuicaoDFe(IntPtr handle, int acUFAutor, string eCnpjcpf, string eultNsu, string ArquivoOuXml, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFE_DistribuicaoDFePorNSU(IntPtr handle, int acUFAutor, string eCnpjcpf, string eNsu, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFE_DistribuicaoDFePorChave(IntPtr handle, int acUFAutor, string eCnpjcpf, string echNFe, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFE_EnviarEmail(IntPtr handle, string ePara, string eChaveNFe, bool aEnviaPDF, string eAssunto, string eCc, string eAnexos, string eMensagem);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFE_EnviarEmailEvento(IntPtr handle, string ePara, string eChaveEvento, string eChaveNFe, bool aEnviaPDF, string eAssunto, string eCc, string eAnexos, string eMensagem);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFE_Imprimir(IntPtr handle, string cImpressora, int nNumCopias, string cProtocolo, string bMostrarPreview, string cMarcaDagua, string bViaConsumidor, string bSimplificado);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFE_ImprimirPDF(IntPtr handle);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFE_SalvarPDF(IntPtr handle, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFE_ImprimirEvento(IntPtr handle, string eArquivoXmlNFe, string eArquivoXmlEvento);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFE_ImprimirEventoPDF(IntPtr handle, string eArquivoXmlNFe, string eArquivoXmlEvento);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFE_SalvarEventoPDF(IntPtr handle, string eArquivoXmlNFe, string eArquivoXmlEvento, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFE_ImprimirInutilizacao(IntPtr handle, string eArquivoXml);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFE_ImprimirInutilizacaoPDF(IntPtr handle, string eArquivoXml);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFE_SalvarInutilizacaoPDF(IntPtr handle, string eArquivoXml, StringBuilder buffer, ref int bufferSize);

}