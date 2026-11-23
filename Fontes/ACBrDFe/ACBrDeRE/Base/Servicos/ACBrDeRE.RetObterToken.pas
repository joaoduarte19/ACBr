{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Renato Rubinho                                  }
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

unit ACBrDeRE.RetObterToken;

interface

uses
  SysUtils, Classes;

type
  { TRetObterTokenDeRE - retorno (JSON) do servico de Token }

  TRetObterTokenDeRE = class(TObject)
  private
    FJsonRetorno: string;
    Faccess_token: string;
    Ftoken_type: string;
    Fexpires_in: Integer;
    Ferror: string;
    Ferror_description: string;
    FMsg: string;
  public
    constructor Create;

    procedure Clear;
    // Le o JSON em JsonRetorno. False (e Msg preenchida) se o JSON for invalido
    // ou nao trouxer o access_token.
    function LerJson: Boolean;
    // Data/hora de validade: agora + expires_in
    function DataExpiracao: TDateTime;

    property JsonRetorno: string read FJsonRetorno write FJsonRetorno;
    property access_token: string read Faccess_token;
    property token_type: string read Ftoken_type;
    property expires_in: Integer read Fexpires_in;
    property error: string read Ferror;
    property error_description: string read Ferror_description;
    property Msg: string read FMsg;
  end;

implementation

uses
  DateUtils,
  ACBrJSON;

const
  EXPIRES_IN_PADRAO = 3600;

{ TRetObterTokenDeRE }

constructor TRetObterTokenDeRE.Create;
begin
  inherited Create;
  Clear;
end;

procedure TRetObterTokenDeRE.Clear;
begin
  Faccess_token := '';
  Ftoken_type := '';
  Fexpires_in := EXPIRES_IN_PADRAO;
  Ferror := '';
  Ferror_description := '';
  FMsg := '';
end;

function TRetObterTokenDeRE.LerJson: Boolean;
var
  LJson: TACBrJSONObject;
begin
  Result := False;

  Clear;

  try
    LJson := TACBrJSONObject.Parse(FJsonRetorno);
    try
      Faccess_token := LJson.AsString['access_token'];
      Ftoken_type := LJson.AsString['token_type'];
      Ferror := LJson.AsString['error'];
      Ferror_description := LJson.AsString['error_description'];

      if LJson.ValueExists('expires_in') then
        Fexpires_in := LJson.AsInteger['expires_in'];
    finally
      LJson.Free;
    end;
  except
    on E: Exception do
    begin
      FMsg := 'Retorno do token invalido: ' + E.Message;
      Exit;
    end;
  end;

  if Faccess_token = '' then
  begin
    FMsg := 'Nao foi possivel obter o token de acesso (DeRE): ' +
      'campo access_token ausente no retorno.';
    Exit;
  end;

  Result := True;
end;

function TRetObterTokenDeRE.DataExpiracao: TDateTime;
begin
  Result := IncSecond(Now, Fexpires_in);
end;

end.
