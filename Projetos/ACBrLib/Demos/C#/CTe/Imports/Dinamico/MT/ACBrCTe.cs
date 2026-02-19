using System;
using System.IO;
using System.Linq;
using System.Text;
using ACBrLib.Core;
using ACBrLib.Core.CTe;
using ACBrLib.Core.DFe;

namespace ACBrLib.CTe
{
    public class ACBrCTe : ACBrLibBase, IACBrLibCTe
    {

        #region Fields
        private IntPtr libHandle = IntPtr.Zero;
        private ACBrCTeHandle acbrCteBridge;
        private bool disposed = false;

        #endregion Fields

        #region Constructors

        /// <inheritdoc/>
        public ACBrCTe(string eArqConfig = "", string eChaveCrypt = "") : base(eArqConfig, eChaveCrypt)
        {
            acbrCteBridge = ACBrCTeHandle.Instance;
            Inicializar(eArqConfig, eChaveCrypt);
            Config = new CTeConfig(this);
        }

        /// <inheritdoc/>
        public override void Inicializar(string eArqConfig = "", string eChaveCrypt = "")
        {
            var inicializarLib = acbrCteBridge.GetMethod<ACBrCTeHandle.CTE_Inicializar>();
            var ret = acbrCteBridge.ExecuteMethod<int>(() => inicializarLib(ref libHandle, ToUTF8(eArqConfig), ToUTF8(eChaveCrypt)));
            CheckResult(ret);
        }

        #endregion Constructors

        #region Properties

        /// <inheritdoc/>
        public override string Nome()
        {

            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrCteBridge.GetMethod<ACBrCTeHandle.CTE_Nome>();
            var ret = acbrCteBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);

        }

        /// <inheritdoc/>
        public override string Versao()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrCteBridge.GetMethod<ACBrCTeHandle.CTE_Versao>();
            var ret = acbrCteBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc/>
        public CTeConfig Config { get; }

        #endregion Properties

        #region Methods

        #region Ini

        /// <inheritdoc/>
        public override void ConfigGravar(string eArqConfig = "")
        {
            var gravarIni = acbrCteBridge.GetMethod<ACBrCTeHandle.CTE_ConfigGravar>();
            var ret = acbrCteBridge.ExecuteMethod(() => gravarIni(libHandle, ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public override void ConfigLer(string eArqConfig = "")
        {
            var lerIni = acbrCteBridge.GetMethod<ACBrCTeHandle.CTE_ConfigLer>();
            var ret = acbrCteBridge.ExecuteMethod(() => lerIni(libHandle, ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public override string ConfigLerValor(string eSessao, string eChave)
        {
            var method = acbrCteBridge.GetMethod<ACBrCTeHandle.CTE_ConfigLerValor>();

            var bufferLen = BUFFER_LEN;
            var pValue = new StringBuilder(bufferLen);
            var ret = acbrCteBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eSessao), ToUTF8(eChave), pValue, ref bufferLen));
            CheckResult(ret);
            return CheckBuffer(pValue, bufferLen);
        }

        /// <inheritdoc/>
        public override void ConfigGravarValor(string eSessao, string eChave, string eValor)
        {
            var method = acbrCteBridge.GetMethod<ACBrCTeHandle.CTE_ConfigGravarValor>();

            var ret = acbrCteBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eSessao), ToUTF8(eChave), ToUTF8(eValor)));
            CheckResult(ret);
        }

        /// <inheritdoc/>
        public override void ImportarConfig(string eArqConfig = "")
        {
            var importarConfig = acbrCteBridge.GetMethod<ACBrCTeHandle.CTE_ConfigImportar>();
            var ret = acbrCteBridge.ExecuteMethod(() => importarConfig(libHandle, ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public override string ExportarConfig()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrCteBridge.GetMethod<ACBrCTeHandle.CTE_ConfigExportar>();
            var ret = acbrCteBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        #endregion Ini
        /// <inheritdoc/>
        public void CarregarCTe(CTe cte) => CarregarINI(cte.ToString());

        /// <inheritdoc/>
        public CTe ObterCTe(int aIndex) => CTe.Load(ObterIni(aIndex));

        /// <inheritdoc/>
        public void CarregarXML(string eArquivoOuXml)
        {
            var method = acbrCteBridge.GetMethod<ACBrCTeHandle.CTE_CarregarXML>();
            var ret = acbrCteBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eArquivoOuXml)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void CarregarINI(string eArquivoOuIni)
        {
            var method = acbrCteBridge.GetMethod<ACBrCTeHandle.CTE_CarregarINI>();
            var ret = acbrCteBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eArquivoOuIni)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public string ObterXml(int aIndex)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrCteBridge.GetMethod<ACBrCTeHandle.CTE_ObterXml>();
            var ret = acbrCteBridge.ExecuteMethod(() => method(libHandle, aIndex, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc/>
        public void GravarXml(int aIndex, string eNomeArquivo = "", string ePathArquivo = "")
        {
            var method = acbrCteBridge.GetMethod<ACBrCTeHandle.CTE_GravarXml>();
            var ret = acbrCteBridge.ExecuteMethod(() => method(libHandle, aIndex, ToUTF8(eNomeArquivo), ToUTF8(ePathArquivo)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public string ObterIni(int aIndex)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrCteBridge.GetMethod<ACBrCTeHandle.CTE_ObterIni>();
            var ret = acbrCteBridge.ExecuteMethod(() => method(libHandle, aIndex, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc/>
        public void GravarIni(int aIndex, string eNomeArquivo = "", string ePathArquivo = "")
        {
            var method = acbrCteBridge.GetMethod<ACBrCTeHandle.CTE_GravarIni>();
            var ret = acbrCteBridge.ExecuteMethod(() => method(libHandle, aIndex, ToUTF8(eNomeArquivo), ToUTF8(ePathArquivo)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void CarregarEventoXML(string eArquivoOuXml)
        {
            var method = acbrCteBridge.GetMethod<ACBrCTeHandle.CTE_CarregarEventoXML>();
            var ret = acbrCteBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eArquivoOuXml)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void CarregarEventoINI(string eArquivoOuIni)
        {
            var method = acbrCteBridge.GetMethod<ACBrCTeHandle.CTE_CarregarEventoINI>();
            var ret = acbrCteBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eArquivoOuIni)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void LimparLista()
        {
            var method = acbrCteBridge.GetMethod<ACBrCTeHandle.CTE_LimparLista>();
            var ret = acbrCteBridge.ExecuteMethod(() => method(libHandle));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void LimparListaEventos()
        {
            var method = acbrCteBridge.GetMethod<ACBrCTeHandle.CTE_LimparListaEventos>();
            var ret = acbrCteBridge.ExecuteMethod(() => method(libHandle));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void Assinar()
        {
            var method = acbrCteBridge.GetMethod<ACBrCTeHandle.CTE_Assinar>();
            var ret = acbrCteBridge.ExecuteMethod(() => method(libHandle));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void Validar()
        {
            var method = acbrCteBridge.GetMethod<ACBrCTeHandle.CTE_Validar>();
            var ret = acbrCteBridge.ExecuteMethod(() => method(libHandle));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public string ValidarRegrasdeNegocios()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrCteBridge.GetMethod<ACBrCTeHandle.CTE_ValidarRegrasdeNegocios>();
            var ret = acbrCteBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc/>
        public string VerificarAssinatura()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrCteBridge.GetMethod<ACBrCTeHandle.CTE_VerificarAssinatura>();
            var ret = acbrCteBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc/>
        public string GerarChave(int aCodigoUf, int aCodigoNumerico, int aModelo, int aSerie, int aNumero,
            int aTpEmi, DateTime aEmissao, string acpfcnpj)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrCteBridge.GetMethod<ACBrCTeHandle.CTE_GerarChave>();
            var ret = acbrCteBridge.ExecuteMethod(() => method(libHandle, aCodigoUf, aCodigoNumerico, aModelo, aSerie, aNumero,
                aTpEmi, aEmissao.Date.ToString("dd/MM/yyyy"), ToUTF8(acpfcnpj),
                buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc/>
        public InfoCertificado[] ObterCertificados()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrCteBridge.GetMethod<ACBrCTeHandle.CTE_ObterCertificados>();
            var ret = acbrCteBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            var certificados = CheckBuffer(buffer, bufferLen).Split(new[] { Environment.NewLine }, StringSplitOptions.RemoveEmptyEntries);
            return certificados.Length == 0 ? new InfoCertificado[0] : certificados.Select(x => new InfoCertificado(x)).ToArray();
        }
        /// <inheritdoc/>
        public override string OpenSSLInfo()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrCteBridge.GetMethod<ACBrCTeHandle.CTE_OpenSSLInfo>();
            var ret = acbrCteBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc/>
        public string GetPath(TipoPathCTe tipo)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrCteBridge.GetMethod<ACBrCTeHandle.CTE_GetPath>();
            var ret = acbrCteBridge.ExecuteMethod(() => method(libHandle, (int)tipo, buffer, ref bufferLen));

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc/>
        public string GetPathEvento(string evento)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrCteBridge.GetMethod<ACBrCTeHandle.CTE_GetPathEvento>();
            var ret = acbrCteBridge.ExecuteMethod(() => method(libHandle, ToUTF8(evento), buffer, ref bufferLen));

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc/>
        public string StatusServico()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrCteBridge.GetMethod<ACBrCTeHandle.CTE_StatusServico>();
            var ret = acbrCteBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc/>
        public ConsultaCTeResposta Consultar(string eChaveOuCTe, bool AExtrairEventos = false)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrCteBridge.GetMethod<ACBrCTeHandle.CTE_Consultar>();
            var ret = acbrCteBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eChaveOuCTe), AExtrairEventos, buffer, ref bufferLen));

            CheckResult(ret);

            return ConsultaCTeResposta.LerResposta(CheckBuffer(buffer, bufferLen));

        }

        /// <inheritdoc/>
        public string ConsultaCadastro(string cUF, string nDocumento, bool nIE)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrCteBridge.GetMethod<ACBrCTeHandle.CTE_ConsultaCadastro>();
            var ret = acbrCteBridge.ExecuteMethod(() => method(libHandle, ToUTF8(cUF), ToUTF8(nDocumento), nIE, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc/>
        public InutilizacaoCTeResposta Inutilizar(string acnpj, string aJustificativa, int ano, int modelo,
            int serie, int numeroInicial, int numeroFinal)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrCteBridge.GetMethod<ACBrCTeHandle.CTE_Inutilizar>();
            var ret = acbrCteBridge.ExecuteMethod(() => method(libHandle, ToUTF8(acnpj), ToUTF8(aJustificativa), ano, modelo, serie, numeroInicial, numeroFinal, buffer, ref bufferLen));

            CheckResult(ret);

            return InutilizacaoCTeResposta.LerResposta(CheckBuffer(buffer, bufferLen));
        }

        /// <inheritdoc/>
        public EnvioRetornoResposta Enviar(int aLote, bool imprimir = false, bool sincrono = false)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrCteBridge.GetMethod<ACBrCTeHandle.CTE_Enviar>();
            var ret = acbrCteBridge.ExecuteMethod(() => method(libHandle, aLote, imprimir, sincrono, buffer, ref bufferLen));

            CheckResult(ret);

            return EnvioRetornoResposta.LerResposta(CheckBuffer(buffer, bufferLen), "CTe");
        }

        /// <inheritdoc/>
        public string ConsultarRecibo(string aRecibo)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrCteBridge.GetMethod<ACBrCTeHandle.CTE_ConsultarRecibo>();
            var ret = acbrCteBridge.ExecuteMethod(() => method(libHandle, ToUTF8(aRecibo), buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc/>
        public CancelamentoCTeResposta Cancelar(string eChave, string eJustificativa, string eCNPJ, int aLote)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrCteBridge.GetMethod<ACBrCTeHandle.CTE_Cancelar>();
            var ret = acbrCteBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eChave), ToUTF8(eJustificativa), ToUTF8(eCNPJ), aLote, buffer, ref bufferLen));

            CheckResult(ret);

            return CancelamentoCTeResposta.LerResposta(CheckBuffer(buffer, bufferLen));
        }

        /// <inheritdoc/>
        public string EnviarEvento(int aLote)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrCteBridge.GetMethod<ACBrCTeHandle.CTE_EnviarEvento>();
            var ret = acbrCteBridge.ExecuteMethod(() => method(libHandle, aLote, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc/>
        public string DistribuicaoDFePorUltNSU(int acUFAutor, string eCnpjcpf, string eultNsu)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrCteBridge.GetMethod<ACBrCTeHandle.CTE_DistribuicaoDFePorUltNSU>();
            var ret = acbrCteBridge.ExecuteMethod(() => method(libHandle, acUFAutor, ToUTF8(eCnpjcpf), ToUTF8(eultNsu), buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc/>
        public string DistribuicaoDFe(int acUFAutor, string eCnpjcpf, string eultNsu, string ArquivoOuXml)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrCteBridge.GetMethod<ACBrCTeHandle.CTE_DistribuicaoDFe>();
            var ret = acbrCteBridge.ExecuteMethod(() => method(libHandle, acUFAutor, ToUTF8(eCnpjcpf), ToUTF8(eultNsu), ToUTF8(ArquivoOuXml), buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc/>
        public string DistribuicaoDFePorNSU(int acUFAutor, string eCnpjcpf, string eNsu)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrCteBridge.GetMethod<ACBrCTeHandle.CTE_DistribuicaoDFePorNSU>();
            var ret = acbrCteBridge.ExecuteMethod(() => method(libHandle, acUFAutor, ToUTF8(eCnpjcpf), ToUTF8(eNsu), buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc/>
        public string DistribuicaoDFePorChave(int acUFAutor, string eCnpjcpf, string echCTe)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrCteBridge.GetMethod<ACBrCTeHandle.CTE_DistribuicaoDFePorChave>();
            var ret = acbrCteBridge.ExecuteMethod(() => method(libHandle, acUFAutor, ToUTF8(eCnpjcpf), ToUTF8(echCTe), buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc/>
        public void EnviarEmail(string ePara, string eArquivoCTe, bool aEnviaPDF, string eAssunto, string eMensagem, string[] eCc = null, string[] eAnexos = null)
        {
            var method = acbrCteBridge.GetMethod<ACBrCTeHandle.CTE_EnviarEmail>();
            var ret = acbrCteBridge.ExecuteMethod(() => method(libHandle, ToUTF8(ePara), ToUTF8(eArquivoCTe), aEnviaPDF, ToUTF8(eAssunto), ToUTF8(eCc == null ? "" : string.Join(";", eCc)),
                                                 ToUTF8(eAnexos == null ? "" : string.Join(";", eAnexos)), ToUTF8(eMensagem.Replace(Environment.NewLine, ";"))));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void EnviarEmailEvento(string ePara, string eArquivoEvento, string eArquivoCTe, bool aEnviaPDF, string eAssunto, string eMensagem, string[] eCc = null, string[] eAnexos = null)
        {
            var method = acbrCteBridge.GetMethod<ACBrCTeHandle.CTE_EnviarEmailEvento>();
            var ret = acbrCteBridge.ExecuteMethod(() => method(libHandle, ToUTF8(ePara), ToUTF8(eArquivoEvento), ToUTF8(eArquivoCTe), aEnviaPDF, ToUTF8(eAssunto), ToUTF8(eCc == null ? "" : string.Join(";", eCc)),
                ToUTF8(eAnexos == null ? "" : string.Join(";", eAnexos)), ToUTF8(eMensagem.Replace(Environment.NewLine, ";"))));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void Imprimir(string cImpressora = "", int nNumCopias = 1, string cProtocolo = "", bool? bMostrarPreview = null)
        {
            var mostrarPreview = bMostrarPreview.HasValue ? $"{Convert.ToInt32(bMostrarPreview.Value)}" : string.Empty;

            var method = acbrCteBridge.GetMethod<ACBrCTeHandle.CTE_Imprimir>();
            var ret = acbrCteBridge.ExecuteMethod(() => method(libHandle, ToUTF8(cImpressora), nNumCopias, ToUTF8(cProtocolo), ToUTF8(mostrarPreview)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void ImprimirPDF()
        {
            var method = acbrCteBridge.GetMethod<ACBrCTeHandle.CTE_ImprimirPDF>();
            var ret = acbrCteBridge.ExecuteMethod(() => method(libHandle));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public async void ImprimirPDF(Stream aStream)
        {
            if (aStream == null) throw new ArgumentNullException(nameof(aStream));

            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrCteBridge.GetMethod<ACBrCTeHandle.CTE_SalvarPDF>();
            var ret = acbrCteBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            var pdf = CheckBuffer(buffer, bufferLen);
            Base64ToStream(pdf, aStream);
        }

        /// <inheritdoc/>
        public void ImprimirEvento(string eArquivoXmlCTe, string eArquivoXmlEvento)
        {
            var method = acbrCteBridge.GetMethod<ACBrCTeHandle.CTE_ImprimirEvento>();
            var ret = acbrCteBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eArquivoXmlCTe), ToUTF8(eArquivoXmlEvento)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void ImprimirEventoPDF(string eArquivoXmlCTe, string eArquivoXmlEvento)
        {
            var method = acbrCteBridge.GetMethod<ACBrCTeHandle.CTE_ImprimirEventoPDF>();
            var ret = acbrCteBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eArquivoXmlCTe), ToUTF8(eArquivoXmlEvento)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void ImprimirInutilizacao(string eArquivoXml)
        {
            var method = acbrCteBridge.GetMethod<ACBrCTeHandle.CTE_ImprimirInutilizacao>();
            var ret = acbrCteBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eArquivoXml)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void ImprimirInutilizacaoPDF(string eArquivoXml)
        {
            var method = acbrCteBridge.GetMethod<ACBrCTeHandle.CTE_ImprimirInutilizacaoPDF>();
            var ret = acbrCteBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eArquivoXml)));

            CheckResult(ret);
        }

        #region Private Methods

        /// <inheritdoc/>
        public override void Finalizar()
        {
            var finalizarLib = acbrCteBridge.GetMethod<ACBrCTeHandle.CTE_Finalizar>();
            var ret = acbrCteBridge.ExecuteMethod(() => finalizarLib(libHandle));
            CheckResult(ret);
            libHandle = IntPtr.Zero;
        }

        protected override string GetUltimoRetorno(int iniBufferLen = 0)
        {
            var bufferLen = iniBufferLen < 1 ? BUFFER_LEN : iniBufferLen;
            var buffer = new StringBuilder(bufferLen);
            var ultimoRetorno = acbrCteBridge.GetMethod<ACBrCTeHandle.CTE_UltimoRetorno>();

            if (iniBufferLen < 1)
            {
                acbrCteBridge.ExecuteMethod(() => ultimoRetorno(libHandle, buffer, ref bufferLen));
                if (bufferLen <= BUFFER_LEN) return FromUTF8(buffer);

                buffer.Capacity = bufferLen;
            }

            acbrCteBridge.ExecuteMethod(() => ultimoRetorno(libHandle, buffer, ref bufferLen));
            return FromUTF8(buffer);
        }

        #endregion Private Methods
        protected void Dispose(bool disposing)
        {
            if (!disposed)
            {
                if (disposing)
                {
                    Finalizar();
                }

                // Dispose unmanaged resources here

                disposed = true;
            }
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
        #endregion Methods
    }
}