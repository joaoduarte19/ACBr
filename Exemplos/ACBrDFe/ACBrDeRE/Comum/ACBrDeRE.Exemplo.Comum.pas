{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interacao com equipa- }
{ mentos de Automacao Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Renato Rubinho                                  }
{                                                                              }
{  Voce pode obter a ultima versao desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Esta biblioteca e software livre; voce pode redistribui-la e/ou modifica-la }
{ sob os termos da Licenca Publica Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a versao 2.1 da Licenca, ou (a seu criterio) }
{ qualquer versao posterior.                                                   }
{                                                                              }
{  Esta biblioteca e distribuida na expectativa de que seja util, porem, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia implicita de COMERCIABILIDADE OU      }
{ ADEQUACAO A UMA FINALIDADE ESPECIFICA. Consulte a Licenca Publica Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENCA.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Voce deve ter recebido uma copia da Licenca Publica Geral Menor do GNU junto}
{ com esta biblioteca; se nao, escreva para a Free Software Foundation, Inc.,  }
{ no endereco 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Voce tambem pode obter uma copia da licenca em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Simoes de Almeida - daniel@projetoacbr.com.br - www.projetoacbr.com.br}
{       Rua Coronel Aureliano de Camargo, 963 - Tatui - SP - 18270-170         }
{******************************************************************************}

unit ACBrDeRE.Exemplo.Comum;

interface

uses
  SysUtils, Classes,
  ACBrUtil.Strings,
  ACBrDFe.Conversao,
  ACBrDeRE, ACBrDeRE.Classes, ACBrDeRE.D1001.Classes, ACBrDeRE.D1011.Classes,
  ACBrDeRE.D1101.Classes, ACBrDeRE.D1106.Classes, ACBrDeRE.D1121.Classes,
  ACBrDeRE.D1198.Classes,
  ACBrDeRE.D1199.Classes,
  ACBrDeRE.D2101.Classes,
  ACBrDeRE.D2102.Classes,
  ACBrDeRE.D2201.Classes,
  ACBrDeRE.D2202.Classes,
  ACBrDeRE.D2211.Classes,
  ACBrDeRE.D2221.Classes,
  ACBrDeRE.D2231.Classes,
  ACBrDeRE.D2241.Classes,
  ACBrDeRE.D2242.Classes,
  ACBrDeRE.D2251.Classes,
  ACBrDeRE.D2252.Classes,
  ACBrDeRE.D3201.Classes,
  ACBrDeRE.D4201.Classes,
  ACBrDeRE.Classes.Retorno,
  ACBrDeRE.Conversao;

type
  // Callback de log, independente de componente visual (TMemo/TListBox/etc.).
  TACBrDeREExemploLog = procedure(const ALinha: string) of object;

  // Callback para avisos ao usuario (cada programa decide como exibir, ex.: ShowMessage).
  TACBrDeREExemploMensagem = procedure(const AMensagem: string) of object;

  { TACBrDeREExemplo }

  TACBrDeREExemplo = class
  private
    FACBrDeRE: TACBrDeRE;
    FOnLog: TACBrDeREExemploLog;
    FOnMensagem: TACBrDeREExemploMensagem;

    procedure Log(const ALinha: string);
    procedure LogStatusEvento(AStatus: TideStatus; AInfo: TinfoRecEv);
    // Registra no log e, se atribuido, dispara OnMensagem.
    procedure Aviso(const AMensagem: string);
  public
    constructor Create(AACBrDeRE: TACBrDeRE);

    // Carrega um evento (XML) a partir do arquivo informado.
    procedure CarregarXML(const ANomeArquivo: string);

    // Carrega eventos a partir de um arquivo INI.
    procedure CarregarINI(const ANomeArquivo: string);

    // Grava o INI dos eventos carregados no componente (ACBrDeRE.Eventos), no diretorio
    // informado (se vazio, usa o PathDeRE): um unico arquivo com todos os eventos (de
    // tipos diferentes) ou, se AArquivoUnico = False, um arquivo por evento.
    procedure GravarINI(const ADiretorio: string = ''; AArquivoUnico: Boolean = True);

    // Monta um evento D-1198 (evtReabertMensal) com dados de exemplo.
    // Usa IdContribuinte e Ambiente de ACBrDeRE.Configuracoes.
    procedure GerarD1198;

    // Monta um evento D-1199 (evtFechMensal) com dados de exemplo.
    // Usa IdContribuinte e Ambiente de ACBrDeRE.Configuracoes.
    procedure GerarD1199;

    // Monta um evento D-2101 (evtDebOpOfPublic) com dados de exemplo.
    // Usa IdContribuinte e Ambiente de ACBrDeRE.Configuracoes.
    procedure GerarD2101;

    // Monta um evento D-2102 (evtInfoCotistas) com dados de exemplo.
    // Usa IdContribuinte e Ambiente de ACBrDeRE.Configuracoes.
    procedure GerarD2102;

    // Monta um evento D-2201 (evtServRemPreco) com dados de exemplo.
    // Usa IdContribuinte e Ambiente de ACBrDeRE.Configuracoes.
    procedure GerarD2201;

    // Monta um evento D-2202 (evtServRemTarifa) com dados de exemplo.
    // Usa IdContribuinte e Ambiente de ACBrDeRE.Configuracoes.
    procedure GerarD2202;

    // Monta um evento D-2211 (evtOperFinanc) com dados de exemplo.
    // Usa IdContribuinte e Ambiente de ACBrDeRE.Configuracoes.
    procedure GerarD2211;

    // Monta um evento D-2221 (evtAntecReceb) com dados de exemplo.
    // Usa IdContribuinte e Ambiente de ACBrDeRE.Configuracoes.
    procedure GerarD2221;

    // Monta um evento D-2231 (evtArrendMerc) com dados de exemplo.
    // Usa IdContribuinte e Ambiente de ACBrDeRE.Configuracoes.
    procedure GerarD2231;

    // Monta um evento D-2241 (evtArranjoCredDest) com dados de exemplo.
    // Usa IdContribuinte e Ambiente de ACBrDeRE.Configuracoes.
    procedure GerarD2241;

    // Monta um evento D-2242 (evtArranjoPartic) com dados de exemplo.
    // Usa IdContribuinte e Ambiente de ACBrDeRE.Configuracoes.
    procedure GerarD2242;

    // Monta um evento D-2251 (evtSegPrevCap) com dados de exemplo.
    // Usa IdContribuinte e Ambiente de ACBrDeRE.Configuracoes.
    procedure GerarD2251;

    // Monta um evento D-2252 (evtSegElemSCob) com dados de exemplo.
    // Usa IdContribuinte e Ambiente de ACBrDeRE.Configuracoes.
    procedure GerarD2252;

    // Monta um evento D-3201 (evtPlAssistSaude) com dados de exemplo.
    // Usa IdContribuinte e Ambiente de ACBrDeRE.Configuracoes.
    procedure GerarD3201;

    // Monta um evento D-4201 (evtIdApostPrem) com dados de exemplo.
    // Usa IdContribuinte e Ambiente de ACBrDeRE.Configuracoes.
    procedure GerarD4201;

    // Limpa os eventos, monta os eventos dos tipos informados, gera, assina,
    // valida e salva os XMLs. Retorna False se nenhum tipo foi informado.
    function GerarEventos(ATipos: TTiposEventoDeRE): Boolean;

    // Envia o lote com os eventos gerados/carregados. Retorna o protocolo
    // ('' em caso de falha).
    function EnviarLote: string;

    // Consulta o lote pelo protocolo e escreve o retorno no log.
    function ConsultarLote(const AProtocolo: string): Boolean;

    // Solicita um novo token de acesso e registra os dados retornados no log.
    // O token e a validade ficam em ACBrDeRE.Configuracoes.Geral (Token/TokenExpira).
    function ObterToken: Boolean;
    function LimparDados(const ACNPJBase: string = ''): Boolean;

    // Monta um evento D-1001 (evtInfoContrib) com dados de exemplo.
    // Usa IdContribuinte e Ambiente de ACBrDeRE.Configuracoes.
    procedure GerarD1001;

    // Monta um evento D-1011 (evtPGCC) com dados de exemplo.
    // Usa IdContribuinte e Ambiente de ACBrDeRE.Configuracoes.
    procedure GerarD1011;

    // Monta um evento D-1101 (evtBalancete) com dados de exemplo.
    // Usa IdContribuinte e Ambiente de ACBrDeRE.Configuracoes.
    procedure GerarD1101;

    // Monta um evento D-1106 (evtAplicResTec) com dados de exemplo.
    // Usa IdContribuinte e Ambiente de ACBrDeRE.Configuracoes.
    procedure GerarD1106;

    // Monta um evento D-1121 (evtRelDeducoes) com dados de exemplo.
    // Usa IdContribuinte e Ambiente de ACBrDeRE.Configuracoes.
    procedure GerarD1121;

    property ACBrDeRE: TACBrDeRE read FACBrDeRE write FACBrDeRE;
    property OnLog: TACBrDeREExemploLog read FOnLog write FOnLog;
    property OnMensagem: TACBrDeREExemploMensagem read FOnMensagem write FOnMensagem;
  end;

implementation

{ TACBrDeREExemplo }

constructor TACBrDeREExemplo.Create(AACBrDeRE: TACBrDeRE);
begin
  inherited Create;

  FACBrDeRE := AACBrDeRE;
end;

procedure TACBrDeREExemplo.Log(const ALinha: string);
begin
  if Assigned(FOnLog) then
    FOnLog(ALinha);
end;

procedure TACBrDeREExemplo.Aviso(const AMensagem: string);
begin
  Log(AMensagem);

  if Assigned(FOnMensagem) then
    FOnMensagem(AMensagem);
end;

procedure TACBrDeREExemplo.CarregarXML(const ANomeArquivo: string);
begin
  FACBrDeRE.Eventos.Clear;

  if ANomeArquivo = '' then
    Exit;

  FACBrDeRE.Eventos.LoadFromFile(ANomeArquivo);
  Log('XML de Eventos Carregado com Sucesso!');
end;

procedure TACBrDeREExemplo.CarregarINI(const ANomeArquivo: string);
begin
  FACBrDeRE.Eventos.Clear;

  if ANomeArquivo = '' then
    Exit;

  if FACBrDeRE.Eventos.LoadFromIni(ANomeArquivo) then
    Log('INI de Eventos Carregado com Sucesso!')
  else
    Log('Nenhum evento com leitura de INI implementada foi encontrado no arquivo.');
end;

procedure TACBrDeREExemplo.GravarINI(const ADiretorio: string; AArquivoUnico: Boolean);
var
  LDir, LArquivo: string;
  LArquivos: TStringList;
  LQtd, i: Integer;
begin
  if FACBrDeRE.Eventos.Count = 0 then
  begin
    Aviso('Nenhum evento carregado no componente. Gere ou carregue eventos antes de gravar o INI.');
    Exit;
  end;

  LDir := ADiretorio;
  if LDir = '' then
    LDir := FACBrDeRE.Configuracoes.Arquivos.GetPathDeRE;

  if AArquivoUnico then
  begin
    LArquivo := IncludeTrailingPathDelimiter(LDir) +
      'DeRE-' + FormatDateTime('yyyymmddhhnnss', Now) + '.ini';

    LQtd := FACBrDeRE.Eventos.SaveToIniFile(LArquivo);
    if LQtd > 0 then
      Log('INI gravado: ' + LArquivo);
  end
  else
  begin
    LArquivos := FACBrDeRE.Eventos.SaveToIni(LDir);
    try
      LQtd := LArquivos.Count;

      for i := 0 to LArquivos.Count - 1 do
        Log('INI gravado: ' + LArquivos[i]);
    finally
      LArquivos.Free;
    end;
  end;

  Aviso(Format('%d evento(s) gravado(s) em INI, em: %s', [LQtd, LDir]));

  if LQtd < FACBrDeRE.Eventos.Count then
    Log(Format('%d evento(s) ignorado(s): gerador de INI ainda nao implementado para o tipo.',
      [FACBrDeRE.Eventos.Count - LQtd]));
end;

function TACBrDeREExemplo.GerarEventos(ATipos: TTiposEventoDeRE): Boolean;
var
  i: Integer;
begin
  FACBrDeRE.Eventos.Clear;

  if teInfoContrib in ATipos then
    GerarD1001;

  if tePGCC in ATipos then
    GerarD1011;

  if teBalancete in ATipos then
    GerarD1101;
  if teAplicResTec in ATipos then
    GerarD1106;
  if teRelDeducoes in ATipos then
    GerarD1121;
  if teReabertMensal in ATipos then
    GerarD1198;
  if teFechMensal in ATipos then
    GerarD1199;
  if teDebOpOfPublic in ATipos then
    GerarD2101;
  if teInfoCotistas in ATipos then
    GerarD2102;
  if teServRemPreco in ATipos then
    GerarD2201;
  if teServRemTarifa in ATipos then
    GerarD2202;
  if teOperFinanc in ATipos then
    GerarD2211;
  if teAntecReceb in ATipos then
    GerarD2221;
  if teArrendMerc in ATipos then
    GerarD2231;
  if teArranjoCredDest in ATipos then
    GerarD2241;
  if teArranjoPartic in ATipos then
    GerarD2242;
  if teSegPrevCap in ATipos then
    GerarD2251;
  if teSegElemSCob in ATipos then
    GerarD2252;
  if tePlAssistSaude in ATipos then
    GerarD3201;
  if teIdApostPrem in ATipos then
    GerarD4201;

  Result := FACBrDeRE.Eventos.Count > 0;
  if not Result then
  begin
    Aviso('Marque ao menos um evento.');
    Exit;
  end;

  FACBrDeRE.Eventos.Gerar;    // Somente Gera os XMLs dos Eventos
  FACBrDeRE.Eventos.Assinar;  // Somente Assina os XMLs
  FACBrDeRE.Eventos.Validar;  // Somente Valida os XMLs

  FACBrDeRE.Eventos.SaveToFiles; // Salva em disco os XMLs dos Eventos

  Log('XML dos Eventos Selecionados Gerados.');

  for i := 0 to FACBrDeRE.Eventos.Gerados.Count - 1 do
  begin
    Log('Tipo Evento.: ' + TipoEventoDeREToStr(FACBrDeRE.Eventos.Gerados.Items[i].TipoEvento));
    Log('ID do Evento: ' + FACBrDeRE.Eventos.Gerados.Items[i].IdEvento);
    Log('Evento Salvo: ' + FACBrDeRE.Eventos.Gerados.Items[i].PathNome);
  end;
end;

function TACBrDeREExemplo.EnviarLote: string;
begin
  Result := '';

  if FACBrDeRE.Eventos.Count = 0 then
  begin
    Aviso('Gere ou carregue um evento antes de enviar.');
    Exit;
  end;

  if FACBrDeRE.EnviarLote then
  begin
    Result := FACBrDeRE.WebServices.EnvioLote.Protocolo;
    Log('Lote enviado.');
    Log('cdResposta: ' + cdRespostaLoteDeREToStr(FACBrDeRE.WebServices.EnvioLote.cdResposta));
    Log('descResposta: ' + FACBrDeRE.WebServices.EnvioLote.descResposta);
    Log('dhRecepcao: ' + FormatDateTime('dd/mm/yyyy hh:nn:ss',
      FACBrDeRE.WebServices.EnvioLote.dhRecepcao));
    Log('versaoAplicativoRecepcao: ' +
      FACBrDeRE.WebServices.EnvioLote.versaoAplicativoRecepcao);
    Log('Protocolo: ' + Result);
  end
  else
    Log('Falha no envio do lote.');
end;

function TACBrDeREExemplo.ObterToken: Boolean;
begin
  Result := FACBrDeRE.ObterToken;

  Log('Codigo HTTP: ' + IntToStr(FACBrDeRE.WebServices.ObterToken.HttpCodigo));

  if not Result then
  begin
    Log('Falha ao obter o token.');
    Log('Mensagem de erro: ' + FACBrDeRE.WebServices.ObterToken.Msg);
    Log('Retorno: ' + FACBrDeRE.WebServices.ObterToken.RetornoToken);
    Exit;
  end;

  Log('Token obtido com sucesso.');
  Log('Token: ' + FACBrDeRE.WebServices.Token);
  Log('TokenExpira: ' + FormatDateTime('dd/mm/yyyy hh:nn:ss',
    FACBrDeRE.WebServices.TokenExpira));
  Log('Retorno (JSON): ' + FACBrDeRE.WebServices.ObterToken.RetornoToken);
end;

// Remove os dados do contribuinte na Producao Restrita (homologacao).
// Se ACNPJBase for vazio, usa o CNPJ base do IdContribuinte configurado.
function TACBrDeREExemplo.LimparDados(const ACNPJBase: string): Boolean;
begin
  Result := FACBrDeRE.LimparDados(ACNPJBase);

  Log('CNPJ base: ' + FACBrDeRE.WebServices.LimpezaDados.nrInsc);
  Log('Codigo HTTP: ' + IntToStr(FACBrDeRE.WebServices.LimpezaDados.HttpCodigo));

  if not Result then
  begin
    Log('Falha ao limpar os dados do contribuinte.');
    Log('Mensagem: ' + FACBrDeRE.WebServices.LimpezaDados.Msg);
    Log('Retorno: ' + FACBrDeRE.WebServices.LimpezaDados.RetWS);
    Exit;
  end;

  Log('Dados do contribuinte removidos da Producao Restrita.');
  Log('Retorno: ' + FACBrDeRE.WebServices.LimpezaDados.RetWS);
end;

procedure TACBrDeREExemplo.LogStatusEvento(AStatus: TideStatus; AInfo: TinfoRecEv);
var
  i: Integer;
begin
  Log('  tpEv.......: ' + AInfo.tpEvStr);
  Log('  cdRetorno..: ' + cdRetornoDeREToStr(AStatus.cdRetorno));
  Log('  descRetorno: ' + descRetornoDeREToStr(AStatus.descRetorno));
  Log('  nrRecibo...: ' + AInfo.nrRecibo);

  for i := 0 to AStatus.ocorrencias.Count - 1 do
  begin
    Log('  Ocorrencia tipo: ' + tipoOcorrenciaDeREToStr(AStatus.ocorrencias.Items[i].tipo));
    Log('  codigo.........: ' + AStatus.ocorrencias.Items[i].codigo);
    Log('  descricao......: ' + AStatus.ocorrencias.Items[i].descricao);
    Log('  localizacao....: ' + AStatus.ocorrencias.Items[i].localizacao);
  end;
end;

function TACBrDeREExemplo.ConsultarLote(const AProtocolo: string): Boolean;
var
  i: Integer;
begin
  Result := False;

  if Trim(AProtocolo) = '' then
  begin
    Aviso('Informe o protocolo para consulta.');
    Exit;
  end;

  Result := FACBrDeRE.ConsultarLote(AProtocolo);
  if not Result then
  begin
    Log('Falha na consulta do lote.');
    Log('HTTP: ' + IntToStr(FACBrDeRE.WebServices.ConsultaLote.HttpCodigo));
    Log(FACBrDeRE.WebServices.ConsultaLote.Msg);
    Exit;
  end;

  with FACBrDeRE.WebServices.ConsultaLote.RetornoLote do
  begin
    Log('Protocolo..: ' + AProtocolo);
    Log('cdResposta.: ' + cdRespostaLoteDeREToStr(status.cdResposta));
    Log('descResposta: ' + status.descResposta);

    for i := 0 to status.ocorrencias.Count - 1 do
    begin
      Log('  Ocorrencia tipo: ' + tipoOcorrenciaDeREToStr(status.ocorrencias.Items[i].tipo));
      Log('  codigo.........: ' + status.ocorrencias.Items[i].codigo);
      Log('  descricao......: ' + status.ocorrencias.Items[i].descricao);
    end;

    // Eventos de retorno (D-9xxx) ja interpretados em Retorno / RetornoTabela
    for i := 0 to retornoEventos.Count - 1 do
    begin
      Log('Retorno do evento: ' + retornoEventos.Items[i].id +
        ' (' + tipoRetornoDeREToStr(retornoEventos.Items[i].TipoRetorno) + ')');

      if Assigned(retornoEventos.Items[i].Retorno) then
        LogStatusEvento(retornoEventos.Items[i].Retorno.ideStatus,
          retornoEventos.Items[i].Retorno.infoRecEv)
      else
      if Assigned(retornoEventos.Items[i].RetornoTabela) then
        LogStatusEvento(retornoEventos.Items[i].RetornoTabela.ideStatus,
          retornoEventos.Items[i].RetornoTabela.infoRecEv);
    end;
  end;
end;

procedure TACBrDeREExemplo.GerarD1101;
var
  LDeRE: TDeRED1101;
  LConta: TinfoContaBalanceteCollectionItemD1101;
  LIdContribuinte: string;
begin
  LIdContribuinte := OnlyCPFCNPJAlphaNum(FACBrDeRE.Configuracoes.Geral.IdContribuinte);

  LDeRE := FACBrDeRE.Eventos.NewD1101;

  // Campos auxiliares para montagem do id (42 chars)
  LDeRE.evtBalancete.nrInscCompleto := LIdContribuinte;
  LDeRE.evtBalancete.dataGeracao := Now;
  LDeRE.evtBalancete.sequencial := 1;

  with LDeRE.evtBalancete.ideEvento do
  begin
    tpOper   := toInclusao;
    tpAmb    := FACBrDeRE.Configuracoes.WebServices.Ambiente;
    aplicEmi := aeEmpresa;
    verAplic := 'ACBrDeRE1.0';
  end;

  // nrInsc do ideContrib = CNPJ raiz (8 posicoes alfanumericas)
  LDeRE.evtBalancete.ideContrib.nrInsc := Copy(LIdContribuinte, 1, 8);

  // perApur no formato AAAA-MM
  LDeRE.evtBalancete.idePeriodo.perApur := '2026-01';

  with LDeRE.evtBalancete.infoBalancete do
  begin
    TeminfoBalancete := True;

    LConta := infoContas.New;
    LConta.cCta         := '11101';
    LConta.natSaldoInic := nsDevedor;
    LConta.vSaldoInic   := 1000.00;
    LConta.vMovDebt     := 500.00;
    LConta.vMovCred     := 200.00;
    // saldo final = saldo inicial + debitos - creditos (natureza devedora)
    LConta.natSaldoFinal := nsDevedor;
    LConta.vSaldoFinal   := 1300.00;
    LConta.TemnatVApur   := True;
    LConta.natVApur      := nsDevedor;
    LConta.vApur         := 0.00;
  end;

  Log('Evento D-1101 (evtBalancete) montado com dados de exemplo.');
end;

procedure TACBrDeREExemplo.GerarD1106;
var
  LDeRE: TDeRED1106;
  LAplic: TinfoAplicCollectionItemD1106;
  LAtivo: TdetAtivoCollectionItemD1106;
  LIdContribuinte: string;
begin
  LIdContribuinte := OnlyCPFCNPJAlphaNum(FACBrDeRE.Configuracoes.Geral.IdContribuinte);

  LDeRE := FACBrDeRE.Eventos.NewD1106;

  // Campos auxiliares para montagem do id (42 chars)
  LDeRE.evtAplicResTec.nrInscCompleto := LIdContribuinte;
  LDeRE.evtAplicResTec.dataGeracao := Now;
  LDeRE.evtAplicResTec.sequencial := 1;

  with LDeRE.evtAplicResTec.ideEvento do
  begin
    tpOper   := toInclusao;
    tpAmb    := FACBrDeRE.Configuracoes.WebServices.Ambiente;
    aplicEmi := aeEmpresa;
    verAplic := 'ACBrDeRE1.0';
  end;

  // nrInsc do ideContrib = CNPJ raiz (8 posicoes alfanumericas)
  LDeRE.evtAplicResTec.ideContrib.nrInsc := Copy(LIdContribuinte, 1, 8);

  // perApur no formato AAAA-MM
  LDeRE.evtAplicResTec.idePeriodo.perApur := '2026-01';

  with LDeRE.evtAplicResTec.infoAplicResTec do
  begin
    TeminfoAplicResTec := True;

    LAplic := infoAplic.New;
    LAplic.cCta := '11101';

    LAtivo := LAplic.detAtivo.New;
    LAtivo.idAtivo          := 'ATIVO001';
    LAtivo.descAtivo        := 'Titulo publico federal (exemplo)';
    LAtivo.vSaldoInic       := 100000.00;
    LAtivo.TemvRendPerReceb := True;
    LAtivo.vRendPerReceb    := 500.00;
    LAtivo.TemvVarMensal    := True;
    LAtivo.vVarMensal       := 1500.00;
    LAtivo.vPrincLiqResg    := 0.00;
    // vSaldoFinal = vSaldoInic + vVarMensal - vPrincLiqResg
    LAtivo.vSaldoFinal      := 101500.00;
    // vApur = vRendPerReceb + vRendLiqResg
    LAtivo.vApur            := 500.00;
  end;

  Log('Evento D-1106 (evtAplicResTec) montado com dados de exemplo.');
end;

procedure TACBrDeREExemplo.GerarD1121;
var
  LDeRE: TDeRED1121;
  LDeducao: TinfoDeducaoCollectionItemD1121;
  LDesdob: TdesdobDeducaoCollectionItemD1121;
  LItem: TitemDFeCollectionItemD1121;
  LIdContribuinte: string;
begin
  LIdContribuinte := OnlyCPFCNPJAlphaNum(FACBrDeRE.Configuracoes.Geral.IdContribuinte);

  LDeRE := FACBrDeRE.Eventos.NewD1121;

  // Campos auxiliares para montagem do id (42 chars)
  LDeRE.evtRelDeducoes.nrInscCompleto := LIdContribuinte;
  LDeRE.evtRelDeducoes.dataGeracao := Now;
  LDeRE.evtRelDeducoes.sequencial := 1;

  with LDeRE.evtRelDeducoes.ideEvento do
  begin
    tpOper   := toInclusao;
    tpAmb    := FACBrDeRE.Configuracoes.WebServices.Ambiente;
    aplicEmi := aeEmpresa;
    verAplic := 'ACBrDeRE1.0';
  end;

  // nrInsc do ideContrib = CNPJ raiz (8 posicoes alfanumericas)
  LDeRE.evtRelDeducoes.ideContrib.nrInsc := Copy(LIdContribuinte, 1, 8);

  // perApur no formato AAAA-MM
  LDeRE.evtRelDeducoes.idePeriodo.perApur := '2026-01';

  with LDeRE.evtRelDeducoes.infoDeducoes do
  begin
    TeminfoDeducoes := True;

    LDeducao := infoDeducao.New;

    LDeducao.TeminfoDFe := True;
    LDeducao.infoDFe.chDFe    := '35260112345678000199550010000000011000000015';
    LDeducao.infoDFe.TemtpDFe := True;
    LDeducao.infoDFe.tpDFe    := tdNFe;
    LDeducao.infoDFe.TemdtEmi := True;
    LDeducao.infoDFe.dtEmi    := EncodeDate(2026, 1, 10);

    LDeducao.TemdetDeducao := True;
    LDeducao.detDeducao.vOper := 100.00;

    LDesdob := LDeducao.detDeducao.desdobDeducoes.New;
    LDesdob.tpAtiv := TTpAtivDedDeRE(1);
    LDesdob.cCta   := '31101';
    LDesdob.vDed   := 10.50;

    LItem := LDesdob.itemsDFe.New;
    LItem.nItem    := '1';
    LItem.vItem    := 100.00;
    LItem.vItemDed := 10.50;
  end;

  Log('Evento D-1121 (evtRelDeducoes) montado com dados de exemplo.');
end;

procedure TACBrDeREExemplo.GerarD1198;
var
  LDeRE: TDeRED1198;
  LIdContribuinte: string;
begin
  LIdContribuinte := OnlyCPFCNPJAlphaNum(FACBrDeRE.Configuracoes.Geral.IdContribuinte);

  LDeRE := FACBrDeRE.Eventos.NewD1198;

  // Campos auxiliares para montagem do id (42 chars)
  LDeRE.evtReabertMensal.nrInscCompleto := LIdContribuinte;
  LDeRE.evtReabertMensal.dataGeracao := Now;
  LDeRE.evtReabertMensal.sequencial := 1;

  with LDeRE.evtReabertMensal.ideEvento do
  begin
    // O D-1198 aceita exclusivamente a operacao de Inclusao
    tpOper   := toInclusao;
    tpAmb    := FACBrDeRE.Configuracoes.WebServices.Ambiente;
    aplicEmi := aeEmpresa;
    verAplic := 'ACBrDeRE1.0';
  end;

  // nrInsc do ideContrib = CNPJ raiz (8 posicoes alfanumericas)
  LDeRE.evtReabertMensal.ideContrib.nrInsc := Copy(LIdContribuinte, 1, 8);

  // Periodo de apuracao a reabrir (AAAA-MM)
  LDeRE.evtReabertMensal.idePeriodo.perApur := '2026-01';

  // Recibo do D-1199 ativo do periodo: 1199-AAAAMM-<19 alfanumericos>
  LDeRE.evtReabertMensal.infoReabertura.nrReciboReab := '1199-202601-A1B2C3D4E5F6G7H8I9J';

  Log('Evento D-1198 (evtReabertMensal) montado com dados de exemplo.');
end;

procedure TACBrDeREExemplo.GerarD1199;
var
  LDeRE: TDeRED1199;
  LInfoBCN: TinfoBCNCollectionItemD1199;
  LDetBCNeg: TdetBCNegCollectionItemD1199;
  LIdContribuinte: string;
begin
  LIdContribuinte := OnlyCPFCNPJAlphaNum(FACBrDeRE.Configuracoes.Geral.IdContribuinte);

  LDeRE := FACBrDeRE.Eventos.NewD1199;

  // Campos auxiliares para montagem do id (42 chars)
  LDeRE.evtFechMensal.nrInscCompleto := LIdContribuinte;
  LDeRE.evtFechMensal.dataGeracao := Now;
  LDeRE.evtFechMensal.sequencial := 1;

  with LDeRE.evtFechMensal.ideEvento do
  begin
    tpOper   := toInclusao;
    tpAmb    := FACBrDeRE.Configuracoes.WebServices.Ambiente;
    aplicEmi := aeEmpresa;
    verAplic := 'ACBrDeRE1.0';
  end;

  // nrInsc do ideContrib = CNPJ raiz (8 posicoes alfanumericas)
  LDeRE.evtFechMensal.ideContrib.nrInsc := Copy(LIdContribuinte, 1, 8);

  // Periodo de apuracao (AAAA-MM)
  LDeRE.evtFechMensal.idePeriodo.perApur := '2026-01';

  LDeRE.evtFechMensal.infoFechamento.TeminfoFechamento := True;
  LDeRE.evtFechMensal.infoFechamento.TeminfoParamFech := True;
  LDeRE.evtFechMensal.infoFechamento.infoParamFech.indInexistDedu := True;
  LDeRE.evtFechMensal.infoFechamento.TemgUtilizBCN := True;
  LInfoBCN := LDeRE.evtFechMensal.infoFechamento.gUtilizBCN.infoBCN.New;
  LInfoBCN.codBCNRaiz := '1001I';
  LInfoBCN.usarBCNAcum := True;
  LInfoBCN.TemmetodoAproveit := True;
  LInfoBCN.metodoAproveit := maPEPS;
  LDetBCNeg := LDeRE.evtFechMensal.infoFechamento.gUtilizBCN.detBCNeg.New;
  LDetBCNeg.codBCN := '1001I00000001';
  LDetBCNeg.TemvUsarBCN := True;
  LDetBCNeg.vUsarBCN := 100.00;

  Log('Evento D-1199 (evtFechMensal) montado com dados de exemplo.');
end;

procedure TACBrDeREExemplo.GerarD2101;
var
  LDeRE: TDeRED2101;
  LDetTitulo: TdetTituloCollectionItemD2101;
  LIdContribuinte: string;
begin
  LIdContribuinte := OnlyCPFCNPJAlphaNum(FACBrDeRE.Configuracoes.Geral.IdContribuinte);

  LDeRE := FACBrDeRE.Eventos.NewD2101;

  // Campos auxiliares para montagem do id (42 chars)
  LDeRE.evtDebOpOfPublic.nrInscCompleto := LIdContribuinte;
  LDeRE.evtDebOpOfPublic.dataGeracao := Now;
  LDeRE.evtDebOpOfPublic.sequencial := 1;

  with LDeRE.evtDebOpOfPublic.ideEvento do
  begin
    tpOper   := toInclusao;
    tpAmb    := FACBrDeRE.Configuracoes.WebServices.Ambiente;
    aplicEmi := aeEmpresa;
    verAplic := 'ACBrDeRE1.0';
  end;

  // nrInsc do ideContrib = CNPJ raiz (8 posicoes alfanumericas)
  LDeRE.evtDebOpOfPublic.ideContrib.nrInsc := Copy(LIdContribuinte, 1, 8);

  // Periodo de apuracao (AAAA-MM)
  LDeRE.evtDebOpOfPublic.idePeriodo.perApur := '2026-01';

  LDeRE.evtDebOpOfPublic.infoDebOpOfPublic.TeminfoDebOpOfPublic := True;
  LDeRE.evtDebOpOfPublic.infoDebOpOfPublic.TeminfoTitulos := True;
  LDetTitulo := LDeRE.evtDebOpOfPublic.infoDebOpOfPublic.infoTitulos.detTitulo.New;
  LDetTitulo.idTitulo := 'BRSTNCLTN7W2';
  LDetTitulo.cCta := '11101';
  LDetTitulo.TemdescFundo := True;
  LDetTitulo.descFundo := 'Exemplo';
  LDetTitulo.CNPJDevedor := '12345678000195';
  LDetTitulo.vSaldoContIni := 100.00;
  LDetTitulo.vEntradas := 100.00;
  LDetTitulo.vSaidas := 100.00;
  LDetTitulo.vJurosRec := 100.00;
  LDetTitulo.TemvVarMensal := True;
  LDetTitulo.vVarMensal := 100.00;
  LDetTitulo.vSaldoContFin := 100.00;
  LDetTitulo.vSelic := 100.00;
  LDetTitulo.TemvPisCofins := True;
  LDetTitulo.vPisCofins := 100.00;
  LDetTitulo.vApur := 100.00;

  Log('Evento D-2101 (evtDebOpOfPublic) montado com dados de exemplo.');
end;

procedure TACBrDeREExemplo.GerarD2102;
var
  LDeRE: TDeRED2102;
  LClasse: TclasseCollectionItemD2102;
  LCotista: TcotistaCollectionItemD2102;
  LCota: TcotaCollectionItemD2102;
  LIdContribuinte: string;
begin
  LIdContribuinte := OnlyCPFCNPJAlphaNum(FACBrDeRE.Configuracoes.Geral.IdContribuinte);

  LDeRE := FACBrDeRE.Eventos.NewD2102;

  // Campos auxiliares para montagem do id (42 chars)
  LDeRE.evtInfoCotistas.nrInscCompleto := LIdContribuinte;
  LDeRE.evtInfoCotistas.dataGeracao := Now;
  LDeRE.evtInfoCotistas.sequencial := 1;

  with LDeRE.evtInfoCotistas.ideEvento do
  begin
    tpOper   := toInclusao;
    tpAmb    := FACBrDeRE.Configuracoes.WebServices.Ambiente;
    aplicEmi := aeEmpresa;
    verAplic := 'ACBrDeRE1.0';
  end;

  // nrInsc do ideContrib = CNPJ raiz (8 posicoes alfanumericas)
  LDeRE.evtInfoCotistas.ideContrib.nrInsc := Copy(LIdContribuinte, 1, 8);

  // Periodo de apuracao (AAAA-MM)
  LDeRE.evtInfoCotistas.idePeriodo.perApur := '2026-01';

  LDeRE.evtInfoCotistas.infoCotistas.TeminfoCotistas := True;
  LDeRE.evtInfoCotistas.infoCotistas.tpDeclarante := tdAdministradorFundo;
  LClasse := LDeRE.evtInfoCotistas.infoCotistas.classes.classe.New;
  LClasse.idClasse := '12345678000195';
  LClasse.quantidadeCotas := '100';
  LClasse.quantidadeCotistas := '1';
  LClasse.TemplClasse := True;
  LClasse.plClasse := 100.00;
  LClasse.cnpjFundo := '12345678000195';
  LCotista := LClasse.cotistas.cotista.New;
  LCotista.tipoPessoa := pesFisicaResidente;
  LCotista.identificacao := '12345678901';
  LCotista.classificacao := clCotista;
  LCota := LCotista.cotas.cota.New;
  LCota.tipoCota := '1';
  LCota.subclasse := 'NA';
  LCota.qtdeCotas := '100';
  LCota.valorCota := '10.5';

  Log('Evento D-2102 (evtInfoCotistas) montado com dados de exemplo.');
end;

procedure TACBrDeREExemplo.GerarD2201;
var
  LDeRE: TDeRED2201;
  LDetOper: TdetOperCollectionItemD2201;
  LIdContribuinte: string;
begin
  LIdContribuinte := OnlyCPFCNPJAlphaNum(FACBrDeRE.Configuracoes.Geral.IdContribuinte);

  LDeRE := FACBrDeRE.Eventos.NewD2201;

  // Campos auxiliares para montagem do id (42 chars)
  LDeRE.evtServRemPreco.nrInscCompleto := LIdContribuinte;
  LDeRE.evtServRemPreco.dataGeracao := Now;
  LDeRE.evtServRemPreco.sequencial := 1;

  with LDeRE.evtServRemPreco.ideEvento do
  begin
    finEvt   := foRegistroOriginal;
    tpAmb    := FACBrDeRE.Configuracoes.WebServices.Ambiente;
    aplicEmi := aeEmpresa;
    verAplic := 'ACBrDeRE1.0';
  end;

  // nrInsc do ideContrib = CNPJ raiz (8 posicoes alfanumericas)
  LDeRE.evtServRemPreco.ideContrib.nrInsc := Copy(LIdContribuinte, 1, 8);

  // Periodo de apuracao (AAAA-MM)
  LDeRE.evtServRemPreco.idePeriodo.perApur := '2026-01';
  LDeRE.evtServRemPreco.idePeriodo.subPer := 1;

  LDeRE.evtServRemPreco.infoOper.gOper.chAgrup := '1HFE86Y5R21DEW1ZCYQESH0ARLH9DL65O6M209408301895931';
  LDeRE.evtServRemPreco.infoOper.gOper.codBC := '1I5E';
  LDeRE.evtServRemPreco.infoOper.gOper.idePartes.infoAdq.TemCNPJ := True;
  LDeRE.evtServRemPreco.infoOper.gOper.idePartes.infoAdq.CNPJ := '12345678000195';
  LDeRE.evtServRemPreco.infoOper.gOper.idePartes.infoAdq.TemcMun := True;
  LDeRE.evtServRemPreco.infoOper.gOper.idePartes.infoAdq.cMun := '5300108';
  LDetOper := LDeRE.evtServRemPreco.infoOper.gOper.dadosOper.detOper.New;
  LDetOper.seq := '007';
  LDetOper.dhOper := EncodeDate(2026, 1, 15) + EncodeTime(10, 30, 0, 0);
  LDetOper.TeminfoDest := True;
  LDetOper.infoDest.TemCNPJDest := True;
  LDetOper.infoDest.CNPJDest := '12345678000195';
  LDetOper.infoDest.TemcMunDest := True;
  LDetOper.infoDest.cMunDest := '5300108';
  LDetOper.gBC.vBCApur := 100.00;
  LDetOper.gTributos.vBCTrib := 100.00;
  LDetOper.gTributos.pIBSMunTrib := 100.000000;
  LDetOper.gTributos.vIBSMunTrib := 100.00;
  LDetOper.gTributos.pIBSUFTrib := 100.000000;
  LDetOper.gTributos.vIBSUFTrib := 100.00;
  LDetOper.gTributos.pCBSTrib := 100.000000;
  LDetOper.gTributos.vCBSTrib := 100.00;

  Log('Evento D-2201 (evtServRemPreco) montado com dados de exemplo.');
end;

procedure TACBrDeREExemplo.GerarD2202;
var
  LDeRE: TDeRED2202;
  LDetOper: TdetOperCollectionItemD2202;
  LIdContribuinte: string;
begin
  LIdContribuinte := OnlyCPFCNPJAlphaNum(FACBrDeRE.Configuracoes.Geral.IdContribuinte);

  LDeRE := FACBrDeRE.Eventos.NewD2202;

  // Campos auxiliares para montagem do id (42 chars)
  LDeRE.evtServRemTarifa.nrInscCompleto := LIdContribuinte;
  LDeRE.evtServRemTarifa.dataGeracao := Now;
  LDeRE.evtServRemTarifa.sequencial := 1;

  with LDeRE.evtServRemTarifa.ideEvento do
  begin
    finEvt   := foRegistroOriginal;
    tpAmb    := FACBrDeRE.Configuracoes.WebServices.Ambiente;
    aplicEmi := aeEmpresa;
    verAplic := 'ACBrDeRE1.0';
  end;

  // nrInsc do ideContrib = CNPJ raiz (8 posicoes alfanumericas)
  LDeRE.evtServRemTarifa.ideContrib.nrInsc := Copy(LIdContribuinte, 1, 8);

  // Periodo de apuracao (AAAA-MM)
  LDeRE.evtServRemTarifa.idePeriodo.perApur := '2026-01';
  LDeRE.evtServRemTarifa.idePeriodo.subPer := 1;

  LDeRE.evtServRemTarifa.infoOper.gOper.chAgrup := '1HFE86Y5R21DEW1ZCYQESH0ARLH9DL65O6M209408301895931';
  LDeRE.evtServRemTarifa.infoOper.gOper.codBC := '1I5E';
  LDeRE.evtServRemTarifa.infoOper.gOper.idePartes.infoAdq.TemCNPJ := True;
  LDeRE.evtServRemTarifa.infoOper.gOper.idePartes.infoAdq.CNPJ := '12345678000195';
  LDeRE.evtServRemTarifa.infoOper.gOper.idePartes.infoAdq.TemcMun := True;
  LDeRE.evtServRemTarifa.infoOper.gOper.idePartes.infoAdq.cMun := '5300108';
  LDetOper := LDeRE.evtServRemTarifa.infoOper.gOper.dadosOper.detOper.New;
  LDetOper.seq := '007';
  LDetOper.dhOper := EncodeDate(2026, 1, 15) + EncodeTime(10, 30, 0, 0);
  LDetOper.TemqualifOper := True;
  LDetOper.qualifOper.TemindPresenc := True;
  LDetOper.qualifOper.indPresenc := True;
  LDetOper.qualifOper.TemcMunOper := True;
  LDetOper.qualifOper.cMunOper := '7525534';
  LDetOper.gBC.vBCApur := 100.00;
  LDetOper.gTributos.vBCTrib := 100.00;
  LDetOper.gTributos.pIBSMunTrib := 100.0000;
  LDetOper.gTributos.vIBSMunTrib := 100.00;
  LDetOper.gTributos.pIBSUFTrib := 100.0000;
  LDetOper.gTributos.vIBSUFTrib := 100.00;
  LDetOper.gTributos.pCBSTrib := 100.0000;
  LDetOper.gTributos.vCBSTrib := 100.00;

  Log('Evento D-2202 (evtServRemTarifa) montado com dados de exemplo.');
end;

procedure TACBrDeREExemplo.GerarD2211;
var
  LDeRE: TDeRED2211;
  LDetOper: TdetOperCollectionItemD2211;
  LIdContribuinte: string;
begin
  LIdContribuinte := OnlyCPFCNPJAlphaNum(FACBrDeRE.Configuracoes.Geral.IdContribuinte);

  LDeRE := FACBrDeRE.Eventos.NewD2211;

  // Campos auxiliares para montagem do id (42 chars)
  LDeRE.evtOperFinanc.nrInscCompleto := LIdContribuinte;
  LDeRE.evtOperFinanc.dataGeracao := Now;
  LDeRE.evtOperFinanc.sequencial := 1;

  with LDeRE.evtOperFinanc.ideEvento do
  begin
    finEvt   := foRegistroOriginal;
    tpAmb    := FACBrDeRE.Configuracoes.WebServices.Ambiente;
    aplicEmi := aeEmpresa;
    verAplic := 'ACBrDeRE1.0';
  end;

  // nrInsc do ideContrib = CNPJ raiz (8 posicoes alfanumericas)
  LDeRE.evtOperFinanc.ideContrib.nrInsc := Copy(LIdContribuinte, 1, 8);

  // Periodo de apuracao (AAAA-MM)
  LDeRE.evtOperFinanc.idePeriodo.perApur := '2026-01';
  LDeRE.evtOperFinanc.idePeriodo.subPer := 1;

  LDeRE.evtOperFinanc.infoOper.gOper.chAgrup := '1HFE86Y5R21DEW1ZCYQESH0ARLH9DL65O6M209408301895931';
  LDeRE.evtOperFinanc.infoOper.gOper.codBC := '1I5E';
  LDeRE.evtOperFinanc.infoOper.gOper.idePartes.infoAdq.TemCNPJ := True;
  LDeRE.evtOperFinanc.infoOper.gOper.idePartes.infoAdq.CNPJ := '12345678000195';
  LDeRE.evtOperFinanc.infoOper.gOper.idePartes.infoAdq.TemcMun := True;
  LDeRE.evtOperFinanc.infoOper.gOper.idePartes.infoAdq.cMun := '5300108';
  LDetOper := LDeRE.evtOperFinanc.infoOper.gOper.dadosOper.detOper.New;
  LDetOper.seq := '007';
  LDetOper.dhOper := EncodeDate(2026, 1, 15) + EncodeTime(10, 30, 0, 0);
  LDetOper.qualifOper.indMoedaEstr := True;
  LDetOper.gBC.vBCApur := 100.00;
  LDetOper.gTributos.vBCTrib := 100.00;
  LDetOper.gTributos.pIBSMunTrib := 100.000000;
  LDetOper.gTributos.vIBSMunTrib := 100.00;
  LDetOper.gTributos.pIBSUFTrib := 100.000000;
  LDetOper.gTributos.vIBSUFTrib := 100.00;
  LDetOper.gTributos.pCBSTrib := 100.000000;
  LDetOper.gTributos.vCBSTrib := 100.00;

  Log('Evento D-2211 (evtOperFinanc) montado com dados de exemplo.');
end;

procedure TACBrDeREExemplo.GerarD2221;
var
  LDeRE: TDeRED2221;
  LDetOper: TdetOperCollectionItemD2221;
  LIdContribuinte: string;
begin
  LIdContribuinte := OnlyCPFCNPJAlphaNum(FACBrDeRE.Configuracoes.Geral.IdContribuinte);

  LDeRE := FACBrDeRE.Eventos.NewD2221;

  // Campos auxiliares para montagem do id (42 chars)
  LDeRE.evtAntecReceb.nrInscCompleto := LIdContribuinte;
  LDeRE.evtAntecReceb.dataGeracao := Now;
  LDeRE.evtAntecReceb.sequencial := 1;

  with LDeRE.evtAntecReceb.ideEvento do
  begin
    finEvt   := foRegistroOriginal;
    tpAmb    := FACBrDeRE.Configuracoes.WebServices.Ambiente;
    aplicEmi := aeEmpresa;
    verAplic := 'ACBrDeRE1.0';
  end;

  // nrInsc do ideContrib = CNPJ raiz (8 posicoes alfanumericas)
  LDeRE.evtAntecReceb.ideContrib.nrInsc := Copy(LIdContribuinte, 1, 8);

  // Periodo de apuracao (AAAA-MM)
  LDeRE.evtAntecReceb.idePeriodo.perApur := '2026-01';
  LDeRE.evtAntecReceb.idePeriodo.subPer := 1;

  LDeRE.evtAntecReceb.infoOper.gOper.chAgrup := '1HFE86Y5R21DEW1ZCYQESH0ARLH9DL65O6M209408301895931';
  LDeRE.evtAntecReceb.infoOper.gOper.codBC := '1I5E';
  LDeRE.evtAntecReceb.infoOper.gOper.idePartes.infoAdq.TemCNPJ := True;
  LDeRE.evtAntecReceb.infoOper.gOper.idePartes.infoAdq.CNPJ := '12345678000195';
  LDeRE.evtAntecReceb.infoOper.gOper.idePartes.infoAdq.TemcMun := True;
  LDeRE.evtAntecReceb.infoOper.gOper.idePartes.infoAdq.cMun := '5300108';
  LDetOper := LDeRE.evtAntecReceb.infoOper.gOper.dadosOper.detOper.New;
  LDetOper.seq := '007';
  LDetOper.dhOper := EncodeDate(2026, 1, 15) + EncodeTime(10, 30, 0, 0);
  LDetOper.TemqualifOper := True;
  LDetOper.qualifOper.indMoedaEstr := True;
  LDetOper.gBC.vBCApur := 100.00;
  LDetOper.gTributos.vBCTrib := 100.00;
  LDetOper.gTributos.pIBSMunTrib := 100.000000;
  LDetOper.gTributos.vIBSMunTrib := 100.00;
  LDetOper.gTributos.pIBSUFTrib := 100.000000;
  LDetOper.gTributos.vIBSUFTrib := 100.00;
  LDetOper.gTributos.pCBSTrib := 100.000000;
  LDetOper.gTributos.vCBSTrib := 100.00;

  Log('Evento D-2221 (evtAntecReceb) montado com dados de exemplo.');
end;

procedure TACBrDeREExemplo.GerarD2231;
var
  LDeRE: TDeRED2231;
  LDetOper: TdetOperCollectionItemD2231;
  LIdContribuinte: string;
begin
  LIdContribuinte := OnlyCPFCNPJAlphaNum(FACBrDeRE.Configuracoes.Geral.IdContribuinte);

  LDeRE := FACBrDeRE.Eventos.NewD2231;

  // Campos auxiliares para montagem do id (42 chars)
  LDeRE.evtArrendMerc.nrInscCompleto := LIdContribuinte;
  LDeRE.evtArrendMerc.dataGeracao := Now;
  LDeRE.evtArrendMerc.sequencial := 1;

  with LDeRE.evtArrendMerc.ideEvento do
  begin
    finEvt   := foRegistroOriginal;
    tpAmb    := FACBrDeRE.Configuracoes.WebServices.Ambiente;
    aplicEmi := aeEmpresa;
    verAplic := 'ACBrDeRE1.0';
  end;

  // nrInsc do ideContrib = CNPJ raiz (8 posicoes alfanumericas)
  LDeRE.evtArrendMerc.ideContrib.nrInsc := Copy(LIdContribuinte, 1, 8);

  // Periodo de apuracao (AAAA-MM)
  LDeRE.evtArrendMerc.idePeriodo.perApur := '2026-01';
  LDeRE.evtArrendMerc.idePeriodo.subPer := 1;

  LDeRE.evtArrendMerc.infoOper.gOper.chAgrup := '1HFE86Y5R21DEW1ZCYQESH0ARLH9DL65O6M209408301895931';
  LDeRE.evtArrendMerc.infoOper.gOper.codBC := '1I5E';
  LDeRE.evtArrendMerc.infoOper.gOper.idePartes.infoAdq.TemCNPJ := True;
  LDeRE.evtArrendMerc.infoOper.gOper.idePartes.infoAdq.CNPJ := '12345678000195';
  LDeRE.evtArrendMerc.infoOper.gOper.idePartes.infoAdq.TemcMun := True;
  LDeRE.evtArrendMerc.infoOper.gOper.idePartes.infoAdq.cMun := '5300108';
  LDetOper := LDeRE.evtArrendMerc.infoOper.gOper.dadosOper.detOper.New;
  LDetOper.seq := '007';
  LDetOper.dhOper := EncodeDate(2026, 1, 15) + EncodeTime(10, 30, 0, 0);
  LDetOper.gBC.TemvOper := True;
  LDetOper.gBC.vOper := 100.00;
  LDetOper.gBC.TemvBCApur := True;
  LDetOper.gBC.vBCApur := 100.00;
  LDetOper.TemgTributos := True;
  LDetOper.gTributos.vBCTrib := 100.00;
  LDetOper.gTributos.pIBSMunTrib := 100.000000;
  LDetOper.gTributos.vIBSMunTrib := 100.00;
  LDetOper.gTributos.pIBSUFTrib := 100.000000;
  LDetOper.gTributos.vIBSUFTrib := 100.00;
  LDetOper.gTributos.pCBSTrib := 100.000000;
  LDetOper.gTributos.vCBSTrib := 100.00;

  Log('Evento D-2231 (evtArrendMerc) montado com dados de exemplo.');
end;

procedure TACBrDeREExemplo.GerarD2241;
var
  LDeRE: TDeRED2241;
  LDetOper: TdetOperCollectionItemD2241;
  LIdContribuinte: string;
begin
  LIdContribuinte := OnlyCPFCNPJAlphaNum(FACBrDeRE.Configuracoes.Geral.IdContribuinte);

  LDeRE := FACBrDeRE.Eventos.NewD2241;

  // Campos auxiliares para montagem do id (42 chars)
  LDeRE.evtArranjoCredDest.nrInscCompleto := LIdContribuinte;
  LDeRE.evtArranjoCredDest.dataGeracao := Now;
  LDeRE.evtArranjoCredDest.sequencial := 1;

  with LDeRE.evtArranjoCredDest.ideEvento do
  begin
    finEvt   := foRegistroOriginal;
    tpAmb    := FACBrDeRE.Configuracoes.WebServices.Ambiente;
    aplicEmi := aeEmpresa;
    verAplic := 'ACBrDeRE1.0';
  end;

  // nrInsc do ideContrib = CNPJ raiz (8 posicoes alfanumericas)
  LDeRE.evtArranjoCredDest.ideContrib.nrInsc := Copy(LIdContribuinte, 1, 8);

  // Periodo de apuracao (AAAA-MM)
  LDeRE.evtArranjoCredDest.idePeriodo.perApur := '2026-01';
  LDeRE.evtArranjoCredDest.idePeriodo.subPer := 1;

  LDeRE.evtArranjoCredDest.infoOper.gOper.chAgrup := '1HFE86Y5R21DEW1ZCYQESH0ARLH9DL65O6M209408301895931';
  LDeRE.evtArranjoCredDest.infoOper.gOper.codBC := '1I5E';
  LDeRE.evtArranjoCredDest.infoOper.gOper.idePartes.infoAdq.TemCNPJ := True;
  LDeRE.evtArranjoCredDest.infoOper.gOper.idePartes.infoAdq.CNPJ := '12345678000195';
  LDeRE.evtArranjoCredDest.infoOper.gOper.idePartes.infoAdq.TemcMun := True;
  LDeRE.evtArranjoCredDest.infoOper.gOper.idePartes.infoAdq.cMun := '5300108';
  LDetOper := LDeRE.evtArranjoCredDest.infoOper.gOper.dadosOper.detOper.New;
  LDetOper.seq := '007';
  LDetOper.dhOper := EncodeDate(2026, 1, 15) + EncodeTime(10, 30, 0, 0);
  LDetOper.gBC.TemgDeducoes := True;
  LDetOper.gBC.gDeducoes.TemvISSQNProp := True;
  LDetOper.gBC.gDeducoes.vISSQNProp := 100.00;
  LDetOper.gBC.gDeducoes.TemvISSQNOutro := True;
  LDetOper.gBC.gDeducoes.vISSQNOutro := 100.00;
  LDetOper.gBC.gDeducoes.TemvPisCofins := True;
  LDetOper.gBC.gDeducoes.vPisCofins := 100.00;
  LDetOper.gBC.gDeducoes.TemvSomaDeducoes := True;
  LDetOper.gBC.gDeducoes.vSomaDeducoes := 100.00;
  LDetOper.gBC.detBC.vBCApur := 100.00;
  LDetOper.gTributos.vBCTrib := 100.00;
  LDetOper.gTributos.pIBSMunTrib := 100.000000;
  LDetOper.gTributos.vIBSMunTrib := 100.00;
  LDetOper.gTributos.pIBSUFTrib := 100.000000;
  LDetOper.gTributos.vIBSUFTrib := 100.00;
  LDetOper.gTributos.pCBSTrib := 100.000000;
  LDetOper.gTributos.vCBSTrib := 100.00;

  Log('Evento D-2241 (evtArranjoCredDest) montado com dados de exemplo.');
end;

procedure TACBrDeREExemplo.GerarD2242;
var
  LDeRE: TDeRED2242;
  LDetOper: TdetOperCollectionItemD2242;
  LIdContribuinte: string;
begin
  LIdContribuinte := OnlyCPFCNPJAlphaNum(FACBrDeRE.Configuracoes.Geral.IdContribuinte);

  LDeRE := FACBrDeRE.Eventos.NewD2242;

  // Campos auxiliares para montagem do id (42 chars)
  LDeRE.evtArranjoPartic.nrInscCompleto := LIdContribuinte;
  LDeRE.evtArranjoPartic.dataGeracao := Now;
  LDeRE.evtArranjoPartic.sequencial := 1;

  with LDeRE.evtArranjoPartic.ideEvento do
  begin
    finEvt   := foRegistroOriginal;
    tpAmb    := FACBrDeRE.Configuracoes.WebServices.Ambiente;
    aplicEmi := aeEmpresa;
    verAplic := 'ACBrDeRE1.0';
  end;

  // nrInsc do ideContrib = CNPJ raiz (8 posicoes alfanumericas)
  LDeRE.evtArranjoPartic.ideContrib.nrInsc := Copy(LIdContribuinte, 1, 8);
  LDeRE.evtArranjoPartic.ideContrib.tpParticip := partInstituidorBandeira;

  // Periodo de apuracao (AAAA-MM)
  LDeRE.evtArranjoPartic.idePeriodo.perApur := '2026-01';
  LDeRE.evtArranjoPartic.idePeriodo.subPer := 1;

  LDeRE.evtArranjoPartic.infoOper.gOper.chAgrup := '1HFE86Y5R21DEW1ZCYQESH0ARLH9DL65O6M209408301895931';
  LDeRE.evtArranjoPartic.infoOper.gOper.codBC := '1I5E';
  LDeRE.evtArranjoPartic.infoOper.gOper.idePartes.infoAdq.TemCNPJ := True;
  LDeRE.evtArranjoPartic.infoOper.gOper.idePartes.infoAdq.CNPJ := '12345678000195';
  LDeRE.evtArranjoPartic.infoOper.gOper.idePartes.infoAdq.TemcMun := True;
  LDeRE.evtArranjoPartic.infoOper.gOper.idePartes.infoAdq.cMun := '5300108';
  LDetOper := LDeRE.evtArranjoPartic.infoOper.gOper.dadosOper.detOper.New;
  LDetOper.seq := '007';
  LDetOper.dhOper := EncodeDate(2026, 1, 15) + EncodeTime(10, 30, 0, 0);
  LDetOper.gBC.gVOper.vLiqOper := 100.00;
  LDetOper.gBC.TemgDeducoes := True;
  LDetOper.gBC.gDeducoes.TemvISSQNProp := True;
  LDetOper.gBC.gDeducoes.vISSQNProp := 100.00;
  LDetOper.gBC.gDeducoes.TemvISSQNOutro := True;
  LDetOper.gBC.gDeducoes.vISSQNOutro := 100.00;
  LDetOper.gBC.gDeducoes.TemvPisCofins := True;
  LDetOper.gBC.gDeducoes.vPisCofins := 100.00;
  LDetOper.gBC.gDeducoes.TemvSomaDeducoes := True;
  LDetOper.gBC.gDeducoes.vSomaDeducoes := 100.00;
  LDetOper.gBC.detBC.vBCApur := 100.00;
  LDetOper.gTributos.vBCTrib := 100.00;
  LDetOper.gTributos.pIBSMunTrib := 100.000000;
  LDetOper.gTributos.vIBSMunTrib := 100.00;
  LDetOper.gTributos.pIBSUFTrib := 100.000000;
  LDetOper.gTributos.vIBSUFTrib := 100.00;
  LDetOper.gTributos.pCBSTrib := 100.000000;
  LDetOper.gTributos.vCBSTrib := 100.00;

  Log('Evento D-2242 (evtArranjoPartic) montado com dados de exemplo.');
end;

procedure TACBrDeREExemplo.GerarD2251;
var
  LDeRE: TDeRED2251;
  LDetOper: TdetOperCollectionItemD2251;
  LDetSegurado: TdetSeguradoCollectionItemD2251;
  LIdContribuinte: string;
begin
  LIdContribuinte := OnlyCPFCNPJAlphaNum(FACBrDeRE.Configuracoes.Geral.IdContribuinte);

  LDeRE := FACBrDeRE.Eventos.NewD2251;

  // Campos auxiliares para montagem do id (42 chars)
  LDeRE.evtSegPrevCap.nrInscCompleto := LIdContribuinte;
  LDeRE.evtSegPrevCap.dataGeracao := Now;
  LDeRE.evtSegPrevCap.sequencial := 1;

  with LDeRE.evtSegPrevCap.ideEvento do
  begin
    finEvt   := foRegistroOriginal;
    tpAmb    := FACBrDeRE.Configuracoes.WebServices.Ambiente;
    aplicEmi := aeEmpresa;
    verAplic := 'ACBrDeRE1.0';
  end;

  // nrInsc do ideContrib = CNPJ raiz (8 posicoes alfanumericas)
  LDeRE.evtSegPrevCap.ideContrib.nrInsc := Copy(LIdContribuinte, 1, 8);

  // Periodo de apuracao (AAAA-MM)
  LDeRE.evtSegPrevCap.idePeriodo.perApur := '2026-01';
  LDeRE.evtSegPrevCap.idePeriodo.subPer := 1;

  LDeRE.evtSegPrevCap.infoOper.gOper.chAgrup := '1HFE86Y5R21DEW1ZCYQESH0ARLH9DL65O6M209408301895931';
  LDeRE.evtSegPrevCap.infoOper.gOper.codBC := '1I5E';
  LDeRE.evtSegPrevCap.infoOper.gOper.idePartes.TemindIdentifAdq := True;
  LDeRE.evtSegPrevCap.infoOper.gOper.idePartes.indIdentifAdq := True;
  LDeRE.evtSegPrevCap.infoOper.gOper.idePartes.TeminfoAdq := True;
  LDeRE.evtSegPrevCap.infoOper.gOper.idePartes.infoAdq.TemCNPJ := True;
  LDeRE.evtSegPrevCap.infoOper.gOper.idePartes.infoAdq.CNPJ := '12345678000195';
  LDeRE.evtSegPrevCap.infoOper.gOper.idePartes.infoAdq.TemcMun := True;
  LDeRE.evtSegPrevCap.infoOper.gOper.idePartes.infoAdq.cMun := '5300108';
  LDetOper := LDeRE.evtSegPrevCap.infoOper.gOper.dadosOper.detOper.New;
  LDetOper.seq := '007';
  LDetOper.dhOper := EncodeDate(2026, 1, 15) + EncodeTime(10, 30, 0, 0);
  LDetOper.TemgComCobertPrev := True;
  LDetOper.gComCobertPrev.tpContrato := tcIndividual;
  LDetOper.gComCobertPrev.vBCDistr := 100.00;
  LDetOper.gComCobertPrev.TemgIdSegurados := True;
  LDetSegurado := LDetOper.gComCobertPrev.gIdSegurados.detSegurado.New;
  LDetSegurado.vBCDistrSeg := 100.00;
  LDetSegurado.TemCNPJSeg := True;
  LDetSegurado.CNPJSeg := 'TNANMDH4AYFA64';
  LDetSegurado.TemcMunSeg := True;
  LDetSegurado.cMunSeg := '5030564';

  Log('Evento D-2251 (evtSegPrevCap) montado com dados de exemplo.');
end;

procedure TACBrDeREExemplo.GerarD2252;
var
  LDeRE: TDeRED2252;
  LDetOper: TdetOperCollectionItemD2252;
  LIdContribuinte: string;
begin
  LIdContribuinte := OnlyCPFCNPJAlphaNum(FACBrDeRE.Configuracoes.Geral.IdContribuinte);

  LDeRE := FACBrDeRE.Eventos.NewD2252;

  // Campos auxiliares para montagem do id (42 chars)
  LDeRE.evtSegElemSCob.nrInscCompleto := LIdContribuinte;
  LDeRE.evtSegElemSCob.dataGeracao := Now;
  LDeRE.evtSegElemSCob.sequencial := 1;

  with LDeRE.evtSegElemSCob.ideEvento do
  begin
    finEvt   := foRegistroOriginal;
    tpAmb    := FACBrDeRE.Configuracoes.WebServices.Ambiente;
    aplicEmi := aeEmpresa;
    verAplic := 'ACBrDeRE1.0';
  end;

  // nrInsc do ideContrib = CNPJ raiz (8 posicoes alfanumericas)
  LDeRE.evtSegElemSCob.ideContrib.nrInsc := Copy(LIdContribuinte, 1, 8);

  // Periodo de apuracao (AAAA-MM)
  LDeRE.evtSegElemSCob.idePeriodo.perApur := '2026-01';
  LDeRE.evtSegElemSCob.idePeriodo.subPer := 1;

  LDeRE.evtSegElemSCob.infoOper.gOper.chAgrup := '1HFE86Y5R21DEW1ZCYQESH0ARLH9DL65O6M209408301895931';
  LDeRE.evtSegElemSCob.infoOper.gOper.codBC := '1I5E';
  LDeRE.evtSegElemSCob.infoOper.gOper.TemchAgrupRef := True;
  LDeRE.evtSegElemSCob.infoOper.gOper.chAgrupRef := 'OHTNANMDH45YFATOHZEK3E2KPH4DKDVPT9G203812313132871';
  LDeRE.evtSegElemSCob.infoOper.gOper.idePartes.infoAdq.TemCNPJ := True;
  LDeRE.evtSegElemSCob.infoOper.gOper.idePartes.infoAdq.CNPJ := '12345678000195';
  LDeRE.evtSegElemSCob.infoOper.gOper.idePartes.infoAdq.TemcMun := True;
  LDeRE.evtSegElemSCob.infoOper.gOper.idePartes.infoAdq.cMun := '5300108';
  LDetOper := LDeRE.evtSegElemSCob.infoOper.gOper.dadosOper.detOper.New;
  LDetOper.seq := '002';
  LDetOper.dhOper := EncodeDate(2026, 1, 15) + EncodeTime(10, 30, 0, 0);
  LDetOper.gBC.vBCApur := 100.00;
  LDetOper.gTributos.vBCTrib := 100.00;
  LDetOper.gTributos.pIBSMunTrib := 100.000000;
  LDetOper.gTributos.vIBSMunTrib := 100.00;
  LDetOper.gTributos.pIBSUFTrib := 100.000000;
  LDetOper.gTributos.vIBSUFTrib := 100.00;
  LDetOper.gTributos.pCBSTrib := 100.000000;
  LDetOper.gTributos.vCBSTrib := 100.00;

  Log('Evento D-2252 (evtSegElemSCob) montado com dados de exemplo.');
end;

procedure TACBrDeREExemplo.GerarD3201;
var
  LDeRE: TDeRED3201;
  LDetOper: TdetOperCollectionItemD3201;
  LDetBenef: TdetBenefCollectionItemD3201;
  LIdContribuinte: string;
begin
  LIdContribuinte := OnlyCPFCNPJAlphaNum(FACBrDeRE.Configuracoes.Geral.IdContribuinte);

  LDeRE := FACBrDeRE.Eventos.NewD3201;

  // Campos auxiliares para montagem do id (42 chars)
  LDeRE.evtPlAssistSaude.nrInscCompleto := LIdContribuinte;
  LDeRE.evtPlAssistSaude.dataGeracao := Now;
  LDeRE.evtPlAssistSaude.sequencial := 1;

  with LDeRE.evtPlAssistSaude.ideEvento do
  begin
    finEvt   := foRegistroOriginal;
    tpAmb    := FACBrDeRE.Configuracoes.WebServices.Ambiente;
    aplicEmi := aeEmpresa;
    verAplic := 'ACBrDeRE1.0';
  end;

  // nrInsc do ideContrib = CNPJ raiz (8 posicoes alfanumericas)
  LDeRE.evtPlAssistSaude.ideContrib.nrInsc := Copy(LIdContribuinte, 1, 8);

  // Periodo de apuracao (AAAA-MM)
  LDeRE.evtPlAssistSaude.idePeriodo.perApur := '2026-01';
  LDeRE.evtPlAssistSaude.idePeriodo.subPer := 1;

  LDeRE.evtPlAssistSaude.infoOper.gOper.chAgrup := '1HFE86Y5R21DEW1ZCYQESH0ARLH9DL65O6M209408301895931';
  LDeRE.evtPlAssistSaude.infoOper.gOper.codBC := '1I5E';
  LDeRE.evtPlAssistSaude.infoOper.gOper.TemchAgrupRef := True;
  LDeRE.evtPlAssistSaude.infoOper.gOper.chAgrupRef := 'OHTNANMDH45YFATOHZEK3E2KPH4DKDVPT9G203812313132871';
  LDeRE.evtPlAssistSaude.infoOper.gOper.idePartes.infoAdq.TemCNPJ := True;
  LDeRE.evtPlAssistSaude.infoOper.gOper.idePartes.infoAdq.CNPJ := '12345678000195';
  LDeRE.evtPlAssistSaude.infoOper.gOper.idePartes.infoAdq.TemcMun := True;
  LDeRE.evtPlAssistSaude.infoOper.gOper.idePartes.infoAdq.cMun := '5300108';
  LDetOper := LDeRE.evtPlAssistSaude.infoOper.gOper.dadosOper.detOper.New;
  LDetOper.seq := '002';
  LDetOper.dhOper := EncodeDate(2026, 1, 15) + EncodeTime(10, 30, 0, 0);
  LDetOper.qualifOper.idContrato := 'Exemplo';
  LDetOper.qualifOper.tpContrato := tcIndividualFamiliar;
  LDetOper.gBC.gVOper.vOper := 100.00;
  LDetOper.gBC.TemdetBC := True;
  LDetOper.gBC.detBC.vBCApur := 100.00;
  LDetOper.gBC.TemgIdBenef := True;
  LDetBenef := LDetOper.gBC.gIdBenef.detBenef.New;
  LDetBenef.TemdtNascTitular := True;
  LDetBenef.dtNascTitular := EncodeDate(2005, 5, 20);
  LDetBenef.TemvTitularDep := True;
  LDetBenef.vTitularDep := 100.00;
  LDetBenef.TemdetDependentes := True;
  LDetBenef.detDependentes.dtNascDep.Add(EncodeDate(2005, 5, 20));
  LDetOper.TemgTributos := True;
  LDetOper.gTributos.vBCTrib := 100.00;
  LDetOper.gTributos.pIBSMunTrib := 100.000000;
  LDetOper.gTributos.vIBSMunTrib := 100.00;
  LDetOper.gTributos.pIBSUFTrib := 100.000000;
  LDetOper.gTributos.vIBSUFTrib := 100.00;
  LDetOper.gTributos.pCBSTrib := 100.000000;
  LDetOper.gTributos.vCBSTrib := 100.00;

  Log('Evento D-3201 (evtPlAssistSaude) montado com dados de exemplo.');
end;

procedure TACBrDeREExemplo.GerarD4201;
var
  LDeRE: TDeRED4201;
  LDetOper: TdetOperCollectionItemD4201;
  LIdContribuinte: string;
begin
  LIdContribuinte := OnlyCPFCNPJAlphaNum(FACBrDeRE.Configuracoes.Geral.IdContribuinte);

  LDeRE := FACBrDeRE.Eventos.NewD4201;

  // Campos auxiliares para montagem do id (42 chars)
  LDeRE.evtIdApostPrem.nrInscCompleto := LIdContribuinte;
  LDeRE.evtIdApostPrem.dataGeracao := Now;
  LDeRE.evtIdApostPrem.sequencial := 1;

  with LDeRE.evtIdApostPrem.ideEvento do
  begin
    finEvt   := foRegistroOriginal;
    tpAmb    := FACBrDeRE.Configuracoes.WebServices.Ambiente;
    aplicEmi := aeEmpresa;
    verAplic := 'ACBrDeRE1.0';
  end;

  // nrInsc do ideContrib = CNPJ raiz (8 posicoes alfanumericas)
  LDeRE.evtIdApostPrem.ideContrib.nrInsc := Copy(LIdContribuinte, 1, 8);

  // Periodo de apuracao (AAAA-MM)
  LDeRE.evtIdApostPrem.idePeriodo.perApur := '2026-01';
  LDeRE.evtIdApostPrem.idePeriodo.subPer := 1;

  LDeRE.evtIdApostPrem.infoOper.gOper.chAgrup := '1HFE86Y5R21DEW1ZCYQESH0ARLH9DL65O6M209408301895931';
  LDeRE.evtIdApostPrem.infoOper.gOper.codBC := '1I5E';
  LDeRE.evtIdApostPrem.infoOper.gOper.TemchAgrupRef := True;
  LDeRE.evtIdApostPrem.infoOper.gOper.chAgrupRef := 'OHTNANMDH45YFATOHZEK3E2KPH4DKDVPT9G203812313132871';
  LDeRE.evtIdApostPrem.infoOper.gOper.idePartes.indApostaPresenc := True;
  LDeRE.evtIdApostPrem.infoOper.gOper.idePartes.TeminfoAdq := True;
  LDeRE.evtIdApostPrem.infoOper.gOper.idePartes.infoAdq.TemCNPJ := True;
  LDeRE.evtIdApostPrem.infoOper.gOper.idePartes.infoAdq.CNPJ := '12345678000195';
  LDeRE.evtIdApostPrem.infoOper.gOper.idePartes.infoAdq.TemcMun := True;
  LDeRE.evtIdApostPrem.infoOper.gOper.idePartes.infoAdq.cMun := '5300108';
  LDetOper := LDeRE.evtIdApostPrem.infoOper.gOper.dadosOper.detOper.New;
  LDetOper.seq := '002';
  LDetOper.dhOper := EncodeDate(2026, 1, 15) + EncodeTime(10, 30, 0, 0);
  LDetOper.infoAposta.TemcMunOper := True;
  LDetOper.infoAposta.cMunOper := '2691669';
  LDetOper.infoAposta.vOper := 100.00;

  Log('Evento D-4201 (evtIdApostPrem) montado com dados de exemplo.');
end;

procedure TACBrDeREExemplo.GerarD1001;
var
  LDeRE: TDeRED1001;
  LIdContribuinte: string;
begin
  LIdContribuinte := OnlyCPFCNPJAlphaNum(FACBrDeRE.Configuracoes.Geral.IdContribuinte);

  LDeRE := FACBrDeRE.Eventos.NewD1001;

  // Campos auxiliares para montagem do id (42 chars)
  // CNPJ alfanumerico: mesma limpeza usada em MontarId (OnlyCPFCNPJAlphaNum)
  LDeRE.evtInfoContrib.nrInscCompleto := LIdContribuinte;
  LDeRE.evtInfoContrib.dataGeracao := Now;
  LDeRE.evtInfoContrib.sequencial := 1;

  with LDeRE.evtInfoContrib.ideEvento do
  begin
    tpOper   := toInclusao;
    tpAmb    := FACBrDeRE.Configuracoes.WebServices.Ambiente;
    aplicEmi := aeEmpresa;
    verAplic := 'ACBrDeRE1.0';
  end;

  // nrInsc do ideContrib = CNPJ raiz (8 posicoes alfanumericas, conforme XSD [0-9A-Z]{8})
  LDeRE.evtInfoContrib.ideContrib.nrInsc := Copy(LIdContribuinte, 1, 8);

  LDeRE.evtInfoContrib.idePeriodo.iniValid := EncodeDate(2026, 1, 1);

  with LDeRE.evtInfoContrib.infoContrib do
  begin
    TeminfoContrib := True;
    regTribPrinc   := rtServFinanceiros;
    indNatTrib     := intTributacaoRegular;
  end;

  Log('Evento D-1001 (evtInfoContrib) montado com dados de exemplo.');
end;

procedure TACBrDeREExemplo.GerarD1011;
var
  LDeRE: TDeRED1011;
  LConta: TinfoContaCollectionItemD1011;
  LIdContribuinte: string;
begin
  LIdContribuinte := OnlyCPFCNPJAlphaNum(FACBrDeRE.Configuracoes.Geral.IdContribuinte);

  LDeRE := FACBrDeRE.Eventos.NewD1011;

  // Campos auxiliares para montagem do id (42 chars)
  LDeRE.evtPGCC.nrInscCompleto := LIdContribuinte;
  LDeRE.evtPGCC.dataGeracao := Now;
  LDeRE.evtPGCC.sequencial := 1;

  with LDeRE.evtPGCC.ideEvento do
  begin
    tpOper   := toInclusao;
    tpAmb    := FACBrDeRE.Configuracoes.WebServices.Ambiente;
    aplicEmi := aeEmpresa;
    verAplic := 'ACBrDeRE1.0';
  end;

  // nrInsc do ideContrib = CNPJ raiz (8 posicoes alfanumericas)
  LDeRE.evtPGCC.ideContrib.nrInsc := Copy(LIdContribuinte, 1, 8);

  LDeRE.evtPGCC.idePeriodo.iniValid := EncodeDate(2026, 1, 1);

  with LDeRE.evtPGCC.infoPGCC do
  begin
    TeminfoPGCC := True;
    planoCtaRef := pcrCOSIF;
    freqEncerr  := feMensal;

    LConta := infoContas.New;
    LConta.cCta        := '1';
    LConta.cCtaInterna := '1';
    LConta.cDbrMista   := '000';
    LConta.nomeCta     := 'ATIVO';
    LConta.indCta      := icSintetica;
    LConta.cCtaRef     := '1';
    LConta.nivelCta    := 1;
    LConta.natCta      := ncDevedora;
    LConta.codNat      := cnAtivo;
    LConta.iniVig      := EncodeDate(2026, 1, 1);
  end;

  Log('Evento D-1011 (evtPGCC) montado com dados de exemplo.');
end;

end.
