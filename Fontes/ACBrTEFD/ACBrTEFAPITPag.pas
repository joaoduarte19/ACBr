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

unit ACBrTEFAPITPag;

interface

uses
  Classes, SysUtils,
  ACBrBase,
  ACBrTEFComum, ACBrTEFAPI, ACBrTEFAPIComum, ACBrTEFTPagAPI;

resourcestring
  sMsgInformeNSU = 'Informe o NSU da Transação';
  sMsgInfoParcelas = 'Número de Parcelas';
  sMsgErroMinMax = 'Valor Mínimo: %d, Máximo: %d';

type

  { TACBrTEFRespTPag }

  TACBrTEFRespTPag = class( TACBrTEFResp )
  public
    procedure ConteudoToProperty; override;
    procedure SetStrings(AStringList: TStrings);
  end;


  { TACBrTEFAPIClassTPag }

  TACBrTEFAPIClassTPag = class(TACBrTEFAPIClass)
  private
    function GetTEFTPagAPI: TPagAPI;
    procedure QuandoGravarLogAPI(const ALogLine: String);
    procedure QuandoTransacaoEmAndamentoAPI(out Cancelar: Boolean);
    procedure QuandoExibirMensagemAPI(const Mensagem: String);
    procedure QuandoPerguntarMenuAPI(const Titulo: String; Opcoes: TStringList;
      var ItemSelecionado: LongInt);
    procedure QuandoPerguntarCampoAPI(
      const Titulo: String; const Mensagem: String;
      RequestOption: TPagRequestOptions;
      InputMode: TPagInputMode;
      InputConfig: TPagInputModeConfig;
      out Resposta: String; out Cancelar: Boolean);
    procedure DoException(const AErrorMsg: String);

  protected
    procedure InterpretarRespostaAPI; override;
    function PerguntarParcelas: Byte;

  public
    constructor Create(AACBrTEFAPI: TACBrTEFAPIComum);
    destructor Destroy; override;

    procedure Inicializar; override;
    procedure DesInicializar; override;
    procedure Autenticar; override;

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
    function CancelarTransacaoTPag(): Boolean;

    procedure FinalizarTransacao(
      const Rede, NSU, CodigoFinalizacao: String;
      AStatus: TACBrTEFStatusTransacao = tefstsSucessoAutomatico); override;

    procedure ResolverTransacaoPendente(AStatus: TACBrTEFStatusTransacao = tefstsSucessoManual); override;

    procedure AbortarTransacaoEmAndamento; override;

    procedure ObterListaDeTransacoes(ListaTransacoes: TACBrTEFRespostas;
      Inicio: TDateTime = 0; Fim: TDateTime = 0;
      TransactionStatusSet: TPagTransactionStatusSet = [];
      ReadCardTypeSet: TPagReadCardTypeSet = []);

    property TEFTPagAPI: TPagAPI read GetTEFTPagAPI;
  end;

implementation

uses
  TypInfo, Math, StrUtils,
  ACBrUtil.DateTime,
  ACBrUtil.Strings;

{ TACBrTEFRespTPag }

procedure TACBrTEFRespTPag.ConteudoToProperty;
var
  LinChave, s: String;
  Linha: TACBrTEFLinha;
  i, v: Integer;
begin
  ImagemComprovante1aVia.Clear;
  ImagemComprovante2aVia.Clear;
  Debito := False;
  Credito := False;
  Digitado := False;
  TaxaServico := 0;
  DataHoraTransacaoCancelada := 0;
  DataHoraTransacaoLocal := 0;

  for i := 0 to Conteudo.Count - 1 do
  begin
    Linha := Conteudo.Linha[i];
    LinChave := Linha.Chave;

    if (LinChave = 'msgError') then
      TextoEspecialOperador := Linha.Informacao.AsString
    else if (LinChave = 'msgSuccess') then
    begin
      TextoEspecialOperador := Linha.Informacao.AsString;
      TextoEspecialCliente := TextoEspecialOperador;
    end;
    if (LinChave = 'nsuRequest') then
      Trailer := Linha.Informacao.AsString
    else if (LinChave = 'amount') then
      ValorTotal := Linha.Informacao.AsInt64/100
    else if (LinChave = 'transactionType') then
    begin
      ModalidadePagto := Linha.Informacao.AsString;
      v := StrToIntDef(ModalidadePagto, -1);
      ModalidadePagtoDescrita := GetEnumName(TypeInfo(TPagTRANSACTION_TYPE), v);
      case TPagTRANSACTION_TYPE(v) of
        TRANSACTION_TYPE_DEBIT:   Debito := True;
        TRANSACTION_TYPE_CREDIT:  Credito := True;
        TRANSACTION_TYPE_VOUCHER: Voucher := True;
      end;
    end
    else if (LinChave = 'installments') then
      QtdParcelas := Linha.Informacao.AsInteger
    else if (LinChave = 'transactionStatus') then
    begin
      StatusTransacao := Linha.Informacao.AsString;
      v := StrToIntDef(StatusTransacao, -1);
      Sucesso := (v = Integer(TRANSACTION_STATUS_CONFIRMED)) or (v = Integer(TRANSACTION_STATUS_CANCELLED));
    end
    else if (LinChave = 'date') then
      DataHoraTransacaoHost := Linha.Informacao.AsTimeStampSQL
    else if (LinChave = 'nsuResponse') then
    begin
      NSU_TEF := Linha.Informacao.AsString;
      Finalizacao := NSU_TEF;
    end
    //else if (LinChave = 'reasonUndo') then
    //  ModalidadePagtoDescrita := Linha.Informacao.AsString;
    else if (LinChave = 'customerReceipt') then
    begin
      s := StringReplace(Linha.Informacao.AsString, '@', sLineBreak, [rfReplaceAll]);
      if (copy(s,1,11) = 'REIMPRESSAO') then
        ImagemComprovante1aVia.Text := s
      else
        ImagemComprovante1aVia.Text := 'VIA CLIENTE' + sLineBreak + s;
    end
    else if (LinChave = 'establishmentReceipt') then
    begin
      s := StringReplace(Linha.Informacao.AsString, '@', sLineBreak, [rfReplaceAll]);
      ImagemComprovante2aVia.Text := 'VIA ESTABELECIMENTO' + sLineBreak + s;
    end
    else if (LinChave = 'brand') then
      Rede := Linha.Informacao.AsString
    else if (LinChave = 'authentication') then
      Autenticacao := Linha.Informacao.AsString
    else if (LinChave = 'entryMode') then
      TipoTransacao := Linha.Informacao.AsInteger
    else if (LinChave = 'merchantCode') then
      DocumentoVinculado := Linha.Informacao.AsString
    else if (LinChave = 'nsuAcquirer') then
      NSU := Linha.Informacao.AsString
    else if (LinChave = 'authAcquirer') then
      CodigoAutorizacaoTransacao := Linha.Informacao.AsString
    else if (LinChave = 'panMasked') then
      PAN := Linha.Informacao.AsString
    else
      ProcessarTipoInterno(Linha);
  end;

  QtdLinhasComprovante := max(ImagemComprovante1aVia.Count, ImagemComprovante2aVia.Count);
  Confirmar := Confirmar or (QtdLinhasComprovante > 0);
  Sucesso := Sucesso or (QtdLinhasComprovante > 0);
end;

procedure TACBrTEFRespTPag.SetStrings(AStringList: TStrings);
var
  i: Integer;
  AChave, AValue: String;
begin
  Clear;

  for i := 0 to AStringList.Count-1 do
  begin
    AChave := AStringList.Names[i];
    AValue := AStringList.ValueFromIndex[i];
    Conteudo.GravaInformacao(AChave, AValue);
  end;

  ConteudoToProperty;
end;

{ TACBrTEFAPIClassTPag }

constructor TACBrTEFAPIClassTPag.Create(AACBrTEFAPI: TACBrTEFAPIComum);
begin
  inherited;

  fpTEFRespClass := TACBrTEFRespTPag;

  with GetTEFTPagAPI do
  begin
    OnGravarLog := QuandoGravarLogAPI;
    OnExibeMensagem := QuandoExibirMensagemAPI;
    OnTransacaoEmAndamento := QuandoTransacaoEmAndamentoAPI;
    QuandoPerguntarMenu := QuandoPerguntarMenuAPI;
    QuandoPerguntarCampo := QuandoPerguntarCampoAPI;
  end;
end;

destructor TACBrTEFAPIClassTPag.Destroy;
begin
  //fTEFTPagAPI.Free;  // Libera em ACBrTEFTPagAPI.finalization;
  inherited Destroy;
end;

function TACBrTEFAPIClassTPag.GetTEFTPagAPI: TPagAPI;
begin
  Result := ACBrTEFTPagAPI.GetTEFTPagAPI;
end;

procedure TACBrTEFAPIClassTPag.Inicializar;
begin
  if Inicializado then
    Exit;

  with GetTEFTPagAPI do
  begin
    PathLib := PathDLL;
    Identification := fpACBrTEFAPI.DadosEstabelecimento.CNPJ;
    Inicializar;
  end;

  inherited;
end;

procedure TACBrTEFAPIClassTPag.DesInicializar;
begin
  GetTEFTPagAPI.DesInicializar;
  inherited;
end;

procedure TACBrTEFAPIClassTPag.Autenticar;
begin
  GetTEFTPagAPI.Conectar;
end;

procedure TACBrTEFAPIClassTPag.QuandoGravarLogAPI(const ALogLine: String);
begin
  fpACBrTEFAPI.GravarLog(ALogLine);
end;

procedure TACBrTEFAPIClassTPag.QuandoTransacaoEmAndamentoAPI(out
  Cancelar: Boolean);
begin
  Cancelar := False;
  TACBrTEFAPI(fpACBrTEFAPI).QuandoEsperarOperacao(opapiPinPad, Cancelar);
end;

procedure TACBrTEFAPIClassTPag.QuandoExibirMensagemAPI(const Mensagem: String);
begin
  TACBrTEFAPI(fpACBrTEFAPI).QuandoExibirMensagem( Mensagem, telaTodas, -1);
end;

procedure TACBrTEFAPIClassTPag.QuandoPerguntarMenuAPI(const Titulo: String;
  Opcoes: TStringList; var ItemSelecionado: LongInt);
var
  i: Integer;
begin
  i := ItemSelecionado;
  TACBrTEFAPI(fpACBrTEFAPI).QuandoPerguntarMenu( Titulo, Opcoes, i);
  ItemSelecionado := i;
end;

procedure TACBrTEFAPIClassTPag.QuandoPerguntarCampoAPI(const Titulo: String;
  const Mensagem: String; RequestOption: TPagRequestOptions;
  InputMode: TPagInputMode; InputConfig: TPagInputModeConfig; out
  Resposta: String; out Cancelar: Boolean);
var
  def: TACBrTEFAPIDefinicaoCampo;
  Validado: Boolean;
  i: Integer;
begin
  if (Mensagem <> '') then
    def.TituloPergunta := Titulo + sLineBreak + Mensagem
  else
    def.TituloPergunta := Titulo;

  def.TipoCampo := Integer(RequestOption);
  def.TamanhoMinimo := InputConfig.minLength;
  def.TamanhoMaximo := InputConfig.maxLength;
  def.ValorMinimo := InputConfig.minValue;
  def.ValorMaximo := InputConfig.maxValue;
  def.MsgErroDeValidacao := '';
  def.MsgErroDadoMaior := '';
  def.MsgErroDadoMenor := '';
  def.MsgConfirmacaoDuplaDigitacao := '';
  def.ValorInicial := '';
  def.MascaraDeCaptura := '';
  def.OcultarDadosDigitados := InputConfig.maskInput;

  def.TipoEntradaCodigoBarras := tbQualquer;
  case InputMode of
    INPUT_MODE_NUMERIC: def.TipoDeEntrada := tedNumerico;
    INPUT_MODE_ALPHANUMERIC: def.TipoDeEntrada := tedAlfaNum;
  else
    def.TipoDeEntrada := tedTodos;
  end;

  if (RequestOption = REQUEST_OPTIONS_INSTALLMENTS) then
    def.ValidacaoDado := valdQuantidadeParcelas
  else if not InputConfig.allowZero then
    def.ValidacaoDado := valdNaoVazio
  else
    def.ValidacaoDado := valdNenhuma;

  repeat
    Validado := False;
    Cancelar := False;
    Resposta := '';
    TACBrTEFAPI(fpACBrTEFAPI).QuandoPerguntarCampo(def, Resposta, Validado, Cancelar);

    if (not Validado) and (not Cancelar) then
    begin
      if (InputMode = INPUT_MODE_NUMERIC) then
      begin
        i := StrToIntDef(Resposta, -1);
        Validado := (i >= def.ValorMinimo) and ((def.ValorMaximo = 0) or (i <= def.ValorMaximo));
        if not Validado then
           TACBrTEFAPI(fpACBrTEFAPI).QuandoExibirMensagem(Format(ACBrStr(sMsgErroMinMax), [def.ValorMinimo, def.ValorMaximo]), telaTodas, 5000);
      end
      else
        Validado := True;
    end;
  until Validado or Cancelar;

end;

procedure TACBrTEFAPIClassTPag.DoException(const AErrorMsg: String);
begin
  fpACBrTEFAPI.DoException(AErrorMsg);
end;

procedure TACBrTEFAPIClassTPag.InterpretarRespostaAPI;
begin
  TACBrTEFRespTPag( fpACBrTEFAPI.UltimaRespostaTEF ).SetStrings(GetTEFTPagAPI.DadosDaTransacao);
end;

function TACBrTEFAPIClassTPag.PerguntarParcelas: Byte;
var
  Resp: String;
  Cancelar: Boolean;
  ic: TPagInputModeConfig;
begin
  Resp := '';
  Cancelar := False;
  ic.minLength := 1; ic.maxLength := 2;
  ic.minValue := 2; ic.maxValue := 99;
  ic.allowZero := False; ic.maskInput := False;

  QuandoPerguntarCampoAPI(ACBrStr(sMsgInfoParcelas), '',
    TPagRequestOptions(-1),
    INPUT_MODE_NUMERIC,
    ic, Resp, Cancelar);

  if Cancelar then
    Result := 0
  else
    Result := StrToIntDef(Resp, 0);
end;

function TACBrTEFAPIClassTPag.EfetuarPagamento(ValorPagto: Currency;
  Modalidade: TACBrTEFModalidadePagamento; CartoesAceitos: TACBrTEFTiposCartao;
  Financiamento: TACBrTEFModalidadeFinanciamento; Parcelas: Byte;
  DataPreDatado: TDateTime; DadosAdicionais: String): Boolean;
var
  Params: TPagTransactionParams;
  ret: LongInt;
begin
  Params.amount := Trunc(ValorPagto * 100);
  if not (Modalidade in [tefmpNaoDefinido, tefmpCartao, tefmpCarteiraVirtual]) then
    fpACBrTEFAPI.DoException(Format(ACBrStr(sACBrTEFAPICapturaNaoSuportada),
      [GetEnumName(TypeInfo(TACBrTEFModalidadePagamento), integer(Modalidade) ), ClassName] ));

  Params.cardType := Cardinal(CARD_TYPE_NONE);

  if Modalidade = tefmpCarteiraVirtual then
    Params.transactionType := Cardinal(TRANSACTION_TYPE_PIX)
  else
  begin
    if (teftcCredito in CartoesAceitos) then
      Params.transactionType := Cardinal(TRANSACTION_TYPE_CREDIT)
    else if (teftcDebito in CartoesAceitos) then
      Params.transactionType := Cardinal(TRANSACTION_TYPE_DEBIT)
    else if (teftcVoucher in CartoesAceitos) then
      Params.transactionType := Cardinal(TRANSACTION_TYPE_VOUCHER)
    else
      Params.transactionType := Cardinal(TRANSACTION_TYPE_NONE);
  end;

  if (Financiamento > tefmfAVista) then
  begin
    Params.creditType := Cardinal(CREDIT_TYPE_INSTALLMENT);

    if (Parcelas <= 1) then
    begin
      Parcelas := PerguntarParcelas;
      if (Parcelas = 0) then
        Exit;
    end;
  end
  else
    Params.creditType := Cardinal(CREDIT_TYPE_NO_INSTALLMENT);

  Params.isTyped := 0;
  Params.installment := Parcelas;

  ret := GetTEFTPagAPI.Transacao(Params);
  if (ret = 0) then
    GetTEFTPagAPI.ObterUltimaTransacao(LAST_TRANSACTION_TYPE_TRANSACTION, ret);

  Result := (ret = 0);
end;

function TACBrTEFAPIClassTPag.EfetuarAdministrativa(
  CodOperacaoAdm: TACBrTEFOperacao): Boolean;
var
  sl: TStringList;
  ItemSel: Integer;
  ret: LongInt;
  s: String;
begin
  GetTEFTPagAPI.DadosDaTransacao.Clear;
  Result := False;
  ItemSel := -1;

  case CodOperacaoAdm of
    tefopReimpressao:
      ItemSel := 0;
    tefopCancelamento:
      ItemSel := 2;
    tefopAdministrativo:
      begin
        sl := TStringList.Create;
        try
          sl.Add(ACBrStr('Reimpressão'));
          sl.Add(ACBrStr('Cancelar Transação'));
          sl.Add(ACBrStr('Atualizar Tabelas'));
          sl.Add(ACBrStr('Manutenção (Reset)'));
          TACBrTEFAPI(fpACBrTEFAPI).QuandoPerguntarMenu( 'Menu Administrativo', sl, ItemSel );
        finally
          sl.Free;
        end;
      end;
    else
      DoException(ACBrStr(Format(sACBrTEFAPIAdministrativaNaoSuportada,
        ['EfetuarAdministrativa( '+GetEnumName(TypeInfo(TACBrTEFOperacao),
        integer(CodOperacaoAdm) )+' )', ClassName])));
  end;

  case ItemSel of
    0:  // Reimpressão
      begin
        with GetTEFTPagAPI do
        begin
          ret := -1;
          s := UltimoRecibo(True, False, True, ret);
          Result := (ret = 0);
          if Result then
            DadosDaTransacao.Values['transactionReceipt'] := s;
        end;
      end;

    1:
      Result := CancelarTransacaoTPag();

    2:  // Atualizar Tabelas
      begin
        ret := GetTEFTPagAPI.AtualizarTabelas;
        Result := (ret = 0);
      end;

    3:  // Manutenção
      begin
        ret := GetTEFTPagAPI.ReiniciarTerminal;
        Result := (ret = 0);
        if Result then
          Autenticar;
      end;
  end;
end;

function TACBrTEFAPIClassTPag.EfetuarAdministrativa(const CodOperacaoAdm: string
  ): Boolean;
begin
  Result := EfetuarAdministrativa( TACBrTEFOperacao(StrToIntDef(CodOperacaoAdm, 0)) );
end;

function TACBrTEFAPIClassTPag.CancelarTransacao(const NSU,
  CodigoAutorizacaoTransacao: string; DataHoraTransacao: TDateTime;
  Valor: Double; const CodigoFinalizacao: string; const Rede: string): Boolean;
var
  nsuResponse: String;
  ret: LongInt;
  Lista: TACBrTEFRespostas;
  i: Integer;
begin
  nsuResponse := '';

  // TPag usa o nsuResponse ou NSU_TEF para Cancelamento, ConteudoToProperty salva em 'TEFResp.Finalizacao'
  if (CodigoFinalizacao <> '') then
    nsuResponse := CodigoFinalizacao
  else
  begin
    if (NSU <> '') then
    begin
      Lista := TACBrTEFRespostas.Create;
      try
        ObterListaDeTransacoes(Lista);
        for i := 0 to Lista.Count-1 do
        begin
          if (Lista[i].NSU = NSU) then
          begin
            nsuResponse := Lista[i].Finalizacao;
            Break;
          end;
        end;
      finally
        Lista.Free;
      end;
    end;
  end;

  ret := GetTEFTPagAPI.Cancelamento(nsuResponse, CARD_TYPE_NONE);
  if (ret = 0) then
    GetTEFTPagAPI.ObterUltimaTransacao(LAST_TRANSACTION_TYPE_CANCELLATION, ret);

  Result := (ret = 0);
end;

function TACBrTEFAPIClassTPag.CancelarTransacaoTPag: Boolean;
var
  NsuTEF: String;
  Cancelar: Boolean;
  ic: TPagInputModeConfig;
begin
  Result := False;
  NsuTEF := '';
  Cancelar := False;
  ic.minLength := 0; ic.maxLength := 0;
  ic.minValue := 0; ic.maxValue := 0;
  ic.allowZero := False; ic.maskInput := False;
  QuandoPerguntarCampoAPI(ACBrStr(sMsgInformeNSU), '',
    TPagRequestOptions(-1),
    INPUT_MODE_ALPHANUMERIC,
    ic, NsuTEF, Cancelar);
  if Cancelar then
    Exit;

  with GetTEFTPagAPI do
  begin
    Result := CancelarTransacao(NsuTEF, '', 0, 0);
  end;
end;

procedure TACBrTEFAPIClassTPag.FinalizarTransacao(const Rede, NSU,
  CodigoFinalizacao: String; AStatus: TACBrTEFStatusTransacao);
begin
  { Em TPag, não há necessidade de enviar a 3a perna (CNF, NCF) }
end;

procedure TACBrTEFAPIClassTPag.ResolverTransacaoPendente(
  AStatus: TACBrTEFStatusTransacao);
begin
  { Em TPag, não há o conceito de Transacao Pendente }
end;

procedure TACBrTEFAPIClassTPag.AbortarTransacaoEmAndamento;
begin
  GetTEFTPagAPI.AbortarTransacao;
end;

procedure TACBrTEFAPIClassTPag.ObterListaDeTransacoes(
  ListaTransacoes: TACBrTEFRespostas; Inicio: TDateTime; Fim: TDateTime;
  TransactionStatusSet: TPagTransactionStatusSet;
  ReadCardTypeSet: TPagReadCardTypeSet);
var
  Params: TPagTransactionFilter;
  lt: PPagTransactionPartial;
  t: TPagTransactionPartial;
  TefResp: TACBrTEFRespTPag;
  num, error, i: LongInt;
  ts: TPagTransactionStatus;
  rc: TPagReadCardType;
  sl: TStringList;
begin
  ListaTransacoes.Clear;

  if (TransactionStatusSet = []) then
    TransactionStatusSet := [ TRANSACTION_STATUS_CONFIRMED,
                              TRANSACTION_STATUS_UNDONE,
                              TRANSACTION_STATUS_PENDING,
                              TRANSACTION_STATUS_PENDING_CONFIRMATION,
                              TRANSACTION_STATUS_UNDO,
                              TRANSACTION_STATUS_PENDING_UNDO,
                              TRANSACTION_STATUS_REJECTED,
                              TRANSACTION_STATUS_CANCELLED ];

  if (ReadCardTypeSet = []) then
    ReadCardTypeSet := [ READ_CARD_TYPE_MAGNETIC,
                         READ_CARD_TYPE_M1,
                         READ_CARD_TYPE_M2,
                         READ_CARD_TYPE_EMV_CONTACT,
                         READ_CARD_TYPE_TIB,
                         READ_CARD_TYPE_CONTACTLESS_STRIPE,
                         READ_CARD_TYPE_CONTACTLESS_EMV,
                         READ_CARD_TYPE_TYPED ];

  if (Inicio <> 0) then
    Params.startDate := DateTimeToUnixMilliseconds(Inicio)
  else
    Params.startDate := 0;

  if (Fim <> 0) then
    Params.endDate := DateTimeToUnixMilliseconds(Fim)
  else
    Params.endDate := 0;

  num := 0;
  for ts := low(TPagTransactionStatus) to High(TPagTransactionStatus)  do
  begin
    if (ts in TransactionStatusSet) then
    begin
      Params.status[num] := Integer(ts);
      Inc(num)
    end;
  end;
  Params.statusSize := num;

  num := 0;
  for rc := low(TPagReadCardType) to High(TPagReadCardType)  do
  begin
    if (rc in ReadCardTypeSet) then
    begin
      Params.readCardType[num] := Integer(rc);
      Inc(num)
    end;
  end;
  Params.readCardTypeSize := num;

  num := 0;
  error := -1;
  lt := TEFTPagAPI.ObterListaTransacoes(Params, num, error);
  sl := TStringList.Create;
  try
    if (error = 0) then
    begin
      for i := 0 to num-1 do
      begin
        t := TEFTPagAPI.ObterTransacao(lt, i);
        TEFTPagAPI.TransacaoToStr(t, sl);
        TefResp := TACBrTEFRespTPag.Create;
        TefResp.SetStrings(sl);
        ListaTransacoes.Add(TefResp);
      end;
    end;
  finally
    sl.Free;
    TEFTPagAPI.LiberarListaTransacoes(lt, num);
  end;
end;

end.

