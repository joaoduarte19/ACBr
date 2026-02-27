using System;
using System.Text;
using ACBrLib.Core;
using ACBrLib.Core.ETQ;

namespace ACBrLib.ETQ
{
    /// <summary>
    /// ACBrETQ é uma classe que implementa a interface <see cref="IACBrLibETQ"/> e fornece métodos para controle de etiquetadoras e impressão de etiquetas, utilizando a biblioteca ACBrLib.
    /// </summary>
    public class ACBrETQ : ACBrLibBase, IACBrLibETQ
    {
        #region Fields

        private IntPtr libHandle = IntPtr.Zero;
        private bool disposed = false;
        private ACBrETQHandle etqBridge;

        #endregion Fields

        #region Constructors

        /// <summary>
        /// Inicializa uma nova instância da classe <see cref="ACBrETQ"/> para controle de etiquetadoras, com opções de configuração inicial.
        /// </summary>
        /// <param name="eArqConfig">Caminho para o arquivo de configuração.</param>
        /// <param name="eChaveCrypt">Chave de criptografia para o arquivo de configuração.</param>
        public ACBrETQ(string eArqConfig = "", string eChaveCrypt = "") : base(eArqConfig, eChaveCrypt)
        {
            etqBridge = ACBrETQHandle.Instance;
            Inicializar(eArqConfig, eChaveCrypt);
            Config = new ACBrETQConfig(this);
        }

        #endregion Constructors

        /// <inheritdoc />
        public override void Inicializar(string eArqConfig = "", string eChaveCrypt = "")
        {
            var inicializarLib = etqBridge.GetMethod<ACBrETQHandle.ETQ_Inicializar>();
            var ret = etqBridge.ExecuteMethod<int>(() => inicializarLib(ref libHandle, ToUTF8(eArqConfig), ToUTF8(eChaveCrypt)));
            CheckResult(ret);
        }

        #region Properties

        /// <inheritdoc />
        public override string Nome()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = etqBridge.GetMethod<ACBrETQHandle.ETQ_Nome>();
            var ret = etqBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public override string Versao()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = etqBridge.GetMethod<ACBrETQHandle.ETQ_Versao>();
            var ret = etqBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public ACBrETQConfig Config { get; }

        #endregion Properties

        #region Métodos

        #region Ini

        /// <inheritdoc />
        public override void ConfigGravar(string eArqConfig = "")
        {
            var gravarIni = etqBridge.GetMethod<ACBrETQHandle.ETQ_ConfigGravar>();
            var ret = etqBridge.ExecuteMethod(() => gravarIni(libHandle, ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        /// <inheritdoc />
        public override void ImportarConfig(string eArqConfig)
        {
            var lerIni = etqBridge.GetMethod<ACBrETQHandle.ETQ_ConfigImportar>();
            var ret = etqBridge.ExecuteMethod(() => lerIni(libHandle, ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        /// <inheritdoc />
        public override string ExportarConfig()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = etqBridge.GetMethod<ACBrETQHandle.ETQ_ConfigExportar>();
            var ret = etqBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public override void ConfigLer(string eArqConfig = "")
        {
            var lerIni = etqBridge.GetMethod<ACBrETQHandle.ETQ_ConfigLer>();
            var ret = etqBridge.ExecuteMethod(() => lerIni(libHandle, ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        /// <inheritdoc />
        public override string ConfigLerValor(string eSessao, string eChave)
        {
            var method = etqBridge.GetMethod<ACBrETQHandle.ETQ_ConfigLerValor>();
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);
            var ret = etqBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eSessao), ToUTF8(eChave), buffer, ref bufferLen));
            CheckResult(ret);
            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public override void ConfigGravarValor(string eSessao, string eChave, string eValor)
        {
            var method = etqBridge.GetMethod<ACBrETQHandle.ETQ_ConfigGravarValor>();
            var ret = etqBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eSessao), ToUTF8(eChave), ToUTF8(eValor)));
            CheckResult(ret);
        }

        #endregion Ini

        #region Etiqueta

        /// <inheritdoc />
        public void Ativar()
        {
            var method = etqBridge.GetMethod<ACBrETQHandle.ETQ_Ativar>();
            var ret = etqBridge.ExecuteMethod(() => method(libHandle));

            CheckResult(ret);
        }

        /// <inheritdoc />
        public void Desativar()
        {
            var method = etqBridge.GetMethod<ACBrETQHandle.ETQ_Desativar>();
            var ret = etqBridge.ExecuteMethod(() => method(libHandle));

            CheckResult(ret);
        }

        /// <inheritdoc />
        public void IniciarEtiqueta()
        {
            var method = etqBridge.GetMethod<ACBrETQHandle.ETQ_IniciarEtiqueta>();
            var ret = etqBridge.ExecuteMethod(() => method(libHandle));

            CheckResult(ret);
        }

        /// <inheritdoc />
        public void FinalizarEtiqueta(int aCopias = 1, int aAvancoEtq = 0)
        {
            var method = etqBridge.GetMethod<ACBrETQHandle.ETQ_FinalizarEtiqueta>();
            var ret = etqBridge.ExecuteMethod(() => method(libHandle, aCopias, aAvancoEtq));

            CheckResult(ret);
        }

        /// <inheritdoc />
        public void CarregarImagem(string eArquivoImagem, string eNomeImagem, bool flipped = true)
        {
            var method = etqBridge.GetMethod<ACBrETQHandle.ETQ_CarregarImagem>();
            var ret = etqBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eArquivoImagem), ToUTF8(eNomeImagem), flipped));

            CheckResult(ret);
        }

        /// <inheritdoc />
        public void Imprimir(int aCopias = 1, int aAvancoEtq = 0)
        {
            var method = etqBridge.GetMethod<ACBrETQHandle.ETQ_Imprimir>();
            var ret = etqBridge.ExecuteMethod(() => method(libHandle, aCopias, aAvancoEtq));

            CheckResult(ret);
        }

        /// <inheritdoc />
        public void ImprimirTexto(ETQOrientacao orientacao, int fonte, int multiplicadorH, int multiplicadorV,
            int vertical, int horizontal, string eTexto, int subFonte = 0, bool imprimirReverso = false)
        {
            var method = etqBridge.GetMethod<ACBrETQHandle.ETQ_ImprimirTexto>();
            var ret = etqBridge.ExecuteMethod(() => method(libHandle, (int)orientacao, fonte, multiplicadorH, multiplicadorV,
                vertical, horizontal, ToUTF8(eTexto), subFonte, imprimirReverso));

            CheckResult(ret);
        }

        /// <inheritdoc />
        public void ImprimirTexto(ETQOrientacao orientacao, string fonte, int multiplicadorH, int multiplicadorV,
            int vertical, int horizontal, string eTexto, int subFonte = 0, bool imprimirReverso = false)
        {
            var method = etqBridge.GetMethod<ACBrETQHandle.ETQ_ImprimirTextoStr>();
            var ret = etqBridge.ExecuteMethod(() => method(libHandle, (int)orientacao, ToUTF8(fonte), multiplicadorH, multiplicadorV,
                vertical, horizontal, ToUTF8(eTexto), subFonte, imprimirReverso));

            CheckResult(ret);
        }

        /// <inheritdoc />
        public void ImprimirBarras(ETQOrientacao orientacao, TipoCodBarra tipoBarras, int larguraBarraLarga, int larguraBarraFina,
            int vertical, int horizontal, string eTexto, int alturaCodBarras = 0,
            ETQBarraExibeCodigo exibeCodigo = ETQBarraExibeCodigo.becPadrao)
        {
            var method = etqBridge.GetMethod<ACBrETQHandle.ETQ_ImprimirBarras>();
            var ret = etqBridge.ExecuteMethod(() => method(libHandle, (int)orientacao, (int)tipoBarras, larguraBarraLarga, larguraBarraFina,
                vertical, horizontal, ToUTF8(eTexto), alturaCodBarras, (int)exibeCodigo));

            CheckResult(ret);
        }

        /// <inheritdoc />
        public void ImprimirLinha(int vertical, int horizontal, int largura, int altura)
        {
            var method = etqBridge.GetMethod<ACBrETQHandle.ETQ_ImprimirLinha>();
            var ret = etqBridge.ExecuteMethod(() => method(libHandle, vertical, horizontal, largura, altura));

            CheckResult(ret);
        }

        /// <inheritdoc />
        public void ImprimirCaixa(int vertical, int horizontal, int largura, int altura, int espessuraVertical,
            int espessuraHorizontal)
        {
            var method = etqBridge.GetMethod<ACBrETQHandle.ETQ_ImprimirCaixa>();
            var ret = etqBridge.ExecuteMethod(() => method(libHandle, vertical, horizontal, largura, altura, espessuraVertical, espessuraHorizontal));

            CheckResult(ret);
        }

        /// <inheritdoc />
        public void ImprimirImagem(int multiplicadorImagem, int vertical, int horizontal, string eNomeImagem)
        {
            var method = etqBridge.GetMethod<ACBrETQHandle.ETQ_ImprimirImagem>();
            var ret = etqBridge.ExecuteMethod(() => method(libHandle, multiplicadorImagem, vertical, horizontal, ToUTF8(eNomeImagem)));

            CheckResult(ret);
        }

        /// <inheritdoc />
        public void ImprimirQRCode(int vertical, int horizontal, string texto, int larguraModulo, int errorLevel, int tipo)
        {
            var method = etqBridge.GetMethod<ACBrETQHandle.ETQ_ImprimirQRCode>();
            var ret = etqBridge.ExecuteMethod(() => method(libHandle, vertical, horizontal, ToUTF8(texto), larguraModulo, errorLevel, tipo));

            CheckResult(ret);
        }

        #endregion Etiqueta

        #region Private Methods

        /// <inheritdoc />
        public override void Finalizar()
        {
            var finalizarLib = etqBridge.GetMethod<ACBrETQHandle.ETQ_Finalizar>();
            var codRet = etqBridge.ExecuteMethod(() => finalizarLib(libHandle));
            CheckResult(codRet);
            libHandle = IntPtr.Zero;
        }

        /// <inheritdoc />
        protected override string GetUltimoRetorno(int iniBufferLen = 0)
        {
            var bufferLen = iniBufferLen < 1 ? BUFFER_LEN : iniBufferLen;
            var buffer = new StringBuilder(bufferLen);
            var ultimoRetorno = etqBridge.GetMethod<ACBrETQHandle.ETQ_UltimoRetorno>();

            if (iniBufferLen < 1)
            {
                etqBridge.ExecuteMethod(() => ultimoRetorno(libHandle, buffer, ref bufferLen));
                if (bufferLen <= BUFFER_LEN) return FromUTF8(buffer);

                buffer.Capacity = bufferLen;
            }

            etqBridge.ExecuteMethod(() => ultimoRetorno(libHandle, buffer, ref bufferLen));
            return FromUTF8(buffer);
        }

        #endregion Private Methods

        /// <inheritdoc />
        public override string OpenSSLInfo()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = etqBridge.GetMethod<ACBrETQHandle.ETQ_OpenSSLInfo>();
            var ret = etqBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        protected void Dispose(bool disposing)
        {
            if (disposed) return;
            if (disposing)
            {
                Finalizar();
            }
            disposed = true;
        }

        /// <summary>
        /// Libera os recursos utilizados pela instância da classe <see cref="ACBrETQ"/>.
        /// </summary>
        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        #endregion Métodos
    }
}
