namespace ACBrLib.Core.Config
{
    /// <summary>
    /// Configurações de casas decimais para valores e quantidades.
    /// <para>Permite definir formato, máscaras e quantidade de casas decimais para campos numéricos.</para>
    /// <para>Veja mais em: https://acbr.sourceforge.io/ACBrLib/BemVindo.html</para>
    /// </summary>
    public sealed class CasasDecimaisConfig<TLib> : ACBrLibConfigBase<TLib> where TLib : IACBrLibBase
    {
        #region Constructors

        /// <summary>
        /// Inicializa a configuração de casas decimais.
        /// </summary>
        /// <param name="acbrlib">Instância da biblioteca ACBrLib.</param>
        /// <param name="sessao">Sessão de configuração.</param>
        public CasasDecimaisConfig(TLib acbrlib, ACBrSessao sessao) : base(acbrlib, sessao)
        {
            SubName = "CasasDecimais";
        }

        #endregion Constructors

        #region Properties

        /// <summary>
        /// Formato de exibição dos valores decimais.
        /// </summary>
        public string Formato
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Máscara para quantidade comercial.
        /// </summary>
        public string MaskqCom
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Máscara para valor unitário comercial.
        /// </summary>
        public string MaskvUnCom
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Quantidade de casas decimais para quantidade comercial.
        /// </summary>
        public int qCom
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Quantidade de casas decimais para valor unitário comercial.
        /// </summary>
        public int vUnCom
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        #endregion Properties
    }
}