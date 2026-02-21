using ACBrLib.Core;
using ACBrLib.Core.Config;

namespace ACBrLib.NFe
{
    /// <summary>
    /// Representa as configurações de fonte da linha de item da DANFE NFC-e, baseadas na interface IACBrLibNFe.
    /// </summary>
    public sealed class FonteDANFCeConfig : ACBrLibConfigBase<IACBrLibNFe>
    {
        #region Constructors

        /// <summary>
        /// Inicializa uma nova instância da classe de configurações de fonte da DANFE NFC-e.
        /// </summary>
        /// <param name="acbrlib">Instância da interface IACBrLibNFe utilizada pela configuração.</param>
        /// <param name="sessao">Sessão de configuração utilizada para leitura e escrita das propriedades.</param>
        public FonteDANFCeConfig(IACBrLibNFe acbrlib, ACBrSessao sessao) : base(acbrlib, sessao)
        {
            SubName = "FonteLinhaItem";
        }

        #endregion Constructors

        #region Properties

        /// <summary>
        /// Define o nome da fonte utilizada na impressão do item da NFCe.
        /// </summary>
        public string Name
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define a cor da fonte utilizada na impressão do item da NFCe.
        /// </summary>
        public string Color
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define o tamanho da fonte utilizada na impressão do item da NFCe.
        /// </summary>
        public int Size
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se deve ou não utilizar fonte em negrito: 0 = Não, 1 = Sim.
        /// </summary>
        public bool Bold
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se deve ou não utilizar fonte em itálico: 0 = Não, 1 = Sim.
        /// </summary>
        public bool Italic
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se deve ou não utilizar fonte sublinhada: 0 = Não, 1 = Sim.
        /// </summary>
        public bool Underline
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se deve ou não utilizar fonte com risco (strikeout): 0 = Não, 1 = Sim.
        /// </summary>
        public bool StrikeOut
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        #endregion Properties
    }
}