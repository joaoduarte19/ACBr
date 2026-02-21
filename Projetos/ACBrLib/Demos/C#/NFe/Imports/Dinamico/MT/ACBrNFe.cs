using System;
using System.IO;
using System.Linq;
using System.Text;
using ACBrLib.Core;
using ACBrLib.Core.DFe;
using ACBrLib.Core.NFe;

namespace ACBrLib.NFe
{

    /// <summary>
    /// Classe principal da biblioteca ACBrLibNFe, responsável por fornecer os métodos e propriedades para manipulação de notas fiscais eletrônicas (NFe) utilizando a biblioteca ACBrLib em C#.
    /// Implementa a interface IACBrLibNFe.
    /// </summary>
    public class ACBrNFe : ACBrLibBase, IACBrLibNFe
    {


        private readonly ACBrNFeHandle nfeBridge;
        private IntPtr libHandle = IntPtr.Zero;
        private bool disposed = false;
        #region Constructors


        /// <summary>
        /// Construtor da classe ACBrNFe, responsável por inicializar a biblioteca e carregar as configurações iniciais, se fornecidas.
        /// </summary>
        /// <param name="eArqConfig">Caminho do arquivo de configuração (opcional).</param>
        /// <param name="eChaveCrypt">Chave de criptografia para o arquivo de configuração (opcional).</param>
        public ACBrNFe(string eArqConfig = "", string eChaveCrypt = "") : base(eArqConfig, eChaveCrypt)
        {
            nfeBridge = ACBrNFeHandle.Instance;
            Inicializar(eArqConfig, eChaveCrypt);
            Config = new ACBrNFeConfig(this);
        }
        /// <inheritdoc/>
        public override void Inicializar(string eArqConfig = "", string eChaveCrypt = "")
        {
            var inicializarLib = nfeBridge.GetMethod<ACBrNFeHandle.NFE_Inicializar>();
            var ret = nfeBridge.ExecuteMethod<int>(() => inicializarLib(ref libHandle, ToUTF8(eArqConfig), ToUTF8(eChaveCrypt)));
            CheckResult(ret);
        }

        #endregion Constructors

        #region Properties


        /// <inheritdoc/>
        public ACBrNFeConfig Config { get; }

        #endregion Properties

        #region Methods

        #region Ini
        
        /// <inheritdoc/>
        public override void ConfigGravar(string eArqConfig = "")
        {
            var gravarIni = nfeBridge.GetMethod<ACBrNFeHandle.NFE_ConfigGravar>();
            var ret = nfeBridge.ExecuteMethod(() => gravarIni(libHandle, ToUTF8(eArqConfig)));

            CheckResult(ret);
        }
        /// <inheritdoc/>
        public override void ConfigLer(string eArqConfig = "")
        {
            var lerIni = nfeBridge.GetMethod<ACBrNFeHandle.NFE_ConfigLer>();
            var ret = nfeBridge.ExecuteMethod(() => lerIni(libHandle, ToUTF8(eArqConfig)));

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
        /// <inheritdoc/>
        public override void ImportarConfig(string eArqConfig)
        {
            var importarConfig = nfeBridge.GetMethod<ACBrNFeHandle.NFE_ConfigImportar>();
            var ret = nfeBridge.ExecuteMethod(() => importarConfig(libHandle, ToUTF8(eArqConfig)));

            CheckResult(ret);
        }
        /// <inheritdoc/>
        public override string ExportarConfig()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = nfeBridge.GetMethod<ACBrNFeHandle.NFE_ConfigExportar>();
            var ret = nfeBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        #endregion Ini

        /// <inheritdoc/>
        public void CarregarNota(NotaFiscal nfe) => CarregarINI(nfe.ToString());

        /// <inheritdoc/>
        public NotaFiscal ObterNFe(int aIndex) => NotaFiscal.Load(ObterIni(aIndex));

        /// <inheritdoc/>
        public void CarregarEvento(EventoNFeBase evento) => CarregarEventoINI(evento.ToString());

        /// <inheritdoc/>
        public void CarregarXML(string eArquivoOuXml)
        {
            var method = nfeBridge.GetMethod<ACBrNFeHandle.NFE_CarregarXML>();
            var ret = nfeBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eArquivoOuXml)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void CarregarINI(string eArquivoOuIni)
        {
            var method = nfeBridge.GetMethod<ACBrNFeHandle.NFE_CarregarINI>();
            var ret = nfeBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eArquivoOuIni)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public string ObterXml(int aIndex)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = nfeBridge.GetMethod<ACBrNFeHandle.NFE_ObterXml>();
            var ret = nfeBridge.ExecuteMethod(() => method(libHandle, aIndex, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc/>
        public void GravarXml(int aIndex, string eNomeArquivo = "", string ePathArquivo = "")
        {
            var method = nfeBridge.GetMethod<ACBrNFeHandle.NFE_GravarXml>();
            var ret = nfeBridge.ExecuteMethod(() => method(libHandle, aIndex, ToUTF8(eNomeArquivo), ToUTF8(ePathArquivo)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public string ObterIni(int aIndex)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = nfeBridge.GetMethod<ACBrNFeHandle.NFE_ObterIni>();
            var ret = nfeBridge.ExecuteMethod(() => method(libHandle, aIndex, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc/>
        public void GravarIni(int aIndex, string eNomeArquivo = "", string ePathArquivo = "")
        {
            var method = nfeBridge.GetMethod<ACBrNFeHandle.NFE_GravarIni>();
            var ret = nfeBridge.ExecuteMethod(() => method(libHandle, aIndex, ToUTF8(eNomeArquivo), ToUTF8(ePathArquivo)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void CarregarEventoXML(string eArquivoOuXml)
        {
            var method = nfeBridge.GetMethod<ACBrNFeHandle.NFE_CarregarEventoXML>();
            var ret = nfeBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eArquivoOuXml)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void CarregarEventoINI(string eArquivoOuIni)
        {
            var method = nfeBridge.GetMethod<ACBrNFeHandle.NFE_CarregarEventoINI>();
            var ret = nfeBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eArquivoOuIni)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void LimparLista()
        {
            var method = nfeBridge.GetMethod<ACBrNFeHandle.NFE_LimparLista>();
            var ret = nfeBridge.ExecuteMethod(() => method(libHandle));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void LimparListaEventos()
        {
            var method = nfeBridge.GetMethod<ACBrNFeHandle.NFE_LimparListaEventos>();
            var ret = nfeBridge.ExecuteMethod(() => method(libHandle));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void Assinar()
        {
            var method = nfeBridge.GetMethod<ACBrNFeHandle.NFE_Assinar>();
            var ret = nfeBridge.ExecuteMethod(() => method(libHandle));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void Validar()
        {
            var method = nfeBridge.GetMethod<ACBrNFeHandle.NFE_Validar>();
            var ret = nfeBridge.ExecuteMethod(() => method(libHandle));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public string ValidarRegrasdeNegocios()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = nfeBridge.GetMethod<ACBrNFeHandle.NFE_ValidarRegrasdeNegocios>();
            var ret = nfeBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc/>
        public string VerificarAssinatura()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = nfeBridge.GetMethod<ACBrNFeHandle.NFE_VerificarAssinatura>();
            var ret = nfeBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc/>
        public string GerarChave(int aCodigoUf, int aCodigoNumerico, int aModelo, int aSerie, int aNumero,
            int aTpEmi, DateTime aEmissao, string acpfcnpj)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = nfeBridge.GetMethod<ACBrNFeHandle.NFE_GerarChave>();
            var ret = nfeBridge.ExecuteMethod(() => method(libHandle, aCodigoUf, aCodigoNumerico, aModelo, aSerie, aNumero,
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

            var method = nfeBridge.GetMethod<ACBrNFeHandle.NFE_ObterCertificados>();
            var ret = nfeBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            var certificados = CheckBuffer(buffer, bufferLen).Split(new[] { Environment.NewLine }, StringSplitOptions.RemoveEmptyEntries);
            return certificados.Length == 0 ? new InfoCertificado[0] : certificados.Select(x => new InfoCertificado(x)).ToArray();
        }

        /// <inheritdoc/>
        public override string OpenSSLInfo()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = nfeBridge.GetMethod<ACBrNFeHandle.NFE_OpenSSLInfo>();
            var ret = nfeBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc/>
        public string GetPath(TipoPathNFe tipo)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = nfeBridge.GetMethod<ACBrNFeHandle.NFE_GetPath>();
            var ret = nfeBridge.ExecuteMethod(() => method(libHandle, (int)tipo, buffer, ref bufferLen));

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc/>
        public string GetPathEvento(string evento)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = nfeBridge.GetMethod<ACBrNFeHandle.NFE_GetPathEvento>();
            var ret = nfeBridge.ExecuteMethod(() => method(libHandle, ToUTF8(evento), buffer, ref bufferLen));

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc/>
        public StatusServicoResposta StatusServico()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = nfeBridge.GetMethod<ACBrNFeHandle.NFE_StatusServico>();
            var ret = nfeBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return StatusServicoResposta.LerResposta(CheckBuffer(buffer, bufferLen));
        }

        /// <inheritdoc/>
        public ConsultaNFeResposta Consultar(string eChaveOuNFe, bool AExtrairEventos = false)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = nfeBridge.GetMethod<ACBrNFeHandle.NFE_Consultar>();
            var ret = nfeBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eChaveOuNFe), AExtrairEventos, buffer, ref bufferLen));

            CheckResult(ret);

            return ConsultaNFeResposta.LerResposta(CheckBuffer(buffer, bufferLen));
        }

        /// <inheritdoc/>
        public ConsultaCadastroResposta ConsultaCadastro(string cUF, string nDocumento, bool nIE)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = nfeBridge.GetMethod<ACBrNFeHandle.NFE_ConsultaCadastro>();
            var ret = nfeBridge.ExecuteMethod(() => method(libHandle, ToUTF8(cUF), ToUTF8(nDocumento), nIE, buffer, ref bufferLen));

            CheckResult(ret);

            return ConsultaCadastroResposta.LerResposta(CheckBuffer(buffer, bufferLen));
        }

        /// <inheritdoc/>
        public InutilizarNFeResposta Inutilizar(string acnpj, string aJustificativa, int ano, int modelo,
            int serie, int numeroInicial, int numeroFinal)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = nfeBridge.GetMethod<ACBrNFeHandle.NFE_Inutilizar>();
            var ret = nfeBridge.ExecuteMethod(() => method(libHandle, ToUTF8(acnpj), ToUTF8(aJustificativa), ano, modelo, serie, numeroInicial, numeroFinal, buffer, ref bufferLen));

            CheckResult(ret);

            return InutilizarNFeResposta.LerResposta(CheckBuffer(buffer, bufferLen));
        }

        /// <inheritdoc/>
        public EnvioRetornoResposta Enviar(int aLote, bool imprimir = false, bool sincrono = false, bool zipado = false)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = nfeBridge.GetMethod<ACBrNFeHandle.NFE_Enviar>();
            var ret = nfeBridge.ExecuteMethod(() => method(libHandle, aLote, imprimir, sincrono, zipado, buffer, ref bufferLen));

            CheckResult(ret);

            return EnvioRetornoResposta.LerResposta(CheckBuffer(buffer, bufferLen), "NFe");
        }

        /// <inheritdoc/>
        public RetornoResposta ConsultarRecibo(string aRecibo)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = nfeBridge.GetMethod<ACBrNFeHandle.NFE_ConsultarRecibo>();
            var ret = nfeBridge.ExecuteMethod(() => method(libHandle, ToUTF8(aRecibo), buffer, ref bufferLen));

            CheckResult(ret);

            return RetornoResposta.LerResposta(CheckBuffer(buffer, bufferLen), "NFe");
        }

        /// <inheritdoc/>
        public CancelamentoNFeResposta Cancelar(string eChave, string eJustificativa, string eCNPJ, int aLote)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = nfeBridge.GetMethod<ACBrNFeHandle.NFE_Cancelar>();
            var ret = nfeBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eChave), ToUTF8(eJustificativa), ToUTF8(eCNPJ), aLote, buffer, ref bufferLen));

            CheckResult(ret);

            return CancelamentoNFeResposta.LerResposta(CheckBuffer(buffer, bufferLen));
        }

        /// <inheritdoc/>
        public EventoResposta EnviarEvento(int aLote)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = nfeBridge.GetMethod<ACBrNFeHandle.NFE_EnviarEvento>();
            var ret = nfeBridge.ExecuteMethod(() => method(libHandle, aLote, buffer, ref bufferLen));

            CheckResult(ret);

            return EventoResposta.LerResposta(CheckBuffer(buffer, bufferLen));
        }

        /// <inheritdoc/>
        public DistribuicaoDFeResposta<TipoEventoNFe> DistribuicaoDFePorUltNSU(int acUFAutor, string eCnpjcpf, string eultNsu)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = nfeBridge.GetMethod<ACBrNFeHandle.NFE_DistribuicaoDFePorUltNSU>();
            var ret = nfeBridge.ExecuteMethod(() => method(libHandle, acUFAutor, ToUTF8(eCnpjcpf), ToUTF8(eultNsu), buffer, ref bufferLen));

            CheckResult(ret);

            return DistribuicaoDFeResposta<TipoEventoNFe>.LerResposta(CheckBuffer(buffer, bufferLen));
        }

        /// <inheritdoc/>
        public DistribuicaoDFeResposta<TipoEventoNFe> DistribuicaoDFe(int acUFAutor, string eCnpjcpf, string eultNsu, string ArquivoOuXml)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = nfeBridge.GetMethod<ACBrNFeHandle.NFE_DistribuicaoDFe>();
            var ret = nfeBridge.ExecuteMethod(() => method(libHandle, acUFAutor, ToUTF8(eCnpjcpf), ToUTF8(eultNsu), ToUTF8(ArquivoOuXml), buffer, ref bufferLen));

            CheckResult(ret);

            return DistribuicaoDFeResposta<TipoEventoNFe>.LerResposta(CheckBuffer(buffer, bufferLen));
        }

        /// <inheritdoc/>
        public DistribuicaoDFeResposta<TipoEventoNFe> DistribuicaoDFePorNSU(int acUFAutor, string eCnpjcpf, string eNsu)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = nfeBridge.GetMethod<ACBrNFeHandle.NFE_DistribuicaoDFePorNSU>();
            var ret = nfeBridge.ExecuteMethod(() => method(libHandle, acUFAutor, ToUTF8(eCnpjcpf), ToUTF8(eNsu), buffer, ref bufferLen));

            CheckResult(ret);

            return DistribuicaoDFeResposta<TipoEventoNFe>.LerResposta(CheckBuffer(buffer, bufferLen));
        }

        /// <inheritdoc/>
        public DistribuicaoDFeResposta<TipoEventoNFe> DistribuicaoDFePorChave(int acUFAutor, string eCnpjcpf, string echNFe)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = nfeBridge.GetMethod<ACBrNFeHandle.NFE_DistribuicaoDFePorChave>();
            var ret = nfeBridge.ExecuteMethod(() => method(libHandle, acUFAutor, ToUTF8(eCnpjcpf), ToUTF8(echNFe), buffer, ref bufferLen));

            CheckResult(ret);

            return DistribuicaoDFeResposta<TipoEventoNFe>.LerResposta(CheckBuffer(buffer, bufferLen));
        }

        /// <inheritdoc/>
        public void EnviarEmail(string ePara, string eChaveNFe, bool aEnviaPDF, string eAssunto, string eMensagem, string[] eCc = null, string[] eAnexos = null)
        {
            var method = nfeBridge.GetMethod<ACBrNFeHandle.NFE_EnviarEmail>();
            var ret = nfeBridge.ExecuteMethod(() => method(libHandle, ToUTF8(ePara), ToUTF8(eChaveNFe), aEnviaPDF, ToUTF8(eAssunto), ToUTF8(eCc == null ? "" : string.Join(";", eCc)),
                                                 ToUTF8(eAnexos == null ? "" : string.Join(";", eAnexos)), ToUTF8(eMensagem.Replace(Environment.NewLine, ";"))));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void EnviarEmailEvento(string ePara, string eChaveEvento, string eChaveNFe, bool aEnviaPDF, string eAssunto, string eMensagem, string[] eCc = null, string[] eAnexos = null)
        {
            var method = nfeBridge.GetMethod<ACBrNFeHandle.NFE_EnviarEmailEvento>();
            var ret = nfeBridge.ExecuteMethod(() => method(libHandle, ToUTF8(ePara), ToUTF8(eChaveEvento), ToUTF8(eChaveNFe), aEnviaPDF, ToUTF8(eAssunto), ToUTF8(eCc == null ? "" : string.Join(";", eCc)),
                ToUTF8(eAnexos == null ? "" : string.Join(";", eAnexos)), ToUTF8(eMensagem.Replace(Environment.NewLine, ";"))));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void Imprimir(string cImpressora = "", int nNumCopias = 1, string cProtocolo = "", bool? bMostrarPreview = null, bool? cMarcaDagua = null,
            bool? bViaConsumidor = null, bool? bSimplificado = null)
        {
            var mostrarPreview = bMostrarPreview.HasValue ? $"{Convert.ToInt32(bMostrarPreview.Value)}" : string.Empty;
            var marcaDagua = cMarcaDagua.HasValue ? $"{Convert.ToInt32(cMarcaDagua.Value)}" : string.Empty;
            var viaConsumidor = bViaConsumidor.HasValue ? $"{Convert.ToInt32(bViaConsumidor.Value)}" : string.Empty;
            var simplificado = bSimplificado.HasValue ? $"{Convert.ToInt32(bSimplificado.Value)}" : string.Empty;

            var method = nfeBridge.GetMethod<ACBrNFeHandle.NFE_Imprimir>();
            var ret = nfeBridge.ExecuteMethod(() => method(libHandle, ToUTF8(cImpressora), nNumCopias, ToUTF8(cProtocolo), ToUTF8(mostrarPreview),
                ToUTF8(marcaDagua), ToUTF8(viaConsumidor), ToUTF8(simplificado)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void ImprimirPDF()
        {
            var method = nfeBridge.GetMethod<ACBrNFeHandle.NFE_ImprimirPDF>();
            var ret = nfeBridge.ExecuteMethod(() => method(libHandle));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void ImprimirPDF(Stream aStream)
        {
            if (aStream == null) throw new ArgumentNullException(nameof(aStream));

            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = nfeBridge.GetMethod<ACBrNFeHandle.NFE_SalvarPDF>();
            var ret = nfeBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            var pdf = CheckBuffer(buffer, bufferLen);
            Base64ToStream(pdf, aStream);
        }

        /// <inheritdoc/>
        public void ImprimirEvento(string eArquivoXmlNFe, string eArquivoXmlEvento)
        {
            var method = nfeBridge.GetMethod<ACBrNFeHandle.NFE_ImprimirEvento>();
            var ret = nfeBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eArquivoXmlNFe), ToUTF8(eArquivoXmlEvento)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void ImprimirEventoPDF(string eArquivoXmlNFe, string eArquivoXmlEvento)
        {
            var method = nfeBridge.GetMethod<ACBrNFeHandle.NFE_ImprimirEventoPDF>();
            var ret = nfeBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eArquivoXmlNFe), ToUTF8(eArquivoXmlEvento)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void ImprimirEventoPDF(string eArquivoXmlNFe, string eArquivoXmlEvento, Stream aStream)
        {
            if (aStream == null) throw new ArgumentNullException(nameof(aStream));

            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = nfeBridge.GetMethod<ACBrNFeHandle.NFE_SalvarEventoPDF>();
            var ret = nfeBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eArquivoXmlNFe), ToUTF8(eArquivoXmlEvento), buffer, ref bufferLen));

            CheckResult(ret);

            var pdf = CheckBuffer(buffer, bufferLen);
            Base64ToStream(pdf, aStream);
        }

        /// <inheritdoc/>
        public void ImprimirInutilizacao(string eArquivoXml)
        {
            var method = nfeBridge.GetMethod<ACBrNFeHandle.NFE_ImprimirInutilizacao>();
            var ret = nfeBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eArquivoXml)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void ImprimirInutilizacaoPDF(string eArquivoXml)
        {
            var method = nfeBridge.GetMethod<ACBrNFeHandle.NFE_ImprimirInutilizacaoPDF>();
            var ret = nfeBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eArquivoXml)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void ImprimirInutilizacaoPDF(string eArquivoXml, Stream aStream)
        {
            if (aStream == null) throw new ArgumentNullException(nameof(aStream));

            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = nfeBridge.GetMethod<ACBrNFeHandle.NFE_SalvarInutilizacaoPDF>();
            var ret = nfeBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eArquivoXml), buffer, ref bufferLen));

            CheckResult(ret);

            var pdf = CheckBuffer(buffer, bufferLen);
            Base64ToStream(pdf, aStream);
        }

        #region Private Methods

        /// <inheritdoc/>
        public override void Finalizar()
        {
            var finalizarLib = nfeBridge.GetMethod<ACBrNFeHandle.NFE_Finalizar>();
            var codRet = nfeBridge.ExecuteMethod(() => finalizarLib(libHandle));
            CheckResult(codRet);
            libHandle = IntPtr.Zero;
        }

        /// <inheritdoc/>
        protected override string GetUltimoRetorno(int iniBufferLen = 0)
        {
            var bufferLen = iniBufferLen < 1 ? BUFFER_LEN : iniBufferLen;
            var buffer = new StringBuilder(bufferLen);
            var ultimoRetorno = nfeBridge.GetMethod<ACBrNFeHandle.NFE_UltimoRetorno>();

            if (iniBufferLen < 1)
            {
                nfeBridge.ExecuteMethod(() => ultimoRetorno(libHandle, buffer, ref bufferLen));
                if (bufferLen <= BUFFER_LEN) return FromUTF8(buffer);

                buffer.Capacity = bufferLen;
            }

            nfeBridge.ExecuteMethod(() => ultimoRetorno(libHandle, buffer, ref bufferLen));
            return FromUTF8(buffer);
        }

        #endregion Private Methods

        /// <inheritdoc/>
        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        /// <inheritdoc/>
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

        /// <inheritdoc/>
        public override string ConfigLerValor(string eSessao, string eChave)
        {
            var method = nfeBridge.GetMethod<ACBrNFeHandle.NFE_ConfigLerValor>();
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);
            var ret = nfeBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eSessao), ToUTF8(eChave), buffer, ref bufferLen));
            CheckResult(ret);
            return CheckBuffer(buffer, bufferLen);

        }

        /// <inheritdoc/>
        public override void ConfigGravarValor(string eSessao, string eChave, string eValor)
        {
            var method = nfeBridge.GetMethod<ACBrNFeHandle.NFE_ConfigGravarValor>();
            var ret = nfeBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eSessao), ToUTF8(eChave), ToUTF8(eValor)));
            CheckResult(ret);
        }

        /// <inheritdoc/>
        public override string Versao()
        {
            var method = nfeBridge.GetMethod<ACBrNFeHandle.NFE_Versao>();
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);
            var ret = nfeBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));
            CheckResult(ret);
            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc/>
        public override string Nome()
        {
            var method = nfeBridge.GetMethod<ACBrNFeHandle.NFE_Nome>();
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);
            var ret = nfeBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));
            CheckResult(ret);
            return CheckBuffer(buffer, bufferLen);
        }

        #endregion Methods
    }
}