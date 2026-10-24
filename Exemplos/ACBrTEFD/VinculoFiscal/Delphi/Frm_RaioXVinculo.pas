unit Frm_RaioXVinculo;

{
  RAIO-X DO VÍNCULO (apoio didático)

  Mostra, depois da NFC-e autorizada:
    - para cada pagamento: de qual campo da resposta do TEF veio cada tag do
      <detPag> (MapaVinculo, na unit uVinculoPagamentoNFCe);
    - a conferência do comprovante do TEF com o conteúdo mínimo das normas;
    - o trecho <pag> do XML exatamente como foi para a SEFAZ.
}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, ExtCtrls, Grids,
  uVinculoPagamentoNFCe;   // TMapaVinculo

type

  { TfrmRaioXVinculo }

  TfrmRaioXVinculo = class(TForm)
    pnlTopo: TPanel;
    lblTitulo: TLabel;
    lblChave: TLabel;
    sgVinculo: TStringGrid;
    Splitter1: TSplitter;
    pnlBaixo: TPanel;
    gbComprovante: TGroupBox;
    mmComprovante: TMemo;
    gbXML: TGroupBox;
    mmXML: TMemo;
    pnlRodape: TPanel;
    btnFechar: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
  public
    procedure Limpar;
    procedure AdicionarPagamento(const ATitulo: String; const AMapa: TMapaVinculo;
      AConferencia: TStrings);
    procedure ExibirXML(const AXMLPag, AChave: String);
  end;

implementation

{$R *.dfm}

{ TfrmRaioXVinculo }

procedure TfrmRaioXVinculo.FormCreate(Sender: TObject);
begin
  sgVinculo.ColWidths[0] := 200;
  sgVinculo.ColWidths[1] := 210;
  sgVinculo.ColWidths[2] := 210;
  sgVinculo.ColWidths[3] := 80;
  sgVinculo.ColWidths[4] := 220;
  Limpar;
end;

procedure TfrmRaioXVinculo.Limpar;
begin
  sgVinculo.RowCount := 2;
  sgVinculo.Rows[1].Clear;
  sgVinculo.Cells[0, 0] := 'Pagamento';
  sgVinculo.Cells[1, 0] := 'Origem (resposta do TEF)';
  sgVinculo.Cells[2, 0] := 'Valor na origem';
  sgVinculo.Cells[3, 0] := 'Tag NFC-e';
  sgVinculo.Cells[4, 0] := 'Valor na NFC-e';
  mmComprovante.Clear;
  mmXML.Clear;
  lblChave.Caption := '';
end;

procedure TfrmRaioXVinculo.AdicionarPagamento(const ATitulo: String;
  const AMapa: TMapaVinculo; AConferencia: TStrings);
var
  I, LLinha: Integer;
begin
  // A 1ª linha de dados ainda vazia é reaproveitada
  if (sgVinculo.RowCount = 2) and (sgVinculo.Cells[1, 1] = '') then
    LLinha := 1
  else
    LLinha := sgVinculo.RowCount;

  sgVinculo.RowCount := LLinha + Length(AMapa);
  for I := 0 to High(AMapa) do
  begin
    if (I = 0) then
      sgVinculo.Cells[0, LLinha + I] := ATitulo
    else
      sgVinculo.Cells[0, LLinha + I] := '';
    sgVinculo.Cells[1, LLinha + I] := AMapa[I].Origem;
    sgVinculo.Cells[2, LLinha + I] := AMapa[I].ValorOrigem;
    sgVinculo.Cells[3, LLinha + I] := AMapa[I].Tag;
    sgVinculo.Cells[4, LLinha + I] := AMapa[I].ValorTag;
  end;

  if Assigned(AConferencia) and (AConferencia.Count > 0) then
  begin
    mmComprovante.Lines.Add(ATitulo);
    mmComprovante.Lines.AddStrings(AConferencia);
    mmComprovante.Lines.Add('');
  end;
end;

procedure TfrmRaioXVinculo.ExibirXML(const AXMLPag, AChave: String);
begin
  lblChave.Caption := 'NFC-e: ' + AChave;
  mmXML.Lines.Text := AXMLPag;
  if (mmComprovante.Lines.Count = 0) then
    mmComprovante.Lines.Add('Nenhum pagamento pelo TEF nesta venda.');
end;

procedure TfrmRaioXVinculo.btnFecharClick(Sender: TObject);
begin
  Close;
end;

end.
