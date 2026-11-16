program ACBrBALTestCases;

{$I ACBr.inc}

{$IFDEF NOGUI}
{$APPTYPE CONSOLE}
{$ENDIF}

{$IFDEF DUNITX}
  {$STRONGLINKTYPES ON}
{$ENDIF}

uses
  ACBrTests.Util in '..\..\ACBrTests.Util.pas',
  ACBrTests.Runner in '..\..\ACBrTests.Runner.pas',
  ACBrBALI9ID12BTest in '..\..\FPCUnit\ACBrSerial\ACBrBALI9ID12BTest.pas';

begin
  ACBrRunTests;
end.
