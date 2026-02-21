using ACBrLib.Core;
using System;

namespace ACBrLib.PIXCD
{
    /// <summary>
    /// Interface para integração com a ACBrLib PIXCD, baseada nos métodos oficiais.
    /// Documentação: https://acbr.sourceforge.io/ACBrLib/MetodosPIXCD.html
    /// </summary>
    public interface IACBrLibPIXCD : IACBrLibBase, IDisposable
    {
        /// <summary>
        /// Configurações da biblioteca PIXCD.
        /// </summary>
        ACBrPIXCDConfig Config { get; }

        /// <summary>
        /// Gera um QR Code estático para pagamento PIX.
        /// </summary>
        /// <param name="AValor">Valor da cobrança.</param>
        /// <param name="AinfoAdicional">Informações adicionais.</param>
        /// <param name="ATxID">Identificador da transação.</param>
        /// <returns>QR Code em formato string.</returns>
        string GerarQRCodeEstatico(double AValor, string AinfoAdicional, string ATxID);

        /// <summary>
        /// Consulta um PIX pelo e2eid.
        /// </summary>
        /// <param name="Ae2eid">Identificador e2eid do PIX.</param>
        /// <returns>Dados do PIX consultado.</returns>
        string ConsultarPix(string Ae2eid);

        /// <summary>
        /// Consulta PIX recebidos em um período.
        /// </summary>
        /// <param name="ADataInicio">Data inicial.</param>
        /// <param name="ADataFim">Data final.</param>
        /// <param name="ATxId">Identificador da transação.</param>
        /// <param name="ACpfCnpj">CPF ou CNPJ do pagador.</param>
        /// <param name="PagAtual">Página atual.</param>
        /// <param name="ItensPorPagina">Itens por página.</param>
        /// <returns>Lista de PIX recebidos.</returns>
        string ConsultarPixRecebidos(DateTime ADataInicio, DateTime ADataFim, string ATxId, string ACpfCnpj, int PagAtual, int ItensPorPagina);

        /// <summary>
        /// Solicita devolução de um PIX.
        /// </summary>
        /// <param name="AInfDevolucao">Informações da devolução.</param>
        /// <param name="Ae2eid">Identificador e2eid do PIX.</param>
        /// <param name="AidDevolucao">ID da devolução.</param>
        /// <returns>Resultado da solicitação.</returns>
        string SolicitarDevolucaoPix(string AInfDevolucao, string Ae2eid, string AidDevolucao);

        /// <summary>
        /// Consulta devolução de um PIX.
        /// </summary>
        /// <param name="Ae2eid">Identificador e2eid do PIX.</param>
        /// <param name="AidDevolucao">ID da devolução.</param>
        /// <returns>Dados da devolução.</returns>
        string ConsultarDevolucaoPix(string Ae2eid, string AidDevolucao);

        /// <summary>
        /// Cria uma cobrança imediata.
        /// </summary>
        /// <param name="AInfCobSolicitada">Informações da cobrança solicitada.</param>
        /// <param name="ATxId">Identificador da transação.</param>
        /// <returns>Resultado da criação.</returns>
        string CriarCobrancaImediata(string AInfCobSolicitada, string ATxId);

        /// <summary>
        /// Consulta uma cobrança imediata.
        /// </summary>
        /// <param name="ATxId">Identificador da transação.</param>
        /// <param name="ARevisao">Número da revisão.</param>
        /// <returns>Dados da cobrança.</returns>
        string ConsultarCobrancaImediata(string ATxId, int ARevisao);

        /// <summary>
        /// Consulta cobranças imediatas em um período.
        /// </summary>
        /// <param name="ADataInicio">Data inicial.</param>
        /// <param name="ADataFim">Data final.</param>
        /// <param name="ACpfCnpj">CPF ou CNPJ do pagador.</param>
        /// <param name="ALocationPresente">Se location está presente.</param>
        /// <param name="AStatus">Status da cobrança.</param>
        /// <param name="PagAtual">Página atual.</param>
        /// <param name="ItensPorPagina">Itens por página.</param>
        /// <returns>Lista de cobranças.</returns>
        string ConsultarCobrancasCob(DateTime ADataInicio, DateTime ADataFim, string ACpfCnpj, Boolean ALocationPresente, int AStatus, int PagAtual, int ItensPorPagina);

        /// <summary>
        /// Revisa uma cobrança imediata.
        /// </summary>
        /// <param name="AInfCobRevisada">Informações revisadas da cobrança.</param>
        /// <param name="ATxId">Identificador da transação.</param>
        /// <returns>Resultado da revisão.</returns>
        string RevisarCobrancaImediata(string AInfCobRevisada, string ATxId);

        /// <summary>
        /// Cancela uma cobrança imediata.
        /// </summary>
        /// <param name="ATxId">Identificador da transação.</param>
        /// <returns>Resultado do cancelamento.</returns>
        string CancelarCobrancaImediata(string ATxId);

        /// <summary>
        /// Cria uma cobrança via CobV.
        /// </summary>
        /// <param name="AInfCobVSolicitada">Informações da cobrança CobV solicitada.</param>
        /// <param name="ATxId">Identificador da transação.</param>
        /// <returns>Resultado da criação.</returns>
        string CriarCobranca(string AInfCobVSolicitada, string ATxId);

        /// <summary>
        /// Consulta uma cobrança CobV.
        /// </summary>
        /// <param name="ATxId">Identificador da transação.</param>
        /// <param name="ARevisao">Número da revisão.</param>
        /// <returns>Dados da cobrança CobV.</returns>
        string ConsultarCobranca(string ATxId, int ARevisao);

        /// <summary>
        /// Consulta cobranças CobV em um período.
        /// </summary>
        /// <param name="ADataInicio">Data inicial.</param>
        /// <param name="ADataFim">Data final.</param>
        /// <param name="ACpfCnpj">CPF ou CNPJ do pagador.</param>
        /// <param name="ALocationPresente">Se location está presente.</param>
        /// <param name="AStatus">Status da cobrança.</param>
        /// <param name="PagAtual">Página atual.</param>
        /// <param name="ItensPorPagina">Itens por página.</param>
        /// <returns>Lista de cobranças CobV.</returns>
        string ConsultarCobrancasCobV(DateTime ADataInicio, DateTime ADataFim, string ACpfCnpj, Boolean ALocationPresente, int AStatus, int PagAtual, int ItensPorPagina);

        /// <summary>
        /// Revisa uma cobrança CobV.
        /// </summary>
        /// <param name="AInfCobVRevisada">Informações revisadas da cobrança CobV.</param>
        /// <param name="ATxId">Identificador da transação.</param>
        /// <returns>Resultado da revisão.</returns>
        string RevisarCobranca(string AInfCobVRevisada, string ATxId);

        /// <summary>
        /// Cancela uma cobrança CobV.
        /// </summary>
        /// <param name="ATxId">Identificador da transação.</param>
        /// <returns>Resultado do cancelamento.</returns>
        string CancelarCobranca(string ATxId);
    }
}
