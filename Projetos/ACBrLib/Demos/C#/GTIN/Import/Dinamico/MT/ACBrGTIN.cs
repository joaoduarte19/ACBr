using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using ACBrLib.Core;
using ACBrLib.GTIN;

namespace ACBrLib.GTIN
{
    /// <summary>
    /// Classe principal para interação com a biblioteca ACBrLibGTIN, fornecendo métodos para inicialização, configuração e consulta de GTINs.
    /// Implementa a interface <see cref="IACBrLibGTIN"/>
    /// </summary>

    public class ACBrGTIN : ACBrLibBase, IACBrLibGTIN
    {

        private IntPtr libHandle = IntPtr.Zero;
        private bool disposed = false;
        private ACBrGTINHandle acbrGTINBridge;

        #region Constructors

        /// <summary>
        /// Inicializa a classe ACBrGTIN, criando uma instância da biblioteca e carregando as configurações iniciais, se fornecidas.
        /// </summary>
        /// <param name="eArqConfig">Caminho para o arquivo de configuração.</param>
        /// <param name="eChaveCrypt">Chave de criptografia para o arquivo de configuração.</param>
        public ACBrGTIN(string eArqConfig = "", string eChaveCrypt = "") : base(eArqConfig, eChaveCrypt)
        {
            acbrGTINBridge = ACBrGTINHandle.Instance;
            Inicializar(eArqConfig, eChaveCrypt);
            Config = new ACBrGTINConfig(this);
        }

        /// <inheritdoc />
        public override void Inicializar(string eArqConfig = "", string eChaveCrypt = "")
        {
            var inicializarLib =acbrGTINBridge. GetMethod<ACBrGTINHandle.GTIN_Inicializar>();
            var ret = acbrGTINBridge.ExecuteMethod<int>(() => inicializarLib(ref libHandle, ToUTF8(eArqConfig), ToUTF8(eChaveCrypt)));
            CheckResult(ret);
        }

        #endregion Constructors

        #region Properties

        /// <inheritdoc />
        public override string Nome()
        {
        
                var bufferLen = BUFFER_LEN;
                var buffer = new StringBuilder(bufferLen);

                var method =acbrGTINBridge. GetMethod<ACBrGTINHandle.GTIN_Nome>();
                var ret = acbrGTINBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

                CheckResult(ret);

                return CheckBuffer(buffer, bufferLen);
        
        }

        /// <inheritdoc />
        public override string Versao() 
        {
           
                var bufferLen = BUFFER_LEN;
                var buffer = new StringBuilder(bufferLen);

                var method =acbrGTINBridge. GetMethod<ACBrGTINHandle.GTIN_Versao>();
                var ret = acbrGTINBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

                CheckResult(ret);

                return CheckBuffer(buffer, bufferLen);
        
        }
        /// <inheritdoc />
        public ACBrGTINConfig Config { get; }

        #endregion Properties

        #region Metodos

        #region Ini
        /// <inheritdoc />
        public override void ConfigGravar(string eArqConfig = "")
        {
            var gravarIni =acbrGTINBridge. GetMethod<ACBrGTINHandle.GTIN_ConfigGravar>();
            var ret = acbrGTINBridge.ExecuteMethod(() => gravarIni(libHandle, ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        /// <inheritdoc />
        public override void ImportarConfig(string eArqConfig)
        {
            var lerIni =acbrGTINBridge. GetMethod<ACBrGTINHandle.GTIN_ConfigImportar>();
            var ret = acbrGTINBridge.ExecuteMethod(() => lerIni(libHandle, ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        /// <inheritdoc />
        public override string ExportarConfig()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method =acbrGTINBridge. GetMethod<ACBrGTINHandle.GTIN_ConfigExportar>();
            var ret = acbrGTINBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc />
        public override void ConfigLer(string eArqConfig = "")
        {
            var lerIni =acbrGTINBridge. GetMethod<ACBrGTINHandle.GTIN_ConfigLer>();
            var ret = acbrGTINBridge.ExecuteMethod(() => lerIni(libHandle, ToUTF8(eArqConfig)));

            CheckResult(ret);
        }


        /// <inheritdoc />
        public override string ConfigLerValor(string eSessao, string eChave)
        {
            var method =acbrGTINBridge. GetMethod<ACBrGTINHandle.GTIN_ConfigLerValor>();

            var bufferLen = BUFFER_LEN;
            var pValue = new StringBuilder(bufferLen);
            var ret = acbrGTINBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eSessao.ToString()), ToUTF8(eChave), pValue, ref bufferLen));
            CheckResult(ret);

            return  CheckBuffer(pValue, bufferLen);        }

        /// <inheritdoc />
        public override void ConfigGravarValor(string eSessao, string eChave, string eValor)
        {
          
            var method =acbrGTINBridge. GetMethod<ACBrGTINHandle.GTIN_ConfigGravarValor>();

            var ret = acbrGTINBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eSessao.ToString()), ToUTF8(eChave), ToUTF8(eValor)));
            CheckResult(ret);
        }
        /// <inheritdoc />
        public override string OpenSSLInfo()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method =acbrGTINBridge. GetMethod<ACBrGTINHandle.GTIN_OpenSSLInfo>();
            var ret = acbrGTINBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        #endregion Ini

        #region Diversos

        /// <inheritdoc />
        public string Consultar(string aGTIN)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method =acbrGTINBridge. GetMethod<ACBrGTINHandle.GTIN_Consultar>();
            var ret = acbrGTINBridge.ExecuteMethod(() => method(libHandle, ToUTF8(aGTIN), buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        #endregion Diversos

        #region Private Methods

        /// <inheritdoc />
        public override void Finalizar()
        {
            var finalizarLib =acbrGTINBridge. GetMethod<ACBrGTINHandle.GTIN_Finalizar>();
            var codRet = acbrGTINBridge.ExecuteMethod(() => finalizarLib(libHandle));
            CheckResult(codRet);
            libHandle = IntPtr.Zero;
        }

        /// <inheritdoc />
        protected override string GetUltimoRetorno(int iniBufferLen = 0)
        {
            var bufferLen = iniBufferLen < 1 ? BUFFER_LEN : iniBufferLen;
            var buffer = new StringBuilder(bufferLen);
            var ultimoRetorno =acbrGTINBridge. GetMethod<ACBrGTINHandle.GTIN_UltimoRetorno>();

            if (iniBufferLen < 1)
            {
                acbrGTINBridge.ExecuteMethod(() => ultimoRetorno(libHandle, buffer, ref bufferLen));
                if (bufferLen <= BUFFER_LEN) return FromUTF8(buffer);

                buffer.Capacity = bufferLen;
            }

            acbrGTINBridge.ExecuteMethod(() => ultimoRetorno(libHandle, buffer, ref bufferLen));
            return FromUTF8(buffer);
        }

        #endregion Private Methods

        /// <inheritdoc/>
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
        /// Libera os recursos utilizados pela classe ACBrGTIN
        /// </summary>
        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
        #endregion Metodos

    }
}