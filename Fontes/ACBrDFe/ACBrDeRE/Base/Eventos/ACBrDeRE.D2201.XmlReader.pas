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

unit ACBrDeRE.D2201.XmlReader;

interface

uses
  Classes, SysUtils,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrXmlDocument,
  ACBrDeRE.Classes,
  ACBrDeRE.D2201.Classes,
  ACBrDeRE.Conversao,
  ACBrDeRE.XmlReader;

type
  { TDeREServRemPrecoXmlReader - le o XML do evento evtServRemPreco (D-2201) }

  TDeREServRemPrecoXmlReader = class(TDeREEventoXmlReader)
  private
    function Evt: TevtServRemPreco;

    procedure Ler_infoOper(const ANode: TACBrXmlNode; A: TinfoOperD2201);
    procedure Ler_gOper(const ANode: TACBrXmlNode; A: TgOperD2201);
    procedure Ler_idePartes(const ANode: TACBrXmlNode; A: TidePartesD2201);
    procedure Ler_infoAdq(const ANode: TACBrXmlNode; A: TinfoAdqD2201);
    procedure Ler_adqExterior(const ANode: TACBrXmlNode; A: TadqExteriorD2201);
    procedure Ler_dadosOper(const ANode: TACBrXmlNode; A: TdadosOperD2201);
    procedure Ler_detOper(const ANode: TACBrXmlNode; A: TdetOperCollectionItemD2201);
    procedure Ler_infoDest(const ANode: TACBrXmlNode; A: TinfoDestD2201);
    procedure Ler_destExterior(const ANode: TACBrXmlNode; A: TdestExteriorD2201);
    procedure Ler_gBC(const ANode: TACBrXmlNode; A: TgBCD2201);
    procedure Ler_gTributos(const ANode: TACBrXmlNode; A: TgTributosD2201);
  protected
    function GetNomeEvento: string; override;
    procedure Ler_Evento(const ANode: TACBrXmlNode); override;
  end;

implementation

uses
  ACBrUtil.Strings;

{ TDeREServRemPrecoXmlReader }

function TDeREServRemPrecoXmlReader.Evt: TevtServRemPreco;
begin
  Result := (DeRE as TDeRED2201).evtServRemPreco;
end;

function TDeREServRemPrecoXmlReader.GetNomeEvento: string;
begin
  Result := 'evtServRemPreco';
end;

procedure TDeREServRemPrecoXmlReader.Ler_Evento(const ANode: TACBrXmlNode);
begin
  Ler_ideEventoFin(ANode.Childrens.FindAnyNs('ideEvento'), Evt.ideEvento);
  Ler_ideContrib(ANode.Childrens.FindAnyNs('ideContrib'), Evt.ideContrib);
  Ler_idePeriodoApurSub(ANode.Childrens.FindAnyNs('idePeriodo'), Evt.idePeriodo);

  Ler_infoOper(ANode.Childrens.FindAnyNs('infoOper'), Evt.infoOper);
end;

procedure TDeREServRemPrecoXmlReader.Ler_infoOper(const ANode: TACBrXmlNode; A: TinfoOperD2201);
begin
  if not Assigned(ANode) then Exit;

  Ler_gOper(ANode.Childrens.FindAnyNs('gOper'), A.gOper);
end;

procedure TDeREServRemPrecoXmlReader.Ler_gOper(const ANode: TACBrXmlNode; A: TgOperD2201);
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

procedure TDeREServRemPrecoXmlReader.Ler_idePartes(const ANode: TACBrXmlNode; A: TidePartesD2201);
begin
  if not Assigned(ANode) then Exit;

  Ler_infoAdq(ANode.Childrens.FindAnyNs('infoAdq'), A.infoAdq);
end;

procedure TDeREServRemPrecoXmlReader.Ler_infoAdq(const ANode: TACBrXmlNode; A: TinfoAdqD2201);
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

procedure TDeREServRemPrecoXmlReader.Ler_adqExterior(const ANode: TACBrXmlNode; A: TadqExteriorD2201);
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

procedure TDeREServRemPrecoXmlReader.Ler_dadosOper(const ANode: TACBrXmlNode; A: TdadosOperD2201);
var
  LNodes: TACBrXmlNodeArray;
  i: Integer;
begin
  if not Assigned(ANode) then Exit;

  LNodes := ANode.Childrens.FindAllAnyNs('detOper');
  for i := 0 to Length(LNodes) - 1 do
    Ler_detOper(LNodes[i], A.detOper.New);
end;

procedure TDeREServRemPrecoXmlReader.Ler_detOper(const ANode: TACBrXmlNode; A: TdetOperCollectionItemD2201);
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

  LNode := ANode.Childrens.FindAnyNs('infoDest');
  A.TeminfoDest := Assigned(LNode);
  if A.TeminfoDest then
    Ler_infoDest(LNode, A.infoDest);
  Ler_gBC(ANode.Childrens.FindAnyNs('gBC'), A.gBC);
  Ler_gTributos(ANode.Childrens.FindAnyNs('gTributos'), A.gTributos);
end;

procedure TDeREServRemPrecoXmlReader.Ler_infoDest(const ANode: TACBrXmlNode; A: TinfoDestD2201);
var
  LNode: TACBrXmlNode;
begin
  if not Assigned(ANode) then Exit;

  LNode := ANode.Childrens.FindAnyNs('CPFDest');
  A.TemCPFDest := Assigned(LNode);
  if A.TemCPFDest then
    A.CPFDest := ObterConteudo(LNode, tcStr);
  LNode := ANode.Childrens.FindAnyNs('CNPJDest');
  A.TemCNPJDest := Assigned(LNode);
  if A.TemCNPJDest then
    A.CNPJDest := ObterConteudo(LNode, tcStr);
  LNode := ANode.Childrens.FindAnyNs('cMunDest');
  A.TemcMunDest := Assigned(LNode);
  if A.TemcMunDest then
    A.cMunDest := ObterConteudo(LNode, tcStr);

  LNode := ANode.Childrens.FindAnyNs('destExterior');
  A.TemdestExterior := Assigned(LNode);
  if A.TemdestExterior then
    Ler_destExterior(LNode, A.destExterior);
end;

procedure TDeREServRemPrecoXmlReader.Ler_destExterior(const ANode: TACBrXmlNode; A: TdestExteriorD2201);
var
  LNode: TACBrXmlNode;
begin
  if not Assigned(ANode) then Exit;

  LNode := ANode.Childrens.FindAnyNs('NIFDest');
  A.TemNIFDest := Assigned(LNode);
  if A.TemNIFDest then
    A.NIFDest := ObterConteudo(LNode, tcStr);
  LNode := ANode.Childrens.FindAnyNs('cNaoNIFDest');
  A.TemcNaoNIFDest := Assigned(LNode);
  if A.TemcNaoNIFDest then
    A.cNaoNIFDest := StrTocNaoNIFDeRE(ObterConteudo(LNode, tcStr));
  LNode := ANode.Childrens.FindAnyNs('nrDocIdentDest');
  A.TemnrDocIdentDest := Assigned(LNode);
  if A.TemnrDocIdentDest then
    A.nrDocIdentDest := ObterConteudo(LNode, tcStr);
  A.cPaisDest := ObterConteudo(ANode.Childrens.FindAnyNs('cPaisDest'), tcStr);
end;

procedure TDeREServRemPrecoXmlReader.Ler_gBC(const ANode: TACBrXmlNode; A: TgBCD2201);
begin
  if not Assigned(ANode) then Exit;

  A.vBCApur := ObterConteudo(ANode.Childrens.FindAnyNs('vBCApur'), tcDe2);
end;

procedure TDeREServRemPrecoXmlReader.Ler_gTributos(const ANode: TACBrXmlNode; A: TgTributosD2201);
begin
  if not Assigned(ANode) then Exit;

  A.vBCTrib := ObterConteudo(ANode.Childrens.FindAnyNs('vBCTrib'), tcDe2);
  A.pIBSMunTrib := ObterConteudo(ANode.Childrens.FindAnyNs('pIBSMunTrib'), tcDe6);
  A.vIBSMunTrib := ObterConteudo(ANode.Childrens.FindAnyNs('vIBSMunTrib'), tcDe2);
  A.pIBSUFTrib := ObterConteudo(ANode.Childrens.FindAnyNs('pIBSUFTrib'), tcDe6);
  A.vIBSUFTrib := ObterConteudo(ANode.Childrens.FindAnyNs('vIBSUFTrib'), tcDe2);
  A.pCBSTrib := ObterConteudo(ANode.Childrens.FindAnyNs('pCBSTrib'), tcDe6);
  A.vCBSTrib := ObterConteudo(ANode.Childrens.FindAnyNs('vCBSTrib'), tcDe2);
end;

initialization
  RegistrarReaderDeRE(teServRemPreco, TDeREServRemPrecoXmlReader);

end.
