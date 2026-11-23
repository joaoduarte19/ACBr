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

unit ACBrDeRE.XmlWriter;

interface

uses
  Classes, SysUtils,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrDFe.RTC.XmlWriter,
  ACBrXmlDocument,
  ACBrXmlWriter,
  ACBrDeRE.Classes,
  ACBrDeRE.Conversao;

type
  TDeREXmlWriterOptions = class(TACBrXmlWriterOptions)
  private
    FGerarTagAssinatura: TACBrTagAssinatura;
  public
    property GerarTagAssinatura: TACBrTagAssinatura read FGerarTagAssinatura write FGerarTagAssinatura;
  end;

  { TDeREXmlWriter - base abstrata dos geradores de XML dos eventos DeRE.
    Cada evento possui o seu gerador, em ACBrDeRE.Dxxxx.XmlWriter (Base\Eventos). }

  TDeREXmlWriter = class(TDFeRTCXmlWriter)
  private
    FDeRE: TDeRE;
    FVersaoDF: TVersaoDeRE;

    function Gerar_idePeriodo_novaValidade(ANova: TnovaValidade): TACBrXmlNode;

    function GetOpcoes: TDeREXmlWriterOptions;
    procedure SetOpcoes(AValue: TDeREXmlWriterOptions);
  protected
    function CreateOptions: TACBrXmlWriterOptions; override;

    // Namespace (xmlns) do elemento raiz <DeRE> do evento
    function GetNameSpace: string; virtual; abstract;
    // Gera o elemento do evento (ex.: <evtInfoContrib id="...">) com todo o seu conteudo
    function Gerar_Evento: TACBrXmlNode; virtual; abstract;

    // Data/hora no formato AAAA-MM-DDThh:mm:ss.sssTZD (horario de Brasilia)
    function FormatarDhDeRE(ADh: TDateTime): string;

    // Grupos comuns a mais de um evento
    function Gerar_ideEvento(AIde: TideEvento): TACBrXmlNode;
    function Gerar_ideEventoRecibo(AIde: TideEventoRecibo): TACBrXmlNode;
    function Gerar_ideEventoFin(AIde: TideEventoFin): TACBrXmlNode;
    function Gerar_ideContrib(AIde: TideContrib): TACBrXmlNode;
    function Gerar_idePeriodo(APer: TidePeriodo): TACBrXmlNode;
    function Gerar_idePeriodoApur(APer: TidePeriodoApur): TACBrXmlNode;
    function Gerar_idePeriodoApurSub(APer: TidePeriodoApurSub): TACBrXmlNode;
  public
    constructor Create(AOwner: TDeRE); reintroduce;

    function GerarXml: boolean; override;

    // Monta o atributo "id" de 42 chars:
    // 'DeRE' + tipo(4) + indicador(1) + nrInsc(14) + AAAAMMDD(8) + HHMMSS(6) + QQQQQ(5)
    function MontarId: string;

    property Opcoes: TDeREXmlWriterOptions read GetOpcoes write SetOpcoes;
    property DeRE: TDeRE read FDeRE write FDeRE;
    property VersaoDF: TVersaoDeRE read FVersaoDF write FVersaoDF;
  end;

  TDeREXmlWriterClass = class of TDeREXmlWriter;

// Registro dos geradores: cada unit ACBrDeRE.Dxxxx.XmlWriter registra o seu na
// secao initialization; o componente cria o gerador pelo tipo do evento.
procedure RegistrarWriterDeRE(ATipo: TTipoEventoDeRE; AClasse: TDeREXmlWriterClass);
function CriarWriterDeRE(ADeRE: TDeRE): TDeREXmlWriter;

implementation

uses
  StrUtils,
  ACBrBase,
  ACBrUtil.Base,
  ACBrUtil.Strings,
  ACBrUtil.XMLHTML,
  ACBrUtil.DateTime,
  ACBrDeRE.Consts;

var
  GWritersDeRE: array[TTipoEventoDeRE] of TDeREXmlWriterClass;

procedure RegistrarWriterDeRE(ATipo: TTipoEventoDeRE; AClasse: TDeREXmlWriterClass);
begin
  GWritersDeRE[ATipo] := AClasse;
end;

function CriarWriterDeRE(ADeRE: TDeRE): TDeREXmlWriter;
begin
  if GWritersDeRE[ADeRE.Evento.TipoEvento] = nil then
    raise EACBrException.CreateFmt('Gerador de XML do evento %s nao registrado.',
      [TipoEventoDeREToStr(ADeRE.Evento.TipoEvento)]);

  Result := GWritersDeRE[ADeRE.Evento.TipoEvento].Create(ADeRE);
end;

{ TDeREXmlWriter }

constructor TDeREXmlWriter.Create(AOwner: TDeRE);
begin
  inherited Create;

  TDeREXmlWriterOptions(Opcoes).GerarTagAssinatura := taSomenteSeAssinada;

  FDeRE := AOwner;
  FVersaoDF := VERSAO_DERE_PADRAO;
end;

function TDeREXmlWriter.CreateOptions: TACBrXmlWriterOptions;
begin
  Result := TDeREXmlWriterOptions.Create;
end;

function TDeREXmlWriter.GetOpcoes: TDeREXmlWriterOptions;
begin
  Result := TDeREXmlWriterOptions(FOpcoes);
end;

procedure TDeREXmlWriter.SetOpcoes(AValue: TDeREXmlWriterOptions);
begin
  FOpcoes := AValue;
end;

function TDeREXmlWriter.MontarId: string;
var
  LEvt: TDeREEvento;
  LTipo: string;
  LIndicador: string;
  LnrInsc: string;
  LData: TDateTime;
  LDataStr: string;
  LHoraStr: string;
  LSeq: string;
begin
  LEvt := FDeRE.Evento;

  // Tipo do evento sem o prefixo "D-" (ex.: D-1001 -> 1001)
  LTipo := TipoEventoDeREToStr(LEvt.TipoEvento);
  LTipo := OnlyNumber(LTipo);

  // Indicador: posicao fixa conforme exemplo da doc (DeRE 1001 '1' ...)
  LIndicador := '1';

  // Numero de inscricao completo (14 posicoes, alinhado a direita com zeros)
  LnrInsc := OnlyCPFCNPJAlphaNum(LEvt.nrInscCompleto);
  LnrInsc := PadLeft(LnrInsc, TAM_NRINSC_ID_DERE, '0');

  LData := LEvt.dataGeracao;
  if LData = 0 then
    LData := Now;

  LDataStr := FormatDateTime('yyyymmdd', LData);
  LHoraStr := FormatDateTime('hhnnss', LData);

  LSeq := PadLeft(IntToStr(LEvt.sequencial), 5, '0');

  Result := PREFIXO_ID_DERE + LTipo + LIndicador + LnrInsc + LDataStr + LHoraStr + LSeq;
end;

function TDeREXmlWriter.GerarXml: boolean;
var
  Gerar: boolean;
  DeRENode, evtNode, xmlNode: TACBrXmlNode;
begin
  ListaDeAlertas.Clear;

  FDeRE.Evento.id := MontarId;

  FDocument.Clear;
  DeRENode := FDocument.CreateElement('DeRE', GetNameSpace);
  FDocument.Root := DeRENode;

  evtNode := Gerar_Evento;
  DeRENode.AppendChild(evtNode);

  if Opcoes.GerarTagAssinatura <> taNunca then
  begin
    Gerar := True;

    if Opcoes.GerarTagAssinatura = taSomenteSeAssinada then
      Gerar := ((FDeRE.Signature.DigestValue <> '') and
                (FDeRE.Signature.SignatureValue <> '') and
                (FDeRE.Signature.X509Certificate <> ''));

    if Opcoes.GerarTagAssinatura = taSomenteParaNaoAssinada then
      Gerar := ((FDeRE.Signature.DigestValue = '') and
                (FDeRE.Signature.SignatureValue = '') and
                (FDeRE.Signature.X509Certificate = ''));

    if Gerar then
    begin
      FDeRE.Signature.URI := '#' + FDeRE.Evento.id;
      xmlNode := GerarSignature(FDeRE.Signature);
      DeRENode.AppendChild(xmlNode);
    end;
  end;

  Result := True;
end;

function TDeREXmlWriter.FormatarDhDeRE(ADh: TDateTime): string;
begin
  Result := FormatDateTime('yyyy-mm-dd"T"hh:nn:ss.zzz', ADh) + GetUTC('DF', ADh);
end;

function TDeREXmlWriter.Gerar_ideEvento(AIde: TideEvento): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('ideEvento');

  Result.AppendChild(AddNode(tcStr, '#1', 'tpOper', 1, 1, 1,
    tpOperDeREToStr(AIde.tpOper), DSC_TPOPER));

  if AIde.TemmotExcl then
    Result.AppendChild(AddNode(tcStr, '#2', 'motExcl', 1, 1, 1,
      motExclDeREToStr(AIde.motExcl), DSC_MOTEXCL));

  if AIde.nrProc <> '' then
    Result.AppendChild(AddNode(tcStr, '#3', 'nrProc', 1, 21, 1,
      AIde.nrProc, DSC_NRPROC));

  Result.AppendChild(AddNode(tcStr, '#4', 'tpAmb', 1, 1, 1,
    TipoAmbienteToStr(AIde.tpAmb), DSC_TPAMB));

  Result.AppendChild(AddNode(tcStr, '#5', 'aplicEmi', 1, 1, 1,
    aplicEmiDeREToStr(AIde.aplicEmi), DSC_APLICEMI));

  Result.AppendChild(AddNode(tcStr, '#6', 'verAplic', 1, 20, 1,
    AIde.verAplic, DSC_VERAPLIC));
end;

function TDeREXmlWriter.Gerar_ideEventoRecibo(AIde: TideEventoRecibo): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('ideEvento');

  Result.AppendChild(AddNode(tcStr, '#1', 'tpOper', 1, 1, 1,
    tpOperDeREToStr(AIde.tpOper), DSC_TPOPER));

  if AIde.TemmotExcl then
    Result.AppendChild(AddNode(tcStr, '#2', 'motExcl', 1, 1, 1,
      motExclDeREToStr(AIde.motExcl), DSC_MOTEXCL));

  if AIde.nrProc <> '' then
    Result.AppendChild(AddNode(tcStr, '#3', 'nrProc', 1, 21, 1,
      AIde.nrProc, DSC_NRPROC));

  if AIde.nrRecibo <> '' then
    Result.AppendChild(AddNode(tcStr, '#4', 'nrRecibo', 31, 31, 1,
      AIde.nrRecibo, DSC_NRRECIBO));

  Result.AppendChild(AddNode(tcStr, '#5', 'tpAmb', 1, 1, 1,
    TipoAmbienteToStr(AIde.tpAmb), DSC_TPAMB));

  Result.AppendChild(AddNode(tcStr, '#6', 'aplicEmi', 1, 1, 1,
    aplicEmiDeREToStr(AIde.aplicEmi), DSC_APLICEMI));

  Result.AppendChild(AddNode(tcStr, '#7', 'verAplic', 1, 20, 1,
    AIde.verAplic, DSC_VERAPLIC));
end;

function TDeREXmlWriter.Gerar_ideEventoFin(AIde: TideEventoFin): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('ideEvento');

  Result.AppendChild(AddNode(tcStr, '#1', 'finEvt', 2, 2, 1,
    finalidadeEvtDeREToStr(AIde.finEvt), DSC_FINEVTOPER));

  Result.AppendChild(AddNode(tcStr, '#2', 'tpAmb', 1, 1, 1,
    TipoAmbienteToStr(AIde.tpAmb), DSC_TPAMB));

  Result.AppendChild(AddNode(tcStr, '#3', 'aplicEmi', 1, 1, 1,
    aplicEmiDeREToStr(AIde.aplicEmi), DSC_APLICEMI));

  Result.AppendChild(AddNode(tcStr, '#4', 'verAplic', 1, 20, 1,
    AIde.verAplic, DSC_VERAPLIC));
end;

function TDeREXmlWriter.Gerar_ideContrib(AIde: TideContrib): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('ideContrib');

  Result.AppendChild(AddNode(tcStr, '#8', 'nrInsc', 8, 8, 1,
    AIde.nrInsc, DSC_NRINSC));
end;

function TDeREXmlWriter.Gerar_idePeriodo(APer: TidePeriodo): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('idePeriodo');

  Result.AppendChild(AddNode(tcDat, '#9', 'iniValid', 10, 10, 1,
    APer.iniValid, DSC_INIVALID));

  if APer.TemfimValid then
    Result.AppendChild(AddNode(tcDat, '#10', 'fimValid', 10, 10, 1,
      APer.fimValid, DSC_FIMVALID));

  if APer.TemNovaValidade then
    Result.AppendChild(Gerar_idePeriodo_novaValidade(APer.novaValidade));
end;

function TDeREXmlWriter.Gerar_idePeriodo_novaValidade(ANova: TnovaValidade): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('novaValidade');

  Result.AppendChild(AddNode(tcDat, '#11', 'iniValid', 10, 10, 1,
    ANova.iniValid, DSC_INIVALID));

  if ANova.TemfimValid then
    Result.AppendChild(AddNode(tcDat, '#12', 'fimValid', 10, 10, 1,
      ANova.fimValid, DSC_FIMVALID));
end;

function TDeREXmlWriter.Gerar_idePeriodoApur(APer: TidePeriodoApur): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('idePeriodo');

  Result.AppendChild(AddNode(tcStr, '#9', 'perApur', 7, 7, 1,
    APer.perApur, DSC_PERAPUR));
end;

function TDeREXmlWriter.Gerar_idePeriodoApurSub(APer: TidePeriodoApurSub): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('idePeriodo');

  Result.AppendChild(AddNode(tcStr, '#9', 'perApur', 7, 7, 1,
    APer.perApur, DSC_PERAPUR));

  Result.AppendChild(AddNode(tcStr, '#10', 'subPer', 1, 1, 1,
    IntToStr(APer.subPer), DSC_SUBPER));
end;

end.
