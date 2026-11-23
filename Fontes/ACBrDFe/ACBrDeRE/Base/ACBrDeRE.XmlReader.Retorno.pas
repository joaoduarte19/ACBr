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

unit ACBrDeRE.XmlReader.Retorno;

interface

uses
  Classes, SysUtils,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrXmlDocument,
  ACBrDeRE.Classes,
  ACBrDeRE.Classes.Retorno,
  ACBrDeRE.Conversao,
  ACBrDeRE.XmlReader;

type
  { TDeRERetornoXmlReader - le os eventos de retorno D-9101, D-9106, D-9109, D-9112, D-9121,
    D-9198, D-9199 e D-9209 (evtRetorno*). O D-9001 (evtRetornoTabela) e lido por TDeREXmlReader. }

  TDeRERetornoXmlReader = class(TDeREXmlReaderBase)
  private
    FevtRetorno: TevtRetornoDeRE;

    procedure Ler_TgTotalCodTribRet(const ANode: TACBrXmlNode; A: TgTotalCodTribCollectionItemRet);
    procedure Ler_TinfoTotVApurRet(const ANode: TACBrXmlNode; A: TinfoTotVApurRet);
    procedure Ler_TinfoAdicRet(const ANode: TACBrXmlNode; A: TinfoAdicRet);
    procedure Ler_TgCoeficientesRet(const ANode: TACBrXmlNode; A: TgCoeficientesRet);
    procedure Ler_TgBCIBSRet(const ANode: TACBrXmlNode; A: TgBCIBSRet);
    procedure Ler_TgBCCBSRet(const ANode: TACBrXmlNode; A: TgBCCBSRet);
    procedure Ler_TgBCISRet(const ANode: TACBrXmlNode; A: TgBCISRet);
    procedure Ler_TdetBCNRet(const ANode: TACBrXmlNode; A: TdetBCNCollectionItemRet);
    procedure Ler_TgBCNRet(const ANode: TACBrXmlNode; A: TgBCNRet);
    procedure Ler_TinfoBCNRet(const ANode: TACBrXmlNode; A: TinfoBCNRet);
    procedure Ler_TdetBCRet(const ANode: TACBrXmlNode; A: TdetBCCollectionItemRet);
    procedure Ler_TtotalTributosRet(const ANode: TACBrXmlNode; A: TtotalTributosRet);
    procedure Ler_TinfoTotMensalRet(const ANode: TACBrXmlNode; A: TinfoTotMensalRet);

    procedure Ler_evtRetorno(const ANode: TACBrXmlNode; ATipo: TTipoRetornoDeRE);
  public
    function LerXml: Boolean; override;

    property evtRetorno: TevtRetornoDeRE read FevtRetorno write FevtRetorno;
  end;

// Identifica o tipo do evento de retorno pelo nome da tag (evtRetornoXxx). Retorna trtNenhum se nao for conhecido.
function TipoRetornoDeREDoTag(const ATag: string): TTipoRetornoDeRE;

// Interpreta o XML de um evento do lote (retornoEventos/evento) preenchendo Retorno ou RetornoTabela.
procedure InterpretarRetornoEvento(AItem: TRetornoEventoCollectionItem);

// Interpreta todos os eventos de retorno contidos no lote consultado.
procedure InterpretarRetornosLote(ALote: TretornoLoteDeRE);

implementation

uses
  ACBrBase,
  ACBrUtil.Base,
  ACBrUtil.Strings;

function NomeTagRetorno(ATipo: TTipoRetornoDeRE): string;
begin
  case ATipo of
    trtTabela: Result := 'evtRetornoTabela';
    trtBalancete: Result := 'evtRetornoBalan';
    trtAplicFin: Result := 'evtRetornoAplicFin';
    trtPeriodicosMensais: Result := 'evtRetornoPMensal';
    trtRelDeducoes: Result := 'evtRetornoRDed';
    trtTitPub: Result := 'evtRetornoTitPub';
    trtReabertura: Result := 'evtRetornoReabert';
    trtFechamento: Result := 'evtRetornoMensal';
    trtTransacionais: Result := 'evtRetornoTransac';
  else
    Result := '';
  end;
end;

function TipoRetornoDeREDoTag(const ATag: string): TTipoRetornoDeRE;
begin
  if ATag = 'evtRetornoBalan' then
    Result := trtBalancete
  else
  if ATag = 'evtRetornoAplicFin' then
    Result := trtAplicFin
  else
  if ATag = 'evtRetornoPMensal' then
    Result := trtPeriodicosMensais
  else
  if ATag = 'evtRetornoRDed' then
    Result := trtRelDeducoes
  else
  if ATag = 'evtRetornoTitPub' then
    Result := trtTitPub
  else
  if ATag = 'evtRetornoReabert' then
    Result := trtReabertura
  else
  if ATag = 'evtRetornoMensal' then
    Result := trtFechamento
  else
  if ATag = 'evtRetornoTransac' then
    Result := trtTransacionais
  else
  if ATag = 'evtRetornoTabela' then
    Result := trtTabela
  else
    Result := trtNenhum;
end;

{ TDeRERetornoXmlReader }

function TDeRERetornoXmlReader.LerXml: Boolean;
var
  LRaiz, LNode: TACBrXmlNode;
  LTipo: TTipoRetornoDeRE;
begin
  if EstaVazio(Arquivo) then
    raise Exception.Create('Arquivo xml de retorno da DeRE nao carregado.');

  if not Assigned(FevtRetorno) then
    raise Exception.Create('Objeto evtRetorno nao informado.');

  Document.Clear;
  Document.LoadFromXml(Arquivo);

  LRaiz := Document.Root;
  if LRaiz = nil then
    raise Exception.Create('Arquivo xml incorreto.');

  // O evento pode vir dentro do envelope <DeRE> ou ser o proprio elemento raiz
  if LRaiz.Name = 'DeRE' then
  begin
    LNode := LRaiz.Childrens.FindAnyNs('evtRetornoBalan');
    if LNode = nil then LNode := LRaiz.Childrens.FindAnyNs('evtRetornoAplicFin');
    if LNode = nil then LNode := LRaiz.Childrens.FindAnyNs('evtRetornoPMensal');
    if LNode = nil then LNode := LRaiz.Childrens.FindAnyNs('evtRetornoRDed');
    if LNode = nil then LNode := LRaiz.Childrens.FindAnyNs('evtRetornoTitPub');
    if LNode = nil then LNode := LRaiz.Childrens.FindAnyNs('evtRetornoReabert');
    if LNode = nil then LNode := LRaiz.Childrens.FindAnyNs('evtRetornoMensal');
    if LNode = nil then LNode := LRaiz.Childrens.FindAnyNs('evtRetornoTransac');
  end
  else
    LNode := LRaiz;

  if LNode = nil then
    raise Exception.Create('Arquivo xml incorreto: evento de retorno (evtRetorno*) nao encontrado.');

  LTipo := TipoRetornoDeREDoTag(LNode.Name);
  if LTipo = trtNenhum then
    raise Exception.CreateFmt('Evento de retorno desconhecido: %s', [LNode.Name]);

  FevtRetorno.Clear;
  Ler_evtRetorno(LNode, LTipo);

  if LRaiz.Name = 'DeRE' then
    LerSignature(LRaiz.Childrens.FindAnyNs('Signature'), FevtRetorno.Signature);

  Result := True;
end;

procedure TDeRERetornoXmlReader.Ler_evtRetorno(const ANode: TACBrXmlNode; ATipo: TTipoRetornoDeRE);
var
  LAtt: TACBrXmlAttribute;
  LNode, LInfo: TACBrXmlNode;
  LNodes: TACBrXmlNodeArray;
  i: Integer;
begin
  FevtRetorno.TipoRetorno := ATipo;

  LAtt := ANode.Attributes.Items['id'];
  if Assigned(LAtt) then
    FevtRetorno.id := LAtt.Content;

  LNode := ANode.Childrens.FindAnyNs('ideContrib');
  if Assigned(LNode) then
    FevtRetorno.nrInsc := ObterConteudo(LNode.Childrens.FindAnyNs('nrInsc'), tcStr);

  Ler_ideStatus(ANode.Childrens.FindAnyNs('ideStatus'), FevtRetorno.ideStatus);
  Ler_infoRecEv(ANode.Childrens.FindAnyNs('infoRecEv'), FevtRetorno.infoRecEv);

  LInfo := ANode.Childrens.FindAnyNs('infoEvento');
  FevtRetorno.TemInfoEvento := Assigned(LInfo);
  if not Assigned(LInfo) then Exit;

  Ler_idePeriodoApur(LInfo.Childrens.FindAnyNs('idePeriodo'), FevtRetorno.idePeriodo);

  LNode := LInfo.Childrens.FindAnyNs('infoAdic');
  FevtRetorno.TeminfoAdic := Assigned(LNode);
  if Assigned(LNode) then
    Ler_TinfoAdicRet(LNode, FevtRetorno.infoAdic);

  // D-9101
  LNode := LInfo.Childrens.FindAnyNs('infoTotBalan');
  FevtRetorno.TeminfoTotBalan := Assigned(LNode);
  if Assigned(LNode) then
  begin
    LNodes := LNode.Childrens.FindAllAnyNs('gTotalCodTrib');
    for i := Low(LNodes) to High(LNodes) do
      Ler_TgTotalCodTribRet(LNodes[i], FevtRetorno.infoTotBalan.New);
  end;

  // D-9106
  LNode := LInfo.Childrens.FindAnyNs('infoTotAplicFin');
  FevtRetorno.TeminfoTotAplicFin := Assigned(LNode);
  if Assigned(LNode) then
    Ler_TinfoTotVApurRet(LNode, FevtRetorno.infoTotAplicFin);

  // D-9121
  LNode := LInfo.Childrens.FindAnyNs('infoTotTitOfPub');
  FevtRetorno.TeminfoTotTitOfPub := Assigned(LNode);
  if Assigned(LNode) then
    Ler_TinfoTotVApurRet(LNode, FevtRetorno.infoTotTitOfPub);

  // D-9199
  LNode := LInfo.Childrens.FindAnyNs('infoTotFinanceiro');
  FevtRetorno.TeminfoTotFinanceiro := Assigned(LNode);
  if Assigned(LNode) then
    Ler_TinfoTotMensalRet(LNode, FevtRetorno.infoTotFinanceiro);

  LNode := LInfo.Childrens.FindAnyNs('infoTotSaude');
  FevtRetorno.TeminfoTotSaude := Assigned(LNode);
  if Assigned(LNode) then
    Ler_TinfoTotMensalRet(LNode, FevtRetorno.infoTotSaude);

  LNode := LInfo.Childrens.FindAnyNs('infoTotProg');
  FevtRetorno.TeminfoTotProg := Assigned(LNode);
  if Assigned(LNode) then
    Ler_TinfoTotMensalRet(LNode, FevtRetorno.infoTotProg);

  LNode := LInfo.Childrens.FindAnyNs('totalTributosGeral');
  FevtRetorno.TemtotalTributosGeral := Assigned(LNode);
  if Assigned(LNode) then
    Ler_TtotalTributosRet(LNode, FevtRetorno.totalTributosGeral);
end;

procedure TDeRERetornoXmlReader.Ler_TgTotalCodTribRet(const ANode: TACBrXmlNode; A: TgTotalCodTribCollectionItemRet);
var
  LNode: TACBrXmlNode;
begin
  if not Assigned(ANode) then Exit;

  A.codTrib := ObterConteudo(ANode.Childrens.FindAnyNs('codTrib'), tcInt);
  A.indTribISS := ObterConteudo(ANode.Childrens.FindAnyNs('indTribISS'), tcStr) = '1';
  A.vApurTot := ObterConteudo(ANode.Childrens.FindAnyNs('vApurTot'), tcDe2);
  LNode := ANode.Childrens.FindAnyNs('vTotSaldoInic');
  A.TemvTotSaldoInic := Assigned(LNode);
  if A.TemvTotSaldoInic then
    A.vTotSaldoInic := ObterConteudo(LNode, tcDe2);
  LNode := ANode.Childrens.FindAnyNs('vTotSaldoFinal');
  A.TemvTotSaldoFinal := Assigned(LNode);
  if A.TemvTotSaldoFinal then
    A.vTotSaldoFinal := ObterConteudo(LNode, tcDe2);
end;

procedure TDeRERetornoXmlReader.Ler_TinfoTotVApurRet(const ANode: TACBrXmlNode; A: TinfoTotVApurRet);
begin
  if not Assigned(ANode) then Exit;

  A.vApurTot := ObterConteudo(ANode.Childrens.FindAnyNs('vApurTot'), tcDe2);
end;

procedure TDeRERetornoXmlReader.Ler_TinfoAdicRet(const ANode: TACBrXmlNode; A: TinfoAdicRet);
var
  LNodes: TACBrXmlNodeArray;
  i: Integer;
begin
  if not Assigned(ANode) then Exit;

  A.nrReciboPGCC := ObterConteudo(ANode.Childrens.FindAnyNs('nrReciboPGCC'), tcStr);
  A.nrReciboBalancete := ObterConteudo(ANode.Childrens.FindAnyNs('nrReciboBalancete'), tcStr);
  A.nrReciboAplicFin := ObterConteudo(ANode.Childrens.FindAnyNs('nrReciboAplicFin'), tcStr);
  A.nrReciboOperTitPub := ObterConteudo(ANode.Childrens.FindAnyNs('nrReciboOperTitPub'), tcStr);
  LNodes := ANode.Childrens.FindAllAnyNs('nrReciboRelDedu');
  for i := Low(LNodes) to High(LNodes) do
    A.nrReciboRelDedu.Add(ObterConteudo(LNodes[i], tcStr));
end;

procedure TDeRERetornoXmlReader.Ler_TgCoeficientesRet(const ANode: TACBrXmlNode; A: TgCoeficientesRet);
var
  LNode: TACBrXmlNode;
begin
  if not Assigned(ANode) then Exit;

  LNode := ANode.Childrens.FindAnyNs('pRateioDespCapt');
  A.TempRateioDespCapt := Assigned(LNode);
  if A.TempRateioDespCapt then
    A.pRateioDespCapt := ObterConteudo(LNode, tcDe8);
  LNode := ANode.Childrens.FindAnyNs('pRevDedAtoCoop');
  A.TempRevDedAtoCoop := Assigned(LNode);
  if A.TempRevDedAtoCoop then
    A.pRevDedAtoCoop := ObterConteudo(LNode, tcDe8);
  LNode := ANode.Childrens.FindAnyNs('pExportIaV');
  A.TempExportIaV := Assigned(LNode);
  if A.TempExportIaV then
    A.pExportIaV := ObterConteudo(LNode, tcDe8);
  LNode := ANode.Childrens.FindAnyNs('pExportVI');
  A.TempExportVI := Assigned(LNode);
  if A.TempExportVI then
    A.pExportVI := ObterConteudo(LNode, tcDe8);
  LNode := ANode.Childrens.FindAnyNs('pExportIX');
  A.TempExportIX := Assigned(LNode);
  if A.TempExportIX then
    A.pExportIX := ObterConteudo(LNode, tcDe8);
  LNode := ANode.Childrens.FindAnyNs('pExportXI');
  A.TempExportXI := Assigned(LNode);
  if A.TempExportXI then
    A.pExportXI := ObterConteudo(LNode, tcDe8);
  LNode := ANode.Childrens.FindAnyNs('pExportXIII');
  A.TempExportXIII := Assigned(LNode);
  if A.TempExportXIII then
    A.pExportXIII := ObterConteudo(LNode, tcDe8);
  LNode := ANode.Childrens.FindAnyNs('pExportXIV');
  A.TempExportXIV := Assigned(LNode);
  if A.TempExportXIV then
    A.pExportXIV := ObterConteudo(LNode, tcDe8);
  LNode := ANode.Childrens.FindAnyNs('pExportProg');
  A.TempExportProg := Assigned(LNode);
  if A.TempExportProg then
    A.pExportProg := ObterConteudo(LNode, tcDe8);
end;

procedure TDeRERetornoXmlReader.Ler_TgBCIBSRet(const ANode: TACBrXmlNode; A: TgBCIBSRet);
var
  LNode: TACBrXmlNode;
begin
  if not Assigned(ANode) then Exit;

  A.vBCIBS := ObterConteudo(ANode.Childrens.FindAnyNs('vBCIBS'), tcDe2);
  LNode := ANode.Childrens.FindAnyNs('vBCNIBS');
  A.TemvBCNIBS := Assigned(LNode);
  if A.TemvBCNIBS then
    A.vBCNIBS := ObterConteudo(LNode, tcDe2);
  LNode := ANode.Childrens.FindAnyNs('vDedBCN');
  A.TemvDedBCN := Assigned(LNode);
  if A.TemvDedBCN then
    A.vDedBCN := ObterConteudo(LNode, tcDe2);
  A.vBCApurIBS := ObterConteudo(ANode.Childrens.FindAnyNs('vBCApurIBS'), tcDe2);
  A.pIBSMun := ObterConteudo(ANode.Childrens.FindAnyNs('pIBSMun'), tcDe6);
  A.vIBSMun := ObterConteudo(ANode.Childrens.FindAnyNs('vIBSMun'), tcDe2);
  A.pIBSUF := ObterConteudo(ANode.Childrens.FindAnyNs('pIBSUF'), tcDe6);
  A.vIBSUF := ObterConteudo(ANode.Childrens.FindAnyNs('vIBSUF'), tcDe2);
  A.pIBS := ObterConteudo(ANode.Childrens.FindAnyNs('pIBS'), tcDe6);
  A.vIBSTot := ObterConteudo(ANode.Childrens.FindAnyNs('vIBSTot'), tcDe2);
end;

procedure TDeRERetornoXmlReader.Ler_TgBCCBSRet(const ANode: TACBrXmlNode; A: TgBCCBSRet);
var
  LNode: TACBrXmlNode;
begin
  if not Assigned(ANode) then Exit;

  A.vBCCBS := ObterConteudo(ANode.Childrens.FindAnyNs('vBCCBS'), tcDe2);
  LNode := ANode.Childrens.FindAnyNs('vBCNCBS');
  A.TemvBCNCBS := Assigned(LNode);
  if A.TemvBCNCBS then
    A.vBCNCBS := ObterConteudo(LNode, tcDe2);
  LNode := ANode.Childrens.FindAnyNs('vDedBCN');
  A.TemvDedBCN := Assigned(LNode);
  if A.TemvDedBCN then
    A.vDedBCN := ObterConteudo(LNode, tcDe2);
  A.vBCApurCBS := ObterConteudo(ANode.Childrens.FindAnyNs('vBCApurCBS'), tcDe2);
  A.pCBS := ObterConteudo(ANode.Childrens.FindAnyNs('pCBS'), tcDe6);
  A.vCBS := ObterConteudo(ANode.Childrens.FindAnyNs('vCBS'), tcDe2);
end;

procedure TDeRERetornoXmlReader.Ler_TgBCISRet(const ANode: TACBrXmlNode; A: TgBCISRet);
var
  LNode: TACBrXmlNode;
begin
  if not Assigned(ANode) then Exit;

  A.vBCIS := ObterConteudo(ANode.Childrens.FindAnyNs('vBCIS'), tcDe2);
  LNode := ANode.Childrens.FindAnyNs('vBCApurIS');
  A.TemvBCApurIS := Assigned(LNode);
  if A.TemvBCApurIS then
    A.vBCApurIS := ObterConteudo(LNode, tcDe2);
  LNode := ANode.Childrens.FindAnyNs('pIS');
  A.TempIS := Assigned(LNode);
  if A.TempIS then
    A.pIS := ObterConteudo(LNode, tcDe6);
  LNode := ANode.Childrens.FindAnyNs('vIS');
  A.TemvIS := Assigned(LNode);
  if A.TemvIS then
    A.vIS := ObterConteudo(LNode, tcDe2);
end;

procedure TDeRERetornoXmlReader.Ler_TdetBCNRet(const ANode: TACBrXmlNode; A: TdetBCNCollectionItemRet);
begin
  if not Assigned(ANode) then Exit;

  A.codBCN := ObterConteudo(ANode.Childrens.FindAnyNs('codBCN'), tcStr);
  A.perOrigem := ObterConteudo(ANode.Childrens.FindAnyNs('perOrigem'), tcStr);
  A.vOrigemIni := ObterConteudo(ANode.Childrens.FindAnyNs('vOrigemIni'), tcDe2);
  A.vSaldoAnt := ObterConteudo(ANode.Childrens.FindAnyNs('vSaldoAnt'), tcDe2);
  A.vUtilPer := ObterConteudo(ANode.Childrens.FindAnyNs('vUtilPer'), tcDe2);
  A.vSaldoFinal := ObterConteudo(ANode.Childrens.FindAnyNs('vSaldoFinal'), tcDe2);
end;

procedure TDeRERetornoXmlReader.Ler_TgBCNRet(const ANode: TACBrXmlNode; A: TgBCNRet);
var
  LNodes: TACBrXmlNodeArray;
  i: Integer;
begin
  if not Assigned(ANode) then Exit;

  A.codBCNRaiz := ObterConteudo(ANode.Childrens.FindAnyNs('codBCNRaiz'), tcStr);
  A.vSaldoAnt := ObterConteudo(ANode.Childrens.FindAnyNs('vSaldoAnt'), tcDe2);
  A.vUtilPer := ObterConteudo(ANode.Childrens.FindAnyNs('vUtilPer'), tcDe2);
  A.vSaldoFinal := ObterConteudo(ANode.Childrens.FindAnyNs('vSaldoFinal'), tcDe2);
  A.qtdOrigens := ObterConteudo(ANode.Childrens.FindAnyNs('qtdOrigens'), tcInt);
  LNodes := ANode.Childrens.FindAllAnyNs('detBCN');
  for i := Low(LNodes) to High(LNodes) do
    Ler_TdetBCNRet(LNodes[i], A.detBCN.New);
end;

procedure TDeRERetornoXmlReader.Ler_TinfoBCNRet(const ANode: TACBrXmlNode; A: TinfoBCNRet);
begin
  if not Assigned(ANode) then Exit;

  Ler_TgBCNRet(ANode.Childrens.FindAnyNs('gBCNIBS'), A.gBCNIBS);
  Ler_TgBCNRet(ANode.Childrens.FindAnyNs('gBCNCBS'), A.gBCNCBS);
end;

procedure TDeRERetornoXmlReader.Ler_TdetBCRet(const ANode: TACBrXmlNode; A: TdetBCCollectionItemRet);
var
  LNode: TACBrXmlNode;
begin
  if not Assigned(ANode) then Exit;

  A.codBC := ObterConteudo(ANode.Childrens.FindAnyNs('codBC'), tcStr);
  A.xDetBC := ObterConteudo(ANode.Childrens.FindAnyNs('xDetBC'), tcStr);
  LNode := ANode.Childrens.FindAnyNs('gCoeficientes');
  A.TemgCoeficientes := Assigned(LNode);
  if A.TemgCoeficientes then
    Ler_TgCoeficientesRet(LNode, A.gCoeficientes);
  A.memoriaCalculo := ObterConteudo(ANode.Childrens.FindAnyNs('memoriaCalculo'), tcStr);
  Ler_TgBCIBSRet(ANode.Childrens.FindAnyNs('gBCIBS'), A.gBCIBS);
  Ler_TgBCCBSRet(ANode.Childrens.FindAnyNs('gBCCBS'), A.gBCCBS);
  LNode := ANode.Childrens.FindAnyNs('gBCIS');
  A.TemgBCIS := Assigned(LNode);
  if A.TemgBCIS then
    Ler_TgBCISRet(LNode, A.gBCIS);
  LNode := ANode.Childrens.FindAnyNs('infoBCN');
  A.TeminfoBCN := Assigned(LNode);
  if A.TeminfoBCN then
    Ler_TinfoBCNRet(LNode, A.infoBCN);
end;

procedure TDeRERetornoXmlReader.Ler_TtotalTributosRet(const ANode: TACBrXmlNode; A: TtotalTributosRet);
var
  LNode: TACBrXmlNode;
begin
  if not Assigned(ANode) then Exit;

  LNode := ANode.Childrens.FindAnyNs('vIS');
  A.TemvIS := Assigned(LNode);
  if A.TemvIS then
    A.vIS := ObterConteudo(LNode, tcDe2);
  A.vIBSMun := ObterConteudo(ANode.Childrens.FindAnyNs('vIBSMun'), tcDe2);
  A.vIBSUF := ObterConteudo(ANode.Childrens.FindAnyNs('vIBSUF'), tcDe2);
  A.vIBSTot := ObterConteudo(ANode.Childrens.FindAnyNs('vIBSTot'), tcDe2);
  A.vCBS := ObterConteudo(ANode.Childrens.FindAnyNs('vCBS'), tcDe2);
end;

procedure TDeRERetornoXmlReader.Ler_TinfoTotMensalRet(const ANode: TACBrXmlNode; A: TinfoTotMensalRet);
var
  LNodes: TACBrXmlNodeArray;
  i: Integer;
begin
  if not Assigned(ANode) then Exit;

  LNodes := ANode.Childrens.FindAllAnyNs('detBC');
  for i := Low(LNodes) to High(LNodes) do
    Ler_TdetBCRet(LNodes[i], A.detBC.New);
  Ler_TtotalTributosRet(ANode.Childrens.FindAnyNs('totalTributos'), A.totalTributos);
end;

// Quando o ambiente nao identifica o tipo do evento (tpEv = D0, ex.: erro MS0010 de namespace
// desconhecido), obtem o tipo pelo id do evento: 'DeRE' + tipo(4) + ... (ex.: DeRE1121... = D-1121).
procedure CorrigirTipoEventoRetorno(AInfo: TinfoRecEv; const AId: string);
var
  LTipo: TTipoEventoDeRE;
begin
  if (AInfo = nil) or TryStrToTipoEventoDeRE(AInfo.tpEvStr, LTipo) then
    Exit;

  if (Length(AId) >= 8) and TryStrToTipoEventoDeRE('D' + Copy(AId, 5, 4), LTipo) then
  begin
    AInfo.tpEv := LTipo;
    AInfo.tpEvStr := TipoEventoDeREToStr(LTipo);
  end;
end;

// Id do evento: atributo id do item ou, se vazio, o id do elemento evtRetorno*.
function IdEventoRetorno(const AId, AXml: string): string;
var
  p: Integer;
begin
  Result := Trim(AId);
  if Result <> '' then
    Exit;

  p := Pos('id="DeRE', AXml);
  if p > 0 then
    Result := Copy(AXml, p + 4, 42);
end;

procedure InterpretarRetornoEvento(AItem: TRetornoEventoCollectionItem);
var
  LXML: string;
  LTag, LAux: string;
  LTipo: TTipoRetornoDeRE;
  LRet: TDeRERetornoXmlReader;
  LTab: TDeREXmlReader;
begin
  AItem.Retorno.Free;
  AItem.Retorno := nil;
  AItem.RetornoTabela.Free;
  AItem.RetornoTabela := nil;
  AItem.TipoRetorno := trtNenhum;

  LXML := Trim(AItem.XML);
  if LXML = '' then Exit;

  // Descobre o tipo pelo nome do elemento evtRetorno* presente no XML
  LTag := '';
  for LTipo := Low(TTipoRetornoDeRE) to High(TTipoRetornoDeRE) do
  begin
    LAux := NomeTagRetorno(LTipo);
    if (LAux <> '') and (Pos('<' + LAux, LXML) > 0) then
    begin
      LTag := LAux;
      Break;
    end;
  end;

  AItem.TipoRetorno := TipoRetornoDeREDoTag(LTag);

  case AItem.TipoRetorno of
    trtNenhum: Exit;

    trtTabela:
      begin
        if Pos('<DeRE', LXML) = 0 then
          LXML := '<DeRE>' + LXML + '</DeRE>';
        AItem.RetornoTabela := TevtRetornoTabela.Create;
        LTab := TDeREXmlReader.Create;
        try
          LTab.evtRetTabela := AItem.RetornoTabela;
          LTab.Arquivo := LXML;
          LTab.LerXml;
        finally
          LTab.Free;
        end;
        CorrigirTipoEventoRetorno(AItem.RetornoTabela.infoRecEv, IdEventoRetorno(AItem.id, LXML));
      end;
  else
    begin
      AItem.Retorno := TevtRetornoDeRE.Create;
      LRet := TDeRERetornoXmlReader.Create;
      try
        LRet.evtRetorno := AItem.Retorno;
        LRet.Arquivo := LXML;
        LRet.LerXml;
      finally
        LRet.Free;
      end;
      CorrigirTipoEventoRetorno(AItem.Retorno.infoRecEv, IdEventoRetorno(AItem.id, LXML));
    end;
  end;
end;

procedure InterpretarRetornosLote(ALote: TretornoLoteDeRE);
var
  i: Integer;
begin
  for i := 0 to ALote.retornoEventos.Count - 1 do
    InterpretarRetornoEvento(ALote.retornoEventos[i]);
end;

end.
