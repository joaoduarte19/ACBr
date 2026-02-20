namespace ACBrLib.Core.Config
{
    /// <summary>
    /// Configurações do emissor de documentos DFe na ACBrLib.
    /// <para>Permite definir CNPJ, razão social, nome fantasia, site, e-mail, telefone e responsável.</para>
    /// <para>Veja mais em: https://acbr.sourceforge.io/ACBrLib/BemVindo.html</para>
    /// </summary>
    public sealed class EmissorConfig<TLib> : ACBrLibConfigBase<TLib> where TLib : IACBrLibBase
    {
        #region Constructors

        /// <summary>
        /// Inicializa a configuração do emissor.
        /// </summary>
        /// <param name="acbrlib">Instância da biblioteca ACBrLib.</param>
        public EmissorConfig(TLib acbrlib) : base(acbrlib, ACBrSessao.Emissor)
        {
        }

        #endregion Constructors

        #region Properties

        /// <summary>
        /// CNPJ do emissor.
        /// </summary>
        public string CNPJ
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Razão social do emissor.
        /// </summary>
        public string RazaoSocial
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Nome fantasia do emissor.
        /// </summary>
        public string NomeFantasia
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Site do emissor.
        /// </summary>
        public string WebSite
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// E-mail do emissor.
        /// </summary>
        public string Email
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Telefone do emissor.
        /// </summary>
        public string Telefone
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Responsável pelo emissor.
        /// </summary>
        public string Responsavel
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        #endregion Properties
    }
}