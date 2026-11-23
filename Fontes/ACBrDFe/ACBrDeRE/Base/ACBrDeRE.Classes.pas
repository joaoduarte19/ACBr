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

unit ACBrDeRE.Classes;

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
  ACBrDFe,
  ACBrDFe.Conversao,
  ACBrDeRE.Conversao;

type

  { TideEvento }

  TideEvento = class(TObject)
  private
    FtpOper: TTpOperDeRE;
    FmotExcl: TMotExclDeRE;
    FTemmotExcl: Boolean;
    FnrProc: string;
    FtpAmb: TACBrTipoAmbiente;
    FaplicEmi: TAplicEmiDeRE;
    FverAplic: string;
  public
    procedure Assign(Source: TideEvento);

    property tpOper: TTpOperDeRE read FtpOper write FtpOper;
    property motExcl: TMotExclDeRE read FmotExcl write FmotExcl;
    property TemmotExcl: Boolean read FTemmotExcl write FTemmotExcl;
    property nrProc: string read FnrProc write FnrProc;
    property tpAmb: TACBrTipoAmbiente read FtpAmb write FtpAmb;
    property aplicEmi: TAplicEmiDeRE read FaplicEmi write FaplicEmi;
    property verAplic: string read FverAplic write FverAplic;
  end;

  { TideContrib }

  TideContrib = class(TObject)
  private
    FnrInsc: string;
  public
    procedure Assign(Source: TideContrib);

    property nrInsc: string read FnrInsc write FnrInsc;
  end;

  { TnovaValidade }

  TnovaValidade = class(TObject)
  private
    FiniValid: TDateTime;
    FfimValid: TDateTime;
    FTemfimValid: Boolean;
  public
    procedure Assign(Source: TnovaValidade);

    property iniValid: TDateTime read FiniValid write FiniValid;
    property fimValid: TDateTime read FfimValid write FfimValid;
    property TemfimValid: Boolean read FTemfimValid write FTemfimValid;
  end;

  { TidePeriodo }

  TidePeriodo = class(TObject)
  private
    FiniValid: TDateTime;
    FfimValid: TDateTime;
    FTemfimValid: Boolean;
    FTemNovaValidade: Boolean;
    FnovaValidade: TnovaValidade;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Assign(Source: TidePeriodo);

    property iniValid: TDateTime read FiniValid write FiniValid;
    property fimValid: TDateTime read FfimValid write FfimValid;
    property TemfimValid: Boolean read FTemfimValid write FTemfimValid;
    property TemNovaValidade: Boolean read FTemNovaValidade write FTemNovaValidade;
    property novaValidade: TnovaValidade read FnovaValidade write FnovaValidade;
  end;

  { TideEventoRecibo - ideEvento dos eventos que retificam/excluem por nrRecibo (D-1101, D-1121, ...) }

  TideEventoRecibo = class(TObject)
  private
    FtpOper: TTpOperDeRE;
    FmotExcl: TMotExclDeRE;
    FTemmotExcl: Boolean;
    FnrProc: string;
    FnrRecibo: string;
    FtpAmb: TACBrTipoAmbiente;
    FaplicEmi: TAplicEmiDeRE;
    FverAplic: string;
  public
    procedure Assign(Source: TideEventoRecibo);

    property tpOper: TTpOperDeRE read FtpOper write FtpOper;
    property motExcl: TMotExclDeRE read FmotExcl write FmotExcl;
    property TemmotExcl: Boolean read FTemmotExcl write FTemmotExcl;
    property nrProc: string read FnrProc write FnrProc;
    property nrRecibo: string read FnrRecibo write FnrRecibo;
    property tpAmb: TACBrTipoAmbiente read FtpAmb write FtpAmb;
    property aplicEmi: TAplicEmiDeRE read FaplicEmi write FaplicEmi;
    property verAplic: string read FverAplic write FverAplic;
  end;

  { TidePeriodoApur - idePeriodo dos eventos periodicos (perApur no formato AAAA-MM) }

  TidePeriodoApur = class(TObject)
  private
    FperApur: string;
  public
    procedure Assign(Source: TidePeriodoApur);

    property perApur: string read FperApur write FperApur;
  end;

  { TideEventoFin - ideEvento dos eventos transacionais (D-22xx, D-3201, D-4201): finEvt no lugar de tpOper }

  TideEventoFin = class(TObject)
  private
    FfinEvt: TFinalidadeEvtDeRE;
    FtpAmb: TACBrTipoAmbiente;
    FaplicEmi: TAplicEmiDeRE;
    FverAplic: string;
  public
    procedure Assign(Source: TideEventoFin);

    property finEvt: TFinalidadeEvtDeRE read FfinEvt write FfinEvt;
    property tpAmb: TACBrTipoAmbiente read FtpAmb write FtpAmb;
    property aplicEmi: TAplicEmiDeRE read FaplicEmi write FaplicEmi;
    property verAplic: string read FverAplic write FverAplic;
  end;

  { TidePeriodoApurSub - idePeriodo com subperiodo de agrupamento das operacoes (perApur + subPer) }

  TidePeriodoApurSub = class(TObject)
  private
    FperApur: string;
    FsubPer: Integer;
  public
    procedure Assign(Source: TidePeriodoApurSub);

    property perApur: string read FperApur write FperApur;
    // Subperiodo: depende do evento (ex.: 1-5 semanas, 1-6 janelas de 5 dias, 1 mes completo)
    property subPer: Integer read FsubPer write FsubPer;
  end;

  { TDatasDeRE - lista simples de datas (campos repetidos do tipo data, ex.: dtNascDep) }

  TDatasDeRE = class(TObject)
  private
    FItens: array of TDateTime;
    function GetCount: Integer;
    function GetItem(Index: Integer): TDateTime;
  public
    function Add(AData: TDateTime): Integer;
    procedure Clear;

    property Count: Integer read GetCount;
    property Items[Index: Integer]: TDateTime read GetItem; default;
  end;

  { TDeREEvento - base abstrata dos eventos (evtInfoContrib, evtPGCC, ...) }

  TDeREEvento = class(TObject)
  private
    Fid: string;
    FXML: string;
    FXMLOriginal: string;
    FXMLAssinado: string;
    // Campos auxiliares para montagem do id (42 chars)
    FnrInscCompleto: string;
    FdataGeracao: TDateTime;
    Fsequencial: Integer;
  protected
    function GetTipoEvento: TTipoEventoDeRE; virtual; abstract;
    function GetSchema: TSchemaDeRE; virtual;
  public
    constructor Create; virtual;

    // Assina o XML do evento (ja em UTF-8) com o certificado do componente ACBrDeRE.
    // Valida as libs de criptografia/assinatura (SHA256) como o ACBrReinf.
    function Assinar(AACBrDeRE: TACBrDFe; const AXMLEvento: string): string;

    property TipoEvento: TTipoEventoDeRE read GetTipoEvento;
    property Schema: TSchemaDeRE read GetSchema;

    property id: string read Fid write Fid;
    property XML: string read FXML write FXML;
    property XMLOriginal: string read FXMLOriginal write FXMLOriginal;
    property XMLAssinado: string read FXMLAssinado write FXMLAssinado;

    property nrInscCompleto: string read FnrInscCompleto write FnrInscCompleto;
    property dataGeracao: TDateTime read FdataGeracao write FdataGeracao;
    property sequencial: Integer read Fsequencial write Fsequencial;
  end;

  { TDeRE - base abstrata do documento DeRE (evento + assinatura) }

  TDeRE = class(TObject)
  private
    FSignature: TSignature;
  protected
    function GetEvento: TDeREEvento; virtual; abstract;
  public
    constructor Create; virtual;
    destructor Destroy; override;

    property Evento: TDeREEvento read GetEvento;
    property Signature: TSignature read FSignature write FSignature;
  end;

  TDeREClass = class of TDeRE;

// Registro dos eventos: cada unit de evento (ACBrDeRE.Dxxxx.Classes) registra a sua
// classe na secao initialization; o componente cria o TDeRE pelo tipo do evento.
procedure RegistrarDeRE(ATipo: TTipoEventoDeRE; AClasse: TDeREClass);
function CriarDeRE(ATipo: TTipoEventoDeRE): TDeRE;

implementation

uses
  ACBrDFeSSL,
  ACBrDeRE;

var
  GClassesDeRE: array[TTipoEventoDeRE] of TDeREClass;

procedure RegistrarDeRE(ATipo: TTipoEventoDeRE; AClasse: TDeREClass);
begin
  GClassesDeRE[ATipo] := AClasse;
end;

function CriarDeRE(ATipo: TTipoEventoDeRE): TDeRE;
begin
  if GClassesDeRE[ATipo] = nil then
    raise EACBrException.CreateFmt('Evento DeRE %s nao registrado.',
      [TipoEventoDeREToStr(ATipo)]);

  Result := GClassesDeRE[ATipo].Create;
end;

{ TideEvento }

procedure TideEvento.Assign(Source: TideEvento);
begin
  FtpOper := Source.tpOper;
  FmotExcl := Source.motExcl;
  FTemmotExcl := Source.TemmotExcl;
  FnrProc := Source.nrProc;
  FtpAmb := Source.tpAmb;
  FaplicEmi := Source.aplicEmi;
  FverAplic := Source.verAplic;
end;

{ TideContrib }

procedure TideContrib.Assign(Source: TideContrib);
begin
  FnrInsc := Source.nrInsc;
end;

{ TnovaValidade }

procedure TnovaValidade.Assign(Source: TnovaValidade);
begin
  FiniValid := Source.iniValid;
  FfimValid := Source.fimValid;
  FTemfimValid := Source.TemfimValid;
end;

{ TidePeriodo }

constructor TidePeriodo.Create;
begin
  inherited Create;
  FnovaValidade := TnovaValidade.Create;
  FTemfimValid := False;
  FTemNovaValidade := False;
end;

destructor TidePeriodo.Destroy;
begin
  FnovaValidade.Free;
  inherited Destroy;
end;

procedure TidePeriodo.Assign(Source: TidePeriodo);
begin
  FiniValid := Source.iniValid;
  FfimValid := Source.fimValid;
  FTemfimValid := Source.TemfimValid;
  FTemNovaValidade := Source.TemNovaValidade;
  FnovaValidade.Assign(Source.novaValidade);
end;

{ TideEventoRecibo }

procedure TideEventoRecibo.Assign(Source: TideEventoRecibo);
begin
  FtpOper := Source.tpOper;
  FmotExcl := Source.motExcl;
  FTemmotExcl := Source.TemmotExcl;
  FnrProc := Source.nrProc;
  FnrRecibo := Source.nrRecibo;
  FtpAmb := Source.tpAmb;
  FaplicEmi := Source.aplicEmi;
  FverAplic := Source.verAplic;
end;

{ TidePeriodoApur }

procedure TidePeriodoApur.Assign(Source: TidePeriodoApur);
begin
  FperApur := Source.perApur;
end;

{ TideEventoFin }

procedure TideEventoFin.Assign(Source: TideEventoFin);
begin
  FfinEvt := Source.finEvt;
  FtpAmb := Source.tpAmb;
  FaplicEmi := Source.aplicEmi;
  FverAplic := Source.verAplic;
end;

{ TidePeriodoApurSub }

procedure TidePeriodoApurSub.Assign(Source: TidePeriodoApurSub);
begin
  FperApur := Source.perApur;
  FsubPer := Source.subPer;
end;

{ TDatasDeRE }

function TDatasDeRE.Add(AData: TDateTime): Integer;
begin
  Result := Length(FItens);
  SetLength(FItens, Result + 1);
  FItens[Result] := AData;
end;

procedure TDatasDeRE.Clear;
begin
  SetLength(FItens, 0);
end;

function TDatasDeRE.GetCount: Integer;
begin
  Result := Length(FItens);
end;

function TDatasDeRE.GetItem(Index: Integer): TDateTime;
begin
  Result := FItens[Index];
end;

{ TDeREEvento }

constructor TDeREEvento.Create;
begin
  inherited Create;
  Fsequencial := 1;
end;

function TDeREEvento.GetSchema: TSchemaDeRE;
begin
  Result := TipoEventoDeREToSchema(GetTipoEvento);
end;

function TDeREEvento.Assinar(AACBrDeRE: TACBrDFe; const AXMLEvento: string): string;
var
  LXMLAss: string;
begin
  Result := '';

  // XML ja deve estar em UTF8, para poder ser assinado
  FXMLOriginal := AXMLEvento;

  if not (AACBrDeRE.SSL.SSLCryptLib in [cryOpenSSL, cryWinCrypt]) then
    raise EACBrDeREException.Create(ACBRDERE_CErroCryptLib);

  if not (AACBrDeRE.SSL.SSLXmlSignLib in [xsXmlSec, xsLibXml2]) then
    raise EACBrDeREException.Create(ACBRDERE_CErroSignLib);

  LXMLAss := AACBrDeRE.SSL.Assinar(AXMLEvento, 'DeRE', SchemaDeREToStr(Schema),
    '', '', '', 'id');

  FXMLAssinado := LXMLAss;
  FXML := LXMLAss;
  Result := LXMLAss;
end;

{ TDeRE }

constructor TDeRE.Create;
begin
  inherited Create;
  FSignature := TSignature.Create;
end;

destructor TDeRE.Destroy;
begin
  FSignature.Free;
  inherited Destroy;
end;

end.
