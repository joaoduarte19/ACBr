program ACBrLibDeRETest;

{$mode objfpc}{$H+}

uses
  Interfaces, Forms, ACBrLibDeREStaticImportMT, GuiTestRunner,
  ACBrLibConsts, ACBrLibDeRETestCase;

{$R *.res}

begin
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TGuiTestRunner, TestRunner);
  Application.Run;
end.

