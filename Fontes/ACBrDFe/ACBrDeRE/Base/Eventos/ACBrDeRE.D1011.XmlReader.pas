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

unit ACBrDeRE.D1011.XmlReader;

interface

uses
  Classes, SysUtils,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrXmlDocument,
  ACBrDeRE.Classes,
  ACBrDeRE.D1011.Classes,
  ACBrDeRE.Conversao,
  ACBrDeRE.XmlReader;

type
  { TDeREPGCCXmlReader - le o XML do evento evtPGCC (D-1011) }

  TDeREPGCCXmlReader = class(TDeREEventoXmlReader)
  private
    function Evt: TevtPGCC;

    procedure Ler_infoPGCC(const ANode: TACBrXmlNode; A: TinfoPGCCD1011);
    procedure Ler_infoContas(const ANode: TACBrXmlNode; A: TinfoContaCollectionD1011);
    procedure Ler_infoConta(const ANode: TACBrXmlNode; A: TinfoContaCollectionItemD1011);
  protected
    function GetNomeEvento: string; override;
    procedure Ler_Evento(const ANode: TACBrXmlNode); override;
  end;

implementation

uses
  ACBrUtil.Strings;

{ TDeREPGCCXmlReader }

function TDeREPGCCXmlReader.Evt: TevtPGCC;
begin
  Result := (DeRE as TDeRED1011).evtPGCC;
end;

function TDeREPGCCXmlReader.GetNomeEvento: string;
begin
  Result := 'evtPGCC';
end;

procedure TDeREPGCCXmlReader.Ler_Evento(const ANode: TACBrXmlNode);
var
  LNode: TACBrXmlNode;
begin
  Ler_ideEvento(ANode.Childrens.FindAnyNs('ideEvento'), Evt.ideEvento);
  Ler_ideContrib(ANode.Childrens.FindAnyNs('ideContrib'), Evt.ideContrib);
  Ler_idePeriodo(ANode.Childrens.FindAnyNs('idePeriodo'), Evt.idePeriodo);

  LNode := ANode.Childrens.FindAnyNs('infoPGCC');
  Evt.infoPGCC.TeminfoPGCC := Assigned(LNode);
  if Evt.infoPGCC.TeminfoPGCC then
    Ler_infoPGCC(LNode, Evt.infoPGCC);
end;

procedure TDeREPGCCXmlReader.Ler_infoPGCC(const ANode: TACBrXmlNode; A: TinfoPGCCD1011);
begin
  if not Assigned(ANode) then Exit;

  A.planoCtaRef := StrToplanoCtaRefDeRE(ObterConteudo(ANode.Childrens.FindAnyNs('planoCtaRef'), tcStr));
  A.freqEncerr := StrTofreqEncerrDeRE(ObterConteudo(ANode.Childrens.FindAnyNs('freqEncerr'), tcStr));

  Ler_infoContas(ANode.Childrens.FindAnyNs('infoContas'), A.infoContas);
end;

procedure TDeREPGCCXmlReader.Ler_infoContas(const ANode: TACBrXmlNode; A: TinfoContaCollectionD1011);
var
  LNodes: TACBrXmlNodeArray;
  i: Integer;
begin
  if not Assigned(ANode) then Exit;

  LNodes := ANode.Childrens.FindAllAnyNs('infoConta');
  for i := 0 to Length(LNodes) - 1 do
    Ler_infoConta(LNodes[i], A.New);
end;

procedure TDeREPGCCXmlReader.Ler_infoConta(const ANode: TACBrXmlNode; A: TinfoContaCollectionItemD1011);
var
  LNode: TACBrXmlNode;
begin
  if not Assigned(ANode) then Exit;

  A.cCta := ObterConteudo(ANode.Childrens.FindAnyNs('cCta'), tcStr);
  A.cCtaInterna := ObterConteudo(ANode.Childrens.FindAnyNs('cCtaInterna'), tcStr);
  A.cDbrMista := ObterConteudo(ANode.Childrens.FindAnyNs('cDbrMista'), tcStr);
  A.nomeCta := ObterConteudo(ANode.Childrens.FindAnyNs('nomeCta'), tcStr);
  A.indCta := StrToindCtaDeRE(ObterConteudo(ANode.Childrens.FindAnyNs('indCta'), tcStr));
  LNode := ANode.Childrens.FindAnyNs('descCta');
  A.TemdescCta := Assigned(LNode);
  if A.TemdescCta then
    A.descCta := ObterConteudo(LNode, tcStr);
  LNode := ANode.Childrens.FindAnyNs('cCtaSup');
  A.TemcCtaSup := Assigned(LNode);
  if A.TemcCtaSup then
    A.cCtaSup := ObterConteudo(LNode, tcStr);
  A.cCtaRef := ObterConteudo(ANode.Childrens.FindAnyNs('cCtaRef'), tcStr);
  A.nivelCta := ObterConteudo(ANode.Childrens.FindAnyNs('nivelCta'), tcInt);
  A.natCta := StrTonatCtaDeRE(ObterConteudo(ANode.Childrens.FindAnyNs('natCta'), tcStr));
  A.codNat := StrTocodNatDeRE(ObterConteudo(ANode.Childrens.FindAnyNs('codNat'), tcStr));
  LNode := ANode.Childrens.FindAnyNs('codTrib');
  A.TemcodTrib := Assigned(LNode);
  if A.TemcodTrib then
    A.codTrib := ObterConteudo(LNode, tcInt);
  LNode := ANode.Childrens.FindAnyNs('indTribISS');
  A.TemindTribISS := Assigned(LNode);
  if A.TemindTribISS then
    A.indTribISS := StrToindTribISSDeRE(ObterConteudo(LNode, tcStr));
  LNode := ANode.Childrens.FindAnyNs('idLeiDisp');
  A.TemidLeiDisp := Assigned(LNode);
  if A.TemidLeiDisp then
    A.idLeiDisp := ObterConteudo(LNode, tcStr);
  A.iniVig := ObterConteudo(ANode.Childrens.FindAnyNs('iniVig'), tcDat);
  LNode := ANode.Childrens.FindAnyNs('fimVig');
  A.TemfimVig := Assigned(LNode);
  if A.TemfimVig then
    A.fimVig := ObterConteudo(LNode, tcDat);
end;

initialization
  RegistrarReaderDeRE(tePGCC, TDeREPGCCXmlReader);

end.
