namespace ACBrLib.Core.NFe
{
    /// <summary>
    /// Enumera os tipos de crédito para configuração da NFe.
    /// </summary>
    public enum TipoNFeCredito
    {
        [EnumValue("")]
        tcNenhum,
        [EnumValue("01")]
        tcMultaJuros,
        [EnumValue("02")]
        tcApropriacaoCreditoPresumido,
        [EnumValue("03")]
        tcRetorno,
        [EnumValue("04")]
        tcReducaoValores,
        [EnumValue("05")]
        tcTransferenciaCreditoSucessao
    }
}

