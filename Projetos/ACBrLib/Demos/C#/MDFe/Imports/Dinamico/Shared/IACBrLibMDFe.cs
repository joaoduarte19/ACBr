using System;
using System.IO;
using ACBrLib.Core;
using ACBrLib.Core.DFe;
using ACBrLib.Core.Extensions;
using ACBrLib.Core.MDFe;
namespace ACBrLib.MDFe

{

    /// <summary>
    /// Interface de comunicação com a biblioteca ACBrLibMDFe.
    /// </summary>
    public interface IACBrLibMDFe : IACBrLibBase, IDisposable
    {
        /// <summary>
        /// Configuração do componente MDFe.
        /// </summary>
        MDFeConfig Config { get; }

        /// <summary>
        /// Carrega um manifesto na lista interna.
        /// </summary>
        void CarregarManifesto(Manifesto manifesto);

        /// <summary>
        /// Obtém um manifesto da lista pelo índice.
        /// </summary>
        Manifesto ObterManifesto(int aIndex);

        /// <summary>
        /// Carrega um evento na lista de eventos.
        /// </summary>
        void CarregarEvento(EventoMDFeBase evento);

        /// <summary>
        /// Carrega um XML de MDF-e para o componente.
        /// </summary>
        /// <param name="eArquivoOuXml">Caminho do arquivo XML ou conteúdo XML.</param>
        void CarregarXML(string eArquivoOuXml);

        /// <summary>
        /// Carrega um INI de MDF-e para o componente.
        /// </summary>
        /// <param name="eArquivoOuIni">Caminho do arquivo INI ou conteúdo INI.</param>
        void CarregarINI(string eArquivoOuIni);

        /// <summary>
        /// Obtém o XML do manifesto pelo índice.
        /// </summary>
        string ObterXml(int aIndex);

        /// <summary>
        /// Grava o XML do manifesto em arquivo.
        /// </summary>
        void GravarXml(int aIndex, string eNomeArquivo = "", string ePathArquivo = "");

        /// <summary>
        /// Obtém o INI do manifesto pelo índice.
        /// </summary>
        string ObterIni(int aIndex);

        /// <summary>
        /// Grava o INI do manifesto em arquivo.
        /// </summary>
        void GravarIni(int aIndex, string eNomeArquivo = "", string ePathArquivo = "");

        /// <summary>
        /// Carrega um evento a partir de um XML.
        /// </summary>
        void CarregarEventoXML(string eArquivoOuXml);

        /// <summary>
        /// Carrega um evento a partir de um INI.
        /// </summary>
        void CarregarEventoINI(string eArquivoOuIni);

        /// <summary>
        /// Limpa a lista de manifestos carregados.
        /// </summary>
        void LimparLista();

        /// <summary>
        /// Limpa a lista de eventos carregados.
        /// </summary>
        void LimparListaEventos();

        /// <summary>
        /// Assina os manifestos carregados.
        /// </summary>
        void Assinar();

        /// <summary>
        /// Valida os manifestos assinados.
        /// </summary>
        void Validar();

        /// <summary>
        /// Valida as regras de negócio do MDF-e.
        /// </summary>
        string ValidarRegrasdeNegocios();

        /// <summary>
        /// Verifica a assinatura digital do MDF-e.
        /// </summary>
        string VerificarAssinatura();

        /// <summary>
        /// Gera a chave de acesso do MDF-e.
        /// </summary>
        string GerarChave(int aCodigoUf, int aCodigoNumerico, int aModelo, int aSerie, int aNumero,
          int aTpEmi, DateTime aEmissao, string acpfcnpj);

        /// <summary>
        /// Obtém a lista de certificados disponíveis.
        /// </summary>
        InfoCertificado[] ObterCertificados();

        /// <summary>
        /// Obtém o caminho configurado para determinado tipo.
        /// </summary>
        string GetPath(TipoPathMDFe tipo);

        /// <summary>
        /// Obtém o caminho configurado para determinado evento.
        /// </summary>
        string GetPathEvento(TipoEventoMDFe evento);

        /// <summary>
        /// Consulta o status do serviço na SEFAZ.
        /// </summary>
        StatusServicoResposta StatusServico();

        /// <summary>
        /// Consulta um MDF-e pela chave ou NFe.
        /// </summary>
        ConsultaMDFeResposta Consultar(string eChaveOuNFe, bool AExtrairEventos = false);

        /// <summary>
        /// Envia o MDF-e para a SEFAZ.
        /// </summary>
        EnvioRetornoResposta Enviar(int aLote, bool imprimir = false, bool sincrono = false);

        /// <summary>
        /// Consulta o recibo de envio do MDF-e.
        /// </summary>
        RetornoResposta ConsultarRecibo(string aRecibo);

        /// <summary>
        /// Cancela um MDF-e.
        /// </summary>
        CancelamentoMDFeResposta Cancelar(string eChave, string eJustificativa, string eCNPJ, int aLote);

        /// <summary>
        /// Envia um evento para o MDF-e.
        /// </summary>
        EventoResposta EnviarEvento(int aLote);

        /// <summary>
        /// Encerra um MDF-e.
        /// </summary>
        EncerramentoResposta EncerrarMDFe(string eChaveOuMDFe, DateTime eDtEnc, string cMunicipioDescarga, string nCNPJ = "", string nProtocolo = "");

        /// <summary>
        /// Consulta MDF-e não encerrados para o CNPJ informado.
        /// </summary>
        NaoEncerradosResposta ConsultaMDFeNaoEnc(string cnpj);

        /// <summary>
        /// Consulta DF-e por último NSU.
        /// </summary>
        DistribuicaoDFeResposta<TipoEventoMDFe> DistribuicaoDFePorUltNSU(string eCnpjcpf, string eultNsu);

        /// <summary>
        /// Consulta DF-e por NSU.
        /// </summary>
        DistribuicaoDFeResposta<TipoEventoMDFe> DistribuicaoDFePorNSU(string eCnpjcpf, string eNsu);

        /// <summary>
        /// Consulta DF-e por chave.
        /// </summary>
        DistribuicaoDFeResposta<TipoEventoMDFe> DistribuicaoDFePorChave(int acUFAutor, string eCnpjcpf, string echNFe);

        /// <summary>
        /// Envia e-mail com o MDF-e.
        /// </summary>
        void EnviarEmail(string ePara, string eChaveNFe, bool aEnviaPDF, string eAssunto, string eMensagem, string[] eCc = null, string[] eAnexos = null);

        /// <summary>
        /// Envia e-mail de evento do MDF-e.
        /// </summary>
        void EnviarEmailEvento(string ePara, string eChaveEvento, string eChaveNFe, bool aEnviaPDF, string eAssunto, string eMensagem, string[] eCc = null, string[] eAnexos = null);

        /// <summary>
        /// Imprime o MDF-e.
        /// </summary>
        void Imprimir(string cImpressora = "", int nNumCopias = 1, string cProtocolo = "", bool? bMostrarPreview = null);

        /// <summary>
        /// Gera o PDF do MDF-e.
        /// </summary>
        void ImprimirPDF();

        /// <summary>
        /// Gera o PDF do MDF-e em um stream.
        /// </summary>
        void ImprimirPDF(Stream aStream);

        /// <summary>
        /// Imprime um evento do MDF-e.
        /// </summary>
        void ImprimirEvento(string eArquivoXmlNFe, string eArquivoXmlEvento);

        /// <summary>
        /// Gera o PDF de um evento do MDF-e.
        /// </summary>
        void ImprimirEventoPDF(string eArquivoXmlNFe, string eArquivoXmlEvento);
    }
}
