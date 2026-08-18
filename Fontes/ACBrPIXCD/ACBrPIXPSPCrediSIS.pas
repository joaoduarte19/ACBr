{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{ - Gilmar Brizolla Dos Santos                                                 }
{ - Gheysiell Camargo Santana                                                  }
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

(*

  Documentação
  https://wiki-erp.ixcsoft.com.br/documentacao/guias-tutoriais/carteira-de-cobranca/integracoes-carteira-de-cobranca/integracoes-bancarias---api/integracoes/api-banco-credisis.html

*)

{$I ACBr.inc}

unit ACBrPIXPSPCrediSIS;

interface

uses
  Classes, SysUtils,
  {$IFDEF RTL230_UP}ACBrBase,{$ENDIF RTL230_UP}
  ACBrPIXCD, ACBrOpenSSLUtils;

const
  cCrediSISURLSandbox = 'https://pix-pgtos-h.api.credisis.coop.br';
  cCrediSISURLProducao = 'https://pix-pgtos.api.credisis.com.br';
  cCrediSISPathAuthToken = '/auth/token';
  cCrediSISPathAPIPix = '/qr';
  cCrediSISURLAuthTeste = cCrediSISURLSandbox+cCrediSISPathAuthToken;
  cCrediSISURLAuthProducao = cCrediSISURLProducao+cCrediSISPathAuthToken;

type

  { TACBrPIXPSPCrediSIS }
  
  {$IFDEF RTL230_UP}
  [ComponentPlatformsAttribute(piacbrAllPlatforms)]
  {$ENDIF RTL230_UP}
  TACBrPSPCrediSIS = class(TACBrPSPCertificate)
  private
    fAgencia: String;
    fConta: String;

    procedure QuandoReceberRespostaEndPoint(const aEndPoint, aURL, aMethod: String;
      var aResultCode: Integer; var aRespostaHttp: AnsiString);
  protected
    procedure ConfigurarBody(const aMethod, aEndPoint: String; var aBody: String); override;

    function ObterURLAmbiente(const Ambiente: TACBrPixCDAmbiente): String; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Clear; override;
    procedure Autenticar; override;
  published
    property Agencia: String read fAgencia write fAgencia;
    property Conta: String read fConta write fConta;
  end;

implementation

uses
  synautil, synacode,
  DateUtils,
  ACBrJSON,
  ACBrUtil.Strings, ACBrUtil.DateTime;

constructor TACBrPSPCrediSIS.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fpQuandoReceberRespostaEndPoint := QuandoReceberRespostaEndPoint;
  Clear;
end;

procedure TACBrPSPCrediSIS.Clear;
begin
  inherited Clear;
end;

procedure TACBrPSPCrediSIS.Autenticar;
var
  wURL, Body: String;
  wRespostaHttp: AnsiString;
  wResultCode, sec: Integer;
  js, jsBody: TACBrJSONObject;
begin
  LimparHTTP;

  if (ACBrPixCD.Ambiente = ambProducao) then
    wURL := cCrediSISURLAuthProducao
  else
    wURL := cCrediSISURLAuthTeste;

  jsBody := TACBrJSONObject.Create;

  try
    jsBody
      .AddPair('grant_type', 'client_credentials')
      .AddPair('client_id', ClientID)
      .AddPair('client_secret', ClientSecret)
      .AddPair('scope', 'internal/pix.cob.read internal/pix.cob.write'); 
    Body := jsBody.ToJSON;
    WriteStrToStream(Http.Document, Body);
    Http.MimeType := CContentTypeApplicationJSon;
  finally
    jsBody.Free;
  end;
  
  TransmitirHttp(ChttpMethodPOST, wURL, wResultCode, wRespostaHttp);

  if (wResultCode = HTTP_OK) then
  begin
    js := TACBrJSONObject.Parse(wRespostaHttp);
    try
      fpToken := js.AsString['access_token'];
      sec := js.AsInteger['expires_in'];
      fpRefreshToken := EmptyStr;
    finally
      js.Free;
    end;

    if (Trim(fpToken) = '') then
      DispararExcecao(EACBrPixHttpException.Create(ACBrStr(sErroAutenticacao)));

    fpValidadeToken := IncSecond(Now, sec);
    fpAutenticado := True;
  end
  else
    DispararExcecao(EACBrPixHttpException.CreateFmt( sErroHttp,
      [Http.ResultCode, ChttpMethodPOST, wURL]));
end;

procedure TACBrPSPCrediSIS.QuandoReceberRespostaEndPoint(const aEndPoint, aURL,
  aMethod: String; var aResultCode: Integer; var aRespostaHttp: AnsiString);
var
  jsCrediSIS, jsBacen, jsCalendario: TACBrJSONObject;
  PayloadDecodificado, wTxId, wLocation, wBaseURL: String;
  dtCriacao, dtExpiracao: TDateTime;
  iExpiracaoSegundos: Integer;
  sCriacao, sExpiracao: String;
  jsPixArray: TACBrJSONArray;
  jsPixItem, jsCompValor, jsOriginal: TACBrJSONObject;
begin
  if (UpperCase(AMethod) = ChttpMethodPOST) and
    (AEndPoint = cEndPointCob) and
    (AResultCode = HTTP_OK)
  then
    AResultCode := HTTP_CREATED;

  if not (AResultCode in [HTTP_OK, HTTP_CREATED]) then
    Exit;

  if Trim(String(aRespostaHttp)) = '' then
    Exit;

  if AEndPoint <> cEndPointCob then
    Exit;

  if ACBrPixCD.Ambiente = ambProducao then
    wBaseURL := cCrediSISURLProducao
  else
    wBaseURL := cCrediSISURLSandbox;

  if (UpperCase(AMethod) = ChttpMethodPOST) then
  begin
    jsCrediSIS := TACBrJSONObject.Parse(ARespostaHttp);

    if Assigned(jsCrediSIS) then
    begin
      jsBacen := TACBrJSONObject.Create;

      try
        wTxId := jsCrediSIS.AsString['idConciliacao'];
        wLocation := wBaseURL + '/cob/' + wTxId;
        PayloadDecodificado := DecodeBase64(jsCrediSIS.AsString['payloadBase64']);

        jsBacen.AddPair('txid', wTxId);
        jsBacen.AddPair('location', wLocation);
        jsBacen.AddPair('pixCopiaECola', PayloadDecodificado);
        jsBacen.AddPair('status', 'ATIVA');

        jsCalendario := TACBrJSONObject.Create;
        jsCalendario.AddPair('criacao', FormatDateTime('yyyy-mm-dd"T"hh:nn:ss"Z"', Now));
        jsCalendario.AddPair('expiracao', 3600);
        jsBacen.AddPair('calendario', jsCalendario);

        aRespostaHttp := AnsiString(jsBacen.ToJSON);
      finally
        jsBacen.Free;
        jsCrediSIS.Free;
      end;
    end;
  end
  else if (UpperCase(AMethod) = ChttpMethodGET) then
  begin
    jsCrediSIS := TACBrJSONObject.Parse(ARespostaHttp);

    if Assigned(jsCrediSIS) then
    begin
      try
        sCriacao   := jsCrediSIS.AsJSONObject['calendario'].AsString['criacao'];
        sExpiracao := jsCrediSIS.AsJSONObject['calendario'].AsString['expiracao'];

        if Length(sCriacao) > 19 then
          sCriacao := Copy(sCriacao, 1, 19);

        if Length(sExpiracao) > 19 then
          sExpiracao := Copy(sExpiracao, 1, 19);

        dtCriacao   := Iso8601ToDateTime(sCriacao);
        dtExpiracao := Iso8601ToDateTime(sExpiracao);

        iExpiracaoSegundos := SecondsBetween(dtExpiracao, dtCriacao);

        if iExpiracaoSegundos <= 0 then
          iExpiracaoSegundos := 3600;

        jsCalendario := TACBrJSONObject.Create;
        jsCalendario.AddPair('criacao', dtCriacao);
        jsCalendario.AddPair('expiracao', iExpiracaoSegundos);
        jsCrediSIS.AsJSONObject['calendario'].AddPair('expiracao', iExpiracaoSegundos);

        jsPixArray := TACBrJSONArray.Create;

        jsPixItem := TACBrJSONObject.Create;
        jsPixItem.AddPair('txid', jsCrediSIS.AsString['txid']);
        jsPixItem.AddPair('valor', jsCrediSIS.AsJSONObject['valor'].AsCurrency['original']);

        jsOriginal  := TACBrJSONObject.Create;
        jsOriginal.AddPair('valor', jsCrediSIS.AsJSONObject['valor'].AsCurrency['original']);
        jsCompValor := TACBrJSONObject.Create;
        jsCompValor.AddPair('original', jsOriginal);

        jsPixItem.AddPair('componentesValor', jsCompValor);

        jsPixItem.AddPair('chave', jsCrediSIS.AsString['chave']);
        jsPixItem.AddPair('horario', FormatDateTime('yyyy-mm-dd"T"hh:nn:ss"Z"', dtExpiracao));

        jsPixArray.AddElementJSON(jsPixItem);

        jsCrediSIS.AddPair('pix', jsPixArray);

        aRespostaHttp := AnsiString(jsCrediSIS.ToJSON);
      finally
        jsCrediSIS.Free;
      end;
    end;
  end;
end;

function TACBrPSPCrediSIS.ObterURLAmbiente(const Ambiente: TACBrPixCDAmbiente): String;
begin
  if (Ambiente = ambProducao) then
    Result := cCrediSISURLProducao
  else
    Result := cCrediSISURLSandbox;

  Result := Result + cCrediSISPathAPIPix;
end;

procedure TACBrPSPCrediSIS.ConfigurarBody(const aMethod, aEndPoint: String;
  var aBody: String);
var
  wBody, wRecebedor, wCalendario: TACBrJSONObject;
  wValor: TACBrJSONObject;
  wInfoAdicionais: TACBrJSONArray;
  sDataExpiracao: String;
  sSolicitacaoPagador: String;
begin
  if Trim(aBody) = '' then
    Exit;

  wBody := TACBrJSONObject.Parse(aBody);
  if not Assigned(wBody) then
    Exit;

  try
    wValor := wBody.AsJSONObject['valor'];

    if Assigned(wValor) then
      wValor.AddPair('modalidadeAlteracao', 0);

    sDataExpiracao := FormatDateTime('yyyy-mm-dd"T"18:00:00"Z"', DateUtils.IncDay(Date, 1));

    wCalendario := wBody.AsJSONObject['calendario'];

    if Assigned(wCalendario) then
      wCalendario.AddPair('expiracao', sDataExpiracao);

    wRecebedor := TACBrJSONObject.Create;
    wRecebedor.AddPair('nome', ACBrPixCD.Recebedor.Nome);
    wRecebedor.AddPair('cidade', ACBrPixCD.Recebedor.Cidade);
    wRecebedor.AddPair('agencia', fAgencia);
    wRecebedor.AddPair('conta', fConta);

    wBody.AddPair('recebedor', wRecebedor);

    wInfoAdicionais := TACBrJSONArray.Create;
    wBody.AddPair('infoAdicionais', wInfoAdicionais);

    if Assigned(epCob) and Assigned(epCob.CobRevisada) then
    begin
      sSolicitacaoPagador := epCob.CobRevisada.solicitacaoPagador;
      if sSolicitacaoPagador = '' then
        sSolicitacaoPagador := 'Solicitacao PIX';
      wBody.AddPair('solicitacaoPagador', sSolicitacaoPagador);
    end;

    aBody := wBody.ToJSON;
  finally
    wBody.Free;
  end;
end;

end.
