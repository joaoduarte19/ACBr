using ACBrLib.Core;
using ACBrLib.Core.Config;
using ACBrLib.Core.DFe;
using ACBrLib.Core.PIXCD;

namespace ACBrLib.PIXCD
{
    /// <summary>
    /// Configurações específicas do PSP Matera para PIXCD.
    /// Veja todas as chaves e descrições em: https://acbr.sourceforge.io/ACBrLib/ConfiguracoesdaBiblioteca23.html
    /// </summary>
    public sealed class MateraConfig : ACBrLibConfigBase<IACBrLibPIXCD>
    {
        #region Constructors

        /// <summary>
        /// Inicializa as configurações do PSP Matera.
        /// </summary>
        /// <param name="acbrlib">Instância da interface PIXCD.</param>
        public MateraConfig(IACBrLibPIXCD acbrlib) : base(acbrlib, ACBrSessao.Matera)
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
        /// ClientID para autenticação no Matera.
        /// </summary>
        public string ClientID
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// SecretKey para autenticação no Matera.
        /// </summary>
        public string SecretKey
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// ClientSecret para autenticação no Matera.
        /// </summary>
        public string ClientSecret
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
        /// Caminho do arquivo de chave privada.
        /// </summary>
        public string ArqChavePrivada
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// AccountID para autenticação no Matera.
        /// </summary>
        public string AccountID
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Taxa do mediador para transações Matera.
        /// </summary>
        public string MediatorFee
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Escopos de autenticação para a API Matera.
        /// </summary>
        public string Scopes
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        #endregion Properties
    }
}