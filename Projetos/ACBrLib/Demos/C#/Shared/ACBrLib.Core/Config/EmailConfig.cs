using ACBrLib.Core.Mail;

namespace ACBrLib.Core.Config
{
    /// <summary>
    /// Configurações para envio de e-mails na ACBrLib.
    /// <para>Permite definir servidor, conta, usuário, senha, codificação, porta, SSL/TLS, timeout, confirmação, tentativas, HTML e prioridade.</para>
    /// <para>Veja mais em: https://acbr.sourceforge.io/ACBrLib/BemVindo.html</para>
    /// </summary>
    public sealed class EmailConfig<TLib> : ACBrLibConfig<TLib> where TLib : IACBrLibBase
    {
        #region Constructors

        /// <summary>
        /// Inicializa a configuração de e-mail.
        /// </summary>
        /// <param name="acbrlib">Instância da biblioteca ACBrLib.</param>
        public EmailConfig(TLib acbrlib) : base(acbrlib, ACBrSessao.Email)
        {
        }

        #endregion Constructors

        #region Properties

        /// <summary>
        /// Nome de exibição no e-mail.
        /// </summary>
        public string Nome
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Endereço do servidor SMTP.
        /// </summary>
        public string Servidor
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Endereço de e-mail.
        /// </summary>
        public string Conta
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Usuário para login no servidor SMTP.
        /// </summary>
        public string Usuario
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Senha do usuário para login.
        /// </summary>
        public string Senha
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Codificação do e-mail.
        /// </summary>
        public MimeChar Codificacao
        {
            get => GetProperty<MimeChar>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Porta do servidor SMTP.
        /// </summary>
        public string Porta
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Utilizar conexão SSL.
        /// </summary>
        public bool SSL
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Utilizar conexão TLS.
        /// </summary>
        public bool TLS
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Timeout da comunicação com o servidor SMTP.
        /// </summary>
        public int TimeOut
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Solicitar confirmação de leitura.
        /// </summary>
        public bool Confirmacao
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Executar em segundo plano.
        /// </summary>
        public bool SegundoPlano
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Número de tentativas de envio.
        /// </summary>
        public int Tentativas
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se deve usar no corpo do e-mail texto em HTML ou não.
        /// </summary>
        public bool IsHTML
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define a prioridade de envio do e-mail.
        /// </summary>
        public MessPriority Priority
        {
            get => GetProperty<MessPriority>();
            set => SetProperty(value);
        }

        #endregion Properties
    }
}