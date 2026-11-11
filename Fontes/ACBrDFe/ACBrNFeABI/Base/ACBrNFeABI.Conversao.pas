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

unit ACBrNFeABI.Conversao;

interface

uses
  SysUtils, StrUtils, Classes,
  ACBrDFe.Conversao;

type
  TStatusNFeABI = (stNFeABIIdle, stNFeABIStatusServico, stNFeABIAutorizacao, stNFeABIConsulta,
                stNFeABIEmail, stNFeABIEvento, stNFeABIEnvioWebService);

  TVersaoNFeABI = (ve100);

const
  TVersaoNFeABIArrayStrings: array[TVersaoNFeABI] of string = ('1.00');
  TVersaoNFeABIArrayDouble: array[TVersaoNFeABI] of Double = (1.00);

type
  TSchemaNFeABI = (schErroNFeABI, schNFeABI, schEventoNFeABI, schconsSitNFeABI,
                schconsStatServNFeABI, schevCancNFeABI);

const
  TSchemaNFeABIArrayStrings: array[TSchemaNFeABI] of string = ('', '', '', '', '',
    'evCancNFeABI');

type
  TLayOutNFeABI = (LayNFeABIAutorizacao, LayNFeABIConsulta, LayNFeABIStatusServico,
                LayNFeABIEvento, LayNFeABIURLQRCode, LayURLConsultaNFeABI);

const
  TLayOutNFeABIArrayStrings: array[TLayOutNFeABI] of string = ('Autorizacao',
    'Consulta', 'StatusServico', 'RecepcaoEvento', 'URL-QRCode', 'URL-Consulta');

type
  TSiteAutorizador = (sa0, sa1, sa2, sa3, sa4, sa5, sa6, sa7, sa8, sa9);

const
  TSiteAutorizadorArrayStrings: array[TSiteAutorizador] of string = ('0','1', '2',
    '3', '4', '5', '6', '7', '8', '9');

type
  TtpNF = (tdSimplificado, tdCompleto, tdTransicao);

const
  TtpNFArrayStrings: array[TtpNF] of string = ('0', '1', '2');

type
  TtpImp = (tiSemGeracao, tiRetrato, tiPaisagem);

const
  TtpImpArrayStrings: array[TtpImp] of string = ('0', '1', '2');

type
  TfinNFe = (fnNormal, fnSubstituicao);

const
  TfinNFeArrayStrings: array[TfinNFe] of string = ('1', '2');

type
  TtpEmit = (teVendedor, teComprador, teLeiloeiro, teTabelionato, teJuntaComercial,
             teBanco, teOrganizacao, teCredor, teGrupoConsorcio, teSucessora,
             teOutros);

const
  TtpEmitArrayStrings: array[TtpEmit] of string = ('01', '02', '03', '04', '05',
    '06', '07', '08', '09', '10', '99');

type
  TindContrib = (icNenhum, icNaoContribuinteIBSCBS, icContribuinteRegimeRegular,
                 icOptanteSN);

const
  TindContribArrayStrings: array[TindContrib] of string = ('', '0', '1', '2');

type
  Ttipo = (tiUrbano, tiRural);

const
  TtipoArrayStrings: array[Ttipo] of string = ('1', '2');

type
  TuareaTotal = (uatm2, uatha);

const
  TuareaTotalArrayStrings: array[TuareaTotal] of string = ('m2', 'ha');

{
  Declaração das funções de conversão
}
function StrTotpEventoNFeABI(out ok: boolean; const s: string): TACBrTipoEvento;

function StrToVersaoNFeABI(const s: String): TVersaoNFeABI;
function VersaoNFeABIToStr(const t: TVersaoNFeABI): String;

function DblToVersaoNFeABI(const d: Double): TVersaoNFeABI;
function VersaoNFeABIToDbl(const t: TVersaoNFeABI): Double;

function SchemaNFeABIToStr(const t: TSchemaNFeABI): String;
function StrToSchemaNFeABI(const s: String): TSchemaNFeABI;

function LayOutNFeABIToSchema(const t: TLayOutNFeABI): TSchemaNFeABI;

function LayOutNFeABIToServico(const t: TLayOutNFeABI): String;
function ServicoToLayOutNFeABI(const s: String): TLayOutNFeABI;

function SiteAutorizadorToStr(const t: TSiteAutorizador): string;
function StrToSiteAutorizator(const s: string): TSiteAutorizador;

function tpNFToStr(const t: TtpNF): string;
function StrTotpNF(const s: string): TtpNF;

function tpImpToStr(const t: TtpImp): string;
function StrTotpImp(const s: string): TtpImp;

function finNFeToStr(const t: TfinNFe): String;
function StrTofinNFe(const s: String): TfinNFe;

function tpEmitToStr(const t: TtpEmit): String;
function StrTotpEmit(const s: String): TtpEmit;

function indContribToStr(const t: TindContrib): String;
function StrToindContrib(const s: String): TindContrib;

function TipoToStr(const t: Ttipo): String;
function StrToTipo(const s: String): Ttipo;

function uareaTotalToStr(const t: TuareaTotal): String;
function StrTouareaTotal(const s: String): TuareaTotal;

implementation

uses
  typinfo,
  ACBrBase;

function StrTotpEventoNFeABI(out ok: boolean; const s: string): TACBrTipoEvento;
begin
  Result := StrToEnumerado(ok, s,
            ['-99999', '110111', '110112', '110114', '110115', '110116',
             '310112', '510620'],
            [teNaoMapeado, teCancelamento, teEncerramento, teInclusaoCondutor,
             teInclusaoDFe, tePagamentoOperacao, teEncerramentoFisco,
             teRegistroPassagemBRId]);
end;

function StrToVersaoNFeABI(const s: String): TVersaoNFeABI;
var
  idx: TVersaoNFeABI;
begin
  for idx := Low(TVersaoNFeABIArrayStrings) to High(TVersaoNFeABIArrayStrings) do
  begin
    if (TVersaoNFeABIArrayStrings[idx] = s) then
    begin
      result := idx;
      exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string inválido para TVersaoNFeABI: %s', [s]);
end;

function VersaoNFeABIToStr(const t: TVersaoNFeABI): String;
begin
  result := TVersaoNFeABIArrayStrings[t];
end;

function DblToVersaoNFeABI(const d: Double): TVersaoNFeABI;
var
  idx: TVersaoNFeABI;
begin
  for idx := Low(TVersaoNFeABIArrayDouble) to High(TVersaoNFeABIArrayDouble) do
  begin
    if (TVersaoNFeABIArrayDouble[idx] = d) then
    begin
      result := idx;
      exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string inválido para TVersaoNFeABI: %s',
    [FormatFloat('0.00', d)]);
end;

function VersaoNFeABIToDbl(const t: TVersaoNFeABI): Double;
begin
  result := TVersaoNFeABIArrayDouble[t];
end;

function SchemaNFeABIToStr(const t: TSchemaNFeABI): String;
begin
  Result := GetEnumName(TypeInfo(TSchemaNFeABI), Integer(t));
  Result := copy(Result, 4, Length(Result)); // Remove prefixo "sch"
end;

function StrToSchemaNFeABI(const s: String): TSchemaNFeABI;
var
  P: Integer;
  SchemaStr: String;
  CodSchema: Integer;
begin
  P := pos('_', s);

  if P > 0 then
    SchemaStr := copy(s, 1, P-1)
  else
    SchemaStr := s;

  if LeftStr(SchemaStr, 3) <> 'sch' then
    SchemaStr := 'sch' + SchemaStr;

  CodSchema := GetEnumValue(TypeInfo(TSchemaNFeABI), SchemaStr);

  if CodSchema = -1 then
    raise Exception.Create(Format('"%s" não é um valor TSchemaNFeABI válido.', [SchemaStr]));

  Result := TSchemaNFeABI(CodSchema);
end;

function LayOutNFeABIToSchema(const t: TLayOutNFeABI): TSchemaNFeABI;
begin
  case t of
    LayNFeABIAutorizacao:   Result := schNFeABI;
    LayNFeABIConsulta:      Result := schconsSitNFeABI;
    LayNFeABIStatusServico: Result := schconsStatServNFeABI;
    LayNFeABIEvento:        Result := schEventoNFeABI;
  else
    Result := schErroNFeABI;
  end;
end;

function LayOutNFeABIToServico(const t: TLayOutNFeABI): String;
begin
  result := TLayOutNFeABIArrayStrings[t];
end;

function ServicoToLayOutNFeABI(const s: String): TLayOutNFeABI;
var
  idx: TLayOutNFeABI;
begin
  for idx := Low(TLayOutNFeABIArrayStrings) to High(TLayOutNFeABIArrayStrings) do
  begin
    if (TLayOutNFeABIArrayStrings[idx] = s) then
    begin
      result := idx;
      exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string inválido para TLayOutNFeABI: %s', [s]);
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

function tpNFToStr(const t: TtpNF): string;
begin
  result := TtpNFArrayStrings[t];
end;

function StrTotpNF(const s: string): TtpNF;
var
  idx: TtpNF;
begin
  for idx := Low(TtpNFArrayStrings) to High(TtpNFArrayStrings) do
  begin
    if (TtpNFArrayStrings[idx] = s) then
    begin
      result := idx;
      exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string inválido para TtpNF: %s', [s]);
end;

function tpImpToStr(const t: TtpImp): string;
begin
  result := TtpImpArrayStrings[t];
end;

function StrTotpImp(const s: string): TtpImp;
var
  idx: TtpImp;
begin
  for idx := Low(TtpImpArrayStrings) to High(TtpImpArrayStrings) do
  begin
    if (TtpImpArrayStrings[idx] = s) then
    begin
      result := idx;
      exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string inválido para TtpImp: %s', [s]);
end;

function finNFeToStr(const t: TfinNFe): string;
begin
  result := TfinNFeArrayStrings[t];
end;

function StrTofinNFe(const s: string): TfinNFe;
var
  idx: TfinNFe;
begin
  for idx := Low(TfinNFeArrayStrings) to High(TfinNFeArrayStrings) do
  begin
    if (TfinNFeArrayStrings[idx] = s) then
    begin
      result := idx;
      exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string inválido para TfinNFe: %s', [s]);
end;

function tpEmitToStr(const t: TtpEmit): String;
begin
  result := TtpEmitArrayStrings[t];
end;

function StrTotpEmit(const s: String): TtpEmit;
var
  idx: TtpEmit;
begin
  for idx := Low(TtpEmitArrayStrings) to High(TtpEmitArrayStrings) do
  begin
    if (TtpEmitArrayStrings[idx] = s) then
    begin
      result := idx;
      exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string inválido para TtpEmit: %s', [s]);
end;

function indContribToStr(const t: TindContrib): String;
begin
  result := TindContribArrayStrings[t];
end;

function StrToindContrib(const s: String): TindContrib;
var
  idx: TindContrib;
begin
  for idx := Low(TindContribArrayStrings) to High(TindContribArrayStrings) do
  begin
    if (TindContribArrayStrings[idx] = s) then
    begin
      result := idx;
      exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string inválido para TindContrib: %s', [s]);
end;

function TipoToStr(const t: Ttipo): String;
begin
  result := TtipoArrayStrings[t];
end;

function StrToTipo(const s: String): Ttipo;
var
  idx: Ttipo;
begin
  for idx := Low(TtipoArrayStrings) to High(TtipoArrayStrings) do
  begin
    if (TtipoArrayStrings[idx] = s) then
    begin
      result := idx;
      exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string inválido para Ttipo: %s', [s]);
end;

function uareaTotalToStr(const t: TuareaTotal): String;
begin
  result := TuareaTotalArrayStrings[t];
end;

function StrTouareaTotal(const s: String): TuareaTotal;
var
  idx: TuareaTotal;
begin
  for idx := Low(TuareaTotalArrayStrings) to High(TuareaTotalArrayStrings) do
  begin
    if (TuareaTotalArrayStrings[idx] = s) then
    begin
      result := idx;
      exit;
    end;
  end;

  raise EACBrException.CreateFmt('Valor string inválido para TuareaTotal: %s', [s]);
end;

initialization
  RegisterStrToTpEventoDFe(StrTotpEventoNFeABI, 'NFeABI');

end.

