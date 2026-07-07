{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
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

unit TaxTecnologia.GravarXml;

interface

uses
  SysUtils, Classes, StrUtils,
  ACBrXmlDocument,
  ACBrDFe.Conversao,
  ACBrNFSeXConsts,
  ACBrUtil.Strings,
  ACBrNFSeXConversao,
  ACBrNFSeXGravarXml_ABRASFv2;

type
  { TNFSeW_TaxTecnologia204 }

  TNFSeW_TaxTecnologia204 = class(TNFSeW_ABRASFv2)
  private

  protected
    procedure Configuracao; override;

    function GerarServico: TACBrXmlNode; override;
    function GerarValores: TACBrXmlNode; override;
    function GerarInfDeclaracaoPrestacaoServico: TACBrXmlNode; override;
  end;

implementation

//==============================================================================
// Essa unit tem por finalidade exclusiva gerar o XML do RPS do provedor:
//     TaxTecologia
//==============================================================================

{ TNFSeW_TaxTecnologia204 }

procedure TNFSeW_TaxTecnologia204.Configuracao;
begin
  inherited Configuracao;

  TagTomador := 'TomadorServico';
  GerarTagNifTomador := True;
  GerarEnderecoExterior := True;
  NrOcorrNumProcesso := 0;
  NrOcorrValTotTrib := 1;
  NrOcorrCodigoPaisServico := -1;
  DivAliq100 := False;
  FormatoAliq := tcDe4;
end;

function TNFSeW_TaxTecnologia204.GerarValores: TACBrXmlNode;
var
  Aliquota: Double;
begin
  Result := CreateElement('Valores');

  Result.AppendChild(AddNode(tcDe2, '#13', 'BaseCalculoCRS', 1, 15, NrOcorrBaseCalcCRS,
      NFSe.Servico.Valores.BaseCalculo, ''));

  Result.AppendChild(AddNode(tcDe2, '#13', 'IrrfIndenizacao', 1, 15, NrOcorrIrrfInd,
      NFSe.Servico.Valores.IrrfIndenizacao, ''));

  Result.AppendChild(AddNode(tcDe2, '#13', 'ValorServicos', 1, 15, 1,
      NFSe.Servico.Valores.ValorServicos, DSC_VSERVICO));

  Result.AppendChild(AddNode(tcDe2, '#14', 'ValorDeducoes', 1, 15, NrOcorrValorDeducoes,
      NFSe.Servico.Valores.ValorDeducoes, DSC_VDEDUCISS));

  Result.AppendChild(AddNode(FormatoAliq, '#15', 'AliquotaPis', 1, 15, NrOcorrAliquotaPis,
      NFSe.Servico.Valores.AliquotaPis, DSC_VALIQ));

  Result.AppendChild(AddNode(tcStr, '#15', 'RetidoPis', 1, 1, NrOcorrRetidoPis,
      FpAOwner.SimNaoToStr(NFSe.Servico.Valores.RetidoPis), DSC_VPIS));

  Result.AppendChild(AddNode(tcDe2, '#15', 'ValorPis', 1, 15, NrOcorrValorPis,
      NFSe.Servico.Valores.ValorPis, DSC_VPIS));

  Result.AppendChild(AddNode(FormatoAliq, '#15', 'AliquotaCofins', 1, 15, NrOcorrAliquotaCofins,
      NFSe.Servico.Valores.AliquotaCofins, DSC_VALIQ));

  Result.AppendChild(AddNode(tcStr, '#15', 'RetidoCofins', 1, 1, NrOcorrRetidoCofins,
      FpAOwner.SimNaoToStr(NFSe.Servico.Valores.RetidoCofins), DSC_VPIS));

  Result.AppendChild(AddNode(tcDe2, '#16', 'ValorCofins', 1, 15, NrOcorrValorCofins,
      NFSe.Servico.Valores.ValorCofins, DSC_VCOFINS));

  Result.AppendChild(AddNode(FormatoAliq, '#15', 'AliquotaInss', 1, 15, NrOcorrAliquotaInss,
      NFSe.Servico.Valores.AliquotaInss, DSC_VALIQ));

  Result.AppendChild(AddNode(tcStr, '#15', 'RetidoInss', 1, 1, NrOcorrRetidoInss,
      FpAOwner.SimNaoToStr(NFSe.Servico.Valores.RetidoInss), DSC_VPIS));

  Result.AppendChild(AddNode(tcDe2, '#17', 'ValorInss', 1, 15, NrOcorrValorInss,
      NFSe.Servico.Valores.ValorInss, DSC_VINSS));

  Result.AppendChild(AddNode(FormatoAliq, '#15', 'AliquotaIr', 1, 15, NrOcorrAliquotaIr,
      NFSe.Servico.Valores.AliquotaIr, DSC_VALIQ));

  Result.AppendChild(AddNode(tcStr, '#15', 'RetidoIr', 1, 1, NrOcorrRetidoIr,
      FpAOwner.SimNaoToStr(NFSe.Servico.Valores.RetidoIr), DSC_VPIS));

  Result.AppendChild(AddNode(tcDe2, '#18', 'ValorIr', 1, 15, NrOcorrValorIr,
      NFSe.Servico.Valores.ValorIr, DSC_VIR));

  Result.AppendChild(AddNode(FormatoAliq, '#15', 'AliquotaCsll', 1, 15, NrOcorrAliquotaCsll,
      NFSe.Servico.Valores.AliquotaCsll, DSC_VALIQ));

  Result.AppendChild(AddNode(tcStr, '#15', 'RetidoCsll', 1, 1, NrOcorrRetidoCsll,
      FpAOwner.SimNaoToStr(NFSe.Servico.Valores.RetidoCsll), DSC_VPIS));

  Result.AppendChild(AddNode(tcDe2, '#19', 'ValorCsll', 1, 15, NrOcorrValorCsll,
      NFSe.Servico.Valores.ValorCsll, DSC_VCSLL));

  Result.AppendChild(AddNode(FormatoAliq, '#15', 'AliquotaCpp', 1, 15, NrOcorrAliquotaCpp,
      NFSe.Servico.Valores.AliquotaCpp, DSC_VALIQ));

  Result.AppendChild(AddNode(tcStr, '#15', 'RetidoCpp', 1, 1, NrOcorrRetidoCpp,
      FpAOwner.SimNaoToStr(NFSe.Servico.Valores.RetidoCpp), DSC_VPIS));

  Result.AppendChild(AddNode(tcDe2, '#19', 'ValorCpp', 1, 15, NrOcorrValorCpp,
      NFSe.Servico.Valores.ValorCpp, DSC_VCSLL));

  Result.AppendChild(AddNode(tcDe2, '#23', 'OutrasRetencoes', 1, 15, NrOcorrOutrasRet,
      NFSe.Servico.Valores.OutrasRetencoes, DSC_OUTRASRETENCOES));

  Result.AppendChild(AddNode(tcDe2, '#23', 'ValTotTributos', 1, 15, NrOcorrValTotTrib,
      NFSe.Servico.Valores.ValorTotalTributos, ''));

  Result.AppendChild(AddNode(tcDe2, '#21', 'ValorIss', 1, 15, NrOcorrValorIss,
      NFSe.Servico.Valores.ValorIss, DSC_VISS));

  Result.AppendChild(AddNode(tcDe2, '#21', 'ValorTTS', 1, 15, NrOcorrValorTTS,
      NFSe.Servico.Valores.ValorTaxaTurismo, DSC_VTTS));

  Result.AppendChild(AddNode(tcDe2, '#21', 'QuantDiarias', 1, 15, NrOcorrQuantDiarias,
      NFSe.Servico.Valores.QtdeDiaria, DSC_QDiaria));

  Aliquota := NormatizarAliquota(NFSe.Servico.Valores.Aliquota, DivAliq100);

  Result.AppendChild(AddNode(FormatoAliq, '#25', 'Aliquota', 1, 5, NrOcorrAliquota,
      Aliquota, DSC_VALIQ));

  Result.AppendChild(AddNode(tcDe2, '#27', 'DescontoIncondicionado', 1, 15, NrOcorrDescIncond,
      NFSe.Servico.Valores.DescontoIncondicionado, DSC_VDESCINCOND));

  Result.AppendChild(AddNode(tcDe2, '#28', 'DescontoCondicionado', 1, 15, NrOcorrDescCond,
      NFSe.Servico.Valores.DescontoCondicionado, DSC_VDESCCOND));
end;

function TNFSeW_TaxTecnologia204.GerarServico: TACBrXmlNode;
var
  Item: string;
  LNaoExigencia: string;
begin
  Result := CreateElement('Servico');

  Result.AppendChild(GerarValores);

  if GerarTagServicos then
  begin
    Result.AppendChild(AddNode(tcStr, '#20', 'IssRetido', 1, 1, NrOcorrIssRetido,
        FpAOwner.SituacaoTributariaToStr(NFSe.Servico.Valores.IssRetido), DSC_INDISSRET));

    Result.AppendChild(AddNode(tcStr, '#21', 'ResponsavelRetencao', 1, 1, NrOcorrRespRetencao,
        FpAOwner.ResponsavelRetencaoToStr(NFSe.Servico.ResponsavelRetencao), DSC_INDRESPRET));

    Item := FormatarItemServico(NFSe.Servico.ItemListaServico, FormatoItemListaServico);

    Result.AppendChild(AddNode(tcStr, '#29', 'ItemListaServico', 1, 8, NrOcorrItemListaServico,
        Item, DSC_CLISTSERV));

    Result.AppendChild(AddNode(tcStr, '#30', 'CodigoCnae', 1, 9, NrOcorrCodigoCNAE,
        OnlyNumber(NFSe.Servico.CodigoCnae), DSC_CNAE));

    Result.AppendChild(AddNode(tcStr, '#31', 'CodigoTributacaoMunicipio', 1, 20, NrOcorrCodTribMun_1,
        NFSe.Servico.CodigoTributacaoMunicipio, DSC_CSERVTRIBMUN));

    Result.AppendChild(AddNode(tcStr, '#32', 'CodigoNbs', 1, 9, NrOcorrCodigoNBS,
        NFSe.Servico.CodigoNBS, DSC_CMUN));

   Result.AppendChild(AddNode(tcStr, '#33', 'Discriminacao', 1, 2000, NrOcorrDiscriminacao_1,
        StringReplace(NFSe.Servico.Discriminacao, Opcoes.QuebraLinha,
          FpAOwner.ConfigGeral.QuebradeLinha, [rfReplaceAll]), DSC_DISCR));

    Result.AppendChild(AddNode(tcStr, '#34', 'CodigoMunicipio', 1, 7, NrOcorrCodigoMunic_1,
        OnlyNumber(NFSe.Servico.CodigoMunicipio), DSC_CMUN));

    Result.AppendChild(GerarCodigoPaisServico);

    Result.AppendChild(AddNode(tcInt, '#36', 'ExigibilidadeISS',
        NrMinExigISS, NrMaxExigISS, NrOcorrExigibilidadeISS,
        StrToInt(FpAOwner.ExigibilidadeISSToStr(NFSe.Servico.ExigibilidadeISS)), DSC_INDISS));

    LNaoExigencia:= DSC_INDISS;
    LNaoExigencia:= StringReplace(LNaoExigencia,  ' da ', ' da não ', [rfReplaceAll]);

    Result.AppendChild(AddNode(tcInt, '#37', 'IdentifNaoExigibilidade', 1, 4, 1,
        StrToIntDef(NFSe.Servico.IdentifNaoExigibilidade, 0), LNaoExigencia));

    Result.AppendChild(AddNode(tcStr, '#9', 'OutrasInformacoes', 0, 255, NrOcorrOutrasInformacoes_2,
        StringReplace(NFSe.OutrasInformacoes, Opcoes.QuebraLinha,
          FpAOwner.ConfigGeral.QuebradeLinha, [rfReplaceAll]), DSC_OUTRASINF));

    Result.AppendChild(AddNode(tcInt, '#38', 'MunicipioIncidencia', 7, 7, NrOcorrMunIncid,
        NFSe.Servico.MunicipioIncidencia, DSC_MUNINCI));

    Result.AppendChild(AddNode(tcStr, '#39', 'NumeroProcesso', 1, 30, NrOcorrNumProcesso,
        NFSe.Servico.NumeroProcesso, DSC_NPROCESSO));

    Result.AppendChild(AddNode(tcStr, '#40', 'InfAdicional', 1, 255, NrOcorrInfAdicional,
        NFSe.Servico.InfAdicional, DSC_INFADICIONAL));

    Result.AppendChild(GerarListaItensServico);
  end;
end;

function TNFSeW_TaxTecnologia204.GerarInfDeclaracaoPrestacaoServico: TACBrXmlNode;
var
  TemGrupoIBSCBS: Boolean;
begin
  Result := inherited GerarInfDeclaracaoPrestacaoServico;

  TemGrupoIBSCBS := FpAOwner.ConfigGeral.Params.TemParametro('GerarGrupoIBSCBS');

  if TemGrupoIBSCBS and ((NFSe.IBSCBS.dest.xNome <> '') or
     (NFSe.IBSCBS.imovel.cCIB <> '') or (NFSe.IBSCBS.imovel.ender.CEP <> '') or
     (NFSe.IBSCBS.imovel.ender.endExt.cEndPost <> '') or
     (NFSe.IBSCBS.valores.trib.gIBSCBS.CST <> cstNenhum)) then
    Result.AppendChild(GerarXMLIBSCBS(NFSe.IBSCBS));
end;

end.
