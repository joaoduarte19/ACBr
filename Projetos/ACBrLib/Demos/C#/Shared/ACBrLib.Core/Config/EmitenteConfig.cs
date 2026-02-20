namespace ACBrLib.Core.Config
{
    /// <summary>
    /// Configurações do emitente na ACBrLib.
    /// <para>Permite definir CNPJ, inscrição municipal, razão social, dados de webservice e dados do emitente.</para>
    /// <para>Veja mais em: https://acbr.sourceforge.io/ACBrLib/BemVindo.html</para>
    /// </summary>
    public sealed class EmitenteConfig<TLib> : ACBrLibConfigBase<TLib> where TLib : IACBrLibBase
    {
        #region Constructors

        /// <summary>
        /// Inicializa a configuração do emitente.
        /// </summary>
        /// <param name="acbrlib">Instância da biblioteca ACBrLib.</param>
        /// <param name="sessao">Sessão de configuração.</param>
        public EmitenteConfig(TLib acbrlib, ACBrSessao sessao) : base(acbrlib, sessao)
        {
            SubName = "Emitente";

            Dados = new DadosConfig<TLib>(Parent, sessao);
        }

        #endregion Constructors

        #region Properties

        /// <summary>
        /// Dados do emitente (nome fantasia, endereço, município, etc).
        /// </summary>
        public DadosConfig<TLib> Dados { get; set; }

        /// <summary>
        /// CNPJ do emitente.
        /// </summary>
        public string CNPJ
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Inscrição municipal do emitente.
        /// </summary>
        public string InscMun
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Razão social do emitente.
        /// </summary>
        public string RazSocial
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Usuário do webservice.
        /// </summary>
        public string WSUser
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Senha do webservice.
        /// </summary>
        public string WSSenha
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Frase secreta do webservice.
        /// </summary>
        public string WSFraseSecr
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Chave de acesso do webservice.
        /// </summary>
        public string WSChaveAcesso
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Chave de autorização do webservice.
        /// </summary>
        public string WSChaveAutoriz
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        #endregion Properties
    }
}