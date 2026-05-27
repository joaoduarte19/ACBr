{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2024 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{ - Elias Cesar                                                                }
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

unit ACBrSchemasTransferenciasAPIBB;

interface

uses
  Classes, SysUtils, ACBrAPIBase, ACBrJSON,
  ACBrSchemasPagamentosAPI;

type
  TACBrTransferenciaPixBBTipoPagamento = (
    tptNenhum,
    tptPagamentoFornecedores,  // 126 - Pagamento a Fornecedores
    tptPagamentoSalarios,      // 127 - Pagamento de Salarios
    tptPagamentosDiversos      // 128 - Pagamentos Diversos
  );

  TACBrTransferenciaPixBBFormaIdentificacao = (
    tfiNenhuma,
    tfiTelefone,        // 1 - Chave Pix tipo Telefone
    tfiEmail,           // 2 - Chave Pix tipo Email
    tfiCpfCnpj,         // 3 - Chave Pix tipo CPF/CNPJ
    tfiAleatoria,       // 4 - Chave Aleatoria
    tfiDadosBancarios   // 5 - Dados Bancarios
  );

  TACBrTransferenciaBBRequisicao = class;
  TACBrTransferenciaBBResposta = class;
  TACBrTransferenciaLoteBBConsulta = class;
  TACBrTransferenciaBBPagamentoEspecifico = class;
  TACBrTransferenciaPixBBRequisicao = class;
  TACBrTransferenciaPixBBResposta = class;
  TACBrPixPagamentoBBEspecifico = class;
  TACBrPagamentoLoteBBConsulta = class;

  TACBrTransferenciasBBRequisicao = class(TACBrAPISchemaArray)
  private
    function GetItem(aIndex: Integer): TACBrTransferenciaBBRequisicao;
    procedure SetItem(aIndex: Integer; aValue: TACBrTransferenciaBBRequisicao);
  protected
    function NewSchema: TACBrAPISchema; override;
  public
    function Add(aItem: TACBrTransferenciaBBRequisicao): Integer;
    procedure Insert(aIndex: Integer; aItem: TACBrTransferenciaBBRequisicao);
    function New: TACBrTransferenciaBBRequisicao;
    property Items[aIndex: Integer]: TACBrTransferenciaBBRequisicao read GetItem write SetItem; default;
  end;

  TACBrTransferenciasBBResposta = class(TACBrAPISchemaArray)
  private
    function GetItem(aIndex: Integer): TACBrTransferenciaBBResposta;
    procedure SetItem(aIndex: Integer; aValue: TACBrTransferenciaBBResposta);
  protected
    function NewSchema: TACBrAPISchema; override;
  public
    function Add(aItem: TACBrTransferenciaBBResposta): Integer;
    procedure Insert(aIndex: Integer; aItem: TACBrTransferenciaBBResposta);
    function New: TACBrTransferenciaBBResposta;
    property Items[aIndex: Integer]: TACBrTransferenciaBBResposta read GetItem write SetItem; default;
  end;

  TACBrTransferenciasLoteBBConsulta = class(TACBrAPISchemaArray)
  private
    function GetItem(aIndex: Integer): TACBrTransferenciaLoteBBConsulta;
    procedure SetItem(aIndex: Integer; aValue: TACBrTransferenciaLoteBBConsulta);
  protected
    function NewSchema: TACBrAPISchema; override;
  public
    function Add(aItem: TACBrTransferenciaLoteBBConsulta): Integer;
    procedure Insert(aIndex: Integer; aItem: TACBrTransferenciaLoteBBConsulta);
    function New: TACBrTransferenciaLoteBBConsulta;
    property Items[aIndex: Integer]: TACBrTransferenciaLoteBBConsulta read GetItem write SetItem; default;
  end;

  TACBrTransferenciaPagamentosBBEspecificos = class(TACBrAPISchemaArray)
  private
    function GetItem(aIndex: Integer): TACBrTransferenciaBBPagamentoEspecifico;
    procedure SetItem(aIndex: Integer; aValue: TACBrTransferenciaBBPagamentoEspecifico);
  protected
    function NewSchema: TACBrAPISchema; override;
  public
    function Add(aItem: TACBrTransferenciaBBPagamentoEspecifico): Integer;
    procedure Insert(aIndex: Integer; aItem: TACBrTransferenciaBBPagamentoEspecifico);
    function New: TACBrTransferenciaBBPagamentoEspecifico;
    property Items[aIndex: Integer]: TACBrTransferenciaBBPagamentoEspecifico read GetItem write SetItem; default;
  end;

  TACBrTransferenciasPixBBRequisicao = class(TACBrAPISchemaArray)
  private
    function GetItem(aIndex: Integer): TACBrTransferenciaPixBBRequisicao;
    procedure SetItem(aIndex: Integer; aValue: TACBrTransferenciaPixBBRequisicao);
  protected
    function NewSchema: TACBrAPISchema; override;
  public
    function Add(aItem: TACBrTransferenciaPixBBRequisicao): Integer;
    procedure Insert(aIndex: Integer; aItem: TACBrTransferenciaPixBBRequisicao);
    function New: TACBrTransferenciaPixBBRequisicao;
    property Items[aIndex: Integer]: TACBrTransferenciaPixBBRequisicao read GetItem write SetItem; default;
  end;

  TACBrTransferenciasPixBBResposta = class(TACBrAPISchemaArray)
  private
    function GetItem(aIndex: Integer): TACBrTransferenciaPixBBResposta;
    procedure SetItem(aIndex: Integer; aValue: TACBrTransferenciaPixBBResposta);
  protected
    function NewSchema: TACBrAPISchema; override;
  public
    function Add(aItem: TACBrTransferenciaPixBBResposta): Integer;
    procedure Insert(aIndex: Integer; aItem: TACBrTransferenciaPixBBResposta);
    function New: TACBrTransferenciaPixBBResposta;
    property Items[aIndex: Integer]: TACBrTransferenciaPixBBResposta read GetItem write SetItem; default;
  end;

  TACBrPagamentosLoteBBConsulta = class(TACBrAPISchemaArray)
  private
    function GetItem(aIndex: Integer): TACBrPagamentoLoteBBConsulta;
    procedure SetItem(aIndex: Integer; aValue: TACBrPagamentoLoteBBConsulta);
  protected
    function NewSchema: TACBrAPISchema; override;
  public
    function Add(aItem: TACBrPagamentoLoteBBConsulta): Integer;
    procedure Insert(aIndex: Integer; aItem: TACBrPagamentoLoteBBConsulta);
    function New: TACBrPagamentoLoteBBConsulta;
    property Items[aIndex: Integer]: TACBrPagamentoLoteBBConsulta read GetItem write SetItem; default;
  end;

  TACBrPixBBPagamentosEspecificos = class(TACBrAPISchemaArray)
  private
    function GetItem(aIndex: Integer): TACBrPixPagamentoBBEspecifico;
    procedure SetItem(aIndex: Integer; aValue: TACBrPixPagamentoBBEspecifico);
  protected
    function NewSchema: TACBrAPISchema; override;
  public
    function Add(aItem: TACBrPixPagamentoBBEspecifico): Integer;
    procedure Insert(aIndex: Integer; aItem: TACBrPixPagamentoBBEspecifico);
    function New: TACBrPixPagamentoBBEspecifico;
    property Items[aIndex: Integer]: TACBrPixPagamentoBBEspecifico read GetItem write SetItem; default;
  end;

  TACBrTransferenciaBBBase = class(TACBrAPISchema)
  private
    fagenciaCredito: Int64;
    fcnpjBeneficiario: String;
    fcodigoFinalidadeDOC: String;
    fcodigoFinalidadeTED: String;
    fcontaCorrenteCredito: Int64;
    fcontaPagamentoCredito: String;
    fcpfBeneficiario: String;
    fdataTransferencia: TDateTime;
    fdescricaoTransferencia: String;
    fdigitoVerificadorContaCorrente: String;
    fdocumentoCredito: Int64;
    fdocumentoDebito: Int64;
    fnumeroCOMPE: Int64;
    fnumeroDepositoJudicial: String;
    fnumeroISPB: Int64;
    fvalorTransferencia: Double;
  protected
    procedure AssignSchema(aSource: TACBrAPISchema); override;
    procedure DoWriteToJSon(aJSon: TACBrJSONObject); override;
    procedure DoReadFromJSon(aJSon: TACBrJSONObject); override;
  public
    procedure Clear; override;
    function IsEmpty: Boolean; override;
    procedure Assign(aSource: TACBrTransferenciaBBBase); virtual;

    property numeroCOMPE: Int64 read fnumeroCOMPE write fnumeroCOMPE;
    property numeroISPB: Int64 read fnumeroISPB write fnumeroISPB;
    property agenciaCredito: Int64 read fagenciaCredito write fagenciaCredito;
    property contaCorrenteCredito: Int64 read fcontaCorrenteCredito write fcontaCorrenteCredito;
    property digitoVerificadorContaCorrente: String read fdigitoVerificadorContaCorrente write fdigitoVerificadorContaCorrente;
    property contaPagamentoCredito: String read fcontaPagamentoCredito write fcontaPagamentoCredito;
    property cpfBeneficiario: String read fcpfBeneficiario write fcpfBeneficiario;
    property cnpjBeneficiario: String read fcnpjBeneficiario write fcnpjBeneficiario;
    property dataTransferencia: TDateTime read fdataTransferencia write fdataTransferencia;
    property valorTransferencia: Double read fvalorTransferencia write fvalorTransferencia;
    property documentoDebito: Int64 read fdocumentoDebito write fdocumentoDebito;
    property documentoCredito: Int64 read fdocumentoCredito write fdocumentoCredito;
    property codigoFinalidadeDOC: String read fcodigoFinalidadeDOC write fcodigoFinalidadeDOC;
    property codigoFinalidadeTED: String read fcodigoFinalidadeTED write fcodigoFinalidadeTED;
    property numeroDepositoJudicial: String read fnumeroDepositoJudicial write fnumeroDepositoJudicial;
    property descricaoTransferencia: String read fdescricaoTransferencia write fdescricaoTransferencia;
  end;

  TACBrTransferenciaBBRequisicao = class(TACBrTransferenciaBBBase)
  end;

  TACBrTransferenciaBBResposta = class(TACBrTransferenciaBBBase)
  private
    ferros: TACBrTransferenciaErros;
    fidentificadorTransferencia: Int64;
    findicadorAceite: String;
    ftipoCredito: Integer;
    function Geterros: TACBrTransferenciaErros;
  protected
    procedure AssignSchema(aSource: TACBrAPISchema); override;
    procedure DoWriteToJSon(aJSon: TACBrJSONObject); override;
    procedure DoReadFromJSon(aJSon: TACBrJSONObject); override;
  public
    destructor Destroy; override;
    procedure Clear; override;
    function IsEmpty: Boolean; override;
    procedure Assign(aSource: TACBrTransferenciaBBResposta); reintroduce; virtual;

    property identificadorTransferencia: Int64 read fidentificadorTransferencia write fidentificadorTransferencia;
    property tipoCredito: Integer read ftipoCredito write ftipoCredito;
    property indicadorAceite: String read findicadorAceite write findicadorAceite;
    property erros: TACBrTransferenciaErros read Geterros write ferros;
  end;

  TACBrLoteTransferenciasRequisicao = class(TACBrAPISchema)
  private
    fagenciaDebito: Int64;
    fcontaCorrenteDebito: Int64;
    fcodigoContrato: Int64;
    fdigitoVerificadorContaCorrenteDebito: String;
    flistaTransferencias: TACBrTransferenciasBBRequisicao;
    fnumeroRequisicao: Int64;
    ftipoPagamento: Integer;
    function GetlistaTransferencias: TACBrTransferenciasBBRequisicao;
  protected
    procedure AssignSchema(aSource: TACBrAPISchema); override;
    procedure DoWriteToJSon(aJSon: TACBrJSONObject); override;
    procedure DoReadFromJSon(aJSon: TACBrJSONObject); override;
  public
    destructor Destroy; override;
    procedure Clear; override;
    function IsEmpty: Boolean; override;
    procedure Assign(aSource: TACBrLoteTransferenciasRequisicao);

    property numeroRequisicao: Int64 read fnumeroRequisicao write fnumeroRequisicao;
    property codigoContrato: Int64 read fcodigoContrato write fcodigoContrato;
    property agenciaDebito: Int64 read fagenciaDebito write fagenciaDebito;
    property contaCorrenteDebito: Int64 read fcontaCorrenteDebito write fcontaCorrenteDebito;
    property digitoVerificadorContaCorrenteDebito: String read fdigitoVerificadorContaCorrenteDebito write fdigitoVerificadorContaCorrenteDebito;
    property tipoPagamento: Integer read ftipoPagamento write ftipoPagamento;
    property listaTransferencias: TACBrTransferenciasBBRequisicao read GetlistaTransferencias write flistaTransferencias;
  end;

  TACBrLoteTransferenciasResposta = class(TACBrAPISchema)
  private
    festadoRequisicao: Integer;
    fquantidadeTransferencias: Integer;
    fquantidadeTransferenciasValidas: Integer;
    ftransferencias: TACBrTransferenciasBBResposta;
    fvalorTransferencias: Double;
    fvalorTransferenciasValidas: Double;
    function Gettransferencias: TACBrTransferenciasBBResposta;
  protected
    procedure AssignSchema(aSource: TACBrAPISchema); override;
    procedure DoWriteToJSon(aJSon: TACBrJSONObject); override;
    procedure DoReadFromJSon(aJSon: TACBrJSONObject); override;
  public
    destructor Destroy; override;
    procedure Clear; override;
    function IsEmpty: Boolean; override;
    procedure Assign(aSource: TACBrLoteTransferenciasResposta);

    property estadoRequisicao: Integer read festadoRequisicao write festadoRequisicao;
    property quantidadeTransferencias: Integer read fquantidadeTransferencias write fquantidadeTransferencias;
    property valorTransferencias: Double read fvalorTransferencias write fvalorTransferencias;
    property quantidadeTransferenciasValidas: Integer read fquantidadeTransferenciasValidas write fquantidadeTransferenciasValidas;
    property valorTransferenciasValidas: Double read fvalorTransferenciasValidas write fvalorTransferenciasValidas;
    property transferencias: TACBrTransferenciasBBResposta read Gettransferencias write ftransferencias;
  end;

  TACBrTransferenciaLoteBBConsulta = class(TACBrAPISchema)
  private
    fagenciaDebito: Int64;
    fcontaCorrenteDebito: Int64;
    fdataRequisicao: TDateTime;
    fdigitoVerificadorContaCorrenteDebito: String;
    festadoRequisicao: Integer;
    fidentificacaoRequisitante: String;
    fnumeroRequisicao: Int64;
    fquantidadeTransferencias: Integer;
    fquantidadeTransferenciasValidas: Integer;
    ftipoPagamento: Integer;
    ftotalTransferencias: Double;
    ftotalTransferenciasValidas: Double;
  protected
    procedure AssignSchema(aSource: TACBrAPISchema); override;
    procedure DoWriteToJSon(aJSon: TACBrJSONObject); override;
    procedure DoReadFromJSon(aJSon: TACBrJSONObject); override;
  public
    procedure Clear; override;
    function IsEmpty: Boolean; override;
    procedure Assign(aSource: TACBrTransferenciaLoteBBConsulta);

    property numeroRequisicao: Int64 read fnumeroRequisicao write fnumeroRequisicao;
    property estadoRequisicao: Integer read festadoRequisicao write festadoRequisicao;
    property agenciaDebito: Int64 read fagenciaDebito write fagenciaDebito;
    property contaCorrenteDebito: Int64 read fcontaCorrenteDebito write fcontaCorrenteDebito;
    property digitoVerificadorContaCorrenteDebito: String read fdigitoVerificadorContaCorrenteDebito write fdigitoVerificadorContaCorrenteDebito;
    property dataRequisicao: TDateTime read fdataRequisicao write fdataRequisicao;
    property tipoPagamento: Integer read ftipoPagamento write ftipoPagamento;
    property identificacaoRequisitante: String read fidentificacaoRequisitante write fidentificacaoRequisitante;
    property quantidadeTransferencias: Integer read fquantidadeTransferencias write fquantidadeTransferencias;
    property totalTransferencias: Double read ftotalTransferencias write ftotalTransferencias;
    property quantidadeTransferenciasValidas: Integer read fquantidadeTransferenciasValidas write fquantidadeTransferenciasValidas;
    property totalTransferenciasValidas: Double read ftotalTransferenciasValidas write ftotalTransferenciasValidas;
  end;

  TACBrPagamentoLoteBBConsulta = class(TACBrAPISchema)
  private
    fagenciaCredito: Int64;
    fcnpjBeneficiario: String;
    fcodigoFinalidadeDOC: String;
    fcodigoFinalidadeTED: String;
    fcontaCorrenteCredito: Int64;
    fcontaPagamentoCredito: String;
    fcpfBeneficiario: String;
    fdataPagamento: TDateTime;
    fdescricaoPagamento: String;
    fdigitoVerificadorContaCorrente: String;
    fdocumentoCredito: Int64;
    fdocumentoDebito: Int64;
    ferros: TACBrTransferenciaErros;
    fidentificadorPagamento: Int64;
    findicadorAceite: String;
    fnumeroCOMPE: Int64;
    fnumeroDepositoJudicial: String;
    fnumeroISPB: Int64;
    ftipoCredito: Integer;
    fvalorPagamento: Double;
    function Geterros: TACBrTransferenciaErros;
  protected
    procedure AssignSchema(aSource: TACBrAPISchema); override;
    procedure DoWriteToJSon(aJSon: TACBrJSONObject); override;
    procedure DoReadFromJSon(aJSon: TACBrJSONObject); override;
  public
    destructor Destroy; override;
    procedure Clear; override;
    function IsEmpty: Boolean; override;
    procedure Assign(aSource: TACBrPagamentoLoteBBConsulta);

    property identificadorPagamento: Int64 read fidentificadorPagamento write fidentificadorPagamento;
    property numeroCOMPE: Int64 read fnumeroCOMPE write fnumeroCOMPE;
    property numeroISPB: Int64 read fnumeroISPB write fnumeroISPB;
    property agenciaCredito: Int64 read fagenciaCredito write fagenciaCredito;
    property contaCorrenteCredito: Int64 read fcontaCorrenteCredito write fcontaCorrenteCredito;
    property digitoVerificadorContaCorrente: String read fdigitoVerificadorContaCorrente write fdigitoVerificadorContaCorrente;
    property contaPagamentoCredito: String read fcontaPagamentoCredito write fcontaPagamentoCredito;
    property cpfBeneficiario: String read fcpfBeneficiario write fcpfBeneficiario;
    property cnpjBeneficiario: String read fcnpjBeneficiario write fcnpjBeneficiario;
    property dataPagamento: TDateTime read fdataPagamento write fdataPagamento;
    property valorPagamento: Double read fvalorPagamento write fvalorPagamento;
    property documentoDebito: Int64 read fdocumentoDebito write fdocumentoDebito;
    property documentoCredito: Int64 read fdocumentoCredito write fdocumentoCredito;
    property tipoCredito: Integer read ftipoCredito write ftipoCredito;
    property codigoFinalidadeDOC: String read fcodigoFinalidadeDOC write fcodigoFinalidadeDOC;
    property codigoFinalidadeTED: String read fcodigoFinalidadeTED write fcodigoFinalidadeTED;
    property numeroDepositoJudicial: String read fnumeroDepositoJudicial write fnumeroDepositoJudicial;
    property descricaoPagamento: String read fdescricaoPagamento write fdescricaoPagamento;
    property indicadorAceite: String read findicadorAceite write findicadorAceite;
    property erros: TACBrTransferenciaErros read Geterros write ferros;
  end;

  TACBrLoteTransferenciasRespostaConsulta = class(TACBrAPISchema)
  private
    festadoRequisicao: Integer;
    fpagamentos: TACBrPagamentosLoteBBConsulta;
    fquantidadePagamentos: Int64;
    fquantidadePagamentosValidos: Int64;
    fvalorPagamentos: Double;
    fvalorPagamentosValidos: Double;
    function Getpagamentos: TACBrPagamentosLoteBBConsulta;
  protected
    procedure AssignSchema(aSource: TACBrAPISchema); override;
    procedure DoWriteToJSon(aJSon: TACBrJSONObject); override;
    procedure DoReadFromJSon(aJSon: TACBrJSONObject); override;
  public
    destructor Destroy; override;
    procedure Clear; override;
    function IsEmpty: Boolean; override;
    procedure Assign(aSource: TACBrLoteTransferenciasRespostaConsulta);

    property estadoRequisicao: Integer read festadoRequisicao write festadoRequisicao;
    property quantidadePagamentos: Int64 read fquantidadePagamentos write fquantidadePagamentos;
    property valorPagamentos: Double read fvalorPagamentos write fvalorPagamentos;
    property quantidadePagamentosValidos: Int64 read fquantidadePagamentosValidos write fquantidadePagamentosValidos;
    property valorPagamentosValidos: Double read fvalorPagamentosValidos write fvalorPagamentosValidos;
    property pagamentos: TACBrPagamentosLoteBBConsulta read Getpagamentos write fpagamentos;
  end;

  TACBrTransferenciaBBPagamentoEspecifico = class(TACBrAPISchema)
  private
    fagenciaCredito: Int64;
    fcontaCorrenteCredito: Int64;
    fcpfCnpjBeneficiario: String;
    fdigitoVerificadorContaCorrente: String;
    fdocumentoCredito: Int64;
    fnomeBeneficiario: String;
    fnumeroCOMPE: Int64;
    fnumeroContaCredito: String;
    fnumeroISPB: Int64;
    ftexto: String;
    ftipoBeneficiario: Integer;
  protected
    procedure AssignSchema(aSource: TACBrAPISchema); override;
    procedure DoWriteToJSon(aJSon: TACBrJSONObject); override;
    procedure DoReadFromJSon(aJSon: TACBrJSONObject); override;
  public
    procedure Clear; override;
    function IsEmpty: Boolean; override;
    procedure Assign(aSource: TACBrTransferenciaBBPagamentoEspecifico);

    property numeroCOMPE: Int64 read fnumeroCOMPE write fnumeroCOMPE;
    property numeroISPB: Int64 read fnumeroISPB write fnumeroISPB;
    property agenciaCredito: Int64 read fagenciaCredito write fagenciaCredito;
    property contaCorrenteCredito: Int64 read fcontaCorrenteCredito write fcontaCorrenteCredito;
    property digitoVerificadorContaCorrente: String read fdigitoVerificadorContaCorrente write fdigitoVerificadorContaCorrente;
    property numeroContaCredito: String read fnumeroContaCredito write fnumeroContaCredito;
    property tipoBeneficiario: Integer read ftipoBeneficiario write ftipoBeneficiario;
    property cpfCnpjBeneficiario: String read fcpfCnpjBeneficiario write fcpfCnpjBeneficiario;
    property nomeBeneficiario: String read fnomeBeneficiario write fnomeBeneficiario;
    property documentoCredito: Int64 read fdocumentoCredito write fdocumentoCredito;
    property texto: String read ftexto write ftexto;
  end;

  TACBrPagamentoEspecificoTransferenciaResposta = class(TACBrAPISchema)
  private
    fagenciaDebito: Int64;
    fcodigoAutenticacaoPagamento: String;
    fcodigoFinalidadeDOC: String;
    fcodigoFinalidadeTED: String;
    fcontaCorrenteDebito: Int64;
    fdataPagamento: TDateTime;
    fdigitoVerificadorContaCorrente: String;
    fdocumentoDebito: Int64;
    festadoPagamento: TACBrEstadoPagamento;
    ffimCartaoCredito: Integer;
    fid: Int64;
    finicioCartaoCredito: Integer;
    flistaDevolucao: TACBrPagamentoDevolucoes;
    flistaPagamentos: TACBrTransferenciaPagamentosBBEspecificos;
    fnumeroDepositoJudicial: String;
    ftipoCredito: Integer;
    fvalorPagamento: Double;
    function GetlistaDevolucao: TACBrPagamentoDevolucoes;
    function GetlistaPagamentos: TACBrTransferenciaPagamentosBBEspecificos;
  protected
    procedure AssignSchema(aSource: TACBrAPISchema); override;
    procedure DoWriteToJSon(aJSon: TACBrJSONObject); override;
    procedure DoReadFromJSon(aJSon: TACBrJSONObject); override;
  public
    destructor Destroy; override;
    procedure Clear; override;
    function IsEmpty: Boolean; override;
    procedure Assign(aSource: TACBrPagamentoEspecificoTransferenciaResposta);

    property id: Int64 read fid write fid;
    property estadoPagamento: TACBrEstadoPagamento read festadoPagamento write festadoPagamento;
    property tipoCredito: Integer read ftipoCredito write ftipoCredito;
    property agenciaDebito: Int64 read fagenciaDebito write fagenciaDebito;
    property contaCorrenteDebito: Int64 read fcontaCorrenteDebito write fcontaCorrenteDebito;
    property digitoVerificadorContaCorrente: String read fdigitoVerificadorContaCorrente write fdigitoVerificadorContaCorrente;
    property inicioCartaoCredito: Integer read finicioCartaoCredito write finicioCartaoCredito;
    property fimCartaoCredito: Integer read ffimCartaoCredito write ffimCartaoCredito;
    property dataPagamento: TDateTime read fdataPagamento write fdataPagamento;
    property valorPagamento: Double read fvalorPagamento write fvalorPagamento;
    property documentoDebito: Int64 read fdocumentoDebito write fdocumentoDebito;
    property codigoAutenticacaoPagamento: String read fcodigoAutenticacaoPagamento write fcodigoAutenticacaoPagamento;
    property numeroDepositoJudicial: String read fnumeroDepositoJudicial write fnumeroDepositoJudicial;
    property codigoFinalidadeDOC: String read fcodigoFinalidadeDOC write fcodigoFinalidadeDOC;
    property codigoFinalidadeTED: String read fcodigoFinalidadeTED write fcodigoFinalidadeTED;
    property listaPagamentos: TACBrTransferenciaPagamentosBBEspecificos read GetlistaPagamentos write flistaPagamentos;
    property listaDevolucao: TACBrPagamentoDevolucoes read GetlistaDevolucao write flistaDevolucao;
  end;

  TACBrTransferenciaPixBase = class(TACBrAPISchema)
  private
    fagencia: Int64;
    fcnpj: String;
    fconta: Int64;
    fcontaPagamento: String;
    fcpf: String;
    fdataTransferencia: TDateTime;
    fdddTelefone: Integer;
    fdescricaoPagamento: String;
    fdescricaoPagamentoInstantaneo: String;
    fdigitoVerificadorConta: String;
    fdocumentoCredito: Int64;
    fdocumentoDebito: Int64;
    femail: String;
    fformaIdentificacao: TACBrTransferenciaPixBBFormaIdentificacao;
    fidentificacaoAleatoria: String;
    fnumeroCOMPE: Int64;
    fnumeroISPB: Int64;
    ftelefone: Int64;
    ftipoConta: Integer;
    fvalorTransferencia: Double;
  protected
    procedure AssignSchema(aSource: TACBrAPISchema); override;
    procedure DoWriteToJSon(aJSon: TACBrJSONObject); override;
    procedure DoReadFromJSon(aJSon: TACBrJSONObject); override;
  public
    procedure Clear; override;
    function IsEmpty: Boolean; override;
    procedure Assign(aSource: TACBrTransferenciaPixBase); virtual;

    property dataTransferencia: TDateTime read fdataTransferencia write fdataTransferencia;
    property valorTransferencia: Double read fvalorTransferencia write fvalorTransferencia;
    property documentoDebito: Int64 read fdocumentoDebito write fdocumentoDebito;
    property documentoCredito: Int64 read fdocumentoCredito write fdocumentoCredito;
    property descricaoPagamento: String read fdescricaoPagamento write fdescricaoPagamento;
    property descricaoPagamentoInstantaneo: String read fdescricaoPagamentoInstantaneo write fdescricaoPagamentoInstantaneo;
    property formaIdentificacao: TACBrTransferenciaPixBBFormaIdentificacao read fformaIdentificacao write fformaIdentificacao;
    property dddTelefone: Integer read fdddTelefone write fdddTelefone;
    property telefone: Int64 read ftelefone write ftelefone;
    property email: String read femail write femail;
    property cpf: String read fcpf write fcpf;
    property cnpj: String read fcnpj write fcnpj;
    property identificacaoAleatoria: String read fidentificacaoAleatoria write fidentificacaoAleatoria;
    property numeroCOMPE: Int64 read fnumeroCOMPE write fnumeroCOMPE;
    property numeroISPB: Int64 read fnumeroISPB write fnumeroISPB;
    property tipoConta: Integer read ftipoConta write ftipoConta;
    property agencia: Int64 read fagencia write fagencia;
    property conta: Int64 read fconta write fconta;
    property digitoVerificadorConta: String read fdigitoVerificadorConta write fdigitoVerificadorConta;
    property contaPagamento: String read fcontaPagamento write fcontaPagamento;
  end;

  TACBrTransferenciaPixBBRequisicao = class(TACBrTransferenciaPixBase)
  end;

  TACBrTransferenciaPixBBResposta = class(TACBrTransferenciaPixBase)
  private
    ferros: TACBrTransferenciaErros;
    fidentificadorPagamento: Int64;
    findicadorMovimentoAceito: String;
    function Geterros: TACBrTransferenciaErros;
  protected
    procedure AssignSchema(aSource: TACBrAPISchema); override;
    procedure DoWriteToJSon(aJSon: TACBrJSONObject); override;
    procedure DoReadFromJSon(aJSon: TACBrJSONObject); override;
  public
    destructor Destroy; override;
    procedure Clear; override;
    function IsEmpty: Boolean; override;
    procedure Assign(aSource: TACBrTransferenciaPixBBResposta); reintroduce; virtual;

    property identificadorPagamento: Int64 read fidentificadorPagamento write fidentificadorPagamento;
    property indicadorMovimentoAceito: String read findicadorMovimentoAceito write findicadorMovimentoAceito;
    property erros: TACBrTransferenciaErros read Geterros write ferros;
  end;

  TACBrLoteTransferenciaPixRequisicao = class(TACBrAPISchema)
  private
    fagenciaDebito: Int64;
    fcontaCorrenteDebito: Int64;
    fcodigoContrato: Int64;
    fdigitoVerificadorContaCorrenteDebito: String;
    flistaTransferencias: TACBrTransferenciasPixBBRequisicao;
    fnumeroRequisicao: Int64;
    ftipoPagamento: TACBrTransferenciaPixBBTipoPagamento;
    function GetlistaTransferencias: TACBrTransferenciasPixBBRequisicao;
  protected
    procedure AssignSchema(aSource: TACBrAPISchema); override;
    procedure DoWriteToJSon(aJSon: TACBrJSONObject); override;
    procedure DoReadFromJSon(aJSon: TACBrJSONObject); override;
  public
    destructor Destroy; override;
    procedure Clear; override;
    function IsEmpty: Boolean; override;
    procedure Assign(aSource: TACBrLoteTransferenciaPixRequisicao);

    property numeroRequisicao: Int64 read fnumeroRequisicao write fnumeroRequisicao;
    property codigoContrato: Int64 read fcodigoContrato write fcodigoContrato;
    property agenciaDebito: Int64 read fagenciaDebito write fagenciaDebito;
    property contaCorrenteDebito: Int64 read fcontaCorrenteDebito write fcontaCorrenteDebito;
    property digitoVerificadorContaCorrenteDebito: String read fdigitoVerificadorContaCorrenteDebito write fdigitoVerificadorContaCorrenteDebito;
    property tipoPagamento: TACBrTransferenciaPixBBTipoPagamento read ftipoPagamento write ftipoPagamento;
    property listaTransferencias: TACBrTransferenciasPixBBRequisicao read GetlistaTransferencias write flistaTransferencias;
  end;

  TACBrLoteTransferenciaPixResposta = class(TACBrAPISchema)
  private
    festadoRequisicao: Integer;
    flistaTransferencias: TACBrTransferenciasPixBBResposta;
    fnumeroRequisicao: Int64;
    fquantidadeTransferencias: Integer;
    fquantidadeTransferenciasValidas: Integer;
    fvalorTransferencias: Double;
    fvalorTransferenciasValidas: Double;
    function GetlistaTransferencias: TACBrTransferenciasPixBBResposta;
  protected
    procedure AssignSchema(aSource: TACBrAPISchema); override;
    procedure DoWriteToJSon(aJSon: TACBrJSONObject); override;
    procedure DoReadFromJSon(aJSon: TACBrJSONObject); override;
  public
    destructor Destroy; override;
    procedure Clear; override;
    function IsEmpty: Boolean; override;
    procedure Assign(aSource: TACBrLoteTransferenciaPixResposta);

    property numeroRequisicao: Int64 read fnumeroRequisicao write fnumeroRequisicao;
    property estadoRequisicao: Integer read festadoRequisicao write festadoRequisicao;
    property quantidadeTransferencias: Integer read fquantidadeTransferencias write fquantidadeTransferencias;
    property valorTransferencias: Double read fvalorTransferencias write fvalorTransferencias;
    property quantidadeTransferenciasValidas: Integer read fquantidadeTransferenciasValidas write fquantidadeTransferenciasValidas;
    property valorTransferenciasValidas: Double read fvalorTransferenciasValidas write fvalorTransferenciasValidas;
    property listaTransferencias: TACBrTransferenciasPixBBResposta read GetlistaTransferencias write flistaTransferencias;
  end;

  TACBrPixPagamentoBBEspecifico = class(TACBrAPISchema)
  private
    fagenciaCredito: Int64;
    fcontaCorrenteCredito: Int64;
    fcpfCnpjBeneficiario: String;
    fdddTelefone: Integer;
    fdescricaoPagamentoInstantaneo: String;
    fdigitoVerificadorContaCorrente: String;
    fdocumentoCredito: Int64;
    femail: String;
    fformaIdentificacao: String;
    fidentificacaoAleatoria: String;
    fnomeBeneficiario: String;
    fnumeroCOMPE: Int64;
    fnumeroContaPagamentoCredito: String;
    fnumeroISPB: Int64;
    ftelefone: Int64;
    ftextoPix: String;
    ftipoBeneficiario: Integer;
    ftipoConta: Integer;
  protected
    procedure AssignSchema(aSource: TACBrAPISchema); override;
    procedure DoWriteToJSon(aJSon: TACBrJSONObject); override;
    procedure DoReadFromJSon(aJSon: TACBrJSONObject); override;
  public
    procedure Clear; override;
    function IsEmpty: Boolean; override;
    procedure Assign(aSource: TACBrPixPagamentoBBEspecifico);

    property numeroCOMPE: Int64 read fnumeroCOMPE write fnumeroCOMPE;
    property numeroISPB: Int64 read fnumeroISPB write fnumeroISPB;
    property agenciaCredito: Int64 read fagenciaCredito write fagenciaCredito;
    property contaCorrenteCredito: Int64 read fcontaCorrenteCredito write fcontaCorrenteCredito;
    property digitoVerificadorContaCorrente: String read fdigitoVerificadorContaCorrente write fdigitoVerificadorContaCorrente;
    property numeroContaPagamentoCredito: String read fnumeroContaPagamentoCredito write fnumeroContaPagamentoCredito;
    property tipoBeneficiario: Integer read ftipoBeneficiario write ftipoBeneficiario;
    property cpfCnpjBeneficiario: String read fcpfCnpjBeneficiario write fcpfCnpjBeneficiario;
    property nomeBeneficiario: String read fnomeBeneficiario write fnomeBeneficiario;
    property documentoCredito: Int64 read fdocumentoCredito write fdocumentoCredito;
    property descricaoPagamentoInstantaneo: String read fdescricaoPagamentoInstantaneo write fdescricaoPagamentoInstantaneo;
    property tipoConta: Integer read ftipoConta write ftipoConta;
    property formaIdentificacao: String read fformaIdentificacao write fformaIdentificacao;
    property dddTelefone: Integer read fdddTelefone write fdddTelefone;
    property telefone: Int64 read ftelefone write ftelefone;
    property email: String read femail write femail;
    property identificacaoAleatoria: String read fidentificacaoAleatoria write fidentificacaoAleatoria;
    property textoPix: String read ftextoPix write ftextoPix;
  end;

  TACBrPagamentoEspecificoPixResposta = class(TACBrAPISchema)
  private
    fagenciaDebito: Int64;
    fautenticacaoPagamento: String;
    fcontaDebito: Int64;
    fdataPagamento: TDateTime;
    fdescricaoPagamento: String;
    fdigitoContaDebito: String;
    festadoPagamento: TACBrEstadoPagamento;
    fid: Int64;
    flistaDevolucao: TACBrPagamentoDevolucoes;
    flistaPix: TACBrPixBBPagamentosEspecificos;
    fnumeroCartaoFim: Integer;
    fnumeroCartaoInicio: Integer;
    fnumeroDocumentoDebito: Int64;
    farquivoPagamento: String;
    fquantidadeOcorrenciaPix: Integer;
    frequisicaoPagamento: Integer;
    fvalorPagamento: Double;
    function GetlistaDevolucao: TACBrPagamentoDevolucoes;
    function GetlistaPix: TACBrPixBBPagamentosEspecificos;
  protected
    procedure AssignSchema(aSource: TACBrAPISchema); override;
    procedure DoWriteToJSon(aJSon: TACBrJSONObject); override;
    procedure DoReadFromJSon(aJSon: TACBrJSONObject); override;
  public
    destructor Destroy; override;
    procedure Clear; override;
    function IsEmpty: Boolean; override;
    procedure Assign(aSource: TACBrPagamentoEspecificoPixResposta);

    property id: Int64 read fid write fid;
    property estadoPagamento: TACBrEstadoPagamento read festadoPagamento write festadoPagamento;
    property agenciaDebito: Int64 read fagenciaDebito write fagenciaDebito;
    property contaDebito: Int64 read fcontaDebito write fcontaDebito;
    property digitoContaDebito: String read fdigitoContaDebito write fdigitoContaDebito;
    property numeroCartaoInicio: Integer read fnumeroCartaoInicio write fnumeroCartaoInicio;
    property numeroCartaoFim: Integer read fnumeroCartaoFim write fnumeroCartaoFim;
    property requisicaoPagamento: Integer read frequisicaoPagamento write frequisicaoPagamento;
    property arquivoPagamento: String read farquivoPagamento write farquivoPagamento;
    property dataPagamento: TDateTime read fdataPagamento write fdataPagamento;
    property valorPagamento: Double read fvalorPagamento write fvalorPagamento;
    property numeroDocumentoDebito: Int64 read fnumeroDocumentoDebito write fnumeroDocumentoDebito;
    property autenticacaoPagamento: String read fautenticacaoPagamento write fautenticacaoPagamento;
    property descricaoPagamento: String read fdescricaoPagamento write fdescricaoPagamento;
    property quantidadeOcorrenciaPix: Integer read fquantidadeOcorrenciaPix write fquantidadeOcorrenciaPix;
    property listaPix: TACBrPixBBPagamentosEspecificos read GetlistaPix write flistaPix;
    property listaDevolucao: TACBrPagamentoDevolucoes read GetlistaDevolucao write flistaDevolucao;
  end;

function TransferenciaPixTipoPagamentoToInteger(const aValue: TACBrTransferenciaPixBBTipoPagamento): Integer;
function IntegerToTransferenciaPixTipoPagamento(const aValue: Integer): TACBrTransferenciaPixBBTipoPagamento;
function TransferenciaPixFormaIdentificacaoToInteger(const aValue: TACBrTransferenciaPixBBFormaIdentificacao): Integer;
function IntegerToTransferenciaPixFormaIdentificacao(const aValue: Integer): TACBrTransferenciaPixBBFormaIdentificacao;

implementation

uses
  ACBrUtil.Base;

function TransferenciaPixTipoPagamentoToInteger(const aValue: TACBrTransferenciaPixBBTipoPagamento): Integer;
begin
  Result := 0;
  case aValue of
    tptPagamentoFornecedores: Result := 126;
    tptPagamentoSalarios: Result := 127;
    tptPagamentosDiversos: Result := 128;
  end;
end;

function IntegerToTransferenciaPixTipoPagamento(const aValue: Integer): TACBrTransferenciaPixBBTipoPagamento;
begin
  Result := tptNenhum;
  case aValue of
    126: Result := tptPagamentoFornecedores;
    127: Result := tptPagamentoSalarios;
    128: Result := tptPagamentosDiversos;
  end;
end;

function TransferenciaPixFormaIdentificacaoToInteger(const aValue: TACBrTransferenciaPixBBFormaIdentificacao): Integer;
begin
  Result := 0;
  case aValue of
    tfiTelefone: Result := 1;
    tfiEmail: Result := 2;
    tfiCpfCnpj: Result := 3;
    tfiAleatoria: Result := 4;
    tfiDadosBancarios: Result := 5;
  end;
end;

function IntegerToTransferenciaPixFormaIdentificacao(const aValue: Integer): TACBrTransferenciaPixBBFormaIdentificacao;
begin
  Result := tfiNenhuma;
  case aValue of
    1: Result := tfiTelefone;
    2: Result := tfiEmail;
    3: Result := tfiCpfCnpj;
    4: Result := tfiAleatoria;
    5: Result := tfiDadosBancarios;
  end;
end;

function DateToJSONInt(const aValue: TDateTime): Int64;
begin
  Result := 0;
  if NaoEstaZerado(aValue) then
    Result := StrToIntDef(FormatDateTime('DDMMYYYY', aValue), 0);
end;

function DecodeDateInt(aValue: Int64): TDateTime;
var
  S: String;
  D, M, Y: Word;
begin
  Result := 0;
  if EstaZerado(aValue) then
    Exit;

  S := Format('%.8d', [aValue]);
  D := StrToIntDef(Copy(S, 1, 2), 0);
  M := StrToIntDef(Copy(S, 3, 2), 0);
  Y := StrToIntDef(Copy(S, 5, 4), 0);

  if (Y > 0) and (M in [1..12]) and (D in [1..31]) then
    Result := EncodeDate(Y, M, D);
end;

function DecodeDateStr(const aValue: String): TDateTime;
var
  S: String;
  D, M, Y: Word;
begin
  Result := 0;
  S := Trim(aValue);
  if EstaVazio(S) then
    Exit;

  if (Length(S) >= 10) and (S[5] = '-') and (S[8] = '-') then
  begin
    Y := StrToIntDef(Copy(S, 1, 4), 0);
    M := StrToIntDef(Copy(S, 6, 2), 0);
    D := StrToIntDef(Copy(S, 9, 2), 0);
    if (Y > 0) and (M in [1..12]) and (D in [1..31]) then
    begin
      Result := EncodeDate(Y, M, D);
      Exit;
    end;
  end;

  if (Length(S) >= 10) and (S[3] = '/') and (S[6] = '/') then
  begin
    D := StrToIntDef(Copy(S, 1, 2), 0);
    M := StrToIntDef(Copy(S, 4, 2), 0);
    Y := StrToIntDef(Copy(S, 7, 4), 0);
    if (Y > 0) and (M in [1..12]) and (D in [1..31]) then
    begin
      Result := EncodeDate(Y, M, D);
      Exit;
    end;
  end;

  Result := DecodeDateInt(StrToIntDef(S, 0));
end;

procedure ReadJSONDate(aJSon: TACBrJSONObject; const aName: String; out aValue: TDateTime);
var
  I: Int64;
  S: String;
begin
  I := 0;
  S := EmptyStr;
  aValue := 0;

  aJSon.Value(aName, I);
  if NaoEstaZerado(I) then
  begin
    aValue := DecodeDateInt(I);
    Exit;
  end;

  aJSon.Value(aName, S);
  if NaoEstaVazio(S) then
    aValue := DecodeDateStr(S);
end;

{ TACBrTransferenciaBBBase }

procedure TACBrTransferenciaBBBase.AssignSchema(aSource: TACBrAPISchema);
begin
  if (aSource is TACBrTransferenciaBBBase) then
    Assign(TACBrTransferenciaBBBase(aSource));
end;

procedure TACBrTransferenciaBBBase.DoWriteToJSon(aJSon: TACBrJSONObject);
begin
  aJSon
    .AddPair('numeroCOMPE', fnumeroCOMPE, False)
    .AddPair('numeroISPB', fnumeroISPB, False)
    .AddPair('agenciaCredito', fagenciaCredito, False)
    .AddPair('contaCorrenteCredito', fcontaCorrenteCredito, False)
    .AddPair('digitoVerificadorContaCorrente', fdigitoVerificadorContaCorrente, False)
    .AddPair('contaPagamentoCredito', fcontaPagamentoCredito, False)
    .AddPair('cpfBeneficiario', fcpfBeneficiario, False)
    .AddPair('cnpjBeneficiario', fcnpjBeneficiario, False)
    .AddPair('dataTransferencia', DateToJSONInt(fdataTransferencia), False)
    .AddPair('valorTransferencia', fvalorTransferencia, False)
    .AddPair('documentoDebito', fdocumentoDebito, False)
    .AddPair('documentoCredito', fdocumentoCredito, False)
    .AddPair('codigoFinalidadeDOC', fcodigoFinalidadeDOC, False)
    .AddPair('codigoFinalidadeTED', fcodigoFinalidadeTED, False)
    .AddPair('numeroDepositoJudicial', fnumeroDepositoJudicial, False)
    .AddPair('descricaoTransferencia', fdescricaoTransferencia, False);
end;

procedure TACBrTransferenciaBBBase.DoReadFromJSon(aJSon: TACBrJSONObject);
begin
  aJSon
    .Value('numeroCOMPE', fnumeroCOMPE)
    .Value('numeroISPB', fnumeroISPB)
    .Value('agenciaCredito', fagenciaCredito)
    .Value('contaCorrenteCredito', fcontaCorrenteCredito)
    .Value('digitoVerificadorContaCorrente', fdigitoVerificadorContaCorrente)
    .Value('contaPagamentoCredito', fcontaPagamentoCredito)
    .Value('cpfBeneficiario', fcpfBeneficiario)
    .Value('cnpjBeneficiario', fcnpjBeneficiario)
    .Value('valorTransferencia', fvalorTransferencia)
    .Value('documentoDebito', fdocumentoDebito)
    .Value('documentoCredito', fdocumentoCredito)
    .Value('codigoFinalidadeDOC', fcodigoFinalidadeDOC)
    .Value('codigoFinalidadeTED', fcodigoFinalidadeTED)
    .Value('numeroDepositoJudicial', fnumeroDepositoJudicial)
    .Value('descricaoTransferencia', fdescricaoTransferencia);
  ReadJSONDate(aJSon, 'dataTransferencia', fdataTransferencia);
end;

procedure TACBrTransferenciaBBBase.Clear;
begin
  fnumeroCOMPE := 0;
  fnumeroISPB := 0;
  fagenciaCredito := 0;
  fcontaCorrenteCredito := 0;
  fdigitoVerificadorContaCorrente := EmptyStr;
  fcontaPagamentoCredito := EmptyStr;
  fcpfBeneficiario := EmptyStr;
  fcnpjBeneficiario := EmptyStr;
  fdataTransferencia := 0;
  fvalorTransferencia := 0;
  fdocumentoDebito := 0;
  fdocumentoCredito := 0;
  fcodigoFinalidadeDOC := EmptyStr;
  fcodigoFinalidadeTED := EmptyStr;
  fnumeroDepositoJudicial := EmptyStr;
  fdescricaoTransferencia := EmptyStr;
end;

function TACBrTransferenciaBBBase.IsEmpty: Boolean;
begin
  Result :=
    EstaZerado(fnumeroCOMPE) and
    EstaZerado(fnumeroISPB) and
    EstaZerado(fagenciaCredito) and
    EstaZerado(fcontaCorrenteCredito) and
    EstaVazio(fdigitoVerificadorContaCorrente) and
    EstaVazio(fcontaPagamentoCredito) and
    EstaVazio(fcpfBeneficiario) and
    EstaVazio(fcnpjBeneficiario) and
    EstaZerado(fdataTransferencia) and
    EstaZerado(fvalorTransferencia) and
    EstaZerado(fdocumentoDebito) and
    EstaZerado(fdocumentoCredito) and
    EstaVazio(fcodigoFinalidadeDOC) and
    EstaVazio(fcodigoFinalidadeTED) and
    EstaVazio(fnumeroDepositoJudicial) and
    EstaVazio(fdescricaoTransferencia);
end;

procedure TACBrTransferenciaBBBase.Assign(aSource: TACBrTransferenciaBBBase);
begin
  if (not Assigned(aSource)) then
    Exit;

  fnumeroCOMPE := aSource.numeroCOMPE;
  fnumeroISPB := aSource.numeroISPB;
  fagenciaCredito := aSource.agenciaCredito;
  fcontaCorrenteCredito := aSource.contaCorrenteCredito;
  fdigitoVerificadorContaCorrente := aSource.digitoVerificadorContaCorrente;
  fcontaPagamentoCredito := aSource.contaPagamentoCredito;
  fcpfBeneficiario := aSource.cpfBeneficiario;
  fcnpjBeneficiario := aSource.cnpjBeneficiario;
  fdataTransferencia := aSource.dataTransferencia;
  fvalorTransferencia := aSource.valorTransferencia;
  fdocumentoDebito := aSource.documentoDebito;
  fdocumentoCredito := aSource.documentoCredito;
  fcodigoFinalidadeDOC := aSource.codigoFinalidadeDOC;
  fcodigoFinalidadeTED := aSource.codigoFinalidadeTED;
  fnumeroDepositoJudicial := aSource.numeroDepositoJudicial;
  fdescricaoTransferencia := aSource.descricaoTransferencia;
end;

{ TACBrTransferenciaBBResposta }

function TACBrTransferenciaBBResposta.Geterros: TACBrTransferenciaErros;
begin
  if not Assigned(ferros) then
    ferros := TACBrTransferenciaErros.Create('erros');
  Result := ferros;
end;

procedure TACBrTransferenciaBBResposta.AssignSchema(aSource: TACBrAPISchema);
begin
  if (aSource is TACBrTransferenciaBBResposta) then
    Assign(TACBrTransferenciaBBResposta(aSource))
  else
    inherited AssignSchema(aSource);
end;

procedure TACBrTransferenciaBBResposta.DoWriteToJSon(aJSon: TACBrJSONObject);
begin
  inherited DoWriteToJSon(aJSon);
  aJSon
    .AddPair('identificadorTransferencia', fidentificadorTransferencia, False)
    .AddPair('tipoCredito', ftipoCredito, False)
    .AddPair('indicadorAceite', findicadorAceite, False);
  if Assigned(ferros) then
    ferros.WriteToJSon(aJSon);
end;

procedure TACBrTransferenciaBBResposta.DoReadFromJSon(aJSon: TACBrJSONObject);
begin
  inherited DoReadFromJSon(aJSon);
  aJSon
    .Value('identificadorTransferencia', fidentificadorTransferencia)
    .Value('tipoCredito', ftipoCredito)
    .Value('indicadorAceite', findicadorAceite);
  erros.ReadFromJSon(aJSon);
end;

destructor TACBrTransferenciaBBResposta.Destroy;
begin
  if Assigned(ferros) then
    ferros.Free;
  inherited Destroy;
end;

procedure TACBrTransferenciaBBResposta.Clear;
begin
  inherited Clear;
  fidentificadorTransferencia := 0;
  ftipoCredito := 0;
  findicadorAceite := EmptyStr;
  if Assigned(ferros) then
    ferros.Clear;
end;

function TACBrTransferenciaBBResposta.IsEmpty: Boolean;
begin
  Result := inherited IsEmpty and
    EstaZerado(fidentificadorTransferencia) and
    EstaZerado(ftipoCredito) and
    EstaVazio(findicadorAceite);
  if Assigned(ferros) then
    Result := Result and ferros.IsEmpty;
end;

procedure TACBrTransferenciaBBResposta.Assign(aSource: TACBrTransferenciaBBResposta);
begin
  if (not Assigned(aSource)) then
    Exit;
  inherited Assign(aSource);
  fidentificadorTransferencia := aSource.identificadorTransferencia;
  ftipoCredito := aSource.tipoCredito;
  findicadorAceite := aSource.indicadorAceite;
  erros.Assign(aSource.erros);
end;

{ TACBrLoteTransferenciasRequisicao }

function TACBrLoteTransferenciasRequisicao.GetlistaTransferencias: TACBrTransferenciasBBRequisicao;
begin
  if not Assigned(flistaTransferencias) then
    flistaTransferencias := TACBrTransferenciasBBRequisicao.Create('listaTransferencias');
  Result := flistaTransferencias;
end;

procedure TACBrLoteTransferenciasRequisicao.AssignSchema(aSource: TACBrAPISchema);
begin
  if (aSource is TACBrLoteTransferenciasRequisicao) then
    Assign(TACBrLoteTransferenciasRequisicao(aSource));
end;

procedure TACBrLoteTransferenciasRequisicao.DoWriteToJSon(aJSon: TACBrJSONObject);
begin
  aJSon
    .AddPair('numeroRequisicao', fnumeroRequisicao, False)
    .AddPair('numeroContratoPagamento', fcodigoContrato, False)
    .AddPair('agenciaDebito', fagenciaDebito, False)
    .AddPair('contaCorrenteDebito', fcontaCorrenteDebito, False)
    .AddPair('digitoVerificadorContaCorrente', fdigitoVerificadorContaCorrenteDebito, False)
    .AddPair('tipoPagamento', ftipoPagamento, False);
  if Assigned(flistaTransferencias) then
    flistaTransferencias.WriteToJSon(aJSon);
end;

procedure TACBrLoteTransferenciasRequisicao.DoReadFromJSon(aJSon: TACBrJSONObject);
begin
  aJSon
    .Value('numeroRequisicao', fnumeroRequisicao)
    .Value('numeroContratoPagamento', fcodigoContrato)
    .Value('agenciaDebito', fagenciaDebito)
    .Value('contaCorrenteDebito', fcontaCorrenteDebito)
    .Value('digitoVerificadorContaCorrente', fdigitoVerificadorContaCorrenteDebito)
    .Value('tipoPagamento', ftipoPagamento);
  listaTransferencias.ReadFromJSon(aJSon);
end;

destructor TACBrLoteTransferenciasRequisicao.Destroy;
begin
  if Assigned(flistaTransferencias) then
    flistaTransferencias.Free;
  inherited Destroy;
end;

procedure TACBrLoteTransferenciasRequisicao.Clear;
begin
  fnumeroRequisicao := 0;
  fcodigoContrato := 0;
  fagenciaDebito := 0;
  fcontaCorrenteDebito := 0;
  fdigitoVerificadorContaCorrenteDebito := EmptyStr;
  ftipoPagamento := 0;
  if Assigned(flistaTransferencias) then
    flistaTransferencias.Clear;
end;

function TACBrLoteTransferenciasRequisicao.IsEmpty: Boolean;
begin
  Result :=
    EstaZerado(fnumeroRequisicao) and
    EstaZerado(fcodigoContrato) and
    EstaZerado(fagenciaDebito) and
    EstaZerado(fcontaCorrenteDebito) and
    EstaVazio(fdigitoVerificadorContaCorrenteDebito) and
    EstaZerado(ftipoPagamento);
  if Assigned(flistaTransferencias) then
    Result := Result and flistaTransferencias.IsEmpty;
end;

procedure TACBrLoteTransferenciasRequisicao.Assign(aSource: TACBrLoteTransferenciasRequisicao);
begin
  if (not Assigned(aSource)) then
    Exit;

  fnumeroRequisicao := aSource.numeroRequisicao;
  fcodigoContrato := aSource.codigoContrato;
  fagenciaDebito := aSource.agenciaDebito;
  fcontaCorrenteDebito := aSource.contaCorrenteDebito;
  fdigitoVerificadorContaCorrenteDebito := aSource.digitoVerificadorContaCorrenteDebito;
  ftipoPagamento := aSource.tipoPagamento;
  listaTransferencias.Assign(aSource.listaTransferencias);
end;

{ TACBrLoteTransferenciasResposta }

function TACBrLoteTransferenciasResposta.Gettransferencias: TACBrTransferenciasBBResposta;
begin
  if not Assigned(ftransferencias) then
    ftransferencias := TACBrTransferenciasBBResposta.Create('transferencias');
  Result := ftransferencias;
end;

procedure TACBrLoteTransferenciasResposta.AssignSchema(aSource: TACBrAPISchema);
begin
  if (aSource is TACBrLoteTransferenciasResposta) then
    Assign(TACBrLoteTransferenciasResposta(aSource));
end;

procedure TACBrLoteTransferenciasResposta.DoWriteToJSon(aJSon: TACBrJSONObject);
begin
  aJSon
    .AddPair('estadoRequisicao', festadoRequisicao, False)
    .AddPair('quantidadeTransferencias', fquantidadeTransferencias, False)
    .AddPair('valorTransferencias', fvalorTransferencias, False)
    .AddPair('quantidadeTransferenciasValidas', fquantidadeTransferenciasValidas, False)
    .AddPair('valorTransferenciasValidas', fvalorTransferenciasValidas, False);
  if Assigned(ftransferencias) then
    ftransferencias.WriteToJSon(aJSon);
end;

procedure TACBrLoteTransferenciasResposta.DoReadFromJSon(aJSon: TACBrJSONObject);
begin
  aJSon
    .Value('estadoRequisicao', festadoRequisicao)
    .Value('quantidadeTransferencias', fquantidadeTransferencias)
    .Value('valorTransferencias', fvalorTransferencias)
    .Value('quantidadeTransferenciasValidas', fquantidadeTransferenciasValidas)
    .Value('valorTransferenciasValidas', fvalorTransferenciasValidas);
  transferencias.ReadFromJSon(aJSon);
end;

destructor TACBrLoteTransferenciasResposta.Destroy;
begin
  if Assigned(ftransferencias) then
    ftransferencias.Free;
  inherited Destroy;
end;

procedure TACBrLoteTransferenciasResposta.Clear;
begin
  festadoRequisicao := 0;
  fquantidadeTransferencias := 0;
  fvalorTransferencias := 0;
  fquantidadeTransferenciasValidas := 0;
  fvalorTransferenciasValidas := 0;
  if Assigned(ftransferencias) then
    ftransferencias.Clear;
end;

function TACBrLoteTransferenciasResposta.IsEmpty: Boolean;
begin
  Result :=
    EstaZerado(festadoRequisicao) and
    EstaZerado(fquantidadeTransferencias) and
    EstaZerado(fvalorTransferencias) and
    EstaZerado(fquantidadeTransferenciasValidas) and
    EstaZerado(fvalorTransferenciasValidas);
  transferencias.IsEmpty;
end;

procedure TACBrLoteTransferenciasResposta.Assign(aSource: TACBrLoteTransferenciasResposta);
begin
  if (not Assigned(aSource)) then
    Exit;
  festadoRequisicao := aSource.estadoRequisicao;
  fquantidadeTransferencias := aSource.quantidadeTransferencias;
  fvalorTransferencias := aSource.valorTransferencias;
  fquantidadeTransferenciasValidas := aSource.quantidadeTransferenciasValidas;
  fvalorTransferenciasValidas := aSource.valorTransferenciasValidas;
  transferencias.Assign(aSource.transferencias);
end;

{ TACBrTransferenciaLoteBBConsulta }

procedure TACBrTransferenciaLoteBBConsulta.AssignSchema(aSource: TACBrAPISchema);
begin
  if (aSource is TACBrTransferenciaLoteBBConsulta) then
    Assign(TACBrTransferenciaLoteBBConsulta(aSource));
end;

procedure TACBrTransferenciaLoteBBConsulta.DoWriteToJSon(aJSon: TACBrJSONObject);
begin
  aJSon
    .AddPair('numeroRequisicao', fnumeroRequisicao, False)
    .AddPair('estadoRequisicao', festadoRequisicao, False)
    .AddPair('agenciaDebito', fagenciaDebito, False)
    .AddPair('contaCorrenteDebito', fcontaCorrenteDebito, False)
    .AddPair('digitoVerificadorContaCorrente', fdigitoVerificadorContaCorrenteDebito, False)
    .AddPair('dataRequisicao', DateToJSONInt(fdataRequisicao), False)
    .AddPair('tipoPagamento', ftipoPagamento, False)
    .AddPair('identificacaoRequisitante', fidentificacaoRequisitante, False)
    .AddPair('quantidadeTransferencias', fquantidadeTransferencias, False)
    .AddPair('totalTransferencias', ftotalTransferencias, False)
    .AddPair('quantidadeTransferenciasValidas', fquantidadeTransferenciasValidas, False)
    .AddPair('totalTransferenciasValidas', ftotalTransferenciasValidas, False);
end;

procedure TACBrTransferenciaLoteBBConsulta.DoReadFromJSon(aJSon: TACBrJSONObject);
begin
  aJSon
    .Value('numeroRequisicao', fnumeroRequisicao)
    .Value('estadoRequisicao', festadoRequisicao)
    .Value('agenciaDebito', fagenciaDebito)
    .Value('contaCorrenteDebito', fcontaCorrenteDebito)
    .Value('digitoVerificadorContaCorrente', fdigitoVerificadorContaCorrenteDebito)
    .Value('tipoPagamento', ftipoPagamento)
    .Value('identificacaoRequisitante', fidentificacaoRequisitante)
    .Value('quantidadeTransferencias', fquantidadeTransferencias)
    .Value('totalTransferencias', ftotalTransferencias)
    .Value('quantidadeTransferenciasValidas', fquantidadeTransferenciasValidas)
    .Value('totalTransferenciasValidas', ftotalTransferenciasValidas);
  ReadJSONDate(aJSon, 'dataRequisicao', fdataRequisicao);
end;

procedure TACBrTransferenciaLoteBBConsulta.Clear;
begin
  fnumeroRequisicao := 0;
  festadoRequisicao := 0;
  fagenciaDebito := 0;
  fcontaCorrenteDebito := 0;
  fdigitoVerificadorContaCorrenteDebito := EmptyStr;
  fdataRequisicao := 0;
  ftipoPagamento := 0;
  fidentificacaoRequisitante := EmptyStr;
  fquantidadeTransferencias := 0;
  ftotalTransferencias := 0;
  fquantidadeTransferenciasValidas := 0;
  ftotalTransferenciasValidas := 0;
end;

function TACBrTransferenciaLoteBBConsulta.IsEmpty: Boolean;
begin
  Result :=
    EstaZerado(fnumeroRequisicao) and
    EstaZerado(festadoRequisicao) and
    EstaZerado(fagenciaDebito) and
    EstaZerado(fcontaCorrenteDebito) and
    EstaVazio(fdigitoVerificadorContaCorrenteDebito) and
    EstaZerado(fdataRequisicao) and
    EstaZerado(ftipoPagamento) and
    EstaVazio(fidentificacaoRequisitante) and
    EstaZerado(fquantidadeTransferencias) and
    EstaZerado(ftotalTransferencias) and
    EstaZerado(fquantidadeTransferenciasValidas) and
    EstaZerado(ftotalTransferenciasValidas);
end;

procedure TACBrTransferenciaLoteBBConsulta.Assign(aSource: TACBrTransferenciaLoteBBConsulta);
begin
  fnumeroRequisicao := aSource.numeroRequisicao;
  festadoRequisicao := aSource.estadoRequisicao;
  fagenciaDebito := aSource.agenciaDebito;
  fcontaCorrenteDebito := aSource.contaCorrenteDebito;
  fdigitoVerificadorContaCorrenteDebito := aSource.digitoVerificadorContaCorrenteDebito;
  fdataRequisicao := aSource.dataRequisicao;
  ftipoPagamento := aSource.tipoPagamento;
  fidentificacaoRequisitante := aSource.identificacaoRequisitante;
  fquantidadeTransferencias := aSource.quantidadeTransferencias;
  ftotalTransferencias := aSource.totalTransferencias;
  fquantidadeTransferenciasValidas := aSource.quantidadeTransferenciasValidas;
  ftotalTransferenciasValidas := aSource.totalTransferenciasValidas;
end;

{ TACBrPagamentoLoteBBConsulta }

function TACBrPagamentoLoteBBConsulta.Geterros: TACBrTransferenciaErros;
begin
  if not Assigned(ferros) then
    ferros := TACBrTransferenciaErros.Create('erros');
  Result := ferros;
end;

procedure TACBrPagamentoLoteBBConsulta.AssignSchema(aSource: TACBrAPISchema);
begin
  if (aSource is TACBrPagamentoLoteBBConsulta) then
    Assign(TACBrPagamentoLoteBBConsulta(aSource));
end;

procedure TACBrPagamentoLoteBBConsulta.DoWriteToJSon(aJSon: TACBrJSONObject);
begin
  aJSon
    .AddPair('identificadorPagamento', fidentificadorPagamento, False)
    .AddPair('numeroCOMPE', fnumeroCOMPE, False)
    .AddPair('numeroISPB', fnumeroISPB, False)
    .AddPair('agenciaCredito', fagenciaCredito, False)
    .AddPair('contaCorrenteCredito', fcontaCorrenteCredito, False)
    .AddPair('digitoVerificadorContaCorrente', fdigitoVerificadorContaCorrente, False)
    .AddPair('contaPagamentoCredito', fcontaPagamentoCredito, False)
    .AddPair('cpfBeneficiario', fcpfBeneficiario, False)
    .AddPair('cnpjBeneficiario', fcnpjBeneficiario, False)
    .AddPair('dataPagamento', DateToJSONInt(fdataPagamento), False)
    .AddPair('valorPagamento', fvalorPagamento, False)
    .AddPair('documentoDebito', fdocumentoDebito, False)
    .AddPair('documentoCredito', fdocumentoCredito, False)
    .AddPair('tipoCredito', ftipoCredito, False)
    .AddPair('codigoFinalidadeDOC', fcodigoFinalidadeDOC, False)
    .AddPair('codigoFinalidadeTED', fcodigoFinalidadeTED, False)
    .AddPair('numeroDepositoJudicial', fnumeroDepositoJudicial, False)
    .AddPair('descricaoPagamento', fdescricaoPagamento, False)
    .AddPair('indicadorAceite', findicadorAceite, False);
  if Assigned(ferros) then
    ferros.WriteToJSon(aJSon);
end;

procedure TACBrPagamentoLoteBBConsulta.DoReadFromJSon(aJSon: TACBrJSONObject);
begin
  aJSon
    .Value('identificadorPagamento', fidentificadorPagamento)
    .Value('numeroCOMPE', fnumeroCOMPE)
    .Value('numeroISPB', fnumeroISPB)
    .Value('agenciaCredito', fagenciaCredito)
    .Value('contaCorrenteCredito', fcontaCorrenteCredito)
    .Value('digitoVerificadorContaCorrente', fdigitoVerificadorContaCorrente)
    .Value('contaPagamentoCredito', fcontaPagamentoCredito)
    .Value('cpfBeneficiario', fcpfBeneficiario)
    .Value('cnpjBeneficiario', fcnpjBeneficiario)
    .Value('valorPagamento', fvalorPagamento)
    .Value('documentoDebito', fdocumentoDebito)
    .Value('documentoCredito', fdocumentoCredito)
    .Value('tipoCredito', ftipoCredito)
    .Value('codigoFinalidadeDOC', fcodigoFinalidadeDOC)
    .Value('codigoFinalidadeTED', fcodigoFinalidadeTED)
    .Value('numeroDepositoJudicial', fnumeroDepositoJudicial)
    .Value('descricaoPagamento', fdescricaoPagamento)
    .Value('indicadorAceite', findicadorAceite);
  ReadJSONDate(aJSon, 'dataPagamento', fdataPagamento);
  erros.ReadFromJSon(aJSon);
end;

destructor TACBrPagamentoLoteBBConsulta.Destroy;
begin
  if Assigned(ferros) then
    ferros.Free;
  inherited Destroy;
end;

procedure TACBrPagamentoLoteBBConsulta.Clear;
begin
  fidentificadorPagamento := 0;
  fnumeroCOMPE := 0;
  fnumeroISPB := 0;
  fagenciaCredito := 0;
  fcontaCorrenteCredito := 0;
  fdigitoVerificadorContaCorrente := EmptyStr;
  fcontaPagamentoCredito := EmptyStr;
  fcpfBeneficiario := EmptyStr;
  fcnpjBeneficiario := EmptyStr;
  fdataPagamento := 0;
  fvalorPagamento := 0;
  fdocumentoDebito := 0;
  fdocumentoCredito := 0;
  ftipoCredito := 0;
  fcodigoFinalidadeDOC := EmptyStr;
  fcodigoFinalidadeTED := EmptyStr;
  fnumeroDepositoJudicial := EmptyStr;
  fdescricaoPagamento := EmptyStr;
  findicadorAceite := EmptyStr;
  if Assigned(ferros) then
    ferros.Clear;
end;

function TACBrPagamentoLoteBBConsulta.IsEmpty: Boolean;
begin
  Result :=
    EstaZerado(fidentificadorPagamento) and
    EstaZerado(fnumeroCOMPE) and
    EstaZerado(fnumeroISPB) and
    EstaZerado(fagenciaCredito) and
    EstaZerado(fcontaCorrenteCredito) and
    EstaVazio(fdigitoVerificadorContaCorrente) and
    EstaVazio(fcontaPagamentoCredito) and
    EstaVazio(fcpfBeneficiario) and
    EstaVazio(fcnpjBeneficiario) and
    EstaZerado(fdataPagamento) and
    EstaZerado(fvalorPagamento) and
    EstaZerado(fdocumentoDebito) and
    EstaZerado(fdocumentoCredito) and
    EstaZerado(ftipoCredito) and
    EstaVazio(fcodigoFinalidadeDOC) and
    EstaVazio(fcodigoFinalidadeTED) and
    EstaVazio(fnumeroDepositoJudicial) and
    EstaVazio(fdescricaoPagamento) and
    EstaVazio(findicadorAceite);
  if Assigned(ferros) then
    Result := Result and ferros.IsEmpty;
end;

procedure TACBrPagamentoLoteBBConsulta.Assign(aSource: TACBrPagamentoLoteBBConsulta);
begin
  if (not Assigned(aSource)) then
    Exit;
  fidentificadorPagamento := aSource.identificadorPagamento;
  fnumeroCOMPE := aSource.numeroCOMPE;
  fnumeroISPB := aSource.numeroISPB;
  fagenciaCredito := aSource.agenciaCredito;
  fcontaCorrenteCredito := aSource.contaCorrenteCredito;
  fdigitoVerificadorContaCorrente := aSource.digitoVerificadorContaCorrente;
  fcontaPagamentoCredito := aSource.contaPagamentoCredito;
  fcpfBeneficiario := aSource.cpfBeneficiario;
  fcnpjBeneficiario := aSource.cnpjBeneficiario;
  fdataPagamento := aSource.dataPagamento;
  fvalorPagamento := aSource.valorPagamento;
  fdocumentoDebito := aSource.documentoDebito;
  fdocumentoCredito := aSource.documentoCredito;
  ftipoCredito := aSource.tipoCredito;
  fcodigoFinalidadeDOC := aSource.codigoFinalidadeDOC;
  fcodigoFinalidadeTED := aSource.codigoFinalidadeTED;
  fnumeroDepositoJudicial := aSource.numeroDepositoJudicial;
  fdescricaoPagamento := aSource.descricaoPagamento;
  findicadorAceite := aSource.indicadorAceite;
  erros.Assign(aSource.erros);
end;

{ TACBrLoteTransferenciasRespostaConsulta }

function TACBrLoteTransferenciasRespostaConsulta.Getpagamentos: TACBrPagamentosLoteBBConsulta;
begin
  if not Assigned(fpagamentos) then
    fpagamentos := TACBrPagamentosLoteBBConsulta.Create('pagamentos');
  Result := fpagamentos;
end;

procedure TACBrLoteTransferenciasRespostaConsulta.AssignSchema(aSource: TACBrAPISchema);
begin
  if (aSource is TACBrLoteTransferenciasRespostaConsulta) then
    Assign(TACBrLoteTransferenciasRespostaConsulta(aSource));
end;

procedure TACBrLoteTransferenciasRespostaConsulta.DoWriteToJSon(aJSon: TACBrJSONObject);
begin
  aJSon
    .AddPair('estadoRequisicao', festadoRequisicao, False)
    .AddPair('quantidadePagamentos', fquantidadePagamentos, False)
    .AddPair('valorPagamentos', fvalorPagamentos, False)
    .AddPair('quantidadePagamentosValidos', fquantidadePagamentosValidos, False)
    .AddPair('valorPagamentosValidos', fvalorPagamentosValidos, False);
  if Assigned(fpagamentos) then
    fpagamentos.WriteToJSon(aJSon);
end;

procedure TACBrLoteTransferenciasRespostaConsulta.DoReadFromJSon(aJSon: TACBrJSONObject);
begin
  aJSon
    .Value('estadoRequisicao', festadoRequisicao)
    .Value('quantidadePagamentos', fquantidadePagamentos)
    .Value('valorPagamentos', fvalorPagamentos)
    .Value('quantidadePagamentosValidos', fquantidadePagamentosValidos)
    .Value('valorPagamentosValidos', fvalorPagamentosValidos);
  pagamentos.ReadFromJSon(aJSon);
end;

destructor TACBrLoteTransferenciasRespostaConsulta.Destroy;
begin
  if Assigned(fpagamentos) then
    fpagamentos.Free;
  inherited Destroy;
end;

procedure TACBrLoteTransferenciasRespostaConsulta.Clear;
begin
  festadoRequisicao := 0;
  fquantidadePagamentos := 0;
  fvalorPagamentos := 0;
  fquantidadePagamentosValidos := 0;
  fvalorPagamentosValidos := 0;
  if Assigned(fpagamentos) then
    fpagamentos.Clear;
end;

function TACBrLoteTransferenciasRespostaConsulta.IsEmpty: Boolean;
begin
  Result :=
    EstaZerado(festadoRequisicao) and
    EstaZerado(fquantidadePagamentos) and
    EstaZerado(fvalorPagamentos) and
    EstaZerado(fquantidadePagamentosValidos) and
    EstaZerado(fvalorPagamentosValidos);
  if Assigned(fpagamentos) then
    Result := Result and fpagamentos.IsEmpty;
end;

procedure TACBrLoteTransferenciasRespostaConsulta.Assign(aSource: TACBrLoteTransferenciasRespostaConsulta);
begin
  if (not Assigned(aSource)) then
    Exit;
  festadoRequisicao := aSource.estadoRequisicao;
  fquantidadePagamentos := aSource.quantidadePagamentos;
  fvalorPagamentos := aSource.valorPagamentos;
  fquantidadePagamentosValidos := aSource.quantidadePagamentosValidos;
  fvalorPagamentosValidos := aSource.valorPagamentosValidos;
  pagamentos.Assign(aSource.pagamentos);
end;

{ TACBrTransferenciaBBPagamentoEspecifico }

procedure TACBrTransferenciaBBPagamentoEspecifico.AssignSchema(aSource: TACBrAPISchema);
begin
  if (aSource is TACBrTransferenciaBBPagamentoEspecifico) then
    Assign(TACBrTransferenciaBBPagamentoEspecifico(aSource));
end;

procedure TACBrTransferenciaBBPagamentoEspecifico.DoWriteToJSon(aJSon: TACBrJSONObject);
begin
  aJSon
    .AddPair('numeroCOMPE', fnumeroCOMPE, False)
    .AddPair('numeroISPB', fnumeroISPB, False)
    .AddPair('agenciaCredito', fagenciaCredito, False)
    .AddPair('contaCorrenteCredito', fcontaCorrenteCredito, False)
    .AddPair('digitoVerificadorContaCorrente', fdigitoVerificadorContaCorrente, False)
    .AddPair('numeroContaCredito', fnumeroContaCredito, False)
    .AddPair('tipoBeneficiario', ftipoBeneficiario, False)
    .AddPair('cpfCnpjBeneficiario', fcpfCnpjBeneficiario, False)
    .AddPair('nomeBeneficiario', fnomeBeneficiario, False)
    .AddPair('documentoCredito', fdocumentoCredito, False)
    .AddPair('texto', ftexto, False);
end;

procedure TACBrTransferenciaBBPagamentoEspecifico.DoReadFromJSon(aJSon: TACBrJSONObject);
begin
  aJSon
    .Value('numeroCOMPE', fnumeroCOMPE)
    .Value('numeroISPB', fnumeroISPB)
    .Value('agenciaCredito', fagenciaCredito)
    .Value('contaCorrenteCredito', fcontaCorrenteCredito)
    .Value('digitoVerificadorContaCorrente', fdigitoVerificadorContaCorrente)
    .Value('numeroContaCredito', fnumeroContaCredito)
    .Value('tipoBeneficiario', ftipoBeneficiario)
    .Value('cpfCnpjBeneficiario', fcpfCnpjBeneficiario)
    .Value('nomeBeneficiario', fnomeBeneficiario)
    .Value('documentoCredito', fdocumentoCredito)
    .Value('texto', ftexto);
end;

procedure TACBrTransferenciaBBPagamentoEspecifico.Clear;
begin
  fnumeroCOMPE := 0;
  fnumeroISPB := 0;
  fagenciaCredito := 0;
  fcontaCorrenteCredito := 0;
  fdigitoVerificadorContaCorrente := EmptyStr;
  fnumeroContaCredito := EmptyStr;
  ftipoBeneficiario := 0;
  fcpfCnpjBeneficiario := EmptyStr;
  fnomeBeneficiario := EmptyStr;
  fdocumentoCredito := 0;
  ftexto := EmptyStr;
end;

function TACBrTransferenciaBBPagamentoEspecifico.IsEmpty: Boolean;
begin
  Result :=
    EstaZerado(fnumeroCOMPE) and
    EstaZerado(fnumeroISPB) and
    EstaZerado(fagenciaCredito) and
    EstaZerado(fcontaCorrenteCredito) and
    EstaVazio(fdigitoVerificadorContaCorrente) and
    EstaVazio(fnumeroContaCredito) and
    EstaZerado(ftipoBeneficiario) and
    EstaVazio(fcpfCnpjBeneficiario) and
    EstaVazio(fnomeBeneficiario) and
    EstaZerado(fdocumentoCredito) and
    EstaVazio(ftexto);
end;

procedure TACBrTransferenciaBBPagamentoEspecifico.Assign(aSource: TACBrTransferenciaBBPagamentoEspecifico);
begin
  if (not Assigned(aSource)) then
    Exit;
  fnumeroCOMPE := aSource.numeroCOMPE;
  fnumeroISPB := aSource.numeroISPB;
  fagenciaCredito := aSource.agenciaCredito;
  fcontaCorrenteCredito := aSource.contaCorrenteCredito;
  fdigitoVerificadorContaCorrente := aSource.digitoVerificadorContaCorrente;
  fnumeroContaCredito := aSource.numeroContaCredito;
  ftipoBeneficiario := aSource.tipoBeneficiario;
  fcpfCnpjBeneficiario := aSource.cpfCnpjBeneficiario;
  fnomeBeneficiario := aSource.nomeBeneficiario;
  fdocumentoCredito := aSource.documentoCredito;
  ftexto := aSource.texto;
end;

{ TACBrPagamentoEspecificoTransferenciaResposta }

function TACBrPagamentoEspecificoTransferenciaResposta.GetlistaDevolucao: TACBrPagamentoDevolucoes;
begin
  if not Assigned(flistaDevolucao) then
    flistaDevolucao := TACBrPagamentoDevolucoes.Create('listaDevolucao');
  Result := flistaDevolucao;
end;

function TACBrPagamentoEspecificoTransferenciaResposta.GetlistaPagamentos: TACBrTransferenciaPagamentosBBEspecificos;
begin
  if not Assigned(flistaPagamentos) then
    flistaPagamentos := TACBrTransferenciaPagamentosBBEspecificos.Create('listaPagamentos');
  Result := flistaPagamentos;
end;

procedure TACBrPagamentoEspecificoTransferenciaResposta.AssignSchema(aSource: TACBrAPISchema);
begin
  if (aSource is TACBrPagamentoEspecificoTransferenciaResposta) then
    Assign(TACBrPagamentoEspecificoTransferenciaResposta(aSource));
end;

procedure TACBrPagamentoEspecificoTransferenciaResposta.DoWriteToJSon(aJSon: TACBrJSONObject);
begin
  aJSon
    .AddPair('id', fid, False)
    .AddPair('estadoPagamento', EstadoPagamentoToString(festadoPagamento), False)
    .AddPair('tipoCredito', ftipoCredito, False)
    .AddPair('agenciaDebito', fagenciaDebito, False)
    .AddPair('contaCorrenteDebito', fcontaCorrenteDebito, False)
    .AddPair('digitoVerificadorContaCorrente', fdigitoVerificadorContaCorrente, False)
    .AddPair('inicioCartaoCredito', finicioCartaoCredito, False)
    .AddPair('fimCartaoCredito', ffimCartaoCredito, False)
    .AddPair('dataPagamento', DateToJSONInt(fdataPagamento), False)
    .AddPair('valorPagamento', fvalorPagamento, False)
    .AddPair('documentoDebito', fdocumentoDebito, False)
    .AddPair('codigoAutenticacaoPagamento', fcodigoAutenticacaoPagamento, False)
    .AddPair('numeroDepositoJudicial', fnumeroDepositoJudicial, False)
    .AddPair('codigoFinalidadeDOC', fcodigoFinalidadeDOC, False)
    .AddPair('codigoFinalidadeTED', fcodigoFinalidadeTED, False);
  if Assigned(flistaPagamentos) then
    flistaPagamentos.WriteToJSon(aJSon);
  if Assigned(flistaDevolucao) then
    flistaDevolucao.WriteToJSon(aJSon);
end;

procedure TACBrPagamentoEspecificoTransferenciaResposta.DoReadFromJSon(aJSon: TACBrJSONObject);
var
  S: String;
begin
  S := EmptyStr;
  aJSon
    .Value('id', fid)
    .Value('estadoPagamento', S)
    .Value('tipoCredito', ftipoCredito)
    .Value('agenciaDebito', fagenciaDebito)
    .Value('contaCorrenteDebito', fcontaCorrenteDebito)
    .Value('digitoVerificadorContaCorrente', fdigitoVerificadorContaCorrente)
    .Value('inicioCartaoCredito', finicioCartaoCredito)
    .Value('fimCartaoCredito', ffimCartaoCredito)
    .Value('valorPagamento', fvalorPagamento)
    .Value('documentoDebito', fdocumentoDebito)
    .Value('codigoAutenticacaoPagamento', fcodigoAutenticacaoPagamento)
    .Value('numeroDepositoJudicial', fnumeroDepositoJudicial)
    .Value('codigoFinalidadeDOC', fcodigoFinalidadeDOC)
    .Value('codigoFinalidadeTED', fcodigoFinalidadeTED);
  if NaoEstaVazio(S) then
    festadoPagamento := StringToEstadoPagamento(S);
  ReadJSONDate(aJSon, 'dataPagamento', fdataPagamento);
  listaPagamentos.ReadFromJSon(aJSon);
  listaDevolucao.ReadFromJSon(aJSon);
end;

destructor TACBrPagamentoEspecificoTransferenciaResposta.Destroy;
begin
  if Assigned(flistaPagamentos) then
    flistaPagamentos.Free;
  if Assigned(flistaDevolucao) then
    flistaDevolucao.Free;
  inherited Destroy;
end;

procedure TACBrPagamentoEspecificoTransferenciaResposta.Clear;
begin
  fid := 0;
  festadoPagamento := epgNenhum;
  ftipoCredito := 0;
  fagenciaDebito := 0;
  fcontaCorrenteDebito := 0;
  fdigitoVerificadorContaCorrente := EmptyStr;
  finicioCartaoCredito := 0;
  ffimCartaoCredito := 0;
  fdataPagamento := 0;
  fvalorPagamento := 0;
  fdocumentoDebito := 0;
  fcodigoAutenticacaoPagamento := EmptyStr;
  fnumeroDepositoJudicial := EmptyStr;
  fcodigoFinalidadeDOC := EmptyStr;
  fcodigoFinalidadeTED := EmptyStr;
  if Assigned(flistaPagamentos) then
    flistaPagamentos.Clear;
  if Assigned(flistaDevolucao) then
    flistaDevolucao.Clear;
end;

function TACBrPagamentoEspecificoTransferenciaResposta.IsEmpty: Boolean;
begin
  Result :=
    EstaZerado(fid) and
    (festadoPagamento = epgNenhum) and
    EstaZerado(ftipoCredito) and
    EstaZerado(fagenciaDebito) and
    EstaZerado(fcontaCorrenteDebito) and
    EstaVazio(fdigitoVerificadorContaCorrente) and
    EstaZerado(finicioCartaoCredito) and
    EstaZerado(ffimCartaoCredito) and
    EstaZerado(fdataPagamento) and
    EstaZerado(fvalorPagamento) and
    EstaZerado(fdocumentoDebito) and
    EstaVazio(fcodigoAutenticacaoPagamento) and
    EstaVazio(fnumeroDepositoJudicial) and
    EstaVazio(fcodigoFinalidadeDOC) and
    EstaVazio(fcodigoFinalidadeTED);
  if Assigned(flistaPagamentos) then
    Result := Result and flistaPagamentos.IsEmpty;
  if Assigned(flistaDevolucao) then
    Result := Result and flistaDevolucao.IsEmpty;
end;

procedure TACBrPagamentoEspecificoTransferenciaResposta.Assign(aSource: TACBrPagamentoEspecificoTransferenciaResposta);
begin
  if (not Assigned(aSource)) then
    Exit;
  fid := aSource.id;
  festadoPagamento := aSource.estadoPagamento;
  ftipoCredito := aSource.tipoCredito;
  fagenciaDebito := aSource.agenciaDebito;
  fcontaCorrenteDebito := aSource.contaCorrenteDebito;
  fdigitoVerificadorContaCorrente := aSource.digitoVerificadorContaCorrente;
  finicioCartaoCredito := aSource.inicioCartaoCredito;
  ffimCartaoCredito := aSource.fimCartaoCredito;
  fdataPagamento := aSource.dataPagamento;
  fvalorPagamento := aSource.valorPagamento;
  fdocumentoDebito := aSource.documentoDebito;
  fcodigoAutenticacaoPagamento := aSource.codigoAutenticacaoPagamento;
  fnumeroDepositoJudicial := aSource.numeroDepositoJudicial;
  fcodigoFinalidadeDOC := aSource.codigoFinalidadeDOC;
  fcodigoFinalidadeTED := aSource.codigoFinalidadeTED;
  listaPagamentos.Assign(aSource.listaPagamentos);
  listaDevolucao.Assign(aSource.listaDevolucao);
end;

{ TACBrTransferenciaPixBase }

procedure TACBrTransferenciaPixBase.AssignSchema(aSource: TACBrAPISchema);
begin
  if (aSource is TACBrTransferenciaPixBase) then
    Assign(TACBrTransferenciaPixBase(aSource));
end;

procedure TACBrTransferenciaPixBase.DoWriteToJSon(aJSon: TACBrJSONObject);
begin
  aJSon
    .AddPair('data', DateToJSONInt(fdataTransferencia), False)
    .AddPair('valor', fvalorTransferencia, False)
    .AddPair('documentoDebito', fdocumentoDebito, False)
    .AddPair('documentoCredito', fdocumentoCredito, False)
    .AddPair('descricaoPagamento', fdescricaoPagamento, False)
    .AddPair('descricaoPagamentoInstantaneo', fdescricaoPagamentoInstantaneo, False)
    .AddPair('formaIdentificacao', TransferenciaPixFormaIdentificacaoToInteger(fformaIdentificacao), False)
    .AddPair('dddTelefone', fdddTelefone, False)
    .AddPair('telefone', ftelefone, False)
    .AddPair('email', femail, False)
    .AddPair('cpf', fcpf, False)
    .AddPair('cnpj', fcnpj, False)
    .AddPair('identificacaoAleatoria', fidentificacaoAleatoria, False)
    .AddPair('numeroCOMPE', fnumeroCOMPE, False)
    .AddPair('numeroISPB', fnumeroISPB, False)
    .AddPair('tipoConta', ftipoConta, False)
    .AddPair('agencia', fagencia, False)
    .AddPair('conta', fconta, False)
    .AddPair('digitoVerificadorConta', fdigitoVerificadorConta, False)
    .AddPair('contaPagamento', fcontaPagamento, False);
end;

procedure TACBrTransferenciaPixBase.DoReadFromJSon(aJSon: TACBrJSONObject);
var
  iFormaIdentificacao: Integer;
begin
  iFormaIdentificacao := 0;
  aJSon
    .Value('valor', fvalorTransferencia)
    .Value('documentoDebito', fdocumentoDebito)
    .Value('documentoCredito', fdocumentoCredito)
    .Value('descricaoPagamento', fdescricaoPagamento)
    .Value('descricaoPagamentoInstantaneo', fdescricaoPagamentoInstantaneo)
    .Value('formaIdentificacao', iFormaIdentificacao)
    .Value('dddTelefone', fdddTelefone)
    .Value('telefone', ftelefone)
    .Value('email', femail)
    .Value('cpf', fcpf)
    .Value('cnpj', fcnpj)
    .Value('identificacaoAleatoria', fidentificacaoAleatoria)
    .Value('numeroCOMPE', fnumeroCOMPE)
    .Value('numeroISPB', fnumeroISPB)
    .Value('tipoConta', ftipoConta)
    .Value('agencia', fagencia)
    .Value('conta', fconta)
    .Value('digitoVerificadorConta', fdigitoVerificadorConta)
    .Value('contaPagamento', fcontaPagamento);
  if NaoEstaZerado(iFormaIdentificacao) then
    fformaIdentificacao := IntegerToTransferenciaPixFormaIdentificacao(iFormaIdentificacao);
  ReadJSONDate(aJSon, 'data', fdataTransferencia);
end;

procedure TACBrTransferenciaPixBase.Clear;
begin
  fdataTransferencia := 0;
  fvalorTransferencia := 0;
  fdocumentoDebito := 0;
  fdocumentoCredito := 0;
  fdescricaoPagamento := EmptyStr;
  fdescricaoPagamentoInstantaneo := EmptyStr;
  fformaIdentificacao := tfiNenhuma;
  fdddTelefone := 0;
  ftelefone := 0;
  femail := EmptyStr;
  fcpf := EmptyStr;
  fcnpj := EmptyStr;
  fidentificacaoAleatoria := EmptyStr;
  fnumeroCOMPE := 0;
  fnumeroISPB := 0;
  ftipoConta := 0;
  fagencia := 0;
  fconta := 0;
  fdigitoVerificadorConta := EmptyStr;
  fcontaPagamento := EmptyStr;
end;

function TACBrTransferenciaPixBase.IsEmpty: Boolean;
begin
  Result :=
    EstaZerado(fdataTransferencia) and
    EstaZerado(fvalorTransferencia) and
    EstaZerado(fdocumentoDebito) and
    EstaZerado(fdocumentoCredito) and
    EstaVazio(fdescricaoPagamento) and
    EstaVazio(fdescricaoPagamentoInstantaneo) and
    EstaZerado(Ord(fformaIdentificacao)) and
    EstaZerado(fdddTelefone) and
    EstaZerado(ftelefone) and
    EstaVazio(femail) and
    EstaVazio(fcpf) and
    EstaVazio(fcnpj) and
    EstaVazio(fidentificacaoAleatoria) and
    EstaZerado(fnumeroCOMPE) and
    EstaZerado(fnumeroISPB) and
    EstaZerado(ftipoConta) and
    EstaZerado(fagencia) and
    EstaZerado(fconta) and
    EstaVazio(fdigitoVerificadorConta) and
    EstaVazio(fcontaPagamento);
end;

procedure TACBrTransferenciaPixBase.Assign(aSource: TACBrTransferenciaPixBase);
begin
  if (not Assigned(aSource)) then
    Exit;
  fdataTransferencia := aSource.dataTransferencia;
  fvalorTransferencia := aSource.valorTransferencia;
  fdocumentoDebito := aSource.documentoDebito;
  fdocumentoCredito := aSource.documentoCredito;
  fdescricaoPagamento := aSource.descricaoPagamento;
  fdescricaoPagamentoInstantaneo := aSource.descricaoPagamentoInstantaneo;
  fformaIdentificacao := aSource.formaIdentificacao;
  fdddTelefone := aSource.dddTelefone;
  ftelefone := aSource.telefone;
  femail := aSource.email;
  fcpf := aSource.cpf;
  fcnpj := aSource.cnpj;
  fidentificacaoAleatoria := aSource.identificacaoAleatoria;
  fnumeroCOMPE := aSource.numeroCOMPE;
  fnumeroISPB := aSource.numeroISPB;
  ftipoConta := aSource.tipoConta;
  fagencia := aSource.agencia;
  fconta := aSource.conta;
  fdigitoVerificadorConta := aSource.digitoVerificadorConta;
  fcontaPagamento := aSource.contaPagamento;
end;

{ TACBrTransferenciaPixBBResposta }

function TACBrTransferenciaPixBBResposta.Geterros: TACBrTransferenciaErros;
begin
  if not Assigned(ferros) then
    ferros := TACBrTransferenciaErros.Create('erros');
  Result := ferros;
end;

procedure TACBrTransferenciaPixBBResposta.AssignSchema(aSource: TACBrAPISchema);
begin
  if (aSource is TACBrTransferenciaPixBBResposta) then
    Assign(TACBrTransferenciaPixBBResposta(aSource))
  else
    inherited AssignSchema(aSource);
end;

procedure TACBrTransferenciaPixBBResposta.DoWriteToJSon(aJSon: TACBrJSONObject);
begin
  inherited DoWriteToJSon(aJSon);
  aJSon
    .AddPair('identificadorPagamento', fidentificadorPagamento, False)
    .AddPair('indicadorMovimentoAceito', findicadorMovimentoAceito, False);
  if Assigned(ferros) then
    ferros.WriteToJSon(aJSon);
end;

procedure TACBrTransferenciaPixBBResposta.DoReadFromJSon(aJSon: TACBrJSONObject);
begin
  inherited DoReadFromJSon(aJSon);
  aJSon
    .Value('identificadorPagamento', fidentificadorPagamento)
    .Value('indicadorMovimentoAceito', findicadorMovimentoAceito);
  erros.ReadFromJSon(aJSon);
end;

destructor TACBrTransferenciaPixBBResposta.Destroy;
begin
  if Assigned(ferros) then
    ferros.Free;
  inherited Destroy;
end;

procedure TACBrTransferenciaPixBBResposta.Clear;
begin
  inherited Clear;
  fidentificadorPagamento := 0;
  findicadorMovimentoAceito := EmptyStr;
  if Assigned(ferros) then
    ferros.Clear;
end;

function TACBrTransferenciaPixBBResposta.IsEmpty: Boolean;
begin
  Result := inherited IsEmpty and
    EstaZerado(fidentificadorPagamento) and
    EstaVazio(findicadorMovimentoAceito);
  if Assigned(ferros) then
    Result := Result and ferros.IsEmpty;
end;

procedure TACBrTransferenciaPixBBResposta.Assign(aSource: TACBrTransferenciaPixBBResposta);
begin
  if (not Assigned(aSource)) then
    Exit;
  inherited Assign(aSource);
  fidentificadorPagamento := aSource.identificadorPagamento;
  findicadorMovimentoAceito := aSource.indicadorMovimentoAceito;
  erros.Assign(aSource.erros);
end;

{ TACBrLoteTransferenciaPixRequisicao }

function TACBrLoteTransferenciaPixRequisicao.GetlistaTransferencias: TACBrTransferenciasPixBBRequisicao;
begin
  if not Assigned(flistaTransferencias) then
    flistaTransferencias := TACBrTransferenciasPixBBRequisicao.Create('listaTransferencias');
  Result := flistaTransferencias;
end;

procedure TACBrLoteTransferenciaPixRequisicao.AssignSchema(aSource: TACBrAPISchema);
begin
  if (aSource is TACBrLoteTransferenciaPixRequisicao) then
    Assign(TACBrLoteTransferenciaPixRequisicao(aSource));
end;

procedure TACBrLoteTransferenciaPixRequisicao.DoWriteToJSon(aJSon: TACBrJSONObject);
begin
  aJSon
    .AddPair('numeroRequisicao', fnumeroRequisicao, False)
    .AddPair('numeroContrato', fcodigoContrato, False)
    .AddPair('agenciaDebito', fagenciaDebito, False)
    .AddPair('contaCorrenteDebito', fcontaCorrenteDebito, False)
    .AddPair('digitoVerificadorContaCorrente', fdigitoVerificadorContaCorrenteDebito, False)
    .AddPair('tipoPagamento', TransferenciaPixTipoPagamentoToInteger(ftipoPagamento), False);
  if Assigned(flistaTransferencias) then
    flistaTransferencias.WriteToJSon(aJSon);
end;

procedure TACBrLoteTransferenciaPixRequisicao.DoReadFromJSon(aJSon: TACBrJSONObject);
var
  iTipoPagamento: Integer;
begin
  iTipoPagamento := 0;
  aJSon
    .Value('numeroRequisicao', fnumeroRequisicao)
    .Value('numeroContrato', fcodigoContrato)
    .Value('agenciaDebito', fagenciaDebito)
    .Value('contaCorrenteDebito', fcontaCorrenteDebito)
    .Value('digitoVerificadorContaCorrente', fdigitoVerificadorContaCorrenteDebito)
    .Value('tipoPagamento', iTipoPagamento);
  if NaoEstaZerado(iTipoPagamento) then
    ftipoPagamento := IntegerToTransferenciaPixTipoPagamento(iTipoPagamento);
  listaTransferencias.ReadFromJSon(aJSon);
end;

destructor TACBrLoteTransferenciaPixRequisicao.Destroy;
begin
  if Assigned(flistaTransferencias) then
    flistaTransferencias.Free;
  inherited Destroy;
end;

procedure TACBrLoteTransferenciaPixRequisicao.Clear;
begin
  fnumeroRequisicao := 0;
  fcodigoContrato := 0;
  fagenciaDebito := 0;
  fcontaCorrenteDebito := 0;
  fdigitoVerificadorContaCorrenteDebito := EmptyStr;
  ftipoPagamento := tptNenhum;
  if Assigned(flistaTransferencias) then
    flistaTransferencias.Clear;
end;

function TACBrLoteTransferenciaPixRequisicao.IsEmpty: Boolean;
begin
  Result :=
    EstaZerado(fnumeroRequisicao) and
    EstaZerado(fcodigoContrato) and
    EstaZerado(fagenciaDebito) and
    EstaZerado(fcontaCorrenteDebito) and
    EstaVazio(fdigitoVerificadorContaCorrenteDebito) and
    EstaZerado(Ord(ftipoPagamento));
  if Assigned(flistaTransferencias) then
    Result := Result and flistaTransferencias.IsEmpty;
end;

procedure TACBrLoteTransferenciaPixRequisicao.Assign(aSource: TACBrLoteTransferenciaPixRequisicao);
begin
  if (not Assigned(aSource)) then
    Exit;
  fnumeroRequisicao := aSource.numeroRequisicao;
  fcodigoContrato := aSource.codigoContrato;
  fagenciaDebito := aSource.agenciaDebito;
  fcontaCorrenteDebito := aSource.contaCorrenteDebito;
  fdigitoVerificadorContaCorrenteDebito := aSource.digitoVerificadorContaCorrenteDebito;
  ftipoPagamento := aSource.tipoPagamento;
  listaTransferencias.Assign(aSource.listaTransferencias);
end;

{ TACBrLoteTransferenciaPixResposta }

function TACBrLoteTransferenciaPixResposta.GetlistaTransferencias: TACBrTransferenciasPixBBResposta;
begin
  if not Assigned(flistaTransferencias) then
    flistaTransferencias := TACBrTransferenciasPixBBResposta.Create('listaTransferencias');
  Result := flistaTransferencias;
end;

procedure TACBrLoteTransferenciaPixResposta.AssignSchema(aSource: TACBrAPISchema);
begin
  if (aSource is TACBrLoteTransferenciaPixResposta) then
    Assign(TACBrLoteTransferenciaPixResposta(aSource));
end;

procedure TACBrLoteTransferenciaPixResposta.DoWriteToJSon(aJSon: TACBrJSONObject);
begin
  aJSon
    .AddPair('numeroRequisicao', fnumeroRequisicao, False)
    .AddPair('estadoRequisicao', festadoRequisicao, False)
    .AddPair('quantidadeTransferencias', fquantidadeTransferencias, False)
    .AddPair('valorTransferencias', fvalorTransferencias, False)
    .AddPair('quantidadeTransferenciasValidas', fquantidadeTransferenciasValidas, False)
    .AddPair('valorTransferenciasValidas', fvalorTransferenciasValidas, False);
  if Assigned(flistaTransferencias) then
    flistaTransferencias.WriteToJSon(aJSon);
end;

procedure TACBrLoteTransferenciaPixResposta.DoReadFromJSon(aJSon: TACBrJSONObject);
begin
  aJSon
    .Value('numeroRequisicao', fnumeroRequisicao)
    .Value('estadoRequisicao', festadoRequisicao)
    .Value('quantidadeTransferencias', fquantidadeTransferencias)
    .Value('valorTransferencias', fvalorTransferencias)
    .Value('quantidadeTransferenciasValidas', fquantidadeTransferenciasValidas)
    .Value('valorTransferenciasValidas', fvalorTransferenciasValidas);
  listaTransferencias.ReadFromJSon(aJSon);
end;

destructor TACBrLoteTransferenciaPixResposta.Destroy;
begin
  if Assigned(flistaTransferencias) then
    flistaTransferencias.Free;
  inherited Destroy;
end;

procedure TACBrLoteTransferenciaPixResposta.Clear;
begin
  fnumeroRequisicao := 0;
  festadoRequisicao := 0;
  fquantidadeTransferencias := 0;
  fvalorTransferencias := 0;
  fquantidadeTransferenciasValidas := 0;
  fvalorTransferenciasValidas := 0;
  if Assigned(flistaTransferencias) then
    flistaTransferencias.Clear;
end;

function TACBrLoteTransferenciaPixResposta.IsEmpty: Boolean;
begin
  Result :=
    EstaZerado(fnumeroRequisicao) and
    EstaZerado(festadoRequisicao) and
    EstaZerado(fquantidadeTransferencias) and
    EstaZerado(fvalorTransferencias) and
    EstaZerado(fquantidadeTransferenciasValidas) and
    EstaZerado(fvalorTransferenciasValidas);
  if Assigned(flistaTransferencias) then
    Result := Result and flistaTransferencias.IsEmpty;
end;

procedure TACBrLoteTransferenciaPixResposta.Assign(aSource: TACBrLoteTransferenciaPixResposta);
begin
  fnumeroRequisicao := aSource.numeroRequisicao;
  festadoRequisicao := aSource.estadoRequisicao;
  fquantidadeTransferencias := aSource.quantidadeTransferencias;
  fvalorTransferencias := aSource.valorTransferencias;
  fquantidadeTransferenciasValidas := aSource.quantidadeTransferenciasValidas;
  fvalorTransferenciasValidas := aSource.valorTransferenciasValidas;
  listaTransferencias.Assign(aSource.listaTransferencias);
end;

{ TACBrPixPagamentoBBEspecifico }

procedure TACBrPixPagamentoBBEspecifico.AssignSchema(aSource: TACBrAPISchema);
begin
  if (aSource is TACBrPixPagamentoBBEspecifico) then
    Assign(TACBrPixPagamentoBBEspecifico(aSource));
end;

procedure TACBrPixPagamentoBBEspecifico.DoWriteToJSon(aJSon: TACBrJSONObject);
begin
  aJSon
    .AddPair('numeroCOMPE', fnumeroCOMPE, False)
    .AddPair('numeroISPB', fnumeroISPB, False)
    .AddPair('agenciaCredito', fagenciaCredito, False)
    .AddPair('contaCorrenteCredito', fcontaCorrenteCredito, False)
    .AddPair('digitoVerificadorContaCorrente', fdigitoVerificadorContaCorrente, False)
    .AddPair('numeroContaPagamentoCredito', fnumeroContaPagamentoCredito, False)
    .AddPair('tipoBeneficiario', ftipoBeneficiario, False)
    .AddPair('cpfCnpjBeneficiario', fcpfCnpjBeneficiario, False)
    .AddPair('nomeBeneficiario', fnomeBeneficiario, False)
    .AddPair('documentoCredito', fdocumentoCredito, False)
    .AddPair('descricaoPagamentoInstantaneo', fdescricaoPagamentoInstantaneo, False)
    .AddPair('tipoConta', ftipoConta, False)
    .AddPair('formaIdentificacao', fformaIdentificacao, False)
    .AddPair('dddTelefone', fdddTelefone, False)
    .AddPair('telefone', ftelefone, False)
    .AddPair('email', femail, False)
    .AddPair('identificacaoAleatoria', fidentificacaoAleatoria, False)
    .AddPair('textoPix', ftextoPix, False);
end;

procedure TACBrPixPagamentoBBEspecifico.DoReadFromJSon(aJSon: TACBrJSONObject);
begin
  aJSon
    .Value('numeroCOMPE', fnumeroCOMPE)
    .Value('numeroISPB', fnumeroISPB)
    .Value('agenciaCredito', fagenciaCredito)
    .Value('contaCorrenteCredito', fcontaCorrenteCredito)
    .Value('digitoVerificadorContaCorrente', fdigitoVerificadorContaCorrente)
    .Value('numeroContaPagamentoCredito', fnumeroContaPagamentoCredito)
    .Value('tipoBeneficiario', ftipoBeneficiario)
    .Value('cpfCnpjBeneficiario', fcpfCnpjBeneficiario)
    .Value('nomeBeneficiario', fnomeBeneficiario)
    .Value('documentoCredito', fdocumentoCredito)
    .Value('descricaoPagamentoInstantaneo', fdescricaoPagamentoInstantaneo)
    .Value('tipoConta', ftipoConta)
    .Value('formaIdentificacao', fformaIdentificacao)
    .Value('dddTelefone', fdddTelefone)
    .Value('telefone', ftelefone)
    .Value('email', femail)
    .Value('identificacaoAleatoria', fidentificacaoAleatoria)
    .Value('textoPix', ftextoPix);
end;

procedure TACBrPixPagamentoBBEspecifico.Clear;
begin
  fnumeroCOMPE := 0;
  fnumeroISPB := 0;
  fagenciaCredito := 0;
  fcontaCorrenteCredito := 0;
  fdigitoVerificadorContaCorrente := EmptyStr;
  fnumeroContaPagamentoCredito := EmptyStr;
  ftipoBeneficiario := 0;
  fcpfCnpjBeneficiario := EmptyStr;
  fnomeBeneficiario := EmptyStr;
  fdocumentoCredito := 0;
  fdescricaoPagamentoInstantaneo := EmptyStr;
  ftipoConta := 0;
  fformaIdentificacao := EmptyStr;
  fdddTelefone := 0;
  ftelefone := 0;
  femail := EmptyStr;
  fidentificacaoAleatoria := EmptyStr;
  ftextoPix := EmptyStr;
end;

function TACBrPixPagamentoBBEspecifico.IsEmpty: Boolean;
begin
  Result :=
    EstaZerado(fnumeroCOMPE) and
    EstaZerado(fnumeroISPB) and
    EstaZerado(fagenciaCredito) and
    EstaZerado(fcontaCorrenteCredito) and
    EstaVazio(fdigitoVerificadorContaCorrente) and
    EstaVazio(fnumeroContaPagamentoCredito) and
    EstaZerado(ftipoBeneficiario) and
    EstaVazio(fcpfCnpjBeneficiario) and
    EstaVazio(fnomeBeneficiario) and
    EstaZerado(fdocumentoCredito) and
    EstaVazio(fdescricaoPagamentoInstantaneo) and
    EstaZerado(ftipoConta) and
    EstaVazio(fformaIdentificacao) and
    EstaZerado(fdddTelefone) and
    EstaZerado(ftelefone) and
    EstaVazio(femail) and
    EstaVazio(fidentificacaoAleatoria) and
    EstaVazio(ftextoPix);
end;

procedure TACBrPixPagamentoBBEspecifico.Assign(aSource: TACBrPixPagamentoBBEspecifico);
begin
  fnumeroCOMPE := aSource.numeroCOMPE;
  fnumeroISPB := aSource.numeroISPB;
  fagenciaCredito := aSource.agenciaCredito;
  fcontaCorrenteCredito := aSource.contaCorrenteCredito;
  fdigitoVerificadorContaCorrente := aSource.digitoVerificadorContaCorrente;
  fnumeroContaPagamentoCredito := aSource.numeroContaPagamentoCredito;
  ftipoBeneficiario := aSource.tipoBeneficiario;
  fcpfCnpjBeneficiario := aSource.cpfCnpjBeneficiario;
  fnomeBeneficiario := aSource.nomeBeneficiario;
  fdocumentoCredito := aSource.documentoCredito;
  fdescricaoPagamentoInstantaneo := aSource.descricaoPagamentoInstantaneo;
  ftipoConta := aSource.tipoConta;
  fformaIdentificacao := aSource.formaIdentificacao;
  fdddTelefone := aSource.dddTelefone;
  ftelefone := aSource.telefone;
  femail := aSource.email;
  fidentificacaoAleatoria := aSource.identificacaoAleatoria;
  ftextoPix := aSource.textoPix;
end;

{ TACBrPagamentoEspecificoPixResposta }

function TACBrPagamentoEspecificoPixResposta.GetlistaDevolucao: TACBrPagamentoDevolucoes;
begin
  if not Assigned(flistaDevolucao) then
    flistaDevolucao := TACBrPagamentoDevolucoes.Create('listaDevolucao');
  Result := flistaDevolucao;
end;

function TACBrPagamentoEspecificoPixResposta.GetlistaPix: TACBrPixBBPagamentosEspecificos;
begin
  if not Assigned(flistaPix) then
    flistaPix := TACBrPixBBPagamentosEspecificos.Create('listaPix');
  Result := flistaPix;
end;

procedure TACBrPagamentoEspecificoPixResposta.AssignSchema(aSource: TACBrAPISchema);
begin
  if (aSource is TACBrPagamentoEspecificoPixResposta) then
    Assign(TACBrPagamentoEspecificoPixResposta(aSource));
end;

procedure TACBrPagamentoEspecificoPixResposta.DoWriteToJSon(aJSon: TACBrJSONObject);
begin
  aJSon
    .AddPair('id', fid, False)
    .AddPair('estadoPagamento', EstadoPagamentoToString(festadoPagamento), False)
    .AddPair('agenciaDebito', fagenciaDebito, False)
    .AddPair('contaDebito', fcontaDebito, False)
    .AddPair('digitoContaDebito', fdigitoContaDebito, False)
    .AddPair('numeroCartaoInicio', fnumeroCartaoInicio, False)
    .AddPair('numeroCartaoFim', fnumeroCartaoFim, False)
    .AddPair('requisicaoPagamento', frequisicaoPagamento, False)
    .AddPair('arquivoPagamento', farquivoPagamento, False)
    .AddPair('dataPagamento', DateToJSONInt(fdataPagamento), False)
    .AddPair('valorPagamento', fvalorPagamento, False)
    .AddPair('numeroDocumentoDebito', fnumeroDocumentoDebito, False)
    .AddPair('autenticacaoPagamento', fautenticacaoPagamento, False)
    .AddPair('descricaoPagamento', fdescricaoPagamento, False)
    .AddPair('quantidadeOcorrenciaPix', fquantidadeOcorrenciaPix, False);
  if Assigned(flistaPix) then
    flistaPix.WriteToJSon(aJSon);
  if Assigned(flistaDevolucao) then
    flistaDevolucao.WriteToJSon(aJSon);
end;

procedure TACBrPagamentoEspecificoPixResposta.DoReadFromJSon(aJSon: TACBrJSONObject);
var
  S: String;
begin
  S := EmptyStr;
  aJSon
    .Value('id', fid)
    .Value('estadoPagamento', S)
    .Value('agenciaDebito', fagenciaDebito)
    .Value('contaDebito', fcontaDebito)
    .Value('digitoContaDebito', fdigitoContaDebito)
    .Value('numeroCartaoInicio', fnumeroCartaoInicio)
    .Value('numeroCartaoFim', fnumeroCartaoFim)
    .Value('requisicaoPagamento', frequisicaoPagamento)
    .Value('arquivoPagamento', farquivoPagamento)
    .Value('valorPagamento', fvalorPagamento)
    .Value('numeroDocumentoDebito', fnumeroDocumentoDebito)
    .Value('autenticacaoPagamento', fautenticacaoPagamento)
    .Value('descricaoPagamento', fdescricaoPagamento)
    .Value('quantidadeOcorrenciaPix', fquantidadeOcorrenciaPix);
  if NaoEstaVazio(S) then
    festadoPagamento := StringToEstadoPagamento(S);
  ReadJSONDate(aJSon, 'dataPagamento', fdataPagamento);
  listaPix.ReadFromJSon(aJSon);
  listaDevolucao.ReadFromJSon(aJSon);
end;

destructor TACBrPagamentoEspecificoPixResposta.Destroy;
begin
  if Assigned(flistaPix) then
    flistaPix.Free;
  if Assigned(flistaDevolucao) then
    flistaDevolucao.Free;
  inherited Destroy;
end;

procedure TACBrPagamentoEspecificoPixResposta.Clear;
begin
  fid := 0;
  festadoPagamento := epgNenhum;
  fagenciaDebito := 0;
  fcontaDebito := 0;
  fdigitoContaDebito := EmptyStr;
  fnumeroCartaoInicio := 0;
  fnumeroCartaoFim := 0;
  frequisicaoPagamento := 0;
  farquivoPagamento := EmptyStr;
  fdataPagamento := 0;
  fvalorPagamento := 0;
  fnumeroDocumentoDebito := 0;
  fautenticacaoPagamento := EmptyStr;
  fdescricaoPagamento := EmptyStr;
  fquantidadeOcorrenciaPix := 0;
  if Assigned(flistaPix) then
    flistaPix.Clear;
  if Assigned(flistaDevolucao) then
    flistaDevolucao.Clear;
end;

function TACBrPagamentoEspecificoPixResposta.IsEmpty: Boolean;
begin
  Result :=
    EstaZerado(fid) and
    (festadoPagamento = epgNenhum) and
    EstaZerado(fagenciaDebito) and
    EstaZerado(fcontaDebito) and
    EstaVazio(fdigitoContaDebito) and
    EstaZerado(fnumeroCartaoInicio) and
    EstaZerado(fnumeroCartaoFim) and
    EstaZerado(frequisicaoPagamento) and
    EstaVazio(farquivoPagamento) and
    EstaZerado(fdataPagamento) and
    EstaZerado(fvalorPagamento) and
    EstaZerado(fnumeroDocumentoDebito) and
    EstaVazio(fautenticacaoPagamento) and
    EstaVazio(fdescricaoPagamento) and
    EstaZerado(fquantidadeOcorrenciaPix);
  if Assigned(flistaPix) then
    Result := Result and flistaPix.IsEmpty;
  if Assigned(flistaDevolucao) then
    Result := Result and flistaDevolucao.IsEmpty;
end;

procedure TACBrPagamentoEspecificoPixResposta.Assign(aSource: TACBrPagamentoEspecificoPixResposta);
begin
  fid := aSource.id;
  festadoPagamento := aSource.estadoPagamento;
  fagenciaDebito := aSource.agenciaDebito;
  fcontaDebito := aSource.contaDebito;
  fdigitoContaDebito := aSource.digitoContaDebito;
  fnumeroCartaoInicio := aSource.numeroCartaoInicio;
  fnumeroCartaoFim := aSource.numeroCartaoFim;
  frequisicaoPagamento := aSource.requisicaoPagamento;
  farquivoPagamento := aSource.arquivoPagamento;
  fdataPagamento := aSource.dataPagamento;
  fvalorPagamento := aSource.valorPagamento;
  fnumeroDocumentoDebito := aSource.numeroDocumentoDebito;
  fautenticacaoPagamento := aSource.autenticacaoPagamento;
  fdescricaoPagamento := aSource.descricaoPagamento;
  fquantidadeOcorrenciaPix := aSource.quantidadeOcorrenciaPix;
  listaPix.Assign(aSource.listaPix);
  listaDevolucao.Assign(aSource.listaDevolucao);
end;

{ Array helpers }

function TACBrTransferenciasBBRequisicao.GetItem(aIndex: Integer): TACBrTransferenciaBBRequisicao;
begin
  Result := TACBrTransferenciaBBRequisicao(inherited Items[aIndex]);
end;

procedure TACBrTransferenciasBBRequisicao.SetItem(aIndex: Integer; aValue: TACBrTransferenciaBBRequisicao);
begin
  inherited Items[aIndex] := aValue;
end;

function TACBrTransferenciasBBRequisicao.NewSchema: TACBrAPISchema;
begin
  Result := New;
end;

function TACBrTransferenciasBBRequisicao.Add(aItem: TACBrTransferenciaBBRequisicao): Integer;
begin
  Result := inherited Add(aItem);
end;

procedure TACBrTransferenciasBBRequisicao.Insert(aIndex: Integer; aItem: TACBrTransferenciaBBRequisicao);
begin
  inherited Insert(aIndex, aItem);
end;

function TACBrTransferenciasBBRequisicao.New: TACBrTransferenciaBBRequisicao;
begin
  Result := TACBrTransferenciaBBRequisicao.Create;
  Self.Add(Result);
end;

function TACBrTransferenciasBBResposta.GetItem(aIndex: Integer): TACBrTransferenciaBBResposta;
begin
  Result := TACBrTransferenciaBBResposta(inherited Items[aIndex]);
end;

procedure TACBrTransferenciasBBResposta.SetItem(aIndex: Integer; aValue: TACBrTransferenciaBBResposta);
begin
  inherited Items[aIndex] := aValue;
end;

function TACBrTransferenciasBBResposta.NewSchema: TACBrAPISchema;
begin
  Result := New;
end;

function TACBrTransferenciasBBResposta.Add(aItem: TACBrTransferenciaBBResposta): Integer;
begin
  Result := inherited Add(aItem);
end;

procedure TACBrTransferenciasBBResposta.Insert(aIndex: Integer; aItem: TACBrTransferenciaBBResposta);
begin
  inherited Insert(aIndex, aItem);
end;

function TACBrTransferenciasBBResposta.New: TACBrTransferenciaBBResposta;
begin
  Result := TACBrTransferenciaBBResposta.Create;
  Self.Add(Result);
end;

function TACBrTransferenciasLoteBBConsulta.GetItem(aIndex: Integer): TACBrTransferenciaLoteBBConsulta;
begin
  Result := TACBrTransferenciaLoteBBConsulta(inherited Items[aIndex]);
end;

procedure TACBrTransferenciasLoteBBConsulta.SetItem(aIndex: Integer; aValue: TACBrTransferenciaLoteBBConsulta);
begin
  inherited Items[aIndex] := aValue;
end;

function TACBrTransferenciasLoteBBConsulta.NewSchema: TACBrAPISchema;
begin
  Result := New;
end;

function TACBrTransferenciasLoteBBConsulta.Add(aItem: TACBrTransferenciaLoteBBConsulta): Integer;
begin
  Result := inherited Add(aItem);
end;

procedure TACBrTransferenciasLoteBBConsulta.Insert(aIndex: Integer; aItem: TACBrTransferenciaLoteBBConsulta);
begin
  inherited Insert(aIndex, aItem);
end;

function TACBrTransferenciasLoteBBConsulta.New: TACBrTransferenciaLoteBBConsulta;
begin
  Result := TACBrTransferenciaLoteBBConsulta.Create;
  Self.Add(Result);
end;

function TACBrTransferenciaPagamentosBBEspecificos.GetItem(aIndex: Integer): TACBrTransferenciaBBPagamentoEspecifico;
begin
  Result := TACBrTransferenciaBBPagamentoEspecifico(inherited Items[aIndex]);
end;

procedure TACBrTransferenciaPagamentosBBEspecificos.SetItem(aIndex: Integer; aValue: TACBrTransferenciaBBPagamentoEspecifico);
begin
  inherited Items[aIndex] := aValue;
end;

function TACBrTransferenciaPagamentosBBEspecificos.NewSchema: TACBrAPISchema;
begin
  Result := New;
end;

function TACBrTransferenciaPagamentosBBEspecificos.Add(aItem: TACBrTransferenciaBBPagamentoEspecifico): Integer;
begin
  Result := inherited Add(aItem);
end;

procedure TACBrTransferenciaPagamentosBBEspecificos.Insert(aIndex: Integer; aItem: TACBrTransferenciaBBPagamentoEspecifico);
begin
  inherited Insert(aIndex, aItem);
end;

function TACBrTransferenciaPagamentosBBEspecificos.New: TACBrTransferenciaBBPagamentoEspecifico;
begin
  Result := TACBrTransferenciaBBPagamentoEspecifico.Create;
  Self.Add(Result);
end;

function TACBrTransferenciasPixBBRequisicao.GetItem(aIndex: Integer): TACBrTransferenciaPixBBRequisicao;
begin
  Result := TACBrTransferenciaPixBBRequisicao(inherited Items[aIndex]);
end;

procedure TACBrTransferenciasPixBBRequisicao.SetItem(aIndex: Integer; aValue: TACBrTransferenciaPixBBRequisicao);
begin
  inherited Items[aIndex] := aValue;
end;

function TACBrTransferenciasPixBBRequisicao.NewSchema: TACBrAPISchema;
begin
  Result := New;
end;

function TACBrTransferenciasPixBBRequisicao.Add(aItem: TACBrTransferenciaPixBBRequisicao): Integer;
begin
  Result := inherited Add(aItem);
end;

procedure TACBrTransferenciasPixBBRequisicao.Insert(aIndex: Integer; aItem: TACBrTransferenciaPixBBRequisicao);
begin
  inherited Insert(aIndex, aItem);
end;

function TACBrTransferenciasPixBBRequisicao.New: TACBrTransferenciaPixBBRequisicao;
begin
  Result := TACBrTransferenciaPixBBRequisicao.Create;
  Self.Add(Result);
end;

function TACBrTransferenciasPixBBResposta.GetItem(aIndex: Integer): TACBrTransferenciaPixBBResposta;
begin
  Result := TACBrTransferenciaPixBBResposta(inherited Items[aIndex]);
end;

procedure TACBrTransferenciasPixBBResposta.SetItem(aIndex: Integer; aValue: TACBrTransferenciaPixBBResposta);
begin
  inherited Items[aIndex] := aValue;
end;

function TACBrTransferenciasPixBBResposta.NewSchema: TACBrAPISchema;
begin
  Result := New;
end;

function TACBrTransferenciasPixBBResposta.Add(aItem: TACBrTransferenciaPixBBResposta): Integer;
begin
  Result := inherited Add(aItem);
end;

procedure TACBrTransferenciasPixBBResposta.Insert(aIndex: Integer; aItem: TACBrTransferenciaPixBBResposta);
begin
  inherited Insert(aIndex, aItem);
end;

function TACBrTransferenciasPixBBResposta.New: TACBrTransferenciaPixBBResposta;
begin
  Result := TACBrTransferenciaPixBBResposta.Create;
  Self.Add(Result);
end;

function TACBrPagamentosLoteBBConsulta.GetItem(aIndex: Integer): TACBrPagamentoLoteBBConsulta;
begin
  Result := TACBrPagamentoLoteBBConsulta(inherited Items[aIndex]);
end;

procedure TACBrPagamentosLoteBBConsulta.SetItem(aIndex: Integer; aValue: TACBrPagamentoLoteBBConsulta);
begin
  inherited Items[aIndex] := aValue;
end;

function TACBrPagamentosLoteBBConsulta.NewSchema: TACBrAPISchema;
begin
  Result := New;
end;

function TACBrPagamentosLoteBBConsulta.Add(aItem: TACBrPagamentoLoteBBConsulta): Integer;
begin
  Result := inherited Add(aItem);
end;

procedure TACBrPagamentosLoteBBConsulta.Insert(aIndex: Integer; aItem: TACBrPagamentoLoteBBConsulta);
begin
  inherited Insert(aIndex, aItem);
end;

function TACBrPagamentosLoteBBConsulta.New: TACBrPagamentoLoteBBConsulta;
begin
  Result := TACBrPagamentoLoteBBConsulta.Create;
  Self.Add(Result);
end;

function TACBrPixBBPagamentosEspecificos.GetItem(aIndex: Integer): TACBrPixPagamentoBBEspecifico;
begin
  Result := TACBrPixPagamentoBBEspecifico(inherited Items[aIndex]);
end;

procedure TACBrPixBBPagamentosEspecificos.SetItem(aIndex: Integer; aValue: TACBrPixPagamentoBBEspecifico);
begin
  inherited Items[aIndex] := aValue;
end;

function TACBrPixBBPagamentosEspecificos.NewSchema: TACBrAPISchema;
begin
  Result := New;
end;

function TACBrPixBBPagamentosEspecificos.Add(aItem: TACBrPixPagamentoBBEspecifico): Integer;
begin
  Result := inherited Add(aItem);
end;

procedure TACBrPixBBPagamentosEspecificos.Insert(aIndex: Integer; aItem: TACBrPixPagamentoBBEspecifico);
begin
  inherited Insert(aIndex, aItem);
end;

function TACBrPixBBPagamentosEspecificos.New: TACBrPixPagamentoBBEspecifico;
begin
  Result := TACBrPixPagamentoBBEspecifico.Create;
  Self.Add(Result);
end;

end.
