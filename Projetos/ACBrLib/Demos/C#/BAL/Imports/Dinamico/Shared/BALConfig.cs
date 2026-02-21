using ACBrLib.Core;
using ACBrLib.Core.BAL;
using ACBrLib.Core.Config;

namespace ACBrLib.BAL
{
    /// <summary>
    /// Representa as configurações da biblioteca ACBrLibBAL.
    /// Esta classe recebe uma instância de IACBrLibBAL para acessar e modificar as configurações da balança.
    /// Permite configurar parâmetros como modelo, porta, intervalo de leitura, posições e monitoramento, conforme a documentação oficial.
    /// </summary>
    public class BALConfig : ACBrLibConfigBase<IACBrLibBAL>
    {

        #region Constructors
        /// <summary>
        /// Inicializa uma nova instância da classe <see cref="BALConfig"/>.
        /// </summary>
        /// <param name="acbrlib">Instância da interface <see cref="IACBrLibBAL"/>.</param>
        public BALConfig(IACBrLibBAL acbrlib) : base(acbrlib, ACBrSessao.BAL)
        {
            Device = new DeviceConfig<IACBrLibBAL>(acbrlib, ACBrSessao.BAL_Device);
        }

        #endregion Constructors

        #region Properties

        /// <summary>
        /// Define o modelo da balança a ser utilizado.
        /// Exemplos: balFilizola, balToledo, balUrano, etc.
        /// </summary>
        public ACBrBALModelo Modelo
        {
            get => GetProperty<ACBrBALModelo>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Caminho e nome do arquivo de log do componente.
        /// </summary>
        public string ArqLog
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Porta de comunicação com a balança (serial ou TCP).
        /// </summary>
        public string Porta
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Intervalo de leitura da balança em milissegundos. Padrão: 200.
        /// </summary>
        public int Intervalo
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Posição inicial para leitura do peso. Padrão: 0.
        /// </summary>
        public int PosIni
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Posição final para leitura do peso. Padrão: 0.
        /// </summary>
        public int PosFim
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se deve monitorar a balança automaticamente. 0 = Não, 1 = Sim.
        /// </summary>
        public bool MonitorarBalanca
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Configurações específicas do dispositivo (porta, baud rate, paridade, etc).
        /// </summary>
        public DeviceConfig<IACBrLibBAL> Device { get; }

        #endregion Properties
    }
}