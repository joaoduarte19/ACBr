using System.Runtime.CompilerServices;

namespace ACBrLib.Core.Config
{
    /// <summary>
    /// Classe base para configurações da ACBrLib.
    /// <para>Fornece métodos para leitura e gravação de valores de configuração, além de gerenciar sessões e nomes de propriedades.</para>
    /// <para>Veja mais em: https://acbr.sourceforge.io/ACBrLib/Geral.html</para>
    /// </summary>
    public abstract class ACBrLibConfigBase<TLib> where TLib : IACBrLibBase
    {
        #region Fields

        /// <summary>
        /// Instância da biblioteca ACBrLib associada à configuração.
        /// </summary>
        protected readonly TLib Parent;
        /// <summary>
        /// Sessão de configuração atual.
        /// </summary>
        protected readonly ACBrSessao SessaoConfig;
        /// <summary>
        /// Nome adicional para subconfigurações.
        /// </summary>
        protected string SubName;

        #endregion Fields

        #region Constructors

        /// <summary>
        /// Inicializa a base de configuração da ACBrLib.
        /// </summary>
        /// <param name="acbrlib">Instância da biblioteca ACBrLib.</param>
        /// <param name="sessao">Sessão de configuração.</param>
        protected ACBrLibConfigBase(TLib acbrlib, ACBrSessao sessao)
        {
            Parent = acbrlib;
            SessaoConfig = sessao;
        }

        #endregion Constructors

        #region Methods

        /// <summary>
        /// Obtém o valor de uma propriedade de configuração.
        /// </summary>
        /// <typeparam name="TProp">Tipo da propriedade.</typeparam>
        /// <param name="propertyName">Nome da propriedade (preenchido automaticamente).</param>
        /// <returns>Valor da propriedade.</returns>
        protected TProp GetProperty<TProp>([CallerMemberName] string propertyName = null)
        {
            return Parent.ConfigLerValor<TProp>(SessaoConfig, string.IsNullOrEmpty(SubName) ? propertyName : $"{SubName}.{propertyName}");
        }

        /// <summary>
        /// Define o valor de uma propriedade de configuração.
        /// </summary>
        /// <typeparam name="TProp">Tipo da propriedade.</typeparam>
        /// <param name="newValue">Novo valor a ser definido.</param>
        /// <param name="propertyName">Nome da propriedade (preenchido automaticamente).</param>
        protected void SetProperty<TProp>(TProp newValue, [CallerMemberName] string propertyName = null)
        {
            Parent.ConfigGravarValor(SessaoConfig, string.IsNullOrEmpty(SubName) ? propertyName : $"{SubName}.{propertyName}", newValue);
        }

        #endregion Methods
    }
}