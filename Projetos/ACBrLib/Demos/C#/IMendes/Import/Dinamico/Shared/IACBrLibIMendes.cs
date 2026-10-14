using System;
using ACBrLib.Core;

namespace ACBrLib.IMendes
{
    /// <summary>
    /// Interface de alto nível para a biblioteca ACBrLibIMendes.
    /// <para>
    /// Permite consultar a tributação de produtos (Saneamento Grades), consultar produtos por descrição,
    /// produtos alterados, histórico de acesso e regimes especiais, além de inativar produtos e remover
    /// produtos devolvidos na base IMendes.
    /// </para>
    /// <para>
    /// As respostas são retornadas no formato definido em [Principal] TipoResposta (INI, XML ou JSON).
    /// </para>
    /// </summary>
    public interface IACBrLibIMendes : IACBrLibBase, IDisposable
    {
        /// <summary>
        /// Obtém as configurações da biblioteca ACBrLibIMendes.
        /// </summary>
        ACBrIMendesConfig Config { get; }

        /// <summary>
        /// Consulta produtos na base IMendes pela descrição (máximo de 100 produtos).
        /// </summary>
        /// <param name="eDescricao">Texto a pesquisar na descrição dos produtos.</param>
        /// <param name="eCNPJ">CNPJ do cliente. Se vazio, usa o CNPJ da configuração ([IMendes] CNPJ).</param>
        /// <param name="nTipo">Forma de comparação: 0 = Contém (padrão), 1 = Inicia com, 2 = Termina com, 3 = Igual a.</param>
        /// <returns>Resposta da consulta.</returns>
        string ConsultarDescricao(string eDescricao, string eCNPJ = "", int nTipo = 0);

        /// <summary>
        /// Consulta os produtos que foram finalizados ou tiveram alteração desde a última consulta.
        /// </summary>
        /// <param name="eUF">UF para a qual se deseja o retorno.</param>
        /// <param name="eCNPJ">CNPJ do cliente. Se vazio, usa o CNPJ da configuração ([IMendes] CNPJ).</param>
        /// <param name="nLimite">Quantidade máxima de produtos retornados. 0 = sem limite (padrão).</param>
        /// <returns>Resposta da consulta.</returns>
        string ConsultarAlterados(string eUF, string eCNPJ = "", int nLimite = 0);

        /// <summary>
        /// Consulta o histórico de acesso dos últimos 45 dias e os produtos devolvidos.
        /// </summary>
        /// <param name="eCNPJ">CNPJ do cliente. Se vazio, usa o CNPJ da configuração ([IMendes] CNPJ).</param>
        /// <returns>Resposta da consulta.</returns>
        string HistoricoAcesso(string eCNPJ = "");

        /// <summary>
        /// Consulta os regimes especiais cadastrados na base IMendes para a UF.
        /// </summary>
        /// <param name="eUF">UF da consulta.</param>
        /// <param name="bIncludeTrib">True para incluir os regimes que dão à empresa a condição de Substituto do ICMS.</param>
        /// <returns>Resposta da consulta.</returns>
        string ConsultarRegimesEspeciais(string eUF, bool bIncludeTrib = false);

        /// <summary>
        /// Consulta a tributação dos produtos (Saneamento Grades - API 3.0).
        /// </summary>
        /// <param name="eArquivoOuIni">Caminho do arquivo INI ou conteúdo INI ([Emitente], [Perfil] e [ProdutoNNN]).</param>
        /// <returns>Resposta da consulta.</returns>
        string SaneamentoGrades(string eArquivoOuIni);

        /// <summary>
        /// Inativa produtos na base IMendes.
        /// </summary>
        /// <param name="eArquivoOuIni">Caminho do arquivo INI ou conteúdo INI ([Inativar] e [ProdutoNNN]).</param>
        /// <returns>Resposta da inativação.</returns>
        string Inativar(string eArquivoOuIni);

        /// <summary>
        /// Remove produtos da lista de devolvidos da base IMendes.
        /// </summary>
        /// <param name="eArquivoOuIni">Caminho do arquivo INI ou conteúdo INI ([RemoveDevolvidos] e [ProdutoNNN]).</param>
        /// <returns>Resposta da remoção.</returns>
        string RemoveDevolvidos(string eArquivoOuIni);
    }
}
