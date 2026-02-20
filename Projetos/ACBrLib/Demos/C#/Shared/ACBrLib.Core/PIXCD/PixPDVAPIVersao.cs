using System.ComponentModel;

namespace ACBrLib.Core.PIXCD
{
    /// <summary>
    /// Enumera as versões da API PixPDV suportadas pelo PIXCD.
    /// <para>Veja mais em: https://acbr.sourceforge.io/ACBrLib/ConfiguracoesdaBiblioteca23.html</para>
    /// </summary>
    public enum PixPDVAPIVersao
    {
        [Description("API Versão 1")]
        apiVersao1 = 0,

        [Description("API Versão Mediator")]
        apiVersaoMediator = 1,
    }
}