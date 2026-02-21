using ACBrLib.Core;
using ACBrLib.Core.Config;
using ACBrLib.Core.PosPrinter;

namespace ACBrLib.PosPrinter
{
    /// <summary>
    /// Classe de configuração da biblioteca ACBrLib para impressoras POS.
    /// Permite definir e acessar parâmetros de operação, dispositivos, códigos de página, campos de impressão, controle de gaveta, QRCode, barras e logo.
    /// Os campos de configuração específicos utilizam documentação herdada de suas respectivas classes.
    /// Baseada na documentação oficial: https://acbr.sourceforge.io/ACBrLib/ConfiguracoesdaBiblioteca.html
    /// </summary>
    public sealed class PosPrinterConfig : ACBrLibConfig<IACBrLibPosPrinter>
    {
        #region Constructors

        /// <summary>
        /// Inicializa as configurações específicas da impressora POS.
        /// </summary>
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

        /// <inheritdoc />
        public PosPrinterBarrasConfig<IACBrLibPosPrinter> BarrasConfig { get; }

        /// <inheritdoc />
        public PosPrinterQRCodeConfig<IACBrLibPosPrinter> QrCodeConfig { get; }

        /// <inheritdoc />
        public PosPrinterLogoConfig<IACBrLibPosPrinter> LogoConfig { get; }

        /// <inheritdoc />
        public PosPrinterGavetaConfig<IACBrLibPosPrinter> GavetaConfig { get; }

        /// <inheritdoc />
        public PosPrinterMPaginaConfig<IACBrLibPosPrinter> MPaginaConfig { get; }

        /// <inheritdoc />
        public DeviceConfig<IACBrLibPosPrinter> Device { get; }

        /// <summary>
        /// Caminho do arquivo de log da biblioteca.
        /// </summary>
        public string ArqLog
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Modelo da impressora POS utilizada.
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
        /// Código de página utilizado para impressão.
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
        /// Indica se as tags devem ser traduzidas durante a impressão.
        /// </summary>
        public bool TraduzirTags
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Indica se as tags devem ser ignoradas durante a impressão.
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
        /// Indica se a impressora deve ser verificada antes da impressão.
        /// </summary>
        public bool VerificarImpressora
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Tipo de corte do papel (parcial ou total).
        /// </summary>
        public bool TipoCorte
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        #endregion Properties
    }
}