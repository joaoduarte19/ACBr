namespace ACBrLib.Core.Config
{
    /// <summary>
    /// Configurações para download de arquivos na ACBrLib.
    /// <para>Permite definir o caminho e opções de separação para arquivos baixados.</para>
    /// <para>Veja mais em: https://acbr.sourceforge.io/ACBrLib/BemVindo.html</para>
    /// </summary>
    public class DownloadConfig<TLib> : ACBrLibConfig<TLib> where TLib : IACBrLibBase
    {
        #region Constructors

        /// <summary>
        /// Inicializa a configuração de download.
        /// </summary>
        /// <param name="acbrlib">Instância da biblioteca ACBrLib.</param>
        /// <param name="sessao">Sessão de configuração.</param>
        public DownloadConfig(TLib acbrlib, ACBrSessao sessao) : base(acbrlib, sessao)
        {
            SubName = "Download";
        }

        #endregion Constructors

        #region Properties

        /// <summary>
        /// Caminho onde os arquivos baixados serão salvos.
        /// </summary>
        public string PathDownload
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se os arquivos baixados devem ser separados por nome.
        /// </summary>
        public string SepararPorNome
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        #endregion Properties
    }
}