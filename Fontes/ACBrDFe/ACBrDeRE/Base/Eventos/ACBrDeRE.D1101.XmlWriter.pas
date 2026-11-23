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

unit ACBrDeRE.D1101.XmlWriter;

interface

uses
  Classes, SysUtils,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrDFe.RTC.XmlWriter,
  ACBrXmlDocument,
  ACBrXmlWriter,
  ACBrDeRE.Classes,
  ACBrDeRE.D1101.Classes,
  ACBrDeRE.Conversao,
  ACBrDeRE.XmlWriter;

type
  { TDeREBalanceteXmlWriter - gera o evento evtBalancete (D-1101) }

  TDeREBalanceteXmlWriter = class(TDeREXmlWriter)
  private
    function Evt: TevtBalancete;

    function Gerar_infoBalancete: TACBrXmlNode;
    function Gerar_infoContas: TACBrXmlNode;
    function Gerar_infoConta(AItem: TinfoContaBalanceteCollectionItemD1101): TACBrXmlNode;
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

{ TDeREBalanceteXmlWriter }

function TDeREBalanceteXmlWriter.Evt: TevtBalancete;
begin
  Result := (DeRE as TDeRED1101).evtBalancete;
end;

function TDeREBalanceteXmlWriter.GetNameSpace: string;
begin
  Result := NamespaceDeRE(schevtBalancete, VersaoDF);
end;

function TDeREBalanceteXmlWriter.Gerar_Evento: TACBrXmlNode;
begin
  Result := FDocument.CreateElement('evtBalancete');
  Result.SetAttribute('id', Evt.id);

  Result.AppendChild(Gerar_ideEventoRecibo(Evt.ideEvento));
  Result.AppendChild(Gerar_ideContrib(Evt.ideContrib));
  Result.AppendChild(Gerar_idePeriodoApur(Evt.idePeriodo));

  if Evt.infoBalancete.TeminfoBalancete then
    Result.AppendChild(Gerar_infoBalancete);
end;

function TDeREBalanceteXmlWriter.Gerar_infoBalancete: TACBrXmlNode;
begin
  Result := FDocument.CreateElement('infoBalancete');

  Result.AppendChild(Gerar_infoContas);
end;

function TDeREBalanceteXmlWriter.Gerar_infoContas: TACBrXmlNode;
var
  LInfo: TinfoBalanceteD1101;
  i: Integer;
begin
  LInfo := Evt.infoBalancete;

  Result := FDocument.CreateElement('infoContas');

  for i := 0 to LInfo.infoContas.Count - 1 do
    Result.AppendChild(Gerar_infoConta(LInfo.infoContas[i]));
end;

function TDeREBalanceteXmlWriter.Gerar_infoConta(AItem: TinfoContaBalanceteCollectionItemD1101): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('infoConta');

  Result.AppendChild(AddNode(tcStr, '#10', 'cCta', 1, 53, 1,
    AItem.cCta, DSC_CCTA));

  Result.AppendChild(AddNode(tcStr, '#11', 'natSaldoInic', 1, 1, 1,
    natSaldoDeREToStr(AItem.natSaldoInic), DSC_NATSALDOINIC));

  Result.AppendChild(AddNode(tcDe2, '#12', 'vSaldoInic', 1, 18, 1,
    AItem.vSaldoInic, DSC_VSALDOINIC));

  Result.AppendChild(AddNode(tcDe2, '#13', 'vMovDebt', 1, 18, 1,
    AItem.vMovDebt, DSC_VMOVDEBT));

  if AItem.TemvAjusteDebt then
    Result.AppendChild(AddNode(tcDe2, '#14', 'vAjusteDebt', 1, 18, 1,
      AItem.vAjusteDebt, DSC_VAJUSTEDEBT));

  Result.AppendChild(AddNode(tcDe2, '#15', 'vMovCred', 1, 18, 1,
    AItem.vMovCred, DSC_VMOVCRED));

  if AItem.TemvAjusteCred then
    Result.AppendChild(AddNode(tcDe2, '#16', 'vAjusteCred', 1, 18, 1,
      AItem.vAjusteCred, DSC_VAJUSTECRED));

  Result.AppendChild(AddNode(tcStr, '#17', 'natSaldoFinal', 1, 1, 1,
    natSaldoDeREToStr(AItem.natSaldoFinal), DSC_NATSALDOFINAL));

  Result.AppendChild(AddNode(tcDe2, '#18', 'vSaldoFinal', 1, 18, 1,
    AItem.vSaldoFinal, DSC_VSALDOFINAL));

  if AItem.TemnatVApur then
    Result.AppendChild(AddNode(tcStr, '#19', 'natVApur', 1, 1, 1,
      natSaldoDeREToStr(AItem.natVApur), DSC_NATVAPUR));

  Result.AppendChild(AddNode(tcDe2, '#20', 'vApur', 1, 18, 1,
    AItem.vApur, DSC_VAPUR));
end;

initialization
  RegistrarWriterDeRE(teBalancete, TDeREBalanceteXmlWriter);

end.
