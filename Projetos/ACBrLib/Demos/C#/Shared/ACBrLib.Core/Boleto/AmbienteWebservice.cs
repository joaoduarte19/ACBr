namespace ACBrLib.Core.Boleto
{
    /// <summary>
    /// Enumera os ambientes de webservice para configuração do Boleto.
    /// <para>Veja mais em: https://acbr.sourceforge.io/ACBrLib/ConfiguracoesdaBiblioteca18.html</para>
    /// </summary>
    public enum AmbienteWebservice
    {
        [EnumValue("0")]
        Producao,

        [EnumValue("1")]
        Homologaçao,

        [EnumValue("2")]
        SandBox,
    }
}