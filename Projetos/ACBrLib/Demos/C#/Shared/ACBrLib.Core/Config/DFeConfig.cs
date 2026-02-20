using System.IO;
using ACBrLib.Core.DFe;

namespace ACBrLib.Core.Config
{
    /// <summary>
    /// Configurações da sessão DFe da ACBrLib.
    /// <para>Utilizada pelas Libs que emitem Documentos Fiscais Eletrônicos.</para>
    /// <para>Veja mais em: https://acbr.sourceforge.io/ACBrLib/DFe.html</para>
    /// </summary>
    public sealed class DFeConfig<TLib> : ACBrLibConfigBase<TLib> where TLib : IACBrLibBase
    {
        #region Constructors

        /// <summary>
        /// Inicializa a configuração DFe.
        /// </summary>
        /// <param name="acbrlib">Instância da biblioteca ACBrLib.</param>
        public DFeConfig(TLib acbrlib) : base(acbrlib, ACBrSessao.DFe)
        {
        }

        #endregion Constructors

        #region Properties

        /// <summary>
        /// Caminho e nome do arquivo PFX do certificado digital.
        /// </summary>
        public string ArquivoPFX
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Número de série do certificado digital.
        /// </summary>
        public string NumeroSerie
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Dados PFX do certificado digital.
        /// </summary>
        public string DadosPFX
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Senha do certificado digital.
        /// </summary>
        public string Senha
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Verifica a validade do certificado digital. 0 = Não, 1 = Sim
        /// </summary>
        public bool VerificarValidade
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define o engine da biblioteca de criptografia.
        /// <para>0 = cryNone, 1 = cryOpenSSL, 2 = cryCapicom, 3 = cryWinCrypt</para>
        /// </summary>
        public SSLCryptLib SSLCryptLib
        {
            get => GetProperty<SSLCryptLib>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define a API de comunicação segura.
        /// <para>0 = httpNone, 1 = httpWinINet, 2 = httpWinHttp, 3 = httpOpenSSL, 4 = httpIndy</para>
        /// </summary>
        public SSLHttpLib SSLHttpLib
        {
            get => GetProperty<SSLHttpLib>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define a API de manipulação do XML para assinatura digital.
        /// <para>0 = xsNone, 1 = xsXmlSec, 2 = xsMsXml, 3 = xsMsXmlCapicom, 4 = xsLibXml2</para>
        /// </summary>
        public SSLXmlSignLib SSLXmlSignLib
        {
            get => GetProperty<SSLXmlSignLib>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Sigla da UF do emitente.
        /// </summary>
        public string UF
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define a configuração de fuso horário.
        /// <para>0 = tzSistema, 1 = tzPCN, 2 = tzManual</para>
        /// </summary>
        public TimezoneMode TimeZoneModo
        {
            get => GetProperty<TimezoneMode>("TimeZone.Modo");
            set => SetProperty(value, "TimeZone.Modo");
        }

        /// <summary>
        /// Retorna o valor do TimeZone quando o mesmo for manual. Ex.: -03:00
        /// </summary>
        public string TimeZoneStr
        {
            get => GetProperty<string>("TimeZone.Str");
            set => SetProperty(value, "TimeZone.Str");
        }

        #endregion Properties
    }
}