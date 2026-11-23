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

unit ACBrDeRE.D2102.Classes;

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

  { TcotaCollectionItemD2102 }

  TcotaCollectionItemD2102 = class(TObject)
  private
    FtipoCota: string;
    Fsubclasse: string;
    FqtdeCotas: string;
    FvalorCota: string;
  public
    // Classificacao do tipo e serie de cota detida. Informar o tipo de cota conforme abaixo: 1  Cota un...
    property tipoCota: string read FtipoCota write FtipoCota;
    // Codigo da subclasse do fundo constante no cadastro da CVM
    property subclasse: string read Fsubclasse write Fsubclasse;
    // Quantidade de cotas detidas pelo cotista ou distribuidor para a subclasse e tipo informados
    property qtdeCotas: string read FqtdeCotas write FqtdeCotas;
    // Valor da cota
    property valorCota: string read FvalorCota write FvalorCota;
  end;

  { TcotaCollectionD2102 }

  TcotaCollectionD2102 = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TcotaCollectionItemD2102;
    procedure SetItem(Index: Integer; Value: TcotaCollectionItemD2102);
  public
    function New: TcotaCollectionItemD2102;
    property Items[Index: Integer]: TcotaCollectionItemD2102 read GetItem write SetItem; default;
  end;

  { TcotasD2102 }

  TcotasD2102 = class(TObject)
  private
    Fcota: TcotaCollectionD2102;
  public
    constructor Create;
    destructor Destroy; override;

    property cota: TcotaCollectionD2102 read Fcota;
  end;

  { TcotistaCollectionItemD2102 }

  TcotistaCollectionItemD2102 = class(TObject)
  private
    FtipoPessoa: TTipoPessoaDeRE;
    Fidentificacao: string;
    Fclassificacao: TClassificacaoDeRE;
    Fcotas: TcotasD2102;
  public
    constructor Create;
    destructor Destroy; override;

    // Indicador do tipo de pessoa do cotista ou distribuidor
    property tipoPessoa: TTipoPessoaDeRE read FtipoPessoa write FtipoPessoa;
    // Identificacao do cotista ou distribuidor
    property identificacao: string read Fidentificacao write Fidentificacao;
    // Classificacao da condicao da parte informada no registro
    property classificacao: TClassificacaoDeRE read Fclassificacao write Fclassificacao;
    property cotas: TcotasD2102 read Fcotas;
  end;

  { TcotistaCollectionD2102 }

  TcotistaCollectionD2102 = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TcotistaCollectionItemD2102;
    procedure SetItem(Index: Integer; Value: TcotistaCollectionItemD2102);
  public
    function New: TcotistaCollectionItemD2102;
    property Items[Index: Integer]: TcotistaCollectionItemD2102 read GetItem write SetItem; default;
  end;

  { TcotistasD2102 }

  TcotistasD2102 = class(TObject)
  private
    Fcotista: TcotistaCollectionD2102;
  public
    constructor Create;
    destructor Destroy; override;

    property cotista: TcotistaCollectionD2102 read Fcotista;
  end;

  { TclasseCollectionItemD2102 }

  TclasseCollectionItemD2102 = class(TObject)
  private
    FidClasse: string;
    FquantidadeCotas: string;
    FquantidadeCotistas: string;
    FplClasse: Double;
    FTemplClasse: Boolean;
    FcnpjFundo: string;
    Fcotistas: TcotistasD2102;
  public
    constructor Create;
    destructor Destroy; override;

    // Numero de inscricao no CNPJ da classe do fundo de investimento
    property idClasse: string read FidClasse write FidClasse;
    // Quantidade total de cotas da classe
    property quantidadeCotas: string read FquantidadeCotas write FquantidadeCotas;
    // Quantidade total de cotistas
    property quantidadeCotistas: string read FquantidadeCotistas write FquantidadeCotistas;
    // Valor do patrimonio liquido da classe
    property plClasse: Double read FplClasse write FplClasse;
    property TemplClasse: Boolean read FTemplClasse write FTemplClasse;
    // Numero de inscricao no CNPJ do fundo de investimento ao qual pertence a classe informada
    property cnpjFundo: string read FcnpjFundo write FcnpjFundo;
    property cotistas: TcotistasD2102 read Fcotistas;
  end;

  { TclasseCollectionD2102 }

  TclasseCollectionD2102 = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TclasseCollectionItemD2102;
    procedure SetItem(Index: Integer; Value: TclasseCollectionItemD2102);
  public
    function New: TclasseCollectionItemD2102;
    property Items[Index: Integer]: TclasseCollectionItemD2102 read GetItem write SetItem; default;
  end;

  { TclassesD2102 }

  TclassesD2102 = class(TObject)
  private
    Fclasse: TclasseCollectionD2102;
  public
    constructor Create;
    destructor Destroy; override;

    property classe: TclasseCollectionD2102 read Fclasse;
  end;

  { TinfoCotistasD2102 }

  TinfoCotistasD2102 = class(TObject)
  private
    FTeminfoCotistas: Boolean;
    FtpDeclarante: TTpDeclaranteDeRE;
    Fclasses: TclassesD2102;
  public
    constructor Create;
    destructor Destroy; override;

    property TeminfoCotistas: Boolean read FTeminfoCotistas write FTeminfoCotistas;
    // Indicador do tipo de declarante
    property tpDeclarante: TTpDeclaranteDeRE read FtpDeclarante write FtpDeclarante;
    property classes: TclassesD2102 read Fclasses;
  end;

  { TevtInfoCotistas }

  TevtInfoCotistas = class(TDeREEvento)
  private
    FideEvento: TideEventoRecibo;
    FideContrib: TideContrib;
    FidePeriodo: TidePeriodoApur;
    FinfoCotistas: TinfoCotistasD2102;
  protected
    function GetTipoEvento: TTipoEventoDeRE; override;
  public
    constructor Create; override;
    destructor Destroy; override;

    property ideEvento: TideEventoRecibo read FideEvento write FideEvento;
    property ideContrib: TideContrib read FideContrib write FideContrib;
    property idePeriodo: TidePeriodoApur read FidePeriodo write FidePeriodo;
    property infoCotistas: TinfoCotistasD2102 read FinfoCotistas write FinfoCotistas;
  end;

  { TDeRED2102 - documento DeRE do evento D-2102 }

  TDeRED2102 = class(TDeRE)
  private
    FevtInfoCotistas: TevtInfoCotistas;
  protected
    function GetEvento: TDeREEvento; override;
  public
    constructor Create; override;
    destructor Destroy; override;

    property evtInfoCotistas: TevtInfoCotistas read FevtInfoCotistas write FevtInfoCotistas;
  end;

implementation

{ TcotaCollectionD2102 }

function TcotaCollectionD2102.GetItem(Index: Integer): TcotaCollectionItemD2102;
begin
  Result := TcotaCollectionItemD2102(inherited Items[Index]);
end;

procedure TcotaCollectionD2102.SetItem(Index: Integer; Value: TcotaCollectionItemD2102);
begin
  inherited Items[Index] := Value;
end;

function TcotaCollectionD2102.New: TcotaCollectionItemD2102;
begin
  Result := TcotaCollectionItemD2102.Create;
  Add(Result);
end;


{ TcotasD2102 }

constructor TcotasD2102.Create;
begin
  inherited Create;
  Fcota := TcotaCollectionD2102.Create;
end;

destructor TcotasD2102.Destroy;
begin
  Fcota.Free;
  inherited Destroy;
end;


{ TcotistaCollectionItemD2102 }

constructor TcotistaCollectionItemD2102.Create;
begin
  inherited Create;
  Fcotas := TcotasD2102.Create;
end;

destructor TcotistaCollectionItemD2102.Destroy;
begin
  Fcotas.Free;
  inherited Destroy;
end;


{ TcotistaCollectionD2102 }

function TcotistaCollectionD2102.GetItem(Index: Integer): TcotistaCollectionItemD2102;
begin
  Result := TcotistaCollectionItemD2102(inherited Items[Index]);
end;

procedure TcotistaCollectionD2102.SetItem(Index: Integer; Value: TcotistaCollectionItemD2102);
begin
  inherited Items[Index] := Value;
end;

function TcotistaCollectionD2102.New: TcotistaCollectionItemD2102;
begin
  Result := TcotistaCollectionItemD2102.Create;
  Add(Result);
end;


{ TcotistasD2102 }

constructor TcotistasD2102.Create;
begin
  inherited Create;
  Fcotista := TcotistaCollectionD2102.Create;
end;

destructor TcotistasD2102.Destroy;
begin
  Fcotista.Free;
  inherited Destroy;
end;


{ TclasseCollectionItemD2102 }

constructor TclasseCollectionItemD2102.Create;
begin
  inherited Create;
  Fcotistas := TcotistasD2102.Create;
end;

destructor TclasseCollectionItemD2102.Destroy;
begin
  Fcotistas.Free;
  inherited Destroy;
end;


{ TclasseCollectionD2102 }

function TclasseCollectionD2102.GetItem(Index: Integer): TclasseCollectionItemD2102;
begin
  Result := TclasseCollectionItemD2102(inherited Items[Index]);
end;

procedure TclasseCollectionD2102.SetItem(Index: Integer; Value: TclasseCollectionItemD2102);
begin
  inherited Items[Index] := Value;
end;

function TclasseCollectionD2102.New: TclasseCollectionItemD2102;
begin
  Result := TclasseCollectionItemD2102.Create;
  Add(Result);
end;


{ TclassesD2102 }

constructor TclassesD2102.Create;
begin
  inherited Create;
  Fclasse := TclasseCollectionD2102.Create;
end;

destructor TclassesD2102.Destroy;
begin
  Fclasse.Free;
  inherited Destroy;
end;


{ TinfoCotistasD2102 }

constructor TinfoCotistasD2102.Create;
begin
  inherited Create;
  Fclasses := TclassesD2102.Create;
end;

destructor TinfoCotistasD2102.Destroy;
begin
  Fclasses.Free;
  inherited Destroy;
end;


{ TevtInfoCotistas }

constructor TevtInfoCotistas.Create;
begin
  inherited Create;
  FideEvento := TideEventoRecibo.Create;
  FideContrib := TideContrib.Create;
  FidePeriodo := TidePeriodoApur.Create;
  FinfoCotistas := TinfoCotistasD2102.Create;
end;

destructor TevtInfoCotistas.Destroy;
begin
  FideEvento.Free;
  FideContrib.Free;
  FidePeriodo.Free;
  FinfoCotistas.Free;
  inherited Destroy;
end;

function TevtInfoCotistas.GetTipoEvento: TTipoEventoDeRE;
begin
  Result := teInfoCotistas;
end;


{ TDeRED2102 }

constructor TDeRED2102.Create;
begin
  inherited Create;
  FevtInfoCotistas := TevtInfoCotistas.Create;
end;

destructor TDeRED2102.Destroy;
begin
  FevtInfoCotistas.Free;
  inherited Destroy;
end;

function TDeRED2102.GetEvento: TDeREEvento;
begin
  Result := FevtInfoCotistas;
end;


initialization
  RegistrarDeRE(teInfoCotistas, TDeRED2102);

end.
