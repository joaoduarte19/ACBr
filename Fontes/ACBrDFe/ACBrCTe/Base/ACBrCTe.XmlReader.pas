{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2024 Daniel Simoes de Almeida               }
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

unit ACBrCTe.XmlReader;

interface

uses
  Classes, SysUtils, StrUtils, 
  ACBrXmlDocument,
  ACBrXmlReader,
  ACBrDFe.RTC.XmlReader,
  ACBrCTe.Classes;

type
  TCTeXmlReader = class(TDFeRTCXmlReader)
  private
    FCTe: TCTe;

    procedure ValidarXML(out infCTeNode: TACBrXmlNode; out CTeNode: TACBrXmlNode);
    procedure Ler_ProtCTe(const ANode: TACBrXmlNode);
    procedure Ler_InfCTe(const ANode: TACBrXmlNode);
    procedure Ler_Ide(const ANode: TACBrXmlNode);
    procedure Ler_gMultaJuros(const ANode: TACBrXmlNode; gMultaJuros: TgMultaJuros);

    procedure Ler_CTe(const ANode: TACBrXmlNode);
    procedure Ler_CTeOS(const ANode: TACBrXmlNode);
    procedure Ler_CTeSimp(const ANode: TACBrXmlNode);
    procedure Ler_GTVe(const ANode: TACBrXmlNode);

    procedure Ler_InfPercurso(ANode: TACBrXmlNode);
    procedure Ler_Toma03(ANode: TACBrXmlNode);
    procedure Ler_Toma04(ANode: TACBrXmlNode);
    procedure Ler_Toma04EnderToma(ANode: TACBrXmlNode);
    procedure Ler_Compl(ANode: TACBrXmlNode);
    procedure Ler_Fluxo(ANode: TACBrXmlNode);
    procedure Ler_Entrega(ANode: TACBrXmlNode);
    procedure Ler_ObsCont(ANodeArr: TACBrXmlNodeArray);
    procedure Ler_ObsFisco(ANodeArr: TACBrXmlNodeArray);
    procedure Ler_Emit(ANode: TACBrXmlNode);
    procedure Ler_EnderEmit(ANode: TACBrXmlNode);
    procedure Ler_Toma(ANode: TACBrXmlNode);
    procedure Ler_TomaEnderToma(ANode: TACBrXmlNode);
    procedure Ler_Rem(ANode: TACBrXmlNode);
    procedure Ler_EnderReme(ANode: TACBrXmlNode);
    procedure Ler_Exped(ANode: TACBrXmlNode);
    procedure Ler_EnderExped(ANode: TACBrXmlNode);
    procedure Ler_Receb(ANode: TACBrXmlNode);
    procedure Ler_EnderReceb(ANode: TACBrXmlNode);
    procedure Ler_Dest(ANode: TACBrXmlNode);
    procedure Ler_EnderDest(ANode: TACBrXmlNode);
    procedure Ler_Origem(ANode: TACBrXmlNode);
    procedure Ler_Destino(ANode: TACBrXmlNode);
    procedure Ler_DetGTVe(ANode: TACBrXmlNode);
    procedure Ler_InfEspecie(ANodeArr: TACBrXmlNodeArray);
    procedure Ler_InfVeiculo(ANodeArr: TACBrXmlNodeArray);
    procedure Ler_VPrest(ANode: TACBrXmlNode);
    procedure Ler_Comp(ANodeArr: TACBrXmlNodeArray; comp: TCompCollection);
    procedure Ler_Imp(ANode: TACBrXmlNode);
    procedure Ler_InfCarga(ANode: TACBrXmlNode; infCarga: TInfCarga);
    procedure Ler_InfCTeNorm(ANode: TACBrXmlNode);
    procedure Ler_InfCTeComp(ANode: TACBrXmlNode);
    procedure Ler_InfCTeAnu(ANode: TACBrXmlNode);
    procedure Ler_DocAnt(ANode: TACBrXmlNode);
    procedure Ler_Seg(segArr: TACBrXmlNodeArray);
    procedure Ler_Rodo(ANode: TACBrXmlNode; rodo: TRodo);
    procedure Ler_RodoOS(ANode: TACBrXmlNode);
    procedure Ler_Aereo(ANode: TACBrXmlNode; aereo: TAereo);
    procedure Ler_Aquav(ANode: TACBrXmlNode; aquav: TAquav);
    procedure Ler_Ferrov(ANode: TACBrXmlNode);
    procedure Ler_Duto(ANode: TACBrXmlNode);
    procedure Ler_MultiModal(ANode: TACBrXmlNode);
    procedure Ler_VeicNovos(veicArr: TACBrXmlNodeArray);
    procedure Ler_Cobr(ANode: TACBrXmlNode);
    procedure Ler_InfGTVe(infGTVeArr: TACBrXmlNodeArray);
    procedure Ler_InfCTeSub(infCteSubNd: TACBrXmlNode; infCTeSub: TInfCteSub);
    procedure Ler_Signature(SignatureNd: TACBrXmlNode);
    procedure Ler_InfCTeSupl(infCTeSuplNd: TACBrXmlNode);
    procedure Ler_AutXML(ANode: TACBrXmlNode);
    procedure Ler_InfRespTec(ANode: TACBrXmlNode);
    procedure Ler_Total(ANode: TACBrXmlNode);
    procedure Ler_InfModal(ANode: TACBrXmlNode);
    procedure Ler_Det(ANode: TACBrXmlNode);
    procedure Ler_InfNFe(ANode: TACBrXmlNode; infNFe: TInfNFeCollection);
    procedure Ler_InfDCe(ANode: TACBrXmlNode);
    procedure Ler_InfDocAnt(ANode: TACBrXmlNode; infDocAnt: TinfDocAntCollection);
  public
    constructor Create(AOwner: TCTe); reintroduce;

    function LerXml: Boolean; override;

    property CTe: TCTe read FCTe;
  end;

implementation

uses
  ACBrUtil.Base, 
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrCTe.Conversao;

{ TCTeXmlReader }

constructor TCTeXmlReader.Create(AOwner: TCTe);
begin
  inherited Create;

  FCTe := AOwner;
end;

procedure TCTeXmlReader.Ler_Aereo(ANode: TACBrXmlNode; aereo: TAereo);
var
  AuxNode, AuxNode2: TACBrXmlNode;
  AuxArr: TACBrXmlNodeArray;
  i: integer;
  Ok: Boolean;
begin
  if not Assigned(ANode) then exit;

  aereo.nMinu := ObterConteudo(ANode.Childrens.FindAnyNs('nMinu'), tcInt);
  aereo.nOCA := ObterConteudo(ANode.Childrens.FindAnyNs('nOCA'), tcStr);
  aereo.dPrevAereo := ObterConteudo(ANode.Childrens.FindAnyNs('dPrevAereo'), tcDat);
  aereo.xLAgEmi := ObterConteudo(ANode.Childrens.FindAnyNs('xLAgEmi'), tcStr);
  aereo.IdT := ObterConteudo(ANode.Childrens.FindAnyNs('IdT'), tcStr);

  AuxNode := ANode.Childrens.FindAnyNs('tarifa');
  if Assigned(AuxNode) then
  begin
    aereo.tarifa.CL := ObterConteudo(AuxNode.Childrens.FindAnyNs('CL'), tcStr);
    aereo.tarifa.cTar := ObterConteudo(AuxNode.Childrens.FindAnyNs('cTar'), tcStr);
    aereo.tarifa.vTar := ObterConteudo(AuxNode.Childrens.FindAnyNs('vTar'), tcDe2);
  end;

  AuxNode := ANode.Childrens.FindAnyNs('natCarga');
  if Assigned(AuxNode) then
  begin
    aereo.natCarga.xDime := ObterConteudo(AuxNode.Childrens.FindAnyNs('xDime'), tcStr);
    aereo.natCarga.cIMP := ObterConteudo(AuxNode.Childrens.FindAnyNs('cIMP'), tcStr);

    aereo.natCarga.cinfManu.Clear;
    for i := 0 to AuxNode.Childrens.Count-1 do
    begin
      if AuxNode.Childrens[i].Name = 'cInfManu' then
      begin
        with aereo.natCarga.cInfManu.New do
          nInfManu := StrToTpInfManu(ok, ObterConteudo(AuxNode.Childrens[i], tcStr));
      end;
    end;
  end;

  AuxArr := ANode.Childrens.FindAllAnyNs('peri');
  aereo.peri.Clear;
  for i := 0 to Length(AuxArr)-1 do
  begin
    aereo.peri.New;
    aereo.peri[i].nONU := ObterConteudo(AuxArr[i].Childrens.FindAnyNs('nONU'), tcStr);
    aereo.peri[i].qTotEmb := ObterConteudo(AuxArr[i].Childrens.FindAnyNs('qTotEmb'), tcStr);

    AuxNode2 := AuxArr[i].Childrens.FindAnyNs('infTotAP');
    if Assigned(AuxNode2) then
    begin
      aereo.peri[i].qTotProd := ObterConteudo(AuxNode2.Childrens.FindAnyNs('qTotProd'), tcStr);
      aereo.peri[i].uniAP := StrToUniMed(Ok, ObterConteudo(AuxNode2.Childrens.FindAnyNs('uniAP'), tcStr));
    end;
  end;
end;

procedure TCTeXmlReader.Ler_Aquav(ANode: TACBrXmlNode; aquav: TAquav);
var
  OK: boolean;
  infDocND: TACBrXmlNode;
  balsaArr, detContArr, lacreArr, infArr: TACBrXmlNodeArray;
  i, j: Integer;
  lAux: String;
begin
  if not Assigned(ANode) then exit;

  aquav.vPrest := ObterConteudo(ANode.Childrens.FindAnyNs('vPrest'), tcDe2);
  aquav.vAFRMM := ObterConteudo(ANode.Childrens.FindAnyNs('vAFRMM'), tcDe2);
  aquav.nBooking := ObterConteudo(ANode.Childrens.FindAnyNs('nBooking'), tcStr);
  aquav.nCtrl := ObterConteudo(ANode.Childrens.FindAnyNs('nCtrl'), tcStr);
  aquav.xNavio := ObterConteudo(ANode.Childrens.FindAnyNs('xNavio'), tcStr);
  aquav.nViag := ObterConteudo(ANode.Childrens.FindAnyNs('nViag'), tcStr);
  aquav.direc := StrToTpDirecao(ok, ObterConteudo(ANode.Childrens.FindAnyNs('direc'), tcStr));
  aquav.prtEmb := ObterConteudo(ANode.Childrens.FindAnyNs('prtEmb'), tcStr);
  aquav.prtTrans := ObterConteudo(ANode.Childrens.FindAnyNs('prtTrans'), tcStr);
  aquav.prtDest := ObterConteudo(ANode.Childrens.FindAnyNs('prtDest'), tcStr);
  lAux := '';
  lAux := ObterConteudo(ANode.Childrens.FindAnyNs('tpNav'), tcStr);
  if lAux <> '' then
    aquav.tpNav := StrToTpNavegacao(lAux);
  aquav.irin := ObterConteudo(ANode.Childrens.FindAnyNs('irin'), tcStr);

  aquav.balsa.Clear;
  balsaArr := ANode.Childrens.FindAllAnyNs('balsa');
  for i := 0 to Length(balsaArr)-1 do
  begin
    aquav.balsa.New;
    aquav.balsa[i].xBalsa := ObterConteudo(balsaArr[i].Childrens.FindAnyNs('xBalsa'), tcStr);
  end;

  aquav.detCont.Clear;
  detContArr := ANode.Childrens.FindAllAnyNs('detCont');
  for i := 0 to Length(detContArr)-1 do
  begin
    aquav.detCont.New;
    aquav.detCont[i].nCont := ObterConteudo(detContArr[i].Childrens.FindAnyNs('nCont'), tcStr);

    aquav.detCont[i].Lacre.Clear;
    lacreArr := detContArr[i].Childrens.FindAllAnyNs('lacre');
    for j := 0 to Length(lacreArr)-1 do
    begin
      aquav.detCont[i].Lacre.New;
      aquav.detCont[i].Lacre[j].nLacre := ObterConteudo(lacreArr[j].Childrens.FindAnyNs('nLacre'), tcStr);
    end;

    infDocND := detContArr[i].Childrens.FindAnyNs('infDoc');
    if Assigned(infDocND) then
    begin
      infArr := infDocND.Childrens.FindAllAnyNs('infNF');
      for j := 0 to Length(infArr)-1 do
      begin
        aquav.detCont[i].infDoc.infNF.New;
        aquav.detCont[i].infDoc.infNF[j].serie := ObterConteudo(infArr[j].Childrens.FindAnyNs('serie'), tcStr);
        aquav.detCont[i].infDoc.infNF[j].nDoc := ObterConteudo(infArr[j].Childrens.FindAnyNs('nDoc'), tcStr);
        aquav.detCont[i].infDoc.infNF[j].unidRat := ObterConteudo(infArr[j].Childrens.FindAnyNs('unidRat'), tcDe2);
      end;

      infArr := infDocND.Childrens.FindAllAnyNs('infNFe');
      for j := 0 to Length(infArr)-1 do
      begin
        aquav.detCont[i].infDoc.infNFe.New;
        aquav.detCont[i].infDoc.infNFe[j].chave := ObterConteudo(infArr[j].Childrens.FindAnyNs('chave'), tcStr);
        aquav.detCont[i].infDoc.infNFe[j].unidRat := ObterConteudo(infArr[j].Childrens.FIndAnyNs('unidRat'), tcDe2);
      end;
    end;
  end;
end;

procedure TCTeXmlReader.Ler_AutXML(ANode: TACBrXmlNode);
var
  autXMLArr: TACBrXmlNodeArray;
  i: Integer;
begin
  if not Assigned(ANode) then exit;

  autXMLArr := ANode.Childrens.FindAllAnyNs('autXML');
  CTe.autXML.Clear;

  for i := 0 to Length(autXMLArr)-1 do
  begin
    CTe.autXML.New;
    CTe.autXML[i].CNPJCPF := ObterCNPJCPF(autXMLArr[i]);
  end;
end;

procedure TCTeXmlReader.Ler_Cobr(ANode: TACBrXmlNode);
var
  dupArr: TACBrXmlNodeArray;
  fatND: TACBrXmlNode;
  i: Integer;
begin
  if not Assigned(ANode) then exit;

  fatND := ANode.Childrens.FindAnyNs('fat');
  if Assigned(fatND) then
  begin
    CTe.infCTeNorm.cobr.fat.nFat := ObterConteudo(fatND.Childrens.FindAnyNs('nFat'), tcStr);
    CTe.infCTeNorm.cobr.fat.vOrig := ObterConteudo(fatND.Childrens.FindAnyNs('vOrig'), tcDe2);
    CTe.infCTeNorm.cobr.fat.vDesc := ObterConteudo(fatND.Childrens.FindAnyNs('vDesc'), tcDe2);
    CTe.infCTeNorm.cobr.fat.vLiq := ObterConteudo(fatND.Childrens.FindAnyNs('vLiq'), tcDe2);
  end;

  dupArr := ANode.Childrens.FindAllAnyNs('dup');
  CTe.infCTeNorm.cobr.dup.Clear;
  for i := 0 to Length(dupArr)-1 do
  begin
    CTe.infCTeNorm.cobr.dup.New;
    CTe.infCTeNorm.cobr.dup[i].nDup := ObterConteudo(dupArr[i].Childrens.FindAnyNs('nDup'), tcStr);
    CTe.infCTeNorm.cobr.dup[i].dVenc := ObterConteudo(dupArr[i].Childrens.FindANyNs('dVenc'), tcDat);
    CTe.infCTeNorm.cobr.dup[i].vDup := ObterConteudo(dupArr[i].Childrens.FindAnyNs('vDup'), tcDe2);
  end;
end;

procedure TCTeXmlReader.Ler_Comp(ANodeArr: TACBrXmlNodeArray; comp: TCompCollection);
var
  i: Integer;
begin
  Comp.Clear;
  for i := 0 to Length(ANodeArr)-1 do
  begin
    Comp.New;
    Comp[i].xNome := ObterConteudo(ANodeArr[i].Childrens.FindAnyNs('xNome'), tcStr);
    Comp[i].vComp := ObterConteudo(ANodeArr[i].Childrens.FindAnyNs('vComp'), tcDe2);
  end;
end;

procedure TCTeXmlReader.Ler_Compl(ANode: TACBrXmlNode);
begin
  if not Assigned(ANode) then exit;

  CTe.Compl.xCaracAd := ObterConteudo(ANode.Childrens.FindAnyNs('xCaracAd'), tcStr);
  CTe.Compl.xCaracSer := ObterConteudo(ANode.Childrens.FindAnyNs('xCaracSer'), tcStr);
  CTe.Compl.xEmi := ObterConteudo(ANode.Childrens.FindAnyNs('xEmi'), tcStr);
  CTe.Compl.origCalc := ObterConteudo(ANode.Childrens.FindAnyNs('origCalc'), tcStr);
  CTe.Compl.destCalc := ObterConteudo(ANode.Childrens.FindAnyNs('destCalc'), tcStr);
  CTe.Compl.xObs := ObterConteudo(ANode.Childrens.FindAnyNs('xObs'), tcStr);

  Ler_Fluxo(ANode.Childrens.FindAnyNs('fluxo'));
  Ler_Entrega(ANode.Childrens.FindAnyNs('Entrega'));
  Ler_ObsCont(ANode.Childrens.FindAllAnyNs('ObsCont'));
  Ler_ObsFisco(ANode.Childrens.FindAllAnyNs('ObsFisco'));
end;

procedure TCTeXmlReader.Ler_Dest(ANode: TACBrXmlNode);
begin
  if not Assigned(ANode) then exit;

  CTe.Dest.CNPJCPF := ObterCNPJCPF(ANode);
  CTe.Dest.IE := ObterConteudo(ANode.Childrens.FindAnyNs('IE'), tcStr);
  CTe.Dest.xNome := ObterConteudo(ANode.Childrens.FindAnyNs('xNome'), tcStr);
  CTe.Dest.fone := ObterConteudo(ANode.Childrens.FindANyNs('fone'), tcStr);
  CTe.Dest.ISUF := ObterConteudo(ANode.Childrens.FindAnyNs('ISUF'), tcStr);
  CTe.Dest.email := ObterConteudo(ANode.Childrens.FindAnyNs('email'), tcStr);

  Ler_EnderDest(ANode.Childrens.FindAnyNs('enderDest'));
end;

procedure TCTeXmlReader.Ler_Destino(ANode: TACBrXmlNode);
begin
  if not Assigned(ANode) then exit;

  CTe.destino.xLgr := ObterConteudo(ANode.Childrens.FindAnyNs('xLgr'), tcStr);
  CTe.destino.Nro := ObterConteudo(ANode.Childrens.FindAnyNs('nro'), tcStr);
  CTe.destino.xCpl := ObterConteudo(ANode.Childrens.FindAnyNs('xCpl'), tcStr);
  CTe.destino.xBairro := ObterConteudo(ANode.Childrens.FindAnyNs('xBairro'), tcStr);
  CTe.destino.cMun := ObterConteudo(ANode.Childrens.FindAnyNs('cMun'), tcInt);
  CTe.destino.xMun := ObterConteudo(ANode.Childrens.FindAnyNs('xMun'), tcStr);
  CTe.destino.CEP := ObterConteudo(ANode.Childrens.FindAnyNs('CEP'), tcInt);
  CTe.destino.UF := ObterConteudo(ANode.Childrens.FindAnyNs('UF'), tcStr);
  CTe.destino.fone := ObterConteudo(ANode.Childrens.FindAnyNs('fone'), tcStr);
end;

procedure TCTeXmlReader.Ler_Det(ANode: TACBrXmlNode);
var
  detArr: TACBrXmlNodeArray;
  i: Integer;
begin
  if not Assigned(ANode) then exit;

  detArr := ANode.Childrens.FindAllAnyNs('det');
  CTe.det.Clear;

  for i := 0 to Length(detArr)-1 do
  begin
    CTe.det.New;

    CTe.det[i].cMunIni := ObterConteudo(detArr[i].Childrens.FindAnyNs('cMunIni'), tcInt);
    CTe.det[i].xMunIni := ObterConteudo(detArr[i].Childrens.FindAnyNs('xMunIni'), tcStr);
    CTe.det[i].cMunFim := ObterConteudo(detArr[i].Childrens.FindAnyNs('cMunFim'), tcInt);
    CTe.det[i].xMunFim := ObterConteudo(detArr[i].Childrens.FindAnyNs('xMunFim'), tcStr);
    CTe.det[i].vPrest := ObterConteudo(detArr[i].Childrens.FindAnyNs('vPrest'), tcDe2);
    CTe.det[i].vPrestLiq := ObterConteudo(detArr[i].Childrens.FindAnyNs('vPrestLiq'), tcDe2);
    CTe.det[i].vRec := ObterConteudo(detArr[i].Childrens.FindAnyNs('vRec'), tcDe2);

    Ler_Comp(detArr[i].Childrens.FindAllAnyNs('Comp'), CTe.det[i].Comp);
    Ler_IBSCBS(detArr[i].Childrens.FindAnyNs('IBSCBS'), CTe.det[i].IBSCBS);
    Ler_InfNFe(detArr[i], CTe.det[i].infNFe);
    Ler_InfDocAnt(detArr[i], CTe.det[i].infdocAnt);
  end;
end;

procedure TCTeXmlReader.Ler_DetGTVe(ANode: TACBrXmlNode);
begin
  if not Assigned(ANode) then exit;

  CTe.detGTV.qCarga := ObterConteudo(ANode.Childrens.FindAnyNs('qCarga'), tcDe4);

  Ler_InfEspecie(ANode.Childrens.FindAllAnyNs('infEspecie'));
  Ler_InfVeiculo(ANode.Childrens.FindAllAnyNs('infVeiculo'));
end;

procedure TCTeXmlReader.Ler_DocAnt(ANode: TACBrXmlNode);
var
  emiDocArr, idDocArr, idDocAntArr: TACBrXMLNodeArray;
  i, j, k: Integer;
  Ok: Boolean;
begin
  if not Assigned(ANode) then exit;

  CTe.infCTeNorm.docAnt.emiDocAnt.Clear;
  emiDocArr := ANode.Childrens.FindAllAnyNs('emiDocAnt');
  for i := 0 to Length(emiDocArr)-1 do
  begin
    CTe.infCTeNorm.docAnt.emiDocAnt.New;
    CTe.infCTeNorm.docAnt.emiDocAnt[i].CNPJCPF := ObterCNPJCPF(emiDocArr[i]);
    CTe.infCTeNorm.docAnt.emiDocAnt[i].IE := ObterConteudo(emiDocArr[i].Childrens.FindAnyNs('IE'), tcStr);
    CTe.infCTeNorm.docAnt.emiDocAnt[i].UF := ObterConteudo(emiDocArr[i].Childrens.FindAnyNs('UF'), tcStr);
    CTe.infCTeNorm.docAnt.emiDocAnt[i].xNome := ObterConteudo(emiDocArr[i].Childrens.FindAnyNs('xNome'), tcStr);

    idDocAntArr := emiDocArr[i].Childrens.FindAllAnyNs('idDocAnt');
    for j := 0 to Length(idDocAntArr)-1 do
    begin
      CTe.infCTeNorm.docAnt.emiDocAnt[i].idDocAnt.New;

      idDocArr := idDocAntArr[j].Childrens.FindAllAnyNs('idDocAntPap');
      for k:=0 to Length(idDocArr)-1 do
      begin
        CTe.infCTeNorm.docAnt.emiDocAnt[i].idDocAnt[j].idDocAntPap.New;
        CTe.infCTeNorm.docAnt.emiDocAnt[i].idDocAnt[j].idDocAntPap[k].tpDoc := StrToTpDocumentoAnterior(ok, ObterConteudo(idDocArr[k].Childrens.FindAnyNs('tpDoc'), tcStr));
        CTe.infCTeNorm.docAnt.emiDocAnt[i].idDocAnt[j].idDocAntPap[k].serie := ObterConteudo(idDocArr[k].Childrens.FindAnyNs('serie'), tcStr);
        CTe.infCTeNorm.docAnt.emiDocAnt[i].idDocAnt[j].idDocAntPap[k].subser := ObterConteudo(idDocArr[k].Childrens.FindAnyNs('subser'), tcStr);
        CTe.infCTeNorm.docAnt.emiDocAnt[i].idDocAnt[j].idDocAntPap[k].nDoc := ObterConteudo(idDocArr[k].Childrens.FindAnyNs('nDoc'), tcStr);
        CTe.infCTeNorm.docAnt.emiDocAnt[i].idDocAnt[j].idDocAntPap[k].dEmi := ObterConteudo(idDocArr[k].Childrens.FindAnyNs('dEmi'), tcDat);
      end;

      idDocArr := idDocAntArr[j].Childrens.FindAllAnyNs('idDocAntEle');
      for k := 0 to Length(idDocArr)-1 do
      begin
        CTe.infCTeNorm.docAnt.emiDocAnt[i].idDocAnt[j].idDocAntEle.New;
        CTe.infCTeNorm.docAnt.emiDocAnt[i].idDocAnt[j].idDocAntEle[k].chCTe := ObterConteudo(idDocArr[k].Childrens.FindAnyNs('chCTe'), tcStr);
      end;
    end;
  end;
end;

procedure TCTeXmlReader.Ler_Duto(ANode: TACBrXmlNode);
var
  OK: Boolean;
begin
  if not Assigned(ANode) then exit;

  CTe.infCTeNorm.duto.vTar := ObterConteudo(ANode.Childrens.FindAnyNs('vTar'), tcDe6);
  CTe.infCTeNorm.duto.dIni := ObterConteudo(ANode.Childrens.FindAnyNs('dIni'), tcDat);
  CTe.infCTeNorm.duto.dFim := ObterConteudo(ANode.Childrens.FindAnyNs('dFim'), tcDat);
  CTe.infCTeNorm.duto.classDuto := StrToclassDuto(Ok, ObterConteudo(ANode.Childrens.FindAnyNs('classDuto'), tcStr));
  CTe.infCTeNorm.duto.tpContratacao := StrTotpContratacao(Ok, ObterConteudo(ANode.Childrens.FindAnyNs('tpContratacao'), tcStr));
  CTe.infCTeNorm.duto.codPontoEntrada := ObterConteudo(ANode.Childrens.FindAnyNs('codPontoEntrada'), tcStr);
  CTe.infCTeNorm.duto.codPontoSaida := ObterConteudo(ANode.Childrens.FindAnyNs('codPontoSaida'), tcStr);
  CTe.infCTeNorm.duto.nContrato := ObterConteudo(ANode.Childrens.FindAnyNs('nContrato'), tcStr);
end;

procedure TCTeXmlReader.Ler_Emit(ANode: TACBrXmlNode);
var
  OK: Boolean;
begin
  if not Assigned(ANode) then exit;

  CTe.emit.CNPJ := ObterCNPJCPF(ANode);
  CTe.emit.IE := ObterConteudo(ANode.Childrens.FindAnyNs('IE'), tcStr);
  CTe.emit.IEST := ObterConteudo(ANode.Childrens.FindAnyNs('IEST'), tcStr);
  CTe.emit.xNome := ObterConteudo(ANode.Childrens.FindAnyNs('xNome'), tcStr);
  CTe.emit.xFant := ObterConteudo(ANode.Childrens.FindAnyNs('xFant'), tcStr);
  CTe.emit.CRT := StrToCRTCTe(ok, ObterConteudo(ANode.Childrens.FindAnyNs('CRT'), tcStr));
  CTe.Emit.ISUFEmit:= ObterConteudo(ANode.Childrens.Find('ISUFEmit'), tcStr);

  Ler_EnderEmit(ANode.Childrens.FindAnyNs('enderEmit'));
  CTe.Emit.tpRegimeIBSCBS := StrTotpRegimeIBSCBS(ObterConteudo(ANode.Childrens.Find('tpRegimeIBSCBS'), tcStr));
end;

procedure TCTeXmlReader.Ler_EnderDest(ANode: TACBrXmlNode);
begin
  if not Assigned(ANode) then exit;

  CTe.Dest.EnderDest.xLgr := ObterConteudo(ANode.Childrens.FindAnyNs('xLgr'), tcStr);
  CTe.Dest.EnderDest.Nro := ObterConteudo(ANode.Childrens.FindAnyNs('nro'), tcStr);
  CTe.Dest.EnderDest.xCpl := ObterConteudo(ANode.Childrens.FindAnyNs('xCpl'), tcStr);
  CTe.Dest.EnderDest.xBairro := ObterConteudo(ANode.Childrens.FindAnyNs('xBairro'), tcStr);
  CTe.Dest.EnderDest.cMun := ObterConteudo(ANode.Childrens.FindAnyNs('cMun'), tcInt);
  CTe.Dest.EnderDest.xMun := ObterConteudo(ANode.Childrens.FindAnyNs('xMun'), tcStr);
  CTe.Dest.EnderDest.CEP := ObterConteudo(ANode.Childrens.FindAnyNs('CEP'), tcInt);
  CTe.Dest.EnderDest.UF := ObterConteudo(ANode.Childrens.FindAnyNs('UF'), tcStr);
  CTe.Dest.EnderDest.cPais := ObterConteudo(ANode.Childrens.FindAnyNs('cPais'), tcInt);
  CTe.Dest.EnderDest.xPais := ObterConteudo(ANode.Childrens.FindAnyNs('xPais'), tcStr);
end;

procedure TCTeXmlReader.Ler_EnderEmit(ANode: TACBrXmlNode);
begin
  if not Assigned(ANode) then exit;

  CTe.emit.enderemit.xLgr := ObterConteudo(ANode.Childrens.FindAnyNs('xLgr'), tcStr);
  CTe.emit.enderemit.Nro := ObterConteudo(ANode.Childrens.FindAnyNs('nro'), tcStr);
  CTe.emit.enderemit.xCpl := ObterConteudo(ANode.Childrens.FindAnyNs('xCpl'), tcStr);
  CTe.emit.enderemit.xBairro := ObterConteudo(ANode.Childrens.FindAnyNs('xBairro'), tcStr);
  CTe.emit.enderemit.cMun := ObterConteudo(ANode.Childrens.FindAnyNs('cMun'), tcInt);
  CTe.emit.enderemit.xMun := ObterConteudo(ANode.Childrens.FindANyNs('xMun'), tcStr);
  CTe.emit.enderemit.CEP := ObterConteudo(ANode.Childrens.FindAnyNs('CEP'), tcInt);
  CTe.emit.enderemit.UF := ObterConteudo(ANode.Childrens.FindAnyNs('UF'), tcStr);
  CTe.emit.enderemit.fone := ObterConteudo(ANode.Childrens.FindAnyNs('fone'), tcStr);
end;

procedure TCTeXmlReader.Ler_EnderExped(ANode: TACBrXmlNode);
begin
  if not Assigned(ANode) then exit;

  CTe.Exped.EnderExped.xLgr := ObterConteudo(ANode.Childrens.FindAnyNs('xLgr'), tcStr);
  CTe.Exped.EnderExped.Nro := ObterConteudo(ANode.Childrens.FindAnyNs('nro'), tcStr);
  CTe.Exped.EnderExped.xCpl := ObterConteudo(ANode.Childrens.FindAnyNs('xCpl'), tcStr);
  CTe.Exped.EnderExped.xBairro := ObterConteudo(ANode.CHildrens.FindANyNs('xBairro'), tcStr);
  CTe.Exped.EnderExped.cMun := ObterConteudo(ANode.Childrens.FindAnyNs('cMun'),tcInt);
  CTe.Exped.EnderExped.xMun := ObterConteudo(ANode.Childrens.FindAnyNS('xMun'), tcStr);
  CTe.Exped.EnderExped.CEP := ObterConteudo(ANode.Childrens.FindAnyNs('CEP'), tcInt);
  CTe.Exped.EnderExped.UF := ObterConteudo(ANode.Childrens.FindAnyNs('UF'), tcStr);
  CTe.Exped.EnderExped.cPais := ObterConteudo(ANode.Childrens.FindAnyNs('cPais'), tcInt);
  CTe.Exped.EnderExped.xPais := ObterConteudo(ANode.Childrens.FindANyNs('xPais'), tcStr);
end;

procedure TCTeXmlReader.Ler_EnderReceb(ANode: TACBrXmlNode);
begin
  if not Assigned(ANode) then exit;

  CTe.receb.Enderreceb.xLgr := ObterConteudo(ANode.Childrens.FindAnyNS('xLgr'), tcStr);
  CTe.receb.Enderreceb.Nro := ObterConteudo(ANode.Childrens.FindAnyNs('nro'), tcStr);
  CTe.receb.Enderreceb.xCpl := ObterConteudo(ANode.Childrens.FindAnyNs('xCpl'), tcStr);
  CTe.receb.Enderreceb.xBairro := ObterConteudo(ANode.Childrens.FindAnyNs('xBairro'), tcStr);
  CTe.receb.Enderreceb.cMun := ObterConteudo(ANode.Childrens.FindAnyNs('cMun'), tcInt);
  CTe.receb.Enderreceb.xMun := ObterConteudo(ANode.Childrens.FindANyNs('xMun'), tcStr);
  CTe.receb.Enderreceb.CEP := ObterConteudo(ANode.Childrens.FindAnyNs('CEP'), tcInt);
  CTe.receb.Enderreceb.UF := ObterConteudo(ANode.Childrens.FindAnyNs('UF'), tcStr);
  CTe.receb.Enderreceb.cPais := ObterConteudo(ANode.Childrens.FindANyNs('cPais'), tcInt);
  CTe.receb.Enderreceb.xPais := ObterConteudo(ANode.Childrens.FindAnyNs('xPais'), tcStr);
end;

procedure TCTeXmlReader.Ler_EnderReme(ANode: TACBrXmlNode);
begin
  if not Assigned(ANode) then exit;

  CTe.Rem.enderReme.xLgr := ObterConteudo(ANode.Childrens.FindAnyNs('xLgr'), tcStr);
  CTe.Rem.enderReme.Nro := ObterConteudo(ANode.Childrens.FindAnyNs('nro'), tcStr);
  CTe.Rem.enderReme.xCpl := ObterConteudo(ANode.Childrens.FindAnyNs('xCpl'), tcStr);
  CTe.Rem.enderReme.xBairro := ObterConteudo(ANode.Childrens.FindAnyNs('xBairro'), tcStr);
  CTe.Rem.enderReme.cMun := ObterConteudo(ANode.Childrens.FindAnyNs('cMun'), tcInt);
  CTe.Rem.enderReme.xMun := ObterConteudo(ANode.Childrens.FindAnyNs('xMun'), tcStr);
  CTe.Rem.enderReme.CEP := ObterConteudo(ANode.Childrens.FindAnyNs('CEP'), tcInt);
  CTe.Rem.enderReme.UF := ObterConteudo(ANode.Childrens.FindAnyNs('UF'), tcStr);
  CTe.Rem.enderReme.cPais := ObterConteudo(ANode.Childrens.FindAnyNs('cPais'), tcInt);
  CTe.Rem.enderReme.xPais := ObterConteudo(ANode.Childrens.FindAnyNs('xPais'), tcStr);
end;

procedure TCTeXmlReader.Ler_Entrega(ANode: TACBrXmlNode);
var
  OK: Boolean;
  ANodeAux: TACBrXmlNode;
begin
  if not Assigned(ANode) then exit;

  CTe.Compl.Entrega.TipoData := tdNaoInformado;
  CTe.Compl.Entrega.TipoHora := thNaoInformado;

  if Assigned(ANode.Childrens.FindAnyNs('semData')) then
  begin
    ANodeAux := ANode.Childrens.FindAnyNs('semData');
    CTe.Compl.Entrega.TipoData := tdSemData;
    CTe.Compl.Entrega.semData.tpPer := StrTotpDataPeriodo(Ok, ObterConteudo(ANodeAux.Childrens.FindAnyNS('tpPeriodo'), tcStr));
  end;

  if Assigned(ANode.Childrens.FindAnyNs('comData'))  then
  begin
    ANodeAux := ANode.Childrens.FindAnyNs('comData');
    CTe.Compl.Entrega.TipoDAta := tdNaData;
    CTe.Compl.Entrega.comData.tpPer := StrToTpDataPeriodo(Ok, ObterConteudo(ANodeAux.Childrens.FindAnyNs('tpPer'), tcStr));
    CTe.Compl.Entrega.comData.dProg := ObterConteudo(ANodeAux.Childrens.FindAnyNs('dProg'), tcDat);
  end;

  if Assigned(ANode.Childrens.FindAnyNs('noPeriodo')) then
  begin
    ANodeAux := ANode.Childrens.FindAnyNs('noPeriodo');
    CTe.Compl.Entrega.TipoData := tdNoPeriodo;
    CTe.Compl.Entrega.noPeriodo.tpPer := StrToTpDataPeriodo(ok, ObterConteudo(ANodeAux.Childrens.FindAnyNs('tpPer'), tcStr));
    CTe.Compl.Entrega.noPeriodo.dIni := ObterConteudo(ANodeAux.Childrens.FindAnyNs('dIni'), tcDat);
    CTe.Compl.Entrega.noPeriodo.dFim := ObterConteudo(ANodeAux.Childrens.FindAnyNs('dFim'), tcDat);
  end;

  if Assigned(ANode.Childrens.FindAnyNs('semHora')) then
  begin
    ANodeAux := ANode.Childrens.FindAnyNs('semHora');
    CTe.Compl.Entrega.TipoHora := thSemHorario;
    CTe.Compl.Entrega.semHora.tpHor := StrToTpHorarioIntervalo(ok, ObterConteudo(ANodeAux.Childrens.FindAnyNs('tpHor'), tcStr));
  end;

  if Assigned(ANode.Childrens.FindAnyNs('comHora')) then
  begin
    ANodeAux := ANode.Childrens.FindAnyNs('comHora');
    CTe.Compl.Entrega.TipoHora := thNoHorario;
    CTe.Compl.Entrega.comHora.tpHor := StrToTpHorarioIntervalo(ok, ObterConteudo(ANodeAux.Childrens.FindAnyNs('tpHor'), tcStr));
    CTe.Compl.Entrega.comHora.hProg := ObterConteudo(ANodeAux.Childrens.FindAnyNs('hProg'), tcHor);
  end;

  if Assigned(ANode.Childrens.FindAnyNs('noInter')) then
  begin
    ANodeAux := ANode.Childrens.FindAnyNs('noInter');
    CTe.Compl.Entrega.TipoHora := thNoIntervalo;
    CTe.Compl.Entrega.noInter.tpHor := StrToTpHorarioIntervalo(ok, ObterConteudo(ANodeAux.Childrens.FindAnyNs('tpHor'), tcStr));
    CTe.Compl.Entrega.noInter.hIni := ObterConteudo(ANodeAux.Childrens.FindAnyNs('hIni'), tcHor);
    CTe.Compl.Entrega.noInter.hFim := ObterConteudo(ANodeAux.Childrens.FindAnyNs('hFim'), tcHor);
  end;
end;

procedure TCTeXmlReader.Ler_Exped(ANode: TACBrXmlNode);
begin
  if not Assigned(ANode) then exit;

  CTe.Exped.CNPJCPF := ObterCNPJCPF(ANode);
  CTe.Exped.IE := ObterConteudo(ANode.Childrens.FindAnyNs('IE'), tcStr);
  CTe.Exped.xNome := ObterConteudo(ANode.Childrens.FindAnyNs('xNome'), tcStr);
  CTe.Exped.fone := ObterConteudo(ANode.Childrens.FindAnyNs('fone'), tcStr);
  CTe.Exped.email := ObterConteudo(ANode.Childrens.FindAnyNs('email'), tcStr);

  Ler_EnderExped(ANode.Childrens.FindAnyNs('enderExped'));
end;

procedure TCTeXmlReader.Ler_Ferrov(ANode: TACBrXmlNode);
var
  Ok: Boolean;
  tratMutND, enderFerroND: TACBrXmlNode;
  ferroEnvArr: TACBrXmlNodeArray;
  i: Integer;
begin
  if not Assigned(ANode) then exit;

  CTe.infCTeNorm.ferrov.tpTraf := StrToTpTrafego(ok, ObterConteudo(ANode.Childrens.FindAnyNs('tpTraf'), tcStr));
  CTe.infCTeNorm.ferrov.fluxo := ObterConteudo(ANode.Childrens.FindAnyNs('fluxo'), tcStr);
  CTe.infCTeNorm.ferrov.idTrem := ObterConteudo(ANode.Childrens.FindAnyNs('idTrem'), tcStr);
  CTe.infCTeNorm.ferrov.vFrete := ObterConteudo(ANode.Childrens.FindANyNs('vFrete'), tcDe2);

  tratMutND := ANode.Childrens.FindAnyNs('trafMut');
  if Assigned(tratMutND) then
  begin
    CTe.infCTeNorm.ferrov.trafMut.respFat := StrToTrafegoMutuo(ok, ObterConteudo(tratMutND.Childrens.FindAnyNs('respFat'), tcStr));
    CTe.infCTeNorm.ferrov.trafMut.ferrEmi := StrToTrafegoMutuo(ok, ObterConteudo(tratMutND.Childrens.FindAnyNs('ferrEmi'), tcStr));
    CTe.infCTeNorm.ferrov.trafMut.vFrete := ObterConteudo(tratMutND.Childrens.FindANyNs('vFrete'), tcDe2);
    CTe.infCTeNorm.ferrov.trafMut.chCTeFerroOrigem := ObterConteudo(tratMutND.Childrens.FindAnyNs('chCTeFerroOrigem'), tcStr);

    CTe.infCTeNorm.ferrov.ferroEnv.Clear;
    ferroEnvArr := tratMutND.Childrens.FindAllAnyNs('ferroEnv');
    for i := 0 to Length(ferroEnvArr)-1 do
    begin
      CTe.infCTeNorm.ferrov.ferroEnv.New;
      CTe.infCTeNorm.ferrov.ferroEnv[i].CNPJ := ObterConteudo(ferroEnvArr[i].Childrens.FindAnyNs('CNPJ'), tcStr);
      CTe.infCTeNorm.ferrov.ferroEnv[i].cInt := ObterConteudo(ferroEnvArr[i].Childrens.FindAnyNs('cInt'), tcStr);
      CTe.infCTeNorm.ferrov.ferroEnv[i].IE := ObterConteudo(ferroEnvArr[i].Childrens.FindAnyNs('IE'), tcStr);
      CTe.infCTeNorm.ferrov.ferroEnv[i].xNome := ObterConteudo(ferroEnvArr[i].Childrens.FindAnyNs('xNome'), tcStr);

      enderFerroND := ferroEnvArr[i].Childrens.FindAnyNs('enderFerro');
      if Assigned(enderFerroND) then
      begin
        CTe.infCTeNorm.ferrov.ferroEnv[i].EnderFerro.xLgr := ObterConteudo(enderFerroND.Childrens.FindAnyNs('xLgr'), tcStr);
        CTe.infCTeNorm.ferrov.ferroEnv[i].EnderFerro.nro := ObterConteudo(enderFerroND.Childrens.FindAnyNs('nro'), tcStr);
        CTe.infCTeNorm.ferrov.ferroEnv[i].EnderFerro.xCpl := ObterConteudo(enderFerroND.Childrens.FindAnyNs('xCpl'), tcStr);
        CTe.infCTeNorm.ferrov.ferroEnv[i].EnderFerro.xBairro := ObterConteudo(enderFerroND.Childrens.FindAnyNs('xBairro'), tcStr);
        CTe.infCTeNorm.ferrov.ferroEnv[i].EnderFerro.cMun := ObterConteudo(enderFerroND.Childrens.FindAnyNs('cMun'), tcInt);
        CTe.infCTeNorm.ferrov.ferroEnv[i].EnderFerro.xMun := ObterConteudo(enderFerroND.Childrens.FindAnyNs('xMun'), tcStr);
        CTe.infCTeNorm.ferrov.ferroEnv[i].EnderFerro.CEP := ObterConteudo(enderFerroND.Childrens.FindAnyNs('CEP'), tcInt);
        CTe.infCTeNorm.ferrov.ferroEnv[i].EnderFerro.UF := ObterConteudo(enderFerroND.Childrens.FindAnyNs('UF'), tcStr);
      end;
    end;
  end;
end;

procedure TCTeXmlReader.Ler_Fluxo(ANode: TACBrXmlNode);
var
  pass: TACBrXmlNodeArray;
  i: Integer;
begin
  if not Assigned(ANode) then exit;

  CTe.Compl.fluxo.xOrig := ObterConteudo(ANode.Childrens.FindAnyNs('xOrig'), tcStr);
  CTe.Compl.fluxo.xDest := ObterConteudo(ANode.Childrens.FindAnyNs('xDest'), tcStr);
  CTe.Compl.fluxo.xRota := ObterConteudo(ANode.Childrens.FindAnyNs('xRota'), tcStr);

  pass := ANode.Childrens.FindAllAnyNs('pass');

  for i := 0 to Length(pass)-1 do
  begin
    CTe.Compl.fluxo.pass.New;
    CTe.Compl.fluxo.pass[i].xPass := ObterConteudo(pass[i].Childrens.FindAnyNs('xPass'), tcStr);
  end;
end;

procedure TCTeXmlReader.Ler_Ide(const ANode: TACBrXmlNode);
var
  OK: Boolean;
  sAux: string;
begin
  if not Assigned(ANode) then exit;

  CTe.Ide.cUF := ObterConteudo(ANode.Childrens.FindAnyNs('cUF'), tcInt);
  CTe.Ide.cCT := ObterConteudo(ANode.Childrens.FindAnyNs('cCT'), tcInt);
  CTe.Ide.CFOP := ObterConteudo(ANode.Childrens.FindAnyNs('CFOP'), tcStr);
  CTe.Ide.natOp := ObterConteudo(ANode.Childrens.FindAnyNs('natOp'), tcStr);

  CTe.Ide.modelo := ObterConteudo(ANode.Childrens.FindAnyNs('mod'), tcStr);
  CTe.Ide.serie := ObterConteudo(ANode.Childrens.FindAnyNs('serie'), tcStr);
  CTe.Ide.nCT := ObterConteudo(ANode.Childrens.FindAnyNs('nCT'), tcInt);
  CTe.Ide.dhEmi := ObterConteudo(ANode.Childrens.FindAnyNs('dhEmi'), tcDatHor);
  CTe.Ide.tpImp := StrToTpImp(ObterConteudo(ANode.Childrens.FindAnyNs('tpImp'), tcStr));
  CTe.Ide.tpEmis := StrToTipoEmissao(ObterConteudo(ANode.Childrens.FindAnyNs('tpEmis'), tcStr));
  CTe.Ide.cDV := ObterConteudo(ANode.Childrens.FindAnyNs('cDV'), tcInt);
  CTe.Ide.tpAmb := StrToTipoAmbiente(ObterConteudo(ANode.Childrens.FindAnyNs('tpAmb'), tcStr));
  CTe.Ide.tpCTe := StrTotpCTe(Ok, ObterConteudo(ANode.Childrens.FindAnyNs('tpCTe'), tcStr));
  sAux := ObterConteudo(ANode.Childrens.FindAnyNs('procEmi'), tcStr);
  if sAux <> '' then //GTVe não tem procEmi
    CTe.Ide.procEmi := StrToprocEmi(sAux);
  CTe.Ide.verProc := ObterConteudo(ANode.Childrens.FindAnyNs('verProc'), tcStr);

  if ObterConteudo(ANode.Childrens.FindAnyNs('indGlobalizado'), tcStr) = '1' then
    CTe.Ide.indGlobalizado := tiSim
  else
    CTe.Ide.IndGlobalizado := tiNao;

  CTe.Ide.refCTE := ObterConteudo(ANode.Childrens.FindAnyNs('refCTE'), tcStr);
  CTe.Ide.cMunEnv := ObterConteudo(ANode.Childrens.FindAnyNs('cMunEnv'), tcInt);
  CTe.Ide.xMunEnv := ObterConteudo(ANode.Childrens.FindAnyNs('xMunEnv'), tcStr);
  CTe.Ide.UFEnv := ObterConteudo(ANode.Childrens.FindAnyNs('UFEnv'), tcStr);
  CTe.Ide.modal := StrToTpModal(ObterConteudo(ANode.Childrens.FindAnyNs('modal'), tcStr));
  CTe.Ide.tpServ := StrtoTpServ(Ok, ObterConteudo(ANode.Childrens.FindAnyNs('tpServ'), tcStr));
  CTe.Ide.cMunIni := ObterConteudo(ANode.Childrens.FindAnyNs('cMunIni'), tcInt);
  CTe.Ide.xMunIni := ObterConteudo(ANode.Childrens.FindAnyNs('xMunIni'), tcStr);
  CTe.Ide.UFIni := ObterConteudo(ANode.Childrens.FindAnyNs('UFIni'), tcStr);
  CTe.Ide.cMunFim := ObterConteudo(ANode.Childrens.FindAnyNs('cMunFim'), tcInt);
  CTe.Ide.xMunFim := ObterConteudo(ANode.Childrens.FindAnyNs('xMunFim'), tcStr);
  CTe.Ide.UFFim := ObterConteudo(ANode.Childrens.FindAnyNs('UFFim'), tcStr);

  sAux := ObterConteudo(ANode.Childrens.FindAnyNs('retira'), tcStr);

  if sAux <> '' then
    CTe.Ide.retira := StrToTpRetira(ok, sAux);

  CTe.Ide.xdetretira := ObterConteudo(ANode.Childrens.FindAnyNs('xDetRetira'), tcStr);
  CTe.Ide.dhCont := ObterConteudo(ANode.Childrens.FindAnyNs('dhCont'), tcDatHor);
  CTe.Ide.xJust := ObterConteudo(ANode.Childrens.FindAnyNs('xJust'), tcStr);

  sAux := ObterConteudo(ANode.Childrens.FindAnyNs('indIEToma'), tcStr);
  if sAux <> '' then
    CTe.Ide.IndIEToma := StrToindIEDest(sAux);

  CTe.Ide.dhSaidaOrig := ObterConteudo(ANode.Childrens.FindAnyNs('dhSaidaOrig'), tcDatHor);
  CTe.Ide.dhChegadaDest := ObterConteudo(ANode.Childrens.FindAnyNs('dhChegadaDest'), tcDatHor);
  CTe.Ide.tpPagAnt := StrTotpPagAnt(ObterConteudo(ANode.Childrens.Find('tpPagAnt'), tcStr));

  // Reforma Tritutária
  Ler_gCompraGovReduzido(ANode.Childrens.Find('gCompraGov'), CTe.Ide.gCompraGov);
  Ler_gPagAntecipadoIde(ANode.Childrens.Find('gPagAntecipado'), CTe.Ide.gPagAntecipado);

  Ler_InfPercurso(ANode);
  Ler_Toma03(ANode);
  Ler_Toma04(ANode);
  Ler_gMultaJuros(ANode.Childrens.Find('gMultaJuros'), CTe.Ide.gMultaJuros);
end;

procedure TCTeXmlReader.Ler_gMultaJuros(const ANode: TACBrXmlNode;
  gMultaJuros: TgMultaJuros);
begin
  if not Assigned(ANode) then Exit;

  gMultaJuros.chCTeRef := ObterConteudo(ANode.Childrens.Find('chCTeRef'), tcStr);
end;

procedure TCTeXmlReader.Ler_Imp(ANode: TACBrXmlNode);
var
  AuxNode: TACBrXmlNode;

  procedure LerICMS00(ANode: TACBrXmlNode);
  begin
    if not Assigned(ANode) then exit;

    CTe.Imp.ICMS.SituTrib := cst00;
    CTe.Imp.ICMS.ICMS00.CST := StrToCSTICMS(ObterConteudo(ANode.Childrens.FindAnyNs('CST'), tcStr));
    CTe.Imp.ICMS.ICMS00.vBC := ObterConteudo(ANode.Childrens.FindAnyNs('vBC'), tcDe2);
    CTe.Imp.ICMS.ICMS00.pICMS := ObterConteudo(ANode.Childrens.FindAnyNs('pICMS'), tcDe2);
    CTe.Imp.ICMS.ICMS00.vICMS := ObterConteudo(ANode.Childrens.FindAnyNs('vICMS'), tcDe2);
  end;

  procedure LerICMS20(ANode: TACBrXmlNode);
  begin
    if not Assigned(ANode) then exit;

    CTe.Imp.ICMS.SituTrib := cst20;
    CTe.Imp.ICMS.ICMS20.CST := StrToCSTICMS(ObterConteudo(ANode.Childrens.FindAnyNs('CST'), tcStr));
    CTe.Imp.ICMS.ICMS20.pRedBC := ObterConteudo(ANode.Childrens.FindAnyNs('pRedBC'), tcDe2);
    CTe.Imp.ICMS.ICMS20.vBC := ObterConteudo(ANode.Childrens.FindAnyNs('vBC'), tcDe2);
    CTe.Imp.ICMS.ICMS20.pICMS := ObterConteudo(ANode.Childrens.FindAnyNs('pICMS'), tcDe2);
    CTe.Imp.ICMS.ICMS20.vICMS := ObterConteudo(ANode.Childrens.FindAnyNs('vICMS'), tcDe2);
  end;

  procedure LerICMS45(ANode: TACBrXmlNode);
  begin
    if not Assigned(ANode) then exit;

    CTe.Imp.ICMS.ICMS45.CST := StrToCSTICMS(ObterConteudo(ANode.Childrens.FindAnyNs('CST'), tcStr));

    case CTe.Imp.ICMS.ICMS45.CST of
      cst40: CTe.Imp.ICMS.SituTrib := cst40;
      cst41: CTe.Imp.ICMS.SituTrib := cst41;
      cst51: CTe.Imp.ICMS.SituTrib := cst51;
    end;
  end;

  procedure LerICMS60(ANode: TACBrXmlNode);
  begin
    if not Assigned(ANode) then exit;
    CTe.Imp.ICMS.SituTrib := cst60;
    CTe.Imp.ICMS.ICMS60.CST := StrToCSTICMS(ObterConteudo(ANode.Childrens.FindAnyNs('CST'), tcStr));
    CTe.Imp.ICMS.ICMS60.vBCSTRet := ObterConteudo(ANode.Childrens.FindAnyNs('vBCSTRet'), tcDe2);
    CTe.Imp.ICMS.ICMS60.vICMSSTRet := ObterConteudo(ANode.Childrens.FindAnyNs('vICMSSTRet'), tcDe2);
    CTe.Imp.ICMS.ICMS60.pICMSSTRet := ObterConteudo(ANode.Childrens.FindANyNs('pICMSSTRet'), tcDe2);
    CTe.Imp.ICMS.ICMS60.vCred := ObterConteudo(ANode.Childrens.FindAnyNs('vCred'), tcDe2);
  end;

  procedure LerICMS90(ANode: TACBrXmlNode);
  begin
    if not Assigned(ANode) then exit;

    CTe.Imp.ICMS.SituTrib := cst90;
    CTe.Imp.ICMS.ICMS90.CST := StrToCSTICMS(ObterConteudo(ANode.Childrens.FindAnyNs('CST'), tcStr));
    CTe.Imp.ICMS.ICMS90.pRedBC := ObterConteudo(ANode.Childrens.FindAnyNs('pRedBC'), tcDe2);
    CTe.Imp.ICMS.ICMS90.vBC := ObterConteudo(ANode.Childrens.FindAnyNs('vBC'), tcDe2);
    CTe.Imp.ICMS.ICMS90.pICMS := ObterConteudo(ANode.Childrens.FindAnyNs('pICMS'), tcDe2);
    CTe.Imp.ICMS.ICMS90.vICMS := ObterConteudo(ANode.Childrens.FindAnyNs('vICMS'), tcDe2);
    CTe.Imp.ICMS.ICMS90.vCred := ObterConteudo(ANode.Childrens.FindAnyNs('vCred'), tcDe2);
  end;

  procedure LerICMSOutrasUF(ANode: TACBrXmlNode);
  begin
    if not Assigned(ANode) then exit;

    // ICMS devido à UF de origem da prestação, quando diferente da UF do emitente
    CTe.Imp.ICMS.SituTrib := cstICMSOutraUF;
    CTe.Imp.ICMS.ICMSOutraUF.CST := StrToCSTICMS(ObterConteudo(ANode.Childrens.FindAnyNs('CST'), tcStr));
    CTe.Imp.ICMS.ICMSOutraUF.pRedBCOutraUF := ObterConteudo(ANode.Childrens.FindAnyNs('pRedBCOutraUF'), tcDe2);
    CTe.Imp.ICMS.ICMSOutraUF.vBCOutraUF := ObterConteudo(ANode.Childrens.FindAnyNs('vBCOutraUF'), tcDe2);
    CTe.Imp.ICMS.ICMSOutraUF.pICMSOutraUF := ObterConteudo(ANode.Childrens.FindAnyNs('pICMSOutraUF'), tcDe2);
    CTe.Imp.ICMS.ICMSOutraUF.vICMSOutraUF := ObterConteudo(ANode.Childrens.FindAnyNs('vICMSOutraUF'), tcDe2);
  end;

  procedure LerICMSSN(ANode: TACBrXmlNode);
  begin
    if not Assigned(ANode) then exit;

    // ICMS Simples Nacional
    CTe.Imp.ICMS.SituTrib := cstICMSSN;

    CTe.Imp.ICMS.ICMSSN.CST := StrToCSTICMS(ObterConteudo(ANode.Childrens.FindAnyNs('CST'), tcStr));

    CTe.Imp.ICMS.ICMSSN.indSN := ObterConteudo(ANode.Childrens.FindAnyNs('indSN'), tcInt);
  end;

  procedure LerICMSPrevisto(ANode: TACBrXmlNode);
  begin
    if not Assigned(ANode) then exit;

    // ICMS Simples Nacional
    CTe.Imp.ICMS.SituTrib := cstICMSPrevisto;

    CTe.Imp.ICMS.gICMSPrevistoPagtoAntecip.vICMSPrevisto := ObterConteudo(ANode.Childrens.FindAnyNs('vICMSPrevisto'), tcDe2);
  end;

  procedure LerICMSUFFim(ANode: TACBrXmlNode);
  begin
    if not Assigned(ANode) then exit;

    CTe.Imp.ICMSUFFim.vBCUFFim := ObterConteudo(ANode.Childrens.FindAnyNs('vBCUFFim'), tcDe2);
    CTe.Imp.ICMSUFFim.pFCPUFFim := ObterConteudo(ANode.Childrens.FindAnyNs('pFCPUFFim'), tcDe2);
    CTe.Imp.ICMSUFFim.pICMSUFFim := ObterConteudo(ANode.Childrens.FindAnyNs('pICMSUFFim'), tcDe2);
    CTe.Imp.ICMSUFFim.pICMSInter := ObterConteudo(ANode.Childrens.FindAnyNs('pICMSInter'), tcDe2);
    CTe.Imp.ICMSUFFim.pICMSInterPart := ObterConteudo(ANode.Childrens.FindAnyNs('pICMSInterPart'), tcDe2);
    CTe.Imp.ICMSUFFim.vFCPUFFim := ObterConteudo(ANode.Childrens.FindAnyNs('vFCPUFFim'), tcDe2);
    CTe.Imp.ICMSUFFim.vICMSUFFim := ObterConteudo(ANode.Childrens.FindAnyNs('vICMSUFFim'), tcDe2);
    CTe.Imp.ICMSUFFim.vICMSUFIni := ObterConteudo(ANode.Childrens.FindAnyNs('vICMSUFIni'), tcDe2);
  end;

  procedure LerInfTribFed(ANode: TACBrXmlNode);
  begin
    if not Assigned(ANode) then exit;

    CTe.Imp.infTribFed.vPIS := ObterConteudo(ANode.Childrens.FindAnyNs('vPIS'), tcDe2);
    CTe.Imp.infTribFed.vCOFINS := ObterConteudo(ANode.Childrens.FindAnyNs('vCOFINS'), tcDe2);
    CTe.Imp.infTribFed.vIR := ObterConteudo(ANode.Childrens.FindAnyNs('vIR'), tcDe2);
    CTe.Imp.infTribFed.vINSS := ObterConteudo(ANode.Childrens.FindAnyNs('vINSS'), tcDe2);
    CTe.Imp.infTribFed.vCSLL := ObterConteudo(ANode.Childrens.FindAnyNs('vCSLL'), tcDe2);
  end;
begin
  if not Assigned(ANode) then exit;

  CTe.Imp.vTotTrib := ObterConteudo(ANode.Childrens.FindAnyNs('vTotTrib'), tcDe2);
  CTe.Imp.infAdFisco := ObterConteudo(ANode.Childrens.FindAnyNs('infAdFisco'), tcStr);

  AuxNode := ANode.Childrens.FindAnyNs('ICMS');

  if Assigned(AuxNode) then
  begin
    LerICMS00(AuxNode.Childrens.FindAnyNs('ICMS00'));
    LerICMS20(AuxNode.Childrens.FindAnyNs('ICMS20'));
    LerICMS45(AuxNode.Childrens.FindAnyNs('ICMS45'));
    LerICMS60(AuxNode.Childrens.FindAnyNs('ICMS60'));
    LerICMS90(AuxNode.Childrens.FindAnyNs('ICMS90'));
    LerICMSOutrasUF(AuxNode.Childrens.FindAnyNs('ICMSOutraUF'));
    LerICMSSN(AuxNode.Childrens.FindAnyNs('ICMSSN'));
    LerICMSPrevisto(AuxNode.Childrens.FindAnyNs('gICMSPrevistoPagtoAntecip'));
  end;

  LerICMSUFFim(ANode.Childrens.FindAnyNs('ICMSUFFim'));
  LerInfTribFed(ANode.Childrens.FindAnyNs('infTribFed'));

  // Reforma Tributária
  Ler_IBSCBS(ANode.Childrens.Find('IBSCBS'), CTe.Imp.IBSCBS);

  CTe.Imp.vTotDFe := ObterConteudo(ANode.Childrens.FindAnyNs('vTotDFe'), tcDe2);
end;

procedure TCTeXmlReader.Ler_InfCarga(ANode: TACBrXmlNode; infCarga: TInfCarga);
var
  ANodeArr: TACBrXmlNodeArray;
  i: Integer;
begin
  if not Assigned(ANode) then exit;

  infCarga.vCarga := ObterConteudo(ANode.Childrens.FindAnyNs('vCarga'), tcDe2);
  InfCarga.proPred := ObterConteudo(ANode.Childrens.FindAnyNs('proPred'), tcStr);
  InfCarga.xOutCat := ObterConteudo(ANode.Childrens.FindAnyNs('xOutCat'), tcStr);
  infCarga.vCargaAverb := ObterConteudo(ANode.Childrens.FindAnyNs('vCargaAverb'), tcDe2);

  ANodeArr := ANode.Childrens.FindAllAnyNs('infQ');

  InfCarga.infQ.Clear;
  for i := 0 to Length(ANodeArr)-1 do
  begin
    InfCarga.infQ.New;
    InfCarga.infQ[i].cUnid := ObterConteudo(ANodeArr[i].Childrens.FindAnyNs('cUnid'), tcStr);
    InfCarga.infQ[i].tpMed := ObterConteudo(ANodeArr[i].Childrens.FindAnyNs('tpMed'), tcStr);
    InfCarga.infQ[i].qCarga := ObterConteudo(ANodeArr[i].Childrens.FindAnyNs('qCarga'), tcDe4);
  end;
end;

procedure TCTeXmlReader.Ler_InfCTe(const ANode: TACBrXmlNode);
begin
  if not Assigned(ANode) then exit;

  Ler_Ide(ANode.Childrens.FindAnyNs('ide'));

  case CTe.ide.tpCTe of
    tcGTVe: Ler_GTVe(ANode);

    tcCTeSimp,
    tcSubstCTeSimpl: Ler_CTeSimp(ANode);
  else
    if CTe.ide.modelo = 57 then
      Ler_CTe(ANode)
    else
      Ler_CTeOS(ANode);
  end;
end;

procedure TCTeXmlReader.Ler_InfCTeNorm(ANode: TACBrXmlNode);
var
  AuxNode, infGlobalizadoNd: TACBrXmlNode;
  ANodeArr, infArr, infUnidArr, UnidArr: TACBrXmlNodeArray;
  i, j, k, l: Integer;
  OK: Boolean;
begin
  if not Assigned(ANode) then exit;

  CTe.infCTeNorm.refCTeCanc := ObterConteudo(ANode.Childrens.FindAnyNs('refCTeCanc'), tcStr);

  AuxNode := ANode.Childrens.FindAnyNs('infServico');

  if Assigned(AuxNode) then
  begin
    CTe.infCTeNorm.infServico.xDescServ := ObterConteudo(AuxNode.Childrens.FindAnyNs('xDescServ'), tcStr);
    AuxNode := AuxNode.Childrens.FindAnyNs('infQ');
    if Assigned(AuxNode) then
      CTe.infCTeNorm.infServico.qCarga := ObterConteudo(AuxNode.Childrens.FindAnyNs('qCarga'), tcDe4);
  end;

  ANodeArr := ANode.Childrens.FindAllAnyNs('infDocRef');

  CTe.infCTeNorm.infDocRef.Clear;
  for i := 0 to Length(ANodeArr)-1 do
  begin
    CTe.infCTeNorm.infDocRef.New;
    CTe.infCTeNorm.infDocRef[i].nDoc := ObterConteudo(ANodeArr[i].Childrens.FindAnyNs('nDoc'), tcEsp);
    CTe.infCTeNorm.infDocRef[i].serie := ObterConteudo(ANodeArr[i].Childrens.FindAnyNs('serie'), tcStr);
    CTe.infCTeNorm.infDocRef[i].subserie := ObterConteudo(ANodeArr[i].Childrens.FindAnyNs('subserie'), tcStr);
    CTe.infCTeNorm.infDocRef[i].dEmi := ObterConteudo(ANodeArr[i].Childrens.FindAnyNs('dEmi'), tcDat);
    CTe.infCTeNorm.infDocRef[i].vDoc := ObterConteudo(ANodeArr[i].Childrens.FindAnyNs('vDoc'), tcDe2);

    CTe.infCTeNorm.infDocRef[i].chBPe := ObterConteudo(ANodeArr[i].Childrens.FindAnyNs('chBPe'), tcStr);
  end;

  AuxNode := ANode.Childrens.FindAnyNs('infCarga');

  Ler_InfCarga(AuxNode, CTe.infCTeNorm.infCarga);

  AuxNode := ANode.Childrens.FindAnyNs('infDoc');
  if Assigned(AuxNode) then
  begin
    CTe.infCTeNorm.infDoc.infNF.Clear;
    infArr := AuxNode.Childrens.FindAllAnyNs('infNF');
    for i := 0 to Length(infArr)-1 do
    begin
      CTe.infCTeNorm.infDoc.infNF.New;
      CTe.infCTeNorm.infDoc.InfNF[i].nRoma := ObterConteudo(infArr[i].Childrens.FindAnyNs('nRoma'), tcStr);
      CTe.infCTeNorm.infDoc.InfNF[i].nPed := ObterConteudo(infArr[i].Childrens.FindAnyNs('nPed'), tcStr);
      CTe.infCTeNorm.infDoc.InfNF[i].Modelo := StrToModeloNFEX(ObterConteudo(infArr[i].Childrens.FindAnyNs('mod'), tcStr));
      CTe.infCTeNorm.infDoc.InfNF[i].serie := ObterConteudo(infArr[i].Childrens.FindAnyNs('serie'), tcStr);
      CTe.infCTeNorm.infDoc.InfNF[i].nDoc := ObterConteudo(infArr[i].Childrens.FindAnyNs('nDoc'), tcEsp);
      CTe.infCTeNorm.infDoc.InfNF[i].dEmi := ObterConteudo(infArr[i].Childrens.FindAnyNs('dEmi'), tcDat);
      CTe.infCTeNorm.infDoc.InfNF[i].vBC := ObterConteudo(infArr[i].Childrens.FindAnyNs('vBC'), tcDe2);
      CTe.infCTeNorm.infDoc.InfNF[i].vICMS := ObterConteudo(infArr[i].Childrens.FindAnyNs('vICMS'), tcDe2);
      CTe.infCTeNorm.infDoc.InfNF[i].vBCST := ObterConteudo(infArr[i].Childrens.FindAnyNs('vBCST'), tcDe2);
      CTe.infCTeNorm.infDoc.InfNF[i].vST := ObterConteudo(infArr[i].Childrens.FindAnyNs('vST'), tcDe2);
      CTe.infCTeNorm.infDoc.InfNF[i].vProd := ObterConteudo(infArr[i].Childrens.FindAnyNs('vProd'), tcDe2);
      CTe.infCTeNorm.infDoc.InfNF[i].vNF := ObterConteudo(infArr[i].Childrens.FindAnyNs('vNF'), tcDe2);
      CTe.infCTeNorm.infDoc.InfNF[i].nCFOP := ObterConteudo(infArr[i].Childrens.FindAnyNs('nCFOP'), tcInt);
      CTe.infCTeNorm.infDoc.InfNF[i].nPeso := ObterConteudo(infArr[i].Childrens.FindAnyNs('nPeso'), tcDe3);
      CTe.infCTeNorm.infDoc.InfNF[i].PIN := ObterConteudo(infArr[i].Childrens.FindAnyNs('PIN'), tcStr);
      CTe.infCTeNorm.infDoc.InfNF[i].dPrev := ObterConteudo(infArr[i].Childrens.FindAnyNs('dPrev'), tcDat);

      infUnidArr := infArr[i].Childrens.FindAllAnyNs('infUnidTransp');
      for j := 0 to Length(infUnidArr)-1 do
      begin
        CTe.infCTeNorm.infDoc.infNF[i].infUnidTransp.New;
        CTe.infCTeNorm.infDoc.infNF[i].infUnidTransp[j].tpUnidTransp := StrToUnidTransp(ObterConteudo(infUnidArr[j].Childrens.FindAnyNs('tpUnidTransp'), tcStr));
        CTe.infCTeNorm.infDoc.infNF[i].infUnidTransp[j].idUnidTransp := ObterConteudo(infUnidArr[j].Childrens.FindAnyNs('idUnidTransp'), tcStr);
        CTe.infCTeNorm.infDoc.infNF[i].infUnidTransp[j].qtdRat := ObterConteudo(infUnidArr[j].Childrens.FindAnyNs('qtdRat'), tcDe2);


        UnidArr := infUnidArr[j].Childrens.FindAllAnyNs('lacUnidTransp');
        for k := 0 to Length(UnidArr)-1 do
        begin
          CTe.infCTeNorm.infDoc.infNF[i].infUnidTransp[j].lacUnidTransp.New;
          CTe.infCTeNorm.infDoc.infNF[i].infUnidTransp[j].lacUnidTransp[k].nLacre := ObterConteudo(UnidArr[k].Childrens.FindAnyNs('nLacre'), tcStr);
        end;

        UnidArr := infUnidArr[j].Childrens.FindAllAnyNs('infUnidCarga');
        for k := 0 to Length(UnidArr)-1 do
        begin
          CTe.infCTeNorm.infDoc.infNF[i].infUnidTransp[j].infUnidCarga.New;
          CTe.infCTeNorm.infDoc.infNF[i].infUnidTransp[j].infUnidCarga[k].tpUnidCarga := StrToUnidCarga(ObterConteudo(UnidArr[k].Childrens.FindAnyNs('tpUnidCarga'), tcStr));
          CTe.infCTeNorm.infDoc.infNF[i].infUnidTransp[j].infUnidCarga[k].idUnidCarga := ObterConteudo(UnidArr[k].Childrens.FindAnyNs('idUnidCarga'), tcStr);
          CTe.infCTeNorm.infDoc.infNF[i].infUnidTransp[j].infUnidCarga[k].qtdRat := ObterConteudo(UnidArr[k].Childrens.FindAnyNs('qtdRat'), tcDe2);

          ANodeArr := UnidArr[k].Childrens.FindAllAnyNs('lacUnidCarga');
          for l := 0 to Length(ANodeArr)-1 do
          begin
            CTe.infCTeNorm.infDoc.infNF[l].infUnidTransp[j].infUnidCarga[k].lacUnidCarga.New;
            CTe.infCTeNorm.infDoc.infNF[l].infUnidTransp[j].infUnidCarga[k].lacUnidCarga[l].nLacre := ObterConteudo(ANodeArr[l].Childrens.FindAnyNs('nLacre'), tcStr);
          end;

        end;
      end;

      UnidArr := infArr[i].Childrens.FindAllAnyNs('infUnidCarga');
      for j := 0 to Length(UnidArr)-1 do
      begin
        CTe.infCTeNorm.infDoc.infNF[i].infUnidCarga.New;
        CTe.infCTeNorm.infDoc.infNF[i].infUnidCarga[j].tpUnidCarga := StrToUnidCarga(ObterConteudo(UnidArr[j].Childrens.FindAnyNs('tpUnidCarga'), tcStr));
        CTe.infCTeNorm.infDoc.infNF[i].infUnidCarga[j].idUnidCarga := ObterConteudo(UnidArr[j].Childrens.FindAnyNs('idUnidCarga'), tcStr);
        CTe.infCTeNorm.infDoc.infNF[i].infUnidCarga[j].qtdRat := ObterConteudo(UnidArr[j].Childrens.FindAnyNs('qtdRat'), tcDe2);

        ANodeArr := UnidArr[j].Childrens.FindAllAnyNs('lacUnidCarga');
        for k := 0 to Length(ANodeArr)-1 do
        begin
          CTe.infCTeNorm.infDoc.infNF[i].infUnidCarga[j].lacUnidCarga.New;
          CTe.infCTeNorm.infDoc.infNF[i].infUnidCarga[j].lacUnidCarga[k].nLacre := ObterConteudo(ANodeArr[k].Childrens.FindANyNs('nLacre'), tcStr);
        end;
      end;
    end;

    Ler_InfNFe(AuxNode, CTe.infCTeNorm.infDoc.infNFe);

    CTe.infCTeNorm.infDoc.InfOutros.Clear;
    infArr := AuxNode.Childrens.FindAllAnyNs('infOutros');
    for i := 0 to Length(infArr)-1 do
    begin
      CTe.infCTeNorm.infDoc.InfOutros.New;
      CTe.infCTeNorm.infDoc.InfOutros[i].tpDoc := StrToTpDocumento(ok, ObterConteudo(infArr[i].Childrens.FindAnyNs('tpDoc'), tcStr));
      CTe.infCTeNorm.infDoc.InfOutros[i].descOutros := ObterConteudo(infArr[i].Childrens.FindAnyNs('descOutros'), tcStr);
      CTe.infCTeNorm.infDoc.InfOutros[i].nDoc := ObterConteudo(infArr[i].Childrens.FindAnyNs('nDoc'), tcStr);
      CTe.infCTeNorm.infDoc.InfOutros[i].dEmi := ObterConteudo(infArr[i].Childrens.FindAnyNs('dEmi'), tcDat);
      CTe.infCTeNorm.infDoc.InfOutros[i].vDocFisc := ObterConteudo(infArr[i].Childrens.FindAnyNs('vDocFisc'), tcDe2);
      CTe.infCTeNorm.infDoc.InfOutros[i].dPrev := ObterConteudo(infArr[i].Childrens.FindAnyNs('dPrev'), tcDat);

      infUnidArr := infArr[i].Childrens.FindAllAnyNs('infUnidTransp');
      for j := 0 to Length(infUnidArr)-1 do
      begin
        CTe.infCTeNorm.infDoc.InfOutros[i].infUnidTransp.New;
        CTe.infCTeNorm.infDoc.InfOutros[i].infUnidTransp[j].tpUnidTransp := StrToUnidTransp(ObterConteudo(infUnidArr[j].Childrens.FindAnyNs('tpUnidTransp'), tcStr));
        CTe.infCTeNorm.infDoc.InfOutros[i].infUnidTransp[j].idUnidTransp := ObterConteudo(infUnidArr[j].Childrens.FindAnyNs('idUnidTransp'), tcStr);
        CTe.infCTeNorm.infDoc.infOutros[i].infUnidTransp[j].qtdRat := ObterConteudo(infUnidArr[j].Childrens.FindAnyNs('qtdRat'), tcDe2);

        UnidArr := infUnidArr[j].Childrens.FindAllAnyNs('lacUnidTransp');
        for k := 0 to Length(UnidArr)-1 do
        begin
          CTe.infCTeNorm.infDoc.InfOutros[i].infUnidTransp[j].lacUnidTransp.New;
          CTe.infCTeNorm.infDoc.InfOutros[i].infUnidTransp[j].lacUnidTransp[k].nLacre := ObterConteudo(UnidArr[k].Childrens.FindAnyNs('nLacre'), tcStr);
        end;

        UnidArr := infUnidArr[j].Childrens.FindAllAnyNs('infUnidCarga');
        for k := 0 to Length(UnidArr)-1 do
        begin
          CTe.infCTeNorm.infDoc.InfOutros[i].infUnidTransp[j].infUnidCarga.New;
          CTe.infCTeNorm.infDoc.InfOutros[i].infUnidTransp[j].infUnidCarga[k].tpUnidCarga := StrToUnidCarga(ObterConteudo(UnidArr[k].Childrens.FindAnyNs('tpUnidCarga'), tcStr));
          CTe.infCTeNorm.infDoc.InfOutros[i].infUnidTransp[j].infUnidCarga[k].idUnidCarga := ObterConteudo(UnidArr[k].Childrens.FindAnyNs('idUnidCarga'), tcStr);
          CTe.infCTeNorm.infDoc.InfOutros[i].infUnidTransp[j].infUnidCarga[k].qtdRat := ObterConteudo(UnidArr[k].Childrens.FindAnyNs('qtdRat'), tcDe2);

          ANodeArr := UnidArr[k].Childrens.FindAllAnyNs('lacUnidCarga');
          for l := 0 to Length(ANodeArr)-1 do
          begin
            CTe.infCTeNorm.infDoc.InfOutros[i].infUnidTransp[j].infUnidCarga[k].lacUnidCarga.New;
            CTe.infCTeNorm.infDoc.InfOutros[i].infUnidTransp[j].infUnidCarga[k].lacUnidCarga[l].nLacre := ObterConteudo(ANodeArr[l].Childrens.FindAnyNs('nLacre'), tcStr);
          end;
        end;
      end;

      infUnidArr := infArr[i].Childrens.FindAllAnyNs('infUnidCarga');
      for j := 0 to Length(infUnidArr)-1 do
      begin
        CTe.infCTeNorm.infDoc.InfOutros[i].infUnidCarga.New;
        CTe.infCTeNorm.infDoc.InfOutros[i].infUnidCarga[j].tpUnidCarga := StrToUnidCarga(ObterConteudo(infUnidArr[j].Childrens.FindAnyNs('tpUnidCarga'), tcStr));
        CTe.infCTeNorm.infDoc.InfOutros[i].infUnidCarga[j].idUnidCarga := ObterConteudo(InfUnidArr[j].Childrens.FindAnyNs('idUnidCarga'), tcStr);
        CTe.infCTeNorm.infDoc.InfOutros[i].infUnidCarga[j].qtdRat := ObterConteudo(InfUnidArr[j].Childrens.FindAnyNs('qtdRat'), tcDe2);

        UnidArr := infUnidArr[j].Childrens.FindAllAnyNs('lacUnidCarga');
        for k := 0 to Length(UnidArr)-1 do
        begin
          CTe.infCTeNorm.infDoc.InfOutros[i].infUnidCarga[j].lacUnidCarga.New;
          CTe.infCTeNorm.infDoc.InfOutros[i].infUnidCarga[j].lacUnidCarga[k].nLacre := ObterConteudo(UnidArr[k].Childrens.FindAnyNs('nLacre'), tcStr);
        end;
      end;
    end;

    Ler_InfDCe(AuxNode);
  end;

  Ler_DocAnt(ANode.Childrens.FindAnyNs('docAnt'));
  Ler_Seg(ANode.Childrens.FindAllAnyNs('seg'));
  AuxNode := ANode.Childrens.FindAnyNs('infModal');

  if Assigned(AuxNode) then
  begin
    Ler_Rodo(AuxNode.Childrens.FindAnyNs('rodo'), CTe.infCTeNorm.rodo);
    Ler_RodoOS(AuxNode.Childrens.FindAnyNs('rodoOS'));
    Ler_Aereo(AuxNode.Childrens.FindAnyNs('aereo'), CTe.infCTeNorm.aereo);
    Ler_Aquav(AuxNode.Childrens.FindAnyNs('aquav'), CTe.infCTeNorm.aquav);
    Ler_Ferrov(AuxNode.Childrens.FindAnyNs('ferrov'));
    Ler_Duto(AuxNode.Childrens.FindAnyNs('duto'));
    Ler_Multimodal(AuxNode.Childrens.FindAnyNs('multimodal'));
  end;

  Ler_VeicNovos(ANode.Childrens.FindAllAnyNs('veicNovos'));
  Ler_Cobr(ANode.Childrens.FindAnyNs('cobr'));
  Ler_InfGTVe(ANode.Childrens.FindAllAnyNs('infGTVe'));
  Ler_InfCTeSub(ANode.Childrens.FindAnyNs('infCteSub'), CTe.infCTeNorm.infCTeSub);

  infGlobalizadoNd := ANode.Childrens.FindAnyNs('infGlobalizado');
  if Assigned(infGlobalizadoNd) then
    CTe.infCTeNorm.infGlobalizado.xObs := ObterConteudo(infGlobalizadoNd.Childrens.FindAnyNs('xObs'), tcStr);

  AuxNode := ANode.Childrens.FindAnyNs('infServVinc');
  if Assigned(AuxNode) then
  begin
    CTe.infCTeNorm.infServVinc.infCTeMultimodal.Clear;
    ANodeArr := AuxNode.Childrens.FindAllAnyNs('infCTeMultimodal');
    for i := 0 to Length(ANodeArr)-1 do
    begin
      CTe.infCTeNorm.infServVinc.infCTeMultimodal.New;
      CTe.infCTeNorm.infServVinc.infCTeMultimodal[i].chCTeMultimodal := ObterConteudo(ANodeArr[i].Childrens.FindAnyNs('chCTeMultimodal'), tcStr);
    end;
  end;
end;

procedure TCTeXmlReader.Ler_InfCTeComp(ANode: TACBrXmlNode);
var
  infCteCompNd: TACBrXmlNode;
  infCTeCompArr: TACBrXmlNodeArray;
  i: Integer;
begin
  if not Assigned(ANode) then exit;

  if CTe.infCTe.versao <= 3 then
  begin
    infCTeCompNd := ANode.Childrens.FindAnyNs('infCteComp');

    if Assigned(infCTeCompNd) then
      CTe.InfCTeComp.Chave := ObterConteudo(infCTeCompNd.Childrens.FindAnyNs('chCTe'), tcStr);
  end
  else
  begin
    infCTeCompArr := ANode.Childrens.FindAllAnyNs('infCteComp');
    CTe.InfCTeComp10.Clear;

    for i := 0 to Length(infCTeCompArr)-1 do
    begin
      CTe.InfCTeComp10.New;
      CTe.InfCTeComp10[i].chCTe := ObterConteudo(infCTeCompArr[i].Childrens.FindAnyNs('chCTe'), tcStr);
    end;
  end;
end;

procedure TCTeXmlReader.Ler_InfCTeAnu(ANode: TACBrXmlNode);
begin
  if not Assigned(ANode) then exit;

  CTe.InfCTeAnu.chCTe := ObterConteudo(ANode.Childrens.FindAnyNs('chCte'), tcStr);
  CTe.InfCTeAnu.dEmi := ObterConteudo(ANode.Childrens.FindAnyNs('dEmi'), tcDat);
end;

procedure TCTeXmlReader.Ler_InfCTeSub(infCteSubNd: TACBrXmlNode; infCTeSub: TInfCteSub);
var
  indAlteraToma: string;
  tomaICMSNd, refNFNd, tomaNaoICMSNd: TACBrXmlNode;
begin
  if not Assigned(infCTeSubNd) then exit;

  infCTeSub.chCte := ObterConteudo(infCTeSubNd.Childrens.FindAnyNs('chCte'), tcStr);
  infCTeSub.refCteAnu := ObterConteudo(infCTeSubNd.Childrens.FindAnyNs('refCteAnu'), tcStr);

  indAlteratoma := ObterConteudo(infCTeSubNd.Childrens.FindAnyNs('indAlteraToma'), tcStr);

  if indAlteratoma <> '' then
    infCTeSub.indAlteraToma := StrToTIndicador(indAlteraToma);

  tomaICMSNd := infCTeSubNd.Childrens.FindAnyNs('tomaICMS');

  if Assigned(tomaICMSNd) then
  begin
    infCTeSub.tomaICMS.refNFe := ObterConteudo(tomaICMSNd.Childrens.FindAnyNs('refNFe'), tcStr);
    infCTeSub.tomaICMS.refCte := ObterConteudo(tomaICMSNd.Childrens.FindAnyNs('refCte'), tcStr);

    refNFNd := tomaICMSNd.Childrens.FindAnyNs('refNF');

    if Assigned(refNFNd) then
    begin
      infCTeSub.tomaICMS.refNF.CNPJCPF := ObterCNPJCPF(refNFNd);
      infCTeSub.tomaICMS.refNF.modelo := ObterConteudo(refNFNd.Childrens.FindAnyNs('mod'), tcStr);
      infCTeSub.tomaICMS.refNF.serie := ObterConteudo(refNFNd.Childrens.FindAnyNs('serie'), tcInt);
      infCTeSub.tomaICMS.refNF.subserie := ObterConteudo(refNFNd.Childrens.FindAnyNs('subserie'), tcInt);
      infCTeSub.tomaICMS.refNF.nro := ObterConteudo(refNFNd.Childrens.FindAnyNs('nro'), tcInt);
      infCTeSub.tomaICMS.refNF.valor := ObterConteudo(refNFNd.Childrens.FindAnyNs('valor'), tcDe2);
      infCTeSub.tomaICMS.refNF.dEmi := ObterConteudo(refNFNd.Childrens.FindAnyNs('dEmi'), tcDat);
    end;
  end;

  tomaNaoICMSNd := infCTeSubNd.Childrens.FindAnyNs('tomaNaoICMS');
  if Assigned(tomaNaoICMSNd) then
    infCTeSub.tomaNaoICMS.refCteAnu := ObterConteudo(tomaNaoICMSNd.Childrens.FindAnyNs('refCteAnu'), tcStr);
end;

procedure TCTeXmlReader.Ler_InfCTeSupl(infCTeSuplNd: TACBrXmlNode);
begin
  if not Assigned(InfCTeSuplNd) then exit;

  CTe.infCTeSupl.qrCodCTe := ObterConteudo(infCTeSuplNd.Childrens.Find('qrCodCTe'), tcStr);
  CTe.infCTeSupl.qrCodCTe := StringReplace(CTe.infCTeSupl.qrCodCTe, '<![CDATA[', '', []);
  CTe.infCTeSupl.qrCodCTe := StringReplace(CTe.infCTeSupl.qrCodCTe, ']]>', '', []);
end;

procedure TCTeXmlReader.Ler_InfDocAnt(ANode: TACBrXmlNode;
  infDocAnt: TinfDocAntCollection);
var
  i, j: Integer;
  ok: Boolean;
  infArr, infNFeArr: TACBrXmlNodeArray;
begin
  if not Assigned(ANode) then exit;

  infdocAnt.Clear;

  infArr := ANode.Childrens.FindAllAnyNs('infDocAnt');

  for i := 0 to Length(infArr)-1 do
  begin
    infdocAnt.New;

    infdocAnt[i].chCTe := ObterConteudo(infArr[i].Childrens.FindAnyNs('chCTe'), tcStr);
    infdocAnt[i].tpPrest := StrTotpPrest(ok, ObterConteudo(infArr[i].Childrens.FindAnyNs('tpPrest'), tcStr));

    infdocAnt[i].infNFeTranspParcial.Clear;

    infNFeArr := infArr[i].Childrens.FindAllAnyNs('infNFeTranspParcial');

    for j := 0 to Length(infNFeArr)-1 do
    begin
      infdocAnt[i].infNFeTranspParcial.New;

      infdocAnt[i].infNFeTranspParcial[j].chNFe := ObterConteudo(infArr[i].Childrens.FindAnyNs('chNFe'), tcStr);
    end;
  end;
end;

procedure TCTeXmlReader.Ler_InfEspecie(ANodeArr: TACBrXmlNodeArray);
var
  i: Integer;
  Ok: Boolean;
begin
  CTe.detGTV.infEspecie.Clear;
  for i := 0 to Length(ANodeArr)-1 do
  begin
    CTe.detGTV.infEspecie.New;
    CTe.detGTV.infEspecie[i].tpEspecie := StrToTEspecie(ok, ObterConteudo(ANodeArr[i].Childrens.FindAnyNs('tpEspecie'), tcStr));
    CTe.detGTV.infEspecie[i].vEspecie := ObterConteudo(ANodeArr[i].Childrens.FindAnyNs('vEspecie'), tcDe2);
    CTe.detGTV.infEspecie[i].tpNumerario := StrTotpNumerario(ok, ObterConteudo(ANodeArr[i].Childrens.FindAnyNs('tpNumerario'), tcStr));
    CTe.detGTV.infEspecie[i].xMoedaEstr := ObterConteudo(ANodeArr[i].Childrens.FindAnyNs('xMoedaEstr'), tcStr);
  end;
end;

procedure TCTeXmlReader.Ler_InfGTVe(infGTVeArr: TACBrXmlNodeArray);
var
  i, j: Integer;
  compArr: TACBrXmlNodeArray;
  Ok: Boolean;
begin
  for i := 0 to Length(infGTVeArr)-1 do
  begin
    CTe.infCTeNorm.infGTVe.New;
    CTe.infCTeNorm.infGTVe[i].chCTe := ObterConteudo(infGTVeArr[i].Childrens.FindAnyNs('chCTe'), tcStr);

    CTe.infCTeNorm.infGTVe[i].Comp.Clear;
    compArr := infGTVeArr[i].Childrens.FindAllAnyNs('Comp');
    for j := 0 to Length(compArr)-1 do
    begin
      CTe.infCTeNorm.infGTVe[i].Comp.New;
      CTe.infCTeNorm.infGTVe[i].Comp[j].tpComp := StrTotpComp(Ok, ObterConteudo(compArr[j].Childrens.FindAnyNs('tpComp'), tcStr));
      CTe.infCTeNorm.infGTVe[i].Comp[j].vComp := ObterConteudo(compArr[j].Childrens.FindAnyNs('vComp'), tcDe2);
      CTe.infCTeNorm.infGTVe[i].Comp[j].xComp := ObterConteudo(compArr[j].Childrens.FindAnyNs('xComp'), tcStr);
    end;
  end;
end;

procedure TCTeXmlReader.Ler_InfModal(ANode: TACBrXmlNode);
begin
  if not Assigned(ANode) then exit;

  Ler_Rodo(ANode.Childrens.FindAnyNs('rodo'), CTe.infModal.rodo);
  Ler_Aereo(ANode.Childrens.FindAnyNs('aereo'), CTe.infModal.aereo);
  Ler_Aquav(ANode.Childrens.FindAnyNs('aquav'), CTe.infModal.aquav);
end;

procedure TCTeXmlReader.Ler_InfNFe(ANode: TACBrXmlNode; infNFe: TInfNFeCollection);
var
  infArr, infUnidArr, UnidArr, ANodeArr: TACBrXmlNodeArray;
  i, j, k, l: Integer;
begin
  if not Assigned(ANode) then exit;
  infArr := ANode.Childrens.FindAllAnyNs('infNFe');

  InfNFE.Clear;
  for i := 0 to Length(infArr)-1 do
  begin
    InfNFE.New;
    InfNFE[i].chave := ObterConteudo(infArr[i].Childrens.FindAnyNs('chave'), tcStr);

    if InfNFE[i].chave = '' then
      InfNFE[i].chave := ObterConteudo(infArr[i].Childrens.FindAnyNs('chNFe'), tcStr);

    InfNFE[i].PIN := ObterConteudo(infArr[i].Childrens.FindAnyNs('PIN'), tcStr);
    InfNFE[i].dPrev := ObterConteudo(infArr[i].Childrens.FindAnyNs('dPrev'), tcDat);

    infUnidArr := infArr[i].Childrens.FindAllAnyNs('infUnidTransp');
    for j := 0 to Length(infUnidArr)-1 do
    begin
      InfNFE[i].infUnidTransp.New;
      InfNFE[i].infUnidTransp[j].tpUnidTransp := StrToUnidTransp(ObterConteudo(infUnidArr[j].Childrens.FindAnyNs('tpUnidTransp'), tcStr));
      InfNFE[i].infUnidTransp[j].idUnidTransp := ObterConteudo(infUnidArr[j].Childrens.FindAnyNs('idUnidTransp'), tcStr);
      infNFE[i].infUnidTransp[j].qtdRat := ObterConteudo(infUnidArr[j].Childrens.FindAnyNs('qtdRat'), tcDe2);

      UnidArr := infUnidArr[j].Childrens.FindAllAnyNs('lacUnidTransp');
      for k := 0 to Length(UnidArr)-1 do
      begin
        InfNFE[i].infUnidTransp[j].lacUnidTransp.New;
        InfNFE[i].infUnidTransp[j].lacUnidTransp[k].nLacre := ObterConteudo(UnidArr[k].Childrens.FindAnyNs('nLacre'), tcStr);
      end;

      UnidArr := infUnidArr[j].Childrens.FindAllAnyNs('infUnidCarga');
      for k := 0 to Length(UnidArr)-1 do
      begin
        InfNFE[i].infUnidTransp[j].infUnidCarga.New;
        InfNFE[i].infUnidTransp[j].infUnidCarga[k].tpUnidCarga := StrToUnidCarga(ObterConteudo(UnidArr[k].Childrens.FindAnyNS('tpUnidCarga'), tcStr));
        InfNFE[i].infUnidTransp[j].infUnidCarga[k].idUnidCarga := ObterConteudo(UnidArr[k].Childrens.FindAnyNs('idUnidCarga'), tcStr);
        InfNFE[i].infUnidTransp[j].infUnidCarga[k].qtdRat := ObterConteudo(UnidArr[k].Childrens.FindAnyNs('qtdRat'), tcDe2);

        ANodeArr := UnidArr[k].Childrens.FindAllAnyNs('lacUnidCarga');
        for l := 0 to Length(ANodeArr)-1 do
        begin
          InfNFE[i].infUnidTransp[j].infUnidCarga[k].lacUnidCarga.New;
          InfNFE[i].infUnidTransp[j].infUnidCarga[k].lacUnidCarga[l].nLacre := ObterConteudo(ANodeArr[l].Childrens.FindAnyNs('nLacre'), tcStr);
        end;
      end;
    end;

    UnidArr := infArr[i].Childrens.FindAllAnyNs('infUnidCarga');
    for j := 0 to Length(UnidArr)-1 do
    begin
      infNFE[i].infUnidCarga.New;
      infNFE[i].infUnidCarga[j].tpUnidCarga := StrToUnidCarga(ObterConteudo(UnidArr[j].Childrens.FindAnyNs('tpUnidCarga'), tcStr));
      infNFE[i].infUnidCarga[j].idUnidCarga := ObterConteudo(UnidArr[j].Childrens.FindAnyNs('idUnidCarga'), tcStr);
      infNFE[i].infUnidCarga[j].qtdRat := ObterConteudo(UnidArr[j].Childrens.FindAnyNs('qtdRat'), tcDe2);

      ANodeArr := UnidArr[j].Childrens.FindAllAnyNs('lacUnidCarga');
      for k := 0 to Length(ANodeArr)-1 do
      begin
        infNFE[i].infUnidCarga[j].lacUnidCarga.New;
        infNFE[i].infUnidCarga[j].lacUnidCarga[k].nLacre := ObterConteudo(ANodeArr[k].Childrens.FindAnyNs('nLacre'), tcStr);
      end;
    end;
  end;
end;

procedure TCTeXmlReader.Ler_InfDCe(ANode: TACBrXmlNode);
var
  infArr: TACBrXmlNodeArray;
  i: Integer;
begin
  if not Assigned(ANode) then exit;
  infArr := ANode.Childrens.FindAllAnyNs('infDCe');

  CTe.infCTeNorm.infDoc.InfDCe.Clear;
  for i := 0 to Length(infArr)-1 do
  begin
    CTe.infCTeNorm.infDoc.InfDCe.New;
    CTe.infCTeNorm.infDoc.InfDCe[i].chave := ObterConteudo(infArr[i].Childrens.FindAnyNs('chave'), tcStr);
  end;
end;

procedure TCTeXmlReader.Ler_InfPercurso(ANode: TACBrXmlNode);
var
  infPercurso: TACBrXmlNodeArray;
  i: integer;
begin
  if not Assigned(ANode) then exit;

  infPercurso := ANode.Childrens.FindAllAnyNs('infPercurso');

  CTe.Ide.InfPercurso.Clear;
  for i := 0 to Length(infPercurso)-1 do
  begin
    with CTe.Ide.InfPercurso.New do
      UFPer := ObterConteudo(infPercurso[i].Childrens.FindAnyNs('UFPer'), tcStr);
  end;
end;

procedure TCTeXmlReader.Ler_InfRespTec(ANode: TACBrXmlNode);
begin
  if not Assigned(ANode) then exit;

  CTe.infRespTec.CNPJ := ObterConteudo(ANode.Childrens.FindAnyNs('CNPJ'), tcStr);
  CTe.infRespTec.xContato := ObterConteudo(ANode.Childrens.FindAnyNs('xContato'), tcStr);
  CTe.infRespTec.email := ObterConteudo(ANode.Childrens.FindAnyNs('email'), tcStr);
  CTe.infRespTec.fone := ObterConteudo(ANode.Childrens.FindAnyNs('fone'), tcStr);
  CTe.infRespTec.idCSRT := ObterConteudo(ANode.Childrens.FindAnyNs('idCSRT'), tcInt);
  CTe.infRespTec.hashCSRT := ObterConteudo(ANode.Childrens.FindAnyNs('hashCSRT'), tcStr);
end;

procedure TCTeXmlReader.Ler_InfVeiculo(ANodeArr: TACBrXmlNodeArray);
var
  i: Integer;
begin
  CTe.detGTV.infVeiculo.Clear;

  for i := 0 to Length(ANodeArr)-1 do
  begin
    CTe.detGTV.infVeiculo.New;
    CTe.detGTV.infVeiculo[i].placa := ObterConteudo(ANodeArr[i].Childrens.FindAnyNs('placa'), tcStr);
    CTe.detGTV.infVeiculo[i].UF := ObterConteudo(ANodeArr[i].Childrens.FindAnyNs('UF'), tcStr);
    CTe.detGTV.infVeiculo[i].RNTRC := ObterConteudo(ANodeArr[i].Childrens.FindAnyNs('RNTRC'), tcStr);
  end;
end;

procedure TCTeXmlReader.Ler_MultiModal(ANode: TACBrXmlNode);
var
  OK: Boolean;
  AuxNode: TACBrXmlNode;
begin
  if not Assigned(ANode) then exit;

  CTe.infCTeNorm.multimodal.COTM := ObterConteudo(ANode.Childrens.FindAnyNs('COTM'), tcStr);
  CTe.infCTeNorm.multimodal.indNegociavel := StrToindNegociavel(ok, ObterConteudo(ANode.Childrens.FindAnyNs('indNegociavel'), tcStr));
  // dados sobre o seguro informados somente na versão 3.00
  AuxNode := ANode.Childrens.FindAnyNs('seg');

  if Assigned(AuxNode) then
  begin
    CTe.infCTeNorm.multimodal.nApol := ObterConteudo(AuxNode.Childrens.FindAnyNs('nApol'), tcStr);
    CTe.infCTeNorm.multimodal.nAver := ObterConteudo(AuxNode.Childrens.FindAnyNs('nAver'), tcStr);

    AuxNode := AuxNode.Childrens.FindAnyNs('infSeg');

    if Assigned(AuxNode) then
    begin
      CTe.infCTeNorm.multimodal.xSeg := ObterConteudo(AuxNode.Childrens.FindAnyNs('xSeg'), tcStr);
      CTe.infCTeNorm.multimodal.CNPJ := ObterConteudo(AuxNode.Childrens.FindAnyNs('CNPJ'), tcStr);
    end;
  end;
end;

procedure TCTeXmlReader.Ler_ObsCont(ANodeArr: TACBrXmlNodeArray);
var
  i: Integer;
begin
  for i := 0 to Length(ANodeArr)-1 do
  begin
    CTe.compl.ObsCont.New;
    CTe.compl.ObsCont[i].xCampo := ANodeArr[i].Attributes.Items['xCampo'].Content;
    CTe.compl.ObsCont[i].xTexto := ObterConteudo(ANodeArr[i].Childrens.FindAnyNs('xTexto'), tcStr);
  end;
end;

procedure TCTeXmlReader.Ler_ObsFisco(ANodeArr: TACBrXmlNodeArray);
var
  i: Integer;
begin
  for i := 0 to Length(ANodeArr)-1 do
  begin
    CTe.compl.ObsFisco.New;
    CTe.compl.ObsFisco[i].xCampo := ANodeArr[i].Attributes.Items['xCampo'].Content;
    CTe.compl.ObsFisco[i].xTexto := ObterConteudo(ANodeArr[i].Childrens.FindAnyNs('xTexto'), tcStr);
  end;
end;

procedure TCTeXmlReader.Ler_Origem(ANode: TACBrXmlNode);
begin
  if not Assigned(ANode) then exit;

  CTe.origem.xLgr := ObterConteudo(ANode.Childrens.FindAnyNs('xLgr'), tcStr);
  CTe.origem.Nro := ObterConteudo(ANode.Childrens.FindAnyNs('nro'), tcStr);
  CTe.origem.xCpl := ObterConteudo(ANode.Childrens.FindAnyNs('xCpl'), tcStr);
  CTe.origem.xBairro := ObterConteudo(ANode.Childrens.FindAnyNs('xBairro'), tcStr);
  CTe.origem.cMun := ObterConteudo(ANode.Childrens.FindAnyNs('cMun'), tcInt);
  CTe.origem.xMun := ObterConteudo(ANode.Childrens.FindAnyNs('xMun'), tcStr);
  CTe.origem.CEP := ObterConteudo(ANode.Childrens.FindAnyNs('CEP'), tcInt);
  CTe.origem.UF := ObterConteudo(ANode.Childrens.FindAnyNs('UF'), tcStr);
  CTe.origem.fone := ObterConteudo(ANode.Childrens.FindAnyNs('fone'), tcStr);
end;

procedure TCTeXmlReader.Ler_ProtCTe(const ANode: TACBrXmlNode);
var
  ANodeAux: TACBrXmlNode;
begin
  if not Assigned(ANode) then exit;

  ANodeAux := ANode.Childrens.FindAnyNs('infProt');

  if not Assigned(ANodeAux) then Exit;

  CTe.procCTe.tpAmb := StrToTipoAmbiente(ObterConteudo(ANodeAux.Childrens.FindAnyNs('tpAmb'), tcStr));
  CTe.procCTe.verAplic := ObterConteudo(ANodeAux.Childrens.FindAnyNs('verAplic'), tcStr);
  CTe.procCTe.chDFe := ObterConteudo(ANodeAux.Childrens.FindAnyNs('chCTe'), tcStr);
  CTe.procCTe.dhRecbto := ObterConteudo(ANodeAux.Childrens.FindAnyNs('dhRecbto'), tcDatHor);
  CTe.procCTe.nProt := ObterConteudo(ANodeAux.Childrens.FindAnyNs('nProt'), tcStr);
  CTe.procCTe.digVal := ObterConteudo(ANodeAux.Childrens.FindAnyNS('digVal'), tcStr);
  CTe.procCTe.cStat := ObterConteudo(ANodeAux.Childrens.FindAnyNs('cStat'), tcInt);
  CTe.procCTe.xMotivo := ObterConteudo(ANodeAux.Childrens.FindAnyNS('xMotivo'), tcStr);
  CTe.procCTe.cMSg := ObterConteudo(ANodeAux.Childrens.FindAnyNs('cMsg'), tcInt);
  CTe.procCTe.xMsg := ObterConteudo(ANodeAux.Childrens.FindAnyNs('xMsg'), tcStr);
end;

procedure TCTeXmlReader.Ler_Receb(ANode: TACBrXmlNode);
begin
  if not Assigned(ANode) then exit;

  CTe.receb.CNPJCPF := ObterCNPJCPF(ANode);
  CTe.receb.IE := ObterConteudo(ANode.Childrens.FindAnyNs('IE'), tcStr);
  CTe.receb.xNome := ObterConteudo(ANode.Childrens.FindAnyNs('xNome'), tcStr);
  CTe.receb.fone := ObterConteudo(ANode.Childrens.FindAnyNs('fone'), tcStr);
  CTe.receb.email := ObterConteudo(ANode.Childrens.FindAnyNs('email'), tcStr);

  Ler_EnderReceb(ANode.Childrens.FindAnyNs('enderReceb'));
end;

procedure TCTeXmlReader.Ler_Rem(ANode: TACBrXmlNode);
begin
  if not Assigned(ANode) then exit;

  CTe.Rem.CNPJCPF := ObterCNPJCPF(ANode);
  CTe.Rem.IE := ObterConteudo(ANode.Childrens.FindAnyNs('IE'), tcStr);
  CTe.Rem.xNome := ObterConteudo(ANode.Childrens.FindAnyNs('xNome'), tcStr);
  CTe.Rem.xFant := ObterConteudo(ANode.Childrens.FindAnyNs('xFant'), tcStr);
  CTe.Rem.fone := ObterConteudo(ANode.Childrens.FindAnyNs('fone'), tcStr);
  CTe.Rem.email := ObterConteudo(ANode.Childrens.FindAnyNs('email'), tcStr);

  Ler_EnderReme(ANode.Childrens.FindAnyNs('enderReme'));
end;

procedure TCTeXmlReader.Ler_Rodo(ANode: TACBrXmlNode; rodo: TRodo);
var
  OK: Boolean;
  AuxNodeArr: TACBrXmlNodeArray;
  AuxNode: TACBrXmlNode;
  i: Integer;
begin
  if not Assigned(ANode) then exit;

  rodo.RNTRC := ObterConteudo(ANode.Childrens.FindAnyNs('RNTRC'), tcStr);
  rodo.dPrev := ObterConteudo(ANode.Childrens.FindAnyNs('dPrev'), tcDat);
  rodo.lota := StrToTpLotacao(ok, ObterConteudo(ANode.Childrens.FindAnyNs('lota'), tcDat));
  rodo.CIOT := ObterConteudo(ANode.Childrens.FindAnyNs('CIOT'), tcStr);

  AuxNodeArr := ANode.Childrens.FindAllAnyNs('occ');
  rodo.occ.Clear;
  for i := 0 to Length(AuxNodeArr)-1 do
  begin
    rodo.occ.New;
    rodo.occ[i].serie := ObterConteudo(AuxNodeArr[i].Childrens.FindAnyNs('serie'), tcStr);
    rodo.occ[i].nOcc := ObterConteudo(AuxNodeArr[i].Childrens.FindAnyNs('nOcc'), tcInt);
    rodo.occ[i].dEmi := ObterConteudo(AuxNodeArr[i].Childrens.FindaNyNs('dEmi'), tcDat);

    AuxNode := AuxNodeArr[i].Childrens.FindAnyNs('emiOcc');
    if Assigned(AuxNode) then
    begin
      rodo.occ[i].emiOcc.CNPJ := ObterConteudo(AuxNode.Childrens.FindAnyNs('CNPJ'), tcStr);
      rodo.occ[i].emiOcc.cInt := ObterConteudo(AuxNode.Childrens.FindAnyNs('cInt'), tcStr);
      rodo.occ[i].emiOcc.IE := ObterConteudo(AuxNode.Childrens.FindAnyNs('IE'), tcStr);
      rodo.occ[i].emiOcc.UF := ObterConteudo(AuxNode.Childrens.FindAnyNs('UF'), tcStr);
      rodo.occ[i].emiOcc.fone := ObterConteudo(AuxNode.Childrens.FindAnyNs('fone'), tcStr);
    end;
  end;

  AuxNodeArr := ANode.Childrens.FindAllAnyNs('valePed');
  rodo.valePed.Clear;
  for i := 0 to Length(AuxNodeArr)-1 do
  begin
    rodo.valePed.New;
    rodo.valePed[i].CNPJForn := ObterConteudo(AuxNodeArr[i].Childrens.FindAnyNs('CNPJForn'), tcStr);
    rodo.valePed[i].nCompra := ObterConteudo(AuxNodeArr[i].Childrens.FindAnyNs('nCompra'), tcStr);
    rodo.valePed[i].CNPJPg := ObterConteudo(AuxNodeArr[i].Childrens.FindAnyNs('CNPJPg'), tcStr);
    rodo.valePed[i].vValePed := ObterConteudo(AuxNodeArr[i].Childrens.FindAnyNs('vValePed'), tcDe2);
  end;

  AuxNodeArr := ANode.Childrens.FindAllAnyNs('veic');
  rodo.veic.Clear;
  for i := 0 to Length(AuxNodeArr)-1 do
  begin
    rodo.veic.New;
    rodo.veic[i].cInt := ObterConteudo(AuxNodeArr[i].Childrens.FindAnyNs('cInt'), tcInt);
    rodo.veic[i].RENAVAM := ObterConteudo(AuxNodeArr[i].Childrens.FindAnyNs('RENAVAM'), tcStr);
    rodo.veic[i].placa := ObterConteudo(AuxNodeArr[i].Childrens.FindAnyNs('placa'), tcStr);
    rodo.veic[i].tara := ObterConteudo(AuxNodeArr[i].Childrens.FindAnyNs('tara'), tcInt);
    rodo.veic[i].capKG := ObterConteudo(AuxNodeArr[i].Childrens.FindAnyNs('capKG'), tcInt);
    rodo.veic[i].capM3 := ObterConteudo(AuxNodeArr[i].Childrens.FindAnyNs('capM3'), tcInt);
    rodo.veic[i].tpProp := StrToTpPropriedade(ok, ObterConteudo(AuxNodeArr[i].Childrens.FindAnyNs('tpProp'), tcStr));
    rodo.veic[i].tpVeic := StrToTpVeiculo(ok, ObterConteudo(AuxNodeArr[i].Childrens.FindAnyNs('tpVeic'), tcStr));
    rodo.veic[i].tpRod := StrToTpRodado(ObterConteudo(AuxNodeArr[i].Childrens.FindAnyNs('tpRod'), tcStr));
    rodo.veic[i].tpCar := StrToTpCarroceria(ObterConteudo(AuxNodeArr[i].Childrens.FindAnyNs('tpCar'), tcStr));
    rodo.veic[i].UF := ObterConteudo(AuxNodeArr[i].Childrens.FindAnyNs('UF'), tcStr);

    AuxNode := AuxNodeArr[i].Childrens.FindAnyNs('prop');

    if Assigned(AuxNode) then
    begin
      rodo.veic[i].prop.CNPJCPF := ObterCNPJCPF(AuxNode);
      rodo.veic[i].prop.RNTRC := ObterConteudo(AuxNode.Childrens.FindAnyNs('RNTRC'), tcStr);
      rodo.veic[i].prop.xNome := ObterConteudo(AuxNode.Childrens.FindAnyNs('xNome'), tcStr);
      rodo.veic[i].prop.IE := ObterConteudo(AuxNode.Childrens.FindAnyNs('IE'), tcStr);
      rodo.veic[i].prop.UF := ObterConteudo(AuxNode.Childrens.FindAnyNs('UF'), tcStr);
      rodo.veic[i].prop.tpProp := StrToTpProp(ObterConteudo(AuxNode.Childrens.FindAnyNs('tpProp'), tcStr));
    end;
  end;

  AuxNodeArr := ANode.Childrens.FindAllAnyNs('lacRodo');
  rodo.lacRodo.Clear;
  for i := 0 to Length(AuxNodeArr)-1 do
  begin
    rodo.lacRodo.New;
    rodo.lacRodo[i].nLacre := ObterConteudo(AuxNodeArr[i].Childrens.FindAnyNs('nLacre'), tcStr);
  end;

  AuxNodeArr := ANode.Childrens.FindAllAnyNs('moto');
  Rodo.moto.Clear;
  for i := 0 to Length(AuxNodeArr)-1 do
  begin
    Rodo.moto.New;
    Rodo.moto[i].xNome := ObterConteudo(AuxNodeArr[i].Childrens.FindAnyNs('xNome'), tcStr);
    Rodo.moto[i].CPF := ObterConteudo(AuxNodeArr[i].Childrens.FindAnyNs('CPF'), tcStr);
  end;
end;

procedure TCTeXmlReader.Ler_RodoOS(ANode: TACBrXmlNode);
var
  veicNd, propNd, infFretamentoNd: TACBrXmlNode;
  Ok: Boolean;
begin
  if not Assigned(ANode) then exit;

  CTe.infCTeNorm.rodoOS.TAF := ObterConteudo(ANode.Childrens.FindAnyNs('TAF'), tcStr);
  CTe.infCTeNorm.rodoOS.NroRegEstadual := ObterConteudo(ANode.Childrens.FindAnyNs('NroRegEstadual'), tcStr);

  veicNd := ANode.Childrens.FindAnyNs('veic');

  if Assigned(veicNd) then
  begin
    CTe.infCTeNorm.rodoOS.veic.placa := ObterConteudo(veicNd.Childrens.FindAnyNs('placa'), tcStr);
    CTe.infCTeNorm.rodoOS.veic.RENAVAM := ObterConteudo(veicNd.Childrens.FindAnyNs('RENAVAM'), tcStr);
    CTe.infCTeNorm.rodoOS.veic.UF := ObterConteudo(veicNd.Childrens.FindAnyNs('UF'), tcStr);

    propNd := veicNd.Childrens.FindAnyNs('prop');

    if Assigned(propNd) then
    begin
      CTe.infCTeNorm.rodoOS.veic.prop.CNPJCPF := ObterCNPJCPF(propNd);
      CTe.infCTeNorm.rodoOS.veic.prop.TAF := ObterConteudo(propNd.Childrens.FindAnyNs('TAF'), tcStr);
      CTe.infCTeNorm.rodoOS.veic.prop.NroRegEstadual := ObterConteudo(propNd.Childrens.FindAnyNs('NroRegEstadual'), tcStr);
      CTe.infCTeNorm.rodoOS.veic.prop.xNome := ObterConteudo(propNd.Childrens.FindAnyNs('xNome'), tcStr);
      CTe.infCTeNorm.rodoOS.veic.prop.IE := ObterConteudo(propNd.Childrens.FindAnyNs('IE'), tcStr);
      CTe.infCTeNorm.rodoOS.veic.prop.UF := ObterConteudo(propNd.Childrens.FindAnyNs('UF'), tcStr);
      CTe.infCTeNorm.rodoOS.veic.prop.tpProp := StrToTpProp(ObterConteudo(propNd.Childrens.FindAnyNs('tpProp'), tcStr));
    end;
  end;

  infFretamentoNd := ANode.Childrens.FindAnyNs('infFretamento');

  if Assigned(infFretamentoNd) then
  begin
    CTe.infCTeNorm.rodoOS.infFretamento.tpFretamento := StrToTpFretamento(ok, ObterConteudo(infFretamentoNd.Childrens.FindAnyNs('tpFretamento'), tcStr));
    CTe.infCTeNorm.rodoOS.infFretamento.dhViagem := ObterConteudo(infFretamentoNd.Childrens.FindAnyNs('dhViagem'), tcDatHor);
  end;
end;

procedure TCTeXmlReader.Ler_Seg(segArr: TACBrXmlNodeArray);
var
  i: Integer;
  Ok: Boolean;
begin
  for i := 0 to Length(segArr) -1 do
  begin
    CTe.infCTeNorm.seg.New;
    CTe.infCTeNorm.seg[i].respSeg := StrToTpRspSeguro(ok, ObterConteudo(segArr[i].Childrens.FindAnyNs('respSeg'), tcStr));
    CTe.infCTeNorm.seg[i].xSeg := ObterConteudo(segArr[i].Childrens.FindAnyNs('xSeg'), tcStr);
    CTe.infCTeNorm.seg[i].nApol := ObterConteudo(segArr[i].Childrens.FindAnyNs('nApol'), tcStr);
    CTe.infCTeNorm.seg[i].nAver := ObterConteudo(segArr[i].Childrens.FindAnyNs('nAver'), tcStr);
    CTe.infCTeNorm.seg[i].vCarga := ObterConteudo(segArr[i].Childrens.FindAnyNs('vCarga'), tcDe2);
  end;
end;

procedure TCTeXmlReader.Ler_Signature(SignatureNd: TACBrXmlNode);
var
  AuxNode: TACBrXmlNode;
begin
  if not Assigned(SignatureNd) then exit;

  AuxNode := SignatureNd.Childrens.FindAnyNs('SignedInfo');
  AuxNode := AuxNode.Childrens.FindAnyNs('Reference');

  if Assigned(AuxNode) then
  begin
    CTe.signature.URI := AuxNode.Attributes.Items['URI'].Content;
    CTe.signature.DigestValue := ObterConteudo(AuxNode.Childrens.Find('DigestValue'), tcStr);
  end;

  CTe.signature.SignatureValue := ObterConteudo(SignatureNd.Childrens.Find('SignatureValue'), tcStr);

  AuxNode := SignatureNd.Childrens.FindAnyNs('KeyInfo');
  AuxNode := AuxNode.Childrens.FindAnyNs('X509Data');

  if Assigned(AuxNode) then
    CTe.signature.X509Certificate := ObterConteudo(AuxNode.Childrens.Find('X509Certificate'), tcStr);
end;

procedure TCTeXmlReader.Ler_Toma(ANode: TACBrXmlNode);
var
  lAux: String;
  Ok: Boolean;
begin
  if not Assigned(ANode) then exit;

  CTe.toma.CNPJCPF := ObterCNPJCPF(ANode);
  CTe.toma.IE := ObterConteudo(ANode.Childrens.FindAnyNs('IE'), tcStr);
  CTe.toma.xNome := ObterConteudo(ANode.Childrens.FindAnyNs('xNome'), tcStr);
  CTe.toma.xFant := ObterConteudo(ANode.Childrens.FindAnyNs('xFant'), tcStr);
  CTe.toma.fone := ObterConteudo(ANode.Childrens.FindAnyNs('fone'), tcStr);
  CTe.toma.email := ObterConteudo(ANode.Childrens.FindAnyNs('email'), tcStr);

  lAux := ObterConteudo(ANode.Childrens.FindAnyNs('toma'), tcStr);
  if lAux <> '' then
    CTe.toma.toma := StrToTpTomador(Ok, lAux);

  lAux := ObterConteudo(ANode.Childrens.FindAnyNs('indIEToma'), tcStr);
  if lAux <> '' then
    CTe.toma.indIEToma := StrToindIEDest(lAux);

  Ler_TomaEnderToma(ANode.Childrens.FindAnyNs('enderToma'));
end;

procedure TCTeXmlReader.Ler_Toma03(ANode: TACBrXmlNode);
var
  tomaNode: TACBrXmlNode;
  Ok: Boolean;
begin
  if not Assigned(ANode) then exit;

  tomaNode := ANode.Childrens.FindAnyNs('toma03');

  if not Assigned(tomaNode) then
    tomaNode := ANode.Childrens.FindAnyNs('toma3');

  if not Assigned(tomaNode) then
    tomaNode := ANode.Childrens.FindAnyNs('toma');

  if not Assigned(tomaNode) then exit;

  CTe.Ide.toma03.Toma := StrToTpTomador(Ok, ObterConteudo(tomaNode.Childrens.FindAnyNs('toma'), tcStr));
end;

procedure TCTeXmlReader.Ler_Toma04(ANode: TACBrXmlNode);
var
  tomaNode: TACBrXmlNode;
  OK: Boolean;
begin
  if not Assigned(ANode) then exit;

  tomaNode := ANode.Childrens.FindAnyNs('toma4');

  if not Assigned(tomaNode) then
    tomaNode := ANode.Childrens.FindAnyNs('tomaTerceiro');

  if not Assigned(tomaNode) then exit;

  CTe.Ide.toma4.toma := StrToTpTomador(OK, ObterConteudo(tomaNode.Childrens.FindAnyNs('toma'), tcStr));
  CTe.Ide.toma03.Toma := CTe.Ide.toma4.Toma;

  CTe.Ide.toma4.CNPJCPF := ObterCNPJCPF(tomaNode);
  CTe.Ide.toma4.IE := ObterConteudo(tomaNode.Childrens.FindAnyNs('IE'), tcStr);
  CTe.Ide.toma4.xNome := ObterConteudo(tomaNode.Childrens.FindAnyNs('xNome'), tcStr);
  CTe.Ide.toma4.xFant := ObterConteudo(tomaNode.Childrens.FindAnyNs('xFant'), tcStr);
  CTe.Ide.toma4.fone := ObterConteudo(tomaNode.Childrens.FindAnyNs('fone'), tcStr);
  CTe.Ide.toma4.email := ObterConteudo(tomaNode.Childrens.FindAnyNs('email'), tcStr);

  Ler_Toma04EnderToma(tomaNode.Childrens.FindAnyNs('enderToma'));
end;

procedure TCTeXmlReader.Ler_Toma04EnderToma(ANode: TACBrXmlNode);
begin
  if not Assigned(ANode) then exit;

  CTe.Ide.Toma4.EnderToma.xLgr := ObterConteudo(ANode.Childrens.FindAnyNs('xLgr'), tcStr);
  CTe.Ide.Toma4.EnderToma.nro := ObterConteudo(ANode.Childrens.FindAnyNs('nro'), tcStr);
  CTe.Ide.Toma4.EnderToma.xCpl := ObterConteudo(ANode.Childrens.FindAnyNs('xCpl'), tcStr);
  CTe.Ide.Toma4.EnderToma.xBairro := ObterConteudo(ANode.Childrens.FindAnyNs('xBairro'), tcStr);
  CTe.Ide.Toma4.EnderToma.cMun := ObterConteudo(ANode.Childrens.FindAnyNs('cMun'), tcInt);
  CTe.Ide.Toma4.EnderToma.xMun := ObterConteudo(ANode.Childrens.FindAnyNs('xMun'), tcStr);
  CTe.Ide.Toma4.EnderToma.CEP := ObterConteudo(ANode.Childrens.FindAnyNs('CEP'), tcInt);
  CTe.Ide.Toma4.EnderToma.UF := ObterConteudo(ANode.Childrens.FindAnyNs('UF'), tcStr);
  CTe.Ide.Toma4.EnderToma.cPais := ObterConteudo(ANode.Childrens.FindAnyNs('cPais'), tcInt);
  CTe.Ide.Toma4.EnderToma.xPais := ObterConteudo(ANode.Childrens.FindAnyNs('xPais'), tcStr);
end;

procedure TCTeXmlReader.Ler_TomaEnderToma(ANode: TACBrXmlNode);
begin
  if not Assigned(ANode) then exit;

  CTe.toma.EnderToma.xLgr := ObterConteudo(ANode.Childrens.FindAnyNs('xLgr'), tcStr);
  CTe.toma.EnderToma.nro := ObterConteudo(ANode.Childrens.FindAnyNs('nro'), tcStr);
  CTe.toma.EnderToma.xCpl := ObterConteudo(ANode.Childrens.FindAnyNs('xCpl'), tcStr);
  CTe.toma.EnderToma.xBairro := ObterConteudo(ANode.Childrens.FindAnyNs('xBairro'), tcStr);
  CTe.toma.EnderToma.cMun := ObterConteudo(ANode.Childrens.FindAnyNs('cMun'), tcInt);
  CTe.toma.EnderToma.xMun := ObterConteudo(ANode.Childrens.FindAnyNs('xMun'), tcStr);
  CTe.toma.EnderToma.CEP := ObterConteudo(ANode.Childrens.FindAnyNs('CEP'), tcInt);
  CTe.toma.EnderToma.UF := ObterConteudo(ANode.Childrens.FindAnyNs('UF'), tcStr);
  CTe.toma.EnderToma.cPais := ObterConteudo(ANode.Childrens.FindAnyNs('cPais'), tcInt);
  CTe.toma.EnderToma.xPais := ObterConteudo(ANode.Childrens.FindANyNs('xPais'), tcStr);
end;

procedure TCTeXmlReader.Ler_Total(ANode: TACBrXmlNode);
begin
  if not Assigned(ANode) then exit;

  CTe.total.vTPrest := ObterConteudo(ANode.Childrens.FindAnyNs('vTPrest'), tcDe2);
  CTe.total.vTPrestLiq := ObterConteudo(ANode.Childrens.FindAnyNs('vTPrestLiq'), tcDe2);
  CTe.total.vTRec := ObterConteudo(ANode.Childrens.FindAnyNs('vTRec'), tcDe2);

  Ler_IBSCBSTot(ANode.Childrens.FindAnyNs('IBSCBSTot'), CTe.total.IBSCBSTot);

  if CTe.ide.tpCTe = tcCTeSimp then
    CTe.Imp.vTotDFe := ObterConteudo(ANode.Childrens.FindAnyNs('vTotDFe'), tcDe2);
end;

procedure TCTeXmlReader.Ler_VeicNovos(veicArr: TACBrXmlNodeArray);
var
  i: Integer;
begin
  CTe.infCTeNorm.veicNovos.Clear;
  for i := 0 to Length(veicArr)-1 do
  begin
    CTe.infCTeNorm.veicNovos.New;
    CTe.infCTeNorm.veicNovos[i].chassi := ObterConteudo(veicArr[i].Childrens.FindAnyNs('chassi'), tcStr);
    CTe.infCTeNorm.veicNovos[i].cCor := ObterConteudo(veicArr[i].Childrens.FindAnyNs('cCor'), tcStr);
    CTe.infCTeNorm.veicNovos[i].xCor := ObterConteudo(veicArr[i].Childrens.FindAnyNs('xCor'), tcStr);
    CTe.infCTeNorm.veicNovos[i].cMod := ObterConteudo(veicArr[i].Childrens.FindAnyNs('cMod'), tcStr);
    CTe.infCTeNorm.veicNovos[i].vUnit := ObterConteudo(veicArr[i].Childrens.FindAnyNs('vUnit'), tcDe2);
    CTe.infCTeNorm.veicNovos[i].vFrete := ObterConteudo(veicArr[i].Childrens.FindAnyNs('vFrete'), tcDe2);
  end;
end;

procedure TCTeXmlReader.Ler_VPrest(ANode: TACBrXmlNode);
begin
  if not Assigned(ANode) then exit;

  CTe.vPrest.vTPrest := ObterConteudo(ANode.Childrens.FindAnyNs('vTPrest'), tcDe2);
  CTe.vPrest.vTPrestLiq := ObterConteudo(ANode.Childrens.FindAnyNs('vTPrestLiq'), tcDe2);
  CTe.vPrest.vRec := ObterConteudo(ANode.Childrens.FindAnyNs('vRec'), tcDe2);

  Ler_Comp(ANode.Childrens.FindAllAnyNs('Comp'), CTe.vPrest.Comp);
end;

function TCTeXmlReader.LerXml: Boolean;
var
  infCTeNode, CTeNode: TACBrXmlNode;
  att: TACBrXmlAttribute;
begin
  if not Assigned(FCTe) or (FCTe = nil) then
    raise Exception.Create('Destino não informado, informe a classe [TCTe] de destino.');

  if EstaVazio(Arquivo) then
    raise Exception.Create('Arquivo Xml do CTe não carregado.');

  infCTeNode := nil;
  Document.Clear();
  Document.LoadFromXml(Arquivo);

  if Document.Root.Name = 'cteProc' then
  begin
    Ler_ProtCTe(Document.Root.Childrens.FindAnyNs('protCTe'));
    CTeNode := Document.Root.Childrens.FindAnyNs('CTe');
  end
  else
  begin
    if Document.Root.Name = 'cteOSProc' then
    begin
      Ler_ProtCTe(Document.Root.Childrens.FindAnyNs('protCTe'));
      CTeNode := Document.Root.Childrens.FindAnyNs('CTeOS');
    end
    else
    begin
      if Document.Root.Name = 'cteSimpProc' then
      begin
        Ler_ProtCTe(Document.Root.Childrens.FindAnyNs('protCTe'));
        CTeNode := Document.Root.Childrens.FindAnyNs('CTeSimp');
      end
      else
      begin
        if Document.Root.Name = 'GTVeProc' then
        begin
          Ler_ProtCTe(Document.Root.Childrens.FindAnyNs('protCTe'));
          CTeNode := Document.Root.Childrens.FindAnyNs('GTVe');
        end
        else
        begin
          CTeNode := Document.Root;
        end;
      end;
    end;
  end;

  if Assigned(CTeNode) then
    infCTeNode := CTeNode.Childrens.FindAnyNs('infCte');

  if not Assigned(infCTeNode) then
    raise Exception.Create('Arquivo Xml incorreto.');

  att := infCTeNode.Attributes.Items['Id'];
  if not Assigned(att) then
    raise Exception.Create('Não encontrei o atributo: Id.');

  CTe.infCTe.Id := att.Content;

  att := infCTeNode.Attributes.Items['versao'];
  if not Assigned(att) then
    raise Exception.Create('Não encontrei o atributo: versão.');

  CTe.infCTe.versao := StringToFloat(att.Content);

  Ler_InfCTe(infCTeNode);
  Ler_InfCTeSupl(CTeNode.Childrens.FindAnyNs('infCTeSupl'));
  Ler_Signature(CTeNode.Childrens.FindAnyNs('Signature'));

  Result := True;
end;

procedure TCTeXmlReader.Ler_CTe(const ANode: TACBrXmlNode);
begin
  if not Assigned(ANode) then exit;

  Ler_Compl(ANode.Childrens.FindAnyNs('compl'));
  Ler_Emit(ANode.Childrens.FindAnyNs('emit'));
  Ler_Rem(ANode.Childrens.FindAnyNs('rem'));
  Ler_Exped(ANode.Childrens.FindAnyNs('exped'));
  Ler_Receb(ANode.Childrens.FindANyNs('receb'));
  Ler_Dest(ANode.Childrens.FindAnyNs('dest'));
  Ler_VPrest(ANode.Childrens.FindAnyNs('vPrest'));
  Ler_Imp(ANode.Childrens.FindAnyNs('imp'));
  Ler_pgtoVinc(ANode.Childrens.Find('pgtoVinc'), CTe.pgtoVinc);
  Ler_InfCTeNorm(ANode.Childrens.FindAnyNs('infCTeNorm'));
  Ler_InfCTeComp(ANode);
  Ler_InfCTeAnu(ANode.Childrens.FindAnyNs('infCteAnu'));
  Ler_AutXML(ANode);
  Ler_InfRespTec(ANode.Childrens.FindAnyNs('infRespTec'));
end;

procedure TCTeXmlReader.Ler_CTeOS(const ANode: TACBrXmlNode);
begin
  if not Assigned(ANode) then exit;

  Ler_Compl(ANode.Childrens.FindAnyNs('compl'));
  Ler_Emit(ANode.Childrens.FindAnyNs('emit'));
  Ler_Toma(ANode.Childrens.FindAnyNs('toma'));
  Ler_VPrest(ANode.Childrens.FindAnyNs('vPrest'));
  Ler_Imp(ANode.Childrens.FindAnyNs('imp'));
  Ler_pgtoVinc(ANode.Childrens.Find('pgtoVinc'), CTe.pgtoVinc);
  Ler_InfCTeNorm(ANode.Childrens.FindAnyNs('infCTeNorm'));
  Ler_InfCTeComp(ANode);
  Ler_AutXML(ANode);
  Ler_InfRespTec(ANode.Childrens.FindAnyNs('infRespTec'));
end;

procedure TCTeXmlReader.Ler_CTeSimp(const ANode: TACBrXmlNode);
begin
  if not Assigned(ANode) then exit;

  Ler_Compl(ANode.Childrens.FindAnyNs('compl'));
  Ler_Emit(ANode.Childrens.FindAnyNs('emit'));
  Ler_Toma(ANode.Childrens.FindAnyNs('toma'));
  Ler_InfCarga(ANode.Childrens.FindAnyNs('infCarga'), CTe.infCarga);
  Ler_Det(ANode);
  Ler_InfModal(ANode.Childrens.FindAnyNs('infModal'));
  Ler_Cobr(ANode.Childrens.FindAnyNs('cobr'));
  Ler_InfCTeSub(ANode.Childrens.FindAnyNs('infCteSub'), CTe.infCTeSub);
  Ler_Imp(ANode.Childrens.FindAnyNs('imp'));
  Ler_pgtoVinc(ANode.Childrens.Find('pgtoVinc'), CTe.pgtoVinc);
  Ler_Total(ANode.Childrens.FindAnyNs('total'));
  Ler_AutXML(ANode);
  Ler_InfRespTec(ANode.Childrens.FindAnyNs('infRespTec'));
end;

procedure TCTeXmlReader.Ler_GTVe(const ANode: TACBrXmlNode);
begin
  if not Assigned(ANode) then exit;

  Ler_Compl(ANode.Childrens.FindAnyNs('compl'));
  Ler_Emit(ANode.Childrens.FindAnyNs('emit'));
  Ler_Rem(ANode.Childrens.FindAnyNs('rem'));
  Ler_Dest(ANode.Childrens.FindAnyNs('dest'));
  Ler_Origem(ANode.Childrens.FindAnyNs('origem'));
  Ler_Destino(ANode.Childrens.FindAnyNs('destino'));
  Ler_DetGTVe(ANode.Childrens.FindAnyNs('detGTV'));
  Ler_AutXML(ANode);
  Ler_InfRespTec(ANode.Childrens.FindAnyNs('infRespTec'));
end;

procedure TCTeXmlReader.ValidarXML(out infCTeNode, CTeNode: TACBrXmlNode);
var
  att: TACBrXmlAttribute;
begin
  if not Assigned(FCTe) or (FCTe = nil) then
    raise Exception.Create('Destino não informado, informe a classe [TCTe] de destino.');

  if EstaVazio(Arquivo) then
    raise Exception.Create('Arquivo Xml do CTe não carregado.');

  infCTeNode := nil;
  Document.Clear();
  Document.LoadFromXml(Arquivo);

  if Document.Root.Name = 'cteProc' then
  begin
    Ler_ProtCTe(Document.Root.Childrens.FindAnyNs('protCTe'));
    CTeNode := Document.Root.Childrens.FindAnyNs('CTe');
  end
  else
  begin
    if Document.Root.Name = 'cteOSProc' then
    begin
      Ler_ProtCTe(Document.Root.Childrens.FindAnyNs('protCTe'));
      CTeNode := Document.Root.Childrens.FindAnyNs('CTeOS');
    end
    else
    begin
      if Document.Root.Name = 'cteSimpProc' then
      begin
        Ler_ProtCTe(Document.Root.Childrens.FindAnyNs('protCTe'));
        CTeNode := Document.Root.Childrens.FindAnyNs('CTeSimp');
      end
      else
      begin
        if Document.Root.Name = 'GTVeProc' then
        begin
          Ler_ProtCTe(Document.Root.Childrens.FindAnyNs('protCTe'));
          CTeNode := Document.Root.Childrens.FindAnyNs('GTVe');
        end
        else
        begin
          CTeNode := Document.Root;
        end;
      end;
    end;
  end;

  if Assigned(CTeNode) then
    infCTeNode := CTeNode.Childrens.FindAnyNs('infCte');

  if not Assigned(infCTeNode) then
    raise Exception.Create('Arquivo Xml incorreto.');

  att := infCTeNode.Attributes.Items['Id'];
  if not Assigned(att) then
    raise Exception.Create('Não encontrei o atributo: Id.');

  CTe.infCTe.Id := att.Content;

  att := infCTeNode.Attributes.Items['versao'];
  if not Assigned(att) then
    raise Exception.Create('Não encontrei o atributo: versão.');

  CTe.infCTe.versao := StringToFloat(att.Content);
end;

end.
