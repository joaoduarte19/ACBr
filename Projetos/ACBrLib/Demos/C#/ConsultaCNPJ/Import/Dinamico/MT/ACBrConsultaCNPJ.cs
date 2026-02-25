using System;
using System.Text;
using ACBrLib.Core;

namespace ACBrLib.ConsultaCNPJ
{

    /// <summary>
    /// ACBrConsultaCNPJ é uma classe que implementa a interface <see cref="IACBrLibConsultaCNPJ"/> e fornece métodos para consultar informações cadastrais de empresas a partir do CNPJ, utilizando a biblioteca ACBrLib.
    /// </summary>

    public class ACBrConsultaCNPJ : ACBrLibBase, IACBrLibConsultaCNPJ
    {

        #region Fields
        private IntPtr libHandle = IntPtr.Zero;
        private bool disposed = false;
        private ACBrConsultaCNPJHandle consultaCNPJBridge;

        #endregion Fields
        #region Constructors

        /// <summary>
        /// Inicializa uma nova instância da classe <see cref="ACBrConsultaCNPJ"/> para consulta de CNPJ, com opções de configuração inicial.
        /// </summary>
        /// <param name="eArqConfig">Caminho para o arquivo de configuração.</param>
        /// <param name="eChaveCrypt">Chave de criptografia para o arquivo de configuração.</param>
        public ACBrConsultaCNPJ(string eArqConfig = "", string eChaveCrypt = "") : base(eArqConfig, eChaveCrypt)
        {
            consultaCNPJBridge = ACBrConsultaCNPJHandle.Instance;
            Inicializar(eArqConfig, eChaveCrypt);
            Config = new ACBrCNPJConfig(this);
        }

        #endregion Constructors
        /// <inheritdoc />
        public override void Inicializar(string eArqConfig = "", string eChaveCrypt = "")
        {
            var inicializarLib = consultaCNPJBridge.GetMethod<ACBrConsultaCNPJHandle.CNPJ_Inicializar>();
            var ret = consultaCNPJBridge.ExecuteMethod<int>(() => inicializarLib(ref libHandle, ToUTF8(eArqConfig), ToUTF8(eChaveCrypt)));
            CheckResult(ret);
        }



        #region Properties

        /// <inheritdoc />
        public override string Nome()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = consultaCNPJBridge.GetMethod<ACBrConsultaCNPJHandle.CNPJ_Nome>();
            var ret = consultaCNPJBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public override string Versao()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = consultaCNPJBridge.GetMethod<ACBrConsultaCNPJHandle.CNPJ_Versao>();
            var ret = consultaCNPJBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public ACBrCNPJConfig Config { get; }

        #endregion Properties

        #region Metodos

        #region Ini

        /// <inheritdoc />
        public override void ConfigGravar(string eArqConfig = "")
        {
            var gravarIni = consultaCNPJBridge.GetMethod<ACBrConsultaCNPJHandle.CNPJ_ConfigGravar>();
            var ret = consultaCNPJBridge.ExecuteMethod(() => gravarIni(libHandle, ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        /// <inheritdoc />
        public override void ImportarConfig(string eArqConfig)
        {
            var lerIni = consultaCNPJBridge.GetMethod<ACBrConsultaCNPJHandle.CNPJ_ConfigImportar>();
            var ret = consultaCNPJBridge.ExecuteMethod(() => lerIni(libHandle, ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        /// <inheritdoc />
        public override string ExportarConfig()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = consultaCNPJBridge.GetMethod<ACBrConsultaCNPJHandle.CNPJ_ConfigExportar>();
            var ret = consultaCNPJBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public override void ConfigLer(string eArqConfig = "")
        {
            var lerIni = consultaCNPJBridge.GetMethod<ACBrConsultaCNPJHandle.CNPJ_ConfigLer>();
            var ret = consultaCNPJBridge.ExecuteMethod(() => lerIni(libHandle, ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        /// <inheritdoc />
        public override string ConfigLerValor(string eSessao, string eChave)
        {
            var method = consultaCNPJBridge.GetMethod<ACBrConsultaCNPJHandle.CNPJ_ConfigLerValor>();
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);
            var ret = consultaCNPJBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eSessao), ToUTF8(eChave), buffer, ref bufferLen));
            CheckResult(ret);
            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public override void ConfigGravarValor(string eSessao, string eChave, string eValor)
        {
            var method = consultaCNPJBridge.GetMethod<ACBrConsultaCNPJHandle.CNPJ_ConfigGravarValor>();
            var ret = consultaCNPJBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eSessao), ToUTF8(eChave), ToUTF8(eValor)));
            CheckResult(ret);
        }

        #endregion Ini

        #region Diversos

        /// <inheritdoc />
        public string Consultar(string eCNPJ)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = consultaCNPJBridge.GetMethod<ACBrConsultaCNPJHandle.CNPJ_Consultar>();
            var ret = consultaCNPJBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eCNPJ), buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        #endregion Diversos

        #region Private Methods

        /// <inheritdoc />
        public override void Finalizar()
        {
            var finalizarLib = consultaCNPJBridge.GetMethod<ACBrConsultaCNPJHandle.CNPJ_Finalizar>();
            var codRet = consultaCNPJBridge.ExecuteMethod(() => finalizarLib(libHandle));
            CheckResult(codRet);
            libHandle = IntPtr.Zero;
        }

        /// <inheritdoc />
        protected override string GetUltimoRetorno(int iniBufferLen = 0)
        {
            var bufferLen = iniBufferLen < 1 ? BUFFER_LEN : iniBufferLen;
            var buffer = new StringBuilder(bufferLen);
            var ultimoRetorno = consultaCNPJBridge.GetMethod<ACBrConsultaCNPJHandle.CNPJ_UltimoRetorno>();

            if (iniBufferLen < 1)
            {
                consultaCNPJBridge.ExecuteMethod(() => ultimoRetorno(libHandle, buffer, ref bufferLen));
                if (bufferLen <= BUFFER_LEN) return FromUTF8(buffer);

                buffer.Capacity = bufferLen;
            }

            consultaCNPJBridge.ExecuteMethod(() => ultimoRetorno(libHandle, buffer, ref bufferLen));
            return FromUTF8(buffer);
        }

        #endregion Private Methods

        /// <inheritdoc />
        public override string OpenSSLInfo()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = consultaCNPJBridge.GetMethod<ACBrConsultaCNPJHandle.CNPJ_OpenSSLInfo>();
            var ret = consultaCNPJBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

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
        /// Libera os recursos utilizados pela instância da classe <see cref="ACBrConsultaCNPJ"/>. Chama o método <see cref="Finalizar"/> para garantir que a biblioteca seja finalizada corretamente.
        /// </summary>
        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }



        #endregion Metodos
    }
}