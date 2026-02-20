namespace ACBrLib.Core.Config
{
    /// <summary>
    /// Classe base para configurações de relatórios na ACBrLib.
    /// <para>Permite definir impressora, PDF, casas decimais, logomarca e prestador.</para>
    /// <para>Veja mais em: https://acbr.sourceforge.io/ACBrLib/Geral.html</para>
    /// </summary>
    public abstract class ReportConfig<TLib> : ACBrLibConfigBase<TLib> where TLib : IACBrLibBase
    {
        #region Constructors

        protected ReportConfig(TLib acbrlib, ACBrSessao sessao) : base(acbrlib, sessao)
        {
            CasasDecimais = new CasasDecimaisConfig<TLib>(acbrlib, sessao);
            LogoMarca = new ExpandeLogoMarcaConfig<TLib>(acbrlib, sessao);
            Prestador = new PrestadorConfig<TLib>(acbrlib, sessao);
        }

        #endregion Constructors

        #region Properties

        public string PathPDF
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        public bool UsaSeparadorPathPDF
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        public string Impressora
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        public string NomeDocumento
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        public bool MostraSetup
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        public bool MostraPreview
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        public bool MostraStatus
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        public int Copias
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        public string PathLogo
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        public decimal MargemInferior
        {
            get => GetProperty<decimal>();
            set => SetProperty(value);
        }

        public decimal MargemSuperior
        {
            get => GetProperty<decimal>();
            set => SetProperty(value);
        }

        public decimal MargemEsquerda
        {
            get => GetProperty<decimal>();
            set => SetProperty(value);
        }

        public decimal MargemDireita
        {
            get => GetProperty<decimal>();
            set => SetProperty(value);
        }

        public bool ExpandeLogoMarca
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        public bool AlterarEscalaPadrao
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        public int NovaEscala
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        public CasasDecimaisConfig<TLib> CasasDecimais { get; }

        public ExpandeLogoMarcaConfig<TLib> LogoMarca { get; }

        public PrestadorConfig<TLib> Prestador { get; }

        #endregion Properties
    }
}