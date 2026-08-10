{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }

{ Direitos Autorais Reservados (c) 2024 Daniel Simoes de Almeida               }

{ Colaboradores nesse arquivo: Rafael Teno Dias                                }

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
{ http://www.opensource.org/licenses/lgpl-license.php                          }

{ Daniel Simões de Almeida - daniel@projetoacbr.com.br - www.projetoacbr.com.br}
{       Rua Coronel Aureliano de Camargo, 963 - Tatuí - SP - 18270-170         }
{******************************************************************************}

{$I ACBr.inc}

unit ACBrLibComum;

interface

uses
  Classes,
  SysUtils,
  ACBrBase,
  {$IfDef FPC}
   fileinfo,
  {$EndIf}
  ACBrUtil.FilesIO,
  {$IFDEF Demo}
   ACBrLibDemo,
  {$ENDIF}
  ACBrLibConfig;

type

  { EACBrLibException }
  EACBrLibException = class(Exception)
  private
    FErro: integer;
  public
    constructor Create(const err: integer; const msg: string); reintroduce;

    property Erro: integer read FErro;
  end;

  { TLibRetorno }
  TLibRetorno = record
    Codigo: integer;
    Mensagem: string;
  end;

  { TACBrLib }
  TACBrLib = class
  private
    FLogNome: string;
    FLogData: TDate;
    FNome: string;
    FOpenSSLInfo: string;
    FDescricao: string;
    FVersao: string;
    FTraduzirUltimoRetorno: boolean;

    function GetOpenSSLInfo: string;
    function GetNome: string;
    function GetDescricao: string;
    function GetVersao: string;
    function GetInformacaoAdicional: string;

  protected
    fpConfig: TLibConfig;
    fpLibRetorno: TLibRetorno;
    {$IfDef FPC}
    fpFileVerInfo: TFileVersionInfo;  // Informações da Aplicação e Versão, definida em Opções do Projeto
    {$EndIf}

    procedure Inicializar; virtual;
    procedure CriarConfiguracao(ArqConfig: string = '';
      ChaveCrypt: ansistring = ''); virtual;
    procedure Executar; virtual;
    procedure Finalizar; virtual;

    function CalcularNomeArqLog: string; virtual;
  public
    constructor Create(ArqConfig: string = ''; ChaveCrypt: ansistring = ''); virtual;
    destructor Destroy; override;

    property Config: TLibConfig read fpConfig;
    property Retorno: TLibRetorno read fpLibRetorno;

    property Nome: string read GetNome;
    property Versao: string read GetVersao;
    property informacaoAdicional: string read GetInformacaoAdicional;
    property OpenSSLInfo: string read GetOpenSSLInfo;
    property Descricao: string read GetDescricao;
    property TraduzirUltimoRetorno: boolean
      read FTraduzirUltimoRetorno write FTraduzirUltimoRetorno;

    procedure GravarLog(const AMsg: string; NivelLog: TNivelLog;
      Traduzir: boolean = False);
    procedure MoverStringParaPChar(const AString: ansistring;
      sDest: pansichar; var esTamanho: integer);

    function SetRetorno(const ACodigo: integer; const AMensagem: string = ''): integer;
    function ConverterStringEntrada(AData: ansistring): ansistring;
    function ConverterStringSaida(AData: ansistring): ansistring;

    function ObterNome(const sNome: pansichar; var esTamanho: integer): integer;
    function ObterVersao(const sVersao: pansichar; var esTamanho: integer): integer;
    function ObterOpenSSLInfo(const sOpenSSLInfo: pansichar;
      var esTamanho: integer): integer;
    function UltimoRetorno(const sMensagem: pansichar; var esTamanho: integer): integer;

    function ImportarConfig(const eArqConfig: pansichar): integer;
    function ExportarConfig(sValor: pansichar; var esTamanho: integer): integer;
    function ConfigLer(const eArqConfig: pansichar): integer;

    function ConfigGravar(const eArqConfig: pansichar): integer;
    function ConfigLerValor(const eSessao, eChave: pansichar;
      sValor: pansichar; var esTamanho: integer): integer;
    function ConfigGravarValor(const eSessao, eChave, eValor: pansichar): integer;
  end;

  { TACBrLibHandle }
  TACBrLibHandle = record
    Lib: TACBrLib;
  end;

  TACBrLibClass = class of TACBrLib;
  PLibHandle = ^TACBrLibHandle;

  {%region Declaração da funções externas}

{%region Constructor/Destructor}
function LIB_Inicializar(var libHandle: PLibHandle; pLibClass: TACBrLibClass;
  const eArqConfig, eChaveCrypt: pansichar): integer;
function LIB_Finalizar(libHandle: PLibHandle): integer;
function LIB_Finalizar_Liberar(var libHandle: PLibHandle): integer;
function LIB_Inicalizada(const libHandle: PLibHandle): boolean;
{%endregion}

{%region Versao/Retorno}
function LIB_Nome(const libHandle: PLibHandle; const sNome: pansichar;
  var esTamanho: integer): integer;
function LIB_Versao(const libHandle: PLibHandle; const sVersao: pansichar;
  var esTamanho: integer): integer;
function LIB_OpenSSLInfo(const libHandle: PLibHandle; const sOpenSSLInfo: pansichar;
  var esTamanho: integer): integer;
function LIB_UltimoRetorno(const libHandle: PLibHandle; const sMensagem: pansichar;
  var esTamanho: integer): integer;
{%endregion}

{%region Ler/Gravar Config }
function LIB_ConfigImportar(const libHandle: PLibHandle;
  const eArqConfig: pansichar): integer;
function LIB_ConfigExportar(const libHandle: PLibHandle;
  const sMensagem: pansichar; var esTamanho: integer): integer;
function LIB_ConfigLer(const libHandle: PLibHandle;
  const eArqConfig: pansichar): integer;
function LIB_ConfigGravar(const libHandle: PLibHandle;
  const eArqConfig: pansichar): integer;
function LIB_ConfigLerValor(const libHandle: PLibHandle;
  const eSessao, eChave: pansichar; sValor: pansichar; var esTamanho: integer): integer;
function LIB_ConfigGravarValor(const libHandle: PLibHandle;
  const eSessao, eChave, eValor: pansichar): integer;
{%endregion}

{%endregion}

{%region Funcoes auxiliares para Funcionamento da Lib}
procedure VerificarLibInicializada(const libHandle: PLibHandle);
procedure VerificarArquivoExiste(const NomeArquivo: string);
procedure LiberarLib(libHandle: PLibHandle);
{%endregion}

{%region Funcoes auxiliares Diversas }
// Le um arquivo em Disco e retorna o seu conteúdo //
function LerArquivoParaString(AArquivo: string): ansistring;

function StringToB64Crypt(AString: ansistring; AChave: ansistring = ''): string;
function B64CryptToString(ABase64Str: string; AChave: ansistring = ''): ansistring;

function StreamToBase64(AStream: TStream): ansistring;

function StringEhXML(AString: string): boolean;
function StringEhINI(AString: string): boolean;
function StringEhArquivo(AString: string): boolean;
function ConverterStringEntradaParaNativa(AData: ansistring;
  CodificacaoEntrada: TACBrLibCodificacao): ansistring;
function ConverterStringNativaParaSaida(AData: ansistring;
  CodificacaoSaida: TACBrLibCodificacao): ansistring;

// Métodos de diagnóstico da lib
// funções para obter informacoes da lib independente de TACBrLIB
// as informações retornadas por essas funções são baseadas nas diretivas de compilação!
function ObterArquiteturaProcessador(): string;
function ObterConvencaoDeChamada(): string;
function ObterInformacoesSistemaOperacional(): string;
function ObterInformacoesDeThreads(): string;
function ObterInformacoesDeAmbienteGrafico(): string;
{%endregion}

{$IFNDEF MT}
var
  pLib: PLibHandle;
{$ENDIF}
  {$IFDEF Demo}
var
  FPDemo: TACBrDemoHelper;
  {$ENDIF}

implementation

uses
  StrUtils, Math,
  {$IfDef FPC}
   strings,
  {$Else}
  System.AnsiStrings,
  {$EndIf}
  synacode, synautil,
  OpenSSLExt,
  ACBrConsts, ACBrUtil.Base, ACBrUtil.DateTime, ACBrUtil.Strings,
  ACBrLibConsts, ACBrLibResposta;

  { EACBrLibException }

constructor EACBrLibException.Create(const err: integer; const msg: string);
begin
  FErro := err;
  inherited Create(msg);
end;

{%endregion}

{ TACBrLib }

constructor TACBrLib.Create(ArqConfig: string; ChaveCrypt: ansistring);
begin
  inherited Create;

  FLogData := -1;
  FLogNome := '';
  FNome := '';
  FVersao := '';
  FDescricao := '';
  FTraduzirUltimoRetorno := True;
  FOpenSSLInfo := '';

  {$IfDef FPC}
  fpFileVerInfo := TFileVersionInfo.Create(Nil);
  fpFileVerInfo.ReadFileInfo;
  {$EndIf}

  FormatSettings.ShortDateFormat := 'dd/mm/yyyy';
  FormatSettings.LongTimeFormat := 'hh:nn:ss';
  FormatSettings.DateSeparator := '/';
  FormatSettings.TimeSeparator := ':';
  FormatSettings.DecimalSeparator := ',';
  FormatSettings.ThousandSeparator := '.';

  {$IFDEF Demo}
  if not Assigned(FPDemo) then
    FPDemo := TACBrDemoHelper.Create;
  {$ENDIF}

  CriarConfiguracao(ArqConfig, ChaveCrypt);
end;

destructor TACBrLib.Destroy;
begin
  GravarLog('TACBrLib.Destroy', logSimples);

  {$IfDef FPC}
  fpFileVerInfo.Free;
  {$EndIf}
  Finalizar;
  inherited Destroy;
end;

function TACBrLib.GetVersao: string;
begin
  if (FVersao = '') then
  begin
    {$IfDef FPC}
    if Assigned(fpFileVerInfo) then
      FVersao := fpFileVerInfo.VersionStrings.Values['FileVersion'];
    {$Else}
    {$IfDef MSWINDOWS}
    FVersao := ACBrUtil.FilesIO.GetFileVersion(ParamStr(0));
    {$EndIf}
  {$EndIf}
  end;

  Result := FVersao;
end;

function TACBrLib.GetInformacaoAdicional: string;
begin
  Result :=
    ObterInformacoesSistemaOperacional() + '/' + ObterArquiteturaProcessador() +
    ' - ' + ObterInformacoesDeAmbienteGrafico() + ' ' +
    ObterInformacoesDeThreads() + ' ' + ObterConvencaoDeChamada();
end;

function TACBrLib.GetNome: string;
begin
  if (FNome = '') then
  begin
    {$IfDef FPC}
    if Assigned(fpFileVerInfo) then
      FNome := fpFileVerInfo.VersionStrings.Values['InternalName'];
  {$EndIf}

    if (FNome = '') then
    begin
      FNome := Self.ClassName;
      if copy(FNome, 1, 1) = 'T' then
        Delete(FNome, 1, 1);
    end;

    {$IFDEF Demo}
    FNome := FNome + ' Demo';
  {$ENDIF}
  end;

  Result := FNome;
end;

function TACBrLib.GetOpenSSLInfo: string;
begin
  GravarLog('GetOpenSSLInfo', logCompleto);
  if (FOpenSSLInfo = '') then
  begin
    FOpenSSLInfo := 'OpenSSLVersion: ' + OpenSSLExt.OpenSSLVersion(0) +
      sLineBreak + 'OpenSSLFullVersion: ' + OpenSSLExt.OpenSSLFullVersion +
      sLineBreak + 'SSLUtilFile: ' + OpenSSLExt.SSLUtilFile +
      sLineBreak + 'SSLLibFile: ' + OpenSSLExt.SSLLibFile;
  end;

  Result := FOpenSSLInfo;
end;

function TACBrLib.GetDescricao: string;
begin
  if (FDescricao = '') then
  begin
    {$IfDef FPC}
    if Assigned(fpFileVerInfo) then
      FDescricao := fpFileVerInfo.VersionStrings.Values['FileDescription'];
  {$EndIf}

    if (FDescricao = '') then
      FDescricao := GetNome;
  end;

  Result := FDescricao;
end;

procedure TACBrLib.Inicializar;
begin
  FLogData := 0;
  FLogNome := '';

  Config.Ler;
end;

procedure TACBrLib.Finalizar;
begin
  GravarLog('Finalizar', logCompleto);
  FreeAndNil(fpConfig);
end;

procedure TACBrLib.CriarConfiguracao(ArqConfig: string; ChaveCrypt: ansistring);
begin
  fpConfig := TLibConfig.Create(Self, ConverterStringEntrada(ArqConfig),
    ConverterStringEntrada(ChaveCrypt));
end;

procedure TACBrLib.Executar;
begin
  GravarLog('Executar', logCompleto);
end;

function TACBrLib.CalcularNomeArqLog: string;
var
  APath: string;
begin
  if (Date <> FLogData) then  // Mudou de dia ? Se SIM, Recalcule o nome do Log
  begin
    FLogData := Date;
    APath := PathWithDelim(fpConfig.Log.Path);
    if NaoEstaVazio(APath) then
    begin
      if (not DirectoryExists(APath)) then
        raise EACBrLibException.Create(ErrDiretorioNaoExiste,
          Format(SErrDiretorioInvalido, [APath]));
    end
    else
    begin
      {$IfDef ANDROID}
       APath := PathWithDelim(ExtractFilePath(fpConfig.NomeArquivo));
  {$Else}
      APath := ApplicationPath;
  {$EndIf}
    end;

    FLogNome := APath + Self.Nome + '-' + DtoS(FLogData) + '.log';
  end;

  Result := FLogNome;
end;

procedure TACBrLib.GravarLog(const AMsg: string; NivelLog: TNivelLog;
  Traduzir: boolean);
var
  NomeArq, s: string;
begin
  if (FLogData < 0) or (Self.Nome = '') or (not Assigned(fpConfig)) or
    (NivelLog > fpConfig.Log.Nivel) then
    Exit;

  s := FormatDateTime('dd/mm/yy hh:nn:ss:zzz', now)
    {$IFDEF MT}
 + ' - ThreadID = ' +  IntToHex(GetThreadID,0) + ' , Handle = ' + IntToHex(PtrUInt(self),0)
  {$ENDIF}
    + ' - ' + AMsg;
  {$IfDef ANDROID}
{$IfDef FPC}
   SysLogWrite(DefaultSysLogPriority, PAnsiChar(Self.Nome), PAnsiChar(s));      // Write a message to the Android system log.
  {$EndIf}
  {$EndIf}

  NomeArq := CalcularNomeArqLog;
  WriteLog(NomeArq, s, Traduzir);
end;

procedure TACBrLib.MoverStringParaPChar(const AString: ansistring;
  sDest: pansichar; var esTamanho: integer);
var
  AStringLen: integer;
begin
  {$IFDEF Demo}
  if FPDemo.EstaExpirado and not (AString = Format(SErroDemoExpirado, [Nome])) then
    raise EACBrLibException.Create(ErrDemoExpirado, Format(SErroDemoExpirado, [Nome]));
  {$ENDIF}

  AStringLen := Length(AString);
  if Config.Log.Nivel >= logParanoico then
    GravarLog('   MoverStringParaPChar. StrLen:' + IntToStr(AStringLen) +
      ', BufLen:' + IntToStr(esTamanho), logParanoico);

  if (esTamanho <= 0) then
    esTamanho := AStringLen
  else
  begin
    if (AStringLen > 0) then
      {$IfNDef FPC}
      System.AnsiStrings.
  {$Else}
SysUtils.
  {$EndIf}
        StrLCopy(sDest, pansichar(AString), esTamanho)
    else
      sDest := nil;

    esTamanho := AStringLen;
  end;
end;

function TACBrLib.SetRetorno(const ACodigo: integer;
  const AMensagem: string = ''): integer;
begin
  Result := ACodigo;
  with fpLibRetorno do
  begin
    Codigo := ACodigo;
    Mensagem := AMensagem;
  end;

  GravarLog('   SetRetorno(' + IntToStr(Retorno.Codigo) + ', ' +
    Retorno.Mensagem + ')', logParanoico);
end;

function TACBrLib.ConverterStringEntrada(AData: ansistring): ansistring;
begin
  Result := ConverterStringEntradaParaNativa(AData, Config.CodResposta);
  if Config.Log.Nivel >= logParanoico then
    if (Result <> AData) then
      GravarLog('   ConverterStringEntrada: ' + AData + ' -> ' +
        Result, logParanoico, True);
end;

function TACBrLib.ConverterStringSaida(AData: ansistring): ansistring;
begin
  Result := ConverterStringNativaParaSaida(AData, Config.CodResposta);
  if Config.Log.Nivel >= logParanoico then
    if (Result <> AData) then
      GravarLog('   ConverterStringSaida: ' + AData + ' -> ' + Result,
        logParanoico, True);
end;

function TACBrLib.ObterNome(const sNome: pansichar; var esTamanho: integer): integer;
var
  Ret: ansistring;
begin
  try
    GravarLog('LIB_Nome', logNormal);
    Ret := ConverterStringSaida(Nome);
    MoverStringParaPChar(Ret, sNome, esTamanho);
    if Config.Log.Nivel >= logCompleto then
      GravarLog('   Nome:' + string(sNome) + ', len:' + IntToStr(esTamanho),
        logCompleto, True);
    Result := SetRetorno(ErrOK, Nome);
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, E.Message);

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, E.Message);
  end;
end;

function TACBrLib.ObterVersao(const sVersao: pansichar; var esTamanho: integer): integer;
var
  Ret: ansistring;
begin
  try
    GravarLog('LIB_Versao', logNormal);
    Ret := ConverterStringSaida(Versao);
    MoverStringParaPChar(Ret, sVersao, esTamanho);
    if Config.Log.Nivel >= logCompleto then
      GravarLog('   Versao:' + string(sVersao) + ', len:' + IntToStr(esTamanho),
        logCompleto, True);
    Result := SetRetorno(ErrOK, Versao);
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, E.Message);

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, E.Message);
  end;
end;

function TACBrLib.ObterOpenSSLInfo(const sOpenSSLInfo: pansichar;
  var esTamanho: integer): integer;
var
  Ret: ansistring;
begin
  try
    GravarLog('LIB_OpenSSLInfo', logNormal);
    Ret := ConverterStringSaida(OpenSSLInfo);
    MoverStringParaPChar(Ret, sOpenSSLInfo, esTamanho);
    if Config.Log.Nivel >= logCompleto then
      GravarLog('   OpenSSLInfo:' + string(sOpenSSLInfo) + ', len:' +
        IntToStr(esTamanho), logCompleto, True);
    Result := SetRetorno(ErrOK, OpenSSLInfo);
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, E.Message);

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, E.Message);
  end;
end;

function TACBrLib.UltimoRetorno(const sMensagem: pansichar;
  var esTamanho: integer): integer;
var
  Ret: ansistring;
begin
  try
    GravarLog('LIB_UltimoRetorno', logNormal);
    Ret := ConverterStringSaida(Retorno.Mensagem);
    MoverStringParaPChar(Ret, sMensagem, esTamanho);
    Result := Retorno.Codigo;
    if (Config.Log.Nivel >= logCompleto) then
      GravarLog('   Codigo:' + IntToStr(Result) + ', Mensagem:' +
        string(sMensagem), logCompleto, TraduzirUltimoRetorno);
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, E.Message);

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, E.Message);
  end;
end;

function TACBrLib.ImportarConfig(const eArqConfig: pansichar): integer;
var
  ArqConfig: string;
begin
  ArqConfig := ConverterStringEntrada(eArqConfig);
  try
    GravarLog('LIB_ImportarConfig(' + ArqConfig + ')', logNormal);

    if NaoEstaVazio(ArqConfig) then
      Config.Importar(ArqConfig);

    Result := SetRetorno(ErrOK);
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, E.Message);

    on E: Exception do
      Result := SetRetorno(ErrConfigLer, E.Message);
  end;

end;

function TACBrLib.ExportarConfig(sValor: pansichar; var esTamanho: integer): integer;
var
  Ret: ansistring;
begin
  try
    GravarLog('LIB_ExportarConfig', logNormal);
    Ret := ConverterStringSaida(Config.Exportar);
    MoverStringParaPChar(Ret, sValor, esTamanho);
    Result := SetRetorno(ErrOK, Ret);
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, E.Message);

    on E: Exception do
      Result := SetRetorno(ErrConfigLer, E.Message);
  end;
end;

function TACBrLib.ConfigLer(const eArqConfig: pansichar): integer;
var
  ArqConfigOuIni: string;
begin
  try
    ArqConfigOuIni := ConverterStringEntrada(eArqConfig);
    GravarLog('LIB_ConfigLer(' + IfThen(Config.EhMemory, CLibMemory, ArqConfigOuIni) +
      ')', logNormal);
    if Config.EhMemory then
      GravarLog('   Memory: Configuração em memória favor usar o método ImportarConfig)', logNormal);

    if not Config.EhMemory then
    begin
      if NaoEstaVazio(ArqConfigOuIni) then
        Config.NomeArquivo := ArqConfigOuIni;

      Config.Ler;
    end;

    Result := SetRetorno(ErrOK);
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, E.Message);

    on E: Exception do
      Result := SetRetorno(ErrConfigLer, E.Message);
  end;
end;

function TACBrLib.ConfigGravar(const eArqConfig: pansichar): integer;
var
  ArqConfig: string;
begin
  try
    ArqConfig := ConverterStringEntrada(eArqConfig);
    GravarLog('LIB_ConfigGravar(' + IfThen(Config.EhMemory, CLibMemory, eArqConfig) +
      ')', logNormal);
    if Config.EhMemory then
      GravarLog('   Memory: Configuração em memória favor usar o método ExportarConfig)', logNormal);

    if not Config.EhMemory then
    begin
      if NaoEstaVazio(ArqConfig) then
        Config.NomeArquivo := ArqConfig;

      Config.Gravar;
    end;

    Result := SetRetorno(ErrOK);
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, E.Message);

    on E: Exception do
      Result := SetRetorno(ErrConfigGravar, E.Message);
  end;
end;

function TACBrLib.ConfigLerValor(const eSessao, eChave: pansichar;
  sValor: pansichar; var esTamanho: integer): integer;
var
  Sessao, Chave, Valor: ansistring;
begin
  try
    Sessao := ConverterStringEntrada(eSessao);
    Chave := ConverterStringEntrada(eChave);
    GravarLog('LIB_ConfigLerValor(' + Sessao + ', ' + Chave + ')', logNormal);

    Valor := Config.LerValor(Sessao, Chave);
    MoverStringParaPChar(Valor, sValor, esTamanho);

    if (Config.Log.Nivel >= logCompleto) then
      GravarLog('   Valor:' + IfThen(Config.PrecisaCriptografar(Sessao, Chave),
        StringOfChar('*', esTamanho), sValor) + ', len:' +
        IntToStr(esTamanho), logCompleto, True);

    Result := SetRetorno(ErrOK, Valor);
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, E.Message);

    on E: Exception do
      Result := SetRetorno(ErrConfigLer, E.Message);
  end;
end;

function TACBrLib.ConfigGravarValor(const eSessao, eChave, eValor: pansichar): integer;
var
  Sessao, Chave, Valor: ansistring;
begin
  try
    Sessao := ConverterStringEntrada(eSessao);
    Chave := ConverterStringEntrada(eChave);
    Valor := ConverterStringEntrada(eValor);
    GravarLog('LIB_ConfigGravarValor(' + Sessao + ', ' + Chave +
      ', ' + IfThen(Config.PrecisaCriptografar(Sessao, Chave),
      StringOfChar('*', Length(Valor)), Valor) + ')', logNormal);

    Config.GravarValor(Sessao, Chave, Valor);
    Result := SetRetorno(ErrOK);
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, E.Message);

    on E: Exception do
      Result := SetRetorno(ErrConfigGravar, E.Message);
  end;
end;

{%region Constructor/Destructor}

function LIB_Inicializar(var libHandle: PLibHandle; pLibClass: TACBrLibClass;
  const eArqConfig, eChaveCrypt: pansichar): integer;
var
  ltmpHandle: PLibHandle;
  ArqConfig, ChaveCrypt, infoAdicional: ansistring;
begin
  ltmpHandle := nil;
  try
    ArqConfig := ansistring(eArqConfig);
    ChaveCrypt := ansistring(eChaveCrypt);

    New(ltmpHandle);
    ltmpHandle^.Lib := nil;
    ltmpHandle^.Lib := pLibClass.Create(ArqConfig, eChaveCrypt);
    ltmpHandle^.Lib.Inicializar;
    ltmpHandle^.Lib.GravarLog('LIB_Inicializar( ' +
      IfThen(ltmpHandle^.Lib.Config.EhMemory, CLibMemory,
      ltmpHandle^.Lib.Config.NomeArquivo) + ',  *** ) ', logSimples);
    ltmpHandle^.Lib.GravarLog('   ' + ltmpHandle^.Lib.Nome + ' - ' +
      ltmpHandle^.Lib.Versao + ' - ' + ltmpHandle^.Lib.informacaoAdicional, logSimples);

    with ltmpHandle^.Lib.fpLibRetorno do
    begin
      Codigo := 0;
      Mensagem := '';
    end;

    libHandle := ltmpHandle;
    Result := 0;
  except

    on E: EACBrLibException do
    begin
      Result := E.Erro;
      LiberarLib(ltmpHandle);
      ltmpHandle := nil;
    end;


    on E: EACBrConversaoEnumeradoException do
    begin
      Result := ErrConfigLer;
      LiberarLib(ltmpHandle);
      ltmpHandle := nil;
    end;

    on E: Exception do
    begin
      Result := ErrLibNaoInicializada;
      LiberarLib(ltmpHandle);
      ltmpHandle := nil;
    end
  end;
end;

function LIB_Finalizar(libHandle: PLibHandle): integer;
begin
  try
    LiberarLib(libHandle);
    Result := 0;
  except
    on E: EACBrLibException do
      Result := libHandle^.Lib.SetRetorno(E.Erro, E.Message);

    on E: Exception do
      Result := libHandle^.Lib.SetRetorno(ErrLibNaoFinalizada, E.Message);
  end;
end;

function LIB_Finalizar_Liberar(var libHandle: PLibHandle): integer;
begin
  Result := 0;
  if Assigned(libHandle) then
  begin
    Result := LIB_Finalizar(libHandle);
    libHandle := nil;
  end;
end;

function LIB_Inicalizada(const libHandle: PLibHandle): boolean;
begin
  Result := (libHandle <> nil);
end;

{%endregion}

{%region Versao/Retorno}

function LIB_Nome(const libHandle: PLibHandle; const sNome: pansichar;
  var esTamanho: integer): integer;
begin
  try
    VerificarLibInicializada(libHandle);
    Result := libHandle^.Lib.ObterNome(sNome, esTamanho);
  except
    on E: EACBrLibException do
      Result := E.Erro;

    on E: Exception do
      Result := ErrExecutandoMetodo;
  end;
end;

function LIB_Versao(const libHandle: PLibHandle; const sVersao: pansichar;
  var esTamanho: integer): integer;
begin
  try
    VerificarLibInicializada(libHandle);
    Result := libHandle^.Lib.ObterVersao(sVersao, esTamanho);
  except
    on E: EACBrLibException do
      Result := E.Erro;

    on E: Exception do
      Result := ErrExecutandoMetodo;
  end;
end;

function LIB_OpenSSLInfo(const libHandle: PLibHandle; const sOpenSSLInfo: pansichar;
  var esTamanho: integer): integer;
begin
  try
    VerificarLibInicializada(libHandle);
    Result := libHandle^.Lib.ObterOpenSSLInfo(sOpenSSLInfo, esTamanho);
  except
    on E: EACBrLibException do
      Result := E.Erro;

    on E: Exception do
      Result := ErrExecutandoMetodo;
  end;
end;

function LIB_UltimoRetorno(const libHandle: PLibHandle; const sMensagem: pansichar;
  var esTamanho: integer): integer;
begin
  try
    VerificarLibInicializada(libHandle);
    Result := libHandle^.Lib.UltimoRetorno(sMensagem, esTamanho);
  except
    on E: EACBrLibException do
      Result := E.Erro;

    on E: Exception do
      Result := ErrExecutandoMetodo;
  end;
end;

{%endregion}

{%region Ler/Gravar Config }

function LIB_ConfigImportar(const libHandle: PLibHandle;
  const eArqConfig: pansichar): integer;
begin
  try
    VerificarLibInicializada(libHandle);
    Result := libHandle^.Lib.ImportarConfig(eArqConfig);
  except
    on E: EACBrLibException do
      Result := E.Erro;

    on E: Exception do
      Result := ErrExecutandoMetodo;
  end;
end;

function LIB_ConfigExportar(const libHandle: PLibHandle;
  const sMensagem: pansichar; var esTamanho: integer): integer;
begin
  try
    VerificarLibInicializada(libHandle);
    Result := libHandle^.Lib.ExportarConfig(sMensagem, esTamanho);
  except
    on E: EACBrLibException do
      Result := E.Erro;

    on E: Exception do
      Result := ErrExecutandoMetodo;
  end;
end;

function LIB_ConfigLer(const libHandle: PLibHandle;
  const eArqConfig: pansichar): integer;
begin
  try
    VerificarLibInicializada(libHandle);
    Result := libHandle^.Lib.ConfigLer(eArqConfig);
  except
    on E: EACBrLibException do
      Result := E.Erro;

    on E: Exception do
      Result := ErrExecutandoMetodo;
  end;
end;

function LIB_ConfigGravar(const libHandle: PLibHandle;
  const eArqConfig: pansichar): integer;
begin
  try
    VerificarLibInicializada(libHandle);
    Result := libHandle^.Lib.ConfigGravar(eArqConfig);
  except
    on E: EACBrLibException do
      Result := E.Erro;

    on E: Exception do
      Result := ErrExecutandoMetodo;
  end;
end;

function LIB_ConfigLerValor(const libHandle: PLibHandle;
  const eSessao, eChave: pansichar; sValor: pansichar; var esTamanho: integer): integer;
begin
  try
    VerificarLibInicializada(libHandle);
    Result := libHandle^.Lib.ConfigLerValor(eSessao, eChave, sValor, esTamanho);
  except
    on E: EACBrLibException do
      Result := E.Erro;

    on E: Exception do
      Result := ErrExecutandoMetodo;
  end;
end;

function LIB_ConfigGravarValor(const libHandle: PLibHandle;
  const eSessao, eChave, eValor: pansichar): integer;
begin
  try
    VerificarLibInicializada(libHandle);
    Result := libHandle^.Lib.ConfigGravarValor(eSessao, eChave, eValor);
  except
    on E: EACBrLibException do
      Result := E.Erro;

    on E: Exception do
      Result := ErrExecutandoMetodo;
  end;
end;

{%endregion}

{%region Funcoes auxiliares }

procedure VerificarLibInicializada(const libHandle: PLibHandle);
begin
  if not Assigned(libHandle) then
  begin
    raise EACBrLibException.Create(ErrLibNaoInicializada, SErrLibNaoInicializada);
  end;
end;

procedure VerificarArquivoExiste(const NomeArquivo: string);
begin
  if not FileExists(NomeArquivo) then
    raise EACBrLibException.Create(ErrArquivoNaoExiste,
      Format(SErrArquivoNaoExiste, [NomeArquivo]));
end;

procedure LiberarLib(libHandle: PLibHandle);
begin
  if Assigned(libHandle) then
  begin
    if Assigned(libHandle^.Lib) then
    begin
      libHandle^.Lib.Destroy;
      libHandle^.Lib := nil;
    end;
    Dispose(libHandle);
  end;
end;

function LerArquivoParaString(AArquivo: string): ansistring;
var
  FS: TFileStream;
begin
  VerificarArquivoExiste(AArquivo);
  FS := TFileStream.Create(AArquivo, fmOpenRead or fmShareExclusive);
  try
    FS.Position := 0;
    Result := ReadStrFromStream(FS, FS.Size);
  finally
    FS.Free;
  end;
end;

function StringToB64Crypt(AString: ansistring; AChave: ansistring): string;
begin
  if (Length(AChave) = 0) then
    AChave := CLibChaveCrypt;

  Result := EncodeBase64(StrCrypt(AString, AChave));
end;

function B64CryptToString(ABase64Str: string; AChave: ansistring): ansistring;
begin
  if (Length(AChave) = 0) then
    AChave := CLibChaveCrypt;

  Result := StrCrypt(DecodeBase64(ABase64Str), AChave);
end;

function StreamToBase64(AStream: TStream): ansistring;
begin
  AStream.Position := 0;
  Result := EncodeBase64(ReadStrFromStream(AStream, AStream.Size));
end;

function StringEhXML(AString: string): boolean;
var
  p1: integer;
begin
  p1 := pos('<', AString);
  Result := (p1 > 0) and (PosEx('>', AString, p1 + 1) > 0);
end;

function StringEhINI(AString: string): boolean;
var
  p1, p2, p3: integer;
begin
  p1 := pos('[', AString);
  p2 := PosEx(']', AString, p1 + 1);
  p3 := PosEx(LF, AString, p2 + 1);
  Result := (p1 > 0) and (p2 > 0) and (p3 > 0) and (PosEx('=', AString, p2) > 0);
end;

function StringEhArquivo(AString: string): boolean;
begin
  Result := FileExists(AString);
end;

function ConverterStringEntradaParaNativa(AData: ansistring;
  CodificacaoEntrada: TACBrLibCodificacao): ansistring;
begin
  {$IfDef FPC}
  if (CodificacaoEntrada = codUTF8) then
    Result := AData
  else
    Result := ACBrAnsiToUTF8(AData);
  {$Else}
  if (CodificacaoEntrada = codANSI) then
    Result := AData
  else
    Result := ACBrUTF8ToAnsi(AData);
  {$EndIf}
end;

function ConverterStringNativaParaSaida(AData: ansistring;
  CodificacaoSaida: TACBrLibCodificacao): ansistring;
begin
  {$IfDef FPC}
  if (CodificacaoSaida = codUTF8) then
    Result := AData
  else
    Result := ACBrUTF8ToAnsi(AData);
  {$Else}
  if (CodificacaoSaida = codANSI) then
    Result := AData
  else
    Result := ACBrAnsiToUTF8(AData);
  {$EndIf}
end;

function ObterArquiteturaProcessador(): string;
begin
  Result :=
  {$IFDEF CPUX86_64}
   'x86_64'
  {$ELSE}
  {$IFDEF CPU386}
    'x86';
  {$ELSE}
     {$IFDEF CPUARM}
       'arm'
     {$ELSE}
       {$IFDEF CPUAARCH64}
         'aarch64'
       {$ELSE}
         ''
       {$ENDIF}
     {$ENDIF}
  {$ENDIF}
  {$ENDIF}
end;

function ObterConvencaoDeChamada(): string;
begin
  {$IFDEF STDCALL}
  result:= 'STDCALL';
  {$ELSE}
  Result := 'cdecl';
  {$ENDIF}
end;

function ObterInformacoesSistemaOperacional(): string;
begin
  Result :=
  {$IFDEF MSWINDOWS}
    'Windows'
  {$ELSE}
  {$IFDEF LINUX}
    'Linux'
  {$ELSE}
    {$IFDEF ANDROID}
      'Android'
    {$ELSE}
      {$IFDEF MACOS}
        'Darwin (macOS/iOS)'
      {$ELSE}
        'Desconhecido'
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}
  {$ENDIF}
  ;

end;

function ObterInformacoesDeThreads(): string;
begin
  Result := '';
  {$IFNDEF MT}
  Result := 'ST';
  {$ELSE}
  result:= 'MT';
  {$ENDIF}
end;

function ObterInformacoesDeAmbienteGrafico(): string;
begin
  Result :=
  {$IFDEF LCLNoGUI}
  'Console'
  {$Else}
  {$IFDEF LCLFpGUI}
   'Console'
    {$else}
    'GUI'
  {$ENDIF}
  {$endif}
  ;
end;

finalization
  {$IFDEF DEMO}
  if Assigned(FPDemo) then
    FreeAndNil(FPDemo);
  {$ENDIF}

end.
