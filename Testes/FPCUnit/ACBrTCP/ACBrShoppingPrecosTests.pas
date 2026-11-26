{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
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

unit ACBrShoppingPrecosTests;

interface

uses
  Classes,
  SysUtils,
  ACBrTests.Util,
  ACBrShoppingPrecos;

type

  { Transporte falso: sobrescreve os pontos de extensao protegidos
    (ExecutarHTTP/ExecutarDownload). Nenhum teste acessa a rede. }

  TACBrShoppingPrecosFake = class(TACBrShoppingPrecos)
  private
    FCodigoResposta: Integer;
    FResposta: AnsiString;
    FTipoResposta: string;
    FFalharTransporte: Boolean;
    FChamadas: Integer;
    FUltimoMetodo: string;
    FUltimaURL: string;
    FUltimoContentType: string;
    FUltimoCorpo: AnsiString;
    FDownloadPermitido: Boolean;
    FDownloadCodigo: Integer;
    FDownloadResposta: AnsiString;
    FDownloadTipo: string;
    FDownloads: Integer;
  protected
    function ExecutarDownload(const URL: string; out Codigo: Integer;
      out TipoResposta: string): AnsiString; override;
    function ExecutarHTTP(const Metodo, URL, ContentType: string;
      const Corpo: AnsiString; out Codigo: Integer;
      out TipoResposta: string): AnsiString; override;
  public
    procedure Responder(ACodigo: Integer; const AResposta: AnsiString);
    procedure ResponderBinario(ACodigo: Integer; const AResposta: AnsiString;
      const ATipo: string);
    { Sem esta chamada, ExecutarDownload gera excecao (nenhum teste usa a rede). }
    procedure ResponderDownload(ACodigo: Integer; const AResposta: AnsiString;
      const ATipo: string);
    procedure ObterCabecalhos(AHeaders: TStrings);
    property Downloads: Integer read FDownloads;
    property FalharTransporte: Boolean read FFalharTransporte write FFalharTransporte;
    property Chamadas: Integer read FChamadas;
    property UltimoMetodo: string read FUltimoMetodo;
    property UltimaURL: string read FUltimaURL;
    property UltimoContentType: string read FUltimoContentType;
    property UltimoCorpo: AnsiString read FUltimoCorpo;
  end;

  TACBrShoppingPrecosTests = class(TTestCase)
  private
    FSDP: TACBrShoppingPrecosFake;
    FTimeSeparatorOriginal: Char;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure Componente_Criado_TimeOutEFormatoEtiquetaPadrao;
    procedure Requisitar_HTTP500CorpoHTML_RetornaFalsoComMensagemHTTP;
    procedure RequisitarJSON_HTTP400ComMessage_PreservaMensagemDaAPI;
    procedure RequisitarJSON_StatusFalse_RetornaFalsoComMessage;
    procedure RequisitarJSON_StatusFalseSemMessage_RetornaMensagemPadrao;
    procedure RequisitarJSON_SemCampoStatus_RetornaFalso;
    procedure RequisitarJSON_CorpoVazio_RetornaFalso;
    procedure ExecutarHTTP_TransporteFalha_RetornaFalsoComMensagem;
    procedure Requisitar_SemCredenciais_GeraExcecao;
    procedure Requisitar_UsuarioComDoisPontos_GeraExcecao;
    procedure ListarCategorias_RespostaValida_PreencheCategoriasEEnviaFormulario;
    procedure ListarCategorias_RespostaUTF8_DecodificaAcento;
    procedure ListarCategorias_SemRegistros_LimpaListaERetornaFalso;
    procedure ValidarPlataforma_PlataformaZero_GeraExcecao;
    procedure ValidarPlataforma_CodigoForaDaTabelaSemLista_Aceita;
    procedure ValidarPlataforma_CodigoAusenteDaListaCarregada_GeraExcecao;
    procedure ValidarPlataforma_CodigoPresenteNaListaCarregada_Aceita;
    procedure EnviarProdutos_SemSKU_GeraExcecao;
    procedure EnviarProdutos_TituloComAcento_CorpoPercentUTF8;
    procedure AtualizarEstoque_Lote1001_GeraExcecao;
    procedure AtualizarEstoque_SemEstoque_GeraExcecao;
    procedure AtualizarEstoque_ProdutoComEstoque_EnviaMultipartJSON;
    procedure AtualizarPreco_PrecoCustoNulo_EnviaNull;
    procedure ListarPedidos_IntervaloMaior3Dias_GeraExcecao;
    procedure ListarPedidos_TimeSeparatorPonto_QueryComDataCodificada;
    procedure ListarPedidos_StatusComCaracteresReservados_CodificaQuery;
    procedure ConsultarPedido_IDComBarraEEspaco_CodificaURL;
  end;

implementation

uses
  ACBrSocket,
  ACBrUtil.Strings,
  ACBrShoppingPrecosModelos,
  ACBrShoppingPrecosConfiguracoes;

const
  CRespostaVaziaOK = '{"status":true,"registros":[]}';
  CPlataformasAPI =
    '{"status":true,"registros":[{"id":1,"titulo":"Mercado Livre","ativo":true},' +
    '{"id":4,"titulo":"Amazon","ativo":true}]}';

{ TACBrShoppingPrecosFake }

procedure TACBrShoppingPrecosFake.Responder(ACodigo: Integer;
  const AResposta: AnsiString);
begin
  FCodigoResposta := ACodigo;
  FResposta := AResposta;
  FTipoResposta := 'application/json';
end;

procedure TACBrShoppingPrecosFake.ResponderBinario(ACodigo: Integer;
  const AResposta: AnsiString; const ATipo: string);
begin
  FCodigoResposta := ACodigo;
  FResposta := AResposta;
  FTipoResposta := ATipo;
end;

procedure TACBrShoppingPrecosFake.ResponderDownload(ACodigo: Integer;
  const AResposta: AnsiString; const ATipo: string);
begin
  FDownloadPermitido := True;
  FDownloadCodigo := ACodigo;
  FDownloadResposta := AResposta;
  FDownloadTipo := ATipo;
end;

procedure TACBrShoppingPrecosFake.ObterCabecalhos(AHeaders: TStrings);
begin
  MontarCabecalhos(AHeaders);
end;

function TACBrShoppingPrecosFake.ExecutarDownload(const URL: string;
  out Codigo: Integer; out TipoResposta: string): AnsiString;
begin
  Codigo := 0;
  TipoResposta := '';
  Result := '';

  if not FDownloadPermitido then
    raise EACBrShoppingPrecos.Create('Download nao permitido nos testes: ' + URL);

  Inc(FDownloads);
  FUltimaURL := URL;
  Codigo := FDownloadCodigo;
  TipoResposta := FDownloadTipo;
  Result := FDownloadResposta;
end;

function TACBrShoppingPrecosFake.ExecutarHTTP(const Metodo, URL,
  ContentType: string; const Corpo: AnsiString; out Codigo: Integer;
  out TipoResposta: string): AnsiString;
begin
  Inc(FChamadas);
  FUltimoMetodo := Metodo;
  FUltimaURL := URL;
  FUltimoContentType := ContentType;
  FUltimoCorpo := Corpo;
  Codigo := 0;
  TipoResposta := '';
  Result := '';

  if FFalharTransporte then
    raise EACBrShoppingPrecos.Create('Falha simulada de transporte');

  Codigo := FCodigoResposta;
  TipoResposta := FTipoResposta;
  Result := FResposta;
end;

{ TACBrShoppingPrecosTests }

procedure TACBrShoppingPrecosTests.SetUp;
begin
  inherited SetUp;
  {$IFDEF HAS_FORMATSETTINGS}
  FTimeSeparatorOriginal := FormatSettings.TimeSeparator;
  {$ELSE}
  FTimeSeparatorOriginal := TimeSeparator;
  {$ENDIF}
  FSDP := TACBrShoppingPrecosFake.Create(nil);
  { Credenciais ficticias }
  FSDP.Configuracoes.Usuario := 'usuario.teste';
  FSDP.Configuracoes.Senha := 'senha-ficticia';
  FSDP.Configuracoes.Token := 'token-ficticio';
  FSDP.Configuracoes.IntegracaoID := '123';
  FSDP.Configuracoes.Plataforma := 4;
  FSDP.Responder(200, CRespostaVaziaOK);
end;

procedure TACBrShoppingPrecosTests.TearDown;
begin
  FSDP.Free;
  {$IFDEF HAS_FORMATSETTINGS}
  FormatSettings.TimeSeparator := FTimeSeparatorOriginal;
  {$ELSE}
  TimeSeparator := FTimeSeparatorOriginal;
  {$ENDIF}
  inherited TearDown;
end;

procedure TACBrShoppingPrecosTests.Componente_Criado_TimeOutEFormatoEtiquetaPadrao;
begin
  CheckEquals(cHTTPTimeOutDef, FSDP.TimeOut);
  CheckTrue(FSDP.FormatoEtiqueta = sdpfPDF, 'FormatoEtiqueta padrao PDF');
end;

procedure TACBrShoppingPrecosTests.Requisitar_HTTP500CorpoHTML_RetornaFalsoComMensagemHTTP;
begin
  FSDP.Responder(500, '<html><body>Erro interno</body></html>');
  CheckFalse(FSDP.ListarPlataformas);
  CheckFalse(FSDP.Retorno.Sucesso);
  CheckEquals(500, FSDP.Retorno.CodigoHTTP);
  CheckEquals('HTTP 500', FSDP.Retorno.Mensagem);
  CheckEquals(0, FSDP.Plataformas.Count);
end;

procedure TACBrShoppingPrecosTests.RequisitarJSON_HTTP400ComMessage_PreservaMensagemDaAPI;
begin
  FSDP.Responder(400, '{"status":false,"message":"Token invalido"}');
  CheckFalse(FSDP.ListarPlataformas);
  CheckEquals(400, FSDP.Retorno.CodigoHTTP);
  CheckEquals('Token invalido', FSDP.Retorno.Mensagem);
end;

procedure TACBrShoppingPrecosTests.RequisitarJSON_StatusFalse_RetornaFalsoComMessage;
begin
  FSDP.Responder(200, '{"status":false,"message":"Integracao nao encontrada"}');
  CheckFalse(FSDP.ListarPlataformas);
  CheckFalse(FSDP.Retorno.Sucesso);
  CheckEquals('Integracao nao encontrada', FSDP.Retorno.Mensagem);
end;

procedure TACBrShoppingPrecosTests.RequisitarJSON_StatusFalseSemMessage_RetornaMensagemPadrao;
begin
  FSDP.Responder(200, '{"status":false}');
  CheckFalse(FSDP.ListarPlataformas);
  CheckEquals('API retornou status=false', FSDP.Retorno.Mensagem);
end;

procedure TACBrShoppingPrecosTests.RequisitarJSON_SemCampoStatus_RetornaFalso;
begin
  FSDP.Responder(200, '{"registros":[]}');
  CheckFalse(FSDP.ListarPlataformas);
  CheckFalse(FSDP.Retorno.Sucesso);
  CheckTrue(Pos('status', FSDP.Retorno.Mensagem) > 0, 'Mensagem: ' + FSDP.Retorno.Mensagem);
end;

procedure TACBrShoppingPrecosTests.RequisitarJSON_CorpoVazio_RetornaFalso;
begin
  FSDP.Responder(200, '');
  CheckFalse(FSDP.ListarPlataformas);
  CheckEquals('Resposta JSON vazia', FSDP.Retorno.Mensagem);
end;

procedure TACBrShoppingPrecosTests.ExecutarHTTP_TransporteFalha_RetornaFalsoComMensagem;
begin
  FSDP.FalharTransporte := True;
  CheckFalse(FSDP.ListarPlataformas);
  CheckFalse(FSDP.Retorno.Sucesso);
  CheckEquals('Falha simulada de transporte', FSDP.Retorno.Mensagem);
  CheckEquals(1, FSDP.Chamadas, 'sem retry');
end;

procedure TACBrShoppingPrecosTests.Requisitar_SemCredenciais_GeraExcecao;
var
  LGerouExcecao: Boolean;
begin
  FSDP.Configuracoes.Token := '';
  LGerouExcecao := False;
  try
    FSDP.ListarPlataformas;
  except
    on E: EACBrShoppingPrecos do
      LGerouExcecao := True;
  end;
  CheckTrue(LGerouExcecao, 'Sem Token deveria gerar EACBrShoppingPrecos');
  CheckEquals(0, FSDP.Chamadas, 'nao pode chamar a API sem credenciais');
end;

procedure TACBrShoppingPrecosTests.Requisitar_UsuarioComDoisPontos_GeraExcecao;
var
  LGerouExcecao: Boolean;
begin
  FSDP.Configuracoes.Usuario := 'usuario:teste';
  LGerouExcecao := False;
  try
    FSDP.ListarPlataformas;
  except
    on E: EACBrShoppingPrecos do
      LGerouExcecao := True;
  end;
  CheckTrue(LGerouExcecao, 'Usuario com ":" quebra o Basic Auth e deveria gerar excecao');
  CheckEquals(0, FSDP.Chamadas);
end;

procedure TACBrShoppingPrecosTests.ListarCategorias_RespostaValida_PreencheCategoriasEEnviaFormulario;
begin
  FSDP.Responder(200, '{"status":true,"registros":[{"id":"CAT-1","nome":"Categoria Ficticia","temFilhos":false}]}');
  CheckTrue(FSDP.ListarCategorias, FSDP.Retorno.Mensagem);
  CheckTrue(FSDP.Retorno.Sucesso);
  CheckEquals(1, FSDP.Categorias.Count);
  CheckEquals('CAT-1', FSDP.Categorias[0].ID);
  CheckEquals('Categoria Ficticia', FSDP.Categorias[0].Nome);
  CheckEquals('POST', FSDP.UltimoMetodo);
  CheckEquals('https://api.shoppingdeprecos.com.br/categorias', FSDP.UltimaURL);
  CheckEquals('application/x-www-form-urlencoded', FSDP.UltimoContentType);
  CheckEquals('IntegracaoID=123&PlataformaID=4', string(FSDP.UltimoCorpo));
end;

procedure TACBrShoppingPrecosTests.ListarCategorias_RespostaUTF8_DecodificaAcento;
var
  LResposta: AnsiString;
begin
  { Corpo da API em UTF-8: 'Calçados' = 'Cal' + C3 A7 + 'ados' }
  LResposta := AnsiString('{"status":true,"registros":[{"id":"CAT-2","nome":"Cal');
  LResposta := LResposta + AnsiChar($C3);
  LResposta := LResposta + AnsiChar($A7);
  LResposta := LResposta + AnsiString('ados"}]}');
  FSDP.Responder(200, LResposta);
  CheckTrue(FSDP.ListarCategorias, FSDP.Retorno.Mensagem);
  CheckEquals(1, FSDP.Categorias.Count);
  CheckEquals(ACBrStr('Cal' + #$E7 + 'ados'), FSDP.Categorias[0].Nome);
end;

procedure TACBrShoppingPrecosTests.ListarCategorias_SemRegistros_LimpaListaERetornaFalso;
begin
  FSDP.Responder(200, '{"status":true,"registros":[{"id":"CAT-1","nome":"A"}]}');
  CheckTrue(FSDP.ListarCategorias, FSDP.Retorno.Mensagem);
  CheckEquals(1, FSDP.Categorias.Count);

  FSDP.Responder(200, '{"status":true}');
  CheckFalse(FSDP.ListarCategorias);
  CheckEquals(0, FSDP.Categorias.Count, 'lista anterior deve ser limpa');
  CheckFalse(FSDP.Retorno.Sucesso);
  CheckTrue(Pos('registros', FSDP.Retorno.Mensagem) > 0, 'Mensagem: ' + FSDP.Retorno.Mensagem);
end;

procedure TACBrShoppingPrecosTests.ValidarPlataforma_PlataformaZero_GeraExcecao;
var
  LGerouExcecao: Boolean;
begin
  FSDP.Configuracoes.Plataforma := 0;
  LGerouExcecao := False;
  try
    FSDP.ListarCategorias;
  except
    on E: EACBrShoppingPrecos do
      LGerouExcecao := True;
  end;
  CheckTrue(LGerouExcecao, 'Plataforma 0 deveria gerar EACBrShoppingPrecos');
  CheckEquals(0, FSDP.Chamadas);
end;

procedure TACBrShoppingPrecosTests.ValidarPlataforma_CodigoForaDaTabelaSemLista_Aceita;
begin
  { 9999 nao consta na tabela estatica; sem ListarPlataformas, e aceito }
  FSDP.Configuracoes.Plataforma := 9999;
  CheckTrue(FSDP.ListarCategorias, FSDP.Retorno.Mensagem);
  CheckEquals(1, FSDP.Chamadas);
  CheckEquals('IntegracaoID=123&PlataformaID=9999', string(FSDP.UltimoCorpo));
end;

procedure TACBrShoppingPrecosTests.ValidarPlataforma_CodigoAusenteDaListaCarregada_GeraExcecao;
var
  LGerouExcecao: Boolean;
begin
  FSDP.Responder(200, CPlataformasAPI);
  CheckTrue(FSDP.ListarPlataformas, FSDP.Retorno.Mensagem);
  CheckEquals(2, FSDP.Plataformas.Count);

  FSDP.Configuracoes.Plataforma := 9999;
  FSDP.Responder(200, CRespostaVaziaOK);
  LGerouExcecao := False;
  try
    FSDP.ListarCategorias;
  except
    on E: EACBrShoppingPrecos do
      LGerouExcecao := True;
  end;
  CheckTrue(LGerouExcecao, 'Plataforma fora da lista carregada deveria gerar EACBrShoppingPrecos');
  CheckEquals(1, FSDP.Chamadas, 'somente a chamada de ListarPlataformas');
end;

procedure TACBrShoppingPrecosTests.ValidarPlataforma_CodigoPresenteNaListaCarregada_Aceita;
begin
  FSDP.Responder(200, CPlataformasAPI);
  CheckTrue(FSDP.ListarPlataformas, FSDP.Retorno.Mensagem);

  FSDP.Configuracoes.Plataforma := 4;
  FSDP.Responder(200, CRespostaVaziaOK);
  CheckTrue(FSDP.ListarCategorias, FSDP.Retorno.Mensagem);
  CheckEquals(2, FSDP.Chamadas);
end;

procedure TACBrShoppingPrecosTests.EnviarProdutos_SemSKU_GeraExcecao;
var
  LGerouExcecao: Boolean;
begin
  FSDP.Produto.Titulo := 'Produto Ficticio';
  LGerouExcecao := False;
  try
    FSDP.EnviarProdutos;
  except
    on E: EACBrShoppingPrecos do
      LGerouExcecao := True;
  end;
  CheckTrue(LGerouExcecao, 'Produto sem SKU deveria gerar EACBrShoppingPrecos');
  CheckEquals(0, FSDP.Chamadas);
end;

procedure TACBrShoppingPrecosTests.EnviarProdutos_TituloComAcento_CorpoPercentUTF8;
begin
  FSDP.Responder(200, '{"status":true,"protocolo":"PROT-1"}');
  FSDP.Produto.SKU := 'A1';
  FSDP.Produto.Titulo := ACBrStr('Cal' + #$E7 + 'a');
  CheckTrue(FSDP.EnviarProdutos, FSDP.Retorno.Mensagem);
  CheckEquals('PROT-1', FSDP.Retorno.Protocolo);
  CheckEquals('POST', FSDP.UltimoMetodo);
  CheckEquals('https://api.shoppingdeprecos.com.br/produtos', FSDP.UltimaURL);
  CheckEquals('application/x-www-form-urlencoded', FSDP.UltimoContentType);
  // JSON do produto com percent-encoding de UTF-8 (hexa maiusculo); "ç" = %C3%A7
  CheckEquals('produtos=%5B%7B%22SKU%22%3A%22A1%22,%22Titulo%22%3A%22Cal%C3%A7a%22%7D%5D',
    string(FSDP.UltimoCorpo));
end;

procedure TACBrShoppingPrecosTests.AtualizarEstoque_Lote1001_GeraExcecao;
var
  I: Integer;
  P: TSDPProduto;
  LGerouExcecao: Boolean;
begin
  for I := 1 to 1001 do
  begin
    P := FSDP.Produtos.Add;
    P.SKU := 'SKU-' + IntToStr(I);
    P.Estoque := 1;
  end;
  LGerouExcecao := False;
  try
    FSDP.AtualizarEstoque;
  except
    on E: EACBrShoppingPrecos do
      LGerouExcecao := True;
  end;
  CheckTrue(LGerouExcecao, 'Lote acima de 1000 deveria gerar EACBrShoppingPrecos');
  CheckEquals(0, FSDP.Chamadas);
end;

procedure TACBrShoppingPrecosTests.AtualizarEstoque_SemEstoque_GeraExcecao;
var
  LGerouExcecao: Boolean;
begin
  FSDP.Produto.SKU := 'A1';
  LGerouExcecao := False;
  try
    FSDP.AtualizarEstoque;
  except
    on E: EACBrShoppingPrecos do
      LGerouExcecao := True;
  end;
  CheckTrue(LGerouExcecao, 'Estoque ausente deveria gerar EACBrShoppingPrecos');
  CheckEquals(0, FSDP.Chamadas);
end;

procedure TACBrShoppingPrecosTests.AtualizarEstoque_ProdutoComEstoque_EnviaMultipartJSON;
begin
  FSDP.Responder(200, '{"status":true}');
  FSDP.Produto.SKU := 'A1';
  FSDP.Produto.Estoque := 5;
  CheckTrue(FSDP.AtualizarEstoque, FSDP.Retorno.Mensagem);
  CheckEquals('POST', FSDP.UltimoMetodo);
  CheckEquals('https://api.shoppingdeprecos.com.br/atualizaEstoqueProduto', FSDP.UltimaURL);
  CheckEquals('multipart/form-data; boundary=ACBrSDPBoundary7B79A5', FSDP.UltimoContentType);
  CheckEquals('--ACBrSDPBoundary7B79A5' + #13#10 +
    'Content-Disposition: form-data; name="produtos"' + #13#10 +
    'Content-Type: application/json; charset=utf-8' + #13#10#13#10 +
    '[{"SKU":"A1","Estoque":5}]' + #13#10 +
    '--ACBrSDPBoundary7B79A5--' + #13#10, string(FSDP.UltimoCorpo));
end;

procedure TACBrShoppingPrecosTests.AtualizarPreco_PrecoCustoNulo_EnviaNull;
begin
  FSDP.Responder(200, '{"status":true}');
  FSDP.Produto.SKU := 'A1';
  FSDP.Produto.Preco := 10.5;
  FSDP.Produto.DefinirNulo('PrecoCusto');
  CheckTrue(FSDP.AtualizarPreco, FSDP.Retorno.Mensagem);
  CheckEquals('https://api.shoppingdeprecos.com.br/atualizaPrecoProduto', FSDP.UltimaURL);
  CheckTrue(Pos('[{"SKU":"A1","Preco":10.5,"PrecoCusto":null}]', string(FSDP.UltimoCorpo)) > 0,
    'Corpo: ' + string(FSDP.UltimoCorpo));
end;

procedure TACBrShoppingPrecosTests.ListarPedidos_IntervaloMaior3Dias_GeraExcecao;
var
  LGerouExcecao: Boolean;
begin
  FSDP.FiltroPedidos.DataInicial := EncodeDate(2026, 1, 1);
  FSDP.FiltroPedidos.DataFinal := EncodeDate(2026, 1, 5);
  LGerouExcecao := False;
  try
    FSDP.ListarPedidos;
  except
    on E: EACBrShoppingPrecos do
      LGerouExcecao := True;
  end;
  CheckTrue(LGerouExcecao, 'Intervalo de 4 dias deveria gerar EACBrShoppingPrecos');
  CheckEquals(0, FSDP.Chamadas);
end;

procedure TACBrShoppingPrecosTests.ListarPedidos_TimeSeparatorPonto_QueryComDataCodificada;
begin
  {$IFDEF HAS_FORMATSETTINGS}
  FormatSettings.TimeSeparator := '.';
  {$ELSE}
  TimeSeparator := '.';
  {$ENDIF}
  FSDP.FiltroPedidos.DataInicial := EncodeDate(2026, 1, 2) + EncodeTime(3, 4, 5, 0);
  FSDP.FiltroPedidos.DataFinal := EncodeDate(2026, 1, 3) + EncodeTime(3, 4, 5, 0);
  CheckTrue(FSDP.ListarPedidos, FSDP.Retorno.Mensagem);
  CheckEquals('GET', FSDP.UltimoMetodo);
  CheckEquals('https://apiv2.shoppingdeprecos.com.br/pedidos/lista?' +
    'dataIni=2026-01-02%2003%3A04%3A05&dataFim=2026-01-03%2003%3A04%3A05&integracao=123',
    FSDP.UltimaURL);
end;

procedure TACBrShoppingPrecosTests.ListarPedidos_StatusComCaracteresReservados_CodificaQuery;
begin
  FSDP.FiltroPedidos.DataInicial := EncodeDate(2026, 1, 2);
  FSDP.FiltroPedidos.DataFinal := EncodeDate(2026, 1, 3);
  FSDP.FiltroPedidos.Status := 'a&b=c';
  CheckTrue(FSDP.ListarPedidos, FSDP.Retorno.Mensagem);
  CheckEquals('https://apiv2.shoppingdeprecos.com.br/pedidos/lista?' +
    'dataIni=2026-01-02%2000%3A00%3A00&dataFim=2026-01-03%2000%3A00%3A00&integracao=123' +
    '&status=a%26b%3Dc', FSDP.UltimaURL);
end;

procedure TACBrShoppingPrecosTests.ConsultarPedido_IDComBarraEEspaco_CodificaURL;
begin
  FSDP.Configuracoes.IntegracaoID := '99';
  FSDP.Pedido.PedidoID := 'AB/12 3';
  FSDP.Responder(200, '{"status":true,"registros":[{"pedido_id":"AB/12 3","status":"aprovado"}]}');
  CheckTrue(FSDP.ConsultarPedido, FSDP.Retorno.Mensagem);
  CheckEquals('GET', FSDP.UltimoMetodo);
  CheckEquals('https://apiv2.shoppingdeprecos.com.br/pedidos/AB%2F12%203/integracao/99/dados',
    FSDP.UltimaURL);
  CheckEquals('AB/12 3', FSDP.Pedido.PedidoID);
  CheckEquals('aprovado', FSDP.Pedido.Status);
end;

initialization
  _RegisterTest('ACBrTCP.ShoppingPrecos.Componente', TACBrShoppingPrecosTests);

end.
