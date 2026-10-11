{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2025 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Antonio Carlos Junior                           }
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

unit ACBrLibIMendesRespostas;

interface

uses
  Classes, SysUtils,
  ACBrBase, ACBrIMendes,
  ACBrLibResposta, ACBrLibConfig;

type

  {%region Erro }

  { TLibIMendesErroResposta }
  TLibIMendesErroResposta = class(TACBrLibRespostaBase)
  private
    FSucesso: Boolean;
    FMensagem: String;
  public
    constructor Create(const ATipo: TACBrLibRespostaTipo; const AFormato: TACBrLibCodificacao); reintroduce;
    procedure Processar(const AErro: TACBrIMendesErro);
  published
    property Sucesso: Boolean read FSucesso write FSucesso;
    property Mensagem: String read FMensagem write FMensagem;
  end;

  {%endregion}

  {%region Inativar / RemoveDevolvidos }

  { TLibIMendesRetornoResposta }
  TLibIMendesRetornoResposta = class(TACBrLibRespostaBase)
  private
    FSucesso: Boolean;
    FMensagem: String;
  public
    procedure Processar(const AJSON: String);
  published
    property Sucesso: Boolean read FSucesso write FSucesso;
    property Mensagem: String read FMensagem write FMensagem;
  end;

  {%endregion}

  {%region ConsultarDescricao / ConsultarAlterados }

  { TLibIMendesCabecalhoResposta }
  TLibIMendesCabecalhoResposta = class(TACBrLibRespostaBase)
  private
    FUF: String;
    FCNPJ: String;
    FProdutosRetornados: Integer;
    FMensagem: String;
  public
    procedure Processar(const ACabecalho: TACBrIMendesCabecalho);
  published
    property UF: String read FUF write FUF;
    property CNPJ: String read FCNPJ write FCNPJ;
    property ProdutosRetornados: Integer read FProdutosRetornados write FProdutosRetornados;
    property Mensagem: String read FMensagem write FMensagem;
  end;

  { TLibIMendesProdutoResposta }
  TLibIMendesProdutoResposta = class(TACBrLibRespostaBase)
  private
    FId: String;
    FDescricao: String;
    FEan: String;
    FNcm: String;
    FCest: String;
    FDescricaoGrupo: String;
    FCodigo: String;
    FCodInterno: String;
    FCodImendes: String;
    FImportado: String;
    FEncontrado: Boolean;
    FTipo: Integer;
    FChaveRetorno: String;
    FDtUltCons: TDateTime;
    FDtRev: TDateTime;
  public
    procedure Processar(const AProduto: TACBrIMendesProduto);
  published
    property Id: String read FId write FId;
    property Descricao: String read FDescricao write FDescricao;
    property Ean: String read FEan write FEan;
    property Ncm: String read FNcm write FNcm;
    property Cest: String read FCest write FCest;
    property DescricaoGrupo: String read FDescricaoGrupo write FDescricaoGrupo;
    property Codigo: String read FCodigo write FCodigo;
    property CodInterno: String read FCodInterno write FCodInterno;
    property CodImendes: String read FCodImendes write FCodImendes;
    property Importado: String read FImportado write FImportado;
    property Encontrado: Boolean read FEncontrado write FEncontrado;
    property Tipo: Integer read FTipo write FTipo;
    property ChaveRetorno: String read FChaveRetorno write FChaveRetorno;
    property DtUltCons: TDateTime read FDtUltCons write FDtUltCons;
    property DtRev: TDateTime read FDtRev write FDtRev;
  end;

  { TLibIMendesConsultarResposta }
  TLibIMendesConsultarResposta = class(TACBrLibRespostaBase)
  private
    FCabecalho: TLibIMendesCabecalhoResposta;
    FProdutos: TACBrObjectList;
  public
    constructor Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo; const AFormato: TACBrLibCodificacao); reintroduce;
    destructor Destroy; override;
    procedure Processar(const AResposta: TACBrIMendesConsultarResponse);
  published
    property Cabecalho: TLibIMendesCabecalhoResposta read FCabecalho;
    property Produtos: TACBrObjectList read FProdutos;
  end;

  {%endregion}

  {%region HistoricoAcesso }

  { TLibIMendesResumoResposta }
  TLibIMendesResumoResposta = class(TACBrLibRespostaBase)
  private
    FDataPrimeiroConsumo: TDateTime;
    FDataUltimoConsumo: TDateTime;
    FProdutosPendentes_Interno: Integer;
    FProdutosPendentes_EAN: Integer;
    FProdutosPendentes_Devolvidos: Integer;
    FProdutosPendentes_DataInicio: TDateTime;
  public
    procedure Processar(const AResumo: TACBrIMendesResumo);
  published
    property DataPrimeiroConsumo: TDateTime read FDataPrimeiroConsumo write FDataPrimeiroConsumo;
    property DataUltimoConsumo: TDateTime read FDataUltimoConsumo write FDataUltimoConsumo;
    property ProdutosPendentes_Interno: Integer read FProdutosPendentes_Interno write FProdutosPendentes_Interno;
    property ProdutosPendentes_EAN: Integer read FProdutosPendentes_EAN write FProdutosPendentes_EAN;
    property ProdutosPendentes_Devolvidos: Integer read FProdutosPendentes_Devolvidos write FProdutosPendentes_Devolvidos;
    property ProdutosPendentes_DataInicio: TDateTime read FProdutosPendentes_DataInicio write FProdutosPendentes_DataInicio;
  end;

  { TLibIMendesDetalheResposta }
  TLibIMendesDetalheResposta = class(TACBrLibRespostaBase)
  private
    FData: TDateTime;
    FMetodo: String;
    FMsg: String;
    FRequisicoes: Integer;
    FEnviados: Integer;
    FRetornados: Integer;
  public
    procedure Processar(const ADetalhe: TACBrImendesDetalhe);
  published
    property Data: TDateTime read FData write FData;
    property Metodo: String read FMetodo write FMetodo;
    property Msg: String read FMsg write FMsg;
    property Requisicoes: Integer read FRequisicoes write FRequisicoes;
    property Enviados: Integer read FEnviados write FEnviados;
    property Retornados: Integer read FRetornados write FRetornados;
  end;

  { TLibIMendesProdDevolvidoResposta }
  TLibIMendesProdDevolvidoResposta = class(TACBrLibRespostaBase)
  private
    FId: String;
    FCodigo: String;
    FDescricao: String;
    FDataInclusao: TDateTime;
    FDataDevolucao: TDateTime;
    FMotivoDevolucao: String;
  public
    procedure Processar(const AProdDevolvido: TACBrImendesProdDevolvido);
  published
    property Id: String read FId write FId;
    property Codigo: String read FCodigo write FCodigo;
    property Descricao: String read FDescricao write FDescricao;
    property DataInclusao: TDateTime read FDataInclusao write FDataInclusao;
    property DataDevolucao: TDateTime read FDataDevolucao write FDataDevolucao;
    property MotivoDevolucao: String read FMotivoDevolucao write FMotivoDevolucao;
  end;

  { TLibIMendesHistoricoResposta }
  TLibIMendesHistoricoResposta = class(TACBrLibRespostaBase)
  private
    FResumo: TLibIMendesResumoResposta;
    FDetalhes: TACBrObjectList;
    FProdDevolvidos: TACBrObjectList;
  public
    constructor Create(const ATipo: TACBrLibRespostaTipo; const AFormato: TACBrLibCodificacao); reintroduce;
    destructor Destroy; override;
    procedure Processar(const AResposta: TACBrIMendesHistoricoResponse);
  published
    property Resumo: TLibIMendesResumoResposta read FResumo;
    property Detalhes: TACBrObjectList read FDetalhes;
    property ProdDevolvidos: TACBrObjectList read FProdDevolvidos;
  end;

  {%endregion}

  {%region ConsultarRegimesEspeciais }

  { TLibIMendesRegimeEspecialItemResposta }
  TLibIMendesRegimeEspecialItemResposta = class(TACBrLibRespostaBase)
  private
    FCode: String;
    FDescription: String;
    FLegalBasis: String;
    FInitialValidity: TDateTime;
    FFinalValidity: TDateTime;
  public
    procedure Processar(const ARegime: TACBrIMendesRegimeEspecial);
  published
    property Code: String read FCode write FCode;
    property Description: String read FDescription write FDescription;
    property LegalBasis: String read FLegalBasis write FLegalBasis;
    property InitialValidity: TDateTime read FInitialValidity write FInitialValidity;
    property FinalValidity: TDateTime read FFinalValidity write FFinalValidity;
  end;

  { TLibIMendesRegimeEspecialResposta }
  TLibIMendesRegimeEspecialResposta = class(TACBrLibRespostaBase)
  private
    FItens: TACBrObjectList;
  public
    constructor Create(const ATipo: TACBrLibRespostaTipo; const AFormato: TACBrLibCodificacao); reintroduce;
    destructor Destroy; override;
    procedure Processar(const ALista: TACBrIMendesRegimeEspecialList);
  published
    property Itens: TACBrObjectList read FItens;
  end;

  {%endregion}

  {%region SaneamentoGrades }

  { TLibIMendesSaneamentoCabecalhoResposta }
  TLibIMendesSaneamentoCabecalhoResposta = class(TACBrLibRespostaBase)
  private
    FSugestao: String;
    FAmb: Integer;
    FCNPJ: String;
    FDtHr: TDateTime;
    FTransacao: String;
    FMensagem: String;
    FProdEnv: Integer;
    FProdRet: Integer;
    FProdNaoRet: Integer;
    FComportamentosParceiro: String;
    FComportamentosCliente: String;
    FVersao: String;
    FDuracao: String;
  public
    procedure Processar(const ACabecalho: TACBrIMendesSaneamentoCabecalho);
  published
    property Sugestao: String read FSugestao write FSugestao;
    property Amb: Integer read FAmb write FAmb;
    property CNPJ: String read FCNPJ write FCNPJ;
    property DtHr: TDateTime read FDtHr write FDtHr;
    property Transacao: String read FTransacao write FTransacao;
    property Mensagem: String read FMensagem write FMensagem;
    property ProdEnv: Integer read FProdEnv write FProdEnv;
    property ProdRet: Integer read FProdRet write FProdRet;
    property ProdNaoRet: Integer read FProdNaoRet write FProdNaoRet;
    property ComportamentosParceiro: String read FComportamentosParceiro write FComportamentosParceiro;
    property ComportamentosCliente: String read FComportamentosCliente write FComportamentosCliente;
    property Versao: String read FVersao write FVersao;
    property Duracao: String read FDuracao write FDuracao;
  end;

  { TLibIMendesCBSTributacaoRegularResposta }
  TLibIMendesCBSTributacaoRegularResposta = class(TACBrLibRespostaBase)
  private
    FCST: String;
    FCClassTrib: String;
    FAliquota: Double;
    FReducao: Double;
    FPAliqEfet: Double;
  public
    procedure Processar(const ATrib: TACBrIMendesGrupoTributacaoRegularCBS);
  published
    property CST: String read FCST write FCST;
    property CClassTrib: String read FCClassTrib write FCClassTrib;
    property Aliquota: Double read FAliquota write FAliquota;
    property Reducao: Double read FReducao write FReducao;
    property PAliqEfet: Double read FPAliqEfet write FPAliqEfet;
  end;

  { TLibIMendesCBSResposta }
  TLibIMendesCBSResposta = class(TACBrLibRespostaBase)
  private
    FId: Integer;
    FCClassTrib: String;
    FDescrCClassTrib: String;
    FCST: String;
    FDescrCST: String;
    FAliquota: Double;
    FReducao: Double;
    FPDifer: Double;
    FAliqAdRem: Double;
    FPAliqEfet: Double;
    FReducaoBaseCalculo: Double;
    FAmpLegal: String;
    FDtVigIni: TDateTime;
    FDtVigFin: TDateTime;
  public
    procedure Processar(const ACBS: TACBrIMendesGrupoCBS);
  published
    property Id: Integer read FId write FId;
    property CClassTrib: String read FCClassTrib write FCClassTrib;
    property DescrCClassTrib: String read FDescrCClassTrib write FDescrCClassTrib;
    property CST: String read FCST write FCST;
    property DescrCST: String read FDescrCST write FDescrCST;
    property Aliquota: Double read FAliquota write FAliquota;
    property Reducao: Double read FReducao write FReducao;
    property PDifer: Double read FPDifer write FPDifer;
    property AliqAdRem: Double read FAliqAdRem write FAliqAdRem;
    property PAliqEfet: Double read FPAliqEfet write FPAliqEfet;
    property ReducaoBaseCalculo: Double read FReducaoBaseCalculo write FReducaoBaseCalculo;
    property AmpLegal: String read FAmpLegal write FAmpLegal;
    property DtVigIni: TDateTime read FDtVigIni write FDtVigIni;
    property DtVigFin: TDateTime read FDtVigFin write FDtVigFin;
  end;

  { TLibIMendesISResposta }
  TLibIMendesISResposta = class(TACBrLibRespostaBase)
  private
    FCClassTrib: String;
    FDescrCClassTrib: String;
    FCST: String;
    FDescrCST: String;
    FAliquota: Double;
    FAmpLegal: String;
    FDtVigIni: TDateTime;
    FDtVigFin: TDateTime;
  public
    procedure Processar(const AIS: TACBrIMendesGrupoIS);
  published
    property CClassTrib: String read FCClassTrib write FCClassTrib;
    property DescrCClassTrib: String read FDescrCClassTrib write FDescrCClassTrib;
    property CST: String read FCST write FCST;
    property DescrCST: String read FDescrCST write FDescrCST;
    property Aliquota: Double read FAliquota write FAliquota;
    property AmpLegal: String read FAmpLegal write FAmpLegal;
    property DtVigIni: TDateTime read FDtVigIni write FDtVigIni;
    property DtVigFin: TDateTime read FDtVigFin write FDtVigFin;
  end;

  { TLibIMendesPisCofinsResposta }
  TLibIMendesPisCofinsResposta = class(TACBrLibRespostaBase)
  private
    FCstEnt: String;
    FCstSai: String;
    FAliqPis: Double;
    FAliqCofins: Double;
    FNri: String;
    FAmpLegal: String;
    FRedPis: Double;
    FRedCofins: Double;
  public
    procedure Processar(const APisCofins: TACBrIMendesGrupoPisCofins);
  published
    property CstEnt: String read FCstEnt write FCstEnt;
    property CstSai: String read FCstSai write FCstSai;
    property AliqPis: Double read FAliqPis write FAliqPis;
    property AliqCofins: Double read FAliqCofins write FAliqCofins;
    property Nri: String read FNri write FNri;
    property AmpLegal: String read FAmpLegal write FAmpLegal;
    property RedPis: Double read FRedPis write FRedPis;
    property RedCofins: Double read FRedCofins write FRedCofins;
  end;

  { TLibIMendesIPIResposta }
  TLibIMendesIPIResposta = class(TACBrLibRespostaBase)
  private
    FCstEnt: String;
    FCstSai: String;
    FAliqIPI: Double;
    FCodEnq: String;
    FEx: String;
    FReducao: Double;
  public
    procedure Processar(const AIPI: TACBrIMendesGrupoIPI);
  published
    property CstEnt: String read FCstEnt write FCstEnt;
    property CstSai: String read FCstSai write FCstSai;
    property AliqIPI: Double read FAliqIPI write FAliqIPI;
    property CodEnq: String read FCodEnq write FCodEnq;
    property Ex: String read FEx write FEx;
    property Reducao: Double read FReducao write FReducao;
  end;

  { TLibIMendesProtocoloResposta }
  TLibIMendesProtocoloResposta = class(TACBrLibRespostaBase)
  private
    FProtId: Integer;
    FProtNome: String;
    FDescricao: String;
    FDtVigIni: TDateTime;
    FDtVigFin: TDateTime;
    FIsento: String;
    FAntecipado: String;
    FSubsTrib: String;
    FRespTrib: String;
    FAliqIcmsInterestadual: Double;
    FRedBcInterestadual: Double;
    FAliqEfetiva: Double;
    FIVA: Double;
    FDebitoPresumidoInter: Double;
  public
    procedure Processar(const AProtocolo: TACBrIMendesGrupoProtocolo);
  published
    property ProtId: Integer read FProtId write FProtId;
    property ProtNome: String read FProtNome write FProtNome;
    property Descricao: String read FDescricao write FDescricao;
    property DtVigIni: TDateTime read FDtVigIni write FDtVigIni;
    property DtVigFin: TDateTime read FDtVigFin write FDtVigFin;
    property Isento: String read FIsento write FIsento;
    property Antecipado: String read FAntecipado write FAntecipado;
    property SubsTrib: String read FSubsTrib write FSubsTrib;
    property RespTrib: String read FRespTrib write FRespTrib;
    property AliqIcmsInterestadual: Double read FAliqIcmsInterestadual write FAliqIcmsInterestadual;
    property RedBcInterestadual: Double read FRedBcInterestadual write FRedBcInterestadual;
    property AliqEfetiva: Double read FAliqEfetiva write FAliqEfetiva;
    property IVA: Double read FIVA write FIVA;
    property DebitoPresumidoInter: Double read FDebitoPresumidoInter write FDebitoPresumidoInter;
  end;

  { TLibIMendesPrecoFabricaResposta }
  TLibIMendesPrecoFabricaResposta = class(TACBrLibRespostaBase)
  private
    FEan: String;
    FRegistro: String;
    FPF: Double;
  public
    procedure Processar(const APreco: TACBrIMendesGrupoPrecoFabrica);
  published
    property Ean: String read FEan write FEan;
    property Registro: String read FRegistro write FRegistro;
    property PF: Double read FPF write FPF;
  end;

  { TLibIMendesPrecoMaximoConsumidorResposta }
  TLibIMendesPrecoMaximoConsumidorResposta = class(TACBrLibRespostaBase)
  private
    FEan: String;
    FRegistro: String;
    FPMC: Double;
    FPRedPmc: Double;
  public
    procedure Processar(const APreco: TACBrIMendesGrupoPrecoMaximoConsumidor);
  published
    property Ean: String read FEan write FEan;
    property Registro: String read FRegistro write FRegistro;
    property PMC: Double read FPMC write FPMC;
    property PRedPmc: Double read FPRedPmc write FPRedPmc;
  end;

  { TLibIMendesConvenioResposta }
  TLibIMendesConvenioResposta = class(TACBrLibRespostaBase)
  private
    FConvId: Integer;
    FConvNome: String;
    FDescricao: String;
    FDtVigIni: TDateTime;
    FDtVigFin: TDateTime;
    FIsento: String;
    FAntecipado: String;
    FSubsTrib: String;
    FRespTrib: String;
    FAliqIcmsInterestadual: Double;
    FRedBcInterestadual: Double;
    FAliqEfetiva: Double;
    FIVA: Double;
    FDebitoPresumidoInter: Double;
  public
    procedure Processar(const AConvenio: TACBrIMendesGrupoConvenio);
  published
    property ConvId: Integer read FConvId write FConvId;
    property ConvNome: String read FConvNome write FConvNome;
    property Descricao: String read FDescricao write FDescricao;
    property DtVigIni: TDateTime read FDtVigIni write FDtVigIni;
    property DtVigFin: TDateTime read FDtVigFin write FDtVigFin;
    property Isento: String read FIsento write FIsento;
    property Antecipado: String read FAntecipado write FAntecipado;
    property SubsTrib: String read FSubsTrib write FSubsTrib;
    property RespTrib: String read FRespTrib write FRespTrib;
    property AliqIcmsInterestadual: Double read FAliqIcmsInterestadual write FAliqIcmsInterestadual;
    property RedBcInterestadual: Double read FRedBcInterestadual write FRedBcInterestadual;
    property AliqEfetiva: Double read FAliqEfetiva write FAliqEfetiva;
    property IVA: Double read FIVA write FIVA;
    property DebitoPresumidoInter: Double read FDebitoPresumidoInter write FDebitoPresumidoInter;
  end;

  { TLibIMendesPmpfResposta }
  TLibIMendesPmpfResposta = class(TACBrLibRespostaBase)
  private
    FPmpfCodigo: String;
    FProdCodigo: String;
    FPTrava: Double;
    FPTravaAjust: Double;
    FVPmpf: Double;
    FVMultiplo: Integer;
    FAmparoLegal: String;
    FDtVigenciaInicial: TDateTime;
    FDtVigenciaFinal: TDateTime;
  public
    procedure Processar(const APmpf: TACBrIMendesGrupoPmpf);
  published
    property PmpfCodigo: String read FPmpfCodigo write FPmpfCodigo;
    property ProdCodigo: String read FProdCodigo write FProdCodigo;
    property PTrava: Double read FPTrava write FPTrava;
    property PTravaAjust: Double read FPTravaAjust write FPTravaAjust;
    property VPmpf: Double read FVPmpf write FVPmpf;
    property VMultiplo: Integer read FVMultiplo write FVMultiplo;
    property AmparoLegal: String read FAmparoLegal write FAmparoLegal;
    property DtVigenciaInicial: TDateTime read FDtVigenciaInicial write FDtVigenciaInicial;
    property DtVigenciaFinal: TDateTime read FDtVigenciaFinal write FDtVigenciaFinal;
  end;

  { TLibIMendesIBSTributacaoRegularResposta }
  TLibIMendesIBSTributacaoRegularResposta = class(TACBrLibRespostaBase)
  private
    FCST: String;
    FCClassTrib: String;
    FIbsUF: Double;
    FIbsMun: Double;
    FReducaoAliqIBS: Double;
    FPAliqEfetUF: Double;
    FPAliqEfetMun: Double;
  public
    procedure Processar(const ATrib: TACBrIMendesGrupoTributacaoRegularIBS);
  published
    property CST: String read FCST write FCST;
    property CClassTrib: String read FCClassTrib write FCClassTrib;
    property IbsUF: Double read FIbsUF write FIbsUF;
    property IbsMun: Double read FIbsMun write FIbsMun;
    property ReducaoAliqIBS: Double read FReducaoAliqIBS write FReducaoAliqIBS;
    property PAliqEfetUF: Double read FPAliqEfetUF write FPAliqEfetUF;
    property PAliqEfetMun: Double read FPAliqEfetMun write FPAliqEfetMun;
  end;

  { TLibIMendesIBSResposta }
  TLibIMendesIBSResposta = class(TACBrLibRespostaBase)
  private
    FCClassTrib: String;
    FDescrCClassTrib: String;
    FCST: String;
    FDescrCST: String;
    FIbsUF: Double;
    FIbsMun: Double;
    FReducaoAliqIBS: Double;
    FReducaoBcIBS: Double;
    FPDifer: Double;
    FPDiferIBSUF: Double;
    FPDiferIBSMun: Double;
    FPAliqEfetUF: Double;
    FPAliqEfetMun: Double;
    FAmpLegal: String;
    FDtVigIni: TDateTime;
    FDtVigFin: TDateTime;
  public
    procedure Processar(const AIBS: TACBrIMendesGrupoIBS);
  published
    property CClassTrib: String read FCClassTrib write FCClassTrib;
    property DescrCClassTrib: String read FDescrCClassTrib write FDescrCClassTrib;
    property CST: String read FCST write FCST;
    property DescrCST: String read FDescrCST write FDescrCST;
    property IbsUF: Double read FIbsUF write FIbsUF;
    property IbsMun: Double read FIbsMun write FIbsMun;
    property ReducaoAliqIBS: Double read FReducaoAliqIBS write FReducaoAliqIBS;
    property ReducaoBcIBS: Double read FReducaoBcIBS write FReducaoBcIBS;
    property PDifer: Double read FPDifer write FPDifer;
    property PDiferIBSUF: Double read FPDiferIBSUF write FPDiferIBSUF;
    property PDiferIBSMun: Double read FPDiferIBSMun write FPDiferIBSMun;
    property PAliqEfetUF: Double read FPAliqEfetUF write FPAliqEfetUF;
    property PAliqEfetMun: Double read FPAliqEfetMun write FPAliqEfetMun;
    property AmpLegal: String read FAmpLegal write FAmpLegal;
    property DtVigIni: TDateTime read FDtVigIni write FDtVigIni;
    property DtVigFin: TDateTime read FDtVigFin write FDtVigFin;
  end;

  { TLibIMendesCaracTribResposta }
  TLibIMendesCaracTribResposta = class(TACBrLibRespostaBase)
  private
    FCodigo: String;
    FMunicipio: String;
    FFinalidade: String;
    FIdGrade: Integer;
    FCodGrade: String;
    FCodRegra: String;
    FCodExcecao: Integer;
    FDtVigIni: TDateTime;
    FDtVigFin: TDateTime;
    FCFOP: String;
    FCST: String;
    FCSOSN: String;
    FAliqIcmsInterna: Double;
    FAliqIcmsInterestadual: Double;
    FReducaoBcIcms: Double;
    FReducaoBcIcmsSt: Double;
    FRedBcICMsInterestadual: Double;
    FAliqIcmsSt: Double;
    FIVA: Double;
    FIVAAjust: Double;
    FFCP: Double;
    FFCPSt: Double;
    FCodBenef: String;
    FPDifer: Double;
    FPIsencao: Double;
    FAntecipado: String;
    FDesonerado: String;
    FPICMSDeson: Double;
    FIsento: String;
    FMotDesICMS: String;
    FIndDeduzDeson: String;
    FTpCalcDifal: Integer;
    FDebitoPresumido: Double;
    FDebitoPresumidoNaoCredenciado: Double;
    FAmpLegal: String;
    FRegraGeral: String;
    FPSuspensaoImportacao: Double;
    FRegimeEspecial: String;
    FProtocolo: TLibIMendesProtocoloResposta;
    FConvenio: TLibIMendesConvenioResposta;
    FIBS: TLibIMendesIBSResposta;
    FIBSTributacaoRegular: TLibIMendesIBSTributacaoRegularResposta;
    FPrecosFabrica: TACBrObjectList;
    FPrecosMaximoConsumidor: TACBrObjectList;
    FPmpfs: TACBrObjectList;
  public
    constructor Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo; const AFormato: TACBrLibCodificacao); reintroduce;
    destructor Destroy; override;
    procedure Processar(const ACaracTrib: TACBrIMendesGrupoCaracTrib; const AIndice: String);
  published
    property Codigo: String read FCodigo write FCodigo;
    property Municipio: String read FMunicipio write FMunicipio;
    property Finalidade: String read FFinalidade write FFinalidade;
    property IdGrade: Integer read FIdGrade write FIdGrade;
    property CodGrade: String read FCodGrade write FCodGrade;
    property CodRegra: String read FCodRegra write FCodRegra;
    property CodExcecao: Integer read FCodExcecao write FCodExcecao;
    property DtVigIni: TDateTime read FDtVigIni write FDtVigIni;
    property DtVigFin: TDateTime read FDtVigFin write FDtVigFin;
    property CFOP: String read FCFOP write FCFOP;
    property CST: String read FCST write FCST;
    property CSOSN: String read FCSOSN write FCSOSN;
    property AliqIcmsInterna: Double read FAliqIcmsInterna write FAliqIcmsInterna;
    property AliqIcmsInterestadual: Double read FAliqIcmsInterestadual write FAliqIcmsInterestadual;
    property ReducaoBcIcms: Double read FReducaoBcIcms write FReducaoBcIcms;
    property ReducaoBcIcmsSt: Double read FReducaoBcIcmsSt write FReducaoBcIcmsSt;
    property RedBcICMsInterestadual: Double read FRedBcICMsInterestadual write FRedBcICMsInterestadual;
    property AliqIcmsSt: Double read FAliqIcmsSt write FAliqIcmsSt;
    property IVA: Double read FIVA write FIVA;
    property IVAAjust: Double read FIVAAjust write FIVAAjust;
    property FCP: Double read FFCP write FFCP;
    property FCPSt: Double read FFCPSt write FFCPSt;
    property CodBenef: String read FCodBenef write FCodBenef;
    property PDifer: Double read FPDifer write FPDifer;
    property PIsencao: Double read FPIsencao write FPIsencao;
    property Antecipado: String read FAntecipado write FAntecipado;
    property Desonerado: String read FDesonerado write FDesonerado;
    property PICMSDeson: Double read FPICMSDeson write FPICMSDeson;
    property Isento: String read FIsento write FIsento;
    property MotDesICMS: String read FMotDesICMS write FMotDesICMS;
    property IndDeduzDeson: String read FIndDeduzDeson write FIndDeduzDeson;
    property TpCalcDifal: Integer read FTpCalcDifal write FTpCalcDifal;
    property DebitoPresumido: Double read FDebitoPresumido write FDebitoPresumido;
    property DebitoPresumidoNaoCredenciado: Double read FDebitoPresumidoNaoCredenciado write FDebitoPresumidoNaoCredenciado;
    property AmpLegal: String read FAmpLegal write FAmpLegal;
    property RegraGeral: String read FRegraGeral write FRegraGeral;
    property PSuspensaoImportacao: Double read FPSuspensaoImportacao write FPSuspensaoImportacao;
    property RegimeEspecial: String read FRegimeEspecial write FRegimeEspecial;
    property Protocolo: TLibIMendesProtocoloResposta read FProtocolo;
    property Convenio: TLibIMendesConvenioResposta read FConvenio;
    property IBS: TLibIMendesIBSResposta read FIBS;
    property IBSTributacaoRegular: TLibIMendesIBSTributacaoRegularResposta read FIBSTributacaoRegular;
    property PrecosFabrica: TACBrObjectList read FPrecosFabrica;
    property PrecosMaximoConsumidor: TACBrObjectList read FPrecosMaximoConsumidor;
    property Pmpfs: TACBrObjectList read FPmpfs;
  end;

  { TLibIMendesUFResposta }
  TLibIMendesUFResposta = class(TACBrLibRespostaBase)
  private
    FUF: String;
    FCFOP: String;
    FMensagem: String;
    FCaracTribs: TACBrObjectList;
  public
    constructor Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo; const AFormato: TACBrLibCodificacao); reintroduce;
    destructor Destroy; override;
    procedure Processar(const AUF: TACBrIMendesGrupoUF; const AIndice: String);
  published
    property UF: String read FUF write FUF;
    property CFOP: String read FCFOP write FCFOP;
    property Mensagem: String read FMensagem write FMensagem;
    property CaracTribs: TACBrObjectList read FCaracTribs;
  end;

  { TLibIMendesDadosRtCBSResposta }
  TLibIMendesDadosRtCBSResposta = class(TACBrLibRespostaBase)
  private
    FCST: String;
    FCstDescricao: String;
    FClassificacaoTributaria: String;
    FClassificacaoTributariaDescricao: String;
    FAliquota: Double;
    FReducao: Double;
    FReducaoBaseCalculo: Double;
    FAmparoLegal: String;
  public
    procedure Processar(const ACBS: TACBrIMendesGrupoDadosRtCBS);
  published
    property CST: String read FCST write FCST;
    property CstDescricao: String read FCstDescricao write FCstDescricao;
    property ClassificacaoTributaria: String read FClassificacaoTributaria write FClassificacaoTributaria;
    property ClassificacaoTributariaDescricao: String read FClassificacaoTributariaDescricao write FClassificacaoTributariaDescricao;
    property Aliquota: Double read FAliquota write FAliquota;
    property Reducao: Double read FReducao write FReducao;
    property ReducaoBaseCalculo: Double read FReducaoBaseCalculo write FReducaoBaseCalculo;
    property AmparoLegal: String read FAmparoLegal write FAmparoLegal;
  end;

  { TLibIMendesDadosRtIBSResposta }
  TLibIMendesDadosRtIBSResposta = class(TACBrLibRespostaBase)
  private
    FCST: String;
    FCstDescricao: String;
    FClassificacaoTributaria: String;
    FClassificacaoTributariaDescricao: String;
    FAliquotaEstadual: Double;
    FAliquotaMunicipal: Double;
    FReducao: Double;
    FReducaoBaseCalculo: Double;
    FAmparoLegal: String;
  public
    procedure Processar(const AIBS: TACBrIMendesGrupoDadosRtIBS);
  published
    property CST: String read FCST write FCST;
    property CstDescricao: String read FCstDescricao write FCstDescricao;
    property ClassificacaoTributaria: String read FClassificacaoTributaria write FClassificacaoTributaria;
    property ClassificacaoTributariaDescricao: String read FClassificacaoTributariaDescricao write FClassificacaoTributariaDescricao;
    property AliquotaEstadual: Double read FAliquotaEstadual write FAliquotaEstadual;
    property AliquotaMunicipal: Double read FAliquotaMunicipal write FAliquotaMunicipal;
    property Reducao: Double read FReducao write FReducao;
    property ReducaoBaseCalculo: Double read FReducaoBaseCalculo write FReducaoBaseCalculo;
    property AmparoLegal: String read FAmparoLegal write FAmparoLegal;
  end;

  { TLibIMendesDadosRtISResposta }
  TLibIMendesDadosRtISResposta = class(TACBrLibRespostaBase)
  private
    FCST: String;
    FCstDescricao: String;
    FClassificacaoTributaria: String;
    FClassificacaoTributariaDescricao: String;
    FAliquota: Double;
    FAmparoLegal: String;
  public
    procedure Processar(const AIS: TACBrIMendesGrupoDadosRtIS);
  published
    property CST: String read FCST write FCST;
    property CstDescricao: String read FCstDescricao write FCstDescricao;
    property ClassificacaoTributaria: String read FClassificacaoTributaria write FClassificacaoTributaria;
    property ClassificacaoTributariaDescricao: String read FClassificacaoTributariaDescricao write FClassificacaoTributariaDescricao;
    property Aliquota: Double read FAliquota write FAliquota;
    property AmparoLegal: String read FAmparoLegal write FAmparoLegal;
  end;

  { TLibIMendesDadosRtPeriodoResposta }
  TLibIMendesDadosRtPeriodoResposta = class(TACBrLibRespostaBase)
  private
    FAnexo: String;
    FVigenciaInicial: TDateTime;
    FVigenciaFinal: TDateTime;
    FAno: Integer;
    FPercentualIcmsUtilizado: Double;
    FCBS: TLibIMendesDadosRtCBSResposta;
    FIBS: TLibIMendesDadosRtIBSResposta;
    FIS: TLibIMendesDadosRtISResposta;
  public
    constructor Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo; const AFormato: TACBrLibCodificacao); reintroduce;
    destructor Destroy; override;
    procedure Processar(const APeriodo: TACBrIMendesGrupoDadosRtPeriodo; const AIndice: String);
  published
    property Anexo: String read FAnexo write FAnexo;
    property VigenciaInicial: TDateTime read FVigenciaInicial write FVigenciaInicial;
    property VigenciaFinal: TDateTime read FVigenciaFinal write FVigenciaFinal;
    property Ano: Integer read FAno write FAno;
    property PercentualIcmsUtilizado: Double read FPercentualIcmsUtilizado write FPercentualIcmsUtilizado;
    property CBS: TLibIMendesDadosRtCBSResposta read FCBS;
    property IBS: TLibIMendesDadosRtIBSResposta read FIBS;
    property IS_: TLibIMendesDadosRtISResposta read FIS;
  end;

  { TLibIMendesGrupoResposta }
  TLibIMendesGrupoResposta = class(TACBrLibRespostaBase)
  private
    FCodigo: String;
    FDescricao: String;
    FNCM: String;
    FCEST: String;
    FDtVigIni: TDateTime;
    FDtVigFin: TDateTime;
    FLista: String;
    FTipo: String;
    FCodAnp: String;
    FPassivelPMC: String;
    FImpostoImportacao: Double;
    FMensagem: String;
    FProdCodInterno: String;
    FProdEan: String;
    FProdCodImendes: String;
    FCBS: TLibIMendesCBSResposta;
    FCBSTributacaoRegular: TLibIMendesCBSTributacaoRegularResposta;
    FIS: TLibIMendesISResposta;
    FPisCofins: TLibIMendesPisCofinsResposta;
    FIPI: TLibIMendesIPIResposta;
    FUFs: TACBrObjectList;
    FDadosRtPeriodos: TACBrObjectList;
  public
    constructor Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo; const AFormato: TACBrLibCodificacao); reintroduce;
    destructor Destroy; override;
    procedure Processar(const AGrupo: TACBrIMendesGrupo; const AIndice: String);
  published
    property Codigo: String read FCodigo write FCodigo;
    property Descricao: String read FDescricao write FDescricao;
    property NCM: String read FNCM write FNCM;
    property CEST: String read FCEST write FCEST;
    property DtVigIni: TDateTime read FDtVigIni write FDtVigIni;
    property DtVigFin: TDateTime read FDtVigFin write FDtVigFin;
    property Lista: String read FLista write FLista;
    property Tipo: String read FTipo write FTipo;
    property CodAnp: String read FCodAnp write FCodAnp;
    property PassivelPMC: String read FPassivelPMC write FPassivelPMC;
    property ImpostoImportacao: Double read FImpostoImportacao write FImpostoImportacao;
    property Mensagem: String read FMensagem write FMensagem;
    property ProdCodInterno: String read FProdCodInterno write FProdCodInterno;
    property ProdEan: String read FProdEan write FProdEan;
    property ProdCodImendes: String read FProdCodImendes write FProdCodImendes;
    property CBS: TLibIMendesCBSResposta read FCBS;
    property CBSTributacaoRegular: TLibIMendesCBSTributacaoRegularResposta read FCBSTributacaoRegular;
    property IS_: TLibIMendesISResposta read FIS;
    property PisCofins: TLibIMendesPisCofinsResposta read FPisCofins;
    property IPI: TLibIMendesIPIResposta read FIPI;
    property UFs: TACBrObjectList read FUFs;
    property DadosRtPeriodos: TACBrObjectList read FDadosRtPeriodos;
  end;

  { TLibIMendesSemRetornoResposta }
  TLibIMendesSemRetornoResposta = class(TACBrLibRespostaBase)
  private
    FCodInterno: String;
    FCodProduto: String;
  public
    procedure Processar(const AItem: TACBrIMendesSemRetornoItem);
  published
    property CodInterno: String read FCodInterno write FCodInterno;
    property CodProduto: String read FCodProduto write FCodProduto;
  end;

  { TLibIMendesBaixaSimilaridadeResposta }
  TLibIMendesBaixaSimilaridadeResposta = class(TACBrLibRespostaBase)
  private
    FCodigoProduto: String;
    FDescricaoIMendes: String;
    FDescricaoInformada: String;
    FPercentualSimilaridade: Double;
  public
    procedure Processar(const AItem: TACBrIMendesBaixaSimilaridadeItem);
  published
    property CodigoProduto: String read FCodigoProduto write FCodigoProduto;
    property DescricaoIMendes: String read FDescricaoIMendes write FDescricaoIMendes;
    property DescricaoInformada: String read FDescricaoInformada write FDescricaoInformada;
    property PercentualSimilaridade: Double read FPercentualSimilaridade write FPercentualSimilaridade;
  end;

  { TLibIMendesSaneamentoResposta }
  TLibIMendesSaneamentoResposta = class(TACBrLibRespostaBase)
  private
    FCabecalho: TLibIMendesSaneamentoCabecalhoResposta;
    FGrupos: TACBrObjectList;
    FSemRetorno: TACBrObjectList;
    FBaixaSimilaridade: TACBrObjectList;
  public
    constructor Create(const ATipo: TACBrLibRespostaTipo; const AFormato: TACBrLibCodificacao); reintroduce;
    destructor Destroy; override;
    procedure Processar(const AResposta: TACBrIMendesSaneamentoResponse);
  published
    property Cabecalho: TLibIMendesSaneamentoCabecalhoResposta read FCabecalho;
    property Grupos: TACBrObjectList read FGrupos;
    property SemRetorno: TACBrObjectList read FSemRetorno;
    property BaixaSimilaridade: TACBrObjectList read FBaixaSimilaridade;
  end;

  {%endregion}

implementation

uses
  ACBrUtil.Base, ACBrJSON,
  ACBrLibIMendesConsts;

function Indice(const ANumero: Integer): String;
begin
  Result := IntToStrZero(ANumero, 3);
end;

function ListaParaTexto(const ALista: TStrings): String;
var
  i: Integer;
begin
  Result := EmptyStr;
  for i := 0 to ALista.Count - 1 do
  begin
    if (i > 0) then
      Result := Result + '|';
    Result := Result + ALista[i];
  end;
end;

{ TLibIMendesErroResposta }

constructor TLibIMendesErroResposta.Create(const ATipo: TACBrLibRespostaTipo; const AFormato: TACBrLibCodificacao);
begin
  inherited Create(CSessaoRespErro, ATipo, AFormato);
  FSucesso := False;
  FMensagem := EmptyStr;
end;

procedure TLibIMendesErroResposta.Processar(const AErro: TACBrIMendesErro);
begin
  FSucesso := AErro.Sucesso;
  FMensagem := AErro.Mensagem;
end;

{ TLibIMendesRetornoResposta }

procedure TLibIMendesRetornoResposta.Processar(const AJSON: String);
var
  wJSON: TACBrJSONObject;
begin
  FSucesso := True;
  FMensagem := EmptyStr;
  if EstaVazio(Trim(AJSON)) then
    Exit;

  wJSON := TACBrJSONObject.Parse(AJSON);
  try
    if wJSON.ValueExists('sucesso') then
      FSucesso := wJSON.AsBoolean['sucesso'];

    FMensagem := wJSON.AsString['mensagem'];
    if EstaVazio(FMensagem) then
      FMensagem := wJSON.AsString['message'];
  finally
    wJSON.Free;
  end;
end;

{ TLibIMendesCabecalhoResposta }

procedure TLibIMendesCabecalhoResposta.Processar(const ACabecalho: TACBrIMendesCabecalho);
begin
  FUF := ACabecalho.UF;
  FCNPJ := ACabecalho.CNPJ;
  FProdutosRetornados := ACabecalho.ProdutosRetornados;
  FMensagem := ACabecalho.Mensagem;
end;

{ TLibIMendesProdutoResposta }

procedure TLibIMendesProdutoResposta.Processar(const AProduto: TACBrIMendesProduto);
begin
  FId := AProduto.Id;
  FDescricao := AProduto.Descricao;
  FEan := AProduto.Ean;
  FNcm := AProduto.Ncm;
  FCest := AProduto.Cest;
  FDescricaoGrupo := AProduto.DescricaoGrupo;
  FCodigo := AProduto.Codigo;
  FCodInterno := AProduto.CodInterno;
  FCodImendes := AProduto.CodImendes;
  FImportado := AProduto.Importado;
  FEncontrado := AProduto.Encontrado;
  FTipo := AProduto.Tipo;
  FChaveRetorno := AProduto.ChaveRetorno;
  FDtUltCons := AProduto.DtUltCons;
  FDtRev := AProduto.DtRev;
end;

{ TLibIMendesConsultarResposta }

constructor TLibIMendesConsultarResposta.Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
  const AFormato: TACBrLibCodificacao);
begin
  inherited Create(ASessao, ATipo, AFormato);
  FCabecalho := TLibIMendesCabecalhoResposta.Create('Cabecalho', ATipo, AFormato);
  FProdutos := TACBrObjectList.Create;
end;

destructor TLibIMendesConsultarResposta.Destroy;
begin
  FCabecalho.Free;
  FProdutos.Free;
  inherited Destroy;
end;

procedure TLibIMendesConsultarResposta.Processar(const AResposta: TACBrIMendesConsultarResponse);
var
  i: Integer;
  Item: TLibIMendesProdutoResposta;
begin
  FCabecalho.Processar(AResposta.Cabecalho);

  for i := 0 to AResposta.Produtos.Count - 1 do
  begin
    Item := TLibIMendesProdutoResposta.Create('Produto' + Indice(i + 1), Tipo, Codificacao);
    Item.Processar(AResposta.Produtos[i]);
    FProdutos.Add(Item);
  end;
end;

{ TLibIMendesResumoResposta }

procedure TLibIMendesResumoResposta.Processar(const AResumo: TACBrIMendesResumo);
begin
  FDataPrimeiroConsumo := AResumo.DataPrimeiroConsumo;
  FDataUltimoConsumo := AResumo.DataUltimoConsumo;
  FProdutosPendentes_Interno := AResumo.ProdutosPendentes_Interno;
  FProdutosPendentes_EAN := AResumo.ProdutosPendentes_EAN;
  FProdutosPendentes_Devolvidos := AResumo.ProdutosPendentes_Devolvidos;
  FProdutosPendentes_DataInicio := AResumo.ProdutosPendentes_DataInicio;
end;

{ TLibIMendesDetalheResposta }

procedure TLibIMendesDetalheResposta.Processar(const ADetalhe: TACBrImendesDetalhe);
begin
  FData := ADetalhe.Data;
  FMetodo := ADetalhe.Metodo;
  FMsg := ADetalhe.Msg;
  FRequisicoes := ADetalhe.Requisicoes;
  FEnviados := ADetalhe.Enviados;
  FRetornados := ADetalhe.Retornados;
end;

{ TLibIMendesProdDevolvidoResposta }

procedure TLibIMendesProdDevolvidoResposta.Processar(const AProdDevolvido: TACBrImendesProdDevolvido);
begin
  FId := AProdDevolvido.Id;
  FCodigo := AProdDevolvido.Codigo;
  FDescricao := AProdDevolvido.Descricao;
  FDataInclusao := AProdDevolvido.DataInclusao;
  FDataDevolucao := AProdDevolvido.DataDevolucao;
  FMotivoDevolucao := AProdDevolvido.MotivoDevolucao;
end;

{ TLibIMendesHistoricoResposta }

constructor TLibIMendesHistoricoResposta.Create(const ATipo: TACBrLibRespostaTipo; const AFormato: TACBrLibCodificacao);
begin
  inherited Create(CSessaoRespHistoricoAcesso, ATipo, AFormato);
  FResumo := TLibIMendesResumoResposta.Create('Resumo', ATipo, AFormato);
  FDetalhes := TACBrObjectList.Create;
  FProdDevolvidos := TACBrObjectList.Create;
end;

destructor TLibIMendesHistoricoResposta.Destroy;
begin
  FResumo.Free;
  FDetalhes.Free;
  FProdDevolvidos.Free;
  inherited Destroy;
end;

procedure TLibIMendesHistoricoResposta.Processar(const AResposta: TACBrIMendesHistoricoResponse);
var
  i: Integer;
  Detalhe: TLibIMendesDetalheResposta;
  ProdDev: TLibIMendesProdDevolvidoResposta;
begin
  FResumo.Processar(AResposta.Resumo);

  for i := 0 to AResposta.Detalhes.Count - 1 do
  begin
    Detalhe := TLibIMendesDetalheResposta.Create('Detalhe' + Indice(i + 1), Tipo, Codificacao);
    Detalhe.Processar(AResposta.Detalhes.Items[i]);
    FDetalhes.Add(Detalhe);
  end;

  for i := 0 to AResposta.ProdDevolvidos.Count - 1 do
  begin
    ProdDev := TLibIMendesProdDevolvidoResposta.Create('ProdDevolvido' + Indice(i + 1), Tipo, Codificacao);
    ProdDev.Processar(AResposta.ProdDevolvidos.Items[i]);
    FProdDevolvidos.Add(ProdDev);
  end;
end;

{ TLibIMendesRegimeEspecialItemResposta }

procedure TLibIMendesRegimeEspecialItemResposta.Processar(const ARegime: TACBrIMendesRegimeEspecial);
begin
  FCode := ARegime.Code;
  FDescription := ARegime.Description;
  FLegalBasis := ARegime.LegalBasis;
  FInitialValidity := ARegime.InitialValidity;
  FFinalValidity := ARegime.FinalValidity;
end;

{ TLibIMendesRegimeEspecialResposta }

constructor TLibIMendesRegimeEspecialResposta.Create(const ATipo: TACBrLibRespostaTipo; const AFormato: TACBrLibCodificacao);
begin
  inherited Create(CSessaoRespRegimesEspeciais, ATipo, AFormato);
  FItens := TACBrObjectList.Create;
end;

destructor TLibIMendesRegimeEspecialResposta.Destroy;
begin
  FItens.Free;
  inherited Destroy;
end;

procedure TLibIMendesRegimeEspecialResposta.Processar(const ALista: TACBrIMendesRegimeEspecialList);
var
  i: Integer;
  Item: TLibIMendesRegimeEspecialItemResposta;
begin
  for i := 0 to ALista.Count - 1 do
  begin
    Item := TLibIMendesRegimeEspecialItemResposta.Create('RegimeEspecial' + Indice(i + 1), Tipo, Codificacao);
    Item.Processar(ALista[i]);
    FItens.Add(Item);
  end;
end;

{ TLibIMendesSaneamentoCabecalhoResposta }

procedure TLibIMendesSaneamentoCabecalhoResposta.Processar(const ACabecalho: TACBrIMendesSaneamentoCabecalho);
begin
  FSugestao := ACabecalho.sugestao;
  FAmb := ACabecalho.amb;
  FCNPJ := ACabecalho.cnpj;
  FDtHr := ACabecalho.dthr;
  FTransacao := ACabecalho.transacao;
  FMensagem := ACabecalho.mensagem;
  FProdEnv := ACabecalho.prodEnv;
  FProdRet := ACabecalho.prodRet;
  FProdNaoRet := ACabecalho.prodNaoRet;
  FComportamentosParceiro := ACabecalho.comportamentosParceiro;
  FComportamentosCliente := ACabecalho.comportamentosCliente;
  FVersao := ACabecalho.versao;
  FDuracao := ACabecalho.duracao;
end;

{ TLibIMendesCBSTributacaoRegularResposta }

procedure TLibIMendesCBSTributacaoRegularResposta.Processar(const ATrib: TACBrIMendesGrupoTributacaoRegularCBS);
begin
  FCST := ATrib.cst;
  FCClassTrib := ATrib.cClassTrib;
  FAliquota := ATrib.aliquota;
  FReducao := ATrib.reducao;
  FPAliqEfet := ATrib.pAliqEfet;
end;

{ TLibIMendesCBSResposta }

procedure TLibIMendesCBSResposta.Processar(const ACBS: TACBrIMendesGrupoCBS);
begin
  FId := ACBS.id;
  FCClassTrib := ACBS.cClassTrib;
  FDescrCClassTrib := ACBS.descrcClassTrib;
  FCST := ACBS.cst;
  FDescrCST := ACBS.descrCST;
  FAliquota := ACBS.aliquota;
  FReducao := ACBS.reducao;
  FPDifer := ACBS.pDifer;
  FAliqAdRem := ACBS.aliqAdRem;
  FPAliqEfet := ACBS.pAliqEfet;
  FReducaoBaseCalculo := ACBS.reducaoBaseCalculo;
  FAmpLegal := ACBS.ampLegal;
  FDtVigIni := ACBS.dtVigIni;
  FDtVigFin := ACBS.dtVigFin;
end;

{ TLibIMendesISResposta }

procedure TLibIMendesISResposta.Processar(const AIS: TACBrIMendesGrupoIS);
begin
  FCClassTrib := AIS.cClassTrib;
  FDescrCClassTrib := AIS.descrcClassTrib;
  FCST := AIS.cst;
  FDescrCST := AIS.descrCST;
  FAliquota := AIS.aliquota;
  FAmpLegal := AIS.ampLegal;
  FDtVigIni := AIS.dtVigIni;
  FDtVigFin := AIS.dtVigFin;
end;

{ TLibIMendesPisCofinsResposta }

procedure TLibIMendesPisCofinsResposta.Processar(const APisCofins: TACBrIMendesGrupoPisCofins);
begin
  FCstEnt := APisCofins.cstEnt;
  FCstSai := APisCofins.cstSai;
  FAliqPis := APisCofins.aliqPis;
  FAliqCofins := APisCofins.aliqCofins;
  FNri := APisCofins.nri;
  FAmpLegal := APisCofins.ampLegal;
  FRedPis := APisCofins.redPis;
  FRedCofins := APisCofins.redCofins;
end;

{ TLibIMendesIPIResposta }

procedure TLibIMendesIPIResposta.Processar(const AIPI: TACBrIMendesGrupoIPI);
begin
  FCstEnt := AIPI.cstEnt;
  FCstSai := AIPI.cstSai;
  FAliqIPI := AIPI.aliqipi;
  FCodEnq := AIPI.codenq;
  FEx := AIPI.ex;
  FReducao := AIPI.reducao;
end;

{ TLibIMendesProtocoloResposta }

procedure TLibIMendesProtocoloResposta.Processar(const AProtocolo: TACBrIMendesGrupoProtocolo);
begin
  FProtId := AProtocolo.protId;
  FProtNome := AProtocolo.protNome;
  FDescricao := AProtocolo.descricao;
  FDtVigIni := AProtocolo.dtVigIni;
  FDtVigFin := AProtocolo.dtVigFin;
  FIsento := AProtocolo.isento;
  FAntecipado := AProtocolo.antecipado;
  FSubsTrib := AProtocolo.subsTrib;
  FRespTrib := AProtocolo.respTrib;
  FAliqIcmsInterestadual := AProtocolo.aliqIcmsInterestadual;
  FRedBcInterestadual := AProtocolo.redBcInterestadual;
  FAliqEfetiva := AProtocolo.aliqEfetiva;
  FIVA := AProtocolo.iva;
  FDebitoPresumidoInter := AProtocolo.debitoPresumidoInter;
end;

{ TLibIMendesPrecoFabricaResposta }

procedure TLibIMendesPrecoFabricaResposta.Processar(const APreco: TACBrIMendesGrupoPrecoFabrica);
begin
  FEan := APreco.ean;
  FRegistro := APreco.registro;
  FPF := APreco.pf;
end;

{ TLibIMendesPrecoMaximoConsumidorResposta }

procedure TLibIMendesPrecoMaximoConsumidorResposta.Processar(const APreco: TACBrIMendesGrupoPrecoMaximoConsumidor);
begin
  FEan := APreco.ean;
  FRegistro := APreco.registro;
  FPMC := APreco.pmc;
  FPRedPmc := APreco.pRedPmc;
end;

{ TLibIMendesConvenioResposta }

procedure TLibIMendesConvenioResposta.Processar(const AConvenio: TACBrIMendesGrupoConvenio);
begin
  FConvId := AConvenio.convId;
  FConvNome := AConvenio.convNome;
  FDescricao := AConvenio.descricao;
  FDtVigIni := AConvenio.dtVigIni;
  FDtVigFin := AConvenio.dtVigFin;
  FIsento := AConvenio.isento;
  FAntecipado := AConvenio.antecipado;
  FSubsTrib := AConvenio.subsTrib;
  FRespTrib := AConvenio.respTrib;
  FAliqIcmsInterestadual := AConvenio.aliqIcmsInterestadual;
  FRedBcInterestadual := AConvenio.redBcInterestadual;
  FAliqEfetiva := AConvenio.aliqEfetiva;
  FIVA := AConvenio.iva;
  FDebitoPresumidoInter := AConvenio.debitoPresumidoInter;
end;

{ TLibIMendesPmpfResposta }

procedure TLibIMendesPmpfResposta.Processar(const APmpf: TACBrIMendesGrupoPmpf);
begin
  FPmpfCodigo := APmpf.pmpfCodigo;
  FProdCodigo := APmpf.prodCodigo;
  FPTrava := APmpf.pTrava;
  FPTravaAjust := APmpf.pTravaAjust;
  FVPmpf := APmpf.vPmpf;
  FVMultiplo := APmpf.vMultiplo;
  FAmparoLegal := APmpf.amparoLegal;
  FDtVigenciaInicial := APmpf.dtVigenciaInicial;
  FDtVigenciaFinal := APmpf.dtVigenciaFinal;
end;

{ TLibIMendesIBSTributacaoRegularResposta }

procedure TLibIMendesIBSTributacaoRegularResposta.Processar(const ATrib: TACBrIMendesGrupoTributacaoRegularIBS);
begin
  FCST := ATrib.cst;
  FCClassTrib := ATrib.cClassTrib;
  FIbsUF := ATrib.ibsUF;
  FIbsMun := ATrib.ibsMun;
  FReducaoAliqIBS := ATrib.reducaoaliqIBS;
  FPAliqEfetUF := ATrib.pAliqEfetUF;
  FPAliqEfetMun := ATrib.pAliqEfetMun;
end;

{ TLibIMendesIBSResposta }

procedure TLibIMendesIBSResposta.Processar(const AIBS: TACBrIMendesGrupoIBS);
begin
  FCClassTrib := AIBS.cClassTrib;
  FDescrCClassTrib := AIBS.descrcClassTrib;
  FCST := AIBS.cst;
  FDescrCST := AIBS.descrCST;
  FIbsUF := AIBS.ibsUF;
  FIbsMun := AIBS.ibsMun;
  FReducaoAliqIBS := AIBS.reducaoaliqIBS;
  FReducaoBcIBS := AIBS.reducaoBcIBS;
  FPDifer := AIBS.pDifer;
  FPDiferIBSUF := AIBS.pDiferIBSUF;
  FPDiferIBSMun := AIBS.pDiferIBSMun;
  FPAliqEfetUF := AIBS.pAliqEfetUF;
  FPAliqEfetMun := AIBS.pAliqEfetMun;
  FAmpLegal := AIBS.ampLegal;
  FDtVigIni := AIBS.dtVigIni;
  FDtVigFin := AIBS.dtVigFin;
end;

{ TLibIMendesCaracTribResposta }

constructor TLibIMendesCaracTribResposta.Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
  const AFormato: TACBrLibCodificacao);
begin
  inherited Create(ASessao, ATipo, AFormato);
  FProtocolo := Nil;
  FConvenio := Nil;
  FIBS := Nil;
  FIBSTributacaoRegular := Nil;
  FPrecosFabrica := TACBrObjectList.Create;
  FPrecosMaximoConsumidor := TACBrObjectList.Create;
  FPmpfs := TACBrObjectList.Create;
end;

destructor TLibIMendesCaracTribResposta.Destroy;
begin
  if Assigned(FProtocolo) then
    FProtocolo.Free;
  if Assigned(FConvenio) then
    FConvenio.Free;
  if Assigned(FIBS) then
    FIBS.Free;
  if Assigned(FIBSTributacaoRegular) then
    FIBSTributacaoRegular.Free;
  FPrecosFabrica.Free;
  FPrecosMaximoConsumidor.Free;
  FPmpfs.Free;
  inherited Destroy;
end;

procedure TLibIMendesCaracTribResposta.Processar(const ACaracTrib: TACBrIMendesGrupoCaracTrib; const AIndice: String);
var
  i: Integer;
  PF: TLibIMendesPrecoFabricaResposta;
  PMC: TLibIMendesPrecoMaximoConsumidorResposta;
  Pmpf: TLibIMendesPmpfResposta;
begin
  FCodigo := ACaracTrib.codigo;
  FMunicipio := ACaracTrib.municipio;
  FFinalidade := ACaracTrib.finalidade;
  FIdGrade := ACaracTrib.idGrade;
  FCodGrade := ACaracTrib.codGrade;
  FCodRegra := ACaracTrib.codRegra;
  FCodExcecao := ACaracTrib.codExcecao;
  FDtVigIni := ACaracTrib.dtVigIni;
  FDtVigFin := ACaracTrib.dtVigFin;
  FCFOP := ACaracTrib.cFOP;
  FCST := ACaracTrib.cST;
  FCSOSN := ACaracTrib.cSOSN;
  FAliqIcmsInterna := ACaracTrib.aliqIcmsInterna;
  FAliqIcmsInterestadual := ACaracTrib.aliqIcmsInterestadual;
  FReducaoBcIcms := ACaracTrib.reducaoBcIcms;
  FReducaoBcIcmsSt := ACaracTrib.reducaoBcIcmsSt;
  FRedBcICMsInterestadual := ACaracTrib.redBcICMsInterestadual;
  FAliqIcmsSt := ACaracTrib.aliqIcmsSt;
  FIVA := ACaracTrib.iVA;
  FIVAAjust := ACaracTrib.iVAAjust;
  FFCP := ACaracTrib.fCP;
  FFCPSt := ACaracTrib.fCPSt;
  FCodBenef := ACaracTrib.codBenef;
  FPDifer := ACaracTrib.pDifer;
  FPIsencao := ACaracTrib.pIsencao;
  FAntecipado := ACaracTrib.antecipado;
  FDesonerado := ACaracTrib.desonerado;
  FPICMSDeson := ACaracTrib.pICMSDeson;
  FIsento := ACaracTrib.isento;
  FMotDesICMS := ACaracTrib.motDesICMS;
  FIndDeduzDeson := ACaracTrib.indDeduzDeson;
  FTpCalcDifal := ACaracTrib.tpCalcDifal;
  FDebitoPresumido := ACaracTrib.debitoPresumido;
  FDebitoPresumidoNaoCredenciado := ACaracTrib.debitoPresumidoNaoCredenciado;
  FAmpLegal := ACaracTrib.ampLegal;
  FRegraGeral := ACaracTrib.regraGeral;
  FPSuspensaoImportacao := ACaracTrib.pSuspensaoImportacao;
  FRegimeEspecial := ACaracTrib.regimeEspecial;

  if not ACaracTrib.Protocolo.IsEmpty then
  begin
    FProtocolo := TLibIMendesProtocoloResposta.Create('Protocolo' + AIndice, Tipo, Codificacao);
    FProtocolo.Processar(ACaracTrib.Protocolo);
  end;

  if not ACaracTrib.Convenio.IsEmpty then
  begin
    FConvenio := TLibIMendesConvenioResposta.Create('Convenio' + AIndice, Tipo, Codificacao);
    FConvenio.Processar(ACaracTrib.Convenio);
  end;

  if not ACaracTrib.ibs.IsEmpty then
  begin
    FIBS := TLibIMendesIBSResposta.Create('IBS' + AIndice, Tipo, Codificacao);
    FIBS.Processar(ACaracTrib.ibs);

    if not ACaracTrib.ibs.tributacaoRegular.IsEmpty then
    begin
      FIBSTributacaoRegular := TLibIMendesIBSTributacaoRegularResposta.Create('IBSTributacaoRegular' + AIndice, Tipo, Codificacao);
      FIBSTributacaoRegular.Processar(ACaracTrib.ibs.tributacaoRegular);
    end;
  end;

  for i := 0 to ACaracTrib.precoFabrica.Count - 1 do
  begin
    PF := TLibIMendesPrecoFabricaResposta.Create('PrecoFabrica' + AIndice + Indice(i + 1), Tipo, Codificacao);
    PF.Processar(ACaracTrib.precoFabrica[i]);
    FPrecosFabrica.Add(PF);
  end;

  for i := 0 to ACaracTrib.precoMaximoConsumidor.Count - 1 do
  begin
    PMC := TLibIMendesPrecoMaximoConsumidorResposta.Create('PrecoMaximoConsumidor' + AIndice + Indice(i + 1), Tipo, Codificacao);
    PMC.Processar(ACaracTrib.precoMaximoConsumidor[i]);
    FPrecosMaximoConsumidor.Add(PMC);
  end;

  for i := 0 to ACaracTrib.Pmpf.Count - 1 do
  begin
    Pmpf := TLibIMendesPmpfResposta.Create('Pmpf' + AIndice + Indice(i + 1), Tipo, Codificacao);
    Pmpf.Processar(ACaracTrib.Pmpf[i]);
    FPmpfs.Add(Pmpf);
  end;
end;

{ TLibIMendesUFResposta }

constructor TLibIMendesUFResposta.Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
  const AFormato: TACBrLibCodificacao);
begin
  inherited Create(ASessao, ATipo, AFormato);
  FCaracTribs := TACBrObjectList.Create;
end;

destructor TLibIMendesUFResposta.Destroy;
begin
  FCaracTribs.Free;
  inherited Destroy;
end;

procedure TLibIMendesUFResposta.Processar(const AUF: TACBrIMendesGrupoUF; const AIndice: String);
var
  i: Integer;
  wIndice: String;
  Item: TLibIMendesCaracTribResposta;
begin
  FUF := AUF.uF;
  FCFOP := AUF.CFOP.cFOP;
  FMensagem := AUF.mensagem;

  for i := 0 to AUF.CFOP.CaracTrib.Count - 1 do
  begin
    wIndice := AIndice + Indice(i + 1);
    Item := TLibIMendesCaracTribResposta.Create('CaracTrib' + wIndice, Tipo, Codificacao);
    Item.Processar(AUF.CFOP.CaracTrib[i], wIndice);
    FCaracTribs.Add(Item);
  end;
end;

{ TLibIMendesDadosRtCBSResposta }

procedure TLibIMendesDadosRtCBSResposta.Processar(const ACBS: TACBrIMendesGrupoDadosRtCBS);
begin
  FCST := ACBS.cst;
  FCstDescricao := ACBS.cstDescricao;
  FClassificacaoTributaria := ACBS.classificacaoTributaria;
  FClassificacaoTributariaDescricao := ACBS.classificacaoTributariaDescricao;
  FAliquota := ACBS.aliquota;
  FReducao := ACBS.reducao;
  FReducaoBaseCalculo := ACBS.reducaoBaseCalculo;
  FAmparoLegal := ACBS.amparoLegal;
end;

{ TLibIMendesDadosRtIBSResposta }

procedure TLibIMendesDadosRtIBSResposta.Processar(const AIBS: TACBrIMendesGrupoDadosRtIBS);
begin
  FCST := AIBS.cst;
  FCstDescricao := AIBS.cstDescricao;
  FClassificacaoTributaria := AIBS.classificacaoTributaria;
  FClassificacaoTributariaDescricao := AIBS.classificacaoTributariaDescricao;
  FAliquotaEstadual := AIBS.aliquotaEstadual;
  FAliquotaMunicipal := AIBS.aliquotaMunicipal;
  FReducao := AIBS.reducao;
  FReducaoBaseCalculo := AIBS.reducaoBaseCalculo;
  FAmparoLegal := AIBS.amparoLegal;
end;

{ TLibIMendesDadosRtISResposta }

procedure TLibIMendesDadosRtISResposta.Processar(const AIS: TACBrIMendesGrupoDadosRtIS);
begin
  FCST := AIS.cst;
  FCstDescricao := AIS.cstDescricao;
  FClassificacaoTributaria := AIS.classificacaoTributaria;
  FClassificacaoTributariaDescricao := AIS.classificacaoTributariaDescricao;
  FAliquota := AIS.aliquota;
  FAmparoLegal := AIS.amparoLegal;
end;

{ TLibIMendesDadosRtPeriodoResposta }

constructor TLibIMendesDadosRtPeriodoResposta.Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
  const AFormato: TACBrLibCodificacao);
begin
  inherited Create(ASessao, ATipo, AFormato);
  FCBS := Nil;
  FIBS := Nil;
  FIS := Nil;
end;

destructor TLibIMendesDadosRtPeriodoResposta.Destroy;
begin
  if Assigned(FCBS) then
    FCBS.Free;
  if Assigned(FIBS) then
    FIBS.Free;
  if Assigned(FIS) then
    FIS.Free;
  inherited Destroy;
end;

procedure TLibIMendesDadosRtPeriodoResposta.Processar(const APeriodo: TACBrIMendesGrupoDadosRtPeriodo;
  const AIndice: String);
begin
  FAnexo := APeriodo.anexo;
  FVigenciaInicial := APeriodo.vigenciaInicial;
  FVigenciaFinal := APeriodo.vigenciaFinal;
  FAno := APeriodo.ano;
  FPercentualIcmsUtilizado := APeriodo.percentualIcmsUtilizado;

  if not APeriodo.cbs.IsEmpty then
  begin
    FCBS := TLibIMendesDadosRtCBSResposta.Create('DadosRtCBS' + AIndice, Tipo, Codificacao);
    FCBS.Processar(APeriodo.cbs);
  end;

  if not APeriodo.ibs.IsEmpty then
  begin
    FIBS := TLibIMendesDadosRtIBSResposta.Create('DadosRtIBS' + AIndice, Tipo, Codificacao);
    FIBS.Processar(APeriodo.ibs);
  end;

  if not APeriodo.gis.IsEmpty then
  begin
    FIS := TLibIMendesDadosRtISResposta.Create('DadosRtIS' + AIndice, Tipo, Codificacao);
    FIS.Processar(APeriodo.gis);
  end;
end;

{ TLibIMendesGrupoResposta }

constructor TLibIMendesGrupoResposta.Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
  const AFormato: TACBrLibCodificacao);
begin
  inherited Create(ASessao, ATipo, AFormato);
  FCBS := Nil;
  FCBSTributacaoRegular := Nil;
  FIS := Nil;
  FPisCofins := Nil;
  FIPI := Nil;
  FUFs := TACBrObjectList.Create;
  FDadosRtPeriodos := TACBrObjectList.Create;
end;

destructor TLibIMendesGrupoResposta.Destroy;
begin
  if Assigned(FCBS) then
    FCBS.Free;
  if Assigned(FCBSTributacaoRegular) then
    FCBSTributacaoRegular.Free;
  if Assigned(FIS) then
    FIS.Free;
  if Assigned(FPisCofins) then
    FPisCofins.Free;
  if Assigned(FIPI) then
    FIPI.Free;
  FUFs.Free;
  FDadosRtPeriodos.Free;
  inherited Destroy;
end;

procedure TLibIMendesGrupoResposta.Processar(const AGrupo: TACBrIMendesGrupo; const AIndice: String);
var
  r, u, nUF, p: Integer;
  wIndice: String;
  UF: TLibIMendesUFResposta;
  Periodo: TLibIMendesDadosRtPeriodoResposta;
  wTipo: TACBrLibRespostaTipo;
begin
  // A property Tipo (String) do grupo esconde o Tipo da resposta herdado da base
  wTipo := TACBrLibRespostaBase(Self).Tipo;

  FCodigo := AGrupo.codigo;
  FDescricao := AGrupo.descricao;
  FNCM := AGrupo.nCM;
  FCEST := AGrupo.cEST;
  FDtVigIni := AGrupo.dtVigIni;
  FDtVigFin := AGrupo.dtVigFin;
  FLista := AGrupo.lista;
  FTipo := AGrupo.tipo;
  FCodAnp := AGrupo.codAnp;
  FPassivelPMC := AGrupo.passivelPMC;
  FImpostoImportacao := AGrupo.impostoImportacao;
  FMensagem := AGrupo.Mensagem;
  FProdCodInterno := ListaParaTexto(AGrupo.prodCodInterno);
  FProdEan := ListaParaTexto(AGrupo.prodEan);
  FProdCodImendes := ListaParaTexto(AGrupo.prodCodImendes);

  if not AGrupo.cbs.IsEmpty then
  begin
    FCBS := TLibIMendesCBSResposta.Create('CBS' + AIndice, wTipo, Codificacao);
    FCBS.Processar(AGrupo.cbs);

    if not AGrupo.cbs.tributacaoRegular.IsEmpty then
    begin
      FCBSTributacaoRegular := TLibIMendesCBSTributacaoRegularResposta.Create('CBSTributacaoRegular' + AIndice, wTipo, Codificacao);
      FCBSTributacaoRegular.Processar(AGrupo.cbs.tributacaoRegular);
    end;
  end;

  if not AGrupo.gis.IsEmpty then
  begin
    FIS := TLibIMendesISResposta.Create('IS' + AIndice, wTipo, Codificacao);
    FIS.Processar(AGrupo.gis);
  end;

  if not AGrupo.pisCofins.IsEmpty then
  begin
    FPisCofins := TLibIMendesPisCofinsResposta.Create('PisCofins' + AIndice, wTipo, Codificacao);
    FPisCofins.Processar(AGrupo.pisCofins);
  end;

  if not AGrupo.iPI.IsEmpty then
  begin
    FIPI := TLibIMendesIPIResposta.Create('IPI' + AIndice, wTipo, Codificacao);
    FIPI.Processar(AGrupo.iPI);
  end;

  // O nivel "Regras" e eliminado: as UFs de todas as regras sao numeradas em sequencia
  nUF := 0;
  for r := 0 to AGrupo.Regras.Count - 1 do
  begin
    for u := 0 to AGrupo.Regras[r].uFs.Count - 1 do
    begin
      Inc(nUF);
      wIndice := AIndice + Indice(nUF);
      UF := TLibIMendesUFResposta.Create('UF' + wIndice, wTipo, Codificacao);
      UF.Processar(AGrupo.Regras[r].uFs[u], wIndice);
      FUFs.Add(UF);
    end;
  end;

  // dadosRt: opcional, retornado somente mediante solicitacao do parceiro ao suporte IMendes
  // (Manual de Integracao API 3.0 v3.3.26, pag. 20 e 38)
  for p := 0 to AGrupo.dadosRt.periodos.Count - 1 do
  begin
    wIndice := AIndice + Indice(p + 1);
    Periodo := TLibIMendesDadosRtPeriodoResposta.Create('DadosRtPeriodo' + wIndice, wTipo, Codificacao);
    Periodo.Processar(AGrupo.dadosRt.periodos[p], wIndice);
    FDadosRtPeriodos.Add(Periodo);
  end;
end;

{ TLibIMendesSemRetornoResposta }

procedure TLibIMendesSemRetornoResposta.Processar(const AItem: TACBrIMendesSemRetornoItem);
begin
  FCodInterno := AItem.CodInterno;
  FCodProduto := AItem.CodProduto;
end;

{ TLibIMendesBaixaSimilaridadeResposta }

procedure TLibIMendesBaixaSimilaridadeResposta.Processar(const AItem: TACBrIMendesBaixaSimilaridadeItem);
begin
  FCodigoProduto := AItem.CodProduto;
  FDescricaoIMendes := AItem.DescricaoIMendes;
  FDescricaoInformada := AItem.DescricaoInformada;
  FPercentualSimilaridade := AItem.PercentualSimilaridade;
end;

{ TLibIMendesSaneamentoResposta }

constructor TLibIMendesSaneamentoResposta.Create(const ATipo: TACBrLibRespostaTipo; const AFormato: TACBrLibCodificacao);
begin
  inherited Create(CSessaoRespSaneamentoGrades, ATipo, AFormato);
  FCabecalho := TLibIMendesSaneamentoCabecalhoResposta.Create('Cabecalho', ATipo, AFormato);
  FGrupos := TACBrObjectList.Create;
  FSemRetorno := TACBrObjectList.Create;
  FBaixaSimilaridade := TACBrObjectList.Create;
end;

destructor TLibIMendesSaneamentoResposta.Destroy;
begin
  FCabecalho.Free;
  FGrupos.Free;
  FSemRetorno.Free;
  FBaixaSimilaridade.Free;
  inherited Destroy;
end;

procedure TLibIMendesSaneamentoResposta.Processar(const AResposta: TACBrIMendesSaneamentoResponse);
var
  i: Integer;
  wIndice: String;
  Grupo: TLibIMendesGrupoResposta;
  SemRet: TLibIMendesSemRetornoResposta;
  Baixa: TLibIMendesBaixaSimilaridadeResposta;
begin
  FCabecalho.Processar(AResposta.Cabecalho);

  for i := 0 to AResposta.Grupos.Count - 1 do
  begin
    wIndice := Indice(i + 1);
    Grupo := TLibIMendesGrupoResposta.Create('Grupo' + wIndice, Tipo, Codificacao);
    Grupo.Processar(AResposta.Grupos[i], wIndice);
    FGrupos.Add(Grupo);
  end;

  for i := 0 to AResposta.SemRetorno.Count - 1 do
  begin
    SemRet := TLibIMendesSemRetornoResposta.Create('SemRetorno' + Indice(i + 1), Tipo, Codificacao);
    SemRet.Processar(AResposta.SemRetorno[i]);
    FSemRetorno.Add(SemRet);
  end;

  for i := 0 to AResposta.BaixaSimilaridade.Count - 1 do
  begin
    Baixa := TLibIMendesBaixaSimilaridadeResposta.Create('BaixaSimilaridade' + Indice(i + 1), Tipo, Codificacao);
    Baixa.Processar(AResposta.BaixaSimilaridade[i]);
    FBaixaSimilaridade.Add(Baixa);
  end;
end;

end.
