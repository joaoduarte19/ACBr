program ACBrNFGas_Exemplo;

uses
  Forms,
  Frm_ACBrNFGas in 'Frm_ACBrNFGas.pas' {frmACBrNFGas},
  Frm_SelecionarCertificado in 'Frm_SelecionarCertificado.pas' {frmSelecionarCertificado},
  Frm_ConfiguraSerial in 'Frm_ConfiguraSerial.pas' {frmConfiguraSerial},
  Frm_Status in 'Frm_Status.pas' {frmStatus};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := true;
  Application.Initialize;
  Application.CreateForm(TfrmACBrNFGas, frmACBrNFGas);
  Application.CreateForm(TfrmSelecionarCertificado, frmSelecionarCertificado);
  Application.CreateForm(TfrmConfiguraSerial, frmConfiguraSerial);
  Application.CreateForm(TfrmStatus, frmStatus);
  Application.Run;
end.
