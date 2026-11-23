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

unit ACBrDeRE.D1106.Classes;

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

  { TdetAtivoCollectionItemD1106 }

  TdetAtivoCollectionItemD1106 = class(TObject)
  private
    FidAtivo: string;
    FdescAtivo: string;
    FvSaldoInic: Double;
    FvRendPerReceb: Double;
    FTemvRendPerReceb: Boolean;
    FvVarMensal: Double;
    FTemvVarMensal: Boolean;
    FvPrincLiqResg: Double;
    FvRendLiqResg: Double;
    FTemvRendLiqResg: Boolean;
    FvSaldoFinal: Double;
    FvApur: Double;
  public
    property idAtivo: string read FidAtivo write FidAtivo;
    property descAtivo: string read FdescAtivo write FdescAtivo;
    property vSaldoInic: Double read FvSaldoInic write FvSaldoInic;
    property vRendPerReceb: Double read FvRendPerReceb write FvRendPerReceb;
    property TemvRendPerReceb: Boolean read FTemvRendPerReceb write FTemvRendPerReceb;
    property vVarMensal: Double read FvVarMensal write FvVarMensal;
    property TemvVarMensal: Boolean read FTemvVarMensal write FTemvVarMensal;
    property vPrincLiqResg: Double read FvPrincLiqResg write FvPrincLiqResg;
    property vRendLiqResg: Double read FvRendLiqResg write FvRendLiqResg;
    property TemvRendLiqResg: Boolean read FTemvRendLiqResg write FTemvRendLiqResg;
    property vSaldoFinal: Double read FvSaldoFinal write FvSaldoFinal;
    property vApur: Double read FvApur write FvApur;
  end;

  { TdetAtivoCollectionD1106 }

  TdetAtivoCollectionD1106 = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TdetAtivoCollectionItemD1106;
    procedure SetItem(Index: Integer; Value: TdetAtivoCollectionItemD1106);
  public
    function New: TdetAtivoCollectionItemD1106;
    property Items[Index: Integer]: TdetAtivoCollectionItemD1106 read GetItem write SetItem; default;
  end;

  { TinfoAplicCollectionItemD1106 }

  TinfoAplicCollectionItemD1106 = class(TObject)
  private
    FcCta: string;
    FdetAtivo: TdetAtivoCollectionD1106;
    procedure SetdetAtivo(const Value: TdetAtivoCollectionD1106);
  public
    constructor Create;
    destructor Destroy; override;

    property cCta: string read FcCta write FcCta;
    property detAtivo: TdetAtivoCollectionD1106 read FdetAtivo write SetdetAtivo;
  end;

  { TinfoAplicCollectionD1106 }

  TinfoAplicCollectionD1106 = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TinfoAplicCollectionItemD1106;
    procedure SetItem(Index: Integer; Value: TinfoAplicCollectionItemD1106);
  public
    function New: TinfoAplicCollectionItemD1106;
    property Items[Index: Integer]: TinfoAplicCollectionItemD1106 read GetItem write SetItem; default;
  end;

  { TinfoAplicResTecD1106 }

  TinfoAplicResTecD1106 = class(TObject)
  private
    FTeminfoAplicResTec: Boolean;
    FsemAplic: Boolean;
    FinfoAplic: TinfoAplicCollectionD1106;
    procedure SetinfoAplic(const Value: TinfoAplicCollectionD1106);
  public
    constructor Create;
    destructor Destroy; override;

    property TeminfoAplicResTec: Boolean read FTeminfoAplicResTec write FTeminfoAplicResTec;
    // semAplic = 1: nao existem aplicacoes financeiras a declarar no periodo
    property semAplic: Boolean read FsemAplic write FsemAplic;
    property infoAplic: TinfoAplicCollectionD1106 read FinfoAplic write SetinfoAplic;
  end;

  { TevtAplicResTec }

  TevtAplicResTec = class(TDeREEvento)
  private
    FideEvento: TideEventoRecibo;
    FideContrib: TideContrib;
    FidePeriodo: TidePeriodoApur;
    FinfoAplicResTec: TinfoAplicResTecD1106;
  protected
    function GetTipoEvento: TTipoEventoDeRE; override;
  public
    constructor Create; override;
    destructor Destroy; override;

    property ideEvento: TideEventoRecibo read FideEvento write FideEvento;
    property ideContrib: TideContrib read FideContrib write FideContrib;
    property idePeriodo: TidePeriodoApur read FidePeriodo write FidePeriodo;
    property infoAplicResTec: TinfoAplicResTecD1106 read FinfoAplicResTec write FinfoAplicResTec;
  end;

  { TDeRED1106 - documento DeRE do evento D-1106 }

  TDeRED1106 = class(TDeRE)
  private
    FevtAplicResTec: TevtAplicResTec;
  protected
    function GetEvento: TDeREEvento; override;
  public
    constructor Create; override;
    destructor Destroy; override;

    property evtAplicResTec: TevtAplicResTec read FevtAplicResTec write FevtAplicResTec;
  end;

implementation

{ TdetAtivoCollectionD1106 }

function TdetAtivoCollectionD1106.GetItem(Index: Integer): TdetAtivoCollectionItemD1106;
begin
  Result := TdetAtivoCollectionItemD1106(inherited Items[Index]);
end;

procedure TdetAtivoCollectionD1106.SetItem(Index: Integer; Value: TdetAtivoCollectionItemD1106);
begin
  inherited Items[Index] := Value;
end;

function TdetAtivoCollectionD1106.New: TdetAtivoCollectionItemD1106;
begin
  Result := TdetAtivoCollectionItemD1106.Create;
  Add(Result);
end;


{ TinfoAplicCollectionItemD1106 }

constructor TinfoAplicCollectionItemD1106.Create;
begin
  inherited Create;
  FdetAtivo := TdetAtivoCollectionD1106.Create;
end;

destructor TinfoAplicCollectionItemD1106.Destroy;
begin
  FdetAtivo.Free;
  inherited Destroy;
end;

procedure TinfoAplicCollectionItemD1106.SetdetAtivo(const Value: TdetAtivoCollectionD1106);
begin
  FdetAtivo := Value;
end;

{ TinfoAplicCollectionD1106 }

function TinfoAplicCollectionD1106.GetItem(Index: Integer): TinfoAplicCollectionItemD1106;
begin
  Result := TinfoAplicCollectionItemD1106(inherited Items[Index]);
end;

procedure TinfoAplicCollectionD1106.SetItem(Index: Integer; Value: TinfoAplicCollectionItemD1106);
begin
  inherited Items[Index] := Value;
end;

function TinfoAplicCollectionD1106.New: TinfoAplicCollectionItemD1106;
begin
  Result := TinfoAplicCollectionItemD1106.Create;
  Add(Result);
end;


{ TinfoAplicResTecD1106 }

constructor TinfoAplicResTecD1106.Create;
begin
  inherited Create;
  FinfoAplic := TinfoAplicCollectionD1106.Create;
  FTeminfoAplicResTec := False;
  FsemAplic := False;
end;

destructor TinfoAplicResTecD1106.Destroy;
begin
  FinfoAplic.Free;
  inherited Destroy;
end;

procedure TinfoAplicResTecD1106.SetinfoAplic(const Value: TinfoAplicCollectionD1106);
begin
  FinfoAplic := Value;
end;

{ TevtAplicResTec }

constructor TevtAplicResTec.Create;
begin
  inherited Create;
  FideEvento := TideEventoRecibo.Create;
  FideContrib := TideContrib.Create;
  FidePeriodo := TidePeriodoApur.Create;
  FinfoAplicResTec := TinfoAplicResTecD1106.Create;
end;

destructor TevtAplicResTec.Destroy;
begin
  FideEvento.Free;
  FideContrib.Free;
  FidePeriodo.Free;
  FinfoAplicResTec.Free;
  inherited Destroy;
end;

function TevtAplicResTec.GetTipoEvento: TTipoEventoDeRE;
begin
  Result := teAplicResTec;
end;

{ TDeRED1106 }

constructor TDeRED1106.Create;
begin
  inherited Create;
  FevtAplicResTec := TevtAplicResTec.Create;
end;

destructor TDeRED1106.Destroy;
begin
  FevtAplicResTec.Free;
  inherited Destroy;
end;

function TDeRED1106.GetEvento: TDeREEvento;
begin
  Result := FevtAplicResTec;
end;

initialization
  RegistrarDeRE(teAplicResTec, TDeRED1106);

end.
