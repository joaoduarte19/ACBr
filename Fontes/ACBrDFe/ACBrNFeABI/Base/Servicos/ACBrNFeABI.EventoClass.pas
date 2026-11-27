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

unit ACBrNFeABI.EventoClass;

interface

uses
  SysUtils,
  Classes,
  {$IF DEFINED(HAS_SYSTEM_GENERICS)}
   System.Generics.Collections,
   System.Generics.Defaults,
  {$ELSEIF DEFINED(DELPHICOMPILER16_UP)}
   System.Contnrs,
  {$IFEND}
  ACBrBase,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrNFeABI.Conversao;

type
  EventoException = class(Exception);

  TgAdquirenteApropCollectionItem = class(TObject)
  private
    FCNPJCPF: string;
    FxNome: string;
    FpParticip: Double;
  public
    property CNPJCPF: string read FCNPJCPF write FCNPJCPF;
    property xNome: string read FxNome write FxNome;
    property pParticip: Double read FpParticip write FpParticip;
  end;

  TgAdquirenteApropCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TgAdquirenteApropCollectionItem;
    procedure SetItem(Index: Integer; Value: TgAdquirenteApropCollectionItem);
  public
    function New: TgAdquirenteApropCollectionItem;
    property Items[Index: Integer]: TgAdquirenteApropCollectionItem read GetItem write SetItem; default;
  end;

  TDetEvento = class
  private
    FVersao: string;
    FDescEvento: string;
    FnProt: string;        // Cancelamento
    FxJust: string;        // Cancelamento

    FidPedidoCancelado: string;
    FcdEventoPag, FCST, FcClassTrib: string;
    FvParcela, FvAcrescimos, FvTotalParcela, FvOrigParcela, FvAcrescParcela: Double;
    FdataPag: TDateTime;
    FvOperacIndiv, FvRedAjusteIndiv, FvRedSocialIndiv, FvBC: Double;
    FpIBSUF, FpRedAliqIBSUF, FpAliqEfetIBSUF, FvIBSUF: Double;
    FpIBSMun, FpRedAliqIBSMun, FpAliqEfetIBSMun, FvIBSMun: Double;
    FpCBS, FpRedAliqCBS, FpAliqEfetCBS, FvCBS: Double;
    Fadquirente: TgAdquirenteApropCollection;
    FtpDesfaz: TtpDesfaz;
    FdtDesfaz: TDateTime;
    FxDesfaz: string;
  public
    constructor Create;
    destructor Destroy; override;

    property versao: string     read FVersao     write FVersao;
    property descEvento: string read FDescEvento write FDescEvento;
    property nProt: string      read FnProt      write FnProt;
    property xJust: string      read FxJust      write FxJust;

    property idPedidoCancelado: string read FidPedidoCancelado write FidPedidoCancelado;

    procedure Assign(Source: TDetEvento);
    property cdEventoPag: string read FcdEventoPag write FcdEventoPag;   // 01 incorporacao / 02 complementar
    property vParcela: Double read FvParcela write FvParcela;
    property vAcrescimos: Double read FvAcrescimos write FvAcrescimos;
    property vTotalParcela: Double read FvTotalParcela write FvTotalParcela;
    property vOrigParcela: Double read FvOrigParcela write FvOrigParcela;
    property vAcrescParcela: Double read FvAcrescParcela write FvAcrescParcela;
    property dataPag: TDateTime read FdataPag write FdataPag;
    property CST: string read FCST write FCST;
    property cClassTrib: string read FcClassTrib write FcClassTrib;
    property vOperacIndiv: Double read FvOperacIndiv write FvOperacIndiv;
    property vRedAjusteIndiv: Double read FvRedAjusteIndiv write FvRedAjusteIndiv;
    property vRedSocialIndiv: Double read FvRedSocialIndiv write FvRedSocialIndiv;
    property vBC: Double read FvBC write FvBC;
    property pIBSUF: Double read FpIBSUF write FpIBSUF;
    property pRedAliqIBSUF: Double read FpRedAliqIBSUF write FpRedAliqIBSUF;
    property pAliqEfetIBSUF: Double read FpAliqEfetIBSUF write FpAliqEfetIBSUF;
    property vIBSUF: Double read FvIBSUF write FvIBSUF;
    property pIBSMun: Double read FpIBSMun write FpIBSMun;
    property pRedAliqIBSMun: Double read FpRedAliqIBSMun write FpRedAliqIBSMun;
    property pAliqEfetIBSMun: Double read FpAliqEfetIBSMun write FpAliqEfetIBSMun;
    property vIBSMun: Double read FvIBSMun write FvIBSMun;
    property pCBS: Double read FpCBS write FpCBS;
    property pRedAliqCBS: Double read FpRedAliqCBS write FpRedAliqCBS;
    property pAliqEfetCBS: Double read FpAliqEfetCBS write FpAliqEfetCBS;
    property vCBS: Double read FvCBS write FvCBS;
    property adquirente: TgAdquirenteApropCollection read Fadquirente write Fadquirente;
    property tpDesfaz: TtpDesfaz read FtpDesfaz write FtpDesfaz;
    property dtDesfaz: TDateTime read FdtDesfaz write FdtDesfaz;
    property xDesfaz: string read FxDesfaz write FxDesfaz;
  end;

  TInfEvento = class
  private
    FID: string;
    FtpAmbiente: TACBrTipoAmbiente;
//    FtpEmit: TEmitenteNFeABI;
    FCNPJCPF: string;
    FCNPJCPFEmit: string;
    FIdOutrosEmit: string;

    FcOrgao: Integer;
    FChave: string;
    FDataEvento: TDateTime;
    FTpEvento: TACBrTipoEvento;
    FnSeqEvento: Integer;
    FDetEvento: TDetEvento;

    function getcOrgao: Integer;
    function getDescEvento: string;
    function getTipoEvento: string;
  public
    constructor Create;
    destructor Destroy; override;

    function DescricaoTipoEvento(TipoEvento:TACBrTipoEvento): string;

    property id: string               read FID             write FID;
    property cOrgao: Integer          read getcOrgao       write FcOrgao;
    property tpAmb: TACBrTipoAmbiente read FtpAmbiente     write FtpAmbiente;
//    property tpEmit: TEmitenteNFeABI     read FtpEmit         write FtpEmit;
    property CNPJCPF: string          read FCNPJCPF        write FCNPJCPF;
    property CNPJCPFEmit: string      read FCNPJCPFEmit    write FCNPJCPFEmit;
    property IdOutrosEmit: string     read FIdOutrosEmit   write FIdOutrosEmit;

    property chNFeABI: string            read FChave          write FChave;
    property dhEvento: TDateTime      read FDataEvento     write FDataEvento;
    property tpEvento: TACBrTipoEvento read FTpEvento       write FTpEvento;
    property nSeqEvento: Integer      read FnSeqEvento     write FnSeqEvento;
    property detEvento: TDetEvento    read FDetEvento      write FDetEvento;
    property DescEvento: string       read getDescEvento;
    property TipoEvento: string       read getTipoEvento;
  end;

  { TRetInfEvento }

  TRetInfEvento = class(TObject)
  private
    FId: string;
    FNomeArquivo: string;
    FtpAmb: TACBrTipoAmbiente;
    FverAplic: string;
    FcOrgao: Integer;
    FcStat: Integer;
    FxMotivo: string;
    FchNFeABI: string;
    FtpEvento: TACBrTipoEvento;
    FxEvento: string;
    FnSeqEvento: Integer;
    FdhRegEvento: TDateTime;
    FnProt: string;
    FXML: AnsiString;
  public
    property Id: string               read FId          write FId;
    property tpAmb: TACBrTipoAmbiente read FtpAmb       write FtpAmb;
    property verAplic: string         read FverAplic    write FverAplic;
    property cOrgao: Integer          read FcOrgao      write FcOrgao;
    property cStat: Integer           read FcStat       write FcStat;
    property xMotivo: string          read FxMotivo     write FxMotivo;
    property chNFeABI: string            read FchNFeABI       write FchNFeABI;
    property tpEvento: TACBrTipoEvento read FtpEvento    write FtpEvento;
    property xEvento: string          read FxEvento     write FxEvento;
    property nSeqEvento: Integer      read FnSeqEvento  write FnSeqEvento;
    property dhRegEvento: TDateTime   read FdhRegEvento write FdhRegEvento;
    property nProt: string            read FnProt       write FnProt;
    property XML: Ansistring          read FXML         write FXML;
    property NomeArquivo: string      read FNomeArquivo write FNomeArquivo;
  end;

implementation

{ TgAdquirenteApropCollection }

function TgAdquirenteApropCollection.GetItem(Index: Integer): TgAdquirenteApropCollectionItem;
begin
  Result := TgAdquirenteApropCollectionItem(inherited Items[Index]);
end;

function TgAdquirenteApropCollection.New: TgAdquirenteApropCollectionItem;
begin
  Result := TgAdquirenteApropCollectionItem.Create;
  Self.Add(Result);
end;

procedure TgAdquirenteApropCollection.SetItem(Index: Integer; Value: TgAdquirenteApropCollectionItem);
begin
  inherited Items[Index] := Value;
end;

{ TDetEvento }

constructor TDetEvento.Create;
begin
  inherited Create;

  Fadquirente := TgAdquirenteApropCollection.Create;
end;

destructor TDetEvento.Destroy;
begin
  Fadquirente.Free;

  inherited;
end;

procedure TDetEvento.Assign(Source: TDetEvento);
var
  I: Integer;
begin
  FVersao := Source.FVersao;
  FDescEvento := Source.FDescEvento;
  FnProt := Source.FnProt;
  FxJust := Source.FxJust;
  FidPedidoCancelado := Source.FidPedidoCancelado;
  FcdEventoPag := Source.FcdEventoPag;
  FvParcela := Source.FvParcela;
  FvAcrescimos := Source.FvAcrescimos;
  FvTotalParcela := Source.FvTotalParcela;
  FvOrigParcela := Source.FvOrigParcela;
  FvAcrescParcela := Source.FvAcrescParcela;
  FdataPag := Source.FdataPag;
  FCST := Source.FCST;
  FcClassTrib := Source.FcClassTrib;
  FvOperacIndiv := Source.FvOperacIndiv;
  FvRedAjusteIndiv := Source.FvRedAjusteIndiv;
  FvRedSocialIndiv := Source.FvRedSocialIndiv;
  FvBC := Source.FvBC;
  FpIBSUF := Source.FpIBSUF;
  FpRedAliqIBSUF := Source.FpRedAliqIBSUF;
  FpAliqEfetIBSUF := Source.FpAliqEfetIBSUF;
  FvIBSUF := Source.FvIBSUF;
  FpIBSMun := Source.FpIBSMun;
  FpRedAliqIBSMun := Source.FpRedAliqIBSMun;
  FpAliqEfetIBSMun := Source.FpAliqEfetIBSMun;
  FvIBSMun := Source.FvIBSMun;
  FpCBS := Source.FpCBS;
  FpRedAliqCBS := Source.FpRedAliqCBS;
  FpAliqEfetCBS := Source.FpAliqEfetCBS;
  FvCBS := Source.FvCBS;

  Fadquirente.Clear;
  for I := 0 to Source.Fadquirente.Count - 1 do
    with Fadquirente.New do
    begin
      CNPJCPF := Source.Fadquirente[I].CNPJCPF;
      xNome := Source.Fadquirente[I].xNome;
      pParticip := Source.Fadquirente[I].pParticip;
    end;

  FtpDesfaz := Source.FtpDesfaz;
  FdtDesfaz := Source.FdtDesfaz;
  FxDesfaz := Source.FxDesfaz;
end;

{ TInfEvento }

constructor TInfEvento.Create;
begin
  inherited Create;

  FDetEvento := TDetEvento.Create();
end;

destructor TInfEvento.Destroy;
begin
  FDetEvento.Free;

  inherited;
end;

function TInfEvento.getcOrgao: Integer;
//  (AC,AL,AP,AM,BA,CE,DF,ES,GO,MA,MT,MS,MG,PA,PB,PR,PE,PI,RJ,RN,RS,RO,RR,SC,SP,SE,TO);
//  (12,27,16,13,29,23,53,32,52,21,51,50,31,15,25,41,26,22,33,24,43,11,14,42,35,28,17);
begin
  if FcOrgao <> 0 then
    Result := FcOrgao
  else
    Result := StrToIntDef(copy(FChave, 1, 2), 0);
end;

function TInfEvento.getDescEvento: string;
begin
  case fTpEvento of
    teCancelamento: Result := 'Cancelamento';
    tePagamentoOperacao: Result := 'Pagamento de Parcela';
    teApropCredIndNFeABI: Result := 'Apropriação de créditos individuais';
    teDesfazAlienacNFeABI: Result := 'Evento de Desfazimento da Alienação';
  else
    Result := '';
  end;
end;

function TInfEvento.getTipoEvento: string;
begin
  try
    // TEMPORARIO: 170110 e 190110 sao os codigos antigos do Pagamento de Parcela e da Apropriacao de Creditos
    // Individuais, que a Sefaz ainda aceita (os novos, 112310 e 211310, seguem sem funcionar)
    // Quando os novos eventos entrarem em vigor, remover os '170110', '190110'
    // Ajuste nos arquivos ACBrNFeABI.Conversao.pas e ACBrNFeABI.EventoClass.pas
    if FTpEvento = tePagamentoOperacao then
      Result := '112310'
    else if FTpEvento = teApropCredIndNFeABI then
      Result := '211310'
    else
      Result := TpEventoToStr( FTpEvento );
  except
    Result := '';
  end;
end;

function TInfEvento.DescricaoTipoEvento(TipoEvento: TACBrTipoEvento): string;
begin
  case TipoEvento of
    teCancelamento: Result := 'CANCELAMENTO DE DC-e';
    tePagamentoOperacao: Result := 'PAGAMENTO DE PARCELA';
    teApropCredIndNFeABI: Result := 'APROPRIAÇÃO DE CRÉDITOS INDIVIDUAIS';
    teDesfazAlienacNFeABI: Result := 'DESFAZIMENTO DA ALIENAÇÃO';
  else
    Result := 'Não Definido';
  end;
end;

end.
