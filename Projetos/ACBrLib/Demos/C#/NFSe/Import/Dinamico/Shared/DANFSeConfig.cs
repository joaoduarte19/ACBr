using ACBrLib.Core;
using ACBrLib.Core.Config;
using ACBrLib.Core.DFe;
using ACBrLib.Core.NFSe;

namespace ACBrLib.NFSe
{
    /// <summary>
    /// Configurações do DANFSe (Documento Auxiliar da Nota Fiscal de Serviço Eletrônica) para ACBrLibNFSe.
    /// Veja mais em: https://acbr.sourceforge.io/ACBrLib/ConfiguracoesdaBiblioteca22.html
    /// </summary>
    public sealed class DANFSeConfig : ReportConfig<IACBrLibNFSe>
    {
        #region Constructors

        /// <summary>
        /// Inicializa uma nova instância da classe DANFSeConfig para configuração do DANFSe na ACBrLibNFSe.
        /// </summary>
        /// <param name="acbrlib">Instância da interface de <see cref="IACBrLibNFSe"/>.</param>
        public DANFSeConfig(IACBrLibNFSe acbrlib) : base(acbrlib, ACBrSessao.DANFSe)
        {

        }

        #endregion Constructors

        #region Properties
        
        /// <summary>
        /// Define o tipo de DANFSe a ser gerado.
        /// Chave: TipoDANFSE
        /// </summary>
        public TipoDANFSE TipoDANFSE
        {
            get => GetProperty<TipoDANFSE>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define o nome da Prefeitura a ser exibido no DANFSe.
        /// Chave: Prefeitura
        /// </summary>
        public string Prefeitura
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se o DANFSe será impresso com a tarja de cancelada.
        /// Chave: Cancelada
        /// 0 = Não, 1 = Sim
        /// </summary>
        public bool Cancelada
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se o ambiente é de produção (não exibe "Ambiente de Homologação - SEM VALOR FISCAL").
        /// Chave: Producao
        /// 0 = Não (exibe mensagem de homologação), 1 = Sim (não exibe)
        /// </summary>
        public bool Producao
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se o DANFSe detalhará os serviços.
        /// Chave: DetalharServico
        /// 0 = Não, 1 = Sim
        /// </summary>
        public bool DetalharServico
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se a data de competência será exibida completa no DANFSe.
        /// Chave: DataCompetenciaCompleta
        /// </summary>
        public bool DataCompetenciaCompleta
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }
        #endregion Properties
    }
}