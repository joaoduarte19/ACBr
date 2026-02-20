namespace ACBrLib.Core.Serial
{
    /// <summary>
    /// Define o tipo de handshake (controle de fluxo) da porta serial.
    /// <para>Veja mais em: https://acbr.sourceforge.io/ACBrLib/ConfiguracoesdaBiblioteca3.html</para>
    /// </summary>
    public enum SerialHandShake
    {
        /// <summary>Sem handshake</summary>
        Nenhum,
        /// <summary>XON/XOFF (controle por software)</summary>
        XON_XOFF,
        /// <summary>RTS/CTS (controle por hardware)</summary>
        RTS_CTS,
        /// <summary>DTR/DSR (controle por hardware)</summary>
        DTR_DSR
    }
}