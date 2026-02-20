using System;

namespace ACBrLib.Core.Config
{
    /// <summary>
    /// Configurações do sistema utilizado nas impressões da ACBrLib.
    /// <para>Permite definir nome, versão, data e descrição do sistema.</para>
    /// <para>Veja mais em: https://acbr.sourceforge.io/ACBrLib/Geral.html</para>
    /// </summary>
    public sealed class SistemaConfig<TLib> : ACBrLibConfigBase<TLib> where TLib : IACBrLibBase
    {
        #region Constructors

        /// <summary>
        /// Inicializa a configuração do sistema.
        /// </summary>
        /// <param name="acbrlib">Instância da biblioteca ACBrLib.</param>
        public SistemaConfig(TLib acbrlib) : base(acbrlib, ACBrSessao.Sistema)
        {
        }

        #endregion Constructors

        #region Properties

        /// <summary>
        /// Nome do sistema utilizado nas impressões.
        /// </summary>
        public string Nome
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Versão do sistema utilizado nas impressões.
        /// </summary>
        public string Versao
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Data do sistema utilizado nas impressões.
        /// </summary>
        public DateTime Data
        {
            get => GetProperty<DateTime>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Descrição do sistema utilizado nas impressões.
        /// </summary>
        public string Descricao
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        #endregion Properties
    }
}