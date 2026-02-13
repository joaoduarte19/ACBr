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

        ACBrNFeConfig Config { get; }
        void CarregarNota(NotaFiscal nfe);
        NotaFiscal ObterNFe(int aIndex);
        void CarregarEvento(EventoNFeBase evento);
        void CarregarXML(string eArquivoOuXml);
        void CarregarINI(string eArquivoOuIni);
        string ObterXml(int aIndex);
        void GravarXml(int aIndex, string eNomeArquivo = "", string ePathArquivo = "");
        string ObterIni(int aIndex);
        void GravarIni(int aIndex, string eNomeArquivo = "", string ePathArquivo = "");
        void CarregarEventoXML(string eArquivoOuXml);
        void CarregarEventoINI(string eArquivoOuIni);
        void LimparLista();
        void LimparListaEventos();
        void Assinar();
        void Validar();
        string ValidarRegrasdeNegocios();
        string VerificarAssinatura();
        string GerarChave(int aCodigoUf, int aCodigoNumerico, int aModelo, int aSerie, int aNumero, int aTpEmi, DateTime aEmissao, string acpfcnpj);
        InfoCertificado[] ObterCertificados();
        string GetPath(TipoPathNFe tipo);
        string GetPathEvento(string evento);
        StatusServicoResposta StatusServico();
        ConsultaNFeResposta Consultar(string eChaveOuNFe, bool AExtrairEventos = false);
        ConsultaCadastroResposta ConsultaCadastro(string cUF, string nDocumento, bool nIE);
        InutilizarNFeResposta Inutilizar(string acnpj, string aJustificativa, int ano, int modelo, int serie, int numeroInicial, int numeroFinal);
        EnvioRetornoResposta Enviar(int aLote, bool imprimir = false, bool sincrono = false, bool zipado = false);
        RetornoResposta ConsultarRecibo(string aRecibo);
        CancelamentoNFeResposta Cancelar(string eChave, string eJustificativa, string eCNPJ, int aLote);
        EventoResposta EnviarEvento(int aLote);
        DistribuicaoDFeResposta<TipoEventoNFe> DistribuicaoDFePorUltNSU(int acUFAutor, string eCnpjcpf, string eultNsu);
        DistribuicaoDFeResposta<TipoEventoNFe> DistribuicaoDFe(int acUFAutor, string eCnpjcpf, string eultNsu, string ArquivoOuXml);
        DistribuicaoDFeResposta<TipoEventoNFe> DistribuicaoDFePorNSU(int acUFAutor, string eCnpjcpf, string eNsu);
        DistribuicaoDFeResposta<TipoEventoNFe> DistribuicaoDFePorChave(int acUFAutor, string eCnpjcpf, string echNFe);
        void EnviarEmail(string ePara, string eChaveNFe, bool aEnviaPDF, string eAssunto, string eMensagem, string[] eCc = null, string[] eAnexos = null);
        void EnviarEmailEvento(string ePara, string eChaveEvento, string eChaveNFe, bool aEnviaPDF, string eAssunto, string eMensagem, string[] eCc = null, string[] eAnexos = null);
        void Imprimir(string cImpressora = "", int nNumCopias = 1, string cProtocolo = "", bool? bMostrarPreview = null, bool? cMarcaDagua = null, bool? bViaConsumidor = null, bool? bSimplificado = null);
        void ImprimirPDF();
        void ImprimirPDF(Stream aStream);
        void ImprimirEvento(string eArquivoXmlNFe, string eArquivoXmlEvento);
        void ImprimirEventoPDF(string eArquivoXmlNFe, string eArquivoXmlEvento);
        void ImprimirEventoPDF(string eArquivoXmlNFe, string eArquivoXmlEvento, Stream aStream);
        void ImprimirInutilizacao(string eArquivoXml);
        void ImprimirInutilizacaoPDF(string eArquivoXml);
        void ImprimirInutilizacaoPDF(string eArquivoXml, Stream aStream);
    }
}