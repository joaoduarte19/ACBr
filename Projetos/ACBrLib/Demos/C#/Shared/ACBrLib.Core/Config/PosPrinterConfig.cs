using ACBrLib.Core.PosPrinter;

namespace ACBrLib.Core.Config
{
    /// <summary>
    /// Configurações da impressora PosPrinter na ACBrLib.
    /// <para>Permite definir modelo, portas, comandos, barras, QRCode, logo, gaveta, página, e parâmetros de dispositivo.</para>
    /// <para>Veja mais em: https://acbr.sourceforge.io/ACBrLib/BemVindo.html</para>
    /// </summary>
    public sealed class PosPrinterConfig<TLib> : ACBrLibConfigBase<TLib> where TLib : IACBrLibBase
    {
        #region Constructors

        public PosPrinterConfig(TLib acbrlib) : base(acbrlib, ACBrSessao.PosPrinter)
        {
            BarrasConfig = new PosPrinterBarrasConfig<TLib>(acbrlib);
            QrCodeConfig = new PosPrinterQRCodeConfig<TLib>(acbrlib);
            LogoConfig = new PosPrinterLogoConfig<TLib>(acbrlib);
            GavetaConfig = new PosPrinterGavetaConfig<TLib>(acbrlib);
            MPaginaConfig = new PosPrinterMPaginaConfig<TLib>(acbrlib);
            DeviceConfig = new DeviceConfig<TLib>(acbrlib, ACBrSessao.PosPrinter_Device);
        }

        #endregion Constructors

        #region Properties


        /// <summary>
        /// Configurações de código de barras da impressora.
        /// </summary>
        public PosPrinterBarrasConfig<TLib> BarrasConfig { get; }


        /// <summary>
        /// Configurações de QR Code da impressora.
        /// </summary>
        public PosPrinterQRCodeConfig<TLib> QrCodeConfig { get; }


        /// <summary>
        /// Configurações de logomarca da impressora.
        /// </summary>
        public PosPrinterLogoConfig<TLib> LogoConfig { get; }


        /// <summary>
        /// Configurações da gaveta de dinheiro da impressora.
        /// </summary>
        public PosPrinterGavetaConfig<TLib> GavetaConfig { get; }


        /// <summary>
        /// Configurações de múltiplas páginas da impressora.
        /// </summary>
        public PosPrinterMPaginaConfig<TLib> MPaginaConfig { get; }


        /// <summary>
        /// Configurações do dispositivo da impressora.
        /// </summary>
        public DeviceConfig<TLib> DeviceConfig { get; }


        /// <summary>
        /// Caminho do arquivo de log das operações da impressora.
        /// </summary>
        public string ArqLog
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }


        /// <summary>
        /// Modelo da impressora PosPrinter.
        /// </summary>
        public ACBrPosPrinterModelo Modelo
        {
            get => GetProperty<ACBrPosPrinterModelo>();
            set => SetProperty(value);
        }


        /// <summary>
        /// Porta de comunicação utilizada pela impressora.
        /// </summary>
        public string Porta
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }


        /// <summary>
        /// Página de código utilizada para impressão.
        /// </summary>
        public PosPaginaCodigo PaginaDeCodigo
        {
            get => GetProperty<PosPaginaCodigo>();
            set => SetProperty(value);
        }


        /// <summary>
        /// Número de colunas para fonte normal.
        /// </summary>
        public int ColunasFonteNormal
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }


        /// <summary>
        /// Espaço entre linhas na impressão.
        /// </summary>
        public int EspacoEntreLinhas
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }


        /// <summary>
        /// Número de linhas entre cupons impressos.
        /// </summary>
        public int LinhasEntreCupons
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }


        /// <summary>
        /// Indica se a impressora deve cortar o papel automaticamente.
        /// </summary>
        public bool CortaPapel
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }


        /// <summary>
        /// Indica se as tags de formatação devem ser traduzidas.
        /// </summary>
        public bool TraduzirTags
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }


        /// <summary>
        /// Indica se as tags de formatação devem ser ignoradas.
        /// </summary>
        public bool IgnorarTags
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }


        /// <summary>
        /// Número de linhas do buffer de impressão.
        /// </summary>
        public int LinhasBuffer
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }


        /// <summary>
        /// Indica se o controle da porta deve ser realizado pela biblioteca.
        /// </summary>
        public bool ControlePorta
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }


        /// <summary>
        /// Indica se a impressora deve ser verificada antes de cada operação.
        /// </summary>
        public bool VerificarImpressora
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }


        /// <summary>
        /// Define o tipo de corte do papel (total ou parcial).
        /// </summary>
        public bool TipoCorte
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        #endregion Properties
    }
}