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

unit ACBrDeRE.D1199.XmlWriter;

interface

uses
  Classes, SysUtils,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrDFe.RTC.XmlWriter,
  ACBrXmlDocument,
  ACBrXmlWriter,
  ACBrDeRE.Classes,
  ACBrDeRE.D1199.Classes,
  ACBrDeRE.Conversao,
  ACBrDeRE.XmlWriter;

type
  { TDeREFechMensalXmlWriter - gera o evento evtFechMensal (D-1199) }

  TDeREFechMensalXmlWriter = class(TDeREXmlWriter)
  private
    function Evt: TevtFechMensal;

    function Gerar_infoParamFech(A: TinfoParamFechD1199): TACBrXmlNode;
    function Gerar_infoBCN(A: TinfoBCNCollectionItemD1199): TACBrXmlNode;
    function Gerar_detBCNeg(A: TdetBCNegCollectionItemD1199): TACBrXmlNode;
    function Gerar_gUtilizBCN(A: TgUtilizBCND1199): TACBrXmlNode;
    function Gerar_infoFechamento(A: TinfoFechamentoD1199): TACBrXmlNode;
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

{ TDeREFechMensalXmlWriter }

function TDeREFechMensalXmlWriter.Evt: TevtFechMensal;
begin
  Result := (DeRE as TDeRED1199).evtFechMensal;
end;

function TDeREFechMensalXmlWriter.GetNameSpace: string;
begin
  Result := NamespaceDeRE(schevtFechMensal, VersaoDF);
end;

function TDeREFechMensalXmlWriter.Gerar_Evento: TACBrXmlNode;
begin
  Result := FDocument.CreateElement('evtFechMensal');
  Result.SetAttribute('id', Evt.id);

  Result.AppendChild(Gerar_ideEvento(Evt.ideEvento));
  Result.AppendChild(Gerar_ideContrib(Evt.ideContrib));
  Result.AppendChild(Gerar_idePeriodoApur(Evt.idePeriodo));

  if Evt.infoFechamento.TeminfoFechamento then
    Result.AppendChild(Gerar_infoFechamento(Evt.infoFechamento));
end;

function TDeREFechMensalXmlWriter.Gerar_infoParamFech(A: TinfoParamFechD1199): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('infoParamFech');

  if A.indInexistDedu then
    Result.AppendChild(AddNode(tcStr, '#10', 'indInexistDedu', 1, 1, 1,
      '1', DSC_INDINEXISTDEDU));
end;

function TDeREFechMensalXmlWriter.Gerar_infoBCN(A: TinfoBCNCollectionItemD1199): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('infoBCN');

  Result.AppendChild(AddNode(tcStr, '#11', 'codBCNRaiz', 5, 5, 1,
    A.codBCNRaiz, DSC_CODBCNRAIZ));

  Result.AppendChild(AddNode(tcStr, '#12', 'usarBCNAcum', 1, 1, 1,
    IntToStr(Ord(A.usarBCNAcum)), DSC_USARBCNACUM));

  if A.TemmetodoAproveit then
    Result.AppendChild(AddNode(tcStr, '#13', 'metodoAproveit', 1, 1, 1,
      metodoAproveitDeREToStr(A.metodoAproveit), DSC_METODOAPROVEIT));
end;

function TDeREFechMensalXmlWriter.Gerar_detBCNeg(A: TdetBCNegCollectionItemD1199): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('detBCNeg');

  Result.AppendChild(AddNode(tcStr, '#14', 'codBCN', 13, 13, 1,
    A.codBCN, DSC_CODBCN));

  if A.TemvUsarBCN then
    Result.AppendChild(AddNode(tcDe2, '#15', 'vUsarBCN', 1, 18, 1,
      A.vUsarBCN, DSC_VUSARBCN));
end;

function TDeREFechMensalXmlWriter.Gerar_gUtilizBCN(A: TgUtilizBCND1199): TACBrXmlNode;
var
  i: Integer;
begin
  Result := FDocument.CreateElement('gUtilizBCN');

  for i := 0 to A.infoBCN.Count - 1 do
    Result.AppendChild(Gerar_infoBCN(A.infoBCN[i]));

  for i := 0 to A.detBCNeg.Count - 1 do
    Result.AppendChild(Gerar_detBCNeg(A.detBCNeg[i]));
end;

function TDeREFechMensalXmlWriter.Gerar_infoFechamento(A: TinfoFechamentoD1199): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('infoFechamento');

  if A.TeminfoParamFech then
    Result.AppendChild(Gerar_infoParamFech(A.infoParamFech));

  if A.TemgUtilizBCN then
    Result.AppendChild(Gerar_gUtilizBCN(A.gUtilizBCN));
end;

initialization
  RegistrarWriterDeRE(teFechMensal, TDeREFechMensalXmlWriter);

end.
