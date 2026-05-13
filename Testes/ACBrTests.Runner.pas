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

unit ACBrTests.Runner;

(****
  Essa Unit possui métodos úteis utilizados nos Testes Unitários do ACBr.
  -------------------------
  Objetivo: facilitar a criação/manutenção dos arquivos .dpr de projetos de testes.
  O método ACBrRunTests gera um executor para os testes no Delphi,
    permitindo o máximo de compatibilidade entre os frameworks
    DUnitX/DUnit, FMX/VCL, CONSOLE/GUI/TestInsight
  
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

  Para um exemplo de um arquivo .dpr usando essa unit: Veja o arquivo ModeloACBrTestsRunnerDpr.dp_

*****)

{$I ACBr.inc}

interface

uses
  {$IFDEF FPC}
  ACBrTests.RunnerLaz;
  {$ELSE}
  ACBrTests.RunnerDelphi;
  {$ENDIF}

  {Use para chamar a aplicação que executa os métodos de testes}
  procedure ACBrRunTests();
type
  {$IFDEF FPC}
  TACBrRunner = ACBrTests.RunnerLaz.TACBrRunnerLaz;
  {$ELSE}
  TACBrRunner = ACBrTests.RunnerDelphi.TACBrRunnerDelphi;
  {$ENDIF}

implementation

procedure ACBrRunTests();
begin
  TACBrRunner.ACBrRunTests();
end;

end.
