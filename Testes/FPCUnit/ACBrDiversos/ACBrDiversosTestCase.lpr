program ACBrDiversosTestCase;

//mantenha a verificação abaixo como primeira linha.
{$IFDEF NOGUI}
{$APPTYPE CONSOLE}
{$ENDIF}

{$I ACBr.inc}

uses
  ACBrTests.Util,
  ACBrTests.Runner,
  ACBrValidadorTest;

{$R *.res}

begin
  ACBrRunTests();
end.

