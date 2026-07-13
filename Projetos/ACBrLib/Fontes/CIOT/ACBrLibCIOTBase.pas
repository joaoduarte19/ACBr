{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Renato Rubinho                                  }
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

unit ACBrLibCIOTBase;

interface

uses
  Classes, SysUtils, Forms, synautil,
  ACBrUtil.FilesIO,
  ACBrLibComum, ACBrLibCIOTDataModule, ACBrDFeException;

type
  { TACBrLibCIOT }
  TACBrLibCIOT = class(TACBrLib)
  private
    FCIOTDM: TLibCIOTDM;

    function SetRetornoCIOTCarregados(const NumCIOT: Integer): Integer;
  protected
    procedure CriarConfiguracao(ArqConfig: string = ''; ChaveCrypt: ansistring = ''); override;
    procedure Executar; Override;
  public
    constructor Create(ArqConfig: string = ''; ChaveCrypt: ansistring = ''); override;
    destructor Destroy; override;

    property CIOTDM: TLibCIOTDM read FCIOTDM;

    function CarregarXML(const eArquivoOuXML: PAnsiChar): Integer;
    function CarregarINI(const eArquivoOuINI: PAnsiChar): Integer;
    function ObterXml(AIndex: Integer; const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
    function GravarXml(AIndex: Integer; const eNomeArquivo, ePathArquivo: PAnsiChar): Integer;
    function ObterIni(AIndex: Integer; const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
    function GravarIni(AIndex: Integer; const eNomeArquivo, ePathArquivo: PAnsiChar): Integer;
    function LimparLista: Integer;
    function GetPath(const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
    function ObterCertificados(const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
    function Enviar(const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
  end;

implementation

uses
  ACBrUtil.Base, ACBrCIOT,
  ACBrUtil.Strings, ACBrDFeUtil, ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrLibConsts, ACBrLibConfig, ACBrLibResposta,
  ACBrLibCIOTConsts, ACBrLibCIOTConfig,
  ACBrLibCIOTRespostas, ACBrLibCertUtils;

{ TACBrLibCIOT }
function TACBrLibCIOT.SetRetornoCIOTCarregados(const NumCIOT: Integer): Integer;
begin
  Result := SetRetorno(0, Format(CInfCIOTCarregados, [NumCIOT]));
end;

procedure TACBrLibCIOT.CriarConfiguracao(ArqConfig: string;
  ChaveCrypt: ansistring);
begin
  fpConfig := TLibCIOTConfig.Create(Self, ArqConfig, ChaveCrypt);
end;

procedure TACBrLibCIOT.Executar;
begin
  inherited Executar;
  FCIOTDM.AplicarConfiguracoes;
end;

constructor TACBrLibCIOT.Create(ArqConfig: string; ChaveCrypt: ansistring);
begin
  inherited Create(ArqConfig, ChaveCrypt);

  FCIOTDM := TLibCIOTDM.Create(nil);
  FCIOTDM.Lib := Self;
end;

destructor TACBrLibCIOT.Destroy;
begin
  FCIOTDM.Free;
  inherited Destroy;
end;

function TACBrLibCIOT.CarregarXML(const eArquivoOuXML: PAnsiChar): Integer;
var
  EhArquivo: boolean;
  ArquivoOuXml: string;
begin
  try
    ArquivoOuXml := ConverterStringEntrada(eArquivoOuXML);

    if Config.Log.Nivel > logNormal then
      GravarLog('CIOT_CarregarXML(' + ArquivoOuXml + ' )', logCompleto, True)
    else
      GravarLog('CIOT_CarregarXML', logNormal);

    EhArquivo := StringEhArquivo(ArquivoOuXml);
    if EhArquivo then
      VerificarArquivoExiste(ArquivoOuXml);

    CIOTDM.Travar;
    try
      if EhArquivo then
        CIOTDM.ACBrCIOT1.Contratos.LoadFromFile(ArquivoOuXml)
      else
        CIOTDM.ACBrCIOT1.Contratos.LoadFromString(ArquivoOuXml);

      Result := SetRetornoCIOTCarregados(CIOTDM.ACBrCIOT1.Contratos.Count);
    finally
      CIOTDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibCIOT.CarregarINI(const eArquivoOuINI: PAnsiChar): Integer;
var
  ArquivoOuINI: string;
begin
  try
    ArquivoOuINI := ConverterStringEntrada(eArquivoOuINI);

    if Config.Log.Nivel > logNormal then
      GravarLog('CIOT_CarregarINI(' + ArquivoOuINI + ' )', logCompleto, True)
    else
      GravarLog('CIOT_CarregarINI', logNormal);

    if StringEhArquivo(ArquivoOuINI) then
      VerificarArquivoExiste(ArquivoOuINI);

    CIOTDM.Travar;
    try
      CIOTDM.ACBrCIOT1.Contratos.LoadFromIni(ArquivoOuINI);
      Result := SetRetornoCIOTCarregados(CIOTDM.ACBrCIOT1.Contratos.Count);
    finally
      CIOTDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibCIOT.ObterXml(AIndex: Integer; const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
var
  Resposta: Ansistring;
begin
  try
    if Config.Log.Nivel > logNormal then
      GravarLog('CIOT_ObterXml(' + IntToStr(AIndex) + ' )', logCompleto, True)
    else
      GravarLog('CIOT_ObterXml', logNormal);

    CIOTDM.Travar;
    try
      if (CIOTDM.ACBrCIOT1.Contratos.Count < 1) or (AIndex < 0) or
         (AIndex >= CIOTDM.ACBrCIOT1.Contratos.Count) then
         raise EACBrLibException.Create(ErrIndex, Format(SErrIndex, [AIndex]));

      if EstaVazio(CIOTDM.ACBrCIOT1.Contratos.Items[AIndex].XMLOriginal) then
        CIOTDM.ACBrCIOT1.Contratos.Items[AIndex].GerarXML;

      Resposta := CIOTDM.ACBrCIOT1.Contratos.Items[AIndex].XMLOriginal;
      MoverStringParaPChar(Resposta, sResposta, esTamanho);
      Result := SetRetorno(ErrOK, Resposta);
    finally
      CIOTDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibCIOT.GravarXml(AIndex: Integer; const eNomeArquivo, ePathArquivo: PAnsiChar): Integer;
var
  ANomeArquivo, APathArquivo: string;
begin
  try
    ANomeArquivo := ConverterStringEntrada(eNomeArquivo);
    APathArquivo := ConverterStringEntrada(ePathArquivo);

    if Config.Log.Nivel > logNormal then
      GravarLog('CIOT_GravarXml(' + IntToStr(AIndex) + ',' +
        ANomeArquivo + ',' + APathArquivo + ' )', logCompleto, True)
    else
      GravarLog('CIOT_GravarXml', logNormal);

    CIOTDM.Travar;
    try
      if (CIOTDM.ACBrCIOT1.Contratos.Count < 1) or (AIndex < 0) or
         (AIndex >= CIOTDM.ACBrCIOT1.Contratos.Count) then
         raise EACBrLibException.Create(ErrIndex, Format(SErrIndex, [AIndex]));

      if CIOTDM.ACBrCIOT1.Contratos.Items[AIndex].GravarXML(ANomeArquivo, APathArquivo) then
        Result := SetRetorno(ErrOK)
      else
        Result := SetRetorno(ErrGerarXml);
    finally
      CIOTDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibCIOT.ObterIni(AIndex: Integer; const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
var
  Resposta: Ansistring;
begin
  try
    if Config.Log.Nivel > logNormal then
      GravarLog('CIOT_ObterIni(' + IntToStr(AIndex) + ' )', logCompleto, True)
    else
      GravarLog('CIOT_ObterIni', logNormal);

    CIOTDM.Travar;
    try
      if (CIOTDM.ACBrCIOT1.Contratos.Count < 1) or (AIndex < 0) or (AIndex >= CIOTDM.ACBrCIOT1.Contratos.Count) then
        raise EACBrLibException.Create(ErrIndex, Format(SErrIndex, [AIndex]));

      if EstaVazio(CIOTDM.ACBrCIOT1.Contratos.Items[AIndex].XMLOriginal) then
        CIOTDM.ACBrCIOT1.Contratos.Items[AIndex].GerarXML;

      Resposta := CIOTDM.ACBrCIOT1.Contratos.Items[AIndex].GerarCIOTIni;
      Resposta := ConverterStringSaida( Resposta );
      MoverStringParaPChar(Resposta, sResposta, esTamanho);
      Result := SetRetorno(ErrOK, Resposta);
    finally
      CIOTDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibCIOT.GravarIni(AIndex: Integer; const eNomeArquivo, ePathArquivo: PAnsiChar): Integer;
var
  LCIOTIni, ANomeArquivo, APathArquivo: string;
begin
  try
    ANomeArquivo := ConverterStringEntrada(eNomeArquivo);
    APathArquivo := ConverterStringEntrada(ePathArquivo);

    if Config.Log.Nivel > logNormal then
      GravarLog('CIOT_GravarIni(' + IntToStr(AIndex) + ',' +
        ANomeArquivo + ',' + APathArquivo + ' )', logCompleto, True)
    else
      GravarLog('CIOT_GravarIni', logNormal);

    CIOTDM.Travar;
    try
      if (CIOTDM.ACBrCIOT1.Contratos.Count < 1) or (AIndex < 0) or (AIndex >= CIOTDM.ACBrCIOT1.Contratos.Count) then
        raise EACBrLibException.Create(ErrIndex, Format(SErrIndex, [AIndex]));

      ANomeArquivo := ExtractFileName(ANomeArquivo);

      if EstaVazio(ANomeArquivo) then
        raise EACBrLibException.Create(ErrExecutandoMetodo, 'Nome de arquivo não informado');

      if EstaVazio(APathArquivo) then
        APathArquivo := ExtractFilePath(ANomeArquivo);
      if EstaVazio(APathArquivo) then
        APathArquivo := CIOTDM.ACBrCIOT1.Configuracoes.Arquivos.PathSalvar;

      APathArquivo := PathWithDelim(APathArquivo);

      if EstaVazio(CIOTDM.ACBrCIOT1.Contratos.Items[AIndex].XMLOriginal) then
        CIOTDM.ACBrCIOT1.Contratos.Items[AIndex].GerarXML;

      LCIOTIni := CIOTDM.ACBrCIOT1.Contratos.Items[AIndex].GerarCIOTIni;
      if not DirectoryExists(APathArquivo) then
        ForceDirectories(APathArquivo);

      WriteToTXT(APathArquivo + ANomeArquivo, LCIOTIni, False, False);
    finally
      CIOTDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibCIOT.LimparLista: Integer;
begin
  try
    GravarLog('CIOT_LimparLista', logNormal);

    CIOTDM.Travar;
    try
      CIOTDM.ACBrCIOT1.Contratos.Clear;
      Result := SetRetornoCIOTCarregados(CIOTDM.ACBrCIOT1.Contratos.Count);
    finally
      CIOTDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibCIOT.GetPath(const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
var
  Resposta: Ansistring;
begin
  try
    if Config.Log.Nivel > logNormal then
      GravarLog('CIOT_GetPath', logCompleto, True)
    else
      GravarLog('CIOT_GetPath', logNormal);

    CIOTDM.Travar;
    try
      with CIOTDM do
      begin
        Resposta := ACBrCIOT1.Configuracoes.Arquivos.GetPathCIOT;
        Resposta := ConverterStringSaida(Resposta);
        MoverStringParaPChar(Resposta, sResposta, esTamanho);
        Result := SetRetorno(ErrOK, Resposta);
      end;
    finally
      CIOTDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibCIOT.ObterCertificados(const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
var
  Resposta: Ansistring;
begin
  try
    GravarLog('CIOT_ObterCertificados', logNormal);

    CIOTDM.Travar;
    try
      Resposta := '';
      Resposta := ObterCerticados(CIOTDM.ACBrCIOT1.SSL);
      Resposta := ConverterStringSaida(Resposta);
      MoverStringParaPChar(Resposta, sResposta, esTamanho);
      Result := SetRetorno(ErrOK, Resposta);
    finally
      CIOTDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibCIOT.Enviar(const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
var
  I: integer;
  Resposta: Ansistring;
  RespEnvio: TEnvioResposta;
  pLibCIOTConfig: TLibCIOTConfig;
begin
  pLibCIOTConfig := TLibCIOTConfig(Config);
  try
    if Config.Log.Nivel > logNormal then
      GravarLog('CIOT_Enviar', logCompleto, True)
    else
      GravarLog('CIOT_Enviar', logNormal);

    CIOTDM.Travar;
    try
      with CIOTDM.ACBrCIOT1 do
      begin
        if Contratos.Count <= 0 then
          raise EACBrLibException.Create(CErrEnvio, Format(CInfCIOTCarregados, [Contratos.Count]));

        if pLibCIOTConfig.IntegradoraConfig.TokenAtivo <> '' then
        begin
          GravarLog('Token Ativo', logParanoico);

          for I:=0 to Contratos.Count - 1 do
            Contratos.Items[I].CIOT.Integradora.Token := pLibCIOTConfig.IntegradoraConfig.TokenAtivo;
        end;

        GravarLog('CIOT_Enviar, Limpando Resp', logParanoico);
        Resposta := '';

        GravarLog('CIOT_Enviar, Enviando', logCompleto);

        Enviar;

        RespEnvio := TEnvioResposta.Create(Config.TipoResposta, Config.CodResposta);
        try
          GravarLog('CIOT_Enviar, Proces.Resp Enviar', logParanoico);
          RespEnvio.Processar(CIOTDM.ACBrCIOT1);

          GravarLog('Token Ativo Antes: ' + pLibCIOTConfig.IntegradoraConfig.TokenAtivo, logParanoico);

          if RespEnvio.Token <> '' then
            pLibCIOTConfig.IntegradoraConfig.TokenAtivo := RespEnvio.Token;

          GravarLog('Token Ativo Depois: ' + pLibCIOTConfig.IntegradoraConfig.TokenAtivo, logParanoico);

          Resposta := RespEnvio.Gerar;
        finally
          RespEnvio.Free;
        end;

        MoverStringParaPChar(Resposta, sResposta, esTamanho);
        Result := SetRetorno(ErrOK, Resposta);
      end;
    finally
      CIOTDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: EACBrDFeExceptionTimeOut do
      Result := SetRetorno(ErrTimeOut, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

end.

