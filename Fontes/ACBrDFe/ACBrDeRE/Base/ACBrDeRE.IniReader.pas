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

unit ACBrDeRE.IniReader;

interface

uses
  Classes, SysUtils,
  IniFiles,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrDFe.RTC.IniReader,
  ACBrDeRE.Classes,
  ACBrDeRE.Conversao,
  ACBrDeRE.IniWriter;

type
  { TDeREIniReader - base abstrata dos leitores de INI dos eventos DeRE.
    Cada evento possui o seu leitor, em ACBrDeRE.Dxxxx.IniReader (Base\Eventos).
    Os grupos comuns a mais de um evento ficam centralizados aqui. }

  TDeREIniReader = class(TDFeRTCIniReader)
  private
    FDeRE: TDeRE;
    FVersaoDF: TVersaoDeRE;
  protected
    // Le o conteudo do evento (ideEvento, ideContrib, ... ) do INI
    procedure Ler_Evento(AINIRec: TMemIniFile); virtual; abstract;

    // Secao [evtXxx]: campos auxiliares usados na montagem do id do evento
    procedure Ler_DadosEvento(AINIRec: TMemIniFile);

    // Grupos comuns a mais de um evento
    procedure Ler_ideEvento(AINIRec: TMemIniFile; AIde: TideEvento);
    procedure Ler_ideEventoRecibo(AINIRec: TMemIniFile; AIde: TideEventoRecibo);
    procedure Ler_ideEventoFin(AINIRec: TMemIniFile; AIde: TideEventoFin);
    procedure Ler_ideContrib(AINIRec: TMemIniFile; AIde: TideContrib);
    procedure Ler_idePeriodo(AINIRec: TMemIniFile; APer: TidePeriodo);
    procedure Ler_idePeriodoApur(AINIRec: TMemIniFile; APer: TidePeriodoApur);
    procedure Ler_idePeriodoApurSub(AINIRec: TMemIniFile; APer: TidePeriodoApurSub);
  public
    constructor Create(AOwner: TDeRE); reintroduce;

    // Le o INI (conteudo ou nome do arquivo) e alimenta o evento do componente
    function LerIni(const AIniString: string): Boolean;

    property DeRE: TDeRE read FDeRE write FDeRE;
    property VersaoDF: TVersaoDeRE read FVersaoDF write FVersaoDF;
  end;

  TDeREIniReaderClass = class of TDeREIniReader;

// Separa o INI em um texto INI por evento (AEventos), removendo a sequencia do evento das secoes
// (ex.: [ideEvento002] -> [ideEvento], [infoConta002001] -> [infoConta001]).
// O INI deve possuir a secao do evento com sequencia ([evtXxx001]), igual ao INI de um unico evento.
procedure SepararIniEventosDeRE(const AIniString: string; AEventos: TStringList);

// Registro dos leitores de INI: cada unit ACBrDeRE.Dxxxx.IniReader registra o seu
// na secao initialization; o componente cria o leitor pelo tipo do evento.
procedure RegistrarIniReaderDeRE(ATipo: TTipoEventoDeRE; AClasse: TDeREIniReaderClass);
function ExisteIniReaderDeRE(ATipo: TTipoEventoDeRE): Boolean;
function CriarIniReaderDeRE(ADeRE: TDeRE): TDeREIniReader;

implementation

uses
  ACBrBase,
  ACBrUtil.Base,
  ACBrUtil.Strings,
  ACBrUtil.FilesIO,
  ACBrUtil.DateTime;

var
  GIniReadersDeRE: array[TTipoEventoDeRE] of TDeREIniReaderClass;

procedure RegistrarIniReaderDeRE(ATipo: TTipoEventoDeRE; AClasse: TDeREIniReaderClass);
begin
  GIniReadersDeRE[ATipo] := AClasse;
end;

function ExisteIniReaderDeRE(ATipo: TTipoEventoDeRE): Boolean;
begin
  Result := GIniReadersDeRE[ATipo] <> nil;
end;

function CriarIniReaderDeRE(ADeRE: TDeRE): TDeREIniReader;
begin
  if GIniReadersDeRE[ADeRE.Evento.TipoEvento] = nil then
    raise EACBrException.CreateFmt('Leitor de INI do evento %s nao registrado.',
      [TipoEventoDeREToStr(ADeRE.Evento.TipoEvento)]);

  Result := GIniReadersDeRE[ADeRE.Evento.TipoEvento].Create(ADeRE);
end;

// Retorna a sequencia do evento (NNN) se a secao for a secao do evento ([evtXxxNNN]) de um
// INI com varios eventos
function SequenciaEventoDeRE(const ASecao: string): string;
var
  sNome, sSeq: string;
  LSchema: TSchemaDeRE;
begin
  Result := '';

  SepararSequenciaSecaoDeRE(ASecao, sNome, sSeq);
  if Length(sSeq) <> 3 then
    Exit;

  for LSchema := Low(TSchemaDeRE) to High(TSchemaDeRE) do
    if SameText(SchemaDeREToStr(LSchema), sNome) then
    begin
      Result := sSeq;
      Exit;
    end;
end;

procedure SepararIniEventosDeRE(const AIniString: string; AEventos: TStringList);
var
  LIni, LSub: TMemIniFile;
  LSecoes, LChaves, LSequencias, LTexto: TStringList;
  i, j, k: Integer;
  sNome, sSeq, sSecao: string;
begin
  LIni := TMemIniFile.Create('');
  LSecoes := TStringList.Create;
  LChaves := TStringList.Create;
  LSequencias := TStringList.Create;
  LTexto := TStringList.Create;
  try
    LSequencias.Sorted := True;
    LSequencias.Duplicates := dupIgnore;

    LerIniArquivoOuString(AIniString, LIni);
    LIni.ReadSections(LSecoes);

    for i := 0 to LSecoes.Count - 1 do
      if SequenciaEventoDeRE(LSecoes[i]) <> '' then
        LSequencias.Add(SequenciaEventoDeRE(LSecoes[i]));

    for k := 0 to LSequencias.Count - 1 do
    begin
      LSub := TMemIniFile.Create('');
      try
        for i := 0 to LSecoes.Count - 1 do
        begin
          SepararSequenciaSecaoDeRE(LSecoes[i], sNome, sSeq);
          if Copy(sSeq, 1, 3) <> LSequencias[k] then
            Continue;

          // Remove a sequencia do evento, mantendo as sequencias dos itens
          sSecao := sNome + Copy(sSeq, 4, MaxInt);
          LIni.ReadSection(LSecoes[i], LChaves);

          for j := 0 to LChaves.Count - 1 do
            LSub.WriteString(sSecao, LChaves[j], LIni.ReadString(LSecoes[i], LChaves[j], ''));
        end;

        LTexto.Clear;
        LSub.GetStrings(LTexto);
        AEventos.Add(LTexto.Text);
      finally
        LSub.Free;
      end;
    end;
  finally
    LTexto.Free;
    LSequencias.Free;
    LChaves.Free;
    LSecoes.Free;
    LIni.Free;
  end;
end;

{ TDeREIniReader }

constructor TDeREIniReader.Create(AOwner: TDeRE);
begin
  inherited Create;

  FDeRE := AOwner;
  FVersaoDF := VERSAO_DERE_PADRAO;
end;

function TDeREIniReader.LerIni(const AIniString: string): Boolean;
var
  INIRec: TMemIniFile;
begin
  Result := True;

  INIRec := TMemIniFile.Create('');
  try
    LerIniArquivoOuString(AIniString, INIRec);

    Ler_DadosEvento(INIRec);
    Ler_Evento(INIRec);
  finally
    INIRec.Free;
  end;
end;

procedure TDeREIniReader.Ler_DadosEvento(AINIRec: TMemIniFile);
var
  sSecao: string;
begin
  sSecao := SchemaDeREToStr(FDeRE.Evento.Schema);

  FVersaoDF := StrToVersaoDeRE(AINIRec.ReadString(sSecao, 'versao', VersaoDeREToStr(FVersaoDF)));
  FDeRE.Evento.nrInscCompleto := AINIRec.ReadString(sSecao, 'nrInscCompleto', '');
  FDeRE.Evento.dataGeracao := StringToDateTime(AINIRec.ReadString(sSecao, 'dataGeracao', '0'));
  FDeRE.Evento.sequencial := AINIRec.ReadInteger(sSecao, 'sequencial', 0);
end;

procedure TDeREIniReader.Ler_ideEvento(AINIRec: TMemIniFile; AIde: TideEvento);
const
  sSecao = 'ideEvento';
var
  sMotExcl: string;
begin
  AIde.tpOper := StrTotpOperDeRE(AINIRec.ReadString(sSecao, 'tpOper', '1'));

  sMotExcl := AINIRec.ReadString(sSecao, 'motExcl', '');
  AIde.TemmotExcl := sMotExcl <> '';
  if AIde.TemmotExcl then
    AIde.motExcl := StrTomotExclDeRE(sMotExcl);

  AIde.nrProc := AINIRec.ReadString(sSecao, 'nrProc', '');
  AIde.tpAmb := StrToTipoAmbiente(AINIRec.ReadString(sSecao, 'tpAmb', '2'));
  AIde.aplicEmi := StrToaplicEmiDeRE(AINIRec.ReadString(sSecao, 'aplicEmi', '1'));
  AIde.verAplic := AINIRec.ReadString(sSecao, 'verAplic', '');
end;

procedure TDeREIniReader.Ler_ideEventoRecibo(AINIRec: TMemIniFile; AIde: TideEventoRecibo);
const
  sSecao = 'ideEvento';
var
  sMotExcl: string;
begin
  AIde.tpOper := StrTotpOperDeRE(AINIRec.ReadString(sSecao, 'tpOper', '1'));

  sMotExcl := AINIRec.ReadString(sSecao, 'motExcl', '');
  AIde.TemmotExcl := sMotExcl <> '';
  if AIde.TemmotExcl then
    AIde.motExcl := StrTomotExclDeRE(sMotExcl);

  AIde.nrProc := AINIRec.ReadString(sSecao, 'nrProc', '');
  AIde.nrRecibo := AINIRec.ReadString(sSecao, 'nrRecibo', '');
  AIde.tpAmb := StrToTipoAmbiente(AINIRec.ReadString(sSecao, 'tpAmb', '2'));
  AIde.aplicEmi := StrToaplicEmiDeRE(AINIRec.ReadString(sSecao, 'aplicEmi', '1'));
  AIde.verAplic := AINIRec.ReadString(sSecao, 'verAplic', '');
end;

procedure TDeREIniReader.Ler_ideEventoFin(AINIRec: TMemIniFile; AIde: TideEventoFin);
const
  sSecao = 'ideEvento';
begin
  AIde.finEvt := StrTofinalidadeEvtDeRE(AINIRec.ReadString(sSecao, 'finEvt', '11'));
  AIde.tpAmb := StrToTipoAmbiente(AINIRec.ReadString(sSecao, 'tpAmb', '2'));
  AIde.aplicEmi := StrToaplicEmiDeRE(AINIRec.ReadString(sSecao, 'aplicEmi', '1'));
  AIde.verAplic := AINIRec.ReadString(sSecao, 'verAplic', '');
end;

procedure TDeREIniReader.Ler_ideContrib(AINIRec: TMemIniFile; AIde: TideContrib);
begin
  AIde.nrInsc := AINIRec.ReadString('ideContrib', 'nrInsc', '');
end;

procedure TDeREIniReader.Ler_idePeriodo(AINIRec: TMemIniFile; APer: TidePeriodo);
const
  sSecao = 'idePeriodo';
  sNova = 'novaValidade';
var
  sFim: string;
begin
  APer.iniValid := StringToDateTime(AINIRec.ReadString(sSecao, 'iniValid', '0'));

  sFim := AINIRec.ReadString(sSecao, 'fimValid', '');
  APer.TemfimValid := sFim <> '';
  if APer.TemfimValid then
    APer.fimValid := StringToDateTime(sFim);

  APer.TemNovaValidade := AINIRec.SectionExists(sNova);
  if APer.TemNovaValidade then
  begin
    APer.novaValidade.iniValid := StringToDateTime(AINIRec.ReadString(sNova, 'iniValid', '0'));

    sFim := AINIRec.ReadString(sNova, 'fimValid', '');
    APer.novaValidade.TemfimValid := sFim <> '';
    if APer.novaValidade.TemfimValid then
      APer.novaValidade.fimValid := StringToDateTime(sFim);
  end;
end;

procedure TDeREIniReader.Ler_idePeriodoApur(AINIRec: TMemIniFile; APer: TidePeriodoApur);
begin
  APer.perApur := AINIRec.ReadString('idePeriodo', 'perApur', '');
end;

procedure TDeREIniReader.Ler_idePeriodoApurSub(AINIRec: TMemIniFile; APer: TidePeriodoApurSub);
const
  sSecao = 'idePeriodo';
begin
  APer.perApur := AINIRec.ReadString(sSecao, 'perApur', '');
  APer.subPer := AINIRec.ReadInteger(sSecao, 'subPer', 1);
end;

end.
