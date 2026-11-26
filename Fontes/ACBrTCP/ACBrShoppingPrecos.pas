{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Fábio Tellini                                   }
{                                                                              }
{                                                                              }
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

{******************************************************************************
|* Historico
|*
|* 29/09/2026: Fábio Tellini
|*  - Primeira Versao ACBrShoppingPrecos
|* 24/10/2026: Projeto ACBr
|*  - Integracao ao trunk: pacotes, Lazarus, encoding, datas e nomes da API
|* 25/11/2026: Projeto ACBr
|*  - Revisao: data zerada/fuso em SDPData, XML da NF-e por bytes
|*    (CarregarXMLNFe), listas com base comum e testes ampliados
|*
|* Documentacao da API: https://apidoc.shoppingdeprecos.com.br/introducao
******************************************************************************}

{$I ACBr.inc}
unit ACBrShoppingPrecos;

interface

uses Classes, SysUtils, ACBrBase, ACBrSocket, ACBrJSON,
  ACBrShoppingPrecosModelos, ACBrShoppingPrecosConfiguracoes,
  ACBrShoppingPrecosModelosAPI;

type
  { Rota do envio em lote (produtos, estoque ou preco). Fica na interface
    porque o Delphi 7 nao aceita tipos aninhados; trate como API estavel:
    novos valores entram no fim. }
  TSDPModoEnvioLote = (sdpmProduto, sdpmEstoque, sdpmPreco);

  TSDPRetorno = class(TPersistent)
  private
    FCodigoHTTP: Integer;
    FSucesso: Boolean;
    FMensagem, FProtocolo, FJSON, FContentType: string;
  public
    procedure Limpar;
    property CodigoHTTP: Integer read FCodigoHTTP;
    property Sucesso: Boolean read FSucesso;
    property Mensagem: string read FMensagem;
    property Protocolo: string read FProtocolo;
    property JSON: string read FJSON;
    property ContentType: string read FContentType;
  end;

  { Os filtros sao entradas; nunca sao substituidos pela resposta. }
  TSDPFiltroPedidos = class(TPersistent)
  private
    FDataInicial, FDataFinal: TDateTime;
    FStatus: string;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property DataInicial: TDateTime read FDataInicial write FDataInicial;
    property DataFinal: TDateTime read FDataFinal write FDataFinal;
    property Status: string read FStatus write FStatus;
  end;

  {$IFDEF RTL230_UP}
  [ComponentPlatformsAttribute(piacbrAllPlatforms)]
  {$ENDIF}
  TACBrShoppingPrecos = class(TACBrComponent)
  private
    FPlataformas: TSDPPlataformaLista;
    FIntegracoes: TSDPIntegracaoLista;
    FEstoquesIntegracao: TSDPEstoqueIntegracaoLista;
    FPrecosIntegracao: TSDPPrecoIntegracaoLista;
    FMarcas: TSDPOpcaoPlataformaLista;
    FAtributosPlataforma: TSDPOpcaoPlataformaLista;
    FEstoquesAnuncios: TSDPEstoqueAnuncioLista;
    FPrecosAnuncios: TSDPPrecoAnuncioLista;
    FResultadosAnuncios: TSDPResultadoAnuncioLista;
    FProdutoPlataforma: TSDPProdutoPlataforma;
    FSituacoesPersonalizadas: TSDPSituacaoPersonalizadaLista;
    FItensAceite: TSDPAceiteItemLista;
    FNotasPedidos: TSDPNotaPedidoLista;
    FFiltroXML: TSDPFiltroXML;
    FRelatorioXML: TSDPRelatorioXML;
    FPedidosXML: TStringList;
    FArquivoIcone: TMemoryStream;
    FArquivoRelatorioXML: TMemoryStream;
    FCategoriaID: string;
    FHTTP: TACBrHTTP;
    FConfiguracoes: TSDPConfiguracoes;
    FProduto: TSDPProduto;
    FProdutos: TSDPProdutoLista;
    FPedido: TSDPPedido;
    FPedidos: TSDPPedidoLista;
    FFilaPedidos: TSDPFilaPedidoLista;
    FCategorias: TSDPCategoriaLista;
    FEtiquetas: TSDPEtiquetaLista;
    FAtualizacaoStatus: TSDPAtualizacaoStatus;
    FFiltroPedidos: TSDPFiltroPedidos;
    FFormatoEtiqueta: TSDPFormatoEtiqueta;
    FPedidosEtiquetas, FFilaIDsImportados: TStringList;
    FArquivoEtiqueta: TMemoryStream;
    FRetorno: TSDPRetorno;
    function CaminhoProdutosIntegracao: string;
    function FormularioPlataforma: string;
    function ConsultarListaAPI(const Metodo, URL, ContentType, Corpo: string;
      Lista: TSDPListaAPI): Boolean;
    function EnviarComandoAPI(const URL, ContentType, Corpo: string): Boolean;
    function ValidarResultadosAnuncios(Enviados: TSDPListaAPI): Boolean;
    function BaixarArquivoPublico(const URL: string; Destino: TMemoryStream;
      Icone: Boolean): Boolean;
    function GetTimeOut: Integer;
    procedure SetTimeOut(Value: Integer);
    function GetProxyHost: string;
    function GetProxyPass: string;
    function GetProxyPort: string;
    function GetProxyUser: string;
    procedure SetProxyHost(const Value: string);
    procedure SetProxyPass(const Value: string);
    procedure SetProxyPort(const Value: string);
    procedure SetProxyUser(const Value: string);
    procedure ConfigurarTransporte(HTTP: TACBrHTTP);
    function LerResposta(HTTP: TACBrHTTP; out Codigo: Integer;
      out TipoResposta: string): AnsiString;
    procedure SetConfiguracoes(Value: TSDPConfiguracoes);
    procedure SetProduto(Value: TSDPProduto);
    procedure SetProdutos(Value: TSDPProdutoLista);
    procedure SetPedido(Value: TSDPPedido);
    procedure SetAtualizacaoStatus(Value: TSDPAtualizacaoStatus);
    procedure SetFiltroPedidos(Value: TSDPFiltroPedidos);
    procedure ValidarCredenciais;
    procedure ValidarPlataforma;
    function IndicePlataformaAPI: Integer;
    function IntegracaoPedido: string;
    function CaminhoPedido: string;
    function Falhar(const Mensagem: string): Boolean;
    function Requisitar(const Metodo, URL, ContentType: string;
      const Corpo: AnsiString; out Resposta: AnsiString): Boolean;
    function RequisitarJSON(const Metodo, URL, ContentType: string;
      const Corpo: AnsiString): TACBrJSONObject;
    function Registros(J: TACBrJSONObject): TACBrJSONArray;
    function EnviarLote(Modo: TSDPModoEnvioLote): Boolean;
    function JSONProduto(P: TSDPProduto; Modo: TSDPModoEnvioLote ): string;
  protected
    { Cabecalhos de autenticacao da API (sem I/O). }
    procedure MontarCabecalhos(AHeaders: TStrings);
    function ExecutarDownload(const URL: string; out Codigo: Integer;
      out TipoResposta: string): AnsiString; virtual;
    { Ponto de extensao para transporte e testes; nunca faz retry de POST. }
    function ExecutarHTTP(const Metodo, URL, ContentType: string;
      const Corpo: AnsiString; out Codigo: Integer;
      out TipoResposta: string): AnsiString; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ListarPlataformas: Boolean;
    function ListarIntegracoes: Boolean;
    function ConsultarEstoquesIntegracao: Boolean;
    function ConsultarPrecosIntegracao: Boolean;
    function ListarMarcas: Boolean;
    function ListarAtributos: Boolean;
    function EnviarProdutoPlataforma: Boolean;
    function AtualizarEstoqueIntegracao: Boolean;
    function AtualizarPrecosIntegracao: Boolean;
    function ListarSituacoesPersonalizadas: Boolean;
    function AtualizarSituacaoPersonalizada: Boolean;
    function AceitarPedidoCompra: Boolean;
    function RecuperarXMLPedidos: Boolean;
    function SolicitarXMLNotas: Boolean;
    function ConsultarSolicitacaoXML: Boolean;
    function ObterIconePlataforma: Boolean;
    function BaixarRelatorioXML: Boolean;
    function EnviarProdutos: Boolean;
    function AtualizarEstoque: Boolean;
    function AtualizarPreco: Boolean;
    function ListarCategorias: Boolean;
    function BuscarFilaPedidos: Boolean;
    function ListarPedidos: Boolean;
    function ConsultarPedido: Boolean;
    function AtualizarStatus: Boolean;
    function ObterEtiquetas: Boolean;
    { Chamada explicita somente depois de o ERP persistir os pedidos. }
    function ConfirmarImportacaoPedidos: Boolean;
    property Plataformas: TSDPPlataformaLista read FPlataformas;
    property Integracoes: TSDPIntegracaoLista read FIntegracoes;
    property EstoquesIntegracao: TSDPEstoqueIntegracaoLista read FEstoquesIntegracao;
    property PrecosIntegracao: TSDPPrecoIntegracaoLista read FPrecosIntegracao;
    property Marcas: TSDPOpcaoPlataformaLista read FMarcas;
    property AtributosPlataforma: TSDPOpcaoPlataformaLista read FAtributosPlataforma;
    property EstoquesAnuncios: TSDPEstoqueAnuncioLista read FEstoquesAnuncios;
    property PrecosAnuncios: TSDPPrecoAnuncioLista read FPrecosAnuncios;
    property ResultadosAnuncios: TSDPResultadoAnuncioLista read FResultadosAnuncios;
    property ProdutoPlataforma: TSDPProdutoPlataforma read FProdutoPlataforma;
    property SituacoesPersonalizadas: TSDPSituacaoPersonalizadaLista read FSituacoesPersonalizadas;
    property ItensAceite: TSDPAceiteItemLista read FItensAceite;
    property NotasPedidos: TSDPNotaPedidoLista read FNotasPedidos;
    property FiltroXML: TSDPFiltroXML read FFiltroXML;
    property RelatorioXML: TSDPRelatorioXML read FRelatorioXML;
    property PedidosXML: TStringList read FPedidosXML;
    property ArquivoIcone: TMemoryStream read FArquivoIcone;
    property ArquivoRelatorioXML: TMemoryStream read FArquivoRelatorioXML;
    property CategoriaID: string read FCategoriaID write FCategoriaID;
    property Retorno: TSDPRetorno read FRetorno;
    property Pedidos: TSDPPedidoLista read FPedidos;
    property FilaPedidos: TSDPFilaPedidoLista read FFilaPedidos;
    property Categorias: TSDPCategoriaLista read FCategorias;
    property Etiquetas: TSDPEtiquetaLista read FEtiquetas;
    property PedidosEtiquetas: TStringList read FPedidosEtiquetas;
    property FilaIDsImportados: TStringList read FFilaIDsImportados;
    { Mercado Livre: PDF ou ZIP. Position = 0 apos a consulta. }
    property ArquivoEtiqueta: TMemoryStream read FArquivoEtiqueta;
    property Produto: TSDPProduto read FProduto write SetProduto;
    property Produtos: TSDPProdutoLista read FProdutos write SetProdutos;
    property Pedido: TSDPPedido read FPedido write SetPedido;
    property AtualizacaoStatus: TSDPAtualizacaoStatus read FAtualizacaoStatus write SetAtualizacaoStatus;
    property FiltroPedidos: TSDPFiltroPedidos read FFiltroPedidos write SetFiltroPedidos;
  published
    property Configuracoes: TSDPConfiguracoes read FConfiguracoes write SetConfiguracoes;
    property TimeOut: Integer read GetTimeOut write SetTimeOut default cHTTPTimeOutDef;
    { O componente nao segue redirecionamentos, para nao reenviar credenciais a outro host. }
    property ProxyHost: string read GetProxyHost write SetProxyHost;
    property ProxyPort: string read GetProxyPort write SetProxyPort;
    property ProxyUser: string read GetProxyUser write SetProxyUser;
    { Como Senha e Token, nao e gravada no DFM }
    property ProxyPass: string read GetProxyPass write SetProxyPass stored False;
    property FormatoEtiqueta: TSDPFormatoEtiqueta read FFormatoEtiqueta write FFormatoEtiqueta default sdpfPDF;
  end;

implementation

uses
  synacode, ACBrUtil.Strings, ACBrUtil.DateTime;

const
  URLV1 = 'https://api.shoppingdeprecos.com.br/';
  URLV2 = 'https://apiv2.shoppingdeprecos.com.br/';
  TipoFormulario = 'application/x-www-form-urlencoded';
  TipoJSON = 'application/json';
  BoundaryMultipart = 'ACBrSDPBoundary7B79A5';
  LimiteLote = 1000;

function SDPEncode(const S: string): string;
begin
  Result := string(EncodeURLElement(NativeStringToUTF8(S)));
end;

procedure FormCampo(var S: string; const Nome, Valor: string);
begin
  if S <> '' then
    S := S + '&';
  S := S + SDPEncode(Nome) + '=' + SDPEncode(Valor);
end;

{ TSDPRetorno }

procedure TSDPRetorno.Limpar;
begin
  FCodigoHTTP := 0;
  FSucesso := False;
  FMensagem := '';
  FProtocolo := '';
  FJSON := '';
  FContentType := '';
end;

{ TSDPFiltroPedidos }

procedure TSDPFiltroPedidos.Assign(Source: TPersistent);
begin
  if Source is TSDPFiltroPedidos then
  begin
    FDataInicial := TSDPFiltroPedidos(Source).DataInicial;
    FDataFinal := TSDPFiltroPedidos(Source).DataFinal;
    FStatus := TSDPFiltroPedidos(Source).Status;
  end
  else
    inherited Assign(Source);
end;

{ TACBrShoppingPrecos }

constructor TACBrShoppingPrecos.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FPlataformas := TSDPPlataformaLista.Create;
  FIntegracoes := TSDPIntegracaoLista.Create;
  FEstoquesIntegracao := TSDPEstoqueIntegracaoLista.Create;
  FPrecosIntegracao := TSDPPrecoIntegracaoLista.Create;
  FMarcas := TSDPOpcaoPlataformaLista.Create;
  FAtributosPlataforma := TSDPOpcaoPlataformaLista.Create;
  FEstoquesAnuncios := TSDPEstoqueAnuncioLista.Create;
  FPrecosAnuncios := TSDPPrecoAnuncioLista.Create;
  FResultadosAnuncios := TSDPResultadoAnuncioLista.Create;
  FProdutoPlataforma := TSDPProdutoPlataforma.Create(nil);
  FSituacoesPersonalizadas := TSDPSituacaoPersonalizadaLista.Create;
  FItensAceite := TSDPAceiteItemLista.Create;
  FNotasPedidos := TSDPNotaPedidoLista.Create;
  FFiltroXML := TSDPFiltroXML.Create(nil);
  FRelatorioXML := TSDPRelatorioXML.Create(nil);
  FPedidosXML := TStringList.Create;
  FArquivoIcone := TMemoryStream.Create;
  FArquivoRelatorioXML := TMemoryStream.Create;
  FHTTP := TACBrHTTP.Create(nil);
  FConfiguracoes := TSDPConfiguracoes.Create;
  FProduto := TSDPProduto.Create(nil);
  FProdutos := TSDPProdutoLista.Create;
  FPedido := TSDPPedido.Create(nil);
  FPedidos := TSDPPedidoLista.Create;
  FFilaPedidos := TSDPFilaPedidoLista.Create;
  FCategorias := TSDPCategoriaLista.Create;
  FEtiquetas := TSDPEtiquetaLista.Create;
  FAtualizacaoStatus := TSDPAtualizacaoStatus.Create(nil);
  FFiltroPedidos := TSDPFiltroPedidos.Create;
  FPedidosEtiquetas := TStringList.Create;
  FFilaIDsImportados := TStringList.Create;
  FArquivoEtiqueta := TMemoryStream.Create;
  FRetorno := TSDPRetorno.Create;
  FHTTP.ContentsEncodingCompress := [];
  FHTTP.TimeOut := cHTTPTimeOutDef;
end;

destructor TACBrShoppingPrecos.Destroy;
begin
  FPlataformas.Free;
  FIntegracoes.Free;
  FEstoquesIntegracao.Free;
  FPrecosIntegracao.Free;
  FMarcas.Free;
  FAtributosPlataforma.Free;
  FEstoquesAnuncios.Free;
  FPrecosAnuncios.Free;
  FResultadosAnuncios.Free;
  FProdutoPlataforma.Free;
  FSituacoesPersonalizadas.Free;
  FItensAceite.Free;
  FNotasPedidos.Free;
  FFiltroXML.Free;
  FRelatorioXML.Free;
  FPedidosXML.Free;
  FArquivoIcone.Free;
  FArquivoRelatorioXML.Free;
  FRetorno.Free;
  FArquivoEtiqueta.Free;
  FFilaIDsImportados.Free;
  FPedidosEtiquetas.Free;
  FFiltroPedidos.Free;
  FAtualizacaoStatus.Free;
  FEtiquetas.Free;
  FCategorias.Free;
  FFilaPedidos.Free;
  FPedidos.Free;
  FPedido.Free;
  FProdutos.Free;
  FProduto.Free;
  FConfiguracoes.Free;
  FHTTP.Free;
  inherited Destroy;
end;

function TACBrShoppingPrecos.GetTimeOut: Integer;
begin
  Result := FHTTP.TimeOut;
end;

procedure TACBrShoppingPrecos.SetTimeOut(Value: Integer);
begin
  FHTTP.TimeOut := Value;
end;

function TACBrShoppingPrecos.GetProxyHost: string;
begin
  Result := FHTTP.ProxyHost;
end;

function TACBrShoppingPrecos.GetProxyPass: string;
begin
  Result := FHTTP.ProxyPass;
end;

function TACBrShoppingPrecos.GetProxyPort: string;
begin
  Result := FHTTP.ProxyPort;
end;

function TACBrShoppingPrecos.GetProxyUser: string;
begin
  Result := FHTTP.ProxyUser;
end;

procedure TACBrShoppingPrecos.SetProxyHost(const Value: string);
begin
  FHTTP.ProxyHost := Value;
end;

procedure TACBrShoppingPrecos.SetProxyPass(const Value: string);
begin
  FHTTP.ProxyPass := Value;
end;

procedure TACBrShoppingPrecos.SetProxyPort(const Value: string);
begin
  FHTTP.ProxyPort := Value;
end;

procedure TACBrShoppingPrecos.SetProxyUser(const Value: string);
begin
  FHTTP.ProxyUser := Value;
end;

procedure TACBrShoppingPrecos.ConfigurarTransporte(HTTP: TACBrHTTP);
begin
  HTTP.HTTPSend.Timeout := TimeOut;
  HTTP.HTTPSend.Sock.ConnectionTimeout := TimeOut;
  HTTP.HTTPSend.Sock.NonblockSendTimeout := TimeOut;

  if HTTP <> FHTTP then
  begin
    HTTP.ProxyHost := ProxyHost;
    HTTP.ProxyPort := ProxyPort;
    HTTP.ProxyUser := ProxyUser;
    HTTP.ProxyPass := ProxyPass;
  end;
end;

function TACBrShoppingPrecos.LerResposta(HTTP: TACBrHTTP; out Codigo: Integer;
  out TipoResposta: string): AnsiString;
var
  Stream: TStream;
begin
  Result := '';
  Codigo := HTTP.HTTPSend.ResultCode;
  TipoResposta := HTTP.HTTPSend.MimeType;
  Stream := HTTP.HTTPSend.OutputStream;

  if Stream = nil then
    Stream := HTTP.HTTPSend.Document;

  SetLength(Result, Integer(Stream.Size));
  Stream.Position := 0;

  if Length(Result) > 0 then
    Stream.ReadBuffer(Result[1], Length(Result));
end;

procedure TACBrShoppingPrecos.SetConfiguracoes(Value: TSDPConfiguracoes);
begin
  FConfiguracoes.Assign(Value);
end;

procedure TACBrShoppingPrecos.SetProduto(Value: TSDPProduto);
begin
  FProduto.Assign(Value);
end;

procedure TACBrShoppingPrecos.SetProdutos(Value: TSDPProdutoLista);
begin
  FProdutos.Assign(Value);
end;

procedure TACBrShoppingPrecos.SetPedido(Value: TSDPPedido);
begin
  FPedido.Assign(Value);
end;

procedure TACBrShoppingPrecos.SetAtualizacaoStatus(Value: TSDPAtualizacaoStatus);
begin
  FAtualizacaoStatus.Assign(Value);
end;

procedure TACBrShoppingPrecos.SetFiltroPedidos(Value: TSDPFiltroPedidos);
begin
  FFiltroPedidos.Assign(Value);
end;

procedure TACBrShoppingPrecos.ValidarCredenciais;
begin
  if (Trim(Configuracoes.Usuario) = '') or
     (Configuracoes.Senha = '') or
     (Trim(Configuracoes.Token) = '') then
    raise EACBrShoppingPrecos.Create('Informe Usuario, Senha e Token nas Configuracoes');

  if (Pos(#13, Configuracoes.Token) > 0) or
     (Pos(#10, Configuracoes.Token) > 0) or
     (Pos(':', Configuracoes.Usuario) > 0) then
    raise EACBrShoppingPrecos.Create('Credenciais possuem caracteres invalidos');
end;

function TACBrShoppingPrecos.IndicePlataformaAPI: Integer;
begin
  Result := Plataformas.Count - 1;
  while (Result >= 0) and (Plataformas[Result].ID <> Configuracoes.Plataforma) do
    Dec(Result);
end;

procedure TACBrShoppingPrecos.ValidarPlataforma;
begin
  if Configuracoes.Plataforma <= 0 then
    raise EACBrShoppingPrecos.Create('Selecione a Configuracoes.Plataforma (atual: ' +
      IntToStr(Configuracoes.Plataforma) + ')');

  { Com a lista da API carregada (ListarPlataformas), ela e a referencia;
    sem ela, aceita o codigo informado, mesmo fora da tabela estatica. }
  if (Plataformas.Count > 0) and (IndicePlataformaAPI < 0) then
    raise EACBrShoppingPrecos.Create('Plataforma ' + IntToStr(Configuracoes.Plataforma) +
      ' nao consta na lista retornada por ListarPlataformas');
end;

function TACBrShoppingPrecos.IntegracaoPedido: string;
begin
  Result := Pedido.IntegracaoID;

  if Result = '' then
    Result := Configuracoes.IntegracaoID;

  if Trim(Result) = '' then
    raise EACBrShoppingPrecos.Create('Informe IntegracaoID da conta no Shopping de Precos');
end;

function TACBrShoppingPrecos.CaminhoPedido: string;
begin
  if Trim(Pedido.PedidoID) = '' then
    raise EACBrShoppingPrecos.Create('Informe Pedido.PedidoID');

  Result := URLV2 + 'pedidos/' + SDPEncode(Pedido.PedidoID) +
    '/integracao/' + SDPEncode(IntegracaoPedido);
end;

function TACBrShoppingPrecos.Falhar(const Mensagem: string): Boolean;
begin
  FRetorno.FSucesso := False;
  FRetorno.FMensagem := Mensagem;
  Result := False;
end;

procedure TACBrShoppingPrecos.MontarCabecalhos(AHeaders: TStrings);
begin
  AHeaders.Add('Authorization: Basic ' +
    string(EncodeBase64(NativeStringToUTF8(Configuracoes.Usuario + ':' + Configuracoes.Senha))));
  AHeaders.Add('X-Client: ' + Configuracoes.Token);
  AHeaders.Add('Accept: application/json, application/pdf, application/zip');
end;

function TACBrShoppingPrecos.ExecutarHTTP(const Metodo, URL, ContentType: string;
  const Corpo: AnsiString; out Codigo: Integer; out TipoResposta: string): AnsiString;
begin
  { Uso direto do transporte ACBr: sem redirecionar credenciais a outro host,
    sem registrar Authorization, Token ou dados pessoais em logs. }
  FHTTP.LimparHTTP;
  ConfigurarTransporte(FHTTP);
  FHTTP.HTTPSend.MimeType := ContentType;
  MontarCabecalhos(FHTTP.HTTPSend.Headers);

  if Length(Corpo) > 0 then
    FHTTP.HTTPSend.Document.WriteBuffer(Corpo[1], Length(Corpo));

  Codigo := 0;
  TipoResposta := '';
  Result := '';

  if not FHTTP.HTTPSend.HTTPMethod(Metodo, URL) then
    raise EACBrShoppingPrecos.Create('Falha no transporte HTTP: ' + FHTTP.HTTPSend.Sock.LastErrorDesc);

  Result := LerResposta(FHTTP, Codigo, TipoResposta);
end;

function TACBrShoppingPrecos.Requisitar(const Metodo, URL, ContentType: string;
  const Corpo: AnsiString; out Resposta: AnsiString): Boolean;
begin
  FRetorno.Limpar;
  ValidarCredenciais;
  Resposta := '';
  try
    Resposta := ExecutarHTTP(Metodo, URL, ContentType, Corpo,
      FRetorno.FCodigoHTTP, FRetorno.FContentType);
    Result := (Retorno.CodigoHTTP >= 200) and (Retorno.CodigoHTTP <= 299);

    if not Result then
    begin
      FRetorno.FJSON := UTF8ToNativeString(Resposta);
      Falhar('HTTP ' + IntToStr(Retorno.CodigoHTTP));
    end;
  except
    on E: Exception do
      Result := Falhar(E.Message);
  end;
end;

function TACBrShoppingPrecos.RequisitarJSON(const Metodo, URL, ContentType: string;
  const Corpo: AnsiString): TACBrJSONObject;
var
  Resposta: AnsiString;
  HTTPValido: Boolean;
  J: TACBrJSONObject;
begin
  Result := nil;
  J := nil;
  HTTPValido := Requisitar(Metodo, URL, ContentType, Corpo, Resposta);
  FRetorno.FJSON := UTF8ToNativeString(Resposta);
  try
    if Trim(Retorno.JSON) = '' then
    begin
      if HTTPValido then
        Falhar('Resposta JSON vazia');
      Exit;
    end;
    J := TACBrJSONObject.Parse(Retorno.JSON);

    if J.ValueExists('message') and not SDPIsNull(J, 'message') then
      FRetorno.FMensagem := J.AsString['message'];

    if not HTTPValido then
    begin
      FreeAndNil(J);
      Exit;
    end;

    if not J.ValueExists('status') then
      raise EACBrShoppingPrecos.Create('Resposta sem campo status');

    if SDPIsNull(J, 'status') then
      raise EACBrShoppingPrecos.Create('Status nulo na resposta');
    FRetorno.FSucesso := J.AsBoolean['status'];

    if J.ValueExists('protocolo') and not SDPIsNull(J, 'protocolo') then
      FRetorno.FProtocolo := J.AsString['protocolo'];

    if not Retorno.Sucesso then
    begin
      if Retorno.Mensagem = '' then
        Falhar('API retornou status=false');
      FreeAndNil(J);
      Exit;
    end;
    Result := J;
    J := nil;
  except
    on E: Exception do
    begin
      { Erro HTTP com corpo nao JSON (ex.: HTML de 502): preserva "HTTP nnn" }
      if HTTPValido then
        Falhar('Resposta JSON invalida: ' + E.Message);
    end;
  end;
  J.Free;
end;

function TACBrShoppingPrecos.Registros(J: TACBrJSONObject): TACBrJSONArray;
begin
  if not J.IsJSONArray('registros') then
    raise EACBrShoppingPrecos.Create('Resposta sem array registros');
  Result := J.AsJSONArray['registros'];
end;

function TACBrShoppingPrecos.JSONProduto(P: TSDPProduto; Modo: TSDPModoEnvioLote ): string;
var
  J: TACBrJSONObject;
  N: Integer;
  Soma: Currency;
begin
  if Trim(P.SKU) = '' then
    raise EACBrShoppingPrecos.Create('Produto sem SKU');
  Result := '';

  if Modo = sdpmProduto then
  begin
    if Trim(P.Titulo) = '' then
      raise EACBrShoppingPrecos.Create('Produto sem Titulo: ' + P.SKU);

    for N := 0 to P.Variacoes.Count - 1 do
    begin
      if P.Variacoes[N].SKU = '' then
        raise EACBrShoppingPrecos.Create('Variacao sem SKU');
    end;

    if P.Kit and (P.ItensKit.Count = 0) then
      raise EACBrShoppingPrecos.Create('Kit sem ItensKit');

    Soma := 0;
    for N := 0 to P.ItensKit.Count - 1 do
    begin
      if (P.ItensKit[N].SKU = '') or (P.ItensKit[N].Quantidade <= 0) then
        raise EACBrShoppingPrecos.Create('Item de kit sem SKU ou quantidade positiva');
      Soma := Soma + P.ItensKit[N].PercentualValor;
    end;

    if (P.ItensKit.Count > 0) and (Abs(Soma - 100) > 0.0001) then
      raise EACBrShoppingPrecos.Create('Percentuais dos itens do kit devem somar 100');
    Result := P.GerarJSON;
    Exit;
  end;
  SDPPar(Result, 'SKU', SDPQuote(P.SKU));

  if Modo = sdpmEstoque then
  begin
    if P.EstadoCampo('Estoque') <> sdpcValor then
      raise EACBrShoppingPrecos.Create('Informe Estoque para ' + P.SKU);

    if P.Estoque < 0 then
      raise EACBrShoppingPrecos.Create('Estoque negativo: ' + P.SKU);
    SDPPar(Result, 'Estoque', IntToStr(P.Estoque));
  end
  else
  begin
    if P.EstadoCampo('Preco') <> sdpcValor then
      raise EACBrShoppingPrecos.Create('Informe Preco para ' + P.SKU);

    if P.Preco < 0 then
      raise EACBrShoppingPrecos.Create('Preco negativo: ' + P.SKU);

    SDPPar(Result, 'Preco', SDPNumero(P.Preco));
    J := TACBrJSONObject.Parse(P.GerarJSON);
    try
      if P.EstadoCampo('PrecoCusto') = sdpcValor then
        SDPPar(Result, 'PrecoCusto', SDPNumero(P.PrecoCusto));

      if P.EstadoCampo('PrecoCusto') = sdpcNulo then
        SDPPar(Result, 'PrecoCusto', 'null');

      if P.EstadoCampo('PrecoPromocao') = sdpcValor then
        SDPPar(Result, 'PrecoPromocao', SDPNumero(P.PrecoPromocao));

      if P.EstadoCampo('PrecoPromocao') = sdpcNulo then
        SDPPar(Result, 'PrecoPromocao', 'null');

      if P.EstadoCampo('InicioPromocao') = sdpcValor then
        SDPPar(Result, 'InicioPromocao', SDPQuote(J.AsString['InicioPromocao']));

      if P.EstadoCampo('InicioPromocao') = sdpcNulo then
        SDPPar(Result, 'InicioPromocao', 'null');

      if P.EstadoCampo('TerminoPromocao') = sdpcValor then
        SDPPar(Result, 'TerminoPromocao', SDPQuote(J.AsString['TerminoPromocao']));

      if P.EstadoCampo('TerminoPromocao') = sdpcNulo then
        SDPPar(Result, 'TerminoPromocao', 'null');
    finally
      J.Free;
    end;
  end;
  Result := '{' + Result + '}';
end;

function TACBrShoppingPrecos.EnviarLote(Modo: TSDPModoEnvioLote): Boolean;
var
  I: Integer;
  JSON, Rota, Corpo, Tipo: string;
  J: TACBrJSONObject;
begin
  FRetorno.Limpar;

  if (Modo <> sdpmProduto) and (Produtos.Count > LimiteLote) then
    raise EACBrShoppingPrecos.Create('Limite de ' + IntToStr(LimiteLote) + ' produtos por requisicao');

  JSON := '[';

  if Produtos.Count = 0 then
  begin
    JSON := JSON + JSONProduto(Produto, Modo)
  end
  else
  begin
    for I := 0 to Produtos.Count - 1 do
    begin
      if I > 0 then
        JSON := JSON + ',';
      JSON := JSON + JSONProduto(Produtos[I], Modo);
    end;
  end;

  JSON := JSON + ']';
  Tipo := TipoFormulario;
  Rota := 'produtos';

  if Modo = sdpmProduto then
    Corpo := 'produtos=' + SDPEncode(JSON)
  else
  begin
    if Modo = sdpmEstoque then
      Rota := 'atualizaEstoqueProduto'
    else
      Rota := 'atualizaPrecoProduto';

    { Conforme corpo e cURL da documentacao: JSON dentro de multipart. }
    Tipo := 'multipart/form-data; boundary=' + BoundaryMultipart;

    if Pos(BoundaryMultipart, JSON) > 0 then
      raise EACBrShoppingPrecos.Create('Conteudo contem delimitador multipart reservado');

    Corpo := '--' + BoundaryMultipart + #13#10 +
             'Content-Disposition: form-data; name="produtos"' + #13#10 +
             'Content-Type: application/json; charset=utf-8' + #13#10#13#10 + JSON + #13#10 +
             '--' + BoundaryMultipart + '--' + #13#10;
  end;
  J := RequisitarJSON('POST', URLV1 + Rota, Tipo, NativeStringToUTF8(Corpo));
  Result := J <> nil;
  J.Free;
end;

function TACBrShoppingPrecos.EnviarProdutos: Boolean;
begin
  Result := EnviarLote(sdpmProduto);
end;

function TACBrShoppingPrecos.AtualizarEstoque: Boolean;
begin
  Result := EnviarLote(sdpmEstoque);
end;

function TACBrShoppingPrecos.AtualizarPreco: Boolean;
begin
  Result := EnviarLote(sdpmPreco);
end;

function TACBrShoppingPrecos.ListarCategorias: Boolean;
var
  J: TACBrJSONObject;
  Corpo: string;
begin
  FRetorno.Limpar;
  Categorias.Clear;
  ValidarPlataforma;

  if Configuracoes.IntegracaoID = '' then
    raise EACBrShoppingPrecos.Create('Informe Configuracoes.IntegracaoID');

  Corpo := 'IntegracaoID=' + SDPEncode(Configuracoes.IntegracaoID) + '&PlataformaID=' + IntToStr(Configuracoes.Plataforma);
  J := RequisitarJSON('POST', URLV1 + 'categorias', TipoFormulario, NativeStringToUTF8(Corpo));
  Result := J <> nil;

  if not Result then
    Exit;

  try
    try
      Categorias.LerJSON(Registros(J));
    except
      on E: Exception do
      begin
        Categorias.Clear;
        Result := Falhar(E.Message);
      end;
    end;
  finally
    J.Free;
  end;
end;

function TACBrShoppingPrecos.BuscarFilaPedidos: Boolean;
var
  J: TACBrJSONObject;
begin
  FRetorno.Limpar;
  FilaPedidos.Clear;
  J := RequisitarJSON('GET', URLV2 + 'pedidos/BuscaFila', TipoJSON, '');
  Result := J <> nil;

  if not Result then
    Exit;

  try
    try
      FilaPedidos.LerJSON(Registros(J));
    except
      on E: Exception do
      begin
        FilaPedidos.Clear;
        Result := Falhar(E.Message);
      end;
    end;
  finally
    J.Free;
  end;
end;

function TACBrShoppingPrecos.ListarPedidos: Boolean;
var
  J: TACBrJSONObject;
  Query: string;
begin
  FRetorno.Limpar;
  Pedidos.Clear;

  if (FiltroPedidos.DataInicial <= 0) or
     (FiltroPedidos.DataFinal < FiltroPedidos.DataInicial) or
     (FiltroPedidos.DataFinal - FiltroPedidos.DataInicial > 3) then
    raise EACBrShoppingPrecos.Create('Informe um intervalo de atualizacao de ate 3 dias');

  if Configuracoes.IntegracaoID = '' then
    raise EACBrShoppingPrecos.Create('Informe Configuracoes.IntegracaoID');

  Query := '';
  FormCampo(Query, 'dataIni', FormatDateTimeBr(FiltroPedidos.DataInicial, 'yyyy-mm-dd hh:nn:ss'));
  FormCampo(Query, 'dataFim', FormatDateTimeBr(FiltroPedidos.DataFinal, 'yyyy-mm-dd hh:nn:ss'));
  FormCampo(Query, 'integracao', Configuracoes.IntegracaoID);

  if FiltroPedidos.Status <> '' then
    FormCampo(Query, 'status', FiltroPedidos.Status);

  J := RequisitarJSON('GET', URLV2 + 'pedidos/lista?' + Query, TipoJSON, '');
  Result := J <> nil;

  if not Result then
    Exit;

  try
    try
      Pedidos.LerJSON(Registros(J));
    except
      on E: Exception do
      begin
        Pedidos.Clear; Result := Falhar(E.Message);
      end;
    end;
  finally
    J.Free;
  end;
end;

function TACBrShoppingPrecos.ConsultarPedido: Boolean;
var
  J: TACBrJSONObject;
  A: TACBrJSONArray;
  URL: string;
begin
  FRetorno.Limpar;
  URL := CaminhoPedido + '/dados';
  Pedido.Limpar;
  J := RequisitarJSON('GET', URL, TipoJSON, '');
  Result := J <> nil;

  if not Result then
    Exit;

  try
    try
      A := Registros(J);

      if A.Count <> 1 then
        raise EACBrShoppingPrecos.Create('Consulta deve retornar exatamente um pedido');

      Pedido.LerJSON(A.ItemAsJSONObject[0]);
    except
      on E: Exception do
      begin
        Pedido.Limpar;
        Result := Falhar(E.Message);
      end;
    end;
  finally
    J.Free;
  end;
end;

function TACBrShoppingPrecos.AtualizarStatus: Boolean;
var
  J: TACBrJSONObject;
  Corpo, URL: string;
  procedure Campo(const Nome, Valor: string);
  begin
    case AtualizacaoStatus.EstadoCampo(Nome) of
      sdpcValor: FormCampo(Corpo, Nome, Valor);
      sdpcNulo : FormCampo(Corpo, Nome, '');
    end;
  end;
begin
  FRetorno.Limpar;
  URL := CaminhoPedido;

  if Trim(AtualizacaoStatus.Status) = '' then
    raise EACBrShoppingPrecos.Create('Informe AtualizacaoStatus.Status');

  Corpo := '';
  Campo('status', AtualizacaoStatus.Status);
  Campo('rastreio', AtualizacaoStatus.Rastreio);
  Campo('serie', AtualizacaoStatus.Serie);
  Campo('nf', AtualizacaoStatus.NF);
  Campo('especie', AtualizacaoStatus.Especie);
  Campo('data', AtualizacaoStatus.Data);
  Campo('chaveNFE', AtualizacaoStatus.ChaveNFe);
  Campo('produtoCFOP', AtualizacaoStatus.ProdutoCFOP);
  Campo('ie', AtualizacaoStatus.IE);
  { Recebe o XML original; o componente aplica base64 uma unica vez. Com
    CarregarXMLNFe os bytes do arquivo seguem sem conversao (Delphi 7). }
  if AtualizacaoStatus.XMLNFeBytes <> '' then
    Campo('xmlNFE', string(EncodeBase64(AtualizacaoStatus.XMLNFeBytes)))
  else
    Campo('xmlNFE', string(EncodeBase64(NativeStringToUTF8(AtualizacaoStatus.XMLNFe))));
  Campo('transportadora', AtualizacaoStatus.Transportadora);
  Campo('formaEnvio', AtualizacaoStatus.FormaEnvio);
  Campo('rastreioURL', AtualizacaoStatus.RastreioURL);
  J := RequisitarJSON('POST', URL, TipoFormulario, NativeStringToUTF8(Corpo));
  Result := J <> nil;
  J.Free;
end;

function TACBrShoppingPrecos.ObterEtiquetas: Boolean;
var
  J: TACBrJSONObject;
  Resposta: AnsiString;
  Query, IDs, Formato, ID: string;
  I: Integer;
  E: TSDPEtiqueta;
begin
  FRetorno.Limpar;
  Etiquetas.Clear;
  ArquivoEtiqueta.Clear;
  ValidarPlataforma;
  IDs := '';
  for I := 0 to PedidosEtiquetas.Count - 1 do
  begin
    ID := Trim(PedidosEtiquetas[I]);

    if (ID = '') or (Pos(',', ID) > 0) then
      raise EACBrShoppingPrecos.Create('Informe um ID por item em PedidosEtiquetas');

    if IDs <> '' then
      IDs := IDs + ',';
    IDs := IDs + ID;
  end;

  if IDs = '' then
    IDs := Pedido.PedidoID;

  if Trim(IDs) = '' then
    raise EACBrShoppingPrecos.Create('Informe o pedido para obter a etiqueta');

  if Configuracoes.CadastroPlataformas.UsaEtiquetaMercadoLivre(Configuracoes.Plataforma) then
  begin
    if Pos(',', IDs) > 0 then
      raise EACBrShoppingPrecos.Create('Mercado Livre: consulte um pedido por chamada');

    if FormatoEtiqueta = sdpfPDF then
      Formato := 'pdf'
    else
      Formato := 'zpl2';

    Result := Requisitar('GET', URLV2 + 'ml/pedidos/' + SDPEncode(IDs) + '/etiquetas/' + Formato, '', '', Resposta);

    if not Result then
      Exit;

    if ((FormatoEtiqueta = sdpfPDF) and (Copy(Resposta, 1, 5) <> '%PDF-')) or
       ((FormatoEtiqueta = sdpfZPL) and (Copy(Resposta, 1, 4) <> 'PK' + #3#4)) then
    begin
      FRetorno.FJSON := UTF8ToNativeString(Resposta);
      Result := Falhar('A API nao retornou o arquivo PDF/ZIP esperado. Consulte Retorno.JSON');
      Exit;
    end;

    ArquivoEtiqueta.WriteBuffer(Resposta[1], Length(Resposta));
    ArquivoEtiqueta.Position := 0;
    E := Etiquetas.Add;
    E.PedidoID := IDs;
    E.PlataformaID := Configuracoes.Plataforma;
    E.Sucesso := True;

    if FormatoEtiqueta = sdpfPDF then
      E.Tipo := 'pdf'
    else
      E.Tipo := 'zip';
    FRetorno.FSucesso := True;
  end
  else
  begin
    if FormatoEtiqueta = sdpfPDF then
      Formato := 'PDF'
    else
      Formato := 'ZPL';

    Query := '';
    FormCampo(Query, 'IntegracaoID', IntegracaoPedido);
    FormCampo(Query, 'PlataformaID', IntToStr(Configuracoes.Plataforma));
    FormCampo(Query, 'Pedidos', IDs);
    FormCampo(Query, 'Formato', Formato);
    J := RequisitarJSON('POST', URLV1 + 'etiquetas?' + Query, TipoFormulario, '');
    Result := J <> nil;

    if not Result then
      Exit;

    try
      try
        Etiquetas.LerJSON(Registros(J));

        if Etiquetas.Count = 0 then
          Result := Falhar('Nenhuma etiqueta retornada');
        for I := 0 to Etiquetas.Count - 1 do
          if not Etiquetas[I].Sucesso then
            Result := Falhar('Uma ou mais etiquetas falharam; consulte Etiquetas');
      except
        on Ex: Exception do
        begin
          Etiquetas.Clear;
          Result := Falhar(Ex.Message);
        end;
      end;
    finally
      J.Free;
    end;
  end;
end;

function TACBrShoppingPrecos.ConfirmarImportacaoPedidos: Boolean;
var
  I, N: Integer;
  Corpo, ID: string;
  J, Item: TACBrJSONObject;
  A: TACBrJSONArray;
  Recebidos: TStringList;
begin
  FRetorno.Limpar;

  if FilaIDsImportados.Count = 0 then
    raise EACBrShoppingPrecos.Create('Informe FilaIDsImportados apos persistir os pedidos');

  Corpo := '[';
  for I := 0 to FilaIDsImportados.Count - 1 do
  begin
    if Trim(FilaIDsImportados[I]) = '' then
      raise EACBrShoppingPrecos.Create('ID de fila vazio');

    for N := 0 to I-1 do
      if FilaIDsImportados[N] = FilaIDsImportados[I] then
        raise EACBrShoppingPrecos.Create('ID de fila duplicado');

    if I > 0 then
      Corpo := Corpo + ',';
    Corpo := Corpo + '{"id":' + SDPQuote(FilaIDsImportados[I]) + '}';
  end;

  Corpo := Corpo + ']';
  J := RequisitarJSON('POST', URLV2 + 'pedidos/LimpaFila', TipoJSON, NativeStringToUTF8(Corpo));
  Result := J <> nil;

  if not Result then
    Exit;
  Recebidos := TStringList.Create;
  Recebidos.CaseSensitive := True;
  try
    try
      A := Registros(J);

      if A.Count <> FilaIDsImportados.Count then
        Result := Falhar('Confirmacao incompleta da fila');

      for I := 0 to A.Count - 1 do
      begin
        Item := A.ItemAsJSONObject[I];
        ID := Item.AsString['id'];
        N := 0;
        while (N < FilaIDsImportados.Count) and (FilaIDsImportados[N] <> ID) do
          Inc(N);

        if (N = FilaIDsImportados.Count) or (Recebidos.IndexOf(ID) >= 0) then
          Result := Falhar('API retornou ID de fila inesperado ou duplicado');
        Recebidos.Add(ID);

        if not Item.AsBoolean['status'] then
          Result := Falhar('Falha ao confirmar item da fila; consulte Retorno.JSON');
      end;

    except
      on E: Exception do
      Result := Falhar(E.Message);
    end;
  finally
    Recebidos.Free;
    J.Free;
  end;
end;

function TACBrShoppingPrecos.CaminhoProdutosIntegracao: string;
begin
  if Trim(Configuracoes.IntegracaoID) = '' then
    raise EACBrShoppingPrecos.Create('Informe Configuracoes.IntegracaoID');

  Result := URLV2 + 'produtos/' + SDPEncode(Configuracoes.IntegracaoID);
end;

function TACBrShoppingPrecos.FormularioPlataforma: string;
begin
  ValidarPlataforma;

  if Trim(Configuracoes.IntegracaoID) = '' then
    raise EACBrShoppingPrecos.Create('Informe Configuracoes.IntegracaoID');

  Result := '';
  FormCampo(Result, 'IntegracaoID', Configuracoes.IntegracaoID);
  FormCampo(Result, 'PlataformaID', IntToStr(Configuracoes.Plataforma));
end;

function TACBrShoppingPrecos.ConsultarListaAPI(const Metodo, URL,
  ContentType, Corpo: string; Lista: TSDPListaAPI): Boolean;
var
  J: TACBrJSONObject;
begin
  Lista.Clear;
  J := RequisitarJSON(Metodo, URL, ContentType, NativeStringToUTF8(Corpo));
  Result := J <> nil;

  if not Result then
    Exit;

  try
    try
      Lista.LerJSON(Registros(J));
    except
      on E: Exception do
      begin
        Lista.Clear;
        Result := Falhar(E.Message);
      end;
    end;
  finally
    J.Free;
  end;
end;

function TACBrShoppingPrecos.EnviarComandoAPI(const URL, ContentType,
  Corpo: string): Boolean;
var
  J: TACBrJSONObject;
begin
  J := RequisitarJSON('POST', URL, ContentType, NativeStringToUTF8(Corpo));
  Result := J <> nil;
  J.Free;
end;

function TACBrShoppingPrecos.ListarPlataformas: Boolean;
begin
  Result := ConsultarListaAPI('GET', URLV2 + 'plataformas', TipoJSON, '', Plataformas);
end;

function TACBrShoppingPrecos.ListarIntegracoes: Boolean;
begin
  Result := ConsultarListaAPI('GET', URLV2 + 'integracoes', TipoJSON, '', Integracoes);
end;

function TACBrShoppingPrecos.ConsultarEstoquesIntegracao: Boolean;
begin
  FRetorno.Limpar;
  EstoquesIntegracao.Clear;
  Result := ConsultarListaAPI('GET', CaminhoProdutosIntegracao + '/estoque',
    TipoJSON, '', EstoquesIntegracao);
end;

function TACBrShoppingPrecos.ConsultarPrecosIntegracao: Boolean;
begin
  FRetorno.Limpar;
  PrecosIntegracao.Clear;
  Result := ConsultarListaAPI('GET', CaminhoProdutosIntegracao + '/precos',
    TipoJSON, '', PrecosIntegracao);
end;

function TACBrShoppingPrecos.ListarMarcas: Boolean;
var
  Corpo: string;
begin
  FRetorno.Limpar;
  Marcas.Clear;
  Corpo := FormularioPlataforma;
  Result := ConsultarListaAPI('POST', URLV1 + 'marcas', TipoFormulario, Corpo, Marcas);
end;

function TACBrShoppingPrecos.ListarAtributos: Boolean;
var
  Corpo: string;
begin
  FRetorno.Limpar;
  AtributosPlataforma.Clear;
  Corpo := FormularioPlataforma;

  if Trim(CategoriaID) = '' then
    raise EACBrShoppingPrecos.Create('Informe CategoriaID para consultar atributos');

  FormCampo(Corpo, 'CategoriaID', CategoriaID);
  Result := ConsultarListaAPI('POST', URLV1 + 'atributos', TipoFormulario,
    Corpo, AtributosPlataforma);
end;

function TACBrShoppingPrecos.EnviarProdutoPlataforma: Boolean;
var
  Corpo: string;
  J: TACBrJSONObject;
  I: Integer;
  V: TSDPVariacaoEnvio;
  procedure Campo(const Nome, Valor: string);
  begin
    if ProdutoPlataforma.EstadoCampo(Nome) = sdpcValor then
      FormCampo(Corpo, Nome, Valor);
  end;
begin
  FRetorno.Limpar;
  Corpo := FormularioPlataforma;

  if (Trim(ProdutoPlataforma.ProdutoID) = '') or
     (Trim(ProdutoPlataforma.SKU) = '') then
    raise EACBrShoppingPrecos.Create('Informe ProdutoPlataforma.ProdutoID e SKU');

  if (ProdutoPlataforma.EstadoCampo('Preco') <> sdpcValor) or
     (ProdutoPlataforma.EstadoCampo('Estoque') <> sdpcValor) then
    raise EACBrShoppingPrecos.Create('Informe Preco e Estoque do anuncio');

  if (ProdutoPlataforma.Preco < 0) or (ProdutoPlataforma.Estoque < 0) then
    raise EACBrShoppingPrecos.Create('Preco e Estoque nao podem ser negativos');

  for I := 0 to ProdutoPlataforma.Variacoes.Count - 1 do
  begin
    V := ProdutoPlataforma.Variacoes[I];

    if (Trim(V.ProdutoID) = '') or (Trim(V.SKU) = '') then
      raise EACBrShoppingPrecos.Create('Informe ProdutoID e SKU de cada variacao');
  end;

  Campo('ProdutoID', ProdutoPlataforma.ProdutoID);
  Campo('SKU', ProdutoPlataforma.SKU);
  Campo('Preco', SDPNumero(ProdutoPlataforma.Preco));
  Campo('Estoque', IntToStr(ProdutoPlataforma.Estoque));
  Campo('MarcaID', ProdutoPlataforma.MarcaID);
  Campo('CategoriaID', ProdutoPlataforma.CategoriaID);
  Campo('DepartamentoID', ProdutoPlataforma.DepartamentoID);
  FormCampo(Corpo, 'Categorias', ProdutoPlataforma.Categorias.GerarJSON);
  FormCampo(Corpo, 'Atributos', ProdutoPlataforma.Atributos.GerarJSON);
  FormCampo(Corpo, 'Variacoes', ProdutoPlataforma.Variacoes.GerarJSON);
  J := RequisitarJSON('POST', URLV1 + 'enviaProdutoPlataforma', TipoFormulario, NativeStringToUTF8(Corpo));
  Result := J <> nil;
  J.Free;
end;

function TACBrShoppingPrecos.ValidarResultadosAnuncios(Enviados: TSDPListaAPI): Boolean;
var
  I, K, N: Integer;
  J: TACBrJSONObject;
  IDs, Recebidos: TStringList;
  Chave: string;
begin
  Result := True;
  IDs := TStringList.Create;
  Recebidos := TStringList.Create;
  IDs.CaseSensitive := True;
  Recebidos.CaseSensitive := True;
  try
    for I := 0 to Enviados.Count - 1 do
    begin
      J := TACBrJSONObject.Parse(TSDPModelo(Enviados.Items[I]).GerarJSON);
      try
        Chave := SDPQuote(J.AsString['ProdutoID']) + ':' + SDPQuote(J.AsString['SKU']);
        IDs.Add(Chave);
      finally
        J.Free;
      end;
    end;

    if ResultadosAnuncios.Count <> Enviados.Count then
      Result := Falhar('Resposta incompleta; consulte ResultadosAnuncios');

    for I := 0 to ResultadosAnuncios.Count - 1 do
    begin
      Chave := SDPQuote(ResultadosAnuncios[I].ProdutoID) + ':' + SDPQuote(ResultadosAnuncios[I].SKU);
      K := IDs.IndexOf(Chave);
      N := Recebidos.IndexOf(Chave);

      if (K < 0) or (N >= 0) then
        Result := Falhar('Resposta com anuncio inesperado ou duplicado');

      Recebidos.Add(Chave);

      if not ResultadosAnuncios[I].Sucesso then
        Result := Falhar('Um ou mais anuncios falharam; consulte ResultadosAnuncios');
    end;
  finally
    Recebidos.Free;
    IDs.Free;
  end;
end;

function TACBrShoppingPrecos.AtualizarEstoqueIntegracao: Boolean;
var
  I, K: Integer;
  URL: string;
  P: TSDPEstoqueAnuncio;
begin
  FRetorno.Limpar;
  ResultadosAnuncios.Clear;
  URL := CaminhoProdutosIntegracao + '/estoque';

  if EstoquesAnuncios.Count = 0 then
    raise EACBrShoppingPrecos.Create('Preencha EstoquesAnuncios');

  for I := 0 to EstoquesAnuncios.Count - 1 do
  begin
    P := EstoquesAnuncios[I];

    if (Trim(P.ProdutoID) = '') or (Trim(P.SKU) = '') or
       (P.EstadoCampo('Estoque') <> sdpcValor) or (P.Estoque < 0) then
      raise EACBrShoppingPrecos.Create('Informe ProdutoID, SKU e Estoque nao negativo');

    for K := 0 to I - 1 do
    begin
      if (EstoquesAnuncios[K].ProdutoID = P.ProdutoID) and (EstoquesAnuncios[K].SKU = P.SKU) then
        raise EACBrShoppingPrecos.Create('Anuncio duplicado no lote');
    end;

    for K := 0 to P.Docas.Count - 1 do
    begin
      if (Trim(P.Docas[K].ID) = '') or (Trim(P.Docas[K].Estoque) = '') then
        raise EACBrShoppingPrecos.Create('Informe ID e Estoque de cada deposito');
    end;
  end;

  Result := ConsultarListaAPI('POST', URL, TipoJSON,
    '{"produtos":' + EstoquesAnuncios.GerarJSON + '}', ResultadosAnuncios);

  if Result then
    Result := ValidarResultadosAnuncios(EstoquesAnuncios);
end;

function TACBrShoppingPrecos.AtualizarPrecosIntegracao: Boolean;
var
  I, K: Integer;
  URL: string;
  P: TSDPPrecoAnuncio;
begin
  FRetorno.Limpar;
  ResultadosAnuncios.Clear;
  URL := CaminhoProdutosIntegracao + '/precos';

  if PrecosAnuncios.Count = 0 then
    raise EACBrShoppingPrecos.Create('Preencha PrecosAnuncios');

  for I := 0 to PrecosAnuncios.Count - 1 do
  begin
    P := PrecosAnuncios[I];

    if (Trim(P.ProdutoID) = '') or (Trim(P.SKU) = '') or
       (P.EstadoCampo('Preco') <> sdpcValor) or (P.Preco < 0) then
      raise EACBrShoppingPrecos.Create('Informe ProdutoID, SKU e Preco nao negativo');

    if (P.EstadoCampo('PrecoPromocao') = sdpcValor) and (P.PrecoPromocao < 0) then
      raise EACBrShoppingPrecos.Create('PrecoPromocao nao pode ser negativo');

    for K := 0 to I - 1 do
    begin
      if (PrecosAnuncios[K].ProdutoID = P.ProdutoID) and (PrecosAnuncios[K].SKU = P.SKU) then
        raise EACBrShoppingPrecos.Create('Anuncio duplicado no lote');
    end;
  end;

  Result := ConsultarListaAPI('POST', URL, TipoJSON,
    '{"produtos":' + PrecosAnuncios.GerarJSON + '}', ResultadosAnuncios);

  if Result then
    Result := ValidarResultadosAnuncios(PrecosAnuncios);
end;

function TACBrShoppingPrecos.ListarSituacoesPersonalizadas: Boolean;
begin
  Result := ConsultarListaAPI('GET', URLV2 + 'pedidos/situacoes-personalizadas',
    TipoJSON, '', SituacoesPersonalizadas);
end;

function TACBrShoppingPrecos.AtualizarSituacaoPersonalizada: Boolean;
var
  URL: string;
begin
  FRetorno.Limpar;
  URL := CaminhoPedido + '/situacao-personalizada';

  if Pedido.EstadoCampo('situacao_personalizada_id') <> sdpcValor then
    raise EACBrShoppingPrecos.Create('Informe Pedido.SituacaoPersonalizadaID');

  Result := EnviarComandoAPI(URL, TipoJSON,
    '{"situacao":' + IntToStr(Pedido.SituacaoPersonalizadaID) + '}');
end;

function TACBrShoppingPrecos.AceitarPedidoCompra: Boolean;
var
  I, K: Integer;
  URL: string;
begin
  FRetorno.Limpar;
  URL := CaminhoPedido + '/aceitePedidoCompra';

  if ItensAceite.Count = 0 then
    raise EACBrShoppingPrecos.Create('Informe ItensAceite');

  for I := 0 to ItensAceite.Count - 1 do
  begin
    if (Trim(ItensAceite[I].SKU) = '') or
       (ItensAceite[I].EstadoCampo('quantidade_aceita') <> sdpcValor) or
       (ItensAceite[I].QuantidadeAceita < 0) then
      raise EACBrShoppingPrecos.Create('Informe SKU e QuantidadeAceita; zero recusa o item');

    for K := 0 to I - 1 do
    begin
      if ItensAceite[I].SKU = ItensAceite[K].SKU then
        raise EACBrShoppingPrecos.Create('SKU duplicado em ItensAceite');
    end;
  end;

  Result := EnviarComandoAPI(URL, TipoJSON, ItensAceite.GerarJSON);
end;

function TACBrShoppingPrecos.RecuperarXMLPedidos: Boolean;
var
  Corpo, IDs, ID: string;
  I, K, Esperados: Integer;
  Encontrado: Boolean;
begin
  FRetorno.Limpar;
  NotasPedidos.Clear;
  ValidarPlataforma;
  Corpo := '';
  FormCampo(Corpo, 'IntegracaoID', IntegracaoPedido);
  FormCampo(Corpo, 'PlataformaID', IntToStr(Configuracoes.Plataforma));
  IDs := '';
  for I := 0 to PedidosXML.Count - 1 do
  begin
    ID := Trim(PedidosXML[I]);

    if (ID = '') or (Pos(',', ID) > 0) then
      raise EACBrShoppingPrecos.Create('Informe um ID por item em PedidosXML');

    if IDs <> '' then
      IDs := IDs + ',';

    IDs := IDs + ID;
  end;

  if IDs = '' then
    IDs := Pedido.PedidoID;

  if Trim(IDs) = '' then
    raise EACBrShoppingPrecos.Create('Informe Pedido.PedidoID ou PedidosXML');

  FormCampo(Corpo, 'Pedidos', IDs);
  Result := ConsultarListaAPI('POST', URLV1 + 'baixarXmlNF', TipoFormulario, Corpo, NotasPedidos);

  if not Result then
    Exit;

  Esperados := PedidosXML.Count;

  if Esperados = 0 then
    Esperados := 1;

  if NotasPedidos.Count <> Esperados then
    Result := Falhar('Resposta incompleta dos XMLs; consulte NotasPedidos');

  for I := 0 to NotasPedidos.Count - 1 do
  begin
    Encontrado := (PedidosXML.Count = 0) and (NotasPedidos[I].PedidoID = Pedido.PedidoID);
    for K := 0 to PedidosXML.Count - 1 do
    begin
      if NotasPedidos[I].PedidoID = Trim(PedidosXML[K]) then
        Encontrado := True;
    end;

    for K := 0 to I - 1 do
    begin
      if NotasPedidos[K].PedidoID = NotasPedidos[I].PedidoID then
        Encontrado := False;
    end;

    if not Encontrado then
      Result := Falhar('Resposta com pedido inesperado ou duplicado nos XMLs');

    if not NotasPedidos[I].Sucesso then
      Result := Falhar('Falha ao recuperar um ou mais XMLs; consulte NotasPedidos');
  end;
end;

function TACBrShoppingPrecos.SolicitarXMLNotas: Boolean;
var
  Corpo: string;
  J: TACBrJSONObject;
  ID: Int64;
begin
  FRetorno.Limpar;
  RelatorioXML.Limpar;
  ArquivoRelatorioXML.Clear;

  if (FiltroXML.DataInicial <= 0) or (FiltroXML.DataFinal < FiltroXML.DataInicial) then
    raise EACBrShoppingPrecos.Create('Informe o periodo em FiltroXML');

  ID := StrToInt64Def(Trim(Configuracoes.IntegracaoID), 0);

  if ID <= 0 then
    raise EACBrShoppingPrecos.Create('Informe IntegracaoID numerico positivo');

  Corpo := '{"integracaoId":' + IntToStr(ID) +
    ',"dataInicial":' + SDPQuote(FormatDateTimeBr(FiltroXML.DataInicial, 'yyyy-mm-dd')) +
    ',"dataFinal":' + SDPQuote(FormatDateTimeBr(FiltroXML.DataFinal, 'yyyy-mm-dd')) + '}';
  J := RequisitarJSON('POST', URLV2 + 'relatorios/exportar-xml', TipoJSON, NativeStringToUTF8(Corpo));
  Result := J <> nil;

  if not Result then
    Exit;

  try
    try
      if not J.ValueExists('relatorio_id') or SDPIsNull(J, 'relatorio_id') then
        raise EACBrShoppingPrecos.Create('Resposta sem relatorio_id');

      RelatorioXML.ID := J.AsString['relatorio_id'];

      if Trim(RelatorioXML.ID) = '' then
        raise EACBrShoppingPrecos.Create('Resposta com relatorio_id vazio');
    except
      on E: Exception do
      begin
        RelatorioXML.Limpar;
        Result := Falhar(E.Message);
      end;
    end;
  finally
    J.Free;
  end;
end;

function TACBrShoppingPrecos.ConsultarSolicitacaoXML: Boolean;
var
  J: TACBrJSONObject;
  ID: string;
begin
  FRetorno.Limpar;
  ID := RelatorioXML.ID;
  RelatorioXML.Limpar;
  RelatorioXML.ID := ID;
  ArquivoRelatorioXML.Clear;

  if Trim(ID) = '' then
    raise EACBrShoppingPrecos.Create('Informe RelatorioXML.ID');

  J := RequisitarJSON('GET', URLV2 + 'relatorios/exportar-xml/' + SDPEncode(ID) + '/status', TipoJSON, '');
  Result := J <> nil;

  if not Result then
    Exit;

  try
    try
      if not J.IsJSONObject('relatorio') then
        raise EACBrShoppingPrecos.Create('Resposta sem objeto relatorio');

      RelatorioXML.LerJSON(J.AsJSONObject['relatorio']);
      RelatorioXML.ID := ID;

      if RelatorioXML.EstadoCampo('status') <> sdpcValor then
        raise EACBrShoppingPrecos.Create('Relatorio sem status');
    except
      on E: Exception do
      begin
        RelatorioXML.Limpar;
        RelatorioXML.ID := ID;
        Result := Falhar(E.Message);
      end;
    end;
  finally
    J.Free;
  end;
end;

function TACBrShoppingPrecos.ExecutarDownload(const URL: string;
  out Codigo: Integer; out TipoResposta: string): AnsiString;
var
  HTTP: TACBrHTTP;
begin
  { Transporte independente: nao encaminha Basic, X-Client ou cookies da API,
    mas usa o mesmo proxy. }
  HTTP := TACBrHTTP.Create(nil);
  try
    HTTP.ContentsEncodingCompress := [];
    ConfigurarTransporte(HTTP);
    Codigo := 0;
    TipoResposta := '';
    Result := '';

    if not HTTP.HTTPSend.HTTPMethod('GET', URL) then
      raise EACBrShoppingPrecos.Create('Falha no download: ' + HTTP.HTTPSend.Sock.LastErrorDesc);

    Result := LerResposta(HTTP, Codigo, TipoResposta);
  finally
    HTTP.Free;
  end;
end;

function TACBrShoppingPrecos.BaixarArquivoPublico(const URL: string;
  Destino: TMemoryStream; Icone: Boolean): Boolean;
var
  Bytes: AnsiString;
  Host: string;
  P: Integer;
begin
  FRetorno.Limpar;
  Destino.Clear;

  if LowerCase(Copy(URL, 1, 8)) <> 'https://' then
    raise EACBrShoppingPrecos.Create('A URL do arquivo deve usar HTTPS');

  Host := Copy(URL, 9, MaxInt);
  P := Pos('/', Host);

  if P > 0 then
    Host := Copy(Host, 1, P - 1);

  if (Host = '') or (Pos('@', Host) > 0) or (Pos(#13, URL) > 0) or
     (Pos(#10, URL) > 0) then
    raise EACBrShoppingPrecos.Create('URL de arquivo invalida');

  try
    Bytes := ExecutarDownload(URL, FRetorno.FCodigoHTTP, FRetorno.FContentType);
    Result := (Retorno.CodigoHTTP >= 200) and (Retorno.CodigoHTTP <= 299);

    if not Result then
    begin
      Falhar('HTTP ' + IntToStr(Retorno.CodigoHTTP) + ' no download');
      Exit;
    end;

    if Length(Bytes) = 0 then
    begin
      Result := Falhar('Arquivo retornado vazio');
      Exit;
    end;

    if Icone and (Pos('image/', LowerCase(Retorno.ContentType)) <> 1) then
    begin
      Result := Falhar('O servidor nao retornou uma imagem');
      Exit;
    end;

    if (not Icone) and ((Pos('text/html', LowerCase(Retorno.ContentType)) = 1) or
       (Pos('application/json', LowerCase(Retorno.ContentType)) = 1)) then
    begin
      Result := Falhar('O servidor nao retornou o arquivo do relatorio');
      Exit;
    end;

    Destino.WriteBuffer(Bytes[1], Length(Bytes));
    Destino.Position := 0;
    FRetorno.FSucesso := True;
  except
    on E: Exception do
    begin
      Destino.Clear;
      Result := Falhar(E.Message);
    end;
  end;
end;

function TACBrShoppingPrecos.ObterIconePlataforma: Boolean;
var
  I: Integer;
begin
  FRetorno.Limpar;
  ArquivoIcone.Clear;
  I := IndicePlataformaAPI;

  if I < 0 then
  begin
    Result := Falhar('Consulte ListarPlataformas e selecione a plataforma desejada');
    Exit;
  end;

  if Trim(Plataformas[I].Icone) = '' then
  begin
    Result := Falhar('Plataforma sem URL de icone');
    Exit;
  end;

  Result := BaixarArquivoPublico(Plataformas[I].Icone, ArquivoIcone, True);
end;

function TACBrShoppingPrecos.BaixarRelatorioXML: Boolean;
begin
  Result := BaixarArquivoPublico(RelatorioXML.URLArquivo, ArquivoRelatorioXML, False);
end;

end.
