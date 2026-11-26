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
unit ACBrShoppingPrecosModelosAPI;

interface

uses Classes, SysUtils, ACBrJSON, ACBrShoppingPrecosModelos;

type
  TSDPPlataforma = class;
  TSDPIntegracao = class;
  TSDPEstoqueIntegracao = class;
  TSDPPrecoIntegracao = class;
  TSDPOpcaoPlataforma = class;
  TSDPSituacaoPersonalizada = class;
  TSDPDeposito = class;
  TSDPEstoqueAnuncio = class;
  TSDPPrecoAnuncio = class;
  TSDPResultadoAnuncio = class;
  TSDPAtributoEnvio = class;
  TSDPVariacaoEnvio = class;
  TSDPProdutoPlataforma = class;
  TSDPAceiteItem = class;
  TSDPOutraNF = class;
  TSDPNotaPedido = class;
  TSDPFiltroXML = class;
  TSDPRelatorioXML = class;
  TSDPPlataformaLista = class(TSDPListaAPI)
  private
    function GetItem(Index: Integer): TSDPPlataforma;
  public
    constructor Create;
    function Add: TSDPPlataforma;
    property Items[Index: Integer]: TSDPPlataforma read GetItem; default;
  end;

  TSDPIntegracaoLista = class(TSDPListaAPI)
  private
    function GetItem(Index: Integer): TSDPIntegracao;
  public
    constructor Create;
    function Add: TSDPIntegracao;
    property Items[Index: Integer]: TSDPIntegracao read GetItem; default;
  end;

  TSDPEstoqueIntegracaoLista = class(TSDPListaAPI)
  private
    function GetItem(Index: Integer): TSDPEstoqueIntegracao;
  public
    constructor Create;
    function Add: TSDPEstoqueIntegracao;
    property Items[Index: Integer]: TSDPEstoqueIntegracao read GetItem; default;
  end;

  TSDPPrecoIntegracaoLista = class(TSDPListaAPI)
  private
    function GetItem(Index: Integer): TSDPPrecoIntegracao;
  public
    constructor Create;
    function Add: TSDPPrecoIntegracao;
    property Items[Index: Integer]: TSDPPrecoIntegracao read GetItem; default;
  end;

  TSDPOpcaoPlataformaLista = class(TSDPListaAPI)
  private
    function GetItem(Index: Integer): TSDPOpcaoPlataforma;
  public
    constructor Create;
    function Add: TSDPOpcaoPlataforma;
    property Items[Index: Integer]: TSDPOpcaoPlataforma read GetItem; default;
  end;

  TSDPSituacaoPersonalizadaLista = class(TSDPListaAPI)
  private
    function GetItem(Index: Integer): TSDPSituacaoPersonalizada;
  public
    constructor Create;
    function Add: TSDPSituacaoPersonalizada;
    property Items[Index: Integer]: TSDPSituacaoPersonalizada read GetItem; default;
  end;

  TSDPDepositoLista = class(TSDPListaAPI)
  private
    function GetItem(Index: Integer): TSDPDeposito;
  public
    constructor Create;
    function Add: TSDPDeposito;
    property Items[Index: Integer]: TSDPDeposito read GetItem; default;
  end;

  TSDPEstoqueAnuncioLista = class(TSDPListaAPI)
  private
    function GetItem(Index: Integer): TSDPEstoqueAnuncio;
  public
    constructor Create;
    function Add: TSDPEstoqueAnuncio;
    property Items[Index: Integer]: TSDPEstoqueAnuncio read GetItem; default;
  end;

  TSDPPrecoAnuncioLista = class(TSDPListaAPI)
  private
    function GetItem(Index: Integer): TSDPPrecoAnuncio;
  public
    constructor Create;
    function Add: TSDPPrecoAnuncio;
    property Items[Index: Integer]: TSDPPrecoAnuncio read GetItem; default;
  end;

  TSDPResultadoAnuncioLista = class(TSDPListaAPI)
  private
    function GetItem(Index: Integer): TSDPResultadoAnuncio;
  public
    constructor Create;
    function Add: TSDPResultadoAnuncio;
    property Items[Index: Integer]: TSDPResultadoAnuncio read GetItem; default;
  end;

  TSDPAtributoEnvioLista = class(TSDPListaAPI)
  private
    function GetItem(Index: Integer): TSDPAtributoEnvio;
  public
    constructor Create;
    function Add: TSDPAtributoEnvio;
    property Items[Index: Integer]: TSDPAtributoEnvio read GetItem; default;
  end;

  TSDPVariacaoEnvioLista = class(TSDPListaAPI)
  private
    function GetItem(Index: Integer): TSDPVariacaoEnvio;
  public
    constructor Create;
    function Add: TSDPVariacaoEnvio;
    property Items[Index: Integer]: TSDPVariacaoEnvio read GetItem; default;
  end;

  TSDPProdutoPlataformaLista = class(TSDPListaAPI)
  private
    function GetItem(Index: Integer): TSDPProdutoPlataforma;
  public
    constructor Create;
    function Add: TSDPProdutoPlataforma;
    property Items[Index: Integer]: TSDPProdutoPlataforma read GetItem; default;
  end;

  TSDPAceiteItemLista = class(TSDPListaAPI)
  private
    function GetItem(Index: Integer): TSDPAceiteItem;
  public
    constructor Create;
    function Add: TSDPAceiteItem;
    property Items[Index: Integer]: TSDPAceiteItem read GetItem; default;
  end;

  TSDPOutraNFLista = class(TSDPListaAPI)
  private
    function GetItem(Index: Integer): TSDPOutraNF;
  public
    constructor Create;
    function Add: TSDPOutraNF;
    property Items[Index: Integer]: TSDPOutraNF read GetItem; default;
  end;

  TSDPNotaPedidoLista = class(TSDPListaAPI)
  private
    function GetItem(Index: Integer): TSDPNotaPedido;
  public
    constructor Create;
    function Add: TSDPNotaPedido;
    property Items[Index: Integer]: TSDPNotaPedido read GetItem; default;
  end;

  TSDPFiltroXMLLista = class(TSDPListaAPI)
  private
    function GetItem(Index: Integer): TSDPFiltroXML;
  public
    constructor Create;
    function Add: TSDPFiltroXML;
    property Items[Index: Integer]: TSDPFiltroXML read GetItem; default;
  end;

  TSDPRelatorioXMLLista = class(TSDPListaAPI)
  private
    function GetItem(Index: Integer): TSDPRelatorioXML;
  public
    constructor Create;
    function Add: TSDPRelatorioXML;
    property Items[Index: Integer]: TSDPRelatorioXML read GetItem; default;
  end;

  TSDPPlataforma = class(TSDPModelo)
  private
    FID: Integer;
    FTitulo: string;
    FIP: string;
    FTipo: string;
    FPlataformaPaiID: Integer;
    FAtivo: Boolean;
    FIcone: string;
    procedure SetID(const Value: Integer);
    procedure SetTitulo(const Value: string);
    procedure SetIP(const Value: string);
    procedure SetTipo(const Value: string);
    procedure SetPlataformaPaiID(const Value: Integer);
    procedure SetAtivo(const Value: Boolean);
    procedure SetIcone(const Value: string);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Limpar; override;
    procedure LerJSON(J: TACBrJSONObject); override;
    function GerarJSON: string; override;
    property ID: Integer read FID write SetID;
    property Titulo: string read FTitulo write SetTitulo;
    property IP: string read FIP write SetIP;
    property Tipo: string read FTipo write SetTipo;
    property PlataformaPaiID: Integer read FPlataformaPaiID write SetPlataformaPaiID;
    property Ativo: Boolean read FAtivo write SetAtivo;
    property Icone: string read FIcone write SetIcone;
  end;

  TSDPIntegracao = class(TSDPModelo)
  private
    FIntegracaoID: string;
    FDescricaoPlataforma: string;
    FPlataformaID: Integer;
    FPlataforma: string;
    procedure SetIntegracaoID(const Value: string);
    procedure SetDescricaoPlataforma(const Value: string);
    procedure SetPlataformaID(const Value: Integer);
    procedure SetPlataforma(const Value: string);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Limpar; override;
    procedure LerJSON(J: TACBrJSONObject); override;
    function GerarJSON: string; override;
    property IntegracaoID: string read FIntegracaoID write SetIntegracaoID;
    property DescricaoPlataforma: string read FDescricaoPlataforma write SetDescricaoPlataforma;
    property PlataformaID: Integer read FPlataformaID write SetPlataformaID;
    property Plataforma: string read FPlataforma write SetPlataforma;
  end;

  TSDPEstoqueIntegracao = class(TSDPModelo)
  private
    FSKU: string;
    FEstoque: Integer;
    FUltimaAtualizacao: TDateTime;
    procedure SetSKU(const Value: string);
    procedure SetEstoque(const Value: Integer);
    procedure SetUltimaAtualizacao(const Value: TDateTime);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Limpar; override;
    procedure LerJSON(J: TACBrJSONObject); override;
    function GerarJSON: string; override;
    property SKU: string read FSKU write SetSKU;
    property Estoque: Integer read FEstoque write SetEstoque;
    property UltimaAtualizacao: TDateTime read FUltimaAtualizacao write SetUltimaAtualizacao;
  end;

  TSDPPrecoIntegracao = class(TSDPModelo)
  private
    FSKU: string;
    FPreco: Currency;
    FPrecoPromocao: Currency;
    FInicioPromocao: TDateTime;
    FTerminoPromocao: TDateTime;
    FUltimaAtualizacao: TDateTime;
    procedure SetSKU(const Value: string);
    procedure SetPreco(const Value: Currency);
    procedure SetPrecoPromocao(const Value: Currency);
    procedure SetInicioPromocao(const Value: TDateTime);
    procedure SetTerminoPromocao(const Value: TDateTime);
    procedure SetUltimaAtualizacao(const Value: TDateTime);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Limpar; override;
    procedure LerJSON(J: TACBrJSONObject); override;
    function GerarJSON: string; override;
    property SKU: string read FSKU write SetSKU;
    property Preco: Currency read FPreco write SetPreco;
    property PrecoPromocao: Currency read FPrecoPromocao write SetPrecoPromocao;
    property InicioPromocao: TDateTime read FInicioPromocao write SetInicioPromocao;
    property TerminoPromocao: TDateTime read FTerminoPromocao write SetTerminoPromocao;
    property UltimaAtualizacao: TDateTime read FUltimaAtualizacao write SetUltimaAtualizacao;
  end;

  TSDPOpcaoPlataforma = class(TSDPModelo)
  private
    FID: string;
    FNome: string;
    procedure SetID(const Value: string);
    procedure SetNome(const Value: string);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Limpar; override;
    procedure LerJSON(J: TACBrJSONObject); override;
    function GerarJSON: string; override;
    property ID: string read FID write SetID;
    property Nome: string read FNome write SetNome;
  end;

  TSDPSituacaoPersonalizada = class(TSDPModelo)
  private
    FID: Integer;
    FSituacao: string;
    procedure SetID(const Value: Integer);
    procedure SetSituacao(const Value: string);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Limpar; override;
    procedure LerJSON(J: TACBrJSONObject); override;
    function GerarJSON: string; override;
    property ID: Integer read FID write SetID;
    property Situacao: string read FSituacao write SetSituacao;
  end;

  TSDPDeposito = class(TSDPModelo)
  private
    FID: string;
    FEstoque: string;
    procedure SetID(const Value: string);
    procedure SetEstoque(const Value: string);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Limpar; override;
    procedure LerJSON(J: TACBrJSONObject); override;
    function GerarJSON: string; override;
    property ID: string read FID write SetID;
    property Estoque: string read FEstoque write SetEstoque;
  end;

  TSDPEstoqueAnuncio = class(TSDPModelo)
  private
    FProdutoID: string;
    FSKU: string;
    FSKUPai: string;
    FSKUVariacaoPai: string;
    FEstoque: Integer;
    FDiasEntrega: Integer;
    FDocas: TSDPDepositoLista;
    procedure SetProdutoID(const Value: string);
    procedure SetSKU(const Value: string);
    procedure SetSKUPai(const Value: string);
    procedure SetSKUVariacaoPai(const Value: string);
    procedure SetEstoque(const Value: Integer);
    procedure SetDiasEntrega(const Value: Integer);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Limpar; override;
    procedure LerJSON(J: TACBrJSONObject); override;
    function GerarJSON: string; override;
    property ProdutoID: string read FProdutoID write SetProdutoID;
    property SKU: string read FSKU write SetSKU;
    property SKUPai: string read FSKUPai write SetSKUPai;
    property SKUVariacaoPai: string read FSKUVariacaoPai write SetSKUVariacaoPai;
    property Estoque: Integer read FEstoque write SetEstoque;
    property DiasEntrega: Integer read FDiasEntrega write SetDiasEntrega;
    property Docas: TSDPDepositoLista read FDocas;
  end;

  TSDPPrecoAnuncio = class(TSDPModelo)
  private
    FProdutoID: string;
    FSKU: string;
    FSKUPai: string;
    FSKUVariacaoPai: string;
    FPreco: Currency;
    FPrecoPromocao: Currency;
    FInicioPromocao: TDateTime;
    FTerminoPromocao: TDateTime;
    procedure SetProdutoID(const Value: string);
    procedure SetSKU(const Value: string);
    procedure SetSKUPai(const Value: string);
    procedure SetSKUVariacaoPai(const Value: string);
    procedure SetPreco(const Value: Currency);
    procedure SetPrecoPromocao(const Value: Currency);
    procedure SetInicioPromocao(const Value: TDateTime);
    procedure SetTerminoPromocao(const Value: TDateTime);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Limpar; override;
    procedure LerJSON(J: TACBrJSONObject); override;
    function GerarJSON: string; override;
    property ProdutoID: string read FProdutoID write SetProdutoID;
    property SKU: string read FSKU write SetSKU;
    property SKUPai: string read FSKUPai write SetSKUPai;
    property SKUVariacaoPai: string read FSKUVariacaoPai write SetSKUVariacaoPai;
    property Preco: Currency read FPreco write SetPreco;
    property PrecoPromocao: Currency read FPrecoPromocao write SetPrecoPromocao;
    property InicioPromocao: TDateTime read FInicioPromocao write SetInicioPromocao;
    property TerminoPromocao: TDateTime read FTerminoPromocao write SetTerminoPromocao;
  end;

  TSDPResultadoAnuncio = class(TSDPModelo)
  private
    FProdutoID: string;
    FSKU: string;
    FSKUPai: string;
    FSKUVariacaoPai: string;
    FSucesso: Boolean;
    FMensagem: string;
    FDiasEntrega: Integer;
    FDocas: TStringList;
    procedure SetProdutoID(const Value: string);
    procedure SetSKU(const Value: string);
    procedure SetSKUPai(const Value: string);
    procedure SetSKUVariacaoPai(const Value: string);
    procedure SetSucesso(const Value: Boolean);
    procedure SetMensagem(const Value: string);
    procedure SetDiasEntrega(const Value: Integer);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Limpar; override;
    procedure LerJSON(J: TACBrJSONObject); override;
    function GerarJSON: string; override;
    property ProdutoID: string read FProdutoID write SetProdutoID;
    property SKU: string read FSKU write SetSKU;
    property SKUPai: string read FSKUPai write SetSKUPai;
    property SKUVariacaoPai: string read FSKUVariacaoPai write SetSKUVariacaoPai;
    property Sucesso: Boolean read FSucesso write SetSucesso;
    property Mensagem: string read FMensagem write SetMensagem;
    property DiasEntrega: Integer read FDiasEntrega write SetDiasEntrega;
    property Docas: TStringList read FDocas;
  end;

  TSDPAtributoEnvio = class(TSDPModelo)
  private
    FCategoria: string;
    FChaveERP: string;
    FValorERP: string;
    FChavePlataforma: string;
    FValorPlataforma: string;
    FAtributoID: string;
    procedure SetCategoria(const Value: string);
    procedure SetChaveERP(const Value: string);
    procedure SetValorERP(const Value: string);
    procedure SetChavePlataforma(const Value: string);
    procedure SetValorPlataforma(const Value: string);
    procedure SetAtributoID(const Value: string);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Limpar; override;
    procedure LerJSON(J: TACBrJSONObject); override;
    function GerarJSON: string; override;
    property Categoria: string read FCategoria write SetCategoria;
    property ChaveERP: string read FChaveERP write SetChaveERP;
    property ValorERP: string read FValorERP write SetValorERP;
    property ChavePlataforma: string read FChavePlataforma write SetChavePlataforma;
    property ValorPlataforma: string read FValorPlataforma write SetValorPlataforma;
    property AtributoID: string read FAtributoID write SetAtributoID;
  end;

  TSDPVariacaoEnvio = class(TSDPModelo)
  private
    FProdutoID: string;
    FSKU: string;
    FAtributos: TSDPAtributoEnvioLista;
    procedure SetProdutoID(const Value: string);
    procedure SetSKU(const Value: string);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Limpar; override;
    procedure LerJSON(J: TACBrJSONObject); override;
    function GerarJSON: string; override;
    property ProdutoID: string read FProdutoID write SetProdutoID;
    property SKU: string read FSKU write SetSKU;
    property Atributos: TSDPAtributoEnvioLista read FAtributos;
  end;

  TSDPProdutoPlataforma = class(TSDPModelo)
  private
    FProdutoID: string;
    FSKU: string;
    FPreco: Currency;
    FEstoque: Integer;
    FMarcaID: string;
    FCategoriaID: string;
    FDepartamentoID: string;
    FCategorias: TSDPOpcaoPlataformaLista;
    FAtributos: TSDPAtributoEnvioLista;
    FVariacoes: TSDPVariacaoEnvioLista;
    procedure SetProdutoID(const Value: string);
    procedure SetSKU(const Value: string);
    procedure SetPreco(const Value: Currency);
    procedure SetEstoque(const Value: Integer);
    procedure SetMarcaID(const Value: string);
    procedure SetCategoriaID(const Value: string);
    procedure SetDepartamentoID(const Value: string);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Limpar; override;
    procedure LerJSON(J: TACBrJSONObject); override;
    function GerarJSON: string; override;
    property ProdutoID: string read FProdutoID write SetProdutoID;
    property SKU: string read FSKU write SetSKU;
    property Preco: Currency read FPreco write SetPreco;
    property Estoque: Integer read FEstoque write SetEstoque;
    property MarcaID: string read FMarcaID write SetMarcaID;
    property CategoriaID: string read FCategoriaID write SetCategoriaID;
    property DepartamentoID: string read FDepartamentoID write SetDepartamentoID;
    property Categorias: TSDPOpcaoPlataformaLista read FCategorias;
    property Atributos: TSDPAtributoEnvioLista read FAtributos;
    property Variacoes: TSDPVariacaoEnvioLista read FVariacoes;
  end;

  TSDPAceiteItem = class(TSDPModelo)
  private
    FSKU: string;
    FQuantidadeAceita: Integer;
    procedure SetSKU(const Value: string);
    procedure SetQuantidadeAceita(const Value: Integer);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Limpar; override;
    procedure LerJSON(J: TACBrJSONObject); override;
    function GerarJSON: string; override;
    property SKU: string read FSKU write SetSKU;
    property QuantidadeAceita: Integer read FQuantidadeAceita write SetQuantidadeAceita;
  end;

  TSDPOutraNF = class(TSDPModelo)
  private
    FID: string;
    FOrigem: string;
    FTipo: string;
    FDescricao: string;
    FXMLBase64: string;
    procedure SetID(const Value: string);
    procedure SetOrigem(const Value: string);
    procedure SetTipo(const Value: string);
    procedure SetDescricao(const Value: string);
    procedure SetXMLBase64(const Value: string);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Limpar; override;
    procedure LerJSON(J: TACBrJSONObject); override;
    function GerarJSON: string; override;
    procedure SalvarXML(Stream: TStream);
    property ID: string read FID write SetID;
    property Origem: string read FOrigem write SetOrigem;
    property Tipo: string read FTipo write SetTipo;
    property Descricao: string read FDescricao write SetDescricao;
    property XMLBase64: string read FXMLBase64 write SetXMLBase64;
  end;

  TSDPNotaPedido = class(TSDPModelo)
  private
    FSucesso: Boolean;
    FPlataformaID: Integer;
    FTempo: Double;
    FPedidoID: string;
    FXMLBase64: string;
    FOutrasNFs: TSDPOutraNFLista;
    procedure SetSucesso(const Value: Boolean);
    procedure SetPlataformaID(const Value: Integer);
    procedure SetTempo(const Value: Double);
    procedure SetPedidoID(const Value: string);
    procedure SetXMLBase64(const Value: string);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Limpar; override;
    procedure LerJSON(J: TACBrJSONObject); override;
    function GerarJSON: string; override;
    procedure SalvarXML(Stream: TStream);
    property Sucesso: Boolean read FSucesso write SetSucesso;
    property PlataformaID: Integer read FPlataformaID write SetPlataformaID;
    property Tempo: Double read FTempo write SetTempo;
    property PedidoID: string read FPedidoID write SetPedidoID;
    property XMLBase64: string read FXMLBase64 write SetXMLBase64;
    property OutrasNFs: TSDPOutraNFLista read FOutrasNFs;
  end;

  TSDPFiltroXML = class(TSDPModelo)
  private
    FDataInicial: TDateTime;
    FDataFinal: TDateTime;
    procedure SetDataInicial(const Value: TDateTime);
    procedure SetDataFinal(const Value: TDateTime);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Limpar; override;
    procedure LerJSON(J: TACBrJSONObject); override;
    function GerarJSON: string; override;
    property DataInicial: TDateTime read FDataInicial write SetDataInicial;
    property DataFinal: TDateTime read FDataFinal write SetDataFinal;
  end;

  TSDPRelatorioXML = class(TSDPModelo)
  private
    FID: string;
    FStatus: string;
    FDataCriacao: TDateTime;
    FDataProcessamento: TDateTime;
    FURLArquivo: string;
    procedure SetID(const Value: string);
    procedure SetStatus(const Value: string);
    procedure SetDataCriacao(const Value: TDateTime);
    procedure SetDataProcessamento(const Value: TDateTime);
    procedure SetURLArquivo(const Value: string);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Limpar; override;
    procedure LerJSON(J: TACBrJSONObject); override;
    function GerarJSON: string; override;
    property ID: string read FID write SetID;
    property Status: string read FStatus write SetStatus;
    property DataCriacao: TDateTime read FDataCriacao write SetDataCriacao;
    property DataProcessamento: TDateTime read FDataProcessamento write SetDataProcessamento;
    property URLArquivo: string read FURLArquivo write SetURLArquivo;
  end;

implementation

uses
  synacode, ACBrUtil.DateTime;

{ Decodifica sem converter a codificacao do XML. Stream pertence ao chamador. }

procedure SDPGravarBase64(const Base64: string; Stream: TStream);
var
  Bytes: AnsiString;
  I, Padding: Integer;
  C: Char;
begin
  if Stream = nil then
    raise EACBrShoppingPrecos.Create('Informe o stream de destino');

  if (Base64 = '') or ((Length(Base64) mod 4) <> 0) then
    raise EACBrShoppingPrecos.Create('XML base64 vazio ou invalido');

  Padding := 0;
  for I := 1 to Length(Base64) do
  begin
    C := Base64[I];

    if C = '=' then
      Inc(Padding)
    else
    begin
      if (Padding > 0) or not (((C >= 'A') and (C <= 'Z')) or
        ((C >= 'a') and (C <= 'z')) or ((C >= '0') and (C <= '9')) or
        (C = '+') or (C = '/')) then
        raise EACBrShoppingPrecos.Create('XML base64 invalido');
    end;
  end;

  if Padding > 2 then
    raise EACBrShoppingPrecos.Create('XML base64 invalido');

  Bytes := DecodeBase64(AnsiString(Base64));
  Stream.Size := 0;

  if Length(Bytes) > 0 then
    Stream.WriteBuffer(Bytes[1], Length(Bytes));

  Stream.Position := 0;
end;

{ TSDPPlataforma }

constructor TSDPPlataforma.Create(Collection: TCollection);
begin
  inherited Create(Collection);
end;

destructor TSDPPlataforma.Destroy;
begin
  inherited Destroy;
end;

procedure TSDPPlataforma.Limpar;
begin
  inherited Limpar;
  FID := 0;
  FTitulo := '';
  FIP := '';
  FTipo := '';
  FPlataformaPaiID := 0;
  FAtivo := False;
  FIcone := '';
end;

procedure TSDPPlataforma.SetID(const Value: Integer);
begin
  FID := Value;
  Informar('id');
end;

procedure TSDPPlataforma.SetTitulo(const Value: string);
begin
  FTitulo := Value;
  Informar('titulo');
end;

procedure TSDPPlataforma.SetIP(const Value: string);
begin
  FIP := Value;
  Informar('ip');
end;

procedure TSDPPlataforma.SetTipo(const Value: string);
begin
  FTipo := Value;
  Informar('tipo');
end;

procedure TSDPPlataforma.SetPlataformaPaiID(const Value: Integer);
begin
  FPlataformaPaiID := Value;
  Informar('plataforma_pai_id');
end;

procedure TSDPPlataforma.SetAtivo(const Value: Boolean);
begin
  FAtivo := Value;
  Informar('ativo');
end;

procedure TSDPPlataforma.SetIcone(const Value: string);
begin
  FIcone := Value;
  Informar('icone');
end;

procedure TSDPPlataforma.LerJSON(J: TACBrJSONObject);
begin
  inherited LerJSON(J);

  if LerCampo(J, 'id') then
    ID := J.AsInteger['id'];

  if LerCampo(J, 'titulo') then
    Titulo := J.AsString['titulo'];

  if LerCampo(J, 'ip') then
    IP := J.AsString['ip'];

  if LerCampo(J, 'tipo') then
    Tipo := J.AsString['tipo'];

  if LerCampo(J, 'plataforma_pai_id') then
    PlataformaPaiID := J.AsInteger['plataforma_pai_id'];

  if LerCampo(J, 'ativo') then
    Ativo := J.AsBoolean['ativo'];

  if LerCampo(J, 'icone') then
    Icone := J.AsString['icone'];
end;

function TSDPPlataforma.GerarJSON: string;
begin
  Result := '';
  Emitir(Result, 'id', IntToStr(FID));
  Emitir(Result, 'titulo', SDPQuote(FTitulo));
  Emitir(Result, 'ip', SDPQuote(FIP));
  Emitir(Result, 'tipo', SDPQuote(FTipo));
  Emitir(Result, 'plataforma_pai_id', IntToStr(FPlataformaPaiID));
  Emitir(Result, 'ativo', SDPBool(FAtivo));
  Emitir(Result, 'icone', SDPQuote(FIcone));
  Result := '{' + Result + '}';
end;

{ TSDPPlataformaLista }

constructor TSDPPlataformaLista.Create;
begin
  inherited Create(TSDPPlataforma);
end;

function TSDPPlataformaLista.Add: TSDPPlataforma;
begin
  Result := TSDPPlataforma(inherited Add);
end;

function TSDPPlataformaLista.GetItem(Index: Integer): TSDPPlataforma;
begin
  Result := TSDPPlataforma(inherited Items[Index]);
end;

{ TSDPIntegracao }

constructor TSDPIntegracao.Create(Collection: TCollection);
begin
  inherited Create(Collection);
end;

destructor TSDPIntegracao.Destroy;
begin
  inherited Destroy;
end;

procedure TSDPIntegracao.Limpar;
begin
  inherited Limpar;
  FIntegracaoID := '';
  FDescricaoPlataforma := '';
  FPlataformaID := 0;
  FPlataforma := '';
end;

procedure TSDPIntegracao.SetIntegracaoID(const Value: string);
begin
  FIntegracaoID := Value;
  Informar('integracao_id');
end;

procedure TSDPIntegracao.SetDescricaoPlataforma(const Value: string);
begin
  FDescricaoPlataforma := Value;
  Informar('descricao_plataforma');
end;

procedure TSDPIntegracao.SetPlataformaID(const Value: Integer);
begin
  FPlataformaID := Value;
  Informar('plataforma_id');
end;

procedure TSDPIntegracao.SetPlataforma(const Value: string);
begin
  FPlataforma := Value;
  Informar('plataforma');
end;

procedure TSDPIntegracao.LerJSON(J: TACBrJSONObject);
begin
  inherited LerJSON(J);

  if LerCampo(J, 'integracao_id') then
    IntegracaoID := J.AsString['integracao_id'];

  if LerCampo(J, 'descricao_plataforma') then
    DescricaoPlataforma := J.AsString['descricao_plataforma'];

  if LerCampo(J, 'plataforma_id') then
    PlataformaID := J.AsInteger['plataforma_id'];

  if LerCampo(J, 'plataforma') then
    Plataforma := J.AsString['plataforma'];
end;

function TSDPIntegracao.GerarJSON: string;
begin
  Result := '';
  Emitir(Result, 'integracao_id', SDPQuote(FIntegracaoID));
  Emitir(Result, 'descricao_plataforma', SDPQuote(FDescricaoPlataforma));
  Emitir(Result, 'plataforma_id', IntToStr(FPlataformaID));
  Emitir(Result, 'plataforma', SDPQuote(FPlataforma));
  Result := '{' + Result + '}';
end;

{ TSDPIntegracaoLista }

constructor TSDPIntegracaoLista.Create;
begin
  inherited Create(TSDPIntegracao);
end;

function TSDPIntegracaoLista.Add: TSDPIntegracao;
begin
  Result := TSDPIntegracao(inherited Add);
end;

function TSDPIntegracaoLista.GetItem(Index: Integer): TSDPIntegracao;
begin
  Result := TSDPIntegracao(inherited Items[Index]);
end;

{ TSDPEstoqueIntegracao }

constructor TSDPEstoqueIntegracao.Create(Collection: TCollection);
begin
  inherited Create(Collection);
end;

destructor TSDPEstoqueIntegracao.Destroy;
begin
  inherited Destroy;
end;

procedure TSDPEstoqueIntegracao.Limpar;
begin
  inherited Limpar;
  FSKU := '';
  FEstoque := 0;
  FUltimaAtualizacao := 0;
end;

procedure TSDPEstoqueIntegracao.SetSKU(const Value: string);
begin
  FSKU := Value;
  Informar('sku');
end;

procedure TSDPEstoqueIntegracao.SetEstoque(const Value: Integer);
begin
  FEstoque := Value;
  Informar('estoque');
end;

procedure TSDPEstoqueIntegracao.SetUltimaAtualizacao(const Value: TDateTime);
begin
  FUltimaAtualizacao := Value;
  Informar('ultima_atualizacao');
end;

procedure TSDPEstoqueIntegracao.LerJSON(J: TACBrJSONObject);
begin
  inherited LerJSON(J);

  if LerCampo(J, 'sku') then
    SKU := J.AsString['sku'];

  if LerCampo(J, 'estoque') then
    Estoque := J.AsInteger['estoque'];

  if LerCampo(J, 'ultima_atualizacao') then
    UltimaAtualizacao := SDPData(J.AsString['ultima_atualizacao']);
end;

function TSDPEstoqueIntegracao.GerarJSON: string;
begin
  Result := '';
  Emitir(Result, 'sku', SDPQuote(FSKU));
  Emitir(Result, 'estoque', IntToStr(FEstoque));
  Emitir(Result, 'ultima_atualizacao', SDPQuote(FormatDateTimeBr(FUltimaAtualizacao, 'yyyy-mm-dd hh:nn:ss')));
  Result := '{' + Result + '}';
end;

{ TSDPEstoqueIntegracaoLista }

constructor TSDPEstoqueIntegracaoLista.Create;
begin
  inherited Create(TSDPEstoqueIntegracao);
end;

function TSDPEstoqueIntegracaoLista.Add: TSDPEstoqueIntegracao;
begin
  Result := TSDPEstoqueIntegracao(inherited Add);
end;

function TSDPEstoqueIntegracaoLista.GetItem(Index: Integer): TSDPEstoqueIntegracao;
begin
  Result := TSDPEstoqueIntegracao(inherited Items[Index]);
end;

{ TSDPPrecoIntegracao }

constructor TSDPPrecoIntegracao.Create(Collection: TCollection);
begin
  inherited Create(Collection);
end;

destructor TSDPPrecoIntegracao.Destroy;
begin
  inherited Destroy;
end;

procedure TSDPPrecoIntegracao.Limpar;
begin
  inherited Limpar;
  FSKU := '';
  FPreco := 0;
  FPrecoPromocao := 0;
  FInicioPromocao := 0;
  FTerminoPromocao := 0;
  FUltimaAtualizacao := 0;
end;

procedure TSDPPrecoIntegracao.SetSKU(const Value: string);
begin
  FSKU := Value;
  Informar('sku');
end;

procedure TSDPPrecoIntegracao.SetPreco(const Value: Currency);
begin
  FPreco := Value;
  Informar('preco');
end;

procedure TSDPPrecoIntegracao.SetPrecoPromocao(const Value: Currency);
begin
  FPrecoPromocao := Value;
  Informar('preco_promocao');
end;

procedure TSDPPrecoIntegracao.SetInicioPromocao(const Value: TDateTime);
begin
  FInicioPromocao := Value;
  Informar('inicio_promocao');
end;

procedure TSDPPrecoIntegracao.SetTerminoPromocao(const Value: TDateTime);
begin
  FTerminoPromocao := Value;
  Informar('termino_promocao');
end;

procedure TSDPPrecoIntegracao.SetUltimaAtualizacao(const Value: TDateTime);
begin
  FUltimaAtualizacao := Value;
  Informar('ultima_atualizacao');
end;

procedure TSDPPrecoIntegracao.LerJSON(J: TACBrJSONObject);
begin
  inherited LerJSON(J);

  if LerCampo(J, 'sku') then
    SKU := J.AsString['sku'];

  if LerCampo(J, 'preco') then
    Preco := J.AsCurrency['preco'];

  if LerCampo(J, 'preco_promocao') then
    PrecoPromocao := J.AsCurrency['preco_promocao'];

  if LerCampo(J, 'inicio_promocao') then
    InicioPromocao := SDPData(J.AsString['inicio_promocao']);

  if LerCampo(J, 'termino_promocao') then
    TerminoPromocao := SDPData(J.AsString['termino_promocao']);

  if LerCampo(J, 'ultima_atualizacao') then
    UltimaAtualizacao := SDPData(J.AsString['ultima_atualizacao']);
end;

function TSDPPrecoIntegracao.GerarJSON: string;
begin
  Result := '';
  Emitir(Result, 'sku', SDPQuote(FSKU));
  Emitir(Result, 'preco', SDPNumero(FPreco));
  Emitir(Result, 'preco_promocao', SDPNumero(FPrecoPromocao));
  Emitir(Result, 'inicio_promocao', SDPQuote(FormatDateTimeBr(FInicioPromocao, 'yyyy-mm-dd hh:nn:ss')));
  Emitir(Result, 'termino_promocao', SDPQuote(FormatDateTimeBr(FTerminoPromocao, 'yyyy-mm-dd hh:nn:ss')));
  Emitir(Result, 'ultima_atualizacao', SDPQuote(FormatDateTimeBr(FUltimaAtualizacao, 'yyyy-mm-dd hh:nn:ss')));
  Result := '{' + Result + '}';
end;

{ TSDPPrecoIntegracaoLista }

constructor TSDPPrecoIntegracaoLista.Create;
begin
  inherited Create(TSDPPrecoIntegracao);
end;

function TSDPPrecoIntegracaoLista.Add: TSDPPrecoIntegracao;
begin
  Result := TSDPPrecoIntegracao(inherited Add);
end;

function TSDPPrecoIntegracaoLista.GetItem(Index: Integer): TSDPPrecoIntegracao;
begin
  Result := TSDPPrecoIntegracao(inherited Items[Index]);
end;

{ TSDPOpcaoPlataforma }

constructor TSDPOpcaoPlataforma.Create(Collection: TCollection);
begin
  inherited Create(Collection);
end;

destructor TSDPOpcaoPlataforma.Destroy;
begin
  inherited Destroy;
end;

procedure TSDPOpcaoPlataforma.Limpar;
begin
  inherited Limpar;
  FID := '';
  FNome := '';
end;

procedure TSDPOpcaoPlataforma.SetID(const Value: string);
begin
  FID := Value;
  Informar('id');
end;

procedure TSDPOpcaoPlataforma.SetNome(const Value: string);
begin
  FNome := Value;
  Informar('nome');
end;

procedure TSDPOpcaoPlataforma.LerJSON(J: TACBrJSONObject);
begin
  inherited LerJSON(J);

  if LerCampo(J, 'id') then
    ID := J.AsString['id'];

  if LerCampo(J, 'nome') then
    Nome := J.AsString['nome'];
end;

function TSDPOpcaoPlataforma.GerarJSON: string;
begin
  Result := '';
  Emitir(Result, 'id', SDPQuote(FID));
  Emitir(Result, 'nome', SDPQuote(FNome));
  Result := '{' + Result + '}';
end;

{ TSDPOpcaoPlataformaLista }

constructor TSDPOpcaoPlataformaLista.Create;
begin
  inherited Create(TSDPOpcaoPlataforma);
end;

function TSDPOpcaoPlataformaLista.Add: TSDPOpcaoPlataforma;
begin
  Result := TSDPOpcaoPlataforma(inherited Add);
end;

function TSDPOpcaoPlataformaLista.GetItem(Index: Integer): TSDPOpcaoPlataforma;
begin
  Result := TSDPOpcaoPlataforma(inherited Items[Index]);
end;

{ TSDPSituacaoPersonalizada }

constructor TSDPSituacaoPersonalizada.Create(Collection: TCollection);
begin
  inherited Create(Collection);
end;

destructor TSDPSituacaoPersonalizada.Destroy;
begin
  inherited Destroy;
end;

procedure TSDPSituacaoPersonalizada.Limpar;
begin
  inherited Limpar;
  FID := 0;
  FSituacao := '';
end;

procedure TSDPSituacaoPersonalizada.SetID(const Value: Integer);
begin
  FID := Value;
  Informar('id');
end;

procedure TSDPSituacaoPersonalizada.SetSituacao(const Value: string);
begin
  FSituacao := Value;
  Informar('situacao');
end;

procedure TSDPSituacaoPersonalizada.LerJSON(J: TACBrJSONObject);
begin
  inherited LerJSON(J);

  if LerCampo(J, 'id') then
    ID := J.AsInteger['id'];

  if LerCampo(J, 'situacao') then
    Situacao := J.AsString['situacao'];
end;

function TSDPSituacaoPersonalizada.GerarJSON: string;
begin
  Result := '';
  Emitir(Result, 'id', IntToStr(FID));
  Emitir(Result, 'situacao', SDPQuote(FSituacao));
  Result := '{' + Result + '}';
end;

{ TSDPSituacaoPersonalizadaLista }

constructor TSDPSituacaoPersonalizadaLista.Create;
begin
  inherited Create(TSDPSituacaoPersonalizada);
end;

function TSDPSituacaoPersonalizadaLista.Add: TSDPSituacaoPersonalizada;
begin
  Result := TSDPSituacaoPersonalizada(inherited Add);
end;

function TSDPSituacaoPersonalizadaLista.GetItem(Index: Integer): TSDPSituacaoPersonalizada;
begin
  Result := TSDPSituacaoPersonalizada(inherited Items[Index]);
end;

{ TSDPDeposito }

constructor TSDPDeposito.Create(Collection: TCollection);
begin
  inherited Create(Collection);
end;

destructor TSDPDeposito.Destroy;
begin
  inherited Destroy;
end;

procedure TSDPDeposito.Limpar;
begin
  inherited Limpar;
  FID := '';
  FEstoque := '';
end;

procedure TSDPDeposito.SetID(const Value: string);
begin
  FID := Value;
  Informar('id');
end;

procedure TSDPDeposito.SetEstoque(const Value: string);
begin
  FEstoque := Value;
  Informar('estoque');
end;

procedure TSDPDeposito.LerJSON(J: TACBrJSONObject);
begin
  inherited LerJSON(J);

  if LerCampo(J, 'id') then
    ID := J.AsString['id'];

  if LerCampo(J, 'estoque') then
    Estoque := J.AsString['estoque'];
end;

function TSDPDeposito.GerarJSON: string;
begin
  Result := '';
  Emitir(Result, 'id', SDPQuote(FID));
  Emitir(Result, 'estoque', SDPQuote(FEstoque));
  Result := '{' + Result + '}';
end;

{ TSDPDepositoLista }

constructor TSDPDepositoLista.Create;
begin
  inherited Create(TSDPDeposito);
end;

function TSDPDepositoLista.Add: TSDPDeposito;
begin
  Result := TSDPDeposito(inherited Add);
end;

function TSDPDepositoLista.GetItem(Index: Integer): TSDPDeposito;
begin
  Result := TSDPDeposito(inherited Items[Index]);
end;

{ TSDPEstoqueAnuncio }

constructor TSDPEstoqueAnuncio.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FDocas := TSDPDepositoLista.Create;
end;

destructor TSDPEstoqueAnuncio.Destroy;
begin
  FDocas.Free;
  inherited Destroy;
end;

procedure TSDPEstoqueAnuncio.Limpar;
begin
  inherited Limpar;
  FProdutoID := '';
  FSKU := '';
  FSKUPai := '';
  FSKUVariacaoPai := '';
  FEstoque := 0;
  FDiasEntrega := 0;
  FDocas.Clear;
end;

procedure TSDPEstoqueAnuncio.SetProdutoID(const Value: string);
begin
  FProdutoID := Value;
  Informar('ProdutoID');
end;

procedure TSDPEstoqueAnuncio.SetSKU(const Value: string);
begin
  FSKU := Value;
  Informar('SKU');
end;

procedure TSDPEstoqueAnuncio.SetSKUPai(const Value: string);
begin
  FSKUPai := Value;
  Informar('SKUPai');
end;

procedure TSDPEstoqueAnuncio.SetSKUVariacaoPai(const Value: string);
begin
  FSKUVariacaoPai := Value;
  Informar('SKUVariacaoPai');
end;

procedure TSDPEstoqueAnuncio.SetEstoque(const Value: Integer);
begin
  FEstoque := Value;
  Informar('Estoque');
end;

procedure TSDPEstoqueAnuncio.SetDiasEntrega(const Value: Integer);
begin
  FDiasEntrega := Value;
  Informar('DiasEntrega');
end;

procedure TSDPEstoqueAnuncio.LerJSON(J: TACBrJSONObject);
begin
  inherited LerJSON(J);

  if LerCampo(J, 'ProdutoID') then
    ProdutoID := J.AsString['ProdutoID'];

  if LerCampo(J, 'SKU') then
    SKU := J.AsString['SKU'];

  if LerCampo(J, 'SKUPai') then
    SKUPai := J.AsString['SKUPai'];

  if LerCampo(J, 'SKUVariacaoPai') then
    SKUVariacaoPai := J.AsString['SKUVariacaoPai'];

  if LerCampo(J, 'Estoque') then
    Estoque := J.AsInteger['Estoque'];

  if LerCampo(J, 'DiasEntrega') then
    DiasEntrega := J.AsInteger['DiasEntrega'];

  if J.IsJSONArray('Docas') then
    FDocas.LerJSON(J.AsJSONArray['Docas']);
end;

function TSDPEstoqueAnuncio.GerarJSON: string;
begin
  Result := '';
  Emitir(Result, 'ProdutoID', SDPQuote(FProdutoID));
  Emitir(Result, 'SKU', SDPQuote(FSKU));
  Emitir(Result, 'SKUPai', SDPQuote(FSKUPai));
  Emitir(Result, 'SKUVariacaoPai', SDPQuote(FSKUVariacaoPai));
  Emitir(Result, 'Estoque', IntToStr(FEstoque));
  Emitir(Result, 'DiasEntrega', IntToStr(FDiasEntrega));
  SDPPar(Result, 'Docas', FDocas.GerarJSON);
  Result := '{' + Result + '}';
end;

{ TSDPEstoqueAnuncioLista }

constructor TSDPEstoqueAnuncioLista.Create;
begin
  inherited Create(TSDPEstoqueAnuncio);
end;

function TSDPEstoqueAnuncioLista.Add: TSDPEstoqueAnuncio;
begin
  Result := TSDPEstoqueAnuncio(inherited Add);
end;

function TSDPEstoqueAnuncioLista.GetItem(Index: Integer): TSDPEstoqueAnuncio;
begin
  Result := TSDPEstoqueAnuncio(inherited Items[Index]);
end;

{ TSDPPrecoAnuncio }

constructor TSDPPrecoAnuncio.Create(Collection: TCollection);
begin
  inherited Create(Collection);
end;

destructor TSDPPrecoAnuncio.Destroy;
begin
  inherited Destroy;
end;

procedure TSDPPrecoAnuncio.Limpar;
begin
  inherited Limpar;
  FProdutoID := '';
  FSKU := '';
  FSKUPai := '';
  FSKUVariacaoPai := '';
  FPreco := 0;
  FPrecoPromocao := 0;
  FInicioPromocao := 0;
  FTerminoPromocao := 0;
end;

procedure TSDPPrecoAnuncio.SetProdutoID(const Value: string);
begin
  FProdutoID := Value;
  Informar('ProdutoID');
end;

procedure TSDPPrecoAnuncio.SetSKU(const Value: string);
begin
  FSKU := Value;
  Informar('SKU');
end;

procedure TSDPPrecoAnuncio.SetSKUPai(const Value: string);
begin
  FSKUPai := Value;
  Informar('SKUPai');
end;

procedure TSDPPrecoAnuncio.SetSKUVariacaoPai(const Value: string);
begin
  FSKUVariacaoPai := Value;
  Informar('SKUVariacaoPai');
end;

procedure TSDPPrecoAnuncio.SetPreco(const Value: Currency);
begin
  FPreco := Value;
  Informar('Preco');
end;

procedure TSDPPrecoAnuncio.SetPrecoPromocao(const Value: Currency);
begin
  FPrecoPromocao := Value;
  Informar('PrecoPromocao');
end;

procedure TSDPPrecoAnuncio.SetInicioPromocao(const Value: TDateTime);
begin
  FInicioPromocao := Value;
  Informar('InicioPromocao');
end;

procedure TSDPPrecoAnuncio.SetTerminoPromocao(const Value: TDateTime);
begin
  FTerminoPromocao := Value;
  Informar('TerminoPromocao');
end;

procedure TSDPPrecoAnuncio.LerJSON(J: TACBrJSONObject);
begin
  inherited LerJSON(J);

  if LerCampo(J, 'ProdutoID') then
    ProdutoID := J.AsString['ProdutoID'];

  if LerCampo(J, 'SKU') then
    SKU := J.AsString['SKU'];

  if LerCampo(J, 'SKUPai') then
    SKUPai := J.AsString['SKUPai'];

  if LerCampo(J, 'SKUVariacaoPai') then
    SKUVariacaoPai := J.AsString['SKUVariacaoPai'];

  if LerCampo(J, 'Preco') then
    Preco := J.AsCurrency['Preco'];

  if LerCampo(J, 'PrecoPromocao') then
    PrecoPromocao := J.AsCurrency['PrecoPromocao'];

  if LerCampo(J, 'InicioPromocao') then
    InicioPromocao := SDPData(J.AsString['InicioPromocao']);

  if LerCampo(J, 'TerminoPromocao') then
    TerminoPromocao := SDPData(J.AsString['TerminoPromocao']);
end;

function TSDPPrecoAnuncio.GerarJSON: string;
begin
  Result := '';
  Emitir(Result, 'ProdutoID', SDPQuote(FProdutoID));
  Emitir(Result, 'SKU', SDPQuote(FSKU));
  Emitir(Result, 'SKUPai', SDPQuote(FSKUPai));
  Emitir(Result, 'SKUVariacaoPai', SDPQuote(FSKUVariacaoPai));
  Emitir(Result, 'Preco', SDPNumero(FPreco));
  Emitir(Result, 'PrecoPromocao', SDPNumero(FPrecoPromocao));
  Emitir(Result, 'InicioPromocao', SDPQuote(FormatDateTimeBr(FInicioPromocao, 'yyyy-mm-dd hh:nn:ss')));
  Emitir(Result, 'TerminoPromocao', SDPQuote(FormatDateTimeBr(FTerminoPromocao, 'yyyy-mm-dd hh:nn:ss')));
  Result := '{' + Result + '}';
end;

{ TSDPPrecoAnuncioLista }

constructor TSDPPrecoAnuncioLista.Create;
begin
  inherited Create(TSDPPrecoAnuncio);
end;

function TSDPPrecoAnuncioLista.Add: TSDPPrecoAnuncio;
begin
  Result := TSDPPrecoAnuncio(inherited Add);
end;

function TSDPPrecoAnuncioLista.GetItem(Index: Integer): TSDPPrecoAnuncio;
begin
  Result := TSDPPrecoAnuncio(inherited Items[Index]);
end;

{ TSDPResultadoAnuncio }

constructor TSDPResultadoAnuncio.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FDocas := TStringList.Create;
end;

destructor TSDPResultadoAnuncio.Destroy;
begin
  FDocas.Free;
  inherited Destroy;
end;

procedure TSDPResultadoAnuncio.Limpar;
begin
  inherited Limpar;
  FProdutoID := '';
  FSKU := '';
  FSKUPai := '';
  FSKUVariacaoPai := '';
  FSucesso := False;
  FMensagem := '';
  FDiasEntrega := 0;
  FDocas.Clear;
end;

procedure TSDPResultadoAnuncio.SetProdutoID(const Value: string);
begin
  FProdutoID := Value;
  Informar('ProdutoID');
end;

procedure TSDPResultadoAnuncio.SetSKU(const Value: string);
begin
  FSKU := Value;
  Informar('SKU');
end;

procedure TSDPResultadoAnuncio.SetSKUPai(const Value: string);
begin
  FSKUPai := Value;
  Informar('SKUPai');
end;

procedure TSDPResultadoAnuncio.SetSKUVariacaoPai(const Value: string);
begin
  FSKUVariacaoPai := Value;
  Informar('SKUVariacaoPai');
end;

procedure TSDPResultadoAnuncio.SetSucesso(const Value: Boolean);
begin
  FSucesso := Value;
  Informar('status');
end;

procedure TSDPResultadoAnuncio.SetMensagem(const Value: string);
begin
  FMensagem := Value;
  Informar('message');
end;

procedure TSDPResultadoAnuncio.SetDiasEntrega(const Value: Integer);
begin
  FDiasEntrega := Value;
  Informar('DiasEntrega');
end;

procedure TSDPResultadoAnuncio.LerJSON(J: TACBrJSONObject);
var
  I: Integer;
  A: TACBrJSONArray;
begin
  inherited LerJSON(J);

  if LerCampo(J, 'ProdutoID') then
    ProdutoID := J.AsString['ProdutoID'];

  if LerCampo(J, 'SKU') then
    SKU := J.AsString['SKU'];

  if LerCampo(J, 'SKUPai') then
    SKUPai := J.AsString['SKUPai'];

  if LerCampo(J, 'SKUVariacaoPai') then
    SKUVariacaoPai := J.AsString['SKUVariacaoPai'];

  if LerCampo(J, 'status') then
    Sucesso := J.AsBoolean['status'];

  if LerCampo(J, 'message') then
    Mensagem := J.AsString['message'];

  if LerCampo(J, 'DiasEntrega') then
    DiasEntrega := J.AsInteger['DiasEntrega'];

  if J.IsJSONArray('Docas') then
  begin
    A := J.AsJSONArray['Docas'];
    for I := 0 to A.Count - 1 do
      FDocas.Add(A.Items[I]);
  end;
end;

function TSDPResultadoAnuncio.GerarJSON: string;
var
  I: Integer;
  S: string;
begin
  Result := '';
  Emitir(Result, 'ProdutoID', SDPQuote(FProdutoID));
  Emitir(Result, 'SKU', SDPQuote(FSKU));
  Emitir(Result, 'SKUPai', SDPQuote(FSKUPai));
  Emitir(Result, 'SKUVariacaoPai', SDPQuote(FSKUVariacaoPai));
  Emitir(Result, 'status', SDPBool(FSucesso));
  Emitir(Result, 'message', SDPQuote(FMensagem));
  Emitir(Result, 'DiasEntrega', IntToStr(FDiasEntrega));

  S := '';
  for I := 0 to FDocas.Count - 1 do
  begin
    if I > 0 then
      S := S + ',';
    S := S + SDPQuote(FDocas[I]);
  end;
  SDPPar(Result, 'Docas', '[' + S + ']');
  Result := '{' + Result + '}';
end;

{ TSDPResultadoAnuncioLista }

constructor TSDPResultadoAnuncioLista.Create;
begin
  inherited Create(TSDPResultadoAnuncio);
end;

function TSDPResultadoAnuncioLista.Add: TSDPResultadoAnuncio;
begin
  Result := TSDPResultadoAnuncio(inherited Add);
end;

function TSDPResultadoAnuncioLista.GetItem(Index: Integer): TSDPResultadoAnuncio;
begin
  Result := TSDPResultadoAnuncio(inherited Items[Index]);
end;

{ TSDPAtributoEnvio }

constructor TSDPAtributoEnvio.Create(Collection: TCollection);
begin
  inherited Create(Collection);
end;

destructor TSDPAtributoEnvio.Destroy;
begin
  inherited Destroy;
end;

procedure TSDPAtributoEnvio.Limpar;
begin
  inherited Limpar;
  FCategoria := '';
  FChaveERP := '';
  FValorERP := '';
  FChavePlataforma := '';
  FValorPlataforma := '';
  FAtributoID := '';
end;

procedure TSDPAtributoEnvio.SetCategoria(const Value: string);
begin
  FCategoria := Value;
  Informar('categoria');
end;

procedure TSDPAtributoEnvio.SetChaveERP(const Value: string);
begin
  FChaveERP := Value;
  Informar('chave_erp');
end;

procedure TSDPAtributoEnvio.SetValorERP(const Value: string);
begin
  FValorERP := Value;
  Informar('valor_erp');
end;

procedure TSDPAtributoEnvio.SetChavePlataforma(const Value: string);
begin
  FChavePlataforma := Value;
  Informar('chave_plataforma');
end;

procedure TSDPAtributoEnvio.SetValorPlataforma(const Value: string);
begin
  FValorPlataforma := Value;
  Informar('valor_plataforma');
end;

procedure TSDPAtributoEnvio.SetAtributoID(const Value: string);
begin
  FAtributoID := Value;
  Informar('atributo_id');
end;

procedure TSDPAtributoEnvio.LerJSON(J: TACBrJSONObject);
begin
  inherited LerJSON(J);

  if LerCampo(J, 'categoria') then
    Categoria := J.AsString['categoria'];

  if LerCampo(J, 'chave_erp') then
    ChaveERP := J.AsString['chave_erp'];

  if LerCampo(J, 'valor_erp') then
    ValorERP := J.AsString['valor_erp'];

  if LerCampo(J, 'chave_plataforma') then
    ChavePlataforma := J.AsString['chave_plataforma'];

  if LerCampo(J, 'valor_plataforma') then
    ValorPlataforma := J.AsString['valor_plataforma'];

  if LerCampo(J, 'atributo_id') then
    AtributoID := J.AsString['atributo_id'];
end;

function TSDPAtributoEnvio.GerarJSON: string;
begin
  Result := '';
  Emitir(Result, 'categoria', SDPQuote(FCategoria));
  Emitir(Result, 'chave_erp', SDPQuote(FChaveERP));
  Emitir(Result, 'valor_erp', SDPQuote(FValorERP));
  Emitir(Result, 'chave_plataforma', SDPQuote(FChavePlataforma));
  Emitir(Result, 'valor_plataforma', SDPQuote(FValorPlataforma));
  Emitir(Result, 'atributo_id', SDPQuote(FAtributoID));
  Result := '{' + Result + '}';
end;

{ TSDPAtributoEnvioLista }

constructor TSDPAtributoEnvioLista.Create;
begin
  inherited Create(TSDPAtributoEnvio);
end;

function TSDPAtributoEnvioLista.Add: TSDPAtributoEnvio;
begin
  Result := TSDPAtributoEnvio(inherited Add);
end;

function TSDPAtributoEnvioLista.GetItem(Index: Integer): TSDPAtributoEnvio;
begin
  Result := TSDPAtributoEnvio(inherited Items[Index]);
end;

{ TSDPVariacaoEnvio }

constructor TSDPVariacaoEnvio.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FAtributos := TSDPAtributoEnvioLista.Create;
end;

destructor TSDPVariacaoEnvio.Destroy;
begin
  FAtributos.Free;
  inherited Destroy;
end;

procedure TSDPVariacaoEnvio.Limpar;
begin
  inherited Limpar;
  FProdutoID := '';
  FSKU := '';
  FAtributos.Clear;
end;

procedure TSDPVariacaoEnvio.SetProdutoID(const Value: string);
begin
  FProdutoID := Value;
  Informar('ProdutoID');
end;

procedure TSDPVariacaoEnvio.SetSKU(const Value: string);
begin
  FSKU := Value;
  Informar('SKU');
end;

procedure TSDPVariacaoEnvio.LerJSON(J: TACBrJSONObject);
begin
  inherited LerJSON(J);

  if LerCampo(J, 'ProdutoID') then
    ProdutoID := J.AsString['ProdutoID'];

  if LerCampo(J, 'SKU') then
    SKU := J.AsString['SKU'];

  if J.IsJSONArray('Atributos') then
    FAtributos.LerJSON(J.AsJSONArray['Atributos']);
end;

function TSDPVariacaoEnvio.GerarJSON: string;
begin
  Result := '';
  Emitir(Result, 'ProdutoID', SDPQuote(FProdutoID));
  Emitir(Result, 'SKU', SDPQuote(FSKU));
  SDPPar(Result, 'Atributos', FAtributos.GerarJSON);
  Result := '{' + Result + '}';
end;

{ TSDPVariacaoEnvioLista }

constructor TSDPVariacaoEnvioLista.Create;
begin
  inherited Create(TSDPVariacaoEnvio);
end;

function TSDPVariacaoEnvioLista.Add: TSDPVariacaoEnvio;
begin
  Result := TSDPVariacaoEnvio(inherited Add);
end;

function TSDPVariacaoEnvioLista.GetItem(Index: Integer): TSDPVariacaoEnvio;
begin
  Result := TSDPVariacaoEnvio(inherited Items[Index]);
end;

{ TSDPProdutoPlataforma }

constructor TSDPProdutoPlataforma.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FCategorias := TSDPOpcaoPlataformaLista.Create;
  FAtributos := TSDPAtributoEnvioLista.Create;
  FVariacoes := TSDPVariacaoEnvioLista.Create;
end;

destructor TSDPProdutoPlataforma.Destroy;
begin
  FCategorias.Free;
  FAtributos.Free;
  FVariacoes.Free;
  inherited Destroy;
end;

procedure TSDPProdutoPlataforma.Limpar;
begin
  inherited Limpar;
  FProdutoID := '';
  FSKU := '';
  FPreco := 0;
  FEstoque := 0;
  FMarcaID := '';
  FCategoriaID := '';
  FDepartamentoID := '';
  FCategorias.Clear;
  FAtributos.Clear;
  FVariacoes.Clear;
end;

procedure TSDPProdutoPlataforma.SetProdutoID(const Value: string);
begin
  FProdutoID := Value;
  Informar('ProdutoID');
end;

procedure TSDPProdutoPlataforma.SetSKU(const Value: string);
begin
  FSKU := Value;
  Informar('SKU');
end;

procedure TSDPProdutoPlataforma.SetPreco(const Value: Currency);
begin
  FPreco := Value;
  Informar('Preco');
end;

procedure TSDPProdutoPlataforma.SetEstoque(const Value: Integer);
begin
  FEstoque := Value;
  Informar('Estoque');
end;

procedure TSDPProdutoPlataforma.SetMarcaID(const Value: string);
begin
  FMarcaID := Value;
  Informar('MarcaID');
end;

procedure TSDPProdutoPlataforma.SetCategoriaID(const Value: string);
begin
  FCategoriaID := Value;
  Informar('CategoriaID');
end;

procedure TSDPProdutoPlataforma.SetDepartamentoID(const Value: string);
begin
  FDepartamentoID := Value;
  Informar('DepartamentoID');
end;

procedure TSDPProdutoPlataforma.LerJSON(J: TACBrJSONObject);
begin
  inherited LerJSON(J);

  if LerCampo(J, 'ProdutoID') then
    ProdutoID := J.AsString['ProdutoID'];

  if LerCampo(J, 'SKU') then
    SKU := J.AsString['SKU'];

  if LerCampo(J, 'Preco') then
    Preco := J.AsCurrency['Preco'];

  if LerCampo(J, 'Estoque') then
    Estoque := J.AsInteger['Estoque'];

  if LerCampo(J, 'MarcaID') then
    MarcaID := J.AsString['MarcaID'];

  if LerCampo(J, 'CategoriaID') then
    CategoriaID := J.AsString['CategoriaID'];

  if LerCampo(J, 'DepartamentoID') then
    DepartamentoID := J.AsString['DepartamentoID'];

  if J.IsJSONArray('Categorias') then
    FCategorias.LerJSON(J.AsJSONArray['Categorias']);

  if J.IsJSONArray('Atributos') then
    FAtributos.LerJSON(J.AsJSONArray['Atributos']);

  if J.IsJSONArray('Variacoes') then
    FVariacoes.LerJSON(J.AsJSONArray['Variacoes']);
end;

function TSDPProdutoPlataforma.GerarJSON: string;
begin
  Result := '';
  Emitir(Result, 'ProdutoID', SDPQuote(FProdutoID));
  Emitir(Result, 'SKU', SDPQuote(FSKU));
  Emitir(Result, 'Preco', SDPNumero(FPreco));
  Emitir(Result, 'Estoque', IntToStr(FEstoque));
  Emitir(Result, 'MarcaID', SDPQuote(FMarcaID));
  Emitir(Result, 'CategoriaID', SDPQuote(FCategoriaID));
  Emitir(Result, 'DepartamentoID', SDPQuote(FDepartamentoID));
  SDPPar(Result, 'Categorias', FCategorias.GerarJSON);
  SDPPar(Result, 'Atributos', FAtributos.GerarJSON);
  SDPPar(Result, 'Variacoes', FVariacoes.GerarJSON);
  Result := '{' + Result + '}';
end;

{ TSDPProdutoPlataformaLista }

constructor TSDPProdutoPlataformaLista.Create;
begin
  inherited Create(TSDPProdutoPlataforma);
end;

function TSDPProdutoPlataformaLista.Add: TSDPProdutoPlataforma;
begin
  Result := TSDPProdutoPlataforma(inherited Add);
end;

function TSDPProdutoPlataformaLista.GetItem(Index: Integer): TSDPProdutoPlataforma;
begin
  Result := TSDPProdutoPlataforma(inherited Items[Index]);
end;

{ TSDPAceiteItem }

constructor TSDPAceiteItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
end;

destructor TSDPAceiteItem.Destroy;
begin
  inherited Destroy;
end;

procedure TSDPAceiteItem.Limpar;
begin
  inherited Limpar;
  FSKU := '';
  FQuantidadeAceita := 0;
end;

procedure TSDPAceiteItem.SetSKU(const Value: string);
begin
  FSKU := Value;
  Informar('sku');
end;

procedure TSDPAceiteItem.SetQuantidadeAceita(const Value: Integer);
begin
  FQuantidadeAceita := Value;
  Informar('quantidade_aceita');
end;

procedure TSDPAceiteItem.LerJSON(J: TACBrJSONObject);
begin
  inherited LerJSON(J);

  if LerCampo(J, 'sku') then
    SKU := J.AsString['sku'];

  if LerCampo(J, 'quantidade_aceita') then
    QuantidadeAceita := J.AsInteger['quantidade_aceita'];
end;

function TSDPAceiteItem.GerarJSON: string;
begin
  Result := '';
  Emitir(Result, 'sku', SDPQuote(FSKU));
  Emitir(Result, 'quantidade_aceita', IntToStr(FQuantidadeAceita));
  Result := '{' + Result + '}';
end;

{ TSDPAceiteItemLista }

constructor TSDPAceiteItemLista.Create;
begin
  inherited Create(TSDPAceiteItem);
end;

function TSDPAceiteItemLista.Add: TSDPAceiteItem;
begin
  Result := TSDPAceiteItem(inherited Add);
end;

function TSDPAceiteItemLista.GetItem(Index: Integer): TSDPAceiteItem;
begin
  Result := TSDPAceiteItem(inherited Items[Index]);
end;

{ TSDPOutraNF }

constructor TSDPOutraNF.Create(Collection: TCollection);
begin
  inherited Create(Collection);
end;

destructor TSDPOutraNF.Destroy;
begin
  inherited Destroy;
end;

procedure TSDPOutraNF.Limpar;
begin
  inherited Limpar;
  FID := '';
  FOrigem := '';
  FTipo := '';
  FDescricao := '';
  FXMLBase64 := '';
end;

procedure TSDPOutraNF.SetID(const Value: string);
begin
  FID := Value;
  Informar('id');
end;

procedure TSDPOutraNF.SetOrigem(const Value: string);
begin
  FOrigem := Value;
  Informar('origem');
end;

procedure TSDPOutraNF.SetTipo(const Value: string);
begin
  FTipo := Value;
  Informar('tipo');
end;

procedure TSDPOutraNF.SetDescricao(const Value: string);
begin
  FDescricao := Value;
  Informar('descricao');
end;

procedure TSDPOutraNF.SetXMLBase64(const Value: string);
begin
  FXMLBase64 := Value;
  Informar('xml');
end;

procedure TSDPOutraNF.LerJSON(J: TACBrJSONObject);
begin
  inherited LerJSON(J);

  if LerCampo(J, 'id') then
    ID := J.AsString['id'];

  if LerCampo(J, 'origem') then
    Origem := J.AsString['origem'];

  if LerCampo(J, 'tipo') then
    Tipo := J.AsString['tipo'];

  if LerCampo(J, 'descricao') then
    Descricao := J.AsString['descricao'];

  if LerCampo(J, 'xml') then
    XMLBase64 := J.AsString['xml'];
end;

function TSDPOutraNF.GerarJSON: string;
begin
  Result := '';
  Emitir(Result, 'id', SDPQuote(FID));
  Emitir(Result, 'origem', SDPQuote(FOrigem));
  Emitir(Result, 'tipo', SDPQuote(FTipo));
  Emitir(Result, 'descricao', SDPQuote(FDescricao));
  Emitir(Result, 'xml', SDPQuote(FXMLBase64));
  Result := '{' + Result + '}';
end;

procedure TSDPOutraNF.SalvarXML(Stream: TStream);
begin
  SDPGravarBase64(XMLBase64, Stream);
end;

{ TSDPOutraNFLista }

constructor TSDPOutraNFLista.Create;
begin
  inherited Create(TSDPOutraNF);
end;

function TSDPOutraNFLista.Add: TSDPOutraNF;
begin
  Result := TSDPOutraNF(inherited Add);
end;

function TSDPOutraNFLista.GetItem(Index: Integer): TSDPOutraNF;
begin
  Result := TSDPOutraNF(inherited Items[Index]);
end;

{ TSDPNotaPedido }

constructor TSDPNotaPedido.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FOutrasNFs := TSDPOutraNFLista.Create;
end;

destructor TSDPNotaPedido.Destroy;
begin
  FOutrasNFs.Free;
  inherited Destroy;
end;

procedure TSDPNotaPedido.Limpar;
begin
  inherited Limpar;
  FSucesso := False;
  FPlataformaID := 0;
  FTempo := 0;
  FPedidoID := '';
  FXMLBase64 := '';
  FOutrasNFs.Clear;
end;

procedure TSDPNotaPedido.SetSucesso(const Value: Boolean);
begin
  FSucesso := Value;
  Informar('status');
end;

procedure TSDPNotaPedido.SetPlataformaID(const Value: Integer);
begin
  FPlataformaID := Value;
  Informar('PlataformaID');
end;

procedure TSDPNotaPedido.SetTempo(const Value: Double);
begin
  FTempo := Value;
  Informar('Tempo');
end;

procedure TSDPNotaPedido.SetPedidoID(const Value: string);
begin
  FPedidoID := Value;
  Informar('PedidoID');
end;

procedure TSDPNotaPedido.SetXMLBase64(const Value: string);
begin
  FXMLBase64 := Value;
  Informar('body');
end;

procedure TSDPNotaPedido.LerJSON(J: TACBrJSONObject);
begin
  inherited LerJSON(J);

  if LerCampo(J, 'status') then
    Sucesso := J.AsBoolean['status'];

  if LerCampo(J, 'PlataformaID') then
    PlataformaID := J.AsInteger['PlataformaID'];

  if LerCampo(J, 'Tempo') then
    Tempo := J.AsFloat['Tempo'];

  if LerCampo(J, 'PedidoID') then
    PedidoID := J.AsString['PedidoID'];

  if LerCampo(J, 'body') then
    XMLBase64 := J.AsString['body'];

  if J.IsJSONArray('OutrasNFs') then
    FOutrasNFs.LerJSON(J.AsJSONArray['OutrasNFs']);
end;

function TSDPNotaPedido.GerarJSON: string;
begin
  Result := '';
  Emitir(Result, 'status', SDPBool(FSucesso));
  Emitir(Result, 'PlataformaID', IntToStr(FPlataformaID));
  Emitir(Result, 'Tempo', SDPNumero(FTempo));
  Emitir(Result, 'PedidoID', SDPQuote(FPedidoID));
  Emitir(Result, 'body', SDPQuote(FXMLBase64));
  SDPPar(Result, 'OutrasNFs', FOutrasNFs.GerarJSON);
  Result := '{' + Result + '}';
end;

procedure TSDPNotaPedido.SalvarXML(Stream: TStream);
begin
  SDPGravarBase64(XMLBase64, Stream);
end;

{ TSDPNotaPedidoLista }

constructor TSDPNotaPedidoLista.Create;
begin
  inherited Create(TSDPNotaPedido);
end;

function TSDPNotaPedidoLista.Add: TSDPNotaPedido;
begin
  Result := TSDPNotaPedido(inherited Add);
end;

function TSDPNotaPedidoLista.GetItem(Index: Integer): TSDPNotaPedido;
begin
  Result := TSDPNotaPedido(inherited Items[Index]);
end;

{ TSDPFiltroXML }

constructor TSDPFiltroXML.Create(Collection: TCollection);
begin
  inherited Create(Collection);
end;

destructor TSDPFiltroXML.Destroy;
begin
  inherited Destroy;
end;

procedure TSDPFiltroXML.Limpar;
begin
  inherited Limpar;
  FDataInicial := 0;
  FDataFinal := 0;
end;

procedure TSDPFiltroXML.SetDataInicial(const Value: TDateTime);
begin
  FDataInicial := Value;
  Informar('dataInicial');
end;

procedure TSDPFiltroXML.SetDataFinal(const Value: TDateTime);
begin
  FDataFinal := Value;
  Informar('dataFinal');
end;

procedure TSDPFiltroXML.LerJSON(J: TACBrJSONObject);
begin
  inherited LerJSON(J);

  if LerCampo(J, 'dataInicial') then
    DataInicial := SDPData(J.AsString['dataInicial']);

  if LerCampo(J, 'dataFinal') then
    DataFinal := SDPData(J.AsString['dataFinal']);
end;

function TSDPFiltroXML.GerarJSON: string;
begin
  Result := '';
  Emitir(Result, 'dataInicial', SDPQuote(FormatDateTimeBr(FDataInicial, 'yyyy-mm-dd hh:nn:ss')));
  Emitir(Result, 'dataFinal', SDPQuote(FormatDateTimeBr(FDataFinal, 'yyyy-mm-dd hh:nn:ss')));
  Result := '{' + Result + '}';
end;

{ TSDPFiltroXMLLista }

constructor TSDPFiltroXMLLista.Create;
begin
  inherited Create(TSDPFiltroXML);
end;

function TSDPFiltroXMLLista.Add: TSDPFiltroXML;
begin
  Result := TSDPFiltroXML(inherited Add);
end;

function TSDPFiltroXMLLista.GetItem(Index: Integer): TSDPFiltroXML;
begin
  Result := TSDPFiltroXML(inherited Items[Index]);
end;

{ TSDPRelatorioXML }

constructor TSDPRelatorioXML.Create(Collection: TCollection);
begin
  inherited Create(Collection);
end;

destructor TSDPRelatorioXML.Destroy;
begin
  inherited Destroy;
end;

procedure TSDPRelatorioXML.Limpar;
begin
  inherited Limpar;
  FID := '';
  FStatus := '';
  FDataCriacao := 0;
  FDataProcessamento := 0;
  FURLArquivo := '';
end;

procedure TSDPRelatorioXML.SetID(const Value: string);
begin
  FID := Value;
  Informar('relatorio_id');
end;

procedure TSDPRelatorioXML.SetStatus(const Value: string);
begin
  FStatus := Value;
  Informar('status');
end;

procedure TSDPRelatorioXML.SetDataCriacao(const Value: TDateTime);
begin
  FDataCriacao := Value;
  Informar('data_criacao');
end;

procedure TSDPRelatorioXML.SetDataProcessamento(const Value: TDateTime);
begin
  FDataProcessamento := Value;
  Informar('data_processamento');
end;

procedure TSDPRelatorioXML.SetURLArquivo(const Value: string);
begin
  FURLArquivo := Value;
  Informar('url_arquivo');
end;

procedure TSDPRelatorioXML.LerJSON(J: TACBrJSONObject);
begin
  inherited LerJSON(J);

  if LerCampo(J, 'relatorio_id') then
    ID := J.AsString['relatorio_id'];

  if LerCampo(J, 'status') then
    Status := J.AsString['status'];

  if LerCampo(J, 'data_criacao') then
    DataCriacao := SDPData(J.AsString['data_criacao']);

  if LerCampo(J, 'data_processamento') then
    DataProcessamento := SDPData(J.AsString['data_processamento']);

  if LerCampo(J, 'url_arquivo') then
    URLArquivo := J.AsString['url_arquivo'];
end;

function TSDPRelatorioXML.GerarJSON: string;
begin
  Result := '';
  Emitir(Result, 'relatorio_id', SDPQuote(FID));
  Emitir(Result, 'status', SDPQuote(FStatus));
  Emitir(Result, 'data_criacao', SDPQuote(FormatDateTimeBr(FDataCriacao, 'yyyy-mm-dd hh:nn:ss')));
  Emitir(Result, 'data_processamento', SDPQuote(FormatDateTimeBr(FDataProcessamento, 'yyyy-mm-dd hh:nn:ss')));
  Emitir(Result, 'url_arquivo', SDPQuote(FURLArquivo));
  Result := '{' + Result + '}';
end;

{ TSDPRelatorioXMLLista }

constructor TSDPRelatorioXMLLista.Create;
begin
  inherited Create(TSDPRelatorioXML);
end;

function TSDPRelatorioXMLLista.Add: TSDPRelatorioXML;
begin
  Result := TSDPRelatorioXML(inherited Add);
end;

function TSDPRelatorioXMLLista.GetItem(Index: Integer): TSDPRelatorioXML;
begin
  Result := TSDPRelatorioXML(inherited Items[Index]);
end;
end.
