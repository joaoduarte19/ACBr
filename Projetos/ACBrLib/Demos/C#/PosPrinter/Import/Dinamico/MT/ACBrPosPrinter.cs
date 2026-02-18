using System;
using System.Globalization;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using ACBrLib.Core;
using ACBrLib.Core.PosPrinter;

namespace ACBrLib.PosPrinter
{
    /// <inheritdoc />
    public class ACBrPosPrinter : ACBrLibBase, IACBrLibPosPrinter
    {

        private readonly ACBrPosPrinterHandle acbrPosPrinterBridge;
        private IntPtr libHandle;
        #region Constructors

        public ACBrPosPrinter(string eArqConfig = "", string eChaveCrypt = "") : base(eArqConfig, eChaveCrypt)
        {
            acbrPosPrinterBridge = ACBrPosPrinterHandle.Instance;
            Inicializar(eArqConfig, eChaveCrypt);
            Config = new PosPrinterConfig(this);
        }

        public override void Inicializar(string eArqConfig, string eChaveCrypt)
        {
            var inicializar = acbrPosPrinterBridge.GetMethod<ACBrPosPrinterHandle.POS_Inicializar>();
            var ret = acbrPosPrinterBridge.ExecuteMethod(() => inicializar(ref libHandle, ToUTF8(eArqConfig), ToUTF8(eChaveCrypt)));
            CheckResult(ret);

        }

        #endregion Constructors

        #region Properties

        public override string Nome()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrPosPrinterBridge.GetMethod<ACBrPosPrinterHandle.POS_Nome>();
            var ret = acbrPosPrinterBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        public override string Versao()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrPosPrinterBridge.GetMethod<ACBrPosPrinterHandle.POS_Versao>();
            var ret = acbrPosPrinterBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        public PosPrinterConfig Config { get; }

        #endregion Properties

        #region Metodos

        #region Ini

        public override void ConfigGravar(string eArqConfig = "")
        {
            var gravarIni = acbrPosPrinterBridge.GetMethod<ACBrPosPrinterHandle.POS_ConfigGravar>();
            var ret = acbrPosPrinterBridge.ExecuteMethod(() => gravarIni(libHandle, ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        public override void ImportarConfig(string eArqConfig)
        {
            var lerIni = acbrPosPrinterBridge.GetMethod<ACBrPosPrinterHandle.POS_ConfigImportar>();
            var ret = acbrPosPrinterBridge.ExecuteMethod(() => lerIni(libHandle, ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        public override string ExportarConfig()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrPosPrinterBridge.GetMethod<ACBrPosPrinterHandle.POS_ConfigExportar>();
            var ret = acbrPosPrinterBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        public override void ConfigLer(string eArqConfig = "")
        {
            var lerIni = acbrPosPrinterBridge.GetMethod<ACBrPosPrinterHandle.POS_ConfigLer>();
            var ret = acbrPosPrinterBridge.ExecuteMethod(() => lerIni(libHandle, ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        public override T ConfigLerValor<T>(ACBrSessao eSessao, string eChave)
        {
            var value = ConfigLerValor(eSessao.ToString(), eChave);
            return ConvertValue<T>(value);
        }

        public override void ConfigGravarValor(ACBrSessao eSessao, string eChave, object value)
        {
            if (value == null) return;

            var propValue = ConvertValue(value);

            ConfigGravarValor(eSessao.ToString(), eChave, propValue);
        }

        #endregion Ini

        #region Ativar

        public void Ativar()
        {
            var method = acbrPosPrinterBridge.GetMethod<ACBrPosPrinterHandle.POS_Ativar>();
            var ret = acbrPosPrinterBridge.ExecuteMethod(() => method(libHandle));

            CheckResult(ret);
        }

        public void Desativar()
        {
            var method = acbrPosPrinterBridge.GetMethod<ACBrPosPrinterHandle.POS_Desativar>();
            var ret = acbrPosPrinterBridge.ExecuteMethod(() => method(libHandle));

            CheckResult(ret);
        }

        #endregion Ativar

        #region Diversos

        public void Zerar()
        {
            var method = acbrPosPrinterBridge.GetMethod<ACBrPosPrinterHandle.POS_Zerar>();
            var ret = acbrPosPrinterBridge.ExecuteMethod(() => method(libHandle));

            CheckResult(ret);
        }

        public void Reset()
        {
            var method = acbrPosPrinterBridge.GetMethod<ACBrPosPrinterHandle.POS_Reset>();
            var ret = acbrPosPrinterBridge.ExecuteMethod(() => method(libHandle));

            CheckResult(ret);
        }

        public void PularLinhas(int numLinhas = 0)
        {
            var method = acbrPosPrinterBridge.GetMethod<ACBrPosPrinterHandle.POS_PularLinhas>();
            var ret = acbrPosPrinterBridge.ExecuteMethod(() => method(libHandle, numLinhas));

            CheckResult(ret);
        }

        public void CortarPapel(bool parcial = false)
        {
            var method = acbrPosPrinterBridge.GetMethod<ACBrPosPrinterHandle.POS_CortarPapel>();
            var ret = acbrPosPrinterBridge.ExecuteMethod(() => method(libHandle, parcial));

            CheckResult(ret);
        }

        public void AbrirGaveta()
        {
            var method = acbrPosPrinterBridge.GetMethod<ACBrPosPrinterHandle.POS_AbrirGaveta>();
            var ret = acbrPosPrinterBridge.ExecuteMethod(() => method(libHandle));

            CheckResult(ret);
        }

        public string LerInfoImpressora()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrPosPrinterBridge.GetMethod<ACBrPosPrinterHandle.POS_LerInfoImpressora>();
            var ret = acbrPosPrinterBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        public ACBrPosTipoStatus LerStatusImpressora(int tentativas = 1)
        {
            var status = 0;
            var method = acbrPosPrinterBridge.GetMethod<ACBrPosPrinterHandle.POS_LerStatusImpressora>();
            var ret = acbrPosPrinterBridge.ExecuteMethod(() => method(libHandle, tentativas, ref status));

            CheckResult(ret);

            return (ACBrPosTipoStatus)status;
        }

        public string[] RetornarTags(bool incluiAjuda = true)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrPosPrinterBridge.GetMethod<ACBrPosPrinterHandle.POS_RetornarTags>();
            var ret = acbrPosPrinterBridge.ExecuteMethod(() => method(libHandle, incluiAjuda, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen).Split('|');
        }

        public string[] AcharPortas()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrPosPrinterBridge.GetMethod<ACBrPosPrinterHandle.POS_AcharPortas>();
            var ret = acbrPosPrinterBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);
            var portas = CheckBuffer(buffer, bufferLen);

            return portas.Split('|')
                         .Where(x => !string.IsNullOrEmpty(x))
                         .ToArray();
        }

        public void GravarLogoArquivo(string aPath, int nAKC1, int nAKC2)
        {
            var method = acbrPosPrinterBridge.GetMethod<ACBrPosPrinterHandle.POS_GravarLogoArquivo>();
            var ret = acbrPosPrinterBridge.ExecuteMethod(() => method(libHandle, ToUTF8(aPath), nAKC1, nAKC2));

            CheckResult(ret);
        }

        public void ApagarLogo(int nAKC1, int nAKC2)
        {
            var method = acbrPosPrinterBridge.GetMethod<ACBrPosPrinterHandle.POS_ApagarLogo>();
            var ret = acbrPosPrinterBridge.ExecuteMethod(() => method(libHandle, nAKC1, nAKC2));

            CheckResult(ret);
        }

        public string LeituraCheque()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrPosPrinterBridge.GetMethod<ACBrPosPrinterHandle.POS_LeituraCheque>();
            var ret = acbrPosPrinterBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        public string LerCMC7(bool AguardaCheque, int SegundosEspera)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrPosPrinterBridge.GetMethod<ACBrPosPrinterHandle.POS_LerCMC7>();
            var ret = acbrPosPrinterBridge.ExecuteMethod(() => method(libHandle, AguardaCheque, SegundosEspera, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        public void EjetarCheque()
        {
            var method = acbrPosPrinterBridge.GetMethod<ACBrPosPrinterHandle.POS_EjetarCheque>();
            var ret = acbrPosPrinterBridge.ExecuteMethod(() => method(libHandle));

            CheckResult(ret);
        }

        public bool PodeLerDaPorta()
        {
            var method = acbrPosPrinterBridge.GetMethod<ACBrPosPrinterHandle.POS_PodeLerDaPorta>();
            var ret = acbrPosPrinterBridge.ExecuteMethod(() => method(libHandle));

            CheckResult(ret);

            return ret == 1;
        }

        public string LerCaracteristicas()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrPosPrinterBridge.GetMethod<ACBrPosPrinterHandle.POS_LerCaracteristicas>();
            var ret = acbrPosPrinterBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        public override string OpenSSLInfo()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrPosPrinterBridge.GetMethod<ACBrPosPrinterHandle.POS_OpenSSLInfo>();
            var ret = acbrPosPrinterBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        #endregion Diversos

        #region Imprimir

        public void Imprimir(string aString = "", bool pulaLinha = false, bool decodificarTags = true, bool codificarPagina = true, int copias = 1)
        {
            var method = acbrPosPrinterBridge.GetMethod<ACBrPosPrinterHandle.POS_Imprimir>();
            var ret = acbrPosPrinterBridge.ExecuteMethod(() => method(libHandle, ToUTF8(aString), pulaLinha, decodificarTags, codificarPagina, copias));

            CheckResult(ret);
        }

        public void ImprimirLinha(string aString)
        {
            var method = acbrPosPrinterBridge.GetMethod<ACBrPosPrinterHandle.POS_ImprimirLinha>();
            var ret = acbrPosPrinterBridge.ExecuteMethod(() => method(libHandle, ToUTF8(aString)));

            CheckResult(ret);
        }

        public void ImprimirCmd(string aString)
        {
            var method = acbrPosPrinterBridge.GetMethod<ACBrPosPrinterHandle.POS_ImprimirCmd>();
            var ret = acbrPosPrinterBridge.ExecuteMethod(() => method(libHandle, ToUTF8(aString)));

            CheckResult(ret);
        }

        public void ImprimirTags()
        {
            var method = acbrPosPrinterBridge.GetMethod<ACBrPosPrinterHandle.POS_ImprimirTags>();
            var ret = acbrPosPrinterBridge.ExecuteMethod(() => method(libHandle));

            CheckResult(ret);
        }

        public void ImprimirImagemArquivo(string aPath)
        {
            var method = acbrPosPrinterBridge.GetMethod<ACBrPosPrinterHandle.POS_ImprimirImagemArquivo>();
            var ret = acbrPosPrinterBridge.ExecuteMethod(() => method(libHandle, ToUTF8(aPath)));

            CheckResult(ret);
        }

        public void ImprimirLogo(int nAKC1, int nAKC2, int nFatorX, int nFatorY)
        {
            var method = acbrPosPrinterBridge.GetMethod<ACBrPosPrinterHandle.POS_ImprimirLogo>();
            var ret = acbrPosPrinterBridge.ExecuteMethod(() => method(libHandle, nAKC1, nAKC2, nFatorX, nFatorY));

            CheckResult(ret);
        }

        public void ImprimirCheque(int CodBanco, decimal AValor, DateTime ADataEmissao, string AFavorecido,
            string ACidade, string AComplemento, bool LerCMC7, int SegundosEspera)
        {
            var method = acbrPosPrinterBridge.GetMethod<ACBrPosPrinterHandle.POS_ImprimirCheque>();

            var valor = AValor.ToString("N2", CultureInfo.CreateSpecificCulture("pt-BR"));
            var data = ADataEmissao.ToString("dd/MM/yyyy");

            var ret = acbrPosPrinterBridge.ExecuteMethod(() => method(libHandle, CodBanco, ToUTF8(valor), ToUTF8(data), ToUTF8(AFavorecido), ToUTF8(ACidade),
                                                 ToUTF8(AComplemento), LerCMC7, SegundosEspera));

            CheckResult(ret);
        }

        public void ImprimirTextoCheque(int X, int Y, string AString, bool AguardaCheque, int SegundosEspera)
        {
            var method = acbrPosPrinterBridge.GetMethod<ACBrPosPrinterHandle.POS_ImprimirTextoCheque>();
            var ret = acbrPosPrinterBridge.ExecuteMethod(() => method(libHandle, X, Y, ToUTF8(AString), AguardaCheque, SegundosEspera));

            CheckResult(ret);
        }

        public string TxRx(string aString, byte bytesToRead = 1, int aTimeOut = 500, bool waitForTerminator = false)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrPosPrinterBridge.GetMethod<ACBrPosPrinterHandle.POS_TxRx>();
            var ret = acbrPosPrinterBridge.ExecuteMethod(() => method(libHandle, ToUTF8(aString), bytesToRead, aTimeOut, waitForTerminator, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        #endregion Imprimir

        #region Private Methods

        public override void Finalizar()
        {
            var finalizarLib = acbrPosPrinterBridge.GetMethod<ACBrPosPrinterHandle.POS_Finalizar>();
            var codRet = acbrPosPrinterBridge.ExecuteMethod(() => finalizarLib(libHandle));
            CheckResult(codRet);
            libHandle = IntPtr.Zero;
        }

        protected override string GetUltimoRetorno(int iniBufferLen = 0)
        {
            var bufferLen = iniBufferLen < 1 ? BUFFER_LEN : iniBufferLen;
            var buffer = new StringBuilder(bufferLen);
            var ultimoRetorno = acbrPosPrinterBridge.GetMethod<ACBrPosPrinterHandle.POS_UltimoRetorno>();

            if (iniBufferLen < 1)
            {
                acbrPosPrinterBridge.ExecuteMethod(() => ultimoRetorno(libHandle, buffer, ref bufferLen));
                if (bufferLen <= BUFFER_LEN) return FromUTF8(buffer);

                buffer.Capacity = bufferLen;
            }

            acbrPosPrinterBridge.ExecuteMethod(() => ultimoRetorno(libHandle, buffer, ref bufferLen));
            return FromUTF8(buffer);
        }

        public override string ConfigLerValor(string eSessao, string eChave)
        {
            var method = acbrPosPrinterBridge.GetMethod<ACBrPosPrinterHandle.POS_ConfigLerValor>();

            var bufferLen = BUFFER_LEN;
            var pValue = new StringBuilder(bufferLen);
            var ret = acbrPosPrinterBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eSessao.ToString()), ToUTF8(eChave), pValue, ref bufferLen));
            CheckResult(ret);

            return CheckBuffer(pValue, bufferLen);
        }

        public override void ConfigGravarValor(string eSessao, string eChave, string eValor)
        {
            var method = acbrPosPrinterBridge.GetMethod<ACBrPosPrinterHandle.POS_ConfigGravarValor>();
            var ret = acbrPosPrinterBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eSessao.ToString()), ToUTF8(eChave), ToUTF8(eValor)));
            CheckResult(ret);
        }



        #endregion Private Methods


        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        public void Dispose(bool disposing)
        {
            if (disposing)
            {
                Finalizar();
            }
        }

        public void InicializarPos()
        {
           var method = acbrPosPrinterBridge.GetMethod<ACBrPosPrinterHandle.POS_InicializarPos>();
           var ret = acbrPosPrinterBridge.ExecuteMethod(() => method(libHandle));
           CheckResult(ret);
        }

        #endregion Metodos
    }
}