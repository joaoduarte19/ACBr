using ACBrLib.Core;
using ACBrLib.Core.Config;
using ACBrLib.Core.DFe;
using ACBrLib.Core.PIXCD;

namespace ACBrLib.PIXCD
{
    public sealed class SicrediConfig : ACBrLibDFeConfig<IACBrLibPIXCD>
    {
        #region Constructors

        public SicrediConfig(IACBrLibPIXCD acbrlib) : base(acbrlib, ACBrSessao.Sicredi)
        {

        }

        #endregion Constructors

        #region Properties

        public string ChavePIX
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        public string ClientID
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        public string ClientSecret
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        public string ArqChavePrivada
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        public string ArqCertificado
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        public string Scopes
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        #endregion Properties
    }
}