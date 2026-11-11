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

unit ACBrNFeABI.RetConsSit;

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
  ACBrDFeComum.Proc,
  ACBrNFeABI.RetEnvEvento;

type

  TRetEventoNFeABICollectionItem = class(TObject)
  private
    FRetEventoNFeABI: TRetEventoNFeABI;
  public
    constructor Create;
    destructor Destroy; override;
    property RetEventoNFeABI: TRetEventoNFeABI read FRetEventoNFeABI write FRetEventoNFeABI;
  end;

  TRetEventoNFeABICollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TRetEventoNFeABICollectionItem;
    procedure SetItem(Index: Integer; Value: TRetEventoNFeABICollectionItem);
  public
    function New: TRetEventoNFeABICollectionItem;
    property Items[Index: Integer]: TRetEventoNFeABICollectionItem read GetItem write SetItem; default;
  end;

  TRetConsSitNFeABI = class(TObject)
  private
    Fversao: string;
    FtpAmb: TACBrTipoAmbiente;
    FverAplic: string;
    FcStat: Integer;
    FxMotivo: string;
    FcUF: Integer;
    FdhRecbto: TDateTime;
    FchNFeABI: string;
    FprotNFeABI: TProcDFe;
    FprocEventoNFeABI: TRetEventoNFeABICollection;
    FnRec: string;
    FXMLprotNFeABI: string;

    FXmlRetorno: string;
  public
    constructor Create;
    destructor Destroy; override;

    function LerXml: Boolean;

    property versao: string read Fversao write Fversao;
    property tpAmb: TACBrTipoAmbiente read FtpAmb write FtpAmb;
    property verAplic: string read FverAplic write FverAplic;
    property cStat: Integer read FcStat write FcStat;
    property xMotivo: string read FxMotivo write FxMotivo;
    property cUF: Integer read FcUF write FcUF;
    property dhRecbto: TDateTime read FdhRecbto write FdhRecbto;
    property chNFeABI: string read FchNFeABI write FchNFeABI;
    property protNFeABI: TProcDFe read FprotNFeABI write FprotNFeABI;
    property procEventoNFeABI: TRetEventoNFeABICollection read FprocEventoNFeABI write FprocEventoNFeABI;
    property nRec: string read FnRec write FnRec;
    property XMLprotNFeABI: string read FXMLprotNFeABI write FXMLprotNFeABI;

    property XmlRetorno: string read FXmlRetorno write FXmlRetorno;
  end;

implementation

uses
  ACBrUtil.Strings,
  ACBrXmlDocument;

{ TRetEventoCollection }

function TRetEventoNFeABICollection.GetItem(Index: Integer): TRetEventoNFeABICollectionItem;
begin
  Result := TRetEventoNFeABICollectionItem(inherited Items[Index]);
end;

procedure TRetEventoNFeABICollection.SetItem(Index: Integer;
  Value: TRetEventoNFeABICollectionItem);
begin
  inherited Items[Index] := Value;
end;

{ TRetEventoCollectionItem }

constructor TRetEventoNFeABICollectionItem.Create;
begin
  inherited Create;

  FRetEventoNFeABI := TRetEventoNFeABI.Create;
end;

destructor TRetEventoNFeABICollectionItem.Destroy;
begin
  FRetEventoNFeABI.Free;

  inherited;
end;

function TRetEventoNFeABICollection.New: TRetEventoNFeABICollectionItem;
begin
  Result := TRetEventoNFeABICollectionItem.Create;
  Self.Add(Result);
end;

{ TRetConsSitNFeABI }

constructor TRetConsSitNFeABI.Create;
begin
  inherited Create;

  FprotNFeABI := TProcDFe.Create('', '', '', '');
end;

destructor TRetConsSitNFeABI.Destroy;
begin
  FprotNFeABI.Free;

  if Assigned(procEventoNFeABI) then
    procEventoNFeABI.Free;

  inherited;
end;

function TRetConsSitNFeABI.LerXml: Boolean;
var
  Document: TACBrXmlDocument;
  ANode, ANodeAux: TACBrXmlNode;
  ANodeArray: TACBrXmlNodeArray;
  i: Integer;
begin
  Document := TACBrXmlDocument.Create;

  try
    try
      Result := False;

      if XmlRetorno = '' then Exit;

      Document.LoadFromXml(XmlRetorno);

      ANode := Document.Root;

      if ANode <> nil then
      begin
        versao := ObterConteudoTag(ANode.Attributes.Items['versao']);
        tpAmb := StrToTipoAmbiente(ObterConteudoTag(ANode.Childrens.FindAnyNs('tpAmb'), tcStr));
        verAplic := ObterConteudoTag(ANode.Childrens.FindAnyNs('verAplic'), tcStr);
        cStat := ObterConteudoTag(ANode.Childrens.FindAnyNs('cStat'), tcInt);
        xMotivo := ACBrStr(ObterConteudoTag(ANode.Childrens.FindAnyNs('xMotivo'), tcStr));
        cUF := ObterConteudoTag(ANode.Childrens.FindAnyNs('cUF'), tcInt);
        nRec := ObterConteudoTag(ANode.Childrens.FindAnyNs('nRec'), tcStr);
        dhRecbto := ObterConteudoTag(ANode.Childrens.FindAnyNs('dhRecbto'), tcDatHor);
        chNFeABI := ObterConteudoTag(ANode.Childrens.FindAnyNs('chNFeABI'), tcStr);

        case cStat of
          100, // Autorizado o Uso da NFeABI
          101, // Cancelamento de NFeABI homologado
          102, // Substituição da NFeABI homologado
          150: // Autorizado o Uso da NFeABI, autorização fora de prazo
            begin
              ANodeAux := ANode.Childrens.FindAnyNs('protNFeABI');

              if ANodeAux <> nil then
              begin
                // A propriedade XMLprotNFeABI contem o XML que traz o resultado do
                // processamento da NFeABI.
                XMLprotNFeABI := ANodeAux.OuterXml;

                ANodeAux := ANodeAux.Childrens.FindAnyNs('infProt');

                if ANodeAux <> nil then
                begin
         //         protNFeABI.Id := ObterConteudoTag(ANodeAux.Attributes.Items['Id']);
                  protNFeABI.tpAmb := StrToTipoAmbiente(ObterConteudoTag(ANodeAux.Childrens.FindAnyNs('tpAmb'), tcStr));
                  protNFeABI.verAplic := ObterConteudoTag(ANodeAux.Childrens.FindAnyNs('verAplic'), tcStr);
                  protNFeABI.chDFe := ObterConteudoTag(ANodeAux.Childrens.FindAnyNs('chNFeABI'), tcStr);
                  protNFeABI.dhRecbto := ObterConteudoTag(ANodeAux.Childrens.FindAnyNs('dhRecbto'), tcDatHor);
                  protNFeABI.nProt := ObterConteudoTag(ANodeAux.Childrens.FindAnyNs('nProt'), tcStr);
                  protNFeABI.digVal := ObterConteudoTag(ANodeAux.Childrens.FindAnyNs('digVal'), tcStr);
                  protNFeABI.cStat := ObterConteudoTag(ANodeAux.Childrens.FindAnyNs('cStat'), tcInt);
                  protNFeABI.xMotivo := ACBrStr(ObterConteudoTag(ANodeAux.Childrens.FindAnyNs('xMotivo'), tcStr));

                  ANodeAux := ANodeAux.Childrens.FindAnyNs('infFisco');

                  if ANodeAux <> nil then
                  begin
                    protNFeABI.cMsg := ObterConteudoTag(ANodeAux.Childrens.FindAnyNs('cMsg'), tcInt);
                    protNFeABI.xMsg := ACBrStr(ObterConteudoTag(ANodeAux.Childrens.FindAnyNs('xMsg'), tcStr));
                  end;
                end;
              end;
            end;
        end;

        if Assigned(procEventoNFeABI) then
          procEventoNFeABI.Free;

        procEventoNFeABI := TRetEventoNFeABICollection.Create;

        try
          ANodeArray := ANode.Childrens.FindAllAnyNs('procEventoNFeABI');

          if Assigned(ANodeArray) then
          begin
            for i := Low(ANodeArray) to High(ANodeArray) do
            begin
              AnodeAux := ANodeArray[i];

              procEventoNFeABI.New;
              procEventoNFeABI.Items[i].RetEventoNFeABI.XmlRetorno := AnodeAux.OuterXml;
              procEventoNFeABI.Items[i].RetEventoNFeABI.LerXml;
            end;
          end;
        finally
          Result := True;
        end;
      end;
    except
      Result := False;
    end;
  finally
    FreeAndNil(Document);
  end;
end;

end.

