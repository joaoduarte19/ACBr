namespace ACBrLib.Core.DFe
{
    /// <summary>
    /// Define a API de manipulação do XML para assinatura digital utilizada pela ACBrLib DFe.
    /// <para>Veja mais em: https://acbr.sourceforge.io/ACBrLib/DFe.html</para>
    /// </summary>
    public enum SSLXmlSignLib
    {
        /// <summary>
        /// Não utiliza API de assinatura digital.
        /// </summary>
        xsNone = 0,
        /// <summary>
        /// Utiliza a API XmlSec (não ativo na compilação ACBr).
        /// </summary>
        xsXmlSec = 1,
        /// <summary>
        /// Utiliza a API MsXml (não ativo na compilação ACBr).
        /// </summary>
        xsMsXml = 2,
        /// <summary>
        /// Utiliza a API MsXmlCapicom (não ativo na compilação ACBr).
        /// </summary>
        xsMsXmlCapicom = 3,
        /// <summary>
        /// Utiliza a API LibXml2.
        /// </summary>
        xsLibXml2 = 4
    }
}