unit uClassePagamento;

{
  Pagamentos da venda.
  Mesma estrutura do TPagamento / TListaPagamentos do exemplo TEFAPI
  (ACBr\Exemplos\ACBrTEFD\TEFAPI\Delphi\uVendaClass.pas).

  Única diferença: a forma de pagamento já é o tipo da NFC-e
  (FormaPagamento: TpcnFormaPagamento), no lugar de TipoPagamento: String
  ('01', '03'...). Assim o AlimentarNFCe faz apenas: tPag := FormaPagamento.

  Como no exemplo TEFAPI, um pagamento é TEF quando tem NSU (Rede + NSU
  localizam a transação em ACBrTEFAPI1.RespostasTEF).

  Origem do pagamento:
    opSemIntegracao - dinheiro, crédito em loja...
    opTEF           - cartão / PIX pelo TEF (ACBrTEFAPI): tem NSU
    opPSP           - PIX Dinâmico direto no PSP (ACBrPIXCD): tem TxId e e2eid
}

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  Classes, SysUtils, Contnrs,
  pcnConversaoNFe;     // TpcnFormaPagamento

type

  TOrigemPagamento = (opSemIntegracao, opTEF, opPSP);

  { TPagamento }

  TPagamento = class
  private
    FAcrescimo: Double;
    FCancelada: Boolean;
    FConfirmada: Boolean;
    FDesconto: Double;
    FHora: TDateTime;
    FRedeCNPJ: String;
    FNSU: String;
    FRede: String;
    FSaque: Double;
    FFormaPagamento: TpcnFormaPagamento;
    FValorPago: Currency;
    FOrigem: TOrigemPagamento;
    FTxId: String;
    FEndToEndId: String;
  public
    constructor Create;
    procedure Clear;

    // Formas que exigem o grupo <card> (03, 04 e 17)
    class function ExigeDadosCartao(AForma: TpcnFormaPagamento): Boolean;
    function Descricao: String;

    property FormaPagamento: TpcnFormaPagamento read FFormaPagamento write FFormaPagamento;
    property ValorPago: Currency read FValorPago write FValorPago;
    property Hora: TDateTime read FHora write FHora;
    property NSU: String read FNSU write FNSU;
    property Rede: String read FRede write FRede;
    property RedeCNPJ: String read FRedeCNPJ write FRedeCNPJ;
    property Acrescimo: Double read FAcrescimo write FAcrescimo;
    property Desconto: Double read FDesconto write FDesconto;
    property Saque: Double read FSaque write FSaque;
    property Confirmada: Boolean read FConfirmada write FConfirmada;
    property Cancelada: Boolean read FCancelada write FCancelada;

    // PIX via PSP (ACBrPIXCD)
    property Origem: TOrigemPagamento read FOrigem write FOrigem;
    property TxId: String read FTxId write FTxId;               // id da cobrança
    property EndToEndId: String read FEndToEndId write FEndToEndId;  // e2eid do PIX pago
  end;

  { TListaPagamentos }

  TListaPagamentos = class(TObjectList)
  private
    function GetTotalPago: Currency;
  protected
    procedure SetObject(Index: Integer; Item: TPagamento);
    function GetObject(Index: Integer): TPagamento;
  public
    function New: TPagamento;
    function Add(Obj: TPagamento): Integer;
    procedure Insert(Index: Integer; Obj: TPagamento);
    property Objects[Index: Integer]: TPagamento read GetObject write SetObject; default;

    property TotalPago: Currency read GetTotalPago;
    function AcharPagamento(const ARede, ANSU: String; AValor: Double): TPagamento;
    function ConfirmarPagamento(const ARede, ANSU: String; AValor: Double): Boolean;
    function CancelarPagamento(const ARede, ANSU: String; AValor: Double): Boolean;

    // Apoio à tela de pagamento / NFC-e (ignoram pagamentos cancelados)
    function TotalDinheiro: Currency;
    function TotalSaque: Currency;
    function Restante(ATotalVenda: Currency): Currency;
    function Troco(ATotalVenda: Currency): Currency;
    function TemTEF: Boolean;
    function TemPIXPSP: Boolean;
  end;

implementation

uses
  Math;

{ TPagamento }

constructor TPagamento.Create;
begin
  inherited Create;
  Clear;
end;

procedure TPagamento.Clear;
begin
  FFormaPagamento := fpDinheiro;
  FHora := 0;
  FValorPago := 0;
  FNSU := '';
  FRede := '';
  FConfirmada := False;
  FCancelada := False;
  FRedeCNPJ := '';
  FDesconto := 0;
  FAcrescimo := 0;
  FSaque := 0;
  FOrigem := opSemIntegracao;
  FTxId := '';
  FEndToEndId := '';
end;

class function TPagamento.ExigeDadosCartao(AForma: TpcnFormaPagamento): Boolean;
begin
  Result := AForma in [fpCartaoCredito, fpCartaoDebito, fpPagamentoInstantaneo];
end;

function TPagamento.Descricao: String;
begin
  Result := FormaPagamentoToStr(FFormaPagamento) + ' - ' +
    FormaPagamentoToDescricao(FFormaPagamento, '');
  if (FOrigem = opPSP) then
    Result := Result + ' (PSP)';
end;

{ TListaPagamentos }

function TListaPagamentos.GetTotalPago: Currency;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Count-1 do
  begin
    with Objects[I] do
    begin
      if not Cancelada then
        Result := Result + ValorPago;
    end;
  end;

  Result := RoundTo(Result, -2);
end;

procedure TListaPagamentos.SetObject(Index: Integer; Item: TPagamento);
begin
  inherited SetItem(Index, Item);
end;

function TListaPagamentos.GetObject(Index: Integer): TPagamento;
begin
  Result := inherited GetItem(Index) as TPagamento;
end;

function TListaPagamentos.New: TPagamento;
begin
  Result := TPagamento.Create;
  Result.Hora := Now;
  Add(Result);
end;

function TListaPagamentos.Add(Obj: TPagamento): Integer;
begin
  Result := inherited Add(Obj);
end;

procedure TListaPagamentos.Insert(Index: Integer; Obj: TPagamento);
begin
  inherited Insert(Index, Obj);
end;

function TListaPagamentos.AcharPagamento(const ARede, ANSU: String;
  AValor: Double): TPagamento;
var
  I: Integer;
begin
  Result := Nil;
  for I := 0 to Count-1 do
  begin
    if (ARede = Objects[I].Rede) and
       (ANSU = Objects[I].NSU) and
       (AValor = Objects[I].ValorPago) then
    begin
      Result := Objects[I];
      Break;
    end;
  end;
end;

function TListaPagamentos.ConfirmarPagamento(const ARede, ANSU: String;
  AValor: Double): Boolean;
var
  APag: TPagamento;
begin
  APag := AcharPagamento(ARede, ANSU, AValor);
  if Assigned(APag) then
  begin
    APag.Confirmada := True;
    Result := True;
  end
  else
    Result := False;
end;

function TListaPagamentos.CancelarPagamento(const ARede, ANSU: String;
  AValor: Double): Boolean;
var
  APag: TPagamento;
begin
  APag := AcharPagamento(ARede, ANSU, AValor);
  if Assigned(APag) then
  begin
    APag.Cancelada := True;
    Result := True;
  end
  else
    Result := False;
end;

function TListaPagamentos.TotalDinheiro: Currency;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Count-1 do
    if (not Objects[I].Cancelada) and (Objects[I].FormaPagamento = fpDinheiro) then
      Result := Result + Objects[I].ValorPago;
end;

function TListaPagamentos.TotalSaque: Currency;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Count-1 do
    if not Objects[I].Cancelada then
      Result := Result + Objects[I].Saque;
end;

function TListaPagamentos.Restante(ATotalVenda: Currency): Currency;
begin
  Result := ATotalVenda - TotalPago;
  if (Result < 0) then
    Result := 0;
end;

function TListaPagamentos.Troco(ATotalVenda: Currency): Currency;
begin
  Result := TotalPago - ATotalVenda;
  if (Result < 0) then
    Result := 0;
end;

function TListaPagamentos.TemTEF: Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to Count-1 do
    if (not Objects[I].Cancelada) and (Objects[I].NSU <> '') then
    begin
      Result := True;
      Break;
    end;
end;

function TListaPagamentos.TemPIXPSP: Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to Count-1 do
    if (not Objects[I].Cancelada) and (Objects[I].Origem = opPSP) then
    begin
      Result := True;
      Break;
    end;
end;

end.
