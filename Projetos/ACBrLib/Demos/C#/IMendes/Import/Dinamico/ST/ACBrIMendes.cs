using System;
using System.Text;
using ACBrLib.Core;

namespace ACBrLib.IMendes
{
    /// <inheritdoc />
    public sealed partial class ACBrIMendes : ACBrLibHandle, IACBrLibIMendes
    {
        #region Constructors

        public ACBrIMendes(string eArqConfig = "", string eChaveCrypt = "") : base(IsWindows ? "ACBrIMendes64.dll" : "libacbrimendes64.so",
                                                                                IsWindows ? "ACBrIMendes32.dll" : "libacbrimendes32.so")
        {
            Inicializar(eArqConfig, eChaveCrypt);
            Config = new ACBrIMendesConfig(this);
        }

        public override void Inicializar(string eArqConfig = "", string eChaveCrypt = "")
        {
            var inicializarLib = GetMethod<IMendes_Inicializar>();
            var ret = ExecuteMethod<int>(() => inicializarLib(ToUTF8(eArqConfig), ToUTF8(eChaveCrypt)));
            CheckResult(ret);
        }

        #endregion Constructors

        #region Properties

        public string Nome
        {
            get
            {
                var bufferLen = BUFFER_LEN;
                var buffer = new StringBuilder(bufferLen);

                var method = GetMethod<IMendes_Nome>();
                var ret = ExecuteMethod(() => method(buffer, ref bufferLen));

                CheckResult(ret);

                return ProcessResult(buffer, bufferLen);
            }
        }

        public string Versao
        {
            get
            {
                var bufferLen = BUFFER_LEN;
                var buffer = new StringBuilder(bufferLen);

                var method = GetMethod<IMendes_Versao>();
                var ret = ExecuteMethod(() => method(buffer, ref bufferLen));

                CheckResult(ret);

                return ProcessResult(buffer, bufferLen);
            }
        }

        public ACBrIMendesConfig Config { get; }

        #endregion Properties

        #region Metodos

        #region Ini

        public override void ConfigGravar(string eArqConfig = "")
        {
            var gravarIni = GetMethod<IMendes_ConfigGravar>();
            var ret = ExecuteMethod(() => gravarIni(ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        public override void ImportarConfig(string eArqConfig)
        {
            var lerIni = GetMethod<IMendes_ConfigImportar>();
            var ret = ExecuteMethod(() => lerIni(ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        public override string ExportarConfig()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = GetMethod<IMendes_ConfigExportar>();
            var ret = ExecuteMethod(() => method(buffer, ref bufferLen));

            CheckResult(ret);

            return ProcessResult(buffer, bufferLen);
        }

        public override void ConfigLer(string eArqConfig = "")
        {
            var lerIni = GetMethod<IMendes_ConfigLer>();
            var ret = ExecuteMethod(() => lerIni(ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        public override T ConfigLerValor<T>(ACBrSessao eSessao, string eChave)
        {
            var method = GetMethod<IMendes_ConfigLerValor>();

            var bufferLen = BUFFER_LEN;
            var pValue = new StringBuilder(bufferLen);
            var ret = ExecuteMethod(() => method(ToUTF8(eSessao.ToString()), ToUTF8(eChave), pValue, ref bufferLen));
            CheckResult(ret);

            var value = ProcessResult(pValue, bufferLen);
            return ConvertValue<T>(value);
        }

        public override void ConfigGravarValor(ACBrSessao eSessao, string eChave, object value)
        {
            if (value == null) return;

            var method = GetMethod<IMendes_ConfigGravarValor>();
            var propValue = ConvertValue(value);

            var ret = ExecuteMethod(() => method(ToUTF8(eSessao.ToString()), ToUTF8(eChave), ToUTF8(propValue)));
            CheckResult(ret);
        }

        #endregion Ini

        #region IMendes

        public string ConsultarDescricao(string eDescricao, string eCNPJ = "", int nTipo = 0)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = GetMethod<IMendes_ConsultarDescricao>();
            var ret = ExecuteMethod(() => method(ToUTF8(eDescricao), ToUTF8(eCNPJ), nTipo, buffer, ref bufferLen));

            CheckResult(ret);

            return ProcessResult(buffer, bufferLen);
        }

        public string ConsultarAlterados(string eUF, string eCNPJ = "", int nLimite = 0)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = GetMethod<IMendes_ConsultarAlterados>();
            var ret = ExecuteMethod(() => method(ToUTF8(eUF), ToUTF8(eCNPJ), nLimite, buffer, ref bufferLen));

            CheckResult(ret);

            return ProcessResult(buffer, bufferLen);
        }

        public string HistoricoAcesso(string eCNPJ = "")
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = GetMethod<IMendes_HistoricoAcesso>();
            var ret = ExecuteMethod(() => method(ToUTF8(eCNPJ), buffer, ref bufferLen));

            CheckResult(ret);

            return ProcessResult(buffer, bufferLen);
        }

        public string ConsultarRegimesEspeciais(string eUF, bool bIncludeTrib = false)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = GetMethod<IMendes_ConsultarRegimesEspeciais>();
            var ret = ExecuteMethod(() => method(ToUTF8(eUF), bIncludeTrib, buffer, ref bufferLen));

            CheckResult(ret);

            return ProcessResult(buffer, bufferLen);
        }

        public string SaneamentoGrades(string eArquivoOuIni)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = GetMethod<IMendes_SaneamentoGrades>();
            var ret = ExecuteMethod(() => method(ToUTF8(eArquivoOuIni), buffer, ref bufferLen));

            CheckResult(ret);

            return ProcessResult(buffer, bufferLen);
        }

        public string Inativar(string eArquivoOuIni)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = GetMethod<IMendes_Inativar>();
            var ret = ExecuteMethod(() => method(ToUTF8(eArquivoOuIni), buffer, ref bufferLen));

            CheckResult(ret);

            return ProcessResult(buffer, bufferLen);
        }

        public string RemoveDevolvidos(string eArquivoOuIni)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = GetMethod<IMendes_RemoveDevolvidos>();
            var ret = ExecuteMethod(() => method(ToUTF8(eArquivoOuIni), buffer, ref bufferLen));

            CheckResult(ret);

            return ProcessResult(buffer, bufferLen);
        }

        #endregion IMendes

        #region Private Methods

        public override void Finalizar()
        {
            var finalizarLib = GetMethod<IMendes_Finalizar>();
            var codRet = ExecuteMethod(() => finalizarLib());
            CheckResult(codRet);
        }

        protected override string GetUltimoRetorno(int iniBufferLen = 0)
        {
            var bufferLen = iniBufferLen < 1 ? BUFFER_LEN : iniBufferLen;
            var buffer = new StringBuilder(bufferLen);
            var ultimoRetorno = GetMethod<IMendes_UltimoRetorno>();

            if (iniBufferLen < 1)
            {
                ExecuteMethod(() => ultimoRetorno(buffer, ref bufferLen));
                if (bufferLen <= BUFFER_LEN) return FromUTF8(buffer);

                buffer.Capacity = bufferLen;
            }

            ExecuteMethod(() => ultimoRetorno(buffer, ref bufferLen));
            return FromUTF8(buffer);
        }

        public override string OpenSSLInfo()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = GetMethod<IMendes_OpenSSLInfo>();
            var ret = ExecuteMethod(() => method(buffer, ref bufferLen));

            CheckResult(ret);

            return ProcessResult(buffer, bufferLen);
        }

        #endregion Private Methods

        #endregion Metodos
    }
}
