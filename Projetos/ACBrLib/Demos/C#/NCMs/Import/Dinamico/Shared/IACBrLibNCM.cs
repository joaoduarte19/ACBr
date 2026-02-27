using System;
using ACBrLib.Core;

namespace ACBrLib.NCM
{
    /// <summary>
    /// Interface de alto nível para a biblioteca ACBrLib NCMs.
    /// <para>
    /// Expõe consulta à tabela NCM (Nomenclatura Comum do Mercosul), descrição,
    /// validação, download de lista e buscas por código ou descrição.
    /// </para>
    /// <para>
    /// Documentação geral: <see href="https://acbr.sourceforge.io/ACBrLib/">ACBrLib</see>
    /// Métodos NCM: <see href="https://acbr.sourceforge.io/ACBrLib/MetodosNCM.html">Métodos NCM</see>
    /// </para>
    /// </summary>
    public interface IACBrLibNCM : IACBrLibBase, IDisposable
    {
        /// <summary>
        /// Configurações da biblioteca ACBrLib NCMs (sessão [NCM]).
        /// </summary>
        ACBrNCMConfig Config { get; }

        /// <summary>
        /// Retorna a descrição do NCM informado. Corresponde a NCM_DescricaoNCM.
        /// </summary>
        /// <param name="cNCM">Código NCM.</param>
        /// <returns>Descrição do NCM.</returns>
        string DescricaoNCM(string cNCM);

        /// <summary>
        /// Valida o código NCM. Corresponde a NCM_Validar.
        /// </summary>
        /// <param name="cNCM">Código NCM a validar.</param>
        /// <returns>Retorno textual da validação.</returns>
        string Validar(string cNCM);

        /// <summary>
        /// Baixa a lista de NCMs. Corresponde a NCM_BaixarLista.
        /// </summary>
        /// <param name="cNomeArquivo">Nome do arquivo para gravação.</param>
        /// <returns>Retorno textual da operação.</returns>
        string BaixarLista(string cNomeArquivo);

        /// <summary>
        /// Obtém a lista de NCMs carregada. Corresponde a NCM_ObterNCMs.
        /// </summary>
        /// <returns>Conteúdo da lista de NCMs.</returns>
        string ObterNCMs();

        /// <summary>
        /// Busca NCM por código. Corresponde a NCM_BuscarPorCodigo.
        /// </summary>
        /// <param name="cNCM">Código NCM.</param>
        /// <returns>Retorno textual com o NCM encontrado.</returns>
        string BuscarPorCodigo(string cNCM);

        /// <summary>
        /// Busca NCMs por descrição. Corresponde a NCM_BuscarPorDescricao.
        /// </summary>
        /// <param name="cDesc">Texto da descrição.</param>
        /// <param name="nTipo">Tipo de busca conforme documentação.</param>
        /// <returns>Retorno textual com os NCMs encontrados.</returns>
        string BuscarPorDescricao(string cDesc, int nTipo);
    }
}
