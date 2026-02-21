using ACBrLib.Core;
using ACBrLib.Core.Config;
using ACBrLib.Core.DFe;
using ACBrLib.Core.PIXCD;

namespace ACBrLib.PIXCD
{
    /// <summary>
    /// Configurações específicas do PSP AppLess para PIXCD.
    /// Veja todas as chaves e descrições em: https://acbr.sourceforge.io/ACBrLib/ConfiguracoesdaBiblioteca23.html
    /// </summary>
    public sealed class AppLessConfig : ACBrLibConfigBase<IACBrLibPIXCD>
    {
        #region Constructors

        /// <summary>
        /// Inicializa as configurações do PSP AppLess.
        /// </summary>
        /// <param name="acbrlib">Instância da interface PIXCD.</param>
        public AppLessConfig(IACBrLibPIXCD acbrlib) : base(acbrlib, ACBrSessao.AppLess)
        {
        }

        #endregion Constructors

        #region Properties

        /// <summary>
        /// ClientID para autenticação no AppLess.
        /// </summary>
        public string ClientID
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// ClientSecret para autenticação no AppLess.
        /// </summary>
        public string ClientSecret
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// SecretKeyHMAC para autenticação no AppLess.
        /// </summary>
        public string SecretKeyHMAC
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Scopes enviados para a API. Exemplo: [scCobWrite,scCobRead,scPixWrite,scPixRead]
        /// </summary>
        public string Scopes
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        #endregion Properties
    }
}