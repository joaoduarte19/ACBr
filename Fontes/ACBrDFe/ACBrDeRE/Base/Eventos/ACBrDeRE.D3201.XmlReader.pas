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

unit ACBrDeRE.D3201.XmlReader;

interface

uses
  Classes, SysUtils,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrXmlDocument,
  ACBrDeRE.Classes,
  ACBrDeRE.D3201.Classes,
  ACBrDeRE.Conversao,
  ACBrDeRE.XmlReader;

type
  { TDeREPlAssistSaudeXmlReader - le o XML do evento evtPlAssistSaude (D-3201) }

  TDeREPlAssistSaudeXmlReader = class(TDeREEventoXmlReader)
  private
    function Evt: TevtPlAssistSaude;

    procedure Ler_infoOper(const ANode: TACBrXmlNode; A: TinfoOperD3201);
    procedure Ler_gOper(const ANode: TACBrXmlNode; A: TgOperD3201);
    procedure Ler_idePartes(const ANode: TACBrXmlNode; A: TidePartesD3201);
    procedure Ler_infoAdq(const ANode: TACBrXmlNode; A: TinfoAdqD3201);
    procedure Ler_adqExterior(const ANode: TACBrXmlNode; A: TadqExteriorD3201);
    procedure Ler_dadosOper(const ANode: TACBrXmlNode; A: TdadosOperD3201);
    procedure Ler_detOper(const ANode: TACBrXmlNode; A: TdetOperCollectionItemD3201);
    procedure Ler_qualifOper(const ANode: TACBrXmlNode; A: TqualifOperD3201);
    procedure Ler_gBC(const ANode: TACBrXmlNode; A: TgBCD3201);
    procedure Ler_gVOper(const ANode: TACBrXmlNode; A: TgVOperD3201);
    procedure Ler_detBC(const ANode: TACBrXmlNode; A: TdetBCD3201);
    procedure Ler_gIdBenef(const ANode: TACBrXmlNode; A: TgIdBenefD3201);
    procedure Ler_detBenef(const ANode: TACBrXmlNode; A: TdetBenefCollectionItemD3201);
    procedure Ler_detDependentes(const ANode: TACBrXmlNode; A: TdetDependentesD3201);
    procedure Ler_gTributos(const ANode: TACBrXmlNode; A: TgTributosD3201);
  protected
    function GetNomeEvento: string; override;
    procedure Ler_Evento(const ANode: TACBrXmlNode); override;
  end;

implementation

uses
  ACBrUtil.Strings;

{ TDeREPlAssistSaudeXmlReader }

function TDeREPlAssistSaudeXmlReader.Evt: TevtPlAssistSaude;
begin
  Result := (DeRE as TDeRED3201).evtPlAssistSaude;
end;

function TDeREPlAssistSaudeXmlReader.GetNomeEvento: string;
begin
  Result := 'evtPlAssistSaude';
end;

procedure TDeREPlAssistSaudeXmlReader.Ler_Evento(const ANode: TACBrXmlNode);
begin
  Ler_ideEventoFin(ANode.Childrens.FindAnyNs('ideEvento'), Evt.ideEvento);
  Ler_ideContrib(ANode.Childrens.FindAnyNs('ideContrib'), Evt.ideContrib);
  Ler_idePeriodoApurSub(ANode.Childrens.FindAnyNs('idePeriodo'), Evt.idePeriodo);

  Ler_infoOper(ANode.Childrens.FindAnyNs('infoOper'), Evt.infoOper);
end;

procedure TDeREPlAssistSaudeXmlReader.Ler_infoOper(const ANode: TACBrXmlNode; A: TinfoOperD3201);
begin
  if not Assigned(ANode) then Exit;

  Ler_gOper(ANode.Childrens.FindAnyNs('gOper'), A.gOper);
end;

procedure TDeREPlAssistSaudeXmlReader.Ler_gOper(const ANode: TACBrXmlNode; A: TgOperD3201);
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

procedure TDeREPlAssistSaudeXmlReader.Ler_idePartes(const ANode: TACBrXmlNode; A: TidePartesD3201);
begin
  if not Assigned(ANode) then Exit;

  Ler_infoAdq(ANode.Childrens.FindAnyNs('infoAdq'), A.infoAdq);
end;

procedure TDeREPlAssistSaudeXmlReader.Ler_infoAdq(const ANode: TACBrXmlNode; A: TinfoAdqD3201);
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

procedure TDeREPlAssistSaudeXmlReader.Ler_adqExterior(const ANode: TACBrXmlNode; A: TadqExteriorD3201);
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

procedure TDeREPlAssistSaudeXmlReader.Ler_dadosOper(const ANode: TACBrXmlNode; A: TdadosOperD3201);
var
  LNodes: TACBrXmlNodeArray;
  i: Integer;
begin
  if not Assigned(ANode) then Exit;

  LNodes := ANode.Childrens.FindAllAnyNs('detOper');
  for i := 0 to Length(LNodes) - 1 do
    Ler_detOper(LNodes[i], A.detOper.New);
end;

procedure TDeREPlAssistSaudeXmlReader.Ler_detOper(const ANode: TACBrXmlNode; A: TdetOperCollectionItemD3201);
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

  Ler_qualifOper(ANode.Childrens.FindAnyNs('qualifOper'), A.qualifOper);
  Ler_gBC(ANode.Childrens.FindAnyNs('gBC'), A.gBC);
  LNode := ANode.Childrens.FindAnyNs('gTributos');
  A.TemgTributos := Assigned(LNode);
  if A.TemgTributos then
    Ler_gTributos(LNode, A.gTributos);
end;

procedure TDeREPlAssistSaudeXmlReader.Ler_qualifOper(const ANode: TACBrXmlNode; A: TqualifOperD3201);
var
  LNode: TACBrXmlNode;
begin
  if not Assigned(ANode) then Exit;

  A.idContrato := ObterConteudo(ANode.Childrens.FindAnyNs('idContrato'), tcStr);
  A.tpContrato := StrTotpContratoD3201(ObterConteudo(ANode.Childrens.FindAnyNs('tpContrato'), tcStr));
  LNode := ANode.Childrens.FindAnyNs('CNPJEntidRelac');
  A.TemCNPJEntidRelac := Assigned(LNode);
  if A.TemCNPJEntidRelac then
    A.CNPJEntidRelac := ObterConteudo(LNode, tcStr);
end;

procedure TDeREPlAssistSaudeXmlReader.Ler_gBC(const ANode: TACBrXmlNode; A: TgBCD3201);
var
  LNode: TACBrXmlNode;
begin
  if not Assigned(ANode) then Exit;

  Ler_gVOper(ANode.Childrens.FindAnyNs('gVOper'), A.gVOper);
  LNode := ANode.Childrens.FindAnyNs('detBC');
  A.TemdetBC := Assigned(LNode);
  if A.TemdetBC then
    Ler_detBC(LNode, A.detBC);
  LNode := ANode.Childrens.FindAnyNs('gIdBenef');
  A.TemgIdBenef := Assigned(LNode);
  if A.TemgIdBenef then
    Ler_gIdBenef(LNode, A.gIdBenef);
end;

procedure TDeREPlAssistSaudeXmlReader.Ler_gVOper(const ANode: TACBrXmlNode; A: TgVOperD3201);
begin
  if not Assigned(ANode) then Exit;

  A.vOper := ObterConteudo(ANode.Childrens.FindAnyNs('vOper'), tcDe2);
end;

procedure TDeREPlAssistSaudeXmlReader.Ler_detBC(const ANode: TACBrXmlNode; A: TdetBCD3201);
begin
  if not Assigned(ANode) then Exit;

  A.vBCApur := ObterConteudo(ANode.Childrens.FindAnyNs('vBCApur'), tcDe2);
end;

procedure TDeREPlAssistSaudeXmlReader.Ler_gIdBenef(const ANode: TACBrXmlNode; A: TgIdBenefD3201);
var
  LNodes: TACBrXmlNodeArray;
  i: Integer;
begin
  if not Assigned(ANode) then Exit;

  LNodes := ANode.Childrens.FindAllAnyNs('detBenef');
  for i := 0 to Length(LNodes) - 1 do
    Ler_detBenef(LNodes[i], A.detBenef.New);
end;

procedure TDeREPlAssistSaudeXmlReader.Ler_detBenef(const ANode: TACBrXmlNode; A: TdetBenefCollectionItemD3201);
var
  LNode: TACBrXmlNode;
begin
  if not Assigned(ANode) then Exit;

  LNode := ANode.Childrens.FindAnyNs('CPFTitular');
  A.TemCPFTitular := Assigned(LNode);
  if A.TemCPFTitular then
    A.CPFTitular := ObterConteudo(LNode, tcStr);
  LNode := ANode.Childrens.FindAnyNs('dtNascTitular');
  A.TemdtNascTitular := Assigned(LNode);
  if A.TemdtNascTitular then
    A.dtNascTitular := ObterConteudo(LNode, tcDat);
  LNode := ANode.Childrens.FindAnyNs('vTitularDep');
  A.TemvTitularDep := Assigned(LNode);
  if A.TemvTitularDep then
    A.vTitularDep := ObterConteudo(LNode, tcDe2);

  LNode := ANode.Childrens.FindAnyNs('detDependentes');
  A.TemdetDependentes := Assigned(LNode);
  if A.TemdetDependentes then
    Ler_detDependentes(LNode, A.detDependentes);
end;

procedure TDeREPlAssistSaudeXmlReader.Ler_detDependentes(const ANode: TACBrXmlNode; A: TdetDependentesD3201);
var
  LNodes: TACBrXmlNodeArray;
  i: Integer;
begin
  if not Assigned(ANode) then Exit;

  LNodes := ANode.Childrens.FindAllAnyNs('dtNascDep');
  for i := 0 to Length(LNodes) - 1 do
    A.dtNascDep.Add(ObterConteudo(LNodes[i], tcDat));
end;

procedure TDeREPlAssistSaudeXmlReader.Ler_gTributos(const ANode: TACBrXmlNode; A: TgTributosD3201);
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
  RegistrarReaderDeRE(tePlAssistSaude, TDeREPlAssistSaudeXmlReader);

end.
