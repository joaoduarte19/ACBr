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

unit ACBrDeRE.D2221.Classes;

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

  { TadqExteriorD2221 }

  TadqExteriorD2221 = class(TObject)
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

  { TinfoAdqD2221 }

  TinfoAdqD2221 = class(TObject)
  private
    FCPF: string;
    FTemCPF: Boolean;
    FCNPJ: string;
    FTemCNPJ: Boolean;
    FcMun: string;
    FTemcMun: Boolean;
    FTemadqExterior: Boolean;
    FadqExterior: TadqExteriorD2221;
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
    property adqExterior: TadqExteriorD2221 read FadqExterior;
  end;

  { TidePartesD2221 }

  TidePartesD2221 = class(TObject)
  private
    FinfoAdq: TinfoAdqD2221;
  public
    constructor Create;
    destructor Destroy; override;

    property infoAdq: TinfoAdqD2221 read FinfoAdq;
  end;

  { TqualifOperD2221 }

  TqualifOperD2221 = class(TObject)
  private
    FindMoedaEstr: Boolean;
  public
    // Indicador de contrato referenciado em moeda estrangeira
    property indMoedaEstr: Boolean read FindMoedaEstr write FindMoedaEstr;
  end;

  { TgBCD2221 }

  TgBCD2221 = class(TObject)
  private
    FvBCApur: Double;
  public
    // Valor da base de calculo liquida correspondente a operacao, obtido apos a exclusao dos tributos q...
    property vBCApur: Double read FvBCApur write FvBCApur;
  end;

  { TgTributosD2221 }

  TgTributosD2221 = class(TObject)
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

  { TdetOperCollectionItemD2221 }

  TdetOperCollectionItemD2221 = class(TObject)
  private
    Fseq: string;
    FseqRef: string;
    FTemseqRef: Boolean;
    FdhOper: TDateTime;
    FTemqualifOper: Boolean;
    FqualifOper: TqualifOperD2221;
    FgBC: TgBCD2221;
    FgTributos: TgTributosD2221;
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
    property TemqualifOper: Boolean read FTemqualifOper write FTemqualifOper;
    property qualifOper: TqualifOperD2221 read FqualifOper;
    property gBC: TgBCD2221 read FgBC;
    property gTributos: TgTributosD2221 read FgTributos;
  end;

  { TdetOperCollectionD2221 }

  TdetOperCollectionD2221 = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TdetOperCollectionItemD2221;
    procedure SetItem(Index: Integer; Value: TdetOperCollectionItemD2221);
  public
    function New: TdetOperCollectionItemD2221;
    property Items[Index: Integer]: TdetOperCollectionItemD2221 read GetItem write SetItem; default;
  end;

  { TdadosOperD2221 }

  TdadosOperD2221 = class(TObject)
  private
    FdetOper: TdetOperCollectionD2221;
  public
    constructor Create;
    destructor Destroy; override;

    property detOper: TdetOperCollectionD2221 read FdetOper;
  end;

  { TgOperD2221 }

  TgOperD2221 = class(TObject)
  private
    FchAgrup: string;
    FcodBC: string;
    FchAgrupRef: string;
    FTemchAgrupRef: Boolean;
    FidePartes: TidePartesD2221;
    FdadosOper: TdadosOperD2221;
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
    property idePartes: TidePartesD2221 read FidePartes;
    property dadosOper: TdadosOperD2221 read FdadosOper;
  end;

  { TinfoOperD2221 }

  TinfoOperD2221 = class(TObject)
  private
    FgOper: TgOperD2221;
  public
    constructor Create;
    destructor Destroy; override;

    property gOper: TgOperD2221 read FgOper;
  end;

  { TevtAntecReceb }

  TevtAntecReceb = class(TDeREEvento)
  private
    FideEvento: TideEventoFin;
    FideContrib: TideContrib;
    FidePeriodo: TidePeriodoApurSub;
    FinfoOper: TinfoOperD2221;
  protected
    function GetTipoEvento: TTipoEventoDeRE; override;
  public
    constructor Create; override;
    destructor Destroy; override;

    property ideEvento: TideEventoFin read FideEvento write FideEvento;
    property ideContrib: TideContrib read FideContrib write FideContrib;
    property idePeriodo: TidePeriodoApurSub read FidePeriodo write FidePeriodo;
    property infoOper: TinfoOperD2221 read FinfoOper write FinfoOper;
  end;

  { TDeRED2221 - documento DeRE do evento D-2221 }

  TDeRED2221 = class(TDeRE)
  private
    FevtAntecReceb: TevtAntecReceb;
  protected
    function GetEvento: TDeREEvento; override;
  public
    constructor Create; override;
    destructor Destroy; override;

    property evtAntecReceb: TevtAntecReceb read FevtAntecReceb write FevtAntecReceb;
  end;

implementation

{ TinfoAdqD2221 }

constructor TinfoAdqD2221.Create;
begin
  inherited Create;
  FadqExterior := TadqExteriorD2221.Create;
end;

destructor TinfoAdqD2221.Destroy;
begin
  FadqExterior.Free;
  inherited Destroy;
end;


{ TidePartesD2221 }

constructor TidePartesD2221.Create;
begin
  inherited Create;
  FinfoAdq := TinfoAdqD2221.Create;
end;

destructor TidePartesD2221.Destroy;
begin
  FinfoAdq.Free;
  inherited Destroy;
end;


{ TdetOperCollectionItemD2221 }

constructor TdetOperCollectionItemD2221.Create;
begin
  inherited Create;
  FqualifOper := TqualifOperD2221.Create;
  FgBC := TgBCD2221.Create;
  FgTributos := TgTributosD2221.Create;
end;

destructor TdetOperCollectionItemD2221.Destroy;
begin
  FqualifOper.Free;
  FgBC.Free;
  FgTributos.Free;
  inherited Destroy;
end;


{ TdetOperCollectionD2221 }

function TdetOperCollectionD2221.GetItem(Index: Integer): TdetOperCollectionItemD2221;
begin
  Result := TdetOperCollectionItemD2221(inherited Items[Index]);
end;

procedure TdetOperCollectionD2221.SetItem(Index: Integer; Value: TdetOperCollectionItemD2221);
begin
  inherited Items[Index] := Value;
end;

function TdetOperCollectionD2221.New: TdetOperCollectionItemD2221;
begin
  Result := TdetOperCollectionItemD2221.Create;
  Add(Result);
end;


{ TdadosOperD2221 }

constructor TdadosOperD2221.Create;
begin
  inherited Create;
  FdetOper := TdetOperCollectionD2221.Create;
end;

destructor TdadosOperD2221.Destroy;
begin
  FdetOper.Free;
  inherited Destroy;
end;


{ TgOperD2221 }

constructor TgOperD2221.Create;
begin
  inherited Create;
  FidePartes := TidePartesD2221.Create;
  FdadosOper := TdadosOperD2221.Create;
end;

destructor TgOperD2221.Destroy;
begin
  FidePartes.Free;
  FdadosOper.Free;
  inherited Destroy;
end;


{ TinfoOperD2221 }

constructor TinfoOperD2221.Create;
begin
  inherited Create;
  FgOper := TgOperD2221.Create;
end;

destructor TinfoOperD2221.Destroy;
begin
  FgOper.Free;
  inherited Destroy;
end;


{ TevtAntecReceb }

constructor TevtAntecReceb.Create;
begin
  inherited Create;
  FideEvento := TideEventoFin.Create;
  FideContrib := TideContrib.Create;
  FidePeriodo := TidePeriodoApurSub.Create;
  FinfoOper := TinfoOperD2221.Create;
end;

destructor TevtAntecReceb.Destroy;
begin
  FideEvento.Free;
  FideContrib.Free;
  FidePeriodo.Free;
  FinfoOper.Free;
  inherited Destroy;
end;

function TevtAntecReceb.GetTipoEvento: TTipoEventoDeRE;
begin
  Result := teAntecReceb;
end;


{ TDeRED2221 }

constructor TDeRED2221.Create;
begin
  inherited Create;
  FevtAntecReceb := TevtAntecReceb.Create;
end;

destructor TDeRED2221.Destroy;
begin
  FevtAntecReceb.Free;
  inherited Destroy;
end;

function TDeRED2221.GetEvento: TDeREEvento;
begin
  Result := FevtAntecReceb;
end;


initialization
  RegistrarDeRE(teAntecReceb, TDeRED2221);

end.
