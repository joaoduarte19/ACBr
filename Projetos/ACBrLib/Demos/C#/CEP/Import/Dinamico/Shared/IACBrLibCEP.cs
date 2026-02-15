using System;
using System.Linq;
using System.Text;
using ACBrLib.Core;
namespace ACBrLib.CEP
{
    /// <summary>
    /// Interface de definição do ACBrLibCEP
    /// </summary>
    public interface IACBrLibCEP : IACBrLibBase, IDisposable
    {

        /// <summary>
        /// Configurações do componente ACBrCEP, permitindo acesso e modificação das propriedades de configuração do componente.
        /// </summary>
        ACBrCEPConfig Config { get; }

        /// <summary>
        /// Método usado para realizar uma consulta pelo numero do CEP no componente ACBrCEP.
        /// </summary>
        /// <param name="eCEP">O número do CEP a ser consultado.</param>
        /// <returns>Um objeto ACBrEndereco contendo as informações do endereço correspondente ao CEP informado.</returns>
        ACBrEndereco BuscarPorCep(string eCEP);
        /// <summary>
        /// Método usado para realizar uma consulta pelo logradouro no componente ACBrCEP
        /// </summary>
        /// <param name="eCidade">O nome da cidade onde o logradouro está localizado.</param>
        /// <param name="eTipoLogradouro">O tipo de logradouro (ex: Rua, Avenida, Praça).</param>
        /// <param name="eLogradouro">Nome do logradouro</param>
        /// <param name="eUF">UF (Estado) </param>
        /// <param name="eBairro">Bairro</param>
        /// <returns>Um array de objetos ACBrEndereco contendo as informações dos endereços correspondentes aos critérios informados.</returns>
        ACBrEndereco[] BuscarPorLogradouro(string eCidade, string eTipoLogradouro, string eLogradouro, string eUF, string eBairro);
    }
    
}