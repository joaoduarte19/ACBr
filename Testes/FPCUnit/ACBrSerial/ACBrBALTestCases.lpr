program ACBrBALTestCases;

{$mode objfpc}{$H+}

uses
  Interfaces, Forms, GuiTestRunner, ACBrBALI9ID12BTest, ACBrTests.Util;

begin
  Application.Initialize;
  Application.CreateForm(TGuiTestRunner, TestRunner);
  Application.Run;
end.
