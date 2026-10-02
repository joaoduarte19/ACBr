{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2023 Daniel Simoes de Almeida               }
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

unit Balker.GravarXml;

interface

uses
  SysUtils, Classes, StrUtils,
  ACBrXmlDocument,
  Giap.GravarXml;

type
  { TNFSeW_Balker }

  TNFSeW_Balker = class(TNFSeW_Giap)
  protected
    function GerarDadosTomador: TACBrXmlNode; override;
    function GerarDetalheServico: TACBrXmlNode; override;
    function GerarItem: TACBrXmlNode; override;
  end;

implementation

uses
  ACBrDFe.Conversao,
  ACBrNFSeXConversao,
  ACBrUtil.Strings;

//==============================================================================
// Essa unit tem por finalidade exclusiva gerar o XML do RPS do provedor:
//     Balker que usa o mesmo layout do Giap
//==============================================================================

{ TNFSeW_Balker }

function TNFSeW_Balker.GerarDadosTomador: TACBrXmlNode;
begin
  Result := CreateElement('dadosTomador');

  Result.AppendChild(AddNode(tcStr, '#1', 'aoConsumidor', 1, 1, 1,
                              FpAOwner.SimNaoToStr(NFSe.Tomador.aoConsumidor), ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'bairro', 1, 25, 1,
                              NFSe.Tomador.Endereco.Bairro, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'cep', 1, 9, 1,
                              NFSe.Tomador.Endereco.CEP, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'cidade', 1, 50, 1,
                              NFSe.Tomador.Endereco.xMunicipio, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'complemento', 1, 30, 0,
                              NFSe.Tomador.Endereco.Complemento, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'documento', 1, 14, 1,
                              OnlyNumber(NFSe.Tomador.IdentificacaoTomador.CpfCnpj), ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'email', 1, 14, 1,
                              NFSe.Tomador.Contato.Email, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'ie', 1, 14, 0,
                              OnlyNumber(NFSe.Tomador.IdentificacaoTomador.InscricaoEstadual), ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'logradouro', 1, 50, 1,
                              NFSe.Tomador.Endereco.Endereco, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'nomeTomador', 1, 120, 1,
                              NFSe.Tomador.RazaoSocial, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'numero', 1, 10, 1,
                              NFSe.Tomador.Endereco.Numero, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'pais', 1, 9, 1,
                              NFSe.Tomador.Endereco.xPais, ''));

  if length(OnlyNumber(NFSe.Tomador.IdentificacaoTomador.CpfCnpj)) = 11 then
    Result.AppendChild(AddNode(tcStr, '#1', 'tipoDoc', 1, 1, 1, 'F', ''))
  else
    Result.AppendChild(AddNode(tcStr, '#1', 'tipoDoc', 1, 1, 1, 'J', ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'uf', 1, 2, 1,
                              NFSe.Tomador.Endereco.UF, ''));
end;

function TNFSeW_Balker.GerarDetalheServico: TACBrXmlNode;
var
  xmlNode: TACBrXmlNode;
begin
  Result := CreateElement('detalheServico');

  Result.AppendChild(AddNode(tcDe2, '#1', 'cofins', 1, 16, 1,
                              NFSe.Servico.Valores.ValorCofins, ''));

  Result.AppendChild(AddNode(tcDe2, '#1', 'csll', 1, 16, 1,
                              NFSe.Servico.Valores.ValorCsll, ''));

  Result.AppendChild(AddNode(tcDe2, '#1', 'deducaoMaterial', 1, 16, 1,
                              NFSe.Servico.Valores.ValorDeducoes, ''));

  Result.AppendChild(AddNode(tcDe2, '#1', 'descontoIncondicional', 1, 16, 1,
                              NFSe.Servico.Valores.DescontoIncondicionado, ''));

  Result.AppendChild(AddNode(tcDe2, '#1', 'inss', 1, 16, 1,
                              NFSe.Servico.Valores.ValorInss, ''));

  Result.AppendChild(AddNode(tcDe2, '#1', 'ir', 1, 16, 1,
                              NFSe.Servico.Valores.ValorIr, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'ibsIsento', 1, 1, 1,
                              FpAOwner.SimNaoToStr(NFSe.IBSCBS.valores.ibsIsento), ''));

  Result.AppendChild(AddNode(tcDe2, '#1', 'ibs', 1, 16, 1,
                                    NFSe.IBSCBS.valores.ValorIbsMunicipal, ''));

  Result.AppendChild(AddNode(tcDe2, '#1', 'cbs', 1, 16, 1,
                                    NFSe.IBSCBS.valores.ValorCbs, ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'issRetido', 1, 1, 1,
                              FpAOwner.SituacaoTributariaToStr(NFSe.Servico.Valores.IssRetido), ''));

  xmlNode := GerarItem;
  Result.AppendChild(xmlNode);

  Result.AppendChild(AddNode(tcStr, '#1', 'obs', 1, 4000, 1,
    StringReplace(NFSe.OutrasInformacoes, Opcoes.QuebraLinha,
               FpAOwner.ConfigGeral.QuebradeLinha, [rfReplaceAll]), '', False));

  Result.AppendChild(AddNode(tcDe2, '#1', 'pisPasep', 1, 15, 1,
                                            NFSe.Servico.Valores.ValorPis, ''));
end;

function TNFSeW_Balker.GerarItem: TACBrXmlNode;
begin
  Result := CreateElement('item');

  Result.AppendChild(AddNode(FormatoAliq, '#1', 'aliquota', 1, 16, 1,
                              NFSe.Servico.Valores.Aliquota, ''));

  Result.AppendChild(AddNode(tcInt, '#1', 'codigo', 1, 4, 1,
                              OnlyNumber(NFSe.Servico.ItemListaServico), ''));

  Result.AppendChild(AddNode(tcInt, '#1', 'nbs', 1, 9, 0,
                              OnlyNumber(NFSe.Servico.CodigoNBS), ''));

  Result.AppendChild(AddNode(tcStr, '#1', 'descricao', 1, 4000, 1,
    StringReplace(NFSe.Servico.Discriminacao, Opcoes.QuebraLinha,
              FpAOwner.ConfigGeral.QuebradeLinha, [rfReplaceAll] ), '', False));

  Result.AppendChild(AddNode(tcDe2, '#1', 'valor', 1, 16, 1,
                              NFSe.Servico.Valores.ValorServicos, ''));
end;

end.
