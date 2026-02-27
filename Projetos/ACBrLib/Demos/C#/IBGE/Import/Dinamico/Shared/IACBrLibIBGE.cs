using System;
using ACBrLib.Core;
namespace ACBrLib.IBGE
{
    /// <summary>
    /// Interface para acesso aos métodos do componente ACBrIBGE.
    /// Permite consultar informações de municípios brasileiros pelo código IBGE ou pelo nome.
    /// </summary>
    public interface IACBrLibIBGE : IACBrLibBase, IDisposable
    {
        /// <summary>
        /// Configurações do componente ACBrIBGE.
        /// </summary>
        ACBrIBGEConfig Config { get; }

        /// <summary>
        /// Realiza uma consulta pelo código IBGE do município.
        /// </summary>
        /// <param name="ACodMun">Código IBGE do município a ser consultado.</param>
        /// <returns>
        /// String contendo as informações do município consultado.
        /// Exemplo: [Cidade1] UF=SP CodUF=35 Municipio=Tatuí CodMunicio=3554003 Area=524,156
        /// Retorno: 0 ou &gt; indica sucesso e quantidade de cidades encontradas; -1 indica biblioteca não inicializada; -10 indica erro na consulta.
        /// </returns>
        string buscarPorCodigo(int ACodMun);

        /// <summary>
        /// Realiza uma consulta pelo nome do município e UF.
        /// </summary>
        /// <param name="eCidade">Nome da cidade a ser consultada.</param>
        /// <param name="eUF">Sigla da UF (estado) da cidade.</param>
        /// <param name="exata">Define se a consulta será exata (true) ou parcial (false).</param>
        /// <returns>
        /// String contendo as informações dos municípios encontrados.
        /// Exemplo: [Cidade1] UF=PE CodUF=26 Municipio=Petrolina CodMunicio=2611101 Area=4558,537
        /// Retorno: 0 ou &gt; indica sucesso e quantidade de cidades encontradas; -1 indica biblioteca não inicializada; -10 indica erro na consulta.
        /// </returns>
        string buscarPorNome(string eCidade, string eUF, bool exata);
    }
}
