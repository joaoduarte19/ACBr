using System;
using System.ComponentModel;

namespace ACBrLib.Core.NFSe
{
    /// <summary>
    /// Define o tipo de impressão do DANFSE (Retrato ou Paisagem).
    /// <para>Veja mais em: https://acbr.sourceforge.io/ACBrLib/ConfiguracoesdaBiblioteca22.html</para>
    /// </summary>
    public enum TipoDANFSE
    {
        /// <summary>
        /// Impressão em formato retrato.
        /// </summary>
        [Description("Retrato")]
        tiRetrato = 0,

        /// <summary>
        /// Impressão em formato paisagem.
        /// </summary>
        [Description("Paisagem")]
        tiPaisagem = 1,
    }
}