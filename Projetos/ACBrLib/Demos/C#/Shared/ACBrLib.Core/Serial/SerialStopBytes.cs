namespace ACBrLib.Core.Serial
{
    /// <summary>
    /// Define o número de bits de parada na comunicação serial.
    /// <para>Veja mais em: https://acbr.sourceforge.io/ACBrLib/ConfiguracoesdaBiblioteca3.html</para>
    /// </summary>
    public enum SerialStopBytes
    {
        /// <summary>1 bit de parada</summary>
        One,
        /// <summary>1,5 bits de parada</summary>
        OnePointFive,
        /// <summary>2 bits de parada</summary>
        Two
    }
}