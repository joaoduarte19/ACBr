using ACBrLib.Core;
using ACBrLib.Core.Config;

namespace ACBrLib.ConsultaCNPJ
{
    /// <summary>
    /// Representa as configurações específicas da biblioteca ACBrConsultaCNPJ.
    /// <para>
    /// Permite definir o provedor de consulta, usuário e senha, conforme documentação oficial da ACBrLib.
    /// </para>
    /// <para>
    /// Consulte: https://acbr.sourceforge.io/ACBrLib/ConfiguracoesdaBiblioteca20.html
    /// </para>
    /// </summary>
    public sealed class ACBrCNPJConfig : ACBrLibConfig<IACBrLibConsultaCNPJ>
    {
        #region Constructors

        /// <summary>
        /// Inicializa uma nova instância da classe <see cref="ACBrCNPJConfig"/> para configuração da biblioteca ACBrConsultaCNPJ.
        /// </summary>
        /// <param name="acbrlib">Instância da interface de alto nível da biblioteca ACBrConsultaCNPJ.</param>
        public ACBrCNPJConfig(IACBrLibConsultaCNPJ acbrlib) : base(acbrlib, ACBrSessao.ConsultaCNPJ)
        {
        }

        #endregion Constructors

        #region Properties

        /// <summary>
        /// Define qual provedor será utilizado para a consulta de CNPJ.
        /// <para>
        /// Valores possíveis:
        /// 0 = cwsNenhum
        /// 1 = cwsBrasilAPI
        /// 2 = cwsReceitaWS
        /// 3 = cwsCNPJWS
        /// 4 = cwsMinhaReceita
        /// </para>
        /// </summary>
        public int Provedor
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Usuário utilizado pelo provedor selecionado, caso seja exigido autenticação.
        /// </summary>
        public string Usuario
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Senha utilizada pelo provedor selecionado, caso seja exigido autenticação.
        /// </summary>
        public string Senha
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        #endregion Properties
    }
}