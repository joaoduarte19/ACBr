{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2023 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Elias César Vieira                              }
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

unit ACBrPIXPSPBradesco;

interface

uses
  Classes, SysUtils, StrUtils,
  {$IFDEF RTL230_UP}ACBrBase,{$ENDIF RTL230_UP}
  ACBrPIXCD;

const

  cBradescoURLSandbox = 'https://qrpix-h.bradesco.com.br';
  cBradescoURLSandboxRecorrente = 'https://apipix-h.bradesco.com.br';

  cBradescoURLProducao = 'https://qrpix.bradesco.com.br';
  cBradescoURLProducaoRecorrente = 'https://apipix.bradesco.com.br';

  cBradescoURLSandboxV2 = 'https://openapisandbox.prebanco.com.br';

  cBradescoPathAuthToken = '/oauth/token';
  cBradescoPathAuthTokenV2 = '/auth/server/oauth/token';

  cBradescoPathAPIPix = '/v2';
  cBradescoPathAPIPixRecorrente = '/v1';

type

  TACBrBradescoAPIVersao = (braVersao1, braVersao2);

  { TACBrPSPBradesco }
                    
  {$IFDEF RTL230_UP}
  [ComponentPlatformsAttribute(piacbrAllPlatforms)]
  {$ENDIF RTL230_UP}
  TACBrPSPBradesco = class(TACBrPSPCertificate)
  protected
    function ObterURLAuth: String;

    function ObterURL(const aMethod, aEndPoint: String): String;
    function ObterURLAmbiente(const aAmbiente: TACBrPixCDAmbiente): String; override;
    function ObterURLAmbienteREC(const aAmbiente: TACBrPixCDAmbiente): String;

    function CalcularURLEndPoint(const Method, EndPoint: String): String; override;

  private
    fAPIVersao: TACBrBradescoAPIVersao;
    procedure QuandoReceberRespostaEndPoint(const aEndPoint, AURL, aMethod: String; var aResultCode: Integer; var aRespostaHttp: AnsiString);
  public
    constructor Create(aOwner: TComponent); override;
    procedure Autenticar; override;
  published
    property APIVersao: TACBrBradescoAPIVersao read fAPIVersao write fAPIVersao default braVersao1;
  end;

implementation

uses synautil, synacode, DateUtils, ACBrJSON, ACBrUtil.Strings;

{ TACBrPSPBradesco }

function TACBrPSPBradesco.ObterURLAuth: String;
begin
  Result := EmptyStr;
  if (ACBrPixCD.Ambiente = ambProducao) then
  begin
    if (fAPIVersao = braVersao2) then
      Result := cBradescoURLProducao + cBradescoPathAuthTokenV2
    else
      Result := cBradescoURLProducao + cBradescoPathAuthToken;
  end
  else
  begin
    if (fAPIVersao = braVersao2) then
      Result := cBradescoURLSandboxV2 + cBradescoPathAuthTokenV2
    else
      Result := cBradescoURLSandbox + cBradescoPathAuthToken;
  end;
end;

function TACBrPSPBradesco.ObterURL(const aMethod, aEndPoint: String): String;
begin

  VerificarPIXCDAtribuido;
  if  (aEndPoint = cEndPointCobR) or
     (aEndPoint = cEndPointRec) or
     (aEndPoint = cEndPointLocRec) or
     (aEndPoint = cEndPointSolicRec) or
     (aEndPoint = cEndPointWebhookCobR) or
     (aEndPoint = cEndPointWebhookRec) then
    Result := ObterURLAmbienteRec(ACBrPixCD.Ambiente)
  else
    Result := ObterURLAmbiente(ACBrPixCD.Ambiente);

  Result := URLSemDelimitador(Result);
end;

function TACBrPSPBradesco.ObterURLAmbiente(const aAmbiente: TACBrPixCDAmbiente): String;
begin
  if (aAmbiente = ambProducao) then
    Result := cBradescoURLProducao + cBradescoPathAPIPix
  else if (fAPIVersao = braVersao2) then
    Result := cBradescoURLSandboxV2 + cBradescoPathAPIPix
  else
    Result := cBradescoURLSandbox + cBradescoPathAPIPix
end;

function TACBrPSPBradesco.ObterURLAmbienteREC(const aAmbiente: TACBrPixCDAmbiente): String;
begin
  if (aAmbiente = ambProducao) then
    Result := cBradescoURLProducaoRecorrente + cBradescoPathAPIPixRecorrente
  else if (fAPIVersao = braVersao2) then
    Result := cBradescoURLSandboxV2 + cBradescoPathAPIPix
  else
    Result := cBradescoURLSandboxRecorrente + cBradescoPathAPIPixRecorrente
end;


procedure TACBrPSPBradesco.QuandoReceberRespostaEndPoint(const aEndPoint, AURL,
  aMethod: String; var aResultCode: Integer; var aRespostaHttp: AnsiString);
begin
  // Bradesco responde OK(200) ao PUT: /cobv ou /pix, de forma diferente da especificada(201)
  if (UpperCase(AMethod) = ChttpMethodPUT) and ((AEndPoint = cEndPointCobV) or (aEndPoint = cEndPointPix)) and (AResultCode = HTTP_OK) then
    AResultCode := HTTP_CREATED;

  // Bradesco responde OK(200) ao POST: /cob de forma diferente da especificada(201)
  if (UpperCase(AMethod) = ChttpMethodPOST) and (AEndPoint = cEndPointCob) and (AResultCode = HTTP_OK) then
    AResultCode := HTTP_CREATED;
end;

function TACBrPSPBradesco.CalcularURLEndPoint(const Method,
  EndPoint: String): String;
var
  AEndPointPath, p: String;
  i: Integer;
begin
  if (NivelLog > 3) then
    RegistrarLog('CalcularURLEndPoint( '+Method+', '+EndPoint+' )');
  AEndPointPath := CalcularEndPointPath(Method, EndPoint);

  //Adicionado para para pegar deferentes urls dependendo do EndPont
  Result := ObterURL(Method, EndPoint);

  if (AEndPointPath <> '') then
    Result := Result + AEndPointPath;

  ConfigurarPathParameters(Method, EndPoint);
  ConfigurarQueryParameters(Method, EndPoint);

  if (URLPathParams.Count > 0) then
    for i := 0 to URLPathParams.Count-1 do
      Result := URLComDelimitador(Result) + URLSemDelimitador(EncodeURLElement(URLPathParams[i]));

  p := URLQueryParams.AsURL;
  if (p <> '') then
    Result := Result + '?' + p;

  if (NivelLog > 3) then
    RegistrarLog('  '+Result);
end;

constructor TACBrPSPBradesco.Create(aOwner: TComponent);
begin
  inherited Create(AOwner);
  fpQuandoReceberRespostaEndPoint := QuandoReceberRespostaEndPoint;
end;

procedure TACBrPSPBradesco.Autenticar;
var
  wURL: String;
  qp: TACBrQueryParams;
  wResultCode: Integer;
  wRespostaHttp: AnsiString;
  js: TACBrJSONObject;
  sec: LongInt;
begin
  LimparHTTP;

  wURL := ObterURLAuth;
  qp := TACBrQueryParams.Create;
  try
    qp.Values['grant_type'] := 'client_credentials';
    WriteStrToStream(Http.Document, qp.AsURL);
    Http.MimeType := CContentTypeApplicationWwwFormUrlEncoded;
  finally
    qp.Free;
  end;
  
  Http.Protocol := '1.1';
  Http.UserName := ClientID;
  Http.Password := ClientSecret;
  TransmitirHttp(ChttpMethodPOST, wURL, wResultCode, wRespostaHttp);

  if (wResultCode = HTTP_OK) then
  begin
    js := TACBrJSONObject.Parse(wRespostaHttp);
    try
      fpToken := js.AsString['access_token'];
      sec := js.AsInteger['expires_in'];
    finally
      js.Free;
    end;

    if (Trim(fpToken) = EmptyStr) then
      DispararExcecao(EACBrPixHttpException.Create(ACBrStr(sErroAutenticacao)));

    fpValidadeToken := IncSecond(Now, sec);
    fpAutenticado := True;
  end
  else
    DispararExcecao(EACBrPixHttpException.CreateFmt(sErroHttp, [wResultCode, ChttpMethodPOST, wURL]));
end;

end.

