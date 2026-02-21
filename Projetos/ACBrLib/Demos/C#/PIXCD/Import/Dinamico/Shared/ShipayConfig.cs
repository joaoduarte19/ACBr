using ACBrLib.Core;
using ACBrLib.Core.Config;
using ACBrLib.Core.DFe;
using ACBrLib.Core.PIXCD;

namespace ACBrLib.PIXCD
{
    /// <summary>
    /// Configurações específicas do PSP Shipay para PIXCD.
    /// Veja todas as chaves e descrições em: https://acbr.sourceforge.io/ACBrLib/ConfiguracoesdaBiblioteca23.html
    /// </summary>
    public sealed class ShipayConfig : ACBrLibDFeConfig<IACBrLibPIXCD>
    {
        #region Constructors

        /// <summary>
        /// Inicializa as configurações do PSP Shipay.
        /// </summary>
        /// <param name="acbrlib">Instância da interface PIXCD.</param>
        public ShipayConfig(IACBrLibPIXCD acbrlib) : base(acbrlib, ACBrSessao.Shipay)
        {
        }

        #endregion Constructors

        #region Properties

        /// <summary>
        /// ClientID para autenticação no Shipay.
        /// </summary>
        public string ClientID
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// SecretKey para autenticação no Shipay.
        /// </summary>
        public string SecretKey
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// AccessKey para autenticação no Shipay.
        /// </summary>
        public string AccessKey
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