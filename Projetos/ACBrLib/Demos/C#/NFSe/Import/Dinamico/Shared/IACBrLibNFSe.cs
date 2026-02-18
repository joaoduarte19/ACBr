using System;
using System.IO;
using ACBrLib.Core;
using ACBrLib.Core.DFe;

namespace ACBrLib.NFSe
{

    /// <summary>
    /// Interface IACBrLibNFSe, respons�vel por definir os m�todos e propriedades para a emiss�o de Notas Fiscais de Servi�o Eletr�nicas (NFSe) utilizando a biblioteca ACBrLib.
    /// </summary>
    public interface IACBrLibNFSe : IACBrLibBase, IDisposable
       {
              ACBrNFSeConfig Config { get; }
              void CarregarXML(string eArquivoOuXml);
              void CarregarLoteXML(string eArquivoOuXml);
              void CarregarINI(string eArquivoOuIni);
              string ObterXml(int aIndex);
              string ObterXmlRps(int aIndex);
              void GravarXml(int aIndex, string eNomeArquivo = "", string ePathArquivo = "");
              string ObterIni(int aIndex);
              void GravarIni(int aIndex, string eNomeArquivo = "", string ePathArquivo = "");
              void LimparLista();
              InfoCertificado[] ObterCertificados();
              string Emitir(string aLote, int aModoEnvio, bool aImprimir);
              string Cancelar(string aInfCancelamento);
              string SubstituirNFSe(string aNumeroNFSe, string aSerieNFSe, string aCodigoCancelamento, string aMotivoCancelamento, string aNumeroLote, string aCodigoVerificacao);
              string LinkNFSe(string aNumeroNFSe, string aCodigoVerificacao, string aChaveAcesso, string aValorServico);
              string GerarLote(string aLote, int aQtdMaximaRps, int aModoEnvio);
              string GerarToken();
              string ConsultarSituacao(string aProtocolo, string aNumeroLote);
              string ConsultarLoteRps(string aProcotolo, string aNumLote);
              string ConsultarNFSePorRps(string aNumeroRps, string aSerie, string aTipo, string aCodigoVerificacao);
              string ConsultarNFSePorNumero(string aNumero, int aPagina);
              string ConsultarNFSePorPeriodo(DateTime aDataInicial, DateTime aDataFinal, int aPagina, string aNumeroLote, int aTipoPeriodo);
              string ConsultarNFSePorFaixa(string aNumeroInicial, string aNumeroFinal, int aPagina);
              string ConsultarNFSeGenerico(string aInfConsultaNFSe);
              string ConsultarLinkNFSe(string aInfConsultaLinkNFSe);
              void EnviarEmail(string ePara, string eXmlNFSe, bool aEnviaPDF, string eAssunto, string eCc, string eAnexos, string eMensagem);
              void Imprimir(string cImpressora = "", int nNumCopias = 1, bool? bGerarPDF = null, bool? bMostrarPreview = null, string cCancelada = "");
              void ImprimirPDF();
              void ImprimirPDF(Stream aStream);
              string ConsultarNFSeServicoPrestadoPorNumero(string aNumero, int aPagina, DateTime aDataInicial, DateTime aDataFinal, int aTipoPeriodo);
              string ConsultarNFSeServicoPrestadoPorPeriodo(DateTime aDataInicial, DateTime aDataFinal, int aPagina, int aTipoPeriodo);
              string ConsultarNFSeServicoPrestadoPorTomador(string aCNPJ, string aInscMun, int aPagina, DateTime aDataInicial, DateTime aDataFinal, int aTipoPeriodo);
              string ConsultarNFSeServicoPrestadoPorIntermediario(string aCNPJ, string aInscMun, int aPagina, DateTime aDataInicial, DateTime aDataFinal, int aTipoPeriodo);
              string ConsultarNFSeServicoTomadoPorNumero(string aNumero, int aPagina, DateTime aDataInicial, DateTime aDataFinal, int aTipoPeriodo);
              string ConsultarNFSeServicoTomadoPorPrestador(string aCNPJ, string aInscMun, int aPagina, DateTime aDataInicial, DateTime aDataFinal, int aTipoPeriodo);
              string ConsultarNFSeServicoTomadoPorTomador(string aCNPJ, string aInscMun, int aPagina, DateTime aDataInicial, DateTime aDataFinal, int aTipoPeriodo);
              string ConsultarNFSeServicoTomadoPorPeriodo(DateTime aDataInicial, DateTime aDataFinal, int aPagina, int aTipoPeriodo);
              string ConsultarNFSeServicoTomadoPorIntermediario(string aCNPJ, string aInscMun, int aPagina, DateTime aDataInicial, DateTime aDataFinal, int aTipoPeriodo);
              string EnviarEvento(string aInfEvento);
              string ConsultarDPSPorChave(string aChaveDPS);
              string ConsultarNFSePorChave(string aChaveNFSe);
              string ConsultarEvento(string aChave, int aTipoEvento, int aNumSeq);
              string ConsultarDFe(int aNSU);
              string ObterDANFSE(string aChaveNFSe);
              string ConsultarParametros(int aTipoParametroMunicipio, string aCodigoServico, DateTime aCompetencia, string aNumeroBeneficio);
              string ObterInformacoesProvedor();
       }
}




