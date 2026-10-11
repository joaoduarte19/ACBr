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

{$I ACBr.inc}

unit ACBrLibIMendesMT;

interface

uses
  Classes, SysUtils, Forms,
  ACBrLibComum;

function IMendes_Inicializar(var libHandle: PLibHandle; const eArqConfig, eChaveCrypt: PAnsiChar): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};

function IMendes_Finalizar(libHandle: PLibHandle): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};

function IMendes_Nome(const libHandle : PLibHandle; const sNome: PAnsiChar; var esTamanho: integer): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};

function IMendes_OpenSSLInfo(const libHandle: PLibHandle; const sOpenSSLInfo: PAnsiChar; var esTamanho: integer): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};

function IMendes_Versao(const libHandle : PLibHandle; const sVersao: PAnsiChar; var esTamanho: integer): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};

function IMendes_UltimoRetorno(const libHandle : PLibHandle; const sMensagem: PAnsiChar; var esTamanho: integer): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};

function IMendes_ConfigImportar(const libHandle : PLibHandle; const eArqConfig: PAnsiChar): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};

function IMendes_ConfigExportar(const libHandle : PLibHandle; const sMensagem: PAnsiChar; var esTamanho: integer): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};

function IMendes_ConfigLer(const libHandle : PLibHandle; const eArqConfig: PAnsiChar): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};

function IMendes_ConfigGravar(const libHandle : PLibHandle; const eArqConfig: PAnsiChar): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};

function IMendes_ConfigLerValor(const libHandle : PLibHandle; const eSessao, eChave: PAnsiChar; sValor: PAnsiChar; var esTamanho: integer): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};

function IMendes_ConfigGravarValor(const libHandle : PLibHandle; const eSessao, eChave, eValor: PAnsiChar): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};

function IMendes_ConsultarDescricao(const libHandle: PLibHandle; const eDescricao, eCNPJ: PAnsiChar; nTipo: Integer; const sResposta: PAnsiChar; var esTamanho: integer): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};

function IMendes_ConsultarAlterados(const libHandle: PLibHandle; const eUF, eCNPJ: PAnsiChar; nLimite: Integer; const sResposta: PAnsiChar; var esTamanho: integer): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};

function IMendes_HistoricoAcesso(const libHandle: PLibHandle; const eCNPJ: PAnsiChar; const sResposta: PAnsiChar; var esTamanho: integer): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};

function IMendes_ConsultarRegimesEspeciais(const libHandle: PLibHandle; const eUF: PAnsiChar; bIncludeTrib: Boolean; const sResposta: PAnsiChar; var esTamanho: integer): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};

function IMendes_SaneamentoGrades(const libHandle: PLibHandle; const eArquivoOuIni: PAnsiChar; const sResposta: PAnsiChar; var esTamanho: integer): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};

function IMendes_Inativar(const libHandle: PLibHandle; const eArquivoOuIni: PAnsiChar; const sResposta: PAnsiChar; var esTamanho: integer): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};

function IMendes_RemoveDevolvidos(const libHandle: PLibHandle; const eArquivoOuIni: PAnsiChar; const sResposta: PAnsiChar; var esTamanho: integer): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};

implementation

Uses
  ACBrLibConsts, ACBrLibIMendesBase;

function IMendes_Inicializar(var libHandle: PLibHandle; const eArqConfig, eChaveCrypt: PAnsiChar): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};
begin
    Result := LIB_Inicializar(libHandle, TACBrLibIMendes, eArqConfig, eChaveCrypt);
end;

function IMendes_Finalizar(libHandle: PLibHandle): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};
begin
  Result := LIB_Finalizar(libHandle);
  libHandle := Nil;
end;

function IMendes_Nome(const libHandle: PLibHandle; const sNome: PAnsiChar; var esTamanho: integer): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};
begin
    Result := LIB_Nome(libHandle, sNome, esTamanho);
end;

function IMendes_OpenSSLInfo(const libHandle: PLibHandle; const sOpenSSLInfo: PAnsiChar; var esTamanho: integer): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};
begin
    Result := LIB_OpenSSLInfo(libHandle, sOpenSSLInfo, esTamanho);
end;

function IMendes_Versao(const libHandle: PLibHandle; const sVersao: PAnsiChar; var esTamanho: integer): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};
begin
    Result := LIB_Versao(libHandle, sVersao, esTamanho);
end;

function IMendes_UltimoRetorno(const libHandle: PLibHandle; const sMensagem: PAnsiChar; var esTamanho: integer): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};
begin
    Result := LIB_UltimoRetorno(libHandle, sMensagem, esTamanho);
end;

function IMendes_ConfigImportar(const libHandle: PLibHandle; const eArqConfig: PAnsiChar): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};
begin
    Result := LIB_ConfigImportar(libHandle, eArqConfig);
end;

function IMendes_ConfigExportar(const libHandle: PLibHandle; const sMensagem: PAnsiChar; var esTamanho: integer): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};
begin
    Result := LIB_ConfigExportar(libHandle, sMensagem, esTamanho);
end;

function IMendes_ConfigLer(const libHandle: PLibHandle; const eArqConfig: PAnsiChar): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};
begin
    Result := LIB_ConfigLer(libHandle, eArqConfig);
end;

function IMendes_ConfigGravar(const libHandle: PLibHandle; const eArqConfig: PAnsiChar): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};
begin
    Result := LIB_ConfigGravar(libHandle, eArqConfig);
end;

function IMendes_ConfigLerValor(const libHandle: PLibHandle; const eSessao, eChave: PAnsiChar; sValor: PAnsiChar; var esTamanho: integer): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};
begin
    Result := LIB_ConfigLerValor(libHandle, eSessao, eChave, sValor, esTamanho);
end;

function IMendes_ConfigGravarValor(const libHandle: PLibHandle; const eSessao, eChave, eValor: PAnsiChar): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};
begin
    Result := LIB_ConfigGravarValor(libHandle, eSessao, eChave, eValor);
end;

function IMendes_ConsultarDescricao(const libHandle: PLibHandle; const eDescricao, eCNPJ: PAnsiChar; nTipo: Integer; const sResposta: PAnsiChar; var esTamanho: integer): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};
begin
  try
    VerificarLibInicializada(libHandle);
    Result := TACBrLibIMendes(libHandle^.Lib).ConsultarDescricao(eDescricao, eCNPJ, nTipo, sResposta, esTamanho);
  except
    on E: EACBrLibException do
      Result := E.Erro;

    on E: Exception do
      Result := ErrExecutandoMetodo;
  end;
end;

function IMendes_ConsultarAlterados(const libHandle: PLibHandle; const eUF, eCNPJ: PAnsiChar; nLimite: Integer; const sResposta: PAnsiChar; var esTamanho: integer): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};
begin
  try
    VerificarLibInicializada(libHandle);
    Result := TACBrLibIMendes(libHandle^.Lib).ConsultarAlterados(eUF, eCNPJ, nLimite, sResposta, esTamanho);
  except
    on E: EACBrLibException do
      Result := E.Erro;

    on E: Exception do
      Result := ErrExecutandoMetodo;
  end;
end;

function IMendes_HistoricoAcesso(const libHandle: PLibHandle; const eCNPJ: PAnsiChar; const sResposta: PAnsiChar; var esTamanho: integer): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};
begin
  try
    VerificarLibInicializada(libHandle);
    Result := TACBrLibIMendes(libHandle^.Lib).HistoricoAcesso(eCNPJ, sResposta, esTamanho);
  except
    on E: EACBrLibException do
      Result := E.Erro;

    on E: Exception do
      Result := ErrExecutandoMetodo;
  end;
end;

function IMendes_ConsultarRegimesEspeciais(const libHandle: PLibHandle; const eUF: PAnsiChar; bIncludeTrib: Boolean; const sResposta: PAnsiChar; var esTamanho: integer): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};
begin
  try
    VerificarLibInicializada(libHandle);
    Result := TACBrLibIMendes(libHandle^.Lib).ConsultarRegimesEspeciais(eUF, bIncludeTrib, sResposta, esTamanho);
  except
    on E: EACBrLibException do
      Result := E.Erro;

    on E: Exception do
      Result := ErrExecutandoMetodo;
  end;
end;

function IMendes_SaneamentoGrades(const libHandle: PLibHandle; const eArquivoOuIni: PAnsiChar; const sResposta: PAnsiChar; var esTamanho: integer): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};
begin
  try
    VerificarLibInicializada(libHandle);
    Result := TACBrLibIMendes(libHandle^.Lib).SaneamentoGrades(eArquivoOuIni, sResposta, esTamanho);
  except
    on E: EACBrLibException do
      Result := E.Erro;

    on E: Exception do
      Result := ErrExecutandoMetodo;
  end;
end;

function IMendes_Inativar(const libHandle: PLibHandle; const eArquivoOuIni: PAnsiChar; const sResposta: PAnsiChar; var esTamanho: integer): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};
begin
  try
    VerificarLibInicializada(libHandle);
    Result := TACBrLibIMendes(libHandle^.Lib).Inativar(eArquivoOuIni, sResposta, esTamanho);
  except
    on E: EACBrLibException do
      Result := E.Erro;

    on E: Exception do
      Result := ErrExecutandoMetodo;
  end;
end;

function IMendes_RemoveDevolvidos(const libHandle: PLibHandle; const eArquivoOuIni: PAnsiChar; const sResposta: PAnsiChar; var esTamanho: integer): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};
begin
  try
    VerificarLibInicializada(libHandle);
    Result := TACBrLibIMendes(libHandle^.Lib).RemoveDevolvidos(eArquivoOuIni, sResposta, esTamanho);
  except
    on E: EACBrLibException do
      Result := E.Erro;

    on E: Exception do
      Result := ErrExecutandoMetodo;
  end;
end;

end.

