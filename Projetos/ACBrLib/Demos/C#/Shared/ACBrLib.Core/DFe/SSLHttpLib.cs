namespace ACBrLib.Core.DFe
{
    /// <summary>
    /// Define a API de comunicação segura utilizada pela ACBrLib DFe.
    /// <para>Veja mais em: https://acbr.sourceforge.io/ACBrLib/DFe.html</para>
    /// </summary>
    public enum SSLHttpLib
    {
        /// <summary>
        /// Não utiliza API de comunicação segura.
        /// </summary>
        httpNone = 0,
        /// <summary>
        /// Utiliza a API WinINet.
        /// </summary>
        httpWinINet = 1,
        /// <summary>
        /// Utiliza a API WinHttp.
        /// </summary>
        httpWinHttp = 2,
        /// <summary>
        /// Utiliza a API OpenSSL.
        /// </summary>
        httpOpenSSL = 3,
        /// <summary>
        /// Utiliza a API Indy.
        /// </summary>
        httpIndy = 4
    }
}