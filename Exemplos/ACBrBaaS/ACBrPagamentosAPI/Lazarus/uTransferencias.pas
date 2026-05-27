{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2021 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{ - Elias César                                                                }
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

unit uTransferencias;

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  ExtCtrls, Buttons, DateTimePicker,
  ACBrPagamentosAPI;

type

  { TfrmTransferencias }

  TfrmTransferencias = class(TForm)
    btConsultarLote: TBitBtn;
    btConsultarIdPagamento: TBitBtn;
    btIncluirLancamento: TBitBtn;
    btLimparLancamentos: TBitBtn;
    btLoteEnviar: TBitBtn;
    btPreencher: TBitBtn;
    cbConsultaLoteTipo: TComboBox;
    cbConsultarIdPagamentoTipo: TComboBox;
    cbLoteTipo: TComboBox;
    cbPixFormaIdentificacao: TComboBox;
    cbPixTipoConta: TComboBox;
    dtPixDataTransferencia: TDateTimePicker;
    dtTransfDataTransferencia: TDateTimePicker;
    edCodigoContrato: TEdit;
    edConsultarIdLote: TEdit;
    edConsultarIdPagamento: TEdit;
    edDigitoCCDebito: TEdit;
    edNumeroAgenciaDebito: TEdit;
    edNumeroContaCorrenteDebito: TEdit;
    edNumRequisicao: TEdit;
    edPixAgencia: TEdit;
    edPixConta: TEdit;
    edPixContaPagamento: TEdit;
    edPixChave: TEdit;
    edPixDescricaoPagamento: TEdit;
    edPixDescricaoPagamentoInstantaneo: TEdit;
    edPixDigitoVerificadorConta: TEdit;
    edPixDocumentoCredito: TEdit;
    edPixDocumentoDebito: TEdit;
    edPixNumeroCOMPE: TEdit;
    edPixNumeroISPB: TEdit;
    edPixValorTransferencia: TEdit;
    edTipoPagamento: TEdit;
    edTransfAgenciaCredito: TEdit;
    edTransfCnpjBeneficiario: TEdit;
    edTransfCodigoFinalidadeDOC: TEdit;
    edTransfCodigoFinalidadeTED: TEdit;
    edTransfContaCorrenteCredito: TEdit;
    edTransfContaPagamentoCredito: TEdit;
    edTransfCpfBeneficiario: TEdit;
    edTransfDescricaoTransferencia: TEdit;
    edTransfDigitoVerificadorCC: TEdit;
    edTransfDocumentoCredito: TEdit;
    edTransfDocumentoDebito: TEdit;
    edTransfNumeroCOMPE: TEdit;
    edTransfNumeroDepositoJudicial: TEdit;
    edTransfNumeroISPB: TEdit;
    edTransfValorTransferencia: TEdit;
    gbTransferenciaLancamento: TGroupBox;
    gbTransfPixLancamento: TGroupBox;
    lbCodigoContrato: TLabel;
    lbConsultaIdLote: TLabel;
    lbConsultaLoteTipo: TLabel;
    lbConsultarIdPagamento: TLabel;
    lbConsultarIdPagamentoTipo: TLabel;
    lbDigitoCCDebito: TLabel;
    lbLancamentos: TLabel;
    lbLancamentosQtd: TLabel;
    lbLoteTipo: TLabel;
    lbNumeroAgenciaDebito: TLabel;
    lbNumeroContaCorrenteDebito: TLabel;
    lbNumRequisicao: TLabel;
    lbPixAgencia: TLabel;
    lbPixConta: TLabel;
    lbPixContaPagamento: TLabel;
    lbPixChave: TLabel;
    lbPixDataTransferencia: TLabel;
    lbPixDescricaoPagamento: TLabel;
    lbPixDescricaoPagamentoInstantaneo: TLabel;
    lbPixDigitoVerificadorConta: TLabel;
    lbPixDocumentoCredito: TLabel;
    lbPixDocumentoDebito: TLabel;
    lbPixFormaIdentificacao: TLabel;
    lbPixNumeroCOMPE: TLabel;
    lbPixNumeroISPB: TLabel;
    lbPixTipoConta: TLabel;
    lbPixValorTransferencia: TLabel;
    lbTipoPagamento: TLabel;
    lbTransfAgenciaCredito: TLabel;
    lbTransfCnpjBeneficiario: TLabel;
    lbTransfCodigoFinalidadeDOC: TLabel;
    lbTransfCodigoFinalidadeTED: TLabel;
    lbTransfContaCorrenteCredito: TLabel;
    lbTransfContaPagamentoCredito: TLabel;
    lbTransfCpfBeneficiario: TLabel;
    lbTransfDataTransferencia: TLabel;
    lbTransfDescricaoTransferencia: TLabel;
    lbTransfDigitoVerificadorCC: TLabel;
    lbTransfDocumentoCredito: TLabel;
    lbTransfDocumentoDebito: TLabel;
    lbTransfNumeroCOMPE: TLabel;
    lbTransfNumeroDepositoJudicial: TLabel;
    lbTransfNumeroISPB: TLabel;
    lbTransfValorTransferencia: TLabel;
    mmConsultaLog: TMemo;
    mmConsultarPagamentoLog: TMemo;
    pnTransPixLancamento: TPanel;
    pnTransfLancamentos: TPanel;
    pgLancamentos: TPageControl;
    pgTransferencias: TPageControl;
    pgTransferenciasConsultas: TPageControl;
    pnLancamentos: TPanel;
    pnLote: TPanel;
    pnLoteConsultar: TPanel;
    pnLoteDados: TPanel;
    pnLoteRodape: TPanel;
    pnPagamentoConsultar: TPanel;
    pnPixLancamento: TPanel;
    pnTransferenciaLancamento: TPanel;
    tsTransfLancamento: TTabSheet;
    tsTransfPixLancamento: TTabSheet;
    tsLoteConsultar: TTabSheet;
    tsLoteTransferencia: TTabSheet;
    tsPagamentoConsultar: TTabSheet;
    tsTransfConsultas: TTabSheet;
    procedure btConsultarIdPagamentoClick(Sender: TObject);
    procedure btConsultarLoteClick(Sender: TObject);
    procedure btIncluirLancamentoClick(Sender: TObject);
    procedure btLimparLancamentosClick(Sender: TObject);
    procedure btLoteEnviarClick(Sender: TObject);
    procedure btPreencherClick(Sender: TObject);
    procedure cbLoteTipoSelect(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure LimparCampos;
    procedure AtualizarContadorLancamentos;

    procedure IncluirTransferenciaSolicitada;
    procedure IncluirPixSolicitado;

    procedure PreencherCamposHeaderLote;
    procedure PreencherCamposTransferencia;
    procedure PreencherCamposPix;

    procedure ConsultarLoteTransferencias;
    procedure ConsultarLotePix;

    procedure ConsultarPagamentoTransferencia;
    procedure ConsultarPagamentoPix;

    function EnviarLoteTransferencias: Boolean;
    function EnviarLotePix: Boolean;

    function ACBrPagamentosAPI: TACBrPagamentosAPI;
  public

  end;

var
  frmTransferencias: TfrmTransferencias;

implementation

uses
  Math,
  uDemoBaaS,
  ACBrUtil.Base,
  ACBrUtil.FilesIO,
  ACBrUtil.DateTime,
  ACBrSchemasPagamentosAPI,
  ACBrSchemasTransferenciasAPIBB;

{$R *.lfm}

{ TfrmTransferencias }

function TfrmTransferencias.ACBrPagamentosAPI: TACBrPagamentosAPI;
begin
  Result := frPagamentosAPITeste.ACBrPagamentosAPI1;
end;

procedure TfrmTransferencias.FormCreate(Sender: TObject);
begin
  LimparCampos;
  pgLancamentos.Visible := False;
  pgTransferencias.PageIndex := 0;
  pgTransferenciasConsultas.PageIndex := 0;

  gbTransferenciaLancamento.Visible := False;
  gbTransferenciaLancamento.Parent := pnLancamentos;

  gbTransfPixLancamento.Visible := False;
  gbTransfPixLancamento.Parent := pnLancamentos;

  cbLoteTipo.ItemIndex := 0;
  cbLoteTipoSelect(Nil);
end;

procedure TfrmTransferencias.cbLoteTipoSelect(Sender: TObject);
var
  i: Integer;
begin
  LimparCampos;

  i := cbLoteTipo.ItemIndex;
  gbTransferenciaLancamento.Visible := (i = 0);
  gbTransfPixLancamento.Visible := (i = 1);

  if Assigned(ACBrPagamentosAPI.Banco) then
  begin
    ACBrPagamentosAPI.Banco.Pagamentos.LoteTransferenciasSolicitado.listaTransferencias.Clear;
    ACBrPagamentosAPI.Banco.Pagamentos.LoteTransferenciaPixSolicitado.listaTransferencias.Clear;
    AtualizarContadorLancamentos;
  end;
end;

procedure TfrmTransferencias.LimparCampos;
begin
  edNumRequisicao.Text := EmptyStr;
  edCodigoContrato.Text := EmptyStr;
  edNumeroAgenciaDebito.Text := EmptyStr;
  edNumeroContaCorrenteDebito.Text := EmptyStr;
  edDigitoCCDebito.Text := EmptyStr;
  edTipoPagamento.Text := EmptyStr;

  edTransfNumeroCOMPE.Text := EmptyStr;
  edTransfNumeroISPB.Text := EmptyStr;
  edTransfAgenciaCredito.Text := EmptyStr;
  edTransfContaCorrenteCredito.Text := EmptyStr;
  edTransfDigitoVerificadorCC.Text := EmptyStr;
  edTransfContaPagamentoCredito.Text := EmptyStr;
  edTransfCpfBeneficiario.Text := EmptyStr;
  edTransfCnpjBeneficiario.Text := EmptyStr;
  dtTransfDataTransferencia.DateTime := NullDate;
  edTransfValorTransferencia.Text := EmptyStr;
  edTransfDocumentoDebito.Text := EmptyStr;
  edTransfDocumentoCredito.Text := EmptyStr;
  edTransfCodigoFinalidadeDOC.Text := EmptyStr;
  edTransfCodigoFinalidadeTED.Text := EmptyStr;
  edTransfNumeroDepositoJudicial.Text := EmptyStr;
  edTransfDescricaoTransferencia.Text := EmptyStr;

  dtPixDataTransferencia.DateTime := NullDate;
  edPixValorTransferencia.Text := EmptyStr;
  edPixDocumentoDebito.Text := EmptyStr;
  edPixDocumentoCredito.Text := EmptyStr;
  edPixDescricaoPagamento.Text := EmptyStr;
  edPixDescricaoPagamentoInstantaneo.Text := EmptyStr;
  cbPixFormaIdentificacao.ItemIndex := -1;
  edPixChave.Text := EmptyStr;
  edPixNumeroCOMPE.Text := EmptyStr;
  edPixNumeroISPB.Text := EmptyStr;
  cbPixTipoConta.ItemIndex := -1;
  edPixAgencia.Text := EmptyStr;
  edPixConta.Text := EmptyStr;
  edPixDigitoVerificadorConta.Text := EmptyStr;
  edPixContaPagamento.Text := EmptyStr;
end;

procedure TfrmTransferencias.AtualizarContadorLancamentos;
var
  qtd: Integer;
begin
  qtd := 0;
  case cbLoteTipo.ItemIndex of
    0: qtd := ACBrPagamentosAPI.Banco.Pagamentos.LoteTransferenciasSolicitado.listaTransferencias.Count;
    1: qtd := ACBrPagamentosAPI.Banco.Pagamentos.LoteTransferenciaPixSolicitado.listaTransferencias.Count;
  end;

  lbLancamentosQtd.Caption := IntToStrZero(qtd, 2);
end;

procedure TfrmTransferencias.btIncluirLancamentoClick(Sender: TObject);
begin
  if (MessageDlg('Deseja incluir o lançamento atual?', mtConfirmation, mbYesNo, 0) = mrNo) then
    Exit;

  case cbLoteTipo.ItemIndex of
    0: IncluirTransferenciaSolicitada;
    1: IncluirPixSolicitado;
  end;

  AtualizarContadorLancamentos;
end;

procedure TfrmTransferencias.btLimparLancamentosClick(Sender: TObject);
begin
  if (MessageDlg('Deseja zerar a lista de lançamentos?', mtConfirmation, mbYesNo, 0) = mrNo) then
    Exit;

  case cbLoteTipo.ItemIndex of
    0: ACBrPagamentosAPI.Banco.Pagamentos.LoteTransferenciasSolicitado.listaTransferencias.Clear;
    1: ACBrPagamentosAPI.Banco.Pagamentos.LoteTransferenciaPixSolicitado.listaTransferencias.Clear;
  end;
  AtualizarContadorLancamentos;
end;

procedure TfrmTransferencias.btPreencherClick(Sender: TObject);
begin
  PreencherCamposHeaderLote;

  case cbLoteTipo.ItemIndex of
    0: PreencherCamposTransferencia;
    1: PreencherCamposPix;
  end;
end;

procedure TfrmTransferencias.btLoteEnviarClick(Sender: TObject);
var
  ok: Boolean;
begin
  ok := False;
  case cbLoteTipo.ItemIndex of
    0: ok := EnviarLoteTransferencias;
    1: ok := EnviarLotePix;
  end;

  if ok then
    MessageDlg('Lote solicitado com Sucesso!', mtInformation, [mbOK], 0)
  else if ACBrPagamentosAPI.Banco.Pagamentos.RespostaErros.IsOAuthError then
    MessageDlg('Erro de Autenticação: ' +
      ACBrPagamentosAPI.Banco.Pagamentos.RespostaErros.OAuthError.message, mtError, [mbOK], 0)
  else if (not ACBrPagamentosAPI.Banco.Pagamentos.RespostaErros.IsEmpty) then
    MessageDlg('Erro: ' + ACBrPagamentosAPI.Banco.Pagamentos.RespostaErros[0].mensagem, mtError, [mbOK], 0);
end;

procedure TfrmTransferencias.btConsultarLoteClick(Sender: TObject);
begin
  if EstaVazio(edConsultarIdLote.Text) then
  begin
    MessageDlg('Preencha o campo Id para efetuar a consulta', mtError, [mbOK], 0);
    Abort;
  end;

  mmConsultaLog.Lines.Text := EmptyStr;
  case cbConsultaLoteTipo.ItemIndex of
    0: ConsultarLoteTransferencias;
    1: ConsultarLotePix;
  end;
end;

procedure TfrmTransferencias.btConsultarIdPagamentoClick(Sender: TObject);
begin
  if EstaVazio(edConsultarIdPagamento.Text) then
  begin
    MessageDlg('Preencha o campo Id para efetuar a consulta', mtError, [mbOK], 0);
    Abort;
  end;

  mmConsultarPagamentoLog.Lines.Text := EmptyStr;
  case cbConsultarIdPagamentoTipo.ItemIndex of
    0: ConsultarPagamentoTransferencia;
    1: ConsultarPagamentoPix;
  end;
end;

procedure TfrmTransferencias.IncluirTransferenciaSolicitada;
begin
  with ACBrPagamentosAPI.Banco.Pagamentos.LoteTransferenciasSolicitado.listaTransferencias.New do
  begin
    numeroCOMPE := StrToInt64Def(edTransfNumeroCOMPE.Text, 0);
    numeroISPB := StrToInt64Def(edTransfNumeroISPB.Text, 0);
    agenciaCredito := StrToInt64Def(edTransfAgenciaCredito.Text, 0);
    contaCorrenteCredito := StrToInt64Def(edTransfContaCorrenteCredito.Text, 0);
    digitoVerificadorContaCorrente := edTransfDigitoVerificadorCC.Text;
    contaPagamentoCredito := edTransfContaPagamentoCredito.Text;
    cpfBeneficiario := edTransfCpfBeneficiario.Text;
    cnpjBeneficiario := edTransfCnpjBeneficiario.Text;
    dataTransferencia := dtTransfDataTransferencia.DateTime;
    valorTransferencia := StrToFloatDef(edTransfValorTransferencia.Text, 0);
    documentoDebito := StrToInt64Def(edTransfDocumentoDebito.Text, 0);
    documentoCredito := StrToInt64Def(edTransfDocumentoCredito.Text, 0);
    codigoFinalidadeDOC := edTransfCodigoFinalidadeDOC.Text;
    codigoFinalidadeTED := edTransfCodigoFinalidadeTED.Text;
    numeroDepositoJudicial := edTransfNumeroDepositoJudicial.Text;
    descricaoTransferencia := edTransfDescricaoTransferencia.Text;
  end;
end;

procedure TfrmTransferencias.IncluirPixSolicitado;
var
  chavePix: String;
begin
  with ACBrPagamentosAPI.Banco.Pagamentos.LoteTransferenciaPixSolicitado.listaTransferencias.New do
  begin
    dataTransferencia := dtPixDataTransferencia.DateTime;
    valorTransferencia := StrToFloatDef(edPixValorTransferencia.Text, 0);
    documentoDebito := StrToInt64Def(edPixDocumentoDebito.Text, 0);
    documentoCredito := StrToInt64Def(edPixDocumentoCredito.Text, 0);
    descricaoPagamento := edPixDescricaoPagamento.Text;
    descricaoPagamentoInstantaneo := edPixDescricaoPagamentoInstantaneo.Text;

    chavePix := Trim(edPixChave.Text);
    case cbPixFormaIdentificacao.ItemIndex of
      0:
        begin
          formaIdentificacao := tfiCpfCnpj;
          cpf := chavePix;
        end;

      1:
        begin
          formaIdentificacao := tfiCpfCnpj;
          cnpj := chavePix;
        end;

      2:
        begin
          formaIdentificacao := tfiTelefone;
          if (Length(chavePix) >= 10) then
          begin
            dddTelefone := StrToIntDef(Copy(chavePix, 1, 2), 0);
            telefone := StrToInt64Def(Copy(chavePix, 3, Length(chavePix) - 2), 0);
          end
          else
          begin
            dddTelefone := 0;
            telefone := StrToInt64Def(chavePix, 0);
          end;
        end;

      3:
        begin
          formaIdentificacao := tfiEmail;
          email := chavePix;
        end;

      4:
        begin
          formaIdentificacao := tfiAleatoria;
          identificacaoAleatoria := chavePix;
        end;
    else
      formaIdentificacao := tfiNenhuma;
    end;

    numeroCOMPE := StrToInt64Def(edPixNumeroCOMPE.Text, 0);
    numeroISPB := StrToInt64Def(edPixNumeroISPB.Text, 0);

    if (cbPixTipoConta.ItemIndex >= 0) then
      tipoConta := cbPixTipoConta.ItemIndex + 1
    else
      tipoConta := 0;

    agencia := StrToInt64Def(edPixAgencia.Text, 0);
    conta := StrToInt64Def(edPixConta.Text, 0);
    digitoVerificadorConta := edPixDigitoVerificadorConta.Text;
    contaPagamento := edPixContaPagamento.Text;
  end;
end;

procedure TfrmTransferencias.PreencherCamposHeaderLote;
begin
  edNumRequisicao.Text := IntToStr(RandomRange(1, 9999999));
  edCodigoContrato.Text := '731030';
  edNumeroAgenciaDebito.Text := '1607';
  edNumeroContaCorrenteDebito.Text := '99738672';
  edDigitoCCDebito.Text := 'X';
  edTipoPagamento.Text := '126';
end;

procedure TfrmTransferencias.PreencherCamposTransferencia;
begin
  edTransfNumeroCOMPE.Text := '1';
  edTransfNumeroISPB.Text := '0';
  edTransfAgenciaCredito.Text := '1234';
  edTransfContaCorrenteCredito.Text := '12345678';
  edTransfDigitoVerificadorCC.Text := '1';
  edTransfContaPagamentoCredito.Text := EmptyStr;
  edTransfCpfBeneficiario.Text := '96050176876';
  edTransfCnpjBeneficiario.Text := EmptyStr;
  dtTransfDataTransferencia.DateTime := IncWorkingDay(Now, 1);
  edTransfValorTransferencia.Text := FormatFloatBr(RoundTo(RandomRange(50, 150) * Random, -2));
  edTransfDocumentoDebito.Text := '123';
  edTransfDocumentoCredito.Text := '456';
  edTransfCodigoFinalidadeDOC.Text := EmptyStr;
  edTransfCodigoFinalidadeTED.Text := '10';
  edTransfNumeroDepositoJudicial.Text := EmptyStr;
  edTransfDescricaoTransferencia.Text := 'Teste Lote Transferencias';
end;

procedure TfrmTransferencias.PreencherCamposPix;
begin
  dtPixDataTransferencia.DateTime := IncWorkingDay(Now, 1);
  edPixValorTransferencia.Text := FormatFloatBr(RoundTo(RandomRange(50, 150) * Random, -2));
  edPixDocumentoDebito.Text := '123';
  edPixDocumentoCredito.Text := '456';
  edPixDescricaoPagamento.Text := 'Teste Lote Pix';
  edPixDescricaoPagamentoInstantaneo.Text := 'Pix Teste';
  cbPixFormaIdentificacao.ItemIndex := 0;
  edPixChave.Text := '96050176876';
  edPixNumeroCOMPE.Text := EmptyStr;
  edPixNumeroISPB.Text := EmptyStr;
  cbPixTipoConta.ItemIndex := -1;
  edPixAgencia.Text := EmptyStr;
  edPixConta.Text := EmptyStr;
  edPixDigitoVerificadorConta.Text := EmptyStr;
  edPixContaPagamento.Text := EmptyStr;
end;

function TfrmTransferencias.EnviarLoteTransferencias: Boolean;
var
  lote: TACBrLoteTransferenciasRequisicao;
begin
  Result := False;

  if ACBrPagamentosAPI.Banco.Pagamentos.LoteTransferenciasSolicitado.listaTransferencias.IsEmpty then
  begin
    MessageDlg('Nenhum lançamento incluído', mtError, [mbOK], 0);
    Abort;
  end;

  lote := ACBrPagamentosAPI.Banco.Pagamentos.LoteTransferenciasSolicitado;
  lote.numeroRequisicao := StrToInt64Def(edNumRequisicao.Text, 0);
  lote.codigoContrato := StrToInt64Def(edCodigoContrato.Text, 0);
  lote.agenciaDebito := StrToInt64Def(edNumeroAgenciaDebito.Text, 0);
  lote.contaCorrenteDebito := StrToInt64Def(edNumeroContaCorrenteDebito.Text, 0);
  lote.digitoVerificadorContaCorrenteDebito := edDigitoCCDebito.Text;
  lote.tipoPagamento := StrToIntDef(edTipoPagamento.Text, 0);

  Result := ACBrPagamentosAPI.Banco.Pagamentos.TransferenciaSolicitarLote;
end;

function TfrmTransferencias.EnviarLotePix: Boolean;
var
  lote: TACBrLoteTransferenciaPixRequisicao;
begin
  Result := False;

  if ACBrPagamentosAPI.Banco.Pagamentos.LoteTransferenciaPixSolicitado.listaTransferencias.IsEmpty then
  begin
    MessageDlg('Nenhum lançamento incluído', mtError, [mbOK], 0);
    Abort;
  end;

  lote := ACBrPagamentosAPI.Banco.Pagamentos.LoteTransferenciaPixSolicitado;
  lote.numeroRequisicao := StrToInt64Def(edNumRequisicao.Text, 0);
  lote.codigoContrato := StrToInt64Def(edCodigoContrato.Text, 0);
  lote.agenciaDebito := StrToInt64Def(edNumeroAgenciaDebito.Text, 0);
  lote.contaCorrenteDebito := StrToInt64Def(edNumeroContaCorrenteDebito.Text, 0);
  lote.digitoVerificadorContaCorrenteDebito := edDigitoCCDebito.Text;
  lote.tipoPagamento := IntegerToTransferenciaPixTipoPagamento(StrToIntDef(edTipoPagamento.Text, 0));

  Result := ACBrPagamentosAPI.Banco.Pagamentos.TransferenciaPixSolicitarLote;
end;

procedure TfrmTransferencias.ConsultarLoteTransferencias;
var
  ok: Boolean;
begin
  ok := ACBrPagamentosAPI.Banco.Pagamentos.TransferenciaConsultarLote(edConsultarIdLote.Text);

  if ok then
  begin
    MessageDlg('Lote consultado com Sucesso!', mtInformation, [mbOK], 0);
    mmConsultaLog.Lines.Text := ACBrPagamentosAPI.Banco.Pagamentos.LoteTransferenciasConsultado.AsJSON;
  end
  else if ACBrPagamentosAPI.Banco.Pagamentos.RespostaErros.IsOAuthError then
    MessageDlg('Erro de Autenticação: ' + ACBrPagamentosAPI.Banco.Pagamentos.RespostaErros.OAuthError.message, mtError, [mbOK], 0)
  else if (not ACBrPagamentosAPI.Banco.Pagamentos.RespostaErros.IsEmpty) then
    MessageDlg('Erro: ' + ACBrPagamentosAPI.Banco.Pagamentos.RespostaErros[0].mensagem, mtError, [mbOK], 0);
end;

procedure TfrmTransferencias.ConsultarLotePix;
var
  ok: Boolean;
begin
  ok := ACBrPagamentosAPI.Banco.Pagamentos.TransferenciaPixConsultarLote(edConsultarIdLote.Text);

  if ok then
  begin
    MessageDlg('Lote consultado com Sucesso!', mtInformation, [mbOK], 0);
    mmConsultaLog.Lines.Text := ACBrPagamentosAPI.Banco.Pagamentos.LoteTransferenciaPixConsultado.AsJSON;
  end
  else if ACBrPagamentosAPI.Banco.Pagamentos.RespostaErros.IsOAuthError then
    MessageDlg('Erro de Autenticação: ' + ACBrPagamentosAPI.Banco.Pagamentos.RespostaErros.OAuthError.message, mtError, [mbOK], 0)
  else if (not ACBrPagamentosAPI.Banco.Pagamentos.RespostaErros.IsEmpty) then
    MessageDlg('Erro: ' + ACBrPagamentosAPI.Banco.Pagamentos.RespostaErros[0].mensagem, mtError, [mbOK], 0);
end;

procedure TfrmTransferencias.ConsultarPagamentoTransferencia;
var
  ok: Boolean;
begin
  ok := ACBrPagamentosAPI.Banco.Pagamentos.TransferenciaConsultar(edConsultarIdPagamento.Text);

  if ok then
  begin
    MessageDlg('Pagamento consultado com Sucesso!', mtInformation, [mbOK], 0);
    mmConsultarPagamentoLog.Lines.Text := ACBrPagamentosAPI.Banco.Pagamentos.TransferenciaConsultada.AsJSON;
  end
  else if ACBrPagamentosAPI.Banco.Pagamentos.RespostaErros.IsOAuthError then
    MessageDlg('Erro de Autenticação: ' + ACBrPagamentosAPI.Banco.Pagamentos.RespostaErros.OAuthError.message, mtError, [mbOK], 0)
  else if (not ACBrPagamentosAPI.Banco.Pagamentos.RespostaErros.IsEmpty) then
    MessageDlg('Erro: ' + ACBrPagamentosAPI.Banco.Pagamentos.RespostaErros[0].mensagem, mtError, [mbOK], 0);
end;

procedure TfrmTransferencias.ConsultarPagamentoPix;
var
  ok: Boolean;
begin
  ok := ACBrPagamentosAPI.Banco.Pagamentos.TransferenciaPixConsultar(edConsultarIdPagamento.Text);

  if ok then
  begin
    MessageDlg('Pagamento consultado com Sucesso!', mtInformation, [mbOK], 0);
    mmConsultarPagamentoLog.Lines.Text := ACBrPagamentosAPI.Banco.Pagamentos.TransferenciaPixConsultada.AsJSON;
  end
  else if ACBrPagamentosAPI.Banco.Pagamentos.RespostaErros.IsOAuthError then
    MessageDlg('Erro de Autenticação: ' + ACBrPagamentosAPI.Banco.Pagamentos.RespostaErros.OAuthError.message, mtError, [mbOK], 0)
  else if (not ACBrPagamentosAPI.Banco.Pagamentos.RespostaErros.IsEmpty) then
    MessageDlg('Erro: ' + ACBrPagamentosAPI.Banco.Pagamentos.RespostaErros[0].mensagem, mtError, [mbOK], 0);
end;

end.
