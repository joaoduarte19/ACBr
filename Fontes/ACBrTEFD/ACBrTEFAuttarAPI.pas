{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la }
{ sob os termos da Licença Pública Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a versão 2.1 da Licença, ou (a seu critério) }
{ qualquer versão posterior.                                                   }
{                                                                              }
{  Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU      }
{ ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENÇA.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Você deve ter recebido uma cópia da Licença Pública Geral Menor do GNU junto}
{ com esta biblioteca; se não, escreva para a Free Software Foundation, Inc.,  }
{ no endereço 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Você também pode obter uma copia da licença em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Simões de Almeida - daniel@projetoacbr.com.br - www.projetoacbr.com.br}
{       Rua Coronel Aureliano de Camargo, 963 - Tatuí - SP - 18270-170         }
{******************************************************************************}

{$I ACBr.inc}

unit ACBrTEFAuttarAPI;

interface

uses
  Classes, SysUtils,
  ACBrTEFAPIComum, ACBrTEFComum,
  ACBrBase, ACBrXmlDocument;

const
  CTFClientFolderName = 'CTFClient';
  {$IfDef MSWINDOWS}
   CCTFClientLib = 'ctfclient.dll';
   CDefaultPathCTFClient = 'C:\'+CTFClientFolderName+'\';
  {$Else}
   CCTFClientLib = 'libctfclient.so';
   CDefaultPathCTFClient = '/opt/'+CTFClientFolderName+'/';
  {$EndIf}
  CCTFClientDirBin = 'bin';
  CCTFClientDirJre = 'jre';
  CCTFClientDirLib = 'lib';
  CCTFClientConfigFile = 'configCTFClient.xml';
  CCTF_TCP_IP = '127.0.0.1';
  CCTF_TCP_PORT = 2500;

  RET_OK = 0;
  RET_CONTINUA = 99;

  PARAM_PINPAD = 'params-pinpad';
  PARAM_HTTPS = 'suporte-https';
  PARAM_HOST = 'host-ctfclient';
  PARAM_PATH_CTF = 'path-ctfclient';

  CENV_CTFCLIENT_HOME = 'CTFCLIENT_HOME';
  CENV_JAVA_HOME = 'JAVA_HOME';

  { Comandos da API }
  CMD_CONTINUAR = 0;
  CMD_RECUPERAR_SUBCAMPO = 0;            // 00: Recuperar subcampo
  CMD_EXIBIR_MENSAGEM = 1;               // 01: Exibir mensagem
  CMD_EXIBIR_TITULO = 2;                 // 02: Exibir título
  CMD_LIMPAR_DISPLAY = 3;                // 03: Limpar display
  CMD_CONFIRMACAO_SIM_NAO = 4;           // 04: Obter confirmação SIM/NÃO
  CMD_EXIBIR_MENU = 5;                   // 05: Exibir menu
  CMD_AGUARDAR_TECLA = 6;                // 06: Aguardar tecla
  CMD_PERGUNTAR_CAMPO = 7;               // 07: Perguntar campo
  CMD_CANCELAR = 8;                      // 08: Cancelar
  CMD_EXIBIR_MENU_TIMEOUT = 9;           // 09: Exibir menu com Timeout

  { Operações (Anexo V - Manual de Integração) }
  OP_REIMPRESSAO = 12;                    // Reimpressão do Último Comprovante
  OP_REIMPRESSAO_ESPECIFICA = 13;         // Reimpressão de Comprovante Específico (NSU/Data)
  OP_DEBITO = 101;                        // Débito
  OP_DEBITO_PREDATADO = 103;
  OP_DEBITO_PARCELADO = 104;
  OP_DEBITO_VOUCHER = 106;                // Débito Voucher (benefício)
  OP_CONSULTA_CDC = 110;                  // Consulta CDC c/ Parcela à Vista
  OP_CREDITO_VISTA = 112;                 // Crédito à vista
  OP_CREDITO_PARCELADO_LOJA = 113;        // Crédito parcelado sem juros (lojista)
  OP_CREDITO_PARCELADO_EMISSOR = 114;     // Crédito parcelado com juros (administradora)
  OP_PRE_AUTORIZACAO_CREDITO = 119;       // Pré-autorização Crédito
  OP_CONSULTA_CREDITO_DIGITADO = 126;     // Consulta Crédito Digitado
  OP_CANCELAMENTO = 128;                  // Cancelamento Genérico
  OP_CONSULTA_CHEQUE = 129;               // Consulta Cheque
  OP_CREDITO_PRIVATE_LABEL = 142;         // Crédito Private Label
  OP_PAGAMENTO_TITULO = 153;              // Pagamento de Título
  OP_CONSULTA_FATURA = 182;               // Consulta de Fatura
  OP_TRANSACAO_GENERICA = 222;            // Transação genérica (não cartão)
  OP_CREDITO_GENERICO = 223;              // Crédito genérico
  OP_DEBITO_GENERICO = 224;               // Débito genérico
  OP_FECHAMENTO = 225;                    // Fechamento/Início Dia
  OP_CONSULTA_CONFIGURACAO = 228;         // Consulta de configuração/versão
  OP_CONSULTA_SALDO_CREDITO = 250;        // Consulta de saldo de crédito
  OP_CONSULTA_SALDO_DEBITO = 251;         // Consulta de saldo de débito
  OP_FUEL_CONTROL = 255;                  // Fuel Control (cartão frota)
  OP_ATIVACAO_PRE_PAGO = 260;             // Ativação de Cartão Pré-Pago
  OP_CONFIRMACAO_NSU_CTF = 280;           // Confirmação pelo NSU do CTF (Manual v1.82)
  OP_DESFAZIMENTO_NSU_CTF = 281;          // Desfazimento pelo NSU do CTF (Manual v1.82)
  OP_CONSULTA_ESTABELECIMENTOS_MULTI_EC = 329; // Consulta de Estabelecimentos Multi-EC
  OP_CARGA_TABELAS = 400;                 // Carga de Tabelas (v1.81)
  OP_CANCELAMENTO_CREDITO_DIGITADO = 411; // Cancelamento do Crédito Digitado (v1.80)
  OP_CARTAO_QUALIDADE = 421;              // Cartão Qualidade (v1.56)
  OP_PAGAMENTO_PIX = 422;                 // Pagamento Pix
  OP_CONSULTA_PIX = 423;                  // Consulta Pix
  OP_RECARGA_PRE_PAGO = 424;              // Recarga de Cartão Pré-Pago
  OP_CONSULTA_STATUS_TRANSACAO = 426;     // Consulta de Status de Transação (v1.72)
  OP_DEVOLUCAO_PIX = 431;                 // Devolução Pix (v1.76)
  OP_CONFIGURAR_CTFCLIENT = 800;          // Menu de Configuração do CTFClient
  OP_AUTENTICACAO_TERMINAL = 801;         // Autenticação do terminal (v1.63)
  OP_CAPTURA_DADO_PINPAD = 908;           // Captura de dados no pinpad

  { Subcampos de identificação e controle }

  SC_E_NSU_CTF_ORIGINAL = 7012;
  SC_E_NUMERO_DOCTO_FISCAL = 7020;
  SC_E_NUMERO_CHEQUE = 7021;
  SC_E_DATA_CHEQUE_DDMMAA = 7022;
  SC_E_NUMERO_BANCO = 7023;
  SC_E_NUMERO_AGENCIA = 7024;
  SC_E_TIPO_DOCUMENTO = 7025;
  SC_E_DOCUMENTO_CLIENTE = 7026;
  SC_E_NUMERO_PRACA = 7028;
  SC_E_TAXA_SERVICO = 7034;
  SC_E_VALOR_ENTRADA = 7035;
  SC_E_TIPO_GARANTIA_PREDATADO = 7037;
  SC_E_VALOR_SAQUE = 7038;
  SC_E_CODIGO_SEGURANCA = 7039;
  SC_E_DATA_PRE_DATADA = 7069;
  SC_E_TAXA_EMBARQUE = 7047;
  SC_E_BAIXA_ORDEM_SERVICO = 7075;
  SC_E_DATA_PARCELA_DEBITO_CDC = 7097;
  SC_E_DATA_VENCTO_CORBAN_DDMMAA = 7108;
  SC_E_VALOR_DESCONTO = 7109;
  SC_E_VALOR_CANCELAMENTO = 7179;
  SC_E_NUMERO_CICLOS = 7190;
  SC_E_DATA_EMISSAO_CARTAO_MMAA = 7191;
  SC_E_COD_PARCELE_MAIS = 7204;
  SC_E_MATRICULA_OPERADOR = 7217;
  SC_E_MATRICULA_SUPERVISOR = 7225;
  SC_E_DADOS_CDC_ELETRONICO = 7227;
  SC_E_NUMERO_ITEM = 7229;
  SC_E_RG = 7235;
  SC_E_FONE_FIXO = 7236;
  SC_E_FONE_MOVEL = 7237;
  SC_E_CNPJ = 7238;
  SC_E_NUMERO_PEDIDO = 7240;
  SC_E_SERVICO_COMBUSTIVEL = 7243;
  SC_E_VOUCHER_CTAH = 7247;
  SC_E_DOCTO_DEPOSITANTE = 7282;
  SC_E_DOCTO_BENEFICIARIO = 7283;
  SC_E_COD_PIN_TRANSFERENCIA = 7284;
  SC_E_ENDERECO = 7317;
  SC_E_NUMERO_ENDERECO = 7318;
  SC_E_COMPLEMENTO_ENDERECO = 7319;
  SC_E_BLOCO_ENDERECO = 7320;
  SC_E_CEP_ENDERECO = 7321;
  SC_E_BAIRRO_ENDERECO = 7322;
  SC_E_CMC7 = 7323;
  SC_E_ULTIMOS_4 = 7324;
  SC_E_CODIGO_CARGA = 7325;
  SC_E_CODIGO_OCORRENCIA = 7326;
  SC_E_BAIXA_TECNICA = 7327;
  SC_E_ENDERECO_ESTABELECIMENTO = 7328;
  SC_E_SP_CREDENCIADA = 7329;
  SC_E_IDENTIFICACAO_TECNICO = 7330;
  SC_E_NOME_ESTABELECIMENTO = 7331;
  SC_E_NUMERO_OS = 7332;
  SC_E_DDTTTTTTTT = 7333;
  SC_E_NUMERO_CONTRACORRENTE = 7334;
  SC_E_CPF = 7335;
  SC_E_DDD = 7336;
  SC_E_TELEFONE = 7337;
  SC_E_INFO_ADICIONAL = 7338;
  SC_E_VALOR_PARCELA = 7339;
  SC_E_DATA_ABERTURA_CONTA_DDMM = 7340;
  SC_E_FLAG_SALDO_VOUCHER = 7341;
  SC_E_DECISAO_OPERACAO = 7342;
  SC_E_CODIGO_AUTORIZACAO = 7343;
  SC_E_CODIGO_BARRAS = 7344;
  SC_E_BARRAS_TITULO_BLOCO1 = 7346;
  SC_E_BARRAS_TITULO_BLOCO2 = 7347;
  SC_E_BARRAS_TITULO_BLOCO3 = 7348;
  SC_E_BARRAS_TITULO_BLOCO4 = 7349;
  SC_E_BARRAS_TITULO_BLOCO5 = 7350;
  SC_E_BARRAS_CONVENIO_BLOCO1 = 7351;
  SC_E_BARRAS_CONVENIO_BLOCO2 = 7352;
  SC_E_BARRAS_CONVENIO_BLOCO3 = 7353;
  SC_E_BARRAS_CONVENIO_BLOCO4 = 7354;
  SC_E_FLAG_TRANSACAO_PENDENTE = 7358;
  SC_E_VALOR_RECARGA_FONE = 7359;
  SC_E_NUM_PREMIOS = 7386;
  SC_E_FLAG_CONSULTA_INTEGRACAO = 7391;
  SC_E_USUARIO_PDV = 7400;
  SC_E_CODIGO_CLIENTE = 7402;
  SC_E_DATA_NASCIMENTO_CLIENTE = 7403;
  SC_E_CELULAR = 7404;
  SC_E_DDD_CELULAR = 7405;
  SC_E_ID_WALLET = 7538;
  SC_E_MCC = 7539;
  SC_E_TIPO_TERMINAL = 7540;
  SC_E_SOFT_DESCRIPTOR = 7541;
  SC_E_COD_TERMINAL = 7900;
  SC_E_COD_EMPRESA = 7901;
  SC_E_COD_LOJA = 7902;
  SC_E_COD_PDV = 7903;
  SC_E_DDD_CELULAR2 = 7907;
  SC_E_BOMBA_COMBUSTIVEL = 7910;
  SC_E_MEIO_PAGTO_FATURA = 7914;
  SC_E_FORMA_IDENTIFICACAO_FATURA = 7915;
  SC_E_TIPO_AUTORIZADORA = 7916;
  SC_E_LOGIN_TERMINAL = 7917;
  SC_E_SENHA_TERMINAL = 7918;
  SC_E_CNPJ_TERMINAL = 7919;
  SC_E_MEIO_PAGTO = 7920;
  SC_E_TIPO_DADO_PINPAD = 7924;
  SC_E_CONFIRMAR_DADO_PINPAD = 7944;
  SC_E_TAM_MIN_DADO_PINPAD = 7945;
  SC_E_TAM_MAX_DADO_PINPAD = 7946;

  SC_ES_VALOR_TRANSACAO = 7005;
  SC_ES_NUMERO_CARTAO_DIGITADO = 7006;
  SC_ES_NUMERO_PARCELAS = 7008;
  SC_ES_DATA_VENCTO_CARTAO_MMAA = 7010;
  SC_ES_DATA_AGENDAMENTO_PREDATADO = 7094;
  SC_ES_VALOR_ACRESCIMO = 7110;
  SC_ES_VALOR_DEVIDO_DOCUMENTO = 7112;
  SC_ES_VALOR_PARCELA_PLANO = 7150;
  SC_ES_DATA_TRANSACAO_ORIGINAL = 7161;
  SC_ES_PRODUTO_CONVENIO_FARMACIA = 7188;
  SC_ES_FORMA_PAGTO_FARMACIA = 7189;
  SC_ES_NUMERO_CARTAO = 7356;
  SC_ES_IDENTIFICADOR_CONSULTA = 7390;
  SC_ES_IDENTIFICADOR_TRANSACAO_PIX = 7516;
  SC_ES_PSP_PIX = 7517;
  SC_ES_NOME_CLIENTE_CARTAO = 7401;

  SC_S_CODIGO_RETORNO = 7000;
  SC_S_CODIGO_TRANSACAO_CTF = 7001;
  SC_S_COD_AUTORIZADORA_CTF = 7011;
  SC_S_CODIGO_RESPOSTA = 7015;
  SC_S_DADOS_RETORNADOS = 7029;
  SC_S_NSU_TEF = 7031;
  SC_S_NSU_AUTORIZADORA = 7081;
  SC_S_CODIGO_APROVACAO_AUTORIZADORA = 7095;
  SC_S_ERRO_AUTORIZADORA = 7187;
  SC_S_MAC = 7195;
  SC_S_CODIGO_ERRO = 7300;
  SC_S_DESCRICAO_TRANSACAO = 7301;
  SC_S_VIA_CLIENTE = 7302;
  SC_S_VIA_LOJISTA = 7303;
  SC_S_REIMPRESSAO_VIA_CLIENTE = 7304;
  SC_S_REIMPRESSAO_VIA_LOJISTA = 7305;
  SC_S_NOME_AUTORIZADORA_CTF = 7306;
  SC_S_NOME_VAN_CTF = 7308;
  SC_S_CODIGO_INSTITUICAO_CTF = 7309;
  SC_S_NOME_INSTITUICAO_CTF = 7310;
  SC_S_DATA_TRANSACAO_CTF_DDMMAAAA = 7311;
  SC_S_HORA_TRANSACAO_CTF_HHMMSS = 7312;
  SC_S_LOGOMARCA = 7313;
  SC_S_VALOR_SALDO = 7314;
  SC_S_VALOR_TOTAL_TRANSACAO = 7315;
  SC_S_TAXA_JUROS_PLANO = 7316;
  SC_S_NSU_AUTORIZADORA_ALFA = 7381;
  SC_S_CUPOM_REDUZIDO = 7384;
  SC_S_MSG_DISPLAY_TRANSACAO = 7385;
  SC_S_VALOR_DESCONTO = 7387;
  SC_S_TIPO_CAPTURA_PREAUT = 7388;
  SC_S_NOME_BANDEIRA_CARTAO = 7389;
  SC_S_CODIGO_AUTORIZACAO = 7564;
  SC_S_METODO_VERIFICACAO = 7939;
  SC_S_NOME_REDE_ADQUIRENTE = 7942;
  SC_S_CODIGO_VAN = 7943;
  SC_S_STATUS_PAGSEGURO = 7947;
  SC_S_NOME_TRANSACAO = 7948;
  SC_S_CODIGO_TRANSACAO_ORIGINAL = 7949;

resourcestring
  sErrDirCTFClientNaoEncontrado = 'Pasta da CTFClient, não encontrado: %s';
  sErrDirCTFClientInvalido = 'Subdiretório "%s" da CTFClient, não encontrado na Pasta: %s';
  sErrArqCTFClientNaoEncontrado = 'Arquivo da CTFClient: "%s", não encontrado em: %s';
  sErrCTFClientNaoIniciado = 'O Serviço CTFClient não pode ser iniciado';

type
  EACBrTEFAuttarAPI = class(EACBrTEFAPIErro);

  TACBrTEFAuttarQuandoExibirMensagem = procedure(
    const Mensagem: String;
    Tela: Integer;   //  '1' display do operador, '2' display do cliente e com '3' ambos os displays.
    MilissegundosExibicao: Integer;  // 0 - Para com OK; Positivo - Aguarda N milissegundos, e apaga a msg; Negativo - Apenas exibe a Msg (não aguarda e não apaga msg)
    out Cancelar: Boolean
    ) of object;

  TACBrTEFAuttarQuandoPerguntarMenu = procedure(
    const Titulo: String;
    Opcoes: TStringList;
    out ItemSelecionado: Integer) of object;  // Retorna o Item Selecionado, iniciando com 0, -2 - Volta no Fluxo, -1 - Cancela o Fluxo

  TACBrTEFAuttarQuandoPerguntarCampo = procedure(
    const Titulo: String;
    TipoCampo, TamMaximo: Integer;
    ZerosAEsquerda: Boolean;
    out Resposta: String;
    out Cancelar: Boolean) of object;

  TACBrTEFAuttarTransacaoEmAndamento = procedure(out Cancelar: Boolean) of object;

  { TACBrTEFAuttarAPI }

  TACBrTEFAuttarAPI = class
  private
    fCNPJAut: String;
    fCodEstabelecimento: String;
    fCodLoja: String;
    fCodPDV: String;
    fCriptografia: Boolean;
    fEfetuarLog: Boolean;
    fEmTransacao: Boolean;
    fEnderecoTCP: String;
    fHomologacao: Boolean;
    fInterativo: Boolean;
    fLoginAut: String;
    fMensagemPinPad: String;
    fNomeAplicacao: String;
    fPortaTCP: Integer;
    fPortaPinPad: String;
    fQuandoExibirMensagem: TACBrTEFAuttarQuandoExibirMensagem;
    fQuandoGravarLog: TACBrGravarLog;
    fParametrosInicializacao: String;
    fPathCTFClient: String;
    fInicializada: Boolean;
    fCarregada: Boolean;
    fQuandoPerguntarCampo: TACBrTEFAuttarQuandoPerguntarCampo;
    fQuandoPerguntarMenu: TACBrTEFAuttarQuandoPerguntarMenu;
    fQuandoTransacaoEmAndamento: TACBrTEFAuttarTransacaoEmAndamento;
    fSenhaAut: String;
    fSubCampos: TACBrTEFParametros;
    fSuporteHttps: Boolean;
    fTituloMenu: String;
    fUltimaMensagem: String;
    fVersaoAplicacao: String;

    xiniciaClientCTF: procedure(resultado, terminal, versao_ac, nome_ac, num_sites,
      lista_ips, criptografia, log, interativo, parametros: PAnsiChar);
      {$IfDef MSWINDOWS}stdcall{$Else}cdecl{$EndIf};

    xiniciaTransacaoCTF: procedure(resultado, operacao, valor, num_doc, data_cli,
      num_trans: PAnsiChar);
      {$IfDef MSWINDOWS}stdcall{$Else}cdecl{$EndIf};

    xiniciaTransacaoCTFext: procedure(resultado, operacao, valor, num_doc, data_cli,
      num_trans, dados: PAnsiChar);
      {$IfDef MSWINDOWS}stdcall{$Else}cdecl{$EndIf};

    xcontinuaTransacaoCTF: procedure(resultado, comando, num_sc, p_sc, tam_sc,
      aux: PAnsiChar);
      {$IfDef MSWINDOWS}stdcall{$Else}cdecl{$EndIf};

    xfinalizaTransacaoCTF: procedure(resultado, confirmar, num_trans,
      data_cli: PAnsiChar);
      {$IfDef MSWINDOWS}stdcall{$Else}cdecl{$EndIf};

    xfinalizaTransacaoCTFext: procedure(resultado, confirmar, num_trans, data_cli,
      dados: PAnsiChar);
    {$IfDef MSWINDOWS}stdcall{$Else}cdecl{$EndIf};

    procedure SetCNPJAut(AValue: String);
    procedure SetCodEstabelecimento(AValue: String);
    procedure SetCodLoja(AValue: String);
    procedure SetCodPDV(AValue: String);
    procedure SetEnderecoTCP(AValue: String);
    procedure SetInicializada(AValue: Boolean);
    procedure SetPathCTFClient(const AValue: String);
    function CheckPathCTFCLient: String;
    procedure CheckEnvirontmentVars;
    function CalcCTFClientPath(const ASubFolder: String; VerificarSeExiste: Boolean = True): String;

    function CTFClientIsRunning: Boolean;
    procedure RunCTFClientDesktop;
    procedure ConfigureConfigCTFClientXml;
    function GetCTFClientConfigFileName: String;
    function GetCTFClientConfigFileValue(const ANode, AAttribute: String): String;
    function SetCTFClientConfigFileValue(const AParameterSet, AParameter, NewValue: String): Boolean;
    function FindNodeWithAttribute(AParent: TACBrXmlNode; NodeName: String;
      AttributeName: String): TACBrXmlNode;

    function IniciaTransacaoCTF(Operacao: Integer; Valor: Double = 0;
      const NumDocto: String = ''; DataFiscal: TDateTime = 0; NumTransacao: Integer = 0;
      const Dados: String = ''): Integer;
    function ContinuaTransacaoCTF(var Comando: Integer; var NumSubcampo: Integer;
      var Buffer: String; var Display: Integer): Integer;
    function FinalizaTransacaoCTF(Confirmar: Boolean; NumTransacao: Integer = 0;
      DataFiscal: TDateTime = 0; const Dados: String = ''): Integer;

  protected
    procedure LoadLibFunctions;
    procedure UnLoadLibFunctions;
    procedure ClearMethodPointers;

    procedure DoException(const AErrorMsg: String);
    procedure GravarLog(const AString: AnsiString; Traduz: Boolean = False);
    procedure TratarErroCTF(CodErro: LongInt);

    function IniciarClientCTF: Integer;
    procedure ContinuarRequisicaoCTF;

    procedure DoExibirMensagem(const Mensagem: String; Tela: Integer;
      MilissegundosExibicao: Integer; out Cancelar: Boolean);
    procedure LimparDisplay(Tela: Integer = 3);  // 1-Operador, 2-Cliente, 3-Ambos
    function DoPerguntarMenu(const Opcoes: String; const Titulo: String = ''): Integer;
    function DoPerguntarCampo(TipoCampo, TamMaximo: Integer; ZerosAEsquerda: Boolean;
      var Cancelar: Boolean; const Titulo: String = ''): String;

  public
    constructor Create;
    destructor Destroy; override;

    procedure Inicializar;
    procedure DesInicializar;

    procedure ExecutarTransacaoCTF(Operacao: Integer; Valor: Double = 0;
      const NumDocto: String = ''; DataFiscal: TDateTime = 0; NumTransacao: Integer = 0;
      const Dados: String = '');
    procedure FinalizarTransacaoCTF(Confirmar: Boolean; NumTransacao: Integer = 0;
      DataFiscal: TDateTime = 0; const Dados: String = '');
    procedure AbortarTransacao;
    function AutenticacaoTerminal: Boolean;

    property Carregada: Boolean read fCarregada;
    property Inicializada: Boolean read fInicializada write SetInicializada;
    property EmTransacao: Boolean read fEmTransacao;

    property QuandoGravarLog: TACBrGravarLog read fQuandoGravarLog write fQuandoGravarLog;
    property QuandoExibirMensagem: TACBrTEFAuttarQuandoExibirMensagem read fQuandoExibirMensagem
      write fQuandoExibirMensagem;
    property QuandoPerguntarMenu: TACBrTEFAuttarQuandoPerguntarMenu read fQuandoPerguntarMenu
      write fQuandoPerguntarMenu;
    property QuandoPerguntarCampo: TACBrTEFAuttarQuandoPerguntarCampo read fQuandoPerguntarCampo
      write fQuandoPerguntarCampo;
    property QuandoTransacaoEmAndamento: TACBrTEFAuttarTransacaoEmAndamento read fQuandoTransacaoEmAndamento
      write fQuandoTransacaoEmAndamento;

    property PathCTFClient: String read fPathCTFClient write SetPathCTFClient;
    property EnderecoTCP: String read fEnderecoTCP write SetEnderecoTCP;
    property PortaTCP: Integer read fPortaTCP write fPortaTCP default CCTF_TCP_PORT;

    property CodEstabelecimento: String read fCodEstabelecimento write SetCodEstabelecimento;
    property CodLoja: String read fCodLoja write SetCodLoja;
    property CodPDV: String read fCodPDV write SetCodPDV;

    property NomeAplicacao: String read fNomeAplicacao write fNomeAplicacao;
    property VersaoAplicacao: String read fVersaoAplicacao write fVersaoAplicacao;
    property Criptografia: Boolean read fCriptografia write fCriptografia default False;
    property Homologacao: Boolean read fHomologacao write fHomologacao default False;
    property EfetuarLog: Boolean read fEfetuarLog write fEfetuarLog default False;
    property Interativo: Boolean read fInterativo write fInterativo default True;
    property PortaPinPad: String read fPortaPinPad write fPortaPinPad;
    property MensagemPinPad: String read fMensagemPinPad write fMensagemPinPad;

    property LoginAut: String read fLoginAut write fLoginAut;
    property SenhaAut: String read fSenhaAut write fSenhaAut;
    property CNPJAut: String read fCNPJAut write SetCNPJAut;
    property SuporteHttps: Boolean read fSuporteHttps write fSuporteHttps default True;

    property ParametrosInicializacao: String read fParametrosInicializacao write fParametrosInicializacao;

    property SubCampos: TACBrTEFParametros read fSubCampos;
    property TituloMenu: String read fTituloMenu;
    property UltimaMensagem: String read fUltimaMensagem;
  end;

  function GetTEFAuttarAPI: TACBrTEFAuttarAPI;
  function TraduzirErroCTF(CodErro: Integer): String;
  function TraduzirCodigoErro(CodErro: Integer): String;

implementation

uses
  StrUtils, Math, DateUtils,
  blcksock,
  ACBrUtil.Strings,
  ACBrUtil.FilesIO;

var
  vTEFAuttar: TACBrTEFAuttarAPI;

  function GetTEFAuttarAPI: TACBrTEFAuttarAPI;
begin
  if not Assigned(vTEFAuttar) then
    vTEFAuttar := TACBrTEFAuttarAPI.Create;

  Result := vTEFAuttar;
end;

function TraduzirErroCTF(CodErro: Integer): String;
var
  Msg: String;
begin
  case CodErro of
    00: Msg := 'Execução bem-sucedida da função.';
    01: Msg := 'time out da transação';
    02: Msg := 'apitef não inicializada';
    04: Msg := 'Erro nos parâmetros/erro de integração.';
    05: Msg := 'Transação não autorizada.';
    06: Msg := 'Erro no parâmetro p_sc da função continuaTransacaoCTF. '+
                  'Transação cancelada pelo operador/cliente.';
    07: Msg := 'Erro no parâmetro tam_sc da função continuaTransacaoCTF.';
    08: Msg := 'Erro no parâmetro aux da função continuaTransacaoCTF.';
    09: Msg := 'Parâmetro comando da função continuaTransacaoCTF não numérico. Autorizadora offline.';
    10: Msg := 'Erro de comunicação da Apitef.';
    11: Msg := 'Erro no CTF.';
    12: Msg := 'Erro na camada de Intertef da Apitef.';
    13: Msg := 'Transação confirmada, mas ainda existem outras transações a confirmar.';
    14: Msg := 'Parâmetro comando inválido.';
    15: Msg := 'Parâmetro comando inválido - deveria ser "00" na primeira chamada. '+
                  'Erro de formatação comprovante.';
    16: Msg := 'Erro de criptografia da mensagem.';
    17: Msg := 'Erro de formatação da mensagem.';
    18: Msg := 'Não há transação para ser confirmada.';
    19: Msg := 'Erro no parâmetro data_cli da função finalizaTransacaoCTF. '+
                  'Documento inexistente para cancelar.';
    20: Msg := 'Dados de entrada inválidos.';
    21: Msg := 'Parâmetro num_trans inválido - deveria ser numérico. Não há transações para consolidar.';
    22: Msg := 'Parâmetro data_cli inválido - deveria ser numérico. Não há comprovantes para imprimir.';
    23: Msg := 'Parâmetro inválido em iniciaClientCTF.';
    24: Msg := 'Parâmetro criptografia inválido da função iniciaClientCTF.';
    25: Msg := 'Parâmetro log inválido da função iniciaClientCTF. Erro interno do CTFClient.';
    26: Msg := 'Parâmetro interativo inválido da função iniciaClientCTF. Erro retornado pelo pinpad.';
    27: Msg := 'Parâmetro parametros inválido da função iniciaClientCTF. Erro de integração.';
    28: Msg := 'Parâmetro lista_ips inválido da função iniciaClientCTF.';
    29: Msg := 'Erro na camada de JNI.';
    30: Msg := 'Parâmetro operação inválido da função iniciaTransacaoCTF.';
    31: Msg := 'Parâmetro valor inválido da função iniciaTransacaoCTF.';
    32: Msg := 'Parâmetro num_doc inválido da função iniciaTransacaoCTF.';
    33: Msg := 'Parâmetro data_cli inválido da função iniciaTransacaoCTF.';
    34: Msg := 'Parâmetro num_trans inválido da função iniciaTransacaoCTF.';
    35: Msg := 'Parâmetro dados inválido da função iniciaTransacaoCTF.';
    36: Msg := 'Parâmetro operação não numérico da função iniciaTransacaoCTF.';
    37: Msg := 'Parâmetro valor não numérico da função iniciaTransacaoCTF.';
    38: Msg := 'Parâmetro data_cli não numérico da função iniciaTransacaoCTF.';
    39: Msg := 'Parâmetro num_trans não numérico da função iniciaTransacaoCTF.';
    50: Msg := 'Biblioteca não foi inicializada.';
    51: Msg := 'Erro parâmetro inválido na função finalizaTransacaoCTF. '+
                  'Erro de alocação de memória.';
    52: Msg := 'Erro carregando a biblioteca CTFClientC.';
    53: Msg := 'Erro carregando bibliotecas de criptografia.';
    54: Msg := 'Erro ao estabelecer conexão na iniciaClientCTF. Erro ao estabelecer conexão.';
    55: Msg := 'Erro no envio do comando "01". Erro ao enviar dados pela conexão.';
    56: Msg := 'Erro ao receber resposta da finalizaTransacaoCTF. Erro ao ler dados da conexão.';
    57: Msg := 'Erro ao receber o comando "01". Mensagem com formato inválido recebida do CTF Client.';
    58: Msg := 'Erro interno na função continuaTransacaoCTF. Chamada de rotina inválida.';
    59: Msg := 'Variável de ambiente CTFCLIENT_HOME não está configurada.';
    60: Msg := 'Porta de conexão com o CTFClient não definida.';
    61: Msg := 'Erro ao configurar o CTFClient na função iniciaClientCTF';
    62: Msg := 'Erro ao receber o comando "02".';
    63: Msg := 'Erro ao receber o comando "03".';
    64: Msg := 'Erro ao receber o comando "04".';
    65: Msg := 'Erro ao receber o comando "05".';
    66: Msg := 'Erro ao receber o comando "06".';
    67: Msg := 'Erro ao receber o comando "07".';
    68: Msg := 'Erro ao receber o comando "08".';
    69: Msg := 'Erro ao receber um comando inválido.';
    70: Msg := 'Erro ao receber os dados finais da transação em continuaTransacaoCTF.';
    71: Msg := 'Erro ao receber dados inválidos do CTFClient em continuaTransacaoCTF.';
    72: Msg := 'Erro ao receber dados inválidos do CTFClient em finalizaTransacaoCTF.';
    73: Msg := 'Erro ao receber os dados finais do CTFClient em finalizaTransacaoCTF.';
    74: Msg := 'Erro ao enviar o comando "02".';
    75: Msg := 'Erro ao enviar o comando "03".';
    76: Msg := 'Erro ao enviar o comando "04".';
    77: Msg := 'Erro ao enviar o comando "05".';
    78: Msg := 'Erro ao enviar o comando "06".';
    79: Msg := 'Erro ao enviar o comando "07".';
    80: Msg := 'Erro ao enviar o comando "08".';
    81: Msg := 'Erro ao enviar o comando "00".';
    82: Msg := 'Erro ao enviar os dados em finalizaTransacaoCTF.';
    83: Msg := 'Erro ao enviar os dados em iniciaTransacaoCTF.';
    84: Msg := 'Biblioteca não inicializada ao executar a finalizaTransacaoCTF.';
    85: Msg := 'Biblioteca não inicializada ao executar a iniciaTransacaoCTF.';
    86: Msg := 'Erro de alocação de memória em iniciaClientCTF.';
    87: Msg := 'Erro ao formatar dados de entrada na iniciaTransacaoCTF.';
    88: Msg := 'Erro ao estabelecer conexão na iniciaTransacaoCTF.';
    89: Msg := 'Erro interno na continuaTransacaoCTF.';
    90: Msg := 'Estado da biblioteca incorreto.';
    91: Msg := 'Estado da biblioteca inconsistente.';
    92: Msg := 'Não existe uma conexão estabelecida.';
    93: Msg := 'Erro interno na função continuaTransacaoCTF.';
    95: Msg := 'Não foi possível iniciar a biblioteca CTFClientC.';
    98: Msg := 'Erro interno desconhecido.';
    99: Msg := 'O comando devolvido pela função continuaTransacaoCTF deve ser executado pela AC, '+
                  'e o resultado deve ser enviado em nova chamada da função continuaTransacaoCTF';
  else
    Msg := Format('Retornado pela %s', [CTFClientFolderName]);
  end;

  Result := Format('Erro CTF: %d - ',[CodErro]) + ACBrStr(Msg);
end;

function TraduzirCodigoErro(CodErro: Integer): String;
var
  Msg: String;
begin
  case CodErro of
    // Erros de integração com CTFClient (5000-5446)
    5002: Msg := 'Erro de leitura da primeira linha dos dados de entrada da operação';
    5004: Msg := 'Tamanho inválido da primeira linha dos dados de entrada';
    5005: Msg := 'Erro de leitura da segunda linha dos dados de entrada da operação';
    5007: Msg := 'Tamanho inválido da segunda linha dos dados de entrada da operação';
    5008: Msg := 'Erro de leitura da terceira linha dos dados de entrada da operação';
    5010: Msg := 'Tamanho inválido da terceira linha dos dados de entrada da operação';
    5107: Msg := 'Diretórios indicados no arquivo de configuração config.ini não encontrados';
    5108: Msg := 'Executável do client Windows não encontrado';
    5109: Msg := 'Erro na conversão de formatos entre as versões antiga e nova dos dados de entrada e de saída da operação';
    5110: Msg := 'Erro para obter o código da operação nos dados de entrada da operação';
    5120: Msg := 'Erro para obter o delay de resposta da rede';
    5121: Msg := 'Erro para obter o time out padrão de resposta da transação';
    5122: Msg := 'Erro para obter o número de vias de comprovantes';
    5123: Msg := 'Erro para obter o tipo do pinpad';
    5126: Msg := 'Erro para obter a lista de endereços Ips';
    5127: Msg := 'Erro para obter o nome do teclado';
    5128: Msg := 'Erro para obter o flag de transações digitadas';
    5129: Msg := 'Erro para obter os valores das teclas especiais';
    5130: Msg := 'Erro para obter o nome do display';
    5131: Msg := 'Leitura de cartão desabilitada';
    5132: Msg := 'Erro no parâmetro flag stand alone';
    5133: Msg := 'Erro no parâmetro flag criptografia dos dados de entrada da operação';
    5200: Msg := 'Erro de timeout. Erro de conexão socket com a AC';
    5220: Msg := 'Erro não tratado pela camada de integração com o CTFClient';

    // Erros de validação de dados (5300-5399)
    5300: Msg := 'Valor não informado';
    5301: Msg := 'Cartão inválido';
    5302: Msg := 'Cartão vencido';
    5303: Msg := 'Data de vencimento inválida';
    5304: Msg := 'Código de segurança inválido';
    5305: Msg := 'Taxa de serviço excede limite';
    5306: Msg := 'Operação não permitida';
    5307: Msg := 'Dados inválidos';
    5308: Msg := 'Valor mínimo da parcela';
    5309: Msg := 'Número de parcelas inválido';
    5310: Msg := 'Número de parcelas excede limite';
    5311: Msg := 'Valor da entrada maior ou igual ao valor da transação';
    5312: Msg := 'Valor da parcela inválido';
    5313: Msg := 'Data inválida';
    5314: Msg := 'Prazo excede limite';
    5315: Msg := 'Transação inválida para o tipo de garantia';
    5316: Msg := 'NSU inválido';
    5317: Msg := 'Operação cancelada pelo usuário';
    5318: Msg := 'Documento inválido (CPF ou CNPJ)';
    5319: Msg := 'Valor do documento inválido';
    5320: Msg := 'Número do plano inválido';
    5321: Msg := 'Número do ciclo inválido';
    5322: Msg := 'Número do item inválido';
    5323: Msg := 'Número da transação inválido';
    5324: Msg := 'Data AC não informada';
    5325: Msg := 'Versão AC não informada';
    5326: Msg := 'Versão AC difere da versão configurada';
    5327: Msg := 'Pinpad desconectado';
    5328: Msg := 'Erro na captura de dados do Pinpad';
    5329: Msg := 'Erro na captura de dados do CHIP';
    5330: Msg := 'Fluxo não encontrado';
    5331: Msg := 'Erro de processamento do CTFClient';
    5332: Msg := 'Captura do valor da entrada não habilitada';
    5333: Msg := 'Captura do valor da parcela não habilitada';
    5334: Msg := 'Data menor que o mínimo';
    5335: Msg := 'Captura da data da 1ª parcela não habilitada';
    5336: Msg := 'Captura do valor do saque não habilitada';
    5337: Msg := 'Campo enviado nos dados de entrada não é aceito para o tipo de integração utilizado';
    5338: Msg := 'Erro na leitura do código da operação da terceira linha';
    5339: Msg := 'Erro na leitura do número do documento da terceira linha';
    5340: Msg := 'Erro na leitura do valor da transação';
    5341: Msg := 'Erro na leitura do número do cartão';
    5342: Msg := 'Erro na leitura do campo info';
    5343: Msg := 'Erro na leitura timestamp';
    5344: Msg := 'Erro na leitura da senha';
    5345: Msg := 'Erro na leitura do número do parcelas';
    5346: Msg := 'Erro na leitura do vencimento do cartão';
    5347: Msg := 'Erro na leitura da data de referência';
    5348: Msg := 'Erro na leitura do valor de entrada';
    5349: Msg := 'Erro na leitura NSU CTF';
    5350: Msg := 'Erro na leitura do valor de parcela';
    5351: Msg := 'Erro na leitura do bit 62';
    5352: Msg := 'Erro na leitura do código de segurança';
    5353: Msg := 'Erro na leitura do valor de saque';
    5354: Msg := 'Erro na leitura da garantia do pré-datado';
    5355: Msg := 'Erro na leitura do nome da AC';
    5356: Msg := 'Erro na leitura do valor do desconto';
    5357: Msg := 'Erro na leitura do valor do acréscimo';
    5358: Msg := 'Pinpad sem api compartilhada';
    5359: Msg := 'Erro na leitura da forma de pagamento do pagamento de contas';
    5360: Msg := 'Erro na leitura da forma de entrada do código de barras do pagamento de contas';
    5361: Msg := 'Erro na leitura no tipo do documento';
    5362: Msg := 'Captura do número de ciclos não habilitada';
    5363: Msg := 'Captura do código de pré-autorização não habilitada';
    5364: Msg := 'Data de emissão do cartão inválida';
    5365: Msg := 'Identificador de consulta informado não condiz com aquele gerado em operação anterior';
    5366: Msg := 'O tipo de financiamento informado não é coerente com o número de parcelas';
    5367: Msg := 'NSU Inválido';
    5368: Msg := 'Não existe terminal disponível';
    5369: Msg := 'Código identificador da multitransação inválido';
    5370: Msg := 'Operadora de telefonia inválida';
    5371: Msg := 'DDD ou Telefone inválido';
    5372: Msg := 'A transação não está no log';
    5373: Msg := 'Valor de cancelamento inválido';
    5374: Msg := 'Valor de cancelamento inválido';
    5375: Msg := 'Valor de cancelamento inválido';
    5376: Msg := 'Valor de cancelamento inválido';
    5377: Msg := 'Pagamento com saldo do voucher não autorizado';
    5378: Msg := 'Número da transação inválido - A sequência do número da transação é inválida';
    5379: Msg := 'Nenhuma modalidade de pagamento habilitada';
    5380: Msg := 'Dado capturado no pinpad não foi confirmado pelo usuário';
    5381: Msg := 'Erro na execução de função no Pinpad';
    5382: Msg := 'Realize a configuração do CTFClient';
    5383: Msg := 'Data de emissão do cartão inválida';
    5384: Msg := 'Tipo da consulta SPC inválido';
    5385: Msg := 'Data de nascimento do Cliente inválida';
    5386: Msg := 'Comunicação segura não pôde ser habilitada';
    5387: Msg := 'Não existem valores de recarga a serem exibidos';
    5388: Msg := 'Valor de cancelamento inválido';
    5389: Msg := 'Código do terminal original inválido';
    5390: Msg := 'Lista de produtos promocionais ausente';
    5391: Msg := 'Código do produto não cadastrado no controlador de bombas (Fusion)';
    5392: Msg := 'Lista de produtos de convênio combustível vazia';
    5393: Msg := 'Problema de comunicação com o Fusion';
    5394: Msg := 'Cartão de Chip requerido';
    5395: Msg := 'Nenhum produto para resgate com DOTZ';
    5396: Msg := 'Valor de identificação do pagamento da fatura inválido';
    5397: Msg := 'Valor da forma de identificação do pagamento de fatura inválido';
    5398: Msg := 'Data de vencimento inválida';
    5399: Msg := 'Código de barras inválido';
    5400: Msg := 'Nenhum terminal foi retornado na Consulta de Estabelecimentos Multi-EC';
    5401: Msg := 'Identificador do terminal Multi-EC não enviado';
    5402: Msg := 'Identificador do terminal Multi-EC não encontrado';
    5403: Msg := 'Identificação Solução Certa não enviado';
    5404: Msg := 'Pagamento parcial do valor da transação não autorizado';
    5405: Msg := 'Operadora de cartão pré-pago digital inexistente';
    5410: Msg := 'Erro ao obter número da transação corrente';
    5411: Msg := 'Erro no processo de autenticação';
    5413: Msg := 'Erro na leitura dos dados do subcomercio';
    5417: Msg := 'Dados inválidos da integração. A biblioteca ctfclient.dll utilizada junto ao programa da Automação Comercial (AC) está desatualizada e é anterior a 1.37.0-0';
    5418: Msg := 'Dados inválidos da integração. A biblioteca ctfclient.dll utilizada junto ao programa da Automação Comercial (AC) está desatualizada';
    5419: Msg := 'A versão do IntegradorTEF-IP.exe está desatualizada e é inferior a 1.28.0.0';
    5420: Msg := 'A versão do IntegradorTEF-IP.exe está desatualizada';
    5423: Msg := 'Nome do parâmetro de periférico';
    5424: Msg := 'Porta ou host do CTFClient informados inválidos';
    5425: Msg := 'Dados dos IPs do CTF inválidos';
    5426: Msg := 'Dados da identificação do terminal inválidos';
    5427: Msg := 'Tipo inválido para o periférico de nome "display-operador"';
    5428: Msg := 'Parâmetros inválidos para o periférico de nome "display-operador"';
    5429: Msg := 'Tipo inválido para o periférico de nome "display-cliente"';
    5430: Msg := 'Parâmetro "params" inválidos para o periférico de nome "display-cliente"';
    5431: Msg := 'Parâmetro "params" inválido para o periférico de nome "leitor-cartão"';
    5432: Msg := 'Parâmetro "params" inválido para o periférico de nome "leitor-documento"';
    5433: Msg := 'Parâmetro "tipo" inválido para o periférico de nome "leitor-documento"';
    5434: Msg := 'Parâmetro "params" inválidos para o periférico de nome "pinpad"';
    5435: Msg := 'Parâmetro "params" inválido para o periférico de nome "scanner"';
    5436: Msg := 'Parâmetro "tipo" inválido para o periférico de nome "scanner"';
    5437: Msg := 'Parâmetro "params" inválido para o periférico de nome "teclado"';
    5438: Msg := 'Parâmetro "tipo" inválido para o periférico de nome "teclado"';
    5439: Msg := 'Erro interno';
    5441: Msg := 'Propriedade inteira inválida';
    5442: Msg := 'Propriedade boleano inválida';
    5443: Msg := 'Propriedade texto inválida';
    5444: Msg := 'Erro na obtenção dos dados de autenticação';
    5445: Msg := 'Erro na leitura e escrita dos dados de autenticação';
    5446: Msg := 'Dados da simulação do crediário não são validos';

    // Erros Intertef da APITEF (2000-2043)
    2001: Msg := 'Erro de abertura do arquivo de cupom';
    2011: Msg := 'Erro de abertura do arquivo C_M_O_S.TEF';
    2012: Msg := 'Erro de leitura do arquivo C_M_O_S.TEF';
    2021: Msg := 'Erro de abertura do arquivo TRANSAC.TEF';
    2022: Msg := 'Erro de busca do arquivo TRANSAC.TEF';
    2023: Msg := 'Erro de leitura do arquivo TRANSAC.TEF';
    2031: Msg := 'Erro de abertura do arquivo C_M_O_S.TEF';
    2032: Msg := 'Erro de gravação do arquivo C_M_O_S.TEF';
    2040: Msg := 'Tamanho do buffer recebido do CTF maior que o esperado';
    2041: Msg := 'Erro de abertura do arquivo TRANSAC.TEF';
    2042: Msg := 'Erro de busca do arquivo TRANSAC.TEF';
    2043: Msg := 'Erro de gravação do arquivo TRANSAC.TEF';

    // Erros de Comunicação da Apitef (1000-0257)
    1002: Msg := 'Erro de acesso ao arquivo INTERNET.TEF';
    1003: Msg := 'Erro de acesso ao arquivo INTERNET.TEF';
    1004: Msg := 'Erro na inicialização da Camada de comunicação';
    1005: Msg := 'Camada de rede não inicializada';
    1006: Msg := 'Camada de rede não inicializada';
    1007: Msg := 'Camada de rede não inicializada';
    0200: Msg := 'Parâmetros inválidos';
    0201: Msg := 'Não conseguiu abrir o canal de comunicação';
    0202: Msg := 'Não conseguiu resolver o endereço do CTF';
    0203: Msg := 'Erro no envio da mensagem';
    0204: Msg := 'Mensagem enviada de tamanho diferente do esperado';
    0205: Msg := 'Endereço IP já está em uso';
    0206: Msg := 'Erro ao receber a mensagem';
    0001: Msg := 'Timeout';
    0208: Msg := 'Erro receber a mensagem';
    0209: Msg := 'Erro receber a mensagem';
    0241: Msg := 'HTTP 401 não autorizado';
    0242: Msg := 'HTTP 402 Payment Required';
    0243: Msg := 'HTTP 403 Proibido';
    0244: Msg := 'HTTP 404 Não encontrado';
    0251: Msg := 'Falha ao estabelecer comunicação SSL';
    0252: Msg := 'Falha validação da lista de cifras SSL';
    0253: Msg := 'Falha na verificação do certificado SSL/TLS';
    0254: Msg := 'Chave pública do certificado SSL/TLS não corresponde à esperada';
    0257: Msg := 'Problema com o certificado SSL/TLS';
  else
    Msg := '';
  end;

  Result := Format(ACBrStr('Erro Transação: %d - '),[CodErro]) + ACBrStr(Msg);
end;


{ TACBrTEFAuttarAPI }

constructor TACBrTEFAuttarAPI.Create;
begin
  inherited Create;
  fSubCampos := TACBrTEFParametros.Create;

  fPathCTFClient := '';
  fInicializada := False;
  fEmTransacao := False;
  fCarregada := False;

  fCriptografia := False;
  fHomologacao := False;
  fEfetuarLog := False;
  fEnderecoTCP := CCTF_TCP_IP;
  fPortaTCP := CCTF_TCP_PORT;
  fInterativo := True;
  fNomeAplicacao := '';
  fCodEstabelecimento := '';
  fCodLoja := '';
  fCodPDV := '';
  fVersaoAplicacao := '';
  fPortaPinPad := '';
  fMensagemPinPad := '';
  fParametrosInicializacao := '';

  fLoginAut := '';
  fSenhaAut := '';
  fCNPJAut := '';
  fSuporteHttps := True;

  fTituloMenu := '';
  fUltimaMensagem := '';

  fQuandoGravarLog := Nil;
  fQuandoExibirMensagem := Nil;
  fQuandoPerguntarMenu := Nil;
  fQuandoPerguntarCampo := Nil;
  fQuandoTransacaoEmAndamento := Nil;

  ClearMethodPointers;
end;

destructor TACBrTEFAuttarAPI.Destroy;
begin
  fSubCampos.Free;
  fQuandoGravarLog := Nil;
  ClearMethodPointers;
  inherited Destroy;
end;

procedure TACBrTEFAuttarAPI.SetInicializada(AValue: Boolean);
begin
  if (fInicializada = AValue) then
    Exit;

  GravarLog('TACBrTEFAuttarAPI.SetInicializada( '+BoolToStr(AValue, True)+' )');

  if AValue then
    Inicializar
  else
    DesInicializar;
end;

procedure TACBrTEFAuttarAPI.SetEnderecoTCP(AValue: String);
var
  s: String;
begin
  if fEnderecoTCP = AValue then Exit;
  s := trim(AValue);
  if (LowerCase(s) = 'localhost') then
    s := '127.0.0.1';

  fEnderecoTCP := s;
end;

procedure TACBrTEFAuttarAPI.SetCodEstabelecimento(AValue: String);
var
  s: String;
begin
  if fCodEstabelecimento = AValue then Exit;
  s := LeftStr(Trim(AValue), 5);
  if StrIsNumber(s) then
    fCodEstabelecimento := Format('%.5d', [StrToInt(s)])
  else
    fCodEstabelecimento := PadLeft(s, 5);
end;

procedure TACBrTEFAuttarAPI.SetCNPJAut(AValue: String);
begin
  if fCNPJAut = AValue then Exit;
  fCNPJAut := OnlyAlphaNum(AValue);
end;

procedure TACBrTEFAuttarAPI.SetCodLoja(AValue: String);
var
  s: String;
begin
  if fCodLoja = AValue then Exit;
  s := LeftStr(Trim(AValue), 4);
  if StrIsNumber(s) then
    fCodLoja := Format('%.4d', [StrToInt(s)])
  else
    fCodLoja := PadLeft(s, 4);
end;

procedure TACBrTEFAuttarAPI.SetCodPDV(AValue: String);
var
  s: String;
begin
  if fCodPDV = AValue then Exit;
  s := LeftStr(Trim(AValue), 3);
  if StrIsNumber(s) then
    fCodPDV := Format('%.3d', [StrToInt(s)])
  else
    fCodPDV := PadLeft(s, 3);
end;

procedure TACBrTEFAuttarAPI.SetPathCTFClient(const AValue: String);
var
  s, p: String;
begin
  if (fPathCTFClient = AValue) then
    Exit;

  s := PathWithDelim(Trim(AValue));
  GravarLog('TACBrTEFAuttarAPI.SetPathCTFClient( '+s+' )');
  if fInicializada then
    DoException(Format(ACBrStr(sACBrTEFAPILibJaInicializada), [CCTFClientLib]));

  if (s = '') then
  begin
    fPathCTFClient := '';
    Exit;
  end;

  p := PathWithDelim(ExtractFilePath(s));
  if FileExists(p + CCTFClientLib) then  // Informou o diretório 'bin'... voltando um Path
    p := copy(p, 1, Length(p)-Length(CCTFClientDirBin)-1);

  if not DirectoryExists(p + CCTFClientDirBin) then
    DoException(Format(ACBrStr(sErrDirCTFClientInvalido), [CCTFClientDirBin, p]));

  fPathCTFClient := p;
end;

function TACBrTEFAuttarAPI.CheckPathCTFCLient: String;
var
  lPath: String;
begin
  lPath := PathCTFClient;
  if (lPath = '') then
  begin
    lPath := SysUtils.GetEnvironmentVariable(CENV_CTFCLIENT_HOME);
    if (lPath <> '') then
    begin
      lPath := PathWithDelim(lPath);
      if not DirectoryExists(lPath) then
        lPath := ''
    end;
  end;

  if (lPath = '') then
  begin
    lPath := ApplicationPath + CTFClientFolderName + PathDelim;
    if not DirectoryExists(lPath) then
      lPath := CDefaultPathCTFClient;
  end;

  if not DirectoryExists(lPath) then
    DoException(Format(ACBrStr(sErrDirCTFClientNaoEncontrado), [lPath]));

  fPathCTFClient := lPath;
  Result := lPath;
end;

procedure TACBrTEFAuttarAPI.CheckEnvirontmentVars;
var
  lPath, lEnv: String;
begin
  lPath := PathWithoutDelim(PathCTFClient);
  // Check for CTFCLIENT_HOME
  if (lPath <> '') then
  begin
    lEnv := Trim(SysUtils.GetEnvironmentVariable(CENV_CTFCLIENT_HOME));
    if (lEnv <> lPath)  then
      ACBrUtil.FilesIO.SetGlobalEnvironment(CENV_CTFCLIENT_HOME, lPath);
  end;

  // Check for JAVA_HOME
  lEnv := Trim(SysUtils.GetEnvironmentVariable(CENV_JAVA_HOME));
  if (lEnv = '')  then
  begin
    lPath := lPath + PathDelim + CCTFClientDirJre;
    ACBrUtil.FilesIO.SetGlobalEnvironment(CENV_JAVA_HOME, lPath);
  end;
end;

procedure TACBrTEFAuttarAPI.ConfigureConfigCTFClientXml;
var
  s: String;
begin
  SetCTFClientConfigFileValue('configCTFClient', 'estabelecimento', CodEstabelecimento);
  SetCTFClientConfigFileValue('configCTFClient', 'loja', CodLoja);
  SetCTFClientConfigFileValue('configCTFClient', 'terminal', CodPDV);
  SetCTFClientConfigFileValue('configCTFClient', 'cnpj', CNPJAut);

  SetCTFClientConfigFileValue('configCTFClient', 'hostclient', EnderecoTCP);
  SetCTFClientConfigFileValue('configCTFClient', 'portclient', IntToStr(PortaTCP));

  SetCTFClientConfigFileValue('configCTFClient', 'versaoAC', VersaoAplicacao);
  SetCTFClientConfigFileValue('configCTFClient', 'nomeAC', NomeAplicacao);

  SetCTFClientConfigFileValue('configCTFClient', 'tipointegracao', 'dll');
  SetCTFClientConfigFileValue('configCTFClient', 'integracaoCriptografada', IfThen(Criptografia, 'true', 'false'));
  SetCTFClientConfigFileValue('configCTFClient', 'homologacao', IfThen(Homologacao, 'true', 'false'));
  SetCTFClientConfigFileValue('configCTFClient', 'suporteHttps', IfThen(SuporteHttps, 'true', 'false'));

  s := Trim(PortaPinPad);
  if StrIsNumber(s) then
    s := 'COM'+s;
  SetCTFClientConfigFileValue('CONFIG_PINPAD', 'portaSerial', s);
  SetCTFClientConfigFileValue('CONFIG_PINPAD', 'msgPrompt', MensagemPinPad);
end;

function TACBrTEFAuttarAPI.CalcCTFClientPath(const ASubFolder: String;
  VerificarSeExiste: Boolean): String;
var
  p: String;
begin
  p := CheckPathCTFCLient;
  if VerificarSeExiste and (not DirectoryExists(p + ASubFolder)) then
    DoException(Format(ACBrStr(sErrDirCTFClientInvalido), [ASubFolder, p]));

  Result := p + ASubFolder + PathDelim;
end;


procedure TACBrTEFAuttarAPI.LoadLibFunctions;

  procedure AuttarFunctionDetect(LibName, FuncName: AnsiString; var LibPointer: Pointer) ;
  begin
    if not Assigned(LibPointer)  then
    begin
      GravarLog('   '+FuncName);
      if not FunctionDetect(LibName, FuncName, LibPointer) then
      begin
        LibPointer := NIL ;
        DoException(Format(ACBrStr(sACBrTEFAPIErroAoCarregarMetodoDeLib), [FuncName, LibName]))
      end ;
    end ;
  end;

var
  sLibName, p: string;
begin
  if fCarregada then
    Exit;

  p := CalcCTFClientPath(CCTFClientDirBin);
  if not FileExists(p + CCTFClientLib) then
    DoException(Format(ACBrStr(sErrArqCTFClientNaoEncontrado), [CCTFClientLib, p]));
  sLibName := p + CCTFClientLib;
  GravarLog('TACBrTEFAuttarAPI.LoadLibFunctions - '+sLibName);

  AuttarFunctionDetect(sLibName, 'iniciaClientCTF', @xIniciaClientCTF);
  AuttarFunctionDetect(sLibName, 'iniciaTransacaoCTF', @xIniciaTransacaoCTF);
  AuttarFunctionDetect(sLibName, 'iniciaTransacaoCTFext', @xIniciaTransacaoCTFext);
  AuttarFunctionDetect(sLibName, 'continuaTransacaoCTF', @xContinuaTransacaoCTF);
  AuttarFunctionDetect(sLibName, 'finalizaTransacaoCTF', @xFinalizaTransacaoCTF);
  AuttarFunctionDetect(sLibName, 'finalizaTransacaoCTFext', @xFinalizaTransacaoCTFext);

  fCarregada := True;
end;

procedure TACBrTEFAuttarAPI.UnLoadLibFunctions;
var
  sLibName: String;
begin
  if not fCarregada then
    Exit;

  sLibName := CalcCTFClientPath(CCTFClientDirBin) + CCTFClientLib;
  GravarLog('TACBrTEFAuttarAPI.UnLoadLibFunctions( '+sLibName+' )');
  UnLoadLibrary( sLibName );
  fCarregada := False;
  ClearMethodPointers;
end;

procedure TACBrTEFAuttarAPI.ClearMethodPointers;
begin
  xIniciaClientCTF := Nil;
  xIniciaTransacaoCTF := Nil;
  xIniciaTransacaoCTFext := Nil;
  xContinuaTransacaoCTF := Nil;
  xFinalizaTransacaoCTF := Nil;
  xFinalizaTransacaoCTFext := Nil;
end;

procedure TACBrTEFAuttarAPI.Inicializar;
var
  ret, Tries: Integer;
begin
  if fInicializada then
    Exit;

  GravarLog('TACBrTEFAuttarAPI.Inicializar');

  if not Assigned(fQuandoExibirMensagem) then
    DoException(Format(ACBrStr(sACBrTEFAPIEventoInvalidoException), ['TACBrTEFAuttarAPI.QuandoExibirMensagem']));
  if not Assigned(fQuandoPerguntarMenu) then
    DoException(Format(ACBrStr(sACBrTEFAPIEventoInvalidoException), ['TACBrTEFAuttarAPI.QuandoPerguntarMenu']));
  if not Assigned(fQuandoPerguntarCampo) then
    DoException(Format(ACBrStr(sACBrTEFAPIEventoInvalidoException), ['TACBrTEFAuttarAPI.QuandoPerguntarCampo']));
  if not Assigned(fQuandoTransacaoEmAndamento) then
    DoException(Format(ACBrStr(sACBrTEFAPIEventoInvalidoException), ['TACBrTEFAuttarAPI.QuandoTransacaoEmAndamento']));

  if (Trim(CodEstabelecimento) = '') then
    DoException(Format(ACBrStr(sACBrTEFAPIParamNaoInformado), ['CodEstabelecimento']));
  if (Trim(CodLoja) = '') then
    DoException(Format(ACBrStr(sACBrTEFAPIParamNaoInformado), ['CodLoja']));
  if (Trim(CodPDV) = '') then
    DoException(Format(ACBrStr(sACBrTEFAPIParamNaoInformado), ['CodPDV']));

  CheckPathCTFCLient;

  // Verificando se o Serviço do CTFClient está em execução, e se necessário iniciando-o
  Tries := 0;
  while (not CTFClientIsRunning) and (Tries < 3) do
  begin
    if (Tries = 0) then
    begin
      CheckEnvirontmentVars;
      ConfigureConfigCTFClientXml;
    end;

    RunCTFClientDesktop;
    Sleep(500);
    Inc(Tries);
  end;
  if (Tries >= 3) then
    DoException(ACBrStr(sErrCTFClientNaoIniciado));

  LoadLibFunctions;
  try
    ret := IniciarClientCTF;
    TratarErroCTF(ret);
  except
    UnLoadLibFunctions;
    raise;
  end;

  fInicializada := True;

  if SuporteHttps then
    AutenticacaoTerminal;
end;

procedure TACBrTEFAuttarAPI.DesInicializar;
begin
  if not fInicializada then
    Exit;

  GravarLog('TACBrTEFAuttarAPI.DesInicializar');
  UnLoadLibFunctions;
  fInicializada := False;
end;

procedure TACBrTEFAuttarAPI.ExecutarTransacaoCTF(Operacao: Integer;
  Valor: Double; const NumDocto: String; DataFiscal: TDateTime;
  NumTransacao: Integer; const Dados: String);
var
  ret: Integer;
  s: String;
begin
  Inicializar;
  if (Dados = '') then
    s := StringReplace(SubCampos.Text, sLineBreak, ';', [rfReplaceAll])
  else
    s := Trim(Dados);

  if (copy(s, Length(s), 1) = ';') then
    Delete(s, Length(s), 1);
  if (copy(s, 1, 1) <> '[') then
    s := '['+s;
  if (copy(s, Length(s), 1) <> ']') then
    s := s+']';

  fEmTransacao := True;
  try
    ret := IniciaTransacaoCTF(Operacao, Valor, NumDocto, DataFiscal, NumTransacao, s);
    TratarErroCTF(ret);

    if fEmTransacao then
      ContinuarRequisicaoCTF;
  finally
    // Limmpando os Displays
    LimparDisplay();
    fEmTransacao := False;
  end;
end;

procedure TACBrTEFAuttarAPI.FinalizarTransacaoCTF(Confirmar: Boolean;
  NumTransacao: Integer; DataFiscal: TDateTime; const Dados: String);
var
  ret: Integer;
begin
  Inicializar;
  ret := FinalizaTransacaoCTF(Confirmar, NumTransacao, DataFiscal, Dados);
  fEmTransacao := False;
  TratarErroCTF(ret);
end;

procedure TACBrTEFAuttarAPI.ContinuarRequisicaoCTF;
var
  ret, resp, Comando, NumSubcampo, NovoNumSubcampo, Aux, NovoAux: Integer;
  Buffer, NovoBuffer, msg: String;
  Cancelar: Boolean;
begin
  fTituloMenu := '';
  fUltimaMensagem := '';
  fSubCampos.Clear;
  fEmTransacao := True;

  Comando := CMD_CONTINUAR;
  Buffer := '';
  NumSubcampo := 0;
  Aux := 0;

  ret := RET_CONTINUA;
  while (ret = RET_CONTINUA) do
  begin
    NovoBuffer := '';
    NovoNumSubcampo := 0;
    NovoAux := 0;
    Cancelar := False;

    ret := ContinuaTransacaoCTF(Comando, NumSubcampo, Buffer, Aux);
    TratarErroCTF(ret);

    case Comando of
      CMD_RECUPERAR_SUBCAMPO:
        fSubCampos.ValueInfo[NumSubcampo] := Buffer;

      CMD_EXIBIR_MENSAGEM:
        begin
          if (copy(Buffer, Length(Buffer), 1)  = ';') then
            Delete(Buffer, Length(Buffer), 1);
          msg := StringReplace(Buffer, ';', sLineBreak, [rfReplaceAll]);
          DoExibirMensagem(msg, Aux, -1, Cancelar);
        end;

      CMD_EXIBIR_TITULO:
        begin
          fTituloMenu := StringReplace(Buffer, ';', sLineBreak, [rfReplaceAll]);
          DoExibirMensagem(fTituloMenu, Aux, -1, Cancelar);
        end;

      CMD_LIMPAR_DISPLAY:
        LimparDisplay(Aux);

      CMD_CONFIRMACAO_SIM_NAO:
        begin
          resp := DoPerguntarMenu('1:SIM;2:NAO');
          if (resp < 0) then
            Cancelar := True
          else
            NovoBuffer := IntToStr(resp);
        end;

      CMD_EXIBIR_MENU:
        begin
          resp := DoPerguntarMenu(Buffer);
          if (resp < 0) then
            Cancelar := True
          else
            NovoBuffer := IntToStr(resp);
        end;

      CMD_AGUARDAR_TECLA:
        DoExibirMensagem(fUltimaMensagem, 1, 0, Cancelar);

      CMD_PERGUNTAR_CAMPO:
        begin
          NovoNumSubcampo := NumSubcampo;
          NovoBuffer := DoPerguntarCampo(NumSubcampo, StrToIntDef(Buffer, 0), (Aux = 1), Cancelar);
        end;

      CMD_CANCELAR:
        begin
          fQuandoTransacaoEmAndamento(Cancelar);
          if not Cancelar then
            Comando := CMD_CONTINUAR;
        end;

      CMD_EXIBIR_MENU_TIMEOUT:
        begin
          if (Buffer = '1') then   // Timeout
            Cancelar := True
          else if (Buffer = '0') then
            fQuandoTransacaoEmAndamento(Cancelar)
          else
          begin
            resp := DoPerguntarMenu(Buffer);
            if (resp < 0) then
              Cancelar := True
            else
            begin
              NovoBuffer := IntToStr(resp);
              NovoAux := 1;
            end;
          end;
        end;
    end;

    if Cancelar or (not fEmTransacao) then
      Comando := CMD_CANCELAR
    else
    begin
      NumSubcampo := NovoNumSubcampo;
      Buffer := NovoBuffer;
      Aux := NovoAux;
    end;
  end;
end;

procedure TACBrTEFAuttarAPI.AbortarTransacao;
begin
  fEmTransacao := False;
end;

function TACBrTEFAuttarAPI.AutenticacaoTerminal: Boolean;
begin
  Result := False;
  if (LoginAut <> '') and (SenhaAut <> '') and (CNPJAut <> '') then
  begin
    SubCampos.Clear;
    SubCampos.ValueInfo[SC_E_LOGIN_TERMINAL] := LoginAut;
    SubCampos.ValueInfo[SC_E_SENHA_TERMINAL] := SenhaAut;
    SubCampos.ValueInfo[SC_E_CNPJ_TERMINAL] := PadLeft(Trim(CNPJAut), 14, '0');

    ExecutarTransacaoCTF(OP_AUTENTICACAO_TERMINAL);
    Result := (StrToIntDef(SubCampos.ValueInfo[SC_S_CODIGO_RETORNO], -1) = 0);
  end;
end;

procedure TACBrTEFAuttarAPI.TratarErroCTF(CodErro: LongInt);
var
  MsgErro: String;
begin
  case CodErro of
    RET_OK, RET_CONTINUA: MsgErro := '';
  else
    MsgErro := TraduzirErroCTF(CodErro);
  end;

  if (MsgErro <> '') then
    DoException(MsgErro);
end;


function TACBrTEFAuttarAPI.IniciarClientCTF: Integer;
var
  lRes, lTerminal, lVersao, lNome, lNumSites, lListaIPs, lCripto, lLog, lInterativo, lParam: AnsiString;
  s: String;
  i, l: Integer;
  slParam, slMsgPinPad: TStringList;

  function ParamTemChave(AParam: TStringList; const Chave: String): Boolean;
  begin
    Result := (AParam.Values[Chave] <> '');
  end;

  function LLVAR(AStr: String): String;
  begin
    Result := Format('%.2d', [Length(AStr)]) + AStr;
  end;

  function LLLVAR(AStr: String): String;
  begin
    Result := Format('%.3d', [Length(AStr)]) + AStr;
  end;

begin
  if not Carregada then
    DoException(Format(ACBrStr(sACBrTEFAPILibNaoInicializada), [CCTFClientLib]));

  Result := -1;
  lRes := StringOfChar('0',2);
  // Código que identifica o terminal CTFClient no formato <EEEEE><LLLL><PPP>
  lTerminal := PadLeft(CodEstabelecimento, 5) + PadLeft(CodLoja, 4) + PadLeft(CodPDV, 3);
  lVersao := PadRight(VersaoAplicacao, 10);
  lNome := PadRight(NomeAplicacao, 20);
  lCripto := IfThen(Criptografia, '1', '0');
  lLog := IfThen(EfetuarLog, '1', '0');
  lInterativo := IfThen(Interativo, '1', '0');

  lNumSites := '01';
  lListaIPs := PadRight(EnderecoTCP, 15) + Format('%.5d', [PortaTCP]) + 'TCP ';

  // Normatizando os Parâmetros recebidos
  // Removendo as chaves, se existirem...
  lParam := Trim(ParametrosInicializacao);
  if (copy(lParam, 1, 1) = '[') then
    Delete(lParam, 1, 1);
  l := Length(lParam);
  if (copy(lParam, l, 1) = ']') then
    Delete(lParam, l, 1);

  // Quebrando os parâmetros em linhas
  slParam := TStringList.Create;
  try
    slParam.Text := StringReplace(lParam, ';', sLineBreak, [rfReplaceAll]);

    if ParamTemChave(slParam, PARAM_HTTPS) then    // Se tem a Chave de HTTPS, use ela...
      fSuporteHttps := (slParam.Values[PARAM_HTTPS] = '1')
    else
      slParam.Values[PARAM_HTTPS] := IfThen(fSuporteHttps, '1', '0');

    if fSuporteHttps then                        // Se o protocolo for HTTPS...
    begin
      lTerminal := StringOfChar('0', 12);        // o valor do terminal deverá ser preenchido com zeros
      lListaIPs := 'HTTPS';                      // o valor do parâmetro lista_ips pode ser preenchido com “HTTPS”
      lNumSites := '00';
    end;

    if not ParamTemChave(slParam, PARAM_PINPAD) then
    begin
      slMsgPinPad := TStringList.Create;
      try
        slMsgPinPad.Text := StringReplace(IfEmptyThen(MensagemPinPad,'TEF ACBR'), ',', sLineBreak, [rfReplaceAll]);
        if (slMsgPinPad.Count < 2) then
          slMsgPinPad.Add('DIGITE A SENHA');
        if (slMsgPinPad.Count < 3) then
          slMsgPinPad.Add('PROCESSANDO...');

        for i := 0 to slMsgPinPad.Count-1 do
          slMsgPinPad[i] := LeftStr(slMsgPinPad[i], 32); // Duas linhas de 16

        s := Trim(PortaPinPad);
        if StrIsNumber(s) then
          s := 'COM'+s;

        s := s+','+slMsgPinPad[0]+','+slMsgPinPad[1]+','+slMsgPinPad[2];

        slParam.Values[PARAM_PINPAD] := LLLVAR( s );
      finally
        slMsgPinPad.Free;
      end;
    end;

    //if not ParamTemChave(slParam, PARAM_HOST) then
    //  slParam.Values[PARAM_HOST] := LLVAR( Trim(EnderecoTCP) ) + Format('%.5d', [PortaTCP]);

    //lPath := PathWithoutDelim(PathCTFClient);
    //if (lPath <> '') then
    //begin
    //  if not ParamTemChave(slParam, PARAM_PATH_CTF) then  // Infelizmente, parece não funcionar
    //    slParam.Values[PARAM_PATH_CTF] := LLLVAR(lPath);
    //end;

    lParam := '[';
    for i := 0 to slParam.Count-1 do
      lParam := lParam + slParam[i] + ';';
    l := Length(lParam);
    if (copy(lParam, l, 1) = ';') then
      Delete(lParam, l, 1);
    lParam := lParam + ']';

  finally
    slParam.Free;
  end;

  GravarLog('iniciaClientCTF( '+lTerminal+', '+lVersao+', '+lNome+', '+lNumSites+', '+
    lListaIPs+', '+lCripto+', '+lLog+', '+lInterativo+', '+lParam+' )' );
  xiniciaClientCTF( PAnsiChar(lRes),
                    PAnsiChar(lTerminal),
                    PAnsiChar(lVersao),
                    PAnsiChar(lNome),
                    PAnsiChar(lNumSites), PAnsiChar(lListaIPs),
                    PAnsiChar(lCripto), PAnsiChar(lLog), PAnsiChar(lInterativo),
                    PAnsiChar(lParam) );
  GravarLog('  ret: '+lRes);

  Result := StrToIntDef(lRes, -1);
end;

function TACBrTEFAuttarAPI.IniciaTransacaoCTF(Operacao: Integer; Valor: Double;
  const NumDocto: String; DataFiscal: TDateTime; NumTransacao: Integer;
  const Dados: String): Integer;
var
  lRes, lOperacao, lValor, lNumDocto, lDataFiscal, lNumTransacao, lDados: AnsiString;
begin
  if not Carregada then
    DoException(Format(ACBrStr(sACBrTEFAPILibNaoInicializada), [CCTFClientLib]));

  Result := -1;
  lRes := StringOfChar('0',2);
  lOperacao := Format('%.3d', [Operacao]);
  lValor := Format('%.12d', [Trunc(RoundTo(Valor * 100,-2))] );
  lNumDocto := PadRight(NumDocto, 20);

  if DataFiscal = 0 then
    DataFiscal := Today;
  lDataFiscal := FormatDateTime('YYYYMMDD', DataFiscal);

  if (NumTransacao = 0) then
    NumTransacao := 1;
  lNumTransacao := Format('%.2d', [NumTransacao]);;

  lDados := Trim(Dados);
  if (LeftStr(lDados, 1) <> '[') then
    lDados := '['+lDados;
  if (RightStr(lDados, 1) <> ']') then
    lDados := lDados+']';

  GravarLog('iniciaTransacaoCTFext( '+lOperacao+', '+lValor+', '+lNumDocto+', '+
    lDataFiscal+', '+lNumTransacao+', '+lDados+' )');
  xiniciaTransacaoCTFext( PAnsiChar(lRes),
                          PAnsiChar(lOperacao),
                          PAnsiChar(lValor),
                          PAnsiChar(lNumDocto),
                          PAnsiChar(lDataFiscal),
                          PAnsiChar(lNumTransacao),
                          PAnsiChar(lDados) );
  GravarLog('  ret: '+lRes);

  Result := StrToIntDef(lRes, -1);
end;

function TACBrTEFAuttarAPI.ContinuaTransacaoCTF(var Comando: Integer;
  var NumSubcampo: Integer; var Buffer: String; var Display: Integer): Integer;
const
  cBUFFER_SIZE = 99000;
var
  lRes, lComando, lNumSubCampo, lBuffer, lTamBuffer, lDisplay: AnsiString;
  iTamBuffer: Integer;
begin
  if not Carregada then
    DoException(Format(ACBrStr(sACBrTEFAPILibNaoInicializada), [CCTFClientLib]));

  Result := -1;
  lRes := StringOfChar('0',2);
  lComando := Format('%.2d', [Comando]);
  lNumSubCampo := Format('%.4d', [NumSubcampo]);
  lTamBuffer := Format('%.5d', [Length(Buffer)]);
  lBuffer := PadRight(Buffer, cBUFFER_SIZE);
  lDisplay := Format('%.1d', [Display]);

  GravarLog('continuaTransacaoCTF( '+lComando+', '+lNumSubCampo+', '+
    Buffer+', '+lTamBuffer+', '+lDisplay+' )');
  xcontinuaTransacaoCTF( PAnsiChar(lRes),
                         PAnsiChar(lComando),
                         PAnsiChar(lNumSubCampo),
                         PAnsiChar(lBuffer),
                         PAnsiChar(lTamBuffer),
                         PAnsiChar(lDisplay) );

  Comando := StrToIntDef(lComando, -1);
  NumSubcampo := StrToIntDef(lNumSubCampo, -1);
  iTamBuffer := StrToIntDef(lTamBuffer, 0);
  Buffer := copy(lBuffer, 1, iTamBuffer);
  Display := StrToIntDef(lDisplay, 0);
  Result := StrToIntDef(lRes, -1);

  GravarLog('  ret: '+lRes+', Comando: '+lComando+', NumSubcampo: '+lNumSubCampo+
    ', Buffer: ['+Buffer+'], TamBuffer: '+lTamBuffer+', Display: '+lDisplay );
end;

function TACBrTEFAuttarAPI.FinalizaTransacaoCTF(Confirmar: Boolean;
  NumTransacao: Integer; DataFiscal: TDateTime; const Dados: String): Integer;
var
  lRes, lConfirmar, lNumTransacao, lDataFiscal, lDados: AnsiString;
begin
  if not Carregada then
    DoException(Format(ACBrStr(sACBrTEFAPILibNaoInicializada), [CCTFClientLib]));

  Result := -1;
  lRes := StringOfChar('0',2);
  lConfirmar := IfThen(Confirmar, '1', '0');
  if (NumTransacao = 0) then
    NumTransacao := 1;
  lNumTransacao := Format('%.2d', [NumTransacao]);;

  if DataFiscal = 0 then
    DataFiscal := Today;
  lDataFiscal := FormatDateTime('YYYYMMDD', DataFiscal);

  lDados := Trim(Dados);
  if (LeftStr(lDados, 1) <> '[') then
    lDados := '['+lDados;
  if (RightStr(lDados, 1) <> ']') then
    lDados := lDados+']';

  GravarLog('finalizaTransacaoCTFext( '+lConfirmar+', '+lNumTransacao+', '+
    ', '+lDataFiscal+', '+lDados+' )');
  xfinalizaTransacaoCTFext( PAnsiChar(lRes),
                            PAnsiChar(lConfirmar),
                            PAnsiChar(lNumTransacao),
                            PAnsiChar(lDataFiscal),
                            PAnsiChar(lDados) );
  GravarLog('  ret: '+lRes);

  Result := StrToIntDef(lRes, -1);
end;

procedure TACBrTEFAuttarAPI.DoExibirMensagem(const Mensagem: String;
  Tela: Integer; MilissegundosExibicao: Integer; out Cancelar: Boolean);
begin
  GravarLog('TACBrTEFAuttarAPI.DoExibirMensagem( '+Mensagem+', '+IntToStr(Tela)+', '+
    IntToStr(MilissegundosExibicao)+' )');
  fUltimaMensagem := Mensagem;
  Cancelar := False;
  fQuandoExibirMensagem(Mensagem, Tela, MilissegundosExibicao, Cancelar);
end;

procedure TACBrTEFAuttarAPI.LimparDisplay(Tela: Integer);
var
  Cancelar: Boolean;
begin
  Cancelar := False;
  DoExibirMensagem('', Tela, -1, Cancelar);
end;

function TACBrTEFAuttarAPI.DoPerguntarMenu(const Opcoes: String;
  const Titulo: String): Integer;
var
  sl: TStringList;
  r, t: String;
  ItemSelecionado, i, p: Integer;
begin
  Result := -1;
  t := Trim(Titulo);
  if (t = '') then
  begin
    t := TituloMenu;
    if (t = '') then
    begin
      t := UltimaMensagem;
      if (t = '') then
        t := 'CONFIRMA ?';
    end;
  end;

  GravarLog('TACBrTEFAuttarAPI.DoPerguntarMenu( ['+Opcoes+'], '+t+' )');
  sl := TStringList.Create;
  try
    sl.Text := StringReplace(Opcoes, ';', sLineBreak, [rfReplaceAll] );
    for i := 0 to sl.Count-1 do
      sl[i] := StringReplace(sl[i], '\', ' ', [rfReplaceAll]);   // Remove quebra de linha no Item (problemas para exibir no Menu))

    ItemSelecionado := -1;  // Cancela o Fluxo
    fQuandoPerguntarMenu(t, sl, ItemSelecionado);

    if (ItemSelecionado >= 0) and (ItemSelecionado < sl.Count) then
    begin
      r := sl[ItemSelecionado];
      Inc(ItemSelecionado); // CTF usa indice 1

      p := pos(':', r);
      if (p > 0) then
      begin
        r := copy(r, 1, p-1);
        i := StrToIntDef(r, -1);
        if (i >= 0) and (ItemSelecionado <> i) then
          ItemSelecionado := i
      end;
    end;

    Result := ItemSelecionado;
  finally
    sl.Free;
  end;
  GravarLog('   '+IntToStr(Result));
end;

function TACBrTEFAuttarAPI.DoPerguntarCampo(TipoCampo, TamMaximo: Integer;
  ZerosAEsquerda: Boolean; var Cancelar: Boolean; const Titulo: String): String;
var
  t, Resposta: String;
begin
  GravarLog('TACBrTEFAuttarAPI.DoPerguntarCampo( '+IntToStr(TipoCampo)+', '+
    IntToStr(TamMaximo)+', '+BoolToStr(ZerosAEsquerda, True)+', ,'+Titulo+' )');
  t := Titulo;
  if (t = '') then
    t := fUltimaMensagem;

  fQuandoPerguntarCampo(t, TipoCampo, TamMaximo, ZerosAEsquerda, Resposta, Cancelar);
  GravarLog('   '+Resposta);
  Result := Resposta;
end;

procedure TACBrTEFAuttarAPI.DoException(const AErrorMsg: String);
var
  s: String;
begin
  if (Trim(AErrorMsg) = '') then
    Exit;

  s := AErrorMsg;
  GravarLog('EACBrTEFAuttarAPI: '+s);
  raise EACBrTEFAuttarAPI.Create(s);
end;

procedure TACBrTEFAuttarAPI.GravarLog(const AString: AnsiString; Traduz: Boolean);
var
  Tratado: Boolean;
  AStringLog: AnsiString;
begin
  if not Assigned(fQuandoGravarLog) then
    Exit;

  if Traduz then
    AStringLog := TranslateUnprintable(AString)
  else
    AStringLog := AString;

  Tratado := False;
  fQuandoGravarLog(AStringLog, Tratado);
end;

function TACBrTEFAuttarAPI.CTFClientIsRunning: Boolean;
var
  Socket: TTCPBlockSocket;
begin
  Socket := TTCPBlockSocket.Create;
  try
    Socket.ConnectionTimeout := 2000;
    Socket.Connect(fEnderecoTCP, IntToStr(fPortaTCP) );
    Result := (Socket.LastError = 0);
  finally
    Socket.Free;
  end;
end;

procedure TACBrTEFAuttarAPI.RunCTFClientDesktop;
var
  DirCTFBin, cmd, DirAtual: String;
  //CTFCLIENT_HOME, DEFAULT_JVM_OPTS, JAVA_OPTS, CTF_CLIENT_DESKTOP_OPTS, JAVA_EXE, CLASSPATH, Params: String;
  //sl: TStringList;
begin

  //CTFCLIENT_HOME := PathWithoutDelim(PathCTFClient);
  //// Add default JVM options here. You can also use JAVA_OPTS and CTF_CLIENT_DESKTOP_OPTS to pass JVM options to this script.
  //DEFAULT_JVM_OPTS := '"-Dlog4j.configurationFile=' + CTFCLIENT_HOME + PathDelim + CCTFClientDirBin + PathDelim + 'log4j2.xml"';
  //JAVA_OPTS := Trim(SysUtils.GetEnvironmentVariable('JAVA_OPTS'));
  //CTF_CLIENT_DESKTOP_OPTS := Trim(SysUtils.GetEnvironmentVariable('CTF_CLIENT_DESKTOP_OPTS'));
  //
  //{$IfDef MSWINDOWS}
  // JAVA_EXE := CTFCLIENT_HOME + PathDelim + CCTFClientDirJre + PathDelim + 'bin' + PathDelim + 'java.exe';
  //{$Else}
  // JAVA_EXE := 'java';
  //{$EndIf}
  //
  //sl := TStringList.Create;
  //try
  //  FindFiles(CTFCLIENT_HOME + PathDelim + CCTFClientDirLib + PathDelim + '*.jar' , sl);
  //  CLASSPATH := StringReplace( Trim(SL.Text), sLineBreak, ';', [rfReplaceAll]);
  //
  //  // Execute ctf-client-desktop
  //  // "%JAVA_EXE%" %DEFAULT_JVM_OPTS% %JAVA_OPTS% %CTF_CLIENT_DESKTOP_OPTS%  -classpath "%CLASSPATH%" com.csi.ctfclient.integracao.IntegradorMain
  //  Params := Trim(DEFAULT_JVM_OPTS + ' ' + JAVA_OPTS + ' ' + CTF_CLIENT_DESKTOP_OPTS) +
  //            ' -classpath "'+CLASSPATH+'" com.csi.ctfclient.integracao.IntegradorMain';
  //  RunCommand(JAVA_EXE, Params, False, 0);
  //finally
  //  sl.Free;
  //end;

  DirAtual := '';
  GetDir(0, DirAtual);
  try
    DirCTFBin := PathWithoutDelim(CalcCTFClientPath(CCTFClientDirBin));
    ChDir(DirCTFBin);
    cmd := 'ctf-client-desktop.bat';
    RunCommand(cmd, '', False, 0);
  finally
    ChDir(DirAtual);
  end;
end;

function TACBrTEFAuttarAPI.GetCTFClientConfigFileName: String;
var
  p, f: String;
begin
  p := CalcCTFClientPath(CCTFClientDirBin);
  f := p + CCTFClientConfigFile;
  if not FileExists(f) then
    DoException(Format(ACBrStr(sErrArqCTFClientNaoEncontrado), [CCTFClientConfigFile, p]));

  Result := f;
end;

function TACBrTEFAuttarAPI.GetCTFClientConfigFileValue(const ANode,
  AAttribute: String): String;
var
  f: String;
  n: TACBrXmlNode;
  XmlDoc: TACBrXmlDocument;
begin
  f := GetCTFClientConfigFileName;
  Result := '';
  XmlDoc := TACBrXmlDocument.Create;
  try
    XmlDoc.LoadFromFile(f);
    n := FindNodeWithAttribute(XmlDoc.Root, ANode, AAttribute);
    if Assigned(n) then
      Result := n.Content;
  finally
    XmlDoc.Free;
  end;
end;

function TACBrTEFAuttarAPI.SetCTFClientConfigFileValue(const AParameterSet,
  AParameter, NewValue: String): Boolean;
var
  f: String;
  s,n: TACBrXmlNode;
  XmlDoc: TACBrXmlDocument;
begin
  f := GetCTFClientConfigFileName;
  Result := False;
  XmlDoc := TACBrXmlDocument.Create;
  try
    XmlDoc.LoadFromFile(f);
    s := FindNodeWithAttribute(XmlDoc.Root, 'ParameterSet', AParameterSet);
    if Assigned(s) then
    begin
      n := FindNodeWithAttribute(s, 'Parameter', AParameter);
      if not Assigned(n) then
      begin
        n := s.AddChild('Parameter');
        n.SetAttribute('name', AParameter);
      end;

      n.SetText(NewValue);
      XmlDoc.SaveToFile(f);
      Result := True;
    end;
  finally
    XmlDoc.Free;
  end;
end;

function TACBrTEFAuttarAPI.FindNodeWithAttribute(AParent: TACBrXmlNode; NodeName: String; AttributeName: String): TACBrXmlNode;
var
  n: TACBrXmlNode;
  a: TACBrXmlAttribute;
  Nname, Aname, AContent: String;
begin
  Result := Nil;
  n := Nil;
  a := Nil;
  while (Result = Nil) and AParent.GetNextChild(n) do
  begin
    if (n.Attributes.Count > 0) then
    begin
      while (Result = Nil) and n.GetNextAttribute(a) do
      begin
        Nname := Trim(n.Name);
        Aname := Trim(a.Name);
        AContent := Trim(a.Content);
        if (Nname = NodeName) and (Aname = 'name') and (AContent = AttributeName) then
          Result := n;
      end;
    end;

    if (Result = Nil) and (n.Childrens.Count > 0) then
      Result := FindNodeWithAttribute(n, NodeName, AttributeName);
  end;
end;

initialization
  vTEFAuttar := Nil;

finalization
  if Assigned(vTEFAuttar) then
    FreeAndNil(vTEFAuttar);

end.

