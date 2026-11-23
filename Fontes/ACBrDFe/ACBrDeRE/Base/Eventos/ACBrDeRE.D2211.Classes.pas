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

unit ACBrDeRE.D2211.Classes;

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

  { TadqExteriorD2211 }

  TadqExteriorD2211 = class(TObject)
  private
    FNIF: string;
    FTemNIF: Boolean;
    FcNaoNIF: TCNaoNIFDeRE;
    FTemcNaoNIF: Boolean;
    FnrDocIdent: string;
    FTemnrDocIdent: Boolean;
    FcPais: string;
  public
    // Numero de Identificacao Fiscal (NIF) do adquirente estrangeiro, fornecido por orgao de administra...
    property NIF: string read FNIF write FNIF;
    property TemNIF: Boolean read FTemNIF write FTemNIF;
    // Codigo do motivo para a nao informacao do NIF do adquirente estrangeiro
    property cNaoNIF: TCNaoNIFDeRE read FcNaoNIF write FcNaoNIF;
    property TemcNaoNIF: Boolean read FTemcNaoNIF write FTemcNaoNIF;
    // Numero do documento de identificacao oficial no exterior (passaporte, carteira de identidade estr...
    property nrDocIdent: string read FnrDocIdent write FnrDocIdent;
    property TemnrDocIdent: Boolean read FTemnrDocIdent write FTemnrDocIdent;
    // Codigo de identificacao do pais de domicilio fiscal (emissor do NIF) ou de residencia fisica do a...
    property cPais: string read FcPais write FcPais;
  end;

  { TinfoAdqD2211 }

  TinfoAdqD2211 = class(TObject)
  private
    FCPF: string;
    FTemCPF: Boolean;
    FCNPJ: string;
    FTemCNPJ: Boolean;
    FcMun: string;
    FTemcMun: Boolean;
    FTemadqExterior: Boolean;
    FadqExterior: TadqExteriorD2211;
  public
    constructor Create;
    destructor Destroy; override;

    // Numero de inscricao no CPF do adquirente, se pessoa fisica
    property CPF: string read FCPF write FCPF;
    property TemCPF: Boolean read FTemCPF write FTemCPF;
    // Numero de inscricao no CNPJ do adquirente, se pessoa juridica
    property CNPJ: string read FCNPJ write FCNPJ;
    property TemCNPJ: Boolean read FTemCNPJ write FTemCNPJ;
    // Codigo IBGE do municipio do endereco do adquirente, conforme informacoes existentes na base cadas...
    property cMun: string read FcMun write FcMun;
    property TemcMun: Boolean read FTemcMun write FTemcMun;
    property TemadqExterior: Boolean read FTemadqExterior write FTemadqExterior;
    property adqExterior: TadqExteriorD2211 read FadqExterior;
  end;

  { TidePartesD2211 }

  TidePartesD2211 = class(TObject)
  private
    FinfoAdq: TinfoAdqD2211;
  public
    constructor Create;
    destructor Destroy; override;

    property infoAdq: TinfoAdqD2211 read FinfoAdq;
  end;

  { TqualifOperD2211 }

  TqualifOperD2211 = class(TObject)
  private
    FindMoedaEstr: Boolean;
  public
    // Indicador de contrato referenciado em moeda estrangeira
    property indMoedaEstr: Boolean read FindMoedaEstr write FindMoedaEstr;
  end;

  { TgBCD2211 }

  TgBCD2211 = class(TObject)
  private
    FvBCApur: Double;
  public
    // Valor da base de calculo liquida correspondente a operacao, obtido apos a exclusao dos tributos q...
    property vBCApur: Double read FvBCApur write FvBCApur;
  end;

  { TgTributosD2211 }

  TgTributosD2211 = class(TObject)
  private
    FvBCTrib: Double;
    FpIBSMunTrib: Double;
    FvIBSMunTrib: Double;
    FpIBSUFTrib: Double;
    FvIBSUFTrib: Double;
    FpCBSTrib: Double;
    FvCBSTrib: Double;
  public
    // Valor da base de calculo oferecida a tributacao
    property vBCTrib: Double read FvBCTrib write FvBCTrib;
    // Aliquota do IBS municipal incidente sobre a operacao
    property pIBSMunTrib: Double read FpIBSMunTrib write FpIBSMunTrib;
    // Valor do IBS Municipal
    property vIBSMunTrib: Double read FvIBSMunTrib write FvIBSMunTrib;
    // Aliquota do IBS estadual incidente sobre a operacao
    property pIBSUFTrib: Double read FpIBSUFTrib write FpIBSUFTrib;
    // Valor do IBS Estadual
    property vIBSUFTrib: Double read FvIBSUFTrib write FvIBSUFTrib;
    // Aliquota da CBS incidente sobre a operacao
    property pCBSTrib: Double read FpCBSTrib write FpCBSTrib;
    // Valor da CBS
    property vCBSTrib: Double read FvCBSTrib write FvCBSTrib;
  end;

  { TdetOperCollectionItemD2211 }

  TdetOperCollectionItemD2211 = class(TObject)
  private
    Fseq: string;
    FseqRef: string;
    FTemseqRef: Boolean;
    FdhOper: TDateTime;
    FqualifOper: TqualifOperD2211;
    FgBC: TgBCD2211;
    FgTributos: TgTributosD2211;
  public
    constructor Create;
    destructor Destroy; override;

    // Numero sequencial de identificacao da operacao individualizada dentro deste agrupamento
    property seq: string read Fseq write Fseq;
    // Numero sequencial ({seq}) da operacao individualizada de origem registrada anteriormente na DeRE,...
    property seqRef: string read FseqRef write FseqRef;
    property TemseqRef: Boolean read FTemseqRef write FTemseqRef;
    // Data e hora da operacao
    property dhOper: TDateTime read FdhOper write FdhOper;
    property qualifOper: TqualifOperD2211 read FqualifOper;
    property gBC: TgBCD2211 read FgBC;
    property gTributos: TgTributosD2211 read FgTributos;
  end;

  { TdetOperCollectionD2211 }

  TdetOperCollectionD2211 = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TdetOperCollectionItemD2211;
    procedure SetItem(Index: Integer; Value: TdetOperCollectionItemD2211);
  public
    function New: TdetOperCollectionItemD2211;
    property Items[Index: Integer]: TdetOperCollectionItemD2211 read GetItem write SetItem; default;
  end;

  { TdadosOperD2211 }

  TdadosOperD2211 = class(TObject)
  private
    FdetOper: TdetOperCollectionD2211;
  public
    constructor Create;
    destructor Destroy; override;

    property detOper: TdetOperCollectionD2211 read FdetOper;
  end;

  { TgOperD2211 }

  TgOperD2211 = class(TObject)
  private
    FchAgrup: string;
    FcodBC: string;
    FchAgrupRef: string;
    FTemchAgrupRef: Boolean;
    FidePartes: TidePartesD2211;
    FdadosOper: TdadosOperD2211;
  public
    constructor Create;
    destructor Destroy; override;

    // Chave identificadora do agrupamento de operacoes da DeRE. Composta por 50 posicoes alfanumericas...
    property chAgrup: string read FchAgrup write FchAgrup;
    // Codigo identificador da base de calculo, conforme [[Tabela 12  Codigos de Bases de Calculo]]
    property codBC: string read FcodBC write FcodBC;
    // Chave do agrupamento de operacoes de origem registrado anteriormente na DeRE, objeto de cancelame...
    property chAgrupRef: string read FchAgrupRef write FchAgrupRef;
    property TemchAgrupRef: Boolean read FTemchAgrupRef write FTemchAgrupRef;
    property idePartes: TidePartesD2211 read FidePartes;
    property dadosOper: TdadosOperD2211 read FdadosOper;
  end;

  { TinfoOperD2211 }

  TinfoOperD2211 = class(TObject)
  private
    FgOper: TgOperD2211;
  public
    constructor Create;
    destructor Destroy; override;

    property gOper: TgOperD2211 read FgOper;
  end;

  { TevtOperFinanc }

  TevtOperFinanc = class(TDeREEvento)
  private
    FideEvento: TideEventoFin;
    FideContrib: TideContrib;
    FidePeriodo: TidePeriodoApurSub;
    FinfoOper: TinfoOperD2211;
  protected
    function GetTipoEvento: TTipoEventoDeRE; override;
  public
    constructor Create; override;
    destructor Destroy; override;

    property ideEvento: TideEventoFin read FideEvento write FideEvento;
    property ideContrib: TideContrib read FideContrib write FideContrib;
    property idePeriodo: TidePeriodoApurSub read FidePeriodo write FidePeriodo;
    property infoOper: TinfoOperD2211 read FinfoOper write FinfoOper;
  end;

  { TDeRED2211 - documento DeRE do evento D-2211 }

  TDeRED2211 = class(TDeRE)
  private
    FevtOperFinanc: TevtOperFinanc;
  protected
    function GetEvento: TDeREEvento; override;
  public
    constructor Create; override;
    destructor Destroy; override;

    property evtOperFinanc: TevtOperFinanc read FevtOperFinanc write FevtOperFinanc;
  end;

implementation

{ TinfoAdqD2211 }

constructor TinfoAdqD2211.Create;
begin
  inherited Create;
  FadqExterior := TadqExteriorD2211.Create;
end;

destructor TinfoAdqD2211.Destroy;
begin
  FadqExterior.Free;
  inherited Destroy;
end;


{ TidePartesD2211 }

constructor TidePartesD2211.Create;
begin
  inherited Create;
  FinfoAdq := TinfoAdqD2211.Create;
end;

destructor TidePartesD2211.Destroy;
begin
  FinfoAdq.Free;
  inherited Destroy;
end;


{ TdetOperCollectionItemD2211 }

constructor TdetOperCollectionItemD2211.Create;
begin
  inherited Create;
  FqualifOper := TqualifOperD2211.Create;
  FgBC := TgBCD2211.Create;
  FgTributos := TgTributosD2211.Create;
end;

destructor TdetOperCollectionItemD2211.Destroy;
begin
  FqualifOper.Free;
  FgBC.Free;
  FgTributos.Free;
  inherited Destroy;
end;


{ TdetOperCollectionD2211 }

function TdetOperCollectionD2211.GetItem(Index: Integer): TdetOperCollectionItemD2211;
begin
  Result := TdetOperCollectionItemD2211(inherited Items[Index]);
end;

procedure TdetOperCollectionD2211.SetItem(Index: Integer; Value: TdetOperCollectionItemD2211);
begin
  inherited Items[Index] := Value;
end;

function TdetOperCollectionD2211.New: TdetOperCollectionItemD2211;
begin
  Result := TdetOperCollectionItemD2211.Create;
  Add(Result);
end;


{ TdadosOperD2211 }

constructor TdadosOperD2211.Create;
begin
  inherited Create;
  FdetOper := TdetOperCollectionD2211.Create;
end;

destructor TdadosOperD2211.Destroy;
begin
  FdetOper.Free;
  inherited Destroy;
end;


{ TgOperD2211 }

constructor TgOperD2211.Create;
begin
  inherited Create;
  FidePartes := TidePartesD2211.Create;
  FdadosOper := TdadosOperD2211.Create;
end;

destructor TgOperD2211.Destroy;
begin
  FidePartes.Free;
  FdadosOper.Free;
  inherited Destroy;
end;


{ TinfoOperD2211 }

constructor TinfoOperD2211.Create;
begin
  inherited Create;
  FgOper := TgOperD2211.Create;
end;

destructor TinfoOperD2211.Destroy;
begin
  FgOper.Free;
  inherited Destroy;
end;


{ TevtOperFinanc }

constructor TevtOperFinanc.Create;
begin
  inherited Create;
  FideEvento := TideEventoFin.Create;
  FideContrib := TideContrib.Create;
  FidePeriodo := TidePeriodoApurSub.Create;
  FinfoOper := TinfoOperD2211.Create;
end;

destructor TevtOperFinanc.Destroy;
begin
  FideEvento.Free;
  FideContrib.Free;
  FidePeriodo.Free;
  FinfoOper.Free;
  inherited Destroy;
end;

function TevtOperFinanc.GetTipoEvento: TTipoEventoDeRE;
begin
  Result := teOperFinanc;
end;


{ TDeRED2211 }

constructor TDeRED2211.Create;
begin
  inherited Create;
  FevtOperFinanc := TevtOperFinanc.Create;
end;

destructor TDeRED2211.Destroy;
begin
  FevtOperFinanc.Free;
  inherited Destroy;
end;

function TDeRED2211.GetEvento: TDeREEvento;
begin
  Result := FevtOperFinanc;
end;


initialization
  RegistrarDeRE(teOperFinanc, TDeRED2211);

end.
