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

unit pcteConversaoCTe deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Utilize a unit ACBrCTe.Conversao no lugar dessa' {$ENDIF};

interface

uses
  SysUtils, StrUtils, Classes,
  ACBrBase,
  ACBrDFe.Conversao,
  ACBrCTe.Conversao;

{$IFDEF FPC}
  {$DEFINE SUPPORTS_SCOPEDENUMS}
{$ENDIF}
{$IFDEF DELPHI2009_UP}
  {$DEFINE SUPPORTS_SCOPEDENUMS}
{$ENDIF}

type
  TpcnTamanhoPapel = ACBrCTe.Conversao.TTamanhoPapel;
  TpcteModeloNF = ACBrCTe.Conversao.TModeloNF;
  TStatusACBrCTe = ACBrCTe.Conversao.TStatusACBrCTe;
  TVersaoCTe = ACBrCTe.Conversao.TVersaoCTe;
  TSchemaCTe = ACBrCTe.Conversao.TSchemaCTe;
  TLayOutCTe = ACBrCTe.Conversao.TLayOutCTe;
  TModeloCTe = ACBrCTe.Conversao.TModeloCTe;
  TpcteFormaPagamento = ACBrCTe.Conversao.TFormaPagamento;
  TpcteTipoCTe = ACBrCTe.Conversao.TTipoCTe;
  TpcteTipoServico = ACBrCTe.Conversao.TTipoServico;
  TpcteRetira = ACBrCTe.Conversao.TRetira;
  TpcteTomador = ACBrCTe.Conversao.TTomador;
  TpcteLotacao = ACBrCTe.Conversao.TLotacao;
  TpcteDirecao = ACBrCTe.Conversao.TDirecao;
  TpcteTipoTrafego = ACBrCTe.Conversao.TTipoTrafego;
  TpcteTipoDataPeriodo = ACBrCTe.Conversao.TTipoDataPeriodo;
  TpcteTipoHorarioIntervalo = ACBrCTe.Conversao.TTipoHorarioIntervalo;
  TpcteTipoDocumento = ACBrCTe.Conversao.TTipoDocumento;
  TpcteTipoDocumentoAnterior = ACBrCTe.Conversao.TTipoDocumentoAnterior;
  TpcteRspPagPedagio = ACBrCTe.Conversao.TRspPagPedagio;
  TpcteTipoDispositivo = ACBrCTe.Conversao.TTipoDispositivo;
  TpcteTipoPropriedade = ACBrCTe.Conversao.TTipoPropriedade;
  TpcteTrafegoMutuo = ACBrCTe.Conversao.TTrafegoMutuo;
  TpcnindNegociavel = ACBrCTe.Conversao.TindNegociavel;
  TpcteTipoVeiculo = ACBrCTe.Conversao.TTipoVeiculo;
  TpcteRspSeg = ACBrCTe.Conversao.TRspSeg;
  TEspecie = ACBrCTe.Conversao.TEspecie;
  TpInfManu = ACBrCTe.Conversao.TpInfManu;
  TpUniMed = ACBrCTe.Conversao.TpUniMed;
  TtpFretamento = ACBrCTe.Conversao.TtpFretamento;
  TtpComp = ACBrCTe.Conversao.TtpComp;
  TtpNumerario = ACBrCTe.Conversao.TtpNumerario;
  TCRT = ACBrCTe.Conversao.TCRT;
  TtpMotivo = ACBrCTe.Conversao.TtpMotivo;
  TtpPrest = ACBrCTe.Conversao.TtpPrest;
  TclassDuto = ACBrCTe.Conversao.TclassDuto;
  TtpContratacao = ACBrCTe.Conversao.TtpContratacao;

  // Enumerados do TTamanhoPapel
const
  tpA4 = {$IFDEF SUPPORTS_SCOPEDENUMS}TTamanhoPapel.{$ENDIF}tpA4 deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTamanhoPapel da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  tpA4_2vias = {$IFDEF SUPPORTS_SCOPEDENUMS}TTamanhoPapel.{$ENDIF}tpA4_2vias deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTamanhoPapel da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  tpA5 = {$IFDEF SUPPORTS_SCOPEDENUMS}TTamanhoPapel.{$ENDIF}tpA5 deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTamanhoPapel da Unit ACBrCTe.Conversao.pas' {$ENDIF};

  // Enumerados do TModeloNF
const
  moNF011AAvulsa = {$IFDEF SUPPORTS_SCOPEDENUMS}TModeloNF.{$ENDIF}moNF011AAvulsa deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TModeloNF da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  moNFProdutor = {$IFDEF SUPPORTS_SCOPEDENUMS}TModeloNF.{$ENDIF}moNFProdutor deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TModeloNF da Unit ACBrCTe.Conversao.pas' {$ENDIF};

  TpcteModeloNFArrayStrings: array[TpcteModeloNF] of string = ('01','04');

  // Enumerados do TStatusACBrCTe
const
  stCTeIdle = {$IFDEF SUPPORTS_SCOPEDENUMS}TStatusACBrCTe.{$ENDIF}stCTeIdle deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TStatusACBrCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  stCTeStatusServico = {$IFDEF SUPPORTS_SCOPEDENUMS}TStatusACBrCTe.{$ENDIF}stCTeStatusServico deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TStatusACBrCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  stCTeRecepcao = {$IFDEF SUPPORTS_SCOPEDENUMS}TStatusACBrCTe.{$ENDIF}stCTeRecepcao deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TStatusACBrCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  stCTeRetRecepcao = {$IFDEF SUPPORTS_SCOPEDENUMS}TStatusACBrCTe.{$ENDIF}stCTeRetRecepcao deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TStatusACBrCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  stCTeConsulta = {$IFDEF SUPPORTS_SCOPEDENUMS}TStatusACBrCTe.{$ENDIF}stCTeConsulta deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TStatusACBrCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  stCTeCancelamento = {$IFDEF SUPPORTS_SCOPEDENUMS}TStatusACBrCTe.{$ENDIF}stCTeCancelamento deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TStatusACBrCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  stCTeInutilizacao = {$IFDEF SUPPORTS_SCOPEDENUMS}TStatusACBrCTe.{$ENDIF}stCTeInutilizacao deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TStatusACBrCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  stCTeRecibo = {$IFDEF SUPPORTS_SCOPEDENUMS}TStatusACBrCTe.{$ENDIF}stCTeRecibo deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TStatusACBrCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  stCTeCadastro = {$IFDEF SUPPORTS_SCOPEDENUMS}TStatusACBrCTe.{$ENDIF}stCTeCadastro deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TStatusACBrCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  stCTeEmail = {$IFDEF SUPPORTS_SCOPEDENUMS}TStatusACBrCTe.{$ENDIF}stCTeEmail deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TStatusACBrCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  stCTeCCe = {$IFDEF SUPPORTS_SCOPEDENUMS}TStatusACBrCTe.{$ENDIF}stCTeCCe deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TStatusACBrCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  stCTeEvento = {$IFDEF SUPPORTS_SCOPEDENUMS}TStatusACBrCTe.{$ENDIF}stCTeEvento deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TStatusACBrCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  stCTeDistDFeInt = {$IFDEF SUPPORTS_SCOPEDENUMS}TStatusACBrCTe.{$ENDIF}stCTeDistDFeInt deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TStatusACBrCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  stCTeEnvioWebService = {$IFDEF SUPPORTS_SCOPEDENUMS}TStatusACBrCTe.{$ENDIF}stCTeEnvioWebService deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TStatusACBrCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};

  // Enumerados do TVersaoCTe
const
  ve200 = {$IFDEF SUPPORTS_SCOPEDENUMS}TVersaoCTe.{$ENDIF}ve200 deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TVersaoCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  ve300 = {$IFDEF SUPPORTS_SCOPEDENUMS}TVersaoCTe.{$ENDIF}ve300 deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TVersaoCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  ve400 = {$IFDEF SUPPORTS_SCOPEDENUMS}TVersaoCTe.{$ENDIF}ve400 deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TVersaoCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};

  TVersaoCTeArrayStrings: array[TVersaoCTe] of string = ('2.00', '3.00', '4.00');
  TVersaoCTeArrayDouble: array[TVersaoCTe] of Double = (2.00, 3.00, 4.00);

  // Enumerados do TSchemaCTe
const
  schErro = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaCTe.{$ENDIF}schErro deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  schCTe = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaCTe.{$ENDIF}schCTe deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  schCTeOS = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaCTe.{$ENDIF}schCTeOS deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  schGTVe = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaCTe.{$ENDIF}schGTVe deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  schcancCTe = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaCTe.{$ENDIF}schcancCTe deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  schInutCTe = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaCTe.{$ENDIF}schInutCTe deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  schEventoCTe = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaCTe.{$ENDIF}schEventoCTe deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  schCTeSimp = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaCTe.{$ENDIF}schCTeSimp deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  schconsReciCTe = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaCTe.{$ENDIF}schconsReciCTe deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  schconsSitCTe = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaCTe.{$ENDIF}schconsSitCTe deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  schconsStatServCTe = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaCTe.{$ENDIF}schconsStatServCTe deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  schconsCad = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaCTe.{$ENDIF}schconsCad deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  schcteModalAereo = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaCTe.{$ENDIF}schcteModalAereo deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  schcteModalAquaviario = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaCTe.{$ENDIF}schcteModalAquaviario deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  schcteModalDutoviario = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaCTe.{$ENDIF}schcteModalDutoviario deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  schcteModalFerroviario = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaCTe.{$ENDIF}schcteModalFerroviario deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  schcteModalRodoviario = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaCTe.{$ENDIF}schcteModalRodoviario deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  schcteMultiModal = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaCTe.{$ENDIF}schcteMultiModal deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  schevEPECCTe = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaCTe.{$ENDIF}schevEPECCTe deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  schevCancCTe = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaCTe.{$ENDIF}schevCancCTe deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  schevRegMultimodal = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaCTe.{$ENDIF}schevRegMultimodal deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  schevCCeCTe = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaCTe.{$ENDIF}schevCCeCTe deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  schdistDFeInt = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaCTe.{$ENDIF}schdistDFeInt deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  schcteModalRodoviarioOS = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaCTe.{$ENDIF}schcteModalRodoviarioOS deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  schevPrestDesacordo = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaCTe.{$ENDIF}schevPrestDesacordo deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  schevGTV = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaCTe.{$ENDIF}schevGTV deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  schevCECTe = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaCTe.{$ENDIF}schevCECTe deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  schevCancCECTe = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaCTe.{$ENDIF}schevCancCECTe deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  schevCancPrestDesacordo = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaCTe.{$ENDIF}schevCancPrestDesacordo deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  schevIECTe = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaCTe.{$ENDIF}schevIECTe deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  schevCancIECTe = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaCTe.{$ENDIF}schevCancIECTe deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  schevVincPgto = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaCTe.{$ENDIF}schevVincPgto deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  schevCancVincPgto = {$IFDEF SUPPORTS_SCOPEDENUMS}TSchemaCTe.{$ENDIF}schevCancVincPgto deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TSchemaCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};

  TSchemaCTeArrayStrings: array[TSchemaCTe] of string = ('', '', '', '', '', '',
    '', '', '', '', '', '', '', '', '', '', '', '', 'evEPECCTe', 'evCancCTe',
    'evRegMultimodal', 'evCCeCTe', 'distDFeInt', 'cteModalRodoviarioOS',
    'evPrestDesacordo', 'evGTV', 'evCECTe', 'evCancCECTe',
    'evCancPrestDesacordo', 'evIECTe', 'evCancIECTe', 'evVincPgto',
    'evCancVincPgto');

  // Enumerados do TLayOutCTe
const
  LayCTeRecepcao = {$IFDEF SUPPORTS_SCOPEDENUMS}TLayOutCTe.{$ENDIF}LayCTeRecepcao deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TLayOutCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  LayCTeRetRecepcao = {$IFDEF SUPPORTS_SCOPEDENUMS}TLayOutCTe.{$ENDIF}LayCTeRetRecepcao deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TLayOutCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  LayCTeCancelamento = {$IFDEF SUPPORTS_SCOPEDENUMS}TLayOutCTe.{$ENDIF}LayCTeCancelamento deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TLayOutCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  LayCTeInutilizacao = {$IFDEF SUPPORTS_SCOPEDENUMS}TLayOutCTe.{$ENDIF}LayCTeInutilizacao deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TLayOutCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  LayCTeConsulta = {$IFDEF SUPPORTS_SCOPEDENUMS}TLayOutCTe.{$ENDIF}LayCTeConsulta deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TLayOutCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  LayCTeStatusServico = {$IFDEF SUPPORTS_SCOPEDENUMS}TLayOutCTe.{$ENDIF}LayCTeStatusServico deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TLayOutCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  LayCTeCadastro = {$IFDEF SUPPORTS_SCOPEDENUMS}TLayOutCTe.{$ENDIF}LayCTeCadastro deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TLayOutCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  LayCTeEvento = {$IFDEF SUPPORTS_SCOPEDENUMS}TLayOutCTe.{$ENDIF}LayCTeEvento deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TLayOutCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  LayCTeEventoAN = {$IFDEF SUPPORTS_SCOPEDENUMS}TLayOutCTe.{$ENDIF}LayCTeEventoAN deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TLayOutCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  LayCTeDistDFeInt = {$IFDEF SUPPORTS_SCOPEDENUMS}TLayOutCTe.{$ENDIF}LayCTeDistDFeInt deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TLayOutCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  LayCTeRecepcaoOS = {$IFDEF SUPPORTS_SCOPEDENUMS}TLayOutCTe.{$ENDIF}LayCTeRecepcaoOS deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TLayOutCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  LayCTeRecepcaoSinc = {$IFDEF SUPPORTS_SCOPEDENUMS}TLayOutCTe.{$ENDIF}LayCTeRecepcaoSinc deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TLayOutCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  LayCTeRecepcaoGTVe = {$IFDEF SUPPORTS_SCOPEDENUMS}TLayOutCTe.{$ENDIF}LayCTeRecepcaoGTVe deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TLayOutCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  LayCTeURLQRCode = {$IFDEF SUPPORTS_SCOPEDENUMS}TLayOutCTe.{$ENDIF}LayCTeURLQRCode deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TLayOutCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  LayURLConsultaCTe = {$IFDEF SUPPORTS_SCOPEDENUMS}TLayOutCTe.{$ENDIF}LayURLConsultaCTe deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TLayOutCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  LayCTeRecepcaoSimp = {$IFDEF SUPPORTS_SCOPEDENUMS}TLayOutCTe.{$ENDIF}LayCTeRecepcaoSimp deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TLayOutCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};

  TLayOutCTeArrayStrings: array[TLayOutCTe] of string = ('CTeRecepcao',
    'CTeRetRecepcao', 'CTeCancelamento', 'CTeInutilizacao',
    'CTeConsultaProtocolo', 'CTeStatusServico', 'CTeConsultaCadastro',
    'RecepcaoEvento', 'RecepcaoEventoAN', 'CTeDistribuicaoDFe', 'CTeRecepcaoOS',
    'CTeRecepcaoSinc', 'CTeRecepcaoGTVe', 'URL-QRCode', 'URL-ConsultaCTe',
    'CTeRecepcaoSimp');

  // Enumerados do TModeloCTe
const
  moCTe = {$IFDEF SUPPORTS_SCOPEDENUMS}TModeloCTe.{$ENDIF}moCTe deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TModeloCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  moGTVe = {$IFDEF SUPPORTS_SCOPEDENUMS}TModeloCTe.{$ENDIF}moGTVe deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TModeloCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  moCTeOS = {$IFDEF SUPPORTS_SCOPEDENUMS}TModeloCTe.{$ENDIF}moCTeOS deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TModeloCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  moCTeSimp = {$IFDEF SUPPORTS_SCOPEDENUMS}TModeloCTe.{$ENDIF}moCTeSimp deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TModeloCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
{
 O código correto do modelo CTe Simplificado é 57, mas foi alterado para 58
 para que o componente interprete corretamente o modelo de CTe
}
  TModeloCTeArrayStrings: array[TModeloCTe] of string = ('57', '64', '67', '57');

  // Enumerados do TFormaPagamento
const
  fpPago = {$IFDEF SUPPORTS_SCOPEDENUMS}TFormaPagamento.{$ENDIF}fpPago deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TFormaPagamento da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  fpAPagar = {$IFDEF SUPPORTS_SCOPEDENUMS}TFormaPagamento.{$ENDIF}fpAPagar deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TFormaPagamento da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  fpOutros = {$IFDEF SUPPORTS_SCOPEDENUMS}TFormaPagamento.{$ENDIF}fpOutros deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TFormaPagamento da Unit ACBrCTe.Conversao.pas' {$ENDIF};

  TFormaPagamentoArrayStrings: array[TpcteFormaPagamento] of string = ('0',
    '1', '2');
  TFormaPagamentoDescArrayStrings: array[TpcteFormaPagamento]
     of string = ('PAGO', 'A PAGAR', 'OUTROS');

  // Enumerados do TTipoCTe
const
  tcNormal = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoCTe.{$ENDIF}tcNormal deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  tcComplemento = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoCTe.{$ENDIF}tcComplemento deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  tcAnulacao = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoCTe.{$ENDIF}tcAnulacao deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  tcSubstituto = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoCTe.{$ENDIF}tcSubstituto deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  tcGTVe = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoCTe.{$ENDIF}tcGTVe deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  tcCTeSimp = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoCTe.{$ENDIF}tcCTeSimp deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  tcSubstCTeSimpl = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoCTe.{$ENDIF}tcSubstCTeSimpl deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};

  TTipoCTeArrayStrings: array[TpcteTipoCTe] of string = ('0', '1', '2', '3',
    '4', '5', '6');
  TTipoCTeDescArrayStrings: array[TpcteTipoCTe] of string = ('NORMAL',
    'COMPLEMENTO', 'ANULAÇÃO', 'SUBSTITUTO', 'GTVe', 'CTeSimp',
    'SubstCTeSimpl');

  // Enumerados do TTipoServico
const
  tsNormal = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoServico.{$ENDIF}tsNormal deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoServico da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  tsSubcontratacao = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoServico.{$ENDIF}tsSubcontratacao deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoServico da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  tsRedespacho = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoServico.{$ENDIF}tsRedespacho deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoServico da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  tsIntermediario = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoServico.{$ENDIF}tsIntermediario deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoServico da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  tsMultimodal = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoServico.{$ENDIF}tsMultimodal deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoServico da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  tsTranspPessoas = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoServico.{$ENDIF}tsTranspPessoas deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoServico da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  tsTranspValores = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoServico.{$ENDIF}tsTranspValores deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoServico da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  tsExcessoBagagem = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoServico.{$ENDIF}tsExcessoBagagem deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoServico da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  tsGTV = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoServico.{$ENDIF}tsGTV deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoServico da Unit ACBrCTe.Conversao.pas' {$ENDIF};

  TTipoServicoArrayStrings: array[TpcteTipoServico] of string = ('0', '1',
    '2', '3', '4', '6', '7', '8', '9');
  TTipoServicoDescArrayStrings: array[TpcteTipoServico]
    of string = ('NORMAL', 'SUBCONTRATAÇÃO', 'REDESPACHO',
      'REDESP. INTERMEDIÁRIO', 'VINC. A MULTIMODAL', 'TRANSP. PESSOAS',
      'TRANSP. VALORES', 'EXCESSO BAGAGEM', 'GTV');

  // Enumerados do TRetira
const
  rtSim = {$IFDEF SUPPORTS_SCOPEDENUMS}TRetira.{$ENDIF}rtSim deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TRetira da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  rtNao = {$IFDEF SUPPORTS_SCOPEDENUMS}TRetira.{$ENDIF}rtNao deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TRetira da Unit ACBrCTe.Conversao.pas' {$ENDIF};

  TRetiraArrayStrings: array[TpcteRetira] of string = ('0', '1');

  // Enumerados do TTomador
const
  tmRemetente = {$IFDEF SUPPORTS_SCOPEDENUMS}TTomador.{$ENDIF}tmRemetente deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTomador da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  tmExpedidor = {$IFDEF SUPPORTS_SCOPEDENUMS}TTomador.{$ENDIF}tmExpedidor deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTomador da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  tmRecebedor = {$IFDEF SUPPORTS_SCOPEDENUMS}TTomador.{$ENDIF}tmRecebedor deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTomador da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  tmDestinatario = {$IFDEF SUPPORTS_SCOPEDENUMS}TTomador.{$ENDIF}tmDestinatario deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTomador da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  tmOutros = {$IFDEF SUPPORTS_SCOPEDENUMS}TTomador.{$ENDIF}tmOutros deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTomador da Unit ACBrCTe.Conversao.pas' {$ENDIF};

  TTomadorArrayStrings: array[TpcteTomador] of string = ('0', '1', '2', '3',
    '4');
  TTomadorDescArrayStrings: array[TpcteTomador] of string = ('REMETENTE',
    'EXPEDIDOR', 'RECEBEDOR', 'DESTINATARIO', 'OUTROS');

  // Enumerados do TLotacao
const
  ltNao = {$IFDEF SUPPORTS_SCOPEDENUMS}TLotacao.{$ENDIF}ltNao deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TLotacao da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  ltSim = {$IFDEF SUPPORTS_SCOPEDENUMS}TLotacao.{$ENDIF}ltSim deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TLotacao da Unit ACBrCTe.Conversao.pas' {$ENDIF};

  TLotacaoArrayStrings: array[TpcteLotacao] of string = ('0', '1');

  // Enumerados do TDirecao
const
  drNorte = {$IFDEF SUPPORTS_SCOPEDENUMS}TDirecao.{$ENDIF}drNorte deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TDirecao da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  drLeste = {$IFDEF SUPPORTS_SCOPEDENUMS}TDirecao.{$ENDIF}drLeste deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TDirecao da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  drSul = {$IFDEF SUPPORTS_SCOPEDENUMS}TDirecao.{$ENDIF}drSul deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TDirecao da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  drOeste = {$IFDEF SUPPORTS_SCOPEDENUMS}TDirecao.{$ENDIF}drOeste deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TDirecao da Unit ACBrCTe.Conversao.pas' {$ENDIF};

  TDirecaoArrayStrings: array[TpcteDirecao] of string = ('N', 'L', 'S', 'O');

  // Enumerados do TTipoTrafego
const
  ttProprio = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoTrafego.{$ENDIF}ttProprio deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoTrafego da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  ttMutuo = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoTrafego.{$ENDIF}ttMutuo deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoTrafego da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  ttRodoferroviario = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoTrafego.{$ENDIF}ttRodoferroviario deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoTrafego da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  ttRodoviario = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoTrafego.{$ENDIF}ttRodoviario deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoTrafego da Unit ACBrCTe.Conversao.pas' {$ENDIF};

  TTipoTrafegoArrayStrings: array[TpcteTipoTrafego] of string = ('0', '1',
    '2', '3');

  // Enumerados do TTipoDataPeriodo
const
  tdSemData = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoDataPeriodo.{$ENDIF}tdSemData deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoDataPeriodo da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  tdNaData = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoDataPeriodo.{$ENDIF}tdNaData deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoDataPeriodo da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  tdAteData = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoDataPeriodo.{$ENDIF}tdAteData deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoDataPeriodo da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  tdApartirData = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoDataPeriodo.{$ENDIF}tdApartirData deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoDataPeriodo da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  tdNoPeriodo = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoDataPeriodo.{$ENDIF}tdNoPeriodo deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoDataPeriodo da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  tdNaoInformado = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoDataPeriodo.{$ENDIF}tdNaoInformado deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoDataPeriodo da Unit ACBrCTe.Conversao.pas' {$ENDIF};

  TTipoDataPeriodoArrayStrings: array[TpcteTipoDataPeriodo] of string = ('0',
    '1', '2', '3', '4', '-1');

  // Enumerados do TTipoHorarioIntervalo
const
  thSemHorario = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoHorarioIntervalo.{$ENDIF}thSemHorario deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoHorarioIntervalo da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  thNoHorario = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoHorarioIntervalo.{$ENDIF}thNoHorario deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoHorarioIntervalo da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  thAteHorario = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoHorarioIntervalo.{$ENDIF}thAteHorario deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoHorarioIntervalo da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  thApartirHorario = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoHorarioIntervalo.{$ENDIF}thApartirHorario deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoHorarioIntervalo da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  thNoIntervalo = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoHorarioIntervalo.{$ENDIF}thNoIntervalo deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoHorarioIntervalo da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  thNaoInformado = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoHorarioIntervalo.{$ENDIF}thNaoInformado deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoHorarioIntervalo da Unit ACBrCTe.Conversao.pas' {$ENDIF};

  TTipoHorarioIntervaloArrayStrings: array[TpcteTipoHorarioIntervalo]
     of string = ('0', '1', '2', '3', '4', '-1');

  // Enumerados do TTipoDocumento
const
  tdDeclaracao = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoDocumento.{$ENDIF}tdDeclaracao deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoDocumento da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  tdDutoviario = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoDocumento.{$ENDIF}tdDutoviario deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoDocumento da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  tdCFeSAT = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoDocumento.{$ENDIF}tdCFeSAT deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoDocumento da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  tdNFCe = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoDocumento.{$ENDIF}tdNFCe deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoDocumento da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  tdOutros = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoDocumento.{$ENDIF}tdOutros deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoDocumento da Unit ACBrCTe.Conversao.pas' {$ENDIF};

  TTipoDocumentoArrayStrings: array[TpcteTipoDocumento] of string = ('00',
    '10', '59', '65', '99');

  // Enumerados do TTipoDocumentoAnterior
const
  daCTRC = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoDocumentoAnterior.{$ENDIF}daCTRC deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoDocumentoAnterior da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  daCTAC = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoDocumentoAnterior.{$ENDIF}daCTAC deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoDocumentoAnterior da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  daACT = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoDocumentoAnterior.{$ENDIF}daACT deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoDocumentoAnterior da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  daNF7 = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoDocumentoAnterior.{$ENDIF}daNF7 deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoDocumentoAnterior da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  daNF27 = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoDocumentoAnterior.{$ENDIF}daNF27 deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoDocumentoAnterior da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  daCAN = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoDocumentoAnterior.{$ENDIF}daCAN deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoDocumentoAnterior da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  daCTMC = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoDocumentoAnterior.{$ENDIF}daCTMC deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoDocumentoAnterior da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  daATRE = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoDocumentoAnterior.{$ENDIF}daATRE deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoDocumentoAnterior da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  daDTA = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoDocumentoAnterior.{$ENDIF}daDTA deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoDocumentoAnterior da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  daCAI = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoDocumentoAnterior.{$ENDIF}daCAI deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoDocumentoAnterior da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  daCCPI = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoDocumentoAnterior.{$ENDIF}daCCPI deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoDocumentoAnterior da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  daCA = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoDocumentoAnterior.{$ENDIF}daCA deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoDocumentoAnterior da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  daTIF = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoDocumentoAnterior.{$ENDIF}daTIF deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoDocumentoAnterior da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  daBL = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoDocumentoAnterior.{$ENDIF}daBL deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoDocumentoAnterior da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  daOutros = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoDocumentoAnterior.{$ENDIF}daOutros deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoDocumentoAnterior da Unit ACBrCTe.Conversao.pas' {$ENDIF};

  TTipoDocumentoAnteriorArrayStrings: array[TpcteTipoDocumentoAnterior]
     of string = ('00', '01', '02', '03', '04', '05', '06', '07', '08', '09',
       '10', '11', '12', '13', '99');

  // Enumerados do TRspPagPedagio
const
  rpEmitente = {$IFDEF SUPPORTS_SCOPEDENUMS}TRspPagPedagio.{$ENDIF}rpEmitente deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TRspPagPedagio da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  rpRemetente = {$IFDEF SUPPORTS_SCOPEDENUMS}TRspPagPedagio.{$ENDIF}rpRemetente deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TRspPagPedagio da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  rpExpedidor = {$IFDEF SUPPORTS_SCOPEDENUMS}TRspPagPedagio.{$ENDIF}rpExpedidor deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TRspPagPedagio da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  rpRecebedor = {$IFDEF SUPPORTS_SCOPEDENUMS}TRspPagPedagio.{$ENDIF}rpRecebedor deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TRspPagPedagio da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  rpDestinatario = {$IFDEF SUPPORTS_SCOPEDENUMS}TRspPagPedagio.{$ENDIF}rpDestinatario deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TRspPagPedagio da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  rpTomadorServico = {$IFDEF SUPPORTS_SCOPEDENUMS}TRspPagPedagio.{$ENDIF}rpTomadorServico deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TRspPagPedagio da Unit ACBrCTe.Conversao.pas' {$ENDIF};

  TRspPagPedagioArrayStrings: array[TpcteRspPagPedagio] of string = ('0',
    '1', '2', '3', '4', '5');

  // Enumerados do TTipoDispositivo
const
  tdCartaoMagnetico = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoDispositivo.{$ENDIF}tdCartaoMagnetico deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoDispositivo da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  tdTAG = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoDispositivo.{$ENDIF}tdTAG deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoDispositivo da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  tdTicket = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoDispositivo.{$ENDIF}tdTicket deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoDispositivo da Unit ACBrCTe.Conversao.pas' {$ENDIF};

  TTipoDispositivoArrayStrings: array[TpcteTipoDispositivo]
     of string = ('1', '2', '3');

  // Enumerados do TTipoPropriedade
const
  tpProprio = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoPropriedade.{$ENDIF}tpProprio deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoPropriedade da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  tpTerceiro = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoPropriedade.{$ENDIF}tpTerceiro deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoPropriedade da Unit ACBrCTe.Conversao.pas' {$ENDIF};

  TTipoPropriedadeArrayStrings: array[TpcteTipoPropriedade] of string = ('P',
    'T');

  // Enumerados do TTrafegoMutuo
const
  tmOrigem = {$IFDEF SUPPORTS_SCOPEDENUMS}TTrafegoMutuo.{$ENDIF}tmOrigem deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTrafegoMutuo da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  tmDestino = {$IFDEF SUPPORTS_SCOPEDENUMS}TTrafegoMutuo.{$ENDIF}tmDestino deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTrafegoMutuo da Unit ACBrCTe.Conversao.pas' {$ENDIF};

  TTrafegoMutuoArrayStrings: array[TpcteTrafegoMutuo] of string = ('1', '2');

  // Enumerados do TindNegociavel
const
  inNaoNegociavel = {$IFDEF SUPPORTS_SCOPEDENUMS}TindNegociavel.{$ENDIF}inNaoNegociavel deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TindNegociavel da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  inNegociavel = {$IFDEF SUPPORTS_SCOPEDENUMS}TindNegociavel.{$ENDIF}inNegociavel deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TindNegociavel da Unit ACBrCTe.Conversao.pas' {$ENDIF};

  TindNegociavelArrayStrings: array[TpcnindNegociavel] of string = ('0', '1');

  // Enumerados do TTipoVeiculo
const
  tvTracao = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoVeiculo.{$ENDIF}tvTracao deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoVeiculo da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  tvReboque = {$IFDEF SUPPORTS_SCOPEDENUMS}TTipoVeiculo.{$ENDIF}tvReboque deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TTipoVeiculo da Unit ACBrCTe.Conversao.pas' {$ENDIF};

  TTipoVeiculoArrayStrings: array[TpcteTipoVeiculo] of string = ('0', '1');

  // Enumerados do TRspSeg
const
  rsRemetente = {$IFDEF SUPPORTS_SCOPEDENUMS}TRspSeg.{$ENDIF}rsRemetente deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TRspSeg da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  rsExpedidor = {$IFDEF SUPPORTS_SCOPEDENUMS}TRspSeg.{$ENDIF}rsExpedidor deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TRspSeg da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  rsRecebedor = {$IFDEF SUPPORTS_SCOPEDENUMS}TRspSeg.{$ENDIF}rsRecebedor deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TRspSeg da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  rsDestinatario = {$IFDEF SUPPORTS_SCOPEDENUMS}TRspSeg.{$ENDIF}rsDestinatario deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TRspSeg da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  rsEmitenteCTe = {$IFDEF SUPPORTS_SCOPEDENUMS}TRspSeg.{$ENDIF}rsEmitenteCTe deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TRspSeg da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  rsTomadorServico = {$IFDEF SUPPORTS_SCOPEDENUMS}TRspSeg.{$ENDIF}rsTomadorServico deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TRspSeg da Unit ACBrCTe.Conversao.pas' {$ENDIF};

  TRspSegArrayStrings: array[TpcteRspSeg] of string = ('0', '1', '2', '3',
    '4', '5');
  TRspSegDescArrayStrings: array[TpcteRspSeg] of string = ('REMETENTE',
    'EXPEDIDOR', 'RECEBEDOR', 'DESTINATARIO', 'EMITENTE', 'TOMADOR SERVICO');

  // Enumerados do TEspecie
const
  teNumerario = {$IFDEF SUPPORTS_SCOPEDENUMS}TEspecie.{$ENDIF}teNumerario deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TEspecie da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  teCheque = {$IFDEF SUPPORTS_SCOPEDENUMS}TEspecie.{$ENDIF}teCheque deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TEspecie da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  teMoeda = {$IFDEF SUPPORTS_SCOPEDENUMS}TEspecie.{$ENDIF}teMoeda deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TEspecie da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  teOutros = {$IFDEF SUPPORTS_SCOPEDENUMS}TEspecie.{$ENDIF}teOutros deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TEspecie da Unit ACBrCTe.Conversao.pas' {$ENDIF};

  TEspecieArrayStrings: array[TEspecie] of string = ('1', '2', '3', '4');

  // Enumerados do TpInfManu
const
  imCEEAV = {$IFDEF SUPPORTS_SCOPEDENUMS}TpInfManu.{$ENDIF}imCEEAV deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TpInfManu da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  imAPCDEA = {$IFDEF SUPPORTS_SCOPEDENUMS}TpInfManu.{$ENDIF}imAPCDEA deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TpInfManu da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  imSAC = {$IFDEF SUPPORTS_SCOPEDENUMS}TpInfManu.{$ENDIF}imSAC deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TpInfManu da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  imAPDENR = {$IFDEF SUPPORTS_SCOPEDENUMS}TpInfManu.{$ENDIF}imAPDENR deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TpInfManu da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  imAPQI = {$IFDEF SUPPORTS_SCOPEDENUMS}TpInfManu.{$ENDIF}imAPQI deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TpInfManu da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  imGSR = {$IFDEF SUPPORTS_SCOPEDENUMS}TpInfManu.{$ENDIF}imGSR deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TpInfManu da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  imNR = {$IFDEF SUPPORTS_SCOPEDENUMS}TpInfManu.{$ENDIF}imNR deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TpInfManu da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  imAPCC = {$IFDEF SUPPORTS_SCOPEDENUMS}TpInfManu.{$ENDIF}imAPCC deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TpInfManu da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  imAAGA = {$IFDEF SUPPORTS_SCOPEDENUMS}TpInfManu.{$ENDIF}imAAGA deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TpInfManu da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  imPI965 = {$IFDEF SUPPORTS_SCOPEDENUMS}TpInfManu.{$ENDIF}imPI965 deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TpInfManu da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  imPI966 = {$IFDEF SUPPORTS_SCOPEDENUMS}TpInfManu.{$ENDIF}imPI966 deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TpInfManu da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  imPI967 = {$IFDEF SUPPORTS_SCOPEDENUMS}TpInfManu.{$ENDIF}imPI967 deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TpInfManu da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  imPI968 = {$IFDEF SUPPORTS_SCOPEDENUMS}TpInfManu.{$ENDIF}imPI968 deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TpInfManu da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  imPI969 = {$IFDEF SUPPORTS_SCOPEDENUMS}TpInfManu.{$ENDIF}imPI969 deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TpInfManu da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  imPI970 = {$IFDEF SUPPORTS_SCOPEDENUMS}TpInfManu.{$ENDIF}imPI970 deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TpInfManu da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  imOUTRO = {$IFDEF SUPPORTS_SCOPEDENUMS}TpInfManu.{$ENDIF}imOUTRO deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TpInfManu da Unit ACBrCTe.Conversao.pas' {$ENDIF};

  TpInfManuArrayStrings: array[TpInfManu] of string = ('01', '02', '03', '04',
    '05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15', '99');
  TpInfManuV2ArrayStrings: array[TpInfManu] of string = ('1', '2', '3', '4', '5',
    '6', '7', '8', '9', '', '', '', '', '', '', '99');

  // Enumerados do TpUniMed
const
  umKG = {$IFDEF SUPPORTS_SCOPEDENUMS}TpUniMed.{$ENDIF}umKG deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TpUniMed da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  umKGG = {$IFDEF SUPPORTS_SCOPEDENUMS}TpUniMed.{$ENDIF}umKGG deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TpUniMed da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  umLitros = {$IFDEF SUPPORTS_SCOPEDENUMS}TpUniMed.{$ENDIF}umLitros deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TpUniMed da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  umTI = {$IFDEF SUPPORTS_SCOPEDENUMS}TpUniMed.{$ENDIF}umTI deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TpUniMed da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  umUnidades = {$IFDEF SUPPORTS_SCOPEDENUMS}TpUniMed.{$ENDIF}umUnidades deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TpUniMed da Unit ACBrCTe.Conversao.pas' {$ENDIF};

  TpUniMedArrayStrings: array[TpUniMed] of string = ('1', '2', '3', '4', '5');

  // Enumerados do TtpFretamento
const
  tfNenhum = {$IFDEF SUPPORTS_SCOPEDENUMS}TtpFretamento.{$ENDIF}tfNenhum deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TtpFretamento da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  tfEventual = {$IFDEF SUPPORTS_SCOPEDENUMS}TtpFretamento.{$ENDIF}tfEventual deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TtpFretamento da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  tpContinuo = {$IFDEF SUPPORTS_SCOPEDENUMS}TtpFretamento.{$ENDIF}tpContinuo deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TtpFretamento da Unit ACBrCTe.Conversao.pas' {$ENDIF};

  TtpFretamentoArrayStrings: array[TtpFretamento] of string = ('', '1', '2');

  // Enumerados do TtpComp
const
  tcCustodia = {$IFDEF SUPPORTS_SCOPEDENUMS}TtpComp.{$ENDIF}tcCustodia deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TtpComp da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  tcEmbarque = {$IFDEF SUPPORTS_SCOPEDENUMS}TtpComp.{$ENDIF}tcEmbarque deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TtpComp da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  tcTempodeespera = {$IFDEF SUPPORTS_SCOPEDENUMS}TtpComp.{$ENDIF}tcTempodeespera deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TtpComp da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  tcMalote = {$IFDEF SUPPORTS_SCOPEDENUMS}TtpComp.{$ENDIF}tcMalote deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TtpComp da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  tcAdValorem = {$IFDEF SUPPORTS_SCOPEDENUMS}TtpComp.{$ENDIF}tcAdValorem deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TtpComp da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  tcOutros = {$IFDEF SUPPORTS_SCOPEDENUMS}TtpComp.{$ENDIF}tcOutros deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TtpComp da Unit ACBrCTe.Conversao.pas' {$ENDIF};

  TtpCompArrayStrings: array[TtpComp] of string = ('1', '2', '3', '4', '5', '6');

  // Enumerados do TtpNumerario
const
  tnNacional = {$IFDEF SUPPORTS_SCOPEDENUMS}TtpNumerario.{$ENDIF}tnNacional deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TtpNumerario da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  tnEstrangeiro = {$IFDEF SUPPORTS_SCOPEDENUMS}TtpNumerario.{$ENDIF}tnEstrangeiro deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TtpNumerario da Unit ACBrCTe.Conversao.pas' {$ENDIF};

  TtpNumerarioArrayStrings: array[TtpNumerario] of string = ('1', '2');

  // Enumerados do TCRT
const
  crtNenhum = {$IFDEF SUPPORTS_SCOPEDENUMS}TCRT.{$ENDIF}crtNenhum deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TCRT da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  crtSimplesNacional = {$IFDEF SUPPORTS_SCOPEDENUMS}TCRT.{$ENDIF}crtSimplesNacional deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TCRT da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  crtSimplesExcessoReceita = {$IFDEF SUPPORTS_SCOPEDENUMS}TCRT.{$ENDIF}crtSimplesExcessoReceita deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TCRT da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  crtRegimeNormal = {$IFDEF SUPPORTS_SCOPEDENUMS}TCRT.{$ENDIF}crtRegimeNormal deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TCRT da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  crtSimplesNacionalMEI = {$IFDEF SUPPORTS_SCOPEDENUMS}TCRT.{$ENDIF}crtSimplesNacionalMEI deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TCRT da Unit ACBrCTe.Conversao.pas' {$ENDIF};

  TCRTArrayStrings: array[TCRT] of string = ('', '1', '2', '3', '4');

  // Enumerados do TtpMotivo
const
  tmNaoEncontrado = {$IFDEF SUPPORTS_SCOPEDENUMS}TtpMotivo.{$ENDIF}tmNaoEncontrado deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TtpMotivo da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  tmRecusa = {$IFDEF SUPPORTS_SCOPEDENUMS}TtpMotivo.{$ENDIF}tmRecusa deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TtpMotivo da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  tmInexistente = {$IFDEF SUPPORTS_SCOPEDENUMS}TtpMotivo.{$ENDIF}tmInexistente deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TtpMotivo da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  tmOutro = {$IFDEF SUPPORTS_SCOPEDENUMS}TtpMotivo.{$ENDIF}tmOutro deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TtpMotivo da Unit ACBrCTe.Conversao.pas' {$ENDIF};

  TtpMotivoArrayStrings: array[TtpMotivo] of string = ('1', '2', '3', '4');

  // Enumerados do TtpPrest
const
  tpTotal = {$IFDEF SUPPORTS_SCOPEDENUMS}TtpPrest.{$ENDIF}tpTotal deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TtpPrest da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  tpParcial = {$IFDEF SUPPORTS_SCOPEDENUMS}TtpPrest.{$ENDIF}tpParcial deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TtpPrest da Unit ACBrCTe.Conversao.pas' {$ENDIF};

  TtpPrestArrayStrings: array[TtpPrest] of string = ('1', '2');

  // Enumerados do TclassDuto
const
  tcdNenhum = {$IFDEF SUPPORTS_SCOPEDENUMS}TclassDuto.{$ENDIF}tcdNenhum deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TclassDuto da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  tcdGasoduto = {$IFDEF SUPPORTS_SCOPEDENUMS}TclassDuto.{$ENDIF}tcdGasoduto deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TclassDuto da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  tcdMineroduto = {$IFDEF SUPPORTS_SCOPEDENUMS}TclassDuto.{$ENDIF}tcdMineroduto deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TclassDuto da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  tcdOleoduto = {$IFDEF SUPPORTS_SCOPEDENUMS}TclassDuto.{$ENDIF}tcdOleoduto deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TclassDuto da Unit ACBrCTe.Conversao.pas' {$ENDIF};

  TclassDutoArrayStrings: array[TclassDuto] of string = ('', '1', '2', '3');

  // Enumerados do TtpContratacao
const
  tcNenhum = {$IFDEF SUPPORTS_SCOPEDENUMS}TtpContratacao.{$ENDIF}tcNenhum deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TtpContratacao da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  tcPontaPonto = {$IFDEF SUPPORTS_SCOPEDENUMS}TtpContratacao.{$ENDIF}tcPontaPonto deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TtpContratacao da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  tcCapacidadeEntrada = {$IFDEF SUPPORTS_SCOPEDENUMS}TtpContratacao.{$ENDIF}tcCapacidadeEntrada deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TtpContratacao da Unit ACBrCTe.Conversao.pas' {$ENDIF};
  tcCapacidadeSaida = {$IFDEF SUPPORTS_SCOPEDENUMS}TtpContratacao.{$ENDIF}tcCapacidadeSaida deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o tipo TtpContratacao da Unit ACBrCTe.Conversao.pas' {$ENDIF};

  TtpContratacaoArrayStrings: array[TtpContratacao] of string = ('', '1', '2', '3');

{
  Declaração das funções de conversão
}
function ModeloNFToStr(const t: TpcteModeloNF): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método ModeloNFToStrEX da Unit ACBrCTe.Conversao.pas' {$ENDIF};
function StrToModeloNF(out ok: boolean; const s: string): TpcteModeloNF; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToModeloNFEX da Unit ACBrCTe.Conversao.pas' {$ENDIF};
function ModeloNFToStrEX(const t: TpcteModeloNF): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método ModeloNFToStrEX da Unit ACBrCTe.Conversao.pas' {$ENDIF};
function StrToModeloNFEX(const s: string): TpcteModeloNF; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToModeloNFEX da Unit ACBrCTe.Conversao.pas' {$ENDIF};

function StrToTpEventoCTe(out ok: boolean; const s: string): TACBrTipoEvento;

function LayOutToServico(const t: TLayOutCTe): String; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método LayOutToServico da Unit ACBrCTe.Conversao.pas' {$ENDIF};
function ServicoToLayOut(out ok: Boolean; const s: String): TLayOutCTe; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método ServicoToLayOut da Unit ACBrCTe.Conversao.pas' {$ENDIF};

function LayOutToSchema(const t: TLayOutCTe): TSchemaCTe; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método LayOutToSchema da Unit ACBrCTe.Conversao.pas' {$ENDIF};

function SchemaCTeToStr(const t: TSchemaCTe): String; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método SchemaCTeToStr da Unit ACBrCTe.Conversao.pas' {$ENDIF};
function StrToSchemaCTe(out ok: Boolean; const s: String): TSchemaCTe; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToSchemaCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};

function StrToVersaoCTe(out ok: Boolean; const s: String): TVersaoCTe; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToVersaoCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
function VersaoCTeToStr(const t: TVersaoCTe): String; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método VersaoCTeToStr da Unit ACBrCTe.Conversao.pas' {$ENDIF};

function DblToVersaoCTe(out ok: Boolean; const d: Double): TVersaoCTe; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método DblToVersaoCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
function VersaoCTeToDbl(const t: TVersaoCTe): Double; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método VersaoCTeToDbl da Unit ACBrCTe.Conversao.pas' {$ENDIF};

function tpforPagToStr(const t: TpcteFormaPagamento): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método tpforPagToStr da Unit ACBrCTe.Conversao.pas' {$ENDIF};
function tpforPagToStrText(const t: TpcteFormaPagamento): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método tpforPagToStrText da Unit ACBrCTe.Conversao.pas' {$ENDIF};
function StrTotpforPag(out ok: boolean; const s: string): TpcteFormaPagamento; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrTotpforPag da Unit ACBrCTe.Conversao.pas' {$ENDIF};

function tpCTeToStr(const t: TpcteTipoCTe): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método tpCTeToStr da Unit ACBrCTe.Conversao.pas' {$ENDIF};
function tpCTeToStrText(const t: TpcteTipoCTe): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método tpCTeToStrText da Unit ACBrCTe.Conversao.pas' {$ENDIF};
function StrTotpCTe(out ok: boolean; const s: string): TpcteTipoCTe; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrTotpCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};

function TpServPagToStr(const t: TpcteTipoServico): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método TpServPagToStr da Unit ACBrCTe.Conversao.pas' {$ENDIF};
function TpServToStrText(const t: TpcteTipoServico): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método TpServToStrText da Unit ACBrCTe.Conversao.pas' {$ENDIF};
function StrToTpServ(out ok: boolean; const s: string): TpcteTipoServico; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToTpServ da Unit ACBrCTe.Conversao.pas' {$ENDIF};

function TpRetiraPagToStr(const t: TpcteRetira): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método TpRetiraPagToStr da Unit ACBrCTe.Conversao.pas' {$ENDIF};
function StrToTpRetira(out ok: boolean; const s: string): TpcteRetira; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToTpRetira da Unit ACBrCTe.Conversao.pas' {$ENDIF};

function TpTomadorPagToStr(const t: TpcteTomador): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método TpTomadorPagToStr da Unit ACBrCTe.Conversao.pas' {$ENDIF};
function TpTomadorToStr(const t: TpcteTomador): String; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método TpTomadorToStr da Unit ACBrCTe.Conversao.pas' {$ENDIF};
function TpTomadorToStrText(const t: TpcteTomador): String; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método TpTomadorToStrText da Unit ACBrCTe.Conversao.pas' {$ENDIF};
function StrToTpTomador(out ok: boolean; const s: String ): TpcteTomador; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToTpTomador da Unit ACBrCTe.Conversao.pas' {$ENDIF};

function TpLotacaoToStr(const t: TpcteLotacao): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método TpLotacaoToStr da Unit ACBrCTe.Conversao.pas' {$ENDIF};
function StrToTpLotacao(out ok: boolean; const s: String ): TpcteLotacao; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToTpLotacao da Unit ACBrCTe.Conversao.pas' {$ENDIF};

function TpDirecaoToStr(const t: TpcteDirecao): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método TpDirecaoToStr da Unit ACBrCTe.Conversao.pas' {$ENDIF};
function StrToTpDirecao(out ok: boolean; const s: string): TpcteDirecao; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToTpDirecao da Unit ACBrCTe.Conversao.pas' {$ENDIF};

function TpTrafegoToStr(const t: TpcteTipoTrafego): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método TpTrafegoToStr da Unit ACBrCTe.Conversao.pas' {$ENDIF};
function StrToTpTrafego(out ok: boolean; const s: string): TpcteTipoTrafego; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToTpTrafego da Unit ACBrCTe.Conversao.pas' {$ENDIF};

function TpDataPeriodoToStr(const t: TpcteTipoDataPeriodo): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método TpDataPeriodoToStr da Unit ACBrCTe.Conversao.pas' {$ENDIF};
function StrToTpDataPeriodo(out ok: boolean; const s: string): TpcteTipoDataPeriodo; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToTpDataPeriodo da Unit ACBrCTe.Conversao.pas' {$ENDIF};

function TpHorarioIntervaloToStr(const t: TpcteTipoHorarioIntervalo): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método TpHorarioIntervaloToStr da Unit ACBrCTe.Conversao.pas' {$ENDIF};
function StrToTpHorarioIntervalo(out ok: boolean; const s: string): TpcteTipoHorarioIntervalo; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToTpHorarioIntervalo da Unit ACBrCTe.Conversao.pas' {$ENDIF};

function TpDocumentoToStr(const t: TpcteTipoDocumento): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método TpDocumentoToStr da Unit ACBrCTe.Conversao.pas' {$ENDIF};
function StrToTpDocumento(out ok: boolean; const s: string): TpcteTipoDocumento; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToTpDocumento da Unit ACBrCTe.Conversao.pas' {$ENDIF};

function TpDocumentoAnteriorToStr(const t: TpcteTipoDocumentoAnterior): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método TpDocumentoAnteriorToStr da Unit ACBrCTe.Conversao.pas' {$ENDIF};
function StrToTpDocumentoAnterior(out ok: boolean; const s: string): TpcteTipoDocumentoAnterior; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToTpDocumentoAnterior da Unit ACBrCTe.Conversao.pas' {$ENDIF};

function RspPagPedagioToStr(const t: TpcteRspPagPedagio): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método RspPagPedagioToStr da Unit ACBrCTe.Conversao.pas' {$ENDIF};
function StrToRspPagPedagio(out ok: boolean; const s: string): TpcteRspPagPedagio; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToRspPagPedagio da Unit ACBrCTe.Conversao.pas' {$ENDIF};

function TpDispositivoToStr(const t: TpcteTipoDispositivo): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método TpDispositivoToStr da Unit ACBrCTe.Conversao.pas' {$ENDIF};
function StrToTpDispositivo(out ok: boolean; const s: string): TpcteTipoDispositivo; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToTpDispositivo da Unit ACBrCTe.Conversao.pas' {$ENDIF};

function TpPropriedadeToStr(const t: TpcteTipoPropriedade): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método TpPropriedadeToStr da Unit ACBrCTe.Conversao.pas' {$ENDIF};
function StrToTpPropriedade(out ok: boolean; const s: string): TpcteTipoPropriedade; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToTpPropriedade da Unit ACBrCTe.Conversao.pas' {$ENDIF};

function TrafegoMutuoToStr(const t: TpcteTrafegoMutuo): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método TrafegoMutuoToStr da Unit ACBrCTe.Conversao.pas' {$ENDIF};
function StrToTrafegoMutuo(out ok: boolean; const s: string): TpcteTrafegoMutuo; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToTrafegoMutuo da Unit ACBrCTe.Conversao.pas' {$ENDIF};

function indNegociavelToStr(const t: TpcnindNegociavel ): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método indNegociavelToStr da Unit ACBrCTe.Conversao.pas' {$ENDIF};
function StrToindNegociavel(out ok: boolean; const s: string): TpcnindNegociavel; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToindNegociavel da Unit ACBrCTe.Conversao.pas' {$ENDIF};

function TpVeiculoToStr(const t: TpcteTipoVeiculo): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método TpVeiculoToStr da Unit ACBrCTe.Conversao.pas' {$ENDIF};
function StrToTpVeiculo(out ok: boolean; const s: string): TpcteTipoVeiculo; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToTpVeiculo da Unit ACBrCTe.Conversao.pas' {$ENDIF};

function GetVersaoModalCTe(AVersaoDF: TVersaoCTe; AModal: TModal): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método GetVersaoModalCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};

function ModeloCTeToStr(const t: TModeloCTe): String; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método ModeloCTeToStr da Unit ACBrCTe.Conversao.pas' {$ENDIF};
function StrToModeloCTe(out ok: Boolean; const s: String): TModeloCTe; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToModeloCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};
function ModeloCTeToPrefixo(const t: TModeloCTe): String; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método ModeloCTeToPrefixo da Unit ACBrCTe.Conversao.pas' {$ENDIF};

function TEspecieToStr(const t: TEspecie): String; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método TEspecieToStr da Unit ACBrCTe.Conversao.pas' {$ENDIF};
function StrToTEspecie(out ok: Boolean; const s: String): TEspecie; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToTEspecie da Unit ACBrCTe.Conversao.pas' {$ENDIF};

function TpRspSeguroToStr(const t: TpcteRspSeg): String; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método TpRspSeguroToStr da Unit ACBrCTe.Conversao.pas' {$ENDIF};
function TpRspSeguroToStrText(const t: TpcteRspSeg): String; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método TpRspSeguroToStrText da Unit ACBrCTe.Conversao.pas' {$ENDIF};
function StrToTpRspSeguro(out ok: boolean; const s: String ): TpcteRspSeg; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToTpRspSeguro da Unit ACBrCTe.Conversao.pas' {$ENDIF};

function TpInfManuToStr(const t: TpInfManu): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método TpInfManuToStr da Unit ACBrCTe.Conversao.pas' {$ENDIF};
function StrToTpInfManu(out ok: boolean; const s: string): TpInfManu; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToTpInfManu da Unit ACBrCTe.Conversao.pas' {$ENDIF};

function TpInfManuToStrV2(const t: TpInfManu): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método TpInfManuToStrV2 da Unit ACBrCTe.Conversao.pas' {$ENDIF};
function StrToTpInfManuV2(out ok: boolean; const s: string): TpInfManu; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToTpInfManuV2 da Unit ACBrCTe.Conversao.pas' {$ENDIF};

function UniMedToStr(const t: TpUniMed): String; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método UniMedToStr da Unit ACBrCTe.Conversao.pas' {$ENDIF};
function StrToUniMed(out ok: Boolean; const s: String): TpUniMed; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToUniMed da Unit ACBrCTe.Conversao.pas' {$ENDIF};

function TpFretamentoToStr(const t: TtpFretamento): String; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método TpFretamentoToStr da Unit ACBrCTe.Conversao.pas' {$ENDIF};
function StrToTpFretamento(out ok: Boolean; const s: String): TtpFretamento; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToTpFretamento da Unit ACBrCTe.Conversao.pas' {$ENDIF};

function tpCompToStr(const t: TtpComp): String; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método tpCompToStr da Unit ACBrCTe.Conversao.pas' {$ENDIF};
function StrTotpComp(out ok: Boolean; const s: String): TtpComp; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrTotpComp da Unit ACBrCTe.Conversao.pas' {$ENDIF};

function tpNumerarioToStr(const t: TtpNumerario): String; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método tpNumerarioToStr da Unit ACBrCTe.Conversao.pas' {$ENDIF};
function StrTotpNumerario(out ok: Boolean; const s: String): TtpNumerario; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrTotpNumerario da Unit ACBrCTe.Conversao.pas' {$ENDIF};

function CRTCTeToStr(const t: TCRT): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método CRTCTeToStr da Unit ACBrCTe.Conversao.pas' {$ENDIF};
function StrToCRTCTe(out ok: boolean; const s: string): TCRT; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToCRTCTe da Unit ACBrCTe.Conversao.pas' {$ENDIF};

function tpMotivoToStr(const t: TtpMotivo): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método tpMotivoToStr da Unit ACBrCTe.Conversao.pas' {$ENDIF};
function StrTotpMotivo(out ok: boolean; const s: string): TtpMotivo; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrTotpMotivo da Unit ACBrCTe.Conversao.pas' {$ENDIF};
function tpMotivoToDesc(const t: TtpMotivo): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método tpMotivoToDesc da Unit ACBrCTe.Conversao.pas' {$ENDIF};

function tpPrestToStr(const t: TtpPrest): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método tpPrestToStr da Unit ACBrCTe.Conversao.pas' {$ENDIF};
function StrTotpPrest(out ok: boolean; const s: string): TtpPrest; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrTotpPrest da Unit ACBrCTe.Conversao.pas' {$ENDIF};

function classDutoToStr(const t: TclassDuto): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método classDutoToStr da Unit ACBrCTe.Conversao.pas' {$ENDIF};
function StrToclassDuto(out ok: boolean; const s: string): TclassDuto; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrToclassDuto da Unit ACBrCTe.Conversao.pas' {$ENDIF};

function tpContratacaoToStr(const t: TtpContratacao): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método tpContratacaoToStr da Unit ACBrCTe.Conversao.pas' {$ENDIF};
function StrTotpContratacao(out ok: boolean; const s: string): TtpContratacao; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Use o método StrTotpContratacao da Unit ACBrCTe.Conversao.pas' {$ENDIF};

implementation

uses
  typinfo;

function ModeloNFToStr(const t: TpcteModeloNF): string;
begin
  result := EnumeradoToStr(t, ['01','04'],
   [moNF011AAvulsa, moNFProdutor]);
end;

function StrToModeloNF(out ok: boolean; const s: string): TpcteModeloNF;
begin
  result := StrToEnumerado(ok, s, ['01','04'],
   [moNF011AAvulsa, moNFProdutor]);
end;

function ModeloNFToStrEX(const t: TpcteModeloNF): string;
begin
  Result := TpcteModeloNFArrayStrings[t];
end;

function StrToModeloNFEX(const s: string): TpcteModeloNF;
var
  idx: TpcteModeloNF;
begin
  for idx:= Low(TpcteModeloNFArrayStrings) to High(TpcteModeloNFArrayStrings)do
  begin
    if(TpcteModeloNFArrayStrings[idx] = s)then
    begin
      Result := idx;
      Exit;
    end;
  end;
  raise EACBrException.CreateFmt('Valor string inválido para TpcteModeloNF: %s', [s]);
end;

function StrToTpEventoCTe(out ok: boolean; const s: string): TACBrTipoEvento;
begin
  Result := StrToEnumerado(ok, s,
            ['-99999', '110110', '110111', '110113', '110160', '110170',
             '110180', '110181', '610110', '310610', '310611', '610111',
             '110190', '110191', '510630', '110300', '110301'],
            [teNaoMapeado, teCCe, teCancelamento, teEPEC, teMultiModal,
             teGTV, teComprEntrega, teCancComprEntrega, tePrestDesacordo,
             teMDFeAutorizado2, teMDFeCancelado2, teCancPrestDesacordo,
             teInsucessoEntregaCTe, teCancInsucessoEntregaCTe, teRegistroPassagemMDFe,
             teVinculoPgto, teCancVinculoPgto]);
end;

function LayOutToServico(const t: TLayOutCTe): String;
begin
  Result := EnumeradoToStr(t,
    ['CTeRecepcao', 'CTeRetRecepcao', 'CTeCancelamento',
     'CTeInutilizacao', 'CTeConsultaProtocolo', 'CTeStatusServico',
     'CTeConsultaCadastro', 'RecepcaoEvento', 'RecepcaoEventoAN',
     'CTeDistribuicaoDFe', 'CTeRecepcaoOS', 'CTeRecepcaoSinc',
      'CTeRecepcaoGTVe', 'CTeRecepcaoSimp'],
    [ LayCTeRecepcao, LayCTeRetRecepcao, LayCTeCancelamento,
      LayCTeInutilizacao, LayCTeConsulta, LayCTeStatusServico,
      LayCTeCadastro, LayCTeEvento, LayCTeEventoAN,
      LayCTeDistDFeInt, LayCTeRecepcaoOS, LayCTeRecepcaoSinc,
      LayCTeRecepcaoGTVe, LayCTeRecepcaoSimp]);
end;

function ServicoToLayOut(out ok: Boolean; const s: String): TLayOutCTe;
begin
  Result := StrToEnumerado(ok, s,
    ['CTeRecepcao', 'CTeRetRecepcao', 'CTeCancelamento',
     'CTeInutilizacao', 'CTeConsultaProtocolo', 'CTeStatusServico',
     'CTeConsultaCadastro', 'RecepcaoEvento', 'RecepcaoEventoAN',
     'CTeDistribuicaoDFe', 'CTeRecepcaoOS', 'CTeRecepcaoSinc',
     'CTeRecepcaoGTVe', 'CTeRecepcaoSimp'],
    [ LayCTeRecepcao, LayCTeRetRecepcao, LayCTeCancelamento,
      LayCTeInutilizacao, LayCTeConsulta, LayCTeStatusServico,
      LayCTeCadastro, LayCTeEvento, LayCTeEventoAN,
      LayCTeDistDFeInt, LayCTeRecepcaoOS, LayCTeRecepcaoSinc,
      LayCTeRecepcaoGTVe, LayCTeRecepcaoSimp]);
end;

function LayOutToSchema(const t: TLayOutCTe): TSchemaCTe;
begin
  case t of
    LayCTeRecepcao,
    LayCTeRecepcaoSinc:  Result := schCTe;
    LayCTeRecepcaoOS:    Result := schCTeOS;

    LayCTeRecepcaoGTVe:  Result := schGTVe;
    LayCTeRecepcaoSimp:  Result := schCTeSimp;

    LayCTeRetRecepcao:   Result := schconsReciCTe;
    LayCTeCancelamento:  Result := schcancCTe;
    LayCTeInutilizacao:  Result := schInutCTe;
    LayCTeConsulta:      Result := schconsSitCTe;
    LayCTeStatusServico: Result := schconsStatServCTe;
    LayCTeCadastro:      Result := schconsCad;
    LayCTeEvento,
    LayCTeEventoAN:      Result := schEventoCTe;
    LayCTeDistDFeInt:    Result := schdistDFeInt;
  else
    Result := schErro;
  end;
end;

function SchemaCTeToStr(const t: TSchemaCTe): String;
begin
  Result := GetEnumName(TypeInfo(TSchemaCTe), Integer( t ) );
  Result := copy(Result, 4, Length(Result)); // Remove prefixo "sch"
end;

function StrToSchemaCTe(out ok: Boolean; const s: String): TSchemaCTe;
var
  P: Integer;
  SchemaStr: String;
begin
  ok := True;

  P := pos('_', s);
  if P > 0 then
    SchemaStr := copy(s, 1, P-1)
  else
    SchemaStr := s;

  if LeftStr(SchemaStr, 3) <> 'sch' then
    SchemaStr := 'sch' + SchemaStr;

  Result := TSchemaCTe( GetEnumValue(TypeInfo(TSchemaCTe), SchemaStr ) );
end;

function StrToVersaoCTe(out ok: Boolean; const s: String): TVersaoCTe;
begin
  Result := StrToEnumerado(ok, s, ['2.00', '3.00', '4.00'],
                                  [ve200, ve300, ve400]);
end;

function VersaoCTeToStr(const t: TVersaoCTe): String;
begin
  Result := EnumeradoToStr(t, ['2.00', '3.00', '4.00'], [ve200, ve300, ve400]);
end;

function DblToVersaoCTe(out ok: Boolean; const d: Double): TVersaoCTe;
begin
  ok := True;

  if d = 2 then
    Result := ve200
  else
  if d = 3 then
    Result := ve300
  else
  if d = 4 then
    Result := ve400
  else
  begin
    Result := ve200;
    ok := False;
  end;
end;

function VersaoCTeToDbl(const t: TVersaoCTe): Double;
begin
  case t of
    ve200: Result := 2.0;
    ve300: Result := 3.0;
    ve400: Result := 4.0;
  else
    Result := 0;
  end;
end;

function tpCTeToStr(const t: TpcteTipoCTe): string;
begin
  result := EnumeradoToStr(t, ['0', '1', '2', '3', '4', '5', '6'],
                   [tcNormal, tcComplemento, tcAnulacao, tcSubstituto, tcGTVe,
                    tcCTeSimp, tcSubstCTeSimpl]);
end;

function tpCTeToStrText(const t: TpcteTipoCTe): string;
begin
  result := EnumeradoToStr(t, ['NORMAL', 'COMPLEMENTO', 'ANULAÇÃO', 'SUBSTITUTO',
                               'GTVe', 'CTe Simplificado',
                               'CTe Simplificado Substituto'],
                   [tcNormal, tcComplemento, tcAnulacao, tcSubstituto, tcGTVe,
                    tcCTeSimp, tcSubstCTeSimpl]);
end;

function StrTotpCTe(out ok: boolean; const s: string): TpcteTipoCTe;
begin
  result := StrToEnumerado(ok, s, ['0', '1', '2', '3', '4', '5', '6'],
                   [tcNormal, tcComplemento, tcAnulacao, tcSubstituto, tcGTVe,
                    tcCTeSimp, tcSubstCTeSimpl]);
end;

function tpforPagToStr(const t: TpcteFormaPagamento): string;
begin
  result := EnumeradoToStr(t, ['0','1', '2'],
                              [fpPago, fpAPagar, fpOutros]);
end;

function tpforPagToStrText(const t: TpcteFormaPagamento): string;
begin
  result := EnumeradoToStr(t, ['PAGO','A PAGAR', 'OUTROS'],
                              [fpPago, fpAPagar, fpOutros]);
end;

function StrTotpforPag(out ok: boolean; const s: string): TpcteFormaPagamento;
begin
  result := StrToEnumerado(ok, s, ['0', '1', '2'],
                                  [fpPago, fpAPagar, fpOutros]);
end;

function TpServPagToStr(const t: TpcteTipoServico): string;
begin
  result := EnumeradoToStr(t, ['0','1', '2', '3', '4', '6', '7', '8', '9'],
                              [tsNormal, tsSubcontratacao, tsRedespacho,
                               tsIntermediario, tsMultimodal, tsTranspPessoas,
                               tsTranspValores, tsExcessoBagagem, tsGTV]);
end;

function TpServToStrText(const t: TpcteTipoServico): string;
begin
  result := EnumeradoToStr(t, ['NORMAL','SUBCONTRATAÇÃO', 'REDESPACHO',
                               'REDESP. INTERMEDIÁRIO', 'VINC. A MULTIMODAL',
                               'TRANSP. PESSOAS', 'TRANSP. VALORES',
                               'EXCESSO BAGAGEM', 'GTV'],
                              [tsNormal, tsSubcontratacao, tsRedespacho,
                               tsIntermediario, tsMultimodal,
                               tsTranspPessoas, tsTranspValores,
                               tsExcessoBagagem, tsGTV]);
end;

function StrToTpServ(out ok: boolean; const s: string): TpcteTipoServico;
begin
  result := StrToEnumerado(ok, s, ['0', '1', '2', '3', '4', '6', '7', '8', '9'],
                                  [tsNormal, tsSubcontratacao, tsRedespacho,
                                   tsIntermediario, tsMultimodal,
                                   tsTranspPessoas, tsTranspValores,
                                   tsExcessoBagagem, tsGTV]);
end;

function TpRetiraPagToStr(const t: TpcteRetira): string;
begin
  result := EnumeradoToStr(t, ['0','1'], [rtSim, rtNao]);
end;

function StrToTpRetira(out ok: boolean; const s: string): TpcteRetira;
begin
  result := StrToEnumerado(ok, s, ['0', '1'], [rtSim, rtNao]);
end;

function TpTomadorPagToStr(const t: TpcteTomador): string;
begin
  result := EnumeradoToStr(t, ['0','1', '2', '3', '4'],
             [tmRemetente, tmExpedidor, tmRecebedor, tmDestinatario, tmOutros]);
end;

function TpTomadorToStr(const t: TpcteTomador): String;
begin
  result := EnumeradoToStr(t, ['0', '1', '2', '3', '4'],
             [tmRemetente, tmExpedidor, tmRecebedor, tmDestinatario, tmOutros]);
end;

function TpTomadorToStrText(const t: TpcteTomador): String;
begin
  result := EnumeradoToStr(t, ['REMETENTE', 'EXPEDIDOR', 'RECEBEDOR',
                               'DESTINATARIO', 'OUTROS'],
             [tmRemetente, tmExpedidor, tmRecebedor, tmDestinatario, tmOutros]);
end;

function TpLotacaoToStr(const t: TpcteLotacao): string;
begin
  result := EnumeradoToStr(t, ['0','1'], [ltNao, ltSim]);
end;

function StrToTpTomador(out ok: boolean; const s: String ): TpcteTomador;
begin
  result := StrToEnumerado(ok, s, ['0', '1', '2', '3', '4'],
             [tmRemetente, tmExpedidor, tmRecebedor, tmDestinatario, tmOutros]);
end;

function StrToTpLotacao(out ok: boolean; const s: String ): TpcteLotacao;
begin
  result := StrToEnumerado(ok, s, ['0', '1'], [ltNao, ltSim]);
end;

function TpDirecaoToStr(const t: TpcteDirecao): string;
begin
  result := EnumeradoToStr(t, ['N','L','S','O'],
                              [drNorte , drLeste, drSul, drOeste]);
end;

function StrToTpDirecao(out ok: boolean; const s: string): TpcteDirecao;
begin
  result := StrToEnumerado(ok, s, ['N','L','S','O'],
                                  [drNorte , drLeste, drSul, drOeste]);
end;

function TpTrafegoToStr(const t: TpcteTipoTrafego): string;
begin
  result := EnumeradoToStr(t, ['0','1','2','3'],
                        [ttProprio , ttMutuo, ttRodoferroviario, ttRodoviario]);
end;

function StrToTpTrafego(out ok: boolean; const s: string): TpcteTipoTrafego;
begin
  result := StrToEnumerado(ok, s, ['0','1','2','3'],
                        [ttProprio , ttMutuo, ttRodoferroviario, ttRodoviario]);
end;

function TpDataPeriodoToStr(const t: TpcteTipoDataPeriodo): string;
begin
  result := EnumeradoToStr(t, ['0','1','2','3','4','-1'],
                              [tdSemData, tdNaData, tdAteData, tdApartirData,
                               tdNoPeriodo, tdNaoInformado]);
end;

function StrToTpDataPeriodo(out ok: boolean; const s: string): TpcteTipoDataPeriodo;
begin
  result := StrToEnumerado(ok, s, ['0','1','2','3','4','-1'],
                                  [tdSemData, tdNaData, tdAteData, tdApartirData,
                                   tdNoPeriodo, tdNaoInformado]);
end;

function TpHorarioIntervaloToStr(const t: TpcteTipoHorarioIntervalo): string;
begin
  result := EnumeradoToStr(t, ['0','1','2','3','4','-1'],
                              [thSemHorario, thNoHorario, thAteHorario,
                               thApartirHorario, thNoIntervalo, thNaoInformado]);
end;

function StrToTpHorarioIntervalo(out ok: boolean; const s: string): TpcteTipoHorarioIntervalo;
begin
  result := StrToEnumerado(ok, s, ['0','1','2','3','4','-1'],
                                  [thSemHorario, thNoHorario, thAteHorario,
                                   thApartirHorario, thNoIntervalo, thNaoInformado]);
end;

function TpDocumentoToStr(const t: TpcteTipoDocumento): string;
begin
  result := EnumeradoToStr(t, ['00', '10', '59', '65', '99'],
                              [tdDeclaracao, tdDutoviario, tdCFeSAT, tdNFCe, tdOutros]);
end;

function StrToTpDocumento(out ok: boolean; const s: string): TpcteTipoDocumento;
begin
  result := StrToEnumerado(ok, s, ['00', '10', '59', '65', '99'],
                                  [tdDeclaracao, tdDutoviario, tdCFeSAT, tdNFCe, tdOutros]);
end;

function TpDocumentoAnteriorToStr(const t: TpcteTipoDocumentoAnterior): string;
begin
  result := EnumeradoToStr(t, ['00', '01', '02', '03', '04', '05', '06', '07',
                               '08', '09', '10', '11', '12', '13', '99'],
                         [daCTRC, daCTAC, daACT, daNF7, daNF27, daCAN, daCTMC,
                          daATRE, daDTA, daCAI, daCCPI, daCA, daTIF, daBL, daOutros]);
end;

function StrToTpDocumentoAnterior(out ok: boolean; const s: string): TpcteTipoDocumentoAnterior;
begin
  result := StrToEnumerado(ok, s, ['00', '01', '02', '03', '04', '05', '06', '07',
                                   '08', '09', '10', '11', '12', '13', '99'],
                         [daCTRC, daCTAC, daACT, daNF7, daNF27, daCAN, daCTMC,
                          daATRE, daDTA, daCAI, daCCPI, daCA, daTIF, daBL, daOutros]);
end;

function RspPagPedagioToStr(const t: TpcteRspPagPedagio): string;
begin
  result := EnumeradoToStr(t, ['0','1','2','3','4','5'],
                             [rpEmitente, rpRemetente, rpExpedidor, rpRecebedor,
                              rpDestinatario, rpTomadorServico]);
end;

function StrToRspPagPedagio(out ok: boolean; const s: string): TpcteRspPagPedagio;
begin
  result := StrToEnumerado(ok, s, ['0','1','2','3','4','5'],
                             [rpEmitente, rpRemetente, rpExpedidor, rpRecebedor,
                              rpDestinatario, rpTomadorServico]);
end;

function TpDispositivoToStr(const t: TpcteTipoDispositivo): string;
begin
  result := EnumeradoToStr(t, ['1','2','3'], [tdCartaoMagnetico, tdTAG, tdTicket]);
end;

function StrToTpDispositivo(out ok: boolean; const s: string): TpcteTipoDispositivo;
begin
  result := StrToEnumerado(ok, s, ['1','2','3'], [tdCartaoMagnetico, tdTAG, tdTicket]);
end;

function TpPropriedadeToStr(const t: TpcteTipoPropriedade): string;
begin
  result := EnumeradoToStr(t, ['P','T'], [tpProprio, tpTerceiro]);
end;

function StrToTpPropriedade(out ok: boolean; const s: string): TpcteTipoPropriedade;
begin
  result := StrToEnumerado(ok, s, ['P','T'], [tpProprio, tpTerceiro]);
end;

function TrafegoMutuoToStr(const t: TpcteTrafegoMutuo): string;
begin
  result := EnumeradoToStr(t, ['1','2'],
   [tmOrigem, tmDestino]);
end;

function StrToTrafegoMutuo(out ok: boolean; const s: string): TpcteTrafegoMutuo;
begin
  result := StrToEnumerado(ok, s, ['1','2'],
   [tmOrigem, tmDestino]);
end;

function indNegociavelToStr(const t: TpcnindNegociavel ): string;
begin
  result := EnumeradoToStr(t, ['0', '1'], [inNaoNegociavel, inNegociavel]);
end;

function StrToindNegociavel(out ok: boolean; const s: string): TpcnindNegociavel;
begin
  result := StrToEnumerado(ok, s, ['0', '1'], [inNaoNegociavel, inNegociavel]);
end;

function TpVeiculoToStr(const t: TpcteTipoVeiculo): string;
begin
  result := EnumeradoToStr(t, ['0','1'], [tvTracao, tvReboque]);
end;

function StrToTpVeiculo(out ok: boolean; const s: string): TpcteTipoVeiculo;
begin
  result := StrToEnumerado(ok, s, ['0','1'], [tvTracao, tvReboque]);
end;

function GetVersaoModalCTe(AVersaoDF: TVersaoCTe; AModal: TModal): string;
begin
  result := '';

  case AModal of
    mdRodoviario,
    mdAereo,
    mdAquaviario,
    mdFerroviario,
    mdDutoviario,
    mdMultimodal:
      case AVersaoDF of
        ve300: Result := '3.00';
        ve400: Result := '4.00';
      else
        Result := '2.00';
      end;
  end;
end;

function ModeloCTeToStr(const t: TModeloCTe): String;
begin
  Result := EnumeradoToStr(t, ['57', '64', '67', '57'],
                              [moCTe, moGTVe, moCTeOS, moCTeSimp]);
end;

function StrToModeloCTe(out ok: Boolean; const s: String): TModeloCTe;
begin
  Result := StrToEnumerado(ok, s, ['57', '64', '67'],
                                  [moCTe, moGTVe, moCTeOS]);
end;

function ModeloCTeToPrefixo(const t: TModeloCTe): String;
begin
  Case t of
    moCTeOS: Result := 'CTeOS';
    moGTVe: Result := 'GTVe';
    moCTeSimp: Result := 'CTeSimp';
  else
    Result := 'CTe';
  end;
end;

function TEspecieToStr(const t: TEspecie): String;
begin
  Result := EnumeradoToStr(t, ['1', '2', '3', '4'],
                              [teNumerario, teCheque, teMoeda, teOutros]);
end;

function StrToTEspecie(out ok: Boolean; const s: String): TEspecie;
begin
  Result := StrToEnumerado(ok, s, ['1', '2', '3', '4'],
                                  [teNumerario, teCheque, teMoeda, teOutros]);
end;

function TpRspSeguroToStr(const t: TpcteRspSeg): String;
begin
  result := EnumeradoToStr(t, ['0', '1', '2', '3', '4', '5'],
                         [rsRemetente, rsExpedidor, rsRecebedor, rsDestinatario,
                          rsEmitenteCTe, rsTomadorServico]);
end;

function TpRspSeguroToStrText(const t: TpcteRspSeg): String;
begin
  result := EnumeradoToStr(t, ['REMETENTE', 'EXPEDIDOR', 'RECEBEDOR',
                               'DESTINATARIO', 'EMITENTE', 'TOMADOR SERVICO'],
                         [rsRemetente, rsExpedidor, rsRecebedor, rsDestinatario,
                          rsEmitenteCTe, rsTomadorServico]);
end;

function StrToTpRspSeguro(out ok: boolean; const s: String ): TpcteRspSeg;
begin
  result := StrToEnumerado(ok, s, ['0', '1', '2', '3', '4', '5'],
                         [rsRemetente, rsExpedidor, rsRecebedor, rsDestinatario,
                          rsEmitenteCTe, rsTomadorServico]);
end;

function TpInfManuToStr(const t: TpInfManu): string;
begin
  result := EnumeradoToStr(t, ['01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','99'],
                              [imCEEAV, imAPCDEA, imSAC,   imAPDENR, imAPQI,  imGSR,   imNR,    imAPCC,
                               imAAGA,  imPI965,  imPI966, imPI967,  imPI968, imPI969, imPI970, imOUTRO]);
end;

function StrToTpInfManu(out ok: boolean; const s: string): TpInfManu;
begin
  result := StrToEnumerado(ok, s, ['01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','99'],
                                  [imCEEAV, imAPCDEA, imSAC,   imAPDENR, imAPQI,  imGSR,   imNR,    imAPCC,
                                   imAAGA,  imPI965,  imPI966, imPI967,  imPI968, imPI969, imPI970, imOUTRO]);
end;

function TpInfManuToStrV2(const t: TpInfManu): string;
begin
  result := EnumeradoToStr(t, ['1','2','3','4','5','6','7','8','9','99'],
                              [imCEEAV, imAPCDEA, imSAC, imAPDENR, imAPQI,
                               imGSR, imNR, imAPCC, imAAGA, imOUTRO]);
end;

function StrToTpInfManuV2(out ok: boolean; const s: string): TpInfManu;
begin
  result := StrToEnumerado(ok, s, ['1','2','3','4','5','6','7','8','9','99'],
                                  [imCEEAV, imAPCDEA, imSAC, imAPDENR, imAPQI,
                                   imGSR, imNR, imAPCC, imAAGA, imOUTRO]);
end;

function UniMedToStr(const t: TpUniMed): String;
begin
  result := EnumeradoToStr(t, ['1','2','3','4','5'],
                              [umKG, umKGG, umLitros, umTI, umUnidades]);
end;

function StrToUniMed(out ok: Boolean; const s: String): TpUniMed;
begin
  result := StrToEnumerado(ok, s, ['1','2','3','4','5'],
                                  [umKG, umKGG, umLitros, umTI, umUnidades]);
end;

function TpFretamentoToStr(const t: TtpFretamento): String;
begin
  result := EnumeradoToStr(t, ['', '1', '2'],
                              [tfNenhum, tfEventual, tpContinuo]);
end;

function StrToTpFretamento(out ok: Boolean; const s: String): TtpFretamento;
begin
  result := StrToEnumerado(ok, s, ['', '1', '2'],
                                  [tfNenhum, tfEventual, tpContinuo]);
end;

function tpCompToStr(const t: TtpComp): String;
begin
  result := EnumeradoToStr(t, ['1', '2', '3', '4', '5', '6'],
                              [tcCustodia, tcEmbarque, tcTempodeespera, tcMalote,
                               tcAdValorem, tcOutros]);
end;

function StrTotpComp(out ok: Boolean; const s: String): TtpComp;
begin
  result := StrToEnumerado(ok, s, ['1', '2', '3', '4', '5', '6'],
                              [tcCustodia, tcEmbarque, tcTempodeespera, tcMalote,
                               tcAdValorem, tcOutros]);
end;

function tpNumerarioToStr(const t: TtpNumerario): String;
begin
  result := EnumeradoToStr(t, ['1', '2'],
                              [tnNacional, tnEstrangeiro]);
end;

function StrTotpNumerario(out ok: Boolean; const s: String): TtpNumerario;
begin
  result := StrToEnumerado(ok, s, ['1', '2'],
                              [tnNacional, tnEstrangeiro]);
end;

function CRTCTeToStr(const t: TCRT): string;
begin
  result := EnumeradoToStr(t, ['', '1', '2', '3', '4'],
    [crtNenhum, crtSimplesNacional, crtSimplesExcessoReceita, crtRegimeNormal,
     crtSimplesNacionalMEI]);
end;

function StrToCRTCTe(out ok: boolean; const s: string): TCRT;
begin
  result := StrToEnumerado(ok, s, ['', '1', '2', '3', '4'],
    [crtNenhum, crtSimplesNacional, crtSimplesExcessoReceita, crtRegimeNormal,
     crtSimplesNacionalMEI]);
end;

function tpMotivoToStr(const t: TtpMotivo): string;
begin
  result := EnumeradoToStr(t, ['1', '2', '3', '4'],
    [tmNaoEncontrado, tmRecusa, tmInexistente, tmOutro]);
end;

function StrTotpMotivo(out ok: boolean; const s: string): TtpMotivo;
begin
  result := StrToEnumerado(ok, s, ['1', '2', '3', '4'],
    [tmNaoEncontrado, tmRecusa, tmInexistente, tmOutro]);
end;

function tpMotivoToDesc(const t: TtpMotivo): string;
begin
  result := EnumeradoToStr(t, ['Não Encontrado', 'Recusa', 'Inexistente', 'Outro'],
    [tmNaoEncontrado, tmRecusa, tmInexistente, tmOutro]);
end;

function tpPrestToStr(const t: TtpPrest): string;
begin
  result := EnumeradoToStr(t, ['1', '2'],
    [tpTotal, tpParcial]);
end;

function StrTotpPrest(out ok: boolean; const s: string): TtpPrest;
begin
  result := StrToEnumerado(ok, s, ['1', '2'],
    [tpTotal, tpParcial]);
end;

function classDutoToStr(const t: TclassDuto): string;
begin
  Result := TclassDutoArrayStrings[t];
end;

function StrToclassDuto(out ok: boolean; const s: string): TclassDuto;
var
  idx: TclassDuto;
begin
  for idx:= Low(TclassDutoArrayStrings) to High(TclassDutoArrayStrings) do
  begin
    if(TclassDutoArrayStrings[idx] = s)then
    begin
      Result := idx;
      exit;
    end;
  end;
  raise EACBrException.CreateFmt('Valor string inválido para TclassDuto: %s', [s]);
end;

function tpContratacaoToStr(const t: TtpContratacao): string;
begin
  Result := TtpContratacaoArrayStrings[t];
end;

function StrTotpContratacao(out ok: boolean; const s: string): TtpContratacao;
var
  idx: TtpContratacao;
begin
  for idx:= Low(TtpContratacaoArrayStrings) to High(TtpContratacaoArrayStrings) do
  begin
    if(TtpContratacaoArrayStrings[idx] = s)then
    begin
      Result := idx;
      exit;
    end;
  end;
  raise EACBrException.CreateFmt('Valor string inválido para TtpContratacao: %s', [s]);
end;

initialization
  //RegisterStrToTpEventoDFe(StrToTpEventoCTe, 'CTe');
  ACBrDFe.Conversao.RegisterStrToTpEventoDFe(StrToTpEventoCTe, 'CTe');

end.
