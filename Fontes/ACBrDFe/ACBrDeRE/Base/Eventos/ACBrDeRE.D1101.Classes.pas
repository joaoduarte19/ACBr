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

unit ACBrDeRE.D1101.Classes;

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

  { TinfoContaBalanceteCollectionItemD1101 }

  TinfoContaBalanceteCollectionItemD1101 = class(TObject)
  private
    FcCta: string;
    FnatSaldoInic: TNatSaldoDeRE;
    FvSaldoInic: Double;
    FvMovDebt: Double;
    FvAjusteDebt: Double;
    FTemvAjusteDebt: Boolean;
    FvMovCred: Double;
    FvAjusteCred: Double;
    FTemvAjusteCred: Boolean;
    FnatSaldoFinal: TNatSaldoDeRE;
    FvSaldoFinal: Double;
    FnatVApur: TNatSaldoDeRE;
    FTemnatVApur: Boolean;
    FvApur: Double;
  public
    property cCta: string read FcCta write FcCta;
    property natSaldoInic: TNatSaldoDeRE read FnatSaldoInic write FnatSaldoInic;
    property vSaldoInic: Double read FvSaldoInic write FvSaldoInic;
    property vMovDebt: Double read FvMovDebt write FvMovDebt;
    property vAjusteDebt: Double read FvAjusteDebt write FvAjusteDebt;
    property TemvAjusteDebt: Boolean read FTemvAjusteDebt write FTemvAjusteDebt;
    property vMovCred: Double read FvMovCred write FvMovCred;
    property vAjusteCred: Double read FvAjusteCred write FvAjusteCred;
    property TemvAjusteCred: Boolean read FTemvAjusteCred write FTemvAjusteCred;
    property natSaldoFinal: TNatSaldoDeRE read FnatSaldoFinal write FnatSaldoFinal;
    property vSaldoFinal: Double read FvSaldoFinal write FvSaldoFinal;
    property natVApur: TNatSaldoDeRE read FnatVApur write FnatVApur;
    property TemnatVApur: Boolean read FTemnatVApur write FTemnatVApur;
    property vApur: Double read FvApur write FvApur;
  end;

  { TinfoContaBalanceteCollectionD1101 }

  TinfoContaBalanceteCollectionD1101 = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TinfoContaBalanceteCollectionItemD1101;
    procedure SetItem(Index: Integer; Value: TinfoContaBalanceteCollectionItemD1101);
  public
    function New: TinfoContaBalanceteCollectionItemD1101;
    property Items[Index: Integer]: TinfoContaBalanceteCollectionItemD1101 read GetItem write SetItem; default;
  end;

  { TinfoBalanceteD1101 }

  TinfoBalanceteD1101 = class(TObject)
  private
    FTeminfoBalancete: Boolean;
    FinfoContas: TinfoContaBalanceteCollectionD1101;
    procedure SetinfoContas(const Value: TinfoContaBalanceteCollectionD1101);
  public
    constructor Create;
    destructor Destroy; override;

    property TeminfoBalancete: Boolean read FTeminfoBalancete write FTeminfoBalancete;
    property infoContas: TinfoContaBalanceteCollectionD1101 read FinfoContas write SetinfoContas;
  end;

  { TevtBalancete }

  TevtBalancete = class(TDeREEvento)
  private
    FideEvento: TideEventoRecibo;
    FideContrib: TideContrib;
    FidePeriodo: TidePeriodoApur;
    FinfoBalancete: TinfoBalanceteD1101;
  protected
    function GetTipoEvento: TTipoEventoDeRE; override;
  public
    constructor Create; override;
    destructor Destroy; override;

    property ideEvento: TideEventoRecibo read FideEvento write FideEvento;
    property ideContrib: TideContrib read FideContrib write FideContrib;
    property idePeriodo: TidePeriodoApur read FidePeriodo write FidePeriodo;
    property infoBalancete: TinfoBalanceteD1101 read FinfoBalancete write FinfoBalancete;
  end;

  { TDeRED1101 - documento DeRE do evento D-1101 }

  TDeRED1101 = class(TDeRE)
  private
    FevtBalancete: TevtBalancete;
  protected
    function GetEvento: TDeREEvento; override;
  public
    constructor Create; override;
    destructor Destroy; override;

    property evtBalancete: TevtBalancete read FevtBalancete write FevtBalancete;
  end;

implementation

{ TinfoContaBalanceteCollectionD1101 }

function TinfoContaBalanceteCollectionD1101.GetItem(Index: Integer): TinfoContaBalanceteCollectionItemD1101;
begin
  Result := TinfoContaBalanceteCollectionItemD1101(inherited Items[Index]);
end;

procedure TinfoContaBalanceteCollectionD1101.SetItem(Index: Integer; Value: TinfoContaBalanceteCollectionItemD1101);
begin
  inherited Items[Index] := Value;
end;

function TinfoContaBalanceteCollectionD1101.New: TinfoContaBalanceteCollectionItemD1101;
begin
  Result := TinfoContaBalanceteCollectionItemD1101.Create;
  Add(Result);
end;

{ TinfoBalanceteD1101 }

constructor TinfoBalanceteD1101.Create;
begin
  inherited Create;
  FinfoContas := TinfoContaBalanceteCollectionD1101.Create;
  FTeminfoBalancete := False;
end;

destructor TinfoBalanceteD1101.Destroy;
begin
  FinfoContas.Free;
  inherited Destroy;
end;

procedure TinfoBalanceteD1101.SetinfoContas(const Value: TinfoContaBalanceteCollectionD1101);
begin
  FinfoContas := Value;
end;

{ TevtBalancete }

constructor TevtBalancete.Create;
begin
  inherited Create;
  FideEvento := TideEventoRecibo.Create;
  FideContrib := TideContrib.Create;
  FidePeriodo := TidePeriodoApur.Create;
  FinfoBalancete := TinfoBalanceteD1101.Create;
end;

destructor TevtBalancete.Destroy;
begin
  FideEvento.Free;
  FideContrib.Free;
  FidePeriodo.Free;
  FinfoBalancete.Free;
  inherited Destroy;
end;

function TevtBalancete.GetTipoEvento: TTipoEventoDeRE;
begin
  Result := teBalancete;
end;

{ TDeRED1101 }

constructor TDeRED1101.Create;
begin
  inherited Create;
  FevtBalancete := TevtBalancete.Create;
end;

destructor TDeRED1101.Destroy;
begin
  FevtBalancete.Free;
  inherited Destroy;
end;

function TDeRED1101.GetEvento: TDeREEvento;
begin
  Result := FevtBalancete;
end;

initialization
  RegistrarDeRE(teBalancete, TDeRED1101);

end.
