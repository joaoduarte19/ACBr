namespace ACBrLib.Core.Config
{
    /// <summary>
    /// Configurações de dados do emitente na ACBrLib.
    /// <para>Permite definir informações como nome fantasia, inscrição estadual, endereço, município, UF, código do município, telefone, CEP, e-mail, etc.</para>
    /// <para>Veja mais em: https://acbr.sourceforge.io/ACBrLib/BemVindo.html</para>
    /// </summary>
    public sealed class DadosConfig<TLib> : ACBrLibConfigBase<TLib> where TLib : IACBrLibBase
    {
        #region Constructors

        /// <summary>
        /// Inicializa a configuração de dados do emitente.
        /// </summary>
        /// <param name="acbrlib">Instância da biblioteca ACBrLib.</param>
        /// <param name="sessao">Sessão de configuração.</param>
        public DadosConfig(TLib acbrlib, ACBrSessao sessao) : base(acbrlib, sessao)
        {
            SubName = "Emitente.Dados";
        }

        #endregion Constructors

        #region Properties

        /// <summary>
        /// Nome fantasia do emitente.
        /// </summary>
        public string NomeFantasia
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Inscrição estadual do emitente.
        /// </summary>
        public string InscricaoEstadual
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Telefone do emitente.
        /// </summary>
        public string Telefone
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// CEP do emitente.
        /// </summary>
        public string CEP
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Endereço do emitente.
        /// </summary>
        public string Endereco
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Número do endereço do emitente.
        /// </summary>
        public string Numero
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Complemento do endereço do emitente.
        /// </summary>
        public string Complemento
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Bairro do emitente.
        /// </summary>
        public string Bairro
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Município do emitente.
        /// </summary>
        public string Municipio
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// UF do emitente.
        /// </summary>
        public string UF
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Código do município do emitente.
        /// </summary>
        public string CodigoMunicipio
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// E-mail do emitente.
        /// </summary>
        public string Email
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        #endregion Properties
    }
}