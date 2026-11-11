program ACBrNFeABI_Exemplo;

uses
  Forms,
  Frm_ACBrNFeABI in 'Frm_ACBrNFeABI.pas' {frmACBrNFeABI},
  Frm_SelecionarCertificado in 'Frm_SelecionarCertificado.pas' {frmSelecionarCertificado},
  Frm_Status in 'Frm_Status.pas' {frmStatus};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmACBrNFeABI, frmACBrNFeABI);
  Application.CreateForm(TfrmSelecionarCertificado, frmSelecionarCertificado);
  Application.CreateForm(TfrmStatus, frmStatus);
  Application.Run;
end.
