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

unit ACBrCIOTIniWriter;

interface

uses
  Classes,
  SysUtils,
  TypInfo,
  IniFiles,
  ACBrCIOTConversao,
  pcnCIOT;

type
  { TCIOTIniWriter }

  TCIOTIniWriter = class
  private
    FCIOT: TCIOT;

    procedure Gerar_GravarAdicionarPagamento(AINIRec: TMemIniFile);
    procedure Gerar_GravarAdicionarOperacao(AINIRec: TMemIniFile);
    procedure Gerar_GravarAdicionarViagem(AINIRec: TMemIniFile);
    procedure Gerar_GravarAlterarDataLiberacaoPagamento(AINIRec: TMemIniFile);
    procedure Gerar_GravarCancelarOperacao(AINIRec: TMemIniFile);
    procedure Gerar_GravarCancelarPagamento(AINIRec: TMemIniFile);
    procedure Gerar_GravarEncerrarOperacao(AINIRec: TMemIniFile);
    procedure Gerar_GravarMotorista(AINIRec: TMemIniFile);
    procedure Gerar_GravarObterCIOT(AINIRec: TMemIniFile);
    procedure Gerar_GravarObterPdf(AINIRec: TMemIniFile);
    procedure Gerar_GravarProprietario(AINIRec: TMemIniFile);
    procedure Gerar_GravarRegistrarPagamentoQuitacao(AINIRec: TMemIniFile);
    procedure Gerar_GravarRegistrarQtdeMercadoriaDesembarque(AINIRec: TMemIniFile);
    procedure Gerar_GravarRetificarOperacao(AINIRec: TMemIniFile);
    procedure Gerar_GravarVeiculo(AINIRec: TMemIniFile);

    procedure Gerar_Consignatario(AINIRec: TMemIniFile);
    procedure Gerar_Contratado(AINIRec: TMemIniFile);
    procedure Gerar_Contratante(AINIRec: TMemIniFile);
    procedure Gerar_ContratantesCargaFracionada(AINIRec: TMemIniFile; APessoaCollection: TPessoaCollection);
    procedure Gerar_Destinatario(AINIRec: TMemIniFile);
    procedure Gerar_Impostos(AINIRec: TMemIniFile; AImpostos: TImpostos);
    procedure Gerar_InformacoesBancarias(AINIRec: TMemIniFile; AInformacoesBancarias: TInformacoesBancarias; ASecao: String);
    procedure Gerar_Login(AINIRec: TMemIniFile);
    procedure Gerar_Logout(AINIRec: TMemIniFile);
    procedure Gerar_Motorista(AINIRec: TMemIniFile);
    procedure Gerar_NotaFiscal(AINIRec: TMemIniFile; ANotaFiscalCollection: TNotaFiscalCollection; item: string);
    procedure Gerar_NotaFiscalDesembarque(AINIRec: TMemIniFile; ANotaFiscalCollection: TNotaFiscalCollection);
    procedure Gerar_ObservacoesAoCredenciado(AINIRec: TMemIniFile; AObservacoesAoCredenciado: TMensagemCollection);
    procedure Gerar_ObservacoesAoTransportador(AINIRec: TMemIniFile; AObservacoesAoTransportador: TMensagemCollection);
    procedure Gerar_Pagamentos(AINIRec: TMemIniFile; APagamentoCollection: TPagamentoCollection);
    procedure Gerar_Pessoa(AINIRec: TMemIniFile; ASecao: string; APessoa: TPessoa);
    procedure Gerar_ProprietarioCarga(AINIRec: TMemIniFile);
    procedure Gerar_Remetente(AINIRec: TMemIniFile);
    procedure Gerar_Responsavel(AINIRec: TMemIniFile; ASecao: string; APessoa: TPessoa);
    procedure Gerar_SubContratante(AINIRec: TMemIniFile);
    procedure Gerar_TomadorServico(AINIRec: TMemIniFile);
    procedure Gerar_Veiculos(AINIRec: TMemIniFile; AVeiculoCollection: TVeiculoCollection);
    procedure Gerar_Viagem(AINIRec: TMemIniFile; AViagemCollection: TViagemCollection);
  public
    constructor Create(AOwner: TCIOT); reintroduce;

    function GravarIni: string;

    property CIOT: TCIOT read FCIOT write FCIOT;
  end;

implementation

uses
  ACBrUtil.Base;

{ TCIOTIniWriter }

constructor TCIOTIniWriter.Create(AOwner: TCIOT);
begin
  inherited Create;

  FCIOT := AOwner;
end;

procedure TCIOTIniWriter.Gerar_Destinatario(AINIRec: TMemIniFile);
var
  LSecao: string;
begin
  LSecao := 'Destinatario';

  Gerar_Pessoa(AINIRec, LSecao, FCIOT.AdicionarOperacao.Destinatario);
end;

procedure TCIOTIniWriter.Gerar_Consignatario(AINIRec: TMemIniFile);
var
  LSecao: string;
begin
  LSecao := 'Consignatario';

  Gerar_Responsavel(AINIRec, LSecao, FCIOT.AdicionarOperacao.Consignatario);
end;

procedure TCIOTIniWriter.Gerar_Contratado(AINIRec: TMemIniFile);
var
  LSecao: string;
begin
  LSecao := 'Contratado';

  AINIRec.WriteString(LSecao, 'CpfOuCnpj', FCIOT.AdicionarOperacao.Contratado.CpfOuCnpj);
  AINIRec.WriteString(LSecao, 'RNTRC', FCIOT.AdicionarOperacao.Contratado.RNTRC);
end;

procedure TCIOTIniWriter.Gerar_Contratante(AINIRec: TMemIniFile);
var
  LSecao: string;
begin
  LSecao := 'Contratante';

  Gerar_Responsavel(AINIRec, LSecao, FCIOT.AdicionarOperacao.Contratante);

  AINIRec.WriteString(LSecao, 'RNTRC', FCIOT.AdicionarOperacao.Contratante.RNTRC);
end;

procedure TCIOTIniWriter.Gerar_ContratantesCargaFracionada(AINIRec: TMemIniFile; APessoaCollection: TPessoaCollection);
var
  LSecao: string;
  i: Integer;
  LItem: string;
begin
  for i:=0 to APessoaCollection.Count - 1 do
  begin
    LItem := IntToStrZero(i+1, 3);
    LSecao := 'ContratantesCargaFracionada' + LItem;

    AINIRec.WriteString(LSecao, 'CpfOuCnpj', APessoaCollection[i].CpfOuCnpj);
  end;
end;

procedure TCIOTIniWriter.Gerar_GravarAdicionarPagamento(AINIRec: TMemIniFile);
var
  LSecao: string;
begin
  LSecao := TpOperacaoToNome(FCIOT.Integradora.Operacao);

  AINIRec.WriteString(LSecao, 'CodigoIdentificacaoOperacao', FCIOT.AdicionarPagamento.CodigoIdentificacaoOperacao);

  Gerar_Pagamentos(AINIRec, FCIOT.AdicionarPagamento.Pagamentos);
end;

procedure TCIOTIniWriter.Gerar_GravarAdicionarOperacao(AINIRec: TMemIniFile);
var
  LSecao: string;
begin
  LSecao := TpOperacaoToNome(FCIOT.Integradora.Operacao);

  AINIRec.WriteString(LSecao, 'TipoViagem', TpTipoViagemToEnumStr(FCIOT.AdicionarOperacao.TipoViagem));
  AINIRec.WriteString(LSecao, 'TipoPagamento', TpTipoPagamentoToEnumStr(FCIOT.AdicionarOperacao.TipoPagamento));
  AINIRec.WriteString(LSecao, 'BloquearNaoEquiparado', IntToStr(Integer(FCIOT.AdicionarOperacao.BloquearNaoEquiparado)));
  AINIRec.WriteString(LSecao, 'MatrizCNPJ', FCIOT.AdicionarOperacao.MatrizCNPJ);
  AINIRec.WriteString(LSecao, 'FilialCNPJ', FCIOT.AdicionarOperacao.FilialCNPJ);
  AINIRec.WriteString(LSecao, 'IdOperacaoCliente', FCIOT.AdicionarOperacao.IdOperacaoCliente);
  AINIRec.WriteString(LSecao, 'DataInicioViagem', DateToStr(FCIOT.AdicionarOperacao.DataInicioViagem));
  AINIRec.WriteString(LSecao, 'DataFimViagem', DateToStr(FCIOT.AdicionarOperacao.DataFimViagem));
  AINIRec.WriteInteger(LSecao, 'CodigoNCMNaturezaCarga', FCIOT.AdicionarOperacao.CodigoNCMNaturezaCarga);
  AINIRec.WriteFloat(LSecao, 'PesoCarga', FCIOT.AdicionarOperacao.PesoCarga);
  AINIRec.WriteString(LSecao, 'TipoEmbalagem', tpTipoEmbalagemToEnumStr(FCIOT.AdicionarOperacao.TipoEmbalagem));
  AINIRec.WriteString(LSecao, 'CodigoIdentificacaoOperacaoPrincipal', FCIOT.AdicionarOperacao.CodigoIdentificacaoOperacaoPrincipal);
  AINIRec.WriteString(LSecao, 'EntregaDocumentacao', TpEntregaDocumentacaoToEnumStr(FCIOT.AdicionarOperacao.EntregaDocumentacao));
  AINIRec.WriteInteger(LSecao, 'QuantidadeSaques', FCIOT.AdicionarOperacao.QuantidadeSaques);
  AINIRec.WriteInteger(LSecao, 'QuantidadeTransferencias', FCIOT.AdicionarOperacao.QuantidadeTransferencias);
  AINIRec.WriteFloat(LSecao, 'ValorSaques', FCIOT.AdicionarOperacao.ValorSaques);
  AINIRec.WriteFloat(LSecao, 'ValorTransferencias', FCIOT.AdicionarOperacao.ValorTransferencias);
  AINIRec.WriteString(LSecao, 'CodigoTipoCarga', tpTipoCargaToEnumStr(FCIOT.AdicionarOperacao.CodigoTipoCarga));
  AINIRec.WriteString(LSecao, 'AltoDesempenho', IntToStr(Integer(FCIOT.AdicionarOperacao.AltoDesempenho)));
  AINIRec.WriteString(LSecao, 'ComposicaoVeicular', IntToStr(Integer(FCIOT.AdicionarOperacao.ComposicaoVeicular)));
  AINIRec.WriteString(LSecao, 'RetornoVazio', IntToStr(Integer(FCIOT.AdicionarOperacao.RetornoVazio)));

  Gerar_Viagem(AINIRec, FCIOT.AdicionarOperacao.Viagens);
  Gerar_Impostos(AINIRec, FCIOT.AdicionarOperacao.Impostos);
  Gerar_Pagamentos(AINIRec, FCIOT.AdicionarOperacao.Pagamentos);
  Gerar_Contratado(AINIRec);
  Gerar_Motorista(AINIRec);
  Gerar_Destinatario(AINIRec);
  Gerar_Contratante(AINIRec);
  Gerar_SubContratante(AINIRec);
  Gerar_Consignatario(AINIRec);
  Gerar_TomadorServico(AINIRec);
  Gerar_Remetente(AINIRec);
  Gerar_ProprietarioCarga(AINIRec);
  Gerar_Veiculos(AINIRec, FCIOT.AdicionarOperacao.Veiculos);
  Gerar_ContratantesCargaFracionada(AINIRec, FCIOT.AdicionarOperacao.ContratantesCargaFracionada);
  Gerar_ObservacoesAoTransportador(AINIRec, FCIOT.AdicionarOperacao.ObservacoesAoTransportador);
  Gerar_ObservacoesAoCredenciado(AINIRec, FCIOT.AdicionarOperacao.ObservacoesAoCredenciado);
end;

procedure TCIOTIniWriter.Gerar_GravarAdicionarViagem(AINIRec: TMemIniFile);
var
  LSecao: string;
begin
  LSecao := TpOperacaoToNome(FCIOT.Integradora.Operacao);

  AINIRec.WriteString(LSecao, 'CodigoIdentificacaoOperacao', FCIOT.AdicionarViagem.CodigoIdentificacaoOperacao);
  AINIRec.WriteString(LSecao, 'NaoAdicionarParcialmente', IntToStr(Integer(FCIOT.AdicionarViagem.NaoAdicionarParcialmente)));

  Gerar_Viagem(AINIRec, FCIOT.AdicionarViagem.Viagens);
  Gerar_Pagamentos(AINIRec, FCIOT.AdicionarViagem.Pagamentos);
end;

procedure TCIOTIniWriter.Gerar_GravarAlterarDataLiberacaoPagamento(AINIRec: TMemIniFile);
var
  LSecao: string;
begin
  LSecao := TpOperacaoToNome(FCIOT.Integradora.Operacao);

  AINIRec.WriteString(LSecao, 'CodigoIdentificacaoOperacao', FCIOT.AlterarDataLiberacaoPagamento.CodigoIdentificacaoOperacao);
  AINIRec.WriteString(LSecao, 'IdPagamentoCliente', FCIOT.AlterarDataLiberacaoPagamento.IdPagamentoCliente);
  AINIRec.WriteString(LSecao, 'DataDeLiberacao', DateToStr(FCIOT.AlterarDataLiberacaoPagamento.DataDeLiberacao));
  AINIRec.WriteString(LSecao, 'Motivo', FCIOT.AlterarDataLiberacaoPagamento.Motivo);
end;

procedure TCIOTIniWriter.Gerar_GravarCancelarOperacao(AINIRec: TMemIniFile);
var
  LSecao: string;
begin
  LSecao := TpOperacaoToNome(FCIOT.Integradora.Operacao);

  AINIRec.WriteString(LSecao, 'CodigoIdentificacaoOperacao', FCIOT.CancelarOperacao.CodigoIdentificacaoOperacao);
  AINIRec.WriteString(LSecao, 'Motivo', FCIOT.CancelarOperacao.Motivo);
end;

procedure TCIOTIniWriter.Gerar_GravarCancelarPagamento(AINIRec: TMemIniFile);
var
  LSecao: string;
begin
  LSecao := TpOperacaoToNome(FCIOT.Integradora.Operacao);

  AINIRec.WriteString(LSecao, 'CodigoIdentificacaoOperacao', FCIOT.CancelarPagamento.CodigoIdentificacaoOperacao);
  AINIRec.WriteString(LSecao, 'IdPagamentoCliente', FCIOT.CancelarPagamento.IdPagamentoCliente);
  AINIRec.WriteString(LSecao, 'Motivo', FCIOT.CancelarPagamento.Motivo);
end;

procedure TCIOTIniWriter.Gerar_GravarEncerrarOperacao(AINIRec: TMemIniFile);
var
  LSecao: string;
begin
  LSecao := TpOperacaoToNome(FCIOT.Integradora.Operacao);

  AINIRec.WriteString(LSecao, 'CodigoIdentificacaoOperacao', FCIOT.EncerrarOperacao.CodigoIdentificacaoOperacao);
  AINIRec.WriteFloat(LSecao, 'PesoCarga', FCIOT.EncerrarOperacao.PesoCarga);
  AINIRec.WriteInteger(LSecao, 'QuantidadeSaques', FCIOT.EncerrarOperacao.QuantidadeSaques);
  AINIRec.WriteInteger(LSecao, 'QuantidadeTransferencias', FCIOT.EncerrarOperacao.QuantidadeTransferencias);

  Gerar_Viagem(AINIRec, FCIOT.EncerrarOperacao.Viagens);
  Gerar_Pagamentos(AINIRec, FCIOT.EncerrarOperacao.Pagamentos);
  Gerar_Impostos(AINIRec, FCIOT.EncerrarOperacao.Impostos);
end;

procedure TCIOTIniWriter.Gerar_GravarMotorista(AINIRec: TMemIniFile);
var
  LSecao: string;
begin
  LSecao := TpOperacaoToNome(FCIOT.Integradora.Operacao);

  AINIRec.WriteString(LSecao, 'CPF', FCIOT.GravarMotorista.CPF);
  AINIRec.WriteString(LSecao, 'Nome', FCIOT.GravarMotorista.Nome);
  AINIRec.WriteString(LSecao, 'CNH', FCIOT.GravarMotorista.CNH);
  AINIRec.WriteString(LSecao, 'DataNascimento', DateToStr(FCIOT.GravarMotorista.DataNascimento));
  AINIRec.WriteString(LSecao, 'NomeDeSolteiraDaMae', FCIOT.GravarMotorista.NomeDeSolteiraDaMae);
  AINIRec.WriteString(LSecao, 'Endereco.Bairro', FCIOT.GravarMotorista.Endereco.Bairro);
  AINIRec.WriteString(LSecao, 'Endereco.Rua', FCIOT.GravarMotorista.Endereco.Rua);
  AINIRec.WriteString(LSecao, 'Endereco.Numero', FCIOT.GravarMotorista.Endereco.Numero);
  AINIRec.WriteString(LSecao, 'Endereco.Complemento', FCIOT.GravarMotorista.Endereco.Complemento);
  AINIRec.WriteString(LSecao, 'Endereco.CEP', FCIOT.GravarMotorista.Endereco.CEP);
  AINIRec.WriteInteger(LSecao, 'Endereco.CodigoMunicipio', FCIOT.GravarMotorista.Endereco.CodigoMunicipio);
  AINIRec.WriteInteger(LSecao, 'Telefones.Celular.DDD', FCIOT.GravarMotorista.Telefones.Celular.DDD);
  AINIRec.WriteInteger(LSecao, 'Telefones.Celular.Numero', FCIOT.GravarMotorista.Telefones.Celular.Numero);
  AINIRec.WriteInteger(LSecao, 'Telefones.Fixo.DDD', FCIOT.GravarMotorista.Telefones.Fixo.DDD);
  AINIRec.WriteInteger(LSecao, 'Telefones.Fixo.Numero', FCIOT.GravarMotorista.Telefones.Fixo.Numero);
  AINIRec.WriteInteger(LSecao, 'Telefones.Fax.DDD', FCIOT.GravarMotorista.Telefones.Fax.DDD);
  AINIRec.WriteInteger(LSecao, 'Telefones.Fax.Numero', FCIOT.GravarMotorista.Telefones.Fax.Numero);
end;

procedure TCIOTIniWriter.Gerar_GravarObterCIOT(AINIRec: TMemIniFile);
var
  LSecao: string;
begin
  LSecao := TpOperacaoToNome(FCIOT.Integradora.Operacao);

  AINIRec.WriteString(LSecao, 'MatrizCNPJ', FCIOT.ObterCodigoOperacaoTransporte.MatrizCNPJ);
  AINIRec.WriteString(LSecao, 'IdOperacaoCliente', FCIOT.ObterCodigoOperacaoTransporte.IdOperacaoCliente);
end;

procedure TCIOTIniWriter.Gerar_GravarObterPdf(AINIRec: TMemIniFile);
var
  LSecao: string;
begin
  LSecao := TpOperacaoToNome(FCIOT.Integradora.Operacao);

  AINIRec.WriteString(LSecao, 'CodigoIdentificacaoOperacao', FCIOT.ObterOperacaoTransportePDF.CodigoIdentificacaoOperacao);
  AINIRec.WriteString(LSecao, 'DocumentoViagem', FCIOT.ObterOperacaoTransportePDF.DocumentoViagem);
end;

procedure TCIOTIniWriter.Gerar_GravarProprietario(AINIRec: TMemIniFile);
var
  LSecao: string;
begin
  LSecao := TpOperacaoToNome(FCIOT.Integradora.Operacao);

  AINIRec.WriteString(LSecao, 'CNPJ', FCIOT.GravarProprietario.CNPJ);
  AINIRec.WriteString(LSecao, 'TipoPessoa', tpTipoPessoaToEnumStr(FCIOT.GravarProprietario.TipoPessoa));
  AINIRec.WriteString(LSecao, 'RazaoSocial', FCIOT.GravarProprietario.RazaoSocial);
  AINIRec.WriteString(LSecao, 'RNTRC', FCIOT.GravarProprietario.RNTRC);

  AINIRec.WriteString(LSecao, 'Bairro', FCIOT.GravarProprietario.Endereco.Bairro);
  AINIRec.WriteString(LSecao, 'Rua', FCIOT.GravarProprietario.Endereco.Rua);
  AINIRec.WriteString(LSecao, 'Numero', FCIOT.GravarProprietario.Endereco.Numero);
  AINIRec.WriteString(LSecao, 'Complemento', FCIOT.GravarProprietario.Endereco.Complemento);
  AINIRec.WriteString(LSecao, 'CEP', FCIOT.GravarProprietario.Endereco.CEP);
  AINIRec.WriteInteger(LSecao, 'CodigoMunicipio', FCIOT.GravarProprietario.Endereco.CodigoMunicipio);

  AINIRec.WriteInteger(LSecao, 'Celular.DDD', FCIOT.GravarProprietario.Telefones.Celular.DDD);
  AINIRec.WriteInteger(LSecao, 'Celular.Numero', FCIOT.GravarProprietario.Telefones.Celular.Numero);

  AINIRec.WriteInteger(LSecao, 'Fixo.DDD', FCIOT.GravarProprietario.Telefones.Fixo.DDD);
  AINIRec.WriteInteger(LSecao, 'Fixo.Numero', FCIOT.GravarProprietario.Telefones.Fixo.Numero);

  AINIRec.WriteInteger(LSecao, 'Fax.DDD', FCIOT.GravarProprietario.Telefones.Fax.DDD);
  AINIRec.WriteInteger(LSecao, 'Fax.Numero', FCIOT.GravarProprietario.Telefones.Fax.Numero);
end;

procedure TCIOTIniWriter.Gerar_GravarRetificarOperacao(AINIRec: TMemIniFile);
var
  LSecao: string;
begin
  LSecao := TpOperacaoToNome(FCIOT.Integradora.Operacao);

  AINIRec.WriteString(LSecao, 'CodigoIdentificacaoOperacao', FCIOT.RetificarOperacao.CodigoIdentificacaoOperacao);
  AINIRec.WriteString(LSecao, 'DataInicioViagem', DateToStr(FCIOT.RetificarOperacao.DataInicioViagem));
  AINIRec.WriteString(LSecao, 'DataFimViagem', DateToStr(FCIOT.RetificarOperacao.DataFimViagem));
  AINIRec.WriteInteger(LSecao, 'CodigoNCMNaturezaCarga', FCIOT.RetificarOperacao.CodigoNCMNaturezaCarga);
  AINIRec.WriteFloat(LSecao, 'PesoCarga', FCIOT.RetificarOperacao.PesoCarga);
  AINIRec.WriteInteger(LSecao, 'CodigoMunicipioOrigem', FCIOT.RetificarOperacao.CodigoMunicipioOrigem);
  AINIRec.WriteInteger(LSecao, 'CodigoMunicipioDestino', FCIOT.RetificarOperacao.CodigoMunicipioDestino);
  AINIRec.WriteInteger(LSecao, 'QuantidadeSaques', FCIOT.RetificarOperacao.QuantidadeSaques);
  AINIRec.WriteInteger(LSecao, 'QuantidadeTransferencias', FCIOT.RetificarOperacao.QuantidadeTransferencias);
  AINIRec.WriteFloat(LSecao, 'ValorSaques', FCIOT.RetificarOperacao.ValorSaques);
  AINIRec.WriteFloat(LSecao, 'ValorTransferencias', FCIOT.RetificarOperacao.ValorTransferencias);
  AINIRec.WriteString(LSecao, 'CodigoTipoCarga', tpTipoCargaToEnumStr(FCIOT.RetificarOperacao.CodigoTipoCarga));
  AINIRec.WriteString(LSecao, 'CepOrigem', FCIOT.RetificarOperacao.CepOrigem);
  AINIRec.WriteString(LSecao, 'CepDestino', FCIOT.RetificarOperacao.CepDestino);
  AINIRec.WriteInteger(LSecao, 'DistanciaPercorrida', FCIOT.RetificarOperacao.DistanciaPercorrida);

  Gerar_Veiculos(AINIRec, FCIOT.RetificarOperacao.Veiculos);
end;

procedure TCIOTIniWriter.Gerar_GravarVeiculo(AINIRec: TMemIniFile);
var
  LSecao: string;
begin
  LSecao := TpOperacaoToNome(FCIOT.Integradora.Operacao);

  AINIRec.WriteString(LSecao, 'Placa', FCIOT.GravarVeiculo.Placa);
  AINIRec.WriteString(LSecao, 'Renavam', FCIOT.GravarVeiculo.Renavam);
  AINIRec.WriteString(LSecao, 'Chassi', FCIOT.GravarVeiculo.Chassi);
  AINIRec.WriteString(LSecao, 'RNTRC', FCIOT.GravarVeiculo.RNTRC);
  AINIRec.WriteInteger(LSecao, 'NumeroDeEixos', FCIOT.GravarVeiculo.NumeroDeEixos);
  AINIRec.WriteInteger(LSecao, 'CodigoMunicipio', FCIOT.GravarVeiculo.CodigoMunicipio);
  AINIRec.WriteString(LSecao, 'Marca', FCIOT.GravarVeiculo.Marca);
  AINIRec.WriteString(LSecao, 'Modelo', FCIOT.GravarVeiculo.Modelo);
  AINIRec.WriteInteger(LSecao, 'AnoFabricacao', FCIOT.GravarVeiculo.AnoFabricacao);
  AINIRec.WriteInteger(LSecao, 'AnoModelo', FCIOT.GravarVeiculo.AnoModelo);
  AINIRec.WriteString(LSecao, 'Cor', FCIOT.GravarVeiculo.Cor);
  AINIRec.WriteInteger(LSecao, 'Tara', FCIOT.GravarVeiculo.Tara);
  AINIRec.WriteInteger(LSecao, 'CapacidadeKg', FCIOT.GravarVeiculo.CapacidadeKg);
  AINIRec.WriteInteger(LSecao, 'CapacidadeM3', FCIOT.GravarVeiculo.CapacidadeM3);
  AINIRec.WriteString(LSecao, 'TipoRodado', TpTipoRodadoToEnumStr(FCIOT.GravarVeiculo.TipoRodado));
  AINIRec.WriteString(LSecao, 'TipoCarroceria', TpTipoCarroceriaToEnumStr(FCIOT.GravarVeiculo.TipoCarroceria));
end;

procedure TCIOTIniWriter.Gerar_Impostos(AINIRec: TMemIniFile; AImpostos: TImpostos);
var
  LSecao: string;
begin
  LSecao := 'Impostos';

  AINIRec.WriteFloat(LSecao, 'IRRF', AImpostos.IRRF);
  AINIRec.WriteFloat(LSecao, 'SestSenat', AImpostos.SestSenat);
  AINIRec.WriteFloat(LSecao, 'INSS', AImpostos.INSS);
  AINIRec.WriteFloat(LSecao, 'ISSQN', AImpostos.ISSQN);
  AINIRec.WriteFloat(LSecao, 'OutrosImpostos', AImpostos.OutrosImpostos);
  AINIRec.WriteString(LSecao, 'DescricaoOutrosImpostos', AImpostos.DescricaoOutrosImpostos);
end;

procedure TCIOTIniWriter.Gerar_InformacoesBancarias(AINIRec: TMemIniFile; AInformacoesBancarias: TInformacoesBancarias; ASecao: String);
begin
  AINIRec.WriteString(ASecao, 'InstituicaoBancaria', AInformacoesBancarias.InstituicaoBancaria);
  AINIRec.WriteString(ASecao, 'Agencia', AInformacoesBancarias.Agencia);
  AINIRec.WriteString(ASecao, 'Conta', AInformacoesBancarias.Conta);
  AINIRec.WriteString(ASecao, 'TipoConta', tpTipoContaToEnumStr(AInformacoesBancarias.TipoConta));
end;

procedure TCIOTIniWriter.Gerar_Login(AINIRec: TMemIniFile);
var
  LSecao: string;
begin
  LSecao := TpOperacaoToNome(FCIOT.Integradora.Operacao);

  AINIRec.WriteString(LSecao, 'Integrador', FCIOT.Integradora.Integrador);
  AINIRec.WriteString(LSecao, 'Usuario', FCIOT.Integradora.Usuario);
  AINIRec.WriteString(LSecao, 'Senha', FCIOT.Integradora.Senha);
end;

procedure TCIOTIniWriter.Gerar_Logout(AINIRec: TMemIniFile);
var
  LSecao: string;
begin
  LSecao := TpOperacaoToNome(FCIOT.Integradora.Operacao);

  AINIRec.WriteString(LSecao, 'Token', FCIOT.Integradora.Token);
  AINIRec.WriteString(LSecao, 'Integrador', FCIOT.Integradora.Integrador);
end;

procedure TCIOTIniWriter.Gerar_Motorista(AINIRec: TMemIniFile);
var
  LSecao: string;
begin
  LSecao := 'Motorista';

  AINIRec.WriteString(LSecao, 'CpfOuCnpj', FCIOT.AdicionarOperacao.Motorista.CpfOuCnpj);
  AINIRec.WriteString(LSecao, 'CNH', FCIOT.AdicionarOperacao.Motorista.CNH);
  AINIRec.WriteInteger(LSecao, 'DDD', FCIOT.AdicionarOperacao.Motorista.Celular.DDD);
  AINIRec.WriteInteger(LSecao, 'Numero', FCIOT.AdicionarOperacao.Motorista.Celular.Numero);
end;

procedure TCIOTIniWriter.Gerar_NotaFiscal(AINIRec: TMemIniFile; ANotaFiscalCollection: TNotaFiscalCollection; item: string);
var
  LSecao: string;
  i: Integer;
  LNotaFiscal: TNotaFiscalCollectionItem;
begin
  for i:=0 to ANotaFiscalCollection.Count - 1 do
  begin
    LNotaFiscal := ANotaFiscalCollection[i];

    LSecao := 'NotaFiscal' + item + IntToStrZero(i+1, 3);

    AINIRec.WriteString(LSecao, 'Numero', LNotaFiscal.Numero);
    AINIRec.WriteString(LSecao, 'Serie', LNotaFiscal.Serie);
    AINIRec.WriteString(LSecao, 'CnpjEmissor', LNotaFiscal.CnpjEmissor);
    AINIRec.WriteString(LSecao, 'Data', DateToStr(LNotaFiscal.Data));
    AINIRec.WriteFloat(LSecao, 'ValorTotal', LNotaFiscal.ValorTotal);
    AINIRec.WriteFloat(LSecao, 'ValorDaMercadoriaPorUnidade', LNotaFiscal.ValorDaMercadoriaPorUnidade);
    AINIRec.WriteInteger(LSecao, 'CodigoNCMNaturezaCarga', LNotaFiscal.CodigoNCMNaturezaCarga);
    AINIRec.WriteString(LSecao, 'DescricaoDaMercadoria', LNotaFiscal.DescricaoDaMercadoria);
    AINIRec.WriteString(LSecao, 'UnidadeDeMedidaDaMercadoria', TpUnidDeMedMercToEnumStr(LNotaFiscal.UnidadeDeMedidaDaMercadoria));
    AINIRec.WriteString(LSecao, 'TipoDeCalculo', TpViagemTipoDeCalculoToEnumStr(LNotaFiscal.TipoDeCalculo));
    AINIRec.WriteFloat(LSecao, 'ValorDoFretePorUnidadeDeMercadoria', LNotaFiscal.ValorDoFretePorUnidadeDeMercadoria);
    AINIRec.WriteFloat(LSecao, 'QuantidadeDaMercadoriaNoEmbarque', LNotaFiscal.QuantidadeDaMercadoriaNoEmbarque);
    AINIRec.WriteString(LSecao, 'ToleranciaDePerdaDeMercadoria.Tipo', TpTipoProporcaoToEnumStr(LNotaFiscal.ToleranciaDePerdaDeMercadoria.Tipo));
    AINIRec.WriteFloat(LSecao, 'ToleranciaDePerdaDeMercadoria.Valor', LNotaFiscal.ToleranciaDePerdaDeMercadoria.Valor);
    AINIRec.WriteString(LSecao, 'DiferencaDeFrete.Tipo', TpDiferencaFreteToEnumStr(LNotaFiscal.DiferencaDeFrete.Tipo));
    AINIRec.WriteString(LSecao, 'DiferencaDeFrete.Base', TpDiferencaFreteBaseCalculoToEnumStr(LNotaFiscal.DiferencaDeFrete.Base));
    AINIRec.WriteString(LSecao, 'Tolerancia.Tipo', TpTipoProporcaoToEnumStr(LNotaFiscal.DiferencaDeFrete.Tolerancia.Tipo));
    AINIRec.WriteFloat(LSecao, 'Tolerancia.Valor', LNotaFiscal.DiferencaDeFrete.Tolerancia.Valor);
    AINIRec.WriteString(LSecao, 'MargemGanho.Tipo', TpTipoProporcaoToEnumStr(LNotaFiscal.DiferencaDeFrete.MargemGanho.Tipo));
    AINIRec.WriteFloat(LSecao, 'MargemGanho.Valor', LNotaFiscal.DiferencaDeFrete.MargemGanho.Valor);
    AINIRec.WriteString(LSecao, 'MargemPerda.Tipo', TpTipoProporcaoToEnumStr(LNotaFiscal.DiferencaDeFrete.MargemPerda.Tipo));
    AINIRec.WriteFloat(LSecao, 'MargemPerda.Valor', LNotaFiscal.DiferencaDeFrete.MargemPerda.Valor);
  end;
end;

procedure TCIOTIniWriter.Gerar_NotaFiscalDesembarque(AINIRec: TMemIniFile; ANotaFiscalCollection: TNotaFiscalCollection);
var
  LSecao: string;
  i: Integer;
  LNotaFiscal: TNotaFiscalCollectionItem;
begin
  for i:=0 to ANotaFiscalCollection.Count - 1 do
  begin
    LNotaFiscal := ANotaFiscalCollection[i];

    LSecao := 'NotaFiscal' + IntToStrZero(i+1, 3);

    AINIRec.WriteString(LSecao, 'Numero', LNotaFiscal.Numero);
    AINIRec.WriteString(LSecao, 'Serie', LNotaFiscal.Serie);
    AINIRec.WriteFloat(LSecao, 'QuantidadeDaMercadoriaNoDesembarque', LNotaFiscal.QuantidadeDaMercadoriaNoDesembarque);
  end;
end;

procedure TCIOTIniWriter.Gerar_ObservacoesAoCredenciado(AINIRec: TMemIniFile; AObservacoesAoCredenciado: TMensagemCollection);
var
  LSecao: string;
  i: Integer;
  LItem: string;
begin
  for i:=0 to AObservacoesAoCredenciado.Count - 1 do
  begin
    LItem := IntToStrZero(i+1, 3);
    LSecao := 'ObservacoesAoCredenciado' + LItem;

    AINIRec.WriteString(LSecao, 'Mensagem', AObservacoesAoCredenciado[i].Mensagem);
  end;
end;

procedure TCIOTIniWriter.Gerar_ObservacoesAoTransportador(AINIRec: TMemIniFile; AObservacoesAoTransportador: TMensagemCollection);
var
  LSecao: string;
  i: Integer;
  LItem: string;
begin
  for i:=0 to AObservacoesAoTransportador.Count - 1 do
  begin
    LItem := IntToStrZero(i+1, 3);
    LSecao := 'ObservacoesAoTransportador' + LItem;

    AINIRec.WriteString(LSecao, 'Mensagem', AObservacoesAoTransportador[i].Mensagem);
  end;
end;

procedure TCIOTIniWriter.Gerar_Pagamentos(AINIRec: TMemIniFile; APagamentoCollection: TPagamentoCollection);
var
  LSecao: string;
  i: Integer;
  LPagamento: TPagamentoCollectionItem;
begin
  for i:=0 to APagamentoCollection.Count - 1 do
  begin
    LPagamento := APagamentoCollection[i];

    LSecao := 'Pagamento' + IntToStrZero(i+1, 3);

    AINIRec.WriteString(LSecao, 'IdPagamentoCliente', LPagamento.IdPagamentoCliente);
    AINIRec.WriteString(LSecao, 'DataDeLiberacao', DateToStr(LPagamento.DataDeLiberacao));
    AINIRec.WriteFloat(LSecao, 'Valor', LPagamento.Valor);
    AINIRec.WriteString(LSecao, 'TipoPagamento', TpTipoPagamentoToEnumStr(LPagamento.TipoPagamento));
    AINIRec.WriteString(LSecao, 'Categoria', TpTipoCategoriaPagamentoToEnumStr(LPagamento.Categoria));
    AINIRec.WriteString(LSecao, 'Documento', LPagamento.Documento);
    AINIRec.WriteString(LSecao, 'IndicadorPagamento', LPagamento.IndicadorPagamento);
    AINIRec.WriteString(LSecao, 'CpfCnpjCreditado', LPagamento.CpfCnpjCreditado);
    AINIRec.WriteInteger(LSecao, 'NumeroParcela', LPagamento.NumeroParcela);
    AINIRec.WriteString(LSecao, 'CodigoPagamento', LPagamento.CodigoPagamento);

    Gerar_InformacoesBancarias(AINIRec, LPagamento.InformacoesBancarias, LSecao);

    AINIRec.WriteString(LSecao, 'InformacaoAdicional', LPagamento.InformacaoAdicional);
    AINIRec.WriteString(LSecao, 'TipoChavePix', LPagamento.TipoChavePix);
    AINIRec.WriteString(LSecao, 'ValorChavePix', LPagamento.ValorChavePix);
    AINIRec.WriteString(LSecao, 'IdentificadorPix', LPagamento.IdentificadorPix);
    AINIRec.WriteString(LSecao, 'CnpjFilialAbastecimento', LPagamento.CnpjFilialAbastecimento);
  end;
end;

procedure TCIOTIniWriter.Gerar_Pessoa(AINIRec: TMemIniFile; ASecao: string; APessoa: TPessoa);
var
  LSecao: string;
begin
  LSecao := ASecao;

  AINIRec.WriteString(LSecao, 'NomeOuRazaoSocial', APessoa.NomeOuRazaoSocial);
  AINIRec.WriteString(LSecao, 'CpfOuCnpj', APessoa.CpfOuCnpj);
  AINIRec.WriteString(LSecao, 'Bairro', APessoa.Endereco.Bairro);
  AINIRec.WriteString(LSecao, 'Rua', APessoa.Endereco.Rua);
  AINIRec.WriteString(LSecao, 'Numero', APessoa.Endereco.Numero);
  AINIRec.WriteString(LSecao, 'Complemento', APessoa.Endereco.Complemento);
  AINIRec.WriteString(LSecao, 'CEP', APessoa.Endereco.CEP);
  AINIRec.WriteInteger(LSecao, 'CodigoMunicipio', APessoa.Endereco.CodigoMunicipio);
  AINIRec.WriteString(LSecao, 'EMail', APessoa.EMail);
  AINIRec.WriteInteger(LSecao, 'Celular.DDD', APessoa.Telefones.Celular.DDD);
  AINIRec.WriteInteger(LSecao, 'Celular.Numero', APessoa.Telefones.Celular.Numero);
  AINIRec.WriteInteger(LSecao, 'Fixo.DDD', APessoa.Telefones.Fixo.DDD);
  AINIRec.WriteInteger(LSecao, 'Fixo.Numero', APessoa.Telefones.Fixo.Numero);
  AINIRec.WriteInteger(LSecao, 'Fax.DDD', APessoa.Telefones.Fax.DDD);
  AINIRec.WriteInteger(LSecao, 'Fax.Numero', APessoa.Telefones.Fax.Numero);
end;

procedure TCIOTIniWriter.Gerar_ProprietarioCarga(AINIRec: TMemIniFile);
var
  LSecao: string;
begin
  LSecao := 'ProprietarioCarga';

  Gerar_Responsavel(AINIRec, LSecao, FCIOT.AdicionarOperacao.ProprietarioCarga);

  AINIRec.WriteString(LSecao, 'RNTRC', FCIOT.AdicionarOperacao.ProprietarioCarga.RNTRC);
end;

procedure TCIOTIniWriter.Gerar_GravarRegistrarPagamentoQuitacao(AINIRec: TMemIniFile);
var
  LSecao: string;
begin
  LSecao := TpOperacaoToNome(FCIOT.Integradora.Operacao);

  AINIRec.WriteString(LSecao, 'CodigoIdentificacaoOperacao', FCIOT.RegistrarPagamentoQuitacao.CodigoIdentificacaoOperacao);
  AINIRec.WriteString(LSecao, 'TokenCompra', FCIOT.RegistrarPagamentoQuitacao.TokenCompra);

  Gerar_NotaFiscalDesembarque(AINIRec, FCIOT.RegistrarPagamentoQuitacao.NotasFiscais);
end;

procedure TCIOTIniWriter.Gerar_GravarRegistrarQtdeMercadoriaDesembarque(AINIRec: TMemIniFile);
var
  LSecao: string;
begin
  LSecao := TpOperacaoToNome(FCIOT.Integradora.Operacao);

  AINIRec.WriteString(LSecao, 'CodigoIdentificacaoOperacao', FCIOT.RegistrarQuantidadeDaMercadoriaNoDesembarque.CodigoIdentificacaoOperacao);

  Gerar_NotaFiscalDesembarque(AINIRec, FCIOT.RegistrarQuantidadeDaMercadoriaNoDesembarque.NotasFiscais);
end;

procedure TCIOTIniWriter.Gerar_Remetente(AINIRec: TMemIniFile);
var
  LSecao: string;
begin
  LSecao := 'Remetente';

  Gerar_Responsavel(AINIRec, LSecao, FCIOT.AdicionarOperacao.Remetente);
end;

procedure TCIOTIniWriter.Gerar_Responsavel(AINIRec: TMemIniFile; ASecao: string; APessoa: TPessoa);
var
  LSecao: string;
begin
  LSecao := ASecao;

  Gerar_Pessoa(AINIRec, ASecao, APessoa);

  AINIRec.WriteString(LSecao, 'ResponsavelPeloPagamento', IntToStr(Integer(APessoa.ResponsavelPeloPagamento)));
end;

procedure TCIOTIniWriter.Gerar_SubContratante(AINIRec: TMemIniFile);
var
  LSecao: string;
begin
  LSecao := 'SubContratante';

  Gerar_Responsavel(AINIRec, LSecao, FCIOT.AdicionarOperacao.SubContratante);
end;

procedure TCIOTIniWriter.Gerar_TomadorServico(AINIRec: TMemIniFile);
var
  LSecao: string;
begin
  LSecao := 'TomadorServico';

  Gerar_Responsavel(AINIRec, LSecao, FCIOT.AdicionarOperacao.TomadorServico);
end;

procedure TCIOTIniWriter.Gerar_Veiculos(AINIRec: TMemIniFile; AVeiculoCollection: TVeiculoCollection);
var
  LSecao: string;
  i: Integer;
  LItem: string;
begin
  for i:=0 to AVeiculoCollection.Count - 1 do
  begin
    LItem := IntToStrZero(i+1, 1);
    LSecao := 'Veiculo' + LItem;

    AINIRec.WriteString(LSecao, 'Placa', AVeiculoCollection[i].Placa);
  end;
end;

procedure TCIOTIniWriter.Gerar_Viagem(AINIRec: TMemIniFile; AViagemCollection: TViagemCollection);
var
  LSecao: string;
  i: Integer;
  LViagem: TViagemCollectionItem;
  LItemViagem: string;
begin
  for i:=0 to AViagemCollection.Count - 1 do
  begin
    LViagem := AViagemCollection[i];

    LItemViagem := IntToStrZero(i+1, 3);
    LSecao := 'Viagem' + LItemViagem;

    AINIRec.WriteString(LSecao, 'DocumentoViagem', LViagem.DocumentoViagem);
    AINIRec.WriteInteger(LSecao, 'CodigoMunicipioOrigem', LViagem.CodigoMunicipioOrigem);
    AINIRec.WriteInteger(LSecao, 'CodigoMunicipioDestino', LViagem.CodigoMunicipioDestino);
    AINIRec.WriteString(LSecao, 'CepOrigem', LViagem.CepOrigem);
    AINIRec.WriteString(LSecao, 'CepDestino', LViagem.CepDestino);
    AINIRec.WriteInteger(LSecao, 'DistanciaPercorrida', LViagem.DistanciaPercorrida);
    AINIRec.WriteFloat(LSecao, 'LatitudeOrigem', LViagem.LatitudeOrigem);
    AINIRec.WriteFloat(LSecao, 'LongitudeOrigem', LViagem.LongitudeOrigem);
    AINIRec.WriteFloat(LSecao, 'LatitudeDestino', LViagem.LatitudeDestino);
    AINIRec.WriteFloat(LSecao, 'LongitudeDestino', LViagem.LongitudeDestino);

    AINIRec.WriteFloat(LSecao, 'TotalOperacao', LViagem.Valores.TotalOperacao);
    AINIRec.WriteFloat(LSecao, 'TotalViagem', LViagem.Valores.TotalViagem);
    AINIRec.WriteFloat(LSecao, 'TotalDeAdiantamento', LViagem.Valores.TotalDeAdiantamento);
    AINIRec.WriteFloat(LSecao, 'TotalDeQuitacao', LViagem.Valores.TotalDeQuitacao);
    AINIRec.WriteFloat(LSecao, 'Combustivel', LViagem.Valores.Combustivel);
    AINIRec.WriteFloat(LSecao, 'Pedagio', LViagem.Valores.Pedagio);
    AINIRec.WriteFloat(LSecao, 'OutrosCreditos', LViagem.Valores.OutrosCreditos);
    AINIRec.WriteString(LSecao, 'JustificativaOutrosCreditos', LViagem.Valores.JustificativaOutrosCreditos);
    AINIRec.WriteFloat(LSecao, 'Seguro', LViagem.Valores.Seguro);
    AINIRec.WriteFloat(LSecao, 'OutrosDebitos', LViagem.Valores.OutrosDebitos);
    AINIRec.WriteString(LSecao, 'JustificativaOutrosDebitos', LViagem.Valores.JustificativaOutrosDebitos);

    AINIRec.WriteString(LSecao, 'TipoPagamento', TpTipoPagamentoToEnumStr(LViagem.TipoPagamento));

    Gerar_InformacoesBancarias(AINIRec, LViagem.InformacoesBancarias, LSecao);
    Gerar_NotaFiscal(AINIRec, LViagem.NotasFiscais, LItemViagem);
  end;
end;

function TCIOTIniWriter.GravarIni: string;
var
  LINIRec: TMemIniFile;
  IniCIOT: TStringList;
begin
  Result := '';

  LINIRec := TMemIniFile.Create('');
  try
    LINIRec.WriteInteger('infCIOT', 'Operacao', TpOperacaoToInt(FCIOT.Integradora.Operacao));

    case FCIOT.Integradora.Operacao of
      opLogin:
        begin
          Gerar_Login(LINIRec);
        end;

      opLogout:
        begin
          Gerar_Logout(LINIRec);
        end;

      opGravarProprietario:
        begin
          Gerar_GravarProprietario(LINIRec);
        end;

      opGravarVeiculo:
        begin
          Gerar_GravarVeiculo(LINIRec);
        end;

      opGravarMotorista:
        begin
          Gerar_GravarMotorista(LINIRec);
        end;

      opAdicionar:
        begin
          Gerar_GravarAdicionarOperacao(LINIRec);
        end;

      opAdicionarViagem:
        begin
          Gerar_GravarAdicionarViagem(LINIRec);
        end;

      opAdicionarPagamento:
        begin
          Gerar_GravarAdicionarPagamento(LINIRec);
        end;

      opObterCodigoIOT:
        begin
          Gerar_GravarObterCIOT(LINIRec);
        end;

      opObterPdf:
        begin
          Gerar_GravarObterPdf(LINIRec);
        end;

      opRetificar:
        begin
          Gerar_GravarRetificarOperacao(LINIRec);
        end;

      opCancelar:
        begin
          Gerar_GravarCancelarOperacao(LINIRec);
        end;

      opCancelarPagamento:
        begin
          Gerar_GravarCancelarPagamento(LINIRec);
        end;

      opEncerrar:
        begin
          Gerar_GravarEncerrarOperacao(LINIRec);
        end;

      opConsultarTipoCarga:
        begin
          // Sem conteúdo
        end;

      opAlterarDataLiberacaoPagamento:
        begin
          Gerar_GravarAlterarDataLiberacaoPagamento(LINIRec);
        end;

      opRegistrarQtdeMercadoriaDesembarque:
        begin
          Gerar_GravarRegistrarQtdeMercadoriaDesembarque(LINIRec);
        end;

      opRegistrarPagamentoQuitacao:
        begin
          Gerar_GravarRegistrarPagamentoQuitacao(LINIRec);
        end;
    else
      raise Exception.Create('Opção não implementada: ' + TpOperacaoToNome(FCIOT.Integradora.Operacao));
    end;

    IniCIOT := TStringList.Create;
    try
      LINIRec.GetStrings(IniCIOT);
      Result := StringReplace(IniCIOT.Text, sLineBreak + sLineBreak, sLineBreak, [rfReplaceAll]);
    finally
      IniCIOT.Free;
    end;
  finally
    LINIRec.Free;
  end;
end;

end.
