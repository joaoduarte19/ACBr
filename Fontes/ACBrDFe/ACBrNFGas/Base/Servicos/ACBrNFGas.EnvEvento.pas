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

unit ACBrNFGas.EnvEvento;

interface

uses
  SysUtils, Classes,
  {$IF DEFINED(HAS_SYSTEM_GENERICS)}
   System.Generics.Collections, System.Generics.Defaults,
  {$ELSEIF DEFINED(DELPHICOMPILER16_UP)}
   System.Contnrs,
  {$IFEND}
  IniFiles,
  ACBrBase,
  ACBrXmlBase,
  ACBrXmlWriter,
  ACBrXmlDocument,
  ACBrDFe.Conversao,
  ACBrDFeConsts,
  ACBrDFeUtil,
  ACBrNFGas.EventoClass,
  ACBrNFGas.Conversao;

type
  EventoException = class(Exception);

  TInfEventoCollectionItem = class(TObject)
  private
    FInfEvento: TInfEvento;
    FSignature: TSignature;
    FRetInfEvento: TRetInfEvento;
    FXML: string;
  public
    constructor Create;
    destructor Destroy; override;

    property InfEvento: TInfEvento read FInfEvento write FInfEvento;
    property Signature: TSignature read FSignature write FSignature;
    property RetInfEvento: TRetInfEvento read FRetInfEvento write FRetInfEvento;
    property XML: string read FXML write FXML;
  end;

  TInfEventoCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TInfEventoCollectionItem;
    procedure SetItem(Index: Integer; Value: TInfEventoCollectionItem);
  public
    function Add: TInfEventoCollectionItem; overload; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Obsoleta: Use a funcao New.'{$EndIf};
    function New: TInfEventoCollectionItem;

    property Items[Index: Integer]: TInfEventoCollectionItem read GetItem write SetItem; default;
  end;

  TEventoNFGas = class(TACBrXmlWriter)
  private
    FIdLote: Int64;
    FEvento: TInfEventoCollection;
    FVersao: string;
    FXmlEnvio: string;

    function GetOpcoes: TACBrXmlWriterOptions;
    procedure SetEvento(const AValue: TInfEventoCollection);
    procedure SetOpcoes(const AValue: TACBrXmlWriterOptions);
  protected
    function CreateOptions: TACBrXmlWriterOptions; override;

    function Gerar_InfEvento(AIdx: Integer): TACBrXmlNode;
    function Gerar_DetEvento(AIdx: Integer): TACBrXmlNode;
    function Gerar_Evento_Cancelamento(AIdx: Integer): TACBrXmlNode;
  public
    constructor Create;
    destructor Destroy; override;

    function GerarXml: Boolean; override;
    function LerXML(const ACaminhoArquivo: string): Boolean;
    function LerXMLFromString(const AXML: string): Boolean;
    function LerFromIni(const AIniString: string): Boolean;
    function ObterNomeArquivo(tpEvento: TACBrTipoEvento): string;

    property IdLote: Int64 read FIdLote write FIdLote;
    property Evento: TInfEventoCollection read FEvento write SetEvento;
    property Versao: string read FVersao write FVersao;
    property Opcoes: TACBrXmlWriterOptions read GetOpcoes write SetOpcoes;
    property XmlEnvio: string read FXmlEnvio write FXmlEnvio;
  end;

implementation

uses
  ACBrUtil.Base,
  ACBrUtil.Strings,
  ACBrUtil.FilesIO,
  ACBrUtil.DateTime,
  ACBrUtil.XMLHTML,
  ACBrNFGas.RetEnvEvento,
  ACBrNFGas.Consts;

{ TEventoNFGas }

constructor TEventoNFGas.Create;
begin
  inherited Create;
  FEvento := TInfEventoCollection.Create;
end;

destructor TEventoNFGas.Destroy;
begin
  FEvento.Free;
  inherited;
end;

function TEventoNFGas.CreateOptions: TACBrXmlWriterOptions;
begin
  Result := TACBrXmlWriterOptions.Create;
end;

function TEventoNFGas.GetOpcoes: TACBrXmlWriterOptions;
begin
  Result := TACBrXmlWriterOptions(FOpcoes);
end;

procedure TEventoNFGas.SetEvento(const AValue: TInfEventoCollection);
begin
  FEvento.Assign(AValue);
end;

procedure TEventoNFGas.SetOpcoes(const AValue: TACBrXmlWriterOptions);
begin
  FOpcoes := AValue;
end;

function TEventoNFGas.ObterNomeArquivo(tpEvento: TACBrTipoEvento): string;
begin
  case tpEvento of
    teCancelamento:
      Result := IntToStr(FIdLote) + '-can-eve.xml';
  else
    raise EventoException.Create('Obter nome do arquivo de evento nao implementado');
  end;
end;

function TEventoNFGas.GerarXml: Boolean;
var
  EventoNode: TACBrXmlNode;
begin
  ListaDeAlertas.Clear;
  FDocument.Clear;

  Result := (Evento.Count > 0);
  if not Result then
    Exit;

  EventoNode := CreateElement('eventoNFGas');
  EventoNode.SetNamespace('http://www.portalfiscal.inf.br/nfgas');
  EventoNode.SetAttribute('versao', Versao);

  FDocument.Root := EventoNode;
  EventoNode.AppendChild(Gerar_InfEvento(0));

  if Trim(Evento[0].Signature.URI) <> '' then
    EventoNode.AppendChild(GerarSignature(Evento[0].Signature));

  FXmlEnvio := ChangeLineBreak(Document.Xml, '');
end;

function TEventoNFGas.Gerar_InfEvento(AIdx: Integer): TACBrXmlNode;
var
  SDoc: string;
begin
  Evento[AIdx].InfEvento.Id :=
    'ID' +
    Evento[AIdx].InfEvento.TipoEvento +
    RemoverLiteralChave(Evento[AIdx].InfEvento.chNFGas) +
    Format('%.2d', [Evento[AIdx].InfEvento.nSeqEvento]);

  Result := CreateElement('infEvento');
  Result.SetAttribute('Id', Evento[AIdx].InfEvento.Id);

  Result.AppendChild(AddNode(tcInt, 'P05', 'cOrgao', 1, 2, 1,
    Evento[AIdx].InfEvento.cOrgao));

  Result.AppendChild(AddNode(tcStr, 'P06', 'tpAmb', 1, 1, 1,
    TipoAmbienteToStr(Evento[AIdx].InfEvento.tpAmb), DSC_TPAMB));

  SDoc := OnlyAlphaNum(Evento[AIdx].InfEvento.CNPJ);
  if EstaVazio(SDoc) then
    SDoc := ExtrairCNPJCPFChaveAcesso(Evento[AIdx].InfEvento.chNFGas);

  Result.AppendChild(AddNode(tcStr, 'HP10', 'CNPJ', 14, 14, 1, SDoc, DSC_CNPJ));

  if not ValidarCNPJ(SDoc) then
    wAlerta('HP10', 'CNPJ', DSC_CNPJ, ERR_MSG_INVALIDO);

  Result.AppendChild(AddNode(tcStr, 'HP12', 'chNFGas', 44, 44, 1,
    Evento[AIdx].InfEvento.chNFGas, DSC_CHAVE));

  if not ValidarChave(Evento[AIdx].InfEvento.chNFGas) then
    wAlerta('HP12', 'chNFGas', DSC_CHAVE, ERR_MSG_INVALIDO);

  Result.AppendChild(AddNode(tcStr, 'HP13', 'dhEvento', 1, 50, 1,
    FormatDateTime('yyyy-mm-dd"T"hh:nn:ss', Evento[AIdx].InfEvento.dhEvento) +
    GetUTC(CodigoUFparaUF(Evento[AIdx].InfEvento.cOrgao), Evento[AIdx].InfEvento.dhEvento)));

  Result.AppendChild(AddNode(tcInt, 'HP14', 'tpEvento', 6, 6, 1,
    Evento[AIdx].InfEvento.TipoEvento));

  Result.AppendChild(AddNode(tcInt, 'HP15', 'nSeqEvento', 1, 3, 1,
    Evento[AIdx].InfEvento.nSeqEvento));

  Result.AppendChild(Gerar_DetEvento(AIdx));
end;

function TEventoNFGas.Gerar_DetEvento(AIdx: Integer): TACBrXmlNode;
begin
  Result := CreateElement('detEvento');
  Result.SetAttribute('versaoEvento', Versao);

  case Evento[AIdx].InfEvento.tpEvento of
    teCancelamento:
      Result.AppendChild(Gerar_Evento_Cancelamento(AIdx));
  else
    raise EventoException.Create('Tipo de evento nao implementado para NFGas');
  end;
end;

function TEventoNFGas.Gerar_Evento_Cancelamento(AIdx: Integer): TACBrXmlNode;
begin
  Result := CreateElement('evCancNFGas');

  Result.AppendChild(AddNode(tcStr, 'EP02', 'descEvento', 4, 60, 1,
    Evento[AIdx].InfEvento.DescEvento));

  Result.AppendChild(AddNode(tcStr, 'EP03', 'nProt', 15, 15, 1,
    Evento[AIdx].InfEvento.detEvento.nProt));

  Result.AppendChild(AddNode(tcStr, 'EP04', 'xJust', 15, 255, 1,
    Evento[AIdx].InfEvento.detEvento.xJust));
end;

function TEventoNFGas.LerXML(const ACaminhoArquivo: string): Boolean;
begin
  Result := LerXMLFromString(CarregarArquivo(ACaminhoArquivo));
end;

function TEventoNFGas.LerXMLFromString(const AXML: string): Boolean;
var
  RetEventoNFGas: TRetEventoNFGas;
begin
  RetEventoNFGas := TRetEventoNFGas.Create;
  try
    RetEventoNFGas.XmlRetorno := RemoverUTF8Bom(AXML);
    Result := RetEventoNFGas.LerXml;

    with FEvento.New do
    begin
      XML := AXML;
      InfEvento.Id := RetEventoNFGas.RetInfEvento.Id;
      InfEvento.cOrgao := RetEventoNFGas.RetInfEvento.cOrgao;
      InfEvento.tpAmb := RetEventoNFGas.RetInfEvento.tpAmb;
      InfEvento.chNFGas := RetEventoNFGas.RetInfEvento.chNFGas;
      InfEvento.tpEvento := RetEventoNFGas.RetInfEvento.tpEvento;
      InfEvento.nSeqEvento := RetEventoNFGas.RetInfEvento.nSeqEvento;
      InfEvento.DetEvento.descEvento := RetEventoNFGas.RetInfEvento.xEvento;
      InfEvento.DetEvento.nProt := RetEventoNFGas.RetInfEvento.nProt;

      Signature.URI := RetEventoNFGas.Signature.URI;
      Signature.DigestValue := RetEventoNFGas.Signature.DigestValue;
      Signature.SignatureValue := RetEventoNFGas.Signature.SignatureValue;
      Signature.X509Certificate := RetEventoNFGas.Signature.X509Certificate;

      RetInfEvento.Id := RetEventoNFGas.RetInfEvento.Id;
      RetInfEvento.tpAmb := RetEventoNFGas.RetInfEvento.tpAmb;
      RetInfEvento.verAplic := RetEventoNFGas.RetInfEvento.verAplic;
      RetInfEvento.cOrgao := RetEventoNFGas.RetInfEvento.cOrgao;
      RetInfEvento.cStat := RetEventoNFGas.RetInfEvento.cStat;
      RetInfEvento.xMotivo := RetEventoNFGas.RetInfEvento.xMotivo;
      RetInfEvento.chNFGas := RetEventoNFGas.RetInfEvento.chNFGas;
      RetInfEvento.tpEvento := RetEventoNFGas.RetInfEvento.tpEvento;
      RetInfEvento.xEvento := RetEventoNFGas.RetInfEvento.xEvento;
      RetInfEvento.nSeqEvento := RetEventoNFGas.RetInfEvento.nSeqEvento;
      RetInfEvento.dhRegEvento := RetEventoNFGas.RetInfEvento.dhRegEvento;
      RetInfEvento.nProt := RetEventoNFGas.RetInfEvento.nProt;
      RetInfEvento.XML := RetEventoNFGas.RetInfEvento.XML;
    end;
  finally
    RetEventoNFGas.Free;
  end;
end;

function TEventoNFGas.LerFromIni(const AIniString: string): Boolean;
var
  I: Integer;
  SSecao, SFim: string;
  INIRec: TMemIniFile;
  Ok: Boolean;
begin
{$IFNDEF COMPILER23_UP}
  Result := False;
{$ENDIF}
  Evento.Clear;

  INIRec := TMemIniFile.Create('');
  try
    LerIniArquivoOuString(AIniString, INIRec);
    IdLote := INIRec.ReadInteger('EVENTO', 'idLote', 0);

    I := 1;
    while True do
    begin
      SSecao := 'EVENTO' + IntToStrZero(I, 3);
      SFim := INIRec.ReadString(SSecao, 'chNFGas', 'FIM');

      if (SFim = 'FIM') or (Length(SFim) <= 0) then
        Break;

      with Evento.New do
      begin
        InfEvento.chNFGas := SFim;
        InfEvento.cOrgao := INIRec.ReadInteger(SSecao, 'cOrgao', 0);
        InfEvento.CNPJ := INIRec.ReadString(SSecao, 'CNPJ', '');
        InfEvento.dhEvento := StringToDateTime(INIRec.ReadString(SSecao, 'dhEvento', ''));
        InfEvento.tpEvento := StrToTpEventoNFGas(Ok, INIRec.ReadString(SSecao, 'tpEvento', ''));
        InfEvento.nSeqEvento := INIRec.ReadInteger(SSecao, 'nSeqEvento', 1);
        InfEvento.detEvento.xJust := INIRec.ReadString(SSecao, 'xJust', '');
        InfEvento.detEvento.nProt := INIRec.ReadString(SSecao, 'nProt', '');
      end;

      Inc(I);
    end;

    Result := True;
  finally
    INIRec.Free;
  end;
end;

{ TInfEventoCollectionItem }

constructor TInfEventoCollectionItem.Create;
begin
  inherited Create;
  FInfEvento := TInfEvento.Create;
  FSignature := TSignature.Create;
  FRetInfEvento := TRetInfEvento.Create;
end;

destructor TInfEventoCollectionItem.Destroy;
begin
  FInfEvento.Free;
  FSignature.Free;
  FRetInfEvento.Free;
  inherited;
end;

{ TInfEventoCollection }

function TInfEventoCollection.Add: TInfEventoCollectionItem;
begin
  Result := New;
end;

function TInfEventoCollection.GetItem(Index: Integer): TInfEventoCollectionItem;
begin
  Result := TInfEventoCollectionItem(inherited Items[Index]);
end;

function TInfEventoCollection.New: TInfEventoCollectionItem;
begin
  Result := TInfEventoCollectionItem.Create;
  Self.Add(Result);
end;

procedure TInfEventoCollection.SetItem(Index: Integer; Value: TInfEventoCollectionItem);
begin
  inherited Items[Index] := Value;
end;

end.
