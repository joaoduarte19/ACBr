using System.Runtime.InteropServices;
using System.Text;
using System.Reflection;


namespace ACBrLib.NFSeMono;

public class ACBrLibNFSeBridgeMT
{
    private const string ACBrLibraryName = "ACBrNFSe";

    static ACBrLibNFSeBridgeMT()
    {
        NativeLibrary.SetDllImportResolver(typeof(ACBrLibNFSeBridgeMT).Assembly, DllImportResolver);
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
                    return handle;
                }
            }

            throw new DllNotFoundException($"Unable to load native library '{actualLibraryName}' for platform.");
        }

        return IntPtr.Zero; // Use default resolver for other libraries
    }

    private static string GetPlatformSpecificLibraryName()
    {
        string libraryPrefix;
        string extension;
        string arch = Environment.Is64BitProcess ? "64" : "32";

        if (RuntimeInformation.IsOSPlatform(OSPlatform.Windows))
        {
            libraryPrefix = "ACBrNFse";
            extension = ".dll";
        }
        else if (RuntimeInformation.IsOSPlatform(OSPlatform.Linux))
        {
            libraryPrefix = "libacbrnfse";
            extension = ".so";
        }
        else if (RuntimeInformation.IsOSPlatform(OSPlatform.OSX))
        {
            libraryPrefix = "libacbrnfse";
            extension = ".dylib";
        }
        else
        {
            throw new PlatformNotSupportedException("Unsupported platform for ACBrNFSe library");
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
    public static extern int NFSE_Inicializar(ref IntPtr handle, string eArqConfig, string eChaveCrypt);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFSE_Finalizar(IntPtr handle);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFSE_Nome(IntPtr handle, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFSE_Versao(IntPtr handle, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFSE_OpenSSLInfo(IntPtr handle, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFSE_UltimoRetorno(IntPtr handle, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFSE_ConfigImportar(IntPtr handle, string eArqConfig);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFSE_ConfigExportar(IntPtr handle, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFSE_ConfigLer(IntPtr handle, string eArqConfig);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFSE_ConfigGravar(IntPtr handle, string eArqConfig);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFSE_ConfigLerValor(IntPtr handle, string eSessao, string eChave, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFSE_ConfigGravarValor(IntPtr handle, string eSessao, string eChave, string valor);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFSE_CarregarXML(IntPtr handle, string eArquivoOuXml);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFSE_CarregarLoteXML(IntPtr handle, string eArquivoOuXml);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFSE_CarregarINI(IntPtr handle, string eArquivoOuIni);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFSE_ObterXml(IntPtr handle, int AIndex, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFSE_ObterXmlRps(IntPtr handle, int AIndex, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFSE_GravarXml(IntPtr handle, int AIndex, string eNomeArquivo, string ePathArquivo);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFSE_ObterIni(IntPtr handle, int AIndex, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFSE_GravarIni(IntPtr handle, int AIndex, string eNomeArquivo, string ePathArquivo);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFSE_LimparLista(IntPtr handle);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFSE_ObterCertificados(IntPtr handle, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFSE_Emitir(IntPtr handle, string aLote, int aModoEnvio, bool aImprimir, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFSE_Cancelar(IntPtr handle, string aInfCancelamento, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFSE_SubstituirNFSe(IntPtr handle, string aNumeroNFSe, string aSerieNFSe, string aCodigoCancelamento, string aMotivoCancelamento, string aNumeroLote, string aCodigoVerificacao, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFSE_LinkNFSe(IntPtr handle, string aNumeroNFSe, string aCodigoVerificacao, string aChaveAcesso, string aValorServico, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFSE_GerarLote(IntPtr handle, string aLote, int aQtdMaximaRps, int aModoEnvio, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFSE_GerarToken(IntPtr handle, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFSE_ConsultarSituacao(IntPtr handle, string aProtocolo, string aNumeroLote, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFSE_ConsultarLoteRps(IntPtr handle, string aProcotolo, string aNumLote, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFSE_ConsultarNFSePorRps(IntPtr handle, string aNumeroRps, string aSerie, string aTipo, string aCodigoVerificacao, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFSE_ConsultarNFSePorNumero(IntPtr handle, string aNumero, int aPagina, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFSE_ConsultarNFSePorPeriodo(IntPtr handle, DateTime aDataInicial, DateTime aDataFinal, int aPagina, string aNumeroLote, int aTipoPeriodo, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFSE_ConsultarNFSePorFaixa(IntPtr handle, string aNumeroInicial, string aNumeroFinal, int aPagina, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFSE_ConsultarNFSeGenerico(IntPtr handle, string aInfConsultaNFSe, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFSE_ConsultarLinkNFSe(IntPtr handle, string aInfConsultaLinkNFSe, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFSE_EnviarEmail(IntPtr handle, string ePara, string eXmlNFSe, bool aEnviaPDF, string eAssunto, string eCc, string eAnexos, string eMensagem);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFSE_Imprimir(IntPtr handle, string cImpressora, int nNumCopias, string bGerarPDF, string bMostrarPreview, string cCancelada);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFSE_ImprimirPDF(IntPtr handle);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFSE_SalvarPDF(IntPtr handle, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFSE_ConsultarNFSeServicoPrestadoPorNumero(IntPtr handle, string aNumero, int aPagina, DateTime aDataInicial, DateTime aDataFinal, int aTipoPeriodo, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFSE_ConsultarNFSeServicoPrestadoPorPeriodo(IntPtr handle, DateTime aDataInicial, DateTime aDataFinal, int aPagina, int aTipoPeriodo, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFSE_ConsultarNFSeServicoPrestadoPorTomador(IntPtr handle, string aCNPJ, string aInscMun, int aPagina, DateTime aDataInicial, DateTime aDataFinal, int aTipoPeriodo, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFSE_ConsultarNFSeServicoPrestadoPorIntermediario(IntPtr handle, string aCNPJ, string aInscMun, int aPagina, DateTime aDataInicial, DateTime aDataFinal, int aTipoPeriodo, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFSE_ConsultarNFSeServicoTomadoPorNumero(IntPtr handle, string aNumero, int aPagina, DateTime aDataInicial, DateTime aDataFinal, int aTipoPeriodo, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFSE_ConsultarNFSeServicoTomadoPorPrestador(IntPtr handle, string aCNPJ, string aInscMun, int aPagina, DateTime aDataInicial, DateTime aDataFinal, int aTipoPeriodo, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFSE_ConsultarNFSeServicoTomadoPorTomador(IntPtr handle, string aCNPJ, string aInscMun, int aPagina, DateTime aDataInicial, DateTime aDataFinal, int aTipoPeriodo, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFSE_ConsultarNFSeServicoTomadoPorPeriodo(IntPtr handle, DateTime aDataInicial, DateTime aDataFinal, int aPagina, int aTipoPeriodo, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFSE_ConsultarNFSeServicoTomadoPorIntermediario(IntPtr handle, string aCNPJ, string aInscMun, int aPagina, DateTime aDataInicial, DateTime aDataFinal, int aTipoPeriodo, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFSE_EnviarEvento(IntPtr handle, string aInfEvento, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFSE_ConsultarDPSPorChave(IntPtr handle, string aChaveDPS, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFSE_ConsultarNFSePorChave(IntPtr handle, string aChaveNFSe, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFSE_ConsultarEvento(IntPtr handle, string aChave, int aTipoEvento, int aNumSeq, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFSE_ConsultarDFe(IntPtr handle, int aNSU, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFSE_ObterDANFSE(IntPtr handle, string aChaveNFSe, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFSE_ConsultarParametros(IntPtr handle, int aTipoParametroMunicipio, string aCodigoServico, DateTime aCompetencia, string aNumeroBeneficio, StringBuilder buffer, ref int bufferSize);

    [DllImport(ACBrLibraryName, CallingConvention = CallingConvention.Cdecl)]
    public static extern int NFSE_ObterInformacoesProvedor(IntPtr handle, StringBuilder buffer, ref int bufferSize);
}
