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

unit ACBrDeRE.IniWriter;

interface

uses
  Classes, SysUtils,
  IniFiles,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrDFe.RTC.IniWriter,
  ACBrDeRE.Classes,
  ACBrDeRE.Conversao;

type
  { TDeREIniWriter - base abstrata dos geradores de INI dos eventos DeRE.
    Cada evento possui o seu gerador, em ACBrDeRE.Dxxxx.IniWriter (Base\Eventos).
    Os grupos comuns a mais de um evento ficam centralizados aqui. }

  TDeREIniWriter = class(TDFeRTCIniWriter)
  private
    FDeRE: TDeRE;
    FVersaoDF: TVersaoDeRE;
  protected
    // Grava o conteudo do evento (ideEvento, ideContrib, ... ) no INI
    procedure Gravar_Evento(AINIRec: TMemIniFile); virtual; abstract;

    // Secao [evtXxx]: campos auxiliares usados na montagem do id do evento
    procedure Gravar_DadosEvento(AINIRec: TMemIniFile);

    // Grupos comuns a mais de um evento
    procedure Gravar_ideEvento(AINIRec: TMemIniFile; AIde: TideEvento);
    procedure Gravar_ideEventoRecibo(AINIRec: TMemIniFile; AIde: TideEventoRecibo);
    procedure Gravar_ideEventoFin(AINIRec: TMemIniFile; AIde: TideEventoFin);
    procedure Gravar_ideContrib(AINIRec: TMemIniFile; AIde: TideContrib);
    procedure Gravar_idePeriodo(AINIRec: TMemIniFile; APer: TidePeriodo);
    procedure Gravar_idePeriodoApur(AINIRec: TMemIniFile; APer: TidePeriodoApur);
    procedure Gravar_idePeriodoApurSub(AINIRec: TMemIniFile; APer: TidePeriodoApurSub);
  public
    constructor Create(AOwner: TDeRE); reintroduce;

    // Retorna o INI do evento, a partir das propriedades carregadas no componente
    function GravarIni: string;

    property DeRE: TDeRE read FDeRE write FDeRE;
    property VersaoDF: TVersaoDeRE read FVersaoDF write FVersaoDF;
  end;

  TDeREIniWriterClass = class of TDeREIniWriter;

// Separa o nome de uma secao do INI em nome (ANome) e sequencias numericas finais (ASeq),
// ex.: 'detAtivo001001' = 'detAtivo' + '001001' (sequencia do item pai + sequencia do item).
procedure SepararSequenciaSecaoDeRE(const ASecao: string; out ANome, ASeq: string);

// Acrescenta ao INI de varios eventos (AIniLote) as secoes do INI de um evento, seguindo o padrao
// dos demais DFe: NomeDaSecao + sequencia do evento (AIndice) + sequencias dos itens, ex.:
// [evtBalancete001], [ideEvento001], [infoConta001001] (evento 1, conta 1).
// Assim o INI pode conter eventos de tipos diferentes.
procedure AdicionarIniEventoDeRE(AIniLote: TMemIniFile; const AIniEvento: string; AIndice: Integer);

// Registro dos geradores de INI: cada unit ACBrDeRE.Dxxxx.IniWriter registra o seu
// na secao initialization; o componente cria o gerador pelo tipo do evento.
procedure RegistrarIniWriterDeRE(ATipo: TTipoEventoDeRE; AClasse: TDeREIniWriterClass);
function ExisteIniWriterDeRE(ATipo: TTipoEventoDeRE): Boolean;
function CriarIniWriterDeRE(ADeRE: TDeRE): TDeREIniWriter;

implementation

uses
  ACBrBase,
  ACBrUtil.Base,
  ACBrUtil.Strings;

var
  GIniWritersDeRE: array[TTipoEventoDeRE] of TDeREIniWriterClass;

procedure RegistrarIniWriterDeRE(ATipo: TTipoEventoDeRE; AClasse: TDeREIniWriterClass);
begin
  GIniWritersDeRE[ATipo] := AClasse;
end;

function ExisteIniWriterDeRE(ATipo: TTipoEventoDeRE): Boolean;
begin
  Result := GIniWritersDeRE[ATipo] <> nil;
end;

function CriarIniWriterDeRE(ADeRE: TDeRE): TDeREIniWriter;
begin
  if GIniWritersDeRE[ADeRE.Evento.TipoEvento] = nil then
    raise EACBrException.CreateFmt('Gerador de INI do evento %s nao registrado.',
      [TipoEventoDeREToStr(ADeRE.Evento.TipoEvento)]);

  Result := GIniWritersDeRE[ADeRE.Evento.TipoEvento].Create(ADeRE);
end;

procedure SepararSequenciaSecaoDeRE(const ASecao: string; out ANome, ASeq: string);
var
  n: Integer;
begin
  n := Length(ASecao);
  while (n > 0) and (ASecao[n] >= '0') and (ASecao[n] <= '9') do
    Dec(n);

  ANome := Copy(ASecao, 1, n);
  ASeq := Copy(ASecao, n + 1, MaxInt);
end;

procedure AdicionarIniEventoDeRE(AIniLote: TMemIniFile; const AIniEvento: string; AIndice: Integer);
var
  LIni: TMemIniFile;
  LLinhas, LSecoes, LChaves: TStringList;
  i, j: Integer;
  sNome, sSeq, sSecao: string;
begin
  LIni := TMemIniFile.Create('');
  LLinhas := TStringList.Create;
  LSecoes := TStringList.Create;
  LChaves := TStringList.Create;
  try
    LLinhas.Text := AIniEvento;
    LIni.SetStrings(LLinhas);
    LIni.ReadSections(LSecoes);

    for i := 0 to LSecoes.Count - 1 do
    begin
      // Sequencia do evento entre o nome e as sequencias dos itens
      SepararSequenciaSecaoDeRE(LSecoes[i], sNome, sSeq);
      sSecao := sNome + IntToStrZero(AIndice, 3) + sSeq;

      LIni.ReadSection(LSecoes[i], LChaves);

      for j := 0 to LChaves.Count - 1 do
        AIniLote.WriteString(sSecao, LChaves[j], LIni.ReadString(LSecoes[i], LChaves[j], ''));
    end;
  finally
    LChaves.Free;
    LSecoes.Free;
    LLinhas.Free;
    LIni.Free;
  end;
end;

{ TDeREIniWriter }

constructor TDeREIniWriter.Create(AOwner: TDeRE);
begin
  inherited Create;

  FDeRE := AOwner;
  FVersaoDF := VERSAO_DERE_PADRAO;
end;

function TDeREIniWriter.GravarIni: string;
var
  INIRec: TMemIniFile;
  IniDeRE: TStringList;
begin
  INIRec := TMemIniFile.Create('');
  try
    Gravar_DadosEvento(INIRec);
    Gravar_Evento(INIRec);

    IniDeRE := TStringList.Create;
    try
      INIRec.GetStrings(IniDeRE);
      Result := StringReplace(IniDeRE.Text, sLineBreak + sLineBreak, sLineBreak, [rfReplaceAll]);
    finally
      IniDeRE.Free;
    end;
  finally
    INIRec.Free;
  end;
end;

procedure TDeREIniWriter.Gravar_DadosEvento(AINIRec: TMemIniFile);
var
  sSecao: string;
begin
  sSecao := SchemaDeREToStr(FDeRE.Evento.Schema);

  AINIRec.WriteString(sSecao, 'versao', VersaoDeREToStr(FVersaoDF));
  AINIRec.WriteString(sSecao, 'nrInscCompleto', FDeRE.Evento.nrInscCompleto);

  if FDeRE.Evento.dataGeracao <> 0 then
    AINIRec.WriteString(sSecao, 'dataGeracao', DateTimeToStr(FDeRE.Evento.dataGeracao));

  AINIRec.WriteInteger(sSecao, 'sequencial', FDeRE.Evento.sequencial);
end;

procedure TDeREIniWriter.Gravar_ideEvento(AINIRec: TMemIniFile; AIde: TideEvento);
const
  sSecao = 'ideEvento';
begin
  AINIRec.WriteString(sSecao, 'tpOper', tpOperDeREToStr(AIde.tpOper));

  if AIde.TemmotExcl then
    AINIRec.WriteString(sSecao, 'motExcl', motExclDeREToStr(AIde.motExcl));

  AINIRec.WriteString(sSecao, 'nrProc', AIde.nrProc);
  AINIRec.WriteString(sSecao, 'tpAmb', TipoAmbienteToStr(AIde.tpAmb));
  AINIRec.WriteString(sSecao, 'aplicEmi', aplicEmiDeREToStr(AIde.aplicEmi));
  AINIRec.WriteString(sSecao, 'verAplic', AIde.verAplic);
end;

procedure TDeREIniWriter.Gravar_ideEventoRecibo(AINIRec: TMemIniFile; AIde: TideEventoRecibo);
const
  sSecao = 'ideEvento';
begin
  AINIRec.WriteString(sSecao, 'tpOper', tpOperDeREToStr(AIde.tpOper));

  if AIde.TemmotExcl then
    AINIRec.WriteString(sSecao, 'motExcl', motExclDeREToStr(AIde.motExcl));

  AINIRec.WriteString(sSecao, 'nrProc', AIde.nrProc);
  AINIRec.WriteString(sSecao, 'nrRecibo', AIde.nrRecibo);
  AINIRec.WriteString(sSecao, 'tpAmb', TipoAmbienteToStr(AIde.tpAmb));
  AINIRec.WriteString(sSecao, 'aplicEmi', aplicEmiDeREToStr(AIde.aplicEmi));
  AINIRec.WriteString(sSecao, 'verAplic', AIde.verAplic);
end;

procedure TDeREIniWriter.Gravar_ideEventoFin(AINIRec: TMemIniFile; AIde: TideEventoFin);
const
  sSecao = 'ideEvento';
begin
  AINIRec.WriteString(sSecao, 'finEvt', finalidadeEvtDeREToStr(AIde.finEvt));
  AINIRec.WriteString(sSecao, 'tpAmb', TipoAmbienteToStr(AIde.tpAmb));
  AINIRec.WriteString(sSecao, 'aplicEmi', aplicEmiDeREToStr(AIde.aplicEmi));
  AINIRec.WriteString(sSecao, 'verAplic', AIde.verAplic);
end;

procedure TDeREIniWriter.Gravar_ideContrib(AINIRec: TMemIniFile; AIde: TideContrib);
begin
  AINIRec.WriteString('ideContrib', 'nrInsc', AIde.nrInsc);
end;

procedure TDeREIniWriter.Gravar_idePeriodo(AINIRec: TMemIniFile; APer: TidePeriodo);
const
  sSecao = 'idePeriodo';
  sNova = 'novaValidade';
begin
  AINIRec.WriteString(sSecao, 'iniValid', DateToStr(APer.iniValid));

  if APer.TemfimValid then
    AINIRec.WriteString(sSecao, 'fimValid', DateToStr(APer.fimValid));

  if APer.TemNovaValidade then
  begin
    AINIRec.WriteString(sNova, 'iniValid', DateToStr(APer.novaValidade.iniValid));

    if APer.novaValidade.TemfimValid then
      AINIRec.WriteString(sNova, 'fimValid', DateToStr(APer.novaValidade.fimValid));
  end;
end;

procedure TDeREIniWriter.Gravar_idePeriodoApur(AINIRec: TMemIniFile; APer: TidePeriodoApur);
begin
  AINIRec.WriteString('idePeriodo', 'perApur', APer.perApur);
end;

procedure TDeREIniWriter.Gravar_idePeriodoApurSub(AINIRec: TMemIniFile; APer: TidePeriodoApurSub);
const
  sSecao = 'idePeriodo';
begin
  AINIRec.WriteString(sSecao, 'perApur', APer.perApur);
  AINIRec.WriteInteger(sSecao, 'subPer', APer.subPer);
end;

end.
