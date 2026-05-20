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

unit BWSistemas.GravarXml;

interface

uses
  SysUtils,
  Classes,
  StrUtils,
  ACBrXMLDocument,
  ACBrUtil.Strings,
  ACBrDFe.Conversao,
  ACBrNFSeXConsts,
  ACBrNFSeXConversao,
  ACBrNFSeXGravarXml_ABRASFv2;

type
  { TNFSeW_BWSistemas200 }

  TNFSeW_BWSistemas200 = class(TNFSeW_ABRASFv2)
  protected
    procedure Configuracao; override;
    function GerarServico: TACBrXmlNode; override;
  end;

implementation

//==============================================================================
// Essa unit tem por finalidade exclusiva gerar o XML do RPS do provedor:
//     BWSistemas
//==============================================================================

{ TNFSeW_BWSistemas200 }

procedure TNFSeW_BWSistemas200.Configuracao;
begin
  // Executa a Configuração Padrão
  inherited Configuracao;
  NrOcorrValorDeducoes := 1;
  NrOcorrValorPis := 1;
  NrOcorrValorCofins := 1;
  NrOcorrValorInss := 1;
  NrOcorrValorCsll := 1;
  NrOcorrOutrasRet := 1;
  NrOcorrValorIss := 1;
  NrOcorrAliquota := 1;
  NrOcorrDescIncond := 1;
  NrOcorrDescCond := 1;
  NrOcorrValorIr := 1;
  NrOcorrRegimeEspecialTributacao := 1;
end;

function TNFSeW_BWSistemas200.GerarServico: TACBrXmlNode;
var
  item: string;
begin
  Result := CreateElement('Servico');

  Result.AppendChild(GerarValores);

  if GerarTagServicos then
  begin
    Result.AppendChild(AddNode(tcStr, '#39', 'CodSitTribPisCofins', 1, 2, 1,
                                              CSTPisToStr(NFSe.Servico.Valores.CSTPis), ''));
    Result.AppendChild(AddNode(tcStr, '#40', 'TipoRetPisCofins', 1, 1, 1,
                                              tpRetPisCofinsToStr(NFSe.Servico.Valores.tpRetPisCofins), ''));

    Result.AppendChild(AddNode(tcStr, '#20', 'IssRetido', 1, 1, NrOcorrIssRetido,
      FpAOwner.SituacaoTributariaToStr(NFSe.Servico.Valores.IssRetido), DSC_INDISSRET));

    Result.AppendChild(AddNode(tcStr, '#21', 'ResponsavelRetencao', 1, 1, NrOcorrRespRetencao,
     FpAOwner.ResponsavelRetencaoToStr(NFSe.Servico.ResponsavelRetencao), DSC_INDRESPRET));

    item := FormatarItemServico(NFSe.Servico.ItemListaServico, FormatoItemListaServico);

    Result.AppendChild(AddNode(tcStr, '#29', 'ItemListaServico', 1, 8, NrOcorrItemListaServico,
                                                          item, DSC_CLISTSERV));

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

    Result.AppendChild(AddNode(tcInt, '#37', 'MunicipioIncidencia', 7, 7, NrOcorrMunIncid,
                                NFSe.Servico.MunicipioIncidencia, DSC_MUNINCI));

    Result.AppendChild(AddNode(tcStr, '#38', 'NumeroProcesso', 1, 30, NrOcorrNumProcesso,
                                   NFSe.Servico.NumeroProcesso, DSC_NPROCESSO));
  end;
end;

end.
