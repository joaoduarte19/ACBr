{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Italo Giurizzato Junior                         }
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

unit ACBrNFAgWebServices;

interface

uses
  Classes, SysUtils, dateutils,
  blcksock, synacode,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  pcnConversao,
  ACBrDFe, ACBrDFeWebService,
  ACBrDFeComum.RetConsReciDFe,
  ACBrDFeComum.Proc,
  ACBrDFeComum.RetEnvio,
  ACBrDFeComum.DistDFeInt, ACBrDFeComum.RetDistDFeInt,
  ACBrNFAgNotasFiscais, ACBrNFAgConfiguracoes,
  ACBrNFAg.Classes, ACBrNFAg.Conversao,
  ACBrNFAg.EnvEvento, ACBrNFAg.RetEnvEvento,
  ACBrNFAg.RetConsSit;

type

  { TNFAgWebService }

  TNFAgWebService = class(TDFeWebService)
  private
    FOldSSLType: TSSLType;
    FOldHeaderElement: String;
  protected
    FPStatus: TStatusNFAg;
    FPLayout: TLayOut;
    FPConfiguracoesNFAg: TConfiguracoesNFAg;

  protected
    procedure InicializarServico; override;
    procedure DefinirURL; override;
    function GerarVersaoDadosSoap: String; override;
    procedure EnviarDados; override;
    procedure FinalizarServico; override;
    procedure RemoverNameSpace;

  public
    constructor Create(AOwner: TACBrDFe); override;
    procedure Clear; override;

    property Status: TStatusNFAg read FPStatus;
    property Layout: TLayOut read FPLayout;
  end;

  { TNFAgStatusServico }

  TNFAgStatusServico = class(TNFAgWebService)
  private
    Fversao: String;
    FtpAmb: TpcnTipoAmbiente;
    FverAplic: String;
    FcStat: integer;
    FxMotivo: String;
    FcUF: integer;
    FdhRecbto: TDateTime;
    FTMed: integer;
    FdhRetorno: TDateTime;
    FxObs: String;
  protected
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    function TratarResposta: Boolean; override;

    function GerarMsgLog: String; override;
    function GerarMsgErro(E: Exception): String; override;
  public
    procedure Clear; override;

    property versao: String read Fversao;
    property tpAmb: TpcnTipoAmbiente read FtpAmb;
    property verAplic: String read FverAplic;
    property cStat: integer read FcStat;
    property xMotivo: String read FxMotivo;
    property cUF: integer read FcUF;
    property dhRecbto: TDateTime read FdhRecbto;
    property TMed: integer read FTMed;
    property dhRetorno: TDateTime read FdhRetorno;
    property xObs: String read FxObs;
  end;

  { TNFAgRecepcao }

  TNFAgRecepcao = class(TNFAgWebService)
  private
    FLote: String;
    FRecibo: String;
    FNotasFiscais: TNotasFiscais;
    Fversao: String;
    FTpAmb: TpcnTipoAmbiente;
    FverAplic: String;
    FcStat: integer;
    FcUF: integer;
    FxMotivo: String;
    FdhRecbto: TDateTime;
    FTMed: integer;
//    FSincrono: Boolean;
    FVersaoDF: TVersaoNFAg;

    FNFAgRetornoSincrono: TRetConsSitNFAg;
    FNFAgRetorno: TretEnvDFe;
    FMsgUnZip: String;

    function GetLote: String;
    function GetRecibo: String;
  protected
    procedure InicializarServico; override;
    procedure DefinirURL; override;
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    function TratarResposta: Boolean; override;

    function GerarMsgLog: String; override;
    function GerarPrefixoArquivo: String; override;
  public
    constructor Create(AOwner: TACBrDFe; ANotasFiscais: TNotasFiscais);
      reintroduce; overload;
    destructor Destroy; override;
    procedure Clear; override;

    property Recibo: String read GetRecibo;
    property versao: String read Fversao;
    property TpAmb: TpcnTipoAmbiente read FTpAmb;
    property verAplic: String read FverAplic;
    property cStat: integer read FcStat;
    property cUF: integer read FcUF;
    property xMotivo: String read FxMotivo;
    property dhRecbto: TDateTime read FdhRecbto;
    property TMed: integer read FTMed;
    property Lote: String read GetLote write FLote;
//    property Sincrono: Boolean read FSincrono write FSincrono;
    property MsgUnZip: String read FMsgUnZip write FMsgUnZip;

    property NFAgRetornoSincrono: TRetConsSitNFAg read FNFAgRetornoSincrono;
  end;

  { TNFAgRetRecepcao }

  TNFAgRetRecepcao = class(TNFAgWebService)
  private
    FRecibo: String;
    FProtocolo: String;
    FChaveNFAg: String;
    FNotasFiscais: TNotasFiscais;
    Fversao: String;
    FTpAmb: TACBrTipoAmbiente;
    FverAplic: String;
    FcStat: integer;
    FcUF: integer;
    FxMotivo: String;
    FcMsg: integer;
    FxMsg: String;
    FVersaoDF: TVersaoNFAg;

    FNFAgRetorno: TRetConsReciDFe;

    function GetRecibo: String;
    function TratarRespostaFinal: Boolean;
  protected
    procedure InicializarServico; override;
    procedure DefinirURL; override;
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    function TratarResposta: Boolean; override;
    procedure FinalizarServico; override;

    function GerarMsgLog: String; override;
    function GerarPrefixoArquivo: String; override;
  public
    constructor Create(AOwner: TACBrDFe; ANotasFiscais: TNotasFiscais);
      reintroduce; overload;
    destructor Destroy; override;
    procedure Clear; override;

    function Executar: Boolean; override;

    property versao: String read Fversao;
    property TpAmb: TACBrTipoAmbiente read FTpAmb;
    property verAplic: String read FverAplic;
    property cStat: integer read FcStat;
    property cUF: integer read FcUF;
    property xMotivo: String read FxMotivo;
    property cMsg: integer read FcMsg;
    property xMsg: String read FxMsg;
    property Recibo: String read GetRecibo write FRecibo;
    property Protocolo: String read FProtocolo write FProtocolo;
    property ChaveNFAg: String read FChaveNFAg write FChaveNFAg;

    property NFAgRetorno: TRetConsReciDFe read FNFAgRetorno;
  end;

  { TNFAgRecibo }

  TNFAgRecibo = class(TNFAgWebService)
  private
    FNotasFiscais: TNotasFiscais;
    FRecibo: String;
    Fversao: String;
    FTpAmb: TpcnTipoAmbiente;
    FverAplic: String;
    FcStat: integer;
    FxMotivo: String;
    FcUF: integer;
    FxMsg: String;
    FcMsg: integer;
    FVersaoDF: TVersaoNFAg;

    FNFAgRetorno: TRetConsReciDFe;
  protected
    procedure InicializarServico; override;
    procedure DefinirServicoEAction; override;
    procedure DefinirURL; override;
    procedure DefinirDadosMsg; override;
    function TratarResposta: Boolean; override;

    function GerarMsgLog: String; override;
  public
    constructor Create(AOwner: TACBrDFe; ANotasFiscais: TNotasFiscais);
      reintroduce; overload;
    destructor Destroy; override;
    procedure Clear; override;

    property versao: String read Fversao;
    property TpAmb: TpcnTipoAmbiente read FTpAmb;
    property verAplic: String read FverAplic;
    property cStat: integer read FcStat;
    property xMotivo: String read FxMotivo;
    property cUF: integer read FcUF;
    property xMsg: String read FxMsg;
    property cMsg: integer read FcMsg;
    property Recibo: String read FRecibo write FRecibo;

    property NFAgRetorno: TRetConsReciDFe read FNFAgRetorno;
  end;

  { TNFAgConsulta }

  TNFAgConsulta = class(TNFAgWebService)
  private
    FOwner: TACBrDFe;
    FNFAgChave: String;
    FExtrairEventos: Boolean;
    FNotasFiscais: TNotasFiscais;
    FProtocolo: String;
    FDhRecbto: TDateTime;
    FXMotivo: String;
    Fversao: String;
    FTpAmb: TpcnTipoAmbiente;
    FverAplic: String;
    FcStat: integer;
    FcUF: integer;
    FRetNFAgDFe: String;

    FprotNFAg: TProcDFe;
    FprocEventoNFAg: TRetEventoNFAgCollection;

    procedure SetNFAgChave(const AValue: String);
  protected
    procedure DefinirURL; override;
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    function GerarUFSoap: String; override;
    function TratarResposta: Boolean; override;

    function GerarMsgLog: String; override;
    function GerarPrefixoArquivo: String; override;
  public
    constructor Create(AOwner: TACBrDFe; ANotasFiscais: TNotasFiscais);
      reintroduce; overload;
    destructor Destroy; override;
    procedure Clear; override;

    property NFAgChave: String read FNFAgChave write SetNFAgChave;
    property ExtrairEventos: Boolean read FExtrairEventos write FExtrairEventos;
    property Protocolo: String read FProtocolo;
    property DhRecbto: TDateTime read FDhRecbto;
    property XMotivo: String read FXMotivo;
    property versao: String read Fversao;
    property TpAmb: TpcnTipoAmbiente read FTpAmb;
    property verAplic: String read FverAplic;
    property cStat: integer read FcStat;
    property cUF: integer read FcUF;
    property RetNFAgDFe: String read FRetNFAgDFe;

    property protNFAg: TProcDFe read FprotNFAg;
    property procEventoNFAg: TRetEventoNFAgCollection read FprocEventoNFAg;
  end;

  { TNFAgEnvEvento }

  TNFAgEnvEvento = class(TNFAgWebService)
  private
    FidLote: Int64;
    FEvento: TEventoNFAg;
    FcStat: integer;
    FxMotivo: String;
    FTpAmb: TACBrTipoAmbiente;
    FCNPJ: String;

    FEventoRetorno: TRetEventoNFAg;

    function GerarPathEvento(const ACNPJ: String = ''; const AIE: String = ''): String;
  protected
    procedure DefinirURL; override;
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    function TratarResposta: Boolean; override;

    function GerarMsgLog: String; override;
    function GerarPrefixoArquivo: String; override;
  public
    constructor Create(AOwner: TACBrDFe; AEvento: TEventoNFAg); reintroduce; overload;
    destructor Destroy; override;
    procedure Clear; override;

    property idLote: Int64 read FidLote write FidLote;
    property cStat: integer read FcStat;
    property xMotivo: String read FxMotivo;
    property TpAmb: TACBrTipoAmbiente read FTpAmb;

    property EventoRetorno: TRetEventoNFAg read FEventoRetorno;
  end;

  { TDistribuicaoDFe }

  TDistribuicaoDFe = class(TNFAgWebService)
  private
    FOwner: TACBrDFe;
    FcUFAutor: integer;
    FCNPJCPF: String;
    FultNSU: String;
    FNSU: String;
    FchNFAg: String;
    FNomeArq: String;
    FlistaArqs: TStringList;

    FretDistDFeInt: TretDistDFeInt;

    function GerarPathDistribuicao(AItem :TdocZipCollectionItem): String;
  protected
    procedure DefinirURL; override;
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    function TratarResposta: Boolean; override;

    function GerarMsgLog: String; override;
    function GerarMsgErro(E: Exception): String; override;
  public
//    constructor Create(AOwner: TACBrDFe); override;
    constructor Create(AOwner: TACBrDFe); reintroduce; overload;
    destructor Destroy; override;
    procedure Clear; override;

    property cUFAutor: integer read FcUFAutor write FcUFAutor;
    property CNPJCPF: String read FCNPJCPF write FCNPJCPF;
    property ultNSU: String read FultNSU write FultNSU;
    property NSU: String read FNSU write FNSU;
    property chNFAg: String read FchNFAg write FchNFAg;
    property NomeArq: String read FNomeArq;
    property ListaArqs: TStringList read FlistaArqs;

    property retDistDFeInt: TretDistDFeInt read FretDistDFeInt;
  end;

  { TNFAgEnvioWebService }

  TNFAgEnvioWebService = class(TNFAgWebService)
  private
    FXMLEnvio: String;
    FPURLEnvio: String;
    FVersao: String;
    FSoapActionEnvio: String;
  protected
    procedure DefinirURL; override;
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    function TratarResposta: Boolean; override;

    function GerarMsgErro(E: Exception): String; override;
    function GerarVersaoDadosSoap: String; override;
  public
    constructor Create(AOwner: TACBrDFe); override;
    destructor Destroy; override;
    procedure Clear; override;

    function Executar: Boolean; override;

    property Versao: String read FVersao;
    property XMLEnvio: String read FXMLEnvio write FXMLEnvio;
    property URLEnvio: String read FPURLEnvio write FPURLEnvio;
    property SoapActionEnvio: String read FSoapActionEnvio write FSoapActionEnvio;
  end;

  { TWebServices }

  TWebServices = class
  private
    FACBrNFAg: TACBrDFe;
    FStatusServico: TNFAgStatusServico;
    FEnviar: TNFAgRecepcao;
    FRetorno: TNFAgRetRecepcao;
    FRecibo: TNFAgRecibo;
    FConsulta: TNFAgConsulta;
    FEnvEvento: TNFAgEnvEvento;
    FDistribuicaoDFe: TDistribuicaoDFe;
    FEnvioWebService: TNFAgEnvioWebService;
  public
    constructor Create(AOwner: TACBrDFe); overload;
    destructor Destroy; override;

    function Envia(ALote: Int64; const ASincrono: Boolean = False): Boolean;
      overload;
    function Envia(const ALote: String; const ASincrono: Boolean = False): Boolean;
      overload;

    property ACBrNFAg: TACBrDFe read FACBrNFAg write FACBrNFAg;
    property StatusServico: TNFAgStatusServico read FStatusServico write FStatusServico;
    property Enviar: TNFAgRecepcao read FEnviar write FEnviar;
    property Retorno: TNFAgRetRecepcao read FRetorno write FRetorno;
    property Recibo: TNFAgRecibo read FRecibo write FRecibo;
    property Consulta: TNFAgConsulta read FConsulta write FConsulta;
    property EnvEvento: TNFAgEnvEvento read FEnvEvento write FEnvEvento;
    property DistribuicaoDFe: TDistribuicaoDFe
      read FDistribuicaoDFe write FDistribuicaoDFe;
    property EnvioWebService: TNFAgEnvioWebService
      read FEnvioWebService write FEnvioWebService;
  end;

implementation

uses
  StrUtils, Math,
  ACBrUtil.Base, ACBrUtil.XMLHTML, ACBrUtil.Strings, ACBrUtil.DateTime,
  ACBrUtil.FilesIO,
  ACBrCompress, ACBrIntegrador,
  ACBrDFeConsts,
  ACBrDFeUtil,
  ACBrDFeComum.ConsStatServ, ACBrDFeComum.RetConsStatServ,
  ACBrDFeComum.ConsReciDFe,
  ACBrNFAg,
  ACBrNFAg.Consts,
  ACBrNFAg.ConsSit;

{ TNFAgWebService }

constructor TNFAgWebService.Create(AOwner: TACBrDFe);
begin
  inherited Create(AOwner);

  FPConfiguracoesNFAg := TConfiguracoesNFAg(FPConfiguracoes);
  FPLayout := LayNFAgStatusServico;

  FPHeaderElement := ''; //'NFAgCabecMsg';
  FPBodyElement := 'NFAgDadosMsg';
end;

procedure TNFAgWebService.Clear;
begin
  inherited Clear;

  FPStatus := stIdle;
  if Assigned(FPDFeOwner) and Assigned(FPDFeOwner.SSL) then
    FPDFeOwner.SSL.UseCertificateHTTP := True;
end;

procedure TNFAgWebService.InicializarServico;
begin
  { Sobrescrever apenas se necessário }
  inherited InicializarServico;

  FOldSSLType := FPDFeOwner.SSL.SSLType;
  FOldHeaderElement := FPHeaderElement;

  FPHeaderElement := '';

  TACBrNFAg(FPDFeOwner).SetStatus(FPStatus);
end;

procedure TNFAgWebService.RemoverNameSpace;
begin
  FPRetWS := StringReplace(FPRetWS, ' xmlns="http://www.portalfiscal.inf.br/NFAg"',
                                    '', [rfReplaceAll, rfIgnoreCase]);
end;

procedure TNFAgWebService.DefinirURL;
var
  Versao: Double;
begin
  { sobrescrever apenas se necessário.
    Você também pode mudar apenas o valor de "FLayoutServico" na classe
    filha e chamar: Inherited;     }

  Versao := 0;
  FPVersaoServico := '';
  FPURL := '';
  FPServico := '';
  FPSoapAction := '';

  TACBrNFAg(FPDFeOwner).LerServicoDeParams(FPLayout, Versao, FPURL, FPServico, FPSoapAction);
  FPVersaoServico := FloatToString(Versao, '.', '0.00');
end;

function TNFAgWebService.GerarVersaoDadosSoap: String;
begin
  { Sobrescrever apenas se necessário }

  if EstaVazio(FPVersaoServico) then
    FPVersaoServico := TACBrNFAg(FPDFeOwner).LerVersaoDeParams(FPLayout);

  Result := '<versaoDados>' + FPVersaoServico + '</versaoDados>';
end;

procedure TNFAgWebService.EnviarDados;
var
//  UsaIntegrador: Boolean;
  Integrador: TACBrIntegrador;
begin
//  UsaIntegrador := Assigned(FPDFeOwner.Integrador);

  Integrador := Nil;

  try
    inherited EnviarDados;
  finally
    if Assigned(Integrador) then
      FPDFeOwner.Integrador := Integrador;
  end;
end;

procedure TNFAgWebService.FinalizarServico;
begin
  { Sobrescrever apenas se necessário }

  // Retornar configurações anteriores
  FPDFeOwner.SSL.SSLType := FOldSSLType;
  FPHeaderElement := FOldHeaderElement;

  TACBrNFAg(FPDFeOwner).SetStatus(stIdle);
end;

{ TNFAgStatusServico }

procedure TNFAgStatusServico.Clear;
begin
  inherited Clear;

  FPStatus := stNFAgStatusServico;
  FPLayout := LayNFAgStatusServico;
  FPArqEnv := 'ped-sta';
  FPArqResp := 'sta';

  Fversao := '';
  FverAplic := '';
  FcStat := 0;
  FxMotivo := '';
  FdhRecbto := 0;
  FTMed := 0;
  FdhRetorno := 0;
  FxObs := '';

  if Assigned(FPConfiguracoesNFAg) then
  begin
    FtpAmb := FPConfiguracoesNFAg.WebServices.Ambiente;
    FcUF := FPConfiguracoesNFAg.WebServices.UFCodigo;
  end
end;

procedure TNFAgStatusServico.DefinirServicoEAction;
begin
  FPServico := GetUrlWsd + 'NFAgStatusServico';
  FPSoapAction := FPServico + '/NFAgStatusServicoNF';
end;

procedure TNFAgStatusServico.DefinirDadosMsg;
var
  ConsStatServ: TConsStatServ;
begin
  ConsStatServ := TConsStatServ.Create(FPVersaoServico, NAME_SPACE_NFAg, 'NFAg', False);
  try
    ConsStatServ.TpAmb := FPConfiguracoesNFAg.WebServices.Ambiente;
    ConsStatServ.CUF := FPConfiguracoesNFAg.WebServices.UFCodigo;

    FPDadosMsg := ConsStatServ.GerarXML;
  finally
    ConsStatServ.Free;
  end;
end;

function TNFAgStatusServico.TratarResposta: Boolean;
var
  NFAgRetorno: TRetConsStatServ;
begin
  FPRetWS := SeparaDadosArray(['NFAgResultMsg'],FPRetornoWS );

  VerificarSemResposta;

  RemoverNameSpace;

  NFAgRetorno := TRetConsStatServ.Create('NFAg');
  try
    NFAgRetorno.XmlRetorno := ParseText(FPRetWS);
    NFAgRetorno.LerXml;

    Fversao := NFAgRetorno.versao;
    FtpAmb := TpcnTipoAmbiente(NFAgRetorno.tpAmb);
    FverAplic := NFAgRetorno.verAplic;
    FcStat := NFAgRetorno.cStat;
    FxMotivo := NFAgRetorno.xMotivo;
    FcUF := NFAgRetorno.cUF;

    { WebService do RS retorna horário de verão mesmo pros estados que não
      adotam esse horário, ao utilizar esta hora para basear a emissão da nota
      acontece o erro. }
    if (pos('svrs.rs.gov.br', FPURL) > 0) and
       (MinutesBetween(NFAgRetorno.dhRecbto, Now) > 50) and
       (not IsHorarioDeVerao(CodigoUFparaUF(FcUF), NFAgRetorno.dhRecbto)) then
      FdhRecbto:= IncHour(NFAgRetorno.dhRecbto,-1)
    else
      FdhRecbto := NFAgRetorno.dhRecbto;

    FTMed := NFAgRetorno.TMed;
    FdhRetorno := NFAgRetorno.dhRetorno;
    FxObs := NFAgRetorno.xObs;
    FPMsg := FxMotivo + LineBreak + FxObs;

    if Assigned(FPConfiguracoesNFAg) and
       Assigned(FPConfiguracoesNFAg.WebServices) and
       FPConfiguracoesNFAg.WebServices.AjustaAguardaConsultaRet then
      FPConfiguracoesNFAg.WebServices.AguardarConsultaRet := FTMed * 1000;

    Result := (FcStat = 107);

  finally
    NFAgRetorno.Free;
  end;
end;

function TNFAgStatusServico.GerarMsgLog: String;
begin
  {(*}
  Result := Format(ACBrStr('Versão Layout: %s ' + LineBreak +
                           'Ambiente: %s' + LineBreak +
                           'Versão Aplicativo: %s ' + LineBreak +
                           'Status Código: %s' + LineBreak +
                           'Status Descrição: %s' + LineBreak +
                           'UF: %s' + LineBreak +
                           'Recebimento: %s' + LineBreak +
                           'Tempo Médio: %s' + LineBreak +
                           'Retorno: %s' + LineBreak +
                           'Observação: %s' + LineBreak),
                   [Fversao, TpAmbToStr(FtpAmb), FverAplic, IntToStr(FcStat),
                    FxMotivo, CodigoUFparaUF(FcUF),
                    IfThen(FdhRecbto = 0, '', FormatDateTimeBr(FdhRecbto)),
                    IntToStr(FTMed),
                    IfThen(FdhRetorno = 0, '', FormatDateTimeBr(FdhRetorno)),
                    FxObs]);
  {*)}
end;

function TNFAgStatusServico.GerarMsgErro(E: Exception): String;
begin
  Result := ACBrStr('WebService Consulta Status serviço:' + LineBreak +
                    '- Inativo ou Inoperante tente novamente.');
end;

{ TNFAgRecepcao }

constructor TNFAgRecepcao.Create(AOwner: TACBrDFe; ANotasFiscais: TNotasFiscais);
begin
  inherited Create(AOwner);

  FNotasFiscais := ANotasFiscais;
end;

destructor TNFAgRecepcao.Destroy;
begin
  FNFAgRetornoSincrono.Free;
  FNFAgRetorno.Free;

  inherited Destroy;
end;

procedure TNFAgRecepcao.Clear;
begin
  inherited Clear;

  FPStatus := stNFAgRecepcao;
  FPLayout := LayNFAgRecepcao;
  FPArqEnv := 'env-lot';
  FPArqResp := 'rec';

  Fversao := '';
  FTMed := 0;
  FverAplic := '';
  FcStat    := 0;
  FxMotivo  := '';
  FRecibo   := '';
  FdhRecbto := 0;
  FMsgUnZip := '';

  if Assigned(FPConfiguracoesNFAg) then
  begin
    FtpAmb := FPConfiguracoesNFAg.WebServices.Ambiente;
    FcUF := FPConfiguracoesNFAg.WebServices.UFCodigo;
  end;

  if Assigned(FNFAgRetornoSincrono) then
    FNFAgRetornoSincrono.Free;

  if Assigned(FNFAgRetorno) then
    FNFAgRetorno.Free;

  FNFAgRetornoSincrono := TRetConsSitNFAg.Create;
  FNFAgRetorno := TretEnvDFe.Create;
end;

function TNFAgRecepcao.GetLote: String;
begin
  Result := Trim(FLote);
end;

function TNFAgRecepcao.GetRecibo: String;
begin
  Result := Trim(FRecibo);
end;

procedure TNFAgRecepcao.InicializarServico;
begin
//  Sincrono := True;

  if FNotasFiscais.Count > 0 then    // Tem NFAg ? Se SIM, use as informações do XML
    FVersaoDF := DblToVersaoNFAg(FNotasFiscais.Items[0].NFAg.infNFAg.Versao)
  else
    FVersaoDF := FPConfiguracoesNFAg.Geral.VersaoDF;

  inherited InicializarServico;

  FPHeaderElement := '';
end;

procedure TNFAgRecepcao.DefinirURL;
var
  xUF: String;
  VerServ: Double;
//  ok: Boolean;
begin
  if FNotasFiscais.Count > 0 then    // Tem NFAg ? Se SIM, use as informações do XML
  begin
    FcUF := FNotasFiscais.Items[0].NFAg.Ide.cUF;

    if Integer(FPConfiguracoesNFAg.WebServices.Ambiente) <> Integer(FNotasFiscais.Items[0].NFAg.Ide.tpAmb) then
      raise EACBrNFAgException.Create( ACBrNFAg_CErroAmbienteDiferente );
  end
  else
  begin // Se não tem NFAg, use as configurações do componente
    FcUF := FPConfiguracoesNFAg.WebServices.UFCodigo;
  end;

  VerServ := VersaoNFAgToDbl(FVersaoDF);
  FTpAmb  := FPConfiguracoesNFAg.WebServices.Ambiente;
  FPVersaoServico := '';
  FPURL := '';

  FPLayout := LayNFAgRecepcaoSinc;
{
  if FSincrono then
    FPLayout := LayNFAgRecepcaoSinc
  else
    FPLayout := LayNFAgRecepcao;
}
  // Configuração correta ao enviar para o SVC
  case FPConfiguracoesNFAg.Geral.FormaEmissao of
    teSVCAN: xUF := 'SVC-AN';
    teSVCRS: xUF := 'SVC-RS';
  else
    xUF := CodigoUFparaUF(FcUF);
  end;

  TACBrNFAg(FPDFeOwner).LerServicoDeParams(
    'NFAg',
    xUF,
    FTpAmb,
    LayOutToServico(FPLayout),
    VerServ,
    FPURL,
    FPServico,
    FPSoapAction);

  FPVersaoServico := FloatToString(VerServ, '.', '0.00');
end;

procedure TNFAgRecepcao.DefinirServicoEAction;
begin
  if EstaVazio(FPServico) then
    FPServico := GetUrlWsd + 'NFAgRecepcaoSinc';
  if EstaVazio(FPSoapAction) then
    FPSoapAction := FPServico + '/NFAgRecepcao';
  {
  if FSincrono then
  begin
    if EstaVazio(FPServico) then
      FPServico := GetUrlWsd + 'NFAgRecepcaoSinc';
    if EstaVazio(FPSoapAction) then
      FPSoapAction := FPServico + '/NFAgRecepcao';
  end
  else
  begin
    FPServico := GetUrlWsd + 'NFAgRecepcao';
    FPSoapAction := FPServico + '/NFAgRecepcaoLote';
  end;
  }
end;

procedure TNFAgRecepcao.DefinirDadosMsg;
//var
//  I: integer;
//  vNotas: String;
begin
  // No envio só podemos ter apena UM NF3-e, pois o seu processamento é síncrono
  if FNotasFiscais.Count > 1 then
    GerarException(ACBrStr('ERRO: Conjunto de NF3-e transmitidos (máximo de 1 NF3-e)' +
           ' excedido. Quantidade atual: ' + IntToStr(FNotasFiscais.Count)));

  if FNotasFiscais.Count > 0 then
    FPDadosMsg := '<NFAg' +
      RetornarConteudoEntre(FNotasFiscais.Items[0].XMLAssinado, '<NFAg', '</NFAg>') +
      '</NFAg>';
  {
  if Sincrono then
  begin
    // No envio só podemos ter apena UM NF3-e, pois o seu processamento é síncrono
    if FNotasFiscais.Count > 1 then
      GerarException(ACBrStr('ERRO: Conjunto de NF3-e transmitidos (máximo de 1 NF3-e)' +
             ' excedido. Quantidade atual: ' + IntToStr(FNotasFiscais.Count)));

    if FNotasFiscais.Count > 0 then
      FPDadosMsg := '<NFAg' +
        RetornarConteudoEntre(FNotasFiscais.Items[0].XMLAssinado, '<NFAg', '</NFAg>') +
        '</NFAg>';
  end
  else
  begin
    vNotas := '';

    for I := 0 to FNotasFiscais.Count - 1 do
      vNotas := vNotas + '<NFAg' + RetornarConteudoEntre(
        FNotasFiscais.Items[I].XMLAssinado, '<NFAg', '</NFAg>') + '</NFAg>';

    FPDadosMsg := '<enviNFAg xmlns="'+ACBRNFAg_NAMESPACE+'" versao="' +
      FPVersaoServico + '">' + '<idLote>' + FLote + '</idLote>' +
      vNotas + '</enviNFAg>';
  end;
  }
  FMsgUnZip := FPDadosMsg;

  FPDadosMsg := EncodeBase64(GZipCompress(FPDadosMsg));

  // Lote tem mais de 1 Mb ? //
  if Length(FPDadosMsg) > (1024 * 1024) then
    GerarException(ACBrStr('Tamanho do XML de Dados superior a 1 Mbytes. Tamanho atual: ' +
      IntToStr(trunc(Length(FPDadosMsg) / 1024)) + ' Kbytes'));

  FRecibo := '';
end;

function TNFAgRecepcao.TratarResposta: Boolean;
var
  I: integer;
  chNFAg, AXML, NomeXMLSalvo: String;
  AProcNFAg: TProcDFe;
  SalvarXML: Boolean;
begin
  FPRetWS := SeparaDadosArray(['NFAgResultMsg'], FPRetornoWS );

  VerificarSemResposta;

  RemoverNameSpace;

//  if FSincrono then
//  begin
    if pos('retNFAg', FPRetWS) > 0 then
      AXML := StringReplace(FPRetWS, 'retNFAg', 'retConsSitNFAg',
                                     [rfReplaceAll, rfIgnoreCase])
    else if pos('retConsReciNFAg', FPRetWS) > 0 then
      AXML := StringReplace(FPRetWS, 'retConsReciNFAg', 'retConsSitNFAg',
                                     [rfReplaceAll, rfIgnoreCase])
    else
      AXML := FPRetWS;

    FNFAgRetornoSincrono.XmlRetorno := ParseText(AXML);
    FNFAgRetornoSincrono.LerXml;

    Fversao := FNFAgRetornoSincrono.versao;
    FTpAmb := TpcnTipoAmbiente(FNFAgRetornoSincrono.TpAmb);
    FverAplic := FNFAgRetornoSincrono.verAplic;

    // Consta no Retorno da NFC-e
    FRecibo := FNFAgRetornoSincrono.nRec;
    FcUF := FNFAgRetornoSincrono.cUF;
    chNFAg := FNFAgRetornoSincrono.ProtNFAg.chDFe;

    if (FNFAgRetornoSincrono.protNFAg.cStat > 0) then
      FcStat := FNFAgRetornoSincrono.protNFAg.cStat
    else
      FcStat := FNFAgRetornoSincrono.cStat;

    if (FNFAgRetornoSincrono.protNFAg.xMotivo <> '') then
    begin
      FPMsg := FNFAgRetornoSincrono.protNFAg.xMotivo;
      FxMotivo := FNFAgRetornoSincrono.protNFAg.xMotivo;
    end
    else
    begin
      FPMsg := FNFAgRetornoSincrono.xMotivo;
      FxMotivo := FNFAgRetornoSincrono.xMotivo;
    end;

    // Verificar se a NF3-e foi autorizada com sucesso
    Result := (FNFAgRetornoSincrono.cStat = 104) and
      (TACBrNFAg(FPDFeOwner).CstatProcessado(FNFAgRetornoSincrono.protNFAg.cStat));

    if Result then
    begin
      for I := 0 to TACBrNFAg(FPDFeOwner).NotasFiscais.Count - 1 do
      begin
        with TACBrNFAg(FPDFeOwner).NotasFiscais.Items[I] do
        begin
          if OnlyNumber(chNFAg) = NumID then
          begin
            if (FPConfiguracoesNFAg.Geral.ValidarDigest) and
               (FNFAgRetornoSincrono.protNFAg.digVal <> '') and
               (NFAg.signature.DigestValue <> FNFAgRetornoSincrono.protNFAg.digVal) then
            begin
              raise EACBrNFAgException.Create('DigestValue do documento ' + NumID + ' não coNFAgre.');
            end;

            NFAg.procNFAg.cStat := FNFAgRetornoSincrono.protNFAg.cStat;
            NFAg.procNFAg.tpAmb := FNFAgRetornoSincrono.tpAmb;
            NFAg.procNFAg.verAplic := FNFAgRetornoSincrono.verAplic;
            NFAg.procNFAg.chDFe := FNFAgRetornoSincrono.ProtNFAg.chDFe;
            NFAg.procNFAg.dhRecbto := FNFAgRetornoSincrono.protNFAg.dhRecbto;
            NFAg.procNFAg.nProt := FNFAgRetornoSincrono.ProtNFAg.nProt;
            NFAg.procNFAg.digVal := FNFAgRetornoSincrono.protNFAg.digVal;
            NFAg.procNFAg.xMotivo := FNFAgRetornoSincrono.protNFAg.xMotivo;

            AProcNFAg := TProcDFe.Create(FPVersaoServico, NAME_SPACE_NFAg, 'NFAgProc', 'NFAg');
            try
              // Processando em UTF8, para poder gravar arquivo corretamente //
              AProcNFAg.XML_DFe := RemoverDeclaracaoXML(XMLAssinado);
              AProcNFAg.XML_Prot := FNFAgRetornoSincrono.XMLprotNFAg;
              XMLOriginal := AProcNFAg.GerarXML;

              if FPConfiguracoesNFAg.Arquivos.Salvar then
              begin
                SalvarXML := Processada;

                // Salva o XML da NF3-e assinado e protocolado
                if SalvarXML then
                begin
                  NomeXMLSalvo := '';
                  if NaoEstaVazio(NomeArq) and FileExists(NomeArq) then
                  begin
                    FPDFeOwner.Gravar( NomeArq, XMLOriginal ); // Atualiza o XML carregado
                    NomeXMLSalvo := NomeArq;
                  end;

                  if (NomeXMLSalvo <> CalcularNomeArquivoCompleto()) then
                    GravarXML; // Salva na pasta baseado nas configurações do PathNFAg
                end;
              end ;
            finally
              AProcNFAg.Free;
            end;
            Break;
          end;
        end;
      end;
    end;
  {
  end
  else
  begin
    FNFAgRetorno.XmlRetorno := ParseText(FPRetWS);
    FNFAgRetorno.LerXml;

    Fversao := FNFAgRetorno.versao;
    FTpAmb := TpcnTipoAmbiente(FNFAgRetorno.TpAmb);
    FverAplic := FNFAgRetorno.verAplic;
    FcStat := FNFAgRetorno.cStat;
    FxMotivo := FNFAgRetorno.xMotivo;
    FdhRecbto := FNFAgRetorno.infRec.dhRecbto;
    FTMed := FNFAgRetorno.infRec.tMed;
    FcUF := FNFAgRetorno.cUF;
    FPMsg := FNFAgRetorno.xMotivo;
    FRecibo := FNFAgRetorno.infRec.nRec;

    Result := (FNFAgRetorno.CStat = 103);
  end;
  }
end;

function TNFAgRecepcao.GerarMsgLog: String;
begin
  Result := Format(ACBrStr('Versão Layout: %s ' + LineBreak +
                         'Ambiente: %s ' + LineBreak +
                         'Versão Aplicativo: %s ' + LineBreak +
                         'Status Código: %s ' + LineBreak +
                         'Status Descrição: %s ' + LineBreak +
                         'UF: %s ' + sLineBreak +
                         'dhRecbto: %s ' + sLineBreak +
                         'chNFAg: %s ' + LineBreak),
                   [FNFAgRetornoSincrono.versao,
                    TipoAmbienteToStr(FNFAgRetornoSincrono.TpAmb),
                    FNFAgRetornoSincrono.verAplic,
                    IntToStr(FNFAgRetornoSincrono.protNFAg.cStat),
                    FNFAgRetornoSincrono.protNFAg.xMotivo,
                    CodigoUFparaUF(FNFAgRetornoSincrono.cUF),
                    FormatDateTimeBr(FNFAgRetornoSincrono.dhRecbto),
                    FNFAgRetornoSincrono.chNFAg]);
  {
  if FSincrono then
    Result := Format(ACBrStr('Versão Layout: %s ' + LineBreak +
                           'Ambiente: %s ' + LineBreak +
                           'Versão Aplicativo: %s ' + LineBreak +
                           'Status Código: %s ' + LineBreak +
                           'Status Descrição: %s ' + LineBreak +
                           'UF: %s ' + sLineBreak +
                           'dhRecbto: %s ' + sLineBreak +
                           'chNFAg: %s ' + LineBreak),
                     [FNFAgRetornoSincrono.versao,
                      TipoAmbienteToStr(FNFAgRetornoSincrono.TpAmb),
                      FNFAgRetornoSincrono.verAplic,
                      IntToStr(FNFAgRetornoSincrono.protNFAg.cStat),
                      FNFAgRetornoSincrono.protNFAg.xMotivo,
                      CodigoUFparaUF(FNFAgRetornoSincrono.cUF),
                      FormatDateTimeBr(FNFAgRetornoSincrono.dhRecbto),
                      FNFAgRetornoSincrono.chNFAg])
  else
    Result := Format(ACBrStr('Versão Layout: %s ' + LineBreak +
                             'Ambiente: %s ' + LineBreak +
                             'Versão Aplicativo: %s ' + LineBreak +
                             'Status Código: %s ' + LineBreak +
                             'Status Descrição: %s ' + LineBreak +
                             'UF: %s ' + sLineBreak +
                             'Recibo: %s ' + LineBreak +
                             'Recebimento: %s ' + LineBreak +
                             'Tempo Médio: %s ' + LineBreak),
                     [FNFAgRetorno.versao,
                      TipoAmbienteToStr(FNFAgRetorno.TpAmb),
                      FNFAgRetorno.verAplic,
                      IntToStr(FNFAgRetorno.cStat),
                      FNFAgRetorno.xMotivo,
                      CodigoUFparaUF(FNFAgRetorno.cUF),
                      FNFAgRetorno.infRec.nRec,
                      IfThen(FNFAgRetorno.InfRec.dhRecbto = 0, '',
                             FormatDateTimeBr(FNFAgRetorno.InfRec.dhRecbto)),
                      IntToStr(FNFAgRetorno.InfRec.TMed)]);
  }
end;

function TNFAgRecepcao.GerarPrefixoArquivo: String;
begin
  if FRecibo <> '' then
  begin
    Result := Recibo;
    FPArqResp := 'pro-rec';
  end
  else
  begin
    Result := Lote;
    FPArqResp := 'pro-lot';
  end;
  {
  if FSincrono then  // Esta procesando nome do Retorno Sincrono ?
  begin
    if FRecibo <> '' then
    begin
      Result := Recibo;
      FPArqResp := 'pro-rec';
    end
    else
    begin
      Result := Lote;
      FPArqResp := 'pro-lot';
    end;
  end
  else
    Result := Lote;
  }
end;

{ TNFAgRetRecepcao }

constructor TNFAgRetRecepcao.Create(AOwner: TACBrDFe; ANotasFiscais: TNotasFiscais);
begin
  inherited Create(AOwner);

  FNotasFiscais := ANotasFiscais;
end;

destructor TNFAgRetRecepcao.Destroy;
begin
  FNFAgRetorno.Free;

  inherited Destroy;
end;

function TNFAgRetRecepcao.GetRecibo: String;
begin
  Result := Trim(FRecibo);
end;

procedure TNFAgRetRecepcao.InicializarServico;
begin
  if FNotasFiscais.Count > 0 then    // Tem NFAg ? Se SIM, use as informações do XML
    FVersaoDF := DblToVersaoNFAg(FNotasFiscais.Items[0].NFAg.infNFAg.Versao)
  else
    FVersaoDF := FPConfiguracoesNFAg.Geral.VersaoDF;

  inherited InicializarServico;

  FPHeaderElement := '';
end;

procedure TNFAgRetRecepcao.Clear;
var
  i, j: Integer;
begin
  inherited Clear;

  FPStatus := stNFAgRetRecepcao;
  FPLayout := LayNFAgRetRecepcao;
  FPArqEnv := 'ped-rec';
  FPArqResp := 'pro-rec';

  FverAplic := '';
  FcStat := 0;
  FxMotivo := '';
  Fversao := '';
  FxMsg := '';
  FcMsg := 0;

  if Assigned(FPConfiguracoesNFAg) then
  begin
    FtpAmb := TACBrTipoAmbiente(FPConfiguracoesNFAg.WebServices.Ambiente);
    FcUF := FPConfiguracoesNFAg.WebServices.UFCodigo;
  end;

  if Assigned(FNFAgRetorno) and Assigned(FNotasFiscais)
		and Assigned(FNFAgRetorno.ProtDFe) then
  begin
    // Limpa Dados dos retornos das notas Fiscais;
    for i := 0 to FNFAgRetorno.ProtDFe.Count - 1 do
    begin
      for j := 0 to FNotasFiscais.Count - 1 do
      begin
        if OnlyNumber(FNFAgRetorno.ProtDFe.Items[i].chDFe) = FNotasFiscais.Items[J].NumID then
        begin
          FNotasFiscais.Items[j].NFAg.procNFAg.verAplic := '';
          FNotasFiscais.Items[j].NFAg.procNFAg.chDFe    := '';
          FNotasFiscais.Items[j].NFAg.procNFAg.dhRecbto := 0;
          FNotasFiscais.Items[j].NFAg.procNFAg.nProt    := '';
          FNotasFiscais.Items[j].NFAg.procNFAg.digVal   := '';
          FNotasFiscais.Items[j].NFAg.procNFAg.cStat    := 0;
          FNotasFiscais.Items[j].NFAg.procNFAg.xMotivo  := '';
        end;
      end;
    end;
  end;

  if Assigned( FNFAgRetorno ) then
    FreeAndNil(FNFAgRetorno);

  FNFAgRetorno := TRetConsReciDFe.Create('NFAg');
end;

function TNFAgRetRecepcao.Executar: Boolean;
var
  IntervaloTentativas, Tentativas: integer;
begin
  Result := False;

  TACBrNFAg(FPDFeOwner).SetStatus(stNFAgRetRecepcao);
  try
    Sleep(FPConfiguracoesNFAg.WebServices.AguardarConsultaRet);

    Tentativas := 0;
    IntervaloTentativas := max(FPConfiguracoesNFAg.WebServices.IntervaloTentativas, 1000);

    while (inherited Executar) and
      (Tentativas < FPConfiguracoesNFAg.WebServices.Tentativas) do
    begin
      Inc(Tentativas);
      sleep(IntervaloTentativas);
    end;
  finally
    TACBrNFAg(FPDFeOwner).SetStatus(stIdle);
  end;

  if FNFAgRetorno.CStat = 104 then  // Lote processado ?
    Result := TratarRespostaFinal;
end;

procedure TNFAgRetRecepcao.DefinirURL;
var
  xUF: String;
  VerServ: Double;
//  ok: Boolean;
begin
  if FNotasFiscais.Count > 0 then    // Tem NFAg ? Se SIM, use as informações do XML
  begin
    FcUF := FNotasFiscais.Items[0].NFAg.Ide.cUF;

    if Integer(FPConfiguracoesNFAg.WebServices.Ambiente) <> Integer(FNotasFiscais.Items[0].NFAg.Ide.tpAmb) then
      raise EACBrNFAgException.Create( ACBrNFAg_CErroAmbienteDiferente );
  end
  else
  begin                              // Se não tem NFAg, use as configurações do componente
    FcUF := FPConfiguracoesNFAg.WebServices.UFCodigo;
  end;

  VerServ := VersaoNFAgToDbl(FVersaoDF);
  FTpAmb := TACBrTipoAmbiente(FPConfiguracoesNFAg.WebServices.Ambiente);
  FPVersaoServico := '';
  FPURL := '';

  FPLayout := LayNFAgRetRecepcao;

  // Configuração correta ao enviar para o SVC
  case FPConfiguracoesNFAg.Geral.FormaEmissao of
    teSVCAN: xUF := 'SVC-AN';
    teSVCRS: xUF := 'SVC-RS';
  else
    xUF := CodigoUFparaUF(FcUF);
  end;

  TACBrNFAg(FPDFeOwner).LerServicoDeParams(
    'NFAg',
    xUF,
    TpcnTipoAmbiente(FTpAmb),
    LayOutToServico(FPLayout),
    VerServ,
    FPURL,
    FPServico,
    FPSoapAction);

  FPVersaoServico := FloatToString(VerServ, '.', '0.00');
end;

procedure TNFAgRetRecepcao.DefinirServicoEAction;
begin
//  if FPLayout = LayNFAgRetAutorizacao then
//  begin
//    if EstaVazio(FPServico) then
//      FPServico := GetUrlWsd + 'NFAgRetAutorizacao4';
//    if EstaVazio(FPSoapAction) then
//      FPSoapAction := FPServico +'/NFAgRetAutorizacaoLote';
//  end
//  else
//  begin
    FPServico := GetUrlWsd + 'NFAgRetRecepcao';
    FPSoapAction := FPServico + '/NFAgRetRecepcao';
//  end;
end;

procedure TNFAgRetRecepcao.DefinirDadosMsg;
var
  ConsReciNFAg: TConsReciDFe;
begin
  ConsReciNFAg := TConsReciDFe.Create(FPVersaoServico, NAME_SPACE_NFAg, 'NFAg');
  try
    ConsReciNFAg.tpAmb := TpcnTipoAmbiente(FTpAmb);
    ConsReciNFAg.nRec := FRecibo;

//    AjustarOpcoes( ConsReciNFAg.Gerador.Opcoes );
    FPDadosMsg := ConsReciNFAg.GerarXML;
  finally
    ConsReciNFAg.Free;
  end;
end;

function TNFAgRetRecepcao.TratarResposta: Boolean;
begin
  FPRetWS := SeparaDadosArray(['NFAgResultMsg'],FPRetornoWS );

  VerificarSemResposta;

  RemoverNameSpace;

  FNFAgRetorno.XmlRetorno := ParseText(FPRetWS);
  FNFAgRetorno.LerXML;

  Fversao := FNFAgRetorno.versao;
  FTpAmb := FNFAgRetorno.TpAmb;
  FverAplic := FNFAgRetorno.verAplic;
  FcStat := FNFAgRetorno.cStat;
  FcUF := FNFAgRetorno.cUF;
  FPMsg := FNFAgRetorno.xMotivo;
  FxMotivo := FNFAgRetorno.xMotivo;
  FcMsg := FNFAgRetorno.cMsg;
  FxMsg := FNFAgRetorno.xMsg;

  Result := (FNFAgRetorno.CStat = 105); // Lote em Processamento
end;

function TNFAgRetRecepcao.TratarRespostaFinal: Boolean;
var
  I, J: integer;
  AProcNFAg: TProcDFe;
  AInfProt: TProtDFeCollection;
  SalvarXML: Boolean;
  NomeXMLSalvo: String;
begin
  Result := False;

  AInfProt := FNFAgRetorno.ProtDFe;

  if (AInfProt.Count > 0) then
  begin
    FPMsg := FNFAgRetorno.ProtDFe.Items[0].xMotivo;
    FxMotivo := FNFAgRetorno.ProtDFe.Items[0].xMotivo;
  end;

  //Setando os retornos das notas fiscais;
  for I := 0 to AInfProt.Count - 1 do
  begin
    for J := 0 to FNotasFiscais.Count - 1 do
    begin
      if OnlyNumber(AInfProt.Items[I].chDFe) = FNotasFiscais.Items[J].NumID then
      begin
        if (FPConfiguracoesNFAg.Geral.ValidarDigest) and
           (AInfProt.Items[I].digVal <> '') and
           (FNotasFiscais.Items[J].NFAg.signature.DigestValue <> AInfProt.Items[I].digVal) then
        begin
          raise EACBrNFAgException.Create('DigestValue do documento ' +
            FNotasFiscais.Items[J].NumID + ' não coNFAgre.');
        end;

        with FNotasFiscais.Items[J] do
        begin
          NFAg.procNFAg.tpAmb := TACBrTipoAmbiente(AInfProt.Items[I].tpAmb);
          NFAg.procNFAg.verAplic := AInfProt.Items[I].verAplic;
          NFAg.procNFAg.chDFe := AInfProt.Items[I].chDFe;
          NFAg.procNFAg.dhRecbto := AInfProt.Items[I].dhRecbto;
          NFAg.procNFAg.nProt := AInfProt.Items[I].nProt;
          NFAg.procNFAg.digVal := AInfProt.Items[I].digVal;
          NFAg.procNFAg.cStat := AInfProt.Items[I].cStat;
          NFAg.procNFAg.xMotivo := AInfProt.Items[I].xMotivo;
        end;

        // Monta o XML da NF3-e assinado e com o protocolo de Autorização
        if (AInfProt.Items[I].cStat = 100) or (AInfProt.Items[I].cStat = 150) then
        begin
          AProcNFAg := TProcDFe.Create(FPVersaoServico, NAME_SPACE_NFAg, 'NFAgProc', 'NFAg');
          try
            AProcNFAg.XML_DFe := RemoverDeclaracaoXML(FNotasFiscais.Items[J].XMLAssinado);
            AProcNFAg.XML_Prot := AInfProt.Items[I].XMLprotDFe;

            with FNotasFiscais.Items[J] do
            begin
              XMLOriginal := AProcNFAg.GerarXML;

              if FPConfiguracoesNFAg.Arquivos.Salvar then
              begin
                SalvarXML := Processada;

                // Salva o XML da NF3-e assinado e protocolado
                if SalvarXML then
                begin
                  NomeXMLSalvo := '';
                  if NaoEstaVazio(NomeArq) and FileExists(NomeArq) then
                  begin
                    FPDFeOwner.Gravar( NomeArq, XMLOriginal );  // Atualiza o XML carregado
                    NomeXMLSalvo := NomeArq;
                  end;

                  if (NomeXMLSalvo <> CalcularNomeArquivoCompleto()) then
                    GravarXML; // Salva na pasta baseado nas configurações do PathNFAg
                end;
              end;
            end;
          finally
            AProcNFAg.Free;
          end;
        end;

        break;
      end;
    end;
  end;

  //Verificando se existe alguma nota confirmada
  for I := 0 to FNotasFiscais.Count - 1 do
  begin
    if FNotasFiscais.Items[I].Confirmada then
    begin
      Result := True;
      break;
    end;
  end;

  //Verificando se existe alguma nota nao confirmada
  for I := 0 to FNotasFiscais.Count - 1 do
  begin
    if not FNotasFiscais.Items[I].Confirmada then
    begin
      FPMsg := ACBrStr('Nota(s) não confirmadas:') + LineBreak;
      break;
    end;
  end;

  //Montando a mensagem de retorno para as notas nao confirmadas
  for I := 0 to FNotasFiscais.Count - 1 do
  begin
    if not FNotasFiscais.Items[I].Confirmada then
      FPMsg := FPMsg + IntToStr(FNotasFiscais.Items[I].NFAg.Ide.nNF) +
        '->' + IntToStr(FNotasFiscais.Items[I].cStat)+'-'+ FNotasFiscais.Items[I].Msg + LineBreak;
  end;

  if AInfProt.Count > 0 then
  begin
    FChaveNFAg := AInfProt.Items[0].chDFe;
    FProtocolo := AInfProt.Items[0].nProt;
    FcStat := AInfProt.Items[0].cStat;
  end;
end;

procedure TNFAgRetRecepcao.FinalizarServico;
begin
  // Sobrescrito, para não liberar para stIdle... não ainda...;

  // Retornar configurações anteriores
  FPDFeOwner.SSL.SSLType := FOldSSLType;
  FPHeaderElement := FOldHeaderElement;
end;

function TNFAgRetRecepcao.GerarMsgLog: String;
begin
  {(*}
  Result := Format(ACBrStr('Versão Layout: %s ' + LineBreak +
                           'Ambiente: %s ' + LineBreak +
                           'Versão Aplicativo: %s ' + LineBreak +
                           'Recibo: %s ' + LineBreak +
                           'Status Código: %s ' + LineBreak +
                           'Status Descrição: %s ' + LineBreak +
                           'UF: %s ' + LineBreak +
                           'cMsg: %s ' + LineBreak +
                           'xMsg: %s ' + LineBreak),
                   [FNFAgRetorno.versao, TipoAmbienteToStr(FNFAgRetorno.tpAmb),
                    FNFAgRetorno.verAplic, FNFAgRetorno.nRec,
                    IntToStr(FNFAgRetorno.cStat), FNFAgRetorno.xMotivo,
                    CodigoUFparaUF(FNFAgRetorno.cUF), IntToStr(FNFAgRetorno.cMsg),
                    FNFAgRetorno.xMsg]);
  {*)}
end;

function TNFAgRetRecepcao.GerarPrefixoArquivo: String;
begin
  Result := Recibo;
end;

{ TNFAgRecibo }

constructor TNFAgRecibo.Create(AOwner: TACBrDFe; ANotasFiscais: TNotasFiscais);
begin
  inherited Create(AOwner);

  FNotasFiscais := ANotasFiscais;
end;

destructor TNFAgRecibo.Destroy;
begin
  FNFAgRetorno.Free;

  inherited Destroy;
end;

procedure TNFAgRecibo.Clear;
begin
  inherited Clear;

  FPStatus := stNFAgRecibo;
  FPLayout := LayNFAgRetRecepcao;
  FPArqEnv := 'ped-rec';
  FPArqResp := 'pro-rec';

  Fversao := '';
  FxMsg := '';
  FcMsg := 0;
  FverAplic := '';
  FcStat    := 0;
  FxMotivo  := '';

  if Assigned(FPConfiguracoesNFAg) then
  begin
    FtpAmb := FPConfiguracoesNFAg.WebServices.Ambiente;
    FcUF := FPConfiguracoesNFAg.WebServices.UFCodigo;
  end;

  if Assigned(FNFAgRetorno) then
    FNFAgRetorno.Free;

  FNFAgRetorno := TRetConsReciDFe.Create('NFAg');
end;

procedure TNFAgRecibo.InicializarServico;
begin
  if FNotasFiscais.Count > 0 then    // Tem NFAg ? Se SIM, use as informações do XML
    FVersaoDF := DblToVersaoNFAg(FNotasFiscais.Items[0].NFAg.infNFAg.Versao)
  else
    FVersaoDF := FPConfiguracoesNFAg.Geral.VersaoDF;

  inherited InicializarServico;

  FPHeaderElement := '';
end;

procedure TNFAgRecibo.DefinirServicoEAction;
begin
//  if FPLayout = LayNFAgRetAutorizacao then
//  begin
//    if EstaVazio(FPServico) then
//      FPServico := GetUrlWsd + 'NFAgRetAutorizacao4';
//    if EstaVazio(FPSoapAction) then
//      FPSoapAction := FPServico +'/NFAgRetAutorizacaoLote';
//  end
//  else
//  begin
    FPServico := GetUrlWsd + 'NFAgRetRecepcao';
    FPSoapAction := FPServico + '/NFAgRetRecepcao';
//  end;
end;

procedure TNFAgRecibo.DefinirURL;
var
  xUF: String;
  VerServ: Double;
//  ok: Boolean;
begin
  if FNotasFiscais.Count > 0 then    // Tem NFAg ? Se SIM, use as informações do XML
  begin
    FcUF := FNotasFiscais.Items[0].NFAg.Ide.cUF;

    if Integer(FPConfiguracoesNFAg.WebServices.Ambiente) <> Integer(FNotasFiscais.Items[0].NFAg.Ide.tpAmb) then
      raise EACBrNFAgException.Create( ACBrNFAg_CErroAmbienteDiferente );
  end
  else
  begin // Se não tem NFAg, use as configurações do componente
    FcUF := FPConfiguracoesNFAg.WebServices.UFCodigo;
  end;

  VerServ := VersaoNFAgToDbl(FVersaoDF);
  FTpAmb := FPConfiguracoesNFAg.WebServices.Ambiente;
  FPVersaoServico := '';
  FPURL := '';

  FPLayout := LayNFAgRetRecepcao;

  // Configuração correta ao enviar para o SVC
  case FPConfiguracoesNFAg.Geral.FormaEmissao of
    teSVCAN: xUF := 'SVC-AN';
    teSVCRS: xUF := 'SVC-RS';
  else
    xUF := CodigoUFparaUF(FcUF);
  end;

  TACBrNFAg(FPDFeOwner).LerServicoDeParams(
    'NFAg',
    xUF,
    FTpAmb,
    LayOutToServico(FPLayout),
    VerServ,
    FPURL,
    FPServico,
    FPSoapAction);

  FPVersaoServico := FloatToString(VerServ, '.', '0.00');
end;

procedure TNFAgRecibo.DefinirDadosMsg;
var
  ConsReciNFAg: TConsReciDFe;
begin
  ConsReciNFAg := TConsReciDFe.Create(FPVersaoServico, NAME_SPACE_NFAg, 'NFAg');
  try
    ConsReciNFAg.tpAmb := FTpAmb;
    ConsReciNFAg.nRec  := FRecibo;

//    AjustarOpcoes( ConsReciNFAg.Gerador.Opcoes );
    FPDadosMsg := ConsReciNFAg.GerarXML;
  finally
    ConsReciNFAg.Free;
  end;
end;

function TNFAgRecibo.TratarResposta: Boolean;
begin
  FPRetWS := SeparaDadosArray(['NFAgResultMsg'],FPRetornoWS );

  VerificarSemResposta;

  RemoverNameSpace;

  FNFAgRetorno.XmlRetorno := ParseText(FPRetWS);
  FNFAgRetorno.LerXML;

  Fversao := FNFAgRetorno.versao;
  FTpAmb := TpcnTipoAmbiente(FNFAgRetorno.TpAmb);
  FverAplic := FNFAgRetorno.verAplic;
  FcStat := FNFAgRetorno.cStat;
  FxMotivo := FNFAgRetorno.xMotivo;
  FcUF := FNFAgRetorno.cUF;
  FxMsg := FNFAgRetorno.xMsg;
  FcMsg := FNFAgRetorno.cMsg;
  FPMsg := FxMotivo;

  Result := (FNFAgRetorno.CStat = 104);
end;

function TNFAgRecibo.GerarMsgLog: String;
begin
  {(*}
  Result := Format(ACBrStr('Versão Layout: %s ' + LineBreak +
                           'Ambiente: %s ' + LineBreak +
                           'Versão Aplicativo: %s ' + LineBreak +
                           'Recibo: %s ' + LineBreak +
                           'Status Código: %s ' + LineBreak +
                           'Status Descrição: %s ' + LineBreak +
                           'UF: %s ' + LineBreak),
                   [FNFAgRetorno.versao, TipoAmbienteToStr(FNFAgRetorno.TpAmb),
                   FNFAgRetorno.verAplic, FNFAgRetorno.nRec,
                   IntToStr(FNFAgRetorno.cStat),
                   FNFAgRetorno.xMotivo,
                   CodigoUFparaUF(FNFAgRetorno.cUF)]);
  {*)}
end;

{ TNFAgConsulta }

constructor TNFAgConsulta.Create(AOwner: TACBrDFe; ANotasFiscais: TNotasFiscais);
begin
  inherited Create(AOwner);

  FOwner := AOwner;
  FNotasFiscais := ANotasFiscais;
end;

destructor TNFAgConsulta.Destroy;
begin
  FprotNFAg.Free;
  FprocEventoNFAg.Free;

  inherited Destroy;
end;

procedure TNFAgConsulta.Clear;
begin
  inherited Clear;

  FPStatus := stNFAgConsulta;
  FPLayout := LayNFAgConsulta;
  FPArqEnv := 'ped-sit';
  FPArqResp := 'sit';

  FverAplic := '';
  FcStat := 0;
  FxMotivo := '';
  FProtocolo := '';
  FDhRecbto := 0;
  Fversao := '';
  FRetNFAgDFe := '';

  if Assigned(FPConfiguracoesNFAg) then
  begin
    FtpAmb := FPConfiguracoesNFAg.WebServices.Ambiente;
    FcUF := FPConfiguracoesNFAg.WebServices.UFCodigo;
  end;

  if Assigned(FprotNFAg) then
    FprotNFAg.Free;

  if Assigned(FprocEventoNFAg) then
    FprocEventoNFAg.Free;

  FprotNFAg := TProcDFe.Create(FPVersaoServico, NAME_SPACE_NFAg, 'NFAgProc', 'NFAg');
  FprocEventoNFAg := TRetEventoNFAgCollection.Create;
end;

procedure TNFAgConsulta.SetNFAgChave(const AValue: String);
var
  NumChave: String;
begin
  if FNFAgChave = AValue then Exit;
  NumChave := OnlyNumber(AValue);

  if not ValidarChave(NumChave) then
     raise EACBrNFAgException.Create('Chave "'+AValue+'" inválida.');

  FNFAgChave := NumChave;
end;

procedure TNFAgConsulta.DefinirURL;
var
  VerServ: Double;
  xUF: String;
//  ok: Boolean;
begin
  FPVersaoServico := '';

  FPURL   := '';
  FcUF    := ExtrairUFChaveAcesso(FNFAgChave);
  VerServ := VersaoNFAgToDbl(FPConfiguracoesNFAg.Geral.VersaoDF);

  if FNotasFiscais.Count > 0 then
    FTpAmb := TpcnTipoAmbiente(FNotasFiscais.Items[0].NFAg.Ide.tpAmb)
  else
    FTpAmb := FPConfiguracoesNFAg.WebServices.Ambiente;

  // Se a nota foi enviada para o SVC a consulta tem que ser realizada no SVC e
  // não na SEFAZ-Autorizadora
  case FPConfiguracoesNFAg.Geral.FormaEmissao of
    teSVCAN: xUF := 'SVC-AN';
    teSVCRS: xUF := 'SVC-RS';
  else
    xUF := CodigoUFparaUF(FcUF);
  end;

  TACBrNFAg(FPDFeOwner).LerServicoDeParams(
    'NFAg',
    xUF,
    FTpAmb,
    LayOutToServico(FPLayout),
    VerServ,
    FPURL,
    FPServico,
    FPSoapAction);

  FPVersaoServico := FloatToString(VerServ, '.', '0.00');
end;

procedure TNFAgConsulta.DefinirServicoEAction;
begin
  if EstaVazio(FPServico) then
    FPServico := GetUrlWsd + 'NFAgConsulta';

  if EstaVazio(FPSoapAction) then
    FPSoapAction := FPServico + '/NFAgConsultaNF';
end;

procedure TNFAgConsulta.DefinirDadosMsg;
var
  ConsSitNFAg: TConsSitNFAg;
begin
  ConsSitNFAg := TConsSitNFAg.Create;
  try
    ConsSitNFAg.TpAmb := TACBrTipoAmbiente(FTpAmb);
    ConsSitNFAg.chNFAg := FNFAgChave;
    ConsSitNFAg.Versao := FPVersaoServico;
    FPDadosMsg := ConsSitNFAg.GerarXML;
  finally
    ConsSitNFAg.Free;
  end;
end;

function TNFAgConsulta.GerarUFSoap: String;
begin
  Result := '<cUF>' + IntToStr(FcUF) + '</cUF>';
end;

function TNFAgConsulta.TratarResposta: Boolean;

procedure SalvarEventos(Retorno: string);
var
  aEvento, aProcEvento, aIDEvento, sPathEvento, sCNPJCPF: string;
  DhEvt: TDateTime;
  Inicio, Fim: Integer;
  TipoEvento: TpcnTpEvento;
  Ok: Boolean;
begin
  while Retorno <> '' do
  begin
    Inicio := Pos('<procEventoNFAg', Retorno);
    Fim    := Pos('</procEventoNFAg>', Retorno) + 15;

    aEvento := Copy(Retorno, Inicio, Fim - Inicio + 1);

    Retorno := Copy(Retorno, Fim + 1, Length(Retorno));

    aProcEvento := '<procEventoNFAg versao="' + FVersao + '" xmlns="' + ACBRNFAg_NAMESPACE + '">' +
                      SeparaDados(aEvento, 'procEventoNFAg') +
                   '</procEventoNFAg>';

    Inicio := Pos('Id=', aProcEvento) + 6;
    Fim    := 52;

    if Inicio = 6 then
      aIDEvento := FormatDateTime('yyyymmddhhnnss', Now)
    else
      aIDEvento := Copy(aProcEvento, Inicio, Fim);

    TipoEvento  := StrToTpEventoNFAg(Ok, SeparaDados(aEvento, 'tpEvento'));
    DhEvt       := EncodeDataHora(SeparaDados(aEvento, 'dhEvento'), 'YYYY-MM-DD');
    sCNPJCPF    := SeparaDados(aEvento, 'CNPJ');

    if EstaVazio(sCNPJCPF) then
      sCNPJCPF := SeparaDados(aEvento, 'CPF');   

    sPathEvento := PathWithDelim(FPConfiguracoesNFAg.Arquivos.GetPathEvento(TipoEvento, sCNPJCPF, '', DhEvt));

    if FPConfiguracoesNFAg.Arquivos.SalvarEvento and (aProcEvento <> '') then
      FPDFeOwner.Gravar( aIDEvento + '-procEventoNFAg.xml', aProcEvento, sPathEvento);
  end;
end;

var
  NFAgRetorno: TRetConsSitNFAg;
  SalvarXML, NFCancelada, Atualiza: Boolean;
  aEventos, sPathNFAg, NomeXMLSalvo: String;
  AProcNFAg: TProcDFe;
  I, Inicio, Fim: integer;
  dhEmissao: TDateTime;
begin
  NFAgRetorno := TRetConsSitNFAg.Create;

  try
    FPRetWS := SeparaDadosArray(['NFAgResultMsg'],FPRetornoWS );

    VerificarSemResposta;

    RemoverNameSpace;

    NFAgRetorno.XmlRetorno := ParseText(FPRetWS);
    NFAgRetorno.LerXML;

    NFCancelada := False;
    aEventos := '';

    // <retConsSitNFAg> - Retorno da consulta da situação da NF3-e
    // Este é o status oficial da NF3-e
    Fversao := NFAgRetorno.versao;
    FTpAmb := TpcnTipoAmbiente(NFAgRetorno.tpAmb);
    FverAplic := NFAgRetorno.verAplic;
    FcStat := NFAgRetorno.cStat;
    FXMotivo := NFAgRetorno.xMotivo;
    FcUF := NFAgRetorno.cUF;
//    FNFAgChave := NFAgRetorno.chNFAg;
    FPMsg := FXMotivo;

    // <protNFAg> - Retorno dos dados do ENVIO da NF3-e
    // Considerá-los apenas se não existir nenhum evento de cancelamento (110111)
    FprotNFAg.PathDFe := NFAgRetorno.protNFAg.PathDFe;
    FprotNFAg.PathRetConsReciDFe := NFAgRetorno.protNFAg.PathRetConsReciDFe;
    FprotNFAg.PathRetConsSitDFe := NFAgRetorno.protNFAg.PathRetConsSitDFe;
    FprotNFAg.tpAmb := NFAgRetorno.protNFAg.tpAmb;
    FprotNFAg.verAplic := NFAgRetorno.protNFAg.verAplic;
    FprotNFAg.chDFe := NFAgRetorno.protNFAg.chDFe;
    FprotNFAg.dhRecbto := NFAgRetorno.protNFAg.dhRecbto;
    FprotNFAg.nProt := NFAgRetorno.protNFAg.nProt;
    FprotNFAg.digVal := NFAgRetorno.protNFAg.digVal;
    FprotNFAg.cStat := NFAgRetorno.protNFAg.cStat;
    FprotNFAg.xMotivo := NFAgRetorno.protNFAg.xMotivo;

    {(*}
    if Assigned(NFAgRetorno.procEventoNFAg) and (NFAgRetorno.procEventoNFAg.Count > 0) then
    begin
      aEventos := '=====================================================' +
        LineBreak + '================== Eventos da NF3-e ==================' +
        LineBreak + '=====================================================' +
        LineBreak + '' + LineBreak + 'Quantidade total de eventos: ' +
        IntToStr(NFAgRetorno.procEventoNFAg.Count);

      FprocEventoNFAg.Clear;
      for I := 0 to NFAgRetorno.procEventoNFAg.Count - 1 do
      begin
        with FprocEventoNFAg.New.RetEventoNFAg.retInfEvento do
        begin
//          idLote := NFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retInfEvento.idLote;
          tpAmb := NFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retInfEvento.tpAmb;
          verAplic := NFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retInfEvento.verAplic;
          cOrgao := NFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retInfEvento.cOrgao;
          cStat := NFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retInfEvento.cStat;
          xMotivo := NFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retInfEvento.xMotivo;
          XML := NFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retInfEvento.XML;

          ID := NFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retInfEvento.ID;
          tpAmb := NFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retInfEvento.tpAmb;
//          CNPJ := NFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retInfEvento.CNPJ;
          chNFAg := NFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retInfEvento.chNFAg;
//          dhEvento := NFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retInfEvento.dhEvento;
          TpEvento := NFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retInfEvento.TpEvento;
          nSeqEvento := NFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retInfEvento.nSeqEvento;
          nProt := NFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retInfEvento.nProt;
//          xJust := NFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retInfEvento.xJust;

          {
          retEvento.Clear;
          for J := 0 to NFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retEvento.Count-1 do
          begin
            with retEvento.New.RetInfEvento do
            begin
              Id := NFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retEvento.Items[J].RetInfEvento.Id;
              tpAmb := NFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retEvento.Items[J].RetInfEvento.tpAmb;
              verAplic := NFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retEvento.Items[J].RetInfEvento.verAplic;
              cOrgao := NFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retEvento.Items[J].RetInfEvento.cOrgao;
              cStat := NFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retEvento.Items[J].RetInfEvento.cStat;
              xMotivo := NFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retEvento.Items[J].RetInfEvento.xMotivo;
              chNFAg := NFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retEvento.Items[J].RetInfEvento.chNFAg;
              tpEvento := NFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retEvento.Items[J].RetInfEvento.tpEvento;
              xEvento := NFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retEvento.Items[J].RetInfEvento.xEvento;
              nSeqEvento := NFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retEvento.Items[J].RetInfEvento.nSeqEvento;
              CNPJDest := NFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retEvento.Items[J].RetInfEvento.CNPJDest;
              emailDest := NFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retEvento.Items[J].RetInfEvento.emailDest;
              dhRegEvento := NFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retEvento.Items[J].RetInfEvento.dhRegEvento;
              nProt := NFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retEvento.Items[J].RetInfEvento.nProt;
              XML := NFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg.retEvento.Items[J].RetInfEvento.XML;
            end;
          end;
          }
        end;

        {
        with NFAgRetorno.procEventoNFAg.Items[I].RetEventoNFAg do
        begin
          for j := 0 to retEvento.Count -1 do
          begin
            aEventos := aEventos + LineBreak + LineBreak +
              Format(ACBrStr('Número de sequência: %s ' + LineBreak +
                             'Código do evento: %s ' + LineBreak +
                             'Descrição do evento: %s ' + LineBreak +
                             'Status do evento: %s ' + LineBreak +
                             'Descrição do status: %s ' + LineBreak +
                             'Protocolo: %s ' + LineBreak +
                             'Data/Hora do registro: %s '),
                     [IntToStr(InfEvento.nSeqEvento),
                      TpEventoToStr(InfEvento.TpEvento),
                      InfEvento.DescEvento,
                      IntToStr(retEvento.Items[J].RetInfEvento.cStat),
                      retEvento.Items[J].RetInfEvento.xMotivo,
                      retEvento.Items[J].RetInfEvento.nProt,
                      FormatDateTimeBr(retEvento.Items[J].RetInfEvento.dhRegEvento)]);

            if retEvento.Items[J].RetInfEvento.tpEvento in [teCancelamento, teCancSubst] then
            begin
              NFCancelada := True;
              FProtocolo := retEvento.Items[J].RetInfEvento.nProt;
              FDhRecbto := retEvento.Items[J].RetInfEvento.dhRegEvento;
              FPMsg := retEvento.Items[J].RetInfEvento.xMotivo;
            end;
          end;
        end;
        }
      end;
    end;
    {*)}

    if (not NFCancelada) and (NaoEstaVazio(NFAgRetorno.protNFAg.nProt))  then
    begin
      FProtocolo := NFAgRetorno.protNFAg.nProt;
      FDhRecbto := NFAgRetorno.protNFAg.dhRecbto;
      FPMsg := NFAgRetorno.protNFAg.xMotivo;
    end;

    if not Assigned(FPDFeOwner) then //evita AV caso não atribua o Owner
    begin
     Result := True;
     Exit;
    end;

    with TACBrNFAg(FPDFeOwner) do
    begin
      Result := CstatProcessado(NFAgRetorno.CStat) or
                CstatCancelada(NFAgRetorno.CStat);
    end;

    if Result then
    begin
      if TACBrNFAg(FPDFeOwner).NotasFiscais.Count > 0 then
      begin
        for i := 0 to TACBrNFAg(FPDFeOwner).NotasFiscais.Count - 1 do
        begin
          with TACBrNFAg(FPDFeOwner).NotasFiscais.Items[i] do
          begin
            if (OnlyNumber(FNFAgChave) = NumID) then
            begin
              Atualiza := (NaoEstaVazio(NFAgRetorno.XMLprotNFAg));
              if Atualiza and
                 TACBrNFAg(FPDFeOwner).CstatCancelada(NFAgRetorno.CStat) then
                Atualiza := False;

              // No retorno pode constar que a nota esta cancelada, mas traz o grupo
              // <protNFAg> com as informações da sua autorização
              if not Atualiza and TACBrNFAg(FPDFeOwner).cstatProcessado(NFAgRetorno.protNFAg.cStat) then
                Atualiza := True;

              if (FPConfiguracoesNFAg.Geral.ValidarDigest) and
                (NFAgRetorno.protNFAg.digVal <> '') and (NFAg.signature.DigestValue <> '') and
                (UpperCase(NFAg.signature.DigestValue) <> UpperCase(NFAgRetorno.protNFAg.digVal)) then
              begin
                raise EACBrNFAgException.Create('DigestValue do documento ' +
                  NumID + ' não confere.');
              end;

              // Atualiza o Status da NFAg interna //
              NFAg.procNFAg.cStat := NFAgRetorno.cStat;

              if Atualiza then
              begin
                if TACBrNFAg(FPDFeOwner).CstatCancelada(NFAgRetorno.CStat) then
                begin
                  NFAg.procNFAg.tpAmb := NFAgRetorno.tpAmb;
                  NFAg.procNFAg.verAplic := NFAgRetorno.verAplic;
                  NFAg.procNFAg.chDFe := NFAgRetorno.chNFAg;
                  NFAg.procNFAg.dhRecbto := FDhRecbto;
                  NFAg.procNFAg.nProt := FProtocolo;
                  NFAg.procNFAg.digVal := NFAgRetorno.protNFAg.digVal;
                  NFAg.procNFAg.cStat := NFAgRetorno.cStat;
                  NFAg.procNFAg.xMotivo := NFAgRetorno.xMotivo;
   
                  GerarXML;
                end
                else
                begin
                  NFAg.procNFAg.tpAmb := NFAgRetorno.protNFAg.tpAmb;
                  NFAg.procNFAg.verAplic := NFAgRetorno.protNFAg.verAplic;
                  NFAg.procNFAg.chDFe := NFAgRetorno.protNFAg.chDFe;
                  NFAg.procNFAg.dhRecbto := NFAgRetorno.protNFAg.dhRecbto;
                  NFAg.procNFAg.nProt := NFAgRetorno.protNFAg.nProt;
                  NFAg.procNFAg.digVal := NFAgRetorno.protNFAg.digVal;
                  NFAg.procNFAg.cStat := NFAgRetorno.protNFAg.cStat;
                  NFAg.procNFAg.xMotivo := NFAgRetorno.protNFAg.xMotivo;

                  // O código abaixo é bem mais rápido que "GerarXML" (acima)...
                  AProcNFAg := TProcDFe.Create(FPVersaoServico, NAME_SPACE_NFAg, 'NFAgProc', 'NFAg');
                  try
                    AProcNFAg.XML_DFe := RemoverDeclaracaoXML(XMLOriginal);
                    AProcNFAg.XML_Prot := NFAgRetorno.XMLprotNFAg;

                    XMLOriginal := AProcNFAg.GerarXML;
                  finally
                    AProcNFAg.Free;
                  end;
                end;
              end;

              { Se no retorno da consulta constar que a nota possui eventos vinculados
               será disponibilizado na propriedade FRetNFAgDFe, e conforme configurado
               em "ConfiguracoesNFAg.Arquivos.Salvar", também será gerado o arquivo:
               <chave>-NFAgDFe.xml}

              FRetNFAgDFe := '';

              if (NaoEstaVazio(SeparaDados(FPRetWS, 'procEventoNFAg'))) then
              begin
                Inicio := Pos('<procEventoNFAg', FPRetWS);
                Fim    := Pos('</retConsSitNFAg', FPRetWS) -1;

                aEventos := Copy(FPRetWS, Inicio, Fim - Inicio + 1);

                FRetNFAgDFe := '<' + ENCODING_UTF8 + '>' +
                              '<NFAgDFe>' +
                               '<NFAgProc versao="' + FVersao + '">' +
                                 SeparaDados(XMLOriginal, 'NFAgProc') +
                               '</NFAgProc>' +
                               '<procEventoNFAg versao="' + FVersao + '">' +
                                 aEventos +
                               '</procEventoNFAg>' +
                              '</NFAgDFe>';
              end;

              SalvarXML := Result and FPConfiguracoesNFAg.Arquivos.Salvar and Atualiza;

              if SalvarXML then
              begin
                // Salva o XML da NF3-e assinado, protocolado e com os eventos
                if FPConfiguracoesNFAg.Arquivos.EmissaoPathNFAg then
                  dhEmissao := NFAg.Ide.dhEmi
                else
                  dhEmissao := Now;

                sPathNFAg := PathWithDelim(FPConfiguracoesNFAg.Arquivos.GetPathNFAg(dhEmissao, NFAg.Emit.CNPJ));

                if (FRetNFAgDFe <> '') then
                  FPDFeOwner.Gravar( FNFAgChave + '-NFAgDFe.xml', FRetNFAgDFe, sPathNFAg);

                if Atualiza then
                begin
                  // Salva o XML da NF3-e assinado e protocolado
                  NomeXMLSalvo := '';
                  if NaoEstaVazio(NomeArq) and FileExists(NomeArq) then
                  begin
                    FPDFeOwner.Gravar( NomeArq, XMLOriginal );  // Atualiza o XML carregado
                    NomeXMLSalvo := NomeArq;
                  end;

                  // Salva na pasta baseado nas configurações do PathNFAg
                  if (NomeXMLSalvo <> CalcularNomeArquivoCompleto()) then
                    GravarXML;

                  // Salva o XML de eventos retornados ao consultar um NF3-e
                  if ExtrairEventos then
                    SalvarEventos(aEventos);
                end;
              end;

              break;
            end;
          end;
        end;
      end
      else
      begin
        if ExtrairEventos and FPConfiguracoesNFAg.Arquivos.SalvarEvento and
           (NaoEstaVazio(SeparaDados(FPRetWS, 'procEventoNFAg'))) then
        begin
          Inicio := Pos('<procEventoNFAg', FPRetWS);
          Fim    := Pos('</retConsSitNFAg', FPRetWS) -1;

          aEventos := Copy(FPRetWS, Inicio, Fim - Inicio + 1);

          // Salva o XML de eventos retornados ao consultar um NF3-e
          SalvarEventos(aEventos);
        end;
      end;
    end;
  finally
    NFAgRetorno.Free;
  end;
end;

function TNFAgConsulta.GerarMsgLog: String;
begin
  {(*}
  Result := Format(ACBrStr('Versão Layout: %s ' + LineBreak +
                           'Identificador: %s ' + LineBreak +
                           'Ambiente: %s ' + LineBreak +
                           'Versão Aplicativo: %s ' + LineBreak +
                           'Status Código: %s ' + LineBreak +
                           'Status Descrição: %s ' + LineBreak +
                           'UF: %s ' + LineBreak +
                           'Chave Acesso: %s ' + LineBreak +
                           'Recebimento: %s ' + LineBreak +
                           'Protocolo: %s ' + LineBreak +
                           'Digest Value: %s ' + LineBreak),
                   [Fversao, FNFAgChave, TpAmbToStr(FTpAmb), FverAplic,
                    IntToStr(FcStat), FXMotivo, CodigoUFparaUF(FcUF), FNFAgChave,
                    FormatDateTimeBr(FDhRecbto), FProtocolo, FprotNFAg.digVal]);
  {*)}
end;

function TNFAgConsulta.GerarPrefixoArquivo: String;
begin
  Result := Trim(FNFAgChave);
end;

{ TNFAgEnvEvento }

constructor TNFAgEnvEvento.Create(AOwner: TACBrDFe; AEvento: TEventoNFAg);
begin
  inherited Create(AOwner);

  FEvento := AEvento;
end;

destructor TNFAgEnvEvento.Destroy;
begin
  if Assigned(FEventoRetorno) then
    FEventoRetorno.Free;

  inherited Destroy;
end;

procedure TNFAgEnvEvento.Clear;
begin
  inherited Clear;

  FPStatus := stNFAgEvento;
  FPLayout := LayNFAgEvento;
  FPArqEnv := 'ped-eve';
  FPArqResp := 'eve';

  FcStat   := 0;
  FxMotivo := '';
  FCNPJ := '';

  if Assigned(FPConfiguracoesNFAg) then
    FtpAmb := TACBrTipoAmbiente(FPConfiguracoesNFAg.WebServices.Ambiente);

  if Assigned(FEventoRetorno) then
    FEventoRetorno.Free;

  FEventoRetorno := TRetEventoNFAg.Create;
end;

function TNFAgEnvEvento.GerarPathEvento(const ACNPJ: String; const AIE: String): String;
begin
  with FEvento.Evento.Items[0].InfEvento do
  begin
    Result := FPConfiguracoesNFAg.Arquivos.GetPathEvento(tpEvento, ACNPJ, AIE);
  end;
end;

procedure TNFAgEnvEvento.DefinirURL;
var
  UF: String;
  VerServ: Double;
//  ok: Boolean;
begin
  { Verificação necessária pois somente os eventos de Cancelamento e CCe serão tratados pela SEFAZ do estado
    os outros eventos como manifestacao de destinatários serão tratados diretamente pela RFB }

  FPLayout := LayNFAgEvento;
  VerServ  := VersaoNFAgToDbl(FPConfiguracoesNFAg.Geral.VersaoDF);
  FCNPJ    := FEvento.Evento.Items[0].InfEvento.CNPJ;
  FTpAmb   := FEvento.Evento.Items[0].InfEvento.tpAmb;

  // Configuração correta ao enviar para o SVC
  case FPConfiguracoesNFAg.Geral.FormaEmissao of
    teSVCAN: UF := 'SVC-AN';
    teSVCRS: UF := 'SVC-RS';
  else
    UF := CodigoUFparaUF(ExtrairUFChaveAcesso(FEvento.Evento.Items[0].InfEvento.chNFAg));
  end;
  {
  if (FEvento.Evento.Items[0].InfEvento.tpEvento = teEPECNFe) then
  begin
    FPLayout := LayNFCeEPEC;
  end
  else if not (FEvento.Evento.Items[0].InfEvento.tpEvento in [teCCe,
         teCancelamento, teCancSubst, tePedProrrog1, tePedProrrog2,
         teCanPedProrrog1, teCanPedProrrog2]) then
  begin
    FPLayout := LayNFAgEventoAN;
    UF       := 'AN';
  end;
  }
  FPURL := '';

  TACBrNFAg(FPDFeOwner).LerServicoDeParams(
    'NFAg',
    UF,
    TpcnTipoAmbiente(FTpAmb),
    LayOutToServico(FPLayout),
    VerServ,
    FPURL,
    FPServico,
    FPSoapAction);

  FPVersaoServico := FloatToString(VerServ, '.', '0.00');
end;

procedure TNFAgEnvEvento.DefinirServicoEAction;
begin
  if EstaVazio(FPServico) then
    FPServico := GetUrlWsd + 'NFAgRecepcaoEvento';

  if EstaVazio(FPSoapAction) then
    FPSoapAction := FPServico + '/NFAgRecepcaoEvento';
end;

procedure TNFAgEnvEvento.DefinirDadosMsg;
var
  EventoNFAg: TEventoNFAg;
  I: integer;
  AXMLEvento: AnsiString;
  FErroValidacao: string;
  EventoEhValido: Boolean;
  SchemaEventoNFAg: TSchemaNFAg;
begin
  EventoNFAg := TEventoNFAg.Create;
  try
    EventoNFAg.idLote := FidLote;
    SchemaEventoNFAg  := schErro;
    {(*}
    for I := 0 to FEvento.Evento.Count - 1 do
    begin
      with EventoNFAg.Evento.New do
      begin
        InfEvento.tpAmb := TACBrTipoAmbiente(FTpAmb);
        infEvento.CNPJ := FEvento.Evento[I].InfEvento.CNPJ;
        infEvento.cOrgao := FEvento.Evento[I].InfEvento.cOrgao;
        infEvento.chNFAg := FEvento.Evento[I].InfEvento.chNFAg;
        infEvento.dhEvento := FEvento.Evento[I].InfEvento.dhEvento;
        infEvento.tpEvento := FEvento.Evento[I].InfEvento.tpEvento;
        infEvento.nSeqEvento := FEvento.Evento[I].InfEvento.nSeqEvento;

        case InfEvento.tpEvento of
          teCancelamento:
            begin
              SchemaEventoNFAg := schCancNFAg;
              infEvento.detEvento.nProt := FEvento.Evento[I].InfEvento.detEvento.nProt;
              infEvento.detEvento.xJust := FEvento.Evento[I].InfEvento.detEvento.xJust;
            end;
        end;
      end;
    end;
    {*)}

    EventoNFAg.Versao := FPVersaoServico;
    AjustarOpcoes(EventoNFAg.Opcoes);
    EventoNFAg.GerarXML;

    AssinarXML(EventoNFAg.XmlEnvio, 'eventoNFAg', 'infEvento',
                                         'Falha ao assinar o Envio de Evento ');

    // Separa o XML especifico do Evento para ser Validado.
    AXMLEvento := SeparaDados(FPDadosMsg, 'detEvento');

    case SchemaEventoNFAg of
      schCancNFAg:
        begin
          AXMLEvento := '<evCancNFAg xmlns="' + ACBRNFAg_NAMESPACE + '">' +
//                          AXMLEvento +
                          Trim(RetornarConteudoEntre(AXMLEvento, '<evCancNFAg>', '</evCancNFAg>')) +
                        '</evCancNFAg>';
        end;
    else
      AXMLEvento := '';
    end;

    AXMLEvento := '<' + ENCODING_UTF8 + '>' + AXMLEvento;

    with TACBrNFAg(FPDFeOwner) do
    begin
      EventoEhValido := SSL.Validar(FPDadosMsg,
                                    GerarNomeArqSchema(FPLayout,
                                      StringToFloatDef(FPVersaoServico, 0)),
                                      FPMsg) and
                        SSL.Validar(AXMLEvento,
                                    GerarNomeArqSchemaEvento(SchemaEventoNFAg,
                                      StringToFloatDef(FPVersaoServico, 0)),
                                      FPMsg);
    end;

    if not EventoEhValido then
    begin
      FErroValidacao := ACBrStr('Falha na validação dos dados do Evento: ') +
        FPMsg;

      raise EACBrNFAgException.CreateDef(FErroValidacao);
    end;

    for I := 0 to FEvento.Evento.Count - 1 do
      FEvento.Evento[I].InfEvento.id := EventoNFAg.Evento[I].InfEvento.id;
  finally
    EventoNFAg.Free;
  end;
end;

function TNFAgEnvEvento.TratarResposta: Boolean;
var
  I, J: integer;
  NomeArq, PathArq, VersaoEvento, Texto: String;
begin
  FEvento.idLote := idLote;

  FPRetWS := SeparaDadosArray(['NFAgResultMsg'],FPRetornoWS );

  VerificarSemResposta;

  RemoverNameSpace;

  EventoRetorno.XmlRetorno := ParseText(FPRetWS);
  EventoRetorno.LerXml;

  FcStat := EventoRetorno.retInfEvento.cStat;
  FxMotivo := EventoRetorno.retInfEvento.xMotivo;
  FPMsg := EventoRetorno.retInfEvento.xMotivo;
  FTpAmb := EventoRetorno.retInfEvento.tpAmb;

  Result := (FcStat = 128);

  //gerar arquivo proc de evento
  if Result then
  begin
    for I := 0 to FEvento.Evento.Count - 1 do
    begin
      for J := 0 to EventoRetorno.retEvento.Count - 1 do
      begin
        if FEvento.Evento.Items[I].InfEvento.chNFAg =
          EventoRetorno.retEvento.Items[J].RetInfEvento.chNFAg then
        begin
          FEvento.Evento.Items[I].RetInfEvento.tpAmb := EventoRetorno.retEvento.Items[J].RetInfEvento.tpAmb;
          FEvento.Evento.Items[I].RetInfEvento.nProt := EventoRetorno.retEvento.Items[J].RetInfEvento.nProt;
          FEvento.Evento.Items[I].RetInfEvento.dhRegEvento := EventoRetorno.retEvento.Items[J].RetInfEvento.dhRegEvento;
          FEvento.Evento.Items[I].RetInfEvento.cStat := EventoRetorno.retEvento.Items[J].RetInfEvento.cStat;
          FEvento.Evento.Items[I].RetInfEvento.xMotivo := EventoRetorno.retEvento.Items[J].RetInfEvento.xMotivo;

          Texto := '';

          if EventoRetorno.retEvento.Items[J].RetInfEvento.cStat in [135, 136, 155] then
          begin
            VersaoEvento := TACBrNFAg(FPDFeOwner).LerVersaoDeParams(LayNFAgEvento);

            Texto := '<evento versao="' + VersaoEvento + '">' +
                         SeparaDados(FPDadosMsg, 'infEvento', True) +
                         '<Signature xmlns="http://www.w3.org/2000/09/xmldsig#">' +
                         SeparaDados(FPDadosMsg, 'Signature', False) +
                         '</Signature>'+
                     '</evento>';

            Texto := Texto +
                       '<retEvento versao="' + VersaoEvento + '">' +
                          SeparaDados(FPRetWS, 'infEvento', True) +
                       '</retEvento>';

            Texto := '<procEventoNFAg versao="' + VersaoEvento + '" xmlns="' + ACBRNFAg_NAMESPACE + '">' +
                       Texto +
                     '</procEventoNFAg>';

            if FPConfiguracoesNFAg.Arquivos.SalvarEvento then
            begin
              NomeArq := OnlyNumber(FEvento.Evento.Items[i].InfEvento.Id) + '-procEventoNFAg.xml';
              PathArq := PathWithDelim(GerarPathEvento(FEvento.Evento.Items[I].InfEvento.CNPJ));

              FPDFeOwner.Gravar(NomeArq, Texto, PathArq);
              FEventoRetorno.retEvento.Items[J].RetInfEvento.NomeArquivo := PathArq + NomeArq;
              FEvento.Evento.Items[I].RetInfEvento.NomeArquivo := PathArq + NomeArq;
            end;

            { Converte de UTF8 para a String nativa e Decodificar caracteres HTML Entity }
            Texto := ParseText(Texto);
          end;

          // Se o evento for rejeitado a propriedade XML conterá uma string vazia
          FEventoRetorno.retEvento.Items[J].RetInfEvento.XML := Texto;
          FEvento.Evento.Items[I].RetInfEvento.XML := Texto;

          break;
        end;
      end;
    end;
  end;
end;

function TNFAgEnvEvento.GerarMsgLog: String;
var
  aMsg: String;
begin
  {(*}
  aMsg := Format(ACBrStr('Versão Layout: %s ' + LineBreak +
                         'Ambiente: %s ' + LineBreak +
                         'Versão Aplicativo: %s ' + LineBreak +
                         'Status Código: %s ' + LineBreak +
                         'Status Descrição: %s ' + LineBreak),
                 [FEventoRetorno.versao, TipoAmbienteToStr(FEventoRetorno.retInfEvento.tpAmb),
                  FEventoRetorno.retInfEvento.verAplic, IntToStr(FEventoRetorno.retInfEvento.cStat),
                  FEventoRetorno.retInfEvento.xMotivo]);
  {
  if FEventoRetorno.retEvento.Count > 0 then
    aMsg := aMsg + Format(ACBrStr('Recebimento: %s ' + LineBreak),
       [IfThen(FEventoRetorno.retEvento.Items[0].RetInfEvento.dhRegEvento = 0, '',
               FormatDateTimeBr(FEventoRetorno.retEvento.Items[0].RetInfEvento.dhRegEvento))]);
  }
  Result := aMsg;
  {*)}
end;

function TNFAgEnvEvento.GerarPrefixoArquivo: String;
begin
//  Result := IntToStr(FEvento.idLote);
  Result := IntToStr(FidLote);
end;

{ TDistribuicaoDFe }

constructor TDistribuicaoDFe.Create(AOwner: TACBrDFe);
begin
  inherited Create(AOwner);

  FOwner := AOwner;
end;

destructor TDistribuicaoDFe.Destroy;
begin
  FretDistDFeInt.Free;
  FlistaArqs.Free;

  inherited Destroy;
end;

procedure TDistribuicaoDFe.Clear;
begin
  inherited Clear;

  FPStatus := stDistDFeInt;
  FPLayout := LayNFAgDistDFeInt;
  FPArqEnv := 'con-dist-dfe';
  FPArqResp := 'dist-dfe';
  FPBodyElement := 'NFAgDistDFeInteresse';
  FPHeaderElement := '';

  if Assigned(FretDistDFeInt) then
    FretDistDFeInt.Free;

  FretDistDFeInt := TRetDistDFeInt.Create(FOwner, 'NFAg');

  if Assigned(FlistaArqs) then
    FlistaArqs.Free;

  FlistaArqs := TStringList.Create;
end;

procedure TDistribuicaoDFe.DefinirURL;
var
  UF : String;
  Versao: Double;
begin
  { Esse método é tratado diretamente pela RFB }

  UF := 'AN';

  Versao := 0;
  FPVersaoServico := '';
  FPURL := '';
  Versao := VersaoNFAgToDbl(FPConfiguracoesNFAg.Geral.VersaoDF);

  TACBrNFAg(FPDFeOwner).LerServicoDeParams(
    TACBrNFAg(FPDFeOwner).GetNomeModeloDFe,
    UF ,
    FPConfiguracoesNFAg.WebServices.Ambiente,
    LayOutToServico(FPLayout),
    Versao,
    FPURL, FPServico,
    FPSoapAction);

  FPVersaoServico := FloatToString(Versao, '.', '0.00');
end;

procedure TDistribuicaoDFe.DefinirServicoEAction;
begin
  FPServico := GetUrlWsd + 'NFAgDistribuicaoDFe';
  FPSoapAction := FPServico + '/NFAgDistDFeInteresse';
end;

procedure TDistribuicaoDFe.DefinirDadosMsg;
var
  DistDFeInt: TDistDFeInt;
begin
  DistDFeInt := TDistDFeInt.Create(FPVersaoServico, NAME_SPACE_NFAg,
                                     'NFAgDadosMsg', 'consChNFAg', 'chNFAg', True);
  try
    DistDFeInt.TpAmb := FPConfiguracoesNFAg.WebServices.Ambiente;
    DistDFeInt.cUFAutor := FcUFAutor;
    DistDFeInt.CNPJCPF := FCNPJCPF;
    DistDFeInt.ultNSU := trim(FultNSU);
    DistDFeInt.NSU := trim(FNSU);
    DistDFeInt.Chave := trim(FchNFAg);

    FPDadosMsg := DistDFeInt.GerarXML;
  finally
    DistDFeInt.Free;
  end;
end;

function TDistribuicaoDFe.TratarResposta: Boolean;
var
  I: integer;
  AXML, aPath: String;
begin
  FPRetWS := SeparaDadosArray(['NFAgDistDFeInteresseResult',
                               'NFAgResultMsg'],FPRetornoWS );

  VerificarSemResposta;

  RemoverNameSpace;

  // Processando em UTF8, para poder gravar arquivo corretamente //
  FretDistDFeInt.XmlRetorno := ParseText(FPRetWS);
  FretDistDFeInt.LerXml;

  FPMsg := FretDistDFeInt.xMotivo;
  Result := (FretDistDFeInt.CStat = 137) or (FretDistDFeInt.CStat = 138);

  for I := 0 to FretDistDFeInt.docZip.Count - 1 do
  begin
    AXML := FretDistDFeInt.docZip.Items[I].XML;
    FNomeArq := '';
    if (AXML <> '') then
    begin
      case FretDistDFeInt.docZip.Items[I].schema of
        schresNFe:
          FNomeArq := FretDistDFeInt.docZip.Items[I].resDFe.chDFe + '-resNFAg.xml';

        schresEvento:
          FNomeArq := OnlyNumber(TpEventoToStr(FretDistDFeInt.docZip.Items[I].resEvento.tpEvento) +
                      FretDistDFeInt.docZip.Items[I].resEvento.chDFe +
                      Format('%.2d', [FretDistDFeInt.docZip.Items[I].resEvento.nSeqEvento])) +
                      '-resEventoNFAg.xml';

        schprocNFe:
          FNomeArq := FretDistDFeInt.docZip.Items[I].resDFe.chDFe + '-NFAg.xml';

        schprocEventoNFe:
          FNomeArq := OnlyNumber(FretDistDFeInt.docZip.Items[I].procEvento.Id) +
                      '-procEventoNFAg.xml';
      end;

      if NaoEstaVazio(NomeArq) then
        FlistaArqs.Add( FNomeArq );

      aPath := GerarPathDistribuicao(FretDistDFeInt.docZip.Items[I]);
      FretDistDFeInt.docZip.Items[I].NomeArq := aPath + FNomeArq;

      if (FPConfiguracoesNFAg.Arquivos.Salvar) and NaoEstaVazio(NomeArq) then
      begin
        if FPConfiguracoesNFAg.Arquivos.SalvarEvento then
          if (FretDistDFeInt.docZip.Items[I].schema in [schresEvento, schprocEventoNFe]) then
            FPDFeOwner.Gravar(NomeArq, AXML, aPath);

        if (FretDistDFeInt.docZip.Items[I].schema in [schresNFe, schprocNFe]) then
          FPDFeOwner.Gravar(NomeArq, AXML, aPath);
      end;
    end;
  end;
end;

function TDistribuicaoDFe.GerarMsgLog: String;
begin
  Result := Format(ACBrStr('Versão Layout: %s ' + LineBreak +
                           'Ambiente: %s ' + LineBreak +
                           'Versão Aplicativo: %s ' + LineBreak +
                           'Status Código: %s ' + LineBreak +
                           'Status Descrição: %s ' + LineBreak +
                           'Resposta: %s ' + LineBreak +
                           'Último NSU: %s ' + LineBreak +
                           'Máximo NSU: %s ' + LineBreak),
                   [FretDistDFeInt.versao, TpAmbToStr(FretDistDFeInt.tpAmb),
                    FretDistDFeInt.verAplic, IntToStr(FretDistDFeInt.cStat),
                    FretDistDFeInt.xMotivo,
                    IfThen(FretDistDFeInt.dhResp = 0, '',
                           FormatDateTimeBr(RetDistDFeInt.dhResp)),
                    FretDistDFeInt.ultNSU, FretDistDFeInt.maxNSU]);
end;

function TDistribuicaoDFe.GerarMsgErro(E: Exception): String;
begin
  Result := ACBrStr('WebService Distribuição de DFe:' + LineBreak +
                    '- Inativo ou Inoperante tente novamente.');
end;

function TDistribuicaoDFe.GerarPathDistribuicao(AItem: TdocZipCollectionItem): String;
var
  Data: TDateTime;
begin
  if FPConfiguracoesNFAg.Arquivos.EmissaoPathNFAg then
  begin
    Data := AItem.resDFe.dhEmi;
    if Data = 0 then
    begin
      Data := AItem.resEvento.dhEvento;
      if Data = 0 then
        Data := AItem.procEvento.dhEvento;
    end;
  end
  else
    Data := Now;

  case AItem.schema of
    schresEvento:
      Result := FPConfiguracoesNFAg.Arquivos.GetPathDownloadEvento(AItem.resEvento.tpEvento,
                                                          AItem.resDFe.xNome,
                                                          AItem.resEvento.CNPJCPF,
                                                          AItem.resDFe.IE,
                                                          Data);

    schprocEventoNFe:
      Result := FPConfiguracoesNFAg.Arquivos.GetPathDownloadEvento(AItem.procEvento.tpEvento,
                                                          AItem.resDFe.xNome,
                                                          AItem.procEvento.CNPJ,
                                                          AItem.resDFe.IE,
                                                          Data);

    schresNFe,
    schprocNFe:
      Result := FPConfiguracoesNFAg.Arquivos.GetPathDownload(AItem.resDFe.xNome,
                                                        AItem.resDFe.CNPJCPF,
                                                        AItem.resDFe.IE,
                                                        Data);
  end;
end;

{ TNFAgEnvioWebService }

constructor TNFAgEnvioWebService.Create(AOwner: TACBrDFe);
begin
  inherited Create(AOwner);

  FPStatus := stEnvioWebService;
end;

destructor TNFAgEnvioWebService.Destroy;
begin
  inherited Destroy;
end;

procedure TNFAgEnvioWebService.Clear;
begin
  inherited Clear;

  FVersao := '';
end;

function TNFAgEnvioWebService.Executar: Boolean;
begin
  Result := inherited Executar;
end;

procedure TNFAgEnvioWebService.DefinirURL;
begin
  FPURL := FPURLEnvio;
end;

procedure TNFAgEnvioWebService.DefinirServicoEAction;
begin
  FPServico := FPSoapAction;
end;

procedure TNFAgEnvioWebService.DefinirDadosMsg;
//var
//  LeitorXML: TLeitor;
begin
{
  LeitorXML := TLeitor.Create;
  try
    LeitorXML.Arquivo := FXMLEnvio;
    LeitorXML.Grupo := FXMLEnvio;
    FVersao := LeitorXML.rAtributo('versao')
  finally
    LeitorXML.Free;
  end;
}
  FPDadosMsg := FXMLEnvio;
end;

function TNFAgEnvioWebService.TratarResposta: Boolean;
begin
  FPRetWS := SeparaDados(FPRetornoWS, 'soap:Body');

  VerificarSemResposta;

  RemoverNameSpace;

  Result := True;
end;

function TNFAgEnvioWebService.GerarMsgErro(E: Exception): String;
begin
  Result := ACBrStr('WebService: '+FPServico + LineBreak +
                    '- Inativo ou Inoperante tente novamente.');
end;

function TNFAgEnvioWebService.GerarVersaoDadosSoap: String;
begin
  Result := '<versaoDados>' + FVersao + '</versaoDados>';
end;

{ TWebServices }

constructor TWebServices.Create(AOwner: TACBrDFe);
begin
  FACBrNFAg := TACBrNFAg(AOwner);

  FStatusServico := TNFAgStatusServico.Create(FACBrNFAg);
  FEnviar := TNFAgRecepcao.Create(FACBrNFAg, TACBrNFAg(FACBrNFAg).NotasFiscais);
  FRetorno := TNFAgRetRecepcao.Create(FACBrNFAg, TACBrNFAg(FACBrNFAg).NotasFiscais);
  FRecibo := TNFAgRecibo.Create(FACBrNFAg, TACBrNFAg(FACBrNFAg).NotasFiscais);
  FConsulta := TNFAgConsulta.Create(FACBrNFAg, TACBrNFAg(FACBrNFAg).NotasFiscais);
  FEnvEvento := TNFAgEnvEvento.Create(FACBrNFAg, TACBrNFAg(FACBrNFAg).EventoNFAg);
  FDistribuicaoDFe := TDistribuicaoDFe.Create(FACBrNFAg);
  FEnvioWebService := TNFAgEnvioWebService.Create(FACBrNFAg);
end;

destructor TWebServices.Destroy;
begin
  FStatusServico.Free;
  FEnviar.Free;
  FRetorno.Free;
  FRecibo.Free;
  FConsulta.Free;
  FEnvEvento.Free;
  FDistribuicaoDFe.Free;
  FEnvioWebService.Free;

  inherited Destroy;
end;

function TWebServices.Envia(ALote: Int64; const ASincrono: Boolean): Boolean;
begin
  Result := Envia(IntToStr(ALote), ASincrono);
end;

function TWebServices.Envia(const ALote: String; const ASincrono: Boolean): Boolean;
begin
  FEnviar.Clear;
  FRetorno.Clear;

  FEnviar.Lote := ALote;
//  FEnviar.Sincrono := ASincrono;

  if not Enviar.Executar then
    Enviar.GerarException( Enviar.Msg );

  Result := True;
end;

end.
