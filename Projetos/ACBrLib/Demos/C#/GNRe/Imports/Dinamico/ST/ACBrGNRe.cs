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
    public sealed partial class ACBrGNRe : ACBrLibHandle, IACBrLibGNRe
    {
        #region Constructors

        /// <summary>
        /// Inicializa uma nova instância da biblioteca ACBrLib GNRe.
        /// </summary>
        /// <param name="eArqConfig">Arquivo de configuração da biblioteca.</param>
        /// <param name="eChaveCrypt">Chave de criptografia utilizada na configuração.</param>
        public ACBrGNRe(string eArqConfig = "", string eChaveCrypt = "") : base(IsWindows ? "ACBrGNRe64.dll" : "libacbrgnre64.so",
                                                                                IsWindows ? "ACBrGNRe32.dll" : "libacbrgnre32.so")
        {
            Inicializar(eArqConfig, eChaveCrypt);
            Config = new GNReConfig(this);
        }

        /// <inheritdoc/>
        public override void Inicializar(string eArqConfig = "", string eChaveCrypt = "")
        {
            var inicializarLib = GetMethod<GNRE_Inicializar>();
            var ret = ExecuteMethod<int>(() => inicializarLib(ToUTF8(eArqConfig), ToUTF8(eChaveCrypt)));
            CheckResult(ret);
        }

        #endregion Constructors

        #region Properties

        /// <summary>
        /// Nome da biblioteca carregada.
        /// </summary>
        public string Nome
        {
            get
            {
                var bufferLen = BUFFER_LEN;
                var buffer = new StringBuilder(bufferLen);

                var method = GetMethod<GNRE_Nome>();
                var ret = ExecuteMethod(() => method(buffer, ref bufferLen));

                CheckResult(ret);

                return ProcessResult(buffer, bufferLen);
            }
        }

        /// <summary>
        /// Versão da biblioteca carregada.
        /// </summary>
        public string Versao
        {
            get
            {
                var bufferLen = BUFFER_LEN;
                var buffer = new StringBuilder(bufferLen);

                var method = GetMethod<GNRE_Versao>();
                var ret = ExecuteMethod(() => method(buffer, ref bufferLen));

                CheckResult(ret);

                return ProcessResult(buffer, bufferLen);
            }
        }

        /// <inheritdoc/>
        public GNReConfig Config { get; }

        #endregion Properties

        #region Methods

        #region Ini

        /// <inheritdoc/>
        public override void ConfigGravar(string eArqConfig = "")
        {
            var gravarIni = GetMethod<GNRE_ConfigGravar>();
            var ret = ExecuteMethod(() => gravarIni(ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public override void ConfigLer(string eArqConfig = "")
        {
            var lerIni = GetMethod<GNRE_ConfigLer>();
            var ret = ExecuteMethod(() => lerIni(ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public override T ConfigLerValor<T>(ACBrSessao eSessao, string eChave)
        {
            var method = GetMethod<GNRE_ConfigLerValor>();

            var bufferLen = BUFFER_LEN;
            var pValue = new StringBuilder(bufferLen);
            var ret = ExecuteMethod(() => method(ToUTF8(eSessao.ToString()), ToUTF8(eChave), pValue, ref bufferLen));
            CheckResult(ret);

            var value = ProcessResult(pValue, bufferLen);
            return ConvertValue<T>(value);
        }

        /// <inheritdoc/>
        public override void ConfigGravarValor(ACBrSessao eSessao, string eChave, object value)
        {
            if (value == null) return;

            var method = GetMethod<GNRE_ConfigGravarValor>();
            var propValue = ConvertValue(value);

            var ret = ExecuteMethod(() => method(ToUTF8(eSessao.ToString()), ToUTF8(eChave), ToUTF8(propValue)));
            CheckResult(ret);
        }

        /// <inheritdoc/>
        public override void ImportarConfig(string eArqConfig = "")
        {
            var importarConfig = GetMethod<GNRE_ConfigImportar>();
            var ret = ExecuteMethod(() => importarConfig(ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public override string ExportarConfig()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = GetMethod<GNRE_ConfigExportar>();
            var ret = ExecuteMethod(() => method(buffer, ref bufferLen));

            CheckResult(ret);

            return ProcessResult(buffer, bufferLen);
        }

        #endregion Ini

        /// <inheritdoc/>
        public void CarregarXML(string eArquivoOuXml)
        {
            var method = GetMethod<GNRE_CarregarXML>();
            var ret = ExecuteMethod(() => method(ToUTF8(eArquivoOuXml)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void CarregarINI(string eArquivoOuIni)
        {
            var method = GetMethod<GNRE_CarregarINI>();
            var ret = ExecuteMethod(() => method(ToUTF8(eArquivoOuIni)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public string ObterXml(int aIndex)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = GetMethod<GNRE_ObterXml>();
            var ret = ExecuteMethod(() => method(aIndex, buffer, ref bufferLen));

            CheckResult(ret);

            return ProcessResult(buffer, bufferLen);
        }

        /// <inheritdoc/>
        public void GravarXml(int aIndex, string eNomeArquivo = "", string ePathArquivo = "")
        {
            var method = GetMethod<GNRE_GravarXml>();
            var ret = ExecuteMethod(() => method(aIndex, ToUTF8(eNomeArquivo), ToUTF8(ePathArquivo)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void CarregarGuiaRetorno(string eArquivoOuXml)
        {
            var method = GetMethod<GNRE_CarregarGuiaRetorno>();
            var ret = ExecuteMethod(() => method(ToUTF8(eArquivoOuXml)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void LimparLista()
        {
            var method = GetMethod<GNRE_LimparLista>();
            var ret = ExecuteMethod(() => method());

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void LimparListaGuiaRetorno()
        {
            var method = GetMethod<GNRE_LimparListaGuiaRetorno>();
            var ret = ExecuteMethod(() => method());

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void Assinar()
        {
            var method = GetMethod<GNRE_Assinar>();
            var ret = ExecuteMethod(() => method());

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void Validar()
        {
            var method = GetMethod<GNRE_Validar>();
            var ret = ExecuteMethod(() => method());

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public string VerificarAssinatura()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = GetMethod<GNRE_VerificarAssinatura>();
            var ret = ExecuteMethod(() => method(buffer, ref bufferLen));

            CheckResult(ret);

            return ProcessResult(buffer, bufferLen);
        }

        /// <inheritdoc/>
        public InfoCertificado[] ObterCertificados()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = GetMethod<GNRE_ObterCertificados>();
            var ret = ExecuteMethod(() => method(buffer, ref bufferLen));

            CheckResult(ret);

            var certificados = ProcessResult(buffer, bufferLen).Split(new[] { Environment.NewLine }, StringSplitOptions.RemoveEmptyEntries);
            return certificados.Length == 0 ? new InfoCertificado[0] : certificados.Select(x => new InfoCertificado(x)).ToArray();
        }

        /// <inheritdoc/>
        public string Enviar()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = GetMethod<GNRE_Enviar>();
            var ret = ExecuteMethod(() => method(buffer, ref bufferLen));

            CheckResult(ret);

            return ProcessResult(buffer, bufferLen);
        }

        /// <inheritdoc/>
        public string Consultar(string uf, int receita)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = GetMethod<GNRE_Consultar>();
            var ret = ExecuteMethod(() => method(ToUTF8(uf), receita, buffer, ref bufferLen));

            CheckResult(ret);

            return ProcessResult(buffer, bufferLen);
        }

        /// <inheritdoc/>
        public void EnviarEmail(string ePara, string eChaveNFe, bool aEnviaPDF, string eAssunto, string eMensagem, string[] eCc = null, string[] eAnexos = null)
        {
            var method = GetMethod<GNRE_EnviarEmail>();
            var ret = ExecuteMethod(() => method(ToUTF8(ePara), ToUTF8(eChaveNFe), aEnviaPDF, ToUTF8(eAssunto), ToUTF8(eCc == null ? "" : string.Join(";", eCc)),
                ToUTF8(eAnexos == null ? "" : string.Join(";", eAnexos)), ToUTF8(eMensagem.Replace(Environment.NewLine, ";"))));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void Imprimir(string impressora = "", bool? MostrarPreview = null)
        {
            var mostrarPreview = MostrarPreview.HasValue ? $"{Convert.ToInt32(MostrarPreview.Value)}" : string.Empty;

            var method = GetMethod<GNRE_Imprimir>();
            var ret = ExecuteMethod(() => method(ToUTF8(impressora), ToUTF8(mostrarPreview)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void ImprimirPDF()
        {
            var method = GetMethod<GNRE_ImprimirPDF>();
            var ret = ExecuteMethod(() => method());

            CheckResult(ret);
        }

        #region Private Methods

        /// <inheritdoc/>
        public override void Finalizar()
        {
            var finalizarLib = GetMethod<GNRE_Finalizar>();
            var codRet = ExecuteMethod(() => finalizarLib());
            CheckResult(codRet);
        }

        /// <inheritdoc/>
        protected override string GetUltimoRetorno(int iniBufferLen = 0)
        {
            var bufferLen = iniBufferLen < 1 ? BUFFER_LEN : iniBufferLen;
            var buffer = new StringBuilder(bufferLen);
            var ultimoRetorno = GetMethod<GNRE_UltimoRetorno>();

            if (iniBufferLen < 1)
            {
                ExecuteMethod(() => ultimoRetorno(buffer, ref bufferLen));
                if (bufferLen <= BUFFER_LEN) return FromUTF8(buffer);

                buffer.Capacity = bufferLen;
            }

            ExecuteMethod(() => ultimoRetorno(buffer, ref bufferLen));
            return FromUTF8(buffer);
        }

        /// <inheritdoc/>
        public override string OpenSSLInfo()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = GetMethod<GNRE_OpenSSLInfo>();
            var ret = ExecuteMethod(() => method(buffer, ref bufferLen));

            CheckResult(ret);

            return ProcessResult(buffer, bufferLen);
        }

        #endregion Private Methods

        #endregion Methods
    }
}