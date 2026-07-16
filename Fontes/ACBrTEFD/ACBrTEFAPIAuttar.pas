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

{$I ACBr.inc}

unit ACBrTEFAPIAuttar;

interface

uses
  Classes, SysUtils,
  ACBrBase,
  ACBrTEFComum, ACBrTEFAPI, ACBrTEFAPIComum, ACBrTEFAuttarAPI;


resourcestring
  sMsgComunicacaoCTF = 'Comunicação com %s, %s';

type

  { TACBrTEFRespAuttar }

  TACBrTEFRespAuttar = class( TACBrTEFResp )
  public
    procedure ConteudoToProperty; override;
    procedure ProcessarTipoInterno(ALinha: TACBrTEFLinha); override;
  end;


  { TACBrTEFAPIClassAuttar }

  TACBrTEFAPIClassAuttar = class(TACBrTEFAPIClass)
  private
    function GetTEFAuttar: TACBrTEFAuttarAPI;
    procedure QuandoGravarLogAPI(const ALogLine: String; var Tratado: Boolean);
    procedure QuandoExibirMensagemAPI(const Mensagem: String; Tela: Integer;
      MilissegundosExibicao: Integer; out Cancelar: Boolean);
    procedure QuandoPerguntarMenuAPI(const Titulo: String; Opcoes: TStringList;
      out ItemSelecionado: Integer);
    procedure QuandoPerguntarCampoAPI( const Titulo: String;
      TipoCampo, TamMaximo: Integer; ZerosAEsquerda: Boolean;
      out Resposta: String; out Cancelar: Boolean);
    procedure QuandoTransacaoEmAndamentoAPI(out Cancelar: Boolean);
  protected
    procedure InterpretarRespostaAPI; override;
    function TestarComunicacaoAuttar: Boolean;
    procedure DadosAdicionaisToStringList(const DadosAdicionais: String; SL: TStringList);
    procedure ExibirQRCodeCTF(const APathQRCodePNG: String);
  public
    constructor Create(AACBrTEFAPI: TACBrTEFAPIComum);
    destructor Destroy; override;

    procedure Inicializar; override;
    procedure DesInicializar; override;

    function EfetuarPagamento(
      ValorPagto: Currency;
      Modalidade: TACBrTEFModalidadePagamento = tefmpNaoDefinido;
      CartoesAceitos: TACBrTEFTiposCartao = [];
      Financiamento: TACBrTEFModalidadeFinanciamento = tefmfNaoDefinido;
      Parcelas: Byte = 0;
      DataPreDatado: TDateTime = 0;
      DadosAdicionais: String = ''): Boolean; override;

    function ConsultarPIXAutorizado(const NsuCTF: String): Boolean;
    function DevolverPIX(const NsuCTF: String; AData: TDateTime): Boolean;

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

    procedure ResolverTransacaoPendente(AStatus: TACBrTEFStatusTransacao = tefstsSucessoManual); override;
    procedure AbortarTransacaoEmAndamento; override;

    function ObterDadoPinPad(TipoDado: TACBrTEFAPIDadoPinPad;
      TimeOut: Integer = 30000; MinLen: SmallInt = 0; MaxLen: SmallInt = 0): String; override;

    function LerConfiguracaoCTF: String;

    property TEFAuttarAPI: TACBrTEFAuttarAPI read GetTEFAuttar;
  end;

implementation

uses
  math, StrUtils, TypInfo, DateUtils,
  ACBrUtil.Strings,
  ACBrUtil.FilesIO,
  ACBrUtil.Math;

{ TACBrTEFRespPayKit }

procedure TACBrTEFRespAuttar.ConteudoToProperty;
var
  Linha: TACBrTEFLinha;
  Info: TACBrInformacao;
  LinStr: String;
  i: Integer;
  CodErro: LongInt;
begin
  ImagemComprovante1aVia.Clear;
  ImagemComprovante2aVia.Clear;
  Debito := False;
  Credito := False;
  Digitado := False;

  for i := 0 to Conteudo.Count - 1 do
  begin
    Linha := Conteudo.Linha[i];
    Info := Linha.Informacao;
    LinStr := StringToBinaryString(Info.AsString);

    case Linha.Identificacao of
      SC_S_CODIGO_RETORNO:
        begin
          Sucesso := (Info.AsInteger = RET_OK);
          if (not Sucesso) and (TextoEspecialOperador = '') then
            TextoEspecialOperador := TraduzirErroCTF(Info.AsInteger);
        end;

      SC_S_CODIGO_TRANSACAO_CTF:
      begin
        ModalidadePagto := LinStr;
        TipoTransacao := Info.AsInteger;
        Credito := (TipoTransacao >= OP_CREDITO_VISTA) and (TipoTransacao < OP_CONSULTA_CREDITO_DIGITADO) or
                   (TipoTransacao = OP_CREDITO_GENERICO);
        Debito := (TipoTransacao >= OP_DEBITO) and (TipoTransacao < OP_CONSULTA_CDC) or
                  (TipoTransacao = OP_DEBITO_GENERICO);
      end;

      SC_ES_VALOR_TRANSACAO:
        ValorTotal := Info.AsFloat;

      SC_ES_NUMERO_CARTAO:
        PAN := LinStr;

      SC_ES_NUMERO_CARTAO_DIGITADO:
      begin
        if (PAN = '') then
          PAN := LinStr;
      end;

      SC_ES_NUMERO_PARCELAS:
        QtdParcelas := Info.AsInteger;

      SC_ES_DATA_VENCTO_CARTAO_MMAA:
        NFCeSAT.DataExpiracao := LinStr;

      SC_S_COD_AUTORIZADORA_CTF:
        CodigoRedeAutorizada := LinStr;

      SC_E_NSU_CTF_ORIGINAL:
      begin
        if (NSUTransacaoCancelada = '') then
          NSUTransacaoCancelada := LinStr;
      end;

      SC_S_CODIGO_RESPOSTA:
        StatusTransacao := LinStr;

      SC_E_NUMERO_DOCTO_FISCAL:
        DocumentoVinculado := LinStr;

      SC_E_NUMERO_CHEQUE:
        Cheque := LinStr;

      SC_E_DATA_CHEQUE_DDMMAA:
        DataCheque := Info.AsDate;

      SC_E_NUMERO_BANCO:
        Banco := LinStr;

      SC_E_NUMERO_AGENCIA:
        Agencia := LinStr;

      SC_E_DOCUMENTO_CLIENTE:
        DocumentoPessoa := LinStr;

      SC_S_DADOS_RETORNADOS:
        Trailer := LinStr;

      SC_S_NSU_TEF:
        NSU_TEF := LinStr;

      SC_E_TAXA_SERVICO:
        TaxaServico := Info.AsFloat;

      SC_E_VALOR_ENTRADA:
        ValorEntradaCDC := Info.AsFloat;

      SC_E_VALOR_SAQUE:
        Saque := Info.AsFloat;

      SC_E_CODIGO_SEGURANCA:
        SerialPOS := LinStr;

      SC_S_NSU_AUTORIZADORA:
      begin
        if (NSU = '') then
          NSU := LinStr;
      end;

      SC_ES_DATA_AGENDAMENTO_PREDATADO:
        DataPreDatado := Info.AsDate;

      SC_S_CODIGO_APROVACAO_AUTORIZADORA:
      begin
        if (CodigoAutorizacaoTransacao = '') then
          CodigoAutorizacaoTransacao := LinStr;
      end;

      SC_E_DATA_PARCELA_DEBITO_CDC:
      begin
        DataVencimento := Info.AsDate;
        DataEntradaCDC := DataVencimento;
      end;

      SC_E_VALOR_DESCONTO:
      begin
        if (Desconto = 0) then
          Desconto := Info.AsFloat;
      end;

      SC_ES_DATA_TRANSACAO_ORIGINAL:
        DataHoraTransacaoCancelada := Info.AsDate;

      SC_E_VALOR_CANCELAMENTO:
        ValorOriginal := Info.AsFloat;

      SC_S_ERRO_AUTORIZADORA:
      begin
        if (Autenticacao = '') then
          Autenticacao := LinStr;
      end;

      SC_S_CODIGO_ERRO:
        Autenticacao := LinStr;

      SC_S_DESCRICAO_TRANSACAO:
        ModalidadePagtoDescrita := LinStr;

      SC_S_VIA_CLIENTE:
        ImagemComprovante1aVia.Text := StringReplace(LinStr, '\', sLineBreak, [rfReplaceAll]);

      SC_S_VIA_LOJISTA:
        ImagemComprovante2aVia.Text := StringReplace(LinStr, '\', sLineBreak, [rfReplaceAll]);

      SC_S_REIMPRESSAO_VIA_CLIENTE:
      begin
        if (ImagemComprovante1aVia.Count = 0) then
          ImagemComprovante1aVia.Text := StringReplace(LinStr, '\', sLineBreak, [rfReplaceAll]);
      end;

      SC_S_REIMPRESSAO_VIA_LOJISTA:
      begin
        if (ImagemComprovante2aVia.Count = 0) then
          ImagemComprovante2aVia.Text := StringReplace(LinStr, '\', sLineBreak, [rfReplaceAll]);
      end;

      SC_S_NOME_AUTORIZADORA_CTF,
      SC_S_NOME_VAN_CTF:
      begin
        if (NomeAdministradora = '') then
          NomeAdministradora := LinStr;
      end;

      SC_S_CODIGO_INSTITUICAO_CTF:
        Instituicao := LinStr;

      SC_S_NOME_INSTITUICAO_CTF:
      begin
        if (Instituicao = '') then
          Instituicao := LinStr;
      end;

      SC_S_DATA_TRANSACAO_CTF_DDMMAAAA:
        DataHoraTransacaoLocal := DataHoraTransacaoLocal + Info.AsDate;

      SC_S_HORA_TRANSACAO_CTF_HHMMSS:
        DataHoraTransacaoLocal := DataHoraTransacaoLocal + Info.AsTime;

      SC_S_VALOR_SALDO:;
      SC_S_VALOR_TOTAL_TRANSACAO:
        ValorTotal := Info.AsFloat;

      SC_S_TAXA_JUROS_PLANO:;

      SC_S_NSU_AUTORIZADORA_ALFA:
        NSU := LinStr;

      SC_S_CUPOM_REDUZIDO:
      begin
        if ViaClienteReduzida then
          if (LinStr <> '') then
            ImagemComprovante1aVia.Text := StringReplace(LinStr, '\', sLineBreak, [rfReplaceAll]);
      end;

      SC_S_MSG_DISPLAY_TRANSACAO:
        TextoEspecialOperador := StringReplace(LinStr, '#', sLineBreak, [rfReplaceAll]);

      SC_S_VALOR_DESCONTO:
        Desconto := Info.AsFloat;

      SC_S_TIPO_CAPTURA_PREAUT:;

      SC_S_NOME_BANDEIRA_CARTAO:
        CodigoBandeiraPadrao := LinStr;

      SC_S_CODIGO_AUTORIZACAO:
        CodigoAutorizacaoTransacao := LinStr;

      SC_S_METODO_VERIFICACAO:
      begin
        Digitado := (LinStr = '2');
      end;

      SC_S_NOME_REDE_ADQUIRENTE:
      begin
        NomeAdministradora := LinStr;
        Rede := LinStr;
      end;

      SC_S_CODIGO_VAN:
      begin
        if (CodigoRedeAutorizada = '') then
          CodigoRedeAutorizada := LinStr;
      end;

      SC_S_NOME_TRANSACAO:
        ModalidadePagtoExtenso := LinStr;

      SC_S_CODIGO_TRANSACAO_ORIGINAL:
        NSUTransacaoCancelada := LinStr;

      SC_ES_IDENTIFICADOR_TRANSACAO_PIX:
        EndToEndID := LinStr;

      SC_ES_PSP_PIX:
        CodigoPSP := LinStr;

    else
      ProcessarTipoInterno(Linha);
    end;
  end;

  if (not Sucesso) then
  begin
    CodErro := StrToIntDef(Trailer, 0);
    if (CodErro > 0) and (TextoEspecialOperador = '') then
      TextoEspecialOperador := TraduzirCodigoErro(CodErro);
  end;

  QtdLinhasComprovante := max(ImagemComprovante1aVia.Count, ImagemComprovante2aVia.Count);
  Confirmar := (CodigoAutorizacaoTransacao <> '') or (QtdLinhasComprovante > 0);
end;

procedure TACBrTEFRespAuttar.ProcessarTipoInterno(ALinha: TACBrTEFLinha);
begin
  inherited ProcessarTipoInterno(ALinha);

  if (ALinha.Identificacao = 899) and (ALinha.Sequencia = CTEF_RESP_ORDEM_PAGTO) then
    Finalizacao := ALinha.Informacao.AsString;
end;


{ TACBrTEFAPIClassPayKit }

constructor TACBrTEFAPIClassAuttar.Create(AACBrTEFAPI: TACBrTEFAPIComum);
begin
  inherited;

  fpTEFRespClass := TACBrTEFRespAuttar;

  with GetTEFAuttar do
  begin
    QuandoGravarLog := QuandoGravarLogAPI;
    QuandoExibirMensagem := QuandoExibirMensagemAPI;
    QuandoPerguntarMenu := QuandoPerguntarMenuAPI;
    QuandoPerguntarCampo := QuandoPerguntarCampoAPI;
    QuandoTransacaoEmAndamento := QuandoTransacaoEmAndamentoAPI;
    //QuandoExibirQRCode := QuandoExibirQRCodeAPI;
    //QuandoAvaliarTransacaoPendente := QuandoAvaliarTransacaoPendenteAPI;
  end;
end;

destructor TACBrTEFAPIClassAuttar.Destroy;
begin
  //fTEFPayKitAPI.Free;  // Libera em ACBrTEFPayKitAPI.finalization;
  inherited;
end;

procedure TACBrTEFAPIClassAuttar.Inicializar;
var
  IpStr, PortaStr: String;
  p: Integer;
begin
  if Inicializado then
    Exit;

  with GetTEFAuttar do
  begin
    PathCTFClient := PathDLL;
    PortaPinPad := fpACBrTEFAPI.DadosTerminal.PortaPinPad;
    CodEstabelecimento := fpACBrTEFAPI.DadosTerminal.CodEmpresa;
    CodLoja := fpACBrTEFAPI.DadosTerminal.CodFilial;
    CodPDV := fpACBrTEFAPI.DadosTerminal.CodTerminal;
    EfetuarLog := fpACBrTEFAPI.DadosTerminal.GravarLogTEF;
    ParametrosInicializacao := fpACBrTEFAPI.DadosTerminal.ParamComunicacao;
    Homologacao :=  (fpACBrTEFAPI.DadosTerminal.Ambiente <> ambProducao);

    LoginAut := fpACBrTEFAPI.DadosTerminal.Operador;
    SenhaAut := fpACBrTEFAPI.DadosTerminal.Senha;
    CNPJAut := fpACBrTEFAPI.DadosEstabelecimento.CNPJ;

    MensagemPinPad := fpACBrTEFAPI.DadosAutomacao.MensagemPinPad;
    NomeAplicacao := fpACBrTEFAPI.DadosAutomacao.NomeAplicacao;
    VersaoAplicacao := fpACBrTEFAPI.DadosAutomacao.VersaoAplicacao;

    IpStr := fpACBrTEFAPI.DadosTerminal.EnderecoServidor;
    PortaStr := '';
    p := pos(':', IpStr);
    if (p > 0) then
    begin
      PortaStr := copy(IpStr, p+1, Length(IpStr));
      IpStr := copy(IpStr, 1, p-1);
    end;

    if (IpStr <> '') then
      EnderecoTCP := IpStr;
    if (PortaStr <> '') then
      PortaTCP := StrToIntDef(PortaStr, PortaTCP);

    Inicializar;
  end;

  inherited;
end;

procedure TACBrTEFAPIClassAuttar.DesInicializar;
begin
  GetTEFAuttar.DesInicializar;
  inherited;
end;

procedure TACBrTEFAPIClassAuttar.InterpretarRespostaAPI;
var
  AChave, i: Integer;
  AValue: String;
begin
  fpACBrTEFAPI.UltimaRespostaTEF.Clear;
  fpACBrTEFAPI.UltimaRespostaTEF.ViaClienteReduzida := fpACBrTEFAPI.DadosAutomacao.ImprimeViaClienteReduzida;

  with GetTEFAuttar do
  begin
    for i := 0 to SubCampos.Count-1 do
    begin
      AChave := StrToIntDef(SubCampos.Names[i], -1);
      if (AChave >= 0) then
      begin
        AValue := SubCampos.ValueFromIndex[i];
        fpACBrTEFAPI.UltimaRespostaTEF.Conteudo.GravaInformacao(AChave, 0, AValue);
      end;
    end;
  end;

  fpACBrTEFAPI.UltimaRespostaTEF.Conteudo.GravaInformacao(899, CTEF_RESP_ORDEM_PAGTO, IntToStr(fpACBrTEFAPI.RespostasTEF.Count+1) );
  fpACBrTEFAPI.UltimaRespostaTEF.ConteudoToProperty;
end;

function TACBrTEFAPIClassAuttar.TestarComunicacaoAuttar: Boolean;
var
  s: String;
  Cancelar: Boolean;
begin
  s := LerConfiguracaoCTF;
  Result := (s <> '');
  if Result then
    s := 'OK'
  else
    s := 'Erro';

  QuandoExibirMensagemAPI(Format(ACBrStr(sMsgComunicacaoCTF), [CTFClientFolderName, s]), 1, 0, Cancelar);
end;

procedure TACBrTEFAPIClassAuttar.DadosAdicionaisToStringList(
  const DadosAdicionais: String; SL: TStringList);
var
  s: String;
begin
  s := Trim(DadosAdicionais);
  if (copy(s, 1, 1) = '[') then
    Delete(s, 1, 1);
  if (copy(s, Length(s), 1) = ']') then
    Delete(s, Length(s), 1);

  SL.Clear;
  SL.Text := StringReplace(s, ';', sLineBreak, [rfReplaceAll]);
end;

procedure TACBrTEFAPIClassAuttar.ExibirQRCodeCTF(const APathQRCodePNG: String);
begin
  with TACBrTEFAPI(fpACBrTEFAPI) do
  begin
    if Assigned(QuandoExibirQRCode) then
      QuandoExibirQRCode(APathQRCodePNG);
  end;
end;

function TACBrTEFAPIClassAuttar.GetTEFAuttar: TACBrTEFAuttarAPI;
begin
  Result := ACBrTEFAuttarAPI.GetTEFAuttarAPI;
end;

procedure TACBrTEFAPIClassAuttar.QuandoGravarLogAPI(const ALogLine: String;
  var Tratado: Boolean);
begin
  fpACBrTEFAPI.GravarLog(ALogLine);
  Tratado := True;
end;

procedure TACBrTEFAPIClassAuttar.QuandoExibirMensagemAPI(
  const Mensagem: String; Tela: Integer; MilissegundosExibicao: Integer; out
  Cancelar: Boolean);
var
  telaAPI: TACBrTEFAPITela;
begin
  if (Tela = 1) then
    telaAPI := telaOperador
  else if (Tela = 2) then
    telaAPI := telaCliente
  else
    telaAPI := telaTodas;

  with TACBrTEFAPI(fpACBrTEFAPI) do
  begin
    QuandoExibirMensagem( Mensagem, telaAPI, MilissegundosExibicao);

    Cancelar := False;
    if Assigned( QuandoEsperarOperacao ) then
      QuandoEsperarOperacao( opapiFluxoAPI, Cancelar );
  end;
end;

procedure TACBrTEFAPIClassAuttar.QuandoPerguntarMenuAPI(const Titulo: String;
  Opcoes: TStringList; out ItemSelecionado: Integer);
var
  i: Integer;
begin
  i := 0;
  TACBrTEFAPI(fpACBrTEFAPI).QuandoPerguntarMenu( Titulo, Opcoes, i);
  ItemSelecionado := i;
end;

procedure TACBrTEFAPIClassAuttar.QuandoPerguntarCampoAPI(const Titulo: String;
  TipoCampo, TamMaximo: Integer; ZerosAEsquerda: Boolean; out Resposta: String;
  out Cancelar: Boolean);
var
  def: TACBrTEFAPIDefinicaoCampo;
  Validado: Boolean;
begin
  def.TituloPergunta := Titulo;
  def.TipoCampo := TipoCampo;
  def.TamanhoMaximo := TamMaximo;
  def.ValorInicial := '';
  def.MascaraDeCaptura := '';
  def.TamanhoMinimo := 0;
  def.ValorMinimo := 0;
  def.ValorMaximo := 0;
  def.TipoDeEntrada := tedAlfaNum;
  def.OcultarDadosDigitados := False;
  def.ValidacaoDado := valdNenhuma;
  def.MsgErroDeValidacao := '';
  def.MsgErroDadoMaior := '';
  def.MsgErroDadoMenor := '';
  def.MsgConfirmacaoDuplaDigitacao := '';
  def.TipoEntradaCodigoBarras := tbQualquer;

  Case TipoCampo of
    SC_ES_VALOR_TRANSACAO,
    SC_ES_NUMERO_PARCELAS,
    SC_ES_DATA_VENCTO_CARTAO_MMAA,
    SC_E_NSU_CTF_ORIGINAL,
    SC_E_NUMERO_CHEQUE,
    SC_E_DATA_CHEQUE_DDMMAA,
    SC_E_NUMERO_BANCO,
    SC_E_NUMERO_AGENCIA,
    SC_E_TIPO_DOCUMENTO,
    SC_E_DOCUMENTO_CLIENTE,
    SC_E_NUMERO_PRACA,
    SC_E_TAXA_SERVICO,
    SC_E_VALOR_ENTRADA,
    SC_E_TIPO_GARANTIA_PREDATADO,
    SC_E_VALOR_SAQUE,
    SC_E_TAXA_EMBARQUE,
    SC_ES_DATA_AGENDAMENTO_PREDATADO,
    SC_E_DATA_PARCELA_DEBITO_CDC,
    SC_E_DATA_VENCTO_CORBAN_DDMMAA,
    SC_E_VALOR_DESCONTO,
    SC_ES_VALOR_ACRESCIMO,
    SC_ES_VALOR_DEVIDO_DOCUMENTO,
    SC_ES_VALOR_PARCELA_PLANO,
    SC_ES_DATA_TRANSACAO_ORIGINAL,
    SC_E_VALOR_CANCELAMENTO,
    SC_ES_PRODUTO_CONVENIO_FARMACIA,
    SC_ES_FORMA_PAGTO_FARMACIA,
    SC_E_NUMERO_CICLOS,
    SC_E_DATA_EMISSAO_CARTAO_MMAA,
    SC_E_COD_PARCELE_MAIS,
    SC_E_NUMERO_ITEM,
    SC_E_FONE_FIXO,
    SC_E_FONE_MOVEL,
    SC_E_CNPJ,
    SC_E_SERVICO_COMBUSTIVEL,
    SC_E_ULTIMOS_4,
    SC_E_BAIXA_TECNICA,
    SC_E_DDTTTTTTTT,
    SC_E_NUMERO_CONTRACORRENTE,
    SC_E_CPF,
    SC_E_DDD,
    SC_E_TELEFONE,
    SC_E_VALOR_PARCELA,
    SC_E_DATA_ABERTURA_CONTA_DDMM,
    SC_E_FLAG_SALDO_VOUCHER,
    SC_E_DECISAO_OPERACAO,
    SC_E_CODIGO_BARRAS,
    SC_E_BARRAS_TITULO_BLOCO1,
    SC_E_BARRAS_TITULO_BLOCO2,
    SC_E_BARRAS_TITULO_BLOCO3,
    SC_E_BARRAS_TITULO_BLOCO4,
    SC_E_BARRAS_TITULO_BLOCO5,
    SC_E_BARRAS_CONVENIO_BLOCO1,
    SC_E_BARRAS_CONVENIO_BLOCO2,
    SC_E_BARRAS_CONVENIO_BLOCO3,
    SC_E_BARRAS_CONVENIO_BLOCO4,
    SC_ES_NUMERO_CARTAO,
    SC_E_FLAG_TRANSACAO_PENDENTE,
    SC_E_VALOR_RECARGA_FONE,
    SC_E_NUM_PREMIOS,
    SC_ES_IDENTIFICADOR_CONSULTA,
    SC_E_FLAG_CONSULTA_INTEGRACAO,
    SC_E_CODIGO_CLIENTE,
    SC_E_DATA_NASCIMENTO_CLIENTE,
    SC_E_CELULAR,
    SC_E_DDD_CELULAR,
    SC_E_ID_WALLET,
    SC_E_MCC,
    SC_E_DDD_CELULAR2,
    SC_E_BOMBA_COMBUSTIVEL,
    SC_E_MEIO_PAGTO_FATURA,
    SC_E_FORMA_IDENTIFICACAO_FATURA,
    SC_E_TIPO_AUTORIZADORA,
    SC_E_CNPJ_TERMINAL,
    SC_E_MEIO_PAGTO:
      def.TipoDeEntrada := tedNumerico;
  end;

  Validado := True;
  Cancelar := False;
  Resposta := '';
  TACBrTEFAPI(fpACBrTEFAPI).QuandoPerguntarCampo(def, Resposta, Validado, Cancelar);
end;

procedure TACBrTEFAPIClassAuttar.QuandoTransacaoEmAndamentoAPI(out Cancelar: Boolean);
begin
  Cancelar := False;
  with TACBrTEFAPI(fpACBrTEFAPI) do
  begin
    if Assigned( QuandoEsperarOperacao ) then
      QuandoEsperarOperacao(opapiFluxoAPI, Cancelar);
  end;
end;

function TACBrTEFAPIClassAuttar.EfetuarAdministrativa(CodOperacaoAdm: TACBrTEFOperacao): Boolean;
var
  Op, ItemSelecionado: Integer;
  OpcoesMenu: TStringList;
begin
  Result := False;
  GetTEFAuttar.SubCampos.Clear;

  // Se for tefopAdministrativo sem especificar, exibe menu de opções
  if (CodOperacaoAdm = tefopAdministrativo) then
  begin
    OpcoesMenu := TStringList.Create;
    try
      // Adiciona as opções administrativas disponíveis
      OpcoesMenu.Add(ACBrStr('1  Cancelamento Genérico'));
      OpcoesMenu.Add(ACBrStr('2  Cancelamento Crédito Digitado'));
      OpcoesMenu.Add(ACBrStr('3  Reimpressão Último Comprovante'));
      OpcoesMenu.Add(ACBrStr('4  Reimpressão Específico'));
      OpcoesMenu.Add(ACBrStr('5  Recarga de Celular/Pré-Pago'));
      OpcoesMenu.Add(ACBrStr('6  Pré-autorização Crédito'));
      OpcoesMenu.Add(ACBrStr('7  Consulta Saldo Crédito'));
      OpcoesMenu.Add(ACBrStr('8  Pagamento de Título'));
      OpcoesMenu.Add(ACBrStr('9  Devolução Pix'));
      OpcoesMenu.Add(ACBrStr('10 Carga de Tabelas'));
      OpcoesMenu.Add(ACBrStr('11 Teste de Comunicação'));

      ItemSelecionado := -1;
      QuandoPerguntarMenuAPI(ACBrStr('Selecione uma opção:'), OpcoesMenu, ItemSelecionado);

      // Converte a seleção do menu para a operação correspondente
      case ItemSelecionado of
        0: Op := OP_CANCELAMENTO;
        1: Op := OP_CANCELAMENTO_CREDITO_DIGITADO;
        2: Op := OP_REIMPRESSAO;
        3: Op := OP_REIMPRESSAO_ESPECIFICA;
        4: Op := OP_RECARGA_PRE_PAGO;
        5: Op := OP_PRE_AUTORIZACAO_CREDITO;
        6: Op := OP_CONSULTA_SALDO_CREDITO;
        7: Op := OP_PAGAMENTO_TITULO;
        8: Op := OP_DEVOLUCAO_PIX;
        9: Op := OP_CARGA_TABELAS;
        10: Op := OP_CONSULTA_CONFIGURACAO;
      else
        Exit;
      end;
    finally
      OpcoesMenu.Free;
    end;
  end
  else
  begin
    // Para outras operações, mapeia diretamente
    case CodOperacaoAdm of
      tefopPagamento:
        Op := OP_CREDITO_VISTA;
      tefopTesteComunicacao:
        Op := OP_CONSULTA_CONFIGURACAO; // Não há teste de Comunicação...
      tefopFechamento:
        Op := OP_FECHAMENTO; // Não há Início Dia...
      tefopCancelamento:
        Op := OP_CANCELAMENTO;
      tefopReimpressao:
        Op := OP_REIMPRESSAO;
      tefopPrePago:
        Op := OP_RECARGA_PRE_PAGO;
      tefopPreAutorizacao:
        Op := OP_PRE_AUTORIZACAO_CREDITO;
      tefopConsultaSaldo:
        Op := OP_CONSULTA_SALDO_CREDITO;
      tefopConsultaCheque:
        Op := OP_CONSULTA_CHEQUE;
      tefopPagamentoConta:
        Op := OP_PAGAMENTO_TITULO;
    else
      fpACBrTEFAPI.DoException(Format(ACBrStr(sACBrTEFAPIAdministrativaNaoSuportada),
        [GetEnumName(TypeInfo(TACBrTEFOperacao), integer(CodOperacaoAdm) ), ClassName] ));
    end;
  end;

  if (OP = OP_CONSULTA_CONFIGURACAO) then
    Result := TestarComunicacaoAuttar
  else
    Result := EfetuarAdministrativa(IntToStr(Op));
end;

function TACBrTEFAPIClassAuttar.EfetuarAdministrativa(const CodOperacaoAdm: string): Boolean;
var
  Op: Integer;
begin
  Result := False;
  Op := StrToIntDef(CodOperacaoAdm, -1);
  if (Op < 0) then
    fpACBrTEFAPI.DoException(Format(ACBrStr(sACBrTEFAPIAdministrativaNaoSuportada),
      [CodOperacaoAdm, ClassName] ));

  with GetTEFAuttar do
  begin
    SubCampos.Clear;
    ExecutarTransacaoCTF(Op);
    Result := True;
  end;
end;

function TACBrTEFAPIClassAuttar.CancelarTransacao(const NSU,
  CodigoAutorizacaoTransacao: string; DataHoraTransacao: TDateTime;
  Valor: Double; const CodigoFinalizacao: string; const Rede: string): Boolean;
begin
  // TODO
end;

function TACBrTEFAPIClassAuttar.EfetuarPagamento(ValorPagto: Currency;
  Modalidade: TACBrTEFModalidadePagamento; CartoesAceitos: TACBrTEFTiposCartao;
  Financiamento: TACBrTEFModalidadeFinanciamento; Parcelas: Byte;
  DataPreDatado: TDateTime; DadosAdicionais: String): Boolean;
var
  Operacao, NumTransacao: Integer;
  NumDocto, PathQrCodePNG, NsuCTF: String;
  DataFiscal: TDateTime;
begin
  VerificarIdentificadorVendaInformado;
  if (ValorPagto <= 0) then
    fpACBrTEFAPI.DoException(ACBrStr(sACBrTEFAPIValorPagamentoInvalidoException));

  with GetTEFAuttar do
  begin
    SubCampos.Clear;
    DadosAdicionaisToStringList(DadosAdicionais, SubCampos);

    Operacao := StrToIntDef(Trim(SubCampos.ValueInfo[SC_S_CODIGO_TRANSACAO_CTF]), OP_TRANSACAO_GENERICA);
    NumDocto := Trim(fpACBrTEFAPI.RespostasTEF.IdentificadorTransacao);
    DataFiscal := fpACBrTEFAPI.RespostasTEF.DataHoraIdentificador;
    if fpACBrTEFAPI.ConfirmarTransacaoAutomaticamente then
      NumTransacao := 1
    else
      NumTransacao := fpACBrTEFAPI.RespostasTEF.Count+1;

    case Modalidade of
      tefmpCartao:
        begin
          if (teftcCredito in CartoesAceitos) then
          begin
            Operacao := OP_CREDITO_GENERICO;
            if (Financiamento = tefmfAVista) then
              Operacao := OP_CREDITO_VISTA
            else if (Financiamento in [tefmfParceladoEmissor, tefmfCreditoEmissor]) then
              Operacao := OP_CREDITO_PARCELADO_EMISSOR
            else if (Financiamento = tefmfParceladoEstabelecimento) then
              Operacao := OP_CREDITO_PARCELADO_LOJA
            else if (Financiamento = tefmfPredatado) then
              Operacao := OP_CREDITO_PARCELADO_LOJA;
          end

          else if (teftcDebito in CartoesAceitos) then
          begin
            Operacao := OP_DEBITO_GENERICO;
            if (Financiamento = tefmfAVista) then
              Operacao := OP_DEBITO
            else if (Financiamento in [tefmfParceladoEmissor, tefmfParceladoEstabelecimento]) then
              Operacao := OP_DEBITO_PARCELADO
            else if (Financiamento = tefmfPredatado) then
              Operacao := OP_DEBITO_PREDATADO;
          end

          else if (teftcPrivateLabel in CartoesAceitos) then
            Operacao := OP_CREDITO_PRIVATE_LABEL
        end;

      tefmpCheque:
        Operacao := OP_CONSULTA_CHEQUE;

      tefmpCarteiraVirtual:
      begin
        Operacao := OP_PAGAMENTO_PIX;
        if (TACBrTEFAPI(fpACBrTEFAPI).ExibicaoQRCode = qrapiExibirAplicacao) then
          SubCampos.ValueInfo[SC_E_FLAG_CONSULTA_INTEGRACAO] := '1';
      end
    end;

    if (Parcelas <> 0) then
      SubCampos.ValueInfo[SC_ES_NUMERO_PARCELAS] := Format('%.2d',[Parcelas]);

    if (DataPreDatado <> 0) then
      SubCampos.ValueInfo[SC_E_DATA_PRE_DATADA] := FormatDateTime('DDMMYYYY', DataPreDatado);

    ExecutarTransacaoCTF(Operacao, ValorPagto,  NumDocto, DataFiscal, NumTransacao);
    Result := True;

    if (TACBrTEFAPI(fpACBrTEFAPI).ExibicaoQRCode = qrapiExibirAplicacao) then
    begin
      PathQrCodePNG := Trim(SubCampos.ValueInfo[SC_S_DADOS_RETORNADOS]);
      NsuCTF := Trim(SubCampos.ValueInfo[SC_ES_IDENTIFICADOR_CONSULTA]);
      if (PathQrCodePNG <> '') and (NsuCTF <> '') and (SubCampos.ValueInfo[SC_S_CODIGO_RETORNO] = '00') then
      begin
        ExibirQRCodeCTF(PathQrCodePNG);

        SubCampos.Clear;
        SubCampos.ValueInfo[SC_ES_IDENTIFICADOR_CONSULTA] := NsuCTF;
        ExecutarTransacaoCTF(Operacao, ValorPagto,  NumDocto, DataFiscal, NumTransacao);

        ExibirQRCodeCTF('');  // Limpa o QRCode
      end;
    end;
  end;
end;

function TACBrTEFAPIClassAuttar.ConsultarPIXAutorizado(const NsuCTF: String): Boolean;
var
  CodResposta: Integer;
  MsgDisplay: String;
  Cancelar: Boolean;
begin
  with GetTEFAuttar do
  begin
    SubCampos.Clear;
    SubCampos.ValueInfo[SC_E_NSU_CTF_ORIGINAL] := PadLeft(Trim(NsuCTF), 6, '0');
    ExecutarTransacaoCTF(OP_CONSULTA_PIX);

    CodResposta := StrToIntDef(Trim(SubCampos.ValueInfo[SC_S_CODIGO_RESPOSTA]), -1);
    MsgDisplay := SubCampos.ValueInfo[SC_S_MSG_DISPLAY_TRANSACAO];
    if (MsgDisplay <> '') then
      QuandoExibirMensagemAPI(MsgDisplay, 3, 0, Cancelar);

    Result := (CodResposta = 0);
  end;
end;

function TACBrTEFAPIClassAuttar.DevolverPIX(const NsuCTF: String;
  AData: TDateTime): Boolean;
var
  CodResposta: Integer;
  MsgDisplay: String;
  Cancelar: Boolean;
begin
  with GetTEFAuttar do
  begin
    SubCampos.Clear;
    SubCampos.ValueInfo[SC_E_NSU_CTF_ORIGINAL] := PadLeft(Trim(NsuCTF), 6, '0');
    SubCampos.ValueInfo[SC_ES_DATA_TRANSACAO_ORIGINAL] := FormatDateTime('DDMMYYYY', AData);
    ExecutarTransacaoCTF(OP_DEVOLUCAO_PIX);

    CodResposta := StrToIntDef(Trim(SubCampos.ValueInfo[SC_S_CODIGO_RESPOSTA]), -1);
    MsgDisplay := SubCampos.ValueInfo[SC_S_MSG_DISPLAY_TRANSACAO];
    if (MsgDisplay <> '') then
      QuandoExibirMensagemAPI(MsgDisplay, 3, 0, Cancelar);

    Result := (CodResposta = 0);
  end;
end;

procedure TACBrTEFAPIClassAuttar.FinalizarTransacao(const Rede, NSU,
  CodigoFinalizacao: String; AStatus: TACBrTEFStatusTransacao);
var
  Confirma: Boolean;
  NumTransacao: Integer;
  DataFiscal: TDateTime;
begin
  Confirma := (AStatus in [tefstsSucessoAutomatico, tefstsSucessoManual]);
  NumTransacao := 0;
  if not fpACBrTEFAPI.ConfirmarTransacaoAutomaticamente then
  begin
    NumTransacao := fpACBrTEFAPI.RespostasTEF.AcharTransacao(Rede, NSU, CodigoFinalizacao);
    if (NumTransacao < 0) then
      NumTransacao := 0;
  end;

  if (NumTransacao < fpACBrTEFAPI.RespostasTEF.Count) then
    DataFiscal := fpACBrTEFAPI.RespostasTEF[NumTransacao].DataHoraTransacaoLocal;

  with GetTEFAuttar do
  begin
    FinalizarTransacaoCTF(Confirma, NumTransacao+1, DataFiscal);
  end;
end;

procedure TACBrTEFAPIClassAuttar.ResolverTransacaoPendente(AStatus: TACBrTEFStatusTransacao);
begin
  FinalizarTransacao( fpACBrTEFAPI.UltimaRespostaTEF.Rede,
                      fpACBrTEFAPI.UltimaRespostaTEF.NSU,
                      fpACBrTEFAPI.UltimaRespostaTEF.Finalizacao,
                      AStatus );
end;

procedure TACBrTEFAPIClassAuttar.AbortarTransacaoEmAndamento;
begin
  GetTEFAuttar.AbortarTransacao;
end;

function TACBrTEFAPIClassAuttar.ObterDadoPinPad(
  TipoDado: TACBrTEFAPIDadoPinPad; TimeOut: Integer; MinLen: SmallInt;
  MaxLen: SmallInt): String;
var
  Dados: AnsiString;
  TipoCaptura: Integer;
begin
  TipoCaptura := Integer(TipoDado)+1;
  if (MinLen = 0) and (MaxLen = 0) then
    CalcularTamanhosCampoDadoPinPad(TipoDado, MinLen, MaxLen);

  with GetTEFAuttar do
  begin
    SubCampos.Clear;
    SubCampos.ValueInfo[SC_E_TIPO_DADO_PINPAD] := Format('%.2d',[TipoCaptura]);
    SubCampos.ValueInfo[SC_E_CONFIRMAR_DADO_PINPAD] := '0';
    SubCampos.ValueInfo[SC_E_TAM_MIN_DADO_PINPAD] := Format('%.2d',[MinLen]);
    SubCampos.ValueInfo[SC_E_TAM_MAX_DADO_PINPAD] := Format('%.2d',[MaxLen]);

    ExecutarTransacaoCTF(OP_CAPTURA_DADO_PINPAD);
    Result := Trim(SubCampos.ValueInfo[SC_S_DADOS_RETORNADOS]);
  end;
end;

function TACBrTEFAPIClassAuttar.LerConfiguracaoCTF: String;
var
  TipoCaptura: Integer;
begin
  with GetTEFAuttar do
  begin
    SubCampos.Clear;
    ExecutarTransacaoCTF(OP_CONSULTA_CONFIGURACAO);
    Result := Trim(SubCampos.ValueInfo[SC_S_DADOS_RETORNADOS]);
  end;
end;

end.
