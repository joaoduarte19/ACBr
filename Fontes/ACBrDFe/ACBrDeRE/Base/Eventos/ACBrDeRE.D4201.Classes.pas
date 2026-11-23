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

unit ACBrDeRE.D4201.Classes;

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

  { TadqExteriorD4201 }

  TadqExteriorD4201 = class(TObject)
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

  { TinfoAdqD4201 }

  TinfoAdqD4201 = class(TObject)
  private
    FCPF: string;
    FTemCPF: Boolean;
    FCNPJ: string;
    FTemCNPJ: Boolean;
    FcMun: string;
    FTemcMun: Boolean;
    FTemadqExterior: Boolean;
    FadqExterior: TadqExteriorD4201;
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
    property adqExterior: TadqExteriorD4201 read FadqExterior;
  end;

  { TinfoPDVD4201 }

  TinfoPDVD4201 = class(TObject)
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

  { TidePartesD4201 }

  TidePartesD4201 = class(TObject)
  private
    FindApostaPresenc: Boolean;
    FTeminfoAdq: Boolean;
    FTeminfoPDV: Boolean;
    FinfoAdq: TinfoAdqD4201;
    FinfoPDV: TinfoPDVD4201;
  public
    constructor Create;
    destructor Destroy; override;

    // Indicador se a aposta no concurso de prognosticos foi realizada de forma presencial
    property indApostaPresenc: Boolean read FindApostaPresenc write FindApostaPresenc;
    property TeminfoAdq: Boolean read FTeminfoAdq write FTeminfoAdq;
    property TeminfoPDV: Boolean read FTeminfoPDV write FTeminfoPDV;
    property infoAdq: TinfoAdqD4201 read FinfoAdq;
    property infoPDV: TinfoPDVD4201 read FinfoPDV;
  end;

  { TinfoApostaD4201 }

  TinfoApostaD4201 = class(TObject)
  private
    FcMunOper: string;
    FTemcMunOper: Boolean;
    FvOper: Double;
  public
    // Identificacao do Municipio correspondente ao local das apostas realizadas presencialmente. Codigo...
    property cMunOper: string read FcMunOper write FcMunOper;
    property TemcMunOper: Boolean read FTemcMunOper write FTemcMunOper;
    // Valor total das operacoes realizadas pelo apostador
    property vOper: Double read FvOper write FvOper;
  end;

  { TdetOperCollectionItemD4201 }

  TdetOperCollectionItemD4201 = class(TObject)
  private
    Fseq: string;
    FseqRef: string;
    FTemseqRef: Boolean;
    FdhOper: TDateTime;
    FinfoAposta: TinfoApostaD4201;
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
    property infoAposta: TinfoApostaD4201 read FinfoAposta;
  end;

  { TdetOperCollectionD4201 }

  TdetOperCollectionD4201 = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TdetOperCollectionItemD4201;
    procedure SetItem(Index: Integer; Value: TdetOperCollectionItemD4201);
  public
    function New: TdetOperCollectionItemD4201;
    property Items[Index: Integer]: TdetOperCollectionItemD4201 read GetItem write SetItem; default;
  end;

  { TdadosOperD4201 }

  TdadosOperD4201 = class(TObject)
  private
    FdetOper: TdetOperCollectionD4201;
  public
    constructor Create;
    destructor Destroy; override;

    property detOper: TdetOperCollectionD4201 read FdetOper;
  end;

  { TgOperD4201 }

  TgOperD4201 = class(TObject)
  private
    FchAgrup: string;
    FcodBC: string;
    FchAgrupRef: string;
    FTemchAgrupRef: Boolean;
    FidePartes: TidePartesD4201;
    FdadosOper: TdadosOperD4201;
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
    property idePartes: TidePartesD4201 read FidePartes;
    property dadosOper: TdadosOperD4201 read FdadosOper;
  end;

  { TinfoOperD4201 }

  TinfoOperD4201 = class(TObject)
  private
    FgOper: TgOperD4201;
  public
    constructor Create;
    destructor Destroy; override;

    property gOper: TgOperD4201 read FgOper;
  end;

  { TevtIdApostPrem }

  TevtIdApostPrem = class(TDeREEvento)
  private
    FideEvento: TideEventoFin;
    FideContrib: TideContrib;
    FidePeriodo: TidePeriodoApurSub;
    FinfoOper: TinfoOperD4201;
  protected
    function GetTipoEvento: TTipoEventoDeRE; override;
  public
    constructor Create; override;
    destructor Destroy; override;

    property ideEvento: TideEventoFin read FideEvento write FideEvento;
    property ideContrib: TideContrib read FideContrib write FideContrib;
    property idePeriodo: TidePeriodoApurSub read FidePeriodo write FidePeriodo;
    property infoOper: TinfoOperD4201 read FinfoOper write FinfoOper;
  end;

  { TDeRED4201 - documento DeRE do evento D-4201 }

  TDeRED4201 = class(TDeRE)
  private
    FevtIdApostPrem: TevtIdApostPrem;
  protected
    function GetEvento: TDeREEvento; override;
  public
    constructor Create; override;
    destructor Destroy; override;

    property evtIdApostPrem: TevtIdApostPrem read FevtIdApostPrem write FevtIdApostPrem;
  end;

implementation

{ TinfoAdqD4201 }

constructor TinfoAdqD4201.Create;
begin
  inherited Create;
  FadqExterior := TadqExteriorD4201.Create;
end;

destructor TinfoAdqD4201.Destroy;
begin
  FadqExterior.Free;
  inherited Destroy;
end;


{ TidePartesD4201 }

constructor TidePartesD4201.Create;
begin
  inherited Create;
  FinfoAdq := TinfoAdqD4201.Create;
  FinfoPDV := TinfoPDVD4201.Create;
end;

destructor TidePartesD4201.Destroy;
begin
  FinfoAdq.Free;
  FinfoPDV.Free;
  inherited Destroy;
end;


{ TdetOperCollectionItemD4201 }

constructor TdetOperCollectionItemD4201.Create;
begin
  inherited Create;
  FinfoAposta := TinfoApostaD4201.Create;
end;

destructor TdetOperCollectionItemD4201.Destroy;
begin
  FinfoAposta.Free;
  inherited Destroy;
end;


{ TdetOperCollectionD4201 }

function TdetOperCollectionD4201.GetItem(Index: Integer): TdetOperCollectionItemD4201;
begin
  Result := TdetOperCollectionItemD4201(inherited Items[Index]);
end;

procedure TdetOperCollectionD4201.SetItem(Index: Integer; Value: TdetOperCollectionItemD4201);
begin
  inherited Items[Index] := Value;
end;

function TdetOperCollectionD4201.New: TdetOperCollectionItemD4201;
begin
  Result := TdetOperCollectionItemD4201.Create;
  Add(Result);
end;


{ TdadosOperD4201 }

constructor TdadosOperD4201.Create;
begin
  inherited Create;
  FdetOper := TdetOperCollectionD4201.Create;
end;

destructor TdadosOperD4201.Destroy;
begin
  FdetOper.Free;
  inherited Destroy;
end;


{ TgOperD4201 }

constructor TgOperD4201.Create;
begin
  inherited Create;
  FidePartes := TidePartesD4201.Create;
  FdadosOper := TdadosOperD4201.Create;
end;

destructor TgOperD4201.Destroy;
begin
  FidePartes.Free;
  FdadosOper.Free;
  inherited Destroy;
end;


{ TinfoOperD4201 }

constructor TinfoOperD4201.Create;
begin
  inherited Create;
  FgOper := TgOperD4201.Create;
end;

destructor TinfoOperD4201.Destroy;
begin
  FgOper.Free;
  inherited Destroy;
end;


{ TevtIdApostPrem }

constructor TevtIdApostPrem.Create;
begin
  inherited Create;
  FideEvento := TideEventoFin.Create;
  FideContrib := TideContrib.Create;
  FidePeriodo := TidePeriodoApurSub.Create;
  FinfoOper := TinfoOperD4201.Create;
end;

destructor TevtIdApostPrem.Destroy;
begin
  FideEvento.Free;
  FideContrib.Free;
  FidePeriodo.Free;
  FinfoOper.Free;
  inherited Destroy;
end;

function TevtIdApostPrem.GetTipoEvento: TTipoEventoDeRE;
begin
  Result := teIdApostPrem;
end;


{ TDeRED4201 }

constructor TDeRED4201.Create;
begin
  inherited Create;
  FevtIdApostPrem := TevtIdApostPrem.Create;
end;

destructor TDeRED4201.Destroy;
begin
  FevtIdApostPrem.Free;
  inherited Destroy;
end;

function TDeRED4201.GetEvento: TDeREEvento;
begin
  Result := FevtIdApostPrem;
end;


initialization
  RegistrarDeRE(teIdApostPrem, TDeRED4201);

end.
