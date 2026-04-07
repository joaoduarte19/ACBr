program NFSe;

uses
  Forms,
  Form.NFSe in 'Form.NFSe.pas' {FNFSe},
  ACBrNFSeXDANFSeFR in '..\..\..\..\Fontes\ACBrDFe\ACBrNFSeX\DANFSE\Fast\ACBrNFSeXDANFSeFR.pas';

//  FastReportAdapter in '..\..\..\..\Fontes\ACBrDFe\ACBrNFSeX\DANFSE\Fast\Dynamic\core\FastReportAdapter.pas',
//  FastReportBuilder in '..\..\..\..\Fontes\ACBrDFe\ACBrNFSeX\DANFSE\Fast\Dynamic\core\FastReportBuilder.pas',
//  FastReportFramework in '..\..\..\..\Fontes\ACBrDFe\ACBrNFSeX\DANFSE\Fast\Dynamic\core\FastReportFramework.pas',
//  FastReportVersionDetector in '..\..\..\..\Fontes\ACBrDFe\ACBrNFSeX\DANFSE\Fast\Dynamic\core\FastReportVersionDetector.pas',
//  FastReportConstants in '..\..\..\..\Fontes\ACBrDFe\ACBrNFSeX\DANFSE\Fast\Dynamic\utils\FastReportConstants.pas',
//  FastReportUtils in '..\..\..\..\Fontes\ACBrDFe\ACBrNFSeX\DANFSE\Fast\Dynamic\utils\FastReportUtils.pas',
//  FastReportFramework.Intf in '..\..\..\..\Fontes\ACBrDFe\ACBrNFSeX\DANFSE\Fast\Dynamic\core\FastReportFramework.Intf.pas',
//  FastReportAdapter.Intf in '..\..\..\..\Fontes\ACBrDFe\ACBrNFSeX\DANFSE\Fast\Dynamic\core\FastReportAdapter.Intf.pas',
//
//  NFSeBuilder in '..\..\..\..\Fontes\ACBrDFe\ACBrNFSeX\DANFSE\Fast\Dynamic\Builder\NFSe\NFSeBuilder.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFNFSe, FNFSe);
  Application.Run;
end.

