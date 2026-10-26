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

unit ACBrCTe.Conversao;

interface

uses
  SysUtils, StrUtils, Classes,
  ACBrBase,
  ACBrDFe.Conversao;

type
  TTamanhoPapel = (tpA4, tpA4_2vias, tpA5);

type
  TModeloNF = (moNF011AAvulsa, moNFProdutor);
const
  TModeloNFArrayStrings: array[TModeloNF] of string = ('01','04');

function ModeloNFToStr(const t: TModeloNF): string;  deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS}'Use a função ModeloNFToStrEX'{$ENDIF};
function StrToModeloNF(out ok: boolean; const s: string): TModeloNF;  deprecated {$IfDef SUPPORTS_DEPRECATED_DETAILS}'Use a função StrToModeloNFEX'{$ENDIF};
function ModeloNFToStrEX(const t: TModeloNF): string;
function StrToModeloNFEX(const s: string): TModeloNF;

type
  TStatusACBrCTe = (stCTeIdle, stCTeStatusServico, stCTeRecepcao, stCTeRetRecepcao,
                    stCTeConsulta, stCTeCancelamento, stCTeInutilizacao,
                    stCTeRecibo, stCTeCadastro, stCTeEmail, stCTeCCe,
                    stCTeEvento, stCTeDistDFeInt, stCTeEnvioWebService);

  TVersaoCTe = (ve200, ve300, ve400);

const
  TVersaoCTeArrayStrings: array[TVersaoCTe] of string = ('2.00', '3.00', '4.00');
  TVersaoCTeArrayDouble: array[TVersaoCTe] of Double = (2.00, 3.00, 4.00);

type
  TSchemaCTe = (schErro, schCTe, schCTeOS, schGTVe, schcancCTe, schInutCTe,
                schEventoCTe, schCTeSimp,
                schconsReciCTe, schconsSitCTe, schconsStatServCTe, schconsCad,
                schcteModalAereo, schcteModalAquaviario, schcteModalDutoviario,
                schcteModalFerroviario, schcteModalRodoviario, schcteMultiModal,
                schevEPECCTe, schevCancCTe, schevRegMultimodal, schevCCeCTe,
                schdistDFeInt, schcteModalRodoviarioOS, schevPrestDesacordo,
                schevGTV, schevCECTe, schevCancCECTe, schevCancPrestDesacordo,
                schevIECTe, schevCancIECTe, schevVincPgto, schevCancVincPgto);

const
  TSchemaCTeArrayStrings: array[TSchemaCTe] of string = ('', '', '', '', '', '',
    '', '', '', '', '', '', '', '', '', '', '', '', 'evEPECCTe', 'evCancCTe',
    'evRegMultimodal', 'evCCeCTe', 'distDFeInt', 'cteModalRodoviarioOS',
    'evPrestDesacordo', 'evGTV', 'evCECTe', 'evCancCECTe',
    'evCancPrestDesacordo', 'evIECTe', 'evCancIECTe', 'evVincPgto',
    'evCancVincPgto');

type
  TLayOutCTe = (LayCTeRecepcao, LayCTeRetRecepcao, LayCTeCancelamento,
                LayCTeInutilizacao, LayCTeConsulta, LayCTeStatusServico,
                LayCTeCadastro, LayCTeEvento, LayCTeEventoAN,
                LayCTeDistDFeInt, LayCTeRecepcaoOS, LayCTeRecepcaoSinc,
                LayCTeRecepcaoGTVe, LayCTeURLQRCode, LayURLConsultaCTe,
                LayCTeRecepcaoSimp);
const
  TLayOutCTeArrayStrings: array[TLayOutCTe] of string = ('CTeRecepcao',
    'CTeRetRecepcao', 'CTeCancelamento', 'CTeInutilizacao',
    'CTeConsultaProtocolo', 'CTeStatusServico', 'CTeConsultaCadastro',
    'RecepcaoEvento', 'RecepcaoEventoAN', 'CTeDistribuicaoDFe', 'CTeRecepcaoOS',
    'CTeRecepcaoSinc', 'CTeRecepcaoGTVe', 'URL-QRCode', 'URL-ConsultaCTe',
    'CTeRecepcaoSimp');

type
  TModeloCTe = (moCTe, moGTVe, moCTeOS, moCTeSimp);

{
 O código correto do modelo CTe Simplificado é 57, mas foi alterado para 58
 para que o componente interprete corretamente o modelo de CTe
}
const
  TModeloCTeArrayStrings: array[TModeloCTe] of string = ('57', '64', '67', '57');

type
  TFormaPagamento = (fpPago, fpAPagar, fpOutros);

const
  TFormaPagamentoArrayStrings: array[TFormaPagamento] of string = ('0',
    '1', '2');
  TFormaPagamentoDescArrayStrings: array[TFormaPagamento]
     of string = ('PAGO', 'A PAGAR', 'OUTROS');

type
  TTipoCTe = (tcNormal, tcComplemento, tcAnulacao, tcSubstituto, tcGTVe,
                  tcCTeSimp, tcSubstCTeSimpl);

const
  TTipoCTeArrayStrings: array[TTipoCTe] of string = ('0', '1', '2', '3',
    '4', '5', '6');
  TTipoCTeDescArrayStrings: array[TTipoCTe] of string = ('NORMAL',
    'COMPLEMENTO', 'ANULAÇÃO', 'SUBSTITUTO', 'GTVe', 'CTeSimp',
    'SubstCTeSimpl');

type
  TTipoServico = (tsNormal, tsSubcontratacao, tsRedespacho, tsIntermediario,
                  tsMultimodal, tsTranspPessoas, tsTranspValores,
                  tsExcessoBagagem, tsGTV);

const
  TTipoServicoArrayStrings: array[TTipoServico] of string = ('0', '1',
    '2', '3', '4', '6', '7', '8', '9');
  TTipoServicoDescArrayStrings: array[TTipoServico]
    of string = ('NORMAL', 'SUBCONTRATAÇÃO', 'REDESPACHO',
      'REDESP. INTERMEDIÁRIO', 'VINC. A MULTIMODAL', 'TRANSP. PESSOAS',
      'TRANSP. VALORES', 'EXCESSO BAGAGEM', 'GTV');

type
  TRetira = (rtSim, rtNao);

const
  TRetiraArrayStrings: array[TRetira] of string = ('0', '1');

type
  TTomador = (tmRemetente, tmExpedidor, tmRecebedor, tmDestinatario,
                  tmOutros);

const
  TTomadorArrayStrings: array[TTomador] of string = ('0', '1', '2', '3',
    '4');
  TTomadorDescArrayStrings: array[TTomador] of string = ('REMETENTE',
    'EXPEDIDOR', 'RECEBEDOR', 'DESTINATARIO', 'OUTROS');

type
  TLotacao = (ltNao, ltSim);

const
  TLotacaoArrayStrings: array[TLotacao] of string = ('0', '1');

type
  TDirecao = (drNorte, drLeste, drSul, drOeste);

const
  TDirecaoArrayStrings: array[TDirecao] of string = ('N', 'L', 'S', 'O');

type
  TTipoTrafego = (ttProprio, ttMutuo, ttRodoferroviario, ttRodoviario);

const
  TTipoTrafegoArrayStrings: array[TTipoTrafego] of string = ('0', '1',
    '2', '3');

type
  TTipoDataPeriodo = (tdSemData, tdNaData, tdAteData, tdApartirData,
                          tdNoPeriodo, tdNaoInformado);

const
  TTipoDataPeriodoArrayStrings: array[TTipoDataPeriodo] of string = ('0',
    '1', '2', '3', '4', '-1');

type
  TTipoHorarioIntervalo = (thSemHorario, thNoHorario, thAteHorario,
                               thApartirHorario, thNoIntervalo, thNaoInformado);

const
  TTipoHorarioIntervaloArrayStrings: array[TTipoHorarioIntervalo]
     of string = ('0', '1', '2', '3', '4', '-1');

type
  TTipoDocumento = (tdDeclaracao, tdDutoviario, tdCFeSAT, tdNFCe, tdOutros);

const
  TTipoDocumentoArrayStrings: array[TTipoDocumento] of string = ('00',
    '10', '59', '65', '99');

type
  TTipoDocumentoAnterior = (daCTRC, daCTAC, daACT, daNF7, daNF27, daCAN,
                                daCTMC, daATRE, daDTA, daCAI, daCCPI, daCA,
                                daTIF, daBL, daOutros);

const
  TTipoDocumentoAnteriorArrayStrings: array[TTipoDocumentoAnterior]
     of string = ('00', '01', '02', '03', '04', '05', '06', '07', '08', '09',
       '10', '11', '12', '13', '99');

type
  TRspPagPedagio = (rpEmitente, rpRemetente, rpExpedidor, rpRecebedor,
                        rpDestinatario, rpTomadorServico);

const
  TRspPagPedagioArrayStrings: array[TRspPagPedagio] of string = ('0',
    '1', '2', '3', '4', '5');

type
  TTipoDispositivo = (tdCartaoMagnetico, tdTAG, tdTicket);

const
  TTipoDispositivoArrayStrings: array[TTipoDispositivo]
     of string = ('1', '2', '3');

type
  TTipoPropriedade = (tpProprio, tpTerceiro);

const
  TTipoPropriedadeArrayStrings: array[TTipoPropriedade] of string = ('P',
    'T');

type
  TTrafegoMutuo = (tmOrigem, tmDestino);

const
  TTrafegoMutuoArrayStrings: array[TTrafegoMutuo] of string = ('1', '2');

type
  TindNegociavel = (inNaoNegociavel, inNegociavel);

const
  TindNegociavelArrayStrings: array[TindNegociavel] of string = ('0', '1');

type
  TTipoVeiculo = (tvTracao, tvReboque);

const
  TTipoVeiculoArrayStrings: array[TTipoVeiculo] of string = ('0', '1');

type
  TRspSeg = (rsRemetente, rsExpedidor, rsRecebedor, rsDestinatario,
                 rsEmitenteCTe, rsTomadorServico);

const
  TRspSegArrayStrings: array[TRspSeg] of string = ('0', '1', '2', '3',
    '4', '5');
  TRspSegDescArrayStrings: array[TRspSeg] of string = ('REMETENTE',
    'EXPEDIDOR', 'RECEBEDOR', 'DESTINATARIO', 'EMITENTE', 'TOMADOR SERVICO');

type
  TEspecie = (teNumerario, teCheque, teMoeda, teOutros);

const
  TEspecieArrayStrings: array[TEspecie] of string = ('1', '2', '3', '4');

type
  TpInfManu = (imCEEAV, imAPCDEA, imSAC, imAPDENR, imAPQI, imGSR, imNR, imAPCC,
               imAAGA, imPI965, imPI966, imPI967, imPI968, imPI969, imPI970,
               imOUTRO);

const
  TpInfManuArrayStrings: array[TpInfManu] of string = ('01', '02', '03', '04',
    '05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15', '99');
  TpInfManuV2ArrayStrings: array[TpInfManu] of string = ('1', '2', '3', '4', '5',
    '6', '7', '8', '9', '', '', '', '', '', '', '99');

type
  TpUniMed = (umKG, umKGG, umLitros, umTI, umUnidades);

const
  TpUniMedArrayStrings: array[TpUniMed] of string = ('1', '2', '3', '4', '5');

type
  TtpFretamento = (tfNenhum, tfEventual, tpContinuo);

const
  TtpFretamentoArrayStrings: array[TtpFretamento] of string = ('', '1', '2');

type
  TtpComp = (tcCustodia, tcEmbarque, tcTempodeespera, tcMalote, tcAdValorem,
             tcOutros);

const
  TtpCompArrayStrings: array[TtpComp] of string = ('1', '2', '3', '4', '5', '6');

type
  TtpNumerario = (tnNacional, tnEstrangeiro);

const
  TtpNumerarioArrayStrings: array[TtpNumerario] of string = ('1', '2');

type
  TCRT = (crtNenhum, crtSimplesNacional, crtSimplesExcessoReceita,
          crtRegimeNormal, crtSimplesNacionalMEI);
const
  TCRTArrayStrings: array[TCRT] of string = ('', '1', '2', '3', '4');

type
  TtpMotivo = (tmNaoEncontrado, tmRecusa, tmInexistente, tmOutro);

const
  TtpMotivoArrayStrings: array[TtpMotivo] of string = ('1', '2', '3', '4');

type
  TtpPrest = (tpTotal, tpParcial);

const
  TtpPrestArrayStrings: array[TtpPrest] of string = ('1', '2');

type
  TclassDuto = (tcdNenhum, tcdGasoduto, tcdMineroduto, tcdOleoduto);

const
  TclassDutoArrayStrings: array[TclassDuto] of string = ('', '1', '2', '3');

type
  TtpContratacao = (tcNenhum, tcPontaPonto, tcCapacidadeEntrada, tcCapacidadeSaida);

const
  TtpContratacaoArrayStrings: array[TtpContratacao] of string = ('', '1', '2', '3');

{
  Declaração das funções de conversão
}
function StrToTpEventoCTe(out ok: boolean; const s: string): TACBrTipoEvento;

function LayOutToServico(const t: TLayOutCTe): String;
function ServicoToLayOut(out ok: Boolean; const s: String): TLayOutCTe;

function LayOutToSchema(const t: TLayOutCTe): TSchemaCTe;

function SchemaCTeToStr(const t: TSchemaCTe): String;
function StrToSchemaCTe(out ok: Boolean; const s: String): TSchemaCTe;

function StrToVersaoCTe(out ok: Boolean; const s: String): TVersaoCTe;
function VersaoCTeToStr(const t: TVersaoCTe): String;

function DblToVersaoCTe(out ok: Boolean; const d: Double): TVersaoCTe;
function VersaoCTeToDbl(const t: TVersaoCTe): Double;

function tpforPagToStr(const t: TFormaPagamento): string;
function tpforPagToStrText(const t: TFormaPagamento): string;
function StrTotpforPag(out ok: boolean; const s: string): TFormaPagamento;

function tpCTeToStr(const t: TTipoCTe): string;
function tpCTeToStrText(const t: TTipoCTe): string;
function StrTotpCTe(out ok: boolean; const s: string): TTipoCTe;

function TpServPagToStr(const t: TTipoServico): string;
function TpServToStrText(const t: TTipoServico): string;
function StrToTpServ(out ok: boolean; const s: string): TTipoServico;

function TpRetiraPagToStr(const t: TRetira): string;
function StrToTpRetira(out ok: boolean; const s: string): TRetira;

function TpTomadorPagToStr(const t: TTomador): string;
function TpTomadorToStr(const t: TTomador): String;
function TpTomadorToStrText(const t: TTomador): String;
function StrToTpTomador(out ok: boolean; const s: String ): TTomador;

function TpLotacaoToStr(const t: TLotacao): string;
function StrToTpLotacao(out ok: boolean; const s: String ): TLotacao;

function TpDirecaoToStr(const t: TDirecao): string;
function StrToTpDirecao(out ok: boolean; const s: string): TDirecao;

function TpTrafegoToStr(const t: TTipoTrafego): string;
function StrToTpTrafego(out ok: boolean; const s: string): TTipoTrafego;

function TpDataPeriodoToStr(const t: TTipoDataPeriodo): string;
function StrToTpDataPeriodo(out ok: boolean; const s: string): TTipoDataPeriodo;

function TpHorarioIntervaloToStr(const t: TTipoHorarioIntervalo): string;
function StrToTpHorarioIntervalo(out ok: boolean; const s: string): TTipoHorarioIntervalo;

function TpDocumentoToStr(const t: TTipoDocumento): string;
function StrToTpDocumento(out ok: boolean; const s: string): TTipoDocumento;

function TpDocumentoAnteriorToStr(const t: TTipoDocumentoAnterior): string;
function StrToTpDocumentoAnterior(out ok: boolean; const s: string): TTipoDocumentoAnterior;

function RspPagPedagioToStr(const t: TRspPagPedagio): string;
function StrToRspPagPedagio(out ok: boolean; const s: string): TRspPagPedagio;

function TpDispositivoToStr(const t: TTipoDispositivo): string;
function StrToTpDispositivo(out ok: boolean; const s: string): TTipoDispositivo;

function TpPropriedadeToStr(const t: TTipoPropriedade): string;
function StrToTpPropriedade(out ok: boolean; const s: string): TTipoPropriedade;

function TrafegoMutuoToStr(const t: TTrafegoMutuo): string;
function StrToTrafegoMutuo(out ok: boolean; const s: string): TTrafegoMutuo;

function indNegociavelToStr(const t: TindNegociavel ): string;
function StrToindNegociavel(out ok: boolean; const s: string): TindNegociavel;

function TpVeiculoToStr(const t: TTipoVeiculo): string;
function StrToTpVeiculo(out ok: boolean; const s: string): TTipoVeiculo;

function GetVersaoModalCTe(AVersaoDF: TVersaoCTe; AModal: TModal): string;

function ModeloCTeToStr(const t: TModeloCTe): String;
function StrToModeloCTe(out ok: Boolean; const s: String): TModeloCTe;
function ModeloCTeToPrefixo(const t: TModeloCTe): String;

function TEspecieToStr(const t: TEspecie): String;
function StrToTEspecie(out ok: Boolean; const s: String): TEspecie;

function TpRspSeguroToStr(const t: TRspSeg): String;
function TpRspSeguroToStrText(const t: TRspSeg): String;
function StrToTpRspSeguro(out ok: boolean; const s: String ): TRspSeg;

function TpInfManuToStr(const t: TpInfManu): string;
function StrToTpInfManu(out ok: boolean; const s: string): TpInfManu;

function TpInfManuToStrV2(const t: TpInfManu): string;
function StrToTpInfManuV2(out ok: boolean; const s: string): TpInfManu;

function UniMedToStr(const t: TpUniMed): String;
function StrToUniMed(out ok: Boolean; const s: String): TpUniMed;

function TpFretamentoToStr(const t: TtpFretamento): String;
function StrToTpFretamento(out ok: Boolean; const s: String): TtpFretamento;

function tpCompToStr(const t: TtpComp): String;
function StrTotpComp(out ok: Boolean; const s: String): TtpComp;

function tpNumerarioToStr(const t: TtpNumerario): String;
function StrTotpNumerario(out ok: Boolean; const s: String): TtpNumerario;

function CRTCTeToStr(const t: TCRT): string;
function StrToCRTCTe(out ok: boolean; const s: string): TCRT;

function tpMotivoToStr(const t: TtpMotivo): string;
function StrTotpMotivo(out ok: boolean; const s: string): TtpMotivo;
function tpMotivoToDesc(const t: TtpMotivo): string;

function tpPrestToStr(const t: TtpPrest): string;
function StrTotpPrest(out ok: boolean; const s: string): TtpPrest;

function classDutoToStr(const t: TclassDuto): string;
function StrToclassDuto(out ok: boolean; const s: string): TclassDuto;

function tpContratacaoToStr(const t: TtpContratacao): string;
function StrTotpContratacao(out ok: boolean; const s: string): TtpContratacao;

implementation

uses
  typinfo;

function ModeloNFToStr(const t: TModeloNF): string;
begin
  result := EnumeradoToStr(t, ['01','04'],
   [moNF011AAvulsa, moNFProdutor]);
end;

function StrToModeloNF(out ok: boolean; const s: string): TModeloNF;
begin
  result := StrToEnumerado(ok, s, ['01','04'],
   [moNF011AAvulsa, moNFProdutor]);
end;

function ModeloNFToStrEX(const t: TModeloNF): string;
begin
  Result := TModeloNFArrayStrings[t];
end;

function StrToModeloNFEX(const s: string): TModeloNF;
var
  idx: TModeloNF;
begin
  for idx:= Low(TModeloNFArrayStrings) to High(TModeloNFArrayStrings)do
  begin
    if(TModeloNFArrayStrings[idx] = s)then
    begin
      Result := idx;
      Exit;
    end;
  end;
  raise EACBrException.CreateFmt('Valor string inválido para TModeloNF: %s', [s]);
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

function tpCTeToStr(const t: TTipoCTe): string;
begin
  result := EnumeradoToStr(t, ['0', '1', '2', '3', '4', '5', '6'],
                   [tcNormal, tcComplemento, tcAnulacao, tcSubstituto, tcGTVe,
                    tcCTeSimp, tcSubstCTeSimpl]);
end;

function tpCTeToStrText(const t: TTipoCTe): string;
begin
  result := EnumeradoToStr(t, ['NORMAL', 'COMPLEMENTO', 'ANULAÇÃO', 'SUBSTITUTO',
                               'GTVe', 'CTe Simplificado',
                               'CTe Simplificado Substituto'],
                   [tcNormal, tcComplemento, tcAnulacao, tcSubstituto, tcGTVe,
                    tcCTeSimp, tcSubstCTeSimpl]);
end;

function StrTotpCTe(out ok: boolean; const s: string): TTipoCTe;
begin
  result := StrToEnumerado(ok, s, ['0', '1', '2', '3', '4', '5', '6'],
                   [tcNormal, tcComplemento, tcAnulacao, tcSubstituto, tcGTVe,
                    tcCTeSimp, tcSubstCTeSimpl]);
end;

function tpforPagToStr(const t: TFormaPagamento): string;
begin
  result := EnumeradoToStr(t, ['0','1', '2'],
                              [fpPago, fpAPagar, fpOutros]);
end;

function tpforPagToStrText(const t: TFormaPagamento): string;
begin
  result := EnumeradoToStr(t, ['PAGO','A PAGAR', 'OUTROS'],
                              [fpPago, fpAPagar, fpOutros]);
end;

function StrTotpforPag(out ok: boolean; const s: string): TFormaPagamento;
begin
  result := StrToEnumerado(ok, s, ['0', '1', '2'],
                                  [fpPago, fpAPagar, fpOutros]);
end;

function TpServPagToStr(const t: TTipoServico): string;
begin
  result := EnumeradoToStr(t, ['0','1', '2', '3', '4', '6', '7', '8', '9'],
                              [tsNormal, tsSubcontratacao, tsRedespacho,
                               tsIntermediario, tsMultimodal, tsTranspPessoas,
                               tsTranspValores, tsExcessoBagagem, tsGTV]);
end;

function TpServToStrText(const t: TTipoServico): string;
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

function StrToTpServ(out ok: boolean; const s: string): TTipoServico;
begin
  result := StrToEnumerado(ok, s, ['0', '1', '2', '3', '4', '6', '7', '8', '9'],
                                  [tsNormal, tsSubcontratacao, tsRedespacho,
                                   tsIntermediario, tsMultimodal,
                                   tsTranspPessoas, tsTranspValores,
                                   tsExcessoBagagem, tsGTV]);
end;

function TpRetiraPagToStr(const t: TRetira): string;
begin
  result := EnumeradoToStr(t, ['0','1'], [rtSim, rtNao]);
end;

function StrToTpRetira(out ok: boolean; const s: string): TRetira;
begin
  result := StrToEnumerado(ok, s, ['0', '1'], [rtSim, rtNao]);
end;

function TpTomadorPagToStr(const t: TTomador): string;
begin
  result := EnumeradoToStr(t, ['0','1', '2', '3', '4'],
             [tmRemetente, tmExpedidor, tmRecebedor, tmDestinatario, tmOutros]);
end;

function TpTomadorToStr(const t: TTomador): String;
begin
  result := EnumeradoToStr(t, ['0', '1', '2', '3', '4'],
             [tmRemetente, tmExpedidor, tmRecebedor, tmDestinatario, tmOutros]);
end;

function TpTomadorToStrText(const t: TTomador): String;
begin
  result := EnumeradoToStr(t, ['REMETENTE', 'EXPEDIDOR', 'RECEBEDOR',
                               'DESTINATARIO', 'OUTROS'],
             [tmRemetente, tmExpedidor, tmRecebedor, tmDestinatario, tmOutros]);
end;

function TpLotacaoToStr(const t: TLotacao): string;
begin
  result := EnumeradoToStr(t, ['0','1'], [ltNao, ltSim]);
end;

function StrToTpTomador(out ok: boolean; const s: String ): TTomador;
begin
  result := StrToEnumerado(ok, s, ['0', '1', '2', '3', '4'],
             [tmRemetente, tmExpedidor, tmRecebedor, tmDestinatario, tmOutros]);
end;

function StrToTpLotacao(out ok: boolean; const s: String ): TLotacao;
begin
  result := StrToEnumerado(ok, s, ['0', '1'], [ltNao, ltSim]);
end;

function TpDirecaoToStr(const t: TDirecao): string;
begin
  result := EnumeradoToStr(t, ['N','L','S','O'],
                              [drNorte , drLeste, drSul, drOeste]);
end;

function StrToTpDirecao(out ok: boolean; const s: string): TDirecao;
begin
  result := StrToEnumerado(ok, s, ['N','L','S','O'],
                                  [drNorte , drLeste, drSul, drOeste]);
end;

function TpTrafegoToStr(const t: TTipoTrafego): string;
begin
  result := EnumeradoToStr(t, ['0','1','2','3'],
                        [ttProprio , ttMutuo, ttRodoferroviario, ttRodoviario]);
end;

function StrToTpTrafego(out ok: boolean; const s: string): TTipoTrafego;
begin
  result := StrToEnumerado(ok, s, ['0','1','2','3'],
                        [ttProprio , ttMutuo, ttRodoferroviario, ttRodoviario]);
end;

function TpDataPeriodoToStr(const t: TTipoDataPeriodo): string;
begin
  result := EnumeradoToStr(t, ['0','1','2','3','4','-1'],
                              [tdSemData, tdNaData, tdAteData, tdApartirData,
                               tdNoPeriodo, tdNaoInformado]);
end;

function StrToTpDataPeriodo(out ok: boolean; const s: string): TTipoDataPeriodo;
begin
  result := StrToEnumerado(ok, s, ['0','1','2','3','4','-1'],
                                  [tdSemData, tdNaData, tdAteData, tdApartirData,
                                   tdNoPeriodo, tdNaoInformado]);
end;

function TpHorarioIntervaloToStr(const t: TTipoHorarioIntervalo): string;
begin
  result := EnumeradoToStr(t, ['0','1','2','3','4','-1'],
                              [thSemHorario, thNoHorario, thAteHorario,
                               thApartirHorario, thNoIntervalo, thNaoInformado]);
end;

function StrToTpHorarioIntervalo(out ok: boolean; const s: string): TTipoHorarioIntervalo;
begin
  result := StrToEnumerado(ok, s, ['0','1','2','3','4','-1'],
                                  [thSemHorario, thNoHorario, thAteHorario,
                                   thApartirHorario, thNoIntervalo, thNaoInformado]);
end;

function TpDocumentoToStr(const t: TTipoDocumento): string;
begin
  result := EnumeradoToStr(t, ['00', '10', '59', '65', '99'],
                              [tdDeclaracao, tdDutoviario, tdCFeSAT, tdNFCe, tdOutros]);
end;

function StrToTpDocumento(out ok: boolean; const s: string): TTipoDocumento;
begin
  result := StrToEnumerado(ok, s, ['00', '10', '59', '65', '99'],
                                  [tdDeclaracao, tdDutoviario, tdCFeSAT, tdNFCe, tdOutros]);
end;

function TpDocumentoAnteriorToStr(const t: TTipoDocumentoAnterior): string;
begin
  result := EnumeradoToStr(t, ['00', '01', '02', '03', '04', '05', '06', '07',
                               '08', '09', '10', '11', '12', '13', '99'],
                         [daCTRC, daCTAC, daACT, daNF7, daNF27, daCAN, daCTMC,
                          daATRE, daDTA, daCAI, daCCPI, daCA, daTIF, daBL, daOutros]);
end;

function StrToTpDocumentoAnterior(out ok: boolean; const s: string): TTipoDocumentoAnterior;
begin
  result := StrToEnumerado(ok, s, ['00', '01', '02', '03', '04', '05', '06', '07',
                                   '08', '09', '10', '11', '12', '13', '99'],
                         [daCTRC, daCTAC, daACT, daNF7, daNF27, daCAN, daCTMC,
                          daATRE, daDTA, daCAI, daCCPI, daCA, daTIF, daBL, daOutros]);
end;

function RspPagPedagioToStr(const t: TRspPagPedagio): string;
begin
  result := EnumeradoToStr(t, ['0','1','2','3','4','5'],
                             [rpEmitente, rpRemetente, rpExpedidor, rpRecebedor,
                              rpDestinatario, rpTomadorServico]);
end;

function StrToRspPagPedagio(out ok: boolean; const s: string): TRspPagPedagio;
begin
  result := StrToEnumerado(ok, s, ['0','1','2','3','4','5'],
                             [rpEmitente, rpRemetente, rpExpedidor, rpRecebedor,
                              rpDestinatario, rpTomadorServico]);
end;

function TpDispositivoToStr(const t: TTipoDispositivo): string;
begin
  result := EnumeradoToStr(t, ['1','2','3'], [tdCartaoMagnetico, tdTAG, tdTicket]);
end;

function StrToTpDispositivo(out ok: boolean; const s: string): TTipoDispositivo;
begin
  result := StrToEnumerado(ok, s, ['1','2','3'], [tdCartaoMagnetico, tdTAG, tdTicket]);
end;

function TpPropriedadeToStr(const t: TTipoPropriedade): string;
begin
  result := EnumeradoToStr(t, ['P','T'], [tpProprio, tpTerceiro]);
end;

function StrToTpPropriedade(out ok: boolean; const s: string): TTipoPropriedade;
begin
  result := StrToEnumerado(ok, s, ['P','T'], [tpProprio, tpTerceiro]);
end;

function TrafegoMutuoToStr(const t: TTrafegoMutuo): string;
begin
  result := EnumeradoToStr(t, ['1','2'],
   [tmOrigem, tmDestino]);
end;

function StrToTrafegoMutuo(out ok: boolean; const s: string): TTrafegoMutuo;
begin
  result := StrToEnumerado(ok, s, ['1','2'],
   [tmOrigem, tmDestino]);
end;

function indNegociavelToStr(const t: TindNegociavel ): string;
begin
  result := EnumeradoToStr(t, ['0', '1'], [inNaoNegociavel, inNegociavel]);
end;

function StrToindNegociavel(out ok: boolean; const s: string): TindNegociavel;
begin
  result := StrToEnumerado(ok, s, ['0', '1'], [inNaoNegociavel, inNegociavel]);
end;

function TpVeiculoToStr(const t: TTipoVeiculo): string;
begin
  result := EnumeradoToStr(t, ['0','1'], [tvTracao, tvReboque]);
end;

function StrToTpVeiculo(out ok: boolean; const s: string): TTipoVeiculo;
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

function TpRspSeguroToStr(const t: TRspSeg): String;
begin
  result := EnumeradoToStr(t, ['0', '1', '2', '3', '4', '5'],
                         [rsRemetente, rsExpedidor, rsRecebedor, rsDestinatario,
                          rsEmitenteCTe, rsTomadorServico]);
end;

function TpRspSeguroToStrText(const t: TRspSeg): String;
begin
  result := EnumeradoToStr(t, ['REMETENTE', 'EXPEDIDOR', 'RECEBEDOR',
                               'DESTINATARIO', 'EMITENTE', 'TOMADOR SERVICO'],
                         [rsRemetente, rsExpedidor, rsRecebedor, rsDestinatario,
                          rsEmitenteCTe, rsTomadorServico]);
end;

function StrToTpRspSeguro(out ok: boolean; const s: String ): TRspSeg;
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
  RegisterStrToTpEventoDFe(StrToTpEventoCTe, 'CTe');

end.
