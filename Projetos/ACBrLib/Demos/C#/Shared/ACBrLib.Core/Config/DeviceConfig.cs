using ACBrLib.Core.Serial;

namespace ACBrLib.Core.Config
{
    /// <summary>
    /// Configurações de dispositivo serial na ACBrLib.
    /// <para>Permite definir parâmetros de comunicação serial como baud rate, bits de dados, paridade, bits de parada, handshake, timeout, fluxo e banda.</para>
    /// <para>Veja mais em: https://acbr.sourceforge.io/ACBrLib/BemVindo.html</para>
    /// </summary>
    public sealed class DeviceConfig<TLib> : ACBrLibConfigBase<TLib> where TLib : IACBrLibBase
    {
        #region Constructors

        /// <summary>
        /// Inicializa a configuração de dispositivo serial.
        /// </summary>
        /// <param name="acbrlib">Instância da biblioteca ACBrLib.</param>
        /// <param name="sessao">Sessão de configuração.</param>
        public DeviceConfig(TLib acbrlib, ACBrSessao sessao) : base(acbrlib, sessao)
        {
        }

        #endregion Constructors

        #region Properties

        /// <summary>
        /// Taxa de transmissão (baud rate).
        /// </summary>
        public SerialBaud Baud
        {
            get => GetProperty<SerialBaud>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Número de bits de dados por byte.
        /// </summary>
        public SerialDataBits Data
        {
            get => GetProperty<SerialDataBits>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Timeout da comunicação serial.
        /// </summary>
        public int TimeOut
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Tipo de paridade.
        /// </summary>
        public SerialParity Parity
        {
            get => GetProperty<SerialParity>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Número de bits de parada.
        /// </summary>
        public SerialStopBytes Stop
        {
            get => GetProperty<SerialStopBytes>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Banda máxima permitida.
        /// </summary>
        public int MaxBandwidth
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Quantidade de bytes enviados.
        /// </summary>
        public int SendBytesCount
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Intervalo entre envios de bytes.
        /// </summary>
        public int SendBytesInterval
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Tipo de handshake (controle de fluxo).
        /// </summary>
        public SerialHandShake HandShake
        {
            get => GetProperty<SerialHandShake>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Controle de fluxo por software.
        /// </summary>
        public bool SoftFlow
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Controle de fluxo por hardware.
        /// </summary>
        public bool HardFlow
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        #endregion Properties
    }
}