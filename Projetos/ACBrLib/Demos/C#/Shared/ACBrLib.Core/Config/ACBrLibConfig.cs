namespace ACBrLib.Core.Config
{
    /// <summary>
    /// Classe base para configuração da ACBrLib.
    /// <para>Reúne as principais sessões de configuração: Principal, Sistema, Proxy, SoftwareHouse e Emissor.</para>
    /// <para>Veja mais em: https://acbr.sourceforge.io/ACBrLib/Geral.html</para>
    /// </summary>
    public abstract class ACBrLibConfig<TLib> : ACBrLibConfigBase<TLib> where TLib : IACBrLibBase
    {
        #region Constructors

        /// <summary>
        /// Inicializa as sessões de configuração da biblioteca ACBrLib.
        /// </summary>
        /// <param name="acbrlib">Instância da biblioteca ACBrLib.</param>
        /// <param name="sessao">Sessão de configuração.</param>
        protected ACBrLibConfig(TLib acbrlib, ACBrSessao sessao) : base(acbrlib, sessao)
        {
            Principal = new PrincipalConfig<TLib>(Parent);
            Sistema = new SistemaConfig<TLib>(Parent);
            Proxy = new ProxyConfig<TLib>(Parent);
            SoftwareHouse = new SoftwareHouseConfig<TLib>(Parent);
            Emissor = new EmissorConfig<TLib>(Parent);
        }

        #endregion Constructors

        #region Properties

        /// <summary>
        /// Configurações principais da biblioteca (formato de resposta, codificação, log).
        /// </summary>
        public PrincipalConfig<TLib> Principal { get; }

        /// <summary>
        /// Configurações do sistema utilizado nas impressões.
        /// </summary>
        public SistemaConfig<TLib> Sistema { get; }

        /// <summary>
        /// Configurações de proxy para comunicação.
        /// </summary>
        public ProxyConfig<TLib> Proxy { get; }

        /// <summary>
        /// Configurações da software house (CNPJ, Razão Social, etc).
        /// </summary>
        public SoftwareHouseConfig<TLib> SoftwareHouse { get; }

        /// <summary>
        /// Configurações do emissor de documentos DFe.
        /// </summary>
        public EmissorConfig<TLib> Emissor { get; set; }

        #endregion Properties
    }
}