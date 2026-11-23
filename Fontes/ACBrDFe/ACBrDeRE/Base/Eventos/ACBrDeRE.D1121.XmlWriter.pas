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

unit ACBrDeRE.D1121.XmlWriter;

interface

uses
  Classes, SysUtils,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrDFe.RTC.XmlWriter,
  ACBrXmlDocument,
  ACBrXmlWriter,
  ACBrDeRE.Classes,
  ACBrDeRE.D1121.Classes,
  ACBrDeRE.Conversao,
  ACBrDeRE.XmlWriter;

type
  { TDeRERelDeducoesXmlWriter - gera o evento evtRelDeducoes (D-1121) }

  TDeRERelDeducoesXmlWriter = class(TDeREXmlWriter)
  private
    function Evt: TevtRelDeducoes;

    function Gerar_infoDeducoes: TACBrXmlNode;
    function Gerar_infoDeducao(AItem: TinfoDeducaoCollectionItemD1121): TACBrXmlNode;
    function Gerar_infoDFe(AItem: TinfoDeducaoCollectionItemD1121): TACBrXmlNode;
    function Gerar_infoImovel(AItem: TinfoDeducaoCollectionItemD1121): TACBrXmlNode;
    function Gerar_detDeducao(ADet: TdetDeducaoD1121): TACBrXmlNode;
    function Gerar_desdobDeducao(ADesdobItem: TdesdobDeducaoCollectionItemD1121): TACBrXmlNode;
    function Gerar_itemDFe(AItemDFe: TitemDFeCollectionItemD1121): TACBrXmlNode;
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

{ TDeRERelDeducoesXmlWriter }

function TDeRERelDeducoesXmlWriter.Evt: TevtRelDeducoes;
begin
  Result := (DeRE as TDeRED1121).evtRelDeducoes;
end;

function TDeRERelDeducoesXmlWriter.GetNameSpace: string;
begin
  Result := NamespaceDeRE(schevtRelDeducoes, VersaoDF);
end;

function TDeRERelDeducoesXmlWriter.Gerar_Evento: TACBrXmlNode;
begin
  Result := FDocument.CreateElement('evtRelDeducoes');
  Result.SetAttribute('id', Evt.id);

  Result.AppendChild(Gerar_ideEventoRecibo(Evt.ideEvento));
  Result.AppendChild(Gerar_ideContrib(Evt.ideContrib));
  Result.AppendChild(Gerar_idePeriodoApur(Evt.idePeriodo));

  if Evt.infoDeducoes.TeminfoDeducoes then
    Result.AppendChild(Gerar_infoDeducoes);
end;

function TDeRERelDeducoesXmlWriter.Gerar_infoDeducoes: TACBrXmlNode;
var
  LInfo: TinfoDeducoesD1121;
  i: Integer;
begin
  LInfo := Evt.infoDeducoes;
  Result := FDocument.CreateElement('infoDeducoes');
  if LInfo.TemfinEvt then
    Result.AppendChild(AddNode(tcStr, '#10', 'finEvt', 1, 1, 1,
      finEvtDeREToStr(LInfo.finEvt), DSC_FINevt));
  for i := 0 to LInfo.infoDeducao.Count - 1 do
    Result.AppendChild(Gerar_infoDeducao(LInfo.infoDeducao[i]));
end;

function TDeRERelDeducoesXmlWriter.Gerar_infoDeducao(AItem: TinfoDeducaoCollectionItemD1121): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('infoDeducao');
  if AItem.TeminfoDFe then
    Result.AppendChild(Gerar_infoDFe(AItem));
  if AItem.TeminfoImovel then
    Result.AppendChild(Gerar_infoImovel(AItem));
  if AItem.TemdetDeducao then
    Result.AppendChild(Gerar_detDeducao(AItem.detDeducao));
end;

function TDeRERelDeducoesXmlWriter.Gerar_infoDFe(AItem: TinfoDeducaoCollectionItemD1121): TACBrXmlNode;
var
  LDFe: TinfoDFeD1121;
begin
  LDFe := AItem.infoDFe;
  Result := FDocument.CreateElement('infoDFe');
  if LDFe.chDFe <> '' then
    Result.SetAttribute('chDFe', LDFe.chDFe);
  if LDFe.chDFeRetif <> '' then
    Result.SetAttribute('chDFeRetif', LDFe.chDFeRetif);
  if LDFe.TemtpDFe then
    Result.AppendChild(AddNode(tcStr, '#11', 'tpDFe', 2, 2, 1,
      tpDFeDeREToStr(LDFe.tpDFe), DSC_TPDFE));
  if LDFe.TemdtEmi then
    Result.AppendChild(AddNode(tcDat, '#12', 'dtEmi', 10, 10, 1,
      LDFe.dtEmi, DSC_DTEMI));
end;

function TDeRERelDeducoesXmlWriter.Gerar_infoImovel(AItem: TinfoDeducaoCollectionItemD1121): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('infoImovel');
  Result.AppendChild(AddNode(tcStr, '#13', 'CPFAlien', 11, 11, 1,
    AItem.infoImovel.CPFAlien, DSC_CPFALIEN));
end;

function TDeRERelDeducoesXmlWriter.Gerar_detDeducao(ADet: TdetDeducaoD1121): TACBrXmlNode;
var
  i: Integer;
begin
  Result := FDocument.CreateElement('detDeducao');
  Result.AppendChild(AddNode(tcDe2, '#14', 'vOper', 1, 18, 1,
    ADet.vOper, DSC_VOPER));
  for i := 0 to ADet.desdobDeducoes.Count - 1 do
    Result.AppendChild(Gerar_desdobDeducao(ADet.desdobDeducoes[i]));
end;

function TDeRERelDeducoesXmlWriter.Gerar_desdobDeducao(ADesdobItem: TdesdobDeducaoCollectionItemD1121): TACBrXmlNode;
var
  i: Integer;
begin
  Result := FDocument.CreateElement('desdobDeducao');
  Result.SetAttribute('tpAtiv', tpAtivDedDeREToStr(ADesdobItem.tpAtiv));
  Result.AppendChild(AddNode(tcStr, '#15', 'cCta', 1, 53, 1,
    ADesdobItem.cCta, DSC_CCTA_DED));
  if ADesdobItem.TemvDedTotal then
    Result.AppendChild(AddNode(tcDe2, '#16', 'vDedTotal', 1, 18, 1,
      ADesdobItem.vDedTotal, DSC_VDEDTOTAL));
  Result.AppendChild(AddNode(tcDe2, '#17', 'vDed', 1, 18, 1,
    ADesdobItem.vDed, DSC_VDED));
  for i := 0 to ADesdobItem.itemsDFe.Count - 1 do
    Result.AppendChild(Gerar_itemDFe(ADesdobItem.itemsDFe[i]));
end;

function TDeRERelDeducoesXmlWriter.Gerar_itemDFe(AItemDFe: TitemDFeCollectionItemD1121): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('itemDFe');
  Result.SetAttribute('nItem', AItemDFe.nItem);
  Result.AppendChild(AddNode(tcDe2, '#18', 'vItem', 1, 18, 1,
    AItemDFe.vItem, DSC_VITEM));
  if AItemDFe.TemvItemDedTotal then
    Result.AppendChild(AddNode(tcDe2, '#19', 'vItemDedTotal', 1, 18, 1,
      AItemDFe.vItemDedTotal, DSC_VITEMDEDTOTAL));
  Result.AppendChild(AddNode(tcDe2, '#20', 'vItemDed', 1, 18, 1,
    AItemDFe.vItemDed, DSC_VITEMDED));
end;

initialization
  RegistrarWriterDeRE(teRelDeducoes, TDeRERelDeducoesXmlWriter);

end.
