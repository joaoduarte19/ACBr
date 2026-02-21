using ACBrLib.Core;
using ACBrLib.Core.Config;
using ACBrLib.Core.NFe;

namespace ACBrLib.NFe
{
    /// <summary>
    /// Representa as configurações de impressão da DANFE para NFC-e, baseadas na interface IACBrLibNFe.
    /// </summary>
    public sealed class DANFeNFCeConfig : ACBrLibConfigBase<IACBrLibNFe>
    {
        #region Constructors

        /// <summary>
        /// Inicializa uma nova instância da classe de configurações da DANFE NFC-e.
        /// </summary>
        /// <param name="acbrlib">Instância da interface IACBrLibNFe utilizada pela configuração.</param>
        public DANFeNFCeConfig(IACBrLibNFe acbrlib) : base(acbrlib, ACBrSessao.DANFENFCe)
        {
            Fonte = new FonteDANFCeConfig(acbrlib, ACBrSessao.DANFENFCe);
        }

        #endregion Constructors

        #region Properties

        /// <summary>
        /// Define o tipo de impressão da NFCe: 0 = tpFortes, 1 = tpEscPos, 2 = tpFortesA4.
        /// </summary>
        public TipoRelatorioBobina TipoRelatorioBobina
        {
            get => GetProperty<TipoRelatorioBobina>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define o tipo de impressão dos eventos da NFCe: 0 = evA4, 1 = evBobina.
        /// </summary>
        public TipoRelatorioEvento TipoRelatorioEvento
        {
            get => GetProperty<TipoRelatorioEvento>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define a largura da bobina de impressão.
        /// </summary>
        public int LarguraBobina
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se deve ou não imprimir os descontos e acréscimos dos itens.
        /// </summary>
        public bool ImprimeDescAcrescItem
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se deve imprimir os itens da NFCe.
        /// </summary>
        public bool ImprimeItens
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se a via a ser impressa é a do consumidor.
        /// </summary>
        public bool ViaConsumidor
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define o valor do troco para impressão.
        /// </summary>
        public decimal vTroco
        {
            get => GetProperty<decimal>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se deve utilizar o QrCode lateral.
        /// </summary>
        public bool ImprimeQRCodeLateral
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se deve utilizar o logo lateral.
        /// </summary>
        public bool ImprimeLogoLateral
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define a quantidade de espaço no fim da impressão.
        /// </summary>
        public int EspacoFinal
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define a altura do logo para impressão.
        /// </summary>
        public int TamanhoLogoHeight
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define a largura do logo para impressão.
        /// </summary>
        public int TamanhoLogoWidth
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define quais campos das informações dos pagamentos devem ser exibidas.
        /// </summary>
        public DescricaoPagamentos DescricaoPagamentos
        {
            get => GetProperty<DescricaoPagamentos>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se deve ou não imprimir os dados dos itens em apenas uma linha.
        /// </summary>
        public bool ImprimeEmUmaLinha
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se deve ou não imprimir os dados dos itens em duas linhas.
        /// </summary>
        public bool ImprimeEmDuasLinhas
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define a margem inferior da impressão.
        /// </summary>
        public int MargemInferior
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define a margem superior da impressão.
        /// </summary>
        public int MargemSuperior
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define a margem esquerda da impressão.
        /// </summary>
        public int MargemEsquerda
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define a margem direita da impressão.
        /// </summary>
        public int MargemDireita
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Retorna as configurações de fonte da DANFE NFCe.
        /// </summary>
        public FonteDANFCeConfig Fonte { get; }

        #endregion Properties
    }
}