namespace ACBrLib.Core.Config
{
    /// <summary>
    /// Configurações de código de barras para a impressora PosPrinter na ACBrLib.
    /// </summary>
    /// <typeparam name="TLib">Tipo da biblioteca ACBrLib.</typeparam>
    public sealed class PosPrinterBarrasConfig<TLib> : ACBrLibConfigBase<TLib> where TLib : IACBrLibBase
    {
        #region Constructors

        public PosPrinterBarrasConfig(TLib acbrlib) : base(acbrlib, ACBrSessao.PosPrinter_Barras)
        {
        }

        #endregion Constructors

        #region Properties


        /// <summary>
        /// Define se o código numérico será exibido abaixo do código de barras.
        /// </summary>
        public bool MostrarCodigo
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }


        /// <summary>
        /// Largura da linha do código de barras.
        /// </summary>
        public int LarguraLinha
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }


        /// <summary>
        /// Altura do código de barras impresso.
        /// </summary>
        public int Altura
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }


        /// <summary>
        /// Margem do código de barras em relação à borda.
        /// </summary>
        public int Margem
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        #endregion Properties
    }
}