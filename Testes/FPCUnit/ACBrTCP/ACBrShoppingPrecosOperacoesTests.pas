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

unit ACBrShoppingPrecosOperacoesTests;

interface

uses
  Classes,
  SysUtils,
  ACBrTests.Util,
  ACBrShoppingPrecosTests;

type

  { Operacoes do TACBrShoppingPrecos sobre o transporte falso
    (TACBrShoppingPrecosFake). Nenhum teste acessa a rede. }

  TACBrShoppingPrecosOperacoesTests = class(TTestCase)
  private
    FSDP: TACBrShoppingPrecosFake;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure MontarCabecalhos_UsuarioComAcento_AuthorizationBasicUTF8;
    procedure RequisitarJSON_StatusNulo_RetornaFalso;
    procedure RequisitarJSON_HTTP200CorpoNaoJSON_RetornaFalsoComMensagem;
    procedure ObterEtiquetas_MercadoLivrePDF_GravaArquivo;
    procedure ObterEtiquetas_MercadoLivreCorpoHTML_RetornaFalso;
    procedure ObterEtiquetas_MercadoLivreVariosIDs_GeraExcecao;
    procedure ObterEtiquetas_IDComVirgula_GeraExcecao;
    procedure ObterEtiquetas_RespostaComFalha_RetornaFalso;
    procedure ConfirmarImportacao_IDDuplicado_GeraExcecao;
    procedure ConfirmarImportacao_TodosConfirmados_EnviaIDs;
    procedure ConfirmarImportacao_RespostaIncompleta_RetornaFalso;
    procedure ConfirmarImportacao_IDInesperado_RetornaFalso;
    procedure AtualizarStatus_SemStatus_GeraExcecao;
    procedure AtualizarStatus_XMLTexto_EnviaBase64UmaVez;
    procedure AtualizarStatus_CarregarXMLNFe_EnviaBytesSemConversao;
    procedure AtualizarStatus_AtribuirXMLNFe_DescartaBytesCarregados;
    procedure AtualizarStatus_CampoNuloEAusente_EnviaVazioEOmite;
    procedure EnviarProdutos_KitSemItens_GeraExcecao;
    procedure EnviarProdutos_PercentuaisDoKitDiferentesDe100_GeraExcecao;
    procedure EnviarProdutos_VariacaoSemSKU_GeraExcecao;
    procedure EnviarProdutos_SemTitulo_GeraExcecao;
    procedure AtualizarEstoque_EstoqueNegativo_GeraExcecao;
    procedure AtualizarPreco_SemPreco_GeraExcecao;
    procedure ListarPedidos_IntervaloExato3Dias_Aceita;
    procedure ListarPedidos_DataFinalAnterior_GeraExcecao;
    procedure ListarPedidos_PedidoComDataZerada_LeLista;
    procedure ConsultarPedido_SemPedidoID_GeraExcecao;
    procedure ConsultarPedido_DoisRegistros_RetornaFalsoELimpaPedido;
    procedure AtualizarEstoqueIntegracao_ResultadoDuplicado_RetornaFalso;
    procedure AtualizarEstoqueIntegracao_ResultadoCompleto_RetornaVerdadeiro;
    procedure BaixarRelatorioXML_URLHttp_GeraExcecao;
    procedure BaixarRelatorioXML_UserInfoNoHost_GeraExcecao;
    procedure BaixarRelatorioXML_ContentTypeHTML_RetornaFalso;
    procedure BaixarRelatorioXML_ArquivoValido_GravaStream;
    procedure ObterIconePlataforma_ContentTypeHTML_RetornaFalso;
  end;

  { Modelos da API (ACBrShoppingPrecosModelosAPI) }

  TSDPModelosAPITests = class(TTestCase)
  published
    procedure ResultadoAnuncio_IdaEVolta_PreservaNuloEAusente;
    procedure PlataformaLista_LerJSON_PreencheItens;
    procedure RelatorioXML_LerJSON_PreencheStatusEURL;
  end;

implementation

uses
  ACBrJSON,
  ACBrUtil.Strings,
  ACBrShoppingPrecosModelos,
  ACBrShoppingPrecosModelosAPI;

const
  CRespostaVaziaOK = '{"status":true,"registros":[]}';
  CURLV1 = 'https://api.shoppingdeprecos.com.br/';
  CURLV2 = 'https://apiv2.shoppingdeprecos.com.br/';

{ TACBrShoppingPrecosOperacoesTests }

procedure TACBrShoppingPrecosOperacoesTests.SetUp;
begin
  inherited SetUp;
  FSDP := TACBrShoppingPrecosFake.Create(nil);
  { Credenciais ficticias }
  FSDP.Configuracoes.Usuario := 'usuario.teste';
  FSDP.Configuracoes.Senha := 'senha-ficticia';
  FSDP.Configuracoes.Token := 'token-ficticio';
  FSDP.Configuracoes.IntegracaoID := '123';
  FSDP.Configuracoes.Plataforma := 4;
  FSDP.Responder(200, CRespostaVaziaOK);
end;

procedure TACBrShoppingPrecosOperacoesTests.TearDown;
begin
  FSDP.Free;
  inherited TearDown;
end;

procedure TACBrShoppingPrecosOperacoesTests.MontarCabecalhos_UsuarioComAcento_AuthorizationBasicUTF8;
var
  LHeaders: TStringList;
begin
  FSDP.Configuracoes.Usuario := ACBrStr('Jos' + #$E9);
  FSDP.Configuracoes.Senha := 'x';
  LHeaders := TStringList.Create;
  try
    FSDP.ObterCabecalhos(LHeaders);
    CheckEquals(3, LHeaders.Count);
    { base64 de UTF-8 "José:x" }
    CheckEquals('Authorization: Basic Sm9zw6k6eA==', LHeaders[0]);
    CheckEquals('X-Client: token-ficticio', LHeaders[1]);
    CheckEquals('Accept: application/json, application/pdf, application/zip', LHeaders[2]);
  finally
    LHeaders.Free;
  end;
end;

procedure TACBrShoppingPrecosOperacoesTests.RequisitarJSON_StatusNulo_RetornaFalso;
begin
  FSDP.Responder(200, '{"status":null,"registros":[]}');
  CheckFalse(FSDP.ListarPlataformas);
  CheckFalse(FSDP.Retorno.Sucesso);
  { Conforme o backend JSON, null e tratado como ausente ou como nulo }
  CheckTrue(Pos('status', LowerCase(FSDP.Retorno.Mensagem)) > 0, 'Mensagem: ' + FSDP.Retorno.Mensagem);
end;

procedure TACBrShoppingPrecosOperacoesTests.RequisitarJSON_HTTP200CorpoNaoJSON_RetornaFalsoComMensagem;
begin
  FSDP.Responder(200, '<html>manutencao</html>');
  CheckFalse(FSDP.ListarPlataformas);
  CheckFalse(FSDP.Retorno.Sucesso);
  CheckTrue(Pos('Resposta JSON invalida', FSDP.Retorno.Mensagem) = 1, 'Mensagem: ' + FSDP.Retorno.Mensagem);
end;

procedure TACBrShoppingPrecosOperacoesTests.ObterEtiquetas_MercadoLivrePDF_GravaArquivo;
var
  LPDF: AnsiString;
begin
  LPDF := '%PDF-1.4 conteudo ficticio';
  FSDP.Configuracoes.Plataforma := 1;
  FSDP.Pedido.PedidoID := 'ML-1';
  FSDP.ResponderBinario(200, LPDF, 'application/pdf');
  CheckTrue(FSDP.ObterEtiquetas, FSDP.Retorno.Mensagem);
  CheckEquals('GET', FSDP.UltimoMetodo);
  CheckEquals(CURLV2 + 'ml/pedidos/ML-1/etiquetas/pdf', FSDP.UltimaURL);
  CheckEquals(Length(LPDF), Integer(FSDP.ArquivoEtiqueta.Size));
  CheckEquals(0, Integer(FSDP.ArquivoEtiqueta.Position));
  CheckEquals(1, FSDP.Etiquetas.Count);
  CheckEquals('pdf', FSDP.Etiquetas[0].Tipo);
  CheckTrue(FSDP.Etiquetas[0].Sucesso);
end;

procedure TACBrShoppingPrecosOperacoesTests.ObterEtiquetas_MercadoLivreCorpoHTML_RetornaFalso;
begin
  FSDP.Configuracoes.Plataforma := 1;
  FSDP.Pedido.PedidoID := 'ML-1';
  FSDP.ResponderBinario(200, '<html>login</html>', 'text/html');
  CheckFalse(FSDP.ObterEtiquetas);
  CheckEquals(0, Integer(FSDP.ArquivoEtiqueta.Size));
  CheckEquals(0, FSDP.Etiquetas.Count);
  CheckEquals('<html>login</html>', FSDP.Retorno.JSON);
end;

procedure TACBrShoppingPrecosOperacoesTests.ObterEtiquetas_MercadoLivreVariosIDs_GeraExcecao;
var
  LGerouExcecao: Boolean;
begin
  FSDP.Configuracoes.Plataforma := 1;
  FSDP.PedidosEtiquetas.Add('ML-1');
  FSDP.PedidosEtiquetas.Add('ML-2');
  LGerouExcecao := False;
  try
    FSDP.ObterEtiquetas;
  except
    on E: EACBrShoppingPrecos do
      LGerouExcecao := True;
  end;
  CheckTrue(LGerouExcecao, 'Mercado Livre aceita um pedido por chamada');
  CheckEquals(0, FSDP.Chamadas);
end;

procedure TACBrShoppingPrecosOperacoesTests.ObterEtiquetas_IDComVirgula_GeraExcecao;
var
  LGerouExcecao: Boolean;
begin
  FSDP.PedidosEtiquetas.Add('P1,P2');
  LGerouExcecao := False;
  try
    FSDP.ObterEtiquetas;
  except
    on E: EACBrShoppingPrecos do
      LGerouExcecao := True;
  end;
  CheckTrue(LGerouExcecao, 'ID com virgula deveria gerar EACBrShoppingPrecos');
  CheckEquals(0, FSDP.Chamadas);
end;

procedure TACBrShoppingPrecosOperacoesTests.ObterEtiquetas_RespostaComFalha_RetornaFalso;
begin
  FSDP.PedidosEtiquetas.Add('P1');
  FSDP.PedidosEtiquetas.Add('P2');
  FSDP.Responder(200, '{"status":true,"registros":[' +
    '{"PedidoID":"P1","type":"pdf","status":true,"body":"QUJD"},' +
    '{"PedidoID":"P2","status":false,"message":"Pedido sem nota"}]}');
  CheckFalse(FSDP.ObterEtiquetas);
  CheckEquals('POST', FSDP.UltimoMetodo);
  CheckEquals(CURLV1 + 'etiquetas?IntegracaoID=123&PlataformaID=4&Pedidos=P1,P2&Formato=PDF',
    FSDP.UltimaURL);
  CheckEquals(2, FSDP.Etiquetas.Count, 'mantem as etiquetas para consulta');
  CheckTrue(FSDP.Etiquetas[0].Sucesso);
  CheckFalse(FSDP.Etiquetas[1].Sucesso);
  CheckEquals('Pedido sem nota', FSDP.Etiquetas[1].Mensagem);
end;

procedure TACBrShoppingPrecosOperacoesTests.ConfirmarImportacao_IDDuplicado_GeraExcecao;
var
  LGerouExcecao: Boolean;
begin
  FSDP.FilaIDsImportados.Add('F1');
  FSDP.FilaIDsImportados.Add('F1');
  LGerouExcecao := False;
  try
    FSDP.ConfirmarImportacaoPedidos;
  except
    on E: EACBrShoppingPrecos do
      LGerouExcecao := True;
  end;
  CheckTrue(LGerouExcecao, 'ID de fila duplicado deveria gerar EACBrShoppingPrecos');
  CheckEquals(0, FSDP.Chamadas);
end;

procedure TACBrShoppingPrecosOperacoesTests.ConfirmarImportacao_TodosConfirmados_EnviaIDs;
begin
  FSDP.FilaIDsImportados.Add('F1');
  FSDP.FilaIDsImportados.Add('F2');
  FSDP.Responder(200, '{"status":true,"registros":[{"id":"F1","status":true},{"id":"F2","status":true}]}');
  CheckTrue(FSDP.ConfirmarImportacaoPedidos, FSDP.Retorno.Mensagem);
  CheckEquals('POST', FSDP.UltimoMetodo);
  CheckEquals(CURLV2 + 'pedidos/LimpaFila', FSDP.UltimaURL);
  CheckEquals('application/json', FSDP.UltimoContentType);
  CheckEquals('[{"id":"F1"},{"id":"F2"}]', string(FSDP.UltimoCorpo));
end;

procedure TACBrShoppingPrecosOperacoesTests.ConfirmarImportacao_RespostaIncompleta_RetornaFalso;
begin
  FSDP.FilaIDsImportados.Add('F1');
  FSDP.FilaIDsImportados.Add('F2');
  FSDP.Responder(200, '{"status":true,"registros":[{"id":"F1","status":true}]}');
  CheckFalse(FSDP.ConfirmarImportacaoPedidos);
  CheckEquals('Confirmacao incompleta da fila', FSDP.Retorno.Mensagem);
end;

procedure TACBrShoppingPrecosOperacoesTests.ConfirmarImportacao_IDInesperado_RetornaFalso;
begin
  FSDP.FilaIDsImportados.Add('F1');
  FSDP.Responder(200, '{"status":true,"registros":[{"id":"F9","status":true}]}');
  CheckFalse(FSDP.ConfirmarImportacaoPedidos);
  CheckEquals('API retornou ID de fila inesperado ou duplicado', FSDP.Retorno.Mensagem);
end;

procedure TACBrShoppingPrecosOperacoesTests.AtualizarStatus_SemStatus_GeraExcecao;
var
  LGerouExcecao: Boolean;
begin
  FSDP.Pedido.PedidoID := 'P1';
  FSDP.AtualizacaoStatus.NF := '10';
  LGerouExcecao := False;
  try
    FSDP.AtualizarStatus;
  except
    on E: EACBrShoppingPrecos do
      LGerouExcecao := True;
  end;
  CheckTrue(LGerouExcecao, 'Sem Status deveria gerar EACBrShoppingPrecos');
  CheckEquals(0, FSDP.Chamadas);
end;

procedure TACBrShoppingPrecosOperacoesTests.AtualizarStatus_XMLTexto_EnviaBase64UmaVez;
begin
  FSDP.Pedido.PedidoID := 'P1';
  FSDP.AtualizacaoStatus.Status := 'faturado';
  FSDP.AtualizacaoStatus.XMLNFe := '<x>';
  FSDP.Responder(200, '{"status":true}');
  CheckTrue(FSDP.AtualizarStatus, FSDP.Retorno.Mensagem);
  CheckEquals('POST', FSDP.UltimoMetodo);
  CheckEquals(CURLV2 + 'pedidos/P1/integracao/123', FSDP.UltimaURL);
  { base64('<x>') = 'PHg+', com '+' codificado no formulario }
  CheckEquals('status=faturado&xmlNFE=PHg%2B', string(FSDP.UltimoCorpo));
end;

procedure TACBrShoppingPrecosOperacoesTests.AtualizarStatus_CarregarXMLNFe_EnviaBytesSemConversao;
var
  LStream: TMemoryStream;
  LBytes: AnsiString;
begin
  { BOM + '<x>' + 'é' em UTF-8 (C3 A9) }
  LBytes := AnsiChar($EF) + AnsiChar($BB) + AnsiChar($BF) + AnsiString('<x>') +
    AnsiChar($C3) + AnsiChar($A9);
  LStream := TMemoryStream.Create;
  try
    LStream.WriteBuffer(LBytes[1], Length(LBytes));
    FSDP.AtualizacaoStatus.Status := 'faturado';
    FSDP.AtualizacaoStatus.CarregarXMLNFe(LStream);
  finally
    LStream.Free;
  end;
  CheckEquals(5, Length(FSDP.AtualizacaoStatus.XMLNFeBytes), 'sem o BOM');
  FSDP.Pedido.PedidoID := 'P1';
  FSDP.Responder(200, '{"status":true}');
  CheckTrue(FSDP.AtualizarStatus, FSDP.Retorno.Mensagem);
  { base64(3C 78 3E C3 A9) = 'PHg+w6k=' }
  CheckEquals('status=faturado&xmlNFE=PHg%2Bw6k%3D', string(FSDP.UltimoCorpo));
end;

procedure TACBrShoppingPrecosOperacoesTests.AtualizarStatus_AtribuirXMLNFe_DescartaBytesCarregados;
var
  LStream: TMemoryStream;
  LBytes: AnsiString;
begin
  LBytes := '<antigo/>';
  LStream := TMemoryStream.Create;
  try
    LStream.WriteBuffer(LBytes[1], Length(LBytes));
    FSDP.AtualizacaoStatus.CarregarXMLNFe(LStream);
  finally
    LStream.Free;
  end;
  FSDP.AtualizacaoStatus.XMLNFe := '<x>';
  CheckEquals('', string(FSDP.AtualizacaoStatus.XMLNFeBytes));
  FSDP.AtualizacaoStatus.Status := 'faturado';
  FSDP.Pedido.PedidoID := 'P1';
  FSDP.Responder(200, '{"status":true}');
  CheckTrue(FSDP.AtualizarStatus, FSDP.Retorno.Mensagem);
  CheckEquals('status=faturado&xmlNFE=PHg%2B', string(FSDP.UltimoCorpo));
end;

procedure TACBrShoppingPrecosOperacoesTests.AtualizarStatus_CampoNuloEAusente_EnviaVazioEOmite;
begin
  FSDP.Pedido.PedidoID := 'P1';
  FSDP.AtualizacaoStatus.Status := 'enviado';
  FSDP.AtualizacaoStatus.DefinirNulo('rastreio');
  FSDP.Responder(200, '{"status":true}');
  CheckTrue(FSDP.AtualizarStatus, FSDP.Retorno.Mensagem);
  CheckEquals('status=enviado&rastreio=', string(FSDP.UltimoCorpo));
end;

procedure TACBrShoppingPrecosOperacoesTests.EnviarProdutos_KitSemItens_GeraExcecao;
var
  LGerouExcecao: Boolean;
begin
  FSDP.Produto.SKU := 'KIT-1';
  FSDP.Produto.Titulo := 'Kit ficticio';
  FSDP.Produto.Kit := True;
  LGerouExcecao := False;
  try
    FSDP.EnviarProdutos;
  except
    on E: EACBrShoppingPrecos do
      LGerouExcecao := True;
  end;
  CheckTrue(LGerouExcecao, 'Kit sem itens deveria gerar EACBrShoppingPrecos');
  CheckEquals(0, FSDP.Chamadas);
end;

procedure TACBrShoppingPrecosOperacoesTests.EnviarProdutos_PercentuaisDoKitDiferentesDe100_GeraExcecao;
var
  LGerouExcecao: Boolean;
  LItem: TSDPItemKit;
begin
  FSDP.Produto.SKU := 'KIT-1';
  FSDP.Produto.Titulo := 'Kit ficticio';
  FSDP.Produto.Kit := True;
  LItem := FSDP.Produto.ItensKit.Add;
  LItem.SKU := 'A';
  LItem.Quantidade := 1;
  LItem.PercentualValor := 60;
  LItem := FSDP.Produto.ItensKit.Add;
  LItem.SKU := 'B';
  LItem.Quantidade := 1;
  LItem.PercentualValor := 30;
  LGerouExcecao := False;
  try
    FSDP.EnviarProdutos;
  except
    on E: EACBrShoppingPrecos do
      LGerouExcecao := True;
  end;
  CheckTrue(LGerouExcecao, 'Percentuais somando 90 deveriam gerar EACBrShoppingPrecos');
  CheckEquals(0, FSDP.Chamadas);
end;

procedure TACBrShoppingPrecosOperacoesTests.EnviarProdutos_VariacaoSemSKU_GeraExcecao;
var
  LGerouExcecao: Boolean;
begin
  FSDP.Produto.SKU := 'A1';
  FSDP.Produto.Titulo := 'Produto ficticio';
  FSDP.Produto.Variacoes.Add.EAN := '7890000000000';
  LGerouExcecao := False;
  try
    FSDP.EnviarProdutos;
  except
    on E: EACBrShoppingPrecos do
      LGerouExcecao := True;
  end;
  CheckTrue(LGerouExcecao, 'Variacao sem SKU deveria gerar EACBrShoppingPrecos');
  CheckEquals(0, FSDP.Chamadas);
end;

procedure TACBrShoppingPrecosOperacoesTests.EnviarProdutos_SemTitulo_GeraExcecao;
var
  LGerouExcecao: Boolean;
begin
  FSDP.Produto.SKU := 'A1';
  LGerouExcecao := False;
  try
    FSDP.EnviarProdutos;
  except
    on E: EACBrShoppingPrecos do
      LGerouExcecao := True;
  end;
  CheckTrue(LGerouExcecao, 'Produto sem Titulo deveria gerar EACBrShoppingPrecos');
  CheckEquals(0, FSDP.Chamadas);
end;

procedure TACBrShoppingPrecosOperacoesTests.AtualizarEstoque_EstoqueNegativo_GeraExcecao;
var
  LGerouExcecao: Boolean;
begin
  FSDP.Produto.SKU := 'A1';
  FSDP.Produto.Estoque := -1;
  LGerouExcecao := False;
  try
    FSDP.AtualizarEstoque;
  except
    on E: EACBrShoppingPrecos do
      LGerouExcecao := True;
  end;
  CheckTrue(LGerouExcecao, 'Estoque negativo deveria gerar EACBrShoppingPrecos');
  CheckEquals(0, FSDP.Chamadas);
end;

procedure TACBrShoppingPrecosOperacoesTests.AtualizarPreco_SemPreco_GeraExcecao;
var
  LGerouExcecao: Boolean;
begin
  FSDP.Produto.SKU := 'A1';
  LGerouExcecao := False;
  try
    FSDP.AtualizarPreco;
  except
    on E: EACBrShoppingPrecos do
      LGerouExcecao := True;
  end;
  CheckTrue(LGerouExcecao, 'Preco ausente deveria gerar EACBrShoppingPrecos');
  CheckEquals(0, FSDP.Chamadas);
end;

procedure TACBrShoppingPrecosOperacoesTests.ListarPedidos_IntervaloExato3Dias_Aceita;
begin
  FSDP.FiltroPedidos.DataInicial := EncodeDate(2026, 1, 1);
  FSDP.FiltroPedidos.DataFinal := EncodeDate(2026, 1, 4);
  CheckTrue(FSDP.ListarPedidos, FSDP.Retorno.Mensagem);
  CheckEquals(1, FSDP.Chamadas);
end;

procedure TACBrShoppingPrecosOperacoesTests.ListarPedidos_DataFinalAnterior_GeraExcecao;
var
  LGerouExcecao: Boolean;
begin
  FSDP.FiltroPedidos.DataInicial := EncodeDate(2026, 1, 3);
  FSDP.FiltroPedidos.DataFinal := EncodeDate(2026, 1, 2);
  LGerouExcecao := False;
  try
    FSDP.ListarPedidos;
  except
    on E: EACBrShoppingPrecos do
      LGerouExcecao := True;
  end;
  CheckTrue(LGerouExcecao, 'DataFinal anterior a DataInicial deveria gerar EACBrShoppingPrecos');
  CheckEquals(0, FSDP.Chamadas);
end;

procedure TACBrShoppingPrecosOperacoesTests.ListarPedidos_PedidoComDataZerada_LeLista;
begin
  FSDP.FiltroPedidos.DataInicial := EncodeDate(2026, 1, 2);
  FSDP.FiltroPedidos.DataFinal := EncodeDate(2026, 1, 3);
  FSDP.Responder(200, '{"status":true,"registros":[' +
    '{"pedido_id":"P1","data_pedido":"2026-01-02 10:00:00","ultima_atualizacao":"0000-00-00 00:00:00"},' +
    '{"pedido_id":"P2","data_pedido":"2026-01-02 11:00:00"}]}');
  CheckTrue(FSDP.ListarPedidos, FSDP.Retorno.Mensagem);
  CheckEquals(2, FSDP.Pedidos.Count, 'data zerada nao pode descartar a lista');
  CheckTrue(FSDP.Pedidos[0].UltimaAtualizacao = 0, 'data zerada vira 0');
end;

procedure TACBrShoppingPrecosOperacoesTests.ConsultarPedido_SemPedidoID_GeraExcecao;
var
  LGerouExcecao: Boolean;
begin
  LGerouExcecao := False;
  try
    FSDP.ConsultarPedido;
  except
    on E: EACBrShoppingPrecos do
      LGerouExcecao := True;
  end;
  CheckTrue(LGerouExcecao, 'Sem PedidoID deveria gerar EACBrShoppingPrecos');
  CheckEquals(0, FSDP.Chamadas);
end;

procedure TACBrShoppingPrecosOperacoesTests.ConsultarPedido_DoisRegistros_RetornaFalsoELimpaPedido;
begin
  FSDP.Pedido.PedidoID := 'P1';
  FSDP.Responder(200, '{"status":true,"registros":[{"pedido_id":"P1"},{"pedido_id":"P2"}]}');
  CheckFalse(FSDP.ConsultarPedido);
  CheckEquals('Consulta deve retornar exatamente um pedido', FSDP.Retorno.Mensagem);
  CheckEquals('', FSDP.Pedido.PedidoID, 'Pedido limpo apos resposta invalida');
end;

procedure TACBrShoppingPrecosOperacoesTests.AtualizarEstoqueIntegracao_ResultadoDuplicado_RetornaFalso;
var
  LItem: TSDPEstoqueAnuncio;
begin
  LItem := FSDP.EstoquesAnuncios.Add;
  LItem.ProdutoID := 'MLB1';
  LItem.SKU := 'S1';
  LItem.Estoque := 3;
  FSDP.Responder(200, '{"status":true,"registros":[' +
    '{"ProdutoID":"MLB1","SKU":"S1","status":true},' +
    '{"ProdutoID":"MLB1","SKU":"S1","status":true}]}');
  CheckFalse(FSDP.AtualizarEstoqueIntegracao);
  CheckEquals(CURLV2 + 'produtos/123/estoque', FSDP.UltimaURL);
  CheckTrue(Pos('inesperado ou duplicado', FSDP.Retorno.Mensagem) > 0, 'Mensagem: ' + FSDP.Retorno.Mensagem);
end;

procedure TACBrShoppingPrecosOperacoesTests.AtualizarEstoqueIntegracao_ResultadoCompleto_RetornaVerdadeiro;
var
  LItem: TSDPEstoqueAnuncio;
begin
  LItem := FSDP.EstoquesAnuncios.Add;
  LItem.ProdutoID := 'MLB1';
  LItem.SKU := 'S1';
  LItem.Estoque := 3;
  FSDP.Responder(200, '{"status":true,"registros":[{"ProdutoID":"MLB1","SKU":"S1","status":true}]}');
  CheckTrue(FSDP.AtualizarEstoqueIntegracao, FSDP.Retorno.Mensagem);
  CheckEquals(1, FSDP.ResultadosAnuncios.Count);
  CheckTrue(Pos('"produtos":[', string(FSDP.UltimoCorpo)) > 0, 'Corpo: ' + string(FSDP.UltimoCorpo));
end;

procedure TACBrShoppingPrecosOperacoesTests.BaixarRelatorioXML_URLHttp_GeraExcecao;
var
  LGerouExcecao: Boolean;
begin
  FSDP.ResponderDownload(200, 'PK', 'application/zip');
  FSDP.RelatorioXML.URLArquivo := 'http://arquivos.exemplo.com.br/rel.zip';
  LGerouExcecao := False;
  try
    FSDP.BaixarRelatorioXML;
  except
    on E: EACBrShoppingPrecos do
      LGerouExcecao := True;
  end;
  CheckTrue(LGerouExcecao, 'URL sem HTTPS deveria gerar EACBrShoppingPrecos');
  CheckEquals(0, FSDP.Downloads);
end;

procedure TACBrShoppingPrecosOperacoesTests.BaixarRelatorioXML_UserInfoNoHost_GeraExcecao;
var
  LGerouExcecao: Boolean;
begin
  FSDP.ResponderDownload(200, 'PK', 'application/zip');
  FSDP.RelatorioXML.URLArquivo := 'https://usuario@arquivos.exemplo.com.br/rel.zip';
  LGerouExcecao := False;
  try
    FSDP.BaixarRelatorioXML;
  except
    on E: EACBrShoppingPrecos do
      LGerouExcecao := True;
  end;
  CheckTrue(LGerouExcecao, 'URL com usuario no host deveria gerar EACBrShoppingPrecos');
  CheckEquals(0, FSDP.Downloads);
end;

procedure TACBrShoppingPrecosOperacoesTests.BaixarRelatorioXML_ContentTypeHTML_RetornaFalso;
begin
  FSDP.ResponderDownload(200, '<html>expirado</html>', 'text/html; charset=utf-8');
  FSDP.RelatorioXML.URLArquivo := 'https://arquivos.exemplo.com.br/rel.zip';
  CheckFalse(FSDP.BaixarRelatorioXML);
  CheckEquals(1, FSDP.Downloads);
  CheckEquals(0, Integer(FSDP.ArquivoRelatorioXML.Size));
end;

procedure TACBrShoppingPrecosOperacoesTests.BaixarRelatorioXML_ArquivoValido_GravaStream;
begin
  FSDP.ResponderDownload(200, 'PK' + #3#4 + 'zip ficticio', 'application/zip');
  FSDP.RelatorioXML.URLArquivo := 'https://arquivos.exemplo.com.br/rel.zip';
  CheckTrue(FSDP.BaixarRelatorioXML, FSDP.Retorno.Mensagem);
  CheckEquals('https://arquivos.exemplo.com.br/rel.zip', FSDP.UltimaURL);
  CheckEquals(16, Integer(FSDP.ArquivoRelatorioXML.Size));
  CheckEquals(0, Integer(FSDP.ArquivoRelatorioXML.Position));
  CheckEquals(0, FSDP.Chamadas, 'download nao envia credenciais da API');
end;

procedure TACBrShoppingPrecosOperacoesTests.ObterIconePlataforma_ContentTypeHTML_RetornaFalso;
begin
  FSDP.Responder(200, '{"status":true,"registros":[' +
    '{"id":4,"titulo":"Amazon","ativo":true,"icone":"https://cdn.exemplo.com.br/amazon.png"}]}');
  CheckTrue(FSDP.ListarPlataformas, FSDP.Retorno.Mensagem);
  FSDP.ResponderDownload(200, '<html></html>', 'text/html');
  CheckFalse(FSDP.ObterIconePlataforma);
  CheckEquals('O servidor nao retornou uma imagem', FSDP.Retorno.Mensagem);
  CheckEquals(0, Integer(FSDP.ArquivoIcone.Size));
end;

{ TSDPModelosAPITests }

procedure TSDPModelosAPITests.ResultadoAnuncio_IdaEVolta_PreservaNuloEAusente;
var
  LLista: TSDPResultadoAnuncioLista;
  J: TACBrJSONObject;
begin
  LLista := TSDPResultadoAnuncioLista.Create;
  try
    J := TACBrJSONObject.Parse('{"ProdutoID":"MLB1","SKU":"S1","status":true,"message":null}');
    try
      LLista.Add.LerJSON(J);
    finally
      J.Free;
    end;
    CheckEquals('MLB1', LLista[0].ProdutoID);
    CheckTrue(LLista[0].Sucesso);
    CheckTrue(LLista[0].EstadoCampo('message') = sdpcNulo, 'message null');
    CheckTrue(LLista[0].EstadoCampo('DiasEntrega') = sdpcAusente, 'DiasEntrega ausente');
    CheckEquals('[{"ProdutoID":"MLB1","SKU":"S1","status":true,"message":null,"Docas":[]}]',
      LLista.GerarJSON);
  finally
    LLista.Free;
  end;
end;

procedure TSDPModelosAPITests.PlataformaLista_LerJSON_PreencheItens;
var
  LLista: TSDPPlataformaLista;
  J: TACBrJSONObject;
begin
  LLista := TSDPPlataformaLista.Create;
  J := TACBrJSONObject.Parse('{"r":[{"id":1,"titulo":"Mercado Livre","ativo":true},' +
    '{"id":4,"titulo":"Amazon","ativo":false}]}');
  try
    LLista.LerJSON(J.AsJSONArray['r']);
    CheckEquals(2, LLista.Count);
    CheckEquals(4, LLista[1].ID);
    CheckEquals('Amazon', LLista[1].Titulo);
    CheckFalse(LLista[1].Ativo);
  finally
    J.Free;
    LLista.Free;
  end;
end;

procedure TSDPModelosAPITests.RelatorioXML_LerJSON_PreencheStatusEURL;
var
  LRelatorio: TSDPRelatorioXML;
  J: TACBrJSONObject;
begin
  LRelatorio := TSDPRelatorioXML.Create(nil);
  J := TACBrJSONObject.Parse('{"relatorio_id":"R1","status":"concluido",' +
    '"url_arquivo":"https://arquivos.exemplo.com.br/r1.zip"}');
  try
    LRelatorio.LerJSON(J);
    CheckEquals('R1', LRelatorio.ID);
    CheckEquals('concluido', LRelatorio.Status);
    CheckEquals('https://arquivos.exemplo.com.br/r1.zip', LRelatorio.URLArquivo);
  finally
    J.Free;
    LRelatorio.Free;
  end;
end;

initialization
  _RegisterTest('ACBrTCP.ShoppingPrecos.Operacoes', TACBrShoppingPrecosOperacoesTests);
  _RegisterTest('ACBrTCP.ShoppingPrecos.ModelosAPI', TSDPModelosAPITests);

end.
