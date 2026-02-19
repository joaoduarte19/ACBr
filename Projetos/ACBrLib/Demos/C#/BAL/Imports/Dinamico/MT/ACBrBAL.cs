using System.Text;
using ACBrLib.Core;
using System;
using System.IO;

namespace ACBrLib.BAL
{
    public class ACBrBAL : ACBrLibBase, IACBrLibBAL
    {

        private readonly ACBrBALHandle acbrBALBridge;
        private bool disposed = false;
        private IntPtr libHandle = IntPtr.Zero; 
        #region Constructors

        public ACBrBAL(string eArqConfig = "", string eChaveCrypt = "") :base(eArqConfig, eChaveCrypt)
        {   
            acbrBALBridge = ACBrBALHandle.Instance;
            Inicializar(eArqConfig, eChaveCrypt);
            Config = new BALConfig(this);
        }

        public override void Inicializar(string eArqConfig = "", string eChaveCrypt = "")
        {
            var inicializarLib = acbrBALBridge.GetMethod<ACBrBALHandle.BAL_Inicializar>();
            var ret =acbrBALBridge.ExecuteMethod<int>(() => inicializarLib(ref libHandle, ToUTF8(eArqConfig), ToUTF8(eChaveCrypt)));
            CheckResult(ret);
        }

        #endregion Constructors

        #region Properties

      

        public BALConfig Config { get; }

        #endregion Properties

        #region Methods

        #region Ini

        public override void ConfigGravar(string eArqConfig = "")
        {
            var gravarIni = acbrBALBridge.GetMethod<ACBrBALHandle.BAL_ConfigGravar>();
            var ret =acbrBALBridge.ExecuteMethod(() => gravarIni(libHandle, ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        public override void ConfigLer(string eArqConfig = "")
        {
            var lerIni = acbrBALBridge.GetMethod<ACBrBALHandle.BAL_ConfigLer>();
            var ret =acbrBALBridge.ExecuteMethod(() => lerIni(libHandle, ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        public override void ImportarConfig(string eArqConfig = "")
        {
            var importarConfig = acbrBALBridge.GetMethod<ACBrBALHandle.BAL_ConfigImportar>();
            var ret =acbrBALBridge.ExecuteMethod(() => importarConfig(libHandle, ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        public override string ExportarConfig()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrBALBridge.GetMethod<ACBrBALHandle.BAL_ConfigExportar>();
            var ret =acbrBALBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        #endregion Ini

        public void Ativar()
        {
            var method = acbrBALBridge.GetMethod<ACBrBALHandle.BAL_Ativar>();
            var ret =acbrBALBridge.ExecuteMethod(() => method(libHandle));

            CheckResult(ret);
        }

        public void Desativar()
        {
            var method = acbrBALBridge.GetMethod<ACBrBALHandle.BAL_Desativar>();
            var ret =acbrBALBridge.ExecuteMethod(() => method(libHandle));

            CheckResult(ret);
        }

        public decimal LePeso(int MillisecTimeOut = 1000)
        {
            var peso = 0D;
            var method = acbrBALBridge.GetMethod<ACBrBALHandle.BAL_LePeso>();
            var ret =acbrBALBridge.ExecuteMethod(() => method(libHandle, MillisecTimeOut, ref peso));

            CheckResult(ret);

            return (decimal)peso;
        }

        public void SolicitarPeso()
        {
            var method = acbrBALBridge.GetMethod<ACBrBALHandle.BAL_SolicitarPeso>();
            var ret =acbrBALBridge.ExecuteMethod(() => method(libHandle));

            CheckResult(ret);
        }

        public decimal UltimoPesoLido()
        {
            var peso = 0D;
            var method = acbrBALBridge.GetMethod<ACBrBALHandle.BAL_UltimoPesoLido>();
            var ret =acbrBALBridge.ExecuteMethod(() => method(libHandle, ref peso));

            CheckResult(ret);

            return (decimal)peso;
        }

        public decimal InterpretarRespostaPeso(string resposta)
        {
            var peso = 0D;
            var method = acbrBALBridge.GetMethod<ACBrBALHandle.BAL_InterpretarRespostaPeso>();
            var ret =acbrBALBridge.ExecuteMethod(() => method(libHandle, ToUTF8(resposta), ref peso));

            CheckResult(ret);

            return (decimal)peso;
        }

        #region Private Methods

        public override void Finalizar()
        {
            var finalizarLib = acbrBALBridge.GetMethod<ACBrBALHandle.BAL_Finalizar>();
            var ret =acbrBALBridge.ExecuteMethod(() => finalizarLib(libHandle));
            CheckResult(ret);
            libHandle = IntPtr.Zero;
        }

        protected override string GetUltimoRetorno(int iniBufferLen = 0)
        {
            var bufferLen = iniBufferLen < 1 ? BUFFER_LEN : iniBufferLen;
            var buffer = new StringBuilder(bufferLen);
            var ultimoRetorno = acbrBALBridge.GetMethod<ACBrBALHandle.BAL_UltimoRetorno>();

            if (iniBufferLen < 1)
            {
               acbrBALBridge.ExecuteMethod(() => ultimoRetorno(libHandle, buffer, ref bufferLen));
                if (bufferLen <= BUFFER_LEN) return FromUTF8(buffer);

                buffer.Capacity = bufferLen;
            }

           acbrBALBridge.ExecuteMethod(() => ultimoRetorno(libHandle, buffer, ref bufferLen));
            return FromUTF8(buffer);
        }

        #endregion Private Methods


        public override string OpenSSLInfo()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrBALBridge.GetMethod<ACBrBALHandle.BAL_OpenSSLInfo>();
            var ret =acbrBALBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        public override string ConfigLerValor(string eSessao, string eChave)
        {
            var method = acbrBALBridge.GetMethod<ACBrBALHandle.BAL_ConfigLerValor>();

            var bufferLen = BUFFER_LEN;
            var pValue = new StringBuilder(bufferLen);
            var ret = acbrBALBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eSessao), ToUTF8(eChave), pValue, ref bufferLen));
            CheckResult(ret);

            return CheckBuffer(pValue, bufferLen);
        }

        public override void ConfigGravarValor(string eSessao, string eChave, string eValor)
        {
            var method = acbrBALBridge.GetMethod<ACBrBALHandle.BAL_ConfigGravarValor>();
            var ret = acbrBALBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eSessao.ToString()), ToUTF8(eChave), ToUTF8(eValor)));
            CheckResult(ret);
        }

        public override string Versao()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrBALBridge.GetMethod<ACBrBALHandle.BAL_Versao>();
            var ret = acbrBALBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        public override string Nome()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrBALBridge.GetMethod<ACBrBALHandle.BAL_Nome>();
            var ret = acbrBALBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        protected void Dispose(bool disposing)
        {
            if (disposed) return;
            if (disposing)
            {
               Finalizar();
            }
            disposed = true;
        }


        #endregion Methods
    }
}