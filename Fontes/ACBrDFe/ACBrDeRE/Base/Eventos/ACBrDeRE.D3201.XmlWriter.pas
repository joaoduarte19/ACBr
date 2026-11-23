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

unit ACBrDeRE.D3201.XmlWriter;

interface

uses
  Classes, SysUtils,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrDFe.RTC.XmlWriter,
  ACBrXmlDocument,
  ACBrXmlWriter,
  ACBrDeRE.Classes,
  ACBrDeRE.D3201.Classes,
  ACBrDeRE.Conversao,
  ACBrDeRE.XmlWriter;

type
  { TDeREPlAssistSaudeXmlWriter - gera o evento evtPlAssistSaude (D-3201) }

  TDeREPlAssistSaudeXmlWriter = class(TDeREXmlWriter)
  private
    function Evt: TevtPlAssistSaude;

    function Gerar_adqExterior(A: TadqExteriorD3201): TACBrXmlNode;
    function Gerar_infoAdq(A: TinfoAdqD3201): TACBrXmlNode;
    function Gerar_idePartes(A: TidePartesD3201): TACBrXmlNode;
    function Gerar_qualifOper(A: TqualifOperD3201): TACBrXmlNode;
    function Gerar_gVOper(A: TgVOperD3201): TACBrXmlNode;
    function Gerar_detBC(A: TdetBCD3201): TACBrXmlNode;
    function Gerar_detDependentes(A: TdetDependentesD3201): TACBrXmlNode;
    function Gerar_detBenef(A: TdetBenefCollectionItemD3201): TACBrXmlNode;
    function Gerar_gIdBenef(A: TgIdBenefD3201): TACBrXmlNode;
    function Gerar_gBC(A: TgBCD3201): TACBrXmlNode;
    function Gerar_gTributos(A: TgTributosD3201): TACBrXmlNode;
    function Gerar_detOper(A: TdetOperCollectionItemD3201): TACBrXmlNode;
    function Gerar_dadosOper(A: TdadosOperD3201): TACBrXmlNode;
    function Gerar_gOper(A: TgOperD3201): TACBrXmlNode;
    function Gerar_infoOper(A: TinfoOperD3201): TACBrXmlNode;
  protected
    function GetNameSpace: string; override;
    function Gerar_Evento: TACBrXmlNode; override;
  end;

implementation

uses
  StrUtils,
  ACBrUtil.Base,
  ACBrUtil.Strings,
  ACBrUtil.XMLHTML,
  ACBrUtil.DateTime,
  ACBrDeRE.Consts;

{ TDeREPlAssistSaudeXmlWriter }

function TDeREPlAssistSaudeXmlWriter.Evt: TevtPlAssistSaude;
begin
  Result := (DeRE as TDeRED3201).evtPlAssistSaude;
end;

function TDeREPlAssistSaudeXmlWriter.GetNameSpace: string;
begin
  Result := NamespaceDeRE(schevtPlAssistSaude, VersaoDF);
end;

function TDeREPlAssistSaudeXmlWriter.Gerar_Evento: TACBrXmlNode;
begin
  Result := FDocument.CreateElement('evtPlAssistSaude');
  Result.SetAttribute('id', Evt.id);

  Result.AppendChild(Gerar_ideEventoFin(Evt.ideEvento));
  Result.AppendChild(Gerar_ideContrib(Evt.ideContrib));
  Result.AppendChild(Gerar_idePeriodoApurSub(Evt.idePeriodo));
  Result.AppendChild(Gerar_infoOper(Evt.infoOper));
end;

function TDeREPlAssistSaudeXmlWriter.Gerar_adqExterior(A: TadqExteriorD3201): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('adqExterior');

  if A.TemNIF then
    Result.AppendChild(AddNode(tcStr, '#10', 'NIF', 1, 20, 1,
      A.NIF, DSC_NIF));

  if A.TemcNaoNIF then
    Result.AppendChild(AddNode(tcStr, '#11', 'cNaoNIF', 1, 1, 1,
      cNaoNIFDeREToStr(A.cNaoNIF), DSC_CNAONIF));

  if A.TemnrDocIdent then
    Result.AppendChild(AddNode(tcStr, '#12', 'nrDocIdent', 1, 20, 1,
      A.nrDocIdent, DSC_NRDOCIDENT));

  Result.AppendChild(AddNode(tcStr, '#13', 'cPais', 2, 2, 1,
    A.cPais, DSC_CPAIS));
end;

function TDeREPlAssistSaudeXmlWriter.Gerar_infoAdq(A: TinfoAdqD3201): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('infoAdq');

  if A.TemCPF then
    Result.AppendChild(AddNode(tcStr, '#14', 'CPF', 11, 11, 1,
      A.CPF, DSC_CPF));

  if A.TemCNPJ then
    Result.AppendChild(AddNode(tcStr, '#15', 'CNPJ', 14, 14, 1,
      A.CNPJ, DSC_CNPJ));

  if A.TemcMun then
    Result.AppendChild(AddNode(tcStr, '#16', 'cMun', 7, 7, 1,
      A.cMun, DSC_CMUN));

  if A.TemadqExterior then
    Result.AppendChild(Gerar_adqExterior(A.adqExterior));
end;

function TDeREPlAssistSaudeXmlWriter.Gerar_idePartes(A: TidePartesD3201): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('idePartes');

  Result.AppendChild(Gerar_infoAdq(A.infoAdq));
end;

function TDeREPlAssistSaudeXmlWriter.Gerar_qualifOper(A: TqualifOperD3201): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('qualifOper');

  Result.AppendChild(AddNode(tcStr, '#17', 'idContrato', 1, 30, 1,
    A.idContrato, DSC_IDCONTRATO));

  Result.AppendChild(AddNode(tcStr, '#18', 'tpContrato', 1, 1, 1,
    tpContratoD3201ToStr(A.tpContrato), DSC_TPCONTRATO));

  if A.TemCNPJEntidRelac then
    Result.AppendChild(AddNode(tcStr, '#19', 'CNPJEntidRelac', 14, 14, 1,
      A.CNPJEntidRelac, DSC_CNPJENTIDRELAC));
end;

function TDeREPlAssistSaudeXmlWriter.Gerar_gVOper(A: TgVOperD3201): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('gVOper');

  Result.AppendChild(AddNode(tcDe2, '#20', 'vOper', 1, 18, 1,
    A.vOper, DSC_VOPER));
end;

function TDeREPlAssistSaudeXmlWriter.Gerar_detBC(A: TdetBCD3201): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('detBC');

  Result.AppendChild(AddNode(tcDe2, '#21', 'vBCApur', 1, 18, 1,
    A.vBCApur, DSC_VBCAPUR));
end;

function TDeREPlAssistSaudeXmlWriter.Gerar_detDependentes(A: TdetDependentesD3201): TACBrXmlNode;
var
  i: Integer;
begin
  Result := FDocument.CreateElement('detDependentes');

  for i := 0 to A.dtNascDep.Count - 1 do
    Result.AppendChild(AddNode(tcDat, '#22', 'dtNascDep', 10, 10, 1,
        A.dtNascDep[i], DSC_DTNASCDEP));
end;

function TDeREPlAssistSaudeXmlWriter.Gerar_detBenef(A: TdetBenefCollectionItemD3201): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('detBenef');

  if A.TemCPFTitular then
    Result.AppendChild(AddNode(tcStr, '#23', 'CPFTitular', 11, 11, 1,
      A.CPFTitular, DSC_CPFTITULAR));

  if A.TemdtNascTitular then
    Result.AppendChild(AddNode(tcDat, '#24', 'dtNascTitular', 10, 10, 1,
      A.dtNascTitular, DSC_DTNASCTITULAR));

  if A.TemvTitularDep then
    Result.AppendChild(AddNode(tcDe2, '#25', 'vTitularDep', 1, 18, 1,
      A.vTitularDep, DSC_VTITULARDEP));

  if A.TemdetDependentes then
    Result.AppendChild(Gerar_detDependentes(A.detDependentes));
end;

function TDeREPlAssistSaudeXmlWriter.Gerar_gIdBenef(A: TgIdBenefD3201): TACBrXmlNode;
var
  i: Integer;
begin
  Result := FDocument.CreateElement('gIdBenef');

  for i := 0 to A.detBenef.Count - 1 do
    Result.AppendChild(Gerar_detBenef(A.detBenef[i]));
end;

function TDeREPlAssistSaudeXmlWriter.Gerar_gBC(A: TgBCD3201): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('gBC');

  Result.AppendChild(Gerar_gVOper(A.gVOper));

  if A.TemdetBC then
    Result.AppendChild(Gerar_detBC(A.detBC));

  if A.TemgIdBenef then
    Result.AppendChild(Gerar_gIdBenef(A.gIdBenef));
end;

function TDeREPlAssistSaudeXmlWriter.Gerar_gTributos(A: TgTributosD3201): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('gTributos');

  Result.AppendChild(AddNode(tcDe2, '#26', 'vBCTrib', 1, 18, 1,
    A.vBCTrib, DSC_VBCTRIB));

  Result.AppendChild(AddNode(tcDe6, '#27', 'pIBSMunTrib', 1, 10, 1,
    A.pIBSMunTrib, DSC_PIBSMUNTRIB));

  Result.AppendChild(AddNode(tcDe2, '#28', 'vIBSMunTrib', 1, 18, 1,
    A.vIBSMunTrib, DSC_VIBSMUNTRIB));

  Result.AppendChild(AddNode(tcDe6, '#29', 'pIBSUFTrib', 1, 10, 1,
    A.pIBSUFTrib, DSC_PIBSUFTRIB));

  Result.AppendChild(AddNode(tcDe2, '#30', 'vIBSUFTrib', 1, 18, 1,
    A.vIBSUFTrib, DSC_VIBSUFTRIB));

  Result.AppendChild(AddNode(tcDe6, '#31', 'pCBSTrib', 1, 10, 1,
    A.pCBSTrib, DSC_PCBSTRIB));

  Result.AppendChild(AddNode(tcDe2, '#32', 'vCBSTrib', 1, 18, 1,
    A.vCBSTrib, DSC_VCBSTRIB));
end;

function TDeREPlAssistSaudeXmlWriter.Gerar_detOper(A: TdetOperCollectionItemD3201): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('detOper');

  Result.SetAttribute('seq', A.seq);

  if A.TemseqRef then
    Result.AppendChild(AddNode(tcStr, '#33', 'seqRef', 3, 3, 1,
      A.seqRef, DSC_SEQREF));

  Result.AppendChild(AddNode(tcStr, '#34', 'dhOper', 29, 29, 1,
    FormatarDhDeRE(A.dhOper), DSC_DHOPER));

  Result.AppendChild(Gerar_qualifOper(A.qualifOper));

  Result.AppendChild(Gerar_gBC(A.gBC));

  if A.TemgTributos then
    Result.AppendChild(Gerar_gTributos(A.gTributos));
end;

function TDeREPlAssistSaudeXmlWriter.Gerar_dadosOper(A: TdadosOperD3201): TACBrXmlNode;
var
  i: Integer;
begin
  Result := FDocument.CreateElement('dadosOper');

  for i := 0 to A.detOper.Count - 1 do
    Result.AppendChild(Gerar_detOper(A.detOper[i]));
end;

function TDeREPlAssistSaudeXmlWriter.Gerar_gOper(A: TgOperD3201): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('gOper');

  Result.AppendChild(AddNode(tcStr, '#35', 'chAgrup', 50, 50, 1,
    A.chAgrup, DSC_CHAGRUP));

  Result.AppendChild(AddNode(tcStr, '#36', 'codBC', 4, 4, 1,
    A.codBC, DSC_CODBC));

  if A.TemchAgrupRef then
    Result.AppendChild(AddNode(tcStr, '#37', 'chAgrupRef', 50, 50, 1,
      A.chAgrupRef, DSC_CHAGRUPREF));

  Result.AppendChild(Gerar_idePartes(A.idePartes));

  Result.AppendChild(Gerar_dadosOper(A.dadosOper));
end;

function TDeREPlAssistSaudeXmlWriter.Gerar_infoOper(A: TinfoOperD3201): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('infoOper');

  Result.AppendChild(Gerar_gOper(A.gOper));
end;

initialization
  RegistrarWriterDeRE(tePlAssistSaude, TDeREPlAssistSaudeXmlWriter);

end.
