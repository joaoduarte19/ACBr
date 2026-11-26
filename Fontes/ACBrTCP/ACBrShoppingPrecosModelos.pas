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
|*
|* Documentacao da API: https://apidoc.shoppingdeprecos.com.br/introducao
******************************************************************************}

{$I ACBr.inc}
unit ACBrShoppingPrecosModelos;

interface

uses Classes, SysUtils, ACBrJSON;

type
  EACBrShoppingPrecos = class(Exception);
  TSDPEstadoCampo = (sdpcAusente, sdpcNulo, sdpcValor);

  TSDPModelo = class(TCollectionItem)
  private
    FInformados, FNulos: TStringList;
    FJSONOriginal: string;
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure LerDados(Reader: TReader);
    procedure GravarDados(Writer: TWriter);
    procedure Informar(const Campo: string);
    procedure Emitir(var JSON: string; const Campo, Valor: string);
    { True quando o campo veio com valor; registra null e ignora ausente. }
    function LerCampo(J: TACBrJSONObject; const Campo: string): Boolean;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Limpar; virtual;
    procedure Assign(Source: TPersistent); override;
    procedure LerJSON(J: TACBrJSONObject); virtual;
    function GerarJSON: string; virtual; abstract;
    procedure DefinirNulo(const Campo: string);
    procedure Omitir(const Campo: string);
    function EstadoCampo(const Campo: string): TSDPEstadoCampo;
    property JSONOriginal: string read FJSONOriginal;
  end;

  { Base das colecoes tipadas: leitura e geracao do array JSON. }
  TSDPListaAPI = class(TCollection)
  public
    procedure LerJSON(A: TACBrJSONArray);
    function GerarJSON: string;
  end;

  TSDPImagem = class;
  TSDPAtributo = class;
  TSDPItemKit = class;
  TSDPVariacao = class;
  TSDPProduto = class;
  TSDPCategoria = class;
  TSDPDimensoes = class;
  TSDPItemPedido = class;
  TSDPPagamento = class;
  TSDPComprador = class;
  TSDPEntrega = class;
  TSDPPlataformaPedido = class;
  TSDPFaturamento = class;
  TSDPPedido = class;
  TSDPFilaPedido = class;
  TSDPAtualizacaoStatus = class;
  TSDPEtiqueta = class;

  TSDPImagemLista = class(TSDPListaAPI)
  private
    function GetItem(Index: Integer): TSDPImagem;
  public
    constructor Create;
    function Add: TSDPImagem;
    property Items[Index: Integer]: TSDPImagem read GetItem; default;
  end;

  TSDPAtributoLista = class(TSDPListaAPI)
  private
    function GetItem(Index: Integer): TSDPAtributo;
  public
    constructor Create;
    function Add: TSDPAtributo;
    property Items[Index: Integer]: TSDPAtributo read GetItem; default;
  end;

  TSDPItemKitLista = class(TSDPListaAPI)
  private
    function GetItem(Index: Integer): TSDPItemKit;
  public
    constructor Create;
    function Add: TSDPItemKit;
    property Items[Index: Integer]: TSDPItemKit read GetItem; default;
  end;

  TSDPVariacaoLista = class(TSDPListaAPI)
  private
    function GetItem(Index: Integer): TSDPVariacao;
  public
    constructor Create;
    function Add: TSDPVariacao;
    property Items[Index: Integer]: TSDPVariacao read GetItem; default;
  end;

  TSDPProdutoLista = class(TSDPListaAPI)
  private
    function GetItem(Index: Integer): TSDPProduto;
  public
    constructor Create;
    function Add: TSDPProduto;
    property Items[Index: Integer]: TSDPProduto read GetItem; default;
  end;

  TSDPCategoriaLista = class(TSDPListaAPI)
  private
    function GetItem(Index: Integer): TSDPCategoria;
  public
    constructor Create;
    function Add: TSDPCategoria;
    property Items[Index: Integer]: TSDPCategoria read GetItem; default;
  end;

  TSDPDimensoesLista = class(TSDPListaAPI)
  private
    function GetItem(Index: Integer): TSDPDimensoes;
  public
    constructor Create;
    function Add: TSDPDimensoes;
    property Items[Index: Integer]: TSDPDimensoes read GetItem; default;
  end;

  TSDPItemPedidoLista = class(TSDPListaAPI)
  private
    function GetItem(Index: Integer): TSDPItemPedido;
  public
    constructor Create;
    function Add: TSDPItemPedido;
    property Items[Index: Integer]: TSDPItemPedido read GetItem; default;
  end;

  TSDPPagamentoLista = class(TSDPListaAPI)
  private
    function GetItem(Index: Integer): TSDPPagamento;
  public
    constructor Create;
    function Add: TSDPPagamento;
    property Items[Index: Integer]: TSDPPagamento read GetItem; default;
  end;

  TSDPCompradorLista = class(TSDPListaAPI)
  private
    function GetItem(Index: Integer): TSDPComprador;
  public
    constructor Create;
    function Add: TSDPComprador;
    property Items[Index: Integer]: TSDPComprador read GetItem; default;
  end;

  TSDPEntregaLista = class(TSDPListaAPI)
  private
    function GetItem(Index: Integer): TSDPEntrega;
  public
    constructor Create;
    function Add: TSDPEntrega;
    property Items[Index: Integer]: TSDPEntrega read GetItem; default;
  end;

  TSDPPlataformaPedidoLista = class(TSDPListaAPI)
  private
    function GetItem(Index: Integer): TSDPPlataformaPedido;
  public
    constructor Create;
    function Add: TSDPPlataformaPedido;
    property Items[Index: Integer]: TSDPPlataformaPedido read GetItem; default;
  end;

  TSDPFaturamentoLista = class(TSDPListaAPI)
  private
    function GetItem(Index: Integer): TSDPFaturamento;
  public
    constructor Create;
    function Add: TSDPFaturamento;
    property Items[Index: Integer]: TSDPFaturamento read GetItem; default;
  end;

  TSDPPedidoLista = class(TSDPListaAPI)
  private
    function GetItem(Index: Integer): TSDPPedido;
  public
    constructor Create;
    function Add: TSDPPedido;
    property Items[Index: Integer]: TSDPPedido read GetItem; default;
  end;

  TSDPFilaPedidoLista = class(TSDPListaAPI)
  private
    function GetItem(Index: Integer): TSDPFilaPedido;
  public
    constructor Create;
    function Add: TSDPFilaPedido;
    property Items[Index: Integer]: TSDPFilaPedido read GetItem; default;
  end;

  TSDPAtualizacaoStatusLista = class(TSDPListaAPI)
  private
    function GetItem(Index: Integer): TSDPAtualizacaoStatus;
  public
    constructor Create;
    function Add: TSDPAtualizacaoStatus;
    property Items[Index: Integer]: TSDPAtualizacaoStatus read GetItem; default;
  end;

  TSDPEtiquetaLista = class(TSDPListaAPI)
  private
    function GetItem(Index: Integer): TSDPEtiqueta;
  public
    constructor Create;
    function Add: TSDPEtiqueta;
    property Items[Index: Integer]: TSDPEtiqueta read GetItem; default;
  end;

  TSDPImagem = class(TSDPModelo)
  private
    FURL: string;
    FEtiqueta: string;
    procedure SetURL(const Value: string);
    procedure SetEtiqueta(const Value: string);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Limpar; override;
    procedure LerJSON(J: TACBrJSONObject); override;
    function GerarJSON: string; override;
  published
    property URL: string read FURL write SetURL stored False;
    property Etiqueta: string read FEtiqueta write SetEtiqueta stored False;
  end;

  TSDPAtributo = class(TSDPModelo)
  private
    FTipo: string;
    FValor: string;
    procedure SetTipo(const Value: string);
    procedure SetValor(const Value: string);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Limpar; override;
    procedure LerJSON(J: TACBrJSONObject); override;
    function GerarJSON: string; override;
  published
    property Tipo: string read FTipo write SetTipo stored False;
    property Valor: string read FValor write SetValor stored False;
  end;

  TSDPItemKit = class(TSDPModelo)
  private
    FSKU: string;
    FQuantidade: Integer;
    FPercentualValor: Currency;
    procedure SetSKU(const Value: string);
    procedure SetQuantidade(const Value: Integer);
    procedure SetPercentualValor(const Value: Currency);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Limpar; override;
    procedure LerJSON(J: TACBrJSONObject); override;
    function GerarJSON: string; override;
  published
    property SKU: string read FSKU write SetSKU stored False;
    property Quantidade: Integer read FQuantidade write SetQuantidade stored False;
    property PercentualValor: Currency read FPercentualValor write SetPercentualValor stored False;
  end;

  TSDPVariacao = class(TSDPModelo)
  private
    FSKU: string;
    FEAN: string;
    FPreco: Currency;
    FPrecoCusto: Currency;
    FEstoque: Integer;
    FLarguraCm: Double;
    FAlturaCm: Double;
    FComprimentoCm: Double;
    FPesoKg: Double;
    FImagens: TSDPImagemLista;
    FAtributos: TSDPAtributoLista;
    procedure SetSKU(const Value: string);
    procedure SetEAN(const Value: string);
    procedure SetPreco(const Value: Currency);
    procedure SetPrecoCusto(const Value: Currency);
    procedure SetEstoque(const Value: Integer);
    procedure SetLarguraCm(const Value: Double);
    procedure SetAlturaCm(const Value: Double);
    procedure SetComprimentoCm(const Value: Double);
    procedure SetPesoKg(const Value: Double);
    procedure SetImagens(Value: TSDPImagemLista);
    procedure SetAtributos(Value: TSDPAtributoLista);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Limpar; override;
    procedure LerJSON(J: TACBrJSONObject); override;
    function GerarJSON: string; override;
  published
    property SKU: string read FSKU write SetSKU stored False;
    property EAN: string read FEAN write SetEAN stored False;
    property Preco: Currency read FPreco write SetPreco stored False;
    property PrecoCusto: Currency read FPrecoCusto write SetPrecoCusto stored False;
    property Estoque: Integer read FEstoque write SetEstoque stored False;
    property LarguraCm: Double read FLarguraCm write SetLarguraCm stored False;
    property AlturaCm: Double read FAlturaCm write SetAlturaCm stored False;
    property ComprimentoCm: Double read FComprimentoCm write SetComprimentoCm stored False;
    property PesoKg: Double read FPesoKg write SetPesoKg stored False;
    property Imagens: TSDPImagemLista read FImagens write SetImagens stored False;
    property Atributos: TSDPAtributoLista read FAtributos write SetAtributos stored False;
  end;

  TSDPProduto = class(TSDPModelo)
  private
    FSKU: string;
    FTitulo: string;
    FMarca: string;
    FCategoria: string;
    FDescricao: string;
    FPreco: Currency;
    FPrecoCusto: Currency;
    FPrecoPromocao: Currency;
    FInicioPromocao: TDateTime;
    FTerminoPromocao: TDateTime;
    FEstoque: Integer;
    FVideo: string;
    FGarantia: string;
    FFabricante: string;
    FLarguraCm: Double;
    FAlturaCm: Double;
    FComprimentoCm: Double;
    FPesoKg: Double;
    FLarguraEmbalagemCm: Double;
    FAlturaEmbalagemCm: Double;
    FComprimentoEmbalagemCm: Double;
    FPesoEmbalagemKg: Double;
    FDescricaoCurta: string;
    FMetaTag: string;
    FMetaTitle: string;
    FMetaDescription: string;
    FCEST: string;
    FOrigem: Integer;
    FUnidadeMedida: string;
    FCSOSN: string;
    FNCM: string;
    FEAN: string;
    FKit: Boolean;
    FCodigoAnvisa: string;
    FCodigoInmetro: string;
    FCodigoMapa: string;
    FImagens: TSDPImagemLista;
    FAtributos: TSDPAtributoLista;
    FVariacoes: TSDPVariacaoLista;
    FItensKit: TSDPItemKitLista;
    procedure SetSKU(const Value: string);
    procedure SetTitulo(const Value: string);
    procedure SetMarca(const Value: string);
    procedure SetCategoria(const Value: string);
    procedure SetDescricao(const Value: string);
    procedure SetPreco(const Value: Currency);
    procedure SetPrecoCusto(const Value: Currency);
    procedure SetPrecoPromocao(const Value: Currency);
    procedure SetInicioPromocao(const Value: TDateTime);
    procedure SetTerminoPromocao(const Value: TDateTime);
    procedure SetEstoque(const Value: Integer);
    procedure SetVideo(const Value: string);
    procedure SetGarantia(const Value: string);
    procedure SetFabricante(const Value: string);
    procedure SetLarguraCm(const Value: Double);
    procedure SetAlturaCm(const Value: Double);
    procedure SetComprimentoCm(const Value: Double);
    procedure SetPesoKg(const Value: Double);
    procedure SetLarguraEmbalagemCm(const Value: Double);
    procedure SetAlturaEmbalagemCm(const Value: Double);
    procedure SetComprimentoEmbalagemCm(const Value: Double);
    procedure SetPesoEmbalagemKg(const Value: Double);
    procedure SetDescricaoCurta(const Value: string);
    procedure SetMetaTag(const Value: string);
    procedure SetMetaTitle(const Value: string);
    procedure SetMetaDescription(const Value: string);
    procedure SetCEST(const Value: string);
    procedure SetOrigem(const Value: Integer);
    procedure SetUnidadeMedida(const Value: string);
    procedure SetCSOSN(const Value: string);
    procedure SetNCM(const Value: string);
    procedure SetEAN(const Value: string);
    procedure SetKit(const Value: Boolean);
    procedure SetCodigoAnvisa(const Value: string);
    procedure SetCodigoInmetro(const Value: string);
    procedure SetCodigoMapa(const Value: string);
    procedure SetImagens(Value: TSDPImagemLista);
    procedure SetAtributos(Value: TSDPAtributoLista);
    procedure SetVariacoes(Value: TSDPVariacaoLista);
    procedure SetItensKit(Value: TSDPItemKitLista);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Limpar; override;
    procedure LerJSON(J: TACBrJSONObject); override;
    function GerarJSON: string; override;
  published
    property SKU: string read FSKU write SetSKU stored False;
    property Titulo: string read FTitulo write SetTitulo stored False;
    property Marca: string read FMarca write SetMarca stored False;
    property Categoria: string read FCategoria write SetCategoria stored False;
    property Descricao: string read FDescricao write SetDescricao stored False;
    property Preco: Currency read FPreco write SetPreco stored False;
    property PrecoCusto: Currency read FPrecoCusto write SetPrecoCusto stored False;
    property PrecoPromocao: Currency read FPrecoPromocao write SetPrecoPromocao stored False;
    property InicioPromocao: TDateTime read FInicioPromocao write SetInicioPromocao stored False;
    property TerminoPromocao: TDateTime read FTerminoPromocao write SetTerminoPromocao stored False;
    property Estoque: Integer read FEstoque write SetEstoque stored False;
    property Video: string read FVideo write SetVideo stored False;
    property Garantia: string read FGarantia write SetGarantia stored False;
    property Fabricante: string read FFabricante write SetFabricante stored False;
    property LarguraCm: Double read FLarguraCm write SetLarguraCm stored False;
    property AlturaCm: Double read FAlturaCm write SetAlturaCm stored False;
    property ComprimentoCm: Double read FComprimentoCm write SetComprimentoCm stored False;
    property PesoKg: Double read FPesoKg write SetPesoKg stored False;
    property LarguraEmbalagemCm: Double read FLarguraEmbalagemCm write SetLarguraEmbalagemCm stored False;
    property AlturaEmbalagemCm: Double read FAlturaEmbalagemCm write SetAlturaEmbalagemCm stored False;
    property ComprimentoEmbalagemCm: Double read FComprimentoEmbalagemCm write SetComprimentoEmbalagemCm stored False;
    property PesoEmbalagemKg: Double read FPesoEmbalagemKg write SetPesoEmbalagemKg stored False;
    property DescricaoCurta: string read FDescricaoCurta write SetDescricaoCurta stored False;
    property MetaTag: string read FMetaTag write SetMetaTag stored False;
    property MetaTitle: string read FMetaTitle write SetMetaTitle stored False;
    property MetaDescription: string read FMetaDescription write SetMetaDescription stored False;
    property CEST: string read FCEST write SetCEST stored False;
    property Origem: Integer read FOrigem write SetOrigem stored False;
    property UnidadeMedida: string read FUnidadeMedida write SetUnidadeMedida stored False;
    property CSOSN: string read FCSOSN write SetCSOSN stored False;
    property NCM: string read FNCM write SetNCM stored False;
    property EAN: string read FEAN write SetEAN stored False;
    property Kit: Boolean read FKit write SetKit stored False;
    property CodigoAnvisa: string read FCodigoAnvisa write SetCodigoAnvisa stored False;
    property CodigoInmetro: string read FCodigoInmetro write SetCodigoInmetro stored False;
    property CodigoMapa: string read FCodigoMapa write SetCodigoMapa stored False;
    property Imagens: TSDPImagemLista read FImagens write SetImagens stored False;
    property Atributos: TSDPAtributoLista read FAtributos write SetAtributos stored False;
    property Variacoes: TSDPVariacaoLista read FVariacoes write SetVariacoes stored False;
    property ItensKit: TSDPItemKitLista read FItensKit write SetItensKit stored False;
  end;

  TSDPCategoria = class(TSDPModelo)
  private
    FID: string;
    FNome: string;
    FDepartamento: string;
    FTemFilhos: Boolean;
    FFilhos: TSDPCategoriaLista;
    procedure SetID(const Value: string);
    procedure SetNome(const Value: string);
    procedure SetDepartamento(const Value: string);
    procedure SetTemFilhos(const Value: Boolean);
    procedure SetFilhos(Value: TSDPCategoriaLista);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Limpar; override;
    procedure LerJSON(J: TACBrJSONObject); override;
    function GerarJSON: string; override;
  published
    property ID: string read FID write SetID stored False;
    property Nome: string read FNome write SetNome stored False;
    property Departamento: string read FDepartamento write SetDepartamento stored False;
    property TemFilhos: Boolean read FTemFilhos write SetTemFilhos stored False;
    property Filhos: TSDPCategoriaLista read FFilhos write SetFilhos stored False;
  end;

  TSDPDimensoes = class(TSDPModelo)
  private
    FAltura: Double;
    FLargura: Double;
    FComprimento: Double;
    FPeso: Double;
    procedure SetAltura(const Value: Double);
    procedure SetLargura(const Value: Double);
    procedure SetComprimento(const Value: Double);
    procedure SetPeso(const Value: Double);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Limpar; override;
    procedure LerJSON(J: TACBrJSONObject); override;
    function GerarJSON: string; override;
  published
    property Altura: Double read FAltura write SetAltura stored False;
    property Largura: Double read FLargura write SetLargura stored False;
    property Comprimento: Double read FComprimento write SetComprimento stored False;
    property Peso: Double read FPeso write SetPeso stored False;
  end;

  TSDPItemPedido = class(TSDPModelo)
  private
    FSequencia: Integer;
    FSKU: string;
    FSKUErp: string;
    FNumeroSerial: string;
    FMLB: string;
    FFoto: string;
    FEAN: string;
    FVariacaoID: string;
    FDescricao: string;
    FDescricaoVariacao: string;
    FObservacao: string;
    FQuantidade: Double;
    FValorUnitario: Currency;
    FDesconto: Currency;
    FValorTotal: Currency;
    FTarifaVenda: Currency;
    FPercentualComissao: Double;
    FTipoAnuncio: string;
    FEmbalagemPresente: Boolean;
    FKit: Boolean;
    FRebate: Currency;
    FDepositoID: string;
    FDimensoes: TSDPDimensoes;
    FItensKit: TSDPItemKitLista;
    procedure SetSequencia(const Value: Integer);
    procedure SetSKU(const Value: string);
    procedure SetSKUErp(const Value: string);
    procedure SetNumeroSerial(const Value: string);
    procedure SetMLB(const Value: string);
    procedure SetFoto(const Value: string);
    procedure SetEAN(const Value: string);
    procedure SetVariacaoID(const Value: string);
    procedure SetDescricao(const Value: string);
    procedure SetDescricaoVariacao(const Value: string);
    procedure SetObservacao(const Value: string);
    procedure SetQuantidade(const Value: Double);
    procedure SetValorUnitario(const Value: Currency);
    procedure SetDesconto(const Value: Currency);
    procedure SetValorTotal(const Value: Currency);
    procedure SetTarifaVenda(const Value: Currency);
    procedure SetPercentualComissao(const Value: Double);
    procedure SetTipoAnuncio(const Value: string);
    procedure SetEmbalagemPresente(const Value: Boolean);
    procedure SetKit(const Value: Boolean);
    procedure SetRebate(const Value: Currency);
    procedure SetDepositoID(const Value: string);
    procedure SetDimensoes(Value: TSDPDimensoes);
    procedure SetItensKit(Value: TSDPItemKitLista);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Limpar; override;
    procedure LerJSON(J: TACBrJSONObject); override;
    function GerarJSON: string; override;
  published
    property Sequencia: Integer read FSequencia write SetSequencia stored False;
    property SKU: string read FSKU write SetSKU stored False;
    property SKUErp: string read FSKUErp write SetSKUErp stored False;
    property NumeroSerial: string read FNumeroSerial write SetNumeroSerial stored False;
    property MLB: string read FMLB write SetMLB stored False;
    property Foto: string read FFoto write SetFoto stored False;
    property EAN: string read FEAN write SetEAN stored False;
    property VariacaoID: string read FVariacaoID write SetVariacaoID stored False;
    property Descricao: string read FDescricao write SetDescricao stored False;
    property DescricaoVariacao: string read FDescricaoVariacao write SetDescricaoVariacao stored False;
    property Observacao: string read FObservacao write SetObservacao stored False;
    property Quantidade: Double read FQuantidade write SetQuantidade stored False;
    property ValorUnitario: Currency read FValorUnitario write SetValorUnitario stored False;
    property Desconto: Currency read FDesconto write SetDesconto stored False;
    property ValorTotal: Currency read FValorTotal write SetValorTotal stored False;
    property TarifaVenda: Currency read FTarifaVenda write SetTarifaVenda stored False;
    property PercentualComissao: Double read FPercentualComissao write SetPercentualComissao stored False;
    property TipoAnuncio: string read FTipoAnuncio write SetTipoAnuncio stored False;
    property EmbalagemPresente: Boolean read FEmbalagemPresente write SetEmbalagemPresente stored False;
    property Kit: Boolean read FKit write SetKit stored False;
    property Rebate: Currency read FRebate write SetRebate stored False;
    property DepositoID: string read FDepositoID write SetDepositoID stored False;
    property Dimensoes: TSDPDimensoes read FDimensoes write SetDimensoes stored False;
    property ItensKit: TSDPItemKitLista read FItensKit write SetItensKit stored False;
  end;

  TSDPPagamento = class(TSDPModelo)
  private
    FSequencia: Integer;
    FData: TDateTime;
    FValor: Currency;
    FStatus: string;
    FBandeira: string;
    FOperadora: string;
    FIdentificacao: string;
    FCodigoTransacao: string;
    FCNPJAutorizador: string;
    FForma: string;
    FParcelas: Integer;
    procedure SetSequencia(const Value: Integer);
    procedure SetData(const Value: TDateTime);
    procedure SetValor(const Value: Currency);
    procedure SetStatus(const Value: string);
    procedure SetBandeira(const Value: string);
    procedure SetOperadora(const Value: string);
    procedure SetIdentificacao(const Value: string);
    procedure SetCodigoTransacao(const Value: string);
    procedure SetCNPJAutorizador(const Value: string);
    procedure SetForma(const Value: string);
    procedure SetParcelas(const Value: Integer);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Limpar; override;
    procedure LerJSON(J: TACBrJSONObject); override;
    function GerarJSON: string; override;
  published
    property Sequencia: Integer read FSequencia write SetSequencia stored False;
    property Data: TDateTime read FData write SetData stored False;
    property Valor: Currency read FValor write SetValor stored False;
    property Status: string read FStatus write SetStatus stored False;
    property Bandeira: string read FBandeira write SetBandeira stored False;
    property Operadora: string read FOperadora write SetOperadora stored False;
    property Identificacao: string read FIdentificacao write SetIdentificacao stored False;
    property CodigoTransacao: string read FCodigoTransacao write SetCodigoTransacao stored False;
    property CNPJAutorizador: string read FCNPJAutorizador write SetCNPJAutorizador stored False;
    property Forma: string read FForma write SetForma stored False;
    property Parcelas: Integer read FParcelas write SetParcelas stored False;
  end;

  TSDPComprador = class(TSDPModelo)
  private
    FNome: string;
    FEndereco: string;
    FNumero: string;
    FBairro: string;
    FComplemento: string;
    FCidade: string;
    FUF: string;
    FPais: string;
    FCEP: string;
    FEmail: string;
    FFone: string;
    FApelido: string;
    FDocumento: string;
    FRGIE: string;
    FCelular: string;
    procedure SetNome(const Value: string);
    procedure SetEndereco(const Value: string);
    procedure SetNumero(const Value: string);
    procedure SetBairro(const Value: string);
    procedure SetComplemento(const Value: string);
    procedure SetCidade(const Value: string);
    procedure SetUF(const Value: string);
    procedure SetPais(const Value: string);
    procedure SetCEP(const Value: string);
    procedure SetEmail(const Value: string);
    procedure SetFone(const Value: string);
    procedure SetApelido(const Value: string);
    procedure SetDocumento(const Value: string);
    procedure SetRGIE(const Value: string);
    procedure SetCelular(const Value: string);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Limpar; override;
    procedure LerJSON(J: TACBrJSONObject); override;
    function GerarJSON: string; override;
  published
    property Nome: string read FNome write SetNome stored False;
    property Endereco: string read FEndereco write SetEndereco stored False;
    property Numero: string read FNumero write SetNumero stored False;
    property Bairro: string read FBairro write SetBairro stored False;
    property Complemento: string read FComplemento write SetComplemento stored False;
    property Cidade: string read FCidade write SetCidade stored False;
    property UF: string read FUF write SetUF stored False;
    property Pais: string read FPais write SetPais stored False;
    property CEP: string read FCEP write SetCEP stored False;
    property Email: string read FEmail write SetEmail stored False;
    property Fone: string read FFone write SetFone stored False;
    property Apelido: string read FApelido write SetApelido stored False;
    property Documento: string read FDocumento write SetDocumento stored False;
    property RGIE: string read FRGIE write SetRGIE stored False;
    property Celular: string read FCelular write SetCelular stored False;
  end;

  TSDPEntrega = class(TSDPModelo)
  private
    FNome: string;
    FEndereco: string;
    FNumero: string;
    FBairro: string;
    FComplemento: string;
    FCidade: string;
    FUF: string;
    FPais: string;
    FCEP: string;
    FEmail: string;
    FFone: string;
    FID: string;
    FFormaEnvio: string;
    FTransportadora: string;
    FCodigoRastreio: string;
    FProgramaEnvio: string;
    FLimiteEntrega: TDateTime;
    FPrevisaoLiberacaoEtiqueta: TDateTime;
    FLimiteExpedicao: TDateTime;
    FComissaoFrete: Currency;
    FRebateFrete: Currency;
    FEtiquetaGeradaTransportadora: Boolean;
    FIDGeradoTransportadora: string;
    procedure SetNome(const Value: string);
    procedure SetEndereco(const Value: string);
    procedure SetNumero(const Value: string);
    procedure SetBairro(const Value: string);
    procedure SetComplemento(const Value: string);
    procedure SetCidade(const Value: string);
    procedure SetUF(const Value: string);
    procedure SetPais(const Value: string);
    procedure SetCEP(const Value: string);
    procedure SetEmail(const Value: string);
    procedure SetFone(const Value: string);
    procedure SetID(const Value: string);
    procedure SetFormaEnvio(const Value: string);
    procedure SetTransportadora(const Value: string);
    procedure SetCodigoRastreio(const Value: string);
    procedure SetProgramaEnvio(const Value: string);
    procedure SetLimiteEntrega(const Value: TDateTime);
    procedure SetPrevisaoLiberacaoEtiqueta(const Value: TDateTime);
    procedure SetLimiteExpedicao(const Value: TDateTime);
    procedure SetComissaoFrete(const Value: Currency);
    procedure SetRebateFrete(const Value: Currency);
    procedure SetEtiquetaGeradaTransportadora(const Value: Boolean);
    procedure SetIDGeradoTransportadora(const Value: string);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Limpar; override;
    procedure LerJSON(J: TACBrJSONObject); override;
    function GerarJSON: string; override;
  published
    property Nome: string read FNome write SetNome stored False;
    property Endereco: string read FEndereco write SetEndereco stored False;
    property Numero: string read FNumero write SetNumero stored False;
    property Bairro: string read FBairro write SetBairro stored False;
    property Complemento: string read FComplemento write SetComplemento stored False;
    property Cidade: string read FCidade write SetCidade stored False;
    property UF: string read FUF write SetUF stored False;
    property Pais: string read FPais write SetPais stored False;
    property CEP: string read FCEP write SetCEP stored False;
    property Email: string read FEmail write SetEmail stored False;
    property Fone: string read FFone write SetFone stored False;
    property ID: string read FID write SetID stored False;
    property FormaEnvio: string read FFormaEnvio write SetFormaEnvio stored False;
    property Transportadora: string read FTransportadora write SetTransportadora stored False;
    property CodigoRastreio: string read FCodigoRastreio write SetCodigoRastreio stored False;
    property ProgramaEnvio: string read FProgramaEnvio write SetProgramaEnvio stored False;
    property LimiteEntrega: TDateTime read FLimiteEntrega write SetLimiteEntrega stored False;
    property PrevisaoLiberacaoEtiqueta: TDateTime read FPrevisaoLiberacaoEtiqueta write SetPrevisaoLiberacaoEtiqueta stored False;
    property LimiteExpedicao: TDateTime read FLimiteExpedicao write SetLimiteExpedicao stored False;
    property ComissaoFrete: Currency read FComissaoFrete write SetComissaoFrete stored False;
    property RebateFrete: Currency read FRebateFrete write SetRebateFrete stored False;
    property EtiquetaGeradaTransportadora: Boolean read FEtiquetaGeradaTransportadora write SetEtiquetaGeradaTransportadora stored False;
    property IDGeradoTransportadora: string read FIDGeradoTransportadora write SetIDGeradoTransportadora stored False;
  end;

  TSDPPlataformaPedido = class(TSDPModelo)
  private
    FID: Integer;
    FNome: string;
    FIntermediadorCNPJ: string;
    FIntermediadorIdentificacaoLoja: string;
    FLoja: string;
    procedure SetID(const Value: Integer);
    procedure SetNome(const Value: string);
    procedure SetIntermediadorCNPJ(const Value: string);
    procedure SetIntermediadorIdentificacaoLoja(const Value: string);
    procedure SetLoja(const Value: string);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Limpar; override;
    procedure LerJSON(J: TACBrJSONObject); override;
    function GerarJSON: string; override;
  published
    property ID: Integer read FID write SetID stored False;
    property Nome: string read FNome write SetNome stored False;
    property IntermediadorCNPJ: string read FIntermediadorCNPJ write SetIntermediadorCNPJ stored False;
    property IntermediadorIdentificacaoLoja: string read FIntermediadorIdentificacaoLoja write SetIntermediadorIdentificacaoLoja stored False;
    property Loja: string read FLoja write SetLoja stored False;
  end;

  TSDPFaturamento = class(TSDPModelo)
  private
    FNumero: string;
    FSerie: string;
    FChaveNFe: string;
    FXMLNFe: string;
    FData: string;
    procedure SetNumero(const Value: string);
    procedure SetSerie(const Value: string);
    procedure SetChaveNFe(const Value: string);
    procedure SetXMLNFe(const Value: string);
    procedure SetData(const Value: string);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Limpar; override;
    procedure LerJSON(J: TACBrJSONObject); override;
    function GerarJSON: string; override;
  published
    property Numero: string read FNumero write SetNumero stored False;
    property Serie: string read FSerie write SetSerie stored False;
    property ChaveNFe: string read FChaveNFe write SetChaveNFe stored False;
    property XMLNFe: string read FXMLNFe write SetXMLNFe stored False;
    property Data: string read FData write SetData stored False;
  end;

  TSDPPedido = class(TSDPModelo)
  private
    FIntegracaoID: string;
    FPedidoID: string;
    FObservacoes: string;
    FTipoME: string;
    FCarrinhoML: string;
    FDataPedido: TDateTime;
    FUltimaAtualizacao: TDateTime;
    FStatus: string;
    FSituacaoPersonalizadaID: Integer;
    FSituacaoPersonalizadaNome: string;
    FVendedorID: string;
    FPaisOrigem: string;
    FMoeda: string;
    FMoedaCotacaoReais: Double;
    FEntregaStatus: string;
    FEtiquetaDisponivel: Boolean;
    FFaturamentoHorario: string;
    FNFPlataforma: string;
    FTotalSemFrete: Currency;
    FTotalFrete: Currency;
    FTotalDesconto: Currency;
    FTotalCupom: Currency;
    FCupomNome: string;
    FTotalAcrescimo: Currency;
    FTotalPedido: Currency;
    FPlataformaPaiID: Integer;
    FTipoOperacao: string;
    FCNPJTransportadora: string;
    FPlataformaID: Integer;
    FPlataformaNome: string;
    FProgramaEnvio: string;
    FTemNF: Boolean;
    FProdutos: TSDPItemPedidoLista;
    FPagamentos: TSDPPagamentoLista;
    FPlataforma: TSDPPlataformaPedido;
    FComprador: TSDPComprador;
    FEntrega: TSDPEntrega;
    FFaturamento: TSDPFaturamentoLista;
    procedure SetIntegracaoID(const Value: string);
    procedure SetPedidoID(const Value: string);
    procedure SetObservacoes(const Value: string);
    procedure SetTipoME(const Value: string);
    procedure SetCarrinhoML(const Value: string);
    procedure SetDataPedido(const Value: TDateTime);
    procedure SetUltimaAtualizacao(const Value: TDateTime);
    procedure SetStatus(const Value: string);
    procedure SetSituacaoPersonalizadaID(const Value: Integer);
    procedure SetSituacaoPersonalizadaNome(const Value: string);
    procedure SetVendedorID(const Value: string);
    procedure SetPaisOrigem(const Value: string);
    procedure SetMoeda(const Value: string);
    procedure SetMoedaCotacaoReais(const Value: Double);
    procedure SetEntregaStatus(const Value: string);
    procedure SetEtiquetaDisponivel(const Value: Boolean);
    procedure SetFaturamentoHorario(const Value: string);
    procedure SetNFPlataforma(const Value: string);
    procedure SetTotalSemFrete(const Value: Currency);
    procedure SetTotalFrete(const Value: Currency);
    procedure SetTotalDesconto(const Value: Currency);
    procedure SetTotalCupom(const Value: Currency);
    procedure SetCupomNome(const Value: string);
    procedure SetTotalAcrescimo(const Value: Currency);
    procedure SetTotalPedido(const Value: Currency);
    procedure SetPlataformaPaiID(const Value: Integer);
    procedure SetTipoOperacao(const Value: string);
    procedure SetCNPJTransportadora(const Value: string);
    procedure SetPlataformaID(const Value: Integer);
    procedure SetPlataformaNome(const Value: string);
    procedure SetProgramaEnvio(const Value: string);
    procedure SetTemNF(const Value: Boolean);
    procedure SetProdutos(Value: TSDPItemPedidoLista);
    procedure SetPagamentos(Value: TSDPPagamentoLista);
    procedure SetPlataforma(Value: TSDPPlataformaPedido);
    procedure SetComprador(Value: TSDPComprador);
    procedure SetEntrega(Value: TSDPEntrega);
    procedure SetFaturamento(Value: TSDPFaturamentoLista);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Limpar; override;
    procedure LerJSON(J: TACBrJSONObject); override;
    function GerarJSON: string; override;
  published
    property IntegracaoID: string read FIntegracaoID write SetIntegracaoID stored False;
    property PedidoID: string read FPedidoID write SetPedidoID stored False;
    property Observacoes: string read FObservacoes write SetObservacoes stored False;
    property TipoME: string read FTipoME write SetTipoME stored False;
    property CarrinhoML: string read FCarrinhoML write SetCarrinhoML stored False;
    property DataPedido: TDateTime read FDataPedido write SetDataPedido stored False;
    property UltimaAtualizacao: TDateTime read FUltimaAtualizacao write SetUltimaAtualizacao stored False;
    property Status: string read FStatus write SetStatus stored False;
    property SituacaoPersonalizadaID: Integer read FSituacaoPersonalizadaID write SetSituacaoPersonalizadaID stored False;
    property SituacaoPersonalizadaNome: string read FSituacaoPersonalizadaNome write SetSituacaoPersonalizadaNome stored False;
    property VendedorID: string read FVendedorID write SetVendedorID stored False;
    property PaisOrigem: string read FPaisOrigem write SetPaisOrigem stored False;
    property Moeda: string read FMoeda write SetMoeda stored False;
    property MoedaCotacaoReais: Double read FMoedaCotacaoReais write SetMoedaCotacaoReais stored False;
    property EntregaStatus: string read FEntregaStatus write SetEntregaStatus stored False;
    property EtiquetaDisponivel: Boolean read FEtiquetaDisponivel write SetEtiquetaDisponivel stored False;
    property FaturamentoHorario: string read FFaturamentoHorario write SetFaturamentoHorario stored False;
    property NFPlataforma: string read FNFPlataforma write SetNFPlataforma stored False;
    property TotalSemFrete: Currency read FTotalSemFrete write SetTotalSemFrete stored False;
    property TotalFrete: Currency read FTotalFrete write SetTotalFrete stored False;
    property TotalDesconto: Currency read FTotalDesconto write SetTotalDesconto stored False;
    property TotalCupom: Currency read FTotalCupom write SetTotalCupom stored False;
    property CupomNome: string read FCupomNome write SetCupomNome stored False;
    property TotalAcrescimo: Currency read FTotalAcrescimo write SetTotalAcrescimo stored False;
    property TotalPedido: Currency read FTotalPedido write SetTotalPedido stored False;
    property PlataformaPaiID: Integer read FPlataformaPaiID write SetPlataformaPaiID stored False;
    property TipoOperacao: string read FTipoOperacao write SetTipoOperacao stored False;
    property CNPJTransportadora: string read FCNPJTransportadora write SetCNPJTransportadora stored False;
    property PlataformaID: Integer read FPlataformaID write SetPlataformaID stored False;
    property PlataformaNome: string read FPlataformaNome write SetPlataformaNome stored False;
    property ProgramaEnvio: string read FProgramaEnvio write SetProgramaEnvio stored False;
    property TemNF: Boolean read FTemNF write SetTemNF stored False;
    property Produtos: TSDPItemPedidoLista read FProdutos write SetProdutos stored False;
    property Pagamentos: TSDPPagamentoLista read FPagamentos write SetPagamentos stored False;
    property Plataforma: TSDPPlataformaPedido read FPlataforma write SetPlataforma stored False;
    property Comprador: TSDPComprador read FComprador write SetComprador stored False;
    property Entrega: TSDPEntrega read FEntrega write SetEntrega stored False;
    property Faturamento: TSDPFaturamentoLista read FFaturamento write SetFaturamento stored False;
  end;

  TSDPFilaPedido = class(TSDPModelo)
  private
    FFilaID: string;
    FPlataformaID: Integer;
    FPedidoID: string;
    FIntegracaoID: string;
    procedure SetFilaID(const Value: string);
    procedure SetPlataformaID(const Value: Integer);
    procedure SetPedidoID(const Value: string);
    procedure SetIntegracaoID(const Value: string);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Limpar; override;
    procedure LerJSON(J: TACBrJSONObject); override;
    function GerarJSON: string; override;
  published
    property FilaID: string read FFilaID write SetFilaID stored False;
    property PlataformaID: Integer read FPlataformaID write SetPlataformaID stored False;
    property PedidoID: string read FPedidoID write SetPedidoID stored False;
    property IntegracaoID: string read FIntegracaoID write SetIntegracaoID stored False;
  end;

  TSDPAtualizacaoStatus = class(TSDPModelo)
  private
    FStatus: string;
    FRastreio: string;
    FSerie: string;
    FNF: string;
    FEspecie: string;
    FData: string;
    FChaveNFe: string;
    FProdutoCFOP: string;
    FIE: string;
    FXMLNFe: string;
    FXMLNFeBytes: AnsiString;
    FTransportadora: string;
    FFormaEnvio: string;
    FRastreioURL: string;
    procedure SetStatus(const Value: string);
    procedure SetRastreio(const Value: string);
    procedure SetSerie(const Value: string);
    procedure SetNF(const Value: string);
    procedure SetEspecie(const Value: string);
    procedure SetData(const Value: string);
    procedure SetChaveNFe(const Value: string);
    procedure SetProdutoCFOP(const Value: string);
    procedure SetIE(const Value: string);
    procedure SetXMLNFe(const Value: string);
    procedure SetTransportadora(const Value: string);
    procedure SetFormaEnvio(const Value: string);
    procedure SetRastreioURL(const Value: string);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Limpar; override;
    procedure Assign(Source: TPersistent); override;
    procedure LerJSON(J: TACBrJSONObject); override;
    function GerarJSON: string; override;
    { Carrega o XML assinado como bytes (ex.: TFileStream do arquivo), sem
      conversao de codificacao: os bytes enviados sao os mesmos do arquivo
      assinado em qualquer compilador. Recomendado no Delphi 7. Retira o BOM
      UTF-8, se houver. Atribuir XMLNFe depois descarta os bytes carregados. }
    procedure CarregarXMLNFe(AStream: TStream);
    property XMLNFeBytes: AnsiString read FXMLNFeBytes;
  published
    property Status: string read FStatus write SetStatus stored False;
    property Rastreio: string read FRastreio write SetRastreio stored False;
    property Serie: string read FSerie write SetSerie stored False;
    property NF: string read FNF write SetNF stored False;
    property Especie: string read FEspecie write SetEspecie stored False;
    property Data: string read FData write SetData stored False;
    property ChaveNFe: string read FChaveNFe write SetChaveNFe stored False;
    property ProdutoCFOP: string read FProdutoCFOP write SetProdutoCFOP stored False;
    property IE: string read FIE write SetIE stored False;
    { XML original (sem Base64). Em compiladores nao Unicode (Delphi 7) a string
      e ANSI: caracteres fora da pagina de codigo do sistema seriam perdidos;
      nesse caso use CarregarXMLNFe. }
    property XMLNFe: string read FXMLNFe write SetXMLNFe stored False;
    property Transportadora: string read FTransportadora write SetTransportadora stored False;
    property FormaEnvio: string read FFormaEnvio write SetFormaEnvio stored False;
    property RastreioURL: string read FRastreioURL write SetRastreioURL stored False;
  end;

  TSDPEtiqueta = class(TSDPModelo)
  private
    FPedidoID: string;
    FPlataformaID: Integer;
    FTipo: string;
    FSucesso: Boolean;
    FConteudo: string;
    FZPL: string;
    FMensagem: string;
    procedure SetPedidoID(const Value: string);
    procedure SetPlataformaID(const Value: Integer);
    procedure SetTipo(const Value: string);
    procedure SetSucesso(const Value: Boolean);
    procedure SetConteudo(const Value: string);
    procedure SetZPL(const Value: string);
    procedure SetMensagem(const Value: string);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Limpar; override;
    procedure LerJSON(J: TACBrJSONObject); override;
    function GerarJSON: string; override;
  published
    property PedidoID: string read FPedidoID write SetPedidoID stored False;
    property PlataformaID: Integer read FPlataformaID write SetPlataformaID stored False;
    property Tipo: string read FTipo write SetTipo stored False;
    property Sucesso: Boolean read FSucesso write SetSucesso stored False;
    property Conteudo: string read FConteudo write SetConteudo stored False;
    property ZPL: string read FZPL write SetZPL stored False;
    property Mensagem: string read FMensagem write SetMensagem stored False;
  end;

{ Auxiliares de montagem e leitura do JSON da API, usados pelas units do
  componente. Sao publicos: alteracoes de assinatura seguem o ciclo de
  depreciacao do ACBr. }
function SDPQuote(const S: string): string;

function SDPIsNull(J: TACBrJSONObject; const Campo: string): Boolean;

function SDPNumero(Value: Extended): string;

function SDPBool(Value: Boolean): string;

function SDPData(const S: string): TDateTime;

procedure SDPPar(var Dest: string; const Nome, ValorJSON: string);

implementation

uses
  ACBrUtil.Strings, ACBrUtil.DateTime;

function SDPIsNull(J: TACBrJSONObject; const Campo: string): Boolean;
begin
  Result := TACBrJSONValueAs.IsNull(J.AsValue[Campo]);
end;

function SDPQuote(const S: string): string;
var
  I, Inicio: Integer;
  Escape: string;
begin
  { Copia os trechos sem escape de uma vez (textos longos, ex.: descricao HTML) }
  Result := '"';
  Inicio := 1;
  for I := 1 to Length(S) do
  begin
    case S[I] of
      '"': Escape := '\"';
      '\': Escape := '\\';
      #8: Escape := '\b';
      #9: Escape := '\t';
      #10: Escape := '\n';
      #12: Escape := '\f';
      #13: Escape := '\r';
    else
      if Ord(S[I]) < 32 then
        Escape := '\u' + IntToHex(Ord(S[I]), 4)
      else
        Continue;
    end;

    Result := Result + Copy(S, Inicio, I - Inicio) + Escape;
    Inicio := I + 1;
  end;
  Result := Result + Copy(S, Inicio, MaxInt) + '"';
end;

function SDPNumero(Value: Extended): string;
begin
  Str(Value:0:8, Result);
  while (Length(Result) > 0) and (Result[Length(Result)] = '0') do
    Delete(Result, Length(Result), 1);

  if (Length(Result) > 0) and (Result[Length(Result)] = '.') then
    Delete(Result, Length(Result), 1);
end;

function SDPBool(Value: Boolean): string;
begin
  if Value then
    Result := 'true'
  else
    Result := 'false';
end;

function SDPData(const S: string): TDateTime;
var
  I: Integer;
  Sufixo: string;

  procedure Invalida;
  begin
    raise EACBrShoppingPrecos.Create('Data ISO invalida: ' + S);
  end;

  function Parte(Inicio, Tamanho: Integer): Word;
  var
    N: Integer;
  begin
    N := StrToIntDef(Copy(S, Inicio, Tamanho), -1);

    if N < 0 then
      Invalida;

    Result := N;
  end;

  function EhFuso(const Fuso: string): Boolean;
  var
    H, M: Integer;
  begin
    Result := (Fuso = 'Z');

    if Result or (Length(Fuso) <> 6) or (Fuso[4] <> ':') or
       not ((Fuso[1] = '+') or (Fuso[1] = '-')) then
      Exit;

    H := StrToIntDef(Copy(Fuso, 2, 2), -1);
    M := StrToIntDef(Copy(Fuso, 5, 2), -1);
    Result := (H >= 0) and (H <= 14) and (M >= 0) and (M <= 59);
  end;

begin
  Result := 0;

  if S = '' then
    Exit;

  { Data zerada do MySQL/PHP ("0000-00-00" ou "0000-00-00 00:00:00"):
    a API usa para "nao informada". }
  if Copy(S, 1, 10) = '0000-00-00' then
    Exit;

  { Aceita "aaaa-mm-dd", "aaaa-mm-dd hh:nn:ss" ou "aaaa-mm-ddThh:nn:ss",
    seguido opcionalmente de fracao de segundos e de fuso ("Z", "+hh:mm" ou
    "-hh:mm"). A hora e devolvida como a API enviou (horario da plataforma):
    o fuso e validado, mas nao converte a hora para o fuso da maquina. }
  if (Length(S) < 10) or (S[5] <> '-') or (S[8] <> '-') then
    Invalida;

  if (Length(S) > 10) and
     ((Length(S) < 19) or not ((S[11] = ' ') or (S[11] = 'T')) or
      (S[14] <> ':') or (S[17] <> ':')) then
    Invalida;

  if Length(S) > 19 then
  begin
    Sufixo := Copy(S, 20, MaxInt);

    if Sufixo[1] = '.' then
    begin
      I := 2;
      while (I <= Length(Sufixo)) and (Sufixo[I] >= '0') and (Sufixo[I] <= '9') do
        Inc(I);

      if I = 2 then
        Invalida;

      Delete(Sufixo, 1, I - 1);
    end;

    if (Sufixo <> '') and not EhFuso(Sufixo) then
      Invalida;
  end;

  try
    Result := EncodeDate(Parte(1, 4), Parte(6, 2), Parte(9, 2));

    if Length(S) >= 19 then
      Result := Result + EncodeTime(Parte(12, 2), Parte(15, 2), Parte(18, 2), 0);
  except
    on E: EConvertError do
      raise EACBrShoppingPrecos.Create('Data ISO invalida: ' + S);
  end;
end;

procedure SDPPar(var Dest: string; const Nome, ValorJSON: string);
begin
  if Dest <> '' then
    Dest := Dest + ',';

  Dest := Dest + SDPQuote(Nome) + ':' + ValorJSON;
end;

{ TSDPModelo }

constructor TSDPModelo.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FInformados := TStringList.Create;
  FNulos := TStringList.Create;
end;

destructor TSDPModelo.Destroy;
begin
  FNulos.Free;
  FInformados.Free;
  inherited Destroy;
end;

procedure TSDPModelo.Informar(const Campo: string);
var
  I: Integer;
begin
  if FInformados.IndexOf(Campo) < 0 then
    FInformados.Add(Campo);

  I := FNulos.IndexOf(Campo);

  if I >= 0 then
    FNulos.Delete(I);
end;

procedure TSDPModelo.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  { Persistir o JSON preserva ausente/null/zero ao salvar e reabrir o DFM. }
  Filer.DefineProperty('DadosJSON', LerDados, GravarDados, GerarJSON <> '{}');
end;

procedure TSDPModelo.LerDados(Reader: TReader);
var
  J: TACBrJSONObject;
begin
  J := TACBrJSONObject.Parse(Reader.ReadString);
  try
    LerJSON(J);
  finally
    J.Free;
  end;
end;

procedure TSDPModelo.GravarDados(Writer: TWriter);
begin
  Writer.WriteString(GerarJSON);
end;

procedure TSDPModelo.DefinirNulo(const Campo: string);
begin
  Informar(Campo);
  FNulos.Add(Campo);
end;

procedure TSDPModelo.Omitir(const Campo: string);
var
  I: Integer;
begin
  I := FInformados.IndexOf(Campo);

  if I >= 0 then
    FInformados.Delete(I);

  I := FNulos.IndexOf(Campo);

  if I >= 0 then
    FNulos.Delete(I);
end;

function TSDPModelo.EstadoCampo(const Campo: string): TSDPEstadoCampo;
begin
  Result := sdpcAusente;

  if FInformados.IndexOf(Campo) >= 0 then
    Result := sdpcValor;

  if FNulos.IndexOf(Campo) >= 0 then
    Result := sdpcNulo;
end;

procedure TSDPModelo.Emitir(var JSON: string; const Campo, Valor: string);
begin
  case EstadoCampo(Campo) of
    sdpcNulo: SDPPar(JSON, Campo, 'null');
    sdpcValor: SDPPar(JSON, Campo, Valor);
  end;
end;

function TSDPModelo.LerCampo(J: TACBrJSONObject; const Campo: string): Boolean;
begin
  Result := False;

  if EstadoCampo(Campo) = sdpcAusente then
    Exit;

  if SDPIsNull(J, Campo) then
    DefinirNulo(Campo)
  else
    Result := True;
end;

procedure TSDPModelo.Limpar;
begin
  FInformados.Clear;
  FNulos.Clear;
  FJSONOriginal := '';
end;

procedure TSDPModelo.LerJSON(J: TACBrJSONObject);
var
  I, Inicio, Nivel: Integer;
  Chave: string;
begin
  Limpar;
  FJSONOriginal := J.ToJSON;
  { ValueExists do ACBr trata null como ausente. Percorrer as chaves do
    objeto serializado preserva a diferenca sem depender do backend JSON. }
  I := 1;
  Nivel := 0;
  while I <= Length(FJSONOriginal) do
  begin
    case FJSONOriginal[I] of
      '{', '[': Inc(Nivel);
      '}', ']': Dec(Nivel);
      '"':
        begin
          Inicio := I + 1;
          Inc(I);
          while I <= Length(FJSONOriginal) do
          begin
            if FJSONOriginal[I] = '\' then
              Inc(I)
            else if FJSONOriginal[I] = '"' then
              Break;
            Inc(I);
          end;
          Chave := Copy(FJSONOriginal, Inicio, I - Inicio);
          Inc(I);
          while (I <= Length(FJSONOriginal)) and
            (Ord(FJSONOriginal[I]) in [9, 10, 13, 32]) do Inc(I);

          if (Nivel = 1) and (I <= Length(FJSONOriginal)) and
            (FJSONOriginal[I] = ':') then
              Informar(Chave);
          Continue;
        end;
    end;
    Inc(I);
  end;
end;

procedure TSDPModelo.Assign(Source: TPersistent);
var
  J: TACBrJSONObject;
begin
  if Source is TSDPModelo then
  begin
    J := TACBrJSONObject.Parse(TSDPModelo(Source).GerarJSON);
    try
      LerJSON(J);
      FJSONOriginal := TSDPModelo(Source).JSONOriginal;
    finally
      J.Free;
    end;
  end
  else
    inherited Assign(Source);
end;

{ TSDPListaAPI }

procedure TSDPListaAPI.LerJSON(A: TACBrJSONArray);
var
  I: Integer;
begin
  Clear;
  try
    for I := 0 to A.Count - 1 do
      TSDPModelo(inherited Add).LerJSON(A.ItemAsJSONObject[I]);
  except
    Clear;
    raise;
  end;
end;

function TSDPListaAPI.GerarJSON: string;
var
  I: Integer;
begin
  Result := '[';
  for I := 0 to Count - 1 do
  begin
    if I > 0 then
      Result := Result + ',';

    Result := Result + TSDPModelo(Items[I]).GerarJSON;
  end;
  Result := Result + ']';
end;

{ TSDPImagem }

constructor TSDPImagem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
end;

destructor TSDPImagem.Destroy;
begin
  inherited Destroy;
end;

procedure TSDPImagem.Limpar;
begin
  inherited Limpar;
  FURL := '';
  FEtiqueta := '';
end;

procedure TSDPImagem.SetURL(const Value: string);
begin
  FURL := Value;
  Informar('url');
end;

procedure TSDPImagem.SetEtiqueta(const Value: string);
begin
  FEtiqueta := Value;
  Informar('label');
end;

procedure TSDPImagem.LerJSON(J: TACBrJSONObject);
begin
  inherited LerJSON(J);

  if LerCampo(J, 'url') then
    URL := J.AsString['url'];

  if LerCampo(J, 'label') then
    Etiqueta := J.AsString['label'];
end;

function TSDPImagem.GerarJSON: string;
begin
  Result := '';
  Emitir(Result, 'url', SDPQuote(FURL));
  Emitir(Result, 'label', SDPQuote(FEtiqueta));
  Result := '{' + Result + '}';
end;

{ TSDPImagemLista }

constructor TSDPImagemLista.Create;
begin
  inherited Create(TSDPImagem);
end;

function TSDPImagemLista.Add: TSDPImagem;
begin
  Result := TSDPImagem(inherited Add);
end;

function TSDPImagemLista.GetItem(Index: Integer): TSDPImagem;
begin
  Result := TSDPImagem(inherited Items[Index]);
end;

{ TSDPAtributo }

constructor TSDPAtributo.Create(Collection: TCollection);
begin
  inherited Create(Collection);
end;

destructor TSDPAtributo.Destroy;
begin
  inherited Destroy;
end;

procedure TSDPAtributo.Limpar;
begin
  inherited Limpar;
  FTipo := '';
  FValor := '';
end;

procedure TSDPAtributo.SetTipo(const Value: string);
begin
  FTipo := Value;
  Informar('tipo');
end;

procedure TSDPAtributo.SetValor(const Value: string);
begin
  FValor := Value;
  Informar('valor');
end;

procedure TSDPAtributo.LerJSON(J: TACBrJSONObject);
begin
  inherited LerJSON(J);

  if LerCampo(J, 'tipo') then
    Tipo := J.AsString['tipo'];

  if LerCampo(J, 'valor') then
    Valor := J.AsString['valor'];
end;

function TSDPAtributo.GerarJSON: string;
begin
  Result := '';
  Emitir(Result, 'tipo', SDPQuote(FTipo));
  Emitir(Result, 'valor', SDPQuote(FValor));
  Result := '{' + Result + '}';
end;

{ TSDPAtributoLista }

constructor TSDPAtributoLista.Create;
begin
  inherited Create(TSDPAtributo);
end;

function TSDPAtributoLista.Add: TSDPAtributo;
begin
  Result := TSDPAtributo(inherited Add);
end;

function TSDPAtributoLista.GetItem(Index: Integer): TSDPAtributo;
begin
  Result := TSDPAtributo(inherited Items[Index]);
end;

{ TSDPItemKit }

constructor TSDPItemKit.Create(Collection: TCollection);
begin
  inherited Create(Collection);
end;

destructor TSDPItemKit.Destroy;
begin
  inherited Destroy;
end;

procedure TSDPItemKit.Limpar;
begin
  inherited Limpar;
  FSKU := '';
  FQuantidade := 0;
  FPercentualValor := 0;
end;

procedure TSDPItemKit.SetSKU(const Value: string);
begin
  FSKU := Value;
  Informar('sku');
end;

procedure TSDPItemKit.SetQuantidade(const Value: Integer);
begin
  FQuantidade := Value;
  Informar('qtde_itens');
end;

procedure TSDPItemKit.SetPercentualValor(const Value: Currency);
begin
  FPercentualValor := Value;
  Informar('percentual_valor_kit');
end;

procedure TSDPItemKit.LerJSON(J: TACBrJSONObject);
begin
  inherited LerJSON(J);

  if LerCampo(J, 'sku') then
    SKU := J.AsString['sku'];

  if LerCampo(J, 'qtde_itens') then
    Quantidade := J.AsInteger['qtde_itens'];

  if LerCampo(J, 'percentual_valor_kit') then
    PercentualValor := J.AsCurrency['percentual_valor_kit'];
end;

function TSDPItemKit.GerarJSON: string;
begin
  Result := '';
  Emitir(Result, 'sku', SDPQuote(FSKU));
  Emitir(Result, 'qtde_itens', IntToStr(FQuantidade));
  Emitir(Result, 'percentual_valor_kit', SDPNumero(FPercentualValor));
  Result := '{' + Result + '}';
end;

{ TSDPItemKitLista }

constructor TSDPItemKitLista.Create;
begin
  inherited Create(TSDPItemKit);
end;

function TSDPItemKitLista.Add: TSDPItemKit;
begin
  Result := TSDPItemKit(inherited Add);
end;

function TSDPItemKitLista.GetItem(Index: Integer): TSDPItemKit;
begin
  Result := TSDPItemKit(inherited Items[Index]);
end;

{ TSDPVariacao }

constructor TSDPVariacao.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FImagens := TSDPImagemLista.Create;
  FAtributos := TSDPAtributoLista.Create;
end;

destructor TSDPVariacao.Destroy;
begin
  FImagens.Free;
  FAtributos.Free;
  inherited Destroy;
end;

procedure TSDPVariacao.Limpar;
begin
  inherited Limpar;
  FSKU := '';
  FEAN := '';
  FPreco := 0;
  FPrecoCusto := 0;
  FEstoque := 0;
  FLarguraCm := 0;
  FAlturaCm := 0;
  FComprimentoCm := 0;
  FPesoKg := 0;
  FImagens.Clear;
  FAtributos.Clear;
end;

procedure TSDPVariacao.SetSKU(const Value: string);
begin
  FSKU := Value;
  Informar('sku');
end;

procedure TSDPVariacao.SetEAN(const Value: string);
begin
  FEAN := Value;
  Informar('ean');
end;

procedure TSDPVariacao.SetPreco(const Value: Currency);
begin
  FPreco := Value;
  Informar('preco');
end;

procedure TSDPVariacao.SetPrecoCusto(const Value: Currency);
begin
  FPrecoCusto := Value;
  Informar('PrecoCusto');
end;

procedure TSDPVariacao.SetEstoque(const Value: Integer);
begin
  FEstoque := Value;
  Informar('estoque');
end;

procedure TSDPVariacao.SetLarguraCm(const Value: Double);
begin
  FLarguraCm := Value;
  Informar('LarguraCm');
end;

procedure TSDPVariacao.SetAlturaCm(const Value: Double);
begin
  FAlturaCm := Value;
  Informar('AlturaCm');
end;

procedure TSDPVariacao.SetComprimentoCm(const Value: Double);
begin
  FComprimentoCm := Value;
  Informar('ComprimentoCm');
end;

procedure TSDPVariacao.SetPesoKg(const Value: Double);
begin
  FPesoKg := Value;
  Informar('PesoKg');
end;

procedure TSDPVariacao.SetImagens(Value: TSDPImagemLista);
begin
  FImagens.Assign(Value);
end;

procedure TSDPVariacao.SetAtributos(Value: TSDPAtributoLista);
begin
  FAtributos.Assign(Value);
end;

procedure TSDPVariacao.LerJSON(J: TACBrJSONObject);
begin
  inherited LerJSON(J);

  if LerCampo(J, 'sku') then
    SKU := J.AsString['sku'];

  if LerCampo(J, 'ean') then
    EAN := J.AsString['ean'];

  if LerCampo(J, 'preco') then
    Preco := J.AsCurrency['preco'];

  if LerCampo(J, 'PrecoCusto') then
    PrecoCusto := J.AsCurrency['PrecoCusto'];

  if LerCampo(J, 'estoque') then
    Estoque := J.AsInteger['estoque'];

  if LerCampo(J, 'LarguraCm') then
    LarguraCm := J.AsFloat['LarguraCm'];

  if LerCampo(J, 'AlturaCm') then
    AlturaCm := J.AsFloat['AlturaCm'];

  if LerCampo(J, 'ComprimentoCm') then
    ComprimentoCm := J.AsFloat['ComprimentoCm'];

  if LerCampo(J, 'PesoKg') then
    PesoKg := J.AsFloat['PesoKg'];

  if J.IsJSONArray('Imagens') then
    FImagens.LerJSON(J.AsJSONArray['Imagens']);

  if J.IsJSONArray('Atributos') then
    FAtributos.LerJSON(J.AsJSONArray['Atributos']);
end;

function TSDPVariacao.GerarJSON: string;
begin
  Result := '';
  Emitir(Result, 'sku', SDPQuote(FSKU));
  Emitir(Result, 'ean', SDPQuote(FEAN));
  Emitir(Result, 'preco', SDPQuote(SDPNumero(FPreco)));
  Emitir(Result, 'PrecoCusto', SDPNumero(FPrecoCusto));
  Emitir(Result, 'estoque', SDPQuote(IntToStr(FEstoque)));
  Emitir(Result, 'LarguraCm', SDPQuote(SDPNumero(FLarguraCm)));
  Emitir(Result, 'AlturaCm', SDPQuote(SDPNumero(FAlturaCm)));
  Emitir(Result, 'ComprimentoCm', SDPQuote(SDPNumero(FComprimentoCm)));
  Emitir(Result, 'PesoKg', SDPQuote(SDPNumero(FPesoKg)));

  if FImagens.Count > 0 then
    SDPPar(Result, 'Imagens', FImagens.GerarJSON);

  if FAtributos.Count > 0 then
    SDPPar(Result, 'Atributos', FAtributos.GerarJSON);

  Result := '{' + Result + '}';
end;

{ TSDPVariacaoLista }

constructor TSDPVariacaoLista.Create;
begin
  inherited Create(TSDPVariacao);
end;

function TSDPVariacaoLista.Add: TSDPVariacao;
begin
  Result := TSDPVariacao(inherited Add);
end;

function TSDPVariacaoLista.GetItem(Index: Integer): TSDPVariacao;
begin
  Result := TSDPVariacao(inherited Items[Index]);
end;

{ TSDPProduto }

constructor TSDPProduto.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FImagens := TSDPImagemLista.Create;
  FAtributos := TSDPAtributoLista.Create;
  FVariacoes := TSDPVariacaoLista.Create;
  FItensKit := TSDPItemKitLista.Create;
end;

destructor TSDPProduto.Destroy;
begin
  FImagens.Free;
  FAtributos.Free;
  FVariacoes.Free;
  FItensKit.Free;
  inherited Destroy;
end;

procedure TSDPProduto.Limpar;
begin
  inherited Limpar;
  FSKU := '';
  FTitulo := '';
  FMarca := '';
  FCategoria := '';
  FDescricao := '';
  FPreco := 0;
  FPrecoCusto := 0;
  FPrecoPromocao := 0;
  FInicioPromocao := 0;
  FTerminoPromocao := 0;
  FEstoque := 0;
  FVideo := '';
  FGarantia := '';
  FFabricante := '';
  FLarguraCm := 0;
  FAlturaCm := 0;
  FComprimentoCm := 0;
  FPesoKg := 0;
  FLarguraEmbalagemCm := 0;
  FAlturaEmbalagemCm := 0;
  FComprimentoEmbalagemCm := 0;
  FPesoEmbalagemKg := 0;
  FDescricaoCurta := '';
  FMetaTag := '';
  FMetaTitle := '';
  FMetaDescription := '';
  FCEST := '';
  FOrigem := 0;
  FUnidadeMedida := '';
  FCSOSN := '';
  FNCM := '';
  FEAN := '';
  FKit := False;
  FCodigoAnvisa := '';
  FCodigoInmetro := '';
  FCodigoMapa := '';
  FImagens.Clear;
  FAtributos.Clear;
  FVariacoes.Clear;
  FItensKit.Clear;
end;

procedure TSDPProduto.SetSKU(const Value: string);
begin
  FSKU := Value;
  Informar('SKU');
end;

procedure TSDPProduto.SetTitulo(const Value: string);
begin
  FTitulo := Value;
  Informar('Titulo');
end;

procedure TSDPProduto.SetMarca(const Value: string);
begin
  FMarca := Value;
  Informar('Marca');
end;

procedure TSDPProduto.SetCategoria(const Value: string);
begin
  FCategoria := Value;
  Informar('Categoria');
end;

procedure TSDPProduto.SetDescricao(const Value: string);
begin
  FDescricao := Value;
  Informar('Descricao');
end;

procedure TSDPProduto.SetPreco(const Value: Currency);
begin
  FPreco := Value;
  Informar('Preco');
end;

procedure TSDPProduto.SetPrecoCusto(const Value: Currency);
begin
  FPrecoCusto := Value;
  Informar('PrecoCusto');
end;

procedure TSDPProduto.SetPrecoPromocao(const Value: Currency);
begin
  FPrecoPromocao := Value;
  Informar('PrecoPromocao');
end;

procedure TSDPProduto.SetInicioPromocao(const Value: TDateTime);
begin
  FInicioPromocao := Value;
  Informar('InicioPromocao');
end;

procedure TSDPProduto.SetTerminoPromocao(const Value: TDateTime);
begin
  FTerminoPromocao := Value;
  Informar('TerminoPromocao');
end;

procedure TSDPProduto.SetEstoque(const Value: Integer);
begin
  FEstoque := Value;
  Informar('Estoque');
end;

procedure TSDPProduto.SetVideo(const Value: string);
begin
  FVideo := Value;
  Informar('Video');
end;

procedure TSDPProduto.SetGarantia(const Value: string);
begin
  FGarantia := Value;
  Informar('Garantia');
end;

procedure TSDPProduto.SetFabricante(const Value: string);
begin
  FFabricante := Value;
  Informar('Fabricante');
end;

procedure TSDPProduto.SetLarguraCm(const Value: Double);
begin
  FLarguraCm := Value;
  Informar('LarguraCm');
end;

procedure TSDPProduto.SetAlturaCm(const Value: Double);
begin
  FAlturaCm := Value;
  Informar('AlturaCm');
end;

procedure TSDPProduto.SetComprimentoCm(const Value: Double);
begin
  FComprimentoCm := Value;
  Informar('ComprimentoCm');
end;

procedure TSDPProduto.SetPesoKg(const Value: Double);
begin
  FPesoKg := Value;
  Informar('PesoKg');
end;

procedure TSDPProduto.SetLarguraEmbalagemCm(const Value: Double);
begin
  FLarguraEmbalagemCm := Value;
  Informar('LarguraEmbalagemCm');
end;

procedure TSDPProduto.SetAlturaEmbalagemCm(const Value: Double);
begin
  FAlturaEmbalagemCm := Value;
  Informar('AlturaEmbalagemCm');
end;

procedure TSDPProduto.SetComprimentoEmbalagemCm(const Value: Double);
begin
  FComprimentoEmbalagemCm := Value;
  Informar('ComprimentoEmbalagemCm');
end;

procedure TSDPProduto.SetPesoEmbalagemKg(const Value: Double);
begin
  FPesoEmbalagemKg := Value;
  Informar('PesoEmbalagemKg');
end;

procedure TSDPProduto.SetDescricaoCurta(const Value: string);
begin
  FDescricaoCurta := Value;
  Informar('DescricaoCurta');
end;

procedure TSDPProduto.SetMetaTag(const Value: string);
begin
  FMetaTag := Value;
  Informar('MetaTag');
end;

procedure TSDPProduto.SetMetaTitle(const Value: string);
begin
  FMetaTitle := Value;
  Informar('MetaTitle');
end;

procedure TSDPProduto.SetMetaDescription(const Value: string);
begin
  FMetaDescription := Value;
  Informar('MetaDescription');
end;

procedure TSDPProduto.SetCEST(const Value: string);
begin
  FCEST := Value;
  Informar('CEST');
end;

procedure TSDPProduto.SetOrigem(const Value: Integer);
begin
  FOrigem := Value;
  Informar('Origem');
end;

procedure TSDPProduto.SetUnidadeMedida(const Value: string);
begin
  FUnidadeMedida := Value;
  Informar('UnidadeMedida');
end;

procedure TSDPProduto.SetCSOSN(const Value: string);
begin
  FCSOSN := Value;
  Informar('CSOSN');
end;

procedure TSDPProduto.SetNCM(const Value: string);
begin
  FNCM := Value;
  Informar('NCM');
end;

procedure TSDPProduto.SetEAN(const Value: string);
begin
  FEAN := Value;
  Informar('EAN');
end;

procedure TSDPProduto.SetKit(const Value: Boolean);
begin
  FKit := Value;
  Informar('Kit');
end;

procedure TSDPProduto.SetCodigoAnvisa(const Value: string);
begin
  FCodigoAnvisa := Value;
  Informar('codigo_anvisa');
end;

procedure TSDPProduto.SetCodigoInmetro(const Value: string);
begin
  FCodigoInmetro := Value;
  Informar('codigo_inmetro');
end;

procedure TSDPProduto.SetCodigoMapa(const Value: string);
begin
  FCodigoMapa := Value;
  Informar('codigo_mapa');
end;

procedure TSDPProduto.SetImagens(Value: TSDPImagemLista);
begin
  FImagens.Assign(Value);
end;

procedure TSDPProduto.SetAtributos(Value: TSDPAtributoLista);
begin
  FAtributos.Assign(Value);
end;

procedure TSDPProduto.SetVariacoes(Value: TSDPVariacaoLista);
begin
  FVariacoes.Assign(Value);
end;

procedure TSDPProduto.SetItensKit(Value: TSDPItemKitLista);
begin
  FItensKit.Assign(Value);
end;

procedure TSDPProduto.LerJSON(J: TACBrJSONObject);
begin
  inherited LerJSON(J);

  if LerCampo(J, 'SKU') then
    SKU := J.AsString['SKU'];

  if LerCampo(J, 'Titulo') then
    Titulo := J.AsString['Titulo'];

  if LerCampo(J, 'Marca') then
    Marca := J.AsString['Marca'];

  if LerCampo(J, 'Categoria') then
    Categoria := J.AsString['Categoria'];

  if LerCampo(J, 'Descricao') then
    Descricao := J.AsString['Descricao'];

  if LerCampo(J, 'Preco') then
    Preco := J.AsCurrency['Preco'];

  if LerCampo(J, 'PrecoCusto') then
    PrecoCusto := J.AsCurrency['PrecoCusto'];

  if LerCampo(J, 'PrecoPromocao') then
    PrecoPromocao := J.AsCurrency['PrecoPromocao'];

  if LerCampo(J, 'InicioPromocao') then
    InicioPromocao := SDPData(J.AsString['InicioPromocao']);

  if LerCampo(J, 'TerminoPromocao') then
    TerminoPromocao := SDPData(J.AsString['TerminoPromocao']);

  if LerCampo(J, 'Estoque') then
    Estoque := J.AsInteger['Estoque'];

  if LerCampo(J, 'Video') then
    Video := J.AsString['Video'];

  if LerCampo(J, 'Garantia') then
    Garantia := J.AsString['Garantia'];

  if LerCampo(J, 'Fabricante') then
    Fabricante := J.AsString['Fabricante'];

  if LerCampo(J, 'LarguraCm') then
    LarguraCm := J.AsFloat['LarguraCm'];

  if LerCampo(J, 'AlturaCm') then
    AlturaCm := J.AsFloat['AlturaCm'];

  if LerCampo(J, 'ComprimentoCm') then
    ComprimentoCm := J.AsFloat['ComprimentoCm'];

  if LerCampo(J, 'PesoKg') then
    PesoKg := J.AsFloat['PesoKg'];

  if LerCampo(J, 'LarguraEmbalagemCm') then
    LarguraEmbalagemCm := J.AsFloat['LarguraEmbalagemCm'];

  if LerCampo(J, 'AlturaEmbalagemCm') then
    AlturaEmbalagemCm := J.AsFloat['AlturaEmbalagemCm'];

  if LerCampo(J, 'ComprimentoEmbalagemCm') then
    ComprimentoEmbalagemCm := J.AsFloat['ComprimentoEmbalagemCm'];

  if LerCampo(J, 'PesoEmbalagemKg') then
    PesoEmbalagemKg := J.AsFloat['PesoEmbalagemKg'];

  if LerCampo(J, 'DescricaoCurta') then
    DescricaoCurta := J.AsString['DescricaoCurta'];

  if LerCampo(J, 'MetaTag') then
    MetaTag := J.AsString['MetaTag'];

  if LerCampo(J, 'MetaTitle') then
    MetaTitle := J.AsString['MetaTitle'];

  if LerCampo(J, 'MetaDescription') then
    MetaDescription := J.AsString['MetaDescription'];

  if LerCampo(J, 'CEST') then
    CEST := J.AsString['CEST'];

  if LerCampo(J, 'Origem') then
    Origem := J.AsInteger['Origem'];

  if LerCampo(J, 'UnidadeMedida') then
    UnidadeMedida := J.AsString['UnidadeMedida'];

  if LerCampo(J, 'CSOSN') then
    CSOSN := J.AsString['CSOSN'];

  if LerCampo(J, 'NCM') then
    NCM := J.AsString['NCM'];

  if LerCampo(J, 'EAN') then
    EAN := J.AsString['EAN'];

  if LerCampo(J, 'Kit') then
    Kit := J.AsBoolean['Kit'];

  if LerCampo(J, 'codigo_anvisa') then
    CodigoAnvisa := J.AsString['codigo_anvisa'];

  if LerCampo(J, 'codigo_inmetro') then
    CodigoInmetro := J.AsString['codigo_inmetro'];

  if LerCampo(J, 'codigo_mapa') then
    CodigoMapa := J.AsString['codigo_mapa'];

  if J.IsJSONArray('Imagens') then
    FImagens.LerJSON(J.AsJSONArray['Imagens']);

  if J.IsJSONArray('Atributos') then
    FAtributos.LerJSON(J.AsJSONArray['Atributos']);

  if J.IsJSONArray('Variacoes') then
    FVariacoes.LerJSON(J.AsJSONArray['Variacoes']);

  if J.IsJSONArray('ItensKit') then
    FItensKit.LerJSON(J.AsJSONArray['ItensKit']);
end;

function TSDPProduto.GerarJSON: string;
begin
  Result := '';
  Emitir(Result, 'SKU', SDPQuote(FSKU));
  Emitir(Result, 'Titulo', SDPQuote(FTitulo));
  Emitir(Result, 'Marca', SDPQuote(FMarca));
  Emitir(Result, 'Categoria', SDPQuote(FCategoria));
  Emitir(Result, 'Descricao', SDPQuote(FDescricao));
  Emitir(Result, 'Preco', SDPQuote(SDPNumero(FPreco)));
  Emitir(Result, 'PrecoCusto', SDPQuote(SDPNumero(FPrecoCusto)));
  Emitir(Result, 'PrecoPromocao', SDPQuote(SDPNumero(FPrecoPromocao)));
  Emitir(Result, 'InicioPromocao', SDPQuote(FormatDateTimeBr(FInicioPromocao, 'yyyy-mm-dd hh:nn:ss')));
  Emitir(Result, 'TerminoPromocao', SDPQuote(FormatDateTimeBr(FTerminoPromocao, 'yyyy-mm-dd hh:nn:ss')));
  Emitir(Result, 'Estoque', SDPQuote(IntToStr(FEstoque)));
  Emitir(Result, 'Video', SDPQuote(FVideo));
  Emitir(Result, 'Garantia', SDPQuote(FGarantia));
  Emitir(Result, 'Fabricante', SDPQuote(FFabricante));
  Emitir(Result, 'LarguraCm', SDPQuote(SDPNumero(FLarguraCm)));
  Emitir(Result, 'AlturaCm', SDPQuote(SDPNumero(FAlturaCm)));
  Emitir(Result, 'ComprimentoCm', SDPQuote(SDPNumero(FComprimentoCm)));
  Emitir(Result, 'PesoKg', SDPQuote(SDPNumero(FPesoKg)));
  Emitir(Result, 'LarguraEmbalagemCm', SDPQuote(SDPNumero(FLarguraEmbalagemCm)));
  Emitir(Result, 'AlturaEmbalagemCm', SDPQuote(SDPNumero(FAlturaEmbalagemCm)));
  Emitir(Result, 'ComprimentoEmbalagemCm', SDPQuote(SDPNumero(FComprimentoEmbalagemCm)));
  Emitir(Result, 'PesoEmbalagemKg', SDPQuote(SDPNumero(FPesoEmbalagemKg)));
  Emitir(Result, 'DescricaoCurta', SDPQuote(FDescricaoCurta));
  Emitir(Result, 'MetaTag', SDPQuote(FMetaTag));
  Emitir(Result, 'MetaTitle', SDPQuote(FMetaTitle));
  Emitir(Result, 'MetaDescription', SDPQuote(FMetaDescription));
  Emitir(Result, 'CEST', SDPQuote(FCEST));
  Emitir(Result, 'Origem', IntToStr(FOrigem));
  Emitir(Result, 'UnidadeMedida', SDPQuote(FUnidadeMedida));
  Emitir(Result, 'CSOSN', SDPQuote(FCSOSN));
  Emitir(Result, 'NCM', SDPQuote(FNCM));
  Emitir(Result, 'EAN', SDPQuote(FEAN));
  Emitir(Result, 'Kit', SDPBool(FKit));
  Emitir(Result, 'codigo_anvisa', SDPQuote(FCodigoAnvisa));
  Emitir(Result, 'codigo_inmetro', SDPQuote(FCodigoInmetro));
  Emitir(Result, 'codigo_mapa', SDPQuote(FCodigoMapa));

  if FImagens.Count > 0 then
    SDPPar(Result, 'Imagens', FImagens.GerarJSON);

  if FAtributos.Count > 0 then
    SDPPar(Result, 'Atributos', FAtributos.GerarJSON);

  if FVariacoes.Count > 0 then
    SDPPar(Result, 'Variacoes', FVariacoes.GerarJSON);

  if FItensKit.Count > 0 then
    SDPPar(Result, 'ItensKit', FItensKit.GerarJSON);

  Result := '{' + Result + '}';
end;

{ TSDPProdutoLista }

constructor TSDPProdutoLista.Create;
begin
  inherited Create(TSDPProduto);
end;

function TSDPProdutoLista.Add: TSDPProduto;
begin
  Result := TSDPProduto(inherited Add);
end;

function TSDPProdutoLista.GetItem(Index: Integer): TSDPProduto;
begin
  Result := TSDPProduto(inherited Items[Index]);
end;

{ TSDPCategoria }

constructor TSDPCategoria.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FFilhos := TSDPCategoriaLista.Create;
end;

destructor TSDPCategoria.Destroy;
begin
  FFilhos.Free;
  inherited Destroy;
end;

procedure TSDPCategoria.Limpar;
begin
  inherited Limpar;
  FID := '';
  FNome := '';
  FDepartamento := '';
  FTemFilhos := False;
  FFilhos.Clear;
end;

procedure TSDPCategoria.SetID(const Value: string);
begin
  FID := Value;
  Informar('id');
end;

procedure TSDPCategoria.SetNome(const Value: string);
begin
  FNome := Value;
  Informar('nome');
end;

procedure TSDPCategoria.SetDepartamento(const Value: string);
begin
  FDepartamento := Value;
  Informar('departamento');
end;

procedure TSDPCategoria.SetTemFilhos(const Value: Boolean);
begin
  FTemFilhos := Value;
  Informar('temFilhos');
end;

procedure TSDPCategoria.SetFilhos(Value: TSDPCategoriaLista);
begin
  FFilhos.Assign(Value);
end;

procedure TSDPCategoria.LerJSON(J: TACBrJSONObject);
begin
  inherited LerJSON(J);

  if LerCampo(J, 'id') then
    ID := J.AsString['id'];

  if LerCampo(J, 'nome') then
    Nome := J.AsString['nome'];

  if LerCampo(J, 'departamento') then
    Departamento := J.AsString['departamento'];

  if LerCampo(J, 'temFilhos') then
    TemFilhos := J.AsBoolean['temFilhos'];

  if J.IsJSONArray('filhos') then
    FFilhos.LerJSON(J.AsJSONArray['filhos']);
end;

function TSDPCategoria.GerarJSON: string;
begin
  Result := '';
  Emitir(Result, 'id', SDPQuote(FID));
  Emitir(Result, 'nome', SDPQuote(FNome));
  Emitir(Result, 'departamento', SDPQuote(FDepartamento));
  Emitir(Result, 'temFilhos', SDPBool(FTemFilhos));

  if FFilhos.Count > 0 then
    SDPPar(Result, 'filhos', FFilhos.GerarJSON);
  Result := '{' + Result + '}';
end;

{ TSDPCategoriaLista }

constructor TSDPCategoriaLista.Create;
begin
  inherited Create(TSDPCategoria);
end;

function TSDPCategoriaLista.Add: TSDPCategoria;
begin
  Result := TSDPCategoria(inherited Add);
end;

function TSDPCategoriaLista.GetItem(Index: Integer): TSDPCategoria;
begin
  Result := TSDPCategoria(inherited Items[Index]);
end;

{ TSDPDimensoes }

constructor TSDPDimensoes.Create(Collection: TCollection);
begin
  inherited Create(Collection);
end;

destructor TSDPDimensoes.Destroy;
begin
  inherited Destroy;
end;

procedure TSDPDimensoes.Limpar;
begin
  inherited Limpar;
  FAltura := 0;
  FLargura := 0;
  FComprimento := 0;
  FPeso := 0;
end;

procedure TSDPDimensoes.SetAltura(const Value: Double);
begin
  FAltura := Value;
  Informar('altura');
end;

procedure TSDPDimensoes.SetLargura(const Value: Double);
begin
  FLargura := Value;
  Informar('largura');
end;

procedure TSDPDimensoes.SetComprimento(const Value: Double);
begin
  FComprimento := Value;
  Informar('comprimento');
end;

procedure TSDPDimensoes.SetPeso(const Value: Double);
begin
  FPeso := Value;
  Informar('peso');
end;

procedure TSDPDimensoes.LerJSON(J: TACBrJSONObject);
begin
  inherited LerJSON(J);

  if LerCampo(J, 'altura') then
    Altura := J.AsFloat['altura'];

  if LerCampo(J, 'largura') then
    Largura := J.AsFloat['largura'];

  if LerCampo(J, 'comprimento') then
    Comprimento := J.AsFloat['comprimento'];

  if LerCampo(J, 'peso') then
    Peso := J.AsFloat['peso'];
end;

function TSDPDimensoes.GerarJSON: string;
begin
  Result := '';
  Emitir(Result, 'altura', SDPNumero(FAltura));
  Emitir(Result, 'largura', SDPNumero(FLargura));
  Emitir(Result, 'comprimento', SDPNumero(FComprimento));
  Emitir(Result, 'peso', SDPNumero(FPeso));
  Result := '{' + Result + '}';
end;

{ TSDPDimensoesLista }

constructor TSDPDimensoesLista.Create;
begin
  inherited Create(TSDPDimensoes);
end;

function TSDPDimensoesLista.Add: TSDPDimensoes;
begin
  Result := TSDPDimensoes(inherited Add);
end;

function TSDPDimensoesLista.GetItem(Index: Integer): TSDPDimensoes;
begin
  Result := TSDPDimensoes(inherited Items[Index]);
end;

{ TSDPItemPedido }

constructor TSDPItemPedido.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FDimensoes := TSDPDimensoes.Create(nil);
  FItensKit := TSDPItemKitLista.Create;
end;

destructor TSDPItemPedido.Destroy;
begin
  FDimensoes.Free;
  FItensKit.Free;
  inherited Destroy;
end;

procedure TSDPItemPedido.Limpar;
begin
  inherited Limpar;
  FSequencia := 0;
  FSKU := '';
  FSKUErp := '';
  FNumeroSerial := '';
  FMLB := '';
  FFoto := '';
  FEAN := '';
  FVariacaoID := '';
  FDescricao := '';
  FDescricaoVariacao := '';
  FObservacao := '';
  FQuantidade := 0;
  FValorUnitario := 0;
  FDesconto := 0;
  FValorTotal := 0;
  FTarifaVenda := 0;
  FPercentualComissao := 0;
  FTipoAnuncio := '';
  FEmbalagemPresente := False;
  FKit := False;
  FRebate := 0;
  FDepositoID := '';
  FDimensoes.Limpar;
  FItensKit.Clear;
end;

procedure TSDPItemPedido.SetSequencia(const Value: Integer);
begin
  FSequencia := Value;
  Informar('sequencia');
end;

procedure TSDPItemPedido.SetSKU(const Value: string);
begin
  FSKU := Value;
  Informar('sku');
end;

procedure TSDPItemPedido.SetSKUErp(const Value: string);
begin
  FSKUErp := Value;
  Informar('sku_erp');
end;

procedure TSDPItemPedido.SetNumeroSerial(const Value: string);
begin
  FNumeroSerial := Value;
  Informar('numero_serial');
end;

procedure TSDPItemPedido.SetMLB(const Value: string);
begin
  FMLB := Value;
  Informar('mlb');
end;

procedure TSDPItemPedido.SetFoto(const Value: string);
begin
  FFoto := Value;
  Informar('foto');
end;

procedure TSDPItemPedido.SetEAN(const Value: string);
begin
  FEAN := Value;
  Informar('ean');
end;

procedure TSDPItemPedido.SetVariacaoID(const Value: string);
begin
  FVariacaoID := Value;
  Informar('variacao_id');
end;

procedure TSDPItemPedido.SetDescricao(const Value: string);
begin
  FDescricao := Value;
  Informar('descricao');
end;

procedure TSDPItemPedido.SetDescricaoVariacao(const Value: string);
begin
  FDescricaoVariacao := Value;
  Informar('descricao_variacao');
end;

procedure TSDPItemPedido.SetObservacao(const Value: string);
begin
  FObservacao := Value;
  Informar('observacao');
end;

procedure TSDPItemPedido.SetQuantidade(const Value: Double);
begin
  FQuantidade := Value;
  Informar('qtde');
end;

procedure TSDPItemPedido.SetValorUnitario(const Value: Currency);
begin
  FValorUnitario := Value;
  Informar('valor_unitario');
end;

procedure TSDPItemPedido.SetDesconto(const Value: Currency);
begin
  FDesconto := Value;
  Informar('desconto');
end;

procedure TSDPItemPedido.SetValorTotal(const Value: Currency);
begin
  FValorTotal := Value;
  Informar('valor_total');
end;

procedure TSDPItemPedido.SetTarifaVenda(const Value: Currency);
begin
  FTarifaVenda := Value;
  Informar('tarifa_venda');
end;

procedure TSDPItemPedido.SetPercentualComissao(const Value: Double);
begin
  FPercentualComissao := Value;
  Informar('percentual_comissao');
end;

procedure TSDPItemPedido.SetTipoAnuncio(const Value: string);
begin
  FTipoAnuncio := Value;
  Informar('tipo_anuncio');
end;

procedure TSDPItemPedido.SetEmbalagemPresente(const Value: Boolean);
begin
  FEmbalagemPresente := Value;
  Informar('embalagem_presente');
end;

procedure TSDPItemPedido.SetKit(const Value: Boolean);
begin
  FKit := Value;
  Informar('kit');
end;

procedure TSDPItemPedido.SetRebate(const Value: Currency);
begin
  FRebate := Value;
  Informar('rebate');
end;

procedure TSDPItemPedido.SetDepositoID(const Value: string);
begin
  FDepositoID := Value;
  Informar('deposito_id');
end;

procedure TSDPItemPedido.SetDimensoes(Value: TSDPDimensoes);
begin
  FDimensoes.Assign(Value);
end;

procedure TSDPItemPedido.SetItensKit(Value: TSDPItemKitLista);
begin
  FItensKit.Assign(Value);
end;

procedure TSDPItemPedido.LerJSON(J: TACBrJSONObject);
begin
  inherited LerJSON(J);

  if LerCampo(J, 'sequencia') then
    Sequencia := J.AsInteger['sequencia'];

  if LerCampo(J, 'sku') then
    SKU := J.AsString['sku'];

  if LerCampo(J, 'sku_erp') then
    SKUErp := J.AsString['sku_erp'];

  if LerCampo(J, 'numero_serial') then
    NumeroSerial := J.AsString['numero_serial'];

  if LerCampo(J, 'mlb') then
    MLB := J.AsString['mlb'];

  if LerCampo(J, 'foto') then
    Foto := J.AsString['foto'];

  if LerCampo(J, 'ean') then
    EAN := J.AsString['ean'];

  if LerCampo(J, 'variacao_id') then
    VariacaoID := J.AsString['variacao_id'];

  if LerCampo(J, 'descricao') then
    Descricao := J.AsString['descricao'];

  if LerCampo(J, 'descricao_variacao') then
    DescricaoVariacao := J.AsString['descricao_variacao'];

  if LerCampo(J, 'observacao') then
    Observacao := J.AsString['observacao'];

  if LerCampo(J, 'qtde') then
    Quantidade := J.AsFloat['qtde'];

  if LerCampo(J, 'valor_unitario') then
    ValorUnitario := J.AsCurrency['valor_unitario'];

  if LerCampo(J, 'desconto') then
    Desconto := J.AsCurrency['desconto'];

  if LerCampo(J, 'valor_total') then
    ValorTotal := J.AsCurrency['valor_total'];

  if LerCampo(J, 'tarifa_venda') then
    TarifaVenda := J.AsCurrency['tarifa_venda'];

  if LerCampo(J, 'percentual_comissao') then
    PercentualComissao := J.AsFloat['percentual_comissao'];

  if LerCampo(J, 'tipo_anuncio') then
    TipoAnuncio := J.AsString['tipo_anuncio'];

  if LerCampo(J, 'embalagem_presente') then
    EmbalagemPresente := J.AsBoolean['embalagem_presente'];

  if LerCampo(J, 'kit') then
    Kit := J.AsBoolean['kit'];

  if LerCampo(J, 'rebate') then
    Rebate := J.AsCurrency['rebate'];

  if LerCampo(J, 'deposito_id') then
    DepositoID := J.AsString['deposito_id'];

  if J.IsJSONObject('dimensoes') then
    FDimensoes.LerJSON(J.AsJSONObject['dimensoes']);

  if J.IsJSONArray('itens_kit') then
    FItensKit.LerJSON(J.AsJSONArray['itens_kit']);
end;

function TSDPItemPedido.GerarJSON: string;
begin
  Result := '';
  Emitir(Result, 'sequencia', IntToStr(FSequencia));
  Emitir(Result, 'sku', SDPQuote(FSKU));
  Emitir(Result, 'sku_erp', SDPQuote(FSKUErp));
  Emitir(Result, 'numero_serial', SDPQuote(FNumeroSerial));
  Emitir(Result, 'mlb', SDPQuote(FMLB));
  Emitir(Result, 'foto', SDPQuote(FFoto));
  Emitir(Result, 'ean', SDPQuote(FEAN));
  Emitir(Result, 'variacao_id', SDPQuote(FVariacaoID));
  Emitir(Result, 'descricao', SDPQuote(FDescricao));
  Emitir(Result, 'descricao_variacao', SDPQuote(FDescricaoVariacao));
  Emitir(Result, 'observacao', SDPQuote(FObservacao));
  Emitir(Result, 'qtde', SDPNumero(FQuantidade));
  Emitir(Result, 'valor_unitario', SDPNumero(FValorUnitario));
  Emitir(Result, 'desconto', SDPNumero(FDesconto));
  Emitir(Result, 'valor_total', SDPNumero(FValorTotal));
  Emitir(Result, 'tarifa_venda', SDPNumero(FTarifaVenda));
  Emitir(Result, 'percentual_comissao', SDPNumero(FPercentualComissao));
  Emitir(Result, 'tipo_anuncio', SDPQuote(FTipoAnuncio));
  Emitir(Result, 'embalagem_presente', SDPBool(FEmbalagemPresente));
  Emitir(Result, 'kit', SDPBool(FKit));
  Emitir(Result, 'rebate', SDPNumero(FRebate));
  Emitir(Result, 'deposito_id', SDPQuote(FDepositoID));

  if FDimensoes.GerarJSON <> '{}' then
    SDPPar(Result, 'dimensoes', FDimensoes.GerarJSON);

  if FItensKit.Count > 0 then
    SDPPar(Result, 'itens_kit', FItensKit.GerarJSON);

  Result := '{' + Result + '}';
end;

{ TSDPItemPedidoLista }

constructor TSDPItemPedidoLista.Create;
begin
  inherited Create(TSDPItemPedido);
end;

function TSDPItemPedidoLista.Add: TSDPItemPedido;
begin
  Result := TSDPItemPedido(inherited Add);
end;

function TSDPItemPedidoLista.GetItem(Index: Integer): TSDPItemPedido;
begin
  Result := TSDPItemPedido(inherited Items[Index]);
end;

{ TSDPPagamento }

constructor TSDPPagamento.Create(Collection: TCollection);
begin
  inherited Create(Collection);
end;

destructor TSDPPagamento.Destroy;
begin
  inherited Destroy;
end;

procedure TSDPPagamento.Limpar;
begin
  inherited Limpar;
  FSequencia := 0;
  FData := 0;
  FValor := 0;
  FStatus := '';
  FBandeira := '';
  FOperadora := '';
  FIdentificacao := '';
  FCodigoTransacao := '';
  FCNPJAutorizador := '';
  FForma := '';
  FParcelas := 0;
end;

procedure TSDPPagamento.SetSequencia(const Value: Integer);
begin
  FSequencia := Value;
  Informar('sequencia');
end;

procedure TSDPPagamento.SetData(const Value: TDateTime);
begin
  FData := Value;
  Informar('data');
end;

procedure TSDPPagamento.SetValor(const Value: Currency);
begin
  FValor := Value;
  Informar('valor');
end;

procedure TSDPPagamento.SetStatus(const Value: string);
begin
  FStatus := Value;
  Informar('status');
end;

procedure TSDPPagamento.SetBandeira(const Value: string);
begin
  FBandeira := Value;
  Informar('bandeira');
end;

procedure TSDPPagamento.SetOperadora(const Value: string);
begin
  FOperadora := Value;
  Informar('operadora');
end;

procedure TSDPPagamento.SetIdentificacao(const Value: string);
begin
  FIdentificacao := Value;
  Informar('identificacao');
end;

procedure TSDPPagamento.SetCodigoTransacao(const Value: string);
begin
  FCodigoTransacao := Value;
  Informar('codigo_transacao');
end;

procedure TSDPPagamento.SetCNPJAutorizador(const Value: string);
begin
  FCNPJAutorizador := Value;
  Informar('cnpj_autorizador');
end;

procedure TSDPPagamento.SetForma(const Value: string);
begin
  FForma := Value;
  Informar('forma');
end;

procedure TSDPPagamento.SetParcelas(const Value: Integer);
begin
  FParcelas := Value;
  Informar('parcelas');
end;

procedure TSDPPagamento.LerJSON(J: TACBrJSONObject);
begin
  inherited LerJSON(J);

  if LerCampo(J, 'sequencia') then
    Sequencia := J.AsInteger['sequencia'];

  if LerCampo(J, 'data') then
    Data := SDPData(J.AsString['data']);

  if LerCampo(J, 'valor') then
    Valor := J.AsCurrency['valor'];

  if LerCampo(J, 'status') then
    Status := J.AsString['status'];

  if LerCampo(J, 'bandeira') then
    Bandeira := J.AsString['bandeira'];

  if LerCampo(J, 'operadora') then
    Operadora := J.AsString['operadora'];

  if LerCampo(J, 'identificacao') then
    Identificacao := J.AsString['identificacao'];

  if LerCampo(J, 'codigo_transacao') then
    CodigoTransacao := J.AsString['codigo_transacao'];

  if LerCampo(J, 'cnpj_autorizador') then
    CNPJAutorizador := J.AsString['cnpj_autorizador'];

  if LerCampo(J, 'forma') then
    Forma := J.AsString['forma'];

  if LerCampo(J, 'parcelas') then
    Parcelas := J.AsInteger['parcelas'];
end;

function TSDPPagamento.GerarJSON: string;
begin
  Result := '';
  Emitir(Result, 'sequencia', IntToStr(FSequencia));
  Emitir(Result, 'data', SDPQuote(FormatDateTimeBr(FData, 'yyyy-mm-dd hh:nn:ss')));
  Emitir(Result, 'valor', SDPNumero(FValor));
  Emitir(Result, 'status', SDPQuote(FStatus));
  Emitir(Result, 'bandeira', SDPQuote(FBandeira));
  Emitir(Result, 'operadora', SDPQuote(FOperadora));
  Emitir(Result, 'identificacao', SDPQuote(FIdentificacao));
  Emitir(Result, 'codigo_transacao', SDPQuote(FCodigoTransacao));
  Emitir(Result, 'cnpj_autorizador', SDPQuote(FCNPJAutorizador));
  Emitir(Result, 'forma', SDPQuote(FForma));
  Emitir(Result, 'parcelas', IntToStr(FParcelas));
  Result := '{' + Result + '}';
end;

{ TSDPPagamentoLista }

constructor TSDPPagamentoLista.Create;
begin
  inherited Create(TSDPPagamento);
end;

function TSDPPagamentoLista.Add: TSDPPagamento;
begin
  Result := TSDPPagamento(inherited Add);
end;

function TSDPPagamentoLista.GetItem(Index: Integer): TSDPPagamento;
begin
  Result := TSDPPagamento(inherited Items[Index]);
end;

{ TSDPComprador }

constructor TSDPComprador.Create(Collection: TCollection);
begin
  inherited Create(Collection);
end;

destructor TSDPComprador.Destroy;
begin
  inherited Destroy;
end;

procedure TSDPComprador.Limpar;
begin
  inherited Limpar;
  FNome := '';
  FEndereco := '';
  FNumero := '';
  FBairro := '';
  FComplemento := '';
  FCidade := '';
  FUF := '';
  FPais := '';
  FCEP := '';
  FEmail := '';
  FFone := '';
  FApelido := '';
  FDocumento := '';
  FRGIE := '';
  FCelular := '';
end;

procedure TSDPComprador.SetNome(const Value: string);
begin
  FNome := Value;
  Informar('nome');
end;

procedure TSDPComprador.SetEndereco(const Value: string);
begin
  FEndereco := Value;
  Informar('endereco');
end;

procedure TSDPComprador.SetNumero(const Value: string);
begin
  FNumero := Value;
  Informar('numero');
end;

procedure TSDPComprador.SetBairro(const Value: string);
begin
  FBairro := Value;
  Informar('bairro');
end;

procedure TSDPComprador.SetComplemento(const Value: string);
begin
  FComplemento := Value;
  Informar('complemento');
end;

procedure TSDPComprador.SetCidade(const Value: string);
begin
  FCidade := Value;
  Informar('cidade');
end;

procedure TSDPComprador.SetUF(const Value: string);
begin
  FUF := Value;
  Informar('uf');
end;

procedure TSDPComprador.SetPais(const Value: string);
begin
  FPais := Value;
  Informar('pais');
end;

procedure TSDPComprador.SetCEP(const Value: string);
begin
  FCEP := Value;
  Informar('cep');
end;

procedure TSDPComprador.SetEmail(const Value: string);
begin
  FEmail := Value;
  Informar('email');
end;

procedure TSDPComprador.SetFone(const Value: string);
begin
  FFone := Value;
  Informar('fone');
end;

procedure TSDPComprador.SetApelido(const Value: string);
begin
  FApelido := Value;
  Informar('apelido');
end;

procedure TSDPComprador.SetDocumento(const Value: string);
begin
  FDocumento := Value;
  Informar('documento');
end;

procedure TSDPComprador.SetRGIE(const Value: string);
begin
  FRGIE := Value;
  Informar('rg_ie');
end;

procedure TSDPComprador.SetCelular(const Value: string);
begin
  FCelular := Value;
  Informar('celular');
end;

procedure TSDPComprador.LerJSON(J: TACBrJSONObject);
begin
  inherited LerJSON(J);

  if LerCampo(J, 'nome') then
    Nome := J.AsString['nome'];

  if LerCampo(J, 'endereco') then
    Endereco := J.AsString['endereco'];

  if LerCampo(J, 'numero') then
    Numero := J.AsString['numero'];

  if LerCampo(J, 'bairro') then
    Bairro := J.AsString['bairro'];

  if LerCampo(J, 'complemento') then
    Complemento := J.AsString['complemento'];

  if LerCampo(J, 'cidade') then
    Cidade := J.AsString['cidade'];

  if LerCampo(J, 'uf') then
    UF := J.AsString['uf'];

  if LerCampo(J, 'pais') then
    Pais := J.AsString['pais'];

  if LerCampo(J, 'cep') then
    CEP := J.AsString['cep'];

  if LerCampo(J, 'email') then
    Email := J.AsString['email'];

  if LerCampo(J, 'fone') then
    Fone := J.AsString['fone'];

  if LerCampo(J, 'apelido') then
    Apelido := J.AsString['apelido'];

  if LerCampo(J, 'documento') then
    Documento := J.AsString['documento'];

  if LerCampo(J, 'rg_ie') then
    RGIE := J.AsString['rg_ie'];

  if LerCampo(J, 'celular') then
    Celular := J.AsString['celular'];
end;

function TSDPComprador.GerarJSON: string;
begin
  Result := '';
  Emitir(Result, 'nome', SDPQuote(FNome));
  Emitir(Result, 'endereco', SDPQuote(FEndereco));
  Emitir(Result, 'numero', SDPQuote(FNumero));
  Emitir(Result, 'bairro', SDPQuote(FBairro));
  Emitir(Result, 'complemento', SDPQuote(FComplemento));
  Emitir(Result, 'cidade', SDPQuote(FCidade));
  Emitir(Result, 'uf', SDPQuote(FUF));
  Emitir(Result, 'pais', SDPQuote(FPais));
  Emitir(Result, 'cep', SDPQuote(FCEP));
  Emitir(Result, 'email', SDPQuote(FEmail));
  Emitir(Result, 'fone', SDPQuote(FFone));
  Emitir(Result, 'apelido', SDPQuote(FApelido));
  Emitir(Result, 'documento', SDPQuote(FDocumento));
  Emitir(Result, 'rg_ie', SDPQuote(FRGIE));
  Emitir(Result, 'celular', SDPQuote(FCelular));
  Result := '{' + Result + '}';
end;

{ TSDPCompradorLista }

constructor TSDPCompradorLista.Create;
begin
  inherited Create(TSDPComprador);
end;

function TSDPCompradorLista.Add: TSDPComprador;
begin
  Result := TSDPComprador(inherited Add);
end;

function TSDPCompradorLista.GetItem(Index: Integer): TSDPComprador;
begin
  Result := TSDPComprador(inherited Items[Index]);
end;

{ TSDPEntrega }

constructor TSDPEntrega.Create(Collection: TCollection);
begin
  inherited Create(Collection);
end;

destructor TSDPEntrega.Destroy;
begin
  inherited Destroy;
end;

procedure TSDPEntrega.Limpar;
begin
  inherited Limpar;
  FNome := '';
  FEndereco := '';
  FNumero := '';
  FBairro := '';
  FComplemento := '';
  FCidade := '';
  FUF := '';
  FPais := '';
  FCEP := '';
  FEmail := '';
  FFone := '';
  FID := '';
  FFormaEnvio := '';
  FTransportadora := '';
  FCodigoRastreio := '';
  FProgramaEnvio := '';
  FLimiteEntrega := 0;
  FPrevisaoLiberacaoEtiqueta := 0;
  FLimiteExpedicao := 0;
  FComissaoFrete := 0;
  FRebateFrete := 0;
  FEtiquetaGeradaTransportadora := False;
  FIDGeradoTransportadora := '';
end;

procedure TSDPEntrega.SetNome(const Value: string);
begin
  FNome := Value;
  Informar('nome');
end;

procedure TSDPEntrega.SetEndereco(const Value: string);
begin
  FEndereco := Value;
  Informar('endereco');
end;

procedure TSDPEntrega.SetNumero(const Value: string);
begin
  FNumero := Value;
  Informar('numero');
end;

procedure TSDPEntrega.SetBairro(const Value: string);
begin
  FBairro := Value;
  Informar('bairro');
end;

procedure TSDPEntrega.SetComplemento(const Value: string);
begin
  FComplemento := Value;
  Informar('complemento');
end;

procedure TSDPEntrega.SetCidade(const Value: string);
begin
  FCidade := Value;
  Informar('cidade');
end;

procedure TSDPEntrega.SetUF(const Value: string);
begin
  FUF := Value;
  Informar('uf');
end;

procedure TSDPEntrega.SetPais(const Value: string);
begin
  FPais := Value;
  Informar('pais');
end;

procedure TSDPEntrega.SetCEP(const Value: string);
begin
  FCEP := Value;
  Informar('cep');
end;

procedure TSDPEntrega.SetEmail(const Value: string);
begin
  FEmail := Value;
  Informar('email');
end;

procedure TSDPEntrega.SetFone(const Value: string);
begin
  FFone := Value;
  Informar('fone');
end;

procedure TSDPEntrega.SetID(const Value: string);
begin
  FID := Value;
  Informar('id');
end;

procedure TSDPEntrega.SetFormaEnvio(const Value: string);
begin
  FFormaEnvio := Value;
  Informar('forma_envio');
end;

procedure TSDPEntrega.SetTransportadora(const Value: string);
begin
  FTransportadora := Value;
  Informar('transportadora');
end;

procedure TSDPEntrega.SetCodigoRastreio(const Value: string);
begin
  FCodigoRastreio := Value;
  Informar('codigo_rastreio');
end;

procedure TSDPEntrega.SetProgramaEnvio(const Value: string);
begin
  FProgramaEnvio := Value;
  Informar('programa_envio');
end;

procedure TSDPEntrega.SetLimiteEntrega(const Value: TDateTime);
begin
  FLimiteEntrega := Value;
  Informar('limite_entrega');
end;

procedure TSDPEntrega.SetPrevisaoLiberacaoEtiqueta(const Value: TDateTime);
begin
  FPrevisaoLiberacaoEtiqueta := Value;
  Informar('previsao_liberacao_etiqueta');
end;

procedure TSDPEntrega.SetLimiteExpedicao(const Value: TDateTime);
begin
  FLimiteExpedicao := Value;
  Informar('limite_expedicao');
end;

procedure TSDPEntrega.SetComissaoFrete(const Value: Currency);
begin
  FComissaoFrete := Value;
  Informar('comissao_frete');
end;

procedure TSDPEntrega.SetRebateFrete(const Value: Currency);
begin
  FRebateFrete := Value;
  Informar('rebate');
end;

procedure TSDPEntrega.SetEtiquetaGeradaTransportadora(const Value: Boolean);
begin
  FEtiquetaGeradaTransportadora := Value;
  Informar('etiqueta_gerada_transportadora');
end;

procedure TSDPEntrega.SetIDGeradoTransportadora(const Value: string);
begin
  FIDGeradoTransportadora := Value;
  Informar('id_gerado_transportadora');
end;

procedure TSDPEntrega.LerJSON(J: TACBrJSONObject);
begin
  inherited LerJSON(J);

  if LerCampo(J, 'nome') then
    Nome := J.AsString['nome'];

  if LerCampo(J, 'endereco') then
    Endereco := J.AsString['endereco'];

  if LerCampo(J, 'numero') then
    Numero := J.AsString['numero'];

  if LerCampo(J, 'bairro') then
    Bairro := J.AsString['bairro'];

  if LerCampo(J, 'complemento') then
    Complemento := J.AsString['complemento'];

  if LerCampo(J, 'cidade') then
    Cidade := J.AsString['cidade'];

  if LerCampo(J, 'uf') then
    UF := J.AsString['uf'];

  if LerCampo(J, 'pais') then
    Pais := J.AsString['pais'];

  if LerCampo(J, 'cep') then
    CEP := J.AsString['cep'];

  if LerCampo(J, 'email') then
    Email := J.AsString['email'];

  if LerCampo(J, 'fone') then
    Fone := J.AsString['fone'];

  if LerCampo(J, 'id') then
    ID := J.AsString['id'];

  if LerCampo(J, 'forma_envio') then
    FormaEnvio := J.AsString['forma_envio'];

  if LerCampo(J, 'transportadora') then
    Transportadora := J.AsString['transportadora'];

  if LerCampo(J, 'codigo_rastreio') then
    CodigoRastreio := J.AsString['codigo_rastreio'];

  if LerCampo(J, 'programa_envio') then
    ProgramaEnvio := J.AsString['programa_envio'];

  if LerCampo(J, 'limite_entrega') then
    LimiteEntrega := SDPData(J.AsString['limite_entrega']);

  if LerCampo(J, 'previsao_liberacao_etiqueta') then
    PrevisaoLiberacaoEtiqueta := SDPData(J.AsString['previsao_liberacao_etiqueta']);

  if LerCampo(J, 'limite_expedicao') then
    LimiteExpedicao := SDPData(J.AsString['limite_expedicao']);

  if LerCampo(J, 'comissao_frete') then
    ComissaoFrete := J.AsCurrency['comissao_frete'];

  if LerCampo(J, 'rebate') then
    RebateFrete := J.AsCurrency['rebate'];

  if LerCampo(J, 'etiqueta_gerada_transportadora') then
    EtiquetaGeradaTransportadora := J.AsBoolean['etiqueta_gerada_transportadora'];

  if LerCampo(J, 'id_gerado_transportadora') then
    IDGeradoTransportadora := J.AsString['id_gerado_transportadora'];
end;

function TSDPEntrega.GerarJSON: string;
begin
  Result := '';
  Emitir(Result, 'nome', SDPQuote(FNome));
  Emitir(Result, 'endereco', SDPQuote(FEndereco));
  Emitir(Result, 'numero', SDPQuote(FNumero));
  Emitir(Result, 'bairro', SDPQuote(FBairro));
  Emitir(Result, 'complemento', SDPQuote(FComplemento));
  Emitir(Result, 'cidade', SDPQuote(FCidade));
  Emitir(Result, 'uf', SDPQuote(FUF));
  Emitir(Result, 'pais', SDPQuote(FPais));
  Emitir(Result, 'cep', SDPQuote(FCEP));
  Emitir(Result, 'email', SDPQuote(FEmail));
  Emitir(Result, 'fone', SDPQuote(FFone));
  Emitir(Result, 'id', SDPQuote(FID));
  Emitir(Result, 'forma_envio', SDPQuote(FFormaEnvio));
  Emitir(Result, 'transportadora', SDPQuote(FTransportadora));
  Emitir(Result, 'codigo_rastreio', SDPQuote(FCodigoRastreio));
  Emitir(Result, 'programa_envio', SDPQuote(FProgramaEnvio));
  Emitir(Result, 'limite_entrega', SDPQuote(FormatDateTimeBr(FLimiteEntrega, 'yyyy-mm-dd hh:nn:ss')));
  Emitir(Result, 'previsao_liberacao_etiqueta', SDPQuote(FormatDateTimeBr(FPrevisaoLiberacaoEtiqueta, 'yyyy-mm-dd hh:nn:ss')));
  Emitir(Result, 'limite_expedicao', SDPQuote(FormatDateTimeBr(FLimiteExpedicao, 'yyyy-mm-dd hh:nn:ss')));
  Emitir(Result, 'comissao_frete', SDPNumero(FComissaoFrete));
  Emitir(Result, 'rebate', SDPNumero(FRebateFrete));
  Emitir(Result, 'etiqueta_gerada_transportadora', SDPBool(FEtiquetaGeradaTransportadora));
  Emitir(Result, 'id_gerado_transportadora', SDPQuote(FIDGeradoTransportadora));
  Result := '{' + Result + '}';
end;

{ TSDPEntregaLista }

constructor TSDPEntregaLista.Create;
begin
  inherited Create(TSDPEntrega);
end;

function TSDPEntregaLista.Add: TSDPEntrega;
begin
  Result := TSDPEntrega(inherited Add);
end;

function TSDPEntregaLista.GetItem(Index: Integer): TSDPEntrega;
begin
  Result := TSDPEntrega(inherited Items[Index]);
end;

{ TSDPPlataformaPedido }

constructor TSDPPlataformaPedido.Create(Collection: TCollection);
begin
  inherited Create(Collection);
end;

destructor TSDPPlataformaPedido.Destroy;
begin
  inherited Destroy;
end;

procedure TSDPPlataformaPedido.Limpar;
begin
  inherited Limpar;
  FID := 0;
  FNome := '';
  FIntermediadorCNPJ := '';
  FIntermediadorIdentificacaoLoja := '';
  FLoja := '';
end;

procedure TSDPPlataformaPedido.SetID(const Value: Integer);
begin
  FID := Value;
  Informar('id');
end;

procedure TSDPPlataformaPedido.SetNome(const Value: string);
begin
  FNome := Value;
  Informar('nome');
end;

procedure TSDPPlataformaPedido.SetIntermediadorCNPJ(const Value: string);
begin
  FIntermediadorCNPJ := Value;
  Informar('intermediador_cnpj');
end;

procedure TSDPPlataformaPedido.SetIntermediadorIdentificacaoLoja(const Value: string);
begin
  FIntermediadorIdentificacaoLoja := Value;
  Informar('intermediador_identificacao_loja');
end;

procedure TSDPPlataformaPedido.SetLoja(const Value: string);
begin
  FLoja := Value;
  Informar('loja');
end;

procedure TSDPPlataformaPedido.LerJSON(J: TACBrJSONObject);
begin
  inherited LerJSON(J);

  if LerCampo(J, 'id') then
    ID := J.AsInteger['id'];

  if LerCampo(J, 'nome') then
    Nome := J.AsString['nome'];

  if LerCampo(J, 'intermediador_cnpj') then
    IntermediadorCNPJ := J.AsString['intermediador_cnpj'];

  if LerCampo(J, 'intermediador_identificacao_loja') then
    IntermediadorIdentificacaoLoja := J.AsString['intermediador_identificacao_loja'];

  if LerCampo(J, 'loja') then
    Loja := J.AsString['loja'];
end;

function TSDPPlataformaPedido.GerarJSON: string;
begin
  Result := '';
  Emitir(Result, 'id', IntToStr(FID));
  Emitir(Result, 'nome', SDPQuote(FNome));
  Emitir(Result, 'intermediador_cnpj', SDPQuote(FIntermediadorCNPJ));
  Emitir(Result, 'intermediador_identificacao_loja', SDPQuote(FIntermediadorIdentificacaoLoja));
  Emitir(Result, 'loja', SDPQuote(FLoja));
  Result := '{' + Result + '}';
end;

{ TSDPPlataformaPedidoLista }

constructor TSDPPlataformaPedidoLista.Create;
begin
  inherited Create(TSDPPlataformaPedido);
end;

function TSDPPlataformaPedidoLista.Add: TSDPPlataformaPedido;
begin
  Result := TSDPPlataformaPedido(inherited Add);
end;

function TSDPPlataformaPedidoLista.GetItem(Index: Integer): TSDPPlataformaPedido;
begin
  Result := TSDPPlataformaPedido(inherited Items[Index]);
end;

{ TSDPFaturamento }

constructor TSDPFaturamento.Create(Collection: TCollection);
begin
  inherited Create(Collection);
end;

destructor TSDPFaturamento.Destroy;
begin
  inherited Destroy;
end;

procedure TSDPFaturamento.Limpar;
begin
  inherited Limpar;
  FNumero := '';
  FSerie := '';
  FChaveNFe := '';
  FXMLNFe := '';
  FData := '';
end;

procedure TSDPFaturamento.SetNumero(const Value: string);
begin
  FNumero := Value;
  Informar('nf');
end;

procedure TSDPFaturamento.SetSerie(const Value: string);
begin
  FSerie := Value;
  Informar('serie');
end;

procedure TSDPFaturamento.SetChaveNFe(const Value: string);
begin
  FChaveNFe := Value;
  Informar('chaveNFE');
end;

procedure TSDPFaturamento.SetXMLNFe(const Value: string);
begin
  FXMLNFe := Value;
  Informar('xmlNFE');
end;

procedure TSDPFaturamento.SetData(const Value: string);
begin
  FData := Value;
  Informar('data');
end;

procedure TSDPFaturamento.LerJSON(J: TACBrJSONObject);
begin
  inherited LerJSON(J);

  if LerCampo(J, 'nf') then
    Numero := J.AsString['nf'];

  if LerCampo(J, 'serie') then
    Serie := J.AsString['serie'];

  if LerCampo(J, 'chaveNFE') then
    ChaveNFe := J.AsString['chaveNFE'];

  if LerCampo(J, 'xmlNFE') then
    XMLNFe := J.AsString['xmlNFE'];

  if LerCampo(J, 'data') then
    Data := J.AsString['data'];
end;

function TSDPFaturamento.GerarJSON: string;
begin
  Result := '';
  Emitir(Result, 'nf', SDPQuote(FNumero));
  Emitir(Result, 'serie', SDPQuote(FSerie));
  Emitir(Result, 'chaveNFE', SDPQuote(FChaveNFe));
  Emitir(Result, 'xmlNFE', SDPQuote(FXMLNFe));
  Emitir(Result, 'data', SDPQuote(FData));
  Result := '{' + Result + '}';
end;

{ TSDPFaturamentoLista }

constructor TSDPFaturamentoLista.Create;
begin
  inherited Create(TSDPFaturamento);
end;

function TSDPFaturamentoLista.Add: TSDPFaturamento;
begin
  Result := TSDPFaturamento(inherited Add);
end;

function TSDPFaturamentoLista.GetItem(Index: Integer): TSDPFaturamento;
begin
  Result := TSDPFaturamento(inherited Items[Index]);
end;

{ TSDPPedido }

constructor TSDPPedido.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FProdutos := TSDPItemPedidoLista.Create;
  FPagamentos := TSDPPagamentoLista.Create;
  FPlataforma := TSDPPlataformaPedido.Create(nil);
  FComprador := TSDPComprador.Create(nil);
  FEntrega := TSDPEntrega.Create(nil);
  FFaturamento := TSDPFaturamentoLista.Create;
end;

destructor TSDPPedido.Destroy;
begin
  FProdutos.Free;
  FPagamentos.Free;
  FPlataforma.Free;
  FComprador.Free;
  FEntrega.Free;
  FFaturamento.Free;
  inherited Destroy;
end;

procedure TSDPPedido.Limpar;
begin
  inherited Limpar;
  FIntegracaoID := '';
  FPedidoID := '';
  FObservacoes := '';
  FTipoME := '';
  FCarrinhoML := '';
  FDataPedido := 0;
  FUltimaAtualizacao := 0;
  FStatus := '';
  FSituacaoPersonalizadaID := 0;
  FSituacaoPersonalizadaNome := '';
  FVendedorID := '';
  FPaisOrigem := '';
  FMoeda := '';
  FMoedaCotacaoReais := 0;
  FEntregaStatus := '';
  FEtiquetaDisponivel := False;
  FFaturamentoHorario := '';
  FNFPlataforma := '';
  FTotalSemFrete := 0;
  FTotalFrete := 0;
  FTotalDesconto := 0;
  FTotalCupom := 0;
  FCupomNome := '';
  FTotalAcrescimo := 0;
  FTotalPedido := 0;
  FPlataformaPaiID := 0;
  FTipoOperacao := '';
  FCNPJTransportadora := '';
  FPlataformaID := 0;
  FPlataformaNome := '';
  FProgramaEnvio := '';
  FTemNF := False;
  FProdutos.Clear;
  FPagamentos.Clear;
  FPlataforma.Limpar;
  FComprador.Limpar;
  FEntrega.Limpar;
  FFaturamento.Clear;
end;

procedure TSDPPedido.SetIntegracaoID(const Value: string);
begin
  FIntegracaoID := Value;
  Informar('integracao_id');
end;

procedure TSDPPedido.SetPedidoID(const Value: string);
begin
  FPedidoID := Value;
  Informar('pedido_id');
end;

procedure TSDPPedido.SetObservacoes(const Value: string);
begin
  FObservacoes := Value;
  Informar('observacoes');
end;

procedure TSDPPedido.SetTipoME(const Value: string);
begin
  FTipoME := Value;
  Informar('tipo_me');
end;

procedure TSDPPedido.SetCarrinhoML(const Value: string);
begin
  FCarrinhoML := Value;
  Informar('carrinho_ml');
end;

procedure TSDPPedido.SetDataPedido(const Value: TDateTime);
begin
  FDataPedido := Value;
  Informar('data_pedido');
end;

procedure TSDPPedido.SetUltimaAtualizacao(const Value: TDateTime);
begin
  FUltimaAtualizacao := Value;
  Informar('ultima_atualizacao');
end;

procedure TSDPPedido.SetStatus(const Value: string);
begin
  FStatus := Value;
  Informar('status');
end;

procedure TSDPPedido.SetSituacaoPersonalizadaID(const Value: Integer);
begin
  FSituacaoPersonalizadaID := Value;
  Informar('situacao_personalizada_id');
end;

procedure TSDPPedido.SetSituacaoPersonalizadaNome(const Value: string);
begin
  FSituacaoPersonalizadaNome := Value;
  Informar('situacao_personalizada_nome');
end;

procedure TSDPPedido.SetVendedorID(const Value: string);
begin
  FVendedorID := Value;
  Informar('vendedor_id');
end;

procedure TSDPPedido.SetPaisOrigem(const Value: string);
begin
  FPaisOrigem := Value;
  Informar('pais_origem_pedido');
end;

procedure TSDPPedido.SetMoeda(const Value: string);
begin
  FMoeda := Value;
  Informar('moeda');
end;

procedure TSDPPedido.SetMoedaCotacaoReais(const Value: Double);
begin
  FMoedaCotacaoReais := Value;
  Informar('moeda_cotacao_reais');
end;

procedure TSDPPedido.SetEntregaStatus(const Value: string);
begin
  FEntregaStatus := Value;
  Informar('entrega_status');
end;

procedure TSDPPedido.SetEtiquetaDisponivel(const Value: Boolean);
begin
  FEtiquetaDisponivel := Value;
  Informar('etiqueta_disponivel');
end;

procedure TSDPPedido.SetFaturamentoHorario(const Value: string);
begin
  FFaturamentoHorario := Value;
  Informar('faturamento_horario');
end;

procedure TSDPPedido.SetNFPlataforma(const Value: string);
begin
  FNFPlataforma := Value;
  Informar('nf_plataforma');
end;

procedure TSDPPedido.SetTotalSemFrete(const Value: Currency);
begin
  FTotalSemFrete := Value;
  Informar('total_sem_frete');
end;

procedure TSDPPedido.SetTotalFrete(const Value: Currency);
begin
  FTotalFrete := Value;
  Informar('total_frete');
end;

procedure TSDPPedido.SetTotalDesconto(const Value: Currency);
begin
  FTotalDesconto := Value;
  Informar('total_desconto');
end;

procedure TSDPPedido.SetTotalCupom(const Value: Currency);
begin
  FTotalCupom := Value;
  Informar('total_cupom');
end;

procedure TSDPPedido.SetCupomNome(const Value: string);
begin
  FCupomNome := Value;
  Informar('cupom_nome');
end;

procedure TSDPPedido.SetTotalAcrescimo(const Value: Currency);
begin
  FTotalAcrescimo := Value;
  Informar('total_acrescimo');
end;

procedure TSDPPedido.SetTotalPedido(const Value: Currency);
begin
  FTotalPedido := Value;
  Informar('total_pedido');
end;

procedure TSDPPedido.SetPlataformaPaiID(const Value: Integer);
begin
  FPlataformaPaiID := Value;
  Informar('plataforma_pai_id');
end;

procedure TSDPPedido.SetTipoOperacao(const Value: string);
begin
  FTipoOperacao := Value;
  Informar('tipo_operacao');
end;

procedure TSDPPedido.SetCNPJTransportadora(const Value: string);
begin
  FCNPJTransportadora := Value;
  Informar('cnpj_transportadora');
end;

procedure TSDPPedido.SetPlataformaID(const Value: Integer);
begin
  FPlataformaID := Value;
  Informar('plataforma_id');
end;

procedure TSDPPedido.SetPlataformaNome(const Value: string);
begin
  FPlataformaNome := Value;
  Informar('plataforma_nome');
end;

procedure TSDPPedido.SetProgramaEnvio(const Value: string);
begin
  FProgramaEnvio := Value;
  Informar('programa_envio');
end;

procedure TSDPPedido.SetTemNF(const Value: Boolean);
begin
  FTemNF := Value;
  Informar('tem_nf');
end;

procedure TSDPPedido.SetProdutos(Value: TSDPItemPedidoLista);
begin
  FProdutos.Assign(Value);
end;

procedure TSDPPedido.SetPagamentos(Value: TSDPPagamentoLista);
begin
  FPagamentos.Assign(Value);
end;

procedure TSDPPedido.SetPlataforma(Value: TSDPPlataformaPedido);
begin
  FPlataforma.Assign(Value);
end;

procedure TSDPPedido.SetComprador(Value: TSDPComprador);
begin
  FComprador.Assign(Value);
end;

procedure TSDPPedido.SetEntrega(Value: TSDPEntrega);
begin
  FEntrega.Assign(Value);
end;

procedure TSDPPedido.SetFaturamento(Value: TSDPFaturamentoLista);
begin
  FFaturamento.Assign(Value);
end;

procedure TSDPPedido.LerJSON(J: TACBrJSONObject);
begin
  inherited LerJSON(J);

  if LerCampo(J, 'integracao_id') then
    IntegracaoID := J.AsString['integracao_id'];

  if LerCampo(J, 'pedido_id') then
    PedidoID := J.AsString['pedido_id'];

  if LerCampo(J, 'observacoes') then
    Observacoes := J.AsString['observacoes'];

  if LerCampo(J, 'tipo_me') then
    TipoME := J.AsString['tipo_me'];

  if LerCampo(J, 'carrinho_ml') then
    CarrinhoML := J.AsString['carrinho_ml'];

  if LerCampo(J, 'data_pedido') then
    DataPedido := SDPData(J.AsString['data_pedido']);

  if LerCampo(J, 'ultima_atualizacao') then
    UltimaAtualizacao := SDPData(J.AsString['ultima_atualizacao']);

  if LerCampo(J, 'status') then
    Status := J.AsString['status'];

  if LerCampo(J, 'situacao_personalizada_id') then
    SituacaoPersonalizadaID := J.AsInteger['situacao_personalizada_id'];

  if LerCampo(J, 'situacao_personalizada_nome') then
    SituacaoPersonalizadaNome := J.AsString['situacao_personalizada_nome'];

  if LerCampo(J, 'vendedor_id') then
    VendedorID := J.AsString['vendedor_id'];

  if LerCampo(J, 'pais_origem_pedido') then
    PaisOrigem := J.AsString['pais_origem_pedido'];

  if LerCampo(J, 'moeda') then
    Moeda := J.AsString['moeda'];

  if LerCampo(J, 'moeda_cotacao_reais') then
    MoedaCotacaoReais := J.AsFloat['moeda_cotacao_reais'];

  if LerCampo(J, 'entrega_status') then
    EntregaStatus := J.AsString['entrega_status'];

  if LerCampo(J, 'etiqueta_disponivel') then
    EtiquetaDisponivel := J.AsBoolean['etiqueta_disponivel'];

  if LerCampo(J, 'faturamento_horario') then
    FaturamentoHorario := J.AsString['faturamento_horario'];

  if LerCampo(J, 'nf_plataforma') then
    NFPlataforma := J.AsString['nf_plataforma'];

  if LerCampo(J, 'total_sem_frete') then
    TotalSemFrete := J.AsCurrency['total_sem_frete'];

  if LerCampo(J, 'total_frete') then
    TotalFrete := J.AsCurrency['total_frete'];

  if LerCampo(J, 'total_desconto') then
    TotalDesconto := J.AsCurrency['total_desconto'];

  if LerCampo(J, 'total_cupom') then
    TotalCupom := J.AsCurrency['total_cupom'];

  if LerCampo(J, 'cupom_nome') then
    CupomNome := J.AsString['cupom_nome'];

  if LerCampo(J, 'total_acrescimo') then
    TotalAcrescimo := J.AsCurrency['total_acrescimo'];

  if LerCampo(J, 'total_pedido') then
    TotalPedido := J.AsCurrency['total_pedido'];

  if LerCampo(J, 'plataforma_pai_id') then
    PlataformaPaiID := J.AsInteger['plataforma_pai_id'];

  if LerCampo(J, 'tipo_operacao') then
    TipoOperacao := J.AsString['tipo_operacao'];

  if LerCampo(J, 'cnpj_transportadora') then
    CNPJTransportadora := J.AsString['cnpj_transportadora'];

  if LerCampo(J, 'plataforma_id') then
    PlataformaID := J.AsInteger['plataforma_id'];

  if LerCampo(J, 'plataforma_nome') then
    PlataformaNome := J.AsString['plataforma_nome'];

  if LerCampo(J, 'programa_envio') then
    ProgramaEnvio := J.AsString['programa_envio'];

  if LerCampo(J, 'tem_nf') then
    TemNF := J.AsBoolean['tem_nf'];

  if J.IsJSONArray('produtos') then
    FProdutos.LerJSON(J.AsJSONArray['produtos']);

  if J.IsJSONArray('pagamentos') then
    FPagamentos.LerJSON(J.AsJSONArray['pagamentos']);

  if J.IsJSONObject('plataforma') then
    FPlataforma.LerJSON(J.AsJSONObject['plataforma']);

  if J.IsJSONObject('comprador') then
    FComprador.LerJSON(J.AsJSONObject['comprador']);

  if J.IsJSONObject('entrega') then
    FEntrega.LerJSON(J.AsJSONObject['entrega']);

  if J.IsJSONArray('faturamento') then
    FFaturamento.LerJSON(J.AsJSONArray['faturamento']);
end;

function TSDPPedido.GerarJSON: string;
begin
  Result := '';
  Emitir(Result, 'integracao_id', SDPQuote(FIntegracaoID));
  Emitir(Result, 'pedido_id', SDPQuote(FPedidoID));
  Emitir(Result, 'observacoes', SDPQuote(FObservacoes));
  Emitir(Result, 'tipo_me', SDPQuote(FTipoME));
  Emitir(Result, 'carrinho_ml', SDPQuote(FCarrinhoML));
  Emitir(Result, 'data_pedido', SDPQuote(FormatDateTimeBr(FDataPedido, 'yyyy-mm-dd hh:nn:ss')));
  Emitir(Result, 'ultima_atualizacao', SDPQuote(FormatDateTimeBr(FUltimaAtualizacao, 'yyyy-mm-dd hh:nn:ss')));
  Emitir(Result, 'status', SDPQuote(FStatus));
  Emitir(Result, 'situacao_personalizada_id', IntToStr(FSituacaoPersonalizadaID));
  Emitir(Result, 'situacao_personalizada_nome', SDPQuote(FSituacaoPersonalizadaNome));
  Emitir(Result, 'vendedor_id', SDPQuote(FVendedorID));
  Emitir(Result, 'pais_origem_pedido', SDPQuote(FPaisOrigem));
  Emitir(Result, 'moeda', SDPQuote(FMoeda));
  Emitir(Result, 'moeda_cotacao_reais', SDPNumero(FMoedaCotacaoReais));
  Emitir(Result, 'entrega_status', SDPQuote(FEntregaStatus));
  Emitir(Result, 'etiqueta_disponivel', SDPBool(FEtiquetaDisponivel));
  Emitir(Result, 'faturamento_horario', SDPQuote(FFaturamentoHorario));
  Emitir(Result, 'nf_plataforma', SDPQuote(FNFPlataforma));
  Emitir(Result, 'total_sem_frete', SDPNumero(FTotalSemFrete));
  Emitir(Result, 'total_frete', SDPNumero(FTotalFrete));
  Emitir(Result, 'total_desconto', SDPNumero(FTotalDesconto));
  Emitir(Result, 'total_cupom', SDPNumero(FTotalCupom));
  Emitir(Result, 'cupom_nome', SDPQuote(FCupomNome));
  Emitir(Result, 'total_acrescimo', SDPNumero(FTotalAcrescimo));
  Emitir(Result, 'total_pedido', SDPNumero(FTotalPedido));
  Emitir(Result, 'plataforma_pai_id', IntToStr(FPlataformaPaiID));
  Emitir(Result, 'tipo_operacao', SDPQuote(FTipoOperacao));
  Emitir(Result, 'cnpj_transportadora', SDPQuote(FCNPJTransportadora));
  Emitir(Result, 'plataforma_id', IntToStr(FPlataformaID));
  Emitir(Result, 'plataforma_nome', SDPQuote(FPlataformaNome));
  Emitir(Result, 'programa_envio', SDPQuote(FProgramaEnvio));
  Emitir(Result, 'tem_nf', SDPBool(FTemNF));

  if FProdutos.Count > 0 then
    SDPPar(Result, 'produtos', FProdutos.GerarJSON);

  if FPagamentos.Count > 0 then
    SDPPar(Result, 'pagamentos', FPagamentos.GerarJSON);

  if FPlataforma.GerarJSON <> '{}' then
    SDPPar(Result, 'plataforma', FPlataforma.GerarJSON);

  if FComprador.GerarJSON <> '{}' then
    SDPPar(Result, 'comprador', FComprador.GerarJSON);

  if FEntrega.GerarJSON <> '{}' then
    SDPPar(Result, 'entrega', FEntrega.GerarJSON);

  if FFaturamento.Count > 0 then
    SDPPar(Result, 'faturamento', FFaturamento.GerarJSON);
  Result := '{' + Result + '}';
end;

{ TSDPPedidoLista }

constructor TSDPPedidoLista.Create;
begin
  inherited Create(TSDPPedido);
end;

function TSDPPedidoLista.Add: TSDPPedido;
begin
  Result := TSDPPedido(inherited Add);
end;

function TSDPPedidoLista.GetItem(Index: Integer): TSDPPedido;
begin
  Result := TSDPPedido(inherited Items[Index]);
end;

{ TSDPFilaPedido }

constructor TSDPFilaPedido.Create(Collection: TCollection);
begin
  inherited Create(Collection);
end;

destructor TSDPFilaPedido.Destroy;
begin
  inherited Destroy;
end;

procedure TSDPFilaPedido.Limpar;
begin
  inherited Limpar;
  FFilaID := '';
  FPlataformaID := 0;
  FPedidoID := '';
  FIntegracaoID := '';
end;

procedure TSDPFilaPedido.SetFilaID(const Value: string);
begin
  FFilaID := Value;
  Informar('fila_id');
end;

procedure TSDPFilaPedido.SetPlataformaID(const Value: Integer);
begin
  FPlataformaID := Value;
  Informar('plataforma_id');
end;

procedure TSDPFilaPedido.SetPedidoID(const Value: string);
begin
  FPedidoID := Value;
  Informar('pedido_id');
end;

procedure TSDPFilaPedido.SetIntegracaoID(const Value: string);
begin
  FIntegracaoID := Value;
  Informar('integracao_id');
end;

procedure TSDPFilaPedido.LerJSON(J: TACBrJSONObject);
begin
  inherited LerJSON(J);

  if LerCampo(J, 'fila_id') then
    FilaID := J.AsString['fila_id'];

  if LerCampo(J, 'plataforma_id') then
    PlataformaID := J.AsInteger['plataforma_id'];

  if LerCampo(J, 'pedido_id') then
    PedidoID := J.AsString['pedido_id'];

  if LerCampo(J, 'integracao_id') then
    IntegracaoID := J.AsString['integracao_id'];
end;

function TSDPFilaPedido.GerarJSON: string;
begin
  Result := '';
  Emitir(Result, 'fila_id', SDPQuote(FFilaID));
  Emitir(Result, 'plataforma_id', IntToStr(FPlataformaID));
  Emitir(Result, 'pedido_id', SDPQuote(FPedidoID));
  Emitir(Result, 'integracao_id', SDPQuote(FIntegracaoID));
  Result := '{' + Result + '}';
end;

{ TSDPFilaPedidoLista }

constructor TSDPFilaPedidoLista.Create;
begin
  inherited Create(TSDPFilaPedido);
end;

function TSDPFilaPedidoLista.Add: TSDPFilaPedido;
begin
  Result := TSDPFilaPedido(inherited Add);
end;

function TSDPFilaPedidoLista.GetItem(Index: Integer): TSDPFilaPedido;
begin
  Result := TSDPFilaPedido(inherited Items[Index]);
end;

{ TSDPAtualizacaoStatus }

constructor TSDPAtualizacaoStatus.Create(Collection: TCollection);
begin
  inherited Create(Collection);
end;

destructor TSDPAtualizacaoStatus.Destroy;
begin
  inherited Destroy;
end;

procedure TSDPAtualizacaoStatus.Limpar;
begin
  inherited Limpar;
  FStatus := '';
  FRastreio := '';
  FSerie := '';
  FNF := '';
  FEspecie := '';
  FData := '';
  FChaveNFe := '';
  FProdutoCFOP := '';
  FIE := '';
  FXMLNFe := '';
  FXMLNFeBytes := '';
  FTransportadora := '';
  FFormaEnvio := '';
  FRastreioURL := '';
end;

procedure TSDPAtualizacaoStatus.Assign(Source: TPersistent);
begin
  inherited Assign(Source);

  if Source is TSDPAtualizacaoStatus then
    FXMLNFeBytes := TSDPAtualizacaoStatus(Source).XMLNFeBytes;
end;

procedure TSDPAtualizacaoStatus.CarregarXMLNFe(AStream: TStream);
var
  Bytes: AnsiString;
begin
  if AStream = nil then
    raise EACBrShoppingPrecos.Create('Informe o stream do XML da NF-e');

  AStream.Position := 0;
  SetLength(Bytes, Integer(AStream.Size));

  if Length(Bytes) > 0 then
    AStream.ReadBuffer(Bytes[1], Length(Bytes));

  if (Length(Bytes) >= 3) and (Ord(Bytes[1]) = $EF) and
     (Ord(Bytes[2]) = $BB) and (Ord(Bytes[3]) = $BF) then
    Delete(Bytes, 1, 3);

  if Bytes = '' then
    raise EACBrShoppingPrecos.Create('XML da NF-e vazio');

  { Texto apenas para consulta; o envio usa XMLNFeBytes. }
  XMLNFe := UTF8ToNativeString(Bytes);
  FXMLNFeBytes := Bytes;
end;

procedure TSDPAtualizacaoStatus.SetStatus(const Value: string);
begin
  FStatus := Value;
  Informar('status');
end;

procedure TSDPAtualizacaoStatus.SetRastreio(const Value: string);
begin
  FRastreio := Value;
  Informar('rastreio');
end;

procedure TSDPAtualizacaoStatus.SetSerie(const Value: string);
begin
  FSerie := Value;
  Informar('serie');
end;

procedure TSDPAtualizacaoStatus.SetNF(const Value: string);
begin
  FNF := Value;
  Informar('nf');
end;

procedure TSDPAtualizacaoStatus.SetEspecie(const Value: string);
begin
  FEspecie := Value;
  Informar('especie');
end;

procedure TSDPAtualizacaoStatus.SetData(const Value: string);
begin
  FData := Value;
  Informar('data');
end;

procedure TSDPAtualizacaoStatus.SetChaveNFe(const Value: string);
begin
  FChaveNFe := Value;
  Informar('chaveNFE');
end;

procedure TSDPAtualizacaoStatus.SetProdutoCFOP(const Value: string);
begin
  FProdutoCFOP := Value;
  Informar('produtoCFOP');
end;

procedure TSDPAtualizacaoStatus.SetIE(const Value: string);
begin
  FIE := Value;
  Informar('ie');
end;

procedure TSDPAtualizacaoStatus.SetXMLNFe(const Value: string);
begin
  FXMLNFe := Value;
  FXMLNFeBytes := '';
  Informar('xmlNFE');
end;

procedure TSDPAtualizacaoStatus.SetTransportadora(const Value: string);
begin
  FTransportadora := Value;
  Informar('transportadora');
end;

procedure TSDPAtualizacaoStatus.SetFormaEnvio(const Value: string);
begin
  FFormaEnvio := Value;
  Informar('formaEnvio');
end;

procedure TSDPAtualizacaoStatus.SetRastreioURL(const Value: string);
begin
  FRastreioURL := Value;
  Informar('rastreioURL');
end;

procedure TSDPAtualizacaoStatus.LerJSON(J: TACBrJSONObject);
begin
  inherited LerJSON(J);

  if LerCampo(J, 'status') then
    Status := J.AsString['status'];

  if LerCampo(J, 'rastreio') then
    Rastreio := J.AsString['rastreio'];

  if LerCampo(J, 'serie') then
    Serie := J.AsString['serie'];

  if LerCampo(J, 'nf') then
    NF := J.AsString['nf'];

  if LerCampo(J, 'especie') then
    Especie := J.AsString['especie'];

  if LerCampo(J, 'data') then
    Data := J.AsString['data'];

  if LerCampo(J, 'chaveNFE') then
    ChaveNFe := J.AsString['chaveNFE'];

  if LerCampo(J, 'produtoCFOP') then
    ProdutoCFOP := J.AsString['produtoCFOP'];

  if LerCampo(J, 'ie') then
    IE := J.AsString['ie'];

  if LerCampo(J, 'xmlNFE') then
    XMLNFe := J.AsString['xmlNFE'];

  if LerCampo(J, 'transportadora') then
    Transportadora := J.AsString['transportadora'];

  if LerCampo(J, 'formaEnvio') then
    FormaEnvio := J.AsString['formaEnvio'];

  if LerCampo(J, 'rastreioURL') then
    RastreioURL := J.AsString['rastreioURL'];
end;

function TSDPAtualizacaoStatus.GerarJSON: string;
begin
  Result := '';
  Emitir(Result, 'status', SDPQuote(FStatus));
  Emitir(Result, 'rastreio', SDPQuote(FRastreio));
  Emitir(Result, 'serie', SDPQuote(FSerie));
  Emitir(Result, 'nf', SDPQuote(FNF));
  Emitir(Result, 'especie', SDPQuote(FEspecie));
  Emitir(Result, 'data', SDPQuote(FData));
  Emitir(Result, 'chaveNFE', SDPQuote(FChaveNFe));
  Emitir(Result, 'produtoCFOP', SDPQuote(FProdutoCFOP));
  Emitir(Result, 'ie', SDPQuote(FIE));
  Emitir(Result, 'xmlNFE', SDPQuote(FXMLNFe));
  Emitir(Result, 'transportadora', SDPQuote(FTransportadora));
  Emitir(Result, 'formaEnvio', SDPQuote(FFormaEnvio));
  Emitir(Result, 'rastreioURL', SDPQuote(FRastreioURL));
  Result := '{' + Result + '}';
end;

{ TSDPAtualizacaoStatusLista }

constructor TSDPAtualizacaoStatusLista.Create;
begin
  inherited Create(TSDPAtualizacaoStatus);
end;

function TSDPAtualizacaoStatusLista.Add: TSDPAtualizacaoStatus;
begin
  Result := TSDPAtualizacaoStatus(inherited Add);
end;

function TSDPAtualizacaoStatusLista.GetItem(Index: Integer): TSDPAtualizacaoStatus;
begin
  Result := TSDPAtualizacaoStatus(inherited Items[Index]);
end;

{ TSDPEtiqueta }

constructor TSDPEtiqueta.Create(Collection: TCollection);
begin
  inherited Create(Collection);
end;

destructor TSDPEtiqueta.Destroy;
begin
  inherited Destroy;
end;

procedure TSDPEtiqueta.Limpar;
begin
  inherited Limpar;
  FPedidoID := '';
  FPlataformaID := 0;
  FTipo := '';
  FSucesso := False;
  FConteudo := '';
  FZPL := '';
  FMensagem := '';
end;

procedure TSDPEtiqueta.SetPedidoID(const Value: string);
begin
  FPedidoID := Value;
  Informar('PedidoID');
end;

procedure TSDPEtiqueta.SetPlataformaID(const Value: Integer);
begin
  FPlataformaID := Value;
  Informar('PlataformaID');
end;

procedure TSDPEtiqueta.SetTipo(const Value: string);
begin
  FTipo := Value;
  Informar('type');
end;

procedure TSDPEtiqueta.SetSucesso(const Value: Boolean);
begin
  FSucesso := Value;
  Informar('status');
end;

procedure TSDPEtiqueta.SetConteudo(const Value: string);
begin
  FConteudo := Value;
  Informar('body');
end;

procedure TSDPEtiqueta.SetZPL(const Value: string);
begin
  FZPL := Value;
  Informar('zpl');
end;

procedure TSDPEtiqueta.SetMensagem(const Value: string);
begin
  FMensagem := Value;
  Informar('message');
end;

procedure TSDPEtiqueta.LerJSON(J: TACBrJSONObject);
begin
  inherited LerJSON(J);

  if LerCampo(J, 'PedidoID') then
    PedidoID := J.AsString['PedidoID'];

  if LerCampo(J, 'PlataformaID') then
    PlataformaID := J.AsInteger['PlataformaID'];

  if LerCampo(J, 'type') then
    Tipo := J.AsString['type'];

  if LerCampo(J, 'status') then
    Sucesso := J.AsBoolean['status'];

  if LerCampo(J, 'body') then
    Conteudo := J.AsString['body'];

  if LerCampo(J, 'zpl') then
    ZPL := J.AsString['zpl'];

  if LerCampo(J, 'message') then
    Mensagem := J.AsString['message'];
end;

function TSDPEtiqueta.GerarJSON: string;
begin
  Result := '';
  Emitir(Result, 'PedidoID', SDPQuote(FPedidoID));
  Emitir(Result, 'PlataformaID', IntToStr(FPlataformaID));
  Emitir(Result, 'type', SDPQuote(FTipo));
  Emitir(Result, 'status', SDPBool(FSucesso));
  Emitir(Result, 'body', SDPQuote(FConteudo));
  Emitir(Result, 'zpl', SDPQuote(FZPL));
  Emitir(Result, 'message', SDPQuote(FMensagem));
  Result := '{' + Result + '}';
end;

{ TSDPEtiquetaLista }

constructor TSDPEtiquetaLista.Create;
begin
  inherited Create(TSDPEtiqueta);
end;

function TSDPEtiquetaLista.Add: TSDPEtiqueta;
begin
  Result := TSDPEtiqueta(inherited Add);
end;

function TSDPEtiquetaLista.GetItem(Index: Integer): TSDPEtiqueta;
begin
  Result := TSDPEtiqueta(inherited Items[Index]);
end;

end.
