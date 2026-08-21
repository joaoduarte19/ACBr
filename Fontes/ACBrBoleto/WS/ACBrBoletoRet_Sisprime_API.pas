{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2024 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:  Juliomar Marchetti                             }
{                               Joao Vitor Bogo                                }
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

unit ACBrBoletoRet_Sisprime_API;

interface

uses
  Classes,
  SysUtils,
  ACBrBoleto,
  ACBrBoletoWS,
  ACBrBoletoRetorno,
  ACBrBoletoWS.Rest,
  ACBrJSON,
  ACBrUtil.Base,
  DateUtils;

type
  { TRetornoEnvio_Sisprime_API }
  TRetornoEnvio_Sisprime_API = class(TRetornoEnvioREST)
  private
    function DateSisprimeToDateTime(const AValue: string): TDateTime;
    procedure LerRetornoEnviar(const ARetornoWS: TACBrBoletoRetornoWS;const LDadosTitulo: TACBrJSONObject);
    procedure LerRetornoConsultar(const ARetornoWS: TACBrBoletoRetornoWS;const LJsonObject, LDadosTitulo: TACBrJSONObject);
  public
    constructor Create(ABoletoWS: TACBrBoleto); override;
    destructor Destroy; override;
    function LerRetorno(const ARetornoWS: TACBrBoletoRetornoWS;AIndex: Integer = 0): Boolean; reintroduce;
    function LerListaRetorno: Boolean; override;
    function RetornoEnvio(const AIndex: Integer): Boolean; override;
  end;

implementation

uses
  ACBrBoletoConversao;

{ TRetornoEnvio_Sisprime_API }

constructor TRetornoEnvio_Sisprime_API.Create(ABoletoWS: TACBrBoleto);
begin
  inherited Create(ABoletoWS);
end;

destructor TRetornoEnvio_Sisprime_API.Destroy;
begin
  inherited Destroy;
end;

function TRetornoEnvio_Sisprime_API.DateSisprimeToDateTime(const AValue: string): TDateTime;
var
  LAno, LMes, LDia: string;
begin
  // Format: YYYY-MM-DD
  LAno := Copy(AValue, 1, 4);
  LMes := Copy(AValue, 6, 2);
  LDia := Copy(AValue, 9, 2);
  Result := StrToDateDef(LDia + '/' + LMes + '/' + LAno, 0);
end;

procedure TRetornoEnvio_Sisprime_API.LerRetornoEnviar(const ARetornoWS: TACBrBoletoRetornoWS;const LDadosTitulo: TACBrJSONObject);
begin
  // Campos comuns apos registro do boleto
  ARetornoWS.DadosRet.IDBoleto.NossoNum        := LDadosTitulo.AsString['nosso_numero'];
  ARetornoWS.DadosRet.TituloRet.NossoNumero    := LDadosTitulo.AsString['nosso_numero'];
  ARetornoWS.DadosRet.IDBoleto.LinhaDig        := LDadosTitulo.AsString['linha_digitavel'];
  ARetornoWS.DadosRet.TituloRet.LinhaDig       := LDadosTitulo.AsString['linha_digitavel'];
  ARetornoWS.DadosRet.IDBoleto.CodBarras       := LDadosTitulo.AsString['codigo_barras'];
  ARetornoWS.DadosRet.TituloRet.CodBarras      := LDadosTitulo.AsString['codigo_barras'];
  ARetornoWS.DadosRet.TituloRet.SeuNumero      := LDadosTitulo.AsString['numero_documento'];
  // id_boleto = UUID unico do boleto na Sisprime (usado em consultar-boleto)
  ARetornoWS.DadosRet.TituloRet.NossoNumeroCorrespondente :=
    LDadosTitulo.AsString['id_boleto'];
  ARetornoWS.indicadorContinuidade := False;
end;

procedure TRetornoEnvio_Sisprime_API.LerRetornoConsultar(const ARetornoWS: TACBrBoletoRetornoWS;const LJsonObject, LDadosTitulo: TACBrJSONObject);
var
  LLancamentos: TACBrJSONArray;
  LLanc: TACBrJSONObject;
  I: Integer;
begin
  ARetornoWS.DadosRet.IDBoleto.NossoNum       := LDadosTitulo.AsString['nosso_numero'];
  ARetornoWS.DadosRet.TituloRet.NossoNumero   := LDadosTitulo.AsString['nosso_numero'];
  ARetornoWS.DadosRet.IDBoleto.LinhaDig       := LDadosTitulo.AsString['linha_digitavel'];
  ARetornoWS.DadosRet.TituloRet.LinhaDig      := LDadosTitulo.AsString['linha_digitavel'];
  ARetornoWS.DadosRet.IDBoleto.CodBarras      := LDadosTitulo.AsString['codigo_barras'];
  ARetornoWS.DadosRet.TituloRet.CodBarras     := LDadosTitulo.AsString['codigo_barras'];
  ARetornoWS.DadosRet.TituloRet.SeuNumero     := LDadosTitulo.AsString['numero_documento'];
  ARetornoWS.DadosRet.TituloRet.NossoNumeroCorrespondente := LDadosTitulo.AsString['id_boleto'];
  ARetornoWS.indicadorContinuidade := False;

  ARetornoWS.DadosRet.TituloRet.Vencimento    := DateSisprimeToDateTime(LDadosTitulo.AsString['data_vencimento']);
  ARetornoWS.DadosRet.TituloRet.ValorDocumento := StrToCurrDef(StringReplace(LDadosTitulo.AsString['valor_documento'], ',', '.', [rfReplaceAll]), 0);
  ARetornoWS.DadosRet.TituloRet.ValorAtual := ARetornoWS.DadosRet.TituloRet.ValorDocumento;

  // Situacao do titulo (usada em ConverteStatusTitulo no Eficaz)
  ARetornoWS.DadosRet.TituloRet.CodigoEstadoTituloCobranca := LDadosTitulo.AsString['codigo_situacao'];
  ARetornoWS.DadosRet.TituloRet.EstadoTituloCobranca := LDadosTitulo.AsString['descricao_situacao'];

  // Ocorrencias
  ARetornoWS.DadosRet.TituloRet.CodigoOcorrenciaCartorio := LDadosTitulo.AsString['codigo_ocorrencia_retorno'];

  // PIX QR Code (campo qr_code = EMV string)
  if LDadosTitulo.ValueExists('qr_code') then
    ARetornoWS.DadosRet.TituloRet.EMV := LDadosTitulo.AsString['qr_code'];

  // Lancamentos: busca o primeiro CREDITO para obter valor e data de pagamento
  if LJsonObject.IsJSONArray('lancamentos') then
  begin
    LLancamentos := LJsonObject.AsJSONArray['lancamentos'];
    for I := 0 to LLancamentos.Count - 1 do
    begin
      LLanc := LLancamentos.ItemAsJSONObject[I];
      if UpperCase(LLanc.AsString['tipo_lancamento']) = 'CREDITO' then
      begin
        ARetornoWS.DadosRet.TituloRet.ValorPago :=
          StrToCurrDef(StringReplace(LLanc.AsString['valor_lancamento'], ',', '.', [rfReplaceAll]), 0);
        ARetornoWS.DadosRet.TituloRet.ValorRecebido :=
          ARetornoWS.DadosRet.TituloRet.ValorPago;
        ARetornoWS.DadosRet.TituloRet.DataBaixa :=
          DateSisprimeToDateTime(LLanc.AsString['data_lancamento']);
        ARetornoWS.DadosRet.TituloRet.DataMovimento :=
          ARetornoWS.DadosRet.TituloRet.DataBaixa;
        ARetornoWS.DadosRet.TituloRet.DataCredito :=
          ARetornoWS.DadosRet.TituloRet.DataBaixa;
        Break;
      end;
    end;
  end;
end;

function TRetornoEnvio_Sisprime_API.LerRetorno(const ARetornoWS: TACBrBoletoRetornoWS;AIndex: Integer = 0): Boolean;
var
  LJsonObject, LDadosTitulo, LJsonInc: TACBrJSONObject;
  LJsonArray: TACBrJSONArray;
  LRejeicao: TACBrBoletoRejeicao;
  LStatusRetorno: string;
  LTipoOperacao: TOperacao;
  LRetWSObj: string;
  I: Integer;
begin
  Result := True;
  LTipoOperacao := ACBrBoleto.Configuracoes.WebService.Operacao;
  ARetornoWS.HTTPResultCode  := HTTPResultCode;
  ARetornoWS.JSONEnvio       := EnvWs;
  ARetornoWS.Header.Operacao := LTipoOperacao;

  if RetWS = '' then
    Exit;

  // Sisprime: respostas vem encapsuladas em array JSON [{...}]
  LRetWSObj := Trim(RetWS);
  if (Length(LRetWSObj) >= 2) and (LRetWSObj[1] = '[') and (LRetWSObj[Length(LRetWSObj)] = ']') then
    LRetWSObj := Copy(LRetWSObj, 2, Length(LRetWSObj) - 2);

  LJsonObject := TACBrJSONObject.Parse(LRetWSObj);
  try
    try
      ARetornoWS.JSON := LJsonObject.ToJSON;
      LStatusRetorno  := LJsonObject.AsString['status_retorno'];

      // Sisprime: status_retorno "0" = sucesso; negativo = erro
      if LStatusRetorno <> '0' then
      begin
        LRejeicao          := ARetornoWS.CriarRejeicaoLista;
        LRejeicao.Codigo   := LStatusRetorno;
        LRejeicao.Mensagem := LJsonObject.AsString['descricao'];

        // Sisprime devolve detalhes em "inconsistencias":[{codigo,descricao}]
        if LJsonObject.IsJSONArray('inconsistencias') then
        begin
          LJsonArray := LJsonObject.AsJSONArray['inconsistencias'];
          for I := 0 to LJsonArray.Count - 1 do
          begin
            LJsonInc := LJsonArray.ItemAsJSONObject[I];
            if Assigned(LJsonInc) then
            begin
              LRejeicao          := ARetornoWS.CriarRejeicaoLista;
              LRejeicao.Codigo   := LJsonInc.AsString['codigo_inconsistencia'];
              LRejeicao.Mensagem := LJsonInc.AsString['descricao_inconsistencia'];
            end;
          end;
        end;
        Exit;
      end;

      if not LJsonObject.IsJSONObject('dados_titulo') then
        Exit;

      LDadosTitulo := LJsonObject.AsJSONObject['dados_titulo'];

      case LTipoOperacao of
        tpInclui, tpAltera:
          LerRetornoEnviar(ARetornoWS, LDadosTitulo);
        tpConsultaDetalhe:
          LerRetornoConsultar(ARetornoWS, LJsonObject, LDadosTitulo);
      end;
    except
      Result := False;
    end;
  finally
    LJsonObject.Free;
  end;
end;

function TRetornoEnvio_Sisprime_API.LerListaRetorno: Boolean;
begin
  Result := True;
end;

function TRetornoEnvio_Sisprime_API.RetornoEnvio(const AIndex: Integer): Boolean;
begin
  Result := LerRetorno(ACBrBoleto.ListadeBoletos[AIndex].RetornoWeb, AIndex);
end;

end.
