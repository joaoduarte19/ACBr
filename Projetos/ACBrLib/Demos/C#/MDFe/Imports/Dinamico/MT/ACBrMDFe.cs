using System;
using System.IO;
using System.Linq;
using System.Text;
using ACBrLib.Core;
using ACBrLib.Core.DFe;
using ACBrLib.Core.Extensions;
using ACBrLib.Core.MDFe;
using static ACBrLib.MDFe.ACBrMDFe;

namespace ACBrLib.MDFe
{
    /// <summary>
    /// Classe de alto nível para integração com a ACBrLibMDFe.
    /// Responsável por encapsular as operações de MDF-e, fornecendo métodos para configuração, envio, consulta, impressão e manipulação de manifestos e eventos.
    /// Herda de <see cref="ACBrLibBase"/> e implementa <see cref="IACBrLibMDFe"/>.
    /// </summary>
    public class ACBrMDFe : ACBrLibBase, IACBrLibMDFe
    {

        private IntPtr libHandle = IntPtr.Zero;
        private readonly ACBrMDFeHandle acbrMDFeBridge;
        private bool disposed = false;
        #region Constructors


        /// <summary>
        /// Inicializa uma nova instância da classe <see cref="ACBrMDFe"/>.
        /// </summary>
        /// <param name="eArqConfig">Caminho do arquivo de configuração INI. Se vazio, utiliza o padrão da biblioteca.</param>
        /// <param name="eChaveCrypt">Chave de criptografia para o arquivo de configuração. Se vazio, utiliza o padrão da biblioteca.</param>
        public ACBrMDFe(string eArqConfig = "", string eChaveCrypt = "") : base(eArqConfig, eChaveCrypt)
        {
            acbrMDFeBridge = ACBrMDFeHandle.Instance;
            Inicializar(eArqConfig, eChaveCrypt);
            Config = new MDFeConfig(this);
        }

        /// <inheritdoc/>
        public override void Inicializar(string eArqConfig = "", string eChaveCrypt = "")
        {
            var inicializarLib = acbrMDFeBridge.GetMethod<ACBrMDFeHandle.MDFE_Inicializar>();
            var ret = acbrMDFeBridge.ExecuteMethod<int>(() => inicializarLib(ref libHandle, ToUTF8(eArqConfig), ToUTF8(eChaveCrypt)));
            CheckResult(ret);
        }

        #endregion Constructors

        #region Properties

        public MDFeConfig Config { get; }

        #endregion Properties

        #region Methods

        #region Ini

        /// <inheritdoc/>
        public override void ConfigGravar(string eArqConfig = "")
        {
            var gravarIni = acbrMDFeBridge.GetMethod<ACBrMDFeHandle.MDFE_ConfigGravar>();
            var ret = acbrMDFeBridge.ExecuteMethod(() => gravarIni(libHandle, ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public override void ConfigLer(string eArqConfig = "")
        {
            var lerIni = acbrMDFeBridge.GetMethod<ACBrMDFeHandle.MDFE_ConfigLer>();
            var ret = acbrMDFeBridge.ExecuteMethod(() => lerIni(libHandle, ToUTF8(eArqConfig)));

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
        public override void ImportarConfig(string eArqConfig = "")
        {
            var importarConfig = acbrMDFeBridge.GetMethod<ACBrMDFeHandle.MDFE_ConfigImportar>();
            var ret = acbrMDFeBridge.ExecuteMethod(() => importarConfig(libHandle, ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public override string ExportarConfig()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrMDFeBridge.GetMethod<ACBrMDFeHandle.MDFE_ConfigExportar>();
            var ret = acbrMDFeBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        #endregion Ini

        /// <inheritdoc/>
        public void CarregarManifesto(Manifesto manifesto) => CarregarINI(manifesto.ToString());

        /// <inheritdoc/>
        public Manifesto ObterManifesto(int aIndex) => Manifesto.Load(ObterIni(aIndex));

        /// <inheritdoc/>
        public void CarregarEvento(EventoMDFeBase evento) => CarregarEventoINI(evento.ToString());

        /// <inheritdoc/>
        public void CarregarXML(string eArquivoOuXml)
        {
            var method = acbrMDFeBridge.GetMethod<ACBrMDFeHandle.MDFE_CarregarXML>();
            var ret = acbrMDFeBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eArquivoOuXml)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void CarregarINI(string eArquivoOuIni)
        {
            var method = acbrMDFeBridge.GetMethod<ACBrMDFeHandle.MDFE_CarregarINI>();
            var ret = acbrMDFeBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eArquivoOuIni)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public string ObterXml(int aIndex)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrMDFeBridge.GetMethod<ACBrMDFeHandle.MDFE_ObterXml>();
            var ret = acbrMDFeBridge.ExecuteMethod(() => method(libHandle, aIndex, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc/>
        public void GravarXml(int aIndex, string eNomeArquivo = "", string ePathArquivo = "")
        {
            var method = acbrMDFeBridge.GetMethod<ACBrMDFeHandle.MDFE_GravarXml>();
            var ret = acbrMDFeBridge.ExecuteMethod(() => method(libHandle, aIndex, ToUTF8(eNomeArquivo), ToUTF8(ePathArquivo)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public string ObterIni(int aIndex)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrMDFeBridge.GetMethod<ACBrMDFeHandle.MDFE_ObterIni>();
            var ret = acbrMDFeBridge.ExecuteMethod(() => method(libHandle, aIndex, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc/>
        public void GravarIni(int aIndex, string eNomeArquivo = "", string ePathArquivo = "")
        {
            var method = acbrMDFeBridge.GetMethod<ACBrMDFeHandle.MDFE_GravarIni>();
            var ret = acbrMDFeBridge.ExecuteMethod(() => method(libHandle, aIndex, ToUTF8(eNomeArquivo), ToUTF8(ePathArquivo)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void CarregarEventoXML(string eArquivoOuXml)
        {
            var method = acbrMDFeBridge.GetMethod<ACBrMDFeHandle.MDFE_CarregarEventoXML>();
            var ret = acbrMDFeBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eArquivoOuXml)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void CarregarEventoINI(string eArquivoOuIni)
        {
            var method = acbrMDFeBridge.GetMethod<ACBrMDFeHandle.MDFE_CarregarEventoINI>();
            var ret = acbrMDFeBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eArquivoOuIni)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void LimparLista()
        {
            var method = acbrMDFeBridge.GetMethod<ACBrMDFeHandle.MDFE_LimparLista>();
            var ret = acbrMDFeBridge.ExecuteMethod(() => method(libHandle));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void LimparListaEventos()
        {
            var method = acbrMDFeBridge.GetMethod<ACBrMDFeHandle.MDFE_LimparListaEventos>();
            var ret = acbrMDFeBridge.ExecuteMethod(() => method(libHandle));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void Assinar()
        {
            var method = acbrMDFeBridge.GetMethod<ACBrMDFeHandle.MDFE_Assinar>();
            var ret = acbrMDFeBridge.ExecuteMethod(() => method(libHandle));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void Validar()
        {
            var method = acbrMDFeBridge.GetMethod<ACBrMDFeHandle.MDFE_Validar>();
            var ret = acbrMDFeBridge.ExecuteMethod(() => method(libHandle));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public string ValidarRegrasdeNegocios()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrMDFeBridge.GetMethod<ACBrMDFeHandle.MDFE_ValidarRegrasdeNegocios>();
            var ret = acbrMDFeBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc/>
        public string VerificarAssinatura()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrMDFeBridge.GetMethod<ACBrMDFeHandle.MDFE_VerificarAssinatura>();
            var ret = acbrMDFeBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc/>
        public string GerarChave(int aCodigoUf, int aCodigoNumerico, int aModelo, int aSerie, int aNumero,
            int aTpEmi, DateTime aEmissao, string acpfcnpj)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrMDFeBridge.GetMethod<ACBrMDFeHandle.MDFE_GerarChave>();
            var ret = acbrMDFeBridge.ExecuteMethod(() => method(libHandle, aCodigoUf, aCodigoNumerico, aModelo, aSerie, aNumero,
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

            var method = acbrMDFeBridge.GetMethod<ACBrMDFeHandle.MDFE_ObterCertificados>();
            var ret = acbrMDFeBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            var certificados = CheckBuffer(buffer, bufferLen).Split(new[] { Environment.NewLine }, StringSplitOptions.RemoveEmptyEntries);
            return certificados.Length == 0 ? new InfoCertificado[0] : certificados.Select(x => new InfoCertificado(x)).ToArray();
        }

        /// <inheritdoc/>
        public override string OpenSSLInfo()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrMDFeBridge.GetMethod<ACBrMDFeHandle.MDFE_OpenSSLInfo>();
            var ret = acbrMDFeBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc/>
        public string GetPath(TipoPathMDFe tipo)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrMDFeBridge.GetMethod<ACBrMDFeHandle.MDFE_GetPath>();
            var ret = acbrMDFeBridge.ExecuteMethod(() => method(libHandle, (int)tipo, buffer, ref bufferLen));

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc/>
        public string GetPathEvento(TipoEventoMDFe evento)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrMDFeBridge.GetMethod<ACBrMDFeHandle.MDFE_GetPathEvento>();
            var ret = acbrMDFeBridge.ExecuteMethod(() => method(libHandle, ToUTF8(evento.GetEnumValueOrInt()), buffer, ref bufferLen));

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc/>
        public StatusServicoResposta StatusServico()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrMDFeBridge.GetMethod<ACBrMDFeHandle.MDFE_StatusServico>();
            var ret = acbrMDFeBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return StatusServicoResposta.LerResposta(CheckBuffer(buffer, bufferLen));
        }

        /// <inheritdoc/>
        public ConsultaMDFeResposta Consultar(string eChaveOuNFe, bool AExtrairEventos = false)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrMDFeBridge.GetMethod<ACBrMDFeHandle.MDFE_Consultar>();
            var ret = acbrMDFeBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eChaveOuNFe), AExtrairEventos, buffer, ref bufferLen));

            CheckResult(ret);

            return ConsultaMDFeResposta.LerResposta(CheckBuffer(buffer, bufferLen));
        }

        /// <inheritdoc/>
        public EnvioRetornoResposta Enviar(int aLote, bool imprimir = false, bool sincrono = false)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrMDFeBridge.GetMethod<ACBrMDFeHandle.MDFE_Enviar>();
            var ret = acbrMDFeBridge.ExecuteMethod(() => method(libHandle, aLote, imprimir, sincrono, buffer, ref bufferLen));

            CheckResult(ret);

            return EnvioRetornoResposta.LerResposta(CheckBuffer(buffer, bufferLen), "MDFe");
        }

        /// <inheritdoc/>
        public RetornoResposta ConsultarRecibo(string aRecibo)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrMDFeBridge.GetMethod<ACBrMDFeHandle.MDFE_ConsultarRecibo>();
            var ret = acbrMDFeBridge.ExecuteMethod(() => method(libHandle, ToUTF8(aRecibo), buffer, ref bufferLen));

            CheckResult(ret);

            return RetornoResposta.LerResposta(CheckBuffer(buffer, bufferLen), "MDFe");
        }

        /// <inheritdoc/>
        public CancelamentoMDFeResposta Cancelar(string eChave, string eJustificativa, string eCNPJ, int aLote)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrMDFeBridge.GetMethod<ACBrMDFeHandle.MDFE_Cancelar>();
            var ret = acbrMDFeBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eChave), ToUTF8(eJustificativa), ToUTF8(eCNPJ), aLote, buffer, ref bufferLen));

            CheckResult(ret);

            return CancelamentoMDFeResposta.LerResposta(CheckBuffer(buffer, bufferLen));
        }

        /// <inheritdoc/>
        public EventoResposta EnviarEvento(int aLote)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrMDFeBridge.GetMethod<ACBrMDFeHandle.MDFE_EnviarEvento>();
            var ret = acbrMDFeBridge.ExecuteMethod(() => method(libHandle, aLote, buffer, ref bufferLen));

            CheckResult(ret);

            return EventoResposta.LerResposta(CheckBuffer(buffer, bufferLen));
        }

        /// <inheritdoc/>
        public EncerramentoResposta EncerrarMDFe(string eChaveOuMDFe, DateTime eDtEnc, string cMunicipioDescarga, string nCNPJ = "", string nProtocolo = "")
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrMDFeBridge.GetMethod<ACBrMDFeHandle.MDFE_EncerrarMDFe>();
            var ret = acbrMDFeBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eChaveOuMDFe), ToUTF8(eDtEnc.ToString("dd/MM/yyyy")), ToUTF8(cMunicipioDescarga),
                                                 ToUTF8(nCNPJ), ToUTF8(nProtocolo), buffer, ref bufferLen));

            CheckResult(ret);

            return EncerramentoResposta.LerResposta(CheckBuffer(buffer, bufferLen));
        }

        /// <inheritdoc/>
        public NaoEncerradosResposta ConsultaMDFeNaoEnc(string cnpj)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrMDFeBridge.GetMethod<ACBrMDFeHandle.MDFE_ConsultaMDFeNaoEnc>();
            var ret = acbrMDFeBridge.ExecuteMethod(() => method(libHandle, ToUTF8(cnpj), buffer, ref bufferLen));

            CheckResult(ret);

            return NaoEncerradosResposta.LerResposta(CheckBuffer(buffer, bufferLen));
        }

        /// <inheritdoc/>
        public DistribuicaoDFeResposta<TipoEventoMDFe> DistribuicaoDFePorUltNSU(string eCnpjcpf, string eultNsu)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrMDFeBridge.GetMethod<ACBrMDFeHandle.MDFE_DistribuicaoDFePorUltNSU>();
            var ret = acbrMDFeBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eCnpjcpf), ToUTF8(eultNsu), buffer, ref bufferLen));

            CheckResult(ret);

            return DistribuicaoDFeResposta<TipoEventoMDFe>.LerResposta(CheckBuffer(buffer, bufferLen));
        }

        /// <inheritdoc/>
        public DistribuicaoDFeResposta<TipoEventoMDFe> DistribuicaoDFePorNSU(string eCnpjcpf, string eNsu)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrMDFeBridge.GetMethod<ACBrMDFeHandle.MDFE_DistribuicaoDFePorNSU>();
            var ret = acbrMDFeBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eCnpjcpf), ToUTF8(eNsu), buffer, ref bufferLen));

            CheckResult(ret);

            return DistribuicaoDFeResposta<TipoEventoMDFe>.LerResposta(CheckBuffer(buffer, bufferLen));
        }

        /// <inheritdoc/>
        public DistribuicaoDFeResposta<TipoEventoMDFe> DistribuicaoDFePorChave(int acUFAutor, string eCnpjcpf, string echNFe)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrMDFeBridge.GetMethod<ACBrMDFeHandle.MDFE_DistribuicaoDFePorChave>();
            var ret = acbrMDFeBridge.ExecuteMethod(() => method(libHandle, acUFAutor, ToUTF8(eCnpjcpf), ToUTF8(echNFe), buffer, ref bufferLen));

            CheckResult(ret);

            return DistribuicaoDFeResposta<TipoEventoMDFe>.LerResposta(CheckBuffer(buffer, bufferLen));
        }

        /// <inheritdoc/>
        public void EnviarEmail(string ePara, string eChaveNFe, bool aEnviaPDF, string eAssunto, string eMensagem, string[] eCc = null, string[] eAnexos = null)
        {
            var method = acbrMDFeBridge.GetMethod<ACBrMDFeHandle.MDFE_EnviarEmail>();
            var ret = acbrMDFeBridge.ExecuteMethod(() => method(libHandle, ToUTF8(ePara), ToUTF8(eChaveNFe), aEnviaPDF, ToUTF8(eAssunto), ToUTF8(eCc == null ? "" : string.Join(";", eCc)),
                                                 ToUTF8(eAnexos == null ? "" : string.Join(";", eAnexos)), ToUTF8(eMensagem.Replace(Environment.NewLine, ";"))));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void EnviarEmailEvento(string ePara, string eChaveEvento, string eChaveNFe, bool aEnviaPDF, string eAssunto, string eMensagem, string[] eCc = null, string[] eAnexos = null)
        {
            var method = acbrMDFeBridge.GetMethod<ACBrMDFeHandle.MDFE_EnviarEmailEvento>();
            var ret = acbrMDFeBridge.ExecuteMethod(() => method(libHandle, ToUTF8(ePara), ToUTF8(eChaveEvento), ToUTF8(eChaveNFe), aEnviaPDF, ToUTF8(eAssunto), ToUTF8(eCc == null ? "" : string.Join(";", eCc)),
                ToUTF8(eAnexos == null ? "" : string.Join(";", eAnexos)), ToUTF8(eMensagem.Replace(Environment.NewLine, ";"))));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void Imprimir(string cImpressora = "", int nNumCopias = 1, string cProtocolo = "", bool? bMostrarPreview = null)
        {
            var mostrarPreview = bMostrarPreview.HasValue ? $"{Convert.ToInt32(bMostrarPreview.Value)}" : string.Empty;

            var method = acbrMDFeBridge.GetMethod<ACBrMDFeHandle.MDFE_Imprimir>();
            var ret = acbrMDFeBridge.ExecuteMethod(() => method(libHandle, ToUTF8(cImpressora), nNumCopias, ToUTF8(cProtocolo), ToUTF8(mostrarPreview)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void ImprimirPDF()
        {
            var method = acbrMDFeBridge.GetMethod<ACBrMDFeHandle.MDFE_ImprimirPDF>();
            var ret = acbrMDFeBridge.ExecuteMethod(() => method(libHandle));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public async void ImprimirPDF(Stream aStream)
        {
            if (aStream == null) throw new ArgumentNullException(nameof(aStream));

            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrMDFeBridge.GetMethod<ACBrMDFeHandle.MDFE_SalvarPDF>();
            var ret = acbrMDFeBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            var pdf = CheckBuffer(buffer, bufferLen);
            Base64ToStream(pdf, aStream);
        }

        /// <inheritdoc/>
        public void ImprimirEvento(string eArquivoXmlNFe, string eArquivoXmlEvento)
        {
            var method = acbrMDFeBridge.GetMethod<ACBrMDFeHandle.MDFE_ImprimirEvento>();
            var ret = acbrMDFeBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eArquivoXmlNFe), ToUTF8(eArquivoXmlEvento)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void ImprimirEventoPDF(string eArquivoXmlNFe, string eArquivoXmlEvento)
        {
            var method = acbrMDFeBridge.GetMethod<ACBrMDFeHandle.MDFE_ImprimirEventoPDF>();
            var ret = acbrMDFeBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eArquivoXmlNFe), ToUTF8(eArquivoXmlEvento)));

            CheckResult(ret);
        }

        #region Private Methods
        /// <inheritdoc/>
        public override void Finalizar()
        {
            var finalizarLib = acbrMDFeBridge.GetMethod<ACBrMDFeHandle.MDFE_Finalizar>();
            var ret = acbrMDFeBridge.ExecuteMethod(() => finalizarLib(libHandle));
            CheckResult(ret);
            libHandle = IntPtr.Zero;
        }

        /// <inheritdoc/>
        protected override string GetUltimoRetorno(int iniBufferLen = 0)
        {
            var bufferLen = iniBufferLen < 1 ? BUFFER_LEN : iniBufferLen;
            var buffer = new StringBuilder(bufferLen);
            var ultimoRetorno = acbrMDFeBridge.GetMethod<ACBrMDFeHandle.MDFE_UltimoRetorno>();

            if (iniBufferLen < 1)
            {
                acbrMDFeBridge.ExecuteMethod(() => ultimoRetorno(libHandle, buffer, ref bufferLen));
                if (bufferLen <= BUFFER_LEN) return FromUTF8(buffer);

                buffer.Capacity = bufferLen;
            }

            acbrMDFeBridge.ExecuteMethod(() => ultimoRetorno(libHandle, buffer, ref bufferLen));
            return FromUTF8(buffer);
        }

        /// <inheritdoc/>
        public override string ConfigLerValor(string eSessao, string eChave)
        {
            var method = acbrMDFeBridge.GetMethod<ACBrMDFeHandle.MDFE_ConfigLerValor>();

            var bufferLen = BUFFER_LEN;
            var pValue = new StringBuilder(bufferLen);
            var ret = acbrMDFeBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eSessao), ToUTF8(eChave), pValue, ref bufferLen));
            CheckResult(ret);

            return CheckBuffer(pValue, bufferLen);
        }

        /// <inheritdoc/>
        public override void ConfigGravarValor(string eSessao, string eChave, string eValor)
        {
            var method = acbrMDFeBridge.GetMethod<ACBrMDFeHandle.MDFE_ConfigGravarValor>();
            var ret = acbrMDFeBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eSessao), ToUTF8(eChave), ToUTF8(eValor)));
            CheckResult(ret);
        }

        /// <inheritdoc/>
        public override string Versao()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrMDFeBridge.GetMethod<ACBrMDFeHandle.MDFE_Versao>();
            var ret = acbrMDFeBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc/>
        public override string Nome()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrMDFeBridge.GetMethod<ACBrMDFeHandle.MDFE_Nome>();
            var ret = acbrMDFeBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        #endregion Private Methods


        /// <inheritdoc/>
        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        /// <inheritdoc/>
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