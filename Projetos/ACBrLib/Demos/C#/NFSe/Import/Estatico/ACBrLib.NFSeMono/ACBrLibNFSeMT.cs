
using System.Text;
using ACBrLib.Core;
using ACBrLib.NFSe;
using ACBrLib.Core.DFe;

namespace ACBrLib.NFSeMono;

public class ACBrLibNFSeMT : ACBrLibBase, IACBrLibNFSe, IDisposable
{
    private IntPtr libHandle;
    private bool disposed = false;

    public ACBrNFSeConfig Config { get; private set; }


    public ACBrLibNFSeMT(string arquivoConfig, string chaveCrypt) : base(arquivoConfig, chaveCrypt)
    {
        libHandle = IntPtr.Zero;

        // Config será inicializada após a inicialização da biblioteca
        Config = new ACBrNFSeConfig(this);

    }

    public override void Inicializar(string arquivoConfig, string chaveCrypt)
    {
        int status = ACBrLibNFSeBridgeMT.NFSE_Inicializar(ref libHandle, ToUTF8(arquivoConfig), ToUTF8(chaveCrypt));
        CheckResult(status);
        // Config será implementado quando necessário
        

    }

    public override void Finalizar()
    {
        int status = ACBrLibNFSeBridgeMT.NFSE_Finalizar(libHandle);

        if (status == 0) libHandle = IntPtr.Zero;
        CheckResult(status);
    }

    public override string Versao()
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);
        int status = ACBrLibNFSeBridgeMT.NFSE_Versao(libHandle, buffer, ref bufferLen);
        CheckResult(status);
        return CheckBuffer(buffer, bufferLen);
    }

    public override string Nome()
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);
        int status = ACBrLibNFSeBridgeMT.NFSE_Nome(libHandle, buffer, ref bufferLen);
        CheckResult(status);
        return CheckBuffer(buffer, bufferLen);
    }


    protected override string GetUltimoRetorno(int iniBufferLen = 0)
    {
        int bufferLen = iniBufferLen < 1 ? BUFFER_LEN : iniBufferLen;
        var buffer = new StringBuilder(bufferLen);
        ACBrLibNFSeBridgeMT.NFSE_UltimoRetorno(libHandle, buffer, ref bufferLen);
        return FromUTF8(buffer);
    }

    public override string OpenSSLInfo()
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        int status = ACBrLibNFSeBridgeMT.NFSE_OpenSSLInfo(libHandle, buffer, ref bufferLen);
        CheckResult(status);
        return CheckBuffer(buffer, bufferLen);
    }


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


    // Métodos de configuração
    public override void ConfigGravar(string eArqConfig = "")
    {
        int status = ACBrLibNFSeBridgeMT.NFSE_ConfigGravar(libHandle, ToUTF8(eArqConfig));
        CheckResult(status);
    }

    public override void ImportarConfig(string eArqConfig)
    {
        int status = ACBrLibNFSeBridgeMT.NFSE_ConfigImportar(libHandle, ToUTF8(eArqConfig));
        CheckResult(status);
    }

    public override string ExportarConfig()
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        int status = ACBrLibNFSeBridgeMT.NFSE_ConfigExportar(libHandle, buffer, ref bufferLen);
        CheckResult(status);
        return CheckBuffer(buffer, bufferLen);
    }

    public override void ConfigLer(string eArqConfig = "")
    {
        int status = ACBrLibNFSeBridgeMT.NFSE_ConfigLer(libHandle, ToUTF8(eArqConfig));
        CheckResult(status);
    }

    public override string ConfigLerValor(string eSessao, string eChave)
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        int status = ACBrLibNFSeBridgeMT.NFSE_ConfigLerValor(libHandle, ToUTF8(eSessao), ToUTF8(eChave), buffer, ref bufferLen);
        CheckResult(status);
        return CheckBuffer(buffer, bufferLen);
    }

    public override void ConfigGravarValor(string eSessao, string eChave, string valor)
    {
        int status = ACBrLibNFSeBridgeMT.NFSE_ConfigGravarValor(libHandle, ToUTF8(eSessao), ToUTF8(eChave), ToUTF8(valor));
        CheckResult(status);
    }

    public override T ConfigLerValor<T>(ACBrSessao eSessao, string eChave)
    {
        var bufferLen = BUFFER_LEN;
        var pValue = new StringBuilder(bufferLen);
        var ret = ACBrLibNFSeBridgeMT.NFSE_ConfigLerValor(libHandle, ToUTF8(eSessao.ToString()), ToUTF8(eChave), pValue, ref bufferLen);
        CheckResult(ret);

        var value = CheckBuffer(pValue, bufferLen);
        return ConvertValue<T>(value);
    }

    public override void ConfigGravarValor(ACBrSessao eSessao, string eChave, object value)
    {
        if (value == null) return;

        var propValue = ConvertValue(value);

        var ret = ACBrLibNFSeBridgeMT.NFSE_ConfigGravarValor(libHandle, ToUTF8(eSessao.ToString()), ToUTF8(eChave), ToUTF8(propValue));
        CheckResult(ret);
    }


    #region nfse
    public void CarregarXML(string eArquivoOuXml)
    {
        int status = ACBrLibNFSeBridgeMT.NFSE_CarregarXML(libHandle, ToUTF8(eArquivoOuXml));
        CheckResult(status);
    }

    public void CarregarLoteXML(string eArquivoOuXml)
    {
        int status = ACBrLibNFSeBridgeMT.NFSE_CarregarLoteXML(libHandle, ToUTF8(eArquivoOuXml));
        CheckResult(status);
    }

    public void CarregarINI(string eArquivoOuIni)
    {
        int status = ACBrLibNFSeBridgeMT.NFSE_CarregarINI(libHandle, ToUTF8(eArquivoOuIni));
        CheckResult(status);
    }

    public string ObterXml(int aIndex)
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        int status = ACBrLibNFSeBridgeMT.NFSE_ObterXml(libHandle, aIndex, buffer, ref bufferLen);
        CheckResult(status);
        return CheckBuffer(buffer, bufferLen);
    }

    public string ObterXmlRps(int aIndex)
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        int status = ACBrLibNFSeBridgeMT.NFSE_ObterXmlRps(libHandle, aIndex, buffer, ref bufferLen);
        CheckResult(status);
        return CheckBuffer(buffer, bufferLen);
    }

    public void GravarXml(int aIndex, string eNomeArquivo = "", string ePathArquivo = "")
    {
        int status = ACBrLibNFSeBridgeMT.NFSE_GravarXml(libHandle, aIndex, ToUTF8(eNomeArquivo), ToUTF8(ePathArquivo));
        CheckResult(status);
    }

    public string ObterIni(int aIndex)
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        int status = ACBrLibNFSeBridgeMT.NFSE_ObterIni(libHandle, aIndex, buffer, ref bufferLen);
        CheckResult(status);
        return CheckBuffer(buffer, bufferLen);
    }

    public void GravarIni(int aIndex, string eNomeArquivo = "", string ePathArquivo = "")
    {
        int status = ACBrLibNFSeBridgeMT.NFSE_GravarIni(libHandle, aIndex, ToUTF8(eNomeArquivo), ToUTF8(ePathArquivo));
        CheckResult(status);
    }

    public void LimparLista()
    {
        int status = ACBrLibNFSeBridgeMT.NFSE_LimparLista(libHandle);
        CheckResult(status);
    }

    public InfoCertificado[] ObterCertificados()
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        int status = ACBrLibNFSeBridgeMT.NFSE_ObterCertificados(libHandle, buffer, ref bufferLen);
        CheckResult(status);
        var certificados = CheckBuffer(buffer, bufferLen).Split(new[] { Environment.NewLine }, StringSplitOptions.RemoveEmptyEntries);
        return certificados.Length == 0 ? new InfoCertificado[0] : certificados.Select(x => new InfoCertificado(x)).ToArray();

    }



    // Métodos principais de NFSe
    public string Emitir(string aLote, int aModoEnvio, bool aImprimir)
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        int status = ACBrLibNFSeBridgeMT.NFSE_Emitir(libHandle, ToUTF8(aLote), aModoEnvio, aImprimir, buffer, ref bufferLen);
        CheckResult(status);
        return CheckBuffer(buffer, bufferLen);
    }

    public string Cancelar(string aInfCancelamento)
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        int status = ACBrLibNFSeBridgeMT.NFSE_Cancelar(libHandle, ToUTF8(aInfCancelamento), buffer, ref bufferLen);
        CheckResult(status);
        return CheckBuffer(buffer, bufferLen);
    }

    public string SubstituirNFSe(string aNumeroNFSe, string aSerieNFSe, string aCodigoCancelamento, string aMotivoCancelamento, string aNumeroLote, string aCodigoVerificacao)
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        int status = ACBrLibNFSeBridgeMT.NFSE_SubstituirNFSe(libHandle, ToUTF8(aNumeroNFSe), ToUTF8(aSerieNFSe), ToUTF8(aCodigoCancelamento), ToUTF8(aMotivoCancelamento), ToUTF8(aNumeroLote), ToUTF8(aCodigoVerificacao), buffer, ref bufferLen);
        CheckResult(status);
        return CheckBuffer(buffer, bufferLen);
    }

    public string LinkNFSe(string aNumeroNFSe, string aCodigoVerificacao, string aChaveAcesso, string aValorServico)
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        int status = ACBrLibNFSeBridgeMT.NFSE_LinkNFSe(libHandle, ToUTF8(aNumeroNFSe), ToUTF8(aCodigoVerificacao), ToUTF8(aChaveAcesso), ToUTF8(aValorServico), buffer, ref bufferLen);
        CheckResult(status);
        return CheckBuffer(buffer, bufferLen);
    }

    public string GerarLote(string aLote, int aQtdMaximaRps, int aModoEnvio)
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        int status = ACBrLibNFSeBridgeMT.NFSE_GerarLote(libHandle, ToUTF8(aLote), aQtdMaximaRps, aModoEnvio, buffer, ref bufferLen);
        CheckResult(status);
        return CheckBuffer(buffer, bufferLen);
    }

    public string GerarToken()
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        int status = ACBrLibNFSeBridgeMT.NFSE_GerarToken(libHandle, buffer, ref bufferLen);
        CheckResult(status);
       return CheckBuffer(buffer, bufferLen);
    }

    // Métodos de consulta
    public string ConsultarSituacao(string aProtocolo, string aNumeroLote)
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        int status = ACBrLibNFSeBridgeMT.NFSE_ConsultarSituacao(libHandle, ToUTF8(aProtocolo), ToUTF8(aNumeroLote), buffer, ref bufferLen);
        CheckResult(status);
        return CheckBuffer(buffer, bufferLen);
    }

    public string ConsultarLoteRps(string aProcotolo, string aNumLote)
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        int status = ACBrLibNFSeBridgeMT.NFSE_ConsultarLoteRps(libHandle, ToUTF8(aProcotolo), ToUTF8(aNumLote), buffer, ref bufferLen);
        CheckResult(status);
        return CheckBuffer(buffer, bufferLen);
    }

    public string ConsultarNFSePorRps(string aNumeroRps, string aSerie, string aTipo, string aCodigoVerificacao)
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        int status = ACBrLibNFSeBridgeMT.NFSE_ConsultarNFSePorRps(libHandle, ToUTF8(aNumeroRps), ToUTF8(aSerie), ToUTF8(aTipo), ToUTF8(aCodigoVerificacao), buffer, ref bufferLen);
        CheckResult(status);
        return CheckBuffer(buffer, bufferLen);
    }

    public string ConsultarNFSePorNumero(string aNumero, int aPagina)
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        int status = ACBrLibNFSeBridgeMT.NFSE_ConsultarNFSePorNumero(libHandle, ToUTF8(aNumero), aPagina, buffer, ref bufferLen);
        CheckResult(status);
        return CheckBuffer(buffer, bufferLen);
    }

    public string ConsultarNFSePorPeriodo(DateTime aDataInicial, DateTime aDataFinal, int aPagina, string aNumeroLote, int aTipoPeriodo)
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        int status = ACBrLibNFSeBridgeMT.NFSE_ConsultarNFSePorPeriodo(libHandle, aDataInicial, aDataFinal, aPagina, ToUTF8(aNumeroLote), aTipoPeriodo, buffer, ref bufferLen);
        CheckResult(status);
        return CheckBuffer(buffer, bufferLen);
    }

    public string ConsultarNFSePorFaixa(string aNumeroInicial, string aNumeroFinal, int aPagina)
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        int status = ACBrLibNFSeBridgeMT.NFSE_ConsultarNFSePorFaixa(libHandle, ToUTF8(aNumeroInicial), ToUTF8(aNumeroFinal), aPagina, buffer, ref bufferLen);
        CheckResult(status);
        return CheckBuffer(buffer, bufferLen);
    }

    public string ConsultarNFSeGenerico(string aInfConsultaNFSe)
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        int status = ACBrLibNFSeBridgeMT.NFSE_ConsultarNFSeGenerico(libHandle, ToUTF8(aInfConsultaNFSe), buffer, ref bufferLen);
        CheckResult(status);
        return CheckBuffer(buffer, bufferLen);
    }

    public string ConsultarLinkNFSe(string aInfConsultaLinkNFSe)
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        int status = ACBrLibNFSeBridgeMT.NFSE_ConsultarLinkNFSe(libHandle, ToUTF8(aInfConsultaLinkNFSe), buffer, ref bufferLen);
        CheckResult(status);
        return CheckBuffer(buffer, bufferLen);
    }

    // Métodos de email e impressão
    public void EnviarEmail(string ePara, string eXmlNFSe, bool aEnviaPDF, string eAssunto, string eCc, string eAnexos, string eMensagem)
    {
        int status = ACBrLibNFSeBridgeMT.NFSE_EnviarEmail(libHandle, ToUTF8(ePara), ToUTF8(eXmlNFSe), aEnviaPDF, ToUTF8(eAssunto), ToUTF8(eCc), ToUTF8(eAnexos), ToUTF8(eMensagem));
        CheckResult(status);
    }

    public void Imprimir(string cImpressora = "", int nNumCopias = 1, string bGerarPDF = "", string bMostrarPreview = "", string cCancelada = "")
    {
        int status = ACBrLibNFSeBridgeMT.NFSE_Imprimir(libHandle, ToUTF8(cImpressora), nNumCopias, bGerarPDF, bMostrarPreview, ToUTF8(cCancelada));
        CheckResult(status);
    }

    public void ImprimirPDF()
    {
        int status = ACBrLibNFSeBridgeMT.NFSE_ImprimirPDF(libHandle);
        CheckResult(status);
    }

    public string SalvarPDF()
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        int status = ACBrLibNFSeBridgeMT.NFSE_SalvarPDF(libHandle, buffer, ref bufferLen);
        CheckResult(status);
        return CheckBuffer(buffer, bufferLen);
    }

    public void ImprimirPDF(Stream stream)
    {
        var pdf = SalvarPDF();
        Base64ToStream(pdf, stream);
    }

    // Métodos de consulta de serviços
    public string ConsultarNFSeServicoPrestadoPorNumero(string aNumero, int aPagina, DateTime aDataInicial, DateTime aDataFinal, int aTipoPeriodo)
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        int status = ACBrLibNFSeBridgeMT.NFSE_ConsultarNFSeServicoPrestadoPorNumero(libHandle, ToUTF8(aNumero), aPagina, aDataInicial, aDataFinal, aTipoPeriodo, buffer, ref bufferLen);
        CheckResult(status);
        return CheckBuffer(buffer, bufferLen);
    }

    public string ConsultarNFSeServicoPrestadoPorPeriodo(DateTime aDataInicial, DateTime aDataFinal, int aPagina, int aTipoPeriodo)
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        int status = ACBrLibNFSeBridgeMT.NFSE_ConsultarNFSeServicoPrestadoPorPeriodo(libHandle, aDataInicial, aDataFinal, aPagina, aTipoPeriodo, buffer, ref bufferLen);
        CheckResult(status);
        return CheckBuffer(buffer, bufferLen);
    }

    public string ConsultarNFSeServicoPrestadoPorTomador(string aCNPJ, string aInscMun, int aPagina, DateTime aDataInicial, DateTime aDataFinal, int aTipoPeriodo)
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        int status = ACBrLibNFSeBridgeMT.NFSE_ConsultarNFSeServicoPrestadoPorTomador(libHandle, ToUTF8(aCNPJ), ToUTF8(aInscMun), aPagina, aDataInicial, aDataFinal, aTipoPeriodo, buffer, ref bufferLen);
        CheckResult(status);
        return CheckBuffer(buffer, bufferLen);
    }

    public string ConsultarNFSeServicoPrestadoPorIntermediario(string aCNPJ, string aInscMun, int aPagina, DateTime aDataInicial, DateTime aDataFinal, int aTipoPeriodo)
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        int status = ACBrLibNFSeBridgeMT.NFSE_ConsultarNFSeServicoPrestadoPorIntermediario(libHandle, ToUTF8(aCNPJ), ToUTF8(aInscMun), aPagina, aDataInicial, aDataFinal, aTipoPeriodo, buffer, ref bufferLen);
        CheckResult(status);
        return CheckBuffer(buffer, bufferLen);
    }

    public string ConsultarNFSeServicoTomadoPorNumero(string aNumero, int aPagina, DateTime aDataInicial, DateTime aDataFinal, int aTipoPeriodo)
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        int status = ACBrLibNFSeBridgeMT.NFSE_ConsultarNFSeServicoTomadoPorNumero(libHandle, ToUTF8(aNumero), aPagina, aDataInicial, aDataFinal, aTipoPeriodo, buffer, ref bufferLen);
        CheckResult(status);
        return CheckBuffer(buffer, bufferLen);
    }

    public string ConsultarNFSeServicoTomadoPorPrestador(string aCNPJ, string aInscMun, int aPagina, DateTime aDataInicial, DateTime aDataFinal, int aTipoPeriodo)
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        int status = ACBrLibNFSeBridgeMT.NFSE_ConsultarNFSeServicoTomadoPorPrestador(libHandle, ToUTF8(aCNPJ), ToUTF8(aInscMun), aPagina, aDataInicial, aDataFinal, aTipoPeriodo, buffer, ref bufferLen);
        CheckResult(status);
        return CheckBuffer(buffer, bufferLen);
    }

    public string ConsultarNFSeServicoTomadoPorTomador(string aCNPJ, string aInscMun, int aPagina, DateTime aDataInicial, DateTime aDataFinal, int aTipoPeriodo)
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        int status = ACBrLibNFSeBridgeMT.NFSE_ConsultarNFSeServicoTomadoPorTomador(libHandle, ToUTF8(aCNPJ), ToUTF8(aInscMun), aPagina, aDataInicial, aDataFinal, aTipoPeriodo, buffer, ref bufferLen);
        CheckResult(status);
        return CheckBuffer(buffer, bufferLen);
    }

    public string ConsultarNFSeServicoTomadoPorPeriodo(DateTime aDataInicial, DateTime aDataFinal, int aPagina, int aTipoPeriodo)
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        int status = ACBrLibNFSeBridgeMT.NFSE_ConsultarNFSeServicoTomadoPorPeriodo(libHandle, aDataInicial, aDataFinal, aPagina, aTipoPeriodo, buffer, ref bufferLen);
        CheckResult(status);
        return CheckBuffer(buffer, bufferLen);
    }

    public string ConsultarNFSeServicoTomadoPorIntermediario(string aCNPJ, string aInscMun, int aPagina, DateTime aDataInicial, DateTime aDataFinal, int aTipoPeriodo)
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        int status = ACBrLibNFSeBridgeMT.NFSE_ConsultarNFSeServicoTomadoPorIntermediario(libHandle, ToUTF8(aCNPJ), ToUTF8(aInscMun), aPagina, aDataInicial, aDataFinal, aTipoPeriodo, buffer, ref bufferLen);
        CheckResult(status);
        return CheckBuffer(buffer, bufferLen);
    }

    // Métodos adicionais
    public string EnviarEvento(string aInfEvento)
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        int status = ACBrLibNFSeBridgeMT.NFSE_EnviarEvento(libHandle, ToUTF8(aInfEvento), buffer, ref bufferLen);
        CheckResult(status);
        return CheckBuffer(buffer, bufferLen);
    }

    public string ConsultarDPSPorChave(string aChaveDPS)
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        int status = ACBrLibNFSeBridgeMT.NFSE_ConsultarDPSPorChave(libHandle, ToUTF8(aChaveDPS), buffer, ref bufferLen);
        CheckResult(status);
        return CheckBuffer(buffer, bufferLen);
    }

    public string ConsultarNFSePorChave(string aChaveNFSe)
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        int status = ACBrLibNFSeBridgeMT.NFSE_ConsultarNFSePorChave(libHandle, ToUTF8(aChaveNFSe), buffer, ref bufferLen);
        CheckResult(status);
        return CheckBuffer(buffer, bufferLen);
    }

    public string ConsultarEvento(string aChave, int aTipoEvento, int aNumSeq)
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        int status = ACBrLibNFSeBridgeMT.NFSE_ConsultarEvento(libHandle, ToUTF8(aChave), aTipoEvento, aNumSeq, buffer, ref bufferLen);
        CheckResult(status);
        return CheckBuffer(buffer, bufferLen);
    }

    public string ConsultarDFe(int aNSU)
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        int status = ACBrLibNFSeBridgeMT.NFSE_ConsultarDFe(libHandle, aNSU, buffer, ref bufferLen);
        CheckResult(status);
        return CheckBuffer(buffer, bufferLen);
    }

    public string ObterDANFSE(string aChaveNFSe)
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        int status = ACBrLibNFSeBridgeMT.NFSE_ObterDANFSE(libHandle, ToUTF8(aChaveNFSe), buffer, ref bufferLen);
        CheckResult(status);
        return CheckBuffer(buffer, bufferLen);
    }

    public string ConsultarParametros(int aTipoParametroMunicipio, string aCodigoServico, DateTime aCompetencia, string aNumeroBeneficio)
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        int status = ACBrLibNFSeBridgeMT.NFSE_ConsultarParametros(libHandle, aTipoParametroMunicipio, ToUTF8(aCodigoServico), aCompetencia, ToUTF8(aNumeroBeneficio), buffer, ref bufferLen);
        CheckResult(status);
        return CheckBuffer(buffer, bufferLen);
    }

    public string ObterInformacoesProvedor()
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        int status = ACBrLibNFSeBridgeMT.NFSE_ObterInformacoesProvedor(libHandle, buffer, ref bufferLen);
        CheckResult(status);
        return CheckBuffer(buffer, bufferLen);
    }



    public void Imprimir(string cImpressora = "", int nNumCopias = 1, bool? bGerarPDF = null, bool? bMostrarPreview = null, string cCancelada = "")
    {
        throw new NotImplementedException();
    }

    #endregion




}