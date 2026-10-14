using System;
using System.Text;
using ACBrLib.Core;

namespace ACBrLib.IMendes
{
    /// <summary>
    /// ACBrIMendes é uma classe que implementa a interface <see cref="IACBrLibIMendes"/> e fornece os métodos da ACBrLibIMendes (versão MultiThread).
    /// </summary>
    public class ACBrIMendes : ACBrLibBase, IACBrLibIMendes
    {
        #region Fields

        private IntPtr libHandle = IntPtr.Zero;
        private bool disposed = false;
        private ACBrIMendesHandle iMendesBridge;

        #endregion Fields

        #region Constructors

        /// <summary>
        /// Inicializa uma nova instância da classe <see cref="ACBrIMendes"/>, com opções de configuração inicial.
        /// </summary>
        /// <param name="eArqConfig">Caminho para o arquivo de configuração.</param>
        /// <param name="eChaveCrypt">Chave de criptografia para o arquivo de configuração.</param>
        public ACBrIMendes(string eArqConfig = "", string eChaveCrypt = "") : base(eArqConfig, eChaveCrypt)
        {
            iMendesBridge = ACBrIMendesHandle.Instance;
            Inicializar(eArqConfig, eChaveCrypt);
            Config = new ACBrIMendesConfig(this);
        }

        #endregion Constructors

        /// <inheritdoc />
        public override void Inicializar(string eArqConfig = "", string eChaveCrypt = "")
        {
            var inicializarLib = iMendesBridge.GetMethod<ACBrIMendesHandle.IMendes_Inicializar>();
            var ret = iMendesBridge.ExecuteMethod<int>(() => inicializarLib(ref libHandle, ToUTF8(eArqConfig), ToUTF8(eChaveCrypt)));
            CheckResult(ret);
        }

        #region Properties

        /// <inheritdoc />
        public override string Nome()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = iMendesBridge.GetMethod<ACBrIMendesHandle.IMendes_Nome>();
            var ret = iMendesBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public override string Versao()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = iMendesBridge.GetMethod<ACBrIMendesHandle.IMendes_Versao>();
            var ret = iMendesBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public ACBrIMendesConfig Config { get; }

        #endregion Properties

        #region Metodos

        #region Ini

        /// <inheritdoc />
        public override void ConfigGravar(string eArqConfig = "")
        {
            var gravarIni = iMendesBridge.GetMethod<ACBrIMendesHandle.IMendes_ConfigGravar>();
            var ret = iMendesBridge.ExecuteMethod(() => gravarIni(libHandle, ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        /// <inheritdoc />
        public override void ImportarConfig(string eArqConfig)
        {
            var lerIni = iMendesBridge.GetMethod<ACBrIMendesHandle.IMendes_ConfigImportar>();
            var ret = iMendesBridge.ExecuteMethod(() => lerIni(libHandle, ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        /// <inheritdoc />
        public override string ExportarConfig()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = iMendesBridge.GetMethod<ACBrIMendesHandle.IMendes_ConfigExportar>();
            var ret = iMendesBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public override void ConfigLer(string eArqConfig = "")
        {
            var lerIni = iMendesBridge.GetMethod<ACBrIMendesHandle.IMendes_ConfigLer>();
            var ret = iMendesBridge.ExecuteMethod(() => lerIni(libHandle, ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        /// <inheritdoc />
        public override string ConfigLerValor(string eSessao, string eChave)
        {
            var method = iMendesBridge.GetMethod<ACBrIMendesHandle.IMendes_ConfigLerValor>();
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);
            var ret = iMendesBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eSessao), ToUTF8(eChave), buffer, ref bufferLen));
            CheckResult(ret);
            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public override void ConfigGravarValor(string eSessao, string eChave, string eValor)
        {
            var method = iMendesBridge.GetMethod<ACBrIMendesHandle.IMendes_ConfigGravarValor>();
            var ret = iMendesBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eSessao), ToUTF8(eChave), ToUTF8(eValor)));
            CheckResult(ret);
        }

        #endregion Ini

        #region IMendes

        /// <inheritdoc />
        public string ConsultarDescricao(string eDescricao, string eCNPJ = "", int nTipo = 0)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = iMendesBridge.GetMethod<ACBrIMendesHandle.IMendes_ConsultarDescricao>();
            var ret = iMendesBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eDescricao), ToUTF8(eCNPJ), nTipo, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public string ConsultarAlterados(string eUF, string eCNPJ = "", int nLimite = 0)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = iMendesBridge.GetMethod<ACBrIMendesHandle.IMendes_ConsultarAlterados>();
            var ret = iMendesBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eUF), ToUTF8(eCNPJ), nLimite, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public string HistoricoAcesso(string eCNPJ = "")
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = iMendesBridge.GetMethod<ACBrIMendesHandle.IMendes_HistoricoAcesso>();
            var ret = iMendesBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eCNPJ), buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public string ConsultarRegimesEspeciais(string eUF, bool bIncludeTrib = false)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = iMendesBridge.GetMethod<ACBrIMendesHandle.IMendes_ConsultarRegimesEspeciais>();
            var ret = iMendesBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eUF), bIncludeTrib, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public string SaneamentoGrades(string eArquivoOuIni)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = iMendesBridge.GetMethod<ACBrIMendesHandle.IMendes_SaneamentoGrades>();
            var ret = iMendesBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eArquivoOuIni), buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public string Inativar(string eArquivoOuIni)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = iMendesBridge.GetMethod<ACBrIMendesHandle.IMendes_Inativar>();
            var ret = iMendesBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eArquivoOuIni), buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public string RemoveDevolvidos(string eArquivoOuIni)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = iMendesBridge.GetMethod<ACBrIMendesHandle.IMendes_RemoveDevolvidos>();
            var ret = iMendesBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eArquivoOuIni), buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        #endregion IMendes

        #region Private Methods

        /// <inheritdoc />
        public override void Finalizar()
        {
            var finalizarLib = iMendesBridge.GetMethod<ACBrIMendesHandle.IMendes_Finalizar>();
            var codRet = iMendesBridge.ExecuteMethod(() => finalizarLib(libHandle));
            CheckResult(codRet);
            libHandle = IntPtr.Zero;
        }

        /// <inheritdoc />
        protected override string GetUltimoRetorno(int iniBufferLen = 0)
        {
            var bufferLen = iniBufferLen < 1 ? BUFFER_LEN : iniBufferLen;
            var buffer = new StringBuilder(bufferLen);
            var ultimoRetorno = iMendesBridge.GetMethod<ACBrIMendesHandle.IMendes_UltimoRetorno>();

            if (iniBufferLen < 1)
            {
                iMendesBridge.ExecuteMethod(() => ultimoRetorno(libHandle, buffer, ref bufferLen));
                if (bufferLen <= BUFFER_LEN) return FromUTF8(buffer);

                buffer.Capacity = bufferLen;
            }

            iMendesBridge.ExecuteMethod(() => ultimoRetorno(libHandle, buffer, ref bufferLen));
            return FromUTF8(buffer);
        }

        #endregion Private Methods

        /// <inheritdoc />
        public override string OpenSSLInfo()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = iMendesBridge.GetMethod<ACBrIMendesHandle.IMendes_OpenSSLInfo>();
            var ret = iMendesBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        protected void Dispose(bool disposing)
        {
            if (disposed) return;
            if (disposing)
            {
                Finalizar();
            }
            disposed = true;
        }

        /// <summary>
        /// Libera os recursos utilizados pela instância da classe <see cref="ACBrIMendes"/>. Chama o método <see cref="Finalizar"/> para garantir que a biblioteca seja finalizada corretamente.
        /// </summary>
        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        #endregion Metodos
    }
}
