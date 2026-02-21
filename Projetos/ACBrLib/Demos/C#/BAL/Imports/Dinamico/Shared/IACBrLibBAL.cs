using System;
using ACBrLib.Core;

namespace ACBrLib.BAL
{
    /// <summary>
    /// Interface para comunicação com balanças utilizando a ACBrLibBAL.
    /// </summary>
    public interface IACBrLibBAL : IACBrLibBase, IDisposable
    {
        /// <summary>
        /// Configurações da balança.
        /// </summary>
        BALConfig Config { get; }

        /// <summary>
        /// Ativa o componente ACBrBAL.
        /// <para>Retornos possíveis: 0 (sucesso), -1 (biblioteca não inicializada), -10 (erro ao ativar).</para>
        /// </summary>
        void Ativar();

        /// <summary>
        /// Desativa o componente ACBrBAL.
        /// <para>Retornos possíveis: 0 (sucesso), -1 (biblioteca não inicializada), -10 (erro ao desativar).</para>
        /// </summary>
        void Desativar();

        /// <summary>
        /// Lê o peso da balança.
        /// </summary>
        /// <param name="MillisecTimeOut">Timeout em milissegundos para leitura do peso.</param>
        /// <returns>Peso lido da balança.</returns>
        /// <remarks>Retornos possíveis: 0 (sucesso), -1 (biblioteca não inicializada), -10 (erro ao ler o peso).</remarks>
        decimal LePeso(int MillisecTimeOut = 1000);

        /// <summary>
        /// Solicita o peso da balança.
        /// <para>Retornos possíveis: 0 (sucesso), -1 (biblioteca não inicializada), -10 (erro ao solicitar o peso).</para>
        /// </summary>
        void SolicitarPeso();

        /// <summary>
        /// Retorna o último peso lido da balança.
        /// </summary>
        /// <returns>Último peso lido.</returns>
        decimal UltimoPesoLido();

        /// <summary>
        /// Interpreta a resposta da balança e retorna o peso.
        /// </summary>
        /// <param name="resposta">Resposta recebida da balança.</param>
        /// <returns>Peso interpretado da resposta.</returns>
        /// <remarks>Retornos possíveis: 0 (sucesso), -1 (biblioteca não inicializada), -10 (erro ao interpretar resposta).</remarks>
        decimal InterpretarRespostaPeso(string resposta);
    }
}