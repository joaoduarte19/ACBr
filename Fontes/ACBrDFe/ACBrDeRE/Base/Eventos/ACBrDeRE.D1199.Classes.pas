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

unit ACBrDeRE.D1199.Classes;

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

  { TinfoParamFechD1199 }

  TinfoParamFechD1199 = class(TObject)
  private
    FindInexistDedu: Boolean;
  public
    // Declaracao de inexistencia de deducoes a detalhar no periodo, dispensando a transmissao do evento...
    property indInexistDedu: Boolean read FindInexistDedu write FindInexistDedu;
  end;

  { TinfoBCNCollectionItemD1199 }

  TinfoBCNCollectionItemD1199 = class(TObject)
  private
    FcodBCNRaiz: string;
    FusarBCNAcum: Boolean;
    FmetodoAproveit: TMetodoAproveitDeRE;
    FTemmetodoAproveit: Boolean;
  public
    // Informar o codigo identificador da base de calculo negativa especifica do qual se deseja utilizar...
    property codBCNRaiz: string read FcodBCNRaiz write FcodBCNRaiz;
    // Informar a opcao por utilizar (se existir) o valor de base de calculo negativa acumulada em perio...
    property usarBCNAcum: Boolean read FusarBCNAcum write FusarBCNAcum;
    // Informar qual metodo o contribuinte deseja para o aproveitamento da base de calculo negativa
    property metodoAproveit: TMetodoAproveitDeRE read FmetodoAproveit write FmetodoAproveit;
    property TemmetodoAproveit: Boolean read FTemmetodoAproveit write FTemmetodoAproveit;
  end;

  { TinfoBCNCollectionD1199 }

  TinfoBCNCollectionD1199 = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TinfoBCNCollectionItemD1199;
    procedure SetItem(Index: Integer; Value: TinfoBCNCollectionItemD1199);
  public
    function New: TinfoBCNCollectionItemD1199;
    property Items[Index: Integer]: TinfoBCNCollectionItemD1199 read GetItem write SetItem; default;
  end;

  { TdetBCNegCollectionItemD1199 }

  TdetBCNegCollectionItemD1199 = class(TObject)
  private
    FcodBCN: string;
    FvUsarBCN: Double;
    FTemvUsarBCN: Boolean;
  public
    // Informar o codigo da base de calculo negativa que sera utilizado para deducao nesta competencia
    property codBCN: string read FcodBCN write FcodBCN;
    // Valor maximo da base de calculo negativa que o contribuinte deseja realizar o aproveitamento na c...
    property vUsarBCN: Double read FvUsarBCN write FvUsarBCN;
    property TemvUsarBCN: Boolean read FTemvUsarBCN write FTemvUsarBCN;
  end;

  { TdetBCNegCollectionD1199 }

  TdetBCNegCollectionD1199 = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TdetBCNegCollectionItemD1199;
    procedure SetItem(Index: Integer; Value: TdetBCNegCollectionItemD1199);
  public
    function New: TdetBCNegCollectionItemD1199;
    property Items[Index: Integer]: TdetBCNegCollectionItemD1199 read GetItem write SetItem; default;
  end;

  { TgUtilizBCND1199 }

  TgUtilizBCND1199 = class(TObject)
  private
    FinfoBCN: TinfoBCNCollectionD1199;
    FdetBCNeg: TdetBCNegCollectionD1199;
  public
    constructor Create;
    destructor Destroy; override;

    property infoBCN: TinfoBCNCollectionD1199 read FinfoBCN;
    property detBCNeg: TdetBCNegCollectionD1199 read FdetBCNeg;
  end;

  { TinfoFechamentoD1199 }

  TinfoFechamentoD1199 = class(TObject)
  private
    FTeminfoFechamento: Boolean;
    FTeminfoParamFech: Boolean;
    FTemgUtilizBCN: Boolean;
    FinfoParamFech: TinfoParamFechD1199;
    FgUtilizBCN: TgUtilizBCND1199;
  public
    constructor Create;
    destructor Destroy; override;

    property TeminfoFechamento: Boolean read FTeminfoFechamento write FTeminfoFechamento;
    property TeminfoParamFech: Boolean read FTeminfoParamFech write FTeminfoParamFech;
    property TemgUtilizBCN: Boolean read FTemgUtilizBCN write FTemgUtilizBCN;
    property infoParamFech: TinfoParamFechD1199 read FinfoParamFech;
    property gUtilizBCN: TgUtilizBCND1199 read FgUtilizBCN;
  end;

  { TevtFechMensal }

  TevtFechMensal = class(TDeREEvento)
  private
    FideEvento: TideEvento;
    FideContrib: TideContrib;
    FidePeriodo: TidePeriodoApur;
    FinfoFechamento: TinfoFechamentoD1199;
  protected
    function GetTipoEvento: TTipoEventoDeRE; override;
  public
    constructor Create; override;
    destructor Destroy; override;

    property ideEvento: TideEvento read FideEvento write FideEvento;
    property ideContrib: TideContrib read FideContrib write FideContrib;
    property idePeriodo: TidePeriodoApur read FidePeriodo write FidePeriodo;
    property infoFechamento: TinfoFechamentoD1199 read FinfoFechamento write FinfoFechamento;
  end;

  { TDeRED1199 - documento DeRE do evento D-1199 }

  TDeRED1199 = class(TDeRE)
  private
    FevtFechMensal: TevtFechMensal;
  protected
    function GetEvento: TDeREEvento; override;
  public
    constructor Create; override;
    destructor Destroy; override;

    property evtFechMensal: TevtFechMensal read FevtFechMensal write FevtFechMensal;
  end;

implementation

{ TinfoBCNCollectionD1199 }

function TinfoBCNCollectionD1199.GetItem(Index: Integer): TinfoBCNCollectionItemD1199;
begin
  Result := TinfoBCNCollectionItemD1199(inherited Items[Index]);
end;

procedure TinfoBCNCollectionD1199.SetItem(Index: Integer; Value: TinfoBCNCollectionItemD1199);
begin
  inherited Items[Index] := Value;
end;

function TinfoBCNCollectionD1199.New: TinfoBCNCollectionItemD1199;
begin
  Result := TinfoBCNCollectionItemD1199.Create;
  Add(Result);
end;


{ TdetBCNegCollectionD1199 }

function TdetBCNegCollectionD1199.GetItem(Index: Integer): TdetBCNegCollectionItemD1199;
begin
  Result := TdetBCNegCollectionItemD1199(inherited Items[Index]);
end;

procedure TdetBCNegCollectionD1199.SetItem(Index: Integer; Value: TdetBCNegCollectionItemD1199);
begin
  inherited Items[Index] := Value;
end;

function TdetBCNegCollectionD1199.New: TdetBCNegCollectionItemD1199;
begin
  Result := TdetBCNegCollectionItemD1199.Create;
  Add(Result);
end;


{ TgUtilizBCND1199 }

constructor TgUtilizBCND1199.Create;
begin
  inherited Create;
  FinfoBCN := TinfoBCNCollectionD1199.Create;
  FdetBCNeg := TdetBCNegCollectionD1199.Create;
end;

destructor TgUtilizBCND1199.Destroy;
begin
  FinfoBCN.Free;
  FdetBCNeg.Free;
  inherited Destroy;
end;


{ TinfoFechamentoD1199 }

constructor TinfoFechamentoD1199.Create;
begin
  inherited Create;
  FinfoParamFech := TinfoParamFechD1199.Create;
  FgUtilizBCN := TgUtilizBCND1199.Create;
end;

destructor TinfoFechamentoD1199.Destroy;
begin
  FinfoParamFech.Free;
  FgUtilizBCN.Free;
  inherited Destroy;
end;


{ TevtFechMensal }

constructor TevtFechMensal.Create;
begin
  inherited Create;
  FideEvento := TideEvento.Create;
  FideContrib := TideContrib.Create;
  FidePeriodo := TidePeriodoApur.Create;
  FinfoFechamento := TinfoFechamentoD1199.Create;
end;

destructor TevtFechMensal.Destroy;
begin
  FideEvento.Free;
  FideContrib.Free;
  FidePeriodo.Free;
  FinfoFechamento.Free;
  inherited Destroy;
end;

function TevtFechMensal.GetTipoEvento: TTipoEventoDeRE;
begin
  Result := teFechMensal;
end;


{ TDeRED1199 }

constructor TDeRED1199.Create;
begin
  inherited Create;
  FevtFechMensal := TevtFechMensal.Create;
end;

destructor TDeRED1199.Destroy;
begin
  FevtFechMensal.Free;
  inherited Destroy;
end;

function TDeRED1199.GetEvento: TDeREEvento;
begin
  Result := FevtFechMensal;
end;


initialization
  RegistrarDeRE(teFechMensal, TDeRED1199);

end.
