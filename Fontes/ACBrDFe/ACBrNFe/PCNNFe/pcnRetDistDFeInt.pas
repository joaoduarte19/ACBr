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
{$IFNDEF VER130}
  Variants,
{$ENDIF}
  pcnAuxiliar, pcnConversao, pcnLeitor;

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
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property NSU: String           read FNSU       write FNSU;
    property schema: String        read Fschema    write Fschema;
    property InfZip: String        read FInfZip    write FInfZip;
    property resNFe: TresNFe       read FresNFe    write FresNFe;
    property resEvento: TresEvento read FresEvento write FresEvento;
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
  xDocZip: String;
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
      xDocZip := Leitor.rExtrai(2, 'docZip', '', i + 1);

//      while Leitor.rExtrai(2, 'docZip', '', i + 1) <> '' do
      while xDocZip <> '' do
      begin
        FdocZip.Add;
        FdocZip.Items[i].FNSU    := Leitor.rAtributo('NSU');
        FdocZip.Items[i].schema  := Leitor.rAtributo('schema');

//        FdocZip.Items[i].FInfZip := Leitor.rCampo(tcStr, 'docZip');
        FdocZip.Items[i].FInfZip := Copy(xDocZip, Pos('>', xDocZip) + 1, Length(xDocZip));

        //**********************************************************************
        //
        // É preciso implementar a partir deste ponto uma chamada para
        // Descompactar o conteudo de FInfZip.
        //
        //**********************************************************************

        if (Leitor.rExtrai(3, 'resNFe') <> '') then
        begin
          FdocZip.Items[i].FresNFe.chNFe    := Leitor.rCampo(tcStr, 'chNFe');
          FdocZip.Items[i].FresNFe.FCNPJCPF := Leitor.rCampo(tcStr, 'CNPJ');

          if FdocZip.Items[i].FresNFe.FCNPJCPF = '' then
            FdocZip.Items[i].FresNFe.FCNPJCPF := Leitor.rCampo(tcStr, 'CPF');

          FdocZip.Items[i].FresNFe.FxNome    := Leitor.rCampo(tcStr, 'xNome');
          FdocZip.Items[i].FresNFe.FIE       := Leitor.rCampo(tcStr, 'IE');
          FdocZip.Items[i].FresNFe.FdhEmi    := Leitor.rCampo(tcDatHor, 'dhEmi');
          FdocZip.Items[i].FresNFe.FtpNF     := StrToTpNF(ok, Leitor.rCampo(tcStr, 'tpNF'));
          FdocZip.Items[i].FresNFe.FvNF      := Leitor.rCampo(tcDe2, 'vNF');
          FdocZip.Items[i].FresNFe.FdigVal   := Leitor.rCampo(tcStr, 'digVal');
          FdocZip.Items[i].FresNFe.FdhRecbto := Leitor.rCampo(tcDatHor, 'dhRecbto');
          FdocZip.Items[i].FresNFe.FnProt    := Leitor.rCampo(tcStr, 'nProt');
          FdocZip.Items[i].FresNFe.FcSitNFe  := StrToSituacaoNFe(ok, Leitor.rCampo(tcStr, 'cSitNFe'));
        end;

        if (Leitor.rExtrai(3, 'resEvento') <> '') then
        begin
          FdocZip.Items[i].FresEvento.FcOrgao  := Leitor.rCampo(tcInt, 'cOrgao');
          FdocZip.Items[i].FresEvento.FCNPJCPF := Leitor.rCampo(tcStr, 'CNPJ');

          if FdocZip.Items[i].FresEvento.FCNPJCPF = '' then
            FdocZip.Items[i].FresEvento.FCNPJCPF := Leitor.rCampo(tcStr, 'CPF');

          FdocZip.Items[i].FresEvento.chNFe       := Leitor.rCampo(tcStr, 'chNFe');
          FdocZip.Items[i].FresEvento.FdhEvento   := Leitor.rCampo(tcDatHor, 'dhEvento');
          FdocZip.Items[i].FresEvento.FtpEvento   := StrToTpEvento(ok, Leitor.rCampo(tcStr, 'tpEvento'));
          FdocZip.Items[i].FresEvento.FnSeqEvento := Leitor.rCampo(tcInt, 'nSeqEvento');
          FdocZip.Items[i].FresEvento.FxEvento    := Leitor.rCampo(tcStr, 'xEvento');
          FdocZip.Items[i].FresEvento.FdhRecbto   := Leitor.rCampo(tcDatHor, 'dhRecbto');
          FdocZip.Items[i].FresEvento.FnProt      := Leitor.rCampo(tcStr, 'nProt');
        end;

        inc(i);
        xDocZip := Leitor.rExtrai(2, 'docZip', '', i + 1);
      end;

      if i = 0
       then FdocZip.Add;

      Result := True;
    end;
  except
    result := False;
  end;
end;

end.
