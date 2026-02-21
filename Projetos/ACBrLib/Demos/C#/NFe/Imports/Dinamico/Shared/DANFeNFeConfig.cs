using ACBrLib.Core;
using ACBrLib.Core.Config;
using ACBrLib.Core.DFe;
using ACBrLib.Core.NFe;

namespace ACBrLib.NFe
{
    /// <summary>
    /// Representa as configurações de impressão da DANFE para NF-e, baseadas na interface IACBrLibNFe.
    /// </summary>
    public sealed class DANFeNFeConfig : ACBrLibConfigBase<IACBrLibNFe>
    {
        #region Constructors

        /// <summary>
        /// Inicializa uma nova instância da classe de configurações da DANFE NF-e.
        /// </summary>
        /// <param name="acbrlib">Instância da interface IACBrLibNFe utilizada pela configuração.</param>
        public DANFeNFeConfig(IACBrLibNFe acbrlib) : base(acbrlib, ACBrSessao.DANFENFe)
        {
            Fonte = new FontConfig<IACBrLibNFe>(acbrlib, ACBrSessao.DANFENFe);
        }

        #endregion Constructors

        #region Properties

        /// <summary>
        /// Define se a DANFE será impressa em formulário contínuo: 0 = Não, 1 = Sim.
        /// </summary>
        public bool FormularioContinuo
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define a forma que deve ser impresso o valor do produto: 0 = iuComercial, 1 = iuTributavel, 2 = iuComercialETributavel.
        /// </summary>
        public ImprimeValor ImprimeValor
        {
            get => GetProperty<ImprimeValor>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se o desconto deve ser impresso como percentual.
        /// </summary>
        public bool ImprimeDescPorPercentual
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se deve imprimir ou não o detalhamento específico: 0 = Não, 1 = Sim.
        /// </summary>
        public bool ImprimeDetalhamentoEspecifico
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define a posição que deve ser impresso o canhoto: 0 = prCabecalho, 1 = prRodape, 2 = prEsquerda.
        /// </summary>
        public PosCanhoto PosCanhoto
        {
            get => GetProperty<PosCanhoto>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se deve ou não gerar e exibir o resumo do canhoto.
        /// </summary>
        public bool ExibeResumoCanhoto
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define o valor a ser impresso no resumo do canhoto.
        /// </summary>
        public string TextoResumoCanhoto
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se deve ou não exibir os campos de fatura na impressão.
        /// </summary>
        public bool ExibeCampoFatura
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se deve ou não exibir os dados de ISSQN na impressão.
        /// </summary>
        public bool ExibeDadosISSQN
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se deve ou não exibir os dados dos documentos referenciados na impressão.
        /// </summary>
        public bool ExibeDadosDocReferenciados
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define quais campos das informações do veículo devem ser exibidos.
        /// </summary>
        public DetVeiculos DetVeiculos
        {
            get => GetProperty<DetVeiculos>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define quais campos das informações do medicamento devem ser exibidos.
        /// </summary>
        public DetMedicamentos DetMedicamentos
        {
            get => GetProperty<DetMedicamentos>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define quais campos das informações do armamento devem ser exibidos.
        /// </summary>
        public DetArmamentos DetArmamentos
        {
            get => GetProperty<DetArmamentos>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define quais campos das informações dos combustíveis devem ser exibidos.
        /// </summary>
        public DetCombustiveis DetCombustiveis
        {
            get => GetProperty<DetCombustiveis>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define quais campos das informações de rastro devem ser exibidos.
        /// </summary>
        public DetRastros DetRastros
        {
            get => GetProperty<DetRastros>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define como deverá ser calculado o percentual dos tributos: 0 = ptValorProdutos, 1 = ptValorNF, 2 = ptPersonalizado.
        /// </summary>
        public TributosPercentual TributosPercentual
        {
            get => GetProperty<TributosPercentual>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define o percentual dos tributos se informado como ptPersonalizado.
        /// </summary>
        public string TributosPercentualPersonalizado
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define o caminho da imagem que será usada como marca d'água na impressão da DANFE.
        /// </summary>
        public string MarcadAgua
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define a largura do campo código do produto.
        /// </summary>
        public int LarguraCodProd
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se deve ser exibido o campo EAN na impressão.
        /// </summary>
        public bool ExibeEAN
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define o tamanho da linha do produto.
        /// </summary>
        public int AltLinhaComun
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define o espaço entre os produtos na impressão.
        /// </summary>
        public int EspacoEntreProdutos
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se deve ou não zebra a impressão dos produtos.
        /// </summary>
        public bool AlternaCoresProdutos
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define a cor que será usada para zebrar a impressão dos produtos.
        /// </summary>
        public string CorDestaqueProdutos
        {
            get => GetProperty<string>();
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
        /// Define o recuo do texto de endereço.
        /// </summary>
        public int RecuoEndereco
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define o recuo do cabeçalho.
        /// </summary>
        public int RecuoEmpresa
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se o logo deve ser impresso em cima do cabeçalho.
        /// </summary>
        public bool LogoemCima
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define o recuo do logo.
        /// </summary>
        public int RecuoLogo
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se deve expandir automaticamente o quadro dados adicionais.
        /// </summary>
        public bool ExpandirDadosAdicionaisAuto
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se deve imprimir a continuação dos dados adicionais na primeira página.
        /// </summary>
        public bool ImprimeContDadosAdPrimeiraPagina
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Retorna as configurações de fonte da DANFE NFe.
        /// </summary>
        public FontConfig<IACBrLibNFe> Fonte { get; }

        /// <summary>
        /// Define o layout do canhoto: 0 = prlPadrao, 1 = prlBarra.
        /// </summary>
        public PosCanhotoLayout PosCanhotoLayout
        {
            get => GetProperty<PosCanhotoLayout>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se exibe ou não os campos de pagamentos: 0 = eipNunca, 1 = eipAdicionais, 2 = eipQuadro.
        /// </summary>
        public ExibeCampoDePagamento ExibeCampoDePagamento
        {
            get => GetProperty<ExibeCampoDePagamento>();
            set => SetProperty(value);
        }

        #endregion Properties
    }
}