namespace ACBrLib.Core.DFe
{
    /// <summary>
    /// Define o tipo de comunicação segura utilizada pela ACBrLib DFe.
    /// <para>Veja mais em: https://acbr.sourceforge.io/ACBrLib/DFe.html</para>
    /// </summary>
    public enum SSLType
    {
        /// <summary>
        /// Permite todos os tipos de comunicação segura.
        /// </summary>
        LT_all = 0,
        /// <summary>
        /// Utiliza o protocolo SSLv2.
        /// </summary>
        LT_SSLv2 = 1,
        /// <summary>
        /// Utiliza o protocolo SSLv3.
        /// </summary>
        LT_SSLv3 = 2,
        /// <summary>
        /// Utiliza o protocolo TLSv1.
        /// </summary>
        LT_TLSv1 = 3,
        /// <summary>
        /// Utiliza o protocolo TLSv1.1.
        /// </summary>
        LT_TLSv1_1 = 4,
        /// <summary>
        /// Utiliza o protocolo TLSv1.2.
        /// </summary>
        LT_TLSv1_2 = 5,
        /// <summary>
        /// Utiliza o protocolo SSHv2.
        /// </summary>
        LT_SSHv2 = 6
    }
}