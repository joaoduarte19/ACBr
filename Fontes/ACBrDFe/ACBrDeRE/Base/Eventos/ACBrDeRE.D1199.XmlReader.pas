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

unit ACBrDeRE.D1199.XmlReader;

interface

uses
  Classes, SysUtils,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrXmlDocument,
  ACBrDeRE.Classes,
  ACBrDeRE.D1199.Classes,
  ACBrDeRE.Conversao,
  ACBrDeRE.XmlReader;

type
  { TDeREFechMensalXmlReader - le o XML do evento evtFechMensal (D-1199) }

  TDeREFechMensalXmlReader = class(TDeREEventoXmlReader)
  private
    function Evt: TevtFechMensal;

    procedure Ler_infoFechamento(const ANode: TACBrXmlNode; A: TinfoFechamentoD1199);
    procedure Ler_infoParamFech(const ANode: TACBrXmlNode; A: TinfoParamFechD1199);
    procedure Ler_gUtilizBCN(const ANode: TACBrXmlNode; A: TgUtilizBCND1199);
    procedure Ler_infoBCN(const ANode: TACBrXmlNode; A: TinfoBCNCollectionItemD1199);
    procedure Ler_detBCNeg(const ANode: TACBrXmlNode; A: TdetBCNegCollectionItemD1199);
  protected
    function GetNomeEvento: string; override;
    procedure Ler_Evento(const ANode: TACBrXmlNode); override;
  end;

implementation

uses
  ACBrUtil.Strings;

{ TDeREFechMensalXmlReader }

function TDeREFechMensalXmlReader.Evt: TevtFechMensal;
begin
  Result := (DeRE as TDeRED1199).evtFechMensal;
end;

function TDeREFechMensalXmlReader.GetNomeEvento: string;
begin
  Result := 'evtFechMensal';
end;

procedure TDeREFechMensalXmlReader.Ler_Evento(const ANode: TACBrXmlNode);
var
  LNode: TACBrXmlNode;
begin
  Ler_ideEvento(ANode.Childrens.FindAnyNs('ideEvento'), Evt.ideEvento);
  Ler_ideContrib(ANode.Childrens.FindAnyNs('ideContrib'), Evt.ideContrib);
  Ler_idePeriodoApur(ANode.Childrens.FindAnyNs('idePeriodo'), Evt.idePeriodo);

  LNode := ANode.Childrens.FindAnyNs('infoFechamento');
  Evt.infoFechamento.TeminfoFechamento := Assigned(LNode);
  if Evt.infoFechamento.TeminfoFechamento then
    Ler_infoFechamento(LNode, Evt.infoFechamento);
end;

procedure TDeREFechMensalXmlReader.Ler_infoFechamento(const ANode: TACBrXmlNode; A: TinfoFechamentoD1199);
var
  LNode: TACBrXmlNode;
begin
  if not Assigned(ANode) then Exit;

  LNode := ANode.Childrens.FindAnyNs('infoParamFech');
  A.TeminfoParamFech := Assigned(LNode);
  if A.TeminfoParamFech then
    Ler_infoParamFech(LNode, A.infoParamFech);
  LNode := ANode.Childrens.FindAnyNs('gUtilizBCN');
  A.TemgUtilizBCN := Assigned(LNode);
  if A.TemgUtilizBCN then
    Ler_gUtilizBCN(LNode, A.gUtilizBCN);
end;

procedure TDeREFechMensalXmlReader.Ler_infoParamFech(const ANode: TACBrXmlNode; A: TinfoParamFechD1199);
begin
  if not Assigned(ANode) then Exit;

  A.indInexistDedu := Assigned(ANode.Childrens.FindAnyNs('indInexistDedu'));
end;

procedure TDeREFechMensalXmlReader.Ler_gUtilizBCN(const ANode: TACBrXmlNode; A: TgUtilizBCND1199);
var
  LNodes: TACBrXmlNodeArray;
  i: Integer;
begin
  if not Assigned(ANode) then Exit;

  LNodes := ANode.Childrens.FindAllAnyNs('infoBCN');
  for i := 0 to Length(LNodes) - 1 do
    Ler_infoBCN(LNodes[i], A.infoBCN.New);
  LNodes := ANode.Childrens.FindAllAnyNs('detBCNeg');
  for i := 0 to Length(LNodes) - 1 do
    Ler_detBCNeg(LNodes[i], A.detBCNeg.New);
end;

procedure TDeREFechMensalXmlReader.Ler_infoBCN(const ANode: TACBrXmlNode; A: TinfoBCNCollectionItemD1199);
var
  LNode: TACBrXmlNode;
begin
  if not Assigned(ANode) then Exit;

  A.codBCNRaiz := ObterConteudo(ANode.Childrens.FindAnyNs('codBCNRaiz'), tcStr);
  A.usarBCNAcum := (ObterConteudo(ANode.Childrens.FindAnyNs('usarBCNAcum'), tcStr) = '1');
  LNode := ANode.Childrens.FindAnyNs('metodoAproveit');
  A.TemmetodoAproveit := Assigned(LNode);
  if A.TemmetodoAproveit then
    A.metodoAproveit := StrTometodoAproveitDeRE(ObterConteudo(LNode, tcStr));
end;

procedure TDeREFechMensalXmlReader.Ler_detBCNeg(const ANode: TACBrXmlNode; A: TdetBCNegCollectionItemD1199);
var
  LNode: TACBrXmlNode;
begin
  if not Assigned(ANode) then Exit;

  A.codBCN := ObterConteudo(ANode.Childrens.FindAnyNs('codBCN'), tcStr);
  LNode := ANode.Childrens.FindAnyNs('vUsarBCN');
  A.TemvUsarBCN := Assigned(LNode);
  if A.TemvUsarBCN then
    A.vUsarBCN := ObterConteudo(LNode, tcDe2);
end;

initialization
  RegistrarReaderDeRE(teFechMensal, TDeREFechMensalXmlReader);

end.
