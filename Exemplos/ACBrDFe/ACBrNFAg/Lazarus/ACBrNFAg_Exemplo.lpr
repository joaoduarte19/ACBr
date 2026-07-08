program ACBrNFAg_Exemplo;

{$MODE Delphi}

uses
  Forms, Interfaces,
  Frm_ACBrNFAg in 'Frm_ACBrNFAg.pas' {frmACBrNFAg},
  Frm_SelecionarCertificado in 'Frm_SelecionarCertificado.pas' {frmSelecionarCertificado},
  Frm_ConfiguraSerial in 'Frm_ConfiguraSerial.pas' {frmConfiguraSerial},
  Frm_Status in 'Frm_Status.pas' {frmStatus};



begin
  Application.Initialize;
  Application.CreateForm(TfrmACBrNFAg, frmACBrNFAg);
  Application.CreateForm(TfrmSelecionarCertificado, frmSelecionarCertificado);
  Application.CreateForm(TfrmConfiguraSerial, frmConfiguraSerial);
  Application.CreateForm(TfrmStatus, frmStatus);
  Application.Run;
end.
