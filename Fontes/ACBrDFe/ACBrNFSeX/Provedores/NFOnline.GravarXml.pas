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

unit NFOnline.GravarXml;

interface

uses
  SysUtils, Classes, StrUtils,
  ACBrNFSeXGravarXml_ABRASFv2,
  ACBrXmlDocument;

type
  { TNFSeW_NFOnline203 }

  TNFSeW_NFOnline203 = class(TNFSeW_ABRASFv2)
  protected
    procedure Configuracao; override;

    function GerarInfDeclaracaoPrestacaoServico: TACBrXmlNode; override;
    function GerarServico: TACBrXmlNode; override;
    function GerarValores: TACBrXmlNode; override;
  end;

implementation

uses
  ACBrDFe.Conversao,
  ACBrNFSeXConversao,
  ACBrNFSeXConsts,
  ACBrUtil.Strings;

//==============================================================================
// Essa unit tem por finalidade exclusiva gerar o XML do RPS do provedor:
//     NFOnline
//==============================================================================

{ TNFSeW_NFOnline203 }

procedure TNFSeW_NFOnline203.Configuracao;
begin
  inherited Configuracao;

  {
     Todos os parâmetros de configuração estão com os seus valores padrões.

     Se a configuração padrão atende o provedor ela pode ser excluida dessa
     procedure.

     Portanto deixe somente os parâmetros de configuração que foram alterados
     para atender o provedor.
  }

  // Propriedades de Formatação de informações
  // elas requerem que seja declarado em uses a unit: ACBrXmlBase
  {
  FormatoEmissao     := tcDat;
  FormatoCompetencia := tcDat;

  FormatoAliq := tcDe4;
  }

  // elas requerem que seja declarado em uses a unit: ACBrNFSeXConversao
  {
  // filsComFormatacao, filsSemFormatacao, filsComFormatacaoSemZeroEsquerda
  FormatoItemListaServico := filsComFormatacao;
  }

  DivAliq100  := False;

  NrMinExigISS := 1;
  NrMaxExigISS := 1;

  GerarTagServicos := True;

  // Gera ou não o atributo ID no grupo <Rps> da versão 2 do layout da ABRASF.
  GerarIDRps := False;
  // Gera ou não o NameSpace no grupo <Rps> da versão 2 do layout da ABRASF.
  GerarNSRps := True;

  GerarIDDeclaracao := True;
  GerarEnderecoExterior := True;

  TagTomador := 'Tomador';
  TagIntermediario := 'Intermediario';

  // Numero de Ocorrencias Minimas de uma tag
  // se for  0 só gera a tag se o conteudo for diferente de vazio ou zero
  // se for  1 sempre vai gerar a tag
  // se for -1 nunca gera a tag

  // Por padrão as tags abaixo são opcionais
  NrOcorrRazaoSocialInterm := 0;
  NrOcorrValorDeducoes := 0;
  NrOcorrRegimeEspecialTributacao := 0;
  NrOcorrValorISS := 0;
  NrOcorrAliquota := 0;
  NrOcorrDescIncond := 0;
  NrOcorrDescCond := 0;
  NrOcorrMunIncid := 0;
  NrOcorrInscEstInter := 0;
  NrOcorrOutrasRet := 0;
  NrOcorrCodigoCNAE := 0;
  NrOcorrEndereco := 0;
  NrOcorrCodigoPaisTomador := 0;
  NrOcorrUFTomador := 0;
  NrOcorrCepTomador := 0;
  NrOcorrCodTribMun_1 := 0;
  NrOcorrNumProcesso := 0;
  NrOcorrInscMunTomador := 0;
  NrOcorrCodigoPaisServico := 0;
  NrOcorrRespRetencao := 0;

  // Por padrão as tags abaixo são obrigatórias
  NrOcorrIssRetido := 1;
  NrOcorrOptanteSimplesNacional := 1;
  NrOcorrIncentCultural := 1;
  NrOcorrItemListaServico := 1;
  NrOcorrCompetencia := 1;
  NrOcorrSerieRPS := 1;
  NrOcorrTipoRPS := 1;
  NrOcorrDiscriminacao_1 := 1;
  NrOcorrExigibilidadeISS := 1;
  NrOcorrCodigoMunic_1 := 1;

  // Por padrão as tags abaixo não devem ser geradas
  NrOcorrCodTribMun_2 := -1;
  NrOcorrDiscriminacao_2 := -1;
  NrOcorrNaturezaOperacao := -1;
  NrOcorrIdCidade := -1;
  NrOcorrValorTotalRecebido := -1;
  NrOcorrInscEstTomador_1 := -1;
  NrOcorrInscEstTomador_2 := -1;
  NrOcorrOutrasInformacoes := -1;
  NrOcorrTipoNota := -1;
  NrOcorrSiglaUF := -1;
  NrOcorrEspDoc := -1;
  NrOcorrSerieTal := -1;
  NrOcorrFormaPag := -1;
  NrOcorrNumParcelas := -1;
  NrOcorrBaseCalcCRS := -1;
  NrOcorrIrrfInd := -1;
  NrOcorrRazaoSocialPrest := -1;
  NrOcorrPercCargaTrib := -1;
  NrOcorrValorCargaTrib := -1;
  NrOcorrPercCargaTribMun := -1;
  NrOcorrValorCargaTribMun := -1;
  NrOcorrPercCargaTribEst := -1;
  NrOcorrValorCargaTribEst := -1;
  NrOcorrInformacoesComplemetares := -1;
  NrOcorrValTotTrib := -1;
  NrOcorrTipoLogradouro := -1;
  NrOcorrLogradouro := -1;
  NrOcorrDDD := -1;
  NrOcorrTipoTelefone := -1;
  NrOcorrProducao := -1;
  NrOcorrAtualizaTomador := -1;
  NrOcorrTomadorExterior := -1;
  NrOcorrCodigoMunic_2 := -1;
  NrOcorrID := -1;
  NrOcorrToken := -1;
  NrOcorrSenha := -1;
  NrOcorrFraseSecreta := -1;
  NrOcorrAliquotaPis := -1;
  NrOcorrRetidoPis := -1;
  NrOcorrAliquotaCofins := -1;
  NrOcorrRetidoCofins := -1;
  NrOcorrAliquotaInss := -1;
  NrOcorrRetidoInss := -1;
  NrOcorrAliquotaIr := -1;
  NrOcorrRetidoIr := -1;
  NrOcorrAliquotaCsll := -1;
  NrOcorrRetidoCsll := -1;
end;

function TNFSeW_NFOnline203.GerarInfDeclaracaoPrestacaoServico: TACBrXmlNode;
var
  aNameSpace: string;
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
  Result.AppendChild(GerarXMLDestinatario(NFSe.IBSCBS.dest));

  Result.AppendChild(AddNode(tcStr, '#6', 'RegimeEspecialTributacao', 1, 2, 1,
   FpAOwner.RegimeEspecialTributacaoToStr(NFSe.RegimeEspecialTributacao), DSC_REGISSQN));

  Result.AppendChild(AddNode(tcStr, '#7', 'OptanteSimplesNacional', 1, 1, 1,
               FpAOwner.SimNaoToStr(NFSe.OptanteSimplesNacional), DSC_INDOPSN));

  Result.AppendChild(AddNode(tcStr, '#8', 'IncentivoFiscal', 1, 1, 1,
              FpAOwner.SimNaoToStr(NFSe.IncentivadorCultural), DSC_INDINCCULT));

  Result.AppendChild(AddNode(tcStr, '#1', 'UsoConsumoPessoal', 1, 1, 1,
                                      indFinalToStr(NFSe.IBSCBS.indFinal), ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'TipoEnteGovernamental', 1, 1, 0,
                                    tpEnteGovToStr(NFSe.IBSCBS.tpEnteGov), ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'ServicoResultadoOutroPais', 2, 2, 0,
         CodIBGEPaisToSiglaISO2(NFSe.Servico.Valores.tribMun.cPaisResult), ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'PaisPrestacao', 2, 2, 0,
                          CodIBGEPaisToSiglaISO2(NFSe.Servico.CodigoPais), ''));
{
  Result.AppendChild(GerarConstrucaoCivil);

  if GerarAtividadeEventoAposConstrucaoCivil then
    Result.AppendChild(GeraAtividadeEvento);

  if GerarAtividadeEventoAposIncentivoFiscal then
    Result.AppendChild(GeraAtividadeEvento);
}
end;

function TNFSeW_NFOnline203.GerarServico: TACBrXmlNode;
var
  item: string;
begin
  Result := CreateElement('Servico');

  Result.AppendChild(GerarValores);

  Result.AppendChild(AddNode(tcStr, '#20', 'IssRetido', 1, 1, 1,
    FpAOwner.SituacaoTributariaToStr(NFSe.Servico.Valores.IssRetido), DSC_INDISSRET));

  item := FormatarItemServico(NFSe.Servico.ItemListaServico, FormatoItemListaServico);

  Result.AppendChild(AddNode(tcStr, '#29', 'ItemListaServico', 1, 8, 1,
                                                          item, DSC_CLISTSERV));

  Result.AppendChild(AddNode(tcStr, '#30', 'CodigoCnae', 1, 9, 0,
                                OnlyNumber(NFSe.Servico.CodigoCnae), DSC_CNAE));

  Result.AppendChild(AddNode(tcStr, '#32', 'Discriminacao', 1, 2000, 1,
      StringReplace(NFSe.Servico.Discriminacao, Opcoes.QuebraLinha,
               FpAOwner.ConfigGeral.QuebradeLinha, [rfReplaceAll]), DSC_DISCR));

  Result.AppendChild(AddNode(tcStr, '#33', 'CodigoMunicipio', 1, 7, 1,
                           OnlyNumber(NFSe.Servico.CodigoMunicipio), DSC_CMUN));

  Result.AppendChild(AddNode(tcInt, '#36', 'ExigibilidadeISS',
                               NrMinExigISS, NrMaxExigISS, 0,
    StrToInt(FpAOwner.ExigibilidadeISSToStr(NFSe.Servico.ExigibilidadeISS)), DSC_INDISS));

  Result.AppendChild(AddNode(tcInt, '#37', 'MunicipioIncidencia', 7, 7, 1,
                                NFSe.Servico.MunicipioIncidencia, DSC_MUNINCI));

  Result.AppendChild(AddNode(tcStr, '#31', 'CodigoTributacaoNacional', 1, 6, 1,
                                       NFSe.Servico.CodigoServicoNacional, ''));

  Result.AppendChild(AddNode(tcStr, '#32', 'CodigoNBS', 1, 9, 1,
                                             NFSe.Servico.CodigoNBS, DSC_CMUN));

  Result.AppendChild(AddNode(tcStr, '#1', 'CodigoClassificacaoTributaria', 6, 6, 1,
                              NFSe.IBSCBS.valores.trib.gIBSCBS.cClassTrib, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'CodigoIndicadorOperacaoFornecimento', 6, 6, 1,
                                                       NFSe.IBSCBS.cIndOp, ''));
end;

function TNFSeW_NFOnline203.GerarValores: TACBrXmlNode;
var
  Aliquota: Double;
begin
  Result := CreateElement('Valores');

  Result.AppendChild(AddNode(tcDe2, '#13', 'ValorServicos', 1, 15, 1,
                             NFSe.Servico.Valores.ValorServicos, DSC_VSERVICO));

  Result.AppendChild(AddNode(tcDe2, '#14', 'ValorDeducoes', 1, 15, 0,
                            NFSe.Servico.Valores.ValorDeducoes, DSC_VDEDUCISS));

  Result.AppendChild(AddNode(tcDe2, '#15', 'ValorPis', 1, 15, 0,
                                      NFSe.Servico.Valores.ValorPis, DSC_VPIS));

  Result.AppendChild(AddNode(tcDe2, '#16', 'ValorCofins', 1, 15, 0,
                                NFSe.Servico.Valores.ValorCofins, DSC_VCOFINS));

  Result.AppendChild(AddNode(tcDe2, '#17', 'ValorInss', 1, 15, 0,
                                    NFSe.Servico.Valores.ValorInss, DSC_VINSS));

  Result.AppendChild(AddNode(tcDe2, '#18', 'ValorIr', 1, 15, 0,
                                        NFSe.Servico.Valores.ValorIr, DSC_VIR));

  Result.AppendChild(AddNode(tcDe2, '#19', 'ValorCsll', 1, 15, 0,
                                    NFSe.Servico.Valores.ValorCsll, DSC_VCSLL));

  Result.AppendChild(AddNode(tcDe2, '#23', 'OutrasRetencoes', 1, 15, 0,
                    NFSe.Servico.Valores.OutrasRetencoes, DSC_OUTRASRETENCOES));

  Result.AppendChild(AddNode(tcDe2, '#23', 'ValTotTributos', 1, 15, 0,
                                  NFSe.Servico.Valores.ValorTotalTributos, ''));

  Result.AppendChild(AddNode(tcDe2, '#21', 'ValorIss', 1, 15, 0,
                                      NFSe.Servico.Valores.ValorIss, DSC_VISS));

  Aliquota := NormatizarAliquota(NFSe.Servico.Valores.Aliquota, DivAliq100);

  Result.AppendChild(AddNode(FormatoAliq, '#25', 'Aliquota', 1, 5, NrOcorrAliquota,
                                                          Aliquota, DSC_VALIQ));

  Result.AppendChild(AddNode(tcDe2, '#1', 'PercentualReducaoIBS', 1, 7, 0,
                              NFSe.infNFSe.IBSCBS.Valores.mun.pRedAliqMun, ''));

  Result.AppendChild(AddNode(tcDe2, '#1', 'PercentualReducaoCBS', 1, 7, 0,
                              NFSe.infNFSe.IBSCBS.Valores.fed.pRedAliqCBS, ''));

  Result.AppendChild(AddNode(tcDe2, '#1', 'AliquotaIBS', 1, 7, 0,
                                  NFSe.infNFSe.IBSCBS.Valores.mun.pIBSMun, ''));

  Result.AppendChild(AddNode(tcDe2, '#1', 'AliquotaCBS', 1, 7, 0,
                                     NFSe.infNFSe.IBSCBS.Valores.fed.pCBS, ''));

  Result.AppendChild(AddNode(tcDe2, '#1', 'ValorIBS', 1, 7, 0,
                                 NFSe.infNFSe.IBSCBS.totCIBS.gIBS.vIBSTot, ''));

  Result.AppendChild(AddNode(tcDe2, '#1', 'ValorCBS', 1, 7, 0,
                                    NFSe.infNFSe.IBSCBS.totCIBS.gCBS.vCBS, ''));

  Result.AppendChild(AddNode(tcStr, '#34', 'CodigoMunicipio', 1, 7, 1,
                                       NFSe.Servico.CodigoMunicipio, DSC_CMUN));
end;

end.
