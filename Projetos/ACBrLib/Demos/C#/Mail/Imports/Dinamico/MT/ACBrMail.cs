using System;
using System.Text;
using ACBrLib.Core;
using ACBrLib.Core.Mail;

namespace ACBrLib.Mail
{
    /// <summary>
    /// Implementação de alto nível da biblioteca ACBrLib Mail para uso em aplicações .NET (Multi-Thread).
    /// </summary>
    public class ACBrMail : ACBrLibBase, IACBrLibMail
    {
        #region Fields

        private IntPtr libHandle = IntPtr.Zero;
        private bool disposed;
        private ACBrMailHandle mailBridge;

        #endregion Fields

        #region Constructors

        /// <summary>
        /// Cria uma nova instância do componente ACBrMail.
        /// </summary>
        public ACBrMail(string eArqConfig = "", string eChaveCrypt = "") : base(eArqConfig, eChaveCrypt)
        {
            mailBridge = ACBrMailHandle.Instance;
            Inicializar(eArqConfig, eChaveCrypt);
            Config = new MailConfig(this);
        }

        /// <inheritdoc />
        public override void Inicializar(string eArqConfig = "", string eChaveCrypt = "")
        {
            var inicializar = mailBridge.GetMethod<ACBrMailHandle.MAIL_Inicializar>();
            var ret = mailBridge.ExecuteMethod<int>(() => inicializar(ref libHandle, ToUTF8(eArqConfig), ToUTF8(eChaveCrypt)));
            CheckResult(ret);
        }

        #endregion Constructors

        #region Properties

        /// <inheritdoc />
        public override string Nome()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);
            var method = mailBridge.GetMethod<ACBrMailHandle.MAIL_Nome>();
            var ret = mailBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));
            CheckResult(ret);
            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public override string Versao()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);
            var method = mailBridge.GetMethod<ACBrMailHandle.MAIL_Versao>();
            var ret = mailBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));
            CheckResult(ret);
            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public MailConfig Config { get; }

        #endregion Properties

        #region Config

        /// <inheritdoc />
        public override void ConfigGravar(string eArqConfig = "")
        {
            var method = mailBridge.GetMethod<ACBrMailHandle.MAIL_ConfigGravar>();
            var ret = mailBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eArqConfig)));
            CheckResult(ret);
        }

        /// <inheritdoc />
        public override void ImportarConfig(string eArqConfig = "")
        {
            var method = mailBridge.GetMethod<ACBrMailHandle.MAIL_ConfigImportar>();
            var ret = mailBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eArqConfig)));
            CheckResult(ret);
        }

        /// <inheritdoc />
        public override string ExportarConfig()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);
            var method = mailBridge.GetMethod<ACBrMailHandle.MAIL_ConfigExportar>();
            var ret = mailBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));
            CheckResult(ret);
            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public override void ConfigLer(string eArqConfig = "")
        {
            var method = mailBridge.GetMethod<ACBrMailHandle.MAIL_ConfigLer>();
            var ret = mailBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eArqConfig)));
            CheckResult(ret);
        }

        /// <inheritdoc />
        public override string ConfigLerValor(string eSessao, string eChave)
        {
            var bufferLen = BUFFER_LEN;
            var pValue = new StringBuilder(bufferLen);
            var method = mailBridge.GetMethod<ACBrMailHandle.MAIL_ConfigLerValor>();
            var ret = mailBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eSessao), ToUTF8(eChave), pValue, ref bufferLen));
            CheckResult(ret);
            return CheckBuffer(pValue, bufferLen);
        }

        /// <inheritdoc />
        public override void ConfigGravarValor(string eSessao, string eChave, string eValor)
        {
            var method = mailBridge.GetMethod<ACBrMailHandle.MAIL_ConfigGravarValor>();
            var ret = mailBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eSessao), ToUTF8(eChave), ToUTF8(eValor)));
            CheckResult(ret);
        }

        #endregion Config

        #region Mail

        /// <inheritdoc />
        public void Clear()
        {
            var method = mailBridge.GetMethod<ACBrMailHandle.MAIL_Clear>();
            var ret = mailBridge.ExecuteMethod(() => method(libHandle));
            CheckResult(ret);
        }

        /// <inheritdoc />
        public void SetSubject(string subject)
        {
            var method = mailBridge.GetMethod<ACBrMailHandle.MAIL_SetSubject>();
            var ret = mailBridge.ExecuteMethod(() => method(libHandle, ToUTF8(subject)));
            CheckResult(ret);
        }

        /// <inheritdoc />
        public void AddAddress(string eEmail, string eName)
        {
            var method = mailBridge.GetMethod<ACBrMailHandle.MAIL_AddAddress>();
            var ret = mailBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eEmail), ToUTF8(eName)));
            CheckResult(ret);
        }

        /// <inheritdoc />
        public void AddReplyTo(string eEmail, string eName)
        {
            var method = mailBridge.GetMethod<ACBrMailHandle.MAIL_AddReplyTo>();
            var ret = mailBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eEmail), ToUTF8(eName)));
            CheckResult(ret);
        }

        /// <inheritdoc />
        public void AddCC(string eEmail, string eName)
        {
            var method = mailBridge.GetMethod<ACBrMailHandle.MAIL_AddCC>();
            var ret = mailBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eEmail), ToUTF8(eName)));
            CheckResult(ret);
        }

        /// <inheritdoc />
        public void AddBCC(string eEmail, string eName)
        {
            var method = mailBridge.GetMethod<ACBrMailHandle.MAIL_AddBCC>();
            var ret = mailBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eEmail)));
            CheckResult(ret);
        }

        /// <inheritdoc />
        public void AddBody(string eBody)
        {
            var method = mailBridge.GetMethod<ACBrMailHandle.MAIL_AddBody>();
            var ret = mailBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eBody)));
            CheckResult(ret);
        }

        /// <inheritdoc />
        public void AddAltBody(string eAltBody)
        {
            var method = mailBridge.GetMethod<ACBrMailHandle.MAIL_AddAltBody>();
            var ret = mailBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eAltBody)));
            CheckResult(ret);
        }

        /// <inheritdoc />
        public void ClearAttachment()
        {
            var method = mailBridge.GetMethod<ACBrMailHandle.MAIL_ClearAttachment>();
            var ret = mailBridge.ExecuteMethod(() => method(libHandle));
            CheckResult(ret);
        }

        /// <inheritdoc />
        public void AddAttachment(string eFileName, string eDescription, MailAttachmentDisposition aDisposition)
        {
            var method = mailBridge.GetMethod<ACBrMailHandle.MAIL_AddAttachment>();
            var ret = mailBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eFileName), ToUTF8(eDescription), (int)aDisposition));
            CheckResult(ret);
        }

        /// <inheritdoc />
        public void Send()
        {
            var method = mailBridge.GetMethod<ACBrMailHandle.MAIL_Send>();
            var ret = mailBridge.ExecuteMethod(() => method(libHandle));
            CheckResult(ret);
        }

        /// <inheritdoc />
        public void SaveToFile(string eFileName)
        {
            var method = mailBridge.GetMethod<ACBrMailHandle.MAIL_SaveToFile>();
            var ret = mailBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eFileName)));
            CheckResult(ret);
        }

        #endregion Mail

        #region Private

        /// <inheritdoc />
        public override void Finalizar()
        {
            var method = mailBridge.GetMethod<ACBrMailHandle.MAIL_Finalizar>();
            var codRet = mailBridge.ExecuteMethod(() => method(libHandle));
            CheckResult(codRet);
            libHandle = IntPtr.Zero;
        }

        /// <inheritdoc />
        protected override string GetUltimoRetorno(int iniBufferLen = 0)
        {
            var bufferLen = iniBufferLen < 1 ? BUFFER_LEN : iniBufferLen;
            var buffer = new StringBuilder(bufferLen);
            var ultimoRetorno = mailBridge.GetMethod<ACBrMailHandle.MAIL_UltimoRetorno>();
            if (iniBufferLen < 1)
            {
                mailBridge.ExecuteMethod(() => ultimoRetorno(libHandle, buffer, ref bufferLen));
                if (bufferLen <= BUFFER_LEN) return FromUTF8(buffer);
                buffer.Capacity = bufferLen;
            }
            mailBridge.ExecuteMethod(() => ultimoRetorno(libHandle, buffer, ref bufferLen));
            return FromUTF8(buffer);
        }

        /// <inheritdoc />
        public override string OpenSSLInfo()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);
            var method = mailBridge.GetMethod<ACBrMailHandle.MAIL_OpenSSLInfo>();
            var ret = mailBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));
            CheckResult(ret);
            return CheckBuffer(buffer, bufferLen);
        }

        #endregion Private

        #region IDisposable

        /// <inheritdoc />
        protected void Dispose(bool disposing)
        {
            if (disposed) return;
            if (disposing) Finalizar();
            disposed = true;
        }

        /// <inheritdoc />
        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        #endregion IDisposable
    }
}
