namespace ACBrLib.Core.DFe
{
    /// <summary>
    /// Define o ambiente de emissão do documento fiscal eletrônico.
    /// <para>Veja mais em: https://acbr.sourceforge.io/ACBrLib/DFe.html</para>
    /// </summary>
    public enum TipoAmbiente
    {
        /// <summary>
        /// Ambiente de produção.
        /// </summary>
        [EnumValue("1")]
        taProducao = 0,

        /// <summary>
        /// Ambiente de homologação.
        /// </summary>
        [EnumValue("2")]
        taHomologacao = 1
    }
}