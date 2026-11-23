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

{$I ACBr.inc}

unit ACBrLibDeREST;

interface

uses
  Classes, SysUtils, Forms,
  ACBrLibComum;

function DeRE_Inicializar (const eArqConfig, eChaveCrypt: PAnsiChar): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};

function DeRE_Finalizar: integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};

function DeRE_Nome (const sNome: PAnsiChar; var esTamanho: integer): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};

function DeRE_Versao (const sVersao: PAnsiChar; var esTamanho: integer): integer;
  {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};

function DeRE_OpenSSLInfo(const sOpenSSLInfo: PAnsiChar; var esTamanho: integer): integer;
  {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};

function DeRE_UltimoRetorno (const sMensagem: PAnsiChar; var esTamanho: integer): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};

function DeRE_ConfigImportar (const eArqConfig: PAnsiChar): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};

function DeRE_ConfigExportar (const sMensagem: PAnsiChar; var esTamanho: integer): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};

function DeRE_ConfigLer (const eArqConfig: PAnsiChar): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};

function DeRE_ConfigGravar (const eArqConfig: PAnsiChar): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};

function DeRE_ConfigLerValor (const eSessao, eChave: PAnsiChar; sValor: PAnsiChar;
  var esTamanho: integer): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};

function DeRE_ConfigGravarValor (const eSessao, eChave, eValor: PAnsiChar): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};

function DeRE_CriarEventoDeRE (const eArqIni: PAnsiChar): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};

function DeRE_EnviarDeRE (const sResposta: PAnsiChar; var esTamanho: integer): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};

function DeRE_ConsultarDeRE (eProtocolo: PAnsiChar; const sResposta: PAnsiChar; var esTamanho: integer): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};

function DeRE_CriarEnviarDeRE (const eArqIni: PAnsiChar;
  const sResposta: PAnsiChar; var esTamanho: integer): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};

function DeRE_LimparDeRE: integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};

function DeRE_CarregarXMLEventoDeRE (const eArquivoOuXML: PAnsiChar):integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};

function DeRE_SetIDContribuinte (const aIdContribuinte: PAnsiChar):integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};

function DeRE_SetVersaoDF (const sVersao: PAnsiChar):integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};

function DeRE_ObterCertificados(const sResposta: PAnsiChar; var esTamanho: integer): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};

function DeRE_ObterIniEventos(const sResposta: PAnsiChar; var esTamanho: integer): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};

function DeRE_ObterToken(const sResposta: PAnsiChar; var esTamanho: integer): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};

function DeRE_LimparDados(eCNPJBase: PAnsiChar; const sResposta: PAnsiChar; var esTamanho: integer): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};

function DeRE_Validar: integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};

implementation

Uses
  ACBrLibConsts, ACBrLibDeREBase;

function DeRE_Inicializar(const eArqConfig, eChaveCrypt: PAnsiChar): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};
begin
  Result := LIB_Inicializar(pLib, TACBrLibDeRE, eArqConfig, eChaveCrypt);
end;

function DeRE_Finalizar: integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};
begin
  Result := LIB_Finalizar(pLib);
  pLib := Nil;
end;

function DeRE_Nome(const sNome: PAnsiChar; var esTamanho: integer): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};
begin
  Result := LIB_Nome(pLib, sNome, esTamanho);
end;

function DeRE_Versao(const sVersao: PAnsiChar; var esTamanho: integer): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};
begin
  Result := LIB_Versao(pLib, sVersao, esTamanho);
end;

function DeRE_OpenSSLInfo(const sOpenSSLInfo: PAnsiChar; var esTamanho: integer): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};
begin
  Result := LIB_OpenSSLInfo(pLib, sOpenSSLInfo, esTamanho);
end;

function DeRE_UltimoRetorno(const sMensagem: PAnsiChar; var esTamanho: integer): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};
begin
  Result := LIB_UltimoRetorno(pLib, sMensagem, esTamanho);
end;

function DeRE_ConfigImportar(const eArqConfig: PAnsiChar): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};
begin
  Result := LIB_ConfigImportar(pLib, eArqConfig);
end;

function DeRE_ConfigExportar(const sMensagem: PAnsiChar; var esTamanho: integer
  ): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};
begin
  Result := LIB_ConfigExportar(pLib, sMensagem, esTamanho);
end;

function DeRE_ConfigLer(const eArqConfig: PAnsiChar): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};
begin
  Result := LIB_ConfigLer(pLib, eArqConfig);
end;

function DeRE_ConfigGravar(const eArqConfig: PAnsiChar): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};
begin
  Result := LIB_ConfigGravar(pLib, eArqConfig);
end;

function DeRE_ConfigLerValor(const eSessao, eChave: PAnsiChar; sValor: PAnsiChar;
  var esTamanho: integer): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};
begin
  Result := LIB_ConfigLerValor(pLib, eSessao, eChave, sValor, esTamanho);
end;

function DeRE_ConfigGravarValor(const eSessao, eChave, eValor: PAnsiChar): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};
begin
  Result := LIB_ConfigGravarValor(pLib, eSessao, eChave, eValor);
end;

function DeRE_CriarEventoDeRE(const eArqIni: PAnsiChar): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};
begin
  try
  VerificarLibInicializada(pLib);
  Result := TACBrLibDeRE(pLib^.Lib).CriarEventoDeRE(eArqIni);
  except
  on E: EACBrLibException do
     Result := E.Erro;

  on E: Exception do
     Result := ErrExecutandoMetodo;
  end;
end;

function DeRE_EnviarDeRE(const sResposta: PAnsiChar; var esTamanho: integer
  ): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};
begin
  try
   VerificarLibInicializada(pLib);
   Result := TACBrLibDeRE(pLib^.Lib).EnviarDeRE(sResposta, esTamanho);
  except
   on E: EACBrLibException do
    Result := E.Erro;

   on E: Exception do
    Result := ErrExecutandoMetodo;
  end;
end;

function DeRE_ConsultarDeRE(eProtocolo: PAnsiChar; const sResposta: PAnsiChar;
  var esTamanho: integer): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};
begin
  try
   VerificarLibInicializada(pLib);
   Result := TACBrLibDeRE(pLib^.Lib).ConsultarDeRE(eProtocolo, sResposta, esTamanho);
  except
   on E: EACBrLibException do
    Result := E.Erro;

   on E: Exception do
    Result := ErrExecutandoMetodo;
  end;
end;

function DeRE_CriarEnviarDeRE (const eArqIni: PAnsiChar;
  const sResposta: PAnsiChar; var esTamanho: integer): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};
begin
  try
    VerificarLibInicializada(pLib);
    Result := TACBrLibDeRE(pLib^.Lib).CriarEnviarDeRE(eArqIni, sResposta, esTamanho);
  except
   on E: EACBrLibException do
    Result := E.Erro;

   on E: Exception do
    Result := ErrExecutandoMetodo;
  end;
end;

function DeRE_LimparDeRE: integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};
begin
  try
   VerificarLibInicializada(pLib);
   Result := TACBrLibDeRE(pLib^.Lib).LimparDeRE;
  except
   on E: EACBrLibException do
    Result := E.Erro;

   on E: Exception do
    Result := ErrExecutandoMetodo;
  end;
end;

function DeRE_CarregarXMLEventoDeRE (const eArquivoOuXML: PAnsiChar):integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};
begin
  try
   VerificarLibInicializada(pLib);
   Result := TACBrLibDeRE(pLib^.Lib).CarregarXMLEventoDeRE(eArquivoOuXML);
  except
   on E: EACBrLibException do
    Result := E.Erro;

   on E: Exception do
    Result := ErrExecutandoMetodo;
  end;
end;

function DeRE_SetIDContribuinte (const aIdContribuinte: PAnsiChar):integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};
begin
  try
   VerificarLibInicializada(pLib);
   Result := TACBrLibDeRE(pLib^.Lib).SetIDContribuinte(aIdContribuinte);
  except
   on E: EACBrLibException do
    Result := E.Erro;

   on E: Exception do
    Result := ErrExecutandoMetodo;
  end;
end;

function DeRE_SetVersaoDF (const sVersao: PAnsiChar):integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};
begin
  try
   VerificarLibInicializada(pLib);
   Result := TACBrLibDeRE(pLib^.Lib).SetVersaoDF(sVersao);
  except
   on E: EACBrLibException do
   Result := E.Erro;

   on E: Exception do
   Result := ErrExecutandoMetodo;
  end;
end;

function DeRE_ObterCertificados (const sResposta: PAnsiChar; var esTamanho: integer):integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};
begin
  try
    VerificarLibInicializada(pLib);
    Result := TACBrLibDeRE(pLib^.Lib).ObterCertificados(sResposta, esTamanho);
  except
    on E: EACBrLibException do
     Result := E.Erro;

    on E: Exception do
      Result := ErrExecutandoMetodo;
  end;
end;

function DeRE_LimparDados(eCNPJBase: PAnsiChar; const sResposta: PAnsiChar; var esTamanho: integer): integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};
begin
  try
    VerificarLibInicializada(pLib);
    Result := TACBrLibDeRE(pLib^.Lib).LimparDados(eCNPJBase, sResposta, esTamanho);
  except
    on E: EACBrLibException do
     Result := E.Erro;

    on E: Exception do
      Result := ErrExecutandoMetodo;
  end;
end;

function DeRE_ObterIniEventos (const sResposta: PAnsiChar; var esTamanho: integer):integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};
begin
  try
    VerificarLibInicializada(pLib);
    Result := TACBrLibDeRE(pLib^.Lib).ObterIniEventos(sResposta, esTamanho);
  except
    on E: EACBrLibException do
     Result := E.Erro;

    on E: Exception do
      Result := ErrExecutandoMetodo;
  end;
end;

function DeRE_ObterToken (const sResposta: PAnsiChar; var esTamanho: integer):integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};
begin
  try
    VerificarLibInicializada(pLib);
    Result := TACBrLibDeRE(pLib^.Lib).ObterToken(sResposta, esTamanho);
  except
    on E: EACBrLibException do
     Result := E.Erro;

    on E: Exception do
      Result := ErrExecutandoMetodo;
  end;
end;

function DeRE_Validar: integer;
 {$IfDef STDCALL} stdcall{$Else} cdecl{$EndIf};
begin
  try
    VerificarLibInicializada(pLib);
    Result := TACBrLibDeRE(pLib^.Lib).Validar;
  except
    on E: EACBrLibException do
     Result := E.Erro;

    on E: Exception do
      Result := ErrExecutandoMetodo;
  end;
end;

end.

