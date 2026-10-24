unit uTEFUtils;

{
  Rotinas de apoio ao TEF (ACBrTEFAPI) do ExemploNFCeTEF.

  - ConfigurarTEFPeloINI: aplica no componente o que foi gravado pelo
    uframeconfigTEF (mesmas chaves do INI). Usado pela tela de configuração
    e pela tela de pagamento, assim existe UM único ponto de configuração.
  - TTEFEventos: trata os eventos do ACBrTEFAPI (mensagens, menus, campos,
    QR Code, transação pendente...). Baseado no exemplo
    ACBr\Exemplos\ACBrTEFD\TEFAPI\Delphi\frPrincipal.pas.
  - OnLog / OnExibirQRCode / CentralizarSobre: permitem que uma tela (ex.:
    uframePagamento) mostre o log do TEF e o QR Code (PIX) dentro dela.
    Sem eles, o QR Code abre numa janela flutuante.
  - O vínculo do pagamento com a NFC-e (CNPJ da credenciadora, bandeira,
    cAut...) fica na unit uVinculoPagamentoNFCe.
}

interface

uses
  Windows, Classes, SysUtils, Forms, Controls, StdCtrls, ExtCtrls, Graphics, Dialogs,
  IniFiles, SyncObjs,
  ACBrBase, ACBrPosPrinter,
  ACBrTEFComum, ACBrTEFAPIComum, ACBrTEFAPI;

type

  // Uma linha de log do TEF (QuandoGravarLog e mensagens do exemplo)
  TTEFLogEvent = procedure(const ALinha: String) of object;
  // DadosQRCode = '' -> esconder o QR Code
  TTEFQRCodeEvent = procedure(const ADadosQRCode: String) of object;

  { TTEFEventos }

  TTEFEventos = class
  private
    FTEF: TACBrTEFAPI;
    FPosPrinter: TACBrPosPrinter;
    FArqINI: String;
    FCancelarPeloOperador: Boolean;

    FFormMsg: TForm;
    FLblOperador: TLabel;
    FLblCliente: TLabel;
    FBtnCancelar: TButton;

    FFormQRCode: TForm;
    FImgQRCode: TImage;

    FOnLog: TTEFLogEvent;
    FOnExibirQRCode: TTEFQRCodeEvent;
    FCentralizarSobre: TWinControl;
    FLogPendente: TStringList;   // linhas vindas de outra thread
    FLogLock: TCriticalSection;  // protege FLogPendente
    FTimerLog: TTimer;           // descarrega FLogPendente na thread principal
    FValorEstorno: Double;       // valor da transação sendo estornada (0 = nenhuma)

    procedure CriarFormMensagem;
    procedure CriarFormQRCode;
    procedure BtnCancelarClick(Sender: TObject);
    procedure MostrarMensagem(const AOperador, ACliente: String);
    procedure EsconderMensagem;
    procedure EsconderQRCode;
    procedure Log(const ALinha: String);
    procedure DescarregarLogPendente(Sender: TObject);
    procedure PosicionarFormMensagem;
    procedure DetectarEstorno(const ALogLine: String);

    // Eventos do ACBrTEFAPI
    procedure QuandoExibirMensagem(const Mensagem: String;
      Terminal: TACBrTEFAPITela; MilissegundosExibicao: Integer);
    procedure QuandoPerguntarMenu(const Titulo: String; Opcoes: TStringList;
      var ItemSelecionado: Integer);
    procedure QuandoPerguntarCampo(DefinicaoCampo: TACBrTEFAPIDefinicaoCampo;
      var Resposta: String; var Validado: Boolean; var Cancelado: Boolean);
    procedure QuandoEsperarOperacao(OperacaoAPI: TACBrTEFAPIOperacaoAPI;
      var Cancelar: Boolean);
    procedure QuandoExibirQRCode(const DadosQRCode: String);
    procedure QuandoGravarLog(const ALogLine: String; var Tratado: Boolean);
    procedure QuandoFinalizarOperacao(RespostaTEF: TACBrTEFResp);
    procedure QuandoDetectarTransacaoPendente(RespostaTEF: TACBrTEFResp;
      const MsgErro: String);
  public
    constructor Create(ATEF: TACBrTEFAPI; APosPrinter: TACBrPosPrinter;
      const AArqINI: String);
    destructor Destroy; override;

    procedure Ligar;
    procedure FimOperacao;   // esconde mensagens / QR Code

    procedure ImprimirComprovantes(ATEFResp: TACBrTEFResp);
    procedure ImprimirRelatorio(const ATexto: String);

    // Gera a imagem do QR Code (texto ou caminho de arquivo enviado pelo GP)
    class procedure GerarImagemQRCode(const ADadosQRCode: String;
      APicture: TPicture);

    // Tela que quer receber o log e o QR Code (nil = comportamento padrão)
    property OnLog: TTEFLogEvent read FOnLog write FOnLog;
    property OnExibirQRCode: TTEFQRCodeEvent read FOnExibirQRCode write FOnExibirQRCode;
    // Janela de mensagens do TEF centralizada sobre este controle
    // (para não cobrir o QR Code). nil = centro da tela.
    property CentralizarSobre: TWinControl read FCentralizarSobre write FCentralizarSobre;
  end;

// Retorna True se o TEF está ligado (tela principal) e há um GP configurado no INI
function TEFHabilitado(const AArqINI: String): Boolean;

// Aplica a configuração do INI no componente e liga os eventos
procedure ConfigurarTEFPeloINI(ATEF: TACBrTEFAPI; APosPrinter: TACBrPosPrinter;
  const AArqINI: String);

// Nome do arquivo de log (campo "Log" do frame de configuração)
function NomeArquivoLogTEF(const ALog: String): String;

// Instância única que trata os eventos (criada pelo ConfigurarTEFPeloINI)
function TEFEventos: TTEFEventos;

implementation

uses
  Types, TypInfo, StrUtils,
  ACBrUtil.Strings, ACBrUtil.FilesIO,
  ACBrDelphiZXingQRCode,
  ACBrTEFAPIPayGoWeb, ACBrTEFAPITXT, ACBrTEFTXTComum, ACBrTEFTXTGerenciadorPadrao,
  frMenuTEF, frObtemCampo, frExibeMensagem;

var
  GTEFEventos: TTEFEventos = nil;

const
  CMoedas: array[0..2] of Integer = (986, 840, 978);  // REAL, DOLAR, EURO (cbxMoeda)

function TEFEventos: TTEFEventos;
begin
  Result := GTEFEventos;
end;

function TEFHabilitado(const AArqINI: String): Boolean;
var
  INI: TIniFile;
begin
  INI := TIniFile.Create(AArqINI);
  try
    Result := INI.ReadBool('TEF', 'Habilitado', True) and
              (INI.ReadInteger('TEF', 'GP', 0) > 0);   // 0 = tefApiNenhum
  finally
    INI.Free;
  end;
end;

function NomeArquivoLogTEF(const ALog: String): String;
var
  LArquivo, LPath: String;
begin
  Result := '';
  LArquivo := ExtractFileName(Trim(ALog));
  if LArquivo = '' then
    Exit;

  LPath := ExtractFilePath(Trim(ALog));
  if LPath = '' then
    LPath := ExtractFilePath(Application.ExeName);
  if ExtractFileExt(LArquivo) = '' then
    LArquivo := LArquivo + '.txt';

  Result := IncludeTrailingPathDelimiter(LPath) + LArquivo;
end;

procedure ConfigurarTEFPeloINI(ATEF: TACBrTEFAPI; APosPrinter: TACBrPosPrinter;
  const AArqINI: String);
var
  INI: TIniFile;
  LModelo: TACBrTEFAPITipo;
  LMoeda: Integer;
begin
  INI := TIniFile.Create(AArqINI);
  try
    LModelo := TACBrTEFAPITipo(INI.ReadInteger('TEF', 'GP', 0));

    // Trocar o Modelo com o TEF inicializado gera exceção no ACBr
    if ATEF.Inicializado and (ATEF.Modelo <> LModelo) then
      ATEF.DesInicializar;

    ATEF.Modelo := LModelo;
    ATEF.ArqLOG := NomeArquivoLogTEF(INI.ReadString('TEF', 'Log', ''));
    ATEF.TratamentoTransacaoPendente :=
      TACBrTEFTratamentoTransacaoPendente(INI.ReadInteger('TEF', 'TransacaoPendente', 0));
    ATEF.TratamentoTransacaoInicializacao :=
      TACBrTEFTratamentoTransacaoInicializacao(INI.ReadInteger('TEF', 'TransacaoPendenteInicializacao', 1));
    // Confirmação da transação TEF (a "3ª perna"):
    //   True  - o ACBrTEFAPI confirma logo após a aprovação. Se a NFC-e
    //           falhar depois, o pagamento precisa ser ESTORNADO.
    //   False - o PDV só confirma DEPOIS da NFC-e autorizada. Se a NFC-e
    //           falhar, a transação é DESFEITA (nunca chegou a ser confirmada).
    // Ver TframePDV.FinalizarTEFVenda / EstornarTEFVenda.
    ATEF.ConfirmarTransacaoAutomaticamente := INI.ReadBool('TEF', 'ConfirmarAutomaticamente', True);

    ATEF.DadosAutomacao.AutoAtendimento := INI.ReadBool('TEF', 'AutoAtendimento', False);
    ATEF.DadosAutomacao.ImprimeViaClienteReduzida := INI.ReadBool('TEF', 'ImprimirViaReduzida', False);
    ATEF.DadosAutomacao.SuportaDesconto := INI.ReadBool('TEF', 'SuportaDesconto', True);
    ATEF.DadosAutomacao.SuportaSaque := INI.ReadBool('TEF', 'SuportaSaque', True);

    ATEF.DadosAutomacao.NomeSoftwareHouse := INI.ReadString('SwHouse', 'RazaoSocial', '');
    ATEF.DadosAutomacao.CNPJSoftwareHouse := INI.ReadString('SwHouse', 'CNPJ', '');
    ATEF.DadosAutomacao.NomeAplicacao := INI.ReadString('Aplicacao', 'Nome', '');
    ATEF.DadosAutomacao.VersaoAplicacao := INI.ReadString('Aplicacao', 'Versao', '');
    ATEF.DadosAutomacao.MensagemPinPad := INI.ReadString('Aplicacao', 'MsgPinPad', '');
    ATEF.DadosAutomacao.Idioma := TACBrTEFAPIIdioma(INI.ReadInteger('Aplicacao', 'Idioma', 0));
    LMoeda := INI.ReadInteger('Aplicacao', 'Moeda', 0);
    if (LMoeda >= Low(CMoedas)) and (LMoeda <= High(CMoedas)) then
      ATEF.DadosAutomacao.MoedaISO4217 := CMoedas[LMoeda]
    else
      ATEF.DadosAutomacao.MoedaISO4217 := CMODEDA_BRL;
    ATEF.DadosAutomacao.ParamAplicacao := INI.ReadString('Aplicacao', 'Parametros', '');

    ATEF.DadosEstabelecimento.RazaoSocial := INI.ReadString('Estabelecimento', 'RazaoSocial', '');
    ATEF.DadosEstabelecimento.CNPJ := INI.ReadString('Estabelecimento', 'CNPJ', '');

    ATEF.DadosTerminal.CodTerminal := INI.ReadString('Terminal', 'CodTerminal', '');
    ATEF.DadosTerminal.CodEmpresa := INI.ReadString('Terminal', 'CodEmpresa', '');
    ATEF.DadosTerminal.CodFilial := INI.ReadString('Terminal', 'CodFilial', '');
    ATEF.DadosTerminal.PortaPinPad := INI.ReadString('Terminal', 'PortaPinPad', '');
    ATEF.DadosTerminal.EnderecoServidor := INI.ReadString('Terminal', 'EnderecoServidor', '');
    ATEF.DadosTerminal.Ambiente := TACBrTEFAPIAmbiente(INI.ReadInteger('Terminal', 'Ambiente', 0));
    ATEF.DadosTerminal.ParamComunicacao := INI.ReadString('Terminal', 'ParamComunic', '');
    ATEF.DadosTerminal.GravarLogTEF := INI.ReadBool('Terminal', 'GravarLogTEF', False);

    case INI.ReadInteger('TEF', 'QRCode', 1) of
      0: ATEF.ExibicaoQRCode := qrapiNaoSuportado;
      2: ATEF.ExibicaoQRCode := qrapiExibirPinPad;
      3, 4: ATEF.ExibicaoQRCode := qrapiExibirAplicacao;   // 3-Tela, 4-Imprimir
    else
      ATEF.ExibicaoQRCode := qrapiAuto;
    end;

    // PayGoWeb: diretório de trabalho (mesmo valor do exemplo TEFAPI)
    if (ATEF.TEF is TACBrTEFAPIClassPayGoWeb) then
      TACBrTEFAPIClassPayGoWeb(ATEF.TEF).DiretorioTrabalho := 'C:\PAYGOWEB\';

    // TEF por troca de arquivos (TXT)
    if (ATEF.TEF is TACBrTEFAPIClassTXT) then
    begin
      with TACBrTEFAPIClassTXT(ATEF.TEF) do
      begin
        Modelo := TACBrTEFTXTModelo(INI.ReadInteger('TXT', 'GP', 0));
        with TEFTXT.Config do
        begin
          DirReq := INI.ReadString('TXT', 'DirReq', DirReq);
          DirResp := INI.ReadString('TXT', 'DirResp', DirResp);
          ArqReq := INI.ReadString('TXT', 'ArqReq', ArqReq);
          ArqSts := INI.ReadString('TXT', 'ArqSts', ArqSts);
          ArqResp := INI.ReadString('TXT', 'ArqResp', ArqResp);
          NivelLog := INI.ReadInteger('TXT', 'NivelLog', NivelLog);
        end;
      end;
    end;
  finally
    INI.Free;
  end;

  // Eventos de interface com o operador
  if (GTEFEventos = nil) then
    GTEFEventos := TTEFEventos.Create(ATEF, APosPrinter, AArqINI);
  GTEFEventos.Ligar;
end;

{ TTEFEventos }

constructor TTEFEventos.Create(ATEF: TACBrTEFAPI; APosPrinter: TACBrPosPrinter;
  const AArqINI: String);
begin
  inherited Create;
  FTEF := ATEF;
  FPosPrinter := APosPrinter;
  FArqINI := AArqINI;
  FCancelarPeloOperador := False;
  FLogPendente := TStringList.Create;
  FLogLock := TCriticalSection.Create;
  FTimerLog := TTimer.Create(nil);
  FTimerLog.Interval := 100;
  FTimerLog.OnTimer := DescarregarLogPendente;
  CriarFormMensagem;
  CriarFormQRCode;
end;

destructor TTEFEventos.Destroy;
begin
  FFormMsg.Free;
  FFormQRCode.Free;
  FTimerLog.Free;
  FLogLock.Free;
  FLogPendente.Free;
  inherited Destroy;
end;

procedure TTEFEventos.Ligar;
begin
  FTEF.QuandoExibirMensagem := QuandoExibirMensagem;
  FTEF.QuandoPerguntarMenu := QuandoPerguntarMenu;
  FTEF.QuandoPerguntarCampo := QuandoPerguntarCampo;
  FTEF.QuandoEsperarOperacao := QuandoEsperarOperacao;
  FTEF.QuandoExibirQRCode := QuandoExibirQRCode;
  FTEF.QuandoFinalizarOperacao := QuandoFinalizarOperacao;
  FTEF.QuandoDetectarTransacaoPendente := QuandoDetectarTransacaoPendente;
  FTEF.QuandoGravarLog := QuandoGravarLog;
end;

procedure TTEFEventos.CriarFormMensagem;
begin
  // Janela NÃO modal com a mensagem do TEF ("Insira o cartão", "Digite a senha"...)
  FFormMsg := TForm.CreateNew(nil);
  FFormMsg.BorderStyle := bsToolWindow;
  FFormMsg.BorderIcons := [];
  FFormMsg.Caption := 'TEF';
  FFormMsg.FormStyle := fsStayOnTop;
  FFormMsg.Position := poScreenCenter;
  FFormMsg.ClientWidth := 480;
  FFormMsg.ClientHeight := 190;
  FFormMsg.Color := clWhite;

  FLblOperador := TLabel.Create(FFormMsg);
  FLblOperador.Parent := FFormMsg;
  FLblOperador.SetBounds(12, 12, 456, 80);
  FLblOperador.AutoSize := False;
  FLblOperador.WordWrap := True;
  FLblOperador.Alignment := taCenter;
  FLblOperador.Font.Height := -20;
  FLblOperador.Font.Style := [fsBold];

  FLblCliente := TLabel.Create(FFormMsg);
  FLblCliente.Parent := FFormMsg;
  FLblCliente.SetBounds(12, 96, 456, 40);
  FLblCliente.AutoSize := False;
  FLblCliente.WordWrap := True;
  FLblCliente.Alignment := taCenter;
  FLblCliente.Font.Height := -15;
  FLblCliente.Font.Color := clNavy;

  FBtnCancelar := TButton.Create(FFormMsg);
  FBtnCancelar.Parent := FFormMsg;
  FBtnCancelar.SetBounds(180, 146, 120, 32);
  FBtnCancelar.Caption := 'Cancelar TEF';
  FBtnCancelar.OnClick := BtnCancelarClick;
end;

procedure TTEFEventos.CriarFormQRCode;
begin
  FFormQRCode := TForm.CreateNew(nil);
  FFormQRCode.BorderStyle := bsToolWindow;
  FFormQRCode.BorderIcons := [];
  FFormQRCode.Caption := 'Leia o QR Code para pagar';
  FFormQRCode.FormStyle := fsStayOnTop;
  FFormQRCode.Position := poScreenCenter;
  FFormQRCode.ClientWidth := 320;
  FFormQRCode.ClientHeight := 320;
  FFormQRCode.Color := clWhite;

  FImgQRCode := TImage.Create(FFormQRCode);
  FImgQRCode.Parent := FFormQRCode;
  FImgQRCode.Align := alClient;
  FImgQRCode.Stretch := True;
  FImgQRCode.Proportional := True;
  FImgQRCode.Center := True;
end;

procedure TTEFEventos.BtnCancelarClick(Sender: TObject);
begin
  FCancelarPeloOperador := True;   // lido no QuandoEsperarOperacao
  FBtnCancelar.Enabled := False;
end;

procedure TTEFEventos.MostrarMensagem(const AOperador, ACliente: String);
begin
  if AOperador <> '' then
    FLblOperador.Caption := AOperador;
  if ACliente <> '' then
    FLblCliente.Caption := ACliente;

  if (Trim(FLblOperador.Caption) = '') and (Trim(FLblCliente.Caption) = '') then
    EsconderMensagem
  else if not FFormMsg.Visible then
  begin
    FBtnCancelar.Enabled := True;
    PosicionarFormMensagem;
    FFormMsg.Show;
  end;
  FFormMsg.Update;
end;

procedure TTEFEventos.EsconderMensagem;
begin
  FLblOperador.Caption := '';
  FLblCliente.Caption := '';
  FFormMsg.Hide;
end;

procedure TTEFEventos.EsconderQRCode;
begin
  FImgQRCode.Picture := nil;
  FFormQRCode.Hide;
end;

procedure TTEFEventos.FimOperacao;
begin
  EsconderMensagem;
  EsconderQRCode;
  if Assigned(FOnExibirQRCode) then
    FOnExibirQRCode('');
  FCancelarPeloOperador := False;
end;

procedure TTEFEventos.PosicionarFormMensagem;
var
  P: TPoint;
begin
  if Assigned(FCentralizarSobre) and FCentralizarSobre.Showing then
  begin
    P := FCentralizarSobre.ClientToScreen(Point(0, 0));
    FFormMsg.Position := poDesigned;
    FFormMsg.Left := P.X + (FCentralizarSobre.Width - FFormMsg.Width) div 2;
    FFormMsg.Top := P.Y + (FCentralizarSobre.Height - FFormMsg.Height) div 2;
  end
  else
    FFormMsg.Position := poScreenCenter;
end;

procedure TTEFEventos.Log(const ALinha: String);
begin
  if not Assigned(FOnLog) then
    Exit;

  if (GetCurrentThreadId = MainThreadID) then
    FOnLog(ALinha)
  else
  begin
    // Alguns GPs gravam log a partir de outra thread: guarda a linha e
    // atualiza a tela pela thread principal
    FLogLock.Enter;
    try
      FLogPendente.Add(ALinha);
    finally
      FLogLock.Leave;
    end;
  end;
end;

procedure TTEFEventos.DescarregarLogPendente(Sender: TObject);
var
  LLinhas: TStringList;
  I: Integer;
begin
  LLinhas := TStringList.Create;
  try
    FLogLock.Enter;
    try
      LLinhas.Assign(FLogPendente);
      FLogPendente.Clear;
    finally
      FLogLock.Leave;
    end;

    if Assigned(FOnLog) then
      for I := 0 to LLinhas.Count - 1 do
        FOnLog(LLinhas[I]);
  finally
    LLinhas.Free;
  end;
end;

procedure TTEFEventos.QuandoGravarLog(const ALogLine: String;
  var Tratado: Boolean);
begin
  Log(ALogLine);
  DetectarEstorno(ALogLine);
  Tratado := False;   // continua gravando no arquivo de log (ArqLOG)
end;

// ESTORNO: antes de cada estorno, o ACBrTEFAPI grava no log
//   "CancelarTransacao( <NSU>, <Autorização>, <Data/Hora>, <Valor>, ... )"
// (inclusive dentro do CancelarOuEstornarTransacoesDiretorioTrabalho).
// Pelo NSU achamos a transação e guardamos o VALOR dela, para preencher
// automaticamente o campo "VALOR DA VENDA" que alguns GPs (ex.: PayGo)
// perguntam durante o estorno (ver QuandoPerguntarCampo).
procedure TTEFEventos.DetectarEstorno(const ALogLine: String);
const
  CMarca = 'CancelarTransacao( ';
var
  p, i: Integer;
  LNSU: String;
begin
  p := Pos(CMarca, ALogLine);
  if (p = 0) then
    Exit;

  LNSU := Copy(ALogLine, p + Length(CMarca), MaxInt);
  p := Pos(',', LNSU);
  if (p > 0) then
    LNSU := Copy(LNSU, 1, p - 1);
  LNSU := Trim(LNSU);

  FValorEstorno := 0;
  if (LNSU = '') then
    Exit;

  for i := 0 to FTEF.RespostasTEF.Count - 1 do
    if (Trim(FTEF.RespostasTEF[i].NSU) = LNSU) and (FTEF.RespostasTEF[i].ValorTotal > 0) then
    begin
      FValorEstorno := FTEF.RespostasTEF[i].ValorTotal;
      Break;
    end;
end;

class procedure TTEFEventos.GerarImagemQRCode(const ADadosQRCode: String;
  APicture: TPicture);
var
  QRCode: TDelphiZXingQRCode;
  QRCodeBitmap: TBitmap;
  Row, Column: Integer;
begin
  if (ExtractFileName(ADadosQRCode) <> '') and FileExists(ADadosQRCode) then
  begin
    APicture.LoadFromFile(ADadosQRCode);   // alguns GPs mandam um arquivo
    Exit;
  end;

  QRCode := TDelphiZXingQRCode.Create;
  QRCodeBitmap := TBitmap.Create;
  try
    QRCode.Encoding := qrUTF8BOM;
    QRCode.QuietZone := 2;
    QRCode.Data := WideString(ADadosQRCode);

    QRCodeBitmap.Width := QRCode.Columns;
    QRCodeBitmap.Height := QRCode.Rows;
    for Row := 0 to QRCode.Rows - 1 do
      for Column := 0 to QRCode.Columns - 1 do
        if QRCode.IsBlack[Row, Column] then
          QRCodeBitmap.Canvas.Pixels[Column, Row] := clBlack
        else
          QRCodeBitmap.Canvas.Pixels[Column, Row] := clWhite;

    APicture.Bitmap.Assign(QRCodeBitmap);
  finally
    QRCode.Free;
    QRCodeBitmap.Free;
  end;
end;

procedure TTEFEventos.QuandoExibirMensagem(const Mensagem: String;
  Terminal: TACBrTEFAPITela; MilissegundosExibicao: Integer);
var
  LForm: TFormExibeMensagem;
begin
  if (Mensagem = '') then
  begin
    // Mensagem vazia = limpar a área indicada
    if (Terminal in [telaCliente, telaTodas]) then
      FLblCliente.Caption := '';
    if (Terminal in [telaOperador, telaTodas]) then
      FLblOperador.Caption := '';
    MostrarMensagem('', '');
  end
  else if (MilissegundosExibicao >= 0) then
  begin
    // Mensagem que exige OK (0) ou fica X milissegundos na tela
    LForm := TFormExibeMensagem.Create(nil);
    try
      LForm.Mensagem := Mensagem;
      LForm.TempoEspera := MilissegundosExibicao;
      LForm.ShowModal;
    finally
      LForm.Free;
    end;
  end
  else
  begin
    Log('QuandoExibirMensagem: ' + Mensagem);
    if (Terminal in [telaCliente, telaTodas]) then
      MostrarMensagem('', Mensagem);
    if (Terminal in [telaOperador, telaTodas]) then
      MostrarMensagem(Mensagem, '');
  end;
end;

procedure TTEFEventos.QuandoPerguntarMenu(const Titulo: String;
  Opcoes: TStringList; var ItemSelecionado: Integer);
var
  MR: TModalResult;
  LForm: TFormMenuTEF;
begin
  if (Opcoes.Count < 1) then
  begin
    ItemSelecionado := -1;
    Exit;
  end;

  LForm := TFormMenuTEF.Create(nil);
  try
    LForm.Titulo := Titulo;
    LForm.Opcoes := Opcoes;
    LForm.UsaTeclasDeAtalho := (Copy(Opcoes[0], 1, 4) = '1 - ');
    LForm.ItemSelecionado := ItemSelecionado;

    MR := LForm.ShowModal;
    case MR of
      mrOK:
        ItemSelecionado := LForm.ItemSelecionado;
      mrRetry:
        ItemSelecionado := -2;  // Voltar
    else
      ItemSelecionado := -1;    // Cancelar
    end;
  finally
    LForm.Free;
  end;
end;

procedure TTEFEventos.QuandoPerguntarCampo(
  DefinicaoCampo: TACBrTEFAPIDefinicaoCampo; var Resposta: String;
  var Validado: Boolean; var Cancelado: Boolean);
var
  MR: TModalResult;
  LForm: TFormObtemCampo;
begin
  { NOTA: se DefinicaoCampo.ValidacaoDado = valdSenhaLojista, o ideal é abrir a
    tela de senha do SEU sistema e devolver o NOME do operador (nunca a senha). }

  LForm := TFormObtemCampo.Create(nil);
  try
    LForm.Titulo := DefinicaoCampo.TituloPergunta;
    LForm.TamanhoMaximo := DefinicaoCampo.TamanhoMaximo;
    LForm.TamanhoMinimo := DefinicaoCampo.TamanhoMinimo;
    LForm.Resposta := DefinicaoCampo.ValorInicial;
    LForm.Ocultar := DefinicaoCampo.OcultarDadosDigitados;
    LForm.Mascara := DefinicaoCampo.MascaraDeCaptura;
    LForm.btVoltar.Visible := (FTEF.Modelo = tefApiCliSiTEF);

    if (Pos('R$', DefinicaoCampo.MascaraDeCaptura) > 0) or
       (Pos('@.@@@,@@', DefinicaoCampo.MascaraDeCaptura) > 0) or
       (Pos('@@@@@@,@@', DefinicaoCampo.MascaraDeCaptura) > 0) then
      LForm.TipoCampo := tcoCurrency
    else
    begin
      case DefinicaoCampo.TipoDeEntrada of
        tedApenasLeitura:
          LForm.edtResposta.ReadOnly := True;
        tedNumerico:
          if (Pos('@,@@', DefinicaoCampo.MascaraDeCaptura) > 0) then
            LForm.TipoCampo := tcoDecimal
          else
            LForm.TipoCampo := tcoNumeric;
        tedAlfabetico:
          LForm.TipoCampo := tcoAlfa;
        tedAlfaNum:
          LForm.TipoCampo := tcoAlfaNum;
      else
        LForm.TipoCampo := tcoString;
      end;
    end;

    // Estorno em andamento: o GP pede o valor da transação original.
    // Preenchemos com o valor DAQUELA transação (não o total da venda);
    // o operador só confere e confirma.
    if (FValorEstorno > 0) and (LForm.TipoCampo in [tcoCurrency, tcoDecimal]) and
       (Trim(DefinicaoCampo.ValorInicial) = '') then
    begin
      LForm.Resposta := IntToStr(Round(FValorEstorno * 100));   // em centavos
      Log('  Estorno: valor preenchido automaticamente: R$ ' +
        FormatFloat('#,##0.00', FValorEstorno));
    end;

    MR := LForm.ShowModal;

    Cancelado := (MR = mrCancel);
    Validado := False;  // deixa o ACBrTEFAPI validar "ValidacaoDado"

    if (MR = mrOK) then
      Resposta := LForm.Resposta
    else if (MR = mrRetry) then  // Voltar
      Resposta := ':-2'
    else if (MR = mrCancel) then // Cancelar
      Resposta := ':-1';
  finally
    LForm.Free;
  end;
end;

procedure TTEFEventos.QuandoEsperarOperacao(OperacaoAPI: TACBrTEFAPIOperacaoAPI;
  var Cancelar: Boolean);
begin
  if FCancelarPeloOperador then
  begin
    FCancelarPeloOperador := False;
    Cancelar := True;   // aborta o TEF em andamento
  end;
  Application.ProcessMessages;
end;

procedure TTEFEventos.QuandoExibirQRCode(const DadosQRCode: String);
var
  INI: TIniFile;
  LImprimir: Boolean;
begin
  INI := TIniFile.Create(FArqINI);
  try
    LImprimir := (INI.ReadInteger('TEF', 'QRCode', 1) = 4);  // 4 - Imprimir
  finally
    INI.Free;
  end;

  if (DadosQRCode <> '') then
    Log('QuandoExibirQRCode: ' + DadosQRCode)
  else
    Log('QuandoExibirQRCode: (ocultar)');

  if LImprimir then
  begin
    if (DadosQRCode <> '') then
      ImprimirRelatorio('</ce><qrcode_largura>8</qrcode_largura>' +
        '<qrcode>' + DadosQRCode + '</qrcode></lf></lf></lf></lf>');
    Exit;
  end;

  // Uma tela (ex.: uframePagamento) mostra o QR Code dentro dela
  if Assigned(FOnExibirQRCode) then
  begin
    FOnExibirQRCode(DadosQRCode);
    Exit;
  end;

  if (DadosQRCode = '') then
  begin
    EsconderQRCode;
    Exit;
  end;

  GerarImagemQRCode(DadosQRCode, FImgQRCode.Picture);
  FFormQRCode.Show;
  FFormQRCode.Update;
end;

procedure TTEFEventos.QuandoFinalizarOperacao(RespostaTEF: TACBrTEFResp);
var
  MsgFinal: String;
begin
  FimOperacao;
  FValorEstorno := 0;
  MsgFinal := RespostaTEF.TextoEspecialOperador;

  Log(Format('QuandoFinalizarOperacao: Sucesso=%s Aprovada=%s Rede=%s NSU=%s Valor=%s',
    [BoolToStr(RespostaTEF.Sucesso, True), BoolToStr(RespostaTEF.TransacaoAprovada, True),
     RespostaTEF.Rede, RespostaTEF.NSU, FormatFloat('0.00', RespostaTEF.ValorTotal)]));
  if (MsgFinal <> '') then
    Log('  ' + MsgFinal);

  if not RespostaTEF.Sucesso then
  begin
    if (Pos('PENDENTE', UpperCase(MsgFinal)) > 0) then
    begin
      if (FTEF.TratamentoTransacaoPendente = tefpenConfirmar) then
        MsgFinal := MsgFinal + sLineBreak + 'Transação será CONFIRMADA'
      else if (FTEF.TratamentoTransacaoPendente = tefpenEstornar) then
        MsgFinal := MsgFinal + sLineBreak + 'Transação será ESTORNADA'
      else
        MsgFinal := '';  // tratado em QuandoDetectarTransacaoPendente
    end;

    if (MsgFinal <> '') then
      MessageDlg(MsgFinal, mtError, [mbOK], 0);
  end
  else
  begin
    // Pagamento (CRT): confirmação e comprovantes ficam para DEPOIS da NFC-e
    // (feito no PDV). Demais operações (ADM, cancelamento) já confirmam e imprimem.
    if (RespostaTEF.Header <> CHEADER_PAGAMENTO) then
    begin
      if (not FTEF.ConfirmarTransacaoAutomaticamente) and RespostaTEF.Confirmar then
        FTEF.FinalizarTransacao(tefstsSucessoAutomatico);
      ImprimirComprovantes(RespostaTEF);
    end;

    if (MsgFinal <> '') then
      MessageDlg(MsgFinal, mtInformation, [mbOK], 0);
  end;
end;

procedure TTEFEventos.QuandoDetectarTransacaoPendente(RespostaTEF: TACBrTEFResp;
  const MsgErro: String);
var
  AStatus: TACBrTEFStatusTransacao;
  LForm: TFormMenuTEF;
  i: Integer;
  ATEFResp: TACBrTEFResp;
begin
  FimOperacao;
  AStatus := tefstsErroDiverso;

  LForm := TFormMenuTEF.Create(nil);
  try
    if (MsgErro <> '') then
      LForm.Titulo := 'Transação Pendente - ' + MsgErro
    else
      LForm.Titulo := 'Transação Pendente - ' + RespostaTEF.TextoEspecialOperador;
    LForm.Opcoes.Add('1 - Confirmação Manual');
    LForm.Opcoes.Add('2 - Estorno Manual');
    LForm.Opcoes.Add('3 - Estorno, Falta de Energia');
    LForm.Opcoes.Add('4 - Estorno, Erro na Impressão');
    LForm.Opcoes.Add('5 - Estorno, Erro no Dispensador');
    LForm.UsaTeclasDeAtalho := True;
    LForm.ItemSelecionado := 0;
    LForm.btVoltar.Visible := False;

    if (LForm.ShowModal = mrOK) then
    begin
      case LForm.ItemSelecionado of
        0: AStatus := tefstsSucessoManual;
        1: AStatus := tefstsErroDiverso;
        2: AStatus := tefstsErroEnergia;
        3: AStatus := tefstsErroImpressao;
        4: AStatus := tefstsErroDispesador;
      else
        AStatus := tefstsSucessoManual;
      end;
      FTEF.ResolverTransacaoPendente(AStatus);
    end;
  finally
    LForm.Free;
  end;

  // Se confirmou, reimprime o comprovante da transação que ficou pendente
  if (AStatus in [tefstsSucessoAutomatico, tefstsSucessoManual]) then
  begin
    i := FTEF.RespostasTEF.AcharTransacao(RespostaTEF.Rede, RespostaTEF.NSU,
      RespostaTEF.Finalizacao);
    if (i >= 0) then
      ATEFResp := FTEF.RespostasTEF[i]
    else
      ATEFResp := RespostaTEF;
    ImprimirComprovantes(ATEFResp);
  end;
end;

procedure TTEFEventos.ImprimirComprovantes(ATEFResp: TACBrTEFResp);
var
  INI: TIniFile;
  LViaCliente: Integer;
  LImprimeCliente: Boolean;
begin
  if not Assigned(ATEFResp) then
    Exit;

  INI := TIniFile.Create(FArqINI);
  try
    // 0-Sempre, 1-Perguntar, 2-Nunca (cbxImpressaoViaCliente)
    LViaCliente := INI.ReadInteger('TEF', 'ImpressaoViaCliente', 0);
  finally
    INI.Free;
  end;

  // Via do estabelecimento (2ª via)
  if (ATEFResp.ImagemComprovante2aVia.Count > 0) then
    ImprimirRelatorio(ATEFResp.ImagemComprovante2aVia.Text);

  // Via do cliente (1ª via)
  if (ATEFResp.ImagemComprovante1aVia.Count > 0) then
  begin
    case LViaCliente of
      0: LImprimeCliente := True;
      1: LImprimeCliente := MessageDlg('Imprimir Via do Cliente ?',
           mtConfirmation, [mbYes, mbNo], 0) = mrYes;
    else
      LImprimeCliente := False;
    end;
    if LImprimeCliente then
      ImprimirRelatorio(ATEFResp.ImagemComprovante1aVia.Text);
  end;
end;

procedure TTEFEventos.ImprimirRelatorio(const ATexto: String);
var
  INI: TIniFile;
  LImpressora: Boolean;
  LArquivo: String;
begin
  INI := TIniFile.Create(FArqINI);
  try
    LImpressora := INI.ReadBool('Impressora', 'Saida', True);
    LArquivo := INI.ReadString('Impressora', 'ArquivoSaida', '');
  finally
    INI.Free;
  end;

  if LImpressora then
  begin
    if not FPosPrinter.Ativo then
      FPosPrinter.Ativar;
    FPosPrinter.Imprimir('</zera>' + ATexto + '</lf></corte_total>');
  end
  else
  begin
    if LArquivo = '' then
      LArquivo := ChangeFileExt(Application.ExeName, '_impressao.txt');
    WriteToTXT(LArquivo, ATexto + sLineBreak + sLineBreak);
  end;
end;

initialization

finalization
  FreeAndNil(GTEFEventos);

end.
