namespace ACBrLib.Core.Config
{
    /// <summary>
    /// Configurações da gaveta de dinheiro para a impressora PosPrinter na ACBrLib.
    /// </summary>
    /// <typeparam name="TLib">Tipo da biblioteca ACBrLib.</typeparam>
    public sealed class PosPrinterGavetaConfig<TLib> : ACBrLibConfigBase<TLib> where TLib : IACBrLibBase
    {
        #region Constructors

        public PosPrinterGavetaConfig(TLib acbrlib) : base(acbrlib, ACBrSessao.PosPrinter_Gaveta)
        {
        }

        #endregion Constructors

        #region Properties


        /// <summary>
        /// Define se o sinal de controle da gaveta será invertido.
        /// </summary>
        public bool SinalInvertido
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }


        /// <summary>
        /// Tempo em milissegundos que a gaveta permanece acionada (ON).
        /// </summary>
        public byte TempoON
        {
            get => GetProperty<byte>();
            set => SetProperty(value);
        }


        /// <summary>
        /// Tempo em milissegundos que a gaveta permanece desligada (OFF).
        /// </summary>
        public byte TempoOFF
        {
            get => GetProperty<byte>();
            set => SetProperty(value);
        }

        #endregion Properties
    }
}