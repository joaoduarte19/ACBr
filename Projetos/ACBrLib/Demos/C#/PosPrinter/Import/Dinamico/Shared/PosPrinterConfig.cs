using ACBrLib.Core;
using ACBrLib.Core.Config;
using ACBrLib.Core.PosPrinter;

namespace ACBrLib.PosPrinter
{
    public sealed class PosPrinterConfig : ACBrLibConfig<IACBrLibPosPrinter>
    {
        #region Constructors

        public PosPrinterConfig(IACBrLibPosPrinter acbrlib) : base(acbrlib, ACBrSessao.PosPrinter)
        {
            BarrasConfig = new PosPrinterBarrasConfig<IACBrLibPosPrinter>(acbrlib);
            QrCodeConfig = new PosPrinterQRCodeConfig<IACBrLibPosPrinter>(acbrlib);
            LogoConfig = new PosPrinterLogoConfig<IACBrLibPosPrinter>(acbrlib);
            GavetaConfig = new PosPrinterGavetaConfig<IACBrLibPosPrinter>(acbrlib);
            MPaginaConfig = new PosPrinterMPaginaConfig<IACBrLibPosPrinter>(acbrlib);
            Device = new DeviceConfig<IACBrLibPosPrinter>(acbrlib, ACBrSessao.PosPrinter_Device);
        }

        #endregion Constructors

        #region Properties

        public PosPrinterBarrasConfig<IACBrLibPosPrinter> BarrasConfig { get; }
                
        public PosPrinterQRCodeConfig<IACBrLibPosPrinter> QrCodeConfig { get; }

        public PosPrinterLogoConfig<IACBrLibPosPrinter> LogoConfig { get; }

        public PosPrinterGavetaConfig<IACBrLibPosPrinter> GavetaConfig { get; }

        public PosPrinterMPaginaConfig<IACBrLibPosPrinter> MPaginaConfig { get; }

        public DeviceConfig<IACBrLibPosPrinter> Device { get; }

        public string ArqLog
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        public ACBrPosPrinterModelo Modelo
        {
            get => GetProperty<ACBrPosPrinterModelo>();
            set => SetProperty(value);
        }

        public string Porta
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        public PosPaginaCodigo PaginaDeCodigo
        {
            get => GetProperty<PosPaginaCodigo>();
            set => SetProperty(value);
        }

        public int ColunasFonteNormal
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        public int EspacoEntreLinhas
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        public int LinhasEntreCupons
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        public bool CortaPapel
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        public bool TraduzirTags
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        public bool IgnorarTags
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        public int LinhasBuffer
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        public bool ControlePorta
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        public bool VerificarImpressora
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        public bool TipoCorte
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        #endregion Properties
    }
}