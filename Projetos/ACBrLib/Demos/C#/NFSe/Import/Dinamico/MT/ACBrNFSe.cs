using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using ACBrLib.Core;
using ACBrLib.Core.DFe;
using ACBrLib.NFSe;
using System.IO;
using static ACBrLib.NFSe.ACBrNFSe;

namespace ACBrLib.NFSe
{
    /// <inheritdoc />
    public class ACBrNFSe : ACBrLibBase, IACBrLibNFSe, IDisposable
    {

        private readonly ACBrNFSeHandle acbrNFseBridge;
        private IntPtr libHandle = IntPtr.Zero;

        private bool disposed = false;

        #region Constructors

        /// <summary>
        /// Construtor da classe ACBrNFSe, responsável por inicializar a biblioteca e configurar o caminho do arquivo de configuração e a chave de criptografia.
        /// </summary>
        /// <param name="eArqConfig"></param>
        /// <param name="eChaveCrypt"></param>
        public ACBrNFSe(string eArqConfig = "", string eChaveCrypt = "") : base(eArqConfig, eChaveCrypt)
        {
            acbrNFseBridge = ACBrNFSeHandle.Instance;
            Inicializar(eArqConfig, eChaveCrypt);
            Config = new ACBrNFSeConfig(this);
        }

        /// <inheritdoc />
        public override void Inicializar(string eArqConfig, string eChaveCrypt)
        {
            var inicializar = acbrNFseBridge.GetMethod<ACBrNFSeHandle.NFSE_Inicializar>();
            var ret = acbrNFseBridge.ExecuteMethod(() => inicializar(ref libHandle, ToUTF8(eArqConfig), ToUTF8(eChaveCrypt)));
            CheckResult(ret);

        }

        #endregion Constructors

        #region Properties

        public ACBrNFSeConfig Config { get; }

        #endregion Properties

        #region Metodos

        #region Ini
        /// <inheritdoc />
        public override void ConfigGravar(string eArqConfig = "")
        {
            var gravarIni = acbrNFseBridge.GetMethod<ACBrNFSeHandle.NFSE_ConfigGravar>();
            var ret = acbrNFseBridge.ExecuteMethod(() => gravarIni(libHandle, ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        /// <inheritdoc />
        public override void ImportarConfig(string eArqConfig)
        {
            var lerIni = acbrNFseBridge.GetMethod<ACBrNFSeHandle.NFSE_ConfigImportar>();
            var ret = acbrNFseBridge.ExecuteMethod(() => lerIni(libHandle, ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        /// <inheritdoc />
        public override string ExportarConfig()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrNFseBridge.GetMethod<ACBrNFSeHandle.NFSE_ConfigExportar>();
            var ret = acbrNFseBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public override void ConfigLer(string eArqConfig = "")
        {
            var lerIni = acbrNFseBridge.GetMethod<ACBrNFSeHandle.NFSE_ConfigLer>();
            var ret = acbrNFseBridge.ExecuteMethod(() => lerIni(libHandle, ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        #endregion Ini

        #region Diversos

        public void CarregarXML(string eArquivoOuXml)
        {
            var method = acbrNFseBridge.GetMethod<ACBrNFSeHandle.NFSE_CarregarXML>();
            var ret = acbrNFseBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eArquivoOuXml)));

            CheckResult(ret);
        }

        public void CarregarLoteXML(string eArquivoOuXml)
        {
            var method = acbrNFseBridge.GetMethod<ACBrNFSeHandle.NFSE_CarregarLoteXML>();
            var ret = acbrNFseBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eArquivoOuXml)));

            CheckResult(ret);
        }

        public void CarregarINI(string eArquivoOuIni)
        {
            var method = acbrNFseBridge.GetMethod<ACBrNFSeHandle.NFSE_CarregarINI>();
            var ret = acbrNFseBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eArquivoOuIni)));

            CheckResult(ret);
        }

        public string ObterXml(int aIndex)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrNFseBridge.GetMethod<ACBrNFSeHandle.NFSE_ObterXml>();
            var ret = acbrNFseBridge.ExecuteMethod(() => method(libHandle, aIndex, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        public string ObterXmlRps(int aIndex)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrNFseBridge.GetMethod<ACBrNFSeHandle.NFSE_ObterXmlRps>();
            var ret = acbrNFseBridge.ExecuteMethod(() => method(libHandle, aIndex, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        public void GravarXml(int aIndex, string eNomeArquivo = "", string ePathArquivo = "")
        {
            var method = acbrNFseBridge.GetMethod<ACBrNFSeHandle.NFSE_GravarXml>();
            var ret = acbrNFseBridge.ExecuteMethod(() => method(libHandle, aIndex, ToUTF8(eNomeArquivo), ToUTF8(ePathArquivo)));

            CheckResult(ret);
        }

        public string ObterIni(int aIndex)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrNFseBridge.GetMethod<ACBrNFSeHandle.NFSE_ObterIni>();
            var ret = acbrNFseBridge.ExecuteMethod(() => method(libHandle, aIndex, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        public void GravarIni(int aIndex, string eNomeArquivo = "", string ePathArquivo = "")
        {
            var method = acbrNFseBridge.GetMethod<ACBrNFSeHandle.NFSE_GravarIni>();
            var ret = acbrNFseBridge.ExecuteMethod(() => method(libHandle, aIndex, ToUTF8(eNomeArquivo), ToUTF8(ePathArquivo)));

            CheckResult(ret);
        }

        public void LimparLista()
        {
            var method = acbrNFseBridge.GetMethod<ACBrNFSeHandle.NFSE_LimparLista>();
            var ret = acbrNFseBridge.ExecuteMethod(() => method(libHandle));

            CheckResult(ret);
        }

        public InfoCertificado[] ObterCertificados()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrNFseBridge.GetMethod<ACBrNFSeHandle.NFSE_ObterCertificados>();
            var ret = acbrNFseBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            var certificados = CheckBuffer(buffer, bufferLen).Split(new[] { Environment.NewLine }, StringSplitOptions.RemoveEmptyEntries);
            return certificados.Length == 0 ? new InfoCertificado[0] : certificados.Select(x => new InfoCertificado(x)).ToArray();
        }
        public override string OpenSSLInfo()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrNFseBridge.GetMethod<ACBrNFSeHandle.NFSE_OpenSSLInfo>();
            var ret = acbrNFseBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        public string Emitir(string aLote, int aModoEnvio, bool aImprimir)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrNFseBridge.GetMethod<ACBrNFSeHandle.NFSE_Emitir>();
            var ret = acbrNFseBridge.ExecuteMethod(() => method(libHandle, ToUTF8(aLote), aModoEnvio, aImprimir, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        public string Cancelar(string aInfCancelamento)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrNFseBridge.GetMethod<ACBrNFSeHandle.NFSE_Cancelar>();
            var ret = acbrNFseBridge.ExecuteMethod(() => method(libHandle, ToUTF8(aInfCancelamento), buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        public string SubstituirNFSe(string aNumeroNFSe, string aSerieNFSe, string aCodigoCancelamento, string aMotivoCancelamento, string aNumeroLote, string aCodigoVerificacao)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrNFseBridge.GetMethod<ACBrNFSeHandle.NFSE_SubstituirNFSe>();
            var ret = acbrNFseBridge.ExecuteMethod(() => method(libHandle, ToUTF8(aNumeroNFSe), ToUTF8(aSerieNFSe), ToUTF8(aCodigoCancelamento), ToUTF8(aMotivoCancelamento), ToUTF8(aNumeroLote), ToUTF8(aCodigoVerificacao), buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        public string LinkNFSe(string aNumeroNFSe, string aCodigoVerificacao, string aChaveAcesso, string aValorServico)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrNFseBridge.GetMethod<ACBrNFSeHandle.NFSE_LinkNFSe>();
            var ret = acbrNFseBridge.ExecuteMethod(() => method(libHandle, ToUTF8(aNumeroNFSe), ToUTF8(aCodigoVerificacao), ToUTF8(aChaveAcesso), ToUTF8(aValorServico), buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        public string GerarLote(string aLote, int aQtdMaximaRps, int aModoEnvio)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrNFseBridge.GetMethod<ACBrNFSeHandle.NFSE_GerarLote>();
            var ret = acbrNFseBridge.ExecuteMethod(() => method(libHandle, ToUTF8(aLote), aQtdMaximaRps, aModoEnvio, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        public string GerarToken()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrNFseBridge.GetMethod<ACBrNFSeHandle.NFSE_GerarToken>();
            var ret = acbrNFseBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        public string ConsultarSituacao(string aProtocolo, string aNumeroLote)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrNFseBridge.GetMethod<ACBrNFSeHandle.NFSE_ConsultarSituacao>();
            var ret = acbrNFseBridge.ExecuteMethod(() => method(libHandle, ToUTF8(aProtocolo), ToUTF8(aNumeroLote), buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        public string ConsultarLoteRps(string aProcotolo, string aNumLote)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrNFseBridge.GetMethod<ACBrNFSeHandle.NFSE_ConsultarLoteRps>();
            var ret = acbrNFseBridge.ExecuteMethod(() => method(libHandle, ToUTF8(aProcotolo), ToUTF8(aNumLote), buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        public string ConsultarNFSePorRps(string aNumeroRps, string aSerie, string aTipo, string aCodigoVerificacao)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrNFseBridge.GetMethod<ACBrNFSeHandle.NFSE_ConsultarNFSePorRps>();
            var ret = acbrNFseBridge.ExecuteMethod(() => method(libHandle, ToUTF8(aNumeroRps), ToUTF8(aSerie), ToUTF8(aTipo), ToUTF8(aCodigoVerificacao), buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        public string ConsultarNFSePorNumero(string aNumero, int aPagina)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrNFseBridge.GetMethod<ACBrNFSeHandle.NFSE_ConsultarNFSePorNumero>();
            var ret = acbrNFseBridge.ExecuteMethod(() => method(libHandle, ToUTF8(aNumero), aPagina, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        public string ConsultarNFSePorPeriodo(DateTime aDataInicial, DateTime aDataFinal, int aPagina, string aNumeroLote, int aTipoPeriodo)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrNFseBridge.GetMethod<ACBrNFSeHandle.NFSE_ConsultarNFSePorPeriodo>();
            var ret = acbrNFseBridge.ExecuteMethod(() => method(libHandle, aDataInicial, aDataFinal, aPagina, ToUTF8(aNumeroLote), aTipoPeriodo, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        public string ConsultarNFSePorFaixa(string aNumeroInicial, string aNumeroFinal, int aPagina)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrNFseBridge.GetMethod<ACBrNFSeHandle.NFSE_ConsultarNFSePorFaixa>();
            var ret = acbrNFseBridge.ExecuteMethod(() => method(libHandle, ToUTF8(aNumeroInicial), ToUTF8(aNumeroFinal), aPagina, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        public string ConsultarNFSeGenerico(string aInfConsultaNFSe)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrNFseBridge.GetMethod<ACBrNFSeHandle.NFSE_ConsultarNFSeGenerico>();
            var ret = acbrNFseBridge.ExecuteMethod(() => method(libHandle, ToUTF8(aInfConsultaNFSe), buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        public string ConsultarLinkNFSe(string aInfConsultaLinkNFSe)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrNFseBridge.GetMethod<ACBrNFSeHandle.NFSE_ConsultarLinkNFSe>();
            var ret = acbrNFseBridge.ExecuteMethod(() => method(libHandle, ToUTF8(aInfConsultaLinkNFSe), buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        public void EnviarEmail(string ePara, string eXmlNFSe, bool aEnviaPDF, string eAssunto, string eCc, string eAnexos, string eMensagem)
        {
            var method = acbrNFseBridge.GetMethod<ACBrNFSeHandle.NFSE_EnviarEmail>();
            var ret = acbrNFseBridge.ExecuteMethod(() => method(libHandle, ToUTF8(ePara), ToUTF8(eXmlNFSe), aEnviaPDF, ToUTF8(eAssunto), ToUTF8(eCc), ToUTF8(eAnexos), ToUTF8(eMensagem)));

            CheckResult(ret);
        }

        public void Imprimir(string cImpressora = "", int nNumCopias = 1, bool? bGerarPDF = null, bool? bMostrarPreview = null, string cCancelada = "")
        {
            var gerarPDF = bGerarPDF.HasValue ? $"{Convert.ToInt32(bMostrarPreview.Value)}" : string.Empty;
            var mostrarPreview = bMostrarPreview.HasValue ? $"{Convert.ToInt32(bMostrarPreview.Value)}" : string.Empty;

            var method = acbrNFseBridge.GetMethod<ACBrNFSeHandle.NFSE_Imprimir>();
            var ret = acbrNFseBridge.ExecuteMethod(() => method(libHandle, ToUTF8(cImpressora), nNumCopias, gerarPDF, mostrarPreview, ToUTF8(cCancelada)));

            CheckResult(ret);
        }

        public void ImprimirPDF()
        {
            var method = acbrNFseBridge.GetMethod<ACBrNFSeHandle.NFSE_ImprimirPDF>();
            var ret = acbrNFseBridge.ExecuteMethod(() => method(libHandle));

            CheckResult(ret);
        }

        public void ImprimirPDF(Stream aStream)
        {
            if (aStream == null) throw new ArgumentNullException(nameof(aStream));

            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrNFseBridge.GetMethod<ACBrNFSeHandle.NFSE_SalvarPDF>();
            var ret = acbrNFseBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            var pdf = CheckBuffer(buffer, bufferLen);
            Base64ToStream(pdf, aStream);
        }

        public string ConsultarNFSeServicoPrestadoPorNumero(string aNumero, int aPagina, DateTime aDataInicial, DateTime aDataFinal, int aTipoPeriodo)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrNFseBridge.GetMethod<ACBrNFSeHandle.NFSE_ConsultarNFSeServicoPrestadoPorNumero>();
            var ret = acbrNFseBridge.ExecuteMethod(() => method(libHandle, ToUTF8(aNumero), aPagina, aDataInicial, aDataFinal, aTipoPeriodo, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        public string ConsultarNFSeServicoPrestadoPorPeriodo(DateTime aDataInicial, DateTime aDataFinal, int aPagina, int aTipoPeriodo)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrNFseBridge.GetMethod<ACBrNFSeHandle.NFSE_ConsultarNFSeServicoPrestadoPorPeriodo>();
            var ret = acbrNFseBridge.ExecuteMethod(() => method(libHandle, aDataInicial, aDataFinal, aPagina, aTipoPeriodo, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        public string ConsultarNFSeServicoPrestadoPorTomador(string aCNPJ, string aInscMun, int aPagina, DateTime aDataInicial, DateTime aDataFinal, int aTipoPeriodo)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrNFseBridge.GetMethod<ACBrNFSeHandle.NFSE_ConsultarNFSeServicoPrestadoPorTomador>();
            var ret = acbrNFseBridge.ExecuteMethod(() => method(libHandle, ToUTF8(aCNPJ), ToUTF8(aInscMun), aPagina, aDataInicial, aDataFinal, aTipoPeriodo, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        public string ConsultarNFSeServicoPrestadoPorIntermediario(string aCNPJ, string aInscMun, int aPagina, DateTime aDataInicial, DateTime aDataFinal, int aTipoPeriodo)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrNFseBridge.GetMethod<ACBrNFSeHandle.NFSE_ConsultarNFSeServicoPrestadoPorIntermediario>();
            var ret = acbrNFseBridge.ExecuteMethod(() => method(libHandle, ToUTF8(aCNPJ), ToUTF8(aInscMun), aPagina, aDataInicial, aDataFinal, aTipoPeriodo, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        public string ConsultarNFSeServicoTomadoPorNumero(string aNumero, int aPagina, DateTime aDataInicial, DateTime aDataFinal, int aTipoPeriodo)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrNFseBridge.GetMethod<ACBrNFSeHandle.NFSE_ConsultarNFSeServicoTomadoPorNumero>();
            var ret = acbrNFseBridge.ExecuteMethod(() => method(libHandle, ToUTF8(aNumero), aPagina, aDataInicial, aDataFinal, aTipoPeriodo, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        public string ConsultarNFSeServicoTomadoPorPrestador(string aCNPJ, string aInscMun, int aPagina, DateTime aDataInicial, DateTime aDataFinal, int aTipoPeriodo)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrNFseBridge.GetMethod<ACBrNFSeHandle.NFSE_ConsultarNFSeServicoTomadoPorPrestador>();
            var ret = acbrNFseBridge.ExecuteMethod(() => method(libHandle, ToUTF8(aCNPJ), ToUTF8(aInscMun), aPagina, aDataInicial, aDataFinal, aTipoPeriodo, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        public string ConsultarNFSeServicoTomadoPorTomador(string aCNPJ, string aInscMun, int aPagina, DateTime aDataInicial, DateTime aDataFinal, int aTipoPeriodo)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrNFseBridge.GetMethod<ACBrNFSeHandle.NFSE_ConsultarNFSeServicoTomadoPorTomador>();
            var ret = acbrNFseBridge.ExecuteMethod(() => method(libHandle, ToUTF8(aCNPJ), ToUTF8(aInscMun), aPagina, aDataInicial, aDataFinal, aTipoPeriodo, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        public string ConsultarNFSeServicoTomadoPorPeriodo(DateTime aDataInicial, DateTime aDataFinal, int aPagina, int aTipoPeriodo)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrNFseBridge.GetMethod<ACBrNFSeHandle.NFSE_ConsultarNFSeServicoTomadoPorPeriodo>();
            var ret = acbrNFseBridge.ExecuteMethod(() => method(libHandle, aDataInicial, aDataFinal, aPagina, aTipoPeriodo, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        public string ConsultarNFSeServicoTomadoPorIntermediario(string aCNPJ, string aInscMun, int aPagina, DateTime aDataInicial, DateTime aDataFinal, int aTipoPeriodo)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrNFseBridge.GetMethod<ACBrNFSeHandle.NFSE_ConsultarNFSeServicoTomadoPorIntermediario>();
            var ret = acbrNFseBridge.ExecuteMethod(() => method(libHandle, ToUTF8(aCNPJ), ToUTF8(aInscMun), aPagina, aDataInicial, aDataFinal, aTipoPeriodo, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        public string EnviarEvento(string aInfEvento)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrNFseBridge.GetMethod<ACBrNFSeHandle.NFSE_EnviarEvento>();
            var ret = acbrNFseBridge.ExecuteMethod(() => method(libHandle, ToUTF8(aInfEvento), buffer, ref bufferLen));

            return CheckBuffer(buffer, bufferLen);
        }

        public string ConsultarDPSPorChave(string aChaveDPS)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrNFseBridge.GetMethod<ACBrNFSeHandle.NFSE_ConsultarDPSPorChave>();
            var ret = acbrNFseBridge.ExecuteMethod(() => method(libHandle, ToUTF8(aChaveDPS), buffer, ref bufferLen));

            return CheckBuffer(buffer, bufferLen);
        }

        public string ConsultarNFSePorChave(string aChaveNFSe)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrNFseBridge.GetMethod<ACBrNFSeHandle.NFSE_ConsultarNFSePorChave>();
            var ret = acbrNFseBridge.ExecuteMethod(() => method(libHandle, ToUTF8(aChaveNFSe), buffer, ref bufferLen));

            return CheckBuffer(buffer, bufferLen);
        }

        public string ConsultarEvento(string aChave, int aTipoEvento, int aNumSeq)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrNFseBridge.GetMethod<ACBrNFSeHandle.NFSE_ConsultarEvento>();
            var ret = acbrNFseBridge.ExecuteMethod(() => method(libHandle, ToUTF8(aChave), aTipoEvento, aNumSeq, buffer, ref bufferLen));

            return CheckBuffer(buffer, bufferLen);
        }

        public string ConsultarDFe(int aNSU)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrNFseBridge.GetMethod<ACBrNFSeHandle.NFSE_ConsultarDFe>();
            var ret = acbrNFseBridge.ExecuteMethod(() => method(libHandle, aNSU, buffer, ref bufferLen));

            return CheckBuffer(buffer, bufferLen);
        }

        public string ObterDANFSE(string aChaveNFSe)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrNFseBridge.GetMethod<ACBrNFSeHandle.NFSE_ObterDANFSE>();
            var ret = acbrNFseBridge.ExecuteMethod(() => method(libHandle, ToUTF8(aChaveNFSe), buffer, ref bufferLen));

            return CheckBuffer(buffer, bufferLen);
        }

        public string ConsultarParametros(int aTipoParametroMunicipio, string aCodigoServico, DateTime aCompetencia, string aNumeroBeneficio)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrNFseBridge.GetMethod<ACBrNFSeHandle.NFSE_ConsultarParametros>();
            var ret = acbrNFseBridge.ExecuteMethod(() => method(libHandle, aTipoParametroMunicipio, ToUTF8(aCodigoServico), aCompetencia, ToUTF8(aNumeroBeneficio), buffer, ref bufferLen));

            return CheckBuffer(buffer, bufferLen);
        }

        public string ObterInformacoesProvedor()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrNFseBridge.GetMethod<ACBrNFSeHandle.NFSE_ObterInformacoesProvedor>();
            var ret = acbrNFseBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            return CheckBuffer(buffer, bufferLen);
        }

        #endregion Diversos

        #region Private Methods

        public override void Finalizar()
        {
            var finalizarLib = acbrNFseBridge.GetMethod<ACBrNFSeHandle.NFSE_Finalizar>();
            var codRet = acbrNFseBridge.ExecuteMethod(() => finalizarLib(libHandle));
            CheckResult(codRet);
            libHandle = IntPtr.Zero;
        }

        protected override string GetUltimoRetorno(int iniBufferLen = 0)
        {
            var bufferLen = iniBufferLen < 1 ? BUFFER_LEN : iniBufferLen;
            var buffer = new StringBuilder(bufferLen);
            var ultimoRetorno = acbrNFseBridge.GetMethod<ACBrNFSeHandle.NFSE_UltimoRetorno>();

            if (iniBufferLen < 1)
            {
                acbrNFseBridge.ExecuteMethod(() => ultimoRetorno(libHandle, buffer, ref bufferLen));
                if (bufferLen <= BUFFER_LEN) return FromUTF8(buffer);

                buffer.Capacity = bufferLen;
            }

            acbrNFseBridge.ExecuteMethod(() => ultimoRetorno(libHandle, buffer, ref bufferLen));
            return FromUTF8(buffer);
        }
        #endregion Private Methods

        /// <summary>
        /// Faz a liberação dos recursos utilizados pela classe ACBrNFSe, garantindo que a biblioteca seja finalizada corretamente e evitando vazamentos de memória.
        /// </summary>
        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        protected virtual void Dispose(bool disposing)
        {
            if (!disposed)
            {
                if (disposing)
                {
                    Finalizar();
                }
                
                disposed = true;
            }
        }

        /// <inheritdoc />
        public override string ConfigLerValor(string eSessao, string eChave)
        {
            var method = acbrNFseBridge.GetMethod<ACBrNFSeHandle.NFSE_ConfigLerValor>();
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);
            var ret = acbrNFseBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eSessao), ToUTF8(eChave), buffer, ref bufferLen));
            CheckResult(ret);
            return CheckBuffer(buffer, bufferLen);
        }

        public override void ConfigGravarValor(string eSessao, string eChave, string eValor)
        {
            var method = acbrNFseBridge.GetMethod<ACBrNFSeHandle.NFSE_ConfigGravarValor>();
            var ret = acbrNFseBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eSessao), ToUTF8(eChave), ToUTF8(eValor)));
            CheckResult(ret);
        }

        /// <inheritdoc />
        public override string Versao()
        {
            var method = acbrNFseBridge.GetMethod<ACBrNFSeHandle.NFSE_Versao>();
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);
            var ret = acbrNFseBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));
            CheckResult(ret);
            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public override string Nome()
        {
            var method = acbrNFseBridge.GetMethod<ACBrNFSeHandle.NFSE_Nome>();
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);
            var ret = acbrNFseBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));
            CheckResult(ret);
            return CheckBuffer(buffer, bufferLen);
        }

        #endregion Metodos
    }
}