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

unit ACBrDeRE.D1001.XmlWriter;

interface

uses
  Classes, SysUtils,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrDFe.RTC.XmlWriter,
  ACBrXmlDocument,
  ACBrXmlWriter,
  ACBrDeRE.Classes,
  ACBrDeRE.D1001.Classes,
  ACBrDeRE.Conversao,
  ACBrDeRE.XmlWriter;

type
  { TDeREInfoContribXmlWriter - gera o evento evtInfoContrib (D-1001) }

  TDeREInfoContribXmlWriter = class(TDeREXmlWriter)
  private
    function Evt: TevtInfoContrib;

    function Gerar_infoContrib: TACBrXmlNode;
    function Gerar_tpAtividades(ALista: TtpAtividadeCollectionD1001): TACBrXmlNode;
    function Gerar_infoContrib_servFinanc: TACBrXmlNode;
    function Gerar_infoContrib_plAssistSaude: TACBrXmlNode;
    function Gerar_infoContrib_prognosticos: TACBrXmlNode;
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

{ TDeREInfoContribXmlWriter }

function TDeREInfoContribXmlWriter.Evt: TevtInfoContrib;
begin
  Result := (DeRE as TDeRED1001).evtInfoContrib;
end;

function TDeREInfoContribXmlWriter.GetNameSpace: string;
begin
  Result := NamespaceDeRE(schevtInfoContrib, VersaoDF);
end;

function TDeREInfoContribXmlWriter.Gerar_Evento: TACBrXmlNode;
begin
  Result := FDocument.CreateElement('evtInfoContrib');
  Result.SetAttribute('id', Evt.id);

  Result.AppendChild(Gerar_ideEvento(Evt.ideEvento));
  Result.AppendChild(Gerar_ideContrib(Evt.ideContrib));
  Result.AppendChild(Gerar_idePeriodo(Evt.idePeriodo));

  if Evt.infoContrib.TeminfoContrib then
    Result.AppendChild(Gerar_infoContrib);
end;

function TDeREInfoContribXmlWriter.Gerar_infoContrib: TACBrXmlNode;
var
  LInfo: TinfoContribD1001;
  i: Integer;
begin
  LInfo := Evt.infoContrib;

  Result := FDocument.CreateElement('infoContrib');

  Result.AppendChild(AddNode(tcStr, '#12', 'regTribPrinc', 1, 1, 1,
    regTribDeREToStr(LInfo.regTribPrinc), DSC_REGTRIBPRINC));

  for i := 0 to LInfo.regTribSecund.Count - 1 do
    Result.AppendChild(AddNode(tcStr, '#13', 'regTribSecund', 1, 1, 1,
      regTribDeREToStr(LInfo.regTribSecund[i].regTribSecund), DSC_REGTRIBSECUND));

  Result.AppendChild(AddNode(tcStr, '#14', 'indNatTrib', 1, 1, 1,
    indNatTribDeREToStr(LInfo.indNatTrib), DSC_INDNATTRIB));

  if LInfo.TemservFinanc then
    Result.AppendChild(Gerar_infoContrib_servFinanc);

  if LInfo.TemplAssistSaude then
    Result.AppendChild(Gerar_infoContrib_plAssistSaude);

  if LInfo.Temprognosticos then
    Result.AppendChild(Gerar_infoContrib_prognosticos);
end;

function TDeREInfoContribXmlWriter.Gerar_tpAtividades(ALista: TtpAtividadeCollectionD1001): TACBrXmlNode;
var
  i: Integer;
begin
  Result := FDocument.CreateElement('tpAtividades');

  for i := 0 to ALista.Count - 1 do
    Result.AppendChild(AddNode(tcStr, '#15', 'tpAtividade', 3, 3, 1,
      ALista[i].tpAtividade, DSC_TPATIVIDADE));
end;

function TDeREInfoContribXmlWriter.Gerar_infoContrib_servFinanc: TACBrXmlNode;
begin
  Result := FDocument.CreateElement('servFinanc');
  Result.AppendChild(Gerar_tpAtividades(Evt.infoContrib.servFinanc.tpAtividades));
end;

function TDeREInfoContribXmlWriter.Gerar_infoContrib_plAssistSaude: TACBrXmlNode;
begin
  Result := FDocument.CreateElement('plAssistSaude');
  Result.AppendChild(Gerar_tpAtividades(Evt.infoContrib.plAssistSaude.tpAtividades));
end;

function TDeREInfoContribXmlWriter.Gerar_infoContrib_prognosticos: TACBrXmlNode;
var
  LProg: TprognosticosD1001;
  UFsNode: TACBrXmlNode;
  i: Integer;
begin
  LProg := Evt.infoContrib.prognosticos;

  Result := FDocument.CreateElement('prognosticos');
  Result.AppendChild(Gerar_tpAtividades(LProg.tpAtividades));

  if LProg.UFsCredenc.Count > 0 then
  begin
    UFsNode := FDocument.CreateElement('UFsCredenc');

    for i := 0 to LProg.UFsCredenc.Count - 1 do
      UFsNode.AppendChild(AddNode(tcInt, '#16', 'UFCredenc', 2, 2, 1,
        LProg.UFsCredenc[i].UFCredenc, DSC_UFCREDENC));

    Result.AppendChild(UFsNode);
  end;
end;

initialization
  RegistrarWriterDeRE(teInfoContrib, TDeREInfoContribXmlWriter);

end.
