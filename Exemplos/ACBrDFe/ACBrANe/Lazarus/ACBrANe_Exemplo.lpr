program ACBrANe_Exemplo;

{$MODE Delphi}

uses
  Forms,
  Interfaces,
  Frm_ACBrANe in 'Frm_ACBrANe.pas' {frmACBrANe},
  Frm_SelecionarCertificado in 'Frm_SelecionarCertificado.pas' {frmSelecionarCertificado},
  Frm_Status in 'Frm_Status.pas' {frmStatus};

{.$R *.res}

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmACBrANe, frmACBrANe);
  Application.Run;
end.
