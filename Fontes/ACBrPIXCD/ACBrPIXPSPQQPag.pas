{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{ - Elias César e Antonio Carlos (ACBr)                                        }
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
  https://docs.qqpag.com.br/pix-cobranca

*)

unit ACBrPIXPSPQQPag;

interface

uses
  Classes, SysUtils,
  {$IFDEF RTL230_UP}ACBrBase,{$ENDIF RTL230_UP}
  ACBrPIXCD;

const
  cQueroQueroURLSandbox      = 'https://sandbox.qqpag.com.br';
  cQueroQueroURLProducao     = 'https://pix.qqpag.com.br';
  cQueroQueroPathAuthToken   = '/api/oauth/token';
  cQueroQueroPathAPIPix      = '/api/v2/';
  cQueroQueroURLAuthSandbox  = cQueroQueroURLSandbox + cQueroQueroPathAuthToken;
  cQueroQueroURLAuthProducao = cQueroQueroURLProducao + cQueroQueroPathAuthToken;

type

  { TACBrPSPQQPag }

  {$IFDEF RTL230_UP}
  [ComponentPlatformsAttribute(piacbrAllPlatforms)]
  {$ENDIF RTL230_UP}
  TACBrPSPQQPag = class(TACBrPSPCertificate)
  protected
    function ObterURLAmbiente(const aAmbiente: TACBrPixCDAmbiente): String; override;
  public
    procedure Autenticar; override;
  end;

implementation

uses
  synautil, DateUtils, ACBrJSON, ACBrUtil.Strings;

{ TACBrPSPQQPag }

function TACBrPSPQQPag.ObterURLAmbiente(const aAmbiente: TACBrPixCDAmbiente): String;
begin
  if (aAmbiente = ambProducao) then
    Result := cQueroQueroURLProducao + cQueroQueroPathAPIPix
  else
    Result := cQueroQueroURLSandbox + cQueroQueroPathAPIPix;
end;

procedure TACBrPSPQQPag.Autenticar;
var
  wURL, Body: String;
  wRespostaHttp: AnsiString;
  wResultCode, sec: Integer;
  js, jsBody: TACBrJSONObject;
begin
  LimparHTTP;
  if (ACBrPixCD.Ambiente = ambProducao) then
    wURL := cQueroQueroURLAuthProducao
  else
    wURL := cQueroQueroURLAuthSandbox;
        
  jsBody := TACBrJSONObject.Create;
  try
    jsBody
      .AddPair('grant_type', 'client_credentials')
      .AddPair('client_id', ClientID)
      .AddPair('client_secret', ClientSecret)
      .AddPair('scope', ScopesToString(Scopes)); 
    Body := jsBody.ToJSON;
    WriteStrToStream(Http.Document, Body);
    Http.MimeType := CContentTypeApplicationJSon;
  finally
    jsBody.Free;
  end;

  Http.UserAgent := 'TACBrPSPQueroQuero/1.0.0';
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
    DispararExcecao(EACBrPixHttpException.CreateFmt(sErroHttp, [Http.ResultCode, ChttpMethodPOST, wURL]));
end;

end.

