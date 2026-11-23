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

unit ACBrDeRE.D4201.XmlWriter;

interface

uses
  Classes, SysUtils,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrDFe.RTC.XmlWriter,
  ACBrXmlDocument,
  ACBrXmlWriter,
  ACBrDeRE.Classes,
  ACBrDeRE.D4201.Classes,
  ACBrDeRE.Conversao,
  ACBrDeRE.XmlWriter;

type
  { TDeREIdApostPremXmlWriter - gera o evento evtIdApostPrem (D-4201) }

  TDeREIdApostPremXmlWriter = class(TDeREXmlWriter)
  private
    function Evt: TevtIdApostPrem;

    function Gerar_adqExterior(A: TadqExteriorD4201): TACBrXmlNode;
    function Gerar_infoAdq(A: TinfoAdqD4201): TACBrXmlNode;
    function Gerar_infoPDV(A: TinfoPDVD4201): TACBrXmlNode;
    function Gerar_idePartes(A: TidePartesD4201): TACBrXmlNode;
    function Gerar_infoAposta(A: TinfoApostaD4201): TACBrXmlNode;
    function Gerar_detOper(A: TdetOperCollectionItemD4201): TACBrXmlNode;
    function Gerar_dadosOper(A: TdadosOperD4201): TACBrXmlNode;
    function Gerar_gOper(A: TgOperD4201): TACBrXmlNode;
    function Gerar_infoOper(A: TinfoOperD4201): TACBrXmlNode;
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

{ TDeREIdApostPremXmlWriter }

function TDeREIdApostPremXmlWriter.Evt: TevtIdApostPrem;
begin
  Result := (DeRE as TDeRED4201).evtIdApostPrem;
end;

function TDeREIdApostPremXmlWriter.GetNameSpace: string;
begin
  Result := NamespaceDeRE(schevtIdApostPrem, VersaoDF);
end;

function TDeREIdApostPremXmlWriter.Gerar_Evento: TACBrXmlNode;
begin
  Result := FDocument.CreateElement('evtIdApostPrem');
  Result.SetAttribute('id', Evt.id);

  Result.AppendChild(Gerar_ideEventoFin(Evt.ideEvento));
  Result.AppendChild(Gerar_ideContrib(Evt.ideContrib));
  Result.AppendChild(Gerar_idePeriodoApurSub(Evt.idePeriodo));
  Result.AppendChild(Gerar_infoOper(Evt.infoOper));
end;

function TDeREIdApostPremXmlWriter.Gerar_adqExterior(A: TadqExteriorD4201): TACBrXmlNode;
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

function TDeREIdApostPremXmlWriter.Gerar_infoAdq(A: TinfoAdqD4201): TACBrXmlNode;
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

function TDeREIdApostPremXmlWriter.Gerar_infoPDV(A: TinfoPDVD4201): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('infoPDV');

  if A.TemCPFPDV then
    Result.AppendChild(AddNode(tcStr, '#17', 'CPFPDV', 11, 11, 1,
      A.CPFPDV, DSC_CPFPDV));

  if A.TemCNPJPDV then
    Result.AppendChild(AddNode(tcStr, '#18', 'CNPJPDV', 14, 14, 1,
      A.CNPJPDV, DSC_CNPJPDV));
end;

function TDeREIdApostPremXmlWriter.Gerar_idePartes(A: TidePartesD4201): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('idePartes');

  Result.AppendChild(AddNode(tcStr, '#19', 'indApostaPresenc', 1, 1, 1,
    IntToStr(Ord(A.indApostaPresenc)), DSC_INDAPOSTAPRESENC));

  if A.TeminfoAdq then
    Result.AppendChild(Gerar_infoAdq(A.infoAdq));

  if A.TeminfoPDV then
    Result.AppendChild(Gerar_infoPDV(A.infoPDV));
end;

function TDeREIdApostPremXmlWriter.Gerar_infoAposta(A: TinfoApostaD4201): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('infoAposta');

  if A.TemcMunOper then
    Result.AppendChild(AddNode(tcStr, '#20', 'cMunOper', 7, 7, 1,
      A.cMunOper, DSC_CMUNOPER));

  Result.AppendChild(AddNode(tcDe2, '#21', 'vOper', 1, 18, 1,
    A.vOper, DSC_VOPER));
end;

function TDeREIdApostPremXmlWriter.Gerar_detOper(A: TdetOperCollectionItemD4201): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('detOper');

  Result.SetAttribute('seq', A.seq);

  if A.TemseqRef then
    Result.AppendChild(AddNode(tcStr, '#22', 'seqRef', 3, 3, 1,
      A.seqRef, DSC_SEQREF));

  Result.AppendChild(AddNode(tcStr, '#23', 'dhOper', 29, 29, 1,
    FormatarDhDeRE(A.dhOper), DSC_DHOPER));

  Result.AppendChild(Gerar_infoAposta(A.infoAposta));
end;

function TDeREIdApostPremXmlWriter.Gerar_dadosOper(A: TdadosOperD4201): TACBrXmlNode;
var
  i: Integer;
begin
  Result := FDocument.CreateElement('dadosOper');

  for i := 0 to A.detOper.Count - 1 do
    Result.AppendChild(Gerar_detOper(A.detOper[i]));
end;

function TDeREIdApostPremXmlWriter.Gerar_gOper(A: TgOperD4201): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('gOper');

  Result.AppendChild(AddNode(tcStr, '#24', 'chAgrup', 50, 50, 1,
    A.chAgrup, DSC_CHAGRUP));

  Result.AppendChild(AddNode(tcStr, '#25', 'codBC', 4, 4, 1,
    A.codBC, DSC_CODBC));

  if A.TemchAgrupRef then
    Result.AppendChild(AddNode(tcStr, '#26', 'chAgrupRef', 50, 50, 1,
      A.chAgrupRef, DSC_CHAGRUPREF));

  Result.AppendChild(Gerar_idePartes(A.idePartes));

  Result.AppendChild(Gerar_dadosOper(A.dadosOper));
end;

function TDeREIdApostPremXmlWriter.Gerar_infoOper(A: TinfoOperD4201): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('infoOper');

  Result.AppendChild(Gerar_gOper(A.gOper));
end;

initialization
  RegistrarWriterDeRE(teIdApostPrem, TDeREIdApostPremXmlWriter);

end.
