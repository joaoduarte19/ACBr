{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
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

unit ACBrTEFAPITXT;

{$I ACBr.inc}

interface

uses
  Classes, SysUtils,
  ACBrBase,
  ACBrTEFComum, ACBrTEFAPI, ACBrTEFAPIComum, ACBrTEFTXTComum,
  ACBrTEFTXTGerenciadorPadrao, ACBrTEFTXTPayGo;

resourcestring
  CINFOTEFTXT_EnviandoRequisicao = 'Enviando Requisição';
  CINFOTEFTXT_AguardandoSts = 'Aguardando Status';
  CINFOTEFTXT_AguardandoResp ='Aguardando Resposta';

type

  TACBrTEFTXTModelo = (teftxtNenhum, teftxtGerenciadorPadrao, teftxtPayGo, teftxtSiTEF);

  { TACBrTEFAPIClassTXT }

  TACBrTEFAPIClassTXT = class(TACBrTEFAPIClass)
  private
    fAguardandoResposta: Boolean;
    fModelo: TACBrTEFTXTModelo;
    fTEFTXT: TACBrTEFTXTGerenciadorPadrao;

    procedure QuandoGravarLogAPI(const ALogLine: String; var Tratado: Boolean);
    procedure QuandoAguardarArquivoAPI( ArquivoAguardado: String;
      SegundosParaTimeOut: Double; var Interromper: Boolean);
    procedure QuandoMudarStatusAPI(Sender: TObject);
    procedure SetModelo(AValue: TACBrTEFTXTModelo);

    procedure ConfigurarTEFTXTPayGo;

  protected
    procedure InterpretarRespostaAPI; override;
    procedure CarregarRespostasPendentes(const AListaRespostasTEF: TACBrTEFAPIRespostas); override;

  public
    constructor Create(AACBrTEFAPI: TACBrTEFAPIComum);
    destructor Destroy; override;

    procedure Inicializar; override;

    function EfetuarPagamento(
      ValorPagto: Currency;
      Modalidade: TACBrTEFModalidadePagamento = tefmpNaoDefinido;
      CartoesAceitos: TACBrTEFTiposCartao = [];
      Financiamento: TACBrTEFModalidadeFinanciamento = tefmfNaoDefinido;
      Parcelas: Byte = 0;
      DataPreDatado: TDateTime = 0;
      DadosAdicionais: String = ''): Boolean; override;

    function EfetuarAdministrativa(
      CodOperacaoAdm: TACBrTEFOperacao = tefopAdministrativo): Boolean; overload; override;
    function EfetuarAdministrativa(
      const CodOperacaoAdm: string = ''): Boolean; overload; override;

    function CancelarTransacao(
      const NSU, CodigoAutorizacaoTransacao: string;
      DataHoraTransacao: TDateTime;
      Valor: Double;
      const CodigoFinalizacao: string = '';
      const Rede: string = ''): Boolean; override;

    procedure FinalizarTransacao(
      const Rede, NSU, CodigoFinalizacao: String;
      AStatus: TACBrTEFStatusTransacao = tefstsSucessoAutomatico); override;

    function ObterDadoPinPad(TipoDado: TACBrTEFAPIDadoPinPad; TimeOut: Integer = 30000;
      MinLen: SmallInt = 0; MaxLen: SmallInt = 0): String; override;
    function MenuPinPad(const Titulo: String; Opcoes: TStrings; TimeOut: Integer = 30000):
      Integer; override;

    function VersaoAPI: String; override;

    procedure ResolverTransacaoPendente(AStatus: TACBrTEFStatusTransacao = tefstsSucessoManual); override;
    procedure AbortarTransacaoEmAndamento; override;

    property TEFTXT: TACBrTEFTXTGerenciadorPadrao read fTEFTXT;
    property Modelo: TACBrTEFTXTModelo read fModelo write SetModelo;
    property AguardandoResposta: Boolean read fAguardandoResposta;
  end;


implementation

uses
  ACBrUtil.Strings;

{ TACBrTEFAPIClassTXT }

constructor TACBrTEFAPIClassTXT.Create(AACBrTEFAPI: TACBrTEFAPIComum);
begin
  inherited;
  fAguardandoResposta := False;
  fTEFTXT := Nil;
  fModelo := teftxtNenhum;
  SetModelo(teftxtGerenciadorPadrao);
end;

destructor TACBrTEFAPIClassTXT.Destroy;
begin
  fTEFTXT.Free;
  inherited Destroy;
end;

procedure TACBrTEFAPIClassTXT.Inicializar;
begin
  AbortarTransacaoEmAndamento;
  inherited Inicializar;
end;

procedure TACBrTEFAPIClassTXT.SetModelo(AValue: TACBrTEFTXTModelo);
var
  lEventoObterId: TACBrTEFTXTObterID;
  lEventoGravarRequisicao: TACBrTEFTXTAntesGravarRequisicao;
begin
  if fModelo = AValue then Exit;

  lEventoObterId := Nil;
  lEventoGravarRequisicao := Nil;
  if Assigned(fTEFTXT) then
  begin
    lEventoObterId := fTEFTXT.QuandoObterID;
    lEventoGravarRequisicao := fTEFTXT.AntesGravarRequisicao;
    fTEFTXT.Free
  end;

  case AValue of
    teftxtPayGo:
      begin
        fTEFTXT := TACBrTEFTXTPayGo.Create;
        fpTEFRespClass := TACBrTEFRespTXTPayGo;
        ConfigurarTEFTXTPayGo;
      end;
    teftxtSiTEF:
      begin
        //TODO
        fTEFTXT := TACBrTEFTXTGerenciadorPadrao.Create;
        fpTEFRespClass := TACBrTEFRespTXTGerenciadorPadrao;
      end;
  else
    fTEFTXT := TACBrTEFTXTGerenciadorPadrao.Create;
    fpTEFRespClass := TACBrTEFRespTXTGerenciadorPadrao;
  end;

  fTEFTXT.QuandoGravarLog := QuandoGravarLogAPI;
  fTEFTXT.QuandoAguardarArquivo := QuandoAguardarArquivoAPI;
  fTEFTXT.QuandoMudarStatus := QuandoMudarStatusAPI;
  fTEFTXT.QuandoObterID := lEventoObterId;
  fTEFTXT.AntesGravarRequisicao := lEventoGravarRequisicao;

  fModelo := AValue;
end;

procedure TACBrTEFAPIClassTXT.ConfigurarTEFTXTPayGo;
begin
  if not (fTEFTXT is TACBrTEFTXTPayGo) then
    Exit;

  with TACBrTEFTXTPayGo(fTEFTXT) do
  begin
    if (fpACBrTEFAPI.DadosAutomacao.MoedaISO4217 = CMODEDA_USD) then
      Moeda := 1
    else if (fpACBrTEFAPI.DadosAutomacao.MoedaISO4217 = CMODEDA_EUR) then
      Moeda := 2
    else
      Moeda := 0;

    Idioma := Integer(fpACBrTEFAPI.DadosAutomacao.Idioma); // 0: Português, 1: Inglês, 2: Espanhol
    SuportaTroco := fpACBrTEFAPI.DadosAutomacao.SuportaSaque;
    SuportaDesconto := fpACBrTEFAPI.DadosAutomacao.SuportaDesconto;
    SuportaViasDiferentes := fpACBrTEFAPI.DadosAutomacao.SuportaViasDiferenciadas;
    SuportaCupomReduzido := fpACBrTEFAPI.DadosAutomacao.SuportaViasDiferenciadas;
    UsarCupomReduzido := fpACBrTEFAPI.DadosAutomacao.ImprimeViaClienteReduzida;
    SuportaReajusteValor := fpACBrTEFAPI.DadosAutomacao.SuportaSaque and fpACBrTEFAPI.DadosAutomacao.SuportaDesconto;
    NomeAplicacao := fpACBrTEFAPI.DadosAutomacao.NomeAplicacao;
    VersaoAplicacao := fpACBrTEFAPI.DadosAutomacao.VersaoAplicacao;
    RegistroCertificacao := fpACBrTEFAPI.DadosAutomacao.ParamAplicacao;
    SoftwareHouse := fpACBrTEFAPI.DadosAutomacao.NomeSoftwareHouse;
    DadosAdicionais1 := fpACBrTEFAPI.DadosAutomacao.CNPJSoftwareHouse;
  end;
end;

procedure TACBrTEFAPIClassTXT.QuandoGravarLogAPI(const ALogLine: String;  var Tratado: Boolean);
begin
  fpACBrTEFAPI.GravarLog(ALogLine);
  Tratado := True;
end;

procedure TACBrTEFAPIClassTXT.QuandoAguardarArquivoAPI(ArquivoAguardado: String;
  SegundosParaTimeOut: Double; var Interromper: Boolean);
var
  msg: String;
  Secs: Double;
begin
  Secs := 0;
  if (SegundosParaTimeOut < 0) then
    Secs := abs(SegundosParaTimeOut)
  else
    Secs := ((fTEFTXT.Config.TempoLimiteEsperaStatus/1000) - SegundosParaTimeOut);

  if (Secs >= 2) then  // So exibe msg se espera passar de 2 seg
  begin
    msg := Format( ACBrStr(CInfoAguardandoResposta),
                   [fTEFTXT.ModeloTEF, FormatFloat('##0',abs(SegundosParaTimeOut))] );
    TACBrTEFAPI(fpACBrTEFAPI).QuandoExibirMensagem( msg, telaTodas, -1);
  end;

  if (ArquivoAguardado <> fTEFTXT.ArqSts) then
    TACBrTEFAPI(fpACBrTEFAPI).QuandoEsperarOperacao(opapiAguardaUsuario, Interromper);

  if not Interromper then
    Interromper := (fAguardandoResposta = False);
end;

procedure TACBrTEFAPIClassTXT.QuandoMudarStatusAPI(Sender: TObject);
var
  msg: String;
begin
  msg := '';
  case fTEFTXT.Status of
    tefstEnviandoRequisicao: msg := ACBrStr(CINFOTEFTXT_EnviandoRequisicao);
    tefstAguardandoSts: msg := ACBrStr(CINFOTEFTXT_AguardandoSts);
    tefstAguardandoResp: msg := ACBrStr(CINFOTEFTXT_AguardandoResp);
  end;

  fAguardandoResposta := (fTEFTXT.Status in [tefstAguardandoSts, tefstAguardandoResp]);
  TACBrTEFAPI(fpACBrTEFAPI).QuandoExibirMensagem( msg, telaTodas, -1);
end;

procedure TACBrTEFAPIClassTXT.InterpretarRespostaAPI;
begin
  fpACBrTEFAPI.UltimaRespostaTEF.Clear;
  fTEFTXT.Resp.SalvarArquivo(fpACBrTEFAPI.UltimaRespostaTEF.Conteudo.Conteudo);
  fpACBrTEFAPI.UltimaRespostaTEF.ViaClienteReduzida := fpACBrTEFAPI.DadosAutomacao.ImprimeViaClienteReduzida;
  fpACBrTEFAPI.UltimaRespostaTEF.ConteudoToProperty;
end;

procedure TACBrTEFAPIClassTXT.CarregarRespostasPendentes(
  const AListaRespostasTEF: TACBrTEFAPIRespostas);
var
  Resp: TACBrTEFResp;
begin
  inherited CarregarRespostasPendentes(AListaRespostasTEF);

  if FileExists(fTEFTXT.ArqResp) then
  begin
    Resp := fpTEFRespClass.Create;
    try
      Resp.LeArquivo(fTEFTXT.ArqResp);
      Resp.ConteudoToProperty;
      Resp.ArqBackup := fTEFTXT.ArqResp;
      fpACBrTEFAPI.RespostasTEF.AdicionarRespostaTEF(Resp);
    finally
      Resp.Free;
    end;
  end;
end;

function TACBrTEFAPIClassTXT.EfetuarPagamento(ValorPagto: Currency;
  Modalidade: TACBrTEFModalidadePagamento; CartoesAceitos: TACBrTEFTiposCartao;
  Financiamento: TACBrTEFModalidadeFinanciamento; Parcelas: Byte;
  DataPreDatado: TDateTime; DadosAdicionais: String): Boolean;
var
  Moeda, tc, tf, fp: Integer;
  sl: TStringList;
begin
  // Gerenciador padrão (original) não preve forma da passar parâmetros:
  // CartoesAceitos, Financiamento, Parcelas, DataPreDatado

  sl := TStringList.Create;
  try
    sl.Text := DadosAdicionais;
    fTEFTXT.ParamReq.LerArquivo(sl);
  finally
    sl.Free
  end;

  if (fpACBrTEFAPI.DadosAutomacao.MoedaISO4217 = CMODEDA_USD) then
    Moeda := 1
  else
    Moeda := 0;
  if (fTEFTXT is TACBrTEFTXTPayGo) then
  begin
    with TACBrTEFTXTPayGo(fTEFTXT) do
    begin
      tc := 0;
      if (teftcCredito in CartoesAceitos) then
        tc := 1
      else if (teftcDebito in CartoesAceitos) then
        tc := 2
      else if (teftcVoucher in CartoesAceitos) then
        tc := 3;

      case Financiamento of
        tefmfAVista: tf := 1;
        tefmfParceladoEmissor: tf := 2;
        tefmfParceladoEstabelecimento: tf := 3;
        tefmfPredatado: tf := 4;
        tefmfCreditoEmissor: tf := 5;
      else
        tf := 0;
      end;

      case Modalidade of
        tefmpCartao: fp := 1;
        tefmpDinheiro: fp := 2;
        tefmpCheque: fp := 4;
        tefmpCarteiraVirtual: fp := 8;
      else
        fp := 0;
      end;

      CRT( ValorPagto,
           fpACBrTEFAPI.RespostasTEF.IdentificadorTransacao,
           fpACBrTEFAPI.RespostasTEF.DataHoraIdentificador,
           tc, tf, fp,
           'F', ParamReq.Campo[7,0].AsString,  // 007-000 Identificador Cliente
           Parcelas, DataPreDatado,
           ParamReq.Campo[727,0].AsFloat,      // 727-000 Taxa de serviço
           ParamReq.Campo[728,0].AsFloat,      // 728-000 Taxa de embarque
           ParamReq.Campo[010,0].AsString);    // 010-000 Rede Adquirente
    end;
  end
  else
  begin
    if (Modalidade = tefmpCheque) then
      Result := fTEFTXT.CHQ( ValorPagto, fpACBrTEFAPI.RespostasTEF.IdentificadorTransacao)
    else
      Result := fTEFTXT.CRT( ValorPagto, fpACBrTEFAPI.RespostasTEF.IdentificadorTransacao, Moeda);
  end;
end;

function TACBrTEFAPIClassTXT.EfetuarAdministrativa(CodOperacaoAdm: TACBrTEFOperacao): Boolean;
begin
  Result := False;
  if (CodOperacaoAdm = tefopTesteComunicacao) then
  begin
    fTEFTXT.ATV;
    Result := True;
    TEFTXT.Resp.Campo[9,0].AsString := '0'; // Sinaliza como Sucesso
  end
  else
    Result := fTEFTXT.ADM;
end;

function TACBrTEFAPIClassTXT.EfetuarAdministrativa(const CodOperacaoAdm: string): Boolean;
begin
  Result := EfetuarAdministrativa(tefopNenhuma);
end;

function TACBrTEFAPIClassTXT.CancelarTransacao(const NSU,
  CodigoAutorizacaoTransacao: string; DataHoraTransacao: TDateTime;
  Valor: Double; const CodigoFinalizacao: string; const Rede: string): Boolean;
begin
  Result := fTEFTXT.CNC( Valor, Rede, NSU, DataHoraTransacao);
end;

procedure TACBrTEFAPIClassTXT.FinalizarTransacao(const Rede, NSU,
  CodigoFinalizacao: String; AStatus: TACBrTEFStatusTransacao);
begin
  if (AStatus in [tefstsSucessoAutomatico, tefstsSucessoManual]) then
    fTEFTXT.CNF(Rede, NSU, CodigoFinalizacao)
  else
    fTEFTXT.NCN(Rede, NSU, CodigoFinalizacao)
end;

function TACBrTEFAPIClassTXT.ObterDadoPinPad(TipoDado: TACBrTEFAPIDadoPinPad;
  TimeOut: Integer; MinLen: SmallInt; MaxLen: SmallInt): String;
var
  lCmdExiste: Boolean;
  tp: Char;
begin
  lCmdExiste := False;
  if (fTEFTXT is TACBrTEFTXTPayGo) then
  begin
    with TACBrTEFTXTPayGo(fTEFTXT) do
    begin
      lCmdExiste := True;
      case TipoDado of
        dpCPF: tp := 'F';
        dpCNPJ: tp := 'J';
      else
        tp := 'X';
      end;

      Result := CPD(tp);
    end;
  end;

  if not lCmdExiste then
    fpACBrTEFAPI.DoException(Format(ACBrStr(CErroComandoNaoExisteEmTEF), ['CPD', fTEFTXT.ModeloTEF]));
end;

function TACBrTEFAPIClassTXT.MenuPinPad(const Titulo: String; Opcoes: TStrings;
  TimeOut: Integer): Integer;
begin
  Result := inherited MenuPinPad(Titulo, Opcoes, TimeOut);
end;

procedure TACBrTEFAPIClassTXT.ResolverTransacaoPendente(
  AStatus: TACBrTEFStatusTransacao);
begin
  if fpACBrTEFAPI.UltimaRespostaTEF.Confirmar then
  begin
    FinalizarTransacao( fpACBrTEFAPI.UltimaRespostaTEF.Rede,
                        fpACBrTEFAPI.UltimaRespostaTEF.NSU,
                        fpACBrTEFAPI.UltimaRespostaTEF.Finalizacao,
                        AStatus );
  end;
end;

procedure TACBrTEFAPIClassTXT.AbortarTransacaoEmAndamento;
begin
  fAguardandoResposta := False;
end;

function TACBrTEFAPIClassTXT.VersaoAPI: String;
begin
  Result := fTEFTXT.VersaoTEF;
end;

end.

