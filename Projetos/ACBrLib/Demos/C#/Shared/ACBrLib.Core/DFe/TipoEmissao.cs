using System;
using System.ComponentModel;

namespace ACBrLib.Core.DFe
{
    /// <summary>
    /// Define o tipo de emissão do documento fiscal eletrônico.
    /// <para>Veja mais em: https://acbr.sourceforge.io/ACBrLib/DFe.html</para>
    /// </summary>
    public enum TipoEmissao
    {
        /// <summary>
        /// Emissão normal (não em contingência).
        /// </summary>
        [EnumValue("1")]
        [Description("Emissão normal (não em contingência)")]
        teNormal = 0,

        /// <summary>
        /// Contingência FS-IA, com impressão do DANFE em formulário de segurança.
        /// </summary>
        [EnumValue("2")]
        [Description("Contingência FS-IA, com impressão do DANFE em formulário de segurança")]
        teContingencia = 1,

        /// <summary>
        /// Contingência SCAN (Sistema de Contingência do Ambiente Nacional).
        /// </summary>
        [EnumValue("3")]
        [Description("Contingência SCAN(Sistema de Contingência do Ambiente Nacional)")]
        teSCAN = 2,

        /// <summary>
        /// Contingência DPEC (Declaração Prévia da Emissão em Contingência).
        /// </summary>
        [EnumValue("4")]
        [Description("Contingência DPEC(Declaração Prévia da Emissão em Contingência)")]
        teDPEC = 3,

        /// <summary>
        /// Contingência FS-DA, com impressão do DANFE em formulário de segurança.
        /// </summary>
        [EnumValue("5")]
        [Description("Contingência FS-DA, com impressão do DANFE em formulário de segurança")]
        teFSDA = 4,

        /// <summary>
        /// Contingência SVC-AN (SEFAZ Virtual de Contingência do AN).
        /// </summary>
        [EnumValue("6")]
        [Description("Contingência SVC-AN(SEFAZ Virtual de Contingência do AN)")]
        teSVCAN = 5,

        /// <summary>
        /// Contingência SVC-RS (SEFAZ Virtual de Contingência do RS).
        /// </summary>
        [EnumValue("7")]
        [Description("Contingência SVC-RS(SEFAZ Virtual de Contingência do RS)")]
        teSVCRS = 6,

        /// <summary>
        /// Contingência SVC-SP (SEFAZ Virtual de Contingência de SP).
        /// </summary>
        [EnumValue("8")]
        [Description("Contingência SVC-SP(SEFAZ Virtual de Contingência de SP)")]
        teSVCSP = 7,

        /// <summary>
        /// Contingência off-line da NFC-e (as demais opções de contingência são válidas também para a NFC-e).
        /// </summary>
        [EnumValue("9")]
        [Description("Contingência off-line da NFC-e(as demais opções de contingência são válidas também para a NFC-e)")]
        teOffLine = 8
    }
}