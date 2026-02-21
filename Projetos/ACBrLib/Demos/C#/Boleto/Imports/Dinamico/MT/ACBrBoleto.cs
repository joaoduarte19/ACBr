using System;
using System.IO;
using System.Net.Security;
using System.Text;
using ACBrLib.Core;
using ACBrLib.Core.Boleto;

namespace ACBrLib.Boleto
{
    /// <summary>
    /// Classe de integração com ACBrLibBoleto para manipulação de boletos.
    /// Implementa métodos de alto nível conforme interface IACBrLibBoleto.
    /// </summary>
    public class ACBrBoleto : ACBrLibBase, IACBrLibBoleto
    {
        private readonly ACBrBoletoHandle acbrBoletoBridge;
        private bool disposed = false;
        private IntPtr libHandle = IntPtr.Zero;
        #region Constructors

        /// <summary>
        /// Inicializa uma nova instância da classe ACBrBoleto.
        /// </summary>
        /// <param name="eArqConfig">Arquivo de configuração opcional.</param>
        /// <param name="eChaveCrypt">Chave de criptografia opcional.</param>
        public ACBrBoleto(string eArqConfig = "", string eChaveCrypt = "") : base(eArqConfig, eChaveCrypt)
        {
            acbrBoletoBridge = ACBrBoletoHandle.Instance;
            Inicializar(eArqConfig, eChaveCrypt);
            Config = new ACBrBoletoConfig(this);
        }

        /// <inheritdoc/>
        public override void Inicializar(string eArqConfig = "", string eChaveCrypt = "")
        {
            var inicializarLib = acbrBoletoBridge.GetMethod<ACBrBoletoHandle.Boleto_Inicializar>();
            var ret = acbrBoletoBridge.ExecuteMethod<int>(() => inicializarLib(ref libHandle, ToUTF8(eArqConfig), ToUTF8(eChaveCrypt)));
            CheckResult(ret);
        }

        #endregion Constructors

        #region Properties

        /// <inheritdoc/>
        public ACBrBoletoConfig Config { get; }

        #endregion Properties

        #region Methods

        #region Ini

        /// <inheritdoc/>
        public override void ConfigGravar(string eArqConfig = "")
        {
            var gravarIni = acbrBoletoBridge.GetMethod<ACBrBoletoHandle.Boleto_ConfigGravar>();
            var ret = acbrBoletoBridge.ExecuteMethod(() => gravarIni(libHandle, ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public override void ConfigLer(string eArqConfig = "")
        {
            var lerIni = acbrBoletoBridge.GetMethod<ACBrBoletoHandle.Boleto_ConfigLer>();
            var ret = acbrBoletoBridge.ExecuteMethod(() => lerIni(libHandle, ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public override void ImportarConfig(string eArqConfig = "")
        {
            var importarConfig = acbrBoletoBridge.GetMethod<ACBrBoletoHandle.Boleto_ConfigImportar>();
            var ret = acbrBoletoBridge.ExecuteMethod(() => importarConfig(libHandle, ToUTF8(eArqConfig)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public override string ExportarConfig()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrBoletoBridge.GetMethod<ACBrBoletoHandle.Boleto_ConfigExportar>();
            var ret = acbrBoletoBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        #endregion Ini

        /// <inheritdoc/>
        public void ConfigurarDados(params BoletoInfo[] infos)
        {
            var iniFile = new ACBrIniFile();
            foreach (var info in infos)
                info.WriteToIni(iniFile);

            ConfigurarDados(iniFile.ToString());
        }

        /// <inheritdoc/>
        public void ConfigurarDados(string eArquivoIni)
        {
            var method = acbrBoletoBridge.GetMethod<ACBrBoletoHandle.Boleto_ConfigurarDados>();
            var ret = acbrBoletoBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eArquivoIni)));

            CheckResult(ret);
        }

        /// <inheritdoc/>
        public void IncluirTitulos(params Titulo[] titulos)
        {
            var iniFile = new ACBrIniFile();
            for (var i = 0; i < titulos.Length; i++)
            {
                titulos[i].Index = i + 1;
                titulos[i].WriteToIni(iniFile);
            }

            IncluirTitulos(iniFile.ToString());
        }
        /// <inheritdoc/>
        public void IncluirTitulos(BoletoTpSaida eTpSaida, params Titulo[] titulos)
        {
            var iniFile = new ACBrIniFile();
            for (var i = 0; i < titulos.Length; i++)
            {
                titulos[i].Index = i + 1;
                titulos[i].WriteToIni(iniFile);
            }

            IncluirTitulos(iniFile.ToString(), eTpSaida);
        }
        /// <inheritdoc/>
        public void IncluirTitulos(string eArquivoIni, BoletoTpSaida? eTpSaida = null)
        {
            var tpSaida = $"{(eTpSaida.HasValue ? (char)eTpSaida.Value : ' ')}";

            var method = acbrBoletoBridge.GetMethod<ACBrBoletoHandle.Boleto_IncluirTitulos>();
            var ret = acbrBoletoBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eArquivoIni), ToUTF8(tpSaida)));

            CheckResult(ret);
        }
        /// <inheritdoc/>
        public void LimparLista()
        {
            var method = acbrBoletoBridge.GetMethod<ACBrBoletoHandle.Boleto_LimparLista>();
            var ret = acbrBoletoBridge.ExecuteMethod(() => method(libHandle));
            CheckResult(ret);
        }
        /// <inheritdoc/>
        public int TotalTitulosLista()
        {
            var method = acbrBoletoBridge.GetMethod<ACBrBoletoHandle.Boleto_TotalTitulosLista>();
            var ret = acbrBoletoBridge.ExecuteMethod(() => method(libHandle));

            CheckResult(ret);

            return ret;
        }
        /// <inheritdoc/>
        public void Imprimir(string eNomeImpressora = "")
        {
            var method = acbrBoletoBridge.GetMethod<ACBrBoletoHandle.Boleto_Imprimir>();
            var ret = acbrBoletoBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eNomeImpressora)));
            CheckResult(ret);
        }
        /// <inheritdoc/>
        public void Imprimir(int indice, string eNomeImpressora = "")
        {
            var method = acbrBoletoBridge.GetMethod<ACBrBoletoHandle.Boleto_ImprimirBoleto>();
            var ret = acbrBoletoBridge.ExecuteMethod(() => method(libHandle, indice, ToUTF8(eNomeImpressora)));
            CheckResult(ret);
        }
        /// <inheritdoc/>
        public void GerarPDF()
        {
            var method = acbrBoletoBridge.GetMethod<ACBrBoletoHandle.Boleto_GerarPDF>();
            var ret = acbrBoletoBridge.ExecuteMethod(() => method(libHandle));
            CheckResult(ret);
        }
        /// <inheritdoc/>
        public void GerarPDF(Stream aStream)
        {
            if (aStream == null) throw new ArgumentNullException(nameof(aStream));

            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrBoletoBridge.GetMethod<ACBrBoletoHandle.Boleto_SalvarPDF>();
            var ret = acbrBoletoBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            var pdf = CheckBuffer(buffer, bufferLen);
            Base64ToStream(pdf, aStream);
        }
        /// <inheritdoc/>
        public void GerarPDF(int indice)
        {
            var method = acbrBoletoBridge.GetMethod<ACBrBoletoHandle.Boleto_GerarPDFBoleto>();
            var ret = acbrBoletoBridge.ExecuteMethod(() => method(libHandle, indice));
            CheckResult(ret);
        }
        /// <inheritdoc/>
        public string GerarToken()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrBoletoBridge.GetMethod<ACBrBoletoHandle.Boleto_GerarToken>();
            var ret = acbrBoletoBridge.ExecuteMethod<int>(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }
        /// <inheritdoc/>
        public string InformarToken(string eToken, DateTime eData)
        {

            var method = acbrBoletoBridge.GetMethod<ACBrBoletoHandle.Boleto_InformarToken>();
            var ret = acbrBoletoBridge.ExecuteMethod<int>(() => method(libHandle, eToken, eData));

            CheckResult(ret);
            return ret.ToString();

        }
        /// <inheritdoc/>
        public void GerarPDF(int indice, Stream aStream)
        {
            if (aStream == null) throw new ArgumentNullException(nameof(aStream));

            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrBoletoBridge.GetMethod<ACBrBoletoHandle.Boleto_SalvarPDFBoleto>();
            var ret = acbrBoletoBridge.ExecuteMethod(() => method(libHandle, indice, buffer, ref bufferLen));

            CheckResult(ret);

            var pdf = CheckBuffer(buffer, bufferLen);
            Base64ToStream(pdf, aStream);
        }


        public void GerarHTML()
        {
            var method = acbrBoletoBridge.GetMethod<ACBrBoletoHandle.Boleto_GerarHTML>();
            var ret = acbrBoletoBridge.ExecuteMethod(() => method(libHandle));
            CheckResult(ret);
        }
        /// <inheritdoc/>
        public void GerarRemessa(string eDir, int eNumArquivo, string eNomeArq)
        {
            var method = acbrBoletoBridge.GetMethod<ACBrBoletoHandle.Boleto_GerarRemessa>();
            var ret = acbrBoletoBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eDir), eNumArquivo, ToUTF8(eNomeArq)));

            CheckResult(ret);
        }
        /// <inheritdoc/>

        public void GerarRemessaStream(int eNumArquivo, Stream aStream)
        {
            if (aStream == null) throw new ArgumentNullException(nameof(aStream));

            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrBoletoBridge.GetMethod<ACBrBoletoHandle.Boleto_GerarRemessaStream>();
            var ret = acbrBoletoBridge.ExecuteMethod(() => method(libHandle, eNumArquivo, buffer, ref bufferLen));

            CheckResult(ret);

            var rem = CheckBuffer(buffer, bufferLen);
            Base64ToStream(rem, aStream);
        }
        /// <inheritdoc/>
        public RetornoBoleto ObterRetorno(string eDir, string eNomeArq)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrBoletoBridge.GetMethod<ACBrBoletoHandle.Boleto_ObterRetorno>();
            var ret = acbrBoletoBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eDir), ToUTF8(eNomeArq), buffer, ref bufferLen));

            CheckResult(ret);

            return RetornoBoleto.LerRetorno(CheckBuffer(buffer, bufferLen));
        }
        /// <inheritdoc/>

        public void LerRetorno(string eDir, string eNomeArq)
        {
            var method = acbrBoletoBridge.GetMethod<ACBrBoletoHandle.Boleto_LerRetorno>();
            var ret = acbrBoletoBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eDir), ToUTF8(eNomeArq)));

            CheckResult(ret);
        }
        /// <inheritdoc/>

        public string LerRetornoStream(string ARetornoBase64)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrBoletoBridge.GetMethod<ACBrBoletoHandle.Boleto_LerRetornoStream>();
            var ret = acbrBoletoBridge.ExecuteMethod(() => method(libHandle, ToUTF8(ARetornoBase64), buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc/>
        public void EnviarEmail(string ePara, string eAssunto, string eMensagem, string eCC)
        {
            var method = acbrBoletoBridge.GetMethod<ACBrBoletoHandle.Boleto_EnviarEmail>();
            var ret = acbrBoletoBridge.ExecuteMethod(() => method(libHandle, ToUTF8(ePara), ToUTF8(eAssunto), ToUTF8(eMensagem), ToUTF8(eCC)));

            CheckResult(ret);
        }

        /// <inheritdoc/>

        public void EnviarEmailBoleto(int eIndex, string ePara, string eAssunto, string eMensagem, string eCC)
        {
            var method = acbrBoletoBridge.GetMethod<ACBrBoletoHandle.Boleto_EnviarEmailBoleto>();
            var ret = acbrBoletoBridge.ExecuteMethod(() => method(libHandle, eIndex, ToUTF8(ePara), ToUTF8(eAssunto), ToUTF8(eMensagem), ToUTF8(eCC)));

            CheckResult(ret);
        }

        public void SetDiretorioArquivo(string eDir, string eArq = "")
        {
            var method = acbrBoletoBridge.GetMethod<ACBrBoletoHandle.Boleto_SetDiretorioArquivo>();
            var ret = acbrBoletoBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eDir), ToUTF8(eArq)));

            CheckResult(ret);
        }
        /// <inheritdoc/>
        public string[] ListaBancos()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrBoletoBridge.GetMethod<ACBrBoletoHandle.Boleto_ListaBancos>();
            var ret = acbrBoletoBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen).Split('|');
        }
        /// <inheritdoc/>
        public string[] ListaCaractTitulo()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrBoletoBridge.GetMethod<ACBrBoletoHandle.Boleto_ListaCaractTitulo>();
            var ret = acbrBoletoBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen).Split('|');
        }
        /// <inheritdoc/>
        public string[] ListaOcorrencias()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrBoletoBridge.GetMethod<ACBrBoletoHandle.Boleto_ListaOcorrencias>();
            var ret = acbrBoletoBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen).Split('|');
        }

        /// <inheritdoc/>

        public string[] ListaOcorrenciasEX()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrBoletoBridge.GetMethod<ACBrBoletoHandle.Boleto_ListaOcorrenciasEX>();
            var ret = acbrBoletoBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen).Split('|');
        }

        /// <inheritdoc/>

        public int TamNossoNumero(string eCarteira, string enossoNumero, string eConvenio)
        {
            var method = acbrBoletoBridge.GetMethod<ACBrBoletoHandle.Boleto_TamNossoNumero>();
            var ret = acbrBoletoBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eCarteira), ToUTF8(enossoNumero), ToUTF8(eConvenio)));

            CheckResult(ret);

            return ret;
        }

        public string CodigosMoraAceitos()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrBoletoBridge.GetMethod<ACBrBoletoHandle.Boleto_CodigosMoraAceitos>();
            var ret = acbrBoletoBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }
        /// <inheritdoc/>
        public void SelecionaBanco(string eCodBanco)
        {
            var method = acbrBoletoBridge.GetMethod<ACBrBoletoHandle.Boleto_SelecionaBanco>();
            var ret = acbrBoletoBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eCodBanco)));

            CheckResult(ret);
        }

        /// <inheritdoc/>

        public string MontarNossoNumero(int eIndex)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrBoletoBridge.GetMethod<ACBrBoletoHandle.Boleto_MontarNossoNumero>();
            var ret = acbrBoletoBridge.ExecuteMethod(() => method(libHandle, eIndex, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        /// <inheritdoc/>

        public string RetornaLinhaDigitavel(int eIndex)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrBoletoBridge.GetMethod<ACBrBoletoHandle.Boleto_RetornaLinhaDigitavel>();
            var ret = acbrBoletoBridge.ExecuteMethod(() => method(libHandle, eIndex, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }
        /// <inheritdoc/>
        public string RetornaCodigoBarras(int eIndex)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrBoletoBridge.GetMethod<ACBrBoletoHandle.Boleto_RetornaCodigoBarras>();
            var ret = acbrBoletoBridge.ExecuteMethod(() => method(libHandle, eIndex, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }
        /// <inheritdoc/>
        public RetornoWeb EnviarBoleto(OperacaoBoleto opercao)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrBoletoBridge.GetMethod<ACBrBoletoHandle.Boleto_EnviarBoleto>();
            var ret = acbrBoletoBridge.ExecuteMethod(() => method(libHandle, (int)opercao, buffer, ref bufferLen));

            CheckResult(ret);

            return RetornoWeb.LerRetorno(CheckBuffer(buffer, bufferLen));
        }
        /// <inheritdoc/>
        public string ConsultarTitulosPorPeriodo(string eArquivoIni)
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrBoletoBridge.GetMethod<ACBrBoletoHandle.Boleto_ConsultarTitulosPorPeriodo>();
            var ret = acbrBoletoBridge.ExecuteMethod<int>(() => method(libHandle, eArquivoIni, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }
        /// <inheritdoc/>

        public override string OpenSSLInfo()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrBoletoBridge.GetMethod<ACBrBoletoHandle.Boleto_OpenSSLInfo>();
            var ret = acbrBoletoBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }

        #region Private Methods
        /// <inheritdoc/>
        public override void Finalizar()
        {
            var finalizarLib = acbrBoletoBridge.GetMethod<ACBrBoletoHandle.Boleto_Finalizar>();
            var ret = acbrBoletoBridge.ExecuteMethod(() => finalizarLib(libHandle));
            CheckResult(ret);
            libHandle = IntPtr.Zero;
        }
        /// <inheritdoc/>
        protected override string GetUltimoRetorno(int iniBufferLen = 0)
        {
            var bufferLen = iniBufferLen < 1 ? BUFFER_LEN : iniBufferLen;
            var buffer = new StringBuilder(bufferLen);
            var ultimoRetorno = acbrBoletoBridge.GetMethod<ACBrBoletoHandle.Boleto_UltimoRetorno>();

            if (iniBufferLen < 1)
            {
                acbrBoletoBridge.ExecuteMethod(() => ultimoRetorno(libHandle, buffer, ref bufferLen));
                if (bufferLen <= BUFFER_LEN) return FromUTF8(buffer);

                buffer.Capacity = bufferLen;
            }

            acbrBoletoBridge.ExecuteMethod(() => ultimoRetorno(libHandle, buffer, ref bufferLen));
            return FromUTF8(buffer);
        }
        /// <inheritdoc/>
        public override string ConfigLerValor(string eSessao, string eChave)
        {
            var method = acbrBoletoBridge.GetMethod<ACBrBoletoHandle.Boleto_ConfigLerValor>();

            var bufferLen = BUFFER_LEN;
            var pValue = new StringBuilder(bufferLen);
            var ret = acbrBoletoBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eSessao), ToUTF8(eChave), pValue, ref bufferLen));
            CheckResult(ret);
            return CheckBuffer(pValue, bufferLen);
        }
        /// <inheritdoc/>
        public override void ConfigGravarValor(string eSessao, string eChave, string eValor)
        {
            var method = acbrBoletoBridge.GetMethod<ACBrBoletoHandle.Boleto_ConfigGravarValor>();
            var ret = acbrBoletoBridge.ExecuteMethod(() => method(libHandle, ToUTF8(eSessao), ToUTF8(eChave), ToUTF8(eValor)));
            CheckResult(ret);
        }
        /// <inheritdoc/>
        public override string Versao()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrBoletoBridge.GetMethod<ACBrBoletoHandle.Boleto_Versao>();
            var ret = acbrBoletoBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }
        /// <inheritdoc/>
        public override string Nome()
        {
            var bufferLen = BUFFER_LEN;
            var buffer = new StringBuilder(bufferLen);

            var method = acbrBoletoBridge.GetMethod<ACBrBoletoHandle.Boleto_Nome>();
            var ret = acbrBoletoBridge.ExecuteMethod(() => method(libHandle, buffer, ref bufferLen));

            CheckResult(ret);

            return CheckBuffer(buffer, bufferLen);
        }
        /// <inheritdoc/>
        #endregion Private Methods

        /// <inheritdoc/>
        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }


        /// <inheritdoc/>
        protected void Dispose(bool disposing)
        {
            if (!disposed)
            {
                if (disposing)
                {
                    Finalizar();   // Libera recursos gerenciados
                }
            }

            disposed = true;
        }
        #endregion Methods
    }
}