namespace ACBrLib.Core.Config
{
    /// <summary>
    /// Configurações para expansão da logo/marca na impressão.
    /// <para>Permite definir altura, largura, posição, dimensionamento e esticamento da logo.</para>
    /// <para>Veja mais em: https://acbr.sourceforge.io/ACBrLib/BemVindo.html</para>
    /// </summary>
    public sealed class ExpandeLogoMarcaConfig<TLib> : ACBrLibConfigBase<TLib> where TLib : IACBrLibBase
    {
        #region Constructors

        /// <summary>
        /// Inicializa a configuração de expansão da logo/marca.
        /// </summary>
        /// <param name="acbrlib">Instância da biblioteca ACBrLib.</param>
        /// <param name="sessao">Sessão de configuração.</param>
        public ExpandeLogoMarcaConfig(TLib acbrlib, ACBrSessao sessao) : base(acbrlib, sessao)
        {
            SubName = "ExpandeLogoMarca";
        }

        #endregion Constructors

        #region Properties

        /// <summary>
        /// Altura da logo/marca.
        /// </summary>
        public int Altura
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Posição à esquerda da logo/marca.
        /// </summary>
        public int Esquerda
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Posição no topo da logo/marca.
        /// </summary>
        public int Topo
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Largura da logo/marca.
        /// </summary>
        public int Largura
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Indica se deve dimensionar a logo/marca.
        /// </summary>
        public bool Dimensionar
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Indica se deve esticar a logo/marca.
        /// </summary>
        public bool Esticar
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        #endregion Properties
    }
}