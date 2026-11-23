{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }

{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }

{ Colaboradores nesse arquivo: Renato Rubinho                                 }

{  Você pode obter a última versão desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }

{  Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la }
{ sob os termos da Licença Pública Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a versão 2.1 da Licença, ou (a seu critério) }
{ qualquer versão posterior.                                                   }

{  Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU      }
{ ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENÇA.TXT ou LICENSE.TXT)              }

{  Você deve ter recebido uma cópia da Licença Pública Geral Menor do GNU junto}
{ com esta biblioteca; se não, escreva para a Free Software Foundation, Inc.,  }
{ no endereço 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Você também pode obter uma copia da licença em:                              }
{ http://www.opensource.org/licenses/gpl-license.php                           }

{ Daniel Simões de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{        Rua Cel.Aureliano de Camargo, 973 - Tatuí - SP - 18270-170            }

{******************************************************************************}

{$I ACBr.inc}

library ACBrLibDeRE;

uses
  {$IFDEF MT}
   {$IFDEF UNIX}
    cthreads,
    cmem, // the c memory manager is on some systems much faster for multi-threading
   {$ENDIF}
  {$ENDIF}
  Interfaces, Forms,
  sysutils, Classes, ACBrLibDeREDataModule,
  {$IFDEF MT} ACBrLibDeREMT {$ELSE} ACBrLibDeREST{$ENDIF},
  ACBrLibConfig, ACBrLibResposta, ACBrLibComum, ACBrLibConsts,
  ACBrLibDataModule, ACBrLibDeREConfig, ACBrLibDeREBase;

{$R *.res}

{$IFDEF DEBUG}
var
   HeapTraceFile: String;
{$ENDIF}

exports
  // Importadas de ACBrLibComum
  DeRE_Inicializar,
  DeRE_Finalizar,
  DeRE_Nome,
  DeRE_Versao,
  DeRE_OpenSSLInfo,
  DeRE_UltimoRetorno,
  DeRE_ConfigImportar,
  DeRE_ConfigExportar,
  DeRE_ConfigLer,
  DeRE_ConfigGravar,
  DeRE_ConfigLerValor,
  DeRE_ConfigGravarValor,

  // DeRE
  DeRE_CriarEventoDeRE,
  DeRE_EnviarDeRE,
  DeRE_ConsultarDeRE,
  DeRE_CriarEnviarDeRE,
  DeRE_LimparDeRE,
  DeRE_CarregarXMLEventoDeRE,
  DeRE_ObterIniEventos,
  DeRE_ObterToken,
  DeRE_LimparDados,
  DeRE_SetIDContribuinte,
  DeRE_SetVersaoDF,
  DeRE_ObterCertificados,
  DeRE_Validar;

begin
  {$IFDEF DEBUG}
   HeapTraceFile := ExtractFilePath(ParamStr(0))+ 'heaptrclog.trc';
   DeleteFile( HeapTraceFile );
   SetHeapTraceOutput( HeapTraceFile );
  {$ENDIF}

  MainThreadID := GetCurrentThreadId();
  Application.Initialize;
end.

