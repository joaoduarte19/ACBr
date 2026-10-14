using ACBrLib.Core;
using ACBrLib.Core.Config;
using ACBrLib.Core.IMendes;

namespace ACBrLib.IMendes
{
    /// <summary>
    /// Representa as configurações específicas da biblioteca ACBrLibIMendes (seção [IMendes] do ACBrLib.ini).
    /// </summary>
    public sealed class ACBrIMendesConfig : ACBrLibConfig<IACBrLibIMendes>
    {
        #region Constructors

        /// <summary>
        /// Inicializa uma nova instância da classe <see cref="ACBrIMendesConfig"/> para configuração da biblioteca ACBrLibIMendes.
        /// </summary>
        /// <param name="acbrlib">Instância da interface de alto nível da biblioteca ACBrLibIMendes.</param>
        public ACBrIMendesConfig(IACBrLibIMendes acbrlib) : base(acbrlib, ACBrSessao.IMendes)
        {
        }

        #endregion Constructors

        #region Properties

        /// <summary>
        /// Ambiente de acesso à API IMendes: imaNenhum = 0, imaHomologacao = 1, imaProducao = 2.
        /// </summary>
        public Ambiente Ambiente
        {
            get => GetProperty<Ambiente>();
            set => SetProperty(value);
        }

        /// <summary>
        /// CNPJ do parceiro credenciado na IMendes (login da API).
        /// </summary>
        public string CNPJ
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Senha do parceiro fornecida pela IMendes. Gravada criptografada no ACBrLib.ini.
        /// </summary>
        public string Senha
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Caminho completo do arquivo de log da comunicação com a API IMendes. Vazio = sem log.
        /// </summary>
        public string ArqLog
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Nível de detalhe do log da comunicação (0 a 4). A partir do nível 3 os headers (login/senha) são registrados.
        /// </summary>
        public int NivelLog
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Tempo máximo de espera da resposta da API, em milissegundos (padrão 300000).
        /// </summary>
        public int Timeout
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Quantidade máxima de produtos por envio no SaneamentoGrades (1 a 300, padrão 300).
        /// </summary>
        public int MaxProdutosPorEnvio
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        #endregion Properties
    }
}
