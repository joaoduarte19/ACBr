using System.ComponentModel;

namespace ACBrLib.Core.PIXCD
{
    /// <summary>
    /// Enumera os ambientes de operação do PIXCD.
    /// <para>Veja mais em: https://acbr.sourceforge.io/ACBrLib/ConfiguracoesdaBiblioteca23.html</para>
    /// </summary>
    public enum Ambiente
    {
        [Description("Teste")]
        ambTeste = 0,

        [Description("Produção")]
        ambProducao = 1,

        [Description("Pré-Produção")]
        ambPreProducao = 2,
    }
}