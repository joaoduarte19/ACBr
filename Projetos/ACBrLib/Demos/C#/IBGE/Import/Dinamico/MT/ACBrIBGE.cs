using System;
using System.Globalization;
using System.IO.Pipes;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using ACBrLib.Core;
using ACBrLib.Core.IBGE;
using ACBrLib.IBGE;

namespace ACBrLib.IBGE
{
    /// <inheritdoc />
    public class ACBrIBGE : ACBrLibBase, IACBrLibIBGE
    {
        private IntPtr libHandle = IntPtr.Zero;
        private bool disposed = false;

        private ACBrIBGEHandle acbrlibIBGEBridge;



        #region Constructors

        /// <summary>
        /// Construtor da classe ACBrIBGE, responsável por inicializar a biblioteca e configurar o caminho do arquivo de configuração e a chave de criptografia, se fornecidos.
        /// </summary>
        /// <param name="eArqConfig">Caminho do arquivo de configuração INI. Se vazio, utiliza o padrão da biblioteca.</param>
        /// <param name="eChaveCrypt">Chave de criptografia para o arquivo de configuração. Se vazio, utiliza o padrão da biblioteca.</param>
        ///     


        public ACBrIBGE(string eArqConfig = "", string eChaveCrypt = "") : base(eArqConfig, eChaveCrypt)
        {
            acbrlibIBGEBridge = ACBrIBGEHandle.Instance;
            Inicializar(eArqConfig, eChaveCrypt);
            Config = new ACBrIBGEConfig(this);
        }

        /// <inheritdoc/>
        public override void Inicializar(string eArqConfig = "", string eChaveCrypt = "")
        {
            var inicializarLib = acbrlibIBGEBridge.GetMethod<ACBrIBGEHandle.IBGE_Inicializar>();
            var ret = acbrlibIBGEBridge.ExecuteMethod<int>(() => inicializarLib(ref libHandle, ToUTF8(eArqConfig), ToUTF8(eChaveCrypt)));
            CheckResult(ret);
        }

        #endregion Constructors

        #region Properties

        /// <inheritdoc/>
        public override string Nome()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrlibIBGEBridge.GetMethod<ACBrIBGEHandle.IBGE_Nome>();
            var ret = acbrlibIBGEBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);

        }

        /// <inheritdoc/>
        public override string Versao()
        {

            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrlibIBGEBridge.GetMethod<ACBrIBGEHandle.IBGE_Versao>();
            var ret = acbrlibIBGEBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);

        }

        /// <inheritdoc/>
        public ACBrIBGEConfig Config { get; }

        #endregion Properties

        #region Metodos

        #region Ini

        /// <inheritdoc/>
        public override void ConfigGravar(string eArqConfig = "")
        {
            var gravarIni = acbrlibIBGEBridge.GetMethod<ACBrIBGEHandle.IBGE_ConfigGravar>();
            var ret = acbrlibIBGEBridge.ExecuteMethod(() => gravarIni(libHandle, ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public override void ImportarConfig(string eArqConfig)
        {
            var lerIni = acbrlibIBGEBridge.GetMethod<ACBrIBGEHandle.IBGE_ConfigImportar>();
            var ret = acbrlibIBGEBridge.ExecuteMethod(() => lerIni(libHandle, ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public override string ExportarConfig()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrlibIBGEBridge.GetMethod<ACBrIBGEHandle.IBGE_ConfigExportar>();
            var ret = acbrlibIBGEBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc/>
        public override void ConfigLer(string eArqConfig = "")
        {
            var lerIni = acbrlibIBGEBridge.GetMethod<ACBrIBGEHandle.IBGE_ConfigLer>();
            var ret = acbrlibIBGEBridge.ExecuteMethod(() => lerIni(libHandle, ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public override string ConfigLerValor(string eSessao, string eChave)
        {
            var method = acbrlibIBGEBridge.GetMethod<ACBrIBGEHandle.IBGE_ConfigLerValor>();

            var bufferLen = BUFFER_LEN;
            var pValue = new StringBuilder(bufferLen);
            var ret = acbrlibIBGEBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eSessao.ToString()), ToUTF8(eChave), pValue, ref bufferLen));
            CheckResult(ret);

            return CheckBuffer(pValue, bufferLen);

        }

        /// <inheritdoc/>
        public override void ConfigGravarValor(string eSessao, string eChave, string eValor)
        {
            var method = acbrlibIBGEBridge.GetMethod<ACBrIBGEHandle.IBGE_ConfigGravarValor>();
            var ret = acbrlibIBGEBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eSessao.ToString()), ToUTF8(eChave), ToUTF8(eValor)));
            CheckResult(ret);
        }

        #endregion Ini

        #region Diversos

        /// <inheritdoc/>
        public string buscarPorCodigo(int ACodMun)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrlibIBGEBridge.GetMethod<ACBrIBGEHandle.IBGE_BuscarPorCodigo>();
            var ret = acbrlibIBGEBridge.ExecuteMethod(() => method(libHandle, ACodMun, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc/>
        public string buscarPorNome(string eCidade, string eUF, bool exata)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrlibIBGEBridge.GetMethod<ACBrIBGEHandle.IBGE_BuscarPorNome>();
            var ret = acbrlibIBGEBridge.ExecuteMethod(() => method(libHandle, (ToUTF8(eCidade)), (ToUTF8(eUF)), false, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        #endregion Diversos

        #region Private Methods

        /// <inheritdoc/>
        public override void Finalizar()
        {
            var finalizarLib = acbrlibIBGEBridge.GetMethod<ACBrIBGEHandle.IBGE_Finalizar>();
            var codRet = acbrlibIBGEBridge.ExecuteMethod(() => finalizarLib(libHandle));
            libHandle = IntPtr.Zero;
            CheckResult(codRet);
        }

        /// <inheritdoc/>
        protected override string GetUltimoRetorno(int iniBufferLen = 0)
        {
            var bufferLen = iniBufferLen < 1 ? BUFFER_LEN : iniBufferLen;
            var buffer = new StringBuilder(bufferLen);
            var ultimoRetorno = acbrlibIBGEBridge.GetMethod<ACBrIBGEHandle.IBGE_UltimoRetorno>();

            if (iniBufferLen < 1)
            {
                acbrlibIBGEBridge.ExecuteMethod(() => ultimoRetorno(libHandle, buffer, ref bufferLen));
                if (bufferLen <= BUFFER_LEN) return FromUTF8(buffer);

                buffer.Capacity = bufferLen;
            }

            acbrlibIBGEBridge.ExecuteMethod(() => ultimoRetorno(libHandle, buffer, ref bufferLen));
            return FromUTF8(buffer);
        }

        /// <inheritdoc/>
        public override string OpenSSLInfo()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrlibIBGEBridge.GetMethod<ACBrIBGEHandle.IBGE_OpenSSLInfo>();
            var ret = acbrlibIBGEBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        #endregion Private Methods

        /// <inheritdoc/>
        protected void Dispose(bool disposing)
        {
            if (disposed) return;

            if (disposing)
            {
                Finalizar(); // Libera recursos gerenciados
            }

            disposed = true;

        }
        /// <inheritdoc/>
        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        #endregion Metodos
    }
}