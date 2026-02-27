using ACBrLib.Core;
using ACBrLib.Core.Config;
using ACBrLib.Core.IBGE;

namespace ACBrLib.IBGE
{
    /// <summary>
    /// Configurações da biblioteca ACBrLibIBGE.
    /// Permite definir opções como cache, validade dos dados e tratamento de caixa/acento nas pesquisas.
    /// Veja mais em: https://acbr.sourceforge.io/ACBrLib/ConfiguracoesdaBiblioteca9.html
    /// </summary>
    public sealed class ACBrIBGEConfig : ACBrLibConfig<IACBrLibIBGE>
    {
        #region Constructors


        /// <summary>
        /// Inicializa as configurações da biblioteca IBGE.
        /// </summary>
        /// <param name="acbrlib">Instância da interface IBGE.</param>
        public ACBrIBGEConfig(IACBrLibIBGE acbrlib) : base(acbrlib, ACBrSessao.IBGE)
        {
        }

        #endregion Constructors

        #region Properties

        /// <summary>
        /// Define se deve ignorar letras maiúsculas e vogais acentuadas nas pesquisas.
        /// 0 = Não; 1 = Sim
        /// </summary>
        public IgnorarCaixaEAcentos IgnorarCaixaEAcentos
        {
            get => GetProperty<IgnorarCaixaEAcentos>();
            set => SetProperty(value);
        }

        #endregion Properties
    }
}