{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Renato Rubinho                                 }
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

unit ACBrLibDeREConsts;

interface

uses
  Classes, SysUtils;

const
  CLibDeRENome = 'ACBrLibDeRE';
  CLibDeREVersao = '1.0.0.0';

  // Sessao e chaves do INI de configuracao (valores gravados criptografados)
  CSessaoDeREConfig = 'DeRE';
  CChaveDeREClientSecret = 'ClientSecret';
  CChaveDeREToken = 'Token';

  // Sessoes da resposta de envio / consulta do lote
  CSessaoRespEnvioLote = 'EnvioLote';
  CSessaoRespToken = 'Token';
  CSessaoRespLimpeza = 'LimpezaDados';
  CSessaoRespRetornoLote = 'retornoLoteEventos';
  CSessaoRespOcorrencias = 'ocorrencias';

  // Sessoes da resposta de cada evento de retorno (prefixo Evento + indice de 3 digitos)
  CSessaoRespEvento = 'Evento';
  CSessaoRespideStatus = 'ideStatus';
  CSessaoRespinfoRecEv = 'infoRecEv';
  CSessaoRespidePeriodo = 'idePeriodo';
  CSessaoRespinfoAdic = 'infoAdic';
  CSessaoRespgTotalCodTrib = 'gTotalCodTrib';
  CSessaoRespinfoTotAplicFin = 'infoTotAplicFin';
  CSessaoRespinfoTotTitOfPub = 'infoTotTitOfPub';
  CSessaoRespinfoTotFinanceiro = 'infoTotFinanceiro';
  CSessaoRespinfoTotSaude = 'infoTotSaude';
  CSessaoRespinfoTotProg = 'infoTotProg';
  CSessaoRespdetBC = 'detBC';
  CSessaoRespgCoeficientes = 'gCoeficientes';
  CSessaoRespgBCIBS = 'gBCIBS';
  CSessaoRespgBCCBS = 'gBCCBS';
  CSessaoRespgBCIS = 'gBCIS';
  CSessaoRespgBCNIBS = 'gBCNIBS';
  CSessaoRespgBCNCBS = 'gBCNCBS';
  CSessaoRespdetBCN = 'detBCN';
  CSessaoResptotalTributos = 'totalTributos';
  CSessaoResptotalTributosGeral = 'totalTributosGeral';
  CSessaoRespextratoDetEvento = 'detEvento';
  CSessaoRespextratoDetLacuna = 'detLacuna';

  CSessaoDeRE = 'DeRE';

  ErrValidacaoDeRE = -11;

resourcestring
  SErroDeREAbrir = 'Erro ao abrir o arquivo do DeRE: %s';
  SMsgDeREEventoAdicionado = 'Evento Adicionado: %s';
  SErroDeREConsulta = 'Erro ao Consultar Lote - Protocolo nao informado';
  SInfEventosCarregados = '%d Evento(s) Carregado(s)';
  SInfDeRECarregadas = '%d Evento(s) DeRE Validado(s)';

implementation

end.
