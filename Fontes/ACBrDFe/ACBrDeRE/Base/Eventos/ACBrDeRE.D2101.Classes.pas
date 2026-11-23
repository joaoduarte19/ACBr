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

unit ACBrDeRE.D2101.Classes;

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

  { TdetTituloCollectionItemD2101 }

  TdetTituloCollectionItemD2101 = class(TObject)
  private
    FidTitulo: string;
    FcCta: string;
    FdescFundo: string;
    FTemdescFundo: Boolean;
    FCNPJDevedor: string;
    FvSaldoContIni: Double;
    FvEntradas: Double;
    FvSaidas: Double;
    FvJurosRec: Double;
    FvVarMensal: Double;
    FTemvVarMensal: Boolean;
    FvSaldoContFin: Double;
    FvSelic: Double;
    FvPisCofins: Double;
    FTemvPisCofins: Boolean;
    FvApur: Double;
  public
    // Codigo de identificacao global do titulo no padrao ISO 6166 (ISIN)
    property idTitulo: string read FidTitulo write FidTitulo;
    // Codigo da conta analitica (como informada no evento D-1011.{cCta})
    property cCta: string read FcCta write FcCta;
    // Descricao do nome do fundo
    property descFundo: string read FdescFundo write FdescFundo;
    property TemdescFundo: Boolean read FTemdescFundo write FTemdescFundo;
    // Numero de inscricao no CNPJ do devedor emitente do titulo de divida
    property CNPJDevedor: string read FCNPJDevedor write FCNPJDevedor;
    // Representa o valor do titulo sobre o qual havera a incidencia dos juros no periodo
    property vSaldoContIni: Double read FvSaldoContIni write FvSaldoContIni;
    // Valor total das entradas (compras de novos titulos) da mesma emissao e serie de ativos no periodo...
    property vEntradas: Double read FvEntradas write FvEntradas;
    // Valor total das saidas (vendas de titulos e amortizacoes) da mesma emissao e serie de ativos, no...
    property vSaidas: Double read FvSaidas write FvSaidas;
    // Valor dos juros recebidos relativos a mesma emissao e serie de ativos, no periodo de apuracao
    property vJurosRec: Double read FvJurosRec write FvJurosRec;
    // Valores de variacao mensal a serem incorporados ao saldo do ativo
    property vVarMensal: Double read FvVarMensal write FvVarMensal;
    property TemvVarMensal: Boolean read FTemvVarMensal write FTemvVarMensal;
    // Valor final do agrumento de titulos
    property vSaldoContFin: Double read FvSaldoContFin write FvSaldoContFin;
    // Valor equivalente a variacao da taxa Selic diaria acumulada no periodo aplicada sobre o saldo, ca...
    property vSelic: Double read FvSelic write FvSelic;
    // Valor da deducao relativa ao PIS/COFINS incidente sobre a receita tributada
    property vPisCofins: Double read FvPisCofins write FvPisCofins;
    property TemvPisCofins: Boolean read FTemvPisCofins write FTemvPisCofins;
    // Valor base sobre o qual serao aplicadas as regras definidas pelo codigo de tributacao ({codTrib})
    property vApur: Double read FvApur write FvApur;
  end;

  { TdetTituloCollectionD2101 }

  TdetTituloCollectionD2101 = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TdetTituloCollectionItemD2101;
    procedure SetItem(Index: Integer; Value: TdetTituloCollectionItemD2101);
  public
    function New: TdetTituloCollectionItemD2101;
    property Items[Index: Integer]: TdetTituloCollectionItemD2101 read GetItem write SetItem; default;
  end;

  { TinfoTitulosD2101 }

  TinfoTitulosD2101 = class(TObject)
  private
    FdetTitulo: TdetTituloCollectionD2101;
  public
    constructor Create;
    destructor Destroy; override;

    property detTitulo: TdetTituloCollectionD2101 read FdetTitulo;
  end;

  { TinfoDebOpOfPublicD2101 }

  TinfoDebOpOfPublicD2101 = class(TObject)
  private
    FTeminfoDebOpOfPublic: Boolean;
    FsemTitulos: Boolean;
    FTeminfoTitulos: Boolean;
    FinfoTitulos: TinfoTitulosD2101;
  public
    constructor Create;
    destructor Destroy; override;

    property TeminfoDebOpOfPublic: Boolean read FTeminfoDebOpOfPublic write FTeminfoDebOpOfPublic;
    // Indicacao da inexistencia de titulos de divida com oferta publica movimentados no periodo
    property semTitulos: Boolean read FsemTitulos write FsemTitulos;
    property TeminfoTitulos: Boolean read FTeminfoTitulos write FTeminfoTitulos;
    property infoTitulos: TinfoTitulosD2101 read FinfoTitulos;
  end;

  { TevtDebOpOfPublic }

  TevtDebOpOfPublic = class(TDeREEvento)
  private
    FideEvento: TideEventoRecibo;
    FideContrib: TideContrib;
    FidePeriodo: TidePeriodoApur;
    FinfoDebOpOfPublic: TinfoDebOpOfPublicD2101;
  protected
    function GetTipoEvento: TTipoEventoDeRE; override;
  public
    constructor Create; override;
    destructor Destroy; override;

    property ideEvento: TideEventoRecibo read FideEvento write FideEvento;
    property ideContrib: TideContrib read FideContrib write FideContrib;
    property idePeriodo: TidePeriodoApur read FidePeriodo write FidePeriodo;
    property infoDebOpOfPublic: TinfoDebOpOfPublicD2101 read FinfoDebOpOfPublic write FinfoDebOpOfPublic;
  end;

  { TDeRED2101 - documento DeRE do evento D-2101 }

  TDeRED2101 = class(TDeRE)
  private
    FevtDebOpOfPublic: TevtDebOpOfPublic;
  protected
    function GetEvento: TDeREEvento; override;
  public
    constructor Create; override;
    destructor Destroy; override;

    property evtDebOpOfPublic: TevtDebOpOfPublic read FevtDebOpOfPublic write FevtDebOpOfPublic;
  end;

implementation

{ TdetTituloCollectionD2101 }

function TdetTituloCollectionD2101.GetItem(Index: Integer): TdetTituloCollectionItemD2101;
begin
  Result := TdetTituloCollectionItemD2101(inherited Items[Index]);
end;

procedure TdetTituloCollectionD2101.SetItem(Index: Integer; Value: TdetTituloCollectionItemD2101);
begin
  inherited Items[Index] := Value;
end;

function TdetTituloCollectionD2101.New: TdetTituloCollectionItemD2101;
begin
  Result := TdetTituloCollectionItemD2101.Create;
  Add(Result);
end;


{ TinfoTitulosD2101 }

constructor TinfoTitulosD2101.Create;
begin
  inherited Create;
  FdetTitulo := TdetTituloCollectionD2101.Create;
end;

destructor TinfoTitulosD2101.Destroy;
begin
  FdetTitulo.Free;
  inherited Destroy;
end;


{ TinfoDebOpOfPublicD2101 }

constructor TinfoDebOpOfPublicD2101.Create;
begin
  inherited Create;
  FinfoTitulos := TinfoTitulosD2101.Create;
end;

destructor TinfoDebOpOfPublicD2101.Destroy;
begin
  FinfoTitulos.Free;
  inherited Destroy;
end;


{ TevtDebOpOfPublic }

constructor TevtDebOpOfPublic.Create;
begin
  inherited Create;
  FideEvento := TideEventoRecibo.Create;
  FideContrib := TideContrib.Create;
  FidePeriodo := TidePeriodoApur.Create;
  FinfoDebOpOfPublic := TinfoDebOpOfPublicD2101.Create;
end;

destructor TevtDebOpOfPublic.Destroy;
begin
  FideEvento.Free;
  FideContrib.Free;
  FidePeriodo.Free;
  FinfoDebOpOfPublic.Free;
  inherited Destroy;
end;

function TevtDebOpOfPublic.GetTipoEvento: TTipoEventoDeRE;
begin
  Result := teDebOpOfPublic;
end;


{ TDeRED2101 }

constructor TDeRED2101.Create;
begin
  inherited Create;
  FevtDebOpOfPublic := TevtDebOpOfPublic.Create;
end;

destructor TDeRED2101.Destroy;
begin
  FevtDebOpOfPublic.Free;
  inherited Destroy;
end;

function TDeRED2101.GetEvento: TDeREEvento;
begin
  Result := FevtDebOpOfPublic;
end;


initialization
  RegistrarDeRE(teDebOpOfPublic, TDeRED2101);

end.
