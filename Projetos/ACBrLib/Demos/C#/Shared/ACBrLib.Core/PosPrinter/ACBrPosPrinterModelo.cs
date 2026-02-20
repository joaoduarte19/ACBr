namespace ACBrLib.Core.PosPrinter
{
    /// <summary>
    /// Enumera os modelos suportados de impressoras PosPrinter para configuração.
    /// <para>Utilize o modelo correspondente à impressora instalada para garantir compatibilidade de comandos e recursos.</para>
    /// <para>Veja mais em: https://acbr.sourceforge.io/ACBrLib/ConfiguracoesdaBiblioteca.html</para>
    /// </summary>
    public enum ACBrPosPrinterModelo
    {
        /// <summary>
        /// Impressão em modo texto puro, sem comandos especiais.
        /// </summary>
        ppTexto,
        /// <summary>
        /// Impressoras compatíveis com o padrão ESC/POS Epson.
        /// </summary>
        ppEscPosEpson,
        /// <summary>
        /// Impressoras compatíveis com o padrão ESC/Bematech.
        /// </summary>
        ppEscBematech,
        /// <summary>
        /// Impressoras compatíveis com o padrão ESC/Daruma.
        /// </summary>
        ppEscDaruma,
        /// <summary>
        /// Impressoras compatíveis com o padrão ESC/Vox.
        /// </summary>
        ppEscVox,
        /// <summary>
        /// Impressoras compatíveis com o padrão ESC/Diebold.
        /// </summary>
        ppEscDiebold,
        /// <summary>
        /// Impressoras Epson com comandos ESC/POS P2.
        /// </summary>
        ppEscEpsonP2,
        /// <summary>
        /// Impressoras Custom POS.
        /// </summary>
        ppCustomPos,
        /// <summary>
        /// Impressoras compatíveis com o padrão ESC/POS Star.
        /// </summary>
        ppEscPosStar,
        /// <summary>
        /// Impressoras compatíveis com o padrão ESC/POS ZJiang.
        /// </summary>
        ppEscZJiang,
        /// <summary>
        /// Impressoras compatíveis com o padrão ESC/POS GPrinter.
        /// </summary>
        ppEscGPrinter,
        /// <summary>
        /// Impressoras compatíveis com o padrão ESC/POS Datecs.
        /// </summary>
        ppEscDatecs
    }
}