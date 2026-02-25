using System;
using ACBrLib.Core;
namespace ACBrLib.ConsultaCNPJ
{

    /// <summary>
    /// Interface de alto nível para a biblioteca ACBrConsultaCNPJ.
    /// <para>
    /// Permite consultar informações cadastrais de empresas a partir do CNPJ, conforme documentação oficial da ACBrLib.
    /// </para>
    /// <para>
    /// Consulte: https://acbr.sourceforge.io/ACBrLib/CNPJ_Consultar.html
    /// </para>
    /// </summary>
    public interface IACBrLibConsultaCNPJ : IACBrLibBase, IDisposable
    {
        /// <summary>
        /// Obtém as configurações da biblioteca ACBrConsultaCNPJ.
        /// </summary>
        ACBrCNPJConfig Config { get; }

        /// <summary>
        /// Consulta informações cadastrais de um CNPJ na base da Receita Federal.
        /// </summary>
        /// <param name="eCNPJ">CNPJ a ser consultado. Informe apenas números, sem formatação.</param>
        /// <returns>
        /// Retorna uma string contendo os dados cadastrais da empresa consultada, conforme resposta da Receita Federal.
        /// <para>Exemplo de resposta:</para>
        /// <para>
        /// Abertura=27/08/2013 Bairro=CENTRO CEP=18270-170 CNAE1=62.04-0-00 - Consultoria em tecnologia da informacao CapitalSocial=20000 Cidade=TATUI Complemento=******** EmpresaTipo=MATRIZ Endereco=RUA TESTE DE ENDERECO Fantasia=NOME FANTASIA EMPRESA NaturezaJuridica=206-2 - Sociedade Empresaria Limitada Numero=963 RazaoSocial=RAZAO SOCIAL DA EMPRESA InscricaoEstadual=111222111000 Situacao=ATIVA UF=SP
        /// </para>
        /// <para>
        /// Retornos possíveis:
        /// <list type="table">
        /// <item><term>0</term><description>Consulta realizada com sucesso.</description></item>
        /// <item><term>-10</term><description>Erro ao executar o método.</description></item>
        /// </list>
        /// </para>
        /// </returns>
        string Consultar(string eCNPJ);
    }
}