using ACBrLib.Core;
using ACBrLib.Core.Config;
using ACBrLib.Core.DFe;
using ACBrLib.Core.PIXCD;

namespace ACBrLib.PIXCD
{
    /// <summary>
    /// Configurações específicas do PSP MercadoPago para PIXCD.
    /// Veja todas as chaves e descrições em: https://acbr.sourceforge.io/ACBrLib/ConfiguracoesdaBiblioteca23.html
    /// </summary>
    public sealed class MercadoPagoConfig : ACBrLibConfigBase<IACBrLibPIXCD>
    {
        #region Constructors

        /// <summary>
        /// Inicializa as configurações do PSP MercadoPago.
        /// </summary>
        /// <param name="acbrlib">Instância da interface PIXCD.</param>
        public MercadoPagoConfig(IACBrLibPIXCD acbrlib) : base(acbrlib, ACBrSessao.MercadoPago)
        {
        }

        #endregion Constructors

        #region Properties

        /// <summary>
        /// Chave PIX utilizada para transações.
        /// </summary>
        public string ChavePIX
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// AccessToken para autenticação no MercadoPago.
        /// </summary>
        public string AccessToken
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