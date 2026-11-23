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

unit ACBrDeRE.D1001.Classes;

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

  { TregTribSecundCollectionItemD1001 }

  TregTribSecundCollectionItemD1001 = class(TObject)
  private
    FregTribSecund: TRegTribDeRE;
  public
    property regTribSecund: TRegTribDeRE read FregTribSecund write FregTribSecund;
  end;

  { TregTribSecundCollectionD1001 }

  TregTribSecundCollectionD1001 = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TregTribSecundCollectionItemD1001;
    procedure SetItem(Index: Integer; Value: TregTribSecundCollectionItemD1001);
  public
    function New: TregTribSecundCollectionItemD1001;
    property Items[Index: Integer]: TregTribSecundCollectionItemD1001 read GetItem write SetItem; default;
  end;

  { TtpAtividadeCollectionItemD1001 }

  TtpAtividadeCollectionItemD1001 = class(TObject)
  private
    FtpAtividade: string;
  public
    property tpAtividade: string read FtpAtividade write FtpAtividade;
  end;

  { TtpAtividadeCollectionD1001 }

  TtpAtividadeCollectionD1001 = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TtpAtividadeCollectionItemD1001;
    procedure SetItem(Index: Integer; Value: TtpAtividadeCollectionItemD1001);
  public
    function New: TtpAtividadeCollectionItemD1001;
    property Items[Index: Integer]: TtpAtividadeCollectionItemD1001 read GetItem write SetItem; default;
  end;

  { TUFCredencCollectionItemD1001 }

  TUFCredencCollectionItemD1001 = class(TObject)
  private
    FUFCredenc: Integer;
  public
    property UFCredenc: Integer read FUFCredenc write FUFCredenc;
  end;

  { TUFCredencCollectionD1001 }

  TUFCredencCollectionD1001 = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TUFCredencCollectionItemD1001;
    procedure SetItem(Index: Integer; Value: TUFCredencCollectionItemD1001);
  public
    function New: TUFCredencCollectionItemD1001;
    property Items[Index: Integer]: TUFCredencCollectionItemD1001 read GetItem write SetItem; default;
  end;

  { TservFinancD1001 }

  TservFinancD1001 = class(TObject)
  private
    FtpAtividades: TtpAtividadeCollectionD1001;
    procedure SettpAtividades(const Value: TtpAtividadeCollectionD1001);
  public
    constructor Create;
    destructor Destroy; override;

    property tpAtividades: TtpAtividadeCollectionD1001 read FtpAtividades write SettpAtividades;
  end;

  { TplAssistSaudeD1001 }

  TplAssistSaudeD1001 = class(TObject)
  private
    FtpAtividades: TtpAtividadeCollectionD1001;
    procedure SettpAtividades(const Value: TtpAtividadeCollectionD1001);
  public
    constructor Create;
    destructor Destroy; override;

    property tpAtividades: TtpAtividadeCollectionD1001 read FtpAtividades write SettpAtividades;
  end;

  { TprognosticosD1001 }

  TprognosticosD1001 = class(TObject)
  private
    FtpAtividades: TtpAtividadeCollectionD1001;
    FUFsCredenc: TUFCredencCollectionD1001;
    procedure SettpAtividades(const Value: TtpAtividadeCollectionD1001);
    procedure SetUFsCredenc(const Value: TUFCredencCollectionD1001);
  public
    constructor Create;
    destructor Destroy; override;

    property tpAtividades: TtpAtividadeCollectionD1001 read FtpAtividades write SettpAtividades;
    property UFsCredenc: TUFCredencCollectionD1001 read FUFsCredenc write SetUFsCredenc;
  end;

  { TinfoContribD1001 }

  TinfoContribD1001 = class(TObject)
  private
    FTeminfoContrib: Boolean;
    FregTribPrinc: TRegTribDeRE;
    FregTribSecund: TregTribSecundCollectionD1001;
    FindNatTrib: TIndNatTribDeRE;
    FTemservFinanc: Boolean;
    FservFinanc: TservFinancD1001;
    FTemplAssistSaude: Boolean;
    FplAssistSaude: TplAssistSaudeD1001;
    FTemprognosticos: Boolean;
    Fprognosticos: TprognosticosD1001;
    procedure SetregTribSecund(const Value: TregTribSecundCollectionD1001);
  public
    constructor Create;
    destructor Destroy; override;

    property TeminfoContrib: Boolean read FTeminfoContrib write FTeminfoContrib;
    property regTribPrinc: TRegTribDeRE read FregTribPrinc write FregTribPrinc;
    property regTribSecund: TregTribSecundCollectionD1001 read FregTribSecund write SetregTribSecund;
    property indNatTrib: TIndNatTribDeRE read FindNatTrib write FindNatTrib;
    property TemservFinanc: Boolean read FTemservFinanc write FTemservFinanc;
    property servFinanc: TservFinancD1001 read FservFinanc write FservFinanc;
    property TemplAssistSaude: Boolean read FTemplAssistSaude write FTemplAssistSaude;
    property plAssistSaude: TplAssistSaudeD1001 read FplAssistSaude write FplAssistSaude;
    property Temprognosticos: Boolean read FTemprognosticos write FTemprognosticos;
    property prognosticos: TprognosticosD1001 read Fprognosticos write Fprognosticos;
  end;

  { TevtInfoContrib }

  TevtInfoContrib = class(TDeREEvento)
  private
    FideEvento: TideEvento;
    FideContrib: TideContrib;
    FidePeriodo: TidePeriodo;
    FinfoContrib: TinfoContribD1001;
  protected
    function GetTipoEvento: TTipoEventoDeRE; override;
  public
    constructor Create; override;
    destructor Destroy; override;

    property ideEvento: TideEvento read FideEvento write FideEvento;
    property ideContrib: TideContrib read FideContrib write FideContrib;
    property idePeriodo: TidePeriodo read FidePeriodo write FidePeriodo;
    property infoContrib: TinfoContribD1001 read FinfoContrib write FinfoContrib;
  end;

  { TDeRED1001 - documento DeRE do evento D-1001 }

  TDeRED1001 = class(TDeRE)
  private
    FevtInfoContrib: TevtInfoContrib;
  protected
    function GetEvento: TDeREEvento; override;
  public
    constructor Create; override;
    destructor Destroy; override;

    property evtInfoContrib: TevtInfoContrib read FevtInfoContrib write FevtInfoContrib;
  end;

implementation

{ TregTribSecundCollectionD1001 }

function TregTribSecundCollectionD1001.GetItem(Index: Integer): TregTribSecundCollectionItemD1001;
begin
  Result := TregTribSecundCollectionItemD1001(inherited Items[Index]);
end;

procedure TregTribSecundCollectionD1001.SetItem(Index: Integer; Value: TregTribSecundCollectionItemD1001);
begin
  inherited Items[Index] := Value;
end;

function TregTribSecundCollectionD1001.New: TregTribSecundCollectionItemD1001;
begin
  Result := TregTribSecundCollectionItemD1001.Create;
  Add(Result);
end;

{ TtpAtividadeCollectionD1001 }

function TtpAtividadeCollectionD1001.GetItem(Index: Integer): TtpAtividadeCollectionItemD1001;
begin
  Result := TtpAtividadeCollectionItemD1001(inherited Items[Index]);
end;

procedure TtpAtividadeCollectionD1001.SetItem(Index: Integer; Value: TtpAtividadeCollectionItemD1001);
begin
  inherited Items[Index] := Value;
end;

function TtpAtividadeCollectionD1001.New: TtpAtividadeCollectionItemD1001;
begin
  Result := TtpAtividadeCollectionItemD1001.Create;
  Add(Result);
end;

{ TUFCredencCollectionD1001 }

function TUFCredencCollectionD1001.GetItem(Index: Integer): TUFCredencCollectionItemD1001;
begin
  Result := TUFCredencCollectionItemD1001(inherited Items[Index]);
end;

procedure TUFCredencCollectionD1001.SetItem(Index: Integer; Value: TUFCredencCollectionItemD1001);
begin
  inherited Items[Index] := Value;
end;

function TUFCredencCollectionD1001.New: TUFCredencCollectionItemD1001;
begin
  Result := TUFCredencCollectionItemD1001.Create;
  Add(Result);
end;

{ TservFinancD1001 }

constructor TservFinancD1001.Create;
begin
  inherited Create;
  FtpAtividades := TtpAtividadeCollectionD1001.Create;
end;

destructor TservFinancD1001.Destroy;
begin
  FtpAtividades.Free;
  inherited Destroy;
end;

procedure TservFinancD1001.SettpAtividades(const Value: TtpAtividadeCollectionD1001);
begin
  FtpAtividades := Value;
end;

{ TplAssistSaudeD1001 }

constructor TplAssistSaudeD1001.Create;
begin
  inherited Create;
  FtpAtividades := TtpAtividadeCollectionD1001.Create;
end;

destructor TplAssistSaudeD1001.Destroy;
begin
  FtpAtividades.Free;
  inherited Destroy;
end;

procedure TplAssistSaudeD1001.SettpAtividades(const Value: TtpAtividadeCollectionD1001);
begin
  FtpAtividades := Value;
end;

{ TprognosticosD1001 }

constructor TprognosticosD1001.Create;
begin
  inherited Create;
  FtpAtividades := TtpAtividadeCollectionD1001.Create;
  FUFsCredenc := TUFCredencCollectionD1001.Create;
end;

destructor TprognosticosD1001.Destroy;
begin
  FtpAtividades.Free;
  FUFsCredenc.Free;
  inherited Destroy;
end;

procedure TprognosticosD1001.SettpAtividades(const Value: TtpAtividadeCollectionD1001);
begin
  FtpAtividades := Value;
end;

procedure TprognosticosD1001.SetUFsCredenc(const Value: TUFCredencCollectionD1001);
begin
  FUFsCredenc := Value;
end;

{ TinfoContribD1001 }

constructor TinfoContribD1001.Create;
begin
  inherited Create;
  FregTribSecund := TregTribSecundCollectionD1001.Create;
  FservFinanc := TservFinancD1001.Create;
  FplAssistSaude := TplAssistSaudeD1001.Create;
  Fprognosticos := TprognosticosD1001.Create;
  FTeminfoContrib := False;
  FTemservFinanc := False;
  FTemplAssistSaude := False;
  FTemprognosticos := False;
end;

destructor TinfoContribD1001.Destroy;
begin
  FregTribSecund.Free;
  FservFinanc.Free;
  FplAssistSaude.Free;
  Fprognosticos.Free;
  inherited Destroy;
end;

procedure TinfoContribD1001.SetregTribSecund(const Value: TregTribSecundCollectionD1001);
begin
  FregTribSecund := Value;
end;

{ TevtInfoContrib }

constructor TevtInfoContrib.Create;
begin
  inherited Create;
  FideEvento := TideEvento.Create;
  FideContrib := TideContrib.Create;
  FidePeriodo := TidePeriodo.Create;
  FinfoContrib := TinfoContribD1001.Create;
end;

destructor TevtInfoContrib.Destroy;
begin
  FideEvento.Free;
  FideContrib.Free;
  FidePeriodo.Free;
  FinfoContrib.Free;
  inherited Destroy;
end;

function TevtInfoContrib.GetTipoEvento: TTipoEventoDeRE;
begin
  Result := teInfoContrib;
end;

{ TDeRED1001 }

constructor TDeRED1001.Create;
begin
  inherited Create;
  FevtInfoContrib := TevtInfoContrib.Create;
end;

destructor TDeRED1001.Destroy;
begin
  FevtInfoContrib.Free;
  inherited Destroy;
end;

function TDeRED1001.GetEvento: TDeREEvento;
begin
  Result := FevtInfoContrib;
end;

initialization
  RegistrarDeRE(teInfoContrib, TDeRED1001);

end.
