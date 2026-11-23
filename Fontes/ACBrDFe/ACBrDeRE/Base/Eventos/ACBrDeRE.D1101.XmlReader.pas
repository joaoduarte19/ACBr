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

unit ACBrDeRE.D1101.XmlReader;

interface

uses
  Classes, SysUtils,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrXmlDocument,
  ACBrDeRE.Classes,
  ACBrDeRE.D1101.Classes,
  ACBrDeRE.Conversao,
  ACBrDeRE.XmlReader;

type
  { TDeREBalanceteXmlReader - le o XML do evento evtBalancete (D-1101) }

  TDeREBalanceteXmlReader = class(TDeREEventoXmlReader)
  private
    function Evt: TevtBalancete;

    procedure Ler_infoBalancete(const ANode: TACBrXmlNode; A: TinfoBalanceteD1101);
    procedure Ler_infoContas(const ANode: TACBrXmlNode; A: TinfoContaBalanceteCollectionD1101);
    procedure Ler_infoConta(const ANode: TACBrXmlNode; A: TinfoContaBalanceteCollectionItemD1101);
  protected
    function GetNomeEvento: string; override;
    procedure Ler_Evento(const ANode: TACBrXmlNode); override;
  end;

implementation

uses
  ACBrUtil.Strings;

{ TDeREBalanceteXmlReader }

function TDeREBalanceteXmlReader.Evt: TevtBalancete;
begin
  Result := (DeRE as TDeRED1101).evtBalancete;
end;

function TDeREBalanceteXmlReader.GetNomeEvento: string;
begin
  Result := 'evtBalancete';
end;

procedure TDeREBalanceteXmlReader.Ler_Evento(const ANode: TACBrXmlNode);
var
  LNode: TACBrXmlNode;
begin
  Ler_ideEventoRecibo(ANode.Childrens.FindAnyNs('ideEvento'), Evt.ideEvento);
  Ler_ideContrib(ANode.Childrens.FindAnyNs('ideContrib'), Evt.ideContrib);
  Ler_idePeriodoApur(ANode.Childrens.FindAnyNs('idePeriodo'), Evt.idePeriodo);

  LNode := ANode.Childrens.FindAnyNs('infoBalancete');
  Evt.infoBalancete.TeminfoBalancete := Assigned(LNode);
  if Evt.infoBalancete.TeminfoBalancete then
    Ler_infoBalancete(LNode, Evt.infoBalancete);
end;

procedure TDeREBalanceteXmlReader.Ler_infoBalancete(const ANode: TACBrXmlNode; A: TinfoBalanceteD1101);
begin
  if not Assigned(ANode) then Exit;

  Ler_infoContas(ANode.Childrens.FindAnyNs('infoContas'), A.infoContas);
end;

procedure TDeREBalanceteXmlReader.Ler_infoContas(const ANode: TACBrXmlNode; A: TinfoContaBalanceteCollectionD1101);
var
  LNodes: TACBrXmlNodeArray;
  i: Integer;
begin
  if not Assigned(ANode) then Exit;

  LNodes := ANode.Childrens.FindAllAnyNs('infoConta');
  for i := 0 to Length(LNodes) - 1 do
    Ler_infoConta(LNodes[i], A.New);
end;

procedure TDeREBalanceteXmlReader.Ler_infoConta(const ANode: TACBrXmlNode; A: TinfoContaBalanceteCollectionItemD1101);
var
  LNode: TACBrXmlNode;
begin
  if not Assigned(ANode) then Exit;

  A.cCta := ObterConteudo(ANode.Childrens.FindAnyNs('cCta'), tcStr);
  A.natSaldoInic := StrTonatSaldoDeRE(ObterConteudo(ANode.Childrens.FindAnyNs('natSaldoInic'), tcStr));
  A.vSaldoInic := ObterConteudo(ANode.Childrens.FindAnyNs('vSaldoInic'), tcDe2);
  A.vMovDebt := ObterConteudo(ANode.Childrens.FindAnyNs('vMovDebt'), tcDe2);
  LNode := ANode.Childrens.FindAnyNs('vAjusteDebt');
  A.TemvAjusteDebt := Assigned(LNode);
  if A.TemvAjusteDebt then
    A.vAjusteDebt := ObterConteudo(LNode, tcDe2);
  A.vMovCred := ObterConteudo(ANode.Childrens.FindAnyNs('vMovCred'), tcDe2);
  LNode := ANode.Childrens.FindAnyNs('vAjusteCred');
  A.TemvAjusteCred := Assigned(LNode);
  if A.TemvAjusteCred then
    A.vAjusteCred := ObterConteudo(LNode, tcDe2);
  A.natSaldoFinal := StrTonatSaldoDeRE(ObterConteudo(ANode.Childrens.FindAnyNs('natSaldoFinal'), tcStr));
  A.vSaldoFinal := ObterConteudo(ANode.Childrens.FindAnyNs('vSaldoFinal'), tcDe2);
  LNode := ANode.Childrens.FindAnyNs('natVApur');
  A.TemnatVApur := Assigned(LNode);
  if A.TemnatVApur then
    A.natVApur := StrTonatSaldoDeRE(ObterConteudo(LNode, tcStr));
  A.vApur := ObterConteudo(ANode.Childrens.FindAnyNs('vApur'), tcDe2);
end;

initialization
  RegistrarReaderDeRE(teBalancete, TDeREBalanceteXmlReader);

end.
