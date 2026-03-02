using ACBrLib.Core;
using ACBrLib.Core.Config;

namespace ACBrLib.Sedex
{
    /// <summary>
    /// Classe de configuração de alto nível para a biblioteca ACBrLib Sedex.
    /// <para>
    /// Mapeia as chaves da sessão <c>[Sedex]</c> do arquivo de configuração da ACBrLib,
    /// utilizadas para autenticação no webservice dos Correios.
    /// </para>
    /// <para>
    /// Documentação: <see href="https://acbr.sourceforge.io/ACBrLib/ConfiguracoesdaBiblioteca10.html">
    /// Configurações da Biblioteca - ACBrLibSedex
    /// </see>.
    /// </para>
    /// </summary>
    public sealed class ACBrSedexConfig : ACBrLibConfig<IACBrLibSedex>
    {
        #region Constructors

        /// <summary>
        /// Cria uma instância de configuração Sedex associada à biblioteca informada.
        /// </summary>
        /// <param name="acbrlib">Instância da interface do ACBrLib Sedex.</param>
        public ACBrSedexConfig(IACBrLibSedex acbrlib) : base(acbrlib, ACBrSessao.Sedex)
        {
        }

        #endregion Constructors

        #region Properties

        /// <summary>
        /// Código do contrato para usar o webservice dos Correios (<c>CodContrato</c>).
        /// </summary>
        public string CodContrato
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Senha para usar o webservice dos Correios (<c>Senha</c>).
        /// </summary>
        public string Senha
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        #endregion Properties
    }
}
