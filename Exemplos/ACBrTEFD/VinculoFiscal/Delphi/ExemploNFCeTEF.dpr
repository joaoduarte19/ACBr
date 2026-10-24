program ExemploNFCeTEF;

uses
  Forms,
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uFrames in 'uFrames.pas',
  uFrameTitulo in 'uFrameTitulo.pas' {FrameTitulo: TFrame},
  uframemenuesquerdo in 'uframemenuesquerdo.pas' {frameMenuEsquerdo: TFrame},
  uframeConfigNFe in 'uframeConfigNFe.pas' {frameConfigNfe: TFrame},
  uframerodapeSalvar in 'uframerodapeSalvar.pas' {frameRodape: TFrame},
  uframeconfigTEF in 'uframeconfigTEF.pas' {frameConfigTEF: TFrame},
  uframePDV in 'uframePDV.pas' {framePDV: TFrame},
  uframePDVRodape in 'uframePDVRodape.pas' {framePDVRodape: TFrame},
  uClasseProduto in 'uClasseProduto.pas',
  uClasseItemPedido in 'uClasseItemPedido.pas',
  Frm_ConfiguraSerial in 'Frm_ConfiguraSerial.pas' {frmConfiguraSerial},
  Frm_SelecionarCertificado in 'Frm_SelecionarCertificado.pas' {frmSelecionarCertificado},
  Frm_Status in 'Frm_Status.pas' {frmStatus},
  uClassePagamento in 'uClassePagamento.pas',
  uframePagamento in 'uframePagamento.pas' {framePagamento: TFrame},
  uTEFUtils in 'uTEFUtils.pas',
  uVinculoPagamentoNFCe in 'uVinculoPagamentoNFCe.pas',
  Frm_RaioXVinculo in 'Frm_RaioXVinculo.pas' {frmRaioXVinculo},
  uPIXUtils in 'uPIXUtils.pas',
  uframeConfigPIX in 'uframeConfigPIX.pas' {frameConfigPIX: TFrame},
  frMenuTEF in 'frMenuTEF.pas' {FormMenuTEF},
  frObtemCampo in 'frObtemCampo.pas' {FormObtemCampo},
  frExibeMensagem in 'frExibeMensagem.pas' {FormExibeMensagem};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'ExemploNFCeTEF';
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TfrmConfiguraSerial, frmConfiguraSerial);
  Application.CreateForm(TFrmSelecionarCertificado, FrmSelecionarCertificado);
  Application.CreateForm(TfrmStatus, frmStatus);
  Application.Run;
end.
