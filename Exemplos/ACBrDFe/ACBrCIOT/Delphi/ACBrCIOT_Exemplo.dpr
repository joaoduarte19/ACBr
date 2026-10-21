program ACBrCIOT_Exemplo;

uses
  Forms,
  Frm_ACBrCIOT in 'Frm_ACBrCIOT.pas' {frmACBrCIOT},
  Frm_SelecionarCertificado in 'Frm_SelecionarCertificado.pas' {frmSelecionarCertificado},
  Frm_Status in 'Frm_Status.pas' {frmStatus},
  pcnRetEnvCIOT in '..\..\..\..\Fontes\ACBrDFe\ACBrCIOT\PCNCIOT\pcnRetEnvCIOT.pas',
  ACBrCIOTWebServices in '..\..\..\..\Fontes\ACBrDFe\ACBrCIOT\ACBrCIOTWebServices.pas',
  pcnCIOTW_ANTT in '..\..\..\..\Fontes\ACBrDFe\ACBrCIOT\PCNCIOT\pcnCIOTW_ANTT.pas',
  pcnCIOTW in '..\..\..\..\Fontes\ACBrDFe\ACBrCIOT\PCNCIOT\pcnCIOTW.pas',
  pcnCIOT in '..\..\..\..\Fontes\ACBrDFe\ACBrCIOT\PCNCIOT\pcnCIOT.pas',
  ACBrCIOTConversao in '..\..\..\..\Fontes\ACBrDFe\ACBrCIOT\PCNCIOT\ACBrCIOTConversao.pas',
  ACBrCIOT in '..\..\..\..\Fontes\ACBrDFe\ACBrCIOT\ACBrCIOT.pas',
  pcnCIOTW_eFrete in '..\..\..\..\Fontes\ACBrDFe\ACBrCIOT\PCNCIOT\pcnCIOTW_eFrete.pas',
  pcnCIOTW_Pamcard in '..\..\..\..\Fontes\ACBrDFe\ACBrCIOT\PCNCIOT\pcnCIOTW_Pamcard.pas',
  ACBrCIOTIniReader in '..\..\..\..\Fontes\ACBrDFe\ACBrCIOT\Base\ACBrCIOTIniReader.pas',
  ACBrCIOTIniWriter in '..\..\..\..\Fontes\ACBrDFe\ACBrCIOT\Base\ACBrCIOTIniWriter.pas',
  ACBrCIOTContratos in '..\..\..\..\Fontes\ACBrDFe\ACBrCIOT\ACBrCIOTContratos.pas',
  pcnCIOTW_WexFrete in '..\..\..\..\Fontes\ACBrDFe\ACBrCIOT\PCNCIOT\pcnCIOTW_WexFrete.pas',
  pcnCIOTR in '..\..\..\..\Fontes\ACBrDFe\ACBrCIOT\PCNCIOT\pcnCIOTR.pas',
  ACBrCIOTConfiguracoes in '..\..\..\..\Fontes\ACBrDFe\ACBrCIOT\ACBrCIOTConfiguracoes.pas',
  pcnCIOTW_REPOM in '..\..\..\..\Fontes\ACBrDFe\ACBrCIOT\PCNCIOT\pcnCIOTW_REPOM.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmACBrCIOT, frmACBrCIOT);
  Application.CreateForm(TfrmSelecionarCertificado, frmSelecionarCertificado);
  Application.CreateForm(TfrmStatus, frmStatus);
  Application.Run;
end.
