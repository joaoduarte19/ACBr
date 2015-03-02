{******************************************************************************}
{ Projeto: Componente ACBrMDFe                                                 }
{  Biblioteca multiplataforma de componentes Delphi                            }
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

{*******************************************************************************
|* Historico
|*
|* 01/08/2012: Italo Jurisato Junior
|*  - Doação do componente para o Projeto ACBr
*******************************************************************************}

{$I ACBr.inc}

unit ACBrMDFeWebServices;

interface

uses
  Classes, SysUtils,
{$IFDEF CLX} QDialogs,{$ELSE} Dialogs,{$ENDIF}
{$IFDEF ACBrMDFeOpenSSL}
  HTTPSend,
{$ELSE}
     {$IFDEF SoapHTTP}
       SoapHTTPClient, SOAPHTTPTrans, SOAPConst,
       JwaWinCrypt, WinInet, ACBrCAPICOM_TLB,
     {$ELSE}
       ACBrHTTPReqResp,
     {$ENDIF}
{$ENDIF}
  pcnAuxiliar, pmdfeConversao, pcnConversao,
  ACBrMDFeConfiguracoes, ACBrMDFeManifestos,
  pmdfeProcMDFe, pmdfeConsStatServ, pmdfeRetConsStatServ, pmdfeRetEnvMDFe,
  pmdfeConsReciMDFe, pmdfeRetConsReciMDFe, pmdfeConsSitMDFe, pmdfeRetConsSitMDFe,
  pmdfeEnvEventoMDFe, pmdfeRetEnvEventoMDFe, pmdfeConsMDFeNaoEnc,
  pmdfeRetConsMDFeNaoEnc, ActiveX;

const
  CURL_WSDL = 'http://www.portalfiscal.inf.br/mdfe/wsdl/';
  INTERNET_OPTION_CLIENT_CERT_CONTEXT = 84;

type

  { TWebServicesBase }

  TWebServicesBase = Class
  private
    {$IFDEF ACBrMDFeOpenSSL}
     procedure ConfiguraHTTP(HTTP: THTTPSend; Action: AnsiString);
    {$ELSE}
     {$IFDEF SoapHTTP}
      procedure ConfiguraReqResp(ReqResp: THTTPReqResp);
      procedure OnBeforePost(const HTTPReqResp: THTTPReqResp; Data:Pointer);
     {$ELSE}
      procedure ConfiguraReqResp(ReqResp: TACBrHTTPReqResp);
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
    FACBrMDFe: TComponent;
    FArqEnv: AnsiString;
    FArqResp: AnsiString;
    FServico: AnsiString;
    FSoapAction: AnsiString;
    FStatus: TStatusACBrMDFe;
    FLayout: TLayOutMDFe;
    FRetMDFeDFe: AnsiString;
  protected
    procedure AssinarXML(AXML: String; MsgErro: String);
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
    property Status: TStatusACBrMDFe  read FStatus;
    property Layout: TLayOutMDFe      read FLayout;
    property URL: WideString          read FURL;
    property CabMsg: WideString       read FCabMsg;
    property DadosMsg: AnsiString     read FDadosMsg;
    property EnvelopeSoap: AnsiString read FEnvelopeSoap;
    property RetornoWS: AnsiString    read FRetornoWS;
    property RetWS: AnsiString        read FRetWS;
    property Msg: AnsiString          read FMsg;
    property ArqEnv: AnsiString       read FArqEnv;
    property ArqResp: AnsiString      read FArqResp;
    property RetMDFeDFe: AnsiString   read FRetMDFeDFe;
  end;

  { TMDFeStatusServico }

  TMDFeStatusServico = Class(TWebServicesBase)
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

  { TMDFeRecepcao }

  TMDFeRecepcao = Class(TWebServicesBase)
  private
    FLote: String;
    FRecibo: String;
    FManifestos: TManifestos;
    Fversao: String;
    FTpAmb: TpcnTipoAmbiente;
    FverAplic: String;
    FcStat: Integer;
    FcUF: Integer;
    FxMotivo: String;
    FdhRecbto: TDateTime;
    FTMed: Integer;

    FMDFeRetorno: TretEnvMDFe;

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
    constructor Create(AOwner: TComponent; AManifestos: TManifestos); reintroduce; overload;
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

  { TMDFeRetRecepcao }

  TMDFeRetRecepcao = Class(TWebServicesBase)
  private
    FRecibo: String;
    FProtocolo: String;
    FChaveMDFe: String;
    FManifestos: TManifestos;
    Fversao: String;
    FTpAmb: TpcnTipoAmbiente;
    FverAplic: String;
    FcStat: Integer;
    FcUF: Integer;
    FxMotivo: String;
    FcMsg: Integer;
    FxMsg: String;

    FMDFeRetorno: TRetConsReciMDFe;

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
    constructor Create(AOwner: TComponent; AManifestos: TManifestos); reintroduce; overload;
    destructor Destroy; override;

    function Executar: Boolean; override;

    property versao: String          read Fversao;
    property TpAmb: TpcnTipoAmbiente read FTpAmb;
    property verAplic: String        read FverAplic;
    property cStat: Integer          read FcStat;
    property cUF: Integer            read FcUF;
    property xMotivo: String         read FxMotivo;
    property cMsg: Integer           read FcMsg;
    property xMsg: String            read FxMsg;
    property Recibo: String          read GetRecibo  write FRecibo;
    property Protocolo: String       read FProtocolo write FProtocolo;
    property ChaveMDFe: String       read FChaveMDFe write FChaveMDFe;

    property MDFeRetorno: TRetConsReciMDFe read FMDFeRetorno;
  end;

  { TMDFeRecibo }

  TMDFeRecibo = Class(TWebServicesBase)
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

    FMDFeRetorno: TRetConsReciMDFe;
  protected
    procedure DefinirServicoEAction; override;
    procedure DefinirURL; override;
    procedure DefinirDadosMsg; override;
    function TratarResposta: Boolean; override;

    function GerarMsgLog: AnsiString; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property versao: String          read Fversao;
    property TpAmb: TpcnTipoAmbiente read FTpAmb;
    property verAplic: String        read FverAplic;
    property cStat: Integer          read FcStat;
    property xMotivo: String         read FxMotivo;
    property cUF: Integer            read FcUF;
    property xMsg: String            read FxMsg;
    property cMsg: Integer           read FcMsg;
    property Recibo: String          read FRecibo write FRecibo;

    property MDFeRetorno: TRetConsReciMDFe read FMDFeRetorno;
  end;

  { TMDFeConsulta }

  TMDFeConsulta = Class(TWebServicesBase)
  private
    FMDFeChave: WideString;
    FProtocolo: WideString;
    FDhRecbto: TDateTime;
    FXMotivo: WideString;
    Fversao: String;
    FTpAmb: TpcnTipoAmbiente;
    FverAplic: String;
    FcStat: Integer;
    FcUF: Integer;
    FdigVal: String;

    FprotMDFe: TProcMDFe;
    FprocEventoMDFe: TRetEventoMDFeCollection;
  protected
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    function TratarResposta: Boolean; override;

    function GerarMsgLog: AnsiString; override;
    function GerarPrefixoArquivo: AnsiString; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property MDFeChave: WideString   read FMDFeChave write FMDFeChave;
    property Protocolo: WideString   read FProtocolo write FProtocolo;
    property DhRecbto: TDateTime     read FDhRecbto  write FDhRecbto;
    property XMotivo: WideString     read FXMotivo   write FXMotivo;
    property versao: String          read Fversao;
    property TpAmb: TpcnTipoAmbiente read FTpAmb;
    property verAplic: String        read FverAplic;
    property cStat: Integer          read FcStat;
    property cUF: Integer            read FcUF;
    property digVal: String          read FdigVal;

    property protMDFe: TProcMDFe                      read FprotMDFe;
    property procEventoMDFe: TRetEventoMDFeCollection read FprocEventoMDFe;
  end;

  { TMDFeEnvEvento }

  TMDFeEnvEvento = Class(TWebServicesBase)
  private
    FidLote: Integer;
    Fversao: String;
    FEvento: TEventoMDFe;
    FcStat: Integer;
    FxMotivo: String;
    FTpAmb: TpcnTipoAmbiente;

    FEventoRetorno: TRetEventoMDFe;

    function GerarPathEvento: String;
  protected
    procedure DefinirURL; override;
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    procedure SalvarEnvio; override;
    function TratarResposta: Boolean; override;
    procedure SalvarResposta; override;

    function GerarMsgLog: AnsiString; override;
    function GerarPrefixoArquivo: AnsiString; override;
  public
    constructor Create(AOwner: TComponent; AEvento: TEventoMDFe); reintroduce; overload;
    destructor Destroy; override;

    property idLote: Integer         read FidLote write FidLote;
    property versao: String          read Fversao write Fversao;
    property cStat: Integer          read FcStat;
    property xMotivo: String         read FxMotivo;
    property TpAmb: TpcnTipoAmbiente read FTpAmb;

    property EventoRetorno: TRetEventoMDFe read FEventoRetorno;
  end;

  { TMDFeConsultaMDFeNaoEnc }

  TMDFeConsultaMDFeNaoEnc = Class(TWebServicesBase)
  private
    FCNPJ: String;
    Fversao: String;
    FtpAmb: TpcnTipoAmbiente;
    FverAplic: String;
    FcStat: Integer;
    FxMotivo: String;
    FcUF: Integer;
    FInfMDFe: TRetInfMDFeCollection;
  protected
    procedure DefinirURL; override;
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    function TratarResposta: Boolean; override;

    function GerarMsgLog: AnsiString; override;
    function GerarMsgErro(E: Exception): AnsiString; override;
  public
    constructor Create(AOwner: TComponent); reintroduce;
    destructor Destroy; override;

    property CNPJ: String                   read FCNPJ write FCNPJ;
    property versao: String                 read Fversao;
    property tpAmb: TpcnTipoAmbiente        read FtpAmb;
    property verAplic: String               read FverAplic;
    property cStat: Integer                 read FcStat;
    property xMotivo: String                read FxMotivo;
    property cUF: Integer                   read FcUF;
    property InfMDFe: TRetInfMDFeCollection read FInfMDFe;
  end;

  { TMDFeEnvioWebService }

  TMDFeEnvioWebService = Class(TWebServicesBase)
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

    property XMLEnvio: String        read FXMLEnvio        write FXMLEnvio;
    property URLEnvio: String        read FURLEnvio        write FURLEnvio;
    property SoapActionEnvio: String read FSoapActionEnvio write FSoapActionEnvio;
  end;

  { TWebService }

  TWebServices = Class(TWebServicesBase)
  private
    FACBrMDFe: TComponent;
    FStatusServico: TMDFeStatusServico;
    FEnviar: TMDFeRecepcao;
    FRetorno: TMDFeRetRecepcao;
    FRecibo: TMDFeRecibo;
    FConsulta: TMDFeConsulta;
    FConsMDFeNaoEnc: TMDFeConsultaMDFeNaoEnc;
    FEnvEvento: TMDFeEnvEvento;
    FEnvioWebService: TMDFeEnvioWebService;
  public
    constructor Create(AFMDFe: TComponent); reintroduce;
    destructor Destroy; override;
    function Envia(ALote: Integer): Boolean; overload;
    function Envia(ALote: String): Boolean; overload;
    function ConsultaMDFeNaoEnc(ACNPJ: String): Boolean;
//  published
    property ACBrMDFe: TComponent                    read FACBrMDFe        write FACBrMDFe;
    property StatusServico: TMDFeStatusServico       read FStatusServico   write FStatusServico;
    property Enviar: TMDFeRecepcao                   read FEnviar          write FEnviar;
    property Retorno: TMDFeRetRecepcao               read FRetorno         write FRetorno;
    property Recibo: TMDFeRecibo                     read FRecibo          write FRecibo;
    property Consulta: TMDFeConsulta                 read FConsulta        write FConsulta;
    property ConsMDFeNaoEnc: TMDFeConsultaMDFeNaoEnc read FConsMDFeNaoEnc  write FConsMDFeNaoEnc;
    property EnvEvento: TMDFeEnvEvento               read FEnvEvento       write FEnvEvento;
    property EnvioWebService: TMDFeEnvioWebService   read FEnvioWebService write FEnvioWebService;
  end;

implementation

uses
{$IFDEF ACBrMDFeOpenSSL}
  ssl_openssl,
{$ENDIF}
  ACBrUtil, ACBrDFeUtil, ACBrMDFeUtil, ACBrMDFe, pmdfeMDFeW, 
  pcnGerador, pmdfeCabecalho, pcnLeitor;

{ TWebServicesBase }

constructor TWebServicesBase.Create(AOwner: TComponent);
begin
  FConfiguracoes := TACBrMDFe(AOwner).Configuracoes;
  FACBrMDFe      := TACBrMDFe(AOwner);
  FLayout        := LayMDFeStatusServico;
  FStatus        := stMDFeIdle;
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
  {$IFDEF ACBrMDFeOpenSSL}
   if not(MAssinar(AXML,
                           FConfiguracoes.Certificados.Certificado,
                           FConfiguracoes.Certificados.Senha,
                           FDadosMsg, FMsg)) then
  {$ELSE}
   if not(MAssinar(AXML,
                           FConfiguracoes.Certificados.GetCertificado,
                           FDadosMsg, FMsg)) then
  {$ENDIF}
   GerarException(MsgErro);
end;

{$IFDEF ACBrMDFeOpenSSL}
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
   HTTP.Protocol  := '1.1';
   HTTP.AddPortNumberToHost := False;
   HTTP.Headers.Add(Action);
 end;
{$ELSE}
 {$IFDEF SoapHTTP}
  procedure TWebServicesBase.ConfiguraReqResp(ReqResp: THTTPReqResp);
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
                             PCertContext,SizeOf(CERT_CONTEXT)) then
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
       ContentHeader := Format(ContentTypeTemplate,
                               ['application/soap+xml; charset=utf-8']);
       HttpAddRequestHeaders(Data,
                             PChar(ContentHeader),
                             Length(ContentHeader),
                             HTTP_ADDREQ_FLAG_REPLACE);
    end;

    HTTPReqResp.CheckContentType;
  end;
 {$ELSE}
  procedure TWebServicesBase.ConfiguraReqResp(ReqResp: TACBrHTTPReqResp);
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
      FazerLog(GerarMsgLog, True);
      SalvarResposta;
    except
      on E: Exception do
      begin
        Result  := False;
        ErroMsg := GerarMsgErro(E);
        GerarException(ErroMsg);
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

  TACBrMDFe(FACBrMDFe).SetStatus(FStatus);
end;

procedure TWebServicesBase.DefinirServicoEAction;
begin
  { sobrescrever, obrigatoriamente }

  FServico    := '';
  FSoapAction := '';
end;

procedure TWebServicesBase.DefinirURL;
begin
  { sobrescrever apenas se necessário.
    Você também pode mudar apenas o valor de "FLayoutServico" na classe
    filha e chamar: Inherited;     }

  FURL := MGetURL(FConfiguracoes.WebServices.UFCodigo,
                          FConfiguracoes.WebServices.AmbienteCodigo,
                          FConfiguracoes.Geral.FormaEmissaoCodigo,
                          Layout);
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
  Texto := Texto +     '<mdfeCabecMsg xmlns="' + Servico + '">';
  Texto := Texto +       GerarUFSoap;
  Texto := Texto +       GerarVersaoDadosSoap;
  Texto := Texto +     '</mdfeCabecMsg>';
  Texto := Texto +   '</soap12:Header>';
  Texto := Texto +   '<soap12:Body>';
  Texto := Texto +     '<mdfeDadosMsg xmlns="' + Servico + '">';
  Texto := Texto +       DadosMsg;
  Texto := Texto +     '</mdfeDadosMsg>';
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
              GetVersaoMDFe(FConfiguracoes.Geral.VersaoDF, Layout) +
            '</versaoDados>';
end;

procedure TWebServicesBase.EnviarDados;
var
  {$IFDEF ACBrMDFeOpenSSL}
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

  {$IFDEF ACBrMDFeOpenSSL}
   HTTP := THTTPSend.Create;
  {$ELSE}
   {$IFDEF SoapHTTP}
    ReqResp := THTTPReqResp.Create(nil);
    ReqResp.UseUTF8InHeader := True;
   {$ELSE}
    ReqResp := TACBrHTTPReqResp.Create;
   {$ENDIF}
   ConfiguraReqResp(ReqResp);
   ReqResp.URL := URL;
   ReqResp.SoapAction := SoapAction;
  {$ENDIF}
  FEnvelopeSoap := UTF8Encode(FEnvelopeSoap);

  try
    {$IFDEF ACBrMDFeOpenSSL}
     ConfiguraHTTP(HTTP, 'SOAPAction: "' + SoapAction + '"');
     HTTP.Document.WriteBuffer(FEnvelopeSoap[1], Length(FEnvelopeSoap));
     OK := HTTP.HTTPMethod('POST', URL);
     OK := OK and (HTTP.ResultCode = 200);
     if not OK then
       GerarException('Cod.Erro HTTP: ' + IntToStr(HTTP.ResultCode) +
                      ' ' + HTTP.ResultString);

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
    FRetornoWS := ParseText(FRetornoWS, True, True); // Resposta sempre é UTF8
  finally
    {$IFDEF ACBrMDFeOpenSSL}
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
    FConfiguracoes.Geral.Save(ArqResp, FRetornoWS);
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
    if Assigned(TACBrMDFe(FACBrMDFe).OnGerarLog) then
      TACBrMDFe(FACBrMDFe).OnGerarLog(Msg);

    if Exibir and FConfiguracoes.WebServices.Visualizar then
      ShowMessage(Msg);
  end;
end;

procedure TWebServicesBase.GerarException(Msg: AnsiString);
begin
  FazerLog('ERRO: ' + Msg, False);
  raise EACBrMDFeException.Create(Msg);
end;

function TWebServicesBase.GerarMsgErro(E: Exception): AnsiString;
begin
  { Sobrescrever com mensagem adicional, se desejar }

  Result := E.Message;
end;

procedure TWebServicesBase.FinalizarServico;
begin
  { Sobrescrever apenas se necessário }

  TACBrMDFe(FACBrMDFe).SetStatus(stMDFeIdle);
  ConfAmbiente;
end;

{ TMDFeStatusServico }

constructor TMDFeStatusServico.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FStatus  := stMDFeStatusServico;
  FLayout  := LayMDFeStatusServico;
  FArqEnv  := 'ped-sta';
  FArqResp := 'sta';
end;

procedure TMDFeStatusServico.DefinirServicoEAction;
begin
  FServico    := CURL_WSDL + 'MDFeStatusServico';
  FSoapAction := FServico + '/mdfeStatusServicoMDF';
end;

procedure TMDFeStatusServico.DefinirDadosMsg;
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

function TMDFeStatusServico.TratarResposta: Boolean;
var
  MDFeRetorno: TRetConsStatServ;
begin
  FRetWS := SeparaDados(FRetornoWS, 'mdfeStatusServicoMDFResult');

  MDFeRetorno := TRetConsStatServ.Create;
  try
    MDFeRetorno.Leitor.Arquivo := FRetWS;
    MDFeRetorno.LerXml;

    Fversao    := MDFeRetorno.versao;
    FtpAmb     := MDFeRetorno.tpAmb;
    FverAplic  := MDFeRetorno.verAplic;
    FcStat     := MDFeRetorno.cStat;
    FxMotivo   := MDFeRetorno.xMotivo;
    FcUF       := MDFeRetorno.cUF;
    FdhRecbto  := MDFeRetorno.dhRecbto;
    FTMed      := MDFeRetorno.TMed;
    FdhRetorno := MDFeRetorno.dhRetorno;
    FxObs      := MDFeRetorno.xObs;
    FMsg       := FxMotivo + LineBreak + FxObs;

    if FConfiguracoes.WebServices.AjustaAguardaConsultaRet then
       FConfiguracoes.WebServices.AguardarConsultaRet := FTMed * 1000;

    Result := (FcStat = 107);

  finally
    MDFeRetorno.Free;
  end;
end;

function TMDFeStatusServico.GerarMsgLog: AnsiString;
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
            'Observação : '        + FxObs + LineBreak;
end;

function TMDFeStatusServico.GerarMsgErro(E: Exception): AnsiString;
begin
  Result := 'WebService Consulta Status serviço:' + LineBreak +
            '- Inativo ou Inoperante tente novamente.' + LineBreak +
            '- ' + E.Message
end;

{ TMDFeRecepcao }

constructor TMDFeRecepcao.Create(AOwner: TComponent;
  AManifestos: TManifestos);
begin
  inherited Create(AOwner);

  FManifestos := AManifestos;

  FStatus  := stMDFeRecepcao;
  FLayout  := LayMDFeRecepcao;
  FArqEnv  := 'env-lot';
  FArqResp := 'rec';

  FMDFeRetorno := nil;
end;

destructor TMDFeRecepcao.Destroy;
begin
  if Assigned(FMDFeRetorno) then
    FMDFeRetorno.Free;

  inherited Destroy;
end;

function TMDFeRecepcao.GetLote: String;
begin
  Result := Trim(FLote);
end;

function TMDFeRecepcao.GetRecibo: String;
begin
  Result := Trim(FRecibo);
end;

procedure TMDFeRecepcao.DefinirURL;
begin
  FLayout := LayMDFeRecepcao;

  inherited DefinirURL;
end;

procedure TMDFeRecepcao.DefinirServicoEAction;
begin
  FServico    := CURL_WSDL + 'MDFeRecepcao';
  FSoapAction := FServico + '/mdfeRecepcaoLote';
end;

procedure TMDFeRecepcao.DefinirDadosMsg;
var
  I: Integer;
  vMDFe: WideString;
  Versao: String;
begin
  Versao := GetVersaoMDFe(FConfiguracoes.Geral.VersaoDF, Layout);

  if FLote = '' then
    FLote := '0';

  vMDFe := '';
  for I := 0 to FManifestos.Count - 1 do
    vMDFe := vMDFe + '<MDFe' +
                       RetornarConteudoEntre(FManifestos.Items[I].XML, '<MDFe', '</MDFe>') +
                     '</MDFe>';

  FDadosMsg := '<enviMDFe xmlns="http://www.portalfiscal.inf.br/mdfe" versao="' + Versao + '">'+
                 '<idLote>' +
                   FLote +
                 '</idLote>'+
                 vMDFe +
               '</enviMDFe>';

  // Lote tem mais de 500kb ? //
  if Length(FDadosMsg) > (500 * 1024) then
    GerarException('Tamanho do XML de Dados superior a 500 Kbytes. Tamanho atual: ' +
                   IntToStr(trunc(Length(FDadosMsg) / 1024)) + ' Kbytes');

  FRecibo := '';
end;

function TMDFeRecepcao.TratarResposta: Boolean;
begin
  FRetWS := SeparaDados(FRetornoWS, 'mdfeRecepcaoLoteResult');

  FMDFeRetorno := TretEnvMDFe.Create;

  FMDFeRetorno.Leitor.Arquivo := FRetWS;
  FMDFeRetorno.LerXml;

  Fversao   := FMDFeRetorno.versao;
  FTpAmb    := FMDFeRetorno.TpAmb;
  FverAplic := FMDFeRetorno.verAplic;
  FcStat    := FMDFeRetorno.cStat;
  FxMotivo  := FMDFeRetorno.xMotivo;
  FdhRecbto := FMDFeRetorno.infRec.dhRecbto;
  FTMed     := FMDFeRetorno.infRec.tMed;
  FcUF      := FMDFeRetorno.cUF;
  FMsg      := FMDFeRetorno.xMotivo;
  FRecibo   := FMDFeRetorno.infRec.nRec;

  Result := (FMDFeRetorno.CStat = 103);
end;

procedure TMDFeRecepcao.FinalizarServico;
begin
  inherited FinalizarServico;

  if Assigned(FMDFeRetorno) then
    FreeAndNil(FMDFeRetorno);
end;

function TMDFeRecepcao.GerarMsgLog: AnsiString;
begin
  if Assigned(FMDFeRetorno) then
    Result := 'Versão Layout : '     + FMDFeRetorno.versao + LineBreak +
              'Ambiente : '          + TpAmbToStr(FMDFeRetorno.TpAmb) + LineBreak +
              'Versão Aplicativo : ' + FMDFeRetorno.verAplic + LineBreak +
              'Status Código : '     + IntToStr(FMDFeRetorno.cStat) + LineBreak +
              'Status Descrição : '  + FMDFeRetorno.xMotivo + LineBreak +
              'UF : '                + CodigoParaUF(FMDFeRetorno.cUF) + LineBreak +
              'Recibo : '            + FMDFeRetorno.infRec.nRec + LineBreak +
              'Recebimento : '       + SeSenao(FMDFeRetorno.InfRec.dhRecbto = 0,
                                                       '',
                                                       DateTimeToStr(FMDFeRetorno.InfRec.dhRecbto)) +
                                                       LineBreak +
              'Tempo Médio : '       + IntToStr(FMDFeRetorno.InfRec.TMed) +
                                       LineBreak
  else
    Result := '';
end;

function TMDFeRecepcao.GerarPrefixoArquivo: AnsiString;
begin
  Result := Lote;
end;

{ TMDFeRetRecepcao }

constructor TMDFeRetRecepcao.Create(AOwner: TComponent;
  AManifestos: TManifestos);
begin
  inherited Create(AOwner);

  FMDFeRetorno := TRetConsReciMDFe.Create;

  FManifestos := AManifestos;

  FStatus  := stMDFeRetRecepcao;
  FLayout  := LayMDFeRetRecepcao;
  FArqEnv  := 'ped-rec';
  FArqResp := 'pro-rec';
end;

destructor TMDFeRetRecepcao.Destroy;
begin
  FMDFeRetorno.Free;

  inherited Destroy;
end;

function TMDFeRetRecepcao.GetRecibo: String;
begin
  Result := Trim(FRecibo);
end;

function TMDFeRetRecepcao.TratarRespostaFinal: Boolean;
var
  I, J: Integer;
  AProcMDFe: TProcMDFe;
  AInfProt: TProtMDFeCollection;
  Data: TDateTime;
begin
  Result := False;

  AInfProt := FMDFeRetorno.ProtMDFe;

  if (AInfProt.Count > 0) then
  begin
    FMsg     := FMDFeRetorno.ProtMDFe.Items[0].xMotivo;
    FxMotivo := FMDFeRetorno.ProtMDFe.Items[0].xMotivo;
  end;

  //Setando os retornos das notas fiscais;
  for I := 0 to AInfProt.Count - 1 do
  begin
    for J := 0 to FManifestos.Count - 1 do
    begin
      if OnlyNumber(AInfProt.Items[I].chMDFe) = OnlyNumber(FManifestos.Items[J].MDFe.InfMDFe.Id) then
      begin
        if (TACBrMDFe( FACBrMDFe ).Configuracoes.Geral.ValidarDigest ) and
           (FManifestos.Items[J].MDFe.Signature.DigestValue <> AInfProt.Items[I].digVal) and
           (AInfProt.Items[I].digVal <> '') then
         begin
           raise EACBrMDFeException.Create('DigestValue do documento '+
                                           OnlyNumber(FManifestos.Items[J].MDFe.infMDFe.Id)+
                                           ' não confere.');
         end;
        FManifestos.Items[J].Confirmada             := (AInfProt.Items[I].cStat in [100, 150]);
        FManifestos.Items[J].Msg                    := AInfProt.Items[I].xMotivo;
        FManifestos.Items[J].MDFe.procMDFe.tpAmb    := AInfProt.Items[I].tpAmb;
        FManifestos.Items[J].MDFe.procMDFe.verAplic := AInfProt.Items[I].verAplic;
        FManifestos.Items[J].MDFe.procMDFe.chMDFe   := AInfProt.Items[I].chMDFe;
        FManifestos.Items[J].MDFe.procMDFe.dhRecbto := AInfProt.Items[I].dhRecbto;
        FManifestos.Items[J].MDFe.procMDFe.nProt    := AInfProt.Items[I].nProt;
        FManifestos.Items[J].MDFe.procMDFe.digVal   := AInfProt.Items[I].digVal;
        FManifestos.Items[J].MDFe.procMDFe.cStat    := AInfProt.Items[I].cStat;
        FManifestos.Items[J].MDFe.procMDFe.xMotivo  := AInfProt.Items[I].xMotivo;

        if FConfiguracoes.Geral.Salvar or NaoEstaVazio(FManifestos.Items[J].NomeArq) then
        begin
          if FileExists(PathWithDelim(FConfiguracoes.Geral.PathSalvar) + AInfProt.Items[I].chMDFe + '-mdfe.xml') and
             FileExists(PathWithDelim(FConfiguracoes.Geral.PathSalvar) + FMDFeRetorno.nRec + '-pro-rec.xml') then
          begin
            AProcMDFe := TProcMDFe.Create;
            try
              AProcMDFe.PathMDFe := PathWithDelim(FConfiguracoes.Geral.PathSalvar)+AInfProt.Items[I].chMDFe+'-mdfe.xml';
              AProcMDFe.PathRetConsReciMDFe := PathWithDelim(FConfiguracoes.Geral.PathSalvar) +
                                               FMDFeRetorno.nRec +
                                               '-pro-rec.xml';

              AProcMDFe.GerarXML;

              if NaoEstaVazio(AProcMDFe.Gerador.ArquivoFormatoXML) then
              begin
                if NaoEstaVazio(FManifestos.Items[J].NomeArq) then
                  AProcMDFe.Gerador.SalvarArquivo(FManifestos.Items[J].NomeArq)
                else
                  AProcMDFe.Gerador.SalvarArquivo(PathWithDelim(FConfiguracoes.Geral.PathSalvar) +
                                                  AInfProt.Items[I].chMDFe +
                                                  '-mdfe.xml');
              end;
            finally
              AProcMDFe.Free;
            end;
          end;

//          if FConfiguracoes.Arquivos.Salvar then
//          begin
//            if FConfiguracoes.Arquivos.EmissaoPathMDFe then
//              Data := FManifestos.Items[J].MDFe.Ide.dhEmi
//            else
//              Data := Now;

//            FManifestos.Items[J].SaveToFile(PathWithDelim(FConfiguracoes.Arquivos.GetPathMDFe(Data,
//               FManifestos.Items[J].MDFe.Emit.CNPJ)) +
//               OnlyNumber(FManifestos.Items[J].MDFe.InfMDFe.Id) + '-mdfe.xml')
//          end;
        end;

        if FConfiguracoes.Arquivos.Salvar then
        begin
          if FConfiguracoes.Arquivos.EmissaoPathMDFe then
            Data := FManifestos.Items[J].MDFe.Ide.dhEmi
          else
            Data := Now;

          if FConfiguracoes.Arquivos.SalvarApenasMDFeProcessados then
           begin
              if FManifestos.Items[J].MDFe.procMDFe.cStat in [100, 150] then
               FManifestos.Items[J].SaveToFile(PathWithDelim(FConfiguracoes.Arquivos.GetPathMDFe(Data,
                   FManifestos.Items[J].MDFe.Emit.CNPJ)) +
                   OnlyNumber(FManifestos.Items[J].MDFe.InfMDFe.Id) + '-mdfe.xml');
           end
           else
            FManifestos.Items[J].SaveToFile(PathWithDelim(FConfiguracoes.Arquivos.GetPathMDFe(Data,
                FManifestos.Items[J].MDFe.Emit.CNPJ)) +
                OnlyNumber(FManifestos.Items[J].MDFe.InfMDFe.Id) + '-mdfe.xml');
        end;

        break;
      end;
    end;
  end;

  //Verificando se existe algum conhecimento confirmado
  for I := 0 to FManifestos.Count - 1 do
  begin
    if FManifestos.Items[I].Confirmada then
    begin
      Result := True;
      break;
    end;
  end;

  //Verificando se existe algum conhecimento nao confirmado
  for I := 0 to FManifestos.Count - 1 do
  begin
    if not FManifestos.Items[I].Confirmada then
    begin
      FMsg := 'Conhecimento(s) não confirmado(s):' + LineBreak;
      break;
    end;
  end;

  //Montando a mensagem de retorno para os Manifestos nao confirmados
  for I := 0 to FManifestos.Count - 1 do
  begin
    if not FManifestos.Items[I].Confirmada then
      FMsg := FMsg + IntToStr(FManifestos.Items[I].MDFe.Ide.nMDF) + '->' +
                     FManifestos.Items[I].Msg + LineBreak;
  end;

  if AInfProt.Count > 0 then
  begin
     FChaveMDFe := AInfProt.Items[0].chMDFe;
     FProtocolo := AInfProt.Items[0].nProt;
     FcStat     := AInfProt.Items[0].cStat;
  end;
end;

function TMDFeRetRecepcao.Executar: Boolean;
var
  IntervaloTentativas, vCont, qTent: Integer;
begin
  Result := False;

  TACBrMDFe(FACBrMDFe).SetStatus(stMDFeRetRecepcao);
  try
    Sleep(FConfiguracoes.WebServices.AguardarConsultaRet);

    vCont := 1000;
    qTent := 0; // Inicializa o contador de tentativas
    IntervaloTentativas := FConfiguracoes.WebServices.IntervaloTentativas;

    while (inherited Executar) and
          (qTent < FConfiguracoes.WebServices.Tentativas) do
    begin
      Inc(qTent);

      if IntervaloTentativas > 0 then
        sleep(IntervaloTentativas)
      else
        Sleep(vCont);
    end;
  finally
    TACBrMDFe(FACBrMDFe).SetStatus(stMDFeIdle);
  end;

  if FMDFeRetorno.CStat = 104 then  // Lote processado ?
    Result := TratarRespostaFinal;
end;

procedure TMDFeRetRecepcao.DefinirURL;
begin
  FLayout := LayMDFeRetRecepcao;

  inherited DefinirURL;
end;

procedure TMDFeRetRecepcao.DefinirServicoEAction;
begin
  FServico    := CURL_WSDL + 'MDFeRetRecepcao';
  FSoapAction := FServico + '/mdfeRetRecepcao';
end;

procedure TMDFeRetRecepcao.DefinirDadosMsg;
var
  ConsReciMDFe: TConsReciMDFe;
begin
  ConsReciMDFe := TConsReciMDFe.Create;
  try
    ConsReciMDFe.tpAmb := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo - 1);
    ConsReciMDFe.nRec  := FRecibo;

    ConsReciMDFe.GerarXML;

    FDadosMsg := ConsReciMDFe.Gerador.ArquivoFormatoXML;
  finally
    ConsReciMDFe.Free;
  end;
end;

function TMDFeRetRecepcao.TratarResposta: Boolean;
begin
  FRetWS := SeparaDados(FRetornoWS, 'mdfeRetRecepcaoResult');

  // Limpando variaveis internas
  FMDFeRetorno.Free;
  FMDFeRetorno := TRetConsReciMDFe.Create;

  FMDFeRetorno.Leitor.Arquivo := FRetWS;
  FMDFeRetorno.LerXML;

  Fversao   := FMDFeRetorno.versao;
  FTpAmb    := FMDFeRetorno.TpAmb;
  FverAplic := FMDFeRetorno.verAplic;
  FcStat    := FMDFeRetorno.cStat;
  FcUF      := FMDFeRetorno.cUF;
  FMsg      := FMDFeRetorno.xMotivo;
  FxMotivo  := FMDFeRetorno.xMotivo;
//  FcMsg     := FMDFeRetorno.cMsg;
//  FxMsg     := FMDFeRetorno.xMsg;

  Result := (FMDFeRetorno.CStat = 105); // Lote em Processamento
end;

procedure TMDFeRetRecepcao.FinalizarServico;
begin
  ConfAmbiente;
  // Não libera para stIdle... não ainda...;
end;

function TMDFeRetRecepcao.GerarMsgLog: AnsiString;
begin
  Result := 'Versão Layout : '     + FMDFeRetorno.versao + LineBreak +
            'Ambiente : '          + TpAmbToStr(FMDFeRetorno.tpAmb) + LineBreak +
            'Versão Aplicativo : ' + FMDFeRetorno.verAplic + LineBreak +
            'Recibo : '            + FMDFeRetorno.nRec + LineBreak +
            'Status Código : '     + IntToStr(FMDFeRetorno.cStat) + LineBreak +
            'Status Descrição : '  + FMDFeRetorno.xMotivo + LineBreak +
            'UF : '                + CodigoParaUF(FMDFeRetorno.cUF) + LineBreak {+
            'cMsg : '              + IntToStr(FMDFeRetorno.cMsg) + LineBreak +
            'xMsg : '              + FMDFeRetorno.xMsg + LineBreak};
end;

function TMDFeRetRecepcao.GerarPrefixoArquivo: AnsiString;
begin
  Result := Recibo;
end;

{ TMDFeRecibo }

constructor TMDFeRecibo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FMDFeRetorno := TRetConsReciMDFe.Create;

  FStatus  := stMDFeRecibo;
  FLayout  := LayMDFeRetRecepcao;
  FArqEnv  := 'ped-rec';
  FArqResp := 'pro-rec';
end;

destructor TMDFeRecibo.Destroy;
begin
  FMDFeRetorno.Free;
  inherited Destroy;
end;

procedure TMDFeRecibo.DefinirServicoEAction;
begin
  FServico    := CURL_WSDL + 'MDFeRetRecepcao';
  FSoapAction := FServico + '/mdfeRetRecepcao';
end;

procedure TMDFeRecibo.DefinirURL;
begin
  FLayout := LayMDFeRetRecepcao;

  inherited DefinirURL;
end;

procedure TMDFeRecibo.DefinirDadosMsg;
var
  ConsReciMDFe: TConsReciMDFe;
begin
  ConsReciMDFe := TConsReciMDFe.Create;
  try
    ConsReciMDFe.tpAmb := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo - 1);
    ConsReciMDFe.nRec  := FRecibo;

    ConsReciMDFe.GerarXML;

    FDadosMsg := ConsReciMDFe.Gerador.ArquivoFormatoXML;
  finally
    ConsReciMDFe.Free;
  end;
end;

function TMDFeRecibo.TratarResposta: Boolean;
begin
  FRetWS := SeparaDados(FRetornoWS, 'mdfeRetRecepcaoResult');

  // Limpando variaveis internas
  FMDFeRetorno.Free;
  FMDFeRetorno := TRetConsReciMDFe.Create;

  FMDFeRetorno.Leitor.Arquivo := FRetWS;
  FMDFeRetorno.LerXML;

  Fversao   := FMDFeRetorno.versao;
  FTpAmb    := FMDFeRetorno.TpAmb;
  FverAplic := FMDFeRetorno.verAplic;
  FcStat    := FMDFeRetorno.cStat;
  FxMotivo  := FMDFeRetorno.xMotivo;
  FcUF      := FMDFeRetorno.cUF;
//  FxMsg     := FMDFeRetorno.xMsg;
//  FcMsg     := FMDFeRetorno.cMsg;
  FMsg      := FxMotivo;

  Result := (FMDFeRetorno.CStat = 104);
end;

function TMDFeRecibo.GerarMsgLog: AnsiString;
begin
  Result := 'Versão Layout : '     + FMDFeRetorno.versao + LineBreak +
            'Ambiente : '          + TpAmbToStr(FMDFeRetorno.TpAmb) + LineBreak +
            'Versão Aplicativo : ' + FMDFeRetorno.verAplic + LineBreak +
            'Recibo : '            + FMDFeRetorno.nRec + LineBreak +
            'Status Código : '     + IntToStr(FMDFeRetorno.cStat) + LineBreak +
            'Status Descrição : '  + FMDFeRetorno.ProtMDFe.Items[0].xMotivo + LineBreak +
            'UF : '                + CodigoParaUF(FMDFeRetorno.cUF) + LineBreak;
end;

{ TMDFeConsulta }

constructor TMDFeConsulta.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FprotMDFe := TProcMDFe.Create;
  FprocEventoMDFe := TRetEventoMDFeCollection.Create(AOwner);

  FStatus  := stMDFeConsulta;
  FLayout  := LayMDFeConsulta;
  FArqEnv  := 'ped-sit';
  FArqResp := 'sit';
end;

destructor TMDFeConsulta.Destroy;
begin
  FprotMDFe.Free;
  if Assigned(FprocEventoMDFe) then
    FprocEventoMDFe.Free;

  Inherited Destroy;
end;

procedure TMDFeConsulta.DefinirServicoEAction;
begin
  FServico    := CURL_WSDL + 'MDFeConsulta';
  FSoapAction := FServico + '/mdfeConsultaMDF';
end;

procedure TMDFeConsulta.DefinirDadosMsg;
var
  ConsSitMDFe: TConsSitMDFe;
begin
  ConsSitMDFe := TConsSitMDFe.Create;
  try
    ConsSitMDFe.TpAmb  := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo - 1);
    ConsSitMDFe.chMDFe := FMDFeChave;

    ConsSitMDFe.GerarXML;

    FDadosMsg := ConsSitMDFe.Gerador.ArquivoFormatoXML;
  finally
    ConsSitMDFe.Free;
  end;
end;

function TMDFeConsulta.TratarResposta: Boolean;
var
  MDFeRetorno: TRetConsSitMDFe;
  MDFCancelado, Atualiza: Boolean;
  aEventos, aMsg, NomeArquivo, aMDFe, aMDFeDFe: String;
  AProcMDFe: TProcMDFe;
  I, J, K, Inicio, Fim: Integer;
  Data: TDateTime;
  LocMDFeW: TMDFeW;
begin
  MDFeRetorno := TRetConsSitMDFe.Create;
  try
    FRetWS := SeparaDados(FRetornoWS, 'mdfeConsultaMDFResult');

    MDFeRetorno.Leitor.Arquivo := FRetWS;
    MDFeRetorno.LerXML;

    MDFCancelado := False;
    aEventos     := '';

    // <retConsSitMDFe> - Retorno da consulta da situação do MDF-e
    // Este é o status oficial do MDF-e
    Fversao    := MDFeRetorno.versao;
    FTpAmb     := MDFeRetorno.TpAmb;
    FverAplic  := MDFeRetorno.verAplic;
    FcStat     := MDFeRetorno.cStat;
    FxMotivo   := MDFeRetorno.xMotivo;
    FcUF       := MDFeRetorno.cUF;
    FMDFeChave := MDFeRetorno.chMDFe;
    FMsg       := MDFeRetorno.XMotivo;

    // <protMDFe> - Retorno dos dados do ENVIO do MDF-e
    // Considerá-los apenas se não existir nenhum evento de cancelamento (110111)
    FprotMDFe.PathMDFe            := MDFeRetorno.protMDFe.PathMDFe;
    FprotMDFe.PathRetConsReciMDFe := MDFeRetorno.protMDFe.PathRetConsReciMDFe;
    FprotMDFe.PathRetConsSitMDFe  := MDFeRetorno.protMDFe.PathRetConsSitMDFe;
    FprotMDFe.tpAmb               := MDFeRetorno.protMDFe.tpAmb;
    FprotMDFe.verAplic            := MDFeRetorno.protMDFe.verAplic;
    FprotMDFe.chMDFe              := MDFeRetorno.protMDFe.chMDFe;
    FprotMDFe.dhRecbto            := MDFeRetorno.protMDFe.dhRecbto;
    FprotMDFe.nProt               := MDFeRetorno.protMDFe.nProt;
    FprotMDFe.digVal              := MDFeRetorno.protMDFe.digVal;
    FprotMDFe.cStat               := MDFeRetorno.protMDFe.cStat;
    FprotMDFe.xMotivo             := MDFeRetorno.protMDFe.xMotivo;

    if Assigned(MDFeRetorno.procEventoMDFe) and
       (MDFeRetorno.procEventoMDFe.Count > 0) then
    begin
      aEventos := '=====================================================' +
                  LineBreak +
                  '================== Eventos da MDF-e =================' +
                  LineBreak +
                  '====================================================='+
                  LineBreak + '' + LineBreak +
                  'Quantidade total de eventos: ' +
                  IntToStr(MDFeRetorno.procEventoMDFe.Count);

      FprocEventoMDFe.Clear;
      for I := 0 to MDFeRetorno.procEventoMDFe.Count - 1 do
      begin
        FprocEventoMDFe.Add;
        FprocEventoMDFe.Items[I].RetEventoMDFe.idLote   := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.idLote;
        FprocEventoMDFe.Items[I].RetEventoMDFe.tpAmb    := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.tpAmb;
        FprocEventoMDFe.Items[I].RetEventoMDFe.verAplic := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.verAplic;
        FprocEventoMDFe.Items[I].RetEventoMDFe.cOrgao   := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.cOrgao;
        FprocEventoMDFe.Items[I].RetEventoMDFe.cStat    := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.cStat;
        FprocEventoMDFe.Items[I].RetEventoMDFe.xMotivo  := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.xMotivo;
        FprocEventoMDFe.Items[I].RetEventoMDFe.XML      := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.XML;

        FprocEventoMDFe.Items[I].RetEventoMDFe.Infevento.ID              := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.InfEvento.ID;
        FprocEventoMDFe.Items[I].RetEventoMDFe.Infevento.tpAmb           := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.InfEvento.tpAmb;
        FprocEventoMDFe.Items[I].RetEventoMDFe.InfEvento.CNPJ            := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.InfEvento.CNPJ;
        FprocEventoMDFe.Items[I].RetEventoMDFe.InfEvento.chMDFe          := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.InfEvento.chMDFe;
        FprocEventoMDFe.Items[I].RetEventoMDFe.InfEvento.dhEvento        := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.InfEvento.dhEvento;
        FprocEventoMDFe.Items[I].RetEventoMDFe.InfEvento.TpEvento        := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.InfEvento.TpEvento;
        FprocEventoMDFe.Items[I].RetEventoMDFe.InfEvento.nSeqEvento      := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.InfEvento.nSeqEvento;
        FprocEventoMDFe.Items[I].RetEventoMDFe.InfEvento.VersaoEvento    := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.InfEvento.VersaoEvento;
        FprocEventoMDFe.Items[I].RetEventoMDFe.InfEvento.DetEvento.nProt := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.InfEvento.DetEvento.nProt;
        FprocEventoMDFe.Items[I].RetEventoMDFe.InfEvento.DetEvento.xJust := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.InfEvento.DetEvento.xJust;
        FprocEventoMDFe.Items[I].RetEventoMDFe.InfEvento.DetEvento.xNome := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.InfEvento.DetEvento.xNome;
        FprocEventoMDFe.Items[I].RetEventoMDFe.InfEvento.DetEvento.CPF   := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.InfEvento.DetEvento.CPF;

        FprocEventoMDFe.Items[I].RetEventoMDFe.retEvento.Clear;
        for J := 0 to MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.retEvento.Count - 1 do
        begin
          FprocEventoMDFe.Items[I].RetEventoMDFe.retEvento.Add;
          FprocEventoMDFe.Items[I].RetEventoMDFe.retEvento.Items[j].RetInfEvento.Id          := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.retEvento.Items[j].RetInfEvento.Id;
          FprocEventoMDFe.Items[I].RetEventoMDFe.retEvento.Items[j].RetInfEvento.tpAmb       := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.retEvento.Items[j].RetInfEvento.tpAmb;
          FprocEventoMDFe.Items[I].RetEventoMDFe.retEvento.Items[j].RetInfEvento.verAplic    := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.retEvento.Items[j].RetInfEvento.verAplic;
          FprocEventoMDFe.Items[I].RetEventoMDFe.retEvento.Items[j].RetInfEvento.cOrgao      := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.retEvento.Items[j].RetInfEvento.cOrgao;
          FprocEventoMDFe.Items[I].RetEventoMDFe.retEvento.Items[j].RetInfEvento.cStat       := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.retEvento.Items[j].RetInfEvento.cStat;
          FprocEventoMDFe.Items[I].RetEventoMDFe.retEvento.Items[j].RetInfEvento.xMotivo     := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.retEvento.Items[j].RetInfEvento.xMotivo;
          FprocEventoMDFe.Items[I].RetEventoMDFe.retEvento.Items[j].RetInfEvento.chMDFe      := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.retEvento.Items[j].RetInfEvento.chMDFe;
          FprocEventoMDFe.Items[I].RetEventoMDFe.retEvento.Items[j].RetInfEvento.tpEvento    := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.retEvento.Items[j].RetInfEvento.tpEvento;
          FprocEventoMDFe.Items[I].RetEventoMDFe.retEvento.Items[j].RetInfEvento.xEvento     := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.retEvento.Items[j].RetInfEvento.xEvento;
          FprocEventoMDFe.Items[I].RetEventoMDFe.retEvento.Items[j].RetInfEvento.nSeqEvento  := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.retEvento.Items[j].RetInfEvento.nSeqEvento;
          FprocEventoMDFe.Items[I].RetEventoMDFe.retEvento.Items[j].RetInfEvento.CNPJDest    := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.retEvento.Items[j].RetInfEvento.CNPJDest;
          FprocEventoMDFe.Items[I].RetEventoMDFe.retEvento.Items[j].RetInfEvento.emailDest   := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.retEvento.Items[j].RetInfEvento.emailDest;
          FprocEventoMDFe.Items[I].RetEventoMDFe.retEvento.Items[j].RetInfEvento.dhRegEvento := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.retEvento.Items[j].RetInfEvento.dhRegEvento;
          FprocEventoMDFe.Items[I].RetEventoMDFe.retEvento.Items[j].RetInfEvento.nProt       := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.retEvento.Items[j].RetInfEvento.nProt;
          FprocEventoMDFe.Items[I].RetEventoMDFe.retEvento.Items[j].RetInfEvento.XML         := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.retEvento.Items[j].RetInfEvento.XML;

          aEventos := aEventos + LineBreak + LineBreak +
                      'Número de sequência: ' + IntToStr(MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.InfEvento.nSeqEvento) + LineBreak +
                      'Código do evento: '    + TpEventoToStr(MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.InfEvento.TpEvento) + LineBreak +
                      'Descrição do evento: ' + ACBrStrToAnsi(MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.InfEvento.DescEvento) + LineBreak +
                      'Status do evento: '    + IntToStr(MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.retEvento.Items[J].RetInfEvento.cStat) + LineBreak +
                      'Descrição do status: ' + ACBrStrToAnsi(MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.retEvento.Items[J].RetInfEvento.xMotivo) + LineBreak +
                      'Protocolo: '           + MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.retEvento.Items[J].RetInfEvento.nProt + LineBreak +
                      'Data / hora do registro: ' + DateTimeToStr(MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.retEvento.Items[J].RetInfEvento.dhRegEvento);

          if MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.retEvento.Items[J].RetInfEvento.tpEvento = teCancelamento then
          begin
            MDFCancelado := True;
            FProtocolo   := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.retEvento.Items[J].RetInfEvento.nProt;
            FDhRecbto    := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.retEvento.Items[J].RetInfEvento.dhRegEvento;
            FMsg         := MDFeRetorno.procEventoMDFe.Items[I].RetEventoMDFe.retEvento.Items[J].RetInfEvento.xMotivo;
          end;
        end;
      end;
    end;

    if not MDFCancelado then
    begin
      FProtocolo := MDFeRetorno.protMDFe.nProt;
      FDhRecbto  := MDFeRetorno.protMDFe.dhRecbto;
      FMsg       := MDFeRetorno.protMDFe.xMotivo;
    end;

    aMsg := GerarMsgLog;
    if aEventos <> '' then
      aMsg := aMsg + sLineBreak + aEventos;

    Result := (MDFeRetorno.CStat in [100, 101, 110, 132, 150, 151, 155]);

    NomeArquivo := PathWithDelim(FConfiguracoes.Geral.PathSalvar) + FMDFeChave;

    for i := 0 to TACBrMDFe(FACBrMDFe).Manifestos.Count-1 do
    begin
      if OnlyNumber(FMDFeChave) = OnlyNumber(TACBrMDFe( FACBrMDFe ).Manifestos.Items[i].MDFe.infMDFe.Id) then
//      if pos(String(FMDFeChave), TACBrMDFe(FACBrMDFe).Manifestos.Items[i].MDFe.infMDFe.ID) > 0 then
      begin
        Atualiza := True;
        if ((MDFeRetorno.CStat in [101, 151, 155]) and
           (not FConfiguracoes.Geral.AtualizarXMLCancelado)) then
          Atualiza := False;

        TACBrMDFe(FACBrMDFe).Manifestos.Items[i].Confirmada := (MDFeRetorno.cStat in [100, 150]);
        if Atualiza then
        begin
          if (TACBrMDFe( FACBrMDFe ).Configuracoes.Geral.ValidarDigest ) and
             (TACBrMDFe( FACBrMDFe ).Manifestos.Items[i].MDFe.Signature.DigestValue <> MDFeRetorno.protMDFe.digVal) and
             (MDFeRetorno.protMDFe.digVal <> '') then
           begin
             raise EACBrMDFeException.Create('DigestValue do documento '+
                                             OnlyNumber(TACBrMDFe( FACBrMDFe ).Manifestos.Items[i].MDFe.infMDFe.Id)+
                                             ' não confere.');
           end;
          TACBrMDFe(FACBrMDFe).Manifestos.Items[i].Msg                    := FprotMDFe.xMotivo;
          TACBrMDFe(FACBrMDFe).Manifestos.Items[i].MDFe.procMDFe.tpAmb    := FprotMDFe.tpAmb;
          TACBrMDFe(FACBrMDFe).Manifestos.Items[i].MDFe.procMDFe.verAplic := FprotMDFe.verAplic;
          TACBrMDFe(FACBrMDFe).Manifestos.Items[i].MDFe.procMDFe.chMDFe   := FprotMDFe.chMDFe;
          TACBrMDFe(FACBrMDFe).Manifestos.Items[i].MDFe.procMDFe.dhRecbto := FprotMDFe.dhRecbto;
          TACBrMDFe(FACBrMDFe).Manifestos.Items[i].MDFe.procMDFe.nProt    := FprotMDFe.nProt;
          TACBrMDFe(FACBrMDFe).Manifestos.Items[i].MDFe.procMDFe.digVal   := FprotMDFe.digVal;
          TACBrMDFe(FACBrMDFe).Manifestos.Items[i].MDFe.procMDFe.cStat    := FprotMDFe.cStat;
          TACBrMDFe(FACBrMDFe).Manifestos.Items[i].MDFe.procMDFe.xMotivo  := FprotMDFe.xMotivo;

          if FileExists(NomeArquivo + '-mdfe.xml') or
             NaoEstaVazio(TACBrMDFe(FACBrMDFe).Manifestos.Items[i].NomeArq) then
          begin
            AProcMDFe := TProcMDFe.Create;
            try
              if NaoEstaVazio(TACBrMDFe(FACBrMDFe).Manifestos.Items[i].NomeArq) then
                AProcMDFe.PathMDFe := TACBrMDFe(FACBrMDFe).Manifestos.Items[i].NomeArq
              else
                AProcMDFe.PathMDFe := NomeArquivo + '-mdfe.xml';

              AProcMDFe.PathRetConsSitMDFe := NomeArquivo + '-sit.xml';

              AProcMDFe.GerarXML;

              aMDFe := AProcMDFe.Gerador.ArquivoFormatoXML;

              if NaoEstaVazio(AProcMDFe.Gerador.ArquivoFormatoXML) then
                AProcMDFe.Gerador.SalvarArquivo(AProcMDFe.PathMDFe);

              FRetMDFeDFe := '';

              if (NaoEstaVazio(aMDFe)) and
                 (NaoEstaVazio(SeparaDados(FRetWS, 'procEventoMDFe'))) then
              begin
                Inicio := Pos('<procEventoMDFe', FRetWS);
                Fim    := Pos('</retConsSitMDFe', FRetWS) - 1;

                aEventos := Copy(FRetWS, Inicio, Fim - Inicio + 1);

                aMDFeDFe := '<?xml version="1.0" encoding="UTF-8" ?>' +
                            '<MDFeDFe>' +
                             '<procMDFe versao="' + MDFeenviMDFe + '">' +
                               SeparaDados(aMDFe, 'MDFeProc') +
                             '</procMDFe>' +
                             '<procEventoMDFe versao="' + MDFeEventoMDFe + '">' +
                               aEventos +
                             '</procEventoMDFe>' +
                            '</MDFeDFe>';

                FRetMDFeDFe := aMDFeDFe;
              end;
            finally
              AProcMDFe.Free;
            end;
          end
          else begin
           LocMDFeW := TMDFeW.Create(TACBrMDFe(FACBrMDFe).Manifestos.Items[i].MDFe);
           try
             LocMDFeW.GerarXML;

             aMDFe := LocMDFeW.Gerador.ArquivoFormatoXML;

             FRetMDFeDFe := '';

             if (NaoEstaVazio(aMDFe)) and
                (NaoEstaVazio(SeparaDados(FRetWS, 'procEventoMDFe'))) then
              begin
                Inicio := Pos('<procEventoMDFe', FRetWS);
                Fim    := Pos('</retConsSitMDFe', FRetWS) -1;

                aEventos := Copy(FRetWS, Inicio, Fim - Inicio + 1);

                aMDFeDFe := '<?xml version="1.0" encoding="UTF-8" ?>' +
                            '<MDFeDFe>' +
                             '<procMDFe versao="' + MDFeenviMDFe + '">' +
                               SeparaDados(aMDFe, 'MDFeProc') +
                             '</procMDFe>' +
                             '<procEventoMDFe versao="' + MDFeEventoMDFe + '">' +
                               aEventos +
                             '</procEventoMDFe>' +
                            '</MDFeDFe>';

                FRetMDFeDFe := aMDFeDFe;
              end;
           finally
             LocMDFeW.Free;
           end;
          end;

          if FConfiguracoes.Arquivos.Salvar then
          begin
            if FConfiguracoes.Arquivos.EmissaoPathMDFe then
              Data := TACBrMDFe(FACBrMDFe).Manifestos.Items[i].MDFe.Ide.dhEmi
            else
              Data := Now;

            if FConfiguracoes.Arquivos.SalvarApenasMDFeProcessados then
             begin
                if TACBrMDFe( FACBrMDFe ).Manifestos.Items[i].MDFe.procMDFe.cStat in [100, 150] then
                  TACBrMDFe( FACBrMDFe ).Manifestos.Items[i].SaveToFile(
                      PathWithDelim(FConfiguracoes.Arquivos.GetPathMDFe(Data,
                      TACBrMDFe( FACBrMDFe ).Manifestos.Items[i].MDFe.Emit.CNPJ)) +
                      OnlyNumber(TACBrMDFe( FACBrMDFe ).Manifestos.Items[i].MDFe.InfMDFe.Id) + '-mdfe.xml')

             end
            else
               TACBrMDFe( FACBrMDFe ).Manifestos.Items[i].SaveToFile(
                   PathWithDelim(FConfiguracoes.Arquivos.GetPathMDFe(Data,
                   TACBrMDFe( FACBrMDFe ).Manifestos.Items[i].MDFe.Emit.CNPJ)) +
                   OnlyNumber(TACBrMDFe( FACBrMDFe ).Manifestos.Items[i].MDFe.InfMDFe.Id) + '-mdfe.xml')
          end;

          if FConfiguracoes.Arquivos.Salvar and (FRetMDFeDFe <> '') then
          begin
            if FConfiguracoes.Arquivos.EmissaoPathMDFe then
              Data := TACBrMDFe(FACBrMDFe).Manifestos.Items[i].MDFe.Ide.dhEmi
            else
              Data := Now;

            FConfiguracoes.Geral.Save(FMDFeChave + '-MDFeDFe.xml',
                                      aMDFeDFe,
                                      PathWithDelim(FConfiguracoes.Arquivos.GetPathMDFe(Data)));
          end;
        end;

        break;
      end;
    end;

    if (TACBrMDFe(FACBrMDFe).Manifestos.Count <= 0) then
    begin
      if FConfiguracoes.Geral.Salvar then
      begin
        if FileExists(NomeArquivo + '-mdfe.xml') then
        begin
          AProcMDFe := TProcMDFe.Create;
          try
            AProcMDFe.PathMDFe := NomeArquivo + '-mdfe.xml';
            AProcMDFe.PathRetConsSitMDFe := NomeArquivo + '-sit.xml';

            AProcMDFe.GerarXML;

            aMDFe := AProcMDFe.Gerador.ArquivoFormatoXML;

            if NaoEstaVazio(AProcMDFe.Gerador.ArquivoFormatoXML) then
              AProcMDFe.Gerador.SalvarArquivo(AProcMDFe.PathMDFe);

            if (NaoEstaVazio(aMDFe)) and
               (NaoEstaVazio(SeparaDados(FRetWS, 'procEventoMDFe'))) then
            begin
              Inicio := Pos('<procEventoMDFe', FRetWS);
              Fim    := Pos('</retConsSitMDFe', FRetWS) -1;

              aEventos := Copy(FRetWS, Inicio, Fim - Inicio + 1);

              aMDFeDFe := '<?xml version="1.0" encoding="UTF-8" ?>' +
                          '<MDFeDFe>' +
                           '<procMDFe versao="' + MDFeenviMDFe + '">' +
                             SeparaDados(aMDFe, 'MDFeProc') +
                           '</procMDFe>' +
                           '<procEventoMDFe versao="' + MDFeEventoMDFe + '">' +
                             aEventos +
                           '</procEventoMDFe>' +
                          '</MDFeDFe>';

              FRetMDFeDFe := aMDFeDFe;
            end;
          finally
            AProcMDFe.Free;
          end;
        end;

        if (FConfiguracoes.Arquivos.Salvar) and (FRetMDFeDFe <> '') then
        begin
          if FConfiguracoes.Arquivos.EmissaoPathMDFe then
            Data := TACBrMDFe(FACBrMDFe).Manifestos.Items[i].MDFe.Ide.dhEmi
          else
            Data := Now;

          FConfiguracoes.Geral.Save(FMDFeChave + '-MDFeDFe.xml',
                                    aMDFeDFe,
                                    PathWithDelim(FConfiguracoes.Arquivos.GetPathMDFe(Data)));
        end;
      end;
    end;
  finally
    MDFeRetorno.Free;
  end;
end;

function TMDFeConsulta.GerarMsgLog: AnsiString;
begin
  Result := 'Versão Layout : '     + Fversao + LineBreak +
            'Identificador : '     + FMDFeChave + LineBreak +
            'Ambiente : '          + TpAmbToStr(FTpAmb) + LineBreak +
            'Versão Aplicativo : ' + FverAplic + LineBreak+
            'Status Código : '     + IntToStr(FcStat) + LineBreak+
            'Status Descrição : '  + FXMotivo + LineBreak +
            'UF : '                + CodigoParaUF(FcUF) + LineBreak +
            'Chave Acesso : '      + FMDFeChave + LineBreak +
            'Recebimento : '       + DateTimeToStr(FDhRecbto) + LineBreak +
            'Protocolo : '         + FProtocolo + LineBreak +
            'Digest Value : '      + FprotMDFe.digVal + LineBreak;
end;

function TMDFeConsulta.GerarPrefixoArquivo: AnsiString;
begin
  Result := Trim(FMDFeChave);
end;

{ TMDFeEnvEvento }

constructor TMDFeEnvEvento.Create(AOwner: TComponent; AEvento: TEventoMDFe);
begin
  inherited Create(AOwner);

  FEventoRetorno := TRetEventoMDFe.Create;

  FEvento  := AEvento;
  FStatus  := stMDFeEvento;
  FLayout  := LayMDFeEvento;
  FArqEnv  := 'ped-eve';
  FArqResp := 'eve';
end;

destructor TMDFeEnvEvento.Destroy;
begin
  FEventoRetorno.Free;

  inherited;
end;

function TMDFeEnvEvento.GerarPathEvento: String;
begin
  Result := FConfiguracoes.Arquivos.GetPathEvento(FEvento.Evento.Items[0].InfEvento.tpEvento);
end;

procedure TMDFeEnvEvento.DefinirURL;
begin
  { Verificação necessária pois somente os eventos de Cancelamento e CCe serão tratados pela SEFAZ do estado
    os outros eventos como manifestacao de destinatários serão tratados diretamente pela RFB }

  FLayout := LayMDFeEvento;

  inherited DefinirURL;
end;

procedure TMDFeEnvEvento.DefinirServicoEAction;
begin
  FServico    := CURL_WSDL + 'MDFeRecepcaoEvento';
  FSoapAction := FServico + '/mdfeRecepcaoEvento';
end;

procedure TMDFeEnvEvento.DefinirDadosMsg;
var
  EventoMDFe: TEventoMDFe;
  I, J, F: Integer;
  Lote, Evento, Eventos, EventosAssinados: String;
begin
  EventoMDFe := TEventoMDFe.Create;
  try
    EventoMDFe.idLote := FidLote;

    for i := 0 to TMDFeEnvEvento(Self).FEvento.Evento.Count-1 do
     begin
       with EventoMDFe.Evento.Add do
        begin
          infEvento.tpAmb      := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo-1);
          infEvento.CNPJ       := TMDFeEnvEvento(Self).FEvento.Evento[i].InfEvento.CNPJ;
          infEvento.chMDFe     := TMDFeEnvEvento(Self).FEvento.Evento[i].InfEvento.chMDFe;
          infEvento.dhEvento   := TMDFeEnvEvento(Self).FEvento.Evento[i].InfEvento.dhEvento;
          infEvento.tpEvento   := TMDFeEnvEvento(Self).FEvento.Evento[i].InfEvento.tpEvento;
          infEvento.nSeqEvento := TMDFeEnvEvento(Self).FEvento.Evento[i].InfEvento.nSeqEvento;

          case InfEvento.tpEvento of
            teCancelamento:
            begin
              infEvento.detEvento.nProt := TMDFeEnvEvento(Self).FEvento.Evento[i].InfEvento.detEvento.nProt;
              infEvento.detEvento.xJust := TMDFeEnvEvento(Self).FEvento.Evento[i].InfEvento.detEvento.xJust;
            end;
            teEncerramento:
            begin
              infEvento.detEvento.nProt := TMDFeEnvEvento(Self).FEvento.Evento[i].InfEvento.detEvento.nProt;
              infEvento.detEvento.dtEnc := TMDFeEnvEvento(Self).FEvento.Evento[i].InfEvento.detEvento.dtEnc;
              infEvento.detEvento.cUF   := TMDFeEnvEvento(Self).FEvento.Evento[i].InfEvento.detEvento.cUF;
              infEvento.detEvento.cMun  := TMDFeEnvEvento(Self).FEvento.Evento[i].InfEvento.detEvento.cMun;
            end;
            teInclusaoCondutor:
            begin
              infEvento.detEvento.xNome := TMDFeEnvEvento(Self).FEvento.Evento[i].InfEvento.detEvento.xNome;
              infEvento.detEvento.CPF   := TMDFeEnvEvento(Self).FEvento.Evento[i].InfEvento.detEvento.CPF;
            end;
          end;
        end;
     end;

    EventoMDFe.GerarXML;
    (*
    // Separa os grupos <evento> e coloca na variável Eventos
    I       := Pos('<evento ', EventoMDFe.Gerador.ArquivoFormatoXML);
    Lote    := Copy(EventoMDFe.Gerador.ArquivoFormatoXML, 1, I - 1);
    Eventos := SeparaDados(EventoMDFe.Gerador.ArquivoFormatoXML, 'envEvento');
    I       := Pos('<evento ', Eventos);
    Eventos := Copy(Eventos, I, length(Eventos));

    EventosAssinados := '';

    // Realiza a assinatura para cada evento
    while Eventos <> '' do
    begin
      F := Pos('</evento>', Eventos);

      if F > 0 then
      begin
        Evento  := Copy(Eventos, 1, F + 8);
        Eventos := Copy(Eventos, F + 9, length(Eventos));

        AssinarXML(Evento,
                   'Falha ao assinar o Envio de Evento ' + LineBreak + FMsg);

        EventosAssinados := EventosAssinados + FDadosMsg;
      end
      else
        Break;
    end;

    F := Pos('?>', EventosAssinados);
    if F <> 0 then
      FDadosMsg := copy(EventosAssinados, 1, F + 1) +
                   Lote +
                   copy(EventosAssinados, F + 2, Length(EventosAssinados)) +
                   '</envEvento>'
    else
      FDadosMsg := Lote + EventosAssinados + '</envEvento>';
    *)

    AssinarXML(EventoMDFe.Gerador.ArquivoFormatoXML,
               'Falha ao assinar o Envio de Evento ' + LineBreak + FMsg);

    if not(MValida(FDadosMsg, FMsg, TACBrMDFe(FACBrMDFe).Configuracoes.Geral.PathSchemas)) then
      GerarException('Falha na validação dos dados do Envio de Evento ' +
                     LineBreak + FMsg);

    for I := 0 to FEvento.Evento.Count-1 do
      FEvento.Evento[I].InfEvento.id := EventoMDFe.Evento[I].InfEvento.id;
  finally
    EventoMDFe.Free;
  end;
end;

function TMDFeEnvEvento.TratarResposta: Boolean;
var
  Leitor: TLeitor;
  I, J: Integer;
  wProc: TStringList;
  NomeArq: String;
begin
  FEvento.idLote := idLote;

  FRetWS := SeparaDados(FRetornoWS, 'mdfeRecepcaoEventoResult');

  // Limpando variaveis internas
  FEventoRetorno.Free;
  FEventoRetorno := TRetEventoMDFe.Create;

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
          if FEvento.Evento.Items[I].InfEvento.chMDFe = FEventoRetorno.retEvento.Items[J].RetInfEvento.chMDFe then
          begin
            FEvento.Evento.Items[I].RetInfEvento.nProt       := FEventoRetorno.retEvento.Items[J].RetInfEvento.nProt;
            FEvento.Evento.Items[I].RetInfEvento.dhRegEvento := FEventoRetorno.retEvento.Items[J].RetInfEvento.dhRegEvento;
            FEvento.Evento.Items[I].RetInfEvento.cStat       := FEventoRetorno.retEvento.Items[J].RetInfEvento.cStat;
            FEvento.Evento.Items[I].RetInfEvento.xMotivo     := FEventoRetorno.retEvento.Items[J].RetInfEvento.xMotivo;
            FEvento.Evento.Items[i].RetInfEvento.chMDFe      := FEventoRetorno.retEvento.Items[j].RetInfEvento.chMDFe;

            wProc := TStringList.Create;
            try
              wProc.Add('<?xml version="1.0" encoding="UTF-8" ?>');
              wProc.Add('<procEventoMDFe versao="' + GetVersaoMDFe(FConfiguracoes.Geral.VersaoDF,
                                                                 LayMDFeEvento) +
                                      '" xmlns="http://www.portalfiscal.inf.br/mdfe">');
              wProc.Add('<eventoMDFe versao="' + GetVersaoMDFe(FConfiguracoes.Geral.VersaoDF,
                                                               LayMDFeEvento) + '">');
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
              wProc.Add('</eventoMDFe>');
              wProc.Add('<retEventoMDFe versao="' + GetVersaoMDFe(FConfiguracoes.Geral.VersaoDF,
                                                                  LayMDFeEvento) + '">');

              Leitor.Arquivo := FRetWS;
              wProc.Add(UTF8Encode(Leitor.rExtrai(1, 'infEvento', '', J + 1)));
              wProc.Add('</retEventoMDFe>');
              wProc.Add('</procEventoMDFe>');

              FEventoRetorno.retEvento.Items[J].RetInfEvento.XML := wProc.Text;

              FEvento.Evento.Items[I].RetInfEvento.XML := wProc.Text;

              NomeArq := OnlyNumber(FEvento.Evento.Items[i].InfEvento.Id) +
                         '-procEventoMDFe.xml';

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

procedure TMDFeEnvEvento.SalvarEnvio;
begin
  inherited SalvarEnvio;

  if FConfiguracoes.Arquivos.Salvar then
    FConfiguracoes.Geral.Save(GerarPrefixoArquivo + '-' + ArqEnv + '.xml',
                              FDadosMsg, GerarPathEvento);
end;

procedure TMDFeEnvEvento.SalvarResposta;
begin
  inherited SalvarResposta;

  if FConfiguracoes.Arquivos.Salvar then
    FConfiguracoes.Geral.Save(GerarPrefixoArquivo + '-' + ArqEnv + '.xml',
                              FDadosMsg, GerarPathEvento);
end;

function TMDFeEnvEvento.GerarMsgLog: AnsiString;
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

function TMDFeEnvEvento.GerarPrefixoArquivo: AnsiString;
begin
  Result := IntToStr(FEvento.idLote);
end;

{ TMDFeConsultaMDFeNaoEnc }

constructor TMDFeConsultaMDFeNaoEnc.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FInfMDFe := TRetInfMDFeCollection.Create(AOwner);

  FStatus  := stMDFeConsulta;
  FLayout  := LayMDFeConsNaoEnc;
  FArqEnv  := 'ped-cons';
  FArqResp := 'cons';
end;

destructor TMDFeConsultaMDFeNaoEnc.Destroy;
begin
  FinfMDFe.Free;

  inherited;
end;

procedure TMDFeConsultaMDFeNaoEnc.DefinirURL;
begin
  FLayout := LayMDFeConsNaoEnc;

  inherited DefinirURL;
end;

procedure TMDFeConsultaMDFeNaoEnc.DefinirServicoEAction;
begin
  FServico    := CURL_WSDL + 'MDFeConsNaoEnc';
  FSoapAction := FServico + '/mdfeConsNaoEnc';
end;

procedure TMDFeConsultaMDFeNaoEnc.DefinirDadosMsg;
var
  ConsMDFeNaoEnc: TConsMDFeNaoEnc;
begin
  ConsMDFeNaoEnc := TConsMDFeNaoEnc.create;
  try
    ConsMDFeNaoEnc.TpAmb := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo - 1);
    ConsMDFeNaoEnc.CNPJ  := FCNPJ; // TMDFeConsultaMDFeNaoEnc(Self).CNPJ;

    ConsMDFeNaoEnc.Gerador.Opcoes.RetirarAcentos := FConfiguracoes.Geral.RetirarAcentos;
    
    ConsMDFeNaoEnc.GerarXML;

    // Atribuindo o XML para propriedade interna //
    FDadosMsg := ConsMDFeNaoEnc.Gerador.ArquivoFormatoXML;
  finally
    ConsMDFeNaoEnc.Free;
  end;
end;

function TMDFeConsultaMDFeNaoEnc.TratarResposta: Boolean;
var
  MDFeRetorno: TRetConsMDFeNaoEnc;
  i: Integer;
begin
//  FRetWS := SeparaDados(FRetornoWS, 'mdfeConsNaoEncMDFResult');
  FRetWS := SeparaDados(FRetornoWS, 'mdfeConsNaoEncResult');

  MDFeRetorno := TRetConsMDFeNaoEnc.Create;
  try
    MDFeRetorno.Leitor.Arquivo := FRetWS;
    MDFeRetorno.LerXml;

    Fversao    := MDFeRetorno.versao;
    FtpAmb     := MDFeRetorno.tpAmb;
    FverAplic  := MDFeRetorno.verAplic;
    FcStat     := MDFeRetorno.cStat;
    FxMotivo   := MDFeRetorno.xMotivo;
    FcUF       := MDFeRetorno.cUF;
    FMsg       := FxMotivo;

    for i := 0 to MDFeRetorno.InfMDFe.Count -1 do
    begin
     FinfMDFe.Add;
     FinfMDFe.Items[i].chMDFe := MDFeRetorno.InfMDFe.Items[i].chMDFe;
     FinfMDFe.Items[i].nProt  := MDFeRetorno.InfMDFe.Items[i].nProt;
    end;

    // 111 = MDF-e não encerrados localizados
    // 112 = MDF-e não encerrados não localizados
    Result := (FcStat in [111, 112]);

  finally
    MDFeRetorno.Free;
  end;
end;

function TMDFeConsultaMDFeNaoEnc.GerarMsgLog: AnsiString;
begin
  Result := 'Versão Layout : '     + Fversao + LineBreak +
            'Ambiente : '          + TpAmbToStr(FtpAmb) + LineBreak +
            'Versão Aplicativo : ' + FverAplic + LineBreak +
            'Status Código : '     + IntToStr(FcStat) + LineBreak +
            'Status Descrição : '  + FxMotivo + LineBreak +
            'UF : '                + CodigoParaUF(FcUF) + LineBreak;
end;

function TMDFeConsultaMDFeNaoEnc.GerarMsgErro(E: Exception): AnsiString;
begin
  Result := 'WebService Consulta MDF-e nao Encerrado:' + LineBreak +
            '- Inativo ou Inoperante tente novamente.' + LineBreak +
            '- ' + E.Message
end;

{ TMDFeEnvioWebService }

constructor TMDFeEnvioWebService.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FStatus := stMDFeEnvioWebService;
end;

destructor TMDFeEnvioWebService.Destroy;
begin
  inherited Destroy;
end;

function TMDFeEnvioWebService.Executar: Boolean;
begin
  Result := inherited Executar;
end;

procedure TMDFeEnvioWebService.DefinirURL;
begin
  FURL := FURLEnvio;
end;

procedure TMDFeEnvioWebService.DefinirServicoEAction;
begin
  FServico := FSoapAction;
end;

procedure TMDFeEnvioWebService.DefinirDadosMsg;
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

function TMDFeEnvioWebService.TratarResposta: Boolean;
begin
  FRetWS := SeparaDados(FRetornoWS, 'soap:Body');
  Result := True;
end;

function TMDFeEnvioWebService.GerarMsgLog: AnsiString;
begin
  Result := inherited GerarMsgLog;
end;

function TMDFeEnvioWebService.GerarMsgErro(E: Exception): AnsiString;
begin
  Result := 'WebService' + LineBreak +
            '- Inativo ou Inoperante tente novamente.' + LineBreak +
            '- ' + E.Message;
end;

function TMDFeEnvioWebService.GerarVersaoDadosSoap: AnsiString;
begin
  Result := '<versaoDados>' +
              FVersao +
            '</versaoDados>';
end;

{ TWebServices }

constructor TWebServices.Create(AFMDFe: TComponent);
begin
  FACBrMDFe        := TACBrMDFe(AFMDFe);
  FStatusServico   := TMDFeStatusServico.Create(AFMDFe);
  FEnviar          := TMDFeRecepcao.Create(AFMDFe, TACBrMDFe(AFMDFe).Manifestos);
  FRetorno         := TMDFeRetRecepcao.Create(AFMDFe, TACBrMDFe(AFMDFe).Manifestos);
  FRecibo          := TMDFeRecibo.Create(AFMDFe);
  FConsulta        := TMDFeConsulta.Create(AFMDFe);
  FConsMDFeNaoEnc  := TMDFeConsultaMDFeNaoEnc.Create(AFMDFe);
  FEnvEvento       := TMDFeEnvEvento.Create(AFMDFe, TACBrMDFe(AFMDFe).EventoMDFe);
  FEnvioWebService := TMDFeEnvioWebService.Create(AFMDFe);
end;

destructor TWebServices.Destroy;
begin
  FStatusServico.Free;
  FEnviar.Free;
  FRetorno.Free;
  FRecibo.Free;
  FConsulta.Free;
  FConsMDFeNaoEnc.Free;
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

function TWebServices.ConsultaMDFeNaoEnc(ACNPJ: String): Boolean;
begin
  FConsMDFeNaoEnc.FCNPJ := ACNPJ;

  if not FConsMDFeNaoEnc.Executar then
    FConsMDFeNaoEnc.GerarException(FConsMDFeNaoEnc.Msg);

  Result := True;
end;

end.
