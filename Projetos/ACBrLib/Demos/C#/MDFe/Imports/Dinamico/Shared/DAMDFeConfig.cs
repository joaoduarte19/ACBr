using ACBrLib.Core;
using ACBrLib.Core.Config;
using ACBrLib.Core.DFe;
using ACBrLib.Core.MDFe;

namespace ACBrLib.MDFe
{
    /// <summary>
    /// Representa as configurações de impressão do DAMDFe (Documento Auxiliar do MDF-e) para a ACBrLibMDFe.
    /// Permite configurar opções de layout, impressão, margens, visualização e outros detalhes do documento auxiliar.
    /// Veja mais detalhes em:
    /// https://acbr.sourceforge.io/ACBrLib/ConfiguracoesdaBiblioteca14.html
    /// </summary>
    public sealed class DAMDFeConfig : ReportConfig<IACBrLibMDFe>
    {
        #region Constructors

        /// <summary>
        /// Inicializa uma nova instância da configuração de impressão do DAMDFe.
        /// </summary>
        /// <param name="acbrlib">Instância da interface de comunicação com a biblioteca ACBrLibMDFe.</param>
        public DAMDFeConfig(IACBrLibMDFe acbrlib) : base(acbrlib, ACBrSessao.DAMDFe)
        {
        }

        #endregion Constructors

        #region Properties

        /// <summary>
        /// Define se será impressa a hora de saída no DAMDFe.
        /// </summary>
        public bool ImprimeHoraSaida
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define um horário personalizado para impressão no DAMDFe (requer ImprimeHoraSaida = true).
        /// </summary>
        public bool ImprimirHoraSaida_Hora
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Tipo de impressão do DAMDFe: Sem geração, Retrato ou Paisagem.
        /// </summary>
        public TipoDAMDFe TipoDAMDFe
        {
            get => GetProperty<TipoDAMDFe>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Tamanho do papel para impressão do DAMDFe (ex: A4, A4 2 vias, A5).
        /// </summary>
        public TamanhoPapel TamanhoPapel
        {
            get => GetProperty<TamanhoPapel>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Protocolo a ser impresso no DAMDFe.
        /// </summary>
        public string Protocolo
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se será impressa a faixa de cancelada no DAMDFe.
        /// </summary>
        public bool Cancelada
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se o MDF-e já foi encerrado (impressão).
        /// </summary>
        public bool Encerrado
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se o logotipo será expandido para ocupar todo o local de impressão.
        /// </summary>
        public bool ExpandeLogoMarca
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se imprime o município de descarregamento para cada documento (não recomendado pela documentação oficial do DAMFe).
        /// </summary>
        public bool ExibirMunicipioDescarregamento
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        #endregion Properties
    }
}