{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
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

  Documentação
  https://www.caixa.gov.br/empresa/pagamentos-recebimentos/recebimentos/pix-automatico/

*)

{$I ACBr.inc}

unit ACBrPIXPSPCaixa;

interface

uses
  Classes, SysUtils,
  {$IFDEF RTL230_UP}ACBrBase,{$ENDIF RTL230_UP}
  ACBrPIXCD;

const
  cCaixaURLSandbox = 'https://api.caixa.gov.br:8443/sandbox/servicos-bancarios/requisicoes/pix-automatico';
  cCaixaURLProducao = 'https://api.caixa.gov.br:8443/servicos-bancarios/requisicoes/pix-automatico';
  cCaixaPathAuthToken = '/auth/realms/internet/protocol/openid-connect/token';
  cCaixaURLAuthTeste = 'https://logindes.caixa.gov.br' + cCaixaPathAuthToken;
  cCaixaURLAuthProducao = 'https://loginservicos.caixa.gov.br' + cCaixaPathAuthToken;
  cCaixaHeaderAPIKey = 'apikey:';
  cCaixaUserAgent = 'ACBrPIXCD-PSPCaixa/1.0';
  cCaixaMargemToken = 30;
  cCaixaScopesPadrao = [scCobWrite, scCobRead, scCobVWrite, scCobVRead, scRecWrite, scRecRead, scSolicRecWrite,
    scSolicRecRead, scCobRWrite, scCobRRead, scPayloadLocationRecWrite, scPayloadLocationRecRead,
    scWebhookRecWrite, scWebhookRecRead, scWebhookCobRWrite, scWebhookCobRRead];

type

  { TACBrPSPCaixa }

  {$IFDEF RTL230_UP}
  [ComponentPlatformsAttribute(piacbrAllPlatforms)]
  {$ENDIF RTL230_UP}
  TACBrPSPCaixa = class(TACBrPSPCertificate)
  private
    fAPIKey: String;
    function ObterErroAutenticacao(const aRespostaHttp: AnsiString): String;
  protected
    function ObterURLAmbientePadrao(const aAmbiente: TACBrPixCDAmbiente): String; override;
    procedure ConfigurarHeaders(const Method, AURL: String); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Autenticar; override;
  published
    property APIKey: String read fAPIKey write fAPIKey;
  end;

implementation

uses
  synautil, DateUtils, ACBrJSON, ACBrUtil.Base, ACBrUtil.Strings;

{ TACBrPSPCaixa }

constructor TACBrPSPCaixa.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fAPIKey := EmptyStr;
  Http.UserAgent := cCaixaUserAgent;
  Scopes := cCaixaScopesPadrao;
end;

function TACBrPSPCaixa.ObterURLAmbientePadrao(const aAmbiente: TACBrPixCDAmbiente): String;
begin
  if (aAmbiente = ambProducao) then
    Result := cCaixaURLProducao
  else
    Result := cCaixaURLSandbox;
end;

procedure TACBrPSPCaixa.ConfigurarHeaders(const Method, AURL: String);
begin
  inherited ConfigurarHeaders(Method, AURL);

  if NaoEstaVazio(fAPIKey) and (Pos(cCaixaPathAuthToken, AURL) = 0) then
    Http.Headers.Add(cCaixaHeaderAPIKey + ' ' + fAPIKey);
end;

procedure TACBrPSPCaixa.Autenticar;
var
  wURL, Body, wErro, wDetalhe: String;
  wRespostaHttp: AnsiString;
  wResultCode, sec: Integer;
  js: TACBrJSONObject;
  qp: TACBrQueryParams;
begin
  LimparHTTP;

  if (ACBrPixCD.Ambiente = ambProducao) then
    wURL := cCaixaURLAuthProducao
  else
    wURL := cCaixaURLAuthTeste;

  qp := TACBrQueryParams.Create;
  try
    qp.Values['grant_type'] := 'client_credentials';
    qp.Values['client_id'] := ClientID;
    qp.Values['client_secret'] := ClientSecret;
    if (Scopes <> []) then
      qp.Values['scope'] := ScopesToString(Scopes);
    Body := qp.AsURL;
    WriteStrToStream(Http.Document, Body);
    Http.MimeType := CContentTypeApplicationWwwFormUrlEncoded;
  finally
    qp.Free;
  end;

  TransmitirHttp(ChttpMethodPOST, wURL, wResultCode, wRespostaHttp);

  if (wResultCode = HTTP_OK) then
  begin
    js := TACBrJSONObject.Parse(wRespostaHttp);
    try
      fpToken := js.AsString['access_token'];
      fpRefreshToken := js.AsString['refresh_token'];
      sec := js.AsInteger['expires_in'];
    finally
      js.Free;
    end;

    if (Trim(fpToken) = EmptyStr) then
      DispararExcecao(EACBrPixHttpException.Create(ACBrStr(sErroAutenticacao)));

    if (sec > cCaixaMargemToken) then
      sec := sec - cCaixaMargemToken;

    fpValidadeToken := IncSecond(Now, sec);
    fpAutenticado := True;
  end
  else
  begin
    wErro := Format(sErroHttp, [Http.ResultCode, ChttpMethodPOST, wURL]);
    wDetalhe := ObterErroAutenticacao(wRespostaHttp);
    if NaoEstaVazio(wDetalhe) then
      wErro := wErro + sLineBreak + wDetalhe;

    DispararExcecao(EACBrPixHttpException.Create(wErro));
  end;
end;

function TACBrPSPCaixa.ObterErroAutenticacao(const aRespostaHttp: AnsiString): String;
var
  js: TACBrJSONObject;
begin
  Result := EmptyStr;
  if EstaVazio(Trim(aRespostaHttp)) then
    Exit;

  try
    js := TACBrJSONObject.Parse(UTF8ToNativeString(aRespostaHttp));
    try
      Result := Trim(js.AsString['error']);
      if NaoEstaVazio(js.AsString['error_description']) then
        Result := Result + ': ' + js.AsString['error_description'];
    finally
      js.Free;
    end;
  except
    Result := EmptyStr;
  end;
end;

end.
