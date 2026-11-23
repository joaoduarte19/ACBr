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

unit ACBrDeRE.D2202.XmlReader;

interface

uses
  Classes, SysUtils,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrXmlDocument,
  ACBrDeRE.Classes,
  ACBrDeRE.D2202.Classes,
  ACBrDeRE.Conversao,
  ACBrDeRE.XmlReader;

type
  { TDeREServRemTarifaXmlReader - le o XML do evento evtServRemTarifa (D-2202) }

  TDeREServRemTarifaXmlReader = class(TDeREEventoXmlReader)
  private
    function Evt: TevtServRemTarifa;

    procedure Ler_infoOper(const ANode: TACBrXmlNode; A: TinfoOperD2202);
    procedure Ler_gOper(const ANode: TACBrXmlNode; A: TgOperD2202);
    procedure Ler_idePartes(const ANode: TACBrXmlNode; A: TidePartesD2202);
    procedure Ler_infoAdq(const ANode: TACBrXmlNode; A: TinfoAdqD2202);
    procedure Ler_adqExterior(const ANode: TACBrXmlNode; A: TadqExteriorD2202);
    procedure Ler_dadosOper(const ANode: TACBrXmlNode; A: TdadosOperD2202);
    procedure Ler_detOper(const ANode: TACBrXmlNode; A: TdetOperCollectionItemD2202);
    procedure Ler_qualifOper(const ANode: TACBrXmlNode; A: TqualifOperD2202);
    procedure Ler_gBC(const ANode: TACBrXmlNode; A: TgBCD2202);
    procedure Ler_gTributos(const ANode: TACBrXmlNode; A: TgTributosD2202);
  protected
    function GetNomeEvento: string; override;
    procedure Ler_Evento(const ANode: TACBrXmlNode); override;
  end;

implementation

uses
  ACBrUtil.Strings;

{ TDeREServRemTarifaXmlReader }

function TDeREServRemTarifaXmlReader.Evt: TevtServRemTarifa;
begin
  Result := (DeRE as TDeRED2202).evtServRemTarifa;
end;

function TDeREServRemTarifaXmlReader.GetNomeEvento: string;
begin
  Result := 'evtServRemTarifa';
end;

procedure TDeREServRemTarifaXmlReader.Ler_Evento(const ANode: TACBrXmlNode);
begin
  Ler_ideEventoFin(ANode.Childrens.FindAnyNs('ideEvento'), Evt.ideEvento);
  Ler_ideContrib(ANode.Childrens.FindAnyNs('ideContrib'), Evt.ideContrib);
  Ler_idePeriodoApurSub(ANode.Childrens.FindAnyNs('idePeriodo'), Evt.idePeriodo);

  Ler_infoOper(ANode.Childrens.FindAnyNs('infoOper'), Evt.infoOper);
end;

procedure TDeREServRemTarifaXmlReader.Ler_infoOper(const ANode: TACBrXmlNode; A: TinfoOperD2202);
begin
  if not Assigned(ANode) then Exit;

  Ler_gOper(ANode.Childrens.FindAnyNs('gOper'), A.gOper);
end;

procedure TDeREServRemTarifaXmlReader.Ler_gOper(const ANode: TACBrXmlNode; A: TgOperD2202);
var
  LNode: TACBrXmlNode;
begin
  if not Assigned(ANode) then Exit;

  A.chAgrup := ObterConteudo(ANode.Childrens.FindAnyNs('chAgrup'), tcStr);
  A.codBC := ObterConteudo(ANode.Childrens.FindAnyNs('codBC'), tcStr);
  LNode := ANode.Childrens.FindAnyNs('chAgrupRef');
  A.TemchAgrupRef := Assigned(LNode);
  if A.TemchAgrupRef then
    A.chAgrupRef := ObterConteudo(LNode, tcStr);

  Ler_idePartes(ANode.Childrens.FindAnyNs('idePartes'), A.idePartes);
  Ler_dadosOper(ANode.Childrens.FindAnyNs('dadosOper'), A.dadosOper);
end;

procedure TDeREServRemTarifaXmlReader.Ler_idePartes(const ANode: TACBrXmlNode; A: TidePartesD2202);
begin
  if not Assigned(ANode) then Exit;

  Ler_infoAdq(ANode.Childrens.FindAnyNs('infoAdq'), A.infoAdq);
end;

procedure TDeREServRemTarifaXmlReader.Ler_infoAdq(const ANode: TACBrXmlNode; A: TinfoAdqD2202);
var
  LNode: TACBrXmlNode;
begin
  if not Assigned(ANode) then Exit;

  LNode := ANode.Childrens.FindAnyNs('CPF');
  A.TemCPF := Assigned(LNode);
  if A.TemCPF then
    A.CPF := ObterConteudo(LNode, tcStr);
  LNode := ANode.Childrens.FindAnyNs('CNPJ');
  A.TemCNPJ := Assigned(LNode);
  if A.TemCNPJ then
    A.CNPJ := ObterConteudo(LNode, tcStr);
  LNode := ANode.Childrens.FindAnyNs('cMun');
  A.TemcMun := Assigned(LNode);
  if A.TemcMun then
    A.cMun := ObterConteudo(LNode, tcStr);

  LNode := ANode.Childrens.FindAnyNs('adqExterior');
  A.TemadqExterior := Assigned(LNode);
  if A.TemadqExterior then
    Ler_adqExterior(LNode, A.adqExterior);
end;

procedure TDeREServRemTarifaXmlReader.Ler_adqExterior(const ANode: TACBrXmlNode; A: TadqExteriorD2202);
var
  LNode: TACBrXmlNode;
begin
  if not Assigned(ANode) then Exit;

  LNode := ANode.Childrens.FindAnyNs('NIF');
  A.TemNIF := Assigned(LNode);
  if A.TemNIF then
    A.NIF := ObterConteudo(LNode, tcStr);
  LNode := ANode.Childrens.FindAnyNs('cNaoNIF');
  A.TemcNaoNIF := Assigned(LNode);
  if A.TemcNaoNIF then
    A.cNaoNIF := StrTocNaoNIFDeRE(ObterConteudo(LNode, tcStr));
  LNode := ANode.Childrens.FindAnyNs('nrDocIdent');
  A.TemnrDocIdent := Assigned(LNode);
  if A.TemnrDocIdent then
    A.nrDocIdent := ObterConteudo(LNode, tcStr);
  A.cPais := ObterConteudo(ANode.Childrens.FindAnyNs('cPais'), tcStr);
end;

procedure TDeREServRemTarifaXmlReader.Ler_dadosOper(const ANode: TACBrXmlNode; A: TdadosOperD2202);
var
  LNodes: TACBrXmlNodeArray;
  i: Integer;
begin
  if not Assigned(ANode) then Exit;

  LNodes := ANode.Childrens.FindAllAnyNs('detOper');
  for i := 0 to Length(LNodes) - 1 do
    Ler_detOper(LNodes[i], A.detOper.New);
end;

procedure TDeREServRemTarifaXmlReader.Ler_detOper(const ANode: TACBrXmlNode; A: TdetOperCollectionItemD2202);
var
  LAtt: TACBrXmlAttribute;
  LNode: TACBrXmlNode;
begin
  if not Assigned(ANode) then Exit;

  LAtt := ANode.Attributes.Items['seq'];
  if Assigned(LAtt) then
    A.seq := LAtt.Content;
  LNode := ANode.Childrens.FindAnyNs('seqRef');
  A.TemseqRef := Assigned(LNode);
  if A.TemseqRef then
    A.seqRef := ObterConteudo(LNode, tcStr);
  A.dhOper := ObterConteudo(ANode.Childrens.FindAnyNs('dhOper'), tcDatHor);

  LNode := ANode.Childrens.FindAnyNs('qualifOper');
  A.TemqualifOper := Assigned(LNode);
  if A.TemqualifOper then
    Ler_qualifOper(LNode, A.qualifOper);
  Ler_gBC(ANode.Childrens.FindAnyNs('gBC'), A.gBC);
  Ler_gTributos(ANode.Childrens.FindAnyNs('gTributos'), A.gTributos);
end;

procedure TDeREServRemTarifaXmlReader.Ler_qualifOper(const ANode: TACBrXmlNode; A: TqualifOperD2202);
var
  LNode: TACBrXmlNode;
begin
  if not Assigned(ANode) then Exit;

  LNode := ANode.Childrens.FindAnyNs('indPresenc');
  A.TemindPresenc := Assigned(LNode);
  if A.TemindPresenc then
    A.indPresenc := (ObterConteudo(LNode, tcStr) = '1');
  LNode := ANode.Childrens.FindAnyNs('cMunOper');
  A.TemcMunOper := Assigned(LNode);
  if A.TemcMunOper then
    A.cMunOper := ObterConteudo(LNode, tcStr);
end;

procedure TDeREServRemTarifaXmlReader.Ler_gBC(const ANode: TACBrXmlNode; A: TgBCD2202);
begin
  if not Assigned(ANode) then Exit;

  A.vBCApur := ObterConteudo(ANode.Childrens.FindAnyNs('vBCApur'), tcDe2);
end;

procedure TDeREServRemTarifaXmlReader.Ler_gTributos(const ANode: TACBrXmlNode; A: TgTributosD2202);
begin
  if not Assigned(ANode) then Exit;

  A.vBCTrib := ObterConteudo(ANode.Childrens.FindAnyNs('vBCTrib'), tcDe2);
  A.pIBSMunTrib := ObterConteudo(ANode.Childrens.FindAnyNs('pIBSMunTrib'), tcDe4);
  A.vIBSMunTrib := ObterConteudo(ANode.Childrens.FindAnyNs('vIBSMunTrib'), tcDe2);
  A.pIBSUFTrib := ObterConteudo(ANode.Childrens.FindAnyNs('pIBSUFTrib'), tcDe4);
  A.vIBSUFTrib := ObterConteudo(ANode.Childrens.FindAnyNs('vIBSUFTrib'), tcDe2);
  A.pCBSTrib := ObterConteudo(ANode.Childrens.FindAnyNs('pCBSTrib'), tcDe4);
  A.vCBSTrib := ObterConteudo(ANode.Childrens.FindAnyNs('vCBSTrib'), tcDe2);
end;

initialization
  RegistrarReaderDeRE(teServRemTarifa, TDeREServRemTarifaXmlReader);

end.
