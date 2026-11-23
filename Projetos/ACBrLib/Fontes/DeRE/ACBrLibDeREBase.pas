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

unit ACBrLibDeREBase;

interface

uses
  Classes, SysUtils, Forms,
  ACBrUtil.Base, ACBrUtil.FilesIO, ACBrUtil.Strings,
  ACBrDeRE, ACBrDeRE.Conversao, ACBrLibDeRERespostas,
  ACBrLibComum, ACBrLibDeREDataModule;

type

  { TACBrLibDeRE }

  TACBrLibDeRE = class(TACBrLib)
  private
    FDeREDM: TLibDeREDM;

    function SetRetornoEventoCarregados(const NumEventos: integer): integer;
    function SetRetornoDeREValidados(const NumEventos: integer): integer;
    procedure GerarSalvarEventos;

  protected
    procedure CriarConfiguracao(ArqConfig: string = ''; ChaveCrypt: ansistring = ''); override;
    procedure Executar; override;

  public
    constructor Create(ArqConfig: string = ''; ChaveCrypt: ansistring = ''); override;
    destructor Destroy; override;

    function CriarEventoDeRE(eArqIni: PAnsiChar): integer;
    function EnviarDeRE(const sResposta: PAnsiChar; var esTamanho: integer): integer;
    function ConsultarDeRE(eProtocolo: PAnsiChar; const sResposta: PAnsiChar; var esTamanho: integer): integer;
    function CriarEnviarDeRE(const eArqIni: PAnsiChar; const sResposta: PAnsiChar;
      var esTamanho: integer): integer;
    function LimparDeRE: integer;
    function CarregarXMLEventoDeRE(const eArquivoOuXML: PAnsiChar): integer;
    function ObterIniEventos(const sResposta: PAnsiChar; var esTamanho: integer): integer;
    function ObterToken(const sResposta: PAnsiChar; var esTamanho: integer): integer;
    function LimparDados(eCNPJBase: PAnsiChar; const sResposta: PAnsiChar; var esTamanho: integer): integer;
    function SetIDContribuinte(const aIdContribuinte: PAnsiChar): integer;
    function SetVersaoDF(const sVersao: PAnsiChar): integer;
    function ObterCertificados(const sResposta: PAnsiChar; var esTamanho: integer): integer;
    function Validar: integer;

    property DeREDM: TLibDeREDM read FDeREDM;

  end;

implementation

uses
  ACBrLibConsts, ACBrLibDeREConsts, ACBrLibConfig, ACBrLibDeREConfig,
  ACBrLibResposta, ACBrLibCertUtils, ACBrDFeException, StrUtils;

{ TACBrLibDeRE }

constructor TACBrLibDeRE.Create(ArqConfig: string; ChaveCrypt: ansistring);
begin
  inherited
  Create(ArqConfig, ChaveCrypt);
  FDeREDM := TLibDeREDM.Create(Nil);
  FDeREDM.Lib := Self;
end;

destructor TACBrLibDeRE.Destroy;
begin
  FDeREDM.Free;

  inherited Destroy;
end;

procedure TACBrLibDeRE.CriarConfiguracao(ArqConfig: string; ChaveCrypt: ansistring);
begin
  fpConfig := TLibDeREConfig.Create(Self, ArqConfig, ChaveCrypt);
end;

procedure TACBrLibDeRE.Executar;
begin
  inherited Executar;
  FDeREDM.AplicarConfiguracoes;
end;

function TACBrLibDeRE.SetRetornoEventoCarregados(const NumEventos: integer): integer;
begin
  Result := SetRetorno(0, Format(SInfEventosCarregados, [NumEventos]));
end;

function TACBrLibDeRE.SetRetornoDeREValidados(const NumEventos: integer): integer;
begin
  Result := SetRetorno(0, Format(SInfDeRECarregadas, [NumEventos]));
end;

procedure TACBrLibDeRE.GerarSalvarEventos;
begin
  // Gera, assina e valida o XML de todos os eventos carregados e salva em disco
  // (somente quando Configuracoes.Geral.Salvar = True).
  FDeREDM.ACBrDeRE1.Eventos.GerarXMLs;
  FDeREDM.ACBrDeRE1.Eventos.SaveToFiles;
end;

function TACBrLibDeRE.CriarEventoDeRE(eArqIni: PAnsiChar): integer;
var
  AArqIni: string;
  EhArquivo: Boolean;
begin
  try
    AArqIni := ConverterStringEntrada(eArqIni);

    if Config.Log.Nivel > logNormal then
      GravarLog('DeRE_CriarEvento (' + AArqIni + ' ) ', logCompleto, True)
    else
      GravarLog('DeRE_CriarEvento', logNormal);

    EhArquivo := StringEhArquivo(AArqIni);
    if EhArquivo then
      VerificarArquivoExiste(AArqIni);

    DeREDM.Travar;
    try
      // Aceita o nome de um arquivo INI ou o proprio conteudo do INI, com um ou varios
      // eventos (inclusive de tipos diferentes).
      DeREDM.ACBrDeRE1.Eventos.LoadFromIni(AArqIni);
      Result := SetRetornoEventoCarregados(DeREDM.ACBrDeRE1.Eventos.Count);
    finally
      DeREDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibDeRE.EnviarDeRE(const sResposta: PAnsiChar; var esTamanho: integer): integer;
var
  AResposta: string;
  Resp: TRespostas;
begin
  try
    if Config.Log.Nivel > logNormal then
      GravarLog('DeRE_EnviarDeRE', logCompleto, True)
    else
      GravarLog('DeRE_EnviarDeRE', logNormal);

    DeREDM.Travar;
    try
      AResposta := '';

      if DeREDM.ACBrDeRE1.Eventos.Count = 0 then
        raise EACBrLibException.Create(ErrParametroInvalido,
          'Nenhum evento carregado. Use DeRE_CriarEventoDeRE ou DeRE_CarregarXMLEventoDeRE.');

      GerarSalvarEventos;

      if DeREDM.ACBrDeRE1.EnviarLote then
      begin
        Resp := TRespostas.Create(DeREDM.ACBrDeRE1, Config.TipoResposta, Config.CodResposta);
        try
          Resp.RespostaEnvio;
          AResposta := Resp.Resposta;
        finally
          Resp.Free;
        end;
      end;

      DeREDM.ACBrDeRE1.Eventos.Clear;

      MoverStringParaPChar(AResposta, sResposta, esTamanho);
      Result := SetRetorno(ErrOK, AResposta);
    finally
      DeREDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibDeRE.ConsultarDeRE(eProtocolo: PAnsiChar; const sResposta: PAnsiChar; var esTamanho: integer): integer;
var
  AProtocolo, AResposta: string;
  Resp: TRespostas;
begin
  try
    AProtocolo := ConverterStringEntrada(eProtocolo);

    if Config.Log.Nivel > logNormal then
      GravarLog('DeRE_ConsultarDeRE (' + AProtocolo + ' ) ', logCompleto, True)
    else
      GravarLog('DeRE_ConsultarDeRE', logNormal);

    if EstaVazio(AProtocolo) then
      raise EACBrLibException.Create(ErrParametroInvalido, ACBrStr(SErroDeREConsulta));

    DeREDM.Travar;
    try
      AResposta := '';
      DeREDM.ACBrDeRE1.Eventos.Clear;

      // Erro HTTP (ex.: protocolo nao encontrado) nao gera excecao: a mensagem retorna com ErrExecutandoMetodo.
      if DeREDM.ACBrDeRE1.ConsultarLote(AProtocolo) then
      begin
        Resp := TRespostas.Create(DeREDM.ACBrDeRE1, Config.TipoResposta, Config.CodResposta);
        try
          Resp.RespostaConsulta;
          AResposta := Resp.Resposta;
        finally
          Resp.Free;
        end;

        MoverStringParaPChar(AResposta, sResposta, esTamanho);
        Result := SetRetorno(ErrOK, AResposta);
      end
      else
      begin
        AResposta := DeREDM.ACBrDeRE1.WebServices.ConsultaLote.Msg;
        MoverStringParaPChar(AResposta, sResposta, esTamanho);
        Result := SetRetorno(ErrExecutandoMetodo, AResposta);
      end;
    finally
      DeREDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibDeRE.CriarEnviarDeRE(const eArqIni: PAnsiChar; const sResposta: PAnsiChar;
  var esTamanho: integer): integer;
var
  EhArquivo: Boolean;
  AIniFile: string;
  i: Integer;
  AResposta: string;
  Resp: TRespostas;
begin
  try
    AIniFile := ConverterStringEntrada(eArqIni);

    if Config.Log.Nivel > logNormal then
      GravarLog('DeRE_CriarEnviarDeRE(' + AIniFile + ')', logCompleto, True)
    else
      GravarLog('DeRE_CriarEnviarDeRE', logNormal);

    EhArquivo := StringEhArquivo(AIniFile);
    if EhArquivo then
      VerificarArquivoExiste(AIniFile);

    DeREDM.Travar;
    try
      DeREDM.ACBrDeRE1.Eventos.LoadFromIni(AIniFile);

      if DeREDM.ACBrDeRE1.Eventos.Count = 0 then
        raise EACBrLibException.Create(ErrParametroInvalido, 'Nenhum evento encontrado no INI informado.');

      GerarSalvarEventos;

      AResposta := '';
      for i := 0 to DeREDM.ACBrDeRE1.Eventos.Gerados.Count - 1 do
      begin
        if DeREDM.ACBrDeRE1.Configuracoes.Geral.Salvar then
          AResposta := AResposta + DeREDM.ACBrDeRE1.Eventos.Gerados.Items[i].PathNome + sLineBreak;

        AResposta := AResposta + ACBrStr(Format(SMsgDeREEventoAdicionado,
          [TipoEventoDeREToStr(DeREDM.ACBrDeRE1.Eventos.Gerados.Items[i].TipoEvento)])) + sLineBreak;
      end;

      if DeREDM.ACBrDeRE1.EnviarLote then
      begin
        Resp := TRespostas.Create(DeREDM.ACBrDeRE1, Config.TipoResposta, Config.CodResposta);
        try
          Resp.RespostaEnvio;
          AResposta := AResposta + sLineBreak + Resp.Resposta;
        finally
          Resp.Free;
        end;
      end;

      DeREDM.ACBrDeRE1.Eventos.Clear;

      MoverStringParaPChar(AResposta, sResposta, esTamanho);
      Result := SetRetorno(ErrOK, AResposta);
    finally
      DeREDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibDeRE.LimparDeRE: integer;
begin
  try
    if Config.Log.Nivel > logNormal then
      GravarLog('DeRE_Limpar', logCompleto, True)
    else
      GravarLog('DeRE_Limpar', logNormal);

    DeREDM.Travar;
    try
      DeREDM.ACBrDeRE1.Eventos.Clear;
      Result := SetRetorno(ErrOK);
    finally
      DeREDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibDeRE.CarregarXMLEventoDeRE(const eArquivoOuXML: PAnsiChar): integer;
var
  EhArquivo: Boolean;
  ArquivoOuXml: string;
begin
  try
    ArquivoOuXml := ConverterStringEntrada(eArquivoOuXML);

    if Config.Log.Nivel > logNormal then
      GravarLog('DeRE_CarregarXMLEventoDeRE(' + ArquivoOuXml + ' ) ', logCompleto, True)
    else
      GravarLog('DeRE_CarregarXMLEventoDeRE', logNormal);

    EhArquivo := StringEhArquivo(ArquivoOuXml);
    if EhArquivo then
      VerificarArquivoExiste(ArquivoOuXml);

    DeREDM.Travar;
    try
      // O formato (XML ou INI) e o tipo de cada evento sao identificados pelo conteudo.
      if EhArquivo then
        DeREDM.ACBrDeRE1.Eventos.LoadFromFile(ArquivoOuXml)
      else
        DeREDM.ACBrDeRE1.Eventos.LoadFromString(ArquivoOuXml);

      Result := SetRetornoEventoCarregados(DeREDM.ACBrDeRE1.Eventos.Count);
    finally
      DeREDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibDeRE.ObterToken(const sResposta: PAnsiChar; var esTamanho: integer): integer;
var
  AResposta: string;
  Resp: TRespostas;
  Obtido: Boolean;
begin
  try
    GravarLog('DeRE_ObterToken', logNormal);

    DeREDM.Travar;
    try
      // Solicita um novo token; o componente grava Token/TokenExpira e salva o retorno (JSON).
      // Erro HTTP (ex.: 429) nao gera excecao: o resultado vem nas propriedades de retorno.
      Obtido := DeREDM.ACBrDeRE1.ObterToken;

      if Obtido then
      begin
        // Persiste no arquivo de configuracao (chaves Token e TokenExpira da secao DeRE)
        with TLibDeREConfig(Config).DeREConfig.Geral do
        begin
          Token := DeREDM.ACBrDeRE1.Configuracoes.Geral.Token;
          TokenExpira := DeREDM.ACBrDeRE1.Configuracoes.Geral.TokenExpira;
        end;
        Config.Gravar;
      end;

      Resp := TRespostas.Create(DeREDM.ACBrDeRE1, Config.TipoResposta, Config.CodResposta);
      try
        Resp.RespostaToken;
        AResposta := Resp.Resposta;
      finally
        Resp.Free;
      end;

      MoverStringParaPChar(AResposta, sResposta, esTamanho);

      // Resposta completa (HttpCodigo, MensagemErro, RetornoJson...) tanto no sucesso quanto na falha
      if Obtido then
        Result := SetRetorno(ErrOK, AResposta)
      else
        Result := SetRetorno(ErrExecutandoMetodo, AResposta);
    finally
      DeREDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibDeRE.LimparDados(eCNPJBase: PAnsiChar; const sResposta: PAnsiChar; var esTamanho: integer): integer;
var
  ACNPJBase, AResposta: string;
  Resp: TRespostas;
  Limpou: Boolean;
begin
  try
    ACNPJBase := Trim(ConverterStringEntrada(eCNPJBase));

    if Config.Log.Nivel > logNormal then
      GravarLog('DeRE_LimparDados (' + ACNPJBase + ' ) ', logCompleto, True)
    else
      GravarLog('DeRE_LimparDados', logNormal);

    DeREDM.Travar;
    try
      // Somente Producao Restrita (DELETE). Se o CNPJ base for vazio, o componente usa o do IdContribuinte.
      // Erro HTTP nao gera excecao: o resultado vem na resposta (HttpCodigo/Mensagem).
      Limpou := DeREDM.ACBrDeRE1.LimparDados(ACNPJBase);

      Resp := TRespostas.Create(DeREDM.ACBrDeRE1, Config.TipoResposta, Config.CodResposta);
      try
        Resp.RespostaLimpeza;
        AResposta := Resp.Resposta;
      finally
        Resp.Free;
      end;

      MoverStringParaPChar(AResposta, sResposta, esTamanho);

      if Limpou then
        Result := SetRetorno(ErrOK, AResposta)
      else
        Result := SetRetorno(ErrExecutandoMetodo, AResposta);
    finally
      DeREDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibDeRE.ObterIniEventos(const sResposta: PAnsiChar; var esTamanho: integer): integer;
var
  AResposta: string;
begin
  try
    GravarLog('DeRE_ObterIniEventos', logNormal);

    DeREDM.Travar;
    try
      // INI unico com todos os eventos carregados (secoes com a sequencia do evento: NomeDaSecao + NNN)
      AResposta := ConverterStringSaida(DeREDM.ACBrDeRE1.Eventos.GerarIni);
      MoverStringParaPChar(AResposta, sResposta, esTamanho);
      Result := SetRetorno(ErrOK, AResposta);
    finally
      DeREDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibDeRE.SetIDContribuinte(const aIdContribuinte: PAnsiChar): integer;
var
  IdContribuinte: AnsiString;
begin
  try
    IdContribuinte := ConverterStringEntrada(aIdContribuinte);

    if Config.Log.Nivel > logNormal then
      GravarLog('DeRE_SetIDContribuinte (' + IdContribuinte + ')', logCompleto, True)
    else
      GravarLog('DeRE_SetIDContribuinte', logNormal);

    if EstaVazio(IdContribuinte) then
      raise EACBrLibException.Create(ErrParametroInvalido, 'Valor Nulo');

    DeREDM.Travar;
    try
      DeREDM.ACBrDeRE1.Configuracoes.Geral.IdContribuinte := IdContribuinte;
      Result := SetRetorno(ErrOK);
    finally
      DeREDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibDeRE.SetVersaoDF(const sVersao: PAnsiChar): integer;
var
  versao: AnsiString;
begin
  try
    versao := ConverterStringEntrada(sVersao);

    if Config.Log.Nivel > logNormal then
      GravarLog('DeRE_SetVersaoDF(' + versao + ' ) ', logCompleto, True)
    else
      GravarLog('DeRE_SetVersaoDF', logNormal);

    DeREDM.Travar;
    try
      DeREDM.ACBrDeRE1.Configuracoes.Geral.VersaoDF := StrToVersaoDeRE(versao);
      Result := SetRetorno(ErrOK);
    finally
      DeREDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibDeRE.ObterCertificados(const sResposta: PAnsiChar; var esTamanho: integer): integer;
var
  Resposta: Ansistring;
begin
  try
    GravarLog('DeRE_ObterCertificados', logNormal);

    DeREDM.Travar;
    try
      Resposta := '';
      Resposta := ConverterStringSaida(ObterCerticados(DeREDM.ACBrDeRE1.SSL));
      MoverStringParaPChar(Resposta, sResposta, esTamanho);
      Result := SetRetorno(ErrOK, Resposta);
    finally
      DeREDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibDeRE.Validar: integer;
begin
  try
    GravarLog('DeRE_Validar', logNormal);

    DeREDM.Travar;
    try
      try
        // Gera, assina e valida os XMLs dos eventos carregados contra os schemas (XSD)
        DeREDM.ACBrDeRE1.Eventos.Gerar;
        DeREDM.ACBrDeRE1.Eventos.Assinar;
        DeREDM.ACBrDeRE1.Eventos.Validar;
        Result := SetRetornoDeREValidados(DeREDM.ACBrDeRE1.Eventos.Count);
      except
        on E: EACBrDFeException do
          Result := SetRetorno(ErrValidacaoDeRE, ConverterStringSaida(E.Message));
      end;
    finally
      DeREDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

end.
