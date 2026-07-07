program ACBrNFSeXTestCases;

{$mode objfpc}{$H+}

uses
  Interfaces, Forms, ACBrNFSeXTests, ACBrTests.Util, GuiTestRunner,
  ACBrNFSeXProviderBaseTests,
  ACBrNFSeXProvedorABRASFv1Tests, ACBrNFSeXProvedorABRASFv2Tests,
  ACBrNFSeXProvedorAgiliTests,
  ACBrNFSeXProvedorAssessorPublicoTests,
  ACBrNFSeXProvedorBauhausTests,
  ACBrNFSeXProvedorEquiplanoTests,
  ACBrNFSeXProvedorIPMTests,
  ACBrNFSeXProvedorISSBarueriTests,
  ACBrNFSeXProvedorPadraoNacionalTests,
  ACBrNFSeXProvedorSigISSTests,
  ACBrNFSeXProvedorSigISSWebTests,
  ACBrNFSeXProvedorSoftPlanTests,
  ACBrNFSeXProvedorWebFiscoTests,
  ACBrNFSeXRetornoSoapTests;
  //ACBrNFSeXIniTests;

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TGuiTestRunner, TestRunner);
  Application.Run;
end.

