////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//              PCN - Projeto Cooperar NFe                                    //
//                                                                            //
//   Descrição: Classes para geração/leitura dos arquivos xml da NFe          //
//                                                                            //
//        site: www.projetocooperar.org                                       //
//       email: projetocooperar@zipmail.com.br                                //
//       forum: http://br.groups.yahoo.com/group/projeto_cooperar_nfe/        //
//     projeto: http://code.google.com/p/projetocooperar/                     //
//         svn: http://projetocooperar.googlecode.com/svn/trunk/              //
//                                                                            //
// Coordenação: (c) 2009 - Paulo Casagrande                                   //
//                                                                            //
//      Equipe: Vide o arquivo leiame.txt na pasta raiz do projeto            //
//                                                                            //
//      Versão: Vide o arquivo leiame.txt na pasta raiz do projeto            //
//                                                                            //
//     Licença: GNU Lesser General Public License (GNU LGPL)                  //
//                                                                            //
//              - Este programa é software livre; você pode redistribuí-lo    //
//              e/ou modificá-lo sob os termos da Licença Pública Geral GNU,  //
//              conforme publicada pela Free Software Foundation; tanto a     //
//              versão 2 da Licença como (a seu critério) qualquer versão     //
//              mais nova.                                                    //
//                                                                            //
//              - Este programa é distribuído na expectativa de ser útil,     //
//              mas SEM QUALQUER GARANTIA; sem mesmo a garantia implícita de  //
//              COMERCIALIZAÇÃO ou de ADEQUAÇÃO A QUALQUER PROPÓSITO EM       //
//              PARTICULAR. Consulte a Licença Pública Geral GNU para obter   //
//              mais detalhes. Você deve ter recebido uma cópia da Licença    //
//              Pública Geral GNU junto com este programa; se não, escreva    //
//              para a Free Software Foundation, Inc., 59 Temple Place,       //
//              Suite 330, Boston, MA - 02111-1307, USA ou consulte a         //
//              licença oficial em http://www.gnu.org/licenses/gpl.txt        //
//                                                                            //
//    Nota (1): - Esta  licença  não  concede  o  direito  de  uso  do nome   //
//              "PCN  -  Projeto  Cooperar  NFe", não  podendo o mesmo ser    //
//              utilizado sem previa autorização.                             //
//                                                                            //
//    Nota (2): - O uso integral (ou parcial) das units do projeto esta       //
//              condicionado a manutenção deste cabeçalho junto ao código     //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

{$I ACBr.inc}

unit pcnRetDistDFeInt;

interface

uses
  SysUtils, Classes,
  pcnConversao, pcnConversaoNFe, pcnLeitor, synacode;

type
  TresNFe               = class;
  TresEvento            = class;
  TdocZipCollection     = class;
  TdocZipCollectionItem = class;
  TRetDistDFeInt        = class;

  TresNFe = class
  private
    FchNFe: String;
    FCNPJCPF: String;
    FxNome: String;
    FIE: String;
    FdhEmi: TDateTime;
    FtpNF: TpcnTipoNFe;
    FvNF: Double;
    FdigVal: String;
    FdhRecbto: TDateTime;
    FnProt: String;
    FcSitNFe: TpcnSituacaoNFe;
  public
    property chNFe: String            read FchNFe    write FchNFe;
    property CNPJCPF: String          read FCNPJCPF  write FCNPJCPF;
    property xNome: String            read FxNome    write FxNome;
    property IE: String               read FIE       write FIE;
    property dhEmi: TDateTime         read FdhEmi    write FdhEmi;
    property tpNF: TpcnTipoNFe        read FtpNF     write FtpNF;
    property vNF: Double              read FvNF      write FvNF;
    property digVal: String           read FdigVal   write FdigVal;
    property dhRecbto: TDateTime      read FdhRecbto write FdhRecbto;
    property nProt: String            read FnProt    write FnProt;
    property cSitNFe: TpcnSituacaoNFe read FcSitNFe  write FcSitNFe;
  end;

  TresEvento = class
  private
    FcOrgao: Integer;
    FCNPJCPF: String;
    FchNFe: String;
    FdhEvento: TDateTime;
    FtpEvento: TpcnTpEvento;
    FnSeqEvento: ShortInt;
    FxEvento: String;
    FdhRecbto: TDateTime;
    FnProt: String;
  public
    property cOrgao: Integer        read FcOrgao     write FcOrgao;
    property CNPJCPF: String        read FCNPJCPF    write FCNPJCPF;
    property chNFe: String          read FchNFe      write FchNFe;
    property dhEvento: TDateTime    read FdhEvento   write FdhEvento;
    property tpEvento: TpcnTpEvento read FtpEvento   write FtpEvento;
    property nSeqEvento: ShortInt   read FnSeqEvento write FnSeqEvento;
    property xEvento: String        read FxEvento    write FxEvento;
    property dhRecbto: TDateTime    read FdhRecbto   write FdhRecbto;
    property nProt: String          read FnProt      write FnProt;
  end;

  TdocZipCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TdocZipCollectionItem;
    procedure SetItem(Index: Integer; Value: TdocZipCollectionItem);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TdocZipCollectionItem;
    property Items[Index: Integer]: TdocZipCollectionItem read GetItem write SetItem; default;
  end;

  TdocZipCollectionItem = class(TCollectionItem)
  private
    // Atributos do resumo da NFe ou Evento
    FNSU: String;
    Fschema: String;
    // A propriedade InfZip contem a informação Resumida ou documento fiscal
    // eletrônico Compactado no padrão gZip
    FInfZip: String;
    // Resumos Descompactados
    FresNFe: TresNFe;
    FresEvento: TresEvento;
    // XML do Resumo ou Documento descompactado
    FXML: String;

  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property NSU: String           read FNSU       write FNSU;
    property schema: String        read Fschema    write Fschema;
    property InfZip: String        read FInfZip    write FInfZip;
    property resNFe: TresNFe       read FresNFe    write FresNFe;
    property resEvento: TresEvento read FresEvento write FresEvento;
    property XML: String           read FXML       write FXML;
  end;

  TRetDistDFeInt = class(TPersistent)
  private
    FLeitor: TLeitor;
    Fversao: String;
    FtpAmb: TpcnTipoAmbiente;
    FverAplic: String;
    FcStat: Integer;
    FxMotivo: String;
    FdhResp: TDateTime;
    FultNSU: String;
    FmaxNSU: String;
    FXML: AnsiString;
    FdocZip: TdocZipCollection;

    procedure SetdocZip(const Value: TdocZipCollection);
  public
    constructor Create;
    destructor Destroy; override;
    function LerXml: boolean;
    function LerXMLFromFile(CaminhoArquivo: String): Boolean;
  published
    property Leitor: TLeitor           read FLeitor   write FLeitor;
    property versao: String            read Fversao   write Fversao;
    property tpAmb: TpcnTipoAmbiente   read FtpAmb    write FtpAmb;
    property verAplic: String          read FverAplic write FverAplic;
    property cStat: Integer            read FcStat    write FcStat;
    property xMotivo: String           read FxMotivo  write FxMotivo;
    property dhResp: TDateTime         read FdhResp   write FdhResp;
    property ultNSU: String            read FultNSU   write FultNSU;
    property maxNSU: String            read FmaxNSU   write FmaxNSU;
    property docZip: TdocZipCollection read FdocZip   write SetdocZip;
    property XML: AnsiString           read FXML      write FXML;
  end;

implementation

Uses Math,
  pcnAuxiliar, pcnNFeR
  {$IFDEF FPC},zstream {$ELSE},ZLibExGZ{$ENDIF};

{ TdocZipCollection }

function TdocZipCollection.Add: TdocZipCollectionItem;
begin
  Result := TdocZipCollectionItem(inherited Add);
  Result.create;
end;

constructor TdocZipCollection.Create(AOwner: TPersistent);
begin
  inherited Create(TdocZipCollectionItem);
end;

function TdocZipCollection.GetItem(Index: Integer): TdocZipCollectionItem;
begin
  Result := TdocZipCollectionItem(inherited GetItem(Index));
end;

procedure TdocZipCollection.SetItem(Index: Integer;
  Value: TdocZipCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{ TdocZipCollectionItem }

constructor TdocZipCollectionItem.Create;
begin
  FresNFe    := TresNFe.Create;
  FresEvento := TresEvento.Create;
end;

destructor TdocZipCollectionItem.Destroy;
begin
  FresNFe.Free;
  FresEvento.Free;
  inherited;
end;

{ TRetDistDFeInt }

constructor TRetDistDFeInt.Create;
begin
  FLeitor := TLeitor.Create;
  FdocZip := TdocZipCollection.Create(Self);
end;

destructor TRetDistDFeInt.Destroy;
begin
  FLeitor.Free;
  FdocZip.Free;
  inherited;
end;

procedure TRetDistDFeInt.SetdocZip(const Value: TdocZipCollection);
begin
  FdocZip := Value;
end;

function TRetDistDFeInt.LerXml: boolean;
var
  ok: boolean;
  i: Integer;
  StrStream: TStringStream;
  StrAux, StrDecod: String;
  oLeitorInfZip: TLeitor;
  XMLNFe: String;

  {$IFDEF FPC}
  { Descompacta um arquivo padrão GZIP de Stream... Fontes:
    http://wiki.freepascal.org/paszlib
    http://www.gocher.me/GZIP
  }
  function UnZipMsg(S: TStringStream): String;
  var
    DS: TDecompressionStream;
    MS: TMemoryStream;
    readCount: integer;
    Buf: array[0..1023] of byte;
    hdr: longword;
  begin
    S.Position := 0; // goto start of input stream
    hdr := S.ReadDWord;
    if (hdr and $00088B1F) = $00088B1F then // gzip header (deflate method)
      S.Position := 10     // Pula cabeçalho gzip
    else if (hdr and $00009C78) = $00009C78 then // zlib header
      S.Position := 2      // Pula cabeçalho zlib
    else
      S.Position := 0;

    MS := TMemoryStream.Create;
    DS := Tdecompressionstream.Create(S, (S.Position > 0) );
    try
      repeat
        readCount := DS.Read(Buf, SizeOf(Buf));
        if readCount <> 0 then
          MS.Write(Buf, readCount);
      until readCount < SizeOf(Buf);

      MS.Position := 0;
      Result := '';
      SetLength(Result, MS.Size);
      MS.ReadBuffer(Result[1], MS.Size);
    finally
      DS.Free;
      MS.Free;
    end;
  end;
  {$ELSE}
  function UnZipMsg(S: TStringStream): String;
  begin
    Result := GZDecompressStr(S.DataString);
  end;
  {$ENDIF}

begin
  Result := False;

  try
    FXML := Self.Leitor.Arquivo;

    if (Leitor.rExtrai(1, 'retDistDFeInt') <> '') then
    begin
      Fversao   := Leitor.rAtributo('versao');
      FtpAmb    := StrToTpAmb(ok, Leitor.rCampo(tcStr, 'tpAmb'));
      FverAplic := Leitor.rCampo(tcStr, 'verAplic');
      FcStat    := Leitor.rCampo(tcInt, 'cStat');
      FxMotivo  := Leitor.rCampo(tcStr, 'xMotivo');
      FdhResp   := Leitor.rCampo(tcDatHor, 'dhResp');
      FultNSU   := Leitor.rCampo(tcStr, 'ultNSU');
      FmaxNSU   := Leitor.rCampo(tcStr, 'maxNSU');

      i := 0;
      while Leitor.rExtrai(2, 'docZip', '', i + 1) <> '' do
      begin
        FdocZip.Add;
        FdocZip.Items[i].FNSU    := Leitor.rAtributo('NSU');
        FdocZip.Items[i].schema  := Leitor.rAtributo('schema');

        StrStream := TStringStream.Create('');

        try
          try
            StrAux := RetornarConteudoEntre(Leitor.Grupo, '>', '</docZip');

            StrDecod := DecodeBase64(StrAux);

            // Incluido por Italo em 21/01/2015
            StrStream.WriteString(StrDecod);

            FdocZip.Items[i].FInfZip := UnZipMsg(StrStream);
          except
            on e : Exception do
            begin
              Raise Exception.Create(e.message);
            end;
          end;
        finally
          FreeAndNil(StrStream);
        end;

        oLeitorInfZip := TLeitor.Create;

        oLeitorInfZip.Arquivo := FdocZip.Items[i].FInfZip;

        if (oLeitorInfZip.rExtrai(1, 'resNFe') <> '') then
        begin
          // Incluido Por Italo em 22/01/2015
          FdocZip.Items[i].XML := oLeitorInfZip.Grupo;

          FdocZip.Items[i].FresNFe.chNFe    := oLeitorInfZip.rCampo(tcStr, 'chNFe');
          FdocZip.Items[i].FresNFe.FCNPJCPF := oLeitorInfZip.rCampo(tcStr, 'CNPJ');

          if FdocZip.Items[i].FresNFe.FCNPJCPF = '' then
            FdocZip.Items[i].FresNFe.FCNPJCPF := oLeitorInfZip.rCampo(tcStr, 'CPF');

          FdocZip.Items[i].FresNFe.FxNome    := oLeitorInfZip.rCampo(tcStr, 'xNome');
          FdocZip.Items[i].FresNFe.FIE       := oLeitorInfZip.rCampo(tcStr, 'IE');
          FdocZip.Items[i].FresNFe.FdhEmi    := oLeitorInfZip.rCampo(tcDatHor, 'dhEmi');
          FdocZip.Items[i].FresNFe.FtpNF     := StrToTpNF(ok, oLeitorInfZip.rCampo(tcStr, 'tpNF'));
          FdocZip.Items[i].FresNFe.FvNF      := oLeitorInfZip.rCampo(tcDe2, 'vNF');
          FdocZip.Items[i].FresNFe.FdigVal   := oLeitorInfZip.rCampo(tcStr, 'digVal');
          FdocZip.Items[i].FresNFe.FdhRecbto := oLeitorInfZip.rCampo(tcDatHor, 'dhRecbto');
          FdocZip.Items[i].FresNFe.FnProt    := oLeitorInfZip.rCampo(tcStr, 'nProt');
          FdocZip.Items[i].FresNFe.FcSitNFe  := StrToSituacaoNFe(ok, oLeitorInfZip.rCampo(tcStr, 'cSitNFe'));
        end;

        if (oLeitorInfZip.rExtrai(1, 'resEvento') <> '') then
        begin
          // Incluido Por Italo em 22/01/2015
          FdocZip.Items[i].XML := oLeitorInfZip.Grupo;

          FdocZip.Items[i].FresEvento.FcOrgao  := oLeitorInfZip.rCampo(tcInt, 'cOrgao');
          FdocZip.Items[i].FresEvento.FCNPJCPF := oLeitorInfZip.rCampo(tcStr, 'CNPJ');

          if FdocZip.Items[i].FresEvento.FCNPJCPF = '' then
            FdocZip.Items[i].FresEvento.FCNPJCPF := oLeitorInfZip.rCampo(tcStr, 'CPF');

          FdocZip.Items[i].FresEvento.chNFe       := oLeitorInfZip.rCampo(tcStr, 'chNFe');
          FdocZip.Items[i].FresEvento.FdhEvento   := oLeitorInfZip.rCampo(tcDatHor, 'dhEvento');
          FdocZip.Items[i].FresEvento.FtpEvento   := StrToTpEvento(ok, oLeitorInfZip.rCampo(tcStr, 'tpEvento'));
          FdocZip.Items[i].FresEvento.FnSeqEvento := oLeitorInfZip.rCampo(tcInt, 'nSeqEvento');
          FdocZip.Items[i].FresEvento.FxEvento    := oLeitorInfZip.rCampo(tcStr, 'xEvento');
          FdocZip.Items[i].FresEvento.FdhRecbto   := oLeitorInfZip.rCampo(tcDatHor, 'dhRecbto');
          FdocZip.Items[i].FresEvento.FnProt      := oLeitorInfZip.rCampo(tcStr, 'nProt');
        end;

        if (oLeitorInfZip.rExtrai(1, 'nfeProc') <> '') then
        begin
          // Incluido Por Italo em 22/01/2015
          FdocZip.Items[i].XML := oLeitorInfZip.Grupo;

          oLeitorInfZip.rExtrai(1, 'infNFe');
          FdocZip.Items[i].FresNFe.chNFe := copy(oLeitorInfZip.Grupo, pos('Id="NFe', oLeitorInfZip.Grupo)+7, 44);

          oLeitorInfZip.rExtrai(1, 'emit');
          FdocZip.Items[i].FresNFe.FCNPJCPF := oLeitorInfZip.rCampo(tcStr, 'CNPJ');
          if FdocZip.Items[i].FresNFe.FCNPJCPF = '' then
            FdocZip.Items[i].FresNFe.FCNPJCPF := oLeitorInfZip.rCampo(tcStr, 'CPF');

          FdocZip.Items[i].FresNFe.FxNome := oLeitorInfZip.rCampo(tcStr, 'xNome');
          FdocZip.Items[i].FresNFe.FIE    := oLeitorInfZip.rCampo(tcStr, 'IE');

          oLeitorInfZip.rExtrai(1, 'ide');
          FdocZip.Items[i].FresNFe.FdhEmi := oLeitorInfZip.rCampo(tcDatHor, 'dhEmi');

          // Se for Versão 2.00 a data de emissão está em dEmi
          if FdocZip.Items[i].FresNFe.FdhEmi = 0 then
            FdocZip.Items[i].FresNFe.FdhEmi := oLeitorInfZip.rCampo(tcDat, 'dEmi');

          FdocZip.Items[i].FresNFe.FtpNF := StrToTpNF(ok, oLeitorInfZip.rCampo(tcStr, 'tpNF'));

          oLeitorInfZip.rExtrai(1, 'total');
          FdocZip.Items[i].FresNFe.FvNF := oLeitorInfZip.rCampo(tcDe2, 'vNF');

          oLeitorInfZip.rExtrai(1, 'infProt');
          FdocZip.Items[i].FresNFe.digVal    := oLeitorInfZip.rCampo(tcStr, 'digVal');
          FdocZip.Items[i].FresNFe.FdhRecbto := oLeitorInfZip.rCampo(tcDatHor, 'dhRecbto');
          FdocZip.Items[i].FresNFe.FnProt    := oLeitorInfZip.rCampo(tcStr, 'nProt');

          case oLeitorInfZip.rCampo(tcInt, 'cStat') of
            100: FdocZip.Items[i].FresNFe.FcSitNFe := snAutorizado;
            101: FdocZip.Items[i].FresNFe.FcSitNFe := snCancelada;
            110: FdocZip.Items[i].FresNFe.FcSitNFe := snDenegado;
          end;
        end;

        if (oLeitorInfZip.rExtrai(1, 'procEventoNFe') <> '') then
        begin
          FdocZip.Items[i].XML := oLeitorInfZip.Grupo;

          FdocZip.Items[i].FresEvento.chNFe    := oLeitorInfZip.rCampo(tcStr, 'chNFe');
          FdocZip.Items[i].FresEvento.FCNPJCPF := oLeitorInfZip.rCampo(tcStr, 'CNPJ');
          if FdocZip.Items[i].FresEvento.FCNPJCPF = '' then
            FdocZip.Items[i].FresEvento.FCNPJCPF := oLeitorInfZip.rCampo(tcStr, 'CPF');

          //FdocZip.Items[i].FresEvento.FxEvento  := oLeitorInfZip.rCampo(tcStr, 'xNome');
          //FdocZip.Items[i].FresEvento.FdhEvento := oLeitorInfZip.rCampo(tcDatHor, 'dhEmi');
          //FdocZip.Items[i].FresEvento.FdhRecbto := oLeitorInfZip.rCampo(tcDatHor, 'dhRecbto');
          FdocZip.Items[i].FresEvento.FnProt := oLeitorInfZip.rCampo(tcStr, 'nProt');
        end;

        FreeAndNil(oLeitorInfZip);
        inc(i);
      end;

      Result := True;
    end;
  except
    on e : Exception do
    begin
      result := False;
      Raise Exception.Create(e.Message);
    end;
  end;
end;

function TRetDistDFeInt.LerXMLFromFile(CaminhoArquivo: String): Boolean;
var
  ArqDist: TStringList;
begin
  ArqDist := TStringList.Create;
  try
     ArqDist.LoadFromFile(CaminhoArquivo);

     Self.Leitor.Arquivo := ArqDist.Text;

     Result := LerXml;
  finally
     ArqDist.Free;
  end;
end;

end.

