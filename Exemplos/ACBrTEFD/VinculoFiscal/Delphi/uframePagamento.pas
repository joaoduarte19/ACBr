unit uframePagamento;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Grids,
  pcnConversaoNFe,     // TpcnFormaPagamento
  ACBrTEFComum, ACBrTEFAPIComum, ACBrTEFAPI,
  ACBrPIXCD,           // TACBrPixCD (PIX Dinâmico via PSP)
  uClassePagamento;

type
  // Uma forma de pagamento do PDV: o tPag da NFC-e + por onde ela é recebida
  TFormaPDV = record
    Forma: TpcnFormaPagamento;
    Origem: TOrigemPagamento;
    Descricao: String;
  end;

  // Disparado ao Confirmar (AConfirmado = True) ou Cancelar (False)
  TPagamentoConcluidoEvent = procedure(Sender: TObject;
    AConfirmado: Boolean) of object;

  { TframePagamento }

  TframePagamento = class(TFrame)
    pnlTotais: TPanel;
    lblTotalTit: TLabel;
    lblTotal: TLabel;
    lblPagoTit: TLabel;
    lblPago: TLabel;
    lblRestanteTit: TLabel;
    lblRestante: TLabel;
    pnlTEF: TPanel;
    gbQRCode: TGroupBox;
    imgQRCode: TImage;
    pnpPrincipal: TPanel;
    sgPagamentos: TStringGrid;
    btnRemover: TButton;
    lblStatusTEF: TLabel;
    btnConfirmar: TButton;
    btnCancelar: TButton;
    gbForma: TGroupBox;
    lblForma: TLabel;
    lblValor: TLabel;
    cbxForma: TComboBox;
    edtValor: TEdit;
    btnAdicionar: TButton;
    gbLog: TGroupBox;
    mLog: TMemo;
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnRemoverClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure edtValorKeyPress(Sender: TObject; var Key: Char);
    procedure FrameResize(Sender: TObject);
  private
    FTotalVenda: Currency;
    FPagamentos: TListaPagamentos;
    FIdentificador: String;   // identificador da venda enviado ao TEF
    FTEFAtivo: Boolean;       // TEF configurado e inicializado
    FEmTEF: Boolean;          // transação TEF em andamento
    FPIXAtivo: Boolean;       // PIX via PSP configurado (ACBrPIXCD)
    FEmPIX: Boolean;          // aguardando o cliente pagar o PIX
    FCancelarPIX: Boolean;    // operador desistiu do PIX em andamento
    FOnConcluir: TPagamentoConcluidoEvent;

    procedure Concluir(AConfirmado: Boolean);

    function TEF: TACBrTEFAPI;
    procedure PrepararTEF;
    function UsarTEF(AForma: TpcnFormaPagamento): Boolean;
    function PIXCD: TACBrPixCD;
    function ArqINI: String;
    procedure PrepararPIX;
    procedure AdicionarPagamentoPIXPSP(AValor: Currency);
    procedure Esperar(AMilissegundos: Cardinal);
    procedure HabilitarTela(AHabilitar: Boolean);
    procedure LigarEventosTela;
    procedure DesligarEventosTela;

    procedure CarregarFormas;
    function FormaSelecionada: TFormaPDV;
    function LerValor: Currency;

    // Iguais ao exemplo TEFAPI (frPrincipal.pas)
    procedure AdicionarPagamento(AForma: TpcnFormaPagamento; AValor: Double);
    procedure ExcluirPagamento(IndicePagto: Integer);
    function AcharTransacaoTEF(IndicePagto: Integer): TACBrTEFResp;
    procedure CancelarVenda;
    procedure AtualizarPagamentosVendaNaInterface;
    procedure AjustarColunasGrade;
    procedure AtualizarTotaisVendaNaInterface;
    procedure AdicionarLinhaLog(const AMensagem: String);
    procedure ExibirQRCode(const DadosQRCode: String);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    // Prepara e exibe o frame para uma nova venda.
    // AIdentificador: nº da operação enviado ao TEF (ex.: nº do pedido)
    procedure Iniciar(ATotalVenda: Currency; APagamentos: TListaPagamentos;
      const AIdentificador: String = '');

    property EmTEF: Boolean read FEmTEF;
    property OnConcluir: TPagamentoConcluidoEvent read FOnConcluir write FOnConcluir;
  end;

implementation

uses
  Math, TypInfo, StrUtils,
  ACBrPIXBase,         // TACBrPIXStatusCobranca
  ACBrNFe.Classes,     // TpagCollectionItem
  uPrincipal, uTEFUtils, uPIXUtils, uVinculoPagamentoNFCe;

{$IFDEF FPC}
  {$R *.lfm}
{$ELSE}
  {$R *.dfm}
{$ENDIF}

const
  CMascaraValor = '#,##0.00';

  // Formas de pagamento do PDV (o cbxForma mostra só as disponíveis).
  // O PIX Dinâmico (17) aparece duas vezes: pelo TEF ou direto no PSP.
  // Nos dois casos a NFC-e recebe o mesmo vínculo (tpIntegra=1, cAut=e2eid).
  // 05, 10, 11 e 12 sem integração (como Dinheiro): só tPag e vPag, sem grupo <card>
  CFormasPDV: array[0..9] of TFormaPDV = (
    (Forma: fpDinheiro;                  Origem: opSemIntegracao; Descricao: '01 - Dinheiro'),
    (Forma: fpCartaoCredito;             Origem: opTEF;           Descricao: '03 - Cartão de Crédito (TEF)'),
    (Forma: fpCartaoDebito;              Origem: opTEF;           Descricao: '04 - Cartão de Débito (TEF)'),
    (Forma: fpCreditoLoja;               Origem: opSemIntegracao; Descricao: '05 - Crédito Loja'),
    (Forma: fpValeAlimentacao;           Origem: opSemIntegracao; Descricao: '10 - Vale Alimentação'),
    (Forma: fpValeRefeicao;              Origem: opSemIntegracao; Descricao: '11 - Vale Refeição'),
    (Forma: fpValePresente;              Origem: opSemIntegracao; Descricao: '12 - Vale Presente'),
    (Forma: fpPagamentoInstantaneo;      Origem: opTEF;           Descricao: '17 - PIX Dinâmico (TEF)'),
    (Forma: fpPagamentoInstantaneo;      Origem: opPSP;           Descricao: '17 - PIX Dinâmico (PSP - ACBrPIXCD)'),
    (Forma: fpCreditoEmLojaPorDevolucao; Origem: opSemIntegracao; Descricao: '21 - Crédito em Loja')
  );

  // PIX via PSP: intervalo entre as consultas do pagamento
  CIntervaloConsultaPIX = 3000;  // ms

{ TframePagamento }

constructor TframePagamento.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  // Mesmas colunas do sgPagamentos do exemplo TEFAPI
  with sgPagamentos do
  begin
    ColCount := 7;
    RowCount := 1;

    Cells[0, 0] := 'Item';
    Cells[1, 0] := 'Forma de Pagamento';
    Cells[2, 0] := 'Valor';
    Cells[3, 0] := 'NSU / e2eid';
    Cells[4, 0] := 'Rede';
    Cells[5, 0] := 'Status';
    Cells[6, 0] := 'CNPJ Credenciadora';
  end;
  AjustarColunasGrade;
end;

procedure TframePagamento.FrameResize(Sender: TObject);
begin
  AjustarColunasGrade;
end;

// Colunas com largura fixa; "NSU / e2eid" ocupa o espaço que sobrar
// (o e2eid do PIX tem 32 caracteres).
procedure TframePagamento.AjustarColunasGrade;
const
  CItem   = 40;
  CForma  = 230;
  CValor  = 80;
  CRede   = 120;
  CStatus = 85;
  CCNPJ   = 130;
var
  LFixas, LLivre: Integer;
begin
  if (sgPagamentos = nil) or (sgPagamentos.ColCount < 7) then
    Exit;   // ainda carregando o .dfm

  with sgPagamentos do
  begin
    LFixas := CItem + CForma + CValor + CRede + CStatus + CCNPJ;
    LLivre := ClientWidth - LFixas - (ColCount * GridLineWidth) - 2;
    if (LLivre < 120) then
      LLivre := 120;   // tela estreita: aparece a barra de rolagem horizontal

    ColWidths[0] := CItem;
    ColWidths[1] := CForma;
    ColWidths[2] := CValor;
    ColWidths[3] := LLivre;    // NSU / e2eid
    ColWidths[4] := CRede;
    ColWidths[5] := CStatus;
    ColWidths[6] := CCNPJ;
  end;
end;

destructor TframePagamento.Destroy;
begin
  // TEFEventos é global: não pode ficar apontando para este frame
  DesligarEventosTela;
  inherited Destroy;
end;

procedure TframePagamento.Iniciar(ATotalVenda: Currency;
  APagamentos: TListaPagamentos; const AIdentificador: String);
begin
  APagamentos.Clear;

  FTotalVenda := ATotalVenda;
  FPagamentos := APagamentos;
  FIdentificador := AIdentificador;
  if (FIdentificador = '') then
    FIdentificador := FormatDateTime('yymmddhhnnss', Now);

  FEmTEF := False;
  FEmPIX := False;
  mLog.Clear;
  ExibirQRCode('');
  HabilitarTela(True);

  Visible := True;
  BringToFront;
  Update;

  PrepararTEF;
  PrepararPIX;

  // Aqui (e não no Create) porque o ComboBox precisa de Parent/Handle.
  // Recarrega a cada venda: só as formas disponíveis (TEF / PIX PSP ativos)
  CarregarFormas;
  cbxForma.ItemIndex := 0;
  AtualizarPagamentosVendaNaInterface;
  if cbxForma.CanFocus then
    cbxForma.SetFocus;
end;

procedure TframePagamento.Concluir(AConfirmado: Boolean);
begin
  DesligarEventosTela;
  ExibirQRCode('');

  // Cancelou: não deixa pagamentos pela metade na lista
  if not AConfirmado then
    FPagamentos.Clear;

  Visible := False;

  if Assigned(FOnConcluir) then
    FOnConcluir(Self, AConfirmado);
end;

procedure TframePagamento.CarregarFormas;
var
  I: Integer;
begin
  cbxForma.Items.Clear;
  for I := Low(CFormasPDV) to High(CFormasPDV) do
  begin
    if ((CFormasPDV[I].Origem = opTEF) and (not FTEFAtivo)) or
       ((CFormasPDV[I].Origem = opPSP) and (not FPIXAtivo)) then
      Continue;
    cbxForma.Items.AddObject(CFormasPDV[I].Descricao, TObject(I));
  end;
end;

function TframePagamento.FormaSelecionada: TFormaPDV;
begin
  Result := CFormasPDV[Integer(cbxForma.Items.Objects[cbxForma.ItemIndex])];
end;

function TframePagamento.LerValor: Currency;
var
  I, Erro: Integer;
  LTexto, LNumero: String;
  LValor: Double;
begin
  // Aceita "11.000,00" ou "11000,00" (independe do DecimalSeparator)
  LTexto := edtValor.Text;
  LNumero := '';
  for I := 1 to Length(LTexto) do
  begin
    case LTexto[I] of
      '0'..'9': LNumero := LNumero + LTexto[I];
      ',':      LNumero := LNumero + '.';
    end;
  end;

  Val(LNumero, LValor, Erro);
  if (Erro <> 0) then
    LValor := 0;

  Result := RoundTo(LValor, -2);
end;

procedure TframePagamento.edtValorKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
  begin
    Key := #0;
    btnAdicionar.Click;
    Exit;
  end;

  // Só dígitos, backspace e vírgula
  case Key of
    '0'..'9', #8, ',': ;
    '.': Key := ',';
  else
    Key := #0;
  end;
end;

procedure TframePagamento.btnAdicionarClick(Sender: TObject);
var
  LFormaPDV: TFormaPDV;
  LForma: TpcnFormaPagamento;
  LValor: Currency;
  LRestante: Currency;
begin
  if (cbxForma.ItemIndex < 0) then
  begin
    ShowMessage('Selecione a forma de pagamento.');
    Exit;
  end;

  LFormaPDV := FormaSelecionada;
  LForma := LFormaPDV.Forma;
  LValor := LerValor;
  LRestante := FPagamentos.Restante(FTotalVenda);

  if (LRestante <= 0) then
  begin
    ShowMessage('O total da venda já foi atingido.');
    Exit;
  end;

  if (LValor <= 0) then
  begin
    ShowMessage('Informe um valor maior que zero.');
    if edtValor.CanFocus then edtValor.SetFocus;
    Exit;
  end;

  // Somente dinheiro pode passar do restante (gera troco)
  if (LForma <> fpDinheiro) and (LValor > LRestante) then
  begin
    ShowMessage('Somente pagamento em Dinheiro pode ultrapassar o valor restante.' +
      sLineBreak + 'Restante: R$ ' + FormatFloat(CMascaraValor, LRestante));
    if edtValor.CanFocus then edtValor.SetFocus;
    Exit;
  end;

  // Cartão / PIX pelo TEF
  if (LFormaPDV.Origem = opTEF) and (not FTEFAtivo) then
  begin
    MessageDlg('TEF não está ativo.' + sLineBreak +
      'Configure o TEF para receber em Cartão / PIX.', mtWarning, [mbOK], 0);
    Exit;
  end;

  // PIX direto no PSP (ACBrPIXCD)
  if (LFormaPDV.Origem = opPSP) and (not FPIXAtivo) then
  begin
    MessageDlg('PIX via PSP não está ativo.' + sLineBreak +
      'Configure em CONFIG. PIX (marque "Usar PIX Dinâmico via PSP no PDV").',
      mtWarning, [mbOK], 0);
    Exit;
  end;

  if (LFormaPDV.Origem = opPSP) then
    AdicionarPagamentoPIXPSP(LValor)
  else
    AdicionarPagamento(LForma, LValor);
  if cbxForma.CanFocus then cbxForma.SetFocus;
end;

procedure TframePagamento.btnRemoverClick(Sender: TObject);
begin
  // Igual ao btExcluirPagamentoClick do exemplo TEFAPI
  ExcluirPagamento(sgPagamentos.Row - 1);
end;

procedure TframePagamento.btnConfirmarClick(Sender: TObject);
begin
  if (FPagamentos.TotalPago <= 0) then
  begin
    ShowMessage('Informe ao menos uma forma de pagamento.');
    Exit;
  end;

  if (FPagamentos.TotalPago < FTotalVenda) then
  begin
    ShowMessage('Valor pago é menor que o total da venda.' + sLineBreak +
      'Restante: R$ ' + FormatFloat(CMascaraValor, FPagamentos.Restante(FTotalVenda)));
    Exit;
  end;

  // Troco só pode sair do dinheiro (ou do Saque feito no TEF)
  if (FPagamentos.Troco(FTotalVenda) > (FPagamentos.TotalDinheiro + FPagamentos.TotalSaque)) then
  begin
    ShowMessage('Troco maior que o valor pago em dinheiro.');
    Exit;
  end;

  Concluir(True);
end;

{ ------------------- Iguais ao exemplo TEFAPI (frPrincipal) ------------------- }

procedure TframePagamento.AdicionarPagamento(AForma: TpcnFormaPagamento;
  AValor: Double);
var
  Ok, TemTEF: Boolean;
  Modalidade: TACBrTEFModalidadePagamento;
  CartoesAceitos: TACBrTEFTiposCartao;
  ReajusteValor: Double;
  LPag: TpagCollectionItem;
begin
  AdicionarLinhaLog('- AdicionarPagamento( ' + FormaPagamentoToStr(AForma) + ', ' +
    FormatFloat(CMascaraValor, AValor) + ' )');

  Ok := False;
  Modalidade := tefmpNaoDefinido;
  CartoesAceitos := [];

  // ** Única diferença do exemplo TEFAPI: a forma já é a da NFC-e **
  TemTEF := UsarTEF(AForma);
  case AForma of
    fpCartaoCredito:
      begin
        Modalidade := tefmpCartao;
        CartoesAceitos := [teftcCredito];
      end;
    fpCartaoDebito:
      begin
        Modalidade := tefmpCartao;
        CartoesAceitos := [teftcDebito];
      end;
    fpPagamentoInstantaneo:
      Modalidade := tefmpCarteiraVirtual;   // PIX / Carteira Digital
  end;

  if TemTEF then
  begin
    FEmTEF := True;
    HabilitarTela(False);
    try
      Ok := TEF.EfetuarPagamento( FIdentificador,
                                  AValor,
                                  Modalidade,
                                  CartoesAceitos );

      AdicionarLinhaLog(' EfetuarPagamento - OK: ' + IfThen(Ok, 'Sim', 'Não'));

      Ok := Ok and
            TEF.UltimaRespostaTEF.Sucesso and
            TEF.UltimaRespostaTEF.TransacaoAprovada;
      AdicionarLinhaLog(' Sucesso - OK: ' + IfThen(Ok, 'Sim', 'Não'));
    finally
      FEmTEF := False;
      if (TEFEventos <> nil) then
        TEFEventos.FimOperacao;     // esconde mensagens / QR Code
      HabilitarTela(True);
    end;
  end
  else
    Ok := True;

  AdicionarLinhaLog('  - OK: ' + IfThen(Ok, 'Sim', 'Não'));

  if Ok then
  begin
    with FPagamentos.New do
    begin
      FormaPagamento := AForma;
      ValorPago := AValor;

      if TemTEF then
      begin
        Origem := opTEF;
        NSU := TEF.UltimaRespostaTEF.NSU;
        Rede := TEF.UltimaRespostaTEF.Rede;
        // Mesmo CNPJ que vai na NFC-e (tabela de credenciadoras pela Rede)
        LPag := TpagCollectionItem.Create;
        try
          DeduzirCredenciadoraNFCe(LPag, TEF.UltimaRespostaTEF.Rede);
          RedeCNPJ := LPag.CNPJ;
        finally
          LPag.Free;
        end;

        // Calcula a Diferença do Valor Retornado pela Operação TEF do Valor que
        //   Informamos no CRT/CHQ
        ReajusteValor := RoundTo(TEF.UltimaRespostaTEF.ValorTotal - ValorPago, -2);

        Saque := TEF.UltimaRespostaTEF.Saque;
        if (Saque > 0) then
        begin
          // Se houve Saque na operação TEF, devemos adicionar no ValorPago,
          //   para que o Saque conste como Troco
          ValorPago := ValorPago + Saque
        end

        else if (ReajusteValor > 0) then
        begin
          // No exemplo TEFAPI o reajuste vira acréscimo na venda.
          // Aqui o total vem dos itens da NFC-e, então só registramos.
          Acrescimo := ReajusteValor;
          AdicionarLinhaLog('  - Acréscimo do TEF (não lançado na NFC-e): ' +
            FormatFloat(CMascaraValor, Acrescimo));
        end;

        Desconto := TEF.UltimaRespostaTEF.Desconto;
        if (Desconto > 0) then
        begin
          // No exemplo TEFAPI o desconto é subtraído do ValorPago e lançado no
          // total da venda. Aqui o total vem dos itens da NFC-e, então só registramos.
          AdicionarLinhaLog('  - Desconto do TEF (não lançado na NFC-e): ' +
            FormatFloat(CMascaraValor, Desconto));
        end

        else if (ReajusteValor < 0) then
        begin
          // Se não é Desconto, mas houve redução no Valor Retornado, devemos
          //   considerar a redução no ValorPago, pois a Adquirente limitou o
          //   valor da Operação, a um máximo permitido... Deverá fechar o cupom,
          //   com outra forma de Pagamento
          ValorPago := ValorPago + ReajusteValor;
        end;
      end
      else
        Confirmada := True;
    end;

    AtualizarPagamentosVendaNaInterface;

    AdicionarLinhaLog('- TotalPago: ' + FormatFloat(CMascaraValor, FPagamentos.TotalPago));
    AdicionarLinhaLog('- TotalVenda: ' + FormatFloat(CMascaraValor, FTotalVenda));
  end;
end;

procedure TframePagamento.ExcluirPagamento(IndicePagto: Integer);
var
  AResp: TACBrTEFResp;
  Cancelada: Boolean;
begin
  if (IndicePagto < 0) or (IndicePagto >= FPagamentos.Count) then
    raise Exception.CreateFmt( 'Indice de pagamento [%d] inválido', [IndicePagto]);

  if FPagamentos[IndicePagto].Cancelada then
    raise Exception.CreateFmt( 'Pagamento [%d] já foi Cancelado', [IndicePagto]);

  Cancelada := False;

  // PIX via PSP já pago: só sai da venda devolvendo o dinheiro ao cliente
  if (FPagamentos[IndicePagto].Origem = opPSP) then
  begin
    if (MessageDlg('Este PIX já foi PAGO pelo cliente.' + sLineBreak +
      'Para removê-lo, o valor será DEVOLVIDO. Confirma?',
      mtConfirmation, [mbYes, mbNo], 0) <> mrYes) then
      Exit;

    if not PIXDevolver(PIXCD, FPagamentos[IndicePagto].EndToEndId,
                       FPagamentos[IndicePagto].ValorPago) then
      raise Exception.Create('Falha ao devolver o PIX:' + sLineBreak +
        PIXCD.PSP.epPix.Problema.title + sLineBreak + PIXCD.PSP.epPix.Problema.detail);

    AdicionarLinhaLog('  PIX DEVOLVIDO - e2eid: ' + FPagamentos[IndicePagto].EndToEndId);
    FPagamentos[IndicePagto].Cancelada := True;
    AtualizarPagamentosVendaNaInterface;
    Exit;
  end;

  AResp := AcharTransacaoTEF(IndicePagto);
  if Assigned(AResp) then
  begin
    if AResp.CNFEnviado then
      raise Exception.CreateFmt( 'Pagamento TEF [%s] já foi Confirmado.' + sLineBreak +
                                 'Para cancelar o mesmo, cancele Toda a Operação',
                                 [AResp.NSU])
    else
    begin
      TEF.FinalizarTransacao( AResp.Rede,
                              AResp.NSU,
                              AResp.Finalizacao,
                              tefstsErroDiverso );
      Cancelada := True;
    end;
  end
  else
  begin
    if (FPagamentos[IndicePagto].NSU <> '') then
      raise Exception.CreateFmt( 'Transação TEF [%s] não foi Localizada.',
                                 [FPagamentos[IndicePagto].NSU])
    else
      Cancelada := True;
  end;

  if Cancelada then
  begin
    FPagamentos[IndicePagto].Cancelada := True;
    AtualizarPagamentosVendaNaInterface;
  end;
end;

function TframePagamento.AcharTransacaoTEF(IndicePagto: Integer): TACBrTEFResp;
var
  i: Integer;
begin
  Result := Nil;
  if (IndicePagto < 0) or (IndicePagto >= FPagamentos.Count) then
    Exit;

  if (FPagamentos[IndicePagto].NSU = '') then   // não foi pelo TEF
    Exit;

  i := TEF.RespostasTEF.AcharTransacao( FPagamentos[IndicePagto].Rede,
                                        FPagamentos[IndicePagto].NSU );
  if (i >= 0) then
    Result := TEF.RespostasTEF[i];
end;

procedure TframePagamento.CancelarVenda;
begin
  AdicionarLinhaLog('- CancelarVenda');
  TEF.CancelarOuEstornarTransacoesDiretorioTrabalho;
  AtualizarPagamentosVendaNaInterface;
end;

procedure TframePagamento.AtualizarPagamentosVendaNaInterface;
var
  i, ARow: Integer;
  AResp: TACBrTEFResp;
begin
  sgPagamentos.RowCount := 1;
  ARow := sgPagamentos.RowCount;

  for i := 0 to FPagamentos.Count-1 do
  begin
    sgPagamentos.RowCount := sgPagamentos.RowCount + 1;

    with FPagamentos[i] do
    begin
      if not Cancelada then
      begin
        AResp := AcharTransacaoTEF(i);
        if Assigned(AResp) then
          Confirmada := AResp.CNFEnviado;
      end;

      sgPagamentos.Cells[0, ARow] := FormatFloat('000', ARow);
      sgPagamentos.Cells[1, ARow] := Descricao;
      sgPagamentos.Cells[2, ARow] := FormatFloat(CMascaraValor, ValorPago);
      sgPagamentos.Cells[3, ARow] := IfThen(Origem = opPSP, EndToEndId, NSU);
      sgPagamentos.Cells[4, ARow] := Rede;
      if Cancelada then
        sgPagamentos.Cells[5, ARow] := IfThen(Origem = opPSP, 'Devolvido', 'Cancelada')
      else if (Origem = opPSP) then
        sgPagamentos.Cells[5, ARow] := 'Pago'
      else
        sgPagamentos.Cells[5, ARow] := IfThen(Confirmada, 'Confirmada', 'Pendente');
      sgPagamentos.Cells[6, ARow] := RedeCNPJ;
    end;

    Inc(ARow);
  end;

  AtualizarTotaisVendaNaInterface;
end;

procedure TframePagamento.AtualizarTotaisVendaNaInterface;
var
  LRestante: Currency;
  LTroco: Currency;
begin
  LRestante := FPagamentos.Restante(FTotalVenda);
  LTroco := FPagamentos.Troco(FTotalVenda);

  lblTotal.Caption := 'R$ ' + FormatFloat(CMascaraValor, FTotalVenda);
  lblPago.Caption := 'R$ ' + FormatFloat(CMascaraValor, FPagamentos.TotalPago);

  if (LTroco > 0) then
  begin
    lblRestanteTit.Caption := 'Troco';
    lblRestante.Caption := 'R$ ' + FormatFloat(CMascaraValor, LTroco);
    lblRestante.Font.Color := clBlue;
  end
  else
  begin
    lblRestanteTit.Caption := 'Restante';
    lblRestante.Caption := 'R$ ' + FormatFloat(CMascaraValor, LRestante);
    if (LRestante > 0) then
      lblRestante.Font.Color := clRed
    else
      lblRestante.Font.Color := clGreen;
  end;

  // Sugere o valor restante para o próximo pagamento
  edtValor.Text := FormatFloat(CMascaraValor, LRestante);

  btnAdicionar.Enabled := (LRestante > 0);
  btnRemover.Enabled := (FPagamentos.Count > 0);
  btnConfirmar.Enabled := (FPagamentos.TotalPago > 0) and (LRestante = 0);
end;

procedure TframePagamento.AdicionarLinhaLog(const AMensagem: String);
begin
  if (csDestroying in ComponentState) then
    Exit;

  mLog.Lines.Add(AMensagem);
end;

procedure TframePagamento.ExibirQRCode(const DadosQRCode: String);
begin
  // Mesmo que o ACBrTEFAPI1QuandoExibirQRCode do exemplo TEFAPI
  // (a geração da imagem fica em TTEFEventos.GerarImagemQRCode)
  if (csDestroying in ComponentState) then
    Exit;

  if (DadosQRCode = '') then
  begin
    gbQRCode.Visible := False;      // OcultatPainelQRCode
    pnlTEF.Visible := False;        // sem QR Code: a grade usa a largura toda
    imgQRCode.Picture := Nil;
  end
  else
  begin
    TTEFEventos.GerarImagemQRCode(DadosQRCode, imgQRCode.Picture);
    pnlTEF.Visible := True;         // painel à direita, só enquanto há QR Code
    gbQRCode.Visible := True;       // ExibirPainelQRCode
  end;

  pnlTEF.Update;
end;

{ ---------------------------------- TEF ---------------------------------- }

function TframePagamento.TEF: TACBrTEFAPI;
begin
  Result := frmPrincipal.ACBrTEFAPI1;
end;

procedure TframePagamento.PrepararTEF;
var
  LArqINI: String;
begin
  FTEFAtivo := False;
  LArqINI := ChangeFileExt(Application.ExeName, '.ini');

  if not TEFHabilitado(LArqINI) then
  begin
    lblStatusTEF.Caption := 'TEF desligado ou não configurado (cartão/PIX indisponível)';
    lblStatusTEF.Font.Color := clGray;
    Exit;
  end;

  Screen.Cursor := crHourGlass;
  try
    try
      // Mesma configuração gravada pelo uframeconfigTEF
      ConfigurarTEFPeloINI(TEF, frmPrincipal.ACBrPosPrinter1, LArqINI);
      LigarEventosTela;   // log e QR Code nesta tela
      if not TEF.Inicializado then
        TEF.Inicializar;  // trata pendências conforme "TransacaoPendenteInicializacao"

      // Igual ao IniciarOperacao do exemplo TEFAPI:
      // Limpa respostas TEF anteriores, e apaga Arqs Backup
      TEF.LimparRespostasTEF;
      FTEFAtivo := True;
    except
      on E: Exception do
        MessageDlg('Não foi possível inicializar o TEF.' + sLineBreak +
          E.Message + sLineBreak + sLineBreak +
          'Pagamentos em Cartão/PIX ficarão indisponíveis.',
          mtWarning, [mbOK], 0);
    end;
  finally
    Screen.Cursor := crDefault;
  end;

  if FTEFAtivo then
  begin
    lblStatusTEF.Caption := 'TEF ativo: ' +
      GetEnumName(TypeInfo(TACBrTEFAPITipo), Integer(TEF.Modelo));
    lblStatusTEF.Font.Color := clGreen;
  end
  else
  begin
    lblStatusTEF.Caption := 'TEF indisponível';
    lblStatusTEF.Font.Color := clRed;
  end;
end;

function TframePagamento.UsarTEF(AForma: TpcnFormaPagamento): Boolean;
begin
  // 03 - Crédito, 04 - Débito e 17 - PIX Dinâmico
  Result := TPagamento.ExigeDadosCartao(AForma);
end;

procedure TframePagamento.HabilitarTela(AHabilitar: Boolean);
begin
  gbForma.Enabled := AHabilitar;
  sgPagamentos.Enabled := AHabilitar;
  btnRemover.Enabled := AHabilitar and (FPagamentos.Count > 0);
  btnConfirmar.Enabled := AHabilitar and (FPagamentos.TotalPago > 0) and
    (FPagamentos.Restante(FTotalVenda) = 0);
  btnCancelar.Enabled := AHabilitar;
end;

procedure TframePagamento.LigarEventosTela;
begin
  if (TEFEventos = nil) then
    Exit;
  TEFEventos.OnLog := AdicionarLinhaLog;
  TEFEventos.OnExibirQRCode := ExibirQRCode;
  TEFEventos.CentralizarSobre := sgPagamentos;  // mensagens não cobrem o QR Code
end;

procedure TframePagamento.DesligarEventosTela;
begin
  if (TEFEventos = nil) then
    Exit;
  TEFEventos.OnLog := nil;
  TEFEventos.OnExibirQRCode := nil;
  TEFEventos.CentralizarSobre := nil;
end;

{ ------------------------- PIX Dinâmico via PSP --------------------------- }

function TframePagamento.PIXCD: TACBrPixCD;
begin
  Result := frmPrincipal.ACBrPixCD1;
end;

function TframePagamento.ArqINI: String;
begin
  Result := ChangeFileExt(Application.ExeName, '.ini');
end;

// Igual ao PrepararTEF: aplica a configuração gravada pelo uframeConfigPIX
procedure TframePagamento.PrepararPIX;
begin
  FPIXAtivo := False;
  if not PIXHabilitado(ArqINI) then
    Exit;

  try
    ConfigurarPIXPeloINI(PIXCD, ArqINI);
    FPIXAtivo := True;
    lblStatusTEF.Caption := lblStatusTEF.Caption +
      '  |  PIX (PSP): ' + PIXNomePSP(ArqINI);
  except
    on E: Exception do
      MessageDlg('Não foi possível configurar o PIX via PSP.' + sLineBreak +
        E.Message, mtWarning, [mbOK], 0);
  end;
end;

// Espera sem travar a tela (o operador pode clicar em Cancelar)
procedure TframePagamento.Esperar(AMilissegundos: Cardinal);
var
  LInicio: Cardinal;
begin
  LInicio := GetTickCount;
  while (GetTickCount - LInicio < AMilissegundos) and (not FCancelarPIX) do
  begin
    Application.ProcessMessages;
    Sleep(50);
  end;
end;

// PIX Dinâmico direto no PSP - mesmo fluxo do exemplo do ACBrPIXCD:
//   1) cria a cobrança  2) mostra o QR Code  3) consulta até PAGAR
//   4) pago: guarda o e2eid (vai no cAut da NFC-e)
procedure TframePagamento.AdicionarPagamentoPIXPSP(AValor: Currency);
var
  LCobranca: TPIXCobranca;
  LStatus: TACBrPIXStatusCobranca;
  LEndToEndId: String;
  LLimite: TDateTime;
  LPag: TpagCollectionItem;
begin
  AdicionarLinhaLog('- PIX via PSP ( ' + FormatFloat(CMascaraValor, AValor) + ' ) - ' +
    PIXNomePSP(ArqINI));

  FEmPIX := True;
  FCancelarPIX := False;
  HabilitarTela(False);
  btnCancelar.Enabled := True;   // permite desistir enquanto espera
  LStatus := stcNENHUM;
  LEndToEndId := '';
  try
    try
      // 1) Cobrança imediata (cob)
      LCobranca := PIXCriarCobranca(PIXCD, AValor, PIXExpiracaoCobranca(ArqINI));
      AdicionarLinhaLog('  Cobrança criada - TxId: ' + LCobranca.TxId);

      // 2) QR Code na tela do PDV (o mesmo painel do PIX via TEF)
      ExibirQRCode(LCobranca.QRCode);
      AdicionarLinhaLog('  Aguardando o cliente pagar... (Cancelar = desistir)');

      // 3) Consulta até o PSP informar que foi pago (ou expirar/desistir)
      LLimite := Now + (PIXExpiracaoCobranca(ArqINI) / SecsPerDay);
      repeat
        Esperar(CIntervaloConsultaPIX);
        if FCancelarPIX then
          Break;
        LStatus := PIXConsultarCobranca(PIXCD, LCobranca.TxId, LEndToEndId);
      until (LStatus <> stcATIVA) or (Now > LLimite);

      // Desistiu (ou expirou): cancela a cobrança no PSP.
      // Consulta de novo: o cliente pode ter pago no último segundo.
      if (LStatus in [stcNENHUM, stcATIVA]) then
      begin
        AdicionarLinhaLog('  Cancelando a cobrança no PSP...');
        PIXCancelarCobranca(PIXCD, LCobranca.TxId);
        LStatus := PIXConsultarCobranca(PIXCD, LCobranca.TxId, LEndToEndId);
      end;

      // 4) Pago: entra na venda com o e2eid
      if (LStatus = stcCONCLUIDA) and (LEndToEndId <> '') then
      begin
        with FPagamentos.New do
        begin
          FormaPagamento := fpPagamentoInstantaneo;
          Origem := opPSP;
          ValorPago := AValor;
          TxId := LCobranca.TxId;
          EndToEndId := LEndToEndId;
          Rede := PIXNomePSP(ArqINI);
          // Mesmo CNPJ que vai na NFC-e (tabela pelo nome do PSP)
          LPag := TpagCollectionItem.Create;
          try
            DeduzirCredenciadoraNFCe(LPag, Rede);
            RedeCNPJ := LPag.CNPJ;
          finally
            LPag.Free;
          end;
          Confirmada := True;
        end;
        AdicionarLinhaLog('  PIX PAGO - e2eid: ' + LEndToEndId);
      end
      else
        AdicionarLinhaLog('  PIX NÃO pago - status: ' + PIXStatusCobrancaToString(LStatus));
    except
      on E: Exception do
      begin
        AdicionarLinhaLog('  ERRO PIX: ' + E.Message);
        MessageDlg(E.Message, mtError, [mbOK], 0);
      end;
    end;
  finally
    FEmPIX := False;
    ExibirQRCode('');
    HabilitarTela(True);
    AtualizarPagamentosVendaNaInterface;
  end;
end;

procedure TframePagamento.btnCancelarClick(Sender: TObject);
begin
  if FEmPIX then
  begin
    FCancelarPIX := True;   // interrompe a espera do PIX (AdicionarPagamentoPIXPSP)
    Exit;
  end;

  if FEmTEF then
    Exit;   // não cancela com transação TEF em andamento

  if FPagamentos.TemPIXPSP then
  begin
    if (MessageDlg('Existem PIX (PSP) já pagos.' + sLineBreak +
      'Eles serão DEVOLVIDOS ao cliente. Confirma?',
      mtConfirmation, [mbYes, mbNo], 0) <> mrYes) then
      Exit;

    try
      PIXDevolverPagamentos(PIXCD, FPagamentos);
      AtualizarPagamentosVendaNaInterface;
    except
      on E: Exception do
      begin
        MessageDlg(E.Message, mtError, [mbOK], 0);
        Exit;   // não abandona a venda com PIX que não foi devolvido
      end;
    end;
  end;

  if FPagamentos.TemTEF then
  begin
    if (MessageDlg('Existem pagamentos TEF aprovados.' + sLineBreak +
      'Eles serão CANCELADOS/ESTORNADOS. Confirma?',
      mtConfirmation, [mbYes, mbNo], 0) <> mrYes) then
      Exit;

    try
      CancelarVenda;
    except
      on E: Exception do
        MessageDlg('Falha ao cancelar/estornar TEF:' + sLineBreak + E.Message,
          mtError, [mbOK], 0);
    end;
  end;

  Concluir(False);
end;

end.
