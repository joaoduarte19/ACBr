using System;
using ACBrLib.Core;

namespace ACBrLib.PIXCD
{
    /// <summary>
    /// Interface de alto nível para a biblioteca ACBrLib PIXCD com integração ao PSP Matera.
    /// <para>
    /// Expõe as operações do Provedor de Serviços de Pagamento (PSP) Matera: gestão de contas,
    /// chaves PIX, geração de QR Code, consulta de transações, saldo, extrato, devoluções e retiradas.
    /// </para>
    /// <para>
    /// Documentação: <see href="https://acbr.sourceforge.io/ACBrLib/PSPMatera.html">PSP Matera</see>,
    /// <see href="https://acbr.sourceforge.io/ACBrLib/MetodosPIXCD.html">Métodos PIXCD</see>.
    /// </para>
    /// </summary>
    public interface IACBrLibPIXCDMatera : IACBrLibBase, IDisposable
    {
        /// <summary>
        /// Configurações da biblioteca (sessões [PIXCD] e [Matera]).
        /// </summary>
        ACBrPIXCDConfig Config { get; }

        /// <summary>
        /// Inclui uma conta no PSP Matera.
        /// </summary>
        /// <param name="aInfIncluirConta">Path com o nome do arquivo INI a ser lido ou o conteúdo do INI.</param>
        /// <returns>Resposta em formato INI com dados da conta criada (MateraAccount, IncluirContaMatera).</returns>
        /// <see href="https://acbr.sourceforge.io/ACBrLib/PIXCD_Matera_IncluirConta.html">PIXCD_Matera_IncluirConta</see>
        string IncluirConta(string aInfIncluirConta);

        /// <summary>
        /// Consulta uma conta no PSP Matera.
        /// </summary>
        /// <param name="aAccountId">ID da conta Matera.</param>
        /// <returns>Resposta em formato INI com dados da conta (MateraAccount, ConsultarContaMatera, etc.).</returns>
        /// <see href="https://acbr.sourceforge.io/ACBrLib/PIXCD_Matera_ConsultarConta.html">PIXCD_Matera_ConsultarConta</see>
        string ConsultarConta(string aAccountId);

        /// <summary>
        /// Inativa uma conta no PSP Matera.
        /// </summary>
        /// <param name="aAccountId">ID da conta Matera.</param>
        /// <returns>Resposta em formato INI (InativarContaMatera: ResultCode, ResultString).</returns>
        /// <see href="https://acbr.sourceforge.io/ACBrLib/PIXCD_Matera_InativarConta.html">PIXCD_Matera_InativarConta</see>
        string InativarConta(string aAccountId);

        /// <summary>
        /// Inclui uma chave PIX para uma conta.
        /// </summary>
        /// <param name="aAccountId">ID da conta Matera.</param>
        /// <param name="aExternalID">Chave PIX (ou identificador externo da chave).</param>
        /// <returns>Resposta em formato INI (Alias, ChavePIX).</returns>
        /// <see href="https://acbr.sourceforge.io/ACBrLib/PIXCD_Matera_IncluirChavePix.html">PIXCD_Matera_IncluirChavePix</see>
        string IncluirChavePix(string aAccountId, string aExternalID);

        /// <summary>
        /// Consulta as chaves PIX de uma conta.
        /// </summary>
        /// <param name="aAccountId">ID da conta Matera.</param>
        /// <returns>Resposta em formato INI com lista de alias e dados da ChavePIX.</returns>
        /// <see href="https://acbr.sourceforge.io/ACBrLib/PIXCD_Matera_ConsultarChavePix.html">PIXCD_Matera_ConsultarChavePix</see>
        string ConsultarChavePix(string aAccountId);

        /// <summary>
        /// Exclui uma chave PIX de uma conta.
        /// </summary>
        /// <param name="aAccountId">ID da conta Matera.</param>
        /// <param name="aChavePIX">Chave PIX a ser excluída.</param>
        /// <returns>Resposta em formato INI (ExcluirChavePIX: ResultCode, ResultString).</returns>
        /// <see href="https://acbr.sourceforge.io/ACBrLib/PIXCD_Matera_ExcluirChavePix.html">PIXCD_Matera_ExcluirChavePix</see>
        string ExcluirChavePix(string aAccountId, string aChavePIX);

        /// <summary>
        /// Gera um QR Code para cobrança PIX.
        /// </summary>
        /// <param name="aInfQRCode">Path com o nome do arquivo INI a ser lido ou o conteúdo do INI.</param>
        /// <returns>Resposta em formato INI (QRCodeResposta, InstantPaymentQRCodeResponse com qrcodeURL, textContent, etc.).</returns>
        /// <see href="https://acbr.sourceforge.io/ACBrLib/PIXCD_Matera_GerarQRCode.html">PIXCD_Matera_GerarQRCode</see>
        string GerarQRCode(string aInfQRCode);

        /// <summary>
        /// Consulta uma transação no PSP Matera.
        /// </summary>
        /// <param name="aAccountId">ID da conta Matera.</param>
        /// <param name="aTransactionID">ID da transação.</param>
        /// <returns>Resposta em formato INI (TransactionResponse, ConsultarTransacao, etc.).</returns>
        /// <see href="https://acbr.sourceforge.io/ACBrLib/PIXCD_Matera_ConsultarTransacao.html">PIXCD_Matera_ConsultarTransacao</see>
        string ConsultarTransacao(string aAccountId, string aTransactionID);

        /// <summary>
        /// Consulta o saldo do estabelecimento de conta (EC).
        /// </summary>
        /// <param name="aAccountId">ID da conta Matera.</param>
        /// <returns>Resposta em formato INI (SaldoECResposta: available, blocked, real, etc.).</returns>
        /// <see href="https://acbr.sourceforge.io/ACBrLib/PIXCD_Matera_ConsultarSaldoEC.html">PIXCD_Matera_ConsultarSaldoEC</see>
        string ConsultarSaldoEC(string aAccountId);

        /// <summary>
        /// Consulta o extrato do estabelecimento de conta (EC) no período informado.
        /// </summary>
        /// <param name="aAccountId">ID da conta Matera.</param>
        /// <param name="aInicio">Data de início do extrato.</param>
        /// <param name="aFim">Data de fim do extrato.</param>
        /// <returns>Resposta em formato INI com o extrato das transações no período.</returns>
        /// <see href="https://acbr.sourceforge.io/ACBrLib/PIXCD_Matera_ConsultarExtratoEC.html">PIXCD_Matera_ConsultarExtratoEC</see>
        string ConsultarExtratoEC(string aAccountId, DateTime aInicio, DateTime aFim);

        /// <summary>
        /// Consulta os motivos de devolução disponíveis no PSP Matera.
        /// </summary>
        /// <returns>
        /// Resposta em formato INI com a lista de motivos de devolução
        /// (ReturnCodeX: code, description, conforme tabela de motivos da Matera).
        /// </returns>
        /// <see href="https://acbr.sourceforge.io/ACBrLib/PIXCD_Matera_ConsultarMotivosDev.html">PIXCD_Matera_ConsultarMotivosDevolucao</see>
        string ConsultarMotivosDevolucao();

        /// <summary>
        /// Solicita uma devolução de transação.
        /// </summary>
        /// <param name="aInfSolicitarDevolucao">Path com o nome do arquivo INI a ser lido ou o conteúdo do INI.</param>
        /// <param name="aAccountId">ID da conta Matera.</param>
        /// <param name="aTransactionID">ID da transação a ser devolvida.</param>
        /// <returns>Resposta em formato INI com o resultado da solicitação de devolução.</returns>
        /// <see href="https://acbr.sourceforge.io/ACBrLib/PIXCD_Matera_SolicitarDevolucao.html">PIXCD_Matera_SolicitarDevolucao</see>
        string SolicitarDevolucao(string aInfSolicitarDevolucao, string aAccountId, string aTransactionID);

        /// <summary>
        /// Consulta um alias de retirada para uma conta.
        /// </summary>
        /// <param name="aAccountId">ID da conta Matera.</param>
        /// <param name="aAlias">Código do alias de retirada.</param>
        /// <returns>Resposta em formato INI com os dados do alias de retirada.</returns>
        /// <see href="https://acbr.sourceforge.io/ACBrLib/PIXCD_Matera_ConsultarAliasRetir.html">PIXCD_Matera_ConsultarAliasRetirada</see>
        string ConsultarAliasRetirada(string aAccountId, string aAlias);

        /// <summary>
        /// Solicita uma retirada para uma conta.
        /// </summary>
        /// <param name="aInfSolicitarRetirada">Path com o nome do arquivo INI a ser lido ou o conteúdo do INI.</param>
        /// <param name="aAccountId">ID da conta Matera.</param>
        /// <returns>Resposta em formato INI com o resultado da solicitação de retirada.</returns>
        /// <see href="https://acbr.sourceforge.io/ACBrLib/PIXCD_Matera_SolicitarRetirada.html">PIXCD_Matera_SolicitarRetirada</see>
        string SolicitarRetirada(string aInfSolicitarRetirada, string aAccountId);
    }
}

