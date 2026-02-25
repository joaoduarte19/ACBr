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

unit ACBrNFAg.Conversao;

interface

uses
  SysUtils, StrUtils, Classes,
  pcnConversao;

type
  TStatusNFAg = (stIdle, stNFAgStatusServico, stNFAgRecepcao,
                 stNFAgRetRecepcao, stNFAgRecibo, stNFAgConsulta,
                 stNFAgInutilizacao, stNFAgEvento, stDistDFeInt,
                 stEnvioWebService, stNFAgEmail);

type
  TVersaoNFAg = (ve100);

const
  TVersaoArrayStrings: array[TVersaoNFAg] of string = ('1.00');
  TVersaoArrayDouble: array[TVersaoNFAg] of Double = (1.00);

type
  TSchemaNFAg = (schErro, schconsStatServNFAg, schNFAg, schconsReciNFAg,
                 schconsSitNFAg, schInutNFAg, schEventoNFAg,
                 schCancNFAg);

const
  TSchemaArrayStrings: array[TSchemaNFAg] of string = ('', '', '', '',  '', '',
    '', 'evCancNFAg');

type
  TLayOut = (LayNFAgStatusServico, LayNFAgRecepcao, LayNFAgRecepcaoSinc,
             LayNFAgRetRecepcao, LayNFAgConsulta, LayNFAgEvento,
             LayNFAgQRCode, LayNFAgURLConsulta, LayNFAgDistDFeInt);

const
  TLayOutArrayStrings: array[TLayOut] of string = ('NFAgStatusServico',
    'NFAgRecepcao', 'NFAgRecepcaoSinc', 'NFAgRetRecepcao', 'NFAgConsulta',
    'NFAgRecepcaoEvento', 'URL-QRCode', 'URL-ConsultaNFAg', 'NFAgDistDFeInt');

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
  TFinalidadeNFAg = (fnNormal, fnSubstituicao);

const
  TFinalidadeArrayStrings: array[TFinalidadeNFAg] of string = ('0', '3');

type
  TtpFat = (tfNormal, tfTerceiro, tfConjunto);

const
  TtpFatArrayStrings: array[TtpFat] of string = ('1', '2', '3');

type
  TtpFaixaCons = (tfMinimo, tfMedio, tfMaximo);

const
  TtpFaixaConsArrayStrings: array[TtpFaixaCons] of string = ('1', '2', '3');

type
  TindIEDest = (inContribuinte, inIsento, inNaoContribuinte);

const
  TindIEDestArrayStrings: array[TindIEDest] of string = ('1', '2', '9');

type
  TtpLigacao = (tlAgua, tlEsgoto, tlAguaEsgoto);

const
  TtpLigacaoArrayStrings: array[TtpLigacao] of string = ('1', '2', '3');

type
  TmotSub = (msErroLeitura, msErroPreco, msDecisaoJudicial,
             msErroCadastral, msErroTributacao);

const
  TmotSubArrayStrings: array[TmotSub] of string = ('01', '02', '03', '04', '05');

type
  TuMed = (umkW, umkWh);

const
  TuMedArrayStrings: array[TuMed] of string = ('1', '2');

type
  TmotDifTarif = (mdtDecisaoJudicial, mdtDecisaoDistribuidora,
                  mdtDesconto, mdtAlteracao);

const
  TmotDifTarifArrayStrings: array[TmotDifTarif] of string = ('01', '02',
    '03', '04');

type
  TindOrigemQtd = (ioMedia, ioMedido, ioContatada, ioCalculada, ioCusto,
                   ioSemQuantidade);

const
  TindOrigemQtdArrayStrings: array[TindOrigemQtd] of string = ('1', '2', '3', '4',
    '5', '6');

type
  TtpMotNaoLeitura = (tmConsumidor, tmDistribuidora,
                      tmIndependente);

const
  TtpMotNaoLeituraArrayStrings: array[TtpMotNaoLeitura] of string = ('1',
    '2', '3');

type
  TtpGrMed = (tgmAguaTratada, tgmEsgotoTratado, tgmEsgotoColetado,
              tgmResidoSolidos, tgmAguaReuso, tgmEsgotoEstatico,
              tgmCaptacaoAguaBruta, tgmRecebimentoTratamentoChorume, tgmOutros);

const
  TtpGrMedArrayStrings: array[TtpGrMed] of string = ('01', '02', '03', '04',
    '05', '06', '07', '08', '99');

type
  TuMedFat = (umM3, umLitros, umUnidade, umTon);

const
  TuMedFatArrayStrings: array[TuMedFat] of string = ('1', '2', '5', '6');
  TuMedFatDescArrayStrings: array[TuMedFat] of string = ('M3', 'Litros', 'Unidade',
    'Tonelada');

type
  TtpCategoria = (tcComercial, tcConsumoProprio, tcIndustrial, tcResidencial,
                  tcRural, tcServicoPublico, tcSocial, tcMista, tcResidComercial,
                  tcResidIndustrial, tcOutros);

const
  tpCategoriaArrayStrings: array[TtpCategoria] of string = ('01', '02', '04',
    '06', '07', '08', '09', '10', '11', '12', '99');

type
  TtpProc = (tpProcAdmEstadual, tpJusticaFederal, tpJusticaEstadual,
             tpProcAdmMunicial, tpProcAdmFederal, tpProcon);

const
  TtpProcArrayStrings: array[TtpProc] of string = ('0', '1', '2', '3', '4', '5');

{
  Declaração das funções de conversão
}
function StrToTpEventoNFAg(out ok: boolean; const s: string): TpcnTpEvento;

function LayOutToServico(const t: TLayOut): string;
function ServicoToLayOut(const s: string): TLayOut;

function LayOutToSchema(const t: TLayOut): TSchemaNFAg;

function SchemaNFAgToStr(const t: TSchemaNFAg): string;
function StrToSchemaNFAg(const s: string): TSchemaNFAg;
function SchemaEventoToStr(const t: TSchemaNFAg): string;

function StrToVersaoNFAg(const s: string): TVersaoNFAg;
function VersaoNFAgToStr(const t: TVersaoNFAg): string;

function DblToVersaoNFAg(const d: Double): TVersaoNFAg;
function VersaoNFAgToDbl(const t: TVersaoNFAg): Double;

function VersaoQrCodeToStr(const t: TVersaoQrCode): string;
function StrToVersaoQrCode(const s: string): TVersaoQrCode;
function VersaoQrCodeToDbl(const t: TVersaoQrCode): Double;

function SiteAutorizadorToStr(const t: TSiteAutorizador): string;
function StrToSiteAutorizator(const s: string): TSiteAutorizador;

function finNFAgToStr(const t: TFinalidadeNFAg): string;
function StrTofinNFAg(const s: string): TFinalidadeNFAg;

function tpFatToStr(const t: TtpFat): string;
function StrTotpFat(const s: string): TtpFat;

function tpFaixaConsToStr(const t: TtpFaixaCons): string;
function StrTotpFaixaCons(const s: string): TtpFaixaCons;

function indIEDestToStr(const t: TindIEDest ): string;
function StrToindIEDest(const s: string): TindIEDest;

function tpLigacaoToStr(const t: TtpLigacao ): string;
function StrTotpLigacao(const s: string): TtpLigacao;

function MotSubToStr(const t: TmotSub): string;
function StrToMotSub(const s: string): TmotSub;

function uMedToStr(const t: TuMed): string;
function StrTouMed(const s: string): TuMed;

function motDifTarifToStr(const t: TmotDifTarif): string;
function StrTomotDifTarif(const s: string): TmotDifTarif;

function indOrigemQtdToStr(const t: TindOrigemQtd): string;
function StrToindOrigemQtd(const s: string): TindOrigemQtd;

function uMedFatToStr(const t: TuMedFat): string;
function StrTouMedFat(const s: string): TuMedFat;
function uMedFatToDesc(const t: TuMedFat): string;

function tpGrMedToStr(const t: TtpGrMed): string;
function StrTotpGrMed(const s: string): TtpGrMed;

function tpMotNaoLeituraToStr(const t: TtpMotNaoLeitura): string;
function StrTotpMotNaoLeitura(const s: string): TtpMotNaoLeitura;

function tpCategoriaToStr(const t: TtpCategoria): string;
function StrTotpCategoria(const s: string): TtpCategoria;

function tpProcToStr(const t: TtpProc): string;
function StrTotpProc(const s: string): TtpProc;

implementation

uses
  typinfo,
  ACBrBase;

function StrToTpEventoNFAg(out ok: boolean; const s: string): TpcnTpEvento;
begin
  Result := StrToEnumerado(ok, s,
            ['-99999', '110111', '240140', '240150', '240170'],
            [teNaoMapeado, teCancelamento, teAutorizadoSubstituicao,
             teAutorizadoAjuste, teLiberacaoPrazoCancelado]);
end;

function LayOutToServico(const t: TLayOut): string;
begin
  result := TLayOutArrayStrings[t];
end;

function ServicoToLayOut(const s: string): TLayOut;
var
  idx: TLayOut;
begin
  for idx := Low(TLayOutArrayStrings) to High(TLayOutArrayStrings) do
  begin
    if (TLayOutArrayStrings[idx] = s) then
    begin
      result := idx;
      exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string inválido para TVersaoNFAg: %s', [s]);
end;

function LayOutToSchema(const t: TLayOut): TSchemaNFAg;
begin
  case t of
    LayNFAgStatusServico: Result := schconsStatServNFAg;
    LayNFAgRecepcao,
    LayNFAgRecepcaoSinc:  Result := schNFAg;
    LayNFAgRetRecepcao:   Result := schconsReciNFAg;
    LayNFAgConsulta:      Result := schconsSitNFAg;
    LayNFAgEvento:        Result := schEventoNFAg;
  else
    Result := schErro;
  end;
end;

function SchemaNFAgToStr(const t: TSchemaNFAg): string;
begin
  Result := GetEnumName(TypeInfo(TSchemaNFAg), Integer( t ) );
  Result := copy(Result, 4, Length(Result)); // Remove prefixo "sch"
end;

function StrToSchemaNFAg(const s: string): TSchemaNFAg;
var
  P: Integer;
  SchemaStr: string;
  CodSchema: Integer;
begin
  P := pos('_',s);
  if p > 0 then
    SchemaStr := copy(s,1,P-1)
  else
    SchemaStr := s;

  if LeftStr(SchemaStr,3) <> 'sch' then
    SchemaStr := 'sch'+SchemaStr;

  CodSchema := GetEnumValue(TypeInfo(TSchemaNFAg), SchemaStr );

  if CodSchema = -1 then
  begin
    raise Exception.Create(Format('"%s" não é um valor TSchemaNFAg válido.',[SchemaStr]));
  end;

  Result := TSchemaNFAg( CodSchema );
end;

function StrToVersaoNFAg(const s: string): TVersaoNFAg;
var
  idx: TVersaoNFAg;
begin
  for idx := Low(TVersaoArrayStrings) to High(TVersaoArrayStrings) do
  begin
    if (TVersaoArrayStrings[idx] = s) then
    begin
      result := idx;
      exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string inválido para TVersaoNFAg: %s', [s]);
end;

function VersaoNFAgToStr(const t: TVersaoNFAg): string;
begin
  result := TVersaoArrayStrings[t];
end;

 function DblToVersaoNFAg(const d: Double): TVersaoNFAg;
var
  idx: TVersaoNFAg;
begin
  for idx := Low(TVersaoArrayDouble) to High(TVersaoArrayDouble) do
  begin
    if (TVersaoArrayDouble[idx] = d) then
    begin
      result := idx;
      exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string inválido para TVersaoNFAg: %s',
    [FormatFloat('0.00', d)]);
end;

 function VersaoNFAgToDbl(const t: TVersaoNFAg): Double;
 begin
  result := TVersaoArrayDouble[t];
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

function SchemaEventoToStr(const t: TSchemaNFAg): string;
begin
  result := TSchemaArrayStrings[t];
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

function finNFAgToStr(const t: TFinalidadeNFAg): string;
begin
  result := TFinalidadeArrayStrings[t];
end;

function StrTofinNFAg(const s: string): TFinalidadeNFAg;
var
  idx: TFinalidadeNFAg;
begin
  for idx := Low(TFinalidadeArrayStrings) to High(TFinalidadeArrayStrings) do
  begin
    if (TFinalidadeArrayStrings[idx] = s) then
    begin
      result := idx;
      exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string inválido para TFinalidadeNFAg: %s', [s]);
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

function indIEDestToStr(const t: TindIEDest ): string;
begin
  result := TindIEDestArrayStrings[t];
end;

function StrToindIEDest(const s: string): TindIEDest;
var
  idx: TindIEDest;
begin
  for idx := Low(TindIEDestArrayStrings) to High(TindIEDestArrayStrings) do
  begin
    if (TindIEDestArrayStrings[idx] = s) then
    begin
      result := idx;
      exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string inválido para TindIEDest: %s', [s]);
end;

function tpLigacaoToStr(const t: TtpLigacao): string;
begin
  result := TtpLigacaoArrayStrings[t];
end;

function StrTotpLigacao(const s: string): TtpLigacao;
var
  idx: TtpLigacao;
begin
  for idx := Low(TtpLigacaoArrayStrings) to High(TtpLigacaoArrayStrings) do
  begin
    if (TtpLigacaoArrayStrings[idx] = s) then
    begin
      result := idx;
      exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string inválido para TtpLigacao: %s', [s]);
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

function motDifTarifToStr(const t: TmotDifTarif): string;
begin
  result := TmotDifTarifArrayStrings[t];
end;

function StrTomotDifTarif(const s: string): TmotDifTarif;
var
  idx: TmotDifTarif;
begin
  for idx := Low(TmotDifTarifArrayStrings) to High(TmotDifTarifArrayStrings) do
  begin
    if (TmotDifTarifArrayStrings[idx] = s) then
    begin
      result := idx;
      exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string inválido para TmotDifTarif: %s', [s]);
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

function uMedFatToStr(const t: TuMedFat): string;
begin
  result := TuMedFatArrayStrings[t];
end;

function StrTouMedFat(const s: string): TuMedFat;
var
  idx: TuMedFat;
begin
  for idx := Low(TuMedFatArrayStrings) to High(TuMedFatArrayStrings) do
  begin
    if (TuMedFatArrayStrings[idx] = s) then
    begin
      result := idx;
      exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string inválido para TuMedFat: %s', [s]);
end;

function uMedFatToDesc(const t: TuMedFat): string;
begin
  result := TuMedFatDescArrayStrings[t];
end;

function tpGrMedToStr(const t: TtpGrMed): string;
begin
  result := TtpGrMedArrayStrings[t];
end;

function StrTotpGrMed(const s: string): TtpGrMed;
var
  idx: TtpGrMed;
begin
  for idx := Low(TtpGrMedArrayStrings) to High(TtpGrMedArrayStrings) do
  begin
    if (TtpGrMedArrayStrings[idx] = s) then
    begin
      result := idx;
      exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string inválido para TtpGrMed: %s', [s]);
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

function tpCategoriaToStr(const t: TtpCategoria): string;
begin
  result := tpCategoriaArrayStrings[t];
end;

function StrTotpCategoria(const s: string): TtpCategoria;
var
  idx: TtpCategoria;
begin
  for idx := Low(tpCategoriaArrayStrings) to High(tpCategoriaArrayStrings) do
  begin
    if (tpCategoriaArrayStrings[idx] = s) then
    begin
      result := idx;
      exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string inválido para tpCategoria: %s', [s]);
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

initialization
  RegisterStrToTpEventoDFe(StrToTpEventoNFAg, 'NFAg');

end.

