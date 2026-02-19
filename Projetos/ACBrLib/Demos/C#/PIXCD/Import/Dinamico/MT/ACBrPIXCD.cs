using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using ACBrLib.Core;

namespace ACBrLib.PIXCD
{
    /// <inheritdoc />
    public class ACBrPIXCD : ACBrLibBase, IACBrLibPIXCD
    {
        #region fields
        private IntPtr libHandle = IntPtr.Zero;
        private bool disposed = false;
        private readonly ACBrPIXCDHandle acbrPIXCDBridge;
        #endregion

        #region Constructors
        public ACBrPIXCD(string eArqConfig = "", string eChaveCrypt = "") : base(eArqConfig, eChaveCrypt)
        {
            acbrPIXCDBridge = ACBrPIXCDHandle.Instance;
            Inicializar(eArqConfig, eChaveCrypt);
            Config = new ACBrPIXCDConfig(this);
        }

        public override void Inicializar(string eArqConfig, string eChaveCrypt)
        {
            var inicializar = acbrPIXCDBridge.GetMethod<ACBrPIXCDHandle.PIXCD_Inicializar>();
            var ret = acbrPIXCDBridge.ExecuteMethod(() => inicializar(ref libHandle, ToUTF8(eArqConfig), ToUTF8(eChaveCrypt)));
            CheckResult(ret);

        }

        #endregion Constructors

        #region Properties


        public ACBrPIXCDConfig Config { get; }

        #endregion Properties

        #region Metodos

        #region Ini

        public override void ConfigGravar(string eArqConfig = "")
        {
            var gravarIni = acbrPIXCDBridge.GetMethod<ACBrPIXCDHandle.PIXCD_ConfigGravar>();
            var ret = acbrPIXCDBridge.ExecuteMethod(() => gravarIni(libHandle, ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        public override void ImportarConfig(string eArqConfig)
        {
            var lerIni = acbrPIXCDBridge.GetMethod<ACBrPIXCDHandle.PIXCD_ConfigImportar>();
            var ret = acbrPIXCDBridge.ExecuteMethod(() => lerIni(libHandle, ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        public override string ExportarConfig()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrPIXCDBridge.GetMethod<ACBrPIXCDHandle.PIXCD_ConfigExportar>();
            var ret = acbrPIXCDBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        public override void ConfigLer(string eArqConfig = "")
        {
            var lerIni = acbrPIXCDBridge.GetMethod<ACBrPIXCDHandle.PIXCD_ConfigLer>();
            var ret = acbrPIXCDBridge.ExecuteMethod(() => lerIni(libHandle, ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        #endregion Ini

        #region Diversos

        public string GerarQRCodeEstatico(double AValor, string AinfoAdicional, string ATxID)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrPIXCDBridge.GetMethod<ACBrPIXCDHandle.PIXCD_GerarQRCodeEstatico>();
            var ret = acbrPIXCDBridge.ExecuteMethod(() => method(libHandle, AValor, ToUTF8(AinfoAdicional), ToUTF8(ATxID), buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        public string ConsultarPix(string Ae2eid)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrPIXCDBridge.GetMethod<ACBrPIXCDHandle.PIXCD_ConsultarPix>();
            var ret = acbrPIXCDBridge.ExecuteMethod(() => method(libHandle, ToUTF8(Ae2eid), buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        public string ConsultarPixRecebidos(DateTime ADataInicio, DateTime ADataFim, string ATxId, string ACpfCnpj, int PagAtual, int ItensPorPagina)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrPIXCDBridge.GetMethod<ACBrPIXCDHandle.PIXCD_ConsultarPixRecebidos>();
            var ret = acbrPIXCDBridge.ExecuteMethod(() => method(libHandle, ADataInicio, ADataFim, ToUTF8(ATxId), ToUTF8(ACpfCnpj), PagAtual, ItensPorPagina, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        public string SolicitarDevolucaoPix(string AInfDevolucao, string Ae2eid, string AidDevolucao)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrPIXCDBridge.GetMethod<ACBrPIXCDHandle.PIXCD_SolicitarDevolucaoPix>();
            var ret = acbrPIXCDBridge.ExecuteMethod(() => method(libHandle, ToUTF8(AInfDevolucao), ToUTF8(Ae2eid), ToUTF8(AidDevolucao), buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        public string ConsultarDevolucaoPix(string Ae2eid, string AidDevolucao)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrPIXCDBridge.GetMethod<ACBrPIXCDHandle.PIXCD_ConsultarDevolucaoPix>();
            var ret = acbrPIXCDBridge.ExecuteMethod(() => method(libHandle, ToUTF8(Ae2eid), ToUTF8(AidDevolucao), buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        public string CriarCobrancaImediata(string AInfCobSolicitada, string ATxId)
        {

            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrPIXCDBridge.GetMethod<ACBrPIXCDHandle.PIXCD_CriarCobrancaImediata>();
            var ret = acbrPIXCDBridge.ExecuteMethod(() => method(libHandle, ToUTF8(AInfCobSolicitada), ToUTF8(ATxId), buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        public string ConsultarCobrancaImediata(string ATxId, int ARevisao)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrPIXCDBridge.GetMethod<ACBrPIXCDHandle.PIXCD_ConsultarCobrancaImediata>();
            var ret = acbrPIXCDBridge.ExecuteMethod(() => method(libHandle, ToUTF8(ATxId), ARevisao, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        public string ConsultarCobrancasCob(DateTime ADataInicio, DateTime ADataFim, string ACpfCnpj, Boolean ALocationPresente, int AStatus, int PagAtual, int ItensPorPagina)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrPIXCDBridge.GetMethod<ACBrPIXCDHandle.PIXCD_ConsultarCobrancasCob>();
            var ret = acbrPIXCDBridge.ExecuteMethod(() => method(libHandle, ADataInicio, ADataFim, ToUTF8(ACpfCnpj), ALocationPresente, AStatus, PagAtual, ItensPorPagina, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        public string RevisarCobrancaImediata(string AInfCobRevisada, string ATxId)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrPIXCDBridge.GetMethod<ACBrPIXCDHandle.PIXCD_RevisarCobrancaImediata>();
            var ret = acbrPIXCDBridge.ExecuteMethod(() => method(libHandle, ToUTF8(AInfCobRevisada), ToUTF8(ATxId), buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        public string CancelarCobrancaImediata(string ATxId)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrPIXCDBridge.GetMethod<ACBrPIXCDHandle.PIXCD_CancelarCobrancaImediata>();
            var ret = acbrPIXCDBridge.ExecuteMethod(() => method(libHandle, ToUTF8(ATxId), buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        public string CriarCobranca(string AInfCobVSolicitada, string ATxId)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrPIXCDBridge.GetMethod<ACBrPIXCDHandle.PIXCD_CriarCobranca>();
            var ret = acbrPIXCDBridge.ExecuteMethod(() => method(libHandle, ToUTF8(AInfCobVSolicitada), ToUTF8(ATxId), buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        public string ConsultarCobranca(string ATxId, int ARevisao)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrPIXCDBridge.GetMethod<ACBrPIXCDHandle.PIXCD_ConsultarCobranca>();
            var ret = acbrPIXCDBridge.ExecuteMethod(() => method(libHandle, ToUTF8(ATxId), ARevisao, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        public string ConsultarCobrancasCobV(DateTime ADataInicio, DateTime ADataFim, string ACpfCnpj, Boolean ALocationPresente, int AStatus, int PagAtual, int ItensPorPagina)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrPIXCDBridge.GetMethod<ACBrPIXCDHandle.PIXCD_ConsultarCobrancasCobV>();
            var ret = acbrPIXCDBridge.ExecuteMethod(() => method(libHandle, ADataInicio, ADataFim, ToUTF8(ACpfCnpj), ALocationPresente, AStatus, PagAtual, ItensPorPagina, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        public string RevisarCobranca(string AInfCobVRevisada, string ATxId)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrPIXCDBridge.GetMethod<ACBrPIXCDHandle.PIXCD_RevisarCobranca>();
            var ret = acbrPIXCDBridge.ExecuteMethod(() => method(libHandle, ToUTF8(AInfCobVRevisada), ToUTF8(ATxId), buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        public string CancelarCobranca(string ATxId)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrPIXCDBridge.GetMethod<ACBrPIXCDHandle.PIXCD_CancelarCobranca>();
            var ret = acbrPIXCDBridge.ExecuteMethod(() => method(libHandle, ToUTF8(ATxId), buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        public override string OpenSSLInfo()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrPIXCDBridge.GetMethod<ACBrPIXCDHandle.PIXCD_OpenSSLInfo>();
            var ret = acbrPIXCDBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        #endregion Diversos

        #region Private Methods

        public override void Finalizar()
        {
            var finalizarLib = acbrPIXCDBridge.GetMethod<ACBrPIXCDHandle.PIXCD_Finalizar>();
            var codRet = acbrPIXCDBridge.ExecuteMethod(() => finalizarLib(libHandle));
            CheckResult(codRet);
            libHandle = IntPtr.Zero;
        }

        protected override string GetUltimoRetorno(int iniBufferLen = 0)
        {
            var bufferLen = iniBufferLen < 1 ? BUFFER_LEN : iniBufferLen;
            var buffer = new StringBuilder(bufferLen);
            var ultimoRetorno = acbrPIXCDBridge.GetMethod<ACBrPIXCDHandle.PIXCD_UltimoRetorno>();

            if (iniBufferLen < 1)
            {
                acbrPIXCDBridge.ExecuteMethod(() => ultimoRetorno(libHandle, buffer, ref bufferLen));
                if (bufferLen <= BUFFER_LEN) return FromUTF8(buffer);

                buffer.Capacity = bufferLen;
            }

            acbrPIXCDBridge.ExecuteMethod(() => ultimoRetorno(libHandle, buffer, ref bufferLen));
            return FromUTF8(buffer);
        }



        public override string ConfigLerValor(string eSessao, string eChave)
        {
            var method = acbrPIXCDBridge.GetMethod<ACBrPIXCDHandle.PIXCD_ConfigLerValor>();

            var bufferLen = BUFFER_LEN;
            var pValue = new StringBuilder(bufferLen);
            var ret = acbrPIXCDBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eSessao.ToString()), ToUTF8(eChave), pValue, ref bufferLen));
            CheckResult(ret);

            return CheckBuffer(pValue, bufferLen);
        }

        public override void ConfigGravarValor(string eSessao, string eChave, string eValor)
        {
            var method = acbrPIXCDBridge.GetMethod<ACBrPIXCDHandle.PIXCD_ConfigGravarValor>();

            var ret = acbrPIXCDBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eSessao.ToString()), ToUTF8(eChave), ToUTF8(eValor)));
            CheckResult(ret);
        }

        public override string Versao()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrPIXCDBridge.GetMethod<ACBrPIXCDHandle.PIXCD_Versao>();
            var ret = acbrPIXCDBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        public override string Nome()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrPIXCDBridge.GetMethod<ACBrPIXCDHandle.PIXCD_Nome>();
            var ret = acbrPIXCDBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        #endregion Private Methods


        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        protected void Dispose(bool disposing)
        {
            if (disposing)
            {
                Finalizar();// dispose managed resources
            }

        }
        #endregion Metodos
    }
}