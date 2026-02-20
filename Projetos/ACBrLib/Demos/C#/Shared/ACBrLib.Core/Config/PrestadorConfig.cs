namespace ACBrLib.Core.Config
{
    /// <summary>
    /// Configurações do prestador de serviço para relatórios na ACBrLib.
    /// <para>Veja mais em: https://acbr.sourceforge.io/ACBrLib/Geral.html</para>
    /// </summary>
    public sealed class PrestadorConfig<TLib> : ACBrLibConfigBase<TLib> where TLib : IACBrLibBase
    {
        #region Constructors

        public PrestadorConfig(TLib acbrlib, ACBrSessao sessao) : base(acbrlib, sessao)
        {
            SubName = "Prestador";
        }

        #endregion Constructors

        #region Properties

        public string Logo
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        #endregion Properties
    }
}