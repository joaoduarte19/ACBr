using ACBrLib.Core;
using ACBrLib.Core.Config;
using ACBrLib.Core.NFe;

namespace ACBrLib.NFe
{
    /// <summary>
    /// Representa as configurações gerais de impressão da DANFE, baseadas na interface IACBrLibNFe.
    /// </summary>
    public sealed class DANFeConfig : ReportConfig<IACBrLibNFe>
    {
        #region Constructors

        /// <summary>
        /// Inicializa uma nova instância da classe de configurações da DANFE.
        /// </summary>
        /// <param name="acbrlib">Instância da interface IACBrLibNFe utilizada pela configuração.</param>
        public DANFeConfig(IACBrLibNFe acbrlib) : base(acbrlib, ACBrSessao.DANFE)
        {
            NFe = new DANFeNFeConfig(acbrlib);
            NFCe = new DANFeNFCeConfig(acbrlib);
        }

        #endregion Constructors

        #region Properties

        /// <summary>
        /// Retorna configurações específicas da DANFE para NF-e.
        /// </summary>
        public DANFeNFeConfig NFe { get; }

        /// <summary>
        /// Retorna configurações específicas da DANFE para NFC-e.
        /// </summary>
        public DANFeNFCeConfig NFCe { get; }

        /// <summary>
        /// Define o tipo de DANFE que será impresso: 0 = tiSemGeracao, 1 = tiRetrato, 2 = tiPaisagem, 3 = tiSimplificado, 4 = tiNFCe, 5 = tiMsgEletronica.
        /// </summary>
        public TipoDANFE TipoDANFE
        {
            get => GetProperty<TipoDANFE>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se deve imprimir o total líquido.
        /// </summary>
        public bool ImprimeTotalLiquido
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define o valor de tributos federais que será impresso.
        /// </summary>
        public decimal vTribFed
        {
            get => GetProperty<decimal>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define o valor de tributos estaduais que será impresso.
        /// </summary>
        public decimal vTribEst
        {
            get => GetProperty<decimal>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define o valor de tributos municipais que será impresso.
        /// </summary>
        public decimal vTribMun
        {
            get => GetProperty<decimal>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define a fonte dos tributos.
        /// </summary>
        public string FonteTributos
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define a chave de tributos para ser impressa.
        /// </summary>
        public string ChaveTributos
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se deve imprimir tributos: 0 = trbNenhum, 1 = trbNormal, 2 = trbSeparadamente.
        /// </summary>
        public ImprimeTributos ImprimeTributos
        {
            get => GetProperty<ImprimeTributos>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se deve exibir o total de tributos por item.
        /// </summary>
        public bool ExibeTotalTributosItem
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se deve imprimir o código EAN, quando disponível, em vez do código do produto.
        /// </summary>
        public bool ImprimeCodigoEan
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define como devem ser exibidas as informações adicionais do produto: 0 = infNenhum, 1 = infDescricao, 2 = infSeparadamente.
        /// </summary>
        public ExibeInfoAdicProduto ExibeInforAdicProduto
        {
            get => GetProperty<ExibeInfoAdicProduto>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se deve ou não quebrar a linha nos detalhamentos: 0 = Não, 1 = Sim.
        /// </summary>
        public bool QuebraLinhaEmDetalhamentos
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se deve ou não usar o nome fantasia da empresa na impressão: 0 = Não, 1 = Sim.
        /// </summary>
        public bool ImprimeNomeFantasia
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se deve imprimir a DANFE com a tarja de cancelada: 0 = Não, 1 = Sim.
        /// </summary>
        public bool Cancelada
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define o protocolo a ser impresso na DANFE.
        /// </summary>
        public string Protocolo
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        #endregion Properties
    }
}