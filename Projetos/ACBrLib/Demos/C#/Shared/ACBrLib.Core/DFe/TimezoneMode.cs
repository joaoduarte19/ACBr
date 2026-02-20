namespace ACBrLib.Core.DFe
{
    /// <summary>
    /// Define o modo de configuração de fuso horário utilizado pela ACBrLib DFe.
    /// <para>Veja mais em: https://acbr.sourceforge.io/ACBrLib/DFe.html</para>
    /// </summary>
    public enum TimezoneMode
    {
        /// <summary>
        /// Utiliza o fuso horário do sistema operacional.
        /// </summary>
        tzSistema = 0,
        /// <summary>
        /// Utiliza o fuso horário padrão nacional.
        /// </summary>
        tzPCN = 1,
        /// <summary>
        /// Permite configuração manual do fuso horário.
        /// </summary>
        tzManual = 2
    }
}