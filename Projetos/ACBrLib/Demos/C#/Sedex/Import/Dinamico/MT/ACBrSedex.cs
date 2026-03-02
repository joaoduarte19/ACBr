using System;
using System.Text;
using ACBrLib.Core;

namespace ACBrLib.Sedex
{
    /// <inheritdoc />
    public class ACBrSedex : ACBrLibBase, IACBrLibSedex
    {
        #region Fields

        private IntPtr libHandle = IntPtr.Zero;
        private bool disposed;
        private readonly ACBrSedexHandle sedexBridge;

        #endregion Fields

        #region Constructors

        /// <inheritdoc />
        public ACBrSedex(string eArqConfig = "", string eChaveCrypt = "") : base(eArqConfig, eChaveCrypt)
        {
            sedexBridge = ACBrSedexHandle.Instance;
            Inicializar(eArqConfig, eChaveCrypt);
            Config = new ACBrSedexConfig(this);
        }

        /// <inheritdoc />
        public override void Inicializar(string eArqConfig = "", string eChaveCrypt = "")
        {
            var inicializar = sedexBridge.GetMethod<ACBrSedexHandle.Sedex_Inicializar>();
            var ret = sedexBridge.ExecuteMethod<int>(() => inicializar(ref libHandle, ToUTF8(eArqConfig), ToUTF8(eChaveCrypt)));
            CheckResult(ret);
        }

        #endregion Constructors

        #region Properties

        /// <inheritdoc />
        public override string Nome()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = sedexBridge.GetMethod<ACBrSedexHandle.Sedex_Nome>();
            var ret = sedexBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public override string Versao()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = sedexBridge.GetMethod<ACBrSedexHandle.Sedex_Versao>();
            var ret = sedexBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public ACBrSedexConfig Config { get; }

        #endregion Properties

        #region Metodos

        #region Ini

        /// <inheritdoc />
        public override void ConfigGravar(string eArqConfig = "")
        {
            var gravarIni = sedexBridge.GetMethod<ACBrSedexHandle.Sedex_ConfigGravar>();
            var ret = sedexBridge.ExecuteMethod(() => gravarIni(libHandle, ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        /// <inheritdoc />
        public override void ImportarConfig(string eArqConfig)
        {
            var lerIni = sedexBridge.GetMethod<ACBrSedexHandle.Sedex_ConfigImportar>();
            var ret = sedexBridge.ExecuteMethod(() => lerIni(libHandle, ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        /// <inheritdoc />
        public override string ExportarConfig()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = sedexBridge.GetMethod<ACBrSedexHandle.Sedex_ConfigExportar>();
            var ret = sedexBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public override void ConfigLer(string eArqConfig = "")
        {
            var lerIni = sedexBridge.GetMethod<ACBrSedexHandle.Sedex_ConfigLer>();
            var ret = sedexBridge.ExecuteMethod(() => lerIni(libHandle, ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        /// <inheritdoc />
        public override string ConfigLerValor(string eSessao, string eChave)
        {
            var method = sedexBridge.GetMethod<ACBrSedexHandle.Sedex_ConfigLerValor>();

            var bufferLen = BUFFER_LEN;
            var pValue = new StringBuilder(bufferLen);
            var ret = sedexBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eSessao), ToUTF8(eChave), pValue, ref bufferLen));
            CheckResult(ret);

            return CheckBuffer(pValue, bufferLen);
        }

        /// <inheritdoc />
        public override void ConfigGravarValor(string eSessao, string eChave, string eValor)
        {
            var method = sedexBridge.GetMethod<ACBrSedexHandle.Sedex_ConfigGravarValor>();
            var ret = sedexBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eSessao), ToUTF8(eChave), ToUTF8(eValor)));
            CheckResult(ret);
        }

        #endregion Ini

        #region Diversos

        /// <inheritdoc />
        public override string OpenSSLInfo()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = sedexBridge.GetMethod<ACBrSedexHandle.Sedex_OpenSSLInfo>();
            var ret = sedexBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public string Consultar()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = sedexBridge.GetMethod<ACBrSedexHandle.Sedex_Consultar>();
            var ret = sedexBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public string Rastrear(string eCodRastreio)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = sedexBridge.GetMethod<ACBrSedexHandle.Sedex_Rastrear>();
            var ret = sedexBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eCodRastreio), buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        #endregion Diversos

        #region Private Methods

        /// <inheritdoc />
        public override void Finalizar()
        {
            var finalizarLib = sedexBridge.GetMethod<ACBrSedexHandle.Sedex_Finalizar>();
            var codRet = sedexBridge.ExecuteMethod(() => finalizarLib(libHandle));
            CheckResult(codRet);
            libHandle = IntPtr.Zero;
        }

        /// <inheritdoc />
        protected override string GetUltimoRetorno(int iniBufferLen = 0)
        {
            var bufferLen = iniBufferLen < 1 ? BUFFER_LEN : iniBufferLen;
            var buffer = new StringBuilder(bufferLen);
            var ultimoRetorno = sedexBridge.GetMethod<ACBrSedexHandle.Sedex_UltimoRetorno>();

            if (iniBufferLen < 1)
            {
                sedexBridge.ExecuteMethod(() => ultimoRetorno(libHandle, buffer, ref bufferLen));
                if (bufferLen <= BUFFER_LEN) return FromUTF8(buffer);

                buffer.Capacity = bufferLen;
            }

            sedexBridge.ExecuteMethod(() => ultimoRetorno(libHandle, buffer, ref bufferLen));
            return FromUTF8(buffer);
        }

        #endregion Private Methods

        #endregion Metodos

        #region IDisposable

        /// <summary>
        /// Libera recursos gerenciados e finaliza a biblioteca nativa.
        /// </summary>
        /// <param name="disposing">True para liberar recursos gerenciados; false apenas para finalizer.</param>
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
