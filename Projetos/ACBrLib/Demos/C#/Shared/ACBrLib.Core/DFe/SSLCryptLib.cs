namespace ACBrLib.Core.DFe
{
    /// <summary>
    /// Define o engine da biblioteca de criptografia utilizado pela ACBrLib DFe.
    /// <para>Veja mais em: https://acbr.sourceforge.io/ACBrLib/DFe.html</para>
    /// </summary>
    public enum SSLCryptLib
    {
        /// <summary>
        /// Não utiliza biblioteca de criptografia.
        /// </summary>
        cryNone = 0,
        /// <summary>
        /// Utiliza a biblioteca OpenSSL.
        /// </summary>
        cryOpenSSL = 1,
        /// <summary>
        /// Utiliza a biblioteca Capicom (não ativo na compilação ACBr).
        /// </summary>
        cryCapicom = 2,
        /// <summary>
        /// Utiliza a biblioteca WinCrypt.
        /// </summary>
        cryWinCrypt = 3
    }
}