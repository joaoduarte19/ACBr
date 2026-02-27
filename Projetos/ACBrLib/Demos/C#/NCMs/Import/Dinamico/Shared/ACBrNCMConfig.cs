using ACBrLib.Core;
using ACBrLib.Core.Config;
using ACBrLib.Core.DFe;

namespace ACBrLib.NCM
{
    /// <summary>
    /// Classe de configuração de alto nível para a biblioteca ACBrLib NCMs.
    /// <para>
    /// Mapeia as chaves da sessão <c>[NCM]</c> do arquivo de configuração da ACBrLib,
    /// permitindo definir o diretório de cache da listagem de NCM e a validade do cache.
    /// </para>
    /// <para>
    /// Documentação completa das chaves de configuração do NCM:
    /// <see href="https://acbr.sourceforge.io/ACBrLib/ConfiguracoesdaBiblioteca21.html">Configurações da Biblioteca - ACBrLibNCM</see>
    /// </para>
    /// </summary>
    public sealed class ACBrNCMConfig : ACBrLibDFeConfig<IACBrLibNCM>
    {
        #region Constructors

        /// <summary>
        /// Cria uma nova instância da classe de configuração do ACBrNCM,
        /// associada a uma instância de <see cref="IACBrLibNCM"/>.
        /// </summary>
        /// <param name="acbrlib">Instância da interface de alto nível do ACBrNCM.</param>
        public ACBrNCMConfig(IACBrLibNCM acbrlib) : base(acbrlib, ACBrSessao.NCM)
        {
        }

        #endregion Constructors

        #region Properties

        /// <summary>
        /// Obtém ou define o caminho do diretório para salvar a listagem de NCM em formato .txt ou .csv
        /// (<c>ArquivoCache</c>). Na primeira consulta é realizado o download da listagem de NCM em cache no disco.
        /// </summary>
        public string ArquivoCache
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Obtém ou define a quantidade de dias para considerar válida a consulta no arquivo em cache no disco
        /// (<c>DiasValidadeCache</c>). A partir dessa quantidade de dias é baixado um novo arquivo atualizado.
        /// </summary>
        public int DiasValidadeCache
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        #endregion Properties
    }
}