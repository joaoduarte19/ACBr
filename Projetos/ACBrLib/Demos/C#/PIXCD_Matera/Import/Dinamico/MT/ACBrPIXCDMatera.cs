using System;
using System.Text;
using ACBrLib.Core;

namespace ACBrLib.PIXCD
{
    /// <summary>
    /// Classe principal para interação com a biblioteca ACBrLib PIXCD Matera.
    /// Implementa a interface <see cref="IACBrLibPIXCDMatera"/>.
    /// </summary>
    public class ACBrPIXCD : ACBrLibBase, IACBrLibPIXCDMatera
    {
        #region Fields

        private IntPtr libHandle = IntPtr.Zero;
        private bool disposed;
        private readonly ACBrPIXCDHandle pixcdBridge;

        #endregion Fields

        #region Constructors

        /// <summary>
        /// Cria uma instância da biblioteca ACBrLib PIXCD Matera.
        /// </summary>
        /// <param name="eArqConfig">Caminho e nome do arquivo de configuração da biblioteca.</param>
        /// <param name="eChaveCrypt">Chave de criptografia para proteção de dados sensíveis.</param>
        public ACBrPIXCD(string eArqConfig = "", string eChaveCrypt = "") : base(eArqConfig, eChaveCrypt)
        {
            pixcdBridge = ACBrPIXCDHandle.Instance;
            Inicializar(eArqConfig, eChaveCrypt);
            Config = new ACBrPIXCDConfig(this);
        }

        /// <inheritdoc />
        public override void Inicializar(string eArqConfig = "", string eChaveCrypt = "")
        {
            var inicializar = pixcdBridge.GetMethod<ACBrPIXCDHandle.PIXCD_Inicializar>();
            var ret = pixcdBridge.ExecuteMethod<int>(() => inicializar(ref libHandle, ToUTF8(eArqConfig), ToUTF8(eChaveCrypt)));
            CheckResult(ret);
        }

        #endregion Constructors

        #region Properties

        /// <inheritdoc />
        public override string Nome()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = pixcdBridge.GetMethod<ACBrPIXCDHandle.PIXCD_Nome>();
            var ret = pixcdBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public override string Versao()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = pixcdBridge.GetMethod<ACBrPIXCDHandle.PIXCD_Versao>();
            var ret = pixcdBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public ACBrPIXCDConfig Config { get; }

        #endregion Properties

        #region Metodos

        #region Ini

        /// <inheritdoc />
        public override void ConfigGravar(string eArqConfig = "")
        {
            var gravarIni = pixcdBridge.GetMethod<ACBrPIXCDHandle.PIXCD_ConfigGravar>();
            var ret = pixcdBridge.ExecuteMethod(() => gravarIni(libHandle, ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        /// <inheritdoc />
        public override void ImportarConfig(string eArqConfig)
        {
            var lerIni = pixcdBridge.GetMethod<ACBrPIXCDHandle.PIXCD_ConfigImportar>();
            var ret = pixcdBridge.ExecuteMethod(() => lerIni(libHandle, ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        /// <inheritdoc />
        public override string ExportarConfig()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = pixcdBridge.GetMethod<ACBrPIXCDHandle.PIXCD_ConfigExportar>();
            var ret = pixcdBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public override void ConfigLer(string eArqConfig = "")
        {
            var lerIni = pixcdBridge.GetMethod<ACBrPIXCDHandle.PIXCD_ConfigLer>();
            var ret = pixcdBridge.ExecuteMethod(() => lerIni(libHandle, ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        /// <inheritdoc />
        public override T ConfigLerValor<T>(ACBrSessao eSessao, string eChave)
        {
            var method = pixcdBridge.GetMethod<ACBrPIXCDHandle.PIXCD_ConfigLerValor>();

            var bufferLen = BUFFER_LEN;
            var pValue = new StringBuilder(bufferLen);
            var ret = pixcdBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eSessao.ToString()), ToUTF8(eChave), pValue, ref bufferLen));
            CheckResult(ret);

            var value = CheckBuffer(pValue, bufferLen);
            return ConvertValue<T>(value);
        }

        /// <inheritdoc />
        public override string ConfigLerValor(string eSessao, string eChave)
        {
            var method = pixcdBridge.GetMethod<ACBrPIXCDHandle.PIXCD_ConfigLerValor>();

            var bufferLen = BUFFER_LEN;
            var pValue = new StringBuilder(bufferLen);
            var ret = pixcdBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eSessao), ToUTF8(eChave), pValue, ref bufferLen));
            CheckResult(ret);

            return CheckBuffer(pValue, bufferLen);
        }

        /// <inheritdoc />
        public override void ConfigGravarValor(string eSessao, string eChave, string eValor)
        {
            var method = pixcdBridge.GetMethod<ACBrPIXCDHandle.PIXCD_ConfigGravarValor>();
            var ret = pixcdBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eSessao), ToUTF8(eChave), ToUTF8(eValor)));
            CheckResult(ret);
        }

        /// <inheritdoc />
        public override void ConfigGravarValor(ACBrSessao eSessao, string eChave, object value)
        {
            if (value == null) return;

            var propValue = ConvertValue(value);
            ConfigGravarValor(eSessao.ToString(), eChave, propValue);
        }

        #endregion Ini

        #region Diversos

        /// <inheritdoc />
        public override string OpenSSLInfo()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = pixcdBridge.GetMethod<ACBrPIXCDHandle.PIXCD_OpenSSLInfo>();
            var ret = pixcdBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public string IncluirConta(string aInfIncluirConta)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = pixcdBridge.GetMethod<ACBrPIXCDHandle.PIXCD_Matera_IncluirConta>();
            var ret = pixcdBridge.ExecuteMethod(() => method(libHandle, ToUTF8(aInfIncluirConta), buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public string ConsultarConta(string aAccountId)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = pixcdBridge.GetMethod<ACBrPIXCDHandle.PIXCD_Matera_ConsultarConta>();
            var ret = pixcdBridge.ExecuteMethod(() => method(libHandle, ToUTF8(aAccountId), buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public string InativarConta(string aAccountId)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = pixcdBridge.GetMethod<ACBrPIXCDHandle.PIXCD_Matera_InativarConta>();
            var ret = pixcdBridge.ExecuteMethod(() => method(libHandle, ToUTF8(aAccountId), buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public string IncluirChavePix(string aAccountId, string aExternalID)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = pixcdBridge.GetMethod<ACBrPIXCDHandle.PIXCD_Matera_IncluirChavePix>();
            var ret = pixcdBridge.ExecuteMethod(() => method(libHandle, ToUTF8(aAccountId), ToUTF8(aExternalID), buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public string ConsultarChavePix(string aAccountId)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = pixcdBridge.GetMethod<ACBrPIXCDHandle.PIXCD_Matera_ConsultarChavePix>();
            var ret = pixcdBridge.ExecuteMethod(() => method(libHandle, ToUTF8(aAccountId), buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public string ExcluirChavePix(string aAccountId, string aChavePIX)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = pixcdBridge.GetMethod<ACBrPIXCDHandle.PIXCD_Matera_ExcluirChavePix>();
            var ret = pixcdBridge.ExecuteMethod(() => method(libHandle, ToUTF8(aAccountId), ToUTF8(aChavePIX), buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public string GerarQRCode(string aInfQRCode)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = pixcdBridge.GetMethod<ACBrPIXCDHandle.PIXCD_Matera_GerarQRCode>();
            var ret = pixcdBridge.ExecuteMethod(() => method(libHandle, ToUTF8(aInfQRCode), buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public string ConsultarTransacao(string aAccountId, string aTransactionID)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = pixcdBridge.GetMethod<ACBrPIXCDHandle.PIXCD_Matera_ConsultarTransacao>();
            var ret = pixcdBridge.ExecuteMethod(() => method(libHandle, ToUTF8(aAccountId), ToUTF8(aTransactionID), buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public string ConsultarSaldoEC(string aAccountId)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = pixcdBridge.GetMethod<ACBrPIXCDHandle.PIXCD_Matera_ConsultarSaldoEC>();
            var ret = pixcdBridge.ExecuteMethod(() => method(libHandle, ToUTF8(aAccountId), buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public string ConsultarExtratoEC(string aAccountId, DateTime aInicio, DateTime aFim)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = pixcdBridge.GetMethod<ACBrPIXCDHandle.PIXCD_Matera_ConsultarExtratoEC>();
            var ret = pixcdBridge.ExecuteMethod(() => method(libHandle, ToUTF8(aAccountId), aInicio, aFim, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public string ConsultarMotivosDevolucao()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = pixcdBridge.GetMethod<ACBrPIXCDHandle.PIXCD_Matera_ConsultarMotivosDevolucao>();
            var ret = pixcdBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public string SolicitarDevolucao(string aInfSolicitarDevolucao, string aAccountId, string aTransactionID)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = pixcdBridge.GetMethod<ACBrPIXCDHandle.PIXCD_Matera_SolicitarDevolucao>();
            var ret = pixcdBridge.ExecuteMethod(() => method(libHandle, ToUTF8(aInfSolicitarDevolucao), ToUTF8(aAccountId), ToUTF8(aTransactionID), buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public string ConsultarAliasRetirada(string aAccountId, string aAlias)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = pixcdBridge.GetMethod<ACBrPIXCDHandle.PIXCD_Matera_ConsultarAliasRetirada>();
            var ret = pixcdBridge.ExecuteMethod(() => method(libHandle, ToUTF8(aAccountId), ToUTF8(aAlias), buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public string SolicitarRetirada(string aInfSolicitarRetirada, string aAccountId)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = pixcdBridge.GetMethod<ACBrPIXCDHandle.PIXCD_Matera_SolicitarRetirada>();
            var ret = pixcdBridge.ExecuteMethod(() => method(libHandle, ToUTF8(aInfSolicitarRetirada), ToUTF8(aAccountId), buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        #endregion Diversos

        #region Private Methods

        /// <inheritdoc />
        public override void Finalizar()
        {
            var finalizarLib = pixcdBridge.GetMethod<ACBrPIXCDHandle.PIXCD_Finalizar>();
            var codRet = pixcdBridge.ExecuteMethod(() => finalizarLib(libHandle));
            CheckResult(codRet);
            libHandle = IntPtr.Zero;
        }

        /// <inheritdoc />
        protected override string GetUltimoRetorno(int iniBufferLen = 0)
        {
            var bufferLen = iniBufferLen < 1 ? BUFFER_LEN : iniBufferLen;
            var buffer = new StringBuilder(bufferLen);
            var ultimoRetorno = pixcdBridge.GetMethod<ACBrPIXCDHandle.PIXCD_UltimoRetorno>();

            if (iniBufferLen < 1)
            {
                pixcdBridge.ExecuteMethod(() => ultimoRetorno(libHandle, buffer, ref bufferLen));
                if (bufferLen <= BUFFER_LEN) return FromUTF8(buffer);

                buffer.Capacity = bufferLen;
            }

            pixcdBridge.ExecuteMethod(() => ultimoRetorno(libHandle, buffer, ref bufferLen));
            return FromUTF8(buffer);
        }

        #endregion Private Methods

        #endregion Metodos

        #region IDisposable
        
        /// <summary>
        /// Libera os recursos utilizados pela classe ACBrPIXCDMatera.
        /// </summary>
        /// <param name="disposing">Indica se o método foi chamado pelo usuário ou pelo garbage collector.</param>
        protected virtual void Dispose(bool disposing)
        {
            if (disposed) return;

            if (disposing)
            {
                Finalizar();
            }

            disposed = true;
        }

        /// <inheritdoc />
        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        #endregion IDisposable
    }
}
