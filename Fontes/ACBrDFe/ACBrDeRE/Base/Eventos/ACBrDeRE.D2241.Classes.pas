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

unit ACBrDeRE.D2241.Classes;

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

  { TadqExteriorD2241 }

  TadqExteriorD2241 = class(TObject)
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

  { TinfoAdqD2241 }

  TinfoAdqD2241 = class(TObject)
  private
    FCPF: string;
    FTemCPF: Boolean;
    FCNPJ: string;
    FTemCNPJ: Boolean;
    FcMun: string;
    FTemcMun: Boolean;
    FTemadqExterior: Boolean;
    FadqExterior: TadqExteriorD2241;
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
    property adqExterior: TadqExteriorD2241 read FadqExterior;
  end;

  { TidePartesD2241 }

  TidePartesD2241 = class(TObject)
  private
    FinfoAdq: TinfoAdqD2241;
  public
    constructor Create;
    destructor Destroy; override;

    property infoAdq: TinfoAdqD2241 read FinfoAdq;
  end;

  { TgVOperD2241 }

  TgVOperD2241 = class(TObject)
  private
  public
  end;

  { TgDeducoesD2241 }

  TgDeducoesD2241 = class(TObject)
  private
    FvISSQNProp: Double;
    FTemvISSQNProp: Boolean;
    FvISSQNOutro: Double;
    FTemvISSQNOutro: Boolean;
    FvPisCofins: Double;
    FTemvPisCofins: Boolean;
    FvSomaDeducoes: Double;
    FTemvSomaDeducoes: Boolean;
  public
    // Informar o valor do ISSQN devido sobre a operacao propria
    property vISSQNProp: Double read FvISSQNProp write FvISSQNProp;
    property TemvISSQNProp: Boolean read FTemvISSQNProp write FTemvISSQNProp;
    // Informar o valor do ISSQN devido sobre operacoes de outros participantes de arranjo
    property vISSQNOutro: Double read FvISSQNOutro write FvISSQNOutro;
    property TemvISSQNOutro: Boolean read FTemvISSQNOutro write FTemvISSQNOutro;
    // Valor do PIS Cofins tributado na operacao
    property vPisCofins: Double read FvPisCofins write FvPisCofins;
    property TemvPisCofins: Boolean read FTemvPisCofins write FTemvPisCofins;
    // Valor total das deducoes
    property vSomaDeducoes: Double read FvSomaDeducoes write FvSomaDeducoes;
    property TemvSomaDeducoes: Boolean read FTemvSomaDeducoes write FTemvSomaDeducoes;
  end;

  { TdetBCD2241 }

  TdetBCD2241 = class(TObject)
  private
    FvBCApur: Double;
  public
    // Base de Calculo do IBS/CBS
    property vBCApur: Double read FvBCApur write FvBCApur;
  end;

  { TgBCD2241 }

  TgBCD2241 = class(TObject)
  private
    FTemgDeducoes: Boolean;
    FgVOper: TgVOperD2241;
    FgDeducoes: TgDeducoesD2241;
    FdetBC: TdetBCD2241;
  public
    constructor Create;
    destructor Destroy; override;

    property TemgDeducoes: Boolean read FTemgDeducoes write FTemgDeducoes;
    property gVOper: TgVOperD2241 read FgVOper;
    property gDeducoes: TgDeducoesD2241 read FgDeducoes;
    property detBC: TdetBCD2241 read FdetBC;
  end;

  { TgTributosD2241 }

  TgTributosD2241 = class(TObject)
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

  { TdetOperCollectionItemD2241 }

  TdetOperCollectionItemD2241 = class(TObject)
  private
    Fseq: string;
    FseqRef: string;
    FTemseqRef: Boolean;
    FdhOper: TDateTime;
    FgBC: TgBCD2241;
    FgTributos: TgTributosD2241;
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
    property gBC: TgBCD2241 read FgBC;
    property gTributos: TgTributosD2241 read FgTributos;
  end;

  { TdetOperCollectionD2241 }

  TdetOperCollectionD2241 = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TdetOperCollectionItemD2241;
    procedure SetItem(Index: Integer; Value: TdetOperCollectionItemD2241);
  public
    function New: TdetOperCollectionItemD2241;
    property Items[Index: Integer]: TdetOperCollectionItemD2241 read GetItem write SetItem; default;
  end;

  { TdadosOperD2241 }

  TdadosOperD2241 = class(TObject)
  private
    FdetOper: TdetOperCollectionD2241;
  public
    constructor Create;
    destructor Destroy; override;

    property detOper: TdetOperCollectionD2241 read FdetOper;
  end;

  { TgOperD2241 }

  TgOperD2241 = class(TObject)
  private
    FchAgrup: string;
    FcodBC: string;
    FchAgrupRef: string;
    FTemchAgrupRef: Boolean;
    FidePartes: TidePartesD2241;
    FdadosOper: TdadosOperD2241;
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
    property idePartes: TidePartesD2241 read FidePartes;
    property dadosOper: TdadosOperD2241 read FdadosOper;
  end;

  { TinfoOperD2241 }

  TinfoOperD2241 = class(TObject)
  private
    FgOper: TgOperD2241;
  public
    constructor Create;
    destructor Destroy; override;

    property gOper: TgOperD2241 read FgOper;
  end;

  { TevtArranjoCredDest }

  TevtArranjoCredDest = class(TDeREEvento)
  private
    FideEvento: TideEventoFin;
    FideContrib: TideContrib;
    FidePeriodo: TidePeriodoApurSub;
    FinfoOper: TinfoOperD2241;
  protected
    function GetTipoEvento: TTipoEventoDeRE; override;
  public
    constructor Create; override;
    destructor Destroy; override;

    property ideEvento: TideEventoFin read FideEvento write FideEvento;
    property ideContrib: TideContrib read FideContrib write FideContrib;
    property idePeriodo: TidePeriodoApurSub read FidePeriodo write FidePeriodo;
    property infoOper: TinfoOperD2241 read FinfoOper write FinfoOper;
  end;

  { TDeRED2241 - documento DeRE do evento D-2241 }

  TDeRED2241 = class(TDeRE)
  private
    FevtArranjoCredDest: TevtArranjoCredDest;
  protected
    function GetEvento: TDeREEvento; override;
  public
    constructor Create; override;
    destructor Destroy; override;

    property evtArranjoCredDest: TevtArranjoCredDest read FevtArranjoCredDest write FevtArranjoCredDest;
  end;

implementation

{ TinfoAdqD2241 }

constructor TinfoAdqD2241.Create;
begin
  inherited Create;
  FadqExterior := TadqExteriorD2241.Create;
end;

destructor TinfoAdqD2241.Destroy;
begin
  FadqExterior.Free;
  inherited Destroy;
end;


{ TidePartesD2241 }

constructor TidePartesD2241.Create;
begin
  inherited Create;
  FinfoAdq := TinfoAdqD2241.Create;
end;

destructor TidePartesD2241.Destroy;
begin
  FinfoAdq.Free;
  inherited Destroy;
end;


{ TgBCD2241 }

constructor TgBCD2241.Create;
begin
  inherited Create;
  FgVOper := TgVOperD2241.Create;
  FgDeducoes := TgDeducoesD2241.Create;
  FdetBC := TdetBCD2241.Create;
end;

destructor TgBCD2241.Destroy;
begin
  FgVOper.Free;
  FgDeducoes.Free;
  FdetBC.Free;
  inherited Destroy;
end;


{ TdetOperCollectionItemD2241 }

constructor TdetOperCollectionItemD2241.Create;
begin
  inherited Create;
  FgBC := TgBCD2241.Create;
  FgTributos := TgTributosD2241.Create;
end;

destructor TdetOperCollectionItemD2241.Destroy;
begin
  FgBC.Free;
  FgTributos.Free;
  inherited Destroy;
end;


{ TdetOperCollectionD2241 }

function TdetOperCollectionD2241.GetItem(Index: Integer): TdetOperCollectionItemD2241;
begin
  Result := TdetOperCollectionItemD2241(inherited Items[Index]);
end;

procedure TdetOperCollectionD2241.SetItem(Index: Integer; Value: TdetOperCollectionItemD2241);
begin
  inherited Items[Index] := Value;
end;

function TdetOperCollectionD2241.New: TdetOperCollectionItemD2241;
begin
  Result := TdetOperCollectionItemD2241.Create;
  Add(Result);
end;


{ TdadosOperD2241 }

constructor TdadosOperD2241.Create;
begin
  inherited Create;
  FdetOper := TdetOperCollectionD2241.Create;
end;

destructor TdadosOperD2241.Destroy;
begin
  FdetOper.Free;
  inherited Destroy;
end;


{ TgOperD2241 }

constructor TgOperD2241.Create;
begin
  inherited Create;
  FidePartes := TidePartesD2241.Create;
  FdadosOper := TdadosOperD2241.Create;
end;

destructor TgOperD2241.Destroy;
begin
  FidePartes.Free;
  FdadosOper.Free;
  inherited Destroy;
end;


{ TinfoOperD2241 }

constructor TinfoOperD2241.Create;
begin
  inherited Create;
  FgOper := TgOperD2241.Create;
end;

destructor TinfoOperD2241.Destroy;
begin
  FgOper.Free;
  inherited Destroy;
end;


{ TevtArranjoCredDest }

constructor TevtArranjoCredDest.Create;
begin
  inherited Create;
  FideEvento := TideEventoFin.Create;
  FideContrib := TideContrib.Create;
  FidePeriodo := TidePeriodoApurSub.Create;
  FinfoOper := TinfoOperD2241.Create;
end;

destructor TevtArranjoCredDest.Destroy;
begin
  FideEvento.Free;
  FideContrib.Free;
  FidePeriodo.Free;
  FinfoOper.Free;
  inherited Destroy;
end;

function TevtArranjoCredDest.GetTipoEvento: TTipoEventoDeRE;
begin
  Result := teArranjoCredDest;
end;


{ TDeRED2241 }

constructor TDeRED2241.Create;
begin
  inherited Create;
  FevtArranjoCredDest := TevtArranjoCredDest.Create;
end;

destructor TDeRED2241.Destroy;
begin
  FevtArranjoCredDest.Free;
  inherited Destroy;
end;

function TDeRED2241.GetEvento: TDeREEvento;
begin
  Result := FevtArranjoCredDest;
end;


initialization
  RegistrarDeRE(teArranjoCredDest, TDeRED2241);

end.
