using System;
using System.Runtime.InteropServices;
using System.Text;
using ACBrLib.Core;

namespace ACBrLib.ETQ
{
    /// <summary>
    /// Mapeamento C# da interface MultiThread (MT) cdecl da ACBrLibETQ.
    /// Permite integração com a DLL nativa usando delegates para cada função exportada.
    /// </summary>
    internal sealed class ACBrETQHandle : ACBrLibHandleBase
    {
        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int ETQ_Inicializar(ref IntPtr handle, string eArqConfig, string eChaveCrypt);

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int ETQ_Finalizar(IntPtr handle);

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int ETQ_Nome(IntPtr handle, StringBuilder buffer, ref int bufferSize);

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int ETQ_Versao(IntPtr handle, StringBuilder buffer, ref int bufferSize);

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int ETQ_UltimoRetorno(IntPtr handle, StringBuilder buffer, ref int bufferSize);

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int ETQ_ConfigImportar(IntPtr handle, string eArqConfig);

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int ETQ_ConfigExportar(IntPtr handle, StringBuilder buffer, ref int bufferSize);

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int ETQ_ConfigLer(IntPtr handle, string eArqConfig);

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int ETQ_ConfigGravar(IntPtr handle, string eArqConfig);

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int ETQ_ConfigLerValor(IntPtr handle, string eSessao, string eChave, StringBuilder buffer, ref int bufferSize);

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int ETQ_ConfigGravarValor(IntPtr handle, string eSessao, string eChave, string valor);

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int ETQ_Ativar(IntPtr handle);

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int ETQ_Desativar(IntPtr handle);

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int ETQ_IniciarEtiqueta(IntPtr handle);

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int ETQ_FinalizarEtiqueta(IntPtr handle, int aCopias, int aAvancoEtq);

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int ETQ_CarregarImagem(IntPtr handle, string eArquivoImagem, string eNomeImagem, bool flipped);

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int ETQ_Imprimir(IntPtr handle, int aCopias, int aAvancoEtq);

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int ETQ_ImprimirTexto(IntPtr handle, int orientacao, int fonte, int multiplicadorH, int multiplicadorV,
            int vertical, int horizontal, string eTexto, int subFonte, bool imprimirReverso);

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int ETQ_ImprimirTextoStr(IntPtr handle, int orientacao, string fonte, int multiplicadorH, int multiplicadorV,
            int vertical, int horizontal, string eTexto, int subFonte, bool imprimirReverso);

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int ETQ_ImprimirBarras(IntPtr handle, int orientacao, int tipoBarras, int larguraBarraLarga, int larguraBarraFina,
            int vertical, int horizontal, string eTexto, int alturaCodBarras, int exibeCodigo);

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int ETQ_ImprimirLinha(IntPtr handle, int vertical, int horizontal, int largura, int altura);

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int ETQ_ImprimirCaixa(IntPtr handle, int vertical, int horizontal, int largura, int altura, int espessuraVertical,
            int espessuraHorizontal);

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int ETQ_ImprimirImagem(IntPtr handle, int multiplicadorImagem, int vertical, int horizontal, string eNomeImagem);

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int ETQ_ImprimirQRCode(IntPtr handle, int vertical, int horizontal, string texto, int larguraModulo, int errorLevel, int tipo);

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int ETQ_OpenSSLInfo(IntPtr handle, StringBuilder buffer, ref int bufferSize);

        protected override void InitializeMethods()
        {
            AddMethod<ETQ_Inicializar>("ETQ_Inicializar");
            AddMethod<ETQ_Finalizar>("ETQ_Finalizar");
            AddMethod<ETQ_Nome>("ETQ_Nome");
            AddMethod<ETQ_Versao>("ETQ_Versao");
            AddMethod<ETQ_UltimoRetorno>("ETQ_UltimoRetorno");
            AddMethod<ETQ_ConfigImportar>("ETQ_ConfigImportar");
            AddMethod<ETQ_ConfigExportar>("ETQ_ConfigExportar");
            AddMethod<ETQ_ConfigLer>("ETQ_ConfigLer");
            AddMethod<ETQ_ConfigGravar>("ETQ_ConfigGravar");
            AddMethod<ETQ_ConfigLerValor>("ETQ_ConfigLerValor");
            AddMethod<ETQ_ConfigGravarValor>("ETQ_ConfigGravarValor");
            AddMethod<ETQ_Ativar>("ETQ_Ativar");
            AddMethod<ETQ_Desativar>("ETQ_Desativar");
            AddMethod<ETQ_IniciarEtiqueta>("ETQ_IniciarEtiqueta");
            AddMethod<ETQ_FinalizarEtiqueta>("ETQ_FinalizarEtiqueta");
            AddMethod<ETQ_CarregarImagem>("ETQ_CarregarImagem");
            AddMethod<ETQ_Imprimir>("ETQ_Imprimir");
            AddMethod<ETQ_ImprimirTexto>("ETQ_ImprimirTexto");
            AddMethod<ETQ_ImprimirTextoStr>("ETQ_ImprimirTextoStr");
            AddMethod<ETQ_ImprimirBarras>("ETQ_ImprimirBarras");
            AddMethod<ETQ_ImprimirLinha>("ETQ_ImprimirLinha");
            AddMethod<ETQ_ImprimirCaixa>("ETQ_ImprimirCaixa");
            AddMethod<ETQ_ImprimirImagem>("ETQ_ImprimirImagem");
            AddMethod<ETQ_ImprimirQRCode>("ETQ_ImprimirQRCode");
            AddMethod<ETQ_OpenSSLInfo>("ETQ_OpenSSLInfo");
        }

        protected override string GetLibraryName()
        {
            var arch = Environment.Is64BitProcess ? "64" : "32";
            if (PlatformID.Unix == Environment.OSVersion.Platform)
                return $"libacbretq{arch}.so";
            return $"ACBrETQ{arch}.dll";
        }

        static readonly Lazy<ACBrETQHandle> _instance = new Lazy<ACBrETQHandle>(() => new ACBrETQHandle());

        public static ACBrETQHandle Instance => _instance.Value;
    }
}
