using ACBrLib.Core;
using ACBrLib.Core.Boleto;
using System;
using System.IO;
namespace ACBrLib.Boleto
{
    /// <summary>
    /// Interface de alto nível para integração com ACBrLibBoleto.
    /// Implementa métodos para manipulação de boletos, retornando buffers como strings.
    /// Baseada nos métodos descritos em https://acbr.sourceforge.io/ACBrLib/MetodosBoleto.html.
    /// </summary>
    public interface IACBrLibBoleto : IACBrLibBase, IDisposable
    {
        /// <summary>
        /// Configurações do componente ACBrBoleto.
        /// </summary>
        ACBrBoletoConfig Config { get; }

        /// <summary>
        /// Configura os dados do boleto a partir de objetos BoletoInfo.
        /// </summary>
        /// <param name="infos">Array de informações de boletos.</param>
        void ConfigurarDados(params BoletoInfo[] infos);
        /// <summary>
        /// Configura os dados do boleto a partir de um arquivo INI.
        /// </summary>
        /// <param name="eArquivoIni">Caminho do arquivo INI.</param>
        void ConfigurarDados(string eArquivoIni);
        /// <summary>
        /// Inclui títulos na lista de boletos.
        /// </summary>
        /// <param name="titulos">Array de títulos.</param>
        void IncluirTitulos(params Titulo[] titulos);
        /// <summary>
        /// Inclui títulos na lista de boletos, especificando o tipo de saída.
        /// </summary>
        /// <param name="eTpSaida">Tipo de saída.</param>
        /// <param name="titulos">Array de títulos.</param>
        void IncluirTitulos(BoletoTpSaida eTpSaida, params Titulo[] titulos);
        /// <summary>
        /// Inclui títulos a partir de um arquivo INI, opcionalmente especificando o tipo de saída.
        /// </summary>
        /// <param name="eArquivoIni">Caminho do arquivo INI.</param>
        /// <param name="eTpSaida">Tipo de saída (opcional).</param>
        void IncluirTitulos(string eArquivoIni, BoletoTpSaida? eTpSaida = null);
        /// <summary>
        /// Limpa a lista de títulos.
        /// </summary>
        void LimparLista();
        /// <summary>
        /// Retorna o total de títulos na lista.
        /// </summary>
        int TotalTitulosLista();
        /// <summary>
        /// Imprime todos os boletos na impressora especificada.
        /// </summary>
        /// <param name="eNomeImpressora">Nome da impressora (opcional).</param>
        void Imprimir(string eNomeImpressora = "");
        /// <summary>
        /// Imprime o boleto do índice especificado.
        /// </summary>
        /// <param name="indice">Índice do boleto.</param>
        /// <param name="eNomeImpressora">Nome da impressora (opcional).</param>
        void Imprimir(int indice, string eNomeImpressora = "");
        /// <summary>
        /// Gera PDF de todos os boletos.
        /// </summary>
        void GerarPDF();
        /// <summary>
        /// Gera PDF de todos os boletos e grava em um Stream.
        /// </summary>
        /// <param name="aStream">Stream de saída.</param>
        void GerarPDF(Stream aStream);
        /// <summary>
        /// Gera PDF do boleto do índice especificado.
        /// </summary>
        /// <param name="indice">Índice do boleto.</param>
        void GerarPDF(int indice);
        /// <summary>
        /// Gera um token para autenticação de operações.
        /// </summary>
        /// <returns>Token gerado.</returns>
        string GerarToken();
        /// <summary>
        /// Informa um token para autenticação.
        /// </summary>
        /// <param name="eToken">Token.</param>
        /// <param name="eData">Data de validade.</param>
        /// <returns>Resultado da operação.</returns>
        string InformarToken(string eToken, DateTime eData);
        /// <summary>
        /// Gera PDF do boleto do índice especificado e grava em um Stream.
        /// </summary>
        /// <param name="indice">Índice do boleto.</param>
        /// <param name="aStream">Stream de saída.</param>
        void GerarPDF(int indice, Stream aStream);
        /// <summary>
        /// Gera HTML dos boletos.
        /// </summary>
        void GerarHTML();
        /// <summary>
        /// Gera arquivo de remessa.
        /// </summary>
        /// <param name="eDir">Diretório de saída.</param>
        /// <param name="eNumArquivo">Número do arquivo.</param>
        /// <param name="eNomeArq">Nome do arquivo.</param>
        void GerarRemessa(string eDir, int eNumArquivo, string eNomeArq);
        /// <summary>
        /// Gera remessa e grava em um Stream.
        /// </summary>
        /// <param name="eNumArquivo">Número do arquivo.</param>
        /// <param name="aStream">Stream de saída.</param>
        void GerarRemessaStream(int eNumArquivo, Stream aStream);
        /// <summary>
        /// Obtém retorno de arquivo de retorno.
        /// </summary>
        /// <param name="eDir">Diretório do arquivo.</param>
        /// <param name="eNomeArq">Nome do arquivo.</param>
        /// <returns>Retorno do boleto.</returns>
        RetornoBoleto ObterRetorno(string eDir, string eNomeArq);
        /// <summary>
        /// Lê arquivo de retorno.
        /// </summary>
        /// <param name="eDir">Diretório do arquivo.</param>
        /// <param name="eNomeArq">Nome do arquivo.</param>
        void LerRetorno(string eDir, string eNomeArq);
        /// <summary>
        /// Lê retorno a partir de um buffer Base64.
        /// </summary>
        /// <param name="ARetornoBase64">Buffer Base64.</param>
        /// <returns>Retorno como string.</returns>
        string LerRetornoStream(string ARetornoBase64);
        /// <summary>
        /// Envia email com boletos.
        /// </summary>
        /// <param name="ePara">Destinatário.</param>
        /// <param name="eAssunto">Assunto.</param>
        /// <param name="eMensagem">Mensagem.</param>
        /// <param name="eCC">Cópia (CC).</param>
        void EnviarEmail(string ePara, string eAssunto, string eMensagem, string eCC);
        /// <summary>
        /// Envia email de um boleto específico.
        /// </summary>
        /// <param name="eIndex">Índice do boleto.</param>
        /// <param name="ePara">Destinatário.</param>
        /// <param name="eAssunto">Assunto.</param>
        /// <param name="eMensagem">Mensagem.</param>
        /// <param name="eCC">Cópia (CC).</param>
        void EnviarEmailBoleto(int eIndex, string ePara, string eAssunto, string eMensagem, string eCC);
        /// <summary>
        /// Define o diretório e arquivo padrão.
        /// </summary>
        /// <param name="eDir">Diretório.</param>
        /// <param name="eArq">Arquivo (opcional).</param>
        void SetDiretorioArquivo(string eDir, string eArq = "");
        /// <summary>
        /// Retorna lista de bancos suportados.
        /// </summary>
        /// <returns>Array de bancos.</returns>
        string[] ListaBancos();
        /// <summary>
        /// Retorna lista de características de títulos.
        /// </summary>
        /// <returns>Array de características.</returns>
        string[] ListaCaractTitulo();
        /// <summary>
        /// Retorna lista de ocorrências.
        /// </summary>
        /// <returns>Array de ocorrências.</returns>
        string[] ListaOcorrencias();
        /// <summary>
        /// Retorna lista de ocorrências estendidas.
        /// </summary>
        /// <returns>Array de ocorrências estendidas.</returns>
        string[] ListaOcorrenciasEX();
        /// <summary>
        /// Retorna o tamanho do Nosso Número para a carteira e convênio informados.
        /// </summary>
        /// <param name="eCarteira">Carteira.</param>
        /// <param name="enossoNumero">Nosso Número.</param>
        /// <param name="eConvenio">Convênio.</param>
        /// <returns>Tamanho do Nosso Número.</returns>
        int TamNossoNumero(string eCarteira, string enossoNumero, string eConvenio);
        /// <summary>
        /// Retorna os códigos de mora aceitos.
        /// </summary>
        /// <returns>Códigos de mora.</returns>
        string CodigosMoraAceitos();
        /// <summary>
        /// Seleciona o banco pelo código informado.
        /// </summary>
        /// <param name="eCodBanco">Código do banco.</param>
        void SelecionaBanco(string eCodBanco);
        /// <summary>
        /// Monta o Nosso Número para o índice informado.
        /// </summary>
        /// <param name="eIndex">Índice do boleto.</param>
        /// <returns>Nosso Número montado.</returns>
        string MontarNossoNumero(int eIndex);
        /// <summary>
        /// Retorna a linha digitável do boleto.
        /// </summary>
        /// <param name="eIndex">Índice do boleto.</param>
        /// <returns>Linha digitável.</returns>
        string RetornaLinhaDigitavel(int eIndex);
        /// <summary>
        /// Retorna o código de barras do boleto.
        /// </summary>
        /// <param name="eIndex">Índice do boleto.</param>
        /// <returns>Código de barras.</returns>
        string RetornaCodigoBarras(int eIndex);
        /// <summary>
        /// Envia boleto via webservice.
        /// </summary>
        /// <param name="opercao">Operação de boleto.</param>
        /// <returns>Retorno da operação web.</returns>
        RetornoWeb EnviarBoleto(OperacaoBoleto opercao);
        /// <summary>
        /// Consulta títulos por período a partir de um arquivo INI.
        /// </summary>
        /// <param name="eArquivoIni">Arquivo INI.</param>
        /// <returns>Resultado da consulta.</returns>
        string ConsultarTitulosPorPeriodo(string eArquivoIni);


    }
}
