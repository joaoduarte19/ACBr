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

unit ACBrDeRE.D2201.Classes;

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

  { TadqExteriorD2201 }

  TadqExteriorD2201 = class(TObject)
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

  { TinfoAdqD2201 }

  TinfoAdqD2201 = class(TObject)
  private
    FCPF: string;
    FTemCPF: Boolean;
    FCNPJ: string;
    FTemCNPJ: Boolean;
    FcMun: string;
    FTemcMun: Boolean;
    FTemadqExterior: Boolean;
    FadqExterior: TadqExteriorD2201;
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
    property adqExterior: TadqExteriorD2201 read FadqExterior;
  end;

  { TidePartesD2201 }

  TidePartesD2201 = class(TObject)
  private
    FinfoAdq: TinfoAdqD2201;
  public
    constructor Create;
    destructor Destroy; override;

    property infoAdq: TinfoAdqD2201 read FinfoAdq;
  end;

  { TdestExteriorD2201 }

  TdestExteriorD2201 = class(TObject)
  private
    FNIFDest: string;
    FTemNIFDest: Boolean;
    FcNaoNIFDest: TCNaoNIFDeRE;
    FTemcNaoNIFDest: Boolean;
    FnrDocIdentDest: string;
    FTemnrDocIdentDest: Boolean;
    FcPaisDest: string;
  public
    // Numero de Identificacao Fiscal (NIF) do destinatario estrangeiro, fornecido por orgao de administ...
    property NIFDest: string read FNIFDest write FNIFDest;
    property TemNIFDest: Boolean read FTemNIFDest write FTemNIFDest;
    // Codigo do motivo para a nao informacao do NIF do destinatario estrangeiro
    property cNaoNIFDest: TCNaoNIFDeRE read FcNaoNIFDest write FcNaoNIFDest;
    property TemcNaoNIFDest: Boolean read FTemcNaoNIFDest write FTemcNaoNIFDest;
    // Numero do documento de identificacao oficial no exterior (passaporte, carteira de identidade estr...
    property nrDocIdentDest: string read FnrDocIdentDest write FnrDocIdentDest;
    property TemnrDocIdentDest: Boolean read FTemnrDocIdentDest write FTemnrDocIdentDest;
    // Codigo de identificacao do pais de domicilio fiscal (emissor do NIF) ou de residencia fisica do d...
    property cPaisDest: string read FcPaisDest write FcPaisDest;
  end;

  { TinfoDestD2201 }

  TinfoDestD2201 = class(TObject)
  private
    FCPFDest: string;
    FTemCPFDest: Boolean;
    FCNPJDest: string;
    FTemCNPJDest: Boolean;
    FcMunDest: string;
    FTemcMunDest: Boolean;
    FTemdestExterior: Boolean;
    FdestExterior: TdestExteriorD2201;
  public
    constructor Create;
    destructor Destroy; override;

    // Numero de inscricao no CPF do destinatario do servico, se pessoa fisica
    property CPFDest: string read FCPFDest write FCPFDest;
    property TemCPFDest: Boolean read FTemCPFDest write FTemCPFDest;
    // Numero de inscricao no CNPJ do destinatario do servico, se pessoa juridica
    property CNPJDest: string read FCNPJDest write FCNPJDest;
    property TemCNPJDest: Boolean read FTemCNPJDest write FTemCNPJDest;
    // Codigo IBGE do municipio do endereco do destinatario, conforme informacoes existentes na base cad...
    property cMunDest: string read FcMunDest write FcMunDest;
    property TemcMunDest: Boolean read FTemcMunDest write FTemcMunDest;
    property TemdestExterior: Boolean read FTemdestExterior write FTemdestExterior;
    property destExterior: TdestExteriorD2201 read FdestExterior;
  end;

  { TgBCD2201 }

  TgBCD2201 = class(TObject)
  private
    FvBCApur: Double;
  public
    // Valor da base de calculo liquida correspondente a operacao, obtido apos a exclusao dos tributos q...
    property vBCApur: Double read FvBCApur write FvBCApur;
  end;

  { TgTributosD2201 }

  TgTributosD2201 = class(TObject)
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

  { TdetOperCollectionItemD2201 }

  TdetOperCollectionItemD2201 = class(TObject)
  private
    Fseq: string;
    FseqRef: string;
    FTemseqRef: Boolean;
    FdhOper: TDateTime;
    FTeminfoDest: Boolean;
    FinfoDest: TinfoDestD2201;
    FgBC: TgBCD2201;
    FgTributos: TgTributosD2201;
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
    property TeminfoDest: Boolean read FTeminfoDest write FTeminfoDest;
    property infoDest: TinfoDestD2201 read FinfoDest;
    property gBC: TgBCD2201 read FgBC;
    property gTributos: TgTributosD2201 read FgTributos;
  end;

  { TdetOperCollectionD2201 }

  TdetOperCollectionD2201 = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TdetOperCollectionItemD2201;
    procedure SetItem(Index: Integer; Value: TdetOperCollectionItemD2201);
  public
    function New: TdetOperCollectionItemD2201;
    property Items[Index: Integer]: TdetOperCollectionItemD2201 read GetItem write SetItem; default;
  end;

  { TdadosOperD2201 }

  TdadosOperD2201 = class(TObject)
  private
    FdetOper: TdetOperCollectionD2201;
  public
    constructor Create;
    destructor Destroy; override;

    property detOper: TdetOperCollectionD2201 read FdetOper;
  end;

  { TgOperD2201 }

  TgOperD2201 = class(TObject)
  private
    FchAgrup: string;
    FcodBC: string;
    FchAgrupRef: string;
    FTemchAgrupRef: Boolean;
    FidePartes: TidePartesD2201;
    FdadosOper: TdadosOperD2201;
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
    property idePartes: TidePartesD2201 read FidePartes;
    property dadosOper: TdadosOperD2201 read FdadosOper;
  end;

  { TinfoOperD2201 }

  TinfoOperD2201 = class(TObject)
  private
    FgOper: TgOperD2201;
  public
    constructor Create;
    destructor Destroy; override;

    property gOper: TgOperD2201 read FgOper;
  end;

  { TevtServRemPreco }

  TevtServRemPreco = class(TDeREEvento)
  private
    FideEvento: TideEventoFin;
    FideContrib: TideContrib;
    FidePeriodo: TidePeriodoApurSub;
    FinfoOper: TinfoOperD2201;
  protected
    function GetTipoEvento: TTipoEventoDeRE; override;
  public
    constructor Create; override;
    destructor Destroy; override;

    property ideEvento: TideEventoFin read FideEvento write FideEvento;
    property ideContrib: TideContrib read FideContrib write FideContrib;
    property idePeriodo: TidePeriodoApurSub read FidePeriodo write FidePeriodo;
    property infoOper: TinfoOperD2201 read FinfoOper write FinfoOper;
  end;

  { TDeRED2201 - documento DeRE do evento D-2201 }

  TDeRED2201 = class(TDeRE)
  private
    FevtServRemPreco: TevtServRemPreco;
  protected
    function GetEvento: TDeREEvento; override;
  public
    constructor Create; override;
    destructor Destroy; override;

    property evtServRemPreco: TevtServRemPreco read FevtServRemPreco write FevtServRemPreco;
  end;

implementation

{ TinfoAdqD2201 }

constructor TinfoAdqD2201.Create;
begin
  inherited Create;
  FadqExterior := TadqExteriorD2201.Create;
end;

destructor TinfoAdqD2201.Destroy;
begin
  FadqExterior.Free;
  inherited Destroy;
end;


{ TidePartesD2201 }

constructor TidePartesD2201.Create;
begin
  inherited Create;
  FinfoAdq := TinfoAdqD2201.Create;
end;

destructor TidePartesD2201.Destroy;
begin
  FinfoAdq.Free;
  inherited Destroy;
end;


{ TinfoDestD2201 }

constructor TinfoDestD2201.Create;
begin
  inherited Create;
  FdestExterior := TdestExteriorD2201.Create;
end;

destructor TinfoDestD2201.Destroy;
begin
  FdestExterior.Free;
  inherited Destroy;
end;


{ TdetOperCollectionItemD2201 }

constructor TdetOperCollectionItemD2201.Create;
begin
  inherited Create;
  FinfoDest := TinfoDestD2201.Create;
  FgBC := TgBCD2201.Create;
  FgTributos := TgTributosD2201.Create;
end;

destructor TdetOperCollectionItemD2201.Destroy;
begin
  FinfoDest.Free;
  FgBC.Free;
  FgTributos.Free;
  inherited Destroy;
end;


{ TdetOperCollectionD2201 }

function TdetOperCollectionD2201.GetItem(Index: Integer): TdetOperCollectionItemD2201;
begin
  Result := TdetOperCollectionItemD2201(inherited Items[Index]);
end;

procedure TdetOperCollectionD2201.SetItem(Index: Integer; Value: TdetOperCollectionItemD2201);
begin
  inherited Items[Index] := Value;
end;

function TdetOperCollectionD2201.New: TdetOperCollectionItemD2201;
begin
  Result := TdetOperCollectionItemD2201.Create;
  Add(Result);
end;


{ TdadosOperD2201 }

constructor TdadosOperD2201.Create;
begin
  inherited Create;
  FdetOper := TdetOperCollectionD2201.Create;
end;

destructor TdadosOperD2201.Destroy;
begin
  FdetOper.Free;
  inherited Destroy;
end;


{ TgOperD2201 }

constructor TgOperD2201.Create;
begin
  inherited Create;
  FidePartes := TidePartesD2201.Create;
  FdadosOper := TdadosOperD2201.Create;
end;

destructor TgOperD2201.Destroy;
begin
  FidePartes.Free;
  FdadosOper.Free;
  inherited Destroy;
end;


{ TinfoOperD2201 }

constructor TinfoOperD2201.Create;
begin
  inherited Create;
  FgOper := TgOperD2201.Create;
end;

destructor TinfoOperD2201.Destroy;
begin
  FgOper.Free;
  inherited Destroy;
end;


{ TevtServRemPreco }

constructor TevtServRemPreco.Create;
begin
  inherited Create;
  FideEvento := TideEventoFin.Create;
  FideContrib := TideContrib.Create;
  FidePeriodo := TidePeriodoApurSub.Create;
  FinfoOper := TinfoOperD2201.Create;
end;

destructor TevtServRemPreco.Destroy;
begin
  FideEvento.Free;
  FideContrib.Free;
  FidePeriodo.Free;
  FinfoOper.Free;
  inherited Destroy;
end;

function TevtServRemPreco.GetTipoEvento: TTipoEventoDeRE;
begin
  Result := teServRemPreco;
end;


{ TDeRED2201 }

constructor TDeRED2201.Create;
begin
  inherited Create;
  FevtServRemPreco := TevtServRemPreco.Create;
end;

destructor TDeRED2201.Destroy;
begin
  FevtServRemPreco.Free;
  inherited Destroy;
end;

function TDeRED2201.GetEvento: TDeREEvento;
begin
  Result := FevtServRemPreco;
end;


initialization
  RegistrarDeRE(teServRemPreco, TDeRED2201);

end.
