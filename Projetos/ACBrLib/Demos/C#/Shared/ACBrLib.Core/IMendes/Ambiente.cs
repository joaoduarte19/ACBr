using System.ComponentModel;

namespace ACBrLib.Core.IMendes
{
    /// <summary>
    /// Enumera os ambientes de acesso à API IMendes ([IMendes] Ambiente).
    /// </summary>
    public enum Ambiente
    {
        [Description("Nenhum")]
        imaNenhum = 0,

        [Description("Homologação")]
        imaHomologacao = 1,

        [Description("Produção")]
        imaProducao = 2,
    }
}
