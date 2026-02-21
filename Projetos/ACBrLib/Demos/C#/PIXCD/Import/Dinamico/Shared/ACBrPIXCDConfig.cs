using ACBrLib.Core;
using ACBrLib.Core.Config;
using ACBrLib.Core.DFe;
using ACBrLib.Core.PIXCD;

namespace ACBrLib.PIXCD
{
    /// <summary>
    /// Configurações da biblioteca ACBrLib PIXCD.
    /// Veja todas as chaves e descrições em: https://acbr.sourceforge.io/ACBrLib/ConfiguracoesdaBiblioteca23.html
    /// </summary>
    public sealed class ACBrPIXCDConfig : ACBrLibConfigBase<IACBrLibPIXCD>
    {
        #region Constructors

        /// <summary>
        /// Inicializa as configurações da biblioteca PIXCD e de todos os PSPs suportados.
        /// </summary>
        /// <param name="acbrlib">Instância da interface PIXCD.</param>
        public ACBrPIXCDConfig(IACBrLibPIXCD acbrlib) : base(acbrlib, ACBrSessao.PIXCD)
        {
            Bradesco = new BradescoConfig(acbrlib);
            Sicredi = new SicrediConfig(acbrlib);
            Sicoob = new SicoobConfig(acbrlib);
            Shipay = new ShipayConfig(acbrlib);
            Santander = new SantanderConfig(acbrlib);
            PixPDV = new PixPDVConfig(acbrlib);
            PagSeguro = new PagSeguroConfig(acbrlib);
            Itau = new ItauConfig(acbrlib);
            Inter = new InterConfig(acbrlib);
            GerenciaNet = new GerenciaNetConfig(acbrlib);
            BancoBrasil = new BancoBrasilConfig(acbrlib);
            Ailos = new AilosConfig(acbrlib);
            Matera = new MateraConfig(acbrlib);
            Cielo = new CieloConfig(acbrlib);
            MercadoPago = new MercadoPagoConfig(acbrlib);
            C6Bank = new C6BankConfig(acbrlib);
            AppLess = new AppLessConfig(acbrlib);
        }
        // ...existing code...

        /// <summary>
        /// Define o ambiente: 0 = ambTeste, 1 = ambProducao, 2 = ambPreProducao
        /// </summary>
        public Ambiente Ambiente
        {
            get => GetProperty<Ambiente>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Nível do log: 0 = Nenhum, 1 = Baixo, 2 = Normal, 3 = Alto, 4 = Muito Alto
        /// </summary>
        public NivelLogPSP NivelLog
        {
            get => GetProperty<NivelLogPSP>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Provedor de Serviços de Pagamento (PSP): 0 - Bradesco, 1 - Itaú, 2 - Banco do Brasil, ...
        /// </summary>
        public PSP PSP
        {
            get => GetProperty<PSP>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Tipo de chave PIX: 0 = Nenhuma, 1 = Email, 2 = CPF, 3 = CNPJ, 4 = Celular, 5 = Aleatória
        /// </summary>
        public TipoChave TipoChave
        {
            get => GetProperty<TipoChave>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Caminho do arquivo de log do componente ACBrPIXCD.
        /// </summary>
        public string ArqLog
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Timeout do PSP (padrão = 90000 ms).
        /// </summary>
        public int Timeout
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        /// <summary>
        /// CNPJ da Software House.
        /// </summary>
        public string CNPJSoftwareHouse
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Nome da aplicação.
        /// </summary>
        public string NomeAplicacao
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Nome da Software House.
        /// </summary>
        public string NomeSoftwareHouse
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Versão da aplicação.
        /// </summary>
        public string VersaoAplicacao
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Endereço do servidor proxy.
        /// </summary>
        public string ProxyHost
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Senha do usuário do proxy.
        /// </summary>
        public string ProxyPass
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Porta do servidor proxy.
        /// </summary>
        public int ProxyPort
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Usuário do servidor proxy.
        /// </summary>
        public string ProxyUser
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Categoria do comerciante (padrão = 0).
        /// </summary>
        public int ChaveCategoriaComerciante
        {
            get => GetProperty<int>();
            set => SetProperty(value);
        }

        /// <summary>
        /// CEP do recebedor.
        /// </summary>
        public string CEPRecebedor
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Cidade do recebedor.
        /// </summary>
        public string CidadeRecebedor
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// Nome do recebedor.
        /// </summary>
        public string NomeRecebedor
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        /// <summary>
        /// UF do recebedor.
        /// </summary>
        public string UFRecebedor
        {
            get => GetProperty<string>();
            set => SetProperty(value);
        }

        #endregion Properties

        /// <summary>
        /// Configurações do PSP Bradesco.
        /// </summary>
        public BradescoConfig Bradesco { get; }

        /// <summary>
        /// Configurações do PSP Sicredi.
        /// </summary>
        public SicrediConfig Sicredi { get; }

        /// <summary>
        /// Configurações do PSP Sicoob.
        /// </summary>
        public SicoobConfig Sicoob { get; }

        /// <summary>
        /// Configurações do PSP Shipay.
        /// </summary>
        public ShipayConfig Shipay { get; }

        /// <summary>
        /// Configurações do PSP Santander.
        /// </summary>
        public SantanderConfig Santander { get; }

        /// <summary>
        /// Configurações do PSP PixPDV.
        /// </summary>
        public PixPDVConfig PixPDV { get; }

        /// <summary>
        /// Configurações do PSP PagSeguro.
        /// </summary>
        public PagSeguroConfig PagSeguro { get; }

        /// <summary>
        /// Configurações do PSP Itaú.
        /// </summary>
        public ItauConfig Itau { get; }

        /// <summary>
        /// Configurações do PSP Inter.
        /// </summary>
        public InterConfig Inter { get; }

        /// <summary>
        /// Configurações do PSP GerenciaNet.
        /// </summary>
        public GerenciaNetConfig GerenciaNet { get; }

        /// <summary>
        /// Configurações do PSP Banco do Brasil.
        /// </summary>
        public BancoBrasilConfig BancoBrasil { get; }

        /// <summary>
        /// Configurações do PSP Ailos.
        /// </summary>
        public AilosConfig Ailos { get; }

        /// <summary>
        /// Configurações do PSP Matera.
        /// </summary>
        public MateraConfig Matera { get; }

        /// <summary>
        /// Configurações do PSP Cielo.
        /// </summary>
        public CieloConfig Cielo { get; }

        /// <summary>
        /// Configurações do PSP MercadoPago.
        /// </summary>
        public MercadoPagoConfig MercadoPago { get; }

        /// <summary>
        /// Configurações do PSP C6 Bank.
        /// </summary>
        public C6BankConfig C6Bank { get; }

        /// <summary>
        /// Configurações do PSP AppLess.
        /// </summary>
        public AppLessConfig AppLess { get; }
    }
}