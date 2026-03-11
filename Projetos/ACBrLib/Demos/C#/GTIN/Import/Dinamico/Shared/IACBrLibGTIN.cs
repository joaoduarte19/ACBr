
using System;
using ACBrLib.Core;

namespace ACBrLib.GTIN
{
    /// <summary>
    /// Interface para as bibliotecas ACBrLibGTIN
    /// </summary>
    public interface IACBrLibGTIN : IACBrLibBase, IDisposable
    {
        /// <summary>
        /// Propriedade de configuração para a biblioteca ACBrLibGTIN, permitindo acesso às opções de configuração específicas do GTIN.
        /// </summary>
        ACBrGTINConfig Config { get; }

        /// <summary>
        /// Consulta o código GTIN (código de barras) usando a biblioteca ACBrLib.
        /// </summary>
        /// <param name="aGTIN">Informe o GTIN (código de barras).</param>
        /// <returns>
        /// Retorna uma string contendo as informações da consulta.
        /// <para>Retorno 0: Biblioteca inicializada corretamente.</para>
        /// <para>Retorno -10: Erro ao executar o método.</para>
        /// <para>Exemplo de resposta: "CEST= NCM=4012090 cStat=9490 dhResp=21/10/2022 15:37:35 tpGTIN=13 xMotivo=Consulta realizada com sucesso xProd=LEITE PASTEURIZADO TIPO B"</para>
        /// </returns>
        string Consultar(string aGTIN);
    }
}
