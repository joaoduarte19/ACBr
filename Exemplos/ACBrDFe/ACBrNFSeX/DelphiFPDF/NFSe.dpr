program NFSe;

uses
  Forms,
  Form.NFSe in 'Form.NFSe.pas' {FNFSe},
  ACBrNFSeXDANFSeFPDFClass in '..\..\..\..\Fontes\ACBrDFe\ACBrNFSeX\DANFSE\FPDF\ACBrNFSeXDANFSeFPDFClass.pas',
  ACBr.DANFSeX.FPDFA4Retrato in '..\..\..\..\Fontes\ACBrDFe\ACBrNFSeX\DANFSE\FPDF\ACBr.DANFSeX.FPDFA4Retrato.pas',
  ACBr.DANFSeX.FPDFPadraoNacional in '..\..\..\..\Fontes\ACBrDFe\ACBrNFSeX\DANFSE\FPDF\ACBr.DANFSeX.FPDFPadraoNacional.pas',
  ACBr.DANFSeX.FPDF.Utils in '..\..\..\..\Fontes\ACBrDFe\ACBrNFSeX\DANFSE\FPDF\ACBr.DANFSeX.FPDF.Utils.pas',
  ACBr.DANFSeX.Classes in '..\..\..\..\Fontes\ACBrDFe\ACBrNFSeX\DANFSE\ACBr.DANFSeX.Classes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFNFSe, FNFSe);
  Application.Run;
end.
