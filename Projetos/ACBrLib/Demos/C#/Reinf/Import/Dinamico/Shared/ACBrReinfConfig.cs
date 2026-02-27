using ACBrLib.Core;
using ACBrLib.Core.Config;
using ACBrLib.Core.Reinf;

namespace ACBrLib.Reinf
{
    /// <summary>
    /// Classe de configuração de alto nível para a biblioteca ACBrReinf.
    /// <para>
    /// Mapeia as principais chaves da sessão <c>[Reinf]</c> do arquivo de configuração
    /// da ACBrLib, permitindo controlar caminhos de gravação, identificação do
    /// contribuinte e transmissor, tipo de contribuinte e versão do Reinf.
    /// </para>
    /// <para>
    /// Documentação completa das chaves de configuração do Reinf:
    /// <see href="https://acbr.sourceforge.io/ACBrLib/ConfiguracoesdaBiblioteca12.html">Configurações da Biblioteca - ACBrLibReinf</see>
    /// </para>
    /// </summary>
    public sealed class ACBrReinfConfig : ACBrLibDFeConfig<IACBrLibReinf>
    {
        #region Constructors

        /// <summary>
        /// Cria uma nova instância da classe de configuração do ACBrReinf,
        /// associada a uma instância de <see cref="IACBrLibReinf"/>.
        /// </summary>
        /// <param name="acbrlib">Instância da interface de alto nível do ACBrReinf.</param>
        public ACBrReinfConfig(IACBrLibReinf acbrlib) : base(acbrlib, ACBrSessao.Reinf)
        {

        }

        #endregion Constructors

        #region Properties

        /// <summary>
        /// Obtém ou define o identificador do contribuinte (<c>IdContribuinte</c>),
        /// que deve ser o CNPJ ou CPF do contribuinte utilizado nos eventos do Reinf.
        /// </summary>
        public string IdContribuinte
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Obtém ou define o identificador do transmissor (<c>IdTransmissor</c>),
        /// que deve ser o CNPJ ou CPF do transmissor responsável pelo envio
        /// dos eventos ao Reinf.
        /// </summary>
        public string IdTransmissor
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Obtém ou define o tipo de contribuinte (<c>TipoContribuinte</c>),
        /// indicando se é pessoa jurídica, órgão público ou pessoa física,
        /// conforme valores esperados pela ACBrLibReinf.
        /// </summary>
        public TipoContribuinte TipoContribuinte
        {
            get => GetProperty<TipoContribuinte>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Obtém ou define a versão do Reinf (<c>VersaoDF</c>) utilizada na
        /// geração e envio dos eventos (por exemplo, v1_05_01, v2_01_02).
        /// </summary>
        public string VersaoDF
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se o caminho de gravação dos XML do Reinf deve considerar
        /// a data de emissão dos eventos (<c>EmissaoPathReinf</c>).
        /// </summary>
        public bool EmissaoPathReinf
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Caminho base onde serão salvos os XML dos eventos do Reinf
        /// (<c>PathReinf</c>).
        /// </summary>
        public string PathReinf
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        #endregion Properties
    }
}