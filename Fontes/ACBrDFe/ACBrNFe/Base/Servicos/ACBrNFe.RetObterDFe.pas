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

unit ACBrNFe.RetObterDFe;

interface

uses
  SysUtils, Classes, StrUtils,
  {$IF DEFINED(HAS_SYSTEM_GENERICS)}
   System.Generics.Collections, System.Generics.Defaults,
  {$ELSEIF DEFINED(DELPHICOMPILER16_UP)}
   System.Contnrs,
  {$IfEnd}
  ACBrBase,
  ACBrXmlBase,
  ACBrDFe.Conversao;

type
  TObterDFeTipoDocumento = (tdNFCe, tdEvento);


  { TObterDFeProcItem }

  TObterDFeProcItem = class(TObject)
  private
    Fversao: string;
    FdhInc: TDateTime;
    FnProt: string;
    FXML: string;
    FXMLDFe: string;
    FId: string;
    FChave: string;
    FCNPJCPF: string;
    FxNome: string;
    FIE: string;
    FdhDoc: TDateTime;
    FtpEvento: TACBrTipoEvento;
    FNomeArq: string;
  public
    procedure Clear;

    property versao: string    read Fversao write Fversao;
    property dhInc: TDateTime  read FdhInc  write FdhInc;
    property nProt: string     read FnProt  write FnProt;
    property XML: string       read FXML    write FXML;
    property XMLDFe: string    read FXMLDFe write FXMLDFe;
    property Id: string        read FId       write FId;
    property Chave: string     read FChave    write FChave;
    property CNPJCPF: string   read FCNPJCPF  write FCNPJCPF;
    property xNome: string     read FxNome    write FxNome;
    property IE: string        read FIE       write FIE;
    property dhDoc: TDateTime  read FdhDoc    write FdhDoc;
    property tpEvento: TACBrTipoEvento read FtpEvento write FtpEvento;
    property NomeArq: string   read FNomeArq  write FNomeArq;
  end;

  { TObterDFeDocumento }

  TObterDFeDocumento = class(TObject)
  private
    FTipo: TObterDFeTipoDocumento;
    FChave: string;
    FId: string;
    FtpEvento: TACBrTipoEvento;
    FdhDoc: TDateTime;
    Fversao: string;
    FdhInc: TDateTime;
    FnProt: string;
    FXML: string;
    FNomeArq: string;
    FOrigem: TObterDFeProcItem;
  public
    property Tipo: TObterDFeTipoDocumento read FTipo write FTipo;
    property Chave: string      read FChave    write FChave;
    property Id: string         read FId       write FId;
    property tpEvento: TACBrTipoEvento read FtpEvento write FtpEvento;
    property dhDoc: TDateTime   read FdhDoc    write FdhDoc;
    property versao: string     read Fversao   write Fversao;
    property dhInc: TDateTime   read FdhInc    write FdhInc;
    property nProt: string      read FnProt    write FnProt;
    property XML: string        read FXML      write FXML;
    property NomeArq: string    read FNomeArq  write FNomeArq;
    property Origem: TObterDFeProcItem read FOrigem write FOrigem;
  end;

  { TObterDFeDocumentoCollection }

  TObterDFeDocumentoCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TObterDFeDocumento;
  public
    function New: TObterDFeDocumento;
    property Items[Index: Integer]: TObterDFeDocumento read GetItem; default;
  end;

  { TObterDFeProcEventoCollection }

  TObterDFeProcEventoCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TObterDFeProcItem;
    procedure SetItem(Index: Integer; Value: TObterDFeProcItem);
  public
    function New: TObterDFeProcItem;
    property Items[Index: Integer]: TObterDFeProcItem read GetItem write SetItem; default;
  end;

  { TRetObterDFe }

  TRetObterDFe = class(TObject)
  private
    Fversao: string;
    FtpAmb: TACBrTipoAmbiente;
    FverAplic: string;
    FdhReq: TDateTime;
    FcStat: Integer;
    FxMotivo: string;
    FXmlRetorno: string;
    FchNFCe: TStringList;
    FdhEmisUltNfce: TDateTime;
    FnfeProc: TObterDFeProcItem;
    FprocEventoNFe: TObterDFeProcEventoCollection;
    FDocumentos: TObterDFeDocumentoCollection;

    function GetListaIncompleta: Boolean;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Clear;
    function LerXml: Boolean;

    property versao: string            read Fversao   write Fversao;
    property tpAmb: TACBrTipoAmbiente  read FtpAmb    write FtpAmb;
    property verAplic: string          read FverAplic write FverAplic;
    property dhReq: TDateTime          read FdhReq    write FdhReq;
    property cStat: Integer            read FcStat    write FcStat;
    property xMotivo: string           read FxMotivo  write FxMotivo;
    property chNFCe: TStringList       read FchNFCe;
    property dhEmisUltNfce: TDateTime  read FdhEmisUltNfce write FdhEmisUltNfce;
    property ListaIncompleta: Boolean  read GetListaIncompleta;
    property nfeProc: TObterDFeProcItem read FnfeProc;
    property procEventoNFe: TObterDFeProcEventoCollection read FprocEventoNFe;
    property Documentos: TObterDFeDocumentoCollection read FDocumentos;

    property XmlRetorno: string read FXmlRetorno write FXmlRetorno;
  end;

implementation

uses
  ACBrXmlDocument,
  ACBrDFeUtil,
  ACBrUtil.Compatibilidade,
  ACBrUtil.Strings,
  ACBrUtil.XMLHTML;

const
  CNamespaceNFe = 'http://www.portalfiscal.inf.br/nfe';

function GarantirNamespace(const AXML: string): string;
var
  P, F: Integer;
begin
  Result := AXML;
  if Result = '' then Exit;

  F := Pos('>', Result);
  if (F = 0) or (Pos('xmlns', Copy(Result, 1, F)) > 0) then Exit;

  P := 2;
  while (P <= F) and not CharInSet(Result[P], [' ', '>', '/', #9, #10, #13]) do
    Inc(P);

  Insert(' xmlns="' + CNamespaceNFe + '"', Result, P);
end;

function ExtrairBloco(const AXML, ATag: string; var APos: Integer): string;
var
  LIni, LFim, LP: Integer;
  LAbre, LFecha: string;
begin
  Result := '';
  LAbre := '<' + ATag;
  LFecha := '</' + ATag + '>';
  LP := APos;

  repeat
    LIni := PosEx(LAbre, AXML, LP);
    if LIni = 0 then Exit;

    LFim := LIni + Length(LAbre);
    if (LFim <= Length(AXML)) and CharInSet(AXML[LFim], [' ', '>', '/', #9, #10, #13]) then
      Break;

    LP := LIni + 1;
  until False;

  LFim := PosEx(LFecha, AXML, LIni);
  if LFim = 0 then Exit;

  Inc(LFim, Length(LFecha));
  Result := Copy(AXML, LIni, LFim - LIni);
  APos := LFim;
end;

{ TObterDFeProcItem }

procedure TObterDFeProcItem.Clear;
begin
  Fversao := '';
  FdhInc := 0;
  FnProt := '';
  FXML := '';
  FXMLDFe := '';
  FId := '';
  FChave := '';
  FCNPJCPF := '';
  FxNome := '';
  FIE := '';
  FdhDoc := 0;
  FtpEvento := teNaoMapeado;
  FNomeArq := '';
end;

{ TObterDFeDocumentoCollection }

function TObterDFeDocumentoCollection.GetItem(Index: Integer): TObterDFeDocumento;
begin
  Result := TObterDFeDocumento(inherited Items[Index]);
end;

function TObterDFeDocumentoCollection.New: TObterDFeDocumento;
begin
  Result := TObterDFeDocumento.Create;
  Result.FtpEvento := teNaoMapeado;
  Self.Add(Result);
end;

{ TObterDFeProcEventoCollection }

function TObterDFeProcEventoCollection.GetItem(Index: Integer): TObterDFeProcItem;
begin
  Result := TObterDFeProcItem(inherited Items[Index]);
end;

procedure TObterDFeProcEventoCollection.SetItem(Index: Integer;
  Value: TObterDFeProcItem);
begin
  inherited Items[Index] := Value;
end;

function TObterDFeProcEventoCollection.New: TObterDFeProcItem;
begin
  Result := TObterDFeProcItem.Create;
  Self.Add(Result);
end;

{ TRetObterDFe }

constructor TRetObterDFe.Create;
begin
  inherited Create;

  FchNFCe := TStringList.Create;
  FnfeProc := TObterDFeProcItem.Create;
  FprocEventoNFe := TObterDFeProcEventoCollection.Create;
  FDocumentos := TObterDFeDocumentoCollection.Create;

  Clear;
end;

destructor TRetObterDFe.Destroy;
begin
  FchNFCe.Free;
  FnfeProc.Free;
  FprocEventoNFe.Free;
  FDocumentos.Free;

  inherited Destroy;
end;

procedure TRetObterDFe.Clear;
begin
  Fversao := '';
  FtpAmb := taHomologacao;
  FverAplic := '';
  FdhReq := 0;
  FcStat := 0;
  FxMotivo := '';
  FXmlRetorno := '';
  FdhEmisUltNfce := 0;

  FchNFCe.Clear;
  FnfeProc.Clear;
  FprocEventoNFe.Clear;
  FDocumentos.Clear;
end;

function TRetObterDFe.GetListaIncompleta: Boolean;
begin
  Result := (FcStat = 101);
end;

function TRetObterDFe.LerXml: Boolean;
var
  Document: TACBrXmlDocument;
  ANode, AProc, ANfeProc: TACBrXmlNode;
  ANodes: TACBrXmlNodeArray;
  I, LPosProc: Integer;
  xChave, LProcRaw: string;
  LDoc: TObterDFeDocumento;

  procedure LerDadosNFe(AItem: TObterDFeProcItem; ANFe: TACBrXmlNode);
  var
    AInf, AEmit, AIde: TACBrXmlNode;
  begin
    AInf := ANFe.Childrens.FindAnyNs('infNFe');
    if AInf = nil then Exit;

    AItem.Id := ObterConteudoTag(AInf.Attributes.Items['Id']);
    AItem.Chave := RemoverLiteralChave(AItem.Id);

    AEmit := AInf.Childrens.FindAnyNs('emit');
    if AEmit <> nil then
    begin
      AItem.CNPJCPF := ObterConteudoTag(AEmit.Childrens.FindAnyNs('CNPJ'), tcStr);
      if AItem.CNPJCPF = '' then
        AItem.CNPJCPF := ObterConteudoTag(AEmit.Childrens.FindAnyNs('CPF'), tcStr);

      AItem.xNome := ObterConteudoTag(AEmit.Childrens.FindAnyNs('xNome'), tcStr);
      AItem.IE := ObterConteudoTag(AEmit.Childrens.FindAnyNs('IE'), tcStr);
    end;

    AIde := AInf.Childrens.FindAnyNs('ide');
    if AIde <> nil then
      AItem.dhDoc := ObterConteudoTag(AIde.Childrens.FindAnyNs('dhEmi'), tcDatHor);
  end;

  procedure LerDadosEvento(AItem: TObterDFeProcItem; AEvento: TACBrXmlNode);
  var
    AInf: TACBrXmlNode;
    Ok: Boolean;
  begin
    AInf := AEvento.Childrens.FindAnyNs('infEvento');
    if AInf = nil then Exit;

    AItem.Id := ObterConteudoTag(AInf.Attributes.Items['Id']);
    AItem.Chave := ObterConteudoTag(AInf.Childrens.FindAnyNs('chNFe'), tcStr);
    AItem.CNPJCPF := ObterConteudoTag(AInf.Childrens.FindAnyNs('CNPJ'), tcStr);
    if AItem.CNPJCPF = '' then
      AItem.CNPJCPF := ObterConteudoTag(AInf.Childrens.FindAnyNs('CPF'), tcStr);

    AItem.dhDoc := ObterConteudoTag(AInf.Childrens.FindAnyNs('dhEvento'), tcDatHor);
    AItem.tpEvento := StrToTpEventoDFe(Ok,
      ObterConteudoTag(AInf.Childrens.FindAnyNs('tpEvento'), tcStr), 'NFe');
  end;

  procedure LerProcItem(AItem: TObterDFeProcItem; ANodeProc: TACBrXmlNode;
    const ATagDFe, AProcRaw: string);
  var
    ADFe: TACBrXmlNode;
    LPos: Integer;
    LRaw: string;
  begin
    AItem.versao := ObterConteudoTag(ANodeProc.Attributes.Items['versao']);
    AItem.dhInc := ObterConteudoTag(ANodeProc.Childrens.FindAnyNs('dhInc'), tcDatHor);
    AItem.nProt := ObterConteudoTag(ANodeProc.Childrens.FindAnyNs('nProt'), tcStr);

    if AProcRaw <> '' then
      AItem.XML := AProcRaw
    else
      AItem.XML := ANodeProc.OuterXml;

    LPos := 1;
    LRaw := ExtrairBloco(AProcRaw, ATagDFe, LPos);

    ADFe := ANodeProc.Childrens.FindAnyNs(ATagDFe);
    if ADFe <> nil then
    begin
      if LRaw <> '' then
        AItem.XMLDFe := GarantirNamespace(LRaw)
      else
        AItem.XMLDFe := GarantirNamespace(ADFe.OuterXml);

      if ATagDFe = 'NFe' then
        LerDadosNFe(AItem, ADFe)
      else
        LerDadosEvento(AItem, ADFe);
    end;
  end;

begin
  Result := False;
  if Trim(FXmlRetorno) = '' then Exit;

  Document := TACBrXmlDocument.Create;
  try
    try
      Document.LoadFromXml(FXmlRetorno);

      ANode := Document.Root;
      if ANode = nil then Exit;

      Fversao := ObterConteudoTag(ANode.Attributes.Items['versao']);
      FtpAmb := StrToTipoAmbiente(ObterConteudoTag(ANode.Childrens.FindAnyNs('tpAmb'), tcStr));
      FverAplic := ObterConteudoTag(ANode.Childrens.FindAnyNs('verAplic'), tcStr);
      FdhReq := ObterConteudoTag(ANode.Childrens.FindAnyNs('dhReq'), tcDatHor);
      FcStat := ObterConteudoTag(ANode.Childrens.FindAnyNs('cStat'), tcInt);
      FxMotivo := ObterConteudoTag(ANode.Childrens.FindAnyNs('xMotivo'), tcStr);

      FchNFCe.Clear;
      ANodes := ANode.Childrens.FindAllAnyNs('chNFCe');
      for I := 0 to Length(ANodes) - 1 do
      begin
        xChave := Trim(ANodes[I].Content);
        if xChave <> '' then
          FchNFCe.Add(xChave);
      end;
      FdhEmisUltNfce := ObterConteudoTag(ANode.Childrens.FindAnyNs('dhEmisUltNfce'), tcDatHor);

      FnfeProc.Clear;
      FprocEventoNFe.Clear;
      FDocumentos.Clear;
      AProc := ANode.Childrens.FindAnyNs('proc');
      if AProc <> nil then
      begin
        LPosProc := 1;
        ANfeProc := AProc.Childrens.FindAnyNs('nfeProc');
        if ANfeProc <> nil then
        begin
          LProcRaw := ExtrairBloco(FXmlRetorno, 'nfeProc', LPosProc);
          LerProcItem(FnfeProc, ANfeProc, 'NFe', LProcRaw);

          if FnfeProc.XMLDFe <> '' then
          begin
            LDoc := FDocumentos.New;
            LDoc.Tipo := tdNFCe;
            LDoc.Chave := FnfeProc.Chave;
            LDoc.Id := FnfeProc.Id;
            LDoc.dhDoc := FnfeProc.dhDoc;
            LDoc.versao := FnfeProc.versao;
            LDoc.dhInc := FnfeProc.dhInc;
            LDoc.nProt := FnfeProc.nProt;
            LDoc.XML := FnfeProc.XMLDFe;
            LDoc.Origem := FnfeProc;
          end;
        end;

        LPosProc := 1;
        ANodes := AProc.Childrens.FindAllAnyNs('procEventoNFe');
        for I := 0 to Length(ANodes) - 1 do
        begin
          LProcRaw := ExtrairBloco(FXmlRetorno, 'procEventoNFe', LPosProc);
          LerProcItem(FprocEventoNFe.New, ANodes[I], 'evento', LProcRaw);

          with FprocEventoNFe[FprocEventoNFe.Count - 1] do
            if XMLDFe <> '' then
            begin
              LDoc := FDocumentos.New;
              LDoc.Tipo := tdEvento;
              LDoc.Chave := Chave;
              LDoc.Id := Id;
              LDoc.tpEvento := tpEvento;
              LDoc.dhDoc := dhDoc;
              LDoc.versao := versao;
              LDoc.dhInc := dhInc;
              LDoc.nProt := nProt;
              LDoc.XML := XMLDFe;
              LDoc.Origem := FprocEventoNFe[FprocEventoNFe.Count - 1];
            end;
        end;
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
