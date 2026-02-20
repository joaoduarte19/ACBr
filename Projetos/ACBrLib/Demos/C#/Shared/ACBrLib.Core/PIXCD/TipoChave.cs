using System.ComponentModel;

namespace ACBrLib.Core.PIXCD
{
    /// <summary>
    /// Enumera os tipos de chave PIX para configuração do PIXCD.
    /// <para>Veja mais em: https://acbr.sourceforge.io/ACBrLib/ConfiguracoesdaBiblioteca23.html</para>
    /// </summary>
    public enum TipoChave
    {
        [Description("Nenhuma")]
        tchNenhuma = 0,

        [Description("Email")]
        tchEmail = 1,

        [Description("CPF")]
        tchCPF = 2,

        [Description("CNPJ")]
        tchCNPJ = 3,

        [Description("Celular")]
        tchCelular = 4,

        [Description("Aleatoria")]
        tchAleatoria = 5,
    }
}