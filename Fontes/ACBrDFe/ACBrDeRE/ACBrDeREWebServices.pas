{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Renato Rubinho                                  }
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

unit ACBrDeREWebServices;

interface

uses
  Classes, SysUtils, DateUtils,
  ACBrDFe, ACBrDFeWebService, ACBrDFe.Conversao,
  ACBrDeREConfiguracoes, ACBrDeREEventos,
  ACBrDeRE.Classes.Retorno,
  ACBrDeRE.Conversao,
  ACBrDeRE.ObterToken, ACBrDeRE.RetObterToken,
  ACBrDeRE.EnvLote, ACBrDeRE.ConsLote, ACBrDeRE.RetEnvLote,
  ACBrDeRE.Limpeza, ACBrDeRE.RetLimpeza;

type
  { TDeREWebService }

  TDeREWebService = class(TDFeWebService)
  private
    FPStatus: TStatusDeRE;
    FPLayout: TLayOutDeRE;
    FPConfiguracoesDeRE: TConfiguracoesDeRE;
    FtpAmb: TACBrTipoAmbiente;
  protected
    procedure InicializarServico; override;
    procedure DefinirURL; override;
    function GerarVersaoDadosSoap: String; override;
    procedure FinalizarServico; override;

    function GerarPrefixoArquivo: String; override;
    // Valida o token configurado (Geral.Token/TokenExpira). Nao gera token automaticamente.
    procedure ValidarToken;
  public
    constructor Create(AOwner: TACBrDFe); override;
    procedure Clear; override;

    property Status: TStatusDeRE read FPStatus;
    property Layout: TLayOutDeRE read FPLayout;
    property tpAmb: TACBrTipoAmbiente read FtpAmb;
  end;

  { TObterToken }

  TObterToken = class(TDeREWebService)
  private
    FHttpCodigo: Integer;

    function GetToken: String;
    function GetTokenExpira: TDateTime;
  protected
    procedure DefinirURL; override;
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    procedure DefinirEnvelopeSoap; override;
    procedure InicializarServico; override;
    procedure SalvarResposta; override;

    function TratarResposta: Boolean; override;
    function GerarMsgLog: String; override;
    function GerarPrefixoArquivo: String; override;
    function GerarMsgErro(E: Exception): String; override;
    function GerarVersaoDadosSoap: String; override;
  public
    constructor Create(AOwner: TACBrDFe); override;

    procedure Clear; override;

    // Token e validade (gravados em Configuracoes.Geral)
    property Token: String read GetToken;
    property TokenExpira: TDateTime read GetTokenExpira;
    // Corpo (JSON) retornado pelo servico de Token
    property RetornoToken: String read FPRetWS;
    // Codigo HTTP do ultimo ObterToken (ex.: 200, 429)
    property HttpCodigo: Integer read FHttpCodigo;
  end;

  { TEnvioLote }

  TEnvioLote = class(TDeREWebService)
  private
    FEventos: TEventos;
    FVersaoDF: TVersaoDeRE;
    FRetEnvLote: TRetEnvLoteDeRE;
    FHttpCodigo: Integer;
    FProtocolo: String;
    FcdResposta: TCdRespostaLoteDeRE;
    FdescResposta: String;
    FdhRecepcao: TDateTime;
    FversaoAplicativoRecepcao: String;

    function GetRetornoLote: TretornoLoteDeRE;
  protected
    procedure DefinirURL; override;
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    procedure DefinirEnvelopeSoap; override;
    procedure InicializarServico; override;

    function TratarResposta: Boolean; override;
    function GerarMsgLog: String; override;
    function GerarPrefixoArquivo: String; override;
    function GerarMsgErro(E: Exception): String; override;
    function GerarVersaoDadosSoap: String; override;
  public
    constructor Create(AOwner: TACBrDFe; AEventos: TEventos); reintroduce; overload;
    destructor Destroy; override;

    procedure Clear; override;

    property HttpCodigo: Integer read FHttpCodigo;
    property Protocolo: String read FProtocolo;
    property cdResposta: TCdRespostaLoteDeRE read FcdResposta;
    property descResposta: String read FdescResposta;
    property dhRecepcao: TDateTime read FdhRecepcao;
    property versaoAplicativoRecepcao: String read FversaoAplicativoRecepcao;
    // Retorno completo (retornoLoteEventos) da recepcao
    property RetornoLote: TretornoLoteDeRE read GetRetornoLote;
  end;

  { TConsultaLote }

  TConsultaLote = class(TDeREWebService)
  private
    FVersaoDF: TVersaoDeRE;
    FConsLote: TConsLoteDeRE;
    FRetEnvLote: TRetEnvLoteDeRE;
    FHttpCodigo: Integer;
    FcdResposta: TCdRespostaLoteDeRE;
    FdescResposta: String;
    function GetProtocolo: String;
    procedure SetProtocolo(const Value: String);
    function GetRetornoLote: TretornoLoteDeRE;
  protected
    procedure DefinirURL; override;
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    procedure DefinirEnvelopeSoap; override;
    procedure InicializarServico; override;

    function TratarResposta: Boolean; override;
    procedure SalvarResposta; override;
    function GerarMsgLog: String; override;
    function GerarPrefixoArquivo: String; override;
    function GerarMsgErro(E: Exception): String; override;
    function GerarVersaoDadosSoap: String; override;
  public
    constructor Create(AOwner: TACBrDFe); override;
    destructor Destroy; override;

    procedure Clear; override;

    // Protocolo do lote a consultar (entrada)
    property Protocolo: String read GetProtocolo write SetProtocolo;
    property HttpCodigo: Integer read FHttpCodigo;
    property cdResposta: TCdRespostaLoteDeRE read FcdResposta;
    property descResposta: String read FdescResposta;
    // Retorno completo (retornoLoteEventos), com os retornos de cada evento
    property RetornoLote: TretornoLoteDeRE read GetRetornoLote;
  end;

  { TLimpezaDados }

  TLimpezaDados = class(TDeREWebService)
  private
    FLimpeza: TLimpezaDeRE;
    FRetLimpeza: TRetLimpezaDeRE;
    FHttpCodigo: Integer;
    FHttpTransmit: Integer;

    function GetnrInsc: String;
    procedure SetnrInsc(const Value: String);
  protected
    procedure DefinirURL; override;
    procedure DefinirServicoEAction; override;
    procedure DefinirDadosMsg; override;
    procedure DefinirEnvelopeSoap; override;
    procedure InicializarServico; override;
    procedure EnviarDados; override;
    procedure SalvarResposta; override;

    function TratarResposta: Boolean; override;
    function GerarMsgLog: String; override;
    function GerarPrefixoArquivo: String; override;
    function GerarMsgErro(E: Exception): String; override;
    function GerarVersaoDadosSoap: String; override;
  public
    constructor Create(AOwner: TACBrDFe); override;
    destructor Destroy; override;

    procedure Clear; override;

    // CNPJ base (8 posicoes) do contribuinte cujos dados serao apagados.
    // Se vazio, usa as 8 primeiras posicoes de Configuracoes.Geral.IdContribuinte.
    property nrInsc: String read GetnrInsc write SetnrInsc;
    property HttpCodigo: Integer read FHttpCodigo;
  end;

  { TWebServices }

  TWebServices = class
  private
    FACBrDeRE: TACBrDFe;
    FObterToken: TObterToken;
    FEnvioLote: TEnvioLote;
    FConsultaLote: TConsultaLote;
    FLimpezaDados: TLimpezaDados;

    function GetToken: string;
    procedure SetToken(const Value: string);
    function GetTokenExpira: TDateTime;
    procedure SetTokenExpira(const Value: TDateTime);
  public
    constructor Create(AOwner: TACBrDFe); overload;
    destructor Destroy; override;

    procedure LimparToken;

    function Envia: Boolean;
    function Consulta(const AProtocolo: string): Boolean;
    function Limpa(const ANrInsc: string = ''): Boolean;

    property ACBrDeRE: TACBrDFe read FACBrDeRE write FACBrDeRE;
    // Solicita um novo token (sempre, sem cache): ObterToken.Executar. Grava Token/TokenExpira
    // e salva o retorno (JSON). Retorna False quando o servico responde com erro
    // (ex.: HTTP 429); consulte ObterToken.HttpCodigo e ObterToken.Msg.
    property ObterToken: TObterToken read FObterToken write FObterToken;
    property EnvioLote: TEnvioLote read FEnvioLote write FEnvioLote;
    property ConsultaLote: TConsultaLote read FConsultaLote write FConsultaLote;
    // Apaga os dados do contribuinte na Producao Restrita (Limpa)
    property LimpezaDados: TLimpezaDados read FLimpezaDados write FLimpezaDados;

    // Token e validade (gravados em Configuracoes.Geral). Podem ser preenchidos
    // manualmente; EnvioLote e ConsultaLote usam somente estes valores.
    property Token: string read GetToken write SetToken;
    property TokenExpira: TDateTime read GetTokenExpira write SetTokenExpira;
  end;

implementation

uses
  synacode, synautil,
  ACBrDFeSSL,
  ACBrConsts,
  ACBrDFeException,
  ACBrUtil.Base,
  ACBrUtil.DateTime,
  ACBrUtil.Strings,
  ACBrUtil.FilesIO,
  ACBrUtil.XMLHTML,
  ACBrDeRE,
  ACBrDeRE.Classes,
  ACBrDeRE.Consts,
  ACBrDeRE.XmlReader.Retorno;

{ TDeREWebService }

constructor TDeREWebService.Create(AOwner: TACBrDFe);
begin
  inherited Create(AOwner);

  FPConfiguracoesDeRE := TConfiguracoesDeRE(FPConfiguracoes);
  FPStatus := stDeREIdle;
end;

procedure TDeREWebService.Clear;
begin
  inherited Clear;

  FPStatus := stDeREIdle;
  if Assigned(FPDFeOwner) and Assigned(FPDFeOwner.SSL) then
    FPDFeOwner.SSL.UseCertificateHTTP := True;
end;

procedure TDeREWebService.DefinirURL;
var
  Versao: Double;
begin
  Versao := 0;
  FPVersaoServico := '';
  FPURL := '';

  TACBrDeRE(FPDFeOwner).LerServicoDeParams(FPLayout, Versao, FPURL);
  FPVersaoServico := FloatToString(Versao, '.', '0.00');
end;

function TDeREWebService.GerarPrefixoArquivo: String;
begin
  Result := FormatDateTime('yyyymmddhhnnss', Now);
end;

procedure TDeREWebService.ValidarToken;
begin
  if Trim(FPConfiguracoesDeRE.Geral.Token) = '' then
    GerarException(ACBrStr(
      'DeRE: Token nao informado. Preencha a propriedade Token ou chame ObterToken.'));

  // TokenExpira = 0 significa validade desconhecida (token informado manualmente).
  if (FPConfiguracoesDeRE.Geral.TokenExpira <> 0) and
     (FPConfiguracoesDeRE.Geral.TokenExpira <= Now) then
    GerarException(ACBrStr(
      'DeRE: Token expirado em ' +
      FormatDateTime('dd/mm/yyyy hh:nn:ss', FPConfiguracoesDeRE.Geral.TokenExpira) +
      '. Chame ObterToken para gerar um novo.'));
end;

function TDeREWebService.GerarVersaoDadosSoap: String;
begin
  { A DeRE usa API REST: nao existe versao de dados no cabecalho SOAP }
  Result := '';
end;

procedure TDeREWebService.InicializarServico;
begin
  { Sobrescrever apenas se necessario }
  FtpAmb := FPConfiguracoesDeRE.WebServices.Ambiente;

  inherited InicializarServico;

  TACBrDeRE(FPDFeOwner).SetStatus(FPStatus);
end;

procedure TDeREWebService.FinalizarServico;
begin
  { Sobrescrever apenas se necessario }
  TACBrDeRE(FPDFeOwner).SetStatus(stDeREIdle);
end;

{ TObterToken }

constructor TObterToken.Create(AOwner: TACBrDFe);
begin
  inherited Create(AOwner);
end;

procedure TObterToken.Clear;
begin
  inherited Clear;

  FPLayout := LayDeREObterToken;
  FPStatus := stDeREToken;
  // O corpo enviado (grant_type) nao e salvo; a resposta e salva em SalvarResposta
  FPArqEnv := '';
  FPArqResp := 'token';

  FHttpCodigo := 0;
end;

function TObterToken.GetToken: String;
begin
  Result := FPConfiguracoesDeRE.Geral.Token;
end;

function TObterToken.GetTokenExpira: TDateTime;
begin
  Result := FPConfiguracoesDeRE.Geral.TokenExpira;
end;

procedure TObterToken.DefinirURL;
begin
  FPLayout := LayDeREObterToken;

  inherited DefinirURL;
end;

procedure TObterToken.DefinirServicoEAction;
begin
  FPServico := 'ObterToken';
  // API REST: nao ha SoapAction ('*' e convertido em vazio por InicializarServico)
  FPSoapAction := '*';
end;

procedure TObterToken.DefinirDadosMsg;
var
  LObterToken: TObterTokenDeRE;
begin
  LObterToken := TObterTokenDeRE.Create;
  try
    FPDadosMsg := LObterToken.GerarCorpo;
  finally
    LObterToken.Free;
  end;
end;

procedure TObterToken.DefinirEnvelopeSoap;
var
  LObterToken: TObterTokenDeRE;
begin
  { Nao ha envelope SOAP: o corpo e um formulario (x-www-form-urlencoded) e as
    credenciais seguem no cabecalho Authorization (Basic). }
  FPMimeType := 'application/x-www-form-urlencoded';
  FPValidateReturnCode := False;

  LObterToken := TObterTokenDeRE.Create;
  try
    LObterToken.ClientId := FPConfiguracoesDeRE.Geral.ClientId;
    LObterToken.ClientSecret := FPConfiguracoesDeRE.Geral.ClientSecret;
    FPAuthorizationHeader := LObterToken.GerarAutorizacao;
  finally
    LObterToken.Free;
  end;

  FPEnvelopeSoap := FPDadosMsg;
end;

procedure TObterToken.InicializarServico;
begin
  if (Trim(FPConfiguracoesDeRE.Geral.ClientId) = '') or
     (Trim(FPConfiguracoesDeRE.Geral.ClientSecret) = '') then
    GerarException(ACBrStr('ClientId e ClientSecret devem ser informados em ' +
      'Configuracoes.Geral para obter o token da DeRE.'));

  inherited InicializarServico;
end;

function TObterToken.TratarResposta: Boolean;
var
  LRetToken: TRetObterTokenDeRE;
begin
  Result := False;

  FPRetWS := FPRetornoWS;
  FHttpCodigo := FPDFeOwner.SSL.HTTPResultCode;

  VerificarSemResposta;

  // Quando o retorno nao for sucesso (ex.: 400 invalid_client, 429 rate limit),
  // o corpo da resposta traz o detalhe do erro.
  // Codigo 0 = transmissao feita pela aplicacao (evento OnTransmit): o JSON decide.
  if (FHttpCodigo <> 0) and not (FHttpCodigo in [200, 201, 202]) then
  begin
    FPMsg := 'DeRE - ObterToken: Erro HTTP ' + IntToStr(FHttpCodigo);

    // Detalhe do erro (invalid_client etc.) lido do JSON; o corpo completo
    // permanece em RetornoToken e no arquivo de retorno salvo.
    LRetToken := TRetObterTokenDeRE.Create;
    try
      LRetToken.JsonRetorno := FPRetWS;
      LRetToken.LerJson;

      if LRetToken.error <> '' then
        FPMsg := FPMsg + ' - ' + LRetToken.error;
      if LRetToken.error_description <> '' then
        FPMsg := FPMsg + ': ' + LRetToken.error_description;
    finally
      LRetToken.Free;
    end;

    Exit;
  end;

  LRetToken := TRetObterTokenDeRE.Create;
  try
    LRetToken.JsonRetorno := FPRetWS;

    if not LRetToken.LerJson then
    begin
      FPMsg := LRetToken.Msg;
      Exit;
    end;

    FPConfiguracoesDeRE.Geral.Token := LRetToken.access_token;
    // Validade = data/hora da geracao + segundos informados no retorno (expires_in).
    FPConfiguracoesDeRE.Geral.TokenExpira := LRetToken.DataExpiracao;
  finally
    LRetToken.Free;
  end;

  Result := True;
end;

procedure TObterToken.SalvarResposta;
begin
  // O retorno e sempre salvo na pasta de retornos (independente de Geral.Salvar),
  // exatamente como recebido (JSON), sem inserir a declaracao XML que
  // TACBrDFe.Gravar adicionaria.
  if FPRetornoWS = '' then
    Exit;

  WriteToTXT(PathWithDelim(FPConfiguracoesDeRE.Arquivos.GetPathDeRE) +
    GerarPrefixoArquivo + '-' + FPArqResp + '-ret.json', AnsiString(FPRetornoWS),
    False, False, True);
end;

function TObterToken.GerarMsgLog: String;
var
  LExpira: String;
begin
  LExpira := '';
  if GetTokenExpira <> 0 then
    LExpira := FormatDateTime('dd/mm/yyyy hh:nn:ss', GetTokenExpira);

  // O token nao e registrado no log
  Result := Format(ACBrStr('Versao Layout: %s ' + sLineBreak +
                           'Ambiente: %s ' + sLineBreak +
                           'Codigo HTTP: %s ' + sLineBreak +
                           'Token expira em: %s ' + sLineBreak +
                           'Mensagem: %s ' + sLineBreak),
    [VersaoDeREToStr(FPConfiguracoesDeRE.Geral.VersaoDF),
     TipoAmbienteToStr(FtpAmb),
     IntToStr(FHttpCodigo),
     LExpira,
     FPMsg]);
end;

function TObterToken.GerarPrefixoArquivo: String;
begin
  Result := FormatDateTime('yyyymmddhhnnss', Now);
end;

function TObterToken.GerarMsgErro(E: Exception): String;
begin
  Result := ACBrStr('WebService: ' + FPServico + #13#10 +
    '- Inativo ou Inoperante tente novamente.');
end;

function TObterToken.GerarVersaoDadosSoap: String;
begin
  Result := '';
end;

{ TEnvioLote }

constructor TEnvioLote.Create(AOwner: TACBrDFe; AEventos: TEventos);
begin
  inherited Create(AOwner);

  FEventos := AEventos;
end;

destructor TEnvioLote.Destroy;
begin
  FRetEnvLote.Free;

  inherited Destroy;
end;

procedure TEnvioLote.Clear;
begin
  inherited Clear;

  FPLayout := LayDeRERecepcaoLote;
  FPStatus := stDeRERecepcao;
  FPArqEnv := 'env-lot';
  FPArqResp := 'rec';

  FHttpCodigo := 0;
  FProtocolo := '';
  FcdResposta := crlNenhum;
  FdescResposta := '';
  FdhRecepcao := 0;
  FversaoAplicativoRecepcao := '';

  if Assigned(FRetEnvLote) then
    FRetEnvLote.Free;

  FRetEnvLote := TRetEnvLoteDeRE.Create;
end;

function TEnvioLote.GetRetornoLote: TretornoLoteDeRE;
begin
  Result := FRetEnvLote.RetornoLote;
end;

procedure TEnvioLote.DefinirURL;
begin
  FPLayout := LayDeRERecepcaoLote;

  inherited DefinirURL;
end;

procedure TEnvioLote.DefinirServicoEAction;
begin
  FPServico := 'RecepcaoLote';
  // API REST: nao ha SoapAction ('*' e convertido em vazio por InicializarServico)
  FPSoapAction := '*';
end;

procedure TEnvioLote.DefinirDadosMsg;
var
  LEnvLote: TEnvLoteDeRE;
  i: Integer;
begin
  if (not Assigned(FEventos)) or (FEventos.Count = 0) then
    GerarException(ACBrStr('Nenhum evento da DeRE informado para o envio do lote.'));

  // Monta o lote por concatenacao, preservando a assinatura embutida em cada evento.
  LEnvLote := TEnvLoteDeRE.Create;
  try
    LEnvLote.VersaoDF := FVersaoDF;
    // O lote leva somente a raiz do inscricao (8 primeiros caracteres),
    // apenas letras e numeros.
    LEnvLote.nrInsc := Copy(OnlyCPFCNPJAlphaNum(
      FPConfiguracoesDeRE.Geral.IdContribuinte), 1, 8);

    // Todos os eventos gerados entram no lote, na ordem em que foram adicionados.
    for i := 0 to FEventos.Count - 1 do
      LEnvLote.AddEvento(FEventos[i].Evento.id, FEventos[i].Evento.XML);

    FPDadosMsg := LEnvLote.GerarXML;
  finally
    LEnvLote.Free;
  end;

  if Assigned(TACBrDeRE(FPDFeOwner).OnTransmissaoEventos) then
    TACBrDeRE(FPDFeOwner).OnTransmissaoEventos(FPDadosMsg, edEnvioLote);
end;

procedure TEnvioLote.DefinirEnvelopeSoap;
begin
  { Nao ha envelope SOAP: o corpo e o proprio XML do lote (ja assinado) }
  FPMimeType := 'application/xml';
  FPValidateReturnCode := False;
  FPAuthorizationHeader := 'Bearer ' + Trim(FPConfiguracoesDeRE.Geral.Token);
  FPEnvelopeSoap := FPDadosMsg;
end;

procedure TEnvioLote.InicializarServico;
begin
  FVersaoDF := FPConfiguracoesDeRE.Geral.VersaoDF;

  // Nao gera token automaticamente: usa o que esta em Token/TokenExpira.
  ValidarToken;

  inherited InicializarServico;
end;

function TEnvioLote.TratarResposta: Boolean;
var
  i: Integer;
begin
  Result := False;

  FPRetWS := FPRetornoWS;
  FHttpCodigo := FPDFeOwner.SSL.HTTPResultCode;

  VerificarSemResposta;

  if Assigned(TACBrDeRE(FPDFeOwner).OnTransmissaoEventos) then
    TACBrDeRE(FPDFeOwner).OnTransmissaoEventos(FPRetWS, edRetornoLote);

  // Codigo 0 = transmissao feita pela aplicacao (evento OnTransmit): o XML decide.
  if (FHttpCodigo <> 0) and not (FHttpCodigo in [200, 201, 202]) then
  begin
    FPMsg := 'DeRE - RecepcaoLote: Erro HTTP ' + IntToStr(FHttpCodigo);
    Exit;
  end;

  FRetEnvLote.XmlRetorno := FPRetWS;
  FRetEnvLote.LerXml;

  FcdResposta := FRetEnvLote.RetornoLote.status.cdResposta;
  FdescResposta := FRetEnvLote.RetornoLote.status.descResposta;
  FdhRecepcao := FRetEnvLote.RetornoLote.dadosRecepcaoLote.dhRecepcao;
  FversaoAplicativoRecepcao := FRetEnvLote.RetornoLote.dadosRecepcaoLote.versaoAplicativoRecepcao;
  FProtocolo := Trim(FRetEnvLote.RetornoLote.dadosRecepcaoLote.protocolo);

  // Resposta sincrona de recepcao (HTTP 202): o protocolo identifica o lote recebido.
  Result := FProtocolo <> '';

  if Result then
    FPMsg := FdescResposta
  else
  begin
    // Lote rejeitado: monta a mensagem com a descricao e as ocorrencias retornadas
    FPMsg := 'DeRE - RecepcaoLote: lote nao recebido (protocolo nao retornado).';
    if FdescResposta <> '' then
      FPMsg := FPMsg + sLineBreak + FdescResposta;
    for i := 0 to FRetEnvLote.RetornoLote.status.ocorrencias.Count - 1 do
      with FRetEnvLote.RetornoLote.status.ocorrencias[i] do
      begin
        FPMsg := FPMsg + sLineBreak + '- ' + codigo + ': ' + descricao;
        if localizacao <> '' then
          FPMsg := FPMsg + ' (' + localizacao + ')';
      end;
  end;
end;

function TEnvioLote.GerarMsgLog: String;
var
  LDhRecepcao: String;
begin
  LDhRecepcao := '';
  if FdhRecepcao <> 0 then
    LDhRecepcao := FormatDateTime('dd/mm/yyyy hh:nn:ss', FdhRecepcao);

  Result := Format(ACBrStr('Versao Layout: %s ' + sLineBreak +
                           'Ambiente: %s ' + sLineBreak +
                           'Codigo HTTP: %s ' + sLineBreak +
                           'Status Codigo: %s ' + sLineBreak +
                           'Status Descricao: %s ' + sLineBreak +
                           'Recebimento: %s ' + sLineBreak +
                           'Versao Aplicativo: %s ' + sLineBreak +
                           'Protocolo: %s ' + sLineBreak),
    [VersaoDeREToStr(FVersaoDF),
     TipoAmbienteToStr(FtpAmb),
     IntToStr(FHttpCodigo),
     cdRespostaLoteDeREToStr(FcdResposta),
     FdescResposta,
     LDhRecepcao,
     FversaoAplicativoRecepcao,
     FProtocolo]);
end;

function TEnvioLote.GerarPrefixoArquivo: String;
begin
  Result := FormatDateTime('yyyymmddhhnnss', Now);
end;

function TEnvioLote.GerarMsgErro(E: Exception): String;
begin
  Result := ACBrStr('WebService: ' + FPServico + #13#10 +
    '- Inativo ou Inoperante tente novamente.');
end;

function TEnvioLote.GerarVersaoDadosSoap: String;
begin
  Result := '';
end;

{ TConsultaLote }

constructor TConsultaLote.Create(AOwner: TACBrDFe);
begin
  inherited Create(AOwner);

  FConsLote := TConsLoteDeRE.Create;
end;

destructor TConsultaLote.Destroy;
begin
  FConsLote.Free;
  FRetEnvLote.Free;

  inherited Destroy;
end;

procedure TConsultaLote.Clear;
begin
  inherited Clear;

  FPLayout := LayDeREConsultaLote;
  FPStatus := stDeREConsulta;
  FPArqEnv := '';
  FPArqResp := 'cons-ret';

  FHttpCodigo := 0;
  FcdResposta := crlNenhum;
  FdescResposta := '';

  // O protocolo e dado de entrada: nao e limpo aqui.
  if Assigned(FRetEnvLote) then
    FRetEnvLote.Free;

  FRetEnvLote := TRetEnvLoteDeRE.Create;
end;

function TConsultaLote.GetProtocolo: String;
begin
  Result := FConsLote.Protocolo;
end;

procedure TConsultaLote.SetProtocolo(const Value: String);
begin
  FConsLote.Protocolo := Value;
end;

function TConsultaLote.GetRetornoLote: TretornoLoteDeRE;
begin
  Result := FRetEnvLote.RetornoLote;
end;

procedure TConsultaLote.DefinirURL;
begin
  FPLayout := LayDeREConsultaLote;

  inherited DefinirURL;

  // O protocolo e o ultimo segmento do endereco: <URL>/<protocolo>
  FPURL := FConsLote.MontarURL(FPURL);
end;

procedure TConsultaLote.DefinirServicoEAction;
begin
  FPServico := 'ConsultaLote';
  // API REST: nao ha SoapAction ('*' e convertido em vazio por InicializarServico)
  FPSoapAction := '*';
end;

procedure TConsultaLote.DefinirDadosMsg;
begin
  { GET: nao ha corpo na requisicao }
  FPDadosMsg := '';

  // Como nao ha XML de envio, o evento recebe o protocolo consultado
  if Assigned(TACBrDeRE(FPDFeOwner).OnTransmissaoEventos) then
    TACBrDeRE(FPDFeOwner).OnTransmissaoEventos(Protocolo, edEnvioConsulta);
end;

procedure TConsultaLote.DefinirEnvelopeSoap;
begin
  { Nao ha envelope SOAP. Com o envelope vazio, TDFeSSL.Enviar faz um GET. }
  FPMimeType := 'application/xml';
  FPValidateReturnCode := False;
  FPAuthorizationHeader := 'Bearer ' + Trim(FPConfiguracoesDeRE.Geral.Token);
  FPEnvelopeSoap := '';
end;

procedure TConsultaLote.InicializarServico;
begin
  FVersaoDF := FPConfiguracoesDeRE.Geral.VersaoDF;

  if Trim(Protocolo) = '' then
    GerarException(ACBrStr('Protocolo do lote da DeRE nao informado.'));

  // Nao gera token automaticamente: usa o que esta em Token/TokenExpira.
  ValidarToken;

  inherited InicializarServico;
end;

function TConsultaLote.TratarResposta: Boolean;
begin
  Result := False;

  FPRetWS := FPRetornoWS;
  FHttpCodigo := FPDFeOwner.SSL.HTTPResultCode;

  // Erro HTTP (ex.: 404 para protocolo nao encontrado) nao gera excecao, igual ao
  // ObterToken: devolve False e o detalhe fica em HttpCodigo e Msg. Isso e avaliado antes
  // de VerificarSemResposta, pois o erro HTTP pode vir sem corpo.
  // Codigo 0 = transmissao feita pela aplicacao (evento OnTransmit): o XML decide.
  if (FHttpCodigo <> 0) and not (FHttpCodigo in [200, 201, 202]) then
  begin
    if Assigned(TACBrDeRE(FPDFeOwner).OnTransmissaoEventos) then
      TACBrDeRE(FPDFeOwner).OnTransmissaoEventos(FPRetWS, edRetornoConsulta);

    FPMsg := 'DeRE - ConsultaLote: Erro HTTP ' + IntToStr(FHttpCodigo);
    if Trim(FPRetWS) <> '' then
      FPMsg := FPMsg + ' - ' + Trim(FPRetWS);
    Exit;
  end;

  VerificarSemResposta;

  if Assigned(TACBrDeRE(FPDFeOwner).OnTransmissaoEventos) then
    TACBrDeRE(FPDFeOwner).OnTransmissaoEventos(FPRetWS, edRetornoConsulta);

  FRetEnvLote.XmlRetorno := FPRetWS;

  if not FRetEnvLote.LerXml then
  begin
    FPMsg := 'DeRE - ConsultaLote: retorno invalido (retornoLoteEventos nao encontrado).';
    Exit;
  end;

  // Separa o retorno de cada evento (ideStatus, ocorrencias, recibos...)
  InterpretarRetornosLote(FRetEnvLote.RetornoLote);

  FcdResposta := FRetEnvLote.RetornoLote.status.cdResposta;
  FdescResposta := FRetEnvLote.RetornoLote.status.descResposta;
  FPMsg := FdescResposta;

  Result := True;
end;

procedure TConsultaLote.SalvarResposta;
begin
  // Erro HTTP pode vir sem corpo: nada a salvar (o Gravar do TACBrDFe criaria um
  // arquivo somente com a declaracao XML).
  if Trim(FPRetWS) = '' then
    Exit;

  // Corpo que nao e XML (ex.: JSON de erro) e salvo como recebido, sem declaracao XML.
  if Copy(TrimLeft(FPRetWS), 1, 1) <> '<' then
  begin
    if FPConfiguracoes.Geral.Salvar then
      WriteToTXT(PathWithDelim(FPConfiguracoesDeRE.Arquivos.GetPathDeRE) +
        GerarPrefixoArquivo + '-' + FPArqResp + '.txt', AnsiString(FPRetWS),
        False, False, True);
    Exit;
  end;

  inherited SalvarResposta;
end;

function TConsultaLote.GerarMsgLog: String;
begin
  Result := Format(ACBrStr('Versao Layout: %s ' + sLineBreak +
                           'Ambiente: %s ' + sLineBreak +
                           'Codigo HTTP: %s ' + sLineBreak +
                           'Protocolo: %s ' + sLineBreak +
                           'Status Codigo: %s ' + sLineBreak +
                           'Status Descricao: %s ' + sLineBreak),
    [VersaoDeREToStr(FVersaoDF),
     TipoAmbienteToStr(FtpAmb),
     IntToStr(FHttpCodigo),
     Protocolo,
     cdRespostaLoteDeREToStr(FcdResposta),
     FdescResposta]);
end;

function TConsultaLote.GerarPrefixoArquivo: String;
begin
  // yyyymmddhhnnss-<protocolo>-cons-ret.xml
  Result := FormatDateTime('yyyymmddhhnnss', Now) + '-' + Trim(Protocolo);
end;

function TConsultaLote.GerarMsgErro(E: Exception): String;
begin
  Result := ACBrStr('WebService: ' + FPServico + #13#10 +
    '- Inativo ou Inoperante tente novamente.');
end;

function TConsultaLote.GerarVersaoDadosSoap: String;
begin
  Result := '';
end;

{ TLimpezaDados }

constructor TLimpezaDados.Create(AOwner: TACBrDFe);
begin
  inherited Create(AOwner);

  FLimpeza := TLimpezaDeRE.Create;
  FRetLimpeza := TRetLimpezaDeRE.Create;
end;

destructor TLimpezaDados.Destroy;
begin
  FLimpeza.Free;
  FRetLimpeza.Free;

  inherited Destroy;
end;

procedure TLimpezaDados.Clear;
begin
  inherited Clear;

  FPLayout := LayDeRELimpeza;
  FPStatus := stDeRELimpeza;
  FPArqEnv := '';
  FPArqResp := 'limpeza-ret';

  FHttpCodigo := 0;
  FHttpTransmit := 0;

  // O CNPJ base e dado de entrada: nao e limpo aqui.
  // (Clear tambem e chamado pelo inherited Create, antes de FRetLimpeza existir)
  if Assigned(FRetLimpeza) then
    FRetLimpeza.Clear;
end;

function TLimpezaDados.GetnrInsc: String;
begin
  Result := FLimpeza.nrInsc;
end;

procedure TLimpezaDados.SetnrInsc(const Value: String);
begin
  FLimpeza.nrInsc := Value;
end;

procedure TLimpezaDados.DefinirURL;
begin
  FPLayout := LayDeRELimpeza;

  inherited DefinirURL;

  // O CNPJ base e o ultimo segmento do endereco: <URL>/<CNPJ base>
  FPURL := FLimpeza.MontarURL(FPURL);
end;

procedure TLimpezaDados.DefinirServicoEAction;
begin
  FPServico := 'Limpeza';
  // API REST: nao ha SoapAction ('*' e convertido em vazio por InicializarServico)
  FPSoapAction := '*';
end;

procedure TLimpezaDados.DefinirDadosMsg;
begin
  { DELETE: nao ha corpo na requisicao }
  FPDadosMsg := '';
end;

procedure TLimpezaDados.DefinirEnvelopeSoap;
begin
  FPMimeType := '';
  FPValidateReturnCode := False;
  FPAuthorizationHeader := 'Bearer ' + Trim(FPConfiguracoesDeRE.Geral.Token);
  FPEnvelopeSoap := '';
end;

procedure TLimpezaDados.InicializarServico;
begin
  if FPConfiguracoesDeRE.WebServices.Ambiente <> taHomologacao then
    GerarException(ACBrStr('A limpeza dos dados so existe na Producao Restrita ' +
      '(Configuracoes.WebServices.Ambiente = taHomologacao).'));

  // Sem informar, usa a raiz do CNPJ do contribuinte (8 primeiras posicoes)
  if Trim(FLimpeza.nrInsc) = '' then
    FLimpeza.nrInsc := Copy(OnlyCPFCNPJAlphaNum(
      FPConfiguracoesDeRE.Geral.IdContribuinte), 1, 8);

  if not FLimpeza.NrInscValido then
    GerarException(ACBrStr('CNPJ base (8 posicoes) do contribuinte invalido ou nao informado.'));

  // Nao gera token automaticamente: usa o que esta em Token/TokenExpira.
  ValidarToken;

  inherited InicializarServico;
end;

procedure TLimpezaDados.EnviarDados;
var
  Tentar, Tratado: Boolean;
  HTTPResultCode, InternalErrorCode: Integer;
  LHttp: TDFeSSLHttpClass;
begin
  { O SSL.Enviar so faz GET/POST. Para o DELETE a requisicao usa o SSLHttpClass com
    o Method definido, como os servicos REST do ACBrNFSeX e do ACBrANe. }
  FPRetWS := '';
  FPRetornoWS := '';
  FHttpTransmit := 0;

  if (FPConfiguracoes.Certificados.NumeroSerie <> '') or
     (FPConfiguracoes.Certificados.DadosPFX <> '') or
     (FPConfiguracoes.Certificados.ArquivoPFX <> '') then
    if FPConfiguracoes.Certificados.VerificarValidade then
      if (FPDFeOwner.SSL.CertDataVenc < Now) then
        raise EACBrDFeException.Create(ACBrStr('Data de Validade do Certificado já expirou: ') +
                                       FormatDateBr(FPDFeOwner.SSL.CertDataVenc));

  Tentar := True;
  while Tentar do
  begin
    Tentar  := False;
    Tratado := False;
    FPRetornoWS := '';
    HTTPResultCode := 0;
    InternalErrorCode := 0;

    try
      // Envio por Evento... Aplicacao cuidara do envio (o evento nao informa o
      // metodo: a aplicacao deve enviar um DELETE para a URL recebida)
      if Assigned(FPDFeOwner.OnTransmit) then
      begin
        FPDFeOwner.OnTransmit(FPEnvelopeSoap, FPURL, FPSoapAction, FPMimeType,
                              FPRetornoWS, HTTPResultCode, InternalErrorCode);

        if (InternalErrorCode <> 0) then
          raise EACBrDFeException.Create('Erro ao Transmitir');
      end
      else   // Envio interno, por TDFeSSL
      begin
        LHttp := FPDFeOwner.SSL.SSLHttpClass;
        LHttp.Clear;
        LHttp.URL := FPURL;
        LHttp.Method := 'DELETE';
        LHttp.MimeType := FPMimeType;
        LHttp.HeaderReq.AddHeader('Authorization', FPAuthorizationHeader);

        try
          try
            LHttp.Execute;
          finally
            HTTPResultCode := LHttp.HTTPResultCode;
            InternalErrorCode := LHttp.InternalErrorCode;
          end;

          // Sucesso (200) nao traz corpo: nao ha erro por retorno vazio
          LHttp.DataResp.Position := 0;
          FPRetornoWS := ReadStrFromStream(LHttp.DataResp, LHttp.DataResp.Size);
        except
          on E: Exception do
            raise EACBrDFeException.CreateDef(Format(ACBrStr(cACBrDFeSSLEnviarException),
              [LHttp.InternalErrorCode, LHttp.HTTPResultCode, LHttp.URL]) +
              sLineBreak + LHttp.LastErrorDesc + sLineBreak + E.Message);
        end;
      end;

      FHttpTransmit := HTTPResultCode;
    except
      if Assigned(FPDFeOwner.OnTransmitError) then
        FPDFeOwner.OnTransmitError(HTTPResultCode, InternalErrorCode,
                                   FPURL, FPEnvelopeSoap, FPSoapAction,
                                   Tentar, Tratado);

      if not (Tentar or Tratado) then
      begin
        if InternalErrorCode = 10060 {WSAETIMEDOUT} then
          raise EACBrDFeExceptionTimeOut.Create('Connection Time Out')
        else
          raise;
      end;
    end;
  end;
end;

procedure TLimpezaDados.SalvarResposta;
begin
  // Sucesso (HTTP 200) nao traz corpo: sem retorno, nada e salvo (o Gravar do
  // TACBrDFe criaria um arquivo somente com a declaracao XML).
  if Trim(FPRetWS) = '' then
    Exit;

  // Corpo que nao e XML (ex.: JSON de erro) e salvo como recebido, sem declaracao XML.
  if Copy(TrimLeft(FPRetWS), 1, 1) <> '<' then
  begin
    if FPConfiguracoes.Geral.Salvar then
      WriteToTXT(PathWithDelim(FPConfiguracoesDeRE.Arquivos.GetPathDeRE) +
        GerarPrefixoArquivo + '-' + FPArqResp + '.txt', AnsiString(FPRetWS),
        False, False, True);
    Exit;
  end;

  inherited SalvarResposta;
end;

function TLimpezaDados.TratarResposta: Boolean;
begin
  FPRetWS := FPRetornoWS;
  FHttpCodigo := FHttpTransmit;

  FRetLimpeza.HttpCodigo := FHttpCodigo;
  FRetLimpeza.Corpo := DecodeToString(AnsiString(FPRetWS), True);

  Result := FRetLimpeza.Interpretar;
  FPMsg := FRetLimpeza.Msg;
end;

function TLimpezaDados.GerarMsgLog: String;
begin
  Result := Format(ACBrStr('Versao Layout: %s ' + sLineBreak +
                           'Ambiente: %s ' + sLineBreak +
                           'CNPJ base: %s ' + sLineBreak +
                           'Codigo HTTP: %s ' + sLineBreak +
                           'Mensagem: %s ' + sLineBreak),
    [VersaoDeREToStr(FPConfiguracoesDeRE.Geral.VersaoDF),
     TipoAmbienteToStr(FtpAmb),
     FLimpeza.nrInsc,
     IntToStr(FHttpCodigo),
     FPMsg]);
end;

function TLimpezaDados.GerarPrefixoArquivo: String;
begin
  // yyyymmddhhnnss-<CNPJ base>-limpeza-ret.xml
  Result := FormatDateTime('yyyymmddhhnnss', Now) + '-' + OnlyCPFCNPJAlphaNum(FLimpeza.nrInsc);
end;

function TLimpezaDados.GerarMsgErro(E: Exception): String;
begin
  Result := ACBrStr('WebService: ' + FPServico + #13#10 +
    '- Inativo ou Inoperante tente novamente.');
end;

function TLimpezaDados.GerarVersaoDadosSoap: String;
begin
  Result := '';
end;

{ TWebServices }

constructor TWebServices.Create(AOwner: TACBrDFe);
begin
  inherited Create;

  FACBrDeRE := AOwner;
  FObterToken := TObterToken.Create(FACBrDeRE);
  FEnvioLote := TEnvioLote.Create(FACBrDeRE, TACBrDeRE(FACBrDeRE).Eventos);
  FConsultaLote := TConsultaLote.Create(FACBrDeRE);
  FLimpezaDados := TLimpezaDados.Create(FACBrDeRE);
end;

destructor TWebServices.Destroy;
begin
  FObterToken.Free;
  FEnvioLote.Free;
  FConsultaLote.Free;
  FLimpezaDados.Free;

  inherited Destroy;
end;

function TWebServices.GetToken: string;
begin
  Result := TACBrDeRE(FACBrDeRE).Configuracoes.Geral.Token;
end;

procedure TWebServices.SetToken(const Value: string);
begin
  TACBrDeRE(FACBrDeRE).Configuracoes.Geral.Token := Value;
end;

function TWebServices.GetTokenExpira: TDateTime;
begin
  Result := TACBrDeRE(FACBrDeRE).Configuracoes.Geral.TokenExpira;
end;

procedure TWebServices.SetTokenExpira(const Value: TDateTime);
begin
  TACBrDeRE(FACBrDeRE).Configuracoes.Geral.TokenExpira := Value;
end;

procedure TWebServices.LimparToken;
begin
  Token := '';
  TokenExpira := 0;
  FObterToken.Clear;
end;

function TWebServices.Envia: Boolean;
begin
  FEnvioLote.Clear;

{$IFDEF FPC}
  Result := False;
{$ENDIF}

  if not EnvioLote.Executar then
    EnvioLote.GerarException(EnvioLote.Msg);

  Result := True;
end;

function TWebServices.Consulta(const AProtocolo: string): Boolean;
begin
  FConsultaLote.Clear;
  FConsultaLote.Protocolo := AProtocolo;

{$IFDEF FPC}
  Result := False;
{$ENDIF}

  // Falha (ex.: erro HTTP, retorno invalido) nao gera excecao: Result = False e o
  // detalhe fica em ConsultaLote.HttpCodigo e ConsultaLote.Msg.
  Result := ConsultaLote.Executar;
end;

function TWebServices.Limpa(const ANrInsc: string): Boolean;
begin
  FLimpezaDados.Clear;
  FLimpezaDados.nrInsc := ANrInsc;

{$IFDEF FPC}
  Result := False;
{$ENDIF}

  if not LimpezaDados.Executar then
    LimpezaDados.GerarException(LimpezaDados.Msg);

  Result := True;
end;

end.
