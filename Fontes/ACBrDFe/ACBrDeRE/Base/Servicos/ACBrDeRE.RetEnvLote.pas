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

unit ACBrDeRE.RetEnvLote;

interface

uses
  SysUtils, Classes,
  ACBrXmlBase, ACBrXmlDocument,
  ACBrDFe.Conversao,
  ACBrDeRE.Classes.Retorno,
  ACBrDeRE.XmlReader;

type
  { TRetEnvLoteDeRE - retorno do lote (retornoLoteEventos), usado na recepcao e na
    consulta do lote }

  TRetEnvLoteDeRE = class(TDeREXmlReaderBase)
  private
    FRetornoLote: TretornoLoteDeRE;

    function GetXmlRetorno: string;
    procedure SetXmlRetorno(const Value: string);

    procedure Ler_RetornoLoteDeRE(const ANode: TACBrXmlNode);
    procedure Ler_RetornoLote_Status(const ANode: TACBrXmlNode);
    procedure Ler_RetornoLote_DadosRecepcao(const ANode: TACBrXmlNode);
    procedure Ler_RetornoLote_DadosProcessamento(const ANode: TACBrXmlNode);
    procedure Ler_RetornoLote_RetornoEventos(const ANode: TACBrXmlNode);
  public
    constructor Create; reintroduce;
    destructor Destroy; override;

    // Le XmlRetorno. False se o XML nao for um retorno de lote (retornoLoteEventos).
    function LerXml: Boolean; override;

    property XmlRetorno: string read GetXmlRetorno write SetXmlRetorno;
    property RetornoLote: TretornoLoteDeRE read FRetornoLote;
  end;

implementation

uses
  ACBrUtil.Base, ACBrUtil.Strings,
  ACBrDeRE.Conversao;

{ TRetEnvLoteDeRE }

constructor TRetEnvLoteDeRE.Create;
begin
  inherited Create;
  FRetornoLote := TretornoLoteDeRE.Create;
end;

destructor TRetEnvLoteDeRE.Destroy;
begin
  FRetornoLote.Free;
  inherited Destroy;
end;

function TRetEnvLoteDeRE.GetXmlRetorno: string;
begin
  Result := Arquivo;
end;

procedure TRetEnvLoteDeRE.SetXmlRetorno(const Value: string);
begin
  Arquivo := Value;
end;

function TRetEnvLoteDeRE.LerXml: Boolean;
var
  DeRENode, FilhoNode: TACBrXmlNode;
begin
  Result := False;

  FRetornoLote.Clear;

  if EstaVazio(Arquivo) then
    Exit;

  try
    Document.Clear;
    Document.LoadFromXml(Arquivo);
  except
    // Corpo que nao e XML (ex.: JSON de erro): o chamador monta a mensagem
    Exit;
  end;

  DeRENode := Document.Root;

  if (DeRENode = nil) or (DeRENode.Name <> 'DeRE') then
    Exit;

  FilhoNode := DeRENode.Childrens.FindAnyNs('retornoLoteEventos');
  if not Assigned(FilhoNode) then
    Exit;

  Ler_RetornoLoteDeRE(FilhoNode);
  LerSignature(DeRENode.Childrens.FindAnyNs('Signature'), FRetornoLote.Signature);
  Result := True;
end;

procedure TRetEnvLoteDeRE.Ler_RetornoLoteDeRE(const ANode: TACBrXmlNode);
var
  ideContribNode, ideTransmNode: TACBrXmlNode;
  att: TACBrXmlAttribute;
begin
  att := ANode.Attributes.Items['id'];
  if Assigned(att) then
    FRetornoLote.id := att.Content;

  ideContribNode := ANode.Childrens.FindAnyNs('ideContrib');
  if Assigned(ideContribNode) then
    FRetornoLote.nrInsc := ObterConteudo(ideContribNode.Childrens.FindAnyNs('nrInsc'), tcStr);

  ideTransmNode := ANode.Childrens.FindAnyNs('ideTransmissor');
  if Assigned(ideTransmNode) then
    FRetornoLote.niTransmissor := ObterConteudo(ideTransmNode.Childrens.FindAnyNs('niTransmissor'), tcStr);

  Ler_RetornoLote_Status(ANode.Childrens.FindAnyNs('status'));
  Ler_RetornoLote_DadosRecepcao(ANode.Childrens.FindAnyNs('dadosRecepcaoLote'));
  Ler_RetornoLote_DadosProcessamento(ANode.Childrens.FindAnyNs('dadosProcessamentoLote'));
  Ler_RetornoLote_RetornoEventos(ANode.Childrens.FindAnyNs('retornoEventos'));
end;

procedure TRetEnvLoteDeRE.Ler_RetornoLote_Status(const ANode: TACBrXmlNode);
begin
  if not Assigned(ANode) then Exit;

  FRetornoLote.status.cdResposta := StrTocdRespostaLoteDeRE(ObterConteudo(ANode.Childrens.FindAnyNs('cdResposta'), tcStr));
  FRetornoLote.status.descResposta := ObterConteudo(ANode.Childrens.FindAnyNs('descResposta'), tcStr);

  Ler_Ocorrencias(ANode.Childrens.FindAnyNs('ocorrencias'), FRetornoLote.status.ocorrencias);
end;

procedure TRetEnvLoteDeRE.Ler_RetornoLote_DadosRecepcao(const ANode: TACBrXmlNode);
begin
  if not Assigned(ANode) then Exit;

  FRetornoLote.dadosRecepcaoLote.TemDados := True;
  FRetornoLote.dadosRecepcaoLote.dhRecepcao := ObterConteudo(ANode.Childrens.FindAnyNs('dhRecepcao'), tcDatHor);
  FRetornoLote.dadosRecepcaoLote.versaoAplicativoRecepcao := ObterConteudo(ANode.Childrens.FindAnyNs('versaoAplicativoRecepcao'), tcStr);
  FRetornoLote.dadosRecepcaoLote.protocolo := ObterConteudo(ANode.Childrens.FindAnyNs('protocolo'), tcStr);
end;

procedure TRetEnvLoteDeRE.Ler_RetornoLote_DadosProcessamento(const ANode: TACBrXmlNode);
begin
  if not Assigned(ANode) then Exit;

  FRetornoLote.dadosProcessamentoLote.TemDados := True;
  FRetornoLote.dadosProcessamentoLote.dhProcessamento := ObterConteudo(ANode.Childrens.FindAnyNs('dhProcessamento'), tcDatHor);
  FRetornoLote.dadosProcessamentoLote.versaoAplicativoProcessamento := ObterConteudo(ANode.Childrens.FindAnyNs('versaoAplicativoProcessamento'), tcStr);
end;

procedure TRetEnvLoteDeRE.Ler_RetornoLote_RetornoEventos(const ANode: TACBrXmlNode);
var
  EventoNodes: TACBrXmlNodeArray;
  i: Integer;
  Item: TRetornoEventoCollectionItem;
  att: TACBrXmlAttribute;
begin
  if not Assigned(ANode) then Exit;

  EventoNodes := ANode.Childrens.FindAllAnyNs('evento');

  for i := Low(EventoNodes) to High(EventoNodes) do
  begin
    Item := FRetornoLote.retornoEventos.New;

    att := EventoNodes[i].Attributes.Items['id'];
    if Assigned(att) then
      Item.id := att.Content;

    Item.XML := EventoNodes[i].InnerXml;
  end;
end;

end.
