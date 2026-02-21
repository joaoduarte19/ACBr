using ACBrLib.Core;
using ACBrLib.Core.Config;
using ACBrLib.Core.MDFe;

namespace ACBrLib.MDFe
{
    /// <summary>
    /// Representa as configurações específicas do componente ACBrLibMDFe.
    /// Permite configurar caminhos, opções de salvamento, versão do MDF-e, normatização de municípios e dados de segurança.
    /// Veja mais detalhes em:
    /// https://acbr.sourceforge.io/ACBrLib/ConfiguracoesdaBiblioteca14.html
    /// </summary>
    public sealed class MDFeConfig : ACBrLibDFeConfig<IACBrLibMDFe>
    {
        #region Constructors

        /// <summary>
        /// Inicializa uma nova instância da classe de configuração do MDF-e.
        /// </summary>
        /// <param name="acbrlib">Instância da interface de comunicação com a biblioteca ACBrLibMDFe.</param>
        public MDFeConfig(IACBrLibMDFe acbrlib) : base(acbrlib, ACBrSessao.MDFe)
        {
            DAMDFe = new DAMDFeConfig(acbrlib);
        }

        #endregion Constructors

        #region Properties

        /// <summary>
        /// Configurações do DAMDFe (impressão do documento auxiliar do MDF-e).
        /// </summary>
        public DAMDFeConfig DAMDFe { get; }

        /// <summary>
        /// Define se o caminho de salvamento dos XMLs do MDF-e deve considerar a data de emissão.
        /// </summary>
        public bool EmissaoPathMDFe
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Caminho onde serão salvos os XMLs do MDF-e.
        /// </summary>
        public string PathMDFe
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Caminho onde serão salvos os XMLs de eventos do MDF-e (cancelamento, encerramento, inclusões).
        /// </summary>
        public string PathEvento
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Caminho do arquivo TXT para normatização dos nomes dos municípios.
        /// </summary>
        public string PathArquivoMunicipios
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Versão do MDF-e utilizada (ex: ve100, ve300).
        /// </summary>
        public VersaoMDFe VersaoDF
        {
            get => GetProperty<VersaoMDFe>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se somente os XMLs dos MDF-e processados (autorizados) serão salvos.
        /// </summary>
        public bool SalvarApenasMDFeProcessados
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se os nomes dos municípios serão normatizados ao gerar o XML do MDF-e.
        /// </summary>
        public bool NormatizarMunicipios
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Identificador do CSRT (Código de Segurança do Responsável Técnico).
        /// </summary>
        public string IdCSRT
        {
            get => GetProperty<string>();
            set => SetProperty<string>(value);
        }

        /// <summary>
        /// Código de Segurança do Responsável Técnico (CSRT).
        /// </summary>
        public string CSRT
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }
        #endregion Properties
    }
}