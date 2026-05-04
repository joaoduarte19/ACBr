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

unit ISSIntel.GravarXml;

interface

uses
  SysUtils, Classes, StrUtils, ACBrXmlDocument, ACBrXmlBase, ACBrDFe.Conversao, ACBrNFSeXConsts, ACBrUtil.Strings,
  ACBrNFSeXGravarXml_ABRASFv1;

type
  { TNFSeW_ISSIntel }

  TNFSeW_ISSIntel = class(TNFSeW_ABRASFv1)
  protected
    procedure Configuracao; override;

    function GerarServico: TACBrXmlNode; override;
    function GerarValores: TACBrXmlNode; override;
  public
    function GerarXml: Boolean; Override;
  end;

implementation

uses
  ACBrNFSeXConversao;

//==============================================================================
// Essa unit tem por finalidade exclusiva gerar o XML do RPS do provedor:
//     ISSIntel
//==============================================================================

{ TNFSeW_ISSIntel }

procedure TNFSeW_ISSIntel.Configuracao;
begin
  inherited Configuracao;

  DivAliq100 := True;

  if FpAOwner.ConfigGeral.Params.TemParametro('NaoDividir100') then
    DivAliq100 := False;

  FormatoItemListaServico := filsComFormatacaoSemZeroEsquerda;

  if FpAOwner.ConfigGeral.Params.TemParametro('NaoFormatarItemServico') then
    FormatoItemListaServico := filsSemFormatacao;
end;

function TNFSeW_ISSIntel.GerarXml: Boolean;
begin
  // no4 = Imune
  if (NFSe.OptanteSimplesNacional = snSim) or (NFSe.NaturezaOperacao = no4) then
    NrOcorrAliquota := 1;

  Result := inherited GerarXml;
end;

function TNFSeW_ISSIntel.GerarServico: TACBrXmlNode;
var
  nodeArray: TACBrXmlNodeArray;
  i: Integer;
  item: string;
begin
  // Em conformidade com a versão 1 do layout da ABRASF não deve ser alterado
  Result := CreateElement('Servico');

  Result.AppendChild(GerarValores);

  item := FormatarItemServico(NFSe.Servico.ItemListaServico, FormatoItemListaServico);

  Result.AppendChild(AddNode(tcStr, '#29', 'ItemListaServico', 1, 5, NrOcorrItemListaServico,
                                                          item, DSC_CLISTSERV));

  Result.AppendChild(AddNode(tcStr, '#29', 'CodigoServicoNacional', 1, 12, 0,
                                       NFSe.Servico.CodigoServicoNacional, ''));

  Result.AppendChild(AddNode(tcStr, '#29', 'CodigoNbs', 1, 12, 0,
                                                   NFSe.Servico.CodigoNBS, ''));

  Result.AppendChild(AddNode(tcStr, '#30', 'CodigoCnae', 1, 7, NrOcorrCodigoCnae,
                                OnlyNumber(NFSe.Servico.CodigoCnae), DSC_CNAE));

  Result.AppendChild(AddNode(tcStr, '#31', 'CodigoTributacaoMunicipio', 1, 20, NrOcorrCodTribMun,
                     NFSe.Servico.CodigoTributacaoMunicipio, DSC_CSERVTRIBMUN));

  Result.AppendChild(AddNode(tcStr, '#32', 'Discriminacao', 1, 2000, 1,
    StringReplace(NFSe.Servico.Discriminacao, Opcoes.QuebraLinha,
               FpAOwner.ConfigGeral.QuebradeLinha, [rfReplaceAll]), DSC_DISCR));

  Result.AppendChild(AddNode(tcStr, '#', 'InformacoesComplementares', 1, 255, NrOcorrInformacoesComplemetares,
    StringReplace(NFSe.InformacoesComplementares, Opcoes.QuebraLinha,
                      FpAOwner.ConfigGeral.QuebradeLinha, [rfReplaceAll]), ''));

  Result.AppendChild(GerarServicoCodigoMunicipio);

  nodeArray := GerarItensServico;
  if nodeArray <> nil then
  begin
    for i := 0 to Length(nodeArray) - 1 do
    begin
      Result.AppendChild(nodeArray[i]);
    end;
  end;
end;

function TNFSeW_ISSIntel.GerarValores: TACBrXmlNode;
var
  Aliquota: Double;
begin
  // Em conformidade com a versão 1 do layout da ABRASF não deve ser alterado
  Result := CreateElement('Valores');

  Result.AppendChild(AddNode(tcDe2, '#13', 'ValorServicos', 1, 15, 1,
                             NFSe.Servico.Valores.ValorServicos, DSC_VSERVICO));

  Result.AppendChild(AddNode(tcDe2, '#14', 'ValorDeducoes', 1, 15, NrOcorrValorDeducoes,
                            NFSe.Servico.Valores.ValorDeducoes, DSC_VDEDUCISS));

  Result.AppendChild(AddNode(tcDe2, '#14', 'ValorTotalRecebido', 1, 15, NrOcorrValorTotalRecebido,
                         NFSe.Servico.Valores.ValorTotalRecebido, DSC_VTOTREC));

  Result.AppendChild(AddNode(tcDe2, '#15', 'ValorPis', 1, 15, NrOcorrValorPis,
                                      NFSe.Servico.Valores.ValorPis, DSC_VPIS));

  Result.AppendChild(AddNode(tcDe2, '#16', 'ValorCofins', 1, 15, NrOcorrValorCofins,
                                NFSe.Servico.Valores.ValorCofins, DSC_VCOFINS));

  Result.AppendChild(AddNode(tcDe2, '#17', 'ValorInss', 1, 15, NrOcorrValorInss,
                                    NFSe.Servico.Valores.ValorInss, DSC_VINSS));

  Result.AppendChild(AddNode(tcDe2, '#18', 'ValorIr', 1, 15, NrOcorrValorIr,
                                        NFSe.Servico.Valores.ValorIr, DSC_VIR));

  Result.AppendChild(AddNode(tcDe2, '#19', 'ValorCsll', 1, 15, NrOcorrValorCsll,
                                    NFSe.Servico.Valores.ValorCsll, DSC_VCSLL));

  Result.AppendChild(AddNode(tcStr, '#20', 'IssRetido', 1, 1, 1,
    FpAOwner.SituacaoTributariaToStr(NFSe.Servico.Valores.IssRetido), DSC_INDISSRET));

  Result.AppendChild(AddNode(tcDe2, '#21', 'ValorIss', 1, 15, NrOcorrValorIss,
                                      NFSe.Servico.Valores.ValorIss, DSC_VISS));

  Result.AppendChild(AddNode(tcDe2, '#22', 'ValorIssRetido', 1, 15, NrOcorrValorISSRetido_1,
                               NFSe.Servico.Valores.ValorIssRetido, DSC_VNFSE));

  Result.AppendChild(AddNode(tcDe2, '#23', 'OutrasRetencoes', 1, 15, NrOcorrOutrasRet,
                    NFSe.Servico.Valores.OutrasRetencoes, DSC_OUTRASRETENCOES));

  Result.AppendChild(AddNode(tcDe2, '#24', 'BaseCalculo', 1, 15, NrOcorrBaseCalc,
                                 NFSe.Servico.Valores.BaseCalculo, DSC_VBCISS));

  Aliquota := NormatizarAliquota(NFSe.Servico.Valores.Aliquota, DivAliq100);

  Result.AppendChild(AddNode(FormatoAliq, '#25', 'Aliquota', 1, 5, NrOcorrAliquota,
                                                          Aliquota, DSC_VALIQ));

  Result.AppendChild(AddNode(tcDe2, '#26', 'ValorLiquidoNfse', 1, 15, NrOcorrValLiq,
                             NFSe.Servico.Valores.ValorLiquidoNfse, DSC_VNFSE));

  Result.AppendChild(AddNode(tcDe2, '#22', 'ValorIssRetido', 1, 15, NrOcorrValorISSRetido_2,
                               NFSe.Servico.Valores.ValorIssRetido, DSC_VNFSE));

  Result.AppendChild(AddNode(tcDe2, '#27', 'DescontoIncondicionado', 1, 15, NrOcorrDescIncond,
                 NFSe.Servico.Valores.DescontoIncondicionado, DSC_VDESCINCOND));

  Result.AppendChild(AddNode(tcDe2, '#28', 'DescontoCondicionado', 1, 15, NrOcorrDescCond,
                     NFSe.Servico.Valores.DescontoCondicionado, DSC_VDESCCOND));

  Result.AppendChild(AddNode(tcStr, '#', 'TpRetPisCofins', 1, 1, 1,
         tpRetPisCofinsToStr(NFSe.Servico.Valores.tribFed.TpRetPisCofins), ''));

  Result.AppendChild(AddNode(tcStr, '#', 'PisCofinsCst', 2, 2, 1,
                               CSTToStr(NFSe.Servico.Valores.tribFed.CST), ''));

  Result.AppendChild(AddNode(tcDe2, '#', 'BcPisCofins', 1, 15, 0,
                                NFSe.Servico.Valores.tribFed.vBCPisCofins, ''));

  Result.AppendChild(AddNode(FormatoAliq, '#', 'AliquotaPis', 1, 5, 0,
                                    NFSe.Servico.Valores.tribFed.pAliqPis, ''));

  Result.AppendChild(AddNode(FormatoAliq, '#', 'AliquotaCofins', 1, 5, 0,
                                 NFSe.Servico.Valores.tribFed.pAliqCofins, ''));
end;

end.
