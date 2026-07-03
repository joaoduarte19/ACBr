{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interacao com equipa- }
{ mentos de Automacao Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Jonathas Duarte Pereira                         }
{                                                                              }
{  Voce pode obter a ultima versao desse arquivo na pagina do Projeto ACBr     }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Esta biblioteca e software livre; voce pode redistribui-la e/ou modifica-la }
{ sob os termos da Licenca Publica Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a versao 2.1 da Licenca, ou (a seu criterio) }
{ qualquer versao posterior.                                                   }
{                                                                              }
{  Esta biblioteca e distribuida na expectativa de que seja util, porem, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia implicita de COMERCIABILIDADE OU      }
{ ADEQUACAO A UMA FINALIDADE ESPECIFICA. Consulte a Licenca Publica Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENCA.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Voce deve ter recebido uma copia da Licenca Publica Geral Menor do GNU junto}
{ com esta biblioteca; se nao, escreva para a Free Software Foundation, Inc.,  }
{ no endereco 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Voce tambem pode obter uma copia da licenca em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Simoes de Almeida - daniel@projetoacbr.com.br - www.projetoacbr.com.br}
{       Rua Coronel Aureliano de Camargo, 963 - Tatui - SP - 18270-170         }
{******************************************************************************}

{$I ACBr.inc}

unit ACBrNFGas.RetEnvEvento;

interface

uses
  SysUtils, Classes,
  {$IF DEFINED(HAS_SYSTEM_GENERICS)}
   System.Generics.Collections, System.Generics.Defaults,
  {$ELSEIF DEFINED(DELPHICOMPILER16_UP)}
   System.Contnrs,
  {$IFEND}
  ACBrBase,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrNFGas.EventoClass,
  ACBrXmlDocument;

type
  TRetInfEventoCollectionItem = class(TObject)
  private
    FRetInfEvento: TRetInfEvento;
  public
    constructor Create;
    destructor Destroy; override;

    property RetInfEvento: TRetInfEvento read FRetInfEvento write FRetInfEvento;
  end;

  TRetInfEventoCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TRetInfEventoCollectionItem;
    procedure SetItem(Index: Integer; Value: TRetInfEventoCollectionItem);
  public
    function Add: TRetInfEventoCollectionItem; overload; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Obsoleta: Use a funcao New'{$EndIf};
    function New: TRetInfEventoCollectionItem;

    property Items[Index: Integer]: TRetInfEventoCollectionItem read GetItem write SetItem; default;
  end;

  TRetEventoNFGas = class(TObject)
  private
    Fversao: string;
    FretInfEvento: TRetInfEvento;
    FretEvento: TRetInfEventoCollection;
    Fsignature: Tsignature;
    FXML: string;
    FXmlRetorno: string;

    procedure Ler_RetEvento(const ANode: TACBrXmlNode);
  public
    constructor Create;
    destructor Destroy; override;

    function LerXml: Boolean;

    property versao: string read Fversao write Fversao;
    property retInfEvento: TRetInfEvento read FretInfEvento write FRetInfEvento;
    property retEvento: TRetInfEventoCollection read FretEvento write FRetEvento;
    property signature: Tsignature read Fsignature write Fsignature;
    property XML: string read FXML write FXML;
    property XmlRetorno: string read FXmlRetorno write FXmlRetorno;
  end;

implementation

uses
  ACBrNFGas.Conversao,
  ACBrUtil.Base,
  ACBrUtil.Strings,
  ACBrXmlReader;

constructor TRetEventoNFGas.Create;
begin
  inherited Create;

  FretInfEvento := TRetInfEvento.Create;
  FretEvento := TRetInfEventoCollection.Create;
  Fsignature := Tsignature.Create;
end;

destructor TRetEventoNFGas.Destroy;
begin
  FretInfEvento.Free;
  FretEvento.Free;
  Fsignature.Free;

  inherited;
end;

function TRetEventoNFGas.LerXml: Boolean;
var
  Document: TACBrXmlDocument;
  ANode, RetNode, InfoNode, SignatureNode: TACBrXmlNode;
begin
  Result := False;
  Document := TACBrXmlDocument.Create;
  try
    try
      Document.LoadFromXml(XmlRetorno);
      ANode := Document.Root;

      if not Assigned(ANode) then
        Exit;

      versao := ObterConteudoTag(ANode.Attributes.Items['versao']);
      SignatureNode := nil;

      if SameText(ANode.LocalName, 'procEventoNFGas') then
      begin
        RetNode := ANode.Childrens.FindAnyNs('retEventoNFGas');
        if Assigned(RetNode) then
        begin
          if EstaVazio(versao) then
            versao := ObterConteudoTag(RetNode.Attributes.Items['versao']);

          SignatureNode := RetNode.Childrens.FindAnyNs('Signature');
          InfoNode := RetNode.Childrens.FindAnyNs('infEvento');
          Ler_RetEvento(InfoNode);
        end;
      end
      else if SameText(ANode.LocalName, 'retEventoNFGas') then
      begin
        SignatureNode := ANode.Childrens.FindAnyNs('Signature');
        InfoNode := ANode.Childrens.FindAnyNs('infEvento');
        Ler_RetEvento(InfoNode);
      end;

      if Assigned(SignatureNode) then
        LerSignature(SignatureNode, signature);

      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(Document);
  end;
end;

procedure TRetEventoNFGas.Ler_RetEvento(const ANode: TACBrXmlNode);
var
  ok: Boolean;
begin
  if not Assigned(ANode) then
    Exit;

  RetInfEvento.XML := ANode.OuterXml;
  RetInfEvento.Id := ObterConteudoTag(ANode.Attributes.Items['Id']);
  RetInfEvento.tpAmb := StrToTipoAmbiente(ObterConteudoTag(ANode.Childrens.FindAnyNs('tpAmb'), tcStr));
  RetInfEvento.verAplic := ObterConteudoTag(ANode.Childrens.FindAnyNs('verAplic'), tcStr);
  RetInfEvento.cOrgao := ObterConteudoTag(ANode.Childrens.FindAnyNs('cOrgao'), tcInt);
  RetInfEvento.cStat := ObterConteudoTag(ANode.Childrens.FindAnyNs('cStat'), tcInt);
  RetInfEvento.xMotivo := ObterConteudoTag(ANode.Childrens.FindAnyNs('xMotivo'), tcStr);
  RetInfEvento.chNFGas := ObterConteudoTag(ANode.Childrens.FindAnyNs('chNFGas'), tcStr);
  RetInfEvento.tpEvento := StrToTpEventoNFGas(ok, ObterConteudoTag(ANode.Childrens.FindAnyNs('tpEvento'), tcStr));
  RetInfEvento.xEvento := ObterConteudoTag(ANode.Childrens.FindAnyNs('xEvento'), tcStr);
  RetInfEvento.nSeqEvento := ObterConteudoTag(ANode.Childrens.FindAnyNs('nSeqEvento'), tcInt);
  RetInfEvento.dhRegEvento := ObterConteudoTag(ANode.Childrens.FindAnyNs('dhRegEvento'), tcDatHor);
  RetInfEvento.nProt := ObterConteudoTag(ANode.Childrens.FindAnyNs('nProt'), tcStr);
end;

constructor TRetInfEventoCollectionItem.Create;
begin
  inherited Create;
  FRetInfEvento := TRetInfEvento.Create;
end;

destructor TRetInfEventoCollectionItem.Destroy;
begin
  FRetInfEvento.Free;
  inherited;
end;

function TRetInfEventoCollection.Add: TRetInfEventoCollectionItem;
begin
  Result := New;
end;

function TRetInfEventoCollection.GetItem(Index: Integer): TRetInfEventoCollectionItem;
begin
  Result := TRetInfEventoCollectionItem(inherited Items[Index]);
end;

function TRetInfEventoCollection.New: TRetInfEventoCollectionItem;
begin
  Result := TRetInfEventoCollectionItem.Create;
  Self.Add(Result);
end;

procedure TRetInfEventoCollection.SetItem(Index: Integer; Value: TRetInfEventoCollectionItem);
begin
  inherited Items[Index] := Value;
end;

end.
