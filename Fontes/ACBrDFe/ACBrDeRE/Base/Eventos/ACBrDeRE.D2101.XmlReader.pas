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

unit ACBrDeRE.D2101.XmlReader;

interface

uses
  Classes, SysUtils,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrXmlDocument,
  ACBrDeRE.Classes,
  ACBrDeRE.D2101.Classes,
  ACBrDeRE.Conversao,
  ACBrDeRE.XmlReader;

type
  { TDeREDebOpOfPublicXmlReader - le o XML do evento evtDebOpOfPublic (D-2101) }

  TDeREDebOpOfPublicXmlReader = class(TDeREEventoXmlReader)
  private
    function Evt: TevtDebOpOfPublic;

    procedure Ler_infoDebOpOfPublic(const ANode: TACBrXmlNode; A: TinfoDebOpOfPublicD2101);
    procedure Ler_infoTitulos(const ANode: TACBrXmlNode; A: TinfoTitulosD2101);
    procedure Ler_detTitulo(const ANode: TACBrXmlNode; A: TdetTituloCollectionItemD2101);
  protected
    function GetNomeEvento: string; override;
    procedure Ler_Evento(const ANode: TACBrXmlNode); override;
  end;

implementation

uses
  ACBrUtil.Strings;

{ TDeREDebOpOfPublicXmlReader }

function TDeREDebOpOfPublicXmlReader.Evt: TevtDebOpOfPublic;
begin
  Result := (DeRE as TDeRED2101).evtDebOpOfPublic;
end;

function TDeREDebOpOfPublicXmlReader.GetNomeEvento: string;
begin
  Result := 'evtDebOpOfPublic';
end;

procedure TDeREDebOpOfPublicXmlReader.Ler_Evento(const ANode: TACBrXmlNode);
var
  LNode: TACBrXmlNode;
begin
  Ler_ideEventoRecibo(ANode.Childrens.FindAnyNs('ideEvento'), Evt.ideEvento);
  Ler_ideContrib(ANode.Childrens.FindAnyNs('ideContrib'), Evt.ideContrib);
  Ler_idePeriodoApur(ANode.Childrens.FindAnyNs('idePeriodo'), Evt.idePeriodo);

  LNode := ANode.Childrens.FindAnyNs('infoDebOpOfPublic');
  Evt.infoDebOpOfPublic.TeminfoDebOpOfPublic := Assigned(LNode);
  if Evt.infoDebOpOfPublic.TeminfoDebOpOfPublic then
    Ler_infoDebOpOfPublic(LNode, Evt.infoDebOpOfPublic);
end;

procedure TDeREDebOpOfPublicXmlReader.Ler_infoDebOpOfPublic(const ANode: TACBrXmlNode; A: TinfoDebOpOfPublicD2101);
var
  LNode: TACBrXmlNode;
begin
  if not Assigned(ANode) then Exit;

  A.semTitulos := Assigned(ANode.Childrens.FindAnyNs('semTitulos'));

  LNode := ANode.Childrens.FindAnyNs('infoTitulos');
  A.TeminfoTitulos := Assigned(LNode);
  if A.TeminfoTitulos then
    Ler_infoTitulos(LNode, A.infoTitulos);
end;

procedure TDeREDebOpOfPublicXmlReader.Ler_infoTitulos(const ANode: TACBrXmlNode; A: TinfoTitulosD2101);
var
  LNodes: TACBrXmlNodeArray;
  i: Integer;
begin
  if not Assigned(ANode) then Exit;

  LNodes := ANode.Childrens.FindAllAnyNs('detTitulo');
  for i := 0 to Length(LNodes) - 1 do
    Ler_detTitulo(LNodes[i], A.detTitulo.New);
end;

procedure TDeREDebOpOfPublicXmlReader.Ler_detTitulo(const ANode: TACBrXmlNode; A: TdetTituloCollectionItemD2101);
var
  LAtt: TACBrXmlAttribute;
  LNode: TACBrXmlNode;
begin
  if not Assigned(ANode) then Exit;

  LAtt := ANode.Attributes.Items['idTitulo'];
  if Assigned(LAtt) then
    A.idTitulo := LAtt.Content;
  LAtt := ANode.Attributes.Items['cCta'];
  if Assigned(LAtt) then
    A.cCta := LAtt.Content;
  LNode := ANode.Childrens.FindAnyNs('descFundo');
  A.TemdescFundo := Assigned(LNode);
  if A.TemdescFundo then
    A.descFundo := ObterConteudo(LNode, tcStr);
  A.CNPJDevedor := ObterConteudo(ANode.Childrens.FindAnyNs('CNPJDevedor'), tcStr);
  A.vSaldoContIni := ObterConteudo(ANode.Childrens.FindAnyNs('vSaldoContIni'), tcDe2);
  A.vEntradas := ObterConteudo(ANode.Childrens.FindAnyNs('vEntradas'), tcDe2);
  A.vSaidas := ObterConteudo(ANode.Childrens.FindAnyNs('vSaidas'), tcDe2);
  A.vJurosRec := ObterConteudo(ANode.Childrens.FindAnyNs('vJurosRec'), tcDe2);
  LNode := ANode.Childrens.FindAnyNs('vVarMensal');
  A.TemvVarMensal := Assigned(LNode);
  if A.TemvVarMensal then
    A.vVarMensal := ObterConteudo(LNode, tcDe2);
  A.vSaldoContFin := ObterConteudo(ANode.Childrens.FindAnyNs('vSaldoContFin'), tcDe2);
  A.vSelic := ObterConteudo(ANode.Childrens.FindAnyNs('vSelic'), tcDe2);
  LNode := ANode.Childrens.FindAnyNs('vPisCofins');
  A.TemvPisCofins := Assigned(LNode);
  if A.TemvPisCofins then
    A.vPisCofins := ObterConteudo(LNode, tcDe2);
  A.vApur := ObterConteudo(ANode.Childrens.FindAnyNs('vApur'), tcDe2);
end;

initialization
  RegistrarReaderDeRE(teDebOpOfPublic, TDeREDebOpOfPublicXmlReader);

end.
