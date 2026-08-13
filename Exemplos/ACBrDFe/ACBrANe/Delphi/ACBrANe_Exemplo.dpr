program ACBrANe_Exemplo;

uses
  Forms,
  Frm_ACBrANe in 'Frm_ACBrANe.pas' {frmACBrANe},
  Frm_SelecionarCertificado in 'Frm_SelecionarCertificado.pas' {frmSelecionarCertificado},
  Frm_Status in 'Frm_Status.pas' {frmStatus};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmACBrANe, frmACBrANe);
  Application.Run;
end.
