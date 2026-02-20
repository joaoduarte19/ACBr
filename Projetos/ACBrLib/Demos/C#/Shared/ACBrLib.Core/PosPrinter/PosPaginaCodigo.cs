namespace ACBrLib.Core.PosPrinter
{
    /// <summary>
    /// Enumera as páginas de código suportadas pela PosPrinter para configuração de charset.
    /// <para>Veja mais em: https://acbr.sourceforge.io/ACBrLib/BemVindo.html</para>
    /// </summary>
    public enum PosPaginaCodigo
    {
        None,
        pc437,
        pc850,
        pc852,
        pc860,
        pcUTF8,
        pc1252
    }
}