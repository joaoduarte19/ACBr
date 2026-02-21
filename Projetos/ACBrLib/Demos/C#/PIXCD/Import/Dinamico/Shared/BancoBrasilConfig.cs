using ACBrLib.Core;
using ACBrLib.Core.Config;
using ACBrLib.Core.DFe;
using ACBrLib.Core.PIXCD;

namespace ACBrLib.PIXCD
{
    /// <summary>
    /// Configurações específicas do PSP Banco do Brasil para PIXCD.
    /// Veja todas as chaves e descrições em: https://acbr.sourceforge.io/ACBrLib/ConfiguracoesdaBiblioteca23.html
    /// </summary>
    public sealed class BancoBrasilConfig : ACBrLibConfigBase<IACBrLibPIXCD>
    {
        #region Constructors

        /// <summary>
        /// Inicializa as configurações do PSP Banco do Brasil.
        /// </summary>
        /// <param name="acbrlib">Instância da interface PIXCD.</param>
        public BancoBrasilConfig(IACBrLibPIXCD acbrlib) : base(acbrlib, ACBrSessao.BancoBrasil)
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
        /// ClientID para autenticação no Banco do Brasil.
        /// </summary>
        public string ClientID
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// ClientSecret para autenticação no Banco do Brasil.
        /// </summary>
        public string ClientSecret
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// DeveloperApplicationKey para autenticação avançada.
        /// </summary>
        public string DeveloperApplicationKey
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Caminho do arquivo de chave privada.
        /// </summary>
        public string ArqChavePrivada
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Caminho do arquivo de certificado.
        /// </summary>
        public string ArqCertificado
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Caminho do arquivo PFX para autenticação.
        /// </summary>
        public string ArqPFX
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Senha do arquivo PFX para autenticação.
        /// </summary>
        public string SenhaPFX
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Versão da API do Banco do Brasil.
        /// </summary>
        public BBAPIVersao BBAPIVersao
        {
            get => GetProperty<BBAPIVersao>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Escopos de autenticação para a API do Banco do Brasil.
        /// </summary>
        public string Scopes
        { 
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        #endregion Properties
    }
}