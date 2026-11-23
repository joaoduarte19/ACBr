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

unit ACBrDeRE.D1106.XmlReader;

interface

uses
  Classes, SysUtils,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrXmlDocument,
  ACBrDeRE.Classes,
  ACBrDeRE.D1106.Classes,
  ACBrDeRE.Conversao,
  ACBrDeRE.XmlReader;

type
  { TDeREAplicResTecXmlReader - le o XML do evento evtAplicResTec (D-1106) }

  TDeREAplicResTecXmlReader = class(TDeREEventoXmlReader)
  private
    function Evt: TevtAplicResTec;

    procedure Ler_infoAplicResTec(const ANode: TACBrXmlNode; A: TinfoAplicResTecD1106);
    procedure Ler_infoAplic(const ANode: TACBrXmlNode; A: TinfoAplicCollectionItemD1106);
    procedure Ler_detAtivo(const ANode: TACBrXmlNode; A: TdetAtivoCollectionItemD1106);
  protected
    function GetNomeEvento: string; override;
    procedure Ler_Evento(const ANode: TACBrXmlNode); override;
  end;

implementation

uses
  ACBrUtil.Strings;

{ TDeREAplicResTecXmlReader }

function TDeREAplicResTecXmlReader.Evt: TevtAplicResTec;
begin
  Result := (DeRE as TDeRED1106).evtAplicResTec;
end;

function TDeREAplicResTecXmlReader.GetNomeEvento: string;
begin
  Result := 'evtAplicResTec';
end;

procedure TDeREAplicResTecXmlReader.Ler_Evento(const ANode: TACBrXmlNode);
var
  LNode: TACBrXmlNode;
begin
  Ler_ideEventoRecibo(ANode.Childrens.FindAnyNs('ideEvento'), Evt.ideEvento);
  Ler_ideContrib(ANode.Childrens.FindAnyNs('ideContrib'), Evt.ideContrib);
  Ler_idePeriodoApur(ANode.Childrens.FindAnyNs('idePeriodo'), Evt.idePeriodo);

  LNode := ANode.Childrens.FindAnyNs('infoAplicResTec');
  Evt.infoAplicResTec.TeminfoAplicResTec := Assigned(LNode);
  if Evt.infoAplicResTec.TeminfoAplicResTec then
    Ler_infoAplicResTec(LNode, Evt.infoAplicResTec);
end;

procedure TDeREAplicResTecXmlReader.Ler_infoAplicResTec(const ANode: TACBrXmlNode; A: TinfoAplicResTecD1106);
var
  LNodes: TACBrXmlNodeArray;
  i: Integer;
begin
  if not Assigned(ANode) then Exit;

  A.semAplic := Assigned(ANode.Childrens.FindAnyNs('semAplic'));

  LNodes := ANode.Childrens.FindAllAnyNs('infoAplic');
  for i := 0 to Length(LNodes) - 1 do
    Ler_infoAplic(LNodes[i], A.infoAplic.New);
end;

procedure TDeREAplicResTecXmlReader.Ler_infoAplic(const ANode: TACBrXmlNode; A: TinfoAplicCollectionItemD1106);
var
  LNodes: TACBrXmlNodeArray;
  i: Integer;
begin
  if not Assigned(ANode) then Exit;

  A.cCta := ObterConteudo(ANode.Childrens.FindAnyNs('cCta'), tcStr);

  LNodes := ANode.Childrens.FindAllAnyNs('detAtivo');
  for i := 0 to Length(LNodes) - 1 do
    Ler_detAtivo(LNodes[i], A.detAtivo.New);
end;

procedure TDeREAplicResTecXmlReader.Ler_detAtivo(const ANode: TACBrXmlNode; A: TdetAtivoCollectionItemD1106);
var
  LAtt: TACBrXmlAttribute;
  LNode: TACBrXmlNode;
begin
  if not Assigned(ANode) then Exit;

  LAtt := ANode.Attributes.Items['idAtivo'];
  if Assigned(LAtt) then
    A.idAtivo := LAtt.Content;
  A.descAtivo := ObterConteudo(ANode.Childrens.FindAnyNs('descAtivo'), tcStr);
  A.vSaldoInic := ObterConteudo(ANode.Childrens.FindAnyNs('vSaldoInic'), tcDe2);
  LNode := ANode.Childrens.FindAnyNs('vRendPerReceb');
  A.TemvRendPerReceb := Assigned(LNode);
  if A.TemvRendPerReceb then
    A.vRendPerReceb := ObterConteudo(LNode, tcDe2);
  LNode := ANode.Childrens.FindAnyNs('vVarMensal');
  A.TemvVarMensal := Assigned(LNode);
  if A.TemvVarMensal then
    A.vVarMensal := ObterConteudo(LNode, tcDe2);
  A.vPrincLiqResg := ObterConteudo(ANode.Childrens.FindAnyNs('vPrincLiqResg'), tcDe2);
  LNode := ANode.Childrens.FindAnyNs('vRendLiqResg');
  A.TemvRendLiqResg := Assigned(LNode);
  if A.TemvRendLiqResg then
    A.vRendLiqResg := ObterConteudo(LNode, tcDe2);
  A.vSaldoFinal := ObterConteudo(ANode.Childrens.FindAnyNs('vSaldoFinal'), tcDe2);
  A.vApur := ObterConteudo(ANode.Childrens.FindAnyNs('vApur'), tcDe2);
end;

initialization
  RegistrarReaderDeRE(teAplicResTec, TDeREAplicResTecXmlReader);

end.
