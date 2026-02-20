using ACBrLib.Core.DFe;

namespace ACBrLib.Core.Config
{
    /// <summary>
    /// Configurações de fonte para impressão na ACBrLib.
    /// <para>Permite definir nome, negrito, tamanho da fonte para razão social, endereço, demais campos e informações complementares.</para>
    /// <para>Veja mais em: https://acbr.sourceforge.io/ACBrLib/BemVindo.html</para>
    /// </summary>
    public sealed class FontConfig<TLib> : ACBrLibConfigBase<TLib> where TLib : IACBrLibBase
    {
        #region Constructors

        /// <summary>
        /// Inicializa a configuração de fonte.
        /// </summary>
        /// <param name="acbrlib">Instância da biblioteca ACBrLib.</param>
        /// <param name="sessao">Sessão de configuração.</param>
        public FontConfig(TLib acbrlib, ACBrSessao sessao) : base(acbrlib, sessao)
        {
            SubName = "Fonte";
        }

        #endregion Constructors

        #region Properties

        /// <summary>
        /// Nome da fonte utilizada.
        /// </summary>
        public FonteNome Nome
        {
            get => GetProperty<FonteNome>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Indica se a fonte será negrito.
        /// </summary>
        public bool Negrito
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Tamanho da fonte para razão social.
        /// </summary>
        public int TamanhoFonteRazaoSocial
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Tamanho da fonte para endereço.
        /// </summary>
        public int TamanhoFonteEndereco
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Tamanho da fonte para demais campos.
        /// </summary>
        public int TamanhoFonteDemaisCampos
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Tamanho da fonte para informações complementares.
        /// </summary>
        public int TamanhoFonteInformacoesComplementares
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        #endregion Properties
    }
}