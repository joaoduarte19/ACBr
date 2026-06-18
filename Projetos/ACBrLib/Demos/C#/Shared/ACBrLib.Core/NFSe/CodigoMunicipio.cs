using System;
using System.ComponentModel;

namespace ACBrLib.Core.NFSe
{
    /// <summary>
    /// Enumera os códigos de municípios para configuração da NFSe.
    /// <para>Utilizado para identificar o município de emissão conforme tabela IBGE.</para>
    /// <para>Veja mais em: https://acbr.sourceforge.io/ACBrLib/ConfiguracoesdaBiblioteca22.html</para>
    /// </summary>
    public enum CodigoMunicipio
    {
        [EnumValue("0")]
        [Description("Nenhuma Cidade Selecionada")]
        NenhumaCidadeSelecionada = 0,

        //======Acre======
        [EnumValue("1200013")]
        [Description("Acrelandia - AC")]
        Acrelandia = 1200013,

        [EnumValue("1200054")]
        [Description("Assis Brasil - AC")]
        AssisBrasil = 1200054,

        [EnumValue("1200104")]
        [Description("Brasileia - AC")]
        Brasileia = 1200104,

        [EnumValue("1200138")]
        [Description("Bujari - AC")]
        Bujari = 1200138,

        [EnumValue("1200179")]
        [Description("Capixaba - AC")]
        Capixaba = 1200179,

        [EnumValue("1200203")]
        [Description("Cruzeiro do Sul - AC")]
        CruzeirodoSul = 1200203,

        [EnumValue("1200252")]
        [Description("Epitaciolandia - AC")]
        Epitaciolandia = 1200252,

        [EnumValue("1200302")]
        [Description("Feijo - AC")]
        Feijo = 1200302,

        [EnumValue("1200328")]
        [Description("Jordao - AC")]
        Jordao = 1200328,

        [EnumValue("1200336")]
        [Description("Mancio Lima - AC")]
        MancioLima = 1200336,

        [EnumValue("1200344")]
        [Description("Manoel Urbano - AC")]
        ManoelUrbano = 1200344,

        [EnumValue("1200351")]
        [Description("Marechal Thaumaturgo - AC")]
        MarechalThaumaturgo = 1200351,

        [EnumValue("1200385")]
        [Description("Placido de Castro - AC")]
        PlacidodeCastro = 1200385,

        [EnumValue("1200393")]
        [Description("Porto Walter - AC")]
        PortoWalter = 1200393,

        [EnumValue("1200401")]
        [Description("Rio Branco - AC")]
        RioBranco = 1200401,

        [EnumValue("1200427")]
        [Description("Rodrigues Alves - AC")]
        RodriguesAlves = 1200427,

        [EnumValue("1200435")]
        [Description("Santa Rosa do Purus - AC")]
        SantaRosadoPurus = 1200435,

        [EnumValue("1200450")]
        [Description("Senador Guiomard - AC")]
        SenadorGuiomard = 1200450,

        [EnumValue("1200500")]
        [Description("Sena Madureira - AC")]
        SenaMadureira = 1200500,

        [EnumValue("1200609")]
        [Description("Tarauaca - AC")]
        Tarauaca = 1200609,

        [EnumValue("1200708")]
        [Description("Xapuri - AC")]
        Xapuri = 1200708,

        [EnumValue("1200807")]
        [Description("Porto Acre - AC")]
        PortoAcre = 1200807,

        //======Alagoas======
        [EnumValue("2700102")]
        [Description("Agua Branca - AL")]
        AguaBranca = 2700102,

        [EnumValue("2700201")]
        [Description("Anadia - AL")]
        Anadia = 2700201,

        [EnumValue("2700300")]
        [Description("Arapiraca - AL")]
        Arapiraca = 2700300,

        [EnumValue("2700409")]
        [Description("Atalaia - AL")]
        Atalaia = 2700409,

        [EnumValue("2700508")]
        [Description("Barra de Santo Antonio - AL")]
        BarradeSantoAntonio = 2700508,

        [EnumValue("2700607")]
        [Description("Barra de Sao Miguel - AL")]
        BarradeSaoMiguel = 2700607,

        [EnumValue("2700706")]
        [Description("Batalha - AL")]
        Batalha = 2700706,

        [EnumValue("2700805")]
        [Description("Belem - AL")]
        Belem = 2700805,

        [EnumValue("2700904")]
        [Description("Belo Monte - AL")]
        BeloMonte = 2700904,

        [EnumValue("2701001")]
        [Description("Boca da Mata - AL")]
        BocadaMata = 2701001,

        [EnumValue("2701100")]
        [Description("Branquinha - AL")]
        Branquinha = 2701100,

        [EnumValue("2701357")]
        [Description("Campestre - AL")]
        Campestre = 2701357,

        [EnumValue("2701407")]
        [Description("Campo Alegre - AL")]
        CampoAlegre = 2701407,

        [EnumValue("2701605")]
        [Description("Canapi - AL")]
        Canapi = 2701605,

        [EnumValue("2701704")]
        [Description("Capela - AL")]
        Capela = 2701704,

        [EnumValue("2701803")]
        [Description("Carneiros - AL")]
        Carneiros = 2701803,

        [EnumValue("2701902")]
        [Description("Cha Preta - AL")]
        ChaPreta = 2701902,

        [EnumValue("2702009")]
        [Description("Coite do Noia - AL")]
        CoitedoNoia = 2702009,

        [EnumValue("2702108")]
        [Description("Colonia Leopoldina - AL")]
        ColoniaLeopoldina = 2702108,

        [EnumValue("2702207")]
        [Description("Coqueiro Seco - AL")]
        CoqueiroSeco = 2702207,

        [EnumValue("2702306")]
        [Description("Coruripe - AL")]
        Coruripe = 2702306,

        [EnumValue("2702355")]
        [Description("Craibas - AL")]
        Craibas = 2702355,

        [EnumValue("2702405")]
        [Description("Delmiro Gouveia - AL")]
        DelmiroGouveia = 2702405,

        [EnumValue("2702504")]
        [Description("Dois Riachos - AL")]
        DoisRiachos = 2702504,

        [EnumValue("2702553")]
        [Description("Estrela de Alagoas - AL")]
        EstreladeAlagoas = 2702553,

        [EnumValue("2702603")]
        [Description("Feira Grande - AL")]
        FeiraGrande = 2702603,

        [EnumValue("2702702")]
        [Description("Feliz Deserto - AL")]
        FelizDeserto = 2702702,

        [EnumValue("2702801")]
        [Description("Flexeiras - AL")]
        Flexeiras = 2702801,

        [EnumValue("2702900")]
        [Description("Girau do Ponciano - AL")]
        GiraudoPonciano = 2702900,

        [EnumValue("2703007")]
        [Description("Ibateguara - AL")]
        Ibateguara = 2703007,

        [EnumValue("2703205")]
        [Description("Igreja Nova - AL")]
        IgrejaNova = 2703205,

        [EnumValue("2703304")]
        [Description("Inhapi - AL")]
        Inhapi = 2703304,

        [EnumValue("2703403")]
        [Description("Jacare dos Homens - AL")]
        JacaredosHomens = 2703403,

        [EnumValue("2703502")]
        [Description("Jacuipe - AL")]
        Jacuipe = 2703502,

        [EnumValue("2703759")]
        [Description("Jequia da Praia - AL")]
        JequiadaPraia = 2703759,

        [EnumValue("2703809")]
        [Description("Joaquim Gomes - AL")]
        JoaquimGomes = 2703809,

        [EnumValue("2703908")]
        [Description("Jundia - AL")]
        Jundia = 2703908,

        [EnumValue("2704104")]
        [Description("Lagoa da Canoa - AL")]
        LagoadaCanoa = 2704104,

        [EnumValue("2704203")]
        [Description("Limoeiro de Anadia - AL")]
        LimoeirodeAnadia = 2704203,

        [EnumValue("2704302")]
        [Description("Maceio - AL")]
        Maceio = 2704302,

        [EnumValue("2704500")]
        [Description("Maragogi - AL")]
        Maragogi = 2704500,

        [EnumValue("2704609")]
        [Description("Maravilha - AL")]
        Maravilha = 2704609,

        [EnumValue("2704708")]
        [Description("Marechal Deodoro - AL")]
        MarechalDeodoro = 2704708,

        [EnumValue("2705200")]
        [Description("Messias - AL")]
        Messias = 2705200,

        [EnumValue("2705309")]
        [Description("Minador do Negrao - AL")]
        MinadordoNegrao = 2705309,

        [EnumValue("2705408")]
        [Description("Monteiropolis - AL")]
        Monteiropolis = 2705408,

        [EnumValue("2705507")]
        [Description("Murici - AL")]
        Murici = 2705507,

        [EnumValue("2705606")]
        [Description("Novo Lino - AL")]
        NovoLino = 2705606,

        [EnumValue("2705705")]
        [Description("Olho dAgua das Flores - AL")]
        OlhodAguadasFlores = 2705705,

        [EnumValue("2705804")]
        [Description("Olho dAgua do Casado - AL")]
        OlhodAguadoCasado = 2705804,

        [EnumValue("2706000")]
        [Description("Olivenca - AL")]
        Olivenca = 2706000,

        [EnumValue("2706109")]
        [Description("Ouro Branco - AL")]
        OuroBranco = 2706109,

        [EnumValue("2706208")]
        [Description("Palestina - AL")]
        Palestina = 2706208,

        [EnumValue("2706406")]
        [Description("Pao de Acucar - AL")]
        PaodeAcucar = 2706406,

        [EnumValue("2706422")]
        [Description("Pariconha - AL")]
        Pariconha = 2706422,

        [EnumValue("2706505")]
        [Description("Passo de Camaragibe - AL")]
        PassodeCamaragibe = 2706505,

        [EnumValue("2706604")]
        [Description("Paulo Jacinto - AL")]
        PauloJacinto = 2706604,

        [EnumValue("2706703")]
        [Description("Penedo - AL")]
        Penedo = 2706703,

        [EnumValue("2707008")]
        [Description("Pindoba - AL")]
        Pindoba = 2707008,

        [EnumValue("2707107")]
        [Description("Piranhas - AL")]
        Piranhas = 2707107,

        [EnumValue("2707206")]
        [Description("Poco das Trincheiras - AL")]
        PocodasTrincheiras = 2707206,

        [EnumValue("2707305")]
        [Description("Porto Calvo - AL")]
        PortoCalvo = 2707305,

        [EnumValue("2707404")]
        [Description("Porto de Pedras - AL")]
        PortodePedras = 2707404,

        [EnumValue("2707503")]
        [Description("Porto Real do Colegio - AL")]
        PortoRealdoColegio = 2707503,

        [EnumValue("2707602")]
        [Description("Quebrangulo - AL")]
        Quebrangulo = 2707602,

        [EnumValue("2707701")]
        [Description("Rio Largo - AL")]
        RioLargo = 2707701,

        [EnumValue("2707909")]
        [Description("Santa Luzia do Norte - AL")]
        SantaLuziadoNorte = 2707909,

        [EnumValue("2708006")]
        [Description("Santana do Ipanema - AL")]
        SantanadoIpanema = 2708006,

        [EnumValue("2708105")]
        [Description("Santana do Mundau - AL")]
        SantanadoMundau = 2708105,

        [EnumValue("2708204")]
        [Description("Sao Bras - AL")]
        SaoBras = 2708204,

        [EnumValue("2708303")]
        [Description("Sao Jose da Laje - AL")]
        SaoJosedaLaje = 2708303,

        [EnumValue("2708600")]
        [Description("Sao Miguel dos Campos - AL")]
        SaoMigueldosCampos = 2708600,

        [EnumValue("2709004")]
        [Description("Tanque dArca - AL")]
        TanquedArca = 2709004,

        [EnumValue("2709103")]
        [Description("Taquarana - AL")]
        Taquarana = 2709103,

        [EnumValue("2709152")]
        [Description("Teotonio Vilela - AL")]
        TeotonioVilela = 2709152,

        [EnumValue("2709301")]
        [Description("Uniao dos Palmares - AL")]
        UniaodosPalmares = 2709301,

        [EnumValue("2709400")]
        [Description("Vicosa - AL")]
        Vicosa = 2709400,

        //======Amazonas======
        [EnumValue("1300060")]
        [Description("Amatura - AM")]
        Amatura = 1300060,

        [EnumValue("1300144")]
        [Description("Apui - AM")]
        Apui = 1300144,

        [EnumValue("1300300")]
        [Description("Autazes - AM")]
        Autazes = 1300300,

        [EnumValue("1300706")]
        [Description("Boca do Acre - AM")]
        BocadoAcre = 1300706,

        [EnumValue("1300805")]
        [Description("Borba - AM")]
        Borba = 1300805,

        [EnumValue("1300839")]
        [Description("Caapiranga - AM")]
        Caapiranga = 1300839,

        [EnumValue("1301159")]
        [Description("Careiro da Varzea - AM")]
        CareirodaVarzea = 1301159,

        [EnumValue("1301209")]
        [Description("Coari - AM")]
        Coari = 1301209,

        [EnumValue("1301308")]
        [Description("Codajas - AM")]
        Codajas = 1301308,

        [EnumValue("1301704")]
        [Description("Humaita - AM")]
        Humaita = 1301704,

        [EnumValue("1301852")]
        [Description("Iranduba - AM")]
        Iranduba = 1301852,

        [EnumValue("1301902")]
        [Description("Itacoatiara - AM")]
        Itacoatiara = 1301902,

        [EnumValue("1302009")]
        [Description("Itapiranga - AM")]
        Itapiranga = 1302009,

        [EnumValue("1302108")]
        [Description("Japura - AM")]
        Japura = 1302108,

        [EnumValue("1302207")]
        [Description("Jurua - AM")]
        Jurua = 1302207,

        [EnumValue("1302553")]
        [Description("Manaquiri - AM")]
        Manaquiri = 1302553,

        [EnumValue("1302603")]
        [Description("Manaus - AM")]
        Manaus = 1302603,

        [EnumValue("1302702")]
        [Description("Manicore - AM")]
        Manicore = 1302702,

        [EnumValue("1303205")]
        [Description("Novo Airao - AM")]
        NovoAirao = 1303205,

        [EnumValue("1303536")]
        [Description("Presidente Figueiredo - AM")]
        PresidenteFigueiredo = 1303536,

        [EnumValue("1303569")]
        [Description("Rio Preto da Eva - AM")]
        RioPretodaEva = 1303569,

        [EnumValue("1303908")]
        [Description("Sao Paulo de Olivenca - AM")]
        SaoPaulodeOlivenca = 1303908,

        [EnumValue("1304005")]
        [Description("Silves - AM")]
        Silves = 1304005,

        [EnumValue("1304203")]
        [Description("Tefe - AM")]
        Tefe = 1304203,

        [EnumValue("1304260")]
        [Description("Uarini - AM")]
        Uarini = 1304260,

        //======Amapá======
        [EnumValue("1600055")]
        [Description("Serra do Navio - AP")]
        SerradoNavio = 1600055,

        [EnumValue("1600154")]
        [Description("Pedra Branca do Amapari - AP")]
        PedraBrancadoAmapari = 1600154,

        [EnumValue("1600204")]
        [Description("Calcoene - AP")]
        Calcoene = 1600204,

        [EnumValue("1600212")]
        [Description("Cutias - AP")]
        Cutias = 1600212,

        [EnumValue("1600238")]
        [Description("Ferreira Gomes - AP")]
        FerreiraGomes = 1600238,

        [EnumValue("1600303")]
        [Description("Macapa - AP")]
        Macapa = 1600303,

        [EnumValue("1600402")]
        [Description("Mazagao - AP")]
        Mazagao = 1600402,

        [EnumValue("1600550")]
        [Description("Pracuuba - AP")]
        Pracuuba = 1600550,

        [EnumValue("1600600")]
        [Description("Santana - AP")]
        Santana = 1600600,

        [EnumValue("1600709")]
        [Description("Tartarugalzinho - AP")]
        Tartarugalzinho = 1600709,

        [EnumValue("1600808")]
        [Description("Vitoria do Jari - AP")]
        VitoriadoJari = 1600808,

        //======Bahia======
        [EnumValue("2900306")]
        [Description("Acajutiba - BA")]
        Acajutiba = 2900306,

        [EnumValue("2900355")]
        [Description("Adustina - BA")]
        Adustina = 2900355,

        [EnumValue("2900504")]
        [Description("Erico Cardoso - BA")]
        EricoCardoso = 2900504,

        [EnumValue("2900603")]
        [Description("Aiquara - BA")]
        Aiquara = 2900603,

        [EnumValue("2900702")]
        [Description("Alagoinhas - BA")]
        Alagoinhas = 2900702,

        [EnumValue("2900801")]
        [Description("Alcobaca - BA")]
        Alcobaca = 2900801,

        [EnumValue("2900900")]
        [Description("Almadina - BA")]
        Almadina = 2900900,

        [EnumValue("2901007")]
        [Description("Amargosa - BA")]
        Amargosa = 2901007,

        [EnumValue("2901106")]
        [Description("Amelia Rodrigues - BA")]
        AmeliaRodrigues = 2901106,

        [EnumValue("2901155")]
        [Description("America Dourada - BA")]
        AmericaDourada = 2901155,

        [EnumValue("2901205")]
        [Description("Anage - BA")]
        Anage = 2901205,

        [EnumValue("2901304")]
        [Description("Andarai - BA")]
        Andarai = 2901304,

        [EnumValue("2901353")]
        [Description("Andorinha - BA")]
        Andorinha = 2901353,

        [EnumValue("2901403")]
        [Description("Angical - BA")]
        Angical = 2901403,

        [EnumValue("2901502")]
        [Description("Anguera - BA")]
        Anguera = 2901502,

        [EnumValue("2901601")]
        [Description("Antas - BA")]
        Antas = 2901601,

        [EnumValue("2901700")]
        [Description("Antonio Cardoso - BA")]
        AntonioCardoso = 2901700,

        [EnumValue("2901809")]
        [Description("Antonio Goncalves - BA")]
        AntonioGoncalves = 2901809,

        [EnumValue("2901957")]
        [Description("Apuarema - BA")]
        Apuarema = 2901957,

        [EnumValue("2902005")]
        [Description("Aracatu - BA")]
        Aracatu = 2902005,

        [EnumValue("2902054")]
        [Description("Aracas - BA")]
        Aracas = 2902054,

        [EnumValue("2902104")]
        [Description("Araci - BA")]
        Araci = 2902104,

        [EnumValue("2902203")]
        [Description("Aramari - BA")]
        Aramari = 2902203,

        [EnumValue("2902252")]
        [Description("Arataca - BA")]
        Arataca = 2902252,

        [EnumValue("2902302")]
        [Description("Aratuipe - BA")]
        Aratuipe = 2902302,

        [EnumValue("2902500")]
        [Description("Baianopolis - BA")]
        Baianopolis = 2902500,

        [EnumValue("2902609")]
        [Description("Baixa Grande - BA")]
        BaixaGrande = 2902609,

        [EnumValue("2902658")]
        [Description("Banzae - BA")]
        Banzae = 2902658,

        [EnumValue("2902708")]
        [Description("Barra - BA")]
        Barra = 2902708,

        [EnumValue("2902807")]
        [Description("Barra da Estiva - BA")]
        BarradaEstiva = 2902807,

        [EnumValue("2902906")]
        [Description("Barra do Choca - BA")]
        BarradoChoca = 2902906,

        [EnumValue("2903003")]
        [Description("Barra do Mendes - BA")]
        BarradoMendes = 2903003,

        [EnumValue("2903102")]
        [Description("Barra do Rocha - BA")]
        BarradoRocha = 2903102,

        [EnumValue("2903201")]
        [Description("Barreiras - BA")]
        Barreiras = 2903201,

        [EnumValue("2903235")]
        [Description("Barro Alto - BA")]
        BarroAlto = 2903235,

        [EnumValue("2903276")]
        [Description("Barrocas - BA")]
        Barrocas = 2903276,

        [EnumValue("2903300")]
        [Description("Barro Preto - BA")]
        BarroPreto = 2903300,

        [EnumValue("2903409")]
        [Description("Belmonte - BA")]
        Belmonte = 2903409,

        [EnumValue("2903508")]
        [Description("Belo Campo - BA")]
        BeloCampo = 2903508,

        [EnumValue("2903607")]
        [Description("Biritinga - BA")]
        Biritinga = 2903607,

        [EnumValue("2903706")]
        [Description("Boa Nova - BA")]
        BoaNova = 2903706,

        [EnumValue("2903904")]
        [Description("Bom Jesus da Lapa - BA")]
        BomJesusdaLapa = 2903904,

        [EnumValue("2903953")]
        [Description("Bom Jesus da Serra - BA")]
        BomJesusdaSerra = 2903953,

        [EnumValue("2904001")]
        [Description("Boninal - BA")]
        Boninal = 2904001,

        [EnumValue("2904100")]
        [Description("Boquira - BA")]
        Boquira = 2904100,

        [EnumValue("2904308")]
        [Description("Brejoes - BA")]
        Brejoes = 2904308,

        [EnumValue("2904407")]
        [Description("Brejolandia - BA")]
        Brejolandia = 2904407,

        [EnumValue("2904605")]
        [Description("Brumado - BA")]
        Brumado = 2904605,

        [EnumValue("2904704")]
        [Description("Buerarema - BA")]
        Buerarema = 2904704,

        [EnumValue("2904753")]
        [Description("Buritirama - BA")]
        Buritirama = 2904753,

        [EnumValue("2904803")]
        [Description("Caatiba - BA")]
        Caatiba = 2904803,

        [EnumValue("2904852")]
        [Description("Cabaceiras do Paraguacu - BA")]
        CabaceirasdoParaguacu = 2904852,

        [EnumValue("2904902")]
        [Description("Cachoeira - BA")]
        Cachoeira = 2904902,

        [EnumValue("2905008")]
        [Description("Cacule - BA")]
        Cacule = 2905008,

        [EnumValue("2905107")]
        [Description("Caem - BA")]
        Caem = 2905107,

        [EnumValue("2905305")]
        [Description("Cafarnaum - BA")]
        Cafarnaum = 2905305,

        [EnumValue("2905404")]
        [Description("Cairu - BA")]
        Cairu = 2905404,

        [EnumValue("2905503")]
        [Description("Caldeirao Grande - BA")]
        CaldeiraoGrande = 2905503,

        [EnumValue("2905602")]
        [Description("Camacan - BA")]
        Camacan = 2905602,

        [EnumValue("2905701")]
        [Description("Camacari - BA")]
        Camacari = 2905701,

        [EnumValue("2905800")]
        [Description("Camamu - BA")]
        Camamu = 2905800,

        [EnumValue("2905909")]
        [Description("Campo Alegre de Lourdes - BA")]
        CampoAlegredeLourdes = 2905909,

        [EnumValue("2906006")]
        [Description("Campo Formoso - BA")]
        CampoFormoso = 2906006,

        [EnumValue("2906105")]
        [Description("Canapolis - BA")]
        Canapolis = 2906105,

        [EnumValue("2906204")]
        [Description("Canarana - BA")]
        Canarana = 2906204,

        [EnumValue("2906303")]
        [Description("Canavieiras - BA")]
        Canavieiras = 2906303,

        [EnumValue("2906402")]
        [Description("Candeal - BA")]
        Candeal = 2906402,

        [EnumValue("2906501")]
        [Description("Candeias - BA")]
        Candeias = 2906501,

        [EnumValue("2906600")]
        [Description("Candiba - BA")]
        Candiba = 2906600,

        [EnumValue("2906709")]
        [Description("Candido Sales - BA")]
        CandidoSales = 2906709,

        [EnumValue("2906808")]
        [Description("Cansancao - BA")]
        Cansancao = 2906808,

        [EnumValue("2906824")]
        [Description("Canudos - BA")]
        Canudos = 2906824,

        [EnumValue("2906857")]
        [Description("Capela do Alto Alegre - BA")]
        CapeladoAltoAlegre = 2906857,

        [EnumValue("2906899")]
        [Description("Caraibas - BA")]
        Caraibas = 2906899,

        [EnumValue("2906907")]
        [Description("Caravelas - BA")]
        Caravelas = 2906907,

        [EnumValue("2907103")]
        [Description("Carinhanha - BA")]
        Carinhanha = 2907103,

        [EnumValue("2907202")]
        [Description("Casa Nova - BA")]
        CasaNova = 2907202,

        [EnumValue("2907301")]
        [Description("Castro Alves - BA")]
        CastroAlves = 2907301,

        [EnumValue("2907400")]
        [Description("Catolandia - BA")]
        Catolandia = 2907400,

        [EnumValue("2907509")]
        [Description("Catu - BA")]
        Catu = 2907509,

        [EnumValue("2907707")]
        [Description("Chorrocho - BA")]
        Chorrocho = 2907707,

        [EnumValue("2907806")]
        [Description("Cicero Dantas - BA")]
        CiceroDantas = 2907806,

        [EnumValue("2907905")]
        [Description("Cipo - BA")]
        Cipo = 2907905,

        [EnumValue("2908200")]
        [Description("Conceicao da Feira - BA")]
        ConceicaodaFeira = 2908200,

        [EnumValue("2908408")]
        [Description("Conceicao do Coite - BA")]
        ConceicaodoCoite = 2908408,

        [EnumValue("2908507")]
        [Description("Conceicao do Jacuipe - BA")]
        ConceicaodoJacuipe = 2908507,

        [EnumValue("2908705")]
        [Description("Condeuba - BA")]
        Condeuba = 2908705,

        [EnumValue("2908804")]
        [Description("Contendas do Sincora - BA")]
        ContendasdoSincora = 2908804,

        [EnumValue("2908903")]
        [Description("Coracao de Maria - BA")]
        CoracaodeMaria = 2908903,

        [EnumValue("2909000")]
        [Description("Cordeiros - BA")]
        Cordeiros = 2909000,

        [EnumValue("2909109")]
        [Description("Coribe - BA")]
        Coribe = 2909109,

        [EnumValue("2909208")]
        [Description("Coronel Joao Sa - BA")]
        CoronelJoaoSa = 2909208,

        [EnumValue("2909307")]
        [Description("Correntina - BA")]
        Correntina = 2909307,

        [EnumValue("2909406")]
        [Description("Cotegipe - BA")]
        Cotegipe = 2909406,

        [EnumValue("2909505")]
        [Description("Cravolandia - BA")]
        Cravolandia = 2909505,

        [EnumValue("2909604")]
        [Description("Crisopolis - BA")]
        Crisopolis = 2909604,

        [EnumValue("2909703")]
        [Description("Cristopolis - BA")]
        Cristopolis = 2909703,

        [EnumValue("2909802")]
        [Description("Cruz das Almas - BA")]
        CruzdasAlmas = 2909802,

        [EnumValue("2909901")]
        [Description("Curaca - BA")]
        Curaca = 2909901,

        [EnumValue("2910008")]
        [Description("Dario Meira - BA")]
        DarioMeira = 2910008,

        [EnumValue("2910057")]
        [Description("Dias dAvila - BA")]
        DiasdAvila = 2910057,

        [EnumValue("2910107")]
        [Description("Dom Basilio - BA")]
        DomBasilio = 2910107,

        [EnumValue("2910305")]
        [Description("Elisio Medrado - BA")]
        ElisioMedrado = 2910305,

        [EnumValue("2910503")]
        [Description("Entre Rios - BA")]
        EntreRios = 2910503,

        [EnumValue("2910602")]
        [Description("Esplanada - BA")]
        Esplanada = 2910602,

        [EnumValue("2910701")]
        [Description("Euclides da Cunha - BA")]
        EuclidesdaCunha = 2910701,

        [EnumValue("2910727")]
        [Description("Eunapolis - BA")]
        Eunapolis = 2910727,

        [EnumValue("2910750")]
        [Description("Fatima - BA")]
        Fatima = 2910750,

        [EnumValue("2910776")]
        [Description("Feira da Mata - BA")]
        FeiradaMata = 2910776,

        [EnumValue("2910800")]
        [Description("Feira de Santana - BA")]
        FeiradeSantana = 2910800,

        [EnumValue("2910859")]
        [Description("Filadelfia - BA")]
        Filadelfia = 2910859,

        [EnumValue("2910909")]
        [Description("Firmino Alves - BA")]
        FirminoAlves = 2910909,

        [EnumValue("2911006")]
        [Description("Floresta Azul - BA")]
        FlorestaAzul = 2911006,

        [EnumValue("2911105")]
        [Description("Formosa do Rio Preto - BA")]
        FormosadoRioPreto = 2911105,

        [EnumValue("2911204")]
        [Description("Gandu - BA")]
        Gandu = 2911204,

        [EnumValue("2911253")]
        [Description("Gaviao - BA")]
        Gaviao = 2911253,

        [EnumValue("2911303")]
        [Description("Gentio do Ouro - BA")]
        GentiodoOuro = 2911303,

        [EnumValue("2911402")]
        [Description("Gloria - BA")]
        Gloria = 2911402,

        [EnumValue("2911501")]
        [Description("Gongogi - BA")]
        Gongogi = 2911501,

        [EnumValue("2911600")]
        [Description("Governador Mangabeira - BA")]
        GovernadorMangabeira = 2911600,

        [EnumValue("2911709")]
        [Description("Guanambi - BA")]
        Guanambi = 2911709,

        [EnumValue("2911808")]
        [Description("Guaratinga - BA")]
        Guaratinga = 2911808,

        [EnumValue("2911857")]
        [Description("Heliopolis - BA")]
        Heliopolis = 2911857,

        [EnumValue("2912004")]
        [Description("Ibiassuce - BA")]
        Ibiassuce = 2912004,

        [EnumValue("2912103")]
        [Description("Ibicarai - BA")]
        Ibicarai = 2912103,

        [EnumValue("2912202")]
        [Description("Ibicoara - BA")]
        Ibicoara = 2912202,

        [EnumValue("2912400")]
        [Description("Ibipeba - BA")]
        Ibipeba = 2912400,

        [EnumValue("2912608")]
        [Description("Ibiquera - BA")]
        Ibiquera = 2912608,

        [EnumValue("2912707")]
        [Description("Ibirapitanga - BA")]
        Ibirapitanga = 2912707,

        [EnumValue("2912806")]
        [Description("Ibirapua - BA")]
        Ibirapua = 2912806,

        [EnumValue("2913002")]
        [Description("Ibitiara - BA")]
        Ibitiara = 2913002,

        [EnumValue("2913101")]
        [Description("Ibitita - BA")]
        Ibitita = 2913101,

        [EnumValue("2913200")]
        [Description("Ibotirama - BA")]
        Ibotirama = 2913200,

        [EnumValue("2913309")]
        [Description("Ichu - BA")]
        Ichu = 2913309,

        [EnumValue("2913408")]
        [Description("Igapora - BA")]
        Igapora = 2913408,

        [EnumValue("2913457")]
        [Description("Igrapiuna - BA")]
        Igrapiuna = 2913457,

        [EnumValue("2913507")]
        [Description("Iguai - BA")]
        Iguai = 2913507,

        [EnumValue("2913606")]
        [Description("Ilheus - BA")]
        Ilheus = 2913606,

        [EnumValue("2913705")]
        [Description("Inhambupe - BA")]
        Inhambupe = 2913705,

        [EnumValue("2913903")]
        [Description("Ipiau - BA")]
        Ipiau = 2913903,

        [EnumValue("2914000")]
        [Description("Ipira - BA")]
        Ipira = 2914000,

        [EnumValue("2914109")]
        [Description("Ipupiara - BA")]
        Ipupiara = 2914109,

        [EnumValue("2914208")]
        [Description("Irajuba - BA")]
        Irajuba = 2914208,

        [EnumValue("2914307")]
        [Description("Iramaia - BA")]
        Iramaia = 2914307,

        [EnumValue("2914406")]
        [Description("Iraquara - BA")]
        Iraquara = 2914406,

        [EnumValue("2914505")]
        [Description("Irara - BA")]
        Irara = 2914505,

        [EnumValue("2914604")]
        [Description("Irece - BA")]
        Irece = 2914604,

        [EnumValue("2914653")]
        [Description("Itabela - BA")]
        Itabela = 2914653,

        [EnumValue("2914703")]
        [Description("Itaberaba - BA")]
        Itaberaba = 2914703,

        [EnumValue("2914802")]
        [Description("Itabuna - BA")]
        Itabuna = 2914802,

        [EnumValue("2914901")]
        [Description("Itacare - BA")]
        Itacare = 2914901,

        [EnumValue("2915007")]
        [Description("Itaete - BA")]
        Itaete = 2915007,

        [EnumValue("2915106")]
        [Description("Itagi - BA")]
        Itagi = 2915106,

        [EnumValue("2915205")]
        [Description("Itagiba - BA")]
        Itagiba = 2915205,

        [EnumValue("2915304")]
        [Description("Itagimirim - BA")]
        Itagimirim = 2915304,

        [EnumValue("2915353")]
        [Description("Itaguacu da Bahia - BA")]
        ItaguacudaBahia = 2915353,

        [EnumValue("2915403")]
        [Description("Itaju do Colonia - BA")]
        ItajudoColonia = 2915403,

        [EnumValue("2915502")]
        [Description("Itajuipe - BA")]
        Itajuipe = 2915502,

        [EnumValue("2915601")]
        [Description("Itamaraju - BA")]
        Itamaraju = 2915601,

        [EnumValue("2915700")]
        [Description("Itamari - BA")]
        Itamari = 2915700,

        [EnumValue("2915809")]
        [Description("Itambe - BA")]
        Itambe = 2915809,

        [EnumValue("2915908")]
        [Description("Itanagra - BA")]
        Itanagra = 2915908,

        [EnumValue("2916005")]
        [Description("Itanhem - BA")]
        Itanhem = 2916005,

        [EnumValue("2916104")]
        [Description("Itaparica - BA")]
        Itaparica = 2916104,

        [EnumValue("2916203")]
        [Description("Itape - BA")]
        Itape = 2916203,

        [EnumValue("2916401")]
        [Description("Itapetinga - BA")]
        Itapetinga = 2916401,

        [EnumValue("2916500")]
        [Description("Itapicuru - BA")]
        Itapicuru = 2916500,

        [EnumValue("2916708")]
        [Description("Itaquara - BA")]
        Itaquara = 2916708,

        [EnumValue("2916807")]
        [Description("Itarantim - BA")]
        Itarantim = 2916807,

        [EnumValue("2916856")]
        [Description("Itatim - BA")]
        Itatim = 2916856,

        [EnumValue("2916906")]
        [Description("Itirucu - BA")]
        Itirucu = 2916906,

        [EnumValue("2917003")]
        [Description("Itiuba - BA")]
        Itiuba = 2917003,

        [EnumValue("2917102")]
        [Description("Itororo - BA")]
        Itororo = 2917102,

        [EnumValue("2917201")]
        [Description("Ituacu - BA")]
        Ituacu = 2917201,

        [EnumValue("2917300")]
        [Description("Itubera - BA")]
        Itubera = 2917300,

        [EnumValue("2917334")]
        [Description("Iuiu - BA")]
        Iuiu = 2917334,

        [EnumValue("2917508")]
        [Description("Jacobina - BA")]
        Jacobina = 2917508,

        [EnumValue("2917607")]
        [Description("Jaguaquara - BA")]
        Jaguaquara = 2917607,

        [EnumValue("2917706")]
        [Description("Jaguarari - BA")]
        Jaguarari = 2917706,

        [EnumValue("2918001")]
        [Description("Jequie - BA")]
        Jequie = 2918001,

        [EnumValue("2918100")]
        [Description("Jeremoabo - BA")]
        Jeremoabo = 2918100,

        [EnumValue("2918308")]
        [Description("Jitauna - BA")]
        Jitauna = 2918308,

        [EnumValue("2918357")]
        [Description("Joao Dourado - BA")]
        JoaoDourado = 2918357,

        [EnumValue("2918407")]
        [Description("Juazeiro - BA")]
        Juazeiro = 2918407,

        [EnumValue("2918456")]
        [Description("Jucurucu - BA")]
        Jucurucu = 2918456,

        [EnumValue("2918506")]
        [Description("Jussara - BA")]
        Jussara = 2918506,

        [EnumValue("2918555")]
        [Description("Jussari - BA")]
        Jussari = 2918555,

        [EnumValue("2918605")]
        [Description("Jussiape - BA")]
        Jussiape = 2918605,

        [EnumValue("2918704")]
        [Description("Lafaiete Coutinho - BA")]
        LafaieteCoutinho = 2918704,

        [EnumValue("2918803")]
        [Description("Laje - BA")]
        Laje = 2918803,

        [EnumValue("2918902")]
        [Description("Lajedao - BA")]
        Lajedao = 2918902,

        [EnumValue("2919009")]
        [Description("Lajedinho - BA")]
        Lajedinho = 2919009,

        [EnumValue("2919058")]
        [Description("Lajedo do Tabocal - BA")]
        LajedodoTabocal = 2919058,

        [EnumValue("2919108")]
        [Description("Lamarao - BA")]
        Lamarao = 2919108,

        [EnumValue("2919157")]
        [Description("Lapao - BA")]
        Lapao = 2919157,

        [EnumValue("2919207")]
        [Description("Lauro de Freitas - BA")]
        LaurodeFreitas = 2919207,

        [EnumValue("2919306")]
        [Description("Lencois - BA")]
        Lencois = 2919306,

        [EnumValue("2919504")]
        [Description("Livramento de Nossa Senhora - BA")]
        LivramentodeNossaSenhora = 2919504,

        [EnumValue("2919553")]
        [Description("Luis Eduardo Magalhaes - BA")]
        LuisEduardoMagalhaes = 2919553,

        [EnumValue("2919603")]
        [Description("Macajuba - BA")]
        Macajuba = 2919603,

        [EnumValue("2919702")]
        [Description("Macarani - BA")]
        Macarani = 2919702,

        [EnumValue("2919900")]
        [Description("Macurure - BA")]
        Macurure = 2919900,

        [EnumValue("2919926")]
        [Description("Madre de Deus - BA")]
        MadredeDeus = 2919926,

        [EnumValue("2919959")]
        [Description("Maetinga - BA")]
        Maetinga = 2919959,

        [EnumValue("2920007")]
        [Description("Maiquinique - BA")]
        Maiquinique = 2920007,

        [EnumValue("2920304")]
        [Description("Malhada de Pedras - BA")]
        MalhadadePedras = 2920304,

        [EnumValue("2920452")]
        [Description("Mansidao - BA")]
        Mansidao = 2920452,

        [EnumValue("2920502")]
        [Description("Maracas - BA")]
        Maracas = 2920502,

        [EnumValue("2920809")]
        [Description("Marcionilio Souza - BA")]
        MarcionilioSouza = 2920809,

        [EnumValue("2920908")]
        [Description("Mascote - BA")]
        Mascote = 2920908,

        [EnumValue("2921401")]
        [Description("Mirangaba - BA")]
        Mirangaba = 2921401,

        [EnumValue("2921450")]
        [Description("Mirante - BA")]
        Mirante = 2921450,

        [EnumValue("2921500")]
        [Description("Monte Santo - BA")]
        MonteSanto = 2921500,

        [EnumValue("2921708")]
        [Description("Morro do Chapeu - BA")]
        MorrodoChapeu = 2921708,

        [EnumValue("2921906")]
        [Description("Mucuge - BA")]
        Mucuge = 2921906,

        [EnumValue("2922003")]
        [Description("Mucuri - BA")]
        Mucuri = 2922003,

        [EnumValue("2922052")]
        [Description("Mulungu do Morro - BA")]
        MulungudoMorro = 2922052,

        [EnumValue("2922102")]
        [Description("Mundo Novo - BA")]
        MundoNovo = 2922102,

        [EnumValue("2922201")]
        [Description("Muniz Ferreira - BA")]
        MunizFerreira = 2922201,

        [EnumValue("2922250")]
        [Description("Muquem do Sao Francisco - BA")]
        MuquemdoSaoFrancisco = 2922250,

        [EnumValue("2922508")]
        [Description("Nazare - BA")]
        Nazare = 2922508,

        [EnumValue("2922607")]
        [Description("Nilo Pecanha - BA")]
        NiloPecanha = 2922607,

        [EnumValue("2922656")]
        [Description("Nordestina - BA")]
        Nordestina = 2922656,

        [EnumValue("2922706")]
        [Description("Nova Canaa - BA")]
        NovaCanaa = 2922706,

        [EnumValue("2922755")]
        [Description("Nova Ibia - BA")]
        NovaIbia = 2922755,

        [EnumValue("2922854")]
        [Description("Nova Redencao - BA")]
        NovaRedencao = 2922854,

        [EnumValue("2922904")]
        [Description("Nova Soure - BA")]
        NovaSoure = 2922904,

        [EnumValue("2923001")]
        [Description("Nova Vicosa - BA")]
        NovaVicosa = 2923001,

        [EnumValue("2923035")]
        [Description("Novo Horizonte - BA")]
        NovoHorizonte = 2923035,

        [EnumValue("2923050")]
        [Description("Novo Triunfo - BA")]
        NovoTriunfo = 2923050,

        [EnumValue("2923209")]
        [Description("Oliveira dos Brejinhos - BA")]
        OliveiradosBrejinhos = 2923209,

        [EnumValue("2923308")]
        [Description("Ouricangas - BA")]
        Ouricangas = 2923308,

        [EnumValue("2923357")]
        [Description("Ourolandia - BA")]
        Ourolandia = 2923357,

        [EnumValue("2923407")]
        [Description("Palmas de Monte Alto - BA")]
        PalmasdeMonteAlto = 2923407,

        [EnumValue("2923704")]
        [Description("Paratinga - BA")]
        Paratinga = 2923704,

        [EnumValue("2923803")]
        [Description("Paripiranga - BA")]
        Paripiranga = 2923803,

        [EnumValue("2923902")]
        [Description("Pau Brasil - BA")]
        PauBrasil = 2923902,

        [EnumValue("2924009")]
        [Description("Paulo Afonso - BA")]
        PauloAfonso = 2924009,

        [EnumValue("2924058")]
        [Description("Pe de Serra - BA")]
        PedeSerra = 2924058,

        [EnumValue("2924207")]
        [Description("Pedro Alexandre - BA")]
        PedroAlexandre = 2924207,

        [EnumValue("2924405")]
        [Description("Pilao Arcado - BA")]
        PilaoArcado = 2924405,

        [EnumValue("2924504")]
        [Description("Pindai - BA")]
        Pindai = 2924504,

        [EnumValue("2924603")]
        [Description("Pindobacu - BA")]
        Pindobacu = 2924603,

        [EnumValue("2924652")]
        [Description("Pintadas - BA")]
        Pintadas = 2924652,

        [EnumValue("2924801")]
        [Description("Piritiba - BA")]
        Piritiba = 2924801,

        [EnumValue("2925105")]
        [Description("Pocoes - BA")]
        Pocoes = 2925105,

        [EnumValue("2925204")]
        [Description("Pojuca - BA")]
        Pojuca = 2925204,

        [EnumValue("2925253")]
        [Description("Ponto Novo - BA")]
        PontoNovo = 2925253,

        [EnumValue("2925303")]
        [Description("Porto Seguro - BA")]
        PortoSeguro = 2925303,

        [EnumValue("2925402")]
        [Description("Potiragua - BA")]
        Potiragua = 2925402,

        [EnumValue("2925501")]
        [Description("Prado - BA")]
        Prado = 2925501,

        [EnumValue("2925709")]
        [Description("Presidente Janio Quadros - BA")]
        PresidenteJanioQuadros = 2925709,

        [EnumValue("2925758")]
        [Description("Presidente Tancredo Neves - BA")]
        PresidenteTancredoNeves = 2925758,

        [EnumValue("2925907")]
        [Description("Quijingue - BA")]
        Quijingue = 2925907,

        [EnumValue("2925931")]
        [Description("Quixabeira - BA")]
        Quixabeira = 2925931,

        [EnumValue("2926004")]
        [Description("Remanso - BA")]
        Remanso = 2926004,

        [EnumValue("2926103")]
        [Description("Retirolandia - BA")]
        Retirolandia = 2926103,

        [EnumValue("2926202")]
        [Description("Riachao das Neves - BA")]
        RiachaodasNeves = 2926202,

        [EnumValue("2926301")]
        [Description("Riachao do Jacuipe - BA")]
        RiachaodoJacuipe = 2926301,

        [EnumValue("2926400")]
        [Description("Riacho de Santana - BA")]
        RiachodeSantana = 2926400,

        [EnumValue("2926657")]
        [Description("Ribeirao do Largo - BA")]
        RibeiraodoLargo = 2926657,

        [EnumValue("2926806")]
        [Description("Rio do Antonio - BA")]
        RiodoAntonio = 2926806,

        [EnumValue("2927002")]
        [Description("Rio Real - BA")]
        RioReal = 2927002,

        [EnumValue("2927200")]
        [Description("Ruy Barbosa - BA")]
        RuyBarbosa = 2927200,

        [EnumValue("2927309")]
        [Description("Salinas da Margarida - BA")]
        SalinasdaMargarida = 2927309,

        [EnumValue("2927408")]
        [Description("Salvador - BA")]
        Salvador = 2927408,

        [EnumValue("2927606")]
        [Description("Santa Brigida - BA")]
        SantaBrigida = 2927606,

        [EnumValue("2927705")]
        [Description("Santa Cruz Cabralia - BA")]
        SantaCruzCabralia = 2927705,

        [EnumValue("2927804")]
        [Description("Santa Cruz da Vitoria - BA")]
        SantaCruzdaVitoria = 2927804,

        [EnumValue("2927903")]
        [Description("Santa Ines - BA")]
        SantaInes = 2927903,

        [EnumValue("2928000")]
        [Description("Santaluz - BA")]
        Santaluz = 2928000,

        [EnumValue("2928059")]
        [Description("Santa Luzia - BA")]
        SantaLuzia = 2928059,

        [EnumValue("2928109")]
        [Description("Santa Maria da Vitoria - BA")]
        SantaMariadaVitoria = 2928109,

        [EnumValue("2928208")]
        [Description("Santana - BA")]
        Santana_BA = 2928208,

        [EnumValue("2928307")]
        [Description("Santanopolis - BA")]
        Santanopolis = 2928307,

        [EnumValue("2928406")]
        [Description("Santa Rita de Cassia - BA")]
        SantaRitadeCassia = 2928406,

        [EnumValue("2928505")]
        [Description("Santa Terezinha - BA")]
        SantaTerezinha = 2928505,

        [EnumValue("2928703")]
        [Description("Santo Antonio de Jesus - BA")]
        SantoAntoniodeJesus = 2928703,

        [EnumValue("2928802")]
        [Description("Santo Estevao - BA")]
        SantoEstevao = 2928802,

        [EnumValue("2928901")]
        [Description("Sao Desiderio - BA")]
        SaoDesiderio = 2928901,

        [EnumValue("2929057")]
        [Description("Sao Felix do Coribe - BA")]
        SaoFelixdoCoribe = 2929057,

        [EnumValue("2929107")]
        [Description("Sao Felipe - BA")]
        SaoFelipe = 2929107,

        [EnumValue("2929206")]
        [Description("Sao Francisco do Conde - BA")]
        SaoFranciscodoConde = 2929206,

        [EnumValue("2929255")]
        [Description("Sao Gabriel - BA")]
        SaoGabriel = 2929255,

        [EnumValue("2929305")]
        [Description("Sao Goncalo dos Campos - BA")]
        SaoGoncalodosCampos = 2929305,

        [EnumValue("2929370")]
        [Description("Sao Jose do Jacuipe - BA")]
        SaoJosedoJacuipe = 2929370,

        [EnumValue("2929404")]
        [Description("Sao Miguel das Matas - BA")]
        SaoMigueldasMatas = 2929404,

        [EnumValue("2929503")]
        [Description("Sao Sebastiao do Passe - BA")]
        SaoSebastiaodoPasse = 2929503,

        [EnumValue("2929602")]
        [Description("Sapeacu - BA")]
        Sapeacu = 2929602,

        [EnumValue("2929909")]
        [Description("Seabra - BA")]
        Seabra = 2929909,

        [EnumValue("2930006")]
        [Description("Sebastiao Laranjeiras - BA")]
        SebastiaoLaranjeiras = 2930006,

        [EnumValue("2930105")]
        [Description("Senhor do Bonfim - BA")]
        SenhordoBonfim = 2930105,

        [EnumValue("2930154")]
        [Description("Serra do Ramalho - BA")]
        SerradoRamalho = 2930154,

        [EnumValue("2930204")]
        [Description("Sento Se - BA")]
        SentoSe = 2930204,

        [EnumValue("2930501")]
        [Description("Serrinha - BA")]
        Serrinha = 2930501,

        [EnumValue("2930600")]
        [Description("Serrolandia - BA")]
        Serrolandia = 2930600,

        [EnumValue("2930709")]
        [Description("Simoes Filho - BA")]
        SimoesFilho = 2930709,

        [EnumValue("2930758")]
        [Description("Sitio do Mato - BA")]
        SitiodoMato = 2930758,

        [EnumValue("2930766")]
        [Description("Sitio do Quinto - BA")]
        SitiodoQuinto = 2930766,

        [EnumValue("2930774")]
        [Description("Sobradinho - BA")]
        Sobradinho = 2930774,

        [EnumValue("2930808")]
        [Description("Souto Soares - BA")]
        SoutoSoares = 2930808,

        [EnumValue("2930907")]
        [Description("Tabocas do Brejo Velho - BA")]
        TabocasdoBrejoVelho = 2930907,

        [EnumValue("2931004")]
        [Description("Tanhacu - BA")]
        Tanhacu = 2931004,

        [EnumValue("2931103")]
        [Description("Tanquinho - BA")]
        Tanquinho = 2931103,

        [EnumValue("2931301")]
        [Description("Tapiramuta - BA")]
        Tapiramuta = 2931301,

        [EnumValue("2931350")]
        [Description("Teixeira de Freitas - BA")]
        TeixeiradeFreitas = 2931350,

        [EnumValue("2931400")]
        [Description("Teodoro Sampaio - BA")]
        TeodoroSampaio = 2931400,

        [EnumValue("2931509")]
        [Description("Teofilandia - BA")]
        Teofilandia = 2931509,

        [EnumValue("2931608")]
        [Description("Teolandia - BA")]
        Teolandia = 2931608,

        [EnumValue("2931707")]
        [Description("Terra Nova - BA")]
        TerraNova = 2931707,

        [EnumValue("2931806")]
        [Description("Tremedal - BA")]
        Tremedal = 2931806,

        [EnumValue("2932002")]
        [Description("Uaua - BA")]
        Uaua = 2932002,

        [EnumValue("2932200")]
        [Description("Ubaitaba - BA")]
        Ubaitaba = 2932200,

        [EnumValue("2932309")]
        [Description("Ubata - BA")]
        Ubata = 2932309,

        [EnumValue("2932408")]
        [Description("Uibai - BA")]
        Uibai = 2932408,

        [EnumValue("2932457")]
        [Description("Umburanas - BA")]
        Umburanas = 2932457,

        [EnumValue("2932507")]
        [Description("Una - BA")]
        Una = 2932507,

        [EnumValue("2932606")]
        [Description("Urandi - BA")]
        Urandi = 2932606,

        [EnumValue("2932705")]
        [Description("Urucuca - BA")]
        Urucuca = 2932705,

        [EnumValue("2932804")]
        [Description("Utinga - BA")]
        Utinga = 2932804,

        [EnumValue("2932903")]
        [Description("Valenca - BA")]
        Valenca = 2932903,

        [EnumValue("2933000")]
        [Description("Valente - BA")]
        Valente = 2933000,

        [EnumValue("2933059")]
        [Description("Varzea da Roca - BA")]
        VarzeadaRoca = 2933059,

        [EnumValue("2933109")]
        [Description("Varzea do Poco - BA")]
        VarzeadoPoco = 2933109,

        [EnumValue("2933158")]
        [Description("Varzea Nova - BA")]
        VarzeaNova = 2933158,

        [EnumValue("2933208")]
        [Description("Vera Cruz - BA")]
        VeraCruz = 2933208,

        [EnumValue("2933257")]
        [Description("Vereda - BA")]
        Vereda = 2933257,

        [EnumValue("2933307")]
        [Description("Vitoria da Conquista - BA")]
        VitoriadaConquista = 2933307,

        [EnumValue("2933406")]
        [Description("Wagner - BA")]
        Wagner = 2933406,

        [EnumValue("2933455")]
        [Description("Wanderley - BA")]
        Wanderley = 2933455,

        [EnumValue("2933505")]
        [Description("Wenceslau Guimaraes - BA")]
        WenceslauGuimaraes = 2933505,

        //======Ceará======
        [EnumValue("2300101")]
        [Description("Abaiara - CE")]
        Abaiara = 2300101,

        [EnumValue("2300150")]
        [Description("Acarape - CE")]
        Acarape = 2300150,

        [EnumValue("2300200")]
        [Description("Acarau - CE")]
        Acarau = 2300200,

        [EnumValue("2300408")]
        [Description("Aiuaba - CE")]
        Aiuaba = 2300408,

        [EnumValue("2300507")]
        [Description("Alcantaras - CE")]
        Alcantaras = 2300507,

        [EnumValue("2300606")]
        [Description("Altaneira - CE")]
        Altaneira = 2300606,

        [EnumValue("2300754")]
        [Description("Amontada - CE")]
        Amontada = 2300754,

        [EnumValue("2300804")]
        [Description("Antonina do Norte - CE")]
        AntoninadoNorte = 2300804,

        [EnumValue("2300903")]
        [Description("Apuiares - CE")]
        Apuiares = 2300903,

        [EnumValue("2301000")]
        [Description("Aquiraz - CE")]
        Aquiraz = 2301000,

        [EnumValue("2301109")]
        [Description("Aracati - CE")]
        Aracati = 2301109,

        [EnumValue("2301257")]
        [Description("Ararenda - CE")]
        Ararenda = 2301257,

        [EnumValue("2301307")]
        [Description("Araripe - CE")]
        Araripe = 2301307,

        [EnumValue("2301703")]
        [Description("Aurora - CE")]
        Aurora = 2301703,

        [EnumValue("2301802")]
        [Description("Baixio - CE")]
        Baixio = 2301802,

        [EnumValue("2301851")]
        [Description("Banabuiu - CE")]
        Banabuiu = 2301851,

        [EnumValue("2301901")]
        [Description("Barbalha - CE")]
        Barbalha = 2301901,

        [EnumValue("2302008")]
        [Description("Barro - CE")]
        Barro = 2302008,

        [EnumValue("2302057")]
        [Description("Barroquinha - CE")]
        Barroquinha = 2302057,

        [EnumValue("2302107")]
        [Description("Baturite - CE")]
        Baturite = 2302107,

        [EnumValue("2302206")]
        [Description("Beberibe - CE")]
        Beberibe = 2302206,

        [EnumValue("2302305")]
        [Description("Bela Cruz - CE")]
        BelaCruz = 2302305,

        [EnumValue("2302503")]
        [Description("Brejo Santo - CE")]
        BrejoSanto = 2302503,

        [EnumValue("2302701")]
        [Description("Campos Sales - CE")]
        CamposSales = 2302701,

        [EnumValue("2302800")]
        [Description("Caninde - CE")]
        Caninde = 2302800,

        [EnumValue("2302909")]
        [Description("Capistrano - CE")]
        Capistrano = 2302909,

        [EnumValue("2303105")]
        [Description("Carire - CE")]
        Carire = 2303105,

        [EnumValue("2303204")]
        [Description("Caririacu - CE")]
        Caririacu = 2303204,

        [EnumValue("2303303")]
        [Description("Carius - CE")]
        Carius = 2303303,

        [EnumValue("2303402")]
        [Description("Carnaubal - CE")]
        Carnaubal = 2303402,

        [EnumValue("2303501")]
        [Description("Cascavel - CE")]
        Cascavel = 2303501,

        [EnumValue("2303600")]
        [Description("Catarina - CE")]
        Catarina = 2303600,

        [EnumValue("2303659")]
        [Description("Catunda - CE")]
        Catunda = 2303659,

        [EnumValue("2303808")]
        [Description("Cedro - CE")]
        Cedro = 2303808,

        [EnumValue("2303907")]
        [Description("Chaval - CE")]
        Chaval = 2303907,

        [EnumValue("2303956")]
        [Description("Chorozinho - CE")]
        Chorozinho = 2303956,

        [EnumValue("2304103")]
        [Description("Crateus - CE")]
        Crateus = 2304103,

        [EnumValue("2304202")]
        [Description("Crato - CE")]
        Crato = 2304202,

        [EnumValue("2304236")]
        [Description("Croata - CE")]
        Croata = 2304236,

        [EnumValue("2304251")]
        [Description("Cruz - CE")]
        Cruz = 2304251,

        [EnumValue("2304269")]
        [Description("Deputado Irapuan Pinheiro - CE")]
        DeputadoIrapuanPinheiro = 2304269,

        [EnumValue("2304285")]
        [Description("Eusebio - CE")]
        Eusebio = 2304285,

        [EnumValue("2304350")]
        [Description("Forquilha - CE")]
        Forquilha = 2304350,

        [EnumValue("2304400")]
        [Description("Fortaleza - CE")]
        Fortaleza = 2304400,

        [EnumValue("2304509")]
        [Description("Frecheirinha - CE")]
        Frecheirinha = 2304509,

        [EnumValue("2304905")]
        [Description("Groairas - CE")]
        Groairas = 2304905,

        [EnumValue("2304954")]
        [Description("Guaiuba - CE")]
        Guaiuba = 2304954,

        [EnumValue("2305001")]
        [Description("Guaraciaba do Norte - CE")]
        GuaraciabadoNorte = 2305001,

        [EnumValue("2305233")]
        [Description("Horizonte - CE")]
        Horizonte = 2305233,

        [EnumValue("2305308")]
        [Description("Ibiapina - CE")]
        Ibiapina = 2305308,

        [EnumValue("2305332")]
        [Description("Ibicuitinga - CE")]
        Ibicuitinga = 2305332,

        [EnumValue("2305407")]
        [Description("Ico - CE")]
        Ico = 2305407,

        [EnumValue("2305506")]
        [Description("Iguatu - CE")]
        Iguatu = 2305506,

        [EnumValue("2305605")]
        [Description("Independencia - CE")]
        Independencia = 2305605,

        [EnumValue("2305654")]
        [Description("Ipaporanga - CE")]
        Ipaporanga = 2305654,

        [EnumValue("2305704")]
        [Description("Ipaumirim - CE")]
        Ipaumirim = 2305704,

        [EnumValue("2306009")]
        [Description("Iracema - CE")]
        Iracema = 2306009,

        [EnumValue("2306207")]
        [Description("Itaicaba - CE")]
        Itaicaba = 2306207,

        [EnumValue("2306256")]
        [Description("Itaitinga - CE")]
        Itaitinga = 2306256,

        [EnumValue("2306306")]
        [Description("Itapaje - CE")]
        Itapaje = 2306306,

        [EnumValue("2306405")]
        [Description("Itapipoca - CE")]
        Itapipoca = 2306405,

        [EnumValue("2306702")]
        [Description("Jaguaretama - CE")]
        Jaguaretama = 2306702,

        [EnumValue("2307007")]
        [Description("Jaguaruana - CE")]
        Jaguaruana = 2307007,

        [EnumValue("2307254")]
        [Description("Jijoca de Jericoacoara - CE")]
        JijocadeJericoacoara = 2307254,

        [EnumValue("2307304")]
        [Description("Juazeiro do Norte - CE")]
        JuazeirodoNorte = 2307304,

        [EnumValue("2307650")]
        [Description("Maracanau - CE")]
        Maracanau = 2307650,

        [EnumValue("2307700")]
        [Description("Maranguape - CE")]
        Maranguape = 2307700,

        [EnumValue("2307809")]
        [Description("Marco - CE")]
        Marco = 2307809,

        [EnumValue("2307908")]
        [Description("Martinopole - CE")]
        Martinopole = 2307908,

        [EnumValue("2308203")]
        [Description("Meruoca - CE")]
        Meruoca = 2308203,

        [EnumValue("2308351")]
        [Description("Milha - CE")]
        Milha = 2308351,

        [EnumValue("2308377")]
        [Description("Miraima - CE")]
        Miraima = 2308377,

        [EnumValue("2308609")]
        [Description("Monsenhor Tabosa - CE")]
        MonsenhorTabosa = 2308609,

        [EnumValue("2308807")]
        [Description("Moraujo - CE")]
        Moraujo = 2308807,

        [EnumValue("2308906")]
        [Description("Morrinhos - CE")]
        Morrinhos = 2308906,

        [EnumValue("2309003")]
        [Description("Mucambo - CE")]
        Mucambo = 2309003,

        [EnumValue("2309102")]
        [Description("Mulungu - CE")]
        Mulungu = 2309102,

        [EnumValue("2309300")]
        [Description("Nova Russas - CE")]
        NovaRussas = 2309300,

        [EnumValue("2309409")]
        [Description("Novo Oriente - CE")]
        NovoOriente = 2309409,

        [EnumValue("2309458")]
        [Description("Ocara - CE")]
        Ocara = 2309458,

        [EnumValue("2309508")]
        [Description("Oros - CE")]
        Oros = 2309508,

        [EnumValue("2310209")]
        [Description("Paracuru - CE")]
        Paracuru = 2310209,

        [EnumValue("2310704")]
        [Description("Pentecoste - CE")]
        Pentecoste = 2310704,

        [EnumValue("2310803")]
        [Description("Pereiro - CE")]
        Pereiro = 2310803,

        [EnumValue("2310852")]
        [Description("Pindoretama - CE")]
        Pindoretama = 2310852,

        [EnumValue("2310902")]
        [Description("Piquet Carneiro - CE")]
        PiquetCarneiro = 2310902,

        [EnumValue("2310951")]
        [Description("Pires Ferreira - CE")]
        PiresFerreira = 2310951,

        [EnumValue("2311009")]
        [Description("Poranga - CE")]
        Poranga = 2311009,

        [EnumValue("2311231")]
        [Description("Potiretama - CE")]
        Potiretama = 2311231,

        [EnumValue("2311405")]
        [Description("Quixeramobim - CE")]
        Quixeramobim = 2311405,

        [EnumValue("2311504")]
        [Description("Quixere - CE")]
        Quixere = 2311504,

        [EnumValue("2311801")]
        [Description("Russas - CE")]
        Russas = 2311801,

        [EnumValue("2311900")]
        [Description("Saboeiro - CE")]
        Saboeiro = 2311900,

        [EnumValue("2311959")]
        [Description("Salitre - CE")]
        Salitre = 2311959,

        [EnumValue("2312205")]
        [Description("Santa Quiteria - CE")]
        SantaQuiteria = 2312205,

        [EnumValue("2312304")]
        [Description("Sao Benedito - CE")]
        SaoBenedito = 2312304,

        [EnumValue("2312809")]
        [Description("Senador Sa - CE")]
        SenadorSa = 2312809,

        [EnumValue("2312908")]
        [Description("Sobral - CE")]
        Sobral = 2312908,

        [EnumValue("2313252")]
        [Description("Tarrafas - CE")]
        Tarrafas = 2313252,

        [EnumValue("2313302")]
        [Description("Taua - CE")]
        Taua = 2313302,

        [EnumValue("2313401")]
        [Description("Tiangua - CE")]
        Tiangua = 2313401,

        [EnumValue("2313500")]
        [Description("Trairi - CE")]
        Trairi = 2313500,

        [EnumValue("2313609")]
        [Description("Ubajara - CE")]
        Ubajara = 2313609,

        [EnumValue("2313757")]
        [Description("Umirim - CE")]
        Umirim = 2313757,

        [EnumValue("2314102")]
        [Description("Vicosa do Ceara - CE")]
        VicosadoCeara = 2314102,

        //======Espírito Santo======
        [EnumValue("3200102")]
        [Description("Afonso Claudio - ES")]
        AfonsoClaudio = 3200102,

        [EnumValue("3200136")]
        [Description("Aguia Branca - ES")]
        AguiaBranca = 3200136,

        [EnumValue("3200169")]
        [Description("Agua Doce do Norte - ES")]
        AguaDocedoNorte = 3200169,

        [EnumValue("3200201")]
        [Description("Alegre - ES")]
        Alegre = 3200201,

        [EnumValue("3200300")]
        [Description("Alfredo Chaves - ES")]
        AlfredoChaves = 3200300,

        [EnumValue("3200359")]
        [Description("Alto Rio Novo - ES")]
        AltoRioNovo = 3200359,

        [EnumValue("3200409")]
        [Description("Anchieta - ES")]
        Anchieta = 3200409,

        [EnumValue("3200508")]
        [Description("Apiaca - ES")]
        Apiaca = 3200508,

        [EnumValue("3200607")]
        [Description("Aracruz - ES")]
        Aracruz = 3200607,

        [EnumValue("3200706")]
        [Description("Atilio Vivacqua - ES")]
        AtilioVivacqua = 3200706,

        [EnumValue("3200805")]
        [Description("Baixo Guandu - ES")]
        BaixoGuandu = 3200805,

        [EnumValue("3200904")]
        [Description("Barra de Sao Francisco - ES")]
        BarradeSaoFrancisco = 3200904,

        [EnumValue("3201001")]
        [Description("Boa Esperanca - ES")]
        BoaEsperanca = 3201001,

        [EnumValue("3201100")]
        [Description("Bom Jesus do Norte - ES")]
        BomJesusdoNorte = 3201100,

        [EnumValue("3201159")]
        [Description("Brejetuba - ES")]
        Brejetuba = 3201159,

        [EnumValue("3201209")]
        [Description("Cachoeiro de Itapemirim - ES")]
        CachoeirodeItapemirim = 3201209,

        [EnumValue("3201308")]
        [Description("Cariacica - ES")]
        Cariacica = 3201308,

        [EnumValue("3201407")]
        [Description("Castelo - ES")]
        Castelo = 3201407,

        [EnumValue("3201506")]
        [Description("Colatina - ES")]
        Colatina = 3201506,

        [EnumValue("3201605")]
        [Description("Conceicao da Barra - ES")]
        ConceicaodaBarra = 3201605,

        [EnumValue("3201704")]
        [Description("Conceicao do Castelo - ES")]
        ConceicaodoCastelo = 3201704,

        [EnumValue("3201803")]
        [Description("Divino de Sao Lourenco - ES")]
        DivinodeSaoLourenco = 3201803,

        [EnumValue("3201902")]
        [Description("Domingos Martins - ES")]
        DomingosMartins = 3201902,

        [EnumValue("3202009")]
        [Description("Dores do Rio Preto - ES")]
        DoresdoRioPreto = 3202009,

        [EnumValue("3202108")]
        [Description("Ecoporanga - ES")]
        Ecoporanga = 3202108,

        [EnumValue("3202207")]
        [Description("Fundao - ES")]
        Fundao = 3202207,

        [EnumValue("3202256")]
        [Description("Governador Lindenberg - ES")]
        GovernadorLindenberg = 3202256,

        [EnumValue("3202306")]
        [Description("Guacui - ES")]
        Guacui = 3202306,

        [EnumValue("3202405")]
        [Description("Guarapari - ES")]
        Guarapari = 3202405,

        [EnumValue("3202454")]
        [Description("Ibatiba - ES")]
        Ibatiba = 3202454,

        [EnumValue("3202504")]
        [Description("Ibiracu - ES")]
        Ibiracu = 3202504,

        [EnumValue("3202553")]
        [Description("Ibitirama - ES")]
        Ibitirama = 3202553,

        [EnumValue("3202603")]
        [Description("Iconha - ES")]
        Iconha = 3202603,

        [EnumValue("3202652")]
        [Description("Irupi - ES")]
        Irupi = 3202652,

        [EnumValue("3202801")]
        [Description("Itapemirim - ES")]
        Itapemirim = 3202801,

        [EnumValue("3202900")]
        [Description("Itarana - ES")]
        Itarana = 3202900,

        [EnumValue("3203007")]
        [Description("Iuna - ES")]
        Iuna = 3203007,

        [EnumValue("3203056")]
        [Description("Jaguare - ES")]
        Jaguare = 3203056,

        [EnumValue("3203106")]
        [Description("Jeronimo Monteiro - ES")]
        JeronimoMonteiro = 3203106,

        [EnumValue("3203130")]
        [Description("Joao Neiva - ES")]
        JoaoNeiva = 3203130,

        [EnumValue("3203163")]
        [Description("Laranja da Terra - ES")]
        LaranjadaTerra = 3203163,

        [EnumValue("3203205")]
        [Description("Linhares - ES")]
        Linhares = 3203205,

        [EnumValue("3203304")]
        [Description("Mantenopolis - ES")]
        Mantenopolis = 3203304,

        [EnumValue("3203320")]
        [Description("Marataizes - ES")]
        Marataizes = 3203320,

        [EnumValue("3203346")]
        [Description("Marechal Floriano - ES")]
        MarechalFloriano = 3203346,

        [EnumValue("3203353")]
        [Description("Marilandia - ES")]
        Marilandia = 3203353,

        [EnumValue("3203403")]
        [Description("Mimoso do Sul - ES")]
        MimosodoSul = 3203403,

        [EnumValue("3203502")]
        [Description("Montanha - ES")]
        Montanha = 3203502,

        [EnumValue("3203601")]
        [Description("Mucurici - ES")]
        Mucurici = 3203601,

        [EnumValue("3203700")]
        [Description("Muniz Freire - ES")]
        MunizFreire = 3203700,

        [EnumValue("3203809")]
        [Description("Muqui - ES")]
        Muqui = 3203809,

        [EnumValue("3203908")]
        [Description("Nova Venecia - ES")]
        NovaVenecia = 3203908,

        [EnumValue("3204005")]
        [Description("Pancas - ES")]
        Pancas = 3204005,

        [EnumValue("3204054")]
        [Description("Pedro Canario - ES")]
        PedroCanario = 3204054,

        [EnumValue("3204104")]
        [Description("Pinheiros - ES")]
        Pinheiros = 3204104,

        [EnumValue("3204203")]
        [Description("Piuma - ES")]
        Piuma = 3204203,

        [EnumValue("3204252")]
        [Description("Ponto Belo - ES")]
        PontoBelo = 3204252,

        [EnumValue("3204302")]
        [Description("Presidente Kennedy - ES")]
        PresidenteKennedy = 3204302,

        [EnumValue("3204351")]
        [Description("Rio Bananal - ES")]
        RioBananal = 3204351,

        [EnumValue("3204401")]
        [Description("Rio Novo do Sul - ES")]
        RioNovodoSul = 3204401,

        [EnumValue("3204500")]
        [Description("Santa Leopoldina - ES")]
        SantaLeopoldina = 3204500,

        [EnumValue("3204559")]
        [Description("Santa Maria de Jetiba - ES")]
        SantaMariadeJetiba = 3204559,

        [EnumValue("3204609")]
        [Description("Santa Teresa - ES")]
        SantaTeresa = 3204609,

        [EnumValue("3204658")]
        [Description("Sao Domingos do Norte - ES")]
        SaoDomingosdoNorte = 3204658,

        [EnumValue("3204708")]
        [Description("Sao Gabriel da Palha - ES")]
        SaoGabrieldaPalha = 3204708,

        [EnumValue("3204807")]
        [Description("Sao Jose do Calcado - ES")]
        SaoJosedoCalcado = 3204807,

        [EnumValue("3204906")]
        [Description("Sao Mateus - ES")]
        SaoMateus = 3204906,

        [EnumValue("3204955")]
        [Description("Sao Roque do Canaa - ES")]
        SaoRoquedoCanaa = 3204955,

        [EnumValue("3205002")]
        [Description("Serra - ES")]
        Serra = 3205002,

        [EnumValue("3205010")]
        [Description("Sooretama - ES")]
        Sooretama = 3205010,

        [EnumValue("3205036")]
        [Description("Vargem Alta - ES")]
        VargemAlta = 3205036,

        [EnumValue("3205069")]
        [Description("Venda Nova do Imigrante - ES")]
        VendaNovadoImigrante = 3205069,

        [EnumValue("3205101")]
        [Description("Viana - ES")]
        Viana = 3205101,

        [EnumValue("3205176")]
        [Description("Vila Valerio - ES")]
        VilaValerio = 3205176,

        [EnumValue("3205200")]
        [Description("Vila Velha - ES")]
        VilaVelha = 3205200,

        [EnumValue("3205309")]
        [Description("Vitoria - ES")]
        Vitoria = 3205309,

        //======Goiás======
        [EnumValue("5200050")]
        [Description("Abadia de Goias - GO")]
        AbadiadeGoias = 5200050,

        [EnumValue("5200100")]
        [Description("Abadiania - GO")]
        Abadiania = 5200100,

        [EnumValue("5200134")]
        [Description("Acreuna - GO")]
        Acreuna = 5200134,

        [EnumValue("5200159")]
        [Description("Adelandia - GO")]
        Adelandia = 5200159,

        [EnumValue("5200209")]
        [Description("Agua Limpa - GO")]
        AguaLimpa = 5200209,

        [EnumValue("5200258")]
        [Description("Aguas Lindas de Goias - GO")]
        AguasLindasdeGoias = 5200258,

        [EnumValue("5200308")]
        [Description("Alexania - GO")]
        Alexania = 5200308,

        [EnumValue("5200506")]
        [Description("Aloandia - GO")]
        Aloandia = 5200506,

        [EnumValue("5200555")]
        [Description("Alto Horizonte - GO")]
        AltoHorizonte = 5200555,

        [EnumValue("5200605")]
        [Description("Alto Paraiso de Goias - GO")]
        AltoParaisodeGoias = 5200605,

        [EnumValue("5200803")]
        [Description("Alvorada do Norte - GO")]
        AlvoradadoNorte = 5200803,

        [EnumValue("5200829")]
        [Description("Amaralina - GO")]
        Amaralina = 5200829,

        [EnumValue("5200902")]
        [Description("Amorinopolis - GO")]
        Amorinopolis = 5200902,

        [EnumValue("5201108")]
        [Description("Anapolis - GO")]
        Anapolis = 5201108,

        [EnumValue("5201207")]
        [Description("Anhanguera - GO")]
        Anhanguera = 5201207,

        [EnumValue("5201306")]
        [Description("Anicuns - GO")]
        Anicuns = 5201306,

        [EnumValue("5201405")]
        [Description("Aparecida de Goiania - GO")]
        AparecidadeGoiania = 5201405,

        [EnumValue("5201454")]
        [Description("Aparecida do Rio Doce - GO")]
        AparecidadoRioDoce = 5201454,

        [EnumValue("5201504")]
        [Description("Apore - GO")]
        Apore = 5201504,

        [EnumValue("5201603")]
        [Description("Aracu - GO")]
        Aracu = 5201603,

        [EnumValue("5201702")]
        [Description("Aragarcas - GO")]
        Aragarcas = 5201702,

        [EnumValue("5201801")]
        [Description("Aragoiania - GO")]
        Aragoiania = 5201801,

        [EnumValue("5202353")]
        [Description("Arenopolis - GO")]
        Arenopolis = 5202353,

        [EnumValue("5202502")]
        [Description("Aruana - GO")]
        Aruana = 5202502,

        [EnumValue("5202601")]
        [Description("Aurilandia - GO")]
        Aurilandia = 5202601,

        [EnumValue("5202809")]
        [Description("Avelinopolis - GO")]
        Avelinopolis = 5202809,

        [EnumValue("5203104")]
        [Description("Baliza - GO")]
        Baliza = 5203104,

        [EnumValue("5203302")]
        [Description("Bela Vista de Goias - GO")]
        BelaVistadeGoias = 5203302,

        [EnumValue("5203401")]
        [Description("Bom Jardim de Goias - GO")]
        BomJardimdeGoias = 5203401,

        [EnumValue("5203500")]
        [Description("Bom Jesus de Goias - GO")]
        BomJesusdeGoias = 5203500,

        [EnumValue("5203559")]
        [Description("Bonfinopolis - GO")]
        Bonfinopolis = 5203559,

        [EnumValue("5203575")]
        [Description("Bonopolis - GO")]
        Bonopolis = 5203575,

        [EnumValue("5203609")]
        [Description("Brazabrantes - GO")]
        Brazabrantes = 5203609,

        [EnumValue("5203807")]
        [Description("Britania - GO")]
        Britania = 5203807,

        [EnumValue("5203906")]
        [Description("Buriti Alegre - GO")]
        BuritiAlegre = 5203906,

        [EnumValue("5203939")]
        [Description("Buriti de Goias - GO")]
        BuritideGoias = 5203939,

        [EnumValue("5203962")]
        [Description("Buritinopolis - GO")]
        Buritinopolis = 5203962,

        [EnumValue("5204003")]
        [Description("Cabeceiras - GO")]
        Cabeceiras = 5204003,

        [EnumValue("5204102")]
        [Description("Cachoeira Alta - GO")]
        CachoeiraAlta = 5204102,

        [EnumValue("5204201")]
        [Description("Cachoeira de Goias - GO")]
        CachoeiradeGoias = 5204201,

        [EnumValue("5204300")]
        [Description("Cacu - GO")]
        Cacu = 5204300,

        [EnumValue("5204409")]
        [Description("Caiaponia - GO")]
        Caiaponia = 5204409,

        [EnumValue("5204508")]
        [Description("Caldas Novas - GO")]
        CaldasNovas = 5204508,

        [EnumValue("5204557")]
        [Description("Caldazinha - GO")]
        Caldazinha = 5204557,

        [EnumValue("5204607")]
        [Description("Campestre de Goias - GO")]
        CampestredeGoias = 5204607,

        [EnumValue("5204706")]
        [Description("Campinorte - GO")]
        Campinorte = 5204706,

        [EnumValue("5204805")]
        [Description("Campo Alegre de Goias - GO")]
        CampoAlegredeGoias = 5204805,

        [EnumValue("5204904")]
        [Description("Campos Belos - GO")]
        CamposBelos = 5204904,

        [EnumValue("5205000")]
        [Description("Carmo do Rio Verde - GO")]
        CarmodoRioVerde = 5205000,

        [EnumValue("5205059")]
        [Description("Castelandia - GO")]
        Castelandia = 5205059,

        [EnumValue("5205109")]
        [Description("Catalao - GO")]
        Catalao = 5205109,

        [EnumValue("5205208")]
        [Description("Caturai - GO")]
        Caturai = 5205208,

        [EnumValue("5205307")]
        [Description("Cavalcante - GO")]
        Cavalcante = 5205307,

        [EnumValue("5205406")]
        [Description("Ceres - GO")]
        Ceres = 5205406,

        [EnumValue("5205455")]
        [Description("Cezarina - GO")]
        Cezarina = 5205455,

        [EnumValue("5205471")]
        [Description("Chapadao do Ceu - GO")]
        ChapadaodoCeu = 5205471,

        [EnumValue("5205497")]
        [Description("Cidade Ocidental - GO")]
        CidadeOcidental = 5205497,

        [EnumValue("5205513")]
        [Description("Cocalzinho de Goias - GO")]
        CocalzinhodeGoias = 5205513,

        [EnumValue("5205521")]
        [Description("Colinas do Sul - GO")]
        ColinasdoSul = 5205521,

        [EnumValue("5205703")]
        [Description("Corrego do Ouro - GO")]
        CorregodoOuro = 5205703,

        [EnumValue("5205802")]
        [Description("Corumba de Goias - GO")]
        CorumbadeGoias = 5205802,

        [EnumValue("5205901")]
        [Description("Corumbaiba - GO")]
        Corumbaiba = 5205901,

        [EnumValue("5206206")]
        [Description("Cristalina - GO")]
        Cristalina = 5206206,

        [EnumValue("5206305")]
        [Description("Cristianopolis - GO")]
        Cristianopolis = 5206305,

        [EnumValue("5206404")]
        [Description("Crixas - GO")]
        Crixas = 5206404,

        [EnumValue("5206503")]
        [Description("Crominia - GO")]
        Crominia = 5206503,

        [EnumValue("5206602")]
        [Description("Cumari - GO")]
        Cumari = 5206602,

        [EnumValue("5206701")]
        [Description("Damianopolis - GO")]
        Damianopolis = 5206701,

        [EnumValue("5206800")]
        [Description("Damolandia - GO")]
        Damolandia = 5206800,

        [EnumValue("5206909")]
        [Description("Davinopolis - GO")]
        Davinopolis = 5206909,

        [EnumValue("5207105")]
        [Description("Diorama - GO")]
        Diorama = 5207105,

        [EnumValue("5207253")]
        [Description("Doverlandia - GO")]
        Doverlandia = 5207253,

        [EnumValue("5207352")]
        [Description("Edealina - GO")]
        Edealina = 5207352,

        [EnumValue("5207402")]
        [Description("Edeia - GO")]
        Edeia = 5207402,

        [EnumValue("5207501")]
        [Description("Estrela do Norte - GO")]
        EstreladoNorte = 5207501,

        [EnumValue("5207535")]
        [Description("Faina - GO")]
        Faina = 5207535,

        [EnumValue("5207600")]
        [Description("Fazenda Nova - GO")]
        FazendaNova = 5207600,

        [EnumValue("5207808")]
        [Description("Firminopolis - GO")]
        Firminopolis = 5207808,

        [EnumValue("5207907")]
        [Description("Flores de Goias - GO")]
        FloresdeGoias = 5207907,

        [EnumValue("5208004")]
        [Description("Formosa - GO")]
        Formosa = 5208004,

        [EnumValue("5208103")]
        [Description("Formoso - GO")]
        Formoso = 5208103,

        [EnumValue("5208152")]
        [Description("Gameleira de Goias - GO")]
        GameleiradeGoias = 5208152,

        [EnumValue("5208301")]
        [Description("Divinopolis de Goias - GO")]
        DivinopolisdeGoias = 5208301,

        [EnumValue("5208400")]
        [Description("Goianapolis - GO")]
        Goianapolis = 5208400,

        [EnumValue("5208509")]
        [Description("Goiandira - GO")]
        Goiandira = 5208509,

        [EnumValue("5208608")]
        [Description("Goianesia - GO")]
        Goianesia = 5208608,

        [EnumValue("5208707")]
        [Description("Goiania - GO")]
        Goiania = 5208707,

        [EnumValue("5208806")]
        [Description("Goianira - GO")]
        Goianira = 5208806,

        [EnumValue("5208905")]
        [Description("Goias - GO")]
        Goias = 5208905,

        [EnumValue("5209101")]
        [Description("Goiatuba - GO")]
        Goiatuba = 5209101,

        [EnumValue("5209291")]
        [Description("Guaraita - GO")]
        Guaraita = 5209291,

        [EnumValue("5209408")]
        [Description("Guarani de Goias - GO")]
        GuaranideGoias = 5209408,

        [EnumValue("5209457")]
        [Description("Guarinos - GO")]
        Guarinos = 5209457,

        [EnumValue("5209606")]
        [Description("Heitorai - GO")]
        Heitorai = 5209606,

        [EnumValue("5209705")]
        [Description("Hidrolandia - GO")]
        Hidrolandia_GO = 5209705,

        [EnumValue("5209804")]
        [Description("Hidrolina - GO")]
        Hidrolina = 5209804,

        [EnumValue("5209903")]
        [Description("Iaciara - GO")]
        Iaciara = 5209903,

        [EnumValue("5209937")]
        [Description("Inaciolandia - GO")]
        Inaciolandia = 5209937,

        [EnumValue("5209952")]
        [Description("Indiara - GO")]
        Indiara = 5209952,

        [EnumValue("5210000")]
        [Description("Inhumas - GO")]
        Inhumas = 5210000,

        [EnumValue("5210109")]
        [Description("Ipameri - GO")]
        Ipameri = 5210109,

        [EnumValue("5210158")]
        [Description("Ipiranga de Goias - GO")]
        IpirangadeGoias = 5210158,

        [EnumValue("5210208")]
        [Description("Ipora - GO")]
        Ipora = 5210208,

        [EnumValue("5210307")]
        [Description("Israelandia - GO")]
        Israelandia = 5210307,

        [EnumValue("5210406")]
        [Description("Itaberai - GO")]
        Itaberai = 5210406,

        [EnumValue("5210562")]
        [Description("Itaguari - GO")]
        Itaguari = 5210562,

        [EnumValue("5210604")]
        [Description("Itaguaru - GO")]
        Itaguaru = 5210604,

        [EnumValue("5210802")]
        [Description("Itaja - GO")]
        Itaja = 5210802,

        [EnumValue("5210901")]
        [Description("Itapaci - GO")]
        Itapaci = 5210901,

        [EnumValue("5211008")]
        [Description("Itapirapua - GO")]
        Itapirapua = 5211008,

        [EnumValue("5211206")]
        [Description("Itapuranga - GO")]
        Itapuranga = 5211206,

        [EnumValue("5211305")]
        [Description("Itaruma - GO")]
        Itaruma = 5211305,

        [EnumValue("5211404")]
        [Description("Itaucu - GO")]
        Itaucu = 5211404,

        [EnumValue("5211503")]
        [Description("Itumbiara - GO")]
        Itumbiara = 5211503,

        [EnumValue("5211602")]
        [Description("Ivolandia - GO")]
        Ivolandia = 5211602,

        [EnumValue("5211701")]
        [Description("Jandaia - GO")]
        Jandaia = 5211701,

        [EnumValue("5211800")]
        [Description("Jaragua - GO")]
        Jaragua = 5211800,

        [EnumValue("5211909")]
        [Description("Jatai - GO")]
        Jatai = 5211909,

        [EnumValue("5212006")]
        [Description("Jaupaci - GO")]
        Jaupaci = 5212006,

        [EnumValue("5212055")]
        [Description("Jesupolis - GO")]
        Jesupolis = 5212055,

        [EnumValue("5212105")]
        [Description("Joviania - GO")]
        Joviania = 5212105,

        [EnumValue("5212204")]
        [Description("Jussara - GO")]
        Jussara_GO = 5212204,

        [EnumValue("5212253")]
        [Description("Lagoa Santa - GO")]
        LagoaSanta = 5212253,

        [EnumValue("5212303")]
        [Description("Leopoldo de Bulhoes - GO")]
        LeopoldodeBulhoes = 5212303,

        [EnumValue("5212501")]
        [Description("Luziania - GO")]
        Luziania = 5212501,

        [EnumValue("5212600")]
        [Description("Mairipotaba - GO")]
        Mairipotaba = 5212600,

        [EnumValue("5212709")]
        [Description("Mambai - GO")]
        Mambai = 5212709,

        [EnumValue("5212808")]
        [Description("Mara Rosa - GO")]
        MaraRosa = 5212808,

        [EnumValue("5212907")]
        [Description("Marzagao - GO")]
        Marzagao = 5212907,

        [EnumValue("5212956")]
        [Description("Matrincha - GO")]
        Matrincha = 5212956,

        [EnumValue("5213004")]
        [Description("Maurilandia - GO")]
        Maurilandia = 5213004,

        [EnumValue("5213053")]
        [Description("Mimoso de Goias - GO")]
        MimosodeGoias = 5213053,

        [EnumValue("5213087")]
        [Description("Minacu - GO")]
        Minacu = 5213087,

        [EnumValue("5213103")]
        [Description("Mineiros - GO")]
        Mineiros = 5213103,

        [EnumValue("5213400")]
        [Description("Moipora - GO")]
        Moipora = 5213400,

        [EnumValue("5213509")]
        [Description("Monte Alegre de Goias - GO")]
        MonteAlegredeGoias = 5213509,

        [EnumValue("5213707")]
        [Description("Montes Claros de Goias - GO")]
        MontesClarosdeGoias = 5213707,

        [EnumValue("5213756")]
        [Description("Montividiu - GO")]
        Montividiu = 5213756,

        [EnumValue("5213772")]
        [Description("Montividiu do Norte - GO")]
        MontividiudoNorte = 5213772,

        [EnumValue("5213806")]
        [Description("Morrinhos - GO")]
        Morrinhos_GO = 5213806,

        [EnumValue("5213855")]
        [Description("Morro Agudo de Goias - GO")]
        MorroAgudodeGoias = 5213855,

        [EnumValue("5213905")]
        [Description("Mossamedes - GO")]
        Mossamedes = 5213905,

        [EnumValue("5214002")]
        [Description("Mozarlandia - GO")]
        Mozarlandia = 5214002,

        [EnumValue("5214051")]
        [Description("Mundo Novo - GO")]
        MundoNovo_GO = 5214051,

        [EnumValue("5214101")]
        [Description("Mutunopolis - GO")]
        Mutunopolis = 5214101,

        [EnumValue("5214408")]
        [Description("Nazario - GO")]
        Nazario = 5214408,

        [EnumValue("5214507")]
        [Description("Neropolis - GO")]
        Neropolis = 5214507,

        [EnumValue("5214606")]
        [Description("Niquelandia - GO")]
        Niquelandia = 5214606,

        [EnumValue("5214705")]
        [Description("Nova America - GO")]
        NovaAmerica = 5214705,

        [EnumValue("5214804")]
        [Description("Nova Aurora - GO")]
        NovaAurora = 5214804,

        [EnumValue("5214838")]
        [Description("Nova Crixas - GO")]
        NovaCrixas = 5214838,

        [EnumValue("5214861")]
        [Description("Nova Gloria - GO")]
        NovaGloria = 5214861,

        [EnumValue("5214879")]
        [Description("Nova Iguacu de Goias - GO")]
        NovaIguacudeGoias = 5214879,

        [EnumValue("5214903")]
        [Description("Nova Roma - GO")]
        NovaRoma = 5214903,

        [EnumValue("5215009")]
        [Description("Nova Veneza - GO")]
        NovaVeneza = 5215009,

        [EnumValue("5215207")]
        [Description("Novo Brasil - GO")]
        NovoBrasil = 5215207,

        [EnumValue("5215231")]
        [Description("Novo Gama - GO")]
        NovoGama = 5215231,

        [EnumValue("5215256")]
        [Description("Novo Planalto - GO")]
        NovoPlanalto = 5215256,

        [EnumValue("5215306")]
        [Description("Orizona - GO")]
        Orizona = 5215306,

        [EnumValue("5215405")]
        [Description("Ouro Verde de Goias - GO")]
        OuroVerdedeGoias = 5215405,

        [EnumValue("5215504")]
        [Description("Ouvidor - GO")]
        Ouvidor = 5215504,

        [EnumValue("5215603")]
        [Description("Padre Bernardo - GO")]
        PadreBernardo = 5215603,

        [EnumValue("5215652")]
        [Description("Palestina de Goias - GO")]
        PalestinadeGoias = 5215652,

        [EnumValue("5215702")]
        [Description("Palmeiras de Goias - GO")]
        PalmeirasdeGoias = 5215702,

        [EnumValue("5215801")]
        [Description("Palmelo - GO")]
        Palmelo = 5215801,

        [EnumValue("5215900")]
        [Description("Palminopolis - GO")]
        Palminopolis = 5215900,

        [EnumValue("5216304")]
        [Description("Paranaiguara - GO")]
        Paranaiguara = 5216304,

        [EnumValue("5216403")]
        [Description("Parauna - GO")]
        Parauna = 5216403,

        [EnumValue("5216452")]
        [Description("Perolandia - GO")]
        Perolandia = 5216452,

        [EnumValue("5216809")]
        [Description("Petrolina de Goias - GO")]
        PetrolinadeGoias = 5216809,

        [EnumValue("5217104")]
        [Description("Piracanjuba - GO")]
        Piracanjuba = 5217104,

        [EnumValue("5217203")]
        [Description("Piranhas - GO")]
        Piranhas_GO = 5217203,

        [EnumValue("5217302")]
        [Description("Pirenopolis - GO")]
        Pirenopolis = 5217302,

        [EnumValue("5217401")]
        [Description("Pires do Rio - GO")]
        PiresdoRio = 5217401,

        [EnumValue("5217609")]
        [Description("Planaltina - GO")]
        Planaltina = 5217609,

        [EnumValue("5217708")]
        [Description("Pontalina - GO")]
        Pontalina = 5217708,

        [EnumValue("5218003")]
        [Description("Porangatu - GO")]
        Porangatu = 5218003,

        [EnumValue("5218052")]
        [Description("Porteirao - GO")]
        Porteirao = 5218052,

        [EnumValue("5218102")]
        [Description("Portelandia - GO")]
        Portelandia = 5218102,

        [EnumValue("5218300")]
        [Description("Posse - GO")]
        Posse = 5218300,

        [EnumValue("5218391")]
        [Description("Professor Jamil - GO")]
        ProfessorJamil = 5218391,

        [EnumValue("5218508")]
        [Description("Quirinopolis - GO")]
        Quirinopolis = 5218508,

        [EnumValue("5218607")]
        [Description("Rialma - GO")]
        Rialma = 5218607,

        [EnumValue("5218706")]
        [Description("Rianapolis - GO")]
        Rianapolis = 5218706,

        [EnumValue("5218789")]
        [Description("Rio Quente - GO")]
        RioQuente = 5218789,

        [EnumValue("5218805")]
        [Description("Rio Verde - GO")]
        RioVerde = 5218805,

        [EnumValue("5218904")]
        [Description("Rubiataba - GO")]
        Rubiataba = 5218904,

        [EnumValue("5219001")]
        [Description("Sanclerlandia - GO")]
        Sanclerlandia = 5219001,

        [EnumValue("5219100")]
        [Description("Santa Barbara de Goias - GO")]
        SantaBarbaradeGoias = 5219100,

        [EnumValue("5219209")]
        [Description("Santa Cruz de Goias - GO")]
        SantaCruzdeGoias = 5219209,

        [EnumValue("5219258")]
        [Description("Santa Fe de Goias - GO")]
        SantaFedeGoias = 5219258,

        [EnumValue("5219308")]
        [Description("Santa Helena de Goias - GO")]
        SantaHelenadeGoias = 5219308,

        [EnumValue("5219357")]
        [Description("Santa Isabel - GO")]
        SantaIsabel = 5219357,

        [EnumValue("5219407")]
        [Description("Santa Rita do Araguaia - GO")]
        SantaRitadoAraguaia = 5219407,

        [EnumValue("5219456")]
        [Description("Santa Rita do Novo Destino - GO")]
        SantaRitadoNovoDestino = 5219456,

        [EnumValue("5219506")]
        [Description("Santa Rosa de Goias - GO")]
        SantaRosadeGoias = 5219506,

        [EnumValue("5219605")]
        [Description("Santa Tereza de Goias - GO")]
        SantaTerezadeGoias = 5219605,

        [EnumValue("5219704")]
        [Description("Santa Terezinha de Goias - GO")]
        SantaTerezinhadeGoias = 5219704,

        [EnumValue("5219712")]
        [Description("Santo Antonio da Barra - GO")]
        SantoAntoniodaBarra = 5219712,

        [EnumValue("5219738")]
        [Description("Santo Antonio de Goias - GO")]
        SantoAntoniodeGoias = 5219738,

        [EnumValue("5219753")]
        [Description("Santo Antonio do Descoberto - GO")]
        SantoAntoniodoDescoberto = 5219753,

        [EnumValue("5219803")]
        [Description("Sao Domingos - GO")]
        SaoDomingos_GO = 5219803,

        [EnumValue("5219902")]
        [Description("Sao Francisco de Goias - GO")]
        SaoFranciscodeGoias = 5219902,

        [EnumValue("5220009")]
        [Description("Sao Joao dAlianca - GO")]
        SaoJoaodAlianca = 5220009,

        [EnumValue("5220058")]
        [Description("Sao Joao da Parauna - GO")]
        SaoJoaodaParauna = 5220058,

        [EnumValue("5220108")]
        [Description("Sao Luis de Montes Belos - GO")]
        SaoLuisdeMontesBelos = 5220108,

        [EnumValue("5220157")]
        [Description("Sao Luiz do Norte - GO")]
        SaoLuizdoNorte = 5220157,

        [EnumValue("5220207")]
        [Description("Sao Miguel do Araguaia - GO")]
        SaoMigueldoAraguaia = 5220207,

        [EnumValue("5220264")]
        [Description("Sao Miguel do Passa Quatro - GO")]
        SaoMigueldoPassaQuatro = 5220264,

        [EnumValue("5220280")]
        [Description("Sao Patricio - GO")]
        SaoPatricio = 5220280,

        [EnumValue("5220405")]
        [Description("Sao Simao - GO")]
        SaoSimao = 5220405,

        [EnumValue("5220454")]
        [Description("Senador Canedo - GO")]
        SenadorCanedo = 5220454,

        [EnumValue("5220504")]
        [Description("Serranopolis - GO")]
        Serranopolis = 5220504,

        [EnumValue("5220603")]
        [Description("Silvania - GO")]
        Silvania = 5220603,

        [EnumValue("5220686")]
        [Description("Simolandia - GO")]
        Simolandia = 5220686,

        [EnumValue("5220702")]
        [Description("Sitio dAbadia - GO")]
        SitiodAbadia = 5220702,

        [EnumValue("5221007")]
        [Description("Taquaral de Goias - GO")]
        TaquaraldeGoias = 5221007,

        [EnumValue("5221080")]
        [Description("Teresina de Goias - GO")]
        TeresinadeGoias = 5221080,

        [EnumValue("5221197")]
        [Description("Terezopolis de Goias - GO")]
        TerezopolisdeGoias = 5221197,

        [EnumValue("5221304")]
        [Description("Tres Ranchos - GO")]
        TresRanchos = 5221304,

        [EnumValue("5221403")]
        [Description("Trindade - GO")]
        Trindade = 5221403,

        [EnumValue("5221452")]
        [Description("Trombas - GO")]
        Trombas = 5221452,

        [EnumValue("5221502")]
        [Description("Turvania - GO")]
        Turvania = 5221502,

        [EnumValue("5221551")]
        [Description("Turvelandia - GO")]
        Turvelandia = 5221551,

        [EnumValue("5221577")]
        [Description("Uirapuru - GO")]
        Uirapuru = 5221577,

        [EnumValue("5221601")]
        [Description("Uruacu - GO")]
        Uruacu = 5221601,

        [EnumValue("5221700")]
        [Description("Uruana - GO")]
        Uruana = 5221700,

        [EnumValue("5221809")]
        [Description("Urutai - GO")]
        Urutai = 5221809,

        [EnumValue("5221858")]
        [Description("Valparaiso de Goias - GO")]
        ValparaisodeGoias = 5221858,

        [EnumValue("5221908")]
        [Description("Varjao - GO")]
        Varjao = 5221908,

        [EnumValue("5222005")]
        [Description("Vianopolis - GO")]
        Vianopolis = 5222005,

        [EnumValue("5222054")]
        [Description("Vicentinopolis - GO")]
        Vicentinopolis = 5222054,

        [EnumValue("5222302")]
        [Description("Vila Propicio - GO")]
        VilaPropicio = 5222302,

        //======Maranhão======
        [EnumValue("2100055")]
        [Description("Acailandia - MA")]
        Acailandia = 2100055,

        [EnumValue("2100204")]
        [Description("Alcantara - MA")]
        Alcantara = 2100204,

        [EnumValue("2100303")]
        [Description("Aldeias Altas - MA")]
        AldeiasAltas = 2100303,

        [EnumValue("2100402")]
        [Description("Altamira do Maranhao - MA")]
        AltamiradoMaranhao = 2100402,

        [EnumValue("2100436")]
        [Description("Alto Alegre do Maranhao - MA")]
        AltoAlegredoMaranhao = 2100436,

        [EnumValue("2100477")]
        [Description("Alto Alegre do Pindare - MA")]
        AltoAlegredoPindare = 2100477,

        [EnumValue("2100501")]
        [Description("Alto Parnaiba - MA")]
        AltoParnaiba = 2100501,

        [EnumValue("2100600")]
        [Description("Amarante do Maranhao - MA")]
        AmarantedoMaranhao = 2100600,

        [EnumValue("2100709")]
        [Description("Anajatuba - MA")]
        Anajatuba = 2100709,

        [EnumValue("2100873")]
        [Description("Araguana - MA")]
        Araguana = 2100873,

        [EnumValue("2100956")]
        [Description("Arame - MA")]
        Arame = 2100956,

        [EnumValue("2101004")]
        [Description("Arari - MA")]
        Arari = 2101004,

        [EnumValue("2101103")]
        [Description("Axixa - MA")]
        Axixa = 2101103,

        [EnumValue("2101202")]
        [Description("Bacabal - MA")]
        Bacabal = 2101202,

        [EnumValue("2101400")]
        [Description("Balsas - MA")]
        Balsas = 2101400,

        [EnumValue("2101608")]
        [Description("Barra do Corda - MA")]
        BarradoCorda = 2101608,

        [EnumValue("2101731")]
        [Description("Belagua - MA")]
        Belagua = 2101731,

        [EnumValue("2101772")]
        [Description("Bela Vista do Maranhao - MA")]
        BelaVistadoMaranhao = 2101772,

        [EnumValue("2101806")]
        [Description("Benedito Leite - MA")]
        BeneditoLeite = 2101806,

        [EnumValue("2101905")]
        [Description("Bequimao - MA")]
        Bequimao = 2101905,

        [EnumValue("2101970")]
        [Description("Boa Vista do Gurupi - MA")]
        BoaVistadoGurupi = 2101970,

        [EnumValue("2102036")]
        [Description("Bom Jesus das Selvas - MA")]
        BomJesusdasSelvas = 2102036,

        [EnumValue("2102077")]
        [Description("Bom Lugar - MA")]
        BomLugar = 2102077,

        [EnumValue("2102309")]
        [Description("Buriti Bravo - MA")]
        BuritiBravo = 2102309,

        [EnumValue("2102358")]
        [Description("Buritirana - MA")]
        Buritirana = 2102358,

        [EnumValue("2102408")]
        [Description("Cajapio - MA")]
        Cajapio = 2102408,

        [EnumValue("2102556")]
        [Description("Campestre do Maranhao - MA")]
        CampestredoMaranhao = 2102556,

        [EnumValue("2102754")]
        [Description("Capinzal do Norte - MA")]
        CapinzaldoNorte = 2102754,

        [EnumValue("2102804")]
        [Description("Carolina - MA")]
        Carolina = 2102804,

        [EnumValue("2102903")]
        [Description("Carutapera - MA")]
        Carutapera = 2102903,

        [EnumValue("2103000")]
        [Description("Caxias - MA")]
        Caxias = 2103000,

        [EnumValue("2103109")]
        [Description("Cedral - MA")]
        Cedral = 2103109,

        [EnumValue("2103158")]
        [Description("Centro do Guilherme - MA")]
        CentrodoGuilherme = 2103158,

        [EnumValue("2103257")]
        [Description("Cidelandia - MA")]
        Cidelandia = 2103257,

        [EnumValue("2103307")]
        [Description("Codo - MA")]
        Codo = 2103307,

        [EnumValue("2103406")]
        [Description("Coelho Neto - MA")]
        CoelhoNeto = 2103406,

        [EnumValue("2103604")]
        [Description("Coroata - MA")]
        Coroata = 2103604,

        [EnumValue("2103703")]
        [Description("Cururupu - MA")]
        Cururupu = 2103703,

        [EnumValue("2103802")]
        [Description("Dom Pedro - MA")]
        DomPedro = 2103802,

        [EnumValue("2104008")]
        [Description("Esperantinopolis - MA")]
        Esperantinopolis = 2104008,

        [EnumValue("2104057")]
        [Description("Estreito - MA")]
        Estreito = 2104057,

        [EnumValue("2104099")]
        [Description("Formosa da Serra Negra - MA")]
        FormosadaSerraNegra = 2104099,

        [EnumValue("2104552")]
        [Description("Governador Edison Lobao - MA")]
        GovernadorEdisonLobao = 2104552,

        [EnumValue("2104651")]
        [Description("Governador Newton Bello - MA")]
        GovernadorNewtonBello = 2104651,

        [EnumValue("2104677")]
        [Description("Governador Nunes Freire - MA")]
        GovernadorNunesFreire = 2104677,

        [EnumValue("2104701")]
        [Description("Graca Aranha - MA")]
        GracaAranha = 2104701,

        [EnumValue("2104800")]
        [Description("Grajau - MA")]
        Grajau = 2104800,

        [EnumValue("2105005")]
        [Description("Humberto de Campos - MA")]
        HumbertodeCampos = 2105005,

        [EnumValue("2105153")]
        [Description("Igarape do Meio - MA")]
        IgarapedoMeio = 2105153,

        [EnumValue("2105302")]
        [Description("Imperatriz - MA")]
        Imperatriz = 2105302,

        [EnumValue("2105401")]
        [Description("Itapecuru Mirim - MA")]
        ItapecuruMirim = 2105401,

        [EnumValue("2105427")]
        [Description("Itinga do Maranhao - MA")]
        ItingadoMaranhao = 2105427,

        [EnumValue("2105708")]
        [Description("Lago da Pedra - MA")]
        LagodaPedra = 2105708,

        [EnumValue("2105948")]
        [Description("Lago dos Rodrigues - MA")]
        LagodosRodrigues = 2105948,

        [EnumValue("2106326")]
        [Description("Maracacume - MA")]
        Maracacume = 2106326,

        [EnumValue("2106375")]
        [Description("Maranhaozinho - MA")]
        Maranhaozinho = 2106375,

        [EnumValue("2106508")]
        [Description("Matinha - MA")]
        Matinha = 2106508,

        [EnumValue("2106607")]
        [Description("Matoes - MA")]
        Matoes = 2106607,

        [EnumValue("2106631")]
        [Description("Matoes do Norte - MA")]
        MatoesdoNorte = 2106631,

        [EnumValue("2106706")]
        [Description("Mirador - MA")]
        Mirador = 2106706,

        [EnumValue("2106755")]
        [Description("Miranda do Norte - MA")]
        MirandadoNorte = 2106755,

        [EnumValue("2107001")]
        [Description("Montes Altos - MA")]
        MontesAltos = 2107001,

        [EnumValue("2107100")]
        [Description("Morros - MA")]
        Morros = 2107100,

        [EnumValue("2107357")]
        [Description("Nova Olinda do Maranhao - MA")]
        NovaOlindadoMaranhao = 2107357,

        [EnumValue("2107407")]
        [Description("Olho dAgua das Cunhas - MA")]
        OlhodAguadasCunhas = 2107407,

        [EnumValue("2107506")]
        [Description("Paco do Lumiar - MA")]
        PacodoLumiar = 2107506,

        [EnumValue("2107704")]
        [Description("Paraibano - MA")]
        Paraibano = 2107704,

        [EnumValue("2107803")]
        [Description("Parnarama - MA")]
        Parnarama = 2107803,

        [EnumValue("2107902")]
        [Description("Passagem Franca - MA")]
        PassagemFranca = 2107902,

        [EnumValue("2108009")]
        [Description("Pastos Bons - MA")]
        PastosBons = 2108009,

        [EnumValue("2108207")]
        [Description("Pedreiras - MA")]
        Pedreiras = 2108207,

        [EnumValue("2108306")]
        [Description("Penalva - MA")]
        Penalva = 2108306,

        [EnumValue("2108454")]
        [Description("Peritoro - MA")]
        Peritoro = 2108454,

        [EnumValue("2108603")]
        [Description("Pinheiro - MA")]
        Pinheiro = 2108603,

        [EnumValue("2108702")]
        [Description("Pio XII - MA")]
        PioXII = 2108702,

        [EnumValue("2108900")]
        [Description("Pocao de Pedras - MA")]
        PocaodePedras = 2108900,

        [EnumValue("2109056")]
        [Description("Porto Rico do Maranhao - MA")]
        PortoRicodoMaranhao = 2109056,

        [EnumValue("2109106")]
        [Description("Presidente Dutra - MA")]
        PresidenteDutra_MA = 2109106,

        [EnumValue("2109205")]
        [Description("Presidente Juscelino - MA")]
        PresidenteJuscelino = 2109205,

        [EnumValue("2109304")]
        [Description("Presidente Vargas - MA")]
        PresidenteVargas = 2109304,

        [EnumValue("2109403")]
        [Description("Primeira Cruz - MA")]
        PrimeiraCruz = 2109403,

        [EnumValue("2109452")]
        [Description("Raposa - MA")]
        Raposa = 2109452,

        [EnumValue("2109601")]
        [Description("Rosario - MA")]
        Rosario = 2109601,

        [EnumValue("2109700")]
        [Description("Sambaiba - MA")]
        Sambaiba = 2109700,

        [EnumValue("2109809")]
        [Description("Santa Helena - MA")]
        SantaHelena = 2109809,

        [EnumValue("2110005")]
        [Description("Santa Luzia - MA")]
        SantaLuzia_MA = 2110005,

        [EnumValue("2110039")]
        [Description("Santa Luzia do Parua - MA")]
        SantaLuziadoParua = 2110039,

        [EnumValue("2110278")]
        [Description("Santo Amaro do Maranhao - MA")]
        SantoAmarodoMaranhao = 2110278,

        [EnumValue("2110302")]
        [Description("Santo Antonio dos Lopes - MA")]
        SantoAntoniodosLopes = 2110302,

        [EnumValue("2110401")]
        [Description("Sao Benedito do Rio Preto - MA")]
        SaoBeneditodoRioPreto = 2110401,

        [EnumValue("2110500")]
        [Description("Sao Bento - MA")]
        SaoBento = 2110500,

        [EnumValue("2110658")]
        [Description("Sao Domingos do Azeitao - MA")]
        SaoDomingosdoAzeitao = 2110658,

        [EnumValue("2110807")]
        [Description("Sao Felix de Balsas - MA")]
        SaoFelixdeBalsas = 2110807,

        [EnumValue("2110856")]
        [Description("Sao Francisco do Brejao - MA")]
        SaoFranciscodoBrejao = 2110856,

        [EnumValue("2111029")]
        [Description("Sao Joao do Caru - MA")]
        SaoJoaodoCaru = 2111029,

        [EnumValue("2111078")]
        [Description("Sao Joao do Soter - MA")]
        SaoJoaodoSoter = 2111078,

        [EnumValue("2111102")]
        [Description("Sao Joao dos Patos - MA")]
        SaoJoaodosPatos = 2111102,

        [EnumValue("2111201")]
        [Description("Sao Jose de Ribamar - MA")]
        SaoJosedeRibamar = 2111201,

        [EnumValue("2111300")]
        [Description("Sao Luis - MA")]
        SaoLuis = 2111300,

        [EnumValue("2111409")]
        [Description("Sao Luis Gonzaga do Maranhao - MA")]
        SaoLuisGonzagadoMaranhao = 2111409,

        [EnumValue("2111508")]
        [Description("Sao Mateus do Maranhao - MA")]
        SaoMateusdoMaranhao = 2111508,

        [EnumValue("2111573")]
        [Description("Sao Pedro dos Crentes - MA")]
        SaoPedrodosCrentes = 2111573,

        [EnumValue("2111607")]
        [Description("Sao Raimundo das Mangabeiras - MA")]
        SaoRaimundodasMangabeiras = 2111607,

        [EnumValue("2111631")]
        [Description("Sao Raimundo do Doca Bezerra - MA")]
        SaoRaimundodoDocaBezerra = 2111631,

        [EnumValue("2111672")]
        [Description("Sao Roberto - MA")]
        SaoRoberto = 2111672,

        [EnumValue("2111763")]
        [Description("Senador La Rocque - MA")]
        SenadorLaRocque = 2111763,

        [EnumValue("2111805")]
        [Description("Sitio Novo - MA")]
        SitioNovo = 2111805,

        [EnumValue("2111953")]
        [Description("Sucupira do Riachao - MA")]
        SucupiradoRiachao = 2111953,

        [EnumValue("2112001")]
        [Description("Tasso Fragoso - MA")]
        TassoFragoso = 2112001,

        [EnumValue("2112100")]
        [Description("Timbiras - MA")]
        Timbiras = 2112100,

        [EnumValue("2112209")]
        [Description("Timon - MA")]
        Timon = 2112209,

        [EnumValue("2112233")]
        [Description("Trizidela do Vale - MA")]
        TrizideladoVale = 2112233,

        [EnumValue("2112407")]
        [Description("Turiacu - MA")]
        Turiacu = 2112407,

        [EnumValue("2112456")]
        [Description("Turilandia - MA")]
        Turilandia = 2112456,

        [EnumValue("2112506")]
        [Description("Tutoia - MA")]
        Tutoia = 2112506,

        [EnumValue("2112704")]
        [Description("Vargem Grande - MA")]
        VargemGrande = 2112704,

        [EnumValue("2112803")]
        [Description("Viana - MA")]
        Viana_MA = 2112803,

        [EnumValue("2112852")]
        [Description("Vila Nova dos Martirios - MA")]
        VilaNovadosMartirios = 2112852,

        [EnumValue("2112902")]
        [Description("Vitoria do Mearim - MA")]
        VitoriadoMearim = 2112902,

        [EnumValue("2114007")]
        [Description("Ze Doca - MA")]
        ZeDoca = 2114007,

        //======Minas Gerais======
        [EnumValue("3100104")]
        [Description("Abadia dos Dourados - MG")]
        AbadiadosDourados = 3100104,

        [EnumValue("3100203")]
        [Description("Abaete - MG")]
        Abaete = 3100203,

        [EnumValue("3100302")]
        [Description("Abre Campo - MG")]
        AbreCampo = 3100302,

        [EnumValue("3100500")]
        [Description("Acucena - MG")]
        Acucena = 3100500,

        [EnumValue("3100609")]
        [Description("Agua Boa - MG")]
        AguaBoa = 3100609,

        [EnumValue("3100807")]
        [Description("Aguanil - MG")]
        Aguanil = 3100807,

        [EnumValue("3100906")]
        [Description("Aguas Formosas - MG")]
        AguasFormosas = 3100906,

        [EnumValue("3101003")]
        [Description("Aguas Vermelhas - MG")]
        AguasVermelhas = 3101003,

        [EnumValue("3101201")]
        [Description("Aiuruoca - MG")]
        Aiuruoca = 3101201,

        [EnumValue("3101300")]
        [Description("Alagoa - MG")]
        Alagoa = 3101300,

        [EnumValue("3101409")]
        [Description("Albertina - MG")]
        Albertina = 3101409,

        [EnumValue("3101508")]
        [Description("Alem Paraiba - MG")]
        AlemParaiba = 3101508,

        [EnumValue("3101607")]
        [Description("Alfenas - MG")]
        Alfenas = 3101607,

        [EnumValue("3101631")]
        [Description("Alfredo Vasconcelos - MG")]
        AlfredoVasconcelos = 3101631,

        [EnumValue("3101805")]
        [Description("Alpercata - MG")]
        Alpercata = 3101805,

        [EnumValue("3101904")]
        [Description("Alpinopolis - MG")]
        Alpinopolis = 3101904,

        [EnumValue("3102001")]
        [Description("Alterosa - MG")]
        Alterosa = 3102001,

        [EnumValue("3102050")]
        [Description("Alto Caparao - MG")]
        AltoCaparao = 3102050,

        [EnumValue("3102209")]
        [Description("Alvarenga - MG")]
        Alvarenga = 3102209,

        [EnumValue("3102308")]
        [Description("Alvinopolis - MG")]
        Alvinopolis = 3102308,

        [EnumValue("3102407")]
        [Description("Alvorada de Minas - MG")]
        AlvoradadeMinas = 3102407,

        [EnumValue("3102506")]
        [Description("Amparo do Serra - MG")]
        AmparodoSerra = 3102506,

        [EnumValue("3102605")]
        [Description("Andradas - MG")]
        Andradas = 3102605,

        [EnumValue("3102704")]
        [Description("Cachoeira de Pajeu - MG")]
        CachoeiradePajeu = 3102704,

        [EnumValue("3102803")]
        [Description("Andrelandia - MG")]
        Andrelandia = 3102803,

        [EnumValue("3102852")]
        [Description("Angelandia - MG")]
        Angelandia = 3102852,

        [EnumValue("3102902")]
        [Description("Antonio Carlos - MG")]
        AntonioCarlos = 3102902,

        [EnumValue("3103009")]
        [Description("Antonio Dias - MG")]
        AntonioDias = 3103009,

        [EnumValue("3103108")]
        [Description("Antonio Prado de Minas - MG")]
        AntonioPradodeMinas = 3103108,

        [EnumValue("3103207")]
        [Description("Aracai - MG")]
        Aracai = 3103207,

        [EnumValue("3103306")]
        [Description("Aracitaba - MG")]
        Aracitaba = 3103306,

        [EnumValue("3103405")]
        [Description("Aracuai - MG")]
        Aracuai = 3103405,

        [EnumValue("3103504")]
        [Description("Araguari - MG")]
        Araguari = 3103504,

        [EnumValue("3103603")]
        [Description("Arantina - MG")]
        Arantina = 3103603,

        [EnumValue("3103702")]
        [Description("Araponga - MG")]
        Araponga = 3103702,

        [EnumValue("3103751")]
        [Description("Arapora - MG")]
        Arapora = 3103751,

        [EnumValue("3103801")]
        [Description("Arapua - MG")]
        Arapua = 3103801,

        [EnumValue("3103900")]
        [Description("Araujos - MG")]
        Araujos = 3103900,

        [EnumValue("3104007")]
        [Description("Araxa - MG")]
        Araxa = 3104007,

        [EnumValue("3104106")]
        [Description("Arceburgo - MG")]
        Arceburgo = 3104106,

        [EnumValue("3104205")]
        [Description("Arcos - MG")]
        Arcos = 3104205,

        [EnumValue("3104304")]
        [Description("Areado - MG")]
        Areado = 3104304,

        [EnumValue("3104403")]
        [Description("Argirita - MG")]
        Argirita = 3104403,

        [EnumValue("3104452")]
        [Description("Aricanduva - MG")]
        Aricanduva = 3104452,

        [EnumValue("3104502")]
        [Description("Arinos - MG")]
        Arinos = 3104502,

        [EnumValue("3104601")]
        [Description("Astolfo Dutra - MG")]
        AstolfoDutra = 3104601,

        [EnumValue("3104700")]
        [Description("Ataleia - MG")]
        Ataleia = 3104700,

        [EnumValue("3104809")]
        [Description("Augusto de Lima - MG")]
        AugustodeLima = 3104809,

        [EnumValue("3104908")]
        [Description("Baependi - MG")]
        Baependi = 3104908,

        [EnumValue("3105004")]
        [Description("Baldim - MG")]
        Baldim = 3105004,

        [EnumValue("3105103")]
        [Description("Bambui - MG")]
        Bambui = 3105103,

        [EnumValue("3105202")]
        [Description("Bandeira - MG")]
        Bandeira = 3105202,

        [EnumValue("3105301")]
        [Description("Bandeira do Sul - MG")]
        BandeiradoSul = 3105301,

        [EnumValue("3105400")]
        [Description("Barao de Cocais - MG")]
        BaraodeCocais = 3105400,

        [EnumValue("3105509")]
        [Description("Barao do Monte Alto - MG")]
        BaraodoMonteAlto = 3105509,

        [EnumValue("3105608")]
        [Description("Barbacena - MG")]
        Barbacena = 3105608,

        [EnumValue("3105707")]
        [Description("Barra Longa - MG")]
        BarraLonga = 3105707,

        [EnumValue("3105905")]
        [Description("Barroso - MG")]
        Barroso = 3105905,

        [EnumValue("3106002")]
        [Description("Bela Vista de Minas - MG")]
        BelaVistadeMinas = 3106002,

        [EnumValue("3106101")]
        [Description("Belmiro Braga - MG")]
        BelmiroBraga = 3106101,

        [EnumValue("3106200")]
        [Description("Belo Horizonte - MG")]
        BeloHorizonte = 3106200,

        [EnumValue("3106309")]
        [Description("Belo Oriente - MG")]
        BeloOriente = 3106309,

        [EnumValue("3106408")]
        [Description("Belo Vale - MG")]
        BeloVale = 3106408,

        [EnumValue("3106507")]
        [Description("Berilo - MG")]
        Berilo = 3106507,

        [EnumValue("3106606")]
        [Description("Bertopolis - MG")]
        Bertopolis = 3106606,

        [EnumValue("3106655")]
        [Description("Berizal - MG")]
        Berizal = 3106655,

        [EnumValue("3106705")]
        [Description("Betim - MG")]
        Betim = 3106705,

        [EnumValue("3106804")]
        [Description("Bias Fortes - MG")]
        BiasFortes = 3106804,

        [EnumValue("3106903")]
        [Description("Bicas - MG")]
        Bicas = 3106903,

        [EnumValue("3107109")]
        [Description("Boa Esperanca - MG")]
        BoaEsperanca_MG = 3107109,

        [EnumValue("3107208")]
        [Description("Bocaina de Minas - MG")]
        BocainadeMinas = 3107208,

        [EnumValue("3107307")]
        [Description("Bocaiuva - MG")]
        Bocaiuva = 3107307,

        [EnumValue("3107406")]
        [Description("Bom Despacho - MG")]
        BomDespacho = 3107406,

        [EnumValue("3107505")]
        [Description("Bom Jardim de Minas - MG")]
        BomJardimdeMinas = 3107505,

        [EnumValue("3107604")]
        [Description("Bom Jesus da Penha - MG")]
        BomJesusdaPenha = 3107604,

        [EnumValue("3107703")]
        [Description("Bom Jesus do Amparo - MG")]
        BomJesusdoAmparo = 3107703,

        [EnumValue("3107901")]
        [Description("Bom Repouso - MG")]
        BomRepouso = 3107901,

        [EnumValue("3108008")]
        [Description("Bom Sucesso - MG")]
        BomSucesso = 3108008,

        [EnumValue("3108107")]
        [Description("Bonfim - MG")]
        Bonfim = 3108107,

        [EnumValue("3108206")]
        [Description("Bonfinopolis de Minas - MG")]
        BonfinopolisdeMinas = 3108206,

        [EnumValue("3108255")]
        [Description("Bonito de Minas - MG")]
        BonitodeMinas = 3108255,

        [EnumValue("3108305")]
        [Description("Borda da Mata - MG")]
        BordadaMata = 3108305,

        [EnumValue("3108404")]
        [Description("Botelhos - MG")]
        Botelhos = 3108404,

        [EnumValue("3108552")]
        [Description("Brasilandia de Minas - MG")]
        BrasilandiadeMinas = 3108552,

        [EnumValue("3108602")]
        [Description("Brasilia de Minas - MG")]
        BrasiliadeMinas = 3108602,

        [EnumValue("3108701")]
        [Description("Bras Pires - MG")]
        BrasPires = 3108701,

        [EnumValue("3108800")]
        [Description("Braunas - MG")]
        Braunas = 3108800,

        [EnumValue("3109006")]
        [Description("Brumadinho - MG")]
        Brumadinho = 3109006,

        [EnumValue("3109105")]
        [Description("Bueno Brandao - MG")]
        BuenoBrandao = 3109105,

        [EnumValue("3109204")]
        [Description("Buenopolis - MG")]
        Buenopolis = 3109204,

        [EnumValue("3109303")]
        [Description("Buritis - MG")]
        Buritis = 3109303,

        [EnumValue("3109402")]
        [Description("Buritizeiro - MG")]
        Buritizeiro = 3109402,

        [EnumValue("3109451")]
        [Description("Cabeceira Grande - MG")]
        CabeceiraGrande = 3109451,

        [EnumValue("3109501")]
        [Description("Cabo Verde - MG")]
        CaboVerde = 3109501,

        [EnumValue("3109600")]
        [Description("Cachoeira da Prata - MG")]
        CachoeiradaPrata = 3109600,

        [EnumValue("3109709")]
        [Description("Cachoeira de Minas - MG")]
        CachoeiradeMinas = 3109709,

        [EnumValue("3109808")]
        [Description("Cachoeira Dourada - MG")]
        CachoeiraDourada_MG = 3109808,

        [EnumValue("3109907")]
        [Description("Caetanopolis - MG")]
        Caetanopolis = 3109907,

        [EnumValue("3110004")]
        [Description("Caete - MG")]
        Caete = 3110004,

        [EnumValue("3110103")]
        [Description("Caiana - MG")]
        Caiana = 3110103,

        [EnumValue("3110202")]
        [Description("Cajuri - MG")]
        Cajuri = 3110202,

        [EnumValue("3110301")]
        [Description("Caldas - MG")]
        Caldas = 3110301,

        [EnumValue("3110400")]
        [Description("Camacho - MG")]
        Camacho = 3110400,

        [EnumValue("3110509")]
        [Description("Camanducaia - MG")]
        Camanducaia = 3110509,

        [EnumValue("3110608")]
        [Description("Cambui - MG")]
        Cambui = 3110608,

        [EnumValue("3110707")]
        [Description("Cambuquira - MG")]
        Cambuquira = 3110707,

        [EnumValue("3110806")]
        [Description("Campanario - MG")]
        Campanario = 3110806,

        [EnumValue("3110905")]
        [Description("Campanha - MG")]
        Campanha = 3110905,

        [EnumValue("3111002")]
        [Description("Campestre - MG")]
        Campestre_MG = 3111002,

        [EnumValue("3111101")]
        [Description("Campina Verde - MG")]
        CampinaVerde = 3111101,

        [EnumValue("3111150")]
        [Description("Campo Azul - MG")]
        CampoAzul = 3111150,

        [EnumValue("3111200")]
        [Description("Campo Belo - MG")]
        CampoBelo = 3111200,

        [EnumValue("3111309")]
        [Description("Campo do Meio - MG")]
        CampodoMeio = 3111309,

        [EnumValue("3111408")]
        [Description("Campo Florido - MG")]
        CampoFlorido = 3111408,

        [EnumValue("3111507")]
        [Description("Campos Altos - MG")]
        CamposAltos = 3111507,

        [EnumValue("3111606")]
        [Description("Campos Gerais - MG")]
        CamposGerais = 3111606,

        [EnumValue("3111705")]
        [Description("Canaa - MG")]
        Canaa = 3111705,

        [EnumValue("3111903")]
        [Description("Cana Verde - MG")]
        CanaVerde = 3111903,

        [EnumValue("3112000")]
        [Description("Candeias - MG")]
        Candeias_MG = 3112000,

        [EnumValue("3112059")]
        [Description("Cantagalo - MG")]
        Cantagalo = 3112059,

        [EnumValue("3112109")]
        [Description("Caparao - MG")]
        Caparao = 3112109,

        [EnumValue("3112208")]
        [Description("Capela Nova - MG")]
        CapelaNova = 3112208,

        [EnumValue("3112307")]
        [Description("Capelinha - MG")]
        Capelinha = 3112307,

        [EnumValue("3112406")]
        [Description("Capetinga - MG")]
        Capetinga = 3112406,

        [EnumValue("3112505")]
        [Description("Capim Branco - MG")]
        CapimBranco = 3112505,

        [EnumValue("3112604")]
        [Description("Capinopolis - MG")]
        Capinopolis = 3112604,

        [EnumValue("3112703")]
        [Description("Capitao Eneas - MG")]
        CapitaoEneas = 3112703,

        [EnumValue("3112802")]
        [Description("Capitolio - MG")]
        Capitolio = 3112802,

        [EnumValue("3112901")]
        [Description("Caputira - MG")]
        Caputira = 3112901,

        [EnumValue("3113008")]
        [Description("Carai - MG")]
        Carai = 3113008,

        [EnumValue("3113107")]
        [Description("Caranaiba - MG")]
        Caranaiba = 3113107,

        [EnumValue("3113206")]
        [Description("Carandai - MG")]
        Carandai = 3113206,

        [EnumValue("3113305")]
        [Description("Carangola - MG")]
        Carangola = 3113305,

        [EnumValue("3113404")]
        [Description("Caratinga - MG")]
        Caratinga = 3113404,

        [EnumValue("3113503")]
        [Description("Carbonita - MG")]
        Carbonita = 3113503,

        [EnumValue("3113602")]
        [Description("Careacu - MG")]
        Careacu = 3113602,

        [EnumValue("3113701")]
        [Description("Carlos Chagas - MG")]
        CarlosChagas = 3113701,

        [EnumValue("3113800")]
        [Description("Carmesia - MG")]
        Carmesia = 3113800,

        [EnumValue("3113909")]
        [Description("Carmo da Cachoeira - MG")]
        CarmodaCachoeira = 3113909,

        [EnumValue("3114006")]
        [Description("Carmo da Mata - MG")]
        CarmodaMata = 3114006,

        [EnumValue("3114105")]
        [Description("Carmo de Minas - MG")]
        CarmodeMinas = 3114105,

        [EnumValue("3114204")]
        [Description("Carmo do Cajuru - MG")]
        CarmodoCajuru = 3114204,

        [EnumValue("3114303")]
        [Description("Carmo do Paranaiba - MG")]
        CarmodoParanaiba = 3114303,

        [EnumValue("3114402")]
        [Description("Carmo do Rio Claro - MG")]
        CarmodoRioClaro = 3114402,

        [EnumValue("3114501")]
        [Description("Carmopolis de Minas - MG")]
        CarmopolisdeMinas = 3114501,

        [EnumValue("3114600")]
        [Description("Carrancas - MG")]
        Carrancas = 3114600,

        [EnumValue("3114709")]
        [Description("Carvalhopolis - MG")]
        Carvalhopolis = 3114709,

        [EnumValue("3114808")]
        [Description("Carvalhos - MG")]
        Carvalhos = 3114808,

        [EnumValue("3114907")]
        [Description("Casa Grande - MG")]
        CasaGrande = 3114907,

        [EnumValue("3115003")]
        [Description("Cascalho Rico - MG")]
        CascalhoRico = 3115003,

        [EnumValue("3115201")]
        [Description("Conceicao da Barra de Minas - MG")]
        ConceicaodaBarradeMinas = 3115201,

        [EnumValue("3115300")]
        [Description("Cataguases - MG")]
        Cataguases = 3115300,

        [EnumValue("3115359")]
        [Description("Catas Altas - MG")]
        CatasAltas = 3115359,

        [EnumValue("3115409")]
        [Description("Catas Altas da Noruega - MG")]
        CatasAltasdaNoruega = 3115409,

        [EnumValue("3115458")]
        [Description("Catuji - MG")]
        Catuji = 3115458,

        [EnumValue("3115474")]
        [Description("Catuti - MG")]
        Catuti = 3115474,

        [EnumValue("3115508")]
        [Description("Caxambu - MG")]
        Caxambu = 3115508,

        [EnumValue("3115607")]
        [Description("Cedro do Abaete - MG")]
        CedrodoAbaete = 3115607,

        [EnumValue("3115706")]
        [Description("Central de Minas - MG")]
        CentraldeMinas = 3115706,

        [EnumValue("3115805")]
        [Description("Centralina - MG")]
        Centralina = 3115805,

        [EnumValue("3115904")]
        [Description("Chacara - MG")]
        Chacara = 3115904,

        [EnumValue("3116001")]
        [Description("Chale - MG")]
        Chale = 3116001,

        [EnumValue("3116100")]
        [Description("Chapada do Norte - MG")]
        ChapadadoNorte = 3116100,

        [EnumValue("3116159")]
        [Description("Chapada Gaucha - MG")]
        ChapadaGaucha = 3116159,

        [EnumValue("3116209")]
        [Description("Chiador - MG")]
        Chiador = 3116209,

        [EnumValue("3116308")]
        [Description("Cipotanea - MG")]
        Cipotanea = 3116308,

        [EnumValue("3116407")]
        [Description("Claraval - MG")]
        Claraval = 3116407,

        [EnumValue("3116506")]
        [Description("Claro dos Pocoes - MG")]
        ClarodosPocoes = 3116506,

        [EnumValue("3116605")]
        [Description("Claudio - MG")]
        Claudio = 3116605,

        [EnumValue("3116704")]
        [Description("Coimbra - MG")]
        Coimbra = 3116704,

        [EnumValue("3116803")]
        [Description("Coluna - MG")]
        Coluna = 3116803,

        [EnumValue("3116902")]
        [Description("Comendador Gomes - MG")]
        ComendadorGomes = 3116902,

        [EnumValue("3117009")]
        [Description("Comercinho - MG")]
        Comercinho = 3117009,

        [EnumValue("3117108")]
        [Description("Conceicao da Aparecida - MG")]
        ConceicaodaAparecida = 3117108,

        [EnumValue("3117207")]
        [Description("Conceicao das Pedras - MG")]
        ConceicaodasPedras = 3117207,

        [EnumValue("3117306")]
        [Description("Conceicao das Alagoas - MG")]
        ConceicaodasAlagoas = 3117306,

        [EnumValue("3117405")]
        [Description("Conceicao de Ipanema - MG")]
        ConceicaodeIpanema = 3117405,

        [EnumValue("3117504")]
        [Description("Conceicao do Mato Dentro - MG")]
        ConceicaodoMatoDentro = 3117504,

        [EnumValue("3117603")]
        [Description("Conceicao do Para - MG")]
        ConceicaodoPara = 3117603,

        [EnumValue("3117702")]
        [Description("Conceicao do Rio Verde - MG")]
        ConceicaodoRioVerde = 3117702,

        [EnumValue("3117801")]
        [Description("Conceicao dos Ouros - MG")]
        ConceicaodosOuros = 3117801,

        [EnumValue("3117836")]
        [Description("Conego Marinho - MG")]
        ConegoMarinho = 3117836,

        [EnumValue("3117876")]
        [Description("Confins - MG")]
        Confins = 3117876,

        [EnumValue("3117900")]
        [Description("Congonhal - MG")]
        Congonhal = 3117900,

        [EnumValue("3118007")]
        [Description("Congonhas - MG")]
        Congonhas = 3118007,

        [EnumValue("3118106")]
        [Description("Congonhas do Norte - MG")]
        CongonhasdoNorte = 3118106,

        [EnumValue("3118205")]
        [Description("Conquista - MG")]
        Conquista = 3118205,

        [EnumValue("3118304")]
        [Description("Conselheiro Lafaiete - MG")]
        ConselheiroLafaiete = 3118304,

        [EnumValue("3118403")]
        [Description("Conselheiro Pena - MG")]
        ConselheiroPena = 3118403,

        [EnumValue("3118502")]
        [Description("Consolacao - MG")]
        Consolacao = 3118502,

        [EnumValue("3118601")]
        [Description("Contagem - MG")]
        Contagem = 3118601,

        [EnumValue("3118700")]
        [Description("Coqueiral - MG")]
        Coqueiral = 3118700,

        [EnumValue("3118809")]
        [Description("Coracao de Jesus - MG")]
        CoracaodeJesus = 3118809,

        [EnumValue("3118908")]
        [Description("Cordisburgo - MG")]
        Cordisburgo = 3118908,

        [EnumValue("3119005")]
        [Description("Cordislandia - MG")]
        Cordislandia = 3119005,

        [EnumValue("3119104")]
        [Description("Corinto - MG")]
        Corinto = 3119104,

        [EnumValue("3119203")]
        [Description("Coroaci - MG")]
        Coroaci = 3119203,

        [EnumValue("3119302")]
        [Description("Coromandel - MG")]
        Coromandel = 3119302,

        [EnumValue("3119401")]
        [Description("Coronel Fabriciano - MG")]
        CoronelFabriciano = 3119401,

        [EnumValue("3119500")]
        [Description("Coronel Murta - MG")]
        CoronelMurta = 3119500,

        [EnumValue("3119609")]
        [Description("Coronel Pacheco - MG")]
        CoronelPacheco = 3119609,

        [EnumValue("3119708")]
        [Description("Coronel Xavier Chaves - MG")]
        CoronelXavierChaves = 3119708,

        [EnumValue("3119807")]
        [Description("Corrego Danta - MG")]
        CorregoDanta = 3119807,

        [EnumValue("3119906")]
        [Description("Corrego do Bom Jesus - MG")]
        CorregodoBomJesus = 3119906,

        [EnumValue("3119955")]
        [Description("Corrego Fundo - MG")]
        CorregoFundo = 3119955,

        [EnumValue("3120003")]
        [Description("Corrego Novo - MG")]
        CorregoNovo = 3120003,

        [EnumValue("3120102")]
        [Description("Couto de Magalhaes de Minas - MG")]
        CoutodeMagalhaesdeMinas = 3120102,

        [EnumValue("3120151")]
        [Description("Crisolita - MG")]
        Crisolita = 3120151,

        [EnumValue("3120201")]
        [Description("Cristais - MG")]
        Cristais = 3120201,

        [EnumValue("3120300")]
        [Description("Cristalia - MG")]
        Cristalia = 3120300,

        [EnumValue("3120409")]
        [Description("Cristiano Otoni - MG")]
        CristianoOtoni = 3120409,

        [EnumValue("3120508")]
        [Description("Cristina - MG")]
        Cristina = 3120508,

        [EnumValue("3120607")]
        [Description("Crucilandia - MG")]
        Crucilandia = 3120607,

        [EnumValue("3120706")]
        [Description("Cruzeiro da Fortaleza - MG")]
        CruzeirodaFortaleza = 3120706,

        [EnumValue("3120805")]
        [Description("Cruzilia - MG")]
        Cruzilia = 3120805,

        [EnumValue("3120839")]
        [Description("Cuparaque - MG")]
        Cuparaque = 3120839,

        [EnumValue("3120870")]
        [Description("Curral de Dentro - MG")]
        CurraldeDentro = 3120870,

        [EnumValue("3120904")]
        [Description("Curvelo - MG")]
        Curvelo = 3120904,

        [EnumValue("3121001")]
        [Description("Datas - MG")]
        Datas = 3121001,

        [EnumValue("3121100")]
        [Description("Delfim Moreira - MG")]
        DelfimMoreira = 3121100,

        [EnumValue("3121209")]
        [Description("Delfinopolis - MG")]
        Delfinopolis = 3121209,

        [EnumValue("3121258")]
        [Description("Delta - MG")]
        Delta = 3121258,

        [EnumValue("3121308")]
        [Description("Descoberto - MG")]
        Descoberto = 3121308,

        [EnumValue("3121407")]
        [Description("Desterro de Entre Rios - MG")]
        DesterrodeEntreRios = 3121407,

        [EnumValue("3121605")]
        [Description("Diamantina - MG")]
        Diamantina = 3121605,

        [EnumValue("3121704")]
        [Description("Diogo de Vasconcelos - MG")]
        DiogodeVasconcelos = 3121704,

        [EnumValue("3121803")]
        [Description("Dionisio - MG")]
        Dionisio = 3121803,

        [EnumValue("3121902")]
        [Description("Divinesia - MG")]
        Divinesia = 3121902,

        [EnumValue("3122009")]
        [Description("Divino - MG")]
        Divino = 3122009,

        [EnumValue("3122108")]
        [Description("Divino das Laranjeiras - MG")]
        DivinodasLaranjeiras = 3122108,

        [EnumValue("3122207")]
        [Description("Divinolandia de Minas - MG")]
        DivinolandiadeMinas = 3122207,

        [EnumValue("3122306")]
        [Description("Divinopolis - MG")]
        Divinopolis = 3122306,

        [EnumValue("3122355")]
        [Description("Divisa Alegre - MG")]
        DivisaAlegre = 3122355,

        [EnumValue("3122405")]
        [Description("Divisa Nova - MG")]
        DivisaNova = 3122405,

        [EnumValue("3122454")]
        [Description("Divisopolis - MG")]
        Divisopolis = 3122454,

        [EnumValue("3122470")]
        [Description("Dom Bosco - MG")]
        DomBosco = 3122470,

        [EnumValue("3122603")]
        [Description("Dom Joaquim - MG")]
        DomJoaquim = 3122603,

        [EnumValue("3122702")]
        [Description("Dom Silverio - MG")]
        DomSilverio = 3122702,

        [EnumValue("3122801")]
        [Description("Dom Vicoso - MG")]
        DomVicoso = 3122801,

        [EnumValue("3122900")]
        [Description("Dona Euzebia - MG")]
        DonaEuzebia = 3122900,

        [EnumValue("3123007")]
        [Description("Dores de Campos - MG")]
        DoresdeCampos = 3123007,

        [EnumValue("3123106")]
        [Description("Dores de Guanhaes - MG")]
        DoresdeGuanhaes = 3123106,

        [EnumValue("3123205")]
        [Description("Dores do Indaia - MG")]
        DoresdoIndaia = 3123205,

        [EnumValue("3123304")]
        [Description("Dores do Turvo - MG")]
        DoresdoTurvo = 3123304,

        [EnumValue("3123403")]
        [Description("Doresopolis - MG")]
        Doresopolis = 3123403,

        [EnumValue("3123502")]
        [Description("Douradoquara - MG")]
        Douradoquara = 3123502,

        [EnumValue("3123528")]
        [Description("Durande - MG")]
        Durande = 3123528,

        [EnumValue("3123601")]
        [Description("Eloi Mendes - MG")]
        EloiMendes = 3123601,

        [EnumValue("3123809")]
        [Description("Engenheiro Navarro - MG")]
        EngenheiroNavarro = 3123809,

        [EnumValue("3123908")]
        [Description("Entre Rios de Minas - MG")]
        EntreRiosdeMinas = 3123908,

        [EnumValue("3124005")]
        [Description("Ervalia - MG")]
        Ervalia = 3124005,

        [EnumValue("3124104")]
        [Description("Esmeraldas - MG")]
        Esmeraldas = 3124104,

        [EnumValue("3124203")]
        [Description("Espera Feliz - MG")]
        EsperaFeliz = 3124203,

        [EnumValue("3124302")]
        [Description("Espinosa - MG")]
        Espinosa = 3124302,

        [EnumValue("3124401")]
        [Description("Espirito Santo do Dourado - MG")]
        EspiritoSantodoDourado = 3124401,

        [EnumValue("3124500")]
        [Description("Estiva - MG")]
        Estiva = 3124500,

        [EnumValue("3124609")]
        [Description("Estrela Dalva - MG")]
        EstrelaDalva = 3124609,

        [EnumValue("3124807")]
        [Description("Estrela do Sul - MG")]
        EstreladoSul = 3124807,

        [EnumValue("3124906")]
        [Description("Eugenopolis - MG")]
        Eugenopolis = 3124906,

        [EnumValue("3125002")]
        [Description("Ewbank da Camara - MG")]
        EwbankdaCamara = 3125002,

        [EnumValue("3125101")]
        [Description("Extrema - MG")]
        Extrema = 3125101,

        [EnumValue("3125200")]
        [Description("Fama - MG")]
        Fama = 3125200,

        [EnumValue("3125309")]
        [Description("Faria Lemos - MG")]
        FariaLemos = 3125309,

        [EnumValue("3125507")]
        [Description("Sao Goncalo do Rio Preto - MG")]
        SaoGoncalodoRioPreto = 3125507,

        [EnumValue("3125606")]
        [Description("Felisburgo - MG")]
        Felisburgo = 3125606,

        [EnumValue("3125705")]
        [Description("Felixlandia - MG")]
        Felixlandia = 3125705,

        [EnumValue("3125903")]
        [Description("Ferros - MG")]
        Ferros = 3125903,

        [EnumValue("3125952")]
        [Description("Fervedouro - MG")]
        Fervedouro = 3125952,

        [EnumValue("3126000")]
        [Description("Florestal - MG")]
        Florestal = 3126000,

        [EnumValue("3126109")]
        [Description("Formiga - MG")]
        Formiga = 3126109,

        [EnumValue("3126208")]
        [Description("Formoso - MG")]
        Formoso_MG = 3126208,

        [EnumValue("3126307")]
        [Description("Fortaleza de Minas - MG")]
        FortalezadeMinas = 3126307,

        [EnumValue("3126406")]
        [Description("Fortuna de Minas - MG")]
        FortunadeMinas = 3126406,

        [EnumValue("3126505")]
        [Description("Francisco Badaro - MG")]
        FranciscoBadaro = 3126505,

        [EnumValue("3126604")]
        [Description("Francisco Dumont - MG")]
        FranciscoDumont = 3126604,

        [EnumValue("3126703")]
        [Description("Francisco Sa - MG")]
        FranciscoSa = 3126703,

        [EnumValue("3126752")]
        [Description("Franciscopolis - MG")]
        Franciscopolis = 3126752,

        [EnumValue("3126802")]
        [Description("Frei Gaspar - MG")]
        FreiGaspar = 3126802,

        [EnumValue("3126901")]
        [Description("Frei Inocencio - MG")]
        FreiInocencio = 3126901,

        [EnumValue("3126950")]
        [Description("Frei Lagonegro - MG")]
        FreiLagonegro = 3126950,

        [EnumValue("3127008")]
        [Description("Fronteira - MG")]
        Fronteira = 3127008,

        [EnumValue("3127057")]
        [Description("Fronteira dos Vales - MG")]
        FronteiradosVales = 3127057,

        [EnumValue("3127073")]
        [Description("Fruta de Leite - MG")]
        FrutadeLeite = 3127073,

        [EnumValue("3127107")]
        [Description("Frutal - MG")]
        Frutal = 3127107,

        [EnumValue("3127206")]
        [Description("Funilandia - MG")]
        Funilandia = 3127206,

        [EnumValue("3127305")]
        [Description("Galileia - MG")]
        Galileia = 3127305,

        [EnumValue("3127339")]
        [Description("Gameleiras - MG")]
        Gameleiras = 3127339,

        [EnumValue("3127354")]
        [Description("Glaucilandia - MG")]
        Glaucilandia = 3127354,

        [EnumValue("3127370")]
        [Description("Goiabeira - MG")]
        Goiabeira = 3127370,

        [EnumValue("3127388")]
        [Description("Goiana - MG")]
        Goiana = 3127388,

        [EnumValue("3127404")]
        [Description("Goncalves - MG")]
        Goncalves = 3127404,

        [EnumValue("3127503")]
        [Description("Gonzaga - MG")]
        Gonzaga = 3127503,

        [EnumValue("3127602")]
        [Description("Gouveia - MG")]
        Gouveia = 3127602,

        [EnumValue("3127701")]
        [Description("Governador Valadares - MG")]
        GovernadorValadares = 3127701,

        [EnumValue("3127800")]
        [Description("Grao Mogol - MG")]
        GraoMogol = 3127800,

        [EnumValue("3127909")]
        [Description("Grupiara - MG")]
        Grupiara = 3127909,

        [EnumValue("3128006")]
        [Description("Guanhaes - MG")]
        Guanhaes = 3128006,

        [EnumValue("3128105")]
        [Description("Guape - MG")]
        Guape = 3128105,

        [EnumValue("3128204")]
        [Description("Guaraciaba - MG")]
        Guaraciaba = 3128204,

        [EnumValue("3128253")]
        [Description("Guaraciama - MG")]
        Guaraciama = 3128253,

        [EnumValue("3128303")]
        [Description("Guaranesia - MG")]
        Guaranesia = 3128303,

        [EnumValue("3128402")]
        [Description("Guarani - MG")]
        Guarani = 3128402,

        [EnumValue("3128501")]
        [Description("Guarara - MG")]
        Guarara = 3128501,

        [EnumValue("3128600")]
        [Description("Guarda-Mor - MG")]
        GuardaMor = 3128600,

        [EnumValue("3128709")]
        [Description("Guaxupe - MG")]
        Guaxupe = 3128709,

        [EnumValue("3128808")]
        [Description("Guidoval - MG")]
        Guidoval = 3128808,

        [EnumValue("3128907")]
        [Description("Guimarania - MG")]
        Guimarania = 3128907,

        [EnumValue("3129004")]
        [Description("Guiricema - MG")]
        Guiricema = 3129004,

        [EnumValue("3129301")]
        [Description("Iapu - MG")]
        Iapu = 3129301,

        [EnumValue("3129400")]
        [Description("Ibertioga - MG")]
        Ibertioga = 3129400,

        [EnumValue("3129509")]
        [Description("Ibia - MG")]
        Ibia = 3129509,

        [EnumValue("3129608")]
        [Description("Ibiai - MG")]
        Ibiai = 3129608,

        [EnumValue("3129657")]
        [Description("Ibiracatu - MG")]
        Ibiracatu = 3129657,

        [EnumValue("3129707")]
        [Description("Ibiraci - MG")]
        Ibiraci = 3129707,

        [EnumValue("3129806")]
        [Description("Ibirite - MG")]
        Ibirite = 3129806,

        [EnumValue("3129905")]
        [Description("Ibitiura de Minas - MG")]
        IbitiuradeMinas = 3129905,

        [EnumValue("3130002")]
        [Description("Ibituruna - MG")]
        Ibituruna = 3130002,

        [EnumValue("3130051")]
        [Description("Icarai de Minas - MG")]
        IcaraideMinas = 3130051,

        [EnumValue("3130101")]
        [Description("Igarape - MG")]
        Igarape = 3130101,

        [EnumValue("3130200")]
        [Description("Igaratinga - MG")]
        Igaratinga = 3130200,

        [EnumValue("3130309")]
        [Description("Iguatama - MG")]
        Iguatama = 3130309,

        [EnumValue("3130408")]
        [Description("Ijaci - MG")]
        Ijaci = 3130408,

        [EnumValue("3130507")]
        [Description("Ilicinea - MG")]
        Ilicinea = 3130507,

        [EnumValue("3130556")]
        [Description("Imbe de Minas - MG")]
        ImbedeMinas = 3130556,

        [EnumValue("3130606")]
        [Description("Inconfidentes - MG")]
        Inconfidentes = 3130606,

        [EnumValue("3130705")]
        [Description("Indianopolis - MG")]
        Indianopolis = 3130705,

        [EnumValue("3130804")]
        [Description("Ingai - MG")]
        Ingai = 3130804,

        [EnumValue("3130903")]
        [Description("Inhapim - MG")]
        Inhapim = 3130903,

        [EnumValue("3131000")]
        [Description("Inhauma - MG")]
        Inhauma = 3131000,

        [EnumValue("3131109")]
        [Description("Inimutaba - MG")]
        Inimutaba = 3131109,

        [EnumValue("3131158")]
        [Description("Ipaba - MG")]
        Ipaba = 3131158,

        [EnumValue("3131208")]
        [Description("Ipanema - MG")]
        Ipanema = 3131208,

        [EnumValue("3131307")]
        [Description("Ipatinga - MG")]
        Ipatinga = 3131307,

        [EnumValue("3131406")]
        [Description("Ipiacu - MG")]
        Ipiacu = 3131406,

        [EnumValue("3131505")]
        [Description("Ipuiuna - MG")]
        Ipuiuna = 3131505,

        [EnumValue("3131604")]
        [Description("Irai de Minas - MG")]
        IraideMinas = 3131604,

        [EnumValue("3131703")]
        [Description("Itabira - MG")]
        Itabira = 3131703,

        [EnumValue("3131802")]
        [Description("Itabirinha - MG")]
        Itabirinha = 3131802,

        [EnumValue("3131901")]
        [Description("Itabirito - MG")]
        Itabirito = 3131901,

        [EnumValue("3132008")]
        [Description("Itacambira - MG")]
        Itacambira = 3132008,

        [EnumValue("3132107")]
        [Description("Itacarambi - MG")]
        Itacarambi = 3132107,

        [EnumValue("3132206")]
        [Description("Itaguara - MG")]
        Itaguara = 3132206,

        [EnumValue("3132305")]
        [Description("Itaipe - MG")]
        Itaipe = 3132305,

        [EnumValue("3132404")]
        [Description("Itajuba - MG")]
        Itajuba = 3132404,

        [EnumValue("3132503")]
        [Description("Itamarandiba - MG")]
        Itamarandiba = 3132503,

        [EnumValue("3132701")]
        [Description("Itambacuri - MG")]
        Itambacuri = 3132701,

        [EnumValue("3132800")]
        [Description("Itambe do Mato Dentro - MG")]
        ItambedoMatoDentro = 3132800,

        [EnumValue("3132909")]
        [Description("Itamogi - MG")]
        Itamogi = 3132909,

        [EnumValue("3133006")]
        [Description("Itamonte - MG")]
        Itamonte = 3133006,

        [EnumValue("3133105")]
        [Description("Itanhandu - MG")]
        Itanhandu = 3133105,

        [EnumValue("3133204")]
        [Description("Itanhomi - MG")]
        Itanhomi = 3133204,

        [EnumValue("3133303")]
        [Description("Itaobim - MG")]
        Itaobim = 3133303,

        [EnumValue("3133402")]
        [Description("Itapagipe - MG")]
        Itapagipe = 3133402,

        [EnumValue("3133501")]
        [Description("Itapecerica - MG")]
        Itapecerica = 3133501,

        [EnumValue("3133600")]
        [Description("Itapeva - MG")]
        Itapeva = 3133600,

        [EnumValue("3133709")]
        [Description("Itatiaiucu - MG")]
        Itatiaiucu = 3133709,

        [EnumValue("3133758")]
        [Description("Itau de Minas - MG")]
        ItaudeMinas = 3133758,

        [EnumValue("3133808")]
        [Description("Itauna - MG")]
        Itauna = 3133808,

        [EnumValue("3133907")]
        [Description("Itaverava - MG")]
        Itaverava = 3133907,

        [EnumValue("3134004")]
        [Description("Itinga - MG")]
        Itinga = 3134004,

        [EnumValue("3134103")]
        [Description("Itueta - MG")]
        Itueta = 3134103,

        [EnumValue("3134202")]
        [Description("Ituiutaba - MG")]
        Ituiutaba = 3134202,

        [EnumValue("3134301")]
        [Description("Itumirim - MG")]
        Itumirim = 3134301,

        [EnumValue("3134400")]
        [Description("Iturama - MG")]
        Iturama = 3134400,

        [EnumValue("3134509")]
        [Description("Itutinga - MG")]
        Itutinga = 3134509,

        [EnumValue("3134608")]
        [Description("Jaboticatubas - MG")]
        Jaboticatubas = 3134608,

        [EnumValue("3134707")]
        [Description("Jacinto - MG")]
        Jacinto = 3134707,

        [EnumValue("3134806")]
        [Description("Jacui - MG")]
        Jacui = 3134806,

        [EnumValue("3134905")]
        [Description("Jacutinga - MG")]
        Jacutinga = 3134905,

        [EnumValue("3135050")]
        [Description("Jaiba - MG")]
        Jaiba = 3135050,

        [EnumValue("3135076")]
        [Description("Jampruca - MG")]
        Jampruca = 3135076,

        [EnumValue("3135100")]
        [Description("Janauba - MG")]
        Janauba = 3135100,

        [EnumValue("3135209")]
        [Description("Januaria - MG")]
        Januaria = 3135209,

        [EnumValue("3135308")]
        [Description("Japaraiba - MG")]
        Japaraiba = 3135308,

        [EnumValue("3135357")]
        [Description("Japonvar - MG")]
        Japonvar = 3135357,

        [EnumValue("3135407")]
        [Description("Jeceaba - MG")]
        Jeceaba = 3135407,

        [EnumValue("3135456")]
        [Description("Jenipapo de Minas - MG")]
        JenipapodeMinas = 3135456,

        [EnumValue("3135605")]
        [Description("Jequitai - MG")]
        Jequitai = 3135605,

        [EnumValue("3135704")]
        [Description("Jequitiba - MG")]
        Jequitiba = 3135704,

        [EnumValue("3135803")]
        [Description("Jequitinhonha - MG")]
        Jequitinhonha = 3135803,

        [EnumValue("3136009")]
        [Description("Joaima - MG")]
        Joaima = 3136009,

        [EnumValue("3136108")]
        [Description("Joanesia - MG")]
        Joanesia = 3136108,

        [EnumValue("3136207")]
        [Description("Joao Monlevade - MG")]
        JoaoMonlevade = 3136207,

        [EnumValue("3136306")]
        [Description("Joao Pinheiro - MG")]
        JoaoPinheiro = 3136306,

        [EnumValue("3136405")]
        [Description("Joaquim Felicio - MG")]
        JoaquimFelicio = 3136405,

        [EnumValue("3136504")]
        [Description("Jordania - MG")]
        Jordania = 3136504,

        [EnumValue("3136520")]
        [Description("Jose Goncalves de Minas - MG")]
        JoseGoncalvesdeMinas = 3136520,

        [EnumValue("3136553")]
        [Description("Jose Raydan - MG")]
        JoseRaydan = 3136553,

        [EnumValue("3136579")]
        [Description("Josenopolis - MG")]
        Josenopolis = 3136579,

        [EnumValue("3136603")]
        [Description("Nova Uniao - MG")]
        NovaUniao = 3136603,

        [EnumValue("3136652")]
        [Description("Juatuba - MG")]
        Juatuba = 3136652,

        [EnumValue("3136702")]
        [Description("Juiz de Fora - MG")]
        JuizdeFora = 3136702,

        [EnumValue("3136801")]
        [Description("Juramento - MG")]
        Juramento = 3136801,

        [EnumValue("3136900")]
        [Description("Juruaia - MG")]
        Juruaia = 3136900,

        [EnumValue("3136959")]
        [Description("Juvenilia - MG")]
        Juvenilia = 3136959,

        [EnumValue("3137007")]
        [Description("Ladainha - MG")]
        Ladainha = 3137007,

        [EnumValue("3137106")]
        [Description("Lagamar - MG")]
        Lagamar = 3137106,

        [EnumValue("3137205")]
        [Description("Lagoa da Prata - MG")]
        LagoadaPrata = 3137205,

        [EnumValue("3137304")]
        [Description("Lagoa dos Patos - MG")]
        LagoadosPatos = 3137304,

        [EnumValue("3137403")]
        [Description("Lagoa Dourada - MG")]
        LagoaDourada = 3137403,

        [EnumValue("3137502")]
        [Description("Lagoa Formosa - MG")]
        LagoaFormosa = 3137502,

        [EnumValue("3137536")]
        [Description("Lagoa Grande - MG")]
        LagoaGrande = 3137536,

        [EnumValue("3137601")]
        [Description("Lagoa Santa - MG")]
        LagoaSanta_MG = 3137601,

        [EnumValue("3137700")]
        [Description("Lajinha - MG")]
        Lajinha = 3137700,

        [EnumValue("3137809")]
        [Description("Lambari - MG")]
        Lambari = 3137809,

        [EnumValue("3137908")]
        [Description("Lamim - MG")]
        Lamim = 3137908,

        [EnumValue("3138005")]
        [Description("Laranjal - MG")]
        Laranjal = 3138005,

        [EnumValue("3138104")]
        [Description("Lassance - MG")]
        Lassance = 3138104,

        [EnumValue("3138203")]
        [Description("Lavras - MG")]
        Lavras = 3138203,

        [EnumValue("3138351")]
        [Description("Leme do Prado - MG")]
        LemedoPrado = 3138351,

        [EnumValue("3138401")]
        [Description("Leopoldina - MG")]
        Leopoldina = 3138401,

        [EnumValue("3138500")]
        [Description("Liberdade - MG")]
        Liberdade = 3138500,

        [EnumValue("3138609")]
        [Description("Lima Duarte - MG")]
        LimaDuarte = 3138609,

        [EnumValue("3138625")]
        [Description("Limeira do Oeste - MG")]
        LimeiradoOeste = 3138625,

        [EnumValue("3138658")]
        [Description("Lontra - MG")]
        Lontra = 3138658,

        [EnumValue("3138674")]
        [Description("Luisburgo - MG")]
        Luisburgo = 3138674,

        [EnumValue("3138708")]
        [Description("Luminarias - MG")]
        Luminarias = 3138708,

        [EnumValue("3138807")]
        [Description("Luz - MG")]
        Luz = 3138807,

        [EnumValue("3138906")]
        [Description("Machacalis - MG")]
        Machacalis = 3138906,

        [EnumValue("3139003")]
        [Description("Machado - MG")]
        Machado = 3139003,

        [EnumValue("3139102")]
        [Description("Madre de Deus de Minas - MG")]
        MadredeDeusdeMinas = 3139102,

        [EnumValue("3139201")]
        [Description("Malacacheta - MG")]
        Malacacheta = 3139201,

        [EnumValue("3139250")]
        [Description("Mamonas - MG")]
        Mamonas = 3139250,

        [EnumValue("3139300")]
        [Description("Manga - MG")]
        Manga = 3139300,

        [EnumValue("3139409")]
        [Description("Manhuacu - MG")]
        Manhuacu = 3139409,

        [EnumValue("3139508")]
        [Description("Manhumirim - MG")]
        Manhumirim = 3139508,

        [EnumValue("3139607")]
        [Description("Mantena - MG")]
        Mantena = 3139607,

        [EnumValue("3139706")]
        [Description("Maravilhas - MG")]
        Maravilhas = 3139706,

        [EnumValue("3139805")]
        [Description("Mar de Espanha - MG")]
        MardeEspanha = 3139805,

        [EnumValue("3139904")]
        [Description("Maria da Fe - MG")]
        MariadaFe = 3139904,

        [EnumValue("3140001")]
        [Description("Mariana - MG")]
        Mariana = 3140001,

        [EnumValue("3140100")]
        [Description("Marilac - MG")]
        Marilac = 3140100,

        [EnumValue("3140159")]
        [Description("Mario Campos - MG")]
        MarioCampos = 3140159,

        [EnumValue("3140209")]
        [Description("Maripa de Minas - MG")]
        MaripadeMinas = 3140209,

        [EnumValue("3140308")]
        [Description("Marlieria - MG")]
        Marlieria = 3140308,

        [EnumValue("3140407")]
        [Description("Marmelopolis - MG")]
        Marmelopolis = 3140407,

        [EnumValue("3140506")]
        [Description("Martinho Campos - MG")]
        MartinhoCampos = 3140506,

        [EnumValue("3140530")]
        [Description("Martins Soares - MG")]
        MartinsSoares = 3140530,

        [EnumValue("3140605")]
        [Description("Materlandia - MG")]
        Materlandia = 3140605,

        [EnumValue("3140704")]
        [Description("Mateus Leme - MG")]
        MateusLeme = 3140704,

        [EnumValue("3140803")]
        [Description("Matias Barbosa - MG")]
        MatiasBarbosa = 3140803,

        [EnumValue("3140852")]
        [Description("Matias Cardoso - MG")]
        MatiasCardoso = 3140852,

        [EnumValue("3141009")]
        [Description("Mato Verde - MG")]
        MatoVerde = 3141009,

        [EnumValue("3141108")]
        [Description("Matozinhos - MG")]
        Matozinhos = 3141108,

        [EnumValue("3141207")]
        [Description("Matutina - MG")]
        Matutina = 3141207,

        [EnumValue("3141306")]
        [Description("Medeiros - MG")]
        Medeiros = 3141306,

        [EnumValue("3141405")]
        [Description("Medina - MG")]
        Medina = 3141405,

        [EnumValue("3141603")]
        [Description("Merces - MG")]
        Merces = 3141603,

        [EnumValue("3141702")]
        [Description("Mesquita - MG")]
        Mesquita = 3141702,

        [EnumValue("3141801")]
        [Description("Minas Novas - MG")]
        MinasNovas = 3141801,

        [EnumValue("3141900")]
        [Description("Minduri - MG")]
        Minduri = 3141900,

        [EnumValue("3142007")]
        [Description("Mirabela - MG")]
        Mirabela = 3142007,

        [EnumValue("3142106")]
        [Description("Miradouro - MG")]
        Miradouro = 3142106,

        [EnumValue("3142205")]
        [Description("Mirai - MG")]
        Mirai = 3142205,

        [EnumValue("3142254")]
        [Description("Miravania - MG")]
        Miravania = 3142254,

        [EnumValue("3142304")]
        [Description("Moeda - MG")]
        Moeda = 3142304,

        [EnumValue("3142403")]
        [Description("Moema - MG")]
        Moema = 3142403,

        [EnumValue("3142502")]
        [Description("Monjolos - MG")]
        Monjolos = 3142502,

        [EnumValue("3142601")]
        [Description("Monsenhor Paulo - MG")]
        MonsenhorPaulo = 3142601,

        [EnumValue("3142700")]
        [Description("Montalvania - MG")]
        Montalvania = 3142700,

        [EnumValue("3142809")]
        [Description("Monte Alegre de Minas - MG")]
        MonteAlegredeMinas = 3142809,

        [EnumValue("3142908")]
        [Description("Monte Azul - MG")]
        MonteAzul = 3142908,

        [EnumValue("3143005")]
        [Description("Monte Belo - MG")]
        MonteBelo = 3143005,

        [EnumValue("3143104")]
        [Description("Monte Carmelo - MG")]
        MonteCarmelo = 3143104,

        [EnumValue("3143203")]
        [Description("Monte Santo de Minas - MG")]
        MonteSantodeMinas = 3143203,

        [EnumValue("3143302")]
        [Description("Montes Claros - MG")]
        MontesClaros = 3143302,

        [EnumValue("3143401")]
        [Description("Monte Siao - MG")]
        MonteSiao = 3143401,

        [EnumValue("3143450")]
        [Description("Montezuma - MG")]
        Montezuma = 3143450,

        [EnumValue("3143500")]
        [Description("Morada Nova de Minas - MG")]
        MoradaNovadeMinas = 3143500,

        [EnumValue("3143609")]
        [Description("Morro da Garca - MG")]
        MorrodaGarca = 3143609,

        [EnumValue("3143708")]
        [Description("Morro do Pilar - MG")]
        MorrodoPilar = 3143708,

        [EnumValue("3143906")]
        [Description("Muriae - MG")]
        Muriae = 3143906,

        [EnumValue("3144003")]
        [Description("Mutum - MG")]
        Mutum = 3144003,

        [EnumValue("3144102")]
        [Description("Muzambinho - MG")]
        Muzambinho = 3144102,

        [EnumValue("3144201")]
        [Description("Nacip Raydan - MG")]
        NacipRaydan = 3144201,

        [EnumValue("3144359")]
        [Description("Naque - MG")]
        Naque = 3144359,

        [EnumValue("3144375")]
        [Description("Natalandia - MG")]
        Natalandia = 3144375,

        [EnumValue("3144409")]
        [Description("Natercia - MG")]
        Natercia = 3144409,

        [EnumValue("3144508")]
        [Description("Nazareno - MG")]
        Nazareno = 3144508,

        [EnumValue("3144607")]
        [Description("Nepomuceno - MG")]
        Nepomuceno = 3144607,

        [EnumValue("3144656")]
        [Description("Ninheira - MG")]
        Ninheira = 3144656,

        [EnumValue("3144672")]
        [Description("Nova Belem - MG")]
        NovaBelem = 3144672,

        [EnumValue("3144706")]
        [Description("Nova Era - MG")]
        NovaEra = 3144706,

        [EnumValue("3144805")]
        [Description("Nova Lima - MG")]
        NovaLima = 3144805,

        [EnumValue("3144904")]
        [Description("Nova Modica - MG")]
        NovaModica = 3144904,

        [EnumValue("3145000")]
        [Description("Nova Ponte - MG")]
        NovaPonte = 3145000,

        [EnumValue("3145059")]
        [Description("Nova Porteirinha - MG")]
        NovaPorteirinha = 3145059,

        [EnumValue("3145109")]
        [Description("Nova Resende - MG")]
        NovaResende = 3145109,

        [EnumValue("3145208")]
        [Description("Nova Serrana - MG")]
        NovaSerrana = 3145208,

        [EnumValue("3145307")]
        [Description("Novo Cruzeiro - MG")]
        NovoCruzeiro = 3145307,

        [EnumValue("3145356")]
        [Description("Novo Oriente de Minas - MG")]
        NovoOrientedeMinas = 3145356,

        [EnumValue("3145372")]
        [Description("Novorizonte - MG")]
        Novorizonte = 3145372,

        [EnumValue("3145406")]
        [Description("Olaria - MG")]
        Olaria = 3145406,

        [EnumValue("3145455")]
        [Description("Olhos-dAgua - MG")]
        OlhosdAgua = 3145455,

        [EnumValue("3145505")]
        [Description("Olimpio Noronha - MG")]
        OlimpioNoronha = 3145505,

        [EnumValue("3145604")]
        [Description("Oliveira - MG")]
        Oliveira = 3145604,

        [EnumValue("3145703")]
        [Description("Oliveira Fortes - MG")]
        OliveiraFortes = 3145703,

        [EnumValue("3145851")]
        [Description("Oratorios - MG")]
        Oratorios = 3145851,

        [EnumValue("3145877")]
        [Description("Orizania - MG")]
        Orizania = 3145877,

        [EnumValue("3145901")]
        [Description("Ouro Branco - MG")]
        OuroBranco_MG = 3145901,

        [EnumValue("3146008")]
        [Description("Ouro Fino - MG")]
        OuroFino = 3146008,

        [EnumValue("3146107")]
        [Description("Ouro Preto - MG")]
        OuroPreto = 3146107,

        [EnumValue("3146255")]
        [Description("Padre Carvalho - MG")]
        PadreCarvalho = 3146255,

        [EnumValue("3146305")]
        [Description("Padre Paraiso - MG")]
        PadreParaiso = 3146305,

        [EnumValue("3146404")]
        [Description("Paineiras - MG")]
        Paineiras = 3146404,

        [EnumValue("3146503")]
        [Description("Pains - MG")]
        Pains = 3146503,

        [EnumValue("3146552")]
        [Description("Pai Pedro - MG")]
        PaiPedro = 3146552,

        [EnumValue("3146602")]
        [Description("Paiva - MG")]
        Paiva = 3146602,

        [EnumValue("3146750")]
        [Description("Palmopolis - MG")]
        Palmopolis = 3146750,

        [EnumValue("3146909")]
        [Description("Papagaios - MG")]
        Papagaios = 3146909,

        [EnumValue("3147006")]
        [Description("Paracatu - MG")]
        Paracatu = 3147006,

        [EnumValue("3147105")]
        [Description("Para de Minas - MG")]
        ParadeMinas = 3147105,

        [EnumValue("3147204")]
        [Description("Paraguacu - MG")]
        Paraguacu = 3147204,

        [EnumValue("3147402")]
        [Description("Paraopeba - MG")]
        Paraopeba = 3147402,

        [EnumValue("3147501")]
        [Description("Passabem - MG")]
        Passabem = 3147501,

        [EnumValue("3147600")]
        [Description("Passa Quatro - MG")]
        PassaQuatro = 3147600,

        [EnumValue("3147709")]
        [Description("Passa Tempo - MG")]
        PassaTempo = 3147709,

        [EnumValue("3147808")]
        [Description("Passa Vinte - MG")]
        PassaVinte = 3147808,

        [EnumValue("3147907")]
        [Description("Passos - MG")]
        Passos = 3147907,

        [EnumValue("3147956")]
        [Description("Patis - MG")]
        Patis = 3147956,

        [EnumValue("3148004")]
        [Description("Patos de Minas - MG")]
        PatosdeMinas = 3148004,

        [EnumValue("3148103")]
        [Description("Patrocinio - MG")]
        Patrocinio = 3148103,

        [EnumValue("3148202")]
        [Description("Patrocinio do Muriae - MG")]
        PatrociniodoMuriae = 3148202,

        [EnumValue("3148301")]
        [Description("Paula Candido - MG")]
        PaulaCandido = 3148301,

        [EnumValue("3148400")]
        [Description("Paulistas - MG")]
        Paulistas = 3148400,

        [EnumValue("3148509")]
        [Description("Pavao - MG")]
        Pavao = 3148509,

        [EnumValue("3148608")]
        [Description("Pecanha - MG")]
        Pecanha = 3148608,

        [EnumValue("3148707")]
        [Description("Pedra Azul - MG")]
        PedraAzul = 3148707,

        [EnumValue("3148756")]
        [Description("Pedra Bonita - MG")]
        PedraBonita = 3148756,

        [EnumValue("3148806")]
        [Description("Pedra do Anta - MG")]
        PedradoAnta = 3148806,

        [EnumValue("3148905")]
        [Description("Pedra do Indaia - MG")]
        PedradoIndaia = 3148905,

        [EnumValue("3149002")]
        [Description("Pedra Dourada - MG")]
        PedraDourada = 3149002,

        [EnumValue("3149101")]
        [Description("Pedralva - MG")]
        Pedralva = 3149101,

        [EnumValue("3149150")]
        [Description("Pedras de Maria da Cruz - MG")]
        PedrasdeMariadaCruz = 3149150,

        [EnumValue("3149200")]
        [Description("Pedrinopolis - MG")]
        Pedrinopolis = 3149200,

        [EnumValue("3149309")]
        [Description("Pedro Leopoldo - MG")]
        PedroLeopoldo = 3149309,

        [EnumValue("3149408")]
        [Description("Pedro Teixeira - MG")]
        PedroTeixeira = 3149408,

        [EnumValue("3149507")]
        [Description("Pequeri - MG")]
        Pequeri = 3149507,

        [EnumValue("3149606")]
        [Description("Pequi - MG")]
        Pequi = 3149606,

        [EnumValue("3149705")]
        [Description("Perdigao - MG")]
        Perdigao = 3149705,

        [EnumValue("3149804")]
        [Description("Perdizes - MG")]
        Perdizes = 3149804,

        [EnumValue("3149903")]
        [Description("Perdoes - MG")]
        Perdoes = 3149903,

        [EnumValue("3149952")]
        [Description("Periquito - MG")]
        Periquito = 3149952,

        [EnumValue("3150000")]
        [Description("Pescador - MG")]
        Pescador = 3150000,

        [EnumValue("3150109")]
        [Description("Piau - MG")]
        Piau = 3150109,

        [EnumValue("3150158")]
        [Description("Piedade de Caratinga - MG")]
        PiedadedeCaratinga = 3150158,

        [EnumValue("3150208")]
        [Description("Piedade de Ponte Nova - MG")]
        PiedadedePonteNova = 3150208,

        [EnumValue("3150307")]
        [Description("Piedade do Rio Grande - MG")]
        PiedadedoRioGrande = 3150307,

        [EnumValue("3150406")]
        [Description("Piedade dos Gerais - MG")]
        PiedadedosGerais = 3150406,

        [EnumValue("3150505")]
        [Description("Pimenta - MG")]
        Pimenta = 3150505,

        [EnumValue("3150539")]
        [Description("Pingo-dAgua - MG")]
        PingodAgua = 3150539,

        [EnumValue("3150570")]
        [Description("Pintopolis - MG")]
        Pintopolis = 3150570,

        [EnumValue("3150604")]
        [Description("Piracema - MG")]
        Piracema = 3150604,

        [EnumValue("3150703")]
        [Description("Pirajuba - MG")]
        Pirajuba = 3150703,

        [EnumValue("3150802")]
        [Description("Piranga - MG")]
        Piranga = 3150802,

        [EnumValue("3150901")]
        [Description("Pirangucu - MG")]
        Pirangucu = 3150901,

        [EnumValue("3151008")]
        [Description("Piranguinho - MG")]
        Piranguinho = 3151008,

        [EnumValue("3151107")]
        [Description("Pirapetinga - MG")]
        Pirapetinga = 3151107,

        [EnumValue("3151206")]
        [Description("Pirapora - MG")]
        Pirapora = 3151206,

        [EnumValue("3151305")]
        [Description("Pirauba - MG")]
        Pirauba = 3151305,

        [EnumValue("3151404")]
        [Description("Pitangui - MG")]
        Pitangui = 3151404,

        [EnumValue("3151503")]
        [Description("Piumhi - MG")]
        Piumhi = 3151503,

        [EnumValue("3151602")]
        [Description("Planura - MG")]
        Planura = 3151602,

        [EnumValue("3151701")]
        [Description("Poco Fundo - MG")]
        PocoFundo = 3151701,

        [EnumValue("3151800")]
        [Description("Pocos de Caldas - MG")]
        PocosdeCaldas = 3151800,

        [EnumValue("3151909")]
        [Description("Pocrane - MG")]
        Pocrane = 3151909,

        [EnumValue("3152006")]
        [Description("Pompeu - MG")]
        Pompeu = 3152006,

        [EnumValue("3152105")]
        [Description("Ponte Nova - MG")]
        PonteNova = 3152105,

        [EnumValue("3152131")]
        [Description("Ponto Chique - MG")]
        PontoChique = 3152131,

        [EnumValue("3152170")]
        [Description("Ponto dos Volantes - MG")]
        PontodosVolantes = 3152170,

        [EnumValue("3152204")]
        [Description("Porteirinha - MG")]
        Porteirinha = 3152204,

        [EnumValue("3152303")]
        [Description("Porto Firme - MG")]
        PortoFirme = 3152303,

        [EnumValue("3152402")]
        [Description("Pote - MG")]
        Pote = 3152402,

        [EnumValue("3152501")]
        [Description("Pouso Alegre - MG")]
        PousoAlegre = 3152501,

        [EnumValue("3152600")]
        [Description("Pouso Alto - MG")]
        PousoAlto = 3152600,

        [EnumValue("3152709")]
        [Description("Prados - MG")]
        Prados = 3152709,

        [EnumValue("3152808")]
        [Description("Prata - MG")]
        Prata = 3152808,

        [EnumValue("3152907")]
        [Description("Pratapolis - MG")]
        Pratapolis = 3152907,

        [EnumValue("3153004")]
        [Description("Pratinha - MG")]
        Pratinha = 3153004,

        [EnumValue("3153103")]
        [Description("Presidente Bernardes - MG")]
        PresidenteBernardes = 3153103,

        [EnumValue("3153202")]
        [Description("Presidente Juscelino - MG")]
        PresidenteJuscelino_MG = 3153202,

        [EnumValue("3153301")]
        [Description("Presidente Kubitschek - MG")]
        PresidenteKubitschek = 3153301,

        [EnumValue("3153400")]
        [Description("Presidente Olegario - MG")]
        PresidenteOlegario = 3153400,

        [EnumValue("3153509")]
        [Description("Alto Jequitiba - MG")]
        AltoJequitiba = 3153509,

        [EnumValue("3153608")]
        [Description("Prudente de Morais - MG")]
        PrudentedeMorais = 3153608,

        [EnumValue("3153707")]
        [Description("Quartel Geral - MG")]
        QuartelGeral = 3153707,

        [EnumValue("3153806")]
        [Description("Queluzito - MG")]
        Queluzito = 3153806,

        [EnumValue("3153905")]
        [Description("Raposos - MG")]
        Raposos = 3153905,

        [EnumValue("3154002")]
        [Description("Raul Soares - MG")]
        RaulSoares = 3154002,

        [EnumValue("3154101")]
        [Description("Recreio - MG")]
        Recreio = 3154101,

        [EnumValue("3154150")]
        [Description("Reduto - MG")]
        Reduto = 3154150,

        [EnumValue("3154200")]
        [Description("Resende Costa - MG")]
        ResendeCosta = 3154200,

        [EnumValue("3154309")]
        [Description("Resplendor - MG")]
        Resplendor = 3154309,

        [EnumValue("3154408")]
        [Description("Ressaquinha - MG")]
        Ressaquinha = 3154408,

        [EnumValue("3154457")]
        [Description("Riachinho - MG")]
        Riachinho = 3154457,

        [EnumValue("3154507")]
        [Description("Riacho dos Machados - MG")]
        RiachodosMachados = 3154507,

        [EnumValue("3154606")]
        [Description("Ribeirao das Neves - MG")]
        RibeiraodasNeves = 3154606,

        [EnumValue("3154705")]
        [Description("Ribeirao Vermelho - MG")]
        RibeiraoVermelho = 3154705,

        [EnumValue("3154804")]
        [Description("Rio Acima - MG")]
        RioAcima = 3154804,

        [EnumValue("3154903")]
        [Description("Rio Casca - MG")]
        RioCasca = 3154903,

        [EnumValue("3155009")]
        [Description("Rio Doce - MG")]
        RioDoce = 3155009,

        [EnumValue("3155108")]
        [Description("Rio do Prado - MG")]
        RiodoPrado = 3155108,

        [EnumValue("3155207")]
        [Description("Rio Espera - MG")]
        RioEspera = 3155207,

        [EnumValue("3155306")]
        [Description("Rio Manso - MG")]
        RioManso = 3155306,

        [EnumValue("3155405")]
        [Description("Rio Novo - MG")]
        RioNovo = 3155405,

        [EnumValue("3155504")]
        [Description("Rio Paranaiba - MG")]
        RioParanaiba = 3155504,

        [EnumValue("3155603")]
        [Description("Rio Pardo de Minas - MG")]
        RioPardodeMinas = 3155603,

        [EnumValue("3155702")]
        [Description("Rio Piracicaba - MG")]
        RioPiracicaba = 3155702,

        [EnumValue("3155801")]
        [Description("Rio Pomba - MG")]
        RioPomba = 3155801,

        [EnumValue("3155900")]
        [Description("Rio Preto - MG")]
        RioPreto = 3155900,

        [EnumValue("3156007")]
        [Description("Rio Vermelho - MG")]
        RioVermelho = 3156007,

        [EnumValue("3156106")]
        [Description("Ritapolis - MG")]
        Ritapolis = 3156106,

        [EnumValue("3156205")]
        [Description("Rochedo de Minas - MG")]
        RochedodeMinas = 3156205,

        [EnumValue("3156304")]
        [Description("Rodeiro - MG")]
        Rodeiro = 3156304,

        [EnumValue("3156403")]
        [Description("Romaria - MG")]
        Romaria = 3156403,

        [EnumValue("3156452")]
        [Description("Rosario da Limeira - MG")]
        RosariodaLimeira = 3156452,

        [EnumValue("3156502")]
        [Description("Rubelita - MG")]
        Rubelita = 3156502,

        [EnumValue("3156601")]
        [Description("Rubim - MG")]
        Rubim = 3156601,

        [EnumValue("3156700")]
        [Description("Sabara - MG")]
        Sabara = 3156700,

        [EnumValue("3156809")]
        [Description("Sabinopolis - MG")]
        Sabinopolis = 3156809,

        [EnumValue("3156908")]
        [Description("Sacramento - MG")]
        Sacramento = 3156908,

        [EnumValue("3157005")]
        [Description("Salinas - MG")]
        Salinas = 3157005,

        [EnumValue("3157104")]
        [Description("Salto da Divisa - MG")]
        SaltodaDivisa = 3157104,

        [EnumValue("3157203")]
        [Description("Santa Barbara - MG")]
        SantaBarbara_MG = 3157203,

        [EnumValue("3157252")]
        [Description("Santa Barbara do Leste - MG")]
        SantaBarbaradoLeste = 3157252,

        [EnumValue("3157278")]
        [Description("Santa Barbara do Monte Verde - MG")]
        SantaBarbaradoMonteVerde = 3157278,

        [EnumValue("3157302")]
        [Description("Santa Barbara do Tugurio - MG")]
        SantaBarbaradoTugurio = 3157302,

        [EnumValue("3157336")]
        [Description("Santa Cruz de Minas - MG")]
        SantaCruzdeMinas = 3157336,

        [EnumValue("3157377")]
        [Description("Santa Cruz de Salinas - MG")]
        SantaCruzdeSalinas = 3157377,

        [EnumValue("3157401")]
        [Description("Santa Cruz do Escalvado - MG")]
        SantaCruzdoEscalvado = 3157401,

        [EnumValue("3157500")]
        [Description("Santa Efigenia de Minas - MG")]
        SantaEfigeniadeMinas = 3157500,

        [EnumValue("3157609")]
        [Description("Santa Fe de Minas - MG")]
        SantaFedeMinas = 3157609,

        [EnumValue("3157658")]
        [Description("Santa Helena de Minas - MG")]
        SantaHelenadeMinas = 3157658,

        [EnumValue("3157708")]
        [Description("Santa Juliana - MG")]
        SantaJuliana = 3157708,

        [EnumValue("3157807")]
        [Description("Santa Luzia - MG")]
        SantaLuzia_MG = 3157807,

        [EnumValue("3157906")]
        [Description("Santa Margarida - MG")]
        SantaMargarida = 3157906,

        [EnumValue("3158003")]
        [Description("Santa Maria de Itabira - MG")]
        SantaMariadeItabira = 3158003,

        [EnumValue("3158102")]
        [Description("Santa Maria do Salto - MG")]
        SantaMariadoSalto = 3158102,

        [EnumValue("3158201")]
        [Description("Santa Maria do Suacui - MG")]
        SantaMariadoSuacui = 3158201,

        [EnumValue("3158300")]
        [Description("Santana da Vargem - MG")]
        SantanadaVargem = 3158300,

        [EnumValue("3158409")]
        [Description("Santana de Cataguases - MG")]
        SantanadeCataguases = 3158409,

        [EnumValue("3158508")]
        [Description("Santana de Pirapama - MG")]
        SantanadePirapama = 3158508,

        [EnumValue("3158607")]
        [Description("Santana do Deserto - MG")]
        SantanadoDeserto = 3158607,

        [EnumValue("3158706")]
        [Description("Santana do Garambeu - MG")]
        SantanadoGarambeu = 3158706,

        [EnumValue("3158805")]
        [Description("Santana do Jacare - MG")]
        SantanadoJacare = 3158805,

        [EnumValue("3158904")]
        [Description("Santana do Manhuacu - MG")]
        SantanadoManhuacu = 3158904,

        [EnumValue("3158953")]
        [Description("Santana do Paraiso - MG")]
        SantanadoParaiso = 3158953,

        [EnumValue("3159001")]
        [Description("Santana do Riacho - MG")]
        SantanadoRiacho = 3159001,

        [EnumValue("3159100")]
        [Description("Santana dos Montes - MG")]
        SantanadosMontes = 3159100,

        [EnumValue("3159209")]
        [Description("Santa Rita de Caldas - MG")]
        SantaRitadeCaldas = 3159209,

        [EnumValue("3159308")]
        [Description("Santa Rita de Jacutinga - MG")]
        SantaRitadeJacutinga = 3159308,

        [EnumValue("3159357")]
        [Description("Santa Rita de Minas - MG")]
        SantaRitadeMinas = 3159357,

        [EnumValue("3159407")]
        [Description("Santa Rita de Ibitipoca - MG")]
        SantaRitadeIbitipoca = 3159407,

        [EnumValue("3159506")]
        [Description("Santa Rita do Itueto - MG")]
        SantaRitadoItueto = 3159506,

        [EnumValue("3159605")]
        [Description("Santa Rita do Sapucai - MG")]
        SantaRitadoSapucai = 3159605,

        [EnumValue("3159704")]
        [Description("Santa Rosa da Serra - MG")]
        SantaRosadaSerra = 3159704,

        [EnumValue("3159803")]
        [Description("Santa Vitoria - MG")]
        SantaVitoria = 3159803,

        [EnumValue("3159902")]
        [Description("Santo Antonio do Amparo - MG")]
        SantoAntoniodoAmparo = 3159902,

        [EnumValue("3160009")]
        [Description("Santo Antonio do Aventureiro - MG")]
        SantoAntoniodoAventureiro = 3160009,

        [EnumValue("3160108")]
        [Description("Santo Antonio do Grama - MG")]
        SantoAntoniodoGrama = 3160108,

        [EnumValue("3160207")]
        [Description("Santo Antonio do Itambe - MG")]
        SantoAntoniodoItambe = 3160207,

        [EnumValue("3160306")]
        [Description("Santo Antonio do Jacinto - MG")]
        SantoAntoniodoJacinto = 3160306,

        [EnumValue("3160405")]
        [Description("Santo Antonio do Monte - MG")]
        SantoAntoniodoMonte = 3160405,

        [EnumValue("3160454")]
        [Description("Santo Antonio do Retiro - MG")]
        SantoAntoniodoRetiro = 3160454,

        [EnumValue("3160504")]
        [Description("Santo Antonio do Rio Abaixo - MG")]
        SantoAntoniodoRioAbaixo = 3160504,

        [EnumValue("3160603")]
        [Description("Santo Hipolito - MG")]
        SantoHipolito = 3160603,

        [EnumValue("3160702")]
        [Description("Santos Dumont - MG")]
        SantosDumont = 3160702,

        [EnumValue("3160801")]
        [Description("Sao Bento Abade - MG")]
        SaoBentoAbade = 3160801,

        [EnumValue("3160900")]
        [Description("Sao Bras do Suacui - MG")]
        SaoBrasdoSuacui = 3160900,

        [EnumValue("3160959")]
        [Description("Sao Domingos das Dores - MG")]
        SaoDomingosdasDores = 3160959,

        [EnumValue("3161007")]
        [Description("Sao Domingos do Prata - MG")]
        SaoDomingosdoPrata = 3161007,

        [EnumValue("3161056")]
        [Description("Sao Felix de Minas - MG")]
        SaoFelixdeMinas = 3161056,

        [EnumValue("3161106")]
        [Description("Sao Francisco - MG")]
        SaoFrancisco = 3161106,

        [EnumValue("3161205")]
        [Description("Sao Francisco de Paula - MG")]
        SaoFranciscodePaula = 3161205,

        [EnumValue("3161304")]
        [Description("Sao Francisco de Sales - MG")]
        SaoFranciscodeSales = 3161304,

        [EnumValue("3161403")]
        [Description("Sao Francisco do Gloria - MG")]
        SaoFranciscodoGloria = 3161403,

        [EnumValue("3161502")]
        [Description("Sao Geraldo - MG")]
        SaoGeraldo = 3161502,

        [EnumValue("3161601")]
        [Description("Sao Geraldo da Piedade - MG")]
        SaoGeraldodaPiedade = 3161601,

        [EnumValue("3161650")]
        [Description("Sao Geraldo do Baixio - MG")]
        SaoGeraldodoBaixio = 3161650,

        [EnumValue("3161700")]
        [Description("Sao Goncalo do Abaete - MG")]
        SaoGoncalodoAbaete = 3161700,

        [EnumValue("3161809")]
        [Description("Sao Goncalo do Para - MG")]
        SaoGoncalodoPara = 3161809,

        [EnumValue("3161908")]
        [Description("Sao Goncalo do Rio Abaixo - MG")]
        SaoGoncalodoRioAbaixo = 3161908,

        [EnumValue("3162005")]
        [Description("Sao Goncalo do Sapucai - MG")]
        SaoGoncalodoSapucai = 3162005,

        [EnumValue("3162104")]
        [Description("Sao Gotardo - MG")]
        SaoGotardo = 3162104,

        [EnumValue("3162203")]
        [Description("Sao Joao Batista do Gloria - MG")]
        SaoJoaoBatistadoGloria = 3162203,

        [EnumValue("3162252")]
        [Description("Sao Joao da Lagoa - MG")]
        SaoJoaodaLagoa = 3162252,

        [EnumValue("3162302")]
        [Description("Sao Joao da Mata - MG")]
        SaoJoaodaMata = 3162302,

        [EnumValue("3162401")]
        [Description("Sao Joao da Ponte - MG")]
        SaoJoaodaPonte = 3162401,

        [EnumValue("3162450")]
        [Description("Sao Joao das Missoes - MG")]
        SaoJoaodasMissoes = 3162450,

        [EnumValue("3162500")]
        [Description("Sao Joao del Rei - MG")]
        SaoJoaodelRei = 3162500,

        [EnumValue("3162559")]
        [Description("Sao Joao do Manhuacu - MG")]
        SaoJoaodoManhuacu = 3162559,

        [EnumValue("3162575")]
        [Description("Sao Joao do Manteninha - MG")]
        SaoJoaodoManteninha = 3162575,

        [EnumValue("3162658")]
        [Description("Sao Joao do Pacui - MG")]
        SaoJoaodoPacui = 3162658,

        [EnumValue("3162807")]
        [Description("Sao Joao Evangelista - MG")]
        SaoJoaoEvangelista = 3162807,

        [EnumValue("3162906")]
        [Description("Sao Joao Nepomuceno - MG")]
        SaoJoaoNepomuceno = 3162906,

        [EnumValue("3162922")]
        [Description("Sao Joaquim de Bicas - MG")]
        SaoJoaquimdeBicas = 3162922,

        [EnumValue("3162948")]
        [Description("Sao Jose da Barra - MG")]
        SaoJosedaBarra = 3162948,

        [EnumValue("3162955")]
        [Description("Sao Jose da Lapa - MG")]
        SaoJosedaLapa = 3162955,

        [EnumValue("3163102")]
        [Description("Sao Jose da Varginha - MG")]
        SaoJosedaVarginha = 3163102,

        [EnumValue("3163201")]
        [Description("Sao Jose do Alegre - MG")]
        SaoJosedoAlegre = 3163201,

        [EnumValue("3163300")]
        [Description("Sao Jose do Divino - MG")]
        SaoJosedoDivino = 3163300,

        [EnumValue("3163409")]
        [Description("Sao Jose do Goiabal - MG")]
        SaoJosedoGoiabal = 3163409,

        [EnumValue("3163508")]
        [Description("Sao Jose do Jacuri - MG")]
        SaoJosedoJacuri = 3163508,

        [EnumValue("3163706")]
        [Description("Sao Lourenco - MG")]
        SaoLourenco = 3163706,

        [EnumValue("3163805")]
        [Description("Sao Miguel do Anta - MG")]
        SaoMigueldoAnta = 3163805,

        [EnumValue("3163904")]
        [Description("Sao Pedro da Uniao - MG")]
        SaoPedrodaUniao = 3163904,

        [EnumValue("3164001")]
        [Description("Sao Pedro dos Ferros - MG")]
        SaoPedrodosFerros = 3164001,

        [EnumValue("3164100")]
        [Description("Sao Pedro do Suacui - MG")]
        SaoPedrodoSuacui = 3164100,

        [EnumValue("3164209")]
        [Description("Sao Romao - MG")]
        SaoRomao = 3164209,

        [EnumValue("3164308")]
        [Description("Sao Roque de Minas - MG")]
        SaoRoquedeMinas = 3164308,

        [EnumValue("3164407")]
        [Description("Sao Sebastiao da Bela Vista - MG")]
        SaoSebastiaodaBelaVista = 3164407,

        [EnumValue("3164431")]
        [Description("Sao Sebastiao da Vargem Alegre - MG")]
        SaoSebastiaodaVargemAlegre = 3164431,

        [EnumValue("3164506")]
        [Description("Sao Sebastiao do Maranhao - MG")]
        SaoSebastiaodoMaranhao = 3164506,

        [EnumValue("3164605")]
        [Description("Sao Sebastiao do Oeste - MG")]
        SaoSebastiaodoOeste = 3164605,

        [EnumValue("3164704")]
        [Description("Sao Sebastiao do Paraiso - MG")]
        SaoSebastiaodoParaiso = 3164704,

        [EnumValue("3164803")]
        [Description("Sao Sebastiao do Rio Preto - MG")]
        SaoSebastiaodoRioPreto = 3164803,

        [EnumValue("3164902")]
        [Description("Sao Sebastiao do Rio Verde - MG")]
        SaoSebastiaodoRioVerde = 3164902,

        [EnumValue("3165008")]
        [Description("Sao Tiago - MG")]
        SaoTiago = 3165008,

        [EnumValue("3165107")]
        [Description("Sao Tomas de Aquino - MG")]
        SaoTomasdeAquino = 3165107,

        [EnumValue("3165206")]
        [Description("Sao Tome das Letras - MG")]
        SaoTomedasLetras = 3165206,

        [EnumValue("3165305")]
        [Description("Sao Vicente de Minas - MG")]
        SaoVicentedeMinas = 3165305,

        [EnumValue("3165404")]
        [Description("Sapucai-Mirim - MG")]
        SapucaiMirim = 3165404,

        [EnumValue("3165503")]
        [Description("Sardoa - MG")]
        Sardoa = 3165503,

        [EnumValue("3165537")]
        [Description("Sarzedo - MG")]
        Sarzedo = 3165537,

        [EnumValue("3165552")]
        [Description("Setubinha - MG")]
        Setubinha = 3165552,

        [EnumValue("3165560")]
        [Description("Sem-Peixe - MG")]
        SemPeixe = 3165560,

        [EnumValue("3165578")]
        [Description("Senador Amaral - MG")]
        SenadorAmaral = 3165578,

        [EnumValue("3165701")]
        [Description("Senador Firmino - MG")]
        SenadorFirmino = 3165701,

        [EnumValue("3165800")]
        [Description("Senador Jose Bento - MG")]
        SenadorJoseBento = 3165800,

        [EnumValue("3165909")]
        [Description("Senador Modestino Goncalves - MG")]
        SenadorModestinoGoncalves = 3165909,

        [EnumValue("3166006")]
        [Description("Senhora de Oliveira - MG")]
        SenhoradeOliveira = 3166006,

        [EnumValue("3166204")]
        [Description("Senhora dos Remedios - MG")]
        SenhoradosRemedios = 3166204,

        [EnumValue("3166303")]
        [Description("Sericita - MG")]
        Sericita = 3166303,

        [EnumValue("3166402")]
        [Description("Seritinga - MG")]
        Seritinga = 3166402,

        [EnumValue("3166501")]
        [Description("Serra Azul de Minas - MG")]
        SerraAzuldeMinas = 3166501,

        [EnumValue("3166600")]
        [Description("Serra da Saudade - MG")]
        SerradaSaudade = 3166600,

        [EnumValue("3166709")]
        [Description("Serra dos Aimores - MG")]
        SerradosAimores = 3166709,

        [EnumValue("3166808")]
        [Description("Serra do Salitre - MG")]
        SerradoSalitre = 3166808,

        [EnumValue("3166907")]
        [Description("Serrania - MG")]
        Serrania = 3166907,

        [EnumValue("3166956")]
        [Description("Serranopolis de Minas - MG")]
        SerranopolisdeMinas = 3166956,

        [EnumValue("3167004")]
        [Description("Serranos - MG")]
        Serranos = 3167004,

        [EnumValue("3167103")]
        [Description("Serro - MG")]
        Serro = 3167103,

        [EnumValue("3167202")]
        [Description("Sete Lagoas - MG")]
        SeteLagoas = 3167202,

        [EnumValue("3167301")]
        [Description("Silveirania - MG")]
        Silveirania = 3167301,

        [EnumValue("3167400")]
        [Description("Silvianopolis - MG")]
        Silvianopolis = 3167400,

        [EnumValue("3167509")]
        [Description("Simao Pereira - MG")]
        SimaoPereira = 3167509,

        [EnumValue("3167608")]
        [Description("Simonesia - MG")]
        Simonesia = 3167608,

        [EnumValue("3167806")]
        [Description("Soledade de Minas - MG")]
        SoledadedeMinas = 3167806,

        [EnumValue("3167905")]
        [Description("Tabuleiro - MG")]
        Tabuleiro = 3167905,

        [EnumValue("3168002")]
        [Description("Taiobeiras - MG")]
        Taiobeiras = 3168002,

        [EnumValue("3168101")]
        [Description("Tapira - MG")]
        Tapira = 3168101,

        [EnumValue("3168200")]
        [Description("Tapirai - MG")]
        Tapirai = 3168200,

        [EnumValue("3168309")]
        [Description("Taquaracu de Minas - MG")]
        TaquaracudeMinas = 3168309,

        [EnumValue("3168408")]
        [Description("Tarumirim - MG")]
        Tarumirim = 3168408,

        [EnumValue("3168507")]
        [Description("Teixeiras - MG")]
        Teixeiras = 3168507,

        [EnumValue("3168606")]
        [Description("Teofilo Otoni - MG")]
        TeofiloOtoni = 3168606,

        [EnumValue("3168705")]
        [Description("Timoteo - MG")]
        Timoteo = 3168705,

        [EnumValue("3168804")]
        [Description("Tiradentes - MG")]
        Tiradentes = 3168804,

        [EnumValue("3168903")]
        [Description("Tiros - MG")]
        Tiros = 3168903,

        [EnumValue("3169000")]
        [Description("Tocantins - MG")]
        Tocantins = 3169000,

        [EnumValue("3169109")]
        [Description("Toledo - MG")]
        Toledo = 3169109,

        [EnumValue("3169307")]
        [Description("Tres Coracoes - MG")]
        TresCoracoes = 3169307,

        [EnumValue("3169356")]
        [Description("Tres Marias - MG")]
        TresMarias = 3169356,

        [EnumValue("3169406")]
        [Description("Tres Pontas - MG")]
        TresPontas = 3169406,

        [EnumValue("3169505")]
        [Description("Tumiritinga - MG")]
        Tumiritinga = 3169505,

        [EnumValue("3169604")]
        [Description("Tupaciguara - MG")]
        Tupaciguara = 3169604,

        [EnumValue("3169703")]
        [Description("Turmalina - MG")]
        Turmalina = 3169703,

        [EnumValue("3169901")]
        [Description("Uba - MG")]
        Uba = 3169901,

        [EnumValue("3170008")]
        [Description("Ubai - MG")]
        Ubai = 3170008,

        [EnumValue("3170057")]
        [Description("Ubaporanga - MG")]
        Ubaporanga = 3170057,

        [EnumValue("3170107")]
        [Description("Uberaba - MG")]
        Uberaba = 3170107,

        [EnumValue("3170206")]
        [Description("Uberlandia - MG")]
        Uberlandia = 3170206,

        [EnumValue("3170305")]
        [Description("Umburatiba - MG")]
        Umburatiba = 3170305,

        [EnumValue("3170404")]
        [Description("Unai - MG")]
        Unai = 3170404,

        [EnumValue("3170438")]
        [Description("Uniao de Minas - MG")]
        UniaodeMinas = 3170438,

        [EnumValue("3170479")]
        [Description("Uruana de Minas - MG")]
        UruanadeMinas = 3170479,

        [EnumValue("3170503")]
        [Description("Urucania - MG")]
        Urucania = 3170503,

        [EnumValue("3170529")]
        [Description("Urucuia - MG")]
        Urucuia = 3170529,

        [EnumValue("3170578")]
        [Description("Vargem Alegre - MG")]
        VargemAlegre = 3170578,

        [EnumValue("3170602")]
        [Description("Vargem Bonita - MG")]
        VargemBonita = 3170602,

        [EnumValue("3170651")]
        [Description("Vargem Grande do Rio Pardo - MG")]
        VargemGrandedoRioPardo = 3170651,

        [EnumValue("3170701")]
        [Description("Varginha - MG")]
        Varginha = 3170701,

        [EnumValue("3170750")]
        [Description("Varjao de Minas - MG")]
        VarjaodeMinas = 3170750,

        [EnumValue("3170800")]
        [Description("Varzea da Palma - MG")]
        VarzeadaPalma = 3170800,

        [EnumValue("3170909")]
        [Description("Varzelandia - MG")]
        Varzelandia = 3170909,

        [EnumValue("3171006")]
        [Description("Vazante - MG")]
        Vazante = 3171006,

        [EnumValue("3171030")]
        [Description("Verdelandia - MG")]
        Verdelandia = 3171030,

        [EnumValue("3171071")]
        [Description("Veredinha - MG")]
        Veredinha = 3171071,

        [EnumValue("3171105")]
        [Description("Verissimo - MG")]
        Verissimo = 3171105,

        [EnumValue("3171154")]
        [Description("Vermelho Novo - MG")]
        VermelhoNovo = 3171154,

        [EnumValue("3171204")]
        [Description("Vespasiano - MG")]
        Vespasiano = 3171204,

        [EnumValue("3171303")]
        [Description("Vicosa - MG")]
        Vicosa_MG = 3171303,

        [EnumValue("3171402")]
        [Description("Vieiras - MG")]
        Vieiras = 3171402,

        [EnumValue("3171501")]
        [Description("Mathias Lobato - MG")]
        MathiasLobato = 3171501,

        [EnumValue("3171600")]
        [Description("Virgem da Lapa - MG")]
        VirgemdaLapa = 3171600,

        [EnumValue("3171709")]
        [Description("Virginia - MG")]
        Virginia = 3171709,

        [EnumValue("3171808")]
        [Description("Virginopolis - MG")]
        Virginopolis = 3171808,

        [EnumValue("3172004")]
        [Description("Visconde do Rio Branco - MG")]
        ViscondedoRioBranco = 3172004,

        [EnumValue("3172103")]
        [Description("Volta Grande - MG")]
        VoltaGrande = 3172103,

        [EnumValue("3172202")]
        [Description("Wenceslau Braz - MG")]
        WenceslauBraz = 3172202,

        //======Mato Grosso do Sul======
        [EnumValue("5000203")]
        [Description("Agua Clara - MS")]
        AguaClara = 5000203,

        [EnumValue("5000252")]
        [Description("Alcinopolis - MS")]
        Alcinopolis = 5000252,

        [EnumValue("5000609")]
        [Description("Amambai - MS")]
        Amambai = 5000609,

        [EnumValue("5000708")]
        [Description("Anastacio - MS")]
        Anastacio = 5000708,

        [EnumValue("5000807")]
        [Description("Anaurilandia - MS")]
        Anaurilandia = 5000807,

        [EnumValue("5000856")]
        [Description("Angelica - MS")]
        Angelica = 5000856,

        [EnumValue("5000906")]
        [Description("Antonio Joao - MS")]
        AntonioJoao = 5000906,

        [EnumValue("5001003")]
        [Description("Aparecida do Taboado - MS")]
        AparecidadoTaboado = 5001003,

        [EnumValue("5001102")]
        [Description("Aquidauana - MS")]
        Aquidauana = 5001102,

        [EnumValue("5001243")]
        [Description("Aral Moreira - MS")]
        AralMoreira = 5001243,

        [EnumValue("5001508")]
        [Description("Bandeirantes - MS")]
        Bandeirantes = 5001508,

        [EnumValue("5001904")]
        [Description("Bataguassu - MS")]
        Bataguassu = 5001904,

        [EnumValue("5002001")]
        [Description("Bataypora - MS")]
        Bataypora = 5002001,

        [EnumValue("5002100")]
        [Description("Bela Vista - MS")]
        BelaVista = 5002100,

        [EnumValue("5002159")]
        [Description("Bodoquena - MS")]
        Bodoquena = 5002159,

        [EnumValue("5002209")]
        [Description("Bonito - MS")]
        Bonito_MS = 5002209,

        [EnumValue("5002308")]
        [Description("Brasilandia - MS")]
        Brasilandia = 5002308,

        [EnumValue("5002407")]
        [Description("Caarapo - MS")]
        Caarapo = 5002407,

        [EnumValue("5002605")]
        [Description("Camapua - MS")]
        Camapua = 5002605,

        [EnumValue("5002704")]
        [Description("Campo Grande - MS")]
        CampoGrande_MS = 5002704,

        [EnumValue("5002803")]
        [Description("Caracol - MS")]
        Caracol = 5002803,

        [EnumValue("5002902")]
        [Description("Cassilandia - MS")]
        Cassilandia = 5002902,

        [EnumValue("5002951")]
        [Description("Chapadao do Sul - MS")]
        ChapadaodoSul = 5002951,

        [EnumValue("5003108")]
        [Description("Corguinho - MS")]
        Corguinho = 5003108,

        [EnumValue("5003157")]
        [Description("Coronel Sapucaia - MS")]
        CoronelSapucaia = 5003157,

        [EnumValue("5003207")]
        [Description("Corumba - MS")]
        Corumba = 5003207,

        [EnumValue("5003256")]
        [Description("Costa Rica - MS")]
        CostaRica = 5003256,

        [EnumValue("5003306")]
        [Description("Coxim - MS")]
        Coxim = 5003306,

        [EnumValue("5003454")]
        [Description("Deodapolis - MS")]
        Deodapolis = 5003454,

        [EnumValue("5003488")]
        [Description("Dois Irmaos do Buriti - MS")]
        DoisIrmaosdoBuriti = 5003488,

        [EnumValue("5003702")]
        [Description("Dourados - MS")]
        Dourados = 5003702,

        [EnumValue("5003751")]
        [Description("Eldorado - MS")]
        Eldorado = 5003751,

        [EnumValue("5003801")]
        [Description("Fatima do Sul - MS")]
        FatimadoSul = 5003801,

        [EnumValue("5003900")]
        [Description("Figueirao - MS")]
        Figueirao = 5003900,

        [EnumValue("5004007")]
        [Description("Gloria de Dourados - MS")]
        GloriadeDourados = 5004007,

        [EnumValue("5004106")]
        [Description("Guia Lopes da Laguna - MS")]
        GuiaLopesdaLaguna = 5004106,

        [EnumValue("5004304")]
        [Description("Iguatemi - MS")]
        Iguatemi = 5004304,

        [EnumValue("5004403")]
        [Description("Inocencia - MS")]
        Inocencia = 5004403,

        [EnumValue("5004502")]
        [Description("Itapora - MS")]
        Itapora = 5004502,

        [EnumValue("5004601")]
        [Description("Itaquirai - MS")]
        Itaquirai = 5004601,

        [EnumValue("5004700")]
        [Description("Ivinhema - MS")]
        Ivinhema = 5004700,

        [EnumValue("5004809")]
        [Description("Japora - MS")]
        Japora = 5004809,

        [EnumValue("5004908")]
        [Description("Jaraguari - MS")]
        Jaraguari = 5004908,

        [EnumValue("5005004")]
        [Description("Jardim - MS")]
        Jardim_MS = 5005004,

        [EnumValue("5005152")]
        [Description("Juti - MS")]
        Juti = 5005152,

        [EnumValue("5005202")]
        [Description("Ladario - MS")]
        Ladario = 5005202,

        [EnumValue("5005251")]
        [Description("Laguna Carapa - MS")]
        LagunaCarapa = 5005251,

        [EnumValue("5005400")]
        [Description("Maracaju - MS")]
        Maracaju = 5005400,

        [EnumValue("5005608")]
        [Description("Miranda - MS")]
        Miranda = 5005608,

        [EnumValue("5005681")]
        [Description("Mundo Novo - MS")]
        MundoNovo_MS = 5005681,

        [EnumValue("5005707")]
        [Description("Navirai - MS")]
        Navirai = 5005707,

        [EnumValue("5005806")]
        [Description("Nioaque - MS")]
        Nioaque = 5005806,

        [EnumValue("5006002")]
        [Description("Nova Alvorada do Sul - MS")]
        NovaAlvoradadoSul = 5006002,

        [EnumValue("5006200")]
        [Description("Nova Andradina - MS")]
        NovaAndradina = 5006200,

        [EnumValue("5006259")]
        [Description("Novo Horizonte do Sul - MS")]
        NovoHorizontedoSul = 5006259,

        [EnumValue("5006275")]
        [Description("Paraiso das Aguas - MS")]
        ParaisodasAguas = 5006275,

        [EnumValue("5006309")]
        [Description("Paranaiba - MS")]
        Paranaiba = 5006309,

        [EnumValue("5006358")]
        [Description("Paranhos - MS")]
        Paranhos = 5006358,

        [EnumValue("5006408")]
        [Description("Pedro Gomes - MS")]
        PedroGomes = 5006408,

        [EnumValue("5006606")]
        [Description("Ponta Pora - MS")]
        PontaPora = 5006606,

        [EnumValue("5006903")]
        [Description("Porto Murtinho - MS")]
        PortoMurtinho = 5006903,

        [EnumValue("5007109")]
        [Description("Ribas do Rio Pardo - MS")]
        RibasdoRioPardo = 5007109,

        [EnumValue("5007208")]
        [Description("Rio Brilhante - MS")]
        RioBrilhante = 5007208,

        [EnumValue("5007307")]
        [Description("Rio Negro - MS")]
        RioNegro = 5007307,

        [EnumValue("5007406")]
        [Description("Rio Verde de Mato Grosso - MS")]
        RioVerdedeMatoGrosso = 5007406,

        [EnumValue("5007505")]
        [Description("Rochedo - MS")]
        Rochedo = 5007505,

        [EnumValue("5007554")]
        [Description("Santa Rita do Pardo - MS")]
        SantaRitadoPardo = 5007554,

        [EnumValue("5007695")]
        [Description("Sao Gabriel do Oeste - MS")]
        SaoGabrieldoOeste = 5007695,

        [EnumValue("5007703")]
        [Description("Sete Quedas - MS")]
        SeteQuedas = 5007703,

        [EnumValue("5007802")]
        [Description("Selviria - MS")]
        Selviria = 5007802,

        [EnumValue("5007901")]
        [Description("Sidrolandia - MS")]
        Sidrolandia = 5007901,

        [EnumValue("5007935")]
        [Description("Sonora - MS")]
        Sonora = 5007935,

        [EnumValue("5007950")]
        [Description("Tacuru - MS")]
        Tacuru = 5007950,

        [EnumValue("5007976")]
        [Description("Taquarussu - MS")]
        Taquarussu = 5007976,

        [EnumValue("5008008")]
        [Description("Terenos - MS")]
        Terenos = 5008008,

        [EnumValue("5008305")]
        [Description("Tres Lagoas - MS")]
        TresLagoas = 5008305,

        //======Mato Grosso======
        [EnumValue("5100102")]
        [Description("Acorizal - MT")]
        Acorizal = 5100102,

        [EnumValue("5100201")]
        [Description("Agua Boa - MT")]
        AguaBoa_MT = 5100201,

        [EnumValue("5100250")]
        [Description("Alta Floresta - MT")]
        AltaFloresta = 5100250,

        [EnumValue("5100300")]
        [Description("Alto Araguaia - MT")]
        AltoAraguaia = 5100300,

        [EnumValue("5100409")]
        [Description("Alto Garcas - MT")]
        AltoGarcas = 5100409,

        [EnumValue("5100607")]
        [Description("Alto Taquari - MT")]
        AltoTaquari = 5100607,

        [EnumValue("5100805")]
        [Description("Apiacas - MT")]
        Apiacas = 5100805,

        [EnumValue("5101001")]
        [Description("Araguaiana - MT")]
        Araguaiana = 5101001,

        [EnumValue("5101209")]
        [Description("Araguainha - MT")]
        Araguainha = 5101209,

        [EnumValue("5101258")]
        [Description("Araputanga - MT")]
        Araputanga = 5101258,

        [EnumValue("5101308")]
        [Description("Arenapolis - MT")]
        Arenapolis = 5101308,

        [EnumValue("5101407")]
        [Description("Aripuana - MT")]
        Aripuana = 5101407,

        [EnumValue("5101704")]
        [Description("Barra do Bugres - MT")]
        BarradoBugres = 5101704,

        [EnumValue("5101803")]
        [Description("Barra do Garcas - MT")]
        BarradoGarcas = 5101803,

        [EnumValue("5101837")]
        [Description("Boa Esperanca do Norte - MT")]
        BoaEsperancadoNorte = 5101837,

        [EnumValue("5101852")]
        [Description("Bom Jesus do Araguaia - MT")]
        BomJesusdoAraguaia = 5101852,

        [EnumValue("5101902")]
        [Description("Brasnorte - MT")]
        Brasnorte = 5101902,

        [EnumValue("5102504")]
        [Description("Caceres - MT")]
        Caceres = 5102504,

        [EnumValue("5102603")]
        [Description("Campinapolis - MT")]
        Campinapolis = 5102603,

        [EnumValue("5102637")]
        [Description("Campo Novo do Parecis - MT")]
        CampoNovodoParecis = 5102637,

        [EnumValue("5102678")]
        [Description("Campo Verde - MT")]
        CampoVerde = 5102678,

        [EnumValue("5102686")]
        [Description("Campos de Julio - MT")]
        CamposdeJulio = 5102686,

        [EnumValue("5102702")]
        [Description("Canarana - MT")]
        Canarana_MT = 5102702,

        [EnumValue("5102793")]
        [Description("Carlinda - MT")]
        Carlinda = 5102793,

        [EnumValue("5103007")]
        [Description("Chapada dos Guimaraes - MT")]
        ChapadadosGuimaraes = 5103007,

        [EnumValue("5103056")]
        [Description("Claudia - MT")]
        Claudia = 5103056,

        [EnumValue("5103106")]
        [Description("Cocalinho - MT")]
        Cocalinho = 5103106,

        [EnumValue("5103205")]
        [Description("Colider - MT")]
        Colider = 5103205,

        [EnumValue("5103254")]
        [Description("Colniza - MT")]
        Colniza = 5103254,

        [EnumValue("5103304")]
        [Description("Comodoro - MT")]
        Comodoro = 5103304,

        [EnumValue("5103353")]
        [Description("Confresa - MT")]
        Confresa = 5103353,

        [EnumValue("5103361")]
        [Description("Conquista DOeste - MT")]
        ConquistaDOeste = 5103361,

        [EnumValue("5103379")]
        [Description("Cotriguacu - MT")]
        Cotriguacu = 5103379,

        [EnumValue("5103403")]
        [Description("Cuiaba - MT")]
        Cuiaba = 5103403,

        [EnumValue("5103437")]
        [Description("Curvelandia - MT")]
        Curvelandia = 5103437,

        [EnumValue("5103452")]
        [Description("Denise - MT")]
        Denise = 5103452,

        [EnumValue("5103502")]
        [Description("Diamantino - MT")]
        Diamantino = 5103502,

        [EnumValue("5103601")]
        [Description("Dom Aquino - MT")]
        DomAquino = 5103601,

        [EnumValue("5103700")]
        [Description("Feliz Natal - MT")]
        FelizNatal = 5103700,

        [EnumValue("5103809")]
        [Description("Figueiropolis DOeste - MT")]
        FigueiropolisDOeste = 5103809,

        [EnumValue("5103858")]
        [Description("Gaucha do Norte - MT")]
        GauchadoNorte = 5103858,

        [EnumValue("5103908")]
        [Description("General Carneiro - MT")]
        GeneralCarneiro = 5103908,

        [EnumValue("5103957")]
        [Description("Gloria DOeste - MT")]
        GloriaDOeste = 5103957,

        [EnumValue("5104104")]
        [Description("Guaranta do Norte - MT")]
        GuarantadoNorte = 5104104,

        [EnumValue("5104203")]
        [Description("Guiratinga - MT")]
        Guiratinga = 5104203,

        [EnumValue("5104500")]
        [Description("Indiavai - MT")]
        Indiavai = 5104500,

        [EnumValue("5104526")]
        [Description("Ipiranga do Norte - MT")]
        IpirangadoNorte = 5104526,

        [EnumValue("5104542")]
        [Description("Itanhanga - MT")]
        Itanhanga = 5104542,

        [EnumValue("5104559")]
        [Description("Itauba - MT")]
        Itauba = 5104559,

        [EnumValue("5104609")]
        [Description("Itiquira - MT")]
        Itiquira = 5104609,

        [EnumValue("5104807")]
        [Description("Jaciara - MT")]
        Jaciara = 5104807,

        [EnumValue("5105002")]
        [Description("Jauru - MT")]
        Jauru = 5105002,

        [EnumValue("5105101")]
        [Description("Juara - MT")]
        Juara = 5105101,

        [EnumValue("5105150")]
        [Description("Juina - MT")]
        Juina = 5105150,

        [EnumValue("5105200")]
        [Description("Juscimeira - MT")]
        Juscimeira = 5105200,

        [EnumValue("5105234")]
        [Description("Lambari DOeste - MT")]
        LambariDOeste = 5105234,

        [EnumValue("5105259")]
        [Description("Lucas do Rio Verde - MT")]
        LucasdoRioVerde = 5105259,

        [EnumValue("5105309")]
        [Description("Luciara - MT")]
        Luciara = 5105309,

        [EnumValue("5105507")]
        [Description("Vila Bela da Santissima Trindade - MT")]
        VilaBeladaSantissimaTrindade = 5105507,

        [EnumValue("5105606")]
        [Description("Matupa - MT")]
        Matupa = 5105606,

        [EnumValue("5105622")]
        [Description("Mirassol dOeste - MT")]
        MirassoldOeste = 5105622,

        [EnumValue("5105903")]
        [Description("Nobres - MT")]
        Nobres = 5105903,

        [EnumValue("5106000")]
        [Description("Nortelandia - MT")]
        Nortelandia = 5106000,

        [EnumValue("5106109")]
        [Description("Nossa Senhora do Livramento - MT")]
        NossaSenhoradoLivramento = 5106109,

        [EnumValue("5106182")]
        [Description("Nova Lacerda - MT")]
        NovaLacerda = 5106182,

        [EnumValue("5106190")]
        [Description("Nova Santa Helena - MT")]
        NovaSantaHelena = 5106190,

        [EnumValue("5106208")]
        [Description("Nova Brasilandia - MT")]
        NovaBrasilandia = 5106208,

        [EnumValue("5106216")]
        [Description("Nova Canaa do Norte - MT")]
        NovaCanaadoNorte = 5106216,

        [EnumValue("5106224")]
        [Description("Nova Mutum - MT")]
        NovaMutum = 5106224,

        [EnumValue("5106232")]
        [Description("Nova Olimpia - MT")]
        NovaOlimpia = 5106232,

        [EnumValue("5106240")]
        [Description("Nova Ubirata - MT")]
        NovaUbirata = 5106240,

        [EnumValue("5106257")]
        [Description("Nova Xavantina - MT")]
        NovaXavantina = 5106257,

        [EnumValue("5106281")]
        [Description("Novo Sao Joaquim - MT")]
        NovoSaoJoaquim = 5106281,

        [EnumValue("5106307")]
        [Description("Paranatinga - MT")]
        Paranatinga = 5106307,

        [EnumValue("5106315")]
        [Description("Novo Santo Antonio - MT")]
        NovoSantoAntonio = 5106315,

        [EnumValue("5106372")]
        [Description("Pedra Preta - MT")]
        PedraPreta = 5106372,

        [EnumValue("5106422")]
        [Description("Peixoto de Azevedo - MT")]
        PeixotodeAzevedo = 5106422,

        [EnumValue("5106455")]
        [Description("Planalto da Serra - MT")]
        PlanaltodaSerra = 5106455,

        [EnumValue("5106505")]
        [Description("Pocone - MT")]
        Pocone = 5106505,

        [EnumValue("5106653")]
        [Description("Pontal do Araguaia - MT")]
        PontaldoAraguaia = 5106653,

        [EnumValue("5106703")]
        [Description("Ponte Branca - MT")]
        PonteBranca = 5106703,

        [EnumValue("5106752")]
        [Description("Pontes e Lacerda - MT")]
        PonteseLacerda = 5106752,

        [EnumValue("5106778")]
        [Description("Porto Alegre do Norte - MT")]
        PortoAlegredoNorte = 5106778,

        [EnumValue("5106802")]
        [Description("Porto dos Gauchos - MT")]
        PortodosGauchos = 5106802,

        [EnumValue("5106828")]
        [Description("Porto Esperidiao - MT")]
        PortoEsperidiao = 5106828,

        [EnumValue("5106851")]
        [Description("Porto Estrela - MT")]
        PortoEstrela = 5106851,

        [EnumValue("5107008")]
        [Description("Poxoreu - MT")]
        Poxoreu = 5107008,

        [EnumValue("5107040")]
        [Description("Primavera do Leste - MT")]
        PrimaveradoLeste = 5107040,

        [EnumValue("5107065")]
        [Description("Querencia - MT")]
        Querencia = 5107065,

        [EnumValue("5107107")]
        [Description("Sao Jose dos Quatro Marcos - MT")]
        SaoJosedosQuatroMarcos = 5107107,

        [EnumValue("5107156")]
        [Description("Reserva do Cabacal - MT")]
        ReservadoCabacal = 5107156,

        [EnumValue("5107180")]
        [Description("Ribeirao Cascalheira - MT")]
        RibeiraoCascalheira = 5107180,

        [EnumValue("5107198")]
        [Description("Ribeiraozinho - MT")]
        Ribeiraozinho = 5107198,

        [EnumValue("5107206")]
        [Description("Rio Branco - MT")]
        RioBranco_MT = 5107206,

        [EnumValue("5107248")]
        [Description("Santa Carmem - MT")]
        SantaCarmem = 5107248,

        [EnumValue("5107297")]
        [Description("Sao Jose do Povo - MT")]
        SaoJosedoPovo = 5107297,

        [EnumValue("5107305")]
        [Description("Sao Jose do Rio Claro - MT")]
        SaoJosedoRioClaro = 5107305,

        [EnumValue("5107354")]
        [Description("Sao Jose do Xingu - MT")]
        SaoJosedoXingu = 5107354,

        [EnumValue("5107404")]
        [Description("Sao Pedro da Cipa - MT")]
        SaoPedrodaCipa = 5107404,

        [EnumValue("5107578")]
        [Description("Rondolandia - MT")]
        Rondolandia = 5107578,

        [EnumValue("5107602")]
        [Description("Rondonopolis - MT")]
        Rondonopolis = 5107602,

        [EnumValue("5107701")]
        [Description("Rosario Oeste - MT")]
        RosarioOeste = 5107701,

        [EnumValue("5107750")]
        [Description("Salto do Ceu - MT")]
        SaltodoCeu = 5107750,

        [EnumValue("5107768")]
        [Description("Santa Rita do Trivelato - MT")]
        SantaRitadoTrivelato = 5107768,

        [EnumValue("5107776")]
        [Description("Santa Terezinha - MT")]
        SantaTerezinha_MT = 5107776,

        [EnumValue("5107792")]
        [Description("Santo Antonio do Leste - MT")]
        SantoAntoniodoLeste = 5107792,

        [EnumValue("5107800")]
        [Description("Santo Antonio de Leverger - MT")]
        SantoAntoniodeLeverger = 5107800,

        [EnumValue("5107859")]
        [Description("Sao Felix do Araguaia - MT")]
        SaoFelixdoAraguaia = 5107859,

        [EnumValue("5107875")]
        [Description("Sapezal - MT")]
        Sapezal = 5107875,

        [EnumValue("5107883")]
        [Description("Serra Nova Dourada - MT")]
        SerraNovaDourada = 5107883,

        [EnumValue("5107909")]
        [Description("Sinop - MT")]
        Sinop = 5107909,

        [EnumValue("5107925")]
        [Description("Sorriso - MT")]
        Sorriso = 5107925,

        [EnumValue("5107941")]
        [Description("Tabapora - MT")]
        Tabapora = 5107941,

        [EnumValue("5107958")]
        [Description("Tangara da Serra - MT")]
        TangaradaSerra = 5107958,

        [EnumValue("5108006")]
        [Description("Tapurah - MT")]
        Tapurah = 5108006,

        [EnumValue("5108105")]
        [Description("Tesouro - MT")]
        Tesouro = 5108105,

        [EnumValue("5108204")]
        [Description("Torixoreu - MT")]
        Torixoreu = 5108204,

        [EnumValue("5108352")]
        [Description("Vale de Sao Domingos - MT")]
        ValedeSaoDomingos = 5108352,

        [EnumValue("5108402")]
        [Description("Varzea Grande - MT")]
        VarzeaGrande = 5108402,

        [EnumValue("5108501")]
        [Description("Vera - MT")]
        Vera = 5108501,

        [EnumValue("5108600")]
        [Description("Vila Rica - MT")]
        VilaRica = 5108600,

        [EnumValue("5108857")]
        [Description("Nova Marilandia - MT")]
        NovaMarilandia = 5108857,

        [EnumValue("5108907")]
        [Description("Nova Maringa - MT")]
        NovaMaringa = 5108907,

        [EnumValue("5108956")]
        [Description("Nova Monte Verde - MT")]
        NovaMonteVerde = 5108956,

        //======Pará======
        [EnumValue("1500107")]
        [Description("Abaetetuba - PA")]
        Abaetetuba = 1500107,

        [EnumValue("1500131")]
        [Description("Abel Figueiredo - PA")]
        AbelFigueiredo = 1500131,

        [EnumValue("1500206")]
        [Description("Acara - PA")]
        Acara = 1500206,

        [EnumValue("1500347")]
        [Description("Agua Azul do Norte - PA")]
        AguaAzuldoNorte = 1500347,

        [EnumValue("1500404")]
        [Description("Alenquer - PA")]
        Alenquer = 1500404,

        [EnumValue("1500602")]
        [Description("Altamira - PA")]
        Altamira = 1500602,

        [EnumValue("1500800")]
        [Description("Ananindeua - PA")]
        Ananindeua = 1500800,

        [EnumValue("1500859")]
        [Description("Anapu - PA")]
        Anapu = 1500859,

        [EnumValue("1500909")]
        [Description("Augusto Correa - PA")]
        AugustoCorrea = 1500909,

        [EnumValue("1500958")]
        [Description("Aurora do Para - PA")]
        AuroradoPara = 1500958,

        [EnumValue("1501006")]
        [Description("Aveiro - PA")]
        Aveiro = 1501006,

        [EnumValue("1501105")]
        [Description("Bagre - PA")]
        Bagre = 1501105,

        [EnumValue("1501204")]
        [Description("Baiao - PA")]
        Baiao = 1501204,

        [EnumValue("1501253")]
        [Description("Bannach - PA")]
        Bannach = 1501253,

        [EnumValue("1501303")]
        [Description("Barcarena - PA")]
        Barcarena = 1501303,

        [EnumValue("1501402")]
        [Description("Belem - PA")]
        Belem_PA = 1501402,

        [EnumValue("1501451")]
        [Description("Belterra - PA")]
        Belterra = 1501451,

        [EnumValue("1501501")]
        [Description("Benevides - PA")]
        Benevides = 1501501,

        [EnumValue("1501576")]
        [Description("Bom Jesus do Tocantins - PA")]
        BomJesusdoTocantins = 1501576,

        [EnumValue("1501600")]
        [Description("Bonito - PA")]
        Bonito_PA = 1501600,

        [EnumValue("1501709")]
        [Description("Braganca - PA")]
        Braganca = 1501709,

        [EnumValue("1501725")]
        [Description("Brasil Novo - PA")]
        BrasilNovo = 1501725,

        [EnumValue("1501758")]
        [Description("Brejo Grande do Araguaia - PA")]
        BrejoGrandedoAraguaia = 1501758,

        [EnumValue("1501782")]
        [Description("Breu Branco - PA")]
        BreuBranco = 1501782,

        [EnumValue("1501808")]
        [Description("Breves - PA")]
        Breves = 1501808,

        [EnumValue("1501907")]
        [Description("Bujaru - PA")]
        Bujaru = 1501907,

        [EnumValue("1501956")]
        [Description("Cachoeira do Piria - PA")]
        CachoeiradoPiria = 1501956,

        [EnumValue("1502004")]
        [Description("Cachoeira do Arari - PA")]
        CachoeiradoArari = 1502004,

        [EnumValue("1502103")]
        [Description("Cameta - PA")]
        Cameta = 1502103,

        [EnumValue("1502152")]
        [Description("Canaa dos Carajas - PA")]
        CanaadosCarajas = 1502152,

        [EnumValue("1502202")]
        [Description("Capanema - PA")]
        Capanema = 1502202,

        [EnumValue("1502301")]
        [Description("Capitao Poco - PA")]
        CapitaoPoco = 1502301,

        [EnumValue("1502400")]
        [Description("Castanhal - PA")]
        Castanhal = 1502400,

        [EnumValue("1502707")]
        [Description("Conceicao do Araguaia - PA")]
        ConceicaodoAraguaia = 1502707,

        [EnumValue("1502756")]
        [Description("Concordia do Para - PA")]
        ConcordiadoPara = 1502756,

        [EnumValue("1502764")]
        [Description("Cumaru do Norte - PA")]
        CumarudoNorte = 1502764,

        [EnumValue("1502772")]
        [Description("Curionopolis - PA")]
        Curionopolis = 1502772,

        [EnumValue("1502806")]
        [Description("Curralinho - PA")]
        Curralinho = 1502806,

        [EnumValue("1502855")]
        [Description("Curua - PA")]
        Curua = 1502855,

        [EnumValue("1502905")]
        [Description("Curuca - PA")]
        Curuca = 1502905,

        [EnumValue("1502939")]
        [Description("Dom Eliseu - PA")]
        DomEliseu = 1502939,

        [EnumValue("1502954")]
        [Description("Eldorado do Carajas - PA")]
        EldoradodoCarajas = 1502954,

        [EnumValue("1503077")]
        [Description("Garrafao do Norte - PA")]
        GarrafaodoNorte = 1503077,

        [EnumValue("1503101")]
        [Description("Gurupa - PA")]
        Gurupa = 1503101,

        [EnumValue("1503200")]
        [Description("Igarape-Acu - PA")]
        IgarapeAcu = 1503200,

        [EnumValue("1503309")]
        [Description("Igarape-Miri - PA")]
        IgarapeMiri = 1503309,

        [EnumValue("1503408")]
        [Description("Inhangapi - PA")]
        Inhangapi = 1503408,

        [EnumValue("1503457")]
        [Description("Ipixuna do Para - PA")]
        IpixunadoPara = 1503457,

        [EnumValue("1503507")]
        [Description("Irituia - PA")]
        Irituia = 1503507,

        [EnumValue("1503606")]
        [Description("Itaituba - PA")]
        Itaituba = 1503606,

        [EnumValue("1503705")]
        [Description("Itupiranga - PA")]
        Itupiranga = 1503705,

        [EnumValue("1503754")]
        [Description("Jacareacanga - PA")]
        Jacareacanga = 1503754,

        [EnumValue("1503804")]
        [Description("Jacunda - PA")]
        Jacunda = 1503804,

        [EnumValue("1503903")]
        [Description("Juruti - PA")]
        Juruti = 1503903,

        [EnumValue("1504000")]
        [Description("Limoeiro do Ajuru - PA")]
        LimoeirodoAjuru = 1504000,

        [EnumValue("1504059")]
        [Description("Mae do Rio - PA")]
        MaedoRio = 1504059,

        [EnumValue("1504109")]
        [Description("Magalhaes Barata - PA")]
        MagalhaesBarata = 1504109,

        [EnumValue("1504208")]
        [Description("Maraba - PA")]
        Maraba = 1504208,

        [EnumValue("1504422")]
        [Description("Marituba - PA")]
        Marituba = 1504422,

        [EnumValue("1504455")]
        [Description("Medicilandia - PA")]
        Medicilandia = 1504455,

        [EnumValue("1504505")]
        [Description("Melgaco - PA")]
        Melgaco = 1504505,

        [EnumValue("1504604")]
        [Description("Mocajuba - PA")]
        Mocajuba = 1504604,

        [EnumValue("1504703")]
        [Description("Moju - PA")]
        Moju = 1504703,

        [EnumValue("1504752")]
        [Description("Mojui dos Campos - PA")]
        MojuidosCampos = 1504752,

        [EnumValue("1504802")]
        [Description("Monte Alegre - PA")]
        MonteAlegre = 1504802,

        [EnumValue("1504901")]
        [Description("Muana - PA")]
        Muana = 1504901,

        [EnumValue("1504950")]
        [Description("Nova Esperanca do Piria - PA")]
        NovaEsperancadoPiria = 1504950,

        [EnumValue("1504976")]
        [Description("Nova Ipixuna - PA")]
        NovaIpixuna = 1504976,

        [EnumValue("1505007")]
        [Description("Nova Timboteua - PA")]
        NovaTimboteua = 1505007,

        [EnumValue("1505031")]
        [Description("Novo Progresso - PA")]
        NovoProgresso = 1505031,

        [EnumValue("1505064")]
        [Description("Novo Repartimento - PA")]
        NovoRepartimento = 1505064,

        [EnumValue("1505106")]
        [Description("Obidos - PA")]
        Obidos = 1505106,

        [EnumValue("1505205")]
        [Description("Oeiras do Para - PA")]
        OeirasdoPara = 1505205,

        [EnumValue("1505304")]
        [Description("Oriximina - PA")]
        Oriximina = 1505304,

        [EnumValue("1505437")]
        [Description("Ourilandia do Norte - PA")]
        OurilandiadoNorte = 1505437,

        [EnumValue("1505486")]
        [Description("Pacaja - PA")]
        Pacaja = 1505486,

        [EnumValue("1505494")]
        [Description("Palestina do Para - PA")]
        PalestinadoPara = 1505494,

        [EnumValue("1505502")]
        [Description("Paragominas - PA")]
        Paragominas = 1505502,

        [EnumValue("1505536")]
        [Description("Parauapebas - PA")]
        Parauapebas = 1505536,

        [EnumValue("1505551")]
        [Description("Pau DArco - PA")]
        PauDArco = 1505551,

        [EnumValue("1505601")]
        [Description("Peixe-Boi - PA")]
        PeixeBoi = 1505601,

        [EnumValue("1505635")]
        [Description("Picarra - PA")]
        Picarra = 1505635,

        [EnumValue("1505650")]
        [Description("Placas - PA")]
        Placas = 1505650,

        [EnumValue("1505700")]
        [Description("Ponta de Pedras - PA")]
        PontadePedras = 1505700,

        [EnumValue("1505809")]
        [Description("Portel - PA")]
        Portel = 1505809,

        [EnumValue("1505908")]
        [Description("Porto de Moz - PA")]
        PortodeMoz = 1505908,

        [EnumValue("1506005")]
        [Description("Prainha - PA")]
        Prainha = 1506005,

        [EnumValue("1506104")]
        [Description("Primavera - PA")]
        Primavera = 1506104,

        [EnumValue("1506138")]
        [Description("Redencao - PA")]
        Redencao_PA = 1506138,

        [EnumValue("1506161")]
        [Description("Rio Maria - PA")]
        RioMaria = 1506161,

        [EnumValue("1506187")]
        [Description("Rondon do Para - PA")]
        RondondoPara = 1506187,

        [EnumValue("1506195")]
        [Description("Ruropolis - PA")]
        Ruropolis = 1506195,

        [EnumValue("1506203")]
        [Description("Salinopolis - PA")]
        Salinopolis = 1506203,

        [EnumValue("1506302")]
        [Description("Salvaterra - PA")]
        Salvaterra = 1506302,

        [EnumValue("1506401")]
        [Description("Santa Cruz do Arari - PA")]
        SantaCruzdoArari = 1506401,

        [EnumValue("1506500")]
        [Description("Santa Izabel do Para - PA")]
        SantaIzabeldoPara = 1506500,

        [EnumValue("1506559")]
        [Description("Santa Luzia do Para - PA")]
        SantaLuziadoPara = 1506559,

        [EnumValue("1506583")]
        [Description("Santa Maria das Barreiras - PA")]
        SantaMariadasBarreiras = 1506583,

        [EnumValue("1506609")]
        [Description("Santa Maria do Para - PA")]
        SantaMariadoPara = 1506609,

        [EnumValue("1506708")]
        [Description("Santana do Araguaia - PA")]
        SantanadoAraguaia = 1506708,

        [EnumValue("1506807")]
        [Description("Santarem - PA")]
        Santarem = 1506807,

        [EnumValue("1506906")]
        [Description("Santarem Novo - PA")]
        SantaremNovo = 1506906,

        [EnumValue("1507003")]
        [Description("Santo Antonio do Taua - PA")]
        SantoAntoniodoTaua = 1507003,

        [EnumValue("1507102")]
        [Description("Sao Caetano de Odivelas - PA")]
        SaoCaetanodeOdivelas = 1507102,

        [EnumValue("1507151")]
        [Description("Sao Domingos do Araguaia - PA")]
        SaoDomingosdoAraguaia = 1507151,

        [EnumValue("1507201")]
        [Description("Sao Domingos do Capim - PA")]
        SaoDomingosdoCapim = 1507201,

        [EnumValue("1507300")]
        [Description("Sao Felix do Xingu - PA")]
        SaoFelixdoXingu = 1507300,

        [EnumValue("1507409")]
        [Description("Sao Francisco do Para - PA")]
        SaoFranciscodoPara = 1507409,

        [EnumValue("1507458")]
        [Description("Sao Geraldo do Araguaia - PA")]
        SaoGeraldodoAraguaia = 1507458,

        [EnumValue("1507466")]
        [Description("Sao Joao da Ponta - PA")]
        SaoJoaodaPonta = 1507466,

        [EnumValue("1507474")]
        [Description("Sao Joao de Pirabas - PA")]
        SaoJoaodePirabas = 1507474,

        [EnumValue("1507607")]
        [Description("Sao Miguel do Guama - PA")]
        SaoMigueldoGuama = 1507607,

        [EnumValue("1507706")]
        [Description("Sao Sebastiao da Boa Vista - PA")]
        SaoSebastiaodaBoaVista = 1507706,

        [EnumValue("1507755")]
        [Description("Sapucaia - PA")]
        Sapucaia = 1507755,

        [EnumValue("1507805")]
        [Description("Senador Jose Porfirio - PA")]
        SenadorJosePorfirio = 1507805,

        [EnumValue("1507904")]
        [Description("Soure - PA")]
        Soure = 1507904,

        [EnumValue("1507953")]
        [Description("Tailandia - PA")]
        Tailandia = 1507953,

        [EnumValue("1507961")]
        [Description("Terra Alta - PA")]
        TerraAlta = 1507961,

        [EnumValue("1507979")]
        [Description("Terra Santa - PA")]
        TerraSanta = 1507979,

        [EnumValue("1508001")]
        [Description("Tome-Acu - PA")]
        TomeAcu = 1508001,

        [EnumValue("1508035")]
        [Description("Tracuateua - PA")]
        Tracuateua = 1508035,

        [EnumValue("1508050")]
        [Description("Trairao - PA")]
        Trairao = 1508050,

        [EnumValue("1508084")]
        [Description("Tucuma - PA")]
        Tucuma = 1508084,

        [EnumValue("1508100")]
        [Description("Tucurui - PA")]
        Tucurui = 1508100,

        [EnumValue("1508126")]
        [Description("Ulianopolis - PA")]
        Ulianopolis = 1508126,

        [EnumValue("1508159")]
        [Description("Uruara - PA")]
        Uruara = 1508159,

        [EnumValue("1508209")]
        [Description("Vigia - PA")]
        Vigia = 1508209,

        [EnumValue("1508308")]
        [Description("Viseu - PA")]
        Viseu = 1508308,

        [EnumValue("1508357")]
        [Description("Vitoria do Xingu - PA")]
        VitoriadoXingu = 1508357,

        [EnumValue("1508407")]
        [Description("Xinguara - PA")]
        Xinguara = 1508407,

        //======Paraíba======
        [EnumValue("2500106")]
        [Description("Agua Branca - PB")]
        AguaBranca_PB = 2500106,

        [EnumValue("2500205")]
        [Description("Aguiar - PB")]
        Aguiar = 2500205,

        [EnumValue("2500304")]
        [Description("Alagoa Grande - PB")]
        AlagoaGrande = 2500304,

        [EnumValue("2500403")]
        [Description("Alagoa Nova - PB")]
        AlagoaNova = 2500403,

        [EnumValue("2500536")]
        [Description("Alcantil - PB")]
        Alcantil = 2500536,

        [EnumValue("2500577")]
        [Description("Algodao de Jandaira - PB")]
        AlgodaodeJandaira = 2500577,

        [EnumValue("2500601")]
        [Description("Alhandra - PB")]
        Alhandra = 2500601,

        [EnumValue("2500775")]
        [Description("Aparecida - PB")]
        Aparecida = 2500775,

        [EnumValue("2500809")]
        [Description("Aracagi - PB")]
        Aracagi = 2500809,

        [EnumValue("2501005")]
        [Description("Araruna - PB")]
        Araruna = 2501005,

        [EnumValue("2501153")]
        [Description("Areia de Baraunas - PB")]
        AreiadeBaraunas = 2501153,

        [EnumValue("2501203")]
        [Description("Areial - PB")]
        Areial = 2501203,

        [EnumValue("2501302")]
        [Description("Aroeiras - PB")]
        Aroeiras = 2501302,

        [EnumValue("2501534")]
        [Description("Barauna - PB")]
        Barauna = 2501534,

        [EnumValue("2501609")]
        [Description("Barra de Santa Rosa - PB")]
        BarradeSantaRosa = 2501609,

        [EnumValue("2501807")]
        [Description("Bayeux - PB")]
        Bayeux = 2501807,

        [EnumValue("2501906")]
        [Description("Belem - PB")]
        Belem_PB = 2501906,

        [EnumValue("2502003")]
        [Description("Belem do Brejo do Cruz - PB")]
        BelemdoBrejodoCruz = 2502003,

        [EnumValue("2502052")]
        [Description("Bernardino Batista - PB")]
        BernardinoBatista = 2502052,

        [EnumValue("2502102")]
        [Description("Boa Ventura - PB")]
        BoaVentura = 2502102,

        [EnumValue("2502201")]
        [Description("Bom Jesus - PB")]
        BomJesus = 2502201,

        [EnumValue("2502300")]
        [Description("Bom Sucesso - PB")]
        BomSucesso_PB = 2502300,

        [EnumValue("2502409")]
        [Description("Bonito de Santa Fe - PB")]
        BonitodeSantaFe = 2502409,

        [EnumValue("2502607")]
        [Description("Igaracy - PB")]
        Igaracy = 2502607,

        [EnumValue("2502706")]
        [Description("Borborema - PB")]
        Borborema = 2502706,

        [EnumValue("2502805")]
        [Description("Brejo do Cruz - PB")]
        BrejodoCruz = 2502805,

        [EnumValue("2502904")]
        [Description("Brejo dos Santos - PB")]
        BrejodosSantos = 2502904,

        [EnumValue("2503001")]
        [Description("Caapora - PB")]
        Caapora = 2503001,

        [EnumValue("2503209")]
        [Description("Cabedelo - PB")]
        Cabedelo = 2503209,

        [EnumValue("2503308")]
        [Description("Cachoeira dos Indios - PB")]
        CachoeiradosIndios = 2503308,

        [EnumValue("2503407")]
        [Description("Cacimba de Areia - PB")]
        CacimbadeAreia = 2503407,

        [EnumValue("2503506")]
        [Description("Cacimba de Dentro - PB")]
        CacimbadeDentro = 2503506,

        [EnumValue("2503704")]
        [Description("Cajazeiras - PB")]
        Cajazeiras = 2503704,

        [EnumValue("2503753")]
        [Description("Cajazeirinhas - PB")]
        Cajazeirinhas = 2503753,

        [EnumValue("2503803")]
        [Description("Caldas Brandao - PB")]
        CaldasBrandao = 2503803,

        [EnumValue("2503902")]
        [Description("Camalau - PB")]
        Camalau = 2503902,

        [EnumValue("2504009")]
        [Description("Campina Grande - PB")]
        CampinaGrande = 2504009,

        [EnumValue("2504074")]
        [Description("Caraubas - PB")]
        Caraubas = 2504074,

        [EnumValue("2504108")]
        [Description("Carrapateira - PB")]
        Carrapateira = 2504108,

        [EnumValue("2504207")]
        [Description("Catingueira - PB")]
        Catingueira = 2504207,

        [EnumValue("2504306")]
        [Description("Catole do Rocha - PB")]
        CatoledoRocha = 2504306,

        [EnumValue("2504355")]
        [Description("Caturite - PB")]
        Caturite = 2504355,

        [EnumValue("2504405")]
        [Description("Conceicao - PB")]
        Conceicao = 2504405,

        [EnumValue("2504603")]
        [Description("Conde - PB")]
        Conde_PB = 2504603,

        [EnumValue("2504702")]
        [Description("Congo - PB")]
        Congo = 2504702,

        [EnumValue("2504900")]
        [Description("Cruz do Espirito Santo - PB")]
        CruzdoEspiritoSanto = 2504900,

        [EnumValue("2505006")]
        [Description("Cubati - PB")]
        Cubati = 2505006,

        [EnumValue("2505204")]
        [Description("Cuitegi - PB")]
        Cuitegi = 2505204,

        [EnumValue("2505238")]
        [Description("Cuite de Mamanguape - PB")]
        CuitedeMamanguape = 2505238,

        [EnumValue("2505303")]
        [Description("Curral Velho - PB")]
        CurralVelho = 2505303,

        [EnumValue("2505352")]
        [Description("Damiao - PB")]
        Damiao = 2505352,

        [EnumValue("2505402")]
        [Description("Desterro - PB")]
        Desterro = 2505402,

        [EnumValue("2505907")]
        [Description("Emas - PB")]
        Emas = 2505907,

        [EnumValue("2506004")]
        [Description("Esperanca - PB")]
        Esperanca = 2506004,

        [EnumValue("2506202")]
        [Description("Frei Martinho - PB")]
        FreiMartinho = 2506202,

        [EnumValue("2506251")]
        [Description("Gado Bravo - PB")]
        GadoBravo = 2506251,

        [EnumValue("2506301")]
        [Description("Guarabira - PB")]
        Guarabira = 2506301,

        [EnumValue("2506400")]
        [Description("Gurinhem - PB")]
        Gurinhem = 2506400,

        [EnumValue("2506509")]
        [Description("Gurjao - PB")]
        Gurjao = 2506509,

        [EnumValue("2506905")]
        [Description("Itabaiana - PB")]
        Itabaiana = 2506905,

        [EnumValue("2507002")]
        [Description("Itaporanga - PB")]
        Itaporanga = 2507002,

        [EnumValue("2507101")]
        [Description("Itapororoca - PB")]
        Itapororoca = 2507101,

        [EnumValue("2507200")]
        [Description("Itatuba - PB")]
        Itatuba = 2507200,

        [EnumValue("2507408")]
        [Description("Jerico - PB")]
        Jerico = 2507408,

        [EnumValue("2507507")]
        [Description("Joao Pessoa - PB")]
        JoaoPessoa = 2507507,

        [EnumValue("2507903")]
        [Description("Juripiranga - PB")]
        Juripiranga = 2507903,

        [EnumValue("2508000")]
        [Description("Juru - PB")]
        Juru = 2508000,

        [EnumValue("2508109")]
        [Description("Lagoa - PB")]
        Lagoa = 2508109,

        [EnumValue("2508208")]
        [Description("Lagoa de Dentro - PB")]
        LagoadeDentro = 2508208,

        [EnumValue("2508505")]
        [Description("Livramento - PB")]
        Livramento = 2508505,

        [EnumValue("2508554")]
        [Description("Logradouro - PB")]
        Logradouro = 2508554,

        [EnumValue("2508604")]
        [Description("Lucena - PB")]
        Lucena = 2508604,

        [EnumValue("2508703")]
        [Description("Mae dAgua - PB")]
        MaedAgua = 2508703,

        [EnumValue("2508802")]
        [Description("Malta - PB")]
        Malta = 2508802,

        [EnumValue("2508901")]
        [Description("Mamanguape - PB")]
        Mamanguape = 2508901,

        [EnumValue("2509008")]
        [Description("Manaira - PB")]
        Manaira = 2509008,

        [EnumValue("2509107")]
        [Description("Mari - PB")]
        Mari = 2509107,

        [EnumValue("2509206")]
        [Description("Massaranduba - PB")]
        Massaranduba = 2509206,

        [EnumValue("2509305")]
        [Description("Mataraca - PB")]
        Mataraca = 2509305,

        [EnumValue("2509404")]
        [Description("Mogeiro - PB")]
        Mogeiro = 2509404,

        [EnumValue("2509503")]
        [Description("Montadas - PB")]
        Montadas = 2509503,

        [EnumValue("2509701")]
        [Description("Monteiro - PB")]
        Monteiro = 2509701,

        [EnumValue("2510006")]
        [Description("Nazarezinho - PB")]
        Nazarezinho = 2510006,

        [EnumValue("2510105")]
        [Description("Nova Floresta - PB")]
        NovaFloresta = 2510105,

        [EnumValue("2510204")]
        [Description("Nova Olinda - PB")]
        NovaOlinda_PB = 2510204,

        [EnumValue("2510402")]
        [Description("Olho dAgua - PB")]
        OlhodAgua = 2510402,

        [EnumValue("2510501")]
        [Description("Olivedos - PB")]
        Olivedos = 2510501,

        [EnumValue("2510600")]
        [Description("Ouro Velho - PB")]
        OuroVelho = 2510600,

        [EnumValue("2510659")]
        [Description("Parari - PB")]
        Parari = 2510659,

        [EnumValue("2510808")]
        [Description("Patos - PB")]
        Patos = 2510808,

        [EnumValue("2510907")]
        [Description("Paulista - PB")]
        Paulista = 2510907,

        [EnumValue("2511004")]
        [Description("Pedra Branca - PB")]
        PedraBranca_PB = 2511004,

        [EnumValue("2511103")]
        [Description("Pedra Lavrada - PB")]
        PedraLavrada = 2511103,

        [EnumValue("2511202")]
        [Description("Pedras de Fogo - PB")]
        PedrasdeFogo = 2511202,

        [EnumValue("2511301")]
        [Description("Pianco - PB")]
        Pianco = 2511301,

        [EnumValue("2511400")]
        [Description("Picui - PB")]
        Picui = 2511400,

        [EnumValue("2511608")]
        [Description("Piloes - PB")]
        Piloes = 2511608,

        [EnumValue("2511707")]
        [Description("Piloezinhos - PB")]
        Piloezinhos = 2511707,

        [EnumValue("2511806")]
        [Description("Pirpirituba - PB")]
        Pirpirituba = 2511806,

        [EnumValue("2512002")]
        [Description("Pocinhos - PB")]
        Pocinhos = 2512002,

        [EnumValue("2512036")]
        [Description("Poco Dantas - PB")]
        PocoDantas = 2512036,

        [EnumValue("2512101")]
        [Description("Pombal - PB")]
        Pombal = 2512101,

        [EnumValue("2512200")]
        [Description("Prata - PB")]
        Prata_PB = 2512200,

        [EnumValue("2512309")]
        [Description("Princesa Isabel - PB")]
        PrincesaIsabel = 2512309,

        [EnumValue("2512408")]
        [Description("Puxinana - PB")]
        Puxinana = 2512408,

        [EnumValue("2512606")]
        [Description("Quixaba - PB")]
        Quixaba = 2512606,

        [EnumValue("2512705")]
        [Description("Remigio - PB")]
        Remigio = 2512705,

        [EnumValue("2512721")]
        [Description("Pedro Regis - PB")]
        PedroRegis = 2512721,

        [EnumValue("2512747")]
        [Description("Riachao - PB")]
        Riachao_PB = 2512747,

        [EnumValue("2512762")]
        [Description("Riachao do Poco - PB")]
        RiachaodoPoco = 2512762,

        [EnumValue("2512788")]
        [Description("Riacho de Santo Antonio - PB")]
        RiachodeSantoAntonio = 2512788,

        [EnumValue("2512804")]
        [Description("Riacho dos Cavalos - PB")]
        RiachodosCavalos = 2512804,

        [EnumValue("2512903")]
        [Description("Rio Tinto - PB")]
        RioTinto = 2512903,

        [EnumValue("2513158")]
        [Description("Santa Cecilia - PB")]
        SantaCecilia = 2513158,

        [EnumValue("2513208")]
        [Description("Santa Cruz - PB")]
        SantaCruz = 2513208,

        [EnumValue("2513307")]
        [Description("Santa Helena - PB")]
        SantaHelena_PB = 2513307,

        [EnumValue("2513356")]
        [Description("Santa Ines - PB")]
        SantaInes_PB = 2513356,

        [EnumValue("2513406")]
        [Description("Santa Luzia - PB")]
        SantaLuzia_PB = 2513406,

        [EnumValue("2513505")]
        [Description("Santana de Mangueira - PB")]
        SantanadeMangueira = 2513505,

        [EnumValue("2513653")]
        [Description("Joca Claudino - PB")]
        JocaClaudino = 2513653,

        [EnumValue("2513968")]
        [Description("Sao Domingos - PB")]
        SaoDomingos_PB = 2513968,

        [EnumValue("2513984")]
        [Description("Sao Francisco - PB")]
        SaoFrancisco_PB = 2513984,

        [EnumValue("2514008")]
        [Description("Sao Joao do Cariri - PB")]
        SaoJoaodoCariri = 2514008,

        [EnumValue("2514107")]
        [Description("Sao Joao do Tigre - PB")]
        SaoJoaodoTigre = 2514107,

        [EnumValue("2514206")]
        [Description("Sao Jose da Lagoa Tapada - PB")]
        SaoJosedaLagoaTapada = 2514206,

        [EnumValue("2514453")]
        [Description("Sao Jose dos Ramos - PB")]
        SaoJosedosRamos = 2514453,

        [EnumValue("2514503")]
        [Description("Sao Jose de Piranhas - PB")]
        SaoJosedePiranhas = 2514503,

        [EnumValue("2514602")]
        [Description("Sao Jose do Bonfim - PB")]
        SaoJosedoBonfim = 2514602,

        [EnumValue("2514651")]
        [Description("Sao Jose do Brejo do Cruz - PB")]
        SaoJosedoBrejodoCruz = 2514651,

        [EnumValue("2514800")]
        [Description("Sao Jose dos Cordeiros - PB")]
        SaoJosedosCordeiros = 2514800,

        [EnumValue("2515005")]
        [Description("Sao Miguel de Taipu - PB")]
        SaoMigueldeTaipu = 2515005,

        [EnumValue("2515104")]
        [Description("Sao Sebastiao de Lagoa de Roca - PB")]
        SaoSebastiaodeLagoadeRoca = 2515104,

        [EnumValue("2515203")]
        [Description("Sao Sebastiao do Umbuzeiro - PB")]
        SaoSebastiaodoUmbuzeiro = 2515203,

        [EnumValue("2515302")]
        [Description("Sape - PB")]
        Sape = 2515302,

        [EnumValue("2515401")]
        [Description("Sao Vicente do Serido - PB")]
        SaoVicentedoSerido = 2515401,

        [EnumValue("2515500")]
        [Description("Serra Branca - PB")]
        SerraBranca = 2515500,

        [EnumValue("2515609")]
        [Description("Serra da Raiz - PB")]
        SerradaRaiz = 2515609,

        [EnumValue("2515807")]
        [Description("Serra Redonda - PB")]
        SerraRedonda = 2515807,

        [EnumValue("2515906")]
        [Description("Serraria - PB")]
        Serraria = 2515906,

        [EnumValue("2515930")]
        [Description("Sertaozinho - PB")]
        Sertaozinho = 2515930,

        [EnumValue("2515971")]
        [Description("Sobrado - PB")]
        Sobrado = 2515971,

        [EnumValue("2516003")]
        [Description("Solanea - PB")]
        Solanea = 2516003,

        [EnumValue("2516102")]
        [Description("Soledade - PB")]
        Soledade = 2516102,

        [EnumValue("2516151")]
        [Description("Sossego - PB")]
        Sossego = 2516151,

        [EnumValue("2516201")]
        [Description("Sousa - PB")]
        Sousa = 2516201,

        [EnumValue("2516508")]
        [Description("Taperoa - PB")]
        Taperoa_PB = 2516508,

        [EnumValue("2516607")]
        [Description("Tavares - PB")]
        Tavares = 2516607,

        [EnumValue("2516706")]
        [Description("Teixeira - PB")]
        Teixeira = 2516706,

        [EnumValue("2516755")]
        [Description("Tenorio - PB")]
        Tenorio = 2516755,

        [EnumValue("2516805")]
        [Description("Triunfo - PB")]
        Triunfo = 2516805,

        [EnumValue("2516904")]
        [Description("Uirauna - PB")]
        Uirauna = 2516904,

        [EnumValue("2517001")]
        [Description("Umbuzeiro - PB")]
        Umbuzeiro = 2517001,

        [EnumValue("2517209")]
        [Description("Vieiropolis - PB")]
        Vieiropolis = 2517209,

        //======Pernambuco======
        [EnumValue("2600054")]
        [Description("Abreu e Lima - PE")]
        AbreueLima = 2600054,

        [EnumValue("2600104")]
        [Description("Afogados da Ingazeira - PE")]
        AfogadosdaIngazeira = 2600104,

        [EnumValue("2600203")]
        [Description("Afranio - PE")]
        Afranio = 2600203,

        [EnumValue("2600302")]
        [Description("Agrestina - PE")]
        Agrestina = 2600302,

        [EnumValue("2600401")]
        [Description("Agua Preta - PE")]
        AguaPreta = 2600401,

        [EnumValue("2600500")]
        [Description("Aguas Belas - PE")]
        AguasBelas = 2600500,

        [EnumValue("2600807")]
        [Description("Altinho - PE")]
        Altinho = 2600807,

        [EnumValue("2600906")]
        [Description("Amaraji - PE")]
        Amaraji = 2600906,

        [EnumValue("2601003")]
        [Description("Angelim - PE")]
        Angelim = 2601003,

        [EnumValue("2601052")]
        [Description("Aracoiaba - PE")]
        Aracoiaba_PE = 2601052,

        [EnumValue("2601201")]
        [Description("Arcoverde - PE")]
        Arcoverde = 2601201,

        [EnumValue("2601300")]
        [Description("Barra de Guabiraba - PE")]
        BarradeGuabiraba = 2601300,

        [EnumValue("2601508")]
        [Description("Belem de Maria - PE")]
        BelemdeMaria = 2601508,

        [EnumValue("2601706")]
        [Description("Belo Jardim - PE")]
        BeloJardim = 2601706,

        [EnumValue("2601805")]
        [Description("Betania - PE")]
        Betania = 2601805,

        [EnumValue("2601904")]
        [Description("Bezerros - PE")]
        Bezerros = 2601904,

        [EnumValue("2602100")]
        [Description("Bom Conselho - PE")]
        BomConselho = 2602100,

        [EnumValue("2602209")]
        [Description("Bom Jardim - PE")]
        BomJardim_PE = 2602209,

        [EnumValue("2602308")]
        [Description("Bonito - PE")]
        Bonito_PE = 2602308,

        [EnumValue("2602407")]
        [Description("Brejao - PE")]
        Brejao = 2602407,

        [EnumValue("2602605")]
        [Description("Brejo da Madre de Deus - PE")]
        BrejodaMadredeDeus = 2602605,

        [EnumValue("2602803")]
        [Description("Buique - PE")]
        Buique = 2602803,

        [EnumValue("2602902")]
        [Description("Cabo de Santo Agostinho - PE")]
        CabodeSantoAgostinho = 2602902,

        [EnumValue("2603207")]
        [Description("Caetes - PE")]
        Caetes = 2603207,

        [EnumValue("2603306")]
        [Description("Calcado - PE")]
        Calcado = 2603306,

        [EnumValue("2603454")]
        [Description("Camaragibe - PE")]
        Camaragibe = 2603454,

        [EnumValue("2603504")]
        [Description("Camocim de Sao Felix - PE")]
        CamocimdeSaoFelix = 2603504,

        [EnumValue("2603603")]
        [Description("Camutanga - PE")]
        Camutanga = 2603603,

        [EnumValue("2603702")]
        [Description("Canhotinho - PE")]
        Canhotinho = 2603702,

        [EnumValue("2603801")]
        [Description("Capoeiras - PE")]
        Capoeiras = 2603801,

        [EnumValue("2603900")]
        [Description("Carnaiba - PE")]
        Carnaiba = 2603900,

        [EnumValue("2603926")]
        [Description("Carnaubeira da Penha - PE")]
        CarnaubeiradaPenha = 2603926,

        [EnumValue("2604007")]
        [Description("Carpina - PE")]
        Carpina = 2604007,

        [EnumValue("2604106")]
        [Description("Caruaru - PE")]
        Caruaru = 2604106,

        [EnumValue("2604155")]
        [Description("Casinhas - PE")]
        Casinhas = 2604155,

        [EnumValue("2604205")]
        [Description("Catende - PE")]
        Catende = 2604205,

        [EnumValue("2604502")]
        [Description("Cha Grande - PE")]
        ChaGrande = 2604502,

        [EnumValue("2604601")]
        [Description("Condado - PE")]
        Condado_PE = 2604601,

        [EnumValue("2604700")]
        [Description("Correntes - PE")]
        Correntes = 2604700,

        [EnumValue("2605004")]
        [Description("Cupira - PE")]
        Cupira = 2605004,

        [EnumValue("2605202")]
        [Description("Escada - PE")]
        Escada = 2605202,

        [EnumValue("2605301")]
        [Description("Exu - PE")]
        Exu = 2605301,

        [EnumValue("2605400")]
        [Description("Feira Nova - PE")]
        FeiraNova = 2605400,

        [EnumValue("2605509")]
        [Description("Ferreiros - PE")]
        Ferreiros = 2605509,

        [EnumValue("2605608")]
        [Description("Flores - PE")]
        Flores = 2605608,

        [EnumValue("2605707")]
        [Description("Floresta - PE")]
        Floresta = 2605707,

        [EnumValue("2606002")]
        [Description("Garanhuns - PE")]
        Garanhuns = 2606002,

        [EnumValue("2606101")]
        [Description("Gloria do Goita - PE")]
        GloriadoGoita = 2606101,

        [EnumValue("2606200")]
        [Description("Goiana - PE")]
        Goiana_PE = 2606200,

        [EnumValue("2606309")]
        [Description("Granito - PE")]
        Granito = 2606309,

        [EnumValue("2606408")]
        [Description("Gravata - PE")]
        Gravata = 2606408,

        [EnumValue("2606507")]
        [Description("Iati - PE")]
        Iati = 2606507,

        [EnumValue("2606705")]
        [Description("Ibirajuba - PE")]
        Ibirajuba = 2606705,

        [EnumValue("2606804")]
        [Description("Igarassu - PE")]
        Igarassu = 2606804,

        [EnumValue("2606903")]
        [Description("Iguaracy - PE")]
        Iguaracy = 2606903,

        [EnumValue("2607000")]
        [Description("Inaja - PE")]
        Inaja = 2607000,

        [EnumValue("2607109")]
        [Description("Ingazeira - PE")]
        Ingazeira = 2607109,

        [EnumValue("2607208")]
        [Description("Ipojuca - PE")]
        Ipojuca = 2607208,

        [EnumValue("2607307")]
        [Description("Ipubi - PE")]
        Ipubi = 2607307,

        [EnumValue("2607406")]
        [Description("Itacuruba - PE")]
        Itacuruba = 2607406,

        [EnumValue("2607505")]
        [Description("Itaiba - PE")]
        Itaiba = 2607505,

        [EnumValue("2607653")]
        [Description("Itambe - PE")]
        Itambe_PE = 2607653,

        [EnumValue("2607802")]
        [Description("Itaquitinga - PE")]
        Itaquitinga = 2607802,

        [EnumValue("2607901")]
        [Description("Jaboatao dos Guararapes - PE")]
        JaboataodosGuararapes = 2607901,

        [EnumValue("2607950")]
        [Description("Jaqueira - PE")]
        Jaqueira = 2607950,

        [EnumValue("2608008")]
        [Description("Jatauba - PE")]
        Jatauba = 2608008,

        [EnumValue("2608107")]
        [Description("Joao Alfredo - PE")]
        JoaoAlfredo = 2608107,

        [EnumValue("2608206")]
        [Description("Joaquim Nabuco - PE")]
        JoaquimNabuco = 2608206,

        [EnumValue("2608255")]
        [Description("Jucati - PE")]
        Jucati = 2608255,

        [EnumValue("2608305")]
        [Description("Jupi - PE")]
        Jupi = 2608305,

        [EnumValue("2608453")]
        [Description("Lagoa do Carro - PE")]
        LagoadoCarro = 2608453,

        [EnumValue("2608503")]
        [Description("Lagoa de Itaenga - PE")]
        LagoadeItaenga = 2608503,

        [EnumValue("2608701")]
        [Description("Lagoa dos Gatos - PE")]
        LagoadosGatos = 2608701,

        [EnumValue("2608750")]
        [Description("Lagoa Grande - PE")]
        LagoaGrande_PE = 2608750,

        [EnumValue("2608800")]
        [Description("Lajedo - PE")]
        Lajedo = 2608800,

        [EnumValue("2609105")]
        [Description("Machados - PE")]
        Machados = 2609105,

        [EnumValue("2609402")]
        [Description("Moreno - PE")]
        Moreno = 2609402,

        [EnumValue("2609600")]
        [Description("Olinda - PE")]
        Olinda = 2609600,

        [EnumValue("2609709")]
        [Description("Orobo - PE")]
        Orobo = 2609709,

        [EnumValue("2609808")]
        [Description("Oroco - PE")]
        Oroco = 2609808,

        [EnumValue("2609907")]
        [Description("Ouricuri - PE")]
        Ouricuri = 2609907,

        [EnumValue("2610004")]
        [Description("Palmares - PE")]
        Palmares = 2610004,

        [EnumValue("2610202")]
        [Description("Panelas - PE")]
        Panelas = 2610202,

        [EnumValue("2610301")]
        [Description("Paranatama - PE")]
        Paranatama = 2610301,

        [EnumValue("2610509")]
        [Description("Passira - PE")]
        Passira = 2610509,

        [EnumValue("2610608")]
        [Description("Paudalho - PE")]
        Paudalho = 2610608,

        [EnumValue("2610707")]
        [Description("Paulista - PE")]
        Paulista_PE = 2610707,

        [EnumValue("2610905")]
        [Description("Pesqueira - PE")]
        Pesqueira = 2610905,

        [EnumValue("2611002")]
        [Description("Petrolandia - PE")]
        Petrolandia = 2611002,

        [EnumValue("2611101")]
        [Description("Petrolina - PE")]
        Petrolina = 2611101,

        [EnumValue("2611200")]
        [Description("Pocao - PE")]
        Pocao = 2611200,

        [EnumValue("2611309")]
        [Description("Pombos - PE")]
        Pombos = 2611309,

        [EnumValue("2611408")]
        [Description("Primavera - PE")]
        Primavera_PE = 2611408,

        [EnumValue("2611533")]
        [Description("Quixaba - PE")]
        Quixaba_PE = 2611533,

        [EnumValue("2611606")]
        [Description("Recife - PE")]
        Recife = 2611606,

        [EnumValue("2611705")]
        [Description("Riacho das Almas - PE")]
        RiachodasAlmas = 2611705,

        [EnumValue("2611804")]
        [Description("Ribeirao - PE")]
        Ribeirao = 2611804,

        [EnumValue("2611903")]
        [Description("Rio Formoso - PE")]
        RioFormoso = 2611903,

        [EnumValue("2612000")]
        [Description("Saire - PE")]
        Saire = 2612000,

        [EnumValue("2612109")]
        [Description("Salgadinho - PE")]
        Salgadinho_PE = 2612109,

        [EnumValue("2612307")]
        [Description("Saloa - PE")]
        Saloa = 2612307,

        [EnumValue("2612455")]
        [Description("Santa Cruz - PE")]
        SantaCruz_PE = 2612455,

        [EnumValue("2612505")]
        [Description("Santa Cruz do Capibaribe - PE")]
        SantaCruzdoCapibaribe = 2612505,

        [EnumValue("2612554")]
        [Description("Santa Filomena - PE")]
        SantaFilomena = 2612554,

        [EnumValue("2612703")]
        [Description("Santa Maria do Cambuca - PE")]
        SantaMariadoCambuca = 2612703,

        [EnumValue("2612802")]
        [Description("Santa Terezinha - PE")]
        SantaTerezinha_PE = 2612802,

        [EnumValue("2612901")]
        [Description("Sao Benedito do Sul - PE")]
        SaoBeneditodoSul = 2612901,

        [EnumValue("2613107")]
        [Description("Sao Caitano - PE")]
        SaoCaitano = 2613107,

        [EnumValue("2613206")]
        [Description("Sao Joao - PE")]
        SaoJoao = 2613206,

        [EnumValue("2613701")]
        [Description("Sao Lourenco da Mata - PE")]
        SaoLourencodaMata = 2613701,

        [EnumValue("2613909")]
        [Description("Serra Talhada - PE")]
        SerraTalhada = 2613909,

        [EnumValue("2614006")]
        [Description("Serrita - PE")]
        Serrita = 2614006,

        [EnumValue("2614105")]
        [Description("Sertania - PE")]
        Sertania = 2614105,

        [EnumValue("2614204")]
        [Description("Sirinhaem - PE")]
        Sirinhaem = 2614204,

        [EnumValue("2614303")]
        [Description("Moreilandia - PE")]
        Moreilandia = 2614303,

        [EnumValue("2614600")]
        [Description("Tabira - PE")]
        Tabira = 2614600,

        [EnumValue("2614709")]
        [Description("Tacaimbo - PE")]
        Tacaimbo = 2614709,

        [EnumValue("2614857")]
        [Description("Tamandare - PE")]
        Tamandare = 2614857,

        [EnumValue("2615102")]
        [Description("Terezinha - PE")]
        Terezinha = 2615102,

        [EnumValue("2615300")]
        [Description("Timbauba - PE")]
        Timbauba = 2615300,

        [EnumValue("2615409")]
        [Description("Toritama - PE")]
        Toritama = 2615409,

        [EnumValue("2615508")]
        [Description("Tracunhaem - PE")]
        Tracunhaem = 2615508,

        [EnumValue("2615607")]
        [Description("Trindade - PE")]
        Trindade_PE = 2615607,

        [EnumValue("2615904")]
        [Description("Tuparetama - PE")]
        Tuparetama = 2615904,

        [EnumValue("2616001")]
        [Description("Venturosa - PE")]
        Venturosa = 2616001,

        [EnumValue("2616100")]
        [Description("Verdejante - PE")]
        Verdejante = 2616100,

        [EnumValue("2616209")]
        [Description("Vertentes - PE")]
        Vertentes = 2616209,

        [EnumValue("2616308")]
        [Description("Vicencia - PE")]
        Vicencia = 2616308,

        [EnumValue("2616407")]
        [Description("Vitoria de Santo Antao - PE")]
        VitoriadeSantoAntao = 2616407,

        [EnumValue("2616506")]
        [Description("Xexeu - PE")]
        Xexeu = 2616506,

        //======Piauí======
        [EnumValue("2200053")]
        [Description("Acaua - PI")]
        Acaua = 2200053,

        [EnumValue("2200103")]
        [Description("Agricolandia - PI")]
        Agricolandia = 2200103,

        [EnumValue("2200251")]
        [Description("Alagoinha do Piaui - PI")]
        AlagoinhadoPiaui = 2200251,

        [EnumValue("2200277")]
        [Description("Alegrete do Piaui - PI")]
        AlegretedoPiaui = 2200277,

        [EnumValue("2200301")]
        [Description("Alto Longa - PI")]
        AltoLonga = 2200301,

        [EnumValue("2200400")]
        [Description("Altos - PI")]
        Altos = 2200400,

        [EnumValue("2200459")]
        [Description("Alvorada do Gurgueia - PI")]
        AlvoradadoGurgueia = 2200459,

        [EnumValue("2200905")]
        [Description("Aroazes - PI")]
        Aroazes = 2200905,

        [EnumValue("2201101")]
        [Description("Avelino Lopes - PI")]
        AvelinoLopes = 2201101,

        [EnumValue("2201150")]
        [Description("Baixa Grande do Ribeiro - PI")]
        BaixaGrandedoRibeiro = 2201150,

        [EnumValue("2201176")]
        [Description("Barra DAlcantara - PI")]
        BarraDAlcantara = 2201176,

        [EnumValue("2201200")]
        [Description("Barras - PI")]
        Barras = 2201200,

        [EnumValue("2201507")]
        [Description("Batalha - PI")]
        Batalha_PI = 2201507,

        [EnumValue("2201556")]
        [Description("Bela Vista do Piaui - PI")]
        BelaVistadoPiaui = 2201556,

        [EnumValue("2201572")]
        [Description("Belem do Piaui - PI")]
        BelemdoPiaui = 2201572,

        [EnumValue("2201606")]
        [Description("Beneditinos - PI")]
        Beneditinos = 2201606,

        [EnumValue("2201705")]
        [Description("Bertolinia - PI")]
        Bertolinia = 2201705,

        [EnumValue("2201739")]
        [Description("Betania do Piaui - PI")]
        BetaniadoPiaui = 2201739,

        [EnumValue("2201770")]
        [Description("Boa Hora - PI")]
        BoaHora = 2201770,

        [EnumValue("2201903")]
        [Description("Bom Jesus - PI")]
        BomJesus_PI = 2201903,

        [EnumValue("2201919")]
        [Description("Bom Principio do Piaui - PI")]
        BomPrincipiodoPiaui = 2201919,

        [EnumValue("2201929")]
        [Description("Bonfim do Piaui - PI")]
        BonfimdoPiaui = 2201929,

        [EnumValue("2201945")]
        [Description("Boqueirao do Piaui - PI")]
        BoqueiraodoPiaui = 2201945,

        [EnumValue("2201960")]
        [Description("Brasileira - PI")]
        Brasileira = 2201960,

        [EnumValue("2202000")]
        [Description("Buriti dos Lopes - PI")]
        BuritidosLopes = 2202000,

        [EnumValue("2202059")]
        [Description("Cabeceiras do Piaui - PI")]
        CabeceirasdoPiaui = 2202059,

        [EnumValue("2202083")]
        [Description("Cajueiro da Praia - PI")]
        CajueirodaPraia = 2202083,

        [EnumValue("2202091")]
        [Description("Caldeirao Grande do Piaui - PI")]
        CaldeiraoGrandedoPiaui = 2202091,

        [EnumValue("2202117")]
        [Description("Campo Alegre do Fidalgo - PI")]
        CampoAlegredoFidalgo = 2202117,

        [EnumValue("2202133")]
        [Description("Campo Grande do Piaui - PI")]
        CampoGrandedoPiaui = 2202133,

        [EnumValue("2202208")]
        [Description("Campo Maior - PI")]
        CampoMaior = 2202208,

        [EnumValue("2202251")]
        [Description("Canavieira - PI")]
        Canavieira = 2202251,

        [EnumValue("2202307")]
        [Description("Canto do Buriti - PI")]
        CantodoBuriti = 2202307,

        [EnumValue("2202406")]
        [Description("Capitao de Campos - PI")]
        CapitaodeCampos = 2202406,

        [EnumValue("2202455")]
        [Description("Capitao Gervasio Oliveira - PI")]
        CapitaoGervasioOliveira = 2202455,

        [EnumValue("2202505")]
        [Description("Caracol - PI")]
        Caracol_PI = 2202505,

        [EnumValue("2202539")]
        [Description("Caraubas do Piaui - PI")]
        CaraubasdoPiaui = 2202539,

        [EnumValue("2202554")]
        [Description("Caridade do Piaui - PI")]
        CaridadedoPiaui = 2202554,

        [EnumValue("2202653")]
        [Description("Caxingo - PI")]
        Caxingo = 2202653,

        [EnumValue("2202703")]
        [Description("Cocal - PI")]
        Cocal = 2202703,

        [EnumValue("2202711")]
        [Description("Cocal de Telha - PI")]
        CocaldeTelha = 2202711,

        [EnumValue("2202729")]
        [Description("Cocal dos Alves - PI")]
        CocaldosAlves = 2202729,

        [EnumValue("2202737")]
        [Description("Coivaras - PI")]
        Coivaras = 2202737,

        [EnumValue("2202851")]
        [Description("Coronel Jose Dias - PI")]
        CoronelJoseDias = 2202851,

        [EnumValue("2203107")]
        [Description("Cristino Castro - PI")]
        CristinoCastro = 2203107,

        [EnumValue("2203255")]
        [Description("Curralinhos - PI")]
        Curralinhos = 2203255,

        [EnumValue("2203271")]
        [Description("Curral Novo do Piaui - PI")]
        CurralNovodoPiaui = 2203271,

        [EnumValue("2203305")]
        [Description("Demerval Lobao - PI")]
        DemervalLobao = 2203305,

        [EnumValue("2203354")]
        [Description("Dirceu Arcoverde - PI")]
        DirceuArcoverde = 2203354,

        [EnumValue("2203404")]
        [Description("Dom Expedito Lopes - PI")]
        DomExpeditoLopes = 2203404,

        [EnumValue("2203453")]
        [Description("Dom Inocencio - PI")]
        DomInocencio = 2203453,

        [EnumValue("2203503")]
        [Description("Elesbao Veloso - PI")]
        ElesbaoVeloso = 2203503,

        [EnumValue("2203800")]
        [Description("Flores do Piaui - PI")]
        FloresdoPiaui = 2203800,

        [EnumValue("2204006")]
        [Description("Francinopolis - PI")]
        Francinopolis = 2204006,

        [EnumValue("2204105")]
        [Description("Francisco Ayres - PI")]
        FranciscoAyres = 2204105,

        [EnumValue("2204154")]
        [Description("Francisco Macedo - PI")]
        FranciscoMacedo = 2204154,

        [EnumValue("2204204")]
        [Description("Francisco Santos - PI")]
        FranciscoSantos = 2204204,

        [EnumValue("2204303")]
        [Description("Fronteiras - PI")]
        Fronteiras = 2204303,

        [EnumValue("2204402")]
        [Description("Gilbues - PI")]
        Gilbues = 2204402,

        [EnumValue("2204659")]
        [Description("Ilha Grande - PI")]
        IlhaGrande = 2204659,

        [EnumValue("2204808")]
        [Description("Ipiranga do Piaui - PI")]
        IpirangadoPiaui = 2204808,

        [EnumValue("2204907")]
        [Description("Isaias Coelho - PI")]
        IsaiasCoelho = 2204907,

        [EnumValue("2205003")]
        [Description("Itainopolis - PI")]
        Itainopolis = 2205003,

        [EnumValue("2205151")]
        [Description("Jacobina do Piaui - PI")]
        JacobinadoPiaui = 2205151,

        [EnumValue("2205250")]
        [Description("Jardim do Mulato - PI")]
        JardimdoMulato = 2205250,

        [EnumValue("2205276")]
        [Description("Jatoba do Piaui - PI")]
        JatobadoPiaui = 2205276,

        [EnumValue("2205300")]
        [Description("Jerumenha - PI")]
        Jerumenha = 2205300,

        [EnumValue("2205409")]
        [Description("Joaquim Pires - PI")]
        JoaquimPires = 2205409,

        [EnumValue("2205458")]
        [Description("Joca Marques - PI")]
        JocaMarques = 2205458,

        [EnumValue("2205508")]
        [Description("Jose de Freitas - PI")]
        JosedeFreitas = 2205508,

        [EnumValue("2205516")]
        [Description("Juazeiro do Piaui - PI")]
        JuazeirodoPiaui = 2205516,

        [EnumValue("2205524")]
        [Description("Julio Borges - PI")]
        JulioBorges = 2205524,

        [EnumValue("2205540")]
        [Description("Lagoinha do Piaui - PI")]
        LagoinhadoPiaui = 2205540,

        [EnumValue("2205557")]
        [Description("Lagoa Alegre - PI")]
        LagoaAlegre = 2205557,

        [EnumValue("2205565")]
        [Description("Lagoa do Barro do Piaui - PI")]
        LagoadoBarrodoPiaui = 2205565,

        [EnumValue("2205581")]
        [Description("Lagoa do Piaui - PI")]
        LagoadoPiaui = 2205581,

        [EnumValue("2205599")]
        [Description("Lagoa do Sitio - PI")]
        LagoadoSitio = 2205599,

        [EnumValue("2205607")]
        [Description("Landri Sales - PI")]
        LandriSales = 2205607,

        [EnumValue("2205706")]
        [Description("Luis Correia - PI")]
        LuisCorreia = 2205706,

        [EnumValue("2205854")]
        [Description("Madeiro - PI")]
        Madeiro = 2205854,

        [EnumValue("2205904")]
        [Description("Manoel Emidio - PI")]
        ManoelEmidio = 2205904,

        [EnumValue("2205953")]
        [Description("Marcolandia - PI")]
        Marcolandia = 2205953,

        [EnumValue("2206001")]
        [Description("Marcos Parente - PI")]
        MarcosParente = 2206001,

        [EnumValue("2206209")]
        [Description("Miguel Alves - PI")]
        MiguelAlves = 2206209,

        [EnumValue("2206670")]
        [Description("Morro do Chapeu do Piaui - PI")]
        MorrodoChapeudoPiaui = 2206670,

        [EnumValue("2206696")]
        [Description("Murici dos Portelas - PI")]
        MuricidosPortelas = 2206696,

        [EnumValue("2206704")]
        [Description("Nazare do Piaui - PI")]
        NazaredoPiaui = 2206704,

        [EnumValue("2206753")]
        [Description("Nossa Senhora de Nazare - PI")]
        NossaSenhoradeNazare = 2206753,

        [EnumValue("2206803")]
        [Description("Nossa Senhora dos Remedios - PI")]
        NossaSenhoradosRemedios = 2206803,

        [EnumValue("2206902")]
        [Description("Novo Oriente do Piaui - PI")]
        NovoOrientedoPiaui = 2206902,

        [EnumValue("2207009")]
        [Description("Oeiras - PI")]
        Oeiras = 2207009,

        [EnumValue("2207207")]
        [Description("Padre Marcos - PI")]
        PadreMarcos = 2207207,

        [EnumValue("2207603")]
        [Description("Parnagua - PI")]
        Parnagua = 2207603,

        [EnumValue("2207702")]
        [Description("Parnaiba - PI")]
        Parnaiba = 2207702,

        [EnumValue("2207751")]
        [Description("Passagem Franca do Piaui - PI")]
        PassagemFrancadoPiaui = 2207751,

        [EnumValue("2207850")]
        [Description("Pavussu - PI")]
        Pavussu = 2207850,

        [EnumValue("2207900")]
        [Description("Pedro II - PI")]
        PedroII = 2207900,

        [EnumValue("2207934")]
        [Description("Pedro Laurentino - PI")]
        PedroLaurentino = 2207934,

        [EnumValue("2208007")]
        [Description("Picos - PI")]
        Picos = 2208007,

        [EnumValue("2208106")]
        [Description("Pimenteiras - PI")]
        Pimenteiras = 2208106,

        [EnumValue("2208205")]
        [Description("Pio IX - PI")]
        PioIX = 2208205,

        [EnumValue("2208403")]
        [Description("Piripiri - PI")]
        Piripiri = 2208403,

        [EnumValue("2208502")]
        [Description("Porto - PI")]
        Porto = 2208502,

        [EnumValue("2208551")]
        [Description("Porto Alegre do Piaui - PI")]
        PortoAlegredoPiaui = 2208551,

        [EnumValue("2208650")]
        [Description("Queimada Nova - PI")]
        QueimadaNova = 2208650,

        [EnumValue("2208700")]
        [Description("Redencao do Gurgueia - PI")]
        RedencaodoGurgueia = 2208700,

        [EnumValue("2208874")]
        [Description("Ribeira do Piaui - PI")]
        RibeiradoPiaui = 2208874,

        [EnumValue("2208908")]
        [Description("Ribeiro Goncalves - PI")]
        RibeiroGoncalves = 2208908,

        [EnumValue("2209104")]
        [Description("Santa Cruz do Piaui - PI")]
        SantaCruzdoPiaui = 2209104,

        [EnumValue("2209203")]
        [Description("Santa Filomena - PI")]
        SantaFilomena_PI = 2209203,

        [EnumValue("2209377")]
        [Description("Santa Rosa do Piaui - PI")]
        SantaRosadoPiaui = 2209377,

        [EnumValue("2209450")]
        [Description("Santo Antonio dos Milagres - PI")]
        SantoAntoniodosMilagres = 2209450,

        [EnumValue("2209500")]
        [Description("Santo Inacio do Piaui - PI")]
        SantoInaciodoPiaui = 2209500,

        [EnumValue("2209658")]
        [Description("Sao Francisco de Assis do Piaui - PI")]
        SaoFranciscodeAssisdoPiaui = 2209658,

        [EnumValue("2209757")]
        [Description("Sao Goncalo do Gurgueia - PI")]
        SaoGoncalodoGurgueia = 2209757,

        [EnumValue("2209807")]
        [Description("Sao Goncalo do Piaui - PI")]
        SaoGoncalodoPiaui = 2209807,

        [EnumValue("2209872")]
        [Description("Sao Joao da Fronteira - PI")]
        SaoJoaodaFronteira = 2209872,

        [EnumValue("2209906")]
        [Description("Sao Joao da Serra - PI")]
        SaoJoaodaSerra = 2209906,

        [EnumValue("2209955")]
        [Description("Sao Joao da Varjota - PI")]
        SaoJoaodaVarjota = 2209955,

        [EnumValue("2210003")]
        [Description("Sao Joao do Piaui - PI")]
        SaoJoaodoPiaui = 2210003,

        [EnumValue("2210052")]
        [Description("Sao Jose do Divino - PI")]
        SaoJosedoDivino_PI = 2210052,

        [EnumValue("2210300")]
        [Description("Sao Juliao - PI")]
        SaoJuliao = 2210300,

        [EnumValue("2210375")]
        [Description("Sao Luis do Piaui - PI")]
        SaoLuisdoPiaui = 2210375,

        [EnumValue("2210391")]
        [Description("Sao Miguel do Fidalgo - PI")]
        SaoMigueldoFidalgo = 2210391,

        [EnumValue("2210409")]
        [Description("Sao Miguel do Tapuio - PI")]
        SaoMigueldoTapuio = 2210409,

        [EnumValue("2210607")]
        [Description("Sao Raimundo Nonato - PI")]
        SaoRaimundoNonato = 2210607,

        [EnumValue("2210631")]
        [Description("Sebastiao Leal - PI")]
        SebastiaoLeal = 2210631,

        [EnumValue("2210656")]
        [Description("Sigefredo Pacheco - PI")]
        SigefredoPacheco = 2210656,

        [EnumValue("2210938")]
        [Description("Sussuapara - PI")]
        Sussuapara = 2210938,

        [EnumValue("2210979")]
        [Description("Tanque do Piaui - PI")]
        TanquedoPiaui = 2210979,

        [EnumValue("2211001")]
        [Description("Teresina - PI")]
        Teresina = 2211001,

        [EnumValue("2211100")]
        [Description("Uniao - PI")]
        Uniao = 2211100,

        [EnumValue("2211209")]
        [Description("Urucui - PI")]
        Urucui = 2211209,

        [EnumValue("2211308")]
        [Description("Valenca do Piaui - PI")]
        ValencadoPiaui = 2211308,

        [EnumValue("2211357")]
        [Description("Varzea Branca - PI")]
        VarzeaBranca = 2211357,

        [EnumValue("2211704")]
        [Description("Wall Ferraz - PI")]
        WallFerraz = 2211704,

        //======Paraná======
        [EnumValue("4100202")]
        [Description("Adrianopolis - PR")]
        Adrianopolis = 4100202,

        [EnumValue("4100301")]
        [Description("Agudos do Sul - PR")]
        AgudosdoSul = 4100301,

        [EnumValue("4100400")]
        [Description("Almirante Tamandare - PR")]
        AlmiranteTamandare = 4100400,

        [EnumValue("4100459")]
        [Description("Altamira do Parana - PR")]
        AltamiradoParana = 4100459,

        [EnumValue("4100509")]
        [Description("Altonia - PR")]
        Altonia = 4100509,

        [EnumValue("4100608")]
        [Description("Alto Parana - PR")]
        AltoParana = 4100608,

        [EnumValue("4100707")]
        [Description("Alto Piquiri - PR")]
        AltoPiquiri = 4100707,

        [EnumValue("4100806")]
        [Description("Alvorada do Sul - PR")]
        AlvoradadoSul = 4100806,

        [EnumValue("4100905")]
        [Description("Amapora - PR")]
        Amapora = 4100905,

        [EnumValue("4101002")]
        [Description("Ampere - PR")]
        Ampere = 4101002,

        [EnumValue("4101051")]
        [Description("Anahy - PR")]
        Anahy = 4101051,

        [EnumValue("4101101")]
        [Description("Andira - PR")]
        Andira = 4101101,

        [EnumValue("4101150")]
        [Description("Angulo - PR")]
        Angulo = 4101150,

        [EnumValue("4101200")]
        [Description("Antonina - PR")]
        Antonina = 4101200,

        [EnumValue("4101309")]
        [Description("Antonio Olinto - PR")]
        AntonioOlinto = 4101309,

        [EnumValue("4101408")]
        [Description("Apucarana - PR")]
        Apucarana = 4101408,

        [EnumValue("4101507")]
        [Description("Arapongas - PR")]
        Arapongas = 4101507,

        [EnumValue("4101606")]
        [Description("Arapoti - PR")]
        Arapoti = 4101606,

        [EnumValue("4101705")]
        [Description("Araruna - PR")]
        Araruna_PR = 4101705,

        [EnumValue("4101804")]
        [Description("Araucaria - PR")]
        Araucaria = 4101804,

        [EnumValue("4101853")]
        [Description("Ariranha do Ivai - PR")]
        AriranhadoIvai = 4101853,

        [EnumValue("4101903")]
        [Description("Assai - PR")]
        Assai = 4101903,

        [EnumValue("4102000")]
        [Description("Assis Chateaubriand - PR")]
        AssisChateaubriand = 4102000,

        [EnumValue("4102109")]
        [Description("Astorga - PR")]
        Astorga = 4102109,

        [EnumValue("4102208")]
        [Description("Atalaia - PR")]
        Atalaia_PR = 4102208,

        [EnumValue("4102307")]
        [Description("Balsa Nova - PR")]
        BalsaNova = 4102307,

        [EnumValue("4102406")]
        [Description("Bandeirantes - PR")]
        Bandeirantes_PR = 4102406,

        [EnumValue("4102505")]
        [Description("Barbosa Ferraz - PR")]
        BarbosaFerraz = 4102505,

        [EnumValue("4102604")]
        [Description("Barracao - PR")]
        Barracao = 4102604,

        [EnumValue("4102703")]
        [Description("Barra do Jacare - PR")]
        BarradoJacare = 4102703,

        [EnumValue("4102752")]
        [Description("Bela Vista da Caroba - PR")]
        BelaVistadaCaroba = 4102752,

        [EnumValue("4102802")]
        [Description("Bela Vista do Paraiso - PR")]
        BelaVistadoParaiso = 4102802,

        [EnumValue("4102901")]
        [Description("Bituruna - PR")]
        Bituruna = 4102901,

        [EnumValue("4103008")]
        [Description("Boa Esperanca - PR")]
        BoaEsperanca_PR = 4103008,

        [EnumValue("4103024")]
        [Description("Boa Esperanca do Iguacu - PR")]
        BoaEsperancadoIguacu = 4103024,

        [EnumValue("4103057")]
        [Description("Boa Vista da Aparecida - PR")]
        BoaVistadaAparecida = 4103057,

        [EnumValue("4103107")]
        [Description("Bocaiuva do Sul - PR")]
        BocaiuvadoSul = 4103107,

        [EnumValue("4103156")]
        [Description("Bom Jesus do Sul - PR")]
        BomJesusdoSul = 4103156,

        [EnumValue("4103206")]
        [Description("Bom Sucesso - PR")]
        BomSucesso_PR = 4103206,

        [EnumValue("4103222")]
        [Description("Bom Sucesso do Sul - PR")]
        BomSucessodoSul = 4103222,

        [EnumValue("4103305")]
        [Description("Borrazopolis - PR")]
        Borrazopolis = 4103305,

        [EnumValue("4103354")]
        [Description("Braganey - PR")]
        Braganey = 4103354,

        [EnumValue("4103370")]
        [Description("Brasilandia do Sul - PR")]
        BrasilandiadoSul = 4103370,

        [EnumValue("4103404")]
        [Description("Cafeara - PR")]
        Cafeara = 4103404,

        [EnumValue("4103453")]
        [Description("Cafelandia - PR")]
        Cafelandia = 4103453,

        [EnumValue("4103479")]
        [Description("Cafezal do Sul - PR")]
        CafezaldoSul = 4103479,

        [EnumValue("4103503")]
        [Description("California - PR")]
        California = 4103503,

        [EnumValue("4103602")]
        [Description("Cambara - PR")]
        Cambara = 4103602,

        [EnumValue("4103701")]
        [Description("Cambe - PR")]
        Cambe = 4103701,

        [EnumValue("4103800")]
        [Description("Cambira - PR")]
        Cambira = 4103800,

        [EnumValue("4103909")]
        [Description("Campina da Lagoa - PR")]
        CampinadaLagoa = 4103909,

        [EnumValue("4103958")]
        [Description("Campina do Simao - PR")]
        CampinadoSimao = 4103958,

        [EnumValue("4104006")]
        [Description("Campina Grande do Sul - PR")]
        CampinaGrandedoSul = 4104006,

        [EnumValue("4104055")]
        [Description("Campo Bonito - PR")]
        CampoBonito = 4104055,

        [EnumValue("4104204")]
        [Description("Campo Largo - PR")]
        CampoLargo = 4104204,

        [EnumValue("4104253")]
        [Description("Campo Magro - PR")]
        CampoMagro = 4104253,

        [EnumValue("4104303")]
        [Description("Campo Mourao - PR")]
        CampoMourao = 4104303,

        [EnumValue("4104428")]
        [Description("Candoi - PR")]
        Candoi = 4104428,

        [EnumValue("4104451")]
        [Description("Cantagalo - PR")]
        Cantagalo_PR = 4104451,

        [EnumValue("4104501")]
        [Description("Capanema - PR")]
        Capanema_PR = 4104501,

        [EnumValue("4104600")]
        [Description("Capitao Leonidas Marques - PR")]
        CapitaoLeonidasMarques = 4104600,

        [EnumValue("4104659")]
        [Description("Carambei - PR")]
        Carambei = 4104659,

        [EnumValue("4104709")]
        [Description("Carlopolis - PR")]
        Carlopolis = 4104709,

        [EnumValue("4104808")]
        [Description("Cascavel - PR")]
        Cascavel_PR = 4104808,

        [EnumValue("4104907")]
        [Description("Castro - PR")]
        Castro = 4104907,

        [EnumValue("4105003")]
        [Description("Catanduvas - PR")]
        Catanduvas = 4105003,

        [EnumValue("4105102")]
        [Description("Centenario do Sul - PR")]
        CentenariodoSul = 4105102,

        [EnumValue("4105201")]
        [Description("Cerro Azul - PR")]
        CerroAzul = 4105201,

        [EnumValue("4105300")]
        [Description("Ceu Azul - PR")]
        CeuAzul = 4105300,

        [EnumValue("4105409")]
        [Description("Chopinzinho - PR")]
        Chopinzinho = 4105409,

        [EnumValue("4105508")]
        [Description("Cianorte - PR")]
        Cianorte = 4105508,

        [EnumValue("4105607")]
        [Description("Cidade Gaucha - PR")]
        CidadeGaucha = 4105607,

        [EnumValue("4105706")]
        [Description("Clevelandia - PR")]
        Clevelandia = 4105706,

        [EnumValue("4105805")]
        [Description("Colombo - PR")]
        Colombo = 4105805,

        [EnumValue("4105904")]
        [Description("Colorado - PR")]
        Colorado = 4105904,

        [EnumValue("4106209")]
        [Description("Contenda - PR")]
        Contenda = 4106209,

        [EnumValue("4106308")]
        [Description("Corbelia - PR")]
        Corbelia = 4106308,

        [EnumValue("4106407")]
        [Description("Cornelio Procopio - PR")]
        CornelioProcopio = 4106407,

        [EnumValue("4106506")]
        [Description("Coronel Vivida - PR")]
        CoronelVivida = 4106506,

        [EnumValue("4106555")]
        [Description("Corumbatai do Sul - PR")]
        CorumbataidoSul = 4106555,

        [EnumValue("4106605")]
        [Description("Cruzeiro do Oeste - PR")]
        CruzeirodoOeste = 4106605,

        [EnumValue("4106704")]
        [Description("Cruzeiro do Sul - PR")]
        CruzeirodoSul_PR = 4106704,

        [EnumValue("4106803")]
        [Description("Cruz Machado - PR")]
        CruzMachado = 4106803,

        [EnumValue("4106852")]
        [Description("Cruzmaltina - PR")]
        Cruzmaltina = 4106852,

        [EnumValue("4106902")]
        [Description("Curitiba - PR")]
        Curitiba = 4106902,

        [EnumValue("4107009")]
        [Description("Curiuva - PR")]
        Curiuva = 4107009,

        [EnumValue("4107108")]
        [Description("Diamante do Norte - PR")]
        DiamantedoNorte = 4107108,

        [EnumValue("4107157")]
        [Description("Diamante DOeste - PR")]
        DiamanteDOeste = 4107157,

        [EnumValue("4107207")]
        [Description("Dois Vizinhos - PR")]
        DoisVizinhos = 4107207,

        [EnumValue("4107256")]
        [Description("Douradina - PR")]
        Douradina_PR = 4107256,

        [EnumValue("4107306")]
        [Description("Doutor Camargo - PR")]
        DoutorCamargo = 4107306,

        [EnumValue("4107405")]
        [Description("Eneas Marques - PR")]
        EneasMarques = 4107405,

        [EnumValue("4107504")]
        [Description("Engenheiro Beltrao - PR")]
        EngenheiroBeltrao = 4107504,

        [EnumValue("4107520")]
        [Description("Esperanca Nova - PR")]
        EsperancaNova = 4107520,

        [EnumValue("4107538")]
        [Description("Entre Rios do Oeste - PR")]
        EntreRiosdoOeste = 4107538,

        [EnumValue("4107553")]
        [Description("Farol - PR")]
        Farol = 4107553,

        [EnumValue("4107603")]
        [Description("Faxinal - PR")]
        Faxinal = 4107603,

        [EnumValue("4107652")]
        [Description("Fazenda Rio Grande - PR")]
        FazendaRioGrande = 4107652,

        [EnumValue("4107702")]
        [Description("Fenix - PR")]
        Fenix = 4107702,

        [EnumValue("4107736")]
        [Description("Fernandes Pinheiro - PR")]
        FernandesPinheiro = 4107736,

        [EnumValue("4107751")]
        [Description("Figueira - PR")]
        Figueira = 4107751,

        [EnumValue("4107801")]
        [Description("Florai - PR")]
        Florai = 4107801,

        [EnumValue("4107850")]
        [Description("Flor da Serra do Sul - PR")]
        FlordaSerradoSul = 4107850,

        [EnumValue("4107900")]
        [Description("Floresta - PR")]
        Floresta_PR = 4107900,

        [EnumValue("4108007")]
        [Description("Florestopolis - PR")]
        Florestopolis = 4108007,

        [EnumValue("4108106")]
        [Description("Florida - PR")]
        Florida = 4108106,

        [EnumValue("4108205")]
        [Description("Formosa do Oeste - PR")]
        FormosadoOeste = 4108205,

        [EnumValue("4108304")]
        [Description("Foz do Iguacu - PR")]
        FozdoIguacu = 4108304,

        [EnumValue("4108320")]
        [Description("Francisco Alves - PR")]
        FranciscoAlves = 4108320,

        [EnumValue("4108403")]
        [Description("Francisco Beltrao - PR")]
        FranciscoBeltrao = 4108403,

        [EnumValue("4108502")]
        [Description("General Carneiro - PR")]
        GeneralCarneiro_PR = 4108502,

        [EnumValue("4108551")]
        [Description("Godoy Moreira - PR")]
        GodoyMoreira = 4108551,

        [EnumValue("4108601")]
        [Description("Goioere - PR")]
        Goioere = 4108601,

        [EnumValue("4108650")]
        [Description("Goioxim - PR")]
        Goioxim = 4108650,

        [EnumValue("4108700")]
        [Description("Grandes Rios - PR")]
        GrandesRios = 4108700,

        [EnumValue("4108809")]
        [Description("Guaira - PR")]
        Guaira = 4108809,

        [EnumValue("4108957")]
        [Description("Guamiranga - PR")]
        Guamiranga = 4108957,

        [EnumValue("4109005")]
        [Description("Guapirama - PR")]
        Guapirama = 4109005,

        [EnumValue("4109203")]
        [Description("Guaraci - PR")]
        Guaraci = 4109203,

        [EnumValue("4109302")]
        [Description("Guaraniacu - PR")]
        Guaraniacu = 4109302,

        [EnumValue("4109401")]
        [Description("Guarapuava - PR")]
        Guarapuava = 4109401,

        [EnumValue("4109500")]
        [Description("Guaraquecaba - PR")]
        Guaraquecaba = 4109500,

        [EnumValue("4109609")]
        [Description("Guaratuba - PR")]
        Guaratuba = 4109609,

        [EnumValue("4109658")]
        [Description("Honorio Serpa - PR")]
        HonorioSerpa = 4109658,

        [EnumValue("4109757")]
        [Description("Ibema - PR")]
        Ibema = 4109757,

        [EnumValue("4109807")]
        [Description("Ibipora - PR")]
        Ibipora = 4109807,

        [EnumValue("4109906")]
        [Description("Icaraima - PR")]
        Icaraima = 4109906,

        [EnumValue("4110003")]
        [Description("Iguaracu - PR")]
        Iguaracu = 4110003,

        [EnumValue("4110078")]
        [Description("Imbau - PR")]
        Imbau = 4110078,

        [EnumValue("4110201")]
        [Description("Inacio Martins - PR")]
        InacioMartins = 4110201,

        [EnumValue("4110300")]
        [Description("Inaja - PR")]
        Inaja_PR = 4110300,

        [EnumValue("4110508")]
        [Description("Ipiranga - PR")]
        Ipiranga = 4110508,

        [EnumValue("4110607")]
        [Description("Ipora - PR")]
        Ipora_PR = 4110607,

        [EnumValue("4110656")]
        [Description("Iracema do Oeste - PR")]
        IracemadoOeste = 4110656,

        [EnumValue("4110706")]
        [Description("Irati - PR")]
        Irati = 4110706,

        [EnumValue("4110805")]
        [Description("Iretama - PR")]
        Iretama = 4110805,

        [EnumValue("4110904")]
        [Description("Itaguaje - PR")]
        Itaguaje = 4110904,

        [EnumValue("4110953")]
        [Description("Itaipulandia - PR")]
        Itaipulandia = 4110953,

        [EnumValue("4111001")]
        [Description("Itambaraca - PR")]
        Itambaraca = 4111001,

        [EnumValue("4111100")]
        [Description("Itambe - PR")]
        Itambe_PR = 4111100,

        [EnumValue("4111209")]
        [Description("Itapejara dOeste - PR")]
        ItapejaradOeste = 4111209,

        [EnumValue("4111258")]
        [Description("Itaperucu - PR")]
        Itaperucu = 4111258,

        [EnumValue("4111407")]
        [Description("Ivai - PR")]
        Ivai = 4111407,

        [EnumValue("4111506")]
        [Description("Ivaipora - PR")]
        Ivaipora = 4111506,

        [EnumValue("4111555")]
        [Description("Ivate - PR")]
        Ivate = 4111555,

        [EnumValue("4111605")]
        [Description("Ivatuba - PR")]
        Ivatuba = 4111605,

        [EnumValue("4111704")]
        [Description("Jaboti - PR")]
        Jaboti = 4111704,

        [EnumValue("4111803")]
        [Description("Jacarezinho - PR")]
        Jacarezinho = 4111803,

        [EnumValue("4111902")]
        [Description("Jaguapita - PR")]
        Jaguapita = 4111902,

        [EnumValue("4112009")]
        [Description("Jaguariaiva - PR")]
        Jaguariaiva = 4112009,

        [EnumValue("4112108")]
        [Description("Jandaia do Sul - PR")]
        JandaiadoSul = 4112108,

        [EnumValue("4112207")]
        [Description("Janiopolis - PR")]
        Janiopolis = 4112207,

        [EnumValue("4112504")]
        [Description("Jardim Alegre - PR")]
        JardimAlegre = 4112504,

        [EnumValue("4112603")]
        [Description("Jardim Olinda - PR")]
        JardimOlinda = 4112603,

        [EnumValue("4112702")]
        [Description("Jataizinho - PR")]
        Jataizinho = 4112702,

        [EnumValue("4112751")]
        [Description("Jesuitas - PR")]
        Jesuitas = 4112751,

        [EnumValue("4112900")]
        [Description("Jundiai do Sul - PR")]
        JundiaidoSul = 4112900,

        [EnumValue("4112959")]
        [Description("Juranda - PR")]
        Juranda = 4112959,

        [EnumValue("4113007")]
        [Description("Jussara - PR")]
        Jussara_PR = 4113007,

        [EnumValue("4113106")]
        [Description("Kalore - PR")]
        Kalore = 4113106,

        [EnumValue("4113205")]
        [Description("Lapa - PR")]
        Lapa = 4113205,

        [EnumValue("4113304")]
        [Description("Laranjeiras do Sul - PR")]
        LaranjeirasdoSul = 4113304,

        [EnumValue("4113429")]
        [Description("Lidianopolis - PR")]
        Lidianopolis = 4113429,

        [EnumValue("4113452")]
        [Description("Lindoeste - PR")]
        Lindoeste = 4113452,

        [EnumValue("4113502")]
        [Description("Loanda - PR")]
        Loanda = 4113502,

        [EnumValue("4113601")]
        [Description("Lobato - PR")]
        Lobato = 4113601,

        [EnumValue("4113700")]
        [Description("Londrina - PR")]
        Londrina = 4113700,

        [EnumValue("4113734")]
        [Description("Luiziana - PR")]
        Luiziana = 4113734,

        [EnumValue("4113759")]
        [Description("Lunardelli - PR")]
        Lunardelli = 4113759,

        [EnumValue("4113809")]
        [Description("Lupionopolis - PR")]
        Lupionopolis = 4113809,

        [EnumValue("4113908")]
        [Description("Mallet - PR")]
        Mallet = 4113908,

        [EnumValue("4114005")]
        [Description("Mambore - PR")]
        Mambore = 4114005,

        [EnumValue("4114104")]
        [Description("Mandaguacu - PR")]
        Mandaguacu = 4114104,

        [EnumValue("4114203")]
        [Description("Mandaguari - PR")]
        Mandaguari = 4114203,

        [EnumValue("4114302")]
        [Description("Mandirituba - PR")]
        Mandirituba = 4114302,

        [EnumValue("4114351")]
        [Description("Manfrinopolis - PR")]
        Manfrinopolis = 4114351,

        [EnumValue("4114401")]
        [Description("Mangueirinha - PR")]
        Mangueirinha = 4114401,

        [EnumValue("4114609")]
        [Description("Marechal Candido Rondon - PR")]
        MarechalCandidoRondon = 4114609,

        [EnumValue("4114708")]
        [Description("Maria Helena - PR")]
        MariaHelena = 4114708,

        [EnumValue("4114807")]
        [Description("Marialva - PR")]
        Marialva = 4114807,

        [EnumValue("4114906")]
        [Description("Marilandia do Sul - PR")]
        MarilandiadoSul = 4114906,

        [EnumValue("4115002")]
        [Description("Marilena - PR")]
        Marilena = 4115002,

        [EnumValue("4115101")]
        [Description("Mariluz - PR")]
        Mariluz = 4115101,

        [EnumValue("4115200")]
        [Description("Maringa - PR")]
        Maringa = 4115200,

        [EnumValue("4115309")]
        [Description("Mariopolis - PR")]
        Mariopolis = 4115309,

        [EnumValue("4115408")]
        [Description("Marmeleiro - PR")]
        Marmeleiro = 4115408,

        [EnumValue("4115457")]
        [Description("Marquinho - PR")]
        Marquinho = 4115457,

        [EnumValue("4115705")]
        [Description("Matinhos - PR")]
        Matinhos = 4115705,

        [EnumValue("4115739")]
        [Description("Mato Rico - PR")]
        MatoRico = 4115739,

        [EnumValue("4115754")]
        [Description("Maua da Serra - PR")]
        MauadaSerra = 4115754,

        [EnumValue("4115804")]
        [Description("Medianeira - PR")]
        Medianeira = 4115804,

        [EnumValue("4115853")]
        [Description("Mercedes - PR")]
        Mercedes = 4115853,

        [EnumValue("4116109")]
        [Description("Moreira Sales - PR")]
        MoreiraSales = 4116109,

        [EnumValue("4116208")]
        [Description("Morretes - PR")]
        Morretes = 4116208,

        [EnumValue("4116307")]
        [Description("Munhoz de Melo - PR")]
        MunhozdeMelo = 4116307,

        [EnumValue("4116406")]
        [Description("Nossa Senhora das Gracas - PR")]
        NossaSenhoradasGracas = 4116406,

        [EnumValue("4116604")]
        [Description("Nova America da Colina - PR")]
        NovaAmericadaColina = 4116604,

        [EnumValue("4116703")]
        [Description("Nova Aurora - PR")]
        NovaAurora_PR = 4116703,

        [EnumValue("4116802")]
        [Description("Nova Cantu - PR")]
        NovaCantu = 4116802,

        [EnumValue("4116901")]
        [Description("Nova Esperanca - PR")]
        NovaEsperanca = 4116901,

        [EnumValue("4116950")]
        [Description("Nova Esperanca do Sudoeste - PR")]
        NovaEsperancadoSudoeste = 4116950,

        [EnumValue("4117008")]
        [Description("Nova Fatima - PR")]
        NovaFatima_PR = 4117008,

        [EnumValue("4117107")]
        [Description("Nova Londrina - PR")]
        NovaLondrina = 4117107,

        [EnumValue("4117206")]
        [Description("Nova Olimpia - PR")]
        NovaOlimpia_PR = 4117206,

        [EnumValue("4117214")]
        [Description("Nova Santa Barbara - PR")]
        NovaSantaBarbara = 4117214,

        [EnumValue("4117222")]
        [Description("Nova Santa Rosa - PR")]
        NovaSantaRosa = 4117222,

        [EnumValue("4117255")]
        [Description("Nova Prata do Iguacu - PR")]
        NovaPratadoIguacu = 4117255,

        [EnumValue("4117271")]
        [Description("Nova Tebas - PR")]
        NovaTebas = 4117271,

        [EnumValue("4117297")]
        [Description("Novo Itacolomi - PR")]
        NovoItacolomi = 4117297,

        [EnumValue("4117305")]
        [Description("Ortigueira - PR")]
        Ortigueira = 4117305,

        [EnumValue("4117404")]
        [Description("Ourizona - PR")]
        Ourizona = 4117404,

        [EnumValue("4117453")]
        [Description("Ouro Verde do Oeste - PR")]
        OuroVerdedoOeste = 4117453,

        [EnumValue("4117503")]
        [Description("Paicandu - PR")]
        Paicandu = 4117503,

        [EnumValue("4117602")]
        [Description("Palmas - PR")]
        Palmas = 4117602,

        [EnumValue("4117701")]
        [Description("Palmeira - PR")]
        Palmeira = 4117701,

        [EnumValue("4117909")]
        [Description("Palotina - PR")]
        Palotina = 4117909,

        [EnumValue("4118006")]
        [Description("Paraiso do Norte - PR")]
        ParaisodoNorte = 4118006,

        [EnumValue("4118105")]
        [Description("Paranacity - PR")]
        Paranacity = 4118105,

        [EnumValue("4118204")]
        [Description("Paranagua - PR")]
        Paranagua = 4118204,

        [EnumValue("4118303")]
        [Description("Paranapoema - PR")]
        Paranapoema = 4118303,

        [EnumValue("4118402")]
        [Description("Paranavai - PR")]
        Paranavai = 4118402,

        [EnumValue("4118451")]
        [Description("Pato Bragado - PR")]
        PatoBragado = 4118451,

        [EnumValue("4118501")]
        [Description("Pato Branco - PR")]
        PatoBranco = 4118501,

        [EnumValue("4118600")]
        [Description("Paula Freitas - PR")]
        PaulaFreitas = 4118600,

        [EnumValue("4118709")]
        [Description("Paulo Frontin - PR")]
        PauloFrontin = 4118709,

        [EnumValue("4118808")]
        [Description("Peabiru - PR")]
        Peabiru = 4118808,

        [EnumValue("4118857")]
        [Description("Perobal - PR")]
        Perobal = 4118857,

        [EnumValue("4118907")]
        [Description("Perola - PR")]
        Perola = 4118907,

        [EnumValue("4119004")]
        [Description("Perola dOeste - PR")]
        PeroladOeste = 4119004,

        [EnumValue("4119152")]
        [Description("Pinhais - PR")]
        Pinhais = 4119152,

        [EnumValue("4119202")]
        [Description("Pinhalao - PR")]
        Pinhalao = 4119202,

        [EnumValue("4119251")]
        [Description("Pinhal de Sao Bento - PR")]
        PinhaldeSaoBento = 4119251,

        [EnumValue("4119301")]
        [Description("Pinhao - PR")]
        Pinhao = 4119301,

        [EnumValue("4119400")]
        [Description("Pirai do Sul - PR")]
        PiraidoSul = 4119400,

        [EnumValue("4119509")]
        [Description("Piraquara - PR")]
        Piraquara = 4119509,

        [EnumValue("4119608")]
        [Description("Pitanga - PR")]
        Pitanga = 4119608,

        [EnumValue("4119657")]
        [Description("Pitangueiras - PR")]
        Pitangueiras = 4119657,

        [EnumValue("4119707")]
        [Description("Planaltina do Parana - PR")]
        PlanaltinadoParana = 4119707,

        [EnumValue("4119806")]
        [Description("Planalto - PR")]
        Planalto_PR = 4119806,

        [EnumValue("4119905")]
        [Description("Ponta Grossa - PR")]
        PontaGrossa = 4119905,

        [EnumValue("4119954")]
        [Description("Pontal do Parana - PR")]
        PontaldoParana = 4119954,

        [EnumValue("4120002")]
        [Description("Porecatu - PR")]
        Porecatu = 4120002,

        [EnumValue("4120150")]
        [Description("Porto Barreiro - PR")]
        PortoBarreiro = 4120150,

        [EnumValue("4120200")]
        [Description("Porto Rico - PR")]
        PortoRico = 4120200,

        [EnumValue("4120309")]
        [Description("Porto Vitoria - PR")]
        PortoVitoria = 4120309,

        [EnumValue("4120333")]
        [Description("Prado Ferreira - PR")]
        PradoFerreira = 4120333,

        [EnumValue("4120507")]
        [Description("Primeiro de Maio - PR")]
        PrimeirodeMaio = 4120507,

        [EnumValue("4120606")]
        [Description("Prudentopolis - PR")]
        Prudentopolis = 4120606,

        [EnumValue("4120655")]
        [Description("Quarto Centenario - PR")]
        QuartoCentenario = 4120655,

        [EnumValue("4120705")]
        [Description("Quatigua - PR")]
        Quatigua = 4120705,

        [EnumValue("4120804")]
        [Description("Quatro Barras - PR")]
        QuatroBarras = 4120804,

        [EnumValue("4120853")]
        [Description("Quatro Pontes - PR")]
        QuatroPontes = 4120853,

        [EnumValue("4121000")]
        [Description("Querencia do Norte - PR")]
        QuerenciadoNorte = 4121000,

        [EnumValue("4121109")]
        [Description("Quinta do Sol - PR")]
        QuintadoSol = 4121109,

        [EnumValue("4121257")]
        [Description("Ramilandia - PR")]
        Ramilandia = 4121257,

        [EnumValue("4121307")]
        [Description("Rancho Alegre - PR")]
        RanchoAlegre = 4121307,

        [EnumValue("4121356")]
        [Description("Rancho Alegre DOeste - PR")]
        RanchoAlegreDOeste = 4121356,

        [EnumValue("4121406")]
        [Description("Realeza - PR")]
        Realeza = 4121406,

        [EnumValue("4121505")]
        [Description("Reboucas - PR")]
        Reboucas = 4121505,

        [EnumValue("4121604")]
        [Description("Renascenca - PR")]
        Renascenca = 4121604,

        [EnumValue("4121703")]
        [Description("Reserva - PR")]
        Reserva = 4121703,

        [EnumValue("4121752")]
        [Description("Reserva do Iguacu - PR")]
        ReservadoIguacu = 4121752,

        [EnumValue("4121802")]
        [Description("Ribeirao Claro - PR")]
        RibeiraoClaro = 4121802,

        [EnumValue("4122008")]
        [Description("Rio Azul - PR")]
        RioAzul = 4122008,

        [EnumValue("4122107")]
        [Description("Rio Bom - PR")]
        RioBom = 4122107,

        [EnumValue("4122156")]
        [Description("Rio Bonito do Iguacu - PR")]
        RioBonitodoIguacu = 4122156,

        [EnumValue("4122172")]
        [Description("Rio Branco do Ivai - PR")]
        RioBrancodoIvai = 4122172,

        [EnumValue("4122206")]
        [Description("Rio Branco do Sul - PR")]
        RioBrancodoSul = 4122206,

        [EnumValue("4122305")]
        [Description("Rio Negro - PR")]
        RioNegro_PR = 4122305,

        [EnumValue("4122404")]
        [Description("Rolandia - PR")]
        Rolandia = 4122404,

        [EnumValue("4122503")]
        [Description("Roncador - PR")]
        Roncador = 4122503,

        [EnumValue("4122602")]
        [Description("Rondon - PR")]
        Rondon = 4122602,

        [EnumValue("4122651")]
        [Description("Rosario do Ivai - PR")]
        RosariodoIvai = 4122651,

        [EnumValue("4122701")]
        [Description("Sabaudia - PR")]
        Sabaudia = 4122701,

        [EnumValue("4122800")]
        [Description("Salgado Filho - PR")]
        SalgadoFilho = 4122800,

        [EnumValue("4122909")]
        [Description("Salto do Itarare - PR")]
        SaltodoItarare = 4122909,

        [EnumValue("4123303")]
        [Description("Santa Cruz de Monte Castelo - PR")]
        SantaCruzdeMonteCastelo = 4123303,

        [EnumValue("4123402")]
        [Description("Santa Fe - PR")]
        SantaFe = 4123402,

        [EnumValue("4123501")]
        [Description("Santa Helena - PR")]
        SantaHelena_PR = 4123501,

        [EnumValue("4123600")]
        [Description("Santa Ines - PR")]
        SantaInes_PR = 4123600,

        [EnumValue("4123709")]
        [Description("Santa Isabel do Ivai - PR")]
        SantaIsabeldoIvai = 4123709,

        [EnumValue("4123808")]
        [Description("Santa Izabel do Oeste - PR")]
        SantaIzabeldoOeste = 4123808,

        [EnumValue("4123824")]
        [Description("Santa Lucia - PR")]
        SantaLucia = 4123824,

        [EnumValue("4123956")]
        [Description("Santa Monica - PR")]
        SantaMonica = 4123956,

        [EnumValue("4124004")]
        [Description("Santana do Itarare - PR")]
        SantanadoItarare = 4124004,

        [EnumValue("4124020")]
        [Description("Santa Tereza do Oeste - PR")]
        SantaTerezadoOeste = 4124020,

        [EnumValue("4124053")]
        [Description("Santa Terezinha de Itaipu - PR")]
        SantaTerezinhadeItaipu = 4124053,

        [EnumValue("4124103")]
        [Description("Santo Antonio da Platina - PR")]
        SantoAntoniodaPlatina = 4124103,

        [EnumValue("4124202")]
        [Description("Santo Antonio do Caiua - PR")]
        SantoAntoniodoCaiua = 4124202,

        [EnumValue("4124301")]
        [Description("Santo Antonio do Paraiso - PR")]
        SantoAntoniodoParaiso = 4124301,

        [EnumValue("4124400")]
        [Description("Santo Antonio do Sudoeste - PR")]
        SantoAntoniodoSudoeste = 4124400,

        [EnumValue("4124608")]
        [Description("Sao Carlos do Ivai - PR")]
        SaoCarlosdoIvai = 4124608,

        [EnumValue("4124806")]
        [Description("Sao Joao - PR")]
        SaoJoao_PR = 4124806,

        [EnumValue("4124905")]
        [Description("Sao Joao do Caiua - PR")]
        SaoJoaodoCaiua = 4124905,

        [EnumValue("4125001")]
        [Description("Sao Joao do Ivai - PR")]
        SaoJoaodoIvai = 4125001,

        [EnumValue("4125100")]
        [Description("Sao Joao do Triunfo - PR")]
        SaoJoaodoTriunfo = 4125100,

        [EnumValue("4125209")]
        [Description("Sao Jorge dOeste - PR")]
        SaoJorgedOeste = 4125209,

        [EnumValue("4125308")]
        [Description("Sao Jorge do Ivai - PR")]
        SaoJorgedoIvai = 4125308,

        [EnumValue("4125357")]
        [Description("Sao Jorge do Patrocinio - PR")]
        SaoJorgedoPatrocinio = 4125357,

        [EnumValue("4125407")]
        [Description("Sao Jose da Boa Vista - PR")]
        SaoJosedaBoaVista = 4125407,

        [EnumValue("4125456")]
        [Description("Sao Jose das Palmeiras - PR")]
        SaoJosedasPalmeiras = 4125456,

        [EnumValue("4125506")]
        [Description("Sao Jose dos Pinhais - PR")]
        SaoJosedosPinhais = 4125506,

        [EnumValue("4125605")]
        [Description("Sao Mateus do Sul - PR")]
        SaoMateusdoSul = 4125605,

        [EnumValue("4125704")]
        [Description("Sao Miguel do Iguacu - PR")]
        SaoMigueldoIguacu = 4125704,

        [EnumValue("4125753")]
        [Description("Sao Pedro do Iguacu - PR")]
        SaoPedrodoIguacu = 4125753,

        [EnumValue("4125803")]
        [Description("Sao Pedro do Ivai - PR")]
        SaoPedrodoIvai = 4125803,

        [EnumValue("4125902")]
        [Description("Sao Pedro do Parana - PR")]
        SaoPedrodoParana = 4125902,

        [EnumValue("4126009")]
        [Description("Sao Sebastiao da Amoreira - PR")]
        SaoSebastiaodaAmoreira = 4126009,

        [EnumValue("4126207")]
        [Description("Sapopema - PR")]
        Sapopema = 4126207,

        [EnumValue("4126256")]
        [Description("Sarandi - PR")]
        Sarandi = 4126256,

        [EnumValue("4126306")]
        [Description("Senges - PR")]
        Senges = 4126306,

        [EnumValue("4126355")]
        [Description("Serranopolis do Iguacu - PR")]
        SerranopolisdoIguacu = 4126355,

        [EnumValue("4126405")]
        [Description("Sertaneja - PR")]
        Sertaneja = 4126405,

        [EnumValue("4126504")]
        [Description("Sertanopolis - PR")]
        Sertanopolis = 4126504,

        [EnumValue("4126603")]
        [Description("Siqueira Campos - PR")]
        SiqueiraCampos = 4126603,

        [EnumValue("4126652")]
        [Description("Sulina - PR")]
        Sulina = 4126652,

        [EnumValue("4126678")]
        [Description("Tamarana - PR")]
        Tamarana = 4126678,

        [EnumValue("4126702")]
        [Description("Tamboara - PR")]
        Tamboara = 4126702,

        [EnumValue("4126801")]
        [Description("Tapejara - PR")]
        Tapejara = 4126801,

        [EnumValue("4126900")]
        [Description("Tapira - PR")]
        Tapira_PR = 4126900,

        [EnumValue("4127007")]
        [Description("Teixeira Soares - PR")]
        TeixeiraSoares = 4127007,

        [EnumValue("4127106")]
        [Description("Telemaco Borba - PR")]
        TelemacoBorba = 4127106,

        [EnumValue("4127205")]
        [Description("Terra Boa - PR")]
        TerraBoa = 4127205,

        [EnumValue("4127403")]
        [Description("Terra Roxa - PR")]
        TerraRoxa = 4127403,

        [EnumValue("4127502")]
        [Description("Tibagi - PR")]
        Tibagi = 4127502,

        [EnumValue("4127601")]
        [Description("Tijucas do Sul - PR")]
        TijucasdoSul = 4127601,

        [EnumValue("4127700")]
        [Description("Toledo - PR")]
        Toledo_PR = 4127700,

        [EnumValue("4127809")]
        [Description("Tomazina - PR")]
        Tomazina = 4127809,

        [EnumValue("4127858")]
        [Description("Tres Barras do Parana - PR")]
        TresBarrasdoParana = 4127858,

        [EnumValue("4127882")]
        [Description("Tunas do Parana - PR")]
        TunasdoParana = 4127882,

        [EnumValue("4127957")]
        [Description("Tupassi - PR")]
        Tupassi = 4127957,

        [EnumValue("4127965")]
        [Description("Turvo - PR")]
        Turvo = 4127965,

        [EnumValue("4128005")]
        [Description("Ubirata - PR")]
        Ubirata = 4128005,

        [EnumValue("4128104")]
        [Description("Umuarama - PR")]
        Umuarama = 4128104,

        [EnumValue("4128203")]
        [Description("Uniao da Vitoria - PR")]
        UniaodaVitoria = 4128203,

        [EnumValue("4128500")]
        [Description("Wenceslau Braz - PR")]
        WenceslauBraz_PR = 4128500,

        [EnumValue("4128559")]
        [Description("Vera Cruz do Oeste - PR")]
        VeraCruzdoOeste = 4128559,

        [EnumValue("4128625")]
        [Description("Alto Paraiso - PR")]
        AltoParaiso = 4128625,

        [EnumValue("4128633")]
        [Description("Doutor Ulysses - PR")]
        DoutorUlysses = 4128633,

        [EnumValue("4128658")]
        [Description("Virmond - PR")]
        Virmond = 4128658,

        [EnumValue("4128708")]
        [Description("Vitorino - PR")]
        Vitorino = 4128708,

        [EnumValue("4128807")]
        [Description("Xambre - PR")]
        Xambre = 4128807,

        //======Rio de Janeiro======
        [EnumValue("3300100")]
        [Description("Angra dos Reis - RJ")]
        AngradosReis = 3300100,

        [EnumValue("3300159")]
        [Description("Aperibe - RJ")]
        Aperibe = 3300159,

        [EnumValue("3300209")]
        [Description("Araruama - RJ")]
        Araruama = 3300209,

        [EnumValue("3300225")]
        [Description("Areal - RJ")]
        Areal = 3300225,

        [EnumValue("3300233")]
        [Description("Armacao dos Buzios - RJ")]
        ArmacaodosBuzios = 3300233,

        [EnumValue("3300308")]
        [Description("Barra do Pirai - RJ")]
        BarradoPirai = 3300308,

        [EnumValue("3300407")]
        [Description("Barra Mansa - RJ")]
        BarraMansa = 3300407,

        [EnumValue("3300456")]
        [Description("Belford Roxo - RJ")]
        BelfordRoxo = 3300456,

        [EnumValue("3300506")]
        [Description("Bom Jardim - RJ")]
        BomJardim_RJ = 3300506,

        [EnumValue("3300605")]
        [Description("Bom Jesus do Itabapoana - RJ")]
        BomJesusdoItabapoana = 3300605,

        [EnumValue("3300704")]
        [Description("Cabo Frio - RJ")]
        CaboFrio = 3300704,

        [EnumValue("3300803")]
        [Description("Cachoeiras de Macacu - RJ")]
        CachoeirasdeMacacu = 3300803,

        [EnumValue("3300902")]
        [Description("Cambuci - RJ")]
        Cambuci = 3300902,

        [EnumValue("3300936")]
        [Description("Carapebus - RJ")]
        Carapebus = 3300936,

        [EnumValue("3300951")]
        [Description("Comendador Levy Gasparian - RJ")]
        ComendadorLevyGasparian = 3300951,

        [EnumValue("3301009")]
        [Description("Campos dos Goytacazes - RJ")]
        CamposdosGoytacazes = 3301009,

        [EnumValue("3301108")]
        [Description("Cantagalo - RJ")]
        Cantagalo_RJ = 3301108,

        [EnumValue("3301157")]
        [Description("Cardoso Moreira - RJ")]
        CardosoMoreira = 3301157,

        [EnumValue("3301207")]
        [Description("Carmo - RJ")]
        Carmo = 3301207,

        [EnumValue("3301306")]
        [Description("Casimiro de Abreu - RJ")]
        CasimirodeAbreu = 3301306,

        [EnumValue("3301405")]
        [Description("Conceicao de Macabu - RJ")]
        ConceicaodeMacabu = 3301405,

        [EnumValue("3301504")]
        [Description("Cordeiro - RJ")]
        Cordeiro = 3301504,

        [EnumValue("3301603")]
        [Description("Duas Barras - RJ")]
        DuasBarras = 3301603,

        [EnumValue("3301702")]
        [Description("Duque de Caxias - RJ")]
        DuquedeCaxias = 3301702,

        [EnumValue("3301801")]
        [Description("Engenheiro Paulo de Frontin - RJ")]
        EngenheiroPaulodeFrontin = 3301801,

        [EnumValue("3301850")]
        [Description("Guapimirim - RJ")]
        Guapimirim = 3301850,

        [EnumValue("3301876")]
        [Description("Iguaba Grande - RJ")]
        IguabaGrande = 3301876,

        [EnumValue("3301900")]
        [Description("Itaborai - RJ")]
        Itaborai = 3301900,

        [EnumValue("3302007")]
        [Description("Itaguai - RJ")]
        Itaguai = 3302007,

        [EnumValue("3302056")]
        [Description("Italva - RJ")]
        Italva = 3302056,

        [EnumValue("3302106")]
        [Description("Itaocara - RJ")]
        Itaocara = 3302106,

        [EnumValue("3302205")]
        [Description("Itaperuna - RJ")]
        Itaperuna = 3302205,

        [EnumValue("3302254")]
        [Description("Itatiaia - RJ")]
        Itatiaia = 3302254,

        [EnumValue("3302270")]
        [Description("Japeri - RJ")]
        Japeri = 3302270,

        [EnumValue("3302304")]
        [Description("Laje do Muriae - RJ")]
        LajedoMuriae = 3302304,

        [EnumValue("3302403")]
        [Description("Macae - RJ")]
        Macae = 3302403,

        [EnumValue("3302452")]
        [Description("Macuco - RJ")]
        Macuco = 3302452,

        [EnumValue("3302502")]
        [Description("Mage - RJ")]
        Mage = 3302502,

        [EnumValue("3302601")]
        [Description("Mangaratiba - RJ")]
        Mangaratiba = 3302601,

        [EnumValue("3302700")]
        [Description("Marica - RJ")]
        Marica = 3302700,

        [EnumValue("3302809")]
        [Description("Mendes - RJ")]
        Mendes = 3302809,

        [EnumValue("3302858")]
        [Description("Mesquita - RJ")]
        Mesquita_RJ = 3302858,

        [EnumValue("3302908")]
        [Description("Miguel Pereira - RJ")]
        MiguelPereira = 3302908,

        [EnumValue("3303005")]
        [Description("Miracema - RJ")]
        Miracema = 3303005,

        [EnumValue("3303104")]
        [Description("Natividade - RJ")]
        Natividade = 3303104,

        [EnumValue("3303203")]
        [Description("Nilopolis - RJ")]
        Nilopolis = 3303203,

        [EnumValue("3303302")]
        [Description("Niteroi - RJ")]
        Niteroi = 3303302,

        [EnumValue("3303401")]
        [Description("Nova Friburgo - RJ")]
        NovaFriburgo = 3303401,

        [EnumValue("3303500")]
        [Description("Nova Iguacu - RJ")]
        NovaIguacu = 3303500,

        [EnumValue("3303609")]
        [Description("Paracambi - RJ")]
        Paracambi = 3303609,

        [EnumValue("3303708")]
        [Description("Paraiba do Sul - RJ")]
        ParaibadoSul = 3303708,

        [EnumValue("3303807")]
        [Description("Paraty - RJ")]
        Paraty = 3303807,

        [EnumValue("3303856")]
        [Description("Paty do Alferes - RJ")]
        PatydoAlferes = 3303856,

        [EnumValue("3303906")]
        [Description("Petropolis - RJ")]
        Petropolis = 3303906,

        [EnumValue("3303955")]
        [Description("Pinheiral - RJ")]
        Pinheiral = 3303955,

        [EnumValue("3304003")]
        [Description("Pirai - RJ")]
        Pirai = 3304003,

        [EnumValue("3304102")]
        [Description("Porciuncula - RJ")]
        Porciuncula = 3304102,

        [EnumValue("3304110")]
        [Description("Porto Real - RJ")]
        PortoReal = 3304110,

        [EnumValue("3304128")]
        [Description("Quatis - RJ")]
        Quatis = 3304128,

        [EnumValue("3304144")]
        [Description("Queimados - RJ")]
        Queimados = 3304144,

        [EnumValue("3304151")]
        [Description("Quissama - RJ")]
        Quissama = 3304151,

        [EnumValue("3304201")]
        [Description("Resende - RJ")]
        Resende = 3304201,

        [EnumValue("3304300")]
        [Description("Rio Bonito - RJ")]
        RioBonito = 3304300,

        [EnumValue("3304409")]
        [Description("Rio Claro - RJ")]
        RioClaro = 3304409,

        [EnumValue("3304508")]
        [Description("Rio das Flores - RJ")]
        RiodasFlores = 3304508,

        [EnumValue("3304524")]
        [Description("Rio das Ostras - RJ")]
        RiodasOstras = 3304524,

        [EnumValue("3304557")]
        [Description("Rio de Janeiro - RJ")]
        RiodeJaneiro = 3304557,

        [EnumValue("3304607")]
        [Description("Santa Maria Madalena - RJ")]
        SantaMariaMadalena = 3304607,

        [EnumValue("3304706")]
        [Description("Santo Antonio de Padua - RJ")]
        SantoAntoniodePadua = 3304706,

        [EnumValue("3304755")]
        [Description("Sao Francisco de Itabapoana - RJ")]
        SaoFranciscodeItabapoana = 3304755,

        [EnumValue("3304805")]
        [Description("Sao Fidelis - RJ")]
        SaoFidelis = 3304805,

        [EnumValue("3304904")]
        [Description("Sao Goncalo - RJ")]
        SaoGoncalo = 3304904,

        [EnumValue("3305000")]
        [Description("Sao Joao da Barra - RJ")]
        SaoJoaodaBarra = 3305000,

        [EnumValue("3305109")]
        [Description("Sao Joao de Meriti - RJ")]
        SaoJoaodeMeriti = 3305109,

        [EnumValue("3305133")]
        [Description("Sao Jose de Uba - RJ")]
        SaoJosedeUba = 3305133,

        [EnumValue("3305158")]
        [Description("Sao Jose do Vale do Rio Preto - RJ")]
        SaoJosedoValedoRioPreto = 3305158,

        [EnumValue("3305208")]
        [Description("Sao Pedro da Aldeia - RJ")]
        SaoPedrodaAldeia = 3305208,

        [EnumValue("3305307")]
        [Description("Sao Sebastiao do Alto - RJ")]
        SaoSebastiaodoAlto = 3305307,

        [EnumValue("3305406")]
        [Description("Sapucaia - RJ")]
        Sapucaia_RJ = 3305406,

        [EnumValue("3305505")]
        [Description("Saquarema - RJ")]
        Saquarema = 3305505,

        [EnumValue("3305554")]
        [Description("Seropedica - RJ")]
        Seropedica = 3305554,

        [EnumValue("3305604")]
        [Description("Silva Jardim - RJ")]
        SilvaJardim = 3305604,

        [EnumValue("3305703")]
        [Description("Sumidouro - RJ")]
        Sumidouro = 3305703,

        [EnumValue("3305802")]
        [Description("Teresopolis - RJ")]
        Teresopolis = 3305802,

        [EnumValue("3305901")]
        [Description("Trajano de Moraes - RJ")]
        TrajanodeMoraes = 3305901,

        [EnumValue("3306008")]
        [Description("Tres Rios - RJ")]
        TresRios = 3306008,

        [EnumValue("3306107")]
        [Description("Valenca - RJ")]
        Valenca_RJ = 3306107,

        [EnumValue("3306156")]
        [Description("Varre-Sai - RJ")]
        VarreSai = 3306156,

        [EnumValue("3306206")]
        [Description("Vassouras - RJ")]
        Vassouras = 3306206,

        [EnumValue("3306305")]
        [Description("Volta Redonda - RJ")]
        VoltaRedonda = 3306305,

        //======Rio Grande do Norte======
        [EnumValue("2400109")]
        [Description("Acari - RN")]
        Acari = 2400109,

        [EnumValue("2400208")]
        [Description("Assu - RN")]
        Assu = 2400208,

        [EnumValue("2400901")]
        [Description("Antonio Martins - RN")]
        AntonioMartins = 2400901,

        [EnumValue("2401008")]
        [Description("Apodi - RN")]
        Apodi = 2401008,

        [EnumValue("2401404")]
        [Description("Baia Formosa - RN")]
        BaiaFormosa = 2401404,

        [EnumValue("2401503")]
        [Description("Barcelona - RN")]
        Barcelona = 2401503,

        [EnumValue("2401602")]
        [Description("Bento Fernandes - RN")]
        BentoFernandes = 2401602,

        [EnumValue("2401909")]
        [Description("Caicara do Rio do Vento - RN")]
        CaicaradoRiodoVento = 2401909,

        [EnumValue("2402006")]
        [Description("Caico - RN")]
        Caico = 2402006,

        [EnumValue("2402105")]
        [Description("Campo Redondo - RN")]
        CampoRedondo = 2402105,

        [EnumValue("2402204")]
        [Description("Canguaretama - RN")]
        Canguaretama = 2402204,

        [EnumValue("2402402")]
        [Description("Carnauba dos Dantas - RN")]
        CarnaubadosDantas = 2402402,

        [EnumValue("2402501")]
        [Description("Carnaubais - RN")]
        Carnaubais = 2402501,

        [EnumValue("2402600")]
        [Description("Ceara-Mirim - RN")]
        CearaMirim = 2402600,

        [EnumValue("2402709")]
        [Description("Cerro Cora - RN")]
        CerroCora = 2402709,

        [EnumValue("2402808")]
        [Description("Coronel Ezequiel - RN")]
        CoronelEzequiel = 2402808,

        [EnumValue("2402907")]
        [Description("Coronel Joao Pessoa - RN")]
        CoronelJoaoPessoa = 2402907,

        [EnumValue("2403004")]
        [Description("Cruzeta - RN")]
        Cruzeta = 2403004,

        [EnumValue("2403103")]
        [Description("Currais Novos - RN")]
        CurraisNovos = 2403103,

        [EnumValue("2403251")]
        [Description("Parnamirim - RN")]
        Parnamirim_RN = 2403251,

        [EnumValue("2403301")]
        [Description("Encanto - RN")]
        Encanto = 2403301,

        [EnumValue("2403400")]
        [Description("Equador - RN")]
        Equador = 2403400,

        [EnumValue("2403509")]
        [Description("Espirito Santo - RN")]
        EspiritoSanto = 2403509,

        [EnumValue("2403608")]
        [Description("Extremoz - RN")]
        Extremoz = 2403608,

        [EnumValue("2403707")]
        [Description("Felipe Guerra - RN")]
        FelipeGuerra = 2403707,

        [EnumValue("2403756")]
        [Description("Fernando Pedroza - RN")]
        FernandoPedroza = 2403756,

        [EnumValue("2403806")]
        [Description("Florania - RN")]
        Florania = 2403806,

        [EnumValue("2403905")]
        [Description("Francisco Dantas - RN")]
        FranciscoDantas = 2403905,

        [EnumValue("2404002")]
        [Description("Frutuoso Gomes - RN")]
        FrutuosoGomes = 2404002,

        [EnumValue("2404200")]
        [Description("Goianinha - RN")]
        Goianinha = 2404200,

        [EnumValue("2404606")]
        [Description("Ielmo Marinho - RN")]
        IelmoMarinho = 2404606,

        [EnumValue("2404705")]
        [Description("Ipanguacu - RN")]
        Ipanguacu = 2404705,

        [EnumValue("2404804")]
        [Description("Ipueira - RN")]
        Ipueira = 2404804,

        [EnumValue("2404853")]
        [Description("Itaja - RN")]
        Itaja_RN = 2404853,

        [EnumValue("2405108")]
        [Description("Jandaira - RN")]
        Jandaira_RN = 2405108,

        [EnumValue("2405207")]
        [Description("Janduis - RN")]
        Janduis = 2405207,

        [EnumValue("2405306")]
        [Description("Januario Cicco - RN")]
        JanuarioCicco = 2405306,

        [EnumValue("2405405")]
        [Description("Japi - RN")]
        Japi = 2405405,

        [EnumValue("2405504")]
        [Description("Jardim de Angicos - RN")]
        JardimdeAngicos = 2405504,

        [EnumValue("2405603")]
        [Description("Jardim de Piranhas - RN")]
        JardimdePiranhas = 2405603,

        [EnumValue("2405702")]
        [Description("Jardim do Serido - RN")]
        JardimdoSerido = 2405702,

        [EnumValue("2406155")]
        [Description("Jundia - RN")]
        Jundia_RN = 2406155,

        [EnumValue("2406205")]
        [Description("Lagoa dAnta - RN")]
        LagoadAnta = 2406205,

        [EnumValue("2406304")]
        [Description("Lagoa de Pedras - RN")]
        LagoadePedras = 2406304,

        [EnumValue("2406403")]
        [Description("Lagoa de Velhos - RN")]
        LagoadeVelhos = 2406403,

        [EnumValue("2406502")]
        [Description("Lagoa Nova - RN")]
        LagoaNova = 2406502,

        [EnumValue("2406601")]
        [Description("Lagoa Salgada - RN")]
        LagoaSalgada = 2406601,

        [EnumValue("2406908")]
        [Description("Lucrecia - RN")]
        Lucrecia = 2406908,

        [EnumValue("2407005")]
        [Description("Luis Gomes - RN")]
        LuisGomes = 2407005,

        [EnumValue("2407104")]
        [Description("Macaiba - RN")]
        Macaiba = 2407104,

        [EnumValue("2407252")]
        [Description("Major Sales - RN")]
        MajorSales = 2407252,

        [EnumValue("2407302")]
        [Description("Marcelino Vieira - RN")]
        MarcelinoVieira = 2407302,

        [EnumValue("2407401")]
        [Description("Martins - RN")]
        Martins = 2407401,

        [EnumValue("2407708")]
        [Description("Montanhas - RN")]
        Montanhas = 2407708,

        [EnumValue("2407807")]
        [Description("Monte Alegre - RN")]
        MonteAlegre_RN = 2407807,

        [EnumValue("2408003")]
        [Description("Mossoro - RN")]
        Mossoro = 2408003,

        [EnumValue("2408102")]
        [Description("Natal - RN")]
        Natal = 2408102,

        [EnumValue("2408201")]
        [Description("Nisia Floresta - RN")]
        NisiaFloresta = 2408201,

        [EnumValue("2408409")]
        [Description("Olho dAgua do Borges - RN")]
        OlhodAguadoBorges = 2408409,

        [EnumValue("2408607")]
        [Description("Parana - RN")]
        Parana = 2408607,

        [EnumValue("2408706")]
        [Description("Parau - RN")]
        Parau = 2408706,

        [EnumValue("2408904")]
        [Description("Parelhas - RN")]
        Parelhas = 2408904,

        [EnumValue("2408953")]
        [Description("Rio do Fogo - RN")]
        RiodoFogo = 2408953,

        [EnumValue("2409209")]
        [Description("Passagem - RN")]
        Passagem_RN = 2409209,

        [EnumValue("2409332")]
        [Description("Santa Maria - RN")]
        SantaMaria = 2409332,

        [EnumValue("2409407")]
        [Description("Pau dos Ferros - RN")]
        PaudosFerros = 2409407,

        [EnumValue("2409506")]
        [Description("Pedra Grande - RN")]
        PedraGrande = 2409506,

        [EnumValue("2409605")]
        [Description("Pedra Preta - RN")]
        PedraPreta_RN = 2409605,

        [EnumValue("2409704")]
        [Description("Pedro Avelino - RN")]
        PedroAvelino = 2409704,

        [EnumValue("2409803")]
        [Description("Pedro Velho - RN")]
        PedroVelho = 2409803,

        [EnumValue("2410207")]
        [Description("Portalegre - RN")]
        Portalegre = 2410207,

        [EnumValue("2410306")]
        [Description("Serra Caiada - RN")]
        SerraCaiada = 2410306,

        [EnumValue("2410405")]
        [Description("Pureza - RN")]
        Pureza = 2410405,

        [EnumValue("2410504")]
        [Description("Rafael Fernandes - RN")]
        RafaelFernandes = 2410504,

        [EnumValue("2410702")]
        [Description("Riacho da Cruz - RN")]
        RiachodaCruz = 2410702,

        [EnumValue("2410900")]
        [Description("Riachuelo - RN")]
        Riachuelo = 2410900,

        [EnumValue("2411007")]
        [Description("Rodolfo Fernandes - RN")]
        RodolfoFernandes = 2411007,

        [EnumValue("2411056")]
        [Description("Tibau - RN")]
        Tibau = 2411056,

        [EnumValue("2411205")]
        [Description("Santa Cruz - RN")]
        SantaCruz_RN = 2411205,

        [EnumValue("2411429")]
        [Description("Santana do Serido - RN")]
        SantanadoSerido = 2411429,

        [EnumValue("2411601")]
        [Description("Sao Bento do Norte - RN")]
        SaoBentodoNorte = 2411601,

        [EnumValue("2411809")]
        [Description("Sao Fernando - RN")]
        SaoFernando = 2411809,

        [EnumValue("2411908")]
        [Description("Sao Francisco do Oeste - RN")]
        SaoFranciscodoOeste = 2411908,

        [EnumValue("2412005")]
        [Description("Sao Goncalo do Amarante - RN")]
        SaoGoncalodoAmarante_RN = 2412005,

        [EnumValue("2412104")]
        [Description("Sao Joao do Sabugi - RN")]
        SaoJoaodoSabugi = 2412104,

        [EnumValue("2412203")]
        [Description("Sao Jose de Mipibu - RN")]
        SaoJosedeMipibu = 2412203,

        [EnumValue("2412302")]
        [Description("Sao Jose do Campestre - RN")]
        SaoJosedoCampestre = 2412302,

        [EnumValue("2412401")]
        [Description("Sao Jose do Serido - RN")]
        SaoJosedoSerido = 2412401,

        [EnumValue("2412500")]
        [Description("Sao Miguel - RN")]
        SaoMiguel = 2412500,

        [EnumValue("2412559")]
        [Description("Sao Miguel do Gostoso - RN")]
        SaoMigueldoGostoso = 2412559,

        [EnumValue("2412609")]
        [Description("Sao Paulo do Potengi - RN")]
        SaoPaulodoPotengi = 2412609,

        [EnumValue("2412708")]
        [Description("Sao Pedro - RN")]
        SaoPedro = 2412708,

        [EnumValue("2412807")]
        [Description("Sao Rafael - RN")]
        SaoRafael = 2412807,

        [EnumValue("2412906")]
        [Description("Sao Tome - RN")]
        SaoTome_RN = 2412906,

        [EnumValue("2413003")]
        [Description("Sao Vicente - RN")]
        SaoVicente = 2413003,

        [EnumValue("2413102")]
        [Description("Senador Eloi de Souza - RN")]
        SenadorEloideSouza = 2413102,

        [EnumValue("2413201")]
        [Description("Senador Georgino Avelino - RN")]
        SenadorGeorginoAvelino = 2413201,

        [EnumValue("2413300")]
        [Description("Serra de Sao Bento - RN")]
        SerradeSaoBento = 2413300,

        [EnumValue("2413359")]
        [Description("Serra do Mel - RN")]
        SerradoMel = 2413359,

        [EnumValue("2413409")]
        [Description("Serra Negra do Norte - RN")]
        SerraNegradoNorte = 2413409,

        [EnumValue("2413508")]
        [Description("Serrinha - RN")]
        Serrinha_RN = 2413508,

        [EnumValue("2413557")]
        [Description("Serrinha dos Pintos - RN")]
        SerrinhadosPintos = 2413557,

        [EnumValue("2413607")]
        [Description("Severiano Melo - RN")]
        SeverianoMelo = 2413607,

        [EnumValue("2413706")]
        [Description("Sitio Novo - RN")]
        SitioNovo_RN = 2413706,

        [EnumValue("2413805")]
        [Description("Taboleiro Grande - RN")]
        TaboleiroGrande = 2413805,

        [EnumValue("2414001")]
        [Description("Tangara - RN")]
        Tangara = 2414001,

        [EnumValue("2414100")]
        [Description("Tenente Ananias - RN")]
        TenenteAnanias = 2414100,

        [EnumValue("2414159")]
        [Description("Tenente Laurentino Cruz - RN")]
        TenenteLaurentinoCruz = 2414159,

        [EnumValue("2414209")]
        [Description("Tibau do Sul - RN")]
        TibaudoSul = 2414209,

        [EnumValue("2414308")]
        [Description("Timbauba dos Batistas - RN")]
        TimbaubadosBatistas = 2414308,

        [EnumValue("2414407")]
        [Description("Touros - RN")]
        Touros = 2414407,

        [EnumValue("2414456")]
        [Description("Triunfo Potiguar - RN")]
        TriunfoPotiguar = 2414456,

        [EnumValue("2414506")]
        [Description("Umarizal - RN")]
        Umarizal = 2414506,

        [EnumValue("2414605")]
        [Description("Upanema - RN")]
        Upanema = 2414605,

        [EnumValue("2414704")]
        [Description("Varzea - RN")]
        Varzea_RN = 2414704,

        [EnumValue("2414753")]
        [Description("Venha-Ver - RN")]
        VenhaVer = 2414753,

        [EnumValue("2414803")]
        [Description("Vera Cruz - RN")]
        VeraCruz_RN = 2414803,

        [EnumValue("2414902")]
        [Description("Vicosa - RN")]
        Vicosa_RN = 2414902,

        //======Rondônia======
        [EnumValue("1100015")]
        [Description("Alta Floresta DOeste - RO")]
        AltaFlorestaDOeste = 1100015,

        [EnumValue("1100023")]
        [Description("Ariquemes - RO")]
        Ariquemes = 1100023,

        [EnumValue("1100031")]
        [Description("Cabixi - RO")]
        Cabixi = 1100031,

        [EnumValue("1100049")]
        [Description("Cacoal - RO")]
        Cacoal = 1100049,

        [EnumValue("1100056")]
        [Description("Cerejeiras - RO")]
        Cerejeiras = 1100056,

        [EnumValue("1100064")]
        [Description("Colorado do Oeste - RO")]
        ColoradodoOeste = 1100064,

        [EnumValue("1100072")]
        [Description("Corumbiara - RO")]
        Corumbiara = 1100072,

        [EnumValue("1100080")]
        [Description("Costa Marques - RO")]
        CostaMarques = 1100080,

        [EnumValue("1100098")]
        [Description("Espigao DOeste - RO")]
        EspigaoDOeste = 1100098,

        [EnumValue("1100106")]
        [Description("Guajara-Mirim - RO")]
        GuajaraMirim = 1100106,

        [EnumValue("1100114")]
        [Description("Jaru - RO")]
        Jaru = 1100114,

        [EnumValue("1100122")]
        [Description("Ji-Parana - RO")]
        JiParana = 1100122,

        [EnumValue("1100130")]
        [Description("Machadinho DOeste - RO")]
        MachadinhoDOeste = 1100130,

        [EnumValue("1100148")]
        [Description("Nova Brasilandia DOeste - RO")]
        NovaBrasilandiaDOeste = 1100148,

        [EnumValue("1100155")]
        [Description("Ouro Preto do Oeste - RO")]
        OuroPretodoOeste = 1100155,

        [EnumValue("1100189")]
        [Description("Pimenta Bueno - RO")]
        PimentaBueno = 1100189,

        [EnumValue("1100205")]
        [Description("Porto Velho - RO")]
        PortoVelho = 1100205,

        [EnumValue("1100254")]
        [Description("Presidente Medici - RO")]
        PresidenteMedici_RO = 1100254,

        [EnumValue("1100262")]
        [Description("Rio Crespo - RO")]
        RioCrespo = 1100262,

        [EnumValue("1100288")]
        [Description("Rolim de Moura - RO")]
        RolimdeMoura = 1100288,

        [EnumValue("1100296")]
        [Description("Santa Luzia DOeste - RO")]
        SantaLuziaDOeste = 1100296,

        [EnumValue("1100304")]
        [Description("Vilhena - RO")]
        Vilhena = 1100304,

        [EnumValue("1100320")]
        [Description("Sao Miguel do Guapore - RO")]
        SaoMigueldoGuapore = 1100320,

        [EnumValue("1100338")]
        [Description("Nova Mamore - RO")]
        NovaMamore = 1100338,

        [EnumValue("1100346")]
        [Description("Alvorada DOeste - RO")]
        AlvoradaDOeste = 1100346,

        [EnumValue("1100379")]
        [Description("Alto Alegre dos Parecis - RO")]
        AltoAlegredosParecis = 1100379,

        [EnumValue("1100403")]
        [Description("Alto Paraiso - RO")]
        AltoParaiso_RO = 1100403,

        [EnumValue("1100452")]
        [Description("Buritis - RO")]
        Buritis_RO = 1100452,

        [EnumValue("1100502")]
        [Description("Novo Horizonte do Oeste - RO")]
        NovoHorizontedoOeste = 1100502,

        [EnumValue("1100601")]
        [Description("Cacaulandia - RO")]
        Cacaulandia = 1100601,

        [EnumValue("1100700")]
        [Description("Campo Novo de Rondonia - RO")]
        CampoNovodeRondonia = 1100700,

        [EnumValue("1100809")]
        [Description("Candeias do Jamari - RO")]
        CandeiasdoJamari = 1100809,

        [EnumValue("1100908")]
        [Description("Castanheiras - RO")]
        Castanheiras = 1100908,

        [EnumValue("1100924")]
        [Description("Chupinguaia - RO")]
        Chupinguaia = 1100924,

        [EnumValue("1100940")]
        [Description("Cujubim - RO")]
        Cujubim = 1100940,

        [EnumValue("1101005")]
        [Description("Governador Jorge Teixeira - RO")]
        GovernadorJorgeTeixeira = 1101005,

        [EnumValue("1101104")]
        [Description("Itapua do Oeste - RO")]
        ItapuadoOeste = 1101104,

        [EnumValue("1101203")]
        [Description("Ministro Andreazza - RO")]
        MinistroAndreazza = 1101203,

        [EnumValue("1101302")]
        [Description("Mirante da Serra - RO")]
        MirantedaSerra = 1101302,

        [EnumValue("1101401")]
        [Description("Monte Negro - RO")]
        MonteNegro = 1101401,

        [EnumValue("1101435")]
        [Description("Nova Uniao - RO")]
        NovaUniao_RO = 1101435,

        [EnumValue("1101450")]
        [Description("Parecis - RO")]
        Parecis = 1101450,

        [EnumValue("1101468")]
        [Description("Pimenteiras do Oeste - RO")]
        PimenteirasdoOeste = 1101468,

        [EnumValue("1101476")]
        [Description("Primavera de Rondonia - RO")]
        PrimaveradeRondonia = 1101476,

        [EnumValue("1101484")]
        [Description("Sao Felipe DOeste - RO")]
        SaoFelipeDOeste = 1101484,

        [EnumValue("1101492")]
        [Description("Sao Francisco do Guapore - RO")]
        SaoFranciscodoGuapore = 1101492,

        [EnumValue("1101500")]
        [Description("Seringueiras - RO")]
        Seringueiras = 1101500,

        [EnumValue("1101559")]
        [Description("Teixeiropolis - RO")]
        Teixeiropolis = 1101559,

        [EnumValue("1101609")]
        [Description("Theobroma - RO")]
        Theobroma = 1101609,

        [EnumValue("1101708")]
        [Description("Urupa - RO")]
        Urupa = 1101708,

        [EnumValue("1101757")]
        [Description("Vale do Anari - RO")]
        ValedoAnari = 1101757,

        [EnumValue("1101807")]
        [Description("Vale do Paraiso - RO")]
        ValedoParaiso = 1101807,

        //======Roraima======
        [EnumValue("1400027")]
        [Description("Amajari - RR")]
        Amajari = 1400027,

        [EnumValue("1400050")]
        [Description("Alto Alegre - RR")]
        AltoAlegre = 1400050,

        [EnumValue("1400100")]
        [Description("Boa Vista - RR")]
        BoaVista_RR = 1400100,

        [EnumValue("1400159")]
        [Description("Bonfim - RR")]
        Bonfim_RR = 1400159,

        [EnumValue("1400175")]
        [Description("Canta - RR")]
        Canta = 1400175,

        [EnumValue("1400209")]
        [Description("Caracarai - RR")]
        Caracarai = 1400209,

        [EnumValue("1400233")]
        [Description("Caroebe - RR")]
        Caroebe = 1400233,

        [EnumValue("1400282")]
        [Description("Iracema - RR")]
        Iracema_RR = 1400282,

        [EnumValue("1400308")]
        [Description("Mucajai - RR")]
        Mucajai = 1400308,

        [EnumValue("1400407")]
        [Description("Normandia - RR")]
        Normandia = 1400407,

        [EnumValue("1400456")]
        [Description("Pacaraima - RR")]
        Pacaraima = 1400456,

        [EnumValue("1400472")]
        [Description("Rorainopolis - RR")]
        Rorainopolis = 1400472,

        [EnumValue("1400506")]
        [Description("Sao Joao da Baliza - RR")]
        SaoJoaodaBaliza = 1400506,

        [EnumValue("1400605")]
        [Description("Sao Luiz do Anaua - RR")]
        SaoLuizdoAnaua = 1400605,

        [EnumValue("1400704")]
        [Description("Uiramuta - RR")]
        Uiramuta = 1400704,

        //======Rio Grande do Sul======
        [EnumValue("4300034")]
        [Description("Acegua - RS")]
        Acegua = 4300034,

        [EnumValue("4300059")]
        [Description("Agua Santa - RS")]
        AguaSanta = 4300059,

        [EnumValue("4300109")]
        [Description("Agudo - RS")]
        Agudo = 4300109,

        [EnumValue("4300208")]
        [Description("Ajuricaba - RS")]
        Ajuricaba = 4300208,

        [EnumValue("4300406")]
        [Description("Alegrete - RS")]
        Alegrete = 4300406,

        [EnumValue("4300471")]
        [Description("Almirante Tamandare do Sul - RS")]
        AlmiranteTamandaredoSul = 4300471,

        [EnumValue("4300505")]
        [Description("Alpestre - RS")]
        Alpestre = 4300505,

        [EnumValue("4300554")]
        [Description("Alto Alegre - RS")]
        AltoAlegre_RS = 4300554,

        [EnumValue("4300570")]
        [Description("Alto Feliz - RS")]
        AltoFeliz = 4300570,

        [EnumValue("4300604")]
        [Description("Alvorada - RS")]
        Alvorada = 4300604,

        [EnumValue("4300646")]
        [Description("Ametista do Sul - RS")]
        AmetistadoSul = 4300646,

        [EnumValue("4300661")]
        [Description("Andre da Rocha - RS")]
        AndredaRocha = 4300661,

        [EnumValue("4300703")]
        [Description("Anta Gorda - RS")]
        AntaGorda = 4300703,

        [EnumValue("4300802")]
        [Description("Antonio Prado - RS")]
        AntonioPrado = 4300802,

        [EnumValue("4300877")]
        [Description("Ararica - RS")]
        Ararica = 4300877,

        [EnumValue("4300901")]
        [Description("Aratiba - RS")]
        Aratiba = 4300901,

        [EnumValue("4301008")]
        [Description("Arroio do Meio - RS")]
        ArroiodoMeio = 4301008,

        [EnumValue("4301057")]
        [Description("Arroio do Sal - RS")]
        ArroiodoSal = 4301057,

        [EnumValue("4301073")]
        [Description("Arroio do Padre - RS")]
        ArroiodoPadre = 4301073,

        [EnumValue("4301107")]
        [Description("Arroio dos Ratos - RS")]
        ArroiodosRatos = 4301107,

        [EnumValue("4301206")]
        [Description("Arroio do Tigre - RS")]
        ArroiodoTigre = 4301206,

        [EnumValue("4301305")]
        [Description("Arroio Grande - RS")]
        ArroioGrande = 4301305,

        [EnumValue("4301404")]
        [Description("Arvorezinha - RS")]
        Arvorezinha = 4301404,

        [EnumValue("4301503")]
        [Description("Augusto Pestana - RS")]
        AugustoPestana = 4301503,

        [EnumValue("4301552")]
        [Description("Aurea - RS")]
        Aurea = 4301552,

        [EnumValue("4301602")]
        [Description("Bage - RS")]
        Bage = 4301602,

        [EnumValue("4301636")]
        [Description("Balneario Pinhal - RS")]
        BalnearioPinhal = 4301636,

        [EnumValue("4301651")]
        [Description("Barao - RS")]
        Barao = 4301651,

        [EnumValue("4301701")]
        [Description("Barao de Cotegipe - RS")]
        BaraodeCotegipe = 4301701,

        [EnumValue("4301750")]
        [Description("Barao do Triunfo - RS")]
        BaraodoTriunfo = 4301750,

        [EnumValue("4301859")]
        [Description("Barra do Guarita - RS")]
        BarradoGuarita = 4301859,

        [EnumValue("4301909")]
        [Description("Barra do Ribeiro - RS")]
        BarradoRibeiro = 4301909,

        [EnumValue("4301925")]
        [Description("Barra do Rio Azul - RS")]
        BarradoRioAzul = 4301925,

        [EnumValue("4301958")]
        [Description("Barra Funda - RS")]
        BarraFunda = 4301958,

        [EnumValue("4302006")]
        [Description("Barros Cassal - RS")]
        BarrosCassal = 4302006,

        [EnumValue("4302055")]
        [Description("Benjamin Constant do Sul - RS")]
        BenjaminConstantdoSul = 4302055,

        [EnumValue("4302105")]
        [Description("Bento Goncalves - RS")]
        BentoGoncalves = 4302105,

        [EnumValue("4302154")]
        [Description("Boa Vista das Missoes - RS")]
        BoaVistadasMissoes = 4302154,

        [EnumValue("4302204")]
        [Description("Boa Vista do Burica - RS")]
        BoaVistadoBurica = 4302204,

        [EnumValue("4302220")]
        [Description("Boa Vista do Cadeado - RS")]
        BoaVistadoCadeado = 4302220,

        [EnumValue("4302238")]
        [Description("Boa Vista do Incra - RS")]
        BoaVistadoIncra = 4302238,

        [EnumValue("4302253")]
        [Description("Boa Vista do Sul - RS")]
        BoaVistadoSul = 4302253,

        [EnumValue("4302303")]
        [Description("Bom Jesus - RS")]
        BomJesus_RS = 4302303,

        [EnumValue("4302352")]
        [Description("Bom Principio - RS")]
        BomPrincipio = 4302352,

        [EnumValue("4302378")]
        [Description("Bom Progresso - RS")]
        BomProgresso = 4302378,

        [EnumValue("4302402")]
        [Description("Bom Retiro do Sul - RS")]
        BomRetirodoSul = 4302402,

        [EnumValue("4302451")]
        [Description("Boqueirao do Leao - RS")]
        BoqueiraodoLeao = 4302451,

        [EnumValue("4302501")]
        [Description("Bossoroca - RS")]
        Bossoroca = 4302501,

        [EnumValue("4302584")]
        [Description("Bozano - RS")]
        Bozano = 4302584,

        [EnumValue("4302600")]
        [Description("Braga - RS")]
        Braga = 4302600,

        [EnumValue("4302659")]
        [Description("Brochier - RS")]
        Brochier = 4302659,

        [EnumValue("4302709")]
        [Description("Butia - RS")]
        Butia = 4302709,

        [EnumValue("4302808")]
        [Description("Cacapava do Sul - RS")]
        CacapavadoSul = 4302808,

        [EnumValue("4302907")]
        [Description("Cacequi - RS")]
        Cacequi = 4302907,

        [EnumValue("4303004")]
        [Description("Cachoeira do Sul - RS")]
        CachoeiradoSul = 4303004,

        [EnumValue("4303103")]
        [Description("Cachoeirinha - RS")]
        Cachoeirinha_RS = 4303103,

        [EnumValue("4303202")]
        [Description("Cacique Doble - RS")]
        CaciqueDoble = 4303202,

        [EnumValue("4303301")]
        [Description("Caibate - RS")]
        Caibate = 4303301,

        [EnumValue("4303400")]
        [Description("Caicara - RS")]
        Caicara_RS = 4303400,

        [EnumValue("4303509")]
        [Description("Camaqua - RS")]
        Camaqua = 4303509,

        [EnumValue("4303558")]
        [Description("Camargo - RS")]
        Camargo = 4303558,

        [EnumValue("4303608")]
        [Description("Cambara do Sul - RS")]
        CambaradoSul = 4303608,

        [EnumValue("4303673")]
        [Description("Campestre da Serra - RS")]
        CampestredaSerra = 4303673,

        [EnumValue("4303707")]
        [Description("Campina das Missoes - RS")]
        CampinadasMissoes = 4303707,

        [EnumValue("4303806")]
        [Description("Campinas do Sul - RS")]
        CampinasdoSul = 4303806,

        [EnumValue("4303905")]
        [Description("Campo Bom - RS")]
        CampoBom = 4303905,

        [EnumValue("4304002")]
        [Description("Campo Novo - RS")]
        CampoNovo = 4304002,

        [EnumValue("4304101")]
        [Description("Campos Borges - RS")]
        CamposBorges = 4304101,

        [EnumValue("4304200")]
        [Description("Candelaria - RS")]
        Candelaria = 4304200,

        [EnumValue("4304309")]
        [Description("Candido Godoi - RS")]
        CandidoGodoi = 4304309,

        [EnumValue("4304358")]
        [Description("Candiota - RS")]
        Candiota = 4304358,

        [EnumValue("4304408")]
        [Description("Canela - RS")]
        Canela = 4304408,

        [EnumValue("4304507")]
        [Description("Cangucu - RS")]
        Cangucu = 4304507,

        [EnumValue("4304606")]
        [Description("Canoas - RS")]
        Canoas = 4304606,

        [EnumValue("4304614")]
        [Description("Canudos do Vale - RS")]
        CanudosdoVale = 4304614,

        [EnumValue("4304622")]
        [Description("Capao Bonito do Sul - RS")]
        CapaoBonitodoSul = 4304622,

        [EnumValue("4304630")]
        [Description("Capao da Canoa - RS")]
        CapaodaCanoa = 4304630,

        [EnumValue("4304655")]
        [Description("Capao do Cipo - RS")]
        CapaodoCipo = 4304655,

        [EnumValue("4304671")]
        [Description("Capivari do Sul - RS")]
        CapivaridoSul = 4304671,

        [EnumValue("4304689")]
        [Description("Capela de Santana - RS")]
        CapeladeSantana = 4304689,

        [EnumValue("4304697")]
        [Description("Capitao - RS")]
        Capitao = 4304697,

        [EnumValue("4304705")]
        [Description("Carazinho - RS")]
        Carazinho = 4304705,

        [EnumValue("4304713")]
        [Description("Caraa - RS")]
        Caraa = 4304713,

        [EnumValue("4304804")]
        [Description("Carlos Barbosa - RS")]
        CarlosBarbosa = 4304804,

        [EnumValue("4304853")]
        [Description("Carlos Gomes - RS")]
        CarlosGomes = 4304853,

        [EnumValue("4304903")]
        [Description("Casca - RS")]
        Casca = 4304903,

        [EnumValue("4304952")]
        [Description("Caseiros - RS")]
        Caseiros = 4304952,

        [EnumValue("4305009")]
        [Description("Catuipe - RS")]
        Catuipe = 4305009,

        [EnumValue("4305108")]
        [Description("Caxias do Sul - RS")]
        CaxiasdoSul = 4305108,

        [EnumValue("4305116")]
        [Description("Centenario - RS")]
        Centenario = 4305116,

        [EnumValue("4305124")]
        [Description("Cerrito - RS")]
        Cerrito = 4305124,

        [EnumValue("4305132")]
        [Description("Cerro Branco - RS")]
        CerroBranco = 4305132,

        [EnumValue("4305157")]
        [Description("Cerro Grande - RS")]
        CerroGrande = 4305157,

        [EnumValue("4305173")]
        [Description("Cerro Grande do Sul - RS")]
        CerroGrandedoSul = 4305173,

        [EnumValue("4305207")]
        [Description("Cerro Largo - RS")]
        CerroLargo = 4305207,

        [EnumValue("4305306")]
        [Description("Chapada - RS")]
        Chapada = 4305306,

        [EnumValue("4305355")]
        [Description("Charqueadas - RS")]
        Charqueadas = 4305355,

        [EnumValue("4305371")]
        [Description("Charrua - RS")]
        Charrua = 4305371,

        [EnumValue("4305405")]
        [Description("Chiapetta - RS")]
        Chiapetta = 4305405,

        [EnumValue("4305439")]
        [Description("Chui - RS")]
        Chui = 4305439,

        [EnumValue("4305447")]
        [Description("Chuvisca - RS")]
        Chuvisca = 4305447,

        [EnumValue("4305454")]
        [Description("Cidreira - RS")]
        Cidreira = 4305454,

        [EnumValue("4305504")]
        [Description("Ciriaco - RS")]
        Ciriaco = 4305504,

        [EnumValue("4305587")]
        [Description("Colinas - RS")]
        Colinas_RS = 4305587,

        [EnumValue("4305603")]
        [Description("Colorado - RS")]
        Colorado_RS = 4305603,

        [EnumValue("4305702")]
        [Description("Condor - RS")]
        Condor = 4305702,

        [EnumValue("4305801")]
        [Description("Constantina - RS")]
        Constantina = 4305801,

        [EnumValue("4305835")]
        [Description("Coqueiro Baixo - RS")]
        CoqueiroBaixo = 4305835,

        [EnumValue("4305850")]
        [Description("Coqueiros do Sul - RS")]
        CoqueirosdoSul = 4305850,

        [EnumValue("4305871")]
        [Description("Coronel Barros - RS")]
        CoronelBarros = 4305871,

        [EnumValue("4305900")]
        [Description("Coronel Bicaco - RS")]
        CoronelBicaco = 4305900,

        [EnumValue("4305934")]
        [Description("Coronel Pilar - RS")]
        CoronelPilar = 4305934,

        [EnumValue("4305959")]
        [Description("Cotipora - RS")]
        Cotipora = 4305959,

        [EnumValue("4305975")]
        [Description("Coxilha - RS")]
        Coxilha = 4305975,

        [EnumValue("4306007")]
        [Description("Crissiumal - RS")]
        Crissiumal = 4306007,

        [EnumValue("4306056")]
        [Description("Cristal - RS")]
        Cristal = 4306056,

        [EnumValue("4306072")]
        [Description("Cristal do Sul - RS")]
        CristaldoSul = 4306072,

        [EnumValue("4306106")]
        [Description("Cruz Alta - RS")]
        CruzAlta = 4306106,

        [EnumValue("4306130")]
        [Description("Cruzaltense - RS")]
        Cruzaltense = 4306130,

        [EnumValue("4306205")]
        [Description("Cruzeiro do Sul - RS")]
        CruzeirodoSul_RS = 4306205,

        [EnumValue("4306304")]
        [Description("David Canabarro - RS")]
        DavidCanabarro = 4306304,

        [EnumValue("4306320")]
        [Description("Derrubadas - RS")]
        Derrubadas = 4306320,

        [EnumValue("4306353")]
        [Description("Dezesseis de Novembro - RS")]
        DezesseisdeNovembro = 4306353,

        [EnumValue("4306379")]
        [Description("Dilermando de Aguiar - RS")]
        DilermandodeAguiar = 4306379,

        [EnumValue("4306403")]
        [Description("Dois Irmaos - RS")]
        DoisIrmaos = 4306403,

        [EnumValue("4306429")]
        [Description("Dois Irmaos das Missoes - RS")]
        DoisIrmaosdasMissoes = 4306429,

        [EnumValue("4306452")]
        [Description("Dois Lajeados - RS")]
        DoisLajeados = 4306452,

        [EnumValue("4306502")]
        [Description("Dom Feliciano - RS")]
        DomFeliciano = 4306502,

        [EnumValue("4306551")]
        [Description("Dom Pedro de Alcantara - RS")]
        DomPedrodeAlcantara = 4306551,

        [EnumValue("4306601")]
        [Description("Dom Pedrito - RS")]
        DomPedrito = 4306601,

        [EnumValue("4306734")]
        [Description("Doutor Mauricio Cardoso - RS")]
        DoutorMauricioCardoso = 4306734,

        [EnumValue("4306759")]
        [Description("Doutor Ricardo - RS")]
        DoutorRicardo = 4306759,

        [EnumValue("4306767")]
        [Description("Eldorado do Sul - RS")]
        EldoradodoSul = 4306767,

        [EnumValue("4306809")]
        [Description("Encantado - RS")]
        Encantado = 4306809,

        [EnumValue("4306908")]
        [Description("Encruzilhada do Sul - RS")]
        EncruzilhadadoSul = 4306908,

        [EnumValue("4306924")]
        [Description("Engenho Velho - RS")]
        EngenhoVelho = 4306924,

        [EnumValue("4306932")]
        [Description("Entre-Ijuis - RS")]
        EntreIjuis = 4306932,

        [EnumValue("4306957")]
        [Description("Entre Rios do Sul - RS")]
        EntreRiosdoSul = 4306957,

        [EnumValue("4306973")]
        [Description("Erebango - RS")]
        Erebango = 4306973,

        [EnumValue("4307005")]
        [Description("Erechim - RS")]
        Erechim = 4307005,

        [EnumValue("4307054")]
        [Description("Ernestina - RS")]
        Ernestina = 4307054,

        [EnumValue("4307104")]
        [Description("Herval - RS")]
        Herval = 4307104,

        [EnumValue("4307302")]
        [Description("Erval Seco - RS")]
        ErvalSeco = 4307302,

        [EnumValue("4307450")]
        [Description("Esperanca do Sul - RS")]
        EsperancadoSul = 4307450,

        [EnumValue("4307500")]
        [Description("Espumoso - RS")]
        Espumoso = 4307500,

        [EnumValue("4307559")]
        [Description("Estacao - RS")]
        Estacao = 4307559,

        [EnumValue("4307609")]
        [Description("Estancia Velha - RS")]
        EstanciaVelha = 4307609,

        [EnumValue("4307708")]
        [Description("Esteio - RS")]
        Esteio = 4307708,

        [EnumValue("4307807")]
        [Description("Estrela - RS")]
        Estrela = 4307807,

        [EnumValue("4307815")]
        [Description("Estrela Velha - RS")]
        EstrelaVelha = 4307815,

        [EnumValue("4307831")]
        [Description("Eugenio de Castro - RS")]
        EugeniodeCastro = 4307831,

        [EnumValue("4307864")]
        [Description("Fagundes Varela - RS")]
        FagundesVarela = 4307864,

        [EnumValue("4307906")]
        [Description("Farroupilha - RS")]
        Farroupilha = 4307906,

        [EnumValue("4308003")]
        [Description("Faxinal do Soturno - RS")]
        FaxinaldoSoturno = 4308003,

        [EnumValue("4308052")]
        [Description("Faxinalzinho - RS")]
        Faxinalzinho = 4308052,

        [EnumValue("4308078")]
        [Description("Fazenda Vilanova - RS")]
        FazendaVilanova = 4308078,

        [EnumValue("4308102")]
        [Description("Feliz - RS")]
        Feliz = 4308102,

        [EnumValue("4308201")]
        [Description("Flores da Cunha - RS")]
        FloresdaCunha = 4308201,

        [EnumValue("4308250")]
        [Description("Floriano Peixoto - RS")]
        FlorianoPeixoto = 4308250,

        [EnumValue("4308300")]
        [Description("Fontoura Xavier - RS")]
        FontouraXavier = 4308300,

        [EnumValue("4308409")]
        [Description("Formigueiro - RS")]
        Formigueiro = 4308409,

        [EnumValue("4308433")]
        [Description("Forquetinha - RS")]
        Forquetinha = 4308433,

        [EnumValue("4308458")]
        [Description("Fortaleza dos Valos - RS")]
        FortalezadosValos = 4308458,

        [EnumValue("4308508")]
        [Description("Frederico Westphalen - RS")]
        FredericoWestphalen = 4308508,

        [EnumValue("4308607")]
        [Description("Garibaldi - RS")]
        Garibaldi = 4308607,

        [EnumValue("4308656")]
        [Description("Garruchos - RS")]
        Garruchos = 4308656,

        [EnumValue("4308706")]
        [Description("Gaurama - RS")]
        Gaurama = 4308706,

        [EnumValue("4308805")]
        [Description("General Camara - RS")]
        GeneralCamara = 4308805,

        [EnumValue("4308904")]
        [Description("Getulio Vargas - RS")]
        GetulioVargas = 4308904,

        [EnumValue("4309001")]
        [Description("Girua - RS")]
        Girua = 4309001,

        [EnumValue("4309050")]
        [Description("Glorinha - RS")]
        Glorinha = 4309050,

        [EnumValue("4309100")]
        [Description("Gramado - RS")]
        Gramado = 4309100,

        [EnumValue("4309126")]
        [Description("Gramado dos Loureiros - RS")]
        GramadodosLoureiros = 4309126,

        [EnumValue("4309159")]
        [Description("Gramado Xavier - RS")]
        GramadoXavier = 4309159,

        [EnumValue("4309209")]
        [Description("Gravatai - RS")]
        Gravatai = 4309209,

        [EnumValue("4309258")]
        [Description("Guabiju - RS")]
        Guabiju = 4309258,

        [EnumValue("4309308")]
        [Description("Guaiba - RS")]
        Guaiba = 4309308,

        [EnumValue("4309407")]
        [Description("Guapore - RS")]
        Guapore = 4309407,

        [EnumValue("4309506")]
        [Description("Guarani das Missoes - RS")]
        GuaranidasMissoes = 4309506,

        [EnumValue("4309555")]
        [Description("Harmonia - RS")]
        Harmonia = 4309555,

        [EnumValue("4309571")]
        [Description("Herveiras - RS")]
        Herveiras = 4309571,

        [EnumValue("4309605")]
        [Description("Horizontina - RS")]
        Horizontina = 4309605,

        [EnumValue("4309654")]
        [Description("Hulha Negra - RS")]
        HulhaNegra = 4309654,

        [EnumValue("4309704")]
        [Description("Humaita - RS")]
        Humaita_RS = 4309704,

        [EnumValue("4309753")]
        [Description("Ibarama - RS")]
        Ibarama = 4309753,

        [EnumValue("4309803")]
        [Description("Ibiaca - RS")]
        Ibiaca = 4309803,

        [EnumValue("4309902")]
        [Description("Ibiraiaras - RS")]
        Ibiraiaras = 4309902,

        [EnumValue("4309951")]
        [Description("Ibirapuita - RS")]
        Ibirapuita = 4309951,

        [EnumValue("4310009")]
        [Description("Ibiruba - RS")]
        Ibiruba = 4310009,

        [EnumValue("4310108")]
        [Description("Igrejinha - RS")]
        Igrejinha = 4310108,

        [EnumValue("4310207")]
        [Description("Ijui - RS")]
        Ijui = 4310207,

        [EnumValue("4310306")]
        [Description("Ilopolis - RS")]
        Ilopolis = 4310306,

        [EnumValue("4310330")]
        [Description("Imbe - RS")]
        Imbe = 4310330,

        [EnumValue("4310363")]
        [Description("Imigrante - RS")]
        Imigrante = 4310363,

        [EnumValue("4310405")]
        [Description("Independencia - RS")]
        Independencia_RS = 4310405,

        [EnumValue("4310413")]
        [Description("Inhacora - RS")]
        Inhacora = 4310413,

        [EnumValue("4310439")]
        [Description("Ipe - RS")]
        Ipe = 4310439,

        [EnumValue("4310462")]
        [Description("Ipiranga do Sul - RS")]
        IpirangadoSul = 4310462,

        [EnumValue("4310504")]
        [Description("Irai - RS")]
        Irai = 4310504,

        [EnumValue("4310538")]
        [Description("Itaara - RS")]
        Itaara = 4310538,

        [EnumValue("4310553")]
        [Description("Itacurubi - RS")]
        Itacurubi = 4310553,

        [EnumValue("4310579")]
        [Description("Itapuca - RS")]
        Itapuca = 4310579,

        [EnumValue("4310603")]
        [Description("Itaqui - RS")]
        Itaqui = 4310603,

        [EnumValue("4310652")]
        [Description("Itati - RS")]
        Itati = 4310652,

        [EnumValue("4310751")]
        [Description("Ivora - RS")]
        Ivora = 4310751,

        [EnumValue("4310801")]
        [Description("Ivoti - RS")]
        Ivoti = 4310801,

        [EnumValue("4310850")]
        [Description("Jaboticaba - RS")]
        Jaboticaba = 4310850,

        [EnumValue("4310876")]
        [Description("Jacuizinho - RS")]
        Jacuizinho = 4310876,

        [EnumValue("4310900")]
        [Description("Jacutinga - RS")]
        Jacutinga_RS = 4310900,

        [EnumValue("4311007")]
        [Description("Jaguarao - RS")]
        Jaguarao = 4311007,

        [EnumValue("4311106")]
        [Description("Jaguari - RS")]
        Jaguari = 4311106,

        [EnumValue("4311122")]
        [Description("Jaquirana - RS")]
        Jaquirana = 4311122,

        [EnumValue("4311130")]
        [Description("Jari - RS")]
        Jari = 4311130,

        [EnumValue("4311205")]
        [Description("Julio de Castilhos - RS")]
        JuliodeCastilhos = 4311205,

        [EnumValue("4311239")]
        [Description("Lagoa Bonita do Sul - RS")]
        LagoaBonitadoSul = 4311239,

        [EnumValue("4311270")]
        [Description("Lagoa dos Tres Cantos - RS")]
        LagoadosTresCantos = 4311270,

        [EnumValue("4311304")]
        [Description("Lagoa Vermelha - RS")]
        LagoaVermelha = 4311304,

        [EnumValue("4311403")]
        [Description("Lajeado - RS")]
        Lajeado = 4311403,

        [EnumValue("4311429")]
        [Description("Lajeado do Bugre - RS")]
        LajeadodoBugre = 4311429,

        [EnumValue("4311502")]
        [Description("Lavras do Sul - RS")]
        LavrasdoSul = 4311502,

        [EnumValue("4311601")]
        [Description("Liberato Salzano - RS")]
        LiberatoSalzano = 4311601,

        [EnumValue("4311627")]
        [Description("Lindolfo Collor - RS")]
        LindolfoCollor = 4311627,

        [EnumValue("4311643")]
        [Description("Linha Nova - RS")]
        LinhaNova = 4311643,

        [EnumValue("4311700")]
        [Description("Machadinho - RS")]
        Machadinho = 4311700,

        [EnumValue("4311718")]
        [Description("Macambara - RS")]
        Macambara = 4311718,

        [EnumValue("4311734")]
        [Description("Mampituba - RS")]
        Mampituba = 4311734,

        [EnumValue("4311759")]
        [Description("Manoel Viana - RS")]
        ManoelViana = 4311759,

        [EnumValue("4311775")]
        [Description("Maquine - RS")]
        Maquine = 4311775,

        [EnumValue("4311791")]
        [Description("Marata - RS")]
        Marata = 4311791,

        [EnumValue("4311809")]
        [Description("Marau - RS")]
        Marau_RS = 4311809,

        [EnumValue("4311908")]
        [Description("Marcelino Ramos - RS")]
        MarcelinoRamos = 4311908,

        [EnumValue("4311981")]
        [Description("Mariana Pimentel - RS")]
        MarianaPimentel = 4311981,

        [EnumValue("4312005")]
        [Description("Mariano Moro - RS")]
        MarianoMoro = 4312005,

        [EnumValue("4312054")]
        [Description("Marques de Souza - RS")]
        MarquesdeSouza = 4312054,

        [EnumValue("4312104")]
        [Description("Mata - RS")]
        Mata = 4312104,

        [EnumValue("4312138")]
        [Description("Mato Castelhano - RS")]
        MatoCastelhano = 4312138,

        [EnumValue("4312153")]
        [Description("Mato Leitao - RS")]
        MatoLeitao = 4312153,

        [EnumValue("4312179")]
        [Description("Mato Queimado - RS")]
        MatoQueimado = 4312179,

        [EnumValue("4312203")]
        [Description("Maximiliano de Almeida - RS")]
        MaximilianodeAlmeida = 4312203,

        [EnumValue("4312252")]
        [Description("Minas do Leao - RS")]
        MinasdoLeao = 4312252,

        [EnumValue("4312302")]
        [Description("Miraguai - RS")]
        Miraguai = 4312302,

        [EnumValue("4312377")]
        [Description("Monte Alegre dos Campos - RS")]
        MonteAlegredosCampos = 4312377,

        [EnumValue("4312385")]
        [Description("Monte Belo do Sul - RS")]
        MonteBelodoSul = 4312385,

        [EnumValue("4312401")]
        [Description("Montenegro - RS")]
        Montenegro_RS = 4312401,

        [EnumValue("4312427")]
        [Description("Mormaco - RS")]
        Mormaco = 4312427,

        [EnumValue("4312443")]
        [Description("Morrinhos do Sul - RS")]
        MorrinhosdoSul = 4312443,

        [EnumValue("4312450")]
        [Description("Morro Redondo - RS")]
        MorroRedondo = 4312450,

        [EnumValue("4312476")]
        [Description("Morro Reuter - RS")]
        MorroReuter = 4312476,

        [EnumValue("4312500")]
        [Description("Mostardas - RS")]
        Mostardas = 4312500,

        [EnumValue("4312609")]
        [Description("Mucum - RS")]
        Mucum = 4312609,

        [EnumValue("4312617")]
        [Description("Muitos Capoes - RS")]
        MuitosCapoes = 4312617,

        [EnumValue("4312658")]
        [Description("Nao-Me-Toque - RS")]
        NaoMeToque = 4312658,

        [EnumValue("4312674")]
        [Description("Nicolau Vergueiro - RS")]
        NicolauVergueiro = 4312674,

        [EnumValue("4312708")]
        [Description("Nonoai - RS")]
        Nonoai = 4312708,

        [EnumValue("4312757")]
        [Description("Nova Alvorada - RS")]
        NovaAlvorada = 4312757,

        [EnumValue("4312807")]
        [Description("Nova Araca - RS")]
        NovaAraca = 4312807,

        [EnumValue("4312906")]
        [Description("Nova Bassano - RS")]
        NovaBassano = 4312906,

        [EnumValue("4312955")]
        [Description("Nova Boa Vista - RS")]
        NovaBoaVista = 4312955,

        [EnumValue("4313003")]
        [Description("Nova Brescia - RS")]
        NovaBrescia = 4313003,

        [EnumValue("4313011")]
        [Description("Nova Candelaria - RS")]
        NovaCandelaria = 4313011,

        [EnumValue("4313037")]
        [Description("Nova Esperanca do Sul - RS")]
        NovaEsperancadoSul = 4313037,

        [EnumValue("4313060")]
        [Description("Nova Hartz - RS")]
        NovaHartz = 4313060,

        [EnumValue("4313086")]
        [Description("Nova Padua - RS")]
        NovaPadua = 4313086,

        [EnumValue("4313102")]
        [Description("Nova Palma - RS")]
        NovaPalma = 4313102,

        [EnumValue("4313201")]
        [Description("Nova Petropolis - RS")]
        NovaPetropolis = 4313201,

        [EnumValue("4313300")]
        [Description("Nova Prata - RS")]
        NovaPrata = 4313300,

        [EnumValue("4313359")]
        [Description("Nova Roma do Sul - RS")]
        NovaRomadoSul = 4313359,

        [EnumValue("4313375")]
        [Description("Nova Santa Rita - RS")]
        NovaSantaRita_RS = 4313375,

        [EnumValue("4313391")]
        [Description("Novo Cabrais - RS")]
        NovoCabrais = 4313391,

        [EnumValue("4313409")]
        [Description("Novo Hamburgo - RS")]
        NovoHamburgo = 4313409,

        [EnumValue("4313425")]
        [Description("Novo Machado - RS")]
        NovoMachado = 4313425,

        [EnumValue("4313441")]
        [Description("Novo Tiradentes - RS")]
        NovoTiradentes = 4313441,

        [EnumValue("4313466")]
        [Description("Novo Xingu - RS")]
        NovoXingu = 4313466,

        [EnumValue("4313490")]
        [Description("Novo Barreiro - RS")]
        NovoBarreiro = 4313490,

        [EnumValue("4313508")]
        [Description("Osorio - RS")]
        Osorio = 4313508,

        [EnumValue("4313656")]
        [Description("Palmares do Sul - RS")]
        PalmaresdoSul = 4313656,

        [EnumValue("4313706")]
        [Description("Palmeira das Missoes - RS")]
        PalmeiradasMissoes = 4313706,

        [EnumValue("4313805")]
        [Description("Palmitinho - RS")]
        Palmitinho = 4313805,

        [EnumValue("4313904")]
        [Description("Panambi - RS")]
        Panambi = 4313904,

        [EnumValue("4313953")]
        [Description("Pantano Grande - RS")]
        PantanoGrande = 4313953,

        [EnumValue("4314001")]
        [Description("Parai - RS")]
        Parai = 4314001,

        [EnumValue("4314027")]
        [Description("Paraiso do Sul - RS")]
        ParaisodoSul = 4314027,

        [EnumValue("4314035")]
        [Description("Pareci Novo - RS")]
        PareciNovo = 4314035,

        [EnumValue("4314050")]
        [Description("Parobe - RS")]
        Parobe = 4314050,

        [EnumValue("4314076")]
        [Description("Passo do Sobrado - RS")]
        PassodoSobrado = 4314076,

        [EnumValue("4314100")]
        [Description("Passo Fundo - RS")]
        PassoFundo = 4314100,

        [EnumValue("4314134")]
        [Description("Paulo Bento - RS")]
        PauloBento = 4314134,

        [EnumValue("4314159")]
        [Description("Paverama - RS")]
        Paverama = 4314159,

        [EnumValue("4314175")]
        [Description("Pedras Altas - RS")]
        PedrasAltas = 4314175,

        [EnumValue("4314209")]
        [Description("Pedro Osorio - RS")]
        PedroOsorio = 4314209,

        [EnumValue("4314308")]
        [Description("Pejucara - RS")]
        Pejucara = 4314308,

        [EnumValue("4314407")]
        [Description("Pelotas - RS")]
        Pelotas = 4314407,

        [EnumValue("4314423")]
        [Description("Picada Cafe - RS")]
        PicadaCafe = 4314423,

        [EnumValue("4314456")]
        [Description("Pinhal - RS")]
        Pinhal = 4314456,

        [EnumValue("4314464")]
        [Description("Pinhal da Serra - RS")]
        PinhaldaSerra = 4314464,

        [EnumValue("4314472")]
        [Description("Pinhal Grande - RS")]
        PinhalGrande = 4314472,

        [EnumValue("4314498")]
        [Description("Pinheirinho do Vale - RS")]
        PinheirinhodoVale = 4314498,

        [EnumValue("4314506")]
        [Description("Pinheiro Machado - RS")]
        PinheiroMachado = 4314506,

        [EnumValue("4314548")]
        [Description("Pinto Bandeira - RS")]
        PintoBandeira = 4314548,

        [EnumValue("4314555")]
        [Description("Pirapo - RS")]
        Pirapo = 4314555,

        [EnumValue("4314605")]
        [Description("Piratini - RS")]
        Piratini = 4314605,

        [EnumValue("4314704")]
        [Description("Planalto - RS")]
        Planalto_RS = 4314704,

        [EnumValue("4314753")]
        [Description("Poco das Antas - RS")]
        PocodasAntas = 4314753,

        [EnumValue("4314779")]
        [Description("Pontao - RS")]
        Pontao = 4314779,

        [EnumValue("4314787")]
        [Description("Ponte Preta - RS")]
        PontePreta = 4314787,

        [EnumValue("4314803")]
        [Description("Portao - RS")]
        Portao = 4314803,

        [EnumValue("4314902")]
        [Description("Porto Alegre - RS")]
        PortoAlegre = 4314902,

        [EnumValue("4315008")]
        [Description("Porto Lucena - RS")]
        PortoLucena = 4315008,

        [EnumValue("4315057")]
        [Description("Porto Maua - RS")]
        PortoMaua = 4315057,

        [EnumValue("4315073")]
        [Description("Porto Vera Cruz - RS")]
        PortoVeraCruz = 4315073,

        [EnumValue("4315107")]
        [Description("Porto Xavier - RS")]
        PortoXavier = 4315107,

        [EnumValue("4315131")]
        [Description("Pouso Novo - RS")]
        PousoNovo = 4315131,

        [EnumValue("4315149")]
        [Description("Presidente Lucena - RS")]
        PresidenteLucena = 4315149,

        [EnumValue("4315156")]
        [Description("Progresso - RS")]
        Progresso = 4315156,

        [EnumValue("4315172")]
        [Description("Protasio Alves - RS")]
        ProtasioAlves = 4315172,

        [EnumValue("4315206")]
        [Description("Putinga - RS")]
        Putinga = 4315206,

        [EnumValue("4315305")]
        [Description("Quarai - RS")]
        Quarai = 4315305,

        [EnumValue("4315313")]
        [Description("Quatro Irmaos - RS")]
        QuatroIrmaos = 4315313,

        [EnumValue("4315354")]
        [Description("Quinze de Novembro - RS")]
        QuinzedeNovembro = 4315354,

        [EnumValue("4315404")]
        [Description("Redentora - RS")]
        Redentora = 4315404,

        [EnumValue("4315453")]
        [Description("Relvado - RS")]
        Relvado = 4315453,

        [EnumValue("4315503")]
        [Description("Restinga Seca - RS")]
        RestingaSeca = 4315503,

        [EnumValue("4315552")]
        [Description("Rio dos Indios - RS")]
        RiodosIndios = 4315552,

        [EnumValue("4315602")]
        [Description("Rio Grande - RS")]
        RioGrande = 4315602,

        [EnumValue("4315701")]
        [Description("Rio Pardo - RS")]
        RioPardo = 4315701,

        [EnumValue("4315750")]
        [Description("Riozinho - RS")]
        Riozinho = 4315750,

        [EnumValue("4315800")]
        [Description("Roca Sales - RS")]
        RocaSales = 4315800,

        [EnumValue("4315909")]
        [Description("Rodeio Bonito - RS")]
        RodeioBonito = 4315909,

        [EnumValue("4315958")]
        [Description("Rolador - RS")]
        Rolador = 4315958,

        [EnumValue("4316006")]
        [Description("Rolante - RS")]
        Rolante = 4316006,

        [EnumValue("4316105")]
        [Description("Ronda Alta - RS")]
        RondaAlta = 4316105,

        [EnumValue("4316204")]
        [Description("Rondinha - RS")]
        Rondinha = 4316204,

        [EnumValue("4316303")]
        [Description("Roque Gonzales - RS")]
        RoqueGonzales = 4316303,

        [EnumValue("4316402")]
        [Description("Rosario do Sul - RS")]
        RosariodoSul = 4316402,

        [EnumValue("4316428")]
        [Description("Sagrada Familia - RS")]
        SagradaFamilia = 4316428,

        [EnumValue("4316436")]
        [Description("Saldanha Marinho - RS")]
        SaldanhaMarinho = 4316436,

        [EnumValue("4316451")]
        [Description("Salto do Jacui - RS")]
        SaltodoJacui = 4316451,

        [EnumValue("4316477")]
        [Description("Salvador das Missoes - RS")]
        SalvadordasMissoes = 4316477,

        [EnumValue("4316501")]
        [Description("Salvador do Sul - RS")]
        SalvadordoSul = 4316501,

        [EnumValue("4316600")]
        [Description("Sananduva - RS")]
        Sananduva = 4316600,

        [EnumValue("4316733")]
        [Description("Santa Cecilia do Sul - RS")]
        SantaCeciliadoSul = 4316733,

        [EnumValue("4316758")]
        [Description("Santa Clara do Sul - RS")]
        SantaClaradoSul = 4316758,

        [EnumValue("4316808")]
        [Description("Santa Cruz do Sul - RS")]
        SantaCruzdoSul = 4316808,

        [EnumValue("4316907")]
        [Description("Santa Maria - RS")]
        SantaMaria_RS = 4316907,

        [EnumValue("4316956")]
        [Description("Santa Maria do Herval - RS")]
        SantaMariadoHerval = 4316956,

        [EnumValue("4316972")]
        [Description("Santa Margarida do Sul - RS")]
        SantaMargaridadoSul = 4316972,

        [EnumValue("4317004")]
        [Description("Santana da Boa Vista - RS")]
        SantanadaBoaVista = 4317004,

        [EnumValue("4317103")]
        [Description("SantAna do Livramento - RS")]
        SantAnadoLivramento = 4317103,

        [EnumValue("4317202")]
        [Description("Santa Rosa - RS")]
        SantaRosa = 4317202,

        [EnumValue("4317251")]
        [Description("Santa Tereza - RS")]
        SantaTereza = 4317251,

        [EnumValue("4317301")]
        [Description("Santa Vitoria do Palmar - RS")]
        SantaVitoriadoPalmar = 4317301,

        [EnumValue("4317400")]
        [Description("Santiago - RS")]
        Santiago = 4317400,

        [EnumValue("4317509")]
        [Description("Santo Angelo - RS")]
        SantoAngelo = 4317509,

        [EnumValue("4317558")]
        [Description("Santo Antonio do Palma - RS")]
        SantoAntoniodoPalma = 4317558,

        [EnumValue("4317608")]
        [Description("Santo Antonio da Patrulha - RS")]
        SantoAntoniodaPatrulha = 4317608,

        [EnumValue("4317707")]
        [Description("Santo Antonio das Missoes - RS")]
        SantoAntoniodasMissoes = 4317707,

        [EnumValue("4317756")]
        [Description("Santo Antonio do Planalto - RS")]
        SantoAntoniodoPlanalto = 4317756,

        [EnumValue("4317806")]
        [Description("Santo Augusto - RS")]
        SantoAugusto = 4317806,

        [EnumValue("4317905")]
        [Description("Santo Cristo - RS")]
        SantoCristo = 4317905,

        [EnumValue("4318002")]
        [Description("Sao Borja - RS")]
        SaoBorja = 4318002,

        [EnumValue("4318051")]
        [Description("Sao Domingos do Sul - RS")]
        SaoDomingosdoSul = 4318051,

        [EnumValue("4318101")]
        [Description("Sao Francisco de Assis - RS")]
        SaoFranciscodeAssis = 4318101,

        [EnumValue("4318200")]
        [Description("Sao Francisco de Paula - RS")]
        SaoFranciscodePaula_RS = 4318200,

        [EnumValue("4318309")]
        [Description("Sao Gabriel - RS")]
        SaoGabriel_RS = 4318309,

        [EnumValue("4318408")]
        [Description("Sao Jeronimo - RS")]
        SaoJeronimo = 4318408,

        [EnumValue("4318424")]
        [Description("Sao Joao da Urtiga - RS")]
        SaoJoaodaUrtiga = 4318424,

        [EnumValue("4318432")]
        [Description("Sao Joao do Polesine - RS")]
        SaoJoaodoPolesine = 4318432,

        [EnumValue("4318440")]
        [Description("Sao Jorge - RS")]
        SaoJorge = 4318440,

        [EnumValue("4318457")]
        [Description("Sao Jose das Missoes - RS")]
        SaoJosedasMissoes = 4318457,

        [EnumValue("4318465")]
        [Description("Sao Jose do Herval - RS")]
        SaoJosedoHerval = 4318465,

        [EnumValue("4318481")]
        [Description("Sao Jose do Hortencio - RS")]
        SaoJosedoHortencio = 4318481,

        [EnumValue("4318499")]
        [Description("Sao Jose do Inhacora - RS")]
        SaoJosedoInhacora = 4318499,

        [EnumValue("4318507")]
        [Description("Sao Jose do Norte - RS")]
        SaoJosedoNorte = 4318507,

        [EnumValue("4318606")]
        [Description("Sao Jose do Ouro - RS")]
        SaoJosedoOuro = 4318606,

        [EnumValue("4318614")]
        [Description("Sao Jose do Sul - RS")]
        SaoJosedoSul = 4318614,

        [EnumValue("4318622")]
        [Description("Sao Jose dos Ausentes - RS")]
        SaoJosedosAusentes = 4318622,

        [EnumValue("4318705")]
        [Description("Sao Leopoldo - RS")]
        SaoLeopoldo = 4318705,

        [EnumValue("4318804")]
        [Description("Sao Lourenco do Sul - RS")]
        SaoLourencodoSul = 4318804,

        [EnumValue("4318903")]
        [Description("Sao Luiz Gonzaga - RS")]
        SaoLuizGonzaga = 4318903,

        [EnumValue("4319000")]
        [Description("Sao Marcos - RS")]
        SaoMarcos = 4319000,

        [EnumValue("4319109")]
        [Description("Sao Martinho - RS")]
        SaoMartinho = 4319109,

        [EnumValue("4319125")]
        [Description("Sao Martinho da Serra - RS")]
        SaoMartinhodaSerra = 4319125,

        [EnumValue("4319158")]
        [Description("Sao Miguel das Missoes - RS")]
        SaoMigueldasMissoes = 4319158,

        [EnumValue("4319208")]
        [Description("Sao Nicolau - RS")]
        SaoNicolau = 4319208,

        [EnumValue("4319307")]
        [Description("Sao Paulo das Missoes - RS")]
        SaoPaulodasMissoes = 4319307,

        [EnumValue("4319356")]
        [Description("Sao Pedro da Serra - RS")]
        SaoPedrodaSerra = 4319356,

        [EnumValue("4319364")]
        [Description("Sao Pedro das Missoes - RS")]
        SaoPedrodasMissoes = 4319364,

        [EnumValue("4319372")]
        [Description("Sao Pedro do Butia - RS")]
        SaoPedrodoButia = 4319372,

        [EnumValue("4319406")]
        [Description("Sao Pedro do Sul - RS")]
        SaoPedrodoSul = 4319406,

        [EnumValue("4319505")]
        [Description("Sao Sebastiao do Cai - RS")]
        SaoSebastiaodoCai = 4319505,

        [EnumValue("4319604")]
        [Description("Sao Sepe - RS")]
        SaoSepe = 4319604,

        [EnumValue("4319703")]
        [Description("Sao Valentim - RS")]
        SaoValentim = 4319703,

        [EnumValue("4319711")]
        [Description("Sao Valentim do Sul - RS")]
        SaoValentimdoSul = 4319711,

        [EnumValue("4319752")]
        [Description("Sao Vendelino - RS")]
        SaoVendelino = 4319752,

        [EnumValue("4319802")]
        [Description("Sao Vicente do Sul - RS")]
        SaoVicentedoSul = 4319802,

        [EnumValue("4319901")]
        [Description("Sapiranga - RS")]
        Sapiranga = 4319901,

        [EnumValue("4320008")]
        [Description("Sapucaia do Sul - RS")]
        SapucaiadoSul = 4320008,

        [EnumValue("4320107")]
        [Description("Sarandi - RS")]
        Sarandi_RS = 4320107,

        [EnumValue("4320206")]
        [Description("Seberi - RS")]
        Seberi = 4320206,

        [EnumValue("4320230")]
        [Description("Sede Nova - RS")]
        SedeNova = 4320230,

        [EnumValue("4320263")]
        [Description("Segredo - RS")]
        Segredo = 4320263,

        [EnumValue("4320305")]
        [Description("Selbach - RS")]
        Selbach = 4320305,

        [EnumValue("4320321")]
        [Description("Senador Salgado Filho - RS")]
        SenadorSalgadoFilho = 4320321,

        [EnumValue("4320354")]
        [Description("Sentinela do Sul - RS")]
        SentineladoSul = 4320354,

        [EnumValue("4320404")]
        [Description("Serafina Correa - RS")]
        SerafinaCorrea = 4320404,

        [EnumValue("4320453")]
        [Description("Serio - RS")]
        Serio = 4320453,

        [EnumValue("4320503")]
        [Description("Sertao - RS")]
        Sertao = 4320503,

        [EnumValue("4320552")]
        [Description("Sertao Santana - RS")]
        SertaoSantana = 4320552,

        [EnumValue("4320578")]
        [Description("Sete de Setembro - RS")]
        SetedeSetembro = 4320578,

        [EnumValue("4320602")]
        [Description("Severiano de Almeida - RS")]
        SeverianodeAlmeida = 4320602,

        [EnumValue("4320651")]
        [Description("Silveira Martins - RS")]
        SilveiraMartins = 4320651,

        [EnumValue("4320677")]
        [Description("Sinimbu - RS")]
        Sinimbu = 4320677,

        [EnumValue("4320701")]
        [Description("Sobradinho - RS")]
        Sobradinho_RS = 4320701,

        [EnumValue("4320800")]
        [Description("Soledade - RS")]
        Soledade_RS = 4320800,

        [EnumValue("4320909")]
        [Description("Tapejara - RS")]
        Tapejara_RS = 4320909,

        [EnumValue("4321006")]
        [Description("Tapera - RS")]
        Tapera = 4321006,

        [EnumValue("4321105")]
        [Description("Tapes - RS")]
        Tapes = 4321105,

        [EnumValue("4321204")]
        [Description("Taquara - RS")]
        Taquara = 4321204,

        [EnumValue("4321303")]
        [Description("Taquari - RS")]
        Taquari = 4321303,

        [EnumValue("4321329")]
        [Description("Taquarucu do Sul - RS")]
        TaquarucudoSul = 4321329,

        [EnumValue("4321352")]
        [Description("Tavares - RS")]
        Tavares_RS = 4321352,

        [EnumValue("4321402")]
        [Description("Tenente Portela - RS")]
        TenentePortela = 4321402,

        [EnumValue("4321436")]
        [Description("Terra de Areia - RS")]
        TerradeAreia = 4321436,

        [EnumValue("4321451")]
        [Description("Teutonia - RS")]
        Teutonia = 4321451,

        [EnumValue("4321469")]
        [Description("Tio Hugo - RS")]
        TioHugo = 4321469,

        [EnumValue("4321477")]
        [Description("Tiradentes do Sul - RS")]
        TiradentesdoSul = 4321477,

        [EnumValue("4321493")]
        [Description("Toropi - RS")]
        Toropi = 4321493,

        [EnumValue("4321501")]
        [Description("Torres - RS")]
        Torres = 4321501,

        [EnumValue("4321600")]
        [Description("Tramandai - RS")]
        Tramandai = 4321600,

        [EnumValue("4321626")]
        [Description("Travesseiro - RS")]
        Travesseiro = 4321626,

        [EnumValue("4321634")]
        [Description("Tres Arroios - RS")]
        TresArroios = 4321634,

        [EnumValue("4321667")]
        [Description("Tres Cachoeiras - RS")]
        TresCachoeiras = 4321667,

        [EnumValue("4321709")]
        [Description("Tres Coroas - RS")]
        TresCoroas = 4321709,

        [EnumValue("4321808")]
        [Description("Tres de Maio - RS")]
        TresdeMaio = 4321808,

        [EnumValue("4321832")]
        [Description("Tres Forquilhas - RS")]
        TresForquilhas = 4321832,

        [EnumValue("4321907")]
        [Description("Tres Passos - RS")]
        TresPassos = 4321907,

        [EnumValue("4321956")]
        [Description("Trindade do Sul - RS")]
        TrindadedoSul = 4321956,

        [EnumValue("4322004")]
        [Description("Triunfo - RS")]
        Triunfo_RS = 4322004,

        [EnumValue("4322103")]
        [Description("Tucunduva - RS")]
        Tucunduva = 4322103,

        [EnumValue("4322202")]
        [Description("Tupancireta - RS")]
        Tupancireta = 4322202,

        [EnumValue("4322251")]
        [Description("Tupandi - RS")]
        Tupandi = 4322251,

        [EnumValue("4322301")]
        [Description("Tuparendi - RS")]
        Tuparendi = 4322301,

        [EnumValue("4322327")]
        [Description("Turucu - RS")]
        Turucu = 4322327,

        [EnumValue("4322343")]
        [Description("Ubiretama - RS")]
        Ubiretama = 4322343,

        [EnumValue("4322350")]
        [Description("Uniao da Serra - RS")]
        UniaodaSerra = 4322350,

        [EnumValue("4322376")]
        [Description("Unistalda - RS")]
        Unistalda = 4322376,

        [EnumValue("4322400")]
        [Description("Uruguaiana - RS")]
        Uruguaiana = 4322400,

        [EnumValue("4322509")]
        [Description("Vacaria - RS")]
        Vacaria = 4322509,

        [EnumValue("4322525")]
        [Description("Vale Verde - RS")]
        ValeVerde = 4322525,

        [EnumValue("4322533")]
        [Description("Vale do Sol - RS")]
        ValedoSol = 4322533,

        [EnumValue("4322541")]
        [Description("Vale Real - RS")]
        ValeReal = 4322541,

        [EnumValue("4322558")]
        [Description("Vanini - RS")]
        Vanini = 4322558,

        [EnumValue("4322608")]
        [Description("Venancio Aires - RS")]
        VenancioAires = 4322608,

        [EnumValue("4322707")]
        [Description("Vera Cruz - RS")]
        VeraCruz_RS = 4322707,

        [EnumValue("4322806")]
        [Description("Veranopolis - RS")]
        Veranopolis = 4322806,

        [EnumValue("4322855")]
        [Description("Vespasiano Correa - RS")]
        VespasianoCorrea = 4322855,

        [EnumValue("4322905")]
        [Description("Viadutos - RS")]
        Viadutos = 4322905,

        [EnumValue("4323002")]
        [Description("Viamao - RS")]
        Viamao = 4323002,

        [EnumValue("4323101")]
        [Description("Vicente Dutra - RS")]
        VicenteDutra = 4323101,

        [EnumValue("4323200")]
        [Description("Victor Graeff - RS")]
        VictorGraeff = 4323200,

        [EnumValue("4323309")]
        [Description("Vila Flores - RS")]
        VilaFlores = 4323309,

        [EnumValue("4323358")]
        [Description("Vila Langaro - RS")]
        VilaLangaro = 4323358,

        [EnumValue("4323408")]
        [Description("Vila Maria - RS")]
        VilaMaria = 4323408,

        [EnumValue("4323457")]
        [Description("Vila Nova do Sul - RS")]
        VilaNovadoSul = 4323457,

        [EnumValue("4323507")]
        [Description("Vista Alegre - RS")]
        VistaAlegre = 4323507,

        [EnumValue("4323606")]
        [Description("Vista Alegre do Prata - RS")]
        VistaAlegredoPrata = 4323606,

        [EnumValue("4323705")]
        [Description("Vista Gaucha - RS")]
        VistaGaucha = 4323705,

        [EnumValue("4323754")]
        [Description("Vitoria das Missoes - RS")]
        VitoriadasMissoes = 4323754,

        [EnumValue("4323770")]
        [Description("Westfalia - RS")]
        Westfalia = 4323770,

        [EnumValue("4323804")]
        [Description("Xangri-la - RS")]
        Xangrila = 4323804,

        //======Santa Catarina======
        [EnumValue("4200051")]
        [Description("Abdon Batista - SC")]
        AbdonBatista = 4200051,

        [EnumValue("4200101")]
        [Description("Abelardo Luz - SC")]
        AbelardoLuz = 4200101,

        [EnumValue("4200200")]
        [Description("Agrolandia - SC")]
        Agrolandia = 4200200,

        [EnumValue("4200309")]
        [Description("Agronomica - SC")]
        Agronomica = 4200309,

        [EnumValue("4200408")]
        [Description("Agua Doce - SC")]
        AguaDoce = 4200408,

        [EnumValue("4200507")]
        [Description("Aguas de Chapeco - SC")]
        AguasdeChapeco = 4200507,

        [EnumValue("4200556")]
        [Description("Aguas Frias - SC")]
        AguasFrias = 4200556,

        [EnumValue("4200606")]
        [Description("Aguas Mornas - SC")]
        AguasMornas = 4200606,

        [EnumValue("4200705")]
        [Description("Alfredo Wagner - SC")]
        AlfredoWagner = 4200705,

        [EnumValue("4200754")]
        [Description("Alto Bela Vista - SC")]
        AltoBelaVista = 4200754,

        [EnumValue("4200804")]
        [Description("Anchieta - SC")]
        Anchieta_SC = 4200804,

        [EnumValue("4200903")]
        [Description("Angelina - SC")]
        Angelina = 4200903,

        [EnumValue("4201000")]
        [Description("Anita Garibaldi - SC")]
        AnitaGaribaldi = 4201000,

        [EnumValue("4201109")]
        [Description("Anitapolis - SC")]
        Anitapolis = 4201109,

        [EnumValue("4201208")]
        [Description("Antonio Carlos - SC")]
        AntonioCarlos_SC = 4201208,

        [EnumValue("4201257")]
        [Description("Apiuna - SC")]
        Apiuna = 4201257,

        [EnumValue("4201273")]
        [Description("Arabuta - SC")]
        Arabuta = 4201273,

        [EnumValue("4201307")]
        [Description("Araquari - SC")]
        Araquari = 4201307,

        [EnumValue("4201406")]
        [Description("Ararangua - SC")]
        Ararangua = 4201406,

        [EnumValue("4201505")]
        [Description("Armazem - SC")]
        Armazem = 4201505,

        [EnumValue("4201604")]
        [Description("Arroio Trinta - SC")]
        ArroioTrinta = 4201604,

        [EnumValue("4201653")]
        [Description("Arvoredo - SC")]
        Arvoredo = 4201653,

        [EnumValue("4201703")]
        [Description("Ascurra - SC")]
        Ascurra = 4201703,

        [EnumValue("4201802")]
        [Description("Atalanta - SC")]
        Atalanta = 4201802,

        [EnumValue("4201901")]
        [Description("Aurora - SC")]
        Aurora_SC = 4201901,

        [EnumValue("4201950")]
        [Description("Balneario Arroio do Silva - SC")]
        BalnearioArroiodoSilva = 4201950,

        [EnumValue("4202008")]
        [Description("Balneario Camboriu - SC")]
        BalnearioCamboriu = 4202008,

        [EnumValue("4202057")]
        [Description("Balneario Barra do Sul - SC")]
        BalnearioBarradoSul = 4202057,

        [EnumValue("4202073")]
        [Description("Balneario Gaivota - SC")]
        BalnearioGaivota = 4202073,

        [EnumValue("4202081")]
        [Description("Bandeirante - SC")]
        Bandeirante = 4202081,

        [EnumValue("4202099")]
        [Description("Barra Bonita - SC")]
        BarraBonita = 4202099,

        [EnumValue("4202107")]
        [Description("Barra Velha - SC")]
        BarraVelha = 4202107,

        [EnumValue("4202131")]
        [Description("Bela Vista do Toldo - SC")]
        BelaVistadoToldo = 4202131,

        [EnumValue("4202156")]
        [Description("Belmonte - SC")]
        Belmonte_SC = 4202156,

        [EnumValue("4202206")]
        [Description("Benedito Novo - SC")]
        BeneditoNovo = 4202206,

        [EnumValue("4202305")]
        [Description("Biguacu - SC")]
        Biguacu = 4202305,

        [EnumValue("4202404")]
        [Description("Blumenau - SC")]
        Blumenau = 4202404,

        [EnumValue("4202438")]
        [Description("Bocaina do Sul - SC")]
        BocainadoSul = 4202438,

        [EnumValue("4202453")]
        [Description("Bombinhas - SC")]
        Bombinhas = 4202453,

        [EnumValue("4202503")]
        [Description("Bom Jardim da Serra - SC")]
        BomJardimdaSerra = 4202503,

        [EnumValue("4202537")]
        [Description("Bom Jesus - SC")]
        BomJesus_SC = 4202537,

        [EnumValue("4202578")]
        [Description("Bom Jesus do Oeste - SC")]
        BomJesusdoOeste = 4202578,

        [EnumValue("4202602")]
        [Description("Bom Retiro - SC")]
        BomRetiro = 4202602,

        [EnumValue("4202701")]
        [Description("Botuvera - SC")]
        Botuvera = 4202701,

        [EnumValue("4202800")]
        [Description("Braco do Norte - SC")]
        BracodoNorte = 4202800,

        [EnumValue("4202859")]
        [Description("Braco do Trombudo - SC")]
        BracodoTrombudo = 4202859,

        [EnumValue("4202875")]
        [Description("Brunopolis - SC")]
        Brunopolis = 4202875,

        [EnumValue("4202909")]
        [Description("Brusque - SC")]
        Brusque = 4202909,

        [EnumValue("4203006")]
        [Description("Cacador - SC")]
        Cacador = 4203006,

        [EnumValue("4203105")]
        [Description("Caibi - SC")]
        Caibi = 4203105,

        [EnumValue("4203154")]
        [Description("Calmon - SC")]
        Calmon = 4203154,

        [EnumValue("4203204")]
        [Description("Camboriu - SC")]
        Camboriu = 4203204,

        [EnumValue("4203253")]
        [Description("Capao Alto - SC")]
        CapaoAlto = 4203253,

        [EnumValue("4203303")]
        [Description("Campo Alegre - SC")]
        CampoAlegre_SC = 4203303,

        [EnumValue("4203402")]
        [Description("Campo Belo do Sul - SC")]
        CampoBelodoSul = 4203402,

        [EnumValue("4203501")]
        [Description("Campo Ere - SC")]
        CampoEre = 4203501,

        [EnumValue("4203600")]
        [Description("Campos Novos - SC")]
        CamposNovos = 4203600,

        [EnumValue("4203709")]
        [Description("Canelinha - SC")]
        Canelinha = 4203709,

        [EnumValue("4203808")]
        [Description("Canoinhas - SC")]
        Canoinhas = 4203808,

        [EnumValue("4203907")]
        [Description("Capinzal - SC")]
        Capinzal = 4203907,

        [EnumValue("4203956")]
        [Description("Capivari de Baixo - SC")]
        CapivarideBaixo = 4203956,

        [EnumValue("4204004")]
        [Description("Catanduvas - SC")]
        Catanduvas_SC = 4204004,

        [EnumValue("4204103")]
        [Description("Caxambu do Sul - SC")]
        CaxambudoSul = 4204103,

        [EnumValue("4204152")]
        [Description("Celso Ramos - SC")]
        CelsoRamos = 4204152,

        [EnumValue("4204178")]
        [Description("Cerro Negro - SC")]
        CerroNegro = 4204178,

        [EnumValue("4204194")]
        [Description("Chapadao do Lageado - SC")]
        ChapadaodoLageado = 4204194,

        [EnumValue("4204202")]
        [Description("Chapeco - SC")]
        Chapeco = 4204202,

        [EnumValue("4204251")]
        [Description("Cocal do Sul - SC")]
        CocaldoSul = 4204251,

        [EnumValue("4204301")]
        [Description("Concordia - SC")]
        Concordia = 4204301,

        [EnumValue("4204350")]
        [Description("Cordilheira Alta - SC")]
        CordilheiraAlta = 4204350,

        [EnumValue("4204400")]
        [Description("Coronel Freitas - SC")]
        CoronelFreitas = 4204400,

        [EnumValue("4204459")]
        [Description("Coronel Martins - SC")]
        CoronelMartins = 4204459,

        [EnumValue("4204509")]
        [Description("Corupa - SC")]
        Corupa = 4204509,

        [EnumValue("4204558")]
        [Description("Correia Pinto - SC")]
        CorreiaPinto = 4204558,

        [EnumValue("4204608")]
        [Description("Criciuma - SC")]
        Criciuma = 4204608,

        [EnumValue("4204707")]
        [Description("Cunha Pora - SC")]
        CunhaPora = 4204707,

        [EnumValue("4204756")]
        [Description("Cunhatai - SC")]
        Cunhatai = 4204756,

        [EnumValue("4204806")]
        [Description("Curitibanos - SC")]
        Curitibanos = 4204806,

        [EnumValue("4204905")]
        [Description("Descanso - SC")]
        Descanso = 4204905,

        [EnumValue("4205001")]
        [Description("Dionisio Cerqueira - SC")]
        DionisioCerqueira = 4205001,

        [EnumValue("4205100")]
        [Description("Dona Emma - SC")]
        DonaEmma = 4205100,

        [EnumValue("4205175")]
        [Description("Entre Rios - SC")]
        EntreRios_SC = 4205175,

        [EnumValue("4205191")]
        [Description("Ermo - SC")]
        Ermo = 4205191,

        [EnumValue("4205209")]
        [Description("Erval Velho - SC")]
        ErvalVelho = 4205209,

        [EnumValue("4205308")]
        [Description("Faxinal dos Guedes - SC")]
        FaxinaldosGuedes = 4205308,

        [EnumValue("4205357")]
        [Description("Flor do Sertao - SC")]
        FlordoSertao = 4205357,

        [EnumValue("4205407")]
        [Description("Florianopolis - SC")]
        Florianopolis = 4205407,

        [EnumValue("4205431")]
        [Description("Formosa do Sul - SC")]
        FormosadoSul = 4205431,

        [EnumValue("4205456")]
        [Description("Forquilhinha - SC")]
        Forquilhinha = 4205456,

        [EnumValue("4205506")]
        [Description("Fraiburgo - SC")]
        Fraiburgo = 4205506,

        [EnumValue("4205555")]
        [Description("Frei Rogerio - SC")]
        FreiRogerio = 4205555,

        [EnumValue("4205605")]
        [Description("Galvao - SC")]
        Galvao = 4205605,

        [EnumValue("4205704")]
        [Description("Garopaba - SC")]
        Garopaba = 4205704,

        [EnumValue("4205803")]
        [Description("Garuva - SC")]
        Garuva = 4205803,

        [EnumValue("4205902")]
        [Description("Gaspar - SC")]
        Gaspar = 4205902,

        [EnumValue("4206009")]
        [Description("Governador Celso Ramos - SC")]
        GovernadorCelsoRamos = 4206009,

        [EnumValue("4206108")]
        [Description("Grao-Para - SC")]
        GraoPara = 4206108,

        [EnumValue("4206207")]
        [Description("Gravatal - SC")]
        Gravatal = 4206207,

        [EnumValue("4206306")]
        [Description("Guabiruba - SC")]
        Guabiruba = 4206306,

        [EnumValue("4206405")]
        [Description("Guaraciaba - SC")]
        Guaraciaba_SC = 4206405,

        [EnumValue("4206504")]
        [Description("Guaramirim - SC")]
        Guaramirim = 4206504,

        [EnumValue("4206603")]
        [Description("Guaruja do Sul - SC")]
        GuarujadoSul = 4206603,

        [EnumValue("4206652")]
        [Description("Guatambu - SC")]
        Guatambu = 4206652,

        [EnumValue("4206702")]
        [Description("Herval dOeste - SC")]
        HervaldOeste = 4206702,

        [EnumValue("4206751")]
        [Description("Ibiam - SC")]
        Ibiam = 4206751,

        [EnumValue("4206801")]
        [Description("Ibicare - SC")]
        Ibicare = 4206801,

        [EnumValue("4206900")]
        [Description("Ibirama - SC")]
        Ibirama = 4206900,

        [EnumValue("4207007")]
        [Description("Icara - SC")]
        Icara = 4207007,

        [EnumValue("4207106")]
        [Description("Ilhota - SC")]
        Ilhota = 4207106,

        [EnumValue("4207205")]
        [Description("Imarui - SC")]
        Imarui = 4207205,

        [EnumValue("4207304")]
        [Description("Imbituba - SC")]
        Imbituba = 4207304,

        [EnumValue("4207403")]
        [Description("Imbuia - SC")]
        Imbuia = 4207403,

        [EnumValue("4207502")]
        [Description("Indaial - SC")]
        Indaial = 4207502,

        [EnumValue("4207577")]
        [Description("Iomere - SC")]
        Iomere = 4207577,

        [EnumValue("4207601")]
        [Description("Ipira - SC")]
        Ipira_SC = 4207601,

        [EnumValue("4207650")]
        [Description("Ipora do Oeste - SC")]
        IporadoOeste = 4207650,

        [EnumValue("4207684")]
        [Description("Ipuacu - SC")]
        Ipuacu = 4207684,

        [EnumValue("4207700")]
        [Description("Ipumirim - SC")]
        Ipumirim = 4207700,

        [EnumValue("4207759")]
        [Description("Iraceminha - SC")]
        Iraceminha = 4207759,

        [EnumValue("4207809")]
        [Description("Irani - SC")]
        Irani = 4207809,

        [EnumValue("4207858")]
        [Description("Irati - SC")]
        Irati_SC = 4207858,

        [EnumValue("4207908")]
        [Description("Irineopolis - SC")]
        Irineopolis = 4207908,

        [EnumValue("4208005")]
        [Description("Ita - SC")]
        Ita = 4208005,

        [EnumValue("4208104")]
        [Description("Itaiopolis - SC")]
        Itaiopolis = 4208104,

        [EnumValue("4208203")]
        [Description("Itajai - SC")]
        Itajai = 4208203,

        [EnumValue("4208302")]
        [Description("Itapema - SC")]
        Itapema = 4208302,

        [EnumValue("4208401")]
        [Description("Itapiranga - SC")]
        Itapiranga_SC = 4208401,

        [EnumValue("4208450")]
        [Description("Itapoa - SC")]
        Itapoa = 4208450,

        [EnumValue("4208500")]
        [Description("Ituporanga - SC")]
        Ituporanga = 4208500,

        [EnumValue("4208609")]
        [Description("Jabora - SC")]
        Jabora = 4208609,

        [EnumValue("4208708")]
        [Description("Jacinto Machado - SC")]
        JacintoMachado = 4208708,

        [EnumValue("4208807")]
        [Description("Jaguaruna - SC")]
        Jaguaruna = 4208807,

        [EnumValue("4208906")]
        [Description("Jaragua do Sul - SC")]
        JaraguadoSul = 4208906,

        [EnumValue("4208955")]
        [Description("Jardinopolis - SC")]
        Jardinopolis = 4208955,

        [EnumValue("4209003")]
        [Description("Joacaba - SC")]
        Joacaba = 4209003,

        [EnumValue("4209102")]
        [Description("Joinville - SC")]
        Joinville = 4209102,

        [EnumValue("4209151")]
        [Description("Jose Boiteux - SC")]
        JoseBoiteux = 4209151,

        [EnumValue("4209177")]
        [Description("Jupia - SC")]
        Jupia = 4209177,

        [EnumValue("4209201")]
        [Description("Lacerdopolis - SC")]
        Lacerdopolis = 4209201,

        [EnumValue("4209300")]
        [Description("Lages - SC")]
        Lages = 4209300,

        [EnumValue("4209409")]
        [Description("Laguna - SC")]
        Laguna = 4209409,

        [EnumValue("4209458")]
        [Description("Lajeado Grande - SC")]
        LajeadoGrande = 4209458,

        [EnumValue("4209508")]
        [Description("Laurentino - SC")]
        Laurentino = 4209508,

        [EnumValue("4209607")]
        [Description("Lauro Muller - SC")]
        LauroMuller = 4209607,

        [EnumValue("4209706")]
        [Description("Lebon Regis - SC")]
        LebonRegis = 4209706,

        [EnumValue("4209805")]
        [Description("Leoberto Leal - SC")]
        LeobertoLeal = 4209805,

        [EnumValue("4209854")]
        [Description("Lindoia do Sul - SC")]
        LindoiadoSul = 4209854,

        [EnumValue("4209904")]
        [Description("Lontras - SC")]
        Lontras = 4209904,

        [EnumValue("4210001")]
        [Description("Luiz Alves - SC")]
        LuizAlves = 4210001,

        [EnumValue("4210035")]
        [Description("Luzerna - SC")]
        Luzerna = 4210035,

        [EnumValue("4210050")]
        [Description("Macieira - SC")]
        Macieira = 4210050,

        [EnumValue("4210100")]
        [Description("Mafra - SC")]
        Mafra = 4210100,

        [EnumValue("4210209")]
        [Description("Major Gercino - SC")]
        MajorGercino = 4210209,

        [EnumValue("4210308")]
        [Description("Major Vieira - SC")]
        MajorVieira = 4210308,

        [EnumValue("4210407")]
        [Description("Maracaja - SC")]
        Maracaja = 4210407,

        [EnumValue("4210506")]
        [Description("Maravilha - SC")]
        Maravilha_SC = 4210506,

        [EnumValue("4210555")]
        [Description("Marema - SC")]
        Marema = 4210555,

        [EnumValue("4210605")]
        [Description("Massaranduba - SC")]
        Massaranduba_SC = 4210605,

        [EnumValue("4210704")]
        [Description("Matos Costa - SC")]
        MatosCosta = 4210704,

        [EnumValue("4210803")]
        [Description("Meleiro - SC")]
        Meleiro = 4210803,

        [EnumValue("4210852")]
        [Description("Mirim Doce - SC")]
        MirimDoce = 4210852,

        [EnumValue("4210902")]
        [Description("Modelo - SC")]
        Modelo = 4210902,

        [EnumValue("4211009")]
        [Description("Mondai - SC")]
        Mondai = 4211009,

        [EnumValue("4211058")]
        [Description("Monte Carlo - SC")]
        MonteCarlo = 4211058,

        [EnumValue("4211108")]
        [Description("Monte Castelo - SC")]
        MonteCastelo = 4211108,

        [EnumValue("4211207")]
        [Description("Morro da Fumaca - SC")]
        MorrodaFumaca = 4211207,

        [EnumValue("4211256")]
        [Description("Morro Grande - SC")]
        MorroGrande = 4211256,

        [EnumValue("4211306")]
        [Description("Navegantes - SC")]
        Navegantes = 4211306,

        [EnumValue("4211405")]
        [Description("Nova Erechim - SC")]
        NovaErechim = 4211405,

        [EnumValue("4211454")]
        [Description("Nova Itaberaba - SC")]
        NovaItaberaba = 4211454,

        [EnumValue("4211504")]
        [Description("Nova Trento - SC")]
        NovaTrento = 4211504,

        [EnumValue("4211603")]
        [Description("Nova Veneza - SC")]
        NovaVeneza_SC = 4211603,

        [EnumValue("4211652")]
        [Description("Novo Horizonte - SC")]
        NovoHorizonte_SC = 4211652,

        [EnumValue("4211702")]
        [Description("Orleans - SC")]
        Orleans = 4211702,

        [EnumValue("4211751")]
        [Description("Otacilio Costa - SC")]
        OtacilioCosta = 4211751,

        [EnumValue("4211801")]
        [Description("Ouro - SC")]
        Ouro = 4211801,

        [EnumValue("4211876")]
        [Description("Paial - SC")]
        Paial = 4211876,

        [EnumValue("4211892")]
        [Description("Painel - SC")]
        Painel = 4211892,

        [EnumValue("4211900")]
        [Description("Palhoca - SC")]
        Palhoca = 4211900,

        [EnumValue("4212007")]
        [Description("Palma Sola - SC")]
        PalmaSola = 4212007,

        [EnumValue("4212056")]
        [Description("Palmeira - SC")]
        Palmeira_SC = 4212056,

        [EnumValue("4212106")]
        [Description("Palmitos - SC")]
        Palmitos = 4212106,

        [EnumValue("4212205")]
        [Description("Papanduva - SC")]
        Papanduva = 4212205,

        [EnumValue("4212239")]
        [Description("Paraiso - SC")]
        Paraiso = 4212239,

        [EnumValue("4212254")]
        [Description("Passo de Torres - SC")]
        PassodeTorres = 4212254,

        [EnumValue("4212270")]
        [Description("Passos Maia - SC")]
        PassosMaia = 4212270,

        [EnumValue("4212304")]
        [Description("Paulo Lopes - SC")]
        PauloLopes = 4212304,

        [EnumValue("4212403")]
        [Description("Pedras Grandes - SC")]
        PedrasGrandes = 4212403,

        [EnumValue("4212502")]
        [Description("Penha - SC")]
        Penha = 4212502,

        [EnumValue("4212601")]
        [Description("Peritiba - SC")]
        Peritiba = 4212601,

        [EnumValue("4212650")]
        [Description("Pescaria Brava - SC")]
        PescariaBrava = 4212650,

        [EnumValue("4212700")]
        [Description("Petrolandia - SC")]
        Petrolandia_SC = 4212700,

        [EnumValue("4212809")]
        [Description("Balneario Picarras - SC")]
        BalnearioPicarras = 4212809,

        [EnumValue("4212908")]
        [Description("Pinhalzinho - SC")]
        Pinhalzinho = 4212908,

        [EnumValue("4213005")]
        [Description("Pinheiro Preto - SC")]
        PinheiroPreto = 4213005,

        [EnumValue("4213104")]
        [Description("Piratuba - SC")]
        Piratuba = 4213104,

        [EnumValue("4213153")]
        [Description("Planalto Alegre - SC")]
        PlanaltoAlegre = 4213153,

        [EnumValue("4213203")]
        [Description("Pomerode - SC")]
        Pomerode = 4213203,

        [EnumValue("4213302")]
        [Description("Ponte Alta - SC")]
        PonteAlta = 4213302,

        [EnumValue("4213351")]
        [Description("Ponte Alta do Norte - SC")]
        PonteAltadoNorte = 4213351,

        [EnumValue("4213401")]
        [Description("Ponte Serrada - SC")]
        PonteSerrada = 4213401,

        [EnumValue("4213500")]
        [Description("Porto Belo - SC")]
        PortoBelo = 4213500,

        [EnumValue("4213609")]
        [Description("Porto Uniao - SC")]
        PortoUniao = 4213609,

        [EnumValue("4213708")]
        [Description("Pouso Redondo - SC")]
        PousoRedondo = 4213708,

        [EnumValue("4213807")]
        [Description("Praia Grande - SC")]
        PraiaGrande = 4213807,

        [EnumValue("4213906")]
        [Description("Presidente Castello Branco - SC")]
        PresidenteCastelloBranco = 4213906,

        [EnumValue("4214003")]
        [Description("Presidente Getulio - SC")]
        PresidenteGetulio = 4214003,

        [EnumValue("4214102")]
        [Description("Presidente Nereu - SC")]
        PresidenteNereu = 4214102,

        [EnumValue("4214151")]
        [Description("Princesa - SC")]
        Princesa = 4214151,

        [EnumValue("4214201")]
        [Description("Quilombo - SC")]
        Quilombo = 4214201,

        [EnumValue("4214300")]
        [Description("Rancho Queimado - SC")]
        RanchoQueimado = 4214300,

        [EnumValue("4214409")]
        [Description("Rio das Antas - SC")]
        RiodasAntas = 4214409,

        [EnumValue("4214508")]
        [Description("Rio do Campo - SC")]
        RiodoCampo = 4214508,

        [EnumValue("4214607")]
        [Description("Rio do Oeste - SC")]
        RiodoOeste = 4214607,

        [EnumValue("4214706")]
        [Description("Rio dos Cedros - SC")]
        RiodosCedros = 4214706,

        [EnumValue("4214805")]
        [Description("Rio do Sul - SC")]
        RiodoSul = 4214805,

        [EnumValue("4214904")]
        [Description("Rio Fortuna - SC")]
        RioFortuna = 4214904,

        [EnumValue("4215000")]
        [Description("Rio Negrinho - SC")]
        RioNegrinho = 4215000,

        [EnumValue("4215059")]
        [Description("Rio Rufino - SC")]
        RioRufino = 4215059,

        [EnumValue("4215075")]
        [Description("Riqueza - SC")]
        Riqueza = 4215075,

        [EnumValue("4215208")]
        [Description("Romelandia - SC")]
        Romelandia = 4215208,

        [EnumValue("4215307")]
        [Description("Salete - SC")]
        Salete = 4215307,

        [EnumValue("4215356")]
        [Description("Saltinho - SC")]
        Saltinho = 4215356,

        [EnumValue("4215406")]
        [Description("Salto Veloso - SC")]
        SaltoVeloso = 4215406,

        [EnumValue("4215455")]
        [Description("Sangao - SC")]
        Sangao = 4215455,

        [EnumValue("4215505")]
        [Description("Santa Cecilia - SC")]
        SantaCecilia_SC = 4215505,

        [EnumValue("4215554")]
        [Description("Santa Helena - SC")]
        SantaHelena_SC = 4215554,

        [EnumValue("4215604")]
        [Description("Santa Rosa de Lima - SC")]
        SantaRosadeLima = 4215604,

        [EnumValue("4215653")]
        [Description("Santa Rosa do Sul - SC")]
        SantaRosadoSul = 4215653,

        [EnumValue("4215679")]
        [Description("Santa Terezinha - SC")]
        SantaTerezinha_SC = 4215679,

        [EnumValue("4215687")]
        [Description("Santa Terezinha do Progresso - SC")]
        SantaTerezinhadoProgresso = 4215687,

        [EnumValue("4215695")]
        [Description("Santiago do Sul - SC")]
        SantiagodoSul = 4215695,

        [EnumValue("4215703")]
        [Description("Santo Amaro da Imperatriz - SC")]
        SantoAmarodaImperatriz = 4215703,

        [EnumValue("4215752")]
        [Description("Sao Bernardino - SC")]
        SaoBernardino = 4215752,

        [EnumValue("4215802")]
        [Description("Sao Bento do Sul - SC")]
        SaoBentodoSul = 4215802,

        [EnumValue("4215901")]
        [Description("Sao Bonifacio - SC")]
        SaoBonifacio = 4215901,

        [EnumValue("4216008")]
        [Description("Sao Carlos - SC")]
        SaoCarlos = 4216008,

        [EnumValue("4216057")]
        [Description("Sao Cristovao do Sul - SC")]
        SaoCristovaodoSul = 4216057,

        [EnumValue("4216107")]
        [Description("Sao Domingos - SC")]
        SaoDomingos_SC = 4216107,

        [EnumValue("4216206")]
        [Description("Sao Francisco do Sul - SC")]
        SaoFranciscodoSul = 4216206,

        [EnumValue("4216255")]
        [Description("Sao Joao do Oeste - SC")]
        SaoJoaodoOeste = 4216255,

        [EnumValue("4216305")]
        [Description("Sao Joao Batista - SC")]
        SaoJoaoBatista_SC = 4216305,

        [EnumValue("4216354")]
        [Description("Sao Joao do Itaperiu - SC")]
        SaoJoaodoItaperiu = 4216354,

        [EnumValue("4216404")]
        [Description("Sao Joao do Sul - SC")]
        SaoJoaodoSul = 4216404,

        [EnumValue("4216503")]
        [Description("Sao Joaquim - SC")]
        SaoJoaquim = 4216503,

        [EnumValue("4216602")]
        [Description("Sao Jose - SC")]
        SaoJose = 4216602,

        [EnumValue("4216701")]
        [Description("Sao Jose do Cedro - SC")]
        SaoJosedoCedro = 4216701,

        [EnumValue("4216800")]
        [Description("Sao Jose do Cerrito - SC")]
        SaoJosedoCerrito = 4216800,

        [EnumValue("4216909")]
        [Description("Sao Lourenco do Oeste - SC")]
        SaoLourencodoOeste = 4216909,

        [EnumValue("4217006")]
        [Description("Sao Ludgero - SC")]
        SaoLudgero = 4217006,

        [EnumValue("4217105")]
        [Description("Sao Martinho - SC")]
        SaoMartinho_SC = 4217105,

        [EnumValue("4217154")]
        [Description("Sao Miguel da Boa Vista - SC")]
        SaoMigueldaBoaVista = 4217154,

        [EnumValue("4217204")]
        [Description("Sao Miguel do Oeste - SC")]
        SaoMigueldoOeste = 4217204,

        [EnumValue("4217253")]
        [Description("Sao Pedro de Alcantara - SC")]
        SaoPedrodeAlcantara = 4217253,

        [EnumValue("4217303")]
        [Description("Saudades - SC")]
        Saudades = 4217303,

        [EnumValue("4217402")]
        [Description("Schroeder - SC")]
        Schroeder = 4217402,

        [EnumValue("4217501")]
        [Description("Seara - SC")]
        Seara = 4217501,

        [EnumValue("4217550")]
        [Description("Serra Alta - SC")]
        SerraAlta = 4217550,

        [EnumValue("4217600")]
        [Description("Sideropolis - SC")]
        Sideropolis = 4217600,

        [EnumValue("4217709")]
        [Description("Sombrio - SC")]
        Sombrio = 4217709,

        [EnumValue("4217758")]
        [Description("Sul Brasil - SC")]
        SulBrasil = 4217758,

        [EnumValue("4217808")]
        [Description("Taio - SC")]
        Taio = 4217808,

        [EnumValue("4217907")]
        [Description("Tangara - SC")]
        Tangara_SC = 4217907,

        [EnumValue("4217956")]
        [Description("Tigrinhos - SC")]
        Tigrinhos = 4217956,

        [EnumValue("4218004")]
        [Description("Tijucas - SC")]
        Tijucas = 4218004,

        [EnumValue("4218202")]
        [Description("Timbo - SC")]
        Timbo = 4218202,

        [EnumValue("4218251")]
        [Description("Timbo Grande - SC")]
        TimboGrande = 4218251,

        [EnumValue("4218301")]
        [Description("Tres Barras - SC")]
        TresBarras = 4218301,

        [EnumValue("4218350")]
        [Description("Treviso - SC")]
        Treviso = 4218350,

        [EnumValue("4218400")]
        [Description("Treze de Maio - SC")]
        TrezedeMaio = 4218400,

        [EnumValue("4218509")]
        [Description("Treze Tilias - SC")]
        TrezeTilias = 4218509,

        [EnumValue("4218608")]
        [Description("Trombudo Central - SC")]
        TrombudoCentral = 4218608,

        [EnumValue("4218707")]
        [Description("Tubarao - SC")]
        Tubarao = 4218707,

        [EnumValue("4218756")]
        [Description("Tunapolis - SC")]
        Tunapolis = 4218756,

        [EnumValue("4218806")]
        [Description("Turvo - SC")]
        Turvo_SC = 4218806,

        [EnumValue("4218855")]
        [Description("Uniao do Oeste - SC")]
        UniaodoOeste = 4218855,

        [EnumValue("4218905")]
        [Description("Urubici - SC")]
        Urubici = 4218905,

        [EnumValue("4218954")]
        [Description("Urupema - SC")]
        Urupema = 4218954,

        [EnumValue("4219002")]
        [Description("Urussanga - SC")]
        Urussanga = 4219002,

        [EnumValue("4219101")]
        [Description("Vargeao - SC")]
        Vargeao = 4219101,

        [EnumValue("4219150")]
        [Description("Vargem - SC")]
        Vargem = 4219150,

        [EnumValue("4219176")]
        [Description("Vargem Bonita - SC")]
        VargemBonita_SC = 4219176,

        [EnumValue("4219200")]
        [Description("Vidal Ramos - SC")]
        VidalRamos = 4219200,

        [EnumValue("4219309")]
        [Description("Videira - SC")]
        Videira = 4219309,

        [EnumValue("4219358")]
        [Description("Vitor Meireles - SC")]
        VitorMeireles = 4219358,

        [EnumValue("4219408")]
        [Description("Witmarsum - SC")]
        Witmarsum = 4219408,

        [EnumValue("4219507")]
        [Description("Xanxere - SC")]
        Xanxere = 4219507,

        [EnumValue("4219606")]
        [Description("Xavantina - SC")]
        Xavantina = 4219606,

        [EnumValue("4219705")]
        [Description("Xaxim - SC")]
        Xaxim = 4219705,

        [EnumValue("4219853")]
        [Description("Zortea - SC")]
        Zortea = 4219853,

        [EnumValue("4220000")]
        [Description("Balneario Rincao - SC")]
        BalnearioRincao = 4220000,

        //======Sergipe======
        [EnumValue("2800209")]
        [Description("Aquidaba - SE")]
        Aquidaba = 2800209,

        [EnumValue("2800308")]
        [Description("Aracaju - SE")]
        Aracaju = 2800308,

        [EnumValue("2800506")]
        [Description("Areia Branca - SE")]
        AreiaBranca_SE = 2800506,

        [EnumValue("2800605")]
        [Description("Barra dos Coqueiros - SE")]
        BarradosCoqueiros = 2800605,

        [EnumValue("2801009")]
        [Description("Campo do Brito - SE")]
        CampodoBrito = 2801009,

        [EnumValue("2801108")]
        [Description("Canhoba - SE")]
        Canhoba = 2801108,

        [EnumValue("2801504")]
        [Description("Carmopolis - SE")]
        Carmopolis = 2801504,

        [EnumValue("2801603")]
        [Description("Cedro de Sao Joao - SE")]
        CedrodeSaoJoao = 2801603,

        [EnumValue("2801900")]
        [Description("Cumbe - SE")]
        Cumbe = 2801900,

        [EnumValue("2802007")]
        [Description("Divina Pastora - SE")]
        DivinaPastora = 2802007,

        [EnumValue("2802106")]
        [Description("Estancia - SE")]
        Estancia = 2802106,

        [EnumValue("2802304")]
        [Description("Frei Paulo - SE")]
        FreiPaulo = 2802304,

        [EnumValue("2802601")]
        [Description("Graccho Cardoso - SE")]
        GracchoCardoso = 2802601,

        [EnumValue("2802809")]
        [Description("Indiaroba - SE")]
        Indiaroba = 2802809,

        [EnumValue("2802908")]
        [Description("Itabaiana - SE")]
        Itabaiana_SE = 2802908,

        [EnumValue("2803104")]
        [Description("Itabi - SE")]
        Itabi = 2803104,

        [EnumValue("2803302")]
        [Description("Japaratuba - SE")]
        Japaratuba = 2803302,

        [EnumValue("2803401")]
        [Description("Japoata - SE")]
        Japoata = 2803401,

        [EnumValue("2803500")]
        [Description("Lagarto - SE")]
        Lagarto = 2803500,

        [EnumValue("2803609")]
        [Description("Laranjeiras - SE")]
        Laranjeiras = 2803609,

        [EnumValue("2803708")]
        [Description("Macambira - SE")]
        Macambira = 2803708,

        [EnumValue("2803906")]
        [Description("Malhador - SE")]
        Malhador = 2803906,

        [EnumValue("2804003")]
        [Description("Maruim - SE")]
        Maruim = 2804003,

        [EnumValue("2804102")]
        [Description("Moita Bonita - SE")]
        MoitaBonita = 2804102,

        [EnumValue("2804201")]
        [Description("Monte Alegre de Sergipe - SE")]
        MonteAlegredeSergipe = 2804201,

        [EnumValue("2804300")]
        [Description("Muribeca - SE")]
        Muribeca = 2804300,

        [EnumValue("2804508")]
        [Description("Nossa Senhora da Gloria - SE")]
        NossaSenhoradaGloria = 2804508,

        [EnumValue("2804607")]
        [Description("Nossa Senhora das Dores - SE")]
        NossaSenhoradasDores = 2804607,

        [EnumValue("2804805")]
        [Description("Nossa Senhora do Socorro - SE")]
        NossaSenhoradoSocorro = 2804805,

        [EnumValue("2804904")]
        [Description("Pacatuba - SE")]
        Pacatuba_SE = 2804904,

        [EnumValue("2805208")]
        [Description("Pinhao - SE")]
        Pinhao_SE = 2805208,

        [EnumValue("2805406")]
        [Description("Poco Redondo - SE")]
        PocoRedondo = 2805406,

        [EnumValue("2805604")]
        [Description("Porto da Folha - SE")]
        PortodaFolha = 2805604,

        [EnumValue("2805802")]
        [Description("Riachao do Dantas - SE")]
        RiachaodoDantas = 2805802,

        [EnumValue("2806107")]
        [Description("Rosario do Catete - SE")]
        RosariodoCatete = 2806107,

        [EnumValue("2806305")]
        [Description("Santa Luzia do Itanhy - SE")]
        SantaLuziadoItanhy = 2806305,

        [EnumValue("2806404")]
        [Description("Santana do Sao Francisco - SE")]
        SantanadoSaoFrancisco = 2806404,

        [EnumValue("2806503")]
        [Description("Santa Rosa de Lima - SE")]
        SantaRosadeLima_SE = 2806503,

        [EnumValue("2806602")]
        [Description("Santo Amaro das Brotas - SE")]
        SantoAmarodasBrotas = 2806602,

        [EnumValue("2806701")]
        [Description("Sao Cristovao - SE")]
        SaoCristovao = 2806701,

        [EnumValue("2806800")]
        [Description("Sao Domingos - SE")]
        SaoDomingos_SE = 2806800,

        [EnumValue("2806909")]
        [Description("Sao Francisco - SE")]
        SaoFrancisco_SE = 2806909,

        [EnumValue("2807204")]
        [Description("Siriri - SE")]
        Siriri = 2807204,

        [EnumValue("2807402")]
        [Description("Tobias Barreto - SE")]
        TobiasBarreto = 2807402,

        //======São Paulo======
        [EnumValue("3500105")]
        [Description("Adamantina - SP")]
        Adamantina = 3500105,

        [EnumValue("3500204")]
        [Description("Adolfo - SP")]
        Adolfo = 3500204,

        [EnumValue("3500303")]
        [Description("Aguai - SP")]
        Aguai = 3500303,

        [EnumValue("3500402")]
        [Description("Aguas da Prata - SP")]
        AguasdaPrata = 3500402,

        [EnumValue("3500501")]
        [Description("Aguas de Lindoia - SP")]
        AguasdeLindoia = 3500501,

        [EnumValue("3500550")]
        [Description("Aguas de Santa Barbara - SP")]
        AguasdeSantaBarbara = 3500550,

        [EnumValue("3500600")]
        [Description("Aguas de Sao Pedro - SP")]
        AguasdeSaoPedro = 3500600,

        [EnumValue("3500709")]
        [Description("Agudos - SP")]
        Agudos = 3500709,

        [EnumValue("3500758")]
        [Description("Alambari - SP")]
        Alambari = 3500758,

        [EnumValue("3500907")]
        [Description("Altair - SP")]
        Altair = 3500907,

        [EnumValue("3501004")]
        [Description("Altinopolis - SP")]
        Altinopolis = 3501004,

        [EnumValue("3501103")]
        [Description("Alto Alegre - SP")]
        AltoAlegre_SP = 3501103,

        [EnumValue("3501152")]
        [Description("Aluminio - SP")]
        Aluminio = 3501152,

        [EnumValue("3501202")]
        [Description("Alvares Florence - SP")]
        AlvaresFlorence = 3501202,

        [EnumValue("3501301")]
        [Description("Alvares Machado - SP")]
        AlvaresMachado = 3501301,

        [EnumValue("3501400")]
        [Description("Alvaro de Carvalho - SP")]
        AlvarodeCarvalho = 3501400,

        [EnumValue("3501509")]
        [Description("Alvinlandia - SP")]
        Alvinlandia = 3501509,

        [EnumValue("3501608")]
        [Description("Americana - SP")]
        Americana = 3501608,

        [EnumValue("3501707")]
        [Description("Americo Brasiliense - SP")]
        AmericoBrasiliense = 3501707,

        [EnumValue("3501806")]
        [Description("Americo de Campos - SP")]
        AmericodeCampos = 3501806,

        [EnumValue("3501905")]
        [Description("Amparo - SP")]
        Amparo_SP = 3501905,

        [EnumValue("3502002")]
        [Description("Analandia - SP")]
        Analandia = 3502002,

        [EnumValue("3502101")]
        [Description("Andradina - SP")]
        Andradina = 3502101,

        [EnumValue("3502200")]
        [Description("Angatuba - SP")]
        Angatuba = 3502200,

        [EnumValue("3502309")]
        [Description("Anhembi - SP")]
        Anhembi = 3502309,

        [EnumValue("3502408")]
        [Description("Anhumas - SP")]
        Anhumas = 3502408,

        [EnumValue("3502507")]
        [Description("Aparecida - SP")]
        Aparecida_SP = 3502507,

        [EnumValue("3502606")]
        [Description("Aparecida dOeste - SP")]
        AparecidadOeste = 3502606,

        [EnumValue("3502705")]
        [Description("Apiai - SP")]
        Apiai = 3502705,

        [EnumValue("3502754")]
        [Description("Aracariguama - SP")]
        Aracariguama = 3502754,

        [EnumValue("3502804")]
        [Description("Aracatuba - SP")]
        Aracatuba = 3502804,

        [EnumValue("3502903")]
        [Description("Aracoiaba da Serra - SP")]
        AracoiabadaSerra = 3502903,

        [EnumValue("3503000")]
        [Description("Aramina - SP")]
        Aramina = 3503000,

        [EnumValue("3503109")]
        [Description("Arandu - SP")]
        Arandu = 3503109,

        [EnumValue("3503158")]
        [Description("Arapei - SP")]
        Arapei = 3503158,

        [EnumValue("3503208")]
        [Description("Araraquara - SP")]
        Araraquara = 3503208,

        [EnumValue("3503307")]
        [Description("Araras - SP")]
        Araras = 3503307,

        [EnumValue("3503356")]
        [Description("Arco-Iris - SP")]
        ArcoIris = 3503356,

        [EnumValue("3503406")]
        [Description("Arealva - SP")]
        Arealva = 3503406,

        [EnumValue("3503505")]
        [Description("Areias - SP")]
        Areias = 3503505,

        [EnumValue("3503604")]
        [Description("Areiopolis - SP")]
        Areiopolis = 3503604,

        [EnumValue("3503703")]
        [Description("Ariranha - SP")]
        Ariranha = 3503703,

        [EnumValue("3503802")]
        [Description("Artur Nogueira - SP")]
        ArturNogueira = 3503802,

        [EnumValue("3503901")]
        [Description("Aruja - SP")]
        Aruja = 3503901,

        [EnumValue("3504008")]
        [Description("Assis - SP")]
        Assis = 3504008,

        [EnumValue("3504107")]
        [Description("Atibaia - SP")]
        Atibaia = 3504107,

        [EnumValue("3504206")]
        [Description("Auriflama - SP")]
        Auriflama = 3504206,

        [EnumValue("3504305")]
        [Description("Avai - SP")]
        Avai = 3504305,

        [EnumValue("3504404")]
        [Description("Avanhandava - SP")]
        Avanhandava = 3504404,

        [EnumValue("3504503")]
        [Description("Avare - SP")]
        Avare = 3504503,

        [EnumValue("3504602")]
        [Description("Bady Bassitt - SP")]
        BadyBassitt = 3504602,

        [EnumValue("3504701")]
        [Description("Balbinos - SP")]
        Balbinos = 3504701,

        [EnumValue("3504800")]
        [Description("Balsamo - SP")]
        Balsamo = 3504800,

        [EnumValue("3504909")]
        [Description("Bananal - SP")]
        Bananal = 3504909,

        [EnumValue("3505005")]
        [Description("Barao de Antonina - SP")]
        BaraodeAntonina = 3505005,

        [EnumValue("3505104")]
        [Description("Barbosa - SP")]
        Barbosa = 3505104,

        [EnumValue("3505203")]
        [Description("Bariri - SP")]
        Bariri = 3505203,

        [EnumValue("3505302")]
        [Description("Barra Bonita - SP")]
        BarraBonita_SP = 3505302,

        [EnumValue("3505351")]
        [Description("Barra do Chapeu - SP")]
        BarradoChapeu = 3505351,

        [EnumValue("3505401")]
        [Description("Barra do Turvo - SP")]
        BarradoTurvo = 3505401,

        [EnumValue("3505500")]
        [Description("Barretos - SP")]
        Barretos = 3505500,

        [EnumValue("3505609")]
        [Description("Barrinha - SP")]
        Barrinha = 3505609,

        [EnumValue("3505708")]
        [Description("Barueri - SP")]
        Barueri = 3505708,

        [EnumValue("3505807")]
        [Description("Bastos - SP")]
        Bastos = 3505807,

        [EnumValue("3505906")]
        [Description("Batatais - SP")]
        Batatais = 3505906,

        [EnumValue("3506003")]
        [Description("Bauru - SP")]
        Bauru = 3506003,

        [EnumValue("3506102")]
        [Description("Bebedouro - SP")]
        Bebedouro = 3506102,

        [EnumValue("3506201")]
        [Description("Bento de Abreu - SP")]
        BentodeAbreu = 3506201,

        [EnumValue("3506300")]
        [Description("Bernardino de Campos - SP")]
        BernardinodeCampos = 3506300,

        [EnumValue("3506359")]
        [Description("Bertioga - SP")]
        Bertioga = 3506359,

        [EnumValue("3506409")]
        [Description("Bilac - SP")]
        Bilac = 3506409,

        [EnumValue("3506508")]
        [Description("Birigui - SP")]
        Birigui = 3506508,

        [EnumValue("3506607")]
        [Description("Biritiba Mirim - SP")]
        BiritibaMirim = 3506607,

        [EnumValue("3506706")]
        [Description("Boa Esperanca do Sul - SP")]
        BoaEsperancadoSul = 3506706,

        [EnumValue("3506805")]
        [Description("Bocaina - SP")]
        Bocaina_SP = 3506805,

        [EnumValue("3506904")]
        [Description("Bofete - SP")]
        Bofete = 3506904,

        [EnumValue("3507001")]
        [Description("Boituva - SP")]
        Boituva = 3507001,

        [EnumValue("3507100")]
        [Description("Bom Jesus dos Perdoes - SP")]
        BomJesusdosPerdoes = 3507100,

        [EnumValue("3507159")]
        [Description("Bom Sucesso de Itarare - SP")]
        BomSucessodeItarare = 3507159,

        [EnumValue("3507209")]
        [Description("Bora - SP")]
        Bora = 3507209,

        [EnumValue("3507308")]
        [Description("Boraceia - SP")]
        Boraceia = 3507308,

        [EnumValue("3507407")]
        [Description("Borborema - SP")]
        Borborema_SP = 3507407,

        [EnumValue("3507456")]
        [Description("Borebi - SP")]
        Borebi = 3507456,

        [EnumValue("3507506")]
        [Description("Botucatu - SP")]
        Botucatu = 3507506,

        [EnumValue("3507605")]
        [Description("Braganca Paulista - SP")]
        BragancaPaulista = 3507605,

        [EnumValue("3507704")]
        [Description("Brauna - SP")]
        Brauna = 3507704,

        [EnumValue("3507753")]
        [Description("Brejo Alegre - SP")]
        BrejoAlegre = 3507753,

        [EnumValue("3507803")]
        [Description("Brodowski - SP")]
        Brodowski = 3507803,

        [EnumValue("3507902")]
        [Description("Brotas - SP")]
        Brotas = 3507902,

        [EnumValue("3508009")]
        [Description("Buri - SP")]
        Buri = 3508009,

        [EnumValue("3508108")]
        [Description("Buritama - SP")]
        Buritama = 3508108,

        [EnumValue("3508207")]
        [Description("Buritizal - SP")]
        Buritizal = 3508207,

        [EnumValue("3508306")]
        [Description("Cabralia Paulista - SP")]
        CabraliaPaulista = 3508306,

        [EnumValue("3508405")]
        [Description("Cabreuva - SP")]
        Cabreuva = 3508405,

        [EnumValue("3508504")]
        [Description("Cacapava - SP")]
        Cacapava = 3508504,

        [EnumValue("3508603")]
        [Description("Cachoeira Paulista - SP")]
        CachoeiraPaulista = 3508603,

        [EnumValue("3508702")]
        [Description("Caconde - SP")]
        Caconde = 3508702,

        [EnumValue("3508801")]
        [Description("Cafelandia - SP")]
        Cafelandia_SP = 3508801,

        [EnumValue("3508900")]
        [Description("Caiabu - SP")]
        Caiabu = 3508900,

        [EnumValue("3509007")]
        [Description("Caieiras - SP")]
        Caieiras = 3509007,

        [EnumValue("3509106")]
        [Description("Caiua - SP")]
        Caiua = 3509106,

        [EnumValue("3509205")]
        [Description("Cajamar - SP")]
        Cajamar = 3509205,

        [EnumValue("3509254")]
        [Description("Cajati - SP")]
        Cajati = 3509254,

        [EnumValue("3509304")]
        [Description("Cajobi - SP")]
        Cajobi = 3509304,

        [EnumValue("3509403")]
        [Description("Cajuru - SP")]
        Cajuru = 3509403,

        [EnumValue("3509452")]
        [Description("Campina do Monte Alegre - SP")]
        CampinadoMonteAlegre = 3509452,

        [EnumValue("3509502")]
        [Description("Campinas - SP")]
        Campinas = 3509502,

        [EnumValue("3509601")]
        [Description("Campo Limpo Paulista - SP")]
        CampoLimpoPaulista = 3509601,

        [EnumValue("3509700")]
        [Description("Campos do Jordao - SP")]
        CamposdoJordao = 3509700,

        [EnumValue("3509809")]
        [Description("Campos Novos Paulista - SP")]
        CamposNovosPaulista = 3509809,

        [EnumValue("3509908")]
        [Description("Cananeia - SP")]
        Cananeia = 3509908,

        [EnumValue("3509957")]
        [Description("Canas - SP")]
        Canas = 3509957,

        [EnumValue("3510005")]
        [Description("Candido Mota - SP")]
        CandidoMota = 3510005,

        [EnumValue("3510104")]
        [Description("Candido Rodrigues - SP")]
        CandidoRodrigues = 3510104,

        [EnumValue("3510153")]
        [Description("Canitar - SP")]
        Canitar = 3510153,

        [EnumValue("3510203")]
        [Description("Capao Bonito - SP")]
        CapaoBonito = 3510203,

        [EnumValue("3510302")]
        [Description("Capela do Alto - SP")]
        CapeladoAlto = 3510302,

        [EnumValue("3510401")]
        [Description("Capivari - SP")]
        Capivari = 3510401,

        [EnumValue("3510500")]
        [Description("Caraguatatuba - SP")]
        Caraguatatuba = 3510500,

        [EnumValue("3510609")]
        [Description("Carapicuiba - SP")]
        Carapicuiba = 3510609,

        [EnumValue("3510708")]
        [Description("Cardoso - SP")]
        Cardoso = 3510708,

        [EnumValue("3510807")]
        [Description("Casa Branca - SP")]
        CasaBranca = 3510807,

        [EnumValue("3510906")]
        [Description("Cassia dos Coqueiros - SP")]
        CassiadosCoqueiros = 3510906,

        [EnumValue("3511003")]
        [Description("Castilho - SP")]
        Castilho = 3511003,

        [EnumValue("3511102")]
        [Description("Catanduva - SP")]
        Catanduva = 3511102,

        [EnumValue("3511201")]
        [Description("Catigua - SP")]
        Catigua = 3511201,

        [EnumValue("3511300")]
        [Description("Cedral - SP")]
        Cedral_SP = 3511300,

        [EnumValue("3511409")]
        [Description("Cerqueira Cesar - SP")]
        CerqueiraCesar = 3511409,

        [EnumValue("3511508")]
        [Description("Cerquilho - SP")]
        Cerquilho = 3511508,

        [EnumValue("3511607")]
        [Description("Cesario Lange - SP")]
        CesarioLange = 3511607,

        [EnumValue("3511706")]
        [Description("Charqueada - SP")]
        Charqueada = 3511706,

        [EnumValue("3511904")]
        [Description("Clementina - SP")]
        Clementina = 3511904,

        [EnumValue("3512001")]
        [Description("Colina - SP")]
        Colina = 3512001,

        [EnumValue("3512100")]
        [Description("Colombia - SP")]
        Colombia = 3512100,

        [EnumValue("3512209")]
        [Description("Conchal - SP")]
        Conchal = 3512209,

        [EnumValue("3512308")]
        [Description("Conchas - SP")]
        Conchas = 3512308,

        [EnumValue("3512407")]
        [Description("Cordeiropolis - SP")]
        Cordeiropolis = 3512407,

        [EnumValue("3512506")]
        [Description("Coroados - SP")]
        Coroados = 3512506,

        [EnumValue("3512605")]
        [Description("Coronel Macedo - SP")]
        CoronelMacedo = 3512605,

        [EnumValue("3512704")]
        [Description("Corumbatai - SP")]
        Corumbatai = 3512704,

        [EnumValue("3512803")]
        [Description("Cosmopolis - SP")]
        Cosmopolis = 3512803,

        [EnumValue("3512902")]
        [Description("Cosmorama - SP")]
        Cosmorama = 3512902,

        [EnumValue("3513009")]
        [Description("Cotia - SP")]
        Cotia = 3513009,

        [EnumValue("3513108")]
        [Description("Cravinhos - SP")]
        Cravinhos = 3513108,

        [EnumValue("3513207")]
        [Description("Cristais Paulista - SP")]
        CristaisPaulista = 3513207,

        [EnumValue("3513405")]
        [Description("Cruzeiro - SP")]
        Cruzeiro = 3513405,

        [EnumValue("3513504")]
        [Description("Cubatao - SP")]
        Cubatao = 3513504,

        [EnumValue("3513603")]
        [Description("Cunha - SP")]
        Cunha = 3513603,

        [EnumValue("3513702")]
        [Description("Descalvado - SP")]
        Descalvado = 3513702,

        [EnumValue("3513801")]
        [Description("Diadema - SP")]
        Diadema = 3513801,

        [EnumValue("3513850")]
        [Description("Dirce Reis - SP")]
        DirceReis = 3513850,

        [EnumValue("3513900")]
        [Description("Divinolandia - SP")]
        Divinolandia = 3513900,

        [EnumValue("3514007")]
        [Description("Dobrada - SP")]
        Dobrada = 3514007,

        [EnumValue("3514106")]
        [Description("Dois Corregos - SP")]
        DoisCorregos = 3514106,

        [EnumValue("3514205")]
        [Description("Dolcinopolis - SP")]
        Dolcinopolis = 3514205,

        [EnumValue("3514304")]
        [Description("Dourado - SP")]
        Dourado = 3514304,

        [EnumValue("3514403")]
        [Description("Dracena - SP")]
        Dracena = 3514403,

        [EnumValue("3514502")]
        [Description("Duartina - SP")]
        Duartina = 3514502,

        [EnumValue("3514601")]
        [Description("Dumont - SP")]
        Dumont = 3514601,

        [EnumValue("3514700")]
        [Description("Echapora - SP")]
        Echapora = 3514700,

        [EnumValue("3514809")]
        [Description("Eldorado - SP")]
        Eldorado_SP = 3514809,

        [EnumValue("3514908")]
        [Description("Elias Fausto - SP")]
        EliasFausto = 3514908,

        [EnumValue("3514924")]
        [Description("Elisiario - SP")]
        Elisiario = 3514924,

        [EnumValue("3514957")]
        [Description("Embauba - SP")]
        Embauba = 3514957,

        [EnumValue("3515004")]
        [Description("Embu das Artes - SP")]
        EmbudasArtes = 3515004,

        [EnumValue("3515103")]
        [Description("Embu-Guacu - SP")]
        EmbuGuacu = 3515103,

        [EnumValue("3515129")]
        [Description("Emilianopolis - SP")]
        Emilianopolis = 3515129,

        [EnumValue("3515152")]
        [Description("Engenheiro Coelho - SP")]
        EngenheiroCoelho = 3515152,

        [EnumValue("3515186")]
        [Description("Espirito Santo do Pinhal - SP")]
        EspiritoSantodoPinhal = 3515186,

        [EnumValue("3515194")]
        [Description("Espirito Santo do Turvo - SP")]
        EspiritoSantodoTurvo = 3515194,

        [EnumValue("3515202")]
        [Description("Estrela dOeste - SP")]
        EstreladOeste = 3515202,

        [EnumValue("3515350")]
        [Description("Euclides da Cunha Paulista - SP")]
        EuclidesdaCunhaPaulista = 3515350,

        [EnumValue("3515400")]
        [Description("Fartura - SP")]
        Fartura = 3515400,

        [EnumValue("3515509")]
        [Description("Fernandopolis - SP")]
        Fernandopolis = 3515509,

        [EnumValue("3515608")]
        [Description("Fernando Prestes - SP")]
        FernandoPrestes = 3515608,

        [EnumValue("3515657")]
        [Description("Fernao - SP")]
        Fernao = 3515657,

        [EnumValue("3515707")]
        [Description("Ferraz de Vasconcelos - SP")]
        FerrazdeVasconcelos = 3515707,

        [EnumValue("3515806")]
        [Description("Flora Rica - SP")]
        FloraRica = 3515806,

        [EnumValue("3516002")]
        [Description("Florida Paulista - SP")]
        FloridaPaulista = 3516002,

        [EnumValue("3516101")]
        [Description("Florinea - SP")]
        Florinea = 3516101,

        [EnumValue("3516200")]
        [Description("Franca - SP")]
        Franca = 3516200,

        [EnumValue("3516309")]
        [Description("Francisco Morato - SP")]
        FranciscoMorato = 3516309,

        [EnumValue("3516408")]
        [Description("Franco da Rocha - SP")]
        FrancodaRocha = 3516408,

        [EnumValue("3516606")]
        [Description("Galia - SP")]
        Galia = 3516606,

        [EnumValue("3516705")]
        [Description("Garca - SP")]
        Garca = 3516705,

        [EnumValue("3516853")]
        [Description("Gaviao Peixoto - SP")]
        GaviaoPeixoto = 3516853,

        [EnumValue("3516903")]
        [Description("General Salgado - SP")]
        GeneralSalgado = 3516903,

        [EnumValue("3517000")]
        [Description("Getulina - SP")]
        Getulina = 3517000,

        [EnumValue("3517109")]
        [Description("Glicerio - SP")]
        Glicerio = 3517109,

        [EnumValue("3517208")]
        [Description("Guaicara - SP")]
        Guaicara = 3517208,

        [EnumValue("3517307")]
        [Description("Guaimbe - SP")]
        Guaimbe = 3517307,

        [EnumValue("3517406")]
        [Description("Guaira - SP")]
        Guaira_SP = 3517406,

        [EnumValue("3517505")]
        [Description("Guapiacu - SP")]
        Guapiacu = 3517505,

        [EnumValue("3517604")]
        [Description("Guapiara - SP")]
        Guapiara = 3517604,

        [EnumValue("3517703")]
        [Description("Guara - SP")]
        Guara = 3517703,

        [EnumValue("3517901")]
        [Description("Guaraci - SP")]
        Guaraci_SP = 3517901,

        [EnumValue("3518206")]
        [Description("Guararapes - SP")]
        Guararapes = 3518206,

        [EnumValue("3518305")]
        [Description("Guararema - SP")]
        Guararema = 3518305,

        [EnumValue("3518404")]
        [Description("Guaratingueta - SP")]
        Guaratingueta = 3518404,

        [EnumValue("3518503")]
        [Description("Guarei - SP")]
        Guarei = 3518503,

        [EnumValue("3518602")]
        [Description("Guariba - SP")]
        Guariba = 3518602,

        [EnumValue("3518701")]
        [Description("Guaruja - SP")]
        Guaruja = 3518701,

        [EnumValue("3518800")]
        [Description("Guarulhos - SP")]
        Guarulhos = 3518800,

        [EnumValue("3518859")]
        [Description("Guatapara - SP")]
        Guatapara = 3518859,

        [EnumValue("3518909")]
        [Description("Guzolandia - SP")]
        Guzolandia = 3518909,

        [EnumValue("3519006")]
        [Description("Herculandia - SP")]
        Herculandia = 3519006,

        [EnumValue("3519055")]
        [Description("Holambra - SP")]
        Holambra = 3519055,

        [EnumValue("3519071")]
        [Description("Hortolandia - SP")]
        Hortolandia = 3519071,

        [EnumValue("3519105")]
        [Description("Iacanga - SP")]
        Iacanga = 3519105,

        [EnumValue("3519204")]
        [Description("Iacri - SP")]
        Iacri = 3519204,

        [EnumValue("3519253")]
        [Description("Iaras - SP")]
        Iaras = 3519253,

        [EnumValue("3519303")]
        [Description("Ibate - SP")]
        Ibate = 3519303,

        [EnumValue("3519402")]
        [Description("Ibira - SP")]
        Ibira = 3519402,

        [EnumValue("3519501")]
        [Description("Ibirarema - SP")]
        Ibirarema = 3519501,

        [EnumValue("3519600")]
        [Description("Ibitinga - SP")]
        Ibitinga = 3519600,

        [EnumValue("3519709")]
        [Description("Ibiuna - SP")]
        Ibiuna = 3519709,

        [EnumValue("3519808")]
        [Description("Icem - SP")]
        Icem = 3519808,

        [EnumValue("3519907")]
        [Description("Iepe - SP")]
        Iepe = 3519907,

        [EnumValue("3520004")]
        [Description("Igaracu do Tiete - SP")]
        IgaracudoTiete = 3520004,

        [EnumValue("3520103")]
        [Description("Igarapava - SP")]
        Igarapava = 3520103,

        [EnumValue("3520202")]
        [Description("Igarata - SP")]
        Igarata = 3520202,

        [EnumValue("3520301")]
        [Description("Iguape - SP")]
        Iguape = 3520301,

        [EnumValue("3520426")]
        [Description("Ilha Comprida - SP")]
        IlhaComprida = 3520426,

        [EnumValue("3520442")]
        [Description("Ilha Solteira - SP")]
        IlhaSolteira = 3520442,

        [EnumValue("3520509")]
        [Description("Indaiatuba - SP")]
        Indaiatuba = 3520509,

        [EnumValue("3520608")]
        [Description("Indiana - SP")]
        Indiana = 3520608,

        [EnumValue("3520707")]
        [Description("Indiapora - SP")]
        Indiapora = 3520707,

        [EnumValue("3520806")]
        [Description("Inubia Paulista - SP")]
        InubiaPaulista = 3520806,

        [EnumValue("3520905")]
        [Description("Ipaussu - SP")]
        Ipaussu = 3520905,

        [EnumValue("3521002")]
        [Description("Ipero - SP")]
        Ipero = 3521002,

        [EnumValue("3521101")]
        [Description("Ipeuna - SP")]
        Ipeuna = 3521101,

        [EnumValue("3521200")]
        [Description("Iporanga - SP")]
        Iporanga = 3521200,

        [EnumValue("3521309")]
        [Description("Ipua - SP")]
        Ipua = 3521309,

        [EnumValue("3521408")]
        [Description("Iracemapolis - SP")]
        Iracemapolis = 3521408,

        [EnumValue("3521507")]
        [Description("Irapua - SP")]
        Irapua = 3521507,

        [EnumValue("3521606")]
        [Description("Irapuru - SP")]
        Irapuru = 3521606,

        [EnumValue("3521705")]
        [Description("Itabera - SP")]
        Itabera = 3521705,

        [EnumValue("3521804")]
        [Description("Itai - SP")]
        Itai = 3521804,

        [EnumValue("3521903")]
        [Description("Itajobi - SP")]
        Itajobi = 3521903,

        [EnumValue("3522000")]
        [Description("Itaju - SP")]
        Itaju = 3522000,

        [EnumValue("3522109")]
        [Description("Itanhaem - SP")]
        Itanhaem = 3522109,

        [EnumValue("3522158")]
        [Description("Itaoca - SP")]
        Itaoca = 3522158,

        [EnumValue("3522208")]
        [Description("Itapecerica da Serra - SP")]
        ItapecericadaSerra = 3522208,

        [EnumValue("3522307")]
        [Description("Itapetininga - SP")]
        Itapetininga = 3522307,

        [EnumValue("3522406")]
        [Description("Itapeva - SP")]
        Itapeva_SP = 3522406,

        [EnumValue("3522505")]
        [Description("Itapevi - SP")]
        Itapevi = 3522505,

        [EnumValue("3522604")]
        [Description("Itapira - SP")]
        Itapira = 3522604,

        [EnumValue("3522653")]
        [Description("Itapirapua Paulista - SP")]
        ItapirapuaPaulista = 3522653,

        [EnumValue("3522703")]
        [Description("Itapolis - SP")]
        Itapolis = 3522703,

        [EnumValue("3522802")]
        [Description("Itaporanga - SP")]
        Itaporanga_SP = 3522802,

        [EnumValue("3522901")]
        [Description("Itapui - SP")]
        Itapui = 3522901,

        [EnumValue("3523008")]
        [Description("Itapura - SP")]
        Itapura = 3523008,

        [EnumValue("3523107")]
        [Description("Itaquaquecetuba - SP")]
        Itaquaquecetuba = 3523107,

        [EnumValue("3523206")]
        [Description("Itarare - SP")]
        Itarare = 3523206,

        [EnumValue("3523305")]
        [Description("Itariri - SP")]
        Itariri = 3523305,

        [EnumValue("3523404")]
        [Description("Itatiba - SP")]
        Itatiba = 3523404,

        [EnumValue("3523503")]
        [Description("Itatinga - SP")]
        Itatinga = 3523503,

        [EnumValue("3523602")]
        [Description("Itirapina - SP")]
        Itirapina = 3523602,

        [EnumValue("3523701")]
        [Description("Itirapua - SP")]
        Itirapua = 3523701,

        [EnumValue("3523909")]
        [Description("Itu - SP")]
        Itu = 3523909,

        [EnumValue("3524006")]
        [Description("Itupeva - SP")]
        Itupeva = 3524006,

        [EnumValue("3524105")]
        [Description("Ituverava - SP")]
        Ituverava = 3524105,

        [EnumValue("3524204")]
        [Description("Jaborandi - SP")]
        Jaborandi_SP = 3524204,

        [EnumValue("3524303")]
        [Description("Jaboticabal - SP")]
        Jaboticabal = 3524303,

        [EnumValue("3524402")]
        [Description("Jacarei - SP")]
        Jacarei = 3524402,

        [EnumValue("3524501")]
        [Description("Jaci - SP")]
        Jaci = 3524501,

        [EnumValue("3524600")]
        [Description("Jacupiranga - SP")]
        Jacupiranga = 3524600,

        [EnumValue("3524709")]
        [Description("Jaguariuna - SP")]
        Jaguariuna = 3524709,

        [EnumValue("3524808")]
        [Description("Jales - SP")]
        Jales = 3524808,

        [EnumValue("3524907")]
        [Description("Jambeiro - SP")]
        Jambeiro = 3524907,

        [EnumValue("3525003")]
        [Description("Jandira - SP")]
        Jandira = 3525003,

        [EnumValue("3525102")]
        [Description("Jardinopolis - SP")]
        Jardinopolis_SP = 3525102,

        [EnumValue("3525201")]
        [Description("Jarinu - SP")]
        Jarinu = 3525201,

        [EnumValue("3525300")]
        [Description("Jau - SP")]
        Jau = 3525300,

        [EnumValue("3525409")]
        [Description("Jeriquara - SP")]
        Jeriquara = 3525409,

        [EnumValue("3525508")]
        [Description("Joanopolis - SP")]
        Joanopolis = 3525508,

        [EnumValue("3525607")]
        [Description("Joao Ramalho - SP")]
        JoaoRamalho = 3525607,

        [EnumValue("3525706")]
        [Description("Jose Bonifacio - SP")]
        JoseBonifacio = 3525706,

        [EnumValue("3525805")]
        [Description("Julio Mesquita - SP")]
        JulioMesquita = 3525805,

        [EnumValue("3525854")]
        [Description("Jumirim - SP")]
        Jumirim = 3525854,

        [EnumValue("3525904")]
        [Description("Jundiai - SP")]
        Jundiai = 3525904,

        [EnumValue("3526001")]
        [Description("Junqueiropolis - SP")]
        Junqueiropolis = 3526001,

        [EnumValue("3526100")]
        [Description("Juquia - SP")]
        Juquia = 3526100,

        [EnumValue("3526209")]
        [Description("Juquitiba - SP")]
        Juquitiba = 3526209,

        [EnumValue("3526308")]
        [Description("Lagoinha - SP")]
        Lagoinha = 3526308,

        [EnumValue("3526407")]
        [Description("Laranjal Paulista - SP")]
        LaranjalPaulista = 3526407,

        [EnumValue("3526506")]
        [Description("Lavinia - SP")]
        Lavinia = 3526506,

        [EnumValue("3526605")]
        [Description("Lavrinhas - SP")]
        Lavrinhas = 3526605,

        [EnumValue("3526704")]
        [Description("Leme - SP")]
        Leme = 3526704,

        [EnumValue("3526803")]
        [Description("Lencois Paulista - SP")]
        LencoisPaulista = 3526803,

        [EnumValue("3526902")]
        [Description("Limeira - SP")]
        Limeira = 3526902,

        [EnumValue("3527009")]
        [Description("Lindoia - SP")]
        Lindoia = 3527009,

        [EnumValue("3527108")]
        [Description("Lins - SP")]
        Lins = 3527108,

        [EnumValue("3527207")]
        [Description("Lorena - SP")]
        Lorena = 3527207,

        [EnumValue("3527256")]
        [Description("Lourdes - SP")]
        Lourdes = 3527256,

        [EnumValue("3527306")]
        [Description("Louveira - SP")]
        Louveira = 3527306,

        [EnumValue("3527405")]
        [Description("Lucelia - SP")]
        Lucelia = 3527405,

        [EnumValue("3527504")]
        [Description("Lucianopolis - SP")]
        Lucianopolis = 3527504,

        [EnumValue("3527603")]
        [Description("Luis Antonio - SP")]
        LuisAntonio = 3527603,

        [EnumValue("3527702")]
        [Description("Luiziania - SP")]
        Luiziania = 3527702,

        [EnumValue("3527801")]
        [Description("Lupercio - SP")]
        Lupercio = 3527801,

        [EnumValue("3527900")]
        [Description("Lutecia - SP")]
        Lutecia = 3527900,

        [EnumValue("3528007")]
        [Description("Macatuba - SP")]
        Macatuba = 3528007,

        [EnumValue("3528106")]
        [Description("Macaubal - SP")]
        Macaubal = 3528106,

        [EnumValue("3528205")]
        [Description("Macedonia - SP")]
        Macedonia = 3528205,

        [EnumValue("3528304")]
        [Description("Magda - SP")]
        Magda = 3528304,

        [EnumValue("3528403")]
        [Description("Mairinque - SP")]
        Mairinque = 3528403,

        [EnumValue("3528502")]
        [Description("Mairipora - SP")]
        Mairipora = 3528502,

        [EnumValue("3528601")]
        [Description("Manduri - SP")]
        Manduri = 3528601,

        [EnumValue("3528700")]
        [Description("Maraba Paulista - SP")]
        MarabaPaulista = 3528700,

        [EnumValue("3528809")]
        [Description("Maracai - SP")]
        Maracai = 3528809,

        [EnumValue("3528858")]
        [Description("Marapoama - SP")]
        Marapoama = 3528858,

        [EnumValue("3528908")]
        [Description("Mariapolis - SP")]
        Mariapolis = 3528908,

        [EnumValue("3529005")]
        [Description("Marilia - SP")]
        Marilia = 3529005,

        [EnumValue("3529104")]
        [Description("Marinopolis - SP")]
        Marinopolis = 3529104,

        [EnumValue("3529203")]
        [Description("Martinopolis - SP")]
        Martinopolis = 3529203,

        [EnumValue("3529302")]
        [Description("Matao - SP")]
        Matao = 3529302,

        [EnumValue("3529401")]
        [Description("Maua - SP")]
        Maua = 3529401,

        [EnumValue("3529500")]
        [Description("Mendonca - SP")]
        Mendonca = 3529500,

        [EnumValue("3529609")]
        [Description("Meridiano - SP")]
        Meridiano = 3529609,

        [EnumValue("3529708")]
        [Description("Miguelopolis - SP")]
        Miguelopolis = 3529708,

        [EnumValue("3529807")]
        [Description("Mineiros do Tiete - SP")]
        MineirosdoTiete = 3529807,

        [EnumValue("3529906")]
        [Description("Miracatu - SP")]
        Miracatu = 3529906,

        [EnumValue("3530003")]
        [Description("Mira Estrela - SP")]
        MiraEstrela = 3530003,

        [EnumValue("3530102")]
        [Description("Mirandopolis - SP")]
        Mirandopolis = 3530102,

        [EnumValue("3530201")]
        [Description("Mirante do Paranapanema - SP")]
        MirantedoParanapanema = 3530201,

        [EnumValue("3530300")]
        [Description("Mirassol - SP")]
        Mirassol = 3530300,

        [EnumValue("3530409")]
        [Description("Mirassolandia - SP")]
        Mirassolandia = 3530409,

        [EnumValue("3530508")]
        [Description("Mococa - SP")]
        Mococa = 3530508,

        [EnumValue("3530607")]
        [Description("Mogi das Cruzes - SP")]
        MogidasCruzes = 3530607,

        [EnumValue("3530706")]
        [Description("Mogi Guacu - SP")]
        MogiGuacu = 3530706,

        [EnumValue("3530805")]
        [Description("Mogi Mirim - SP")]
        MogiMirim = 3530805,

        [EnumValue("3530904")]
        [Description("Mombuca - SP")]
        Mombuca = 3530904,

        [EnumValue("3531100")]
        [Description("Mongagua - SP")]
        Mongagua = 3531100,

        [EnumValue("3531308")]
        [Description("Monte Alto - SP")]
        MonteAlto = 3531308,

        [EnumValue("3531407")]
        [Description("Monte Aprazivel - SP")]
        MonteAprazivel = 3531407,

        [EnumValue("3531506")]
        [Description("Monte Azul Paulista - SP")]
        MonteAzulPaulista = 3531506,

        [EnumValue("3531605")]
        [Description("Monte Castelo - SP")]
        MonteCastelo_SP = 3531605,

        [EnumValue("3531704")]
        [Description("Monteiro Lobato - SP")]
        MonteiroLobato = 3531704,

        [EnumValue("3531803")]
        [Description("Monte Mor - SP")]
        MonteMor = 3531803,

        [EnumValue("3531902")]
        [Description("Morro Agudo - SP")]
        MorroAgudo = 3531902,

        [EnumValue("3532009")]
        [Description("Morungaba - SP")]
        Morungaba = 3532009,

        [EnumValue("3532058")]
        [Description("Motuca - SP")]
        Motuca = 3532058,

        [EnumValue("3532108")]
        [Description("Murutinga do Sul - SP")]
        MurutingadoSul = 3532108,

        [EnumValue("3532207")]
        [Description("Narandiba - SP")]
        Narandiba = 3532207,

        [EnumValue("3532306")]
        [Description("Natividade da Serra - SP")]
        NatividadedaSerra = 3532306,

        [EnumValue("3532405")]
        [Description("Nazare Paulista - SP")]
        NazarePaulista = 3532405,

        [EnumValue("3532504")]
        [Description("Neves Paulista - SP")]
        NevesPaulista = 3532504,

        [EnumValue("3532603")]
        [Description("Nhandeara - SP")]
        Nhandeara = 3532603,

        [EnumValue("3532801")]
        [Description("Nova Alianca - SP")]
        NovaAlianca = 3532801,

        [EnumValue("3532827")]
        [Description("Nova Campina - SP")]
        NovaCampina = 3532827,

        [EnumValue("3532843")]
        [Description("Nova Canaa Paulista - SP")]
        NovaCanaaPaulista = 3532843,

        [EnumValue("3532900")]
        [Description("Nova Europa - SP")]
        NovaEuropa = 3532900,

        [EnumValue("3533007")]
        [Description("Nova Granada - SP")]
        NovaGranada = 3533007,

        [EnumValue("3533106")]
        [Description("Nova Guataporanga - SP")]
        NovaGuataporanga = 3533106,

        [EnumValue("3533205")]
        [Description("Nova Independencia - SP")]
        NovaIndependencia = 3533205,

        [EnumValue("3533254")]
        [Description("Novais - SP")]
        Novais = 3533254,

        [EnumValue("3533304")]
        [Description("Nova Luzitania - SP")]
        NovaLuzitania = 3533304,

        [EnumValue("3533403")]
        [Description("Nova Odessa - SP")]
        NovaOdessa = 3533403,

        [EnumValue("3533502")]
        [Description("Novo Horizonte - SP")]
        NovoHorizonte_SP = 3533502,

        [EnumValue("3533601")]
        [Description("Nuporanga - SP")]
        Nuporanga = 3533601,

        [EnumValue("3533700")]
        [Description("Ocaucu - SP")]
        Ocaucu = 3533700,

        [EnumValue("3533809")]
        [Description("Oleo - SP")]
        Oleo = 3533809,

        [EnumValue("3533908")]
        [Description("Olimpia - SP")]
        Olimpia = 3533908,

        [EnumValue("3534005")]
        [Description("Onda Verde - SP")]
        OndaVerde = 3534005,

        [EnumValue("3534104")]
        [Description("Oriente - SP")]
        Oriente = 3534104,

        [EnumValue("3534203")]
        [Description("Orindiuva - SP")]
        Orindiuva = 3534203,

        [EnumValue("3534302")]
        [Description("Orlandia - SP")]
        Orlandia = 3534302,

        [EnumValue("3534401")]
        [Description("Osasco - SP")]
        Osasco = 3534401,

        [EnumValue("3534609")]
        [Description("Osvaldo Cruz - SP")]
        OsvaldoCruz = 3534609,

        [EnumValue("3534708")]
        [Description("Ourinhos - SP")]
        Ourinhos = 3534708,

        [EnumValue("3534757")]
        [Description("Ouroeste - SP")]
        Ouroeste = 3534757,

        [EnumValue("3534807")]
        [Description("Ouro Verde - SP")]
        OuroVerde_SP = 3534807,

        [EnumValue("3534906")]
        [Description("Pacaembu - SP")]
        Pacaembu = 3534906,

        [EnumValue("3535101")]
        [Description("Palmares Paulista - SP")]
        PalmaresPaulista = 3535101,

        [EnumValue("3535200")]
        [Description("Palmeira dOeste - SP")]
        PalmeiradOeste = 3535200,

        [EnumValue("3535309")]
        [Description("Palmital - SP")]
        Palmital_SP = 3535309,

        [EnumValue("3535408")]
        [Description("Panorama - SP")]
        Panorama = 3535408,

        [EnumValue("3535507")]
        [Description("Paraguacu Paulista - SP")]
        ParaguacuPaulista = 3535507,

        [EnumValue("3535606")]
        [Description("Paraibuna - SP")]
        Paraibuna = 3535606,

        [EnumValue("3535705")]
        [Description("Paraiso - SP")]
        Paraiso_SP = 3535705,

        [EnumValue("3535804")]
        [Description("Paranapanema - SP")]
        Paranapanema = 3535804,

        [EnumValue("3536000")]
        [Description("Parapua - SP")]
        Parapua = 3536000,

        [EnumValue("3536109")]
        [Description("Pardinho - SP")]
        Pardinho = 3536109,

        [EnumValue("3536208")]
        [Description("Pariquera-Acu - SP")]
        PariqueraAcu = 3536208,

        [EnumValue("3536257")]
        [Description("Parisi - SP")]
        Parisi = 3536257,

        [EnumValue("3536406")]
        [Description("Pauliceia - SP")]
        Pauliceia = 3536406,

        [EnumValue("3536505")]
        [Description("Paulinia - SP")]
        Paulinia = 3536505,

        [EnumValue("3536570")]
        [Description("Paulistania - SP")]
        Paulistania = 3536570,

        [EnumValue("3536703")]
        [Description("Pederneiras - SP")]
        Pederneiras = 3536703,

        [EnumValue("3536802")]
        [Description("Pedra Bela - SP")]
        PedraBela = 3536802,

        [EnumValue("3536901")]
        [Description("Pedranopolis - SP")]
        Pedranopolis = 3536901,

        [EnumValue("3537008")]
        [Description("Pedregulho - SP")]
        Pedregulho = 3537008,

        [EnumValue("3537107")]
        [Description("Pedreira - SP")]
        Pedreira = 3537107,

        [EnumValue("3537156")]
        [Description("Pedrinhas Paulista - SP")]
        PedrinhasPaulista = 3537156,

        [EnumValue("3537206")]
        [Description("Pedro de Toledo - SP")]
        PedrodeToledo = 3537206,

        [EnumValue("3537305")]
        [Description("Penapolis - SP")]
        Penapolis = 3537305,

        [EnumValue("3537404")]
        [Description("Pereira Barreto - SP")]
        PereiraBarreto = 3537404,

        [EnumValue("3537503")]
        [Description("Pereiras - SP")]
        Pereiras = 3537503,

        [EnumValue("3537602")]
        [Description("Peruibe - SP")]
        Peruibe = 3537602,

        [EnumValue("3537800")]
        [Description("Piedade - SP")]
        Piedade = 3537800,

        [EnumValue("3537909")]
        [Description("Pilar do Sul - SP")]
        PilardoSul = 3537909,

        [EnumValue("3538006")]
        [Description("Pindamonhangaba - SP")]
        Pindamonhangaba = 3538006,

        [EnumValue("3538105")]
        [Description("Pindorama - SP")]
        Pindorama = 3538105,

        [EnumValue("3538204")]
        [Description("Pinhalzinho - SP")]
        Pinhalzinho_SP = 3538204,

        [EnumValue("3538303")]
        [Description("Piquerobi - SP")]
        Piquerobi = 3538303,

        [EnumValue("3538709")]
        [Description("Piracicaba - SP")]
        Piracicaba = 3538709,

        [EnumValue("3538808")]
        [Description("Piraju - SP")]
        Piraju = 3538808,

        [EnumValue("3538907")]
        [Description("Pirajui - SP")]
        Pirajui = 3538907,

        [EnumValue("3539004")]
        [Description("Pirangi - SP")]
        Pirangi = 3539004,

        [EnumValue("3539103")]
        [Description("Pirapora do Bom Jesus - SP")]
        PiraporadoBomJesus = 3539103,

        [EnumValue("3539202")]
        [Description("Pirapozinho - SP")]
        Pirapozinho = 3539202,

        [EnumValue("3539301")]
        [Description("Pirassununga - SP")]
        Pirassununga = 3539301,

        [EnumValue("3539400")]
        [Description("Piratininga - SP")]
        Piratininga = 3539400,

        [EnumValue("3539509")]
        [Description("Pitangueiras - SP")]
        Pitangueiras_SP = 3539509,

        [EnumValue("3539707")]
        [Description("Platina - SP")]
        Platina = 3539707,

        [EnumValue("3539806")]
        [Description("Poa - SP")]
        Poa = 3539806,

        [EnumValue("3539905")]
        [Description("Poloni - SP")]
        Poloni = 3539905,

        [EnumValue("3540002")]
        [Description("Pompeia - SP")]
        Pompeia = 3540002,

        [EnumValue("3540101")]
        [Description("Pongai - SP")]
        Pongai = 3540101,

        [EnumValue("3540200")]
        [Description("Pontal - SP")]
        Pontal = 3540200,

        [EnumValue("3540259")]
        [Description("Pontalinda - SP")]
        Pontalinda = 3540259,

        [EnumValue("3540309")]
        [Description("Pontes Gestal - SP")]
        PontesGestal = 3540309,

        [EnumValue("3540507")]
        [Description("Porangaba - SP")]
        Porangaba = 3540507,

        [EnumValue("3540606")]
        [Description("Porto Feliz - SP")]
        PortoFeliz = 3540606,

        [EnumValue("3540705")]
        [Description("Porto Ferreira - SP")]
        PortoFerreira = 3540705,

        [EnumValue("3540754")]
        [Description("Potim - SP")]
        Potim = 3540754,

        [EnumValue("3540804")]
        [Description("Potirendaba - SP")]
        Potirendaba = 3540804,

        [EnumValue("3540853")]
        [Description("Pracinha - SP")]
        Pracinha = 3540853,

        [EnumValue("3540903")]
        [Description("Pradopolis - SP")]
        Pradopolis = 3540903,

        [EnumValue("3541000")]
        [Description("Praia Grande - SP")]
        PraiaGrande_SP = 3541000,

        [EnumValue("3541059")]
        [Description("Pratania - SP")]
        Pratania = 3541059,

        [EnumValue("3541109")]
        [Description("Presidente Alves - SP")]
        PresidenteAlves = 3541109,

        [EnumValue("3541208")]
        [Description("Presidente Bernardes - SP")]
        PresidenteBernardes_SP = 3541208,

        [EnumValue("3541307")]
        [Description("Presidente Epitacio - SP")]
        PresidenteEpitacio = 3541307,

        [EnumValue("3541406")]
        [Description("Presidente Prudente - SP")]
        PresidentePrudente = 3541406,

        [EnumValue("3541505")]
        [Description("Presidente Venceslau - SP")]
        PresidenteVenceslau = 3541505,

        [EnumValue("3541604")]
        [Description("Promissao - SP")]
        Promissao = 3541604,

        [EnumValue("3541653")]
        [Description("Quadra - SP")]
        Quadra = 3541653,

        [EnumValue("3541703")]
        [Description("Quata - SP")]
        Quata = 3541703,

        [EnumValue("3541802")]
        [Description("Queiroz - SP")]
        Queiroz = 3541802,

        [EnumValue("3541901")]
        [Description("Queluz - SP")]
        Queluz = 3541901,

        [EnumValue("3542008")]
        [Description("Quintana - SP")]
        Quintana = 3542008,

        [EnumValue("3542107")]
        [Description("Rafard - SP")]
        Rafard = 3542107,

        [EnumValue("3542206")]
        [Description("Rancharia - SP")]
        Rancharia = 3542206,

        [EnumValue("3542305")]
        [Description("Redencao da Serra - SP")]
        RedencaodaSerra = 3542305,

        [EnumValue("3542404")]
        [Description("Regente Feijo - SP")]
        RegenteFeijo = 3542404,

        [EnumValue("3542503")]
        [Description("Reginopolis - SP")]
        Reginopolis = 3542503,

        [EnumValue("3542602")]
        [Description("Registro - SP")]
        Registro = 3542602,

        [EnumValue("3542701")]
        [Description("Restinga - SP")]
        Restinga = 3542701,

        [EnumValue("3542909")]
        [Description("Ribeirao Bonito - SP")]
        RibeiraoBonito = 3542909,

        [EnumValue("3543006")]
        [Description("Ribeirao Branco - SP")]
        RibeiraoBranco = 3543006,

        [EnumValue("3543105")]
        [Description("Ribeirao Corrente - SP")]
        RibeiraoCorrente = 3543105,

        [EnumValue("3543204")]
        [Description("Ribeirao do Sul - SP")]
        RibeiraodoSul = 3543204,

        [EnumValue("3543238")]
        [Description("Ribeirao dos Indios - SP")]
        RibeiraodosIndios = 3543238,

        [EnumValue("3543253")]
        [Description("Ribeirao Grande - SP")]
        RibeiraoGrande = 3543253,

        [EnumValue("3543303")]
        [Description("Ribeirao Pires - SP")]
        RibeiraoPires = 3543303,

        [EnumValue("3543402")]
        [Description("Ribeirao Preto - SP")]
        RibeiraoPreto = 3543402,

        [EnumValue("3543501")]
        [Description("Riversul - SP")]
        Riversul = 3543501,

        [EnumValue("3543600")]
        [Description("Rifaina - SP")]
        Rifaina = 3543600,

        [EnumValue("3543709")]
        [Description("Rincao - SP")]
        Rincao = 3543709,

        [EnumValue("3543808")]
        [Description("Rinopolis - SP")]
        Rinopolis = 3543808,

        [EnumValue("3543907")]
        [Description("Rio Claro - SP")]
        RioClaro_SP = 3543907,

        [EnumValue("3544004")]
        [Description("Rio das Pedras - SP")]
        RiodasPedras = 3544004,

        [EnumValue("3544202")]
        [Description("Riolandia - SP")]
        Riolandia = 3544202,

        [EnumValue("3544251")]
        [Description("Rosana - SP")]
        Rosana = 3544251,

        [EnumValue("3544301")]
        [Description("Roseira - SP")]
        Roseira = 3544301,

        [EnumValue("3544400")]
        [Description("Rubiacea - SP")]
        Rubiacea = 3544400,

        [EnumValue("3544509")]
        [Description("Rubineia - SP")]
        Rubineia = 3544509,

        [EnumValue("3544608")]
        [Description("Sabino - SP")]
        Sabino = 3544608,

        [EnumValue("3544707")]
        [Description("Sagres - SP")]
        Sagres = 3544707,

        [EnumValue("3544806")]
        [Description("Sales - SP")]
        Sales = 3544806,

        [EnumValue("3544905")]
        [Description("Sales Oliveira - SP")]
        SalesOliveira = 3544905,

        [EnumValue("3545001")]
        [Description("Salesopolis - SP")]
        Salesopolis = 3545001,

        [EnumValue("3545100")]
        [Description("Salmourao - SP")]
        Salmourao = 3545100,

        [EnumValue("3545159")]
        [Description("Saltinho - SP")]
        Saltinho_SP = 3545159,

        [EnumValue("3545209")]
        [Description("Salto - SP")]
        Salto = 3545209,

        [EnumValue("3545308")]
        [Description("Salto de Pirapora - SP")]
        SaltodePirapora = 3545308,

        [EnumValue("3545407")]
        [Description("Salto Grande - SP")]
        SaltoGrande = 3545407,

        [EnumValue("3545506")]
        [Description("Sandovalina - SP")]
        Sandovalina = 3545506,

        [EnumValue("3545605")]
        [Description("Santa Adelia - SP")]
        SantaAdelia = 3545605,

        [EnumValue("3545803")]
        [Description("Santa Barbara dOeste - SP")]
        SantaBarbaradOeste = 3545803,

        [EnumValue("3546009")]
        [Description("Santa Branca - SP")]
        SantaBranca = 3546009,

        [EnumValue("3546108")]
        [Description("Santa Clara dOeste - SP")]
        SantaClaradOeste = 3546108,

        [EnumValue("3546207")]
        [Description("Santa Cruz da Conceicao - SP")]
        SantaCruzdaConceicao = 3546207,

        [EnumValue("3546306")]
        [Description("Santa Cruz das Palmeiras - SP")]
        SantaCruzdasPalmeiras = 3546306,

        [EnumValue("3546405")]
        [Description("Santa Cruz do Rio Pardo - SP")]
        SantaCruzdoRioPardo = 3546405,

        [EnumValue("3546504")]
        [Description("Santa Ernestina - SP")]
        SantaErnestina = 3546504,

        [EnumValue("3546603")]
        [Description("Santa Fe do Sul - SP")]
        SantaFedoSul = 3546603,

        [EnumValue("3546702")]
        [Description("Santa Gertrudes - SP")]
        SantaGertrudes = 3546702,

        [EnumValue("3546801")]
        [Description("Santa Isabel - SP")]
        SantaIsabel_SP = 3546801,

        [EnumValue("3546900")]
        [Description("Santa Lucia - SP")]
        SantaLucia_SP = 3546900,

        [EnumValue("3547007")]
        [Description("Santa Maria da Serra - SP")]
        SantaMariadaSerra = 3547007,

        [EnumValue("3547106")]
        [Description("Santa Mercedes - SP")]
        SantaMercedes = 3547106,

        [EnumValue("3547205")]
        [Description("Santana da Ponte Pensa - SP")]
        SantanadaPontePensa = 3547205,

        [EnumValue("3547304")]
        [Description("Santana de Parnaiba - SP")]
        SantanadeParnaiba = 3547304,

        [EnumValue("3547502")]
        [Description("Santa Rita do Passa Quatro - SP")]
        SantaRitadoPassaQuatro = 3547502,

        [EnumValue("3547601")]
        [Description("Santa Rosa de Viterbo - SP")]
        SantaRosadeViterbo = 3547601,

        [EnumValue("3547650")]
        [Description("Santa Salete - SP")]
        SantaSalete = 3547650,

        [EnumValue("3547700")]
        [Description("Santo Anastacio - SP")]
        SantoAnastacio = 3547700,

        [EnumValue("3547809")]
        [Description("Santo Andre - SP")]
        SantoAndre_SP = 3547809,

        [EnumValue("3547908")]
        [Description("Santo Antonio da Alegria - SP")]
        SantoAntoniodaAlegria = 3547908,

        [EnumValue("3548005")]
        [Description("Santo Antonio de Posse - SP")]
        SantoAntoniodePosse = 3548005,

        [EnumValue("3548054")]
        [Description("Santo Antonio do Aracangua - SP")]
        SantoAntoniodoAracangua = 3548054,

        [EnumValue("3548104")]
        [Description("Santo Antonio do Jardim - SP")]
        SantoAntoniodoJardim = 3548104,

        [EnumValue("3548203")]
        [Description("Santo Antonio do Pinhal - SP")]
        SantoAntoniodoPinhal = 3548203,

        [EnumValue("3548302")]
        [Description("Santo Expedito - SP")]
        SantoExpedito = 3548302,

        [EnumValue("3548401")]
        [Description("Santopolis do Aguapei - SP")]
        SantopolisdoAguapei = 3548401,

        [EnumValue("3548500")]
        [Description("Santos - SP")]
        Santos = 3548500,

        [EnumValue("3548609")]
        [Description("Sao Bento do Sapucai - SP")]
        SaoBentodoSapucai = 3548609,

        [EnumValue("3548708")]
        [Description("Sao Bernardo do Campo - SP")]
        SaoBernardodoCampo = 3548708,

        [EnumValue("3548807")]
        [Description("Sao Caetano do Sul - SP")]
        SaoCaetanodoSul = 3548807,

        [EnumValue("3548906")]
        [Description("Sao Carlos - SP")]
        SaoCarlos_SP = 3548906,

        [EnumValue("3549003")]
        [Description("Sao Francisco - SP")]
        SaoFrancisco_SP = 3549003,

        [EnumValue("3549102")]
        [Description("Sao Joao da Boa Vista - SP")]
        SaoJoaodaBoaVista = 3549102,

        [EnumValue("3549201")]
        [Description("Sao Joao das Duas Pontes - SP")]
        SaoJoaodasDuasPontes = 3549201,

        [EnumValue("3549300")]
        [Description("Sao Joao do Pau dAlho - SP")]
        SaoJoaodoPaudAlho = 3549300,

        [EnumValue("3549409")]
        [Description("Sao Joaquim da Barra - SP")]
        SaoJoaquimdaBarra = 3549409,

        [EnumValue("3549508")]
        [Description("Sao Jose da Bela Vista - SP")]
        SaoJosedaBelaVista = 3549508,

        [EnumValue("3549607")]
        [Description("Sao Jose do Barreiro - SP")]
        SaoJosedoBarreiro = 3549607,

        [EnumValue("3549706")]
        [Description("Sao Jose do Rio Pardo - SP")]
        SaoJosedoRioPardo = 3549706,

        [EnumValue("3549805")]
        [Description("Sao Jose do Rio Preto - SP")]
        SaoJosedoRioPreto = 3549805,

        [EnumValue("3549904")]
        [Description("Sao Jose dos Campos - SP")]
        SaoJosedosCampos = 3549904,

        [EnumValue("3549953")]
        [Description("Sao Lourenco da Serra - SP")]
        SaoLourencodaSerra = 3549953,

        [EnumValue("3550001")]
        [Description("Sao Luiz do Paraitinga - SP")]
        SaoLuizdoParaitinga = 3550001,

        [EnumValue("3550100")]
        [Description("Sao Manuel - SP")]
        SaoManuel = 3550100,

        [EnumValue("3550209")]
        [Description("Sao Miguel Arcanjo - SP")]
        SaoMiguelArcanjo = 3550209,

        [EnumValue("3550308")]
        [Description("Sao Paulo - SP")]
        SaoPaulo = 3550308,

        [EnumValue("3550407")]
        [Description("Sao Pedro - SP")]
        SaoPedro_SP = 3550407,

        [EnumValue("3550506")]
        [Description("Sao Pedro do Turvo - SP")]
        SaoPedrodoTurvo = 3550506,

        [EnumValue("3550605")]
        [Description("Sao Roque - SP")]
        SaoRoque = 3550605,

        [EnumValue("3550704")]
        [Description("Sao Sebastiao - SP")]
        SaoSebastiao_SP = 3550704,

        [EnumValue("3550803")]
        [Description("Sao Sebastiao da Grama - SP")]
        SaoSebastiaodaGrama = 3550803,

        [EnumValue("3550902")]
        [Description("Sao Simao - SP")]
        SaoSimao_SP = 3550902,

        [EnumValue("3551009")]
        [Description("Sao Vicente - SP")]
        SaoVicente_SP = 3551009,

        [EnumValue("3551108")]
        [Description("Sarapui - SP")]
        Sarapui = 3551108,

        [EnumValue("3551207")]
        [Description("Sarutaia - SP")]
        Sarutaia = 3551207,

        [EnumValue("3551306")]
        [Description("Sebastianopolis do Sul - SP")]
        SebastianopolisdoSul = 3551306,

        [EnumValue("3551405")]
        [Description("Serra Azul - SP")]
        SerraAzul = 3551405,

        [EnumValue("3551504")]
        [Description("Serrana - SP")]
        Serrana = 3551504,

        [EnumValue("3551603")]
        [Description("Serra Negra - SP")]
        SerraNegra = 3551603,

        [EnumValue("3551702")]
        [Description("Sertaozinho - SP")]
        Sertaozinho_SP = 3551702,

        [EnumValue("3551801")]
        [Description("Sete Barras - SP")]
        SeteBarras = 3551801,

        [EnumValue("3551900")]
        [Description("Severinia - SP")]
        Severinia = 3551900,

        [EnumValue("3552007")]
        [Description("Silveiras - SP")]
        Silveiras = 3552007,

        [EnumValue("3552106")]
        [Description("Socorro - SP")]
        Socorro = 3552106,

        [EnumValue("3552205")]
        [Description("Sorocaba - SP")]
        Sorocaba = 3552205,

        [EnumValue("3552304")]
        [Description("Sud Mennucci - SP")]
        SudMennucci = 3552304,

        [EnumValue("3552403")]
        [Description("Sumare - SP")]
        Sumare = 3552403,

        [EnumValue("3552502")]
        [Description("Suzano - SP")]
        Suzano = 3552502,

        [EnumValue("3552551")]
        [Description("Suzanapolis - SP")]
        Suzanapolis = 3552551,

        [EnumValue("3552601")]
        [Description("Tabapua - SP")]
        Tabapua = 3552601,

        [EnumValue("3552700")]
        [Description("Tabatinga - SP")]
        Tabatinga_SP = 3552700,

        [EnumValue("3552809")]
        [Description("Taboao da Serra - SP")]
        TaboaodaSerra = 3552809,

        [EnumValue("3552908")]
        [Description("Taciba - SP")]
        Taciba = 3552908,

        [EnumValue("3553005")]
        [Description("Taguai - SP")]
        Taguai = 3553005,

        [EnumValue("3553104")]
        [Description("Taiacu - SP")]
        Taiacu = 3553104,

        [EnumValue("3553203")]
        [Description("Taiuva - SP")]
        Taiuva = 3553203,

        [EnumValue("3553302")]
        [Description("Tambau - SP")]
        Tambau = 3553302,

        [EnumValue("3553500")]
        [Description("Tapirai - SP")]
        Tapirai_SP = 3553500,

        [EnumValue("3553609")]
        [Description("Tapiratiba - SP")]
        Tapiratiba = 3553609,

        [EnumValue("3553658")]
        [Description("Taquaral - SP")]
        Taquaral = 3553658,

        [EnumValue("3553708")]
        [Description("Taquaritinga - SP")]
        Taquaritinga = 3553708,

        [EnumValue("3553807")]
        [Description("Taquarituba - SP")]
        Taquarituba = 3553807,

        [EnumValue("3553856")]
        [Description("Taquarivai - SP")]
        Taquarivai = 3553856,

        [EnumValue("3553955")]
        [Description("Taruma - SP")]
        Taruma = 3553955,

        [EnumValue("3554003")]
        [Description("Tatui - SP")]
        Tatui = 3554003,

        [EnumValue("3554102")]
        [Description("Taubate - SP")]
        Taubate = 3554102,

        [EnumValue("3554201")]
        [Description("Tejupa - SP")]
        Tejupa = 3554201,

        [EnumValue("3554300")]
        [Description("Teodoro Sampaio - SP")]
        TeodoroSampaio_SP = 3554300,

        [EnumValue("3554409")]
        [Description("Terra Roxa - SP")]
        TerraRoxa_SP = 3554409,

        [EnumValue("3554508")]
        [Description("Tiete - SP")]
        Tiete = 3554508,

        [EnumValue("3554607")]
        [Description("Timburi - SP")]
        Timburi = 3554607,

        [EnumValue("3554656")]
        [Description("Torre de Pedra - SP")]
        TorredePedra = 3554656,

        [EnumValue("3554706")]
        [Description("Torrinha - SP")]
        Torrinha = 3554706,

        [EnumValue("3554755")]
        [Description("Trabiju - SP")]
        Trabiju = 3554755,

        [EnumValue("3554805")]
        [Description("Tremembe - SP")]
        Tremembe = 3554805,

        [EnumValue("3554953")]
        [Description("Tuiuti - SP")]
        Tuiuti = 3554953,

        [EnumValue("3555000")]
        [Description("Tupa - SP")]
        Tupa = 3555000,

        [EnumValue("3555109")]
        [Description("Tupi Paulista - SP")]
        TupiPaulista = 3555109,

        [EnumValue("3555356")]
        [Description("Ubarana - SP")]
        Ubarana = 3555356,

        [EnumValue("3555406")]
        [Description("Ubatuba - SP")]
        Ubatuba = 3555406,

        [EnumValue("3555505")]
        [Description("Ubirajara - SP")]
        Ubirajara = 3555505,

        [EnumValue("3555604")]
        [Description("Uchoa - SP")]
        Uchoa = 3555604,

        [EnumValue("3555802")]
        [Description("Urania - SP")]
        Urania = 3555802,

        [EnumValue("3556008")]
        [Description("Urupes - SP")]
        Urupes = 3556008,

        [EnumValue("3556107")]
        [Description("Valentim Gentil - SP")]
        ValentimGentil = 3556107,

        [EnumValue("3556206")]
        [Description("Valinhos - SP")]
        Valinhos = 3556206,

        [EnumValue("3556305")]
        [Description("Valparaiso - SP")]
        Valparaiso = 3556305,

        [EnumValue("3556354")]
        [Description("Vargem - SP")]
        Vargem_SP = 3556354,

        [EnumValue("3556404")]
        [Description("Vargem Grande do Sul - SP")]
        VargemGrandedoSul = 3556404,

        [EnumValue("3556453")]
        [Description("Vargem Grande Paulista - SP")]
        VargemGrandePaulista = 3556453,

        [EnumValue("3556503")]
        [Description("Varzea Paulista - SP")]
        VarzeaPaulista = 3556503,

        [EnumValue("3556602")]
        [Description("Vera Cruz - SP")]
        VeraCruz_SP = 3556602,

        [EnumValue("3556701")]
        [Description("Vinhedo - SP")]
        Vinhedo = 3556701,

        [EnumValue("3556800")]
        [Description("Viradouro - SP")]
        Viradouro = 3556800,

        [EnumValue("3556909")]
        [Description("Vista Alegre do Alto - SP")]
        VistaAlegredoAlto = 3556909,

        [EnumValue("3557006")]
        [Description("Votorantim - SP")]
        Votorantim = 3557006,

        [EnumValue("3557105")]
        [Description("Votuporanga - SP")]
        Votuporanga = 3557105,

        [EnumValue("3557154")]
        [Description("Zacarias - SP")]
        Zacarias = 3557154,

        [EnumValue("3557204")]
        [Description("Chavantes - SP")]
        Chavantes = 3557204,

        [EnumValue("3557303")]
        [Description("Estiva Gerbi - SP")]
        EstivaGerbi = 3557303,

        //======Tocantins======
        [EnumValue("1700251")]
        [Description("Abreulandia - TO")]
        Abreulandia = 1700251,

        [EnumValue("1700301")]
        [Description("Aguiarnopolis - TO")]
        Aguiarnopolis = 1700301,

        [EnumValue("1700400")]
        [Description("Almas - TO")]
        Almas = 1700400,

        [EnumValue("1701002")]
        [Description("Ananas - TO")]
        Ananas = 1701002,

        [EnumValue("1701051")]
        [Description("Angico - TO")]
        Angico = 1701051,

        [EnumValue("1701101")]
        [Description("Aparecida do Rio Negro - TO")]
        AparecidadoRioNegro = 1701101,

        [EnumValue("1701309")]
        [Description("Aragominas - TO")]
        Aragominas = 1701309,

        [EnumValue("1702109")]
        [Description("Araguaina - TO")]
        Araguaina = 1702109,

        [EnumValue("1702158")]
        [Description("Araguana - TO")]
        Araguana_TO = 1702158,

        [EnumValue("1702208")]
        [Description("Araguatins - TO")]
        Araguatins = 1702208,

        [EnumValue("1702307")]
        [Description("Arapoema - TO")]
        Arapoema = 1702307,

        [EnumValue("1702406")]
        [Description("Arraias - TO")]
        Arraias = 1702406,

        [EnumValue("1702554")]
        [Description("Augustinopolis - TO")]
        Augustinopolis = 1702554,

        [EnumValue("1702901")]
        [Description("Axixa do Tocantins - TO")]
        AxixadoTocantins = 1702901,

        [EnumValue("1703008")]
        [Description("Babaculandia - TO")]
        Babaculandia = 1703008,

        [EnumValue("1703057")]
        [Description("Bandeirantes do Tocantins - TO")]
        BandeirantesdoTocantins = 1703057,

        [EnumValue("1703073")]
        [Description("Barra do Ouro - TO")]
        BarradoOuro = 1703073,

        [EnumValue("1703107")]
        [Description("Barrolandia - TO")]
        Barrolandia = 1703107,

        [EnumValue("1703305")]
        [Description("Bom Jesus do Tocantins - TO")]
        BomJesusdoTocantins_TO = 1703305,

        [EnumValue("1703701")]
        [Description("Brejinho de Nazare - TO")]
        BrejinhodeNazare = 1703701,

        [EnumValue("1703826")]
        [Description("Cachoeirinha - TO")]
        Cachoeirinha_TO = 1703826,

        [EnumValue("1703842")]
        [Description("Campos Lindos - TO")]
        CamposLindos = 1703842,

        [EnumValue("1703867")]
        [Description("Cariri do Tocantins - TO")]
        CariridoTocantins = 1703867,

        [EnumValue("1703883")]
        [Description("Carmolandia - TO")]
        Carmolandia = 1703883,

        [EnumValue("1703909")]
        [Description("Caseara - TO")]
        Caseara = 1703909,

        [EnumValue("1705508")]
        [Description("Colinas do Tocantins - TO")]
        ColinasdoTocantins = 1705508,

        [EnumValue("1705557")]
        [Description("Combinado - TO")]
        Combinado = 1705557,

        [EnumValue("1705607")]
        [Description("Conceicao do Tocantins - TO")]
        ConceicaodoTocantins = 1705607,

        [EnumValue("1706001")]
        [Description("Couto Magalhaes - TO")]
        CoutoMagalhaes = 1706001,

        [EnumValue("1706100")]
        [Description("Cristalandia - TO")]
        Cristalandia = 1706100,

        [EnumValue("1706506")]
        [Description("Darcinopolis - TO")]
        Darcinopolis = 1706506,

        [EnumValue("1707009")]
        [Description("Dianopolis - TO")]
        Dianopolis = 1707009,

        [EnumValue("1707108")]
        [Description("Divinopolis do Tocantins - TO")]
        DivinopolisdoTocantins = 1707108,

        [EnumValue("1707207")]
        [Description("Dois Irmaos do Tocantins - TO")]
        DoisIrmaosdoTocantins = 1707207,

        [EnumValue("1707553")]
        [Description("Fatima - TO")]
        Fatima_TO = 1707553,

        [EnumValue("1707702")]
        [Description("Filadelfia - TO")]
        Filadelfia_TO = 1707702,

        [EnumValue("1708205")]
        [Description("Formoso do Araguaia - TO")]
        FormosodoAraguaia = 1708205,

        [EnumValue("1708254")]
        [Description("Tabocao - TO")]
        Tabocao = 1708254,

        [EnumValue("1708304")]
        [Description("Goianorte - TO")]
        Goianorte = 1708304,

        [EnumValue("1709005")]
        [Description("Goiatins - TO")]
        Goiatins = 1709005,

        [EnumValue("1709302")]
        [Description("Guarai - TO")]
        Guarai = 1709302,

        [EnumValue("1709500")]
        [Description("Gurupi - TO")]
        Gurupi = 1709500,

        [EnumValue("1709807")]
        [Description("Ipueiras - TO")]
        Ipueiras_TO = 1709807,

        [EnumValue("1710706")]
        [Description("Itaguatins - TO")]
        Itaguatins = 1710706,

        [EnumValue("1711100")]
        [Description("Itapora do Tocantins - TO")]
        ItaporadoTocantins = 1711100,

        [EnumValue("1711803")]
        [Description("Juarina - TO")]
        Juarina = 1711803,

        [EnumValue("1711902")]
        [Description("Lagoa da Confusao - TO")]
        LagoadaConfusao = 1711902,

        [EnumValue("1712009")]
        [Description("Lajeado - TO")]
        Lajeado_TO = 1712009,

        [EnumValue("1712157")]
        [Description("Lavandeira - TO")]
        Lavandeira = 1712157,

        [EnumValue("1712405")]
        [Description("Lizarda - TO")]
        Lizarda = 1712405,

        [EnumValue("1712504")]
        [Description("Marianopolis do Tocantins - TO")]
        MarianopolisdoTocantins = 1712504,

        [EnumValue("1712702")]
        [Description("Mateiros - TO")]
        Mateiros = 1712702,

        [EnumValue("1712801")]
        [Description("Maurilandia do Tocantins - TO")]
        MaurilandiadoTocantins = 1712801,

        [EnumValue("1713205")]
        [Description("Miracema do Tocantins - TO")]
        MiracemadoTocantins = 1713205,

        [EnumValue("1713304")]
        [Description("Miranorte - TO")]
        Miranorte = 1713304,

        [EnumValue("1713601")]
        [Description("Monte do Carmo - TO")]
        MontedoCarmo = 1713601,

        [EnumValue("1713700")]
        [Description("Monte Santo do Tocantins - TO")]
        MonteSantodoTocantins = 1713700,

        [EnumValue("1713809")]
        [Description("Palmeiras do Tocantins - TO")]
        PalmeirasdoTocantins = 1713809,

        [EnumValue("1713957")]
        [Description("Muricilandia - TO")]
        Muricilandia = 1713957,

        [EnumValue("1714203")]
        [Description("Natividade - TO")]
        Natividade_TO = 1714203,

        [EnumValue("1714302")]
        [Description("Nazare - TO")]
        Nazare_TO = 1714302,

        [EnumValue("1714880")]
        [Description("Nova Olinda - TO")]
        NovaOlinda_TO = 1714880,

        [EnumValue("1715002")]
        [Description("Nova Rosalandia - TO")]
        NovaRosalandia = 1715002,

        [EnumValue("1715101")]
        [Description("Novo Acordo - TO")]
        NovoAcordo = 1715101,

        [EnumValue("1715259")]
        [Description("Novo Jardim - TO")]
        NovoJardim = 1715259,

        [EnumValue("1715705")]
        [Description("Palmeirante - TO")]
        Palmeirante = 1715705,

        [EnumValue("1715754")]
        [Description("Palmeiropolis - TO")]
        Palmeiropolis = 1715754,

        [EnumValue("1716109")]
        [Description("Paraiso do Tocantins - TO")]
        ParaisodoTocantins = 1716109,

        [EnumValue("1716307")]
        [Description("Pau DArco - TO")]
        PauDArco_TO = 1716307,

        [EnumValue("1716505")]
        [Description("Pedro Afonso - TO")]
        PedroAfonso = 1716505,

        [EnumValue("1716604")]
        [Description("Peixe - TO")]
        Peixe = 1716604,

        [EnumValue("1716653")]
        [Description("Pequizeiro - TO")]
        Pequizeiro = 1716653,

        [EnumValue("1716703")]
        [Description("Colmeia - TO")]
        Colmeia = 1716703,

        [EnumValue("1717008")]
        [Description("Pindorama do Tocantins - TO")]
        PindoramadoTocantins = 1717008,

        [EnumValue("1717206")]
        [Description("Piraque - TO")]
        Piraque = 1717206,

        [EnumValue("1717909")]
        [Description("Ponte Alta do Tocantins - TO")]
        PonteAltadoTocantins = 1717909,

        [EnumValue("1718006")]
        [Description("Porto Alegre do Tocantins - TO")]
        PortoAlegredoTocantins = 1718006,

        [EnumValue("1718204")]
        [Description("Porto Nacional - TO")]
        PortoNacional = 1718204,

        [EnumValue("1718303")]
        [Description("Praia Norte - TO")]
        PraiaNorte = 1718303,

        [EnumValue("1718402")]
        [Description("Presidente Kennedy - TO")]
        PresidenteKennedy_TO = 1718402,

        [EnumValue("1718501")]
        [Description("Recursolandia - TO")]
        Recursolandia = 1718501,

        [EnumValue("1718550")]
        [Description("Riachinho - TO")]
        Riachinho_TO = 1718550,

        [EnumValue("1718659")]
        [Description("Rio da Conceicao - TO")]
        RiodaConceicao = 1718659,

        [EnumValue("1718840")]
        [Description("Sandolandia - TO")]
        Sandolandia = 1718840,

        [EnumValue("1718865")]
        [Description("Santa Fe do Araguaia - TO")]
        SantaFedoAraguaia = 1718865,

        [EnumValue("1718881")]
        [Description("Santa Maria do Tocantins - TO")]
        SantaMariadoTocantins = 1718881,

        [EnumValue("1718899")]
        [Description("Santa Rita do Tocantins - TO")]
        SantaRitadoTocantins = 1718899,

        [EnumValue("1719004")]
        [Description("Santa Tereza do Tocantins - TO")]
        SantaTerezadoTocantins = 1719004,

        [EnumValue("1720002")]
        [Description("Santa Terezinha do Tocantins - TO")]
        SantaTerezinhadoTocantins = 1720002,

        [EnumValue("1720150")]
        [Description("Sao Felix do Tocantins - TO")]
        SaoFelixdoTocantins = 1720150,

        [EnumValue("1720259")]
        [Description("Sao Salvador do Tocantins - TO")]
        SaoSalvadordoTocantins = 1720259,

        [EnumValue("1720309")]
        [Description("Sao Sebastiao do Tocantins - TO")]
        SaoSebastiaodoTocantins = 1720309,

        [EnumValue("1720499")]
        [Description("Sao Valerio - TO")]
        SaoValerio = 1720499,

        [EnumValue("1720655")]
        [Description("Silvanopolis - TO")]
        Silvanopolis = 1720655,

        [EnumValue("1720903")]
        [Description("Taguatinga - TO")]
        Taguatinga = 1720903,

        [EnumValue("1720937")]
        [Description("Taipas do Tocantins - TO")]
        TaipasdoTocantins = 1720937,

        [EnumValue("1720978")]
        [Description("Talisma - TO")]
        Talisma = 1720978,

        [EnumValue("1721000")]
        [Description("Palmas - TO")]
        Palmas_TO = 1721000,

        [EnumValue("1721109")]
        [Description("Tocantinia - TO")]
        Tocantinia = 1721109,

        [EnumValue("1721208")]
        [Description("Tocantinopolis - TO")]
        Tocantinopolis = 1721208,

        [EnumValue("1721307")]
        [Description("Tupiratins - TO")]
        Tupiratins = 1721307,

        [EnumValue("1722081")]
        [Description("Wanderlandia - TO")]
        Wanderlandia = 1722081,

        [EnumValue("1722107")]
        [Description("Xambioa - TO")]
        Xambioa = 1722107,

        //======Distrito Federal======
        [EnumValue("5300108")]
        [Description("Brasilia - DF")]
        Brasilia = 5300108

    }
}
