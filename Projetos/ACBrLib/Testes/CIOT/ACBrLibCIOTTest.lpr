program ACBrLibCIOTTest;

{$mode objfpc}{$H+}

uses
  Interfaces, Forms, ACBrLibCIOTStaticImportMT, GuiTestRunner,
  ACBrLibConsts, ACBrLibCIOTTestCase;

{$R *.res}

begin
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TGuiTestRunner, TestRunner);
  Application.Run;
end.

