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

unit ACBrDeRE.D4201.XmlReader;

interface

uses
  Classes, SysUtils,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrXmlDocument,
  ACBrDeRE.Classes,
  ACBrDeRE.D4201.Classes,
  ACBrDeRE.Conversao,
  ACBrDeRE.XmlReader;

type
  { TDeREIdApostPremXmlReader - le o XML do evento evtIdApostPrem (D-4201) }

  TDeREIdApostPremXmlReader = class(TDeREEventoXmlReader)
  private
    function Evt: TevtIdApostPrem;

    procedure Ler_infoOper(const ANode: TACBrXmlNode; A: TinfoOperD4201);
    procedure Ler_gOper(const ANode: TACBrXmlNode; A: TgOperD4201);
    procedure Ler_idePartes(const ANode: TACBrXmlNode; A: TidePartesD4201);
    procedure Ler_infoAdq(const ANode: TACBrXmlNode; A: TinfoAdqD4201);
    procedure Ler_adqExterior(const ANode: TACBrXmlNode; A: TadqExteriorD4201);
    procedure Ler_infoPDV(const ANode: TACBrXmlNode; A: TinfoPDVD4201);
    procedure Ler_dadosOper(const ANode: TACBrXmlNode; A: TdadosOperD4201);
    procedure Ler_detOper(const ANode: TACBrXmlNode; A: TdetOperCollectionItemD4201);
    procedure Ler_infoAposta(const ANode: TACBrXmlNode; A: TinfoApostaD4201);
  protected
    function GetNomeEvento: string; override;
    procedure Ler_Evento(const ANode: TACBrXmlNode); override;
  end;

implementation

uses
  ACBrUtil.Strings;

{ TDeREIdApostPremXmlReader }

function TDeREIdApostPremXmlReader.Evt: TevtIdApostPrem;
begin
  Result := (DeRE as TDeRED4201).evtIdApostPrem;
end;

function TDeREIdApostPremXmlReader.GetNomeEvento: string;
begin
  Result := 'evtIdApostPrem';
end;

procedure TDeREIdApostPremXmlReader.Ler_Evento(const ANode: TACBrXmlNode);
begin
  Ler_ideEventoFin(ANode.Childrens.FindAnyNs('ideEvento'), Evt.ideEvento);
  Ler_ideContrib(ANode.Childrens.FindAnyNs('ideContrib'), Evt.ideContrib);
  Ler_idePeriodoApurSub(ANode.Childrens.FindAnyNs('idePeriodo'), Evt.idePeriodo);

  Ler_infoOper(ANode.Childrens.FindAnyNs('infoOper'), Evt.infoOper);
end;

procedure TDeREIdApostPremXmlReader.Ler_infoOper(const ANode: TACBrXmlNode; A: TinfoOperD4201);
begin
  if not Assigned(ANode) then Exit;

  Ler_gOper(ANode.Childrens.FindAnyNs('gOper'), A.gOper);
end;

procedure TDeREIdApostPremXmlReader.Ler_gOper(const ANode: TACBrXmlNode; A: TgOperD4201);
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

procedure TDeREIdApostPremXmlReader.Ler_idePartes(const ANode: TACBrXmlNode; A: TidePartesD4201);
var
  LNode: TACBrXmlNode;
begin
  if not Assigned(ANode) then Exit;

  A.indApostaPresenc := (ObterConteudo(ANode.Childrens.FindAnyNs('indApostaPresenc'), tcStr) = '1');

  LNode := ANode.Childrens.FindAnyNs('infoAdq');
  A.TeminfoAdq := Assigned(LNode);
  if A.TeminfoAdq then
    Ler_infoAdq(LNode, A.infoAdq);
  LNode := ANode.Childrens.FindAnyNs('infoPDV');
  A.TeminfoPDV := Assigned(LNode);
  if A.TeminfoPDV then
    Ler_infoPDV(LNode, A.infoPDV);
end;

procedure TDeREIdApostPremXmlReader.Ler_infoAdq(const ANode: TACBrXmlNode; A: TinfoAdqD4201);
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

procedure TDeREIdApostPremXmlReader.Ler_adqExterior(const ANode: TACBrXmlNode; A: TadqExteriorD4201);
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

procedure TDeREIdApostPremXmlReader.Ler_infoPDV(const ANode: TACBrXmlNode; A: TinfoPDVD4201);
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

procedure TDeREIdApostPremXmlReader.Ler_dadosOper(const ANode: TACBrXmlNode; A: TdadosOperD4201);
var
  LNodes: TACBrXmlNodeArray;
  i: Integer;
begin
  if not Assigned(ANode) then Exit;

  LNodes := ANode.Childrens.FindAllAnyNs('detOper');
  for i := 0 to Length(LNodes) - 1 do
    Ler_detOper(LNodes[i], A.detOper.New);
end;

procedure TDeREIdApostPremXmlReader.Ler_detOper(const ANode: TACBrXmlNode; A: TdetOperCollectionItemD4201);
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

  Ler_infoAposta(ANode.Childrens.FindAnyNs('infoAposta'), A.infoAposta);
end;

procedure TDeREIdApostPremXmlReader.Ler_infoAposta(const ANode: TACBrXmlNode; A: TinfoApostaD4201);
var
  LNode: TACBrXmlNode;
begin
  if not Assigned(ANode) then Exit;

  LNode := ANode.Childrens.FindAnyNs('cMunOper');
  A.TemcMunOper := Assigned(LNode);
  if A.TemcMunOper then
    A.cMunOper := ObterConteudo(LNode, tcStr);
  A.vOper := ObterConteudo(ANode.Childrens.FindAnyNs('vOper'), tcDe2);
end;

initialization
  RegistrarReaderDeRE(teIdApostPrem, TDeREIdApostPremXmlReader);

end.
