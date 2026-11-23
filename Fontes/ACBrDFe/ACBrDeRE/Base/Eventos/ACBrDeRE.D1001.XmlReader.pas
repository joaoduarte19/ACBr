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

unit ACBrDeRE.D1001.XmlReader;

interface

uses
  Classes, SysUtils,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrXmlDocument,
  ACBrDeRE.Classes,
  ACBrDeRE.D1001.Classes,
  ACBrDeRE.Conversao,
  ACBrDeRE.XmlReader;

type
  { TDeREInfoContribXmlReader - le o XML do evento evtInfoContrib (D-1001) }

  TDeREInfoContribXmlReader = class(TDeREEventoXmlReader)
  private
    function Evt: TevtInfoContrib;

    procedure Ler_infoContrib(const ANode: TACBrXmlNode);
    procedure Ler_tpAtividades(const ANode: TACBrXmlNode; ALista: TtpAtividadeCollectionD1001);
    procedure Ler_prognosticos(const ANode: TACBrXmlNode; AProg: TprognosticosD1001);
  protected
    function GetNomeEvento: string; override;
    procedure Ler_Evento(const ANode: TACBrXmlNode); override;
  end;

implementation

{ TDeREInfoContribXmlReader }

function TDeREInfoContribXmlReader.Evt: TevtInfoContrib;
begin
  Result := (DeRE as TDeRED1001).evtInfoContrib;
end;

function TDeREInfoContribXmlReader.GetNomeEvento: string;
begin
  Result := 'evtInfoContrib';
end;

procedure TDeREInfoContribXmlReader.Ler_Evento(const ANode: TACBrXmlNode);
var
  LNode: TACBrXmlNode;
begin
  Ler_ideEvento(ANode.Childrens.FindAnyNs('ideEvento'), Evt.ideEvento);
  Ler_ideContrib(ANode.Childrens.FindAnyNs('ideContrib'), Evt.ideContrib);
  Ler_idePeriodo(ANode.Childrens.FindAnyNs('idePeriodo'), Evt.idePeriodo);

  LNode := ANode.Childrens.FindAnyNs('infoContrib');
  Evt.infoContrib.TeminfoContrib := Assigned(LNode);
  if Evt.infoContrib.TeminfoContrib then
    Ler_infoContrib(LNode);
end;

procedure TDeREInfoContribXmlReader.Ler_infoContrib(const ANode: TACBrXmlNode);
var
  LInfo: TinfoContribD1001;
  LNodes: TACBrXmlNodeArray;
  LNode: TACBrXmlNode;
  i: Integer;
begin
  LInfo := Evt.infoContrib;

  LInfo.regTribPrinc := StrToregTribDeRE(
    ObterConteudo(ANode.Childrens.FindAnyNs('regTribPrinc'), tcStr));

  LInfo.regTribSecund.Clear;
  LNodes := ANode.Childrens.FindAllAnyNs('regTribSecund');
  for i := 0 to Length(LNodes) - 1 do
    LInfo.regTribSecund.New.regTribSecund := StrToregTribDeRE(
      ObterConteudo(LNodes[i], tcStr));

  LInfo.indNatTrib := StrToindNatTribDeRE(
    ObterConteudo(ANode.Childrens.FindAnyNs('indNatTrib'), tcStr));

  LNode := ANode.Childrens.FindAnyNs('servFinanc');
  LInfo.TemservFinanc := Assigned(LNode);
  if LInfo.TemservFinanc then
    Ler_tpAtividades(LNode, LInfo.servFinanc.tpAtividades);

  LNode := ANode.Childrens.FindAnyNs('plAssistSaude');
  LInfo.TemplAssistSaude := Assigned(LNode);
  if LInfo.TemplAssistSaude then
    Ler_tpAtividades(LNode, LInfo.plAssistSaude.tpAtividades);

  LNode := ANode.Childrens.FindAnyNs('prognosticos');
  LInfo.Temprognosticos := Assigned(LNode);
  if LInfo.Temprognosticos then
    Ler_prognosticos(LNode, LInfo.prognosticos);
end;

procedure TDeREInfoContribXmlReader.Ler_tpAtividades(const ANode: TACBrXmlNode;
  ALista: TtpAtividadeCollectionD1001);
var
  LGrupo: TACBrXmlNode;
  LNodes: TACBrXmlNodeArray;
  i: Integer;
begin
  ALista.Clear;

  LGrupo := ANode.Childrens.FindAnyNs('tpAtividades');
  if not Assigned(LGrupo) then
    Exit;

  LNodes := LGrupo.Childrens.FindAllAnyNs('tpAtividade');
  for i := 0 to Length(LNodes) - 1 do
    ALista.New.tpAtividade := ObterConteudo(LNodes[i], tcStr);
end;

procedure TDeREInfoContribXmlReader.Ler_prognosticos(const ANode: TACBrXmlNode;
  AProg: TprognosticosD1001);
var
  LGrupo: TACBrXmlNode;
  LNodes: TACBrXmlNodeArray;
  i: Integer;
begin
  Ler_tpAtividades(ANode, AProg.tpAtividades);

  AProg.UFsCredenc.Clear;

  LGrupo := ANode.Childrens.FindAnyNs('UFsCredenc');
  if not Assigned(LGrupo) then
    Exit;

  LNodes := LGrupo.Childrens.FindAllAnyNs('UFCredenc');
  for i := 0 to Length(LNodes) - 1 do
    AProg.UFsCredenc.New.UFCredenc := ObterConteudo(LNodes[i], tcInt);
end;

initialization
  RegistrarReaderDeRE(teInfoContrib, TDeREInfoContribXmlReader);

end.
