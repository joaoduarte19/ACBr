program ACBrDeRE_Exemplo;

uses
  Forms,
  // Salve a pasta Comum do programa de exemplo no mesmo caminho das pastas Delphi e Lazarus
  // ..\Exemplos\ACBrDFe\ACBrDeRE\Comum
  ACBrDeRE.Exemplo.Comum in '..\Comum\ACBrDeRE.Exemplo.Comum.pas',
  Frm_ACBrDeRE in 'Frm_ACBrDeRE.pas' {frmACBrDeRE},
  Frm_SelecionarCertificado in 'Frm_SelecionarCertificado.pas' {frmSelecionarCertificado},
  Frm_Status in 'Frm_Status.pas' {frmStatus};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmACBrDeRE, frmACBrDeRE);
  Application.CreateForm(TfrmSelecionarCertificado, frmSelecionarCertificado);
  Application.CreateForm(TfrmStatus, frmStatus);
  Application.Run;
end.
