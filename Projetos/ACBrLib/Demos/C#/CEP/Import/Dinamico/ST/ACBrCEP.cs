using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using ACBrLib.Core;
using ACBrLib.Core.CEP;
using ACBrLib.CEP;

namespace ACBrLib.CEP
{
    /// <Summary>
    /// Classe principal da biblioteca ACBrLibCEP, responsável por fornecer os métodos e propriedades para interação com o componente de consulta de CEP.
    /// Baseado na documentação oficial: https://acbr.sourceforge.io/ACBrLib/MetodosCEP.html
    /// </Summary>
    public sealed partial class ACBrCEP : ACBrLibHandle, IACBrLibCEP
    {
        #region Constructors
        
        /// <inheritdoc/>
        public ACBrCEP(string eArqConfig = "", string eChaveCrypt = "") : base(IsWindows ? "ACBrCEP64.dll" : "libacbrcep64.so",
                                                                                      IsWindows ? "ACBrCEP32.dll" : "libacbrcep32.so")
        {
            Inicializar(eArqConfig, eChaveCrypt);
            Config = new ACBrCEPConfig(this);
        }

        /// <inheritdoc/>
        public override void Inicializar(string eArqConfig = "", string eChaveCrypt = "")
        {
            var inicializarLib = GetMethod<CEP_Inicializar>();
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

                var method = GetMethod<CEP_Nome>();
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

                var method = GetMethod<CEP_Versao>();
                var ret = ExecuteMethod(() => method(buffer, ref bufferLen));

                CheckResult(ret);

                return ProcessResult(buffer, bufferLen);
            }
        }

        public ACBrCEPConfig Config { get; }

        #endregion Properties

        #region Metodos

        #region Ini

        /// <inheritdoc/>
        public override void ConfigGravar(string eArqConfig = "")
        {
            var gravarIni = GetMethod<CEP_ConfigGravar>();
            var ret = ExecuteMethod(() => gravarIni(ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public override void ImportarConfig(string eArqConfig)
        {
            var lerIni = GetMethod<CEP_ConfigImportar>();
            var ret = ExecuteMethod(() => lerIni(ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public override string ExportarConfig()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = GetMethod<CEP_ConfigExportar>();
            var ret = ExecuteMethod(() => method(buffer, ref bufferLen));

            CheckResult(ret);

            return ProcessResult(buffer, bufferLen);
        }

        /// <inheritdoc/>
        public override void ConfigLer(string eArqConfig = "")
        {
            var lerIni = GetMethod<CEP_ConfigLer>();
            var ret = ExecuteMethod(() => lerIni(ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public override T ConfigLerValor<T>(ACBrSessao eSessao, string eChave)
        {
            var method = GetMethod<CEP_ConfigLerValor>();

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

            var method = GetMethod<CEP_ConfigGravarValor>();
            var propValue = ConvertValue(value);

            var ret = ExecuteMethod(() => method(ToUTF8(eSessao.ToString()), ToUTF8(eChave), ToUTF8(propValue)));
            CheckResult(ret);
        }

        #endregion Ini

        #region Diversos

        /// <inheritdoc/>
        public ACBrEndereco BuscarPorCep(string eCEP)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = GetMethod<CEP_BuscarPorCEP>();
            var ret = ExecuteMethod(() => method(ToUTF8(eCEP), buffer, ref bufferLen));

            CheckResult(ret);

            var ini = ACBrIniFile.Parse(ProcessResult(buffer, bufferLen));
            return ini.Where(x => x.Name.StartsWith("Endereco")).Select(ACBrEndereco.LerResposta).SingleOrDefault();
        }

        /// <inheritdoc/>
        public ACBrEndereco[] BuscarPorLogradouro(string eCidade, string eTipoLogradouro, string eLogradouro, string eUF, string eBairro)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = GetMethod<CEP_BuscarPorLogradouro>();
            var ret = ExecuteMethod(() => method((ToUTF8(eCidade)), (ToUTF8(eTipoLogradouro)), (ToUTF8(eLogradouro)), (ToUTF8(eUF)), (ToUTF8(eUF)), buffer, ref bufferLen));

            CheckResult(ret);

            var ini = ACBrIniFile.Parse(ProcessResult(buffer, bufferLen));
            return ini.Where(x => x.Name.StartsWith("Endereco")).Select(ACBrEndereco.LerResposta).ToArray();
        }

        #endregion Diversos

        #region Private Methods

        /// <inheritdoc/>
        public override void Finalizar()
        {
            var finalizarLib = GetMethod<CEP_Finalizar>();
            var codRet = ExecuteMethod(() => finalizarLib());
            CheckResult(codRet);
        }

        /// <inheritdoc/>
        protected override string GetUltimoRetorno(int iniBufferLen = 0)
        {
            var bufferLen = iniBufferLen < 1 ? BUFFER_LEN : iniBufferLen;
            var buffer = new StringBuilder(bufferLen);
            var ultimoRetorno = GetMethod<CEP_UltimoRetorno>();

            if (iniBufferLen < 1)
            {
                ExecuteMethod(() => ultimoRetorno(buffer, ref bufferLen));
                if (bufferLen <= BUFFER_LEN) return FromUTF8(buffer);

                buffer.Capacity = bufferLen;
            }

            ExecuteMethod(() => ultimoRetorno(buffer, ref bufferLen));
            return FromUTF8(buffer);
        }

        /// <inheritdoc/>
        public override string OpenSSLInfo()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = GetMethod<CEP_OpenSSLInfo>();
            var ret = ExecuteMethod(() => method(buffer, ref bufferLen));

            CheckResult(ret);

            return ProcessResult(buffer, bufferLen);
        }

        #endregion Private Methods

        #endregion Metodos
    }
}