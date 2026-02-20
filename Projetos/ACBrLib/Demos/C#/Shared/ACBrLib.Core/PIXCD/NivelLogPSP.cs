using System.ComponentModel;

namespace ACBrLib.Core.PIXCD
{
    /// <summary>
    /// Enumera os níveis de log para PSP no PIXCD.
    /// <para>Veja mais em: https://acbr.sourceforge.io/ACBrLib/ConfiguracoesdaBiblioteca23.html</para>
    /// </summary>
    public enum NivelLogPSP
    {
        [Description("Nenhum")]
        logPSPNenhum = 0,

        [Description("Baixo")]
        logPSPBaixo = 1,

        [Description("Normal")]
        logPSPNormal = 2,

        [Description("Alto")]
        logPSPAlto = 3,

        [Description("Muito Alto")]
        logPSPMuitoAlto = 4,
    }
}