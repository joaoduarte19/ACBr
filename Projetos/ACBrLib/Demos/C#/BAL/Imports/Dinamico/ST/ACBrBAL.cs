using System.Text;
using ACBrLib.Core;

namespace ACBrLib.BAL
{
    /// <summary>
    /// Implementação da interface IACBrLibBAL para comunicação com balanças via ACBrLib (ST).
    /// Responsável por encapsular as operações de configuração, ativação, leitura e interpretação de peso.
    /// </summary>
    public sealed partial class ACBrBAL : ACBrLibHandle, IACBrLibBAL
    {
        #region Constructors

        /// <summary>
        /// Inicializa uma nova instância da classe <see cref="ACBrBAL"/> (ST).
        /// </summary>
        /// <param name="eArqConfig">Caminho do arquivo de configuração INI.</param>
        /// <param name="eChaveCrypt">Chave de criptografia para o arquivo de configuração.</param>
        public ACBrBAL(string eArqConfig = "", string eChaveCrypt = "") : base(IsWindows ? "ACBrBAL64.dll" : "libacbrbal64.so",
                                                                               IsWindows ? "ACBrBAL32.dll" : "libacbrbal32.so")
        {
            Inicializar(eArqConfig, eChaveCrypt);
            Config = new BALConfig(this);
        }

        /// <inheritdoc/>
        public override void Inicializar(string eArqConfig = "", string eChaveCrypt = "")
        {
            var inicializarLib = GetMethod<BAL_Inicializar>();
            var ret = ExecuteMethod<int>(() => inicializarLib(ToUTF8(eArqConfig), ToUTF8(eChaveCrypt)));
            CheckResult(ret);
        }

        #endregion Constructors

        #region Properties

        /// <summary>
        /// Retorna o nome da biblioteca ACBrLibBAL carregada.
        /// </summary>
        public string Nome
        {
            get
            {
                var bufferLen = BUFFER_LEN;
                var buffer = new StringBuilder(bufferLen);

                var method = GetMethod<BAL_Nome>();
                var ret = ExecuteMethod(() => method(buffer, ref bufferLen));

                CheckResult(ret);

                return ProcessResult(buffer, bufferLen);
            }
        }

        /// <summary>
        /// Retorna a versão da biblioteca ACBrLibBAL carregada.
        /// </summary>
        public string Versao
        {
            get
            {
                var bufferLen = BUFFER_LEN;
                var buffer = new StringBuilder(bufferLen);

                var method = GetMethod<BAL_Versao>();
                var ret = ExecuteMethod(() => method(buffer, ref bufferLen));

                CheckResult(ret);

                return ProcessResult(buffer, bufferLen);
            }
        }

        /// <inheritdoc/>
        public BALConfig Config { get; }

        #endregion Properties

        #region Methods

        #region Ini

        /// <inheritdoc/>
        public override void ConfigGravar(string eArqConfig = "")
        {
            var gravarIni = GetMethod<BAL_ConfigGravar>();
            var ret = ExecuteMethod(() => gravarIni(ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public override void ConfigLer(string eArqConfig = "")
        {
            var lerIni = GetMethod<BAL_ConfigLer>();
            var ret = ExecuteMethod(() => lerIni(ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public override T ConfigLerValor<T>(ACBrSessao eSessao, string eChave)
        {
            var method = GetMethod<BAL_ConfigLerValor>();

            var bufferLen = BUFFER_LEN;
            var pValue = new StringBuilder(bufferLen);
            var ret = ExecuteMethod(() => method(ToUTF8(eSessao.ToString()), ToUTF8(eChave), pValue, ref bufferLen));
            CheckResult(ret);

            var value = ProcessResult(pValue, bufferLen);
            return ConvertValue<T>(value);
        }

        /// <inheritdoc/>
        public override void ConfigGravarValor(ACBrSessao eSessao, string eChave, object value)
        {
            if (value == null) return;

            var method = GetMethod<BAL_ConfigGravarValor>();
            var propValue = ConvertValue(value);

            var ret = ExecuteMethod(() => method(ToUTF8(eSessao.ToString()), ToUTF8(eChave), ToUTF8(propValue)));
            CheckResult(ret);
        }

        /// <inheritdoc/>
        public override void ImportarConfig(string eArqConfig = "")
        {
            var importarConfig = GetMethod<BAL_ConfigImportar>();
            var ret = ExecuteMethod(() => importarConfig(ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public override string ExportarConfig()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = GetMethod<BAL_ConfigExportar>();
            var ret = ExecuteMethod(() => method(buffer, ref bufferLen));

            CheckResult(ret);

            return ProcessResult(buffer, bufferLen);
        }

        #endregion Ini

        /// <inheritdoc/>
        public void Ativar()
        {
            var method = GetMethod<BAL_Ativar>();
            var ret = ExecuteMethod(() => method());

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void Desativar()
        {
            var method = GetMethod<BAL_Desativar>();
            var ret = ExecuteMethod(() => method());

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public decimal LePeso(int MillisecTimeOut = 1000)
        {
            var peso = 0D;
            var method = GetMethod<BAL_LePeso>();
            var ret = ExecuteMethod(() => method(MillisecTimeOut, ref peso));

            CheckResult(ret);

            return (decimal)peso;
        }

        /// <inheritdoc/>
        public void SolicitarPeso()
        {
            var method = GetMethod<BAL_SolicitarPeso>();
            var ret = ExecuteMethod(() => method());

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public decimal UltimoPesoLido()
        {
            var peso = 0D;
            var method = GetMethod<BAL_UltimoPesoLido>();
            var ret = ExecuteMethod(() => method(ref peso));

            CheckResult(ret);

            return (decimal)peso;
        }

        /// <inheritdoc/>
        public decimal InterpretarRespostaPeso(string resposta)
        {
            var peso = 0D;
            var method = GetMethod<BAL_InterpretarRespostaPeso>();
            var ret = ExecuteMethod(() => method(ToUTF8(resposta), ref peso));

            CheckResult(ret);

            return (decimal)peso;
        }

        #region Private Methods

        /// <inheritdoc/>
        public override void Finalizar()
        {
            var finalizarLib = GetMethod<BAL_Finalizar>();
            var ret = ExecuteMethod(() => finalizarLib());
            CheckResult(ret);
        }

        /// <inheritdoc/>
        protected override string GetUltimoRetorno(int iniBufferLen = 0)
        {
            var bufferLen = iniBufferLen < 1 ? BUFFER_LEN : iniBufferLen;
            var buffer = new StringBuilder(bufferLen);
            var ultimoRetorno = GetMethod<BAL_UltimoRetorno>();

            if (iniBufferLen < 1)
            {
                ExecuteMethod(() => ultimoRetorno(buffer, ref bufferLen));
                if (bufferLen <= BUFFER_LEN) return FromUTF8(buffer);

                buffer.Capacity = bufferLen;
            }

            ExecuteMethod(() => ultimoRetorno(buffer, ref bufferLen));
            return FromUTF8(buffer);
        }

        #endregion Private Methods


        /// <inheritdoc/>
        public override string OpenSSLInfo()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = GetMethod<BAL_OpenSSLInfo>();
            var ret = ExecuteMethod(() => method(buffer, ref bufferLen));

            CheckResult(ret);

            return ProcessResult(buffer, bufferLen);
        }

        #endregion Methods
    }
}