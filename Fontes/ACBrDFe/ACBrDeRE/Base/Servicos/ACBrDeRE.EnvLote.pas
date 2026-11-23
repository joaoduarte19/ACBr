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

unit ACBrDeRE.EnvLote;

interface

uses
  SysUtils, Classes,
  ACBrDeRE.Conversao;

type
  { TEnvLoteDeRE - monta o lote envioLoteDere com os XMLs dos eventos ja assinados }

  TEnvLoteDeRE = class(TObject)
  private
    FnrInsc: string;
    FVersaoDF: TVersaoDeRE;
    FIds: TStringList;
    FEventos: TStringList;
  public
    constructor Create;
    destructor Destroy; override;

    procedure AddEvento(const AId, AXml: string);
    function GerarXML: string;

    property nrInsc: string read FnrInsc write FnrInsc;
    property VersaoDF: TVersaoDeRE read FVersaoDF write FVersaoDF;
    property Ids: TStringList read FIds;
    property Eventos: TStringList read FEventos;
  end;

implementation

uses
  ACBrUtil.XMLHTML;

{ TEnvLoteDeRE }

constructor TEnvLoteDeRE.Create;
begin
  inherited Create;
  FIds := TStringList.Create;
  FEventos := TStringList.Create;
  FVersaoDF := VERSAO_DERE_PADRAO;
end;

destructor TEnvLoteDeRE.Destroy;
begin
  FIds.Free;
  FEventos.Free;
  inherited Destroy;
end;

procedure TEnvLoteDeRE.AddEvento(const AId, AXml: string);
begin
  FIds.Add(AId);
  FEventos.Add(AXml);
end;

function TEnvLoteDeRE.GerarXML: string;
var
  i: Integer;
begin
  // O XML de cada evento ja esta assinado; monta-se o lote por concatenacao
  // para nao reparsear/alterar a assinatura embutida.
  Result := '<?xml version="1.0" encoding="UTF-8"?>';
  Result := Result + '<DeRE xmlns="' + NamespaceDeRE(schenvioLoteDere, FVersaoDF) + '">';
  Result := Result + '<loteEventos>';
  Result := Result + '<ideContrib>';
  Result := Result + '<nrInsc>' + FnrInsc + '</nrInsc>';
  Result := Result + '</ideContrib>';
  Result := Result + '<eventos>';

  for i := 0 to FEventos.Count - 1 do
  begin
    Result := Result + '<evento id="' + FIds[i] + '">';
    Result := Result + RemoverDeclaracaoXML(FEventos[i]);
    Result := Result + '</evento>';
  end;

  Result := Result + '</eventos>';
  Result := Result + '</loteEventos>';
  Result := Result + '</DeRE>';
end;

end.
