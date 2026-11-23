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

unit ACBrDeRE.D1011.XmlWriter;

interface

uses
  Classes, SysUtils,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrDFe.RTC.XmlWriter,
  ACBrXmlDocument,
  ACBrXmlWriter,
  ACBrDeRE.Classes,
  ACBrDeRE.D1011.Classes,
  ACBrDeRE.Conversao,
  ACBrDeRE.XmlWriter;

type
  { TDeREPGCCXmlWriter - gera o evento evtPGCC (D-1011) }

  TDeREPGCCXmlWriter = class(TDeREXmlWriter)
  private
    function Evt: TevtPGCC;

    function Gerar_infoPGCC: TACBrXmlNode;
    function Gerar_infoContas: TACBrXmlNode;
    function Gerar_infoConta(AItem: TinfoContaCollectionItemD1011): TACBrXmlNode;
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

{ TDeREPGCCXmlWriter }

function TDeREPGCCXmlWriter.Evt: TevtPGCC;
begin
  Result := (DeRE as TDeRED1011).evtPGCC;
end;

function TDeREPGCCXmlWriter.GetNameSpace: string;
begin
  Result := NamespaceDeRE(schevtPGCC, VersaoDF);
end;

function TDeREPGCCXmlWriter.Gerar_Evento: TACBrXmlNode;
begin
  Result := FDocument.CreateElement('evtPGCC');
  Result.SetAttribute('id', Evt.id);

  Result.AppendChild(Gerar_ideEvento(Evt.ideEvento));
  Result.AppendChild(Gerar_ideContrib(Evt.ideContrib));
  Result.AppendChild(Gerar_idePeriodo(Evt.idePeriodo));

  if Evt.infoPGCC.TeminfoPGCC then
    Result.AppendChild(Gerar_infoPGCC);
end;

function TDeREPGCCXmlWriter.Gerar_infoPGCC: TACBrXmlNode;
var
  LInfo: TinfoPGCCD1011;
begin
  LInfo := Evt.infoPGCC;

  Result := FDocument.CreateElement('infoPGCC');

  // COFI (6) so existe a partir do evtPGCC v1_0_4 (ve104)
  if (LInfo.planoCtaRef = pcrCOFI) and (VersaoDF < ve104) then
    wAlerta('#12', 'planoCtaRef', DSC_PLANOCTAREF,
      'Plano de contas referencial COFI so existe a partir da versao 1.0.4 do leiaute');

  Result.AppendChild(AddNode(tcStr, '#12', 'planoCtaRef', 1, 1, 1,
    planoCtaRefDeREToStr(LInfo.planoCtaRef), DSC_PLANOCTAREF));

  Result.AppendChild(AddNode(tcStr, '#13', 'freqEncerr', 1, 1, 1,
    freqEncerrDeREToStr(LInfo.freqEncerr), DSC_FREQENCERR));

  Result.AppendChild(Gerar_infoContas);
end;

function TDeREPGCCXmlWriter.Gerar_infoContas: TACBrXmlNode;
var
  LInfo: TinfoPGCCD1011;
  i: Integer;
begin
  LInfo := Evt.infoPGCC;

  Result := FDocument.CreateElement('infoContas');

  for i := 0 to LInfo.infoContas.Count - 1 do
    Result.AppendChild(Gerar_infoConta(LInfo.infoContas[i]));
end;

function TDeREPGCCXmlWriter.Gerar_infoConta(AItem: TinfoContaCollectionItemD1011): TACBrXmlNode;
begin
  Result := FDocument.CreateElement('infoConta');

  Result.AppendChild(AddNode(tcStr, '#14', 'cCta', 1, 53, 1,
    AItem.cCta, DSC_CCTA));

  Result.AppendChild(AddNode(tcStr, '#15', 'cCtaInterna', 1, 50, 1,
    AItem.cCtaInterna, DSC_CCTAINTERNA));

  Result.AppendChild(AddNode(tcStr, '#16', 'cDbrMista', 3, 3, 1,
    AItem.cDbrMista, DSC_CDBRMISTA));

  Result.AppendChild(AddNode(tcStr, '#17', 'nomeCta', 1, 100, 1,
    AItem.nomeCta, DSC_NOMECTA));

  Result.AppendChild(AddNode(tcStr, '#18', 'indCta', 1, 1, 1,
    indCtaDeREToStr(AItem.indCta), DSC_INDCTA));

  if AItem.TemdescCta then
    Result.AppendChild(AddNode(tcStr, '#19', 'descCta', 1, 600, 1,
      AItem.descCta, DSC_DESCCTA));

  if AItem.TemcCtaSup then
    Result.AppendChild(AddNode(tcStr, '#20', 'cCtaSup', 1, 53, 1,
      AItem.cCtaSup, DSC_CCTASUP));

  // cCtaRef e obrigatorio ate o evtPGCC v1_0_3 e opcional a partir da v1_0_4 (ve104)
  if (VersaoDF < ve104) or (AItem.cCtaRef <> '') then
    Result.AppendChild(AddNode(tcStr, '#21', 'cCtaRef', 1, 13, 1,
      AItem.cCtaRef, DSC_CCTAREF));

  Result.AppendChild(AddNode(tcInt, '#22', 'nivelCta', 1, 2, 1,
    AItem.nivelCta, DSC_NIVELCTA));

  Result.AppendChild(AddNode(tcStr, '#23', 'natCta', 1, 1, 1,
    natCtaDeREToStr(AItem.natCta), DSC_NATCTA));

  // codNat 6-Compensacao e 7-Outras so existem a partir do evtPGCC v1_0_4 (ve104)
  if (AItem.codNat in [cnCompensacao, cnOutras]) and (VersaoDF < ve104) then
    wAlerta('#24', 'codNat', DSC_CODNAT,
      'Codigo da natureza 6 e 7 so existem a partir da versao 1.0.4 do leiaute');

  Result.AppendChild(AddNode(tcStr, '#24', 'codNat', 1, 1, 1,
    codNatDeREToStr(AItem.codNat), DSC_CODNAT));

  if AItem.TemcodTrib then
    Result.AppendChild(AddNode(tcInt, '#25', 'codTrib', 1, 9, 1,
      AItem.codTrib, DSC_CODTRIB));

  if AItem.TemindTribISS then
    Result.AppendChild(AddNode(tcStr, '#26', 'indTribISS', 1, 1, 1,
      indTribISSDeREToStr(AItem.indTribISS), DSC_INDTRIBISS));

  if AItem.TemidLeiDisp then
    Result.AppendChild(AddNode(tcStr, '#27', 'idLeiDisp', 5, 5, 1,
      AItem.idLeiDisp, DSC_IDLEIDISP));

  Result.AppendChild(AddNode(tcDat, '#28', 'iniVig', 10, 10, 1,
    AItem.iniVig, DSC_INIVIG));

  if AItem.TemfimVig then
    Result.AppendChild(AddNode(tcDat, '#29', 'fimVig', 10, 10, 1,
      AItem.fimVig, DSC_FIMVIG));
end;

initialization
  RegistrarWriterDeRE(tePGCC, TDeREPGCCXmlWriter);

end.
