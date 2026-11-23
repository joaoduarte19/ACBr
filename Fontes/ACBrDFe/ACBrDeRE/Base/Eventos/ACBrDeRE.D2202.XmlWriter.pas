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

unit ACBrDeRE.D2202.XmlWriter;

interface

uses
  Classes, SysUtils,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrDFe.RTC.XmlWriter,
  ACBrXmlDocument,
  ACBrXmlWriter,
  ACBrDeRE.Classes,
  ACBrDeRE.D2202.Classes,
  ACBrDeRE.Conversao,
  ACBrDeRE.XmlWriter;

type
  { TDeREServRemTarifaXmlWriter - gera o evento evtServRemTarifa (D-2202) }

  TDeREServRemTarifaXmlWriter = class(TDeREXmlWriter)
  private
    function Evt: TevtServRemTarifa;

    function Gerar_adqExterior(A: TadqExteriorD2202): TACBrXmlNode;
    function Gerar_infoAdq(A: TinfoAdqD2202): TACBrXmlNode;
    function Gerar_idePartes(A: TidePartesD2202): TACBrXmlNode;
    function Gerar_qualifOper(A: TqualifOperD2202): TACBrXmlNode;
    function Gerar_gBC(A: TgBCD2202): TACBrXmlNode;
    function Gerar_gTributos(A: TgTributosD2202): TACBrXmlNode;
    function Gerar_detOper(A: TdetOperCollectionItemD2202): TACBrXmlNode;
    function Gerar_dadosOper(A: TdadosOperD2202): TACBrXmlNode;
    function Gerar_gOper(A: TgOperD2202): TACBrXmlNode;
    function Gerar_infoOper(A: TinfoOperD2202): TACBrXmlNode;
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

{ TDeREServRemTarifaXmlWriter }

function TDeREServRemTarifaXmlWriter.Evt: TevtServRemTarifa;
begin
  Result := (DeRE as TDeRED2202).evtServRemTarifa;
end;

function TDeREServRemTarifaXmlWriter.GetNameSpace: string;
begin
  Result := NamespaceDeRE(schevtServRemTarifa, VersaoDF);
end;

function TDeREServRemTarifaXmlWriter.Gerar_Evento: TACBrXmlNode;
begin
  Result := FDocument.CreateElement('evtServRemTarifa');
  Result.SetAttribute('id', Evt.id);

  Result.AppendChild(Gerar_ideEventoFin(Evt.ideEvento));
  Result.AppendChild(Gerar_ideContrib(Evt.ideContrib));
  Result.AppendChild(Gerar_idePeriodoApurSub(Evt.idePeriodo));
  Result.AppendChild(Gerar_infoOper(Evt.infoOper));
end;

function TDeREServRemTarifaXmlWriter.Gerar_adqExterior(A: TadqExteriorD2202): TACBrXmlNode;
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

function TDeREServRemTarifaXmlWriter.Gerar_infoAdq(A: TinfoAdqD2202): TACBrXmlNode;
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

function TDeREServRemTarifaXmlWriter.Gerar_idePartes(A: TidePartesD2202): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('idePartes');

  Result.AppendChild(Gerar_infoAdq(A.infoAdq));
end;

function TDeREServRemTarifaXmlWriter.Gerar_qualifOper(A: TqualifOperD2202): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('qualifOper');

  if A.TemindPresenc then
    Result.AppendChild(AddNode(tcStr, '#17', 'indPresenc', 1, 1, 1,
      IntToStr(Ord(A.indPresenc)), DSC_INDPRESENC));

  if A.TemcMunOper then
    Result.AppendChild(AddNode(tcStr, '#18', 'cMunOper', 7, 7, 1,
      A.cMunOper, DSC_CMUNOPER));
end;

function TDeREServRemTarifaXmlWriter.Gerar_gBC(A: TgBCD2202): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('gBC');

  Result.AppendChild(AddNode(tcDe2, '#19', 'vBCApur', 1, 18, 1,
    A.vBCApur, DSC_VBCAPUR));
end;

function TDeREServRemTarifaXmlWriter.Gerar_gTributos(A: TgTributosD2202): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('gTributos');

  Result.AppendChild(AddNode(tcDe2, '#20', 'vBCTrib', 1, 18, 1,
    A.vBCTrib, DSC_VBCTRIB));

  Result.AppendChild(AddNode(tcDe4, '#21', 'pIBSMunTrib', 1, 8, 1,
    A.pIBSMunTrib, DSC_PIBSMUNTRIB));

  Result.AppendChild(AddNode(tcDe2, '#22', 'vIBSMunTrib', 1, 18, 1,
    A.vIBSMunTrib, DSC_VIBSMUNTRIB));

  Result.AppendChild(AddNode(tcDe4, '#23', 'pIBSUFTrib', 1, 8, 1,
    A.pIBSUFTrib, DSC_PIBSUFTRIB));

  Result.AppendChild(AddNode(tcDe2, '#24', 'vIBSUFTrib', 1, 18, 1,
    A.vIBSUFTrib, DSC_VIBSUFTRIB));

  Result.AppendChild(AddNode(tcDe4, '#25', 'pCBSTrib', 1, 8, 1,
    A.pCBSTrib, DSC_PCBSTRIB));

  Result.AppendChild(AddNode(tcDe2, '#26', 'vCBSTrib', 1, 18, 1,
    A.vCBSTrib, DSC_VCBSTRIB));
end;

function TDeREServRemTarifaXmlWriter.Gerar_detOper(A: TdetOperCollectionItemD2202): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('detOper');

  Result.SetAttribute('seq', A.seq);

  if A.TemseqRef then
    Result.AppendChild(AddNode(tcStr, '#27', 'seqRef', 3, 3, 1,
      A.seqRef, DSC_SEQREF));

  Result.AppendChild(AddNode(tcStr, '#28', 'dhOper', 29, 29, 1,
    FormatarDhDeRE(A.dhOper), DSC_DHOPER));

  if A.TemqualifOper then
    Result.AppendChild(Gerar_qualifOper(A.qualifOper));

  Result.AppendChild(Gerar_gBC(A.gBC));

  Result.AppendChild(Gerar_gTributos(A.gTributos));
end;

function TDeREServRemTarifaXmlWriter.Gerar_dadosOper(A: TdadosOperD2202): TACBrXmlNode;
var
  i: Integer;
begin
  Result := FDocument.CreateElement('dadosOper');

  for i := 0 to A.detOper.Count - 1 do
    Result.AppendChild(Gerar_detOper(A.detOper[i]));
end;

function TDeREServRemTarifaXmlWriter.Gerar_gOper(A: TgOperD2202): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('gOper');

  Result.AppendChild(AddNode(tcStr, '#29', 'chAgrup', 50, 50, 1,
    A.chAgrup, DSC_CHAGRUP));

  Result.AppendChild(AddNode(tcStr, '#30', 'codBC', 4, 4, 1,
    A.codBC, DSC_CODBC));

  if A.TemchAgrupRef then
    Result.AppendChild(AddNode(tcStr, '#31', 'chAgrupRef', 50, 50, 1,
      A.chAgrupRef, DSC_CHAGRUPREF));

  Result.AppendChild(Gerar_idePartes(A.idePartes));

  Result.AppendChild(Gerar_dadosOper(A.dadosOper));
end;

function TDeREServRemTarifaXmlWriter.Gerar_infoOper(A: TinfoOperD2202): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('infoOper');

  Result.AppendChild(Gerar_gOper(A.gOper));
end;

initialization
  RegistrarWriterDeRE(teServRemTarifa, TDeREServRemTarifaXmlWriter);

end.
