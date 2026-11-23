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

unit ACBrDeRE.D2251.XmlWriter;

interface

uses
  Classes, SysUtils,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrDFe.RTC.XmlWriter,
  ACBrXmlDocument,
  ACBrXmlWriter,
  ACBrDeRE.Classes,
  ACBrDeRE.D2251.Classes,
  ACBrDeRE.Conversao,
  ACBrDeRE.XmlWriter;

type
  { TDeRESegPrevCapXmlWriter - gera o evento evtSegPrevCap (D-2251) }

  TDeRESegPrevCapXmlWriter = class(TDeREXmlWriter)
  private
    function Evt: TevtSegPrevCap;

    function Gerar_adqExterior(A: TadqExteriorD2251): TACBrXmlNode;
    function Gerar_infoAdq(A: TinfoAdqD2251): TACBrXmlNode;
    function Gerar_infoPDV(A: TinfoPDVD2251): TACBrXmlNode;
    function Gerar_idePartes(A: TidePartesD2251): TACBrXmlNode;
    function Gerar_gSemCobert(A: TgSemCobertD2251): TACBrXmlNode;
    function Gerar_segExterior(A: TsegExteriorD2251): TACBrXmlNode;
    function Gerar_detSegurado(A: TdetSeguradoCollectionItemD2251): TACBrXmlNode;
    function Gerar_gIdSegurados(A: TgIdSeguradosD2251): TACBrXmlNode;
    function Gerar_gComCobertPrev(A: TgComCobertPrevD2251): TACBrXmlNode;
    function Gerar_gCapitalizacao(A: TgCapitalizacaoD2251): TACBrXmlNode;
    function Gerar_detOper(A: TdetOperCollectionItemD2251): TACBrXmlNode;
    function Gerar_dadosOper(A: TdadosOperD2251): TACBrXmlNode;
    function Gerar_gOper(A: TgOperD2251): TACBrXmlNode;
    function Gerar_infoOper(A: TinfoOperD2251): TACBrXmlNode;
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

{ TDeRESegPrevCapXmlWriter }

function TDeRESegPrevCapXmlWriter.Evt: TevtSegPrevCap;
begin
  Result := (DeRE as TDeRED2251).evtSegPrevCap;
end;

function TDeRESegPrevCapXmlWriter.GetNameSpace: string;
begin
  Result := NamespaceDeRE(schevtSegPrevCap, VersaoDF);
end;

function TDeRESegPrevCapXmlWriter.Gerar_Evento: TACBrXmlNode;
begin
  Result := FDocument.CreateElement('evtSegPrevCap');
  Result.SetAttribute('id', Evt.id);

  Result.AppendChild(Gerar_ideEventoFin(Evt.ideEvento));
  Result.AppendChild(Gerar_ideContrib(Evt.ideContrib));
  Result.AppendChild(Gerar_idePeriodoApurSub(Evt.idePeriodo));
  Result.AppendChild(Gerar_infoOper(Evt.infoOper));
end;

function TDeRESegPrevCapXmlWriter.Gerar_adqExterior(A: TadqExteriorD2251): TACBrXmlNode;
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

function TDeRESegPrevCapXmlWriter.Gerar_infoAdq(A: TinfoAdqD2251): TACBrXmlNode;
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

function TDeRESegPrevCapXmlWriter.Gerar_infoPDV(A: TinfoPDVD2251): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('infoPDV');

  if A.TemCPFPDV then
    Result.AppendChild(AddNode(tcStr, '#17', 'CPFPDV', 11, 11, 1,
      A.CPFPDV, DSC_CPFPDV));

  if A.TemCNPJPDV then
    Result.AppendChild(AddNode(tcStr, '#18', 'CNPJPDV', 14, 14, 1,
      A.CNPJPDV, DSC_CNPJPDV));
end;

function TDeRESegPrevCapXmlWriter.Gerar_idePartes(A: TidePartesD2251): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('idePartes');

  if A.TemindIdentifAdq then
    Result.AppendChild(AddNode(tcStr, '#19', 'indIdentifAdq', 1, 1, 1,
      IntToStr(Ord(A.indIdentifAdq)), DSC_INDIDENTIFADQ));

  if A.TeminfoAdq then
    Result.AppendChild(Gerar_infoAdq(A.infoAdq));

  if A.TeminfoPDV then
    Result.AppendChild(Gerar_infoPDV(A.infoPDV));
end;

function TDeRESegPrevCapXmlWriter.Gerar_gSemCobert(A: TgSemCobertD2251): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('gSemCobert');

  Result.AppendChild(AddNode(tcDe2, '#20', 'vBCDistr', 1, 18, 1,
    A.vBCDistr, DSC_VBCDISTR));
end;

function TDeRESegPrevCapXmlWriter.Gerar_segExterior(A: TsegExteriorD2251): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('segExterior');

  if A.TemNIFSeg then
    Result.AppendChild(AddNode(tcStr, '#21', 'NIFSeg', 1, 20, 1,
      A.NIFSeg, DSC_NIFSEG));

  if A.TemcNaoNIFSeg then
    Result.AppendChild(AddNode(tcStr, '#22', 'cNaoNIFSeg', 1, 1, 1,
      cNaoNIFDeREToStr(A.cNaoNIFSeg), DSC_CNAONIFSEG));

  if A.TemnrDocIdentSeg then
    Result.AppendChild(AddNode(tcStr, '#23', 'nrDocIdentSeg', 1, 20, 1,
      A.nrDocIdentSeg, DSC_NRDOCIDENTSEG));

  Result.AppendChild(AddNode(tcStr, '#24', 'cPaisSeg', 2, 2, 1,
    A.cPaisSeg, DSC_CPAISSEG));
end;

function TDeRESegPrevCapXmlWriter.Gerar_detSegurado(A: TdetSeguradoCollectionItemD2251): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('detSegurado');

  Result.AppendChild(AddNode(tcDe2, '#25', 'vBCDistrSeg', 1, 18, 1,
    A.vBCDistrSeg, DSC_VBCDISTRSEG));

  if A.TemCPFSeg then
    Result.AppendChild(AddNode(tcStr, '#26', 'CPFSeg', 11, 11, 1,
      A.CPFSeg, DSC_CPFSEG));

  if A.TemCNPJSeg then
    Result.AppendChild(AddNode(tcStr, '#27', 'CNPJSeg', 14, 14, 1,
      A.CNPJSeg, DSC_CNPJSEG));

  if A.TemcMunSeg then
    Result.AppendChild(AddNode(tcStr, '#28', 'cMunSeg', 7, 7, 1,
      A.cMunSeg, DSC_CMUNSEG));

  if A.TemsegExterior then
    Result.AppendChild(Gerar_segExterior(A.segExterior));
end;

function TDeRESegPrevCapXmlWriter.Gerar_gIdSegurados(A: TgIdSeguradosD2251): TACBrXmlNode;
var
  i: Integer;
begin
  Result := FDocument.CreateElement('gIdSegurados');

  for i := 0 to A.detSegurado.Count - 1 do
    Result.AppendChild(Gerar_detSegurado(A.detSegurado[i]));
end;

function TDeRESegPrevCapXmlWriter.Gerar_gComCobertPrev(A: TgComCobertPrevD2251): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('gComCobertPrev');

  Result.AppendChild(AddNode(tcStr, '#29', 'tpContrato', 1, 1, 1,
    tpContratoDeREToStr(A.tpContrato), DSC_TPCONTRATO));

  Result.AppendChild(AddNode(tcDe2, '#30', 'vBCDistr', 1, 18, 1,
    A.vBCDistr, DSC_VBCDISTR));

  if A.TemgIdSegurados then
    Result.AppendChild(Gerar_gIdSegurados(A.gIdSegurados));
end;

function TDeRESegPrevCapXmlWriter.Gerar_gCapitalizacao(A: TgCapitalizacaoD2251): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('gCapitalizacao');

  Result.AppendChild(AddNode(tcDe2, '#31', 'vBCDistr', 1, 18, 1,
    A.vBCDistr, DSC_VBCDISTR));

  if A.TemcMunOper then
    Result.AppendChild(AddNode(tcStr, '#32', 'cMunOper', 7, 7, 1,
      A.cMunOper, DSC_CMUNOPER));
end;

function TDeRESegPrevCapXmlWriter.Gerar_detOper(A: TdetOperCollectionItemD2251): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('detOper');

  Result.SetAttribute('seq', A.seq);

  if A.TemseqRef then
    Result.AppendChild(AddNode(tcStr, '#33', 'seqRef', 3, 3, 1,
      A.seqRef, DSC_SEQREF));

  Result.AppendChild(AddNode(tcStr, '#34', 'dhOper', 29, 29, 1,
    FormatarDhDeRE(A.dhOper), DSC_DHOPER));

  if A.TemgSemCobert then
    Result.AppendChild(Gerar_gSemCobert(A.gSemCobert));

  if A.TemgComCobertPrev then
    Result.AppendChild(Gerar_gComCobertPrev(A.gComCobertPrev));

  if A.TemgCapitalizacao then
    Result.AppendChild(Gerar_gCapitalizacao(A.gCapitalizacao));
end;

function TDeRESegPrevCapXmlWriter.Gerar_dadosOper(A: TdadosOperD2251): TACBrXmlNode;
var
  i: Integer;
begin
  Result := FDocument.CreateElement('dadosOper');

  for i := 0 to A.detOper.Count - 1 do
    Result.AppendChild(Gerar_detOper(A.detOper[i]));
end;

function TDeRESegPrevCapXmlWriter.Gerar_gOper(A: TgOperD2251): TACBrXmlNode;
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

function TDeRESegPrevCapXmlWriter.Gerar_infoOper(A: TinfoOperD2251): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('infoOper');

  Result.AppendChild(Gerar_gOper(A.gOper));
end;

initialization
  RegistrarWriterDeRE(teSegPrevCap, TDeRESegPrevCapXmlWriter);

end.
