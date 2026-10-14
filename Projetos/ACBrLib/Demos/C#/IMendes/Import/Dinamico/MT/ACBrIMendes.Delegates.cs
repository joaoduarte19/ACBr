using System;
using System.Runtime.InteropServices;
using System.Text;
using ACBrLib.Core;

namespace ACBrLib.IMendes
{
    /// <summary>
    /// Esta classe é o mapeamento C# da interface MultiThread (MT) cdecl da ACBrLibIMendes.
    /// <para>
    /// <see href="https://acbr.sourceforge.io/ACBrLib/ACBrLibeMultiThread.html">ACBrLib MultiThread</see> — Permite integração direta e segura com a DLL nativa, usando delegates para cada função exportada.
    /// </para>
    /// <para>
    /// <b>Fonte original Pascal:</b>
    /// <see href="https://sourceforge.net/p/acbr/code/HEAD/tree/trunk2/Projetos/ACBrLib/Fontes/IMendes/ACBrLibIMendesMT.pas">ACBrLibIMendesMT.pas</see>
    /// </para>
    /// <para>
    /// <b>Mapeamento de tipos (Pascal | C/C++ | C#):</b>
    /// </para>
    /// <para><c>PLibHandle</c> | <c>void*</c> | <c>IntPtr</c></para>
    /// <para><c>PAnsiChar</c> | <c>char*</c> | <c>string</c> (entrada) / <c>StringBuilder</c> (saída)</para>
    /// <para><c>var integer</c> | <c>int*</c> | <c>ref int</c></para>
    /// <para><c>var PLibHandle</c> | <c>void**</c> | <c>ref IntPtr</c></para>
    /// <para><c>Boolean</c> | <c>bool</c> | <c>bool</c></para>
    /// <para>
    /// <b>Convenção cdecl:</b> Todos os métodos nativos da ACBrLib MT usam <b>cdecl</b> (<see href="https://acbr.sourceforge.io/ACBrLib/CdeclouStdCallqualusar.html">documentação</see>), onde o chamador limpa a pilha.
    /// </para>
    /// </summary>
    internal sealed class ACBrIMendesHandle : ACBrLibHandleBase
    {
        /// <summary>
        /// Inicializa a biblioteca ACBrLibIMendes, criando uma nova instância e retornando um handle para ela.
        /// </summary>
        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int IMendes_Inicializar(ref IntPtr libHandle, string eArqConfig, string eChaveCrypt);

        /// <summary>
        /// Finaliza a instância da biblioteca.
        /// </summary>
        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int IMendes_Finalizar(IntPtr handle);

        /// <summary>
        /// Obtém o nome da biblioteca.
        /// </summary>
        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int IMendes_Nome(IntPtr handle, StringBuilder buffer, ref int bufferSize);

        /// <summary>
        /// Obtém a versão da biblioteca.
        /// </summary>
        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int IMendes_Versao(IntPtr handle, StringBuilder buffer, ref int bufferSize);

        /// <summary>
        /// Obtém informações sobre a biblioteca OpenSSL utilizada internamente.
        /// </summary>
        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int IMendes_OpenSSLInfo(IntPtr handle, StringBuilder buffer, ref int bufferSize);

        /// <summary>
        /// Obtém a última mensagem de retorno da biblioteca.
        /// </summary>
        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int IMendes_UltimoRetorno(IntPtr handle, StringBuilder buffer, ref int bufferSize);

        /// <summary>
        /// Importa configurações de um arquivo INI para a biblioteca.
        /// </summary>
        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int IMendes_ConfigImportar(IntPtr handle, string eArqConfig);

        /// <summary>
        /// Exporta as configurações atuais da biblioteca no formato INI.
        /// </summary>
        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int IMendes_ConfigExportar(IntPtr handle, StringBuilder buffer, ref int bufferSize);

        /// <summary>
        /// Lê as configurações de um arquivo INI e aplica na biblioteca.
        /// </summary>
        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int IMendes_ConfigLer(IntPtr handle, string eArqConfig);

        /// <summary>
        /// Grava as configurações atuais da biblioteca em um arquivo INI.
        /// </summary>
        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int IMendes_ConfigGravar(IntPtr handle, string eArqConfig);

        /// <summary>
        /// Lê o valor de uma chave de configuração.
        /// </summary>
        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int IMendes_ConfigLerValor(IntPtr handle, string eSessao, string eChave, StringBuilder buffer, ref int bufferSize);

        /// <summary>
        /// Grava o valor de uma chave de configuração.
        /// </summary>
        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int IMendes_ConfigGravarValor(IntPtr handle, string eSessao, string eChave, string valor);

        /// <summary>
        /// Consulta produtos na base IMendes pela descrição.
        /// </summary>
        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int IMendes_ConsultarDescricao(IntPtr handle, string eDescricao, string eCNPJ, int nTipo, StringBuilder buffer, ref int bufferSize);

        /// <summary>
        /// Consulta os produtos finalizados ou alterados.
        /// </summary>
        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int IMendes_ConsultarAlterados(IntPtr handle, string eUF, string eCNPJ, int nLimite, StringBuilder buffer, ref int bufferSize);

        /// <summary>
        /// Consulta o histórico de acesso e os produtos devolvidos.
        /// </summary>
        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int IMendes_HistoricoAcesso(IntPtr handle, string eCNPJ, StringBuilder buffer, ref int bufferSize);

        /// <summary>
        /// Consulta os regimes especiais da UF.
        /// </summary>
        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int IMendes_ConsultarRegimesEspeciais(IntPtr handle, string eUF, bool bIncludeTrib, StringBuilder buffer, ref int bufferSize);

        /// <summary>
        /// Consulta a tributação dos produtos (Saneamento Grades).
        /// </summary>
        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int IMendes_SaneamentoGrades(IntPtr handle, string eArquivoOuIni, StringBuilder buffer, ref int bufferSize);

        /// <summary>
        /// Inativa produtos na base IMendes.
        /// </summary>
        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int IMendes_Inativar(IntPtr handle, string eArquivoOuIni, StringBuilder buffer, ref int bufferSize);

        /// <summary>
        /// Remove produtos da lista de devolvidos.
        /// </summary>
        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int IMendes_RemoveDevolvidos(IntPtr handle, string eArquivoOuIni, StringBuilder buffer, ref int bufferSize);

        /// <inheritdoc />
        protected override void InitializeMethods()
        {
            AddMethod<IMendes_Inicializar>("IMendes_Inicializar");
            AddMethod<IMendes_Finalizar>("IMendes_Finalizar");
            AddMethod<IMendes_Nome>("IMendes_Nome");
            AddMethod<IMendes_Versao>("IMendes_Versao");
            AddMethod<IMendes_OpenSSLInfo>("IMendes_OpenSSLInfo");
            AddMethod<IMendes_UltimoRetorno>("IMendes_UltimoRetorno");
            AddMethod<IMendes_ConfigImportar>("IMendes_ConfigImportar");
            AddMethod<IMendes_ConfigExportar>("IMendes_ConfigExportar");
            AddMethod<IMendes_ConfigLer>("IMendes_ConfigLer");
            AddMethod<IMendes_ConfigGravar>("IMendes_ConfigGravar");
            AddMethod<IMendes_ConfigLerValor>("IMendes_ConfigLerValor");
            AddMethod<IMendes_ConfigGravarValor>("IMendes_ConfigGravarValor");
            AddMethod<IMendes_ConsultarDescricao>("IMendes_ConsultarDescricao");
            AddMethod<IMendes_ConsultarAlterados>("IMendes_ConsultarAlterados");
            AddMethod<IMendes_HistoricoAcesso>("IMendes_HistoricoAcesso");
            AddMethod<IMendes_ConsultarRegimesEspeciais>("IMendes_ConsultarRegimesEspeciais");
            AddMethod<IMendes_SaneamentoGrades>("IMendes_SaneamentoGrades");
            AddMethod<IMendes_Inativar>("IMendes_Inativar");
            AddMethod<IMendes_RemoveDevolvidos>("IMendes_RemoveDevolvidos");
        }

        /// <inheritdoc />
        protected override string GetLibraryName()
        {
            var arch = Environment.Is64BitProcess ? "64" : "32";
            if (PlatformID.Unix == Environment.OSVersion.Platform)
                return $"libacbrimendes{arch}.so";
            return $"ACBrIMendes{arch}.dll";
        }

        // thread safe singleton pattern para ACBrIMendesHandle usando Lazy Singleton
        static readonly Lazy<ACBrIMendesHandle> _instance = new Lazy<ACBrIMendesHandle>(() => new ACBrIMendesHandle());

        /// <summary>
        /// Singleton para acesso ao ACBrIMendesHandle, garantindo que apenas uma instância seja criada durante a execução do programa.
        /// </summary>
        public static ACBrIMendesHandle Instance => _instance.Value;
    }
}
