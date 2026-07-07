program ACBrNFSeXTestCases;

{
  Esse é um projeto de testes com a ajuda da ACBrTests.Runner.pas
  -------------------------
  Este projeto deve funcionar tanto em DUnit/DUnitX/TestInsight
  Por padrão ele irá utilizar DUnit e Interface (GUI)

  Para mudar o comportamento, adicione os seguintes "conditional defines" nas
  opções do projeto (project->options):
  * "NOGUI"       - Transforma os testes em uma aplicação CONSOLE
  * "DUNITX"      - Passa a usar a DUnitX ao invés da Dunit
  * "TESTINSIGHT" - Passa a usar o TestInsight
  * "CI"          - Caso use integração continua (por exemplo com o Continua CI ou Jenkins)
                  --/ Geralmente usado em conjunto com NOGUI
  * "FMX"         - Para usar Firemonkey (FMX) ao invés de VCL. (Testado apenas com DUnitX)

  ATENÇÃO: 1) OS defines PRECISAM estar nas opções do projeto. Não basta definir no arquivo de projeto.
           2) Faça um Build sempre que fizer alterações de Defines.
  Para mais informações veja o arquivo: ACBrTests.Runner.pas
}

{$I ACBr.inc}

{$IFDEF NOGUI}
{$APPTYPE CONSOLE}
{$ENDIF}

{$IFDEF DUNITX}
  {$STRONGLINKTYPES ON}
{$ENDIF}

{$R *.RES}

uses
  ACBrTests.Util in '..\..\ACBrTests.Util.pas',
  ACBrTests.Runner in '..\..\ACBrTests.Runner.pas',
  ACBrNFSeXTests in '..\..\FPCUnit\ACBrNFSeX\ACBrNFSeXTests.pas',
  ACBrNFSeXProvedorABRASFv1Tests in '..\..\FPCUnit\ACBrNFSeX\ACBrNFSeXProvedorABRASFv1Tests.pas',
  ACBrNFSeXProvedorABRASFv2Tests in '..\..\FPCUnit\ACBrNFSeX\ACBrNFSeXProvedorABRASFv2Tests.pas',
  ACBrNFSeXProvedorAgiliTests in '..\..\FPCUnit\ACBrNFSeX\ACBrNFSeXProvedorAgiliTests.pas',
  ACBrNFSeXProvedorAssessorPublicoTests in '..\..\FPCUnit\ACBrNFSeX\ACBrNFSeXProvedorAssessorPublicoTests.pas',
  ACBrNFSeXProvedorBauhausTests in '..\..\FPCUnit\ACBrNFSeX\ACBrNFSeXProvedorBauhausTests.pas',
  ACBrNFSeXProvedorEquiplanoTests in '..\..\FPCUnit\ACBrNFSeX\ACBrNFSeXProvedorEquiplanoTests.pas',
  ACBrNFSeXProvedorIPMTests in '..\..\FPCUnit\ACBrNFSeX\ACBrNFSeXProvedorIPMTests.pas',
  ACBrNFSeXProvedorISSBarueriTests in '..\..\FPCUnit\ACBrNFSeX\ACBrNFSeXProvedorISSBarueriTests.pas',
  ACBrNFSeXProvedorPadraoNacionalTests in '..\..\FPCUnit\ACBrNFSeX\ACBrNFSeXProvedorPadraoNacionalTests.pas',
  ACBrNFSeXProvedorSigISSTests in '..\..\FPCUnit\ACBrNFSeX\ACBrNFSeXProvedorSigISSTests.pas',
  ACBrNFSeXProvedorSigISSWebTests in '..\..\FPCUnit\ACBrNFSeX\ACBrNFSeXProvedorSigISSWebTests.pas',
  ACBrNFSeXProvedorSoftPlanTests in '..\..\FPCUnit\ACBrNFSeX\ACBrNFSeXProvedorSoftPlanTests.pas',
  ACBrNFSeXProvedorWebFiscoTests in '..\..\FPCUnit\ACBrNFSeX\ACBrNFSeXProvedorWebFiscoTests.pas',
  ACBrNFSeXRetornoSoapTests in '..\..\FPCUnit\ACBrNFSeX\ACBrNFSeXRetornoSoapTests.pas',
  ACBrTests.RunnerDelphi in '..\..\ACBrTests.RunnerDelphi.pas',
  ACBrNFSeXProviderBaseTests in '..\..\FPCUnit\ACBrNFSeX\ACBrNFSeXProviderBaseTests.pas';

begin
  ACBrRunTests;
end.
