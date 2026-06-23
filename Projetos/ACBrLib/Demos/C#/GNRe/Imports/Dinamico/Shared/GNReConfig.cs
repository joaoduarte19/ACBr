using ACBrLib.Core;
using ACBrLib.Core.Config;
using ACBrLib.Core.GNRe;

namespace ACBrLib.GNRe
{
    /// <summary>
    /// Configurações da seção GNRe da ACBrLib.
    /// </summary>
    public sealed class GNReConfig : ACBrLibDFeConfig<IACBrLibGNRe>
    {
        #region Constructors

        /// <summary>
        /// Inicializa uma nova instância da classe <see cref="GNReConfig"/>.
        /// </summary>
        /// <param name="acbrlib">Instância da biblioteca GNRe.</param>
        public GNReConfig(IACBrLibGNRe acbrlib) : base(acbrlib, ACBrSessao.GNRe)
        {
            Guia = new GuiaConfig(acbrlib);
        }

        #endregion Constructors

        #region Properties

        /// <summary>
        /// Configurações de impressão e geração da seção Guia.
        /// </summary>
        public GuiaConfig Guia { get; }

        /// <summary>
        /// Define se a estrutura de pastas considera a data de emissão da GNRe.
        /// Chave: EmissaoPathGNRe (0 = Não, 1 = Sim).
        /// </summary>
        public bool EmissaoPathGNRe
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Caminho onde serão salvos os XML de GNRe.
        /// Chave: PathGNRe.
        /// </summary>
        public string PathGNRe
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Caminho onde serão salvos os arquivos TXT com os dados para impressão das guias.
        /// Chave: PathArqTxt.
        /// </summary>
        public string PathArqTxt
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se os arquivos TXT das guias serão salvos em disco.
        /// Chave: SalvarTXT (0 = Não, 1 = Sim).
        /// </summary>
        public bool SalvarTXT
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define a versão do documento GNRe.
        /// Chave: VersaoDF (atualmente: 0 = ve100).
        /// </summary>
        public VersaoGNRe VersaoDF
        {
            get => GetProperty<VersaoGNRe>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se somente XML de GNRe processadas (autorizadas) serão salvos.
        /// Chave: SalvarApenasGNReProcessados (0 = Não, 1 = Sim).
        /// </summary>
        public bool SalvarApenasGNReProcessados
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        #endregion Properties
    }
}