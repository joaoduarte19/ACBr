{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2025 Daniel Simoes de Almeida               }
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

unit ACBrNFe.Conversao;

interface

uses
  SysUtils, StrUtils, Classes,
  ACBrBase,
  ACBrDFe.Conversao;

type
  TIndicadorPagamento = (ipVista, ipPrazo, ipOutras, ipNenhum);

const
  TIndicadorPagamentoArrayStrings: array[TIndicadorPagamento] of string = ('0', '1', '2', '');

function IndpagToStr(const t: TIndicadorPagamento): string; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS}'Use a função IndpagToStrEX'{$ENDIF};
function StrToIndpag(out ok: boolean; const s: string): TIndicadorPagamento; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS}'Use a função StrToIndpagEX'{$ENDIF};
function IndpagToStrEX(const t: TIndicadorPagamento): string;
function StrToIndpagEX(const s: string): TIndicadorPagamento;

type
  TPercentualTributos = (ptValorProdutos, ptValorNF, ptPersonalizado);

function PercTribToStr(const t: TPercentualTributos): string;
function StrToPercTrib(out ok: boolean; const s: string): TPercentualTributos;

type
  TDeterminacaoBaseIcms = (dbiMargemValorAgregado, dbiPauta, dbiPrecoTabelado, dbiValorOperacao, dbiNenhum);
  TDeterminacaoBaseIcmsST = (dbisPrecoTabelado, dbisListaNegativa,
                                dbisListaPositiva, dbisListaNeutra,
                                dbisMargemValorAgregado, dbisPauta,
                                dbisValordaOperacao);
  TMotivoDesoneracaoICMS = (mdiTaxi, mdiDeficienteFisico, mdiProdutorAgropecuario, mdiFrotistaLocadora, mdiDiplomaticoConsular,
                               mdiAmazoniaLivreComercio, mdiSuframa, mdiVendaOrgaosPublicos, mdiOutros, mdiDeficienteCondutor,
                               mdiDeficienteNaoCondutor, mdiOrgaoFomento, mdiOlimpiadaRio2016, mdiSolicitadoFisco );

function modBCToStr(const t: TDeterminacaoBaseIcms): string;
function modBCToStrTagPosText(const t: TDeterminacaoBaseIcms): string;
function StrTomodBC(out ok: boolean; const s: string): TDeterminacaoBaseIcms;
function modBCSTToStr(const t: TDeterminacaoBaseIcmsST): string;
function modBCSTToStrTagPosText(const t: TDeterminacaoBaseIcmsST): string;
function StrTomodBCST(out ok: boolean; const s: string): TDeterminacaoBaseIcmsST;
function motDesICMSToStr(const t: TMotivoDesoneracaoICMS): string;
function motDesICMSToStrTagPosText(const t: TMotivoDesoneracaoICMS): string;
function StrTomotDesICMS(out ok: boolean; const s: string): TMotivoDesoneracaoICMS;

type
  TCstIpi = (ipi00, ipi49, ipi50, ipi99, ipi01, ipi02, ipi03, ipi04, ipi05, ipi51, ipi52, ipi53, ipi54, ipi55);

function CSTIPIToStrTagPosText(const t: TCstIpi): string;
function CSTIPIToStr(const t: TCstIpi): string;
function StrToCSTIPI(out ok: boolean; const s: string): TCstIpi;

type
  TIndicadorProcesso = (ipSEFAZ, ipJusticaFederal, ipJusticaEstadual,
                           ipSecexRFB, ipCONFAZ, ipOutros);

function indProcToStr(const t: TIndicadorProcesso): string;
function indProcToDescrStr(const t: TIndicadorProcesso): string;
function StrToindProc(out ok: boolean; const s: string): TIndicadorProcesso;

type
  // TCRT  ==> migrar para o ACBrDFe.Conversao
  TCRT = (crtSimplesNacional, crtSimplesExcessoReceita, crtRegimeNormal, crtMEI);

function CRTToStr(const t: TCRT): string;
function StrToCRT(out ok: boolean; const s: string): TCRT;
function CRTTocRegTrib(const t: TCRT): TRegTrib;

type
  TIndicadorTotal = (itSomaTotalNFe, itNaoSomaTotalNFe );

function indTotToStr(const t: TIndicadorTotal): string;
function StrToindTot(out ok: boolean; const s: string): TIndicadorTotal;

type
  TECFModRef = (ECFModRefVazio, ECFModRef2B,ECFModRef2C,ECFModRef2D);

function ECFModRefToStr(const t:  TECFModRef ): string;
function StrToECFModRef(out ok: boolean; const s: string): TECFModRef;

type
  TISSQNcSitTrib  = ( ISSQNcSitTribVazio , ISSQNcSitTribNORMAL, ISSQNcSitTribRETIDA, ISSQNcSitTribSUBSTITUTA,ISSQNcSitTribISENTA);

function ISSQNcSitTribToStr(const t: TISSQNcSitTrib ): string;
function ISSQNcSitTribToStrTagPosText(const t: TISSQNcSitTrib ): string;
function StrToISSQNcSitTrib(out ok: boolean; const s: string) : TISSQNcSitTrib;

type
  TImprimeDescAcrescItem = (idaiSempre, idaiNunca, idaiComValor);
  TImprimirUnidQtdeValor = (iuComercial, iuTributavel, iuComercialETributavel);

  TDestinoOperacao = (doInterna, doInterestadual, doExterior);
  TConsumidorFinal = (cfNao, cfConsumidorFinal);
  TPresencaComprador = (pcNao, pcPresencial, pcInternet, pcTeleatendimento, pcEntregaDomicilio, pcPresencialForaEstabelecimento, pcOutros);

function DestinoOperacaoToStr(const t: TDestinoOperacao): string;
function StrToDestinoOperacao(out ok: boolean; const s: string): TDestinoOperacao;
function ConsumidorFinalToStr(const t: TConsumidorFinal): string;
function StrToConsumidorFinal(out ok: boolean; const s: string): TConsumidorFinal;
function PresencaCompradorToStr(const t: TPresencaComprador): string;
function StrToPresencaComprador(out ok: boolean; const s: string): TPresencaComprador;

type
  TTipoPagamento = (fpDinheiro, fpCheque, fpCartaoCredito, fpCartaoDebito, fpCreditoLoja,
                    fpValeAlimentacao, fpValeRefeicao, fpValePresente, fpValeCombustivel,
                    fpDuplicataMercantil, fpBoletoBancario, fpDepositoBancario,
                    fpPagamentoInstantaneo, fpTransfBancario, fpProgramaFidelidade,
                    fpSemPagamento, fpRegimeEspecial, fpOutro, fpPagamentoInstantaneoEstatico,
                    fpCreditoEmLojaPorDevolucao, fpFalhaHardware, fpPagamentoPosterior, fpPagInstantaneoPIXAutomatico,
                    fpTEFBookTransfer);

  TBandeiraCartao = (bcVisa, bcMasterCard, bcAmericanExpress, bcSorocred, bcDinersClub,
                        bcElo, bcHipercard, bcAura, bcCabal, bcAlelo, bcBanesCard,
                        bcCalCard, bcCredz, bcDiscover, bcGoodCard, bcGreenCard,
                        bcHiper, bcJcB, bcMais, bcMaxVan, bcPolicard, bcRedeCompras,
                        bcSodexo, bcValeCard, bcVerocheque, bcVR, bcTicket,
                        bcOutros);

function FormaPagamentoToStr(const t: TTipoPagamento): string;
function FormaPagamentoToDescricao(const t: TTipoPagamento): string; overload; deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS} 'Obsoleta: Use FormaPagamentoToDescricao(const t: TFormaPagamento; const xPag: String)'{$EndIf};
function FormaPagamentoToDescricao(const t: TTipoPagamento; const xPag: String): string; overload;
function StrToFormaPagamento(out ok: boolean; const s: string): TTipoPagamento;
function BandeiraCartaoToStr(const t: TBandeiraCartao): string;
function BandeiraCartaoToDescStr(const t: TBandeiraCartao): string;
function StrToBandeiraCartao(out ok: boolean; const s: string): TBandeiraCartao;

type
  TTipoViaTransp = (tvMaritima, tvFluvial, tvLacustre, tvAerea, tvPostal,
                       tvFerroviaria, tvRodoviaria, tvConduto, tvMeiosProprios,
                       tvEntradaSaidaFicta, tvCourier, tvEmMaos, tvPorReboque);

function TipoViaTranspToStr(const t: TTipoViaTransp ): string;
function StrToTipoViaTransp(out ok: boolean; const s: string): TTipoViaTransp;
function TipoViaTranspToDescricao(const t: TTipoViaTransp): string;

type
  TTipoIntermedio = (tiContaPropria, tiContaOrdem, tiEncomenda);
  TindISSRet = (iirSim, iirNao);
  TindISS = (iiExigivel, iiNaoIncidencia, iiIsencao, iiExportacao, iiImunidade, iiExigSuspDecisaoJudicial, iiExigSuspProcessoAdm);

function TipoIntermedioToStr(const t: TTipoIntermedio ): string;
function StrToTipoIntermedio(out ok: boolean; const s: string): TTipoIntermedio;
function TipoIntermedioToDescricao(const t: TTipoIntermedio ): string;
function indISSRetToStr(const t: TindISSRet ): string;
function StrToindISSRet(out ok: boolean; const s: string): TindISSRet;
function indISSToStr(const t: TindISS ): string;
function StrToindISS(out ok: boolean; const s: string): TindISS;
function indISSToStrTagPosText(const t: TindISS ): string;

type
  TTipoAutor = (taEmpresaEmitente, taEmpresaDestinataria, taEmpresa, taFisco,
                taRFB, taOutros, taEmpresaSucessora);

function TipoAutorToStr(const t: TTipoAutor ): string;
function StrToTipoAutor(out ok: boolean; const s: string): TTipoAutor;

type
  TIndOperacao = (ioConsultaCSC, ioNovoCSC, ioRevogaCSC);

function IndOperacaoToStr(const t: TIndOperacao ): string;
function StrToIndOperacao(out ok: boolean; const s: string): TIndOperacao;

type
  TForcarGeracaoTag = (fgtNunca, fgtSomenteProducao, fgtSomenteHomologacao, fgtSempre);

type
  TIndSomaPISST = (ispNenhum, ispPISSTNaoCompoe, ispPISSTCompoe);
  TIndSomaCOFINSST = (iscNenhum, iscCOFINSSTNaoCompoe, iscCOFINSSTCompoe);

function indSomaPISSTToStr(const t: TIndSomaPISST): String;
function StrToindSomaPISST(out ok: Boolean; const s: String): TIndSomaPISST;

function indSomaCOFINSSTToStr(const t: TIndSomaCOFINSST): String;
function StrToindSomaCOFINSST(out ok: Boolean; const s: String): TIndSomaCOFINSST;

type
  TStatusACBrNFe = (stIdle, stNFeStatusServico, stNFeRecepcao, stNFeRetRecepcao,
    stNFeConsulta, stNFeCancelamento, stNFeInutilizacao, stNFeRecibo,
    stNFeCadastro, stNFeEmail, stNFeCCe, stNFeEvento, stConsNFeDest,
    stDownloadNFe, stAdmCSCNFCe, stDistDFeInt, stEnvioWebService,
    stObterDFe);

  TInformacoesDePagamento = (eipNunca, eipAdicionais, eipQuadro);

  TVersaoDF = (ve200, ve300, ve310, ve400);

const
  TVersaoDFArrayStrings: array[TVersaoDF] of string = ('2.00', '3.00', '3.10',
    '4.00');
  TVersaoDFArrayDouble: array[TVersaoDF] of Double = (2.00, 3.00, 3.10, 4.00);

type
  TSchemaNFe = (schErro, schNfe, schcancNFe, schInutNFe, schEnvCCe,
                schEnvEventoCancNFe, schEnvConfRecebto, schEnvEPEC,
                schconsReciNFe, schconsSitNFe, schconsStatServ, schconsCad,
                schenvEvento, schconsNFeDest, schdownloadNFe, schretEnviNFe,
                schadmCscNFCe, schdistDFeInt, scheventoEPEC, schCancSubst,
                schPedProrrog1, schPedProrrog2, schCanPedProrrog1,
                schCanPedProrrog2, schManifDestConfirmacao,
                schManifDestCiencia, schManifDestDesconhecimento,
                schManifDestOperNaoRealizada, schCompEntrega, schCancCompEntrega,
                schAtorInteressadoNFe, schInsucessoEntregaNFe,
                schCancInsucessoEntregaNFe, schConcFinanceira,
                schCancConcFinanceira, schCancGenerico, schPagIntegLibCredPresAdq,
                schImporALCZFM, schPerecPerdaRouboFurtoTranspContratFornec,
                schFornecNaoRealizPagAntec, schSolicApropCredPres,
                schDestItemConsPessoal, schPerecPerdaRouboFurtoTranspContratAqu,
                schAceiteDebitoApuracaoNotaCredito, schImobilizacaoItem,
                schSolicApropCredCombustivel, schSolicApropCredBensServicos,
                schManifPedTransfCredIBSSucessao, schManifPedTransfCredCBSSucessao,
                schAtualizacaoDataPrevisaoEntrega, schevVincPgto,
                schnfceListagemChaves, schnfceDownloadXML);

const
  TSchemaNFeArrayStrings: array[TSchemaNFe] of string = ('Erro', 'Nfe',
    'cancNFe', 'InutNFe', 'EnvCCe', 'EnvEventoCancNFe', 'EnvConfRecebto',
    'EnvEPEC', 'consReciNFe', 'consSitNFe', 'consStatServ', 'consCad',
    'envEvento', 'consNFeDest', 'downloadNFe', 'retEnviNFe', 'admCscNFCe',
    'distDFeInt', 'eventoEPEC', 'CancSubst', 'PedProrrog1', 'PedProrrog2',
    'CanPedProrrog1', 'CanPedProrrog2', 'ManifDestConfirmacao',
    'ManifDestCiencia', 'ManifDestDesconhecimento', 'ManifDestOperNaoRealizada',
    'CompEntrega', 'CancCompEntrega', 'AtorInteressadoNFe',
    'InsucessoEntrega', 'CancInsucessoEntrega', 'ConcFinanceira',
    'CancConcFinanceira', 'CancGenerico', 'PagIntegLibCredPresAdq',
    'ImporALCZFM', 'PerecPerdaRouboFurtoTranspContratFornec',
    'FornecNaoRealizPagAntec', 'SolicApropCredPres', 'DestItemConsPessoal',
    'PerecPerdaRouboFurtoTranspContratAqu',
    'AceiteDebitoApuracaoNotaCredito', 'ImobilizacaoItem',
    'SolicApropCredCombustivel', 'SolicApropCredBensServicos',
    'ManifPedTransfCredIBSSucessao', 'ManifPedTransfCredCBSSucessao',
    'AtualizacaoDataPrevisaoEntrega', 'evVincPgto',
    'nfceListagemChaves', 'nfceDownloadXML');

  TEventoArrayStrings: array[TSchemaNFe] of string = ('', '', 'e110111', '',
    'e110110', '', '', 'e110140', '', '', '', '', '', '', '', '', '', '', '',
    'e110112', 'e111500', 'e111501', 'e111502', 'e111503', 'e210200', 'e210210',
    'e210220', 'e210240', 'e110130', 'e110131', 'e110150', 'e110192', 'e110193',
    'e110750', 'e110751', 'e110001', 'e112110', 'e112120', 'e112130', 'e112140',
    'e211110', 'e211120', 'e211124', 'e211128', 'e211130', 'e211140', 'e211150',
    'e212110', 'e212120', 'e112150', 'e110300', '', '');

type
  TLayOut = (LayNfeRecepcao, LayNfeRetRecepcao, LayNfeCancelamento,
    LayNfeInutilizacao, LayNfeConsulta, LayNfeStatusServico,
    LayNfeCadastro, LayNFeCCe, LayNFeEvento, LayNFeEventoAN, LayNFeConsNFeDest,
    LayNFeDownloadNFe, LayNfeAutorizacao, LayNfeRetAutorizacao,
    LayAdministrarCSCNFCe, LayDistDFeInt, LayNFCeEPEC, LayNFeURLQRCode,
    LayURLConsultaNFe, LayURLConsultaNFCe, LayNFCeListagemChaves, LayNFCeDownloadXML);

const
  TLayOutArrayStrings: array[TLayOut] of string = ('NfeRecepcao',
    'NfeRetRecepcao', 'NfeCancelamento', 'NfeInutilizacao',
    'NfeConsultaProtocolo', 'NfeStatusServico', 'NfeConsultaCadastro',
    'RecepcaoEvento', 'RecepcaoEvento', 'RecepcaoEvento', 'NfeConsultaDest',
    'NfeDownloadNF', 'NfeAutorizacao', 'NfeRetAutorizacao', 'AdministrarCSCNFCe',
    'NFeDistribuicaoDFe', 'EventoEPEC', 'URL-QRCode', 'URL-ConsultaNFe',
    'URL-ConsultaNFCe', 'NFCeListagemChaves', 'NFCeDownloadXML');

type
  TFinalidadeNFe = (fnNormal, fnComplementar, fnAjuste, fnDevolucao, fnCredito,
                    fnDebito);

const
  TFinalidadeNFeArrayStrings: array[TFinalidadeNFe] of string = ('1', '2', '3',
    '4', '5', '6');

type
  TModeloDF = (moNFe, moNFCe);

const
  TModeloDFArrayStrings: array[TModeloDF] of string = ('55', '65');

type
  TIndicadorNFe = (inTodas, inSemManifestacaoComCiencia,
                      inSemManifestacaoSemCiencia);

const
  TIndicadorNFeArrayStrings: array[TIndicadorNFe] of string = ('0', '1', '2');

type
  TVersaoQrCode = (veqr000, veqr100, veqr200, veqr300);

const
  TVersaoQrCodeArrayStrings: array[TVersaoQrCode] of string = ('0', '1', '2',
    '3');
  TVersaoQrCodeArrayDouble: array[TVersaoQrCode] of Double = (0, 1.00, 2.00,
    3.00);

type
  TTipoOperacao = (toVendaConcessionaria, toFaturamentoDireto, toVendaDireta,
                      toOutros);

const
  TTipoOperacaoArrayStrings: array[TTipoOperacao] of string = ('1', '2', '3',
    '0');
  TTipoOperacaoDescArrayStrings: array[TTipoOperacao]
    of string = ('1-VENDA CONCESSIONÁRIA', '2-FAT. DIRETO CONS. FINAL',
      '3-VENDA DIRETA', '0-OUTROS');

type
  TCondicaoVeiculo = (cvAcabado, cvInacabado, cvSemiAcabado);

const
  TCondicaoVeiculoArrayStrings: array[TCondicaoVeiculo] of string = ('1', '2',
    '3');
  TCondicaoVeiculoDescArrayStrings: array[TCondicaoVeiculo]
     of string = ('1-ACABADO', '2-INACABADO', '3-SEMI-ACABADO');

type
  TTipoArma = (taUsoPermitido, taUsoRestrito);

const
  TTipoArmaArrayStrings: array[TTipoArma] of string = ('0', '1');
  TTipoArmaDescArrayStrings: array[TTipoArma] of string = ('0-USO PERMITIDO',
    '1-USO RESTRITO');

type
  TIndEscala = (ieRelevante, ieNaoRelevante, ieNenhum);

const
  TIndEscalaArrayStrings: array[TIndEscala] of string = ('S', 'N', '');

type
  TModalidadeFrete = (mfContaEmitente, mfContaDestinatario, mfContaTerceiros,
                         mfProprioRemetente, mfProprioDestinatario, mfSemFrete);

const
  TModalidadeFreteArrayStrings: array[TModalidadeFrete] of string = ('0', '1',
    '2', '3', '4', '9');

type
  TAutorizacao = (taNaoPermite, taPermite, taNaoInformar);

const
  TAutorizacaoArrayStrings: array[TAutorizacao] of string = ('0', '1', '');

type
  TindIntermed = (iiSemOperacao, iiOperacaoSemIntermediador,
                  iiOperacaoComIntermediador);

const
  TindIntermedArrayStrings: array[TindIntermed] of string = ('', '0', '1');

type
  TtpAto = (taNenhum, taTermoAcordo, taRegimeEspecial, taAutorizacaoEspecifica,
            taAjusteSNIEF, taConvenioICMS);

const
  TtpAtoArrayStrings: array[TtpAto] of string = ('', '08', '10', '12', '14',
    '15');

type
  TindImport = (iiNacional, iiImportado);

const
  TindImportArrayStrings: array[TindImport] of string = ('0', '1');

type
  TmotRedAdRem = (motTranspColetivo, motOutros);

const
  TmotRedAdRemArrayStrings: array[TmotRedAdRem] of string = ('1', '9');

type
  TtpMotivo = (tmNaoEncontrado, tmRecusa, tmInexistente, tmOutro);

const
  TtpMotivoArrayStrings: array[TtpMotivo] of string = ('1', '2', '3', '4');

type
  TtpGuia = (tpgNenhum, tpgGTA, tpgTTA, tpgDTA, tpgATV, tpgPTV, tpgGTV, tpgGuiaFlorestal);

const
  TtpGuiaArrayStrings: array[TtpGuia] of string = ('', '1', '2', '3', '4', '5', '6', '7');

// Reforma Tributária
type
  TtpNFCredito = (tcNenhum, tcMultaJuros, tcApropriacaoCreditoPresumido, tcRetorno,
                  tcReducaoValores, tcTransferenciaCreditoSucessao,
                  tcRetornoRecusaParcial);

const
  TtpNFCreditoArrayStrings: array[TtpNFCredito] of string = ('', '01', '02', '03',
    '04', '05', '06');

{
  Declaração das funções de conversão
}
function StrToTpEventoNFe(out ok: boolean; const s: string): TACBrTipoEvento;

function LayOutToServico(const t: TLayOut): String;
function ServicoToLayOut(out ok: Boolean; const s: String): TLayOut;

function LayOutToSchema(const t: TLayOut): TSchemaNFe;

function SchemaNFeToStr(const t: TSchemaNFe): String;
function StrToSchemaNFe(const s: String): TSchemaNFe;
function SchemaEventoToStr(const t: TSchemaNFe): String;

function FinNFeToStr(const t: TFinalidadeNFe): String;
function StrToFinNFe(out ok: Boolean; const s: String): TFinalidadeNFe;

function IndicadorNFeToStr(const t: TIndicadorNFe): String;
function StrToIndicadorNFe(out ok: Boolean; const s: String): TIndicadorNFe;

function VersaoQrCodeToStr(const t: TVersaoQrCode): String;
function StrToVersaoQrCode(out ok: Boolean; const s: String): TVersaoQrCode;
function VersaoQrCodeToDbl(const t: TVersaoQrCode): Real;

function ModeloDFToStr(const t: TModeloDF): String;
function StrToModeloDF(out ok: Boolean; const s: String): TModeloDF;
function ModeloDFToPrefixo(const t: TModeloDF): String;

function StrToVersaoDF(out ok: Boolean; const s: String): TVersaoDF;
function VersaoDFToStr(const t: TVersaoDF): String;

function DblToVersaoDF(out ok: Boolean; const d: Real): TVersaoDF;
function VersaoDFToDbl(const t: TVersaoDF): Real;

function tpOPToStr(const t: TTipoOperacao): string;
function StrTotpOP(out ok: boolean; const s: string): TTipoOperacao;

function condVeicToStr(const t: TCondicaoVeiculo): string;
function StrTocondVeic(out ok: boolean; const s: string): TCondicaoVeiculo;

function tpArmaToStr(const t: TTipoArma): string;
function StrTotpArma(out ok: boolean; const s: string): TTipoArma;

function VeiculosRestricaoStr( const iRestricao :Integer ): String;
function VeiculosCorDENATRANStr( const sCorDENATRAN : String ): String;
function VeiculosCondicaoStr( const condVeic: TCondicaoVeiculo ): String;
function VeiculosVinStr( const sVin: String ): String;
function VeiculosEspecieStr( const iEspecie : Integer ): String;
function VeiculosTipoStr( const iTipoVeic : Integer ): String;
function VeiculosCombustivelStr( const sTpComb : String ): String;
function VeiculosTipoOperStr( const TtpOP : TTipoOperacao ): String;

function ArmaTipoStr( const TtpArma : TTipoArma ): String;

function IndEscalaToStr(const t: TIndEscala): String;
function StrToIndEscala(out ok: Boolean; const s: String): TIndEscala;
function modFreteToStr(const t: TModalidadeFrete): string;
function StrTomodFrete(out ok: boolean; const s: string): TModalidadeFrete;
function modFreteToDesStr(const t: TModalidadeFrete; versao: TVersaoDF): string;

function AutorizacaoToStr(const t: TAutorizacao): string;
function StrToAutorizacao(out ok: boolean; const s: string): TAutorizacao;

function IndIntermedToStr(const t: TindIntermed): string;
function StrToIndIntermed(out ok: boolean; const s: string): TindIntermed;

function tpAtoToStr(const t: TtpAto): string;
function StrTotpAto(out ok: boolean; const s: string): TtpAto;

function indImportToStr(const t: TindImport): string;
function StrToindImport(out ok: boolean; const s: string): TindImport;

function motRedAdRemToStr(const t: TmotRedAdRem): string;
function StrTomotRedAdRem(out ok: boolean; const s: string): TmotRedAdRem;

function tpMotivoToStr(const t: TtpMotivo): string;
function StrTotpMotivo(out ok: boolean; const s: string): TtpMotivo;

function TtpGuiaToStr(const t: TtpGuia): string;
function StrToTtpGuia(const s: string): TtpGuia;

// Reforma Tributária
function tpNFCreditoToStr(const t: TtpNFCredito): string;
function StrTotpNFCredito(const s: string): TtpNFCredito;

implementation

uses
  typinfo;

function IndpagToStr(const t: TIndicadorPagamento): string;
begin
  Result := EnumeradoToStr(t, TIndicadorPagamentoArrayStrings, [ipVista, ipPrazo, ipOutras, ipNenhum]);
end;

function StrToIndpag(out ok: boolean; const s: string): TIndicadorPagamento;
begin
  Result := StrToEnumerado(ok, s, TIndicadorPagamentoArrayStrings, [ipVista, ipPrazo, ipOutras, ipNenhum]);
end;

function IndpagToStrEX(const t: TIndicadorPagamento): string;
begin
  Result := TIndicadorPagamentoArrayStrings[t];
end;

function StrToIndpagEX(const s: string): TIndicadorPagamento;
var
  idx: TIndicadorPagamento;
begin
  for idx:= Low(TIndicadorPagamentoArrayStrings) to High(TIndicadorPagamentoArrayStrings)do
  begin
    if(TIndicadorPagamentoArrayStrings[idx] = s)then
    begin
      Result := idx;
      Exit;
    end;
  end;
  raise EACBrException.CreateFmt('Valor string inválido para TIndicadorPagamento: %s', [s]);
end;

function PercTribToStr(const t: TPercentualTributos): string;
begin
  result := EnumeradoToStr(t, ['0', '1', '2'],
                              [ptValorProdutos, ptValorNF, ptPersonalizado]);
end;

function StrToPercTrib(out ok: boolean; const s: string): TPercentualTributos;
begin
  result := StrToEnumerado(ok, s, ['0', '1', '2'],
                                  [ptValorProdutos, ptValorNF, ptPersonalizado]);
end;

function modBCToStrTagPosText(const t: TDeterminacaoBaseIcms): string;
begin
  result := EnumeradoToStr(t, ['0 - Margem Valor Agregado (%)', '1 - Pauta (Valor)', '2 - Preço Tabelado Máx. (valor)', '3 - Valor da operação', ''],
    [dbiMargemValorAgregado, dbiPauta, dbiPrecoTabelado, dbiValorOperacao, dbiNenhum]);
end;

function modBCToStr(const t: TDeterminacaoBaseIcms): string;
begin
  result := EnumeradoToStr(t, ['0', '1', '2', '3', ''],
    [dbiMargemValorAgregado, dbiPauta, dbiPrecoTabelado, dbiValorOperacao, dbiNenhum]);
end;

function StrTomodBC(out ok: boolean; const s: string): TDeterminacaoBaseIcms;
begin
  result := StrToEnumerado(ok, s, ['0', '1', '2', '3', ''],
    [dbiMargemValorAgregado, dbiPauta, dbiPrecoTabelado, dbiValorOperacao, dbiNenhum]);
end;

function modBCSTToStrTagPosText(const t: TDeterminacaoBaseIcmsST): string;
begin
  result := EnumeradoToStr(t, ['0 - Preço tabelado ou máximo sugerido', '1 - Lista Negativa (valor)',
   '2 - Lista Positiva (valor)', '3 - Lista Neutra (valor)',
   '4 - Margem Valor Agregado (%)', '5 - Pauta (valor)', '6 - Valor da Operação', ''],
    [dbisPrecoTabelado, dbisListaNegativa, dbisListaPositiva, dbisListaNeutra,
     dbisMargemValorAgregado, dbisPauta, dbisValordaOperacao,
     TDeterminacaoBaseIcmsST(-1)]);
end;

function modBCSTToStr(const t: TDeterminacaoBaseIcmsST): string;
begin
  result := EnumeradoToStr(t, ['0', '1', '2', '3', '4', '5', '6', ''],
    [dbisPrecoTabelado, dbisListaNegativa, dbisListaPositiva, dbisListaNeutra,
     dbisMargemValorAgregado, dbisPauta, dbisValordaOperacao,
     TDeterminacaoBaseIcmsST(-1)]);
end;

function StrTomodBCST(out ok: boolean; const s: string): TDeterminacaoBaseIcmsST;
begin
  result := StrToEnumerado(ok, s, ['0', '1', '2', '3', '4', '5', '6', ''],
    [dbisPrecoTabelado, dbisListaNegativa, dbisListaPositiva, dbisListaNeutra,
     dbisMargemValorAgregado, dbisPauta, dbisValordaOperacao,
     TDeterminacaoBaseIcmsST(-1)]);
end;

function motDesICMSToStr(const t: TMotivoDesoneracaoICMS): string;
begin
  result := EnumeradoToStr(t, ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10',
                               '11', '12', '16', '90', ''],
    [mdiTaxi, mdiDeficienteFisico, mdiProdutorAgropecuario, mdiFrotistaLocadora,
     mdiDiplomaticoConsular, mdiAmazoniaLivreComercio, mdiSuframa, mdiVendaOrgaosPublicos,
     mdiOutros, mdiDeficienteCondutor, mdiDeficienteNaoCondutor, mdiOrgaoFomento,
     mdiOlimpiadaRio2016, mdiSolicitadoFisco,
     TMotivoDesoneracaoICMS(-1)]);
end;

function StrTomotDesICMS(out ok: boolean; const s: string): TMotivoDesoneracaoICMS;
begin
  result := StrToEnumerado(ok, s, ['1', '2', '3', '4', '5', '6', '7', '8', '9',
                                   '10', '11', '12', '16', '90', ''],
    [mdiTaxi, mdiDeficienteFisico, mdiProdutorAgropecuario, mdiFrotistaLocadora,
     mdiDiplomaticoConsular, mdiAmazoniaLivreComercio, mdiSuframa, mdiVendaOrgaosPublicos,
     mdiOutros, mdiDeficienteCondutor, mdiDeficienteNaoCondutor, mdiOrgaoFomento,
     mdiOlimpiadaRio2016, mdiSolicitadoFisco,
     TMotivoDesoneracaoICMS(-1)]);
end;

function motDesICMSToStrTagPosText(const t: TMotivoDesoneracaoICMS): string;
begin
result := EnumeradoToStr(t, ['1 – Táxi', '2 – Deficiente Físico', '3 – Produtor Agropecuário',
  '4 – Frotista/Locadora', '5 – Diplomático/Consular', '6 - Utilit./Motos da Am./Áreas Livre Com.',
  '7 – SUFRAMA', '8 – Venda a Orgãos Publicos', '9 – Outros', '10 – Deficiente Condutor',
  '11 – Deficiente não Condutor', '12 - Orgão Fomento', '16 - Olimpiadas Rio 2016',
  '90 - Solicitado pelo Fisco', ''],
  [mdiTaxi, mdiDeficienteFisico, mdiProdutorAgropecuario, mdiFrotistaLocadora,
   mdiDiplomaticoConsular, mdiAmazoniaLivreComercio, mdiSuframa, mdiVendaOrgaosPublicos,
   mdiOutros, mdiDeficienteCondutor, mdiDeficienteNaoCondutor, mdiOrgaoFomento,
   mdiOlimpiadaRio2016, mdiSolicitadoFisco,
   TMotivoDesoneracaoICMS(-1)]);
end;

function CSTIPIToStr(const t: TCstIpi): string;
begin
  result := EnumeradoToStr(t, ['00', '49', '50', '99', '01', '02', '03', '04', '05', '51', '52', '53', '54', '55'],
    [ipi00, ipi49, ipi50, ipi99, ipi01, ipi02, ipi03, ipi04, ipi05, ipi51, ipi52, ipi53, ipi54, ipi55]);
end;

function StrToCSTIPI(out ok: boolean; const s: string): TCstIpi;
begin
  result := StrToEnumerado(ok, s, ['00', '49', '50', '99', '01', '02', '03', '04', '05', '51', '52', '53', '54', '55'],
    [ipi00, ipi49, ipi50, ipi99, ipi01, ipi02, ipi03, ipi04, ipi05, ipi51, ipi52, ipi53, ipi54, ipi55]);
end;

function CSTIPIToStrTagPosText(const t: TCstIpi): string;
begin
  case t of
    ipi00 : Result := '00 - Entrada com Recuperação de Crédito';
    ipi01 : Result := '01 - Entrada Tributável com Alíquota Zero';
    ipi02 : Result := '02 - Entrada Isenta';
    ipi03 : Result := '03 - Entrada Não-Tributada';
    ipi04 : Result := '04 - Entrada Imune';
    ipi05 : Result := '05 - Entrada com Suspensão';
    ipi49 : Result := '49 - Outras Entradas';
    ipi50 : Result := '50 - Saída Tributada';
    ipi51 : Result := '51 - Saída Tributável com Alíquota Zero';
    ipi52 : Result := '52 - Saída Isenta';
    ipi53 : Result := '53 - Saída Não-Tributada';
    ipi54 : Result := '54 - Saída Imune';
    ipi55 : Result := '55 - Saída com Suspensão';
    ipi99 : Result := '99 - Outras Saídas';
  end;
end;

function indProcToStr(const t: TIndicadorProcesso): string;
begin
  result := EnumeradoToStr(t, ['0', '1', '2', '3', '4', '9'],
  [ipSEFAZ, ipJusticaFederal, ipJusticaEstadual, ipSecexRFB, ipCONFAZ, ipOutros]);
end;

function indProcToDescrStr(const t: TIndicadorProcesso): string;
begin
  case t of
    ipSEFAZ           : result  := 'SEFAZ';
    ipJusticaFederal  : result  := 'JUSTIÇA FEDERAL';
    ipJusticaEstadual : result  := 'JUSTIÇA ESTADUAL';
    ipSecexRFB        : result  := 'SECEX / RFB';
    ipCONFAZ          : Result  := 'CONFAZ';
    ipOutros          : result  := 'OUTROS';
  end;
end;

function StrToindProc(out ok: boolean; const s: string): TIndicadorProcesso;
begin
  result := StrToEnumerado(ok, s, ['0', '1', '2', '3', '4', '9'],
  [ipSEFAZ, ipJusticaFederal, ipJusticaEstadual, ipSecexRFB, ipCONFAZ, ipOutros]);
end;

function CRTToStr(const t: TCRT): string;
begin
  result := EnumeradoToStr(t, ['','1', '2', '3', '4'],
    [crtRegimeNormal, crtSimplesNacional, crtSimplesExcessoReceita,
     crtRegimeNormal, crtMEI]);
end;

function StrToCRT(out ok: boolean; const s: string): TCRT;
begin
  result := StrToEnumerado(ok, s, ['','1', '2', '3', '4'],
    [crtRegimeNormal, crtSimplesNacional, crtSimplesExcessoReceita,
     crtRegimeNormal, crtMEI]);
end;

function CRTTocRegTrib(const t: TCRT): TRegTrib;
begin
  if T = crtSimplesNacional then
    Result := RTSimplesNacional
  else
    Result := RTRegimeNormal;
end;

function indTotToStr(const t: TIndicadorTotal): string;
begin
  result := EnumeradoToStr(t, ['0', '1'], [itNaoSomaTotalNFe, itSomaTotalNFe]);
end;

function StrToindTot(out ok: boolean; const s: string): TIndicadorTotal;
begin
  result := StrToEnumerado(ok, s, ['0', '1'], [itNaoSomaTotalNFe, itSomaTotalNFe]);
end;

function ECFModRefToStr(const t: TECFModRef): string;
begin
    result := EnumeradoToStr(t, ['', '2B', '2C','2D'],[ECFModRefVazio ,ECFModRef2B,ECFModRef2C,ECFModRef2D]);
end;

function StrToECFModRef(out ok: boolean; const s: string): TECFModRef;
begin
  result := StrToEnumerado(ok, s, ['', '2B', '2C','2D'],[ECFModRefVazio, ECFModRef2B,ECFModRef2C,ECFModRef2D]);
end;

function ISSQNcSitTribToStr(const t: TISSQNcSitTrib ): string;
begin
    result := EnumeradoToStr(t, ['','N','R','S','I'],[ISSQNcSitTribVazio , ISSQNcSitTribNORMAL, ISSQNcSitTribRETIDA, ISSQNcSitTribSUBSTITUTA,ISSQNcSitTribISENTA]);
end;

function StrToISSQNcSitTrib(out ok: boolean; const s: string) : TISSQNcSitTrib;
begin
  result := StrToEnumerado(ok, s, ['','N','R','S','I'],[ISSQNcSitTribVazio , ISSQNcSitTribNORMAL, ISSQNcSitTribRETIDA, ISSQNcSitTribSUBSTITUTA,ISSQNcSitTribISENTA]);
end;

function ISSQNcSitTribToStrTagPosText(const t: TISSQNcSitTrib): string;
begin
  result := EnumeradoToStr(t, ['','N - Normal','R - Retida','S - Substituta','I - Isenta'],
  [ISSQNcSitTribVazio , ISSQNcSitTribNORMAL, ISSQNcSitTribRETIDA, ISSQNcSitTribSUBSTITUTA,ISSQNcSitTribISENTA]);
end;

function DestinoOperacaoToStr(const t: TDestinoOperacao): string;
begin
  result := EnumeradoToStr(t, ['1', '2', '3'],
                              [doInterna, doInterestadual, doExterior]);
end;

function StrToDestinoOperacao(out ok: boolean; const s: string): TDestinoOperacao;
begin
  result := StrToEnumerado(ok, s, ['1', '2', '3'],
                                  [doInterna, doInterestadual, doExterior]);
end;

function ConsumidorFinalToStr(const t: TConsumidorFinal): string;
begin
  result := EnumeradoToStr(t, ['0', '1'],
                              [cfNao, cfConsumidorFinal]);
end;

function StrToConsumidorFinal(out ok: boolean; const s: string): TConsumidorFinal;
begin
  result := StrToEnumerado(ok, s, ['0', '1'],
                                  [cfNao, cfConsumidorFinal]);
end;

function PresencaCompradorToStr(const t: TPresencaComprador): string;
begin
  result := EnumeradoToStr(t, ['0', '1', '2', '3', '4', '5', '9'],
                              [pcNao, pcPresencial, pcInternet, pcTeleatendimento, pcEntregaDomicilio,
                              pcPresencialForaEstabelecimento, pcOutros]);
end;

function StrToPresencaComprador(out ok: boolean; const s: string): TPresencaComprador;
begin
  result := StrToEnumerado(ok, s, ['0', '1', '2', '3', '4', '5', '9'],
                                  [pcNao, pcPresencial, pcInternet, pcTeleatendimento, pcEntregaDomicilio,
                                  pcPresencialForaEstabelecimento, pcOutros]);
end;

function FormaPagamentoToStr(const t: TTipoPagamento): string;
begin
  result := EnumeradoToStr(t, ['01', '02', '03', '04', '05', '10', '11', '12',
                               '13', '14', '15', '16', '17', '18', '19', '90',
                               '98', '99', '20', '21', '22', '91', '23', '24'],
                              [fpDinheiro, fpCheque, fpCartaoCredito, fpCartaoDebito,
                               fpCreditoLoja, fpValeAlimentacao, fpValeRefeicao,
                               fpValePresente, fpValeCombustivel, fpDuplicataMercantil,
                               fpBoletoBancario, fpDepositoBancario,
                               fpPagamentoInstantaneo, fpTransfBancario,
                               fpProgramaFidelidade, fpSemPagamento, fpRegimeEspecial,
                               fpOutro, fpPagamentoInstantaneoEstatico,
                               fpCreditoEmLojaPorDevolucao, fpFalhaHardware,
                               fpPagamentoPosterior, fpPagInstantaneoPIXAutomatico,
                               fpTEFBookTransfer]);
end;

function FormaPagamentoToDescricao(const t: TTipoPagamento): string; overload;
begin
  Result := FormaPagamentoToDescricao(t, '');
end;

function FormaPagamentoToDescricao(const t: TTipoPagamento; const xPag: String): string; overload;
begin
  if (t = fpOutro) and (xPag <> '') then
    result := xPag
  else
    result := EnumeradoToStr(t,  ['Dinheiro', 'Cheque', 'Cartão de Crédito',
                                'Cartão de Débito', 'Cartão da Loja (Private Label)',
                                'Vale Alimentação', 'Vale Refeição', 'Vale Presente',
                                'Vale Combustível', 'Duplicata Mercantil',
                                'Boleto Bancário', 'Deposito Bancário',
                                'PIX - Dinâmico', 'Transferência Bancária',
                                'Programa Fidelidade', 'Sem Pagamento',
                                'Regime Especial NFF', 'Outro', 'PIX - Estático',
                                'Crédito em Loja', 'Falha de hardware do sistema emissor',
                                'Pagamento Posterior', 'PIX - Automatico',
                                'TEF - Book Transfer'],
                              [fpDinheiro, fpCheque, fpCartaoCredito, fpCartaoDebito,
                               fpCreditoLoja, fpValeAlimentacao, fpValeRefeicao,
                               fpValePresente, fpValeCombustivel, fpDuplicataMercantil,
                               fpBoletoBancario, fpDepositoBancario,
                               fpPagamentoInstantaneo, fpTransfBancario,
                               fpProgramaFidelidade, fpSemPagamento, fpRegimeEspecial,
                               fpOutro, fpPagamentoInstantaneoEstatico,
                               fpCreditoEmLojaPorDevolucao, fpFalhaHardware,
                               fpPagamentoPosterior, fpPagInstantaneoPIXAutomatico,
                               fpTEFBookTransfer]);
end;

function StrToFormaPagamento(out ok: boolean; const s: string): TTipoPagamento;
begin
  result := StrToEnumerado(ok, s, ['01', '02', '03', '04', '05', '10', '11', '12',
                                   '13', '14', '15', '16', '17', '18', '19', '90',
                                   '98', '99', '20', '21', '22', '91', '23', '24'],
                              [fpDinheiro, fpCheque, fpCartaoCredito, fpCartaoDebito,
                               fpCreditoLoja, fpValeAlimentacao, fpValeRefeicao,
                               fpValePresente, fpValeCombustivel, fpDuplicataMercantil,
                               fpBoletoBancario, fpDepositoBancario,
                               fpPagamentoInstantaneo, fpTransfBancario,
                               fpProgramaFidelidade, fpSemPagamento, fpRegimeEspecial,
                               fpOutro,fpPagamentoInstantaneoEstatico,
                               fpCreditoEmLojaPorDevolucao, fpFalhaHardware,
                               fpPagamentoPosterior, fpPagInstantaneoPIXAutomatico,
                               fpTEFBookTransfer]);
end;

function BandeiraCartaoToDescStr(const t: TBandeiraCartao): string;
begin
  case t of
    bcVisa:            Result := 'Visa';
    bcMasterCard:      Result := 'MasterCard';
    bcAmericanExpress: Result := 'AmericanExpress';
    bcSorocred:        Result := 'Sorocred';
    bcDinersClub:      Result := 'Diners Club';
    bcElo:             Result := 'Elo';
    bcHipercard:       Result := 'Hipercard';
    bcAura:            Result := 'Aura';
    bcCabal:           Result := 'Cabal';
    bcAlelo:           Result := 'Alelo';
    bcBanesCard:       Result := 'BanesCard';
    bcCalCard:         Result := 'CalCard';
    bcCredz:           Result := 'Credz';
    bcDiscover:        Result := 'Discover';
    bcGoodCard:        Result := 'GoodCard';
    bcGreenCard:       Result := 'GreenCard';
    bcHiper:           Result := 'Hiper';
    bcJcB:             Result := 'JcB';
    bcMais:            Result := 'Mais';
    bcMaxVan:          Result := 'MaxVan';
    bcPolicard:        Result := 'Policard';
    bcRedeCompras:     Result := 'RedeCompras';
    bcSodexo:          Result := 'Sodexo';
    bcValeCard:        Result := 'ValeCard';
    bcVerocheque:      Result := 'Verocheque';
    bcVR:              Result := 'VR';
    bcTicket:          Result := 'Ticket';
    bcOutros:          Result := 'Outros'
  end;
end;

function BandeiraCartaoToStr(const t: TBandeiraCartao): string;
begin
  result := EnumeradoToStr(t, ['01', '02', '03', '04', '05', '06', '07', '08',
                               '09', '10', '11', '12', '13', '14', '15', '16',
                               '17', '18', '19', '20', '21', '22', '23', '24',
                               '25', '26', '27', '99', ''],
                              [bcVisa, bcMasterCard, bcAmericanExpress, bcSorocred,
                               bcDinersClub, bcElo, bcHipercard, bcAura, bcCabal,
                               bcAlelo, bcBanesCard, bcCalCard, bcCredz, bcDiscover,
                               bcGoodCard, bcGreenCard, bcHiper, bcJcB, bcMais,
                               bcMaxVan, bcPolicard, bcRedeCompras, bcSodexo,
                               bcValeCard, bcVerocheque, bcVR, bcTicket, bcOutros,
                               TBandeiraCartao(-1)]);
end;

function StrToBandeiraCartao(out ok: boolean; const s: string): TBandeiraCartao;
begin
  result := StrToEnumerado(ok, s, ['01', '02', '03', '04', '05', '06', '07', '08',
                                   '09', '10', '11', '12', '13', '14', '15', '16',
                                   '17', '18', '19', '20', '21', '22', '23', '24',
                                   '25', '26', '27', '99', ''],
                                  [bcVisa, bcMasterCard, bcAmericanExpress, bcSorocred,
                                   bcDinersClub, bcElo, bcHipercard, bcAura, bcCabal,
                                   bcAlelo, bcBanesCard, bcCalCard, bcCredz, bcDiscover,
                                   bcGoodCard, bcGreenCard, bcHiper, bcJcB, bcMais,
                                   bcMaxVan, bcPolicard, bcRedeCompras, bcSodexo,
                                   bcValeCard, bcVerocheque, bcVR, bcTicket, bcOutros,
                                   TBandeiraCartao(-1)]);
end;

function TipoViaTranspToStr(const t: TTipoViaTransp ): string;
begin
  result := EnumeradoToStr(t, ['1', '2', '3', '4', '5', '6', '7', '8', '9',
                               '10', '11', '12', '13'],
                              [tvMaritima, tvFluvial, tvLacustre, tvAerea, tvPostal,
                               tvFerroviaria, tvRodoviaria, tvConduto, tvMeiosProprios,
                               tvEntradaSaidaFicta, tvCourier, tvEmMaos, tvPorReboque]);
end;

function StrToTipoViaTransp(out ok: boolean; const s: string): TTipoViaTransp;
begin
  result := StrToEnumerado(ok, s, ['1', '2', '3', '4', '5', '6', '7', '8', '9',
                                   '10', '11', '12', '13'],
                                  [tvMaritima, tvFluvial, tvLacustre, tvAerea, tvPostal,
                                   tvFerroviaria, tvRodoviaria, tvConduto, tvMeiosProprios,
                                   tvEntradaSaidaFicta, tvCourier, tvEmMaos, tvPorReboque]);
end;

function TipoViaTranspToDescricao(const t: TTipoViaTransp): string;
begin
  result := EnumeradoToStr(t, ['01 - Marítima',
                               '02 - Fluvial',
                               '03 - Lacustre',
                               '04 - Aérea',
                               '05 - Postal',
                               '06 - Ferroviária',
                               '07 - Rodoviária',
                               '08 - Conduto / Rede Transmissão',
                               '09 - Meios Próprios',
                               '10 - Entrada / Saída ficta',
                               '11 - Courier',
                               '12 - Em mãos',
                               '13 - Por reboque'],
                              [tvMaritima, tvFluvial, tvLacustre, tvAerea, tvPostal,
                               tvFerroviaria, tvRodoviaria, tvConduto, tvMeiosProprios,
                               tvEntradaSaidaFicta, tvCourier, tvEmMaos, tvPorReboque]);
end;

function TipoIntermedioToStr(const t: TTipoIntermedio ): string;
begin
  result := EnumeradoToStr(t, ['1', '2', '3'],
                              [tiContaPropria, tiContaOrdem, tiEncomenda]);
end;

function StrToTipoIntermedio(out ok: boolean; const s: string): TTipoIntermedio;
begin
  result := StrToEnumerado(ok, s, ['1', '2', '3'],
                                  [tiContaPropria, tiContaOrdem, tiEncomenda]);
end;

function TipoIntermedioToDescricao(const t: TTipoIntermedio): string;
begin
  result := EnumeradoToStr(t, ['1 - Importação por conta própria',
                               '2 - Importação por conta e ordem',
                               '3 - Importação por encomenda'],
                              [tiContaPropria, tiContaOrdem, tiEncomenda]);
end;

function indISSRetToStr(const t: TindISSRet ): string;
begin
  result := EnumeradoToStr(t, ['1', '2'],
                              [iirSim, iirNao]);
end;

function StrToindISSRet(out ok: boolean; const s: string): TindISSRet;
begin
  result := StrToEnumerado(ok, s, ['1', '2'],
                                  [iirSim, iirNao]);
end;

function indISSToStr(const t: TindISS ): string;
begin
  result := EnumeradoToStr(t, ['1', '2', '3', '4', '5', '6', '7'],
                              [iiExigivel, iiNaoIncidencia, iiIsencao, iiExportacao,
                               iiImunidade, iiExigSuspDecisaoJudicial, iiExigSuspProcessoAdm]);
end;

function StrToindISS(out ok: boolean; const s: string): TindISS;
begin
  result := StrToEnumerado(ok, s, ['1', '2', '3', '4', '5', '6', '7'],
                                  [iiExigivel, iiNaoIncidencia, iiIsencao, iiExportacao,
                                   iiImunidade, iiExigSuspDecisaoJudicial, iiExigSuspProcessoAdm]);
end;

function indISSToStrTagPosText(const t: TindISS): string;
begin
  result := EnumeradoToStr(t, ['1 - Exigível', '2 - Não incidência', '3 - Isenção', '4 - Exportação',
                               '5 - Imunidade', '6 - Exig. Susp. Dec. Jud.', '7 - Exig. Susp. Proc. Adm.'],
                              [iiExigivel, iiNaoIncidencia, iiIsencao, iiExportacao,
                               iiImunidade, iiExigSuspDecisaoJudicial, iiExigSuspProcessoAdm]);
end;

function TipoAutorToStr(const t: TTipoAutor ): string;
begin
  result := EnumeradoToStr(t, ['1', '2', '3', '5', '6', '9', '8'],
                              [taEmpresaEmitente, taEmpresaDestinataria,
                               taEmpresa, taFisco, taRFB, taOutros,
                               taEmpresaSucessora]);
end;

function StrToTipoAutor(out ok: boolean; const s: string): TTipoAutor;
begin
  result := StrToEnumerado(ok, s, ['1', '2', '3', '5', '6', '9', '8'],
                                  [taEmpresaEmitente, taEmpresaDestinataria,
                                   taEmpresa, taFisco, taRFB, taOutros,
                                   taEmpresaSucessora]);
end;

function IndOperacaoToStr(const t: TIndOperacao ): string;
begin
  result := EnumeradoToStr(t, ['1', '2', '3'],
                              [ioConsultaCSC, ioNovoCSC, ioRevogaCSC]);
end;

function StrToIndOperacao(out ok: boolean; const s: string): TIndOperacao;
begin
  result := StrToEnumerado(ok, s, ['1', '2', '3'],
                                  [ioConsultaCSC, ioNovoCSC, ioRevogaCSC]);
end;

function indSomaPISSTToStr(const t: TIndSomaPISST): String;
begin
  Result := EnumeradoToStr(t, ['', '0', '1'],
                                [ispNenhum, ispPISSTNaoCompoe, ispPISSTCompoe]);
end;

function StrToindSomaPISST(out ok: Boolean; const s: String): TIndSomaPISST;
begin
  Result := StrToEnumerado(ok, s, ['', '0', '1'],
                                [ispNenhum, ispPISSTNaoCompoe, ispPISSTCompoe]);
end;

function indSomaCOFINSSTToStr(const t: TIndSomaCOFINSST): String;
begin
  Result := EnumeradoToStr(t, ['', '0', '1'],
                          [iscNenhum, iscCOFINSSTNaoCompoe, iscCOFINSSTCompoe]);
end;

function StrToindSomaCOFINSST(out ok: Boolean; const s: String): TIndSomaCOFINSST;
begin
  Result := StrToEnumerado(ok, s, ['', '0', '1'],
                          [iscNenhum, iscCOFINSSTNaoCompoe, iscCOFINSSTCompoe]);
end;

function StrToTpEventoNFe(out ok: boolean; const s: string): TACBrTipoEvento;
begin
  Result := StrToEnumerado(ok, s,
            ['-99999', '110110', '110111', '110112', '110140', '111500',
             '111501', '111502', '111503', '210200', '210210', '210220',
             '210240', '610600', '610614', '790700', '990900', '990910',
             '110180', '610554', '610510', '610615', '610610', '110130',
             '110131', '110150', '610130', '610131', '610601', '110192',
             '110193', '610514', '610500', '110750', '110751', '510630',
             '110001', '112110', '112120', '112130', '112140', '211110',
             '211120', '211124', '211128', '211130', '211140', '211150',
             '212110', '212120', '112150', '110300', '110301'],
            [teNaoMapeado, teCCe, teCancelamento, teCancSubst, teEPECNFe,
             tePedProrrog1, tePedProrrog2, teCanPedProrrog1, teCanPedProrrog2,
             teManifDestConfirmacao, teManifDestCiencia,
             teManifDestDesconhecimento, teManifDestOperNaoRealizada,
             teRegistroCTe, teMDFeAutorizadoComCTe, teAverbacaoExportacao,
             teVistoriaSuframa, teConfInternalizacao, teComprEntrega,
             teRegPasAutMDFeComCte, teRegPasNfeProMDFe,
             teCancelamentoMDFeAutComCTe, teMDFeAutorizado,
             teComprEntregaNFe, teCancComprEntregaNFe, teAtorInteressadoNFe,
             teComprEntregaCTe, teCancComprEntregaCTe, teCTeCancelado,
             teInsucessoEntregaNFe, teCancInsucessoEntregaNFe,
             teRegPasNfeProMDFeCte, teRegistroPassagemNFe, teConcFinanceira,
             teCancConcFinanceira, teRegistroPassagemMDFe, teCancGenerico,
             tePagIntegLibCredPresAdq, teImporALCZFM,
             tePerecPerdaRouboFurtoTranspContratFornec, teFornecNaoRealizPagAntec,
             teSolicApropCredPres, teDestItemConsPessoal,
             tePerecPerdaRouboFurtoTranspContratAqu,
             teAceiteDebitoApuracaoNotaCredito, teImobilizacaoItem,
             teSolicApropCredCombustivel, teSolicApropCredBensServicos,
             teManifPedTransfCredIBSSucessao, teManifPedTransfCredCBSSucessao,
             teAtualizacaoDataPrevisaoEntrega, teVinculoPgto, teCancVinculoPgto]);
end;

function LayOutToServico(const t: TLayOut): String;
begin
  Result := EnumeradoToStr(t,
    ['NfeRecepcao', 'NfeRetRecepcao', 'NfeCancelamento', 'NfeInutilizacao',
     'NfeConsultaProtocolo', 'NfeStatusServico', 'NfeConsultaCadastro',
     'RecepcaoEvento', 'RecepcaoEvento', 'RecepcaoEvento', 'NfeConsultaDest',
     'NfeDownloadNF', 'NfeAutorizacao', 'NfeRetAutorizacao', 'AdministrarCSCNFCe',
     'NFeDistribuicaoDFe', 'EventoEPEC', 'NFCeListagemChaves', 'NFCeDownloadXML'],
    [ LayNfeRecepcao, LayNfeRetRecepcao, LayNfeCancelamento, LayNfeInutilizacao,
      LayNfeConsulta, LayNfeStatusServico, LayNfeCadastro,
      LayNFeCCe, LayNFeEvento, LayNFeEventoAN, LayNFeConsNFeDest,
      LayNFeDownloadNFe, LayNfeAutorizacao, LayNfeRetAutorizacao,
      LayAdministrarCSCNFCe, LayDistDFeInt, LayNFCeEPEC, LayNFCeListagemChaves, 
	  LayNFCeDownloadXML ] );
end;

function ServicoToLayOut(out ok: Boolean; const s: String): TLayOut;
begin
  Result := StrToEnumerado(ok, s,
  ['NfeRecepcao', 'NfeRetRecepcao', 'NfeCancelamento', 'NfeInutilizacao',
   'NfeConsultaProtocolo', 'NfeStatusServico', 'NfeConsultaCadastro',
   'RecepcaoEvento', 'RecepcaoEvento', 'RecepcaoEvento', 'NfeConsultaDest',
   'NfeDownloadNF', 'NfeAutorizacao', 'NfeRetAutorizacao', 'AdministrarCSCNFCe',
   'NFeDistribuicaoDFe', 'EventoEPEC', 'NFCeListagemChaves', 'NFCeDownloadXML'],
  [ LayNfeRecepcao, LayNfeRetRecepcao, LayNfeCancelamento, LayNfeInutilizacao,
    LayNfeConsulta, LayNfeStatusServico, LayNfeCadastro,
    LayNFeCCe, LayNFeEvento, LayNFeEventoAN, LayNFeConsNFeDest,
    LayNFeDownloadNFe, LayNfeAutorizacao, LayNfeRetAutorizacao,
    LayAdministrarCSCNFCe, LayDistDFeInt, LayNFCeEPEC, LayNFCeListagemChaves, 
	LayNFCeDownloadXML ] );
end;

function LayOutToSchema(const t: TLayOut): TSchemaNFe;
begin
  case t of
    LayNfeRecepcao:       Result := schNfe;
    LayNfeRetRecepcao:    Result := schconsReciNFe;
    LayNfeCancelamento:   Result := schcancNFe;
    LayNfeInutilizacao:   Result := schInutNFe;
    LayNfeConsulta:       Result := schconsSitNFe;
    LayNfeStatusServico:  Result := schconsStatServ;
    LayNfeCadastro:       Result := schconsCad;
    LayNFeCCe,
    LayNFeEvento,
    LayNFeEventoAN:       Result := schenvEvento;
    LayNFeConsNFeDest:    Result := schconsNFeDest;
    LayNFeDownloadNFe:    Result := schdownloadNFe;
    LayNfeAutorizacao:    Result := schNfe;
    LayNfeRetAutorizacao: Result := schretEnviNFe;
    LayAdministrarCSCNFCe: Result := schadmCscNFCe;
    LayDistDFeInt:        Result := schdistDFeInt;
    LayNFCeEPEC:          Result := scheventoEPEC;
    LayNFCeListagemChaves: Result := schnfceListagemChaves;
    LayNFCeDownloadXML:   Result := schnfceDownloadXML;
  else
    Result := schErro;
  end;
end;

function SchemaNFeToStr(const t: TSchemaNFe): String;
begin
  Result := GetEnumName(TypeInfo(TSchemaNFe), Integer( t ) );
  Result := copy(Result, 4, Length(Result)); // Remove prefixo "sch"
end;

function StrToSchemaNFe(const s: String): TSchemaNFe;
var
  P: Integer;
  SchemaStr: String;
  CodSchema: Integer;
begin
  P := pos('_',s);
  if p > 0 then
    SchemaStr := copy(s,1,P-1)
  else
    SchemaStr := s;

  if LeftStr(SchemaStr,3) <> 'sch' then
    SchemaStr := 'sch'+SchemaStr;

  CodSchema := GetEnumValue(TypeInfo(TSchemaNFe), SchemaStr );

  if CodSchema = -1 then
  begin
    raise Exception.Create(Format('"%s" não é um valor TSchemaNFe válido.',[SchemaStr]));
  end;

  Result := TSchemaNFe( CodSchema );
end;

function FinNFeToStr(const t: TFinalidadeNFe): String;
begin
  Result := EnumeradoToStr(t, ['1', '2', '3', '4', '5', '6'],
    [fnNormal, fnComplementar, fnAjuste, fnDevolucao, fnCredito, fnDebito]);
end;

function StrToFinNFe(out ok: Boolean; const s: String): TFinalidadeNFe;
begin
  Result := StrToEnumerado(ok, s, ['1', '2', '3', '4', '5', '6'],
    [fnNormal, fnComplementar, fnAjuste, fnDevolucao, fnCredito, fnDebito]);
end;

function IndicadorNFeToStr(const t: TIndicadorNFe): String;
begin
  Result := EnumeradoToStr(t, ['0', '1', '2'],
    [inTodas, inSemManifestacaoComCiencia, inSemManifestacaoSemCiencia]);
end;

function StrToIndicadorNFe(out ok: Boolean; const s: String): TIndicadorNFe;
begin
  Result := StrToEnumerado(ok, s, ['0', '1', '2'],
    [inTodas, inSemManifestacaoComCiencia, inSemManifestacaoSemCiencia]);
end;

function VersaoQrCodeToStr(const t: TVersaoQrCode): String;
begin
  Result := EnumeradoToStr(t, ['0', '1', '2', '3'],
    [veqr000, veqr100, veqr200, veqr300]);
end;

function StrToVersaoQrCode(out ok: Boolean; const s: String): TVersaoQrCode;
begin
  Result := StrToEnumerado(ok, s, ['0', '1', '2', '3'],
    [veqr000, veqr100, veqr200, veqr300]);
end;

function VersaoQrCodeToDbl(const t: TVersaoQrCode): Real;
begin
  case t of
    veqr000: Result := 0;
    veqr100: Result := 1;
    veqr200: Result := 2;
    veqr300: Result := 3;
  else
    Result := 0;
  end;
end;

function ModeloDFToStr(const t: TModeloDF): String;
begin
  Result := EnumeradoToStr(t, ['55', '65'], [moNFe, moNFCe]);
end;

function StrToModeloDF(out ok: Boolean; const s: String): TModeloDF;
begin
  Result := StrToEnumerado(ok, s, ['55', '65'], [moNFe, moNFCe]);
end;

function ModeloDFToPrefixo(const t: TModeloDF): String;
begin
  Case t of
    moNFCe: Result := 'NFCe';
  else
    Result := 'NFe';
  end;
end;

function StrToVersaoDF(out ok: Boolean; const s: String): TVersaoDF;
begin
  Result := StrToEnumerado(ok, s, ['2.00', '3.00', '3.10', '4.00'], [ve200, ve300, ve310, ve400]);
end;

function VersaoDFToStr(const t: TVersaoDF): String;
begin
  Result := EnumeradoToStr(t, ['2.00', '3.00', '3.10', '4.00'], [ve200, ve300, ve310, ve400]);
end;

 function DblToVersaoDF(out ok: Boolean; const d: Real): TVersaoDF;
 begin
   ok := True;

   if (d = 2.0) or (d < 3.0)  then
     Result := ve200
   else if (d >= 3.0) and (d < 3.1) then
     Result := ve300
   else if (d >= 3.10) and (d < 4) then
     Result := ve310
   else if (d >= 4) then
     Result := ve400
   else
   begin
     Result := ve310;
     ok := False;
   end;
 end;

 function VersaoDFToDbl(const t: TVersaoDF): Real;
 begin
   case t of
     ve200: Result := 2.00;
     ve300: Result := 3.00;
     ve310: Result := 3.10;
     ve400: Result := 4.00;
   else
     Result := 0;
   end;
 end;

 function tpOPToStr(const t: TTipoOperacao): string;
begin
  result := EnumeradoToStr(t, ['1', '2', '3', '0'], [toVendaConcessionaria, toFaturamentoDireto, toVendaDireta, toOutros]);
end;

function StrTotpOP(out ok: boolean; const s: string): TTipoOperacao;
begin
  result := StrToEnumerado(ok, s, ['1', '2', '3', '0'], [toVendaConcessionaria, toFaturamentoDireto, toVendaDireta, toOutros]);
end;

function condVeicToStr(const t: TCondicaoVeiculo): string;
begin
  result := EnumeradoToStr(t, ['1', '2', '3'], [cvAcabado, cvInacabado, cvSemiAcabado]);
end;

function StrTocondVeic(out ok: boolean; const s: string): TCondicaoVeiculo;
begin
  result := StrToEnumerado(ok, s, ['1', '2', '3'], [cvAcabado, cvInacabado, cvSemiAcabado]);
end;

function tpArmaToStr(const t: TTipoArma): string;
begin
  result := EnumeradoToStr(t, ['0', '1'], [taUsoPermitido, taUsoRestrito]);
end;

function StrTotpArma(out ok: boolean; const s: string): TTipoArma;
begin
  result := StrToEnumerado(ok, s, ['0', '1'], [taUsoPermitido, taUsoRestrito]);
end;

function VeiculosRestricaoStr( const iRestricao : Integer ): String;
begin
  case iRestricao of
    0: result := '0-NÃO HÁ';
    1: result := '1-ALIENAÇÃO FIDUCIÁRIA';
    2: result := '2-RESERVA DE DOMICÍLIO';
    3: result := '3-RESERVA DE DOMÍNIO';
    4: result := '4-PENHOR DE VEÍCULOS';
    9: result := '9-OUTRAS'
  else
    result := IntToStr(iRestricao)+ 'NÃO DEFINIDO';
  end;
end;

function VeiculosCorDENATRANStr( const sCorDENATRAN : String ): String;
begin
  case StrToIntDef( sCorDENATRAN, 0 ) of
     1: result := '01-AMARELO';
     2: result := '02-AZUL';
     3: result := '03-BEGE';
     4: result := '04-BRANCA';
     5: result := '05-CINZA';
     6: result := '06-DOURADA';
     7: result := '07-GRENÁ';
     8: result := '08-LARANJA';
     9: result := '09-MARROM';
    10: result := '10-PRATA';
    11: result := '11-PRETA';
    12: result := '12-ROSA';
    13: result := '13-ROXA';
    14: result := '14-VERDE';
    15: result := '15-VERMELHA';
    16: result := '16-FANTASIA'
  else
    result := sCorDENATRAN + 'NÃO DEFINIDA';
  end;
end;

function VeiculosCondicaoStr( const condVeic: TCondicaoVeiculo ): String;
begin
  case condVeic of
    cvAcabado     : result := '1-ACABADO';
    cvInacabado   : result := '2-INACABADO';
    cvSemiAcabado : result := '3-SEMI-ACABADO';
  end;
end;

function VeiculosVinStr( const sVin: String ): String;
begin
  // Enumerar Vim no futuro ?
  if sVIN = 'R' then
      result := 'R-REMARCADO'
  else
    if sVIN = 'N' then
      result:= 'N-NORMAL'
    else
      result := 'NÃO DEFINIDA';
end;

function VeiculosEspecieStr( const iEspecie : Integer ): String;
begin
  case iEspecie of
    1: result := '01-PASSAGEIRO';
    2: result := '02-CARGA';
    3: result := '03-MISTO';
    4: result := '04-CORRIDA';
    5: result := '05-TRAÇÃO';
    6: result := '06-ESPECIAL';
    7: result := '07-COLEÇÃO'
  else
      result := IntToStr(iEspecie ) + 'NÃO DEFINIDA';
  end;
end;

function VeiculosTipoStr( const iTipoVeic : Integer ): String;
begin
  case iTipoVeic of
     1: result := '01-BICICLETA';
     2: result := '02-CICLOMOTOR';
     3: result := '03-MOTONETA';
     4: result := '04-MOTOCICLETA';
     5: result := '05-TRICICLO';
     6: result := '06-AUTOMÓVEL';
     7: result := '07-MICROONIBUS';
     8: result := '08-ONIBUS';
     9: result := '09-BONDE';
    10: result := '10-REBOQUE';
    11: result := '11-SEMI-REBOQUE';
    12: result := '12-CHARRETE';
    13: result := '13-CAMIONETA';
    14: result := '14-CAMINHÃO';
    15: result := '15-CARROÇA';
    16: result := '16-CARRO DE MÃO';
    17: result := '17-CAMINHÃO TRATOR';
    18: result := '18-TRATOR DE RODAS';
    19: result := '19-TRATOR DE ESTEIRAS';
    20: result := '20-TRATOR MISTO';
    21: result := '21-QUADRICICLO';
    22: result := '22-CHASSI/PLATAFORMA';
    23: result := '23-CAMINHONETE';
    24: result := '24-SIDE-CAR';
    25: result := '25-UTILITÁRIO';
    26: result := '26-MOTOR-CASA'
  else
      result := IntToStr(iTipoVeic)+'NÃO DEFINIDO';
  end;
end;

function VeiculosCombustivelStr( const sTpComb : String ): String;
begin
  case StrToIntDef( stpComb, 0) of
     1: result := '01-ÁLCOOL';
     2: result := '02-GASOLINA';
     3: result := '03-DIESEL';
     4: result := '04-GASOGÊNIO';
     5: result := '05-GÁS METANO';
     6: result := '06-ELETRICO/F INTERNA';
     7: result := '07-ELETRICO/F EXTERNA';
     8: result := '08-GASOLINA/GNC';
     9: result := '09-ÁLCOOL/GNC';
    10: result := '10-DIESEL / GNC';
    11: result := '11-VIDE CAMPO OBSERVAÇÃO';
    12: result := '12-ÁLCOOL/GNV';
    13: result := '13-GASOLINA/GNV';
    14: result := '14-DIESEL/GNV';
    15: result := '15-GÁS NATURAL VEICULAR';
    16: result := '16-ÁLCOOL/GASOLINA';
    17: result := '17-GASOLINA/ÁLCOOL/GNV';
    18: result := '18-GASOLINA/ELÉTRICO';
    19: result := '19-GASOLINA/ÁLCOOL/ELÉTRICO';
    20: result := '20-GÁS/NATURAL/LIQUEFEITO';
    21: result := '21-DIESEL/ELÉTRICO';
    22: result := '22-HÍBRIDO';
    23: result := '23-HÍBRIDO PLUG-IN';
    24: result := '24-ELÉTRICO';
    25: result := '25-CÉLULA COMBUSTÍVEL';
    26: result := '26-HÍBRIDO/GÁS NATURAL VEICULAR';
    27: result := '27-ETANOL/ELÉTRICO';
  else
      result := stpComb +'NÃO DEFINIDO';
  end;
end;

function VeiculosTipoOperStr( const TtpOP : TTipoOperacao ): String;
begin
  case TtpOP of
    toVendaConcessionaria : result := '1-VENDA CONCESSIONÁRIA';
    toFaturamentoDireto   : result := '2-FAT. DIRETO CONS. FINAL';
    toVendaDireta         : result := '3-VENDA DIRETA';
    toOutros              : result := '0-OUTROS';
  end;
end;

function ArmaTipoStr( const TtpArma : TTipoArma ): String;
begin
  case TtpArma of
    taUsoPermitido: result := '0-USO PERMITIDO';
    taUsoRestrito : result := '1-USO RESTRITO';
  end;
end;

function IndEscalaToStr(const t: TIndEscala): String;
begin
  result := EnumeradoToStr(t, ['S', 'N', ''],
                              [ieRelevante, ieNaoRelevante, ieNenhum]);
end;

function StrToIndEscala(out ok: Boolean; const s: String): TIndEscala;
begin
  result := StrToEnumerado(ok, s, ['S', 'N', ''],
                                  [ieRelevante, ieNaoRelevante, ieNenhum]);
end;

function modFreteToStr(const t: TModalidadeFrete): string;
begin
  result := EnumeradoToStr(t, ['0', '1', '2', '3', '4', '9'],
    [mfContaEmitente, mfContaDestinatario, mfContaTerceiros, mfProprioRemetente, mfProprioDestinatario, mfSemFrete]);
end;

function StrTomodFrete(out ok: boolean; const s: string): TModalidadeFrete;
begin
  result := StrToEnumerado(ok, s, ['0', '1', '2',  '3', '4', '9'],
    [mfContaEmitente, mfContaDestinatario, mfContaTerceiros, mfProprioRemetente, mfProprioDestinatario, mfSemFrete]);
end;

function modFreteToDesStr(const t: TModalidadeFrete; versao: TVersaoDF): string;
begin
  case versao of
    ve200,
    ve300,
    ve310:
      case t  of
        mfContaEmitente       : result := '0 - EMITENTE';
        mfContaDestinatario   : result := '1 - DEST/REM';
        mfContaTerceiros      : result := '2 - TERCEIROS';
        mfProprioRemetente    : result := '3 - PROP/REMT';
        mfProprioDestinatario : result := '4 - PROP/DEST';
        mfSemFrete            : result := '9 - SEM FRETE';
      end;
    ve400:
      case t  of
        mfContaEmitente       : result := '0 - REMETENTE';
        mfContaDestinatario   : result := '1 - DESTINATARIO';
        mfContaTerceiros      : result := '2 - TERCEIROS';
        mfProprioRemetente    : result := '3 - PROP/REMT';
        mfProprioDestinatario : result := '4 - PROP/DEST';
        mfSemFrete            : result := '9 - SEM FRETE';
      end;
  end;
end;

function SchemaEventoToStr(const t: TSchemaNFe): String;
begin
  result := EnumeradoToStr(t, ['e110001',
                               'e110110', 'e110111', 'e110112', 'e110140',
                               'e111500', 'e111501', 'e111502', 'e111503',
                               'e210200', 'e210210', 'e210220', 'e210240',
                               'e110130', 'e110131', 'e110150', 'e110192',
                               'e110193', 'e110750', 'e110751', 'e112110',
                               'e112120', 'e112130', 'e112140', 'e211110',
                               'e211120', 'e211124', 'e211128', 'e211130',
                               'e211140', 'e211150', 'e212110', 'e212120',
                               'e112150', 'e110300'],
    [schCancGenerico,
     schEnvCCe, schcancNFe, schCancSubst, schEnvEPEC,
     schPedProrrog1, schPedProrrog2, schCanPedProrrog1, schCanPedProrrog2,
     schManifDestConfirmacao, schManifDestCiencia, schManifDestDesconhecimento,
     schManifDestOperNaoRealizada, schCompEntrega, schCancCompEntrega,
     schAtorInteressadoNFe, schInsucessoEntregaNFe, schCancInsucessoEntregaNFe,
     schConcFinanceira, schCancConcFinanceira, schPagIntegLibCredPresAdq,
     schImporALCZFM, schPerecPerdaRouboFurtoTranspContratFornec,
     schFornecNaoRealizPagAntec, schSolicApropCredPres, schDestItemConsPessoal,
     schPerecPerdaRouboFurtoTranspContratAqu, schAceiteDebitoApuracaoNotaCredito,
     schImobilizacaoItem, schSolicApropCredCombustivel, schSolicApropCredBensServicos,
     schManifPedTransfCredIBSSucessao, schManifPedTransfCredCBSSucessao,
     schAtualizacaoDataPrevisaoEntrega, schevVincPgto]);
end;

function AutorizacaoToStr(const t: TAutorizacao): string;
begin
  result := EnumeradoToStr(t, ['0', '1', ''],
                              [taNaoPermite, taPermite, taNaoInformar]);
end;

function StrToAutorizacao(out ok: boolean; const s: string): TAutorizacao;
begin
  result := StrToEnumerado(ok, s, ['0', '1', ''],
                                  [taNaoPermite, taPermite, taNaoInformar]);
end;

function IndIntermedToStr(const t: TindIntermed): string;
begin
  Result := EnumeradoToStr(t, ['', '0', '1'],
       [iiSemOperacao, iiOperacaoSemIntermediador, iiOperacaoComIntermediador]);
end;

function StrToIndIntermed(out ok: boolean; const s: string): TindIntermed;
begin
  Result := StrToEnumerado(ok, s, ['', '0', '1'],
       [iiSemOperacao, iiOperacaoSemIntermediador, iiOperacaoComIntermediador]);
end;

function tpAtoToStr(const t: TtpAto): string;
begin
  Result := EnumeradoToStr(t, ['', '08', '10', '12', '14', '15'],
       [taNenhum, taTermoAcordo, taRegimeEspecial, taAutorizacaoEspecifica,
            taAjusteSNIEF, taConvenioICMS]);
end;

function StrTotpAto(out ok: boolean; const s: string): TtpAto;
begin
  Result := StrToEnumerado(ok, s, ['', '08', '10', '12', '14', '15'],
       [taNenhum, taTermoAcordo, taRegimeEspecial, taAutorizacaoEspecifica,
            taAjusteSNIEF, taConvenioICMS]);
end;

function indImportToStr(const t: TindImport): string;
begin
  Result := EnumeradoToStr(t, ['0', '1'],
       [iiNacional, iiImportado]);
end;

function StrToindImport(out ok: boolean; const s: string): TindImport;
begin
  Result := StrToEnumerado(ok, s, ['0', '1'],
       [iiNacional, iiImportado]);
end;

function motRedAdRemToStr(const t: TmotRedAdRem): string;
begin
  Result := EnumeradoToStr(t, ['1', '9'],
       [motTranspColetivo, motOutros]);
end;

function StrTomotRedAdRem(out ok: boolean; const s: string): TmotRedAdRem;
begin
  Result := StrToEnumerado(ok, s, ['1', '9'],
       [motTranspColetivo, motOutros]);
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


function TtpGuiaToStr(const t: TtpGuia): string;
begin
  Result := TtpGuiaArrayStrings[t];
end;

function StrToTtpGuia(const s: String): TtpGuia;
var
  idx: TtpGuia;
begin
  for idx:= Low(TtpGuiaArrayStrings) to High(TtpGuiaArrayStrings) do
  begin
    if(TtpGuiaArrayStrings[idx] = s)then
    begin
      Result := idx;
      exit;
    end;
  end;
  raise EACBrException.CreateFmt('Valor string inválido para TtpGuia: %s', [s]);
end;

// Reforma Tributária
function tpNFCreditoToStr(const t: TtpNFCredito): string;
begin
  Result := TtpNFCreditoArrayStrings[t];
end;

function StrTotpNFCredito(const s: string): TtpNFCredito;
var
  idx: TtpNFCredito;
begin
  for idx:= Low(TtpNFCreditoArrayStrings) to High(TtpNFCreditoArrayStrings) do
  begin
    if(TtpNFCreditoArrayStrings[idx] = s)then
    begin
      Result := idx;
      exit;
    end;
  end;
  raise EACBrException.CreateFmt('Valor string inválido para TtpNFCredito: %s', [s]);
end;

initialization
  RegisterStrToTpEventoDFe(StrToTpEventoNFe, 'NFe');

end.

