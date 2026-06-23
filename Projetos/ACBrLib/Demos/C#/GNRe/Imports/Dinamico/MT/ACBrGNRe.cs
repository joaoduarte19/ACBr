using System;
using System.Linq;
using System.Text;
using ACBrLib.Core;
using ACBrLib.Core.DFe;

namespace ACBrLib.GNRe
{
    /// <summary>
    /// Implementação dinâmica da ACBrLib GNRe.
    /// </summary>
    public class ACBrGNRe : ACBrLibBase, IACBrLibGNRe
    {
        /// <summary>
        /// Handle nativo da instância da biblioteca.
        /// </summary>
        protected IntPtr libHandle = IntPtr.Zero;

        private bool disposed = false;

        /// <summary>
        /// Ponte para os delegates nativos da ACBrLib GNRe.
        /// </summary>
        protected ACBrGNReHandle acbrGNReBridge;
        #region Constructors

        /// <summary>
        /// Inicializa uma nova instância da biblioteca ACBrLib GNRe.
        /// </summary>
        /// <param name="eArqConfig">Arquivo de configuração da biblioteca.</param>
        /// <param name="eChaveCrypt">Chave de criptografia utilizada na configuração.</param>
        public ACBrGNRe(string eArqConfig = "", string eChaveCrypt = "") : base(eArqConfig, eChaveCrypt)
        {
            acbrGNReBridge = ACBrGNReHandle.Instance;
            Inicializar(eArqConfig, eChaveCrypt);
            Config = new GNReConfig(this);
        }

        /// <inheritdoc/>
        public override void Inicializar(string eArqConfig = "", string eChaveCrypt = "")
        {
            var inicializarLib = acbrGNReBridge.GetMethod<ACBrGNReHandle.GNRE_Inicializar>();
            var ret = acbrGNReBridge.ExecuteMethod<int>(() => inicializarLib(ref libHandle, ToUTF8(eArqConfig), ToUTF8(eChaveCrypt)));
            CheckResult(ret);
        }

        #endregion Constructors

        #region Properties

        /// <inheritdoc/>
        public override string Nome()
        {


            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrGNReBridge.GetMethod<ACBrGNReHandle.GNRE_Nome>();
            var ret = acbrGNReBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);

        }

        /// <inheritdoc/>
        public override string Versao()
        {


            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrGNReBridge.GetMethod<ACBrGNReHandle.GNRE_Versao>();
            var ret = acbrGNReBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);

        }

        /// <inheritdoc/>
        public GNReConfig Config { get; }

  

        #endregion Properties

        #region Methods

        #region Ini

        /// <inheritdoc/>
        public override void ConfigGravar(string eArqConfig = "")
        {
            var gravarIni = acbrGNReBridge.GetMethod<ACBrGNReHandle.GNRE_ConfigGravar>();
            var ret = acbrGNReBridge.ExecuteMethod(() => gravarIni(libHandle, ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public override void ConfigLer(string eArqConfig = "")
        {
            var lerIni = acbrGNReBridge.GetMethod<ACBrGNReHandle.GNRE_ConfigLer>();
            var ret = acbrGNReBridge.ExecuteMethod(() => lerIni(libHandle, ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public override string ConfigLerValor(string eSessao, string eChave)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrGNReBridge.GetMethod<ACBrGNReHandle.GNRE_ConfigLerValor>();
            var ret = acbrGNReBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eSessao), ToUTF8(eChave), buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc/>
        public override void ConfigGravarValor(string eSessao, string eChave, string valor)
        {
            var method = acbrGNReBridge.GetMethod<ACBrGNReHandle.GNRE_ConfigGravarValor>();
            var ret = acbrGNReBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eSessao), ToUTF8(eChave), ToUTF8(valor)));

            CheckResult(ret);
        }


        /// <inheritdoc/>
        public override void ImportarConfig(string eArqConfig = "")
        {
            var importarConfig = acbrGNReBridge.GetMethod<ACBrGNReHandle.GNRE_ConfigImportar>();
            var ret = acbrGNReBridge.ExecuteMethod(() => importarConfig(libHandle, ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public override string ExportarConfig()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrGNReBridge.GetMethod<ACBrGNReHandle.GNRE_ConfigExportar>();
            var ret = acbrGNReBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        #endregion Ini

        /// <inheritdoc/>
        public void CarregarXML(string eArquivoOuXml)
        {
            var method = acbrGNReBridge.GetMethod<ACBrGNReHandle.GNRE_CarregarXML>();
            var ret = acbrGNReBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eArquivoOuXml)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void CarregarINI(string eArquivoOuIni)
        {
            var method = acbrGNReBridge.GetMethod<ACBrGNReHandle.GNRE_CarregarINI>();
            var ret = acbrGNReBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eArquivoOuIni)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public string ObterXml(int aIndex)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrGNReBridge.GetMethod<ACBrGNReHandle.GNRE_ObterXml>();
            var ret = acbrGNReBridge.ExecuteMethod(() => method(libHandle, aIndex, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc/>
        public void GravarXml(int aIndex, string eNomeArquivo = "", string ePathArquivo = "")
        {
            var method = acbrGNReBridge.GetMethod<ACBrGNReHandle.GNRE_GravarXml>();
            var ret = acbrGNReBridge.ExecuteMethod(() => method(libHandle, aIndex, ToUTF8(eNomeArquivo), ToUTF8(ePathArquivo)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void CarregarGuiaRetorno(string eArquivoOuXml)
        {
            var method = acbrGNReBridge.GetMethod<ACBrGNReHandle.GNRE_CarregarGuiaRetorno>();
            var ret = acbrGNReBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eArquivoOuXml)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void LimparLista()
        {
            var method = acbrGNReBridge.GetMethod<ACBrGNReHandle.GNRE_LimparLista>();
            var ret = acbrGNReBridge.ExecuteMethod(() => method(libHandle));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void LimparListaGuiaRetorno()
        {
            var method = acbrGNReBridge.GetMethod<ACBrGNReHandle.GNRE_LimparListaGuiaRetorno>();
            var ret = acbrGNReBridge.ExecuteMethod(() => method(libHandle));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void Assinar()
        {
            var method = acbrGNReBridge.GetMethod<ACBrGNReHandle.GNRE_Assinar>();
            var ret = acbrGNReBridge.ExecuteMethod(() => method(libHandle));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void Validar()
        {
            var method = acbrGNReBridge.GetMethod<ACBrGNReHandle.GNRE_Validar>();
            var ret = acbrGNReBridge.ExecuteMethod(() => method(libHandle));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public string VerificarAssinatura()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrGNReBridge.GetMethod<ACBrGNReHandle.GNRE_VerificarAssinatura>();
            var ret = acbrGNReBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc/>
        public InfoCertificado[] ObterCertificados()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrGNReBridge.GetMethod<ACBrGNReHandle.GNRE_ObterCertificados>();
            var ret = acbrGNReBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            var certificados = CheckBuffer(buffer, bufferLen).Split(new[] { Environment.NewLine }, StringSplitOptions.RemoveEmptyEntries);
            return certificados.Length == 0 ? new InfoCertificado[0] : certificados.Select(x => new InfoCertificado(x)).ToArray();
        }

        /// <inheritdoc/>
        public string Enviar()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrGNReBridge.GetMethod<ACBrGNReHandle.GNRE_Enviar>();
            var ret = acbrGNReBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc/>
        public string Consultar(string uf, int receita)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrGNReBridge.GetMethod<ACBrGNReHandle.GNRE_Consultar>();
            var ret = acbrGNReBridge.ExecuteMethod(() => method(libHandle, ToUTF8(uf), receita, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc/>
        public void EnviarEmail(string ePara, string eChaveNFe, bool aEnviaPDF, string eAssunto, string eMensagem, string[] eCc = null, string[] eAnexos = null)
        {
            var method = acbrGNReBridge.GetMethod<ACBrGNReHandle.GNRE_EnviarEmail>();
            var ret = acbrGNReBridge.ExecuteMethod(() => method(libHandle, ToUTF8(ePara), ToUTF8(eChaveNFe), aEnviaPDF, ToUTF8(eAssunto), ToUTF8(eCc == null ? "" : string.Join(";", eCc)),
                ToUTF8(eAnexos == null ? "" : string.Join(";", eAnexos)), ToUTF8(eMensagem.Replace(Environment.NewLine, ";"))));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void Imprimir(string impressora = "", bool? MostrarPreview = null)
        {
            var mostrarPreview = MostrarPreview.HasValue ? $"{Convert.ToInt32(MostrarPreview.Value)}" : string.Empty;

            var method = acbrGNReBridge.GetMethod<ACBrGNReHandle.GNRE_Imprimir>();
            var ret = acbrGNReBridge.ExecuteMethod(() => method(libHandle, ToUTF8(impressora), ToUTF8(mostrarPreview)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void ImprimirPDF()
        {
            var method = acbrGNReBridge.GetMethod<ACBrGNReHandle.GNRE_ImprimirPDF>();
            var ret = acbrGNReBridge.ExecuteMethod(() => method(libHandle));

            CheckResult(ret);
        }


        /// <summary>
        /// Libera recursos gerenciados e nativos da instância.
        /// </summary>
        /// <param name="disposing">Indica se o descarte foi iniciado de forma determinística.</param>
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
            this.Dispose(true);

        }

        #region Private Methods

        /// <inheritdoc/>
        public override void Finalizar()
        {
            var finalizarLib = acbrGNReBridge.GetMethod<ACBrGNReHandle.GNRE_Finalizar>();
            var codRet = acbrGNReBridge.ExecuteMethod(() => finalizarLib(libHandle));
 
            CheckResult(codRet);
            libHandle = IntPtr.Zero;
        }

        /// <inheritdoc/>
        protected override string GetUltimoRetorno(int iniBufferLen = 0)
        {
            var bufferLen = iniBufferLen < 1 ? BUFFER_LEN : iniBufferLen;
            var buffer = new StringBuilder(bufferLen);
            var ultimoRetorno = acbrGNReBridge.GetMethod<ACBrGNReHandle.GNRE_UltimoRetorno>();

            if (iniBufferLen < 1)
            {
                acbrGNReBridge.ExecuteMethod(() => ultimoRetorno(libHandle, buffer, ref bufferLen));
                if (bufferLen <= BUFFER_LEN) return FromUTF8(buffer);

                buffer.Capacity = bufferLen;
            }

            acbrGNReBridge.ExecuteMethod(() => ultimoRetorno(libHandle, buffer, ref bufferLen));
            return FromUTF8(buffer);
        }

        /// <inheritdoc/>
        public override string OpenSSLInfo()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrGNReBridge.GetMethod<ACBrGNReHandle.GNRE_OpenSSLInfo>();
            var ret = acbrGNReBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }


        #endregion Private Methods

        #endregion Methods
    }
}