{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Renato Rubinho                                  }
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

unit ACBrDeRE.Conversao;

interface

uses
  SysUtils, StrUtils, Classes,
  ACBrDFe.Conversao;

type
  TStatusDeRE = (stDeREIdle, stDeREToken, stDeRERecepcao, stDeREConsulta, stDeRELimpeza);

  // Momento da transmissao informado no evento OnTransmissaoEventos
  TEventosDeRE = (edEnvioLote, edRetornoLote, edEnvioConsulta, edRetornoConsulta);

  // Servicos (REST) da DeRE
  TLayOutDeRE = (LayDeREObterToken, LayDeRERecepcaoLote, LayDeREConsultaLote,
    LayDeRELimpeza);

type
  // Versao do leiaute da DeRE (versao dos schemas dos eventos). Cada versao agrupa o
  //  conjunto de XSD aceito por um ambiente do SERPRO:
  //  ve102 - Nota Orientativa 2026-001 (evtPGCC v1_0_2, evtBalancete v1_0_0)
  //  ve103 - PRODUCAO (evtPGCC v1_0_3; sem evtBalancete e evtAplicResTec)
  //  ve104 - PRODUCAO RESTRITA / Empresas Piloto de 03/11/2026 (evtPGCC v1_0_4,
  //          evtBalancete v1_0_1, evtAplicResTec v1_0_0). Eventos do pacote v1.3.0
  //          (ainda inativo nos ambientes) so estao disponiveis nesta versao.
  TVersaoDeRE = (ve102, ve103, ve104);

const
  // Versao padrao do leiaute (a mais recente)
  VERSAO_DERE_PADRAO = ve104;

const
  TVersaoDeREArrayStrings: array[TVersaoDeRE] of string = ('1.0.2', '1.0.3', '1.0.4');
  TVersaoDeREArrayDouble: array[TVersaoDeRE] of Double = (1.02, 1.03, 1.04);

type
  TSchemaDeRE = (schErroDeRE, schevtInfoContrib, schevtPGCC, schevtBalancete,
                 schevtAplicResTec, schevtRelDeducoes,
                 schevtReabertMensal,
                 schevtFechMensal,
                 schevtDebOpOfPublic,
                 schevtInfoCotistas,
                 schevtServRemPreco,
                 schevtServRemTarifa,
                 schevtOperFinanc,
                 schevtAntecReceb,
                 schevtArrendMerc,
                 schevtArranjoCredDest,
                 schevtArranjoPartic,
                 schevtSegPrevCap,
                 schevtSegElemSCob,
                 schevtPlAssistSaude,
                 schevtIdApostPrem,
                 schenvioLoteDere, schretornoLoteDere, schevtRetornoTabela);

type
  TTipoEventoDeRE = (
    teInfoContrib, tePGCC, teBalancete, teAplicResTec, teRelDeducoes,
    teReabertMensal, teFechMensal, teDebOpOfPublic, teInfoCotistas, teServRemPreco, teServRemTarifa,
    teOperFinanc, teAntecReceb, teArrendMerc, teArranjoCredDest, teArranjoPartic, teSegPrevCap,
    teSegElemSCob, tePlAssistSaude, teIdApostPrem);

  // Conjunto de tipos de evento (ex.: eventos marcados para gerar)
  TTiposEventoDeRE = set of TTipoEventoDeRE;

const
  TTipoEventoDeREArrayStrings: array[TTipoEventoDeRE] of string = (
    'D-1001', 'D-1011', 'D-1101',
    'D-1106', 'D-1121', 'D-1198', 'D-1199', 'D-2101', 'D-2102', 'D-2201', 'D-2202', 'D-2211',
    'D-2221', 'D-2231', 'D-2241', 'D-2242', 'D-2251', 'D-2252', 'D-3201', 'D-4201');
  TTipoEventoDeREArraySchemas: array[TTipoEventoDeRE] of TSchemaDeRE = (
    schevtInfoContrib, schevtPGCC,
    schevtBalancete, schevtAplicResTec, schevtRelDeducoes, schevtReabertMensal, schevtFechMensal,
    schevtDebOpOfPublic, schevtInfoCotistas, schevtServRemPreco, schevtServRemTarifa,
    schevtOperFinanc, schevtAntecReceb, schevtArrendMerc, schevtArranjoCredDest,
    schevtArranjoPartic, schevtSegPrevCap, schevtSegElemSCob, schevtPlAssistSaude, schevtIdApostPrem);

type
  // Tipo de operacao do evento (tpOper): 0-Nenhum 1-Inclusao, 2-Alteracao, 3-Exclusao,
  //  4-Retificacao
  TTpOperDeRE = (toNenhum, toInclusao, toAlteracao, toExclusao, toRetificacao);

const
  TTpOperDeREArrayStrings: array[TTpOperDeRE] of string = ('', '1', '2', '3', '4');

type
  // Motivo da exclusao (motExcl): Nenhum (vazio), 1, 2, 3, 9
  TMotExclDeRE = (meNenhum, meDeterminacao, meEnvioIndevido, meErroIdentificacao, meOutro);

const
  TMotExclDeREArrayStrings: array[TMotExclDeRE] of string = ('', '1', '2', '3', '9');

type
  // Aplicativo emissor (aplicEmi): 0-Nenhum 1-Empresa, 2-Governamental
  TAplicEmiDeRE = (aeNenhum, aeEmpresa, aeGovernamental);

const
  TAplicEmiDeREArrayStrings: array[TAplicEmiDeRE] of string = ('', '1', '2');

type
  // Regime de tributacao (regTribPrinc/regTribSecund): Nenhum (vazio), 1, 2, 3, 9
  TRegTribDeRE = (rtNenhum, rtServFinanceiros, rtPlanoSaude, rtPrognosticos, rtOutros);

const
  TRegTribDeREArrayStrings: array[TRegTribDeRE] of string = ('', '1', '2', '3', '9');

type
  // Indicador da natureza tributaria (indNatTrib): Nenhum (vazio), 0, 1
  TIndNatTribDeRE = (intNenhum, intTributacaoRegular, intImunidadeNaoIncidencia);

const
  TIndNatTribDeREArrayStrings: array[TIndNatTribDeRE] of string = ('', '0', '1');

type
  // Plano de contas referencial (planoCtaRef): 0-Nenhum 1-COSIF, 2-ANS, 3-SUSEP, 4-SPED,
  //  5-PREVIC, 6-COFI (COFI somente a partir do evtPGCC v1_0_4 / ve104)
  TPlanoCtaRefDeRE = (pcrNenhum, pcrCOSIF, pcrANS, pcrSUSEP, pcrSPED, pcrPREVIC, pcrCOFI);

const
  TPlanoCtaRefDeREArrayStrings: array[TPlanoCtaRefDeRE] of string = ('', '1', '2', '3', '4', '5', '6');

type
  // Frequencia de encerramento contabil (freqEncerr): Nenhum (vazio), A-Anual, S-Semestral,
  //  Q-Quadrimestral, T-Trimestral, B-Bimestral, M-Mensal
  TFreqEncerrDeRE = (feNenhum, feAnual, feSemestral, feQuadrimestral, feTrimestral, feBimestral, feMensal);

const
  TFreqEncerrDeREArrayStrings: array[TFreqEncerrDeRE] of string = ('', 'A', 'S', 'Q', 'T', 'B', 'M');

type
  // Indicador do tipo de conta (indCta): Nenhum (vazio), S-Sintetica, A-Analitica
  TIndCtaDeRE = (icNenhum, icSintetica, icAnalitica);

const
  TIndCtaDeREArrayStrings: array[TIndCtaDeRE] of string = ('', 'S', 'A');

type
  // Natureza da conta (natCta): Nenhum (vazio), C-Credora, D-Devedora, V-Variavel
  TNatCtaDeRE = (ncNenhum, ncCredora, ncDevedora, ncVariavel);

const
  TNatCtaDeREArrayStrings: array[TNatCtaDeRE] of string = ('', 'C', 'D', 'V');

type
  // Codigo da natureza da conta (codNat): 0-Nenhum 1-Ativo, 2-Passivo, 3-Patrimonio Liquido,
  //  4-Receita, 5-Despesa, 6-Compensacao, 7-Outras (6 e 7 somente a partir do evtPGCC
  //  v1_0_4 / ve104)
  TCodNatDeRE = (cnNenhum, cnAtivo, cnPassivo, cnPatrimonioLiquido, cnReceita, cnDespesa,
                 cnCompensacao, cnOutras);

const
  TCodNatDeREArrayStrings: array[TCodNatDeRE] of string = ('', '1', '2', '3', '4', '5', '6', '7');

type
  // Indicador de sujeicao ao ISSQN (indTribISS): 0-Nenhum 0-Nao sujeita, 1-Sujeita
  TIndTribISSDeRE = (itNenhum, itNaoSujeita, itSujeita);

const
  TIndTribISSDeREArrayStrings: array[TIndTribISSDeRE] of string = ('', '0', '1');

type
  // Natureza de saldo/movimento do balancete (natSaldoInic/natSaldoFinal/natVApur): Nenhum (vazio),
  //  D-Devedor, C-Credor
  TNatSaldoDeRE = (nsNenhum, nsDevedor, nsCredor);

const
  TNatSaldoDeREArrayStrings: array[TNatSaldoDeRE] of string = ('', 'D', 'C');

type
  // Finalidade do evento na retificacao pos-fechamento (finEvt): Nenhum (vazio), 1/2/3
  TFinEvtDeRE = (fiNenhum, feInclusaoReg, feAlteracaoReg, feExclusaoReg);

const
  TFinEvtDeREArrayStrings: array[TFinEvtDeRE] of string = ('', '1', '2', '3');

type
  // Tipo de documento fiscal (tpDFe): 0-Nenhum 01-DeRE, 02-NFS-e, 03-NF-e, 04-NFC-e, 05-NF-e ABI
  TTpDFeDeRE = (tdNenhum, tdDeRE, tdNFSe, tdNFe, tdNFCe, tdNFeABI);

const
  TTpDFeDeREArrayStrings: array[TTpDFeDeRE] of string = ('', '01', '02', '03', '04', '05');

type
  // Tipo de atividade para deducao (tpAtiv): Nenhum (vazio)
  TTpAtivDedDeRE = (tadNenhum, tadOpCredCambio, tadArrendamentos, tadAdmConsorcio,
                    tadSegRamosElem, tadSegPessoasSobrev, tadCapitalizacao,
                    tadPlAssistSaude, tadConcursosProg);

const
  TTpAtivDedDeREArrayStrings: array[TTpAtivDedDeRE] of string =
    ('', '01', '06', '08', '11', '13', '14', '20', '30');

{
  Declaracao das funcoes de conversao
}
type
  // Finalidade do evento (finEvt) dos eventos transacionais: 0-Nenhum 11-Original, 21-Deducao
  //  extemporanea, 31-Devolucao, 41-Cancelamento
  TFinalidadeEvtDeRE = (foNenhum, foRegistroOriginal, foDeducaoExtemporanea, foDevolucao, foCancelamento);

const
  TFinalidadeEvtDeREArrayStrings: array[TFinalidadeEvtDeRE] of string = ('', '11', '21', '31', '41');

type
  // metodoAproveit (D-1199): Nenhum (vazio)
  TMetodoAproveitDeRE = (maNenhum, maPEPS, maManual);

const
  TMetodoAproveitDeREArrayStrings: array[TMetodoAproveitDeRE] of string = ('', '0', '1');

type
  // tipoPessoa (D-2102): Nenhum (vazio)
  TTipoPessoaDeRE = (pesNenhum, pesFisicaResidente, pesJuridicaResidente, pesFisicaExterior, pesJuridicaExterior, pesFisicaNaoIdentificada, pesJuridicaNaoIdentificada);

const
  TTipoPessoaDeREArrayStrings: array[TTipoPessoaDeRE] of string = ('', '1', '2', '3', '4', '5', '6');

type
  // classificacao (D-2102): 0-Nenhum 1-Cotista de fundo de investimento, 2-Distribuidor de cotas de
  //  fundo de invest
  TClassificacaoDeRE = (clNenhum, clCotista, clDistribuidor);

const
  TClassificacaoDeREArrayStrings: array[TClassificacaoDeRE] of string = ('', '1', '2');

type
  // tpDeclarante (D-2102): 0-Nenhum 1-Administrador de fundo de investimento (, 2-Distribuidor de
  //  cotas por conta e ordem
  TTpDeclaranteDeRE = (tdeNenhum, tdAdministradorFundo, tdDistribuidorCotas);

const
  TTpDeclaranteDeREArrayStrings: array[TTpDeclaranteDeRE] of string = ('', '1', '2');

type
  // cNaoNIF (D-2201): 0-Nenhum 1-Dispensado de NIF, 2-Nao exigencia de NIF
  TCNaoNIFDeRE = (cnfNenhum, cnDispensado, cnNaoExigencia);

const
  TCNaoNIFDeREArrayStrings: array[TCNaoNIFDeRE] of string = ('', '1', '2');

type
  // tpParticip (D-2242): 0-Nenhum 1-Instituidor/Bandeira, 2-Emissor, 3-Credenciador
  TTpParticipDeRE = (partNenhum, partInstituidorBandeira, partEmissor, partCredenciador);

const
  TTpParticipDeREArrayStrings: array[TTpParticipDeRE] of string = ('', '1', '2', '3');

type
  // tpContrato (D-2251): 0-Nenhum 1-Plano ou seguro individual, 2-Plano ou seguro coletivo
  TTpContratoDeRE = (tcNenhum, tcIndividual, tcColetivo);

const
  TTpContratoDeREArrayStrings: array[TTpContratoDeRE] of string = ('', '1', '2');

type
  // tpContrato (D-3201): Nenhum (vazio)
  TTpContratoD3201 = (tcdNenhum, tcIndividualFamiliar, tcColetivoSemAdministradora, tcColetivoComAdministradora, tcSemValorDefinido);

const
  TTpContratoD3201ArrayStrings: array[TTpContratoD3201] of string = ('', '1', '2', '3', '4');

type
  // Codigo de resposta do lote (cdResposta): 1-Aguardando, 2-Sucesso, 3-Com erros, 4-Consulta nao executada, 5-Lote nao encontrado, 7-Lote nao recebido, 9-Erro interno [item nulo: crlNenhum = vazio]
  TCdRespostaLoteDeRE = (crlNenhum, crlAguardando, crlProcessadoSucesso, crlProcessadoComErros, crlConsultaNaoExecutada, crlLoteNaoEncontrado, crlLoteNaoRecebido, crlErroInterno);

const
  TCdRespostaLoteDeREArrayStrings: array[TCdRespostaLoteDeRE] of string = ('', '1', '2', '3', '4', '5', '7', '9');

type
  // Codigo de retorno do evento (cdRetorno): 0-Erro, 1-Sucesso [item nulo: cretNenhum = vazio]
  TCdRetornoDeRE = (cretNenhum, cretErro, cretSucesso);

const
  TCdRetornoDeREArrayStrings: array[TCdRetornoDeRE] of string = ('', '0', '1');

type
  // Descricao literal do retorno do evento (descRetorno) [item nulo: dretNenhum = vazio]
  TDescRetornoDeRE = (dretNenhum, dretErro, dretSucesso);

const
  TDescRetornoDeREArrayStrings: array[TDescRetornoDeRE] of string = ('', 'Erro', 'Sucesso');

type
  // Tipo da ocorrencia (tipo): 1-Erro, 2-Advertencia [item nulo: tocNenhum = vazio]
  TTipoOcorrenciaDeRE = (tocNenhum, tocErro, tocAdvertencia);

const
  TTipoOcorrenciaDeREArrayStrings: array[TTipoOcorrenciaDeRE] of string = ('', '1', '2');

type
  // Tipo do evento de retorno: D-9001 Tabela, D-9101 Balancete, D-9106 Aplic. Financeiras, D-9109 Periodicos Mensais, D-9112 Deducoes, D-9121 Titulos Publicos, D-9198 Reabertura, D-9199 Fechamento, D-9209 Transacionais [item nulo: trtNenhum = vazio]
  TTipoRetornoDeRE = (trtNenhum, trtTabela, trtBalancete, trtAplicFin, trtPeriodicosMensais, trtRelDeducoes, trtTitPub, trtReabertura, trtFechamento, trtTransacionais);

const
  TTipoRetornoDeREArrayStrings: array[TTipoRetornoDeRE] of string = ('', 'D-9001', 'D-9101', 'D-9106', 'D-9109', 'D-9112', 'D-9121', 'D-9198', 'D-9199', 'D-9209');

function tipoRetornoDeREToStr(const t: TTipoRetornoDeRE): string;
function StrTotipoRetornoDeRE(const s: string): TTipoRetornoDeRE;

function tipoOcorrenciaDeREToStr(const t: TTipoOcorrenciaDeRE): string;
function StrTotipoOcorrenciaDeRE(const s: string): TTipoOcorrenciaDeRE;

function descRetornoDeREToStr(const t: TDescRetornoDeRE): string;
function StrTodescRetornoDeRE(const s: string): TDescRetornoDeRE;

function cdRetornoDeREToStr(const t: TCdRetornoDeRE): string;
function StrTocdRetornoDeRE(const s: string): TCdRetornoDeRE;

function cdRespostaLoteDeREToStr(const t: TCdRespostaLoteDeRE): string;
function StrTocdRespostaLoteDeRE(const s: string): TCdRespostaLoteDeRE;

function tpContratoD3201ToStr(const t: TTpContratoD3201): string;
function StrTotpContratoD3201(const s: string): TTpContratoD3201;

function tpContratoDeREToStr(const t: TTpContratoDeRE): string;
function StrTotpContratoDeRE(const s: string): TTpContratoDeRE;

function tpParticipDeREToStr(const t: TTpParticipDeRE): string;
function StrTotpParticipDeRE(const s: string): TTpParticipDeRE;

function cNaoNIFDeREToStr(const t: TCNaoNIFDeRE): string;
function StrTocNaoNIFDeRE(const s: string): TCNaoNIFDeRE;

function tpDeclaranteDeREToStr(const t: TTpDeclaranteDeRE): string;
function StrTotpDeclaranteDeRE(const s: string): TTpDeclaranteDeRE;

function classificacaoDeREToStr(const t: TClassificacaoDeRE): string;
function StrToclassificacaoDeRE(const s: string): TClassificacaoDeRE;

function tipoPessoaDeREToStr(const t: TTipoPessoaDeRE): string;
function StrTotipoPessoaDeRE(const s: string): TTipoPessoaDeRE;

function metodoAproveitDeREToStr(const t: TMetodoAproveitDeRE): string;
function StrTometodoAproveitDeRE(const s: string): TMetodoAproveitDeRE;

function finalidadeEvtDeREToStr(const t: TFinalidadeEvtDeRE): string;
function StrTofinalidadeEvtDeRE(const s: string): TFinalidadeEvtDeRE;

function LayOutDeREToServico(const t: TLayOutDeRE): string;
function VersaoDeREToStr(const t: TVersaoDeRE): string;
function StrToVersaoDeRE(const s: string): TVersaoDeRE;
function StrToVersaoDeREDef(const s: string; const ADefault: TVersaoDeRE): TVersaoDeRE;
function DblToVersaoDeRE(const d: Double): TVersaoDeRE;
function VersaoDeREToDbl(const t: TVersaoDeRE): Double;

// Versao do schema (ex.: '1_0_4') do evento/servico para a versao do leiaute informada.
//  Retorna vazio quando o schema nao existe nessa versao.
function VersaoSchemaDeRE(const ASchema: TSchemaDeRE; const AVersao: TVersaoDeRE): string;
function SchemaDeREDisponivel(const ASchema: TSchemaDeRE; const AVersao: TVersaoDeRE): Boolean;
// Mesmo valor de VersaoSchemaDeRE no formato numerico usado no nome do XSD (1_0_4 = 1.04)
function VersaoSchemaDeREToDbl(const ASchema: TSchemaDeRE; const AVersao: TVersaoDeRE): Double;
// Namespace (xmlns/targetNamespace) do schema na versao informada. Gera excecao se o
//  schema nao existir nessa versao.
function NamespaceDeRE(const ASchema: TSchemaDeRE; const AVersao: TVersaoDeRE): string;

function SchemaDeREToStr(const t: TSchemaDeRE): string;
function StrToSchemaDeRE(const s: string): TSchemaDeRE;

function TipoEventoDeREToStr(const t: TTipoEventoDeRE): string;
function StrToTipoEventoDeRE(const s: string): TTipoEventoDeRE;
function TryStrToTipoEventoDeRE(const s: string; out t: TTipoEventoDeRE): Boolean;
function TipoEventoDeREToSchema(const t: TTipoEventoDeRE): TSchemaDeRE;

function tpOperDeREToStr(const t: TTpOperDeRE): string;
function StrTotpOperDeRE(const s: string): TTpOperDeRE;

function motExclDeREToStr(const t: TMotExclDeRE): string;
function StrTomotExclDeRE(const s: string): TMotExclDeRE;

function aplicEmiDeREToStr(const t: TAplicEmiDeRE): string;
function StrToaplicEmiDeRE(const s: string): TAplicEmiDeRE;

function regTribDeREToStr(const t: TRegTribDeRE): string;
function StrToregTribDeRE(const s: string): TRegTribDeRE;

function indNatTribDeREToStr(const t: TIndNatTribDeRE): string;
function StrToindNatTribDeRE(const s: string): TIndNatTribDeRE;

function planoCtaRefDeREToStr(const t: TPlanoCtaRefDeRE): string;
function StrToplanoCtaRefDeRE(const s: string): TPlanoCtaRefDeRE;

function freqEncerrDeREToStr(const t: TFreqEncerrDeRE): string;
function StrTofreqEncerrDeRE(const s: string): TFreqEncerrDeRE;

function indCtaDeREToStr(const t: TIndCtaDeRE): string;
function StrToindCtaDeRE(const s: string): TIndCtaDeRE;

function natCtaDeREToStr(const t: TNatCtaDeRE): string;
function StrTonatCtaDeRE(const s: string): TNatCtaDeRE;

function codNatDeREToStr(const t: TCodNatDeRE): string;
function StrTocodNatDeRE(const s: string): TCodNatDeRE;

function indTribISSDeREToStr(const t: TIndTribISSDeRE): string;
function StrToindTribISSDeRE(const s: string): TIndTribISSDeRE;

function natSaldoDeREToStr(const t: TNatSaldoDeRE): string;
function StrTonatSaldoDeRE(const s: string): TNatSaldoDeRE;

function finEvtDeREToStr(const t: TFinEvtDeRE): string;
function StrTofinEvtDeRE(const s: string): TFinEvtDeRE;

function tpDFeDeREToStr(const t: TTpDFeDeRE): string;
function StrTotpDFeDeRE(const s: string): TTpDFeDeRE;

function tpAtivDedDeREToStr(const t: TTpAtivDedDeRE): string;
function StrTotpAtivDedDeRE(const s: string): TTpAtivDedDeRE;

implementation

uses
  typinfo,
  ACBrBase;

function LayOutDeREToServico(const t: TLayOutDeRE): string;
begin
  // Chave do servico em ACBrDeREServicos.ini (<Servico>_<versao>)
  case t of
    LayDeREObterToken:   Result := 'Token';
    LayDeRERecepcaoLote: Result := 'RecepcaoLote';
    LayDeREConsultaLote: Result := 'ConsultaLote';
    LayDeRELimpeza:      Result := 'Limpeza';
  else
    Result := '';
  end;
end;

function VersaoDeREToStr(const t: TVersaoDeRE): string;
begin
  Result := TVersaoDeREArrayStrings[t];
end;

function finalidadeEvtDeREToStr(const t: TFinalidadeEvtDeRE): string;
begin
  Result := TFinalidadeEvtDeREArrayStrings[t];
end;

function StrTofinalidadeEvtDeRE(const s: string): TFinalidadeEvtDeRE;
var
  idx: TFinalidadeEvtDeRE;
begin
  for idx := Low(TFinalidadeEvtDeREArrayStrings) to High(TFinalidadeEvtDeREArrayStrings) do
  begin
    if (TFinalidadeEvtDeREArrayStrings[idx] = s) then
    begin
      Result := idx;
      Exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string invalido para TFinalidadeEvtDeRE: %s', [s]);
end;

function metodoAproveitDeREToStr(const t: TMetodoAproveitDeRE): string;
begin
  Result := TMetodoAproveitDeREArrayStrings[t];
end;

function StrTometodoAproveitDeRE(const s: string): TMetodoAproveitDeRE;
var
  idx: TMetodoAproveitDeRE;
begin
  for idx := Low(TMetodoAproveitDeREArrayStrings) to High(TMetodoAproveitDeREArrayStrings) do
  begin
    if (TMetodoAproveitDeREArrayStrings[idx] = s) then
    begin
      Result := idx;
      Exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string invalido para TMetodoAproveitDeRE: %s', [s]);
end;

function tipoPessoaDeREToStr(const t: TTipoPessoaDeRE): string;
begin
  Result := TTipoPessoaDeREArrayStrings[t];
end;

function StrTotipoPessoaDeRE(const s: string): TTipoPessoaDeRE;
var
  idx: TTipoPessoaDeRE;
begin
  for idx := Low(TTipoPessoaDeREArrayStrings) to High(TTipoPessoaDeREArrayStrings) do
  begin
    if (TTipoPessoaDeREArrayStrings[idx] = s) then
    begin
      Result := idx;
      Exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string invalido para TTipoPessoaDeRE: %s', [s]);
end;

function classificacaoDeREToStr(const t: TClassificacaoDeRE): string;
begin
  Result := TClassificacaoDeREArrayStrings[t];
end;

function StrToclassificacaoDeRE(const s: string): TClassificacaoDeRE;
var
  idx: TClassificacaoDeRE;
begin
  for idx := Low(TClassificacaoDeREArrayStrings) to High(TClassificacaoDeREArrayStrings) do
  begin
    if (TClassificacaoDeREArrayStrings[idx] = s) then
    begin
      Result := idx;
      Exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string invalido para TClassificacaoDeRE: %s', [s]);
end;

function tpDeclaranteDeREToStr(const t: TTpDeclaranteDeRE): string;
begin
  Result := TTpDeclaranteDeREArrayStrings[t];
end;

function StrTotpDeclaranteDeRE(const s: string): TTpDeclaranteDeRE;
var
  idx: TTpDeclaranteDeRE;
begin
  for idx := Low(TTpDeclaranteDeREArrayStrings) to High(TTpDeclaranteDeREArrayStrings) do
  begin
    if (TTpDeclaranteDeREArrayStrings[idx] = s) then
    begin
      Result := idx;
      Exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string invalido para TTpDeclaranteDeRE: %s', [s]);
end;

function cNaoNIFDeREToStr(const t: TCNaoNIFDeRE): string;
begin
  Result := TCNaoNIFDeREArrayStrings[t];
end;

function StrTocNaoNIFDeRE(const s: string): TCNaoNIFDeRE;
var
  idx: TCNaoNIFDeRE;
begin
  for idx := Low(TCNaoNIFDeREArrayStrings) to High(TCNaoNIFDeREArrayStrings) do
  begin
    if (TCNaoNIFDeREArrayStrings[idx] = s) then
    begin
      Result := idx;
      Exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string invalido para TCNaoNIFDeRE: %s', [s]);
end;

function tpParticipDeREToStr(const t: TTpParticipDeRE): string;
begin
  Result := TTpParticipDeREArrayStrings[t];
end;

function StrTotpParticipDeRE(const s: string): TTpParticipDeRE;
var
  idx: TTpParticipDeRE;
begin
  for idx := Low(TTpParticipDeREArrayStrings) to High(TTpParticipDeREArrayStrings) do
  begin
    if (TTpParticipDeREArrayStrings[idx] = s) then
    begin
      Result := idx;
      Exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string invalido para TTpParticipDeRE: %s', [s]);
end;

function tpContratoDeREToStr(const t: TTpContratoDeRE): string;
begin
  Result := TTpContratoDeREArrayStrings[t];
end;

function StrTotpContratoDeRE(const s: string): TTpContratoDeRE;
var
  idx: TTpContratoDeRE;
begin
  for idx := Low(TTpContratoDeREArrayStrings) to High(TTpContratoDeREArrayStrings) do
  begin
    if (TTpContratoDeREArrayStrings[idx] = s) then
    begin
      Result := idx;
      Exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string invalido para TTpContratoDeRE: %s', [s]);
end;

function tpContratoD3201ToStr(const t: TTpContratoD3201): string;
begin
  Result := TTpContratoD3201ArrayStrings[t];
end;

function StrTotpContratoD3201(const s: string): TTpContratoD3201;
var
  idx: TTpContratoD3201;
begin
  for idx := Low(TTpContratoD3201ArrayStrings) to High(TTpContratoD3201ArrayStrings) do
  begin
    if (TTpContratoD3201ArrayStrings[idx] = s) then
    begin
      Result := idx;
      Exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string invalido para TTpContratoD3201: %s', [s]);
end;

function cdRespostaLoteDeREToStr(const t: TCdRespostaLoteDeRE): string;
begin
  Result := TCdRespostaLoteDeREArrayStrings[t];
end;

function StrTocdRespostaLoteDeRE(const s: string): TCdRespostaLoteDeRE;
var
  idx: TCdRespostaLoteDeRE;
begin
  for idx := Low(TCdRespostaLoteDeREArrayStrings) to High(TCdRespostaLoteDeREArrayStrings) do
  begin
    if (TCdRespostaLoteDeREArrayStrings[idx] = s) then
    begin
      Result := idx;
      Exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string invalido para TCdRespostaLoteDeRE: %s', [s]);
end;

function cdRetornoDeREToStr(const t: TCdRetornoDeRE): string;
begin
  Result := TCdRetornoDeREArrayStrings[t];
end;

function StrTocdRetornoDeRE(const s: string): TCdRetornoDeRE;
var
  idx: TCdRetornoDeRE;
begin
  for idx := Low(TCdRetornoDeREArrayStrings) to High(TCdRetornoDeREArrayStrings) do
  begin
    if (TCdRetornoDeREArrayStrings[idx] = s) then
    begin
      Result := idx;
      Exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string invalido para TCdRetornoDeRE: %s', [s]);
end;

function descRetornoDeREToStr(const t: TDescRetornoDeRE): string;
begin
  Result := TDescRetornoDeREArrayStrings[t];
end;

function StrTodescRetornoDeRE(const s: string): TDescRetornoDeRE;
var
  idx: TDescRetornoDeRE;
begin
  for idx := Low(TDescRetornoDeREArrayStrings) to High(TDescRetornoDeREArrayStrings) do
  begin
    if (TDescRetornoDeREArrayStrings[idx] = s) then
    begin
      Result := idx;
      Exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string invalido para TDescRetornoDeRE: %s', [s]);
end;

function tipoOcorrenciaDeREToStr(const t: TTipoOcorrenciaDeRE): string;
begin
  Result := TTipoOcorrenciaDeREArrayStrings[t];
end;

function StrTotipoOcorrenciaDeRE(const s: string): TTipoOcorrenciaDeRE;
var
  idx: TTipoOcorrenciaDeRE;
begin
  for idx := Low(TTipoOcorrenciaDeREArrayStrings) to High(TTipoOcorrenciaDeREArrayStrings) do
  begin
    if (TTipoOcorrenciaDeREArrayStrings[idx] = s) then
    begin
      Result := idx;
      Exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string invalido para TTipoOcorrenciaDeRE: %s', [s]);
end;

function tipoRetornoDeREToStr(const t: TTipoRetornoDeRE): string;
begin
  Result := TTipoRetornoDeREArrayStrings[t];
end;

function StrTotipoRetornoDeRE(const s: string): TTipoRetornoDeRE;
var
  idx: TTipoRetornoDeRE;
begin
  for idx := Low(TTipoRetornoDeREArrayStrings) to High(TTipoRetornoDeREArrayStrings) do
  begin
    if (TTipoRetornoDeREArrayStrings[idx] = s) then
    begin
      Result := idx;
      Exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string invalido para TTipoRetornoDeRE: %s', [s]);
end;

function StrToVersaoDeRE(const s: string): TVersaoDeRE;
var
  idx: TVersaoDeRE;
  LS: string;
begin
  // Aceita '1.0.4', '1_0_4', '1.04' e '1,04'
  LS := StringReplace(Trim(s), '_', '.', [rfReplaceAll]);

  for idx := Low(TVersaoDeREArrayStrings) to High(TVersaoDeREArrayStrings) do
  begin
    if StringReplace(TVersaoDeREArrayStrings[idx], '.', '', [rfReplaceAll]) =
       StringReplace(StringReplace(LS, '.', '', [rfReplaceAll]), ',', '', [rfReplaceAll]) then
    begin
      Result := idx;
      Exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string invalido para TVersaoDeRE: %s', [s]);
end;

function StrToVersaoDeREDef(const s: string; const ADefault: TVersaoDeRE): TVersaoDeRE;
begin
  try
    Result := StrToVersaoDeRE(s);
  except
    Result := ADefault;
  end;
end;

function DblToVersaoDeRE(const d: Double): TVersaoDeRE;
var
  idx: TVersaoDeRE;
begin
  for idx := Low(TVersaoDeREArrayDouble) to High(TVersaoDeREArrayDouble) do
  begin
    if (TVersaoDeREArrayDouble[idx] = d) then
    begin
      Result := idx;
      Exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor double invalido para TVersaoDeRE: %s',
    [FormatFloat('0.00', d)]);
end;

function VersaoDeREToDbl(const t: TVersaoDeRE): Double;
begin
  Result := TVersaoDeREArrayDouble[t];
end;

function SchemaDeREToStr(const t: TSchemaDeRE): string;
begin
  Result := GetEnumName(TypeInfo(TSchemaDeRE), Integer(t));
  Result := Copy(Result, 4, Length(Result)); // Remove prefixo "sch"
  // ATENCAO: o nome do membro do enum define o nome do schema (namespace do XML e arquivo
  //  XSD), que no ambiente nacional e minusculo/camelCase. Por isso schenvioLoteDere e
  //  schretornoLoteDere NAO podem ser renomeados para ...DeRE.
end;

const
  // Versao de cada schema por versao do leiaute (ve102, ve103, ve104). Vazio = o schema
  //  nao existe naquela versao.
  //  Fontes: pacotes oficiais Nota Orientativa 2026-001 (ve102), PRODUCAO (ve103) e
  //  Producao Restrita Empresas Piloto 03/11/2026 (ve104). Os schemas 0_0_x pertencem ao
  //  pacote v1.3.0, ainda nao ativo nos ambientes do SERPRO.
  TSchemaDeREVersoes: array[TSchemaDeRE, TVersaoDeRE] of string = (
    ('', '', ''),                         // schErroDeRE
    ('1_0_1', '1_0_1', '1_0_1'),          // schevtInfoContrib
    ('1_0_2', '1_0_3', '1_0_4'),          // schevtPGCC
    ('1_0_0', '', '1_0_1'),               // schevtBalancete
    ('1_0_0', '', '1_0_0'),               // schevtAplicResTec
    ('', '', '0_0_2'),                    // schevtRelDeducoes
    ('', '', '0_0_1'),                    // schevtReabertMensal
    ('', '', '0_0_2'),                    // schevtFechMensal
    ('', '', '0_0_3'),                    // schevtDebOpOfPublic
    ('', '', '0_0_1'),                    // schevtInfoCotistas
    ('', '', '0_0_2'),                    // schevtServRemPreco
    ('', '', '0_0_2'),                    // schevtServRemTarifa
    ('', '', '0_0_2'),                    // schevtOperFinanc
    ('', '', '0_0_2'),                    // schevtAntecReceb
    ('', '', '0_0_2'),                    // schevtArrendMerc
    ('', '', '0_0_2'),                    // schevtArranjoCredDest
    ('', '', '0_0_2'),                    // schevtArranjoPartic
    ('', '', '0_0_2'),                    // schevtSegPrevCap
    ('', '', '0_0_1'),                    // schevtSegElemSCob
    ('', '', '0_0_2'),                    // schevtPlAssistSaude
    ('', '', '0_0_2'),                    // schevtIdApostPrem
    ('1_0_1', '1_0_1', '1_0_1'),          // schenvioLoteDere
    ('1_0_1', '1_0_1', '1_0_1'),          // schretornoLoteDere
    ('1_0_1', '1_0_1', '1_0_1'));         // schevtRetornoTabela

function VersaoSchemaDeRE(const ASchema: TSchemaDeRE; const AVersao: TVersaoDeRE): string;
begin
  Result := TSchemaDeREVersoes[ASchema, AVersao];
end;

function SchemaDeREDisponivel(const ASchema: TSchemaDeRE; const AVersao: TVersaoDeRE): Boolean;
begin
  Result := TSchemaDeREVersoes[ASchema, AVersao] <> '';
end;

function VersaoSchemaDeREToDbl(const ASchema: TSchemaDeRE; const AVersao: TVersaoDeRE): Double;
var
  LVer: string;
begin
  Result := 0;
  LVer := StringReplace(VersaoSchemaDeRE(ASchema, AVersao), '_', '', [rfReplaceAll]);
  if Length(LVer) = 3 then
    Result := StrToInt(LVer[1]) + StrToInt(LVer[2]) / 10 + StrToInt(LVer[3]) / 100;
end;

function NamespaceDeRE(const ASchema: TSchemaDeRE; const AVersao: TVersaoDeRE): string;
var
  LVer: string;
begin
  LVer := VersaoSchemaDeRE(ASchema, AVersao);
  if LVer = '' then
    raise EACBrException.CreateFmt(
      'O schema %s nao existe na versao %s do leiaute da DeRE.',
      [SchemaDeREToStr(ASchema), VersaoDeREToStr(AVersao)]);

  Result := 'http://www.dere.gov.br/schemas/' + SchemaDeREToStr(ASchema) + '/v' + LVer;
end;

function StrToSchemaDeRE(const s: string): TSchemaDeRE;
var
  P: Integer;
  SchemaStr: string;
  CodSchema: Integer;
begin
  P := Pos('_', s);

  if P > 0 then
    SchemaStr := Copy(s, 1, P - 1)
  else
    SchemaStr := s;

  if LeftStr(SchemaStr, 3) <> 'sch' then
    SchemaStr := 'sch' + SchemaStr;

  CodSchema := GetEnumValue(TypeInfo(TSchemaDeRE), SchemaStr);

  if CodSchema = -1 then
    raise EACBrException.CreateFmt('"%s" nao e um valor TSchemaDeRE valido.', [SchemaStr]);

  Result := TSchemaDeRE(CodSchema);
end;

function TipoEventoDeREToStr(const t: TTipoEventoDeRE): string;
begin
  Result := TTipoEventoDeREArrayStrings[t];
end;

function TryStrToTipoEventoDeRE(const s: string; out t: TTipoEventoDeRE): Boolean;
var
  idx: TTipoEventoDeRE;
  LS: string;
begin
  // O ambiente nacional devolve o tipo sem hifen (D1001); o manual/XSD usa D-1001.
  // Aceita as duas formas.
  LS := StringReplace(Trim(s), '-', '', [rfReplaceAll]);

  for idx := Low(TTipoEventoDeREArrayStrings) to High(TTipoEventoDeREArrayStrings) do
  begin
    if SameText(StringReplace(TTipoEventoDeREArrayStrings[idx], '-', '', [rfReplaceAll]), LS) then
    begin
      t := idx;
      Result := True;
      Exit;
    end;
  end;

  t := Low(TTipoEventoDeRE);
  Result := False;
end;

function StrToTipoEventoDeRE(const s: string): TTipoEventoDeRE;
begin
  if not TryStrToTipoEventoDeRE(s, Result) then
    raise EACBrException.CreateFmt('Valor string invalido para TTipoEventoDeRE: %s', [s]);
end;

function TipoEventoDeREToSchema(const t: TTipoEventoDeRE): TSchemaDeRE;
begin
  Result := TTipoEventoDeREArraySchemas[t];
end;

function tpOperDeREToStr(const t: TTpOperDeRE): string;
begin
  Result := TTpOperDeREArrayStrings[t];
end;

function StrTotpOperDeRE(const s: string): TTpOperDeRE;
var
  idx: TTpOperDeRE;
begin
  for idx := Low(TTpOperDeREArrayStrings) to High(TTpOperDeREArrayStrings) do
  begin
    if (TTpOperDeREArrayStrings[idx] = s) then
    begin
      Result := idx;
      Exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string invalido para TTpOperDeRE: %s', [s]);
end;

function motExclDeREToStr(const t: TMotExclDeRE): string;
begin
  Result := TMotExclDeREArrayStrings[t];
end;

function StrTomotExclDeRE(const s: string): TMotExclDeRE;
var
  idx: TMotExclDeRE;
begin
  for idx := Low(TMotExclDeREArrayStrings) to High(TMotExclDeREArrayStrings) do
  begin
    if (TMotExclDeREArrayStrings[idx] = s) then
    begin
      Result := idx;
      Exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string invalido para TMotExclDeRE: %s', [s]);
end;

function aplicEmiDeREToStr(const t: TAplicEmiDeRE): string;
begin
  Result := TAplicEmiDeREArrayStrings[t];
end;

function StrToaplicEmiDeRE(const s: string): TAplicEmiDeRE;
var
  idx: TAplicEmiDeRE;
begin
  for idx := Low(TAplicEmiDeREArrayStrings) to High(TAplicEmiDeREArrayStrings) do
  begin
    if (TAplicEmiDeREArrayStrings[idx] = s) then
    begin
      Result := idx;
      Exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string invalido para TAplicEmiDeRE: %s', [s]);
end;

function regTribDeREToStr(const t: TRegTribDeRE): string;
begin
  Result := TRegTribDeREArrayStrings[t];
end;

function StrToregTribDeRE(const s: string): TRegTribDeRE;
var
  idx: TRegTribDeRE;
begin
  for idx := Low(TRegTribDeREArrayStrings) to High(TRegTribDeREArrayStrings) do
  begin
    if (TRegTribDeREArrayStrings[idx] = s) then
    begin
      Result := idx;
      Exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string invalido para TRegTribDeRE: %s', [s]);
end;

function indNatTribDeREToStr(const t: TIndNatTribDeRE): string;
begin
  Result := TIndNatTribDeREArrayStrings[t];
end;

function StrToindNatTribDeRE(const s: string): TIndNatTribDeRE;
var
  idx: TIndNatTribDeRE;
begin
  for idx := Low(TIndNatTribDeREArrayStrings) to High(TIndNatTribDeREArrayStrings) do
  begin
    if (TIndNatTribDeREArrayStrings[idx] = s) then
    begin
      Result := idx;
      Exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string invalido para TIndNatTribDeRE: %s', [s]);
end;

function planoCtaRefDeREToStr(const t: TPlanoCtaRefDeRE): string;
begin
  Result := TPlanoCtaRefDeREArrayStrings[t];
end;

function StrToplanoCtaRefDeRE(const s: string): TPlanoCtaRefDeRE;
var
  idx: TPlanoCtaRefDeRE;
begin
  for idx := Low(TPlanoCtaRefDeREArrayStrings) to High(TPlanoCtaRefDeREArrayStrings) do
  begin
    if (TPlanoCtaRefDeREArrayStrings[idx] = s) then
    begin
      Result := idx;
      Exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string invalido para TPlanoCtaRefDeRE: %s', [s]);
end;

function freqEncerrDeREToStr(const t: TFreqEncerrDeRE): string;
begin
  Result := TFreqEncerrDeREArrayStrings[t];
end;

function StrTofreqEncerrDeRE(const s: string): TFreqEncerrDeRE;
var
  idx: TFreqEncerrDeRE;
begin
  for idx := Low(TFreqEncerrDeREArrayStrings) to High(TFreqEncerrDeREArrayStrings) do
  begin
    if (TFreqEncerrDeREArrayStrings[idx] = s) then
    begin
      Result := idx;
      Exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string invalido para TFreqEncerrDeRE: %s', [s]);
end;

function indCtaDeREToStr(const t: TIndCtaDeRE): string;
begin
  Result := TIndCtaDeREArrayStrings[t];
end;

function StrToindCtaDeRE(const s: string): TIndCtaDeRE;
var
  idx: TIndCtaDeRE;
begin
  for idx := Low(TIndCtaDeREArrayStrings) to High(TIndCtaDeREArrayStrings) do
  begin
    if (TIndCtaDeREArrayStrings[idx] = s) then
    begin
      Result := idx;
      Exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string invalido para TIndCtaDeRE: %s', [s]);
end;

function natCtaDeREToStr(const t: TNatCtaDeRE): string;
begin
  Result := TNatCtaDeREArrayStrings[t];
end;

function StrTonatCtaDeRE(const s: string): TNatCtaDeRE;
var
  idx: TNatCtaDeRE;
begin
  for idx := Low(TNatCtaDeREArrayStrings) to High(TNatCtaDeREArrayStrings) do
  begin
    if (TNatCtaDeREArrayStrings[idx] = s) then
    begin
      Result := idx;
      Exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string invalido para TNatCtaDeRE: %s', [s]);
end;

function codNatDeREToStr(const t: TCodNatDeRE): string;
begin
  Result := TCodNatDeREArrayStrings[t];
end;

function StrTocodNatDeRE(const s: string): TCodNatDeRE;
var
  idx: TCodNatDeRE;
begin
  for idx := Low(TCodNatDeREArrayStrings) to High(TCodNatDeREArrayStrings) do
  begin
    if (TCodNatDeREArrayStrings[idx] = s) then
    begin
      Result := idx;
      Exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string invalido para TCodNatDeRE: %s', [s]);
end;

function indTribISSDeREToStr(const t: TIndTribISSDeRE): string;
begin
  Result := TIndTribISSDeREArrayStrings[t];
end;

function StrToindTribISSDeRE(const s: string): TIndTribISSDeRE;
var
  idx: TIndTribISSDeRE;
begin
  for idx := Low(TIndTribISSDeREArrayStrings) to High(TIndTribISSDeREArrayStrings) do
  begin
    if (TIndTribISSDeREArrayStrings[idx] = s) then
    begin
      Result := idx;
      Exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string invalido para TIndTribISSDeRE: %s', [s]);
end;

function natSaldoDeREToStr(const t: TNatSaldoDeRE): string;
begin
  Result := TNatSaldoDeREArrayStrings[t];
end;

function StrTonatSaldoDeRE(const s: string): TNatSaldoDeRE;
var
  idx: TNatSaldoDeRE;
begin
  for idx := Low(TNatSaldoDeREArrayStrings) to High(TNatSaldoDeREArrayStrings) do
  begin
    if (TNatSaldoDeREArrayStrings[idx] = s) then
    begin
      Result := idx;
      Exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string invalido para TNatSaldoDeRE: %s', [s]);
end;

function finEvtDeREToStr(const t: TFinEvtDeRE): string;
begin
  Result := TFinEvtDeREArrayStrings[t];
end;

function StrTofinEvtDeRE(const s: string): TFinEvtDeRE;
var
  idx: TFinEvtDeRE;
begin
  for idx := Low(TFinEvtDeREArrayStrings) to High(TFinEvtDeREArrayStrings) do
  begin
    if (TFinEvtDeREArrayStrings[idx] = s) then
    begin
      Result := idx;
      Exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string invalido para TFinEvtDeRE: %s', [s]);
end;

function tpDFeDeREToStr(const t: TTpDFeDeRE): string;
begin
  Result := TTpDFeDeREArrayStrings[t];
end;

function StrTotpDFeDeRE(const s: string): TTpDFeDeRE;
var
  idx: TTpDFeDeRE;
begin
  for idx := Low(TTpDFeDeREArrayStrings) to High(TTpDFeDeREArrayStrings) do
  begin
    if (TTpDFeDeREArrayStrings[idx] = s) then
    begin
      Result := idx;
      Exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string invalido para TTpDFeDeRE: %s', [s]);
end;

function tpAtivDedDeREToStr(const t: TTpAtivDedDeRE): string;
begin
  Result := TTpAtivDedDeREArrayStrings[t];
end;

function StrTotpAtivDedDeRE(const s: string): TTpAtivDedDeRE;
var
  idx: TTpAtivDedDeRE;
begin
  for idx := Low(TTpAtivDedDeREArrayStrings) to High(TTpAtivDedDeREArrayStrings) do
  begin
    if (TTpAtivDedDeREArrayStrings[idx] = s) then
    begin
      Result := idx;
      Exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string invalido para TTpAtivDedDeRE: %s', [s]);
end;

end.
