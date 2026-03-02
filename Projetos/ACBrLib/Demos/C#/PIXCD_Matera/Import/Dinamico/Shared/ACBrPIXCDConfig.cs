using ACBrLib.Core;
using ACBrLib.Core.PIXCD;
using ACBrLib.Core.Config;
namespace ACBrLib.PIXCD
{
    /// <summary>
    /// Classe de configuração de alto nível para a ACBrLib PIXCD.
    /// <para>
    /// Mapeia as chaves da sessão <c>[PIXCD]</c> do arquivo de configuração da biblioteca,
    /// permitindo ajustar ambiente, provedor PSP, chave PIX, log, timeout, proxy e dados
    /// do recebedor.
    /// </para>
    /// <para>
    /// Documentação completa das chaves de configuração do PIXCD:
    /// <see href="https://acbr.sourceforge.io/ACBrLib/ConfiguracoesdaBiblioteca23.html">
    /// Configurações da Biblioteca - ACBrLibPIXCD
    /// </see>.
    /// </para>
    /// </summary>
    public sealed class ACBrPIXCDConfig : ACBrLibConfig<IACBrLibPIXCDMatera>
    {
        #region Constructors
        /// <summary>
        /// Cria uma instância de configuração PIXCD associada à biblioteca PIXCD Matera informada.
        /// </summary>
        /// <param name="acbrlib">Instância da interface do ACBrLib PIXCD Matera.</param>
        public ACBrPIXCDConfig(IACBrLibPIXCDMatera acbrlib) : base(acbrlib, ACBrSessao.PIXCD)
        {
            Matera = new MateraConfig(acbrlib);
        }

        #endregion Constructors

        #region Properties

        /// <summary>
        /// Configurações específicas do PSP Matera (sessão <c>[Matera]</c>).
        /// </summary>
        public MateraConfig Matera { get; }

        /// <summary>
        /// Ambiente de operação para o PIXCD.
        /// 0 = teste, 1 = produção, 2 = pré-produção.
        /// </summary>
        public Ambiente Ambiente
        {
            get => GetProperty<Ambiente>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Nível de log do componente PIXCD.
        /// 0 = Nenhum, 1 = Baixo, 2 = Normal, 3 = Alto, 4 = Muito Alto.
        /// </summary>
        public NivelLogPSP NivelLog
        {
            get => GetProperty<NivelLogPSP>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Provedor de Serviços de Pagamento (PSP) utilizado pelo PIXCD.
        /// Ex.: Bradesco, Itaú, Banco do Brasil, Matera, etc.
        /// </summary>
        public PSP PSP
        {
            get => GetProperty<PSP>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Tipo de chave PIX preferencial.
        /// 0 = Nenhuma, 1 = E-mail, 2 = CPF, 3 = CNPJ, 4 = Celular, 5 = Aleatória.
        /// </summary>
        public TipoChave TipoChave
        {
            get => GetProperty<TipoChave>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Caminho e nome do arquivo de log do componente PIXCD (<c>ArqLog</c>).
        /// Quando vazio, o log pode ser desabilitado ou salvo no diretório padrão.
        /// </summary>
        public string ArqLog
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Timeout (em milissegundos) para chamadas ao PSP (<c>Timeout</c>).
        /// Padrão: 90000 ms, conforme documentação da biblioteca.
        /// </summary>
        public int Timeout
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        /// <summary>
        /// CNPJ da software house (<c>CNPJSoftwareHouse</c>).
        /// Utilizado para identificação junto ao PSP e à SEFAZ quando aplicável.
        /// </summary>
        public string CNPJSoftwareHouse
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Nome da aplicação integradora (<c>NomeAplicacao</c>).
        /// </summary>
        public string NomeAplicacao
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Nome da software house responsável pela integração (<c>NomeSoftwareHouse</c>).
        /// </summary>
        public string NomeSoftwareHouse
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Versão da aplicação integradora (<c>VersaoAplicacao</c>).
        /// </summary>
        public string VersaoAplicacao
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Endereço do servidor proxy (<c>ProxyHost</c>), quando utilizado.
        /// </summary>
        public string ProxyHost
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Senha do usuário do proxy (<c>ProxyPass</c>).
        /// </summary>
        public string ProxyPass
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Porta do servidor proxy (<c>ProxyPort</c>).
        /// </summary>
        public int ProxyPort
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Usuário do servidor proxy (<c>ProxyUser</c>).
        /// </summary>
        public string ProxyUser
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Categoria do comerciante (<c>ChaveCategoriaComerciante</c>).
        /// Padrão: 0, de acordo com a documentação do PIXCD.
        /// </summary>
        public int ChaveCategoriaComerciante
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        /// <summary>
        /// CEP do recebedor padrão das transações PIX (<c>CEPRecebedor</c>).
        /// </summary>
        public string CEPRecebedor
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Cidade do recebedor padrão (<c>CidadeRecebedor</c>).
        /// </summary>
        public string CidadeRecebedor
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Nome do recebedor padrão (<c>NomeRecebedor</c>).
        /// </summary>
        public string NomeRecebedor
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// UF do recebedor padrão (<c>UFRecebedor</c>).
        /// </summary>
        public string UFRecebedor
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        #endregion Properties
    }
}