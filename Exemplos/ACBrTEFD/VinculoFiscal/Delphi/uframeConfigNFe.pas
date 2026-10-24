unit uframeConfigNFe;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ExtCtrls,
  StdCtrls,
  Spin,
  Buttons,
  ComCtrls,
  ACBrMail,
  ACBrPosPrinter,
  ACBrNFeDANFeESCPOS,
  ACBrNFeDANFEClass,
  ACBrDANFCeFortesFr,
  ACBrDFeReport,
  ACBrDFeDANFeReport,
  ACBrNFeDANFeRLClass,
  ACBrBase,
  ACBrDFe,
  ACBrNFe,
  ACBrDANFCeFortesFrA4,
  Types,
  IniFiles,
  TypInfo,
  ACBrDFeSSL,
  pcnConversao,
  ACBrUtil,
  ACBrUtil.Strings,
  Frm_SelecionarCertificado, uframerodapeSalvar, uPrincipal;//, uframeRodape;

type

  { TframeConfigNfe }

  TframeConfigNfe = class(TFrame)
    btnCNPJ: TButton;
    btnDataValidade: TButton;
    btnHTTPS: TButton;
    btnIssuerName: TButton;
    btnLeituraX509: TButton;
    btnNumSerie: TButton;
    btnSha256: TButton;
    btnSubName: TButton;
    btSerial: TBitBtn;
    btVersao: TButton;
    cbAssinar: TCheckBox;
    cbCortarPapel: TCheckBox;
    cbCryptLib: TComboBox;
    cbFormaEmissao: TComboBox;
    cbHttpLib: TComboBox;
    cbModeloDF: TComboBox;
    cbSSLLib: TComboBox;
    cbSSLType: TComboBox;
    cbTipoEmpresa: TComboBox;
    cbUF: TComboBox;
    cbVersaoDF: TComboBox;
    cbVersaoQRCode: TComboBox;
    cbxAdicionaLiteral: TCheckBox;
    cbxAjustarAut: TCheckBox;
    cbxAtualizarXML: TCheckBox;
    cbxEmissaoPathNFe: TCheckBox;
    cbxExibirErroSchema: TCheckBox;
    cbXmlSignLib: TComboBox;
    cbxModeloPosPrinter: TComboBox;
    cbxPagCodigo: TComboBox;
    cbxPastaMensal: TCheckBox;
    cbxPorta: TComboBox;
    btProcuraPortas: TButton;
    cbxRetirarAcentos: TCheckBox;
    cbxSalvaPathEvento: TCheckBox;
    cbxSalvarArqs: TCheckBox;
    cbxSalvarSOAP: TCheckBox;
    cbxSepararPorCNPJ: TCheckBox;
    cbxSepararPorModelo: TCheckBox;
    cbxVisualizar: TCheckBox;
    ckSalvar: TCheckBox;
    Edit1: TEdit;
    edtAguardar: TEdit;
    edtCaminho: TEdit;
    edtCSRT: TEdit;
    edtEmitBairro: TEdit;
    edtEmitCEP: TEdit;
    edtEmitCidade: TEdit;
    edtEmitCNPJ: TEdit;
    edtEmitCodCidade: TEdit;
    edtEmitComp: TEdit;
    edtEmitFantasia: TEdit;
    edtEmitFone: TEdit;
    edtEmitIE: TEdit;
    edtEmitLogradouro: TEdit;
    edtEmitNumero: TEdit;
    edtEmitRazao: TEdit;
    edtEmitUF: TEdit;
    edtFormatoAlerta: TEdit;
    edtIdCSRT: TEdit;
    edtIdToken: TEdit;
    edtIntervalo: TEdit;
    edtLogoMarca: TEdit;
    edtNumSerie: TEdit;
    edtPathEvento: TEdit;
    edtPathInu: TEdit;
    edtPathLogs: TEdit;
    edtPathNFe: TEdit;
    edtPathPDF: TEdit;
    edtPathSchemas: TEdit;
    edtProxyHost: TEdit;
    edtProxyPorta: TEdit;
    edtProxySenha: TEdit;
    edtProxyUser: TEdit;
    edtSenha: TEdit;
    edtTentativas: TEdit;
    edtToken: TEdit;
    edtURLPFX: TEdit;
    frameRodape1: TframeRodape;

    gbCertificado: TGroupBox;
    gbEscPos: TGroupBox;
    gbProxy: TGroupBox;
    gbxRetornoEnvio: TGroupBox;
    GroupBox1: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
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
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lCryptLib: TLabel;
    lHttpLib: TLabel;
    lSSLLib: TLabel;
    lSSLLib1: TLabel;
    lTimeOut: TLabel;
    lXmlSign: TLabel;
    pgPrincipal: TPageControl;
    pcConfig: TPageControl;
    pnpRodape: TPanel;
    rgDANFCE: TRadioGroup;
    rgTipoAmb: TRadioGroup;
    rgTipoDanfe: TRadioGroup;
    sbPathEvento: TSpeedButton;
    sbPathInu: TSpeedButton;
    sbPathNFe: TSpeedButton;
    sbPathPDF: TSpeedButton;
    sbtnCaminhoCert: TSpeedButton;
    sbtnGetCert: TSpeedButton;
    sbtnLogoMarca: TSpeedButton;
    sbtnNumSerie: TSpeedButton;
    sbtnPathSalvar: TSpeedButton;
    seColunas: TSpinEdit;
    seEspLinhas: TSpinEdit;
    seLinhasPular: TSpinEdit;
    seTimeOut: TSpinEdit;
    spPathSchemas: TSpeedButton;
    tsConfigura: TTabSheet;
    tsConfEmitente: TTabSheet;
    TabArquivos: TTabSheet;
    tbDocAuxiliar: TTabSheet;
    tsConfCertificado: TTabSheet;
    tsConfGeral: TTabSheet;
    tsConfWebService: TTabSheet;
    procedure btnDataValidadeClick(Sender: TObject);
    procedure btnNumSerieClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnSubNameClick(Sender: TObject);
    procedure btnCNPJClick(Sender: TObject);
    procedure btnIssuerNameClick(Sender: TObject);
    procedure btnSha256Click(Sender: TObject);
    procedure btnHTTPSClick(Sender: TObject);
    procedure btnLeituraX509Click(Sender: TObject);
    procedure btVersaoClick(Sender: TObject);
    procedure btSerialClick(Sender: TObject);
    procedure cbSSLTypeChange(Sender: TObject);
    procedure cbSSLLibChange(Sender: TObject);
    procedure cbCryptLibChange(Sender: TObject);
    procedure cbHttpLibChange(Sender: TObject);
    procedure cbXmlSignLibChange(Sender: TObject);
    procedure sbPathNFeClick(Sender: TObject);
    procedure sbPathInuClick(Sender: TObject);
    procedure sbPathEventoClick(Sender: TObject);
    procedure sbPathPDFClick(Sender: TObject);
    procedure sbtnCaminhoCertClick(Sender: TObject);
    procedure sbtnNumSerieClick(Sender: TObject);
    procedure sbtnGetCertClick(Sender: TObject);
    procedure sbtnLogoMarcaClick(Sender: TObject);
    procedure sbtnPathSalvarClick(Sender: TObject);
    procedure spPathSchemasClick(Sender: TObject);
    procedure btProcuraPortasClick(Sender: TObject);
  private
    FOnFechar: TNotifyEvent;

    procedure AtualizarSSLLibsCombo;
    procedure PathClick(Sender: TObject);
    procedure ConfigurarComponente;
    procedure PrepararImpressao;
    procedure AdicionarPortasFixas;
  public
    procedure Inicializar;
    procedure GravarConfiguracao;
    procedure LerConfiguracao;
    procedure Configurar;

    property OnFechar: TNotifyEvent read FOnFechar write FOnFechar;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;


implementation

uses
  strutils,
  Math,
  DateUtils,
  synacode,
  blcksock,
  FileCtrl,
  Grids,
  Printers,
  ACBrUtil.Base,
  ACBrUtil.FilesIO,
  ACBrUtil.DateTime,
  ACBrUtil.XMLHTML,
  ACBrNFe.Classes,
  ACBrNFe.EnvEvento,
  ACBrNFe.EventoClass,
  ACBrDFe.Conversao,
  pcnConversaoNFe,
  ACBrDFeConfiguracoes,
  ACBrDFeOpenSSL,
  ACBrDFeUtil,
  ACBrNFeNotasFiscais,
  ACBrNFeConfiguracoes,
  Frm_Status,
  Frm_ConfiguraSerial;

  {$R *.dfm}

const
  SELDIRHELP = 1000;

  { TframeConfigNfe }

procedure TframeConfigNfe.AtualizarSSLLibsCombo;
begin
  cbSSLType.Enabled := cbSSLType.ItemIndex <> -1;
end;

procedure TframeConfigNfe.Inicializar;
var
  T: TSSLLib;
  I: TpcnTipoEmissao;
  J: TpcnModeloDF;
  K: TpcnVersaoDF;
  U: TSSLCryptLib;
  V: TSSLHttpLib;
  X: TSSLXmlSignLib;
  Y: TSSLType;
  N: TACBrPosPrinterModelo;
  O: TACBrPosPaginaCodigo;
  P: TpcnVersaoQrCode;
begin
  cbSSLLib.Items.Clear;
  for T := Low(TSSLLib) to High(TSSLLib) do
    cbSSLLib.Items.Add(GetEnumName(TypeInfo(TSSLLib), integer(T)));
  cbSSLLib.ItemIndex := 4;

  cbCryptLib.Items.Clear;
  for U := Low(TSSLCryptLib) to High(TSSLCryptLib) do
    cbCryptLib.Items.Add(GetEnumName(TypeInfo(TSSLCryptLib), integer(U)));
  cbCryptLib.ItemIndex := 0;

  cbHttpLib.Items.Clear;
  for V := Low(TSSLHttpLib) to High(TSSLHttpLib) do
    cbHttpLib.Items.Add(GetEnumName(TypeInfo(TSSLHttpLib), integer(V)));
  cbHttpLib.ItemIndex := 0;

  cbXmlSignLib.Items.Clear;
  for X := Low(TSSLXmlSignLib) to High(TSSLXmlSignLib) do
    cbXmlSignLib.Items.Add(GetEnumName(TypeInfo(TSSLXmlSignLib), integer(X)));
  cbXmlSignLib.ItemIndex := 0;

  cbSSLType.Items.Clear;
  for Y := Low(TSSLType) to High(TSSLType) do
    cbSSLType.Items.Add(GetEnumName(TypeInfo(TSSLType), integer(Y)));
  cbSSLType.ItemIndex := 5;

  cbFormaEmissao.Items.Clear;
  for I := Low(TpcnTipoEmissao) to High(TpcnTipoEmissao) do
    cbFormaEmissao.Items.Add(GetEnumName(TypeInfo(TpcnTipoEmissao), integer(I)));
  cbFormaEmissao.ItemIndex := 0;

  cbModeloDF.Items.Clear;
  for J := Low(TpcnModeloDF) to High(TpcnModeloDF) do
    cbModeloDF.Items.Add(GetEnumName(TypeInfo(TpcnModeloDF), integer(J)));
  cbModeloDF.ItemIndex := 0;

  cbVersaoDF.Items.Clear;
  for K := Low(TpcnVersaoDF) to High(TpcnVersaoDF) do
    cbVersaoDF.Items.Add(GetEnumName(TypeInfo(TpcnVersaoDF), integer(K)));
  cbVersaoDF.ItemIndex := 0;

  cbxModeloPosPrinter.Items.Clear;
  for N := Low(TACBrPosPrinterModelo) to High(TACBrPosPrinterModelo) do
    cbxModeloPosPrinter.Items.Add(GetEnumName(TypeInfo(TACBrPosPrinterModelo),
      integer(N)));

  cbxPagCodigo.Items.Clear;
  for O := Low(TACBrPosPaginaCodigo) to High(TACBrPosPaginaCodigo) do
    cbxPagCodigo.Items.Add(GetEnumName(TypeInfo(TACBrPosPaginaCodigo), integer(O)));

  cbVersaoQRCode.Items.Clear;
  for P := Low(TpcnVersaoQrCode) to High(TpcnVersaoQrCode) do
    cbVersaoQRCode.Items.Add(GetEnumName(TypeInfo(TpcnVersaoQrCode), integer(P)));
  cbVersaoQRCode.ItemIndex := 0;

  cbxPorta.Items.Clear;
  frmPrincipal.ACBrPosPrinter1.Device.AcharPortasSeriais(cbxPorta.Items);
  frmPrincipal.ACBrPosPrinter1.Device.AcharPortasRAW(cbxPorta.Items);

  {$IfDef MSWINDOWS}
  cbxPorta.Items.Add('LPT1');
  cbxPorta.Items.Add('\\localhost\Epson');
  cbxPorta.Items.Add('c:\temp\ecf.txt');
  {$EndIf}

  cbxPorta.Items.Add('TCP:192.168.0.31:9100');

  {$IfDef LINUX}
  cbxPorta.Items.Add('/dev/ttyS0');
  cbxPorta.Items.Add('/dev/ttyUSB0');
  cbxPorta.Items.Add('/tmp/ecf.txt');
  {$EndIf}

  LerConfiguracao;
  pgPrincipal.ActivePageIndex := 0;
  pcConfig.ActivePageIndex := 3;
end;

procedure TframeConfigNfe.GravarConfiguracao;
var
  IniFile: string;
  Ini: TIniFile;

begin
  IniFile := ChangeFileExt(ParamStr(0), '.ini');

  Ini := TIniFile.Create(IniFile);
  try
    Ini.WriteInteger('Certificado', 'SSLLib', cbSSLLib.ItemIndex);
    Ini.WriteInteger('Certificado', 'CryptLib', cbCryptLib.ItemIndex);
    Ini.WriteInteger('Certificado', 'HttpLib', cbHttpLib.ItemIndex);
    Ini.WriteInteger('Certificado', 'XmlSignLib', cbXmlSignLib.ItemIndex);
    Ini.WriteString('Certificado', 'URL', edtURLPFX.Text);
    Ini.WriteString('Certificado', 'Caminho', edtCaminho.Text);
    Ini.WriteString('Certificado', 'Senha', edtSenha.Text);
    Ini.WriteString('Certificado', 'NumSerie', edtNumSerie.Text);

    Ini.WriteBool('Geral', 'AtualizarXML', cbxAtualizarXML.Checked);
    Ini.WriteBool('Geral', 'ExibirErroSchema', cbxExibirErroSchema.Checked);
    Ini.WriteString('Geral', 'FormatoAlerta', edtFormatoAlerta.Text);
    Ini.WriteInteger('Geral', 'FormaEmissao', cbFormaEmissao.ItemIndex);
    Ini.WriteInteger('Geral', 'ModeloDF', cbModeloDF.ItemIndex);
    Ini.WriteInteger('Geral', 'VersaoDF', cbVersaoDF.ItemIndex);
    Ini.WriteInteger('Geral', 'VersaoQRCode', cbVersaoQRCode.ItemIndex);
    Ini.WriteString('Geral', 'IdToken', edtIdToken.Text);
    Ini.WriteString('Geral', 'Token', edtToken.Text);
    Ini.WriteBool('Geral', 'RetirarAcentos', cbxRetirarAcentos.Checked);
    Ini.WriteBool('Geral', 'Salvar', ckSalvar.Checked);
    Ini.WriteString('Geral', 'PathSalvar', edtPathLogs.Text);
    Ini.WriteString('Geral', 'PathSchemas', edtPathSchemas.Text);

    Ini.WriteString('WebService', 'UF', cbUF.Text);
    Ini.WriteInteger('WebService', 'Ambiente', rgTipoAmb.ItemIndex);
    Ini.WriteBool('WebService', 'Visualizar', cbxVisualizar.Checked);
    Ini.WriteBool('WebService', 'SalvarSOAP', cbxSalvarSOAP.Checked);
    Ini.WriteBool('WebService', 'AjustarAut', cbxAjustarAut.Checked);
    Ini.WriteString('WebService', 'Aguardar', edtAguardar.Text);
    Ini.WriteString('WebService', 'Tentativas', edtTentativas.Text);
    Ini.WriteString('WebService', 'Intervalo', edtIntervalo.Text);
    Ini.WriteInteger('WebService', 'TimeOut', seTimeOut.Value);
    Ini.WriteInteger('WebService', 'SSLType', cbSSLType.ItemIndex);

    Ini.WriteString('Proxy', 'Host', edtProxyHost.Text);
    Ini.WriteString('Proxy', 'Porta', edtProxyPorta.Text);
    Ini.WriteString('Proxy', 'User', edtProxyUser.Text);
    Ini.WriteString('Proxy', 'Pass', edtProxySenha.Text);

    Ini.WriteBool('Arquivos', 'Salvar', cbxSalvarArqs.Checked);
    Ini.WriteBool('Arquivos', 'PastaMensal', cbxPastaMensal.Checked);
    Ini.WriteBool('Arquivos', 'AddLiteral', cbxAdicionaLiteral.Checked);
    Ini.WriteBool('Arquivos', 'EmissaoPathNFe', cbxEmissaoPathNFe.Checked);
    Ini.WriteBool('Arquivos', 'SalvarPathEvento', cbxSalvaPathEvento.Checked);
    Ini.WriteBool('Arquivos', 'SepararPorCNPJ', cbxSepararPorCNPJ.Checked);
    Ini.WriteBool('Arquivos', 'SepararPorModelo', cbxSepararPorModelo.Checked);
    Ini.WriteString('Arquivos', 'PathNFe', edtPathNFe.Text);
    Ini.WriteString('Arquivos', 'PathInu', edtPathInu.Text);
    Ini.WriteString('Arquivos', 'PathEvento', edtPathEvento.Text);
    Ini.WriteString('Arquivos', 'PathPDF', edtPathPDF.Text);

    Ini.WriteString('Emitente', 'CNPJ', edtEmitCNPJ.Text);
    Ini.WriteString('Emitente', 'IE', edtEmitIE.Text);
    Ini.WriteString('Emitente', 'RazaoSocial', edtEmitRazao.Text);
    Ini.WriteString('Emitente', 'Fantasia', edtEmitFantasia.Text);
    Ini.WriteString('Emitente', 'Fone', edtEmitFone.Text);
    Ini.WriteString('Emitente', 'CEP', edtEmitCEP.Text);
    Ini.WriteString('Emitente', 'Logradouro', edtEmitLogradouro.Text);
    Ini.WriteString('Emitente', 'Numero', edtEmitNumero.Text);
    Ini.WriteString('Emitente', 'Complemento', edtEmitComp.Text);
    Ini.WriteString('Emitente', 'Bairro', edtEmitBairro.Text);
    Ini.WriteString('Emitente', 'CodCidade', edtEmitCodCidade.Text);
    Ini.WriteString('Emitente', 'Cidade', edtEmitCidade.Text);
    Ini.WriteString('Emitente', 'UF', edtEmitUF.Text);
    Ini.WriteInteger('Emitente', 'CRT', cbTipoEmpresa.ItemIndex);

    Ini.WriteString('RespTecnico', 'IdCSRT', edtIdCSRT.Text);
    Ini.WriteString('RespTecnico', 'CSRT', edtCSRT.Text);




    Ini.WriteInteger('DANFE', 'Tipo', rgTipoDanfe.ItemIndex);
    Ini.WriteString('DANFE', 'LogoMarca', edtLogoMarca.Text);
    Ini.WriteInteger('DANFE', 'TipoDANFCE', rgDANFCE.ItemIndex);

    Ini.WriteInteger('PosPrinter', 'Modelo', cbxModeloPosPrinter.ItemIndex);
    Ini.WriteString('PosPrinter', 'Porta', cbxPorta.Text);
    Ini.WriteInteger('PosPrinter', 'PaginaDeCodigo', cbxPagCodigo.ItemIndex);
    Ini.WriteString('PosPrinter', 'ParamsString',
      frmPrincipal.ACBrPosPrinter1.Device.ParamsString);
    Ini.WriteInteger('PosPrinter', 'Colunas', seColunas.Value);
    Ini.WriteInteger('PosPrinter', 'EspacoLinhas', seEspLinhas.Value);
    Ini.WriteInteger('PosPrinter', 'LinhasEntreCupons', seLinhasPular.Value);
    Ini.WriteBool('PosPrinter', 'CortarPapel', cbCortarPapel.Checked);

    ConfigurarComponente;
  finally
    Ini.Free;
  end;
end;

procedure TframeConfigNfe.LerConfiguracao;
var
  IniFile: string;
  Ini: TIniFile;
  StreamMemo: TMemoryStream;
begin
  IniFile := ChangeFileExt(ParamStr(0), '.ini');

  Ini := TIniFile.Create(IniFile);
  try
    cbSSLLib.ItemIndex     := Ini.ReadInteger('Certificado', 'SSLLib',     4);
    cbCryptLib.ItemIndex   := Ini.ReadInteger('Certificado', 'CryptLib',   0);
    cbHttpLib.ItemIndex    := Ini.ReadInteger('Certificado', 'HttpLib',    0);
    cbXmlSignLib.ItemIndex := Ini.ReadInteger('Certificado', 'XmlSignLib', 0);
//    cbSSLLibChange(cbSSLLib);
    edtURLPFX.Text         := Ini.ReadString( 'Certificado', 'URL',        '');
    edtCaminho.Text        := Ini.ReadString( 'Certificado', 'Caminho',    '');
    edtSenha.Text          := Ini.ReadString( 'Certificado', 'Senha',      '');
    edtNumSerie.Text       := Ini.ReadString( 'Certificado', 'NumSerie',   '');

    cbxAtualizarXML.Checked     := Ini.ReadBool(   'Geral', 'AtualizarXML',     True);
    cbxExibirErroSchema.Checked := Ini.ReadBool(   'Geral', 'ExibirErroSchema', True);
    edtFormatoAlerta.Text       := Ini.ReadString( 'Geral', 'FormatoAlerta',    'TAG:%TAGNIVEL% ID:%ID%/%TAG%(%DESCRICAO%) - %MSG%.');
    cbFormaEmissao.ItemIndex    := Ini.ReadInteger('Geral', 'FormaEmissao',     0);
    cbModeloDF.ItemIndex        := Ini.ReadInteger('Geral', 'ModeloDF',         0);

    cbVersaoDF.ItemIndex      := Ini.ReadInteger('Geral', 'VersaoDF',       3);
    cbVersaoQRCode.ItemIndex  := Ini.ReadInteger('Geral', 'VersaoQRCode',   2);
    edtIdToken.Text           := Ini.ReadString( 'Geral', 'IdToken',        '');
    edtToken.Text             := Ini.ReadString( 'Geral', 'Token',          '');
    ckSalvar.Checked          := Ini.ReadBool(   'Geral', 'Salvar',         True);
    cbxRetirarAcentos.Checked := Ini.ReadBool(   'Geral', 'RetirarAcentos', True);
    edtPathLogs.Text          := Ini.ReadString( 'Geral', 'PathSalvar',     PathWithDelim(ExtractFilePath(Application.ExeName))+'Logs');
    edtPathSchemas.Text       := Ini.ReadString( 'Geral', 'PathSchemas',    PathWithDelim(ExtractFilePath(Application.ExeName))+'Schemas\'+GetEnumName(TypeInfo(TpcnVersaoDF), integer(cbVersaoDF.ItemIndex) ));

    cbUF.ItemIndex := cbUF.Items.IndexOf(Ini.ReadString('WebService', 'UF', 'SP'));

    rgTipoAmb.ItemIndex   := Ini.ReadInteger('WebService', 'Ambiente',   0);
    cbxVisualizar.Checked := Ini.ReadBool(   'WebService', 'Visualizar', False);
    cbxSalvarSOAP.Checked := Ini.ReadBool(   'WebService', 'SalvarSOAP', False);
    cbxAjustarAut.Checked := Ini.ReadBool(   'WebService', 'AjustarAut', False);
    edtAguardar.Text      := Ini.ReadString( 'WebService', 'Aguardar',   '0');
    edtTentativas.Text    := Ini.ReadString( 'WebService', 'Tentativas', '5');
    edtIntervalo.Text     := Ini.ReadString( 'WebService', 'Intervalo',  '0');
    seTimeOut.Value       := Ini.ReadInteger('WebService', 'TimeOut',    5000);
    cbSSLType.ItemIndex   := Ini.ReadInteger('WebService', 'SSLType',    5);

    edtProxyHost.Text  := Ini.ReadString('Proxy', 'Host',  '');
    edtProxyPorta.Text := Ini.ReadString('Proxy', 'Porta', '');
    edtProxyUser.Text  := Ini.ReadString('Proxy', 'User',  '');
    edtProxySenha.Text := Ini.ReadString('Proxy', 'Pass',  '');

    cbxSalvarArqs.Checked       := Ini.ReadBool(  'Arquivos', 'Salvar',           false);
    cbxPastaMensal.Checked      := Ini.ReadBool(  'Arquivos', 'PastaMensal',      false);
    cbxAdicionaLiteral.Checked  := Ini.ReadBool(  'Arquivos', 'AddLiteral',       false);
    cbxEmissaoPathNFe.Checked   := Ini.ReadBool(  'Arquivos', 'EmissaoPathNFe',   false);
    cbxSalvaPathEvento.Checked  := Ini.ReadBool(  'Arquivos', 'SalvarPathEvento', false);
    cbxSepararPorCNPJ.Checked   := Ini.ReadBool(  'Arquivos', 'SepararPorCNPJ',   false);
    cbxSepararPorModelo.Checked := Ini.ReadBool(  'Arquivos', 'SepararPorModelo', false);
    edtPathNFe.Text             := Ini.ReadString('Arquivos', 'PathNFe',          '');
    edtPathInu.Text             := Ini.ReadString('Arquivos', 'PathInu',          '');
    edtPathEvento.Text          := Ini.ReadString('Arquivos', 'PathEvento',       '');
    edtPathPDF.Text             := Ini.ReadString('Arquivos', 'PathPDF',          '');

    edtEmitCNPJ.Text       := Ini.ReadString('Emitente', 'CNPJ',        '');
    edtEmitIE.Text         := Ini.ReadString('Emitente', 'IE',          '');
    edtEmitRazao.Text      := Ini.ReadString('Emitente', 'RazaoSocial', '');
    edtEmitFantasia.Text   := Ini.ReadString('Emitente', 'Fantasia',    '');
    edtEmitFone.Text       := Ini.ReadString('Emitente', 'Fone',        '');
    edtEmitCEP.Text        := Ini.ReadString('Emitente', 'CEP',         '');
    edtEmitLogradouro.Text := Ini.ReadString('Emitente', 'Logradouro',  '');
    edtEmitNumero.Text     := Ini.ReadString('Emitente', 'Numero',      '');
    edtEmitComp.Text       := Ini.ReadString('Emitente', 'Complemento', '');
    edtEmitBairro.Text     := Ini.ReadString('Emitente', 'Bairro',      '');
    edtEmitCodCidade.Text  := Ini.ReadString('Emitente', 'CodCidade',   '');
    edtEmitCidade.Text     := Ini.ReadString('Emitente', 'Cidade',      '');
    edtEmitUF.Text         := Ini.ReadString('Emitente', 'UF',          '');

    cbTipoEmpresa.ItemIndex := Ini.ReadInteger('Emitente', 'CRT', 2);

    // Responsável Técnico
    edtIdCSRT.Text := Ini.ReadString('RespTecnico', 'IdCSRT', '');
    edtCSRT.Text := Ini.ReadString('RespTecnico', 'CSRT', '');





    rgTipoDanfe.ItemIndex := Ini.ReadInteger('DANFE', 'Tipo',       0);
    edtLogoMarca.Text     := Ini.ReadString( 'DANFE', 'LogoMarca',  '');
    rgDANFCE.ItemIndex    := Ini.ReadInteger('DANFE', 'TipoDANFCE', 1);

    cbxModeloPosPrinter.ItemIndex := INI.ReadInteger('PosPrinter', 'Modelo',            Integer(frmPrincipal.ACBrPosPrinter1.Modelo));
    cbxPorta.Text                 := INI.ReadString( 'PosPrinter', 'Porta',             frmPrincipal.ACBrPosPrinter1.Porta);
    cbxPagCodigo.ItemIndex        := INI.ReadInteger('PosPrinter', 'PaginaDeCodigo',    Integer(frmPrincipal.ACBrPosPrinter1.PaginaDeCodigo));
    seColunas.Value               := INI.ReadInteger('PosPrinter', 'Colunas',           frmPrincipal.ACBrPosPrinter1.ColunasFonteNormal);
    seEspLinhas.Value             := INI.ReadInteger('PosPrinter', 'EspacoLinhas',      frmPrincipal.ACBrPosPrinter1.EspacoEntreLinhas);
    seLinhasPular.Value           := INI.ReadInteger('PosPrinter', 'LinhasEntreCupons', frmPrincipal.ACBrPosPrinter1.LinhasEntreCupons);
    cbCortarPapel.Checked         := Ini.ReadBool(   'PosPrinter', 'CortarPapel',       True);

    frmPrincipal.ACBrPosPrinter1.Device.ParamsString := INI.ReadString('PosPrinter', 'ParamsString', '');

    ConfigurarComponente;

  finally
    Ini.Free;
  end;
end;

procedure TframeConfigNfe.ConfigurarComponente;
const
  CTipoDanfeMap: array[0..3] of TACBrTipoImpressao =
    (tiRetrato, tiPaisagem, tiSimplificado, tiSimplificadoTipo2);
var
  Ok: boolean;
  PathMensal: string;
begin
  frmPrincipal.ACBrNFe1.Configuracoes.Certificados.URLPFX := edtURLPFX.Text;
  frmPrincipal.ACBrNFe1.Configuracoes.Certificados.ArquivoPFX := edtCaminho.Text;
  frmPrincipal.ACBrNFe1.Configuracoes.Certificados.Senha := edtSenha.Text;
  frmPrincipal.ACBrNFe1.Configuracoes.Certificados.NumeroSerie := edtNumSerie.Text;

  if (cbModeloDF.ItemIndex = 0) and (CTipoDanfeMap[rgTipoDanfe.ItemIndex] <>
    tiSimplificadoTipo2) then
    frmPrincipal.ACBrNFe1.DANFE := frmPrincipal.ACBrNFeDANFeRL1
  else
  begin
    case rgDANFCE.ItemIndex of
      0: frmPrincipal.ACBrNFe1.DANFE := frmPrincipal.ACBrNFeDANFCeFortes1;
      1: frmPrincipal.ACBrNFe1.DANFE := frmPrincipal.ACBrNFeDANFeESCPOS1;
    end;
  end;

  frmPrincipal.ACBrNFe1.SSL.DescarregarCertificado;

  with frmPrincipal.ACBrNFe1.Configuracoes.Geral do
  begin
    SSLLib := TSSLLib(cbSSLLib.ItemIndex);
    SSLCryptLib := TSSLCryptLib(cbCryptLib.ItemIndex);
    SSLHttpLib := TSSLHttpLib(cbHttpLib.ItemIndex);
    SSLXmlSignLib := TSSLXmlSignLib(cbXmlSignLib.ItemIndex);

    AtualizarXMLCancelado := cbxAtualizarXML.Checked;
    Salvar := ckSalvar.Checked;
    ExibirErroSchema := cbxExibirErroSchema.Checked;
    RetirarAcentos := cbxRetirarAcentos.Checked;
    FormatoAlerta := edtFormatoAlerta.Text;
    FormaEmissao := TpcnTipoEmissao(cbFormaEmissao.ItemIndex);
    ModeloDF := TpcnModeloDF(cbModeloDF.ItemIndex);
    VersaoDF := TpcnVersaoDF(cbVersaoDF.ItemIndex);
    IdCSC := edtIdToken.Text;
    CSC := edtToken.Text;
    VersaoQRCode := TpcnVersaoQrCode(cbVersaoQRCode.ItemIndex);
  end;

  with frmPrincipal.ACBrNFe1.Configuracoes.WebServices do
  begin
    UF := cbUF.Text;
    Ambiente := StrToTpAmb(Ok, IntToStr(rgTipoAmb.ItemIndex + 1));
    Visualizar := cbxVisualizar.Checked;
    Salvar := cbxSalvarSOAP.Checked;
    AjustaAguardaConsultaRet := cbxAjustarAut.Checked;

    if NaoEstaVazio(edtAguardar.Text) then
      AguardarConsultaRet := IfThen(StrToInt(edtAguardar.Text) < 1000,
        StrToInt(edtAguardar.Text) * 1000, StrToInt(edtAguardar.Text))
    else
      edtAguardar.Text := IntToStr(AguardarConsultaRet);

    if NaoEstaVazio(edtTentativas.Text) then
      Tentativas := StrToInt(edtTentativas.Text)
    else
      edtTentativas.Text := IntToStr(Tentativas);

    if NaoEstaVazio(edtIntervalo.Text) then
      IntervaloTentativas := IfThen(StrToInt(edtIntervalo.Text) <
        1000, StrToInt(edtIntervalo.Text) * 1000, StrToInt(edtIntervalo.Text))
    else
      edtIntervalo.Text := IntToStr(IntervaloTentativas);

    TimeOut := seTimeOut.Value;
    ProxyHost := edtProxyHost.Text;
    ProxyPort := edtProxyPorta.Text;
    ProxyUser := edtProxyUser.Text;
    ProxyPass := edtProxySenha.Text;
  end;

  frmPrincipal.ACBrNFe1.SSL.SSLType := TSSLType(cbSSLType.ItemIndex);

  with frmPrincipal.ACBrNFe1.Configuracoes.Arquivos do
  begin
    Salvar := cbxSalvarArqs.Checked;
    SepararPorMes := cbxPastaMensal.Checked;
    AdicionarLiteral := cbxAdicionaLiteral.Checked;
    EmissaoPathNFe := cbxEmissaoPathNFe.Checked;
    SalvarEvento := cbxSalvaPathEvento.Checked;
    SepararPorCNPJ := cbxSepararPorCNPJ.Checked;
    SepararPorModelo := cbxSepararPorModelo.Checked;
    PathSchemas := edtPathSchemas.Text;
    PathNFe := edtPathNFe.Text;
    PathInu := edtPathInu.Text;
    PathEvento := edtPathEvento.Text;
    PathMensal := GetPathNFe(0);
    PathSalvar := PathMensal;
  end;

  frmPrincipal.ACBrNFe1.Configuracoes.RespTec.idCSRT := StrToIntDef(edtIdCSRT.Text, 0);
  frmPrincipal.ACBrNFe1.Configuracoes.RespTec.CSRT := edtCSRT.Text;

  if (frmPrincipal.ACBrNFe1.DANFE <> nil) and (rgTipoDanfe.ItemIndex >=
    Low(CTipoDanfeMap)) and (rgTipoDanfe.ItemIndex <= High(CTipoDanfeMap)) then
  begin
    frmPrincipal.ACBrNFe1.DANFE.TipoDANFE := CTipoDanfeMap[rgTipoDanfe.ItemIndex];
    frmPrincipal.ACBrNFe1.DANFE.Logo := edtLogoMarca.Text;
    frmPrincipal.ACBrNFe1.DANFE.PathPDF := edtPathPDF.Text;
    frmPrincipal.ACBrNFe1.DANFE.MargemDireita := 7;
    frmPrincipal.ACBrNFe1.DANFE.MargemEsquerda := 7;
    frmPrincipal.ACBrNFe1.DANFE.MargemSuperior := 5;
    frmPrincipal.ACBrNFe1.DANFE.MargemInferior := 5;
  end;
end;

procedure TframeConfigNfe.Configurar;
begin
  ConfigurarComponente;
  PrepararImpressao;
end;

constructor TframeConfigNfe.Create(AOwner: TComponent);
 var
  T: TSSLLib;
  I: TpcnTipoEmissao;
  J: TpcnModeloDF;
  K: TpcnVersaoDF;
  U: TSSLCryptLib;
  V: TSSLHttpLib;
  X: TSSLXmlSignLib;
  Y: TSSLType;
  N: TACBrPosPrinterModelo;
  O: TACBrPosPaginaCodigo;
  P: TpcnVersaoQrCode;
begin
  inherited Create(AOwner);

  cbSSLLib.Items.Clear;
  for T := Low(TSSLLib) to High(TSSLLib) do
    cbSSLLib.Items.Add( GetEnumName(TypeInfo(TSSLLib), integer(T) ) );
  cbSSLLib.ItemIndex := 4;

  cbCryptLib.Items.Clear;
  for U := Low(TSSLCryptLib) to High(TSSLCryptLib) do
    cbCryptLib.Items.Add( GetEnumName(TypeInfo(TSSLCryptLib), integer(U) ) );
  cbCryptLib.ItemIndex := 0;

  cbHttpLib.Items.Clear;
  for V := Low(TSSLHttpLib) to High(TSSLHttpLib) do
    cbHttpLib.Items.Add( GetEnumName(TypeInfo(TSSLHttpLib), integer(V) ) );
  cbHttpLib.ItemIndex := 0;

  cbXmlSignLib.Items.Clear;
  for X := Low(TSSLXmlSignLib) to High(TSSLXmlSignLib) do
    cbXmlSignLib.Items.Add( GetEnumName(TypeInfo(TSSLXmlSignLib), integer(X) ) );
  cbXmlSignLib.ItemIndex := 0;

  cbSSLType.Items.Clear;
  for Y := Low(TSSLType) to High(TSSLType) do
    cbSSLType.Items.Add( GetEnumName(TypeInfo(TSSLType), integer(Y) ) );
  cbSSLType.ItemIndex := 5;

  cbFormaEmissao.Items.Clear;
  for I := Low(TpcnTipoEmissao) to High(TpcnTipoEmissao) do
     cbFormaEmissao.Items.Add( GetEnumName(TypeInfo(TpcnTipoEmissao), integer(I) ) );
  cbFormaEmissao.ItemIndex := 0;

  cbModeloDF.Items.Clear;
  for J := Low(TpcnModeloDF) to High(TpcnModeloDF) do
     cbModeloDF.Items.Add( GetEnumName(TypeInfo(TpcnModeloDF), integer(J) ) );
  cbModeloDF.ItemIndex := 0;

  cbVersaoDF.Items.Clear;
  for K := Low(TpcnVersaoDF) to High(TpcnVersaoDF) do
     cbVersaoDF.Items.Add( GetEnumName(TypeInfo(TpcnVersaoDF), integer(K) ) );
  cbVersaoDF.ItemIndex := 0;

  cbxModeloPosPrinter.Items.Clear ;
  for N := Low(TACBrPosPrinterModelo) to High(TACBrPosPrinterModelo) do
    cbxModeloPosPrinter.Items.Add( GetEnumName(TypeInfo(TACBrPosPrinterModelo), integer(N) ) ) ;

  cbxPagCodigo.Items.Clear ;
  for O := Low(TACBrPosPaginaCodigo) to High(TACBrPosPaginaCodigo) do
     cbxPagCodigo.Items.Add( GetEnumName(TypeInfo(TACBrPosPaginaCodigo), integer(O) ) ) ;

  cbVersaoQRCode.Items.Clear;
  for P := Low(TpcnVersaoQrCode) to High(TpcnVersaoQrCode) do
     cbVersaoQRCode.Items.Add( GetEnumName(TypeInfo(TpcnVersaoQrCode), integer(P) ) );
  cbVersaoQRCode.ItemIndex := 0;

  // So as portas fixas. A busca de portas (COM1..COMn, impressoras do
  // Windows) e lenta e fica no botao btProcuraPortas.
  cbxPorta.Items.Clear;
  AdicionarPortasFixas;

  LerConfiguracao;
end;

procedure TframeConfigNfe.AdicionarPortasFixas;
begin
  {$IfDef MSWINDOWS}
  cbxPorta.Items.Add('LPT1');
  cbxPorta.Items.Add('\\localhost\Epson');
  cbxPorta.Items.Add('c:\temp\ecf.txt');
  {$EndIf}

  cbxPorta.Items.Add('TCP:192.168.0.31:9100');
  {$IfDef LINUX}
  cbxPorta.Items.Add('/dev/ttyS0');
  cbxPorta.Items.Add('/dev/ttyUSB0');
  cbxPorta.Items.Add('/tmp/ecf.txt');
  {$EndIf}
end;

procedure TframeConfigNfe.btProcuraPortasClick(Sender: TObject);
var
  LPortaAtual: String;
begin
  LPortaAtual := cbxPorta.Text;
  Screen.Cursor := crHourGlass;
  cbxPorta.Items.BeginUpdate;
  try
    cbxPorta.Items.Clear;
    frmPrincipal.ACBrPosPrinter1.Device.AcharPortasSeriais(cbxPorta.Items, 20);
    frmPrincipal.ACBrPosPrinter1.Device.AcharPortasRAW(cbxPorta.Items);
    AdicionarPortasFixas;
  finally
    cbxPorta.Items.EndUpdate;
    Screen.Cursor := crDefault;
  end;
  cbxPorta.Text := LPortaAtual;
  cbxPorta.DroppedDown := True;
end;

destructor TframeConfigNfe.Destroy;
begin
  inherited Destroy;
end;

procedure TframeConfigNfe.PrepararImpressao;
begin
  frmPrincipal.ACBrPosPrinter1.Desativar;

  frmPrincipal.ACBrPosPrinter1.Modelo :=
    TACBrPosPrinterModelo(cbxModeloPosPrinter.ItemIndex);
  frmPrincipal.ACBrPosPrinter1.PaginaDeCodigo :=
    TACBrPosPaginaCodigo(cbxPagCodigo.ItemIndex);
  frmPrincipal.ACBrPosPrinter1.Porta := cbxPorta.Text;
  frmPrincipal.ACBrPosPrinter1.ColunasFonteNormal := seColunas.Value;
  frmPrincipal.ACBrPosPrinter1.LinhasEntreCupons := seLinhasPular.Value;
  frmPrincipal.ACBrPosPrinter1.EspacoEntreLinhas := seEspLinhas.Value;
  frmPrincipal.ACBrPosPrinter1.CortaPapel := cbCortarPapel.Checked;

  frmPrincipal.ACBrPosPrinter1.Ativar;
end;

procedure TframeConfigNfe.PathClick(Sender: TObject);
var
  Dir: string;
begin
  if Length(TEdit(Sender).Text) <= 0 then
    Dir := ApplicationPath
  else
    Dir := TEdit(Sender).Text;

  if SelectDirectory(Dir, [sdAllowCreate, sdPerformCreate, sdPrompt], SELDIRHELP) then
    TEdit(Sender).Text := Dir;
end;

procedure TframeConfigNfe.sbPathNFeClick(Sender: TObject);
begin
  PathClick(edtPathNFe);
end;

procedure TframeConfigNfe.sbPathInuClick(Sender: TObject);
begin
  PathClick(edtPathInu);
end;

procedure TframeConfigNfe.sbPathEventoClick(Sender: TObject);
begin
  PathClick(edtPathEvento);
end;

procedure TframeConfigNfe.sbPathPDFClick(Sender: TObject);
begin
  PathClick(edtPathPDF);
end;

procedure TframeConfigNfe.sbtnPathSalvarClick(Sender: TObject);
begin
  PathClick(edtPathLogs);
end;

procedure TframeConfigNfe.spPathSchemasClick(Sender: TObject);
begin
  PathClick(edtPathSchemas);
end;

procedure TframeConfigNfe.sbtnCaminhoCertClick(Sender: TObject);
begin
  frmPrincipal.OpenDialog1.Title := 'Selecione o Certificado';
  frmPrincipal.OpenDialog1.DefaultExt := '*.pfx';
  frmPrincipal.OpenDialog1.Filter :=
    'Arquivos PFX (*.pfx)|*.pfx|Todos os Arquivos (*.*)|*.*';
  frmPrincipal.OpenDialog1.InitialDir := ApplicationPath;

  if frmPrincipal.OpenDialog1.Execute then
    edtCaminho.Text := frmPrincipal.OpenDialog1.FileName;
end;

procedure TframeConfigNfe.sbtnGetCertClick(Sender: TObject);
begin
  edtNumSerie.Text := frmPrincipal.ACBrNFe1.SSL.SelecionarCertificado;
end;

procedure TframeConfigNfe.sbtnLogoMarcaClick(Sender: TObject);
begin
  frmPrincipal.OpenDialog1.Title := 'Selecione o Logo';
  frmPrincipal.OpenDialog1.DefaultExt := '*.bmp';
  frmPrincipal.OpenDialog1.Filter :=
    'Arquivos BMP (*.bmp)|*.bmp|Todos os Arquivos (*.*)|*.*';
  frmPrincipal.OpenDialog1.InitialDir := ApplicationPath;

  if frmPrincipal.OpenDialog1.Execute then
    edtLogoMarca.Text := frmPrincipal.OpenDialog1.FileName;
end;

procedure TframeConfigNfe.sbtnNumSerieClick(Sender: TObject);
var
  I: integer;
  AddRow: boolean;
  frmSelecionarCertificado: TfrmSelecionarCertificado;
begin
  frmSelecionarCertificado := TfrmSelecionarCertificado.Create(Self);
  try
    frmPrincipal.ACBrNFe1.SSL.LerCertificadosStore;
    AddRow := False;

    with frmSelecionarCertificado.StringGrid1 do
    begin
      ColWidths[0] := 220;
      ColWidths[1] := 250;
      ColWidths[2] := 120;
      ColWidths[3] := 80;
      ColWidths[4] := 150;
      Cells[0, 0] := 'Num.Série';
      Cells[1, 0] := 'Razão Social';
      Cells[2, 0] := 'CNPJ';
      Cells[3, 0] := 'Validade';
      Cells[4, 0] := 'Certificadora';
    end;

    for I := 0 to frmPrincipal.ACBrNFe1.SSL.ListaCertificados.Count - 1 do
      with frmPrincipal.ACBrNFe1.SSL.ListaCertificados[I] do
        if CNPJ <> '' then
        begin
          with frmSelecionarCertificado.StringGrid1 do
          begin
            if AddRow then
              RowCount := RowCount + 1;

            Cells[0, RowCount - 1] := NumeroSerie;
            Cells[1, RowCount - 1] := RazaoSocial;
            Cells[2, RowCount - 1] := CNPJ;
            Cells[3, RowCount - 1] := FormatDateTimeBr(DataVenc);
            Cells[4, RowCount - 1] := Certificadora;
            AddRow := True;
          end;
        end;

    frmSelecionarCertificado.ShowModal;

    if frmSelecionarCertificado.ModalResult = mrOk then
      edtNumSerie.Text :=
        frmSelecionarCertificado.StringGrid1.Cells[0,
        frmSelecionarCertificado.StringGrid1.Row];
  finally
    frmSelecionarCertificado.Free;
  end;
end;

procedure TframeConfigNfe.btnDataValidadeClick(Sender: TObject);
begin
  ShowMessage(FormatDateTimeBr(frmPrincipal.ACBrNFe1.SSL.CertDataVenc));
end;

procedure TframeConfigNfe.btnNumSerieClick(Sender: TObject);
begin
  ShowMessage(frmPrincipal.ACBrNFe1.SSL.CertNumeroSerie);
end;

procedure TframeConfigNfe.btnSalvarClick(Sender: TObject);
begin
  GravarConfiguracao;
  if Assigned(FOnFechar) then
    FOnFechar(Self);
end;

procedure TframeConfigNfe.btnSubNameClick(Sender: TObject);
begin
  ShowMessage(frmPrincipal.ACBrNFe1.SSL.CertSubjectName + sLineBreak +
    sLineBreak + 'Razão Social: ' +
    frmPrincipal.ACBrNFe1.SSL.CertRazaoSocial);
end;

procedure TframeConfigNfe.btnCNPJClick(Sender: TObject);
begin
  ShowMessage(frmPrincipal.ACBrNFe1.SSL.CertCNPJ);
end;

procedure TframeConfigNfe.btnIssuerNameClick(Sender: TObject);
begin
  ShowMessage(frmPrincipal.ACBrNFe1.SSL.CertIssuerName + sLineBreak +
    sLineBreak + 'Certificadora: ' +
    frmPrincipal.ACBrNFe1.SSL.CertCertificadora);
end;

procedure TframeConfigNfe.btnSha256Click(Sender: TObject);
var
  AHash: ansistring;
begin
  AHash := frmPrincipal.ACBrNFe1.SSL.CalcHash(Edit1.Text, dgstSHA256,
    outBase64, cbAssinar.Checked);
  ShowMessage(AHash);
end;

procedure TframeConfigNfe.btnHTTPSClick(Sender: TObject);
var
  Acao: string;
  OldUseCert: boolean;
begin
  Acao := '<?xml version="1.0" encoding="UTF-8" standalone="no"?>' +
    '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" ' +
    'xmlns:cli="http://cliente.bean.master.sigep.bsb.correios.com.br/"> ' +
    ' <soapenv:Header/>' + ' <soapenv:Body>' + ' <cli:consultaCEP>' +
    ' <cep>18270-170</cep>' + ' </cli:consultaCEP>' + ' </soapenv:Body>' +
    ' </soapenv:Envelope>';

  OldUseCert := frmPrincipal.ACBrNFe1.SSL.UseCertificateHTTP;
  frmPrincipal.ACBrNFe1.SSL.UseCertificateHTTP := False;
  try
    ShowMessage(frmPrincipal.ACBrNFe1.SSL.Enviar(
      Acao, 'https://apps.correios.com.br/SigepMasterJPA/AtendeClienteService/AtendeCliente?wsdl',
      ''));
  finally
    frmPrincipal.ACBrNFe1.SSL.UseCertificateHTTP := OldUseCert;
  end;
end;

procedure TframeConfigNfe.btnLeituraX509Click(Sender: TObject);
var
  Msg: string;
begin
  with frmPrincipal.ACBrNFe1.SSL do
  begin
    CarregarCertificadoPublico(Edit1.Text);
    Msg := 'Issuer: ' + CertIssuerName + sLineBreak + 'Razão Social: ' +
      CertRazaoSocial + sLineBreak + 'CNPJ: ' + CertCNPJ +
      sLineBreak + 'Subject: ' + CertSubjectName + sLineBreak +
      'Número de Série: ' + CertNumeroSerie;
  end;
  ShowMessage(Msg);
end;

procedure TframeConfigNfe.btVersaoClick(Sender: TObject);
begin
  ShowMessage(frmPrincipal.ACBrNFe1.SSL.SSLCryptClass.Versao);
end;

procedure TframeConfigNfe.btSerialClick(Sender: TObject);
begin
  ShowMessage('A configuração da porta serial deve ser feita pelo componente frmPrincipal.ACBrPosPrinter1.'
    + sLineBreak + 'Porta atual: ' + cbxPorta.Text);
end;

procedure TframeConfigNfe.cbSSLTypeChange(Sender: TObject);
begin
  if cbSSLType.ItemIndex <> -1 then
    frmPrincipal.ACBrNFe1.SSL.SSLType := TSSLType(cbSSLType.ItemIndex);
end;

procedure TframeConfigNfe.cbSSLLibChange(Sender: TObject);
begin
  try
    if cbSSLLib.ItemIndex <> -1 then
      frmPrincipal.ACBrNFe1.Configuracoes.Geral.SSLLib := TSSLLib(cbSSLLib.ItemIndex);
  finally
    AtualizarSSLLibsCombo;
  end;
end;

procedure TframeConfigNfe.cbCryptLibChange(Sender: TObject);
begin
  try
    if cbCryptLib.ItemIndex <> -1 then
      frmPrincipal.ACBrNFe1.Configuracoes.Geral.SSLCryptLib :=
        TSSLCryptLib(cbCryptLib.ItemIndex);
  finally
    AtualizarSSLLibsCombo;
  end;
end;

procedure TframeConfigNfe.cbHttpLibChange(Sender: TObject);
begin
  try
    if cbHttpLib.ItemIndex <> -1 then
      frmPrincipal.ACBrNFe1.Configuracoes.Geral.SSLHttpLib :=
        TSSLHttpLib(cbHttpLib.ItemIndex);
  finally
    AtualizarSSLLibsCombo;
  end;
end;

procedure TframeConfigNfe.cbXmlSignLibChange(Sender: TObject);
begin
  try
    if cbXmlSignLib.ItemIndex <> -1 then
      frmPrincipal.ACBrNFe1.Configuracoes.Geral.SSLXmlSignLib :=
        TSSLXmlSignLib(cbXmlSignLib.ItemIndex);
  finally
    AtualizarSSLLibsCombo;
  end;
end;

end.
