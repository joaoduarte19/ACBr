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

unit ACBrDeRE.D1011.Classes;

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

  { TinfoContaCollectionItemD1011 }

  TinfoContaCollectionItemD1011 = class(TObject)
  private
    FcCta: string;
    FcCtaInterna: string;
    FcDbrMista: string;
    FnomeCta: string;
    FindCta: TIndCtaDeRE;
    FdescCta: string;
    FTemdescCta: Boolean;
    FcCtaSup: string;
    FTemcCtaSup: Boolean;
    FcCtaRef: string;
    FnivelCta: Integer;
    FnatCta: TNatCtaDeRE;
    FcodNat: TCodNatDeRE;
    FcodTrib: Integer;
    FTemcodTrib: Boolean;
    FindTribISS: TIndTribISSDeRE;
    FTemindTribISS: Boolean;
    FidLeiDisp: string;
    FTemidLeiDisp: Boolean;
    FiniVig: TDateTime;
    FfimVig: TDateTime;
    FTemfimVig: Boolean;
  public
    property cCta: string read FcCta write FcCta;
    property cCtaInterna: string read FcCtaInterna write FcCtaInterna;
    property cDbrMista: string read FcDbrMista write FcDbrMista;
    property nomeCta: string read FnomeCta write FnomeCta;
    property indCta: TIndCtaDeRE read FindCta write FindCta;
    property descCta: string read FdescCta write FdescCta;
    property TemdescCta: Boolean read FTemdescCta write FTemdescCta;
    property cCtaSup: string read FcCtaSup write FcCtaSup;
    property TemcCtaSup: Boolean read FTemcCtaSup write FTemcCtaSup;
    property cCtaRef: string read FcCtaRef write FcCtaRef;
    property nivelCta: Integer read FnivelCta write FnivelCta;
    property natCta: TNatCtaDeRE read FnatCta write FnatCta;
    property codNat: TCodNatDeRE read FcodNat write FcodNat;
    property codTrib: Integer read FcodTrib write FcodTrib;
    property TemcodTrib: Boolean read FTemcodTrib write FTemcodTrib;
    property indTribISS: TIndTribISSDeRE read FindTribISS write FindTribISS;
    property TemindTribISS: Boolean read FTemindTribISS write FTemindTribISS;
    property idLeiDisp: string read FidLeiDisp write FidLeiDisp;
    property TemidLeiDisp: Boolean read FTemidLeiDisp write FTemidLeiDisp;
    property iniVig: TDateTime read FiniVig write FiniVig;
    property fimVig: TDateTime read FfimVig write FfimVig;
    property TemfimVig: Boolean read FTemfimVig write FTemfimVig;
  end;

  { TinfoContaCollectionD1011 }

  TinfoContaCollectionD1011 = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TinfoContaCollectionItemD1011;
    procedure SetItem(Index: Integer; Value: TinfoContaCollectionItemD1011);
  public
    function New: TinfoContaCollectionItemD1011;
    property Items[Index: Integer]: TinfoContaCollectionItemD1011 read GetItem write SetItem; default;
  end;

  { TinfoPGCCD1011 }

  TinfoPGCCD1011 = class(TObject)
  private
    FTeminfoPGCC: Boolean;
    FplanoCtaRef: TPlanoCtaRefDeRE;
    FfreqEncerr: TFreqEncerrDeRE;
    FinfoContas: TinfoContaCollectionD1011;
    procedure SetinfoContas(const Value: TinfoContaCollectionD1011);
  public
    constructor Create;
    destructor Destroy; override;

    property TeminfoPGCC: Boolean read FTeminfoPGCC write FTeminfoPGCC;
    property planoCtaRef: TPlanoCtaRefDeRE read FplanoCtaRef write FplanoCtaRef;
    property freqEncerr: TFreqEncerrDeRE read FfreqEncerr write FfreqEncerr;
    property infoContas: TinfoContaCollectionD1011 read FinfoContas write SetinfoContas;
  end;

  { TevtPGCC }

  TevtPGCC = class(TDeREEvento)
  private
    FideEvento: TideEvento;
    FideContrib: TideContrib;
    FidePeriodo: TidePeriodo;
    FinfoPGCC: TinfoPGCCD1011;
  protected
    function GetTipoEvento: TTipoEventoDeRE; override;
  public
    constructor Create; override;
    destructor Destroy; override;

    property ideEvento: TideEvento read FideEvento write FideEvento;
    property ideContrib: TideContrib read FideContrib write FideContrib;
    property idePeriodo: TidePeriodo read FidePeriodo write FidePeriodo;
    property infoPGCC: TinfoPGCCD1011 read FinfoPGCC write FinfoPGCC;
  end;

  { TDeRED1011 - documento DeRE do evento D-1011 }

  TDeRED1011 = class(TDeRE)
  private
    FevtPGCC: TevtPGCC;
  protected
    function GetEvento: TDeREEvento; override;
  public
    constructor Create; override;
    destructor Destroy; override;

    property evtPGCC: TevtPGCC read FevtPGCC write FevtPGCC;
  end;

implementation

{ TinfoContaCollectionD1011 }

function TinfoContaCollectionD1011.GetItem(Index: Integer): TinfoContaCollectionItemD1011;
begin
  Result := TinfoContaCollectionItemD1011(inherited Items[Index]);
end;

procedure TinfoContaCollectionD1011.SetItem(Index: Integer; Value: TinfoContaCollectionItemD1011);
begin
  inherited Items[Index] := Value;
end;

function TinfoContaCollectionD1011.New: TinfoContaCollectionItemD1011;
begin
  Result := TinfoContaCollectionItemD1011.Create;
  Add(Result);
end;

{ TinfoPGCCD1011 }

constructor TinfoPGCCD1011.Create;
begin
  inherited Create;
  FinfoContas := TinfoContaCollectionD1011.Create;
  FTeminfoPGCC := False;
end;

destructor TinfoPGCCD1011.Destroy;
begin
  FinfoContas.Free;
  inherited Destroy;
end;

procedure TinfoPGCCD1011.SetinfoContas(const Value: TinfoContaCollectionD1011);
begin
  FinfoContas := Value;
end;

{ TevtPGCC }

constructor TevtPGCC.Create;
begin
  inherited Create;
  FideEvento := TideEvento.Create;
  FideContrib := TideContrib.Create;
  FidePeriodo := TidePeriodo.Create;
  FinfoPGCC := TinfoPGCCD1011.Create;
end;

destructor TevtPGCC.Destroy;
begin
  FideEvento.Free;
  FideContrib.Free;
  FidePeriodo.Free;
  FinfoPGCC.Free;
  inherited Destroy;
end;

function TevtPGCC.GetTipoEvento: TTipoEventoDeRE;
begin
  Result := tePGCC;
end;

{ TDeRED1011 }

constructor TDeRED1011.Create;
begin
  inherited Create;
  FevtPGCC := TevtPGCC.Create;
end;

destructor TDeRED1011.Destroy;
begin
  FevtPGCC.Free;
  inherited Destroy;
end;

function TDeRED1011.GetEvento: TDeREEvento;
begin
  Result := FevtPGCC;
end;

initialization
  RegistrarDeRE(tePGCC, TDeRED1011);

end.
