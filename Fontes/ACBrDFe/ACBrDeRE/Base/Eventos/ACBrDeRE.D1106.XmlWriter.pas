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

unit ACBrDeRE.D1106.XmlWriter;

interface

uses
  Classes, SysUtils,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrDFe.RTC.XmlWriter,
  ACBrXmlDocument,
  ACBrXmlWriter,
  ACBrDeRE.Classes,
  ACBrDeRE.D1106.Classes,
  ACBrDeRE.Conversao,
  ACBrDeRE.XmlWriter;

type
  { TDeREAplicResTecXmlWriter - gera o evento evtAplicResTec (D-1106) }

  TDeREAplicResTecXmlWriter = class(TDeREXmlWriter)
  private
    function Evt: TevtAplicResTec;

    function Gerar_infoAplicResTec: TACBrXmlNode;
    function Gerar_infoAplic(AItem: TinfoAplicCollectionItemD1106): TACBrXmlNode;
    function Gerar_detAtivo(AItem: TdetAtivoCollectionItemD1106): TACBrXmlNode;
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

{ TDeREAplicResTecXmlWriter }

function TDeREAplicResTecXmlWriter.Evt: TevtAplicResTec;
begin
  Result := (DeRE as TDeRED1106).evtAplicResTec;
end;

function TDeREAplicResTecXmlWriter.GetNameSpace: string;
begin
  Result := NamespaceDeRE(schevtAplicResTec, VersaoDF);
end;

function TDeREAplicResTecXmlWriter.Gerar_Evento: TACBrXmlNode;
begin
  Result := FDocument.CreateElement('evtAplicResTec');
  Result.SetAttribute('id', Evt.id);

  Result.AppendChild(Gerar_ideEventoRecibo(Evt.ideEvento));
  Result.AppendChild(Gerar_ideContrib(Evt.ideContrib));
  Result.AppendChild(Gerar_idePeriodoApur(Evt.idePeriodo));

  if Evt.infoAplicResTec.TeminfoAplicResTec then
    Result.AppendChild(Gerar_infoAplicResTec);
end;

function TDeREAplicResTecXmlWriter.Gerar_infoAplicResTec: TACBrXmlNode;
var
  LInfo: TinfoAplicResTecD1106;
  i: Integer;
begin
  LInfo := Evt.infoAplicResTec;

  Result := FDocument.CreateElement('infoAplicResTec');

  if LInfo.semAplic then
    Result.AppendChild(AddNode(tcStr, '#10', 'semAplic', 1, 1, 1,
      '1', DSC_SEMAPLIC));

  for i := 0 to LInfo.infoAplic.Count - 1 do
    Result.AppendChild(Gerar_infoAplic(LInfo.infoAplic[i]));
end;

function TDeREAplicResTecXmlWriter.Gerar_infoAplic(AItem: TinfoAplicCollectionItemD1106): TACBrXmlNode;
var
  i: Integer;
begin
  Result := FDocument.CreateElement('infoAplic');

  Result.AppendChild(AddNode(tcStr, '#11', 'cCta', 1, 53, 1,
    AItem.cCta, DSC_CCTA));

  for i := 0 to AItem.detAtivo.Count - 1 do
    Result.AppendChild(Gerar_detAtivo(AItem.detAtivo[i]));
end;

function TDeREAplicResTecXmlWriter.Gerar_detAtivo(AItem: TdetAtivoCollectionItemD1106): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('detAtivo');
  Result.SetAttribute('idAtivo', AItem.idAtivo);

  Result.AppendChild(AddNode(tcStr, '#13', 'descAtivo', 1, 255, 1,
    AItem.descAtivo, DSC_DESCATIVO));

  Result.AppendChild(AddNode(tcDe2, '#14', 'vSaldoInic', 1, 18, 1,
    AItem.vSaldoInic, DSC_VSALDOINIC));

  if AItem.TemvRendPerReceb then
    Result.AppendChild(AddNode(tcDe2, '#15', 'vRendPerReceb', 1, 18, 1,
      AItem.vRendPerReceb, DSC_VRENDPERRECEB));

  if AItem.TemvVarMensal then
    Result.AppendChild(AddNode(tcDe2, '#16', 'vVarMensal', 1, 19, 1,
      AItem.vVarMensal, DSC_VVARMENSAL));

  Result.AppendChild(AddNode(tcDe2, '#17', 'vPrincLiqResg', 1, 18, 1,
    AItem.vPrincLiqResg, DSC_VPRINCLIQRESG));

  if AItem.TemvRendLiqResg then
    Result.AppendChild(AddNode(tcDe2, '#18', 'vRendLiqResg', 1, 18, 1,
      AItem.vRendLiqResg, DSC_VRENDLIQRESG));

  Result.AppendChild(AddNode(tcDe2, '#19', 'vSaldoFinal', 1, 18, 1,
    AItem.vSaldoFinal, DSC_VSALDOFINAL));

  Result.AppendChild(AddNode(tcDe2, '#20', 'vApur', 1, 18, 1,
    AItem.vApur, DSC_VAPUR));
end;

initialization
  RegistrarWriterDeRE(teAplicResTec, TDeREAplicResTecXmlWriter);

end.
