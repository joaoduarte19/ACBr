using ACBrLib.Core;
using ACBrLib.Core.Config;
using ACBrLib.Core.DFe;
using ACBrLib.Core.PIXCD;

namespace ACBrLib.PIXCD
{
    /// <summary>
    /// Configurações específicas do PSP PixPDV para PIXCD.
    /// Veja todas as chaves e descrições em: https://acbr.sourceforge.io/ACBrLib/ConfiguracoesdaBiblioteca23.html
    /// </summary>
    public sealed class PixPDVConfig : ACBrLibConfigBase<IACBrLibPIXCD>
    {
        #region Constructors

        /// <summary>
        /// Inicializa as configurações do PSP PixPDV.
        /// </summary>
        /// <param name="acbrlib">Instância da interface PIXCD.</param>
        public PixPDVConfig(IACBrLibPIXCD acbrlib) : base(acbrlib, ACBrSessao.PixPDV)
        {
        }

        #endregion Constructors

        #region Properties

        /// <summary>
        /// CNPJ utilizado para autenticação no PixPDV.
        /// </summary>
        public string CNPJ
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Token de autenticação no PixPDV.
        /// </summary>
        public string Token
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// SecretKey para autenticação no PixPDV.
        /// </summary>
        public string SecretKey
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Versão da API PixPDV: 0 = apiVersao1, 1 = apiVersaoMediator
        /// </summary>
        public PixPDVAPIVersao PixPDVAPIVersao
        {
            get => GetProperty<PixPDVAPIVersao>();
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