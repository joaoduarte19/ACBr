{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interacao com equipa- }
{ mentos de Automacao Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Renato Rubinho                                  }
{                                                                              }
{  Voce pode obter a ultima versao desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Esta biblioteca e software livre; voce pode redistribui-la e/ou modifica-la }
{ sob os termos da Licenca Publica Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a versao 2.1 da Licenca, ou (a seu criterio) }
{ qualquer versao posterior.                                                   }
{                                                                              }
{  Esta biblioteca e distribuida na expectativa de que seja util, porem, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia implicita de COMERCIABILIDADE OU      }
{ ADEQUACAO A UMA FINALIDADE ESPECIFICA. Consulte a Licenca Publica Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENCA.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Voce deve ter recebido uma copia da Licenca Publica Geral Menor do GNU junto}
{ com esta biblioteca; se nao, escreva para a Free Software Foundation, Inc.,  }
{ no endereco 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Voce tambem pode obter uma copia da licenca em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Simoes de Almeida - daniel@projetoacbr.com.br - www.projetoacbr.com.br}
{       Rua Coronel Aureliano de Camargo, 963 - Tatui - SP - 18270-170         }
{******************************************************************************}

unit Frm_ACBrDeRE;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Spin, Buttons, ComCtrls, blcksock,
  ACBrUtil.Base, ACBrUtil.Strings, ACBrUtil.DateTime, ACBrUtil.FilesIO,
  ACBrBase, ACBrDFe, ACBrDFe.Conversao,
  ACBrDeRE, ACBrDeRE.Classes, ACBrDeRE.Conversao,
  // Salve a pasta Comum do programa de exemplo no mesmo caminho das pastas Delphi e Lazarus
  // ..\Exemplos\ACBrDFe\ACBrDeRE\Comum
  ACBrDeRE.Exemplo.Comum;

type
  TfrmACBrDeRE = class(TForm)
    pnlMenus: TPanel;
    pgPrincipal: TPageControl;
    tsConfig: TTabSheet;
    pgConfig: TPageControl;
    tsCertificado: TTabSheet;
    lblSSLLib: TLabel;
    lblCryptLib: TLabel;
    lblHttpLib: TLabel;
    lblXmlSignLib: TLabel;
    gbCertificado: TGroupBox;
    lblCaminhoCert: TLabel;
    lblSenhaCert: TLabel;
    sbtnCaminhoCert: TSpeedButton;
    lblNumSerie: TLabel;
    sbtnGetCert: TSpeedButton;
    sbtnNumSerie: TSpeedButton;
    edtCaminho: TEdit;
    edtSenha: TEdit;
    edtNumSerie: TEdit;
    btnDataValidade: TButton;
    btnNumSerie: TButton;
    btnRazaoSocial: TButton;
    btnCNPJ: TButton;
    cbSSLLib: TComboBox;
    cbCryptLib: TComboBox;
    cbHttpLib: TComboBox;
    cbXmlSignLib: TComboBox;
    tsGeral: TTabSheet;
    gbGeral: TGroupBox;
    lblFormatoAlerta: TLabel;
    lblVersaoDF: TLabel;
    lblPathSchemas: TLabel;
    sbtnPathLogs: TSpeedButton;
    sbtnPathSchemas: TSpeedButton;
    cbxAtualizarXML: TCheckBox;
    cbxExibirErroSchema: TCheckBox;
    edtFormatoAlerta: TEdit;
    cbVersaoDF: TComboBox;
    cbxRetirarAcentos: TCheckBox;
    cbxSalvar: TCheckBox;
    edtPathLogs: TEdit;
    edtPathSchemas: TEdit;
    tsWebService: TTabSheet;
    gbWebService: TGroupBox;
    lblTimeOut: TLabel;
    lblSSLType: TLabel;
    rgTipoAmb: TRadioGroup;
    seTimeOut: TSpinEdit;
    cbSSLType: TComboBox;
    gbProxy: TGroupBox;
    lblProxyHost: TLabel;
    lblProxyPorta: TLabel;
    lblProxyUser: TLabel;
    lblProxySenha: TLabel;
    edtProxyHost: TEdit;
    edtProxyPorta: TEdit;
    edtProxyUser: TEdit;
    edtProxySenha: TEdit;
    tsEmitente: TTabSheet;
    gbContribuinte: TGroupBox;
    lblIdContribuinte: TLabel;
    edtIdContribuinte: TEdit;
    gbApi: TGroupBox;
    lblClientId: TLabel;
    lblClientSecret: TLabel;
    edtClientId: TEdit;
    edtClientSecret: TEdit;
    gbToken: TGroupBox;
    lblToken: TLabel;
    lblTokenExpira: TLabel;
    edtToken: TEdit;
    edtTokenExpira: TEdit;
    btnObterToken: TButton;
    btnLimparDados: TButton;
    tsArquivos: TTabSheet;
    sbtnPathDeRE: TSpeedButton;
    lblPathDeRE: TLabel;
    cbxSepararPorMes: TCheckBox;
    cbxSepararPorCNPJ: TCheckBox;
    cbxEmissaoPathDeRE: TCheckBox;
    edtPathDeRE: TEdit;
    btnSalvarConfig: TBitBtn;
    pnlCentral: TPanel;
    pgEventos: TPageControl;
    tsEventosTabela: TTabSheet;
    cbD1001: TCheckBox;
    cbD1011: TCheckBox;
    cbD1101: TCheckBox;
    cbD1106: TCheckBox;
    cbD1121: TCheckBox;
    cbD1198: TCheckBox;
    cbD1199: TCheckBox;
    cbD2101: TCheckBox;
    cbD2102: TCheckBox;
    cbD2201: TCheckBox;
    cbD2202: TCheckBox;
    cbD2211: TCheckBox;
    cbD2221: TCheckBox;
    cbD2231: TCheckBox;
    cbD2241: TCheckBox;
    cbD2242: TCheckBox;
    cbD2251: TCheckBox;
    cbD2252: TCheckBox;
    cbD3201: TCheckBox;
    cbD4201: TCheckBox;
    tsEventosPeriodicos: TTabSheet;
    tsEventosTransacionais: TTabSheet;
    pgRespostas: TPageControl;
    tsComandos: TTabSheet;
    lblProtocolo: TLabel;
    btnGerar: TButton;
    btnCarregarXML: TButton;
    btnCarregarINI: TButton;
    btnGravarINI: TButton;
    btnEnviar: TButton;
    edProtocolo: TEdit;
    btnConsultar: TButton;
    tsLog: TTabSheet;
    memoLog: TMemo;
    OpenDialog1: TOpenDialog;
    ACBrDeRE1: TACBrDeRE;
    procedure FormCreate(Sender: TObject);
    procedure btnSalvarConfigClick(Sender: TObject);
    procedure sbtnCaminhoCertClick(Sender: TObject);
    procedure sbtnGetCertClick(Sender: TObject);
    procedure sbtnNumSerieClick(Sender: TObject);
    procedure sbtnPathSchemasClick(Sender: TObject);
    procedure sbtnPathLogsClick(Sender: TObject);
    procedure sbtnPathDeREClick(Sender: TObject);
    procedure btnNumSerieClick(Sender: TObject);
    procedure btnCNPJClick(Sender: TObject);
    procedure btnRazaoSocialClick(Sender: TObject);
    procedure btnDataValidadeClick(Sender: TObject);
    procedure cbSSLLibChange(Sender: TObject);
    procedure cbCryptLibChange(Sender: TObject);
    procedure cbHttpLibChange(Sender: TObject);
    procedure cbXmlSignLibChange(Sender: TObject);
    procedure cbSSLTypeChange(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure btnCarregarXMLClick(Sender: TObject);
    procedure btnCarregarINIClick(Sender: TObject);
    procedure btnGravarINIClick(Sender: TObject);
    procedure btnEnviarClick(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure btnObterTokenClick(Sender: TObject);
    procedure btnLimparDadosClick(Sender: TObject);
    procedure lblColaboradorClick(Sender: TObject);
    procedure lblPatrocinadorClick(Sender: TObject);
    procedure lblDoar1Click(Sender: TObject);
    procedure lblDoar2Click(Sender: TObject);
    procedure ACBrDeRE1GerarLog(const ALogLine: string; var Tratado: Boolean);
    procedure ACBrDeRE1StatusChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FExemplo: TACBrDeREExemplo;
    procedure AdicionarLog(const ALinha: string);
    procedure ExibirMensagem(const AMensagem: string);
    procedure PathClick(AEdit: TEdit);
    procedure AtualizarSSLLibsCombo;
    procedure GravarConfiguracao;
    procedure LerConfiguracao;
    procedure ConfigurarComponente;
  public
    { Public declarations }
  end;

var
  frmACBrDeRE: TfrmACBrDeRE;

implementation

uses
  TypInfo, IniFiles, DateUtils,
  ACBrDFeConfiguracoes, ACBrDFeSSL,
  Frm_Status, Frm_SelecionarCertificado;

{$R *.lfm}

{ TfrmACBrDeRE }

procedure TfrmACBrDeRE.FormCreate(Sender: TObject);
var
  L: TSSLLib;
  U: TSSLCryptLib;
  V: TSSLHttpLib;
  X: TSSLXmlSignLib;
  Y: TSSLType;
  K: TVersaoDeRE;
begin
  cbSSLLib.Items.Clear;
  for L := Low(TSSLLib) to High(TSSLLib) do
    cbSSLLib.Items.Add(GetEnumName(TypeInfo(TSSLLib), Integer(L)));
  cbSSLLib.ItemIndex := 4;

  cbCryptLib.Items.Clear;
  for U := Low(TSSLCryptLib) to High(TSSLCryptLib) do
    cbCryptLib.Items.Add(GetEnumName(TypeInfo(TSSLCryptLib), Integer(U)));
  cbCryptLib.ItemIndex := 0;

  cbHttpLib.Items.Clear;
  for V := Low(TSSLHttpLib) to High(TSSLHttpLib) do
    cbHttpLib.Items.Add(GetEnumName(TypeInfo(TSSLHttpLib), Integer(V)));
  cbHttpLib.ItemIndex := 0;

  cbXmlSignLib.Items.Clear;
  for X := Low(TSSLXmlSignLib) to High(TSSLXmlSignLib) do
    cbXmlSignLib.Items.Add(GetEnumName(TypeInfo(TSSLXmlSignLib), Integer(X)));
  cbXmlSignLib.ItemIndex := 0;

  cbSSLType.Items.Clear;
  for Y := Low(TSSLType) to High(TSSLType) do
    cbSSLType.Items.Add(GetEnumName(TypeInfo(TSSLType), Integer(Y)));
  cbSSLType.ItemIndex := 5;

  cbVersaoDF.Items.Clear;
  for K := Low(TVersaoDeRE) to High(TVersaoDeRE) do
    cbVersaoDF.Items.Add(VersaoDeREToStr(K));
  cbVersaoDF.ItemIndex := Ord(High(TVersaoDeRE)); // abre com a versao mais recente

  LerConfiguracao;
  pgPrincipal.ActivePageIndex := 0;
  pgConfig.ActivePageIndex := 0;
  pgEventos.ActivePageIndex := 0;
  pgRespostas.ActivePageIndex := 0;

  FExemplo := TACBrDeREExemplo.Create(ACBrDeRE1);
  FExemplo.OnLog := AdicionarLog;
  FExemplo.OnMensagem := ExibirMensagem;
end;

procedure TfrmACBrDeRE.FormDestroy(Sender: TObject);
begin
  FExemplo.Free;
end;

procedure TfrmACBrDeRE.AdicionarLog(const ALinha: string);
begin
  memoLog.Lines.Add(ALinha);
end;

procedure TfrmACBrDeRE.ExibirMensagem(const AMensagem: string);
begin
  ShowMessage(AMensagem);
end;

procedure TfrmACBrDeRE.AtualizarSSLLibsCombo;
begin
  cbSSLLib.ItemIndex     := Integer(ACBrDeRE1.Configuracoes.Geral.SSLLib);
  cbCryptLib.ItemIndex   := Integer(ACBrDeRE1.Configuracoes.Geral.SSLCryptLib);
  cbHttpLib.ItemIndex    := Integer(ACBrDeRE1.Configuracoes.Geral.SSLHttpLib);
  cbXmlSignLib.ItemIndex := Integer(ACBrDeRE1.Configuracoes.Geral.SSLXmlSignLib);

  cbSSLType.Enabled := (ACBrDeRE1.Configuracoes.Geral.SSLHttpLib in [httpWinHttp, httpOpenSSL]);
end;

procedure TfrmACBrDeRE.cbSSLLibChange(Sender: TObject);
begin
  try
    if cbSSLLib.ItemIndex <> -1 then
      ACBrDeRE1.Configuracoes.Geral.SSLLib := TSSLLib(cbSSLLib.ItemIndex);
  finally
    AtualizarSSLLibsCombo;
  end;
end;

procedure TfrmACBrDeRE.cbCryptLibChange(Sender: TObject);
begin
  try
    if cbCryptLib.ItemIndex <> -1 then
      ACBrDeRE1.Configuracoes.Geral.SSLCryptLib := TSSLCryptLib(cbCryptLib.ItemIndex);
  finally
    AtualizarSSLLibsCombo;
  end;
end;

procedure TfrmACBrDeRE.cbHttpLibChange(Sender: TObject);
begin
  try
    if cbHttpLib.ItemIndex <> -1 then
      ACBrDeRE1.Configuracoes.Geral.SSLHttpLib := TSSLHttpLib(cbHttpLib.ItemIndex);
  finally
    AtualizarSSLLibsCombo;
  end;
end;

procedure TfrmACBrDeRE.cbXmlSignLibChange(Sender: TObject);
begin
  try
    if cbXmlSignLib.ItemIndex <> -1 then
      ACBrDeRE1.Configuracoes.Geral.SSLXmlSignLib := TSSLXmlSignLib(cbXmlSignLib.ItemIndex);
  finally
    AtualizarSSLLibsCombo;
  end;
end;

procedure TfrmACBrDeRE.cbSSLTypeChange(Sender: TObject);
begin
  if cbSSLType.ItemIndex <> -1 then
    ACBrDeRE1.SSL.SSLType := TSSLType(cbSSLType.ItemIndex);
end;

procedure TfrmACBrDeRE.PathClick(AEdit: TEdit);
var
  Dir: string;
begin
  if Length(AEdit.Text) <= 0 then
    Dir := ExtractFileDir(Application.ExeName)
  else
    Dir := AEdit.Text;

  if SelectDirectory('Selecione o Diretorio', Dir, Dir) then
    AEdit.Text := Dir;
end;

procedure TfrmACBrDeRE.lblColaboradorClick(Sender: TObject);
begin
  OpenURL('http://acbr.sourceforge.net/drupal/?q=node/5');
end;

procedure TfrmACBrDeRE.lblPatrocinadorClick(Sender: TObject);
begin
  OpenURL('http://acbr.sourceforge.net/drupal/?q=node/5');
end;

procedure TfrmACBrDeRE.lblDoar1Click(Sender: TObject);
begin
  OpenURL('http://acbr.sourceforge.net/drupal/?q=node/14');
end;

procedure TfrmACBrDeRE.lblDoar2Click(Sender: TObject);
begin
  OpenURL('http://acbr.sourceforge.net/drupal/?q=node/14');
end;

procedure TfrmACBrDeRE.sbtnCaminhoCertClick(Sender: TObject);
begin
  OpenDialog1.Title := 'Selecione o Certificado';
  OpenDialog1.DefaultExt := '*.pfx';
  OpenDialog1.Filter := 'Arquivos PFX (*.pfx)|*.pfx|Todos os Arquivos (*.*)|*.*';
  OpenDialog1.InitialDir := ExtractFileDir(Application.ExeName);

  if OpenDialog1.Execute then
    edtCaminho.Text := OpenDialog1.FileName;
end;

procedure TfrmACBrDeRE.sbtnGetCertClick(Sender: TObject);
begin
  edtNumSerie.Text := ACBrDeRE1.SSL.SelecionarCertificado;
end;

procedure TfrmACBrDeRE.sbtnNumSerieClick(Sender: TObject);
var
  I: Integer;
  AddRow: Boolean;
begin
  ACBrDeRE1.SSL.LerCertificadosStore;
  AddRow := False;

  with frmSelecionarCertificado.StringGrid1 do
  begin
    ColWidths[0] := 220;
    ColWidths[1] := 250;
    ColWidths[2] := 120;
    ColWidths[3] := 80;
    ColWidths[4] := 150;

    Cells[0, 0] := 'Num.Serie';
    Cells[1, 0] := 'Razao Social';
    Cells[2, 0] := 'CNPJ';
    Cells[3, 0] := 'Validade';
    Cells[4, 0] := 'Certificadora';
  end;

  for I := 0 to ACBrDeRE1.SSL.ListaCertificados.Count - 1 do
  begin
    with ACBrDeRE1.SSL.ListaCertificados[I] do
    begin
      if (CNPJ <> '') then
      begin
        with frmSelecionarCertificado.StringGrid1 do
        begin
          if AddRow then
            RowCount := RowCount + 1;

          Cells[0, RowCount - 1] := NumeroSerie;
          Cells[1, RowCount - 1] := RazaoSocial;
          Cells[2, RowCount - 1] := CNPJ;
          Cells[3, RowCount - 1] := FormatDateBr(DataVenc);
          Cells[4, RowCount - 1] := Certificadora;

          AddRow := True;
        end;
      end;
    end;
  end;

  frmSelecionarCertificado.ShowModal;

  if frmSelecionarCertificado.ModalResult = mrOK then
    edtNumSerie.Text := frmSelecionarCertificado.StringGrid1.Cells[0,
      frmSelecionarCertificado.StringGrid1.Row];
end;

procedure TfrmACBrDeRE.sbtnPathSchemasClick(Sender: TObject);
begin
  PathClick(edtPathSchemas);
end;

procedure TfrmACBrDeRE.sbtnPathLogsClick(Sender: TObject);
begin
  PathClick(edtPathLogs);
end;

procedure TfrmACBrDeRE.sbtnPathDeREClick(Sender: TObject);
begin
  PathClick(edtPathDeRE);
end;

procedure TfrmACBrDeRE.btnNumSerieClick(Sender: TObject);
begin
  ShowMessage(ACBrDeRE1.SSL.CertNumeroSerie);
end;

procedure TfrmACBrDeRE.btnCNPJClick(Sender: TObject);
begin
  ShowMessage(ACBrDeRE1.SSL.CertCNPJ);
end;

procedure TfrmACBrDeRE.btnRazaoSocialClick(Sender: TObject);
begin
  ShowMessage(ACBrDeRE1.SSL.CertRazaoSocial);
end;

procedure TfrmACBrDeRE.btnDataValidadeClick(Sender: TObject);
begin
  ShowMessage(FormatDateBr(ACBrDeRE1.SSL.CertDataVenc));
end;

procedure TfrmACBrDeRE.btnSalvarConfigClick(Sender: TObject);
begin
  GravarConfiguracao;
  ShowMessage('Configuracoes salvas.');
end;

procedure TfrmACBrDeRE.GravarConfiguracao;
var
  IniFile: string;
  Ini: TIniFile;
begin
  IniFile := ChangeFileExt(Application.ExeName, '.ini');

  Ini := TIniFile.Create(IniFile);
  try
    Ini.WriteInteger('Certificado', 'SSLLib',     cbSSLLib.ItemIndex);
    Ini.WriteInteger('Certificado', 'CryptLib',   cbCryptLib.ItemIndex);
    Ini.WriteInteger('Certificado', 'HttpLib',    cbHttpLib.ItemIndex);
    Ini.WriteInteger('Certificado', 'XmlSignLib', cbXmlSignLib.ItemIndex);
    Ini.WriteString( 'Certificado', 'Caminho',    edtCaminho.Text);
    Ini.WriteString( 'Certificado', 'Senha',      edtSenha.Text);
    Ini.WriteString( 'Certificado', 'NumSerie',   edtNumSerie.Text);

    Ini.WriteInteger('Geral', 'VersaoDF',         cbVersaoDF.ItemIndex);
    Ini.WriteBool(   'Geral', 'AtualizarXML',     cbxAtualizarXML.Checked);
    Ini.WriteBool(   'Geral', 'ExibirErroSchema', cbxExibirErroSchema.Checked);
    Ini.WriteBool(   'Geral', 'RetirarAcentos',   cbxRetirarAcentos.Checked);
    Ini.WriteString( 'Geral', 'FormatoAlerta',    edtFormatoAlerta.Text);
    Ini.WriteBool(   'Geral', 'Salvar',           cbxSalvar.Checked);
    Ini.WriteString( 'Geral', 'PathSalvar',       edtPathLogs.Text);
    Ini.WriteString( 'Geral', 'PathSchemas',      edtPathSchemas.Text);

    Ini.WriteInteger('API', 'Ambiente',     rgTipoAmb.ItemIndex);
    Ini.WriteString( 'API', 'ClientId',     edtClientId.Text);
    Ini.WriteString( 'API', 'ClientSecret', edtClientSecret.Text);
    Ini.WriteString( 'API', 'Token',        edtToken.Text);
    Ini.WriteString( 'API', 'TokenExpira',  edtTokenExpira.Text);
    Ini.WriteString( 'API', 'IdContribuinte', edtIdContribuinte.Text);
    Ini.WriteInteger('API', 'TimeOut',      seTimeOut.Value);
    Ini.WriteInteger('API', 'SSLType',      cbSSLType.ItemIndex);

    Ini.WriteString('Proxy', 'Host',  edtProxyHost.Text);
    Ini.WriteString('Proxy', 'Porta', edtProxyPorta.Text);
    Ini.WriteString('Proxy', 'User',  edtProxyUser.Text);
    Ini.WriteString('Proxy', 'Pass',  edtProxySenha.Text);

    Ini.WriteBool(  'Arquivos', 'EmissaoPathDeRE', cbxEmissaoPathDeRE.Checked);
    Ini.WriteBool(  'Arquivos', 'SepararPorCNPJ',  cbxSepararPorCNPJ.Checked);
    Ini.WriteBool(  'Arquivos', 'SepararPorMes',   cbxSepararPorMes.Checked);
    Ini.WriteString('Arquivos', 'PathDeRE',        edtPathDeRE.Text);
  finally
    Ini.Free;
  end;

  ConfigurarComponente;
end;

procedure TfrmACBrDeRE.LerConfiguracao;
var
  IniFile: string;
  Ini: TIniFile;
begin
  IniFile := ChangeFileExt(Application.ExeName, '.ini');

  Ini := TIniFile.Create(IniFile);
  try
    cbSSLLib.ItemIndex     := Ini.ReadInteger('Certificado', 'SSLLib',     4);
    cbCryptLib.ItemIndex   := Ini.ReadInteger('Certificado', 'CryptLib',   0);
    cbHttpLib.ItemIndex    := Ini.ReadInteger('Certificado', 'HttpLib',    0);
    cbXmlSignLib.ItemIndex := Ini.ReadInteger('Certificado', 'XmlSignLib', 0);
    cbSSLLibChange(cbSSLLib);
    edtCaminho.Text        := Ini.ReadString( 'Certificado', 'Caminho',    '');
    edtSenha.Text          := Ini.ReadString( 'Certificado', 'Senha',      '');
    edtNumSerie.Text       := Ini.ReadString( 'Certificado', 'NumSerie',   '');

    // Sem valor gravado no INI (ou invalido), assume a versao mais recente
    cbVersaoDF.ItemIndex        := Ini.ReadInteger('Geral', 'VersaoDF', Ord(High(TVersaoDeRE)));
    if (cbVersaoDF.ItemIndex < 0) or (cbVersaoDF.ItemIndex > Ord(High(TVersaoDeRE))) then
      cbVersaoDF.ItemIndex      := Ord(High(TVersaoDeRE));
    cbxAtualizarXML.Checked     := Ini.ReadBool(   'Geral', 'AtualizarXML',     True);
    cbxExibirErroSchema.Checked := Ini.ReadBool(   'Geral', 'ExibirErroSchema', True);
    cbxRetirarAcentos.Checked   := Ini.ReadBool(   'Geral', 'RetirarAcentos',   False);
    edtFormatoAlerta.Text       := Ini.ReadString( 'Geral', 'FormatoAlerta',
      'TAG:%TAGNIVEL% ID:%ID%/%TAG%(%DESCRICAO%) - %MSG%.');
    cbxSalvar.Checked           := Ini.ReadBool(   'Geral', 'Salvar',           True);
    edtPathLogs.Text            := Ini.ReadString( 'Geral', 'PathSalvar',
      PathWithDelim(ExtractFilePath(Application.ExeName)) + 'Logs');
    edtPathSchemas.Text         := Ini.ReadString( 'Geral', 'PathSchemas',
      PathWithDelim(ExtractFilePath(Application.ExeName)) + 'Schemas\DeRE');

    rgTipoAmb.ItemIndex   := Ini.ReadInteger('API', 'Ambiente',       0);
    edtClientId.Text      := Ini.ReadString( 'API', 'ClientId',       '');
    edtClientSecret.Text  := Ini.ReadString( 'API', 'ClientSecret',   '');
    edtToken.Text         := Ini.ReadString( 'API', 'Token',          '');
    edtTokenExpira.Text   := Ini.ReadString( 'API', 'TokenExpira',    '');
    edtIdContribuinte.Text := Ini.ReadString('API', 'IdContribuinte', '');
    seTimeOut.Value       := Ini.ReadInteger('API', 'TimeOut',        30000);
    cbSSLType.ItemIndex   := Ini.ReadInteger('API', 'SSLType',        5);

    edtProxyHost.Text  := Ini.ReadString('Proxy', 'Host',  '');
    edtProxyPorta.Text := Ini.ReadString('Proxy', 'Porta', '');
    edtProxyUser.Text  := Ini.ReadString('Proxy', 'User',  '');
    edtProxySenha.Text := Ini.ReadString('Proxy', 'Pass',  '');

    cbxEmissaoPathDeRE.Checked := Ini.ReadBool('Arquivos', 'EmissaoPathDeRE', False);
    cbxSepararPorCNPJ.Checked  := Ini.ReadBool('Arquivos', 'SepararPorCNPJ',  False);
    cbxSepararPorMes.Checked   := Ini.ReadBool('Arquivos', 'SepararPorMes',   False);
    edtPathDeRE.Text           := Ini.ReadString('Arquivos', 'PathDeRE',      '');

    ConfigurarComponente;
  finally
    Ini.Free;
  end;
end;

procedure TfrmACBrDeRE.ConfigurarComponente;
begin
  ACBrDeRE1.Configuracoes.Certificados.ArquivoPFX  := edtCaminho.Text;
  ACBrDeRE1.Configuracoes.Certificados.Senha       := edtSenha.Text;
  ACBrDeRE1.Configuracoes.Certificados.NumeroSerie := edtNumSerie.Text;

  with ACBrDeRE1.Configuracoes.Geral do
  begin
    SSLLib        := TSSLLib(cbSSLLib.ItemIndex);
    SSLCryptLib   := TSSLCryptLib(cbCryptLib.ItemIndex);
    SSLHttpLib    := TSSLHttpLib(cbHttpLib.ItemIndex);
    SSLXmlSignLib := TSSLXmlSignLib(cbXmlSignLib.ItemIndex);

    AtualizarSSLLibsCombo;

    Salvar           := cbxSalvar.Checked;
    ExibirErroSchema := cbxExibirErroSchema.Checked;
    RetirarAcentos   := cbxRetirarAcentos.Checked;
    FormatoAlerta    := edtFormatoAlerta.Text;

    VersaoDF       := TVersaoDeRE(cbVersaoDF.ItemIndex);
    IdContribuinte := edtIdContribuinte.Text;
    ClientId       := edtClientId.Text;
    ClientSecret   := edtClientSecret.Text;
    Token          := Trim(edtToken.Text);
    TokenExpira    := StrToDateTimeDef(Trim(edtTokenExpira.Text), 0);
  end;

  with ACBrDeRE1.SSL do
  begin
    DescarregarCertificado;
    SSLDgst := dgstSHA256;
    if cbSSLType.ItemIndex <> -1 then
      SSLType := TSSLType(cbSSLType.ItemIndex);
  end;

  with ACBrDeRE1.Configuracoes.WebServices do
  begin
    if rgTipoAmb.ItemIndex = 0 then
      Ambiente := taProducao
    else
      Ambiente := taHomologacao;

    TimeOut   := seTimeOut.Value;
    ProxyHost := edtProxyHost.Text;
    ProxyPort := edtProxyPorta.Text;
    ProxyUser := edtProxyUser.Text;
    ProxyPass := edtProxySenha.Text;
  end;

  with ACBrDeRE1.Configuracoes.Arquivos do
  begin
    Salvar           := cbxSalvar.Checked;
    SepararPorMes    := cbxSepararPorMes.Checked;
    SepararPorCNPJ   := cbxSepararPorCNPJ.Checked;
    EmissaoPathDeRE  := cbxEmissaoPathDeRE.Checked;
    PathSchemas      := edtPathSchemas.Text;
    PathDeRE         := edtPathDeRE.Text;
    PathSalvar       := edtPathLogs.Text;
  end;
end;

procedure TfrmACBrDeRE.btnGerarClick(Sender: TObject);
var
  LTipos: TTiposEventoDeRE;
begin
  edProtocolo.Text := '';
  ConfigurarComponente;

  LTipos := [];
  if cbD1001.Checked then
    Include(LTipos, teInfoContrib);
  if cbD1011.Checked then
    Include(LTipos, tePGCC);
  if cbD1101.Checked then
    Include(LTipos, teBalancete);
  if cbD1106.Checked then
    Include(LTipos, teAplicResTec);
  if cbD1121.Checked then
    Include(LTipos, teRelDeducoes);
  if cbD1198.Checked then
    Include(LTipos, teReabertMensal);
  if cbD1199.Checked then
    Include(LTipos, teFechMensal);
  if cbD2101.Checked then
    Include(LTipos, teDebOpOfPublic);
  if cbD2102.Checked then
    Include(LTipos, teInfoCotistas);
  if cbD2201.Checked then
    Include(LTipos, teServRemPreco);
  if cbD2202.Checked then
    Include(LTipos, teServRemTarifa);
  if cbD2211.Checked then
    Include(LTipos, teOperFinanc);
  if cbD2221.Checked then
    Include(LTipos, teAntecReceb);
  if cbD2231.Checked then
    Include(LTipos, teArrendMerc);
  if cbD2241.Checked then
    Include(LTipos, teArranjoCredDest);
  if cbD2242.Checked then
    Include(LTipos, teArranjoPartic);
  if cbD2251.Checked then
    Include(LTipos, teSegPrevCap);
  if cbD2252.Checked then
    Include(LTipos, teSegElemSCob);
  if cbD3201.Checked then
    Include(LTipos, tePlAssistSaude);
  if cbD4201.Checked then
    Include(LTipos, teIdApostPrem);

  FExemplo.GerarEventos(LTipos);
end;

procedure TfrmACBrDeRE.btnCarregarXMLClick(Sender: TObject);
begin
  OpenDialog1.Title := 'Selecione o Evento (Arquivo XML)';
  OpenDialog1.DefaultExt := '*.xml';
  OpenDialog1.Filter := 'Arquivos XML (*.xml)|*.xml|Todos os Arquivos (*.*)|*.*';
  OpenDialog1.InitialDir := ACBrDeRE1.Configuracoes.Arquivos.PathSalvar;

  if OpenDialog1.Execute then
    FExemplo.CarregarXML(OpenDialog1.FileName);
end;

procedure TfrmACBrDeRE.btnCarregarINIClick(Sender: TObject);
begin
  OpenDialog1.Title := 'Selecione o Evento (Arquivo INI)';
  OpenDialog1.DefaultExt := '*.ini';
  OpenDialog1.Filter := 'Arquivos INI (*.ini)|*.ini|Todos os Arquivos (*.*)|*.*';
  OpenDialog1.InitialDir := ACBrDeRE1.Configuracoes.Arquivos.PathSalvar;

  if OpenDialog1.Execute then
    FExemplo.CarregarINI(OpenDialog1.FileName);
end;

procedure TfrmACBrDeRE.btnGravarINIClick(Sender: TObject);
begin
  ConfigurarComponente;

  FExemplo.GravarINI;
end;

procedure TfrmACBrDeRE.btnEnviarClick(Sender: TObject);
begin
  ConfigurarComponente;

  edProtocolo.Text := FExemplo.EnviarLote;

  pgRespostas.ActivePage := tsLog;
end;

procedure TfrmACBrDeRE.btnObterTokenClick(Sender: TObject);
var
  LObteve: Boolean;
begin
  ConfigurarComponente;

  LObteve := FExemplo.ObterToken;

  pgRespostas.ActivePage := tsLog;

  if LObteve then
  begin
    edtToken.Text := ACBrDeRE1.Configuracoes.Geral.Token;
    edtTokenExpira.Text := FormatDateTime('dd/mm/yyyy hh:nn:ss',
      ACBrDeRE1.Configuracoes.Geral.TokenExpira);

    if MessageDlg('Token atualizado. Deseja salvar as configuracoes?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      GravarConfiguracao;
      ShowMessage('Configuracoes salvas.');
    end;
  end;
end;

procedure TfrmACBrDeRE.btnLimparDadosClick(Sender: TObject);
begin
  ConfigurarComponente;

  if ACBrDeRE1.Configuracoes.WebServices.Ambiente <> taHomologacao then
  begin
    ShowMessage('A limpeza de dados existe somente na Producao Restrita. ' +
      'Selecione o ambiente de Homologacao.');
    Exit;
  end;

  if MessageDlg('Remover TODOS os dados deste contribuinte na Producao Restrita?',
    mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  FExemplo.LimparDados;

  pgRespostas.ActivePage := tsLog;
end;

procedure TfrmACBrDeRE.btnConsultarClick(Sender: TObject);
begin
  ConfigurarComponente;

  FExemplo.ConsultarLote(edProtocolo.Text);

  pgRespostas.ActivePage := tsLog;
end;

procedure TfrmACBrDeRE.ACBrDeRE1GerarLog(const ALogLine: string; var Tratado: Boolean);
begin
  memoLog.Lines.Add(ALogLine);
  Tratado := False;
end;

procedure TfrmACBrDeRE.ACBrDeRE1StatusChange(Sender: TObject);
begin
  case ACBrDeRE1.Status of
    stDeREIdle:
      begin
        if (frmStatus <> nil) then
          frmStatus.Hide;
      end;
    stDeREToken:
      begin
        if (frmStatus = nil) then
          frmStatus := TfrmStatus.Create(Application);
        frmStatus.lblStatus.Caption := 'Obtendo token da DeRE...';
        frmStatus.Show;
        frmStatus.BringToFront;
      end;
    stDeRERecepcao:
      begin
        if (frmStatus = nil) then
          frmStatus := TfrmStatus.Create(Application);
        frmStatus.lblStatus.Caption := 'Enviando lote da DeRE...';
        frmStatus.Show;
        frmStatus.BringToFront;
      end;
    stDeREConsulta:
      begin
        if (frmStatus = nil) then
          frmStatus := TfrmStatus.Create(Application);
        frmStatus.lblStatus.Caption := 'Consultando lote da DeRE...';
        frmStatus.Show;
        frmStatus.BringToFront;
      end;
    stDeRELimpeza:
      begin
        if (frmStatus = nil) then
          frmStatus := TfrmStatus.Create(Application);
        frmStatus.lblStatus.Caption := 'Limpando dados na Producao Restrita...';
        frmStatus.Show;
        frmStatus.BringToFront;
      end;
  end;

  Application.ProcessMessages;
end;

end.
