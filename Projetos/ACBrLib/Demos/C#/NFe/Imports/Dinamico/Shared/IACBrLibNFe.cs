using ACBrLib.Core;
using ACBrLib.Core.DFe;
using ACBrLib.Core.NFe;
using System;
using System.IO;

namespace ACBrLib.NFe
{
    /// <summary>
    /// Interface para o ACBrLibNFe
    /// </summary>
    public interface IACBrLibNFe : System.IDisposable, IACBrLibBase
    {

    /// <summary>
    /// Configurações da biblioteca NFe.
    /// </summary>
    ACBrNFeConfig Config { get; }


    /// <summary>
    /// Carrega uma nota fiscal na lista de documentos.
    /// </summary>
    /// <param name="nfe">Objeto NotaFiscal a ser carregado.</param>
    void CarregarNota(NotaFiscal nfe);


    /// <summary>
    /// Retorna a nota fiscal pelo índice informado.
    /// </summary>
    /// <param name="aIndex">Índice da nota fiscal na lista.</param>
    NotaFiscal ObterNFe(int aIndex);


    /// <summary>
    /// Carrega um evento na lista de eventos.
    /// </summary>
    /// <param name="evento">Objeto EventoNFeBase a ser carregado.</param>
    void CarregarEvento(EventoNFeBase evento);


    /// <summary>
    /// Carrega um XML de NFe (arquivo ou string XML).
    /// </summary>
    /// <param name="eArquivoOuXml">Caminho do arquivo XML ou conteúdo XML.</param>
    void CarregarXML(string eArquivoOuXml);


    /// <summary>
    /// Carrega um INI de NFe (arquivo ou string INI).
    /// </summary>
    /// <param name="eArquivoOuIni">Caminho do arquivo INI ou conteúdo INI.</param>
    void CarregarINI(string eArquivoOuIni);


    /// <summary>
    /// Retorna o XML da NFe pelo índice informado.
    /// </summary>
    /// <param name="aIndex">Índice da nota fiscal na lista.</param>
    string ObterXml(int aIndex);


    /// <summary>
    /// Grava o XML da NFe em arquivo.
    /// </summary>
    /// <param name="aIndex">Índice da nota fiscal na lista.</param>
    /// <param name="eNomeArquivo">Nome do arquivo a ser gravado (opcional).</param>
    /// <param name="ePathArquivo">Caminho do diretório onde o arquivo será salvo (opcional).</param>
    void GravarXml(int aIndex, string eNomeArquivo = "", string ePathArquivo = "");


    /// <summary>
    /// Retorna o INI da NFe pelo índice informado.
    /// </summary>
    /// <param name="aIndex">Índice da nota fiscal na lista.</param>
    string ObterIni(int aIndex);


    /// <summary>
    /// Grava o INI da NFe em arquivo.
    /// </summary>
    /// <param name="aIndex">Índice da nota fiscal na lista.</param>
    /// <param name="eNomeArquivo">Nome do arquivo a ser gravado (opcional).</param>
    /// <param name="ePathArquivo">Caminho do diretório onde o arquivo será salvo (opcional).</param>
    void GravarIni(int aIndex, string eNomeArquivo = "", string ePathArquivo = "");


    /// <summary>
    /// Carrega um evento a partir de um XML (arquivo ou string XML).
    /// </summary>
    /// <param name="eArquivoOuXml">Caminho do arquivo XML ou conteúdo XML do evento.</param>
    void CarregarEventoXML(string eArquivoOuXml);


    /// <summary>
    /// Carrega um evento a partir de um INI (arquivo ou string INI).
    /// </summary>
    /// <param name="eArquivoOuIni">Caminho do arquivo INI ou conteúdo INI do evento.</param>
    void CarregarEventoINI(string eArquivoOuIni);

    /// <summary>
    /// Limpa a lista de notas fiscais carregadas.
    /// </summary>
    void LimparLista();

    /// <summary>
    /// Limpa a lista de eventos carregados.
    /// </summary>
    void LimparListaEventos();

    /// <summary>
    /// Assina digitalmente as notas fiscais carregadas.
    /// </summary>
    void Assinar();

    /// <summary>
    /// Valida os XMLs das notas fiscais carregadas.
    /// </summary>
    void Validar();

    /// <summary>
    /// Valida as regras de negócio das notas fiscais carregadas.
    /// </summary>
    /// <returns>Mensagem de validação.</returns>
    string ValidarRegrasdeNegocios();

    /// <summary>
    /// Verifica a assinatura digital das notas fiscais carregadas.
    /// </summary>
    /// <returns>Mensagem de verificação.</returns>
    string VerificarAssinatura();


    /// <summary>
    /// Gera a chave de acesso da NFe.
    /// </summary>
    /// <param name="aCodigoUf">Código da UF.</param>
    /// <param name="aCodigoNumerico">Código numérico da NFe.</param>
    /// <param name="aModelo">Modelo do documento fiscal.</param>
    /// <param name="aSerie">Série do documento fiscal.</param>
    /// <param name="aNumero">Número do documento fiscal.</param>
    /// <param name="aTpEmi">Tipo de emissão.</param>
    /// <param name="aEmissao">Data de emissão.</param>
    /// <param name="acpfcnpj">CPF ou CNPJ do emitente.</param>
    string GerarChave(int aCodigoUf, int aCodigoNumerico, int aModelo, int aSerie, int aNumero, int aTpEmi, DateTime aEmissao, string acpfcnpj);

    /// <summary>
    /// Retorna os certificados digitais disponíveis.
    /// </summary>
    InfoCertificado[] ObterCertificados();


    /// <summary>
    /// Retorna o caminho configurado para determinado tipo de arquivo.
    /// </summary>
    /// <param name="tipo">Tipo do caminho desejado.</param>
    string GetPath(TipoPathNFe tipo);


    /// <summary>
    /// Retorna o caminho configurado para determinado evento.
    /// </summary>
    /// <param name="evento">Nome do evento.</param>
    string GetPathEvento(string evento);

    /// <summary>
    /// Consulta o status do serviço na SEFAZ.
    /// </summary>
    StatusServicoResposta StatusServico();


    /// <summary>
    /// Consulta uma NFe na SEFAZ pela chave ou XML.
    /// </summary>
    /// <param name="eChaveOuNFe">Chave de acesso da NFe ou XML da NFe.</param>
    /// <param name="AExtrairEventos">Se verdadeiro, extrai também os eventos vinculados.</param>
    ConsultaNFeResposta Consultar(string eChaveOuNFe, bool AExtrairEventos = false);


    /// <summary>
    /// Consulta cadastro de contribuinte na SEFAZ.
    /// </summary>
    /// <param name="cUF">Código da UF.</param>
    /// <param name="nDocumento">CNPJ ou CPF do contribuinte.</param>
    /// <param name="nIE">Se verdadeiro, consulta por Inscrição Estadual.</param>
    ConsultaCadastroResposta ConsultaCadastro(string cUF, string nDocumento, bool nIE);


    /// <summary>
    /// Solicita inutilização de numeração de NFe.
    /// </summary>
    /// <param name="acnpj">CNPJ do emitente.</param>
    /// <param name="aJustificativa">Justificativa da inutilização.</param>
    /// <param name="ano">Ano da inutilização.</param>
    /// <param name="modelo">Modelo do documento fiscal.</param>
    /// <param name="serie">Série do documento fiscal.</param>
    /// <param name="numeroInicial">Número inicial da faixa a inutilizar.</param>
    /// <param name="numeroFinal">Número final da faixa a inutilizar.</param>
    InutilizarNFeResposta Inutilizar(string acnpj, string aJustificativa, int ano, int modelo, int serie, int numeroInicial, int numeroFinal);


    /// <summary>
    /// Envia as notas fiscais carregadas para a SEFAZ.
    /// </summary>
    /// <param name="aLote">Número do lote de envio.</param>
    /// <param name="imprimir">Se verdadeiro, imprime após o envio.</param>
    /// <param name="sincrono">Se verdadeiro, envio síncrono.</param>
    /// <param name="zipado">Se verdadeiro, envia o lote compactado.</param>
    EnvioRetornoResposta Enviar(int aLote, bool imprimir = false, bool sincrono = false, bool zipado = false);


    /// <summary>
    /// Consulta o recibo de envio de lote.
    /// </summary>
    /// <param name="aRecibo">Número do recibo retornado no envio.</param>
    RetornoResposta ConsultarRecibo(string aRecibo);


    /// <summary>
    /// Cancela uma NFe já autorizada.
    /// </summary>
    /// <param name="eChave">Chave de acesso da NFe.</param>
    /// <param name="eJustificativa">Justificativa do cancelamento.</param>
    /// <param name="eCNPJ">CNPJ do emitente.</param>
    /// <param name="aLote">Número do lote do evento.</param>
    CancelamentoNFeResposta Cancelar(string eChave, string eJustificativa, string eCNPJ, int aLote);


    /// <summary>
    /// Envia eventos relacionados à NFe.
    /// </summary>
    /// <param name="aLote">Número do lote de eventos.</param>
    EventoResposta EnviarEvento(int aLote);


    /// <summary>
    /// Consulta documentos fiscais eletrônicos por último NSU.
    /// </summary>
    /// <param name="acUFAutor">Código da UF do autor.</param>
    /// <param name="eCnpjcpf">CNPJ ou CPF do interessado.</param>
    /// <param name="eultNsu">Último NSU consultado.</param>
    DistribuicaoDFeResposta<TipoEventoNFe> DistribuicaoDFePorUltNSU(int acUFAutor, string eCnpjcpf, string eultNsu);


    /// <summary>
    /// Consulta documentos fiscais eletrônicos por XML/arquivo.
    /// </summary>
    /// <param name="acUFAutor">Código da UF do autor.</param>
    /// <param name="eCnpjcpf">CNPJ ou CPF do interessado.</param>
    /// <param name="eultNsu">Último NSU consultado.</param>
    /// <param name="ArquivoOuXml">Arquivo ou conteúdo XML para consulta.</param>
    DistribuicaoDFeResposta<TipoEventoNFe> DistribuicaoDFe(int acUFAutor, string eCnpjcpf, string eultNsu, string ArquivoOuXml);


    /// <summary>
    /// Consulta documentos fiscais eletrônicos por NSU.
    /// </summary>
    /// <param name="acUFAutor">Código da UF do autor.</param>
    /// <param name="eCnpjcpf">CNPJ ou CPF do interessado.</param>
    /// <param name="eNsu">NSU a ser consultado.</param>
    DistribuicaoDFeResposta<TipoEventoNFe> DistribuicaoDFePorNSU(int acUFAutor, string eCnpjcpf, string eNsu);


    /// <summary>
    /// Consulta documentos fiscais eletrônicos por chave de acesso.
    /// </summary>
    /// <param name="acUFAutor">Código da UF do autor.</param>
    /// <param name="eCnpjcpf">CNPJ ou CPF do interessado.</param>
    /// <param name="echNFe">Chave de acesso da NFe.</param>
    DistribuicaoDFeResposta<TipoEventoNFe> DistribuicaoDFePorChave(int acUFAutor, string eCnpjcpf, string echNFe);


    /// <summary>
    /// Envia e-mail com a NFe e/ou PDF em anexo.
    /// </summary>
    /// <param name="ePara">E-mail do destinatário.</param>
    /// <param name="eChaveNFe">Chave de acesso da NFe.</param>
    /// <param name="aEnviaPDF">Se verdadeiro, envia o PDF em anexo.</param>
    /// <param name="eAssunto">Assunto do e-mail.</param>
    /// <param name="eMensagem">Mensagem do e-mail.</param>
    /// <param name="eCc">Lista de e-mails em cópia (opcional).</param>
    /// <param name="eAnexos">Lista de arquivos anexos (opcional).</param>
    void EnviarEmail(string ePara, string eChaveNFe, bool aEnviaPDF, string eAssunto, string eMensagem, string[] eCc = null, string[] eAnexos = null);


    /// <summary>
    /// Envia e-mail com evento da NFe e/ou PDF em anexo.
    /// </summary>
    /// <param name="ePara">E-mail do destinatário.</param>
    /// <param name="eChaveEvento">Chave do evento.</param>
    /// <param name="eChaveNFe">Chave de acesso da NFe.</param>
    /// <param name="aEnviaPDF">Se verdadeiro, envia o PDF em anexo.</param>
    /// <param name="eAssunto">Assunto do e-mail.</param>
    /// <param name="eMensagem">Mensagem do e-mail.</param>
    /// <param name="eCc">Lista de e-mails em cópia (opcional).</param>
    /// <param name="eAnexos">Lista de arquivos anexos (opcional).</param>
    void EnviarEmailEvento(string ePara, string eChaveEvento, string eChaveNFe, bool aEnviaPDF, string eAssunto, string eMensagem, string[] eCc = null, string[] eAnexos = null);


    /// <summary>
    /// Imprime a NFe.
    /// </summary>
    /// <param name="cImpressora">Nome da impressora (opcional).</param>
    /// <param name="nNumCopias">Número de cópias.</param>
    /// <param name="cProtocolo">Protocolo de autorização (opcional).</param>
    /// <param name="bMostrarPreview">Se verdadeiro, exibe preview antes de imprimir (opcional).</param>
    /// <param name="cMarcaDagua">Se verdadeiro, imprime com marca d'água (opcional).</param>
    /// <param name="bViaConsumidor">Se verdadeiro, imprime via consumidor (opcional).</param>
    /// <param name="bSimplificado">Se verdadeiro, imprime em modo simplificado (opcional).</param>
    void Imprimir(string cImpressora = "", int nNumCopias = 1, string cProtocolo = "", bool? bMostrarPreview = null, bool? cMarcaDagua = null, bool? bViaConsumidor = null, bool? bSimplificado = null);

    /// <summary>
    /// Gera o PDF da NFe.
    /// </summary>
    void ImprimirPDF();


    /// <summary>
    /// Gera o PDF da NFe em um stream.
    /// </summary>
    /// <param name="aStream">Stream de saída para o PDF.</param>
    void ImprimirPDF(Stream aStream);


    /// <summary>
    /// Imprime evento vinculado à NFe.
    /// </summary>
    /// <param name="eArquivoXmlNFe">Arquivo XML da NFe.</param>
    /// <param name="eArquivoXmlEvento">Arquivo XML do evento.</param>
    void ImprimirEvento(string eArquivoXmlNFe, string eArquivoXmlEvento);


    /// <summary>
    /// Gera o PDF do evento vinculado à NFe.
    /// </summary>
    /// <param name="eArquivoXmlNFe">Arquivo XML da NFe.</param>
    /// <param name="eArquivoXmlEvento">Arquivo XML do evento.</param>
    void ImprimirEventoPDF(string eArquivoXmlNFe, string eArquivoXmlEvento);


    /// <summary>
    /// Gera o PDF do evento vinculado à NFe em um stream.
    /// </summary>
    /// <param name="eArquivoXmlNFe">Arquivo XML da NFe.</param>
    /// <param name="eArquivoXmlEvento">Arquivo XML do evento.</param>
    /// <param name="aStream">Stream de saída para o PDF.</param>
    void ImprimirEventoPDF(string eArquivoXmlNFe, string eArquivoXmlEvento, Stream aStream);


    /// <summary>
    /// Imprime inutilização de numeração de NFe.
    /// </summary>
    /// <param name="eArquivoXml">Arquivo XML da inutilização.</param>
    void ImprimirInutilizacao(string eArquivoXml);


    /// <summary>
    /// Gera o PDF da inutilização de NFe.
    /// </summary>
    /// <param name="eArquivoXml">Arquivo XML da inutilização.</param>
    void ImprimirInutilizacaoPDF(string eArquivoXml);


    /// <summary>
    /// Gera o PDF da inutilização de NFe em um stream.
    /// </summary>
    /// <param name="eArquivoXml">Arquivo XML da inutilização.</param>
    /// <param name="aStream">Stream de saída para o PDF.</param>
    void ImprimirInutilizacaoPDF(string eArquivoXml, Stream aStream);
    }
}