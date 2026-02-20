namespace ACBrLib.Core.Boleto
{
    /// <summary>
    /// Enumera os layouts de impressão suportados para configuração do Boleto.
    /// <para>Veja mais em: https://acbr.sourceforge.io/ACBrLib/ConfiguracoesdaBiblioteca18.html</para>
    /// </summary>
    public enum ACBrBolLayOut
    {
        lPadrao,
        lCarne,
        lFatura,
        lPadraoEntrega,
        lReciboTopo,
        lPadraoEntrega2,
        lFaturaDetal,
        lTermica80mm,
        lPadraoPix,
        lPrestaServ
    }
}