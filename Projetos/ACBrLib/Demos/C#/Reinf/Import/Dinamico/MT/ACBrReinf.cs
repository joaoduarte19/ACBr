using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using ACBrLib.Core;
using ACBrLib.Core.DFe;

namespace ACBrLib.Reinf
{
    /// <summary>
    /// Implementação de alto nível da biblioteca ACBrLibReinf para uso em aplicações .NET.
    /// <para>
    /// Encapsula as chamadas à DLL nativa do Reinf, expondo métodos de configuração,
    /// criação, envio e consulta de eventos EFD-Reinf, bem como acesso às configurações
    /// e certificados utilizados pela biblioteca.
    /// </para>
    /// <para>
    /// Documentação geral: <see href="https://acbr.sourceforge.io/ACBrLib/ACBrLibReinf.html">ACBrLibReinf</see>
    /// Métodos: <see href="https://acbr.sourceforge.io/ACBrLib/MetodosReinf.html">Métodos Reinf</see>
    /// </para>
    /// </summary>
    public class ACBrReinf : ACBrLibBase, IACBrLibReinf
    {
        #region Fields

        private IntPtr libHandle = IntPtr.Zero;
        private bool disposed = false;
        private ACBrReinfHandle reinfBridge;

        #endregion Fields

        #region Constructors

        /// <summary>
        /// Cria uma nova instância do componente ACBrReinf.
        /// </summary>
        /// <param name="eArqConfig">Caminho do arquivo de configuração da ACBrLibReinf.</param>
        /// <param name="eChaveCrypt">Chave de criptografia utilizada para proteger o arquivo de configuração.</param>
        public ACBrReinf(string eArqConfig = "", string eChaveCrypt = "") : base(eArqConfig, eChaveCrypt)
        {
            reinfBridge = ACBrReinfHandle.Instance;
            Inicializar(eArqConfig, eChaveCrypt);
            Config = new ACBrReinfConfig(this);
        }

        /// <inheritdoc />
        public override void Inicializar(string eArqConfig = "", string eChaveCrypt = "")
        {
            var inicializar = reinfBridge.GetMethod<ACBrReinfHandle.Reinf_Inicializar>();
            var ret = reinfBridge.ExecuteMethod<int>(() => inicializar(ref libHandle, ToUTF8(eArqConfig), ToUTF8(eChaveCrypt)));
            CheckResult(ret);
        }

        #endregion Constructors

        #region Properties

        /// <inheritdoc />
        public override string Nome()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = reinfBridge.GetMethod<ACBrReinfHandle.Reinf_Nome>();
            var ret = reinfBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public override string Versao()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = reinfBridge.GetMethod<ACBrReinfHandle.Reinf_Versao>();
            var ret = reinfBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public ACBrReinfConfig Config { get; }

        #endregion Properties

        #region Metodos

        #region Ini

        /// <inheritdoc />
        public override void ConfigGravar(string eArqConfig = "")
        {
            var gravarIni = reinfBridge.GetMethod<ACBrReinfHandle.Reinf_ConfigGravar>();
            var ret = reinfBridge.ExecuteMethod(() => gravarIni(libHandle, ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        /// <inheritdoc />
        public override void ImportarConfig(string eArqConfig)
        {
            var lerIni = reinfBridge.GetMethod<ACBrReinfHandle.Reinf_ConfigImportar>();
            var ret = reinfBridge.ExecuteMethod(() => lerIni(libHandle, ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        /// <inheritdoc />
        public override string ExportarConfig()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = reinfBridge.GetMethod<ACBrReinfHandle.Reinf_ConfigExportar>();
            var ret = reinfBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public override void ConfigLer(string eArqConfig = "")
        {
            var lerIni = reinfBridge.GetMethod<ACBrReinfHandle.Reinf_ConfigLer>();
            var ret = reinfBridge.ExecuteMethod(() => lerIni(libHandle, ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        /// <inheritdoc />
        public override string ConfigLerValor(string eSessao, string eChave)
        {
            var method = reinfBridge.GetMethod<ACBrReinfHandle.Reinf_ConfigLerValor>();

            var bufferLen = BUFFER_LEN;
            var pValue = new StringBuilder(bufferLen);
            var ret = reinfBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eSessao), ToUTF8(eChave), pValue, ref bufferLen));
            CheckResult(ret);

            return CheckBuffer(pValue, bufferLen);
        }

        /// <inheritdoc />
        public override void ConfigGravarValor(string eSessao, string eChave, string eValor)
        {
            var method = reinfBridge.GetMethod<ACBrReinfHandle.Reinf_ConfigGravarValor>();
            var ret = reinfBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eSessao), ToUTF8(eChave), ToUTF8(eValor)));
            CheckResult(ret);
        }

        #endregion Ini

        #region Diversos

        /// <inheritdoc />
        public void CriarEventoReinf (string eArqIni)
        {
            var method = reinfBridge.GetMethod<ACBrReinfHandle.Reinf_CriarEventoReinf>();
            var ret = reinfBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eArqIni)));

            CheckResult(ret);
        }

        /// <inheritdoc />
        public string EnviarReinf()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = reinfBridge.GetMethod<ACBrReinfHandle.Reinf_EnviarReinf>();
            var ret = reinfBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public string ConsultarReinf(string eProtocolo)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = reinfBridge.GetMethod<ACBrReinfHandle.Reinf_ConsultarReinf>();
            var ret = reinfBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eProtocolo), buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

         /// <inheritdoc />
        public string ConsultarReciboReinf(string ePerApur, int aTipoEvento, string eNrInscEstab,
            string eCnpjPrestador, string eNrInscTomador, string eDtApur, string eCpfCnpjBenef,
            string eCnpjFonte)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = reinfBridge.GetMethod<ACBrReinfHandle.Reinf_ConsultarReciboReinf>();
            var ret = reinfBridge.ExecuteMethod(() => method(libHandle, 
                                                 ToUTF8(ePerApur), aTipoEvento, ToUTF8(eNrInscEstab),
                                                 ToUTF8(eCnpjPrestador), ToUTF8(eNrInscTomador), 
                                                 ToUTF8(eDtApur), ToUTF8(eCpfCnpjBenef),
                                                 ToUTF8(eCnpjFonte),
                                                 buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public string CriarEnviarReinf(string eArqIni)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = reinfBridge.GetMethod<ACBrReinfHandle.Reinf_CriarEnviarReinf>();
            var ret = reinfBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eArqIni), buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public void LimparReinf()
        {
            var method = reinfBridge.GetMethod<ACBrReinfHandle.Reinf_LimparReinf>();
            var ret = reinfBridge.ExecuteMethod(() => method(libHandle));

            CheckResult(ret);
        }

        /// <inheritdoc />
        public void CarregarXMLEventoReinf(string eArquivoOuXML)
        {
            var method = reinfBridge.GetMethod<ACBrReinfHandle.Reinf_CarregarXMLEventoReinf>();
            var ret = reinfBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eArquivoOuXML)));

            CheckResult(ret);
        }

        /// <inheritdoc />
        public void SetIDContribuinte(string aIdContribuinte)
        {
            var method = reinfBridge.GetMethod<ACBrReinfHandle.Reinf_SetIDContribuinte>();
            var ret = reinfBridge.ExecuteMethod(() => method(libHandle, ToUTF8(aIdContribuinte)));

            CheckResult(ret);
        }

        /// <inheritdoc />
        public void SetIDTransmissor(string aIdTransmissor)
        {
            var method = reinfBridge.GetMethod<ACBrReinfHandle.Reinf_SetIDTransmissor>();
            var ret = reinfBridge.ExecuteMethod(() => method(libHandle, ToUTF8(aIdTransmissor)));

            CheckResult(ret);
        }

        public void TipoContribuinte(int aTipoContribuinte)
        {
            var method = reinfBridge.GetMethod<ACBrReinfHandle.Reinf_SetTipoContribuinte>();
            var ret = reinfBridge.ExecuteMethod(() => method(libHandle, aTipoContribuinte));

            CheckResult(ret);
        }

        /// <inheritdoc />
        public void SetTipoContribuinte(int aTipoContribuinte)
        {
            TipoContribuinte(aTipoContribuinte);
        }

        /// <inheritdoc />
        public void SetVersao(string sVersao)
        {
            var method = reinfBridge.GetMethod<ACBrReinfHandle.Reinf_SetVersaoDF>();
            var ret = reinfBridge.ExecuteMethod(() => method(libHandle, ToUTF8(sVersao)));

            CheckResult(ret);
        }

        /// <inheritdoc />
        public override string OpenSSLInfo()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = reinfBridge.GetMethod<ACBrReinfHandle.Reinf_OpenSSLInfo>();
            var ret = reinfBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public InfoCertificado[] ObterCertificados()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = reinfBridge.GetMethod<ACBrReinfHandle.Reinf_ObterCertificados>();
            var ret = reinfBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            var certificados = CheckBuffer(buffer, bufferLen).Split(new[] { Environment.NewLine }, StringSplitOptions.RemoveEmptyEntries);
            return certificados.Length == 0 ? new InfoCertificado[0] : certificados.Select(x => new InfoCertificado(x)).ToArray();
        }

        #endregion Diversos

        #region Private Methods

        /// <inheritdoc />
        public override void Finalizar()
        {
            var finalizarLib = reinfBridge.GetMethod<ACBrReinfHandle.Reinf_Finalizar>();
            var codRet = reinfBridge.ExecuteMethod(() => finalizarLib(libHandle));
            CheckResult(codRet);
            libHandle = IntPtr.Zero;
        }

        /// <inheritdoc />
        protected override string GetUltimoRetorno(int iniBufferLen = 0)
        {
            var bufferLen = iniBufferLen < 1 ? BUFFER_LEN : iniBufferLen;
            var buffer = new StringBuilder(bufferLen);
            var ultimoRetorno = reinfBridge.GetMethod<ACBrReinfHandle.Reinf_UltimoRetorno>();

            if (iniBufferLen < 1)
            {
                reinfBridge.ExecuteMethod(() => ultimoRetorno(libHandle, buffer, ref bufferLen));
                if (bufferLen <= BUFFER_LEN) return FromUTF8(buffer);

                buffer.Capacity = bufferLen;
            }

            reinfBridge.ExecuteMethod(() => ultimoRetorno(libHandle, buffer, ref bufferLen));
            return FromUTF8(buffer);
        }

        #endregion Private Methods

        #endregion Metodos

        #region IDisposable

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

        /// <inheritdoc />
        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        #endregion IDisposable
    }
}