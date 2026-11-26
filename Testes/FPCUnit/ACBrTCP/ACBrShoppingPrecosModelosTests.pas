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

unit ACBrShoppingPrecosModelosTests;

interface

uses
  Classes,
  SysUtils,
  ACBrTests.Util,
  ACBrShoppingPrecosModelos;

type

  { Ida e volta JSON -> objeto -> JSON e os tres estados (ausente/null/valor)
    dos campos. Dados ficticios em literais; sem rede e sem relogio. }

  TSDPModelosTests = class(TTestCase)
  private
    FTimeSeparatorOriginal: Char;
    FDecimalSeparatorOriginal: Char;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure Produto_JSONComNullEAusente_PreservaTresEstados;
    procedure Produto_IdaEVolta_JSONEstavel;
    procedure Produto_DefinirNuloEOmitir_ControlaEmissao;
    procedure Produto_SetterAposNulo_VoltaParaValor;
    procedure Produto_DataPromocaoComTimeSeparatorPonto_EmiteDoisPontos;
    procedure Produto_NumeroComDecimalSeparatorVirgula_EmitePonto;
    procedure Produto_JSONComDataInvalida_GeraExcecao;
    procedure Produto_Assign_CopiaEstadosDosCampos;
    procedure Produto_Limpar_VoltaTodosParaAusente;
    procedure Pedido_JSONDaAPI_LeCamposEDatas;
    procedure Pedido_IdaEVolta_JSONEstavel;
    procedure Categoria_ComFilhos_LeHierarquia;
    procedure Modelo_DefineProperties_PreservaNuloAoRecarregar;
  end;

  { Componente auxiliar para gravar/ler a colecao no formato de DFM }
  TSDPProdutosHost = class(TComponent)
  private
    FProdutos: TSDPProdutoLista;
    procedure SetProdutos(Value: TSDPProdutoLista);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Produtos: TSDPProdutoLista read FProdutos write SetProdutos;
  end;

implementation

uses
  ACBrJSON,
  ACBrUtil.DateTime;

const
  CProdutoAPI =
    '{"SKU":"SKU-TESTE-01","Titulo":"Produto Ficticio","Preco":10.5,' +
    '"PrecoCusto":null,"Estoque":7,"InicioPromocao":"2026-01-02 03:04:05",' +
    '"Kit":false}';

  CPedidoAPI =
    '{"pedido_id":"PED-0001","integracao_id":"123",' +
    '"data_pedido":"2026-01-02 03:04:05","status":"aprovado",' +
    '"observacoes":null}';

function LerProduto(P: TSDPProduto; const AJSON: string): TSDPProduto;
var
  J: TACBrJSONObject;
begin
  J := TACBrJSONObject.Parse(AJSON);
  try
    P.LerJSON(J);
  finally
    J.Free;
  end;
  Result := P;
end;

{ TSDPProdutosHost }

constructor TSDPProdutosHost.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FProdutos := TSDPProdutoLista.Create;
end;

destructor TSDPProdutosHost.Destroy;
begin
  FProdutos.Free;
  inherited Destroy;
end;

procedure TSDPProdutosHost.SetProdutos(Value: TSDPProdutoLista);
begin
  FProdutos.Assign(Value);
end;

{ TSDPModelosTests }

procedure TSDPModelosTests.SetUp;
begin
  inherited SetUp;
  {$IFDEF HAS_FORMATSETTINGS}
  FTimeSeparatorOriginal := FormatSettings.TimeSeparator;
  FDecimalSeparatorOriginal := FormatSettings.DecimalSeparator;
  {$ELSE}
  FTimeSeparatorOriginal := TimeSeparator;
  FDecimalSeparatorOriginal := DecimalSeparator;
  {$ENDIF}
end;

procedure TSDPModelosTests.TearDown;
begin
  {$IFDEF HAS_FORMATSETTINGS}
  FormatSettings.TimeSeparator := FTimeSeparatorOriginal;
  FormatSettings.DecimalSeparator := FDecimalSeparatorOriginal;
  {$ELSE}
  TimeSeparator := FTimeSeparatorOriginal;
  DecimalSeparator := FDecimalSeparatorOriginal;
  {$ENDIF}
  inherited TearDown;
end;

procedure TSDPModelosTests.Produto_JSONComNullEAusente_PreservaTresEstados;
var
  P: TSDPProduto;
  LJSON: string;
begin
  P := TSDPProduto.Create(nil);
  try
    LerProduto(P, CProdutoAPI);
    CheckEquals('SKU-TESTE-01', P.SKU);
    CheckEquals(7, P.Estoque);
    CheckTrue(Abs(P.Preco - 10.5) < 0.0001, 'Preco');
    CheckTrue(P.EstadoCampo('SKU') = sdpcValor, 'SKU com valor');
    CheckTrue(P.EstadoCampo('PrecoCusto') = sdpcNulo, 'PrecoCusto null');
    CheckTrue(P.EstadoCampo('Marca') = sdpcAusente, 'Marca ausente');

    LJSON := P.GerarJSON;
    CheckTrue(Pos('"PrecoCusto":null', LJSON) > 0, 'null deve ser reemitido: ' + LJSON);
    CheckEquals(0, Pos('"Marca"', LJSON), 'campo ausente nao pode ser emitido: ' + LJSON);
    CheckTrue(Pos('"SKU":"SKU-TESTE-01"', LJSON) > 0, LJSON);
  finally
    P.Free;
  end;
end;

procedure TSDPModelosTests.Produto_IdaEVolta_JSONEstavel;
var
  P1, P2: TSDPProduto;
  LJSON1: string;
begin
  P1 := TSDPProduto.Create(nil);
  P2 := TSDPProduto.Create(nil);
  try
    LJSON1 := LerProduto(P1, CProdutoAPI).GerarJSON;
    LerProduto(P2, LJSON1);
    CheckEquals(LJSON1, P2.GerarJSON);
    CheckTrue(P2.EstadoCampo('PrecoCusto') = sdpcNulo, 'PrecoCusto continua null');
    CheckTrue(P2.EstadoCampo('Marca') = sdpcAusente, 'Marca continua ausente');
  finally
    P2.Free;
    P1.Free;
  end;
end;

procedure TSDPModelosTests.Produto_DefinirNuloEOmitir_ControlaEmissao;
var
  P: TSDPProduto;
begin
  P := TSDPProduto.Create(nil);
  try
    P.SKU := 'A1';
    P.DefinirNulo('PrecoPromocao');
    CheckEquals('{"SKU":"A1","PrecoPromocao":null}', P.GerarJSON);
    P.Omitir('PrecoPromocao');
    CheckEquals('{"SKU":"A1"}', P.GerarJSON);
    CheckTrue(P.EstadoCampo('PrecoPromocao') = sdpcAusente, 'apos Omitir');
  finally
    P.Free;
  end;
end;

procedure TSDPModelosTests.Produto_SetterAposNulo_VoltaParaValor;
var
  P: TSDPProduto;
begin
  P := TSDPProduto.Create(nil);
  try
    P.DefinirNulo('Estoque');
    P.Estoque := 0;
    CheckTrue(P.EstadoCampo('Estoque') = sdpcValor, 'zero informado e valor, nao null');
    CheckEquals('{"Estoque":"0"}', P.GerarJSON);
  finally
    P.Free;
  end;
end;

procedure TSDPModelosTests.Produto_DataPromocaoComTimeSeparatorPonto_EmiteDoisPontos;
var
  P: TSDPProduto;
begin
  {$IFDEF HAS_FORMATSETTINGS}
  FormatSettings.TimeSeparator := '.';
  {$ELSE}
  TimeSeparator := '.';
  {$ENDIF}
  P := TSDPProduto.Create(nil);
  try
    P.InicioPromocao := EncodeDate(2026, 1, 2) + EncodeTime(3, 4, 5, 0);
    CheckEquals('{"InicioPromocao":"2026-01-02 03:04:05"}', P.GerarJSON);
  finally
    P.Free;
  end;
end;

procedure TSDPModelosTests.Produto_NumeroComDecimalSeparatorVirgula_EmitePonto;
var
  P: TSDPProduto;
begin
  {$IFDEF HAS_FORMATSETTINGS}
  FormatSettings.DecimalSeparator := ',';
  {$ELSE}
  DecimalSeparator := ',';
  {$ENDIF}
  P := TSDPProduto.Create(nil);
  try
    P.Preco := 1234.56;
    CheckEquals('{"Preco":"1234.56"}', P.GerarJSON);
  finally
    P.Free;
  end;
end;

procedure TSDPModelosTests.Produto_JSONComDataInvalida_GeraExcecao;
var
  P: TSDPProduto;
  LGerouExcecao: Boolean;
begin
  P := TSDPProduto.Create(nil);
  try
    LGerouExcecao := False;
    try
      LerProduto(P, '{"SKU":"A1","InicioPromocao":"2026-13-40 00:00:00"}');
    except
      on E: EACBrShoppingPrecos do
        LGerouExcecao := True;
    end;
    CheckTrue(LGerouExcecao, 'Data invalida no JSON deveria gerar EACBrShoppingPrecos');
  finally
    P.Free;
  end;
end;

procedure TSDPModelosTests.Produto_Assign_CopiaEstadosDosCampos;
var
  P1, P2: TSDPProduto;
begin
  P1 := TSDPProduto.Create(nil);
  P2 := TSDPProduto.Create(nil);
  try
    LerProduto(P1, CProdutoAPI);
    P2.Assign(P1);
    CheckEquals(P1.GerarJSON, P2.GerarJSON);
    CheckTrue(P2.EstadoCampo('PrecoCusto') = sdpcNulo, 'null copiado');
    CheckTrue(P2.EstadoCampo('Marca') = sdpcAusente, 'ausente copiado');
    CheckEquals(P1.JSONOriginal, P2.JSONOriginal);
  finally
    P2.Free;
    P1.Free;
  end;
end;

procedure TSDPModelosTests.Produto_Limpar_VoltaTodosParaAusente;
var
  P: TSDPProduto;
begin
  P := TSDPProduto.Create(nil);
  try
    LerProduto(P, CProdutoAPI);
    P.Limpar;
    CheckEquals('{}', P.GerarJSON);
    CheckEquals('', P.JSONOriginal);
    CheckTrue(P.EstadoCampo('PrecoCusto') = sdpcAusente, 'null limpo');
  finally
    P.Free;
  end;
end;

procedure TSDPModelosTests.Pedido_JSONDaAPI_LeCamposEDatas;
var
  P: TSDPPedido;
  J: TACBrJSONObject;
  LJSON: string;
begin
  P := TSDPPedido.Create(nil);
  try
    J := TACBrJSONObject.Parse(CPedidoAPI);
    try
      P.LerJSON(J);
    finally
      J.Free;
    end;
    CheckEquals('PED-0001', P.PedidoID);
    CheckEquals('123', P.IntegracaoID);
    CheckEquals('aprovado', P.Status);
    CheckEquals('2026-01-02 03:04:05', FormatDateTimeBr(P.DataPedido, 'yyyy-mm-dd hh:nn:ss'));
    CheckTrue(P.EstadoCampo('observacoes') = sdpcNulo, 'observacoes null');
    CheckTrue(P.EstadoCampo('tipo_me') = sdpcAusente, 'tipo_me ausente');

    LJSON := P.GerarJSON;
    CheckTrue(Pos('"data_pedido":"2026-01-02 03:04:05"', LJSON) > 0, LJSON);
    CheckTrue(Pos('"observacoes":null', LJSON) > 0, LJSON);
    CheckEquals(0, Pos('"tipo_me"', LJSON), LJSON);
  finally
    P.Free;
  end;
end;

procedure TSDPModelosTests.Pedido_IdaEVolta_JSONEstavel;
var
  P1, P2: TSDPPedido;
  J: TACBrJSONObject;
  LJSON1: string;
begin
  P1 := TSDPPedido.Create(nil);
  P2 := TSDPPedido.Create(nil);
  try
    J := TACBrJSONObject.Parse(CPedidoAPI);
    try
      P1.LerJSON(J);
    finally
      J.Free;
    end;
    LJSON1 := P1.GerarJSON;
    J := TACBrJSONObject.Parse(LJSON1);
    try
      P2.LerJSON(J);
    finally
      J.Free;
    end;
    CheckEquals(LJSON1, P2.GerarJSON);
  finally
    P2.Free;
    P1.Free;
  end;
end;

procedure TSDPModelosTests.Categoria_ComFilhos_LeHierarquia;
var
  L: TSDPCategoriaLista;
  J: TACBrJSONObject;
begin
  L := TSDPCategoriaLista.Create;
  try
    J := TACBrJSONObject.Parse(
      '{"registros":[{"id":"C1","nome":"Raiz","temFilhos":true,' +
      '"filhos":[{"id":"C2","nome":"Filha","temFilhos":false}]}]}');
    try
      L.LerJSON(J.AsJSONArray['registros']);
    finally
      J.Free;
    end;
    CheckEquals(1, L.Count);
    CheckEquals('C1', L[0].ID);
    CheckTrue(L[0].TemFilhos, 'TemFilhos');
    CheckEquals(1, L[0].Filhos.Count);
    CheckEquals('C2', L[0].Filhos[0].ID);
    CheckEquals('Filha', L[0].Filhos[0].Nome);
  finally
    L.Free;
  end;
end;

procedure TSDPModelosTests.Modelo_DefineProperties_PreservaNuloAoRecarregar;
var
  H1, H2: TSDPProdutosHost;
  S: TMemoryStream;
begin
  H1 := TSDPProdutosHost.Create(nil);
  H2 := TSDPProdutosHost.Create(nil);
  S := TMemoryStream.Create;
  try
    LerProduto(H1.Produtos.Add, CProdutoAPI);
    S.WriteComponent(H1);
    S.Position := 0;
    S.ReadComponent(H2);
    CheckEquals(1, H2.Produtos.Count);
    CheckEquals(H1.Produtos[0].GerarJSON, H2.Produtos[0].GerarJSON);
    CheckTrue(H2.Produtos[0].EstadoCampo('PrecoCusto') = sdpcNulo, 'null preservado no DFM');
    CheckTrue(H2.Produtos[0].EstadoCampo('Marca') = sdpcAusente, 'ausente preservado no DFM');
  finally
    S.Free;
    H2.Free;
    H1.Free;
  end;
end;

initialization
  _RegisterTest('ACBrTCP.ShoppingPrecos.Modelos', TSDPModelosTests);

end.
