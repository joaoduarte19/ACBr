using ACBrLib.Core;
using ACBrLib.Core.Config;
using ACBrLib.Core.ETQ;

namespace ACBrLib.ETQ
{
    /// <summary>
    /// Representa as configurações da sessão [ETQ] da biblioteca ACBrETQ.
    /// <para>
    /// Permite definir porta, modelo, temperatura, velocidade, unidade, DPI, página de código e demais
    /// parâmetros da etiquetadora, conforme documentação oficial da ACBrLib.
    /// </para>
    /// <para>
    /// Documentação oficial: <see href="https://acbr.sourceforge.io/ACBrLib/ConfiguracoesdaBiblioteca2.html">Configurações da Biblioteca - ACBrLib</see>
    /// </para>
    /// </summary>
    public sealed class ACBrETQConfig : ACBrLibConfig<IACBrLibETQ>
    {
        #region Constructors

        /// <summary>
        /// Inicializa as configurações da biblioteca ACBrETQ.
        /// </summary>
        /// <param name="acbretq">Instância da biblioteca ETQ.</param>
        public ACBrETQConfig(IACBrLibETQ acbretq) : base(acbretq, ACBrSessao.ETQ)
        {
            Device = new DeviceConfig<IACBrLibETQ>(acbretq, ACBrSessao.ETQ_Device);
        }

        #endregion Constructors

        #region Properties

        /// <summary>
        /// Configurações do dispositivo [ETQ_Device]: Baud, Data, TimeOut, Parity, Stop, HandShake, SoftFlow, HardFlow, etc.
        /// </summary>
        public DeviceConfig<IACBrLibETQ> Device { get; }

        /// <summary>
        /// Caminho e nome do arquivo de log do componente.
        /// </summary>
        public string ArqLog
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Porta de comunicação com a impressora (serial ou TCP). Ex.: "COM1", "TCP:192.168.0.31:9100", "LPT1".
        /// </summary>
        public string Porta
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Temperatura em impressoras térmicas. Padrão = 10.
        /// </summary>
        public int Temperatura
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Velocidade de impressão. Padrão = -1.
        /// </summary>
        public int Velocidade
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Avanço entre uma etiqueta e outra. Padrão = 0.
        /// </summary>
        public int Avanco
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Margem esquerda da etiqueta. Padrão = 0.
        /// </summary>
        public int MargemEsquerda
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se deve limpar a memória da impressora antes de imprimir. 0 = Não; 1 = Sim.
        /// </summary>
        public bool LimparMemoria
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Situação atual do componente. 0 = Não ativo; 1 = Ativo.
        /// </summary>
        public bool Ativo
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Página de código para comunicação com a impressora. pceNone, pce437, pce850, pce852, pce860, pce1250, pce1252.
        /// </summary>
        public ETQPageCode PaginaDeCodigo
        {
            get => GetProperty<ETQPageCode>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Protocolo de etiqueta: etqNenhum, etqPpla, etqPplb, etqZPLII, etqEpl2.
        /// </summary>
        public ETQModelo Modelo
        {
            get => GetProperty<ETQModelo>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Unidade de medida: etqMilimetros, etqPolegadas, etqDots, etqDecimoDeMilimetros.
        /// </summary>
        public ETQUnidade Unidade
        {
            get => GetProperty<ETQUnidade>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Back Feed: bfNone, bfOn, bfOff.
        /// </summary>
        public ETQBackFeed BackFeed
        {
            get => GetProperty<ETQBackFeed>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Origem de referência: ogNone, ogTop, ogBottom.
        /// </summary>
        public ETQOrigem Origem
        {
            get => GetProperty<ETQOrigem>();
            set => SetProperty(value);
        }

        /// <summary>
        /// DPI da impressora: dpi203, dpi300, dpi600.
        /// </summary>
        public ETQDPI DPI
        {
            get => GetProperty<ETQDPI>();
            set => SetProperty(value);
        }

        #endregion Properties
    }
}