{******************************************************************************}
{ Projeto: Componente ACBrCTe                                                  }
{  Biblioteca multiplataforma de componentes Delphi para emissão de Conhecimen-}
{ to de Transporte eletrônico - CTe - http://www.cte.fazenda.gov.br            }
{                                                                              }
{ Direitos Autorais Reservados (c) 2008 Wiliam Zacarias da Silva Rosa          }
{                                       Wemerson Souto                         }
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
{ Wiliam Zacarias da Silva Rosa  -  wrosa2009@yahoo.com.br -  www.motta.com.br }
{                                                                              }
{******************************************************************************}

{*******************************************************************************
|* Historico
|*
|* 16/12/2008: Wemerson Souto
|*  - Doação do componente para o Projeto ACBr
|* 10/08/2009 : Wiliam Zacarias da Silva Rosa
|*  - Criadas classes e procedimentos para acesso aos webservices
|* 08/03/2010 : Bruno - Rhythmus Informatica
|* Corrigida função DoCTeRecepcao
|* 26/09/2014: Italo Jurisao Junior
|*  - Refactoring, revisão e otimização
*******************************************************************************}

{$I ACBr.inc}

unit ACBrCTeWebServices;

interface

uses
  Classes, SysUtils,
{$IFDEF CLX} QDialogs,{$ELSE} Dialogs,{$ENDIF}
{$IFDEF ACBrCTeOpenSSL}
  HTTPSend,
{$ELSE}
     {$IFDEF SoapHTTP}
     SoapHTTPClient, SOAPHTTPTrans, SOAPConst, JwaWinCrypt, WinInet, ACBrCAPICOM_TLB,
     {$ELSE}
        ACBrHTTPReqResp,
     {$ENDIF}
{$ENDIF}
  pcnAuxiliar, pcnConversao, pcteRetConsCad,
  ACBrCTeConfiguracoes, ACBrCteConhecimentos,
  pcteRetConsReciCTe, pcteProcCte, pcteRetCancCTe, pcteConsReciCTe,
  pcteRetConsSitCTe, pcteEnvEventoCTe, pcteRetEnvEventoCTe, pcteCTeW,
  pcteRetEnvCTe;

const
  CURL_WSDL = 'http://www.portalfiscal.inf.br/cte/wsdl/';
  INTERNET_OPTION_CLIENT_CERT_CONTEXT = 84;

type

  { TWebServicesBase }

  TWebServicesBase = Class
  private
    {$IFDEF ACBrCTeOpenSSL}
     procedure ConfiguraHTTP( HTTP: THTTPSend; Action: AnsiString );
    {$ELSE}
     {$IFDEF SoapHTTP}
      procedure ConfiguraReqResp( ReqResp: THTTPReqResp );
      procedure OnBeforePost(const HTTPReqResp: THTTPReqResp; Data:Pointer);
     {$ELSE}
      procedure ConfiguraReqResp( ReqResp: TACBrHTTPReqResp );
     {$ENDIF}
    {$ENDIF}
  protected
    FCabMsg: WideString;
    FDadosMsg: AnsiString;
    FEnvelopeSoap: AnsiString;
    FRetornoWS: AnsiString;
    FRetWS: AnsiString;
    FMsg: AnsiString;
    FURL: WideString;
    FConfiguracoes: TConfiguracoes;
    FACBrCTe: TComponent;
    FArqEnv: AnsiString;
    FArqResp: AnsiString;
    FServico: AnsiString;
    FSoapAction: AnsiString;
    FStatus: TStatusACBrCTe;
    FLayout: TLayOutCTe;
    FEveEPEC: Boolean;
    FRetCTeDFe: AnsiString;
  protected
    procedure AssinarXML( AXML: String; MsgErro: String );
    procedure FazerLog(Msg: AnsiString; Exibir: Boolean = False);
    procedure GerarException(Msg: AnsiString);
  protected
    procedure InicializarServico; virtual;
    procedure DefinirServicoEAction; virtual;
    procedure DefinirURL; virtual;
    procedure DefinirDadosMsg; virtual;
    procedure DefinirEnvelopeSoap; virtual;
    procedure SalvarEnvio; virtual;
    procedure EnviarDados; virtual;
    function TratarResposta: Boolean; virtual;
    procedure SalvarResposta; virtual;
    procedure FinalizarServico; virtual;

    function GerarMsgLog: AnsiString; virtual;
    function GerarMsgErro(E: Exception): AnsiString; virtual;
    function GerarVersaoDadosSoap: AnsiString; virtual;
    function GerarUFSoap:AnsiString; virtual;
    function GerarPrefixoArquivo: AnsiString; virtual;
  public
    constructor Create(AOwner: TComponent); virtual;

    function Executar: Boolean; virtual;

    property Servico: AnsiString      read FServico;
    property SoapAction: AnsiString   read FSoapAction;
    property Status: TStatusACBrCTe   read FStatus;
    property Layout: TLayOutCTe       read FLayout;
    property URL: WideString          read FURL;
    property CabMsg: WideString       read FCabMsg;
    property DadosMsg: AnsiString     read FDadosMsg;
    property EnvelopeSoap: AnsiString read FEnvelopeSoap;
    property RetornoWS: AnsiString    read FRetornoWS;
    property RetWS: AnsiString        read FRetWS;
    property Msg: AnsiString          read FMsg;
    property ArqEnv: AnsiString       read FArqEnv;
    property ArqResp: AnsiString      read FArqResp;
    property RetCTeDFe: AnsiString    read FRetCTeDFe;
  end;

  { TCTeStatusServico }

  TCTeStatusServico = Class(TWebServicesBase)
  private
    Fversao: String;
    FtpAmb: TpcnTipoAmbiente;
    FverAplic: String;
    FcStat: Integer;
    FxMotivo: String;
    FcUF: Integer;
    FdhRecbto: TDateTime;
    FTMed: Integer;
    FdhRetorno: TDateTime;
    FxObs: String;
  protected
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    function TratarResposta: Boolean; override;

    function GerarMsgLog: AnsiString; override;
    function GerarMsgErro(E: Exception): AnsiString; override;
  public
    constructor Create(AOwner: TComponent); override;

    property versao: String          read Fversao;
    property tpAmb: TpcnTipoAmbiente read FtpAmb;
    property verAplic: String        read FverAplic;
    property cStat: Integer          read FcStat;
    property xMotivo: String         read FxMotivo;
    property cUF: Integer            read FcUF;
    property dhRecbto: TDateTime     read FdhRecbto;
    property TMed: Integer           read FTMed;
    property dhRetorno: TDateTime    read FdhRetorno;
    property xObs: String            read FxObs;
  end;

  { TCTeRecepcao }

  TCTeRecepcao = Class(TWebServicesBase)
  private
    FLote: String;
    FRecibo: String;
    FConhecimentos: TConhecimentos;
    Fversao: String;
    FTpAmb: TpcnTipoAmbiente;
    FverAplic: String;
    FcStat: Integer;
    FcUF: Integer;
    FxMotivo: String;
    FdhRecbto: TDateTime;
    FTMed: Integer;

    FCTeRetorno: TretEnvCTe;

    function GetLote: String;
    function GetRecibo: String;
  protected
    procedure DefinirURL; override;
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    function TratarResposta: Boolean; override;
    procedure FinalizarServico; override;

    function GerarMsgLog: AnsiString; override;
    function GerarPrefixoArquivo: AnsiString; override;
  public
    constructor Create(AOwner: TComponent; AConhecimentos: TConhecimentos); reintroduce; overload;
    destructor Destroy; override;

    property Recibo: String          read GetRecibo;
    property versao: String          read Fversao;
    property TpAmb: TpcnTipoAmbiente read FTpAmb;
    property verAplic: String        read FverAplic;
    property cStat: Integer          read FcStat;
    property cUF: Integer            read FcUF;
    property xMotivo: String         read FxMotivo;
    property dhRecbto: TDateTime     read FdhRecbto;
    property TMed: Integer           read FTMed;
    property Lote: String            read GetLote write FLote;
  end;

  { TCTeRetRecepcao }

  TCTeRetRecepcao = Class(TWebServicesBase)
  private
    FRecibo: String;
    FProtocolo: String;
    FChaveCTe: String;
    FConhecimentos: TConhecimentos;
    FCTeRetorno: TRetConsReciCTe;
    Fversao: String;
    FTpAmb: TpcnTipoAmbiente;
    FverAplic: String;
    FcStat: Integer;
    FcUF: Integer;
    FxMotivo: String;
    FcMsg: Integer;
    FxMsg: String;

    function GetRecibo: String;
    function TratarRespostaFinal: Boolean;
  protected
    procedure DefinirURL; override;
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    function TratarResposta: Boolean; override;
    procedure FinalizarServico; override;

    function GerarMsgLog: AnsiString; override;
    function GerarPrefixoArquivo: AnsiString; override;
  public
    constructor Create(AOwner: TComponent; AConhecimentos: TConhecimentos); reintroduce; overload;
    destructor Destroy; override;

    function Executar: Boolean; override;

    property versao: String              read Fversao;
    property TpAmb: TpcnTipoAmbiente     read FTpAmb;
    property verAplic: String            read FverAplic;
    property cStat: Integer              read FcStat;
    property cUF: Integer                read FcUF;
    property xMotivo: String             read FxMotivo;
    property cMsg: Integer               read FcMsg;
    property xMsg: String                read FxMsg;
    property Recibo: String              read GetRecibo  write FRecibo;
    property Protocolo: String           read FProtocolo write FProtocolo;
    property ChaveCTe: String            read FChaveCTe  write FChaveCTe;
    property CTeRetorno: TRetConsReciCTe read FCTeRetorno;
  end;

  { TCTeRecibo }

  TCTeRecibo = Class(TWebServicesBase)
  private
    FRecibo: String;
    FCTeRetorno: TRetConsReciCTe;
    Fversao: String;
    FTpAmb: TpcnTipoAmbiente;
    FverAplic: String;
    FcStat: Integer;
    FxMotivo: String;
    FcUF: Integer;
    FxMsg: String;
    FcMsg: Integer;
  protected
    procedure DefinirServicoEAction; override;
    procedure DefinirURL; override;
    procedure DefinirDadosMsg; override;
    function TratarResposta: Boolean; override;

    function GerarMsgLog: AnsiString; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property versao: String              read Fversao;
    property TpAmb: TpcnTipoAmbiente     read FTpAmb;
    property verAplic: String            read FverAplic;
    property cStat: Integer              read FcStat;
    property xMotivo: String             read FxMotivo;
    property cUF: Integer                read FcUF;
    property xMsg: String                read FxMsg;
    property cMsg: Integer               read FcMsg;
    property Recibo: String              read FRecibo write FRecibo;
    property CTeRetorno: TRetConsReciCTe read FCTeRetorno;
  end;

  { TCTeConsulta }

  TCTeConsulta = Class(TWebServicesBase)
  private
    FCTeChave: WideString;
    FProtocolo: WideString;
    FDhRecbto: TDateTime;
    FXMotivo: WideString;
    Fversao: String;
    FTpAmb: TpcnTipoAmbiente;
    FverAplic: String;
    FcStat: Integer;
    FcUF: Integer;
//    FdigVal: String;
    FprotCTe: TProcCTe;
    FretCancCTe: TRetCancCTe;
    FprocEventoCTe: TRetEventoCTeCollection;
  protected
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    function TratarResposta: Boolean; override;

    function GerarMsgLog: AnsiString; override;
    function GerarPrefixoArquivo: AnsiString; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property CTeChave: WideString                   read FCTeChave  write FCTeChave;
    property Protocolo: WideString                  read FProtocolo write FProtocolo;
    property DhRecbto: TDateTime                    read FDhRecbto  write FDhRecbto;
    property XMotivo: WideString                    read FXMotivo   write FXMotivo;
    property versao: String                         read Fversao;
    property TpAmb: TpcnTipoAmbiente                read FTpAmb;
    property verAplic: String                       read FverAplic;
    property cStat: Integer                         read FcStat;
    property cUF: Integer                           read FcUF;
//    property digVal: String                         read FdigVal;
    property protCTe: TProcCTe                      read FprotCTe;
    property retCancCTe: TRetCancCTe                read FretCancCTe;
    property procEventoCTe: TRetEventoCTeCollection read FprocEventoCTe;
  end;

  { TCTeInutilizacao }

  TCTeInutilizacao = Class(TWebServicesBase)
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
    FxMotivo: String;
    FcUF: Integer;
    FdhRecbto: TDateTime;
    FXML_ProcInutCTe: AnsiString;

    procedure SetJustificativa(AValue: WideString);
    function GerarPathPorCNPJ: String;
  protected
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    procedure SalvarEnvio; override;
    function TratarResposta: Boolean; override;
    procedure SalvarResposta; override;

    function GerarMsgLog: AnsiString; override;
    function GerarPrefixoArquivo: AnsiString; override;
  public
    constructor Create(AOwner: TComponent); override;

    property ID: WideString              read FID            write FID;
    property Protocolo: String           read FProtocolo     write FProtocolo;
    property Modelo: Integer             read FModelo        write FModelo;
    property Serie: Integer              read FSerie         write FSerie;
    property CNPJ: String                read FCNPJ          write FCNPJ;
    property Ano: Integer                read FAno           write FAno;
    property NumeroInicial: Integer      read FNumeroInicial write FNumeroInicial;
    property NumeroFinal: Integer        read FNumeroFinal   write FNumeroFinal;
    property Justificativa: WideString   read FJustificativa write SetJustificativa;
    property versao: String              read Fversao;
    property TpAmb: TpcnTipoAmbiente     read FTpAmb;
    property verAplic: String            read FverAplic;
    property cStat: Integer              read FcStat;
    property xMotivo: String             read FxMotivo;
    property cUF: Integer                read FcUF;
    property dhRecbto: TDateTime         read FdhRecbto;
    property XML_ProcInutCTe: AnsiString read FXML_ProcInutCTe write FXML_ProcInutCTe;
  end;

  { TCTeConsultaCadastro }

  TCTeConsultaCadastro = Class(TWebServicesBase)
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
    FRetConsCad: TRetConsCad;

    procedure SetCNPJ(const Value: String);
    procedure SetCPF(const Value: String);
    procedure SetIE(const Value: String);
  protected
    procedure DefinirURL; override;
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    function TratarResposta: Boolean; override;

    function GerarMsgLog: AnsiString; override;
    function GerarUFSoap:AnsiString; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property UF: String              read FUF   write FUF;
    property IE: String              read FIE   write SetIE;
    property CNPJ: String            read FCNPJ write SetCNPJ;
    property CPF: String             read FCPF  write SetCPF;
    property versao: String          read Fversao;
    property verAplic: String        read FverAplic;
    property cStat: Integer          read FcStat;
    property xMotivo: String         read FxMotivo;
    property DhCons: TDateTime       read FdhCons;
    property cUF: Integer            read FcUF;
    property RetConsCad: TRetConsCad read FRetConsCad;
  end;

  { TCTeEnvEvento }

  TCTeEnvEvento = Class(TWebServicesBase)
  private
    FidLote: Integer;
    Fversao: String;
    FEvento: TEventoCTe;
    FcStat: Integer;
    FxMotivo: String;
    FTpAmb: TpcnTipoAmbiente;
    FEventoRetorno: TRetEventoCTe;

    function GerarPathEvento: String;
  protected
    procedure DefinirURL; override;
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    procedure DefinirEnvelopeSoap; override;
    procedure SalvarEnvio; override;
    function TratarResposta: Boolean; override;
    procedure SalvarResposta; override;

    function GerarMsgLog: AnsiString; override;
    function GerarPrefixoArquivo: AnsiString; override;
  public
    constructor Create(AOwner: TComponent; AEvento: TEventoCTe); reintroduce; overload;
    destructor Destroy; override;

    property idLote: Integer              read FidLote write FidLote;
    property versao: String               read Fversao write Fversao;
    property cStat: Integer               read FcStat;
    property xMotivo: String              read FxMotivo;
    property TpAmb: TpcnTipoAmbiente      read FTpAmb;
    property EventoRetorno: TRetEventoCTe read FEventoRetorno;
  end;

  { TCTeEnvioWebService }

  TCTeEnvioWebService = Class(TWebServicesBase)
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

    function GerarMsgLog: AnsiString; override;
    function GerarMsgErro(E: Exception): AnsiString; override;
    function GerarVersaoDadosSoap: AnsiString; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Executar: Boolean; override;

    property XMLEnvio: String read FXMLEnvio write FXMLEnvio;
    property URLEnvio: String read FURLEnvio write FURLEnvio;
    property SoapActionEnvio: String read FSoapActionEnvio write FSoapActionEnvio;
  end;

  { TWebService }

  TWebServices = Class(TWebServicesBase)
  private
    FACBrCTe: TComponent;
    FStatusServico: TCTeStatusServico;
    FEnviar: TCTeRecepcao;
    FRetorno: TCTeRetRecepcao;
    FRecibo: TCTeRecibo;
    FConsulta: TCTeConsulta;
    FInutilizacao: TCTeInutilizacao;
    FConsultaCadastro: TCTeConsultaCadastro;
    FEnvEvento: TCTeEnvEvento;
    FEnvioWebService: TCTeEnvioWebService;
  public
    constructor Create(AFCTe: TComponent); reintroduce;
    destructor Destroy; override;
    function Envia(ALote: Integer): Boolean; overload;
    function Envia(ALote: String): Boolean; overload;
    procedure Inutiliza(CNPJ, AJustificativa: String; Ano, Modelo, Serie, NumeroInicial, NumeroFinal: Integer);
//  published
    property ACBrCTe: TComponent                    read FACBrCTe          write FACBrCTe;
    property StatusServico: TCTeStatusServico       read FStatusServico    write FStatusServico;
    property Enviar: TCTeRecepcao                   read FEnviar           write FEnviar;
    property Retorno: TCTeRetRecepcao               read FRetorno          write FRetorno;
    property Recibo: TCTeRecibo                     read FRecibo           write FRecibo;
    property Consulta: TCTeConsulta                 read FConsulta         write FConsulta;
    property Inutilizacao: TCTeInutilizacao         read FInutilizacao     write FInutilizacao;
    property ConsultaCadastro: TCTeConsultaCadastro read FConsultaCadastro write FConsultaCadastro;
    property EnvEvento: TCTeEnvEvento               read FEnvEvento        write FEnvEvento;
    property EnvioWebService: TCTeEnvioWebService   read FEnvioWebService  write FEnvioWebService;
  end;

implementation

uses
{$IFDEF ACBrCTeOpenSSL}
  ssl_openssl,
{$ENDIF}
  ACBrUtil, ACBrCTeUtil, ACBrCTe, ACBrDFeUtil,
  pcnGerador, pcteCabecalho, pcnLeitor,
  pcteConsStatServ, pcteRetConsStatServ, pcteConsCad, pcteConsSitCTe,
  pcteCancCTe, pcteInutCTe, pcteRetInutCTe;

{ TWebServicesBase }

constructor TWebServicesBase.Create(AOwner: TComponent);
begin
  FConfiguracoes := TACBrCTe( AOwner ).Configuracoes;
  FACBrCTe       := TACBrCTe( AOwner );
  FLayout        := LayCTeStatusServico;
  FStatus        := stCTeIdle;
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

procedure TWebServicesBase.AssinarXML(AXML: String; MsgErro: String);
begin
  {$IFDEF ACBrCTeOpenSSL}
   if not(CTeUtil.Assinar( AXML, FConfiguracoes.Certificados.Certificado,
                            FConfiguracoes.Certificados.Senha,
                            FDadosMsg, FMsg )) then
  {$ELSE}
   if not(CTeUtil.Assinar( AXML, FConfiguracoes.Certificados.GetCertificado,
                           FDadosMsg, FMsg )) then
  {$ENDIF}
   GerarException(MsgErro);
end;

{$IFDEF ACBrCTeOpenSSL}
 procedure TWebServicesBase.ConfiguraHTTP(HTTP: THTTPSend; Action: AnsiString);
 begin
   if FileExists(FConfiguracoes.Certificados.Certificado) then
     HTTP.Sock.SSL.PFXfile := FConfiguracoes.Certificados.Certificado
   else
     HTTP.Sock.SSL.PFX     := FConfiguracoes.Certificados.Certificado;

   HTTP.Sock.SSL.KeyPassword := FConfiguracoes.Certificados.Senha;

   HTTP.ProxyHost := FConfiguracoes.WebServices.ProxyHost;
   HTTP.ProxyPort := FConfiguracoes.WebServices.ProxyPort;
   HTTP.ProxyUser := FConfiguracoes.WebServices.ProxyUser;
   HTTP.ProxyPass := FConfiguracoes.WebServices.ProxyPass;

   if (pos('SCERECEPCAORFB',UpperCase(FURL)) <= 0) and
      (pos('SCECONSULTARFB',UpperCase(FURL)) <= 0) then
      HTTP.MimeType := 'application/soap+xml; charset=utf-8'
   else
      HTTP.MimeType := 'text/xml; charset=utf-8';

   HTTP.UserAgent := '';
   HTTP.Protocol := '1.1';
   HTTP.AddPortNumberToHost := False;
   HTTP.Headers.Add(Action);
 end;
{$ELSE}
 {$IFDEF SoapHTTP}
  procedure TWebServicesBase.ConfiguraReqResp( ReqResp: THTTPReqResp );
  begin
    if FConfiguracoes.WebServices.ProxyHost <> '' then
     begin
       ReqResp.Proxy    := FConfiguracoes.WebServices.ProxyHost + ':' +
                           FConfiguracoes.WebServices.ProxyPort;
       ReqResp.UserName := FConfiguracoes.WebServices.ProxyUser;
       ReqResp.Password := FConfiguracoes.WebServices.ProxyPass;
     end;
    ReqResp.OnBeforePost := OnBeforePost;
  end;

  procedure TWebServicesBase.OnBeforePost(const HTTPReqResp: THTTPReqResp;
    Data: Pointer);
  var
    Cert: ICertificate2;
    CertContext: ICertContext;
    PCertContext: Pointer;
    ContentHeader: string;
  begin
    Cert := FConfiguracoes.Certificados.GetCertificado;
    CertContext := Cert as ICertContext;
    CertContext.Get_CertContext(Integer(PCertContext));

    if not InternetSetOption(Data,
                             INTERNET_OPTION_CLIENT_CERT_CONTEXT,
                             PCertContext,
                             SizeOf(CERT_CONTEXT)) then
      GerarException('OnBeforePost: ' + IntToStr(GetLastError));

    if trim(FConfiguracoes.WebServices.ProxyUser) <> '' then
      if not InternetSetOption(Data,
                               INTERNET_OPTION_PROXY_USERNAME,
                               PChar(FConfiguracoes.WebServices.ProxyUser),
                               Length(FConfiguracoes.WebServices.ProxyUser)) then
        GerarException('OnBeforePost: ' + IntToStr(GetLastError));

    if trim(FConfiguracoes.WebServices.ProxyPass) <> '' then
      if not InternetSetOption(Data,
                               INTERNET_OPTION_PROXY_PASSWORD,
                               PChar(FConfiguracoes.WebServices.ProxyPass),
                               Length(FConfiguracoes.WebServices.ProxyPass)) then
        GerarException('OnBeforePost: ' + IntToStr(GetLastError));

    if (pos('SCERECEPCAORFB',UpperCase(FURL)) <= 0) and
       (pos('SCECONSULTARFB',UpperCase(FURL)) <= 0) then
    begin
       ContentHeader := Format(ContentTypeTemplate, ['application/soap+xml; charset=utf-8']);
       HttpAddRequestHeaders(Data,
                             PChar(ContentHeader),
                             Length(ContentHeader),
                             HTTP_ADDREQ_FLAG_REPLACE);
    end;

    HTTPReqResp.CheckContentType;
  end;
 {$ELSE}
  procedure TWebServicesBase.ConfiguraReqResp( ReqResp: TACBrHTTPReqResp );
  begin
    if FConfiguracoes.WebServices.ProxyHost <> '' then
    begin
      ReqResp.ProxyHost := FConfiguracoes.WebServices.ProxyHost;
      ReqResp.ProxyPort := FConfiguracoes.WebServices.ProxyPort;
      ReqResp.ProxyUser := FConfiguracoes.WebServices.ProxyUser;
      ReqResp.ProxyPass := FConfiguracoes.WebServices.ProxyPass;
    end;

    ReqResp.SetCertificate(FConfiguracoes.Certificados.GetCertificado);

    if (pos('SCERECEPCAORFB',UpperCase(FURL)) <= 0) and
       (pos('SCECONSULTARFB',UpperCase(FURL)) <= 0) then
      ReqResp.MimeType := 'application/soap+xml'
    else
      ReqResp.MimeType := 'text/xml';
  end;
 {$ENDIF}
{$ENDIF}

function TWebServicesBase.Executar: Boolean;
var
  ErroMsg: String;
begin
  { Sobrescrever apenas se realmente necessário }

  Result := False;

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
        ErroMsg := GerarMsgErro( E );
        GerarException( ErroMsg );
      end;
    end;
  finally
     FinalizarServico;
  end;
end;

procedure TWebServicesBase.InicializarServico;
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

  TACBrCTe( FACBrCTe ).SetStatus( FStatus );
end;

procedure TWebServicesBase.DefinirServicoEAction;
begin
  { sobrescrever, obrigatoriamente }

  FServico := '';
  FSoapAction := '';
end;

procedure TWebServicesBase.DefinirURL;
begin
  { sobrescrever apenas se necessário.
    Você também pode mudar apenas o valor de "FLayoutServico" na classe
    filha e chamar: Inherited;     }

  FURL := CTeUtil.GetURL( FConfiguracoes.WebServices.UFCodigo,
                          FConfiguracoes.WebServices.AmbienteCodigo,
                          FConfiguracoes.Geral.FormaEmissaoCodigo,
                          Layout );
end;

procedure TWebServicesBase.DefinirDadosMsg;
begin
  { sobrescrever, obrigatoriamente }

  FDadosMsg := '';
end;

procedure TWebServicesBase.DefinirEnvelopeSoap;
var
  Texto: AnsiString;
begin
  { Sobrescrever apenas se necessário }

  Texto := '<?xml version="1.0" encoding="utf-8"?>';
  Texto := Texto + '<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' +
                                   ' xmlns:xsd="http://www.w3.org/2001/XMLSchema"' +
                                   ' xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">';
  Texto := Texto +   '<soap12:Header>';
  Texto := Texto +     '<cteCabecMsg xmlns="' + Servico + '">';
  Texto := Texto +       GerarUFSoap;
  Texto := Texto +       GerarVersaoDadosSoap;
  Texto := Texto +     '</cteCabecMsg>';
  Texto := Texto +   '</soap12:Header>';
  Texto := Texto +   '<soap12:Body>';
  Texto := Texto +     '<cteDadosMsg xmlns="' + Servico + '">';
  Texto := Texto +       DadosMsg;
  Texto := Texto +     '</cteDadosMsg>';
  Texto := Texto +   '</soap12:Body>';
  Texto := Texto + '</soap12:Envelope>';

  FEnvelopeSoap := Texto;
end;

function TWebServicesBase.GerarUFSoap: AnsiString;
begin
  Result := '<cUF>' +
              IntToStr(FConfiguracoes.WebServices.UFCodigo) +
            '</cUF>';
end;

function TWebServicesBase.GerarVersaoDadosSoap: AnsiString;
begin
  { Sobrescrever apenas se necessário }

  Result := '<versaoDados>' +
              GetVersaoCTe(FConfiguracoes.Geral.VersaoDF, Layout) +
            '</versaoDados>';
end;

procedure TWebServicesBase.EnviarDados;
var
  {$IFDEF ACBrCTeOpenSSL}
   HTTP: THTTPSend;
   OK: Boolean;
  {$ELSE}
   Stream: TMemoryStream;
   StrStream: TStringStream;
   {$IFDEF SoapHTTP}
    ReqResp: THTTPReqResp;
   {$ELSE}
    ReqResp: TACBrHTTPReqResp;
   {$ENDIF}
  {$ENDIF}
begin
  { Sobrescrever apenas se necessário }
  
  FRetWS     := '';
  FRetornoWS := '';

  {$IFDEF ACBrCTeOpenSSL}
   HTTP := THTTPSend.Create;
  {$ELSE}
   {$IFDEF SoapHTTP}
    ReqResp := THTTPReqResp.Create(nil);
    ReqResp.UseUTF8InHeader := True;
   {$ELSE}
    ReqResp := TACBrHTTPReqResp.Create;
   {$ENDIF}
   ConfiguraReqResp( ReqResp );
   ReqResp.URL := URL;
   ReqResp.SoapAction := SoapAction;
  {$ENDIF}
  FEnvelopeSoap := UTF8Encode(FEnvelopeSoap);

  try
    {$IFDEF ACBrCTeOpenSSL}
     ConfiguraHTTP(HTTP, 'SOAPAction: "' + SoapAction + '"');
     HTTP.Document.WriteBuffer(FEnvelopeSoap[1], Length(FEnvelopeSoap));
     OK := HTTP.HTTPMethod('POST', URL);
     OK := OK and (HTTP.ResultCode = 200);
     if not OK then
       GerarException( 'Cod.Erro HTTP: ' +
                       IntToStr(HTTP.ResultCode) + ' ' +
                       HTTP.ResultString );

     // Lendo a resposta //
     HTTP.Document.Position := 0;
     SetLength(FRetornoWS, HTTP.Document.Size);
     HTTP.Document.ReadBuffer(FRetornoWS[1], HTTP.Document.Size);
    {$ELSE}
      {$IFDEF SoapHTTP}
        Stream := TMemoryStream.Create;
        StrStream := TStringStream.Create('');
        try
          ReqResp.Execute(FEnvelopeSoap, Stream);  // Dispara exceptions no caso de erro
          StrStream.CopyFrom(Stream, 0);
          FRetornoWS := StrStream.DataString;
        finally
          StrStream.Free;
          Stream.Free;
        end;
      {$ELSE}
        ReqResp.Data := FEnvelopeSoap;
        FRetornoWS := ReqResp.Execute;
      {$ENDIF}
    {$ENDIF}
    FRetornoWS := ParseText(FRetornoWS, True, True ); // Resposta sempre é UTF8
  finally
    {$IFDEF ACBrCTeOpenSSL}
     HTTP.Free;
    {$ELSE}
     ReqResp.Free;
    {$ENDIF}
  end;
end;

function TWebServicesBase.GerarPrefixoArquivo: AnsiString;
begin
  Result := FormatDateTime('yyyymmddhhnnss', Now);
end;

procedure TWebServicesBase.SalvarEnvio;
var
  Prefixo, ArqEnv: String;
begin
  { Sobrescrever apenas se necessário }

  if FArqEnv = '' then exit;

  Prefixo := GerarPrefixoArquivo;

  if FConfiguracoes.Geral.Salvar then
  begin
    ArqEnv := Prefixo + '-' + FArqEnv + '.xml';
    FConfiguracoes.Geral.Save(ArqEnv, FDadosMsg);
  end;

  if FConfiguracoes.WebServices.Salvar then
  begin
    ArqEnv := Prefixo + '-' + FArqEnv + '-soap.xml';
    FConfiguracoes.Geral.Save(ArqEnv, FEnvelopeSoap);
  end;
end;

procedure TWebServicesBase.SalvarResposta;
var
  Prefixo, ArqResp: String;
begin
  { Sobrescrever apenas se necessário }

  if FArqResp = '' then exit;

  Prefixo := GerarPrefixoArquivo;

  if FConfiguracoes.Geral.Salvar then
  begin
    ArqResp := Prefixo + '-' + FArqResp + '.xml';
    FConfiguracoes.Geral.Save(ArqResp, FRetWS);
  end;

  if FConfiguracoes.WebServices.Salvar then
  begin
    ArqResp := Prefixo + '-' + FArqResp + '-soap.xml';
    FConfiguracoes.Geral.Save(ArqResp, FRetornoWS );
  end;
end;

function TWebServicesBase.GerarMsgLog: AnsiString;
begin
  { sobrescrever, se quiser Logar }

  Result := '';
end;

function TWebServicesBase.TratarResposta: Boolean;
begin
  { sobrescrever, obrigatoriamente }
  
  Result := False;
end;

procedure TWebServicesBase.FazerLog(Msg: AnsiString; Exibir: Boolean);
begin
  if (Msg <> '') then
  begin
    if  Assigned(TACBrCTe( FACBrCTe ).OnGerarLog) then
      TACBrCTe( FACBrCTe ).OnGerarLog(Msg);

    if Exibir and FConfiguracoes.WebServices.Visualizar then
      ShowMessage(Msg);
  end;
end;

procedure TWebServicesBase.GerarException(Msg: AnsiString);
begin
  FazerLog( 'ERRO: ' + Msg, False );
  raise EACBrCTeException.Create( Msg );
end;

function TWebServicesBase.GerarMsgErro(E: Exception): AnsiString;
begin
  { Sobrescrever com mensagem adicional, se desejar }

  Result := E.Message;
end;

procedure TWebServicesBase.FinalizarServico;
begin
  { Sobrescrever apenas se necessário }

  TACBrCTe( FACBrCTe ).SetStatus( stCTeIdle );
  ConfAmbiente;
end;

{ TCTeStatusServico }

constructor TCTeStatusServico.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FStatus  := stCTeStatusServico;
  FLayout  := LayCTeStatusServico;
  FArqEnv  := 'ped-sta';
  FArqResp := 'sta';
end;

procedure TCTeStatusServico.DefinirServicoEAction;
begin
  FServico    := CURL_WSDL + 'CteStatusServico';
  FSoapAction := FServico + '/cteStatusServicoCT';
end;

procedure TCTeStatusServico.DefinirDadosMsg;
var
  ConsStatServ: TConsStatServ;
begin
  ConsStatServ := TConsStatServ.create;
  try
    ConsStatServ.TpAmb := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo - 1);
    ConsStatServ.CUF   := FConfiguracoes.WebServices.UFCodigo;

    ConsStatServ.GerarXML;

    // Atribuindo o XML para propriedade interna //
    FDadosMsg := ConsStatServ.Gerador.ArquivoFormatoXML;
  finally
    ConsStatServ.Free;
  end;
end;

function TCTeStatusServico.TratarResposta: Boolean;
var
  CTeRetorno: TRetConsStatServ;
begin
  FRetWS := SeparaDados(FRetornoWS, 'cteStatusServicoCTResult');

  CTeRetorno := TRetConsStatServ.Create;
  try
    CTeRetorno.Leitor.Arquivo := FRetWS;
    CTeRetorno.LerXml;

    Fversao    := CTeRetorno.versao;
    FtpAmb     := CTeRetorno.tpAmb;
    FverAplic  := CTeRetorno.verAplic;
    FcStat     := CTeRetorno.cStat;
    FxMotivo   := CTeRetorno.xMotivo;
    FcUF       := CTeRetorno.cUF;
    FdhRecbto  := CTeRetorno.dhRecbto;
    FTMed      := CTeRetorno.TMed;
    FdhRetorno := CTeRetorno.dhRetorno;
    FxObs      := CTeRetorno.xObs;
    FMsg       := FxMotivo + LineBreak + FxObs;

    if FConfiguracoes.WebServices.AjustaAguardaConsultaRet then
       FConfiguracoes.WebServices.AguardarConsultaRet := FTMed * 1000;

    Result := (FcStat = 107);

  finally
    CTeRetorno.Free;
  end;
end;

function TCTeStatusServico.GerarMsgLog: AnsiString;
begin
  Result := 'Versão Layout : '     + Fversao + LineBreak +
            'Ambiente : '          + TpAmbToStr(FtpAmb) + LineBreak +
            'Versão Aplicativo : ' + FverAplic + LineBreak +
            'Status Código : '     + IntToStr(FcStat) + LineBreak +
            'Status Descrição : '  + FxMotivo + LineBreak +
            'UF : '                + CodigoParaUF(FcUF) + LineBreak +
            'Recebimento : '       + SeSenao(FdhRecbto = 0,
                                                     '',
                                                     DateTimeToStr(FdhRecbto)) +
                                                     LineBreak +
            'Tempo Médio : '       + IntToStr(FTMed) + LineBreak +
            'Retorno : '           + SeSenao(FdhRetorno = 0,
                                                     '',
                                                     DateTimeToStr(FdhRetorno)) +
                                                     LineBreak +
            'Observação : '        + FxObs;
end;

function TCTeStatusServico.GerarMsgErro(E: Exception): AnsiString;
begin
  Result := 'WebService Consulta Status serviço:' + LineBreak +
            '- Inativo ou Inoperante tente novamente.' + LineBreak +
            '- ' + E.Message
end;

{ TCTeRecepcao }

constructor TCTeRecepcao.Create(AOwner: TComponent; AConhecimentos: TConhecimentos);
begin
  inherited Create(AOwner);
  
  FConhecimentos := AConhecimentos;

  FStatus  := stCTeRecepcao;
  FLayout  := LayCTeRecepcao;
  FArqEnv  := 'env-lot';
  FArqResp := 'rec';

  FCTeRetorno := nil;
end;

destructor TCTeRecepcao.Destroy;
begin
  if Assigned(FCTeRetorno) then
    FCTeRetorno.Free;

  inherited Destroy;
end;

function TCTeRecepcao.GetLote: String;
begin
  Result := Trim(FLote);
end;

function TCTeRecepcao.GetRecibo: String;
begin
  Result := Trim(FRecibo);
end;

procedure TCTeRecepcao.DefinirURL;
begin
  FLayout := LayCTeRecepcao;

  inherited DefinirURL;
end;

procedure TCTeRecepcao.DefinirServicoEAction;
begin
  FServico    := CURL_WSDL + 'CteRecepcao';
  FSoapAction := FServico + '/cteRecepcaoLote';
end;

procedure TCTeRecepcao.DefinirDadosMsg;
var
  I: Integer;
  vCTe: WideString;
  Versao: String;
begin
  Versao := GetVersaoCTe(FConfiguracoes.Geral.VersaoDF,
                         Layout);

  if FLote = '' then
    FLote := '0';

  vCTe := '';
  for I := 0 to FConhecimentos.Count-1 do
    vCTe := vCTe + '<CTe' +
                     RetornarConteudoEntre(FConhecimentos.Items[I].XML,
                                           '<CTe', '</CTe>') +
                   '</CTe>';

  FDadosMsg := '<enviCTe xmlns="http://www.portalfiscal.inf.br/cte" versao="' + Versao + '">'+
                 '<idLote>' +
                   FLote +
                 '</idLote>'+
                 vCTe +
               '</enviCTe>';

  // Lote tem mais de 500kb ? //
  if Length(FDadosMsg) > (500 * 1024) then
    GerarException('Tamanho do XML de Dados superior a 500 Kbytes. Tamanho atual: ' +
                   IntToStr(trunc(Length(FDadosMsg) / 1024)) + ' Kbytes');

  FRecibo := '';
end;

function TCTeRecepcao.TratarResposta: Boolean;
begin
  FRetWS := SeparaDados(FRetornoWS, 'cteRecepcaoLoteResult');

  FCTeRetorno := TretEnvCTe.Create;

  FCTeRetorno.Leitor.Arquivo := FRetWS;
  FCTeRetorno.LerXml;

  Fversao   := FCTeRetorno.versao;
  FTpAmb    := FCTeRetorno.TpAmb;
  FverAplic := FCTeRetorno.verAplic;
  FcStat    := FCTeRetorno.cStat;
  FxMotivo  := FCTeRetorno.xMotivo;
  FdhRecbto := FCTeRetorno.infRec.dhRecbto;
  FTMed     := FCTeRetorno.infRec.tMed;
  FcUF      := FCTeRetorno.cUF;
  FMsg      := FCTeRetorno.xMotivo;
  FRecibo   := FCTeRetorno.infRec.nRec;

  Result := (FCTeRetorno.CStat = 103);
end;

procedure TCTeRecepcao.FinalizarServico;
begin
  inherited FinalizarServico;

  if Assigned(FCTeRetorno) then
    FreeAndNil( FCTeRetorno );
end;

function TCTeRecepcao.GerarMsgLog: AnsiString;
begin
  if Assigned(FCTeRetorno) then
    Result := 'Versão Layout : '     + FCTeRetorno.versao + LineBreak +
              'Ambiente : '          + TpAmbToStr(FCTeRetorno.TpAmb) + LineBreak +
              'Versão Aplicativo : ' + FCTeRetorno.verAplic + LineBreak +
              'Status Código : '     + IntToStr(FCTeRetorno.cStat) + LineBreak +
              'Status Descrição : '  + FCTeRetorno.xMotivo + LineBreak +
              'UF : '                + CodigoParaUF(FCTeRetorno.cUF) + LineBreak +
              'Recibo : '            + FCTeRetorno.infRec.nRec + LineBreak +
              'Recebimento : '       + SeSenao(FCTeRetorno.InfRec.dhRecbto = 0,
                                                       '',
                                                       DateTimeToStr(FCTeRetorno.InfRec.dhRecbto)) +
                                                       LineBreak +
              'Tempo Médio : '       + IntToStr(FCTeRetorno.InfRec.TMed)
  else
    Result := '';
end;

function TCTeRecepcao.GerarPrefixoArquivo: AnsiString;
begin
  Result := Lote;
end;

{ TCTeRetRecepcao }

constructor TCTeRetRecepcao.Create(AOwner: TComponent; AConhecimentos: TConhecimentos);
begin
  inherited Create(AOwner);

  FCTeRetorno := TRetConsReciCTe.Create;

  FConhecimentos := AConhecimentos;

  FStatus  := stCTeRetRecepcao;
  FLayout  := LayCTeRetRecepcao;
  FArqEnv  := 'ped-rec';
  FArqResp := 'pro-rec';
end;

destructor TCTeRetRecepcao.Destroy;
begin
  FCTeRetorno.Free;
  inherited Destroy;
end;

function TCTeRetRecepcao.GetRecibo: String;
begin
  Result := Trim(FRecibo);
end;

function TCTeRetRecepcao.TratarRespostaFinal: Boolean;
var
  I, J: Integer;
  AProcCTe: TProcCTe;
  AInfProt: TProtCTeCollection;
  Data: TDateTime;
  NomeXML: String;
begin
  Result := False;

  AInfProt := FCTeRetorno.ProtCTe;

  if (AInfProt.Count > 0) then
  begin
    FMsg     := FCTeRetorno.ProtCTe.Items[0].xMotivo;
    FxMotivo := FCTeRetorno.ProtCTe.Items[0].xMotivo;
  end;

  //Setando os retornos das notas fiscais;
  for I := 0 to AInfProt.Count-1 do
  begin
    for J := 0 to FConhecimentos.Count-1 do
    begin
      if OnlyNumber(AInfProt.Items[I].chCTe) = OnlyNumber(FConhecimentos.Items[J].CTe.InfCTe.Id) then
      begin
        if (TACBrCTe( FACBrCTe ).Configuracoes.Geral.ValidarDigest ) and
           (FConhecimentos.Items[J].CTe.Signature.DigestValue <> AInfProt.Items[I].digVal) and
           (AInfProt.Items[I].digVal <> '') then
         begin
           raise EACBrCTeException.Create('DigestValue do documento '+
                                           OnlyNumber(FConhecimentos.Items[J].CTe.infCTe.Id)+
                                           ' não confere.');
         end;
        FConhecimentos.Items[J].Confirmada           := (AInfProt.Items[I].cStat in [100, 150]);
        FConhecimentos.Items[J].Msg                  := AInfProt.Items[I].xMotivo;
        FConhecimentos.Items[J].CTe.procCTe.tpAmb    := AInfProt.Items[I].tpAmb;
        FConhecimentos.Items[J].CTe.procCTe.verAplic := AInfProt.Items[I].verAplic;
        FConhecimentos.Items[J].CTe.procCTe.chCTe    := AInfProt.Items[I].chCTe;
        FConhecimentos.Items[J].CTe.procCTe.dhRecbto := AInfProt.Items[I].dhRecbto;
        FConhecimentos.Items[J].CTe.procCTe.nProt    := AInfProt.Items[I].nProt;
        FConhecimentos.Items[J].CTe.procCTe.digVal   := AInfProt.Items[I].digVal;
        FConhecimentos.Items[J].CTe.procCTe.cStat    := AInfProt.Items[I].cStat;
        FConhecimentos.Items[J].CTe.procCTe.xMotivo  := AInfProt.Items[I].xMotivo;

        NomeXML := '-cte.xml';
        if (AInfProt.Items[I].cStat = 110) or (AInfProt.Items[I].cStat = 301) then
          NomeXML := '-den.xml';

        if FConfiguracoes.Geral.Salvar or NaoEstaVazio(FConhecimentos.Items[J].NomeArq) then
        begin
          if FileExists(PathWithDelim(FConfiguracoes.Geral.PathSalvar) + AInfProt.Items[I].chCTe + '-cte.xml') and
             FileExists(PathWithDelim(FConfiguracoes.Geral.PathSalvar) + FCTeRetorno.nRec + '-pro-rec.xml') then
          begin
            AProcCTe := TProcCTe.Create;
            try
              AProcCTe.PathCTe := PathWithDelim(FConfiguracoes.Geral.PathSalvar) +
                                                AInfProt.Items[I].chCTe +
                                                '-cte.xml';
              AProcCTe.PathRetConsReciCTe := PathWithDelim(FConfiguracoes.Geral.PathSalvar) +
                                             FCTeRetorno.nRec +
                                             '-pro-rec.xml';

              AProcCTe.GerarXML;

              if NaoEstaVazio(AProcCTe.Gerador.ArquivoFormatoXML) then
              begin
                if NaoEstaVazio(FConhecimentos.Items[J].NomeArq) then
                  AProcCTe.Gerador.SalvarArquivo(FConhecimentos.Items[J].NomeArq)
                else
                  AProcCTe.Gerador.SalvarArquivo(PathWithDelim(FConfiguracoes.Geral.PathSalvar) +
                                                 AInfProt.Items[I].chCTe + NomeXML);
              end;
            finally
              AProcCTe.Free;
            end;
          end;
        end;

        if FConfiguracoes.Arquivos.Salvar then
        begin
          if FConfiguracoes.Arquivos.EmissaoPathCTe then
            Data := FConhecimentos.Items[J].CTe.Ide.dhEmi
          else
            Data := Now;

          if FConfiguracoes.Arquivos.SalvarApenasCTeProcessados then
           begin
             if CTeUtil.CstatProcessado(FConhecimentos.Items[J].CTe.procCTe.cStat) then
               FConhecimentos.Items[J].SaveToFile(PathWithDelim(
                     FConfiguracoes.Arquivos.GetPathCTe( Data,
                     FConhecimentos.Items[J].CTe.Emit.CNPJ)) +
                     OnlyNumber(FConhecimentos.Items[J].CTe.InfCTe.Id) + NomeXML);
           end
          else
            FConhecimentos.Items[J].SaveToFile(PathWithDelim(
                FConfiguracoes.Arquivos.GetPathCTe( Data,
                FConhecimentos.Items[J].CTe.Emit.CNPJ)) +
                OnlyNumber(FConhecimentos.Items[J].CTe.InfCTe.Id) + NomeXML);
        end;

        break;
      end;
    end;
  end;

  //Verificando se existe algum conhecimento confirmado
  for I := 0 to FConhecimentos.Count-1 do
  begin
    if FConhecimentos.Items[I].Confirmada then
    begin
      Result := True;
      break;
    end;
  end;

  //Verificando se existe algum conhecimento nao confirmado
  for I := 0 to FConhecimentos.Count-1 do
  begin
    if not FConhecimentos.Items[I].Confirmada then
    begin
      FMsg := 'Conhecimento(s) não confirmado(s):' + LineBreak;
      break;
    end;
  end;

  //Montando a mensagem de retorno para os conhecimentos nao confirmados
  for I := 0 to FConhecimentos.Count-1 do
  begin
    if not FConhecimentos.Items[I].Confirmada then
      FMsg:= FMsg + IntToStr(FConhecimentos.Items[I].CTe.Ide.nCT) + '->' +
                    FConhecimentos.Items[I].Msg + LineBreak;
  end;

  if AInfProt.Count > 0 then
  begin
     FChaveCTe  := AInfProt.Items[0].chCTe;
     FProtocolo := AInfProt.Items[0].nProt;
     FcStat     := AInfProt.Items[0].cStat;
  end;
end;

function TCTeRetRecepcao.Executar: Boolean;
var
  IntervaloTentativas, vCont, qTent: Integer;
begin
  Result := False;

  TACBrCTe( FACBrCTe ).SetStatus( stCTeRetRecepcao );
  try
    Sleep( FConfiguracoes.WebServices.AguardarConsultaRet );

    vCont := 1000;
    qTent := 0; // Inicializa o contador de tentativas
    IntervaloTentativas := FConfiguracoes.WebServices.IntervaloTentativas;

    while (inherited Executar) and
          (qTent < FConfiguracoes.WebServices.Tentativas) do
    begin
      Inc( qTent );

      if IntervaloTentativas > 0 then
        sleep( IntervaloTentativas )
      else
        Sleep( vCont );
    end;
  finally
    TACBrCTe( FACBrCTe ).SetStatus( stCTeIdle );
  end;

  if FCTeRetorno.CStat = 104 then  // Lote processado ?
    Result := TratarRespostaFinal;
end;

procedure TCTeRetRecepcao.DefinirURL;
begin
  FLayout := LayCTeRetRecepcao;

  inherited DefinirURL;
end;

procedure TCTeRetRecepcao.DefinirServicoEAction;
begin
  FServico    := CURL_WSDL + 'CteRetRecepcao';
  FSoapAction := FServico + '/cteRetRecepcao';
end;

procedure TCTeRetRecepcao.DefinirDadosMsg;
var
  ConsReciCTe: TConsReciCTe;
begin
  ConsReciCTe := TConsReciCTe.Create;
  try
    ConsReciCTe.tpAmb := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo - 1);
    ConsReciCTe.nRec  := FRecibo;

    ConsReciCTe.GerarXML;

    FDadosMsg := ConsReciCTe.Gerador.ArquivoFormatoXML;
  finally
    ConsReciCTe.Free;
  end;
end;

function TCTeRetRecepcao.TratarResposta: Boolean;
begin
  FRetWS := SeparaDados(FRetornoWS, 'cteRetRecepcaoResult');

  // Limpando variaveis internas
  FCTeRetorno.Free;
  FCTeRetorno := TRetConsReciCTe.Create;

  FCTeRetorno.Leitor.Arquivo := FRetWS;
  FCTeRetorno.LerXML;

  Fversao   := FCTeRetorno.versao;
  FTpAmb    := FCTeRetorno.TpAmb;
  FverAplic := FCTeRetorno.verAplic;
  FcStat    := FCTeRetorno.cStat;
  FcUF      := FCTeRetorno.cUF;
  FMsg      := FCTeRetorno.xMotivo;
  FxMotivo  := FCTeRetorno.xMotivo;
//  FcMsg     := FCTeRetorno.cMsg;
//  FxMsg     := FCTeRetorno.xMsg;

  Result := (FCTeRetorno.CStat = 105); // Lote em Processamento
end;

procedure TCTeRetRecepcao.FinalizarServico;
begin
  ConfAmbiente;
  // Não libera para stIdle... não ainda...;
end;

function TCTeRetRecepcao.GerarMsgLog: AnsiString;
begin
  Result := 'Versão Layout : '     + FCTeRetorno.versao + LineBreak +
            'Ambiente : '          + TpAmbToStr(FCTeRetorno.tpAmb) + LineBreak +
            'Versão Aplicativo : ' + FCTeRetorno.verAplic + LineBreak +
            'Recibo : '            + FCTeRetorno.nRec + LineBreak +
            'Status Código : '     + IntToStr(FCTeRetorno.cStat) + LineBreak +
            'Status Descrição : '  + FCTeRetorno.xMotivo + LineBreak +
            'UF : '                + CodigoParaUF(FCTeRetorno.cUF) + LineBreak {+
            'cMsg : '              + IntToStr(FCTeRetorno.cMsg) + LineBreak +
            'xMsg : '              + FCTeRetorno.xMsg};
end;

function TCTeRetRecepcao.GerarPrefixoArquivo: AnsiString;
begin
  Result := Recibo;
end;

{ TCTeRecibo }

constructor TCTeRecibo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FCTeRetorno := TRetConsReciCTe.Create;

  FStatus  := stCTeRecibo;
  FLayout  := LayCTeRetRecepcao;
  FArqEnv  := 'ped-rec';
  FArqResp := 'pro-rec';
end;

destructor TCTeRecibo.Destroy;
begin
  FCTeRetorno.Free;
  inherited Destroy;
end;

procedure TCTeRecibo.DefinirServicoEAction;
begin
  FServico    := CURL_WSDL + 'CteRetRecepcao';
  FSoapAction := FServico + '/cteRetRecepcao';
end;

procedure TCTeRecibo.DefinirURL;
begin
  FLayout := LayCTeRetRecepcao;

  inherited DefinirURL;
end;

procedure TCTeRecibo.DefinirDadosMsg;
var
  ConsReciCTe: TConsReciCTe;
begin
  ConsReciCTe := TConsReciCTe.Create;
  try
    ConsReciCTe.tpAmb := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo - 1);
    ConsReciCTe.nRec  := FRecibo;

    ConsReciCTe.GerarXML;

    FDadosMsg := ConsReciCTe.Gerador.ArquivoFormatoXML;
  finally
    ConsReciCTe.Free;
  end;
end;

function TCTeRecibo.TratarResposta: Boolean;
begin
  FRetWS := SeparaDados(FRetornoWS, 'cteRetRecepcaoResult');

  // Limpando variaveis internas
  FCTeRetorno.Free;
  FCTeRetorno := TRetConsReciCTe.Create;

  FCTeRetorno.Leitor.Arquivo := FRetWS;
  FCTeRetorno.LerXML;

  Fversao   := FCTeRetorno.versao;
  FTpAmb    := FCTeRetorno.TpAmb;
  FverAplic := FCTeRetorno.verAplic;
  FcStat    := FCTeRetorno.cStat;
  FxMotivo  := FCTeRetorno.xMotivo;
  FcUF      := FCTeRetorno.cUF;
//  FxMsg     := FCTeRetorno.xMsg;
//  FcMsg     := FCTeRetorno.cMsg;
  FMsg      := FxMotivo;

  Result := (FCTeRetorno.CStat = 104);
end;

function TCTeRecibo.GerarMsgLog: AnsiString;
begin
  Result := 'Versão Layout : '     + FCTeRetorno.versao + LineBreak +
            'Ambiente : '          + TpAmbToStr(FCTeRetorno.TpAmb) + LineBreak +
            'Versão Aplicativo : ' + FCTeRetorno.verAplic + LineBreak +
            'Recibo : '            + FCTeRetorno.nRec + LineBreak +
            'Status Código : '     + IntToStr(FCTeRetorno.cStat) + LineBreak +
            'Status Descrição : '  + FCTeRetorno.ProtCTe.Items[0].xMotivo + LineBreak +
            'UF : '                + CodigoParaUF(FCTeRetorno.cUF);
end;

{ TCTeConsulta }

constructor TCTeConsulta.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FprotCTe       := TProcCTe.Create;
  FretCancCTe    := TRetCancCTe.Create;
  FprocEventoCTe := TRetEventoCTeCollection.Create(AOwner);

  FStatus  := stCTeConsulta;
  FLayout  := LayCTeConsultaCT;
  FArqEnv  := 'ped-sit';
  FArqResp := 'sit';
end;

destructor TCTeConsulta.Destroy;
begin
  FprotCTe.Free;
  FretCancCTe.Free;
  if Assigned(FprocEventoCTe) then
    FprocEventoCTe.Free;

  Inherited Destroy;
end;

procedure TCTeConsulta.DefinirServicoEAction;
begin
  FServico    := CURL_WSDL + 'CteConsulta';
  FSoapAction := FServico + '/cteConsultaCT';
end;

procedure TCTeConsulta.DefinirDadosMsg;
var
  ConsSitCTe: TConsSitCTe;
begin
  ConsSitCTe := TConsSitCTe.Create;
  try
    ConsSitCTe.TpAmb := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo - 1);
    ConsSitCTe.chCTe := FCTeChave;

    ConsSitCTe.GerarXML;

    FDadosMsg := ConsSitCTe.Gerador.ArquivoFormatoXML;
  finally
    ConsSitCTe.Free;
  end;
end;

function TCTeConsulta.TratarResposta: Boolean;
var
  CTeRetorno: TRetConsSitCTe;
  CTCancelado, Atualiza: Boolean;
  aEventos, aMsg, NomeArquivo, aCTe, aCTeDFe, NomeXML: String;
  AProcCTe: TProcCTe;
  I, J, K, Inicio, Fim: Integer;
  Data: TDateTime;
  LocCTeW: TCTeW;
begin
  CTeRetorno := TRetConsSitCTe.Create;
  try
    FRetWS := SeparaDados(FRetornoWS, 'cteConsultaCTResult');

    CTeRetorno.Leitor.Arquivo := FRetWS;
    CTeRetorno.LerXML;

    CTCancelado := False;
    aEventos    := '';

    // <retConsSitCTe> - Retorno da consulta da situação do CT-e
    // Este é o status oficial do CT-e
    Fversao   := CTeRetorno.versao;
    FTpAmb    := CTeRetorno.TpAmb;
    FverAplic := CTeRetorno.verAplic;
    FcStat    := CTeRetorno.cStat;
    FxMotivo  := CTeRetorno.xMotivo;
    FcUF      := CTeRetorno.cUF;
    FCTeChave := CTeRetorno.chCTe;
    FMsg      := CTeRetorno.XMotivo;

    // Verifica se o conhecimento está cancelado pelo método antigo. Se estiver,
    // então CTCancelado será True e já atribui Protocolo, Data e Mensagem
    if CTeRetorno.retCancCTe.cStat > 0 then
    begin
      FretCancCTe.versao   := CTeRetorno.retCancCTe.versao;
      FretCancCTe.tpAmb    := CTeRetorno.retCancCTe.tpAmb;
      FretCancCTe.verAplic := CTeRetorno.retCancCTe.verAplic;
      FretCancCTe.cStat    := CTeRetorno.retCancCTe.cStat;
      FretCancCTe.xMotivo  := CTeRetorno.retCancCTe.xMotivo;
      FretCancCTe.cUF      := CTeRetorno.retCancCTe.cUF;
      FretCancCTe.chCTE    := CTeRetorno.retCancCTe.chCTE;
      FretCancCTe.dhRecbto := CTeRetorno.retCancCTe.dhRecbto;
      FretCancCTe.nProt    := CTeRetorno.retCancCTe.nProt;

      CTCancelado := True;
      FProtocolo  := CTeRetorno.retCancCTe.nProt;
      FDhRecbto   := CTeRetorno.retCancCTe.dhRecbto;
      FMsg        := CTeRetorno.xMotivo;
    end;

    // <protCTe> - Retorno dos dados do ENVIO do CT-e
    // Considerá-los apenas se não existir nenhum evento de cancelamento (110111)
    FprotCTe.PathCTe            := CTeRetorno.protCTe.PathCTe;
    FprotCTe.PathRetConsReciCTe := CTeRetorno.protCTe.PathRetConsReciCTe;
    FprotCTe.PathRetConsSitCTe  := CTeRetorno.protCTe.PathRetConsSitCTe;
    FprotCTe.tpAmb              := CTeRetorno.protCTe.tpAmb;
    FprotCTe.verAplic           := CTeRetorno.protCTe.verAplic;
    FprotCTe.chCTe              := CTeRetorno.protCTe.chCTe;
    FprotCTe.dhRecbto           := CTeRetorno.protCTe.dhRecbto;
    FprotCTe.nProt              := CTeRetorno.protCTe.nProt;
    FprotCTe.digVal             := CTeRetorno.protCTe.digVal;
    FprotCTe.cStat              := CTeRetorno.protCTe.cStat;
    FprotCTe.xMotivo            := CTeRetorno.protCTe.xMotivo;

    if Assigned(CTeRetorno.procEventoCTe) and (CTeRetorno.procEventoCTe.Count > 0) then
    begin
      aEventos := '=====================================================' +
                  LineBreak +
                  '================== Eventos da NF-e ==================' +
                  LineBreak +
                  '====================================================='+
                  LineBreak + '' + LineBreak +
                  'Quantidade total de eventos: ' +
                  IntToStr(CTeRetorno.procEventoCTe.Count);

      FprocEventoCTe.Clear;
      for I := 0 to CTeRetorno.procEventoCTe.Count - 1 do
      begin
        FprocEventoCTe.Add;
        FprocEventoCTe.Items[I].RetEventoCTe.idLote   := CTeRetorno.procEventoCTe.Items[I].RetEventoCTe.idLote;
        FprocEventoCTe.Items[I].RetEventoCTe.tpAmb    := CTeRetorno.procEventoCTe.Items[I].RetEventoCTe.tpAmb;
        FprocEventoCTe.Items[I].RetEventoCTe.verAplic := CTeRetorno.procEventoCTe.Items[I].RetEventoCTe.verAplic;
        FprocEventoCTe.Items[I].RetEventoCTe.cOrgao   := CTeRetorno.procEventoCTe.Items[I].RetEventoCTe.cOrgao;
        FprocEventoCTe.Items[I].RetEventoCTe.cStat    := CTeRetorno.procEventoCTe.Items[I].RetEventoCTe.cStat;
        FprocEventoCTe.Items[I].RetEventoCTe.xMotivo  := CTeRetorno.procEventoCTe.Items[I].RetEventoCTe.xMotivo;
        FprocEventoCTe.Items[I].RetEventoCTe.XML      := CTeRetorno.procEventoCTe.Items[I].RetEventoCTe.XML;

        FprocEventoCTe.Items[I].RetEventoCTe.Infevento.ID                 := CTeRetorno.procEventoCTe.Items[I].RetEventoCTe.InfEvento.ID;
        FprocEventoCTe.Items[I].RetEventoCTe.Infevento.tpAmb              := CTeRetorno.procEventoCTe.Items[I].RetEventoCTe.InfEvento.tpAmb;
        FprocEventoCTe.Items[I].RetEventoCTe.InfEvento.CNPJ               := CTeRetorno.procEventoCTe.Items[I].RetEventoCTe.InfEvento.CNPJ;
        FprocEventoCTe.Items[I].RetEventoCTe.InfEvento.chCTe              := CTeRetorno.procEventoCTe.Items[I].RetEventoCTe.InfEvento.chCTe;
        FprocEventoCTe.Items[I].RetEventoCTe.InfEvento.dhEvento           := CTeRetorno.procEventoCTe.Items[I].RetEventoCTe.InfEvento.dhEvento;
        FprocEventoCTe.Items[I].RetEventoCTe.InfEvento.TpEvento           := CTeRetorno.procEventoCTe.Items[I].RetEventoCTe.InfEvento.TpEvento;
        FprocEventoCTe.Items[I].RetEventoCTe.InfEvento.nSeqEvento         := CTeRetorno.procEventoCTe.Items[I].RetEventoCTe.InfEvento.nSeqEvento;
        FprocEventoCTe.Items[I].RetEventoCTe.InfEvento.VersaoEvento       := CTeRetorno.procEventoCTe.Items[I].RetEventoCTe.InfEvento.VersaoEvento;
        FprocEventoCTe.Items[I].RetEventoCTe.InfEvento.DetEvento.nProt    := CTeRetorno.procEventoCTe.Items[I].RetEventoCTe.InfEvento.DetEvento.nProt;
        FprocEventoCTe.Items[I].RetEventoCTe.InfEvento.DetEvento.xJust    := CTeRetorno.procEventoCTe.Items[I].RetEventoCTe.InfEvento.DetEvento.xJust;
        FprocEventoCTe.Items[I].RetEventoCTe.InfEvento.DetEvento.xCondUso := CTeRetorno.procEventoCTe.Items[I].RetEventoCTe.InfEvento.DetEvento.xCondUso;

        FprocEventoCTe.Items[I].RetEventoCTe.InfEvento.DetEvento.infCorrecao.Clear;
        for k := 0 to CTeRetorno.procEventoCTe.Items[I].RetEventoCTe.InfEvento.detEvento.infCorrecao.Count -1 do
        begin
          FprocEventoCTe.Items[I].RetEventoCTe.InfEvento.DetEvento.infCorrecao.Add;
          FprocEventoCTe.Items[I].RetEventoCTe.InfEvento.DetEvento.infCorrecao.Items[k].grupoAlterado   := CTeRetorno.procEventoCTe.Items[I].RetEventoCTe.InfEvento.DetEvento.infCorrecao.Items[k].grupoAlterado;
          FprocEventoCTe.Items[I].RetEventoCTe.InfEvento.DetEvento.infCorrecao.Items[k].campoAlterado   := CTeRetorno.procEventoCTe.Items[I].RetEventoCTe.InfEvento.DetEvento.infCorrecao.Items[k].campoAlterado;
          FprocEventoCTe.Items[I].RetEventoCTe.InfEvento.DetEvento.infCorrecao.Items[k].valorAlterado   := CTeRetorno.procEventoCTe.Items[I].RetEventoCTe.InfEvento.DetEvento.infCorrecao.Items[k].valorAlterado;
          FprocEventoCTe.Items[I].RetEventoCTe.InfEvento.DetEvento.infCorrecao.Items[k].nroItemAlterado := CTeRetorno.procEventoCTe.Items[I].RetEventoCTe.InfEvento.DetEvento.infCorrecao.Items[k].nroItemAlterado;
        end;

        FprocEventoCTe.Items[I].RetEventoCTe.retEvento.Clear;
        for J := 0 to CTeRetorno.procEventoCTe.Items[I].RetEventoCTe.retEvento.Count - 1 do
        begin
          FprocEventoCTe.Items[I].RetEventoCTe.retEvento.Add;
          FprocEventoCTe.Items[I].RetEventoCTe.retEvento.Items[j].RetInfEvento.Id          := CTeRetorno.procEventoCTe.Items[I].RetEventoCTe.retEvento.Items[j].RetInfEvento.Id;
          FprocEventoCTe.Items[I].RetEventoCTe.retEvento.Items[j].RetInfEvento.tpAmb       := CTeRetorno.procEventoCTe.Items[I].RetEventoCTe.retEvento.Items[j].RetInfEvento.tpAmb;
          FprocEventoCTe.Items[I].RetEventoCTe.retEvento.Items[j].RetInfEvento.verAplic    := CTeRetorno.procEventoCTe.Items[I].RetEventoCTe.retEvento.Items[j].RetInfEvento.verAplic;
          FprocEventoCTe.Items[I].RetEventoCTe.retEvento.Items[j].RetInfEvento.cOrgao      := CTeRetorno.procEventoCTe.Items[I].RetEventoCTe.retEvento.Items[j].RetInfEvento.cOrgao;
          FprocEventoCTe.Items[I].RetEventoCTe.retEvento.Items[j].RetInfEvento.cStat       := CTeRetorno.procEventoCTe.Items[I].RetEventoCTe.retEvento.Items[j].RetInfEvento.cStat;
          FprocEventoCTe.Items[I].RetEventoCTe.retEvento.Items[j].RetInfEvento.xMotivo     := CTeRetorno.procEventoCTe.Items[I].RetEventoCTe.retEvento.Items[j].RetInfEvento.xMotivo;
          FprocEventoCTe.Items[I].RetEventoCTe.retEvento.Items[j].RetInfEvento.chCTe       := CTeRetorno.procEventoCTe.Items[I].RetEventoCTe.retEvento.Items[j].RetInfEvento.chCTe;
          FprocEventoCTe.Items[I].RetEventoCTe.retEvento.Items[j].RetInfEvento.tpEvento    := CTeRetorno.procEventoCTe.Items[I].RetEventoCTe.retEvento.Items[j].RetInfEvento.tpEvento;
          FprocEventoCTe.Items[I].RetEventoCTe.retEvento.Items[j].RetInfEvento.xEvento     := CTeRetorno.procEventoCTe.Items[I].RetEventoCTe.retEvento.Items[j].RetInfEvento.xEvento;
          FprocEventoCTe.Items[I].RetEventoCTe.retEvento.Items[j].RetInfEvento.nSeqEvento  := CTeRetorno.procEventoCTe.Items[I].RetEventoCTe.retEvento.Items[j].RetInfEvento.nSeqEvento;
          FprocEventoCTe.Items[I].RetEventoCTe.retEvento.Items[j].RetInfEvento.CNPJDest    := CTeRetorno.procEventoCTe.Items[I].RetEventoCTe.retEvento.Items[j].RetInfEvento.CNPJDest;
          FprocEventoCTe.Items[I].RetEventoCTe.retEvento.Items[j].RetInfEvento.emailDest   := CTeRetorno.procEventoCTe.Items[I].RetEventoCTe.retEvento.Items[j].RetInfEvento.emailDest;
          FprocEventoCTe.Items[I].RetEventoCTe.retEvento.Items[j].RetInfEvento.dhRegEvento := CTeRetorno.procEventoCTe.Items[I].RetEventoCTe.retEvento.Items[j].RetInfEvento.dhRegEvento;
          FprocEventoCTe.Items[I].RetEventoCTe.retEvento.Items[j].RetInfEvento.nProt       := CTeRetorno.procEventoCTe.Items[I].RetEventoCTe.retEvento.Items[j].RetInfEvento.nProt;
          FprocEventoCTe.Items[I].RetEventoCTe.retEvento.Items[j].RetInfEvento.XML         := CTeRetorno.procEventoCTe.Items[I].RetEventoCTe.retEvento.Items[j].RetInfEvento.XML;

          aEventos := aEventos + LineBreak + LineBreak +
                      'Número de sequência: ' + IntToStr(CTeRetorno.procEventoCTe.Items[I].RetEventoCTe.InfEvento.nSeqEvento) + LineBreak +
                      'Código do evento: '    + TpEventoToStr(CTeRetorno.procEventoCTe.Items[I].RetEventoCTe.InfEvento.TpEvento) + LineBreak +
                      'Descrição do evento: ' + ACBrStrToAnsi(CTeRetorno.procEventoCTe.Items[I].RetEventoCTe.InfEvento.DescEvento) + LineBreak +
                      'Status do evento: '    + IntToStr(CTeRetorno.procEventoCTe.Items[I].RetEventoCTe.retEvento.Items[J].RetInfEvento.cStat) + LineBreak +
                      'Descrição do status: ' + ACBrStrToAnsi(CTeRetorno.procEventoCTe.Items[I].RetEventoCTe.retEvento.Items[J].RetInfEvento.xMotivo) + LineBreak +
                      'Protocolo: '           + CTeRetorno.procEventoCTe.Items[I].RetEventoCTe.retEvento.Items[J].RetInfEvento.nProt + LineBreak +
                      'Data / hora do registro: ' + DateTimeToStr(CTeRetorno.procEventoCTe.Items[I].RetEventoCTe.retEvento.Items[J].RetInfEvento.dhRegEvento);

          if CTeRetorno.procEventoCTe.Items[I].RetEventoCTe.retEvento.Items[J].RetInfEvento.tpEvento = teCancelamento then
          begin
            CTCancelado := True;
            FProtocolo  := CTeRetorno.procEventoCTe.Items[I].RetEventoCTe.retEvento.Items[J].RetInfEvento.nProt;
            FDhRecbto   := CTeRetorno.procEventoCTe.Items[I].RetEventoCTe.retEvento.Items[J].RetInfEvento.dhRegEvento;
            FMsg        := CTeRetorno.procEventoCTe.Items[I].RetEventoCTe.retEvento.Items[J].RetInfEvento.xMotivo;
          end;
        end;
      end;
    end;

    if not CTCancelado then
    begin
      FProtocolo := CTeRetorno.protCTe.nProt;
      FDhRecbto  := CTeRetorno.protCTe.dhRecbto;
      FMsg       := CTeRetorno.protCTe.xMotivo;
    end;

    aMsg := GerarMsgLog;
    if aEventos <> '' then
      aMsg := aMsg + sLineBreak + aEventos;

    Result := (CTeRetorno.CStat in [100, 101, 110, 150, 151, 155]);

    NomeArquivo := PathWithDelim(FConfiguracoes.Geral.PathSalvar) + FCTeChave;

    for i:= 0 to TACBrCTe( FACBrCTe ).Conhecimentos.Count - 1 do
    begin
      if OnlyNumber(FCTeChave) = OnlyNumber(TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].CTe.infCTe.Id) then
//      if pos(String(FCTeChave), TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].CTe.infCTe.ID) > 0 then
      begin
        Atualiza := True;
        if ((CTeRetorno.CStat in [101, 151, 155]) and
           (not FConfiguracoes.Geral.AtualizarXMLCancelado)) then
          Atualiza := False;

        TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].Confirmada := (CTeRetorno.cStat in [100, 150]);
        if Atualiza then
        begin
          if (TACBrCTe( FACBrCTe ).Configuracoes.Geral.ValidarDigest ) and
             (TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].CTe.Signature.DigestValue <> CTeRetorno.protCTe.digVal) and
             (CTeRetorno.protCTe.digVal <> '') then
           begin
             raise EACBrCTeException.Create('DigestValue do documento '+
                                             OnlyNumber(TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].CTe.infCTe.Id)+
                                             ' não confere.');
           end;
         {$IFDEF PL_200}
          TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].Msg                  := CTeRetorno.protCTe.xMotivo;
          TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].CTe.procCTe.Id       := CTeRetorno.protCTe.Id;
          TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].CTe.procCTe.tpAmb    := CTeRetorno.protCTe.tpAmb;
          TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].CTe.procCTe.verAplic := CTeRetorno.protCTe.verAplic;
          TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].CTe.procCTe.chCTe    := FCTeChave;
          TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].CTe.procCTe.dhRecbto := CTeRetorno.protCTe.dhRecbto;
          TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].CTe.procCTe.nProt    := CTeRetorno.protCTe.nProt;
          TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].CTe.procCTe.digVal   := CTeRetorno.protCTe.digVal;
          TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].CTe.procCTe.cStat    := CTeRetorno.protCTe.cStat;
          TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].CTe.procCTe.xMotivo  := CTeRetorno.protCTe.xMotivo;
         {$ELSE}
          TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].Msg                  := CTeRetorno.xMotivo;
          TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].CTe.procCTe.tpAmb    := CTeRetorno.tpAmb;
          TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].CTe.procCTe.verAplic := CTeRetorno.protCTe.verAplic;
          TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].CTe.procCTe.chCTe    := FCTeChave;
          TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].CTe.procCTe.dhRecbto := FDhRecbto;
          TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].CTe.procCTe.nProt    := FProtocolo;
          TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].CTe.procCTe.digVal   := CTeRetorno.protCTe.digVal;
          TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].CTe.procCTe.cStat    := CTeRetorno.cStat;
          TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].CTe.procCTe.xMotivo  := CTeRetorno.xMotivo;
        {$ENDIF}

          NomeXML := '-cte.xml';
          if (CTeRetorno.protCTe.cStat = 110) or (CTeRetorno.protCTe.cStat = 301) then
            NomeXML := '-den.xml';

          if FileExists(NomeArquivo + '-cte.xml') or
              NaoEstaVazio(TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].NomeArq) then
          begin
            AProcCTe := TProcCTe.Create;
            try
              if NaoEstaVazio(TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].NomeArq) then
                AProcCTe.PathCTe := TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].NomeArq
              else
                AProcCTe.PathCTe := NomeArquivo + '-cte.xml';

              AProcCTe.PathRetConsSitCTe := NomeArquivo + '-sit.xml';

              AProcCTe.GerarXML;

              aCTe := AProcCTe.Gerador.ArquivoFormatoXML;

              if NaoEstaVazio(AProcCTe.Gerador.ArquivoFormatoXML) then
                AProcCTe.Gerador.SalvarArquivo(AProcCTe.PathCTe);

              FRetCTeDFe := '';

              if (NaoEstaVazio(aCTe)) and (NaoEstaVazio(SeparaDados(FRetWS, 'procEventoCTe'))) then
              begin
                Inicio := Pos('<procEventoCTe', FRetWS);
                Fim    := Pos('</retConsSitCTe', FRetWS) -1;

                aEventos := Copy(FRetWS, Inicio, Fim - Inicio + 1);

                aCTeDFe := '<?xml version="1.0" encoding="UTF-8" ?>' +
                           '<CTeDFe>' +
                            '<procCTe versao="' + CTeenviCTe + '">' +
                              SeparaDados(aCTe, 'cteProc') +
                            '</procCTe>' +
                            '<procEventoCTe versao="' + CTeEventoCTe + '">' +
                              aEventos +
                            '</procEventoCTe>' +
                           '</CTeDFe>';

                FRetCTeDFe := aCTeDFe;
              end;
            finally
              AProcCTe.Free;
            end;
          end
          else begin
           LocCTeW := TCTeW.Create(TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].CTe);
           try
             LocCTeW.GerarXML;

             aCTe := LocCTeW.Gerador.ArquivoFormatoXML;

             FRetCTeDFe := '';

             if (NaoEstaVazio(aCTe)) and (NaoEstaVazio(SeparaDados(FRetWS, 'procEventoCTe'))) then
              begin
                Inicio := Pos('<procEventoCTe', FRetWS);
                Fim    := Pos('</retConsSitCTe', FRetWS) -1;

                aEventos := Copy(FRetWS, Inicio, Fim - Inicio + 1);

                aCTeDFe := '<?xml version="1.0" encoding="UTF-8" ?>' +
                           '<CTeDFe>' +
                            '<procCTe versao="' + CTeenviCTe + '">' +
                              SeparaDados(aCTe, 'cteProc') +
                            '</procCTe>' +
                            '<procEventoCTe versao="' + CTeEventoCTe + '">' +
                              aEventos +
                            '</procEventoCTe>' +
                           '</CTeDFe>';

                FRetCTeDFe := aCTeDFe;
              end;
           finally
             LocCTeW.Free;
           end;
          end;

          if FConfiguracoes.Arquivos.Salvar then
          begin
            if FConfiguracoes.Arquivos.EmissaoPathCTe then
              Data := TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].CTe.Ide.dhEmi
            else
              Data := Now;

            if FConfiguracoes.Arquivos.SalvarApenasCTeProcessados then
             begin
               if CTeUtil.CstatProcessado(TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].CTe.procCTe.cStat) then
                 TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].SaveToFile(
                      PathWithDelim(FConfiguracoes.Arquivos.GetPathCTe(Data,
                      TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].CTe.Emit.CNPJ)) +
                      OnlyNumber(TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].CTe.InfCTe.Id) + NomeXML);
             end
            else
               TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].SaveToFile(
                   PathWithDelim(FConfiguracoes.Arquivos.GetPathCTe(Data,
                   TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].CTe.Emit.CNPJ)) +
                   OnlyNumber(TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].CTe.InfCTe.Id) + NomeXML);
          end;

          if FConfiguracoes.Arquivos.Salvar and (FRetCTeDFe <> '') then
          begin
            if FConfiguracoes.Arquivos.EmissaoPathCTe then
              Data := TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].CTe.Ide.dhEmi
            else
              Data := Now;

            FConfiguracoes.Geral.Save(FCTeChave + '-CTeDFe.xml',
                                      aCTeDFe,
                                      PathWithDelim(FConfiguracoes.Arquivos.GetPathCTe(Data)));
          end;
        end;

        break;
      end;
    end;

    if (TACBrCTe( FACBrCTe ).Conhecimentos.Count <= 0) then
    begin
      if FConfiguracoes.Geral.Salvar then
      begin
        if FileExists(NomeArquivo + '-cte.xml') then
        begin
          AProcCTe := TProcCTe.Create;
          try
            AProcCTe.PathCTe := NomeArquivo + '-cte.xml';
            AProcCTe.PathRetConsSitCTe := NomeArquivo + '-sit.xml';

            AProcCTe.GerarXML;

            aCTe := AProcCTe.Gerador.ArquivoFormatoXML;

            if NaoEstaVazio(AProcCTe.Gerador.ArquivoFormatoXML) then
              AProcCTe.Gerador.SalvarArquivo(AProcCTe.PathCTe);

            if (NaoEstaVazio(aCTe)) and (NaoEstaVazio(SeparaDados(FRetWS, 'procEventoCTe'))) then
            begin
              Inicio := Pos('<procEventoCTe', FRetWS);
              Fim    := Pos('</retConsSitCTe', FRetWS) -1;

              aEventos := Copy(FRetWS, Inicio, Fim - Inicio + 1);

              aCTeDFe := '<?xml version="1.0" encoding="UTF-8" ?>' +
                         '<CTeDFe>' +
                          '<procCTe versao="' + CTeenviCTe + '">' +
                            SeparaDados(aCTe, 'cteProc') +
                          '</procCTe>' +
                          '<procEventoCTe versao="' + CTeEventoCTe + '">' +
                            aEventos +
                          '</procEventoCTe>' +
                         '</CTeDFe>';

              FRetCTeDFe := aCTeDFe;
            end;
          finally
            AProcCTe.Free;
          end;
        end;

       if (FConfiguracoes.Arquivos.Salvar) and (FRetCTeDFe <> '') then
       begin
         if FConfiguracoes.Arquivos.EmissaoPathCTe then
           Data := TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].CTe.Ide.dhEmi
         else
           Data := Now;

         FConfiguracoes.Geral.Save(FCTeChave + '-CTeDFe.xml',
                                   aCTeDFe,
                                   PathWithDelim(FConfiguracoes.Arquivos.GetPathCTe(Data)));
       end;
      end;
    end;
  finally
    CTeRetorno.Free;
  end;
end;

function TCTeConsulta.GerarMsgLog: AnsiString;
begin
  Result := 'Versão Layout : '     + Fversao + LineBreak +
            'Identificador : '     + FCTeChave + LineBreak +
            'Ambiente : '          + TpAmbToStr(FTpAmb) + LineBreak +
            'Versão Aplicativo : ' + FverAplic + LineBreak +
            'Status Código : '     + IntToStr(FcStat) + LineBreak +
            'Status Descrição : '  + FXMotivo + LineBreak +
            'UF : '                + CodigoParaUF(FcUF) + LineBreak +
            'Chave Acesso : '      + FCTeChave + LineBreak +
            'Recebimento : '       + DateTimeToStr(FDhRecbto) + LineBreak +
            'Protocolo : '         + FProtocolo + LineBreak +
            'Digest Value : '      + FprotCTe.digVal;
end;

function TCTeConsulta.GerarPrefixoArquivo: AnsiString;
begin
  Result := Trim( FCTeChave );
end;

{ TCTeInutilizacao }

constructor TCTeInutilizacao.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FStatus  := stCTeInutilizacao;
  FLayout  := LayCTeInutilizacao;
  FArqEnv  := 'ped-inu';
  FArqResp := 'inu';
end;

procedure TCTeInutilizacao.SetJustificativa(AValue: WideString);
begin
  if EstaVazio(AValue) then
    GerarException('Informar uma Justificativa para Inutilização de numeração do Conhecimento de Transporte Eletrônico')
  else
    AValue := TrataString(AValue);

  if Length(Trim(AValue)) < 15 then
    GerarException('A Justificativa para Inutilização de numeração do Conhecimento de Transporte Eletrônico deve ter no minimo 15 caracteres')
  else
    FJustificativa := Trim(AValue);
end;

function TCTeInutilizacao.GerarPathPorCNPJ(): String;
var
  CNPJ: String;
begin
  if FConfiguracoes.Arquivos.SepararPorCNPJ then
    CNPJ := FCNPJ
  else
    CNPJ := '';

  Result := FConfiguracoes.Arquivos.GetPathInu( 0, CNPJ );
end;

procedure TCTeInutilizacao.DefinirServicoEAction;
begin
  FServico    := CURL_WSDL + 'CteInutilizacao';
  FSoapAction := FServico + '/cteInutilizacaoCT';
end;

procedure TCTeInutilizacao.DefinirDadosMsg;
var
  InutCTe: TinutCTe;
begin
  InutCTe := TinutCTe.Create;
  try
    InutCTe.tpAmb  := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo - 1);
    InutCTe.cUF    := FConfiguracoes.WebServices.UFCodigo;
    InutCTe.ano    := FAno;
    InutCTe.CNPJ   := FCNPJ;
    InutCTe.modelo := FModelo;
    InutCTe.serie  := FSerie;
    InutCTe.nCTIni := FNumeroInicial;
    InutCTe.nCTFin := FNumeroFinal;
    InutCTe.xJust  := FJustificativa;

    InutCTe.GerarXML;

    AssinarXML( InutCTe.Gerador.ArquivoFormatoXML,
                'Falha ao assinar Inutilização do Conhecimento de Transporte Eletrônico ' +
                LineBreak + FMsg );

    FID := InutCTe.ID;
  finally
    InutCTe.Free;
  end;
end;

procedure TCTeInutilizacao.SalvarEnvio;
var
  aPath: String;
begin
  inherited SalvarEnvio;

//  if FConfiguracoes.Arquivos.Salvar then
  if FConfiguracoes.Geral.Salvar then
  begin
    aPath := GerarPathPorCNPJ;
    FConfiguracoes.Geral.Save(GerarPrefixoArquivo + '-' + ArqEnv + '.xml',
                              FDadosMsg, aPath);
  end;
end;

procedure TCTeInutilizacao.SalvarResposta;
var
  aPath: String;
begin
  inherited SalvarResposta;

//  if FConfiguracoes.Arquivos.Salvar then
  if FConfiguracoes.Geral.Salvar then
  begin
    aPath := GerarPathPorCNPJ;
    FConfiguracoes.Geral.Save(GerarPrefixoArquivo + '-' + ArqResp + '.xml',
                              FRetWS, aPath);
  end;
end;

function TCTeInutilizacao.TratarResposta: Boolean;
var
  CTeRetorno: TRetInutCTe;
  wProc: TStringList;
begin
  CTeRetorno := TRetInutCTe.Create;
  try
    FRetWS := SeparaDados(FRetornoWS, 'cteInutilizacaoCTResult');

    CTeRetorno.Leitor.Arquivo := FRetWS;
    CTeRetorno.LerXml;

    Fversao    := CTeRetorno.versao;
    FTpAmb     := CTeRetorno.TpAmb;
    FverAplic  := CTeRetorno.verAplic;
    FcStat     := CTeRetorno.cStat;
    FxMotivo   := CTeRetorno.xMotivo;
    FcUF       := CTeRetorno.cUF;
    FdhRecbto  := CTeRetorno.dhRecbto;
    Fprotocolo := CTeRetorno.nProt;
    FMsg       := CTeRetorno.XMotivo;

    Result := (CTeRetorno.cStat = 102);

    //gerar arquivo proc de inutilizacao
    if ((CTeRetorno.cStat = 102) or (CTeRetorno.cStat = 563)) then
    begin
      wProc := TStringList.Create;
      try
        wProc.Add('<?xml version="1.0" encoding="UTF-8" ?>');
        wProc.Add('<ProcInutCTe versao="' + GetVersaoCTe(FConfiguracoes.Geral.VersaoDF,
                                                         LayCTeInutilizacao) +
                                 '" xmlns="http://www.portalfiscal.inf.br/cte">');

        wProc.Add(FDadosMSG);
        wProc.Add(FRetWS);
        wProc.Add('</ProcInutCTe>');
        FXML_ProcInutCTe := wProc.Text;
      finally
        wProc.Free;
      end;

      if FConfiguracoes.Geral.Salvar then
        FConfiguracoes.Geral.Save( GerarPrefixoArquivo + '-procInutCTe.xml',
                                   FXML_ProcInutCTe );

      if FConfiguracoes.Arquivos.Salvar then
        FConfiguracoes.Geral.Save( GerarPrefixoArquivo + '-procInutCTe.xml',
                                   FXML_ProcInutCTe, GerarPathPorCNPJ );
    end;
  finally
    CTeRetorno.Free;
  end;
end;

function TCTeInutilizacao.GerarMsgLog: AnsiString;
begin
  Result := 'Versão Layout : '     + Fversao + LineBreak +
            'Ambiente : '          + TpAmbToStr(FTpAmb) + LineBreak +
            'Versão Aplicativo : ' + FverAplic + LineBreak +
            'Status Código : '     + IntToStr(FcStat) + LineBreak +
            'Status Descrição : '  + FxMotivo + LineBreak +
            'UF : '                + CodigoParaUF(FcUF) + LineBreak +
            'Recebimento : '       + SeSenao(FdhRecbto = 0,
                                                     '',
                                                     DateTimeToStr(FdhRecbto));
end;

function TCTeInutilizacao.GerarPrefixoArquivo: AnsiString;
begin
  Result := OnlyNumber(FID);
end;

{ TCTeConsultaCadastro }

constructor TCTeConsultaCadastro.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FRetConsCad := TRetConsCad.Create;

  FStatus  := stCTeCadastro;
  FLayout  := LayCTeCadastro;
  FArqEnv  := 'ped-cad';
  FArqResp := 'cad';
end;

destructor TCTeConsultaCadastro.Destroy;
begin
  FRetConsCad.Free;
  inherited Destroy;
end;

procedure TCTeConsultaCadastro.SetCNPJ(const Value: String);
begin
  if NaoEstaVazio(Value) then
  begin
    FIE  := '';
    FCPF := '';
  end;

  FCNPJ := Value;
end;

procedure TCTeConsultaCadastro.SetCPF(const Value: String);
begin
  if NaoEstaVazio(Value) then
  begin
    FIE   := '';
    FCNPJ := '';
  end;

  FCPF := Value;
end;

procedure TCTeConsultaCadastro.SetIE(const Value: String);
begin
  if NaoEstaVazio(Value) then
  begin
    FCNPJ := '';
    FCPF  := '';
  end;

  FIE := Value;
end;

procedure TCTeConsultaCadastro.DefinirURL;
begin
  inherited DefinirURL;

  FURL := CTeUtil.GetURL( UFparaCodigo(FUF),
                          FConfiguracoes.WebServices.AmbienteCodigo,
                          FConfiguracoes.Geral.FormaEmissaoCodigo,
                          LayCTeCadastro );
end;

procedure TCTeConsultaCadastro.DefinirServicoEAction;
begin
  FServico    := CURL_WSDL + 'CteInutilizacao';
  FSoapAction := FServico;
end;

procedure TCTeConsultaCadastro.DefinirDadosMsg;
var
  ConCadCTe: TConsCad;
begin
  ConCadCTe := TConsCad.Create;
  try
    ConCadCTe.UF   := FUF;
    ConCadCTe.IE   := FIE;
    ConCadCTe.CNPJ := FCNPJ;
    ConCadCTe.CPF  := FCPF;

    ConCadCTe.GerarXML;

    FDadosMsg := ConCadCTe.Gerador.ArquivoFormatoXML;
  finally
    ConCadCTe.Free;
  end;
end;

function TCTeConsultaCadastro.TratarResposta: Boolean;
begin
  FRetWS := SeparaDados(FRetornoWS, 'consultaCadastro2Result');

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

function TCTeConsultaCadastro.GerarMsgLog: AnsiString;
begin
  Result := 'Versão Layout : '     + FRetConsCad.versao + LineBreak +
            'Versão Aplicativo : ' + FRetConsCad.verAplic + LineBreak +
            'Status Código : '     + IntToStr(FRetConsCad.cStat) + LineBreak +
            'Status Descrição : '  + FRetConsCad.xMotivo + LineBreak +
            'UF : '                + CodigoParaUF(FRetConsCad.cUF) + LineBreak +
            'Consulta : '          + DateTimeToStr(FRetConsCad.dhCons);
end;

function TCTeConsultaCadastro.GerarUFSoap: AnsiString;
begin
  Result := '<cUF>' +
              IntToStr(UFparaCodigo(FUF)) +
            '</cUF>';
end;

{ TCTeEnvEvento }

constructor TCTeEnvEvento.Create(AOwner: TComponent; AEvento: TEventoCTe);
begin
  inherited Create(AOwner);

  FEventoRetorno := TRetEventoCTe.Create;

  FEvento  := AEvento;
  FStatus  := stCTeEvento;
  FLayout  := LayCTeEvento;
  FArqEnv  := 'ped-eve';
  FArqResp := 'eve';
end;

destructor TCTeEnvEvento.Destroy;
begin
  FEventoRetorno.Free;
  inherited;
end;

function TCTeEnvEvento.GerarPathEvento: String;
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

procedure TCTeEnvEvento.DefinirURL;
begin
  { Verificação necessária pois somente os eventos de Cancelamento e CCe serão tratados pela SEFAZ do estado
    os outros eventos como manifestacao de destinatários serão tratados diretamente pela RFB }

  if not (FEvento.Evento.Items[0].InfEvento.tpEvento in [teCCe, teCancelamento, teMultiModal]) then
    FLayout := LayCTeEventoEPEC
  else
    FLayout := LayCTeEvento;

  inherited DefinirURL;
end;

procedure TCTeEnvEvento.DefinirServicoEAction;
begin
  FServico    := CURL_WSDL + 'CteRecepcaoEvento';
  FSoapAction := FServico + '/cteRecepcaoEvento';
end;

procedure TCTeEnvEvento.DefinirDadosMsg;
var
  EventoCTe: TEventoCTe;
  I, J, F: Integer;
  Lote, Evento, Eventos, EventosAssinados: String;
begin
  EventoCTe := TEventoCTe.Create;
  try
    EventoCTe.idLote := FidLote;
    FEveEPEC := False;

    for I := 0 to TCTeEnvEvento(Self).FEvento.Evento.Count - 1 do
    begin
      with EventoCTe.Evento.Add do
      begin
        infEvento.tpAmb      := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo - 1);
        infEvento.CNPJ       := FEvento.Evento[I].InfEvento.CNPJ;
        infEvento.cOrgao     := FEvento.Evento[I].InfEvento.cOrgao;
        infEvento.chCTe      := FEvento.Evento[I].InfEvento.chCTe;
        infEvento.dhEvento   := FEvento.Evento[I].InfEvento.dhEvento;
        infEvento.tpEvento   := FEvento.Evento[I].InfEvento.tpEvento;
        infEvento.nSeqEvento := FEvento.Evento[I].InfEvento.nSeqEvento;

        case InfEvento.tpEvento of
          teCCe:
          begin
            infEvento.detEvento.xCondUso := FEvento.Evento[i].InfEvento.detEvento.xCondUso;

            for j := 0 to FEvento.Evento[i].InfEvento.detEvento.infCorrecao.Count - 1 do
             begin
               with EventoCTe.Evento[i].InfEvento.detEvento.infCorrecao.Add do
                begin
                 grupoAlterado   := FEvento.Evento[i].InfEvento.detEvento.infCorrecao[j].grupoAlterado;
                 campoAlterado   := FEvento.Evento[i].InfEvento.detEvento.infCorrecao[j].campoAlterado;
                 valorAlterado   := FEvento.Evento[i].InfEvento.detEvento.infCorrecao[j].valorAlterado;
                 nroItemAlterado := FEvento.Evento[i].InfEvento.detEvento.infCorrecao[j].nroItemAlterado;
                end;
             end;
          end;

          teCancelamento:
          begin
            infEvento.detEvento.nProt := FEvento.Evento[I].InfEvento.detEvento.nProt;
            infEvento.detEvento.xJust := FEvento.Evento[I].InfEvento.detEvento.xJust;
          end;

          teMultiModal:
          begin
            infEvento.detEvento.xRegistro := FEvento.Evento[i].InfEvento.detEvento.xRegistro;
            infEvento.detEvento.nDoc      := FEvento.Evento[i].InfEvento.detEvento.nDoc;
          end;

          teEPEC:
          begin
            FEveEPEC := True;

            infEvento.detEvento.xJust   := FEvento.Evento[i].InfEvento.detEvento.xJust;
            infEvento.detEvento.vICMS   := FEvento.Evento[i].InfEvento.detEvento.vICMS;
            infEvento.detEvento.vTPrest := FEvento.Evento[i].InfEvento.detEvento.vTPrest;
            infEvento.detEvento.vCarga  := FEvento.Evento[i].InfEvento.detEvento.vCarga;
            infEvento.detEvento.toma    := FEvento.Evento[i].InfEvento.detEvento.toma;
            infEvento.detEvento.UF      := FEvento.Evento[i].InfEvento.detEvento.UF;
            infEvento.detEvento.CNPJCPF := FEvento.Evento[i].InfEvento.detEvento.CNPJCPF;
            infEvento.detEvento.IE      := FEvento.Evento[i].InfEvento.detEvento.IE;
            infEvento.detEvento.modal   := FEvento.Evento[i].InfEvento.detEvento.modal;
            infEvento.detEvento.UFIni   := FEvento.Evento[i].InfEvento.detEvento.UFIni;
            infEvento.detEvento.UFFim   := FEvento.Evento[i].InfEvento.detEvento.UFFim;
          end;

        end;
      end;
    end;

    EventoCTe.GerarXML;

    (*
    // Separa os grupos <evento> e coloca na variável Eventos
    I       := Pos( '<evento ', EventoCTe.Gerador.ArquivoFormatoXML );
    Lote    := Copy( EventoCTe.Gerador.ArquivoFormatoXML, 1, I - 1 );
    Eventos := SeparaDados(EventoCTe.Gerador.ArquivoFormatoXML, 'envEvento' );
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

        AssinarXML(Evento,
                   'Falha ao assinar o Envio de Evento ' + LineBreak + FMsg);

        EventosAssinados := EventosAssinados + FDadosMsg;
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
    *)

    AssinarXML(EventoCTe.Gerador.ArquivoFormatoXML,
               'Falha ao assinar o Envio de Evento ' + LineBreak + FMsg);

    if not(CTeUtil.Valida(FDadosMsg, FMsg, TACBrCTe( FACBrCTe ).Configuracoes.Geral.PathSchemas)) then
      GerarException('Falha na validação dos dados do Envio de Evento ' +
                     LineBreak + FMsg);

    for I := 0 to FEvento.Evento.Count-1 do
      FEvento.Evento[I].InfEvento.id := EventoCTe.Evento[I].InfEvento.id;
  finally
    EventoCTe.Free;
  end;
end;

procedure TCTeEnvEvento.DefinirEnvelopeSoap;
var
  Texto: AnsiString;
begin
  // UF = 51 = MT não esta aceitando SOAP 1.2
  if FConfiguracoes.WebServices.UFCodigo <> 51 then
  begin
    Texto := '<?xml version="1.0" encoding="utf-8"?>';
    Texto := Texto + '<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' +
                                     ' xmlns:xsd="http://www.w3.org/2001/XMLSchema"' +
                                     ' xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">';
    Texto := Texto +   '<soap12:Header>';
    Texto := Texto +     '<cteCabecMsg xmlns="' + Servico + '">';
    Texto := Texto +       GerarUFSoap;
    Texto := Texto +       GerarVersaoDadosSoap;
    Texto := Texto +     '</cteCabecMsg>';
    Texto := Texto +   '</soap12:Header>';
    Texto := Texto +   '<soap12:Body>';
    Texto := Texto +     '<cteDadosMsg xmlns="' + Servico + '">';
    Texto := Texto +       DadosMsg;
    Texto := Texto +     '</cteDadosMsg>';
    Texto := Texto +   '</soap12:Body>';
    Texto := Texto + '</soap12:Envelope>';
  end
  else begin
    Texto := '<?xml version="1.0" encoding="utf-8"?>';
    Texto := Texto + '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' +
                                   ' xmlns:xsd="http://www.w3.org/2001/XMLSchema"' +
                                   ' xmlns:soap="http://www.w3.org/2003/05/soap-envelope">';
    Texto := Texto +   '<soap:Header>';
    Texto := Texto +     '<cteCabecMsg xmlns="' + Servico + '">';
    Texto := Texto +       GerarUFSoap;
    Texto := Texto +       GerarVersaoDadosSoap;
    Texto := Texto +     '</cteCabecMsg>';
    Texto := Texto +   '</soap:Header>';
    Texto := Texto +   '<soap:Body>';
    Texto := Texto +     '<cteDadosMsg xmlns="' + Servico + '">';
    Texto := Texto +       DadosMsg;
    Texto := Texto +     '</cteDadosMsg>';
    Texto := Texto +   '</soap:Body>';
    Texto := Texto + '</soap:Envelope>';
  end;

  FEnvelopeSoap := Texto;
end;

function TCTeEnvEvento.TratarResposta: Boolean;
var
  Leitor: TLeitor;
  I, J: Integer;
  wProc: TStringList;
  NomeArq: String;
begin
  FEvento.idLote := idLote;

  FRetWS := SeparaDados(FRetornoWS, 'cteRecepcaoEventoResult');

  // Limpando variaveis internas
  FEventoRetorno.Free;
  FEventoRetorno := TRetEventoCTe.Create;

  FEventoRetorno.Leitor.Arquivo := FRetWS;
  FEventoRetorno.LerXml;

//  FcStat   := FEventoRetorno.cStat;
//  FxMotivo := FEventoRetorno.xMotivo;
//  FMsg     := FEventoRetorno.xMotivo;
//  FTpAmb   := FEventoRetorno.tpAmb;

  FcStat   := FEventoRetorno.retEvento.Items[0].RetInfEvento.cStat;
  FxMotivo := FEventoRetorno.retEvento.Items[0].RetInfEvento.xMotivo;
  FMsg     := FEventoRetorno.retEvento.Items[0].RetInfEvento.xMotivo;
  FTpAmb   := FEventoRetorno.retEvento.Items[0].RetInfEvento.tpAmb;

  Result := (FcStat in [128, 135, 136, 155]);

  //gerar arquivo proc de evento
  if Result then
  begin
    Leitor := TLeitor.Create;
    try
      for I := 0 to FEvento.Evento.Count - 1 do
      begin
        for J := 0 to FEventoRetorno.retEvento.Count - 1 do
        begin
          if FEvento.Evento.Items[I].InfEvento.chCTe = FEventoRetorno.retEvento.Items[J].RetInfEvento.chCTe then
          begin
            FEvento.Evento.Items[I].RetInfEvento.nProt       := FEventoRetorno.retEvento.Items[J].RetInfEvento.nProt;
            FEvento.Evento.Items[I].RetInfEvento.dhRegEvento := FEventoRetorno.retEvento.Items[J].RetInfEvento.dhRegEvento;
            FEvento.Evento.Items[I].RetInfEvento.cStat       := FEventoRetorno.retEvento.Items[J].RetInfEvento.cStat;
            FEvento.Evento.Items[I].RetInfEvento.xMotivo     := FEventoRetorno.retEvento.Items[J].RetInfEvento.xMotivo;
            FEvento.Evento.Items[i].RetInfEvento.chCTe       := FEventoRetorno.retEvento.Items[j].RetInfEvento.chCTe;

            wProc := TStringList.Create;
            try
              wProc.Add('<?xml version="1.0" encoding="UTF-8" ?>');
              wProc.Add('<procEventoCTe versao="' + GetVersaoCTe(FConfiguracoes.Geral.VersaoDF,
                                                                 LayCTeEvento) +
                                      '" xmlns="http://www.portalfiscal.inf.br/cte">');
              wProc.Add('<eventoCTe versao="' + GetVersaoCTe(FConfiguracoes.Geral.VersaoDF,
                                                          LayCTeEvento) + '">');
              Leitor.Arquivo := FDadosMSG;
              wProc.Add(UTF8Encode(Leitor.rExtrai(1, 'infEvento', '', I + 1)));
              wProc.Add('<Signature xmlns="http://www.w3.org/2000/09/xmldsig#">');

              Leitor.Arquivo := FDadosMSG;
              wProc.Add(UTF8Encode(Leitor.rExtrai(1, 'SignedInfo', '', I + 1)));

              Leitor.Arquivo := FDadosMSG;
              wProc.Add(UTF8Encode(Leitor.rExtrai(1, 'SignatureValue', '', I + 1)));

              Leitor.Arquivo := FDadosMSG;
              wProc.Add(UTF8Encode(Leitor.rExtrai(1, 'KeyInfo', '', I + 1)));
              wProc.Add('</Signature>');
              wProc.Add('</eventoCTe>');
              wProc.Add('<retEventoCTe versao="' + GetVersaoCTe(FConfiguracoes.Geral.VersaoDF,
                                                             LayCTeEvento) + '">');

              Leitor.Arquivo := FRetWS;
              wProc.Add(UTF8Encode(Leitor.rExtrai(1, 'infEvento', '', J + 1)));
              wProc.Add('</retEventoCTe>');
              wProc.Add('</procEventoCTe>');

              FEventoRetorno.retEvento.Items[J].RetInfEvento.XML := wProc.Text;

              FEvento.Evento.Items[I].RetInfEvento.XML := wProc.Text;

              NomeArq := OnlyNumber(FEvento.Evento.Items[i].InfEvento.Id) +
                         '-procEventoCTe.xml';

              if FConfiguracoes.Geral.Salvar then
                FConfiguracoes.Geral.Save(NomeArq, wProc.Text);

              if FConfiguracoes.Arquivos.Salvar then
                FConfiguracoes.Geral.Save(NomeArq, wProc.Text, GerarPathEvento);
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

procedure TCTeEnvEvento.SalvarEnvio;
begin
  inherited SalvarEnvio;

  if FConfiguracoes.Arquivos.Salvar then
    FConfiguracoes.Geral.Save(GerarPrefixoArquivo + '-' + ArqEnv + '.xml',
                              FDadosMsg, GerarPathEvento);
end;

procedure TCTeEnvEvento.SalvarResposta;
begin
  inherited SalvarResposta;

  if FConfiguracoes.Arquivos.Salvar then
    FConfiguracoes.Geral.Save(GerarPrefixoArquivo + '-' + ArqEnv + '.xml',
                              FDadosMsg, GerarPathEvento);
end;

function TCTeEnvEvento.GerarMsgLog: AnsiString;
var
  aMsg: String;
begin
  aMsg := 'Versão Layout : '     + FEventoRetorno.versao + LineBreak +
          'Ambiente : '          + TpAmbToStr(FEventoRetorno.tpAmb) + LineBreak +
          'Versão Aplicativo : ' + FEventoRetorno.verAplic + LineBreak +
          'Status Código : '     + IntToStr(FEventoRetorno.cStat) + LineBreak +
          'Status Descrição : '  + FEventoRetorno.xMotivo + LineBreak;

  if (FEventoRetorno.retEvento.Count > 0) then
      aMsg := aMsg + 'Recebimento : ' +
              SeSenao(FEventoRetorno.retEvento.Items[0].RetInfEvento.dhRegEvento = 0,
                              '',
                              DateTimeToStr(FEventoRetorno.retEvento.Items[0].RetInfEvento.dhRegEvento));
  Result := aMsg;
end;

function TCTeEnvEvento.GerarPrefixoArquivo: AnsiString;
begin
  Result := IntToStr(FEvento.idLote);
end;

{ TCTeEnvioWebService }

constructor TCTeEnvioWebService.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FStatus := stCTeEnvioWebService;
end;

destructor TCTeEnvioWebService.Destroy;
begin
  inherited Destroy;
end;

function TCTeEnvioWebService.Executar: Boolean;
begin
  Result := inherited Executar;
end;

procedure TCTeEnvioWebService.DefinirURL;
begin
  FURL := FURLEnvio;
end;

procedure TCTeEnvioWebService.DefinirServicoEAction;
begin
  FServico := FSoapAction;
end;

procedure TCTeEnvioWebService.DefinirDadosMsg;
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

function TCTeEnvioWebService.TratarResposta: Boolean;
begin
  FRetWS := SeparaDados(FRetornoWS, 'soap:Body');
  Result := True;
end;

function TCTeEnvioWebService.GerarMsgLog: AnsiString;
begin
  Result := inherited GerarMsgLog;
end;

function TCTeEnvioWebService.GerarMsgErro(E: Exception): AnsiString;
begin
  Result := 'WebService' + LineBreak +
            '- Inativo ou Inoperante tente novamente.' + LineBreak +
            '- ' + E.Message;
end;

function TCTeEnvioWebService.GerarVersaoDadosSoap: AnsiString;
begin
  Result := '<versaoDados>' +
              FVersao +
            '</versaoDados>';
end;

{ TWebServices }

constructor TWebServices.Create(AFCTe: TComponent);
begin
  FACBrCTe          := TACBrCTe(AFCTe);
  FStatusServico    := TCTeStatusServico.Create(AFCTe);
  FEnviar           := TCTeRecepcao.Create(AFCTe, TACBrCTe(AFCTe).Conhecimentos);
  FRetorno          := TCTeRetRecepcao.Create(AFCTe, TACBrCTe(AFCTe).Conhecimentos);
  FRecibo           := TCTeRecibo.Create(AFCTe);
  FConsulta         := TCTeConsulta.Create(AFCTe);
  FInutilizacao     := TCTeInutilizacao.Create(AFCTe);
  FConsultaCadastro := TCTeConsultaCadastro.Create(AFCTe);
  FEnvEvento        := TCTeEnvEvento.Create(AFCTe,TACBrCTe(AFCTe).EventoCTe);
  FEnvioWebService  := TCTeEnvioWebService.Create(AFCTe);
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
  FEnvEvento.Free;
  FEnvioWebService.Free;
  
  inherited Destroy;
end;

function TWebServices.Envia(ALote: Integer): Boolean;
begin
  Result := Envia(IntToStr(ALote));
end;

function TWebServices.Envia(ALote: String): Boolean;
begin
  FEnviar.FLote := ALote;

  if not Enviar.Executar then
    Enviar.GerarException(Enviar.Msg);

  FRetorno.Recibo := FEnviar.Recibo;

  if not FRetorno.Executar then
    FRetorno.GerarException(FRetorno.Msg);

  Result := True;
end;

procedure TWebServices.Inutiliza(CNPJ, AJustificativa: String; Ano, Modelo, Serie, NumeroInicial, NumeroFinal: Integer);
begin
  CNPJ := OnlyNumber(CNPJ);
  if not ValidarCNPJ(CNPJ) then
    raise EACBrCTeException.Create('CNPJ: ' + CNPJ + ', inválido.');

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
