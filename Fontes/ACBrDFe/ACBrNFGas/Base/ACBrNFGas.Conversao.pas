{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interacao com equipa- }
{ mentos de Automacao Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Jonathas Duarte Pereira                         }
{                                                                              }
{  Voce pode obter a ultima versao desse arquivo na pagina do Projeto ACBr     }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Esta biblioteca e software livre; voce pode redistribui-la e/ou modifica-la }
{ sob os termos da Licenca Publica Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a versao 2.1 da Licenca, ou (a seu criterio) }
{ qualquer versao posterior.                                                   }
{                                                                              }
{  Esta biblioteca e distribuida na expectativa de que seja util, porem, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia implicita de COMERCIABILIDADE OU      }
{ ADEQUACAO A UMA FINALIDADE ESPECIFICA. Consulte a Licenca Publica Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENCA.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Voce deve ter recebido uma copia da Licenca Publica Geral Menor do GNU junto}
{ com esta biblioteca; se nao, escreva para a Free Software Foundation, Inc.,  }
{ no endereco 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Voce tambem pode obter uma copia da licenca em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Simoes de Almeida - daniel@projetoacbr.com.br - www.projetoacbr.com.br}
{       Rua Coronel Aureliano de Camargo, 963 - Tatui - SP - 18270-170         }
{******************************************************************************}

{$I ACBr.inc}

unit ACBrNFGas.Conversao;

interface

uses
  SysUtils, StrUtils, Classes,
  ACBrDFe.Conversao;

type
  TStatusNFGas = (stNFGasIdle, stNFGasStatusServico, stNFGasRecepcao,
    stNFGasRetRecepcao, stNFGasConsulta, stNFGasEnvioWebService, stNFGasEmail,
    stNFGasEvento);

type
  TVersaoNFGas = (ve100);

const
  TVersaoNFGasArrayStrings: array[TVersaoNFGas] of string = ('1.00');

  TVersaoNFGasArrayDouble: array[TVersaoNFGas] of Double = (1.00);

type
  TSchemaNFGas = (schErroNFGas, schNFGas, schconsStatServNFGas, schretNFGas,
    schconsSitNFGas, schEventoNFGas, schevCancNFGas);

const
  TSchemaNFGasArrayStrings: array[TSchemaNFGas] of string = ('', '', '', '', '',
    '', 'evCancNFGas');

type
  TLayOutNFGas = (LayNFGasStatusServico, LayNFGasRecepcao, LayNFGasConsulta,
                  LayNFGasRetRecepcao, LayNFGasEvento, LayNFGasURLQRCode,
                  LayURLConsultaNFGas);

const
  TLayOutNFGasArrayStrings: array[TLayOutNFGas] of string = (
    'NFGasStatusServico', 'NFGasRecepcao', 'NFGasConsulta', 'NFGasRetRecepcao',
    'NFGasRecepcaoEvento', 'URL-QRCode', 'URL-ConsultaNFGas');

type
  TindIEDest = (inContribuinte, inIsento, inNaoContribuinte);

const
  TindIEDestArrayStrings: array[TindIEDest] of string = ('1', '2', '9');

type
  TVersaoQrCode = (veqr000, veqr100, veqr200);

const
  TVersaoQrCodeArrayStrings: array[TVersaoQrCode] of string = ('0', '1', '2');
  TVersaoQrCodeArrayDouble: array[TVersaoQrCode] of Double = (0, 1, 2);

type
  TSiteAutorizador = (sa0, sa1, sa2, sa3, sa4, sa5, sa6, sa7, sa8, sa9);

const
  TSiteAutorizadorArrayStrings: array[TSiteAutorizador] of string = ('0','1', '2',
    '3', '4', '5', '6', '7', '8', '9');

type
  TindOrigemQtd = (ioMedia, ioMedido, ioContatada, ioCalculada, ioCusto,
                   ioSemQuantidade);

const
  TindOrigemQtdArrayStrings: array[TindOrigemQtd] of string = ('1', '2', '3', '4',
    '5', '6');

type
  TuMed = (umm3);

const
  TuMedArrayStrings: array[TuMed] of string = ('1');
  TuMedDescArrayStrings: array[TuMed] of string = ('m3');

type
  TuMedItem = (umim3, umiUnidade);

const
  TuMedItemArrayStrings: array[TuMedItem] of string = ('1', '2');
  TuMedItemDescArrayStrings: array[TuMedItem] of string = ('m3', 'Unidade');

type
  TtpMotNaoLeitura = (tmConsumidor, tmDistribuidora,
                      tmIndependente);

const
  TtpMotNaoLeituraArrayStrings: array[TtpMotNaoLeitura] of string = ('1',
    '2', '3');

type
  TFinalidadeNFGas = (fnNormal, fnSubstituicao);

const
  TFinalidadeArrayStrings: array[TFinalidadeNFGas] of string = ('0', '3');

type
  TtpInstalacao = (tiCativo, tiLivre, tiParcialmenteLivre);

const
  TtpInstalacaoArrayStrings: array[TtpInstalacao] of string = ('1', '2', '3');

type
  TtpClasse = (tcComercial, tcIndustrial, tcResidencial, tcTermico,
    tcVeicularPosto, tcVeicularFrota, tcGNC, tcGNL, tcCogeracao, tcRefinaria,
    tcOutros);

const
  TtpClasseArrayStrings: array[TtpClasse] of string = ('01', '02', '03', '04',
    '05', '06', '07', '08', '09', '10', '99');

type
  TmotSub = (msErroLeitura, msErroPreco, msDecisaoJudicial,
             msErroCadastral, msErroTributacao, msDecisaoReguladora);

const
  TmotSubArrayStrings: array[TmotSub] of string = ('01', '02', '03', '04', '05',
    '06');

type
  TVolContrat = (vcDemandaMinima, vcMontanteUso, vcEncargoCapacidade, vcVolumeContratado);

const
  TVolContratArrayStrings: array[TVolContrat] of string = ('1', '2', '3', '4');

type
  TtpEqp = (teMedidor, teConversor);

const
  TtpEqpArrayStrings: array[TtpEqp] of string = ('1', '2');

type
  TtpMedidor = (tmTurbina, tmRotativo, tmDiafragma, tmUltrasonico);

const
  TtpMedidorArrayStrings: array[TtpMedidor] of string = ('1', '2', '3', '4');

type
  TtpFaixaCons = (tfFixa, tfMedia);

const
  TtpFaixaConsArrayStrings: array[TtpFaixaCons] of string = ('1', '2');

type
  TtpProc = (tpProcAdmEstadual, tpJusticaFederal, tpJusticaEstadual,
             tpProcAdmMunicial, tpProcAdmFederal, tpProcon);

const
  TtpProcArrayStrings: array[TtpProc] of string = ('0', '1', '2', '3', '4', '5');

type
  TDeterminacaoBaseIcms = (dbiMargemValorAgregado, dbiPauta, dbiPrecoTabelado,
                           dbiValorOperacao, dbiNenhum);
  TDeterminacaoBaseIcmsST = (dbisPrecoTabelado, dbisListaNegativa,
                             dbisListaPositiva, dbisListaNeutra,
                             dbisMargemValorAgregado, dbisPauta,
                             dbisValordaOperacao);
  TMotivoDesoneracaoICMS = (mdiTaxi, mdiDeficienteFisico, mdiProdutorAgropecuario,
                            mdiFrotistaLocadora, mdiDiplomaticoConsular,
                            mdiAmazoniaLivreComercio, mdiSuframa,
                            mdiVendaOrgaosPublicos, mdiOutros, mdiDeficienteCondutor,
                            mdiDeficienteNaoCondutor, mdiOrgaoFomento,
                            mdiOlimpiadaRio2016, mdiSolicitadoFisco );

type
  TtpFat = (tfNormal, tfAgregado, tfAgregador);

const
  TtpFatArrayStrings: array[TtpFat] of string = ('1', '2', '3');

{
  Declaração das funções de conversão
}
function StrToTpEventoNFGas(out ok: Boolean; const s: string): TACBrTipoEvento;

function VersaoNFGasToStr(const t: TVersaoNFGas): string;
function StrToVersaoNFGas(const s: string): TVersaoNFGas;

function DblToVersaoNFGas(const d: Double): TVersaoNFGas;
function VersaoNFGasToDbl(const t: TVersaoNFGas): Double;

function SchemaNFGasToStr(const t: TSchemaNFGas): string;
function StrToSchemaNFGas(const s: string): TSchemaNFGas;
function SchemaEventoToStr(const t: TSchemaNFGas): string;

function LayOutNFGasToSchema(const t: TLayOutNFGas): TSchemaNFGas;
function LayOutNFGasToServico(const t: TLayOutNFGas): string;
function ServicoToLayOutNFGas(const s: string): TLayOutNFGas;

function indIEDestToStr(const t: TindIEDest): string;
function StrToindIEDest(const s: string): TindIEDest;

function VersaoQrCodeToStr(const t: TVersaoQrCode): string;
function StrToVersaoQrCode(const s: string): TVersaoQrCode;
function VersaoQrCodeToDbl(const t: TVersaoQrCode): Double;

function SiteAutorizadorToStr(const t: TSiteAutorizador): string;
function StrToSiteAutorizator(const s: string): TSiteAutorizador;

function indOrigemQtdToStr(const t: TindOrigemQtd): string;
function StrToindOrigemQtd(const s: string): TindOrigemQtd;

function uMedToStr(const t: TuMed): string;
function StrTouMed(const s: string): TuMed;
function uMedToDesc(const t: TuMed): string;

function uMedItemToStr(const t: TuMedItem): string;
function StrTouMedItem(const s: string): TuMedItem;
function uMedItemToDesc(const t: TuMedItem): string;

function tpMotNaoLeituraToStr(const t: TtpMotNaoLeitura): string;
function StrTotpMotNaoLeitura(const s: string): TtpMotNaoLeitura;

function finNFGasToStr(const t: TFinalidadeNFGas): string;
function StrTofinNFGas(const s: string): TFinalidadeNFGas;

function InstalacaoToStr(const t: TtpInstalacao): string;
function StrToInstalacao(const s: string): TtpInstalacao;

function ClasseToStr(const t: TtpClasse): string;
function StrToClasse(const s: string): TtpClasse;

function MotSubToStr(const t: TmotSub): string;
function StrToMotSub(const s: string): TmotSub;

function VolContratToStr(const t: TVolContrat): string;
function StrToVolContrat(const s: string): TVolContrat;

function tpEqpToStr(const t: TtpEqp): string;
function StrTotpEqp(const s: string): TtpEqp;

function tpMedidorToStr(const t: TtpMedidor): string;
function StrTotpMedidor(const s: string): TtpMedidor;

function tpFaixaConsToStr(const t: TtpFaixaCons): string;
function StrTotpFaixaCons(const s: string): TtpFaixaCons;

function tpProcToStr(const t: TtpProc): string;
function StrTotpProc(const s: string): TtpProc;

function modBCToStr(const t: TDeterminacaoBaseIcms): string;
function modBCToStrTagPosText(const t: TDeterminacaoBaseIcms): string;
function StrTomodBC(out ok: boolean; const s: string): TDeterminacaoBaseIcms;

function modBCSTToStr(const t: TDeterminacaoBaseIcmsST): string;
function modBCSTToStrTagPosText(const t: TDeterminacaoBaseIcmsST): string;
function StrTomodBCST(out ok: boolean; const s: string): TDeterminacaoBaseIcmsST;

function motDesICMSToStr(const t: TMotivoDesoneracaoICMS): string;
function motDesICMSToStrTagPosText(const t: TMotivoDesoneracaoICMS): string;
function StrTomotDesICMS(out ok: boolean; const s: string): TMotivoDesoneracaoICMS;

function tpFatToStr(const t: TtpFat): string;
function StrTotpFat(const s: string): TtpFat;

implementation

uses
  TypInfo,
  ACBrBase;

function StrToTpEventoNFGas(out ok: Boolean; const s: string): TACBrTipoEvento;
begin
  Result := StrToEnumerado(ok, s,
    ['-99999', '110111', '240140', '240150', '240170'],
    [teNaoMapeado, teCancelamento, teAutorizadoSubstituicao,
     teAutorizadoAjuste, teLiberacaoPrazoCancelado]
  );
end;

function VersaoNFGasToStr(const t: TVersaoNFGas): string;
begin
  Result := TVersaoNFGasArrayStrings[t];
end;

function StrToVersaoNFGas(const s: string): TVersaoNFGas;
var
  Index: TVersaoNFGas;
begin
  for Index := Low(TVersaoNFGasArrayStrings) to High(TVersaoNFGasArrayStrings) do
  begin
    if TVersaoNFGasArrayStrings[Index] = s then
    begin
      Result := Index;
      Exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string inválido para TVersaoNFGas: %s', [s]);
end;

function DblToVersaoNFGas(const d: Double): TVersaoNFGas;
var
  Index: TVersaoNFGas;
begin
  for Index := Low(TVersaoNFGasArrayDouble) to High(TVersaoNFGasArrayDouble) do
  begin
    if TVersaoNFGasArrayDouble[Index] = d then
    begin
      Result := Index;
      Exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor double inválido para TVersaoNFGas: %s', [FormatFloat('0.00', d)]);
end;

function VersaoNFGasToDbl(const t: TVersaoNFGas): Double;
begin
  Result := TVersaoNFGasArrayDouble[t];
end;

function SchemaNFGasToStr(const t: TSchemaNFGas): string;
begin
  Result := GetEnumName(TypeInfo(TSchemaNFGas), Integer(t));
  Result := Copy(Result, 4, Length(Result));
end;

function StrToSchemaNFGas(const s: string): TSchemaNFGas;
var
  SchemaStr: string;
  CodigoSchema: Integer;
  PosicaoSeparador: Integer;
begin
  PosicaoSeparador := Pos('_', s);

  if PosicaoSeparador > 0 then
  begin
    SchemaStr := Copy(s, 1, PosicaoSeparador - 1);
  end
  else
  begin
    SchemaStr := s;
  end;

  if LeftStr(SchemaStr, 3) <> 'sch' then
  begin
    SchemaStr := 'sch' + SchemaStr;
  end;

  CodigoSchema := GetEnumValue(TypeInfo(TSchemaNFGas), SchemaStr);

  if CodigoSchema = -1 then
  begin
    raise EACBrException.CreateFmt('"%s" não está mapeado em TSchemaNFGas.', [SchemaStr]);
  end;

  Result := TSchemaNFGas(CodigoSchema);
end;

function SchemaEventoToStr(const t: TSchemaNFGas): string;
begin
  Result := TSchemaNFGasArrayStrings[t];
end;

function LayOutNFGasToSchema(const t: TLayOutNFGas): TSchemaNFGas;
begin
  case t of
    LayNFGasStatusServico:
      Result := schconsStatServNFGas;
    LayNFGasRecepcao:
      Result := schNFGas;
    LayNFGasConsulta:
      Result := schconsSitNFGas;
    LayNFGasRetRecepcao:
      Result := schretNFGas;
    LayNFGasEvento:
      Result := schEventoNFGas;
  else
    Result := schErroNFGas;
  end;
end;

function LayOutNFGasToServico(const t: TLayOutNFGas): string;
begin
  Result := TLayOutNFGasArrayStrings[t];
end;

function ServicoToLayOutNFGas(const s: string): TLayOutNFGas;
var
  Index: TLayOutNFGas;
begin
  for Index := Low(TLayOutNFGasArrayStrings) to High(TLayOutNFGasArrayStrings) do
  begin
    if TLayOutNFGasArrayStrings[Index] = s then
    begin
      Result := Index;
      Exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string inválido para TLayOutNFGas: %s', [s]);
end;

function indIEDestToStr(const t: TindIEDest): string;
begin
  Result := TindIEDestArrayStrings[t];
end;

function StrToindIEDest(const s: string): TindIEDest;
var
  Index: TindIEDest;
begin
  for Index := Low(TindIEDestArrayStrings) to High(TindIEDestArrayStrings) do
  begin
    if TindIEDestArrayStrings[Index] = s then
    begin
      Result := Index;
      Exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string inválido para TindIEDest: %s', [s]);
end;

function VersaoQrCodeToStr(const t: TVersaoQrCode): string;
begin
  result := TVersaoQrCodeArrayStrings[t];
end;

function StrToVersaoQrCode(const s: string): TVersaoQrCode;
var
  idx: TVersaoQrCode;
begin
  for idx := Low(TVersaoQrCodeArrayStrings) to High(TVersaoQrCodeArrayStrings) do
  begin
    if (TVersaoQrCodeArrayStrings[idx] = s) then
    begin
      result := idx;
      exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string inválido para TVersaoQrCode: %s', [s]);
end;

function VersaoQrCodeToDbl(const t: TVersaoQrCode): Double;
begin
  result := TVersaoQrCodeArrayDouble[t];
end;

function SiteAutorizadorToStr(const t: TSiteAutorizador): string;
begin
  result := TSiteAutorizadorArrayStrings[t];
end;

function StrToSiteAutorizator(const s: string): TSiteAutorizador;
var
  idx: TSiteAutorizador;
begin
  for idx := Low(TSiteAutorizadorArrayStrings) to High(TSiteAutorizadorArrayStrings) do
  begin
    if (TSiteAutorizadorArrayStrings[idx] = s) then
    begin
      result := idx;
      exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string inválido para TSiteAutorizador: %s', [s]);
end;

function indOrigemQtdToStr(const t: TindOrigemQtd): string;
begin
  result := TindOrigemQtdArrayStrings[t];
end;

function StrToindOrigemQtd(const s: string): TindOrigemQtd;
var
  idx: TindOrigemQtd;
begin
  for idx := Low(TindOrigemQtdArrayStrings) to High(TindOrigemQtdArrayStrings) do
  begin
    if (TindOrigemQtdArrayStrings[idx] = s) then
    begin
      result := idx;
      exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string inválido para TindOrigemQtd: %s', [s]);
end;

function uMedToStr(const t: TuMed): string;
begin
  result := TuMedArrayStrings[t];
end;

function StrTouMed(const s: string): TuMed;
var
  idx: TuMed;
begin
  for idx := Low(TuMedArrayStrings) to High(TuMedArrayStrings) do
  begin
    if (TuMedArrayStrings[idx] = s) then
    begin
      result := idx;
      exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string inválido para TuMed: %s', [s]);
end;

function uMedToDesc(const t: TuMed): string;
begin
  result := TuMedDescArrayStrings[t];
end;

function uMedItemToStr(const t: TuMedItem): string;
begin
  result := TuMedItemArrayStrings[t];
end;

function StrTouMedItem(const s: string): TuMedItem;
var
  idx: TuMedItem;
begin
  for idx := Low(TuMedItemArrayStrings) to High(TuMedItemArrayStrings) do
  begin
    if (TuMedItemArrayStrings[idx] = s) then
    begin
      result := idx;
      exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string inválido para TuMedItem: %s', [s]);
end;

function uMedItemToDesc(const t: TuMedItem): string;
begin
  result := TuMedItemDescArrayStrings[t];
end;

function tpMotNaoLeituraToStr(const t: TtpMotNaoLeitura): string;
begin
  result := TtpMotNaoLeituraArrayStrings[t];
end;

function StrTotpMotNaoLeitura(const s: string): TtpMotNaoLeitura;
var
  idx: TtpMotNaoLeitura;
begin
  for idx := Low(TtpMotNaoLeituraArrayStrings) to High(TtpMotNaoLeituraArrayStrings) do
  begin
    if (TtpMotNaoLeituraArrayStrings[idx] = s) then
    begin
      result := idx;
      exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string inválido para TtpMotNaoLeitura: %s', [s]);
end;

function finNFGasToStr(const t: TFinalidadeNFGas): string;
begin
  result := TFinalidadeArrayStrings[t];
end;

function StrTofinNFGas(const s: string): TFinalidadeNFGas;
var
  idx: TFinalidadeNFGas;
begin
  for idx := Low(TFinalidadeArrayStrings) to High(TFinalidadeArrayStrings) do
  begin
    if (TFinalidadeArrayStrings[idx] = s) then
    begin
      result := idx;
      exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string inválido para TFinalidadeNFGas: %s', [s]);
end;

function InstalacaoToStr(const t: TtpInstalacao): string;
begin
  result := TtpInstalacaoArrayStrings[t];
end;

function StrToInstalacao(const s: string): TtpInstalacao;
var
  idx: TtpInstalacao;
begin
  for idx := Low(TtpInstalacaoArrayStrings) to High(TtpInstalacaoArrayStrings) do
  begin
    if (TtpInstalacaoArrayStrings[idx] = s) then
    begin
      result := idx;
      exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string inválido para TtpInstalacao: %s', [s]);
end;

function ClasseToStr(const t: TtpClasse): string;
begin
  result := TtpClasseArrayStrings[t];
end;

function StrToClasse(const s: string): TtpClasse;
var
  idx: TtpClasse;
begin
  for idx := Low(TtpClasseArrayStrings) to High(TtpClasseArrayStrings) do
  begin
    if (TtpClasseArrayStrings[idx] = s) then
    begin
      result := idx;
      exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string inválido para TtpClasse: %s', [s]);
end;

function MotSubToStr(const t: TmotSub): string;
begin
  result := TmotSubArrayStrings[t];
end;

function StrToMotSub(const s: string): TmotSub;
var
  idx: TmotSub;
begin
  for idx := Low(TmotSubArrayStrings) to High(TmotSubArrayStrings) do
  begin
    if (TmotSubArrayStrings[idx] = s) then
    begin
      result := idx;
      exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string inválido para TmotSub: %s', [s]);
end;

function VolContratToStr(const t: TVolContrat): string;
begin
  result := TVolContratArrayStrings[t];
end;

function StrToVolContrat(const s: string): TVolContrat;
var
  idx: TVolContrat;
begin
  for idx := Low(TVolContratArrayStrings) to High(TVolContratArrayStrings) do
  begin
    if (TVolContratArrayStrings[idx] = s) then
    begin
      result := idx;
      exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string inválido para TVolContrat: %s', [s]);
end;

function tpEqpToStr(const t: TtpEqp): string;
begin
  result := TtpEqpArrayStrings[t];
end;

function StrTotpEqp(const s: string): TtpEqp;
var
  idx: TtpEqp;
begin
  for idx := Low(TtpEqpArrayStrings) to High(TtpEqpArrayStrings) do
  begin
    if (TtpEqpArrayStrings[idx] = s) then
    begin
      result := idx;
      exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string inválido para TtpEqp: %s', [s]);
end;

function tpMedidorToStr(const t: TtpMedidor): string;
begin
  result := TtpMedidorArrayStrings[t];
end;

function StrTotpMedidor(const s: string): TtpMedidor;
var
  idx: TtpMedidor;
begin
  for idx := Low(TtpMedidorArrayStrings) to High(TtpMedidorArrayStrings) do
  begin
    if (TtpMedidorArrayStrings[idx] = s) then
    begin
      result := idx;
      exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string inválido para TtpMedidor: %s', [s]);
end;

function tpFaixaConsToStr(const t: TtpFaixaCons): string;
begin
  result := TtpFaixaConsArrayStrings[t];
end;

function StrTotpFaixaCons(const s: string): TtpFaixaCons;
var
  idx: TtpFaixaCons;
begin
  for idx := Low(TtpFaixaConsArrayStrings) to High(TtpFaixaConsArrayStrings) do
  begin
    if (TtpFaixaConsArrayStrings[idx] = s) then
    begin
      result := idx;
      exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string inválido para TtpFaixaCons: %s', [s]);
end;

function tpProcToStr(const t: TtpProc): string;
begin
  result := TtpProcArrayStrings[t];
end;

function StrTotpProc(const s: string): TtpProc;
var
  idx: TtpProc;
begin
  for idx := Low(TtpProcArrayStrings) to High(TtpProcArrayStrings) do
  begin
    if (TtpProcArrayStrings[idx] = s) then
    begin
      result := idx;
      exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string inválido para TtpProc: %s', [s]);
end;

function modBCToStr(const t: TDeterminacaoBaseIcms): string;
begin
  result := EnumeradoToStr(t, ['0', '1', '2', '3', ''],
    [dbiMargemValorAgregado, dbiPauta, dbiPrecoTabelado, dbiValorOperacao, dbiNenhum]);
end;

function modBCToStrTagPosText(const t: TDeterminacaoBaseIcms): string;
begin
  result := EnumeradoToStr(t, ['0 - Margem Valor Agregado (%)', '1 - Pauta (Valor)', '2 - Preço Tabelado Máx. (valor)', '3 - Valor da operação', ''],
    [dbiMargemValorAgregado, dbiPauta, dbiPrecoTabelado, dbiValorOperacao, dbiNenhum]);
end;

function StrTomodBC(out ok: boolean; const s: string): TDeterminacaoBaseIcms;
begin
  result := StrToEnumerado(ok, s, ['0', '1', '2', '3', ''],
    [dbiMargemValorAgregado, dbiPauta, dbiPrecoTabelado, dbiValorOperacao, dbiNenhum]);
end;

function modBCSTToStr(const t: TDeterminacaoBaseIcmsST): string;
begin
  result := EnumeradoToStr(t, ['0', '1', '2', '3', '4', '5', '6', ''],
    [dbisPrecoTabelado, dbisListaNegativa, dbisListaPositiva, dbisListaNeutra,
     dbisMargemValorAgregado, dbisPauta, dbisValordaOperacao,
     TDeterminacaoBaseIcmsST(-1)]);
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

function tpFatToStr(const t: TtpFat): string;
begin
  result := TtpFatArrayStrings[t];
end;

function StrTotpFat(const s: string): TtpFat;
var
  idx: TtpFat;
begin
  for idx := Low(TtpFatArrayStrings) to High(TtpFatArrayStrings) do
  begin
    if (TtpFatArrayStrings[idx] = s) then
    begin
      result := idx;
      exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string inválido para TtpFat: %s', [s]);
end;

initialization
  RegisterStrToTpEventoDFe(StrToTpEventoNFGas, 'NFGas');

end.
