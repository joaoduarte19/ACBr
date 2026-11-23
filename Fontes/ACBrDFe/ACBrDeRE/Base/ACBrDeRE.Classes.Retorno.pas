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

unit ACBrDeRE.Classes.Retorno;

interface

uses
  SysUtils, Classes,
  {$IF DEFINED(HAS_SYSTEM_GENERICS)}
   System.Generics.Collections, System.Generics.Defaults,
  {$ELSEIF DEFINED(DELPHICOMPILER16_UP)}
   System.Contnrs,
  {$IFEND}
  ACBrBase,
  ACBrXmlBase,
  ACBrDFe.Conversao,
  ACBrDeRE.Conversao,
  ACBrDeRE.Classes;

type

  { TOcorrenciaCollectionItem }

  TOcorrenciaCollectionItem = class(TObject)
  private
    Fcodigo: string;
    Fdescricao: string;
    Ftipo: TTipoOcorrenciaDeRE;
    Flocalizacao: string;
  public
    property codigo: string read Fcodigo write Fcodigo;
    property descricao: string read Fdescricao write Fdescricao;
    property tipo: TTipoOcorrenciaDeRE read Ftipo write Ftipo;
    property localizacao: string read Flocalizacao write Flocalizacao;
  end;

  { TOcorrenciaCollection }

  TOcorrenciaCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TOcorrenciaCollectionItem;
    procedure SetItem(Index: Integer; Value: TOcorrenciaCollectionItem);
  public
    function New: TOcorrenciaCollectionItem;
    property Items[Index: Integer]: TOcorrenciaCollectionItem read GetItem write SetItem; default;
  end;

  { TStatusLote }

  TStatusLote = class(TObject)
  private
    FcdResposta: TCdRespostaLoteDeRE;
    FdescResposta: string;
    Focorrencias: TOcorrenciaCollection;
    procedure Setocorrencias(const Value: TOcorrenciaCollection);
  public
    constructor Create;
    destructor Destroy; override;

    property cdResposta: TCdRespostaLoteDeRE read FcdResposta write FcdResposta;
    property descResposta: string read FdescResposta write FdescResposta;
    property ocorrencias: TOcorrenciaCollection read Focorrencias write Setocorrencias;
  end;

  { TDadosRecepcaoLote }

  TDadosRecepcaoLote = class(TObject)
  private
    FTemDados: Boolean;
    FdhRecepcao: TDateTime;
    FversaoAplicativoRecepcao: string;
    Fprotocolo: string;
  public
    property TemDados: Boolean read FTemDados write FTemDados;
    property dhRecepcao: TDateTime read FdhRecepcao write FdhRecepcao;
    property versaoAplicativoRecepcao: string read FversaoAplicativoRecepcao write FversaoAplicativoRecepcao;
    property protocolo: string read Fprotocolo write Fprotocolo;
  end;

  { TDadosProcessamentoLote }

  TDadosProcessamentoLote = class(TObject)
  private
    FTemDados: Boolean;
    FdhProcessamento: TDateTime;
    FversaoAplicativoProcessamento: string;
  public
    property TemDados: Boolean read FTemDados write FTemDados;
    property dhProcessamento: TDateTime read FdhProcessamento write FdhProcessamento;
    property versaoAplicativoProcessamento: string read FversaoAplicativoProcessamento write FversaoAplicativoProcessamento;
  end;

  TideStatus = class;
  TinfoRecEv = class;
  TevtRetornoTabela = class;
  TevtRetornoDeRE = class;

  { TRetornoEventoCollectionItem - evento de retorno contido no lote (retornoEventos/evento).
    O XML original fica em XML; o conteudo e interpretado em Retorno (D-91xx/D-92xx) ou em
    RetornoTabela (D-9001), conforme TipoRetorno. Retorno e RetornoTabela sao nil quando nao se aplicam. }

  TRetornoEventoCollectionItem = class(TObject)
  private
    Fid: string;
    FXML: string;
    FTipoRetorno: TTipoRetornoDeRE;
    FRetorno: TevtRetornoDeRE;
    FRetornoTabela: TevtRetornoTabela;
  public
    destructor Destroy; override;

    property TipoRetorno: TTipoRetornoDeRE read FTipoRetorno write FTipoRetorno;
    property Retorno: TevtRetornoDeRE read FRetorno write FRetorno;
    property RetornoTabela: TevtRetornoTabela read FRetornoTabela write FRetornoTabela;
    property id: string read Fid write Fid;
    property XML: string read FXML write FXML;
  end;

  { TRetornoEventoCollection }

  TRetornoEventoCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TRetornoEventoCollectionItem;
    procedure SetItem(Index: Integer; Value: TRetornoEventoCollectionItem);
  public
    function New: TRetornoEventoCollectionItem;
    property Items[Index: Integer]: TRetornoEventoCollectionItem read GetItem write SetItem; default;
  end;

  { TgTotalCodTribCollectionItemRet }

  TgTotalCodTribCollectionItemRet = class(TObject)
  private
    FcodTrib: Integer;
    FindTribISS: Boolean;
    FvApurTot: Double;
    FvTotSaldoInic: Double;
    FTemvTotSaldoInic: Boolean;
    FvTotSaldoFinal: Double;
    FTemvTotSaldoFinal: Boolean;
  public
    property codTrib: Integer read FcodTrib write FcodTrib;
    property indTribISS: Boolean read FindTribISS write FindTribISS;
    property vApurTot: Double read FvApurTot write FvApurTot;
    property vTotSaldoInic: Double read FvTotSaldoInic write FvTotSaldoInic;
    property TemvTotSaldoInic: Boolean read FTemvTotSaldoInic write FTemvTotSaldoInic;
    property vTotSaldoFinal: Double read FvTotSaldoFinal write FvTotSaldoFinal;
    property TemvTotSaldoFinal: Boolean read FTemvTotSaldoFinal write FTemvTotSaldoFinal;
  end;

  { TgTotalCodTribCollectionRet }

  TgTotalCodTribCollectionRet = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TgTotalCodTribCollectionItemRet;
    procedure SetItem(Index: Integer; Value: TgTotalCodTribCollectionItemRet);
  public
    function New: TgTotalCodTribCollectionItemRet;
    property Items[Index: Integer]: TgTotalCodTribCollectionItemRet read GetItem write SetItem; default;
  end;

  { TinfoTotVApurRet }

  TinfoTotVApurRet = class(TObject)
  private
    FvApurTot: Double;
  public
    property vApurTot: Double read FvApurTot write FvApurTot;
  end;

  { TinfoAdicRet }

  TinfoAdicRet = class(TObject)
  private
    FnrReciboPGCC: string;
    FnrReciboBalancete: string;
    FnrReciboAplicFin: string;
    FnrReciboOperTitPub: string;
    FnrReciboRelDedu: TStringList;
  public
    constructor Create;
    destructor Destroy; override;

    property nrReciboPGCC: string read FnrReciboPGCC write FnrReciboPGCC;
    property nrReciboBalancete: string read FnrReciboBalancete write FnrReciboBalancete;
    property nrReciboAplicFin: string read FnrReciboAplicFin write FnrReciboAplicFin;
    property nrReciboOperTitPub: string read FnrReciboOperTitPub write FnrReciboOperTitPub;
    property nrReciboRelDedu: TStringList read FnrReciboRelDedu write FnrReciboRelDedu;
  end;

  { TgCoeficientesRet }

  TgCoeficientesRet = class(TObject)
  private
    FpRateioDespCapt: Double;
    FTempRateioDespCapt: Boolean;
    FpRevDedAtoCoop: Double;
    FTempRevDedAtoCoop: Boolean;
    FpExportIaV: Double;
    FTempExportIaV: Boolean;
    FpExportVI: Double;
    FTempExportVI: Boolean;
    FpExportIX: Double;
    FTempExportIX: Boolean;
    FpExportXI: Double;
    FTempExportXI: Boolean;
    FpExportXIII: Double;
    FTempExportXIII: Boolean;
    FpExportXIV: Double;
    FTempExportXIV: Boolean;
    FpExportProg: Double;
    FTempExportProg: Boolean;
  public
    property pRateioDespCapt: Double read FpRateioDespCapt write FpRateioDespCapt;
    property TempRateioDespCapt: Boolean read FTempRateioDespCapt write FTempRateioDespCapt;
    property pRevDedAtoCoop: Double read FpRevDedAtoCoop write FpRevDedAtoCoop;
    property TempRevDedAtoCoop: Boolean read FTempRevDedAtoCoop write FTempRevDedAtoCoop;
    property pExportIaV: Double read FpExportIaV write FpExportIaV;
    property TempExportIaV: Boolean read FTempExportIaV write FTempExportIaV;
    property pExportVI: Double read FpExportVI write FpExportVI;
    property TempExportVI: Boolean read FTempExportVI write FTempExportVI;
    property pExportIX: Double read FpExportIX write FpExportIX;
    property TempExportIX: Boolean read FTempExportIX write FTempExportIX;
    property pExportXI: Double read FpExportXI write FpExportXI;
    property TempExportXI: Boolean read FTempExportXI write FTempExportXI;
    property pExportXIII: Double read FpExportXIII write FpExportXIII;
    property TempExportXIII: Boolean read FTempExportXIII write FTempExportXIII;
    property pExportXIV: Double read FpExportXIV write FpExportXIV;
    property TempExportXIV: Boolean read FTempExportXIV write FTempExportXIV;
    property pExportProg: Double read FpExportProg write FpExportProg;
    property TempExportProg: Boolean read FTempExportProg write FTempExportProg;
  end;

  { TgBCIBSRet }

  TgBCIBSRet = class(TObject)
  private
    FvBCIBS: Double;
    FvBCNIBS: Double;
    FTemvBCNIBS: Boolean;
    FvDedBCN: Double;
    FTemvDedBCN: Boolean;
    FvBCApurIBS: Double;
    FpIBSMun: Double;
    FvIBSMun: Double;
    FpIBSUF: Double;
    FvIBSUF: Double;
    FpIBS: Double;
    FvIBSTot: Double;
  public
    property vBCIBS: Double read FvBCIBS write FvBCIBS;
    property vBCNIBS: Double read FvBCNIBS write FvBCNIBS;
    property TemvBCNIBS: Boolean read FTemvBCNIBS write FTemvBCNIBS;
    property vDedBCN: Double read FvDedBCN write FvDedBCN;
    property TemvDedBCN: Boolean read FTemvDedBCN write FTemvDedBCN;
    property vBCApurIBS: Double read FvBCApurIBS write FvBCApurIBS;
    property pIBSMun: Double read FpIBSMun write FpIBSMun;
    property vIBSMun: Double read FvIBSMun write FvIBSMun;
    property pIBSUF: Double read FpIBSUF write FpIBSUF;
    property vIBSUF: Double read FvIBSUF write FvIBSUF;
    property pIBS: Double read FpIBS write FpIBS;
    property vIBSTot: Double read FvIBSTot write FvIBSTot;
  end;

  { TgBCCBSRet }

  TgBCCBSRet = class(TObject)
  private
    FvBCCBS: Double;
    FvBCNCBS: Double;
    FTemvBCNCBS: Boolean;
    FvDedBCN: Double;
    FTemvDedBCN: Boolean;
    FvBCApurCBS: Double;
    FpCBS: Double;
    FvCBS: Double;
  public
    property vBCCBS: Double read FvBCCBS write FvBCCBS;
    property vBCNCBS: Double read FvBCNCBS write FvBCNCBS;
    property TemvBCNCBS: Boolean read FTemvBCNCBS write FTemvBCNCBS;
    property vDedBCN: Double read FvDedBCN write FvDedBCN;
    property TemvDedBCN: Boolean read FTemvDedBCN write FTemvDedBCN;
    property vBCApurCBS: Double read FvBCApurCBS write FvBCApurCBS;
    property pCBS: Double read FpCBS write FpCBS;
    property vCBS: Double read FvCBS write FvCBS;
  end;

  { TgBCISRet }

  TgBCISRet = class(TObject)
  private
    FvBCIS: Double;
    FvBCApurIS: Double;
    FTemvBCApurIS: Boolean;
    FpIS: Double;
    FTempIS: Boolean;
    FvIS: Double;
    FTemvIS: Boolean;
  public
    property vBCIS: Double read FvBCIS write FvBCIS;
    property vBCApurIS: Double read FvBCApurIS write FvBCApurIS;
    property TemvBCApurIS: Boolean read FTemvBCApurIS write FTemvBCApurIS;
    property pIS: Double read FpIS write FpIS;
    property TempIS: Boolean read FTempIS write FTempIS;
    property vIS: Double read FvIS write FvIS;
    property TemvIS: Boolean read FTemvIS write FTemvIS;
  end;

  { TdetBCNCollectionItemRet }

  TdetBCNCollectionItemRet = class(TObject)
  private
    FcodBCN: string;
    FperOrigem: string;
    FvOrigemIni: Double;
    FvSaldoAnt: Double;
    FvUtilPer: Double;
    FvSaldoFinal: Double;
  public
    property codBCN: string read FcodBCN write FcodBCN;
    property perOrigem: string read FperOrigem write FperOrigem;
    property vOrigemIni: Double read FvOrigemIni write FvOrigemIni;
    property vSaldoAnt: Double read FvSaldoAnt write FvSaldoAnt;
    property vUtilPer: Double read FvUtilPer write FvUtilPer;
    property vSaldoFinal: Double read FvSaldoFinal write FvSaldoFinal;
  end;

  { TdetBCNCollectionRet }

  TdetBCNCollectionRet = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TdetBCNCollectionItemRet;
    procedure SetItem(Index: Integer; Value: TdetBCNCollectionItemRet);
  public
    function New: TdetBCNCollectionItemRet;
    property Items[Index: Integer]: TdetBCNCollectionItemRet read GetItem write SetItem; default;
  end;

  { TgBCNRet }

  TgBCNRet = class(TObject)
  private
    FcodBCNRaiz: string;
    FvSaldoAnt: Double;
    FvUtilPer: Double;
    FvSaldoFinal: Double;
    FqtdOrigens: Integer;
    FdetBCN: TdetBCNCollectionRet;
    procedure SetdetBCN(const Value: TdetBCNCollectionRet);
  public
    constructor Create;
    destructor Destroy; override;

    property codBCNRaiz: string read FcodBCNRaiz write FcodBCNRaiz;
    property vSaldoAnt: Double read FvSaldoAnt write FvSaldoAnt;
    property vUtilPer: Double read FvUtilPer write FvUtilPer;
    property vSaldoFinal: Double read FvSaldoFinal write FvSaldoFinal;
    property qtdOrigens: Integer read FqtdOrigens write FqtdOrigens;
    property detBCN: TdetBCNCollectionRet read FdetBCN write SetdetBCN;
  end;

  { TinfoBCNRet }

  TinfoBCNRet = class(TObject)
  private
    FgBCNIBS: TgBCNRet;
    FgBCNCBS: TgBCNRet;
  public
    constructor Create;
    destructor Destroy; override;

    property gBCNIBS: TgBCNRet read FgBCNIBS write FgBCNIBS;
    property gBCNCBS: TgBCNRet read FgBCNCBS write FgBCNCBS;
  end;

  { TdetBCCollectionItemRet }

  TdetBCCollectionItemRet = class(TObject)
  private
    FcodBC: string;
    FxDetBC: string;
    FgCoeficientes: TgCoeficientesRet;
    FTemgCoeficientes: Boolean;
    FmemoriaCalculo: string;
    FgBCIBS: TgBCIBSRet;
    FgBCCBS: TgBCCBSRet;
    FgBCIS: TgBCISRet;
    FTemgBCIS: Boolean;
    FinfoBCN: TinfoBCNRet;
    FTeminfoBCN: Boolean;
  public
    constructor Create;
    destructor Destroy; override;

    property codBC: string read FcodBC write FcodBC;
    property xDetBC: string read FxDetBC write FxDetBC;
    property gCoeficientes: TgCoeficientesRet read FgCoeficientes write FgCoeficientes;
    property TemgCoeficientes: Boolean read FTemgCoeficientes write FTemgCoeficientes;
    property memoriaCalculo: string read FmemoriaCalculo write FmemoriaCalculo;
    property gBCIBS: TgBCIBSRet read FgBCIBS write FgBCIBS;
    property gBCCBS: TgBCCBSRet read FgBCCBS write FgBCCBS;
    property gBCIS: TgBCISRet read FgBCIS write FgBCIS;
    property TemgBCIS: Boolean read FTemgBCIS write FTemgBCIS;
    property infoBCN: TinfoBCNRet read FinfoBCN write FinfoBCN;
    property TeminfoBCN: Boolean read FTeminfoBCN write FTeminfoBCN;
  end;

  { TdetBCCollectionRet }

  TdetBCCollectionRet = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TdetBCCollectionItemRet;
    procedure SetItem(Index: Integer; Value: TdetBCCollectionItemRet);
  public
    function New: TdetBCCollectionItemRet;
    property Items[Index: Integer]: TdetBCCollectionItemRet read GetItem write SetItem; default;
  end;

  { TtotalTributosRet }

  TtotalTributosRet = class(TObject)
  private
    FvIS: Double;
    FTemvIS: Boolean;
    FvIBSMun: Double;
    FvIBSUF: Double;
    FvIBSTot: Double;
    FvCBS: Double;
  public
    property vIS: Double read FvIS write FvIS;
    property TemvIS: Boolean read FTemvIS write FTemvIS;
    property vIBSMun: Double read FvIBSMun write FvIBSMun;
    property vIBSUF: Double read FvIBSUF write FvIBSUF;
    property vIBSTot: Double read FvIBSTot write FvIBSTot;
    property vCBS: Double read FvCBS write FvCBS;
  end;

  { TinfoTotMensalRet }

  TinfoTotMensalRet = class(TObject)
  private
    FdetBC: TdetBCCollectionRet;
    FtotalTributos: TtotalTributosRet;
    procedure SetdetBC(const Value: TdetBCCollectionRet);
  public
    constructor Create;
    destructor Destroy; override;

    property detBC: TdetBCCollectionRet read FdetBC write SetdetBC;
    property totalTributos: TtotalTributosRet read FtotalTributos write FtotalTributos;
  end;

  { TevtRetornoDeRE - eventos de retorno D-9101, D-9106, D-9109, D-9112, D-9121, D-9198, D-9199 e D-9209.
    Os grupos nao aplicados ao tipo do retorno ficam com o respectivo Tem... = False. }

  TevtRetornoDeRE = class(TObject)
  private
    FTipoRetorno: TTipoRetornoDeRE;
    Fid: string;
    FnrInsc: string;
    FideStatus: TideStatus;
    FinfoRecEv: TinfoRecEv;
    FTemInfoEvento: Boolean;
    FidePeriodo: TidePeriodoApur;
    FTeminfoAdic: Boolean;
    FinfoAdic: TinfoAdicRet;
    FTeminfoTotBalan: Boolean;
    FinfoTotBalan: TgTotalCodTribCollectionRet;
    FTeminfoTotAplicFin: Boolean;
    FinfoTotAplicFin: TinfoTotVApurRet;
    FTeminfoTotTitOfPub: Boolean;
    FinfoTotTitOfPub: TinfoTotVApurRet;
    FTeminfoTotFinanceiro: Boolean;
    FinfoTotFinanceiro: TinfoTotMensalRet;
    FTeminfoTotSaude: Boolean;
    FinfoTotSaude: TinfoTotMensalRet;
    FTeminfoTotProg: Boolean;
    FinfoTotProg: TinfoTotMensalRet;
    FTemtotalTributosGeral: Boolean;
    FtotalTributosGeral: TtotalTributosRet;
    FSignature: TSignature;
    procedure CriarObjetos;
    procedure LiberarObjetos;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Clear;

    property TipoRetorno: TTipoRetornoDeRE read FTipoRetorno write FTipoRetorno;
    property id: string read Fid write Fid;
    property nrInsc: string read FnrInsc write FnrInsc;
    property ideStatus: TideStatus read FideStatus;
    property infoRecEv: TinfoRecEv read FinfoRecEv;
    property TemInfoEvento: Boolean read FTemInfoEvento write FTemInfoEvento;
    property idePeriodo: TidePeriodoApur read FidePeriodo;
    property TeminfoAdic: Boolean read FTeminfoAdic write FTeminfoAdic;
    property infoAdic: TinfoAdicRet read FinfoAdic;
    // D-9101: totalizadores por codigo de tributacao (infoTotBalan/gTotalCodTrib)
    property TeminfoTotBalan: Boolean read FTeminfoTotBalan write FTeminfoTotBalan;
    property infoTotBalan: TgTotalCodTribCollectionRet read FinfoTotBalan;
    // D-9106: infoTotAplicFin / D-9121: infoTotTitOfPub
    property TeminfoTotAplicFin: Boolean read FTeminfoTotAplicFin write FTeminfoTotAplicFin;
    property infoTotAplicFin: TinfoTotVApurRet read FinfoTotAplicFin;
    property TeminfoTotTitOfPub: Boolean read FTeminfoTotTitOfPub write FTeminfoTotTitOfPub;
    property infoTotTitOfPub: TinfoTotVApurRet read FinfoTotTitOfPub;
    // D-9199: totalizadores do fechamento mensal
    property TeminfoTotFinanceiro: Boolean read FTeminfoTotFinanceiro write FTeminfoTotFinanceiro;
    property infoTotFinanceiro: TinfoTotMensalRet read FinfoTotFinanceiro;
    property TeminfoTotSaude: Boolean read FTeminfoTotSaude write FTeminfoTotSaude;
    property infoTotSaude: TinfoTotMensalRet read FinfoTotSaude;
    property TeminfoTotProg: Boolean read FTeminfoTotProg write FTeminfoTotProg;
    property infoTotProg: TinfoTotMensalRet read FinfoTotProg;
    property TemtotalTributosGeral: Boolean read FTemtotalTributosGeral write FTemtotalTributosGeral;
    property totalTributosGeral: TtotalTributosRet read FtotalTributosGeral;
    property Signature: TSignature read FSignature;
  end;

  { TretornoLoteDeRE }

  TretornoLoteDeRE = class(TObject)
  private
    Fid: string;
    FnrInsc: string;
    FniTransmissor: string;
    Fstatus: TStatusLote;
    FdadosRecepcaoLote: TDadosRecepcaoLote;
    FdadosProcessamentoLote: TDadosProcessamentoLote;
    FretornoEventos: TRetornoEventoCollection;
    FSignature: TSignature;
    procedure SetretornoEventos(const Value: TRetornoEventoCollection);
  public
    constructor Create;
    destructor Destroy; override;

    procedure Clear;

    property id: string read Fid write Fid;
    property nrInsc: string read FnrInsc write FnrInsc;
    property niTransmissor: string read FniTransmissor write FniTransmissor;
    property status: TStatusLote read Fstatus write Fstatus;
    property dadosRecepcaoLote: TDadosRecepcaoLote read FdadosRecepcaoLote write FdadosRecepcaoLote;
    property dadosProcessamentoLote: TDadosProcessamentoLote read FdadosProcessamentoLote write FdadosProcessamentoLote;
    property retornoEventos: TRetornoEventoCollection read FretornoEventos write SetretornoEventos;
    property Signature: TSignature read FSignature write FSignature;
  end;

  { TideStatus }

  TideStatus = class(TObject)
  private
    FcdRetorno: TCdRetornoDeRE;
    FdescRetorno: TDescRetornoDeRE;
    Focorrencias: TOcorrenciaCollection;
    procedure Setocorrencias(const Value: TOcorrenciaCollection);
  public
    constructor Create;
    destructor Destroy; override;

    property cdRetorno: TCdRetornoDeRE read FcdRetorno write FcdRetorno;
    property descRetorno: TDescRetornoDeRE read FdescRetorno write FdescRetorno;
    property ocorrencias: TOcorrenciaCollection read Focorrencias write Setocorrencias;
  end;

  { TinfoRecEv }

  TinfoRecEv = class(TObject)
  private
    FnrRecibo: string;
    FprotocoloLote: string;
    FdhRecepcao: TDateTime;
    FdhProcess: TDateTime;
    FseqEvento: string;
    FtpEv: TTipoEventoDeRE;
    FtpEvStr: string;
    Fhash: string;
  public
    property nrRecibo: string read FnrRecibo write FnrRecibo;
    property seqEvento: string read FseqEvento write FseqEvento;
    property protocoloLote: string read FprotocoloLote write FprotocoloLote;
    property dhRecepcao: TDateTime read FdhRecepcao write FdhRecepcao;
    property dhProcess: TDateTime read FdhProcess write FdhProcess;
    // Tipo do evento conforme o ambiente (ex.: D1001). Quando o ambiente nao identifica o
    // evento ele devolve um valor fora da lista (ex.: D0): tpEvStr guarda o valor recebido e
    // tpEv so e preenchido quando o valor for um tipo conhecido.
    property tpEv: TTipoEventoDeRE read FtpEv write FtpEv;
    property tpEvStr: string read FtpEvStr write FtpEvStr;
    property hash: string read Fhash write Fhash;
  end;

  { TinfoEvento }

  TinfoEvento = class(TObject)
  private
    FTemInfoEvento: Boolean;
    FidePeriodo: TidePeriodo;
  public
    constructor Create;
    destructor Destroy; override;

    property TemInfoEvento: Boolean read FTemInfoEvento write FTemInfoEvento;
    property idePeriodo: TidePeriodo read FidePeriodo write FidePeriodo;
  end;

  { TdetEventoCollectionItem }

  TdetEventoCollectionItem = class(TObject)
  private
    FnrRecibo: string;
    FiniValid: TDateTime;
    FfimValid: TDateTime;
    FTemfimValid: Boolean;
    FfimValidEfetiva: TDateTime;
    FTemfimValidEfetiva: Boolean;
    FindAjusteAuto: Boolean;
  public
    property nrRecibo: string read FnrRecibo write FnrRecibo;
    property iniValid: TDateTime read FiniValid write FiniValid;
    property fimValid: TDateTime read FfimValid write FfimValid;
    property TemfimValid: Boolean read FTemfimValid write FTemfimValid;
    property fimValidEfetiva: TDateTime read FfimValidEfetiva write FfimValidEfetiva;
    property TemfimValidEfetiva: Boolean read FTemfimValidEfetiva write FTemfimValidEfetiva;
    property indAjusteAuto: Boolean read FindAjusteAuto write FindAjusteAuto;
  end;

  { TdetEventoCollection }

  TdetEventoCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TdetEventoCollectionItem;
    procedure SetItem(Index: Integer; Value: TdetEventoCollectionItem);
  public
    function New: TdetEventoCollectionItem;
    property Items[Index: Integer]: TdetEventoCollectionItem read GetItem write SetItem; default;
  end;

  { TdetLacunaCollectionItem }

  TdetLacunaCollectionItem = class(TObject)
  private
    FiniLacuna: TDateTime;
    FfimLacuna: TDateTime;
    FTemfimLacuna: Boolean;
  public
    property iniLacuna: TDateTime read FiniLacuna write FiniLacuna;
    property fimLacuna: TDateTime read FfimLacuna write FfimLacuna;
    property TemfimLacuna: Boolean read FTemfimLacuna write FTemfimLacuna;
  end;

  { TdetLacunaCollection }

  TdetLacunaCollection = class(TACBrObjectList)
  private
    function GetItem(Index: Integer): TdetLacunaCollectionItem;
    procedure SetItem(Index: Integer; Value: TdetLacunaCollectionItem);
  public
    function New: TdetLacunaCollectionItem;
    property Items[Index: Integer]: TdetLacunaCollectionItem read GetItem write SetItem; default;
  end;

  { TextratoEventos }

  TextratoEventos = class(TObject)
  private
    FTemExtrato: Boolean;
    FdetEvento: TdetEventoCollection;
    FdetLacuna: TdetLacunaCollection;
    procedure SetdetEvento(const Value: TdetEventoCollection);
    procedure SetdetLacuna(const Value: TdetLacunaCollection);
  public
    constructor Create;
    destructor Destroy; override;

    property TemExtrato: Boolean read FTemExtrato write FTemExtrato;
    property detEvento: TdetEventoCollection read FdetEvento write SetdetEvento;
    property detLacuna: TdetLacunaCollection read FdetLacuna write SetdetLacuna;
  end;

  { TevtRetornoTabela }

  TevtRetornoTabela = class(TObject)
  private
    Fid: string;
    FnrInsc: string;
    FideStatus: TideStatus;
    FinfoRecEv: TinfoRecEv;
    FinfoEvento: TinfoEvento;
    FextratoEventos: TextratoEventos;
    FSignature: TSignature;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Clear;

    property id: string read Fid write Fid;
    property nrInsc: string read FnrInsc write FnrInsc;
    property ideStatus: TideStatus read FideStatus write FideStatus;
    property infoRecEv: TinfoRecEv read FinfoRecEv write FinfoRecEv;
    property infoEvento: TinfoEvento read FinfoEvento write FinfoEvento;
    property extratoEventos: TextratoEventos read FextratoEventos write FextratoEventos;
    property Signature: TSignature read FSignature write FSignature;
  end;

implementation

{ TgTotalCodTribCollectionItemRet }

{ TgTotalCodTribCollectionRet }

function TgTotalCodTribCollectionRet.GetItem(Index: Integer): TgTotalCodTribCollectionItemRet;
begin
  Result := TgTotalCodTribCollectionItemRet(inherited Items[Index]);
end;

procedure TgTotalCodTribCollectionRet.SetItem(Index: Integer; Value: TgTotalCodTribCollectionItemRet);
begin
  inherited Items[Index] := Value;
end;

function TgTotalCodTribCollectionRet.New: TgTotalCodTribCollectionItemRet;
begin
  Result := TgTotalCodTribCollectionItemRet.Create;
  Add(Result);
end;


{ TinfoTotVApurRet }


{ TinfoAdicRet }

constructor TinfoAdicRet.Create;
begin
  inherited Create;
  FnrReciboRelDedu := TStringList.Create;
end;

destructor TinfoAdicRet.Destroy;
begin
  FnrReciboRelDedu.Free;
  inherited Destroy;
end;


{ TgCoeficientesRet }


{ TgBCIBSRet }


{ TgBCCBSRet }


{ TgBCISRet }


{ TdetBCNCollectionItemRet }

{ TdetBCNCollectionRet }

function TdetBCNCollectionRet.GetItem(Index: Integer): TdetBCNCollectionItemRet;
begin
  Result := TdetBCNCollectionItemRet(inherited Items[Index]);
end;

procedure TdetBCNCollectionRet.SetItem(Index: Integer; Value: TdetBCNCollectionItemRet);
begin
  inherited Items[Index] := Value;
end;

function TdetBCNCollectionRet.New: TdetBCNCollectionItemRet;
begin
  Result := TdetBCNCollectionItemRet.Create;
  Add(Result);
end;


{ TgBCNRet }

constructor TgBCNRet.Create;
begin
  inherited Create;
  FdetBCN := TdetBCNCollectionRet.Create;
end;

destructor TgBCNRet.Destroy;
begin
  FdetBCN.Free;
  inherited Destroy;
end;

procedure TgBCNRet.SetdetBCN(const Value: TdetBCNCollectionRet);
begin
  FdetBCN := Value;
end;


{ TinfoBCNRet }

constructor TinfoBCNRet.Create;
begin
  inherited Create;
  FgBCNIBS := TgBCNRet.Create;
  FgBCNCBS := TgBCNRet.Create;
end;

destructor TinfoBCNRet.Destroy;
begin
  FgBCNIBS.Free;
  FgBCNCBS.Free;
  inherited Destroy;
end;


{ TdetBCCollectionItemRet }

constructor TdetBCCollectionItemRet.Create;
begin
  inherited Create;
  FgCoeficientes := TgCoeficientesRet.Create;
  FgBCIBS := TgBCIBSRet.Create;
  FgBCCBS := TgBCCBSRet.Create;
  FgBCIS := TgBCISRet.Create;
  FinfoBCN := TinfoBCNRet.Create;
end;

destructor TdetBCCollectionItemRet.Destroy;
begin
  FgCoeficientes.Free;
  FgBCIBS.Free;
  FgBCCBS.Free;
  FgBCIS.Free;
  FinfoBCN.Free;
  inherited Destroy;
end;

{ TdetBCCollectionRet }

function TdetBCCollectionRet.GetItem(Index: Integer): TdetBCCollectionItemRet;
begin
  Result := TdetBCCollectionItemRet(inherited Items[Index]);
end;

procedure TdetBCCollectionRet.SetItem(Index: Integer; Value: TdetBCCollectionItemRet);
begin
  inherited Items[Index] := Value;
end;

function TdetBCCollectionRet.New: TdetBCCollectionItemRet;
begin
  Result := TdetBCCollectionItemRet.Create;
  Add(Result);
end;


{ TtotalTributosRet }


{ TinfoTotMensalRet }

constructor TinfoTotMensalRet.Create;
begin
  inherited Create;
  FdetBC := TdetBCCollectionRet.Create;
  FtotalTributos := TtotalTributosRet.Create;
end;

destructor TinfoTotMensalRet.Destroy;
begin
  FdetBC.Free;
  FtotalTributos.Free;
  inherited Destroy;
end;

procedure TinfoTotMensalRet.SetdetBC(const Value: TdetBCCollectionRet);
begin
  FdetBC := Value;
end;

{ TRetornoEventoCollectionItem }

destructor TRetornoEventoCollectionItem.Destroy;
begin
  FRetorno.Free;
  FRetornoTabela.Free;
  inherited Destroy;
end;

{ TevtRetornoDeRE }

constructor TevtRetornoDeRE.Create;
begin
  inherited Create;
  FSignature := TSignature.Create;
  CriarObjetos;
end;

destructor TevtRetornoDeRE.Destroy;
begin
  LiberarObjetos;
  FSignature.Free;
  inherited Destroy;
end;

procedure TevtRetornoDeRE.CriarObjetos;
begin
  FideStatus := TideStatus.Create;
  FinfoRecEv := TinfoRecEv.Create;
  FidePeriodo := TidePeriodoApur.Create;
  FinfoAdic := TinfoAdicRet.Create;
  FinfoTotBalan := TgTotalCodTribCollectionRet.Create;
  FinfoTotAplicFin := TinfoTotVApurRet.Create;
  FinfoTotTitOfPub := TinfoTotVApurRet.Create;
  FinfoTotFinanceiro := TinfoTotMensalRet.Create;
  FinfoTotSaude := TinfoTotMensalRet.Create;
  FinfoTotProg := TinfoTotMensalRet.Create;
  FtotalTributosGeral := TtotalTributosRet.Create;
end;

procedure TevtRetornoDeRE.LiberarObjetos;
begin
  FideStatus.Free;
  FinfoRecEv.Free;
  FidePeriodo.Free;
  FinfoAdic.Free;
  FinfoTotBalan.Free;
  FinfoTotAplicFin.Free;
  FinfoTotTitOfPub.Free;
  FinfoTotFinanceiro.Free;
  FinfoTotSaude.Free;
  FinfoTotProg.Free;
  FtotalTributosGeral.Free;
end;

procedure TevtRetornoDeRE.Clear;
begin
  LiberarObjetos;
  CriarObjetos;
  FSignature.Clear;
  FTipoRetorno := trtNenhum;
  Fid := '';
  FnrInsc := '';
  FTemInfoEvento := False;
  FTeminfoAdic := False;
  FTeminfoTotBalan := False;
  FTeminfoTotAplicFin := False;
  FTeminfoTotTitOfPub := False;
  FTeminfoTotFinanceiro := False;
  FTeminfoTotSaude := False;
  FTeminfoTotProg := False;
  FTemtotalTributosGeral := False;
end;

{ TOcorrenciaCollection }

function TOcorrenciaCollection.GetItem(Index: Integer): TOcorrenciaCollectionItem;
begin
  Result := TOcorrenciaCollectionItem(inherited Items[Index]);
end;

procedure TOcorrenciaCollection.SetItem(Index: Integer; Value: TOcorrenciaCollectionItem);
begin
  inherited Items[Index] := Value;
end;

function TOcorrenciaCollection.New: TOcorrenciaCollectionItem;
begin
  Result := TOcorrenciaCollectionItem.Create;
  Add(Result);
end;

{ TStatusLote }

constructor TStatusLote.Create;
begin
  inherited Create;
  Focorrencias := TOcorrenciaCollection.Create;
end;

destructor TStatusLote.Destroy;
begin
  Focorrencias.Free;
  inherited Destroy;
end;

procedure TStatusLote.Setocorrencias(const Value: TOcorrenciaCollection);
begin
  Focorrencias := Value;
end;

{ TRetornoEventoCollection }

function TRetornoEventoCollection.GetItem(Index: Integer): TRetornoEventoCollectionItem;
begin
  Result := TRetornoEventoCollectionItem(inherited Items[Index]);
end;

procedure TRetornoEventoCollection.SetItem(Index: Integer; Value: TRetornoEventoCollectionItem);
begin
  inherited Items[Index] := Value;
end;

function TRetornoEventoCollection.New: TRetornoEventoCollectionItem;
begin
  Result := TRetornoEventoCollectionItem.Create;
  Add(Result);
end;

{ TretornoLoteDeRE }

constructor TretornoLoteDeRE.Create;
begin
  inherited Create;
  Fstatus := TStatusLote.Create;
  FdadosRecepcaoLote := TDadosRecepcaoLote.Create;
  FdadosProcessamentoLote := TDadosProcessamentoLote.Create;
  FretornoEventos := TRetornoEventoCollection.Create;
  FSignature := TSignature.Create;
end;

destructor TretornoLoteDeRE.Destroy;
begin
  Fstatus.Free;
  FdadosRecepcaoLote.Free;
  FdadosProcessamentoLote.Free;
  FretornoEventos.Free;
  FSignature.Free;
  inherited Destroy;
end;

procedure TretornoLoteDeRE.Clear;
begin
  Fid := '';
  FnrInsc := '';
  FniTransmissor := '';
  Fstatus.cdResposta := crlNenhum;
  Fstatus.descResposta := '';
  Fstatus.ocorrencias.Clear;
  FdadosRecepcaoLote.TemDados := False;
  FdadosProcessamentoLote.TemDados := False;
  FretornoEventos.Clear;
  FSignature.Clear;
end;

procedure TretornoLoteDeRE.SetretornoEventos(const Value: TRetornoEventoCollection);
begin
  FretornoEventos := Value;
end;

{ TideStatus }

constructor TideStatus.Create;
begin
  inherited Create;
  Focorrencias := TOcorrenciaCollection.Create;
end;

destructor TideStatus.Destroy;
begin
  Focorrencias.Free;
  inherited Destroy;
end;

procedure TideStatus.Setocorrencias(const Value: TOcorrenciaCollection);
begin
  Focorrencias := Value;
end;

{ TinfoEvento }

constructor TinfoEvento.Create;
begin
  inherited Create;
  FidePeriodo := TidePeriodo.Create;
  FTemInfoEvento := False;
end;

destructor TinfoEvento.Destroy;
begin
  FidePeriodo.Free;
  inherited Destroy;
end;

{ TdetEventoCollection }

function TdetEventoCollection.GetItem(Index: Integer): TdetEventoCollectionItem;
begin
  Result := TdetEventoCollectionItem(inherited Items[Index]);
end;

procedure TdetEventoCollection.SetItem(Index: Integer; Value: TdetEventoCollectionItem);
begin
  inherited Items[Index] := Value;
end;

function TdetEventoCollection.New: TdetEventoCollectionItem;
begin
  Result := TdetEventoCollectionItem.Create;
  Add(Result);
end;

{ TdetLacunaCollection }

function TdetLacunaCollection.GetItem(Index: Integer): TdetLacunaCollectionItem;
begin
  Result := TdetLacunaCollectionItem(inherited Items[Index]);
end;

procedure TdetLacunaCollection.SetItem(Index: Integer; Value: TdetLacunaCollectionItem);
begin
  inherited Items[Index] := Value;
end;

function TdetLacunaCollection.New: TdetLacunaCollectionItem;
begin
  Result := TdetLacunaCollectionItem.Create;
  Add(Result);
end;

{ TextratoEventos }

constructor TextratoEventos.Create;
begin
  inherited Create;
  FdetEvento := TdetEventoCollection.Create;
  FdetLacuna := TdetLacunaCollection.Create;
  FTemExtrato := False;
end;

destructor TextratoEventos.Destroy;
begin
  FdetEvento.Free;
  FdetLacuna.Free;
  inherited Destroy;
end;

procedure TextratoEventos.SetdetEvento(const Value: TdetEventoCollection);
begin
  FdetEvento := Value;
end;

procedure TextratoEventos.SetdetLacuna(const Value: TdetLacunaCollection);
begin
  FdetLacuna := Value;
end;

{ TevtRetornoTabela }

constructor TevtRetornoTabela.Create;
begin
  inherited Create;
  FideStatus := TideStatus.Create;
  FinfoRecEv := TinfoRecEv.Create;
  FinfoEvento := TinfoEvento.Create;
  FextratoEventos := TextratoEventos.Create;
  FSignature := TSignature.Create;
end;

destructor TevtRetornoTabela.Destroy;
begin
  FideStatus.Free;
  FinfoRecEv.Free;
  FinfoEvento.Free;
  FextratoEventos.Free;
  FSignature.Free;
  inherited Destroy;
end;

procedure TevtRetornoTabela.Clear;
begin
  Fid := '';
  FnrInsc := '';
  FideStatus.cdRetorno := cretNenhum;
  FideStatus.descRetorno := dretNenhum;
  FideStatus.ocorrencias.Clear;
  FinfoEvento.TemInfoEvento := False;
  FextratoEventos.TemExtrato := False;
  FextratoEventos.detEvento.Clear;
  FextratoEventos.detLacuna.Clear;
  FSignature.Clear;
end;

end.
