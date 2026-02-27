using System;
using System.Text;
using ACBrLib.Core;

namespace ACBrLib.NCM
{
    /// <summary>
    /// Implementação de alto nível da biblioteca ACBrLib NCMs para uso em aplicações .NET (Multi-Thread).
    /// </summary>
    public class ACBrNCM : ACBrLibBase, IACBrLibNCM
    {
        #region Fields

        private IntPtr libHandle = IntPtr.Zero;
        private bool disposed;
        private ACBrNCMHandle ncmBridge;

        #endregion Fields

        #region Constructors

        /// <summary>
        /// Cria uma nova instância do componente ACBrNCM.
        /// </summary>
        public ACBrNCM(string eArqConfig = "", string eChaveCrypt = "") : base(eArqConfig, eChaveCrypt)
        {
            ncmBridge = ACBrNCMHandle.Instance;
            Inicializar(eArqConfig, eChaveCrypt);
            Config = new ACBrNCMConfig(this);
        }

        /// <inheritdoc />
        public override void Inicializar(string eArqConfig = "", string eChaveCrypt = "")
        {
            var inicializar = ncmBridge.GetMethod<ACBrNCMHandle.NCM_Inicializar>();
            var ret = ncmBridge.ExecuteMethod<int>(() => inicializar(ref libHandle, ToUTF8(eArqConfig), ToUTF8(eChaveCrypt)));
            CheckResult(ret);
        }

        #endregion Constructors

        #region Properties

        /// <inheritdoc />
        public override string Nome()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);
            var method = ncmBridge.GetMethod<ACBrNCMHandle.NCM_Nome>();
            var ret = ncmBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));
            CheckResult(ret);
            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public override string Versao()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);
            var method = ncmBridge.GetMethod<ACBrNCMHandle.NCM_Versao>();
            var ret = ncmBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));
            CheckResult(ret);
            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public ACBrNCMConfig Config { get; }

        #endregion Properties

        #region Config

        /// <inheritdoc />
        public override void ConfigGravar(string eArqConfig = "")
        {
            var method = ncmBridge.GetMethod<ACBrNCMHandle.NCM_ConfigGravar>();
            var ret = ncmBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eArqConfig)));
            CheckResult(ret);
        }

        /// <inheritdoc />
        public override void ImportarConfig(string eArqConfig)
        {
            var method = ncmBridge.GetMethod<ACBrNCMHandle.NCM_ConfigImportar>();
            var ret = ncmBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eArqConfig)));
            CheckResult(ret);
        }

        /// <inheritdoc />
        public override string ExportarConfig()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);
            var method = ncmBridge.GetMethod<ACBrNCMHandle.NCM_ConfigExportar>();
            var ret = ncmBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));
            CheckResult(ret);
            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public override void ConfigLer(string eArqConfig = "")
        {
            var method = ncmBridge.GetMethod<ACBrNCMHandle.NCM_ConfigLer>();
            var ret = ncmBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eArqConfig)));
            CheckResult(ret);
        }

        /// <inheritdoc />
        public override string ConfigLerValor(string eSessao, string eChave)
        {
            var bufferLen = BUFFER_LEN;
            var pValue = new StringBuilder(bufferLen);
            var method = ncmBridge.GetMethod<ACBrNCMHandle.NCM_ConfigLerValor>();
            var ret = ncmBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eSessao), ToUTF8(eChave), pValue, ref bufferLen));
            CheckResult(ret);
            return CheckBuffer(pValue, bufferLen);
        }

        /// <inheritdoc />
        public override void ConfigGravarValor(string eSessao, string eChave, string eValor)
        {
            var method = ncmBridge.GetMethod<ACBrNCMHandle.NCM_ConfigGravarValor>();
            var ret = ncmBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eSessao), ToUTF8(eChave), ToUTF8(eValor)));
            CheckResult(ret);
        }

        #endregion Config

        #region NCM

        /// <inheritdoc />
        public string DescricaoNCM(string cNCM)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);
            var method = ncmBridge.GetMethod<ACBrNCMHandle.NCM_DescricaoNCM>();
            var ret = ncmBridge.ExecuteMethod(() => method(libHandle, ToUTF8(cNCM), buffer, ref bufferLen));
            CheckResult(ret);
            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public string Validar(string cNCM)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);
            var method = ncmBridge.GetMethod<ACBrNCMHandle.NCM_Validar>();
            var ret = ncmBridge.ExecuteMethod(() => method(libHandle, ToUTF8(cNCM), buffer, ref bufferLen));
            CheckResult(ret);
            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public string BaixarLista(string cNomeArquivo)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);
            var method = ncmBridge.GetMethod<ACBrNCMHandle.NCM_BaixarLista>();
            var ret = ncmBridge.ExecuteMethod(() => method(libHandle, ToUTF8(cNomeArquivo), buffer, ref bufferLen));
            CheckResult(ret);
            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public string ObterNCMs()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);
            var method = ncmBridge.GetMethod<ACBrNCMHandle.NCM_ObterNCMs>();
            var ret = ncmBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));
            CheckResult(ret);
            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public string BuscarPorCodigo(string cNCM)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);
            var method = ncmBridge.GetMethod<ACBrNCMHandle.NCM_BuscarPorCodigo>();
            var ret = ncmBridge.ExecuteMethod(() => method(libHandle, ToUTF8(cNCM), buffer, ref bufferLen));
            CheckResult(ret);
            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public string BuscarPorDescricao(string cDesc, int nTipo)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);
            var method = ncmBridge.GetMethod<ACBrNCMHandle.NCM_BuscarPorDescricao>();
            var ret = ncmBridge.ExecuteMethod(() => method(libHandle, ToUTF8(cDesc), nTipo, buffer, ref bufferLen));
            CheckResult(ret);
            return CheckBuffer(buffer, bufferLen);
        }

        #endregion NCM

        #region Private

        /// <inheritdoc />
        public override void Finalizar()
        {
            var method = ncmBridge.GetMethod<ACBrNCMHandle.NCM_Finalizar>();
            var codRet = ncmBridge.ExecuteMethod(() => method(libHandle));
            CheckResult(codRet);
            libHandle = IntPtr.Zero;
        }

        /// <inheritdoc />
        protected override string GetUltimoRetorno(int iniBufferLen = 0)
        {
            var bufferLen = iniBufferLen < 1 ? BUFFER_LEN : iniBufferLen;
            var buffer = new StringBuilder(bufferLen);
            var ultimoRetorno = ncmBridge.GetMethod<ACBrNCMHandle.NCM_UltimoRetorno>();
            if (iniBufferLen < 1)
            {
                ncmBridge.ExecuteMethod(() => ultimoRetorno(libHandle, buffer, ref bufferLen));
                if (bufferLen <= BUFFER_LEN) return FromUTF8(buffer);
                buffer.Capacity = bufferLen;
            }
            ncmBridge.ExecuteMethod(() => ultimoRetorno(libHandle, buffer, ref bufferLen));
            return FromUTF8(buffer);
        }

        /// <inheritdoc />
        public override string OpenSSLInfo()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);
            var method = ncmBridge.GetMethod<ACBrNCMHandle.NCM_OpenSSLInfo>();
            var ret = ncmBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));
            CheckResult(ret);
            return CheckBuffer(buffer, bufferLen);
        }

        #endregion Private

        #region IDisposable

        /// <inheritdoc />
        protected void Dispose(bool disposing)
        {
            if (disposed) return;
            if (disposing) Finalizar();
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
