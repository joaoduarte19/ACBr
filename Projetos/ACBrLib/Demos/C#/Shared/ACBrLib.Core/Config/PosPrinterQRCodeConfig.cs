namespace ACBrLib.Core.Config
{
    /// <summary>
    /// Configurações de QR Code para a impressora PosPrinter na ACBrLib.
    /// </summary>
    /// <typeparam name="TLib">Tipo da biblioteca ACBrLib.</typeparam>
    public sealed class PosPrinterQRCodeConfig<TLib> : ACBrLibConfigBase<TLib> where TLib : IACBrLibBase
    {
        #region Constructors

        public PosPrinterQRCodeConfig(TLib acbrlib) : base(acbrlib, ACBrSessao.PosPrinter_QRCode)
        {
        }

        #endregion Constructors

        #region Properties


        /// <summary>
        /// Tipo do QR Code a ser impresso.
        /// </summary>
        public int Tipo
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }


        /// <summary>
        /// Largura do módulo do QR Code.
        /// </summary>
        public int LarguraModulo
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }


        /// <summary>
        /// Nível de correção de erro do QR Code.
        /// </summary>
        public int ErrorLevel
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        #endregion Properties
    }
}