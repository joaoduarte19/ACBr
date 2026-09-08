{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2020 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Italo Giurizzato Junior                         }
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

unit GovDigital.GravarXml;

interface

uses
  SysUtils, Classes, StrUtils,
  ACBrXmlDocument,
  ACBrUtil.Strings,
  ACBrDFe.Conversao,
  ACBrNFSeXConversao,
  ACBrNFSeXClass,
  ACBrNFSeXGravarXml_ABRASFv2;

type
  { TNFSeW_GovDigital200 }

  TNFSeW_GovDigital200 = class(TNFSeW_ABRASFv2)
  protected
    procedure Configuracao; override;

    function GerarServico: TACBrXmlNode; override;
    function GerarValores: TACBrXmlNode; override;

  end;

  { TNFSeW_GovDigital201 }

  TNFSeW_GovDigital201 = class(TNFSeW_GovDigital200)
  protected
    function GeraAtividadeEvento: TACBrXmlNode; override;
    function GerarEnderecoEvento: TACBrXmlNode; override;
    function GerarEnderecoExteriorEvento: TACBrXmlNode; override;
    function GerarValores: TACBrXmlNode; override;
    function GerarServico: TACBrXmlNode; override;
    function GerarXMLImovel(Imovel: TDadosimovel): TACBrXmlNode; override;
    function GerarXMLEnderecoNacionalImovel(ender: TenderImovel): TACBrXmlNode; override;
    function GerarXMLEnderecoExteriorImovel(endExt: TendExt): TACBrXmlNode; override;
    function GerarConstrucaoCivil: TACBrXmlNode; override;
    function GerarEnderecoObra: TACBrXmlNode;
    function GerarXMLComercioExterior: TACBrXMLNode;
    function GerarInfDeclaracaoPrestacaoServico: TACBrXmlNode; override;
  end;

implementation

uses
  ACBrNFSeXConsts;

//==============================================================================
// Essa unit tem por finalidade exclusiva gerar o XML do RPS do provedor:
//     GovDigital
//==============================================================================

{ TNFSeW_GovDigital200 }

procedure TNFSeW_GovDigital200.Configuracao;
begin
  inherited Configuracao;

  GerarAtividadeEventoAposConstrucaoCivil := False;
  GerarAtividadeEventoAposIncentivoFiscal := True;

  DivAliq100 := True;

  NrOcorrCodigoNBS := -1;

  if FpAOwner.ConfigGeral.Params.TemParametro('NaoDividir100') then
    DivAliq100 := False;
end;

function TNFSeW_GovDigital200.GerarServico: TACBrXmlNode;
var
  NrOcorrMunPrest: Integer;
begin
  Result := inherited GerarServico;

  NrOcorrMunPrest := 0;
  if NFSe.Servico.CodigoPais = 1058 then
    NrOcorrMunPrest := 1;

  Result.AppendChild(AddNode(tcInt, '#32', 'MunicipioPrestacao', 7, 7, NrOcorrMunPrest,
                               NFSe.Servico.CodigoMunicipioLocalPrestacao, ''));

  Result.AppendChild(AddNode(tcInt, '#41', 'PaisPrestacao', 4, 4, 0,
                                                  NFSe.Servico.CodigoPais, ''));

  Result.AppendChild(AddNode(tcStr, '#32', 'CodigoNBS', 1, 9, 0,
                                                   NFSe.Servico.CodigoNBS, ''));

  Result.AppendChild(AddNode(tcStr, '#32', 'CIndOp', 6, 6, 0,
                                                       NFSe.Servico.INDOP, ''));

  if NFSe.Servico.CodigoPais = 1058 then
  begin
    if NFSe.IBSCBS.valores.trib.gIBSCBS.gTribRegular.cClassTribReg <> '' then
    begin
      Result.AppendChild(AddNode(tcStr, '#32', 'CClassTribReg', 6, 6, 0,
                                                    NFSe.IBSCBS.valores.trib.gIBSCBS.gTribRegular.cClassTribReg, ''));

      Result.AppendChild(AddNode(tcStr, '#32', 'CClassTrib', 6, 6, 0,
                                                    NFSe.Servico.CClassTrib, ''));
    end else
    begin
      Result.AppendChild(AddNode(tcStr, '#32', 'CClassTribReg', 6, 6, 0,
                                                    NFSe.Servico.CClassTrib, ''));
    end;
  end;
end;

function TNFSeW_GovDigital200.GerarValores: TACBrXmlNode;
var
  sCST, sRet: string;
begin
  Result := inherited GerarValores;

  if (NFSe.Servico.Valores.ValorPis > 0) or (NFSe.Servico.Valores.ValorCofins > 0) then
  begin
    // Tenta CSTPis primeiro, usa tribFed.CST como fallback
    sCST := CSTPisToStr(NFSe.Servico.Valores.CSTPis);
    if sCST = '' then
      sCST := CSTToStr(NFSe.Servico.Valores.tribFed.CST);
    if sCST = '' then
      sCST := '01'; // fallback final: operação tributável alíquota normal

    Result.AppendChild(AddNode(tcStr, '#1', 'CST', 2, 2, 1, sCST, ''));

    if not (StrToIntDef(sCST, 0) in [0, 8, 9]) then
    begin
      // Tenta tpRetPisCofins, usa tribFed como fallback
      sRet := tpRetPisCofinsToStr(NFSe.Servico.Valores.tpRetPisCofins);
      if sRet = '' then
        sRet := tpRetPisCofinsToStr(NFSe.Servico.Valores.tribFed.tpRetPisCofins);
      if sRet = '' then
        sRet := '1'; // fallback final: retido

      Result.AppendChild(AddNode(tcStr, '#1', 'TpRetPisCofins', 1, 1, 1, sRet, ''));
    end;
  end;
end;

{ TNFSeW_GovDigital201 }

function TNFSeW_GovDigital201.GeraAtividadeEvento: TACBrXmlNode;
begin
  Result := nil;

  if NFSe.Servico.Evento.xNome <> '' then
  begin
    Result := CreateElement('AtvEvento');

    Result.AppendChild(AddNode(tcStr, '#1', 'Nome', 1, 255, 1,
                                                NFSe.Servico.Evento.xNome, ''));

    Result.AppendChild(AddNode(tcDat, '#1', 'DataInicio', 10, 10, 1,
                                                NFSe.Servico.Evento.dtIni, ''));

    Result.AppendChild(AddNode(tcDat, '#1', 'DataFim', 10, 10, 1,
                                                NFSe.Servico.Evento.dtFim, ''));

    if NFSe.Servico.Evento.idAtvEvt <> '' then
      Result.AppendChild(AddNode(tcStr, '#1', 'IdAtvEv', 1, 30, 1,
                                              NFSe.Servico.Evento.idAtvEvt, ''))
    else
      Result.AppendChild(GerarEnderecoEvento);
  end;
end;

function TNFSeW_GovDigital201.GerarConstrucaoCivil: TACBrXmlNode;
var
  NrOcorrCodigoObra: integer;
  NrOcorrArt: integer;
begin
  Result := nil;

  if ((NFSe.ConstrucaoCivil.CodigoObra <> '') or (NFSe.ConstrucaoCivil.Art <> '')) then
  begin
    if (NFSe.ConstrucaoCivil.CodigoObra <> '') then
    begin
      NrOcorrCodigoObra := 1;
      NrOcorrArt := 0;
    end
    else
    begin
      NrOcorrCodigoObra := 0;
      NrOcorrArt := 1;
    end;

    Result := CreateElement('ConstrucaoCivil');

    Result.AppendChild(AddNode(tcStr, '#51', 'CodigoObra', 1, 15, NrOcorrCodigoObra,
                                   NFSe.ConstrucaoCivil.CodigoObra, DSC_COBRA));

    Result.AppendChild(AddNode(tcStr, '#52', 'Art', 1, 15, NrOcorrArt,
                                            NFSe.ConstrucaoCivil.Art, DSC_ART));

    Result.AppendChild(AddNode(tcStr, '#53', 'InscImobFisc', 1, 30, 0,
                                              NFSe.ConstrucaoCivil.inscImobFisc, ''));

    Result.AppendChild(AddNode(tcStr, '#54', 'IdObra', 1, 15, NrOcorrCodigoObra,
                                   NFSe.ConstrucaoCivil.CodigoObra, DSC_COBRA));

    Result.AppendChild(AddNode(tcInt, '#54', 'CCIB', 8, 8, 0,
                                   NFSe.ConstrucaoCivil.Cib, ''));

    Result.AppendChild(GerarEnderecoObra);
  end;
end;

function TNFSeW_GovDigital201.GerarEnderecoEvento: TACBrXmlNode;
begin
  Result := CreateElement('Endereco');

  Result.AppendChild(AddNode(tcStr, '#1', 'Endereco', 1, 255, 1,
                                    NFSe.Servico.Evento.Endereco.Endereco, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'Numero', 1, 60, 1,
                                      NFSe.Servico.Evento.Endereco.Numero, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'Complemento', 1, 60, 0,
                                 NFSe.Servico.Evento.Endereco.Complemento, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'Bairro', 1, 60, 1,
                                      NFSe.Servico.Evento.Endereco.Bairro, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'CodigoMunicipio', 1, 7, 1,
                             NFSe.Servico.Evento.Endereco.CodigoMunicipio, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'Uf', 1, 60, 1,
                                          NFSe.Servico.Evento.Endereco.UF, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'CodigoPais', 1, 4, 1,
                                  NFSe.Servico.Evento.Endereco.CodigoPais, ''));

  if (NFSe.Servico.Evento.Endereco.UF = '') then
    Result.AppendChild(AddNode(tcStr, '#1', 'Cep', 8, 8, 1,
                                          NFSe.Servico.Evento.Endereco.CEP, ''))
  else
    Result.AppendChild(GerarEnderecoExteriorEvento);

end;

function TNFSeW_GovDigital201.GerarEnderecoExteriorEvento: TACBrXmlNode;
begin
  Result := CreateElement('EndExt');

  Result.AppendChild(AddNode(tcStr, '#1', 'CodigoEndPost', 1, 11, 1,
                                         NFSe.Servico.Evento.Endereco.CEP, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'CidadeExterior', 1, 60, 1,
                                  NFSe.Servico.Evento.Endereco.xMunicipio, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'EstProvRegExterior', 1, 60, 1,
                                          NFSe.Servico.Evento.Endereco.UF, ''));
end;

function TNFSeW_GovDigital201.GerarEnderecoObra: TACBrXmlNode;
begin
  Result := nil;

  if (NFSe.ConstrucaoCivil.Endereco.Endereco <> '') then
  begin
    Result := CreateElement('Endereco');

    Result.AppendChild(AddNode(tcStr, '#53', 'Endereco', 1, 125, 0,
                             NFSe.ConstrucaoCivil.Endereco.Endereco, DSC_XLGR));

    Result.AppendChild(AddNode(tcStr, '#54', 'Numero', 1, 10, 0,
                                NFSe.ConstrucaoCivil.Endereco.Numero, DSC_NRO));

    Result.AppendChild(AddNode(tcStr, '#55', 'Complemento', 1, 80, 0,
                          NFSe.ConstrucaoCivil.Endereco.Complemento, DSC_XCPL));

    Result.AppendChild(AddNode(tcStr, '#56', 'Bairro', 1, 60, 0,
                            NFSe.ConstrucaoCivil.Endereco.Bairro, DSC_XBAIRRO));

    Result.AppendChild(AddNode(tcStr, '#57', 'CodigoMunicipio', 1, 7, 0,
                      NFSe.ConstrucaoCivil.Endereco.CodigoMunicipio, DSC_CMUN));

    Result.AppendChild(AddNode(tcStr, '#57', 'Uf', 2, 2, 0,
                                     NFSe.ConstrucaoCivil.Endereco.UF, DSC_UF));

    Result.AppendChild(AddNode(tcStr, '#58', 'CodigoPais', 4, 4, 0,
                                     PadLeft(IntToStr(NFSe.ConstrucaoCivil.Endereco.CodigoPais), 4, '0'), ''));

    Result.AppendChild(AddNode(tcStr, '#59', 'Cep', 1, 8, 0,
                                   NFSe.ConstrucaoCivil.Endereco.CEP, DSC_CEP));
  end;
end;

function TNFSeW_GovDigital201.GerarInfDeclaracaoPrestacaoServico: TACBrXmlNode;
var
  aNameSpace: string;
  nodeArray: TACBrXmlNodeArray;
  i: Integer;
begin
  aNameSpace := DefinirNameSpaceDeclaracao;

  Result := CreateElement('InfDeclaracaoPrestacaoServico');

  if aNameSpace <> '' then
    Result.SetNamespace(aNameSpace);

  DefinirIDDeclaracao;

  if (FpAOwner.ConfigGeral.Identificador <> '') and GerarIDDeclaracao then
    Result.SetAttribute(FpAOwner.ConfigGeral.Identificador, NFSe.infID.ID);

  Result.AppendChild(AddNode(tcStr, '#4', 'Id', 1, 15, NrOcorrID,
                                                            NFSe.infID.ID, ''));

  if (NFSe.IdentificacaoRps.Numero <> '') and GerarTagRps then
    Result.AppendChild(GerarRps);

  Result.AppendChild(AddNode(FormatoCompetencia, '#4', 'Competencia', 10, 10, NrOcorrCompetencia,
                                                  NFSe.Competencia, DSC_DHEMI));

  Result.AppendChild(GerarServico);
  Result.AppendChild(GerarPrestador);
  Result.AppendChild(GerarTomador);
  Result.AppendChild(GerarIntermediarioServico);
  Result.AppendChild(GerarConstrucaoCivil);

  Result.AppendChild(AddNode(tcStr, '#6', 'RegimeEspecialTributacao', 1, 2, NrOcorrRegimeEspecialTributacao,
   FpAOwner.RegimeEspecialTributacaoToStr(NFSe.RegimeEspecialTributacao), DSC_REGISSQN));

  Result.AppendChild(AddNode(tcStr, '#7', 'OptanteSimplesNacional', 1, 1, NrOcorrOptanteSimplesNacional,
               FpAOwner.SimNaoToStr(NFSe.OptanteSimplesNacional), DSC_INDOPSN));

  Result.AppendChild(AddNode(tcStr, '#8', 'IncentivoFiscal', 1, 1, NrOcorrIncentCultural,
              FpAOwner.SimNaoToStr(NFSe.IncentivadorCultural), DSC_INDINCCULT));

  Result.AppendChild(GerarXMLComercioExterior);
  Result.AppendChild(GeraAtividadeEvento);
end;

function TNFSeW_GovDigital201.GerarServico: TACBrXmlNode;
begin
  if NFSe.Servico.ExigibilidadeISS = exiImunidade then
    NrOcorrTpImunidade := 0
  else
    NrOcorrTpImunidade := -1;

  Result := inherited GerarServico;

  Result.AppendChild(GerarXMLImovel(NFSe.IBSCBS.imovel));

  if NFSe.IBSCBS.tpOper <> togNenhum then
    Result.AppendChild(AddNode(tcStr, '#1', 'TpOper', 1, 1, 0,
                                             tpOperGovNFSeToStr(NFSe.IBSCBS.tpOper), ''));
end;

function TNFSeW_GovDigital201.GerarValores: TACBrXmlNode;
begin
  Result := inherited GerarValores;

  Result.AppendChild(AddNode(tcDe2, '#1', 'AliquotaPisProprio', 1, 4, 0,
                                           NFSe.Servico.Valores.AliquotaPis, ''));

  Result.AppendChild(AddNode(tcDe2, '#1', 'AliquotaCofinsProprio', 1, 4, 0,
                                           NFSe.Servico.Valores.AliquotaCofins, ''));
end;

function TNFSeW_GovDigital201.GerarXMLComercioExterior: TACBrXMLNode;
begin
  Result := nil;

  if NFSe.Servico.comExt.tpMoeda > 0 then
  begin
    Result := CreateElement('ComExt');

    Result.AppendChild(AddNode(tcStr, '#1', 'MdPrestacao', 1, 1, 1,
                        mdPrestacaoToStr(NFSe.Servico.comExt.mdPrestacao), ''));

    Result.AppendChild(AddNode(tcStr, '#1', 'VincPrest', 1, 1, 1,
                            vincPrestToStr(NFSe.Servico.comExt.vincPrest), ''));

    Result.AppendChild(AddNode(tcInt, '#1', 'TpMoeda', 3, 3, 1,
                                              NFSe.Servico.comExt.tpMoeda, ''));

    Result.AppendChild(AddNode(tcDe2, '#1', 'VServMoeda', 1, 15, 1,
                                           NFSe.Servico.comExt.vServMoeda, ''));

    Result.AppendChild(AddNode(tcStr, '#1', 'MecAFComexP', 2, 2, 1,
                        mecAFComexPToStr(NFSe.Servico.comExt.mecAFComexP), ''));

    Result.AppendChild(AddNode(tcStr, '#1', 'MecAFComexT', 2, 2, 1,
                        mecAFComexTToStr(NFSe.Servico.comExt.mecAFComexT), ''));

    Result.AppendChild(AddNode(tcStr, '#1', 'MovTempBens', 1, 1, 1,
                        movTempBensToStr(NFSe.Servico.comExt.movTempBens), ''));

    Result.AppendChild(AddNode(tcInt, '#1', 'Mdic', 1, 1, 1,
                                                 NFSe.Servico.comExt.mdic, ''));
  end;
end;

function TNFSeW_GovDigital201.GerarXMLEnderecoExteriorImovel(
  endExt: TendExt): TACBrXmlNode;
begin
  Result := CreateElement('EndExt');

  Result.AppendChild(AddNode(tcStr, '#1', 'CodigoEndPost', 1, 11, 1,
                                         NFSe.IBSCBS.imovel.ender.endExt.cEndPost, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'CidadeExterior', 1, 60, 1,
                                  NFSe.IBSCBS.imovel.ender.endExt.xCidade, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'EstProvRegExterior', 1, 60, 1,
                                          NFSe.IBSCBS.imovel.ender.endExt.xEstProvReg, ''));
end;

function TNFSeW_GovDigital201.GerarXMLEnderecoNacionalImovel(
  ender: TenderImovel): TACBrXmlNode;
begin
  Result := nil;

  if (ender.CEP <> '') or (ender.endExt.cEndPost <> '') then
  begin
    Result := CreateElement('Endereco');

    Result.AppendChild(AddNode(tcStr, '#1', 'Endereco', 1, 255, 1, ender.xLgr, ''));

    Result.AppendChild(AddNode(tcStr, '#1', 'Numero', 1, 60, 1, ender.nro, ''));

    Result.AppendChild(AddNode(tcStr, '#1', 'Complemento', 1, 156, 0, ender.xCpl, ''));

    Result.AppendChild(AddNode(tcStr, '#1', 'Bairro', 1, 60, 1,
                                                            ender.xBairro, ''));
    if (ender.endExt.cEndPost <> '') and (ender.endExt.xCidade <> '') and (ender.endExt.xEstProvReg <> '') then
      Result.AppendChild(GerarXMLEnderecoExteriorImovel(ender.endExt))
    else
    begin
      Result.AppendChild(AddNode(tcStr, '#1', 'CodigoMunicipio', 7, 7, 0,
                                                              ender.CodigoMunicipio, ''));

      Result.AppendChild(AddNode(tcStr, '#1', 'Uf', 1, 2, 0, ender.UF, ''));

      Result.AppendChild(AddNode(tcStr, '#1', 'CodigoPais', 4, 4, 0, PadLeft(IntToStr(ender.endExt.cPais), 4, '0'), ''));

      Result.AppendChild(AddNode(tcStr, '#1', 'Cep', 1, 2, 0, ender.CEP, ''));
    end;
  end;
end;

function TNFSeW_GovDigital201.GerarXMLImovel(
  Imovel: TDadosimovel): TACBrXmlNode;
begin
  Result := nil;

  if (Imovel.cCIB <> '') or (Imovel.ender.CEP <> '') or
     (Imovel.ender.endExt.cEndPost <> '') then
  begin
    Result := CreateElement('Imovel');

    if (Imovel.cCIB <> '') then
      Result.AppendChild(AddNode(tcStr, '#1', 'CCIB', 1, 8, 1,
                                                               Imovel.cCIB, ''))
    else
      Result.AppendChild(GerarXMLEnderecoNacionalImovel(Imovel.ender));
  end;
end;

end.
