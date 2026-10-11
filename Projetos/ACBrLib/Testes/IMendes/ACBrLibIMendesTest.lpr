program ACBrLibIMendesTest;

{$mode objfpc}{$H+}

uses
  Interfaces, Forms, ACBrLibIMendesStaticImportMT, GuiTestRunner,
  ACBrLibConsts, ACBrLibIMendesTestCase;

{$R *.res}

begin
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TGuiTestRunner, TestRunner);
  Application.Run;
end.

