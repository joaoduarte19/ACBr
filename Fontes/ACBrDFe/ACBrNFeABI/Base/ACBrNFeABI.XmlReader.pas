{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Italo Giurizzato Junior                         }
{                              MXM Sistemas                                    }
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

unit ACBrNFeABI.XmlReader;

interface

uses
  Classes, SysUtils,
  ACBrXmlDocument, ACBrXmlReader,
  ACBrDFe.RTC.XmlReader,
  ACBrDFeComum.Proc,
  ACBrNFeABI.Classes;

type

  { TNFeABIXmlReader }
  TNFeABIXmlReader = class(TDFeRTCXmlReader)
  private
    FNFeABI: TNFeABI;

    procedure Ler_InfNFeABI(const ANode: TACBrXmlNode);
    procedure Ler_Ide(const ANode: TACBrXmlNode; Ide: TIde);
    procedure Ler_gModNat(const ANode: TACBrXmlNode; gModNat: TgModNat);
    procedure Ler_gCont(const ANode: TACBrXmlNode; gCont: TgCont);
    procedure Ler_NFref(const ANode: TACBrXmlNode; NFref: TNFrefCollection);
    procedure Ler_Emit(const ANode: TACBrXmlNode; Emit: Temit);
    procedure Ler_Endereco(const ANode: TACBrXmlNode; Endereco: TEndereco);
    procedure Ler_Transmit(const ANode: TACBrXmlNode; transmit: tTransmitCollection);
    procedure Ler_Adquirente(const ANode: TACBrXmlNode; adquirente: tadquirenteCollection);
    procedure Ler_Imovel(const ANode: TACBrXmlNode; Imovel: Timovel);
    procedure Ler_Cadastro(const ANode: TACBrXmlNode; Cadastro: TCadastro);
    procedure Ler_autXML(const ANode: TACBrXmlNode; autXML: TautXMLCollection);
    procedure Ler_infOper(const ANode: TACBrXmlNode; infOper: TinfOper);
    procedure Ler_gTorna(const ANode: TACBrXmlNode; gTorna: TgTorna);
    procedure Ler_imovelTorna(const ANode: TACBrXmlNode; imovelTorna: TimovelTornaCollection);
    procedure Ler_gIncorpLote(const ANode: TACBrXmlNode; gIncorpLote: TgIncorpLote);
    procedure Ler_gRedAjusteImovel(const ANode: TACBrXmlNode; gRedAjusteImovel: TgRedAjusteImovel);
    procedure Ler_instrumento(const ANode: TACBrXmlNode; instrumento: Tinstrumento);
    procedure Ler_gIntermedCorret(const ANode: TACBrXmlNode; gIntermedCorret: tgIntermedCorretCollection);
    procedure Ler_ginfTrib(const ANode: TACBrXmlNode; ginfTrib: TginfTrib);
    procedure Ler_pag(const ANode: TACBrXmlNode; pag: Tpag);
    procedure Ler_detPagImovel(const ANode: TACBrXmlNode; detPagImovel: tdetPagImovelCollection);
    procedure Ler_detPagIncorpLote(const ANode: TACBrXmlNode; detPagIncorpLote: tdetPagIncorpLoteCollection);
    procedure Ler_Total(const ANode: TACBrXmlNode; total: Ttotal);
    procedure Ler_tribTot(const ANode: TACBrXmlNode; total: Ttotal);
    procedure Ler_InfAdic(const ANode: TACBrXmlNode; infAdic: TinfAdic);
    procedure Ler_ObsCont(const ANode: TACBrXmlNode; ObsCont: tObsContCollection);
    procedure Ler_ObsFisco(const ANode: TACBrXmlNode; ObsFisco: tObsFiscoCollection);
    procedure Ler_infRespTec(const ANode: TACBrXmlNode; infRespTec: TinfRespTec);
    procedure Ler_ProtNFeABI(const ANode: TACBrXmlNode; procNFeABI: TProcDFe);
    procedure Ler_InfNFeSupl(const ANode: TACBrXmlNode; infNFeSupl: TinfNFeSupl);

  public
    constructor Create(AOwner: TNFeABI); reintroduce;

    function LerXml: Boolean; override;

    property NFeABI: TNFeABI read FNFeABI write FNFeABI;

  end;

implementation

uses
  ACBrUtil.Base,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrNFeABI.Conversao;

{ TNFeABIXmlReader }

constructor TNFeABIXmlReader.Create(AOwner: TNFeABI);
begin
  inherited Create;

  FNFeABI := AOwner;
end;

procedure TNFeABIXmlReader.Ler_InfNFeABI(const ANode: TACBrXmlNode);
var
  i: Integer;
  ANodes: TACBrXmlNodeArray;
begin
  if not Assigned(ANode) then Exit;

  Ler_Ide(ANode.Childrens.Find('ide'), NFeABI.Ide);

  ANodes := ANode.Childrens.FindAll('NFref');
  for i := 0 to Length(ANodes) - 1 do
  begin
    Ler_NFref(ANodes[i], NFeABI.NFref);
  end;

  Ler_Emit(ANode.Childrens.Find('emit'), NFeABI.emit);

  ANodes := ANode.Childrens.FindAll('transmit');
  for i := 0 to Length(ANodes) - 1 do
  begin
    Ler_Transmit(ANodes[i], NFeABI.transmit);
  end;

  ANodes := ANode.Childrens.FindAll('adquirente');
  for i := 0 to Length(ANodes) - 1 do
  begin
    Ler_Adquirente(ANodes[i], NFeABI.adquirente);
  end;

  Ler_Imovel(ANode.Childrens.Find('imovel'), NFeABI.imovel);

  ANodes := ANode.Childrens.FindAll('autXML');
  for i := 0 to Length(ANodes) - 1 do
  begin
    Ler_autXML(ANodes[i], NFeABI.autXML);
  end;

  Ler_infOper(ANode.Childrens.Find('infOper'), NFeABI.infOper);
  Ler_gInfTrib(ANode.Childrens.Find('gInfTrib'), NFeABI.gInfTrib);
  Ler_pag(ANode.Childrens.Find('pag'), NFeABI.pag);
  Ler_total(ANode.Childrens.Find('total'), NFeABI.total);
  Ler_infAdic(ANode.Childrens.Find('infAdic'), NFeABI.infAdic);
  Ler_infRespTec(ANode.Childrens.Find('infRespTec'), NFeABI.infRespTec);
end;

procedure TNFeABIXmlReader.Ler_Ide(const ANode: TACBrXmlNode; Ide: TIde);
begin
  if not Assigned(ANode) then Exit;

  ide.cUF := ObterConteudo(ANode.Childrens.Find('cUF'), tcInt);
  ide.cNF := ObterConteudo(ANode.Childrens.Find('cNF'), tcInt);
  ide.modelo := ObterConteudo(ANode.Childrens.Find('mod'), tcInt);
  ide.serie := ObterConteudo(ANode.Childrens.Find('serie'), tcInt);
  ide.nNF := ObterConteudo(ANode.Childrens.Find('nNF'), tcInt);
  ide.dhEmi := ObterConteudo(ANode.Childrens.Find('dhEmi'), tcDatHor);
  ide.tpNF := StrTotpNF(ObterConteudo(ANode.Childrens.Find('tpNF'), tcStr));
  ide.tpImp := StrTotpImp(ObterConteudo(ANode.Childrens.Find('tpImp'), tcStr));

  Ler_gModNat(ANode.Childrens.Find('gModNat'), Ide.gModNat);

  Ide.tpEmis := StrToTipoEmissao(ObterConteudo(ANode.Childrens.Find('tpEmis'), tcStr));
  ide.nSiteAutoriz := ObterConteudo(ANode.Childrens.Find('nSiteAutoriz'), tcInt);
  ide.cDV := ObterConteudo(ANode.Childrens.Find('cDV'), tcInt);
  Ide.tpAmb := StrToTipoAmbiente(ObterConteudo(ANode.Childrens.Find('tpAmb'), tcStr));
  Ide.finNFe := StrTofinNFe(ObterConteudo(ANode.Childrens.Find('finNFe'), tcStr));
  Ide.procEmi := StrToprocEmi(ObterConteudo(ANode.Childrens.Find('procEmi'), tcStr));
  Ide.verProc := ObterConteudo(ANode.Childrens.Find('verProc'), tcStr);

  Ler_gCont(ANode.Childrens.Find('gCont'), Ide.gCont);
end;

procedure TNFeABIXmlReader.Ler_gModNat(const ANode: TACBrXmlNode;
  gModNat: TgModNat);
begin
  if not Assigned(ANode) then Exit;

  gModNat.modOper := ObterConteudo(ANode.Childrens.Find('modOper'), tcInt);
  gModNat.natOper := ObterConteudo(ANode.Childrens.Find('natOper'), tcInt);
  gModNat.detOper := ObterConteudo(ANode.Childrens.Find('detOper'), tcInt);
end;

procedure TNFeABIXmlReader.Ler_gCont(const ANode: TACBrXmlNode; gCont: TgCont);
begin
  if not Assigned(ANode) then Exit;

  gCont.dhCont := ObterConteudo(ANode.Childrens.Find('dhCont'), tcDatHor);
  gCont.xJust := ObterConteudo(ANode.Childrens.Find('xJust'), tcStr);
end;

procedure TNFeABIXmlReader.Ler_NFref(const ANode: TACBrXmlNode;
  NFref: TNFrefCollection);
var
  Item: TNFrefCollectionItem;
begin
  if not Assigned(ANode) then
    Exit;

  Item := NFref.New;

  Item.refNFeABI := ObterConteudo(ANode.Childrens.FindAnyNs('refNFeABI'), tcStr);
end;

procedure TNFeABIXmlReader.Ler_Emit(const ANode: TACBrXmlNode; Emit: Temit);
begin
  if not Assigned(ANode) then Exit;

  emit.CNPJCPF := ObterCNPJCPF(ANode);

  emit.xNome := ObterConteudo(ANode.Childrens.Find('xNome'), tcStr);
  emit.xFant := ObterConteudo(ANode.Childrens.Find('xFant'), tcStr);

  Ler_Endereco(ANode.Childrens.Find('enderEmit'), Emit.enderEmit);

  emit.tpEmit := StrTotpEmit(ObterConteudo(ANode.Childrens.Find('tpEmit'), tcStr));
end;

procedure TNFeABIXmlReader.Ler_Endereco(const ANode: TACBrXmlNode;
  Endereco: TEndereco);
begin
  if not Assigned(ANode) then Exit;

  Endereco.xLgr := ObterConteudo(ANode.Childrens.Find('xLgr'), tcStr);
  Endereco.nro := ObterConteudo(ANode.Childrens.Find('nro'), tcStr);
  Endereco.xCpl := ObterConteudo(ANode.Childrens.Find('xCpl'), tcStr);
  Endereco.xBairro := ObterConteudo(ANode.Childrens.Find('xBairro'), tcStr);
  Endereco.cMun := ObterConteudo(ANode.Childrens.Find('cMun'), tcInt);
  Endereco.xMun := ObterConteudo(ANode.Childrens.Find('xMun'), tcStr);
  Endereco.UF := ObterConteudo(ANode.Childrens.Find('UF'), tcStr);
  Endereco.CEP := ObterConteudo(ANode.Childrens.Find('CEP'), tcStr);
  Endereco.cPais := ObterConteudo(ANode.Childrens.Find('cPais'), tcInt);

  if Endereco.cPais = 0 then
    Endereco.cPais := 1058;

  Endereco.xPais := ObterConteudo(ANode.Childrens.Find('xPais'), tcStr);

  if Endereco.xPais = '' then
    Endereco.xPais := 'BRASIL';

  Endereco.fone := ObterConteudo(ANode.Childrens.Find('fone'), tcStr);
end;

procedure TNFeABIXmlReader.Ler_Transmit(const ANode: TACBrXmlNode;
  transmit: tTransmitCollection);
var
  Item: tTransmitCollectionItem;
begin
  if not Assigned(ANode) then Exit;

  Item := transmit.New;

  Item.indDeclarante := StrToTIndicadorEx(ObterConteudo(ANode.Childrens.FindAnyNs('indDeclarante'), tcStr));
  Item.CNPJCPF := ObterCNPJCPF(ANode);
  Item.xNome := ObterConteudo(ANode.Childrens.FindAnyNs('xNome'), tcStr);

  Ler_Endereco(ANode.Childrens.Find('enderTransmit'), Item.enderTransmit);

  Item.pTransIndiv := ObterConteudo(ANode.Childrens.FindAnyNs('pTransIndiv'), tcDe4);
  Item.indContrib := StrToindContrib(ObterConteudo(ANode.Childrens.FindAnyNs('indContrib'), tcStr));
end;

procedure TNFeABIXmlReader.Ler_Adquirente(const ANode: TACBrXmlNode;
  adquirente: tadquirenteCollection);
var
  Item: tadquirenteCollectionItem;
begin
  if not Assigned(ANode) then Exit;

  Item := adquirente.New;

  Item.indDeclarante := StrToTIndicadorEx(ObterConteudo(ANode.Childrens.FindAnyNs('indDeclarante'), tcStr));
  Item.CNPJCPF := ObterCNPJCPF(ANode);
  Item.xNome := ObterConteudo(ANode.Childrens.FindAnyNs('xNome'), tcStr);

  Ler_Endereco(ANode.Childrens.Find('enderAdquirente'), Item.enderAdquirente);

  Item.pAquisicao := ObterConteudo(ANode.Childrens.FindAnyNs('pAquisicao'), tcDe4);
  Item.indContrib := StrToindContrib(ObterConteudo(ANode.Childrens.FindAnyNs('indContrib'), tcStr));
end;

procedure TNFeABIXmlReader.Ler_Imovel(const ANode: TACBrXmlNode;
  Imovel: Timovel);
begin
  if not Assigned(ANode) then Exit;

  Imovel.tipo := StrTotipo(ObterConteudo(ANode.Childrens.FindAnyNs('tipo'), tcStr));

  Ler_Cadastro(ANode.Childrens.Find('cadastro'), Imovel.cadastro);

  Imovel.espImovel := ObterConteudo(ANode.Childrens.FindAnyNs('espImovel'), tcStr);
  Imovel.xOutrosEspecies := ObterConteudo(ANode.Childrens.FindAnyNs('xOutrosEspecies'), tcStr);
  Imovel.enquadramento := ObterConteudo(ANode.Childrens.FindAnyNs('enquadramento'), tcStr);

  Ler_Endereco(ANode.Childrens.Find('enderImovel'), Imovel.enderImovel);

  Imovel.obsLocalImovel := ObterConteudo(ANode.Childrens.FindAnyNs('obsLocalImovel'), tcStr);
  Imovel.areaTotal := ObterConteudo(ANode.Childrens.FindAnyNs('areaTotal'), tcDe2);
  Imovel.uAreaTotal := StrTouareaTotal(ObterConteudo(ANode.Childrens.FindAnyNs('uAreaTotal'), tcStr));
  Imovel.cartorioRegistro := ObterConteudo(ANode.Childrens.FindAnyNs('cartorioRegistro'), tcStr);
  Imovel.matricTransc := ObterConteudo(ANode.Childrens.FindAnyNs('matricTransc'), tcStr);
end;

procedure TNFeABIXmlReader.Ler_Cadastro(const ANode: TACBrXmlNode;
  Cadastro: TCadastro);
begin
  if not Assigned(ANode) then Exit;

  Cadastro.cCIB := ObterConteudo(ANode.Childrens.FindAnyNs('cCIB'), tcStr);
  Cadastro.indIPTU := StrToTIndicador(ObterConteudo(ANode.Childrens.FindAnyNs('indIPTU'), tcStr));
  Cadastro.nIptu := ObterConteudo(ANode.Childrens.FindAnyNs('nIptu'), tcStr);
  Cadastro.indIncra := StrToTIndicador(ObterConteudo(ANode.Childrens.FindAnyNs('indIncra'), tcStr));
  Cadastro.nIncra := ObterConteudo(ANode.Childrens.FindAnyNs('nIncra'), tcStr);
end;

procedure TNFeABIXmlReader.Ler_autXML(const ANode: TACBrXmlNode;
  autXML: TautXMLCollection);
var
  Item: TautXMLCollectionItem;
begin
  if not Assigned(ANode) then
    Exit;

  Item := autXML.New;

  Item.CNPJCPF := ObterCNPJCPF(ANode);
end;

procedure TNFeABIXmlReader.Ler_infOper(const ANode: TACBrXmlNode;
  infOper: TinfOper);
var
  i: Integer;
  ANodes: TACBrXmlNodeArray;
begin
  if not Assigned(ANode) then Exit;

  infOper.pTransImovel := ObterConteudo(ANode.Childrens.FindAnyNs('pTransImovel'), tcDe4);
  infOper.vTotalOperacao := ObterConteudo(ANode.Childrens.FindAnyNs('vTotalOperacao'), tcDe2);
  infOper.indTorna := StrToTIndicador(ObterConteudo(ANode.Childrens.FindAnyNs('indTorna'), tcStr));

  Ler_gTorna(ANode.Childrens.Find('gTorna'), infOper.gTorna);
  Ler_gIncorpLote(ANode.Childrens.Find('gIncorpLote'), infOper.gIncorpLote);
  Ler_gRedAjusteImovel(ANode.Childrens.Find('gRedAjusteImovel'), infOper.gRedAjusteImovel);

  infOper.indRedSocial := StrToTIndicador(ObterConteudo(ANode.Childrens.FindAnyNs('indRedSocial'), tcStr));
  infOper.vRedSocial := ObterConteudo(ANode.Childrens.FindAnyNs('vRedSocial'), tcDe2);

  Ler_instrumento(ANode.Childrens.Find('instrumento'), infOper.instrumento);

  infOper.indIntermedCorret := StrToTIndicador(ObterConteudo(ANode.Childrens.FindAnyNs('indIntermedCorret'), tcStr));

  ANodes := ANode.Childrens.FindAll('gIntermedCorret');
  for i := 0 to Length(ANodes) - 1 do
  begin
    Ler_gIntermedCorret(ANodes[i], infOper.gIntermedCorret);
  end;
end;

procedure TNFeABIXmlReader.Ler_gTorna(const ANode: TACBrXmlNode;
  gTorna: TgTorna);
var
  i: Integer;
  ANodes: TACBrXmlNodeArray;
begin
  if not Assigned(ANode) then Exit;

  gTorna.vTorna := ObterConteudo(ANode.Childrens.FindAnyNs('vTorna'), tcDe2);

  ANodes := ANode.Childrens.FindAll('imovelTorna');
  for i := 0 to Length(ANodes) - 1 do
  begin
    Ler_imovelTorna(ANodes[i], gTorna.imovelTorna);
  end;
end;

procedure TNFeABIXmlReader.Ler_imovelTorna(const ANode: TACBrXmlNode;
  imovelTorna: TimovelTornaCollection);
var
  Item: TimovelTornaCollectionItem;
begin
  if not Assigned(ANode) then Exit;

  Item := imovelTorna.New;

  Item.Imovel.tipo := StrToTipo(ObterConteudo(ANode.Childrens.FindAnyNs('tipo'), tcStr));

  Ler_Cadastro(ANode.Childrens.Find('cadastro'), Item.Imovel.cadastro);

  Item.Imovel.espImovel := ObterConteudo(ANode.Childrens.FindAnyNs('espImovel'), tcStr);
  Item.Imovel.xOutrosEspecies := ObterConteudo(ANode.Childrens.FindAnyNs('xOutrosEspecies'), tcStr);
  Item.Imovel.enquadramento := ObterConteudo(ANode.Childrens.FindAnyNs('enquadramento'), tcStr);

  Ler_Endereco(ANode.Childrens.Find('enderImovel'), Item.Imovel.enderImovel);

  Item.Imovel.obsLocalImovel := ObterConteudo(ANode.Childrens.FindAnyNs('obsLocalImovel'), tcStr);
  Item.Imovel.areaTotal := ObterConteudo(ANode.Childrens.FindAnyNs('areaTotal'), tcDe2);
  Item.Imovel.uAreaTotal := StrTouareaTotal(ObterConteudo(ANode.Childrens.FindAnyNs('uAreaTotal'), tcStr));
  Item.Imovel.cartorioRegistro := ObterConteudo(ANode.Childrens.FindAnyNs('cartorioRegistro'), tcStr);
  Item.Imovel.matricTransc := ObterConteudo(ANode.Childrens.FindAnyNs('matricTransc'), tcStr);
end;

procedure TNFeABIXmlReader.Ler_gIncorpLote(const ANode: TACBrXmlNode;
  gIncorpLote: TgIncorpLote);
begin
  if not Assigned(ANode) then Exit;

  gIncorpLote.indIncorpLote := StrToTIndicador(ObterConteudo(ANode.Childrens.FindAnyNs('indIncorpLote'), tcStr));
  gIncorpLote.CNPJempImob := ObterConteudo(ANode.Childrens.FindAnyNs('CNPJempImob'), tcStr);
  gIncorpLote.cCIBObra := ObterConteudo(ANode.Childrens.FindAnyNs('cCIBObra'), tcStr);
end;

procedure TNFeABIXmlReader.Ler_gRedAjusteImovel(const ANode: TACBrXmlNode;
  gRedAjusteImovel: TgRedAjusteImovel);
begin
  if not Assigned(ANode) then Exit;

  gRedAjusteImovel.vInicial := ObterConteudo(ANode.Childrens.FindAnyNs('vInicial'), tcDe2);
  gRedAjusteImovel.vITBI := ObterConteudo(ANode.Childrens.FindAnyNs('vITBI'), tcDe2);
  gRedAjusteImovel.vLaudemio := ObterConteudo(ANode.Childrens.FindAnyNs('vLaudemio'), tcDe2);
  gRedAjusteImovel.vContrap := ObterConteudo(ANode.Childrens.FindAnyNs('vContrap'), tcDe2);
  gRedAjusteImovel.vRedAjusteImovel := ObterConteudo(ANode.Childrens.FindAnyNs('vRedAjusteImovel'), tcDe2);
end;

procedure TNFeABIXmlReader.Ler_instrumento(const ANode: TACBrXmlNode;
  instrumento: Tinstrumento);
begin
  if not Assigned(ANode) then Exit;

  instrumento.tpInstrumento := ObterConteudo(ANode.Childrens.FindAnyNs('tpInstrumento'), tcInt);
  instrumento.xOutrosInst := ObterConteudo(ANode.Childrens.FindAnyNs('xOutrosInst'), tcStr);
  instrumento.dtInstrumento := ObterConteudo(ANode.Childrens.FindAnyNs('dtInstrumento'), tcDat);
end;

procedure TNFeABIXmlReader.Ler_gIntermedCorret(const ANode: TACBrXmlNode;
  gIntermedCorret: tgIntermedCorretCollection);
var
  Item: tgIntermedCorretCollectionItem;
begin
  if not Assigned(ANode) then Exit;

  Item := gIntermedCorret.New;

  Item.CNPJCPF := ObterCNPJCPF(ANode);
  Item.xNome := ObterConteudo(ANode.Childrens.FindAnyNs('xNome'), tcStr);
  Item.vCorretagem := ObterConteudo(ANode.Childrens.FindAnyNs('vCorretagem'), tcDe2);
end;

procedure TNFeABIXmlReader.Ler_ginfTrib(const ANode: TACBrXmlNode;
  ginfTrib: TginfTrib);
begin
  if not Assigned(ANode) then Exit;

  Ler_gCompraGovReduzido(ANode.Childrens.FindAnyNs('gCompraGov'), ginfTrib.gCompraGov);
  Ler_IBSCBS(ANode.Childrens.FindAnyNs('IBSCBS'), ginfTrib.IBSCBS);
end;

procedure TNFeABIXmlReader.Ler_pag(const ANode: TACBrXmlNode; pag: Tpag);
var
  i: Integer;
  ANodes: TACBrXmlNodeArray;
begin
  if not Assigned(ANode) then Exit;

  ANodes := ANode.Childrens.FindAll('detPagImovel');
  for i := 0 to Length(ANodes) - 1 do
  begin
    Ler_detPagImovel(ANodes[i], pag.detPagImovel);
  end;

  ANodes := ANode.Childrens.FindAll('detPagIncorpLote');
  for i := 0 to Length(ANodes) - 1 do
  begin
    Ler_detPagIncorpLote(ANodes[i], pag.detPagIncorpLote);
  end;
end;

procedure TNFeABIXmlReader.Ler_detPagImovel(const ANode: TACBrXmlNode;
  detPagImovel: tdetPagImovelCollection);
var
  Item: tdetPagImovelCollectionItem;
begin
  if not Assigned(ANode) then Exit;

  Item := detPagImovel.New;

  Item.tPag := ObterConteudo(ANode.Childrens.FindAnyNs('tPag'), tcInt);
  Item.xPag := ObterConteudo(ANode.Childrens.FindAnyNs('xPag'), tcStr);
  Item.vPag := ObterConteudo(ANode.Childrens.FindAnyNs('vPag'), tcDe2);
end;

procedure TNFeABIXmlReader.Ler_detPagIncorpLote(const ANode: TACBrXmlNode;
  detPagIncorpLote: tdetPagIncorpLoteCollection);
var
  Item: tdetPagIncorpLoteCollectionItem;
begin
  if not Assigned(ANode) then Exit;

  Item := detPagIncorpLote.New;

  Item.tParcela := ObterConteudo(ANode.Childrens.FindAnyNs('tParcela'), tcStr);
  Item.nParcela := ObterConteudo(ANode.Childrens.FindAnyNs('nParcela'), tcInt);
  Item.xParcela := ObterConteudo(ANode.Childrens.FindAnyNs('xParcela'), tcStr);
end;

procedure TNFeABIXmlReader.Ler_Total(const ANode: TACBrXmlNode; total: Ttotal);
begin
  if not Assigned(ANode) then Exit;

  total.vTotalOperacao := ObterConteudo(ANode.Childrens.FindAnyNs('vTotalOperacao'), tcDe2);
  total.vOperacIndiv := ObterConteudo(ANode.Childrens.FindAnyNs('vOperacIndiv'), tcDe2);

  Ler_tribTot(ANode.Childrens.FindAnyNs('tribTot'), total);

  total.vNF := ObterConteudo(ANode.Childrens.FindAnyNs('vNF'), tcDe2);
end;

procedure TNFeABIXmlReader.Ler_tribTot(const ANode: TACBrXmlNode;
  total: Ttotal);
begin
  if not Assigned(ANode) then Exit;

  total.vRedAjusteIndiv := ObterConteudo(ANode.Childrens.FindAnyNs('vRedAjusteIndiv'), tcDe2);
  total.vRedSocialIndiv := ObterConteudo(ANode.Childrens.FindAnyNs('vRedSocialIndiv'), tcDe2);
  total.vBC := ObterConteudo(ANode.Childrens.FindAnyNs('vBC'), tcDe2);
  total.vIBSUF := ObterConteudo(ANode.Childrens.FindAnyNs('vIBSUF'), tcDe2);
  total.vIBSMun := ObterConteudo(ANode.Childrens.FindAnyNs('vIBSMun'), tcDe2);
  total.vCBS := ObterConteudo(ANode.Childrens.FindAnyNs('vCBS'), tcDe2);
end;

procedure TNFeABIXmlReader.Ler_InfAdic(const ANode: TACBrXmlNode;
  infAdic: TinfAdic);
var
  i: Integer;
  ANodes: TACBrXmlNodeArray;
begin
  if not Assigned(ANode) then Exit;

  InfAdic.infAdFisco := ObterConteudo(ANode.Childrens.Find('infAdFisco'), tcStr);
  InfAdic.infCpl := ObterConteudo(ANode.Childrens.Find('infCpl'), tcStr);

  ANodes := ANode.Childrens.FindAll('obsCont');
  for i := 0 to Length(ANodes) - 1 do
  begin
    Ler_obsCont(ANodes[i], InfAdic.obsCont);
  end;

  ANodes := ANode.Childrens.FindAll('obsFisco');
  for i := 0 to Length(ANodes) - 1 do
  begin
    Ler_obsFisco(ANodes[i], infAdic.obsFisco);
  end;
end;

procedure TNFeABIXmlReader.Ler_ObsCont(const ANode: TACBrXmlNode;
  ObsCont: tObsContCollection);
var
  Item: TobservacoesCollectionItem;
begin
  if not Assigned(ANode) then Exit;

  Item := ObsCont.New;

  Item.xCampo := ANode.Attributes.Items['xCampo'].Content;
  Item.xTexto := ObterConteudo(ANode.Childrens.Find('xTexto'), tcStr);
end;

procedure TNFeABIXmlReader.Ler_ObsFisco(const ANode: TACBrXmlNode;
  ObsFisco: tObsFiscoCollection);
var
  Item: TobservacoesCollectionItem;
begin
  if not Assigned(ANode) then Exit;

  Item := ObsFisco.New;

  Item.xCampo := ANode.Attributes.Items['xCampo'].Content;
  Item.xTexto := ObterConteudo(ANode.Childrens.Find('xTexto'), tcStr);
end;

procedure TNFeABIXmlReader.Ler_infRespTec(const ANode: TACBrXmlNode;
  infRespTec: TinfRespTec);
begin
  if not Assigned(ANode) then Exit;

  infRespTec.CNPJ := ObterConteudo(ANode.Childrens.Find('CNPJ'), tcStr);
  infRespTec.xContato := ObterConteudo(ANode.Childrens.Find('xContato'), tcStr);
  infRespTec.email := ObterConteudo(ANode.Childrens.Find('email'), tcStr);
  infRespTec.fone := ObterConteudo(ANode.Childrens.Find('fone'), tcStr);
end;

procedure TNFeABIXmlReader.Ler_ProtNFeABI(const ANode: TACBrXmlNode; procNFeABI: TProcDFe);
var
  AuxNode: TACBrXmlNode;
begin
  if not Assigned(ANode) then Exit;

  AuxNode := ANode.Childrens.Find('infProt');

  if not Assigned(AuxNode) then Exit;

  procNFeABI.tpAmb    := StrToTipoAmbiente(ObterConteudo(AuxNode.Childrens.Find('tpAmb'), tcStr));
  procNFeABI.verAplic := ObterConteudo(AuxNode.Childrens.Find('verAplic'), tcStr);
  procNFeABI.chDFe    := ObterConteudo(AuxNode.Childrens.Find('chNFeABI'), tcStr);
  procNFeABI.dhRecbto := ObterConteudo(AuxNode.Childrens.Find('dhRecbto'), tcDatHor);
  procNFeABI.nProt    := ObterConteudo(AuxNode.Childrens.Find('nProt'), tcStr);
  procNFeABI.digVal   := ObterConteudo(AuxNode.Childrens.Find('digVal'), tcStr);
  procNFeABI.cStat    := ObterConteudo(AuxNode.Childrens.Find('cStat'), tcInt);
  procNFeABI.xMotivo  := ObterConteudo(AuxNode.Childrens.Find('xMotivo'), tcStr);
  procNFeABI.cMsg     := ObterConteudo(AuxNode.Childrens.Find('cMsg'), tcInt);
  procNFeABI.xMsg     := ObterConteudo(AuxNode.Childrens.Find('xMsg'), tcStr);
end;

procedure TNFeABIXmlReader.Ler_InfNFeSupl(const ANode: TACBrXmlNode;
  infNFeSupl: TinfNFeSupl);
begin
  if not Assigned(ANode) then Exit;

  infNFeSupl.qrCode := ObterConteudo(ANode.Childrens.Find('qrCodNFeABI'), tcStr);
  infNFeSupl.qrCode := StringReplace(NFeABI.infNFeSupl.qrCode, '<![CDATA[', '', []);
  infNFeSupl.qrCode := StringReplace(NFeABI.infNFeSupl.qrCode, ']]>', '', []);
  infNFeSupl.urlChave := ObterConteudo(ANode.Childrens.Find('urlChave'), tcStr);
end;

function TNFeABIXmlReader.LerXml: Boolean;
var
  NFeABINode, infNFeABINode: TACBrXmlNode;
  att: TACBrXmlAttribute;
begin
  Result := False;

  if not Assigned(FNFeABI) then
    raise Exception.Create('Destino não informado, informe a classe [TNFeABI] de destino.');

  if EstaVazio(Arquivo) then
    raise Exception.Create('Arquivo xml da NFeABI não carregado.');

  Document.Clear();
  Document.LoadFromXml(Arquivo);

  if Document.Root.Name = 'NFeABIProc' then
  begin
    Ler_ProtNFeABI(Document.Root.Childrens.Find('protNFeABI'), NFeABI.procNFeABI);
    NFeABINode := Document.Root.Childrens.Find('NFeABI');
  end
  else
  begin
    NFeABINode := Document.Root;
  end;

  if NFeABINode <> nil then
  begin
    infNFeABINode := NFeABINode.Childrens.Find('infNFeABI');

    if infNFeABINode = nil then
      raise Exception.Create('Arquivo xml incorreto.');

    att := infNFeABINode.Attributes.Items['Id'];
    if att = nil then
      raise Exception.Create('Não encontrei o atributo: Id');

    NFeABI.infNFeABI.Id := att.Content;

    att := infNFeABINode.Attributes.Items['versao'];
    if att = nil then
      raise Exception.Create('Não encontrei o atributo: versao');

    NFeABI.infNFeABI.Versao := StringToFloat(att.Content);

    Ler_InfNFeABI(infNFeABINode);
    Ler_InfNFeSupl(NFeABINode.Childrens.Find('infNFeSupl'), NFeABI.infNFeSupl);
    LerSignature(NFeABINode.Childrens.Find('Signature'), NFeABI.signature);

    Result := True;
  end;
end;

end.

