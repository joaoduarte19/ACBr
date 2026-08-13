{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2024 Daniel Simoes de Almeida               }
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

unit PortoSeguro.Provider;

interface

uses
  SysUtils,
  Classes,
  Variants,
  ACBrBase,
  ACBrDFe,
  ACBrDFeSSL,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrXmlDocument,
  ACBrANeDocumentos,
  ACBrANe.Classes,
  ACBrANe.Conversao,
  ACBrANe.ProviderProprio,
  ACBrANe.WebservicesBase,
  ACBrANe.WebServicesResponse;

type
  TACBrANeWebservicePortoSeguro = class(TACBrANeWebserviceRest)
  private
    FBound: string;
    FCookies: TStringList;
    FNomeArquivo: string;

    procedure CapturarCookies;
    function MontarCookieHeader: string;
    function MontarCampoFormData(const ANome, AValor: string): string;
    function MontarLoginUrlEncoded(const AUsuario, ASenha: string): string;
    function MontarMultipartUpload(const AXml: string): string;
    procedure EfetuarLogin;
  protected
    procedure SetHeaders(aHeaderReq: THTTPHeader); override;
  public
    constructor Create(AOwner: TACBrDFe; AMetodo: TMetodo; const AURL: string;
      const AMethod: string = 'POST'); reintroduce;
    destructor Destroy; override;

    function Enviar(const ACabecalho, AMSG: string): string; override;
    function Consultar(const ACabecalho, AMSG: string): string; override;

  end;

  TACBrANeProviderPortoSeguro = class (TACBrANeProviderProprio)
  private
    FpPath: string;
    FpMethod: string;
  protected
    procedure Configuracao; override;

    function CriarServiceClient(const AMetodo: TMetodo): TACBrANeWebservice; override;

    procedure PrepararEnviar(Response: TANeEnviarResponse); override;
    procedure TratarRetornoEnviar(Response: TANeEnviarResponse); override;

    procedure PrepararConsultar(Response: TANeConsultarResponse); override;
    procedure TratarRetornoConsultar(Response: TANeConsultarResponse); override;

    procedure ProcessarMensagemErros(RootNode: TACBrXmlNode;
                                     Response: TANeWebserviceResponse;
                                     const AListTag: string = '';
                                     const AMessageTag: string = ''); override;
  end;

var
  XmlDocumento: string;

implementation

uses
  StrUtils,
  synacode,
  ACBrUtil.Strings,
  ACBrUtil.Base,
  ACBrANe.Consts,
  ACBrDFeException,
  ACBrANe,
  ACBrANeConfiguracoes;

const
  CRLF = #13#10;

{ TACBrANeProviderPortoSeguro }

procedure TACBrANeProviderPortoSeguro.Configuracao;
begin
  inherited Configuracao;
  with ConfigSchemas do
  begin
    Enviar := 'ANe.xsd';
    Consultar := '***';

    Validar := False;
  end;
end;

function TACBrANeProviderPortoSeguro.CriarServiceClient(
  const AMetodo: TMetodo): TACBrANeWebservice;
var
  URL: string;
begin
  URL := GetWebServiceURL(AMetodo);

  if URL <> '' then
  begin
    URL := URL + FpPath;
    Result := TACBrANeWebservicePortoSeguro.Create(FAOwner, AMetodo, URL, FpMethod);
  end
  else
  begin
    if ConfigGeral.Ambiente = taProducao then
      raise EACBrDFeException.Create(ERR_SEM_URL_PRO)
    else
      raise EACBrDFeException.Create(ERR_SEM_URL_HOM);
  end;
end;

procedure TACBrANeProviderPortoSeguro.ProcessarMensagemErros(RootNode: TACBrXmlNode;
  Response: TANeWebserviceResponse; const AListTag, AMessageTag: string);
var
  ANode: TACBrXmlNode;
  AErro: TANeEventoCollectionItem;
  AAlerta: TANeEventoCollectionItem;
  Codigo, Mensagem: string;
begin
  ANode := RootNode;

  if ANode = nil then
    Exit;

  Codigo := ObterConteudoTag(ANode.Childrens.FindAnyNs('Codigo'), tcStr);
  Mensagem := ACBrStr(ObterConteudoTag(ANode.Childrens.FindAnyNs('Resultado'), tcStr));

  if (Codigo = '3') or (Codigo = '7') then
  begin
    AErro := Response.Erros.New;
    AErro.Codigo := Codigo;
    AErro.Descricao := ACBrStr(Mensagem);
    AErro.Correcao := '';
  end;

  if Codigo = '1' then
  begin
    AAlerta := Response.Alertas.New;
    AAlerta.Codigo := Codigo;
    AAlerta.Descricao := ACBrStr(Mensagem);
    AAlerta.Correcao := '';
  end;
end;

procedure TACBrANeProviderPortoSeguro.PrepararEnviar(Response: TANeEnviarResponse);
var
  Documento: TDocumento;
begin
  Documento := TACBrANe(FAOwner).Documentos.Items[0];

  XmlDocumento := Documento.ANe.xmlDFe;
  Response.ArquivoEnvio := XmlDocumento;

  FpPath := '';
  FpMethod := 'POST';
end;

function ExtrairJsonString(const AJson, ACampo: string): string;
var
  pIni, pFim: Integer;
  Marca: string;
begin
  Result := '';
  Marca := '"' + ACampo + '":"';
  pIni := Pos(Marca, AJson);

  if pIni = 0 then
    Exit;

  pIni := pIni + Length(Marca);
  pFim := PosEx('"', AJson, pIni);

  if pFim = 0 then
    pFim := Length(AJson) + 1;

  Result := Copy(AJson, pIni, pFim - pIni);
end;

procedure TACBrANeProviderPortoSeguro.TratarRetornoEnviar(Response: TANeEnviarResponse);
var
  AErro: TANeEventoCollectionItem;
  Retorno: string;
begin
  Retorno := Response.ArquivoRetorno;

  if Trim(Retorno) = '' then
  begin
    AErro := Response.Erros.New;
    AErro.Codigo := Cod201;
    AErro.Descricao := ACBrStr(Desc201);
    Exit;
  end;

  Response.Sucesso := (Pos('"success":1', Retorno) > 0) and
                      (Pos('"P":1', Retorno) > 0);

  if Response.Sucesso then
  begin
    Response.Protocolo := ExtrairJsonString(Retorno, 'prot');
    Response.DataHora := Now;
    Exit;
  end;

  AErro := Response.Erros.New;
  AErro.Codigo := Cod999;
  AErro.Correcao := '';

  if Pos('"logout"', Retorno) > 0 then
    AErro.Descricao := ACBrStr('Sessao nao autenticada. Verifique usuario e ' +
      'senha (utilize a senha da API, gerada no modulo Cadastro do Usuario ' +
      'do portal AverbePorto, e nao a senha de acesso web).')
  else if Pos('"D":1', Retorno) > 0 then
    AErro.Descricao := ACBrStr('Duplicado (xml preexistente).')
  else if Pos('"R":1', Retorno) > 0 then
    AErro.Descricao := ACBrStr('Rejeitado (xml nao parece ser do tipo certo).')
  else if Pos('"N":1', Retorno) > 0 then
    AErro.Descricao := ACBrStr('Negado (nao e xml ou zip).')
  else
    AErro.Descricao := ACBrStr('Erro inesperado: ') + Retorno;

  if pos('"error"',Retorno) >0 then
    AErro.Descricao := AErro.Descricao +#13#10+ ExtrairJsonString(Retorno, 'error');
end;

procedure TACBrANeProviderPortoSeguro.PrepararConsultar(
  Response: TANeConsultarResponse);
var
  AErro: TANeEventoCollectionItem;
begin
  if EstaVazio(Response.Chave) then
  begin
    AErro := Response.Erros.New;
    AErro.Codigo := Cod126;
    AErro.Descricao := ACBrStr(Desc126);
    Exit;
  end;

  FpPath := '?out=json&download=1&chave[]=' + Response.Chave;
  Response.ArquivoEnvio := FpPath;
  FpMethod := 'GET';
end;

procedure TACBrANeProviderPortoSeguro.TratarRetornoConsultar(
  Response: TANeConsultarResponse);
begin
  inherited;

end;

{ TACBrANeWebservicePortoSeguro }

constructor TACBrANeWebservicePortoSeguro.Create(AOwner: TACBrDFe;
  AMetodo: TMetodo; const AURL: string; const AMethod: string);
begin
  inherited Create(AOwner, AMetodo, AURL, AMethod, 'multipart/form-data');

  FCookies := TStringList.Create;
end;

destructor TACBrANeWebservicePortoSeguro.Destroy;
begin
  FCookies.Free;

  inherited Destroy;
end;

procedure TACBrANeWebservicePortoSeguro.SetHeaders(aHeaderReq: THTTPHeader);
begin
  inherited SetHeaders(aHeaderReq);
  aHeaderReq.AddHeader('User-Agent',
    'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20100101 Firefox/12.0');
  aHeaderReq.AddHeader('Accept', '*/*');

  if FCookies.Count > 0 then
    aHeaderReq.AddHeader('Cookie', MontarCookieHeader);
end;

procedure TACBrANeWebservicePortoSeguro.CapturarCookies;
var
  i, p: Integer;
  Linha, Cookie, Nome: string;
begin
  for i := 0 to FHttpClient.HeaderResp.Count - 1 do
  begin
    Linha := Trim(FHttpClient.HeaderResp[i]);

    if Pos('set-cookie:', LowerCase(Linha)) <> 1 then
      Continue;

    Cookie := Trim(Copy(Linha, Length('set-cookie:') + 1, Length(Linha)));

    p := Pos(';', Cookie);
    if p > 0 then
      Cookie := Trim(Copy(Cookie, 1, p - 1));

    p := Pos('=', Cookie);
    if p <= 1 then
      Continue;

    Nome := Copy(Cookie, 1, p - 1);
    FCookies.Values[Nome] := Copy(Cookie, p + 1, Length(Cookie));
  end;
end;

function TACBrANeWebservicePortoSeguro.MontarCookieHeader: string;
var
  i: Integer;
begin
  Result := '';

  for i := 0 to FCookies.Count - 1 do
  begin
    if Result <> '' then
      Result := Result + '; ';

    Result := Result + FCookies[i];
  end;
end;

function TACBrANeWebservicePortoSeguro.MontarCampoFormData(const ANome,
  AValor: string): string;
begin
  Result := '--' + FBound + CRLF +
            'Content-Disposition: form-data; name="' + ANome + '"' + CRLF +
            CRLF +
            AValor + CRLF;
end;

function TACBrANeWebservicePortoSeguro.MontarLoginUrlEncoded(const AUsuario,
  ASenha: string): string;
begin
  Result :=
    'mod=login' +
    '&comp=5' +
    '&user=' + string(EncodeURLElement(AnsiString(AUsuario))) +
    '&pass=' + string(EncodeURLElement(AnsiString(ASenha))) +
    '&dump=1';
end;

function TACBrANeWebservicePortoSeguro.MontarMultipartUpload(const AXml: string): string;
begin
  Result := MontarCampoFormData('mod', 'Upload') +
            MontarCampoFormData('comp', '5') +
            MontarCampoFormData('path', 'eguarda/php/') +
            '--' + FBound + CRLF +
            'Content-Disposition: form-data; name="file"; filename="' +
              FNomeArquivo + '"' + CRLF +
            'Content-Type: text/xml' + CRLF +
            CRLF +
            AXml + CRLF +
            '--' + FBound + '--' + CRLF;
end;

procedure TACBrANeWebservicePortoSeguro.EfetuarLogin;
var
  Usuario, Senha: string;
  OldURL, OldMimeType, OldMethod, OldEnvio, OldArqEnv, OldArqResp: string;
  p: Integer;
begin
  Usuario := Trim(TConfiguracoesANe(FPConfiguracoes).Geral.Usuario);
  Senha := Trim(TConfiguracoesANe(FPConfiguracoes).Geral.Senha);

  if (Usuario = '') or (Senha = '') then
    raise EACBrDFeException.Create(ACBrStr('A seguradora Porto Seguro ' +
      'necessita que as propriedades: Configuracoes.Geral.Usuario e ' +
      'Configuracoes.Geral.Senha sejam informadas.'));

  FCookies.Clear;

  OldURL := FPURL;
  OldMimeType := FPMimeType;
  OldMethod := FPMethod;
  OldEnvio := FPEnvio;
  OldArqEnv := FPArqEnv;
  OldArqResp := FPArqResp;
  try

    p := Pos('?', FPURL);
    if p > 0 then
      FPURL := Copy(FPURL, 1, p - 1);

    FPMethod := 'POST';
    FPMimeType := 'application/x-www-form-urlencoded';
    FPEnvio := MontarLoginUrlEncoded(Usuario, Senha);
    FPArqEnv := 'ped-login';
    FPArqResp := 'res-login';

    FHttpClient := FPDFeOwner.SSL.SSLHttpClass;
    FHttpClient.Clear;

    SalvarEnvio(FPEnvio, FPEnvio);
    UsarCertificado;
    EnviarDados('');
    SalvarRetornoWebService(FPRetorno);

    CapturarCookies;

    if Pos('"logout"', FPRetorno) > 0 then
      raise EACBrDFeException.Create(ACBrStr('Falha no login AverbePorto: ' +
        'usuario ou senha invalidos. Utilize a senha da API, gerada no ' +
        'modulo Cadastro do Usuario do portal (nao a senha de acesso web).') +
        sLineBreak + 'Body: ' + FPEnvio +
        sLineBreak + 'Retorno: ' + FPRetorno);
  finally
    FPURL := OldURL;
    FPMimeType := OldMimeType;
    FPMethod := OldMethod;
    FPEnvio := OldEnvio;
    FPArqEnv := OldArqEnv;
    FPArqResp := OldArqResp;
  end;
end;

function TACBrANeWebservicePortoSeguro.Enviar(const ACabecalho, AMSG: string): string;
begin
  FPMsgOrig := AMSG;

  EfetuarLogin;

  FNomeArquivo := ExtractFileName(
    Trim(TACBrANe(FPDFeOwner).Documentos.Items[0].ANe.NomeArq));

  if FNomeArquivo = '' then
    FNomeArquivo := GerarPrefixoArquivo + '-ANe.xml';

  FBound := IntToHex(Random(MaxInt), 8) + '_ACBr_boundary';
  FPMimeType := 'multipart/form-data; boundary=' + FBound;

  Result := Executar('', MontarMultipartUpload(AMSG), [], []);
end;

function TACBrANeWebservicePortoSeguro.Consultar(const ACabecalho,
  AMSG: string): string;
begin
  FPMsgOrig := AMSG;

  EfetuarLogin;

  Result := Executar('', AMSG, [], []);
end;

end.
