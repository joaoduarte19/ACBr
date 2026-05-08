{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2025 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Antonio Carlos Junior, Renato Rubinho           }
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

unit ACBrLibDCeBase;

interface

uses
  Classes, SysUtils, Forms, synautil,
  ACBrUtil.FilesIO,
  ACBrLibComum, ACBrLibDCeDataModule, ACBrDFeException;

type
  { TACBrLibDCe }
  TACBrLibDCe = class(TACBrLib)
  private
    FDCeDM: TLibDCeDM;

    function SetRetornoDCeCarregados(const NumDCe: Integer): Integer;
    function SetRetornoEventoCarregados(const NumEventos: integer): integer;
  protected
    procedure CriarConfiguracao(ArqConfig: string = ''; ChaveCrypt: ansistring = ''); override;
    procedure Executar; Override;
  public
    constructor Create(ArqConfig: string = ''; ChaveCrypt: ansistring = ''); override;
    destructor Destroy; override;

    property DCeDM: TLibDCeDM read FDCeDM;

    function CarregarXML(const eArquivoOuXML: PAnsiChar): Integer;
    function CarregarINI(const eArquivoOuINI: PAnsiChar): Integer;
    function ObterXml(AIndex: Integer; const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
    function GravarXml(AIndex: Integer; const eNomeArquivo, ePathArquivo: PAnsiChar): Integer;
    function ObterIni(AIndex: Integer; const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
    function GravarIni(AIndex: Integer; const eNomeArquivo, ePathArquivo: PAnsiChar): Integer;
    function CarregarEventoXML(const eArquivoOuXML: PAnsiChar): Integer;
    function CarregarEventoINI(const eArquivoOuINI: PAnsiChar): Integer;
    function LimparLista: Integer;
    function LimparListaEventos: Integer;
    function Validar: Integer;
    function VerificarAssinatura(const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
    function GetPath(ATipo: Integer; const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
    function GetPathEvento(ACodEvento: PAnsiChar; const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
    function StatusServico(const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
    function GerarChave(ACodigoUF, ACodigoNumerico, AModelo, ASerie,
      ANumero, ATpEmi: Integer; AEmissao, ACNPJCPF: PAnsiChar;
      const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
    function ObterCertificados(const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
    function Enviar(ALote: integer; AImprimir, AZipado: boolean;
      const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
    function Assinar: Integer;
    function Consultar(const eChaveOuDCe: PAnsiChar; AExtrairEventos: boolean;
      const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
    function Cancelar(const eChave, eJustificativa, eCNPJCPF: PAnsiChar; ALote, AEmitenteDCe: Integer;
      const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
    function ImprimirPDF: Integer;
    function SalvarPDF(const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
    function ImprimirEventoPDF(const eArquivoXmlDCe, eArquivoXmlEvento: PAnsiChar): Integer;
    function SalvarEventoPDF(const eArquivoXmlDCe, eArquivoXmlEvento, sResposta: PAnsiChar; var esTamanho: Integer): Integer;
    function ValidarRegrasdeNegocios(const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
    function EnviarEmail(const ePara, eXmlDCe: PAnsiChar; const AEnviaPDF: boolean;
      const eAssunto, eCC, eAnexos, eMensagem: PAnsiChar): Integer;
    function EnviarEmailEvento(const ePara, eXmlEvento, eXmlDCe: PAnsiChar; const AEnviaPDF: boolean;
      const eAssunto, eCC, eAnexos, eMensagem: PAnsiChar): Integer;
  end;

implementation

Uses
  ACBrUtil.Base, ACBrDCe,
  ACBrUtil.Strings, ACBrDFeUtil, ACBrXmlBase,
  ACBrDCe.Conversao, ACBrDFe.Conversao,
  ACBrLibConsts, ACBrLibConfig, ACBrLibResposta,
  ACBrLibDCeConsts, ACBrLibDCeConfig,
  ACBrLibDCeRespostas, ACBrLibCertUtils;

{ TACBrLibDCe }
function TACBrLibDCe.SetRetornoDCeCarregados(const NumDCe: Integer): Integer;
begin
  Result := SetRetorno(0, Format(CInfDCeCarregados, [NumDCe]));
end;

function TACBrLibDCe.SetRetornoEventoCarregados(const NumEventos: integer): integer;
begin
  Result := SetRetorno(0, Format(CInfEventosCarregados, [NumEventos]));
end;

procedure TACBrLibDCe.CriarConfiguracao(ArqConfig: string;
  ChaveCrypt: ansistring);
begin
  fpConfig := TLibDCeConfig.Create(Self, ArqConfig, ChaveCrypt);
end;

procedure TACBrLibDCe.Executar;
begin
  inherited Executar;
  FDCeDM.AplicarConfiguracoes;
end;

constructor TACBrLibDCe.Create(ArqConfig: string; ChaveCrypt: ansistring);
begin
  inherited Create(ArqConfig, ChaveCrypt);

  FDCeDM := TLibDCeDM.Create(nil);
  FDCeDM.Lib := Self;
end;

destructor TACBrLibDCe.Destroy;
begin
  FDCeDM.Free;
  inherited Destroy;
end;

function TACBrLibDCe.CarregarXML(const eArquivoOuXML: PAnsiChar): Integer;
var
  EhArquivo: boolean;
  ArquivoOuXml: string;
begin
  try
    ArquivoOuXml := ConverterStringEntrada(eArquivoOuXML);

    if Config.Log.Nivel > logNormal then
      GravarLog('DCE_CarregarXML(' + ArquivoOuXml + ' )', logCompleto, True)
    else
      GravarLog('DCE_CarregarXML', logNormal);

    EhArquivo := StringEhArquivo(ArquivoOuXml);
    if EhArquivo then
      VerificarArquivoExiste(ArquivoOuXml);

    DCeDM.Travar;
    try
      if EhArquivo then
        DCeDM.ACBrDCe1.Declaracoes.LoadFromFile(ArquivoOuXml)
      else
        DCeDM.ACBrDCe1.Declaracoes.LoadFromString(ArquivoOuXml);

      Result := SetRetornoDCeCarregados(DCeDM.ACBrDCe1.Declaracoes.Count);
    finally
      DCeDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibDCe.CarregarINI(const eArquivoOuINI: PAnsiChar): Integer;
var
  ArquivoOuINI: string;
begin
  try
    ArquivoOuINI := ConverterStringEntrada(eArquivoOuINI);

    if Config.Log.Nivel > logNormal then
      GravarLog('DCE_CarregarINI(' + ArquivoOuINI + ' )', logCompleto, True)
    else
      GravarLog('DCE_CarregarINI', logNormal);

    if StringEhArquivo(ArquivoOuINI) then
      VerificarArquivoExiste(ArquivoOuINI);

    DCeDM.Travar;
    try
      DCeDM.ACBrDCe1.Declaracoes.LoadFromIni(ArquivoOuINI);
      Result := SetRetornoDCeCarregados(DCeDM.ACBrDCe1.Declaracoes.Count);
    finally
      DCeDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibDCe.ObterXml(AIndex: Integer; const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
var
  Resposta: Ansistring;
begin
  try
    if Config.Log.Nivel > logNormal then
      GravarLog('DCE_ObterXml(' + IntToStr(AIndex) + ' )', logCompleto, True)
    else
      GravarLog('DCE_ObterXml', logNormal);

    DCeDM.Travar;
    try
      if (DCeDM.ACBrDCe1.Declaracoes.Count < 1) or (AIndex < 0) or
         (AIndex >= DCeDM.ACBrDCe1.Declaracoes.Count) then
         raise EACBrLibException.Create(ErrIndex, Format(SErrIndex, [AIndex]));

      if EstaVazio(DCeDM.ACBrDCe1.Declaracoes.Items[AIndex].XMLOriginal) then
        DCeDM.ACBrDCe1.Declaracoes.Items[AIndex].GerarXML;

      Resposta := DCeDM.ACBrDCe1.Declaracoes.Items[AIndex].XMLOriginal;
      MoverStringParaPChar(Resposta, sResposta, esTamanho);
      Result := SetRetorno(ErrOK, Resposta);
    finally
      DCeDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibDCe.GravarXml(AIndex: Integer; const eNomeArquivo, ePathArquivo: PAnsiChar): Integer;
var
  ANomeArquivo, APathArquivo: string;
begin
  try
    ANomeArquivo := ConverterStringEntrada(eNomeArquivo);
    APathArquivo := ConverterStringEntrada(ePathArquivo);

    if Config.Log.Nivel > logNormal then
      GravarLog('DCE_GravarXml(' + IntToStr(AIndex) + ',' +
        ANomeArquivo + ',' + APathArquivo + ' )', logCompleto, True)
    else
      GravarLog('DCE_GravarXml', logNormal);

    DCeDM.Travar;
    try
      if (DCeDM.ACBrDCe1.Declaracoes.Count < 1) or (AIndex < 0) or
         (AIndex >= DCeDM.ACBrDCe1.Declaracoes.Count) then
         raise EACBrLibException.Create(ErrIndex, Format(SErrIndex, [AIndex]));

      if DCeDM.ACBrDCe1.Declaracoes.Items[AIndex].GravarXML(ANomeArquivo, APathArquivo) then
        Result := SetRetorno(ErrOK)
      else
        Result := SetRetorno(ErrGerarXml);
    finally
      DCeDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibDCe.ObterIni(AIndex: Integer; const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
var
  Resposta: Ansistring;
begin
  try
    if Config.Log.Nivel > logNormal then
      GravarLog('DCE_ObterIni(' + IntToStr(AIndex) + ' )', logCompleto, True)
    else
      GravarLog('DCE_ObterIni', logNormal);

    DCeDM.Travar;
    try
      if (DCeDM.ACBrDCe1.Declaracoes.Count < 1) or (AIndex < 0) or (AIndex >= DCeDM.ACBrDCe1.Declaracoes.Count) then
        raise EACBrLibException.Create(ErrIndex, Format(SErrIndex, [AIndex]));

      if EstaVazio(DCeDM.ACBrDCe1.Declaracoes.Items[AIndex].XMLOriginal) then
        DCeDM.ACBrDCe1.Declaracoes.Items[AIndex].GerarXML;

      Resposta := DCeDM.ACBrDCe1.Declaracoes.Items[AIndex].GerarDCeIni;
      Resposta := ConverterStringSaida( Resposta );
      MoverStringParaPChar(Resposta, sResposta, esTamanho);
      Result := SetRetorno(ErrOK, Resposta);
    finally
      DCeDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibDCe.GravarIni(AIndex: Integer; const eNomeArquivo, ePathArquivo: PAnsiChar): Integer;
var
  LDCeIni, ANomeArquivo, APathArquivo: string;
begin
  try
    ANomeArquivo := ConverterStringEntrada(eNomeArquivo);
    APathArquivo := ConverterStringEntrada(ePathArquivo);

    if Config.Log.Nivel > logNormal then
      GravarLog('DCE_GravarIni(' + IntToStr(AIndex) + ',' +
        ANomeArquivo + ',' + APathArquivo + ' )', logCompleto, True)
    else
      GravarLog('DCE_GravarIni', logNormal);

    DCeDM.Travar;
    try
      if (DCeDM.ACBrDCe1.Declaracoes.Count < 1) or (AIndex < 0) or (AIndex >= DCeDM.ACBrDCe1.Declaracoes.Count) then
        raise EACBrLibException.Create(ErrIndex, Format(SErrIndex, [AIndex]));

      ANomeArquivo := ExtractFileName(ANomeArquivo);

      if EstaVazio(ANomeArquivo) then
        raise EACBrLibException.Create(ErrExecutandoMetodo, 'Nome de arquivo não informado');

      if EstaVazio(APathArquivo) then
        APathArquivo := ExtractFilePath(ANomeArquivo);
      if EstaVazio(APathArquivo) then
        APathArquivo := DCeDM.ACBrDCe1.Configuracoes.Arquivos.PathSalvar;

      APathArquivo := PathWithDelim(APathArquivo);

      if EstaVazio(DCeDM.ACBrDCe1.Declaracoes.Items[AIndex].XMLOriginal) then
        DCeDM.ACBrDCe1.Declaracoes.Items[AIndex].GerarXML;

      LDCeIni := DCeDM.ACBrDCe1.Declaracoes.Items[AIndex].GerarDCeIni;
      if not DirectoryExists(APathArquivo) then
        ForceDirectories(APathArquivo);

      WriteToTXT(APathArquivo + ANomeArquivo, LDCeIni, False, False);
    finally
      DCeDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibDCe.CarregarEventoXML(const eArquivoOuXML: PAnsiChar): Integer;
var
  EhArquivo: boolean;
  ArquivoOuXml: string;
begin
  try
    ArquivoOuXml := ConverterStringEntrada(eArquivoOuXML);

    if Config.Log.Nivel > logNormal then
      GravarLog('DCE_CarregarEventoXML(' + ArquivoOuXml + ' )', logCompleto, True)
    else
      GravarLog('DCE_CarregarEventoXML', logNormal);

    EhArquivo := StringEhArquivo(ArquivoOuXml);
    if EhArquivo then
      VerificarArquivoExiste(ArquivoOuXml);

    DCeDM.Travar;
    try
      if EhArquivo then
        DCeDM.ACBrDCe1.EventoDCe.LerXML(ArquivoOuXml)
      else
        DCeDM.ACBrDCe1.EventoDCe.LerXMLFromString(ArquivoOuXml);

      Result := SetRetornoEventoCarregados(DCeDM.ACBrDCe1.EventoDCe.Evento.Count);
    finally
      DCeDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibDCe.CarregarEventoINI(const eArquivoOuINI: PAnsiChar): Integer;
var
  ArquivoOuINI: string;
begin
  try
    ArquivoOuINI := ConverterStringEntrada(eArquivoOuINI);

    if Config.Log.Nivel > logNormal then
      GravarLog('DCE_CarregarEventoINI(' + ArquivoOuINI + ' )', logCompleto, True)
    else
      GravarLog('DCE_CarregarEventoINI', logNormal);

    if StringEhArquivo(ArquivoOuINI) then
      VerificarArquivoExiste(ArquivoOuINI);

    DCeDM.Travar;
    try
      DCeDM.ACBrDCe1.EventoDCe.LerFromIni(ArquivoOuINI);
      Result := SetRetornoEventoCarregados(DCeDM.ACBrDCe1.EventoDCe.Evento.Count);
    finally
      DCeDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibDCe.LimparLista: Integer;
begin
  try
    GravarLog('DCE_LimparLista', logNormal);

    DCeDM.Travar;
    try
      DCeDM.ACBrDCe1.Declaracoes.Clear;
      Result := SetRetornoDCeCarregados(DCeDM.ACBrDCe1.Declaracoes.Count);
    finally
      DCeDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibDCe.LimparListaEventos: Integer;
begin
  try
    GravarLog('DCE_LimparListaEventos', logNormal);

    DCeDM.Travar;
    try
      DCeDM.ACBrDCe1.EventoDCe.Evento.Clear;
      Result := SetRetornoEventoCarregados(DCeDM.ACBrDCe1.EventoDCe.Evento.Count);
    finally
      DCeDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibDCe.Validar: Integer;
begin
  try
    GravarLog('DCE_Validar', logNormal);

    DCeDM.Travar;
    try
      try
        DCeDM.ACBrDCe1.Declaracoes.Validar;
        Result := SetRetornoDCeCarregados(DCeDM.ACBrDCe1.Declaracoes.Count);
      except
        on E: EACBrDCeException do
          Result := SetRetorno(CErrValidacaoDCe, ConverterStringSaida(E.Message));
      end;
    finally
      DCeDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibDCe.VerificarAssinatura(const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
var
  Erros: Ansistring;
begin
  try
    GravarLog('DCE_VerificarAssinatura', logNormal);

    DCeDM.Travar;
    try
      Erros := '';
      DCeDM.ACBrDCe1.Declaracoes.VerificarAssinatura(Erros);
      Erros := ConverterStringSaida(Erros);
      if Erros = '' then
        Erros := 'ok';
      MoverStringParaPChar(Erros, sResposta, esTamanho);
      Result := SetRetorno(ErrOK, Erros);
    finally
      DCeDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibDCe.GetPath(ATipo: Integer; const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
var
  Resposta: Ansistring;
begin
  try
    if Config.Log.Nivel > logNormal then
      GravarLog('DCE_GetPath(' + IntToStr(ATipo) + ' )', logCompleto, True)
    else
      GravarLog('DCE_GetPath', logNormal);

    DCeDM.Travar;
    try
      with DCeDM do
      begin
        Resposta := '';

        case ATipo of
          0: Resposta := ACBrDCe1.Configuracoes.Arquivos.GetPathDCe;
          1: Resposta := ACBrDCe1.Configuracoes.Arquivos.GetPathEvento(teCancelamento);
        end;

        Resposta := ConverterStringSaida(Resposta);
        MoverStringParaPChar(Resposta, sResposta, esTamanho);
        Result := SetRetorno(ErrOK, Resposta);
      end;
    finally
      DCeDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibDCe.GetPathEvento(ACodEvento: PAnsiChar; const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
var
  CodEvento: string;
  Resposta: Ansistring;
  ok: boolean;
begin
  try
    CodEvento := ConverterStringEntrada(ACodEvento);

    if Config.Log.Nivel > logNormal then
      GravarLog('DCE_GetPathEvento(' + CodEvento + ' )', logCompleto, True)
    else
      GravarLog('DCE_GetPathEvento', logNormal);

    DCeDM.Travar;
    try
      with DCeDM do
      begin
        Resposta := '';
        Resposta := ACBrDCe1.Configuracoes.Arquivos.GetPathEvento(StrTotpEventoDCe(ok, CodEvento));
        Resposta := ConverterStringSaida(Resposta);
        MoverStringParaPChar(Resposta, sResposta, esTamanho);
        Result := SetRetorno(ErrOK, Resposta);
      end;
    finally
      DCeDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibDCe.StatusServico(const sResposta: PAnsiChar;
  var esTamanho: Integer): Integer;
var
  Resp: TStatusServicoResposta;
  Resposta: Ansistring;
begin
  try
    GravarLog('DCE_StatusServico', logNormal);

    DCeDM.Travar;
    Resp := TStatusServicoResposta.Create(Config.TipoResposta, Config.CodResposta);
    try
      with DCeDM.ACBrDCe1 do
      begin
        WebServices.StatusServico.Executar;

        Resp.Processar(DCeDM.ACBrDCe1);
        Resposta := Resp.Gerar;
        MoverStringParaPChar(Resposta, sResposta, esTamanho);
        Result := SetRetorno(ErrOK, Resposta);
      end;
    finally
      Resp.Free;
      DCeDM.Destravar;
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

function TACBrLibDCe.GerarChave(ACodigoUF, ACodigoNumerico, AModelo, ASerie,
  ANumero, ATpEmi: Integer; AEmissao, ACNPJCPF: PAnsiChar;
  const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
var
  CNPJCPF: string;
  Emissao: TDateTime;
  Resposta: Ansistring;
begin
  try
    Emissao := StrToDate(AEmissao);
    CNPJCPF := ConverterStringEntrada(ACNPJCPF);

    if Config.Log.Nivel > logNormal then
      GravarLog('DCE_GerarChave(' + IntToStr(ACodigoUF) + ',' + IntToStr(ACodigoNumerico) + ',' + IntToStr(AModelo) +
        ',' + IntToStr(AModelo) + ',' + IntToStr(ASerie) + ',' + IntToStr(ANumero) + ',' + IntToStr(ATpEmi) +
        ',' + DateToStr(Emissao) + ',' + CNPJCPF + ' )', logCompleto, True)
    else
      GravarLog('DCE_GerarChave', logNormal);

    DCeDM.Travar;
    try
      Resposta := '';
      Resposta := GerarChaveAcesso(ACodigoUF, Emissao, CNPJCPF, ASerie, ANumero, ATpEmi, ACodigoNumerico, AModelo);
      Resposta := ConverterStringSaida(Resposta);
      MoverStringParaPChar(Resposta, sResposta, esTamanho);
      Result := SetRetorno(ErrOK, Resposta);
    finally
      DCeDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibDCe.ObterCertificados(const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
var
  Resposta: Ansistring;
begin
  try
    GravarLog('DCE_ObterCertificados', logNormal);

    DCeDM.Travar;
    try
      Resposta := '';
      Resposta := ObterCerticados(DCeDM.ACBrDCe1.SSL);
      Resposta := ConverterStringSaida(Resposta);
      MoverStringParaPChar(Resposta, sResposta, esTamanho);
      Result := SetRetorno(ErrOK, Resposta);
    finally
      DCeDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibDCe.Enviar(ALote: integer; AImprimir, AZipado: boolean;
  const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
var
  Resposta: Ansistring;
  RespEnvio: TEnvioResposta;
  ImpResp: TLibImpressaoResposta;
  i, ImpCount: integer;
begin
  try
    if Config.Log.Nivel > logNormal then
      GravarLog('DCe_Enviar(' + IntToStr(ALote) +
                 BoolToStr(AImprimir, ', Imprimir', '') +
                 BoolToStr(AZipado, ', Zipado', '') + ' )', logCompleto, True)
    else
      GravarLog('DCe_Enviar', logNormal);

    DCeDM.Travar;
    try
      with DCeDM.ACBrDCe1 do
      begin
        if Declaracoes.Count <= 0 then
          raise EACBrLibException.Create(CErrEnvio, Format(CInfDCeCarregados, [Declaracoes.Count]));

        if Declaracoes.Count > 50 then
          raise EACBrLibException.Create(CErrEnvio, 'ERRO: Conjunto de DC-e transmitidas (máximo de 50 DC-e)' +
                                                    ' excedido. Quantidade atual: ' + IntToStr(Declaracoes.Count));

        GravarLog('DCe_Enviar, Limpando Resp', logParanoico);
        Resposta := '';
        WebServices.Enviar.Clear;

        GravarLog('DCe_Enviar, Assinando', logCompleto);
        Declaracoes.Assinar;

        try
          GravarLog('DCe_Enviar, Validando', logCompleto);
          Declaracoes.Validar;
        except
          on E: EACBrDCeException do
          begin
            Result := SetRetorno(CErrValidacaoDCe, ConverterStringSaida(E.Message) );
            Exit;
          end;
        end;

        if (ALote = 0) then
          WebServices.Enviar.Lote := '1'
        else
          WebServices.Enviar.Lote := IntToStr(ALote);

        GravarLog('DCe_Enviar, Enviando', logCompleto);
        WebServices.Enviar.Zipado := AZipado;
        WebServices.Enviar.Executar;

        RespEnvio := TEnvioResposta.Create(Config.TipoResposta, Config.CodResposta);
        try
          GravarLog('DCe_Enviar, Proces.Resp Enviar', logParanoico);
          RespEnvio.Processar(DCeDM.ACBrDCe1);
          Resposta := RespEnvio.Gerar;
        finally
          RespEnvio.Free;
        end;

        if AImprimir then
        begin
          try
            DCeDM.ConfigurarImpressao;

            ImpCount := 0;
            for I := 0 to Declaracoes.Count - 1 do
            begin
              if Declaracoes.Items[I].Confirmado then
              begin
                GravarLog('DCe_Enviar, Imprindo DCe['+IntToStr(I+1)+'], '+Declaracoes.Items[I].DCe.infDCe.ID, logNormal);
                Declaracoes.Items[I].Imprimir;
                Inc(ImpCount);
              end;
            end;

            if ImpCount > 0 then
            begin
              ImpResp := TLibImpressaoResposta.Create(ImpCount, Config.TipoResposta, Config.CodResposta);
              try
                GravarLog('DCe_Enviar, Proces.Resp Impressao', logParanoico);
                Resposta := Resposta + sLineBreak + ImpResp.Gerar;
              finally
                ImpResp.Free;
              end;
            end;
          finally
            DCeDM.FinalizarImpressao;
          end;
        end;

        MoverStringParaPChar(Resposta, sResposta, esTamanho);
        Result := SetRetorno(ErrOK, Resposta);
      end;
    finally
      DCeDM.Destravar;
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

function TACBrLibDCe.Assinar: Integer;
begin
  try
    GravarLog('DCe_Assinar', logNormal);

    DCeDM.Travar;
    try
      try
        DCeDM.ACBrDCe1.Declaracoes.Assinar;
      except
        on E: EACBrDCeException do
          Result := SetRetorno(CErrAssinarDCe, ConverterStringSaida(E.Message));
      end;

      Result := SetRetornoDCeCarregados(DCeDM.ACBrDCe1.Declaracoes.Count);
    finally
      DCeDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibDCe.Consultar(const eChaveOuDCe: PAnsiChar; AExtrairEventos: boolean;
  const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
var
  EhArquivo: boolean;
  EhChave: boolean;
  ChaveOuDCe: string;
  Resp: TConsultaDCeResposta;
  Resposta: Ansistring;
begin
  EhChave := False;
  try
    ChaveOuDCe := ConverterStringSaida(eChaveOuDCe);

    if Config.Log.Nivel > logNormal then
      GravarLog('DCE_Consultar(' + ChaveOuDCe + ', ' +
        BoolToStr(AExtrairEventos, True) + ' )', logCompleto, True)
    else
      GravarLog('DCE_Consultar', logNormal);

    DCeDM.Travar;
    try
      EhArquivo := StringEhArquivo(ChaveOuDCe);

      if EhArquivo then
      begin
        VerificarArquivoExiste(ChaveOuDCe);
        DCeDM.ACBrDCe1.Declaracoes.LoadFromFile(ChaveOuDCe);
      end
      else
      begin
        EhChave := ValidarChave(ChaveOuDCe);
        if not EhChave then
          DCeDM.ACBrDCe1.Declaracoes.LoadFromString(ChaveOuDCe);
      end;

      if DCeDM.ACBrDCe1.Declaracoes.Count = 0 then
      begin
        if EhChave then
          DCeDM.ACBrDCe1.WebServices.Consulta.DCeChave := ChaveOuDCe
        else
          raise EACBrLibException.Create(CErrChaveDCe, Format(CErrChaveInvalida, [ChaveOuDCe]));
      end
      else
        DCeDM.ACBrDCe1.WebServices.Consulta.DCeChave := DCeDM.ACBrDCe1.Declaracoes.Items[DCeDM.ACBrDCe1.Declaracoes.Count - 1].NumID;

      DCeDM.ACBrDCe1.WebServices.Consulta.ExtrairEventos := AExtrairEventos;

      Resp := TConsultaDCeResposta.Create(Config.TipoResposta, Config.CodResposta);
      try
        with DCeDM.ACBrDCe1 do
        begin
          WebServices.Consulta.Executar;
          Resp.Processar(DCeDM.ACBrDCe1);

          Resposta := Resp.Gerar;
          MoverStringParaPChar(Resposta, sResposta, esTamanho);
          Result := SetRetorno(ErrOK, Resposta);
        end;
      finally
        Resp.Free;
      end;
    finally
      DCeDM.Destravar;
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

function TACBrLibDCe.Cancelar(const eChave, eJustificativa, eCNPJCPF: PAnsiChar; ALote, AEmitenteDCe: Integer;
  const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
var
  AChave, AJustificativa, ACNPJCPF: String;
  Resp: TCancelamentoResposta;
  Resposta: AnsiString;
begin
  try
    AChave := ConverterStringEntrada(eChave);
    AJustificativa := ConverterStringEntrada(eJustificativa);
    ACNPJCPF := ConverterStringEntrada(eCNPJCPF);

    if Config.Log.Nivel > logNormal then
      GravarLog('DCE_Cancelar(' + AChave + ',' + AJustificativa + ',' + ACNPJCPF + ',' + IntToStr(ALote) + ',' +
        IntToStr(AEmitenteDCe) + ' )', logCompleto, True)
    else
      GravarLog('DCE_Cancelar', logNormal);

    DCeDM.Travar;
    try
      if not ValidarChave(AChave) then
        raise EACBrLibException.Create(CErrChaveDCe, Format(CErrChaveInvalida, [AChave]))
      else
        DCeDM.ACBrDCe1.WebServices.Consulta.DCeChave := AChave;

      if (not DCeDM.ACBrDCe1.WebServices.Consulta.Executar) or
         (DCeDM.ACBrDCe1.WebServices.Consulta.Protocolo = '') then
        raise EACBrLibException.Create(CErrConsulta, DCeDM.ACBrDCe1.WebServices.Consulta.Msg);

      DCeDM.ACBrDCe1.EventoDCe.Evento.Clear;
      with DCeDM.ACBrDCe1.EventoDCe.Evento.New do
      begin
        InfEvento.CNPJCPF := ACNPJCPF;
        if Trim(Infevento.CNPJCPF) = '' then
          InfEvento.CNPJCPF := Copy(OnlyNumber(DCeDM.ACBrDCe1.WebServices.Consulta.DCeChave), 7, 14)
        else
        begin
          if not ValidarCNPJouCPF(ACNPJCPF) then
            raise EACBrLibException.Create(CErrCNPJ, Format(CErrCNPJCPFInvalido, [ACNPJCPF]));
        end;

        infEvento.CNPJCPFEmit := InfEvento.CNPJCPF;
        infEvento.tpEmit := StrToEmitenteDCe(IntToStr(AEmitenteDCe));
        InfEvento.nSeqEvento := 1;
        InfEvento.tpAmb := TACBrTipoAmbiente(DCeDM.ACBrDCe1.Configuracoes.WebServices.Ambiente);
        InfEvento.cOrgao := StrToIntDef(Copy(OnlyNumber(DCeDM.ACBrDCe1.WebServices.Consulta.DCeChave), 1, 2), 0);
        InfEvento.dhEvento := Now;
        InfEvento.tpEvento := teCancelamento;
        InfEvento.chDCe := DCeDM.ACBrDCe1.WebServices.Consulta.DCeChave;
        InfEvento.detEvento.nProt := DCeDM.ACBrDCe1.WebServices.Consulta.Protocolo;
        InfEvento.detEvento.xJust := AJustificativa;
      end;

      if (ALote = 0) then
        ALote := 1;

      DCeDM.ACBrDCe1.WebServices.EnvEvento.idLote := ALote;
      DCeDM.ACBrDCe1.WebServices.EnvEvento.Executar;

      Resp := TCancelamentoResposta.Create(Config.TipoResposta, Config.CodResposta);
      try
        Resp.Processar(DCeDM.ACBrDCe1);
        Resposta := Resp.Gerar;
      finally
        Resp.Free;
      end;

      MoverStringParaPChar(Resposta, sResposta, esTamanho);
      Result := SetRetorno(ErrOK, Resposta);
    finally
      DCeDM.Destravar;
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

function TACBrLibDCe.ImprimirPDF: Integer;
var
  Resposta: TLibImpressaoResposta;
begin
  try
    GravarLog('DCe_ImprimirPDF', logNormal);

    DCeDM.Travar;
    try
      if DCeDM.ACBrDCe1.Declaracoes.Count <= 0 then
        raise EACBrLibException.Create(CErrEnvio, Format(CInfDCeCarregados, [DCeDM.ACBrDCe1.Declaracoes.Count]));

      Resposta := TLibImpressaoResposta.Create(DCeDM.ACBrDCe1.Declaracoes.Count, Config.TipoResposta, Config.CodResposta);
      try
        DCeDM.ConfigurarImpressao('', True);
        try
          DCeDM.ACBrDCe1.Declaracoes.ImprimirPDF;
          Resposta.Msg := DCeDM.ACBrDCe1.DACE.ArquivoPDF;
          Result := SetRetorno(ErrOK, Resposta.Gerar);
        finally
          DCeDM.FinalizarImpressao;
        end;
      finally
        Resposta.Free;
      end;
    finally
      DCeDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibDCe.SalvarPDF(const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
var
  AStream: TMemoryStream;
  Resposta: AnsiString;
begin
  try
    GravarLog('DCe_SalvarPDF', logNormal);

    DCeDM.Travar;
    try
      if DCeDM.ACBrDCe1.Declaracoes.Count <= 0 then
        raise EACBrLibException.Create(CErrEnvio, Format(CInfDCeCarregados, [DCeDM.ACBrDCe1.Declaracoes.Count]));

      AStream := TMemoryStream.Create;
      try
        DCeDM.ConfigurarImpressao('', True);

        DCeDM.ACBrDCe1.DACE.ImprimirDACEPDF(AStream);
        Resposta := StreamToBase64(AStream);

        MoverStringParaPChar(Resposta, sResposta, esTamanho);
        Result := SetRetorno(ErrOK, Resposta);
      finally
        DCeDM.FinalizarImpressao;
        AStream.Free;
      end;
    finally
      DCeDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibDCe.ImprimirEventoPDF(const eArquivoXmlDCe, eArquivoXmlEvento: PAnsiChar): Integer;
var
  EhArquivo: boolean;
  AArquivoXmlDCe: string;
  AArquivoXmlEvento: string;
  Resposta: TLibImpressaoResposta;
begin
  try
    AArquivoXmlDCe := ConverterStringEntrada(eArquivoXmlDCe);
    AArquivoXmlEvento := ConverterStringEntrada(eArquivoXmlEvento);

    if Config.Log.Nivel > logNormal then
      GravarLog('DCe_ImprimirEventoPDF(' + AArquivoXmlDCe + ',' + AArquivoXmlEvento + ' )', logCompleto, True)
    else
      GravarLog('DCe_ImprimirEventoPDF', logNormal);

    DCeDM.Travar;
    try
      Resposta := TLibImpressaoResposta.Create(DCeDM.ACBrDCe1.EventoDCe.Evento.Count, Config.TipoResposta, Config.CodResposta);
      try
        EhArquivo := StringEhArquivo(AArquivoXmlDCe);

        if EhArquivo then
          VerificarArquivoExiste(AArquivoXmlDCe);

        if EhArquivo then
          DCeDM.ACBrDCe1.Declaracoes.LoadFromFile(AArquivoXmlDCe)
        else
          DCeDM.ACBrDCe1.Declaracoes.LoadFromString(AArquivoXmlDCe);

        if DCeDM.ACBrDCe1.Declaracoes.Count <= 0 then
          raise EACBrLibException.Create(CErrEnvio, Format(CInfDCeCarregados, [DCeDM.ACBrDCe1.Declaracoes.Count]));

        EhArquivo := StringEhArquivo(AArquivoXmlEvento);

        if EhArquivo then
          VerificarArquivoExiste(AArquivoXmlEvento);

        if EhArquivo then
          DCeDM.ACBrDCe1.EventoDCe.LerXML(AArquivoXmlEvento)
        else
          DCeDM.ACBrDCe1.EventoDCe.LerXMLFromString(AArquivoXmlEvento);

        DCeDM.ConfigurarImpressao('', True);
        DCeDM.ACBrDCe1.ImprimirEventoPDF;

        Resposta.Msg := DCeDM.ACBrDCe1.DACE.ArquivoPDF;
        Result := SetRetorno(ErrOK, Resposta.Gerar);
      finally
        DCeDM.FinalizarImpressao;
        Resposta.Free;
      end;
    finally
      DCeDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibDCe.SalvarEventoPDF(const eArquivoXmlDCe, eArquivoXmlEvento,
  sResposta: PAnsiChar; var esTamanho: Integer): Integer;
var
  EhArquivo: boolean;
  AArquivoXmlDCe: string;
  AArquivoXmlEvento: string;
  AStream: TMemoryStream;
  Resposta: Ansistring;
begin
  try
    AArquivoXmlDCe := ConverterStringEntrada(eArquivoXmlDCe);
    AArquivoXmlEvento := ConverterStringEntrada(eArquivoXmlEvento);

    if Config.Log.Nivel > logNormal then
      GravarLog('DCe_SalvarEventoPDF(' + AArquivoXmlDCe + ',' + AArquivoXmlEvento + ' )', logCompleto, True)
    else
      GravarLog('DCe_SalvarEventoPDF', logNormal);

    DCeDM.Travar;
    try
      AStream := TMemoryStream.Create;
      try
        EhArquivo := StringEhArquivo(AArquivoXmlDCe);

        if EhArquivo then
          VerificarArquivoExiste(AArquivoXmlDCe);

        if EhArquivo then
          DCeDM.ACBrDCe1.Declaracoes.LoadFromFile(AArquivoXmlDCe)
        else
          DCeDM.ACBrDCe1.Declaracoes.LoadFromString(AArquivoXmlDCe);

        if DCeDM.ACBrDCe1.Declaracoes.Count <= 0 then
          raise EACBrLibException.Create(CErrEnvio, Format(CInfDCeCarregados, [DCeDM.ACBrDCe1.Declaracoes.Count]));

        EhArquivo := StringEhArquivo(AArquivoXmlEvento);

        if EhArquivo then
          VerificarArquivoExiste(AArquivoXmlEvento);

        if EhArquivo then
          DCeDM.ACBrDCe1.EventoDCe.LerXML(AArquivoXmlEvento)
        else
          DCeDM.ACBrDCe1.EventoDCe.LerXMLFromString(AArquivoXmlEvento);

        DCeDM.ConfigurarImpressao('', True);
        DCeDM.ACBrDCe1.DACE.ImprimirEventoPDF(AStream);

        Resposta := StreamToBase64(AStream);

        MoverStringParaPChar(Resposta, sResposta, esTamanho);
        Result := SetRetorno(ErrOK, Resposta);
      finally
        DCeDM.FinalizarImpressao;
        AStream.Free;
      end;
    finally
      DCeDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibDCe.ValidarRegrasdeNegocios(const sResposta: PAnsiChar; var esTamanho: Integer): Integer;
var
  Erros: Ansistring;
begin
  try
    GravarLog('DCE_ValidarRegrasdeNegocios', logNormal);

    DCeDM.Travar;
    try
      Erros := '';
      DCeDM.ACBrDCe1.Declaracoes.ValidarRegrasdeNegocios(Erros);
      Erros := ConverterStringSaida(Erros);
      MoverStringParaPChar(Erros, sResposta, esTamanho);
      Result := SetRetorno(ErrOK, Erros);
    finally
      DCeDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibDCe.EnviarEmail(const ePara, eXmlDCe: PAnsiChar; const AEnviaPDF: boolean;
  const eAssunto, eCC, eAnexos, eMensagem: PAnsiChar): Integer;
var
  Resposta, APara, AXmlDCe, AAssunto, ACC, AAnexos, AMensagem: string;
  slMensagemEmail, slCC, slAnexos: TStringList;
  EhArquivo, LXmlCarregado: boolean;
  Resp: TLibDCeResposta;
  LDCeEnviar : TACBrDCe;
begin
  try
    APara := ConverterStringEntrada(ePara);
    AXmlDCe := ConverterStringEntrada(eXmlDCe);
    AAssunto := ConverterStringEntrada(eAssunto);
    ACC := ConverterStringEntrada(eCC);
    AAnexos := ConverterStringEntrada(eAnexos);
    AMensagem := ConverterStringEntrada(eMensagem);

    if Config.Log.Nivel > logNormal then
      GravarLog('DCe_EnviarEmail(' + APara + ',' + AXmlDCe + ',' + BoolToStr(AEnviaPDF, 'PDF', '') + ',' + AAssunto
                 + ',' + ACC + ',' + AAnexos + ',' + AMensagem + ' )', logCompleto, True)
    else
      GravarLog('DCe_EnviarEmail', logNormal);

    DCeDM.Travar;
    try
      LDCeEnviar := TACBrDCe.Create(nil);
      try
        EhArquivo := StringEhArquivo(AXmlDCe);

        if EhArquivo then
          VerificarArquivoExiste(AXmlDCe);

        if EhArquivo then
          LXmlCarregado := LDCeEnviar.Declaracoes.LoadFromFile(AXmlDCe)
        else
          LXmlCarregado := LDCeEnviar.Declaracoes.LoadFromString(AXmlDCe);

        if not LXmlCarregado then
          raise EACBrLibException.Create(CErrEnvio, 'Erro Caminho ou conteudo do XML inválido, não foi possível fazer a leitura do conteúdo do XML');

        if LDCeEnviar.Declaracoes.Count = 0 then
          raise EACBrLibException.Create(CErrEnvio, Format(CInfDCeCarregados, [LDCeEnviar.Declaracoes.Count]));

        slMensagemEmail := TStringList.Create;
        slCC := TStringList.Create;
        slAnexos := TStringList.Create;

        Resp := TLibDCeResposta.Create('EnviaEmail', Config.TipoResposta, Config.CodResposta);

        if AEnviaPDF then
          DCeDM.ConfigurarImpressao('', True, '', LDCeEnviar);

        LDCeEnviar.MAIL := DCeDM.ACBrMail1;
        try
          slMensagemEmail.DelimitedText := sLineBreak;
          slMensagemEmail.Text := StringReplace(AMensagem, ';', sLineBreak, [rfReplaceAll]);

          slCC.DelimitedText := sLineBreak;
          slCC.Text := StringReplace(ACC, ';', sLineBreak, [rfReplaceAll]);

          slAnexos.DelimitedText := sLineBreak;
          slAnexos.Text := StringReplace(AAnexos, ';', sLineBreak, [rfReplaceAll]);

          LDCeEnviar.Declaracoes[0].EnviarEmail(
                APara,
                AAssunto,
                slMensagemEmail,
                AEnviaPDF,
                slCC,
                slAnexos);

          Resp.Msg := 'Email enviado com sucesso';
          Resposta := Resp.Gerar;

          Result := SetRetorno(ErrOK, Resposta);
        finally
          Resp.Free;
          slCC.Free;
          slAnexos.Free;
          slMensagemEmail.Free;

          if (AEnviaPDF) then DCeDM.FinalizarImpressao;
        end;
      finally
        LDCeEnviar.Free;
      end;
    finally
      DCeDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

function TACBrLibDCe.EnviarEmailEvento(const ePara, eXmlEvento, eXmlDCe: PAnsiChar; const AEnviaPDF: boolean;
  const eAssunto, eCC, eAnexos, eMensagem: PAnsiChar): Integer;
var
  APara, AXmlEvento, AXmlDCe, AAssunto, ACC, AAnexos, AMensagem, ArqPDF: string;
  LNomeArq: string;
  LStream: TStream;
  slMensagemEmail, slCC, slAnexos: TStringList;
  EhArquivo: boolean;
  EhArquivoEvento: boolean;
  Resposta: TLibDCeResposta;
  LDCeEnviar : TACBrDCe;
begin
  try
    APara := ConverterStringEntrada(ePara);
    AXmlEvento := ConverterStringEntrada(eXmlEvento);
    AXmlDCe := ConverterStringEntrada(eXmlDCe);
    AAssunto := ConverterStringEntrada(eAssunto);
    ACC := ConverterStringEntrada(eCC);
    AAnexos := ConverterStringEntrada(eAnexos);
    AMensagem := ConverterStringEntrada(eMensagem);

    if Config.Log.Nivel > logNormal then
      GravarLog('DCe_EnviarEmailEvento(' + APara + ',' + AXmlEvento + ',' + AXmlDCe + ',' +
                 BoolToStr(AEnviaPDF, 'PDF', '') + ',' + AAssunto + ',' + ACC + ',' + AAnexos + ',' + AMensagem +
                 ' )', logCompleto, True)
    else
      GravarLog('DCe_EnviarEmailEvento', logNormal);

    DCeDM.Travar;
    try
      LDCeEnviar := TACBrDCe.Create(nil);
      try
        with LDCeEnviar do
        begin
          EventoDCe.Evento.Clear;
          Declaracoes.Clear;

          EhArquivoEvento := StringEhArquivo(AXmlEvento);

          if EhArquivoEvento then
            VerificarArquivoExiste(AXmlEvento);

          if EhArquivoEvento then
            EventoDCe.LerXML(AXmlEvento)
          else
            EventoDCe.LerXMLFromString(AXmlEvento);

          EhArquivo := StringEhArquivo(AXmlDCe);

          if EhArquivo then
            VerificarArquivoExiste(AXmlDCe);

          if EhArquivo then
            Declaracoes.LoadFromFile(AXmlDCe)
          else
            Declaracoes.LoadFromString(AXmlDCe);

          if Declaracoes.Count <= 0 then
            raise EACBrLibException.Create(CErrEnvio, Format(CInfDCeCarregados, [Declaracoes.Count]));

          if EventoDCe.Evento.Count = 0 then
            raise EACBrLibException.Create(CErrEnvio, Format(CInfEventosCarregados, [EventoDCe.Evento.Count]))
          else
          begin
            slMensagemEmail := TStringList.Create;
            slCC := TStringList.Create;
            slAnexos := TStringList.Create;
            Resposta := TLibDCeResposta.Create('EnviaEmail', Config.TipoResposta, Config.CodResposta);
            LStream := TMemoryStream.Create;

            try
              LNomeArq := OnlyNumber(EventoDCe.Evento[0].Infevento.id) + '-procEventoDCe';

              if AEnviaPDF then
              begin
                try
                  DCeDM.ConfigurarImpressao('', True, '', LDCeEnviar);
                  ImprimirEventoPDF;

                  ArqPDF := PathWithDelim(DACE.PathPDF) + LNomeArq + '.pdf';
                except
                  raise EACBrLibException.Create(CErrRetorno, 'Erro ao criar o arquivo PDF');
                end;
              end;

              MAIL := DCeDM.ACBrMail1;
              with MAIL do
              begin
                slMensagemEmail.DelimitedText := sLineBreak;
                slMensagemEmail.Text := StringReplace(AMensagem, ';', sLineBreak, [rfReplaceAll]);

                slCC.DelimitedText := sLineBreak;
                slCC.Text := StringReplace(ACC, ';', sLineBreak, [rfReplaceAll]);

                slAnexos.DelimitedText := sLineBreak;
                slAnexos.Text := StringReplace(AAnexos, ';', sLineBreak, [rfReplaceAll]);

                if EhArquivoEvento then
                  slAnexos.Add(AXmlEvento)
                else
                begin
                  LNomeArq := LNomeArq + '.xml';
                  LStream.Size := 0;
                  WriteStrToStream(LStream, AnsiString(AXmlEvento));
                end;

                if AEnviaPDF then
                  slAnexos.Add(ArqPDF);

                try
                  if EhArquivoEvento then
                  begin
                    EnviarEmail(
                       APara,
                       AAssunto,
                       slMensagemEmail,
                       slCC,
                       slAnexos);
                  end
                  else
                  begin
                    EnviarEmail(
                       APara,
                       AAssunto,
                       slMensagemEmail,
                       slCC,
                       slAnexos,
                       LStream,
                       LNomeArq);
                  end;

                  Resposta.Msg := 'Email enviado com sucesso';
                  Result := SetRetorno(ErrOK, Resposta.Gerar);
                except
                  on E: Exception do
                    raise EACBrLibException.Create(CErrRetorno, 'Erro ao enviar email' + sLineBreak + E.Message);
                end;
              end;
            finally
              LStream.Free;
              Resposta.Free;
              slCC.Free;
              slAnexos.Free;
              slMensagemEmail.Free;
              if (AEnviaPDF) then DCeDM.FinalizarImpressao;
            end;
          end;
        end;
      finally
        LDCeEnviar.Free;
      end;
    finally
      DCeDM.Destravar;
    end;
  except
    on E: EACBrLibException do
      Result := SetRetorno(E.Erro, ConverterStringSaida(E.Message));

    on E: Exception do
      Result := SetRetorno(ErrExecutandoMetodo, ConverterStringSaida(E.Message));
  end;
end;

end.

