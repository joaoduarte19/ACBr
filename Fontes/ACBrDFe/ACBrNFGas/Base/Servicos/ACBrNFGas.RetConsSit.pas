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

unit ACBrNFGas.RetConsSit;

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
  ACBrNFGas.RetEnvEvento;

type

  TRetEventoNFGasCollectionItem = class(TObject)
  private
    FRetEventoNFGas: TRetEventoNFGas;
  public
    constructor Create;
    destructor Destroy; override;
    property RetEventoNFGas: TRetEventoNFGas read FRetEventoNFGas write FRetEventoNFGas;
  end;

  TRetEventoNFGasCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TRetEventoNFGasCollectionItem;
    procedure SetItem(Index: Integer; Value: TRetEventoNFGasCollectionItem);
  public
    function New: TRetEventoNFGasCollectionItem;
    property Items[Index: Integer]: TRetEventoNFGasCollectionItem read GetItem write SetItem; default;
  end;

  TRetConsSitNFGas = class(TObject)
  private
    Fversao: String;
    FtpAmb: TACBrTipoAmbiente;
    FverAplic: String;
    FcStat: Integer;
    FxMotivo: String;
    FcUF: Integer;
    FdhRecbto: TDateTime;
    FchNFGas: String;
    FprotNFGas: TProcDFe;
    FprocEventoNFGas: TRetEventoNFGasCollection;
    FnRec: String;
    FXMLprotNFGas: String;

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
    property chNFGas: String                           read FchNFGas         write FchNFGas;
    property protNFGas: TProcDFe                       read FprotNFGas       write FprotNFGas;
    property procEventoNFGas: TRetEventoNFGasCollection read FprocEventoNFGas write FprocEventoNFGas;
    property nRec: String                             read FnRec           write FnRec;
    property XMLprotNFGas: String                      read FXMLprotNFGas    write FXMLprotNFGas;

    property XmlRetorno: String read FXmlRetorno write FXmlRetorno;
  end;

implementation

uses
  ACBrNFGas.Consts,
  ACBrXmlDocument;

{ TRetEventoCollection }

function TRetEventoNFGasCollection.GetItem(Index: Integer): TRetEventoNFGasCollectionItem;
begin
  Result := TRetEventoNFGasCollectionItem(inherited Items[Index]);
end;

procedure TRetEventoNFGasCollection.SetItem(Index: Integer;
  Value: TRetEventoNFGasCollectionItem);
begin
  inherited Items[Index] := Value;
end;

{ TRetEventoCollectionItem }

constructor TRetEventoNFGasCollectionItem.Create;
begin
  inherited Create;

  FRetEventoNFGas := TRetEventoNFGas.Create;
end;

destructor TRetEventoNFGasCollectionItem.Destroy;
begin
  FRetEventoNFGas.Free;

  inherited;
end;

function TRetEventoNFGasCollection.New: TRetEventoNFGasCollectionItem;
begin
  Result := TRetEventoNFGasCollectionItem.Create;
  Self.Add(Result);
end;

{ TRetConsSitNFGas }

constructor TRetConsSitNFGas.Create;
begin
  inherited Create;

  FprotNFGas := TProcDFe.Create(Versao, NAME_SPACE_NFGAS, 'NFGasProc', 'NFGas');
end;

destructor TRetConsSitNFGas.Destroy;
begin
  FprotNFGas.Free;

  if Assigned(procEventoNFGas) then
    procEventoNFGas.Free;

  inherited;
end;

function TRetConsSitNFGas.LerXml: Boolean;
var
  Document: TACBrXmlDocument;
  ANode, ANodeAux: TACBrXmlNode;
  ANodeArray: TACBrXmlNodeArray;
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
        chNFGas := ObterConteudoTag(ANode.Childrens.FindAnyNs('chNFGas'), tcStr);

        case cStat of
          100, 101, 104, 150, 151, 155:
            begin
              ANodeAux := ANode.Childrens.FindAnyNs('protNFGas');

              if ANodeAux <> nil then
              begin
                // A propriedade XMLprotNFGas contem o XML que traz o resultado do
                // processamento da NF3-e.
                XMLprotNFGas := ANodeAux.OuterXml;

                ANodeAux := ANodeAux.Childrens.FindAnyNs('infProt');

                if ANodeAux <> nil then
                begin
                  protNFGas.tpAmb := StrToTipoAmbiente(ObterConteudoTag(ANodeAux.Childrens.FindAnyNs('tpAmb'), tcStr));
                  protNFGas.verAplic := ObterConteudoTag(ANodeAux.Childrens.FindAnyNs('verAplic'), tcStr);
                  protNFGas.chDFe := ObterConteudoTag(ANodeAux.Childrens.FindAnyNs('chNFGas'), tcStr);
                  protNFGas.dhRecbto := ObterConteudoTag(ANodeAux.Childrens.FindAnyNs('dhRecbto'), tcDatHor);
                  protNFGas.nProt := ObterConteudoTag(ANodeAux.Childrens.FindAnyNs('nProt'), tcStr);
                  protNFGas.digVal := ObterConteudoTag(ANodeAux.Childrens.FindAnyNs('digVal'), tcStr);
                  protNFGas.cStat := ObterConteudoTag(ANodeAux.Childrens.FindAnyNs('cStat'), tcInt);
                  protNFGas.xMotivo := ObterConteudoTag(ANodeAux.Childrens.FindAnyNs('xMotivo'), tcStr);
                  protNFGas.cMsg := ObterConteudoTag(ANodeAux.Childrens.FindAnyNs('cMsg'), tcInt);
                  protNFGas.xMsg := ObterConteudoTag(ANodeAux.Childrens.FindAnyNs('xMsg'), tcStr);
                end;
              end;
            end;
        end;

        if Assigned(procEventoNFGas) then
          procEventoNFGas.Free;

        procEventoNFGas := TRetEventoNFGasCollection.Create;

        try
          ANodeArray := ANode.Childrens.FindAllAnyNs('procEventoNFGas');

          if Assigned(ANodeArray) then
          begin
            for i := Low(ANodeArray) to High(ANodeArray) do
            begin
              AnodeAux := ANodeArray[i];

              procEventoNFGas.New;
              procEventoNFGas.Items[i].RetEventoNFGas.XmlRetorno := AnodeAux.OuterXml;
              procEventoNFGas.Items[i].RetEventoNFGas.XML := AnodeAux.OuterXml;
              procEventoNFGas.Items[i].RetEventoNFGas.LerXml;
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

