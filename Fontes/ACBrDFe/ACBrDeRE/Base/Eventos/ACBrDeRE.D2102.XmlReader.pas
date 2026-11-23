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

unit ACBrDeRE.D2102.XmlReader;

interface

uses
  Classes, SysUtils,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrXmlDocument,
  ACBrDeRE.Classes,
  ACBrDeRE.D2102.Classes,
  ACBrDeRE.Conversao,
  ACBrDeRE.XmlReader;

type
  { TDeREInfoCotistasXmlReader - le o XML do evento evtInfoCotistas (D-2102) }

  TDeREInfoCotistasXmlReader = class(TDeREEventoXmlReader)
  private
    function Evt: TevtInfoCotistas;

    procedure Ler_infoCotistas(const ANode: TACBrXmlNode; A: TinfoCotistasD2102);
    procedure Ler_classes(const ANode: TACBrXmlNode; A: TclassesD2102);
    procedure Ler_classe(const ANode: TACBrXmlNode; A: TclasseCollectionItemD2102);
    procedure Ler_cotistas(const ANode: TACBrXmlNode; A: TcotistasD2102);
    procedure Ler_cotista(const ANode: TACBrXmlNode; A: TcotistaCollectionItemD2102);
    procedure Ler_cotas(const ANode: TACBrXmlNode; A: TcotasD2102);
    procedure Ler_cota(const ANode: TACBrXmlNode; A: TcotaCollectionItemD2102);
  protected
    function GetNomeEvento: string; override;
    procedure Ler_Evento(const ANode: TACBrXmlNode); override;
  end;

implementation

uses
  ACBrUtil.Base, ACBrUtil.Strings;

{ TDeREInfoCotistasXmlReader }

function TDeREInfoCotistasXmlReader.Evt: TevtInfoCotistas;
begin
  Result := (DeRE as TDeRED2102).evtInfoCotistas;
end;

function TDeREInfoCotistasXmlReader.GetNomeEvento: string;
begin
  Result := 'evtInfoCotistas';
end;

procedure TDeREInfoCotistasXmlReader.Ler_Evento(const ANode: TACBrXmlNode);
var
  LNode: TACBrXmlNode;
begin
  Ler_ideEventoRecibo(ANode.Childrens.FindAnyNs('ideEvento'), Evt.ideEvento);
  Ler_ideContrib(ANode.Childrens.FindAnyNs('ideContrib'), Evt.ideContrib);
  Ler_idePeriodoApur(ANode.Childrens.FindAnyNs('idePeriodo'), Evt.idePeriodo);

  LNode := ANode.Childrens.FindAnyNs('infoCotistas');
  Evt.infoCotistas.TeminfoCotistas := Assigned(LNode);
  if Evt.infoCotistas.TeminfoCotistas then
    Ler_infoCotistas(LNode, Evt.infoCotistas);
end;

procedure TDeREInfoCotistasXmlReader.Ler_infoCotistas(const ANode: TACBrXmlNode; A: TinfoCotistasD2102);
begin
  if not Assigned(ANode) then Exit;

  A.tpDeclarante := StrTotpDeclaranteDeRE(ObterConteudo(ANode.Childrens.FindAnyNs('tpDeclarante'), tcStr));

  Ler_classes(ANode.Childrens.FindAnyNs('classes'), A.classes);
end;

procedure TDeREInfoCotistasXmlReader.Ler_classes(const ANode: TACBrXmlNode; A: TclassesD2102);
var
  LNodes: TACBrXmlNodeArray;
  i: Integer;
begin
  if not Assigned(ANode) then Exit;

  LNodes := ANode.Childrens.FindAllAnyNs('classe');
  for i := 0 to Length(LNodes) - 1 do
    Ler_classe(LNodes[i], A.classe.New);
end;

procedure TDeREInfoCotistasXmlReader.Ler_classe(const ANode: TACBrXmlNode; A: TclasseCollectionItemD2102);
var
  LAtt: TACBrXmlAttribute;
begin
  if not Assigned(ANode) then Exit;

  LAtt := ANode.Attributes.Items['idClasse'];
  if Assigned(LAtt) then
    A.idClasse := LAtt.Content;
  LAtt := ANode.Attributes.Items['quantidadeCotas'];
  if Assigned(LAtt) then
    A.quantidadeCotas := LAtt.Content;
  LAtt := ANode.Attributes.Items['quantidadeCotistas'];
  if Assigned(LAtt) then
    A.quantidadeCotistas := LAtt.Content;
  LAtt := ANode.Attributes.Items['plClasse'];
  A.TemplClasse := Assigned(LAtt);
  if A.TemplClasse then
    A.plClasse := StringToFloatDef(LAtt.Content, 0);
  LAtt := ANode.Attributes.Items['cnpjFundo'];
  if Assigned(LAtt) then
    A.cnpjFundo := LAtt.Content;

  Ler_cotistas(ANode.Childrens.FindAnyNs('cotistas'), A.cotistas);
end;

procedure TDeREInfoCotistasXmlReader.Ler_cotistas(const ANode: TACBrXmlNode; A: TcotistasD2102);
var
  LNodes: TACBrXmlNodeArray;
  i: Integer;
begin
  if not Assigned(ANode) then Exit;

  LNodes := ANode.Childrens.FindAllAnyNs('cotista');
  for i := 0 to Length(LNodes) - 1 do
    Ler_cotista(LNodes[i], A.cotista.New);
end;

procedure TDeREInfoCotistasXmlReader.Ler_cotista(const ANode: TACBrXmlNode; A: TcotistaCollectionItemD2102);
var
  LAtt: TACBrXmlAttribute;
begin
  if not Assigned(ANode) then Exit;

  LAtt := ANode.Attributes.Items['tipoPessoa'];
  if Assigned(LAtt) then
    A.tipoPessoa := StrTotipoPessoaDeRE(LAtt.Content);
  LAtt := ANode.Attributes.Items['identificacao'];
  if Assigned(LAtt) then
    A.identificacao := LAtt.Content;
  LAtt := ANode.Attributes.Items['classificacao'];
  if Assigned(LAtt) then
    A.classificacao := StrToclassificacaoDeRE(LAtt.Content);

  Ler_cotas(ANode.Childrens.FindAnyNs('cotas'), A.cotas);
end;

procedure TDeREInfoCotistasXmlReader.Ler_cotas(const ANode: TACBrXmlNode; A: TcotasD2102);
var
  LNodes: TACBrXmlNodeArray;
  i: Integer;
begin
  if not Assigned(ANode) then Exit;

  LNodes := ANode.Childrens.FindAllAnyNs('cota');
  for i := 0 to Length(LNodes) - 1 do
    Ler_cota(LNodes[i], A.cota.New);
end;

procedure TDeREInfoCotistasXmlReader.Ler_cota(const ANode: TACBrXmlNode; A: TcotaCollectionItemD2102);
var
  LAtt: TACBrXmlAttribute;
begin
  if not Assigned(ANode) then Exit;

  LAtt := ANode.Attributes.Items['tipoCota'];
  if Assigned(LAtt) then
    A.tipoCota := LAtt.Content;
  LAtt := ANode.Attributes.Items['subclasse'];
  if Assigned(LAtt) then
    A.subclasse := LAtt.Content;
  LAtt := ANode.Attributes.Items['qtdeCotas'];
  if Assigned(LAtt) then
    A.qtdeCotas := LAtt.Content;
  LAtt := ANode.Attributes.Items['valorCota'];
  if Assigned(LAtt) then
    A.valorCota := LAtt.Content;
end;

initialization
  RegistrarReaderDeRE(teInfoCotistas, TDeREInfoCotistasXmlReader);

end.
