using ACBrLib.Core;
using ACBrLib.Core.BAL;
using ACBrLib.Core.Config;

namespace ACBrLib.BAL
{
    public sealed class BALConfig : ACBrLibConfig<IACBrLibBAL>
    {
        #region Constructors

        public BALConfig(IACBrLibBAL acbrlib) : base(acbrlib, ACBrSessao.BAL)
        {
            Device = new DeviceConfig<IACBrLibBAL>(acbrlib, ACBrSessao.BAL_Device);
        }

        #endregion Constructors

        #region Properties

        public ACBrBALModelo Modelo
        {
            get => GetProperty<ACBrBALModelo>();
            set => SetProperty(value);
        }

        public string ArqLog
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        public string Porta
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        public int Intervalo
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        public int PosIni
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        public int PosFim
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        public bool MonitorarBalanca
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        public DeviceConfig<IACBrLibBAL> Device { get; }

        #endregion Properties
    }
}