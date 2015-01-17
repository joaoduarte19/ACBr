{******************************************************************************}
{ Projeto: Componente ACBrNFe                                                  }
{  Biblioteca multiplataforma de componentes Delphi para emissão de Nota Fiscal}
{ eletrônica - NFe - http://www.nfe.fazenda.gov.br                             }

{ Direitos Autorais Reservados (c) 2008 Wemerson Souto                         }
{                                       Daniel Simoes de Almeida               }
{                                       André Ferreira de Moraes               }

{ Colaboradores nesse arquivo:                                                 }

{  Você pode obter a última versão desse arquivo na pagina do Projeto ACBr     }
{ Componentes localizado em http://www.sourceforge.net/projects/acbr           }


{  Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la }
{ sob os termos da Licença Pública Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a versão 2.1 da Licença, ou (a seu critério) }
{ qualquer versão posterior.                                                   }

{  Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU      }
{ ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENÇA.TXT ou LICENSE.TXT)              }

{  Você deve ter recebido uma cópia da Licença Pública Geral Menor do GNU junto}
{ com esta biblioteca; se não, escreva para a Free Software Foundation, Inc.,  }
{ no endereço 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Você também pode obter uma copia da licença em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }

{ Daniel Simões de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Praça Anita Costa, 34 - Tatuí - SP - 18270-410                  }

{******************************************************************************}

{$I ACBr.inc}

unit ACBrDFeWebService;

interface

uses Classes, SysUtils,
  {$IFNDEF NOGUI}
   {$IFDEF CLX} QDialogs,{$ELSE} Dialogs,{$ENDIF}
  {$ENDIF}
  ACBrDFeConfiguracoes, ACBrDFe;

const
  INTERNET_OPTION_CLIENT_CERT_CONTEXT = 84;

type

  { TDFeWebService }

  TDFeWebService = class
  private
  protected
    FSoapVersion: String;
    FSoapEnvelopeAtributtes: String;
    FHeaderElement: String;
    FBodyElement: String;

    FCabMsg: String;
    FDadosMsg: String;
    FEnvelopeSoap: String;
    FRetornoWS: String;
    FRetWS: String;
    FMsg: String;
    FURL: String;
    FConfiguracoes: TConfiguracoes;
    FDFeOwner: TACBrDFe;
    FArqEnv: String;
    FArqResp: String;
    FServico: String;
    FSoapAction: String;
  protected
    procedure FazerLog(Msg: AnsiString; Exibir: Boolean = False);
    procedure GerarException(Msg: String);

    procedure InicializarServico; virtual;
    procedure DefinirServicoEAction; virtual;
    procedure DefinirURL; virtual;
    procedure DefinirDadosMsg; virtual;
    procedure DefinirEnvelopeSoap; virtual;
    procedure SalvarEnvio; virtual;
    procedure EnviarDados; virtual;
    function TratarResposta: Boolean; virtual;
    procedure SalvarResposta; virtual;
    procedure FinalizarServico; virtual;

    function GerarMsgLog: String; virtual;
    function GerarMsgErro(E: Exception): String; virtual;
    function GerarCabecalhoSoap: String; virtual;
    function GerarVersaoDadosSoap: String; virtual;
    function GerarUFSoap: String; virtual;
    function GerarPrefixoArquivo: String; virtual;
  public
    constructor Create(AOwner: TACBrDFe);

    function Executar: Boolean; virtual;

    property SoapVersion: String read FSoapVersion;
    property SoapEnvelopeAtributtes: String read FSoapEnvelopeAtributtes;

    property HeaderElement: String read FHeaderElement;
    property BodyElement: String read FBodyElement;

    property Servico: String read FServico;
    property SoapAction: String read FSoapAction;
    property URL: String read FURL;
    property CabMsg: String read FCabMsg;
    property DadosMsg: String read FDadosMsg;
    property EnvelopeSoap: String read FEnvelopeSoap;
    property RetornoWS: String read FRetornoWS;
    property RetWS: String read FRetWS;
    property Msg: String read FMsg;
    property ArqEnv: String read FArqEnv;
    property ArqResp: String read FArqResp;
  end;

implementation

uses
  ACBrDFeUtil, ACBrUtil, pcnGerador;

{ TDFeWebService }

constructor TDFeWebService.Create(AOwner: TACBrDFe);
begin
  FDFeOwner := AOwner;
  FConfiguracoes := AOwner.Configuracoes;

  FSoapVersion := 'soap12';
  FHeaderElement := 'nfeCabecMsg';
  FBodyElement := 'nfeDadosMsg';
  FSoapEnvelopeAtributtes :=
    'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
    'xmlns:xsd="http://www.w3.org/2001/XMLSchema" ' +
    'xmlns:soap12="http://www.w3.org/2003/05/soap-envelope"';

  FCabMsg := '';
  FDadosMsg := '';
  FRetornoWS := '';
  FRetWS := '';
  FMsg := '';
  FURL := '';
  FArqEnv := '';
  FArqResp := '';
  FServico := '';
  FSoapAction := '';
end;

function TDFeWebService.Executar: Boolean;
var
  ErroMsg: String;
begin
  { Sobrescrever apenas se realmente necessário }

  InicializarServico;
  try
    DefinirDadosMsg;
    DefinirEnvelopeSoap;
    SalvarEnvio;

    try
      EnviarDados;
      Result := TratarResposta;
      FazerLog(GerarMsgLog, True);
      SalvarResposta;
    except
      on E: Exception do
      begin
        Result := False;
        ErroMsg := GerarMsgErro(E);
        GerarException(ErroMsg);
      end;
    end;
  finally
    FinalizarServico;
  end;
end;

procedure TDFeWebService.InicializarServico;
begin
  { Sobrescrever apenas se necessário }

  DefinirURL;
  if URL = '' then
    GerarException('URL não definida para: ' + ClassName);

  DefinirServicoEAction;
  if Servico = '' then
    GerarException('Servico não definido para: ' + ClassName);

  if SoapAction = '' then
    GerarException('SoapAction não definido para: ' + ClassName);
end;

procedure TDFeWebService.DefinirServicoEAction;
begin
  { sobrescrever, OBRIGATORIAMENTE }

  FServico := '';
  FSoapAction := '';

  GerarException('DefinirServicoEAction não implementado para: ' + ClassName);
end;

procedure TDFeWebService.DefinirURL;
begin
  { sobrescrever OBRIGATORIAMENTE.
    Você também pode mudar apenas o valor de "FLayoutServico" na classe
    filha e chamar: Inherited;     }

  GerarException('DefinirURL não implementado para: ' + ClassName);
end;


procedure TDFeWebService.DefinirDadosMsg;
begin
  { sobrescrever, OBRIGATORIAMENTE }

  FDadosMsg := '';

  GerarException('DefinirDadosMsg não implementado para: ' + ClassName);
end;


procedure TDFeWebService.DefinirEnvelopeSoap;
var
  Texto: String;
begin
  { Sobrescrever apenas se necessário }

  Texto := '<' + ENCODING_UTF8 + '>';    // Envelop Final DEVE SEMPRE estar em UTF8...
  Texto := Texto + '<' + FSoapVersion + ':Envelope ' + FSoapEnvelopeAtributtes + '>';
  Texto := Texto + '<' + FSoapVersion + ':Header>';
  Texto := Texto + '<' + FHeaderElement + ' xmlns="' + Servico + '">';
  Texto := Texto + GerarCabecalhoSoap;
  Texto := Texto + '</' + FHeaderElement + '>';
  Texto := Texto + '</' + FSoapVersion + ':Header>';
  Texto := Texto + '<' + FSoapVersion + ':Body>';
  Texto := Texto + '<' + FBodyElement + ' xmlns="' + Servico + '">';
  Texto := Texto + DadosMsg;
  Texto := Texto + '</' + FBodyElement + '>';
  Texto := Texto + '</' + FSoapVersion + ':Body>';
  Texto := Texto + '</' + FSoapVersion + ':Envelope>';

  FEnvelopeSoap := Texto;
end;

function TDFeWebService.GerarUFSoap: String;
begin
  Result := '<cUF>' + IntToStr(FConfiguracoes.WebServices.UFCodigo) + '</cUF>';
end;

function TDFeWebService.GerarVersaoDadosSoap: String;
begin
  { sobrescrever, OBRIGATORIAMENTE }

  Result := '';
  GerarException('GerarVersaoDadosSoap não implementado para: ' + ClassName);
end;

procedure TDFeWebService.EnviarDados;
begin
  { Sobrescrever apenas se necessário }

  FRetWS := '';
  FRetornoWS := '';

  { Verifica se precisa converter o Envelope para UTF8 antes de ser enviado.
     Entretanto o Envelope pode já ter sido convertido antes, como por exemplo,
     para assinatura.
     Se o XML está assinado, não deve modificar o conteúdo }
  if not DFeUtil.XmlEstaAssinado(FEnvelopeSoap) then
    FEnvelopeSoap := DFeUtil.ConverteXMLtoUTF8(FEnvelopeSoap);

  FRetornoWS := FDFeOwner.DFeSSL.Enviar(FEnvelopeSoap, FURL, FSoapAction);

  { Resposta sempre é UTF8, ParseTXT chamará DecodetoString, que converterá
    de UTF8 para o formato nativo de  String usada pela IDE }
  FRetornoWS := ParseText(FRetornoWS, True, True);
end;

function TDFeWebService.GerarPrefixoArquivo: String;
begin
  Result := FormatDateTime('yyyymmddhhnnss', Now);
end;

procedure TDFeWebService.SalvarEnvio;
var
  Prefixo, ArqEnv: String;
begin
  { Sobrescrever apenas se necessário }

  if FArqEnv = '' then
    exit;

  Prefixo := GerarPrefixoArquivo;

  if FConfiguracoes.Geral.Salvar then
  begin
    ArqEnv := Prefixo + '-' + FArqEnv + '.xml';
    FDFeOwner.Gravar(ArqEnv, FDadosMsg);
  end;

  if FConfiguracoes.WebServices.Salvar then
  begin
    ArqEnv := Prefixo + '-' + FArqEnv + '-soap.xml';
    FDFeOwner.Gravar(ArqEnv, FEnvelopeSoap);
  end;
end;

procedure TDFeWebService.SalvarResposta;
var
  Prefixo, ArqResp: String;
begin
  { Sobrescrever apenas se necessário }

  if FArqResp = '' then
    exit;

  Prefixo := GerarPrefixoArquivo;

  if FConfiguracoes.Geral.Salvar then
  begin
    ArqResp := Prefixo + '-' + FArqResp + '.xml';
    FDFeOwner.Gravar(ArqResp, FRetWS);
  end;

  if FConfiguracoes.WebServices.Salvar then
  begin
    ArqResp := Prefixo + '-' + FArqResp + '-soap.xml';
    FDFeOwner.Gravar(ArqResp, FRetornoWS);
  end;
end;

function TDFeWebService.GerarMsgLog: String;
begin
  { sobrescrever, se quiser Logar }

  Result := '';
end;

function TDFeWebService.TratarResposta: Boolean;
begin
  { sobrescrever, OBRIGATORIAMENTE }

  Result := False;
end;

procedure TDFeWebService.FazerLog(Msg: AnsiString; Exibir: Boolean);
var
  Tratado: Boolean;
begin
  if (Msg <> '') then
  begin
    Tratado := False;
    if Assigned(FDFeOwner.OnGerarLog) then
      FDFeOwner.OnGerarLog(Msg, Tratado);

    if Tratado then
      exit;

    {$IFNDEF NOGUI}
    if Exibir and FConfiguracoes.WebServices.Visualizar then
      ShowMessage(Msg);
    {$ENDIF}
  end;
end;

procedure TDFeWebService.GerarException(Msg: String);
begin
  FazerLog('ERRO: ' + Msg, False);
  raise EACBrDFeException.Create(Msg);
end;

function TDFeWebService.GerarMsgErro(E: Exception): String;
begin
  { Sobrescrever com mensagem adicional, se desejar }

  Result := E.Message;
end;

function TDFeWebService.GerarCabecalhoSoap: String;
begin
  { Sobrescrever apenas se necessário }

  Result := GerarUFSoap + GerarVersaoDadosSoap;

end;

procedure TDFeWebService.FinalizarServico;
begin
  { Sobrescrever apenas se necessário }

  DFeUtil.ConfAmbiente;
end;

end.
(*
// TODO: VERIFICAR:

CURL_WSDL = 'http://www.portalfiscal.inf.br/nfe/wsdl/';


function TWebServicesBase.EhAutorizacao: Boolean;
begin
  Result := False;
  case FConfiguracoes.Geral.ModeloDF of
    moNFe:
      if (FConfiguracoes.Geral.VersaoDF = ve310) then
        Result := True;
    moNFCe:
      if (FConfiguracoes.Geral.VersaoDF = ve310) and not
         (FConfiguracoes.WebServices.UFCodigo in [13])  then // AM
        Result := True;
  end;
end;

function TWebServicesBase.GerarSoapDEPC: String;
var
  Texto: String;
begin
  Texto := '<'+ENCODING_UTF8+'>';
  Texto := Texto + '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                                  'xmlns:xsd="http://www.w3.org/2001/XMLSchema" ' +
                                  'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">';
  Texto := Texto + '<soap:Header>';
  Texto := Texto +  '<sceCabecMsg xmlns="' + Servico + '">';
  Texto := Texto +    GerarVersaoDadosSoap;
  Texto := Texto +  '</sceCabecMsg>';
  Texto := Texto + '</soap:Header>';
  Texto := Texto + '<soap:Body>';
  Texto := Texto +  '<sceDadosMsg xmlns="' + Servico +'">';
  Texto := Texto +    FDadosMsg;
  Texto := Texto +  '</sceDadosMsg>';
  Texto := Texto + '</soap:Body>';
  Texto := Texto + '</soap:Envelope>';

  Result := Texto;
end;



// TODO: Verificar onde fica...


property Status: TStatusACBrNFe   read FStatus;
property Layout: TLayOut          read FLayout;


procedure TWebServicesBase.AssinarXML(AXML: String; MsgErro: String);
begin
   if not NotaUtil.Assinar( AXML,
                            FConfiguracoes.Certificados.Certificado,
                            FConfiguracoes.Certificados.Senha,
                            FDadosMsg, FMsg )) then
   if not(NotaUtil.openAssinar( AXML,
                            FConfiguracoes.Certificados.GetCertificado,
                            FDadosMsg, FMsg )) then
     GerarException(MsgErro);
end;


procedure TWebServicesBase.InicializarServico;
begin
  { Sobrescrever apenas se necessário }

  TACBrNFe( FACBrNFe ).SetStatus( FStatus );
end;

procedure TWebServicesBase.DefinirURL;
begin
  { sobrescrever apenas se necessário.
    Você também pode mudar apenas o valor de "FLayoutServico" na classe
    filha e chamar: Inherited;     }

  FURL := NotaUtil.GetURL( FConfiguracoes.WebServices.UFCodigo,
                           FConfiguracoes.WebServices.AmbienteCodigo,
                           FConfiguracoes.Geral.FormaEmissaoCodigo,
                           Layout,
                           FConfiguracoes.Geral.ModeloDF,
                           FConfiguracoes.Geral.VersaoDF );
end;


function TWebServicesBase.GerarVersaoDadosSoap: String;
begin
  { Sobrescrever apenas se necessário }

  Result := '<versaoDados>' + GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                                           FConfiguracoes.Geral.VersaoDF,
                                           Layout) +
            '</versaoDados>';
end;

procedure TWebServicesBase.FinalizarServico;
begin
  { Sobrescrever apenas se necessário }

  TACBrNFe( FACBrNFe ).SetStatus( stIdle );
end;




procedure TDFeWebService.EnviarDados;
var
  HTTP: THTTPSend;
  OK: Boolean;
  Stream: TMemoryStream;
   {$IFDEF SoapHTTP}
  ReqResp: THTTPReqResp;
   {$ELSE}
  ReqResp: TACBrHTTPReqResp;
   {$ENDIF}
begin
  { Sobrescrever apenas se necessário }

  FRetWS := '';
  FRetornoWS := '';

  HTTP := THTTPSend.Create;
   {$IFDEF SoapHTTP}
  ReqResp := THTTPReqResp.Create(nil);
  ReqResp.UseUTF8InHeader := True;
   {$ELSE}
  ReqResp := TACBrHTTPReqResp.Create;
   {$ENDIF}
  ConfiguraReqResp(ReqResp);
  ReqResp.URL := URL;
  ReqResp.SoapAction := SoapAction;
  { Verifica se precisa converter o Envelope para UTF8 antes de ser enviado.
     Entretanto o Envelope pode já ter sido convertido antes, como por exemplo,
     para assinatura.
     Se o XML está assinado, não deve modificar o conteúdo }

  if not DFeUtil.XmlEstaAssinado(FEnvelopeSoap) then
    FEnvelopeSoap := DFeUtil.ConverteXMLtoUTF8(FEnvelopeSoap);

  try
    {$IFDEF ACBrNFeOpenSSL}
    ConfiguraHTTP(HTTP, 'SOAPAction: "' + SoapAction + '"');
    // DEBUG //
    //HTTP.Document.SaveToFile( 'c:\temp\HttpSend.xml' );
    HTTP.Document.WriteBuffer(FEnvelopeSoap[1], Length(FEnvelopeSoap));
    OK := HTTP.HTTPMethod('POST', URL);
    OK := OK and (HTTP.ResultCode = 200);
    if not OK then
      GerarException('Cod.Erro HTTP: ' + IntToStr(HTTP.ResultCode) +
        ' ' + HTTP.ResultString);

    // Lendo a resposta //
    HTTP.Document.Position := 0;
    SetLength(FRetornoWS, HTTP.Document.Size);
    HTTP.Document.ReadBuffer(FRetornoWS[1], HTTP.Document.Size);
    // DEBUG //
    HTTP.Document.SaveToFile('c:\temp\ReqResp.xml');
    {$ELSE}
    Stream := TMemoryStream.Create;
    try
      ReqResp.Execute(FEnvelopeSoap, Stream);  // Dispara exceptions no caso de erro
      SetLength(FRetornoWS, Stream.Size);
      Stream.ReadBuffer(FRetornoWS[1], Stream.Size);
      // DEBUG //
      Stream.SaveToFile('c:\temp\ReqResp.xml');
    finally
      Stream.Free;
    end;
    {$ENDIF}
    { Resposta sempre é UTF8, ParseTXT chamará DecodetoString, que converterá
      de UTF8 para o formato nativo de  String usada pela IDE }
    FRetornoWS := ParseText(FRetornoWS, True, True);
  finally
    HTTP.Free;
    ReqResp.Free;
  end;
end;

{$IFDEF SoapHTTP}
SoapHTTPClient, SOAPHTTPTrans, SOAPConst, WinInet, ACBrCAPICOM_TLB,
{$ELSE}
ACBrHTTPReqResp,
{$ENDIF}


{$IFDEF SoapHTTP}
procedure ConfiguraReqResp(ReqResp: THTTPReqResp);
procedure OnBeforePost(const HTTPReqResp: THTTPReqResp; Data: Pointer);
{$ELSE}
procedure ConfiguraReqResp(ReqResp: TACBrHTTPReqResp);
{$ENDIF}


{$IFDEF SoapHTTP}
procedure TWebServicesBase.ConfiguraReqResp(ReqResp: THTTPReqResp);
begin
  if FConfiguracoes.WebServices.ProxyHost <> '' then
  begin
    ReqResp.Proxy := FConfiguracoes.WebServices.ProxyHost + ':' +
      FConfiguracoes.WebServices.ProxyPort;
    ReqResp.UserName := FConfiguracoes.WebServices.ProxyUser;
    ReqResp.Password := FConfiguracoes.WebServices.ProxyPass;
  end;
  ReqResp.OnBeforePost := OnBeforePost;
end;

procedure TWebServicesBase.OnBeforePost(const HTTPReqResp: THTTPReqResp; Data: Pointer);
var
  Cert: ICertificate2;
  CertContext: ICertContext;
  PCertContext: Pointer;
  ContentHeader: String;
begin
  Cert := FConfiguracoes.Certificados.GetCertificado;
  CertContext := Cert as ICertContext;
  CertContext.Get_CertContext(integer(PCertContext));

  if not InternetSetOption(Data, INTERNET_OPTION_CLIENT_CERT_CONTEXT,
    PCertContext, SizeOf(CERT_CONTEXT)) then
    GerarException('OnBeforePost: ' + IntToStr(GetLastError));

  if trim(FConfiguracoes.WebServices.ProxyUser) <> '' then
    if not InternetSetOption(Data, INTERNET_OPTION_PROXY_USERNAME,
      PChar(FConfiguracoes.WebServices.ProxyUser),
      Length(FConfiguracoes.WebServices.ProxyUser)) then
      GerarException('OnBeforePost: ' + IntToStr(GetLastError));

  if trim(FConfiguracoes.WebServices.ProxyPass) <> '' then
    if not InternetSetOption(Data, INTERNET_OPTION_PROXY_PASSWORD,
      PChar(FConfiguracoes.WebServices.ProxyPass),
      Length(FConfiguracoes.WebServices.ProxyPass)) then
      GerarException('OnBeforePost: ' + IntToStr(GetLastError));

  if (pos('SCERECEPCAORFB', UpperCase(FURL)) <= 0) and
    (pos('SCECONSULTARFB', UpperCase(FURL)) <= 0) then
  begin
    ContentHeader := Format(ContentTypeTemplate,
      ['application/soap+xml; charset=utf-8']);
    HttpAddRequestHeaders(Data, PChar(ContentHeader),
      Length(ContentHeader), HTTP_ADDREQ_FLAG_REPLACE);
  end;

  HTTPReqResp.CheckContentType;
end;

{$ELSE}

procedure TDFeWebService.ConfiguraReqResp(ReqResp: TACBrHTTPReqResp);
begin
  if FConfiguracoes.WebServices.ProxyHost <> '' then
  begin
    ReqResp.ProxyHost := FConfiguracoes.WebServices.ProxyHost;
    ReqResp.ProxyPort := FConfiguracoes.WebServices.ProxyPort;
    ReqResp.ProxyUser := FConfiguracoes.WebServices.ProxyUser;
    ReqResp.ProxyPass := FConfiguracoes.WebServices.ProxyPass;
  end;

  ReqResp.SetCertificate(FConfiguracoes.Certificados.NumeroSerie);

  if (pos('SCERECEPCAORFB', UpperCase(FURL)) <= 0) and
    (pos('SCECONSULTARFB', UpperCase(FURL)) <= 0) then
    ReqResp.MimeType := 'application/soap+xml'
  else
    ReqResp.MimeType := 'text/xml';
end;

{$ENDIF}

*)
