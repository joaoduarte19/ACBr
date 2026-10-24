unit uframeconfigTEF;

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  Spin, Buttons, ExtCtrls, Grids, FileCtrl, ImgList,
  uframerodapeSalvar, ACBrPosPrinter, ACBrTEFComum, ACBrTEFAPI,
  ACBrBase, ACBrTEFAPIComum, IniFiles;

type

  { TframeConfigTEF }

  TframeConfigTEF = class(TFrame)
    btProcuraImpressoras: TSpeedButton;
    btSerial: TSpeedButton;
    btTestarPosPrinter: TBitBtn;
    btMenuAdministrativo: TBitBtn;
    cbAutoAtendimento: TCheckBox;
    cbGravarLogTEF: TCheckBox;
    cbImprimirViaReduzida: TCheckBox;
    cbConfirmarAutomaticamente: TCheckBox;
    cbSuportaDesconto: TCheckBox;
    cbSuportaSaque: TCheckBox;
    cbxAmbiente: TComboBox;
    cbxGP: TComboBox;
    cbxGPTXT: TComboBox;
    cbxIdioma: TComboBox;
    cbxImpressaoViaCliente: TComboBox;
    cbxModeloPosPrinter: TComboBox;
    cbxMoeda: TComboBox;
    cbxPagCodigo: TComboBox;
    cbxPorta: TComboBox;
    cbxQRCode: TComboBox;
    cbxTransacaoPendente: TComboBox;
    cbxTransacaoPendenteInicializacao: TComboBox;
    edArqReq: TEdit;
    edArqResp: TEdit;
    edArqSts: TEdit;
    edArquivoImpressao: TEdit;
    edCNPJEstabelecimento: TEdit;
    edCNPJSwHouse: TEdit;
    edCodEmpresa: TEdit;
    edCodFilial: TEdit;
    edCodTerminal: TEdit;
    edDirReq: TEdit;
    edDirResp: TEdit;
    edEnderecoServidor: TEdit;
    edLog: TEdit;
    edMsgPinPad: TEdit;
    edNomeAplicacao: TEdit;
    edParamAplic: TEdit;
    edParamComunic: TEdit;
    edPortaPinPad: TEdit;
    edRazaoSocialEstabelecimento: TEdit;
    edRazaoSocialSwHouse: TEdit;
    edVersaoAplicacao: TEdit;
    frameRodape1: TframeRodape;
    gbConfigImpressora: TGroupBox;
    gbConfigTEF: TGroupBox;
    gbDadosEstabComercial: TGroupBox;
    gbDadosSwHouseAplicacao: TGroupBox;
    gbDadosTEFTXT: TGroupBox;
    gbDadosTerminal: TGroupBox;
    gbSaidaImpressao: TGroupBox;
    ImageList1: TImageList;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    pBotaoConfig: TPanel;
    pConfigImpSwHouseEstab: TPanel;
    pConfigTEF: TPanel;
    pConfiguracao: TPanel;
    pgConfiguracao: TPageControl;
    pnpRodape: TPanel;
    rbArquivo: TRadioButton;
    rbImpressora: TRadioButton;
    SbArqLog: TSpeedButton;
    sbDirReq: TSpeedButton;
    sbDirResp: TSpeedButton;
    seColunas: TSpinEdit;
    seEspLinhas: TSpinEdit;
    seLinhasPular: TSpinEdit;
    seNivelLogTXT: TSpinEdit;
    tsConfImpressora: TTabSheet;
    tsConfTEF: TTabSheet;
    procedure btnSalvarClick(Sender: TObject);
    // Eventos ligados no .dfm (precisam ficar na secao published)
    procedure cbxGPChange(Sender: TObject);
    procedure rbImpressoraChange(Sender: TObject);
    procedure sbDirReqClick(Sender: TObject);
    procedure sbDirRespClick(Sender: TObject);
    procedure SbArqLogClick(Sender: TObject);
    procedure btProcuraImpressorasClick(Sender: TObject);
    procedure btSerialClick(Sender: TObject);
    procedure btTestarPosPrinterClick(Sender: TObject);
    procedure btTestarTEFClick(Sender: TObject);
    procedure btMenuAdministrativoClick(Sender: TObject);
  private
    FOnFechar: TNotifyEvent;
    FParamsStringPosPrinter: String;   // parametros da serial (btSerial)

    function GetNomeArquivoConfiguracao: String;
    function GetNomeArquivoLog: String;
    procedure CarregarCombos;
    procedure AdicionarPortasFixas;
  public
    constructor Create(AOwner: TComponent); override;

    procedure LerConfiguracao;
    procedure GravarConfiguracao;

    // Aplica o que esta na tela nos componentes do frmPrincipal
    procedure ConfigurarTEF;
    procedure ConfigurarPosPrinter;
    procedure Configurar;

    property NomeArquivoConfiguracao: String read GetNomeArquivoConfiguracao;
    property OnFechar: TNotifyEvent read FOnFechar write FOnFechar;
  end;

implementation

uses
  TypInfo, Windows, ShellAPI,
  ACBrUtil.Strings,
  ACBrTEFAPITXT,
  uPrincipal, Frm_ConfiguraSerial, uTEFUtils;

{$R *.dfm}

{ TframeConfigTEF }

constructor TframeConfigTEF.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  CarregarCombos;
  // A busca de portas (COM1..COMn, USB, impressoras do Windows) e lenta:
  // fica so no botao btProcuraImpressoras. Aqui, apenas as portas fixas.
  cbxPorta.Items.Clear;
  AdicionarPortasFixas;
  pgConfiguracao.ActivePageIndex := 0;

  LerConfiguracao;
end;

procedure TframeConfigTEF.CarregarCombos;
var
  M: TACBrTEFAPITipo;
  N: TACBrPosPrinterModelo;
  O: TACBrPosPaginaCodigo;
  Q: TACBrTEFTXTModelo;
begin
  // Gerenciadores (TACBrTEFAPITipo): tefApiNenhum, tefApiPayGoWeb, ...
  cbxGP.Items.Clear;
  for M := Low(TACBrTEFAPITipo) to High(TACBrTEFAPITipo) do
    cbxGP.Items.Add(GetEnumName(TypeInfo(TACBrTEFAPITipo), Integer(M)));
  cbxGP.ItemIndex := 0;

  cbxGPTXT.Items.Clear;
  for Q := Low(TACBrTEFTXTModelo) to High(TACBrTEFTXTModelo) do
    cbxGPTXT.Items.Add(GetEnumName(TypeInfo(TACBrTEFTXTModelo), Integer(Q)));
  cbxGPTXT.ItemIndex := 0;

  cbxModeloPosPrinter.Items.Clear;
  for N := Low(TACBrPosPrinterModelo) to High(TACBrPosPrinterModelo) do
    cbxModeloPosPrinter.Items.Add(GetEnumName(TypeInfo(TACBrPosPrinterModelo), Integer(N)));

  cbxPagCodigo.Items.Clear;
  for O := Low(TACBrPosPaginaCodigo) to High(TACBrPosPaginaCodigo) do
    cbxPagCodigo.Items.Add(GetEnumName(TypeInfo(TACBrPosPaginaCodigo), Integer(O)));

  // cbxAmbiente, cbxIdioma, cbxMoeda e cbxQRCode ja vem preenchidos no .dfm
  // (mesma ordem dos enumerados TACBrTEFAPIAmbiente / TACBrTEFAPIIdioma)
end;

function TframeConfigTEF.GetNomeArquivoConfiguracao: String;
begin
  Result := ChangeFileExt(Application.ExeName, '.ini');
end;

procedure TframeConfigTEF.LerConfiguracao;
var
  INI: TIniFile;
begin
  INI := TIniFile.Create(NomeArquivoConfiguracao);
  try
    cbxGP.ItemIndex := INI.ReadInteger('TEF', 'GP', 0);
    cbxGPChange(nil);
    cbxQRCode.ItemIndex := INI.ReadInteger('TEF', 'QRCode', 1);
    edLog.Text := INI.ReadString('TEF', 'Log', '');
    cbxImpressaoViaCliente.ItemIndex := INI.ReadInteger('TEF', 'ImpressaoViaCliente', 0);
    cbxTransacaoPendente.ItemIndex := INI.ReadInteger('TEF', 'TransacaoPendente', 0);
    cbxTransacaoPendenteInicializacao.ItemIndex :=
      INI.ReadInteger('TEF', 'TransacaoPendenteInicializacao', 1);
    cbAutoAtendimento.Checked := INI.ReadBool('TEF', 'AutoAtendimento', False);
    cbImprimirViaReduzida.Checked := INI.ReadBool('TEF', 'ImprimirViaReduzida', False);
    cbConfirmarAutomaticamente.Checked := INI.ReadBool('TEF', 'ConfirmarAutomaticamente', True);
    cbSuportaDesconto.Checked := INI.ReadBool('TEF', 'SuportaDesconto', True);
    cbSuportaSaque.Checked := INI.ReadBool('TEF', 'SuportaSaque', True);

    cbxGPTXT.ItemIndex := INI.ReadInteger('TXT', 'GP', 0);
    edDirReq.Text := INI.ReadString('TXT', 'DirReq', edDirReq.Text);
    edDirResp.Text := INI.ReadString('TXT', 'DirResp', edDirResp.Text);
    edArqReq.Text := INI.ReadString('TXT', 'ArqReq', edArqReq.Text);
    edArqSts.Text := INI.ReadString('TXT', 'ArqSts', edArqSts.Text);
    edArqResp.Text := INI.ReadString('TXT', 'ArqResp', edArqResp.Text);
    seNivelLogTXT.Value := INI.ReadInteger('TXT', 'NivelLog', seNivelLogTXT.Value);

    edRazaoSocialSwHouse.Text := INI.ReadString('SwHouse', 'RazaoSocial', edRazaoSocialSwHouse.Text);
    edCNPJSwHouse.Text := INI.ReadString('SwHouse', 'CNPJ', edCNPJSwHouse.Text);
    edNomeAplicacao.Text := INI.ReadString('Aplicacao', 'Nome', edNomeAplicacao.Text);
    edVersaoAplicacao.Text := INI.ReadString('Aplicacao', 'Versao', edVersaoAplicacao.Text);
    edMsgPinPad.Text := INI.ReadString('Aplicacao', 'MsgPinPad', edMsgPinPad.Text);
    cbxIdioma.ItemIndex := INI.ReadInteger('Aplicacao', 'Idioma', 0);
    cbxMoeda.ItemIndex := INI.ReadInteger('Aplicacao', 'Moeda', 0);
    edParamAplic.Text := INI.ReadString('Aplicacao', 'Parametros', edParamAplic.Text);

    edRazaoSocialEstabelecimento.Text := INI.ReadString('Estabelecimento', 'RazaoSocial', edRazaoSocialEstabelecimento.Text);
    edCNPJEstabelecimento.Text := INI.ReadString('Estabelecimento', 'CNPJ', edCNPJEstabelecimento.Text);

    edCodTerminal.Text := INI.ReadString('Terminal', 'CodTerminal', edCodTerminal.Text);
    edCodEmpresa.Text := INI.ReadString('Terminal', 'CodEmpresa', edCodEmpresa.Text);
    edCodFilial.Text := INI.ReadString('Terminal', 'CodFilial', edCodFilial.Text);
    edPortaPinPad.Text := INI.ReadString('Terminal', 'PortaPinPad', edPortaPinPad.Text);
    edEnderecoServidor.Text := INI.ReadString('Terminal', 'EnderecoServidor', edEnderecoServidor.Text);
    cbxAmbiente.ItemIndex := INI.ReadInteger('Terminal', 'Ambiente', cbxAmbiente.ItemIndex);
    edParamComunic.Text := INI.ReadString('Terminal', 'ParamComunic', edParamComunic.Text);
    cbGravarLogTEF.Checked := INI.ReadBool('Terminal', 'GravarLogTEF', cbGravarLogTEF.Checked);

    rbImpressora.Checked := INI.ReadBool('Impressora', 'Saida', rbImpressora.Checked);
    rbArquivo.Checked := not rbImpressora.Checked;
    edArquivoImpressao.Text := INI.ReadString('Impressora', 'ArquivoSaida', edArquivoImpressao.Text);

    cbxModeloPosPrinter.ItemIndex := INI.ReadInteger('PosPrinter', 'Modelo', 1);
    cbxPorta.Text := INI.ReadString('PosPrinter', 'Porta', frmPrincipal.ACBrPosPrinter1.Porta);
    cbxPagCodigo.ItemIndex := INI.ReadInteger('PosPrinter', 'PaginaDeCodigo', 2);
    FParamsStringPosPrinter := INI.ReadString('PosPrinter', 'ParamsString', '');
    seColunas.Value := INI.ReadInteger('PosPrinter', 'Colunas', 40);
    seEspLinhas.Value := INI.ReadInteger('PosPrinter', 'EspacoLinhas', frmPrincipal.ACBrPosPrinter1.EspacoEntreLinhas);
    seLinhasPular.Value := INI.ReadInteger('PosPrinter', 'LinhasEntreCupons', frmPrincipal.ACBrPosPrinter1.LinhasEntreCupons);

    rbImpressoraChange(nil);
  finally
    INI.Free;
  end;
end;

procedure TframeConfigTEF.GravarConfiguracao;
var
  INI: TIniFile;
begin
  INI := TIniFile.Create(NomeArquivoConfiguracao);
  try
    INI.WriteInteger('TEF', 'GP', cbxGP.ItemIndex);
    INI.WriteInteger('TEF', 'QRCode', cbxQRCode.ItemIndex);
    INI.WriteString('TEF', 'Log', edLog.Text);
    INI.WriteInteger('TEF', 'ImpressaoViaCliente', cbxImpressaoViaCliente.ItemIndex);
    INI.WriteInteger('TEF', 'TransacaoPendente', cbxTransacaoPendente.ItemIndex);
    INI.WriteInteger('TEF', 'TransacaoPendenteInicializacao', cbxTransacaoPendenteInicializacao.ItemIndex);
    INI.WriteBool('TEF', 'AutoAtendimento', cbAutoAtendimento.Checked);
    INI.WriteBool('TEF', 'ImprimirViaReduzida', cbImprimirViaReduzida.Checked);
    INI.WriteBool('TEF', 'ConfirmarAutomaticamente', cbConfirmarAutomaticamente.Checked);
    INI.WriteBool('TEF', 'SuportaDesconto', cbSuportaDesconto.Checked);
    INI.WriteBool('TEF', 'SuportaSaque', cbSuportaSaque.Checked);

    INI.WriteInteger('TXT', 'GP', cbxGPTXT.ItemIndex);
    INI.WriteString('TXT', 'DirReq', edDirReq.Text);
    INI.WriteString('TXT', 'DirResp', edDirResp.Text);
    INI.WriteString('TXT', 'ArqReq', edArqReq.Text);
    INI.WriteString('TXT', 'ArqSts', edArqSts.Text);
    INI.WriteString('TXT', 'ArqResp', edArqResp.Text);
    INI.WriteInteger('TXT', 'NivelLog', seNivelLogTXT.Value);

    INI.WriteString('SwHouse', 'RazaoSocial', edRazaoSocialSwHouse.Text);
    INI.WriteString('SwHouse', 'CNPJ', edCNPJSwHouse.Text);
    INI.WriteString('Aplicacao', 'Nome', edNomeAplicacao.Text);
    INI.WriteString('Aplicacao', 'Versao', edVersaoAplicacao.Text);
    INI.WriteString('Aplicacao', 'MsgPinPad', edMsgPinPad.Text);
    INI.WriteInteger('Aplicacao', 'Idioma', cbxIdioma.ItemIndex);
    INI.WriteInteger('Aplicacao', 'Moeda', cbxMoeda.ItemIndex);
    INI.WriteString('Aplicacao', 'Parametros', edParamAplic.Text);

    INI.WriteString('Estabelecimento', 'RazaoSocial', edRazaoSocialEstabelecimento.Text);
    INI.WriteString('Estabelecimento', 'CNPJ', edCNPJEstabelecimento.Text);

    INI.WriteString('Terminal', 'CodTerminal', edCodTerminal.Text);
    INI.WriteString('Terminal', 'CodEmpresa', edCodEmpresa.Text);
    INI.WriteString('Terminal', 'CodFilial', edCodFilial.Text);
    INI.WriteString('Terminal', 'PortaPinPad', edPortaPinPad.Text);
    INI.WriteString('Terminal', 'EnderecoServidor', edEnderecoServidor.Text);
    INI.WriteInteger('Terminal', 'Ambiente', cbxAmbiente.ItemIndex);
    INI.WriteString('Terminal', 'ParamComunic', edParamComunic.Text);
    INI.WriteBool('Terminal', 'GravarLogTEF', cbGravarLogTEF.Checked);

    INI.WriteBool('Impressora', 'Saida', rbImpressora.Checked);
    INI.WriteString('Impressora', 'ArquivoSaida', edArquivoImpressao.Text);

    INI.WriteInteger('PosPrinter', 'Modelo', cbxModeloPosPrinter.ItemIndex);
    INI.WriteString('PosPrinter', 'Porta', cbxPorta.Text);
    INI.WriteInteger('PosPrinter', 'PaginaDeCodigo', cbxPagCodigo.ItemIndex);
    INI.WriteString('PosPrinter', 'ParamsString', FParamsStringPosPrinter);
    INI.WriteInteger('PosPrinter', 'Colunas', seColunas.Value);
    INI.WriteInteger('PosPrinter', 'EspacoLinhas', seEspLinhas.Value);
    INI.WriteInteger('PosPrinter', 'LinhasEntreCupons', seLinhasPular.Value);
  finally
    INI.Free;
  end;
end;

procedure TframeConfigTEF.cbxGPChange(Sender: TObject);
begin
  gbDadosTEFTXT.Enabled := (cbxGP.ItemIndex = Integer(tefTXT));
end;

procedure TframeConfigTEF.rbImpressoraChange(Sender: TObject);
begin
  gbConfigImpressora.Enabled := rbImpressora.Checked;
  edArquivoImpressao.Enabled := rbArquivo.Checked;
end;

procedure TframeConfigTEF.sbDirReqClick(Sender: TObject);
var
  lDir: String;
begin
  lDir := edDirReq.Text;
  if SelectDirectory(lDir, [], 0) then
    edDirReq.Text := lDir;
end;

procedure TframeConfigTEF.sbDirRespClick(Sender: TObject);
var
  lDir: String;
begin
  lDir := edDirResp.Text;
  if SelectDirectory(lDir, [], 0) then
    edDirResp.Text := lDir;
end;

procedure TframeConfigTEF.AdicionarPortasFixas;
begin
  cbxPorta.Items.Add('TCP:192.168.0.31:9100');

  {$IfNDef MSWINDOWS}
  cbxPorta.Items.Add('/dev/ttyS0');
  cbxPorta.Items.Add('/dev/ttyUSB0');
  cbxPorta.Items.Add('/tmp/ecf.txt');
  {$Else}
  cbxPorta.Items.Add('\\localhost\Epson');
  cbxPorta.Items.Add('c:\temp\ecf.txt');
  {$EndIf}
end;

procedure TframeConfigTEF.btProcuraImpressorasClick(Sender: TObject);
var
  LPortaAtual: String;
begin
  LPortaAtual := cbxPorta.Text;
  Screen.Cursor := crHourGlass;
  cbxPorta.Items.BeginUpdate;
  try
    cbxPorta.Items.Clear;
    frmPrincipal.ACBrPosPrinter1.Device.AcharPortasSeriais(cbxPorta.Items, 20);
    {$IfDef MSWINDOWS}
    frmPrincipal.ACBrPosPrinter1.Device.AcharPortasUSB(cbxPorta.Items);
    {$EndIf}
    frmPrincipal.ACBrPosPrinter1.Device.AcharPortasRAW(cbxPorta.Items);
    AdicionarPortasFixas;
  finally
    cbxPorta.Items.EndUpdate;
    Screen.Cursor := crDefault;
  end;
  cbxPorta.Text := LPortaAtual;
  cbxPorta.DroppedDown := True;
end;

procedure TframeConfigTEF.btnSalvarClick(Sender: TObject);
begin
  GravarConfiguracao;
  Configurar;
  if Assigned(FOnFechar) then
    FOnFechar(Self);
end;

function TframeConfigTEF.GetNomeArquivoLog: String;
var
  LArquivo, LPath: String;
begin
  // edLog pode ter so o nome (grava na pasta do exe) ou o caminho completo
  Result := '';
  LArquivo := ExtractFileName(Trim(edLog.Text));
  if LArquivo = '' then
    Exit;

  LPath := ExtractFilePath(Trim(edLog.Text));
  if LPath = '' then
    LPath := ExtractFilePath(Application.ExeName);
  if ExtractFileExt(LArquivo) = '' then
    LArquivo := LArquivo + '.txt';

  Result := IncludeTrailingPathDelimiter(LPath) + LArquivo;
end;

procedure TframeConfigTEF.Configurar;
begin
  ConfigurarPosPrinter;
  ConfigurarTEF;
end;

procedure TframeConfigTEF.ConfigurarPosPrinter;
begin
  with frmPrincipal.ACBrPosPrinter1 do
  begin
    Desativar;
    Modelo := TACBrPosPrinterModelo(cbxModeloPosPrinter.ItemIndex);
    PaginaDeCodigo := TACBrPosPaginaCodigo(cbxPagCodigo.ItemIndex);
    Porta := cbxPorta.Text;
    Device.ParamsString := FParamsStringPosPrinter;
    ColunasFonteNormal := seColunas.Value;
    LinhasEntreCupons := seLinhasPular.Value;
    EspacoEntreLinhas := seEspLinhas.Value;
  end;
end;

procedure TframeConfigTEF.ConfigurarTEF;
begin
  // A configuracao do componente sai SEMPRE do INI (unit uTEFUtils), a mesma
  // rotina usada pela tela de pagamento. Por isso, grave antes de chamar.
  ConfigurarTEFPeloINI(frmPrincipal.ACBrTEFAPI1, frmPrincipal.ACBrPosPrinter1,
    NomeArquivoConfiguracao);
end;

procedure TframeConfigTEF.SbArqLogClick(Sender: TObject);
var
  LArquivo: String;
begin
  LArquivo := GetNomeArquivoLog;
  if (LArquivo = '') or (not FileExists(LArquivo)) then
  begin
    ShowMessage('Arquivo de log nao encontrado: ' + LArquivo);
    Exit;
  end;
  ShellExecute(0, 'open', PChar(LArquivo), nil, nil, SW_SHOWNORMAL);
end;

procedure TframeConfigTEF.btSerialClick(Sender: TObject);
var
  LFrm: TfrmConfiguraSerial;
begin
  LFrm := TfrmConfiguraSerial.Create(Self);
  try
    LFrm.Device.Porta := cbxPorta.Text;
    LFrm.cmbPortaSerial.Text := cbxPorta.Text;
    LFrm.Device.ParamsString := FParamsStringPosPrinter;

    if LFrm.ShowModal = mrOk then
    begin
      cbxPorta.Text := LFrm.cmbPortaSerial.Text;
      FParamsStringPosPrinter := LFrm.Device.ParamsString;
    end;
  finally
    LFrm.Free;
  end;
end;

procedure TframeConfigTEF.btTestarPosPrinterClick(Sender: TObject);
const
  CREGUA = '....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8';
var
  SL: TStringList;
  LPos: TACBrPosPrinter;
begin
  LPos := frmPrincipal.ACBrPosPrinter1;
  try
    ConfigurarPosPrinter;
    if LPos.Porta = '' then
      raise Exception.Create('Porta nao definida');
    LPos.Ativar;

    SL := TStringList.Create;
    try
      SL.Add('</zera>');
      SL.Add('</linha_dupla>');
      SL.Add('FONTE NORMAL: ' + IntToStr(LPos.ColunasFonteNormal) + ' Colunas');
      SL.Add(Copy(CREGUA, 1, LPos.ColunasFonteNormal));
      SL.Add('<e>EXPANDIDO: ' + IntToStr(LPos.ColunasFonteExpandida) + ' Colunas');
      SL.Add(Copy(CREGUA, 1, LPos.ColunasFonteExpandida));
      SL.Add('</e><c>CONDENSADO: ' + IntToStr(LPos.ColunasFonteCondensada) + ' Colunas');
      SL.Add(Copy(CREGUA, 1, LPos.ColunasFonteCondensada));
      SL.Add('</c><n>FONTE NEGRITO</N>');
      SL.Add('<in>FONTE INVERTIDA</in>');
      SL.Add('<S>FONTE SUBLINHADA</s>');
      SL.Add('<i>FONTE ITALICO</i>');
      SL.Add('FONTE NORMAL');
      SL.Add('');
      SL.Add('TESTE DE ACENTOS. ÁÉÍÓÚáéíóú');
      SL.Add('');
      SL.Add('</corte_total>');

      LPos.Imprimir(SL.Text);
    finally
      SL.Free;
    end;
  except
    on E: Exception do
      MessageDlg('Falha ao ativar a Impressora' + sLineBreak + E.Message,
        mtError, [mbOK], 0);
  end;
end;

procedure TframeConfigTEF.btTestarTEFClick(Sender: TObject);
var
  NomeTEF: String;
  LTEF: TACBrTEFAPI;
begin
  LTEF := frmPrincipal.ACBrTEFAPI1;
  NomeTEF := GetEnumName(TypeInfo(TACBrTEFAPITipo), cbxGP.ItemIndex);

  if cbxGP.ItemIndex <= 0 then
  begin
    ShowMessage('Selecione o gerenciador (GP) de TEF.');
    Exit;
  end;

  GravarConfiguracao;
  try
    ConfigurarTEF;
    LTEF.Inicializar;
    LTEF.EfetuarAdministrativa(tefopTesteComunicacao);

    if LTEF.UltimaRespostaTEF.Sucesso then
      MessageDlg(Format('TEF %s ATIVO', [NomeTEF]), mtInformation, [mbOK], 0)
    else if (LTEF.UltimaRespostaTEF.TextoEspecialOperador <> '') then
      MessageDlg(LTEF.UltimaRespostaTEF.TextoEspecialOperador, mtError, [mbOK], 0)
    else
      MessageDlg(Format('TEF %s nao respondeu com sucesso.', [NomeTEF]),
        mtWarning, [mbOK], 0);
  except
    on E: Exception do
      MessageDlg(Format('Falha ao ativar TEF %s' + sLineBreak + E.Message, [NomeTEF]),
        mtError, [mbOK], 0);
  end;
end;

// Menu Administrativo do gerenciador (GP): reimpressão, cancelamento,
// relatórios, configurações do PinPad... As opções dependem de cada GP.
// Igual ao btAdministrativoClick do exemplo ACBr\Exemplos\ACBrTEFD\TEFAPI.
// Resultado e comprovantes: TTEFEventos.QuandoFinalizarOperacao (uTEFUtils).
procedure TframeConfigTEF.btMenuAdministrativoClick(Sender: TObject);
var
  LTEF: TACBrTEFAPI;
begin
  LTEF := frmPrincipal.ACBrTEFAPI1;

  if cbxGP.ItemIndex <= 0 then
  begin
    ShowMessage('Selecione o gerenciador (GP) de TEF.');
    Exit;
  end;

  GravarConfiguracao;
  try
    ConfigurarTEF;
    if not LTEF.Inicializado then
      LTEF.Inicializar;

    // Igual ao IniciarOperacao do exemplo TEFAPI:
    // limpa respostas TEF anteriores e apaga arquivos de backup
    LTEF.LimparRespostasTEF;

    LTEF.EfetuarAdministrativa(tefopAdministrativo);
  except
    on E: Exception do
      MessageDlg('Falha no Menu Administrativo do TEF:' + sLineBreak + E.Message,
        mtError, [mbOK], 0);
  end;
end;

end.
