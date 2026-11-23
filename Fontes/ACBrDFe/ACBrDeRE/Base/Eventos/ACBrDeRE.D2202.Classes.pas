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

unit ACBrDeRE.D2202.Classes;

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

  { TadqExteriorD2202 }

  TadqExteriorD2202 = class(TObject)
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

  { TinfoAdqD2202 }

  TinfoAdqD2202 = class(TObject)
  private
    FCPF: string;
    FTemCPF: Boolean;
    FCNPJ: string;
    FTemCNPJ: Boolean;
    FcMun: string;
    FTemcMun: Boolean;
    FTemadqExterior: Boolean;
    FadqExterior: TadqExteriorD2202;
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
    property adqExterior: TadqExteriorD2202 read FadqExterior;
  end;

  { TidePartesD2202 }

  TidePartesD2202 = class(TObject)
  private
    FinfoAdq: TinfoAdqD2202;
  public
    constructor Create;
    destructor Destroy; override;

    property infoAdq: TinfoAdqD2202 read FinfoAdq;
  end;

  { TqualifOperD2202 }

  TqualifOperD2202 = class(TObject)
  private
    FindPresenc: Boolean;
    FTemindPresenc: Boolean;
    FcMunOper: string;
    FTemcMunOper: Boolean;
  public
    // Indicador que define se o servico prestado foi fruido presencialmente por pessoa fisica
    property indPresenc: Boolean read FindPresenc write FindPresenc;
    property TemindPresenc: Boolean read FTemindPresenc write FTemindPresenc;
    // Codigo do municipio correspondente ao local do estabelecimento onde o servico foi prestado, confo...
    property cMunOper: string read FcMunOper write FcMunOper;
    property TemcMunOper: Boolean read FTemcMunOper write FTemcMunOper;
  end;

  { TgBCD2202 }

  TgBCD2202 = class(TObject)
  private
    FvBCApur: Double;
  public
    // Valor da base de calculo liquida correspondente a operacao, obtido apos a exclusao dos tributos q...
    property vBCApur: Double read FvBCApur write FvBCApur;
  end;

  { TgTributosD2202 }

  TgTributosD2202 = class(TObject)
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

  { TdetOperCollectionItemD2202 }

  TdetOperCollectionItemD2202 = class(TObject)
  private
    Fseq: string;
    FseqRef: string;
    FTemseqRef: Boolean;
    FdhOper: TDateTime;
    FTemqualifOper: Boolean;
    FqualifOper: TqualifOperD2202;
    FgBC: TgBCD2202;
    FgTributos: TgTributosD2202;
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
    property qualifOper: TqualifOperD2202 read FqualifOper;
    property gBC: TgBCD2202 read FgBC;
    property gTributos: TgTributosD2202 read FgTributos;
  end;

  { TdetOperCollectionD2202 }

  TdetOperCollectionD2202 = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TdetOperCollectionItemD2202;
    procedure SetItem(Index: Integer; Value: TdetOperCollectionItemD2202);
  public
    function New: TdetOperCollectionItemD2202;
    property Items[Index: Integer]: TdetOperCollectionItemD2202 read GetItem write SetItem; default;
  end;

  { TdadosOperD2202 }

  TdadosOperD2202 = class(TObject)
  private
    FdetOper: TdetOperCollectionD2202;
  public
    constructor Create;
    destructor Destroy; override;

    property detOper: TdetOperCollectionD2202 read FdetOper;
  end;

  { TgOperD2202 }

  TgOperD2202 = class(TObject)
  private
    FchAgrup: string;
    FcodBC: string;
    FchAgrupRef: string;
    FTemchAgrupRef: Boolean;
    FidePartes: TidePartesD2202;
    FdadosOper: TdadosOperD2202;
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
    property idePartes: TidePartesD2202 read FidePartes;
    property dadosOper: TdadosOperD2202 read FdadosOper;
  end;

  { TinfoOperD2202 }

  TinfoOperD2202 = class(TObject)
  private
    FgOper: TgOperD2202;
  public
    constructor Create;
    destructor Destroy; override;

    property gOper: TgOperD2202 read FgOper;
  end;

  { TevtServRemTarifa }

  TevtServRemTarifa = class(TDeREEvento)
  private
    FideEvento: TideEventoFin;
    FideContrib: TideContrib;
    FidePeriodo: TidePeriodoApurSub;
    FinfoOper: TinfoOperD2202;
  protected
    function GetTipoEvento: TTipoEventoDeRE; override;
  public
    constructor Create; override;
    destructor Destroy; override;

    property ideEvento: TideEventoFin read FideEvento write FideEvento;
    property ideContrib: TideContrib read FideContrib write FideContrib;
    property idePeriodo: TidePeriodoApurSub read FidePeriodo write FidePeriodo;
    property infoOper: TinfoOperD2202 read FinfoOper write FinfoOper;
  end;

  { TDeRED2202 - documento DeRE do evento D-2202 }

  TDeRED2202 = class(TDeRE)
  private
    FevtServRemTarifa: TevtServRemTarifa;
  protected
    function GetEvento: TDeREEvento; override;
  public
    constructor Create; override;
    destructor Destroy; override;

    property evtServRemTarifa: TevtServRemTarifa read FevtServRemTarifa write FevtServRemTarifa;
  end;

implementation

{ TinfoAdqD2202 }

constructor TinfoAdqD2202.Create;
begin
  inherited Create;
  FadqExterior := TadqExteriorD2202.Create;
end;

destructor TinfoAdqD2202.Destroy;
begin
  FadqExterior.Free;
  inherited Destroy;
end;


{ TidePartesD2202 }

constructor TidePartesD2202.Create;
begin
  inherited Create;
  FinfoAdq := TinfoAdqD2202.Create;
end;

destructor TidePartesD2202.Destroy;
begin
  FinfoAdq.Free;
  inherited Destroy;
end;


{ TdetOperCollectionItemD2202 }

constructor TdetOperCollectionItemD2202.Create;
begin
  inherited Create;
  FqualifOper := TqualifOperD2202.Create;
  FgBC := TgBCD2202.Create;
  FgTributos := TgTributosD2202.Create;
end;

destructor TdetOperCollectionItemD2202.Destroy;
begin
  FqualifOper.Free;
  FgBC.Free;
  FgTributos.Free;
  inherited Destroy;
end;


{ TdetOperCollectionD2202 }

function TdetOperCollectionD2202.GetItem(Index: Integer): TdetOperCollectionItemD2202;
begin
  Result := TdetOperCollectionItemD2202(inherited Items[Index]);
end;

procedure TdetOperCollectionD2202.SetItem(Index: Integer; Value: TdetOperCollectionItemD2202);
begin
  inherited Items[Index] := Value;
end;

function TdetOperCollectionD2202.New: TdetOperCollectionItemD2202;
begin
  Result := TdetOperCollectionItemD2202.Create;
  Add(Result);
end;


{ TdadosOperD2202 }

constructor TdadosOperD2202.Create;
begin
  inherited Create;
  FdetOper := TdetOperCollectionD2202.Create;
end;

destructor TdadosOperD2202.Destroy;
begin
  FdetOper.Free;
  inherited Destroy;
end;


{ TgOperD2202 }

constructor TgOperD2202.Create;
begin
  inherited Create;
  FidePartes := TidePartesD2202.Create;
  FdadosOper := TdadosOperD2202.Create;
end;

destructor TgOperD2202.Destroy;
begin
  FidePartes.Free;
  FdadosOper.Free;
  inherited Destroy;
end;


{ TinfoOperD2202 }

constructor TinfoOperD2202.Create;
begin
  inherited Create;
  FgOper := TgOperD2202.Create;
end;

destructor TinfoOperD2202.Destroy;
begin
  FgOper.Free;
  inherited Destroy;
end;


{ TevtServRemTarifa }

constructor TevtServRemTarifa.Create;
begin
  inherited Create;
  FideEvento := TideEventoFin.Create;
  FideContrib := TideContrib.Create;
  FidePeriodo := TidePeriodoApurSub.Create;
  FinfoOper := TinfoOperD2202.Create;
end;

destructor TevtServRemTarifa.Destroy;
begin
  FideEvento.Free;
  FideContrib.Free;
  FidePeriodo.Free;
  FinfoOper.Free;
  inherited Destroy;
end;

function TevtServRemTarifa.GetTipoEvento: TTipoEventoDeRE;
begin
  Result := teServRemTarifa;
end;


{ TDeRED2202 }

constructor TDeRED2202.Create;
begin
  inherited Create;
  FevtServRemTarifa := TevtServRemTarifa.Create;
end;

destructor TDeRED2202.Destroy;
begin
  FevtServRemTarifa.Free;
  inherited Destroy;
end;

function TDeRED2202.GetEvento: TDeREEvento;
begin
  Result := FevtServRemTarifa;
end;


initialization
  RegistrarDeRE(teServRemTarifa, TDeRED2202);

end.
