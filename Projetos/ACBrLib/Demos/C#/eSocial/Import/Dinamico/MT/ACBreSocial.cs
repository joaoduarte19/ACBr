using System;
using System.Linq;
using System.Text;
using ACBrLib.Core;
using ACBrLib.Core.DFe;

namespace ACBrLib.eSocial
{
    /// <inheritdoc />
    public class ACBreSocial : ACBrLibBase, IACBrLibeSocial
    {
        /// <summary>
        /// Handle nativo da instância da ACBrLib eSocial.
        /// </summary>
        protected IntPtr libHandle = IntPtr.Zero;

        /// <summary>
        /// Ponte para os delegates nativos da ACBrLib eSocial.
        /// </summary>
        protected readonly ACBreSocialHandle acbreSocialBridge;
        protected bool disposed = false;

        #region Constructors

        /// <inheritdoc/>
        public ACBreSocial(string eArqConfig = "", string eChaveCrypt = "") : base(eArqConfig, eChaveCrypt)
        {
            acbreSocialBridge = ACBreSocialHandle.Instance;
            Inicializar(eArqConfig, eChaveCrypt);
            Config = new ACBreSocialConfig(this);
        }

        /// <inheritdoc/>
        public override void Inicializar(string eArqConfig = "", string eChaveCrypt = "")
        {
            var inicializarLib = acbreSocialBridge.GetMethod<ACBreSocialHandle.eSocial_Inicializar>();
            var ret = acbreSocialBridge.ExecuteMethod(() => inicializarLib(ref libHandle, ToUTF8(eArqConfig), ToUTF8(eChaveCrypt)));
            CheckResult(ret);
        }

        #endregion Constructors

        #region Properties

        /// <inheritdoc/>
        public override string Nome()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbreSocialBridge.GetMethod<ACBreSocialHandle.eSocial_Nome>();
            var ret = acbreSocialBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc/>
        public override string Versao()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbreSocialBridge.GetMethod<ACBreSocialHandle.eSocial_Versao>();
            var ret = acbreSocialBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc/>
        public ACBreSocialConfig Config { get; }

        #endregion Properties

        #region Methods

        #region Ini

        /// <inheritdoc/>
        public override void ConfigGravar(string eArqConfig = "")
        {
            var gravarIni = acbreSocialBridge.GetMethod<ACBreSocialHandle.eSocial_ConfigGravar>();
            var ret = acbreSocialBridge.ExecuteMethod(() => gravarIni(libHandle, ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public override void ImportarConfig(string eArqConfig)
        {
            var lerIni = acbreSocialBridge.GetMethod<ACBreSocialHandle.eSocial_ConfigImportar>();
            var ret = acbreSocialBridge.ExecuteMethod(() => lerIni(libHandle, ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public override string ExportarConfig()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbreSocialBridge.GetMethod<ACBreSocialHandle.eSocial_ConfigExportar>();
            var ret = acbreSocialBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc/>
        public override void ConfigLer(string eArqConfig = "")
        {
            var lerIni = acbreSocialBridge.GetMethod<ACBreSocialHandle.eSocial_ConfigLer>();
            var ret = acbreSocialBridge.ExecuteMethod(() => lerIni(libHandle, ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public override string ConfigLerValor(string eSessao, string eChave)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbreSocialBridge.GetMethod<ACBreSocialHandle.eSocial_ConfigLerValor>();
            var ret = acbreSocialBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eSessao), ToUTF8(eChave), buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc/>
        public override void ConfigGravarValor(string eSessao, string eChave, string eValor)
        {
            var method = acbreSocialBridge.GetMethod<ACBreSocialHandle.eSocial_ConfigGravarValor>();
            var ret = acbreSocialBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eSessao), ToUTF8(eChave), ToUTF8(eValor)));

            CheckResult(ret);
        }

        #endregion Ini

        #region Diversos

        /// <inheritdoc/>
        public void CriarEventoeSocial(string eArqIni)
        {
            var method = acbreSocialBridge.GetMethod<ACBreSocialHandle.eSocial_CriarEventoeSocial>();
            var ret = acbreSocialBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eArqIni)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public string EnviareSocial(int aGrupo)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbreSocialBridge.GetMethod<ACBreSocialHandle.eSocial_EnviareSocial>();
            var ret = acbreSocialBridge.ExecuteMethod(() => method(libHandle, aGrupo, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc/>
        public string ConsultareSocial(string eProtocolo)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbreSocialBridge.GetMethod<ACBreSocialHandle.eSocial_ConsultareSocial>();
            var ret = acbreSocialBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eProtocolo), buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc/>
        public string CriarEnviareSocial(string eArqIni, int aGrupo)
        {
            var method = acbreSocialBridge.GetMethod<ACBreSocialHandle.eSocial_CriarEnviareSocial>();
            var ret = acbreSocialBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eArqIni), aGrupo));

            CheckResult(ret);

            return GetUltimoRetorno(ret);
        }

        /// <inheritdoc/>
        public void LimpareSocial()
        {
            var method = acbreSocialBridge.GetMethod<ACBreSocialHandle.eSocial_LimpareSocial>();
            var ret = acbreSocialBridge.ExecuteMethod(() => method(libHandle));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void CarregarXMLEventoeSocial(string eArquivoOuXML)
        {
            var method = acbreSocialBridge.GetMethod<ACBreSocialHandle.eSocial_CarregarXMLEventoeSocial>();
            var ret = acbreSocialBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eArquivoOuXML)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void SetIDEmpregador(string aIdEmpregador)
        {
            var method = acbreSocialBridge.GetMethod<ACBreSocialHandle.eSocial_SetIDEmpregador>();
            var ret = acbreSocialBridge.ExecuteMethod(() => method(libHandle, ToUTF8(aIdEmpregador)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void SetIDTransmissor(string aIdTransmissor)
        {
            var method = acbreSocialBridge.GetMethod<ACBreSocialHandle.eSocial_SetIDTransmissor>();
            var ret = acbreSocialBridge.ExecuteMethod(() => method(libHandle, ToUTF8(aIdTransmissor)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void SetTipoEmpregador(int aTipoEmpregador)
        {
            var method = acbreSocialBridge.GetMethod<ACBreSocialHandle.eSocial_SetTipoEmpregador>();
            var ret = acbreSocialBridge.ExecuteMethod(() => method(libHandle, aTipoEmpregador));

            CheckResult(ret);
        }

        public void TipoEmpregador(int aTipoEmpregador)
        {
            SetTipoEmpregador(aTipoEmpregador);
        }

        /// <inheritdoc/>
        public void SetVersao(string sVersao)
        {
            var method = acbreSocialBridge.GetMethod<ACBreSocialHandle.eSocial_SetVersaoDF>();
            var ret = acbreSocialBridge.ExecuteMethod(() => method(libHandle, ToUTF8(sVersao)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public string ConsultaIdentificadoresEventosEmpregador(string aIdEmpregador, int aTipoEvento, DateTime aPeriodoApuracao)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbreSocialBridge.GetMethod<ACBreSocialHandle.eSocial_ConsultaIdentificadoresEventosEmpregador>();
            var ret = acbreSocialBridge.ExecuteMethod(() => method(libHandle, ToUTF8(aIdEmpregador), aTipoEvento, aPeriodoApuracao, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc/>
        public string ConsultaIdentificadoresEventosTabela(string aIdEmpregador, int aTipoEvento, string aChave, DateTime aDataInicial, DateTime aDataFinal)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbreSocialBridge.GetMethod<ACBreSocialHandle.eSocial_ConsultaIdentificadoresEventosTabela>();
            var ret = acbreSocialBridge.ExecuteMethod(() => method(libHandle, ToUTF8(aIdEmpregador), aTipoEvento, aChave, aDataInicial, aDataFinal, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc/>
        public string ConsultaIdentificadoresEventosTrabalhador(string aIdEmpregador, string aCPFTrabalhador, DateTime aDataInicial, DateTime aDataFinal)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbreSocialBridge.GetMethod<ACBreSocialHandle.eSocial_ConsultaIdentificadoresEventosTrabalhador>();
            var ret = acbreSocialBridge.ExecuteMethod(() => method(libHandle, ToUTF8(aIdEmpregador), aCPFTrabalhador, aDataInicial, aDataFinal, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc/>
        public string DownloadEventos(string aIdEmpregador, string aCPFTrabalhador, DateTime aDataInicial, DateTime aDataFinal)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbreSocialBridge.GetMethod<ACBreSocialHandle.eSocial_DownloadEventos>();
            var ret = acbreSocialBridge.ExecuteMethod(() => method(libHandle, ToUTF8(aIdEmpregador), aCPFTrabalhador, aDataInicial, aDataFinal, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc/>
        public InfoCertificado[] ObterCertificados()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbreSocialBridge.GetMethod<ACBreSocialHandle.eSocial_ObterCertificados>();
            var ret = acbreSocialBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            var certificados = CheckBuffer(buffer, bufferLen).Split(new[] { Environment.NewLine }, StringSplitOptions.RemoveEmptyEntries);
            return certificados.Length == 0 ? new InfoCertificado[0] : certificados.Select(x => new InfoCertificado(x)).ToArray();
        }

        /// <inheritdoc/>
        protected void Dispose(bool disposing)
        {
            if (disposed) return;

            if (disposing)
            {
                Finalizar();
                disposed = true;
            }
        }

        /// <inheritdoc/>
        public void Dispose()
        {
            if (disposed) return;
            Dispose(true);
        }

        /// <inheritdoc/>
        public override string OpenSSLInfo()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbreSocialBridge.GetMethod<ACBreSocialHandle.eSocial_OpenSSLInfo>();
            var ret = acbreSocialBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        #endregion Diversos

        #region Private Methods

        /// <inheritdoc/>
        public override void Finalizar()
        {
            if (libHandle == IntPtr.Zero) return;

            var finalizarLib = acbreSocialBridge.GetMethod<ACBreSocialHandle.eSocial_Finalizar>();
            var codRet = acbreSocialBridge.ExecuteMethod(() => finalizarLib(libHandle));
            CheckResult(codRet);
            libHandle = IntPtr.Zero;
        }

        /// <inheritdoc/>
        protected override string GetUltimoRetorno(int iniBufferLen = 0)
        {
            var bufferLen = iniBufferLen < 1 ? BUFFER_LEN : iniBufferLen;
            var buffer = new StringBuilder(bufferLen);
            var ultimoRetorno = acbreSocialBridge.GetMethod<ACBreSocialHandle.eSocial_UltimoRetorno>();

            if (iniBufferLen < 1)
            {
                acbreSocialBridge.ExecuteMethod(() => ultimoRetorno(libHandle, buffer, ref bufferLen));
                if (bufferLen <= BUFFER_LEN) return FromUTF8(buffer);

                buffer.Capacity = bufferLen;
            }

            acbreSocialBridge.ExecuteMethod(() => ultimoRetorno(libHandle, buffer, ref bufferLen));
            return FromUTF8(buffer);
        }

        #endregion Private Methods

        #endregion Methods
    }
}
