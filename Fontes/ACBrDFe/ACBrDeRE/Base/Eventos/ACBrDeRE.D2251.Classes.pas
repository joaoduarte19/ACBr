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

unit ACBrDeRE.D2251.Classes;

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

  { TadqExteriorD2251 }

  TadqExteriorD2251 = class(TObject)
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

  { TinfoAdqD2251 }

  TinfoAdqD2251 = class(TObject)
  private
    FCPF: string;
    FTemCPF: Boolean;
    FCNPJ: string;
    FTemCNPJ: Boolean;
    FcMun: string;
    FTemcMun: Boolean;
    FTemadqExterior: Boolean;
    FadqExterior: TadqExteriorD2251;
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
    property adqExterior: TadqExteriorD2251 read FadqExterior;
  end;

  { TinfoPDVD2251 }

  TinfoPDVD2251 = class(TObject)
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

  { TidePartesD2251 }

  TidePartesD2251 = class(TObject)
  private
    FindIdentifAdq: Boolean;
    FTemindIdentifAdq: Boolean;
    FTeminfoAdq: Boolean;
    FTeminfoPDV: Boolean;
    FinfoAdq: TinfoAdqD2251;
    FinfoPDV: TinfoPDVD2251;
  public
    constructor Create;
    destructor Destroy; override;

    // Indicador se o subscritor e obrigado a se identificar por ocasiao da aquisicao, nos termos de nor...
    property indIdentifAdq: Boolean read FindIdentifAdq write FindIdentifAdq;
    property TemindIdentifAdq: Boolean read FTemindIdentifAdq write FTemindIdentifAdq;
    property TeminfoAdq: Boolean read FTeminfoAdq write FTeminfoAdq;
    property TeminfoPDV: Boolean read FTeminfoPDV write FTeminfoPDV;
    property infoAdq: TinfoAdqD2251 read FinfoAdq;
    property infoPDV: TinfoPDVD2251 read FinfoPDV;
  end;

  { TgSemCobertD2251 }

  TgSemCobertD2251 = class(TObject)
  private
    FvBCDistr: Double;
  public
    // Valor da base de calculo para distribuicao do IBS, correspondente ao montante integral do premio...
    property vBCDistr: Double read FvBCDistr write FvBCDistr;
  end;

  { TsegExteriorD2251 }

  TsegExteriorD2251 = class(TObject)
  private
    FNIFSeg: string;
    FTemNIFSeg: Boolean;
    FcNaoNIFSeg: TCNaoNIFDeRE;
    FTemcNaoNIFSeg: Boolean;
    FnrDocIdentSeg: string;
    FTemnrDocIdentSeg: Boolean;
    FcPaisSeg: string;
  public
    // Numero de Identificacao Fiscal (NIF) do participante/segurado estrangeiro, fornecido por orgao de...
    property NIFSeg: string read FNIFSeg write FNIFSeg;
    property TemNIFSeg: Boolean read FTemNIFSeg write FTemNIFSeg;
    // Codigo do motivo para a nao informacao do NIF do participante/segurado estrangeiro
    property cNaoNIFSeg: TCNaoNIFDeRE read FcNaoNIFSeg write FcNaoNIFSeg;
    property TemcNaoNIFSeg: Boolean read FTemcNaoNIFSeg write FTemcNaoNIFSeg;
    // Numero do documento de identificacao oficial no exterior (passaporte, carteira de identidade estr...
    property nrDocIdentSeg: string read FnrDocIdentSeg write FnrDocIdentSeg;
    property TemnrDocIdentSeg: Boolean read FTemnrDocIdentSeg write FTemnrDocIdentSeg;
    // Codigo de identificacao do pais de domicilio fiscal (emissor do NIF) ou de residencia fisica do p...
    property cPaisSeg: string read FcPaisSeg write FcPaisSeg;
  end;

  { TdetSeguradoCollectionItemD2251 }

  TdetSeguradoCollectionItemD2251 = class(TObject)
  private
    FvBCDistrSeg: Double;
    FCPFSeg: string;
    FTemCPFSeg: Boolean;
    FCNPJSeg: string;
    FTemCNPJSeg: Boolean;
    FcMunSeg: string;
    FTemcMunSeg: Boolean;
    FTemsegExterior: Boolean;
    FsegExterior: TsegExteriorD2251;
  public
    constructor Create;
    destructor Destroy; override;

    // Valor individualizado do seguro, cosseguro ou contribuicao recebida. Parcela da base de calculo i...
    property vBCDistrSeg: Double read FvBCDistrSeg write FvBCDistrSeg;
    // Numero de inscricao no CPF do participante/segurado, se pessoa fisica
    property CPFSeg: string read FCPFSeg write FCPFSeg;
    property TemCPFSeg: Boolean read FTemCPFSeg write FTemCPFSeg;
    // Numero de inscricao no CNPJ do participante/segurado, se pessoa juridica
    property CNPJSeg: string read FCNPJSeg write FCNPJSeg;
    property TemCNPJSeg: Boolean read FTemCNPJSeg write FTemCNPJSeg;
    // Codigo IBGE do municipio do endereco do participante/segurado, conforme informacoes existentes na...
    property cMunSeg: string read FcMunSeg write FcMunSeg;
    property TemcMunSeg: Boolean read FTemcMunSeg write FTemcMunSeg;
    property TemsegExterior: Boolean read FTemsegExterior write FTemsegExterior;
    property segExterior: TsegExteriorD2251 read FsegExterior;
  end;

  { TdetSeguradoCollectionD2251 }

  TdetSeguradoCollectionD2251 = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TdetSeguradoCollectionItemD2251;
    procedure SetItem(Index: Integer; Value: TdetSeguradoCollectionItemD2251);
  public
    function New: TdetSeguradoCollectionItemD2251;
    property Items[Index: Integer]: TdetSeguradoCollectionItemD2251 read GetItem write SetItem; default;
  end;

  { TgIdSeguradosD2251 }

  TgIdSeguradosD2251 = class(TObject)
  private
    FdetSegurado: TdetSeguradoCollectionD2251;
  public
    constructor Create;
    destructor Destroy; override;

    property detSegurado: TdetSeguradoCollectionD2251 read FdetSegurado;
  end;

  { TgComCobertPrevD2251 }

  TgComCobertPrevD2251 = class(TObject)
  private
    FtpContrato: TTpContratoDeRE;
    FvBCDistr: Double;
    FTemgIdSegurados: Boolean;
    FgIdSegurados: TgIdSeguradosD2251;
  public
    constructor Create;
    destructor Destroy; override;

    // Tipo de contrato
    property tpContrato: TTpContratoDeRE read FtpContrato write FtpContrato;
    // Valor total do seguro, cosseguro ou contribuicao recebida. Parcela da base de calculo individuali...
    property vBCDistr: Double read FvBCDistr write FvBCDistr;
    property TemgIdSegurados: Boolean read FTemgIdSegurados write FTemgIdSegurados;
    property gIdSegurados: TgIdSeguradosD2251 read FgIdSegurados;
  end;

  { TgCapitalizacaoD2251 }

  TgCapitalizacaoD2251 = class(TObject)
  private
    FvBCDistr: Double;
    FcMunOper: string;
    FTemcMunOper: Boolean;
  public
    // Valor arrecadado com a venda do titulo de capitalizacao
    property vBCDistr: Double read FvBCDistr write FvBCDistr;
    // Identificacao do municipio correspondente ao local de comercializacao do titulo de capitalizacao....
    property cMunOper: string read FcMunOper write FcMunOper;
    property TemcMunOper: Boolean read FTemcMunOper write FTemcMunOper;
  end;

  { TdetOperCollectionItemD2251 }

  TdetOperCollectionItemD2251 = class(TObject)
  private
    Fseq: string;
    FseqRef: string;
    FTemseqRef: Boolean;
    FdhOper: TDateTime;
    FTemgSemCobert: Boolean;
    FTemgComCobertPrev: Boolean;
    FTemgCapitalizacao: Boolean;
    FgSemCobert: TgSemCobertD2251;
    FgComCobertPrev: TgComCobertPrevD2251;
    FgCapitalizacao: TgCapitalizacaoD2251;
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
    property TemgSemCobert: Boolean read FTemgSemCobert write FTemgSemCobert;
    property TemgComCobertPrev: Boolean read FTemgComCobertPrev write FTemgComCobertPrev;
    property TemgCapitalizacao: Boolean read FTemgCapitalizacao write FTemgCapitalizacao;
    property gSemCobert: TgSemCobertD2251 read FgSemCobert;
    property gComCobertPrev: TgComCobertPrevD2251 read FgComCobertPrev;
    property gCapitalizacao: TgCapitalizacaoD2251 read FgCapitalizacao;
  end;

  { TdetOperCollectionD2251 }

  TdetOperCollectionD2251 = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TdetOperCollectionItemD2251;
    procedure SetItem(Index: Integer; Value: TdetOperCollectionItemD2251);
  public
    function New: TdetOperCollectionItemD2251;
    property Items[Index: Integer]: TdetOperCollectionItemD2251 read GetItem write SetItem; default;
  end;

  { TdadosOperD2251 }

  TdadosOperD2251 = class(TObject)
  private
    FdetOper: TdetOperCollectionD2251;
  public
    constructor Create;
    destructor Destroy; override;

    property detOper: TdetOperCollectionD2251 read FdetOper;
  end;

  { TgOperD2251 }

  TgOperD2251 = class(TObject)
  private
    FchAgrup: string;
    FcodBC: string;
    FchAgrupRef: string;
    FTemchAgrupRef: Boolean;
    FidePartes: TidePartesD2251;
    FdadosOper: TdadosOperD2251;
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
    property idePartes: TidePartesD2251 read FidePartes;
    property dadosOper: TdadosOperD2251 read FdadosOper;
  end;

  { TinfoOperD2251 }

  TinfoOperD2251 = class(TObject)
  private
    FgOper: TgOperD2251;
  public
    constructor Create;
    destructor Destroy; override;

    property gOper: TgOperD2251 read FgOper;
  end;

  { TevtSegPrevCap }

  TevtSegPrevCap = class(TDeREEvento)
  private
    FideEvento: TideEventoFin;
    FideContrib: TideContrib;
    FidePeriodo: TidePeriodoApurSub;
    FinfoOper: TinfoOperD2251;
  protected
    function GetTipoEvento: TTipoEventoDeRE; override;
  public
    constructor Create; override;
    destructor Destroy; override;

    property ideEvento: TideEventoFin read FideEvento write FideEvento;
    property ideContrib: TideContrib read FideContrib write FideContrib;
    property idePeriodo: TidePeriodoApurSub read FidePeriodo write FidePeriodo;
    property infoOper: TinfoOperD2251 read FinfoOper write FinfoOper;
  end;

  { TDeRED2251 - documento DeRE do evento D-2251 }

  TDeRED2251 = class(TDeRE)
  private
    FevtSegPrevCap: TevtSegPrevCap;
  protected
    function GetEvento: TDeREEvento; override;
  public
    constructor Create; override;
    destructor Destroy; override;

    property evtSegPrevCap: TevtSegPrevCap read FevtSegPrevCap write FevtSegPrevCap;
  end;

implementation

{ TinfoAdqD2251 }

constructor TinfoAdqD2251.Create;
begin
  inherited Create;
  FadqExterior := TadqExteriorD2251.Create;
end;

destructor TinfoAdqD2251.Destroy;
begin
  FadqExterior.Free;
  inherited Destroy;
end;


{ TidePartesD2251 }

constructor TidePartesD2251.Create;
begin
  inherited Create;
  FinfoAdq := TinfoAdqD2251.Create;
  FinfoPDV := TinfoPDVD2251.Create;
end;

destructor TidePartesD2251.Destroy;
begin
  FinfoAdq.Free;
  FinfoPDV.Free;
  inherited Destroy;
end;


{ TdetSeguradoCollectionItemD2251 }

constructor TdetSeguradoCollectionItemD2251.Create;
begin
  inherited Create;
  FsegExterior := TsegExteriorD2251.Create;
end;

destructor TdetSeguradoCollectionItemD2251.Destroy;
begin
  FsegExterior.Free;
  inherited Destroy;
end;


{ TdetSeguradoCollectionD2251 }

function TdetSeguradoCollectionD2251.GetItem(Index: Integer): TdetSeguradoCollectionItemD2251;
begin
  Result := TdetSeguradoCollectionItemD2251(inherited Items[Index]);
end;

procedure TdetSeguradoCollectionD2251.SetItem(Index: Integer; Value: TdetSeguradoCollectionItemD2251);
begin
  inherited Items[Index] := Value;
end;

function TdetSeguradoCollectionD2251.New: TdetSeguradoCollectionItemD2251;
begin
  Result := TdetSeguradoCollectionItemD2251.Create;
  Add(Result);
end;


{ TgIdSeguradosD2251 }

constructor TgIdSeguradosD2251.Create;
begin
  inherited Create;
  FdetSegurado := TdetSeguradoCollectionD2251.Create;
end;

destructor TgIdSeguradosD2251.Destroy;
begin
  FdetSegurado.Free;
  inherited Destroy;
end;


{ TgComCobertPrevD2251 }

constructor TgComCobertPrevD2251.Create;
begin
  inherited Create;
  FgIdSegurados := TgIdSeguradosD2251.Create;
end;

destructor TgComCobertPrevD2251.Destroy;
begin
  FgIdSegurados.Free;
  inherited Destroy;
end;


{ TdetOperCollectionItemD2251 }

constructor TdetOperCollectionItemD2251.Create;
begin
  inherited Create;
  FgSemCobert := TgSemCobertD2251.Create;
  FgComCobertPrev := TgComCobertPrevD2251.Create;
  FgCapitalizacao := TgCapitalizacaoD2251.Create;
end;

destructor TdetOperCollectionItemD2251.Destroy;
begin
  FgSemCobert.Free;
  FgComCobertPrev.Free;
  FgCapitalizacao.Free;
  inherited Destroy;
end;


{ TdetOperCollectionD2251 }

function TdetOperCollectionD2251.GetItem(Index: Integer): TdetOperCollectionItemD2251;
begin
  Result := TdetOperCollectionItemD2251(inherited Items[Index]);
end;

procedure TdetOperCollectionD2251.SetItem(Index: Integer; Value: TdetOperCollectionItemD2251);
begin
  inherited Items[Index] := Value;
end;

function TdetOperCollectionD2251.New: TdetOperCollectionItemD2251;
begin
  Result := TdetOperCollectionItemD2251.Create;
  Add(Result);
end;


{ TdadosOperD2251 }

constructor TdadosOperD2251.Create;
begin
  inherited Create;
  FdetOper := TdetOperCollectionD2251.Create;
end;

destructor TdadosOperD2251.Destroy;
begin
  FdetOper.Free;
  inherited Destroy;
end;


{ TgOperD2251 }

constructor TgOperD2251.Create;
begin
  inherited Create;
  FidePartes := TidePartesD2251.Create;
  FdadosOper := TdadosOperD2251.Create;
end;

destructor TgOperD2251.Destroy;
begin
  FidePartes.Free;
  FdadosOper.Free;
  inherited Destroy;
end;


{ TinfoOperD2251 }

constructor TinfoOperD2251.Create;
begin
  inherited Create;
  FgOper := TgOperD2251.Create;
end;

destructor TinfoOperD2251.Destroy;
begin
  FgOper.Free;
  inherited Destroy;
end;


{ TevtSegPrevCap }

constructor TevtSegPrevCap.Create;
begin
  inherited Create;
  FideEvento := TideEventoFin.Create;
  FideContrib := TideContrib.Create;
  FidePeriodo := TidePeriodoApurSub.Create;
  FinfoOper := TinfoOperD2251.Create;
end;

destructor TevtSegPrevCap.Destroy;
begin
  FideEvento.Free;
  FideContrib.Free;
  FidePeriodo.Free;
  FinfoOper.Free;
  inherited Destroy;
end;

function TevtSegPrevCap.GetTipoEvento: TTipoEventoDeRE;
begin
  Result := teSegPrevCap;
end;


{ TDeRED2251 }

constructor TDeRED2251.Create;
begin
  inherited Create;
  FevtSegPrevCap := TevtSegPrevCap.Create;
end;

destructor TDeRED2251.Destroy;
begin
  FevtSegPrevCap.Free;
  inherited Destroy;
end;

function TDeRED2251.GetEvento: TDeREEvento;
begin
  Result := FevtSegPrevCap;
end;


initialization
  RegistrarDeRE(teSegPrevCap, TDeRED2251);

end.
