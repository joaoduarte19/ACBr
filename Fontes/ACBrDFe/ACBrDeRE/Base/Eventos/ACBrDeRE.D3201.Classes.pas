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

unit ACBrDeRE.D3201.Classes;

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

  { TadqExteriorD3201 }

  TadqExteriorD3201 = class(TObject)
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

  { TinfoAdqD3201 }

  TinfoAdqD3201 = class(TObject)
  private
    FCPF: string;
    FTemCPF: Boolean;
    FCNPJ: string;
    FTemCNPJ: Boolean;
    FcMun: string;
    FTemcMun: Boolean;
    FTemadqExterior: Boolean;
    FadqExterior: TadqExteriorD3201;
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
    property adqExterior: TadqExteriorD3201 read FadqExterior;
  end;

  { TidePartesD3201 }

  TidePartesD3201 = class(TObject)
  private
    FinfoAdq: TinfoAdqD3201;
  public
    constructor Create;
    destructor Destroy; override;

    property infoAdq: TinfoAdqD3201 read FinfoAdq;
  end;

  { TqualifOperD3201 }

  TqualifOperD3201 = class(TObject)
  private
    FidContrato: string;
    FtpContrato: TTpContratoD3201;
    FCNPJEntidRelac: string;
    FTemCNPJEntidRelac: Boolean;
  public
    // Numero de identificacao do contrato relativo a operacao. Codigo alfanumerico que identifica unica...
    property idContrato: string read FidContrato write FidContrato;
    // Tipo de contrato
    property tpContrato: TTpContratoD3201 read FtpContrato write FtpContrato;
    // Numero de inscricao no CNPJ da outra entidade juridica participante da relacao do contrato coleti...
    property CNPJEntidRelac: string read FCNPJEntidRelac write FCNPJEntidRelac;
    property TemCNPJEntidRelac: Boolean read FTemCNPJEntidRelac write FTemCNPJEntidRelac;
  end;

  { TgVOperD3201 }

  TgVOperD3201 = class(TObject)
  private
    FvOper: Double;
  public
    // Valor total recebido pela contraprestacao ou premio de seguro saude referente ao contrato ou, em...
    property vOper: Double read FvOper write FvOper;
  end;

  { TdetBCD3201 }

  TdetBCD3201 = class(TObject)
  private
    FvBCApur: Double;
  public
    // Valor da base de calculo liquida correspondente ao valor da operacao ({vOper}) com a exclusao dos...
    property vBCApur: Double read FvBCApur write FvBCApur;
  end;

  { TdetDependentesD3201 }

  TdetDependentesD3201 = class(TObject)
  private
    FdtNascDep: TDatasDeRE;
  public
    constructor Create;
    destructor Destroy; override;

    // Data de nascimento do beneficiario dependente vinculado ao titular do plano de saude
    property dtNascDep: TDatasDeRE read FdtNascDep;
  end;

  { TdetBenefCollectionItemD3201 }

  TdetBenefCollectionItemD3201 = class(TObject)
  private
    FCPFTitular: string;
    FTemCPFTitular: Boolean;
    FdtNascTitular: TDateTime;
    FTemdtNascTitular: Boolean;
    FvTitularDep: Double;
    FTemvTitularDep: Boolean;
    FTemdetDependentes: Boolean;
    FdetDependentes: TdetDependentesD3201;
  public
    constructor Create;
    destructor Destroy; override;

    // Numero de inscricao no CPF do beneficiario titular do plano de saude
    property CPFTitular: string read FCPFTitular write FCPFTitular;
    property TemCPFTitular: Boolean read FTemCPFTitular write FTemCPFTitular;
    // Data de nascimento do beneficiario titular do plano de saude
    property dtNascTitular: TDateTime read FdtNascTitular write FdtNascTitular;
    property TemdtNascTitular: Boolean read FTemdtNascTitular write FTemdtNascTitular;
    // Valor total relativo ao titular do plano ou seguro, incluindo seus dependentes
    property vTitularDep: Double read FvTitularDep write FvTitularDep;
    property TemvTitularDep: Boolean read FTemvTitularDep write FTemvTitularDep;
    property TemdetDependentes: Boolean read FTemdetDependentes write FTemdetDependentes;
    property detDependentes: TdetDependentesD3201 read FdetDependentes;
  end;

  { TdetBenefCollectionD3201 }

  TdetBenefCollectionD3201 = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TdetBenefCollectionItemD3201;
    procedure SetItem(Index: Integer; Value: TdetBenefCollectionItemD3201);
  public
    function New: TdetBenefCollectionItemD3201;
    property Items[Index: Integer]: TdetBenefCollectionItemD3201 read GetItem write SetItem; default;
  end;

  { TgIdBenefD3201 }

  TgIdBenefD3201 = class(TObject)
  private
    FdetBenef: TdetBenefCollectionD3201;
  public
    constructor Create;
    destructor Destroy; override;

    property detBenef: TdetBenefCollectionD3201 read FdetBenef;
  end;

  { TgBCD3201 }

  TgBCD3201 = class(TObject)
  private
    FTemdetBC: Boolean;
    FTemgIdBenef: Boolean;
    FgVOper: TgVOperD3201;
    FdetBC: TdetBCD3201;
    FgIdBenef: TgIdBenefD3201;
  public
    constructor Create;
    destructor Destroy; override;

    property TemdetBC: Boolean read FTemdetBC write FTemdetBC;
    property TemgIdBenef: Boolean read FTemgIdBenef write FTemgIdBenef;
    property gVOper: TgVOperD3201 read FgVOper;
    property detBC: TdetBCD3201 read FdetBC;
    property gIdBenef: TgIdBenefD3201 read FgIdBenef;
  end;

  { TgTributosD3201 }

  TgTributosD3201 = class(TObject)
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

  { TdetOperCollectionItemD3201 }

  TdetOperCollectionItemD3201 = class(TObject)
  private
    Fseq: string;
    FseqRef: string;
    FTemseqRef: Boolean;
    FdhOper: TDateTime;
    FTemgTributos: Boolean;
    FqualifOper: TqualifOperD3201;
    FgBC: TgBCD3201;
    FgTributos: TgTributosD3201;
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
    property qualifOper: TqualifOperD3201 read FqualifOper;
    property gBC: TgBCD3201 read FgBC;
    property gTributos: TgTributosD3201 read FgTributos;
  end;

  { TdetOperCollectionD3201 }

  TdetOperCollectionD3201 = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TdetOperCollectionItemD3201;
    procedure SetItem(Index: Integer; Value: TdetOperCollectionItemD3201);
  public
    function New: TdetOperCollectionItemD3201;
    property Items[Index: Integer]: TdetOperCollectionItemD3201 read GetItem write SetItem; default;
  end;

  { TdadosOperD3201 }

  TdadosOperD3201 = class(TObject)
  private
    FdetOper: TdetOperCollectionD3201;
  public
    constructor Create;
    destructor Destroy; override;

    property detOper: TdetOperCollectionD3201 read FdetOper;
  end;

  { TgOperD3201 }

  TgOperD3201 = class(TObject)
  private
    FchAgrup: string;
    FcodBC: string;
    FchAgrupRef: string;
    FTemchAgrupRef: Boolean;
    FidePartes: TidePartesD3201;
    FdadosOper: TdadosOperD3201;
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
    property idePartes: TidePartesD3201 read FidePartes;
    property dadosOper: TdadosOperD3201 read FdadosOper;
  end;

  { TinfoOperD3201 }

  TinfoOperD3201 = class(TObject)
  private
    FgOper: TgOperD3201;
  public
    constructor Create;
    destructor Destroy; override;

    property gOper: TgOperD3201 read FgOper;
  end;

  { TevtPlAssistSaude }

  TevtPlAssistSaude = class(TDeREEvento)
  private
    FideEvento: TideEventoFin;
    FideContrib: TideContrib;
    FidePeriodo: TidePeriodoApurSub;
    FinfoOper: TinfoOperD3201;
  protected
    function GetTipoEvento: TTipoEventoDeRE; override;
  public
    constructor Create; override;
    destructor Destroy; override;

    property ideEvento: TideEventoFin read FideEvento write FideEvento;
    property ideContrib: TideContrib read FideContrib write FideContrib;
    property idePeriodo: TidePeriodoApurSub read FidePeriodo write FidePeriodo;
    property infoOper: TinfoOperD3201 read FinfoOper write FinfoOper;
  end;

  { TDeRED3201 - documento DeRE do evento D-3201 }

  TDeRED3201 = class(TDeRE)
  private
    FevtPlAssistSaude: TevtPlAssistSaude;
  protected
    function GetEvento: TDeREEvento; override;
  public
    constructor Create; override;
    destructor Destroy; override;

    property evtPlAssistSaude: TevtPlAssistSaude read FevtPlAssistSaude write FevtPlAssistSaude;
  end;

implementation

{ TinfoAdqD3201 }

constructor TinfoAdqD3201.Create;
begin
  inherited Create;
  FadqExterior := TadqExteriorD3201.Create;
end;

destructor TinfoAdqD3201.Destroy;
begin
  FadqExterior.Free;
  inherited Destroy;
end;


{ TidePartesD3201 }

constructor TidePartesD3201.Create;
begin
  inherited Create;
  FinfoAdq := TinfoAdqD3201.Create;
end;

destructor TidePartesD3201.Destroy;
begin
  FinfoAdq.Free;
  inherited Destroy;
end;


{ TdetDependentesD3201 }

constructor TdetDependentesD3201.Create;
begin
  inherited Create;
  FdtNascDep := TDatasDeRE.Create;
end;

destructor TdetDependentesD3201.Destroy;
begin
  FdtNascDep.Free;
  inherited Destroy;
end;


{ TdetBenefCollectionItemD3201 }

constructor TdetBenefCollectionItemD3201.Create;
begin
  inherited Create;
  FdetDependentes := TdetDependentesD3201.Create;
end;

destructor TdetBenefCollectionItemD3201.Destroy;
begin
  FdetDependentes.Free;
  inherited Destroy;
end;


{ TdetBenefCollectionD3201 }

function TdetBenefCollectionD3201.GetItem(Index: Integer): TdetBenefCollectionItemD3201;
begin
  Result := TdetBenefCollectionItemD3201(inherited Items[Index]);
end;

procedure TdetBenefCollectionD3201.SetItem(Index: Integer; Value: TdetBenefCollectionItemD3201);
begin
  inherited Items[Index] := Value;
end;

function TdetBenefCollectionD3201.New: TdetBenefCollectionItemD3201;
begin
  Result := TdetBenefCollectionItemD3201.Create;
  Add(Result);
end;


{ TgIdBenefD3201 }

constructor TgIdBenefD3201.Create;
begin
  inherited Create;
  FdetBenef := TdetBenefCollectionD3201.Create;
end;

destructor TgIdBenefD3201.Destroy;
begin
  FdetBenef.Free;
  inherited Destroy;
end;


{ TgBCD3201 }

constructor TgBCD3201.Create;
begin
  inherited Create;
  FgVOper := TgVOperD3201.Create;
  FdetBC := TdetBCD3201.Create;
  FgIdBenef := TgIdBenefD3201.Create;
end;

destructor TgBCD3201.Destroy;
begin
  FgVOper.Free;
  FdetBC.Free;
  FgIdBenef.Free;
  inherited Destroy;
end;


{ TdetOperCollectionItemD3201 }

constructor TdetOperCollectionItemD3201.Create;
begin
  inherited Create;
  FqualifOper := TqualifOperD3201.Create;
  FgBC := TgBCD3201.Create;
  FgTributos := TgTributosD3201.Create;
end;

destructor TdetOperCollectionItemD3201.Destroy;
begin
  FqualifOper.Free;
  FgBC.Free;
  FgTributos.Free;
  inherited Destroy;
end;


{ TdetOperCollectionD3201 }

function TdetOperCollectionD3201.GetItem(Index: Integer): TdetOperCollectionItemD3201;
begin
  Result := TdetOperCollectionItemD3201(inherited Items[Index]);
end;

procedure TdetOperCollectionD3201.SetItem(Index: Integer; Value: TdetOperCollectionItemD3201);
begin
  inherited Items[Index] := Value;
end;

function TdetOperCollectionD3201.New: TdetOperCollectionItemD3201;
begin
  Result := TdetOperCollectionItemD3201.Create;
  Add(Result);
end;


{ TdadosOperD3201 }

constructor TdadosOperD3201.Create;
begin
  inherited Create;
  FdetOper := TdetOperCollectionD3201.Create;
end;

destructor TdadosOperD3201.Destroy;
begin
  FdetOper.Free;
  inherited Destroy;
end;


{ TgOperD3201 }

constructor TgOperD3201.Create;
begin
  inherited Create;
  FidePartes := TidePartesD3201.Create;
  FdadosOper := TdadosOperD3201.Create;
end;

destructor TgOperD3201.Destroy;
begin
  FidePartes.Free;
  FdadosOper.Free;
  inherited Destroy;
end;


{ TinfoOperD3201 }

constructor TinfoOperD3201.Create;
begin
  inherited Create;
  FgOper := TgOperD3201.Create;
end;

destructor TinfoOperD3201.Destroy;
begin
  FgOper.Free;
  inherited Destroy;
end;


{ TevtPlAssistSaude }

constructor TevtPlAssistSaude.Create;
begin
  inherited Create;
  FideEvento := TideEventoFin.Create;
  FideContrib := TideContrib.Create;
  FidePeriodo := TidePeriodoApurSub.Create;
  FinfoOper := TinfoOperD3201.Create;
end;

destructor TevtPlAssistSaude.Destroy;
begin
  FideEvento.Free;
  FideContrib.Free;
  FidePeriodo.Free;
  FinfoOper.Free;
  inherited Destroy;
end;

function TevtPlAssistSaude.GetTipoEvento: TTipoEventoDeRE;
begin
  Result := tePlAssistSaude;
end;


{ TDeRED3201 }

constructor TDeRED3201.Create;
begin
  inherited Create;
  FevtPlAssistSaude := TevtPlAssistSaude.Create;
end;

destructor TDeRED3201.Destroy;
begin
  FevtPlAssistSaude.Free;
  inherited Destroy;
end;

function TDeRED3201.GetEvento: TDeREEvento;
begin
  Result := FevtPlAssistSaude;
end;


initialization
  RegistrarDeRE(tePlAssistSaude, TDeRED3201);

end.
