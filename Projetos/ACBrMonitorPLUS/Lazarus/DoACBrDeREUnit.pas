{*******************************************************************************}
{ Projeto: ACBrMonitor                                                          }
{  Executavel multiplataforma que faz uso do conjunto de componentes ACBr para  }
{ criar uma interface de comunicação com equipamentos de automacao comercial.   }
{                                                                               }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida                }
{                                                                               }
{ Colaboradores nesse arquivo: Renato Rubinho                                   }
{                                                                               }
{  Você pode obter a última versão desse arquivo na pagina do  Projeto ACBr     }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr       }
{                                                                               }
{  Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la  }
{ sob os termos da Licença Pública Geral Menor do GNU conforme publicada pela   }
{ Free Software Foundation; tanto a versão 2.1 da Licença, ou (a seu critério)  }
{ qualquer versão posterior.                                                    }
{                                                                               }
{  Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM    }
{ NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU       }
{ ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor }
{ do GNU para mais detalhes. (Arquivo LICENÇA.TXT ou LICENSE.TXT)               }
{                                                                               }
{  Você deve ter recebido uma cópia da Licença Pública Geral Menor do GNU junto }
{ com esta biblioteca; se não, escreva para a Free Software Foundation, Inc.,   }
{ no endereço 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.           }
{ Você também pode obter uma copia da licença em:                               }
{ http://www.opensource.org/licenses/gpl-license.php                            }
{                                                                               }
{ Daniel Simões de Almeida - daniel@projetoacbr.com.br - www.projetoacbr.com.br }

{$I ACBr.inc}

unit DoACBrDeREUnit;

interface

uses
  Classes, SysUtils, ACBrUtil.Base, ACBrUtil.Strings, ACBrUtil.FilesIO,
  ACBrLibDeRERespostas, ACBrDeRE, ACBrDeRE.Conversao, ACBrLibResposta,
  ACBrMonitorConfig, ACBrMonitorConsts, UtilUnit, DoACBrDFeUnit, CmdUnit,
  ACBrLibConfig;

// Data/hora do token no formato dd/mm/yyyy hh:nn:ss (vazio/invalido = 0)
function DeREStrToDataHora(const AValor: String): TDateTime;
function DeREDataHoraToStr(const AValor: TDateTime): String;

type

{ TACBrObjetoDeRE }

TACBrObjetoDeRE = class(TACBrObjetoDFe)
private
  fACBrDeRE: TACBrDeRE;
  procedure GerarSalvarEventos;
public
  constructor Create(AConfig: TMonitorConfig; ACBrDeRE: TACBrDeRE); reintroduce;
  procedure Executar(ACmd: TACBrCmd); override;

  procedure RespostaEnvio;
  procedure RespostaConsulta;
  procedure RespostaToken;
  procedure RespostaLimpeza;

  property ACBrDeRE: TACBrDeRE read fACBrDeRE;
end;

{ TMetodoCriarEventoDeRE }

TMetodoCriarEventoDeRE = class(TACBrMetodo)
public
  procedure Executar; override;
end;

{ TMetodoEnviarDeRE }

TMetodoEnviarDeRE = class(TACBrMetodo)
public
  procedure Executar; override;
end;

{ TMetodoConsultarDeRE }

TMetodoConsultarDeRE = class(TACBrMetodo)
public
  procedure Executar; override;
end;

{ TMetodoCriarEnviarDeRE }

TMetodoCriarEnviarDeRE = class(TACBrMetodo)
public
  procedure Executar; override;
end;

{ TMetodoLimparDeRE }

TMetodoLimparDeRE = class(TACBrMetodo)
public
  procedure Executar; override;
end;

{ TMetodoCarregarXMLEventoDeRE }

TMetodoCarregarXMLEventoDeRE = class(TACBrMetodo)
public
  procedure Executar; override;
end;

{ TMetodoObterIniEventosDeRE }

TMetodoObterIniEventosDeRE = class(TACBrMetodo)
public
  procedure Executar; override;
end;

{ TMetodoSetIDContribuinteDeRE }

TMetodoSetIDContribuinteDeRE = class(TACBrMetodo)
public
  procedure Executar; override;
end;

{ TMetodoSetVersaoDFDeRE }

TMetodoSetVersaoDFDeRE = class(TACBrMetodo)
public
  procedure Executar; override;
end;

{ TMetodoSetAmbienteDeRE }

TMetodoSetAmbienteDeRE = class(TACBrMetodo)
public
  procedure Executar; override;
end;

{ TMetodoValidarDeRE }

TMetodoValidarDeRE = class(TACBrMetodo)
public
  procedure Executar; override;
end;

{ TMetodoCertificadoDataVencimentoDeRE }

TMetodoCertificadoDataVencimentoDeRE = class(TACBrMetodo)
public
  procedure Executar; override;
end;

{ TMetodoCNPJCertificadoDeRE }

TMetodoCNPJCertificadoDeRE = class(TACBrMetodo)
public
  procedure Executar; override;
end;

{ TMetodoVersaoDeRE }

TMetodoVersaoDeRE = class(TACBrMetodo)
public
  procedure Executar; override;
end;

{ TMetodoObterTokenDeRE }

TMetodoObterTokenDeRE = class(TACBrMetodo)
public
  procedure Executar; override;
end;

{ TMetodoLimparDadosDeRE }

TMetodoLimparDadosDeRE = class(TACBrMetodo)
public
  procedure Executar; override;
end;

implementation

uses
  IniFiles, DateUtils, Forms, ACBrDFeConfiguracoes, DoACBrUnit;

const
  CMetodoDeRECriarEventoDeRE = 'criareventodere';
  CMetodoDeREEnviarDeRE = 'enviardere';
  CMetodoDeREConsultarDeRE = 'consultardere';
  CMetodoDeRECriarEnviarDeRE = 'criarenviardere';
  CMetodoDeRELimparDeRE = 'limpardere';
  CMetodoDeRECarregarXMLEventoDeRE = 'carregarxmleventodere';
  CMetodoDeREObterIniEventos = 'obterinieventos';
  CMetodoDeRESetIDContribuinte = 'setidcontribuinte';
  CMetodoDeRESetVersaoDF = 'setversaodf';
  CMetodoDeRESetAmbiente = 'setambiente';
  CMetodoDeREValidar = 'validardere';
  CMetodoDeRECertificadoDataVencimento = 'certificadodatavencimento';
  CMetodoDeRECNPJCertificado = 'cnpjcertificado';
  CMetodoDeREVersao = 'versao';
  CMetodoDeREObterToken = 'obtertoken';
  CMetodoDeRELimparDados = 'limpardados';

function DeREStrToDataHora(const AValor: String): TDateTime;
var
  FS: TFormatSettings;
begin
  FS := DefaultFormatSettings;
  FS.DateSeparator := '/';
  FS.ShortDateFormat := 'dd/mm/yyyy';
  FS.TimeSeparator := ':';
  FS.LongTimeFormat := 'hh:nn:ss';
  Result := StrToDateTimeDef(Trim(AValor), 0, FS);
end;

function DeREDataHoraToStr(const AValor: TDateTime): String;
begin
  if AValor = 0 then
    Result := ''
  else
    Result := FormatDateTime('dd/mm/yyyy hh:nn:ss', AValor);
end;

{ TACBrObjetoDeRE }

constructor TACBrObjetoDeRE.Create(AConfig: TMonitorConfig; ACBrDeRE: TACBrDeRE);
begin
  inherited Create(AConfig);

  fACBrDeRE := ACBrDeRE;

  ListaDeMetodos.Add(CMetodoDeRECriarEventoDeRE);
  ListaDeMetodos.Add(CMetodoDeREEnviarDeRE);
  ListaDeMetodos.Add(CMetodoDeREConsultarDeRE);
  ListaDeMetodos.Add(CMetodoDeRECriarEnviarDeRE);
  ListaDeMetodos.Add(CMetodoDeRELimparDeRE);
  ListaDeMetodos.Add(CMetodoDeRECarregarXMLEventoDeRE);
  ListaDeMetodos.Add(CMetodoDeREObterIniEventos);
  ListaDeMetodos.Add(CMetodoDeRESetIDContribuinte);
  ListaDeMetodos.Add(CMetodoDeRESetVersaoDF);
  ListaDeMetodos.Add(CMetodoDeRESetAmbiente);
  ListaDeMetodos.Add(CMetodoDeREValidar);
  ListaDeMetodos.Add(CMetodoDeRECertificadoDataVencimento);
  ListaDeMetodos.Add(CMetodoDeRECNPJCertificado);
  ListaDeMetodos.Add(CMetodoDeREVersao);
  ListaDeMetodos.Add(CMetodoDeREObterToken);
  ListaDeMetodos.Add(CMetodoDeRELimparDados);

  // DoACBr
  ListaDeMetodos.Add(CMetodoSavetofile);
  ListaDeMetodos.Add(CMetodoLoadfromfile);
  ListaDeMetodos.Add(CMetodoLerini);
  ListaDeMetodos.Add(CMetodoSetcertificado);
  ListaDeMetodos.Add(CMetodoRestaurar);
  ListaDeMetodos.Add(CMetodoOcultar);
  ListaDeMetodos.Add(CMetodoEncerrarmonitor);
  ListaDeMetodos.Add(CMetodoAtivo);
  ListaDeMetodos.Add(CMetodoDatahora);
  ListaDeMetodos.Add(CMetodoData);
  ListaDeMetodos.Add(CMetodoHora);
  ListaDeMetodos.Add(CMetodoExit);
  ListaDeMetodos.Add(CMetodoBye);
  ListaDeMetodos.Add(CMetodoFim);
  ListaDeMetodos.Add(CMetodoSair);
end;

procedure TACBrObjetoDeRE.Executar(ACmd: TACBrCmd);
var
  AMetodoClass: TACBrMetodoClass;
  CmdNum: Integer;
  Ametodo: TACBrMetodo;
  AACBrUnit: TACBrObjetoACBr;
begin
  inherited Executar(ACmd);

  CmdNum := ListaDeMetodos.IndexOf(LowerCase(ACmd.Metodo));
  AMetodoClass := Nil;

  case CmdNum of
    0  : AMetodoClass := TMetodoCriarEventoDeRE;
    1  : AMetodoClass := TMetodoEnviarDeRE;
    2  : AMetodoClass := TMetodoConsultarDeRE;
    3  : AMetodoClass := TMetodoCriarEnviarDeRE;
    4  : AMetodoClass := TMetodoLimparDeRE;
    5  : AMetodoClass := TMetodoCarregarXMLEventoDeRE;
    6  : AMetodoClass := TMetodoObterIniEventosDeRE;
    7  : AMetodoClass := TMetodoSetIDContribuinteDeRE;
    8  : AMetodoClass := TMetodoSetVersaoDFDeRE;
    9  : AMetodoClass := TMetodoSetAmbienteDeRE;
    10 : AMetodoClass := TMetodoValidarDeRE;
    11 : AMetodoClass := TMetodoCertificadoDataVencimentoDeRE;
    12 : AMetodoClass := TMetodoCNPJCertificadoDeRE;
    13 : AMetodoClass := TMetodoVersaoDeRE;
    14 : AMetodoClass := TMetodoObterTokenDeRE;
    15 : AMetodoClass := TMetodoLimparDadosDeRE;
  else
    begin
      AACBrUnit := TACBrObjetoACBr.Create(Nil); //Instancia DoACBrUnit para validar métodos padrão para todos os objetos
      try
        AACBrUnit.Executar(ACmd);
      finally
        AACBrUnit.Free;
      end;
    end;
  end;

  if Assigned(AMetodoClass) then
  begin
    Ametodo := AMetodoClass.Create(ACmd, Self);
    try
      Ametodo.Executar;
    finally
      Ametodo.Free;
    end;
  end;
end;

procedure TACBrObjetoDeRE.GerarSalvarEventos;
begin
  // Gera, assina e valida o XML de todos os eventos carregados e salva em disco
  fACBrDeRE.Eventos.GerarXMLs;
  fACBrDeRE.Eventos.SaveToFiles;
end;

procedure TACBrObjetoDeRE.RespostaEnvio;
var
  Resp: TRespostas;
begin
  Resp := TRespostas.Create(fACBrDeRE, TpResp, codUTF8);
  try
    Resp.RespostaEnvio;
    fpCmd.Resposta := fpCmd.Resposta + sLineBreak + Resp.Resposta;
  finally
    Resp.Free;
  end;
end;

procedure TACBrObjetoDeRE.RespostaToken;
var
  Resp: TRespostas;
begin
  Resp := TRespostas.Create(fACBrDeRE, TpResp, codUTF8);
  try
    Resp.RespostaToken;
    fpCmd.Resposta := fpCmd.Resposta + sLineBreak + Resp.Resposta;
  finally
    Resp.Free;
  end;
end;

procedure TACBrObjetoDeRE.RespostaLimpeza;
var
  Resp: TRespostas;
begin
  Resp := TRespostas.Create(fACBrDeRE, TpResp, codUTF8);
  try
    Resp.RespostaLimpeza;
    fpCmd.Resposta := fpCmd.Resposta + sLineBreak + Resp.Resposta;
  finally
    Resp.Free;
  end;
end;

procedure TACBrObjetoDeRE.RespostaConsulta;
var
  Resp: TRespostas;
begin
  Resp := TRespostas.Create(fACBrDeRE, TpResp, codUTF8);
  try
    Resp.RespostaConsulta;
    fpCmd.Resposta := fpCmd.Resposta + sLineBreak + Resp.Resposta;
  finally
    Resp.Free;
  end;
end;

{ TMetodoCriarEventoDeRE }

{ Params: 0 - IniFile: path de um arquivo INI ou o conteudo do INI (um ou varios eventos)
}
procedure TMetodoCriarEventoDeRE.Executar;
var
  AIni: String;
begin
  AIni := fpCmd.Params(0);
  with TACBrObjetoDeRE(fpObjetoDono) do
  begin
    ACBrDeRE.Eventos.Clear;
    ACBrDeRE.Eventos.LoadFromIni(AIni);
    fpCmd.Resposta := Format('%d evento(s) carregado(s)', [ACBrDeRE.Eventos.Count]);
  end;
end;

{ TMetodoEnviarDeRE }

{ Envia o lote com os eventos carregados
}
procedure TMetodoEnviarDeRE.Executar;
begin
  with TACBrObjetoDeRE(fpObjetoDono) do
  begin
    if ACBrDeRE.Eventos.Count = 0 then
      raise Exception.Create('Nenhum evento carregado. Use CriarEventoDeRE ou CarregarXMLEventoDeRE.');

    GerarSalvarEventos;
    if ACBrDeRE.EnviarLote then
      RespostaEnvio;
    ACBrDeRE.Eventos.Clear;
  end;
end;

{ TMetodoConsultarDeRE }

{ Params: 0 - Protocolo do lote
}
procedure TMetodoConsultarDeRE.Executar;
var
  AProtocolo: String;
begin
  AProtocolo := fpCmd.Params(0);
  if EstaVazio(AProtocolo) then
    raise Exception.Create('Protocolo não informado.');

  with TACBrObjetoDeRE(fpObjetoDono) do
  begin
    ACBrDeRE.Eventos.Clear;
    if ACBrDeRE.ConsultarLote(AProtocolo) then
      RespostaConsulta
    else
      // Erro HTTP (ex.: protocolo nao encontrado): mensagem do componente com o codigo HTTP
      raise Exception.Create(ACBrDeRE.WebServices.ConsultaLote.Msg);
  end;
end;

{ TMetodoCriarEnviarDeRE }

{ Params: 0 - IniFile: path ou conteudo INI com os eventos
}
procedure TMetodoCriarEnviarDeRE.Executar;
var
  AIni: String;
begin
  AIni := fpCmd.Params(0);

  with TACBrObjetoDeRE(fpObjetoDono) do
  begin
    ACBrDeRE.Eventos.Clear;
    ACBrDeRE.Eventos.LoadFromIni(AIni);

    if ACBrDeRE.Eventos.Count = 0 then
      raise Exception.Create('Nenhum evento encontrado no INI informado.');

    GerarSalvarEventos;

    if ACBrDeRE.EnviarLote then
      RespostaEnvio;
    ACBrDeRE.Eventos.Clear;
  end;
end;

{ TMetodoLimparDeRE }

{ 
}
procedure TMetodoLimparDeRE.Executar;
begin
  with TACBrObjetoDeRE(fpObjetoDono) do
  begin
    ACBrDeRE.Eventos.Clear;
  end;
end;

{ TMetodoCarregarXMLEventoDeRE }

{ Params: 0 - Path ou conteudo XML/INI
}
procedure TMetodoCarregarXMLEventoDeRE.Executar;
var
  AArq: String;
begin
  AArq := fpCmd.Params(0);

  with TACBrObjetoDeRE(fpObjetoDono) do
  begin
    ACBrDeRE.Eventos.Clear;
    if FilesExists(AArq) then
      ACBrDeRE.Eventos.LoadFromFile(AArq)
    else
      ACBrDeRE.Eventos.LoadFromString(ConvertStrRecived(AArq));

    fpCmd.Resposta := Format('%d evento(s) carregado(s)', [ACBrDeRE.Eventos.Count]);
  end;
end;

{ TMetodoObterIniEventosDeRE }

{ 
}
procedure TMetodoObterIniEventosDeRE.Executar;
begin
  with TACBrObjetoDeRE(fpObjetoDono) do
  begin
    fpCmd.Resposta := ACBrDeRE.Eventos.GerarIni;
  end;
end;

{ TMetodoSetIDContribuinteDeRE }

{ Params: 0 - Id do contribuinte
}
procedure TMetodoSetIDContribuinteDeRE.Executar;
var
  AValor: String;
begin
  AValor := fpCmd.Params(0);
  if EstaVazio(AValor) then
    raise Exception.Create('Valor Nulo');

  with TACBrObjetoDeRE(fpObjetoDono) do
  begin
    with MonitorConfig.DFE.DeRE do
      IdContribuinte := AValor;
    MonitorConfig.SalvarArquivo;
    ACBrDeRE.Configuracoes.Geral.IdContribuinte := AValor;
  end;
end;

{ TMetodoSetVersaoDFDeRE }

{ Params: 0 - Versao do leiaute (1.0.2, 1.0.3 ou 1.0.4)
}
procedure TMetodoSetVersaoDFDeRE.Executar;
var
  VersaoDFe: TVersaoDeRE;
  AVersao: String;
begin
  AVersao := fpCmd.Params(0);
  VersaoDFe := StrToVersaoDeRE(AVersao);

  with TACBrObjetoDeRE(fpObjetoDono) do
  begin
    with MonitorConfig.DFE.WebService do
      VersaoDeRE := VersaoDeREToStr(VersaoDFe);
    MonitorConfig.SalvarArquivo;
    ACBrDeRE.Configuracoes.Geral.VersaoDF := VersaoDFe;
  end;
end;

{ TMetodoSetAmbienteDeRE }

{ Params: 0 - 1 Producao / 2 Homologacao
}
procedure TMetodoSetAmbienteDeRE.Executar;
var
  NumAmbiente: Integer;
begin
  NumAmbiente := StrToIntDef(fpCmd.Params(0), 2);
  if (NumAmbiente < 1) or (NumAmbiente > 2) then
    raise Exception.Create('Ambiente Inválido: ' + IntToStr(NumAmbiente));

  with TACBrObjetoDeRE(fpObjetoDono) do
  begin
    with MonitorConfig.DFE.WebService do
      Ambiente := NumAmbiente - 1;
    MonitorConfig.SalvarArquivo;
  end;
end;

{ TMetodoValidarDeRE }

{ Gera, assina e valida os eventos carregados
}
procedure TMetodoValidarDeRE.Executar;
begin
  with TACBrObjetoDeRE(fpObjetoDono) do
  begin
    ACBrDeRE.Eventos.Gerar;
    ACBrDeRE.Eventos.Assinar;
    ACBrDeRE.Eventos.Validar;
    fpCmd.Resposta := Format('%d evento(s) validado(s)', [ACBrDeRE.Eventos.Count]);
  end;
end;

{ TMetodoCertificadoDataVencimentoDeRE }

{ 
}
procedure TMetodoCertificadoDataVencimentoDeRE.Executar;
begin
  with TACBrObjetoDeRE(fpObjetoDono) do
  begin
    fpCmd.Resposta := DateToStr(ACBrDeRE.SSL.CertDataVenc);
  end;
end;

{ TMetodoCNPJCertificadoDeRE }

{ 
}
procedure TMetodoCNPJCertificadoDeRE.Executar;
begin
  with TACBrObjetoDeRE(fpObjetoDono) do
  begin
    fpCmd.Resposta := ACBrDeRE.SSL.CertCNPJ;
  end;
end;

{ TMetodoObterTokenDeRE }

{ Params: nenhum. Solicita um novo token, grava Token/TokenExpira no INI do Monitor
  e salva o retorno (JSON) na pasta de retornos.
}
procedure TMetodoObterTokenDeRE.Executar;
begin
  with TACBrObjetoDeRE(fpObjetoDono) do
  begin
    if not ACBrDeRE.ObterToken then
    begin
      // Falha (ex.: HTTP 429): devolve a resposta completa, igual a da Lib
      // (Token, TokenExpira, RetornoJson, HttpCodigo, MensagemErro).
      fpCmd.Resposta := '';
      RespostaToken;
      raise Exception.Create('Erro ao obter o token (HTTP ' +
        IntToStr(ACBrDeRE.WebServices.ObterToken.HttpCodigo) + ')' + fpCmd.Resposta);
    end;

    with MonitorConfig.DFE.DeRE do
    begin
      Token := ACBrDeRE.Configuracoes.Geral.Token;
      TokenExpira := DeREDataHoraToStr(ACBrDeRE.Configuracoes.Geral.TokenExpira);
    end;
    MonitorConfig.SalvarArquivo;

    RespostaToken;
  end;
end;

{ TMetodoLimparDadosDeRE }

{ Params: 0 - CNPJBase: CNPJ base (8 posicoes) do contribuinte. Opcional: se vazio, usa o
          IdContribuinte da configuracao.
  Remove os dados do contribuinte na Producao Restrita (DELETE). Nao existe em producao.
  Atencao: 'LimparDeRE' limpa os eventos em memoria; 'LimparDados' limpa os dados no servidor.
}
procedure TMetodoLimparDadosDeRE.Executar;
var
  ACNPJBase: String;
begin
  ACNPJBase := Trim(fpCmd.Params(0));

  with TACBrObjetoDeRE(fpObjetoDono) do
  begin
    if not ACBrDeRE.LimparDados(ACNPJBase) then
    begin
      fpCmd.Resposta := '';
      RespostaLimpeza;
      raise Exception.Create('Erro ao limpar os dados (HTTP ' +
        IntToStr(ACBrDeRE.WebServices.LimpezaDados.HttpCodigo) + ')' + fpCmd.Resposta);
    end;

    RespostaLimpeza;
  end;
end;

{ TMetodoVersaoDeRE }

{ 
}
procedure TMetodoVersaoDeRE.Executar;
begin
  fpCmd.Resposta := VersaoACBr;
end;

end.
