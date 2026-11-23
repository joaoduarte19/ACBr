{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Renato Rubinho                                 }
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

unit ACBrLibDeREStaticImportST;

{$IfDef FPC}
{$mode objfpc}{$H+}
{$EndIf}

{.$Define STDCALL}

interface

uses
  Classes, SysUtils;

const
 {$IfDef MSWINDOWS}
  {$IfDef CPU64}
  CACBrDeRELIBName = 'ACBrDeRE64.dll';
  {$Else}
  CACBrDeRELIBName = 'ACBrDeRE32.dll';
  {$EndIf}
 {$Else}
  {$IfDef CPU64}
  CACBrDeRELIBName = 'ACBrDeRE64.so';
  {$Else}
  CACBrDeRELIBName = 'ACBrDeRE32.so';

  {$EndIf}
 {$EndIf}

{$I ACBrLibErros.inc}

{%region Constructor/Destructor}
function DeRE_Inicializar(const eArqConfig, eChaveCrypt: PAnsiChar): integer;
  {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf}; external CACBrDeRELIBName;

function DeRE_Finalizar: integer;
  {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf}; external CACBrDeRELIBName;
{%endregion}

{%region Versao/Retorno}
function DeRE_Nome(const sNome: PAnsiChar; var esTamanho: integer): integer;
  {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf}; external CACBrDeRELIBName;

function DeRE_Versao(const sVersao: PAnsiChar; var esTamanho: integer): integer;
  {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf}; external CACBrDeRELIBName;

function DeRE_OpenSSLInfo(const sOpenSSLInfo: PAnsiChar; var esTamanho: integer): integer;
  {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf}; external CACBrDeRELIBName;

function DeRE_UltimoRetorno(const sMensagem: PAnsiChar; var esTamanho: integer): integer;
  {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf}; external CACBrDeRELIBName;
{%endregion}

{%region Ler/Gravar Config }
function DeRE_ConfigLer(const eArqConfig: PAnsiChar): integer;
  {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf}; external CACBrDeRELIBName;

function DeRE_ConfigGravar(const eArqConfig: PAnsiChar): integer;
  {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf}; external CACBrDeRELIBName;

function DeRE_ConfigLerValor(const eSessao, eChave: PAnsiChar; sValor: PAnsiChar; var esTamanho: integer): integer;
  {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf}; external CACBrDeRELIBName;

function DeRE_ConfigGravarValor(const eSessao, eChave, eValor: PAnsiChar): integer;
  {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf}; external CACBrDeRELIBName;
{%endregion}

{%region DeRE}
function DeRE_CriarEventoDeRE(const eArqIni: PAnsiChar): integer;
  {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf}; external CACBrDeRELIBName;

function DeRE_EnviarDeRE(const sResposta: PAnsiChar;
  var esTamanho: integer): integer;
  {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf}; external CACBrDeRELIBName;

function DeRE_ConsultarDeRE(const eProtocolo, sResposta: PAnsiChar; var esTamanho: integer): integer;
  {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf}; external CACBrDeRELIBName;

function DeRE_CriarEnviarDeRE(const eArqIni: PAnsiChar;
  const sResposta: PAnsiChar; var esTamanho: integer): integer;
  {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf}; external CACBrDeRELIBName;

function DeRE_LimparDeRE: integer;
  {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf}; external CACBrDeRELIBName;

function DeRE_CarregarXMLEventoDeRE (const eArquivoOuXML: PAnsiChar): integer;
  {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf}; external CACBrDeRELIBName;

function DeRE_SetIDContribuinte (const aIdContribuinte: PAnsiChar):integer;
  {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf}; external CACBrDeRELIBName;

function DeRE_SetVersaoDF (const sVersao: PAnsiChar):integer;
  {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf}; external CACBrDeRELIBName;

function DeRE_ObterCertificados (const sResposta: PAnsiChar; var esTamanho: integer):integer;
  {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf}; external CACBrDeRELIBName;

function DeRE_ObterIniEventos (const sResposta: PAnsiChar; var esTamanho: integer):integer;
  {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf}; external CACBrDeRELIBName;

function DeRE_ObterToken (const sResposta: PAnsiChar; var esTamanho: integer):integer;
  {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf}; external CACBrDeRELIBName;

function DeRE_LimparDados (const eCNPJBase, sResposta: PAnsiChar; var esTamanho: integer):integer;
  {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf}; external CACBrDeRELIBName;

function DeRE_Validar: integer;
   {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf}; external CACBrDeRELIBName;

{%endregion}

implementation

end.
