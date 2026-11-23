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

unit ACBrDeRE.D2231.Classes;

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

  { TadqExteriorD2231 }

  TadqExteriorD2231 = class(TObject)
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

  { TinfoAdqD2231 }

  TinfoAdqD2231 = class(TObject)
  private
    FCPF: string;
    FTemCPF: Boolean;
    FCNPJ: string;
    FTemCNPJ: Boolean;
    FcMun: string;
    FTemcMun: Boolean;
    FTemadqExterior: Boolean;
    FadqExterior: TadqExteriorD2231;
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
    property adqExterior: TadqExteriorD2231 read FadqExterior;
  end;

  { TidePartesD2231 }

  TidePartesD2231 = class(TObject)
  private
    FinfoAdq: TinfoAdqD2231;
  public
    constructor Create;
    destructor Destroy; override;

    property infoAdq: TinfoAdqD2231 read FinfoAdq;
  end;

  { TgBCD2231 }

  TgBCD2231 = class(TObject)
  private
    FvOper: Double;
    FTemvOper: Boolean;
    FvBCApur: Double;
    FTemvBCApur: Boolean;
  public
    // Valor da parcela recebida pelo arrendamento mercantil financeiro, incluindo o valor de tarifa vin...
    property vOper: Double read FvOper write FvOper;
    property TemvOper: Boolean read FTemvOper write FTemvOper;
    // Valor da base de calculo liquida correspondente a operacao, obtido apos a exclusao dos tributos q...
    property vBCApur: Double read FvBCApur write FvBCApur;
    property TemvBCApur: Boolean read FTemvBCApur write FTemvBCApur;
  end;

  { TgTributosD2231 }

  TgTributosD2231 = class(TObject)
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

  { TdetOperCollectionItemD2231 }

  TdetOperCollectionItemD2231 = class(TObject)
  private
    Fseq: string;
    FseqRef: string;
    FTemseqRef: Boolean;
    FdhOper: TDateTime;
    FTemgTributos: Boolean;
    FgBC: TgBCD2231;
    FgTributos: TgTributosD2231;
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
    property TemgTributos: Boolean read FTemgTributos write FTemgTributos;
    property gBC: TgBCD2231 read FgBC;
    property gTributos: TgTributosD2231 read FgTributos;
  end;

  { TdetOperCollectionD2231 }

  TdetOperCollectionD2231 = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TdetOperCollectionItemD2231;
    procedure SetItem(Index: Integer; Value: TdetOperCollectionItemD2231);
  public
    function New: TdetOperCollectionItemD2231;
    property Items[Index: Integer]: TdetOperCollectionItemD2231 read GetItem write SetItem; default;
  end;

  { TdadosOperD2231 }

  TdadosOperD2231 = class(TObject)
  private
    FdetOper: TdetOperCollectionD2231;
  public
    constructor Create;
    destructor Destroy; override;

    property detOper: TdetOperCollectionD2231 read FdetOper;
  end;

  { TgOperD2231 }

  TgOperD2231 = class(TObject)
  private
    FchAgrup: string;
    FcodBC: string;
    FchAgrupRef: string;
    FTemchAgrupRef: Boolean;
    FidePartes: TidePartesD2231;
    FdadosOper: TdadosOperD2231;
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
    property idePartes: TidePartesD2231 read FidePartes;
    property dadosOper: TdadosOperD2231 read FdadosOper;
  end;

  { TinfoOperD2231 }

  TinfoOperD2231 = class(TObject)
  private
    FgOper: TgOperD2231;
  public
    constructor Create;
    destructor Destroy; override;

    property gOper: TgOperD2231 read FgOper;
  end;

  { TevtArrendMerc }

  TevtArrendMerc = class(TDeREEvento)
  private
    FideEvento: TideEventoFin;
    FideContrib: TideContrib;
    FidePeriodo: TidePeriodoApurSub;
    FinfoOper: TinfoOperD2231;
  protected
    function GetTipoEvento: TTipoEventoDeRE; override;
  public
    constructor Create; override;
    destructor Destroy; override;

    property ideEvento: TideEventoFin read FideEvento write FideEvento;
    property ideContrib: TideContrib read FideContrib write FideContrib;
    property idePeriodo: TidePeriodoApurSub read FidePeriodo write FidePeriodo;
    property infoOper: TinfoOperD2231 read FinfoOper write FinfoOper;
  end;

  { TDeRED2231 - documento DeRE do evento D-2231 }

  TDeRED2231 = class(TDeRE)
  private
    FevtArrendMerc: TevtArrendMerc;
  protected
    function GetEvento: TDeREEvento; override;
  public
    constructor Create; override;
    destructor Destroy; override;

    property evtArrendMerc: TevtArrendMerc read FevtArrendMerc write FevtArrendMerc;
  end;

implementation

{ TinfoAdqD2231 }

constructor TinfoAdqD2231.Create;
begin
  inherited Create;
  FadqExterior := TadqExteriorD2231.Create;
end;

destructor TinfoAdqD2231.Destroy;
begin
  FadqExterior.Free;
  inherited Destroy;
end;


{ TidePartesD2231 }

constructor TidePartesD2231.Create;
begin
  inherited Create;
  FinfoAdq := TinfoAdqD2231.Create;
end;

destructor TidePartesD2231.Destroy;
begin
  FinfoAdq.Free;
  inherited Destroy;
end;


{ TdetOperCollectionItemD2231 }

constructor TdetOperCollectionItemD2231.Create;
begin
  inherited Create;
  FgBC := TgBCD2231.Create;
  FgTributos := TgTributosD2231.Create;
end;

destructor TdetOperCollectionItemD2231.Destroy;
begin
  FgBC.Free;
  FgTributos.Free;
  inherited Destroy;
end;


{ TdetOperCollectionD2231 }

function TdetOperCollectionD2231.GetItem(Index: Integer): TdetOperCollectionItemD2231;
begin
  Result := TdetOperCollectionItemD2231(inherited Items[Index]);
end;

procedure TdetOperCollectionD2231.SetItem(Index: Integer; Value: TdetOperCollectionItemD2231);
begin
  inherited Items[Index] := Value;
end;

function TdetOperCollectionD2231.New: TdetOperCollectionItemD2231;
begin
  Result := TdetOperCollectionItemD2231.Create;
  Add(Result);
end;


{ TdadosOperD2231 }

constructor TdadosOperD2231.Create;
begin
  inherited Create;
  FdetOper := TdetOperCollectionD2231.Create;
end;

destructor TdadosOperD2231.Destroy;
begin
  FdetOper.Free;
  inherited Destroy;
end;


{ TgOperD2231 }

constructor TgOperD2231.Create;
begin
  inherited Create;
  FidePartes := TidePartesD2231.Create;
  FdadosOper := TdadosOperD2231.Create;
end;

destructor TgOperD2231.Destroy;
begin
  FidePartes.Free;
  FdadosOper.Free;
  inherited Destroy;
end;


{ TinfoOperD2231 }

constructor TinfoOperD2231.Create;
begin
  inherited Create;
  FgOper := TgOperD2231.Create;
end;

destructor TinfoOperD2231.Destroy;
begin
  FgOper.Free;
  inherited Destroy;
end;


{ TevtArrendMerc }

constructor TevtArrendMerc.Create;
begin
  inherited Create;
  FideEvento := TideEventoFin.Create;
  FideContrib := TideContrib.Create;
  FidePeriodo := TidePeriodoApurSub.Create;
  FinfoOper := TinfoOperD2231.Create;
end;

destructor TevtArrendMerc.Destroy;
begin
  FideEvento.Free;
  FideContrib.Free;
  FidePeriodo.Free;
  FinfoOper.Free;
  inherited Destroy;
end;

function TevtArrendMerc.GetTipoEvento: TTipoEventoDeRE;
begin
  Result := teArrendMerc;
end;


{ TDeRED2231 }

constructor TDeRED2231.Create;
begin
  inherited Create;
  FevtArrendMerc := TevtArrendMerc.Create;
end;

destructor TDeRED2231.Destroy;
begin
  FevtArrendMerc.Free;
  inherited Destroy;
end;

function TDeRED2231.GetEvento: TDeREEvento;
begin
  Result := FevtArrendMerc;
end;


initialization
  RegistrarDeRE(teArrendMerc, TDeRED2231);

end.
