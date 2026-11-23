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

unit ACBrDeRE.D2251.XmlReader;

interface

uses
  Classes, SysUtils,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrXmlDocument,
  ACBrDeRE.Classes,
  ACBrDeRE.D2251.Classes,
  ACBrDeRE.Conversao,
  ACBrDeRE.XmlReader;

type
  { TDeRESegPrevCapXmlReader - le o XML do evento evtSegPrevCap (D-2251) }

  TDeRESegPrevCapXmlReader = class(TDeREEventoXmlReader)
  private
    function Evt: TevtSegPrevCap;

    procedure Ler_infoOper(const ANode: TACBrXmlNode; A: TinfoOperD2251);
    procedure Ler_gOper(const ANode: TACBrXmlNode; A: TgOperD2251);
    procedure Ler_idePartes(const ANode: TACBrXmlNode; A: TidePartesD2251);
    procedure Ler_infoAdq(const ANode: TACBrXmlNode; A: TinfoAdqD2251);
    procedure Ler_adqExterior(const ANode: TACBrXmlNode; A: TadqExteriorD2251);
    procedure Ler_infoPDV(const ANode: TACBrXmlNode; A: TinfoPDVD2251);
    procedure Ler_dadosOper(const ANode: TACBrXmlNode; A: TdadosOperD2251);
    procedure Ler_detOper(const ANode: TACBrXmlNode; A: TdetOperCollectionItemD2251);
    procedure Ler_gSemCobert(const ANode: TACBrXmlNode; A: TgSemCobertD2251);
    procedure Ler_gComCobertPrev(const ANode: TACBrXmlNode; A: TgComCobertPrevD2251);
    procedure Ler_gIdSegurados(const ANode: TACBrXmlNode; A: TgIdSeguradosD2251);
    procedure Ler_detSegurado(const ANode: TACBrXmlNode; A: TdetSeguradoCollectionItemD2251);
    procedure Ler_segExterior(const ANode: TACBrXmlNode; A: TsegExteriorD2251);
    procedure Ler_gCapitalizacao(const ANode: TACBrXmlNode; A: TgCapitalizacaoD2251);
  protected
    function GetNomeEvento: string; override;
    procedure Ler_Evento(const ANode: TACBrXmlNode); override;
  end;

implementation

uses
  ACBrUtil.Strings;

{ TDeRESegPrevCapXmlReader }

function TDeRESegPrevCapXmlReader.Evt: TevtSegPrevCap;
begin
  Result := (DeRE as TDeRED2251).evtSegPrevCap;
end;

function TDeRESegPrevCapXmlReader.GetNomeEvento: string;
begin
  Result := 'evtSegPrevCap';
end;

procedure TDeRESegPrevCapXmlReader.Ler_Evento(const ANode: TACBrXmlNode);
begin
  Ler_ideEventoFin(ANode.Childrens.FindAnyNs('ideEvento'), Evt.ideEvento);
  Ler_ideContrib(ANode.Childrens.FindAnyNs('ideContrib'), Evt.ideContrib);
  Ler_idePeriodoApurSub(ANode.Childrens.FindAnyNs('idePeriodo'), Evt.idePeriodo);

  Ler_infoOper(ANode.Childrens.FindAnyNs('infoOper'), Evt.infoOper);
end;

procedure TDeRESegPrevCapXmlReader.Ler_infoOper(const ANode: TACBrXmlNode; A: TinfoOperD2251);
begin
  if not Assigned(ANode) then Exit;

  Ler_gOper(ANode.Childrens.FindAnyNs('gOper'), A.gOper);
end;

procedure TDeRESegPrevCapXmlReader.Ler_gOper(const ANode: TACBrXmlNode; A: TgOperD2251);
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

procedure TDeRESegPrevCapXmlReader.Ler_idePartes(const ANode: TACBrXmlNode; A: TidePartesD2251);
var
  LNode: TACBrXmlNode;
begin
  if not Assigned(ANode) then Exit;

  LNode := ANode.Childrens.FindAnyNs('indIdentifAdq');
  A.TemindIdentifAdq := Assigned(LNode);
  if A.TemindIdentifAdq then
    A.indIdentifAdq := (ObterConteudo(LNode, tcStr) = '1');

  LNode := ANode.Childrens.FindAnyNs('infoAdq');
  A.TeminfoAdq := Assigned(LNode);
  if A.TeminfoAdq then
    Ler_infoAdq(LNode, A.infoAdq);
  LNode := ANode.Childrens.FindAnyNs('infoPDV');
  A.TeminfoPDV := Assigned(LNode);
  if A.TeminfoPDV then
    Ler_infoPDV(LNode, A.infoPDV);
end;

procedure TDeRESegPrevCapXmlReader.Ler_infoAdq(const ANode: TACBrXmlNode; A: TinfoAdqD2251);
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

procedure TDeRESegPrevCapXmlReader.Ler_adqExterior(const ANode: TACBrXmlNode; A: TadqExteriorD2251);
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

procedure TDeRESegPrevCapXmlReader.Ler_infoPDV(const ANode: TACBrXmlNode; A: TinfoPDVD2251);
var
  LNode: TACBrXmlNode;
begin
  if not Assigned(ANode) then Exit;

  LNode := ANode.Childrens.FindAnyNs('CPFPDV');
  A.TemCPFPDV := Assigned(LNode);
  if A.TemCPFPDV then
    A.CPFPDV := ObterConteudo(LNode, tcStr);
  LNode := ANode.Childrens.FindAnyNs('CNPJPDV');
  A.TemCNPJPDV := Assigned(LNode);
  if A.TemCNPJPDV then
    A.CNPJPDV := ObterConteudo(LNode, tcStr);
end;

procedure TDeRESegPrevCapXmlReader.Ler_dadosOper(const ANode: TACBrXmlNode; A: TdadosOperD2251);
var
  LNodes: TACBrXmlNodeArray;
  i: Integer;
begin
  if not Assigned(ANode) then Exit;

  LNodes := ANode.Childrens.FindAllAnyNs('detOper');
  for i := 0 to Length(LNodes) - 1 do
    Ler_detOper(LNodes[i], A.detOper.New);
end;

procedure TDeRESegPrevCapXmlReader.Ler_detOper(const ANode: TACBrXmlNode; A: TdetOperCollectionItemD2251);
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

  LNode := ANode.Childrens.FindAnyNs('gSemCobert');
  A.TemgSemCobert := Assigned(LNode);
  if A.TemgSemCobert then
    Ler_gSemCobert(LNode, A.gSemCobert);
  LNode := ANode.Childrens.FindAnyNs('gComCobertPrev');
  A.TemgComCobertPrev := Assigned(LNode);
  if A.TemgComCobertPrev then
    Ler_gComCobertPrev(LNode, A.gComCobertPrev);
  LNode := ANode.Childrens.FindAnyNs('gCapitalizacao');
  A.TemgCapitalizacao := Assigned(LNode);
  if A.TemgCapitalizacao then
    Ler_gCapitalizacao(LNode, A.gCapitalizacao);
end;

procedure TDeRESegPrevCapXmlReader.Ler_gSemCobert(const ANode: TACBrXmlNode; A: TgSemCobertD2251);
begin
  if not Assigned(ANode) then Exit;

  A.vBCDistr := ObterConteudo(ANode.Childrens.FindAnyNs('vBCDistr'), tcDe2);
end;

procedure TDeRESegPrevCapXmlReader.Ler_gComCobertPrev(const ANode: TACBrXmlNode; A: TgComCobertPrevD2251);
var
  LNode: TACBrXmlNode;
begin
  if not Assigned(ANode) then Exit;

  A.tpContrato := StrTotpContratoDeRE(ObterConteudo(ANode.Childrens.FindAnyNs('tpContrato'), tcStr));
  A.vBCDistr := ObterConteudo(ANode.Childrens.FindAnyNs('vBCDistr'), tcDe2);

  LNode := ANode.Childrens.FindAnyNs('gIdSegurados');
  A.TemgIdSegurados := Assigned(LNode);
  if A.TemgIdSegurados then
    Ler_gIdSegurados(LNode, A.gIdSegurados);
end;

procedure TDeRESegPrevCapXmlReader.Ler_gIdSegurados(const ANode: TACBrXmlNode; A: TgIdSeguradosD2251);
var
  LNodes: TACBrXmlNodeArray;
  i: Integer;
begin
  if not Assigned(ANode) then Exit;

  LNodes := ANode.Childrens.FindAllAnyNs('detSegurado');
  for i := 0 to Length(LNodes) - 1 do
    Ler_detSegurado(LNodes[i], A.detSegurado.New);
end;

procedure TDeRESegPrevCapXmlReader.Ler_detSegurado(const ANode: TACBrXmlNode; A: TdetSeguradoCollectionItemD2251);
var
  LNode: TACBrXmlNode;
begin
  if not Assigned(ANode) then Exit;

  A.vBCDistrSeg := ObterConteudo(ANode.Childrens.FindAnyNs('vBCDistrSeg'), tcDe2);
  LNode := ANode.Childrens.FindAnyNs('CPFSeg');
  A.TemCPFSeg := Assigned(LNode);
  if A.TemCPFSeg then
    A.CPFSeg := ObterConteudo(LNode, tcStr);
  LNode := ANode.Childrens.FindAnyNs('CNPJSeg');
  A.TemCNPJSeg := Assigned(LNode);
  if A.TemCNPJSeg then
    A.CNPJSeg := ObterConteudo(LNode, tcStr);
  LNode := ANode.Childrens.FindAnyNs('cMunSeg');
  A.TemcMunSeg := Assigned(LNode);
  if A.TemcMunSeg then
    A.cMunSeg := ObterConteudo(LNode, tcStr);

  LNode := ANode.Childrens.FindAnyNs('segExterior');
  A.TemsegExterior := Assigned(LNode);
  if A.TemsegExterior then
    Ler_segExterior(LNode, A.segExterior);
end;

procedure TDeRESegPrevCapXmlReader.Ler_segExterior(const ANode: TACBrXmlNode; A: TsegExteriorD2251);
var
  LNode: TACBrXmlNode;
begin
  if not Assigned(ANode) then Exit;

  LNode := ANode.Childrens.FindAnyNs('NIFSeg');
  A.TemNIFSeg := Assigned(LNode);
  if A.TemNIFSeg then
    A.NIFSeg := ObterConteudo(LNode, tcStr);
  LNode := ANode.Childrens.FindAnyNs('cNaoNIFSeg');
  A.TemcNaoNIFSeg := Assigned(LNode);
  if A.TemcNaoNIFSeg then
    A.cNaoNIFSeg := StrTocNaoNIFDeRE(ObterConteudo(LNode, tcStr));
  LNode := ANode.Childrens.FindAnyNs('nrDocIdentSeg');
  A.TemnrDocIdentSeg := Assigned(LNode);
  if A.TemnrDocIdentSeg then
    A.nrDocIdentSeg := ObterConteudo(LNode, tcStr);
  A.cPaisSeg := ObterConteudo(ANode.Childrens.FindAnyNs('cPaisSeg'), tcStr);
end;

procedure TDeRESegPrevCapXmlReader.Ler_gCapitalizacao(const ANode: TACBrXmlNode; A: TgCapitalizacaoD2251);
var
  LNode: TACBrXmlNode;
begin
  if not Assigned(ANode) then Exit;

  A.vBCDistr := ObterConteudo(ANode.Childrens.FindAnyNs('vBCDistr'), tcDe2);
  LNode := ANode.Childrens.FindAnyNs('cMunOper');
  A.TemcMunOper := Assigned(LNode);
  if A.TemcMunOper then
    A.cMunOper := ObterConteudo(LNode, tcStr);
end;

initialization
  RegistrarReaderDeRE(teSegPrevCap, TDeRESegPrevCapXmlReader);

end.
