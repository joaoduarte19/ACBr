{******************************************************************************}
{ Projeto: Componente ACBrNFe                                                  }
{  Biblioteca multiplataforma de componentes Delphi para emissão de Nota Fiscal}
{ eletrônica - NFe - http://www.nfe.fazenda.gov.br                             }
{                                                                              }
{ Direitos Autorais Reservados (c) 2008 Wemerson Souto                         }
{                                       Daniel Simoes de Almeida               }
{                                       André Ferreira de Moraes               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do Projeto ACBr     }
{ Componentes localizado em http://www.sourceforge.net/projects/acbr           }
{                                                                              }
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
{ Daniel Simões de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Praça Anita Costa, 34 - Tatuí - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{******************************************************************************
|* Historico
|*
|* 16/12/2008: Wemerson Souto
|*  - Doação do componente para o Projeto ACBr
|* 09/04/2012: Italo
|*  - Incluído envio de evento
|* 17/07/2012: Italo
|*  - Incluído Consulta de NFe pelo Destinatário
|* 18/07/2012: Italo
|*  - Incluído Download da NFe
|* 28/09/2012: Italo
|*  - Suporte a NFe 3.0 - NFC-e
|* 22/09/2014: DSA
|*  - Refactoring, revisão e otimização
|* 03/10/2014: Italo Jurisato Junior
|*  - Comentado as classes/rotinas referentes a CC-e e
|*    Cancelamento via WebService
******************************************************************************}
{$I ACBr.inc}

unit ACBrNFeWebServices;

interface

uses Classes, SysUtils,
  ACBrDFeWebService,
  pcnNFe, pcnNFeW,
  pcnRetConsReciNFe, pcnRetConsCad, pcnAuxiliar, pcnConversao, pcnRetDPEC,
  pcnProcNFe, pcnRetCancNFe,
  pcnEnvEventoNFe, pcnRetEnvEventoNFe, pcnRetConsSitNFe,
  pcnConsNFeDest, pcnRetConsNFeDest,
  pcnDownloadNFe, pcnRetDownloadNFe,
  pcnAdmCSCNFCe, pcnRetAdmCSCNFCe,
  pcnDistDFeInt, pcnRetDistDFeInt, pcnRetEnvNFe,
  ACBrNFeNotasFiscais,
  ACBrNFeConfiguracoes;

const
  CURL_WSDL = 'http://www.portalfiscal.inf.br/nfe/wsdl/';

type

  { TNFeWebService }

  TNFeWebService = Class(TDFeWebService)
  private
  protected
    FCabMsg: String;
    FDadosMsg: String;
    FEnvelopeSoap: String;
    FRetornoWS: String;
    FRetWS: String;
    FMsg: String;
    FURL: String;
    FConfiguracoes: TConfiguracoesNFe;
    FACBrNFe : TComponent;
    FArqEnv: String;
    FArqResp: String;
    FServico: String;
    FSoapAction: String;
    FStatus: TStatusACBrNFe;
    FLayout: TLayOut;
  protected
    function EhAutorizacao: Boolean;
    function GerarSoapDEPC: String;
    procedure GerarException(Msg: String);
  protected
    procedure InicializarServico; virtual;
    procedure DefinirServicoEAction; virtual;
    procedure DefinirURL; virtual;
    procedure DefinirDadosMsg; virtual;
    procedure DefinirEnvelopeSoap; virtual;
    procedure SalvarEnvio; virtual;
    function TratarResposta: Boolean; virtual;
    procedure SalvarResposta; virtual;
    procedure FinalizarServico; virtual;

    function GerarMsgLog: String; virtual;
    function GerarMsgErro(E: Exception): String; virtual;
    function GerarVersaoDadosSoap: String; virtual;
    function GerarUFSoap:String; virtual;
    function GerarPrefixoArquivo: String; virtual;
  public
    constructor Create(AOwner : TComponent); virtual;

    function Executar: Boolean; virtual;

    property Servico: String      read FServico;
    property SoapAction: String   read FSoapAction;
    property Status: TStatusACBrNFe   read FStatus;
    property Layout: TLayOut          read FLayout;
    property URL: String              read FURL;
    property CabMsg: String           read FCabMsg;
    property DadosMsg: String         read FDadosMsg;
    property EnvelopeSoap: String     read FEnvelopeSoap;
    property RetornoWS: String        read FRetornoWS;
    property RetWS: String            read FRetWS;
    property Msg: String              read FMsg;
    property ArqEnv: String           read FArqEnv;
    property ArqResp: String          read FArqResp;
  end;

  { TNFeStatusServico }

  TNFeStatusServico = Class(TNFeWebService)
  private
    Fversao: String;
    FtpAmb : TpcnTipoAmbiente;
    FverAplic : String;
    FcStat : Integer;
    FxMotivo : String;
    FcUF : Integer;
    FdhRecbto : TDateTime;
    FTMed : Integer;
    FdhRetorno : TDateTime;
    FxObs :  String;
  protected
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    function TratarResposta: Boolean; override;

    function GerarMsgLog: String; override;
    function GerarMsgErro(E: Exception): String; override;
  public
    constructor Create(AOwner : TComponent); override;

    property versao : String          read Fversao;
    property tpAmb : TpcnTipoAmbiente read FtpAmb;
    property verAplic : String        read FverAplic;
    property cStat : Integer          read FcStat;
    property xMotivo : String         read FxMotivo;
    property cUF : Integer            read FcUF;
    property dhRecbto : TDateTime     read FdhRecbto;
    property TMed : Integer           read FTMed;
    property dhRetorno : TDateTime    read FdhRetorno;
    property xObs :  String           read FxObs;
  end;

  { TNFeRecepcao }

  TNFeRecepcao = Class(TNFeWebService)
  private
    FLote: String;
    FRecibo : String;
    FNotasFiscais : TNotasFiscais;
    Fversao: String;
    FTpAmb: TpcnTipoAmbiente;
    FverAplic: String;
    FcStat: Integer;
    FcUF: Integer;
    FxMotivo: String;
    FdhRecbto: TDateTime;
    FTMed: Integer;
    FSincrono: Boolean;

    FNFeRetornoSincrono: TRetConsSitNFe;
    FNFeRetorno: TretEnvNFe;

    function GetLote: String;
    function GetRecibo: String;
  protected
    procedure DefinirURL; override;
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    function TratarResposta: Boolean; override;
    procedure FinalizarServico; override;

    function GerarMsgLog: String; override;
    function GerarPrefixoArquivo: String; override;
  public
    constructor Create(AOwner : TComponent; ANotasFiscais : TNotasFiscais); reintroduce; overload;
    destructor Destroy; override;

    property Recibo: String          read GetRecibo;
    property versao : String         read Fversao;
    property TpAmb: TpcnTipoAmbiente read FTpAmb;
    property verAplic: String        read FverAplic;
    property cStat: Integer          read FcStat;
    property cUF: Integer            read FcUF;
    property xMotivo: String         read FxMotivo;
    property dhRecbto: TDateTime     read FdhRecbto;
    property TMed: Integer           read FTMed;
    property Lote: String            read GetLote   write FLote;
    property Sincrono: Boolean       read FSincrono write FSincrono;
  end;

  { TNFeRetRecepcao }

  TNFeRetRecepcao = Class(TNFeWebService)
  private
    FRecibo: String;
    FProtocolo: String;
    FChaveNFe: String;
    FNotasFiscais: TNotasFiscais;
    Fversao: String;
    FTpAmb: TpcnTipoAmbiente;
    FverAplic: String;
    FcStat: Integer;
    FcUF: Integer;
    FxMotivo: String;
    FcMsg: Integer;
    FxMsg: String;

    FNFeRetorno: TRetConsReciNFe;

    function GetRecibo: String;
    function TratarRespostaFinal : Boolean;
  protected
    procedure DefinirURL; override;
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    function TratarResposta: Boolean; override;
    procedure FinalizarServico; override;

    function GerarMsgLog: String; override;
    function GerarPrefixoArquivo: String; override;
  public
    constructor Create(AOwner : TComponent; ANotasFiscais : TNotasFiscais); reintroduce; overload;
    destructor Destroy; override;

    function Executar: Boolean; override;

    property versao : String         read Fversao;
    property TpAmb: TpcnTipoAmbiente read FTpAmb;
    property verAplic: String        read FverAplic;
    property cStat: Integer          read FcStat;
    property cUF: Integer            read FcUF;
    property xMotivo: String         read FxMotivo;
    property cMsg: Integer           read FcMsg;
    property xMsg: String            read FxMsg;
    property Recibo: String          read GetRecibo  write FRecibo;
    property Protocolo: String       read FProtocolo write FProtocolo;
    property ChaveNFe: String        read FChaveNFe  write FChaveNFe;

    property NFeRetorno: TRetConsReciNFe read FNFeRetorno;
  end;

  { TNFeRecibo }

  TNFeRecibo = Class(TNFeWebService)
  private
    FRecibo: String;
    Fversao: String;
    FTpAmb: TpcnTipoAmbiente;
    FverAplic: String;
    FcStat: Integer;
    FxMotivo: String;
    FcUF: Integer;
    FxMsg: String;
    FcMsg: Integer;

    FNFeRetorno: TRetConsReciNFe;
  protected
    procedure DefinirServicoEAction; override;
    procedure DefinirURL; override;
    procedure DefinirDadosMsg; override;
    function TratarResposta: Boolean; override;

    function GerarMsgLog: String; override;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;

    property versao : String         read Fversao;
    property TpAmb: TpcnTipoAmbiente read FTpAmb;
    property verAplic: String        read FverAplic;
    property cStat: Integer          read FcStat;
    property xMotivo: String         read FxMotivo;
    property cUF: Integer            read FcUF;
    property xMsg: String            read FxMsg;
    property cMsg: Integer           read FcMsg;
    property Recibo: String          read FRecibo write FRecibo;

    property NFeRetorno: TRetConsReciNFe read FNFeRetorno;
  end;

  { TNFeConsulta }

  TNFeConsulta = Class(TNFeWebService)
  private
    FNFeChave: WideString;
    FProtocolo: WideString;
    FDhRecbto: TDateTime;
    FXMotivo: WideString;
    Fversao: String;
    FTpAmb: TpcnTipoAmbiente;
    FverAplic: String;
    FcStat: Integer;
    FcUF: Integer;

    FprotNFe: TProcNFe;
    FretCancNFe: TRetCancNFe;
    FprocEventoNFe: TRetEventoNFeCollection;
  protected
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    function TratarResposta: Boolean; override;

    function GerarMsgLog: String; override;
    function GerarPrefixoArquivo: String; override;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;

    property NFeChave: WideString    read FNFeChave  write FNFeChave;
    property Protocolo: WideString   read FProtocolo write FProtocolo;
    property DhRecbto: TDateTime     read FDhRecbto  write FDhRecbto;
    property XMotivo: WideString     read FXMotivo   write FXMotivo;
    property versao: String          read Fversao;
    property TpAmb: TpcnTipoAmbiente read FTpAmb;
    property verAplic: String        read FverAplic;
    property cStat: Integer          read FcStat;
    property cUF: Integer            read FcUF;

    property protNFe: TProcNFe                      read FprotNFe;
    property retCancNFe: TRetCancNFe                read FretCancNFe;
    property procEventoNFe: TRetEventoNFeCollection read FprocEventoNFe;
  end;

  { TNFeInutilizacao }

  TNFeInutilizacao = Class(TNFeWebService)
  private
    FID: WideString;
    FProtocolo: string;
    FModelo: Integer;
    FSerie: Integer;
    FCNPJ: String;
    FAno: Integer;
    FNumeroInicial: Integer;
    FNumeroFinal: Integer;
    FJustificativa: WideString;
    Fversao: String;
    FTpAmb: TpcnTipoAmbiente;
    FverAplic: String;
    FcStat: Integer;
    FxMotivo : String;
    FcUF: Integer;
    FdhRecbto: TDateTime;

    FXML_ProcInutNFe: String;

    procedure SetJustificativa(AValue: WideString);
    function GerarPathPorCNPJ: String;
  protected
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    procedure SalvarEnvio; override;
    function TratarResposta: Boolean; override;
    procedure SalvarResposta; override;

    function GerarMsgLog: String; override;
    function GerarPrefixoArquivo: String; override;
  public
    constructor Create(AOwner : TComponent); override;

    property ID: WideString            read FID            write FID;
    property Protocolo: String         read FProtocolo     write FProtocolo;
    property Modelo: Integer           read FModelo        write FModelo;
    property Serie: Integer            read FSerie         write FSerie;
    property CNPJ: String              read FCNPJ          write FCNPJ;
    property Ano: Integer              read FAno           write FAno;
    property NumeroInicial: Integer    read FNumeroInicial write FNumeroInicial;
    property NumeroFinal: Integer      read FNumeroFinal   write FNumeroFinal;
    property Justificativa: WideString read FJustificativa write SetJustificativa;
    property versao: String            read Fversao;
    property TpAmb: TpcnTipoAmbiente   read FTpAmb;
    property verAplic: String          read FverAplic;
    property cStat: Integer            read FcStat;
    property xMotivo : String          read FxMotivo;
    property cUF: Integer              read FcUF;
    property dhRecbto: TDateTime       read FdhRecbto;

    property XML_ProcInutNFe: String read FXML_ProcInutNFe write FXML_ProcInutNFe;
  end;

  { TNFeConsultaCadastro }

  TNFeConsultaCadastro = Class(TNFeWebService)
  private
    Fversao: String;
    FverAplic: String;
    FcStat: Integer;
    FxMotivo: String;
    FUF: String;
    FIE: String;
    FCNPJ: String;
    FCPF: String;
    FcUF: Integer;
    FdhCons: TDateTime;

    FRetConsCad : TRetConsCad;

    procedure SetCNPJ(const Value: String);
    procedure SetCPF(const Value: String);
    procedure SetIE(const Value: String);
  protected
    procedure DefinirURL; override;
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    function TratarResposta: Boolean; override;

    function GerarMsgLog: String; override;
    function GerarUFSoap: String; override;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;

    property versao: String    read Fversao;
    property verAplic: String  read FverAplic;
    property cStat: Integer    read FcStat;
    property xMotivo: String   read FxMotivo;
    property DhCons: TDateTime read FdhCons;
    property cUF: Integer      read FcUF;
    property UF: String        read FUF   write FUF;
    property IE: String        read FIE   write SetIE;
    property CNPJ: String      read FCNPJ write SetCNPJ;
    property CPF: String       read FCPF  write SetCPF;

    property RetConsCad: TRetConsCad read FRetConsCad;
  end;

  { TNFeEnvDPEC }

  TNFeEnvDPEC = Class(TNFeWebService)
  private
    FId: String;
    FverAplic: String;
    FcStat: Integer;
    Fversao: String;
    FTpAmb: TpcnTipoAmbiente;
    FxMotivo: String;
    FdhRegDPEC: TDateTime;
    FnRegDPEC: String;
    FNFeChave: String;

    FXML_ProcDPEC: String;
  protected
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    procedure DefinirEnvelopeSoap; override;
    procedure SalvarEnvio; override;
    function TratarResposta: Boolean; override;
    procedure SalvarResposta; override;

    function GerarMsgLog: String; override;
  public
    constructor Create(AOwner : TComponent); override;

    property ID: String               read FId;
    property verAplic: String         read FverAplic;
    property cStat: Integer           read FcStat;
    property versao: String           read Fversao;
    property TpAmb: TpcnTipoAmbiente  read FTpAmb;
    property xMotivo: String          read FxMotivo;
    property DhRegDPEC: TDateTime     read FdhRegDPEC;
    property nRegDPEC: String         read FnRegDPEC;
    property NFeChave: String         read FNFeChave;

    property XML_ProcDPEC: String read FXML_ProcDpec write FXML_ProcDpec;
  end;

  { TNFeConsultaDPEC }

  TNFeConsultaDPEC = Class(TNFeWebService)
  private
    FverAplic: String;
    FcStat: Integer;
    Fversao: String;
    FTpAmb: TpcnTipoAmbiente;
    FxMotivo: String;
    FnRegDPEC: String;
    FNFeChave: String;
    FdhRegDPEC: TDateTime;

    FretDPEC: TRetDPEC;

    procedure SetNFeChave(const Value: String);
    procedure SetnRegDPEC(const Value: String);
  protected
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    procedure DefinirEnvelopeSoap; override;
    function TratarResposta: Boolean; override;

    function GerarMsgLog: String; override;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;

    property verAplic: String        read FverAplic;
    property cStat: Integer          read FcStat;
    property versao: String          read Fversao;
    property TpAmb: TpcnTipoAmbiente read FTpAmb;
    property xMotivo: String         read FxMotivo;
    property dhRegDPEC: TDateTime    read FdhRegDPEC;
    property nRegDPEC: String        read FnRegDPEC write SetnRegDPEC;
    property NFeChave: String        read FNFeChave write SetNFeChave;

    property retDPEC: TRetDPEC       read FretDPEC;
  end;

  { TNFeEnvEvento }

  TNFeEnvEvento = Class(TNFeWebService)
  private
    FidLote: Integer;
    Fversao: String;
    FEvento: TEventoNFe;
    FcStat: Integer;
    FxMotivo: String;
    FTpAmb: TpcnTipoAmbiente;

    FEventoRetorno: TRetEventoNFe;

    function GerarPathEvento: String;
  protected
    procedure DefinirURL; override;
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    procedure SalvarEnvio; override;
    function TratarResposta: Boolean; override;
    procedure SalvarResposta; override;

    function GerarMsgLog: String; override;
    function GerarPrefixoArquivo: String; override;
  public
    constructor Create(AOwner : TComponent; AEvento : TEventoNFe);reintroduce; overload;
    destructor Destroy; override;

    property idLote: Integer              read FidLote write FidLote;
    property versao: String               read Fversao write Fversao;
    property cStat: Integer               read FcStat;
    property xMotivo: String              read FxMotivo;
    property TpAmb: TpcnTipoAmbiente      read FTpAmb;

    property EventoRetorno: TRetEventoNFe read FEventoRetorno;
  end;

  { TNFeConsNFeDest }

  TNFeConsNFeDest = Class(TNFeWebService)
  private
    Fversao: String;
    FtpAmb: TpcnTipoAmbiente;
    FCNPJ: String;
    FindEmi: TpcnIndicadorEmissor;
    FindNFe: TpcnIndicadorNFe;
    FultNSU: String;

    FretConsNFeDest: TretConsNFeDest;
  protected
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    function TratarResposta: Boolean; override;

    function GerarMsgLog: String; override;
    function GerarMsgErro(E: Exception): String; override;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;

    property versao: String                  read Fversao;
    property tpAmb: TpcnTipoAmbiente         read FtpAmb;
    property CNPJ: String                    read FCNPJ   write FCNPJ;
    property indNFe: TpcnIndicadorNFe        read FindNFe write FindNFe;
    property indEmi: TpcnIndicadorEmissor    read FindEmi write FindEmi;
    property ultNSU: String                  read FultNSU write FultNSU;

    property retConsNFeDest: TretConsNFeDest read FretConsNFeDest;
  end;

  { TNFeDownloadNFe }

  TNFeDownloadNFe = Class(TNFeWebService)
  private
    Fversao: String;
    FtpAmb: TpcnTipoAmbiente;
    FCNPJ: String;
    FDownload: TDownLoadNFe;

    FretDownloadNFe: TretDownloadNFe;
  protected
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    function TratarResposta: Boolean; override;

    function GerarMsgLog: String; override;
    function GerarMsgErro(E: Exception): String; override;
  public
    constructor Create(AOwner : TComponent; ADownload : TDownloadNFe); reintroduce; overload;
    destructor Destroy; override;

    property versao: String                  read Fversao;
    property tpAmb: TpcnTipoAmbiente         read FtpAmb;
    property CNPJ: String                    read FCNPJ write FCNPJ;

    property retDownloadNFe: TretDownloadNFe read FretDownloadNFe;
  end;

  { TAdministrarCSCNFCe }

  TAdministrarCSCNFCe = Class(TNFeWebService)
  private
    Fversao: String;
    FtpAmb: TpcnTipoAmbiente;
    FRaizCNPJ: String;
    FindOp: TpcnIndOperacao;
    FIdCSC: Integer;
    FCodigoCSC: String;

    FretAdmCSCNFCe: TRetAdmCSCNFCe;
  protected
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    function TratarResposta: Boolean; override;

    function GerarMsgLog: String; override;
    function GerarMsgErro(E: Exception): String; override;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;

    property versao: String                read Fversao;
    property tpAmb: TpcnTipoAmbiente       read FtpAmb;
    property RaizCNPJ: String              read FRaizCNPJ  write FRaizCNPJ;
    property indOP: TpcnIndOperacao        read FindOP     write FindOP;
    property idCsc: Integer                read FidCsc     write FidCsc;
    property codigoCsc: String             read FcodigoCsc write FcodigoCsc;

    property retAdmCSCNFCe: TRetAdmCSCNFCe read FretAdmCSCNFCe;
  end;

  { TDistribuicaoDFe }

  TDistribuicaoDFe = Class(TNFeWebService)
  private
    Fversao: String;
    FtpAmb: TpcnTipoAmbiente;
    FcUFAutor: Integer;
    FCNPJCPF: String;
    FultNSU: String;
    FNSU: String;

    FretDistDFeInt: TretDistDFeInt;
  protected
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    procedure DefinirEnvelopeSoap; override;
    function TratarResposta: Boolean; override;

    function GerarMsgLog: String; override;
    function GerarMsgErro(E: Exception): String; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property versao: String                read Fversao;
    property tpAmb: TpcnTipoAmbiente       read FtpAmb;
    property cUFAutor: Integer             read FcUFAutor write FcUFAutor;
    property CNPJCPF: String               read FCNPJCPF  write FCNPJCPF;
    property ultNSU: String                read FultNSU   write FultNSU;
    property NSU: String                   read FNSU      write FNSU;

    property retDistDFeInt: TretDistDFeInt read FretDistDFeInt;
  end;  

  { TNFeEnvioWebService }

  TNFeEnvioWebService = Class(TNFeWebService)
  private
    FXMLEnvio: String;
    FURLEnvio: String;
    FVersao: String;
    FSoapActionEnvio: String;
  protected
    procedure DefinirURL; override;
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    function TratarResposta: Boolean; override;

    function GerarMsgLog: String; override;
    function GerarMsgErro(E: Exception): String; override;
    function GerarVersaoDadosSoap: String; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Executar: Boolean; override;

    property XMLEnvio: String        read FXMLEnvio        write FXMLEnvio;
    property URLEnvio: String        read FURLEnvio        write FURLEnvio;
    property SoapActionEnvio: String read FSoapActionEnvio write FSoapActionEnvio;
  end;

  TWebServices = Class
  private
    FACBrNFe : TComponent;
    FStatusServico: TNFeStatusServico;
    FEnviar: TNFeRecepcao;
    FRetorno: TNFeRetRecepcao;
    FRecibo: TNFeRecibo;
    FConsulta: TNFeConsulta;
    FInutilizacao: TNFeInutilizacao;
    FConsultaCadastro: TNFeConsultaCadastro;
    FEnviaDPEC: TNFeEnvDPEC;
    FConsultaDPEC: TNFeConsultaDPEC;
    FEnvEvento: TNFeEnvEvento;
    FConsNFeDest: TNFeConsNFeDest;
    FDownloadNFe: TNFeDownloadNFe;
    FAdministrarCSCNFCe: TAdministrarCSCNFCe;
    FDistribuicaoDFe: TDistribuicaoDFe;
    FEnvioWebService: TNFeEnvioWebService;
  public
    constructor Create(AFNotaFiscalEletronica: TComponent); overload;
    destructor Destroy; override;

    function Envia(ALote: Integer;
                   const ASincrono: Boolean = False): Boolean; overload;
    function Envia(ALote: String;
                   const ASincrono: Boolean = False): Boolean; overload;
    procedure Inutiliza(CNPJ, AJustificativa: String;
                        Ano, Modelo, Serie, NumeroInicial, NumeroFinal : Integer);
  //published
    property ACBrNFe: TComponent                     read FACBrNFe            write FACBrNFe;
    property StatusServico: TNFeStatusServico        read FStatusServico      write FStatusServico;
    property Enviar: TNFeRecepcao                    read FEnviar             write FEnviar;
    property Retorno: TNFeRetRecepcao                read FRetorno            write FRetorno;
    property Recibo: TNFeRecibo                      read FRecibo             write FRecibo;
    property Consulta: TNFeConsulta                  read FConsulta           write FConsulta;
    property Inutilizacao: TNFeInutilizacao          read FInutilizacao       write FInutilizacao;
    property ConsultaCadastro: TNFeConsultaCadastro  read FConsultaCadastro   write FConsultaCadastro;
    property EnviarDPEC: TNFeEnvDPEC                 read FEnviaDPEC          write FEnviaDPEC;
    property ConsultaDPEC: TNFeConsultaDPEC          read FConsultaDPEC       write FConsultaDPEC;
    property EnvEvento: TNFeEnvEvento                read FEnvEvento          write FEnvEvento;
    property ConsNFeDest: TNFeConsNFeDest            read FConsNFeDest        write FConsNFeDest;
    property DownloadNFe: TNFeDownloadNFe            read FDownloadNFe        write FDownloadNFe;
    property AdministrarCSCNFCe: TAdministrarCSCNFCe read FAdministrarCSCNFCe write FAdministrarCSCNFCe;
    property DistribuicaoDFe: TDistribuicaoDFe       read FDistribuicaoDFe    write FDistribuicaoDFe;
    property EnvioWebService: TNFeEnvioWebService    read FEnvioWebService    write FEnvioWebService;
  end;

implementation

uses {$IFDEF ACBrNFeOpenSSL}
        ssl_openssl,
     {$ENDIF}
     ACBrUtil, ACBrNFeUtil, ACBrNFe, ACBrDFeUtil,
     pcnGerador, pcnCabecalho,
     pcnConsStatServ, pcnRetConsStatServ,
     pcnCancNFe, pcnConsSitNFe,
     pcnInutNFe, pcnRetInutNFe,
     pcnConsReciNFe, pcnConsCad,
     pcnNFeR, pcnLeitor,
     pcnEnvDPEC, pcnConsDPEC, pcnEventoNFe, StrUtils;

{ TNFeWebService }

constructor TNFeWebService.Create(AOwner: TComponent);
begin
  FConfiguracoes := TACBrNFe( AOwner ).Configuracoes;
  FACBrNFe       := TACBrNFe( AOwner );
  FLayout        := LayNfeStatusServico;
  FStatus        := stIdle;
  FCabMsg        := '';
  FDadosMsg      := '';
  FRetornoWS     := '';
  FRetWS         := '';
  FMsg           := '';
  FURL           := '';
  FArqEnv        := '';
  FArqResp       := '';
  FServico       := '';
  FSoapAction    := '';
end;

function TNFeWebService.EhAutorizacao: Boolean;
begin
  Result := False;
  case FConfiguracoes.Geral.ModeloDF of
    moNFe:  
      if (FConfiguracoes.Geral.VersaoDF = ve310) then
        Result := True;
    moNFCe: 
      if (FConfiguracoes.Geral.VersaoDF = ve310) and not
         (FConfiguracoes.WebServices.UFCodigo in [13])  then // AM
        Result := True;
  end;
end;

function TNFeWebService.GerarSoapDEPC: String;
var
  Texto: String;
begin
  Texto := '<'+ENCODING_UTF8+'>';
  Texto := Texto + '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                                  'xmlns:xsd="http://www.w3.org/2001/XMLSchema" ' +
                                  'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">';
  Texto := Texto + '<soap:Header>';
  Texto := Texto +  '<sceCabecMsg xmlns="' + Servico + '">';
  Texto := Texto +    GerarVersaoDadosSoap;
  Texto := Texto +  '</sceCabecMsg>';
  Texto := Texto + '</soap:Header>';
  Texto := Texto + '<soap:Body>';
  Texto := Texto +  '<sceDadosMsg xmlns="' + Servico +'">';
  Texto := Texto +    FDadosMsg;
  Texto := Texto +  '</sceDadosMsg>';
  Texto := Texto + '</soap:Body>';
  Texto := Texto + '</soap:Envelope>';

  Result := Texto;
end;

function TNFeWebService.Executar: Boolean;
var
  ErroMsg: String;
begin
  { Sobrescrever apenas se realmente necessário }

  InicializarServico;
  try
    DefinirDadosMsg;
    DefinirEnvelopeSoap;
    SalvarEnvio;

    try
      EnviarDados;
      Result := TratarResposta;
      FazerLog( GerarMsgLog, True );
      SalvarResposta;
    except
      on E: Exception do
      begin
        Result := False;
        ErroMsg := GerarMsgErro(E);
        GerarException( ErroMsg );
      end;
    end;
  finally
     FinalizarServico;
  end;
end;

procedure TNFeWebService.InicializarServico;
begin
  { Sobrescrever apenas se necessário }

  DefinirURL;
  if URL = '' then
    GerarException('URL não definida para: ' + ClassName);

  DefinirServicoEAction;
  if Servico = '' then
    GerarException('Servico não definido para: ' + ClassName);

  if SoapAction = '' then
    GerarException('SoapAction não definido para: ' + ClassName);

  TACBrNFe( FACBrNFe ).SetStatus( FStatus );
end;

procedure TNFeWebService.DefinirServicoEAction;
begin
  { sobrescrever, OBRIGATORIAMENTE }

  FServico    := '';
  FSoapAction := '';
end;

procedure TNFeWebService.DefinirURL;
begin
  { sobrescrever apenas se necessário.
    Você também pode mudar apenas o valor de "FLayoutServico" na classe
    filha e chamar: Inherited;     }

  FURL := NotaUtil.GetURL( FConfiguracoes.WebServices.UFCodigo,
                           FConfiguracoes.WebServices.AmbienteCodigo,
                           FConfiguracoes.Geral.FormaEmissaoCodigo,
                           Layout,
                           FConfiguracoes.Geral.ModeloDF,
                           FConfiguracoes.Geral.VersaoDF );
end;


procedure TNFeWebService.DefinirDadosMsg;
begin
  { sobrescrever, OBRIGATORIAMENTE }

  FDadosMsg := '';
end;


procedure TNFeWebService.DefinirEnvelopeSoap;
var
  Texto: String;
begin
  { Sobrescrever apenas se necessário }

  Texto := '<'+ENCODING_UTF8+'>' ;    // Envelop Final DEVE SEMPRE estar em UTF8...

  Texto := Texto + '<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" '+
                                    'xmlns:xsd="http://www.w3.org/2001/XMLSchema" ' +
                                    'xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">';
  Texto := Texto +   '<soap12:Header>';
  Texto := Texto +     '<nfeCabecMsg xmlns="' + Servico + '">';
  Texto := Texto +       GerarUFSoap;
  Texto := Texto +       GerarVersaoDadosSoap;
  Texto := Texto +     '</nfeCabecMsg>';
  Texto := Texto +   '</soap12:Header>';
  Texto := Texto +   '<soap12:Body>';

  Texto := Texto +     '<nfeDadosMsg xmlns="' + Servico + '">';
  Texto := Texto +       DadosMsg;
  Texto := Texto +     '</nfeDadosMsg>';
  Texto := Texto +   '</soap12:Body>';
  Texto := Texto +'</soap12:Envelope>';

  FEnvelopeSoap := Texto;
end;

function TNFeWebService.GerarUFSoap: String;
begin
  Result := '<cUF>' + IntToStr(FConfiguracoes.WebServices.UFCodigo) + '</cUF>';
end;

function TNFeWebService.GerarVersaoDadosSoap: String;
begin
  { Sobrescrever apenas se necessário }

  ////Result := '<versaoDados>' + GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
  ////                                         FConfiguracoes.Geral.VersaoDF,
  ////                                         Layout) +
  ////          '</versaoDados>';
end;


function TNFeWebService.GerarPrefixoArquivo: String;
begin
  Result := FormatDateTime('yyyymmddhhnnss', Now);
end;

procedure TNFeWebService.SalvarEnvio;
var
  Prefixo, ArqEnv: String;
begin
  { Sobrescrever apenas se necessário }

  if FArqEnv = '' then exit;

  Prefixo := GerarPrefixoArquivo;

  if FConfiguracoes.Arquivos.Salvar then
  begin
    ArqEnv := Prefixo + '-' + FArqEnv + '.xml';
    ////FConfiguracoes.Geral.Save(ArqEnv, FDadosMsg);
  end;

  if FConfiguracoes.WebServices.Salvar then
  begin
    ArqEnv := Prefixo + '-' + FArqEnv + '-soap.xml';
    ////FConfiguracoes.Geral.Save(ArqEnv, FEnvelopeSoap);
  end;
end;

procedure TNFeWebService.SalvarResposta;
var
  Prefixo, ArqResp: String;
begin
  { Sobrescrever apenas se necessário }

  if FArqResp = '' then exit;

  Prefixo := GerarPrefixoArquivo;

  if FConfiguracoes.Arquivos.Salvar then
  begin
    ArqResp := Prefixo + '-' + FArqResp + '.xml';
    ////FConfiguracoes.Geral.Save(ArqResp, FRetWS);
  end;

  if FConfiguracoes.WebServices.Salvar then
  begin
    ArqResp := Prefixo + '-' + FArqResp + '-soap.xml';
    ////FConfiguracoes.Geral.Save(ArqResp, FRetornoWS );
  end;
end;

function TNFeWebService.GerarMsgLog: String;
begin
  { sobrescrever, se quiser Logar }

  Result := '';
end;

function TNFeWebService.TratarResposta: Boolean;
begin
  { sobrescrever, OBRIGATORIAMENTE }

  Result := False;
end;

procedure TNFeWebService.GerarException(Msg: String);
begin
  FazerLog( 'ERRO: ' + Msg, False );
  raise EACBrNFeException.Create( Msg );
end;

function TNFeWebService.GerarMsgErro(E: Exception): String;
begin
  { Sobrescrever com mensagem adicional, se desejar }

  Result := E.Message;
end;

procedure TNFeWebService.FinalizarServico;
begin
  { Sobrescrever apenas se necessário }

  TACBrNFe( FACBrNFe ).SetStatus( stIdle );
  ////NotaUtil.ConfAmbiente;
end;

{ TNFeStatusServico }

constructor TNFeStatusServico.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FStatus  := stNFeStatusServico;
  FLayout  := LayNfeStatusServico;
  FArqEnv  := 'ped-sta';
  FArqResp := 'sta';
end;

procedure TNFeStatusServico.DefinirServicoEAction;
begin
  if (FConfiguracoes.Geral.ModeloDF = moNFe) and
     (FConfiguracoes.Geral.VersaoDF = ve310) and
     (FConfiguracoes.WebServices.UFCodigo = 29) then
  begin
    FServico    := CURL_WSDL + 'NfeStatusServico';
    FSoapAction := FServico + '/NfeStatusServicoNF';
  end
  else
  begin
    FServico    := CURL_WSDL + 'NfeStatusServico2';
    FSoapAction := FServico;
  end;
end;

procedure TNFeStatusServico.DefinirDadosMsg;
var
  ConsStatServ: TConsStatServ;
begin
  ConsStatServ := TConsStatServ.create;
  try
    ConsStatServ.TpAmb := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo-1);
    ConsStatServ.CUF   := FConfiguracoes.WebServices.UFCodigo;

    ////ConsStatServ.Versao := GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
    ////                                    FConfiguracoes.Geral.VersaoDF,
    ////                                    LayNfeStatusServico);

    ConsStatServ.GerarXML;

    // Atribuindo o XML para propriedade interna //
    FDadosMsg := ConsStatServ.Gerador.ArquivoFormatoXML;
  finally
    ConsStatServ.Free;
  end;
end;

function TNFeStatusServico.TratarResposta: Boolean;
var
  NFeRetorno: TRetConsStatServ;
begin
  FRetWS := SeparaDados( FRetornoWS, 'nfeStatusServicoNF2Result' );
  if FRetWS = '' then
    FRetWS := SeparaDados( FRetornoWS, 'NfeStatusServicoNFResult' );

  NFeRetorno := TRetConsStatServ.Create;
  try
    NFeRetorno.Leitor.Arquivo := FRetWS;
    NFeRetorno.LerXml;

    Fversao    := NFeRetorno.versao;
    FtpAmb     := NFeRetorno.tpAmb;
    FverAplic  := NFeRetorno.verAplic;
    FcStat     := NFeRetorno.cStat;
    FxMotivo   := NFeRetorno.xMotivo;
    FcUF       := NFeRetorno.cUF;
    FdhRecbto  := NFeRetorno.dhRecbto;
    FTMed      := NFeRetorno.TMed;
    FdhRetorno := NFeRetorno.dhRetorno;
    FxObs      := NFeRetorno.xObs;
    FMsg       := FxMotivo + LineBreak + FxObs;

    if FConfiguracoes.WebServices.AjustaAguardaConsultaRet then
       FConfiguracoes.WebServices.AguardarConsultaRet := FTMed*1000;

    Result := (FcStat = 107);

  finally
    NFeRetorno.Free;
  end;
end;

function TNFeStatusServico.GerarMsgLog: String;
begin
  Result := 'Versão Layout : ' + Fversao + LineBreak +
            'Ambiente : ' + TpAmbToStr(FtpAmb) + LineBreak +
            'Versão Aplicativo : ' + FverAplic + LineBreak +
            'Status Código : ' + IntToStr(FcStat) + LineBreak +
            'Status Descrição : ' + FxMotivo + LineBreak +
            'UF : ' + CodigoParaUF(FcUF) + LineBreak +
            'Recebimento : ' + IfThen(FdhRecbto = 0,'',DateTimeToStr(FdhRecbto)) +
                               LineBreak +
            'Tempo Médio : ' + IntToStr(FTMed) + LineBreak +
            'Retorno : ' + IfThen(FdhRetorno = 0,'',DateTimeToStr(FdhRetorno)) +
                           LineBreak +
            'Observação : ' + FxObs + LineBreak;
end;

function TNFeStatusServico.GerarMsgErro(E: Exception): String;
begin
  Result := 'WebService Consulta Status serviço:' + LineBreak +
            '- Inativo ou Inoperante tente novamente.' + LineBreak +
            '- ' + E.Message
end;

{ TNFeRecepcao }

constructor TNFeRecepcao.Create(AOwner : TComponent;
  ANotasFiscais: TNotasFiscais);
begin
  inherited Create(AOwner);

  FNotasFiscais := ANotasFiscais;
  FSincrono     := False;

  FStatus  := stNFeRecepcao;
  FLayout  := LayNfeRecepcao;
  FArqEnv  := 'env-lot';
  FArqResp := 'rec';

  FNFeRetornoSincrono := nil;
  FNFeRetorno := nil;
end;

destructor TNFeRecepcao.Destroy;
begin
  if Assigned(FNFeRetornoSincrono) then
    FNFeRetornoSincrono.Free;

  if Assigned(FNFeRetorno) then
    FNFeRetorno.Free;

  inherited Destroy;
end;

function TNFeRecepcao.GetLote: String;
begin
  Result := Trim(FLote);
end;

function TNFeRecepcao.GetRecibo: String;
begin
  Result := Trim(FRecibo);
end;

procedure TNFeRecepcao.DefinirURL;
begin
  if EhAutorizacao then
    FLayout := LayNfeAutorizacao
  else
    FLayout := LayNfeRecepcao;

  inherited DefinirURL;
end;

procedure TNFeRecepcao.DefinirServicoEAction;
begin
  if FLayout = LayNfeAutorizacao then
    FServico := CURL_WSDL + 'NfeAutorizacao'
  else
    FServico := CURL_WSDL + 'NfeRecepcao2';

  FSoapAction := FServico;
end;

procedure TNFeRecepcao.DefinirDadosMsg;
var
  I: Integer;
  vNotas: WideString;
  indSinc, Versao: String;
begin
  if (FLayout = LayNfeAutorizacao) or
     (FConfiguracoes.Geral.ModeloDF = moNFCe) or
     (FConfiguracoes.Geral.VersaoDF = ve310) then
    indSinc := '<indSinc>' + IfThen(FSincrono, '1', '0') + '</indSinc>'
  else
    indSinc := '';

  ////Versao := GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
  ////                       FConfiguracoes.Geral.VersaoDF,
  ////                       Layout);

  vNotas := '';
  for I := 0 to FNotasFiscais.Count-1 do
    vNotas := vNotas + '<NFe' +
                         RetornarConteudoEntre(FNotasFiscais.Items[I].XMLOriginal,
                                               '<NFe',
                                               '</NFe>') +
                       '</NFe>';

  FDadosMsg := '<enviNFe xmlns="http://www.portalfiscal.inf.br/nfe" versao="' + Versao + '">' +
                 '<idLote>' + FLote + '</idLote>' +
                 indSinc +
                 vNotas +
               '</enviNFe>';

  // Lote tem mais de 500kb ? //
  if Length(FDadosMsg) > (500 * 1024) then
    GerarException('Tamanho do XML de Dados superior a 500 Kbytes. Tamanho atual: '+
                   IntToStr(trunc(Length(FDadosMsg)/1024)) + ' Kbytes' );

  FRecibo := '';
end;

function TNFeRecepcao.TratarResposta: Boolean;
var
  I: Integer;
  chNFe, NomeArquivo: String;
  AProcNFe: TProcNFe;
  Data: TDateTime;
begin
  if FLayout = LayNfeAutorizacao then
  begin
    FRetWS := SeparaDados( FRetornoWS, 'nfeAutorizacaoLoteResult' );
    if FRetWS = '' then
      FRetWS := SeparaDados( FRetornoWS, 'nfeAutorizacaoResult' );
  end
  else
    FRetWS := SeparaDados( FRetornoWS, 'nfeRecepcaoLote2Result' );

  if ((FConfiguracoes.Geral.ModeloDF = moNFCe) or
      (FConfiguracoes.Geral.VersaoDF = ve310)) and FSincrono then  begin
    FNFeRetornoSincrono := TRetConsSitNFe.Create;

    if pos('retEnviNFe', FRetWS) > 0 then
      FNFeRetornoSincrono.Leitor.Arquivo := StringReplace(FRetWS,
                                                          'retEnviNFe',
                                                          'retConsSitNFe',
                                                          [rfReplaceAll,
                                                           rfIgnoreCase])
    else if pos('retConsReciNFe', FRetWS) > 0 then
      FNFeRetornoSincrono.Leitor.Arquivo := StringReplace(FRetWS,
                                                          'retConsReciNFe',
                                                          'retConsSitNFe',
                                                          [rfReplaceAll,
                                                           rfIgnoreCase])
    else
      FNFeRetornoSincrono.Leitor.Arquivo := FRetWS;

    FNFeRetornoSincrono.LerXml;

    Fversao   := FNFeRetornoSincrono.versao;
    FTpAmb    := FNFeRetornoSincrono.TpAmb;
    FverAplic := FNFeRetornoSincrono.verAplic;

    // Consta no Retorno da NFC-e
    FRecibo  := FNFeRetornoSincrono.nRec;
    FcStat   := FNFeRetornoSincrono.protNFe.cStat;
    FcUF     := FNFeRetornoSincrono.cUF;
    FMsg     := FNFeRetornoSincrono.protNFe.xMotivo;
    FxMotivo := FNFeRetornoSincrono.protNFe.xMotivo;
    chNFe    := FNFeRetornoSincrono.ProtNFe.chNFe;

    // Verificar se a NF-e foi autorizada com sucesso
    Result := (FNFeRetornoSincrono.cStat = 104) and
              (NotaUtil.CstatProcessado(FNFeRetornoSincrono.protNFe.cStat));

    NomeArquivo := PathWithDelim(FConfiguracoes.Arquivos.PathSalvar) + chNFe;

    if Result then
    begin
      for I := 0 to TACBrNFe( FACBrNFe ).NotasFiscais.Count-1 do
      begin
        if OnlyNumber(chNFe) = OnlyNumber(TACBrNFe( FACBrNFe ).NotasFiscais.Items[I].NFe.infNFe.Id) then
        begin
          if (TACBrNFe( FACBrNFe ).Configuracoes.Geral.ValidarDigest ) and
             (TACBrNFe( FACBrNFe ).NotasFiscais.Items[I].NFe.signature.DigestValue <> FNFeRetornoSincrono.protNFe.digVal) and
             (FNFeRetornoSincrono.protNFe.digVal <> '') then
           begin
             raise EACBrNFeException.Create('DigestValue do documento '+
                                             OnlyNumber(TACBrNFe( FACBrNFe ).NotasFiscais.Items[I].NFe.infNFe.Id)+
                                             ' não confere.');
           end;
          TACBrNFe( FACBrNFe ).NotasFiscais.Items[I].Confirmada           := (FNFeRetornoSincrono.protNFe.cStat in [100, 150]);
          TACBrNFe( FACBrNFe ).NotasFiscais.Items[I].Msg                  := FNFeRetornoSincrono.protNFe.xMotivo;
          TACBrNFe( FACBrNFe ).NotasFiscais.Items[I].NFe.procNFe.tpAmb    := FNFeRetornoSincrono.tpAmb;
          TACBrNFe( FACBrNFe ).NotasFiscais.Items[I].NFe.procNFe.verAplic := FNFeRetornoSincrono.verAplic;
          TACBrNFe( FACBrNFe ).NotasFiscais.Items[I].NFe.procNFe.chNFe    := FNFeRetornoSincrono.ProtNFe.chNFe;
          TACBrNFe( FACBrNFe ).NotasFiscais.Items[I].NFe.procNFe.dhRecbto := FNFeRetornoSincrono.protNFe.dhRecbto;
          TACBrNFe( FACBrNFe ).NotasFiscais.Items[I].NFe.procNFe.nProt    := FNFeRetornoSincrono.ProtNFe.nProt;
          TACBrNFe( FACBrNFe ).NotasFiscais.Items[I].NFe.procNFe.digVal   := FNFeRetornoSincrono.protNFe.digVal;
          TACBrNFe( FACBrNFe ).NotasFiscais.Items[I].NFe.procNFe.cStat    := FNFeRetornoSincrono.protNFe.cStat;
          TACBrNFe( FACBrNFe ).NotasFiscais.Items[I].NFe.procNFe.xMotivo  := FNFeRetornoSincrono.protNFe.xMotivo;

          if (FileExists( NomeArquivo + '-nfe.xml')) or
            DFeUtil.NaoEstaVazio(TACBrNFe( FACBrNFe ).NotasFiscais.Items[I].NomeArq) then
          begin
            AProcNFe := TProcNFe.Create;
            try
              if DFeUtil.NaoEstaVazio(TACBrNFe( FACBrNFe ).NotasFiscais.Items[I].NomeArq) then
                AProcNFe.PathNFe := TACBrNFe( FACBrNFe ).NotasFiscais.Items[I].NomeArq
              else
                AProcNFe.PathNFe := NomeArquivo + '-nfe.xml';

              AProcNFe.PathRetConsSitNFe  := '';
              AProcNFe.PathRetConsReciNFe := '';
              AProcNFe.tpAmb              := FNFeRetornoSincrono.protNFe.tpAmb;
              AProcNFe.verAplic           := FNFeRetornoSincrono.protNFe.verAplic;
              AProcNFe.chNFe              := FNFeRetornoSincrono.protNFe.chNFe;
              AProcNFe.dhRecbto           := FNFeRetornoSincrono.protNFe.dhRecbto;
              AProcNFe.nProt              := FNFeRetornoSincrono.protNFe.nProt;
              AProcNFe.digVal             := FNFeRetornoSincrono.protNFe.digVal;
              AProcNFe.cStat              := FNFeRetornoSincrono.protNFe.cStat;
              AProcNFe.xMotivo            := FNFeRetornoSincrono.protNFe.xMotivo;

              ////AProcNFe.Versao := GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
              ////                                FConfiguracoes.Geral.VersaoDF,
              ////                                Layout);
              AProcNFe.GerarXML;

              if DFeUtil.NaoEstaVazio(AProcNFe.Gerador.ArquivoFormatoXML) then
                 AProcNFe.Gerador.SalvarArquivo(AProcNFe.PathNFe);
            finally
              AProcNFe.Free;
            end;
          end;

          if FConfiguracoes.Arquivos.Salvar then
          begin
            if FConfiguracoes.Arquivos.EmissaoPathNFe then
              Data := TACBrNFe( FACBrNFe ).NotasFiscais.Items[I].NFe.Ide.dEmi
            else
              Data := Now;

            if FConfiguracoes.Arquivos.SalvarApenasNFeProcessadas then
             begin
                if NotaUtil.CstatProcessado(TACBrNFe( FACBrNFe ).NotasFiscais.Items[I].NFe.procNFe.cStat) then
                   TACBrNFe( FACBrNFe ).NotasFiscais.Items[I].SaveToFile(PathWithDelim(
                       FConfiguracoes.Arquivos.GetPathNFe( Data,
                       TACBrNFe( FACBrNFe ).NotasFiscais.Items[I].NFe.Emit.CNPJCPF)) +
                       OnlyNumber(TACBrNFe( FACBrNFe ).NotasFiscais.Items[I].NFe.InfNFe.Id) + '-nfe.xml');
             end
            else
              TACBrNFe( FACBrNFe ).NotasFiscais.Items[I].SaveToFile(PathWithDelim(
                  FConfiguracoes.Arquivos.GetPathNFe( Data,
                  TACBrNFe( FACBrNFe ).NotasFiscais.Items[I].NFe.Emit.CNPJCPF)) +
                  OnlyNumber(TACBrNFe( FACBrNFe ).NotasFiscais.Items[I].NFe.InfNFe.Id) + '-nfe.xml');
          end;

          Break;
        end;
      end;
    end;
  end
  else
  begin
    FNFeRetorno := TretEnvNFe.Create;

    FNFeRetorno.Leitor.Arquivo := FRetWS;
    FNFeRetorno.LerXml;

    Fversao   := FNFeRetorno.versao;
    FTpAmb    := FNFeRetorno.TpAmb;
    FverAplic := FNFeRetorno.verAplic;
    FcStat    := FNFeRetorno.cStat;
    FxMotivo  := FNFeRetorno.xMotivo;
    FdhRecbto := FNFeRetorno.infRec.dhRecbto;
    FTMed     := FNFeRetorno.infRec.tMed;
    FcUF      := FNFeRetorno.cUF;
    FMsg      := FNFeRetorno.xMotivo;
    FRecibo   := FNFeRetorno.infRec.nRec;

    Result := (FNFeRetorno.CStat = 103);
  end;
end;

procedure TNFeRecepcao.FinalizarServico;
begin
  inherited FinalizarServico;

  if Assigned(FNFeRetornoSincrono) then
    FreeAndNil( FNFeRetornoSincrono );

  if Assigned(FNFeRetorno) then
    FreeAndNil( FNFeRetorno );
end;

function TNFeRecepcao.GerarMsgLog: String;
begin
  if Assigned(FNFeRetornoSincrono) then
    Result := 'Versão Layout : ' + FNFeRetornoSincrono.versao + LineBreak +
              'Ambiente : ' + TpAmbToStr(FNFeRetornoSincrono.TpAmb) + LineBreak +
              'Versão Aplicativo : ' + FNFeRetornoSincrono.verAplic + LineBreak +
              'Status Código : ' + IntToStr(FNFeRetornoSincrono.protNFe.cStat) + LineBreak +
              'Status Descrição : ' + FNFeRetornoSincrono.protNFe.xMotivo + LineBreak +
              'UF : ' + CodigoParaUF(FNFeRetornoSincrono.cUF) + LineBreak +
              'dhRecbto : ' + DateTimeToStr(FNFeRetornoSincrono.dhRecbto) + LineBreak +
              'chNFe : ' + FNFeRetornoSincrono.chNfe + LineBreak
  else if Assigned(FNFeRetorno) then
    Result := 'Versão Layout : ' + FNFeRetorno.versao + LineBreak +
              'Ambiente : ' + TpAmbToStr(FNFeRetorno.TpAmb) + LineBreak +
              'Versão Aplicativo : ' + FNFeRetorno.verAplic + LineBreak +
              'Status Código : ' + IntToStr(FNFeRetorno.cStat) + LineBreak +
              'Status Descrição : ' + FNFeRetorno.xMotivo + LineBreak +
              'UF : ' + CodigoParaUF(FNFeRetorno.cUF) + LineBreak +
              'Recibo : ' + FNFeRetorno.infRec.nRec + LineBreak +
              'Recebimento : ' + IfThen(FNFeRetorno.InfRec.dhRecbto = 0,'',DateTimeToStr(FNFeRetorno.InfRec.dhRecbto)) +
                                LineBreak +
              'Tempo Médio : ' + IntToStr(FNFeRetorno.InfRec.TMed) + LineBreak
  else
    Result := '';

end;

function TNFeRecepcao.GerarPrefixoArquivo: String;
begin
  if Assigned(FNFeRetornoSincrono) then  // Esta procesando nome do Retorno Sincrono ?
  begin
    if FRecibo <> '' then
    begin
      Result := Recibo;
      FArqResp := 'pro-rec';
    end
    else
    begin
      Result := Lote;
      FArqResp := 'pro-lot';
    end;
  end
  else
    Result := Lote;
end;

{ TNFeRetRecepcao }

constructor TNFeRetRecepcao.Create(AOwner : TComponent;
  ANotasFiscais: TNotasFiscais);
begin
  inherited Create(AOwner);

  FNotasFiscais := ANotasFiscais;
  FNFeRetorno   := TRetConsReciNFe.Create;

  FStatus  := stNFeRetRecepcao;
  FLayout  := LayNfeRetRecepcao;
  FArqEnv  := 'ped-rec';
  FArqResp := 'pro-rec';
end;

destructor TNFeRetRecepcao.Destroy;
begin
  FNFeRetorno.Free;

  inherited Destroy;
end;

function TNFeRetRecepcao.GetRecibo: String;
begin
  Result := Trim(FRecibo);
end;

function TNFeRetRecepcao.TratarRespostaFinal: Boolean;
var
  I, J : Integer;
  AProcNFe: TProcNFe;
  AInfProt: TProtNFeCollection;
  Data: TDateTime;
begin
  Result := False;

  AInfProt := FNFeRetorno.ProtNFe;

  if (AInfProt.Count > 0) then
  begin
    FMsg     := FNFeRetorno.ProtNFe.Items[0].xMotivo;
    FxMotivo := FNFeRetorno.ProtNFe.Items[0].xMotivo;
  end;

  //Setando os retornos das notas fiscais;
  for I := 0 to AInfProt.Count-1 do
  begin
    for J := 0 to FNotasFiscais.Count-1 do
    begin
      if OnlyNumber(AInfProt.Items[I].chNFe) = OnlyNumber(FNotasFiscais.Items[J].NFe.InfNFe.Id) then
      begin
        if (TACBrNFe( FACBrNFe ).Configuracoes.Geral.ValidarDigest ) and
           (FNotasFiscais.Items[J].NFe.signature.DigestValue <> AInfProt.Items[I].digVal) and
           (AInfProt.Items[I].digVal <> '') then
         begin
           raise EACBrNFeException.Create('DigestValue do documento '+
                                           OnlyNumber(FNotasFiscais.Items[J].NFe.infNFe.Id)+
                                           ' não confere.');
         end;
        FNotasFiscais.Items[J].Confirmada           := (AInfProt.Items[I].cStat in [100, 150]);
        FNotasFiscais.Items[J].Msg                  := AInfProt.Items[I].xMotivo;
        FNotasFiscais.Items[J].NFe.procNFe.tpAmb    := AInfProt.Items[I].tpAmb;
        FNotasFiscais.Items[J].NFe.procNFe.verAplic := AInfProt.Items[I].verAplic;
        FNotasFiscais.Items[J].NFe.procNFe.chNFe    := AInfProt.Items[I].chNFe;
        FNotasFiscais.Items[J].NFe.procNFe.dhRecbto := AInfProt.Items[I].dhRecbto;
        FNotasFiscais.Items[J].NFe.procNFe.nProt    := AInfProt.Items[I].nProt;
        FNotasFiscais.Items[J].NFe.procNFe.digVal   := AInfProt.Items[I].digVal;
        FNotasFiscais.Items[J].NFe.procNFe.cStat    := AInfProt.Items[I].cStat;
        FNotasFiscais.Items[J].NFe.procNFe.xMotivo  := AInfProt.Items[I].xMotivo;

        if FConfiguracoes.Arquivos.Salvar or DFeUtil.NaoEstaVazio(FNotasFiscais.Items[J].NomeArq) then
        begin
          if FileExists(PathWithDelim(FConfiguracoes.Arquivos.PathSalvar)+AInfProt.Items[I].chNFe + '-nfe.xml') and
             FileExists(PathWithDelim(FConfiguracoes.Arquivos.PathSalvar)+FNFeRetorno.nRec + '-pro-rec.xml') then
          begin
            AProcNFe := TProcNFe.Create;
            try
              AProcNFe.PathNFe := PathWithDelim(FConfiguracoes.Arquivos.PathSalvar)+AInfProt.Items[I].chNFe + '-nfe.xml';
              AProcNFe.PathRetConsReciNFe := PathWithDelim(FConfiguracoes.Arquivos.PathSalvar)+FNFeRetorno.nRec + '-pro-rec.xml';

              ////if FLayout = LayNfeRetAutorizacao then
              ////  AProcNFe.Versao := GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
              ////                                  FConfiguracoes.Geral.VersaoDF,
              ////                                  LayNfeAutorizacao)
              ////else
              ////  AProcNFe.Versao := GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
              ////                                  FConfiguracoes.Geral.VersaoDF,
              ////                                  LayNfeRecepcao);

              AProcNFe.GerarXML;

              if DFeUtil.NaoEstaVazio(AProcNFe.Gerador.ArquivoFormatoXML) then
              begin
                if DFeUtil.NaoEstaVazio(FNotasFiscais.Items[J].NomeArq) then
                  AProcNFe.Gerador.SalvarArquivo(FNotasFiscais.Items[J].NomeArq)
                else
                  AProcNFe.Gerador.SalvarArquivo(PathWithDelim(FConfiguracoes.Arquivos.PathSalvar)+AInfProt.Items[I].chNFe + '-nfe.xml');
              end;
            finally
              AProcNFe.Free;
            end;
          end;

//          if FConfiguracoes.Arquivos.Salvar then
//          begin
//            if FConfiguracoes.Arquivos.EmissaoPathNFe then
//              Data := FNotasFiscais.Items[J].NFe.Ide.dEmi
//            else
//              Data := Now;

//            FNotasFiscais.Items[J].SaveToFile(PathWithDelim(FConfiguracoes.Arquivos.GetPathNFe(Data,
//               FNotasFiscais.Items[J].NFe.Emit.CNPJCPF)) +
//               OnlyNumber(FNotasFiscais.Items[J].NFe.InfNFe.Id) + '-nfe.xml')
//          end;
        end;

        if FConfiguracoes.Arquivos.Salvar then
        begin
          if FConfiguracoes.Arquivos.EmissaoPathNFe then
            Data := FNotasFiscais.Items[J].NFe.Ide.dEmi
          else
            Data := Now;

            if FConfiguracoes.Arquivos.SalvarApenasNFeProcessadas then
             begin
                if NotaUtil.CstatProcessado(FNotasFiscais.Items[J].NFe.procNFe.cStat) then
                 FNotasFiscais.Items[J].SaveToFile(PathWithDelim(FConfiguracoes.Arquivos.GetPathNFe(Data,
                     FNotasFiscais.Items[J].NFe.Emit.CNPJCPF)) +
                     OnlyNumber(FNotasFiscais.Items[J].NFe.InfNFe.Id) + '-nfe.xml');

             end
            else
              FNotasFiscais.Items[J].SaveToFile(PathWithDelim(FConfiguracoes.Arquivos.GetPathNFe(Data,
                  FNotasFiscais.Items[J].NFe.Emit.CNPJCPF)) +
                  OnlyNumber(FNotasFiscais.Items[J].NFe.InfNFe.Id) + '-nfe.xml');
        end;

        break;
      end;
    end;
  end;

  //Verificando se existe alguma nota confirmada
  for I := 0 to FNotasFiscais.Count-1 do
  begin
    if FNotasFiscais.Items[I].Confirmada then
    begin
      Result := True;
      break;
    end;
  end;

  //Verificando se existe alguma nota nao confirmada
  for I := 0 to FNotasFiscais.Count-1 do
  begin
    if not FNotasFiscais.Items[I].Confirmada then
    begin
      FMsg := 'Nota(s) não confirmadas:' + LineBreak;
      break;
    end;
  end;

  //Montando a mensagem de retorno para as notas nao confirmadas
  for I := 0 to FNotasFiscais.Count-1 do
  begin
    if not FNotasFiscais.Items[I].Confirmada then
      FMsg:= FMsg + IntToStr(FNotasFiscais.Items[I].NFe.Ide.nNF) + '->' +
                    FNotasFiscais.Items[I].Msg + LineBreak;
  end;

  if AInfProt.Count > 0 then
  begin
     FChaveNFe  := AInfProt.Items[0].chNFe;
     FProtocolo := AInfProt.Items[0].nProt;
     FcStat     := AInfProt.Items[0].cStat;
  end;
end;

function TNFeRetRecepcao.Executar: Boolean;
var
  IntervaloTentativas, Tentativas: Integer;
begin
  Result := False;

  TACBrNFe( FACBrNFe ).SetStatus( stNfeRetRecepcao );
  try
    Sleep( FConfiguracoes.WebServices.AguardarConsultaRet );

    Tentativas := 0;
    IntervaloTentativas := FConfiguracoes.WebServices.IntervaloTentativas;

    while (inherited Executar) and
          (Tentativas < FConfiguracoes.WebServices.Tentativas) do
    begin
      Inc( Tentativas );

      if IntervaloTentativas > 0 then
        sleep( IntervaloTentativas )
      else
        Sleep( Tentativas * 1000 );
    end;
  finally
    TACBrNFe( FACBrNFe ).SetStatus( stIdle );
  end;

  if FNFeRetorno.CStat = 104 then  // Lote processado ?
    Result := TratarRespostaFinal;
end;

procedure TNFeRetRecepcao.DefinirURL;
begin
  if EhAutorizacao then
    FLayout := LayNfeRetAutorizacao
  else
    FLayout := LayNfeRetRecepcao;

  inherited DefinirURL;
end;

procedure TNFeRetRecepcao.DefinirServicoEAction;
begin
  if FLayout = LayNfeRetAutorizacao then
    FServico := CURL_WSDL + 'NfeRetAutorizacao'
  else
    FServico := CURL_WSDL + 'NfeRetRecepcao2';

  FSoapAction := FServico;
end;

procedure TNFeRetRecepcao.DefinirDadosMsg;
var
  ConsReciNFe: TConsReciNFe;
begin
  ConsReciNFe := TConsReciNFe.Create;
  try
    ConsReciNFe.tpAmb  := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo-1);
    ConsReciNFe.nRec   := FRecibo;
    ////ConsReciNFe.Versao := GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
    ////                                   FConfiguracoes.Geral.VersaoDF,
    ////                                   Layout);
    ConsReciNFe.GerarXML;

    FDadosMsg := ConsReciNFe.Gerador.ArquivoFormatoXML;
  finally
    ConsReciNFe.Free;
  end;
end;

function TNFeRetRecepcao.TratarResposta: Boolean;
begin
  if FLayout = LayNfeRetAutorizacao then
  begin
    FRetWS := SeparaDados( FRetornoWS, 'nfeRetAutorizacaoResult' );
    if FRetWS = '' then
      FRetWS := SeparaDados( FRetornoWS, 'nfeRetAutorizacaoLoteResult' );
  end
  else
    FRetWS := SeparaDados( FRetornoWS, 'nfeRetRecepcao2Result' );

  // Limpando variaveis internas
  FNFeRetorno.Free;
  FNFeRetorno := TRetConsReciNFe.Create;

  FNFeRetorno.Leitor.Arquivo := FRetWS;
  FNFeRetorno.LerXML;

  Fversao   := FNFeRetorno.versao;
  FTpAmb    := FNFeRetorno.TpAmb;
  FverAplic := FNFeRetorno.verAplic;
  FcStat    := FNFeRetorno.cStat;
  FcUF      := FNFeRetorno.cUF;
  FMsg      := FNFeRetorno.xMotivo;
  FxMotivo  := FNFeRetorno.xMotivo;
  FcMsg     := FNFeRetorno.cMsg;
  FxMsg     := FNFeRetorno.xMsg;

  Result := (FNFeRetorno.CStat = 105); // Lote em Processamento
end;

procedure TNFeRetRecepcao.FinalizarServico;
begin
  ////NotaUtil.ConfAmbiente;
  // Não libera para stIdle... não ainda...;
end;

function TNFeRetRecepcao.GerarMsgLog: String;
begin
  Result := 'Versão Layout : ' + FNFeRetorno.versao + LineBreak +
            'Ambiente : ' + TpAmbToStr(FNFeRetorno.tpAmb) + LineBreak +
            'Versão Aplicativo : ' + FNFeRetorno.verAplic + LineBreak +
            'Recibo : ' + FNFeRetorno.nRec + LineBreak +
            'Status Código : ' + IntToStr(FNFeRetorno.cStat) + LineBreak +
            'Status Descrição : ' + FNFeRetorno.xMotivo + LineBreak +
            'UF : ' + CodigoParaUF(FNFeRetorno.cUF) + LineBreak +
            'cMsg : ' + IntToStr(FNFeRetorno.cMsg) + LineBreak +
            'xMsg : ' + FNFeRetorno.xMsg + LineBreak;
end;

function TNFeRetRecepcao.GerarPrefixoArquivo: String;
begin
  Result := Recibo;
end;

{ TNFeRecibo }

constructor TNFeRecibo.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  FNFeRetorno := TRetConsReciNFe.Create;

  FStatus  := stNFeRecibo;
  FLayout  := LayNfeRetRecepcao;
  FArqEnv  := 'ped-rec';
  FArqResp := 'pro-rec';
end;

destructor TNFeRecibo.Destroy;
begin
  FNFeRetorno.Free;

  inherited Destroy;
end;

procedure TNFeRecibo.DefinirServicoEAction;
begin
  if FLayout = LayNfeRetAutorizacao then
    FServico := CURL_WSDL + 'NfeRetAutorizacao'
  else
    FServico := CURL_WSDL + 'NfeRetRecepcao2';

  FSoapAction := FServico;
end;

procedure TNFeRecibo.DefinirURL;
begin
  if EhAutorizacao then
    FLayout := LayNfeRetAutorizacao
  else
    FLayout := LayNfeRetRecepcao;

  inherited DefinirURL;
end;

procedure TNFeRecibo.DefinirDadosMsg;
var
  ConsReciNFe: TConsReciNFe;
begin
  ConsReciNFe := TConsReciNFe.Create;
  try
    ConsReciNFe.tpAmb  := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo-1);
    ConsReciNFe.nRec   := FRecibo;
    ////ConsReciNFe.Versao := GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
    ////                                   FConfiguracoes.Geral.VersaoDF,
    ////                                   FLayout);
    ConsReciNFe.GerarXML;

    FDadosMsg := ConsReciNFe.Gerador.ArquivoFormatoXML;
  finally
    ConsReciNFe.Free;
  end;
end;

function TNFeRecibo.TratarResposta: Boolean;
begin
  if FLayout = LayNfeRetAutorizacao then
  begin
    FRetWS := SeparaDados( FRetornoWS, 'nfeRetAutorizacaoResult' );
    if FRetWS = '' then
      FRetWS := SeparaDados( FRetornoWS, 'nfeRetAutorizacaoLoteResult' );
  end
  else
     FRetWS := SeparaDados( FRetornoWS, 'nfeRetRecepcao2Result' );

  // Limpando variaveis internas
  FNFeRetorno.Free;
  FNFeRetorno := TRetConsReciNFe.Create;

  FNFeRetorno.Leitor.Arquivo := FRetWS;
  FNFeRetorno.LerXML;

  Fversao   := FNFeRetorno.versao;
  FTpAmb    := FNFeRetorno.TpAmb;
  FverAplic := FNFeRetorno.verAplic;
  FcStat    := FNFeRetorno.cStat;
  FxMotivo  := FNFeRetorno.xMotivo;
  FcUF      := FNFeRetorno.cUF;
  FxMsg     := FNFeRetorno.xMsg;
  FcMsg     := FNFeRetorno.cMsg;
  FMsg      := FxMotivo;

  Result := (FNFeRetorno.CStat = 104);
end;

function TNFeRecibo.GerarMsgLog: String;
begin
  Result := 'Versão Layout : ' + FNFeRetorno.versao + LineBreak +
            'Ambiente : ' + TpAmbToStr(FNFeRetorno.TpAmb) + LineBreak +
            'Versão Aplicativo : ' + FNFeRetorno.verAplic + LineBreak +
            'Recibo : ' + FNFeRetorno.nRec + LineBreak +
            'Status Código : ' + IntToStr(FNFeRetorno.cStat) + LineBreak +
            'Status Descrição : ' + FNFeRetorno.ProtNFe.Items[0].xMotivo + LineBreak +
            'UF : ' + CodigoParaUF(FNFeRetorno.cUF) + LineBreak;
end;

{ TNFeConsulta }

constructor TNFeConsulta.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FprotNFe       := TProcNFe.Create;
  FretCancNFe    := TRetCancNFe.Create;
  FprocEventoNFe := TRetEventoNFeCollection.Create(AOwner);

  FStatus  := stNfeConsulta;
  FLayout  := LayNfeConsulta;
  FArqEnv  := 'ped-sit';
  FArqResp := 'sit';
end;

destructor TNFeConsulta.Destroy;
begin
  FprotNFe.Free;
  FretCancNFe.Free;
  if Assigned(FprocEventoNFe) then
    FprocEventoNFe.Free;

  Inherited Destroy;
end;

procedure TNFeConsulta.DefinirServicoEAction;
begin
  if (FConfiguracoes.Geral.VersaoDF = ve310) and
     (FConfiguracoes.WebServices.UFCodigo in [29, 41]) then // 29 = BA, 41 = PR
    FServico := CURL_WSDL + 'NfeConsulta'
  else
    FServico := CURL_WSDL + 'NfeConsulta2';

  FSoapAction := FServico;
end;

procedure TNFeConsulta.DefinirDadosMsg;
var
  ConsSitNFe: TConsSitNFe;
  OK: Boolean;
begin
  OK := False;
  ConsSitNFe := TConsSitNFe.Create;
  try
    ConsSitNFe.TpAmb := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo-1);
    ConsSitNFe.chNFe := FNFeChave;

    ////FConfiguracoes.Geral.ModeloDF := StrToModeloDF(OK, NotaUtil.ExtraiModeloChaveAcesso(ConsSitNFe.chNFe));

    ////ConsSitNFe.Versao := GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
    ////                                  FConfiguracoes.Geral.VersaoDF,
    ////                                  LayNfeConsulta);
    ConsSitNFe.GerarXML;

    FDadosMsg := ConsSitNFe.Gerador.ArquivoFormatoXML;
  finally
    ConsSitNFe.Free;
  end;
end;

function TNFeConsulta.TratarResposta: Boolean;
var
  NFeRetorno: TRetConsSitNFe;
  NFCancelada, Atualiza: Boolean;
  aEventos, aMsg, NomeArquivo: String;
  AProcNFe: TProcNFe;
  I, J: Integer;
  Data: TDateTime;
begin
  NFeRetorno := TRetConsSitNFe.Create;

  try
    FRetWS := SeparaDados(FRetornoWS, 'NfeConsultaNF2Result');
    if FRetWS = '' then
      FRetWS := SeparaDados(FRetornoWS, 'NfeConsultaNFResult');

    NFeRetorno.Leitor.Arquivo := FRetWS;
    NFeRetorno.LerXML;

    NFCancelada := False;
    aEventos    := '';

    // <retConsSitNFe> - Retorno da consulta da situação da NF-e
    // Este é o status oficial da NF-e
    Fversao   := NFeRetorno.versao;
    FTpAmb    := NFeRetorno.tpAmb;
    FverAplic := NFeRetorno.verAplic;
    FcStat    := NFeRetorno.cStat;
    FXMotivo  := NFeRetorno.xMotivo;
    FcUF      := NFeRetorno.cUF;
    FNFeChave := NFeRetorno.chNfe;
    FMsg      := FXMotivo;

    // Verifica se a nota fiscal está cancelada pelo método antigo. Se estiver,
    // então NFCancelada será True e já atribui Protocolo, Data e Mensagem
    if NFeRetorno.retCancNFe.cStat > 0 then
    begin
      FRetCancNFe.versao   := NFeRetorno.retCancNFe.versao;
      FretCancNFe.tpAmb    := NFeRetorno.retCancNFe.tpAmb;
      FretCancNFe.verAplic := NFeRetorno.retCancNFe.verAplic;
      FretCancNFe.cStat    := NFeRetorno.retCancNFe.cStat;
      FretCancNFe.xMotivo  := NFeRetorno.retCancNFe.xMotivo;
      FretCancNFe.cUF      := NFeRetorno.retCancNFe.cUF;
      FretCancNFe.chNFE    := NFeRetorno.retCancNFe.chNFE;
      FretCancNFe.dhRecbto := NFeRetorno.retCancNFe.dhRecbto;
      FretCancNFe.nProt    := NFeRetorno.retCancNFe.nProt;

      NFCancelada := True;
      FProtocolo  := NFeRetorno.retCancNFe.nProt;
      FDhRecbto   := NFeRetorno.retCancNFe.dhRecbto;
      FMsg        := NFeRetorno.xMotivo;
    end;

    // <protNFe> - Retorno dos dados do ENVIO da NF-e
    // Considerá-los apenas se não existir nenhum evento de cancelamento (110111)
    FprotNFe.PathNFe            := NFeRetorno.protNFe.PathNFe;
    FprotNFe.PathRetConsReciNFe := NFeRetorno.protNFe.PathRetConsReciNFe;
    FprotNFe.PathRetConsSitNFe  := NFeRetorno.protNFe.PathRetConsSitNFe;
    FprotNFe.PathRetConsSitNFe  := NFeRetorno.protNFe.PathRetConsSitNFe;
    FprotNFe.tpAmb              := NFeRetorno.protNFe.tpAmb;
    FprotNFe.verAplic           := NFeRetorno.protNFe.verAplic;
    FprotNFe.chNFe              := NFeRetorno.protNFe.chNFe;
    FprotNFe.dhRecbto           := NFeRetorno.protNFe.dhRecbto;
    FprotNFe.nProt              := NFeRetorno.protNFe.nProt;
    FprotNFe.digVal             := NFeRetorno.protNFe.digVal;
    FprotNFe.cStat              := NFeRetorno.protNFe.cStat;
    FprotNFe.xMotivo            := NFeRetorno.protNFe.xMotivo;

    if Assigned(NFeRetorno.procEventoNFe) and (NFeRetorno.procEventoNFe.Count > 0) then
    begin
      aEventos := '=====================================================' +
                  LineBreak +
                  '================== Eventos da NF-e ==================' +
                  LineBreak +
                  '====================================================='+
                  LineBreak + '' + LineBreak +
                  'Quantidade total de eventos: ' +
                  IntToStr(NFeRetorno.procEventoNFe.Count);

      FprocEventoNFe.Clear;
      for I := 0 to NFeRetorno.procEventoNFe.Count-1 do
      begin
        FprocEventoNFe.Add;
        FprocEventoNFe.Items[I].RetEventoNFe.idLote   := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.idLote;
        FprocEventoNFe.Items[I].RetEventoNFe.tpAmb    := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.tpAmb;
        FprocEventoNFe.Items[I].RetEventoNFe.verAplic := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.verAplic;
        FprocEventoNFe.Items[I].RetEventoNFe.cOrgao   := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.cOrgao;
        FprocEventoNFe.Items[I].RetEventoNFe.cStat    := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.cStat;
        FprocEventoNFe.Items[I].RetEventoNFe.xMotivo  := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.xMotivo;
        FprocEventoNFe.Items[I].RetEventoNFe.XML      := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.XML;

        FprocEventoNFe.Items[I].RetEventoNFe.InfEvento.ID := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.InfEvento.ID;
        FprocEventoNFe.Items[I].RetEventoNFe.InfEvento.tpAmb := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.InfEvento.tpAmb;
        FprocEventoNFe.Items[I].RetEventoNFe.InfEvento.CNPJ := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.InfEvento.CNPJ;
        FprocEventoNFe.Items[I].RetEventoNFe.InfEvento.chNFe := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.InfEvento.chNFe;
        FprocEventoNFe.Items[I].RetEventoNFe.InfEvento.dhEvento := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.InfEvento.dhEvento;
        FprocEventoNFe.Items[I].RetEventoNFe.InfEvento.TpEvento := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.InfEvento.TpEvento;
        FprocEventoNFe.Items[I].RetEventoNFe.InfEvento.nSeqEvento := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.InfEvento.nSeqEvento;
        FprocEventoNFe.Items[I].RetEventoNFe.InfEvento.VersaoEvento := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.InfEvento.VersaoEvento;
        FprocEventoNFe.Items[I].RetEventoNFe.InfEvento.DetEvento.xCorrecao := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.InfEvento.DetEvento.xCorrecao;
        FprocEventoNFe.Items[I].RetEventoNFe.InfEvento.DetEvento.xCondUso := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.InfEvento.DetEvento.xCondUso;
        FprocEventoNFe.Items[I].RetEventoNFe.InfEvento.DetEvento.nProt := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.InfEvento.DetEvento.nProt;
        FprocEventoNFe.Items[I].RetEventoNFe.InfEvento.DetEvento.xJust := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.InfEvento.DetEvento.xJust;

        FprocEventoNFe.Items[I].RetEventoNFe.retEvento.Clear;
        for J := 0 to NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.retEvento.Count-1 do
        begin
          FprocEventoNFe.Items[I].RetEventoNFe.retEvento.Add;
          FprocEventoNFe.Items[I].RetEventoNFe.retEvento.Items[J].RetInfEvento.Id := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.retEvento.Items[J].RetInfEvento.Id;
          FprocEventoNFe.Items[I].RetEventoNFe.retEvento.Items[J].RetInfEvento.tpAmb := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.retEvento.Items[J].RetInfEvento.tpAmb;
          FprocEventoNFe.Items[I].RetEventoNFe.retEvento.Items[J].RetInfEvento.verAplic := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.retEvento.Items[J].RetInfEvento.verAplic;
          FprocEventoNFe.Items[I].RetEventoNFe.retEvento.Items[J].RetInfEvento.cOrgao := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.retEvento.Items[J].RetInfEvento.cOrgao;
          FprocEventoNFe.Items[I].RetEventoNFe.retEvento.Items[J].RetInfEvento.cStat := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.retEvento.Items[J].RetInfEvento.cStat;
          FprocEventoNFe.Items[I].RetEventoNFe.retEvento.Items[J].RetInfEvento.xMotivo := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.retEvento.Items[J].RetInfEvento.xMotivo;
          FprocEventoNFe.Items[I].RetEventoNFe.retEvento.Items[J].RetInfEvento.chNFe := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.retEvento.Items[J].RetInfEvento.chNFe;
          FprocEventoNFe.Items[I].RetEventoNFe.retEvento.Items[J].RetInfEvento.tpEvento := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.retEvento.Items[J].RetInfEvento.tpEvento;
          FprocEventoNFe.Items[I].RetEventoNFe.retEvento.Items[J].RetInfEvento.xEvento := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.retEvento.Items[J].RetInfEvento.xEvento;
          FprocEventoNFe.Items[I].RetEventoNFe.retEvento.Items[J].RetInfEvento.nSeqEvento := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.retEvento.Items[J].RetInfEvento.nSeqEvento;
          FprocEventoNFe.Items[I].RetEventoNFe.retEvento.Items[J].RetInfEvento.CNPJDest := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.retEvento.Items[J].RetInfEvento.CNPJDest;
          FprocEventoNFe.Items[I].RetEventoNFe.retEvento.Items[J].RetInfEvento.emailDest := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.retEvento.Items[J].RetInfEvento.emailDest;
          FprocEventoNFe.Items[I].RetEventoNFe.retEvento.Items[J].RetInfEvento.dhRegEvento := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.retEvento.Items[J].RetInfEvento.dhRegEvento;
          FprocEventoNFe.Items[I].RetEventoNFe.retEvento.Items[J].RetInfEvento.nProt := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.retEvento.Items[J].RetInfEvento.nProt;
          FprocEventoNFe.Items[I].RetEventoNFe.retEvento.Items[J].RetInfEvento.XML := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.retEvento.Items[J].RetInfEvento.XML;

          aEventos := aEventos + LineBreak + LineBreak +
                      'Número de sequência: ' + IntToStr(NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.InfEvento.nSeqEvento) + LineBreak +
                      'Código do evento: ' + TpEventoToStr(NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.InfEvento.TpEvento) + LineBreak +
                      'Descrição do evento: ' + ACBrStrToAnsi(NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.InfEvento.DescEvento) + LineBreak +
                      'Status do evento: ' + IntToStr(NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.retEvento.Items[J].RetInfEvento.cStat) + LineBreak +
                      'Descrição do status: ' + ACBrStrToAnsi(NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.retEvento.Items[J].RetInfEvento.xMotivo) + LineBreak +
                      'Protocolo: ' + NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.retEvento.Items[J].RetInfEvento.nProt + LineBreak +
                      'Data / hora do registro: ' + DateTimeToStr(NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.retEvento.Items[J].RetInfEvento.dhRegEvento);

          if NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.retEvento.Items[J].RetInfEvento.tpEvento = teCancelamento then
          begin
            NFCancelada := True;
            FProtocolo  := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.retEvento.Items[J].RetInfEvento.nProt;
            FDhRecbto   := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.retEvento.Items[J].RetInfEvento.dhRegEvento;
            FMsg        := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.retEvento.Items[J].RetInfEvento.xMotivo;
          end;
        end;
      end;
    end;

    if not NFCancelada then
    begin
      FProtocolo := NFeRetorno.protNFe.nProt;
      FDhRecbto  := NFeRetorno.protNFe.dhRecbto;
      FMsg       := NFeRetorno.protNFe.xMotivo;
    end;

    aMsg := GerarMsgLog;
    if aEventos <> '' then
      aMsg := aMsg + sLineBreak + aEventos;

    Result := (NFeRetorno.CStat in [100, 101, 110, 150, 151, 155]);

    NomeArquivo := PathWithDelim(FConfiguracoes.Arquivos.PathSalvar) + FNFeChave;

    for i:= 0 to TACBrNFe( FACBrNFe ).NotasFiscais.Count-1 do
    begin
      if (OnlyNumber(FNFeChave) = OnlyNumber(TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.infNFe.Id)) then
      begin
        Atualiza := True;
        if ((NFeRetorno.CStat in [101, 151, 155]) and
           (not FConfiguracoes.Geral.AtualizarXMLCancelado)) then
          Atualiza := False;

        TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].Confirmada := (NFeRetorno.cStat in [100, 150]);
        if Atualiza then
        begin
          if (TACBrNFe( FACBrNFe ).Configuracoes.Geral.ValidarDigest ) and
             (TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.signature.DigestValue <> NFeRetorno.protNFe.digVal) and
             (NFeRetorno.protNFe.digVal <> '') then
           begin
             raise EACBrNFeException.Create('DigestValue do documento '+
                                             OnlyNumber(TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.infNFe.Id)+
                                             ' não confere.');
           end;
          TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].Msg                  := NFeRetorno.xMotivo;
          TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.procNFe.tpAmb    := NFeRetorno.tpAmb;
          TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.procNFe.verAplic := NFeRetorno.verAplic;
          TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.procNFe.chNFe    := NFeRetorno.chNfe;
          TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.procNFe.dhRecbto := FDhRecbto;
          TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.procNFe.nProt    := FProtocolo;
          TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.procNFe.digVal   := NFeRetorno.protNFe.digVal;
          TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.procNFe.cStat    := NFeRetorno.cStat;
          TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.procNFe.xMotivo  := NFeRetorno.xMotivo;

          if FileExists(NomeArquivo + '-nfe.xml') or
            DFeUtil.NaoEstaVazio(TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NomeArq) then
          begin
            AProcNFe := TProcNFe.Create;
            try
              if DFeUtil.NaoEstaVazio(TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NomeArq) then
                AProcNFe.PathNFe := TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NomeArq
              else
                AProcNFe.PathNFe := NomeArquivo + '-nfe.xml';

              AProcNFe.PathRetConsSitNFe := NomeArquivo + '-sit.xml';

              ////if FConfiguracoes.Geral.VersaoDF = ve310 then
              ////  AProcNFe.Versao := GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
              ////                                  FConfiguracoes.Geral.VersaoDF,
              ////                                  LayNfeAutorizacao)
              ////else
              ////  AProcNFe.Versao := GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
              ////                                  FConfiguracoes.Geral.VersaoDF,
              ////                                  LayNfeRecepcao);
              AProcNFe.GerarXML;

              if DFeUtil.NaoEstaVazio(AProcNFe.Gerador.ArquivoFormatoXML) then
                AProcNFe.Gerador.SalvarArquivo(AProcNFe.PathNFe);

            finally
              AProcNFe.Free;
            end;
          end;

          if FConfiguracoes.Arquivos.Salvar then
          begin
            if FConfiguracoes.Arquivos.EmissaoPathNFe then
              Data := TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.Ide.dEmi
            else
              Data := Now;

            if FConfiguracoes.Arquivos.SalvarApenasNFeProcessadas then
             begin
                if NotaUtil.CstatProcessado(TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.procNFe.cStat) then
                  TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].SaveToFile(
                      PathWithDelim(FConfiguracoes.Arquivos.GetPathNFe(Data,
                      TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.Emit.CNPJCPF)) +
                      OnlyNumber(TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.InfNFe.Id) + '-nfe.xml')

             end
            else
               TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].SaveToFile(
                   PathWithDelim(FConfiguracoes.Arquivos.GetPathNFe(Data,
                   TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.Emit.CNPJCPF)) +
                   OnlyNumber(TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.InfNFe.Id) + '-nfe.xml')
          end;
        end;

        break;
      end;
    end;

    if (TACBrNFe( FACBrNFe ).NotasFiscais.Count <= 0) then
    begin
      if FConfiguracoes.Arquivos.Salvar then
      begin
        if FileExists(NomeArquivo + '-nfe.xml') then
        begin
          AProcNFe := TProcNFe.Create;
          try
            AProcNFe.PathNFe := NomeArquivo + '-nfe.xml';
            AProcNFe.PathRetConsSitNFe := NomeArquivo + '-sit.xml';

            ////if FConfiguracoes.Geral.VersaoDF = ve310 then
            ////  AProcNFe.Versao := GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
            ////                                  FConfiguracoes.Geral.VersaoDF,
            ////                                  LayNfeAutorizacao)
            ////else
            ////  AProcNFe.Versao := GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
            ////                                  FConfiguracoes.Geral.VersaoDF,
            ////                                  LayNfeRecepcao);

            AProcNFe.GerarXML;

            if DFeUtil.NaoEstaVazio(AProcNFe.Gerador.ArquivoFormatoXML) then
              AProcNFe.Gerador.SalvarArquivo(AProcNFe.PathNFe);
          finally
            AProcNFe.Free;
          end;
        end;
      end;
    end;
  finally
    NFeRetorno.Free;
  end;
end;

function TNFeConsulta.GerarMsgLog: String;
begin
  Result := 'Versão Layout : '     + Fversao + LineBreak +
            'Identificador : '     + FNFeChave + LineBreak +
            'Ambiente : '          + TpAmbToStr(FTpAmb) + LineBreak +
            'Versão Aplicativo : ' + FverAplic + LineBreak+
            'Status Código : '     + IntToStr(FcStat) + LineBreak+
            'Status Descrição : '  + FXMotivo + LineBreak +
            'UF : '                + CodigoParaUF(FcUF) + LineBreak +
            'Chave Acesso : '      + FNFeChave + LineBreak +
            'Recebimento : '       + DateTimeToStr(FDhRecbto) + LineBreak +
            'Protocolo : '         + FProtocolo + LineBreak +
            'Digest Value : '      + FprotNFe.digVal + LineBreak;

end;

function TNFeConsulta.GerarPrefixoArquivo: String;
begin
  Result := Trim( FNFeChave );
end;

{ TNFeInutilizacao }

constructor TNFeInutilizacao.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FStatus  := stNFeInutilizacao;
  FLayout  := LayNfeInutilizacao;
  FArqEnv  := 'ped-inu';
  FArqResp := 'inu';
end;

procedure TNFeInutilizacao.SetJustificativa(AValue: WideString);
begin
  if DFeUtil.EstaVazio(AValue) then
    GerarException('Informar uma Justificativa para Inutilização de ' +
                   'numeração da Nota Fiscal Eletronica')
  else
    ////AValue := DFeUtil.TrataString(AValue);

  if Length(Trim(AValue)) < 15 then
    GerarException('A Justificativa para Inutilização de numeração da ' +
                   'Nota Fiscal Eletronica deve ter no minimo 15 caracteres')
  else
    FJustificativa := Trim(AValue);
end;

function TNFeInutilizacao.GerarPathPorCNPJ(): String;
var
  CNPJ: String;
begin
  if FConfiguracoes.Arquivos.SepararPorCNPJ then
    CNPJ := FCNPJ
  else
    CNPJ := '';

  Result := FConfiguracoes.Arquivos.GetPathInu( CNPJ );
end;

procedure TNFeInutilizacao.DefinirServicoEAction;
begin
  if (FConfiguracoes.Geral.VersaoDF = ve310) and
     (FConfiguracoes.WebServices.UFCodigo in [29]) then // 29 = BA
  begin
    FServico    := CURL_WSDL + 'NfeInutilizacao';
    FSoapAction := FServico + '/NfeInutilizacao';
  end
  else
  begin
    FServico    := CURL_WSDL + 'NfeInutilizacao2';
    FSoapAction := FServico;
  end;

//  FServico    := CURL_WSDL + 'NfeInutilizacao2';
//  FSoapAction := FServico;
end;

procedure TNFeInutilizacao.DefinirDadosMsg;
var
  InutNFe: TinutNFe;
  OK: boolean;
begin
  OK      := False;
  InutNFe := TinutNFe.Create;
  try
    InutNFe.tpAmb  := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo-1);
    InutNFe.cUF    := FConfiguracoes.WebServices.UFCodigo;
    InutNFe.ano    := FAno;
    InutNFe.CNPJ   := FCNPJ;
    InutNFe.modelo := FModelo;
    InutNFe.serie  := FSerie;
    InutNFe.nNFIni := FNumeroInicial;
    InutNFe.nNFFin := FNumeroFinal;
    InutNFe.xJust  := FJustificativa;

    FConfiguracoes.Geral.ModeloDF := StrToModeloDF(OK, IntToStr(InutNFe.modelo));

    ////InutNFe.Versao := GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
    ////                               FConfiguracoes.Geral.VersaoDF,
    ////                               LayNfeInutilizacao);
    InutNFe.GerarXML;

    ////AssinarXML( InutNFe.Gerador.ArquivoFormatoXML,
    ////            'Falha ao assinar Inutilização Nota Fiscal Eletrônica ' +
    ////            LineBreak + FMsg );

    FID := InutNFe.ID;
  finally
    InutNFe.Free;
  end;
end;

procedure TNFeInutilizacao.SalvarEnvio;
var
  aPath: String;
begin
  inherited SalvarEnvio;

  if FConfiguracoes.Arquivos.Salvar then
  begin
    aPath := GerarPathPorCNPJ;
    ////FConfiguracoes.Geral.Save(GerarPrefixoArquivo + '-' + ArqEnv + '.xml',
    ////                          FDadosMsg, aPath);
  end;
end;

procedure TNFeInutilizacao.SalvarResposta;
var
  aPath: String;
begin
  inherited SalvarResposta;

  if FConfiguracoes.Arquivos.Salvar then
  begin
    aPath := GerarPathPorCNPJ;
    ////FConfiguracoes.Geral.Save(GerarPrefixoArquivo + '-' + ArqResp + '.xml',
    ////                          FRetWS, aPath);
  end;
end;

function TNFeInutilizacao.TratarResposta: Boolean;
var
  NFeRetorno: TRetInutNFe;
  wProc: TStringList;
begin
  NFeRetorno := TRetInutNFe.Create;
  try
    FRetWS := SeparaDados(FRetornoWS, 'nfeInutilizacaoNF2Result');
    if FRetWS = '' then
      FRetWS := SeparaDados(FRetornoWS, 'nfeInutilizacaoNFResult');

    NFeRetorno.Leitor.Arquivo := FRetWS;
    NFeRetorno.LerXml;

    Fversao    := NFeRetorno.versao;
    FTpAmb     := NFeRetorno.TpAmb;
    FverAplic  := NFeRetorno.verAplic;
    FcStat     := NFeRetorno.cStat;
    FxMotivo   := NFeRetorno.xMotivo;
    FcUF       := NFeRetorno.cUF;
    FdhRecbto  := NFeRetorno.dhRecbto;
    Fprotocolo := NFeRetorno.nProt;
    FMsg       := NFeRetorno.XMotivo;

    Result := (NFeRetorno.cStat = 102);

    //gerar arquivo proc de inutilizacao
    if ((NFeRetorno.cStat = 102) or (NFeRetorno.cStat = 563)) then
    begin
      wProc := TStringList.Create;
      try
        wProc.Add('<'+ENCODING_UTF8+'>');
        ////wProc.Add('<ProcInutNFe versao="' + GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
        ////                                                 FConfiguracoes.Geral.VersaoDF,
        ////                                                 LayNfeInutilizacao) +
        ////                         '" xmlns="http://www.portalfiscal.inf.br/nfe">');

        wProc.Add(FDadosMSG);
        wProc.Add(FRetWS);
        wProc.Add('</ProcInutNFe>');
        FXML_ProcInutNFe := wProc.Text;
      finally
        wProc.Free;
      end;

      ////if FConfiguracoes.Geral.Salvar then
      ////  FConfiguracoes.Geral.Save( GerarPrefixoArquivo + '-procInutNFe.xml',
      ////                             FXML_ProcInutNFe );
      ////
      ////if FConfiguracoes.Arquivos.Salvar then
      ////  FConfiguracoes.Geral.Save( GerarPrefixoArquivo + '-procInutNFe.xml',
      ////                             FXML_ProcInutNFe, GerarPathPorCNPJ );
    end;
  finally
    NFeRetorno.Free;
  end;
end;

function TNFeInutilizacao.GerarMsgLog: String;
begin
  Result := 'Versão Layout : ' + Fversao + LineBreak +
            'Ambiente : ' + TpAmbToStr(FTpAmb) + LineBreak +
            'Versão Aplicativo : ' + FverAplic + LineBreak +
            'Status Código : ' + IntToStr(FcStat) + LineBreak +
            'Status Descrição : ' + FxMotivo + LineBreak +
            'UF : ' + CodigoParaUF(FcUF) + LineBreak +
            'Recebimento : ' + IfThen(FdhRecbto = 0,
                                               '',
                                               DateTimeToStr(FdhRecbto));
end;

function TNFeInutilizacao.GerarPrefixoArquivo: String;
begin
  Result := Trim(OnlyNumber(FID));
end;

{ TNFeConsultaCadastro }

constructor TNFeConsultaCadastro.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FRetConsCad := TRetConsCad.Create;

  FStatus  := stNFeCadastro;
  FLayout  := LayNfeCadastro;
  FArqEnv  := 'ped-cad';
  FArqResp := 'cad';
end;

destructor TNFeConsultaCadastro.Destroy;
begin
  FRetConsCad.Free;

  inherited Destroy;
end;

procedure TNFeConsultaCadastro.SetCNPJ(const Value: String);
begin
  if DFeUtil.NaoEstaVazio(Value) then
  begin
    FIE  := '';
    FCPF := '';
  end;

  FCNPJ := Value;
end;

procedure TNFeConsultaCadastro.SetCPF(const Value: String);
begin
  if DFeUtil.NaoEstaVazio(Value) then
  begin
    FIE   := '';
    FCNPJ := '';
  end;

  FCPF := Value;
end;

procedure TNFeConsultaCadastro.SetIE(const Value: String);
begin
  if DFeUtil.NaoEstaVazio(Value) then
  begin
    FCNPJ := '';
    FCPF  := '';
  end;

  FIE := Value;
end;

procedure TNFeConsultaCadastro.DefinirURL;
begin
  inherited DefinirURL;

  FURL := NotaUtil.GetURL( UFparaCodigo(FUF),
                           FConfiguracoes.WebServices.AmbienteCodigo,
                           FConfiguracoes.Geral.FormaEmissaoCodigo,
                           LayNfeCadastro,
                           FConfiguracoes.Geral.ModeloDF,
                           FConfiguracoes.Geral.VersaoDF );
end;

procedure TNFeConsultaCadastro.DefinirServicoEAction;
begin
  FServico    := CURL_WSDL + 'CadConsultaCadastro2';
  FSoapAction := FServico;
end;

procedure TNFeConsultaCadastro.DefinirDadosMsg;
var
  ConCadNFe: TConsCad;
begin
  ConCadNFe := TConsCad.Create;
  try
    ConCadNFe.UF     := FUF;
    ConCadNFe.IE     := FIE;
    ConCadNFe.CNPJ   := FCNPJ;
    ConCadNFe.CPF    := FCPF;
    ////ConCadNFe.Versao := GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
    ////                                 FConfiguracoes.Geral.VersaoDF,
    ////                                 LayNfeCadastro);
    ConCadNFe.GerarXML;

    FDadosMsg := ConCadNFe.Gerador.ArquivoFormatoXML;
  finally
    ConCadNFe.Free;
  end;
end;

function TNFeConsultaCadastro.TratarResposta: Boolean;
begin
  FRetWS := SeparaDados( FRetornoWS, 'consultaCadastro2Result' );

  // Limpando variaveis internas
  FRetConsCad.Free;
  FRetConsCad := TRetConsCad.Create;

  FRetConsCad.Leitor.Arquivo := FRetWS;
  FRetConsCad.LerXml;

  Fversao   := FRetConsCad.versao;
  FverAplic := FRetConsCad.verAplic;
  FcStat    := FRetConsCad.cStat;
  FxMotivo  := FRetConsCad.xMotivo;
  FdhCons   := FRetConsCad.dhCons;
  FcUF      := FRetConsCad.cUF;
  FMsg      := FRetConsCad.XMotivo;

  Result := (FRetConsCad.cStat in [111, 112]);
end;

function TNFeConsultaCadastro.GerarMsgLog: String;
begin
  Result := 'Versão Layout : ' + FRetConsCad.versao + LineBreak +
            'Versão Aplicativo : ' + FRetConsCad.verAplic + LineBreak +
            'Status Código : ' + IntToStr(FRetConsCad.cStat) + LineBreak +
            'Status Descrição : ' + FRetConsCad.xMotivo + LineBreak +
            'UF : ' + CodigoParaUF(FRetConsCad.cUF) + LineBreak +
            'Consulta : ' + DateTimeToStr(FRetConsCad.dhCons);
end;

function TNFeConsultaCadastro.GerarUFSoap: String;
begin
  Result := '<cUF>' + IntToStr(UFparaCodigo(FUF)) + '</cUF>';
end;

{ TNFeEnvDPEC }

constructor TNFeEnvDPEC.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FStatus  := stNFeEnvDPEC;
  FLayout  := LayNfeEnvDPEC;
  FArqEnv  := 'env-dpec';
  FArqResp := 'ret-dpec';
end;

procedure TNFeEnvDPEC.DefinirServicoEAction;
begin
  FServico    := CURL_WSDL + 'SCERecepcaoRFB';
  FSoapAction := FServico + '/sceRecepcaoDPEC';
end;

procedure TNFeEnvDPEC.DefinirDadosMsg;
var
  EnvDPEC: TEnvDPEC;
  I : Integer;
begin
  EnvDPEC := TEnvDPEC.Create;
  try
    //Gera NFe pra pegar a Chave
    TACBrNFe( FACBrNFe ).NotasFiscais.GerarNFe;

    // Se tiver configurado pra salvar, salva as NFes
    if TACBrNFe( FACBrNFe ).Configuracoes.Arquivos.Salvar then
      TACBrNFe( FACBrNFe ).NotasFiscais.SaveToFile;

    with EnvDPEC.infDPEC do
    begin
      ID := TACBrNFe( FACBrNFe ).NotasFiscais.Items[0].NFe.Emit.CNPJCPF;

      IdeDec.cUF     := FConfiguracoes.WebServices.UFCodigo;
      ideDec.tpAmb   := FConfiguracoes.WebServices.Ambiente;
      ideDec.verProc := ACBRNFE_VERSAO;
      ideDec.CNPJ    := TACBrNFe( FACBrNFe ).NotasFiscais.Items[0].NFe.Emit.CNPJCPF;
      ideDec.IE      := TACBrNFe( FACBrNFe ).NotasFiscais.Items[0].NFe.Emit.IE;

      for I := 0 to TACBrNFe( FACBrNFe ).NotasFiscais.Count-1 do
      begin
        with resNFe.Add do
        begin
          chNFe   := OnlyNumber(TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.infNFe.id);
          CNPJCPF := TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.dest.CNPJCPF;
          UF      := TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.dest.enderdEST.UF;
          vNF     := TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.Total.ICMSTot.vNF;
          vICMS   := TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.Total.ICMSTot.vICMS;
          vST     := TACBrNFe( FACBrNFe ).NotasFiscais.Items[I].NFe.Total.ICMSTot.vST;
        end;
      end;
    end;

    ////EnvDPEC.Versao := GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
    ////                               FConfiguracoes.Geral.VersaoDF,
    ////                               LayNfeEnvDPEC);
    EnvDPEC.GerarXML;

    ////AssinarXML( EnvDPEC.Gerador.ArquivoFormatoXML,
    ////            'Falha ao assinar DPEC ' + LineBreak + FMsg );
  finally
    EnvDPEC.Free;
  end;
end;

procedure TNFeEnvDPEC.DefinirEnvelopeSoap;
begin
  { sobrescrito, pois Usa SOAP e não SOAP12 }

  FEnvelopeSoap := GerarSoapDEPC;
end;

function TNFeEnvDPEC.TratarResposta: Boolean;
var
  RetDPEC: TRetDPEC;
  wProc: TStringList;
begin
  RetDPEC := TRetDPEC.Create;
  try
    FRetWS := SeparaDados( FRetornoWS, 'sceRecepcaoDPECResult', True);

    RetDPEC.Leitor.Arquivo := FRetWS;
    RetDPEC.LerXml;

    Fversao    := RetDPEC.versao;
    FverAplic  := RetDPEC.verAplic;
    FcStat     := RetDPEC.cStat;
    FxMotivo   := RetDPEC.xMotivo;
    FId        := RetDPEC.Id;
    FTpAmb     := RetDPEC.tpAmb;
    FdhRegDPEC := RetDPEC.dhRegDPEC;
    FnRegDPEC  := RetDPEC.nRegDPEC;
    FNFeChave  := RetDPEC.chNFE;
    FMsg       := RetDPEC.XMotivo;

    Result := (RetDPEC.cStat = 124);

    //gerar arquivo proc de DPEC
    if Result then
    begin
      wProc := TStringList.Create;
      try
        wProc.Add('<'+ENCODING_UTF8+'>');
        wProc.Add('<procDPEC>');
        wProc.Add(FDadosMSG);
        wProc.Add(FRetWS);
        wProc.Add('</procDPEC>');
        FXML_ProcDPEC := wProc.Text;
      finally
        wProc.Free;
      end;

      if FConfiguracoes.Arquivos.Salvar then
         ////FConfiguracoes.Geral.Save(GerarPrefixoArquivo + '-procdpec.xml',
         ////                          FXML_ProcDPEC);
    end;
  finally
    RetDPEC.Free;
  end;
end;

procedure TNFeEnvDPEC.SalvarEnvio;
begin
  inherited SalvarEnvio;

  if FConfiguracoes.Arquivos.Salvar then
    ////FConfiguracoes.Geral.Save( GerarPrefixoArquivo + '-' + ArqEnv + '.xml',
    ////                           FDadosMsg,
    ////                           FConfiguracoes.Arquivos.GetPathDPEC );
end;

procedure TNFeEnvDPEC.SalvarResposta;
begin
  inherited SalvarResposta;

  if FConfiguracoes.Arquivos.Salvar then
    ////FConfiguracoes.Geral.Save( GerarPrefixoArquivo + '-' + ArqResp + '.xml',
    ////                           FRetWS,
    ////                           FConfiguracoes.Arquivos.GetPathDPEC );
end;

function TNFeEnvDPEC.GerarMsgLog: String;
begin
  Result := 'Versão Layout : ' + Fversao + LineBreak +
            'Versão Aplicativo : ' + FverAplic + LineBreak +
            'ID : ' + FId + LineBreak +
            'Status Código : ' + IntToStr(FcStat) + LineBreak +
            'Status Descrição : ' + FxMotivo + LineBreak +
            'Data Registro : ' + DateTimeToStr(FdhRegDPEC) + LineBreak +
            'nRegDPEC : ' + FnRegDPEC + LineBreak +
            'ChaveNFe : ' + FNFeChave;
end;

{ TNFeConsultaDPEC }

constructor TNFeConsultaDPEC.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FretDPEC := TRetDPEC.Create;

  FStatus  := stNFeConsultaDPEC;
  FLayout  := LayNfeConsultaDPEC;
  FArqEnv  := 'cons-dpec';
  FArqResp := 'sit-dpec';
end;

destructor TNFeConsultaDPEC.Destroy;
begin
  FretDPEC.Free;

  inherited Destroy;
end;

procedure TNFeConsultaDPEC.SetNFeChave(const Value: String);
begin
  if DFeUtil.NaoEstaVazio(Value) then
    FnRegDPEC := '';

  FNFeChave := OnlyNumber(Value);
end;

procedure TNFeConsultaDPEC.SetnRegDPEC(const Value: String);
begin
  if DFeUtil.NaoEstaVazio(Value) then
    FNFeChave := '';

  FnRegDPEC := Value;
end;

procedure TNFeConsultaDPEC.DefinirServicoEAction;
begin
  FServico    := CURL_WSDL + 'SCEConsultaRFB';
  FSoapAction := FServico + '/sceConsultaDPEC';
end;

procedure TNFeConsultaDPEC.DefinirDadosMsg;
var
  ConsDPEC: TConsDPEC;
  OK : Boolean;
begin
  OK       := False;
  ConsDPEC := TConsDPEC.Create;
  try
    ConsDPEC.tpAmb    := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo-1);
    ConsDPEC.verAplic := NfVersao;
    ConsDPEC.nRegDPEC := FnRegDPEC;
    ConsDPEC.chNFe    := FNFeChave;

    ////FConfiguracoes.Geral.ModeloDF := StrToModeloDF(OK, NotaUtil.ExtraiModeloChaveAcesso(ConsDPEC.chNFe));
    ////
    ////ConsDPEC.Versao := GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
    ////                                FConfiguracoes.Geral.VersaoDF,
    ////                                LayNfeConsultaDPEC);
    ConsDPEC.GerarXML;

    FDadosMsg := ConsDPEC.Gerador.ArquivoFormatoXML;
  finally
    ConsDPEC.Free;
  end;
end;

procedure TNFeConsultaDPEC.DefinirEnvelopeSoap;
begin
  { sobrescrito, pois Usa SOAP e não SOAP12 }

  FEnvelopeSoap := GerarSoapDEPC;
end;

function TNFeConsultaDPEC.TratarResposta: Boolean;
begin
  FRetWS := SeparaDados( FRetornoWS, 'sceConsultaDPECResult', True);

  // Limpando variaveis internas
  FretDPEC.Free;
  FretDPEC := TRetDPEC.Create;

  FretDPEC.Leitor.Arquivo := FRetWS;
  FretDPEC.LerXml;

  Fversao    := FretDPEC.versao;
  FverAplic  := FretDPEC.verAplic;
  FcStat     := FretDPEC.cStat;
  FxMotivo   := FretDPEC.xMotivo;
  FTpAmb     := FretDPEC.tpAmb;
  FnRegDPEC  := FretDPEC.nRegDPEC;
  FNFeChave  := FretDPEC.chNFE;
  FdhRegDPEC := FretDPEC.dhRegDPEC;
  FMsg       := FretDPEC.XMotivo;

  Result := (FretDPEC.cStat = 125);
end;

function TNFeConsultaDPEC.GerarMsgLog: String;
begin
  Result := 'Versão Layout : ' + FRetDPEC.versao + LineBreak +
            'Versão Aplicativo : ' + FretDPEC.verAplic + LineBreak +
            'ID : ' + FretDPEC.Id + LineBreak +
            'Status Código : ' + IntToStr(FretDPEC.cStat) + LineBreak +
            'Status Descrição : ' + FretDPEC.xMotivo + LineBreak +
            'Data Registro : ' + DateTimeToStr(FretDPEC.dhRegDPEC) + LineBreak +
            'nRegDPEC : ' + FretDPEC.nRegDPEC + LineBreak +
            'ChaveNFe : ' + FretDPEC.chNFE;
end;

{ TNFeEnvEvento }

constructor TNFeEnvEvento.Create(AOwner: TComponent; AEvento: TEventoNFe);
begin
  inherited Create(AOwner);

  FEventoRetorno := TRetEventoNFe.Create;
  FEvento := AEvento;

  FStatus  := stNFeEvento;
  FLayout  := LayNFeEvento;
  FArqEnv  := 'ped-eve';
  FArqResp := 'eve';
end;

destructor TNFeEnvEvento.Destroy;
begin
  FEventoRetorno.Free;

  inherited;
end;

function TNFeEnvEvento.GerarPathEvento: String;
begin
  if (FEvento.Evento.Items[0].InfEvento.tpEvento = teCCe) and
     (not FConfiguracoes.Arquivos.SalvarCCeCanEvento) then
    Result := FConfiguracoes.Arquivos.GetPathCCe
  else if (FEvento.Evento.Items[0].InfEvento.tpEvento = teCancelamento) and
          (not FConfiguracoes.Arquivos.SalvarCCeCanEvento) then
    Result := FConfiguracoes.Arquivos.GetPathCan
  else
    Result := FConfiguracoes.Arquivos.GetPathEvento(FEvento.Evento.Items[0].InfEvento.tpEvento);
end;

procedure TNFeEnvEvento.DefinirURL;
begin
  { Verificação necessária pois somente os eventos de Cancelamento e CCe serão tratados pela SEFAZ do estado
    os outros eventos como manifestacao de destinatários serão tratados diretamente pela RFB }

  if not (FEvento.Evento.Items[0].InfEvento.tpEvento in [teCCe, teCancelamento]) then
    FLayout := LayNFeEventoAN
  else
    FLayout := LayNFeEvento;

  inherited DefinirURL;
end;

procedure TNFeEnvEvento.DefinirServicoEAction;
begin
  FServico    := CURL_WSDL + 'RecepcaoEvento';
  FSoapAction := FServico;
end;

procedure TNFeEnvEvento.DefinirDadosMsg;
var
  EventoNFe: TEventoNFe;
  I, F: Integer;
  Lote, Evento, Eventos, EventosAssinados: String;
begin
  EventoNFe := TEventoNFe.Create;
  try
    EventoNFe.idLote := FidLote;

    for I := 0 to TNFeEnvEvento(Self).FEvento.Evento.Count-1 do
    begin
      with EventoNFe.Evento.Add do
      begin
        infEvento.tpAmb      := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo-1);
        infEvento.CNPJ       := FEvento.Evento[I].InfEvento.CNPJ;
        infEvento.cOrgao     := FEvento.Evento[I].InfEvento.cOrgao;
        infEvento.chNFe      := FEvento.Evento[I].InfEvento.chNFe;
        infEvento.dhEvento   := FEvento.Evento[I].InfEvento.dhEvento;
        infEvento.tpEvento   := FEvento.Evento[I].InfEvento.tpEvento;
        infEvento.nSeqEvento := FEvento.Evento[I].InfEvento.nSeqEvento;

        case InfEvento.tpEvento of
          teCCe:
          begin
            infEvento.detEvento.xCorrecao := FEvento.Evento[I].InfEvento.detEvento.xCorrecao;
            infEvento.detEvento.xCondUso  := FEvento.Evento[I].InfEvento.detEvento.xCondUso;
          end;

          teCancelamento:
          begin
            infEvento.detEvento.nProt := FEvento.Evento[I].InfEvento.detEvento.nProt;
            infEvento.detEvento.xJust := FEvento.Evento[I].InfEvento.detEvento.xJust;
          end;

          teManifDestOperNaoRealizada:
            infEvento.detEvento.xJust := FEvento.Evento[I].InfEvento.detEvento.xJust;

          teEPECNFe:
          begin
            infEvento.detEvento.cOrgaoAutor := FEvento.Evento[I].InfEvento.detEvento.cOrgaoAutor;
            infEvento.detEvento.tpAutor     := FEvento.Evento[I].InfEvento.detEvento.tpAutor;
            infEvento.detEvento.verAplic    := FEvento.Evento[I].InfEvento.detEvento.verAplic;
            infEvento.detEvento.dhEmi       := FEvento.Evento[I].InfEvento.detEvento.dhEmi;
            infEvento.detEvento.tpNF        := FEvento.Evento[I].InfEvento.detEvento.tpNF;
            infEvento.detEvento.IE          := FEvento.Evento[I].InfEvento.detEvento.IE;

            infEvento.detEvento.dest.UF            := FEvento.Evento[I].InfEvento.detEvento.dest.UF;
            infEvento.detEvento.dest.CNPJCPF       := FEvento.Evento[I].InfEvento.detEvento.dest.CNPJCPF;
            infEvento.detEvento.dest.idEstrangeiro := FEvento.Evento[I].InfEvento.detEvento.dest.idEstrangeiro;
            infEvento.detEvento.dest.IE            := FEvento.Evento[I].InfEvento.detEvento.dest.IE;

            infEvento.detEvento.vNF   := FEvento.Evento[I].InfEvento.detEvento.vNF;
            infEvento.detEvento.vICMS := FEvento.Evento[I].InfEvento.detEvento.vICMS;
            infEvento.detEvento.vST   := FEvento.Evento[I].InfEvento.detEvento.vST;
          end;
        end;
      end;
    end;

    ////EventoNFe.Versao := GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
    ////                                 FConfiguracoes.Geral.VersaoDF,
    ////                                 Layout);
    EventoNFe.GerarXML;

    // Separa os grupos <evento> e coloca na variável Eventos
    I       := Pos( '<evento ', EventoNFe.Gerador.ArquivoFormatoXML );
    Lote    := Copy( EventoNFe.Gerador.ArquivoFormatoXML, 1, I - 1 );
    Eventos := SeparaDados( EventoNFe.Gerador.ArquivoFormatoXML, 'envEvento' );
    I       := Pos( '<evento ', Eventos );
    Eventos := Copy( Eventos, I, length(Eventos) );

    EventosAssinados := '';

    // Realiza a assinatura para cada evento
    while Eventos <> '' do
    begin
      F := Pos( '</evento>', Eventos );

      if F > 0 then
      begin
        Evento  := Copy( Eventos, 1, F + 8 );
        Eventos := Copy( Eventos, F + 9, length(Eventos) );

        ////AssinarXML(Evento,
        ////           'Falha ao assinar o Envio de Evento ' + LineBreak + FMsg);

        EventosAssinados := EventosAssinados + StringReplace( FDadosMsg, '<?xml version="1.0"?>', '', [] );
      end
      else
        Break;
    end;

    F := Pos( '?>', EventosAssinados );
    if F <> 0 then
      FDadosMsg := copy(EventosAssinados, 1, F + 1) +
                   Lote +
                   copy(EventosAssinados, F + 2, Length(EventosAssinados)) +
                   '</envEvento>'
    else
      FDadosMsg := Lote + EventosAssinados + '</envEvento>';

    ////if not(NotaUtil.Valida(FDadosMsg, FMsg, TACBrNFe( FACBrNFe ).Configuracoes.Geral.PathSchemas,
    ////                       FConfiguracoes.Geral.ModeloDF, FConfiguracoes.Geral.VersaoDF)) then
    ////  GerarException('Falha na validação dos dados do Envio de Evento ' +
    ////                 LineBreak + FMsg);

    for I := 0 to FEvento.Evento.Count-1 do
      FEvento.Evento[I].InfEvento.id := EventoNFe.Evento[I].InfEvento.id;
  finally
    EventoNFe.Free;
  end;
end;

function TNFeEnvEvento.TratarResposta: Boolean;
var
  Leitor: TLeitor;
  I, J: Integer;
  wProc: TStringList;
  NomeArq: String;
begin
  FEvento.idLote := idLote;

  FRetWS := SeparaDados( FRetornoWS, 'nfeRecepcaoEventoResult' );

  // Limpando variaveis internas
  FEventoRetorno.Free;
  FEventoRetorno := TRetEventoNFe.Create;

  EventoRetorno.Leitor.Arquivo := FRetWS;
  EventoRetorno.LerXml;

  FcStat   := EventoRetorno.cStat;
  FxMotivo := EventoRetorno.xMotivo;
  FMsg     := EventoRetorno.xMotivo;
  FTpAmb   := EventoRetorno.tpAmb;

  Result := (EventoRetorno.cStat = 128) or
            (EventoRetorno.cStat = 135) or
            (EventoRetorno.cStat = 136) or
            (EventoRetorno.cStat = 155);

  //gerar arquivo proc de evento
  if Result then
  begin
    Leitor := TLeitor.Create;
    try
      for I := 0 to FEvento.Evento.Count-1 do
      begin
        for J := 0 to EventoRetorno.retEvento.Count-1 do
        begin
          if FEvento.Evento.Items[I].InfEvento.chNFe = EventoRetorno.retEvento.Items[J].RetInfEvento.chNFe then
          begin
            FEvento.Evento.Items[I].RetInfEvento.nProt       := EventoRetorno.retEvento.Items[J].RetInfEvento.nProt;
            FEvento.Evento.Items[I].RetInfEvento.dhRegEvento := EventoRetorno.retEvento.Items[J].RetInfEvento.dhRegEvento;
            FEvento.Evento.Items[I].RetInfEvento.cStat       := EventoRetorno.retEvento.Items[J].RetInfEvento.cStat;
            FEvento.Evento.Items[I].RetInfEvento.xMotivo     := EventoRetorno.retEvento.Items[J].RetInfEvento.xMotivo;

            wProc := TStringList.Create;
            try
              wProc.Add('<'+ENCODING_UTF8+'>');
              ////wProc.Add('<procEventoNFe versao="' + GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
              ////                                                   FConfiguracoes.Geral.VersaoDF,
              ////                                                   LayNfeEvento) +
              ////                        '" xmlns="http://www.portalfiscal.inf.br/nfe">');
              ////wProc.Add('<evento versao="' + GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
              ////                                            FConfiguracoes.Geral.VersaoDF,
              ////                                            LayNfeEvento) + '">');
              Leitor.Arquivo := FDadosMSG;
              wProc.Add(Leitor.rExtrai(1, 'infEvento', '', I + 1));
              wProc.Add('<Signature xmlns="http://www.w3.org/2000/09/xmldsig#">');

              Leitor.Arquivo := FDadosMSG;
              wProc.Add(Leitor.rExtrai(1, 'SignedInfo', '', I + 1));

              Leitor.Arquivo := FDadosMSG;
              wProc.Add(Leitor.rExtrai(1, 'SignatureValue', '', I + 1));

              Leitor.Arquivo := FDadosMSG;
              wProc.Add(Leitor.rExtrai(1, 'KeyInfo', '', I + 1));
              wProc.Add('</Signature>');
              wProc.Add('</evento>');
              ////wProc.Add('<retEvento versao="' + GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
              ////                                               FConfiguracoes.Geral.VersaoDF,
              ////                                               LayNfeEvento) + '">');

              Leitor.Arquivo := FRetWS;
              wProc.Add(Leitor.rExtrai(1, 'infEvento', '', J + 1));
              wProc.Add('</retEvento>');
              wProc.Add('</procEventoNFe>');

              EventoRetorno.retEvento.Items[J].RetInfEvento.XML := wProc.Text;

              FEvento.Evento.Items[I].RetInfEvento.XML := wProc.Text;

              NomeArq := OnlyNumber(FEvento.Evento.Items[i].InfEvento.Id) +
                         '-procEventoNFe.xml';

              ////if FConfiguracoes.Geral.Salvar then
              ////  FConfiguracoes.Geral.Save(NomeArq, wProc.Text);
              ////
              ////if FConfiguracoes.Arquivos.Salvar then
              ////  FConfiguracoes.Geral.Save(NomeArq, wProc.Text, GerarPathEvento);
            finally
              wProc.Free;
            end;

            break;
          end;
        end;
      end;
    finally
      Leitor.Free;
    end;
  end;
end;

procedure TNFeEnvEvento.SalvarEnvio;
begin
  inherited SalvarEnvio;

  if FConfiguracoes.Arquivos.Salvar then
    ////FConfiguracoes.Geral.Save(GerarPrefixoArquivo + '-' + ArqEnv + '.xml',
    ////                          FDadosMsg, GerarPathEvento);
end;

procedure TNFeEnvEvento.SalvarResposta;
begin
  inherited SalvarResposta;

  if FConfiguracoes.Arquivos.Salvar then
    ////FConfiguracoes.Geral.Save(GerarPrefixoArquivo + '-' + ArqEnv + '.xml',
    ////                          FDadosMsg, GerarPathEvento);
end;

function TNFeEnvEvento.GerarMsgLog: String;
var
  aMsg: String;
begin
  aMsg := 'Versão Layout : ' + FEventoRetorno.versao + LineBreak +
          'Ambiente : ' + TpAmbToStr(FEventoRetorno.tpAmb) + LineBreak +
          'Versão Aplicativo : ' + FEventoRetorno.verAplic + LineBreak +
          'Status Código : ' + IntToStr(FEventoRetorno.cStat) + LineBreak +
          'Status Descrição : ' + FEventoRetorno.xMotivo + LineBreak;

  if FEventoRetorno.retEvento.Count > 0 then
    aMsg := aMsg + 'Recebimento : '+
            IfThen(FEventoRetorno.retEvento.Items[0].RetInfEvento.dhRegEvento = 0,
                            '',
                            DateTimeToStr(FEventoRetorno.retEvento.Items[0].RetInfEvento.dhRegEvento));
  Result := aMsg;
end;

function TNFeEnvEvento.GerarPrefixoArquivo: String;
begin
  Result := IntToStr(FEvento.idLote);
end;

{ TNFeConsNFeDest }

constructor TNFeConsNFeDest.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FretConsNFeDest := TretConsNFeDest.Create;

  FStatus  := stConsNFeDest;
  FLayout  := LayNFeConsNFeDest;
  FArqEnv  := 'con-nfe-dest';
  FArqResp := 'nfe-dest';
end;

destructor TNFeConsNFeDest.Destroy;
begin
  FretConsNFeDest.Free;

  inherited Destroy;
end;

procedure TNFeConsNFeDest.DefinirServicoEAction;
begin
  FServico    := CURL_WSDL + 'NfeConsultaDest';
  FSoapAction := FServico + '/nfeConsultaNFDest';
end;

procedure TNFeConsNFeDest.DefinirDadosMsg;
var
  ConsNFeDest: TConsNFeDest;
begin
  ConsNFeDest := TConsNFeDest.Create;
  try
    ConsNFeDest.TpAmb  := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo-1);
    ConsNFeDest.CNPJ   := FCNPJ;
    ConsNFeDest.indNFe := FindNFe;
    ConsNFeDest.indEmi := FindEmi;
    ConsNFeDest.ultNSU := FultNSU;
    ////ConsNFeDest.Versao := GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
    ////                                   FConfiguracoes.Geral.VersaoDF,
    ////                                   LayNfeConsNFeDest);
    ConsNFeDest.GerarXML;

    FDadosMsg := ConsNFeDest.Gerador.ArquivoFormatoXML;
  finally
    ConsNFeDest.Free;
  end;
end;

function TNFeConsNFeDest.TratarResposta: Boolean;
begin
  FRetWS := SeparaDados( FRetornoWS, 'nfeConsultaNFDestResult' );

  // Limpando variaveis internas
  FretConsNFeDest.Free;
  FretConsNFeDest := TRetConsNFeDest.Create;

  FretConsNFeDest.Leitor.Arquivo := FRetWS;
  FretConsNFeDest.LerXml;

  Result := (FretConsNFeDest.CStat =137) or
            (FretConsNFeDest.CStat =138);
end;

function TNFeConsNFeDest.GerarMsgLog: String;
begin
  Result := 'Versão Layout: ' + FretConsNFeDest.versao + LineBreak +
            'Ambiente : ' + TpAmbToStr(FretConsNFeDest.tpAmb) + LineBreak +
            'Versão Aplicativo : ' + FretConsNFeDest.verAplic + LineBreak +
            'Status Código : ' + IntToStr(FretConsNFeDest.cStat) + LineBreak +
            'Status Descrição : ' + FretConsNFeDest.xMotivo + LineBreak +
            'Recebimento : ' + IfThen(FretConsNFeDest.dhResp = 0,
                                               '',
                                               DateTimeToStr(RetConsNFeDest.dhResp)) +
                               LineBreak +
            'Ind. Continuação : ' + IndicadorContinuacaoToStr(FretConsNFeDest.indCont) +
                                    LineBreak +
            'Último NSU : ' + FretConsNFeDest.ultNSU + LineBreak;
end;

function TNFeConsNFeDest.GerarMsgErro(E: Exception): String;
begin
  Result := 'WebService Consulta NF-e Destinadas:' + LineBreak +
            '- Inativo ou Inoperante tente novamente.' + LineBreak +
            '- ' + E.Message;
end;

{ TNFeDownloadNFe }

constructor TNFeDownloadNFe.Create(AOwner: TComponent; ADownload: TDownloadNFe);
begin
  inherited Create(AOwner);

  FRetDownloadNFe := TretDownloadNFe.Create;
  FDownload := ADownload;

  FStatus  := stDownloadNFe;
  FLayout  := LayNFeDownloadNFe;
  FArqEnv  := 'ped-down-nfe';
  FArqResp := 'down-nfe';
end;

destructor TNFeDownloadNFe.Destroy;
begin
  FRetDownloadNFe.Free;

  inherited Destroy;
end;

procedure TNFeDownloadNFe.DefinirServicoEAction;
begin
  FServico    := CURL_WSDL + 'NfeDownloadNF';
  FSoapAction := FServico + '/nfeDownloadNF';
end;

procedure TNFeDownloadNFe.DefinirDadosMsg;
var
  DownloadNFe: TDownloadNFe;
  I: integer;
begin
  DownloadNFe := TDownloadNFe.create;
  try
    DownloadNFe.TpAmb := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo-1);
    DownloadNFe.CNPJ  := FDownload.CNPJ;

    for I := 0 to FDownload.Chaves.Count - 1 do
    begin
      with DownloadNFe.Chaves.Add do
      begin
        chNFe := FDownload.Chaves[I].chNFe;
      end;
    end;

    ////DownloadNFe.Versao := GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
    ////                                   FConfiguracoes.Geral.VersaoDF,
    ////                                   LayNfeDownloadNFe);
    DownloadNFe.GerarXML;

    FDadosMsg := DownloadNFe.Gerador.ArquivoFormatoXML;
  finally
    DownloadNFe.Free;
  end;
end;

function TNFeDownloadNFe.TratarResposta: Boolean;
var
  I: Integer;
  NomeArq: String;
begin
  FRetWS := SeparaDados( FRetornoWS, 'nfeDownloadNFResult' );

  // Limpando variaveis internas
  FretDownloadNFe.Free;
  FRetDownloadNFe := TRetDownloadNFe.Create;

  FRetDownloadNFe.Leitor.Arquivo := FRetWS;
  FRetDownloadNFe.LerXml;

  Result := (FRetDownloadNFe.cStat = 139);

  for I := 0 to FRetDownloadNFe.retNFe.Count - 1 do
  begin
    if FRetDownloadNFe.retNFe.Items[I].cStat = 140 then
    begin
      NomeArq := FRetDownloadNFe.retNFe.Items[I].chNFe + '-nfe.xml';
      ////FConfiguracoes.Geral.Save(NomeArq, FRetDownloadNFe.retNFe.Items[I].procNFe);
    end;
  end;
end;

function TNFeDownloadNFe.GerarMsgLog: String;
begin
  Result := 'Versão Layout: ' + FretDownloadNFe.versao + LineBreak +
            'Ambiente : ' + TpAmbToStr(FretDownloadNFe.tpAmb) + LineBreak +
            'Versão Aplicativo : ' + FretDownloadNFe.verAplic + LineBreak +
            'Status Código : ' + IntToStr(FretDownloadNFe.cStat) + LineBreak +
            'Status Descrição : ' + FretDownloadNFe.xMotivo + LineBreak +
            'Recebimento : ' + IfThen(FretDownloadNFe.dhResp = 0,
                                               '',
                                               DateTimeToStr(FRetDownloadNFe.dhResp)) +
                               LineBreak;
end;

function TNFeDownloadNFe.GerarMsgErro(E: Exception): String;
begin
  Result := 'WebService Download de NF-e:' + LineBreak +
            '- Inativo ou Inoperante tente novamente.' + LineBreak +
            '- ' + E.Message;
end;

{ TAdministrarCSCNFCe }

constructor TAdministrarCSCNFCe.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FretAdmCSCNFCe := TretAdmCSCNFCe.Create;

  FStatus  := stAdmCSCNFCe;
  FLayout  := LayAdministrarCSCNFCe;
  FArqEnv  := 'ped-csc';
  FArqResp := 'csc';
end;

destructor TAdministrarCSCNFCe.Destroy;
begin
  FretAdmCSCNFCe.Free;

  inherited Destroy;
end;

procedure TAdministrarCSCNFCe.DefinirServicoEAction;
begin
  // O Método ainda não esta definido.
  FServico    := CURL_WSDL + 'MetodoNaoDefinido';
  FSoapAction := FServico;
end;

procedure TAdministrarCSCNFCe.DefinirDadosMsg;
var
  AdmCSCNFCe: TAdmCSCNFCe;
begin
  AdmCSCNFCe := TAdmCSCNFCe.Create;
  try
    AdmCSCNFCe.TpAmb     := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo-1);
    AdmCSCNFCe.RaizCNPJ  := FRaizCNPJ;
    AdmCSCNFCe.indOP     := FindOp;
    AdmCSCNFCe.idCsc     := FIdCSC;
    AdmCSCNFCe.codigoCsc := FCodigoCSC;

    ////AdmCSCNFCe.Versao := GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
    ////                                  FConfiguracoes.Geral.VersaoDF,
    ////                                  LayAdministrarCSCNFCe);
    AdmCSCNFCe.GerarXML;

    FDadosMsg := AdmCSCNFCe.Gerador.ArquivoFormatoXML;
  finally
    AdmCSCNFCe.Free;
  end;
end;

function TAdministrarCSCNFCe.TratarResposta: Boolean;
begin
  // O Método ainda não esta definido.
  FRetWS := SeparaDados( FRetornoWS, 'MetodoNaoDefinidoResult' );

  // Limpando variaveis internas
  FretAdmCSCNFCe.Free;
  FretAdmCSCNFCe := TRetAdmCSCNFCe.Create;

  FretAdmCSCNFCe.Leitor.Arquivo := FRetWS;
  FretAdmCSCNFCe.LerXml;

  Result := (FretAdmCSCNFCe.CStat in [150..153]);
end;

function TAdministrarCSCNFCe.GerarMsgLog: String;
begin
  Result := 'Versão Layout : ' + FretAdmCSCNFCe.versao + LineBreak +
            'Ambiente : ' + TpAmbToStr(FretAdmCSCNFCe.tpAmb) + LineBreak +
            'Status Código : ' + IntToStr(FretAdmCSCNFCe.cStat) + LineBreak +
            'Status Descrição : ' + FretAdmCSCNFCe.xMotivo + LineBreak;
end;

function TAdministrarCSCNFCe.GerarMsgErro(E: Exception): String;
begin
  Result := 'WebService Administrar CSC da NFC-e:' + LineBreak +
            '- Inativo ou Inoperante tente novamente.' + LineBreak +
            '- ' + E.Message;
end;

{ TDistribuicaoDFe }

constructor TDistribuicaoDFe.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FretDistDFeInt := TretDistDFeInt.Create;

  FStatus  := stDistDFeInt;
  FLayout  := LayDistDFeInt;
  FArqEnv  := 'con-dist-dfe';
  FArqResp := 'dist-dfe';
end;

destructor TDistribuicaoDFe.Destroy;
begin
  FretDistDFeInt.Free;

  inherited;
end;

procedure TDistribuicaoDFe.DefinirServicoEAction;
begin
  FServico    := CURL_WSDL + 'NFeDistribuicaoDFe';
  FSoapAction := FServico + '/nfeDistDFeInteresse';
end;

procedure TDistribuicaoDFe.DefinirDadosMsg;
var
  DistDFeInt: TDistDFeInt;
begin
  DistDFeInt := TDistDFeInt.Create;
  try
    DistDFeInt.TpAmb    := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo-1);
    DistDFeInt.cUFAutor := FcUFAutor;
    DistDFeInt.CNPJCPF  := FCNPJCPF;
    DistDFeInt.ultNSU   := FultNSU;
    DistDFeInt.NSU      := FNSU;
    ////DistDFeInt.Versao   := GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
    ////                                    FConfiguracoes.Geral.VersaoDF,
    ////                                    LayDistDFeInt);
    DistDFeInt.GerarXML;

    FDadosMsg := DistDFeInt.Gerador.ArquivoFormatoXML;
  finally
    DistDFeInt.Free;
  end;
end;

procedure TDistribuicaoDFe.DefinirEnvelopeSoap;
var
  Texto: String;
begin
  { sobrescrito, pois não utiliza o grupo Header }

  Texto := '<'+ENCODING_UTF8+'>';
  Texto := Texto + '<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                                    'xmlns:xsd="http://www.w3.org/2001/XMLSchema" ' +
                                    'xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">';
  Texto := Texto +   '<soap12:Body>';
  Texto := Texto +     '<nfeDistDFeInteresse xmlns="' + Servico + '">';
  Texto := Texto +       '<nfeDadosMsg>';
  Texto := Texto +         FDadosMsg;
  Texto := Texto +       '</nfeDadosMsg>';
  Texto := Texto +     '</nfeDistDFeInteresse>';
  Texto := Texto +   '</soap12:Body>';
  Texto := Texto + '</soap12:Envelope>';

  FEnvelopeSoap := Texto;
end;

function TDistribuicaoDFe.TratarResposta: Boolean;
var
  I: Integer;
  NomeArq: String;
begin
  FRetWS := SeparaDados( FRetornoWS, 'nfeDistDFeInteresseResult' );

  // Limpando variaveis internas
  FretDistDFeInt.Free;
  FretDistDFeInt := TRetDistDFeInt.Create;

  FretDistDFeInt.Leitor.Arquivo := FRetWS;
  FretDistDFeInt.LerXml;

  Result := (FretDistDFeInt.CStat = 137) or
            (FretDistDFeInt.CStat = 138);

  // Incluido por Italo em 22/01/2015
  for I := 0 to FretDistDFeInt.docZip.Count - 1 do
  begin
    if (FretDistDFeInt.docZip.Items[I].XML <> '') and
       (Copy(FretDistDFeInt.docZip.Items[I].schema, 1, 7) = 'procNFe') then
    begin
      NomeArq := FretDistDFeInt.docZip.Items[I].resNFe.chNFe + '-nfe.xml';
      FConfiguracoes.Geral.Save(NomeArq, FretDistDFeInt.docZip.Items[I].XML);
    end;
  end;
end;

function TDistribuicaoDFe.GerarMsgLog: String;
begin
  Result := 'Versão Layout : ' + FretDistDFeInt.versao + LineBreak +
            'Ambiente : ' + TpAmbToStr(FretDistDFeInt.tpAmb) + LineBreak +
            'Versão Aplicativo : ' + FretDistDFeInt.verAplic + LineBreak +
            'Status Código : ' + IntToStr(FretDistDFeInt.cStat) + LineBreak +
            'Status Descrição : ' + FretDistDFeInt.xMotivo + LineBreak +
            'Resposta : ' + IfThen(FretDistDFeInt.dhResp = 0,
                                            '',
                                            DateTimeToStr(RetDistDFeInt.dhResp)) +
                            LineBreak +
            'Último NSU : ' + FretDistDFeInt.ultNSU + LineBreak +
            'Máximo NSU : ' + FretDistDFeInt.maxNSU + LineBreak;
end;

function TDistribuicaoDFe.GerarMsgErro(E: Exception): String;
begin
  Result := 'WebService Distribuição de DFe:' + LineBreak +
            '- Inativo ou Inoperante tente novamente.' + LineBreak +
            '- ' + E.Message;
end;

{ TNFeEnvioWebService }

constructor TNFeEnvioWebService.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FStatus := stEnvioWebService;
end;

destructor TNFeEnvioWebService.Destroy;
begin
  inherited Destroy;
end;

function TNFeEnvioWebService.Executar: Boolean;
begin
  Result := inherited Executar;
end;

procedure TNFeEnvioWebService.DefinirURL;
begin
  FURL := FURLEnvio;
end;

procedure TNFeEnvioWebService.DefinirServicoEAction;
begin
  FServico := FSoapAction;
end;

procedure TNFeEnvioWebService.DefinirDadosMsg;
var
  LeitorXML: TLeitor;
begin
  LeitorXML := TLeitor.Create;
  try
    LeitorXML.Arquivo := FXMLEnvio;
    LeitorXML.Grupo   := FXMLEnvio;
    FVersao           := LeitorXML.rAtributo('versao')
  finally
    LeitorXML.Free;
  end;

  FDadosMsg := FXMLEnvio;
end;

function TNFeEnvioWebService.TratarResposta: Boolean;
begin
  FRetWS := SeparaDados( FRetornoWS, 'soap:Body' );
  Result := True;
end;

function TNFeEnvioWebService.GerarMsgLog: String;
begin
  Result := inherited GerarMsgLog;
end;

function TNFeEnvioWebService.GerarMsgErro(E: Exception): String;
begin
  Result := 'WebService' + LineBreak +
            '- Inativo ou Inoperante tente novamente.' + LineBreak +
            '- ' + E.Message;
end;

function TNFeEnvioWebService.GerarVersaoDadosSoap: String;
begin
  Result := '<versaoDados>' + FVersao + '</versaoDados>';
end;

{ TWebServices }

constructor TWebServices.Create(AFNotaFiscalEletronica: TComponent);
begin
  FACBrNFe            := TACBrNFe(AFNotaFiscalEletronica);
  FStatusServico      := TNFeStatusServico.Create(AFNotaFiscalEletronica);
  FEnviar             := TNFeRecepcao.Create(AFNotaFiscalEletronica,
                                             TACBrNFe(AFNotaFiscalEletronica).NotasFiscais);
  FRetorno            := TNFeRetRecepcao.Create(AFNotaFiscalEletronica,
                                                TACBrNFe(AFNotaFiscalEletronica).NotasFiscais);
  FRecibo             := TNFeRecibo.Create(AFNotaFiscalEletronica);
  FConsulta           := TNFeConsulta.Create(AFNotaFiscalEletronica);
  FInutilizacao       := TNFeInutilizacao.Create(AFNotaFiscalEletronica);
  FConsultaCadastro   := TNFeConsultaCadastro.Create(AFNotaFiscalEletronica);
  FEnviaDPEC          := TNFeEnvDPEC.Create(AFNotaFiscalEletronica);
  FConsultaDPEC       := TNFeConsultaDPEC.Create(AFNotaFiscalEletronica);
  FEnvEvento          := TNFeEnvEvento.Create(AFNotaFiscalEletronica,
                                              TACBrNFe(AFNotaFiscalEletronica).EventoNFe);
  FConsNFeDest        := TNFeConsNFeDest.Create(AFNotaFiscalEletronica);
  FDownloadNFe        := TNFeDownloadNFe.Create(AFNotaFiscalEletronica,
                                                TACBrNFe(AFNotaFiscalEletronica).DownloadNFe.Download);
  FAdministrarCSCNFCe := TAdministrarCSCNFCe.Create(AFNotaFiscalEletronica);
  FDistribuicaoDFe    := TDistribuicaoDFe.Create(AFNotaFiscalEletronica);
  FEnvioWebService    := TNFeEnvioWebService.Create(AFNotaFiscalEletronica);
end;

destructor TWebServices.Destroy;
begin
  FStatusServico.Free;
  FEnviar.Free;
  FRetorno.Free;
  FRecibo.Free;
  FConsulta.Free;
  FInutilizacao.Free;
  FConsultaCadastro.Free;
  FEnviaDPEC.Free;
  FConsultaDPEC.Free;
  FEnvEvento.Free;
  FConsNFeDest.Free;
  FDownloadNFe.Free;
  FAdministrarCSCNFCe.Free;
  FDistribuicaoDFe.Free;
  FEnvioWebService.Free;

  inherited Destroy;
end;

function TWebServices.Envia(ALote: Integer; const ASincrono: Boolean): Boolean;
begin
  Result := Envia(IntToStr(ALote), ASincrono);
end;

function TWebServices.Envia(ALote: String; const ASincrono: Boolean): Boolean;
begin
  FEnviar.FLote     := ALote;
  FEnviar.FSincrono := ASincrono;

  if not Enviar.Executar then
    Enviar.GerarException(Enviar.Msg);

  if not ASincrono then
  begin
    FRetorno.Recibo := FEnviar.Recibo;
    if not FRetorno.Executar then
      FRetorno.GerarException(FRetorno.Msg);
  end;

  Result := True;
end;

procedure TWebServices.Inutiliza(CNPJ,
                                 AJustificativa: String;
                                 Ano,
                                 Modelo,
                                 Serie,
                                 NumeroInicial,
                                 NumeroFinal: Integer);
begin
  CNPJ := OnlyNumber(CNPJ);

  if not ValidarCNPJ(CNPJ) then
    raise EACBrNFeException.Create('CNPJ: ' + CNPJ + ', inválido.');

  FInutilizacao.CNPJ          := CNPJ;
  FInutilizacao.Modelo        := Modelo;
  FInutilizacao.Serie         := Serie;
  FInutilizacao.Ano           := Ano;
  FInutilizacao.NumeroInicial := NumeroInicial;
  FInutilizacao.NumeroFinal   := NumeroFinal;
  FInutilizacao.Justificativa := AJustificativa;

  if not FInutilizacao.Executar then
     FInutilizacao.GerarException(FInutilizacao.Msg);
end;

end.

