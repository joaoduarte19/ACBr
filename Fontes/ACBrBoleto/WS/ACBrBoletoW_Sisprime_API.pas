{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Colaboradores nesse arquivo:  Juliomar Marchetti                             }
{                               Joao Vitor Bogo                                }
{                                                                              }
{ Colaboradores nesse arquivo:  José M S Junior, Victor H Gonzales - Pandaaa   }
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

unit ACBrBoletoW_Sisprime_API;

interface

uses
  Classes,
  SysUtils,
  ACBrBoletoWS,
  ACBrBoletoConversao,
  StrUtils,
  DateUtils,
  ACBrBoleto,
  ACBrBoletoWS.Rest,
  ACBrJSON,
  ACBrBoletoWS.Rest.OAuth,
  ACBr.Auth.JWT;

type
  { TBoletoW_Sisprime_API }
  TBoletoW_Sisprime_API = class(TBoletoWSREST)
  private
    function DateTimeToDtSisprime(const AValue: TDateTime): string;
    function GerarJWT: string;
    procedure RequisicaoEnviar(const AOcorrencia: string);
    procedure RequisicaoConsultar;
  protected
    procedure DefinirURL; override;
    procedure DefinirContentType; override;
    procedure GerarHeader; override;
    procedure GerarDados; override;
    procedure DefinirAuthorization; override;
    function GerarTokenAutenticacao: string; override;
  public
    constructor Create(ABoletoWS: TBoletoWS); override;
    function GerarRemessa: string; override;
    function Enviar: Boolean; override;
  end;

const
  C_SISPRIME_URL_PROD = 'https://sisprimebr.cobexpress.com.br/webservice';
  C_SISPRIME_URL_HOM  = 'https://homologa-ws.cobexpress.com.br/webservice';
  C_SISPRIME_CONTENT  = 'application/json';

implementation

uses
  ACBrUtil.Base,
  ACBrUtil.Strings,
  ACBrUtil.DateTime,
  ACBrUtil.Compatibilidade,
  Math;

{ TBoletoW_Sisprime_API }

constructor TBoletoW_Sisprime_API.Create(ABoletoWS: TBoletoWS);
begin
  inherited Create(ABoletoWS);
end;

function TBoletoW_Sisprime_API.DateTimeToDtSisprime(const AValue: TDateTime): string;
begin
  Result := FormatDateBr(AValue, 'YYYY-MM-DD');
end;

function TBoletoW_Sisprime_API.GerarJWT: string;
var
  LHeaderB64, LPayloadB64, LMessage: string;
  LIat: Int64;
  LHmac: TBytes;
  LChaveGeral, LChaveConta, LPayloadJson: string;
begin
  LChaveGeral := Boleto.Cedente.CedenteWS.ClientID;
  LChaveConta := Boleto.Cedente.CedenteWS.ClientSecret;
//  LIat := DateTimeToUnix(Now, False);

  // JWT Header: {"alg":"HS512"}
//  LHeaderB64 := TNetEncoding.Base64URL.EncodeBytesToString( TEncoding.UTF8.GetBytes('{"alg":"HS512"}'));

  // JWT Payload: {"iat":X,"exp":X+600,"iss":"cobexpress","hash":"<chave_conta>"}
  LPayloadJson := Format('{"iat":%d,"exp":%d,"iss":"cobexpress","hash":"%s"}', [LIat, LIat + 600, LChaveConta]);
//  LPayloadB64 := TNetEncoding.Base64URL.EncodeBytesToString(TEncoding.UTF8.GetBytes(LPayloadJson));

  LMessage := LHeaderB64 + '.' + LPayloadB64;

  // HMAC-SHA512 signature using chave_geral as key
  //LHmac := THashSHA2.GetHMACAsBytes(
  //  TEncoding.UTF8.GetBytes(LMessage),
  //  TEncoding.UTF8.GetBytes(LChaveGeral),
  //  THashSHA2.TSHA2Version.SHA512);

//  Result := LMessage + '.' + TNetEncoding.Base64URL.EncodeBytesToString(LHmac);
end;

procedure TBoletoW_Sisprime_API.DefinirURL;
begin
  case Boleto.Configuracoes.WebService.Operacao of
    tpInclui, tpAltera, tpBaixa, tpCancelar:
      begin
        FPURL.URLProducao    := C_SISPRIME_URL_PROD;
        FPURL.URLHomologacao := C_SISPRIME_URL_HOM;
        FPURL.SetPathURI('/enviar-boleto');
      end;
    tpConsultaDetalhe:
      begin
        FPURL.URLProducao    := C_SISPRIME_URL_PROD;
        FPURL.URLHomologacao := C_SISPRIME_URL_HOM;
        FPURL.SetPathURI('/consultar-boleto');
      end;
  else
    raise EACBrBoletoWSException.Create(ClassName +
      Format(S_OPERACAO_NAO_IMPLEMENTADO,
        [TipoOperacaoToStr(Boleto.Configuracoes.WebService.Operacao)]));
  end;
end;

procedure TBoletoW_Sisprime_API.DefinirContentType;
begin
  FPContentType := C_SISPRIME_CONTENT;
end;

procedure TBoletoW_Sisprime_API.GerarHeader;
begin
  DefinirContentType;
end;

procedure TBoletoW_Sisprime_API.DefinirAuthorization;
begin
  FPAuthorization := '';
end;

function TBoletoW_Sisprime_API.GerarTokenAutenticacao: string;
begin
  Result := GerarJWT;
end;

procedure TBoletoW_Sisprime_API.RequisicaoEnviar(const AOcorrencia: string);
var
  LJson, LTitulo: TACBrJSONObject;
  LMensagens: TACBrJSONArray;
  I: Integer;
begin
  FMetodoHTTP := htPOST;

  LJson := TACBrJSONObject.Create;
  try
    LJson.AddPair('token', GerarJWT);

    LTitulo := TACBrJSONObject.Create;
    LTitulo.AddPair('ocorrencia_remessa', AOcorrencia);
    LTitulo.AddPair('nosso_numero',      PadLeft(ATitulo.NossoNumero, 11, '0'));
    LTitulo.AddPair('numero_documento',  ATitulo.NumeroDocumento);
    LTitulo.AddPair('data_emissao',      DateTimeToDtSisprime(ATitulo.DataDocumento));
    LTitulo.AddPair('data_vencimento',   DateTimeToDtSisprime(ATitulo.Vencimento));
    LTitulo.AddPair('valor_documento',   Format('%.2f', [ATitulo.ValorDocumento]));
    LTitulo.AddPair('especie_documento', ATitulo.EspecieDoc);

    // Protesto/negativacao: 0=nao, 1=protesto, 2=negativacao
    if ATitulo.DiasDeProtesto > 0 then
      LTitulo.AddPair('tipo_protesto_negativacao', '1')
    else
      LTitulo.AddPair('tipo_protesto_negativacao', '0');

    // Juros mensais (%)
    if ATitulo.ValorMoraJuros > 0 then
      LTitulo.AddPair('percentual_juros', Format('%.2f', [ATitulo.ValorMoraJuros]))
    else
      LTitulo.AddPair('percentual_juros', '0.00');

    // Multa por atraso (%)
    if ATitulo.PercentualMulta > 0 then
      LTitulo.AddPair('percentual_multa', Format('%.2f', [ATitulo.PercentualMulta]))
    else
      LTitulo.AddPair('percentual_multa', '0.00');

    // Pagador
    LTitulo.AddPair('codigo_pagador',                 OnlyNumber(ATitulo.Sacado.CNPJCPF));

    if ATitulo.Sacado.Pessoa = pJuridica then
      LTitulo.AddPair('tipo_inscricao_pagador', '2')
    else
      LTitulo.AddPair('tipo_inscricao_pagador', '1');

    // Sisprime nao aceita acentos em campos de endereco/nome do pagador
    LTitulo.AddPair('inscricao_pagador',              OnlyNumber(ATitulo.Sacado.CNPJCPF));
    LTitulo.AddPair('nome_pagador',                   TiraAcentos(ATitulo.Sacado.NomeSacado));
    LTitulo.AddPair('logradouro_pagador',              TiraAcentos(ATitulo.Sacado.Logradouro));
    LTitulo.AddPair('numero_logradouro_pagador',       ATitulo.Sacado.Numero);
    LTitulo.AddPair('complemento_logradouro_pagador',  TiraAcentos(ATitulo.Sacado.Complemento));
    LTitulo.AddPair('cep_pagador',                    OnlyNumber(ATitulo.Sacado.CEP));
    LTitulo.AddPair('bairro_pagador',                 TiraAcentos(ATitulo.Sacado.Bairro));
    LTitulo.AddPair('municipio_pagador',              TiraAcentos(ATitulo.Sacado.Cidade));
    LTitulo.AddPair('uf_pagador',                     ATitulo.Sacado.UF);
    LTitulo.AddPair('endereco_eletronico_pagador',    ATitulo.Sacado.Email);

    // Mensagens (max 4 linhas)
    if ATitulo.Mensagem.Count > 0 then
    begin
      LMensagens := TACBrJSONArray.Create;
      for I := 0 to Min(ATitulo.Mensagem.Count - 1, 3) do
        LMensagens.AddElement(ATitulo.Mensagem[I]);
      LTitulo.AddPair('linhas_mensagem', LMensagens);
    end;

    LJson.AddPair('titulo', LTitulo);
    FPDadosMsg := LJson.ToJSON;
  finally
    LJson.Free;
  end;
end;

procedure TBoletoW_Sisprime_API.RequisicaoConsultar;
var
  LJson: TACBrJSONObject;
begin
  FMetodoHTTP := htPOST;
  LJson := TACBrJSONObject.Create;
  try
    LJson.AddPair('token',     GerarJWT);
    LJson.AddPair('id_boleto', ATitulo.NossoNumeroCorrespondente);
    FPDadosMsg := LJson.ToJSON;
  finally
    LJson.Free;
  end;
end;

procedure TBoletoW_Sisprime_API.GerarDados;
begin
  DefinirURL;
  // Sisprime ocorrencia_remessa (CNAB 240): 01=registro, 02=baixa, 06=alteracao vencimento
  case Boleto.Configuracoes.WebService.Operacao of
    tpInclui:                       RequisicaoEnviar('01');
    tpAltera:                       RequisicaoEnviar('06');
    tpBaixa, tpCancelar:            RequisicaoEnviar('02');
    tpConsulta, tpConsultaDetalhe:  RequisicaoConsultar;
  else
    raise EACBrBoletoWSException.Create(ClassName +
      Format(S_OPERACAO_NAO_IMPLEMENTADO,
        [TipoOperacaoToStr(Boleto.Configuracoes.WebService.Operacao)]));
  end;
end;

function TBoletoW_Sisprime_API.GerarRemessa: string;
begin
  GerarHeader;
  GerarDados;
  Result := FPDadosMsg;
end;

function TBoletoW_Sisprime_API.Enviar: Boolean;
begin
  GerarHeader;
  GerarDados;
  Executar;
  Result := (BoletoWS.RetornoBanco.HTTPResultCode in [200..207]);
end;

end.
