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

unit ACBrDeRE.D2101.XmlWriter;

interface

uses
  Classes, SysUtils,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrDFe.RTC.XmlWriter,
  ACBrXmlDocument,
  ACBrXmlWriter,
  ACBrDeRE.Classes,
  ACBrDeRE.D2101.Classes,
  ACBrDeRE.Conversao,
  ACBrDeRE.XmlWriter;

type
  { TDeREDebOpOfPublicXmlWriter - gera o evento evtDebOpOfPublic (D-2101) }

  TDeREDebOpOfPublicXmlWriter = class(TDeREXmlWriter)
  private
    function Evt: TevtDebOpOfPublic;

    function Gerar_detTitulo(A: TdetTituloCollectionItemD2101): TACBrXmlNode;
    function Gerar_infoTitulos(A: TinfoTitulosD2101): TACBrXmlNode;
    function Gerar_infoDebOpOfPublic(A: TinfoDebOpOfPublicD2101): TACBrXmlNode;
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

{ TDeREDebOpOfPublicXmlWriter }

function TDeREDebOpOfPublicXmlWriter.Evt: TevtDebOpOfPublic;
begin
  Result := (DeRE as TDeRED2101).evtDebOpOfPublic;
end;

function TDeREDebOpOfPublicXmlWriter.GetNameSpace: string;
begin
  Result := NamespaceDeRE(schevtDebOpOfPublic, VersaoDF);
end;

function TDeREDebOpOfPublicXmlWriter.Gerar_Evento: TACBrXmlNode;
begin
  Result := FDocument.CreateElement('evtDebOpOfPublic');
  Result.SetAttribute('id', Evt.id);

  Result.AppendChild(Gerar_ideEventoRecibo(Evt.ideEvento));
  Result.AppendChild(Gerar_ideContrib(Evt.ideContrib));
  Result.AppendChild(Gerar_idePeriodoApur(Evt.idePeriodo));

  if Evt.infoDebOpOfPublic.TeminfoDebOpOfPublic then
    Result.AppendChild(Gerar_infoDebOpOfPublic(Evt.infoDebOpOfPublic));
end;

function TDeREDebOpOfPublicXmlWriter.Gerar_detTitulo(A: TdetTituloCollectionItemD2101): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('detTitulo');

  Result.SetAttribute('idTitulo', A.idTitulo);

  Result.SetAttribute('cCta', A.cCta);

  if A.TemdescFundo then
    Result.AppendChild(AddNode(tcStr, '#10', 'descFundo', 1, 255, 1,
      A.descFundo, DSC_DESCFUNDO));

  Result.AppendChild(AddNode(tcStr, '#11', 'CNPJDevedor', 14, 14, 1,
    A.CNPJDevedor, DSC_CNPJDEVEDOR));

  Result.AppendChild(AddNode(tcDe2, '#12', 'vSaldoContIni', 1, 18, 1,
    A.vSaldoContIni, DSC_VSALDOCONTINI));

  Result.AppendChild(AddNode(tcDe2, '#13', 'vEntradas', 1, 18, 1,
    A.vEntradas, DSC_VENTRADAS));

  Result.AppendChild(AddNode(tcDe2, '#14', 'vSaidas', 1, 18, 1,
    A.vSaidas, DSC_VSAIDAS));

  Result.AppendChild(AddNode(tcDe2, '#15', 'vJurosRec', 1, 18, 1,
    A.vJurosRec, DSC_VJUROSREC));

  if A.TemvVarMensal then
    Result.AppendChild(AddNode(tcDe2, '#16', 'vVarMensal', 1, 19, 1,
      A.vVarMensal, DSC_VVARMENSAL));

  Result.AppendChild(AddNode(tcDe2, '#17', 'vSaldoContFin', 1, 18, 1,
    A.vSaldoContFin, DSC_VSALDOCONTFIN));

  Result.AppendChild(AddNode(tcDe2, '#18', 'vSelic', 1, 18, 1,
    A.vSelic, DSC_VSELIC));

  if A.TemvPisCofins then
    Result.AppendChild(AddNode(tcDe2, '#19', 'vPisCofins', 1, 18, 1,
      A.vPisCofins, DSC_VPISCOFINS));

  Result.AppendChild(AddNode(tcDe2, '#20', 'vApur', 1, 18, 1,
    A.vApur, DSC_VAPUR));
end;

function TDeREDebOpOfPublicXmlWriter.Gerar_infoTitulos(A: TinfoTitulosD2101): TACBrXmlNode;
var
  i: Integer;
begin
  Result := FDocument.CreateElement('infoTitulos');

  for i := 0 to A.detTitulo.Count - 1 do
    Result.AppendChild(Gerar_detTitulo(A.detTitulo[i]));
end;

function TDeREDebOpOfPublicXmlWriter.Gerar_infoDebOpOfPublic(A: TinfoDebOpOfPublicD2101): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('infoDebOpOfPublic');

  if A.semTitulos then
    Result.AppendChild(AddNode(tcStr, '#21', 'semTitulos', 1, 1, 1,
      '1', DSC_SEMTITULOS));

  if A.TeminfoTitulos then
    Result.AppendChild(Gerar_infoTitulos(A.infoTitulos));
end;

initialization
  RegistrarWriterDeRE(teDebOpOfPublic, TDeREDebOpOfPublicXmlWriter);

end.
