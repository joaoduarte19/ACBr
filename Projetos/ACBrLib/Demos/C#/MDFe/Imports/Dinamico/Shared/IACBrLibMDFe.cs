using System;
using System.IO;
using ACBrLib.Core;
using ACBrLib.Core.DFe;
using ACBrLib.Core.Extensions;
using ACBrLib.Core.MDFe;
namespace ACBrLib.MDFe

{
    public interface IACBrLibMDFe : IACBrLibBase, IDisposable
    {
        MDFeConfig Config { get; }
        void CarregarManifesto(Manifesto manifesto);
        Manifesto ObterManifesto(int aIndex);
        void CarregarEvento(EventoMDFeBase evento);
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
        string GerarChave(int aCodigoUf, int aCodigoNumerico, int aModelo, int aSerie, int aNumero,
          int aTpEmi, DateTime aEmissao, string acpfcnpj);
        InfoCertificado[] ObterCertificados();
        string GetPath(TipoPathMDFe tipo);
        string GetPathEvento(TipoEventoMDFe evento);
        StatusServicoResposta StatusServico();
        ConsultaMDFeResposta Consultar(string eChaveOuNFe, bool AExtrairEventos = false);
        EnvioRetornoResposta Enviar(int aLote, bool imprimir = false, bool sincrono = false);
        RetornoResposta ConsultarRecibo(string aRecibo);
        CancelamentoMDFeResposta Cancelar(string eChave, string eJustificativa, string eCNPJ, int aLote);
        EventoResposta EnviarEvento(int aLote);
        EncerramentoResposta EncerrarMDFe(string eChaveOuMDFe, DateTime eDtEnc, string cMunicipioDescarga, string nCNPJ = "", string nProtocolo = "");
        NaoEncerradosResposta ConsultaMDFeNaoEnc(string cnpj);
        DistribuicaoDFeResposta<TipoEventoMDFe> DistribuicaoDFePorUltNSU(string eCnpjcpf, string eultNsu);
        DistribuicaoDFeResposta<TipoEventoMDFe> DistribuicaoDFePorNSU(string eCnpjcpf, string eNsu);
        DistribuicaoDFeResposta<TipoEventoMDFe> DistribuicaoDFePorChave(int acUFAutor, string eCnpjcpf, string echNFe);
        void EnviarEmail(string ePara, string eChaveNFe, bool aEnviaPDF, string eAssunto, string eMensagem, string[] eCc = null, string[] eAnexos = null);
        void EnviarEmailEvento(string ePara, string eChaveEvento, string eChaveNFe, bool aEnviaPDF, string eAssunto, string eMensagem, string[] eCc = null, string[] eAnexos = null);
        void Imprimir(string cImpressora = "", int nNumCopias = 1, string cProtocolo = "", bool? bMostrarPreview = null);
        void ImprimirPDF();
        void ImprimirPDF(Stream aStream);
        void ImprimirEvento(string eArquivoXmlNFe, string eArquivoXmlEvento);
        void ImprimirEventoPDF(string eArquivoXmlNFe, string eArquivoXmlEvento);
    }
}
