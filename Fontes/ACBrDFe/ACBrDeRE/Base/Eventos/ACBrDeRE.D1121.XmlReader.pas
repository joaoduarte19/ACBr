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

unit ACBrDeRE.D1121.XmlReader;

interface

uses
  Classes, SysUtils,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrXmlDocument,
  ACBrDeRE.Classes,
  ACBrDeRE.D1121.Classes,
  ACBrDeRE.Conversao,
  ACBrDeRE.XmlReader;

type
  { TDeRERelDeducoesXmlReader - le o XML do evento evtRelDeducoes (D-1121) }

  TDeRERelDeducoesXmlReader = class(TDeREEventoXmlReader)
  private
    function Evt: TevtRelDeducoes;

    procedure Ler_infoDeducoes(const ANode: TACBrXmlNode; A: TinfoDeducoesD1121);
    procedure Ler_infoDeducao(const ANode: TACBrXmlNode; A: TinfoDeducaoCollectionItemD1121);
    procedure Ler_infoDFe(const ANode: TACBrXmlNode; A: TinfoDFeD1121);
    procedure Ler_infoImovel(const ANode: TACBrXmlNode; A: TinfoImovelD1121);
    procedure Ler_detDeducao(const ANode: TACBrXmlNode; A: TdetDeducaoD1121);
    procedure Ler_desdobDeducao(const ANode: TACBrXmlNode; A: TdesdobDeducaoCollectionItemD1121);
    procedure Ler_itemDFe(const ANode: TACBrXmlNode; A: TitemDFeCollectionItemD1121);
  protected
    function GetNomeEvento: string; override;
    procedure Ler_Evento(const ANode: TACBrXmlNode); override;
  end;

implementation

uses
  ACBrUtil.Strings;

{ TDeRERelDeducoesXmlReader }

function TDeRERelDeducoesXmlReader.Evt: TevtRelDeducoes;
begin
  Result := (DeRE as TDeRED1121).evtRelDeducoes;
end;

function TDeRERelDeducoesXmlReader.GetNomeEvento: string;
begin
  Result := 'evtRelDeducoes';
end;

procedure TDeRERelDeducoesXmlReader.Ler_Evento(const ANode: TACBrXmlNode);
var
  LNode: TACBrXmlNode;
begin
  Ler_ideEventoRecibo(ANode.Childrens.FindAnyNs('ideEvento'), Evt.ideEvento);
  Ler_ideContrib(ANode.Childrens.FindAnyNs('ideContrib'), Evt.ideContrib);
  Ler_idePeriodoApur(ANode.Childrens.FindAnyNs('idePeriodo'), Evt.idePeriodo);

  LNode := ANode.Childrens.FindAnyNs('infoDeducoes');
  Evt.infoDeducoes.TeminfoDeducoes := Assigned(LNode);
  if Evt.infoDeducoes.TeminfoDeducoes then
    Ler_infoDeducoes(LNode, Evt.infoDeducoes);
end;

procedure TDeRERelDeducoesXmlReader.Ler_infoDeducoes(const ANode: TACBrXmlNode; A: TinfoDeducoesD1121);
var
  LNode: TACBrXmlNode;
  LNodes: TACBrXmlNodeArray;
  i: Integer;
begin
  if not Assigned(ANode) then Exit;

  LNode := ANode.Childrens.FindAnyNs('finEvt');
  A.TemfinEvt := Assigned(LNode);
  if A.TemfinEvt then
    A.finEvt := StrTofinEvtDeRE(ObterConteudo(LNode, tcStr));

  LNodes := ANode.Childrens.FindAllAnyNs('infoDeducao');
  for i := 0 to Length(LNodes) - 1 do
    Ler_infoDeducao(LNodes[i], A.infoDeducao.New);
end;

procedure TDeRERelDeducoesXmlReader.Ler_infoDeducao(const ANode: TACBrXmlNode; A: TinfoDeducaoCollectionItemD1121);
var
  LNode: TACBrXmlNode;
begin
  if not Assigned(ANode) then Exit;

  LNode := ANode.Childrens.FindAnyNs('infoDFe');
  A.TeminfoDFe := Assigned(LNode);
  if A.TeminfoDFe then
    Ler_infoDFe(LNode, A.infoDFe);
  LNode := ANode.Childrens.FindAnyNs('infoImovel');
  A.TeminfoImovel := Assigned(LNode);
  if A.TeminfoImovel then
    Ler_infoImovel(LNode, A.infoImovel);
  LNode := ANode.Childrens.FindAnyNs('detDeducao');
  A.TemdetDeducao := Assigned(LNode);
  if A.TemdetDeducao then
    Ler_detDeducao(LNode, A.detDeducao);
end;

procedure TDeRERelDeducoesXmlReader.Ler_infoDFe(const ANode: TACBrXmlNode; A: TinfoDFeD1121);
var
  LAtt: TACBrXmlAttribute;
  LNode: TACBrXmlNode;
begin
  if not Assigned(ANode) then Exit;

  LAtt := ANode.Attributes.Items['chDFe'];
  if Assigned(LAtt) then
    A.chDFe := LAtt.Content;
  LAtt := ANode.Attributes.Items['chDFeRetif'];
  if Assigned(LAtt) then
    A.chDFeRetif := LAtt.Content;
  LNode := ANode.Childrens.FindAnyNs('tpDFe');
  A.TemtpDFe := Assigned(LNode);
  if A.TemtpDFe then
    A.tpDFe := StrTotpDFeDeRE(ObterConteudo(LNode, tcStr));
  LNode := ANode.Childrens.FindAnyNs('dtEmi');
  A.TemdtEmi := Assigned(LNode);
  if A.TemdtEmi then
    A.dtEmi := ObterConteudo(LNode, tcDat);
end;

procedure TDeRERelDeducoesXmlReader.Ler_infoImovel(const ANode: TACBrXmlNode; A: TinfoImovelD1121);
begin
  if not Assigned(ANode) then Exit;

  A.CPFAlien := ObterConteudo(ANode.Childrens.FindAnyNs('CPFAlien'), tcStr);
end;

procedure TDeRERelDeducoesXmlReader.Ler_detDeducao(const ANode: TACBrXmlNode; A: TdetDeducaoD1121);
var
  LNodes: TACBrXmlNodeArray;
  i: Integer;
begin
  if not Assigned(ANode) then Exit;

  A.vOper := ObterConteudo(ANode.Childrens.FindAnyNs('vOper'), tcDe2);

  LNodes := ANode.Childrens.FindAllAnyNs('desdobDeducao');
  for i := 0 to Length(LNodes) - 1 do
    Ler_desdobDeducao(LNodes[i], A.desdobDeducoes.New);
end;

procedure TDeRERelDeducoesXmlReader.Ler_desdobDeducao(const ANode: TACBrXmlNode; A: TdesdobDeducaoCollectionItemD1121);
var
  LAtt: TACBrXmlAttribute;
  LNode: TACBrXmlNode;
  LNodes: TACBrXmlNodeArray;
  i: Integer;
begin
  if not Assigned(ANode) then Exit;

  LAtt := ANode.Attributes.Items['tpAtiv'];
  if Assigned(LAtt) then
    A.tpAtiv := StrTotpAtivDedDeRE(LAtt.Content);
  A.cCta := ObterConteudo(ANode.Childrens.FindAnyNs('cCta'), tcStr);
  LNode := ANode.Childrens.FindAnyNs('vDedTotal');
  A.TemvDedTotal := Assigned(LNode);
  if A.TemvDedTotal then
    A.vDedTotal := ObterConteudo(LNode, tcDe2);
  A.vDed := ObterConteudo(ANode.Childrens.FindAnyNs('vDed'), tcDe2);

  LNodes := ANode.Childrens.FindAllAnyNs('itemDFe');
  for i := 0 to Length(LNodes) - 1 do
    Ler_itemDFe(LNodes[i], A.itemsDFe.New);
end;

procedure TDeRERelDeducoesXmlReader.Ler_itemDFe(const ANode: TACBrXmlNode; A: TitemDFeCollectionItemD1121);
var
  LAtt: TACBrXmlAttribute;
  LNode: TACBrXmlNode;
begin
  if not Assigned(ANode) then Exit;

  LAtt := ANode.Attributes.Items['nItem'];
  if Assigned(LAtt) then
    A.nItem := LAtt.Content;
  A.vItem := ObterConteudo(ANode.Childrens.FindAnyNs('vItem'), tcDe2);
  LNode := ANode.Childrens.FindAnyNs('vItemDedTotal');
  A.TemvItemDedTotal := Assigned(LNode);
  if A.TemvItemDedTotal then
    A.vItemDedTotal := ObterConteudo(LNode, tcDe2);
  A.vItemDed := ObterConteudo(ANode.Childrens.FindAnyNs('vItemDed'), tcDe2);
end;

initialization
  RegistrarReaderDeRE(teRelDeducoes, TDeRERelDeducoesXmlReader);

end.
