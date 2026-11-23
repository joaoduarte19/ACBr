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

unit ACBrDeRE.D2242.Classes;

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

  { TideContribD2242 }

  TideContribD2242 = class(TideContrib)
  private
    FtpParticip: TTpParticipDeRE;
  public
    // Tipo de participacao do contribuinte no arranjo de pagamento
    property tpParticip: TTpParticipDeRE read FtpParticip write FtpParticip;
  end;

  { TadqExteriorD2242 }

  TadqExteriorD2242 = class(TObject)
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

  { TinfoAdqD2242 }

  TinfoAdqD2242 = class(TObject)
  private
    FCPF: string;
    FTemCPF: Boolean;
    FCNPJ: string;
    FTemCNPJ: Boolean;
    FcMun: string;
    FTemcMun: Boolean;
    FTemadqExterior: Boolean;
    FadqExterior: TadqExteriorD2242;
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
    property adqExterior: TadqExteriorD2242 read FadqExterior;
  end;

  { TidePartesD2242 }

  TidePartesD2242 = class(TObject)
  private
    FinfoAdq: TinfoAdqD2242;
  public
    constructor Create;
    destructor Destroy; override;

    property infoAdq: TinfoAdqD2242 read FinfoAdq;
  end;

  { TgVOperD2242 }

  TgVOperD2242 = class(TObject)
  private
    FvLiqOper: Double;
  public
    // Valor liquido da operacao
    property vLiqOper: Double read FvLiqOper write FvLiqOper;
  end;

  { TgDeducoesD2242 }

  TgDeducoesD2242 = class(TObject)
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

  { TdetBCD2242 }

  TdetBCD2242 = class(TObject)
  private
    FvBCApur: Double;
  public
    // Base de Calculo do IBS/CBS
    property vBCApur: Double read FvBCApur write FvBCApur;
  end;

  { TgBCD2242 }

  TgBCD2242 = class(TObject)
  private
    FTemgDeducoes: Boolean;
    FgVOper: TgVOperD2242;
    FgDeducoes: TgDeducoesD2242;
    FdetBC: TdetBCD2242;
  public
    constructor Create;
    destructor Destroy; override;

    property TemgDeducoes: Boolean read FTemgDeducoes write FTemgDeducoes;
    property gVOper: TgVOperD2242 read FgVOper;
    property gDeducoes: TgDeducoesD2242 read FgDeducoes;
    property detBC: TdetBCD2242 read FdetBC;
  end;

  { TgTributosD2242 }

  TgTributosD2242 = class(TObject)
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

  { TdetOperCollectionItemD2242 }

  TdetOperCollectionItemD2242 = class(TObject)
  private
    Fseq: string;
    FseqRef: string;
    FTemseqRef: Boolean;
    FdhOper: TDateTime;
    FgBC: TgBCD2242;
    FgTributos: TgTributosD2242;
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
    property gBC: TgBCD2242 read FgBC;
    property gTributos: TgTributosD2242 read FgTributos;
  end;

  { TdetOperCollectionD2242 }

  TdetOperCollectionD2242 = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TdetOperCollectionItemD2242;
    procedure SetItem(Index: Integer; Value: TdetOperCollectionItemD2242);
  public
    function New: TdetOperCollectionItemD2242;
    property Items[Index: Integer]: TdetOperCollectionItemD2242 read GetItem write SetItem; default;
  end;

  { TdadosOperD2242 }

  TdadosOperD2242 = class(TObject)
  private
    FdetOper: TdetOperCollectionD2242;
  public
    constructor Create;
    destructor Destroy; override;

    property detOper: TdetOperCollectionD2242 read FdetOper;
  end;

  { TgOperD2242 }

  TgOperD2242 = class(TObject)
  private
    FchAgrup: string;
    FcodBC: string;
    FchAgrupRef: string;
    FTemchAgrupRef: Boolean;
    FidePartes: TidePartesD2242;
    FdadosOper: TdadosOperD2242;
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
    property idePartes: TidePartesD2242 read FidePartes;
    property dadosOper: TdadosOperD2242 read FdadosOper;
  end;

  { TinfoOperD2242 }

  TinfoOperD2242 = class(TObject)
  private
    FgOper: TgOperD2242;
  public
    constructor Create;
    destructor Destroy; override;

    property gOper: TgOperD2242 read FgOper;
  end;

  { TevtArranjoPartic }

  TevtArranjoPartic = class(TDeREEvento)
  private
    FideEvento: TideEventoFin;
    FideContrib: TideContribD2242;
    FidePeriodo: TidePeriodoApurSub;
    FinfoOper: TinfoOperD2242;
  protected
    function GetTipoEvento: TTipoEventoDeRE; override;
  public
    constructor Create; override;
    destructor Destroy; override;

    property ideEvento: TideEventoFin read FideEvento write FideEvento;
    property ideContrib: TideContribD2242 read FideContrib write FideContrib;
    property idePeriodo: TidePeriodoApurSub read FidePeriodo write FidePeriodo;
    property infoOper: TinfoOperD2242 read FinfoOper write FinfoOper;
  end;

  { TDeRED2242 - documento DeRE do evento D-2242 }

  TDeRED2242 = class(TDeRE)
  private
    FevtArranjoPartic: TevtArranjoPartic;
  protected
    function GetEvento: TDeREEvento; override;
  public
    constructor Create; override;
    destructor Destroy; override;

    property evtArranjoPartic: TevtArranjoPartic read FevtArranjoPartic write FevtArranjoPartic;
  end;

implementation

{ TinfoAdqD2242 }

constructor TinfoAdqD2242.Create;
begin
  inherited Create;
  FadqExterior := TadqExteriorD2242.Create;
end;

destructor TinfoAdqD2242.Destroy;
begin
  FadqExterior.Free;
  inherited Destroy;
end;


{ TidePartesD2242 }

constructor TidePartesD2242.Create;
begin
  inherited Create;
  FinfoAdq := TinfoAdqD2242.Create;
end;

destructor TidePartesD2242.Destroy;
begin
  FinfoAdq.Free;
  inherited Destroy;
end;


{ TgBCD2242 }

constructor TgBCD2242.Create;
begin
  inherited Create;
  FgVOper := TgVOperD2242.Create;
  FgDeducoes := TgDeducoesD2242.Create;
  FdetBC := TdetBCD2242.Create;
end;

destructor TgBCD2242.Destroy;
begin
  FgVOper.Free;
  FgDeducoes.Free;
  FdetBC.Free;
  inherited Destroy;
end;


{ TdetOperCollectionItemD2242 }

constructor TdetOperCollectionItemD2242.Create;
begin
  inherited Create;
  FgBC := TgBCD2242.Create;
  FgTributos := TgTributosD2242.Create;
end;

destructor TdetOperCollectionItemD2242.Destroy;
begin
  FgBC.Free;
  FgTributos.Free;
  inherited Destroy;
end;


{ TdetOperCollectionD2242 }

function TdetOperCollectionD2242.GetItem(Index: Integer): TdetOperCollectionItemD2242;
begin
  Result := TdetOperCollectionItemD2242(inherited Items[Index]);
end;

procedure TdetOperCollectionD2242.SetItem(Index: Integer; Value: TdetOperCollectionItemD2242);
begin
  inherited Items[Index] := Value;
end;

function TdetOperCollectionD2242.New: TdetOperCollectionItemD2242;
begin
  Result := TdetOperCollectionItemD2242.Create;
  Add(Result);
end;


{ TdadosOperD2242 }

constructor TdadosOperD2242.Create;
begin
  inherited Create;
  FdetOper := TdetOperCollectionD2242.Create;
end;

destructor TdadosOperD2242.Destroy;
begin
  FdetOper.Free;
  inherited Destroy;
end;


{ TgOperD2242 }

constructor TgOperD2242.Create;
begin
  inherited Create;
  FidePartes := TidePartesD2242.Create;
  FdadosOper := TdadosOperD2242.Create;
end;

destructor TgOperD2242.Destroy;
begin
  FidePartes.Free;
  FdadosOper.Free;
  inherited Destroy;
end;


{ TinfoOperD2242 }

constructor TinfoOperD2242.Create;
begin
  inherited Create;
  FgOper := TgOperD2242.Create;
end;

destructor TinfoOperD2242.Destroy;
begin
  FgOper.Free;
  inherited Destroy;
end;


{ TevtArranjoPartic }

constructor TevtArranjoPartic.Create;
begin
  inherited Create;
  FideEvento := TideEventoFin.Create;
  FideContrib := TideContribD2242.Create;
  FidePeriodo := TidePeriodoApurSub.Create;
  FinfoOper := TinfoOperD2242.Create;
end;

destructor TevtArranjoPartic.Destroy;
begin
  FideEvento.Free;
  FideContrib.Free;
  FidePeriodo.Free;
  FinfoOper.Free;
  inherited Destroy;
end;

function TevtArranjoPartic.GetTipoEvento: TTipoEventoDeRE;
begin
  Result := teArranjoPartic;
end;


{ TDeRED2242 }

constructor TDeRED2242.Create;
begin
  inherited Create;
  FevtArranjoPartic := TevtArranjoPartic.Create;
end;

destructor TDeRED2242.Destroy;
begin
  FevtArranjoPartic.Free;
  inherited Destroy;
end;

function TDeRED2242.GetEvento: TDeREEvento;
begin
  Result := FevtArranjoPartic;
end;


initialization
  RegistrarDeRE(teArranjoPartic, TDeRED2242);

end.
