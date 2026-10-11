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

unit ACBrLibIMendesBase;

interface

uses
  Classes, SysUtils, ACBrUtil.FilesIO,
  ACBrLibComum, ACBrLibIMendesDataModule;

type
{ TACBrLibIMendes }
TACBrLibIMendes = class(TACBrLib)
  private
    FIMendesDM: TLibIMendesDM;

    function GerarRespostaErro: AnsiString;
    function RetornarResposta(const ACodigo: Integer; const AResposta: AnsiString;
      const sResposta: PAnsiChar; var esTamanho: Integer): Integer;

  protected
    procedure CriarConfiguracao(ArqConfig: string = ''; ChaveCrypt: ansistring = ''); override;
    procedure Executar; Override;

  public
    constructor Create(ArqConfig: string = ''; ChaveCrypt: ansistring = ''); override;
    destructor Destroy; override;

    function ConsultarDescricao(const eDescricao, eCNPJ: PAnsiChar; nTipo: Integer;
      const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
    function ConsultarAlterados(const eUF, eCNPJ: PAnsiChar; nLimite: Integer;
      const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
    function HistoricoAcesso(const eCNPJ: PAnsiChar;
      const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
    function ConsultarRegimesEspeciais(const eUF: PAnsiChar; bIncludeTrib: Boolean;
      const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
    function SaneamentoGrades(const eArquivoOuIni: PAnsiChar;
      const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
    function Inativar(const eArquivoOuIni: PAnsiChar;
      const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
    function RemoveDevolvidos(const eArquivoOuIni: PAnsiChar;
      const sResposta: PAnsiChar; var esTamanho: Integer): Integer;

    property IMendesDM: TLibIMendesDM read FIMendesDM;
end;

implementation

Uses
  ACBrLibConsts, ACBrLibConfig, ACBrLibIMendesConsts, ACBrLibIMendesConfig, ACBrIMendes, ACBrLibIMendesRespostas, ACBrLibHelpers,
  ACBrUtil.Base;

{ TACBrLibIMendes }

procedure TACBrLibIMendes.CriarConfiguracao(ArqConfig: string; ChaveCrypt: ansistring);
begin
  fpConfig := TLibIMendesConfig.Create(Self, ArqConfig, ChaveCrypt);
end;

procedure TACBrLibIMendes.Executar;
begin
  inherited Executar;
  FIMendesDM.AplicarConfiguracoes;
end;

constructor TACBrLibIMendes.Create(ArqConfig: string; ChaveCrypt: ansistring);
begin
  inherited Create(ArqConfig, ChaveCrypt);

  FIMendesDM := TLibIMendesDM.Create(Nil);
  FIMendesDM.Lib := Self;
end;

destructor TACBrLibIMendes.Destroy;
begin
  FIMendesDM.Free;
  inherited Destroy;
end;

function TACBrLibIMendes.GerarRespostaErro: AnsiString;
var
  Resp: TLibIMendesErroResposta;
begin
  Resp := TLibIMendesErroResposta.Create(Config.TipoResposta, Config.CodResposta);
  try
    Resp.Processar(IMendesDM.ACBrIMendes1.RespostaErro);
    Result := Resp.Gerar;
  finally
    Resp.Free;
  end;
end;

function TACBrLibIMendes.RetornarResposta(const ACodigo: Integer; const AResposta: AnsiString;
  const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
begin
  MoverStringParaPChar(AResposta, sResposta, esTamanho);
  Result := SetRetorno(ACodigo, AResposta);
end;

function TACBrLibIMendes.ConsultarDescricao(const eDescricao, eCNPJ: PAnsiChar; nTipo: Integer;
  const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
var
  Descricao, CNPJ: String;
  Resposta: AnsiString;
  Resp: TLibIMendesConsultarResposta;
  wCodigoRetorno: Integer;
begin
  try
    Descricao := ConverterStringEntrada(eDescricao);
    CNPJ := ConverterStringEntrada(eCNPJ);

    if (Config.Log.Nivel > logNormal) then
      GravarLog('IMendes_ConsultarDescricao(' + Descricao + ',' + CNPJ + ',' + IntToStr(nTipo) + ')', logCompleto, True)
    else
      GravarLog('IMendes_ConsultarDescricao', logNormal);

    IMendesDM.Travar;
    try
      IMendesDM.ACBrIMendes1.Clear;
      if IMendesDM.ACBrIMendes1.ConsultarDescricao(Descricao, CNPJ, nTipo) then
      begin
        Resp := TLibIMendesConsultarResposta.Create(CSessaoRespConsultarDescricao, Config.TipoResposta, Config.CodResposta);
        try
          Resp.Processar(IMendesDM.ACBrIMendes1.ConsultarDescricaoResponse);
          Resposta := Resp.Gerar;
        finally
          Resp.Free;
        end;
        wCodigoRetorno := ErrOK;
      end
      else
      begin
        Resposta := GerarRespostaErro;
        wCodigoRetorno := ErrHttp;
      end;

      Result := RetornarResposta(wCodigoRetorno, Resposta, sResposta, esTamanho);
    finally
      IMendesDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibIMendes.ConsultarAlterados(const eUF, eCNPJ: PAnsiChar; nLimite: Integer;
  const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
var
  UF, CNPJ: String;
  Resposta: AnsiString;
  Resp: TLibIMendesConsultarResposta;
  wCodigoRetorno: Integer;
begin
  try
    UF := ConverterStringEntrada(eUF);
    CNPJ := ConverterStringEntrada(eCNPJ);

    if (Config.Log.Nivel > logNormal) then
      GravarLog('IMendes_ConsultarAlterados(' + UF + ',' + CNPJ + ',' + IntToStr(nLimite) + ')', logCompleto, True)
    else
      GravarLog('IMendes_ConsultarAlterados', logNormal);

    IMendesDM.Travar;
    try
      IMendesDM.ACBrIMendes1.Clear;
      if IMendesDM.ACBrIMendes1.ConsultarAlterados(UF, CNPJ, nLimite) then
      begin
        Resp := TLibIMendesConsultarResposta.Create(CSessaoRespConsultarAlterados, Config.TipoResposta, Config.CodResposta);
        try
          Resp.Processar(IMendesDM.ACBrIMendes1.ConsultarAlteradosResponse);
          Resposta := Resp.Gerar;
        finally
          Resp.Free;
        end;
        wCodigoRetorno := ErrOK;
      end
      else
      begin
        Resposta := GerarRespostaErro;
        wCodigoRetorno := ErrHttp;
      end;

      Result := RetornarResposta(wCodigoRetorno, Resposta, sResposta, esTamanho);
    finally
      IMendesDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibIMendes.HistoricoAcesso(const eCNPJ: PAnsiChar;
  const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
var
  CNPJ: String;
  Resposta: AnsiString;
  Resp: TLibIMendesHistoricoResposta;
  wCodigoRetorno: Integer;
begin
  try
    CNPJ := ConverterStringEntrada(eCNPJ);

    if (Config.Log.Nivel > logNormal) then
      GravarLog('IMendes_HistoricoAcesso(' + CNPJ + ')', logCompleto, True)
    else
      GravarLog('IMendes_HistoricoAcesso', logNormal);

    IMendesDM.Travar;
    try
      IMendesDM.ACBrIMendes1.Clear;
      if IMendesDM.ACBrIMendes1.HistoricoAcesso(CNPJ) then
      begin
        Resp := TLibIMendesHistoricoResposta.Create(Config.TipoResposta, Config.CodResposta);
        try
          Resp.Processar(IMendesDM.ACBrIMendes1.HistoricoAcessoResponse);
          Resposta := Resp.Gerar;
        finally
          Resp.Free;
        end;
        wCodigoRetorno := ErrOK;
      end
      else
      begin
        Resposta := GerarRespostaErro;
        wCodigoRetorno := ErrHttp;
      end;

      Result := RetornarResposta(wCodigoRetorno, Resposta, sResposta, esTamanho);
    finally
      IMendesDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibIMendes.ConsultarRegimesEspeciais(const eUF: PAnsiChar; bIncludeTrib: Boolean;
  const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
var
  UF: String;
  Resposta: AnsiString;
  Resp: TLibIMendesRegimeEspecialResposta;
  wCodigoRetorno: Integer;
begin
  try
    UF := ConverterStringEntrada(eUF);

    if (Config.Log.Nivel > logNormal) then
      GravarLog('IMendes_ConsultarRegimesEspeciais(' + UF + ',' + BoolToStr(bIncludeTrib, True) + ')', logCompleto, True)
    else
      GravarLog('IMendes_ConsultarRegimesEspeciais', logNormal);

    IMendesDM.Travar;
    try
      IMendesDM.ACBrIMendes1.Clear;
      if IMendesDM.ACBrIMendes1.ConsultarRegimesEspeciais(UF, bIncludeTrib) then
      begin
        Resp := TLibIMendesRegimeEspecialResposta.Create(Config.TipoResposta, Config.CodResposta);
        try
          Resp.Processar(IMendesDM.ACBrIMendes1.ConsultarRegimeEspecialResponse);
          Resposta := Resp.Gerar;
        finally
          Resp.Free;
        end;
        wCodigoRetorno := ErrOK;
      end
      else
      begin
        Resposta := GerarRespostaErro;
        wCodigoRetorno := ErrHttp;
      end;

      Result := RetornarResposta(wCodigoRetorno, Resposta, sResposta, esTamanho);
    finally
      IMendesDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibIMendes.SaneamentoGrades(const eArquivoOuIni: PAnsiChar;
  const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
var
  ArquivoOuIni: String;
  Resposta: AnsiString;
  Resp: TLibIMendesSaneamentoResposta;
  Ok: Boolean;
  wCodigoRetorno: Integer;
begin
  try
    ArquivoOuIni := ConverterStringEntrada(eArquivoOuIni);

    if (Config.Log.Nivel > logNormal) then
      GravarLog('IMendes_SaneamentoGrades(' + ArquivoOuIni + ')', logCompleto, True)
    else
      GravarLog('IMendes_SaneamentoGrades', logNormal);

    // Se nao for conteudo INI, tem que ser um arquivo existente
    if not StringEhINI(ArquivoOuIni) then
      VerificarArquivoExiste(ArquivoOuIni);

    IMendesDM.Travar;
    try
      IMendesDM.ACBrIMendes1.Clear;
      IMendesDM.ACBrIMendes1.SaneamentoGradesRequest.LoadFromIni(ArquivoOuIni);
      Ok := IMendesDM.ACBrIMendes1.SaneamentoGrades;

      // HTTP 400: o componente retorna False, mas preenche o SaneamentoGradesResponse
      if Ok or (IMendesDM.ACBrIMendes1.HTTPResultCode = 400) then
      begin
        Resp := TLibIMendesSaneamentoResposta.Create(Config.TipoResposta, Config.CodResposta);
        try
          Resp.Processar(IMendesDM.ACBrIMendes1.SaneamentoGradesResponse);
          Resposta := Resp.Gerar;
        finally
          Resp.Free;
        end;

        if Ok then
          wCodigoRetorno := ErrOK
        else
          wCodigoRetorno := ErrHttp;
      end
      else
      begin
        Resposta := GerarRespostaErro;
        wCodigoRetorno := ErrHttp;
      end;

      Result := RetornarResposta(wCodigoRetorno, Resposta, sResposta, esTamanho);
    finally
      IMendesDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibIMendes.Inativar(const eArquivoOuIni: PAnsiChar;
  const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
var
  ArquivoOuIni: String;
  Resposta: AnsiString;
  Resp: TLibIMendesRetornoResposta;
  wCodigoRetorno: Integer;
begin
  try
    ArquivoOuIni := ConverterStringEntrada(eArquivoOuIni);

    if (Config.Log.Nivel > logNormal) then
      GravarLog('IMendes_Inativar(' + ArquivoOuIni + ')', logCompleto, True)
    else
      GravarLog('IMendes_Inativar', logNormal);

    // Se nao for conteudo INI, tem que ser um arquivo existente
    if not StringEhINI(ArquivoOuIni) then
      VerificarArquivoExiste(ArquivoOuIni);

    IMendesDM.Travar;
    try
      IMendesDM.ACBrIMendes1.Clear;
      IMendesDM.ACBrIMendes1.InativarRequest.LoadFromIni(ArquivoOuIni);
      // Mesmo comportamento do componente: sem CNPJ no INI, usa o CNPJ da configuracao [IMendes] no ACBrLib.ini
      if EstaVazio(IMendesDM.ACBrIMendes1.InativarRequest.cnpj) then
        IMendesDM.ACBrIMendes1.InativarRequest.cnpj := IMendesDM.ACBrIMendes1.CNPJ;

      if IMendesDM.ACBrIMendes1.Inativar then
      begin
        Resp := TLibIMendesRetornoResposta.Create(CSessaoRespInativar, Config.TipoResposta, Config.CodResposta);
        try
          Resp.Processar(IMendesDM.ACBrIMendes1.HTTPResponse);
          Resposta := Resp.Gerar;
        finally
          Resp.Free;
        end;
        wCodigoRetorno := ErrOK;
      end
      else
      begin
        Resposta := GerarRespostaErro;
        wCodigoRetorno := ErrHttp;
      end;

      Result := RetornarResposta(wCodigoRetorno, Resposta, sResposta, esTamanho);
    finally
      IMendesDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibIMendes.RemoveDevolvidos(const eArquivoOuIni: PAnsiChar;
  const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
var
  ArquivoOuIni: String;
  Resposta: AnsiString;
  Resp: TLibIMendesRetornoResposta;
  wCodigoRetorno: Integer;
begin
  try
    ArquivoOuIni := ConverterStringEntrada(eArquivoOuIni);

    if (Config.Log.Nivel > logNormal) then
      GravarLog('IMendes_RemoveDevolvidos(' + ArquivoOuIni + ')', logCompleto, True)
    else
      GravarLog('IMendes_RemoveDevolvidos', logNormal);

    // Se nao for conteudo INI, tem que ser um arquivo existente
    if not StringEhINI(ArquivoOuIni) then
      VerificarArquivoExiste(ArquivoOuIni);

    IMendesDM.Travar;
    try
      IMendesDM.ACBrIMendes1.Clear;
      IMendesDM.ACBrIMendes1.RemoveDevolvidosRequest.LoadFromIni(ArquivoOuIni);
      // Mesmo comportamento do componente: sem CNPJ no INI, usa o CNPJ da configuracao [IMendes] no ACBrLib.ini
      if EstaVazio(IMendesDM.ACBrIMendes1.RemoveDevolvidosRequest.CNPJ) then
        IMendesDM.ACBrIMendes1.RemoveDevolvidosRequest.CNPJ := IMendesDM.ACBrIMendes1.CNPJ;

      if IMendesDM.ACBrIMendes1.RemoveDevolvidos then
      begin
        Resp := TLibIMendesRetornoResposta.Create(CSessaoRespRemoveDevolvidos, Config.TipoResposta, Config.CodResposta);
        try
          Resp.Processar(IMendesDM.ACBrIMendes1.HTTPResponse);
          Resposta := Resp.Gerar;
        finally
          Resp.Free;
        end;
        wCodigoRetorno := ErrOK;
      end
      else
      begin
        Resposta := GerarRespostaErro;
        wCodigoRetorno := ErrHttp;
      end;

      Result := RetornarResposta(wCodigoRetorno, Resposta, sResposta, esTamanho);
    finally
      IMendesDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

end.

