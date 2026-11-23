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

unit ACBrDeRE.D2102.XmlWriter;

interface

uses
  Classes, SysUtils,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrDFe.RTC.XmlWriter,
  ACBrXmlDocument,
  ACBrXmlWriter,
  ACBrDeRE.Classes,
  ACBrDeRE.D2102.Classes,
  ACBrDeRE.Conversao,
  ACBrDeRE.XmlWriter;

type
  { TDeREInfoCotistasXmlWriter - gera o evento evtInfoCotistas (D-2102) }

  TDeREInfoCotistasXmlWriter = class(TDeREXmlWriter)
  private
    function Evt: TevtInfoCotistas;

    function Gerar_cota(A: TcotaCollectionItemD2102): TACBrXmlNode;
    function Gerar_cotas(A: TcotasD2102): TACBrXmlNode;
    function Gerar_cotista(A: TcotistaCollectionItemD2102): TACBrXmlNode;
    function Gerar_cotistas(A: TcotistasD2102): TACBrXmlNode;
    function Gerar_classe(A: TclasseCollectionItemD2102): TACBrXmlNode;
    function Gerar_classes(A: TclassesD2102): TACBrXmlNode;
    function Gerar_infoCotistas(A: TinfoCotistasD2102): TACBrXmlNode;
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

{ TDeREInfoCotistasXmlWriter }

function TDeREInfoCotistasXmlWriter.Evt: TevtInfoCotistas;
begin
  Result := (DeRE as TDeRED2102).evtInfoCotistas;
end;

function TDeREInfoCotistasXmlWriter.GetNameSpace: string;
begin
  Result := NamespaceDeRE(schevtInfoCotistas, VersaoDF);
end;

function TDeREInfoCotistasXmlWriter.Gerar_Evento: TACBrXmlNode;
begin
  Result := FDocument.CreateElement('evtInfoCotistas');
  Result.SetAttribute('id', Evt.id);

  Result.AppendChild(Gerar_ideEventoRecibo(Evt.ideEvento));
  Result.AppendChild(Gerar_ideContrib(Evt.ideContrib));
  Result.AppendChild(Gerar_idePeriodoApur(Evt.idePeriodo));

  if Evt.infoCotistas.TeminfoCotistas then
    Result.AppendChild(Gerar_infoCotistas(Evt.infoCotistas));
end;

function TDeREInfoCotistasXmlWriter.Gerar_cota(A: TcotaCollectionItemD2102): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('cota');

  Result.SetAttribute('tipoCota', A.tipoCota);

  Result.SetAttribute('subclasse', A.subclasse);

  Result.SetAttribute('qtdeCotas', A.qtdeCotas);

  Result.SetAttribute('valorCota', A.valorCota);
end;

function TDeREInfoCotistasXmlWriter.Gerar_cotas(A: TcotasD2102): TACBrXmlNode;
var
  i: Integer;
begin
  Result := FDocument.CreateElement('cotas');

  for i := 0 to A.cota.Count - 1 do
    Result.AppendChild(Gerar_cota(A.cota[i]));
end;

function TDeREInfoCotistasXmlWriter.Gerar_cotista(A: TcotistaCollectionItemD2102): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('cotista');

  Result.SetAttribute('tipoPessoa', tipoPessoaDeREToStr(A.tipoPessoa));

  Result.SetAttribute('identificacao', A.identificacao);

  Result.SetAttribute('classificacao', classificacaoDeREToStr(A.classificacao));

  Result.AppendChild(Gerar_cotas(A.cotas));
end;

function TDeREInfoCotistasXmlWriter.Gerar_cotistas(A: TcotistasD2102): TACBrXmlNode;
var
  i: Integer;
begin
  Result := FDocument.CreateElement('cotistas');

  for i := 0 to A.cotista.Count - 1 do
    Result.AppendChild(Gerar_cotista(A.cotista[i]));
end;

function TDeREInfoCotistasXmlWriter.Gerar_classe(A: TclasseCollectionItemD2102): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('classe');

  Result.SetAttribute('idClasse', A.idClasse);

  Result.SetAttribute('quantidadeCotas', A.quantidadeCotas);

  Result.SetAttribute('quantidadeCotistas', A.quantidadeCotistas);

  if A.TemplClasse then
    Result.SetAttribute('plClasse', StringReplace(FormatFloat('0.00', A.plClasse), ',', '.', []));

  Result.SetAttribute('cnpjFundo', A.cnpjFundo);

  Result.AppendChild(Gerar_cotistas(A.cotistas));
end;

function TDeREInfoCotistasXmlWriter.Gerar_classes(A: TclassesD2102): TACBrXmlNode;
var
  i: Integer;
begin
  Result := FDocument.CreateElement('classes');

  for i := 0 to A.classe.Count - 1 do
    Result.AppendChild(Gerar_classe(A.classe[i]));
end;

function TDeREInfoCotistasXmlWriter.Gerar_infoCotistas(A: TinfoCotistasD2102): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('infoCotistas');

  Result.AppendChild(AddNode(tcStr, '#10', 'tpDeclarante', 1, 1, 1,
    tpDeclaranteDeREToStr(A.tpDeclarante), DSC_TPDECLARANTE));

  Result.AppendChild(Gerar_classes(A.classes));
end;

initialization
  RegistrarWriterDeRE(teInfoCotistas, TDeREInfoCotistasXmlWriter);

end.
