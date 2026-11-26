{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Fábio Tellini                                   }
{                                                                              }
{                                                                              }
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

{******************************************************************************
|* Historico
|*
|* 29/09/2026: Fábio Tellini
|*  - Primeira Versao ACBrShoppingPrecos
|* 24/10/2026: Projeto ACBr
|*  - Integracao ao trunk: pacotes, Lazarus, encoding, datas e nomes da API
|*
|* Documentacao da API: https://apidoc.shoppingdeprecos.com.br/introducao
******************************************************************************}

{$I ACBr.inc}

unit ACBrShoppingPrecosReg;

interface

uses
  Classes {$IFDEF FPC}, LResources {$ENDIF};

procedure Register;

implementation

uses
  SysUtils, TypInfo,
  {$IFDEF FPC}
  PropEdits,
  {$ELSE}
  DesignIntf, DesignEditors,
  {$ENDIF}
  ACBrShoppingPrecos, ACBrShoppingPrecosConfiguracoes;

{$IFNDEF FPC}
  {$R ACBrShoppingPrecos.dcr}
{$ENDIF}

type
  { Lista as plataformas da tabela estatica como sugestao; aceita qualquer
    codigo, pois a API pode ter plataformas mais novas que a tabela. }
  TSDPPlataformaProperty = class(TIntegerProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

{ TSDPPlataformaProperty }

function TSDPPlataformaProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paMultiSelect, paRevertable];
end;

function TSDPPlataformaProperty.GetValue: string;
var
  Codigo: Integer;
  Nome: string;
begin
  Codigo := GetOrdValue;

  if Codigo = 0 then
  begin
    Result := '0 - Selecione';
    Exit;
  end;

  Result := IntToStr(Codigo);
  Nome := TSDPConfiguracoes(GetComponent(0)).CadastroPlataformas.Nome(Codigo);

  if Nome <> '' then
    Result := Result + ' - ' + Nome;
end;

procedure TSDPPlataformaProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
  Cadastro: TSDPCadastroPlataformas;
begin
  Proc('0 - Selecione');
  Cadastro := TSDPConfiguracoes(GetComponent(0)).CadastroPlataformas;

  for I := 0 to Cadastro.Count - 1 do
    Proc(IntToStr(Cadastro[I].Codigo) + ' - ' + Cadastro[I].Nome);
end;

procedure TSDPPlataformaProperty.SetValue(const Value: string);
var
  Codigo, Separador: Integer;
  S: string;
begin
  S := Trim(Value);
  Separador := Pos(' - ', S);

  if Separador > 0 then
    S := Copy(S, 1, Separador - 1);

  Codigo := StrToIntDef(S, -1);

  if Codigo < 0 then
    raise EPropertyError.Create('Informe o codigo numerico da plataforma');

  SetOrdValue(Codigo);
end;

procedure Register;
begin
  RegisterComponents('ACBrTCP', [TACBrShoppingPrecos]);
  RegisterPropertyEditor(TypeInfo(TSDPPlataformaID), TSDPConfiguracoes,
    'Plataforma', TSDPPlataformaProperty);
end;

{$IFDEF FPC}
{$IFNDEF FRAMEWORK}
initialization
  {$i ACBrShoppingPrecos.lrs}
{$ENDIF}
{$ENDIF}

end.