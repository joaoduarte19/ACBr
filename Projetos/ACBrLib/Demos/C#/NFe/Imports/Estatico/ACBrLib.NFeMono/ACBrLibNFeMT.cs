using System.Text;
using ACBrLib.Core;
using ACBrLib.Core.DFe;
using ACBrLib.Core.NFe;
using ACBrLib.NFe;

namespace ACBrLib.NFeMono;

public class ACBrLibNFeMT : ACBrLibBase, IACBrLibNFe
{
    private IntPtr libHandle;
    private bool disposed = false;

    public ACBrNFeConfig Config { get; }

    public ACBrLibNFeMT(string arquivoConfig, string chaveCrypt) : base(arquivoConfig, chaveCrypt)
    {
        libHandle = IntPtr.Zero;

        // Config será inicializada após a inicialização da biblioteca
        Config = new ACBrNFeConfig(this);

    }

    public override void Inicializar(String arquivoConfig = "", String chaveCrypt = "")
    {
        int status = ACBrLibNFeBridgeMT.NFE_Inicializar(ref libHandle, ToUTF8(arquivoConfig), ToUTF8(chaveCrypt));
        CheckResult(status);
        // Config será implementado quando necessário

    }

    public override void Finalizar()
    {
        int status = ACBrLibNFeBridgeMT.NFE_Finalizar(libHandle);

        if (status == 0) libHandle = IntPtr.Zero;
        CheckResult(status);
    }

    public override string Versao()
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);
        int status = ACBrLibNFeBridgeMT.NFE_Versao(libHandle, buffer, ref bufferLen);
        CheckResult(status);
        return CheckBuffer(buffer, bufferLen);
    }

    public override string Nome()
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);
        int status = ACBrLibNFeBridgeMT.NFE_Nome(libHandle, buffer, ref bufferLen);
        CheckResult(status);
        return CheckBuffer(buffer, bufferLen);
    }


    protected override string GetUltimoRetorno(int iniBufferLen = 0)
    {
        int bufferLen = iniBufferLen < 1 ? BUFFER_LEN : iniBufferLen;
        var buffer = new StringBuilder(bufferLen);
        ACBrLibNFeBridgeMT.NFE_UltimoRetorno(libHandle, buffer, ref bufferLen);
        return FromUTF8(buffer);
    }

    public override string OpenSSLInfo()
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        int status = ACBrLibNFeBridgeMT.NFE_OpenSSLInfo(libHandle, buffer, ref bufferLen);
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
        int status = ACBrLibNFeBridgeMT.NFE_ConfigGravar(libHandle, ToUTF8(eArqConfig));
        CheckResult(status);
    }

    public override void ImportarConfig(string eArqConfig)
    {
        int status = ACBrLibNFeBridgeMT.NFE_ConfigImportar(libHandle, ToUTF8(eArqConfig));
        CheckResult(status);
    }

    public override string ExportarConfig()
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        int status = ACBrLibNFeBridgeMT.NFE_ConfigExportar(libHandle, buffer, ref bufferLen);
        CheckResult(status);
        return CheckBuffer(buffer, bufferLen);
    }

    public override void ConfigLer(string eArqConfig = "")
    {
        int status = ACBrLibNFeBridgeMT.NFE_ConfigLer(libHandle, ToUTF8(eArqConfig));
        CheckResult(status);
    }

    public override string ConfigLerValor(string eSessao, string eChave)
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        int status = ACBrLibNFeBridgeMT.NFE_ConfigLerValor(libHandle, ToUTF8(eSessao), ToUTF8(eChave), buffer, ref bufferLen);
        CheckResult(status);
        return CheckBuffer(buffer, bufferLen);
    }

    public override void ConfigGravarValor(string eSessao, string eChave, string valor)
    {
        int status = ACBrLibNFeBridgeMT.NFE_ConfigGravarValor(libHandle, ToUTF8(eSessao), ToUTF8(eChave), ToUTF8(valor));
        CheckResult(status);
    }

    public override T ConfigLerValor<T>(ACBrSessao eSessao, string eChave)
    {
        var bufferLen = BUFFER_LEN;
        var pValue = new StringBuilder(bufferLen);
        var ret = ACBrLibNFeBridgeMT.NFE_ConfigLerValor(libHandle, ToUTF8(eSessao.ToString()), ToUTF8(eChave), pValue, ref bufferLen);
        CheckResult(ret);

        var value = CheckBuffer(pValue, bufferLen);
        return ConvertValue<T>(value);
    }

    public override void ConfigGravarValor(ACBrSessao eSessao, string eChave, object value)
    {
        if (value == null) return;

        var propValue = ConvertValue(value);

        var ret = ACBrLibNFeBridgeMT.NFE_ConfigGravarValor(libHandle, ToUTF8(eSessao.ToString()), ToUTF8(eChave), ToUTF8(propValue));
        CheckResult(ret);
    }

    /// <summary>
    /// Adiciona uma nota fiscal na lista.
    /// </summary>
    /// <param name="nfe"></param>
    public void CarregarNota(NotaFiscal nfe) => CarregarINI(nfe.ToString());

    /// <summary>
    /// Retornar os dados da NFe no index informado.
    /// </summary>
    /// <param name="aIndex"></param>
    /// <returns></returns>
    public NotaFiscal ObterNFe(int aIndex) => NotaFiscal.Load(ObterIni(aIndex));

    public void CarregarEvento(EventoNFeBase evento) => CarregarEventoINI(evento.ToString());

    public void CarregarXML(string eArquivoOuXml)
    {
        var ret = ACBrLibNFeBridgeMT.NFE_CarregarXML(libHandle, ToUTF8(eArquivoOuXml));

        CheckResult(ret);
    }

    public void CarregarINI(string eArquivoOuIni)
    {
        var ret = ACBrLibNFeBridgeMT.NFE_CarregarINI(libHandle, ToUTF8(eArquivoOuIni));

        CheckResult(ret);
    }

    public string ObterXml(int aIndex)
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        var ret = ACBrLibNFeBridgeMT.NFE_ObterXml(libHandle, aIndex, buffer, ref bufferLen);

        CheckResult(ret);

        return CheckBuffer(buffer, bufferLen);
    }

    public void GravarXml(int aIndex, string eNomeArquivo = "", string ePathArquivo = "")
    {
        var ret = ACBrLibNFeBridgeMT.NFE_GravarXml(libHandle, aIndex, ToUTF8(eNomeArquivo), ToUTF8(ePathArquivo));

        CheckResult(ret);
    }

    public string ObterIni(int aIndex)
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        var ret = ACBrLibNFeBridgeMT.NFE_ObterIni(libHandle, aIndex, buffer, ref bufferLen);

        CheckResult(ret);

        return CheckBuffer(buffer, bufferLen);
    }

    public void GravarIni(int aIndex, string eNomeArquivo = "", string ePathArquivo = "")
    {
        var ret = ACBrLibNFeBridgeMT.NFE_GravarIni(libHandle, aIndex, ToUTF8(eNomeArquivo), ToUTF8(ePathArquivo));
        CheckResult(ret);
    }

    public void CarregarEventoXML(string eArquivoOuXml)
    {

        var ret = ACBrLibNFeBridgeMT.NFE_CarregarEventoXML(libHandle, ToUTF8(eArquivoOuXml));

        CheckResult(ret);
    }

    public void CarregarEventoINI(string eArquivoOuIni)
    {
        var ret = ACBrLibNFeBridgeMT.NFE_CarregarEventoINI(libHandle, ToUTF8(eArquivoOuIni));

        CheckResult(ret);
    }

    public void LimparLista()
    {
        var ret = ACBrLibNFeBridgeMT.NFE_LimparLista(libHandle);

        CheckResult(ret);
    }

    public void LimparListaEventos()
    {
        var ret = ACBrLibNFeBridgeMT.NFE_LimparListaEventos(libHandle);
        CheckResult(ret);
    }

    public void Assinar()
    {
        var ret = ACBrLibNFeBridgeMT.NFE_Assinar(libHandle);

        CheckResult(ret);
    }

    public void Validar()
    {
        var ret = ACBrLibNFeBridgeMT.NFE_Validar(libHandle);

        CheckResult(ret);
    }

    public string ValidarRegrasdeNegocios()
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        var ret = ACBrLibNFeBridgeMT.NFE_ValidarRegrasdeNegocios(libHandle, buffer, ref bufferLen);

        CheckResult(ret);

        return CheckBuffer(buffer, bufferLen);
    }

    public string VerificarAssinatura()
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        var ret = ACBrLibNFeBridgeMT.NFE_VerificarAssinatura(libHandle, buffer, ref bufferLen);

        CheckResult(ret);

        return CheckBuffer(buffer, bufferLen);
    }

    public string GerarChave(int aCodigoUf, int aCodigoNumerico, int aModelo, int aSerie, int aNumero,
        int aTpEmi, DateTime aEmissao, string acpfcnpj)
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        var ret = ACBrLibNFeBridgeMT.NFE_GerarChave(libHandle, aCodigoUf, aCodigoNumerico, aModelo, aSerie, aNumero,
                                             aTpEmi, aEmissao.Date.ToString("dd/MM/yyyy"), ToUTF8(acpfcnpj),
                                             buffer, ref bufferLen);

        CheckResult(ret);

        return CheckBuffer(buffer, bufferLen);
    }

    public InfoCertificado[] ObterCertificados()
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        var ret = ACBrLibNFeBridgeMT.NFE_ObterCertificados(libHandle, buffer, ref bufferLen);

        CheckResult(ret);

        var certificados = CheckBuffer(buffer, bufferLen).Split(new[] { Environment.NewLine }, StringSplitOptions.RemoveEmptyEntries);
        return certificados.Length == 0 ? new InfoCertificado[0] : certificados.Select(x => new InfoCertificado(x)).ToArray();
    }

    public string GetPath(TipoPathNFe tipo)
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        var ret = ACBrLibNFeBridgeMT.NFE_GetPath(libHandle, (int)tipo, buffer, ref bufferLen);

        return CheckBuffer(buffer, bufferLen);
    }

    public string GetPathEvento(string evento)
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        var ret = ACBrLibNFeBridgeMT.NFE_GetPathEvento(libHandle, ToUTF8(evento), buffer, ref bufferLen);

        return CheckBuffer(buffer, bufferLen);
    }

    public StatusServicoResposta StatusServico()
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        var ret = ACBrLibNFeBridgeMT.NFE_StatusServico(libHandle, buffer, ref bufferLen);

        CheckResult(ret);

        return StatusServicoResposta.LerResposta(CheckBuffer(buffer, bufferLen));
    }

    public ConsultaNFeResposta Consultar(string eChaveOuNFe, bool AExtrairEventos = false)
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        var ret = ACBrLibNFeBridgeMT.NFE_Consultar(libHandle, ToUTF8(eChaveOuNFe), AExtrairEventos, buffer, ref bufferLen);

        CheckResult(ret);

        return ConsultaNFeResposta.LerResposta(CheckBuffer(buffer, bufferLen));
    }

    public ConsultaCadastroResposta ConsultaCadastro(string cUF, string nDocumento, bool nIE)
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        var ret = ACBrLibNFeBridgeMT.NFE_ConsultaCadastro(libHandle, ToUTF8(cUF), ToUTF8(nDocumento), nIE, buffer, ref bufferLen);

        CheckResult(ret);

        return ConsultaCadastroResposta.LerResposta(CheckBuffer(buffer, bufferLen));
    }

    public InutilizarNFeResposta Inutilizar(string acnpj, string aJustificativa, int ano, int modelo,
        int serie, int numeroInicial, int numeroFinal)
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        var ret = ACBrLibNFeBridgeMT.NFE_Inutilizar(libHandle, ToUTF8(acnpj), ToUTF8(aJustificativa), ano, modelo, serie, numeroInicial, numeroFinal, buffer, ref bufferLen);

        CheckResult(ret);

        return InutilizarNFeResposta.LerResposta(CheckBuffer(buffer, bufferLen));
    }

    public EnvioRetornoResposta Enviar(int aLote, bool imprimir = false, bool sincrono = false, bool zipado = false)
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        var ret = ACBrLibNFeBridgeMT.NFE_Enviar(libHandle, aLote, imprimir, sincrono, zipado, buffer, ref bufferLen);

        CheckResult(ret);

        return EnvioRetornoResposta.LerResposta(CheckBuffer(buffer, bufferLen), "NFe");
    }

    public RetornoResposta ConsultarRecibo(string aRecibo)
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        var ret = ACBrLibNFeBridgeMT.NFE_ConsultarRecibo(libHandle, ToUTF8(aRecibo), buffer, ref bufferLen);

        CheckResult(ret);

        return RetornoResposta.LerResposta(CheckBuffer(buffer, bufferLen), "NFe");
    }

    public CancelamentoNFeResposta Cancelar(string eChave, string eJustificativa, string eCNPJ, int aLote)
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        var ret = ACBrLibNFeBridgeMT.NFE_Cancelar(libHandle, ToUTF8(eChave), ToUTF8(eJustificativa), ToUTF8(eCNPJ), aLote, buffer, ref bufferLen);

        CheckResult(ret);

        return CancelamentoNFeResposta.LerResposta(CheckBuffer(buffer, bufferLen));
    }

    public EventoResposta EnviarEvento(int aLote)
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        var ret = ACBrLibNFeBridgeMT.NFE_EnviarEvento(libHandle, aLote, buffer, ref bufferLen);

        CheckResult(ret);

        return EventoResposta.LerResposta(CheckBuffer(buffer, bufferLen));
    }

    public DistribuicaoDFeResposta<TipoEventoNFe> DistribuicaoDFePorUltNSU(int acUFAutor, string eCnpjcpf, string eultNsu)
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        var ret = ACBrLibNFeBridgeMT.NFE_DistribuicaoDFePorUltNSU(libHandle, acUFAutor, ToUTF8(eCnpjcpf), ToUTF8(eultNsu), buffer, ref bufferLen);

        CheckResult(ret);

        return DistribuicaoDFeResposta<TipoEventoNFe>.LerResposta(CheckBuffer(buffer, bufferLen));
    }

    public DistribuicaoDFeResposta<TipoEventoNFe> DistribuicaoDFe(int acUFAutor, string eCnpjcpf, string eultNsu, string ArquivoOuXml)
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        var ret = ACBrLibNFeBridgeMT.NFE_DistribuicaoDFe(libHandle, acUFAutor, ToUTF8(eCnpjcpf), ToUTF8(eultNsu), ToUTF8(ArquivoOuXml), buffer, ref bufferLen);

        CheckResult(ret);

        return DistribuicaoDFeResposta<TipoEventoNFe>.LerResposta(CheckBuffer(buffer, bufferLen));
    }

    public DistribuicaoDFeResposta<TipoEventoNFe> DistribuicaoDFePorNSU(int acUFAutor, string eCnpjcpf, string eNsu)
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        var ret = ACBrLibNFeBridgeMT.NFE_DistribuicaoDFePorNSU(libHandle, acUFAutor, ToUTF8(eCnpjcpf), ToUTF8(eNsu), buffer, ref bufferLen);

        CheckResult(ret);

        return DistribuicaoDFeResposta<TipoEventoNFe>.LerResposta(CheckBuffer(buffer, bufferLen));
    }

    public DistribuicaoDFeResposta<TipoEventoNFe> DistribuicaoDFePorChave(int acUFAutor, string eCnpjcpf, string echNFe)
    {
        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        var ret = ACBrLibNFeBridgeMT.NFE_DistribuicaoDFePorChave(libHandle, acUFAutor, ToUTF8(eCnpjcpf), ToUTF8(echNFe), buffer, ref bufferLen);

        CheckResult(ret);

        return DistribuicaoDFeResposta<TipoEventoNFe>.LerResposta(CheckBuffer(buffer, bufferLen));
    }

    public void EnviarEmail(string ePara, string eChaveNFe, bool aEnviaPDF, string eAssunto, string eMensagem, string[] eCc = null, string[] eAnexos = null)
    {
        var ret = ACBrLibNFeBridgeMT.NFE_EnviarEmail(libHandle, ToUTF8(ePara), ToUTF8(eChaveNFe), aEnviaPDF, ToUTF8(eAssunto), ToUTF8(eCc == null ? "" : string.Join(";", eCc)),
                                             ToUTF8(eAnexos == null ? "" : string.Join(";", eAnexos)), ToUTF8(eMensagem.Replace(Environment.NewLine, ";")));

        CheckResult(ret);
    }

    public void EnviarEmailEvento(string ePara, string eChaveEvento, string eChaveNFe, bool aEnviaPDF, string eAssunto, string eMensagem, string[] eCc = null, string[] eAnexos = null)
    {
        var ret = ACBrLibNFeBridgeMT.NFE_EnviarEmailEvento(libHandle, ToUTF8(ePara), ToUTF8(eChaveEvento), ToUTF8(eChaveNFe), aEnviaPDF, ToUTF8(eAssunto), ToUTF8(eCc == null ? "" : string.Join(";", eCc)),
            ToUTF8(eAnexos == null ? "" : string.Join(";", eAnexos)), ToUTF8(eMensagem.Replace(Environment.NewLine, ";")));

        CheckResult(ret);
    }

    public void Imprimir(string cImpressora = "", int nNumCopias = 1, string cProtocolo = "", bool? bMostrarPreview = null, bool? cMarcaDagua = null,
        bool? bViaConsumidor = null, bool? bSimplificado = null)
    {
        var mostrarPreview = bMostrarPreview.HasValue ? $"{Convert.ToInt32(bMostrarPreview.Value)}" : string.Empty;
        var marcaDagua = cMarcaDagua.HasValue ? $"{Convert.ToInt32(cMarcaDagua.Value)}" : string.Empty;
        var viaConsumidor = bViaConsumidor.HasValue ? $"{Convert.ToInt32(bViaConsumidor.Value)}" : string.Empty;
        var simplificado = bSimplificado.HasValue ? $"{Convert.ToInt32(bSimplificado.Value)}" : string.Empty;

        var ret = ACBrLibNFeBridgeMT.NFE_Imprimir(libHandle, ToUTF8(cImpressora), nNumCopias, ToUTF8(cProtocolo), ToUTF8(mostrarPreview),
            ToUTF8(marcaDagua), ToUTF8(viaConsumidor), ToUTF8(simplificado));

        CheckResult(ret);
    }

    public void ImprimirPDF()
    {
        var ret = ACBrLibNFeBridgeMT.NFE_ImprimirPDF(libHandle);

        CheckResult(ret);
    }

    public void ImprimirPDF(Stream aStream)
    {
        if (aStream == null) throw new ArgumentNullException(nameof(aStream));

        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);


        var ret = ACBrLibNFeBridgeMT.NFE_SalvarPDF(libHandle, buffer, ref bufferLen);

        CheckResult(ret);

        var pdf = CheckBuffer(buffer, bufferLen);
        Base64ToStream(pdf, aStream);
    }

    public void ImprimirEvento(string eArquivoXmlNFe, string eArquivoXmlEvento)
    {
        var ret = ACBrLibNFeBridgeMT.NFE_ImprimirEvento(libHandle, ToUTF8(eArquivoXmlNFe), ToUTF8(eArquivoXmlEvento));

        CheckResult(ret);
    }

    public void ImprimirEventoPDF(string eArquivoXmlNFe, string eArquivoXmlEvento)
    {
        var ret = ACBrLibNFeBridgeMT.NFE_ImprimirEventoPDF(libHandle, ToUTF8(eArquivoXmlNFe), ToUTF8(eArquivoXmlEvento));

        CheckResult(ret);
    }

    public void ImprimirEventoPDF(string eArquivoXmlNFe, string eArquivoXmlEvento, Stream aStream)
    {
        if (aStream == null) throw new ArgumentNullException(nameof(aStream));

        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        var ret = ACBrLibNFeBridgeMT.NFE_SalvarEventoPDF(libHandle, ToUTF8(eArquivoXmlNFe), ToUTF8(eArquivoXmlEvento), buffer, ref bufferLen);

        CheckResult(ret);

        var pdf = CheckBuffer(buffer, bufferLen);
        Base64ToStream(pdf, aStream);
    }

    public void ImprimirInutilizacao(string eArquivoXml)
    {
        var ret = ACBrLibNFeBridgeMT.NFE_ImprimirInutilizacao(libHandle, ToUTF8(eArquivoXml));

        CheckResult(ret);
    }

    public void ImprimirInutilizacaoPDF(string eArquivoXml)
    {
        var ret = ACBrLibNFeBridgeMT.NFE_ImprimirInutilizacaoPDF(libHandle, ToUTF8(eArquivoXml));

        CheckResult(ret);
    }

    public void ImprimirInutilizacaoPDF(string eArquivoXml, Stream aStream)
    {
        if (aStream == null) throw new ArgumentNullException(nameof(aStream));

        var bufferLen = BUFFER_LEN;
        var buffer = new StringBuilder(bufferLen);

        var ret = ACBrLibNFeBridgeMT.NFE_SalvarInutilizacaoPDF(libHandle, ToUTF8(eArquivoXml), buffer, ref bufferLen);

        CheckResult(ret);

        var pdf = CheckBuffer(buffer, bufferLen);
        Base64ToStream(pdf, aStream);
    }

    public override string ToString()
    {
        return "libHandle: " + libHandle.ToString();
    }


}