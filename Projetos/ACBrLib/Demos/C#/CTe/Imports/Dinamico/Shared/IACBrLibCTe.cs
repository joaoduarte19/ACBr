using System.IO;
using System;
using ACBrLib.Core;
using ACBrLib.Core.CTe;
using ACBrLib.Core.DFe;
namespace ACBrLib.CTe
{
    /// <summary>
    /// Interface de comunicação com a classe ACBrCTe. Esta interface é utilizada para desacoplar a implementação da classe ACBrCTe, permitindo que outras implementações possam ser utilizadas sem afetar o código que depende dela.
    /// </summary>
    public interface IACBrLibCTe : IACBrLibBase, IDisposable
    {
        /// <summary>
        /// Configuração da biblioteca CTe.
        /// </summary>
        CTeConfig Config { get; }

        /// <summary>
        /// Carrega um CTe a partir de um objeto CTe (em formato INI).
        /// </summary>
        /// <param name="cte">Objeto CTe a ser carregado.</param>
        void CarregarCTe(CTe cte);

        /// <summary>
        /// Obtém o CTe carregado no índice informado.
        /// </summary>
        /// <param name="aIndex">Índice do CTe.</param>
        /// <returns>Objeto CTe correspondente.</returns>
        CTe ObterCTe(int aIndex);

        /// <summary>
        /// Carrega um CTe a partir de um arquivo ou string XML.
        /// </summary>
        /// <param name="eArquivoOuXml">Caminho do arquivo XML ou conteúdo XML.</param>
        void CarregarXML(string eArquivoOuXml);

        /// <summary>
        /// Carrega um CTe a partir de um arquivo ou string INI.
        /// </summary>
        /// <param name="eArquivoOuIni">Caminho do arquivo INI ou conteúdo INI.</param>
        void CarregarINI(string eArquivoOuIni);

        /// <summary>
        /// Retorna o XML do CTe carregado no índice informado.
        /// </summary>
        /// <param name="aIndex">Índice do CTe.</param>
        /// <returns>Conteúdo XML do CTe.</returns>
        string ObterXml(int aIndex);

        /// <summary>
        /// Grava o XML do CTe no disco.
        /// </summary>
        /// <param name="aIndex">Índice do CTe.</param>
        /// <param name="eNomeArquivo">Nome do arquivo de saída.</param>
        /// <param name="ePathArquivo">Caminho do diretório de saída.</param>
        void GravarXml(int aIndex, string eNomeArquivo = "", string ePathArquivo = "");

        /// <summary>
        /// Retorna o INI do CTe carregado no índice informado.
        /// </summary>
        /// <param name="aIndex">Índice do CTe.</param>
        /// <returns>Conteúdo INI do CTe.</returns>
        string ObterIni(int aIndex);

        /// <summary>
        /// Grava o INI do CTe no disco.
        /// </summary>
        /// <param name="aIndex">Índice do CTe.</param>
        /// <param name="eNomeArquivo">Nome do arquivo de saída.</param>
        /// <param name="ePathArquivo">Caminho do diretório de saída.</param>
        void GravarIni(int aIndex, string eNomeArquivo = "", string ePathArquivo = "");

        /// <summary>
        /// Carrega um evento do CTe a partir de um arquivo ou string XML.
        /// </summary>
        /// <param name="eArquivoOuXml">Caminho do arquivo XML ou conteúdo XML do evento.</param>
        void CarregarEventoXML(string eArquivoOuXml);

        /// <summary>
        /// Carrega um evento do CTe a partir de um arquivo ou string INI.
        /// </summary>
        /// <param name="eArquivoOuIni">Caminho do arquivo INI ou conteúdo INI do evento.</param>
        void CarregarEventoINI(string eArquivoOuIni);

        /// <summary>
        /// Limpa a lista de CTe carregados na memória.
        /// </summary>
        void LimparLista();

        /// <summary>
        /// Limpa a lista de eventos carregados na memória.
        /// </summary>
        void LimparListaEventos();

        /// <summary>
        /// Realiza a assinatura digital dos CTe carregados.
        /// </summary>
        void Assinar();

        /// <summary>
        /// Realiza a validação dos CTe carregados (schema XML).
        /// </summary>
        void Validar();

        /// <summary>
        /// Valida as regras de negócio dos CTe carregados.
        /// </summary>
        /// <returns>Resultado da validação das regras de negócio.</returns>
        string ValidarRegrasdeNegocios();

        /// <summary>
        /// Verifica a assinatura digital dos CTe carregados.
        /// </summary>
        /// <returns>Resultado da verificação da assinatura.</returns>
        string VerificarAssinatura();

        /// <summary>
        /// Gera a chave de acesso do CTe.
        /// </summary>
        /// <param name="aCodigoUf">Código da UF.</param>
        /// <param name="aCodigoNumerico">Código numérico.</param>
        /// <param name="aModelo">Modelo do documento.</param>
        /// <param name="aSerie">Série do documento.</param>
        /// <param name="aNumero">Número do documento.</param>
        /// <param name="aTpEmi">Tipo de emissão.</param>
        /// <param name="aEmissao">Data de emissão.</param>
        /// <param name="acpfcnpj">CPF ou CNPJ do emitente.</param>
        /// <returns>Chave de acesso gerada.</returns>
        string GerarChave(int aCodigoUf, int aCodigoNumerico, int aModelo, int aSerie, int aNumero,
                int aTpEmi, DateTime aEmissao, string acpfcnpj);

        /// <summary>
        /// Obtém informações dos certificados digitais disponíveis.
        /// </summary>
        /// <returns>Array de informações dos certificados.</returns>
        InfoCertificado[] ObterCertificados();

        /// <summary>
        /// Retorna o caminho de diretórios utilizados pela biblioteca.
        /// </summary>
        /// <param name="tipo">Tipo do caminho solicitado.</param>
        /// <returns>Caminho correspondente ao tipo informado.</returns>
        string GetPath(TipoPathCTe tipo);

        /// <summary>
        /// Retorna o caminho de diretórios de eventos utilizados pela biblioteca.
        /// </summary>
        /// <param name="evento">Tipo do evento.</param>
        /// <returns>Caminho do evento.</returns>
        string GetPathEvento(string evento);

        /// <summary>
        /// Consulta o status do serviço na SEFAZ.
        /// </summary>
        /// <returns>Resultado da consulta de status.</returns>
        string StatusServico();

        /// <summary>
        /// Consulta um CTe na SEFAZ pela chave ou XML.
        /// </summary>
        /// <param name="eChaveOuCTe">Chave de acesso ou XML do CTe.</param>
        /// <param name="AExtrairEventos">Se deve extrair eventos vinculados.</param>
        /// <returns>Resposta da consulta.</returns>
        ConsultaCTeResposta Consultar(string eChaveOuCTe, bool AExtrairEventos = false);

        /// <summary>
        /// Consulta o cadastro do contribuinte na SEFAZ.
        /// </summary>
        /// <param name="cUF">Código da UF.</param>
        /// <param name="nDocumento">CPF ou CNPJ.</param>
        /// <param name="nIE">Se é inscrição estadual.</param>
        /// <returns>Resultado da consulta de cadastro.</returns>
        string ConsultaCadastro(string cUF, string nDocumento, bool nIE);

        /// <summary>
        /// Solicita a inutilização de numeração de CTe.
        /// </summary>
        /// <param name="acnpj">CNPJ do emitente.</param>
        /// <param name="aJustificativa">Justificativa da inutilização.</param>
        /// <param name="ano">Ano da inutilização.</param>
        /// <param name="modelo">Modelo do documento.</param>
        /// <param name="serie">Série do documento.</param>
        /// <param name="numeroInicial">Número inicial.</param>
        /// <param name="numeroFinal">Número final.</param>
        /// <returns>Resposta da inutilização.</returns>
        InutilizacaoCTeResposta Inutilizar(string acnpj, string aJustificativa, int ano, int modelo, int serie, int numeroInicial, int numeroFinal);

        /// <summary>
        /// Envia os CTe para a SEFAZ.
        /// </summary>
        /// <param name="aLote">Número do lote.</param>
        /// <param name="imprimir">Se deve imprimir após o envio.</param>
        /// <param name="sincrono">Se o envio é síncrono.</param>
        /// <returns>Resposta do envio.</returns>
        EnvioRetornoResposta Enviar(int aLote, bool imprimir = false, bool sincrono = false);

        /// <summary>
        /// Consulta o recibo de envio do CTe.
        /// </summary>
        /// <param name="aRecibo">Número do recibo.</param>
        /// <returns>Resultado da consulta do recibo.</returns>
        string ConsultarRecibo(string aRecibo);

        /// <summary>
        /// Solicita o cancelamento de um CTe.
        /// </summary>
        /// <param name="eChave">Chave de acesso do CTe.</param>
        /// <param name="eJustificativa">Justificativa do cancelamento.</param>
        /// <param name="eCNPJ">CNPJ do emitente.</param>
        /// <param name="aLote">Número do lote.</param>
        /// <returns>Resposta do cancelamento.</returns>
        CancelamentoCTeResposta Cancelar(string eChave, string eJustificativa, string eCNPJ, int aLote);

        /// <summary>
        /// Envia eventos de CTe para a SEFAZ.
        /// </summary>
        /// <param name="aLote">Número do lote.</param>
        /// <returns>Resultado do envio do evento.</returns>
        string EnviarEvento(int aLote);

        /// <summary>
        /// Realiza a distribuição de DF-e por último NSU.
        /// </summary>
        /// <param name="acUFAutor">Código da UF autora.</param>
        /// <param name="eCnpjcpf">CNPJ ou CPF do interessado.</param>
        /// <param name="eultNsu">Último NSU.</param>
        /// <returns>Resultado da distribuição.</returns>
        string DistribuicaoDFePorUltNSU(int acUFAutor, string eCnpjcpf, string eultNsu);

        /// <summary>
        /// Realiza a distribuição de DF-e por arquivo/XML.
        /// </summary>
        /// <param name="acUFAutor">Código da UF autora.</param>
        /// <param name="eCnpjcpf">CNPJ ou CPF do interessado.</param>
        /// <param name="eultNsu">Último NSU.</param>
        /// <param name="ArquivoOuXml">Arquivo ou XML de solicitação.</param>
        /// <returns>Resultado da distribuição.</returns>
        string DistribuicaoDFe(int acUFAutor, string eCnpjcpf, string eultNsu, string ArquivoOuXml);

        /// <summary>
        /// Realiza a distribuição de DF-e por NSU.
        /// </summary>
        /// <param name="acUFAutor">Código da UF autora.</param>
        /// <param name="eCnpjcpf">CNPJ ou CPF do interessado.</param>
        /// <param name="eNsu">NSU solicitado.</param>
        /// <returns>Resultado da distribuição.</returns>
        string DistribuicaoDFePorNSU(int acUFAutor, string eCnpjcpf, string eNsu);

        /// <summary>
        /// Realiza a distribuição de DF-e por chave de acesso.
        /// </summary>
        /// <param name="acUFAutor">Código da UF autora.</param>
        /// <param name="eCnpjcpf">CNPJ ou CPF do interessado.</param>
        /// <param name="echCTe">Chave de acesso do CTe.</param>
        /// <returns>Resultado da distribuição.</returns>
        string DistribuicaoDFePorChave(int acUFAutor, string eCnpjcpf, string echCTe);

        /// <summary>
        /// Envia o CTe por e-mail.
        /// </summary>
        /// <param name="ePara">Destinatário.</param>
        /// <param name="eArquivoCTe">Arquivo do CTe.</param>
        /// <param name="aEnviaPDF">Se deve enviar PDF.</param>
        /// <param name="eAssunto">Assunto do e-mail.</param>
        /// <param name="eMensagem">Mensagem do e-mail.</param>
        /// <param name="eCc">Destinatários em cópia.</param>
        /// <param name="eAnexos">Arquivos anexos.</param>
        void EnviarEmail(string ePara, string eArquivoCTe, bool aEnviaPDF, string eAssunto, string eMensagem, string[] eCc = null, string[] eAnexos = null);

        /// <summary>
        /// Envia evento do CTe por e-mail.
        /// </summary>
        /// <param name="ePara">Destinatário.</param>
        /// <param name="eArquivoEvento">Arquivo do evento.</param>
        /// <param name="eArquivoCTe">Arquivo do CTe.</param>
        /// <param name="aEnviaPDF">Se deve enviar PDF.</param>
        /// <param name="eAssunto">Assunto do e-mail.</param>
        /// <param name="eMensagem">Mensagem do e-mail.</param>
        /// <param name="eCc">Destinatários em cópia.</param>
        /// <param name="eAnexos">Arquivos anexos.</param>
        void EnviarEmailEvento(string ePara, string eArquivoEvento, string eArquivoCTe, bool aEnviaPDF, string eAssunto, string eMensagem, string[] eCc = null, string[] eAnexos = null);

        /// <summary>
        /// Imprime o CTe.
        /// </summary>
        /// <param name="cImpressora">Nome da impressora.</param>
        /// <param name="nNumCopias">Número de cópias.</param>
        /// <param name="cProtocolo">Protocolo de autorização.</param>
        /// <param name="bMostrarPreview">Se deve mostrar preview.</param>
        void Imprimir(string cImpressora = "", int nNumCopias = 1, string cProtocolo = "", bool? bMostrarPreview = null);

        /// <summary>
        /// Gera o PDF do CTe.
        /// </summary>
        void ImprimirPDF();

        /// <summary>
        /// Gera o PDF do CTe e grava em um stream.
        /// </summary>
        /// <param name="aStream">Stream de saída para o PDF.</param>
        void ImprimirPDF(Stream aStream);

        /// <summary>
        /// Imprime o evento do CTe.
        /// </summary>
        /// <param name="eArquivoXmlCTe">Arquivo XML do CTe.</param>
        /// <param name="eArquivoXmlEvento">Arquivo XML do evento.</param>
        void ImprimirEvento(string eArquivoXmlCTe, string eArquivoXmlEvento);

        /// <summary>
        /// Gera o PDF do evento do CTe.
        /// </summary>
        /// <param name="eArquivoXmlCTe">Arquivo XML do CTe.</param>
        /// <param name="eArquivoXmlEvento">Arquivo XML do evento.</param>
        void ImprimirEventoPDF(string eArquivoXmlCTe, string eArquivoXmlEvento);

        /// <summary>
        /// Imprime a inutilização do CTe.
        /// </summary>
        /// <param name="eArquivoXml">Arquivo XML da inutilização.</param>
        void ImprimirInutilizacao(string eArquivoXml);

        /// <summary>
        /// Gera o PDF da inutilização do CTe.
        /// </summary>
        /// <param name="eArquivoXml">Arquivo XML da inutilização.</param>
        void ImprimirInutilizacaoPDF(string eArquivoXml);
    }
}
