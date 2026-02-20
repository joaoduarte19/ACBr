using ACBrLib.Core.PosPrinter;

namespace ACBrLib.Core.Config
{
    /// <summary>
    /// Configurações de múltiplas páginas para a impressora PosPrinter na ACBrLib.
    /// </summary>
    /// <typeparam name="TLib">Tipo da biblioteca ACBrLib.</typeparam>
    public sealed class PosPrinterMPaginaConfig<TLib> : ACBrLibConfigBase<TLib> where TLib : IACBrLibBase
    {
        #region Constructors

        public PosPrinterMPaginaConfig(TLib acbrlib) : base(acbrlib, ACBrSessao.PosPrinter_MPagina)
        {
        }

        #endregion Constructors

        #region Properties


        /// <summary>
        /// Largura da página em pontos.
        /// </summary>
        public int Largura
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }


        /// <summary>
        /// Altura da página em pontos.
        /// </summary>
        public int Altura
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }


        /// <summary>
        /// Margem esquerda da página em pontos.
        /// </summary>
        public int Esquerda
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }


        /// <summary>
        /// Margem superior da página em pontos.
        /// </summary>
        public int Topo
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }


        /// <summary>
        /// Direção de impressão da página.
        /// </summary>
        public PosDirecao Direcao
        {
            get => GetProperty<PosDirecao>();
            set => SetProperty(value);
        }


        /// <summary>
        /// Espaço entre linhas na página em pontos.
        /// </summary>
        public int EspacoEntreLinhas
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        #endregion Properties
    }
}