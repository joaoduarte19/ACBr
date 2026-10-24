unit uframePDV;

{
  PDV - Frente de Caixa

  Fluxo da venda (TStatusPedido):

    spFechado --[Iniciar Venda]--> spAberto
       ^                              |  lança itens (código + quantidade)
       |                        [Finalizar Venda]
       |                              v
       |                    spAguardandoPagamento   (TframePagamento)
       |                              |  dinheiro / cartão (TEF) / PIX (TEF)
       |                              v
       |                       spAguardandoNFe       (EmitirNFCe)
       |                              |
       +-- NFC-e autorizada ----------+  imprime comprovantes TEF + Raio-X
       +-- NFC-e com erro: ESTORNA/DESFAZ os pagamentos TEF e volta p/ a venda

  O log (mmLOG) mostra a venda em ETAPAS, com cores:
    azul = etapa | verde = aprovado/autorizado | vermelho = erro | laranja = estorno

  Confirmação do TEF (Config. TEF - "Confirmar Transação Automaticamente"):
    Ligado    - o ACBrTEFAPI confirma a transação logo após a aprovação.
                NFC-e não autorizada -> o pagamento precisa ser ESTORNADO.
    Desligado - o PDV confirma a transação só DEPOIS da NFC-e autorizada.
                NFC-e não autorizada -> a transação é DESFEITA.
}

interface

uses
  Classes, SysUtils, Forms, Controls, ExtCtrls, StdCtrls, ComCtrls, Dialogs,
  Graphics, uframePDVRodape, Frm_RaioXVinculo, uClasseProduto, uClasseItemPedido, uClassePagamento,
  uframePagamento,
  ACBrNFe.Classes,   // TNFe, TpagCollectionItem
  ACBrTEFComum;      // TACBrTEFResp

type

  // Dados do emitente gravados pelo uframeConfigNFe (seção [Emitente] do INI)
  TConfiguracaoPDV = record
    FormaEmissao: Integer;
    Ambiente: Integer;
    EmitCNPJ: String;
    EmitIE: String;
    EmitRazao: String;
    EmitFantasia: String;
    EmitFone: String;
    EmitCEP: String;
    EmitLogradouro: String;
    EmitNumero: String;
    EmitComplemento: String;
    EmitBairro: String;
    EmitCodCidade: String;
    EmitCidade: String;
    EmitUF: String;
    CRT: Integer;
  end;

  { Situação da venda }
  TStatusPedido = (
    spAberto,
    spAguardandoPagamento,
    spAguardandoNFe,
    spFechado
  );

  { TframePDV }

  TframePDV = class(TFrame)

    edtCodigo: TEdit;
    edtDescricao: TEdit;
    edtQtde: TEdit;
    edtUnitario: TEdit;
    edtTotal: TEdit;

    framePDVRodape1: TframePDVRodape;

    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;

    mmLOG: TRichEdit;

    pnlRodapePDV: TPanel;
    pnlStatusCaixa: TPanel;
    pnlLog: TPanel;
    pnlCamposVenda: TPanel;
    Label5: TLabel;

    procedure btnFinalizaVendaClick(Sender: TObject);
    procedure btnIniciaVendaClick(Sender: TObject);
    procedure framePDVRodape1btnCancelaVendaClick(Sender: TObject);
    procedure btnSairPDVClick(Sender: TObject);
    procedure btnRaioXClick(Sender: TObject);
    procedure btnMenuADMClick(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
    procedure edtQtdeExit(Sender: TObject);
  private
    FProdutos: TListaProdutos;
    FItensPedido: TListaItensPedido;
    FPagamentos: TListaPagamentos;
    FStatusPedido: TStatusPedido;
    FStatusAntesPagamento: TStatusPedido;
    FFramePagamento: TframePagamento;
    FPagamentoAberto: Boolean;
    FOnFechar: TNotifyEvent;
    FConfiguracao: TConfiguracaoPDV;   // emitente (lido do INI ao emitir)
    FRaioX: TfrmRaioXVinculo;          // Raio-X da última NFC-e autorizada

    // Configuração e impressora
    procedure LerConfiguracao;
    procedure PrepararImpressao;

    // Venda (itens)
    procedure CarregarProdutos;
    function LocalizarProduto(const ACodigo: string): Boolean;
    procedure VenderItem;
    function CalcularTotalNota: Currency;

    // Pagamento
    procedure AbrirPagamento;
    procedure PagamentoConcluido(Sender: TObject; AConfirmado: Boolean);

    // TEF (iguais ao exemplo ACBr\Exemplos\ACBrTEFD\TEFAPI\Delphi - frPrincipal.pas)
    function AcharTransacaoTEF(IndicePagto: Integer): TACBrTEFResp;
    procedure FinalizarTEFVenda;
    procedure EstornarTEFVenda;
    procedure DevolverPIXVenda;

    // NFC-e: EmitirNFCe -> AlimentarNFCe -> Preencher...
    procedure EmitirNFCe;
    procedure AlimentarNFCe(ANumeroNFCe: Integer);
    procedure PreencherIdentificacao(ANFe: TNFe; ANumeroNFCe: Integer);
    procedure PreencherEmitente(ANFe: TNFe);
    procedure PreencherDestinatario(ANFe: TNFe);
    procedure PreencherItens(ANFe: TNFe);
    procedure PreencherTotais(ANFe: TNFe);
    procedure PreencherPagamentos(ANFe: TNFe);
    procedure ExibirRetornoNFCe;
    procedure MostrarRaioX;

    // Tela
    procedure Log(const ATexto: String; ACor: TColor = clWindowText;
      AEstilo: TFontStyles = []);
    procedure LogEtapa(const ATitulo: String);
    procedure LogTEF(const ALinha: String);
    procedure AtualizarBotoes;
    procedure FocarCodigo;
    procedure LimparCampos;
    procedure HabilitarEdicao(AHabilitar: Boolean);
    procedure LiberarCaixa;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property StatusPedido: TStatusPedido read FStatusPedido;
    property Produtos: TListaProdutos read FProdutos;
    property OnFechar: TNotifyEvent read FOnFechar write FOnFechar;
  end;

implementation

uses
  Windows, Messages, IniFiles, Math, StrUtils, blcksock,
  ACBrUtil.Base, ACBrUtil.Strings, ACBrDFeUtil, ACBrDFeSSL,
  ACBrPosPrinter, ACBrTEFAPIComum, ACBrTEFAPI,
  pcnConversaoNFe,
  ACBrDFe.Conversao,   // por último: tipos novos do ACBr (tnSaida, cst00...)
  uPrincipal, uTEFUtils, uPIXUtils, uVinculoPagamentoNFCe;

const
  CMascaraQtde  = '#,##0.000';
  CMascaraValor = '#,##0.00';

  // Cores do log
  CCorEtapa   = clNavy;
  CCorOK      = clGreen;
  CCorErro    = clRed;
  CCorEstorno = TColor($000080FF);   // laranja

  // Dados fiscais fixos dos produtos de exemplo.
  // Num sistema real, viriam do cadastro de cada produto.
  CProdutoEAN   = '7896523206646';
  CProdutoNCM   = '61051000';
  CProdutoCFOP  = '5102';
  CProdutoUnid  = 'UN';
  CAliquotaICMS = 18;

procedure LerIniPDV(var AConfiguracao: TConfiguracaoPDV);
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(ChangeFileExt(ParamStr(0), '.ini'));
  try
    AConfiguracao.FormaEmissao := Ini.ReadInteger('Geral', 'FormaEmissao', 0);
    AConfiguracao.Ambiente := Ini.ReadInteger('WebService', 'Ambiente', 1);
    AConfiguracao.EmitCNPJ := Ini.ReadString('Emitente', 'CNPJ', '');
    AConfiguracao.EmitIE := Ini.ReadString('Emitente', 'IE', '');
    AConfiguracao.EmitRazao := Ini.ReadString('Emitente', 'RazaoSocial', '');
    AConfiguracao.EmitFantasia := Ini.ReadString('Emitente', 'Fantasia', '');
    AConfiguracao.EmitFone := Ini.ReadString('Emitente', 'Fone', '');
    AConfiguracao.EmitCEP := Ini.ReadString('Emitente', 'CEP', '');
    AConfiguracao.EmitLogradouro := Ini.ReadString('Emitente', 'Logradouro', '');
    AConfiguracao.EmitNumero := Ini.ReadString('Emitente', 'Numero', '');
    AConfiguracao.EmitComplemento := Ini.ReadString('Emitente', 'Complemento', '');
    AConfiguracao.EmitBairro := Ini.ReadString('Emitente', 'Bairro', '');
    AConfiguracao.EmitCodCidade := Ini.ReadString('Emitente', 'CodCidade', '');
    AConfiguracao.EmitCidade := Ini.ReadString('Emitente', 'Cidade', '');
    AConfiguracao.EmitUF := UpperCase(Trim(Ini.ReadString('Emitente', 'UF', '')));
    AConfiguracao.CRT := Ini.ReadInteger('Emitente', 'CRT', 2);
  finally
    Ini.Free;
  end;
end;

{$R *.dfm}

{ TframePDV }

constructor TframePDV.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  LerConfiguracao;

  FStatusPedido := spFechado;
  FItensPedido := TListaItensPedido.Create(True);
  FProdutos := TListaProdutos.Create;
  FPagamentos := TListaPagamentos.Create(True);

  CarregarProdutos;

  AtualizarBotoes;
  LimparCampos;
end;

destructor TframePDV.Destroy;
begin
  FPagamentos.Free;
  FProdutos.Free;
  FItensPedido.Free;
  inherited Destroy;
end;

{ ------------------------- Configuração e impressora ------------------------- }

procedure TframePDV.LerConfiguracao;
const
  CDANFCE_ESCPOS = 1;
  CTipoDanfeMap: array[0..3] of TACBrTipoImpressao =
    (tiRetrato, tiPaisagem, tiSimplificado, tiSimplificadoTipo2);
var
  Ini: TIniFile;
  LValor: Integer;
  LModeloDF: Integer;
  LTipoDanfe: Integer;
  LTipoDANFCE: Integer;
begin
  Ini := TIniFile.Create(ChangeFileExt(ParamStr(0), '.ini'));
  try
    with frmPrincipal.ACBrNFe1.Configuracoes.Certificados do
    begin
      URLPFX := Ini.ReadString('Certificado', 'URL', '');
      ArquivoPFX := Ini.ReadString('Certificado', 'Caminho', '');
      Senha := Ini.ReadString('Certificado', 'Senha', '');
      NumeroSerie := Ini.ReadString('Certificado', 'NumSerie', '');
    end;

    frmPrincipal.ACBrNFe1.SSL.DescarregarCertificado;

    with frmPrincipal.ACBrNFe1.Configuracoes.Geral do
    begin
      SSLLib := TSSLLib(Ini.ReadInteger('Certificado', 'SSLLib', 4));
      SSLCryptLib := TSSLCryptLib(Ini.ReadInteger('Certificado', 'CryptLib', 0));
      SSLHttpLib := TSSLHttpLib(Ini.ReadInteger('Certificado', 'HttpLib', 0));
      SSLXmlSignLib := TSSLXmlSignLib(Ini.ReadInteger('Certificado', 'XmlSignLib', 0));
      AtualizarXMLCancelado := Ini.ReadBool('Geral', 'AtualizarXML', True);
      Salvar := Ini.ReadBool('Geral', 'Salvar', True);
      ExibirErroSchema := Ini.ReadBool('Geral', 'ExibirErroSchema', True);
      RetirarAcentos := Ini.ReadBool('Geral', 'RetirarAcentos', True);
      FormatoAlerta := Ini.ReadString('Geral', 'FormatoAlerta', '');
      FormaEmissao := TACBrTipoEmissao(Ini.ReadInteger('Geral', 'FormaEmissao', 0));
      LModeloDF := Ini.ReadInteger('Geral', 'ModeloDF', 0);
      ModeloDF := TpcnModeloDF(LModeloDF);
      VersaoDF := TpcnVersaoDF(Ini.ReadInteger('Geral', 'VersaoDF', 3));
      IdCSC := Ini.ReadString('Geral', 'IdToken', '');
      CSC := Ini.ReadString('Geral', 'Token', '');
      VersaoQRCode := TpcnVersaoQrCode(Ini.ReadInteger('Geral', 'VersaoQRCode', 2));
    end;

    with frmPrincipal.ACBrNFe1.Configuracoes.WebServices do
    begin
      UF := Ini.ReadString('WebService', 'UF', 'SP');
      // INI: 0 = Produção | 1 = Homologação (mesma ordem do TACBrTipoAmbiente)
      Ambiente := TACBrTipoAmbiente(Ini.ReadInteger('WebService', 'Ambiente', 1));
      Visualizar := Ini.ReadBool('WebService', 'Visualizar', False);
      Salvar := Ini.ReadBool('WebService', 'SalvarSOAP', False);
      AjustaAguardaConsultaRet := Ini.ReadBool('WebService', 'AjustarAut', False);

      LValor := Ini.ReadInteger('WebService', 'Aguardar', 0);
      if LValor < 1000 then
        LValor := LValor * 1000;
      AguardarConsultaRet := LValor;

      Tentativas := Ini.ReadInteger('WebService', 'Tentativas', 5);
      LValor := Ini.ReadInteger('WebService', 'Intervalo', 0);
      if LValor < 1000 then
        LValor := LValor * 1000;
      IntervaloTentativas := LValor;
      TimeOut := Ini.ReadInteger('WebService', 'TimeOut', 5000);
      ProxyHost := Ini.ReadString('Proxy', 'Host', '');
      ProxyPort := Ini.ReadString('Proxy', 'Porta', '');
      ProxyUser := Ini.ReadString('Proxy', 'User', '');
      ProxyPass := Ini.ReadString('Proxy', 'Pass', '');
    end;

    frmPrincipal.ACBrNFe1.SSL.SSLType :=
      TSSLType(Ini.ReadInteger('WebService', 'SSLType', 5));

    with frmPrincipal.ACBrNFe1.Configuracoes.Arquivos do
    begin
      Salvar := Ini.ReadBool('Arquivos', 'Salvar', False);
      SepararPorMes := Ini.ReadBool('Arquivos', 'PastaMensal', False);
      AdicionarLiteral := Ini.ReadBool('Arquivos', 'AddLiteral', False);
      EmissaoPathNFe := Ini.ReadBool('Arquivos', 'EmissaoPathNFe', False);
      SalvarEvento := Ini.ReadBool('Arquivos', 'SalvarPathEvento', False);
      SepararPorCNPJ := Ini.ReadBool('Arquivos', 'SepararPorCNPJ', False);
      SepararPorModelo := Ini.ReadBool('Arquivos', 'SepararPorModelo', False);
      PathSchemas := Ini.ReadString('Geral', 'PathSchemas', '');
      PathNFe := Ini.ReadString('Arquivos', 'PathNFe', '');
      PathInu := Ini.ReadString('Arquivos', 'PathInu', '');
      PathEvento := Ini.ReadString('Arquivos', 'PathEvento', '');
      PathSalvar := Ini.ReadString('Geral', 'PathSalvar', '');
    end;

    frmPrincipal.ACBrNFe1.Configuracoes.RespTec.idCSRT :=
      StrToIntDef(Ini.ReadString('RespTecnico', 'IdCSRT', '0'), 0);
    frmPrincipal.ACBrNFe1.Configuracoes.RespTec.CSRT :=
      Ini.ReadString('RespTecnico', 'CSRT', '');

    LTipoDanfe := Ini.ReadInteger('DANFE', 'Tipo', 0);
    if (LTipoDanfe < Low(CTipoDanfeMap)) or (LTipoDanfe > High(CTipoDanfeMap)) then
      LTipoDanfe := 0;

    // rgDANFCE (uframeConfigNFe): 0 = Fortes | 1 = EscPos | 2 = A4
    LTipoDANFCE := Ini.ReadInteger('DANFE', 'TipoDANFCE', CDANFCE_ESCPOS);

    // Configura a PosPrinter ANTES de ativar (parâmetros vindos do INI)
    with frmPrincipal.ACBrPosPrinter1 do
    begin
      Desativar;
      Device.ParamsString := Ini.ReadString('PosPrinter', 'ParamsString', '');
      Modelo := TACBrPosPrinterModelo(Ini.ReadInteger('PosPrinter', 'Modelo',
        Integer(Modelo)));
      PaginaDeCodigo := TACBrPosPaginaCodigo(Ini.ReadInteger('PosPrinter',
        'PaginaDeCodigo', Integer(PaginaDeCodigo)));
      Porta := Ini.ReadString('PosPrinter', 'Porta', Porta);
      ColunasFonteNormal := Ini.ReadInteger('PosPrinter', 'Colunas',
        ColunasFonteNormal);
      EspacoEntreLinhas := Ini.ReadInteger('PosPrinter', 'EspacoLinhas',
        EspacoEntreLinhas);
      LinhasEntreCupons := Ini.ReadInteger('PosPrinter', 'LinhasEntreCupons',
        LinhasEntreCupons);
      CortaPapel := Ini.ReadBool('PosPrinter', 'CortarPapel', True);
    end;

    // Escolhe o componente de DANFE conforme o modelo e o tipo de DANFCe
    if LModeloDF = 0 then  // NF-e (modelo 55)
      frmPrincipal.ACBrNFe1.DANFE := frmPrincipal.ACBrNFeDANFeRL1
    else
      case LTipoDANFCE of
        CDANFCE_ESCPOS:
          frmPrincipal.ACBrNFe1.DANFE := frmPrincipal.ACBrNFeDANFeESCPOS1;
      else
        // 0 = Fortes e 2 = A4 (enquanto não houver componente A4 específico)
        frmPrincipal.ACBrNFe1.DANFE := frmPrincipal.ACBrNFeDANFCeFortes1;
      end;

    if frmPrincipal.ACBrNFe1.DANFE <> nil then
    begin
      if LModeloDF = 0 then
        frmPrincipal.ACBrNFe1.DANFE.TipoDANFE := CTipoDanfeMap[LTipoDanfe];
      frmPrincipal.ACBrNFe1.DANFE.Logo := Ini.ReadString('DANFE', 'LogoMarca', '');
      frmPrincipal.ACBrNFe1.DANFE.PathPDF := Ini.ReadString('Arquivos', 'PathPDF', '');
      frmPrincipal.ACBrNFe1.DANFE.MargemDireita := 7;
      frmPrincipal.ACBrNFe1.DANFE.MargemEsquerda := 7;
      frmPrincipal.ACBrNFe1.DANFE.MargemSuperior := 5;
      frmPrincipal.ACBrNFe1.DANFE.MargemInferior := 5;
    end;

    // Só abre a porta da impressora térmica quando o DANFCe for EscPos
    if (LModeloDF <> 0) and (LTipoDANFCE = CDANFCE_ESCPOS) then
      PrepararImpressao;
  finally
    Ini.Free;
  end;
end;

procedure TframePDV.PrepararImpressao;
begin
  // Parâmetros já carregados no LerConfiguracao; aqui só ativa a porta.
  if frmPrincipal.ACBrPosPrinter1.Ativo then
    Exit;
  try
    frmPrincipal.ACBrPosPrinter1.Ativar;
  except
    on E: Exception do
      ShowMessage('Não foi possível ativar a impressora na porta ' +
        frmPrincipal.ACBrPosPrinter1.Porta + sLineBreak + E.Message);
  end;
end;

{ ------------------------------- Venda (itens) ------------------------------- }

procedure TframePDV.CarregarProdutos;
begin
  // Simula um cadastro de produtos para ser utilizado na venda
  FProdutos.Add(1, 'Teste Produto 1', 1.00);
  FProdutos.Add(2, 'Teste Produto 2', 2.50);
  FProdutos.Add(3, 'Teste Produto 3', 0.50);
  FProdutos.Add(4, 'Teste Produto 4 (PIX)', 0.05);  // valor baixo p/ testar PIX real (ex.: QQPag)
end;

function TframePDV.LocalizarProduto(const ACodigo: string): Boolean;
var
  Produto: TClasseProduto;
begin
  Produto := FProdutos.Find(StrToIntDef(ACodigo, 0));
  Result := Assigned(Produto);

  if Result then
  begin
    edtDescricao.Text := Produto.Descricao;
    edtUnitario.Text := CurrToStr(Produto.ValorUnitario);
  end
  else
    ShowMessage('Código do produto não localizado!');
end;

procedure TframePDV.VenderItem;
var
  LQtde: Double;
  LUnitario: Currency;
  LTotalItem: Currency;
begin
  LQtde := StrToFloatDef(edtQtde.Text, 0);
  LUnitario := StrToCurrDef(edtUnitario.Text, 0);

  FItensPedido.AdicionarItem(
    StrToIntDef(edtCodigo.Text, 0),
    edtDescricao.Text,
    LQtde,
    LUnitario
  );
  LTotalItem := RoundTo(LQtde * LUnitario, -2);

  // Linha 1: código + descrição | Linha 2: qtde x unitário = total
  Log(PadLeft(edtCodigo.Text, 5) + ' ' + edtDescricao.Text);
  Log(
    PadLeft(FormatFloat(CMascaraQtde, LQtde), 9) + ' x ' +
    PadLeft('R$ ' + FormatFloat(CMascaraValor, LUnitario), 9) + ' = ' +
    PadLeft('R$ ' + FormatFloat(CMascaraValor, LTotalItem), 13));

  edtTotal.Text := CurrToStr(CalcularTotalNota);
end;

// Total da venda = soma dos itens (arredondados a 2 casas).
// É o mesmo valor que vai no vNF da NFC-e (ver PreencherTotais), pois este
// exemplo não tem desconto, acréscimo, frete, ST ou desoneração.
function TframePDV.CalcularTotalNota: Currency;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to FItensPedido.Count - 1 do
    Result := Result + RoundTo(FItensPedido[I].ValorTotal, -2);
  Result := RoundTo(Result, -2);
end;

procedure TframePDV.edtCodigoExit(Sender: TObject);
begin
  // Frame de pagamento aberto: o foco saiu porque o PDV foi escondido,
  // não porque o operador terminou de digitar
  if FPagamentoAberto or (not Visible) or (FStatusPedido <> spAberto) then
    Exit;

  if not LocalizarProduto(edtCodigo.Text) then
  begin
    if edtCodigo.CanFocus then edtCodigo.SetFocus;
  end
  else if edtQtde.CanFocus then
    edtQtde.SetFocus;
end;

procedure TframePDV.edtQtdeExit(Sender: TObject);
begin
  // Frame de pagamento aberto: o foco saiu porque o PDV foi escondido,
  // não porque o operador terminou de digitar
  if FPagamentoAberto or (not Visible) or (FStatusPedido <> spAberto) then
    Exit;

  if StrToFloatDef(edtQtde.Text, 0) > 0.01 then
    VenderItem;
  FocarCodigo;
end;

procedure TframePDV.btnIniciaVendaClick(Sender: TObject);
begin
  FItensPedido.Clear;
  FPagamentos.Clear;
  FStatusPedido := spAberto;
  pnlStatusCaixa.Caption := 'Caixa: Venda em andamento';
  mmLOG.Clear;
  LogEtapa('VENDA INICIADA');
  AtualizarBotoes;
  HabilitarEdicao(True);
  edtTotal.Clear;
  FocarCodigo;
end;

// Cancela a venda ainda aberta (antes do pagamento): nada foi enviado ao
// TEF nem à SEFAZ, então basta descartar os itens e liberar o caixa.
procedure TframePDV.framePDVRodape1btnCancelaVendaClick(Sender: TObject);
begin
  if (FStatusPedido <> spAberto) then
    Exit;

  if (FItensPedido.Count > 0) and
     (MessageDlg('Cancelar a venda em andamento?' + sLineBreak +
       'Os itens lançados serão descartados.',
       mtConfirmation, [mbYes, mbNo], 0) <> mrYes) then
    Exit;

  FPagamentos.Clear;
  Log('');
  Log('VENDA CANCELADA (nada foi enviado ao TEF/SEFAZ)', CCorErro, [fsBold]);
  LiberarCaixa;
end;

procedure TframePDV.btnSairPDVClick(Sender: TObject);
begin
  if Assigned(FOnFechar) then
    FOnFechar(Self);
end;

{ --------------------------------- Pagamento --------------------------------- }

procedure TframePDV.btnFinalizaVendaClick(Sender: TObject);
begin
  if FItensPedido.Count = 0 then
  begin
    ShowMessage('Adicione pelo menos um item antes de finalizar a venda.');
    Exit;
  end;

  // 1) Formas de pagamento (antes de montar a NFC-e)
  //    Abre o frame de pagamento no lugar do PDV; a venda continua em
  //    PagamentoConcluido, quando o operador Confirmar ou Cancelar.
  FStatusAntesPagamento := FStatusPedido;
  FStatusPedido := spAguardandoPagamento;
  AtualizarBotoes;
  AbrirPagamento;
end;

// Mesmo padrão do AbrirFrame (uFrames): frame alClient no mesmo container
// do PDV (frmPrincipal.pnpPrincipal). O PDV fica oculto enquanto paga.
procedure TframePDV.AbrirPagamento;
begin
  if not Assigned(FFramePagamento) then
  begin
    FFramePagamento := TframePagamento.Create(Self);  // liberado junto com o PDV
    FFramePagamento.Parent := Self.Parent;
    FFramePagamento.Align := alClient;
    FFramePagamento.OnConcluir := PagamentoConcluido;
  end;

  FPagamentoAberto := True;   // antes de esconder: desarma os OnExit
  Self.Visible := False;
  // Identificador da operação enviado ao TEF (no seu sistema: nº do pedido)
  FFramePagamento.Iniciar(CalcularTotalNota, FPagamentos,
    FormatDateTime('yymmddhhnnss', Now));
end;

procedure TframePDV.PagamentoConcluido(Sender: TObject; AConfirmado: Boolean);
begin
  // O frame de pagamento já se ocultou: volta para o PDV
  Self.Visible := True;
  FPagamentoAberto := False;

  if not AConfirmado then
  begin
    // Cancelou o pagamento: volta para a venda
    FStatusPedido := FStatusAntesPagamento;
    AtualizarBotoes;
    FocarCodigo;
    Exit;
  end;

  EmitirNFCe;
end;

{ ------------------------------------ TEF ------------------------------------ }

// Localiza a resposta TEF do pagamento, pela Rede + NSU
function TframePDV.AcharTransacaoTEF(IndicePagto: Integer): TACBrTEFResp;
var
  i: Integer;
begin
  Result := Nil;
  if (IndicePagto < 0) or (IndicePagto >= FPagamentos.Count) then
    Exit;

  if (FPagamentos[IndicePagto].NSU = '') then   // não foi pelo TEF
    Exit;

  i := frmPrincipal.ACBrTEFAPI1.RespostasTEF.AcharTransacao(
         FPagamentos[IndicePagto].Rede,
         FPagamentos[IndicePagto].NSU );
  if (i >= 0) then
    Result := frmPrincipal.ACBrTEFAPI1.RespostasTEF[i];
end;

// NFC-e autorizada:
//   - confirmação automática: as transações TEF JÁ foram confirmadas pelo
//     ACBrTEFAPI; só avisamos o TEF que a venda terminou;
//   - confirmação após a NFC-e: AGORA confirmamos as transações pendentes.
// Depois, imprime os comprovantes (vias do TEF).
procedure TframePDV.FinalizarTEFVenda;
var
  I: Integer;
  ATEFResp: TACBrTEFResp;
  LTEF: TACBrTEFAPI;
begin
  LTEF := frmPrincipal.ACBrTEFAPI1;
  try
    if LTEF.ConfirmarTransacaoAutomaticamente then
      LTEF.FinalizarVenda
    else
      LTEF.FinalizarTransacoesPendentes(tefstsSucessoAutomatico);

    if (TEFEventos <> nil) then
      for I := 0 to FPagamentos.Count - 1 do
        if not FPagamentos[I].Cancelada then
        begin
          ATEFResp := AcharTransacaoTEF(I);
          if Assigned(ATEFResp) then
            TEFEventos.ImprimirComprovantes(ATEFResp);
        end;
  except
    on E: Exception do
      MessageDlg('Falha ao finalizar/imprimir TEF:' + sLineBreak + E.Message,
        mtError, [mbOK], 0);
  end;
end;

// NFC-e NÃO autorizada: o ACBrTEFAPI trata cada transação TEF da venda:
//   - já confirmada (confirmação automática): ESTORNO (CancelarTransacao);
//   - ainda pendente (confirmação após a NFC-e): DESFAZIMENTO.
procedure TframePDV.EstornarTEFVenda;
begin
  try
    frmPrincipal.ACBrTEFAPI1.CancelarOuEstornarTransacoesDiretorioTrabalho;
  except
    on E: Exception do
      MessageDlg('Falha ao estornar TEF:' + sLineBreak + E.Message,
        mtError, [mbOK], 0);
  end;
end;

// NFC-e NÃO autorizada: o PIX pago direto no PSP é DEVOLVIDO ao cliente
procedure TframePDV.DevolverPIXVenda;
begin
  try
    PIXDevolverPagamentos(frmPrincipal.ACBrPixCD1, FPagamentos);
  except
    on E: Exception do
      MessageDlg('Falha ao devolver PIX:' + sLineBreak + E.Message,
        mtError, [mbOK], 0);
  end;
end;

{ ----------------------------------- NFC-e ----------------------------------- }

procedure TframePDV.EmitirNFCe;
var
  LNumero: String;
  LTotalNota: Currency;
  I: Integer;
  LTinhaTEF, LTinhaPIX: Boolean;
begin
  LTotalNota := CalcularTotalNota;

  // ETAPA 1 - Pagamento: já aconteceu no TframePagamento. Os pagamentos TEF
  // foram APROVADOS e CONFIRMADOS automaticamente pelo ACBrTEFAPI.
  LogEtapa('ETAPA 1 - PAGAMENTO');
  for I := 0 to FPagamentos.Count - 1 do
    if not FPagamentos[I].Cancelada then
    begin
      Log(PadRight(FPagamentos[I].Descricao, 22) +
          PadLeft(FormatFloat(CMascaraValor, FPagamentos[I].ValorPago), 12));
      if (FPagamentos[I].NSU <> '') then
        Log(IfThen(frmPrincipal.ACBrTEFAPI1.ConfirmarTransacaoAutomaticamente,
                   '  TEF aprovado e CONFIRMADO',
                   '  TEF aprovado - PENDENTE (confirma após a NFC-e)') + sLineBreak +
            '  Rede: ' + FPagamentos[I].Rede + '  NSU: ' + FPagamentos[I].NSU, CCorOK)
      else if (FPagamentos[I].Origem = opPSP) then
        Log('  PIX PAGO no PSP ' + FPagamentos[I].Rede + sLineBreak +
            '  e2eid: ' + FPagamentos[I].EndToEndId, CCorOK);
    end;
  if FPagamentos.Troco(LTotalNota) > 0 then
    Log(PadRight('Troco', 22) +
        PadLeft(FormatFloat(CMascaraValor, FPagamentos.Troco(LTotalNota)), 12));

  // ETAPA 2 - NFC-e
  //   Erro (ou desistência do operador): os pagamentos TEF são ESTORNADOS
  //   (confirmação automática) ou DESFEITOS (confirmação após a NFC-e).
  //   Autorizada: o TEF é confirmado/finalizado e os comprovantes impressos.
  LogEtapa('ETAPA 2 - NFC-e');
  FStatusPedido := spAguardandoNFe;
  try
    LNumero := '';
    if not InputQuery('WebServices Enviar', 'Número da Nota', LNumero) then
      raise Exception.Create('Emissão da NFC-e cancelada pelo operador.');

    AlimentarNFCe(StrToInt(LNumero));
    Log('Vínculo dos pagamentos montado (<pag>)', CCorOK);

    frmPrincipal.ACBrNFe1.NotasFiscais.Assinar;
    frmPrincipal.ACBrNFe1.NotasFiscais.GravarXML();
    frmPrincipal.ACBrNFe1.NotasFiscais.Validar;
    Log('Enviando para a SEFAZ...');
    frmPrincipal.ACBrNFe1.Enviar(1, True, True);   // gera exceção se rejeitar
  except
    on E: Exception do
    begin
      if (E is EVinculoPagamento) then   // nem chegou a ser enviada à SEFAZ
        Log('VÍNCULO INCOMPLETO - NFC-e NÃO enviada', CCorErro, [fsBold])
      else
        Log('NFC-e NÃO AUTORIZADA', CCorErro, [fsBold]);
      Log(E.Message, CCorErro);

      LTinhaTEF := FPagamentos.TemTEF;
      LTinhaPIX := FPagamentos.TemPIXPSP;
      if LTinhaTEF then
      begin
        EstornarTEFVenda;
        Log(IfThen(frmPrincipal.ACBrTEFAPI1.ConfirmarTransacaoAutomaticamente,
                   'Pagamentos TEF ESTORNADOS', 'Pagamentos TEF DESFEITOS'),
            CCorEstorno, [fsBold]);
      end;
      if LTinhaPIX then
      begin
        DevolverPIXVenda;
        Log('PIX (PSP) DEVOLVIDOS ao cliente', CCorEstorno, [fsBold]);
      end;

      MessageDlg('Falha na emissão da NFC-e:' + sLineBreak + E.Message +
        IfThen(LTinhaTEF, sLineBreak + sLineBreak +
          'Os pagamentos TEF foram estornados.', '') +
        IfThen(LTinhaPIX, sLineBreak + sLineBreak +
          'Os PIX (PSP) foram devolvidos ao cliente.', ''),
        mtError, [mbOK], 0);

      FStatusPedido := FStatusAntesPagamento;
      AtualizarBotoes;
      Exit;
    end;
  end;

  // NFC-e autorizada: finaliza o TEF e imprime os comprovantes
  ExibirRetornoNFCe;
  if FPagamentos.TemTEF then
  begin
    if not frmPrincipal.ACBrTEFAPI1.ConfirmarTransacaoAutomaticamente then
      Log('TEF CONFIRMADO (3ª perna, após a NFC-e)', CCorOK);
    FinalizarTEFVenda;
    Log('Comprovantes TEF impressos', CCorOK);
  end;

  MostrarRaioX;
  LiberarCaixa;
end;

// Monta a NFC-e no componente, grupo a grupo, na ordem do leiaute.
procedure TframePDV.AlimentarNFCe(ANumeroNFCe: Integer);
var
  LNFe: TNFe;
begin
  LerIniPDV(FConfiguracao);
  if (FConfiguracao.EmitUF = '') then
    raise Exception.Create('UF do emitente não configurada no INI.');
  if UFparaCodigoUF(FConfiguracao.EmitUF) <= 0 then
    raise Exception.Create('UF do emitente inválida: ' + FConfiguracao.EmitUF);

  // A NFC-e é autorizada pela SEFAZ da UF do emitente
  frmPrincipal.ACBrNFe1.Configuracoes.WebServices.UF := FConfiguracao.EmitUF;
  frmPrincipal.ACBrNFe1.Configuracoes.Geral.ModeloDF := moNFCe;
  frmPrincipal.ACBrNFe1.NotasFiscais.Clear;

  LNFe := frmPrincipal.ACBrNFe1.NotasFiscais.Add.NFe;

  PreencherIdentificacao(LNFe, ANumeroNFCe);   // grupo B  - ide
  PreencherEmitente(LNFe);                     // grupo C  - emit
  PreencherDestinatario(LNFe);                 // grupo E  - dest
  PreencherItens(LNFe);                        // grupo H  - det (produtos e impostos)
  PreencherTotais(LNFe);                       // grupo W  - total
  LNFe.Transp.modFrete := mfSemFrete;          // grupo X  - NFC-e não tem frete
  PreencherPagamentos(LNFe);                   // grupo YA - pag  (VÍNCULO DO PAGAMENTO)

  frmPrincipal.ACBrNFe1.NotasFiscais.GerarNFe;
end;

// Grupo B - Identificação da NFC-e
procedure TframePDV.PreencherIdentificacao(ANFe: TNFe; ANumeroNFCe: Integer);
begin
  ANFe.Ide.natOp    := 'VENDA DE MERCADORIA';
  ANFe.Ide.modelo   := 65;
  ANFe.Ide.serie    := 3;            // informar a série do seu perfil
  ANFe.Ide.nNF      := ANumeroNFCe;
  ANFe.Ide.cNF      := GerarCodigoDFe(ANFe.Ide.nNF);
  ANFe.Ide.dEmi     := Now;
  ANFe.Ide.tpNF     := tnSaida;
  ANFe.Ide.tpEmis   := TACBrTipoEmissao(FConfiguracao.FormaEmissao);
  ANFe.Ide.tpAmb    := frmPrincipal.ACBrNFe1.Configuracoes.WebServices.Ambiente;
  ANFe.Ide.cUF      := UFparaCodigoUF(FConfiguracao.EmitUF);
  ANFe.Ide.cMunFG   := StrToInt(FConfiguracao.EmitCodCidade);
  ANFe.Ide.finNFe   := fnNormal;
  ANFe.Ide.tpImp    := tiNFCe;
  ANFe.Ide.indFinal := cfConsumidorFinal;
  ANFe.Ide.indPres  := pcPresencial;     // venda presencial (no caixa)
  ANFe.Ide.indIntermed := iiSemOperacao; // sem intermediador (marketplace)
  ANFe.Ide.procEmi  := peAplicativoContribuinte;
  ANFe.Ide.verProc  := '1.0.0.0';
end;

// Grupo C - Emitente (dados da seção [Emitente] do INI)
procedure TframePDV.PreencherEmitente(ANFe: TNFe);
begin
  ANFe.Emit.CNPJCPF := FConfiguracao.EmitCNPJ;
  ANFe.Emit.IE      := FConfiguracao.EmitIE;
  ANFe.Emit.xNome   := FConfiguracao.EmitRazao;
  ANFe.Emit.xFant   := FConfiguracao.EmitFantasia;
  // INI: 0 = Simples Nacional | 1 = Excesso sublimite | 2 = Regime Normal
  ANFe.Emit.CRT     := TpcnCRT(FConfiguracao.CRT);

  ANFe.Emit.EnderEmit.fone    := FConfiguracao.EmitFone;
  ANFe.Emit.EnderEmit.CEP     := StrToInt(FConfiguracao.EmitCEP);
  ANFe.Emit.EnderEmit.xLgr    := FConfiguracao.EmitLogradouro;
  ANFe.Emit.EnderEmit.nro     := FConfiguracao.EmitNumero;
  ANFe.Emit.EnderEmit.xCpl    := FConfiguracao.EmitComplemento;
  ANFe.Emit.EnderEmit.xBairro := FConfiguracao.EmitBairro;
  ANFe.Emit.EnderEmit.cMun    := StrToInt(FConfiguracao.EmitCodCidade);
  ANFe.Emit.EnderEmit.xMun    := FConfiguracao.EmitCidade;
  ANFe.Emit.EnderEmit.UF      := FConfiguracao.EmitUF;
  ANFe.Emit.EnderEmit.cPais   := 1058;
  ANFe.Emit.EnderEmit.xPais   := 'BRASIL';
end;

// Grupo E - Destinatário
// Na NFC-e o destinatário é opcional (consumidor não identificado).
// Este exemplo ainda usa um destinatário fixo (não contribuinte do ICMS).
procedure TframePDV.PreencherDestinatario(ANFe: TNFe);
begin
  ANFe.Dest.CNPJCPF   := '05481336000137';
  ANFe.Dest.xNome     := 'D.J. COM. E LOCACAO DE SOFTWARES LTDA - ME';
  ANFe.Dest.indIEDest := inNaoContribuinte;

  ANFe.Dest.EnderDest.Fone    := '1532599600';
  ANFe.Dest.EnderDest.CEP     := 18270170;
  ANFe.Dest.EnderDest.xLgr    := 'Rua Coronel Aureliano de Camargo';
  ANFe.Dest.EnderDest.nro     := '973';
  ANFe.Dest.EnderDest.xBairro := 'Centro';
  ANFe.Dest.EnderDest.cMun    := 3554003;
  ANFe.Dest.EnderDest.xMun    := 'Tatui';
  ANFe.Dest.EnderDest.UF      := 'SP';
  ANFe.Dest.EnderDest.cPais   := 1058;
  ANFe.Dest.EnderDest.xPais   := 'BRASIL';
end;

// Grupo H - Itens (produto + impostos)
// Tributação simplificada do exemplo: ICMS CST 00 (18%), PIS/COFINS CST 99
// zerados. Os campos não informados ficam com o valor padrão do ACBr (zero).
procedure TframePDV.PreencherItens(ANFe: TNFe);
var
  I: Integer;
  LItemPedido: TItemPedido;
  LTotalItem: Currency;
begin
  for I := 0 to FItensPedido.Count - 1 do
  begin
    LItemPedido := FItensPedido[I];
    LTotalItem := RoundTo(LItemPedido.ValorTotal, -2);

    with ANFe.Det.New do
    begin
      Prod.nItem    := I + 1;
      Prod.cProd    := IntToStr(LItemPedido.Codigo);
      Prod.xProd    := LItemPedido.Descricao;
      Prod.cEAN     := CProdutoEAN;
      Prod.NCM      := CProdutoNCM;
      Prod.CFOP     := CProdutoCFOP;
      Prod.uCom     := CProdutoUnid;
      Prod.qCom     := LItemPedido.Quantidade;
      Prod.vUnCom   := LItemPedido.ValorUnitario;
      Prod.vProd    := LTotalItem;
      Prod.cEANTrib := CProdutoEAN;
      Prod.uTrib    := CProdutoUnid;
      Prod.qTrib    := LItemPedido.Quantidade;
      Prod.vUnTrib  := LItemPedido.ValorUnitario;
      Prod.indTot   := itSomaTotalNFe;

      Imposto.ICMS.orig  := oeNacional;
      Imposto.ICMS.CST   := cst00;
      Imposto.ICMS.modBC := dbiValorOperacao;
      Imposto.ICMS.vBC   := LTotalItem;
      Imposto.ICMS.pICMS := CAliquotaICMS;
      Imposto.ICMS.vICMS := RoundTo(LTotalItem * CAliquotaICMS / 100, -2);

      Imposto.PIS.CST    := pis99;
      Imposto.COFINS.CST := cof99;
    end;
  end;
end;

// Grupo W - Totais: soma dos itens.
// vNF = vProd, pois o exemplo não tem desconto, frete, ST ou desoneração.
procedure TframePDV.PreencherTotais(ANFe: TNFe);
var
  I: Integer;
begin
  for I := 0 to ANFe.Det.Count - 1 do
  begin
    ANFe.Total.ICMSTot.vProd := ANFe.Total.ICMSTot.vProd + ANFe.Det[I].Prod.vProd;
    ANFe.Total.ICMSTot.vBC   := ANFe.Total.ICMSTot.vBC   + ANFe.Det[I].Imposto.ICMS.vBC;
    ANFe.Total.ICMSTot.vICMS := ANFe.Total.ICMSTot.vICMS + ANFe.Det[I].Imposto.ICMS.vICMS;
  end;

  ANFe.Total.ICMSTot.vNF := ANFe.Total.ICMSTot.vProd;
end;

// Grupo YA - Pagamentos: aqui acontece o VÍNCULO do meio de pagamento com a
// NFC-e. Cada pagamento da venda vira um <detPag>; as regras de cada tag
// estão na unit uVinculoPagamentoNFCe.
procedure TframePDV.PreencherPagamentos(ANFe: TNFe);
var
  I: Integer;
begin
  if FPagamentos.Count = 0 then
    raise Exception.Create('Nenhuma forma de pagamento informada.');
  if FPagamentos.TotalPago < ANFe.Total.ICMSTot.vNF then
    raise Exception.Create('Total pago menor que o total da nota (' +
      FormatFloat(CMascaraValor, ANFe.Total.ICMSTot.vNF) + ').');

  for I := 0 to FPagamentos.Count - 1 do
    if not FPagamentos[I].Cancelada then
      PreencherPagamentoNFCe( ANFe.pag.New,           // novo <detPag>
                              FPagamentos[I],         // pagamento da venda
                              AcharTransacaoTEF(I),   // resposta do TEF (nil = sem TEF)
                              ANFe.Emit.CNPJCPF );    // estabelecimento beneficiário

  {Intermediador ou Marketplace}
  ANFe.infIntermed.CNPJ := '';          // CNPJ Intermediador ou Marketplace
  ANFe.infIntermed.idCadIntTran := '';  // Identificador Cadastral no Intermediador

  ANFe.pag.vTroco := FPagamentos.Troco(ANFe.Total.ICMSTot.vNF);
end;

procedure TframePDV.ExibirRetornoNFCe;
begin
  with frmPrincipal.ACBrNFe1 do
  begin
    Log('NFC-e AUTORIZADA', CCorOK, [fsBold]);
    Log('cStat: ' + IntToStr(WebServices.Enviar.cStat) + ' - ' +
        WebServices.Enviar.xMotivo, CCorOK);
    Log('Chave: ' + NotasFiscais[0].NFe.procNFe.chDFe);
    Log('Protocolo: ' + WebServices.Enviar.Protocolo);
    Log('Ambiente: ' + TipoAmbienteToStr(WebServices.Enviar.TpAmb) +
        '  (1 = Produção, 2 = Homologação)');
  end;
end;

// Abre o Raio-X da NFC-e que acabou de ser autorizada:
// resposta do TEF -> tags do <detPag> + conferência do comprovante + XML <pag>
procedure TframePDV.MostrarRaioX;
var
  I, K: Integer;
  LNFe: TNFe;
  LResp: TACBrTEFResp;
  LConferencia: TStringList;
begin
  if not Assigned(FRaioX) then
    FRaioX := TfrmRaioXVinculo.Create(Self);

  LNFe := frmPrincipal.ACBrNFe1.NotasFiscais[0].NFe;
  FRaioX.Limpar;

  LConferencia := TStringList.Create;
  try
    // Os <detPag> foram gerados na mesma ordem dos pagamentos não cancelados
    K := 0;
    for I := 0 to FPagamentos.Count - 1 do
    begin
      if FPagamentos[I].Cancelada then
        Continue;

      LResp := AcharTransacaoTEF(I);
      LConferencia.Clear;
      if Assigned(LResp) then
        ConferirComprovante(LNFe.pag[K], LResp, LConferencia);

      FRaioX.AdicionarPagamento(IntToStr(K + 1) + ') ' + FPagamentos[I].Descricao,
        MapaVinculo(LNFe.pag[K], FPagamentos[I], LResp), LConferencia);
      Inc(K);
    end;
  finally
    LConferencia.Free;
  end;

  FRaioX.ExibirXML(
    ExtrairGrupoPagXML(frmPrincipal.ACBrNFe1.NotasFiscais[0].XMLOriginal),
    LNFe.procNFe.chDFe);
  FRaioX.Show;
end;

procedure TframePDV.btnRaioXClick(Sender: TObject);
begin
  if Assigned(FRaioX) then
    FRaioX.Show;
end;

// Menu Administrativo do gerenciador (GP): reimpressão, cancelamento,
// relatórios... As opções dependem de cada GP (PayGo, CliSiTef...).
// Igual ao btAdministrativoClick do exemplo ACBr\Exemplos\ACBrTEFD\TEFAPI.
// Resultado e comprovantes: TTEFEventos.QuandoFinalizarOperacao (uTEFUtils).
procedure TframePDV.btnMenuADMClick(Sender: TObject);
var
  LArqINI: String;
  LTEF: TACBrTEFAPI;
begin
  if (FStatusPedido <> spFechado) then
    Exit;

  LArqINI := ChangeFileExt(Application.ExeName, '.ini');
  if not TEFHabilitado(LArqINI) then
  begin
    ShowMessage('TEF não configurado. Configure em CONFIG. TEF.');
    Exit;
  end;

  LTEF := frmPrincipal.ACBrTEFAPI1;
  LogEtapa('MENU ADMINISTRATIVO TEF');
  try
    // Mesma configuração gravada pelo uframeconfigTEF
    ConfigurarTEFPeloINI(LTEF, frmPrincipal.ACBrPosPrinter1, LArqINI);
    if (TEFEventos <> nil) then
      TEFEventos.OnLog := LogTEF;   // log do TEF neste PDV
    try
      if not LTEF.Inicializado then
        LTEF.Inicializar;

      // Igual ao IniciarOperacao do exemplo TEFAPI:
      // limpa respostas TEF anteriores e apaga arquivos de backup
      LTEF.LimparRespostasTEF;

      LTEF.EfetuarAdministrativa(tefopAdministrativo);

      if LTEF.UltimaRespostaTEF.Sucesso then
        Log('Operação administrativa concluída', CCorOK)
      else
        Log('Operação administrativa não concluída', CCorErro);
    finally
      if (TEFEventos <> nil) then
        TEFEventos.OnLog := nil;
    end;
  except
    on E: Exception do
    begin
      Log('ERRO: ' + E.Message, CCorErro);
      MessageDlg('Falha no Menu Administrativo do TEF:' + sLineBreak + E.Message,
        mtError, [mbOK], 0);
    end;
  end;
end;

{ ----------------------------------- Tela ------------------------------------ }

// Acrescenta uma linha colorida no log da venda
procedure TframePDV.Log(const ATexto: String; ACor: TColor; AEstilo: TFontStyles);
begin
  mmLOG.ReadOnly := False;
  try
    mmLOG.SelStart := mmLOG.GetTextLen;
    mmLOG.SelLength := 0;
    mmLOG.SelAttributes.Color := ACor;
    mmLOG.SelAttributes.Style := AEstilo;
    mmLOG.SelText := ATexto + sLineBreak;
  finally
    mmLOG.ReadOnly := True;
  end;
  mmLOG.Perform(EM_SCROLLCARET, 0, 0);
end;

// Linhas de log do TEF (TTEFEventos.OnLog) durante o Menu Administrativo
procedure TframePDV.LogTEF(const ALinha: String);
begin
  Log(ALinha, clGray);
end;

procedure TframePDV.LogEtapa(const ATitulo: String);
begin
  Log('');
  Log('=== ' + ATitulo + ' ===', CCorEtapa, [fsBold]);
end;

procedure TframePDV.AtualizarBotoes;
begin
  framePDVRodape1.btnIniciaVenda.Enabled := False;
  framePDVRodape1.btnFinalizaVenda.Enabled := False;
  framePDVRodape1.btnCancelaVenda.Enabled := False;
  framePDVRodape1.btnSairPDV.Enabled := False;
  // Menu Administrativo do TEF: só com o caixa livre (fora de uma venda)
  framePDVRodape1.btnMenuADM.Enabled := (FStatusPedido = spFechado);
  // Raio-X: disponível depois da 1ª NFC-e autorizada
  framePDVRodape1.btnRaioX.Enabled := Assigned(FRaioX) and (FStatusPedido = spFechado);

  case FStatusPedido of
    spFechado:
      begin
        framePDVRodape1.btnIniciaVenda.Enabled := True;
        framePDVRodape1.btnSairPDV.Enabled := True;
      end;

    spAberto:
      begin
        framePDVRodape1.btnFinalizaVenda.Enabled := True;
        framePDVRodape1.btnCancelaVenda.Enabled := True;
      end;

    spAguardandoPagamento,
    spAguardandoNFe:
      framePDVRodape1.btnFinalizaVenda.Enabled := True;
  end;
end;

procedure TframePDV.FocarCodigo;
begin
  if (not FPagamentoAberto) and edtCodigo.CanFocus then
    edtCodigo.SetFocus;
end;

procedure TframePDV.LimparCampos;
var
  I: Integer;
begin
  for I := 0 to ComponentCount - 1 do
    if (Components[I] is TEdit) then
      TEdit(Components[I]).Clear;
end;

procedure TframePDV.HabilitarEdicao(AHabilitar: Boolean);
begin
  edtCodigo.Enabled := AHabilitar;
  edtQtde.Enabled := AHabilitar;
end;

// Venda encerrada (concluída ou cancelada): libera o caixa para a próxima
procedure TframePDV.LiberarCaixa;
begin
  FStatusPedido := spFechado;   // antes de desabilitar os edits (OnExit)
  FItensPedido.Clear;
  pnlStatusCaixa.Caption := 'Caixa: Disponível';
  LimparCampos;
  HabilitarEdicao(False);
  AtualizarBotoes;
end;

end.
