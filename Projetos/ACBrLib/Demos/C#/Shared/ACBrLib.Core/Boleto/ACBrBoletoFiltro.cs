namespace ACBrLib.Core.Boleto
{
    /// <summary>
    /// Enumera os filtros de saída para geração do Boleto.
    /// <para>Veja mais em: https://acbr.sourceforge.io/ACBrLib/ConfiguracoesdaBiblioteca18.html</para>
    /// </summary>
    public enum ACBrBoletoFiltro
    {
        fiNenhum,
        fiPDF,
        fiHTML,
        fiJPG
    }
}