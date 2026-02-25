using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;
using ACBrLib.Core;
using ACBrLib.Core.DFe;

namespace ACBrLib.ConsultaCNPJ
{
    /// <summary>
    /// Handle de interoperabilidade para a ACBrConsultaCNPJ MT.
    /// <para>
    /// <see href="https://acbr.sourceforge.io/ACBrLib/ACBrLibeMultiThread.html">ACBrLib MultiThread</see>
    /// </para>
    /// <para>
    /// Esta classe encapsula os delegates (ponteiros de função) para chamada de métodos nativos da biblioteca ACBrConsultaCNPJ,
    /// permitindo integração entre C# e o código nativo Pascal.
    /// </para>
    /// <para>
    /// <b>Fonte original Pascal:</b>
    /// <see href="https://sourceforge.net/p/acbr/code/HEAD/tree/trunk2/Projetos/ACBrLib/Fontes/ConsultaCNPJ/ACBrLibConsultaCNPJMT.pas">ACBrLibConsultaCNPJMT.pas</see>
    /// </para>
    /// <para>
    /// <b>Mapeamento de tipos e interoperabilidade:</b>
    /// <list type="bullet">
    /// <item><description><b>plibHandle</b> (Pascal: <c>PLibHandle = ^LibHandle; LibHandle = Pointer</c>) → <b>IntPtr</b> em C#.</description></item>
    /// <item><description><b>IntPtr</b> representa ponteiro nativo (<c>void*</c> em C/C++), usado para handles e instâncias nativas.</description></item>
    /// <item><description><b>StringBuilder</b> é usado como buffer de texto, equivalente a <c>char*</c> em C/C++.</description></item>
    /// <item><description><b>ref IntPtr</b> indica passagem por referência de ponteiro (<c>void**</c>), permitindo inicialização/alteração do ponteiro.</description></item>
    /// <item><description><b>ref int</b> (ex: <c>ref bufferSize</c>) indica passagem por referência de inteiros, geralmente para informar e receber o tamanho real do buffer.</description></item>
    /// <item><description>Em Pascal, o uso de <b>ref</b> em C# corresponde à palavra-chave especial <b>var</b>, que indica passagem por referência.</description></item>
    /// </list>
    /// </para>
    /// <para>
    /// <b>Sobre delegates em C#:</b> Delegates são tipos que representam referências para métodos, permitindo encapsular funções como objetos. Neste contexto, são usados para mapear funções exportadas por bibliotecas nativas (DLLs) e possibilitar chamadas diretas do código gerenciado (C#) para o código nativo (Pascal/C/C++).
    /// </para>
    /// <para>
    /// <b>Convenção de chamada cdecl:</b> Todos os métodos nativos da ACBrLib utilizam a convenção de chamada <b>cdecl</b> (<see href="https://acbr.sourceforge.io/ACBrLib/CdeclouStdCallqualusar.html">documentação</see>), que define como os parâmetros são passados e quem é responsável por limpar a pilha após a chamada. No caso de cdecl, a responsabilidade é do chamador. Isso garante compatibilidade entre diferentes compiladores e linguagens.
    /// </para>
    /// </summary>
    internal sealed class ACBrConsultaCNPJHandle : ACBrLibHandleBase
    {


        // Pascal: function CNPJ_Inicializar(var libHandle: PLibHandle; eArqConfig: PChar; eChaveCrypt: PChar): longint; cdecl;
        /// <summary>
        /// Inicializa a biblioteca ACBrConsultaCNPJ, criando uma nova instância e retornando um handle para ela.
        /// </summary>
        /// <param name="libHandle">Ponteiro para receber o handle da instância criada.</param>
        /// <param name="eArqConfig">Caminho do arquivo de configuração (opcional).</param>
        /// <param name="eChaveCrypt">Chave de criptografia para o arquivo de configuração (opcional).</param>
        /// <returns>Código de status da operação (0 = sucesso).</returns>
        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int CNPJ_Inicializar(ref IntPtr libHandle, string eArqConfig, string eChaveCrypt);
        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int CNPJ_Finalizar(IntPtr handle);


        // Pascal: function CNPJ_Nome(libHandle: PLibHandle; buffer: PChar; var bufferSize: longint): longint; cdecl;
        /// <summary>
        /// Obtém o nome da biblioteca ACBrConsultaCNPJ.
        /// </summary>
        /// <param name="handle">Ponteiro da instância da biblioteca.</param>
        /// <param name="buffer">Buffer para receber o nome.</param>
        /// <param name="bufferSize">Tamanho do buffer (entrada e saída).</param>
        /// <returns>Código de status da operação (0 = sucesso).</returns>
        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int CNPJ_Nome(IntPtr handle, StringBuilder buffer, ref int bufferSize);


        // Pascal: function CNPJ_Versao(libHandle: PLibHandle; buffer: PChar; var bufferSize: longint): longint; cdecl;
        /// <summary>
        /// Obtém a versão da biblioteca ACBrConsultaCNPJ.
        /// </summary>
        /// <param name="handle">Ponteiro da instância da biblioteca.</param>
        /// <param name="buffer">Buffer para receber a versão.</param>
        /// <param name="bufferSize">Tamanho do buffer (entrada e saída).</param>
        /// <returns>Código de status da operação (0 = sucesso).</returns>
        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int CNPJ_Versao(IntPtr handle, StringBuilder buffer, ref int bufferSize);


        // Pascal: function CNPJ_UltimoRetorno(libHandle: PLibHandle; buffer: PChar; var bufferSize: longint): longint; cdecl;
        /// <summary>
        /// Obtém a última mensagem de retorno da biblioteca.
        /// </summary>
        /// <param name="handle">Ponteiro da instância da biblioteca.</param>
        /// <param name="buffer">Buffer para receber a mensagem.</param>
        /// <param name="bufferSize">Tamanho do buffer (entrada e saída).</param>
        /// <returns>Código de status da operação (0 = sucesso).</returns>
        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int CNPJ_UltimoRetorno(IntPtr handle, StringBuilder buffer, ref int bufferSize);


        // Pascal: function CNPJ_ConfigImportar(libHandle: PLibHandle; eArqConfig: PChar): longint; cdecl;
        /// <summary>
        /// Importa configurações de um arquivo INI para a biblioteca.
        /// </summary>
        /// <param name="handle">Ponteiro da instância da biblioteca.</param>
        /// <param name="eArqConfig">Caminho do arquivo de configuração INI.</param>
        /// <returns>Código de status da operação (0 = sucesso).</returns>
        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int CNPJ_ConfigImportar(IntPtr handle, string eArqConfig);


        // Pascal: function CNPJ_ConfigExportar(libHandle: PLibHandle; buffer: PChar; var bufferSize: longint): longint; cdecl;
        /// <summary>
        /// Exporta as configurações atuais da biblioteca para uma string no formato INI.
        /// </summary>
        /// <param name="handle">Ponteiro da instância da biblioteca.</param>
        /// <param name="buffer">Buffer para receber o conteúdo exportado.</param>
        /// <param name="bufferSize">Tamanho do buffer (entrada e saída).</param>
        /// <returns>Código de status da operação (0 = sucesso).</returns>
        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int CNPJ_ConfigExportar(IntPtr handle, StringBuilder buffer, ref int bufferSize);


        // Pascal: function CNPJ_ConfigLer(libHandle: PLibHandle; eArqConfig: PChar): longint; cdecl;
        /// <summary>
        /// Lê as configurações de um arquivo INI e aplica na biblioteca.
        /// </summary>
        /// <param name="handle">Ponteiro da instância da biblioteca.</param>
        /// <param name="eArqConfig">Caminho do arquivo de configuração INI.</param>
        /// <returns>Código de status da operação (0 = sucesso).</returns>
        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int CNPJ_ConfigLer(IntPtr handle, string eArqConfig);


        // Pascal: function CNPJ_ConfigGravar(libHandle: PLibHandle; eArqConfig: PChar): longint; cdecl;
        /// <summary>
        /// Grava as configurações atuais da biblioteca em um arquivo INI.
        /// </summary>
        /// <param name="handle">Ponteiro da instância da biblioteca.</param>
        /// <param name="eArqConfig">Caminho do arquivo de configuração INI.</param>
        /// <returns>Código de status da operação (0 = sucesso).</returns>
        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int CNPJ_ConfigGravar(IntPtr handle, string eArqConfig);


        // Pascal: function CNPJ_ConfigLerValor(libHandle: PLibHandle; eSessao, eChave: PChar; buffer: PChar; var bufferSize: longint): longint; cdecl;
        /// <summary>
        /// Lê o valor de uma chave de configuração específica.
        /// </summary>
        /// <param name="handle">Ponteiro da instância da biblioteca.</param>
        /// <param name="eSessao">Nome da sessão no arquivo INI.</param>
        /// <param name="eChave">Nome da chave a ser lida.</param>
        /// <param name="buffer">Buffer para receber o valor.</param>
        /// <param name="bufferSize">Tamanho do buffer (entrada e saída).</param>
        /// <returns>Código de status da operação (0 = sucesso).</returns>
        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int CNPJ_ConfigLerValor(IntPtr handle, string eSessao, string eChave, StringBuilder buffer, ref int bufferSize);


        // Pascal: function CNPJ_ConfigGravarValor(libHandle: PLibHandle; eSessao, eChave, valor: PChar): longint; cdecl;
        /// <summary>
        /// Grava o valor de uma chave de configuração específica.
        /// </summary>
        /// <param name="handle">Ponteiro da instância da biblioteca.</param>
        /// <param name="eSessao">Nome da sessão no arquivo INI.</param>
        /// <param name="eChave">Nome da chave a ser gravada.</param>
        /// <param name="valor">Valor a ser gravado.</param>
        /// <returns>Código de status da operação (0 = sucesso).</returns>
        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int CNPJ_ConfigGravarValor(IntPtr handle, string eSessao, string eChave, string valor);


        // Pascal: function CNPJ_Consultar(libHandle: PLibHandle; eCNPJ: PChar; buffer: PChar; var bufferSize: longint): longint; cdecl;
        /// <summary>
        /// Realiza a consulta de informações cadastrais de um CNPJ.
        /// </summary>
        /// <param name="handle">Ponteiro da instância da biblioteca.</param>
        /// <param name="eCNPJ">CNPJ a ser consultado (apenas números).</param>
        /// <param name="buffer">Buffer para receber a resposta da consulta.</param>
        /// <param name="bufferSize">Tamanho do buffer (entrada e saída).</param>
        /// <returns>Código de status da operação (0 = sucesso, -10 = erro).</returns>
        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int CNPJ_Consultar(IntPtr handle, string eCNPJ, StringBuilder buffer, ref int bufferSize);


        // Pascal: function CNPJ_OpenSSLInfo(libHandle: PLibHandle; buffer: PChar; var bufferSize: longint): longint; cdecl;
        /// <summary>
        /// Obtém informações sobre a biblioteca OpenSSL utilizada internamente.
        /// </summary>
        /// <param name="handle">Ponteiro da instância da biblioteca.</param>
        /// <param name="buffer">Buffer para receber as informações.</param>
        /// <param name="bufferSize">Tamanho do buffer (entrada e saída).</param>
        /// <returns>Código de status da operação (0 = sucesso).</returns>
        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int CNPJ_OpenSSLInfo(IntPtr handle, StringBuilder buffer, ref int bufferSize);

        /// <inheritdoc />
        protected override void InitializeMethods()
        {
            AddMethod<CNPJ_Inicializar>("CNPJ_Inicializar");
            AddMethod<CNPJ_Finalizar>("CNPJ_Finalizar");
            AddMethod<CNPJ_Nome>("CNPJ_Nome");
            AddMethod<CNPJ_Versao>("CNPJ_Versao");
            AddMethod<CNPJ_UltimoRetorno>("CNPJ_UltimoRetorno");
            AddMethod<CNPJ_ConfigImportar>("CNPJ_ConfigImportar");
            AddMethod<CNPJ_ConfigExportar>("CNPJ_ConfigExportar");
            AddMethod<CNPJ_ConfigLer>("CNPJ_ConfigLer");
            AddMethod<CNPJ_ConfigGravar>("CNPJ_ConfigGravar");
            AddMethod<CNPJ_ConfigLerValor>("CNPJ_ConfigLerValor");
            AddMethod<CNPJ_ConfigGravarValor>("CNPJ_ConfigGravarValor");
            AddMethod<CNPJ_Consultar>("CNPJ_Consultar");
            AddMethod<CNPJ_OpenSSLInfo>("CNPJ_OpenSSLInfo");

        }

        /// <inheritdoc />
        protected override string GetLibraryName()
        {
            var arch = Environment.Is64BitProcess ? "64" : "32";
            if (PlatformID.Unix == Environment.OSVersion.Platform)
                return $"libacbrconsultaCNPJ{arch}.so";
            return $"ACBrConsultaCNPJ{arch}.dll";
        }

        // thread safe singleton pattern for ACBrConsultaCNPJHandle usando Lazy Singleton
        static readonly Lazy<ACBrConsultaCNPJHandle> _instance = new Lazy<ACBrConsultaCNPJHandle>(() => new ACBrConsultaCNPJHandle());

        /// <summary>
        /// Singleton para acesso ao ACBrConsultaCNPJHandle, garantindo que apenas uma instância seja criada durante a execução do programa.
        /// </summary>
        public static ACBrConsultaCNPJHandle Instance => _instance.Value;
    }
}