using ACBrLib.Core;
using ACBrLib.Core.Config;
using ACBrLib.Core.DFe;
using ACBrLib.Core.PIXCD;

namespace ACBrLib.PIXCD
{
    /// <summary>
    /// Configurações específicas do PSP Inter para PIXCD.
    /// Veja todas as chaves e descrições em: https://acbr.sourceforge.io/ACBrLib/ConfiguracoesdaBiblioteca23.html
    /// </summary>
    public sealed class InterConfig : ACBrLibConfigBase<IACBrLibPIXCD>
    {
        #region Constructors

        /// <summary>
        /// Inicializa as configurações do PSP Inter.
        /// </summary>
        /// <param name="acbrlib">Instância da interface PIXCD.</param>
        public InterConfig(IACBrLibPIXCD acbrlib) : base(acbrlib, ACBrSessao.Inter)
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
        /// ClientID para autenticação no Inter.
        /// </summary>
        public string ClientID
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// ClientSecret para autenticação no Inter.
        /// </summary>
        public string ClientSecret
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