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

unit ACBrDeRE.D2252.Classes;

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

  { TadqExteriorD2252 }

  TadqExteriorD2252 = class(TObject)
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

  { TinfoAdqD2252 }

  TinfoAdqD2252 = class(TObject)
  private
    FCPF: string;
    FTemCPF: Boolean;
    FCNPJ: string;
    FTemCNPJ: Boolean;
    FcMun: string;
    FTemcMun: Boolean;
    FTemadqExterior: Boolean;
    FadqExterior: TadqExteriorD2252;
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
    property adqExterior: TadqExteriorD2252 read FadqExterior;
  end;

  { TinfoPDVD2252 }

  TinfoPDVD2252 = class(TObject)
  private
    FCPFPDV: string;
    FTemCPFPDV: Boolean;
    FCNPJPDV: string;
    FTemCNPJPDV: Boolean;
  public
    // Numero de inscricao no CPF do ponto de venda
    property CPFPDV: string read FCPFPDV write FCPFPDV;
    property TemCPFPDV: Boolean read FTemCPFPDV write FTemCPFPDV;
    // Numero de inscricao no CNPJ do ponto de venda
    property CNPJPDV: string read FCNPJPDV write FCNPJPDV;
    property TemCNPJPDV: Boolean read FTemCNPJPDV write FTemCNPJPDV;
  end;

  { TidePartesD2252 }

  TidePartesD2252 = class(TObject)
  private
    FTeminfoPDV: Boolean;
    FinfoAdq: TinfoAdqD2252;
    FinfoPDV: TinfoPDVD2252;
  public
    constructor Create;
    destructor Destroy; override;

    property TeminfoPDV: Boolean read FTeminfoPDV write FTeminfoPDV;
    property infoAdq: TinfoAdqD2252 read FinfoAdq;
    property infoPDV: TinfoPDVD2252 read FinfoPDV;
  end;

  { TgBCD2252 }

  TgBCD2252 = class(TObject)
  private
    FvBCApur: Double;
  public
    // Valor da base de calculo liquida correspondente a operacao, obtido apos a exclusao dos tributos q...
    property vBCApur: Double read FvBCApur write FvBCApur;
  end;

  { TgTributosD2252 }

  TgTributosD2252 = class(TObject)
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

  { TdetOperCollectionItemD2252 }

  TdetOperCollectionItemD2252 = class(TObject)
  private
    Fseq: string;
    FseqRef: string;
    FTemseqRef: Boolean;
    FdhOper: TDateTime;
    FgBC: TgBCD2252;
    FgTributos: TgTributosD2252;
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
    property gBC: TgBCD2252 read FgBC;
    property gTributos: TgTributosD2252 read FgTributos;
  end;

  { TdetOperCollectionD2252 }

  TdetOperCollectionD2252 = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TdetOperCollectionItemD2252;
    procedure SetItem(Index: Integer; Value: TdetOperCollectionItemD2252);
  public
    function New: TdetOperCollectionItemD2252;
    property Items[Index: Integer]: TdetOperCollectionItemD2252 read GetItem write SetItem; default;
  end;

  { TdadosOperD2252 }

  TdadosOperD2252 = class(TObject)
  private
    FdetOper: TdetOperCollectionD2252;
  public
    constructor Create;
    destructor Destroy; override;

    property detOper: TdetOperCollectionD2252 read FdetOper;
  end;

  { TgOperD2252 }

  TgOperD2252 = class(TObject)
  private
    FchAgrup: string;
    FcodBC: string;
    FchAgrupRef: string;
    FTemchAgrupRef: Boolean;
    FidePartes: TidePartesD2252;
    FdadosOper: TdadosOperD2252;
  public
    constructor Create;
    destructor Destroy; override;

    // Chave identificadora do agrupamento de operacoes da DeRE. Composta por 50 posicoes alfanumericas...
    property chAgrup: string read FchAgrup write FchAgrup;
    // Codigo identificador da base de calculo, conforme [[Tabela 12  Codigos de Bases de Calculo]]
    property codBC: string read FcodBC write FcodBC;
    // Chave do agrupamento de operacoes de origem registrado anteriormente na DeRE, objeto de deducao e...
    property chAgrupRef: string read FchAgrupRef write FchAgrupRef;
    property TemchAgrupRef: Boolean read FTemchAgrupRef write FTemchAgrupRef;
    property idePartes: TidePartesD2252 read FidePartes;
    property dadosOper: TdadosOperD2252 read FdadosOper;
  end;

  { TinfoOperD2252 }

  TinfoOperD2252 = class(TObject)
  private
    FgOper: TgOperD2252;
  public
    constructor Create;
    destructor Destroy; override;

    property gOper: TgOperD2252 read FgOper;
  end;

  { TevtSegElemSCob }

  TevtSegElemSCob = class(TDeREEvento)
  private
    FideEvento: TideEventoFin;
    FideContrib: TideContrib;
    FidePeriodo: TidePeriodoApurSub;
    FinfoOper: TinfoOperD2252;
  protected
    function GetTipoEvento: TTipoEventoDeRE; override;
  public
    constructor Create; override;
    destructor Destroy; override;

    property ideEvento: TideEventoFin read FideEvento write FideEvento;
    property ideContrib: TideContrib read FideContrib write FideContrib;
    property idePeriodo: TidePeriodoApurSub read FidePeriodo write FidePeriodo;
    property infoOper: TinfoOperD2252 read FinfoOper write FinfoOper;
  end;

  { TDeRED2252 - documento DeRE do evento D-2252 }

  TDeRED2252 = class(TDeRE)
  private
    FevtSegElemSCob: TevtSegElemSCob;
  protected
    function GetEvento: TDeREEvento; override;
  public
    constructor Create; override;
    destructor Destroy; override;

    property evtSegElemSCob: TevtSegElemSCob read FevtSegElemSCob write FevtSegElemSCob;
  end;

implementation

{ TinfoAdqD2252 }

constructor TinfoAdqD2252.Create;
begin
  inherited Create;
  FadqExterior := TadqExteriorD2252.Create;
end;

destructor TinfoAdqD2252.Destroy;
begin
  FadqExterior.Free;
  inherited Destroy;
end;


{ TidePartesD2252 }

constructor TidePartesD2252.Create;
begin
  inherited Create;
  FinfoAdq := TinfoAdqD2252.Create;
  FinfoPDV := TinfoPDVD2252.Create;
end;

destructor TidePartesD2252.Destroy;
begin
  FinfoAdq.Free;
  FinfoPDV.Free;
  inherited Destroy;
end;


{ TdetOperCollectionItemD2252 }

constructor TdetOperCollectionItemD2252.Create;
begin
  inherited Create;
  FgBC := TgBCD2252.Create;
  FgTributos := TgTributosD2252.Create;
end;

destructor TdetOperCollectionItemD2252.Destroy;
begin
  FgBC.Free;
  FgTributos.Free;
  inherited Destroy;
end;


{ TdetOperCollectionD2252 }

function TdetOperCollectionD2252.GetItem(Index: Integer): TdetOperCollectionItemD2252;
begin
  Result := TdetOperCollectionItemD2252(inherited Items[Index]);
end;

procedure TdetOperCollectionD2252.SetItem(Index: Integer; Value: TdetOperCollectionItemD2252);
begin
  inherited Items[Index] := Value;
end;

function TdetOperCollectionD2252.New: TdetOperCollectionItemD2252;
begin
  Result := TdetOperCollectionItemD2252.Create;
  Add(Result);
end;


{ TdadosOperD2252 }

constructor TdadosOperD2252.Create;
begin
  inherited Create;
  FdetOper := TdetOperCollectionD2252.Create;
end;

destructor TdadosOperD2252.Destroy;
begin
  FdetOper.Free;
  inherited Destroy;
end;


{ TgOperD2252 }

constructor TgOperD2252.Create;
begin
  inherited Create;
  FidePartes := TidePartesD2252.Create;
  FdadosOper := TdadosOperD2252.Create;
end;

destructor TgOperD2252.Destroy;
begin
  FidePartes.Free;
  FdadosOper.Free;
  inherited Destroy;
end;


{ TinfoOperD2252 }

constructor TinfoOperD2252.Create;
begin
  inherited Create;
  FgOper := TgOperD2252.Create;
end;

destructor TinfoOperD2252.Destroy;
begin
  FgOper.Free;
  inherited Destroy;
end;


{ TevtSegElemSCob }

constructor TevtSegElemSCob.Create;
begin
  inherited Create;
  FideEvento := TideEventoFin.Create;
  FideContrib := TideContrib.Create;
  FidePeriodo := TidePeriodoApurSub.Create;
  FinfoOper := TinfoOperD2252.Create;
end;

destructor TevtSegElemSCob.Destroy;
begin
  FideEvento.Free;
  FideContrib.Free;
  FidePeriodo.Free;
  FinfoOper.Free;
  inherited Destroy;
end;

function TevtSegElemSCob.GetTipoEvento: TTipoEventoDeRE;
begin
  Result := teSegElemSCob;
end;


{ TDeRED2252 }

constructor TDeRED2252.Create;
begin
  inherited Create;
  FevtSegElemSCob := TevtSegElemSCob.Create;
end;

destructor TDeRED2252.Destroy;
begin
  FevtSegElemSCob.Free;
  inherited Destroy;
end;

function TDeRED2252.GetEvento: TDeREEvento;
begin
  Result := FevtSegElemSCob;
end;


initialization
  RegistrarDeRE(teSegElemSCob, TDeRED2252);

end.
