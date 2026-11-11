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

unit ACBrNFeABI.Consts;

interface

uses
  SysUtils;

resourcestring
  NAME_SPACE_NFeABI = 'xmlns="http://www.portalfiscal.inf.br/nfeabi"';

  DSC_TPNF = 'Tipo de Nota Fiscal';
  DSC_MODOPER = 'Modalidade da operacao';
  DSC_NATOPER = 'Natureza da operacao';
  DSC_DETOPER = 'Detalhamento da natureza da operacao';
  DSC_TPNFABI = 'Tipo do documento (0 simplificado, 1 completo)';
  DSC_TPEMITABI = 'Tipo do emitente';
  DSC_INDDECLARANTE = 'Indicador de declarante';
  DSC_PTRANSINDIV = 'Percentual transmitido individualizado';
  DSC_PAQUISICAO = 'Percentual de aquisicao';
  DSC_INDCONTRIB = 'Indicador de contribuinte';
  DSC_TIPOIMOVEL = 'Tipo do imovel (1 urbano, 2 rural)';
  DSC_CCIB = 'Codigo do imovel no CIB';
  DSC_INDIPTU = 'Indicador de inscricao de IPTU';
  DSC_NIPTU = 'Numero da inscricao de IPTU';
  DSC_INDINCRA = 'Indicador de inscricao no INCRA';
  DSC_NINCRA = 'Numero da inscricao no INCRA';
  DSC_ESPIMOVEL = 'Especie do imovel';
  DSC_XOUTROSESPECIES = 'Descricao da especie quando outros';
  DSC_ENQUADRAMENTO = 'Enquadramento do imovel';
  DSC_OBSLOCALIMOVEL = 'Observacao do local do imovel';
  DSC_AREATOTAL = 'Area total do imovel';
  DSC_UAREATOTAL = 'Unidade da area total';
  DSC_CARTORIOREGISTRO = 'Cartorio de registro';
  DSC_MATRICTRANSC = 'Matricula ou transcricao';
  DSC_PTRANSIMOVEL = 'Percentual transmitido do imovel';
  DSC_VTOTALOPERACAO = 'Valor total da operacao';
  DSC_INDTORNA = 'Indicador de torna';
  DSC_VTORNA = 'Valor da torna';
  DSC_INDINCORPLOTE = 'Indicador de incorporacao ou parcelamento do solo';
  DSC_CNPJEMPIMOB = 'CNPJ da empresa incorporadora';
  DSC_CCIBOBRA = 'Codigo CIB da obra';
  DSC_VINICIAL = 'Valor inicial para o redutor de ajuste';
  DSC_VITBI = 'Valor do ITBI';
  DSC_VLAUDEMIO = 'Valor do laudemio';
  DSC_VCONTRAP = 'Valor da contrapartida';
  DSC_VREDAJUSTEIMOVEL = 'Valor do redutor de ajuste do imovel';
  DSC_INDREDSOCIAL = 'Indicador do redutor social';
  DSC_VREDSOCIAL = 'Valor do redutor social';
  DSC_TPINSTRUMENTO = 'Tipo do instrumento';
  DSC_XOUTROSINST = 'Descricao do instrumento quando outros';
  DSC_DTINSTRUMENTO = 'Data do instrumento';
  DSC_INDINTERMEDCORRET = 'Indicador de intermediacao ou corretagem';
  DSC_VCORRETAGEM = 'Valor da corretagem';
  DSC_VOPERACINDIV = 'Valor da operacao individualizado do declarante';
  DSC_VTORNAINDIV = 'Valor da torna individualizado';
  DSC_VREDAJUSTEINDIV = 'Valor do redutor de ajuste individualizado';
  DSC_VREDSOCIALINDIV = 'Valor do redutor social individualizado';
  DSC_TPAG = 'Meio de pagamento';
  DSC_XPAG = 'Descricao do meio de pagamento';
  DSC_VPAG = 'Valor do pagamento';
  DSC_TPARCELA = 'Tipo da parcela';
  DSC_NPARCELA = 'Numero de parcelas';
  DSC_XPARCELA = 'Descricao da parcela';
  DSC_VNFABI = 'Valor total da NF-e ABI';
  DSC_QRCODEABI = 'Texto do QR Code da NF-e ABI';
  DSC_URLCHAVE = 'URL de consulta por chave de acesso';
  DSC_FINNFE = 'Finalidade da NFe';

implementation

end.

