using ACBrLib.Core;
using ACBrLib.Core.Config;
using ACBrLib.Core.Mail;

namespace ACBrLib.Mail
{
    /// <summary>
    /// Classe de configuração de alto nível para a biblioteca ACBrLib Mail.
    /// <para>
    /// Mapeia as chaves da sessão <c>[Email]</c> do arquivo de configuração da ACBrLib
    /// (servidor SMTP, conta, autenticação, SSL/TLS, prioridade, etc.).
    /// </para>
    /// <para>
    /// Documentação das configurações (Geral e Email):
    /// <see href="https://acbr.sourceforge.io/ACBrLib/Geral.html">Configurações da Biblioteca (Geral)</see>
    /// </para>
    /// </summary>
    public sealed class MailConfig : ACBrLibConfig<IACBrLibMail>
    {
        #region Constructors

        /// <summary>
        /// Cria uma nova instância da classe de configuração do ACBrMail,
        /// associada a uma instância de <see cref="IACBrLibMail"/>.
        /// </summary>
        /// <param name="acbrlib">Instância da interface de alto nível do ACBrMail.</param>
        public MailConfig(IACBrLibMail acbrlib) : base(acbrlib, ACBrSessao.Email)
        {
        }

        #endregion Constructors

        #region Properties

        /// <summary>
        /// Nome de exibição no e-mail (chave <c>Nome</c> da sessão [Email]).
        /// </summary>
        public string Nome
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Endereço do servidor SMTP (chave <c>Servidor</c>).
        /// </summary>
        public string Servidor
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Endereço de e-mail da conta (chave <c>Conta</c>).
        /// </summary>
        public string Conta
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Usuário para login no servidor SMTP (chave <c>Usuario</c>).
        /// </summary>
        public string Usuario
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Senha do usuário para login (chave <c>Senha</c>).
        /// </summary>
        public string Senha
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Codificação do e-mail (chave <c>Codificacao</c>). Ex.: UTF_8, ISO_8859_1, CP1252.
        /// </summary>
        public MimeChar Codificacao
        {
            get => GetProperty<MimeChar>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Porta do servidor SMTP (chave <c>Porta</c>).
        /// </summary>
        public string Porta
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Utilizar conexão SSL. 0 = Não, 1 = Sim (chave <c>SSL</c>).
        /// </summary>
        public bool SSL
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Utilizar conexão TLS. 0 = Não, 1 = Sim (chave <c>TLS</c>).
        /// </summary>
        public bool TLS
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Timeout da comunicação com o servidor SMTP em segundos (chave <c>TimeOut</c>).
        /// </summary>
        public int TimeOut
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Solicitar confirmação de leitura (chave <c>Confirmacao</c>).
        /// </summary>
        public bool Confirmacao
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Executar envio em segundo plano (chave <c>SegundoPlano</c>).
        /// </summary>
        public bool SegundoPlano
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Número de tentativas de envio (chave <c>Tentativas</c>).
        /// </summary>
        public int Tentativas
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se o corpo do e-mail é HTML. 0 = Não, 1 = Sim (chave <c>IsHTML</c>).
        /// </summary>
        public bool IsHTML
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Prioridade do e-mail: MP_unknown, MP_low, MP_normal, MP_high (chave <c>Priority</c>).
        /// </summary>
        public MessPriority Priority
        {
            get => GetProperty<MessPriority>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Tipo de comunicação segura: LT_all, LT_SSLv2, LT_SSLv3, LT_TLSv1, LT_TLSv1_1, LT_TLSv1_2, LT_SSHv2 (chave <c>SSLType</c>).
        /// </summary>
        public int SSLType
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        #endregion Properties
    }
}