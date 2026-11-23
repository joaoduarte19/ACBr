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

unit ACBrNFeABI.RetEnvEvento;

interface

uses
  SysUtils,
  Classes,
  {$IF DEFINED(HAS_SYSTEM_GENERICS)}
   System.Generics.Collections,
   System.Generics.Defaults,
  {$ELSEIF DEFINED(DELPHICOMPILER16_UP)}
   System.Contnrs,
  {$IfEnd}
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrDFe.RTC.Classes,
  ACBrNFeABI.EventoClass,
  ACBrBase,
  ACBrXmlDocument;

type
  TRetInfeventoCollectionItem = class(TObject)
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
    function Add: TRetInfEventoCollectionItem; overload; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Obsoleta: Use a função New'{$EndIf};
    function New: TRetInfEventoCollectionItem;
    property Items[Index: Integer]: TRetInfEventoCollectionItem read GetItem write SetItem; default;
  end;

  TRetEventoNFeABI = class(TObject)
  private
    FidLote: Int64;
    Fversao: string;
    FtpAmb: TACBrTipoAmbiente;
    FverAplic: string;
    FcStat: Integer;
    FcOrgao: Integer;
    FxMotivo: string;
    FretInfEvento: TRetInfEventoCollection;
    FInfEvento: TInfEvento;
    Fsignature: Tsignature;
    FXML: AnsiString;
    FXmlRetorno: string;

  protected
    procedure Ler_InfEventos(const ANode: TACBrXmlNode);
//    procedure Ler_RetEvento(const ANode: TACBrXmlNode);
    procedure Ler_InfEvento(const ANode: TACBrXmlNode);
    procedure Ler_DetEvento(const ANode: TACBrXmlNode);
    procedure Ler_EvPagParcela(const ANode: TACBrXmlNode);
    procedure Ler_EvApropCredInd(const ANode: TACBrXmlNode);
    procedure Ler_EvDesfazimAlienac(const ANode: TACBrXmlNode);

  public
    constructor Create;
    destructor Destroy; override;

    function LerXml: Boolean;

    property idLote: Int64                      read FidLote    write FidLote;
    property versao: string                     read Fversao    write Fversao;
    property tpAmb: TACBrTipoAmbiente           read FtpAmb     write FtpAmb;
    property verAplic: string                   read FverAplic  write FverAplic;
    property cOrgao: Integer                    read FcOrgao    write FcOrgao;
    property cStat: Integer                     read FcStat     write FcStat;
    property xMotivo: string                    read FxMotivo   write FxMotivo;
    property InfEvento: TInfEvento              read FInfEvento write FInfEvento;
    property signature: Tsignature              read Fsignature write Fsignature;
    property retInfEvento: TRetInfEventoCollection read FretInfEvento write FretInfEvento;
    property XML: AnsiString                    read FXML       write FXML;

    property XmlRetorno: string read FXmlRetorno write FXmlRetorno;
  end;


implementation

uses
  ACBrNFeABI.Conversao,
  ACBrNFeABI,
  ACBrUtil.Strings,
  ACBrUtil.XMLHTML;

{ TRetInfEventoCollection }

function TRetInfEventoCollection.Add: TRetInfEventoCollectionItem;
begin
  Result := Self.New;
end;

function TRetInfEventoCollection.GetItem(Index: Integer): TRetInfEventoCollectionItem;
begin
  Result := TRetInfEventoCollectionItem(inherited Items[Index]);
end;

procedure TRetInfEventoCollection.SetItem(Index: Integer;
  Value: TRetInfEventoCollectionItem);
begin
  inherited Items[Index] := Value;
end;

function TRetInfEventoCollection.New: TRetInfEventoCollectionItem;
begin
  Result := TRetInfEventoCollectionItem.Create;
  Self.Add(Result);
end;

{ TRetInfEventoCollectionItem }

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

{ TRetEventoNFeABI }

constructor TRetEventoNFeABI.Create;
begin
  inherited Create;

  FretInfEvento := TRetInfEventoCollection.Create;
  FInfEvento := TInfEvento.Create;
  Fsignature := Tsignature.Create;
end;

destructor TRetEventoNFeABI.Destroy;
begin
  FretInfEvento.Free;
  FInfEvento.Free;
  Fsignature.Free;

  inherited;
end;

procedure TRetEventoNFeABI.Ler_DetEvento(const ANode: TACBrXmlNode);
var
  AuxNode: TACBrXmlNode;
begin
  if not Assigned(ANode) then Exit;

  InfEvento.DetEvento.Versao := ObterConteudoTag(ANode.Attributes.Items['versaoEvento']);

  case InfEvento.tpEvento of
    teCancelamento: AuxNode := ANode.Childrens.FindAnyNs('evCancNFeABI');
    tePagamentoOperacao: AuxNode := ANode.Childrens.FindAnyNs('evPagParcelaNFeABI');
    teApropCredIndNFeABI: AuxNode := ANode.Childrens.FindAnyNs('evApropCredIndNFeABI');
    teDesfazAlienacNFeABI: AuxNode := ANode.Childrens.FindAnyNs('evDesfazimAlienac');
  else
    AuxNode := nil;
  end;

  if AuxNode <> nil then
  begin
    InfEvento.DetEvento.descEvento := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('descEvento'), tcStr);
    InfEvento.DetEvento.nProt := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('nProt'), tcStr);
    InfEvento.DetEvento.xJust := ObterConteudoTag(AuxNode.Childrens.FindAnyNs('xJust'), tcStr);

    case InfEvento.tpEvento of
      tePagamentoOperacao: Ler_EvPagParcela(AuxNode);
      teApropCredIndNFeABI: Ler_EvApropCredInd(AuxNode);
      teDesfazAlienacNFeABI: Ler_EvDesfazimAlienac(AuxNode);
    end;
  end;
end;

procedure TRetEventoNFeABI.Ler_EvPagParcela(const ANode: TACBrXmlNode);
var
  LDet: TDetEvento;
  LGIBSCBS, LAux, LRed: TACBrXmlNode;
begin
  LDet := InfEvento.DetEvento;

  LDet.cdEventoPag := ObterConteudoTag(ANode.Childrens.FindAnyNs('cdEventoPag'), tcStr);
  LDet.vParcela := ObterConteudoTag(ANode.Childrens.FindAnyNs('vParcela'), tcDe2);
  LDet.vAcrescimos := ObterConteudoTag(ANode.Childrens.FindAnyNs('vAcrescimos'), tcDe2);
  LDet.vTotalParcela := ObterConteudoTag(ANode.Childrens.FindAnyNs('vTotalParcela'), tcDe2);
  LDet.vOrigParcela := ObterConteudoTag(ANode.Childrens.FindAnyNs('vOrigParcela'), tcDe2);
  LDet.vAcrescParcela := ObterConteudoTag(ANode.Childrens.FindAnyNs('vAcrescParcela'), tcDe2);
  LDet.dataPag := ObterConteudoTag(ANode.Childrens.FindAnyNs('dataPag'), tcDat);
  LDet.CST := ObterConteudoTag(ANode.Childrens.FindAnyNs('CST'), tcStr);
  LDet.cClassTrib := ObterConteudoTag(ANode.Childrens.FindAnyNs('cClassTrib'), tcStr);

  LGIBSCBS := ANode.Childrens.FindAnyNs('gIBSCBS');
  if not Assigned(LGIBSCBS) then Exit;

  LDet.vOperacIndiv := ObterConteudoTag(LGIBSCBS.Childrens.FindAnyNs('vOperacIndiv'), tcDe2);
  LDet.vRedAjusteIndiv := ObterConteudoTag(LGIBSCBS.Childrens.FindAnyNs('vRedAjusteIndiv'), tcDe2);
  LDet.vRedSocialIndiv := ObterConteudoTag(LGIBSCBS.Childrens.FindAnyNs('vRedSocialIndiv'), tcDe2);
  LDet.vBC := ObterConteudoTag(LGIBSCBS.Childrens.FindAnyNs('vBC'), tcDe2);

  LAux := LGIBSCBS.Childrens.FindAnyNs('gIBSUF');
  if Assigned(LAux) then
  begin
    LDet.pIBSUF := ObterConteudoTag(LAux.Childrens.FindAnyNs('pIBSUF'), tcDe4);
    LDet.vIBSUF := ObterConteudoTag(LAux.Childrens.FindAnyNs('vIBSUF'), tcDe2);

    LRed := LAux.Childrens.FindAnyNs('gRed');
    if Assigned(LRed) then
    begin
      LDet.pRedAliqIBSUF := ObterConteudoTag(LRed.Childrens.FindAnyNs('pRedAliq'), tcDe4);
      LDet.pAliqEfetIBSUF := ObterConteudoTag(LRed.Childrens.FindAnyNs('pAliqEfet'), tcDe4);
    end;
  end;

  LAux := LGIBSCBS.Childrens.FindAnyNs('gIBSMun');
  if Assigned(LAux) then
  begin
    LDet.pIBSMun := ObterConteudoTag(LAux.Childrens.FindAnyNs('pIBSMun'), tcDe4);
    LDet.vIBSMun := ObterConteudoTag(LAux.Childrens.FindAnyNs('vIBSMun'), tcDe2);

    LRed := LAux.Childrens.FindAnyNs('gRed');
    if Assigned(LRed) then
    begin
      LDet.pRedAliqIBSMun := ObterConteudoTag(LRed.Childrens.FindAnyNs('pRedAliq'), tcDe4);
      LDet.pAliqEfetIBSMun := ObterConteudoTag(LRed.Childrens.FindAnyNs('pAliqEfet'), tcDe4);
    end;
  end;

  LAux := LGIBSCBS.Childrens.FindAnyNs('gCBS');
  if Assigned(LAux) then
  begin
    LDet.pCBS := ObterConteudoTag(LAux.Childrens.FindAnyNs('pCBS'), tcDe4);
    LDet.vCBS := ObterConteudoTag(LAux.Childrens.FindAnyNs('vCBS'), tcDe2);

    LRed := LAux.Childrens.FindAnyNs('gRed');
    if Assigned(LRed) then
    begin
      LDet.pRedAliqCBS := ObterConteudoTag(LRed.Childrens.FindAnyNs('pRedAliq'), tcDe4);
      LDet.pAliqEfetCBS := ObterConteudoTag(LRed.Childrens.FindAnyNs('pAliqEfet'), tcDe4);
    end;
  end;
end;

procedure TRetEventoNFeABI.Ler_EvApropCredInd(const ANode: TACBrXmlNode);
var
  ANodes: TACBrXmlNodeArray;
  I: Integer;
begin
  InfEvento.DetEvento.adquirente.Clear;

  ANodes := ANode.Childrens.FindAll('adquirente');
  for I := 0 to Length(ANodes) - 1 do
    with InfEvento.DetEvento.adquirente.New do
    begin
      CNPJCPF := ObterConteudoTagCNPJCPF(ANodes[I]);
      xNome := ObterConteudoTag(ANodes[I].Childrens.FindAnyNs('xNome'), tcStr);
      pParticip := ObterConteudoTag(ANodes[I].Childrens.FindAnyNs('pParticip'), tcDe4);
    end;
end;

procedure TRetEventoNFeABI.Ler_EvDesfazimAlienac(const ANode: TACBrXmlNode);
begin
  InfEvento.DetEvento.tpDesfaz := StrTotpDesfaz(ObterConteudoTag(ANode.Childrens.FindAnyNs('tpDesfaz'), tcStr));
  InfEvento.DetEvento.dtDesfaz := ObterConteudoTag(ANode.Childrens.FindAnyNs('dtDesfaz'), tcDat);
  InfEvento.DetEvento.xDesfaz := ObterConteudoTag(ANode.Childrens.FindAnyNs('xDesfaz'), tcStr);
end;

procedure TRetEventoNFeABI.Ler_InfEvento(const ANode: TACBrXmlNode);
var
  ok: Boolean;
begin
  if not Assigned(ANode) then Exit;

  infEvento.Id := ObterConteudoTag(ANode.Attributes.Items['Id']);
  infEvento.cOrgao := ObterConteudoTag(ANode.Childrens.FindAnyNs('cOrgao'), tcInt);
  infEvento.tpAmb := StrToTipoAmbiente(ObterConteudoTag(ANode.Childrens.FindAnyNs('tpAmb'), tcStr));
  infEvento.CNPJCPF := ObterConteudoTagCNPJCPF(ANode);
  infEvento.chNFeABI := ObterConteudoTag(ANode.Childrens.FindAnyNs('chNFeABI'), tcStr);
  infEvento.dhEvento := ObterConteudoTag(ANode.Childrens.FindAnyNs('dhEvento'), tcDatHor);
  infEvento.tpEvento := StrToTpEventoNFeABI(ok, ObterConteudoTag(ANode.Childrens.FindAnyNs('tpEvento'), tcStr));
  infEvento.nSeqEvento := ObterConteudoTag(ANode.Childrens.FindAnyNs('nSeqEvento'), tcInt);

  Ler_DetEvento(ANode.Childrens.FindAnyNs('detEvento'));
end;

procedure TRetEventoNFeABI.Ler_InfEventos(const ANode: TACBrXmlNode);
var
  Item: TRetInfEventoCollectionItem;
  ok: Boolean;
begin
  if not Assigned(ANode) then Exit;

  Item := FretInfEvento.New;

  Item.RetInfEvento.XML := ANode.OuterXml;

  Item.RetInfEvento.Id := ObterConteudoTag(ANode.Attributes.Items['Id']);
  Item.RetInfEvento.tpAmb := StrToTipoAmbiente(ObterConteudoTag(ANode.Childrens.FindAnyNs('tpAmb'), tcStr));
  Item.RetInfEvento.verAplic := ObterConteudoTag(ANode.Childrens.FindAnyNs('verAplic'), tcStr);
  Item.RetInfEvento.cOrgao := ObterConteudoTag(ANode.Childrens.FindAnyNs('cOrgao'), tcInt);
  Item.RetInfEvento.cStat := ObterConteudoTag(ANode.Childrens.FindAnyNs('cStat'), tcInt);
  Item.RetInfEvento.xMotivo := ObterConteudoTag(ANode.Childrens.FindAnyNs('xMotivo'), tcStr);
  Item.RetInfEvento.chNFeABI := ObterConteudoTag(ANode.Childrens.FindAnyNs('chNFeABI'), tcStr);
  Item.RetInfEvento.tpEvento := StrToTpEventoNFeABI(ok, ObterConteudoTag(ANode.Childrens.FindAnyNs('tpEvento'), tcStr));
  Item.RetInfEvento.xEvento := ObterConteudoTag(ANode.Childrens.FindAnyNs('xEvento'), tcStr);
  Item.RetInfEvento.nSeqEvento := ObterConteudoTag(ANode.Childrens.FindAnyNs('nSeqEvento'), tcInt);
  Item.RetInfEvento.dhRegEvento := ObterConteudoTag(ANode.Childrens.FindAnyNs('dhRegEvento'), tcDatHor);
  Item.RetInfEvento.nProt := ObterConteudoTag(ANode.Childrens.FindAnyNs('nProt'), tcStr);

  tpAmb   := Item.RetInfEvento.tpAmb;
  cStat   := Item.RetInfEvento.cStat;
  xMotivo := Item.RetInfEvento.xMotivo;
end;

{
procedure TRetEventoNFeABI.Ler_RetEvento(const ANode: TACBrXmlNode);
var
  ok: Boolean;
  i: Integer;
  ANodes: TACBrXmlNodeArray;
begin
  if not Assigned(ANode) then Exit;

  versao := ObterConteudoTag(ANode.Attributes.Items['versao']);
  idLote := ObterConteudoTag(ANode.Childrens.FindAnyNs('idLote'), tcInt64);
  tpAmb := StrToTpAmb(ok, ObterConteudoTag(ANode.Childrens.FindAnyNs('tpAmb'), tcStr));
  verAplic := ObterConteudoTag(ANode.Childrens.FindAnyNs('verAplic'), tcStr);
  cOrgao := ObterConteudoTag(ANode.Childrens.FindAnyNs('cOrgao'), tcInt);
  cStat := ObterConteudoTag(ANode.Childrens.FindAnyNs('cStat'), tcInt);
  xMotivo := ObterConteudoTag(ANode.Childrens.FindAnyNs('xMotivo'), tcStr);

  ANodes := ANode.Childrens.FindAll('retEvento');
  for i := 0 to Length(ANodes) - 1 do
  begin
    Ler_InfEventos(ANodes[i].Childrens.FindAnyNs('infEvento'));
  end;
end;
}
function TRetEventoNFeABI.LerXml: Boolean;
var
  Document: TACBrXmlDocument;
  ANode, AuxNode: TACBrXmlNode;
  ANodes: TACBrXmlNodeArray;
  i: Integer;
begin
  Document := TACBrXmlDocument.Create;

  try
    try
      if XmlRetorno = '' then Exit;

      Document.LoadFromXml(XmlRetorno);

      ANode := Document.Root;

      if ANode <> nil then
      begin
        if (ANode.LocalName = 'procEventoNFeABI') then
        begin
          versao := ObterConteudoTag(ANode.Attributes.Items['versao']);

          AuxNode := ANode.Childrens.FindAnyNs('eventoNFeABI');

          if AuxNode = nil then
            AuxNode := ANode.Childrens.FindAnyNs('evento');

          Ler_InfEvento(AuxNode.Childrens.FindAnyNs('infEvento'));

          AuxNode := ANode.Childrens.FindAnyNs('retEventoNFeABI');

          if AuxNode <> nil then
          begin
            ANodes := AuxNode.Childrens.FindAllAnyNs('infEvento');
            for i := 0 to Length(ANodes) - 1 do
            begin
              Ler_InfEventos(ANodes[i]);
            end;
          end;
        end;

        if ANode.LocalName = 'retEventoNFeABI' then
        begin
          ANodes := ANode.Childrens.FindAllAnyNs('infEvento');
          for i := 0 to Length(ANodes) - 1 do
          begin
            Ler_InfEventos(ANodes[i]);
          end;
        end;

        if (ANode.LocalName = 'eventoNFeABI') or (ANode.LocalName = 'evento') then
          Ler_InfEvento(ANode.Childrens.FindAnyNs('infEvento'));

        LerSignature(ANode.Childrens.FindAnyNs('Signature'), signature);
      end;

      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(Document);
  end;
end;

end.
