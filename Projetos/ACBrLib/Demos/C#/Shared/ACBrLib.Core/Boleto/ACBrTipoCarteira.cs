namespace ACBrLib.Core.Boleto
{
    /// <summary>
    /// Enumera os tipos de carteira para configuração do Boleto.
    /// <para>Veja mais em: https://acbr.sourceforge.io/ACBrLib/ConfiguracoesdaBiblioteca18.html</para>
    /// </summary>
    public enum ACBrTipoCarteira
    {
        tctSimples = 0,
        tctRegistrada = 1,
        tctEletronica = 2
    }
}