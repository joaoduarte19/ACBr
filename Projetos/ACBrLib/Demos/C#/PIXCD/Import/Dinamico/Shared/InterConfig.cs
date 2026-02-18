using ACBrLib.Core;
using ACBrLib.Core.Config;
using ACBrLib.Core.DFe;
using ACBrLib.Core.PIXCD;

namespace ACBrLib.PIXCD
{
    public sealed class InterConfig : ACBrLibDFeConfig<IACBrLibPIXCD>
    {
        #region Constructors

        public InterConfig(IACBrLibPIXCD acbrlib) : base(acbrlib, ACBrSessao.Inter)
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