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

unit ACBrNFeABI.EnvEvento;

interface

uses
  SysUtils, Classes,
  {$IF DEFINED(HAS_SYSTEM_GENERICS)}
   System.Generics.Collections, System.Generics.Defaults,
  {$ELSEIF DEFINED(DELPHICOMPILER16_UP)}
   System.Contnrs,
  {$IfEnd}
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrDFeConsts,
  ACBrNFeABI.Consts,
  ACBrNFeABI.EventoClass,
  ACBrBase,
  ACBrXmlWriter,
  ACBrXmlDocument;

type
  TInfEventoCollectionItem = class(TObject)
  private
    FInfEvento: TInfEvento;
    Fsignature: Tsignature;
    FRetInfEvento: TRetInfEvento;
    FXML: string;
  public
    constructor Create;
    destructor Destroy; override;

    property InfEvento: TInfEvento read FInfEvento write FInfEvento;
    property signature: Tsignature read Fsignature write Fsignature;
    property RetInfEvento: TRetInfEvento read FRetInfEvento write FRetInfEvento;
    property XML: string read FXML write FXML;
  end;

  TInfEventoCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TInfEventoCollectionItem;
    procedure SetItem(Index: Integer; Value: TInfEventoCollectionItem);
  public
    function Add: TInfEventoCollectionItem; overload; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Obsoleta: Use a função New.'{$EndIf};
    function New: TInfEventoCollectionItem;
    property Items[Index: Integer]: TInfEventoCollectionItem read GetItem write SetItem; default;
  end;

  { TEventoNFeABI }

  TEventoNFeABI = class(TACBrXmlWriter)
  private
    FidLote: Int64;
    FEvento: TInfEventoCollection;
    FVersao: string;
    FXmlEnvio: string;

    procedure SetEvento(const Value: TInfEventoCollection);

    function GetOpcoes: TACBrXmlWriterOptions;
    procedure SetOpcoes(const Value: TACBrXmlWriterOptions);
  protected
    function CreateOptions: TACBrXmlWriterOptions; override;

    function Gerar_InfEvento(Idx: Integer): TACBrXmlNode;
    function Gerar_DetEvento(Idx: Integer): TACBrXmlNode;
    function Gerar_Evento_Cancelamento(Idx: Integer): TACBrXmlNode;
  public
    constructor Create;
    destructor Destroy; override;

    function GerarXml: Boolean; Override;

    function LerXML(const CaminhoArquivo: string): Boolean;
    function LerXMLFromString(const AXML: string): Boolean;
    function ObterNomeArquivo(tpEvento: TACBrTipoEvento): string;
    function LerFromIni(const AIniString: string): Boolean;

    property idLote: Int64 read FidLote write FidLote;
    property Evento: TInfEventoCollection read FEvento write SetEvento;
    property Versao: string read FVersao write FVersao;
    property Opcoes: TACBrXmlWriterOptions read GetOpcoes write SetOpcoes;
    property XmlEnvio: string read FXmlEnvio write FXmlEnvio;
  end;

implementation

uses
  IniFiles,
  ACBrDFeUtil,
  ACBrUtil.Base,
  ACBrUtil.Strings,
  ACBrUtil.DateTime,
  ACBrUtil.FilesIO,
  ACBrNFeABI.RetEnvEvento,
  ACBrNFeABI.Conversao;

{ TEventoNFeABI }

constructor TEventoNFeABI.Create;
begin
  inherited Create;

  FEvento  := TInfEventoCollection.Create();
end;

function TEventoNFeABI.CreateOptions: TACBrXmlWriterOptions;
begin
  Result := TACBrXmlWriterOptions.Create();
end;

destructor TEventoNFeABI.Destroy;
begin
  FEvento.Free;

  inherited;
end;

function TEventoNFeABI.ObterNomeArquivo(tpEvento: TACBrTipoEvento): string;
begin
  case tpEvento of
    teCancelamento: Result := IntToStr(Self.idLote) + '-can-eve.xml';
  else
    raise EventoException.Create('Obter nome do arquivo de Evento não Implementado!');
  end;
end;

function TEventoNFeABI.GerarXML: Boolean;
var
  EventoNode: TACBrXmlNode;
begin
  ListaDeAlertas.Clear;

  FDocument.Clear();

  EventoNode := CreateElement('evento');
  EventoNode.SetNamespace('http://www.portalfiscal.inf.br/nfeabi');
  EventoNode.SetAttribute('versao', Versao);

  FDocument.Root := EventoNode;


  EventoNode.AppendChild(Gerar_InfEvento(0));

  // Incluir a assinatura no XML
  if Evento[0].signature.URI <> '' then
    EventoNode.AppendChild(GerarSignature(Evento[0].signature));

  XmlEnvio := ChangeLineBreak(Document.Xml, '');
  Result := True;
end;

function TEventoNFeABI.Gerar_Evento_Cancelamento(Idx: Integer): TACBrXmlNode;
begin
  Result := CreateElement('evCancNFeABI');
  Result.SetAttribute('versao', Versao);

  Result.AppendChild(AddNode(tcStr, 'EP02', 'descEvento', 4, 60, 1,
                                            Evento[Idx].FInfEvento.DescEvento));

  Result.AppendChild(AddNode(tcStr, 'EP03', 'nProt', 15, 15, 1,
                                       Evento[Idx].FInfEvento.detEvento.nProt));

  Result.AppendChild(AddNode(tcStr, 'EP04', 'xJust', 15, 255, 1,
                                       Evento[Idx].FInfEvento.detEvento.xJust));

end;

function TEventoNFeABI.Gerar_DetEvento(Idx: Integer): TACBrXmlNode;
begin
  Result := CreateElement('detEvento');
  Result.SetAttribute('versaoEvento', Versao);

  case Evento[Idx].InfEvento.tpEvento of
    teCancelamento: Result.AppendChild(Gerar_Evento_Cancelamento(Idx));
  end;
end;

function TEventoNFeABI.Gerar_InfEvento(Idx: Integer): TACBrXmlNode;
var
  sDoc: string;
begin
  Evento[Idx].InfEvento.id := 'ID' + Evento[Idx].InfEvento.TipoEvento +
                             RemoverLiteralChave(Evento[Idx].InfEvento.chNFeABI) +
                             Format('%.3d', [Evento[Idx].InfEvento.nSeqEvento]);

  if Length(Evento[Idx].InfEvento.id) < 54 then
    wAlerta('P04', 'ID', '', 'ID de Evento inválido');

  Result := CreateElement('infEvento');
  Result.SetAttribute('Id', Evento[Idx].InfEvento.id);

  Result.AppendChild(AddNode(tcInt, 'P05', 'cOrgao', 1, 2, 1,
                                                Evento[Idx].FInfEvento.cOrgao));

  Result.AppendChild(AddNode(tcStr, 'P06', 'tpAmb', 1, 1, 1,
                    TipoAmbienteToStr(Evento[Idx].InfEvento.tpAmb), DSC_TPAMB));

  Result.AppendChild(AddNodeCNPJCPF('P07', 'P08',
                           OnlyCPFCNPJAlphaNum(Evento[Idx].InfEvento.CNPJCPF)));

  Result.AppendChild(AddNode(tcStr, 'P09', 'chNFeABI', 44, 44, 1,
                                      Evento[Idx].FInfEvento.chNFeABI, DSC_CHAVE));

  if not ValidarChave(Evento[Idx].InfEvento.chNFeABI) then
    wAlerta('P10', 'chNFeABI', '', 'Chave de DC-e inválida');

  Result.AppendChild(AddNode(tcStr, 'P11', 'dhEvento', 1, 50, 1,
    FormatDateTime('yyyy-mm-dd"T"hh:nn:ss', Evento[Idx].InfEvento.dhEvento)+
    GetUTC(CodigoUFparaUF(Evento[Idx].InfEvento.cOrgao),
    Evento[Idx].InfEvento.dhEvento)));

  Result.AppendChild(AddNode(tcInt, 'P12', 'tpEvento', 6, 6, 1,
                                            Evento[Idx].FInfEvento.TipoEvento));

  Result.AppendChild(AddNode(tcInt, 'P13', 'nSeqEvento', 1, 3, 1,
                                            Evento[Idx].FInfEvento.nSeqEvento));

  Result.AppendChild(AddNode(tcStr, 'P14', 'verEvento', 1, 4, 1, Versao));

  Result.AppendChild(Gerar_DetEvento(Idx));
end;

function TEventoNFeABI.GetOpcoes: TACBrXmlWriterOptions;
begin
  Result := TACBrXmlWriterOptions(FOpcoes);
end;

procedure TEventoNFeABI.SetEvento(const Value: TInfEventoCollection);
begin
  FEvento.Assign(Value);
end;

procedure TEventoNFeABI.SetOpcoes(const Value: TACBrXmlWriterOptions);
begin
  FOpcoes := Value;
end;

function TEventoNFeABI.LerXML(const CaminhoArquivo: string): Boolean;
var
  aXml: string;
begin
  aXml := CarregarArquivo(CaminhoArquivo);
  Result := LerXMLFromString(aXml);
end;

function TEventoNFeABI.LerXMLFromString(const AXML: string): Boolean;
var
  RetEventoNFeABI: TRetEventoNFeABI;
begin
  RetEventoNFeABI := TRetEventoNFeABI.Create;

  try
    RetEventoNFeABI.XmlRetorno := AXML;
    Result := RetEventoNFeABI.LerXml;

    with FEvento.New do
    begin
      XML := AXML;

      infEvento.ID := RetEventoNFeABI.InfEvento.id;
      infEvento.cOrgao := RetEventoNFeABI.InfEvento.cOrgao;
      infEvento.tpAmb := RetEventoNFeABI.InfEvento.tpAmb;
//      infEvento.tpEmit := RetEventoNFeABI.InfEvento.tpEmit;
      infEvento.CNPJCPF := RetEventoNFeABI.InfEvento.CNPJCPF;
      infEvento.CNPJCPFEmit := RetEventoNFeABI.InfEvento.CNPJCPFEmit;
      infEvento.IdOutrosEmit := RetEventoNFeABI.InfEvento.IdOutrosEmit;
      infEvento.chNFeABI := RetEventoNFeABI.InfEvento.chNFeABI;
      infEvento.dhEvento := RetEventoNFeABI.InfEvento.dhEvento;
      infEvento.tpEvento := RetEventoNFeABI.InfEvento.tpEvento;
      infEvento.nSeqEvento := RetEventoNFeABI.InfEvento.nSeqEvento;

       infEvento.DetEvento.descEvento := RetEventoNFeABI.InfEvento.DetEvento.descEvento;
      infEvento.DetEvento.nProt := RetEventoNFeABI.InfEvento.DetEvento.nProt;
      infEvento.DetEvento.xJust := RetEventoNFeABI.InfEvento.DetEvento.xJust;

      signature.URI := RetEventoNFeABI.signature.URI;
      signature.DigestValue := RetEventoNFeABI.signature.DigestValue;
      signature.SignatureValue := RetEventoNFeABI.signature.SignatureValue;
      signature.X509Certificate := RetEventoNFeABI.signature.X509Certificate;

      if RetEventoNFeABI.retInfEvento.Count > 0 then
      begin
        RetInfEvento.Id := RetEventoNFeABI.retInfEvento[0].RetInfEvento.Id;
        RetInfEvento.tpAmb := RetEventoNFeABI.retInfEvento[0].RetInfEvento.tpAmb;
        RetInfEvento.verAplic := RetEventoNFeABI.retInfEvento[0].RetInfEvento.verAplic;
        RetInfEvento.cOrgao := RetEventoNFeABI.retInfEvento[0].RetInfEvento.cOrgao;
        RetInfEvento.cStat := RetEventoNFeABI.retInfEvento[0].RetInfEvento.cStat;
        RetInfEvento.xMotivo := RetEventoNFeABI.retInfEvento[0].RetInfEvento.xMotivo;
        RetInfEvento.chNFeABI := RetEventoNFeABI.retInfEvento[0].RetInfEvento.chNFeABI;
        RetInfEvento.tpEvento := RetEventoNFeABI.retInfEvento[0].RetInfEvento.tpEvento;
        RetInfEvento.xEvento := RetEventoNFeABI.retInfEvento[0].RetInfEvento.xEvento;
        RetInfEvento.nSeqEvento := RetEventoNFeABI.retInfEvento[0].RetInfEvento.nSeqEvento;
        RetInfEvento.dhRegEvento := RetEventoNFeABI.retInfEvento[0].RetInfEvento.dhRegEvento;
        RetInfEvento.nProt := RetEventoNFeABI.retInfEvento[0].RetInfEvento.nProt;
        RetInfEvento.XML := RetEventoNFeABI.retInfEvento[0].RetInfEvento.XML;
      end;
    end;
  finally
    RetEventoNFeABI.Free;
  end;
end;

function TEventoNFeABI.LerFromIni(const AIniString: string): Boolean;
var
  I: Integer;
  sSecao, sFim: string;
  INIRec: TMemIniFile;
  ok: Boolean;
begin
{$IFNDEF COMPILER23_UP}
  Result := False;
{$ENDIF}
  Self.Evento.Clear;

  INIRec := TMemIniFile.Create('');
  try
    LerIniArquivoOuString(AIniString, INIRec);
    idLote := INIRec.ReadInteger( 'EVENTO', 'idLote', 0);

    I := 1;
    while true do
    begin
      sSecao := 'EVENTO' + IntToStrZero(I, 3);
      sFim := INIRec.ReadString(sSecao, 'chNFeABI', 'FIM');

      if (sFim = 'FIM') or (Length(sFim) <= 0) then
        break ;

      with Self.Evento.New do
      begin
        infEvento.chNFeABI := sFim;
        infEvento.cOrgao := INIRec.ReadInteger(sSecao, 'cOrgao', 0);
        infEvento.CNPJCPF := INIRec.ReadString(sSecao, 'CNPJCPF', '');
        infEvento.CNPJCPFEmit := INIRec.ReadString(sSecao, 'CNPJCPFEmit', '');
        infEvento.IdOutrosEmit := INIRec.ReadString(sSecao, 'IdOutrosEmit', '');
        infEvento.dhEvento := StringToDateTime(INIRec.ReadString(sSecao, 'dhEvento', ''));
        infEvento.tpEvento := StrToTpEventoNFeABI(ok, INIRec.ReadString(sSecao, 'tpEvento', ''));
        infEvento.nSeqEvento := INIRec.ReadInteger(sSecao, 'nSeqEvento', 1);

        infEvento.detEvento.nProt := INIRec.ReadString(sSecao, 'nProt', '');
        infEvento.detEvento.xJust := INIRec.ReadString(sSecao, 'xJust', '');
      end;

      Inc(I);
    end;

    Result := True;
  finally
    INIRec.Free;
  end;
end;

{ TInfEventoCollection }

function TInfEventoCollection.Add: TInfEventoCollectionItem;
begin
  Result := Self.New;
end;

function TInfEventoCollection.GetItem(
  Index: Integer): TInfEventoCollectionItem;
begin
  Result := TInfEventoCollectionItem(inherited Items[Index]);
end;

procedure TInfEventoCollection.SetItem(Index: Integer;
  Value: TInfEventoCollectionItem);
begin
  inherited Items[Index] := Value;
end;

function TInfEventoCollection.New: TInfEventoCollectionItem;
begin
  Result := TInfEventoCollectionItem.Create;
  Self.Add(Result);
end;

{ TInfEventoCollectionItem }

constructor TInfEventoCollectionItem.Create;
begin
  inherited Create;

  FInfEvento := TInfEvento.Create;
  Fsignature := Tsignature.Create;
  FRetInfEvento := TRetInfEvento.Create;
end;

destructor TInfEventoCollectionItem.Destroy;
begin
  FInfEvento.Free;
  fsignature.Free;
  FRetInfEvento.Free;

  inherited;
end;

end.

