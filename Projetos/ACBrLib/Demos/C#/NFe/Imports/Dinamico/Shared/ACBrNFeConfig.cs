using ACBrLib.Core;
using ACBrLib.Core.Config;
using ACBrLib.Core.NFe;

namespace ACBrLib.NFe
{
    /// <summary>
    /// Representa as configurações da biblioteca ACBrLib para NF-e, baseadas na interface IACBrLibNFe.
    /// </summary>
    public sealed class ACBrNFeConfig : ACBrLibDFeConfig<IACBrLibNFe>
    {
        #region Constructors

        /// <summary>
        /// Inicializa uma nova instância da classe de configurações da NF-e.
        /// </summary>
        /// <param name="acbrnfe">Instância da interface IACBrLibNFe utilizada pela configuração.</param>
        public ACBrNFeConfig(IACBrLibNFe acbrnfe) : base(acbrnfe, ACBrSessao.NFe)
        {
            DANFe = new DANFeConfig(acbrnfe);
            PosPrinter = new PosPrinterConfig<IACBrLibNFe>(acbrnfe);
        }

        #endregion Constructors

        #region Properties

        /// <summary>
        /// Retorna configurações da DANFe.
        /// </summary>
        public DANFeConfig DANFe { get; }

        /// <summary>
        /// Retorna configurações da impressão em impressora não fiscal (POS).
        /// </summary>
        public PosPrinterConfig<IACBrLibNFe> PosPrinter { get; }

        /// <summary>
        /// Define o IdCSC para emissão de NFCe.
        /// </summary>
        public string IdCSC
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define o CSC para emissão de NFCe.
        /// </summary>
        public string CSC
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define o modelo de NF-e a ser emitido: 0 = moNFe, 1 = moNFCe.
        /// </summary>
        public ModeloNFe ModeloDF
        {
            get => GetProperty<ModeloNFe>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define a versão da NF-e: 0 = ve200, 1 = ve300, 2 = ve310, 3 = ve400.
        /// </summary>
        public VersaoNFe VersaoDF
        {
            get => GetProperty<VersaoNFe>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se deve ou não atualizar o protocolo do XML quando a NFe é cancelada: 0 = Não, 1 = Sim.
        /// </summary>
        public bool AtualizarXMLCancelado
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define a versão do QrCode da NFCe: 0 = veqr000, 1 = veqr100, 2 = veqr200, 3 = veqr300.
        /// </summary>
        public VersaoQrCode VersaoQRCode
        {
            get => GetProperty<VersaoQrCode>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se devem ser adicionadas as tags de faturamento no XML: 0 = Não, 1 = Sim.
        /// </summary>
        public bool CamposFatObrigatorios
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se devem ou não ser geradas as tags da NT 2018.005: 0 = fgtNunca, 1 = fgtSomenteProducao, 2 = fgtSomenteHomologacao, 3 = fgtSempre.
        /// </summary>
        public TagNT2018005 TagNT2018005
        {
            get => GetProperty<TagNT2018005>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se os eventos de NFe (cancelamento, carta de correção, manifestação) serão salvos: 0 = Não, 1 = Sim.
        /// </summary>
        public bool SalvarEvento
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se somente os XML das NFe processadas (autorizados) serão salvos: 0 = Não, 1 = Sim.
        /// </summary>
        public bool SalvarApenasNFeProcessadas
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se vai levar em consideração a data de emissão da NFe: 0 = Não, 1 = Sim.
        /// </summary>
        public bool EmissaoPathNFe
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se, ao gerar o XML da NF-e, as tags com nomes dos municípios serão normalizadas: 0 = Não, 1 = Sim.
        /// </summary>
        public bool NormatizarMunicipios
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Caminho onde será salvo os XML do NFe.
        /// </summary>
        public string PathNFe
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Caminho onde será salvo os XML do pedido de inutilização de números bem como o retorno.
        /// </summary>
        public string PathInu
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Caminho onde será salvo os XML do envio e retorno de um evento.
        /// </summary>
        public string PathEvento
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Caminho onde está o arquivo TXT para a normatização.
        /// </summary>
        public string PathArquivoMunicipios
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define o id do responsável técnico.
        /// </summary>
        public string IdCSRT
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define o CSRT do responsável técnico.
        /// </summary>
        public string CSRT
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        #endregion Properties
    }
}