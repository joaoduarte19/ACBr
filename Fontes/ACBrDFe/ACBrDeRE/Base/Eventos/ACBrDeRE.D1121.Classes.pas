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

unit ACBrDeRE.D1121.Classes;

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
  ACBrDeRE.Conversao,
  ACBrDeRE.Classes;

type

  { TitemDFeCollectionItemD1121 }

  TitemDFeCollectionItemD1121 = class(TObject)
  private
    FnItem: string;
    FvItem: Double;
    FvItemDedTotal: Double;
    FTemvItemDedTotal: Boolean;
    FvItemDed: Double;
  public
    property nItem: string read FnItem write FnItem;
    property vItem: Double read FvItem write FvItem;
    property vItemDedTotal: Double read FvItemDedTotal write FvItemDedTotal;
    property TemvItemDedTotal: Boolean read FTemvItemDedTotal write FTemvItemDedTotal;
    property vItemDed: Double read FvItemDed write FvItemDed;
  end;

  { TitemDFeCollectionD1121 }

  TitemDFeCollectionD1121 = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TitemDFeCollectionItemD1121;
    procedure SetItem(Index: Integer; Value: TitemDFeCollectionItemD1121);
  public
    function New: TitemDFeCollectionItemD1121;
    property Items[Index: Integer]: TitemDFeCollectionItemD1121 read GetItem write SetItem; default;
  end;

  { TdesdobDeducaoCollectionItemD1121 }

  TdesdobDeducaoCollectionItemD1121 = class(TObject)
  private
    FtpAtiv: TTpAtivDedDeRE;
    FcCta: string;
    FvDedTotal: Double;
    FTemvDedTotal: Boolean;
    FvDed: Double;
    FitemsDFe: TitemDFeCollectionD1121;
    procedure SetitemsDFe(const Value: TitemDFeCollectionD1121);
  public
    constructor Create;
    destructor Destroy; override;
    property tpAtiv: TTpAtivDedDeRE read FtpAtiv write FtpAtiv;
    property cCta: string read FcCta write FcCta;
    property vDedTotal: Double read FvDedTotal write FvDedTotal;
    property TemvDedTotal: Boolean read FTemvDedTotal write FTemvDedTotal;
    property vDed: Double read FvDed write FvDed;
    property itemsDFe: TitemDFeCollectionD1121 read FitemsDFe write SetitemsDFe;
  end;

  { TdesdobDeducaoCollectionD1121 }

  TdesdobDeducaoCollectionD1121 = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TdesdobDeducaoCollectionItemD1121;
    procedure SetItem(Index: Integer; Value: TdesdobDeducaoCollectionItemD1121);
  public
    function New: TdesdobDeducaoCollectionItemD1121;
    property Items[Index: Integer]: TdesdobDeducaoCollectionItemD1121 read GetItem write SetItem; default;
  end;

  { TinfoDFeD1121 }

  TinfoDFeD1121 = class(TObject)
  private
    FchDFe: string;
    FchDFeRetif: string;
    FtpDFe: TTpDFeDeRE;
    FTemtpDFe: Boolean;
    FdtEmi: TDateTime;
    FTemdtEmi: Boolean;
  public
    property chDFe: string read FchDFe write FchDFe;
    property chDFeRetif: string read FchDFeRetif write FchDFeRetif;
    property tpDFe: TTpDFeDeRE read FtpDFe write FtpDFe;
    property TemtpDFe: Boolean read FTemtpDFe write FTemtpDFe;
    property dtEmi: TDateTime read FdtEmi write FdtEmi;
    property TemdtEmi: Boolean read FTemdtEmi write FTemdtEmi;
  end;

  { TinfoImovelD1121 }

  TinfoImovelD1121 = class(TObject)
  private
    FCPFAlien: string;
  public
    property CPFAlien: string read FCPFAlien write FCPFAlien;
  end;

  { TdetDeducaoD1121 }

  TdetDeducaoD1121 = class(TObject)
  private
    FvOper: Double;
    FdesdobDeducoes: TdesdobDeducaoCollectionD1121;
    procedure SetdesdobDeducoes(const Value: TdesdobDeducaoCollectionD1121);
  public
    constructor Create;
    destructor Destroy; override;
    property vOper: Double read FvOper write FvOper;
    property desdobDeducoes: TdesdobDeducaoCollectionD1121 read FdesdobDeducoes write SetdesdobDeducoes;
  end;

  { TinfoDeducaoCollectionItemD1121 }

  TinfoDeducaoCollectionItemD1121 = class(TObject)
  private
    FinfoDFe: TinfoDFeD1121;
    FTeminfoDFe: Boolean;
    FinfoImovel: TinfoImovelD1121;
    FTeminfoImovel: Boolean;
    FdetDeducao: TdetDeducaoD1121;
    FTemdetDeducao: Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    property infoDFe: TinfoDFeD1121 read FinfoDFe write FinfoDFe;
    property TeminfoDFe: Boolean read FTeminfoDFe write FTeminfoDFe;
    property infoImovel: TinfoImovelD1121 read FinfoImovel write FinfoImovel;
    property TeminfoImovel: Boolean read FTeminfoImovel write FTeminfoImovel;
    property detDeducao: TdetDeducaoD1121 read FdetDeducao write FdetDeducao;
    property TemdetDeducao: Boolean read FTemdetDeducao write FTemdetDeducao;
  end;

  { TinfoDeducaoCollectionD1121 }

  TinfoDeducaoCollectionD1121 = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TinfoDeducaoCollectionItemD1121;
    procedure SetItem(Index: Integer; Value: TinfoDeducaoCollectionItemD1121);
  public
    function New: TinfoDeducaoCollectionItemD1121;
    property Items[Index: Integer]: TinfoDeducaoCollectionItemD1121 read GetItem write SetItem; default;
  end;

  { TinfoDeducoesD1121 }

  TinfoDeducoesD1121 = class(TObject)
  private
    FTeminfoDeducoes: Boolean;
    FfinEvt: TFinEvtDeRE;
    FTemfinEvt: Boolean;
    FinfoDeducao: TinfoDeducaoCollectionD1121;
    procedure SetinfoDeducao(const Value: TinfoDeducaoCollectionD1121);
  public
    constructor Create;
    destructor Destroy; override;
    property TeminfoDeducoes: Boolean read FTeminfoDeducoes write FTeminfoDeducoes;
    property finEvt: TFinEvtDeRE read FfinEvt write FfinEvt;
    property TemfinEvt: Boolean read FTemfinEvt write FTemfinEvt;
    property infoDeducao: TinfoDeducaoCollectionD1121 read FinfoDeducao write SetinfoDeducao;
  end;

  { TevtRelDeducoes }

  TevtRelDeducoes = class(TDeREEvento)
  private
    FideEvento: TideEventoRecibo;
    FideContrib: TideContrib;
    FidePeriodo: TidePeriodoApur;
    FinfoDeducoes: TinfoDeducoesD1121;
  protected
    function GetTipoEvento: TTipoEventoDeRE; override;
  public
    constructor Create; override;
    destructor Destroy; override;

    property ideEvento: TideEventoRecibo read FideEvento write FideEvento;
    property ideContrib: TideContrib read FideContrib write FideContrib;
    property idePeriodo: TidePeriodoApur read FidePeriodo write FidePeriodo;
    property infoDeducoes: TinfoDeducoesD1121 read FinfoDeducoes write FinfoDeducoes;
  end;

  { TDeRED1121 - documento DeRE do evento D-1121 }

  TDeRED1121 = class(TDeRE)
  private
    FevtRelDeducoes: TevtRelDeducoes;
  protected
    function GetEvento: TDeREEvento; override;
  public
    constructor Create; override;
    destructor Destroy; override;

    property evtRelDeducoes: TevtRelDeducoes read FevtRelDeducoes write FevtRelDeducoes;
  end;

implementation

{ TitemDFeCollectionD1121 }

function TitemDFeCollectionD1121.GetItem(Index: Integer): TitemDFeCollectionItemD1121;
begin
  Result := TitemDFeCollectionItemD1121(inherited Items[Index]);
end;

procedure TitemDFeCollectionD1121.SetItem(Index: Integer; Value: TitemDFeCollectionItemD1121);
begin
  inherited Items[Index] := Value;
end;

function TitemDFeCollectionD1121.New: TitemDFeCollectionItemD1121;
begin
  Result := TitemDFeCollectionItemD1121.Create;
  Add(Result);
end;

{ TdesdobDeducaoCollectionItemD1121 }

constructor TdesdobDeducaoCollectionItemD1121.Create;
begin
  inherited Create;
  FitemsDFe := TitemDFeCollectionD1121.Create;
  FTemvDedTotal := False;
end;

destructor TdesdobDeducaoCollectionItemD1121.Destroy;
begin
  FitemsDFe.Free;
  inherited Destroy;
end;

procedure TdesdobDeducaoCollectionItemD1121.SetitemsDFe(const Value: TitemDFeCollectionD1121);
begin
  FitemsDFe := Value;
end;

{ TdesdobDeducaoCollectionD1121 }

function TdesdobDeducaoCollectionD1121.GetItem(Index: Integer): TdesdobDeducaoCollectionItemD1121;
begin
  Result := TdesdobDeducaoCollectionItemD1121(inherited Items[Index]);
end;

procedure TdesdobDeducaoCollectionD1121.SetItem(Index: Integer; Value: TdesdobDeducaoCollectionItemD1121);
begin
  inherited Items[Index] := Value;
end;

function TdesdobDeducaoCollectionD1121.New: TdesdobDeducaoCollectionItemD1121;
begin
  Result := TdesdobDeducaoCollectionItemD1121.Create;
  Add(Result);
end;

{ TdetDeducaoD1121 }

constructor TdetDeducaoD1121.Create;
begin
  inherited Create;
  FdesdobDeducoes := TdesdobDeducaoCollectionD1121.Create;
end;

destructor TdetDeducaoD1121.Destroy;
begin
  FdesdobDeducoes.Free;
  inherited Destroy;
end;

procedure TdetDeducaoD1121.SetdesdobDeducoes(const Value: TdesdobDeducaoCollectionD1121);
begin
  FdesdobDeducoes := Value;
end;

{ TinfoDeducaoCollectionItemD1121 }

constructor TinfoDeducaoCollectionItemD1121.Create;
begin
  inherited Create;
  FinfoDFe := TinfoDFeD1121.Create;
  FinfoImovel := TinfoImovelD1121.Create;
  FdetDeducao := TdetDeducaoD1121.Create;
  FTeminfoDFe := False;
  FTeminfoImovel := False;
  FTemdetDeducao := False;
end;

destructor TinfoDeducaoCollectionItemD1121.Destroy;
begin
  FinfoDFe.Free;
  FinfoImovel.Free;
  FdetDeducao.Free;
  inherited Destroy;
end;

{ TinfoDeducaoCollectionD1121 }

function TinfoDeducaoCollectionD1121.GetItem(Index: Integer): TinfoDeducaoCollectionItemD1121;
begin
  Result := TinfoDeducaoCollectionItemD1121(inherited Items[Index]);
end;

procedure TinfoDeducaoCollectionD1121.SetItem(Index: Integer; Value: TinfoDeducaoCollectionItemD1121);
begin
  inherited Items[Index] := Value;
end;

function TinfoDeducaoCollectionD1121.New: TinfoDeducaoCollectionItemD1121;
begin
  Result := TinfoDeducaoCollectionItemD1121.Create;
  Add(Result);
end;

{ TinfoDeducoesD1121 }

constructor TinfoDeducoesD1121.Create;
begin
  inherited Create;
  FinfoDeducao := TinfoDeducaoCollectionD1121.Create;
  FTeminfoDeducoes := False;
  FTemfinEvt := False;
end;

destructor TinfoDeducoesD1121.Destroy;
begin
  FinfoDeducao.Free;
  inherited Destroy;
end;

procedure TinfoDeducoesD1121.SetinfoDeducao(const Value: TinfoDeducaoCollectionD1121);
begin
  FinfoDeducao := Value;
end;

{ TevtRelDeducoes }

constructor TevtRelDeducoes.Create;
begin
  inherited Create;
  FideEvento := TideEventoRecibo.Create;
  FideContrib := TideContrib.Create;
  FidePeriodo := TidePeriodoApur.Create;
  FinfoDeducoes := TinfoDeducoesD1121.Create;
end;

destructor TevtRelDeducoes.Destroy;
begin
  FideEvento.Free;
  FideContrib.Free;
  FidePeriodo.Free;
  FinfoDeducoes.Free;
  inherited Destroy;
end;

function TevtRelDeducoes.GetTipoEvento: TTipoEventoDeRE;
begin
  Result := teRelDeducoes;
end;

{ TDeRED1121 }

constructor TDeRED1121.Create;
begin
  inherited Create;
  FevtRelDeducoes := TevtRelDeducoes.Create;
end;

destructor TDeRED1121.Destroy;
begin
  FevtRelDeducoes.Free;
  inherited Destroy;
end;

function TDeRED1121.GetEvento: TDeREEvento;
begin
  Result := FevtRelDeducoes;
end;

initialization
  RegistrarDeRE(teRelDeducoes, TDeRED1121);

end.
