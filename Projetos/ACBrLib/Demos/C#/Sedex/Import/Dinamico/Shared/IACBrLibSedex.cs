using System;
using ACBrLib.Core;

namespace ACBrLib.Sedex
{
    /// <summary>
    /// Interface de alto nível para a biblioteca ACBrLib Sedex.
    /// <para>
    /// Expõe consulta de preços e prazos e rastreamento de encomendas
    /// nos Correios, conforme documentação oficial da ACBrLib.
    /// </para>
    /// <para>
    /// Documentação: <see href="https://acbr.sourceforge.io/ACBrLib/MetodosSedex.html">Métodos Sedex</see>
    /// (Sedex_Consultar, Sedex_Rastrear, Sedex_LerArqIni).
    /// </para>
    /// </summary>
    public interface IACBrLibSedex : IACBrLibBase, IDisposable
    {
        /// <summary>
        /// Configurações da biblioteca (sessão <c>[Sedex]</c>).
        /// </summary>
        ACBrSedexConfig Config { get; }

        /// <summary>
        /// Consulta preços e prazos no webservice dos Correios (Sedex_Consultar).
        /// </summary>
        /// <returns>Resposta em string com o retorno da consulta.</returns>
        string Consultar();

        /// <summary>
        /// Rastreia uma encomenda pelo código de rastreio (Sedex_Rastrear).
        /// </summary>
        /// <param name="eCodRastreio">Código de rastreio da encomenda.</param>
        /// <returns>Resposta em string com os dados de rastreamento.</returns>
        string Rastrear(string eCodRastreio);
    }
}
