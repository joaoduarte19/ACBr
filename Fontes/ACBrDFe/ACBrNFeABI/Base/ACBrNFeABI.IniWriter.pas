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

unit ACBrNFeABI.IniWriter;

interface

uses
  Classes, SysUtils,
  IniFiles,
  ACBrNFeABI.Classes,
  ACBrDFe.Conversao,
  ACBrNFeABI.Conversao,
  ACBrDFe.RTC.IniWriter,
  ACBrDFeComum.Proc;

type
  { TNFeABIIniWriter }

  TNFeABIIniWriter = class(TDFeRTCIniWriter)
  private
    FNFeABI: TNFeABI;
    sSecao: string;

    procedure Gerar_Identificacao(AINIRec: TMemIniFile; Ide: TIde);
    procedure Gerar_gModNat(AINIRec: TMemIniFile; gModNat: TgModNat);
    procedure Gerar_gCont(AINIRec: TMemIniFile; gCont: TgCont);

    procedure Gerar_NFref(AINIRec: TMemIniFile; NFref: TNFrefCollection);

    procedure Gerar_Emitente(AINIRec: TMemIniFile; Emit: TEmit);
    procedure Gerar_transmit(AINIRec: TMemIniFile; transmit: tTransmitCollection);
    procedure Gerar_adquirente(AINIRec: TMemIniFile; adquirente: tadquirenteCollection);
    procedure Gerar_Imovel(AINIRec: TMemIniFile; Imovel: Timovel);
    procedure Gerar_autXML(AINIRec: TMemIniFile; autXML: TautXMLCollection);
    procedure Gerar_infOper(AINIRec: TMemIniFile; infOper: TinfOper);
    procedure Gerar_imovelTorna(AINIRec: TMemIniFile; imovelTorna: timovelTornaCollection);
    procedure Gerar_gIntermedCorret(AINIRec: TMemIniFile; gIntermedCorret: tgIntermedCorretCollection);
    procedure Gerar_ginfTrib(AINIRec: TMemIniFile; ginfTrib: TginfTrib);
    procedure Gerar_pag(AINIRec: TMemIniFile; pag: Tpag);
    procedure Gerar_detPagImovel(AINIRec: TMemIniFile; detPagImovel: tdetPagImovelCollection);
    procedure Gerar_detPagIncorpLote(AINIRec: TMemIniFile; detPagIncorpLote: tdetPagIncorpLoteCollection);

    procedure Gerar_Total(AINIRec: TMemIniFile; total: Ttotal);

    procedure Gerar_InfAdic(AINIRec: TMemIniFile; infAdic: TinfAdic);
    procedure Gerar_ObsCont(AINIRec: TMemIniFile; ObsCont: tObsContCollection);
    procedure Gerar_ObsFisco(AINIRec: TMemIniFile; ObsFisco: tObsFiscoCollection);

    procedure Gerar_infRespTec(AINIRec: TMemIniFile; infRespTec: TinfRespTec);

    procedure Gerar_ProtNFeABI(AINIRec: TMemIniFile; procNFeABI: TProcDFe);
  public
    constructor Create(AOwner: TNFeABI); reintroduce;

    function GravarIni: string;

    property NFeABI: TNFeABI read FNFeABI write FNFeABI;
  end;


implementation

uses
  ACBrXmlBase,
  ACBrDFeUtil,
  ACBrNFeABI,
  ACBrUtil.Base;

{ TNFeABIIniWriter }

constructor TNFeABIIniWriter.Create(AOwner: TNFeABI);
begin
  inherited Create;

  FNFeABI := AOwner;
end;

function TNFeABIIniWriter.GravarIni: string;
var
  INIRec: TMemIniFile;
  IniNFeABI: TStringList;
begin
  Result := '';
  ModelosDFe := mdfNFeABI;
  tpNFDebito := tdNenhum;

  if not ValidarChave(FNFeABI.infNFeABI.ID) then
    raise EACBrNFeABIException.Create('NFeABI Inconsistente para gerar INI. Chave Inválida.');

  INIRec := TMemIniFile.Create('');
  try
    INIRec.WriteString('infNFeABI', 'ID', FNFeABI.infNFeABI.ID);
    INIRec.WriteString('infNFeABI', 'Versao', FloatToStr(FNFeABI.infNFeABI.Versao));

    Gerar_Identificacao(INIRec, FNFeABI.Ide);
    Gerar_NFref(INIRec,FNFeABI.NFref);
    Gerar_Emitente(INIRec, FNFeABI.Emit);
    Gerar_transmit(INIRec, NFeABI.transmit);
    Gerar_adquirente(INIRec, NFeABI.adquirente);
    Gerar_Imovel(INIRec, NFeABI.imovel);
    Gerar_autXML(INIRec, FNFeABI.autXML);
    Gerar_infOper(INIRec, FNFeABI.infOper);
    Gerar_ginfTrib(INIRec, FNFeABI.gInfTrib);

    if (NFeABI.pag.detPagImovel.Count > 0) or
       (NFeABI.pag.detPagIncorpLote.Count > 0) then
      Gerar_pag(INIRec, FNFeABI.pag);

    Gerar_Total(INIRec, FNFeABI.total);
    Gerar_InfAdic(INIRec, FNFeABI.infAdic);
    Gerar_infRespTec(INIRec, FNFeABI.infRespTec);
    Gerar_ProtNFeABI(INIRec, FNFeABI.procNFeABI);

    IniNFeABI := TStringList.Create;
    try
      INIRec.GetStrings(IniNFeABI);
      Result := StringReplace(IniNFeABI.Text, sLineBreak + sLineBreak, sLineBreak, [rfReplaceAll]);
    finally
      IniNFeABI.Free;
    end;
  finally
    INIRec.Free;
  end;
end;

procedure TNFeABIIniWriter.Gerar_Identificacao(AINIRec: TMemIniFile; Ide: TIde);
begin
  sSecao := 'ide';
  AINIRec.WriteInteger(sSecao, 'cUF', Ide.cUF);
  AINIRec.WriteInteger(sSecao, 'cNF', Ide.cNF);
  AINIRec.WriteInteger(sSecao, 'Modelo', Ide.modelo);
  AINIRec.WriteInteger(sSecao, 'Serie', Ide.serie);
  AINIRec.WriteInteger(sSecao, 'nNF', Ide.nNF);
  AINIRec.WriteString(sSecao, 'dhEmi', DateTimeToStr(Ide.dhEmi));
  AINIRec.WriteString(sSecao, 'tpNF', tpNFToStr(Ide.tpNF));
  AINIRec.WriteString(sSecao, 'tpImp', tpImpToStr(Ide.tpImp));
  AINIRec.WriteString(sSecao, 'tpEmis', TipoEmissaoToStr(Ide.tpEmis));
  AINIRec.WriteString(sSecao, 'nSiteAutoriz', SiteAutorizadorToStr(Ide.nSiteAutoriz));
  AINIRec.WriteString(sSecao, 'tpAmb', TipoAmbienteToStr(Ide.tpAmb));
  AINIRec.WriteString(sSecao, 'finNFe', finNFeToStr(Ide.finNFe));
  AINIRec.WriteString(sSecao, 'procEmi', procEmiToStr(Ide.procEmi));
  AINIRec.WriteString(sSecao, 'verProc', Ide.verProc);

  Gerar_gModNat(AINIRec, Ide.gModNat);

  if Ide.gCont.dhCont > 0 then
    Gerar_gCont(AINIRec, Ide.gCont);
end;

procedure TNFeABIIniWriter.Gerar_gModNat(AINIRec: TMemIniFile;
  gModNat: TgModNat);
begin
  sSecao := 'gModNat';
  AINIRec.WriteInteger(sSecao, 'modOper', gModNat.modOper);
  AINIRec.WriteInteger(sSecao, 'natOper', gModNat.natOper);
  AINIRec.WriteInteger(sSecao, 'detOper', gModNat.detOper);
end;

procedure TNFeABIIniWriter.Gerar_gCont(AINIRec: TMemIniFile; gCont: TgCont);
begin
  sSecao := 'gCont';
  AINIRec.WriteString(sSecao, 'dhCont', DateTimeToStr(gCont.dhCont));
  AINIRec.WriteString(sSecao, 'xJust', gCont.xJust);
end;

procedure TNFeABIIniWriter.Gerar_NFref(AINIRec: TMemIniFile;
  NFref: TNFrefCollection);
var
  i: Integer;
begin
  for i := 0 to NFref.Count - 1 do
  begin
    sSecao := 'NFref' + IntToStrZero(I + 1, 3);
    with NFref[i] do
    begin
      AINIRec.WriteString(sSecao, 'refNFeABI', refNFeABI);
    end;
  end;
end;

procedure TNFeABIIniWriter.Gerar_Emitente(AINIRec: TMemIniFile; Emit: TEmit);
begin
  sSecao := 'emit';
  AINIRec.WriteString(sSecao, 'CNPJCPF', Emit.CNPJCPF);
  AINIRec.WriteString(sSecao, 'xNome', Emit.xNome);
  AINIRec.WriteString(sSecao, 'xFant', Emit.xFant);
  AINIRec.WriteString(sSecao, 'tpEmit', tpEmitToStr(Emit.tpEmit));
  // Endereço do Emitente
  AINIRec.WriteString(sSecao, 'xLgr', Emit.EnderEmit.xLgr);
  AINIRec.WriteString(sSecao, 'nro', Emit.EnderEmit.nro);
  AINIRec.WriteString(sSecao, 'xCpl', Emit.EnderEmit.xCpl);
  AINIRec.WriteString(sSecao, 'xBairro', Emit.EnderEmit.xBairro);
  AINIRec.WriteInteger(sSecao, 'cMun', Emit.EnderEmit.cMun);
  AINIRec.WriteString(sSecao, 'xMun', Emit.EnderEmit.xMun);
  AINIRec.WriteString(sSecao, 'CEP', Emit.EnderEmit.CEP);
  AINIRec.WriteString(sSecao, 'UF', Emit.EnderEmit.UF);
  AINIRec.WriteInteger(sSecao, 'cPais', Emit.EnderEmit.cPais);
  AINIRec.WriteString(sSecao, 'xPais', Emit.EnderEmit.xPais);
  AINIRec.WriteString(sSecao, 'fone', Emit.EnderEmit.fone);
end;

procedure TNFeABIIniWriter.Gerar_transmit(AINIRec: TMemIniFile;
  transmit: tTransmitCollection);
var
  i: Integer;
begin
  for i := 0 to transmit.Count - 1 do
  begin
    sSecao := 'transmit' + IntToStrZero(i + 1, 2);

    AINIRec.WriteString(sSecao, 'indDeclarante', TIndicadorExToStr(transmit[i].indDeclarante));
    AINIRec.WriteString(sSecao, 'CNPJCPF', transmit[i].CNPJCPF);
    AINIRec.WriteString(sSecao, 'xNome', transmit[i].xNome);
    AINIRec.WriteFloat(sSecao, 'pTransIndiv', transmit[i].pTransIndiv);
    AINIRec.WriteString(sSecao, 'indContrib', indContribToStr(transmit[i].indContrib));
    // Endereço do transmit
    AINIRec.WriteString(sSecao, 'xLgr', transmit[i].enderTransmit.xLgr);
    AINIRec.WriteString(sSecao, 'nro', transmit[i].enderTransmit.nro);
    AINIRec.WriteString(sSecao, 'xCpl', transmit[i].enderTransmit.xCpl);
    AINIRec.WriteString(sSecao, 'xBairro', transmit[i].enderTransmit.xBairro);
    AINIRec.WriteInteger(sSecao, 'cMun', transmit[i].enderTransmit.cMun);
    AINIRec.WriteString(sSecao, 'xMun', transmit[i].enderTransmit.xMun);
    AINIRec.WriteString(sSecao, 'CEP', transmit[i].enderTransmit.CEP);
    AINIRec.WriteString(sSecao, 'UF', transmit[i].enderTransmit.UF);
    AINIRec.WriteInteger(sSecao, 'cPais', transmit[i].enderTransmit.cPais);
    AINIRec.WriteString(sSecao, 'xPais', transmit[i].enderTransmit.xPais);
    AINIRec.WriteString(sSecao, 'fone', transmit[i].enderTransmit.fone);
  end;
end;

procedure TNFeABIIniWriter.Gerar_adquirente(AINIRec: TMemIniFile;
  adquirente: tadquirenteCollection);
var
  i: Integer;
begin
  for i := 0 to adquirente.Count - 1 do
  begin
    sSecao := 'adquirente' + IntToStrZero(i + 1, 2);

    AINIRec.WriteString(sSecao, 'indDeclarante', TIndicadorExToStr(adquirente[i].indDeclarante));
    AINIRec.WriteString(sSecao, 'CNPJCPF', adquirente[i].CNPJCPF);
    AINIRec.WriteString(sSecao, 'xNome', adquirente[i].xNome);
    AINIRec.WriteFloat(sSecao, 'pAquisicao', adquirente[i].pAquisicao);
    AINIRec.WriteString(sSecao, 'indContrib', indContribToStr(adquirente[i].indContrib));
    // Endereço do adquirente
    AINIRec.WriteString(sSecao, 'xLgr', adquirente[i].enderAdquirente.xLgr);
    AINIRec.WriteString(sSecao, 'nro', adquirente[i].enderAdquirente.nro);
    AINIRec.WriteString(sSecao, 'xCpl', adquirente[i].enderAdquirente.xCpl);
    AINIRec.WriteString(sSecao, 'xBairro', adquirente[i].enderAdquirente.xBairro);
    AINIRec.WriteInteger(sSecao, 'cMun', adquirente[i].enderAdquirente.cMun);
    AINIRec.WriteString(sSecao, 'xMun', adquirente[i].enderAdquirente.xMun);
    AINIRec.WriteString(sSecao, 'CEP', adquirente[i].enderAdquirente.CEP);
    AINIRec.WriteString(sSecao, 'UF', adquirente[i].enderAdquirente.UF);
    AINIRec.WriteInteger(sSecao, 'cPais', adquirente[i].enderAdquirente.cPais);
    AINIRec.WriteString(sSecao, 'xPais', adquirente[i].enderAdquirente.xPais);
    AINIRec.WriteString(sSecao, 'fone', adquirente[i].enderAdquirente.fone);
  end;
end;

procedure TNFeABIIniWriter.Gerar_Imovel(AINIRec: TMemIniFile; Imovel: Timovel);
begin
  sSecao := 'imovel';
  AINIRec.WriteString(sSecao, 'tipo', TipoToStr(Imovel.tipo));
  AINIRec.WriteString(sSecao, 'espImovel', Imovel.espImovel);
  AINIRec.WriteString(sSecao, 'xOutrosEspecies', Imovel.xOutrosEspecies);
  AINIRec.WriteString(sSecao, 'enquadramento', Imovel.enquadramento);
  AINIRec.WriteString(sSecao, 'obsLocalImovel', Imovel.obsLocalImovel);
  AINIRec.WriteFloat(sSecao, 'areaTotal', Imovel.areaTotal);
  AINIRec.WriteString(sSecao, 'uAreaTotal', uareaTotalToStr(Imovel.uAreaTotal));
  AINIRec.WriteString(sSecao, 'cartorioRegistro', Imovel.cartorioRegistro);
  AINIRec.WriteString(sSecao, 'matricTransc', Imovel.matricTransc);
  // Cadastro do Imovel
  AINIRec.WriteString(sSecao, 'cCIB', Imovel.cadastro.cCIB);
  AINIRec.WriteString(sSecao, 'indIPTU', TIndicadorToStr(Imovel.cadastro.indIPTU));
  AINIRec.WriteString(sSecao, 'nIptu', Imovel.cadastro.nIptu);
  AINIRec.WriteString(sSecao, 'indIncra', TIndicadorToStr(Imovel.cadastro.indIncra));
  AINIRec.WriteString(sSecao, 'nIncra', Imovel.cadastro.nIncra);
  // Endereço do Imovel
  AINIRec.WriteString(sSecao, 'xLgr', Imovel.enderImovel.xLgr);
  AINIRec.WriteString(sSecao, 'nro', Imovel.enderImovel.nro);
  AINIRec.WriteString(sSecao, 'xCpl', Imovel.enderImovel.xCpl);
  AINIRec.WriteString(sSecao, 'xBairro', Imovel.enderImovel.xBairro);
  AINIRec.WriteInteger(sSecao, 'cMun', Imovel.enderImovel.cMun);
  AINIRec.WriteString(sSecao, 'xMun', Imovel.enderImovel.xMun);
  AINIRec.WriteString(sSecao, 'CEP', Imovel.enderImovel.CEP);
  AINIRec.WriteString(sSecao, 'UF', Imovel.enderImovel.UF);
  AINIRec.WriteInteger(sSecao, 'cPais', Imovel.enderImovel.cPais);
  AINIRec.WriteString(sSecao, 'xPais', Imovel.enderImovel.xPais);
  AINIRec.WriteString(sSecao, 'fone', Imovel.enderImovel.fone);
end;

procedure TNFeABIIniWriter.Gerar_autXML(AINIRec: TMemIniFile;
  autXML: TautXMLCollection);
var
  i: Integer;
begin
  for i := 0 to autXML.Count - 1 do
  begin
    sSecao := 'autXML' + IntToStrZero(I + 1, 2);
    with autXML[i] do
    begin
      AINIRec.WriteString(sSecao, 'CNPJCPF', CNPJCPF);
    end;
  end;
end;

procedure TNFeABIIniWriter.Gerar_infOper(AINIRec: TMemIniFile;
  infOper: TinfOper);
begin
  sSecao := 'infOper';
  AINIRec.WriteFloat(sSecao, 'pTransImovel', infOper.pTransImovel);
  AINIRec.WriteFloat(sSecao, 'vTotalOperacao', infOper.vTotalOperacao);
  AINIRec.WriteString(sSecao, 'indTorna', TIndicadorToStr(infOper.indTorna));
  AINIRec.WriteString(sSecao, 'indRedSocial', TIndicadorToStr(infOper.indRedSocial));
  AINIRec.WriteFloat(sSecao, 'vRedSocial', infOper.vRedSocial);
  AINIRec.WriteString(sSecao, 'indIntermedCorret', TIndicadorToStr(infOper.indIntermedCorret));

  AINIRec.WriteFloat(sSecao, 'vTorna', infOper.gTorna.vTorna);

  AINIRec.WriteString(sSecao, 'indIncorpLote', TIndicadorToStr(infOper.gIncorpLote.indIncorpLote));
  AINIRec.WriteString(sSecao, 'CNPJempImob', infOper.gIncorpLote.CNPJempImob);
  AINIRec.WriteString(sSecao, 'cCIBObra', infOper.gIncorpLote.cCIBObra);

  if infOper.gRedAjusteImovel.vRedAjusteImovel > 0 then
  begin
    AINIRec.WriteFloat(sSecao, 'vInicial', infOper.gRedAjusteImovel.vInicial);
    AINIRec.WriteFloat(sSecao, 'vITBI', infOper.gRedAjusteImovel.vITBI);
    AINIRec.WriteFloat(sSecao, 'vLaudemio', infOper.gRedAjusteImovel.vLaudemio);
    AINIRec.WriteFloat(sSecao, 'vContrap', infOper.gRedAjusteImovel.vContrap);
    AINIRec.WriteFloat(sSecao, 'vRedAjusteImovel', infOper.gRedAjusteImovel.vRedAjusteImovel);
  end;

  AINIRec.WriteInteger(sSecao, 'tpInstrumento', infOper.instrumento.tpInstrumento);
  AINIRec.WriteString(sSecao, 'xOutrosInst', infOper.instrumento.xOutrosInst);
  AINIRec.WriteString(sSecao, 'dtInstrumento', DateTimeToStr(infOper.instrumento.dtInstrumento));

  if infOper.gTorna.vTorna > 0 then
    Gerar_imovelTorna(AINIRec, infOper.gTorna.imovelTorna);

  Gerar_gIntermedCorret(AINIRec, infOper.gIntermedCorret);
end;

procedure TNFeABIIniWriter.Gerar_imovelTorna(AINIRec: TMemIniFile;
  imovelTorna: timovelTornaCollection);
var
  i: Integer;
begin
  for i := 0 to imovelTorna.Count - 1 do
  begin
    sSecao := 'imovelTorna' + IntToStrZero(I + 1, 2);
    with imovelTorna[i] do
    begin
      AINIRec.WriteString(sSecao, 'tipo', TipoToStr(Imovel.tipo));
      AINIRec.WriteString(sSecao, 'espImovel', Imovel.espImovel);
      AINIRec.WriteString(sSecao, 'xOutrosEspecies', Imovel.xOutrosEspecies);
      AINIRec.WriteString(sSecao, 'enquadramento', Imovel.enquadramento);
      AINIRec.WriteString(sSecao, 'obsLocalImovel', Imovel.obsLocalImovel);
      AINIRec.WriteFloat(sSecao, 'areaTotal', Imovel.areaTotal);
      AINIRec.WriteString(sSecao, 'uAreaTotal', uareaTotalToStr(Imovel.uAreaTotal));
      AINIRec.WriteString(sSecao, 'cartorioRegistro', Imovel.cartorioRegistro);
      AINIRec.WriteString(sSecao, 'matricTransc', Imovel.matricTransc);
      // Cadastro do Imovel
      AINIRec.WriteString(sSecao, 'cCIB', Imovel.cadastro.cCIB);
      AINIRec.WriteString(sSecao, 'indIPTU', TIndicadorToStr(Imovel.cadastro.indIPTU));
      AINIRec.WriteString(sSecao, 'nIptu', Imovel.cadastro.nIptu);
      AINIRec.WriteString(sSecao, 'indIncra', TIndicadorToStr(Imovel.cadastro.indIncra));
      AINIRec.WriteString(sSecao, 'nIncra', Imovel.cadastro.nIncra);
      // Endereço do Imovel
      AINIRec.WriteString(sSecao, 'xLgr', Imovel.enderImovel.xLgr);
      AINIRec.WriteString(sSecao, 'nro', Imovel.enderImovel.nro);
      AINIRec.WriteString(sSecao, 'xCpl', Imovel.enderImovel.xCpl);
      AINIRec.WriteString(sSecao, 'xBairro', Imovel.enderImovel.xBairro);
      AINIRec.WriteInteger(sSecao, 'cMun', Imovel.enderImovel.cMun);
      AINIRec.WriteString(sSecao, 'xMun', Imovel.enderImovel.xMun);
      AINIRec.WriteString(sSecao, 'CEP', Imovel.enderImovel.CEP);
      AINIRec.WriteString(sSecao, 'UF', Imovel.enderImovel.UF);
      AINIRec.WriteInteger(sSecao, 'cPais', Imovel.enderImovel.cPais);
      AINIRec.WriteString(sSecao, 'xPais', Imovel.enderImovel.xPais);
      AINIRec.WriteString(sSecao, 'fone', Imovel.enderImovel.fone);
    end;
  end;
end;

procedure TNFeABIIniWriter.Gerar_gIntermedCorret(AINIRec: TMemIniFile;
  gIntermedCorret: tgIntermedCorretCollection);
var
  i: Integer;
begin
  for i := 0 to gIntermedCorret.Count - 1 do
  begin
    sSecao := 'gIntermedCorret' + IntToStrZero(I + 1, 2);
    AINIRec.WriteString(sSecao, 'CNPJCPF', gIntermedCorret[i].CNPJCPF);
    AINIRec.WriteString(sSecao, 'xNome', gIntermedCorret[i].xNome);
    AINIRec.WriteFloat(sSecao, 'vCorretagem', gIntermedCorret[i].vCorretagem);
  end;
end;

procedure TNFeABIIniWriter.Gerar_ginfTrib(AINIRec: TMemIniFile;
  ginfTrib: TginfTrib);
begin
  Gerar_gCompraGovReduzido(AINIRec, ginfTrib.gCompraGov);
  Gerar_IBSCBS(AINIRec, ginfTrib.IBSCBS, -1, -1);
end;

procedure TNFeABIIniWriter.Gerar_pag(AINIRec: TMemIniFile; pag: Tpag);
begin
  Gerar_detPagImovel(AINIRec, pag.detPagImovel);
  Gerar_detPagIncorpLote(AINIRec, pag.detPagIncorpLote);
end;

procedure TNFeABIIniWriter.Gerar_detPagImovel(AINIRec: TMemIniFile;
  detPagImovel: tdetPagImovelCollection);
var
  i: Integer;
begin
  for i := 0 to detPagImovel.Count - 1 do
  begin
    sSecao := 'detPagImovel' + IntToStrZero(I + 1, 2);
    with detPagImovel[i] do
    begin
      AINIRec.WriteInteger(sSecao, 'tPag', tPag);
      AINIRec.WriteString(sSecao, 'xPag', xPag);
      AINIRec.WriteFloat(sSecao, 'vPag', vPag);
    end;
  end;
end;

procedure TNFeABIIniWriter.Gerar_detPagIncorpLote(AINIRec: TMemIniFile;
  detPagIncorpLote: tdetPagIncorpLoteCollection);
var
  i: Integer;
begin
  for i := 0 to detPagIncorpLote.Count - 1 do
  begin
    sSecao := 'detPagIncorpLote' + IntToStrZero(I + 1, 2);
    with detPagIncorpLote[i] do
    begin
      AINIRec.WriteString(sSecao, 'tParcela', tParcela);
      AINIRec.WriteInteger(sSecao, 'nParcela', nParcela);
      AINIRec.WriteString(sSecao, 'xParcela', xParcela);
    end;
  end;
end;

procedure TNFeABIIniWriter.Gerar_Total(AINIRec: TMemIniFile; total: Ttotal);
begin
  sSecao := 'total';
  AINIRec.WriteFloat(sSecao, 'vTotalOperacao', total.vTotalOperacao);
  AINIRec.WriteFloat(sSecao, 'vOperacIndiv', total.vOperacIndiv);
  AINIRec.WriteFloat(sSecao, 'vRedAjusteIndiv', total.vRedAjusteIndiv);
  AINIRec.WriteFloat(sSecao, 'vRedSocialIndiv', total.vRedSocialIndiv);
  AINIRec.WriteFloat(sSecao, 'vBC', total.vBC);
  AINIRec.WriteFloat(sSecao, 'vIBSUF', total.vIBSUF);
  AINIRec.WriteFloat(sSecao, 'vIBSMun', total.vIBSMun);
  AINIRec.WriteFloat(sSecao, 'vCBS', total.vCBS);
  AINIRec.WriteFloat(sSecao, 'vNF', total.vNF);
end;

procedure TNFeABIIniWriter.Gerar_InfAdic(AINIRec: TMemIniFile;
  infAdic: TinfAdic);
begin
  sSecao := 'infAdic';
  AINIRec.WriteString(sSecao, 'infAdFisco', infAdic.infAdFisco);
  AINIRec.WriteString(sSecao, 'infCpl', infAdic.infCpl);

  Gerar_ObsCont(AINIRec, infAdic.obsCont);
  Gerar_ObsFisco(AINIRec, infAdic.ObsFisco);
end;

procedure TNFeABIIniWriter.Gerar_ObsCont(AINIRec: TMemIniFile;
  ObsCont: tObsContCollection);
var
  i: Integer;
begin
  for i := 0 to ObsCont.Count - 1 do
  begin
    sSecao := 'ObsCont' + IntToStrZero(I + 1, 2);
    with ObsCont[i] do
    begin
      AINIRec.WriteString(sSecao, 'xCampo', xCampo);
      AINIRec.WriteString(sSecao, 'xTexto', xTexto);
    end;
  end;
end;

procedure TNFeABIIniWriter.Gerar_ObsFisco(AINIRec: TMemIniFile;
  ObsFisco: tObsFiscoCollection);
var
  i: Integer;
begin
  for i := 0 to obsFisco.Count - 1 do
  begin
    sSecao := 'obsFisco' + IntToStrZero(I + 1, 2);
    with obsFisco[i] do
    begin
      AINIRec.WriteString(sSecao, 'xCampo', xCampo);
      AINIRec.WriteString(sSecao, 'xTexto', xTexto);
    end;
  end;
end;

procedure TNFeABIIniWriter.Gerar_infRespTec(AINIRec: TMemIniFile;
  infRespTec: TinfRespTec);
begin
  sSecao := 'infRespTec';
  AINIRec.WriteString(sSecao, 'CNPJ', infRespTec.CNPJ);
  AINIRec.WriteString(sSecao, 'xContato', infRespTec.xContato);
  AINIRec.WriteString(sSecao, 'email', infRespTec.email);
  AINIRec.WriteString(sSecao, 'fone', infRespTec.fone);
end;

procedure TNFeABIIniWriter.Gerar_ProtNFeABI(AINIRec: TMemIniFile;
  procNFeABI: TProcDFe);
begin
  sSecao := 'procNFeABI';

  if procNFeABI.nProt <> '' then
  begin
    AINIRec.WriteString(sSecao, 'tpAmb', TipoAmbienteToStr(procNFeABI.tpAmb));
    AINIRec.WriteString(sSecao, 'verAplic', procNFeABI.verAplic);
    AINIRec.WriteString(sSecao, 'chNFe', procNFeABI.chDFe);
    AINIRec.WriteString(sSecao, 'dhRecbto', DateTimeToStr(procNFeABI.dhRecbto));
    AINIRec.WriteString(sSecao, 'nProt', procNFeABI.nProt);
    AINIRec.WriteString(sSecao, 'digVal', procNFeABI.digVal);
    AINIRec.WriteString(sSecao, 'cStat', IntToStr(procNFeABI.cStat));
    AINIRec.WriteString(sSecao, 'xMotivo', procNFeABI.xMotivo);
  end;
end;

end.
