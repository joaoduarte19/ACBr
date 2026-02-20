namespace ACBrLib.Core.Boleto
{
    /// <summary>
    /// Enumera os tipos de saída para geração do Boleto.
    /// <para>Veja mais em: https://acbr.sourceforge.io/ACBrLib/ConfiguracoesdaBiblioteca18.html</para>
    /// </summary>
    public enum BoletoTpSaida
    {
        Imprimir = 'I',
        PDF = 'P',
        Email = 'E'
    }
}