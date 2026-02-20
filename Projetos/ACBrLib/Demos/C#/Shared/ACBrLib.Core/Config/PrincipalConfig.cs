namespace ACBrLib.Core.Config
{
    /// <summary>
    /// Configurações principais da ACBrLib.
    /// <para>Define parâmetros gerais como formato e codificação da resposta, nível e caminho do log.</para>
    /// <para>Veja mais em: https://acbr.sourceforge.io/ACBrLib/Geral.html</para>
    /// </summary>
    public sealed class PrincipalConfig<TLib> : ACBrLibConfigBase<TLib> where TLib : IACBrLibBase
    {
        #region Constructors

        /// <summary>
        /// Inicializa a configuração principal da biblioteca.
        /// </summary>
        /// <param name="acbrlib">Instância da biblioteca ACBrLib.</param>
        public PrincipalConfig(TLib acbrlib) : base(acbrlib, ACBrSessao.Principal)
        {
        }

        #endregion Constructors

        #region Properties

        /// <summary>
        /// Define o formato da resposta da biblioteca.
        /// <para>0 = INI (Padrão), 1 = XML, 2 = JSON</para>
        /// </summary>
        public TipoResposta TipoResposta
        {
            get => GetProperty<TipoResposta>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define a codificação das respostas.
        /// <para>0 = UTF8 (Padrão), 1 = ANSI</para>
        /// </summary>
        public CodResposta CodificacaoResposta
        {
            get => GetProperty<CodResposta>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define o nível do log da biblioteca.
        /// <para>0 = Nenhum, 1 = Simples, 2 = Normal, 3 = Completo, 4 = Paranoico</para>
        /// </summary>
        public NivelLog LogNivel
        {
            get => GetProperty<NivelLog>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Caminho onde será salvo o arquivo de log da biblioteca.
        /// <para>Padrão: vazio</para>
        /// </summary>
        public string LogPath
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        #endregion Properties
    }
}