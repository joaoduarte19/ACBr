using System;
using System.ComponentModel;

namespace ACBrLib.Core.NFSe
{
    /// <summary>
    /// Define o layout de impressão da NFSe.
    /// <para>Veja mais em: https://acbr.sourceforge.io/ACBrLib/ConfiguracoesdaBiblioteca22.html</para>
    /// </summary>
    public enum LayoutNFSe
    {
        /// <summary>
        /// Layout do provedor.
        /// </summary>
        [Description("Layout Provedor")]
        lnfsProvedor = 0,

        /// <summary>
        /// Layout Padrão Nacional versão 1.00.
        /// </summary>
        [Description("Layout Padrão Nacional")]
        lnfsPadraoNacionalv1 = 1,

        /// <summary>
        /// Layout Padrão Nacional versão 1.01.
        /// </summary>
        [Description("Layout Padrão Nacional v1.01")]
        lnfsPadraoNacionalv101 = 2
    }
}