using ACBrLib.Core;
using ACBrLib.Core.Config;
using ACBrLib.Core.DFe;
using ACBrLib.Core.PIXCD;

namespace ACBrLib.PIXCD
{
    /// <summary>
    /// Configurações específicas do PSP PagSeguro para PIXCD.
    /// Veja todas as chaves e descrições em: https://acbr.sourceforge.io/ACBrLib/ConfiguracoesdaBiblioteca23.html
    /// </summary>
    public sealed class PagSeguroConfig : ACBrLibConfigBase<IACBrLibPIXCD>
    {
        #region Constructors

        /// <summary>
        /// Inicializa as configurações do PSP PagSeguro.
        /// </summary>
        /// <param name="acbrlib">Instância da interface PIXCD.</param>
        public PagSeguroConfig(IACBrLibPIXCD acbrlib) : base(acbrlib, ACBrSessao.PagSeguro)
        {
        }

        #endregion Constructors

        #region Properties

        /// <summary>
        /// Chave PIX utilizada para transações.
        /// </summary>
        public string ChavePIX
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// ClientID para autenticação no PagSeguro.
        /// </summary>
        public string ClientID
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// ClientSecret para autenticação no PagSeguro.
        /// </summary>
        public string ClientSecret
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Caminho do arquivo de chave privada.
        /// </summary>
        public string ArqChavePrivada
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Caminho do arquivo de certificado.
        /// </summary>
        public string ArqCertificado
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Scopes enviados para a API. Exemplo: [scCobWrite,scCobRead,scPixWrite,scPixRead]
        /// </summary>
        public string Scopes
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        #endregion Properties
    }
}