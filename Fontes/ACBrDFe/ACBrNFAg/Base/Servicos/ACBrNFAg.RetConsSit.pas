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

unit ACBrNFAg.RetConsSit;

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
  ACBrNFAg.RetEnvEvento;

type

  TRetEventoNFAgCollectionItem = class(TObject)
  private
    FRetEventoNFAg: TRetEventoNFAg;
  public
    constructor Create;
    destructor Destroy; override;
    property RetEventoNFAg: TRetEventoNFAg read FRetEventoNFAg write FRetEventoNFAg;
  end;

  TRetEventoNFAgCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TRetEventoNFAgCollectionItem;
    procedure SetItem(Index: Integer; Value: TRetEventoNFAgCollectionItem);
  public
    function New: TRetEventoNFAgCollectionItem;
    property Items[Index: Integer]: TRetEventoNFAgCollectionItem read GetItem write SetItem; default;
  end;

  TRetConsSitNFAg = class(TObject)
  private
    Fversao: String;
    FtpAmb: TACBrTipoAmbiente;
    FverAplic: String;
    FcStat: Integer;
    FxMotivo: String;
    FcUF: Integer;
    FdhRecbto: TDateTime;
    FchNFAg: String;
    FprotNFAg: TProcDFe;
    FprocEventoNFAg: TRetEventoNFAgCollection;
    FnRec: String;
    FXMLprotNFAg: String;

    FXmlRetorno: String;
  public
    constructor Create;
    destructor Destroy; override;

    function LerXml: Boolean;

    property versao: String                           read Fversao         write Fversao;
    property tpAmb: TACBrTipoAmbiente                 read FtpAmb          write FtpAmb;
    property verAplic: String                         read FverAplic       write FverAplic;
    property cStat: Integer                           read FcStat          write FcStat;
    property xMotivo: String                          read FxMotivo        write FxMotivo;
    property cUF: Integer                             read FcUF            write FcUF;
    property dhRecbto: TDateTime                      read FdhRecbto       write FdhRecbto;
    property chNFAg: String                           read FchNFAg         write FchNFAg;
    property protNFAg: TProcDFe                       read FprotNFAg       write FprotNFAg;
    property procEventoNFAg: TRetEventoNFAgCollection read FprocEventoNFAg write FprocEventoNFAg;
    property nRec: String                             read FnRec           write FnRec;
    property XMLprotNFAg: String                      read FXMLprotNFAg    write FXMLprotNFAg;

    property XmlRetorno: String read FXmlRetorno write FXmlRetorno;
  end;

implementation

uses
  ACBrNFAg.Consts,
  ACBrXmlDocument;

{ TRetEventoCollection }

function TRetEventoNFAgCollection.GetItem(Index: Integer): TRetEventoNFAgCollectionItem;
begin
  Result := TRetEventoNFAgCollectionItem(inherited Items[Index]);
end;

procedure TRetEventoNFAgCollection.SetItem(Index: Integer;
  Value: TRetEventoNFAgCollectionItem);
begin
  inherited Items[Index] := Value;
end;

{ TRetEventoCollectionItem }

constructor TRetEventoNFAgCollectionItem.Create;
begin
  inherited Create;

  FRetEventoNFAg := TRetEventoNFAg.Create;
end;

destructor TRetEventoNFAgCollectionItem.Destroy;
begin
  FRetEventoNFAg.Free;

  inherited;
end;

function TRetEventoNFAgCollection.New: TRetEventoNFAgCollectionItem;
begin
  Result := TRetEventoNFAgCollectionItem.Create;
  Self.Add(Result);
end;

{ TRetConsSitNFAg }

constructor TRetConsSitNFAg.Create;
begin
  inherited Create;

  FprotNFAg := TProcDFe.Create(Versao, NAME_SPACE_NFAg, 'NFAgProc', 'NFAg');
end;

destructor TRetConsSitNFAg.Destroy;
begin
  FprotNFAg.Free;

  if Assigned(procEventoNFAg) then
    procEventoNFAg.Free;

  inherited;
end;

function TRetConsSitNFAg.LerXml: Boolean;
var
  Document: TACBrXmlDocument;
  ANode, ANodeAux: TACBrXmlNode;
  ANodeArray: TACBrXmlNodeArray;
  ok: Boolean;
  i: Integer;
begin
  Document := TACBrXmlDocument.Create;

  try
    try
      Result := True;

      Document.LoadFromXml(XmlRetorno);

      ANode := Document.Root;

      if ANode <> nil then
      begin
        versao := ObterConteudoTag(ANode.Attributes.Items['versao']);
        verAplic := ObterConteudoTag(ANode.Childrens.FindAnyNs('verAplic'), tcStr);
        tpAmb := StrToTipoAmbiente(ObterConteudoTag(ANode.Childrens.FindAnyNs('tpAmb'), tcStr));
        cUF := ObterConteudoTag(ANode.Childrens.FindAnyNs('cUF'), tcInt);
        nRec := ObterConteudoTag(ANode.Childrens.FindAnyNs('nRec'), tcStr);
        cStat := ObterConteudoTag(ANode.Childrens.FindAnyNs('cStat'), tcInt);
        xMotivo := ObterConteudoTag(ANode.Childrens.FindAnyNs('xMotivo'), tcStr);
        dhRecbto := ObterConteudoTag(ANode.Childrens.FindAnyNs('dhRecbto'), tcDatHor);
        chNFAg := ObterConteudoTag(ANode.Childrens.FindAnyNs('chNFAg'), tcStr);

        case cStat of
          100, 101, 104, 150, 151, 155:
            begin
              ANodeAux := ANode.Childrens.FindAnyNs('protNFAg');

              if ANodeAux <> nil then
              begin
                // A propriedade XMLprotNFAg contem o XML que traz o resultado do
                // processamento da NF3-e.
                XMLprotNFAg := ANodeAux.OuterXml;

                ANodeAux := ANodeAux.Childrens.FindAnyNs('infProt');

                if ANodeAux <> nil then
                begin
                  protNFAg.tpAmb := StrToTipoAmbiente(ObterConteudoTag(ANodeAux.Childrens.FindAnyNs('tpAmb'), tcStr));
                  protNFAg.verAplic := ObterConteudoTag(ANodeAux.Childrens.FindAnyNs('verAplic'), tcStr);
                  protNFAg.chDFe := ObterConteudoTag(ANodeAux.Childrens.FindAnyNs('chNFAg'), tcStr);
                  protNFAg.dhRecbto := ObterConteudoTag(ANodeAux.Childrens.FindAnyNs('dhRecbto'), tcDatHor);
                  protNFAg.nProt := ObterConteudoTag(ANodeAux.Childrens.FindAnyNs('nProt'), tcStr);
                  protNFAg.digVal := ObterConteudoTag(ANodeAux.Childrens.FindAnyNs('digVal'), tcStr);
                  protNFAg.cStat := ObterConteudoTag(ANodeAux.Childrens.FindAnyNs('cStat'), tcInt);
                  protNFAg.xMotivo := ObterConteudoTag(ANodeAux.Childrens.FindAnyNs('xMotivo'), tcStr);
                  protNFAg.cMsg := ObterConteudoTag(ANodeAux.Childrens.FindAnyNs('cMsg'), tcInt);
                  protNFAg.xMsg := ObterConteudoTag(ANodeAux.Childrens.FindAnyNs('xMsg'), tcStr);
                end;
              end;
            end;
        end;

        if Assigned(procEventoNFAg) then
          procEventoNFAg.Free;

        procEventoNFAg := TRetEventoNFAgCollection.Create;

        try
          ANodeArray := ANode.Childrens.FindAllAnyNs('procEventoNFAg');

          if Assigned(ANodeArray) then
          begin
            for i := Low(ANodeArray) to High(ANodeArray) do
            begin
              AnodeAux := ANodeArray[i];

              procEventoNFAg.New;
              procEventoNFAg.Items[i].RetEventoNFAg.XmlRetorno := AnodeAux.OuterXml;
              procEventoNFAg.Items[i].RetEventoNFAg.XML := AnodeAux.OuterXml;
              procEventoNFAg.Items[i].RetEventoNFAg.LerXml;
            end;
          end;
        except
          Result := False;
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

