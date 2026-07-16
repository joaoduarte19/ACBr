using System;
using ACBrLib.Core;
using ACBrLib.Core.DFe;

namespace ACBrLib.eSocial
{
    /// <summary>
    /// Interface de comunicação com a ACBrLib eSocial.
    /// </summary>
    public interface IACBrLibeSocial : IACBrLibBase, IDisposable
    {
        /// <summary>
        /// Configuração da biblioteca eSocial.
        /// </summary>
        ACBreSocialConfig Config { get; }

        /// <summary>
        /// Lê um arquivo INI de evento eSocial e cria o evento em memória.
        /// </summary>
        /// <param name="eArqIni">Caminho do arquivo INI a ser lido.</param>
        void CriarEventoeSocial(string eArqIni);

        /// <summary>
        /// Envia um lote de eventos eSocial por grupo.
        /// </summary>
        /// <param name="aGrupo">Tipo de grupo de eventos: 1 = Iniciais/Tabelas, 2 = Não Periódicos, 3 = Periódicos.</param>
        /// <returns>Resposta do envio retornada pela biblioteca.</returns>
        string EnviareSocial(int aGrupo);

        /// <summary>
        /// Consulta um evento eSocial pelo número de protocolo.
        /// </summary>
        /// <param name="eProtocolo">Número do protocolo do evento a ser consultado.</param>
        /// <returns>Resposta da consulta retornada pela biblioteca.</returns>
        string ConsultareSocial(string eProtocolo);

        /// <summary>
        /// Cria um evento a partir de um INI e já realiza o envio do lote.
        /// </summary>
        /// <param name="eArqIni">Caminho do arquivo INI do evento.</param>
        /// <param name="aGrupo">Tipo de grupo de eventos: 1 = Iniciais/Tabelas, 2 = Não Periódicos, 3 = Periódicos.</param>
        /// <returns>Retorno da operação de criação e envio.</returns>
        string CriarEnviareSocial(string eArqIni, int aGrupo);

        /// <summary>
        /// Limpa a lista de eventos carregados em memória.
        /// </summary>
        void LimpareSocial();

        /// <summary>
        /// Carrega um XML de evento eSocial já gerado anteriormente.
        /// </summary>
        /// <param name="eArquivoOuXML">Caminho do arquivo XML ou conteúdo XML.</param>
        void CarregarXMLEventoeSocial(string eArquivoOuXML);

        /// <summary>
        /// Define o identificador do empregador para as operações da biblioteca.
        /// </summary>
        /// <param name="aIdEmpregador">ID do empregador.</param>
        void SetIDEmpregador(string aIdEmpregador);

        /// <summary>
        /// Define o identificador do transmissor para as operações da biblioteca.
        /// </summary>
        /// <param name="aIdTransmissor">ID do transmissor.</param>
        void SetIDTransmissor(string aIdTransmissor);

        /// <summary>
        /// Define o tipo de empregador utilizado pela biblioteca.
        /// </summary>
        /// <param name="aTipoEmpregador">Tipo do empregador conforme enumeração esperada pela ACBrLib.</param>
        void SetTipoEmpregador(int aTipoEmpregador);

        /// <summary>
        /// Define a versão do layout/documento eSocial.
        /// </summary>
        /// <param name="sVersao">Versão aceita pela ACBrLib, por exemplo: 02_04_01, 02_04_02, 02_05_00, S01_00_00, S01_01_00 ou S01_02_00.</param>
        void SetVersao(string sVersao);

        /// <summary>
        /// Consulta identificadores de eventos do empregador.
        /// </summary>
        /// <param name="aIdEmpregador">ID do empregador.</param>
        /// <param name="aTipoEvento">Tipo do evento a consultar.</param>
        /// <param name="aPeriodoApuracao">Período de apuração da consulta.</param>
        /// <returns>Resposta da consulta retornada pela biblioteca.</returns>
        string ConsultaIdentificadoresEventosEmpregador(string aIdEmpregador, int aTipoEvento, DateTime aPeriodoApuracao);

        /// <summary>
        /// Consulta identificadores de eventos de tabela.
        /// </summary>
        /// <param name="aIdEmpregador">ID do empregador.</param>
        /// <param name="aTipoEvento">Tipo do evento a consultar.</param>
        /// <param name="aChave">Chave de consulta do evento.</param>
        /// <param name="aDataInicial">Data inicial da consulta.</param>
        /// <param name="aDataFinal">Data final da consulta.</param>
        /// <returns>Resposta da consulta retornada pela biblioteca.</returns>
        string ConsultaIdentificadoresEventosTabela(string aIdEmpregador, int aTipoEvento, string aChave, DateTime aDataInicial, DateTime aDataFinal);

        /// <summary>
        /// Consulta identificadores de eventos de trabalhador.
        /// </summary>
        /// <param name="aIdEmpregador">ID do empregador.</param>
        /// <param name="aCPFTrabalhador">CPF do trabalhador.</param>
        /// <param name="aDataInicial">Data inicial da consulta.</param>
        /// <param name="aDataFinal">Data final da consulta.</param>
        /// <returns>Resposta da consulta retornada pela biblioteca.</returns>
        string ConsultaIdentificadoresEventosTrabalhador(string aIdEmpregador, string aCPFTrabalhador, DateTime aDataInicial, DateTime aDataFinal);

        /// <summary>
        /// Realiza o download de XML de eventos no intervalo informado.
        /// </summary>
        /// <param name="aIdEmpregador">ID do empregador.</param>
        /// <param name="aCPFTrabalhador">CPF do trabalhador.</param>
        /// <param name="aDataInicial">Data inicial da consulta.</param>
        /// <param name="aDataFinal">Data final da consulta.</param>
        /// <returns>Resposta da operação de download.</returns>
        string DownloadEventos(string aIdEmpregador, string aCPFTrabalhador, DateTime aDataInicial, DateTime aDataFinal);

        /// <summary>
        /// Obtém os certificados disponíveis para uso pela biblioteca.
        /// </summary>
        /// <returns>Array com os dados dos certificados encontrados.</returns>
        InfoCertificado[] ObterCertificados();
    }
}