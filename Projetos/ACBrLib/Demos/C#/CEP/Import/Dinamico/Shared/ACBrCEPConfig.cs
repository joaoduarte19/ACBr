using ACBrLib.Core;
using ACBrLib.Core.Config;
using ACBrLib.Core.CEP;

namespace ACBrLib.CEP
{
    /// <summary>
    /// Configurações da biblioteca ACBrLibCEP.
    /// Baseado na documentação oficial: https://acbr.sourceforge.io/ACBrLib/ConfiguracoesdaBiblioteca8.html
    /// </summary>
    public sealed class ACBrCEPConfig : ACBrLibConfig<IACBrLibCEP>
    {
        #region Constructors
        /// <summary>
        /// Construtor da classe ACBrCEPConfig, responsável por inicializar as configurações do componente ACBrCEP.
        /// </summary>
        /// <param name="acbrlib">Instância de uma implementação da interface <see cref="IACBrLibCEP"/>.</param>
        public ACBrCEPConfig(IACBrLibCEP acbrlib) : base(acbrlib, ACBrSessao.CEP)
        {
        }

        #endregion Constructors

        #region Properties

        /// <summary>
        /// Define qual será o webservice a ser utilizado para realizar a consulta.
        /// Valores possíveis:
        /// 1 = wsBuscarCep, 2 = wsCepLivre, 3 = wsRepublicaVirtual, 4 = wsBases4you, 5 = wsRNSolucoes,
        /// 6 = wsKingHost, 7 = wsByJG, 8 = wsCorreios, 9 = wsDevMedia, 10 = wsViaCep, 11 = wsCorreiosSIGEP,
        /// 12 = wsCepAberto, 13 = wsWSCep, 14 = wsOpenCep, 15 = wsBrasilAPI, 16 = wsCepAwesomeAPI
        /// </summary>
        public WebService WebService
        {
            get => GetProperty<WebService>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Chave de acesso necessária por alguns webservices.
        /// </summary>
        public string ChaveAcesso
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Nome do usuário necessário para poder usar alguns webservices.
        /// </summary>
        public string Usuario
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Senha necessária para poder usar alguns webservices.
        /// </summary>
        public string Senha
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Define se deve ou não pesquisar pelo código IBGE.
        /// 0 = Não; 1 = Sim
        /// </summary>
        public bool PesquisarIBGE
        {
            get => GetProperty<bool>();
            set => SetProperty(value);
        }

        #endregion Properties
    }
}