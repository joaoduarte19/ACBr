using System;
using System.IO;
using ACBrLib.Core;
using ACBrLib.Core.DFe;

namespace ACBrLib.NFSe
{
    /// <summary>
    /// Interface de alto nível da ACBrLibNFSe.
    /// </summary>
    /// <remarks>
    /// Encapsula as funções da ACBrLibNFSe para emissão, consulta, cancelamento e impressão
    /// de Notas Fiscais de Serviço Eletrônicas (NFSe), trabalhando apenas com tipos .NET
    /// de alto nível (como <see cref="string"/> e <see cref="DateTime"/>), em vez de buffers
    /// e tamanhos de memória.
    /// </remarks>
    public interface IACBrLibNFSe : IACBrLibBase, IDisposable
    {
        /// <summary>
        /// Obtém o objeto de configuração da ACBrLib NFSe.
        /// </summary>
        /// <remarks>
        /// Equivale ao controle das configurações internas da ACBrLib, como
        /// parâmetros de certificado, pastas, provedor, webservice, entre outros.
        /// </remarks>
        ACBrNFSeConfig Config { get; }

        /// <summary>
        /// Carrega um RPS/NFSe a partir de um arquivo XML ou de um conteúdo XML em memória.
        /// </summary>
        /// <param name="eArquivoOuXml">
        /// Caminho completo do arquivo XML a ser carregado ou o conteúdo XML em forma de <see cref="string"/>.
        /// </param>
        /// <remarks>
        /// Método de alto nível correspondente à função nativa <c>NFSE_CarregarXML</c>, que recebe
        /// um buffer de entrada e seu tamanho. Aqui é utilizado apenas uma <see cref="string"/>.
        /// </remarks>
        void CarregarXML(string eArquivoOuXml);

        /// <summary>
        /// Carrega um lote de RPS/NFSe a partir de um arquivo XML ou de um conteúdo XML em memória.
        /// </summary>
        /// <param name="eArquivoOuXml">
        /// Caminho completo do arquivo XML do lote ou o conteúdo XML do lote em forma de <see cref="string"/>.
        /// </param>
        /// <remarks>
        /// Versão de alto nível da função nativa de carregamento de lote em XML,
        /// substituindo o uso de buffer por <see cref="string"/>.
        /// </remarks>
        void CarregarLoteXML(string eArquivoOuXml);

        /// <summary>
        /// Carrega um RPS/NFSe a partir de um arquivo INI ou de um conteúdo INI em memória.
        /// </summary>
        /// <param name="eArquivoOuIni">
        /// Caminho completo do arquivo INI a ser carregado ou o conteúdo INI em forma de <see cref="string"/>.
        /// </param>
        /// <remarks>
        /// Versão de alto nível da função <c>NFSE_CarregarINI</c>, trabalhando apenas com <see cref="string"/>.
        /// </remarks>
        void CarregarINI(string eArquivoOuIni);

        /// <summary>
        /// Obtém o XML de uma NFSe ou RPS já carregado, pelo índice em memória.
        /// </summary>
        /// <param name="aIndex">Índice do documento na lista interna da biblioteca (base zero).</param>
        /// <returns>Conteúdo XML da NFSe/RPS correspondente ao índice informado.</returns>
        /// <remarks>
        /// Corresponde à função de baixo nível que preenche um buffer de saída com o XML.
        /// Neste método de alto nível o resultado é retornado diretamente como <see cref="string"/>.
        /// </remarks>
        string ObterXml(int aIndex);

        /// <summary>
        /// Obtém o XML do RPS correspondente à NFSe já carregada, pelo índice em memória.
        /// </summary>
        /// <param name="aIndex">Índice do documento na lista interna da biblioteca (base zero).</param>
        /// <returns>Conteúdo XML do RPS associado ao índice informado.</returns>
        string ObterXmlRps(int aIndex);

        /// <summary>
        /// Grava o XML de uma NFSe/RPS carregada em disco.
        /// </summary>
        /// <param name="aIndex">Índice do documento na lista interna da biblioteca (base zero).</param>
        /// <param name="eNomeArquivo">
        /// Nome do arquivo XML a ser gerado (sem caminho). Se vazio, o nome padrão será utilizado.
        /// </param>
        /// <param name="ePathArquivo">
        /// Caminho onde o arquivo será salvo. Se vazio, será utilizada a pasta configurada na biblioteca.
        /// </param>
        void GravarXml(int aIndex, string eNomeArquivo = "", string ePathArquivo = "");

        /// <summary>
        /// Obtém o conteúdo INI da NFSe/RPS carregada, pelo índice em memória.
        /// </summary>
        /// <param name="aIndex">Índice do documento na lista interna da biblioteca (base zero).</param>
        /// <returns>Conteúdo INI correspondente ao documento informado.</returns>
        string ObterIni(int aIndex);

        /// <summary>
        /// Grava em disco o conteúdo INI da NFSe/RPS carregada.
        /// </summary>
        /// <param name="aIndex">Índice do documento na lista interna da biblioteca (base zero).</param>
        /// <param name="eNomeArquivo">
        /// Nome do arquivo INI a ser gerado (sem caminho). Se vazio, o nome padrão será utilizado.
        /// </param>
        /// <param name="ePathArquivo">
        /// Caminho onde o arquivo será salvo. Se vazio, será utilizada a pasta configurada na biblioteca.
        /// </param>
        void GravarIni(int aIndex, string eNomeArquivo = "", string ePathArquivo = "");

        /// <summary>
        /// Limpa a lista de documentos (RPS/NFSe) carregados em memória.
        /// </summary>
        void LimparLista();

        /// <summary>
        /// Obtém a lista de certificados digitais instalados no sistema.
        /// </summary>
        /// <returns>Array de <see cref="InfoCertificado"/> contendo informações dos certificados encontrados.</returns>
        InfoCertificado[] ObterCertificados();

        /// <summary>
        /// Emite as NFSe/RPS previamente carregadas, gerando e enviando o lote ao provedor.
        /// </summary>
        /// <param name="aLote">Identificador do lote de envio.</param>
        /// <param name="aModoEnvio">
        /// Modo de envio definido pela biblioteca (por exemplo, síncrono/assíncrono, conforme provedor).
        /// </param>
        /// <param name="aImprimir">
        /// Quando verdadeiro, realiza a impressão das NFSe emitidas de acordo com a configuração de impressão.
        /// </param>
        /// <returns>
        /// Retorna uma <see cref="string"/> com a resposta do provedor, normalmente em XML, contendo protocolo e/ou NFSe.
        /// </returns>
        string Emitir(string aLote, int aModoEnvio, bool aImprimir);

        /// <summary>
        /// Cancela uma NFSe junto ao provedor.
        /// </summary>
        /// <param name="aInfCancelamento">
        /// Estrutura de dados de cancelamento (XML ou outro formato aceito), contendo as informações exigidas
        /// pelo provedor, como número da NFSe, motivo e código de cancelamento.
        /// </param>
        /// <returns>Resposta do provedor, normalmente em XML, com o resultado do cancelamento.</returns>
        string Cancelar(string aInfCancelamento);

        /// <summary>
        /// Substitui uma NFSe por outra, realizando o cancelamento da atual e emissão de nova NFSe.
        /// </summary>
        /// <param name="aNumeroNFSe">Número da NFSe a ser substituída.</param>
        /// <param name="aSerieNFSe">Série da NFSe a ser substituída.</param>
        /// <param name="aCodigoCancelamento">Código de cancelamento definido pelo provedor/município.</param>
        /// <param name="aMotivoCancelamento">Motivo do cancelamento/substituição.</param>
        /// <param name="aNumeroLote">Número do lote utilizado na substituição.</param>
        /// <param name="aCodigoVerificacao">Código de verificação da NFSe, quando exigido pelo provedor.</param>
        /// <returns>Resposta do provedor contendo o resultado da substituição.</returns>
        string SubstituirNFSe(string aNumeroNFSe, string aSerieNFSe, string aCodigoCancelamento, string aMotivoCancelamento, string aNumeroLote, string aCodigoVerificacao);

        /// <summary>
        /// Obtém o link de consulta/impressão de uma NFSe disponibilizado pelo provedor.
        /// </summary>
        /// <param name="aNumeroNFSe">Número da NFSe.</param>
        /// <param name="aCodigoVerificacao">Código de verificação da NFSe.</param>
        /// <param name="aChaveAcesso">Chave de acesso ou identificador exigido pelo provedor, quando aplicável.</param>
        /// <param name="aValorServico">Valor total do serviço constante na NFSe, quando exigido na geração do link.</param>
        /// <returns>Link (URL) de consulta/impressão da NFSe.</returns>
        string LinkNFSe(string aNumeroNFSe, string aCodigoVerificacao, string aChaveAcesso, string aValorServico);

        /// <summary>
        /// Gera um lote de RPS/NFSe a partir dos documentos carregados, respeitando a quantidade máxima informada.
        /// </summary>
        /// <param name="aLote">Identificador do lote de envio.</param>
        /// <param name="aQtdMaximaRps">Quantidade máxima de RPS que o lote deve conter.</param>
        /// <param name="aModoEnvio">Modo de envio (por exemplo, síncrono/assíncrono) definido pela biblioteca.</param>
        /// <returns>Retorna uma <see cref="string"/> com o XML do lote gerado ou outra estrutura definida pelo provedor.</returns>
        string GerarLote(string aLote, int aQtdMaximaRps, int aModoEnvio);

        /// <summary>
        /// Gera um token de autenticação/validação para uso junto ao provedor, quando exigido.
        /// </summary>
        /// <returns>Token gerado pelo provedor ou pela biblioteca, dependendo da implementação.</returns>
        string GerarToken();

        /// <summary>
        /// Consulta a situação de um lote de NFSe no provedor.
        /// </summary>
        /// <param name="aProtocolo">Número do protocolo de envio do lote.</param>
        /// <param name="aNumeroLote">Número do lote utilizado na emissão.</param>
        /// <returns>Resposta do provedor com a situação atual do lote.</returns>
        string ConsultarSituacao(string aProtocolo, string aNumeroLote);

        /// <summary>
        /// Consulta um lote de RPS enviado ao provedor.
        /// </summary>
        /// <param name="aProcotolo">Número do protocolo de envio do lote.</param>
        /// <param name="aNumLote">Número do lote.</param>
        /// <returns>Resposta do provedor com o detalhamento do lote e das NFSe/RPS.</returns>
        string ConsultarLoteRps(string aProcotolo, string aNumLote);

        /// <summary>
        /// Consulta uma NFSe a partir do RPS utilizado na sua geração.
        /// </summary>
        /// <param name="aNumeroRps">Número do RPS.</param>
        /// <param name="aSerie">Série do RPS.</param>
        /// <param name="aTipo">Tipo do RPS, conforme especificação do provedor.</param>
        /// <param name="aCodigoVerificacao">Código de verificação, quando exigido para a consulta.</param>
        /// <returns>Resposta do provedor com os dados da NFSe correspondente ao RPS informado.</returns>
        string ConsultarNFSePorRps(string aNumeroRps, string aSerie, string aTipo, string aCodigoVerificacao);

        /// <summary>
        /// Consulta NFSe pelo número do documento.
        /// </summary>
        /// <param name="aNumero">Número da NFSe.</param>
        /// <param name="aPagina">Número da página de resultados a ser retornada, quando aplicável.</param>
        /// <returns>Resposta do provedor contendo a(s) NFSe encontrada(s).</returns>
        string ConsultarNFSePorNumero(string aNumero, int aPagina);

        /// <summary>
        /// Consulta NFSe emitidas em um determinado período.
        /// </summary>
        /// <param name="aDataInicial">Data inicial do período da consulta.</param>
        /// <param name="aDataFinal">Data final do período da consulta.</param>
        /// <param name="aPagina">Número da página de resultados a ser retornada.</param>
        /// <param name="aNumeroLote">Número do lote para filtragem, quando aplicável.</param>
        /// <param name="aTipoPeriodo">
        /// Tipo de período utilizado na consulta (por exemplo, emissão, competência), conforme especificação do provedor.
        /// </param>
        /// <returns>Resposta do provedor com as NFSe encontradas no período solicitado.</returns>
        string ConsultarNFSePorPeriodo(DateTime aDataInicial, DateTime aDataFinal, int aPagina, string aNumeroLote, int aTipoPeriodo);

        /// <summary>
        /// Consulta NFSe por faixa de numeração.
        /// </summary>
        /// <param name="aNumeroInicial">Número inicial da faixa.</param>
        /// <param name="aNumeroFinal">Número final da faixa.</param>
        /// <param name="aPagina">Número da página de resultados a ser retornada.</param>
        /// <returns>Resposta do provedor contendo as NFSe dentro da faixa informada.</returns>
        string ConsultarNFSePorFaixa(string aNumeroInicial, string aNumeroFinal, int aPagina);

        /// <summary>
        /// Executa uma consulta genérica de NFSe, de acordo com o layout/estrutura exigido pelo provedor.
        /// </summary>
        /// <param name="aInfConsultaNFSe">
        /// Conteúdo da requisição de consulta (XML ou outro formato específico do provedor).
        /// </param>
        /// <returns>Resposta do provedor com o resultado da consulta.</returns>
        string ConsultarNFSeGenerico(string aInfConsultaNFSe);

        /// <summary>
        /// Executa uma consulta genérica de link de NFSe, de acordo com o layout/estrutura exigido pelo provedor.
        /// </summary>
        /// <param name="aInfConsultaLinkNFSe">
        /// Conteúdo da requisição de consulta de link (XML ou outro formato específico do provedor).
        /// </param>
        /// <returns>Resposta do provedor com o link ou informações de acesso à NFSe.</returns>
        string ConsultarLinkNFSe(string aInfConsultaLinkNFSe);

        /// <summary>
        /// Envia uma NFSe por e-mail.
        /// </summary>
        /// <param name="ePara">Endereço(s) de e-mail do destinatário, separados conforme configuração (por exemplo, ponto e vírgula).</param>
        /// <param name="eXmlNFSe">Caminho do arquivo XML da NFSe ou o conteúdo XML em forma de <see cref="string"/>.</param>
        /// <param name="aEnviaPDF">Indica se o PDF da NFSe deve ser anexado ao e-mail.</param>
        /// <param name="eAssunto">Assunto da mensagem de e-mail.</param>
        /// <param name="eCc">Endereços de e-mail em cópia, quando desejado.</param>
        /// <param name="eAnexos">Arquivos adicionais a serem anexados, quando necessário.</param>
        /// <param name="eMensagem">Corpo da mensagem de e-mail.</param>
        void EnviarEmail(string ePara, string eXmlNFSe, bool aEnviaPDF, string eAssunto, string eCc, string eAnexos, string eMensagem);

        /// <summary>
        /// Imprime as NFSe atualmente carregadas ou emitidas.
        /// </summary>
        /// <param name="cImpressora">
        /// Nome da impressora. Se vazio, será utilizada a impressora padrão ou configurada na biblioteca.
        /// </param>
        /// <param name="nNumCopias">Número de cópias a serem impressas.</param>
        /// <param name="bGerarPDF">
        /// Quando verdadeiro, gera o PDF da NFSe em vez de enviar diretamente para a impressora.
        /// </param>
        /// <param name="bMostrarPreview">
        /// Quando verdadeiro, exibe um preview da impressão antes de enviar para a impressora.
        /// </param>
        /// <param name="cCancelada">
        /// Texto opcional para indicar NFSe cancelada no DANFSe, dependendo do layout utilizado.
        /// </param>
        void Imprimir(string cImpressora = "", int nNumCopias = 1, bool? bGerarPDF = null, bool? bMostrarPreview = null, string cCancelada = "");

        /// <summary>
        /// Gera o PDF da NFSe e grava em arquivo, conforme configuração de diretório e nome definido na biblioteca.
        /// </summary>
        void ImprimirPDF();

        /// <summary>
        /// Gera o PDF da NFSe e grava o resultado diretamente em um <see cref="Stream"/>.
        /// </summary>
        /// <param name="aStream">
        /// <see cref="Stream"/> de saída que receberá o conteúdo do PDF gerado.
        /// O chamador é responsável por gerenciar o ciclo de vida do stream.
        /// </param>
        void ImprimirPDF(Stream aStream);

        /// <summary>
        /// Consulta NFSe de serviços prestados filtrando por número do documento e período.
        /// </summary>
        /// <param name="aNumero">Número da NFSe.</param>
        /// <param name="aPagina">Número da página de resultados.</param>
        /// <param name="aDataInicial">Data inicial do período da consulta.</param>
        /// <param name="aDataFinal">Data final do período da consulta.</param>
        /// <param name="aTipoPeriodo">
        /// Tipo de período utilizado na consulta (por exemplo, emissão, competência).
        /// </param>
        /// <returns>Resposta do provedor com as NFSe de serviços prestados encontradas.</returns>
        string ConsultarNFSeServicoPrestadoPorNumero(string aNumero, int aPagina, DateTime aDataInicial, DateTime aDataFinal, int aTipoPeriodo);

        /// <summary>
        /// Consulta NFSe de serviços prestados em um determinado período.
        /// </summary>
        /// <param name="aDataInicial">Data inicial do período da consulta.</param>
        /// <param name="aDataFinal">Data final do período da consulta.</param>
        /// <param name="aPagina">Número da página de resultados.</param>
        /// <param name="aTipoPeriodo">
        /// Tipo de período utilizado na consulta (por exemplo, emissão, competência).
        /// </param>
        /// <returns>Resposta do provedor com as NFSe de serviços prestados encontradas.</returns>
        string ConsultarNFSeServicoPrestadoPorPeriodo(DateTime aDataInicial, DateTime aDataFinal, int aPagina, int aTipoPeriodo);

        /// <summary>
        /// Consulta NFSe de serviços prestados filtrando por dados do tomador.
        /// </summary>
        /// <param name="aCNPJ">CNPJ/CPF do tomador do serviço.</param>
        /// <param name="aInscMun">Inscrição municipal do tomador.</param>
        /// <param name="aPagina">Número da página de resultados.</param>
        /// <param name="aDataInicial">Data inicial do período da consulta.</param>
        /// <param name="aDataFinal">Data final do período da consulta.</param>
        /// <param name="aTipoPeriodo">
        /// Tipo de período utilizado na consulta (por exemplo, emissão, competência).
        /// </param>
        /// <returns>Resposta do provedor com as NFSe de serviços prestados ao tomador informado.</returns>
        string ConsultarNFSeServicoPrestadoPorTomador(string aCNPJ, string aInscMun, int aPagina, DateTime aDataInicial, DateTime aDataFinal, int aTipoPeriodo);

        /// <summary>
        /// Consulta NFSe de serviços prestados filtrando por intermediário do serviço.
        /// </summary>
        /// <param name="aCNPJ">CNPJ/CPF do intermediário do serviço.</param>
        /// <param name="aInscMun">Inscrição municipal do intermediário.</param>
        /// <param name="aPagina">Número da página de resultados.</param>
        /// <param name="aDataInicial">Data inicial do período da consulta.</param>
        /// <param name="aDataFinal">Data final do período da consulta.</param>
        /// <param name="aTipoPeriodo">
        /// Tipo de período utilizado na consulta (por exemplo, emissão, competência).
        /// </param>
        /// <returns>Resposta do provedor com as NFSe de serviços prestados intermediados pelo contribuinte informado.</returns>
        string ConsultarNFSeServicoPrestadoPorIntermediario(string aCNPJ, string aInscMun, int aPagina, DateTime aDataInicial, DateTime aDataFinal, int aTipoPeriodo);

        /// <summary>
        /// Consulta NFSe de serviços tomados filtrando por número do documento e período.
        /// </summary>
        /// <param name="aNumero">Número da NFSe.</param>
        /// <param name="aPagina">Número da página de resultados.</param>
        /// <param name="aDataInicial">Data inicial do período da consulta.</param>
        /// <param name="aDataFinal">Data final do período da consulta.</param>
        /// <param name="aTipoPeriodo">
        /// Tipo de período utilizado na consulta (por exemplo, emissão, competência).
        /// </param>
        /// <returns>Resposta do provedor com as NFSe de serviços tomados encontradas.</returns>
        string ConsultarNFSeServicoTomadoPorNumero(string aNumero, int aPagina, DateTime aDataInicial, DateTime aDataFinal, int aTipoPeriodo);

        /// <summary>
        /// Consulta NFSe de serviços tomados filtrando por dados do prestador.
        /// </summary>
        /// <param name="aCNPJ">CNPJ/CPF do prestador do serviço.</param>
        /// <param name="aInscMun">Inscrição municipal do prestador.</param>
        /// <param name="aPagina">Número da página de resultados.</param>
        /// <param name="aDataInicial">Data inicial do período da consulta.</param>
        /// <param name="aDataFinal">Data final do período da consulta.</param>
        /// <param name="aTipoPeriodo">
        /// Tipo de período utilizado na consulta (por exemplo, emissão, competência).
        /// </param>
        /// <returns>Resposta do provedor com as NFSe de serviços tomados do prestador informado.</returns>
        string ConsultarNFSeServicoTomadoPorPrestador(string aCNPJ, string aInscMun, int aPagina, DateTime aDataInicial, DateTime aDataFinal, int aTipoPeriodo);

        /// <summary>
        /// Consulta NFSe de serviços tomados filtrando por dados do tomador.
        /// </summary>
        /// <param name="aCNPJ">CNPJ/CPF do tomador do serviço.</param>
        /// <param name="aInscMun">Inscrição municipal do tomador.</param>
        /// <param name="aPagina">Número da página de resultados.</param>
        /// <param name="aDataInicial">Data inicial do período da consulta.</param>
        /// <param name="aDataFinal">Data final do período da consulta.</param>
        /// <param name="aTipoPeriodo">
        /// Tipo de período utilizado na consulta (por exemplo, emissão, competência).
        /// </param>
        /// <returns>Resposta do provedor com as NFSe de serviços tomados pelo tomador informado.</returns>
        string ConsultarNFSeServicoTomadoPorTomador(string aCNPJ, string aInscMun, int aPagina, DateTime aDataInicial, DateTime aDataFinal, int aTipoPeriodo);

        /// <summary>
        /// Consulta NFSe de serviços tomados em um determinado período.
        /// </summary>
        /// <param name="aDataInicial">Data inicial do período da consulta.</param>
        /// <param name="aDataFinal">Data final do período da consulta.</param>
        /// <param name="aPagina">Número da página de resultados.</param>
        /// <param name="aTipoPeriodo">
        /// Tipo de período utilizado na consulta (por exemplo, emissão, competência).
        /// </param>
        /// <returns>Resposta do provedor com as NFSe de serviços tomados no período solicitado.</returns>
        string ConsultarNFSeServicoTomadoPorPeriodo(DateTime aDataInicial, DateTime aDataFinal, int aPagina, int aTipoPeriodo);

        /// <summary>
        /// Consulta NFSe de serviços tomados filtrando por intermediário do serviço.
        /// </summary>
        /// <param name="aCNPJ">CNPJ/CPF do intermediário do serviço.</param>
        /// <param name="aInscMun">Inscrição municipal do intermediário.</param>
        /// <param name="aPagina">Número da página de resultados.</param>
        /// <param name="aDataInicial">Data inicial do período da consulta.</param>
        /// <param name="aDataFinal">Data final do período da consulta.</param>
        /// <param name="aTipoPeriodo">
        /// Tipo de período utilizado na consulta (por exemplo, emissão, competência).
        /// </param>
        /// <returns>Resposta do provedor com as NFSe de serviços tomados intermediados pelo contribuinte informado.</returns>
        string ConsultarNFSeServicoTomadoPorIntermediario(string aCNPJ, string aInscMun, int aPagina, DateTime aDataInicial, DateTime aDataFinal, int aTipoPeriodo);

        /// <summary>
        /// Envia um evento relacionado à NFSe para o provedor (por exemplo, cancelamento por substituição,
        /// eventos específicos de cada município).
        /// </summary>
        /// <param name="aInfEvento">
        /// Conteúdo da requisição do evento (XML ou outro formato específico do provedor).
        /// </param>
        /// <returns>Resposta do provedor com o resultado do processamento do evento.</returns>
        string EnviarEvento(string aInfEvento);

        /// <summary>
        /// Consulta uma DPS (Declaração de Prestação de Serviços) pela chave de acesso.
        /// </summary>
        /// <param name="aChaveDPS">Chave de acesso da DPS.</param>
        /// <returns>Resposta do provedor com os dados da DPS consultada.</returns>
        string ConsultarDPSPorChave(string aChaveDPS);

        /// <summary>
        /// Consulta uma NFSe pela chave de acesso.
        /// </summary>
        /// <param name="aChaveNFSe">Chave de acesso da NFSe.</param>
        /// <returns>Resposta do provedor com os dados da NFSe consultada.</returns>
        string ConsultarNFSePorChave(string aChaveNFSe);

        /// <summary>
        /// Consulta um evento de NFSe pela chave, tipo de evento e número de sequência.
        /// </summary>
        /// <param name="aChave">Chave de acesso da NFSe relacionada ao evento.</param>
        /// <param name="aTipoEvento">Tipo do evento, conforme especificação do provedor.</param>
        /// <param name="aNumSeq">Número de sequência do evento.</param>
        /// <returns>Resposta do provedor com os dados do evento consultado.</returns>
        string ConsultarEvento(string aChave, int aTipoEvento, int aNumSeq);

        /// <summary>
        /// Consulta documentos fiscais eletrônicos de NFSe via DFe (Distribuição de Documentos Fiscais),
        /// a partir de um NSU.
        /// </summary>
        /// <param name="aNSU">Número Sequencial Único (NSU) para a consulta.</param>
        /// <returns>Resposta do provedor com a relação de documentos ou eventos disponíveis para o NSU informado.</returns>
        string ConsultarDFe(int aNSU);

        /// <summary>
        /// Obtém o DANFSe (Documento Auxiliar da NFSe) em formato pronto para impressão ou exibição.
        /// </summary>
        /// <param name="aChaveNFSe">Chave de acesso da NFSe.</param>
        /// <returns>
        /// Conteúdo do DANFSe no formato definido pela biblioteca/provedor
        /// (por exemplo, HTML, XML de impressão, etc.).
        /// </returns>
        string ObterDANFSE(string aChaveNFSe);

        /// <summary>
        /// Consulta parâmetros municipais de serviço, como códigos de tributação,
        /// alíquotas ou regras específicas, conforme disponibilizado pelo provedor.
        /// </summary>
        /// <param name="aTipoParametroMunicipio">
        /// Tipo de parâmetro a ser consultado, conforme codificação definida pela biblioteca/provedor.
        /// </param>
        /// <param name="aCodigoServico">Código do serviço utilizado na NFSe.</param>
        /// <param name="aCompetencia">Data de competência para a qual os parâmetros serão consultados.</param>
        /// <param name="aNumeroBeneficio">
        /// Número de benefício/incentivo fiscal, quando necessário para a consulta.
        /// </param>
        /// <returns>Resposta do provedor contendo os parâmetros solicitados.</returns>
        string ConsultarParametros(int aTipoParametroMunicipio, string aCodigoServico, DateTime aCompetencia, string aNumeroBeneficio);

        /// <summary>
        /// Obtém informações detalhadas sobre o provedor de NFSe atualmente configurado.
        /// </summary>
        /// <returns>
        /// Estrutura de dados em <see cref="string"/> (geralmente XML ou INI) contendo
        /// informações como nome do provedor, versão do layout, peculiaridades de implementação, entre outros.
        /// </returns>
        string ObterInformacoesProvedor();
    }
}




