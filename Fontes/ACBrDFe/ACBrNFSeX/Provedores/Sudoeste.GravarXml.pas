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

unit Sudoeste.GravarXml;

interface

uses
  SysUtils, Classes, StrUtils,
  ACBrXmlBase,
  ACBrXmlDocument,
  ACBrNFSeXGravarXml_ABRASFv2;

type
  { TNFSeW_Sudoeste202 }

  TNFSeW_Sudoeste202 = class(TNFSeW_ABRASFv2)
  protected
    procedure Configuracao; override;
    procedure DefinirIDRps; override;

  end;

  { TNFSeW_Sudoeste302 }

  TNFSeW_Sudoeste302 = class(TNFSeW_Sudoeste202)
  protected
    function GerarServico: TACBrXmlNode; override;

  end;

implementation

uses
  ACBrDFe.Conversao,
  ACBrUtil.Strings,
  ACBrNFSeXConsts;

//==============================================================================
// Essa unit tem por finalidade exclusiva gerar o XML do RPS do provedor:
//     Sudoeste
//==============================================================================

{ TNFSeW_Sudoeste202 }

procedure TNFSeW_Sudoeste202.Configuracao;
begin
  inherited Configuracao;

  NrOcorrCodigoNBS := -1;
  FormatoAliq := tcDe2;
  GerarIDRps := True;
  DivAliq100 := True;

  if FpAOwner.ConfigGeral.Params.TemParametro('NaoDividir100') then
    DivAliq100 := False;
end;

procedure TNFSeW_Sudoeste202.DefinirIDRps;
begin
  NFSe.InfID.ID := 'Rps_' + OnlyNumber(NFSe.IdentificacaoRps.Numero) +
                   NFSe.IdentificacaoRps.Serie;
end;

{ TNFSeW_Sudoeste302 }

function TNFSeW_Sudoeste302.GerarServico: TACBrXmlNode;
var
  item: string;
begin
  Result := CreateElement('Servico');

  Result.AppendChild(GerarValores);

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

  Result.AppendChild(AddNode(tcStr, '#32', 'Discriminacao', 1, 2000, NrOcorrDiscriminacao_1,
      StringReplace(NFSe.Servico.Discriminacao, Opcoes.QuebraLinha,
               FpAOwner.ConfigGeral.QuebradeLinha, [rfReplaceAll]), DSC_DISCR));

  Result.AppendChild(AddNode(tcStr, '#33', 'CodigoMunicipio', 1, 7, NrOcorrCodigoMunic_1,
                           OnlyNumber(NFSe.Servico.CodigoMunicipio), DSC_CMUN));

  Result.AppendChild(AddNode(tcStr, '#31', 'CodigoServicoNacional', 1, 20, 0,
                                       NFSe.Servico.CodigoServicoNacional, ''));

  Result.AppendChild(GerarCodigoPaisServico);

  Result.AppendChild(AddNode(tcInt, '#36', 'ExigibilidadeISS',
                               NrMinExigISS, NrMaxExigISS, NrOcorrExigibilidadeISS,
    StrToInt(FpAOwner.ExigibilidadeISSToStr(NFSe.Servico.ExigibilidadeISS)), DSC_INDISS));

  Result.AppendChild(AddNode(tcInt, '#37', 'MunicipioIncidencia', 7, 7, NrOcorrMunIncid,
                                NFSe.Servico.MunicipioIncidencia, DSC_MUNINCI));

  Result.AppendChild(AddNode(tcStr, '#38', 'NumeroProcesso', 1, 30, NrOcorrNumProcesso,
                                   NFSe.Servico.NumeroProcesso, DSC_NPROCESSO));

  Result.AppendChild(AddNode(tcStr, '#32', 'cNBS', 1, 9, 0,
                                                   NFSe.Servico.CodigoNBS, ''));

  Result.AppendChild(AddNode(tcStr, '#39', 'CST', 3, 3, 0,
                     CSTIBSCBSToStr(NFSe.IBSCBS.valores.trib.gIBSCBS.CST), ''));

  Result.AppendChild(AddNode(tcStr, '#39', 'cClassTrib', 6, 6, 0,
                              NFSe.IBSCBS.valores.trib.gIBSCBS.cClassTrib, ''));

  Result.AppendChild(AddNode(tcStr, '#39', 'cIndOp', 1, 1, 0,
                                                       NFSe.IBSCBS.cIndOp, ''));
  {
						<ExigibilidadeISS>1</ExigibilidadeISS>
						<MunicipioIncidencia>3300000</MunicipioIncidencia>
            <CST>000</CST>
						<cClassTrib>000000</cClassTrib>
						<cNBS>000000000</cNBS>
						<cIndOp>000000</cIndOp>
  }

{
<ExigibilidadeISS>1</ExigibilidadeISS>
<cNBS>120013110</cNBS>
<CST>000</CST>
<cClassTrib>000001</cClassTrib>
<cIndOp>050101</cIndOp>
<MunicipioIncidencia>2931350</MunicipioIncidencia>
}
end;

end.
