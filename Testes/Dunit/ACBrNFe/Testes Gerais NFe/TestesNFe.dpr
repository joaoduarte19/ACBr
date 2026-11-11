program TestesNFe;

{ Roteiro de testes automatizados do componente TACBrNFe (DUnitX).
  Ver ROTEIRO.md para a descrição de cada fixture e caso de teste.

  Padrão: runner GRÁFICO (VCL) - selecione os testes na árvore e clique em Run.
  Console/CI: compilar com -DCONSOLE_TESTRUNNER
             bin\TestesNFe_Console.exe --exitbehavior:Continue
             bin\TestesNFe_Console.exe --run:uTestNFe03ManipulacaoXML }

{$IFDEF CONSOLE_TESTRUNNER}
  {$APPTYPE CONSOLE}
{$ENDIF}
{$STRONGLINKTYPES ON}

uses
  SysUtils,
  {$IFDEF CONSOLE_TESTRUNNER}
  DUnitX.Loggers.Console,
  DUnitX.Loggers.Xml.NUnit,
  {$ELSE}
  Vcl.Forms,
  DUnitX.Loggers.GUI.VCL,
  {$ENDIF}
  DUnitX.TestFramework,
  uXmlTesteHelpers in 'Base\uXmlTesteHelpers.pas',
  uSefazMock in 'Base\uSefazMock.pas',
  uNFeTesteBase in 'Base\uNFeTesteBase.pas',
  uTestNFe01Componente in 'Testes\uTestNFe01Componente.pas',
  uTestNFe02GeracaoXML in 'Testes\uTestNFe02GeracaoXML.pas',
  uTestNFe03ManipulacaoXML in 'Testes\uTestNFe03ManipulacaoXML.pas',
  uTestNFe04WebServices in 'Testes\uTestNFe04WebServices.pas',
  uTestNFe05Impressao in 'Testes\uTestNFe05Impressao.pas',
  uTestNFe06ProtocoloMensagem in 'Testes\uTestNFe06ProtocoloMensagem.pas',
  uRttiCobertura in 'Base\uRttiCobertura.pas',
  uTestNFe07CoberturaPropriedades in 'Testes\uTestNFe07CoberturaPropriedades.pas',
  uTestNFe08FusoHorario in 'Testes\uTestNFe08FusoHorario.pas',
  uTestConversoes in 'Testes\uTestConversoes.pas',
  uTestXmlDocument in 'Testes\uTestXmlDocument.pas',
  uTestFluxoNFe in 'Testes\uTestFluxoNFe.pas';

{$IFDEF CONSOLE_TESTRUNNER}
var
  Runner: ITestRunner;
  Results: IRunResults;
{$ENDIF}
begin
  LogLinha('### TestesNFe - ACBr: ' + DiretorioACBr + ' ###');
{$IFDEF CONSOLE_TESTRUNNER}
  try
    TDUnitX.CheckCommandLine;
    Runner := TDUnitX.CreateRunner;
    Runner.UseRTTI := True;
    Runner.FailsOnNoAsserts := False;
    Runner.AddLogger(TDUnitXConsoleLogger.Create(True));
    Runner.AddLogger(TDUnitXXMLNUnitFileLogger.Create(ChangeFileExt(ParamStr(0), '_resultado.xml')));
    Results := Runner.Execute;
    if not Results.AllPassed then
      System.ExitCode := 1;
  except
    on E: Exception do
    begin
      System.Writeln(E.ClassName, ': ', E.Message);
      System.ExitCode := 2;
    end;
  end;
{$ELSE}
  ReportMemoryLeaksOnShutdown := False;
  DUnitX.Loggers.GUI.VCL.Run;
{$ENDIF}
end.
