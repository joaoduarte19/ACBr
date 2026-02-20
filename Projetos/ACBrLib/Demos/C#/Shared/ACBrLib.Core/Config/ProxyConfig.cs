namespace ACBrLib.Core.Config
{
    /// <summary>
    /// Configurações de proxy para comunicação da ACBrLib.
    /// <para>Permite definir servidor, porta, usuário e senha para acesso via proxy.</para>
    /// <para>Veja mais em: https://acbr.sourceforge.io/ACBrLib/Geral.html</para>
    /// </summary>
    public sealed class ProxyConfig<TLib> : ACBrLibConfigBase<TLib> where TLib : IACBrLibBase
    {
        #region Constructors

        public ProxyConfig(TLib acbrlib) : base(acbrlib, ACBrSessao.Proxy)
        {
        }

        #endregion Constructors

        #region Properties


        /// <summary>
        /// Endereço do servidor proxy utilizado para conexão.
        /// </summary>
        public string Servidor
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }


        /// <summary>
        /// Porta do servidor proxy.
        /// </summary>
        public string Porta
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }


        /// <summary>
        /// Nome de usuário para autenticação no proxy.
        /// </summary>
        public string Usuario
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }


        /// <summary>
        /// Senha para autenticação no proxy.
        /// </summary>
        public string Senha
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        #endregion Properties
    }
}