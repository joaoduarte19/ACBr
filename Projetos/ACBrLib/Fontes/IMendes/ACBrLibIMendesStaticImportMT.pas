{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2025 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Antonio Carlos Junior                           }
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

unit ACBrLibIMendesStaticImportMT;

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
  CACBrIMendesLIBName = 'ACBrIMendes64.dll';
  {$Else}
  CACBrIMendesLIBName = 'ACBrIMendes32.dll';
  {$EndIf}
 {$Else}
  {$IfDef CPU64}
  CACBrIMendesLIBName = 'ACBrIMendes64.so';
  {$Else}
  CACBrIMendesLIBName = 'ACBrIMendes32.so';

  {$EndIf}
 {$EndIf}

 {$I ACBrLibErros.inc}

 {%region Constructor/Destructor}
 function IMendes_Inicializar(var libHandle: TLibHandle; const eArqConfig, eChaveCrypt: PAnsiChar): integer;
  {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf}; external CACBrIMendesLIBName;

 function IMendes_Finalizar(libHandle: TLibHandle): integer;
  {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf}; external CACBrIMendesLIBName;
 {%endregion}

 {%region Versao/Retorno}
 function IMendes_Nome(const libHandle : TLibHandle; const sNome: PAnsiChar; var esTamanho: integer): integer;
  {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf}; external CACBrIMendesLIBName;

 function IMendes_OpenSSLInfo(const libHandle: TLibHandle; const sOpenSSLInfo: PAnsiChar; var esTamanho: integer): integer;
  {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf}; external CACBrIMendesLIBName;

 function IMendes_Versao(const libHandle : TLibHandle; const sVersao: PAnsiChar; var esTamanho: integer): integer;
  {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf}; external CACBrIMendesLIBName;

 function IMendes_UltimoRetorno(const libHandle : TLibHandle; const sMensagem: PAnsiChar; var esTamanho: integer): integer;
  {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf}; external CACBrIMendesLIBName;

 function IMendes_ConfigImportar(const libHandle : TLibHandle; const eArqConfig: PAnsiChar): integer;
  {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf}; external CACBrIMendesLIBName;

 function IMendes_ConfigExportar(const libHandle : TLibHandle; const sMensagem: PAnsiChar; var esTamanho: integer): integer;
  {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf}; external CACBrIMendesLIBName;
 {%endregion}

 {%region Ler/Gravar Config }
 function IMendes_ConfigLer(const libHandle : TLibHandle; const eArqConfig: PAnsiChar): integer;
  {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf}; external CACBrIMendesLIBName;

 function IMendes_ConfigGravar(const libHandle : TLibHandle; const eArqConfig: PAnsiChar): integer;
  {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf}; external CACBrIMendesLIBName;

 function IMendes_ConfigLerValor(const libHandle : TLibHandle; const eSessao, eChave: PAnsiChar; sValor: PAnsiChar; var esTamanho: integer): integer;
  {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf}; external CACBrIMendesLIBName;

 function IMendes_ConfigGravarValor(const libHandle : TLibHandle; const eSessao, eChave, eValor: PAnsiChar): integer;
  {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf}; external CACBrIMendesLIBName;
 {%endregion}

 {%region IMendes }
 function IMendes_ConsultarDescricao(const libHandle: TLibHandle; const eDescricao, eCNPJ: PAnsiChar; nTipo: Integer; const sResposta: PAnsiChar; var esTamanho: integer): integer;
  {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf}; external CACBrIMendesLIBName;

 function IMendes_ConsultarAlterados(const libHandle: TLibHandle; const eUF, eCNPJ: PAnsiChar; nLimite: Integer; const sResposta: PAnsiChar; var esTamanho: integer): integer;
  {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf}; external CACBrIMendesLIBName;

 function IMendes_HistoricoAcesso(const libHandle: TLibHandle; const eCNPJ: PAnsiChar; const sResposta: PAnsiChar; var esTamanho: integer): integer;
  {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf}; external CACBrIMendesLIBName;

 function IMendes_ConsultarRegimesEspeciais(const libHandle: TLibHandle; const eUF: PAnsiChar; bIncludeTrib: Boolean; const sResposta: PAnsiChar; var esTamanho: integer): integer;
  {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf}; external CACBrIMendesLIBName;

 function IMendes_SaneamentoGrades(const libHandle: TLibHandle; const eArquivoOuIni: PAnsiChar; const sResposta: PAnsiChar; var esTamanho: integer): integer;
  {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf}; external CACBrIMendesLIBName;

 function IMendes_Inativar(const libHandle: TLibHandle; const eArquivoOuIni: PAnsiChar; const sResposta: PAnsiChar; var esTamanho: integer): integer;
  {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf}; external CACBrIMendesLIBName;

 function IMendes_RemoveDevolvidos(const libHandle: TLibHandle; const eArquivoOuIni: PAnsiChar; const sResposta: PAnsiChar; var esTamanho: integer): integer;
  {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf}; external CACBrIMendesLIBName;
 {%endregion}

implementation

end.

