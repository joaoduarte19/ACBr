{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2025 Daniel Simoes de Almeida               }    
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{ - Elias César Vieira                                                         }
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

(*

  Documentação SmartTEF
  https://docs.smarttef.com.br

*)

{$I ACBr.inc}

unit ACBrTEFSmartTEFAPI;

interface

uses
  Classes, SysUtils,
  ACBrBase,
  ACBrJSON,
  ACBrSocket,
  ACBrAPIBase,
  ACBrTEFSmartTEFSchemas,
  ACBrTEFSmartTEFInterface;

type                    

  TACBrSmartTEF = class;

  { TACBrSmartTEFOrderResponse }

  TACBrSmartTEFOrderResponse = class(TInterfacedObject, IACBrSmartTEFOrderResponse)
  private
    fResponseSchemas: TACBrSmartTEFOrderResponseSchema;
  protected
    function responseSchemas: TACBrSmartTEFOrderResponseSchema;
  public
    destructor destroy; override;

    procedure LoadJson(aJson: String);

    function payment_identifier: String;
    function payment_status: TACBrSmartTEFStatus;
    function order_type: TACBrSmartTEFOrderType;
    function charge_id: String;
    function allow_multi_payments: Boolean;
    function allow_cash_payment: Boolean;
    function has_details: Boolean;
    function form: TACBrSmartTEFFormResponseSchema;
    function ToJson: String;
  end;

  { TACBrSmartTEFAnonymizeResponse }

  TACBrSmartTEFAnonymizeResponse = class(TInterfacedObject, IACBrSmartTEFAnonymizeResponse)
  private
    fResponseSchemas: TACBrSmartTEFAnonymizeResponseSchema;
  protected
    function responseSchemas: TACBrSmartTEFAnonymizeResponseSchema;
  public
    destructor Destroy; override;

    procedure LoadJson(aJson: String);

    function rowsAffected: Integer;
    function hasChanges: Boolean;
    function message: String;
    function ToJson: String;
  end;

  { TACBrSmartTEFFormResponse }

  TACBrSmartTEFFormResponse = class(TInterfacedObject, IACBrSmartTEFFormResponse)
  private
    fResponseSchemas: TACBrSmartTEFFormResponseSchema;
  protected
    function responseSchemas: TACBrSmartTEFFormResponseSchema;
  public
    destructor Destroy; override;

    procedure LoadJson(aJson: String);

    function form_identifier: String;
    function form_status: TACBrSmartTEFStatus;
    function order_type: TACBrSmartTEFOrderType;
    function form_url: String;
    function form_name: String;
    function fill_out_type: TACBrSmartTEFFormFillOutType;
    function ToJson: String;
  end;

  { TACBrSmartTEFFormDetailsResponse }

  TACBrSmartTEFFormDetailsResponse = class(TInterfacedObject, IACBrSmartTEFFormDetailsResponse)
  private
    fformulario: TACBrSmartTEFFormDetails;
  public
    destructor Destroy; override;

    procedure LoadJson(aJson: String);
    function ToJson: String;
    function formulario: TACBrSmartTEFFormDetails;
  end;

  { TACBrSmartTEFPrintResponse }

  TACBrSmartTEFPrintResponse = class(TInterfacedObject, IACBrSmartTEFPrintResponse)
  private
    fResponseSchemas: TACBrSmartTEFPrintResponseSchemas;
  protected
    function responseSchemas: TACBrSmartTEFPrintResponseSchemas;
  public
    destructor destroy; override;

    procedure LoadJson(aJson: String);

    function print_identifier: String;
    function print_status: TACBrSmartTEFStatus;
    function order_type: TACBrSmartTEFOrderType;
    function print_id: String;
    function file_: String;
    function ToJson: String;
  end;  

  { TACBrSmartTEFPrintDetailsResponse }

  TACBrSmartTEFPrintDetailsResponse = class(TInterfacedObject, IACBrSmartTEFPrintDetailsResponse)
  private
    fResponseSchemas: TACBrSmartTEFPrintDetails;
  protected
    function responseSchemas: TACBrSmartTEFPrintDetails;
  public
    destructor destroy; override;

    procedure LoadJson(aJson: String);

    function print_identifier: String;
    function cnpj: String;
    function create_at: TDateTime;
    function update_at: TDateTime;
    function file_: String;
    function order_type: TACBrSmartTEFOrderType;
    function print_status: TACBrSmartTEFStatus;
    function serial_pos: String;
    function user_id: Integer;
    function type_: String;
    function has_details: Boolean;
    function print_id: String;
    function ToJson: String;
  end;

  { TACBrSmartTEFCardDetailsListResponse }

  TACBrSmartTEFCardDetailsListResponse = class(TInterfacedObject, IACBrSmartTEFCardDetailsListResponse)
  private
    fcards: TACBrSmartTEFCardDetailsList;
  public
    destructor Destroy; override;
                                      
    procedure LoadJson(aJson: String);
    function ToJson: String;
    function cards: TACBrSmartTEFCardDetailsList;
  end;

  { TACBrSmartTEFTerminalListResponse }

  TACBrSmartTEFTerminalListResponse = class(TInterfacedObject, IACBrSmartTEFTerminalListResponse)
  private
    fterminais: TACBrSmartTEFTerminalList;
  public
    destructor Destroy; override;

    procedure LoadJson(aJson: String);
    function ToJson: String;
    function terminais: TACBrSmartTEFTerminalList;
  end;

  { TACBrSmartTEFUserListResponse }

  TACBrSmartTEFUserListResponse = class(TInterfacedObject, IACBrSmartTEFUserListResponse)
  private
    fusers: TACBrSmartTEFUserList;
  public
    destructor Destroy; override;

    procedure LoadJson(aJson: String);
    function ToJson: String;
    function users: TACBrSmartTEFUserList;
  end;

  { TACBrSmartTEFUserCreateResponse }

  TACBrSmartTEFUserCreateResponse = class(TInterfacedObject, IACBrSmartTEFUserCreateResponse)
  private
    fresponseSchemas: TACBrSmartTEFUserCreateResponseSchemas;
  protected
    function responseSchemas: TACBrSmartTEFUserCreateResponseSchemas;
  public
    destructor Destroy; override;

    procedure LoadJson(aJson: String);
    function ToJson: String;
    function email: String;
    function pos_password: String;
  end;

  { TACBrSmartTEFStoreResponse }

  TACBrSmartTEFStoreResponse = class(TInterfacedObject, IACBrSmartTEFStoreResponse)
  private
    fstoreSchemas: TACBrSmartTEFStore;
  protected
    function storeSchemas: TACBrSmartTEFStore;
  public
    destructor Destroy; override;

    procedure LoadJson(aJson: String);
    function ToJson: String;
    function store_id: Integer;
    function cnpj: String;
    function cnpj_integrador: String;
    function webhook: TACBrSmartTEFWebhook;
    function active: Boolean;
    function create_at: TDateTime;
    function update_at: TDateTime;
    function token: String;
    function name: String;
    function trademark: String;
    function contact_tel: String;
    function city_id: Integer;
    function state_id: Integer;
    function zip_code: String;
    function district: String;
    function address: String;
    function integrator_id: Integer;
  end;

  { TACBrSmartTEFStoreSettingsListResponse }

  TACBrSmartTEFStoreSettingsListResponse = class(TInterfacedObject, IACBrSmartTEFStoreSettingsListResponse)
  private
    fstoreSettings: TACBrSmartTEFStoreSettingsList;
  public
    destructor Destroy; override;

    procedure LoadJson(aJson: String);
    function ToJson: String;
    function storeSettings: TACBrSmartTEFStoreSettingsList;
  end;

  { TACBrSmartTEFPoolingListResponse }

  TACBrSmartTEFPoolingListResponse = class(TInterfacedObject, IACBrSmartTEFPoolingResponse)
  private
    fpoolingList: TACBrSmartTEFPoolingList;
    fpooling_time: Integer;
  public
    destructor Destroy; override;

    procedure LoadJson(aJson: String);
    function ToJson: String;
    function poolingList: TACBrSmartTEFPoolingList;
    function pooling_time: Integer;
  end;

  { TACBrSmartTEFOrdemPagamento }

  TACBrSmartTEFOrdemPagamento = class
  private
    fOwner: TACBrSmartTEF;
    fRespostaErro: TACBrSmartTEFError;
    fOrdemPagamentoSolicitada: TACBrSmartTEFOrderCreateRequest;
    fAnonimizacaoSolicitada: TACBrSmartTEFAnonymizeRequest;

    function GetOrdemPagamentoSolicitada: TACBrSmartTEFOrderCreateRequest;
    function GetAnonimizacaoSolicitada: TACBrSmartTEFAnonymizeRequest;
    function GetRespostaErro: TACBrSmartTEFError;
    procedure SetRespostaErro(aJson: String);
  public
    constructor Create(aOwner: TACBrSmartTEF);
    destructor Destroy; override;
    
    function Criar(out aResponse: IACBrSmartTEFOrderResponse): Boolean;
    function Consultar(const aPaymentIdentifier: String; out aResponse: IACBrSmartTEFCardDetailsListResponse; const aChargeId: String = ''): Boolean;
    function Cancelar(const aPaymentIdentifier: String; out aResponse: IACBrSmartTEFOrderResponse): Boolean;
    function Estornar(const aPaymentIdentifier: String; out aResponse: IACBrSmartTEFOrderResponse): Boolean;
    function Anonimizar(out aResponse: IACBrSmartTEFAnonymizeResponse): Boolean; overload;
    function Anonimizar(const aPaymentIdentifier: String; out aResponse: IACBrSmartTEFAnonymizeResponse): Boolean; overload;

    property OrdemPagamentoSolicitada: TACBrSmartTEFOrderCreateRequest read GetOrdemPagamentoSolicitada;
    property AnonimizacaoSolicitada: TACBrSmartTEFAnonymizeRequest read GetAnonimizacaoSolicitada;
    property RespostaErro: TACBrSmartTEFError read GetRespostaErro;
  end;

  { TACBrSmartTEFOrdemFormulario }

  TACBrSmartTEFOrdemFormulario = class
  private
    fOwner: TACBrSmartTEF;
    fRespostaErro: TACBrSmartTEFError;
    fOrdemFormularioSolicitada: TACBrSmartTEFFormCreateRequest;

    function GetOrdemFormularioSolicitada: TACBrSmartTEFFormCreateRequest;
    function GetRespostaErro: TACBrSmartTEFError;
    procedure SetRespostaErro(aJson: String);
  public
    constructor Create(aOwner: TACBrSmartTEF);
    destructor Destroy; override;

    function Criar(out aResponse: IACBrSmartTEFFormResponse): Boolean;
    function Consultar(const aFormIdentifier: String; out aResponse: IACBrSmartTEFFormDetailsResponse): Boolean;
    function Cancelar(const aFormIdentifier: String; out aResponse: IACBrSmartTEFFormResponse): Boolean;

    property OrdemFormularioSolicitada: TACBrSmartTEFFormCreateRequest read GetOrdemFormularioSolicitada;
    property RespostaErro: TACBrSmartTEFError read GetRespostaErro;
  end;

  { TACBrSmartTEFOrdemImpressao }

  TACBrSmartTEFOrdemImpressao = class
  private
    fOwner: TACBrSmartTEF;
    fRespostaErro: TACBrSmartTEFError;
    fOrdemImpressaoSolicitada: TACBrSmartTEFPrintCreateRequest;

    function GetOrdemImpressaoSolicitada: TACBrSmartTEFPrintCreateRequest;
    function GetRespostaErro: TACBrSmartTEFError;
    procedure SetRespostaErro(aJson: String);
  public
    constructor Create(aOwner: TACBrSmartTEF);
    destructor Destroy; override;

    function Criar(out aResponse: IACBrSmartTEFPrintResponse): Boolean;
    function Consultar(const aPrintIdentifier: String; out aResponse: IACBrSmartTEFPrintDetailsResponse): Boolean;
    function Cancelar(const aPrintIdentifier: String; out aResponse: IACBrSmartTEFPrintDetailsResponse): Boolean;

    property OrdemImpressaoSolicitada: TACBrSmartTEFPrintCreateRequest read GetOrdemImpressaoSolicitada;
    property RespostaErro: TACBrSmartTEFError read GetRespostaErro;
  end;

  { TACBrSmartTEFTerminais }

  TACBrSmartTEFTerminais = class
  private
    fOwner: TACBrSmartTEF;
    fRespostaErro: TACBrSmartTEFError;
    function GetRespostaErro: TACBrSmartTEFError;
    procedure SetRespostaErro(aJson: String);
  public
    constructor Create(aOwner: TACBrSmartTEF);
    destructor Destroy; override;

    function Listar(out aResponse: IACBrSmartTEFTerminalListResponse): Boolean;
    function AlterarNickname(const aSerialPos, aNickname: String): Boolean;
    function AlterarBloqueio(const aSerialPos: String; Bloquear: Boolean = False): Boolean;

    property RespostaErro: TACBrSmartTEFError read GetRespostaErro;
  end;  

  { TACBrSmartTEFUsuarios }

  TACBrSmartTEFUsuarios = class
  private
    fOwner: TACBrSmartTEF;
    fRespostaErro: TACBrSmartTEFError;
    fUsuarioSolicitado: TACBrSmartTEFUserRequest;
    function GetRespostaErro: TACBrSmartTEFError;
    function GetUsuarioSolicitado: TACBrSmartTEFUserRequest;
    procedure SetRespostaErro(aJson: String);
  public
    constructor Create(aOwner: TACBrSmartTEF);
    destructor Destroy; override;

    function Listar(out aResponse: IACBrSmartTEFUserListResponse): Boolean;
    function Criar(out aResponse: IACBrSmartTEFUserCreateResponse): Boolean;
                                                                   
    property UsuarioSolicitado: TACBrSmartTEFUserRequest read GetUsuarioSolicitado;
    property RespostaErro: TACBrSmartTEFError read GetRespostaErro;
  end; 

  { TACBrSmartTEFLoja }

  TACBrSmartTEFLoja = class
  private
    fOwner: TACBrSmartTEF;
    fRespostaErro: TACBrSmartTEFError;
    function GetRespostaErro: TACBrSmartTEFError;
    procedure SetRespostaErro(aJson: String);
  public
    constructor Create(aOwner: TACBrSmartTEF);
    destructor Destroy; override;

    function ConsultarLoja(out aResponse: IACBrSmartTEFStoreResponse): Boolean;
    function ConsultarConfiguracao(out aResponse: IACBrSmartTEFStoreSettingsListResponse): Boolean;

    property RespostaErro: TACBrSmartTEFError read GetRespostaErro;
  end;

  TACBrSmartTEF = class(TACBrHTTP)
  private
    fTokenSW: String;
    fCNPJLoja: String;
    fGWTokenLoja: String;
    fCNPJIntegrador: String;
    fGWTokenIntegrador: String;
    fJWTTokenIntegrador: String;
    fLoja: TACBrSmartTEFLoja;
    fUsuarios: TACBrSmartTEFUsuarios;
    fTerminais: TACBrSmartTEFTerminais;
    fOrdemImpressao: TACBrSmartTEFOrdemImpressao;
    fOrdemPagamento: TACBrSmartTEFOrdemPagamento;
    fOrdemFormulario: TACBrSmartTEFOrdemFormulario;
    fRespostaErro: TACBrSmartTEFError;
    function GetLoja: TACBrSmartTEFLoja;
    function GetOrdemFormulario: TACBrSmartTEFOrdemFormulario;
    function GetOrdemImpressao: TACBrSmartTEFOrdemImpressao;
    function GetOrdemPagamento: TACBrSmartTEFOrdemPagamento;
    function GetRespostaErro: TACBrSmartTEFError;
    function GetTerminais: TACBrSmartTEFTerminais;
    function GetUsuarios: TACBrSmartTEFUsuarios;
  protected
    procedure Autenticar;
    procedure PrepararHTTP;
    procedure DispararExcecao(E: Exception);

    function GetAutenticado: Boolean;
    function GetAuthorizationERP: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function Pooling(const aInicio, aFim: TDateTime; out aResponse: IACBrSmartTEFPoolingResponse): Boolean; overload;
    function Pooling(const aInicio: TDateTime; out aResponse: IACBrSmartTEFPoolingResponse): Boolean; overload;

    property OrdemPagamento: TACBrSmartTEFOrdemPagamento read GetOrdemPagamento;
    property OrdemImpressao: TACBrSmartTEFOrdemImpressao read GetOrdemImpressao;
    property OrdemFormulario: TACBrSmartTEFOrdemFormulario read GetOrdemFormulario;
    property Terminais: TACBrSmartTEFTerminais read GetTerminais;
    property Usuarios: TACBrSmartTEFUsuarios read GetUsuarios;
    property Loja: TACBrSmartTEFLoja read GetLoja;

    property RespostaErro: TACBrSmartTEFError read GetRespostaErro;
  published
    property CNPJLoja: String read fCNPJLoja write fCNPJLoja;
    property GWTokenLoja: String read fGWTokenLoja write fGWTokenLoja;
    property CNPJIntegrador: String read fCNPJIntegrador write fCNPJIntegrador;
    property GWTokenIntegrador: String read fGWTokenIntegrador write fGWTokenIntegrador;
    property JWTTokenIntegrador: String read fJWTTokenIntegrador write fJWTTokenIntegrador;
    property JWTTokenLoja: String read fTokenSW write fTokenSW;
  end;

implementation

uses
  synautil, DateUtils,
  ACBrUtil.DateTime,
  ACBrUtil.Strings,
  ACBrUtil.Base;

{ TACBrSmartTEFOrdemPagamento }

function TACBrSmartTEFOrdemPagamento.GetRespostaErro: TACBrSmartTEFError;
begin
  if (not Assigned(fRespostaErro)) then
    fRespostaErro := TACBrSmartTEFError.Create;
  Result := fRespostaErro;
end;

procedure TACBrSmartTEFOrdemPagamento.SetRespostaErro(aJson: String);
begin
  RespostaErro.AsJSON := aJson;
  fOwner.RespostaErro.AsJSON := aJson;
end;

function TACBrSmartTEFOrdemPagamento.GetOrdemPagamentoSolicitada: TACBrSmartTEFOrderCreateRequest;
begin
  if (not Assigned(fOrdemPagamentoSolicitada)) then
    fOrdemPagamentoSolicitada := TACBrSmartTEFOrderCreateRequest.Create;
  Result := fOrdemPagamentoSolicitada;
end;

function TACBrSmartTEFOrdemPagamento.GetAnonimizacaoSolicitada: TACBrSmartTEFAnonymizeRequest;
begin
  if (not Assigned(fAnonimizacaoSolicitada)) then
    fAnonimizacaoSolicitada := TACBrSmartTEFAnonymizeRequest.Create;
  Result := fAnonimizacaoSolicitada;
end;

constructor TACBrSmartTEFOrdemPagamento.Create(aOwner: TACBrSmartTEF);
begin
  inherited Create;
  fOwner := aOwner;
end;

destructor TACBrSmartTEFOrdemPagamento.Destroy;
begin
  if Assigned(fRespostaErro) then
    fRespostaErro.Free;
  if Assigned(fOrdemPagamentoSolicitada) then
    fOrdemPagamentoSolicitada.Free;
  if Assigned(fAnonimizacaoSolicitada) then
    fAnonimizacaoSolicitada.Free;
  inherited Destroy;
end;

function TACBrSmartTEFOrdemPagamento.Criar(out aResponse: IACBrSmartTEFOrderResponse): Boolean;
begin
  {$IfDef FPC}
  Result := False; 
  {$EndIf}
  aResponse := TACBrSmartTEFOrderResponse.Create;

  if (not Assigned(fOrdemPagamentoSolicitada)) or fOrdemPagamentoSolicitada.IsEmpty then
    fOwner.DispararExcecao(EACBrAPIException.Create(Format(sErrorInvalidObject, ['OrdemPagamentoSolicitada'])));

  fOwner.PrepararHTTP;
  WriteStrToStream(fOwner.HTTPSend.Document, fOrdemPagamentoSolicitada.AsJSON);
  fOwner.HttpSend.MimeType := cContentTypeApplicationJSon;
  fOwner.HTTPSend.Headers.Add(fOwner.GetAuthorizationERP);
  fOwner.HTTPSend.Headers.Add(cSmartTEFHeaderGWKey + fOwner.GWTokenLoja);
  fOwner.URLPathParams.Add(cSmartTEFEndpointCommands);
  fOwner.URLPathParams.Add(cSmartTEFEndpointOrder);
  fOwner.URLPathParams.Add(cSmartTEFEndpointCreate);

  try
    fOwner.HTTPMethod(ChttpMethodPOST, cSmartTEFURL);
  except
    RespostaErro.AsJSON := fOwner.HTTPResponse;
    if RespostaErro.IsEmpty then
      raise;
  end;

  Result := (fOwner.HTTPResultCode = HTTP_CREATED);
  if Result then
    aResponse.LoadJson(fOwner.HTTPResponse)
  else
    SetRespostaErro(fOwner.HTTPResponse);
end;

function TACBrSmartTEFOrdemPagamento.Consultar(const aPaymentIdentifier: String;
  out aResponse: IACBrSmartTEFCardDetailsListResponse; const aChargeId: String): Boolean;
var
  jo: TACBrJSONObject;
begin
  {$IfDef FPC}
  Result := False;
  {$EndIf}
  aResponse := TACBrSmartTEFCardDetailsListResponse.Create;

  if EstaVazio(aChargeId) and EstaVazio(aPaymentIdentifier) then
    raise EACBrAPIException.Create(Format(sErrorInvalidObject, ['ChargeId e PaymentIdentifier']));

  fOwner.PrepararHTTP;
  jo := TACBrJSONObject.Create;
  try
    jo
      .AddPair('payment_identifier', aPaymentIdentifier, False)
      .AddPair('charge_id', aChargeId, False);

    fOwner.HttpSend.MimeType := cContentTypeApplicationJSon;
    WriteStrToStream(fOwner.HTTPSend.Document, jo.ToJSON);
  finally
    jo.Free;
  end;

  fOwner.HTTPSend.Headers.Add(fOwner.GetAuthorizationERP);
  fOwner.HTTPSend.Headers.Add(cSmartTEFHeaderGWKey + fOwner.GWTokenLoja);
  fOwner.URLPathParams.Add(cSmartTEFEndpointPooling);
  fOwner.URLPathParams.Add(cSmartTEFEndpointOrder);
  fOwner.URLPathParams.Add(cSmartTEFEndpointGet);

  try
    fOwner.HTTPMethod(ChttpMethodPOST, cSmartTEFURL);
  except
    RespostaErro.AsJSON := fOwner.HTTPResponse;
    if RespostaErro.IsEmpty then
      raise;
  end;

  Result := (fOwner.HTTPResultCode in [HTTP_OK, HTTP_CREATED]);
  if Result then
    aResponse.LoadJson(fOwner.HTTPResponse)
  else
    SetRespostaErro(fOwner.HTTPResponse);
end;

function TACBrSmartTEFOrdemPagamento.Cancelar(const aPaymentIdentifier: String; out aResponse: IACBrSmartTEFOrderResponse): Boolean;
var
  jo: TACBrJSONObject;
begin
  {$IfDef FPC}
  Result := False;
  {$EndIf}
  aResponse := TACBrSmartTEFOrderResponse.Create;

  if EstaVazio(aPaymentIdentifier) then
    raise EACBrAPIException.Create(Format(sErrorInvalidObject, ['PaymentIdentifier']));

  fOwner.PrepararHTTP;
  jo := TACBrJSONObject.Create;
  try
    jo.AddPair('payment_identifier', aPaymentIdentifier);
    fOwner.HttpSend.MimeType := cContentTypeApplicationJSon;
    WriteStrToStream(fOwner.HTTPSend.Document, jo.ToJSON);
  finally
    jo.Free;
  end;

  fOwner.HTTPSend.Headers.Add(fOwner.GetAuthorizationERP);
  fOwner.HTTPSend.Headers.Add(cSmartTEFHeaderGWKey + fOwner.GWTokenLoja);
  fOwner.URLPathParams.Add(cSmartTEFEndpointCommands);
  fOwner.URLPathParams.Add(cSmartTEFEndpointOrder);
  fOwner.URLPathParams.Add(cSmartTEFEndpointStatus);
  fOwner.URLPathParams.Add(cSmartTEFEndpointCancel);

  try
    fOwner.HTTPMethod(ChttpMethodPOST, cSmartTEFURL);
  except
    RespostaErro.AsJSON := fOwner.HTTPResponse;
    if RespostaErro.IsEmpty then
      raise;
  end;

  Result := (fOwner.HTTPResultCode in [HTTP_OK, HTTP_CREATED]);
  if Result then
    aResponse.LoadJson(fOwner.HTTPResponse)
  else
    SetRespostaErro(fOwner.HTTPResponse);
end;

function TACBrSmartTEFOrdemPagamento.Estornar(const aPaymentIdentifier: String; out aResponse: IACBrSmartTEFOrderResponse): Boolean;
var
  jo: TACBrJSONObject;
begin
  {$IfDef FPC}
  Result := False; 
  {$EndIf}
  aResponse := TACBrSmartTEFOrderResponse.Create;

  if EstaVazio(aPaymentIdentifier) then
    raise EACBrAPIException.Create(Format(sErrorInvalidObject, ['PaymentIdentifier']));

  fOwner.PrepararHTTP;
  jo := TACBrJSONObject.Create;
  try
    jo.AddPair('payment_identifier', aPaymentIdentifier);
    fOwner.HttpSend.MimeType := cContentTypeApplicationJSon;
    WriteStrToStream(fOwner.HTTPSend.Document, jo.ToJSON);
  finally
    jo.Free;
  end;

  fOwner.HTTPSend.Headers.Add(fOwner.GetAuthorizationERP);
  fOwner.HTTPSend.Headers.Add(cSmartTEFHeaderGWKey + fOwner.GWTokenLoja);
  fOwner.URLPathParams.Add(cSmartTEFEndpointCommands);
  fOwner.URLPathParams.Add(cSmartTEFEndpointOrder);
  fOwner.URLPathParams.Add(cSmartTEFEndpointStatus);
  fOwner.URLPathParams.Add(cSmartTEFEndpointEstornar);

  try
    fOwner.HTTPMethod(ChttpMethodPOST, cSmartTEFURL);
  except
    RespostaErro.AsJSON := fOwner.HTTPResponse;
    if RespostaErro.IsEmpty then
      raise;
  end;

  Result := (fOwner.HTTPResultCode in [HTTP_OK, HTTP_CREATED]);
  if Result then
    aResponse.LoadJson(fOwner.HTTPResponse)
  else
    SetRespostaErro(fOwner.HTTPResponse);
end;

function TACBrSmartTEFOrdemPagamento.Anonimizar(out aResponse: IACBrSmartTEFAnonymizeResponse): Boolean;
begin
  {$IfDef FPC}
  Result := False;
  {$EndIf}
  aResponse := TACBrSmartTEFAnonymizeResponse.Create;

  if (not Assigned(fAnonimizacaoSolicitada)) or fAnonimizacaoSolicitada.IsEmpty then
    fOwner.DispararExcecao(EACBrAPIException.Create(Format(sErrorInvalidObject, ['AnonimizacaoSolicitada'])));

  if (fAnonimizacaoSolicitada.payments_identifers.Count > 100) then
    fOwner.DispararExcecao(EACBrAPIException.Create(Format(sErrorInvalidParameter, ['payments_identifers (1 a 100)'])));

  fOwner.PrepararHTTP;
  WriteStrToStream(fOwner.HTTPSend.Document, fAnonimizacaoSolicitada.AsJSON);
  fOwner.HttpSend.MimeType := cContentTypeApplicationJSon;
  fOwner.HTTPSend.Headers.Add(fOwner.GetAuthorizationERP);
  fOwner.HTTPSend.Headers.Add(cSmartTEFHeaderGWKey + fOwner.GWTokenLoja);
  fOwner.URLPathParams.Add(cSmartTEFEndpointManager);
  fOwner.URLPathParams.Add(cSmartTEFEndpointStore);
  fOwner.URLPathParams.Add(cSmartTEFEndpointPayments);
  fOwner.URLPathParams.Add(cSmartTEFEndpointAnonymize);

  try
    fOwner.HTTPMethod(ChttpMethodPOST, cSmartTEFURL);
  except
    RespostaErro.AsJSON := fOwner.HTTPResponse;
    if RespostaErro.IsEmpty then
      raise;
  end;

  Result := (fOwner.HTTPResultCode in [HTTP_OK, HTTP_CREATED]);
  if Result then
    aResponse.LoadJson(fOwner.HTTPResponse)
  else
    SetRespostaErro(fOwner.HTTPResponse);
end;

function TACBrSmartTEFOrdemPagamento.Anonimizar(const aPaymentIdentifier: String;
  out aResponse: IACBrSmartTEFAnonymizeResponse): Boolean;
begin
  if EstaVazio(aPaymentIdentifier) then
    raise EACBrAPIException.Create(Format(sErrorInvalidObject, ['PaymentIdentifier']));

  AnonimizacaoSolicitada.Clear;
  AnonimizacaoSolicitada.payments_identifers.Add(aPaymentIdentifier);
  Result := Anonimizar(aResponse);
end;

{ TACBrSmartTEFOrdemFormulario }

function TACBrSmartTEFOrdemFormulario.GetOrdemFormularioSolicitada: TACBrSmartTEFFormCreateRequest;
begin
  if (not Assigned(fOrdemFormularioSolicitada)) then
    fOrdemFormularioSolicitada := TACBrSmartTEFFormCreateRequest.Create;
  Result := fOrdemFormularioSolicitada;
end;

function TACBrSmartTEFOrdemFormulario.GetRespostaErro: TACBrSmartTEFError;
begin
  if (not Assigned(fRespostaErro)) then
    fRespostaErro := TACBrSmartTEFError.Create;
  Result := fRespostaErro;
end;

procedure TACBrSmartTEFOrdemFormulario.SetRespostaErro(aJson: String);
begin
  RespostaErro.AsJSON := aJson;
  fOwner.RespostaErro.AsJSON := aJson;
end;

constructor TACBrSmartTEFOrdemFormulario.Create(aOwner: TACBrSmartTEF);
begin
  inherited Create;
  fOwner := aOwner;
end;

destructor TACBrSmartTEFOrdemFormulario.Destroy;
begin
  if Assigned(fRespostaErro) then
    fRespostaErro.Free;
  if Assigned(fOrdemFormularioSolicitada) then
    fOrdemFormularioSolicitada.Free;
  inherited Destroy;
end;

function TACBrSmartTEFOrdemFormulario.Criar(out aResponse: IACBrSmartTEFFormResponse): Boolean;
begin
  {$IfDef FPC}
  Result := False;
  {$EndIf}
  aResponse := TACBrSmartTEFFormResponse.Create;

  if (not Assigned(fOrdemFormularioSolicitada)) or fOrdemFormularioSolicitada.form.IsEmpty then
    fOwner.DispararExcecao(EACBrAPIException.Create(Format(sErrorInvalidObject, ['OrdemFormularioSolicitada'])));

  fOwner.PrepararHTTP;
  WriteStrToStream(fOwner.HTTPSend.Document, fOrdemFormularioSolicitada.AsJSON);
  fOwner.HttpSend.MimeType := cContentTypeApplicationJSon;
  fOwner.HTTPSend.Headers.Add(fOwner.GetAuthorizationERP);
  fOwner.HTTPSend.Headers.Add(cSmartTEFHeaderGWKey + fOwner.GWTokenLoja);
  fOwner.URLPathParams.Add(cSmartTEFEndpointCommands);
  fOwner.URLPathParams.Add(cSmartTEFEndpointForm);
  fOwner.URLPathParams.Add(cSmartTEFEndpointCreate);

  try
    fOwner.HTTPMethod(ChttpMethodPOST, cSmartTEFURL);
  except
    RespostaErro.AsJSON := fOwner.HTTPResponse;
    if RespostaErro.IsEmpty then
      raise;
  end;

  Result := (fOwner.HTTPResultCode = HTTP_CREATED);
  if Result then
    aResponse.LoadJson(fOwner.HTTPResponse)
  else
    SetRespostaErro(fOwner.HTTPResponse);
end;

function TACBrSmartTEFOrdemFormulario.Consultar(const aFormIdentifier: String;
  out aResponse: IACBrSmartTEFFormDetailsResponse): Boolean;
var
  jo: TACBrJSONObject;
begin
  {$IfDef FPC}
  Result := False;
  {$EndIf}
  aResponse := TACBrSmartTEFFormDetailsResponse.Create;

  if EstaVazio(aFormIdentifier) then
    raise EACBrAPIException.Create(Format(sErrorInvalidObject, ['FormIdentifier']));

  fOwner.PrepararHTTP;
  jo := TACBrJSONObject.Create;
  try
    jo.AddPair('form_identifier', aFormIdentifier);
    fOwner.HttpSend.MimeType := cContentTypeApplicationJSon;
    WriteStrToStream(fOwner.HTTPSend.Document, jo.ToJSON);
  finally
    jo.Free;
  end;

  fOwner.HTTPSend.Headers.Add(fOwner.GetAuthorizationERP);
  fOwner.HTTPSend.Headers.Add(cSmartTEFHeaderGWKey + fOwner.GWTokenLoja);
  fOwner.URLPathParams.Add(cSmartTEFEndpointPooling);
  fOwner.URLPathParams.Add(cSmartTEFEndpointForm);
  fOwner.URLPathParams.Add(cSmartTEFEndpointGet);

  try
    fOwner.HTTPMethod(ChttpMethodPOST, cSmartTEFURL);
  except
    RespostaErro.AsJSON := fOwner.HTTPResponse;
    if RespostaErro.IsEmpty then
      raise;
  end;

  Result := (fOwner.HTTPResultCode in [HTTP_OK, HTTP_CREATED]);
  if Result then
    aResponse.LoadJson(fOwner.HTTPResponse)
  else
    SetRespostaErro(fOwner.HTTPResponse);
end;

function TACBrSmartTEFOrdemFormulario.Cancelar(const aFormIdentifier: String;
  out aResponse: IACBrSmartTEFFormResponse): Boolean;
var
  jo: TACBrJSONObject;
begin
  {$IfDef FPC}
  Result := False;
  {$EndIf}
  aResponse := TACBrSmartTEFFormResponse.Create;

  if EstaVazio(aFormIdentifier) then
    raise EACBrAPIException.Create(Format(sErrorInvalidObject, ['FormIdentifier']));

  fOwner.PrepararHTTP;
  jo := TACBrJSONObject.Create;
  try
    jo.AddPair('form_identifier', aFormIdentifier);
    fOwner.HttpSend.MimeType := cContentTypeApplicationJSon;
    WriteStrToStream(fOwner.HTTPSend.Document, jo.ToJSON);
  finally
    jo.Free;
  end;

  fOwner.HTTPSend.Headers.Add(fOwner.GetAuthorizationERP);
  fOwner.HTTPSend.Headers.Add(cSmartTEFHeaderGWKey + fOwner.GWTokenLoja);
  fOwner.URLPathParams.Add(cSmartTEFEndpointCommands);
  fOwner.URLPathParams.Add(cSmartTEFEndpointForm);
  fOwner.URLPathParams.Add(cSmartTEFEndpointStatus);
  fOwner.URLPathParams.Add(cSmartTEFEndpointCancel);

  try
    fOwner.HTTPMethod(ChttpMethodPOST, cSmartTEFURL);
  except
    RespostaErro.AsJSON := fOwner.HTTPResponse;
    if RespostaErro.IsEmpty then
      raise;
  end;

  Result := (fOwner.HTTPResultCode in [HTTP_OK, HTTP_CREATED]);
  if Result then
    aResponse.LoadJson(fOwner.HTTPResponse)
  else
    SetRespostaErro(fOwner.HTTPResponse);
end;

{ TACBrSmartTEFTerminalListResponse }

destructor TACBrSmartTEFTerminalListResponse.Destroy;
begin
  if Assigned(fterminais) then
    fterminais.Free;
  inherited Destroy;
end;

procedure TACBrSmartTEFTerminalListResponse.LoadJson(aJson: String);
begin
  terminais.AsJSON := aJson;
end;

function TACBrSmartTEFTerminalListResponse.ToJson: String;
begin
  Result := terminais.AsJSON;
end;

function TACBrSmartTEFTerminalListResponse.terminais: TACBrSmartTEFTerminalList;
begin
  if (not Assigned(fterminais)) then
    fterminais := TACBrSmartTEFTerminalList.Create('');
  Result := fterminais;
end;

{ TACBrSmartTEFUserListResponse }

destructor TACBrSmartTEFUserListResponse.Destroy;
begin
  if Assigned(fusers) then
    fusers.Free;;
  inherited Destroy;
end;

procedure TACBrSmartTEFUserListResponse.LoadJson(aJson: String);
begin
  users.AsJSON := aJson;
end;

function TACBrSmartTEFUserListResponse.ToJson: String;
begin
  Result := users.AsJSON;
end;

function TACBrSmartTEFUserListResponse.users: TACBrSmartTEFUserList;
begin
  if (not Assigned(fusers)) then
    fusers := TACBrSmartTEFUserList.Create('');
  Result := fusers;
end;

{ TACBrSmartTEFUserCreateResponse }

function TACBrSmartTEFUserCreateResponse.responseSchemas: TACBrSmartTEFUserCreateResponseSchemas;
begin
  if (not Assigned(fresponseSchemas)) then
    fresponseSchemas := TACBrSmartTEFUserCreateResponseSchemas.Create;
  Result := fresponseSchemas;
end;

destructor TACBrSmartTEFUserCreateResponse.Destroy;
begin
  if Assigned(fresponseSchemas) then
    fresponseSchemas.Free;;
  inherited Destroy;
end;

procedure TACBrSmartTEFUserCreateResponse.LoadJson(aJson: String);
begin
  responseSchemas.AsJSON := aJson;
end;

function TACBrSmartTEFUserCreateResponse.ToJson: String;
begin
  Result := responseSchemas.AsJSON;
end;

function TACBrSmartTEFUserCreateResponse.email: String;
begin
  Result := responseSchemas.email;
end;

function TACBrSmartTEFUserCreateResponse.pos_password: String;
begin
  Result := responseSchemas.pos_password;
end;

{ TACBrSmartTEFStoreResponse }

function TACBrSmartTEFStoreResponse.storeSchemas: TACBrSmartTEFStore;
begin
  if (not Assigned(fstoreSchemas)) then
    fstoreSchemas := TACBrSmartTEFStore.Create;
  Result := fstoreSchemas;
end;

destructor TACBrSmartTEFStoreResponse.Destroy;
begin
  if Assigned(fstoreSchemas) then
    fstoreSchemas.Free;
  inherited Destroy;
end;

procedure TACBrSmartTEFStoreResponse.LoadJson(aJson: String);
begin
  storeSchemas.AsJSON := aJson;
end;

function TACBrSmartTEFStoreResponse.ToJson: String;
begin
  Result := storeSchemas.AsJSON;
end;

function TACBrSmartTEFStoreResponse.store_id: Integer;
begin
  Result := storeSchemas.store_id;
end;

function TACBrSmartTEFStoreResponse.cnpj: String;
begin
  Result := storeSchemas.cnpj;
end;

function TACBrSmartTEFStoreResponse.cnpj_integrador: String;
begin
  Result := storeSchemas.cnpj_integrador;
end;

function TACBrSmartTEFStoreResponse.webhook: TACBrSmartTEFWebhook;
begin
  Result := storeSchemas.webhook;
end;

function TACBrSmartTEFStoreResponse.active: Boolean;
begin
  Result := storeSchemas.active;
end;

function TACBrSmartTEFStoreResponse.create_at: TDateTime;
begin
  Result := storeSchemas.create_at;
end;

function TACBrSmartTEFStoreResponse.update_at: TDateTime;
begin
  Result := storeSchemas.update_at;
end;

function TACBrSmartTEFStoreResponse.token: String;
begin
  Result := storeSchemas.token;
end;

function TACBrSmartTEFStoreResponse.name: String;
begin
  Result := storeSchemas.name;
end;

function TACBrSmartTEFStoreResponse.trademark: String;
begin
  Result := storeSchemas.trademark;
end;

function TACBrSmartTEFStoreResponse.contact_tel: String;
begin
  Result := storeSchemas.contact_tel;
end;

function TACBrSmartTEFStoreResponse.city_id: Integer;
begin
  Result := storeSchemas.city_id;
end;

function TACBrSmartTEFStoreResponse.state_id: Integer;
begin
  Result := storeSchemas.state_id;
end;

function TACBrSmartTEFStoreResponse.zip_code: String;
begin
  Result := storeSchemas.zip_code;
end;

function TACBrSmartTEFStoreResponse.district: String;
begin
  Result := storeSchemas.district;
end;

function TACBrSmartTEFStoreResponse.address: String;
begin
  Result := storeSchemas.address;
end;

function TACBrSmartTEFStoreResponse.integrator_id: Integer;
begin
  Result := storeSchemas.integrator_id;
end;

{ TACBrSmartTEFStoreSettingsListResponse }

destructor TACBrSmartTEFStoreSettingsListResponse.Destroy;
begin
  if Assigned(fstoreSettings) then
    fstoreSettings.Free;
  inherited Destroy;
end;

procedure TACBrSmartTEFStoreSettingsListResponse.LoadJson(aJson: String);
begin
  storeSettings.AsJSON := aJson;
end;

function TACBrSmartTEFStoreSettingsListResponse.ToJson: String;
begin
  Result := storeSettings.AsJSON;
end;

function TACBrSmartTEFStoreSettingsListResponse.storeSettings: TACBrSmartTEFStoreSettingsList;
begin
  if (not Assigned(fstoreSettings)) then
    fstoreSettings := TACBrSmartTEFStoreSettingsList.Create('');
  Result := fstoreSettings;
end;

{ TACBrSmartTEFPoolingListResponse }

destructor TACBrSmartTEFPoolingListResponse.Destroy;
begin
  if Assigned(fpoolingList) then
    fpoolingList.Free;
  inherited Destroy;
end;

procedure TACBrSmartTEFPoolingListResponse.LoadJson(aJson: String);
var
  jo: TACBrJSONObject;
begin
  poolingList.AsJSON := aJson;

  fpooling_time := 0;
  jo := TACBrJSONObject.Parse(aJson);
  try
    fpooling_time := StrToIntDef(jo.AsString['pooling_time'], 0);
  finally
    jo.Free;
  end;
end;

function TACBrSmartTEFPoolingListResponse.pooling_time: Integer;
begin
  Result := fpooling_time;
end;

function TACBrSmartTEFPoolingListResponse.ToJson: String;
begin
  Result := poolingList.AsJSON;
end;

function TACBrSmartTEFPoolingListResponse.poolingList: TACBrSmartTEFPoolingList;
begin
  if (not Assigned(fpoolingList)) then
    fpoolingList := TACBrSmartTEFPoolingList.Create('pooling');
  Result := fpoolingList;
end;

{ TACBrSmartTEFOrdemImpressao }

function TACBrSmartTEFOrdemImpressao.GetOrdemImpressaoSolicitada: TACBrSmartTEFPrintCreateRequest;
begin
  if (not Assigned(fOrdemImpressaoSolicitada)) then
    fOrdemImpressaoSolicitada := TACBrSmartTEFPrintCreateRequest.Create;
  Result := fOrdemImpressaoSolicitada;
end;

function TACBrSmartTEFOrdemImpressao.GetRespostaErro: TACBrSmartTEFError;
begin
  if (not Assigned(fRespostaErro)) then
    fRespostaErro := TACBrSmartTEFError.Create;
  Result := fRespostaErro;
end;

procedure TACBrSmartTEFOrdemImpressao.SetRespostaErro(aJson: String);
begin
  RespostaErro.AsJSON := aJson;
  fOwner.RespostaErro.AsJSON := aJson;
end;

constructor TACBrSmartTEFOrdemImpressao.Create(aOwner: TACBrSmartTEF);
begin
  inherited Create;
  fOwner := aOwner;
end;

destructor TACBrSmartTEFOrdemImpressao.Destroy;
begin
  if Assigned(fRespostaErro) then
    fRespostaErro.Free;
  if Assigned(fOrdemImpressaoSolicitada) then
    fOrdemImpressaoSolicitada.Free;
  inherited Destroy;
end;

function TACBrSmartTEFOrdemImpressao.Criar(out aResponse: IACBrSmartTEFPrintResponse): Boolean;
begin
  {$IfDef FPC}
  Result := False; 
  {$EndIf}
  aResponse := TACBrSmartTEFPrintResponse.Create;

  if (not Assigned(fOrdemImpressaoSolicitada)) or fOrdemImpressaoSolicitada.IsEmpty then
    fOwner.DispararExcecao(EACBrAPIException.Create(Format(sErrorInvalidObject, ['OrdemImpressaoSolicitada'])));

  fOwner.PrepararHTTP;
  WriteStrToStream(fOwner.HTTPSend.Document, fOrdemImpressaoSolicitada.AsJSON);
  fOwner.HttpSend.MimeType := cContentTypeApplicationJSon;
  fOwner.HTTPSend.Headers.Add(fOwner.GetAuthorizationERP);
  fOwner.HTTPSend.Headers.Add(cSmartTEFHeaderGWKey + fOwner.GWTokenLoja);
  fOwner.URLPathParams.Add(cSmartTEFEndpointCommands);
  fOwner.URLPathParams.Add(cSmartTEFEndpointPrint);
  fOwner.URLPathParams.Add(cSmartTEFEndpointCreate);

  try
    fOwner.HTTPMethod(ChttpMethodPOST, cSmartTEFURL);
  except
    RespostaErro.AsJSON := fOwner.HTTPResponse;
    if RespostaErro.IsEmpty then
      raise;
  end;

  Result := (fOwner.HTTPResultCode = HTTP_CREATED);
  if Result then
    aResponse.LoadJson(fOwner.HTTPResponse)
  else
    SetRespostaErro(fOwner.HTTPResponse);
end;

function TACBrSmartTEFOrdemImpressao.Consultar(const aPrintIdentifier: String; out aResponse: IACBrSmartTEFPrintDetailsResponse): Boolean;
var
  jo: TACBrJSONObject;
begin
  {$IfDef FPC}
  Result := False; 
  {$EndIf}
  aResponse := TACBrSmartTEFPrintDetailsResponse.Create;

  if EstaVazio(aPrintIdentifier) then
    raise EACBrAPIException.Create(Format(sErrorInvalidObject, ['PrintIdentifier']));

  fOwner.PrepararHTTP;
  jo := TACBrJSONObject.Create;
  try
    jo.AddPair('print_identifier', aPrintIdentifier);
    fOwner.HttpSend.MimeType := cContentTypeApplicationJSon;
    WriteStrToStream(fOwner.HTTPSend.Document, jo.ToJSON);
  finally
    jo.Free;
  end;

  fOwner.HTTPSend.Headers.Add(fOwner.GetAuthorizationERP);
  fOwner.HTTPSend.Headers.Add(cSmartTEFHeaderGWKey + fOwner.GWTokenLoja);
  fOwner.URLPathParams.Add(cSmartTEFEndpointPooling);
  fOwner.URLPathParams.Add(cSmartTEFEndpointPrint);
  fOwner.URLPathParams.Add(cSmartTEFEndpointGet);

  try
    fOwner.HTTPMethod(ChttpMethodPOST, cSmartTEFURL);
  except
    RespostaErro.AsJSON := fOwner.HTTPResponse;
    if RespostaErro.IsEmpty then
      raise;
  end;

  Result := (fOwner.HTTPResultCode in [HTTP_OK, HTTP_CREATED]);
  if Result then
    aResponse.LoadJson(fOwner.HTTPResponse)
  else
    SetRespostaErro(fOwner.HTTPResponse);
end;

function TACBrSmartTEFOrdemImpressao.Cancelar(const aPrintIdentifier: String; out aResponse: IACBrSmartTEFPrintDetailsResponse): Boolean;
var
  jo: TACBrJSONObject;
begin
  {$IfDef FPC}
  Result := False; 
  {$EndIf}
  aResponse := TACBrSmartTEFPrintDetailsResponse.Create;

  if EstaVazio(aPrintIdentifier) then
    raise EACBrAPIException.Create(Format(sErrorInvalidObject, ['PrintIdentifier']));

  fOwner.PrepararHTTP;
  jo := TACBrJSONObject.Create;
  try
    jo.AddPair('print_identifier', aPrintIdentifier);
    fOwner.HttpSend.MimeType := cContentTypeApplicationJSon;
    WriteStrToStream(fOwner.HTTPSend.Document, jo.ToJSON);
  finally
    jo.Free;
  end;

  fOwner.HTTPSend.Headers.Add(fOwner.GetAuthorizationERP);
  fOwner.HTTPSend.Headers.Add(cSmartTEFHeaderGWKey + fOwner.GWTokenLoja);
  fOwner.URLPathParams.Add(cSmartTEFEndpointCommands);
  fOwner.URLPathParams.Add(cSmartTEFEndpointPrint);
  fOwner.URLPathParams.Add(cSmartTEFEndpointStatus);
  fOwner.URLPathParams.Add(cSmartTEFEndpointCancel);

  try
    fOwner.HTTPMethod(ChttpMethodPOST, cSmartTEFURL);
  except
    RespostaErro.AsJSON := fOwner.HTTPResponse;
    if RespostaErro.IsEmpty then
      raise;
  end;

  Result := (fOwner.HTTPResultCode in [HTTP_OK, HTTP_CREATED]);
  if Result then
    aResponse.LoadJson(fOwner.HTTPResponse)
  else
    SetRespostaErro(fOwner.HTTPResponse);
end;

{ TACBrSmartTEFTerminais }

function TACBrSmartTEFTerminais.GetRespostaErro: TACBrSmartTEFError;
begin
  if (not Assigned(fRespostaErro)) then
    fRespostaErro := TACBrSmartTEFError.Create;
  Result := fRespostaErro;
end;

procedure TACBrSmartTEFTerminais.SetRespostaErro(aJson: String);
begin
  RespostaErro.AsJSON := aJson;
  fOwner.RespostaErro.AsJSON := aJson;
end;

constructor TACBrSmartTEFTerminais.Create(aOwner: TACBrSmartTEF);
begin
  inherited Create;
  fOwner := aOwner;
end;

destructor TACBrSmartTEFTerminais.Destroy;
begin
  if Assigned(fRespostaErro) then
    fRespostaErro.Free;
  inherited Destroy;
end;

function TACBrSmartTEFTerminais.Listar(out aResponse: IACBrSmartTEFTerminalListResponse): Boolean;
begin
  {$IfDef FPC}
  Result := False; 
  {$EndIf}
  aResponse := TACBrSmartTEFTerminalListResponse.Create;

  fOwner.PrepararHTTP;
  fOwner.HTTPSend.Headers.Add(fOwner.GetAuthorizationERP);
  fOwner.HTTPSend.Headers.Add(cSmartTEFHeaderGWKey + fOwner.GWTokenLoja);
  fOwner.URLPathParams.Add(cSmartTEFEndpointManager);
  fOwner.URLPathParams.Add(cSmartTEFEndpointTerminals);
  fOwner.URLPathParams.Add(cSmartTEFEndpointGet);

  try
    fOwner.HTTPMethod(cHTTPMethodGET, cSmartTEFURL);
  except
    RespostaErro.AsJSON := fOwner.HTTPResponse;
    if RespostaErro.IsEmpty then
      raise;
  end;

  Result := (fOwner.HTTPResultCode in [HTTP_OK, HTTP_CREATED]);
  if Result then
    aResponse.LoadJson(fOwner.HTTPResponse)
  else
    SetRespostaErro(fOwner.HTTPResponse);
end;

function TACBrSmartTEFTerminais.AlterarNickname(const aSerialPos, aNickname: String): Boolean;
var
  jo: TACBrJSONObject;
begin
  {$IfDef FPC}
  Result := False;
  {$EndIf}

  if EstaVazio(aSerialPos) then
    raise EACBrAPIException.Create(Format(sErrorInvalidObject, ['SerialPos']));

  fOwner.PrepararHTTP;
  jo := TACBrJSONObject.Create;
  try
    jo
      .AddPair('serial_pos', aSerialPos)
      .AddPair('nickname', aNickname);
    fOwner.HttpSend.MimeType := cContentTypeApplicationJSon;
    WriteStrToStream(fOwner.HTTPSend.Document, jo.ToJSON);
  finally
    jo.Free;
  end;

  fOwner.HTTPSend.Headers.Add(fOwner.GetAuthorizationERP);
  fOwner.HTTPSend.Headers.Add(cSmartTEFHeaderGWKey + fOwner.GWTokenLoja);
  fOwner.URLPathParams.Add(cSmartTEFEndpointManager);
  fOwner.URLPathParams.Add(cSmartTEFEndpointTerminals);
  fOwner.URLPathParams.Add(cSmartTEFEndpointNickname);

  try
    fOwner.HTTPMethod(ChttpMethodPOST, cSmartTEFURL);
  except
    RespostaErro.AsJSON := fOwner.HTTPResponse;
    if RespostaErro.IsEmpty then
      raise;
  end;

  Result := (fOwner.HTTPResultCode in [HTTP_OK, HTTP_CREATED]);
  if (not Result) then
    SetRespostaErro(fOwner.HTTPResponse);
end;

function TACBrSmartTEFTerminais.AlterarBloqueio(const aSerialPos: String; Bloquear: Boolean): Boolean;
var
  jo: TACBrJSONObject;
begin
  {$IfDef FPC}
  Result := False;
  {$EndIf}

  if EstaVazio(aSerialPos) then
    raise EACBrAPIException.Create(Format(sErrorInvalidObject, ['SerialPos']));

  fOwner.PrepararHTTP;
  jo := TACBrJSONObject.Create;
  try
    jo.AddPair('serial_pos', aSerialPos);
    fOwner.HttpSend.MimeType := cContentTypeApplicationJSon;
    WriteStrToStream(fOwner.HTTPSend.Document, jo.ToJSON);
  finally
    jo.Free;
  end;

  fOwner.HTTPSend.Headers.Add(fOwner.GetAuthorizationERP);
  fOwner.HTTPSend.Headers.Add(cSmartTEFHeaderGWKey + fOwner.GWTokenLoja);
  fOwner.URLPathParams.Add(cSmartTEFEndpointManager);
  fOwner.URLPathParams.Add(cSmartTEFEndpointTerminals);
  if Bloquear then
    fOwner.URLPathParams.Add(cSmartTEFEndpointBlock)
  else
    fOwner.URLPathParams.Add(cSmartTEFEndpointUnblock);

  try
    fOwner.HTTPMethod(ChttpMethodPOST, cSmartTEFURL);
  except
    RespostaErro.AsJSON := fOwner.HTTPResponse;
    if RespostaErro.IsEmpty then
      raise;
  end;

  Result := (fOwner.HTTPResultCode in [HTTP_OK, HTTP_CREATED]);
  if (not Result) then
    SetRespostaErro(fOwner.HTTPResponse);
end;

{ TACBrSmartTEFUsuarios }

function TACBrSmartTEFUsuarios.GetRespostaErro: TACBrSmartTEFError;
begin
  if (not Assigned(fRespostaErro)) then
    fRespostaErro := TACBrSmartTEFError.Create;
  Result := fRespostaErro;
end;

function TACBrSmartTEFUsuarios.GetUsuarioSolicitado: TACBrSmartTEFUserRequest;
begin
  if (not Assigned(fUsuarioSolicitado)) then
    fUsuarioSolicitado := TACBrSmartTEFUserRequest.Create;
  Result := fUsuarioSolicitado;
end;

procedure TACBrSmartTEFUsuarios.SetRespostaErro(aJson: String);
begin
  RespostaErro.AsJSON := aJson;
  fOwner.RespostaErro.AsJSON := aJson;
end;

constructor TACBrSmartTEFUsuarios.Create(aOwner: TACBrSmartTEF);
begin
  inherited Create;
  fOwner := aOwner;
end;

destructor TACBrSmartTEFUsuarios.Destroy;
begin
  if Assigned(fUsuarioSolicitado) then
    fUsuarioSolicitado.Free;
  if Assigned(fRespostaErro) then
    fRespostaErro.Free;
  inherited Destroy;
end;

function TACBrSmartTEFUsuarios.Listar(out aResponse: IACBrSmartTEFUserListResponse): Boolean;
begin
  {$IfDef FPC}
  Result := False; 
  {$EndIf}
  aResponse := TACBrSmartTEFUserListResponse.Create;

  fOwner.PrepararHTTP;
  fOwner.HTTPSend.Headers.Add(fOwner.GetAuthorizationERP);
  fOwner.HTTPSend.Headers.Add(cSmartTEFHeaderGWKey + fOwner.GWTokenLoja);
  fOwner.URLPathParams.Add(cSmartTEFEndpointManager);
  fOwner.URLPathParams.Add(cSmartTEFEndpointUsers);
  fOwner.URLPathParams.Add(cSmartTEFEndpointGet);

  try
    fOwner.HTTPMethod(cHTTPMethodGET, cSmartTEFURL);
  except
    RespostaErro.AsJSON := fOwner.HTTPResponse;
    if RespostaErro.IsEmpty then
      raise;
  end;

  Result := (fOwner.HTTPResultCode in [HTTP_OK, HTTP_CREATED]);
  if Result then
    aResponse.LoadJson(fOwner.HTTPResponse)
  else
    SetRespostaErro(fOwner.HTTPResponse);
end;

function TACBrSmartTEFUsuarios.Criar(out aResponse: IACBrSmartTEFUserCreateResponse): Boolean;
begin
  {$IfDef FPC}
  Result := False;
  {$EndIf}
  aResponse := TACBrSmartTEFUserCreateResponse.Create;

  if (not Assigned(fUsuarioSolicitado)) or fUsuarioSolicitado.IsEmpty then
    fOwner.DispararExcecao(EACBrAPIException.Create(Format(sErrorInvalidObject, ['UsuarioSolicitado'])));

  fOwner.PrepararHTTP;
  WriteStrToStream(fOwner.HTTPSend.Document, fUsuarioSolicitado.AsJSON);
  fOwner.HttpSend.MimeType := cContentTypeApplicationJSon;
  fOwner.HTTPSend.Headers.Add(fOwner.GetAuthorizationERP);
  fOwner.HTTPSend.Headers.Add(cSmartTEFHeaderGWKey + fOwner.GWTokenLoja);
  fOwner.URLPathParams.Add(cSmartTEFEndpointManager);
  fOwner.URLPathParams.Add(cSmartTEFEndpointUser);
  fOwner.URLPathParams.Add(cSmartTEFEndpointCreate);

  try
    fOwner.HTTPMethod(ChttpMethodPOST, cSmartTEFURL);
  except
    RespostaErro.AsJSON := fOwner.HTTPResponse;
    if RespostaErro.IsEmpty then
      raise;
  end;

  Result := (fOwner.HTTPResultCode = HTTP_CREATED);
  if Result then
    aResponse.LoadJson(fOwner.HTTPResponse)
  else
    SetRespostaErro(fOwner.HTTPResponse);
end;

{ TACBrSmartTEFLoja }

function TACBrSmartTEFLoja.GetRespostaErro: TACBrSmartTEFError;
begin
  if (not Assigned(fRespostaErro)) then
    fRespostaErro := TACBrSmartTEFError.Create;
  Result := fRespostaErro;
end;

procedure TACBrSmartTEFLoja.SetRespostaErro(aJson: String);
begin
  RespostaErro.AsJSON := aJson;
  fOwner.RespostaErro.AsJSON := aJson;
end;

constructor TACBrSmartTEFLoja.Create(aOwner: TACBrSmartTEF);
begin
  inherited Create;
  fOwner := aOwner;
end;

destructor TACBrSmartTEFLoja.Destroy;
begin
  if Assigned(fRespostaErro) then
    fRespostaErro.Free;
  inherited Destroy;
end;

function TACBrSmartTEFLoja.ConsultarLoja(out aResponse: IACBrSmartTEFStoreResponse): Boolean;
begin
  {$IfDef FPC}
  Result := False; 
  {$EndIf}
  aResponse := TACBrSmartTEFStoreResponse.Create;

  fOwner.PrepararHTTP;
  fOwner.HTTPSend.Headers.Add(fOwner.GetAuthorizationERP);
  fOwner.HTTPSend.Headers.Add(cSmartTEFHeaderGWKey + fOwner.GWTokenLoja);
  fOwner.URLPathParams.Add(cSmartTEFEndpointManager);
  fOwner.URLPathParams.Add(cSmartTEFEndpointStore);
  fOwner.URLPathParams.Add(cSmartTEFEndpointGet);

  try
    fOwner.HTTPMethod(cHTTPMethodGET, cSmartTEFURL);
  except
    RespostaErro.AsJSON := fOwner.HTTPResponse;
    if RespostaErro.IsEmpty then
      raise;
  end;

  Result := (fOwner.HTTPResultCode in [HTTP_OK, HTTP_CREATED]);
  if Result then
    aResponse.LoadJson(fOwner.HTTPResponse)
  else
    SetRespostaErro(fOwner.HTTPResponse);
end;

function TACBrSmartTEFLoja.ConsultarConfiguracao(out aResponse: IACBrSmartTEFStoreSettingsListResponse): Boolean;
begin
  {$IfDef FPC}
  Result := False;
  {$EndIf}
  aResponse := TACBrSmartTEFStoreSettingsListResponse.Create;

  fOwner.PrepararHTTP;
  fOwner.HTTPSend.Headers.Add(fOwner.GetAuthorizationERP);
  fOwner.HTTPSend.Headers.Add(cSmartTEFHeaderGWKey + fOwner.GWTokenLoja);
  fOwner.URLPathParams.Add(cSmartTEFEndpointManager);
  fOwner.URLPathParams.Add(cSmartTEFEndpointStore);
  fOwner.URLPathParams.Add(cSmartTEFEndpointConfig);
  fOwner.URLPathParams.Add(cSmartTEFEndpointGet);

  try
    fOwner.HTTPMethod(cHTTPMethodGET, cSmartTEFURL);
  except
    RespostaErro.AsJSON := fOwner.HTTPResponse;
    if RespostaErro.IsEmpty then
      raise;
  end;

  Result := (fOwner.HTTPResultCode in [HTTP_OK, HTTP_CREATED]);
  if Result then
    aResponse.LoadJson(fOwner.HTTPResponse)
  else
    SetRespostaErro(fOwner.HTTPResponse);
end;

{ TACBrSmartTEF }

function TACBrSmartTEF.GetOrdemPagamento: TACBrSmartTEFOrdemPagamento;
begin
  if (not Assigned(fOrdemPagamento)) then
    fOrdemPagamento := TACBrSmartTEFOrdemPagamento.Create(Self);
  Result := fOrdemPagamento;
end;

function TACBrSmartTEF.GetRespostaErro: TACBrSmartTEFError;
begin
  if (not Assigned(fRespostaErro)) then
    fRespostaErro := TACBrSmartTEFError.Create;
  Result := fRespostaErro;
end;

function TACBrSmartTEF.GetTerminais: TACBrSmartTEFTerminais;
begin
  if (not Assigned(fTerminais)) then
    fTerminais := TACBrSmartTEFTerminais.Create(Self);
  Result := fTerminais;
end;

function TACBrSmartTEF.GetUsuarios: TACBrSmartTEFUsuarios;
begin
  if (not Assigned(fUsuarios)) then
    fUsuarios := TACBrSmartTEFUsuarios.Create(Self);
  Result := fUsuarios;
end;

function TACBrSmartTEF.GetOrdemImpressao: TACBrSmartTEFOrdemImpressao;
begin
  if (not Assigned(fOrdemImpressao)) then
    fOrdemImpressao := TACBrSmartTEFOrdemImpressao.Create(Self);
  Result := fOrdemImpressao;
end;

function TACBrSmartTEF.GetLoja: TACBrSmartTEFLoja;
begin
  if (not Assigned(fLoja)) then
    fLoja := TACBrSmartTEFLoja.Create(Self);
  Result := fLoja;
end;

function TACBrSmartTEF.GetOrdemFormulario: TACBrSmartTEFOrdemFormulario;
begin
  if (not Assigned(fOrdemFormulario)) then
    fOrdemFormulario := TACBrSmartTEFOrdemFormulario.Create(Self);
  Result := fOrdemFormulario;
end;

procedure TACBrSmartTEF.Autenticar;
var
  Body, wBearerToken: String;
  js: TACBrJSONObject;
begin
  RegistrarLog('Autenticar', 3);
  LimparHTTP;

  js := TACBrJSONObject.Create;
  try
    js
      .AddPair('cnpj', CNPJLoja)
      .AddPair('cnpj_integrador', CNPJIntegrador, False);
    Body := js.ToJSON;
    WriteStrToStream(HTTPSend.Document, Body);
    HttpSend.MimeType := cContentTypeApplicationJSon;
  finally
    FreeAndNil(js);
  end;

  wBearerToken := cHTTPAuthorizationBearer + ' ' + fJWTTokenIntegrador;
  HTTPSend.Headers.Add(cHTTPHeaderAuthorization + wBearerToken);
  HTTPSend.Headers.Add(cSmartTEFHeaderGWKey + GWTokenIntegrador);
  URLPathParams.Add(cSmartTEFEndpointIntegrador);
  URLPathParams.Add(cSmartTEFEndpointStore);
  URLPathParams.Add(cSmartTEFEndpointGet);
  URLPathParams.Add(cSmartTEFEndpointToken);

  try
    HTTPMethod(ChttpMethodPOST, cSmartTEFURL);
  except
    try
      RespostaErro.AsJSON := HTTPResponse;
    except
      RespostaErro.Clear;
    end;
    raise;
  end;

  if (HTTPResultCode = HTTP_CREATED) then
  begin
    js := TACBrJSONObject.Parse(HTTPResponse);
    try
      fTokenSW := js.AsString['jwt_token'];
    finally
      FreeAndNil(js);
    end;

    if EstaVazio(Trim(fTokenSW)) then
      DispararExcecao(EACBrAPIException.Create(ACBrStr('Erro de Autenticação')));
  end
  else
    DispararExcecao(EACBrAPIException.CreateFmt('Erro na função %s. HTTP: %d, Metodo: %s', ['Autenticar', HTTPResultCode, cHTTPMethodPOST]));
end;

function TACBrSmartTEF.GetAuthorizationERP: String;
begin
  Result := cHTTPHeaderAuthorization + cHTTPAuthorizationBearer;
  if NaoEstaVazio(fTokenSW) then
    Result := Result + ' ' + fTokenSW;
end;

procedure TACBrSmartTEF.PrepararHTTP;
begin
  RespostaErro.Clear;
  RegistrarLog('PrepararHTTP', 3);

  if (not GetAutenticado) then
    Autenticar;

  LimparHTTP;
end;

procedure TACBrSmartTEF.DispararExcecao(E: Exception);
begin
  if (not Assigned(E)) then
    Exit;

  RegistrarLog(E.ClassName + ': ' + E.Message);
  raise E;
end;

function TACBrSmartTEF.GetAutenticado: Boolean;
begin
  Result := (not EstaVazio(fTokenSW));
end;

constructor TACBrSmartTEF.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fTokenSW := EmptyStr;
  fCNPJLoja := EmptyStr;
  fGWTokenLoja := EmptyStr;
  fCNPJIntegrador := EmptyStr;
  fGWTokenIntegrador := EmptyStr;
  fJWTTokenIntegrador := EmptyStr;
end;

destructor TACBrSmartTEF.Destroy;
begin
  if Assigned(fLoja) then
    fLoja.Free;
  if Assigned(fTerminais) then
    fTerminais.Free;
  if Assigned(fUsuarios) then
    fUsuarios.Free;
  if Assigned(fOrdemImpressao) then
    fOrdemImpressao.Free;
  if Assigned(fOrdemPagamento) then
    fOrdemPagamento.Free;
  if Assigned(fOrdemFormulario) then
    fOrdemFormulario.Free;
  if Assigned(fRespostaErro) then
    fRespostaErro.Free;
  inherited Destroy;
end;

function TACBrSmartTEF.Pooling(const aInicio: TDateTime; out aResponse: IACBrSmartTEFPoolingResponse): Boolean;
begin
  Result := Pooling(aInicio, IncDay(aInicio), aResponse);
end;

function TACBrSmartTEF.Pooling(const aInicio, aFim: TDateTime; out aResponse: IACBrSmartTEFPoolingResponse): Boolean;
var
  jo: TACBrJSONObject;
  wSegundos: Int64;
begin
  {$IfDef FPC}
  Result := False;
  {$EndIf}
  aResponse := TACBrSmartTEFPoolingListResponse.Create;

  if EstaZerado(aInicio) or EstaZerado(aFim) then
    raise EACBrAPIException.Create(Format(sErrorInvalidParameter, ['Inicio/Fim']));

  wSegundos := Round((RecodeMilliSecond(aFim, 0) - RecodeMilliSecond(aInicio, 0)) * SecsPerDay);
  if (Abs(wSegundos - SecsPerDay) > 1) then
    raise EACBrAPIException.Create(Format(sErrorInvalidParameter, ['Inicio/Fim (intervalo de 24 horas)']));

  PrepararHTTP;
  jo := TACBrJSONObject.Create;
  try
    jo
      .AddPair('datetimeInitial', FormatDateTime('YYYY-MM-DD hh:nn:ss', aInicio))
      .AddPair('datetimeFinal', FormatDateTime('YYYY-MM-DD hh:nn:ss', aFim));
    HttpSend.MimeType := cContentTypeApplicationJSon;
    WriteStrToStream(HTTPSend.Document, jo.ToJSON);
  finally
    jo.Free;
  end;

  HTTPSend.Headers.Add(GetAuthorizationERP);
  HTTPSend.Headers.Add(cSmartTEFHeaderGWKey + GWTokenLoja);
  URLPathParams.Add(cSmartTEFEndpointPooling);
  URLPathParams.Add(cSmartTEFEndpointOrder);

  try
    HTTPMethod(cHTTPMethodPOST, cSmartTEFURL);
  except
    RespostaErro.AsJSON := HTTPResponse;
    if RespostaErro.IsEmpty then
      raise;
  end;

  Result := (HTTPResultCode in [HTTP_OK, HTTP_CREATED]);
  if Result then
    aResponse.LoadJson(HTTPResponse)
  else
    RespostaErro.AsJSON := HTTPResponse;
end;

{ TACBrSmartTEFOrderResponse }

function TACBrSmartTEFOrderResponse.responseSchemas: TACBrSmartTEFOrderResponseSchema;
begin
  if (not Assigned(fResponseSchemas)) then
    fResponseSchemas := TACBrSmartTEFOrderResponseSchema.Create;
  Result := fResponseSchemas;
end;

destructor TACBrSmartTEFOrderResponse.destroy;
begin
  if Assigned(fResponseSchemas) then
    fResponseSchemas.Free;
  inherited destroy;
end;

procedure TACBrSmartTEFOrderResponse.LoadJson(aJson: String);
begin
  responseSchemas.AsJSON := aJson;
end;

function TACBrSmartTEFOrderResponse.payment_identifier: String;
begin
  Result := responseSchemas.payment_identifier;
end;

function TACBrSmartTEFOrderResponse.payment_status: TACBrSmartTEFStatus;
begin
  Result := responseSchemas.payment_status;
end;

function TACBrSmartTEFOrderResponse.order_type: TACBrSmartTEFOrderType;
begin
  Result := responseSchemas.order_type;
end;

function TACBrSmartTEFOrderResponse.charge_id: String;
begin
  Result := responseSchemas.charge_id;
end;

function TACBrSmartTEFOrderResponse.allow_multi_payments: Boolean;
begin
  Result := responseSchemas.allow_multi_payments;
end;

function TACBrSmartTEFOrderResponse.allow_cash_payment: Boolean;
begin
  Result := responseSchemas.allow_cash_payment;
end;

function TACBrSmartTEFOrderResponse.has_details: Boolean;
begin
  Result := responseSchemas.has_details;
end;

function TACBrSmartTEFOrderResponse.form: TACBrSmartTEFFormResponseSchema;
begin
  Result := responseSchemas.form;
end;

function TACBrSmartTEFOrderResponse.ToJson: String;
begin
  Result := responseSchemas.AsJSON;
end;

{ TACBrSmartTEFAnonymizeResponse }

function TACBrSmartTEFAnonymizeResponse.responseSchemas: TACBrSmartTEFAnonymizeResponseSchema;
begin
  if (not Assigned(fResponseSchemas)) then
    fResponseSchemas := TACBrSmartTEFAnonymizeResponseSchema.Create;
  Result := fResponseSchemas;
end;

destructor TACBrSmartTEFAnonymizeResponse.Destroy;
begin
  if Assigned(fResponseSchemas) then
    fResponseSchemas.Free;
  inherited Destroy;
end;

procedure TACBrSmartTEFAnonymizeResponse.LoadJson(aJson: String);
begin
  responseSchemas.AsJSON := aJson;
end;

function TACBrSmartTEFAnonymizeResponse.rowsAffected: Integer;
begin
  Result := responseSchemas.rowsAffected;
end;

function TACBrSmartTEFAnonymizeResponse.hasChanges: Boolean;
begin
  Result := responseSchemas.hasChanges;
end;

function TACBrSmartTEFAnonymizeResponse.message: String;
begin
  Result := responseSchemas.message;
end;

function TACBrSmartTEFAnonymizeResponse.ToJson: String;
begin
  Result := responseSchemas.AsJSON;
end;

{ TACBrSmartTEFFormResponse }

function TACBrSmartTEFFormResponse.responseSchemas: TACBrSmartTEFFormResponseSchema;
begin
  if (not Assigned(fResponseSchemas)) then
    fResponseSchemas := TACBrSmartTEFFormResponseSchema.Create;
  Result := fResponseSchemas;
end;

destructor TACBrSmartTEFFormResponse.Destroy;
begin
  if Assigned(fResponseSchemas) then
    fResponseSchemas.Free;
  inherited Destroy;
end;

procedure TACBrSmartTEFFormResponse.LoadJson(aJson: String);
begin
  responseSchemas.AsJSON := aJson;
end;

function TACBrSmartTEFFormResponse.form_identifier: String;
begin
  Result := responseSchemas.form_identifier;
end;

function TACBrSmartTEFFormResponse.form_status: TACBrSmartTEFStatus;
begin
  Result := responseSchemas.form_status;
end;

function TACBrSmartTEFFormResponse.order_type: TACBrSmartTEFOrderType;
begin
  Result := responseSchemas.order_type;
end;

function TACBrSmartTEFFormResponse.form_url: String;
begin
  Result := responseSchemas.form_url;
end;

function TACBrSmartTEFFormResponse.form_name: String;
begin
  Result := responseSchemas.form_name;
end;

function TACBrSmartTEFFormResponse.fill_out_type: TACBrSmartTEFFormFillOutType;
begin
  Result := responseSchemas.fill_out_type;
end;

function TACBrSmartTEFFormResponse.ToJson: String;
begin
  Result := responseSchemas.AsJSON;
end;

{ TACBrSmartTEFFormDetailsResponse }

destructor TACBrSmartTEFFormDetailsResponse.Destroy;
begin
  if Assigned(fformulario) then
    fformulario.Free;
  inherited Destroy;
end;

procedure TACBrSmartTEFFormDetailsResponse.LoadJson(aJson: String);
begin
  formulario.AsJSON := aJson;
end;

function TACBrSmartTEFFormDetailsResponse.ToJson: String;
begin
  Result := formulario.AsJSON;
end;

function TACBrSmartTEFFormDetailsResponse.formulario: TACBrSmartTEFFormDetails;
begin
  if (not Assigned(fformulario)) then
    fformulario := TACBrSmartTEFFormDetails.Create;
  Result := fformulario;
end;

{ TACBrSmartTEFPrintResponse }

function TACBrSmartTEFPrintResponse.responseSchemas: TACBrSmartTEFPrintResponseSchemas;
begin
  if (not Assigned(fResponseSchemas)) then
    fResponseSchemas := TACBrSmartTEFPrintResponseSchemas.Create;
  Result := fResponseSchemas;
end;

destructor TACBrSmartTEFPrintResponse.destroy;
begin
  if Assigned(fResponseSchemas) then
    fResponseSchemas.Free;
  inherited destroy;
end;

procedure TACBrSmartTEFPrintResponse.LoadJson(aJson: String);
begin
  ResponseSchemas.AsJSON := aJson;
end;

function TACBrSmartTEFPrintResponse.print_identifier: String;
begin
  Result := ResponseSchemas.print_identifier;
end;

function TACBrSmartTEFPrintResponse.print_status: TACBrSmartTEFStatus;
begin
  Result := ResponseSchemas.print_status;
end;

function TACBrSmartTEFPrintResponse.order_type: TACBrSmartTEFOrderType;
begin
  Result := ResponseSchemas.order_type;
end;

function TACBrSmartTEFPrintResponse.print_id: String;
begin
  Result := ResponseSchemas.print_id;
end;

function TACBrSmartTEFPrintResponse.file_: String;
begin
  Result := ResponseSchemas.file_;
end;

function TACBrSmartTEFPrintResponse.ToJson: String;
begin
  Result := ResponseSchemas.AsJSON;
end;

{ TACBrSmartTEFPrintDetailsResponse }

function TACBrSmartTEFPrintDetailsResponse.responseSchemas: TACBrSmartTEFPrintDetails;
begin
  if (not Assigned(fResponseSchemas)) then
    fResponseSchemas := TACBrSmartTEFPrintDetails.Create;
  Result := fResponseSchemas;
end;

destructor TACBrSmartTEFPrintDetailsResponse.destroy;
begin
  if Assigned(fResponseSchemas) then
    fResponseSchemas.Free;
  inherited destroy;
end;

procedure TACBrSmartTEFPrintDetailsResponse.LoadJson(aJson: String);
begin
  responseSchemas.AsJSON := aJson;
end;

function TACBrSmartTEFPrintDetailsResponse.print_identifier: String;
begin
  Result := ResponseSchemas.print_identifier;
end;

function TACBrSmartTEFPrintDetailsResponse.cnpj: String;
begin
  Result := ResponseSchemas.cnpj;
end;

function TACBrSmartTEFPrintDetailsResponse.create_at: TDateTime;
begin
  Result := ResponseSchemas.create_at;
end;

function TACBrSmartTEFPrintDetailsResponse.update_at: TDateTime;
begin
  Result := ResponseSchemas.update_at;
end;

function TACBrSmartTEFPrintDetailsResponse.file_: String;
begin
  Result := ResponseSchemas.file_;
end;

function TACBrSmartTEFPrintDetailsResponse.order_type: TACBrSmartTEFOrderType;
begin
  Result := ResponseSchemas.order_type;
end;

function TACBrSmartTEFPrintDetailsResponse.print_status: TACBrSmartTEFStatus;
begin
  Result := ResponseSchemas.print_status;
end;

function TACBrSmartTEFPrintDetailsResponse.serial_pos: String;
begin
  Result := ResponseSchemas.serial_pos;
end;

function TACBrSmartTEFPrintDetailsResponse.user_id: Integer;
begin
  Result := ResponseSchemas.user_id;
end;

function TACBrSmartTEFPrintDetailsResponse.type_: String;
begin
  Result := ResponseSchemas.type_;
end;

function TACBrSmartTEFPrintDetailsResponse.has_details: Boolean;
begin
  Result := ResponseSchemas.has_details;
end;

function TACBrSmartTEFPrintDetailsResponse.print_id: String;
begin
  Result := ResponseSchemas.print_id;
end;

function TACBrSmartTEFPrintDetailsResponse.ToJson: String;
begin
  Result := ResponseSchemas.AsJSON;
end;

{ TACBrSmartTEFCardDetailsListResponse }

destructor TACBrSmartTEFCardDetailsListResponse.Destroy;
begin
  if Assigned(fcards) then
    fcards.Free;
  inherited destroy;
end;

function TACBrSmartTEFCardDetailsListResponse.ToJson: String;
begin
  Result := cards.AsJSON;
end;

function TACBrSmartTEFCardDetailsListResponse.cards: TACBrSmartTEFCardDetailsList;
begin
  if (not Assigned(fcards)) then
    fcards := TACBrSmartTEFCardDetailsList.Create('');
  Result := fcards;
end;

procedure TACBrSmartTEFCardDetailsListResponse.LoadJson(aJson: String);
begin
  cards.AsJSON := aJson;
end;

end. 
