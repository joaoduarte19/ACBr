unit uClasseProduto;

interface

uses
  Classes;

type

  TClasseProduto = class
  private
    FCodigo: Integer;
    FDescricao: string;
    FValorUnitario: Currency;
  public
    property Codigo: Integer read FCodigo write FCodigo;
    property Descricao: string read FDescricao write FDescricao;
    property ValorUnitario: Currency read FValorUnitario write FValorUnitario;
  end;


  TListaProdutos = class
  private
    FLista: TList;

    function GetItem(AIndex: Integer): TClasseProduto;

  public
    constructor Create;
    destructor Destroy; override;

    function Add(ACodigo: Integer; ADescricao: string;
      AValorUnitario: Currency): TClasseProduto;

    function Find(ACodigo: Integer): TClasseProduto;

    function Locate(ACodigo: Integer): Boolean;


    procedure Delete(AIndex: Integer);
    procedure Clear;

    function Count: Integer;

    property Items[AIndex: Integer]: TClasseProduto read GetItem; default;
  end;


implementation


{ TListaProdutos }

constructor TListaProdutos.Create;
begin
  inherited Create;

  FLista := TList.Create;
end;


destructor TListaProdutos.Destroy;
begin
  Clear;

  FLista.Free;

  inherited Destroy;
end;


function TListaProdutos.Add(ACodigo: Integer; ADescricao: string;
  AValorUnitario: Currency): TClasseProduto;
begin
  Result := TClasseProduto.Create;

  Result.Codigo := ACodigo;
  Result.Descricao := ADescricao;
  Result.ValorUnitario := AValorUnitario;

  FLista.Add(Result);
end;


function TListaProdutos.Find(ACodigo: Integer): TClasseProduto;
var
  I: Integer;
  Produto: TClasseProduto;
begin
  Result := nil;

  for I := 0 to FLista.Count - 1 do
  begin
    Produto := TClasseProduto(FLista[I]);

    if Produto.Codigo = ACodigo then
    begin
      Result := Produto;
      Exit;
    end;
  end;
end;


function TListaProdutos.Locate(ACodigo: Integer): Boolean;
begin
  Result := Find(ACodigo) <> nil;
end;


function TListaProdutos.GetItem(AIndex: Integer): TClasseProduto;
begin
  Result := TClasseProduto(FLista[AIndex]);
end;


function TListaProdutos.Count: Integer;
begin
  Result := FLista.Count;
end;


procedure TListaProdutos.Delete(AIndex: Integer);
begin
  TClasseProduto(FLista[AIndex]).Free;

  FLista.Delete(AIndex);
end;


procedure TListaProdutos.Clear;
var
  I: Integer;
begin
  for I := FLista.Count - 1 downto 0 do
    TClasseProduto(FLista[I]).Free;

  FLista.Clear;
end;


end.
