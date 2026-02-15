using System;
using System.Linq;
using System.Text;
using ACBrLib.Core;

namespace ACBrLib.CEP
{
    /// <inheritdoc />
    public class ACBrCEP : ACBrLibBase, IACBrLibCEP, IDisposable
    {
        #region Constructors

        private readonly ACBrCEPHandle acbrCepBridge;
        private IntPtr libHandle = IntPtr.Zero;
        private bool disposed = false;

        public ACBrCEP(string eArqConfig = "", string eChaveCrypt = "") : base(eArqConfig, eChaveCrypt)
        {

            acbrCepBridge = ACBrCEPHandle.Instance;
            Inicializar(eArqConfig, eChaveCrypt);
            Config = new ACBrCEPConfig(this);
        }


        /// <inheritdoc/>
        public override void Inicializar(string eArqConfig = "", string eChaveCrypt = "")
        {
            var inicializarLib = acbrCepBridge.GetMethod<ACBrCEPHandle.CEP_Inicializar>();
            var ret = acbrCepBridge.ExecuteMethod<int>(() => inicializarLib(ref libHandle, ToUTF8(eArqConfig), ToUTF8(eChaveCrypt)));
            CheckResult(ret);
        }

        #endregion Constructors


        /// <inheritdoc/>
        public override string Nome()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrCepBridge.GetMethod<ACBrCEPHandle.CEP_Nome>();
            var ret = acbrCepBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }


        /// <inheritdoc/>
        public override string Versao()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrCepBridge.GetMethod<ACBrCEPHandle.CEP_Versao>();
            var ret = acbrCepBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        #region Properties
        public ACBrCEPConfig Config { get; }

        #endregion Properties

        #region Metodos

        #region Ini


        /// <inheritdoc/>
        public override void ConfigGravar(string eArqConfig = "")
        {
            var gravarIni = acbrCepBridge.GetMethod<ACBrCEPHandle.CEP_ConfigGravar>();
            var ret = acbrCepBridge.ExecuteMethod(() => gravarIni(libHandle, ToUTF8(eArqConfig)));

            CheckResult(ret);
        }


        /// <inheritdoc/>
        public override void ImportarConfig(string eArqConfig)
        {
            var lerIni = acbrCepBridge.GetMethod<ACBrCEPHandle.CEP_ConfigImportar>();
            var ret = acbrCepBridge.ExecuteMethod(() => lerIni(libHandle, ToUTF8(eArqConfig)));

            CheckResult(ret);
        }


        /// <inheritdoc/>
        public override string ExportarConfig()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrCepBridge.GetMethod<ACBrCEPHandle.CEP_ConfigExportar>();
            var ret = acbrCepBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc/>
        public override void ConfigLer(string eArqConfig = "")
        {
            var lerIni = acbrCepBridge.GetMethod<ACBrCEPHandle.CEP_ConfigLer>();
            var ret = acbrCepBridge.ExecuteMethod(() => lerIni(libHandle, ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public override T ConfigLerValor<T>(ACBrSessao eSessao, string eChave)
        {
            var value = ConfigLerValor(eSessao.ToString(), eChave);
            return ConvertValue<T>(value);
        }

        /// <inheritdoc/>
        public override void ConfigGravarValor(ACBrSessao eSessao, string eChave, object value)
        {
            if (value == null) return;

            var propValue = ConvertValue(value);
            ConfigGravarValor(eSessao.ToString(), eChave, propValue);
        }

        #endregion Ini

        #region Diversos

        /// <inheritdoc/>
        public ACBrEndereco BuscarPorCep(string eCEP)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrCepBridge.GetMethod<ACBrCEPHandle.CEP_BuscarPorCEP>();
            var ret = acbrCepBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eCEP), buffer, ref bufferLen));

            CheckResult(ret);

            var ini = ACBrIniFile.Parse(CheckBuffer(buffer, bufferLen));
            return ini.Where(x => x.Name.StartsWith("Endereco")).Select(ACBrEndereco.LerResposta).SingleOrDefault();
        }

        /// <inheritdoc/>
        public ACBrEndereco[] BuscarPorLogradouro(string eCidade, string eTipoLogradouro, string eLogradouro, string eUF, string eBairro)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrCepBridge.GetMethod<ACBrCEPHandle.CEP_BuscarPorLogradouro>();
            var ret = acbrCepBridge.ExecuteMethod(() => method(libHandle, (ToUTF8(eCidade)), (ToUTF8(eTipoLogradouro)), (ToUTF8(eLogradouro)), (ToUTF8(eUF)), (ToUTF8(eUF)), buffer, ref bufferLen));

            CheckResult(ret);

            var ini = ACBrIniFile.Parse(CheckBuffer(buffer, bufferLen));
            return ini.Where(x => x.Name.StartsWith("Endereco")).Select(ACBrEndereco.LerResposta).ToArray();
        }

        #endregion Diversos

        #region Private Methods


        /// <inheritdoc/>
        public override void Finalizar()
        {
            var finalizarLib = acbrCepBridge.GetMethod<ACBrCEPHandle.CEP_Finalizar>();
            var codRet = acbrCepBridge.ExecuteMethod(() => finalizarLib(libHandle));
            CheckResult(codRet);
            libHandle = IntPtr.Zero;
        }


        /// <inheritdoc/>
        protected override string GetUltimoRetorno(int iniBufferLen = 0)
        {
            var bufferLen = iniBufferLen < 1 ? BUFFER_LEN : iniBufferLen;
            var buffer = new StringBuilder(bufferLen);
            var ultimoRetorno = acbrCepBridge.GetMethod<ACBrCEPHandle.CEP_UltimoRetorno>();

            if (iniBufferLen < 1)
            {
                acbrCepBridge.ExecuteMethod(() => ultimoRetorno(libHandle, buffer, ref bufferLen));
                if (bufferLen <= BUFFER_LEN) return FromUTF8(buffer);

                buffer.Capacity = bufferLen;
            }

            acbrCepBridge.ExecuteMethod(() => ultimoRetorno(libHandle, buffer, ref bufferLen));
            return FromUTF8(buffer);
        }

        #endregion Private Methods


        /// <inheritdoc/>
        public override string OpenSSLInfo()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrCepBridge.GetMethod<ACBrCEPHandle.CEP_OpenSSLInfo>();
            var ret = acbrCepBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }
        
        /// <inheritdoc/>
        public override string ConfigLerValor(string eSessao, string eChave)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);
            var method = acbrCepBridge.GetMethod<ACBrCEPHandle.CEP_ConfigLerValor>();
            var ret = acbrCepBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eSessao), ToUTF8(eChave), buffer, ref bufferLen));
            CheckResult(ret);
            return CheckBuffer(buffer, bufferLen);
        }


        /// <inheritdoc/>
        public override void ConfigGravarValor(string eSessao, string eChave, string eValor)
        {
            var method = acbrCepBridge.GetMethod<ACBrCEPHandle.CEP_ConfigGravarValor>();
            var ret = acbrCepBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eSessao), ToUTF8(eChave), ToUTF8(eValor)));
            CheckResult(ret);

        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        protected virtual void Dispose(bool disposing)
        {
            if (!disposed)
            {
                if (disposing)
                {
                    Finalizar();
                }
                disposed = true;
            }
        }
        #endregion Metodos
    }
}