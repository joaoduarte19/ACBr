using ACBrLib.Core;
using ACBrLib.Core.Config;
using ACBrLib.Core.PIXCD;

namespace ACBrLib.PIXCD
{
    /// <summary>
    /// Configurações específicas do PSP Matera para a ACBrLib PIXCD.
    /// <para>
    /// Mapeia as chaves da sessão <c>[Matera]</c> do arquivo de configuração da biblioteca,
    /// utilizadas quando o provedor de serviços de pagamento (PSP) é o Matera.
    /// </para>
    /// <para>
    /// Documentação das chaves da sessão [Matera]:
    /// <see href="https://acbr.sourceforge.io/ACBrLib/ConfiguracoesdaBiblioteca23.html">
    /// Configurações da Biblioteca - ACBrLibPIXCD
    /// </see>.
    /// </para>
    /// </summary>
    public sealed class MateraConfig : ACBrLibConfigBase<IACBrLibPIXCDMatera>
    {
        #region Constructors

        /// <summary>
        /// Cria uma instância de configuração Matera associada à biblioteca PIXCD informada.
        /// </summary>
        /// <param name="acbrlib">Instância da interface do ACBrLib PIXCD Matera.</param>
        public MateraConfig(IACBrLibPIXCDMatera acbrlib) : base(acbrlib, ACBrSessao.Matera)
        {
        }

        #endregion Constructors

        #region Properties

        /// <summary>
        /// Chave PIX utilizada na integração com o PSP Matera (<c>ChavePIX</c>).
        /// </summary>
        public string ChavePIX
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Identificador do cliente na API do Matera (<c>ClientID</c>).
        /// </summary>
        public string ClientID
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Chave secreta para autenticação na API do Matera (<c>SecretKey</c>).
        /// </summary>
        public string SecretKey
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Segredo do cliente para autenticação na API do Matera (<c>ClientSecret</c>).
        /// </summary>
        public string ClientSecret
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Caminho e nome do arquivo do certificado PEM (<c>ArqCertificado</c>).
        /// </summary>
        public string ArqCertificado
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Caminho e nome do arquivo da chave privada KEY (<c>ArqChavePrivada</c>).
        /// </summary>
        public string ArqChavePrivada
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Identificador da conta no Matera (<c>AccountID</c>).
        /// </summary>
        public string AccountID
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Taxa do mediador (<c>MediatorFee</c>). Padrão: 0.
        /// </summary>
        public string MediatorFee
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Scopes enviados para a API do Matera (<c>Scopes</c>).
        /// Preencher no formato: [scCobWrite,scCobRead,scPixWrite,scPixRead].
        /// Opções: scCobWrite, scCobRead, scCobVWrite, scCobVRead, scLoteCobVWrite, scLoteCobVRead,
        /// scPixWrite, scPixRead, scWebhookWrite, scWebhookRead, scPayloadLocationWrite, scPayloadLocationRead.
        /// </summary>
        public string Scopes
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        #endregion Properties
    }
}