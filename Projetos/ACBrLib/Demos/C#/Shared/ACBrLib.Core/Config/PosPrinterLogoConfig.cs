namespace ACBrLib.Core.Config
{
    /// <summary>
    /// Configurações de impressão de logomarca para a impressora PosPrinter na ACBrLib.
    /// </summary>
    /// <typeparam name="TLib">Tipo da biblioteca ACBrLib.</typeparam>
    public sealed class PosPrinterLogoConfig<TLib> : ACBrLibConfigBase<TLib> where TLib : IACBrLibBase
    {
        #region Constructors

        public PosPrinterLogoConfig(TLib acbrlib) : base(acbrlib, ACBrSessao.PosPrinter_Logo)
        {
        }

        #endregion Constructors

        #region Properties


        /// <summary>
        /// Define se a impressão da logomarca deve ser ignorada.
        /// </summary>
        public bool IgnorarLogo
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }


        /// <summary>
        /// Código da primeira tecla de atalho para impressão da logomarca.
        /// </summary>
        public byte KeyCode1
        {
            get => GetProperty<byte>();
            set => SetProperty(value);
        }


        /// <summary>
        /// Código da segunda tecla de atalho para impressão da logomarca.
        /// </summary>
        public byte KeyCode2
        {
            get => GetProperty<byte>();
            set => SetProperty(value);
        }


        /// <summary>
        /// Fator de escala horizontal da logomarca.
        /// </summary>
        public byte FatorX
        {
            get => GetProperty<byte>();
            set => SetProperty(value);
        }


        /// <summary>
        /// Fator de escala vertical da logomarca.
        /// </summary>
        public byte FatorY
        {
            get => GetProperty<byte>();
            set => SetProperty(value);
        }

        #endregion Properties
    }
}