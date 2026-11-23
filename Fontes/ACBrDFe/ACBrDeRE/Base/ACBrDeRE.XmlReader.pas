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

unit ACBrDeRE.XmlReader;

interface

uses
  Classes, SysUtils,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrDFe.RTC.XmlReader,
  ACBrXmlDocument,
  ACBrXmlReader,
  ACBrDeRE.Classes,
  ACBrDeRE.Classes.Retorno,
  ACBrDeRE.Conversao;

type
  { TDeREXmlReaderBase - base dos leitores de XML do DeRE: grupos comuns a mais de
    um evento (e aos retornos) ficam centralizados aqui. }

  TDeREXmlReaderBase = class(TDFeRTCXmlReader)
  protected
    procedure Ler_ideEvento(const ANode: TACBrXmlNode; AIde: TideEvento);
    procedure Ler_ideEventoRecibo(const ANode: TACBrXmlNode; AIde: TideEventoRecibo);
    procedure Ler_ideEventoFin(const ANode: TACBrXmlNode; AIde: TideEventoFin);
    procedure Ler_ideContrib(const ANode: TACBrXmlNode; AIde: TideContrib);
    procedure Ler_idePeriodo(const ANode: TACBrXmlNode; APeriodo: TidePeriodo);
    procedure Ler_idePeriodoApur(const ANode: TACBrXmlNode; APeriodo: TidePeriodoApur);
    procedure Ler_idePeriodoApurSub(const ANode: TACBrXmlNode; APeriodo: TidePeriodoApurSub);
    // Grupos comuns aos eventos de retorno (D-9xxx)
    procedure Ler_Ocorrencias(const ANode: TACBrXmlNode; ALista: TOcorrenciaCollection);
    procedure Ler_OcorrenciasEvento(const ANode: TACBrXmlNode; ALista: TOcorrenciaCollection);
    procedure Ler_ideStatus(const ANode: TACBrXmlNode; AStatus: TideStatus);
    procedure Ler_infoRecEv(const ANode: TACBrXmlNode; AInfo: TinfoRecEv);
  end;

  { TDeREEventoXmlReader - base abstrata dos leitores de XML dos eventos DeRE.
    Cada evento possui o seu leitor, em ACBrDeRE.Dxxxx.XmlReader (Base\Eventos). }

  TDeREEventoXmlReader = class(TDeREXmlReaderBase)
  private
    FDeRE: TDeRE;

    // Extrai do id (42 chars) o nrInsc completo, a data/hora de geracao e a sequencia
    procedure Ler_Id(const AId: string);
  protected
    // Nome da tag do evento (ex.: evtInfoContrib)
    function GetNomeEvento: string; virtual; abstract;
    // Le o conteudo do elemento do evento
    procedure Ler_Evento(const ANode: TACBrXmlNode); virtual; abstract;
  public
    constructor Create(AOwner: TDeRE); reintroduce;

    function LerXml: Boolean; override;

    property DeRE: TDeRE read FDeRE write FDeRE;
  end;

  TDeREEventoXmlReaderClass = class of TDeREEventoXmlReader;

  { TDeREXmlReader - le evtRetornoTabela (o retorno do lote e lido por TRetEnvLoteDeRE) }

  TDeREXmlReader = class(TDeREXmlReaderBase)
  private
    FevtRetTabela: TevtRetornoTabela;

    procedure Ler_EvtRetornoTabela(const ANode: TACBrXmlNode);
    procedure Ler_EvtRetTabela_infoEvento(const ANode: TACBrXmlNode);
    procedure Ler_EvtRetTabela_extratoEventos(const ANode: TACBrXmlNode);

  public
    function LerXml: Boolean; override;

    property evtRetTabela: TevtRetornoTabela read FevtRetTabela write FevtRetTabela;
  end;

// Registro dos leitores de XML: cada unit ACBrDeRE.Dxxxx.XmlReader registra o seu
// na secao initialization; o componente cria o leitor pelo tipo do evento.
procedure RegistrarReaderDeRE(ATipo: TTipoEventoDeRE; AClasse: TDeREEventoXmlReaderClass);
function ExisteReaderDeRE(ATipo: TTipoEventoDeRE): Boolean;
function CriarReaderDeRE(ADeRE: TDeRE): TDeREEventoXmlReader;

implementation

uses
  ACBrBase,
  ACBrUtil.Base;

var
  GReadersDeRE: array[TTipoEventoDeRE] of TDeREEventoXmlReaderClass;

procedure RegistrarReaderDeRE(ATipo: TTipoEventoDeRE; AClasse: TDeREEventoXmlReaderClass);
begin
  GReadersDeRE[ATipo] := AClasse;
end;

function ExisteReaderDeRE(ATipo: TTipoEventoDeRE): Boolean;
begin
  Result := GReadersDeRE[ATipo] <> nil;
end;

function CriarReaderDeRE(ADeRE: TDeRE): TDeREEventoXmlReader;
begin
  if GReadersDeRE[ADeRE.Evento.TipoEvento] = nil then
    raise EACBrException.CreateFmt('Leitor de XML do evento %s nao registrado.',
      [TipoEventoDeREToStr(ADeRE.Evento.TipoEvento)]);

  Result := GReadersDeRE[ADeRE.Evento.TipoEvento].Create(ADeRE);
end;

{ TDeREXmlReaderBase }

procedure TDeREXmlReaderBase.Ler_ideEvento(const ANode: TACBrXmlNode; AIde: TideEvento);
var
  LNode: TACBrXmlNode;
begin
  if not Assigned(ANode) then Exit;

  AIde.tpOper := StrTotpOperDeRE(ObterConteudo(ANode.Childrens.FindAnyNs('tpOper'), tcStr));

  LNode := ANode.Childrens.FindAnyNs('motExcl');
  AIde.TemmotExcl := Assigned(LNode);
  if AIde.TemmotExcl then
    AIde.motExcl := StrTomotExclDeRE(ObterConteudo(LNode, tcStr));

  AIde.nrProc := ObterConteudo(ANode.Childrens.FindAnyNs('nrProc'), tcStr);
  AIde.tpAmb := StrToTipoAmbiente(ObterConteudo(ANode.Childrens.FindAnyNs('tpAmb'), tcStr));
  AIde.aplicEmi := StrToaplicEmiDeRE(ObterConteudo(ANode.Childrens.FindAnyNs('aplicEmi'), tcStr));
  AIde.verAplic := ObterConteudo(ANode.Childrens.FindAnyNs('verAplic'), tcStr);
end;

procedure TDeREXmlReaderBase.Ler_ideEventoRecibo(const ANode: TACBrXmlNode; AIde: TideEventoRecibo);
var
  LNode: TACBrXmlNode;
begin
  if not Assigned(ANode) then Exit;

  AIde.tpOper := StrTotpOperDeRE(ObterConteudo(ANode.Childrens.FindAnyNs('tpOper'), tcStr));

  LNode := ANode.Childrens.FindAnyNs('motExcl');
  AIde.TemmotExcl := Assigned(LNode);
  if AIde.TemmotExcl then
    AIde.motExcl := StrTomotExclDeRE(ObterConteudo(LNode, tcStr));

  AIde.nrProc := ObterConteudo(ANode.Childrens.FindAnyNs('nrProc'), tcStr);
  AIde.nrRecibo := ObterConteudo(ANode.Childrens.FindAnyNs('nrRecibo'), tcStr);
  AIde.tpAmb := StrToTipoAmbiente(ObterConteudo(ANode.Childrens.FindAnyNs('tpAmb'), tcStr));
  AIde.aplicEmi := StrToaplicEmiDeRE(ObterConteudo(ANode.Childrens.FindAnyNs('aplicEmi'), tcStr));
  AIde.verAplic := ObterConteudo(ANode.Childrens.FindAnyNs('verAplic'), tcStr);
end;

procedure TDeREXmlReaderBase.Ler_ideEventoFin(const ANode: TACBrXmlNode; AIde: TideEventoFin);
begin
  if not Assigned(ANode) then Exit;

  AIde.finEvt := StrTofinalidadeEvtDeRE(ObterConteudo(ANode.Childrens.FindAnyNs('finEvt'), tcStr));
  AIde.tpAmb := StrToTipoAmbiente(ObterConteudo(ANode.Childrens.FindAnyNs('tpAmb'), tcStr));
  AIde.aplicEmi := StrToaplicEmiDeRE(ObterConteudo(ANode.Childrens.FindAnyNs('aplicEmi'), tcStr));
  AIde.verAplic := ObterConteudo(ANode.Childrens.FindAnyNs('verAplic'), tcStr);
end;

procedure TDeREXmlReaderBase.Ler_ideContrib(const ANode: TACBrXmlNode; AIde: TideContrib);
begin
  if not Assigned(ANode) then Exit;

  AIde.nrInsc := ObterConteudo(ANode.Childrens.FindAnyNs('nrInsc'), tcStr);
end;

procedure TDeREXmlReaderBase.Ler_idePeriodo(const ANode: TACBrXmlNode; APeriodo: TidePeriodo);
var
  NovaNode: TACBrXmlNode;
  FimNode: TACBrXmlNode;
begin
  if not Assigned(ANode) then Exit;

  APeriodo.iniValid := ObterConteudo(ANode.Childrens.FindAnyNs('iniValid'), tcDat);

  FimNode := ANode.Childrens.FindAnyNs('fimValid');
  APeriodo.TemfimValid := Assigned(FimNode);
  if APeriodo.TemfimValid then
    APeriodo.fimValid := ObterConteudo(FimNode, tcDat);

  NovaNode := ANode.Childrens.FindAnyNs('novaValidade');
  APeriodo.TemNovaValidade := Assigned(NovaNode);
  if APeriodo.TemNovaValidade then
  begin
    APeriodo.novaValidade.iniValid := ObterConteudo(NovaNode.Childrens.FindAnyNs('iniValid'), tcDat);

    FimNode := NovaNode.Childrens.FindAnyNs('fimValid');
    APeriodo.novaValidade.TemfimValid := Assigned(FimNode);
    if APeriodo.novaValidade.TemfimValid then
      APeriodo.novaValidade.fimValid := ObterConteudo(FimNode, tcDat);
  end;
end;

procedure TDeREXmlReaderBase.Ler_idePeriodoApur(const ANode: TACBrXmlNode; APeriodo: TidePeriodoApur);
begin
  if not Assigned(ANode) then Exit;

  APeriodo.perApur := ObterConteudo(ANode.Childrens.FindAnyNs('perApur'), tcStr);
end;

procedure TDeREXmlReaderBase.Ler_idePeriodoApurSub(const ANode: TACBrXmlNode; APeriodo: TidePeriodoApurSub);
begin
  if not Assigned(ANode) then Exit;

  APeriodo.perApur := ObterConteudo(ANode.Childrens.FindAnyNs('perApur'), tcStr);
  APeriodo.subPer := ObterConteudo(ANode.Childrens.FindAnyNs('subPer'), tcInt);
end;

procedure TDeREXmlReaderBase.Ler_Ocorrencias(const ANode: TACBrXmlNode; ALista: TOcorrenciaCollection);
var
  OcorrNodes: TACBrXmlNodeArray;
  i: Integer;
  Item: TOcorrenciaCollectionItem;
begin
  if not Assigned(ANode) then Exit;

  OcorrNodes := ANode.Childrens.FindAllAnyNs('ocorrencia');

  for i := Low(OcorrNodes) to High(OcorrNodes) do
  begin
    Item := ALista.New;
    Item.codigo := ObterConteudo(OcorrNodes[i].Childrens.FindAnyNs('codigo'), tcStr);
    Item.descricao := ObterConteudo(OcorrNodes[i].Childrens.FindAnyNs('descricao'), tcStr);
    Item.tipo := StrTotipoOcorrenciaDeRE(ObterConteudo(OcorrNodes[i].Childrens.FindAnyNs('tipo'), tcStr));
    Item.localizacao := ObterConteudo(OcorrNodes[i].Childrens.FindAnyNs('localizacao'), tcStr);
  end;
end;

// Nos retornos dos eventos (ideStatus) o XSD repete o elemento <ocorrencias> (ate 10),
// cada um com codigo/descricao/tipo/localizacao, diferente do retorno do lote, que
// tem <ocorrencias><ocorrencia>...</ocorrencia></ocorrencias>.
procedure TDeREXmlReaderBase.Ler_OcorrenciasEvento(const ANode: TACBrXmlNode; ALista: TOcorrenciaCollection);
var
  OcorrNodes: TACBrXmlNodeArray;
  i: Integer;
  Item: TOcorrenciaCollectionItem;
begin
  if not Assigned(ANode) then Exit;

  OcorrNodes := ANode.Childrens.FindAllAnyNs('ocorrencias');

  for i := Low(OcorrNodes) to High(OcorrNodes) do
  begin
    Item := ALista.New;
    Item.codigo := ObterConteudo(OcorrNodes[i].Childrens.FindAnyNs('codigo'), tcStr);
    Item.descricao := ObterConteudo(OcorrNodes[i].Childrens.FindAnyNs('descricao'), tcStr);
    Item.tipo := StrTotipoOcorrenciaDeRE(ObterConteudo(OcorrNodes[i].Childrens.FindAnyNs('tipo'), tcStr));
    Item.localizacao := ObterConteudo(OcorrNodes[i].Childrens.FindAnyNs('localizacao'), tcStr);
  end;
end;

procedure TDeREXmlReaderBase.Ler_ideStatus(const ANode: TACBrXmlNode; AStatus: TideStatus);
begin
  if not Assigned(ANode) then Exit;

  AStatus.cdRetorno := StrTocdRetornoDeRE(ObterConteudo(ANode.Childrens.FindAnyNs('cdRetorno'), tcStr));
  AStatus.descRetorno := StrTodescRetornoDeRE(ObterConteudo(ANode.Childrens.FindAnyNs('descRetorno'), tcStr));

  Ler_OcorrenciasEvento(ANode, AStatus.ocorrencias);
end;

procedure TDeREXmlReaderBase.Ler_infoRecEv(const ANode: TACBrXmlNode; AInfo: TinfoRecEv);
var
  LTipo: TTipoEventoDeRE;
begin
  if not Assigned(ANode) then Exit;

  AInfo.nrRecibo := ObterConteudo(ANode.Childrens.FindAnyNs('nrRecibo'), tcStr);
  AInfo.seqEvento := ObterConteudo(ANode.Childrens.FindAnyNs('seqEvento'), tcStr);
  AInfo.protocoloLote := ObterConteudo(ANode.Childrens.FindAnyNs('protocoloLote'), tcStr);
  AInfo.dhRecepcao := ObterConteudo(ANode.Childrens.FindAnyNs('dhRecepcao'), tcDatHor);
  AInfo.dhProcess := ObterConteudo(ANode.Childrens.FindAnyNs('dhProcess'), tcDatHor);
  // O ambiente pode devolver um tipo desconhecido (ex.: D0): nao gera excecao, mantem o valor recebido.
  AInfo.tpEvStr := ObterConteudo(ANode.Childrens.FindAnyNs('tpEv'), tcStr);
  if TryStrToTipoEventoDeRE(AInfo.tpEvStr, LTipo) then
    AInfo.tpEv := LTipo;
  AInfo.hash := ObterConteudo(ANode.Childrens.FindAnyNs('hash'), tcStr);
end;

{ TDeREEventoXmlReader }

constructor TDeREEventoXmlReader.Create(AOwner: TDeRE);
begin
  inherited Create;

  FDeRE := AOwner;
end;

procedure TDeREEventoXmlReader.Ler_Id(const AId: string);
var
  LData: string;
begin
  // id = 'DeRE' + tipo(4) + indicador(1) + nrInsc(14) + AAAAMMDD(8) + HHMMSS(6) + QQQQQ(5)
  FDeRE.Evento.id := AId;

  if Length(AId) <> 42 then
    Exit;

  FDeRE.Evento.nrInscCompleto := Copy(AId, 10, 14);
  FDeRE.Evento.sequencial := StrToIntDef(Copy(AId, 38, 5), 0);

  LData := Copy(AId, 24, 8) + Copy(AId, 32, 6);
  if LData <> '' then
    FDeRE.Evento.dataGeracao := EncodeDate(StrToIntDef(Copy(LData, 1, 4), 1899),
      StrToIntDef(Copy(LData, 5, 2), 12), StrToIntDef(Copy(LData, 7, 2), 30)) +
      EncodeTime(StrToIntDef(Copy(LData, 9, 2), 0), StrToIntDef(Copy(LData, 11, 2), 0),
      StrToIntDef(Copy(LData, 13, 2), 0), 0);
end;

function TDeREEventoXmlReader.LerXml: Boolean;
var
  LDeRENode, LEvtNode: TACBrXmlNode;
  LAtt: TACBrXmlAttribute;
begin
  Result := False;

  if EstaVazio(Arquivo) then
    raise Exception.Create('Arquivo xml do evento DeRE nao carregado.');

  Document.Clear;
  Document.LoadFromXml(Arquivo);

  LDeRENode := Document.Root;

  if (LDeRENode = nil) or (LDeRENode.Name <> 'DeRE') then
    raise Exception.Create('Arquivo xml incorreto: raiz [DeRE] nao encontrada.');

  LEvtNode := LDeRENode.Childrens.FindAnyNs(GetNomeEvento);
  if not Assigned(LEvtNode) then
    Exit;

  LAtt := LEvtNode.Attributes.Items['id'];
  if Assigned(LAtt) then
    Ler_Id(LAtt.Content);

  Ler_Evento(LEvtNode);

  LerSignature(LDeRENode.Childrens.FindAnyNs('Signature'), FDeRE.Signature);

  Result := True;
end;

{ TDeREXmlReader }

function TDeREXmlReader.LerXml: Boolean;
var
  DeRENode, FilhoNode: TACBrXmlNode;
begin
  Result := False;

  if EstaVazio(Arquivo) then
    raise Exception.Create('Arquivo xml da DeRE nao carregado.');

  Document.Clear;
  Document.LoadFromXml(Arquivo);

  DeRENode := Document.Root;

  if DeRENode = nil then
    raise Exception.Create('Arquivo xml incorreto.');

  if DeRENode.Name <> 'DeRE' then
    raise Exception.Create('Arquivo xml incorreto: raiz [DeRE] nao encontrada.');

  FilhoNode := DeRENode.Childrens.FindAnyNs('evtRetornoTabela');
  if Assigned(FilhoNode) then
  begin
    if Assigned(FevtRetTabela) then
    begin
      FevtRetTabela.Clear;
      Ler_EvtRetornoTabela(FilhoNode);
      LerSignature(DeRENode.Childrens.FindAnyNs('Signature'), FevtRetTabela.Signature);
      Result := True;
    end;
    Exit;
  end;
end;

{ evtRetornoTabela }

procedure TDeREXmlReader.Ler_EvtRetornoTabela(const ANode: TACBrXmlNode);
var
  ideContribNode: TACBrXmlNode;
  att: TACBrXmlAttribute;
begin
  att := ANode.Attributes.Items['id'];
  if Assigned(att) then
    FevtRetTabela.id := att.Content;

  ideContribNode := ANode.Childrens.FindAnyNs('ideContrib');
  if Assigned(ideContribNode) then
    FevtRetTabela.nrInsc := ObterConteudo(ideContribNode.Childrens.FindAnyNs('nrInsc'), tcStr);

  Ler_ideStatus(ANode.Childrens.FindAnyNs('ideStatus'), FevtRetTabela.ideStatus);
  Ler_infoRecEv(ANode.Childrens.FindAnyNs('infoRecEv'), FevtRetTabela.infoRecEv);
  Ler_EvtRetTabela_infoEvento(ANode.Childrens.FindAnyNs('infoEvento'));
  Ler_EvtRetTabela_extratoEventos(ANode.Childrens.FindAnyNs('extratoEventos'));
end;

procedure TDeREXmlReader.Ler_EvtRetTabela_infoEvento(const ANode: TACBrXmlNode);
begin
  if not Assigned(ANode) then Exit;

  FevtRetTabela.infoEvento.TemInfoEvento := True;
  Ler_idePeriodo(ANode.Childrens.FindAnyNs('idePeriodo'), FevtRetTabela.infoEvento.idePeriodo);
end;

procedure TDeREXmlReader.Ler_EvtRetTabela_extratoEventos(const ANode: TACBrXmlNode);
var
  DetNodes: TACBrXmlNodeArray;
  i: Integer;
  ItemEv: TdetEventoCollectionItem;
  ItemLac: TdetLacunaCollectionItem;
  FimNode: TACBrXmlNode;
begin
  if not Assigned(ANode) then Exit;

  FevtRetTabela.extratoEventos.TemExtrato := True;

  DetNodes := ANode.Childrens.FindAllAnyNs('detEvento');
  for i := Low(DetNodes) to High(DetNodes) do
  begin
    ItemEv := FevtRetTabela.extratoEventos.detEvento.New;
    ItemEv.nrRecibo := ObterConteudo(DetNodes[i].Childrens.FindAnyNs('nrRecibo'), tcStr);
    ItemEv.iniValid := ObterConteudo(DetNodes[i].Childrens.FindAnyNs('iniValid'), tcDat);

    FimNode := DetNodes[i].Childrens.FindAnyNs('fimValid');
    ItemEv.TemfimValid := Assigned(FimNode);
    if ItemEv.TemfimValid then
      ItemEv.fimValid := ObterConteudo(FimNode, tcDat);

    FimNode := DetNodes[i].Childrens.FindAnyNs('fimValidEfetiva');
    ItemEv.TemfimValidEfetiva := Assigned(FimNode);
    if ItemEv.TemfimValidEfetiva then
      ItemEv.fimValidEfetiva := ObterConteudo(FimNode, tcDat);

    ItemEv.indAjusteAuto := ObterConteudo(DetNodes[i].Childrens.FindAnyNs('indAjusteAuto'), tcStr) = '1';
  end;

  DetNodes := ANode.Childrens.FindAllAnyNs('detLacuna');
  for i := Low(DetNodes) to High(DetNodes) do
  begin
    ItemLac := FevtRetTabela.extratoEventos.detLacuna.New;
    ItemLac.iniLacuna := ObterConteudo(DetNodes[i].Childrens.FindAnyNs('iniLacuna'), tcDat);

    FimNode := DetNodes[i].Childrens.FindAnyNs('fimLacuna');
    ItemLac.TemfimLacuna := Assigned(FimNode);
    if ItemLac.TemfimLacuna then
      ItemLac.fimLacuna := ObterConteudo(FimNode, tcDat);
  end;
end;

end.
