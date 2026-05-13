{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Elton Barbosa                                   }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la }
{ sob os termos da Licença Pública Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a versão 2.1 da Licença, ou (a seu critério) }
{ qualquer versão posterior.                                                   }
{                                                                              }
{  Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU      }
{ ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENÇA.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Você deve ter recebido uma cópia da Licença Pública Geral Menor do GNU junto}
{ com esta biblioteca; se não, escreva para a Free Software Foundation, Inc.,  }
{ no endereço 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Você também pode obter uma copia da licença em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Simões de Almeida - daniel@projetoacbr.com.br - www.projetoacbr.com.br}
{       Rua Coronel Aureliano de Camargo, 963 - Tatuí - SP - 18270-170         }
{******************************************************************************}

unit ACBrTests.RunnerLaz;

(****
  Essa Unit possui métodos úteis utilizados nos Testes Unitários do ACBr.
  -------------------------
  Objetivo: facilitar a criação/manutenção dos projetos de testes.
  O método ACBrRunTests gera um executor para os testes,
    permitindo o máximo de compatibilidade entre os frameworks
    DUnitX/DUnit, FMX/VCL, CONSOLE/GUI/TestInsight
  
  Para mudar o comportamento, adicione os seguintes "conditional defines" nas
    opções do projeto (project->options):
    * "NOGUI"       - Transforma os testes em uma aplicação CONSOLE
    * "DUNITX"      - Passa a usar a DUnitX ao invés da Dunit
    * "TESTINSIGHT" - Passa a usar o TestInsight
    * "CI"          - Caso use integração continua (por exemplo com o Continua CI ou Jenkins)
                   --/ Geralmente usado em conjunto com NOGUI. Por exemplo evita uma pausa depois dos testes.
    * "FMX"         - Para usar Firemonkey (FMX) ao invés de VCL. (Testado apenas com DUnitX)

  ATENÇÃO: 1) OS defines PRECISAM estar nas opções do projeto. Não basta definir no arquivo de projeto.
           2) Faça um Build sempre que fizer alterações de Defines.
           3) No caso do Lazarus, verifique os pacotes requeridos. GUI precisa do pacote FPCUnitTestRunner

  Para um exemplo, veja as pastas modelos.

*****)

{$I ACBr.inc}

interface

uses
  //Classes,
{$IFDEF TESTINSIGHT}
  fpcunittestinsight,
{$ENDIF }

{$IFDEF NOGUI}
  //Quando LCL está nos pacotes requeridos, precisa da "Interfaces" para evitar o erro Undefined symbol: WSRegisterCustomPage
  Interfaces,
  consoletestrunner,
{$ELSE}
  Interfaces,
  Forms,
  GuiTestRunner, //Necessário adicionar o pacote como required: fpcunittestrunner
{$ENDIF }
  SysUtils;

type
  {Use para chamar a aplicação que executa os métodos de testes}

  { TACBrRunnerLaz }

  TACBrRunnerLaz = class
  public
    class procedure ACBrRunTests;
  end;

  {$IFDEF NOGUI}
  type
    { TMyTestRunner }
    TMyTestRunner = class(TTestRunner)
    protected
    // override the protected methods of TTestRunner to customize its behavior
    end;
  {$ENDIF}

implementation
  {$IFDEF NOGUI}
  var
    Application: TMyTestRunner;
  {$ENDIF}

  {$IFDEF NOGUI}
  procedure PausaSeNaoTiverCI;
  begin
    {$IFNDEF CI}
    //We don't want this happening when running under CI.
    System.Write('Pronto.. pressione <Enter> para sair.');
    System.Readln;
    {$ENDIF}
  end;
  {$ENDIF}

class procedure TACBrRunnerLaz.ACBrRunTests;
begin
{$IFDEF TESTINSIGHT}
  if IsTestInsightListening() then
    RunRegisteredTests('','');
  Exit;
{$ELSE}
  {$IFDEF NOGUI}
  DefaultRunAllTests := True;
  DefaultFormat := fPlain;
  //DefaultFormat := fXML;
  Application := TMyTestRunner.Create(nil);
  Application.Initialize;
  Application.Title := 'FPCUnit Console test runner';
  Application.Run;
  Application.Free;
  PausaSeNaoTiverCI
  {$ELSE}
  Application.Initialize;
  Application.CreateForm(TGuiTestRunner, TestRunner);
  Application.Run;
  {$ENDIF}
{$ENDIF}


end;

end.
