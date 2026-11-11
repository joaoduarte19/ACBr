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

unit ACBrNFeABI.IniReader;

interface

uses
  Classes, SysUtils,
  IniFiles,
  ACBrNFeABI.Classes,
  ACBrNFeABI.Conversao,
  ACBrDFe.RTC.IniReader,
  ACBrDFeComum.Proc,
  ACBrDFe.Conversao;

type
  { TNFeABIIniReader }

  TNFeABIIniReader = class(TDFeRTCIniReader)
  private
    FNFeABI: TNFeABI;
    FVersaoDF: TVersaoNFeABI;
    FAmbiente: Integer;
    FtpEmis: Integer;
    sSecao: string;
    sFim: string;

    procedure Ler_Identificacao(AINIRec: TMemIniFile; Ide: TIde);
    procedure Ler_NFref(AINIRec: TMemIniFile; NFref: TNFrefCollection);
    procedure Ler_Emitente(AINIRec: TMemIniFile; Emit: TEmit);
    procedure Ler_Transmit(AINIRec: TMemIniFile; transmit: tTransmitCollection);
    procedure Ler_Adquirente(AINIRec: TMemIniFile; adquirente: tadquirenteCollection);
    procedure Ler_Imovel(AINIRec: TMemIniFile; Imovel: Timovel);
    procedure Ler_autXML(AINIRec: TMemIniFile; autXML: TautXMLCollection);
    procedure Ler_infOper(AINIRec: TMemIniFile; infOper: TinfOper);
    procedure Ler_imovelTorna(AINIRec: TMemIniFile; imovelTorna: timovelTornaCollection);
    procedure Ler_gIntermedCorret(AINIRec: TMemIniFile; gIntermedCorret: tgIntermedCorretCollection);
    procedure Ler_ginfTrib(AINIRec: TMemIniFile; ginfTrib: TginfTrib);
    procedure Ler_pag(AINIRec: TMemIniFile; pag: Tpag);
    procedure Ler_detPagImovel(AINIRec: TMemIniFile; detPagImovel: tdetPagImovelCollection);
    procedure Ler_detPagIncorpLote(AINIRec: TMemIniFile; detPagIncorpLote: tdetPagIncorpLoteCollection);
    procedure Ler_Total(AINIRec: TMemIniFile; total: Ttotal);
    procedure Ler_InfAdic(AINIRec: TMemIniFile; infAdic: TinfAdic);
    procedure Ler_ObsCont(AINIRec: TMemIniFile; ObsCont: tObsContCollection);
    procedure Ler_ObsFisco(AINIRec: TMemIniFile; ObsFisco: tObsFiscoCollection);
    procedure Ler_infRespTec(AINIRec: TMemIniFile; infRespTec: TinfRespTec);
    procedure Ler_ProtNFeABI(AINIRec: TMemIniFile; procNFeABI: TProcDFe);
  public
    constructor Create(AOwner: TNFeABI); reintroduce;

    function LerIni(const AIniString: string): Boolean;

    property NFeABI: TNFeABI read FNFeABI write FNFeABI;
    property VersaoDF: TVersaoNFeABI read FVersaoDF write FVersaoDF;
    property Ambiente: Integer read FAmbiente write FAmbiente;
    property tpEmis: Integer read FtpEmis write FtpEmis;
  end;

implementation

uses
  ACBrXmlBase,
  ACBrNFeABI,
  ACBrUtil.Base,
  ACBrUtil.Strings,
  ACBrUtil.FilesIO,
  ACBrUtil.DateTime;

{ TNFeABIIniReader }

constructor TNFeABIIniReader.Create(AOwner: TNFeABI);
begin
  inherited Create;

  FNFeABI := AOwner;
end;

function TNFeABIIniReader.LerIni(const AIniString: string): Boolean;
var
  INIRec: TMemIniFile;
begin
  Result := True;

  INIRec := TMemIniFile.Create('');
  try
    LerIniArquivoOuString(AIniString, INIRec);

    FNFeABI.infNFeABI.versao := StringToFloatDef(INIRec.ReadString('infNFeABI', 'versao', VersaoNFeABIToStr(VersaoDF)),0);

    Ler_Identificacao(INIRec, FNFeABI.Ide);
    Ler_NFref(INIRec,FNFeABI.NFref);
    Ler_Emitente(INIRec, FNFeABI.Emit);
    Ler_transmit(INIRec, NFeABI.transmit);
    Ler_adquirente(INIRec, NFeABI.adquirente);
    Ler_Imovel(INIRec, NFeABI.imovel);
    Ler_autXML(INIRec, FNFeABI.autXML);
    Ler_infOper(INIRec, FNFeABI.infOper);
    Ler_ginfTrib(INIRec, FNFeABI.gInfTrib);
    Ler_pag(INIRec, FNFeABI.pag);
    Ler_Total(INIRec, FNFeABI.total);
    Ler_InfAdic(INIRec, FNFeABI.infAdic);
    Ler_infRespTec(INIRec, FNFeABI.infRespTec);
    Ler_ProtNFeABI(INIRec, FNFeABI.procNFeABI);
  finally
    INIRec.Free;
  end;
end;

procedure TNFeABIIniReader.Ler_Identificacao(AINIRec: TMemIniFile; Ide: TIde);
begin
  sSecao := 'ide';
  Ide.tpAmb := StrToTipoAmbiente(AINIRec.ReadString(sSecao, 'tpAmb', IntToStr(Ambiente)));
  Ide.modelo := AINIRec.ReadInteger(sSecao, 'Modelo', 77);
  Ide.serie := AINIRec.ReadInteger(sSecao, 'Serie', 1);
  Ide.nNF := AINIRec.ReadInteger(sSecao, 'nNF', 0);
  Ide.cNF := AINIRec.ReadInteger(sSecao, 'cNF', 0);
  Ide.dhEmi := StringToDateTime(AINIRec.ReadString(sSecao, 'dhEmi', '0'));
  Ide.tpEmis := StrToTipoEmissao(AINIRec.ReadString(sSecao, 'tpEmis', IntToStr(tpEmis)));
  Ide.nSiteAutoriz := StrToSiteAutorizator(AINIRec.ReadString(sSecao, 'nSiteAutoriz', '0'));
  Ide.verProc := AINIRec.ReadString(sSecao, 'verProc', 'ACBrNFCom');
end;

procedure TNFeABIIniReader.Ler_NFref(AINIRec: TMemIniFile;
  NFref: TNFrefCollection);
var
  I: Integer;
begin
  I := 1 ;
  while true do
  begin
    sSecao := 'NFref' + IntToStrZero(I, 3) ;
    sFim   := AINIRec.ReadString(sSecao, 'refNFeABI', 'FIM');
    if (sFim = 'FIM') or (Length(sFim) <= 0) then
      break ;

    NFref.New.refNFeABI := sFim;

    Inc(I);
  end;
end;

procedure TNFeABIIniReader.Ler_Emitente(AINIRec: TMemIniFile; Emit: TEmit);
begin
  sSecao := 'emit';
  Emit.CNPJCPF := AINIRec.ReadString(sSecao, 'CNPJCPF', '');
  Emit.xNome := AINIRec.ReadString(sSecao, 'xNome', '');
  Emit.tpEmit := StrTotpEmit(AINIRec.ReadString(sSecao, 'tpEmit', '1'));
  // Endereço do Emitente
  Emit.EnderEmit.xLgr := AINIRec.ReadString(sSecao, 'xLgr', '');
  Emit.EnderEmit.nro := AINIRec.ReadString(sSecao, 'nro', '');
  Emit.EnderEmit.xCpl := AINIRec.ReadString(sSecao, 'xCpl', '');
  Emit.EnderEmit.xBairro := AINIRec.ReadString(sSecao, 'xBairro', '');
  Emit.EnderEmit.cMun := AINIRec.ReadInteger(sSecao, 'cMun', 0);
  Emit.EnderEmit.xMun := AINIRec.ReadString(sSecao, 'xMun', '');
  Emit.EnderEmit.CEP := AINIRec.ReadString(sSecao, 'CEP', '');
  Emit.EnderEmit.UF := AINIRec.ReadString(sSecao, 'UF', '');
  Emit.EnderEmit.cPais := AINIRec.ReadInteger(sSecao, 'cPais', 0);
  Emit.EnderEmit.xPais := AINIRec.ReadString(sSecao, 'xPais', '');
  Emit.EnderEmit.fone := AINIRec.ReadString(sSecao, 'fone', '');
  Emit.EnderEmit.email := AINIRec.ReadString(sSecao, 'email', '');
end;

procedure TNFeABIIniReader.Ler_Transmit(AINIRec: TMemIniFile;
  transmit: tTransmitCollection);
var
  I: Integer;
  Item: tTransmitCollectionItem;
begin
  I := 1 ;
  while true do
  begin
    sSecao := 'transmit' + IntToStrZero(I, 2) ;
    sFim   := OnlyCPFCNPJAlphaNum(AINIRec.ReadString(sSecao, 'CNPJCPF', 'FIM'));
    if (sFim = 'FIM') or (Length(sFim) <= 0) then
      break ;

    Item := transmit.New;

    Item.indDeclarante := StrToTIndicadorEx(AINIRec.ReadString(sSecao, 'indDeclarante', ''));
    Item.CNPJCPF := sFim;
    Item.xNome := AINIRec.ReadString(sSecao, 'xNome', '');
    Item.pTransIndiv := StringToFloatDef(AINIRec.ReadString(sSecao, 'pTransIndiv', ''), 0);
    Item.indContrib := StrToindContrib(AINIRec.ReadString(sSecao, 'indContrib', ''));
    // Endereço
    Item.enderTransmit.xLgr := AINIRec.ReadString(sSecao, 'xLgr', '');
    Item.enderTransmit.nro := AINIRec.ReadString(sSecao, 'nro', '');
    Item.enderTransmit.xCpl := AINIRec.ReadString(sSecao, 'xCpl', '');
    Item.enderTransmit.xBairro := AINIRec.ReadString(sSecao, 'xBairro', '');
    Item.enderTransmit.cMun := AINIRec.ReadInteger(sSecao, 'cMun', 0);
    Item.enderTransmit.xMun := AINIRec.ReadString(sSecao, 'xMun', '');
    Item.enderTransmit.UF := AINIRec.ReadString(sSecao, 'UF', '');
    Item.enderTransmit.CEP := AINIRec.ReadString(sSecao, 'CEP', '');
    Item.enderTransmit.cPais := AINIRec.ReadInteger(sSecao, 'cPais', 1058);
    Item.enderTransmit.xPais := AINIRec.ReadString(sSecao, 'xPais', 'BRASIL');
    Item.enderTransmit.fone := AINIRec.ReadString(sSecao, 'fone', '');

    Inc(I);
  end;
end;

procedure TNFeABIIniReader.Ler_Adquirente(AINIRec: TMemIniFile;
  adquirente: tadquirenteCollection);
var
  I: Integer;
  Item: tadquirenteCollectionItem;
begin
  I := 1 ;
  while true do
  begin
    sSecao := 'adquirente' + IntToStrZero(I, 2) ;
    sFim   := OnlyCPFCNPJAlphaNum(AINIRec.ReadString(sSecao, 'CNPJCPF', 'FIM'));
    if (sFim = 'FIM') or (Length(sFim) <= 0) then
      break ;

    Item := adquirente.New;

    Item.indDeclarante := StrToTIndicadorEx(AINIRec.ReadString(sSecao, 'indDeclarante', ''));
    Item.CNPJCPF := sFim;
    Item.xNome := AINIRec.ReadString(sSecao, 'xNome', '');
    Item.pAquisicao := StringToFloatDef(AINIRec.ReadString(sSecao, 'pAquisicao', ''), 0);
    Item.indContrib := StrToindContrib(AINIRec.ReadString(sSecao, 'indContrib', ''));
    // Endereço
    Item.enderAdquirente.xLgr := AINIRec.ReadString(sSecao, 'xLgr', '');
    Item.enderAdquirente.nro := AINIRec.ReadString(sSecao, 'nro', '');
    Item.enderAdquirente.xCpl := AINIRec.ReadString(sSecao, 'xCpl', '');
    Item.enderAdquirente.xBairro := AINIRec.ReadString(sSecao, 'xBairro', '');
    Item.enderAdquirente.cMun := AINIRec.ReadInteger(sSecao, 'cMun', 0);
    Item.enderAdquirente.xMun := AINIRec.ReadString(sSecao, 'xMun', '');
    Item.enderAdquirente.UF := AINIRec.ReadString(sSecao, 'UF', '');
    Item.enderAdquirente.CEP := AINIRec.ReadString(sSecao, 'CEP', '');
    Item.enderAdquirente.cPais := AINIRec.ReadInteger(sSecao, 'cPais', 1058);
    Item.enderAdquirente.xPais := AINIRec.ReadString(sSecao, 'xPais', 'BRASIL');
    Item.enderAdquirente.fone := AINIRec.ReadString(sSecao, 'fone', '');

    Inc(I);
  end;
end;

procedure TNFeABIIniReader.Ler_Imovel(AINIRec: TMemIniFile; Imovel: Timovel);
begin
  sSecao := 'imovel';
  Imovel.tipo := StrToTipo(AINIRec.ReadString(sSecao, 'tipo', ''));
  Imovel.espImovel := AINIRec.ReadString(sSecao, 'espImovel', '');
  Imovel.xOutrosEspecies := AINIRec.ReadString(sSecao, 'xOutrosEspecies', '');
  Imovel.enquadramento := AINIRec.ReadString(sSecao, 'enquadramento', '');
  Imovel.obsLocalImovel := AINIRec.ReadString(sSecao, 'obsLocalImovel', '');
  Imovel.areaTotal := StringToFloatDef(AINIRec.ReadString(sSecao, 'areaTotal', ''), 0);
  Imovel.uAreaTotal := StrTouareaTotal(AINIRec.ReadString(sSecao, 'uAreaTotal', 'm2'));
  Imovel.cartorioRegistro := AINIRec.ReadString(sSecao, 'cartorioRegistro', '');
  Imovel.matricTransc := AINIRec.ReadString(sSecao, 'matricTransc', '');
  // Cadastro do Imovel
  Imovel.cadastro.cCIB := AINIRec.ReadString(sSecao, 'cCIB', '');
  Imovel.cadastro.indIPTU := StrToTIndicador(AINIRec.ReadString(sSecao, 'indIPTU', ''));
  Imovel.cadastro.nIptu := AINIRec.ReadString(sSecao, 'nIptu', '');
  Imovel.cadastro.indIncra := StrToTIndicador(AINIRec.ReadString(sSecao, 'indIncra', ''));
  Imovel.cadastro.nIncra := AINIRec.ReadString(sSecao, 'nIncra', '');
  // Endereço do Imovel
  Imovel.enderImovel.xLgr := AINIRec.ReadString(sSecao, 'xLgr', '');
  Imovel.enderImovel.nro := AINIRec.ReadString(sSecao, 'nro', '');
  Imovel.enderImovel.xCpl := AINIRec.ReadString(sSecao, 'xCpl', '');
  Imovel.enderImovel.xBairro := AINIRec.ReadString(sSecao, 'xBairro', '');
  Imovel.enderImovel.cMun := AINIRec.ReadInteger(sSecao, 'cMun', 0);
  Imovel.enderImovel.xMun := AINIRec.ReadString(sSecao, 'xMun', '');
  Imovel.enderImovel.CEP := AINIRec.ReadString(sSecao, 'CEP', '');
  Imovel.enderImovel.UF := AINIRec.ReadString(sSecao, 'UF', '');
  Imovel.enderImovel.cPais := AINIRec.ReadInteger(sSecao, 'cPais', 0);
  Imovel.enderImovel.xPais := AINIRec.ReadString(sSecao, 'xPais', '');
  Imovel.enderImovel.fone := AINIRec.ReadString(sSecao, 'fone', '');
end;

procedure TNFeABIIniReader.Ler_autXML(AINIRec: TMemIniFile;
  autXML: TautXMLCollection);
var
  I: Integer;
begin
  I := 1 ;
  while true do
  begin
    sSecao := 'autXML' + IntToStrZero(I, 2) ;
    sFim   := OnlyCPFCNPJAlphaNum(AINIRec.ReadString(sSecao, 'CNPJCPF', 'FIM'));
    if (sFim = 'FIM') or (Length(sFim) <= 0) then
      break ;

    autXML.New.CNPJCPF := sFim;

    Inc(I);
  end;
end;

procedure TNFeABIIniReader.Ler_infOper(AINIRec: TMemIniFile; infOper: TinfOper);
begin
  sSecao := 'infOper';
  infOper.pTransImovel := StringToFloatDef(AINIRec.ReadString(sSecao, 'pTransImovel', ''), 0);
  infOper.vTotalOperacao := StringToFloatDef(AINIRec.ReadString(sSecao, 'vTotalOperacao', ''), 0);
  infOper.indTorna := StrToTIndicador(AINIRec.ReadString(sSecao, 'indTorna', ''));
  infOper.indRedSocial := StrToTIndicador(AINIRec.ReadString(sSecao, 'indRedSocial', ''));
  infOper.vRedSocial := StringToFloatDef(AINIRec.ReadString(sSecao, 'vRedSocial', ''), 0);
  infOper.indIntermedCorret := StrToTIndicador(AINIRec.ReadString(sSecao, 'indIntermedCorret', ''));
  infOper.gTorna.vTorna := StringToFloatDef(AINIRec.ReadString(sSecao, 'vTorna', ''), 0);
  infOper.gIncorpLote.indIncorpLote := StrToTIndicador(AINIRec.ReadString(sSecao, 'indIncorpLote', ''));
  infOper.gIncorpLote.CNPJempImob := AINIRec.ReadString(sSecao, 'CNPJempImob', '');
  infOper.gIncorpLote.cCIBObra := AINIRec.ReadString(sSecao, 'cCIBObra', '');

  infOper.gRedAjusteImovel.vInicial := StringToFloatDef(AINIRec.ReadString(sSecao, 'vInicial', ''), 0);
  infOper.gRedAjusteImovel.vITBI := StringToFloatDef(AINIRec.ReadString(sSecao, 'vITBI', ''), 0);
  infOper.gRedAjusteImovel.vLaudemio := StringToFloatDef(AINIRec.ReadString(sSecao, 'vLaudemio', ''), 0);
  infOper.gRedAjusteImovel.vContrap := StringToFloatDef(AINIRec.ReadString(sSecao, 'vContrap', ''), 0);
  infOper.gRedAjusteImovel.vRedAjusteImovel := StringToFloatDef(AINIRec.ReadString(sSecao, 'vRedAjusteImovel', ''), 0);

  infOper.instrumento.tpInstrumento := AINIRec.ReadInteger(sSecao, 'tpInstrumento', 0);
  infOper.instrumento.xOutrosInst := AINIRec.ReadString(sSecao, 'xOutrosInst', '');
  infOper.instrumento.dtInstrumento := StringToDateTime(AINIRec.ReadString(sSecao, 'dtInstrumento', '0'));

  Ler_imovelTorna(AINIRec, infOper.gTorna.imovelTorna);
  Ler_gIntermedCorret(AINIRec, infOper.gIntermedCorret);
end;

procedure TNFeABIIniReader.Ler_imovelTorna(AINIRec: TMemIniFile;
  imovelTorna: timovelTornaCollection);
var
  i: Integer;
begin
  I := 1;
  while true do
  begin
    sSecao := 'imovelTorna' + IntToStrZero(I, 2);
    sFim   := AINIRec.ReadString(sSecao, 'espImovel', 'FIM');
    if (sFim = 'FIM') or (Length(sFim) <= 0) then
      break;

    with imovelTorna.New do
    begin
      Imovel.tipo := StrToTipo(AINIRec.ReadString(sSecao, 'tipo', ''));
      Imovel.espImovel := sFim;
      Imovel.xOutrosEspecies := AINIRec.ReadString(sSecao, 'xOutrosEspecies', '');
      Imovel.enquadramento := AINIRec.ReadString(sSecao, 'enquadramento', '');
      Imovel.obsLocalImovel := AINIRec.ReadString(sSecao, 'obsLocalImovel', '');
      Imovel.areaTotal := StringToFloatDef(AINIRec.ReadString(sSecao, 'areaTotal', ''), 0);
      Imovel.uAreaTotal := StrTouareaTotal(AINIRec.ReadString(sSecao, 'uAreaTotal', 'm2'));
      Imovel.cartorioRegistro := AINIRec.ReadString(sSecao, 'cartorioRegistro', '');
      Imovel.matricTransc := AINIRec.ReadString(sSecao, 'matricTransc', '');
      // Cadastro do Imovel
      Imovel.cadastro.cCIB := AINIRec.ReadString(sSecao, 'cCIB', '');
      Imovel.cadastro.indIPTU := StrToTIndicador(AINIRec.ReadString(sSecao, 'indIPTU', ''));
      Imovel.cadastro.nIptu := AINIRec.ReadString(sSecao, 'nIptu', '');
      Imovel.cadastro.indIncra := StrToTIndicador(AINIRec.ReadString(sSecao, 'indIncra', ''));
      Imovel.cadastro.nIncra := AINIRec.ReadString(sSecao, 'nIncra', '');
      // Endereço do Imovel
      Imovel.enderImovel.xLgr := AINIRec.ReadString(sSecao, 'xLgr', '');
      Imovel.enderImovel.nro := AINIRec.ReadString(sSecao, 'nro', '');
      Imovel.enderImovel.xCpl := AINIRec.ReadString(sSecao, 'xCpl', '');
      Imovel.enderImovel.xBairro := AINIRec.ReadString(sSecao, 'xBairro', '');
      Imovel.enderImovel.cMun := AINIRec.ReadInteger(sSecao, 'cMun', 0);
      Imovel.enderImovel.xMun := AINIRec.ReadString(sSecao, 'xMun', '');
      Imovel.enderImovel.CEP := AINIRec.ReadString(sSecao, 'CEP', '');
      Imovel.enderImovel.UF := AINIRec.ReadString(sSecao, 'UF', '');
      Imovel.enderImovel.cPais := AINIRec.ReadInteger(sSecao, 'cPais', 0);
      Imovel.enderImovel.xPais := AINIRec.ReadString(sSecao, 'xPais', '');
      Imovel.enderImovel.fone := AINIRec.ReadString(sSecao, 'fone', '');
    end;

    Inc(I);
  end;
end;

procedure TNFeABIIniReader.Ler_gIntermedCorret(AINIRec: TMemIniFile;
  gIntermedCorret: tgIntermedCorretCollection);
var
  i: Integer;
begin
  I := 1;
  while true do
  begin
    sSecao := 'gIntermedCorret' + IntToStrZero(I, 2);
    sFim   := AINIRec.ReadString(sSecao, 'CNPJCPF', 'FIM');
    if (sFim = 'FIM') or (Length(sFim) <= 0) then
      break;

    with gIntermedCorret.New do
    begin
      CNPJCPF := sFim;
      xNome := AINIRec.ReadString(sSecao, 'xNome', '');
      vCorretagem := StringToFloatDef(AINIRec.ReadString(sSecao, 'vCorretagem', ''), 0);
    end;

    Inc(I);
  end;
end;

procedure TNFeABIIniReader.Ler_ginfTrib(AINIRec: TMemIniFile;
  ginfTrib: TginfTrib);
begin
  Ler_gCompraGovReduzido(AINIRec, ginfTrib.gCompraGov);
  Ler_IBSCBS(AINIRec, ginfTrib.IBSCBS, -1, -1);
end;

procedure TNFeABIIniReader.Ler_pag(AINIRec: TMemIniFile; pag: Tpag);
begin
  Ler_detPagImovel(AINIRec, pag.detPagImovel);
  Ler_detPagIncorpLote(AINIRec, pag.detPagIncorpLote);
end;

procedure TNFeABIIniReader.Ler_detPagImovel(AINIRec: TMemIniFile;
  detPagImovel: tdetPagImovelCollection);
var
  i: Integer;
begin
  I := 1;
  while true do
  begin
    sSecao := 'detPagImovel' + IntToStrZero(I, 2);
    sFim   := AINIRec.ReadString(sSecao, 'vPag', 'FIM');
    if (sFim = 'FIM') or (Length(sFim) <= 0) then
      break;

    with detPagImovel.New do
    begin
      tPag := AINIRec.ReadInteger(sSecao, 'tPag', 0);
      xPag := AINIRec.ReadString(sSecao, 'xPag', '');
      vPag := StringToFloatDef(sFim, 0);
    end;

    Inc(I);
  end;
end;

procedure TNFeABIIniReader.Ler_detPagIncorpLote(AINIRec: TMemIniFile;
  detPagIncorpLote: tdetPagIncorpLoteCollection);
var
  i: Integer;
begin
  I := 1;
  while true do
  begin
    sSecao := 'detPagIncorpLote' + IntToStrZero(I, 2);
    sFim   := AINIRec.ReadString(sSecao, 'tParcela', 'FIM');
    if (sFim = 'FIM') or (Length(sFim) <= 0) then
      break;

    with detPagIncorpLote.New do
    begin
      tParcela := sFim;
      nParcela := AINIRec.ReadInteger(sSecao, 'nParcela', 0);
      xParcela := AINIRec.ReadString(sSecao, 'xParcela', '');
    end;

    Inc(I);
  end;
end;

procedure TNFeABIIniReader.Ler_Total(AINIRec: TMemIniFile; total: Ttotal);
begin
  sSecao := 'total';
  total.vTotalOperacao := StringToFloatDef(AINIRec.ReadString(sSecao, 'vTotalOperacao', ''), 0);
  total.vOperacIndiv := StringToFloatDef(AINIRec.ReadString(sSecao, 'vOperacIndiv', ''), 0);
  total.vRedAjusteIndiv := StringToFloatDef(AINIRec.ReadString(sSecao, 'vRedAjusteIndiv', ''), 0);
  total.vRedSocialIndiv := StringToFloatDef(AINIRec.ReadString(sSecao, 'vRedSocialIndiv', ''), 0);
  total.vBC := StringToFloatDef(AINIRec.ReadString(sSecao, 'vBC', ''), 0);
  total.vIBSUF := StringToFloatDef(AINIRec.ReadString(sSecao, 'vIBSUF', ''), 0);
  total.vIBSMun := StringToFloatDef(AINIRec.ReadString(sSecao, 'vIBSMun', ''), 0);
  total.vCBS := StringToFloatDef(AINIRec.ReadString(sSecao, 'vCBS', ''), 0);
  total.vNF := StringToFloatDef(AINIRec.ReadString(sSecao, 'vNF', ''), 0);
end;

procedure TNFeABIIniReader.Ler_InfAdic(AINIRec: TMemIniFile; infAdic: TinfAdic);
begin
  sSecao := 'infAdic';
  infAdic.infAdFisco := AINIRec.ReadString(sSecao, 'infAdFisco', '');
  infAdic.infCpl := AINIRec.ReadString(sSecao, 'infCpl', '');

  Ler_ObsCont(AINIRec, infAdic.obsCont);
  Ler_ObsFisco(AINIRec, infAdic.ObsFisco);
end;

procedure TNFeABIIniReader.Ler_ObsCont(AINIRec: TMemIniFile;
  ObsCont: tObsContCollection);
var
  i: Integer;
begin
  I := 1;
  while true do
  begin
    sSecao := 'ObsCont' + IntToStrZero(I, 2);
    sFim   := AINIRec.ReadString(sSecao, 'xCampo', 'FIM');
    if (sFim = 'FIM') or (Length(sFim) <= 0) then
      break;

    with ObsCont.New do
    begin
      xCampo := sFim;
      xTexto := AINIRec.ReadString(sSecao, 'xTexto', '');
    end;

    Inc(I);
  end;
end;

procedure TNFeABIIniReader.Ler_ObsFisco(AINIRec: TMemIniFile;
  ObsFisco: tObsFiscoCollection);
var
  i: Integer;
begin
  I := 1;
  while true do
  begin
    sSecao := 'obsFisco' + IntToStrZero(I, 2);
    sFim   := AINIRec.ReadString(sSecao, 'xCampo', 'FIM');
    if (sFim = 'FIM') or (Length(sFim) <= 0) then
      break;

    with obsFisco.New do
    begin
      xCampo := sFim;
      xTexto := AINIRec.ReadString(sSecao, 'xTexto', '');
    end;

    Inc(I);
  end;
end;

procedure TNFeABIIniReader.Ler_infRespTec(AINIRec: TMemIniFile;
  infRespTec: TinfRespTec);
begin
  sSecao := 'infRespTec';
  infRespTec.CNPJ     := AINIRec.ReadString(sSecao, 'CNPJ', '');
  infRespTec.xContato := AINIRec.ReadString(sSecao, 'xContato', '');
  infRespTec.email    := AINIRec.ReadString(sSecao, 'email', '');
  infRespTec.fone     := AINIRec.ReadString(sSecao, 'fone', '');
end;

procedure TNFeABIIniReader.Ler_ProtNFeABI(AINIRec: TMemIniFile;
  procNFeABI: TProcDFe);
begin
  sSecao := 'procNFeABI';
  procNFeABI.tpAmb := StrToTipoAmbiente(AINIRec.ReadString(sSecao, 'tpAmb', ''));
  procNFeABI.verAplic := AINIRec.ReadString(sSecao, 'verAplic', '');
  procNFeABI.chDFe := AINIRec.ReadString(sSecao, 'chNFe', '');
  procNFeABI.dhRecbto := StringToDateTime(AINIRec.ReadString(sSecao, 'dhRecbto', '0'));
  procNFeABI.nProt := AINIRec.ReadString(sSecao, 'nProt', '');
  procNFeABI.digVal := AINIRec.ReadString(sSecao, 'digVal', '');
  procNFeABI.cStat := AINIRec.ReadInteger(sSecao, 'cStat', 0);
  procNFeABI.xMotivo := AINIRec.ReadString(sSecao, 'xMotivo', '');
end;

end.
