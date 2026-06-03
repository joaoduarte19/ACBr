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

unit ACBrCIOTIniReader;

interface

uses
  Classes,
  SysUtils,
  IniFiles,
  ACBrCIOTConversao,
  pcnCIOT;


type
  { TCIOTIniReader }

  TCIOTIniReader = class
  private
    FCIOT: TCIOT;

    FVersaoDF: TVersaoCIOT;
    FAmbiente: Integer;
    FtpEmis: Integer;

    procedure Ler_GravarAdicionarPagamento(AINIRec: TMemIniFile);
    procedure Ler_GravarAdicionarOperacao(AINIRec: TMemIniFile);
    procedure Ler_GravarAdicionarViagem(AINIRec: TMemIniFile);
    procedure Ler_GravarAlterarDataLiberacaoPagamento(AINIRec: TMemIniFile);
    procedure Ler_GravarCancelarOperacao(AINIRec: TMemIniFile);
    procedure Ler_GravarCancelarPagamento(AINIRec: TMemIniFile);
    procedure Ler_GravarEncerrarOperacao(AINIRec: TMemIniFile);
    procedure Ler_GravarMotorista(AINIRec: TMemIniFile);
    procedure Ler_GravarObterCIOT(AINIRec: TMemIniFile);
    procedure Ler_GravarObterPdf(AINIRec: TMemIniFile);
    procedure Ler_GravarProprietario(AINIRec: TMemIniFile);
    procedure Ler_GravarRegistrarPagamentoQuitacao(AINIRec: TMemIniFile);
    procedure Ler_GravarRegistrarQtdeMercadoriaDesembarque(AINIRec: TMemIniFile);
    procedure Ler_GravarRetificarOperacao(AINIRec: TMemIniFile);
    procedure Ler_GravarVeiculo(AINIRec: TMemIniFile);

    procedure Ler_Consignatario(AINIRec: TMemIniFile);
    procedure Ler_Contratado(AINIRec: TMemIniFile);
    procedure Ler_Contratante(AINIRec: TMemIniFile);
    procedure Ler_ContratantesCargaFracionada(AINIRec: TMemIniFile; APessoaCollection: TPessoaCollection);
    procedure Ler_Destinatario(AINIRec: TMemIniFile);
    procedure Ler_Impostos(AINIRec: TMemIniFile; AImpostos: TImpostos);
    procedure Ler_InformacoesBancarias(AINIRec: TMemIniFile; AInformacoesBancarias: TInformacoesBancarias; ASecao: String);
    procedure Ler_Login(AINIRec: TMemIniFile);
    procedure Ler_Logout(AINIRec: TMemIniFile);
    procedure Ler_Motorista(AINIRec: TMemIniFile);
    procedure Ler_NotaFiscalDesembarque(AINIRec: TMemIniFile; ANotaFiscalCollection: TNotaFiscalCollection);
    procedure Ler_NotaFiscal(AINIRec: TMemIniFile; ANotaFiscalCollection: TNotaFiscalCollection; item: string);
    procedure Ler_ObservacoesAoCredenciado(AINIRec: TMemIniFile; AObservacoesAoCredenciado: TMensagemCollection);
    procedure Ler_ObservacoesAoTransportador(AINIRec: TMemIniFile; AObservacoesAoTransportador: TMensagemCollection);
    procedure Ler_Pagamentos(AINIRec: TMemIniFile; APagamentoCollection: TPagamentoCollection);
    procedure Ler_Pessoa(AINIRec: TMemIniFile; ASecao: string; APessoa: TPessoa);
    procedure Ler_ProprietarioCarga(AINIRec: TMemIniFile);
    procedure Ler_Remetente(AINIRec: TMemIniFile);
    procedure Ler_Responsavel(AINIRec: TMemIniFile; ASecao: string; APessoa: TPessoa);
    procedure Ler_SubContratante(AINIRec: TMemIniFile);
    procedure Ler_TomadorServico(AINIRec: TMemIniFile);
    procedure Ler_Veiculos(AINIRec: TMemIniFile; AVeiculoCollection: TVeiculoCollection);
    procedure Ler_Viagem(AINIRec: TMemIniFile; AViagemCollection: TViagemCollection);
  public
    constructor Create(AOwner: TCIOT); reintroduce;

    function LerIni(const AIniString: string): Boolean;

    property CIOT: TCIOT read FCIOT write FCIOT;
    property VersaoDF: TVersaoCIOT read FVersaoDF write FVersaoDF;
    property Ambiente: Integer read FAmbiente write FAmbiente;
    property tpEmis: Integer read FtpEmis write FtpEmis;
  end;

implementation

uses
  ACBrUtil.Base,
  ACBrUtil.FilesIO,
  ACBrUtil.DateTime;

{ TCIOTIniReader }

constructor TCIOTIniReader.Create(AOwner: TCIOT);
begin
  inherited Create;

  FCIOT := AOwner;
end;

function TCIOTIniReader.LerIni(const AIniString: string): Boolean;
var
  LINIRec: TMemIniFile;
begin
  Result := True;

  LINIRec := TMemIniFile.Create('');
  try
    LerIniArquivoOuString(AIniString, LINIRec);

    FCIOT.Integradora.Operacao := IntToTpOperacao(LINIRec.ReadInteger('infCIOT', 'Operacao', 0));

    case FCIOT.Integradora.Operacao of
      opLogin:
        begin
          Ler_Login(LINIRec);
        end;

      opLogout:
        begin
          Ler_Logout(LINIRec);
        end;

      opGravarProprietario:
        begin
          Ler_GravarProprietario(LINIRec);
        end;

      opGravarVeiculo:
        begin
          Ler_GravarVeiculo(LINIRec);
        end;

      opGravarMotorista:
        begin
          Ler_GravarMotorista(LINIRec);
        end;

      opAdicionar:
        begin
          Ler_GravarAdicionarOperacao(LINIRec);
        end;

      opAdicionarViagem:
        begin
          Ler_GravarAdicionarViagem(LINIRec);
        end;

      opAdicionarPagamento:
        begin
          Ler_GravarAdicionarPagamento(LINIRec);
        end;

      opObterCodigoIOT:
        begin
          Ler_GravarObterCIOT(LINIRec);
        end;

      opObterPdf:
        begin
          Ler_GravarObterPdf(LINIRec);
        end;

      opRetificar:
        begin
          Ler_GravarRetificarOperacao(LINIRec);
        end;

      opCancelar:
        begin
          Ler_GravarCancelarOperacao(LINIRec);
        end;

      opCancelarPagamento:
        begin
          Ler_GravarCancelarPagamento(LINIRec);
        end;

      opEncerrar:
        begin
          Ler_GravarEncerrarOperacao(LINIRec);
        end;

      opConsultarTipoCarga:
        begin
          // Sem conteúdo
        end;

      opAlterarDataLiberacaoPagamento:
        begin
          Ler_GravarAlterarDataLiberacaoPagamento(LINIRec);
        end;

      opRegistrarQtdeMercadoriaDesembarque:
        begin
          Ler_GravarRegistrarQtdeMercadoriaDesembarque(LINIRec);
        end;

      opRegistrarPagamentoQuitacao:
        begin
          Ler_GravarRegistrarPagamentoQuitacao(LINIRec);
        end;
    else
      raise Exception.Create('Opção não implementada: ' + TpOperacaoToNome(FCIOT.Integradora.Operacao));
    end;
  finally
    LINIRec.Free;
  end;
end;

procedure TCIOTIniReader.Ler_Consignatario(AINIRec: TMemIniFile);
var
  LSecao: string;
begin
  LSecao := 'Consignatario';

  Ler_Responsavel(AINIRec, LSecao, FCIOT.AdicionarOperacao.Consignatario);
end;

procedure TCIOTIniReader.Ler_Contratado(AINIRec: TMemIniFile);
var
  LSecao: string;
begin
  LSecao := 'Contratado';

  FCIOT.AdicionarOperacao.Contratado.CpfOuCnpj := AINIRec.ReadString(LSecao, 'CpfOuCnpj', '');
  FCIOT.AdicionarOperacao.Contratado.RNTRC := AINIRec.ReadString(LSecao, 'RNTRC', '');
end;

procedure TCIOTIniReader.Ler_Contratante(AINIRec: TMemIniFile);
var
  LSecao: string;
begin
  LSecao := 'Contratante';

  Ler_Responsavel(AINIRec, LSecao, FCIOT.AdicionarOperacao.Contratante);

  FCIOT.AdicionarOperacao.Contratante.RNTRC := AINIRec.ReadString(LSecao, 'RNTRC', '');
end;

procedure TCIOTIniReader.Ler_ContratantesCargaFracionada(AINIRec: TMemIniFile; APessoaCollection: TPessoaCollection);
var
  LSecao: string;
  i: Integer;
  LFim: string;
  LItem: string;
  LPessoa: TPessoa;
begin
  i := 1;
  while true do
  begin
    LItem := IntToStrZero(i, 3);
    LSecao := 'ContratantesCargaFracionada' + LItem;
    LFim := AINIRec.ReadString(LSecao, 'CpfOuCnpj', 'FIM');

    if (LFim = 'FIM') or (Trim(LFim) = '') then
      break;

    LPessoa := APessoaCollection.New;

    LPessoa.CpfOuCnpj := LFim;

    Inc(i);
  end;
end;

procedure TCIOTIniReader.Ler_Destinatario(AINIRec: TMemIniFile);
var
  LSecao: string;
begin
  LSecao := 'Destinatario';

  Ler_Pessoa(AINIRec, LSecao, FCIOT.AdicionarOperacao.Destinatario);
end;

procedure TCIOTIniReader.Ler_GravarAdicionarOperacao(AINIRec: TMemIniFile);
var
  LSecao: string;
  ok: Boolean;
begin
  LSecao := TpOperacaoToNome(FCIOT.Integradora.Operacao);

  FCIOT.AdicionarOperacao.TipoViagem := EnumStrToTpTipoViagem(ok, AINIRec.ReadString(LSecao, 'TipoViagem', '0'));
  FCIOT.AdicionarOperacao.TipoPagamento := EnumStrToTpTipoPagamento(ok, AINIRec.ReadString(LSecao, 'TipoPagamento', '1'));
  FCIOT.AdicionarOperacao.BloquearNaoEquiparado := Boolean(StrToIntDef(AINIRec.ReadString(LSecao, 'BloquearNaoEquiparado', '0'), 0));
  FCIOT.AdicionarOperacao.MatrizCNPJ := AINIRec.ReadString(LSecao, 'MatrizCNPJ', '');
  FCIOT.AdicionarOperacao.FilialCNPJ := AINIRec.ReadString(LSecao, 'FilialCNPJ', '');
  FCIOT.AdicionarOperacao.IdOperacaoCliente := AINIRec.ReadString(LSecao, 'IdOperacaoCliente', '');
  FCIOT.AdicionarOperacao.DataInicioViagem := StringToDateTime(AINIRec.ReadString(LSecao, 'DataInicioViagem', '0'));
  FCIOT.AdicionarOperacao.DataFimViagem := StringToDateTime(AINIRec.ReadString(LSecao, 'DataFimViagem', '0'));
  FCIOT.AdicionarOperacao.CodigoNCMNaturezaCarga := AINIRec.ReadInteger(LSecao, 'CodigoNCMNaturezaCarga', 0);
  FCIOT.AdicionarOperacao.PesoCarga := AINIRec.ReadFloat(LSecao, 'PesoCarga', 0);
  FCIOT.AdicionarOperacao.TipoEmbalagem := EnumStrTotpTipoEmbalagem(ok, AINIRec.ReadString(LSecao, 'TipoEmbalagem', '0'));
  FCIOT.AdicionarOperacao.CodigoIdentificacaoOperacaoPrincipal := AINIRec.ReadString(LSecao, 'CodigoIdentificacaoOperacaoPrincipal', '');
  FCIOT.AdicionarOperacao.EntregaDocumentacao := EnumStrToTpEntregaDocumentacao(ok, AINIRec.ReadString(LSecao, 'EntregaDocumentacao', '0'));
  FCIOT.AdicionarOperacao.QuantidadeSaques := AINIRec.ReadInteger(LSecao, 'QuantidadeSaques', 0);
  FCIOT.AdicionarOperacao.QuantidadeTransferencias := AINIRec.ReadInteger(LSecao, 'QuantidadeTransferencias', 0);
  FCIOT.AdicionarOperacao.ValorSaques := AINIRec.ReadFloat(LSecao, 'ValorSaques', 0);
  FCIOT.AdicionarOperacao.ValorTransferencias := AINIRec.ReadFloat(LSecao, 'ValorTransferencias', 0);
  FCIOT.AdicionarOperacao.CodigoTipoCarga := EnumStrTotpTipoCarga(ok, AINIRec.ReadString(LSecao, 'CodigoTipoCarga', '0'));
  FCIOT.AdicionarOperacao.AltoDesempenho := Boolean(StrToIntDef(AINIRec.ReadString(LSecao, 'AltoDesempenho', '0'), 0));
  FCIOT.AdicionarOperacao.ComposicaoVeicular := Boolean(StrToIntDef(AINIRec.ReadString(LSecao, 'ComposicaoVeicular', '0'), 0));
  FCIOT.AdicionarOperacao.RetornoVazio := Boolean(StrToIntDef(AINIRec.ReadString(LSecao, 'RetornoVazio', '0'), 0));

  Ler_Viagem(AINIRec, FCIOT.AdicionarOperacao.Viagens);
  Ler_Impostos(AINIRec, FCIOT.AdicionarOperacao.Impostos);
  Ler_Pagamentos(AINIRec, FCIOT.AdicionarOperacao.Pagamentos);
  Ler_Contratado(AINIRec);
  Ler_Motorista(AINIRec);
  Ler_Destinatario(AINIRec);
  Ler_Contratante(AINIRec);
  Ler_SubContratante(AINIRec);
  Ler_Consignatario(AINIRec);
  Ler_TomadorServico(AINIRec);
  Ler_Remetente(AINIRec);
  Ler_ProprietarioCarga(AINIRec);
  Ler_Veiculos(AINIRec, FCIOT.AdicionarOperacao.Veiculos);
  Ler_ContratantesCargaFracionada(AINIRec, FCIOT.AdicionarOperacao.ContratantesCargaFracionada);
  Ler_ObservacoesAoTransportador(AINIRec, FCIOT.AdicionarOperacao.ObservacoesAoTransportador);
  Ler_ObservacoesAoCredenciado(AINIRec, FCIOT.AdicionarOperacao.ObservacoesAoCredenciado);
end;

procedure TCIOTIniReader.Ler_GravarAdicionarPagamento(AINIRec: TMemIniFile);
var
  LSecao: string;
begin
  LSecao := TpOperacaoToNome(FCIOT.Integradora.Operacao);

  FCIOT.AdicionarPagamento.CodigoIdentificacaoOperacao := AINIRec.ReadString(LSecao, 'CodigoIdentificacaoOperacao', '');

  Ler_Pagamentos(AINIRec, FCIOT.AdicionarPagamento.Pagamentos);
end;

procedure TCIOTIniReader.Ler_GravarAdicionarViagem(AINIRec: TMemIniFile);
var
  LSecao: string;
begin
  LSecao := TpOperacaoToNome(FCIOT.Integradora.Operacao);

  FCIOT.AdicionarViagem.CodigoIdentificacaoOperacao := AINIRec.ReadString(LSecao, 'CodigoIdentificacaoOperacao', '');
  FCIOT.AdicionarViagem.NaoAdicionarParcialmente := Boolean(StrToIntDef(AINIRec.ReadString(LSecao, 'NaoAdicionarParcialmente', '0'), 0));

  Ler_Viagem(AINIRec, FCIOT.AdicionarViagem.Viagens);
  Ler_Pagamentos(AINIRec, FCIOT.AdicionarViagem.Pagamentos);
end;

procedure TCIOTIniReader.Ler_GravarAlterarDataLiberacaoPagamento(AINIRec: TMemIniFile);
var
  LSecao: string;
begin
  LSecao := TpOperacaoToNome(FCIOT.Integradora.Operacao);

  FCIOT.AlterarDataLiberacaoPagamento.CodigoIdentificacaoOperacao := AINIRec.ReadString(LSecao, 'CodigoIdentificacaoOperacao', '');
  FCIOT.AlterarDataLiberacaoPagamento.IdPagamentoCliente := AINIRec.ReadString(LSecao, 'IdPagamentoCliente', '');
  FCIOT.AlterarDataLiberacaoPagamento.DataDeLiberacao := StringToDateTime(AINIRec.ReadString(LSecao, 'DataDeLiberacao', '0'));
  FCIOT.AlterarDataLiberacaoPagamento.Motivo := AINIRec.ReadString(LSecao, 'Motivo', '');
end;

procedure TCIOTIniReader.Ler_GravarCancelarOperacao(AINIRec: TMemIniFile);
var
  LSecao: string;
begin
  LSecao := TpOperacaoToNome(FCIOT.Integradora.Operacao);

  FCIOT.CancelarOperacao.CodigoIdentificacaoOperacao := AINIRec.ReadString(LSecao, 'CodigoIdentificacaoOperacao', '');
  FCIOT.CancelarOperacao.Motivo := AINIRec.ReadString(LSecao, 'Motivo', '');
end;

procedure TCIOTIniReader.Ler_GravarCancelarPagamento(AINIRec: TMemIniFile);
var
  LSecao: string;
begin
  LSecao := TpOperacaoToNome(FCIOT.Integradora.Operacao);

  FCIOT.CancelarPagamento.CodigoIdentificacaoOperacao := AINIRec.ReadString(LSecao, 'CodigoIdentificacaoOperacao', '');
  FCIOT.CancelarPagamento.IdPagamentoCliente := AINIRec.ReadString(LSecao, 'IdPagamentoCliente', '');
  FCIOT.CancelarPagamento.Motivo := AINIRec.ReadString(LSecao, 'Motivo', '');
end;

procedure TCIOTIniReader.Ler_GravarEncerrarOperacao(AINIRec: TMemIniFile);
var
  LSecao: string;
begin
  LSecao := TpOperacaoToNome(FCIOT.Integradora.Operacao);

  FCIOT.EncerrarOperacao.CodigoIdentificacaoOperacao := AINIRec.ReadString(LSecao, 'CodigoIdentificacaoOperacao', '');
  FCIOT.EncerrarOperacao.PesoCarga := AINIRec.ReadFloat(LSecao, 'PesoCarga', 0);
  FCIOT.EncerrarOperacao.QuantidadeSaques := AINIRec.ReadInteger(LSecao, 'QuantidadeSaques', 0);
  FCIOT.EncerrarOperacao.QuantidadeTransferencias := AINIRec.ReadInteger(LSecao, 'QuantidadeTransferencias', 0);

  Ler_Viagem(AINIRec, FCIOT.EncerrarOperacao.Viagens);
  Ler_Pagamentos(AINIRec, FCIOT.EncerrarOperacao.Pagamentos);
  Ler_Impostos(AINIRec, FCIOT.EncerrarOperacao.Impostos);
end;

procedure TCIOTIniReader.Ler_GravarMotorista(AINIRec: TMemIniFile);
var
  LSecao: string;
begin
  LSecao := TpOperacaoToNome(FCIOT.Integradora.Operacao);

  FCIOT.GravarMotorista.CPF := AINIRec.ReadString(LSecao, 'CPF', '');
  FCIOT.GravarMotorista.Nome := AINIRec.ReadString(LSecao, 'Nome', '');
  FCIOT.GravarMotorista.CNH := AINIRec.ReadString(LSecao, 'CNH', '');
  FCIOT.GravarMotorista.DataNascimento := StringToDateTime(AINIRec.ReadString(LSecao, 'DataNascimento', '0'));
  FCIOT.GravarMotorista.NomeDeSolteiraDaMae := AINIRec.ReadString(LSecao, 'NomeDeSolteiraDaMae', '');
  FCIOT.GravarMotorista.Endereco.Bairro := AINIRec.ReadString(LSecao, 'Endereco.Bairro', '');
  FCIOT.GravarMotorista.Endereco.Rua := AINIRec.ReadString(LSecao, 'Endereco.Rua', '');
  FCIOT.GravarMotorista.Endereco.Numero := AINIRec.ReadString(LSecao, 'Endereco.Numero', '');
  FCIOT.GravarMotorista.Endereco.Complemento := AINIRec.ReadString(LSecao, 'Endereco.Complemento', '');
  FCIOT.GravarMotorista.Endereco.CEP := AINIRec.ReadString(LSecao, 'Endereco.CEP', '');
  FCIOT.GravarMotorista.Endereco.CodigoMunicipio := AINIRec.ReadInteger(LSecao, 'Endereco.CodigoMunicipio', 0);
  FCIOT.GravarMotorista.Telefones.Celular.DDD := AINIRec.ReadInteger(LSecao, 'Telefones.Celular.DDD', 0);
  FCIOT.GravarMotorista.Telefones.Celular.Numero := AINIRec.ReadInteger(LSecao, 'Telefones.Celular.Numero', 0);
  FCIOT.GravarMotorista.Telefones.Fixo.DDD := AINIRec.ReadInteger(LSecao, 'Telefones.Fixo.DDD', 0);
  FCIOT.GravarMotorista.Telefones.Fixo.Numero := AINIRec.ReadInteger(LSecao, 'Telefones.Fixo.Numero', 0);
  FCIOT.GravarMotorista.Telefones.Fax.DDD := AINIRec.ReadInteger(LSecao, 'Telefones.Fax.DDD', 0);
  FCIOT.GravarMotorista.Telefones.Fax.Numero := AINIRec.ReadInteger(LSecao, 'Telefones.Fax.Numero', 0);
end;

procedure TCIOTIniReader.Ler_GravarObterCIOT(AINIRec: TMemIniFile);
var
  LSecao: string;
begin
  LSecao := TpOperacaoToNome(FCIOT.Integradora.Operacao);

  FCIOT.ObterCodigoOperacaoTransporte.MatrizCNPJ := AINIRec.ReadString(LSecao, 'MatrizCNPJ', '');
  FCIOT.ObterCodigoOperacaoTransporte.IdOperacaoCliente := AINIRec.ReadString(LSecao, 'IdOperacaoCliente', '');
end;

procedure TCIOTIniReader.Ler_GravarObterPdf(AINIRec: TMemIniFile);
var
  LSecao: string;
begin
  LSecao := TpOperacaoToNome(FCIOT.Integradora.Operacao);

  FCIOT.ObterOperacaoTransportePDF.CodigoIdentificacaoOperacao := AINIRec.ReadString(LSecao, 'CodigoIdentificacaoOperacao', '');
  FCIOT.ObterOperacaoTransportePDF.DocumentoViagem := AINIRec.ReadString(LSecao, 'DocumentoViagem', '');
end;

procedure TCIOTIniReader.Ler_GravarProprietario(AINIRec: TMemIniFile);
var
  LSecao: string;
  ok: Boolean;
begin
  LSecao := TpOperacaoToNome(FCIOT.Integradora.Operacao);

  FCIOT.GravarProprietario.CNPJ := AINIRec.ReadString(LSecao, 'CNPJ', '');
  FCIOT.GravarProprietario.TipoPessoa := EnumStrTotpTipoPessoa(ok, AINIRec.ReadString(LSecao, 'TipoPessoa', IntToStr(Integer(tpIndefinido))));
  FCIOT.GravarProprietario.RazaoSocial := AINIRec.ReadString(LSecao, 'RazaoSocial', '');
  FCIOT.GravarProprietario.RNTRC := AINIRec.ReadString(LSecao, 'RNTRC', '');

  FCIOT.GravarProprietario.Endereco.Bairro := AINIRec.ReadString(LSecao, 'Bairro', '');
  FCIOT.GravarProprietario.Endereco.Rua := AINIRec.ReadString(LSecao, 'Rua', '');
  FCIOT.GravarProprietario.Endereco.Numero := AINIRec.ReadString(LSecao, 'Numero', '');
  FCIOT.GravarProprietario.Endereco.Complemento := AINIRec.ReadString(LSecao, 'Complemento', '');
  FCIOT.GravarProprietario.Endereco.CEP := AINIRec.ReadString(LSecao, 'CEP', '');
  FCIOT.GravarProprietario.Endereco.CodigoMunicipio := AINIRec.ReadInteger(LSecao, 'CodigoMunicipio', 0);

  FCIOT.GravarProprietario.Telefones.Celular.DDD := AINIRec.ReadInteger(LSecao, 'Celular.DDD', 0);
  FCIOT.GravarProprietario.Telefones.Celular.Numero := AINIRec.ReadInteger(LSecao, 'Celular.Numero', 0);

  FCIOT.GravarProprietario.Telefones.Fixo.DDD := AINIRec.ReadInteger(LSecao, 'Fixo.DDD', 0);
  FCIOT.GravarProprietario.Telefones.Fixo.Numero := AINIRec.ReadInteger(LSecao, 'Fixo.Numero', 0);

  FCIOT.GravarProprietario.Telefones.Fax.DDD := AINIRec.ReadInteger(LSecao, 'Fax.DDD', 0);
  FCIOT.GravarProprietario.Telefones.Fax.Numero := AINIRec.ReadInteger(LSecao, 'Fax.Numero', 0);
end;

procedure TCIOTIniReader.Ler_GravarRegistrarPagamentoQuitacao(AINIRec: TMemIniFile);
var
  LSecao: string;
begin
  LSecao := TpOperacaoToNome(FCIOT.Integradora.Operacao);

  FCIOT.RegistrarPagamentoQuitacao.CodigoIdentificacaoOperacao := AINIRec.ReadString(LSecao, 'CodigoIdentificacaoOperacao', '');
  FCIOT.RegistrarPagamentoQuitacao.TokenCompra := AINIRec.ReadString(LSecao, 'TokenCompra', '');

  Ler_NotaFiscalDesembarque(AINIRec, FCIOT.RegistrarPagamentoQuitacao.NotasFiscais);
end;

procedure TCIOTIniReader.Ler_GravarRegistrarQtdeMercadoriaDesembarque(AINIRec: TMemIniFile);
var
  LSecao: string;
begin
  LSecao := TpOperacaoToNome(FCIOT.Integradora.Operacao);

  FCIOT.RegistrarQuantidadeDaMercadoriaNoDesembarque.CodigoIdentificacaoOperacao := AINIRec.ReadString(LSecao, 'CodigoIdentificacaoOperacao', '');

  Ler_NotaFiscalDesembarque(AINIRec, FCIOT.RegistrarQuantidadeDaMercadoriaNoDesembarque.NotasFiscais);
end;

procedure TCIOTIniReader.Ler_GravarRetificarOperacao(AINIRec: TMemIniFile);
var
  LSecao: string;
  ok: Boolean;
begin
  LSecao := TpOperacaoToNome(FCIOT.Integradora.Operacao);

  FCIOT.RetificarOperacao.CodigoIdentificacaoOperacao := AINIRec.ReadString(LSecao, 'CodigoIdentificacaoOperacao', '0');
  FCIOT.RetificarOperacao.DataInicioViagem := StringToDateTime(AINIRec.ReadString(LSecao, 'DataInicioViagem', '0'));
  FCIOT.RetificarOperacao.DataFimViagem := StringToDateTime(AINIRec.ReadString(LSecao, 'DataFimViagem', '0'));
  FCIOT.RetificarOperacao.CodigoNCMNaturezaCarga := AINIRec.ReadInteger(LSecao, 'CodigoNCMNaturezaCarga', 0);
  FCIOT.RetificarOperacao.PesoCarga := AINIRec.ReadFloat(LSecao, 'PesoCarga', 0);
  FCIOT.RetificarOperacao.CodigoMunicipioOrigem := AINIRec.ReadInteger(LSecao, 'CodigoMunicipioOrigem', 0);
  FCIOT.RetificarOperacao.CodigoMunicipioDestino := AINIRec.ReadInteger(LSecao, 'CodigoMunicipioDestino', 0);
  FCIOT.RetificarOperacao.QuantidadeSaques := AINIRec.ReadInteger(LSecao, 'QuantidadeSaques', 0);
  FCIOT.RetificarOperacao.QuantidadeTransferencias := AINIRec.ReadInteger(LSecao, 'QuantidadeTransferencias', 0);
  FCIOT.RetificarOperacao.ValorSaques := AINIRec.ReadFloat(LSecao, 'ValorSaques', 0);
  FCIOT.RetificarOperacao.ValorTransferencias := AINIRec.ReadFloat(LSecao, 'ValorTransferencias', 0);
  FCIOT.RetificarOperacao.CodigoTipoCarga := EnumStrTotpTipoCarga(ok, AINIRec.ReadString(LSecao, 'CodigoTipoCarga', '0'));
  FCIOT.RetificarOperacao.CepOrigem := AINIRec.ReadString(LSecao, 'CepOrigem', '0');
  FCIOT.RetificarOperacao.CepDestino := AINIRec.ReadString(LSecao, 'CepDestino', '0');
  FCIOT.RetificarOperacao.DistanciaPercorrida := AINIRec.ReadInteger(LSecao, 'DistanciaPercorrida', 0);

  Ler_Veiculos(AINIRec, FCIOT.RetificarOperacao.Veiculos);
end;

procedure TCIOTIniReader.Ler_GravarVeiculo(AINIRec: TMemIniFile);
var
  LSecao: string;
  ok: Boolean;
begin
  LSecao := TpOperacaoToNome(FCIOT.Integradora.Operacao);

  FCIOT.GravarVeiculo.Placa := AINIRec.ReadString(LSecao, 'Placa', '');
  FCIOT.GravarVeiculo.Renavam := AINIRec.ReadString(LSecao, 'Renavam', '');
  FCIOT.GravarVeiculo.Chassi := AINIRec.ReadString(LSecao, 'Chassi', '');
  FCIOT.GravarVeiculo.RNTRC := AINIRec.ReadString(LSecao, 'RNTRC', '');
  FCIOT.GravarVeiculo.NumeroDeEixos := AINIRec.ReadInteger(LSecao, 'NumeroDeEixos', 0);
  FCIOT.GravarVeiculo.CodigoMunicipio := AINIRec.ReadInteger(LSecao, 'CodigoMunicipio', 0);
  FCIOT.GravarVeiculo.Marca := AINIRec.ReadString(LSecao, 'Marca', '');
  FCIOT.GravarVeiculo.Modelo := AINIRec.ReadString(LSecao, 'Modelo', '');
  FCIOT.GravarVeiculo.AnoFabricacao := AINIRec.ReadInteger(LSecao, 'AnoFabricacao', 0);
  FCIOT.GravarVeiculo.AnoModelo := AINIRec.ReadInteger(LSecao, 'AnoModelo', 0);
  FCIOT.GravarVeiculo.Cor := AINIRec.ReadString(LSecao, 'Cor', '');
  FCIOT.GravarVeiculo.Tara := AINIRec.ReadInteger(LSecao, 'Tara', 0);
  FCIOT.GravarVeiculo.CapacidadeKg := AINIRec.ReadInteger(LSecao, 'CapacidadeKg', 0);
  FCIOT.GravarVeiculo.CapacidadeM3 := AINIRec.ReadInteger(LSecao, 'CapacidadeM3', 0);
  FCIOT.GravarVeiculo.TipoRodado := EnumStrToTpTipoRodado(ok, AINIRec.ReadString(LSecao, 'TipoRodado', '0'));
  FCIOT.GravarVeiculo.TipoCarroceria := EnumStrToTpTipoCarroceria(ok, AINIRec.ReadString(LSecao, 'TipoCarroceria', '0'));
end;

procedure TCIOTIniReader.Ler_Impostos(AINIRec: TMemIniFile; AImpostos: TImpostos);
var
  LSecao: string;
begin
  LSecao := 'Impostos';

  AImpostos.IRRF := AINIRec.ReadFloat(LSecao, 'IRRF', 0);
  AImpostos.SestSenat := AINIRec.ReadFloat(LSecao, 'SestSenat', 0);
  AImpostos.INSS := AINIRec.ReadFloat(LSecao, 'INSS', 0);
  AImpostos.ISSQN := AINIRec.ReadFloat(LSecao, 'ISSQN', 0);
  AImpostos.OutrosImpostos := AINIRec.ReadFloat(LSecao, 'OutrosImpostos', 0);
  AImpostos.DescricaoOutrosImpostos := AINIRec.ReadString(LSecao, 'DescricaoOutrosImpostos', '');
end;

procedure TCIOTIniReader.Ler_InformacoesBancarias(AINIRec: TMemIniFile; AInformacoesBancarias: TInformacoesBancarias; ASecao: String);
var
  ok: boolean;
begin
  AInformacoesBancarias.InstituicaoBancaria := AINIRec.ReadString(ASecao, 'InstituicaoBancaria', '');
  AInformacoesBancarias.Agencia := AINIRec.ReadString(ASecao, 'Agencia', '');
  AInformacoesBancarias.Conta := AINIRec.ReadString(ASecao, 'Conta', '');
  AInformacoesBancarias.TipoConta := EnumStrTotpTipoConta(ok, AINIRec.ReadString(ASecao, 'TipoConta', '0'));
end;

procedure TCIOTIniReader.Ler_Login(AINIRec: TMemIniFile);
var
  LSecao: string;
  LValor: string;
begin
  LSecao := TpOperacaoToNome(FCIOT.Integradora.Operacao);

  LValor := AINIRec.ReadString(LSecao, 'Usuario', '');
  if LValor <> '' then
  begin
    FCIOT.Integradora.Usuario := LValor;
    FCIOT.Integradora.Senha := AINIRec.ReadString(LSecao, 'Senha', '');
    FCIOT.Integradora.Integrador := AINIRec.ReadString(LSecao, 'Integrador', '');
  end;
end;

procedure TCIOTIniReader.Ler_Logout(AINIRec: TMemIniFile);
var
  LSecao: string;
  LValor: string;
begin
  LSecao := TpOperacaoToNome(FCIOT.Integradora.Operacao);

  LValor := AINIRec.ReadString(LSecao, 'Token', '');
  if LValor <> '' then
  begin
    FCIOT.Integradora.Token := LValor;
    FCIOT.Integradora.Integrador := AINIRec.ReadString(LSecao, 'Integrador', '');
  end;
end;

procedure TCIOTIniReader.Ler_Motorista(AINIRec: TMemIniFile);
var
  LSecao: string;
begin
  LSecao := 'Motorista';

  FCIOT.AdicionarOperacao.Motorista.CpfOuCnpj := AINIRec.ReadString(LSecao, 'CpfOuCnpj', '');
  FCIOT.AdicionarOperacao.Motorista.CNH := AINIRec.ReadString(LSecao, 'CNH', '');
  FCIOT.AdicionarOperacao.Motorista.Celular.DDD := AINIRec.ReadInteger(LSecao, 'DDD', 0);
  FCIOT.AdicionarOperacao.Motorista.Celular.Numero := AINIRec.ReadInteger(LSecao, 'Numero', 0);
end;

procedure TCIOTIniReader.Ler_NotaFiscal(AINIRec: TMemIniFile; ANotaFiscalCollection: TNotaFiscalCollection; item: string);
var
  LSecao: string;
  ok: boolean;
  i: Integer;
  LNotaFiscal: TNotaFiscalCollectionItem;
  LFim: string;
begin
  i := 1;
  while true do
  begin
    LSecao := 'NotaFiscal' + item + IntToStrZero(i, 3);
    LFim := AINIRec.ReadString(LSecao, 'Numero', 'FIM');

    if (LFim = 'FIM') or (Trim(LFim) = '') then
      break;

    LNotaFiscal := ANotaFiscalCollection.New;

    LNotaFiscal.Numero := LFim;
    LNotaFiscal.Serie := AINIRec.ReadString(LSecao, 'Serie', '');
    LNotaFiscal.CnpjEmissor := AINIRec.ReadString(LSecao, 'CnpjEmissor', '');
    LNotaFiscal.Data := StringToDateTime(AINIRec.ReadString(LSecao, 'Data', '0'));
    LNotaFiscal.ValorTotal := AINIRec.ReadFloat(LSecao, 'ValorTotal', 0);
    LNotaFiscal.ValorDaMercadoriaPorUnidade := AINIRec.ReadFloat(LSecao, 'ValorDaMercadoriaPorUnidade', 0);
    LNotaFiscal.CodigoNCMNaturezaCarga := AINIRec.ReadInteger(LSecao, 'CodigoNCMNaturezaCarga', 0);
    LNotaFiscal.DescricaoDaMercadoria := AINIRec.ReadString(LSecao, 'DescricaoDaMercadoria', '');
    LNotaFiscal.UnidadeDeMedidaDaMercadoria := EnumStrToTpUnidDeMedMerc(ok, AINIRec.ReadString(LSecao, 'UnidadeDeMedidaDaMercadoria', '0'));
    LNotaFiscal.TipoDeCalculo := EnumStrToTpViagemTipoDeCalculo(ok, AINIRec.ReadString(LSecao, 'TipoDeCalculo', '1'));
    LNotaFiscal.ValorDoFretePorUnidadeDeMercadoria := AINIRec.ReadFloat(LSecao, 'ValorDoFretePorUnidadeDeMercadoria', 0);
    LNotaFiscal.QuantidadeDaMercadoriaNoEmbarque := AINIRec.ReadFloat(LSecao, 'QuantidadeDaMercadoriaNoEmbarque', 0);
    LNotaFiscal.ToleranciaDePerdaDeMercadoria.Tipo := EnumStrToTpTipoProporcao(ok, AINIRec.ReadString(LSecao, 'ToleranciaDePerdaDeMercadoria.Tipo', '0'));
    LNotaFiscal.ToleranciaDePerdaDeMercadoria.Valor := AINIRec.ReadFloat(LSecao, 'ToleranciaDePerdaDeMercadoria.Valor', 0);
    LNotaFiscal.DiferencaDeFrete.Tipo := EnumStrToTpDiferencaFrete(ok, AINIRec.ReadString(LSecao, 'DiferencaDeFrete.Tipo', '1'));
    LNotaFiscal.DiferencaDeFrete.Base := EnumStrToTpDiferencaFreteBaseCalculo(ok, AINIRec.ReadString(LSecao, 'DiferencaDeFrete.Base', '1'));
    LNotaFiscal.DiferencaDeFrete.Tolerancia.Tipo := EnumStrToTpTipoProporcao(ok, AINIRec.ReadString(LSecao, 'Tolerancia.Tipo', '0'));
    LNotaFiscal.DiferencaDeFrete.Tolerancia.Valor := AINIRec.ReadFloat(LSecao, 'Tolerancia.Valor', 0);
    LNotaFiscal.DiferencaDeFrete.MargemGanho.Tipo := EnumStrToTpTipoProporcao(ok, AINIRec.ReadString(LSecao, 'MargemGanho.Tipo', '0'));
    LNotaFiscal.DiferencaDeFrete.MargemGanho.Valor := AINIRec.ReadFloat(LSecao, 'MargemGanho.Valor', 0);
    LNotaFiscal.DiferencaDeFrete.MargemPerda.Tipo := EnumStrToTpTipoProporcao(ok, AINIRec.ReadString(LSecao, 'MargemPerda.Tipo', '0'));
    LNotaFiscal.DiferencaDeFrete.MargemPerda.Valor := AINIRec.ReadFloat(LSecao, 'MargemPerda.Valor', 0);

    Inc(i);
  end;
end;

procedure TCIOTIniReader.Ler_NotaFiscalDesembarque(AINIRec: TMemIniFile; ANotaFiscalCollection: TNotaFiscalCollection);
var
  LSecao: string;
  ok: boolean;
  i: Integer;
  LNotaFiscal: TNotaFiscalCollectionItem;
  LFim: string;
begin
  i := 1;
  while true do
  begin
    LSecao := 'NotaFiscal' + IntToStrZero(i, 3);
    LFim := AINIRec.ReadString(LSecao, 'Numero', 'FIM');

    if (LFim = 'FIM') or (Trim(LFim) = '') then
      break;

    LNotaFiscal := ANotaFiscalCollection.New;

    LNotaFiscal.Numero := LFim;
    LNotaFiscal.Serie := AINIRec.ReadString(LSecao, 'Serie', '');
    LNotaFiscal.QuantidadeDaMercadoriaNoDesembarque := AINIRec.ReadFloat(LSecao, 'QuantidadeDaMercadoriaNoDesembarque', 0);

    Inc(i);
  end;
end;

procedure TCIOTIniReader.Ler_ObservacoesAoCredenciado(AINIRec: TMemIniFile; AObservacoesAoCredenciado: TMensagemCollection);
var
  LSecao: string;
  i: Integer;
  LFim: string;
  LItem: string;
  LMensagem: TMensagemCollectionItem;
begin
  i := 1;
  while true do
  begin
    LItem := IntToStrZero(i, 3);
    LSecao := 'ObservacoesAoCredenciado' + LItem;
    LFim := AINIRec.ReadString(LSecao, 'Mensagem', 'FIM');

    if (LFim = 'FIM') or (Trim(LFim) = '') then
      break;

    LMensagem := AObservacoesAoCredenciado.New;

    LMensagem.Mensagem := LFim;

    Inc(i);
  end;
end;

procedure TCIOTIniReader.Ler_ObservacoesAoTransportador(AINIRec: TMemIniFile; AObservacoesAoTransportador: TMensagemCollection);
var
  LSecao: string;
  i: Integer;
  LFim: string;
  LItem: string;
  LMensagem: TMensagemCollectionItem;
begin
  i := 1;
  while true do
  begin
    LItem := IntToStrZero(i, 3);
    LSecao := 'ObservacoesAoTransportador' + LItem;
    LFim := AINIRec.ReadString(LSecao, 'Mensagem', 'FIM');

    if (LFim = 'FIM') or (Trim(LFim) = '') then
      break;

    LMensagem := AObservacoesAoTransportador.New;

    LMensagem.Mensagem := LFim;

    Inc(i);
  end;
end;

procedure TCIOTIniReader.Ler_Pagamentos(AINIRec: TMemIniFile; APagamentoCollection: TPagamentoCollection);
var
  LSecao: string;
  ok: boolean;
  i: Integer;
  LPagamento: TPagamentoCollectionItem;
  LFim: string;
begin
  i := 1;
  while true do
  begin
    LSecao := 'Pagamento' + IntToStrZero(i, 3);
    LFim := AINIRec.ReadString(LSecao, 'IdPagamentoCliente', 'FIM');

    if (LFim = 'FIM') or (Trim(LFim) = '') then
      break;

    LPagamento := APagamentoCollection.New;

    LPagamento.IdPagamentoCliente := LFim;

    LPagamento.DataDeLiberacao := StringToDateTime(AINIRec.ReadString(LSecao, 'DataDeLiberacao', '0'));
    LPagamento.Valor := AINIRec.ReadFloat(LSecao, 'Valor', 0);
    LPagamento.TipoPagamento := EnumStrToTpTipoPagamento(ok, AINIRec.ReadString(LSecao, 'TipoPagamento', '1'));
    LPagamento.Categoria := EnumStrToTpTipoCategoriaPagamento(ok, AINIRec.ReadString(LSecao, 'Categoria', '1'));
    LPagamento.Documento := AINIRec.ReadString(LSecao, 'Documento', '');
    LPagamento.IndicadorPagamento := AINIRec.ReadString(LSecao, 'IndicadorPagamento', '');
    LPagamento.CpfCnpjCreditado := AINIRec.ReadString(LSecao, 'CpfCnpjCreditado', '');
    LPagamento.NumeroParcela := AINIRec.ReadInteger(LSecao, 'NumeroParcela', 0);
    LPagamento.CodigoPagamento := AINIRec.ReadString(LSecao, 'CodigoPagamento', '');

    Ler_InformacoesBancarias(AINIRec, LPagamento.InformacoesBancarias, LSecao);

    LPagamento.InformacaoAdicional := AINIRec.ReadString(LSecao, 'InformacaoAdicional', '');
    LPagamento.TipoChavePix := AINIRec.ReadString(LSecao, 'TipoChavePix', '');
    LPagamento.ValorChavePix := AINIRec.ReadString(LSecao, 'ValorChavePix', '');
    LPagamento.IdentificadorPix := AINIRec.ReadString(LSecao, 'IdentificadorPix', '');
    LPagamento.CnpjFilialAbastecimento := AINIRec.ReadString(LSecao, 'CnpjFilialAbastecimento', '');

    Inc(i);
  end;
end;

procedure TCIOTIniReader.Ler_Pessoa(AINIRec: TMemIniFile; ASecao: string; APessoa: TPessoa);
var
  LSecao: string;
begin
  LSecao := ASecao;

  APessoa.NomeOuRazaoSocial := AINIRec.ReadString(LSecao, 'NomeOuRazaoSocial', '');
  APessoa.CpfOuCnpj := AINIRec.ReadString(LSecao, 'CpfOuCnpj', '');
  APessoa.Endereco.Bairro := AINIRec.ReadString(LSecao, 'Bairro', '');
  APessoa.Endereco.Rua := AINIRec.ReadString(LSecao, 'Rua', '');
  APessoa.Endereco.Numero := AINIRec.ReadString(LSecao, 'Numero', '');
  APessoa.Endereco.Complemento := AINIRec.ReadString(LSecao, 'Complemento', '');
  APessoa.Endereco.CEP := AINIRec.ReadString(LSecao, 'CEP', '');
  APessoa.Endereco.CodigoMunicipio := AINIRec.ReadInteger(LSecao, 'CodigoMunicipio', 0);
  APessoa.EMail := AINIRec.ReadString(LSecao, 'EMail', '');
  APessoa.Telefones.Celular.DDD := AINIRec.ReadInteger(LSecao, 'Celular.DDD', 0);
  APessoa.Telefones.Celular.Numero := AINIRec.ReadInteger(LSecao, 'Celular.Numero', 0);
  APessoa.Telefones.Fixo.DDD := AINIRec.ReadInteger(LSecao, 'Fixo.DDD', 0);
  APessoa.Telefones.Fixo.Numero := AINIRec.ReadInteger(LSecao, 'Fixo.Numero', 0);
  APessoa.Telefones.Fax.DDD := AINIRec.ReadInteger(LSecao, 'Fax.DDD', 0);
  APessoa.Telefones.Fax.Numero := AINIRec.ReadInteger(LSecao, 'Fax.Numero', 0);
end;

procedure TCIOTIniReader.Ler_ProprietarioCarga(AINIRec: TMemIniFile);
var
  LSecao: string;
begin
  LSecao := 'ProprietarioCarga';

  Ler_Responsavel(AINIRec, LSecao, FCIOT.AdicionarOperacao.ProprietarioCarga);

  FCIOT.AdicionarOperacao.ProprietarioCarga.RNTRC := AINIRec.ReadString(LSecao, 'RNTRC', '');
end;

procedure TCIOTIniReader.Ler_Remetente(AINIRec: TMemIniFile);
var
  LSecao: string;
begin
  LSecao := 'Remetente';

  Ler_Responsavel(AINIRec, LSecao, FCIOT.AdicionarOperacao.Remetente);
end;

procedure TCIOTIniReader.Ler_Responsavel(AINIRec: TMemIniFile; ASecao: string; APessoa: TPessoa);
var
  LSecao: string;
begin
  LSecao := ASecao;

  Ler_Pessoa(AINIRec, ASecao, APessoa);

  APessoa.ResponsavelPeloPagamento := Boolean(StrToIntDef(AINIRec.ReadString(LSecao, 'ResponsavelPeloPagamento', '0'), 0));
end;

procedure TCIOTIniReader.Ler_SubContratante(AINIRec: TMemIniFile);
var
  LSecao: string;
begin
  LSecao := 'SubContratante';

  Ler_Responsavel(AINIRec, LSecao, FCIOT.AdicionarOperacao.SubContratante);
end;

procedure TCIOTIniReader.Ler_TomadorServico(AINIRec: TMemIniFile);
var
  LSecao: string;
begin
  LSecao := 'TomadorServico';

  Ler_Responsavel(AINIRec, LSecao, FCIOT.AdicionarOperacao.TomadorServico);
end;

procedure TCIOTIniReader.Ler_Veiculos(AINIRec: TMemIniFile; AVeiculoCollection: TVeiculoCollection);
var
  LSecao: string;
  i: Integer;
  LFim: string;
  LItem: string;
  LVeiculo: TVeiculoCollectionItem;
begin
  i := 1;
  while true do
  begin
    LItem := IntToStrZero(i, 1);
    LSecao := 'Veiculo' + LItem;
    LFim := AINIRec.ReadString(LSecao, 'Placa', 'FIM');

    if (LFim = 'FIM') or (Trim(LFim) = '') then
      break;

    LVeiculo := AVeiculoCollection.New;

    LVeiculo.Placa := LFim;

    Inc(i);
  end;
end;

procedure TCIOTIniReader.Ler_Viagem(AINIRec: TMemIniFile; AViagemCollection: TViagemCollection);
var
  LSecao: string;
  i: Integer;
  LViagem: TViagemCollectionItem;
  LFim: string;
  LItemViagem: string;
begin
  i := 1;
  while true do
  begin
    LItemViagem := IntToStrZero(i, 3);
    LSecao := 'Viagem' + LItemViagem;
    LFim := AINIRec.ReadString(LSecao, 'DocumentoViagem', 'FIM');

    if (LFim = 'FIM') or (Trim(LFim) = '') then
      break;

    LViagem := AViagemCollection.New;

    LViagem.DocumentoViagem := LFim;
    LViagem.CodigoMunicipioOrigem := AINIRec.ReadInteger(LSecao, 'CodigoMunicipioOrigem', 0);
    LViagem.CodigoMunicipioDestino := AINIRec.ReadInteger(LSecao, 'CodigoMunicipioDestino', 0);
    LViagem.CepOrigem := AINIRec.ReadString(LSecao, 'CepOrigem', '');
    LViagem.CepDestino := AINIRec.ReadString(LSecao, 'CepDestino', '');
    LViagem.DistanciaPercorrida := AINIRec.ReadInteger(LSecao, 'DistanciaPercorrida', 0);
    LViagem.LatitudeOrigem := AINIRec.ReadFloat(LSecao, 'LatitudeOrigem', 0);
    LViagem.LongitudeOrigem := AINIRec.ReadFloat(LSecao, 'LongitudeOrigem', 0);
    LViagem.LatitudeDestino := AINIRec.ReadFloat(LSecao, 'LatitudeDestino', 0);
    LViagem.LongitudeDestino := AINIRec.ReadFloat(LSecao, 'LongitudeDestino', 0);

    LViagem.Valores.TotalOperacao := AINIRec.ReadFloat(LSecao, 'TotalOperacao', 0);
    LViagem.Valores.TotalViagem := AINIRec.ReadFloat(LSecao, 'TotalViagem', 0);
    LViagem.Valores.TotalDeAdiantamento := AINIRec.ReadFloat(LSecao, 'TotalDeAdiantamento', 0);
    LViagem.Valores.TotalDeQuitacao := AINIRec.ReadFloat(LSecao, 'TotalDeQuitacao', 0);
    LViagem.Valores.Combustivel := AINIRec.ReadFloat(LSecao, 'Combustivel', 0);
    LViagem.Valores.Pedagio := AINIRec.ReadFloat(LSecao, 'Pedagio', 0);
    LViagem.Valores.OutrosCreditos := AINIRec.ReadFloat(LSecao, 'OutrosCreditos', 0);
    LViagem.Valores.JustificativaOutrosCreditos := AINIRec.ReadString(LSecao, 'JustificativaOutrosCreditos', '');
    LViagem.Valores.Seguro := AINIRec.ReadFloat(LSecao, 'Seguro', 0);
    LViagem.Valores.OutrosDebitos := AINIRec.ReadFloat(LSecao, 'OutrosDebitos', 0);
    LViagem.Valores.JustificativaOutrosDebitos := AINIRec.ReadString(LSecao, 'JustificativaOutrosDebitos', '');

    Ler_InformacoesBancarias(AINIRec, LViagem.InformacoesBancarias, LSecao);
    Ler_NotaFiscal(AINIRec, LViagem.NotasFiscais, LItemVIagem);

    Inc(i);
  end;
end;

end.
