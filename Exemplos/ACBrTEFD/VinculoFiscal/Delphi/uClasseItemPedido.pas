unit uClasseItemPedido;

interface

uses
  Classes, SysUtils, Contnrs;

type

  { TItemPedido }

  // Representa um único item do pedido.
  TItemPedido = class
  private
    FCodigo: Integer;
    FDescricao: string;
    FQuantidade: Double;
    FValorUnitario: Currency;
  public
    constructor Create;

    property Codigo: Integer read FCodigo write FCodigo;
    property Descricao: string read FDescricao write FDescricao;
    property Quantidade: Double read FQuantidade write FQuantidade;
    property ValorUnitario: Currency read FValorUnitario write FValorUnitario;

    // Retorna o valor total do item.
    // Quantidade x Valor Unitário.
    function ValorTotal: Currency;
  end;

  { TListaItensPedido }

  // Representa a lista de itens do pedido.
  // Cada posição da lista contém um TItemPedido.
  // No Delphi é usada a TObjectList (Contnrs), compatível desde o Delphi 7,
  // no lugar da lista genérica TFPGObjectList do Lazarus.
  TListaItensPedido = class(TObjectList)
  private
    function GetItem(AIndex: Integer): TItemPedido;
    procedure SetItem(AIndex: Integer; AValue: TItemPedido);
  public

    // Adiciona um novo item à lista e retorna o item criado.
    function AdicionarItem(
      ACodigo: Integer;
      const ADescricao: string;
      AQuantidade: Double;
      AValorUnitario: Currency
    ): TItemPedido;

    // Retorna a quantidade de itens existentes na lista.
    function QuantidadeItens: Integer;

    property Items[AIndex: Integer]: TItemPedido read GetItem write SetItem; default;
  end;

implementation

{ TItemPedido }

constructor TItemPedido.Create;
begin
  inherited Create;

  // Inicializa as propriedades do item.
  FCodigo := 0;
  FDescricao := '';
  FQuantidade := 0;
  FValorUnitario := 0;
end;

function TItemPedido.ValorTotal: Currency;
begin
  // Calcula o valor total do item.
  Result := Quantidade * ValorUnitario;
end;

{ TListaItensPedido }

function TListaItensPedido.GetItem(AIndex: Integer): TItemPedido;
begin
  Result := TItemPedido(inherited Items[AIndex]);
end;

procedure TListaItensPedido.SetItem(AIndex: Integer; AValue: TItemPedido);
begin
  inherited Items[AIndex] := AValue;
end;

function TListaItensPedido.AdicionarItem(
  ACodigo: Integer;
  const ADescricao: string;
  AQuantidade: Double;
  AValorUnitario: Currency
): TItemPedido;
begin
  // Cria um novo item.
  Result := TItemPedido.Create;

  // Preenche os dados do item.
  Result.Codigo := ACodigo;
  Result.Descricao := ADescricao;
  Result.Quantidade := AQuantidade;
  Result.ValorUnitario := AValorUnitario;

  // Adiciona o item à lista.
  Add(Result);
end;

function TListaItensPedido.QuantidadeItens: Integer;
begin
  // Count informa quantos itens existem na lista.
  Result := Count;
end;

end.
