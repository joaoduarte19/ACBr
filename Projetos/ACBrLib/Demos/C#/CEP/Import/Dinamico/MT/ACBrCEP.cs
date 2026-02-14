using System;
using System.Linq;
using System.Text;
using ACBrLib.Core;

namespace ACBrLib.CEP
{
    /// <inheritdoc />
    public class ACBrCEP : ACBrLibBase, IDisposable
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

        public override void Inicializar(string eArqConfig = "", string eChaveCrypt = "")
        {
            var inicializarLib = acbrCepBridge.GetMethod<ACBrCEPHandle.CEP_Inicializar>();
            var ret = acbrCepBridge.ExecuteMethod<int>(() => inicializarLib(ref libHandle, ToUTF8(eArqConfig), ToUTF8(eChaveCrypt)));
            CheckResult(ret);
        }

        #endregion Constructors

        public override string Nome()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrCepBridge.GetMethod<ACBrCEPHandle.CEP_Nome>();
            var ret = acbrCepBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

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

        public override void ConfigGravar(string eArqConfig = "")
        {
            var gravarIni = acbrCepBridge.GetMethod<ACBrCEPHandle.CEP_ConfigGravar>();
            var ret = acbrCepBridge.ExecuteMethod(() => gravarIni(libHandle, ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        public override void ImportarConfig(string eArqConfig)
        {
            var lerIni = acbrCepBridge.GetMethod<ACBrCEPHandle.CEP_ConfigImportar>();
            var ret = acbrCepBridge.ExecuteMethod(() => lerIni(libHandle, ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        public override string ExportarConfig()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrCepBridge.GetMethod<ACBrCEPHandle.CEP_ConfigExportar>();
            var ret = acbrCepBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        public override void ConfigLer(string eArqConfig = "")
        {
            var lerIni = acbrCepBridge.GetMethod<ACBrCEPHandle.CEP_ConfigLer>();
            var ret = acbrCepBridge.ExecuteMethod(() => lerIni(libHandle, ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        public override T ConfigLerValor<T>(ACBrSessao eSessao, string eChave)
        {
            var method = acbrCepBridge.GetMethod<ACBrCEPHandle.CEP_ConfigLerValor>();

            var bufferLen = BUFFER_LEN;
            var pValue = new StringBuilder(bufferLen);
            var ret = acbrCepBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eSessao.ToString()), ToUTF8(eChave), pValue, ref bufferLen));
            CheckResult(ret);

            var value = CheckBuffer(pValue, bufferLen);
            return ConvertValue<T>(value);
        }

        public override void ConfigGravarValor(ACBrSessao eSessao, string eChave, object value)
        {
            if (value == null) return;

            var method = acbrCepBridge.GetMethod<ACBrCEPHandle.CEP_ConfigGravarValor>();
            var propValue = ConvertValue(value);

            var ret = acbrCepBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eSessao.ToString()), ToUTF8(eChave), ToUTF8(propValue)));
            CheckResult(ret);
        }

        #endregion Ini

        #region Diversos

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

        public override void Finalizar()
        {
            var finalizarLib = acbrCepBridge.GetMethod<ACBrCEPHandle.CEP_Finalizar>();
            var codRet = acbrCepBridge.ExecuteMethod(() => finalizarLib(libHandle));
            CheckResult(codRet);
            libHandle = IntPtr.Zero;
        }

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

        public override string OpenSSLInfo()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrCepBridge.GetMethod<ACBrCEPHandle.CEP_OpenSSLInfo>();
            var ret = acbrCepBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        public override string ConfigLerValor(string eSessao, string eChave)
        {
            throw new NotImplementedException();
        }

        public override void ConfigGravarValor(string eSessao, string eChave, string eValor)
        {
            throw new NotImplementedException();
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