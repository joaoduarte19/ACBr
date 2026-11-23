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

unit ACBrLibDeRERespostas;

interface

uses
  Classes, SysUtils, StrUtils,
  ACBrUtil.Base, ACBrUtil.Strings,
  ACBrDeRE, ACBrDeRE.Conversao, ACBrDeRE.Classes, ACBrDeRE.Classes.Retorno,
  ACBrLibResposta, ACBrLibConfig, ACBrLibDeREConsts;

type

  { TDeREEnvioResposta - protocolo gerado no envio do lote }

  TDeREEnvioResposta = class(TACBrLibRespostaBase)
  private
    FProtocolo: String;
    FQtdEventos: Integer;
  public
    constructor Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
      const AFormato: TACBrLibCodificacao); reintroduce;

    procedure Processar(const A: TACBrDeRE);
  published
    property Protocolo: String read FProtocolo write FProtocolo;
    property QtdEventos: Integer read FQtdEventos write FQtdEventos;
  end;

  { TDeRETokenResposta - token de acesso obtido }

  TDeRETokenResposta = class(TACBrLibRespostaBase)
  private
    FToken: String;
    FTokenExpira: TDateTime;
    FRetornoJson: String;
    FHttpCodigo: Integer;
    FMensagemErro: String;
  public
    constructor Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
      const AFormato: TACBrLibCodificacao); reintroduce;

    procedure Processar(const A: TACBrDeRE);
  published
    property Token: String read FToken write FToken;
    property TokenExpira: TDateTime read FTokenExpira write FTokenExpira;
    property RetornoJson: String read FRetornoJson write FRetornoJson;
    property HttpCodigo: Integer read FHttpCodigo write FHttpCodigo;
    property MensagemErro: String read FMensagemErro write FMensagemErro;
  end;

  { TDeRELimpezaResposta - limpeza dos dados do contribuinte (Producao Restrita) }

  TDeRELimpezaResposta = class(TACBrLibRespostaBase)
  private
    FnrInsc: String;
    FHttpCodigo: Integer;
    FMensagem: String;
    FRetorno: String;
  public
    constructor Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
      const AFormato: TACBrLibCodificacao); reintroduce;

    procedure Processar(const A: TACBrDeRE);
  published
    property nrInsc: String read FnrInsc write FnrInsc;
    property HttpCodigo: Integer read FHttpCodigo write FHttpCodigo;
    property Mensagem: String read FMensagem write FMensagem;
    property Retorno: String read FRetorno write FRetorno;
  end;

  { TDeRELoteResposta - retornoLoteEventos }

  TDeRELoteResposta = class(TACBrLibRespostaBase)
  private
    Fid: String;
    FnrInsc: String;
    FniTransmissor: String;
    FcdResposta: Integer;
    FdescResposta: String;
    Fprotocolo: String;
    FdhRecepcao: TDateTime;
    FversaoAplicativoRecepcao: String;
    FdhProcessamento: TDateTime;
    FversaoAplicativoProcessamento: String;
    FqtdEventos: Integer;
  public
    constructor Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
      const AFormato: TACBrLibCodificacao); reintroduce;

    procedure Processar(const A: TretornoLoteDeRE);
  published
    property id: String read Fid write Fid;
    property nrInsc: String read FnrInsc write FnrInsc;
    property niTransmissor: String read FniTransmissor write FniTransmissor;
    property cdResposta: Integer read FcdResposta write FcdResposta;
    property descResposta: String read FdescResposta write FdescResposta;
    property protocolo: String read Fprotocolo write Fprotocolo;
    property dhRecepcao: TDateTime read FdhRecepcao write FdhRecepcao;
    property versaoAplicativoRecepcao: String read FversaoAplicativoRecepcao write FversaoAplicativoRecepcao;
    property dhProcessamento: TDateTime read FdhProcessamento write FdhProcessamento;
    property versaoAplicativoProcessamento: String read FversaoAplicativoProcessamento write FversaoAplicativoProcessamento;
    property qtdEventos: Integer read FqtdEventos write FqtdEventos;
  end;

  { TDeREOcorrenciaResposta - ocorrencia }

  TDeREOcorrenciaResposta = class(TACBrLibRespostaBase)
  private
    Ftipo: Integer;
    Fcodigo: String;
    Fdescricao: String;
    Flocalizacao: String;
  public
    constructor Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
      const AFormato: TACBrLibCodificacao); reintroduce;

    procedure Processar(const A: TOcorrenciaCollectionItem);
  published
    property tipo: Integer read Ftipo write Ftipo;
    property codigo: String read Fcodigo write Fcodigo;
    property descricao: String read Fdescricao write Fdescricao;
    property localizacao: String read Flocalizacao write Flocalizacao;
  end;

  { TDeREEventoResposta - evento de retorno contido no lote }

  TDeREEventoResposta = class(TACBrLibRespostaBase)
  private
    Fid: String;
    FtipoRetorno: String;
  public
    constructor Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
      const AFormato: TACBrLibCodificacao); reintroduce;

    procedure Processar(const A: TRetornoEventoCollectionItem);
  published
    property id: String read Fid write Fid;
    property tipoRetorno: String read FtipoRetorno write FtipoRetorno;
  end;

  { TDeREIdeStatusResposta - ideStatus }

  TDeREIdeStatusResposta = class(TACBrLibRespostaBase)
  private
    FcdRetorno: Integer;
    FdescRetorno: String;
  public
    constructor Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
      const AFormato: TACBrLibCodificacao); reintroduce;

    procedure Processar(const A: TideStatus);
  published
    property cdRetorno: Integer read FcdRetorno write FcdRetorno;
    property descRetorno: String read FdescRetorno write FdescRetorno;
  end;

  { TDeREInfoRecEvResposta - infoRecEv }

  TDeREInfoRecEvResposta = class(TACBrLibRespostaBase)
  private
    FnrRecibo: String;
    FseqEvento: String;
    FprotocoloLote: String;
    FdhRecepcao: TDateTime;
    FdhProcess: TDateTime;
    FtpEv: String;
    Fhash: String;
  public
    constructor Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
      const AFormato: TACBrLibCodificacao); reintroduce;

    procedure Processar(const A: TinfoRecEv);
  published
    property nrRecibo: String read FnrRecibo write FnrRecibo;
    property seqEvento: String read FseqEvento write FseqEvento;
    property protocoloLote: String read FprotocoloLote write FprotocoloLote;
    property dhRecepcao: TDateTime read FdhRecepcao write FdhRecepcao;
    property dhProcess: TDateTime read FdhProcess write FdhProcess;
    property tpEv: String read FtpEv write FtpEv;
    property hash: String read Fhash write Fhash;
  end;

  { TDeREIdePeriodoApurResposta - idePeriodo (perApur) }

  TDeREIdePeriodoApurResposta = class(TACBrLibRespostaBase)
  private
    FperApur: String;
  public
    constructor Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
      const AFormato: TACBrLibCodificacao); reintroduce;

    procedure Processar(const A: TidePeriodoApur);
  published
    property perApur: String read FperApur write FperApur;
  end;

  { TDeREIdePeriodoResposta - idePeriodo (vigencia) do retorno de tabela }

  TDeREIdePeriodoResposta = class(TACBrLibRespostaBase)
  private
    FiniValid: TDateTime;
    FfimValid: TDateTime;
  public
    constructor Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
      const AFormato: TACBrLibCodificacao); reintroduce;

    procedure Processar(const A: TidePeriodo);
  published
    property iniValid: TDateTime read FiniValid write FiniValid;
    property fimValid: TDateTime read FfimValid write FfimValid;
  end;

  { TDeREInfoAdicResposta - infoAdic }

  TDeREInfoAdicResposta = class(TACBrLibRespostaBase)
  private
    FnrReciboPGCC: String;
    FnrReciboBalancete: String;
    FnrReciboAplicFin: String;
    FnrReciboOperTitPub: String;
    FnrReciboRelDedu: String;
  public
    constructor Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
      const AFormato: TACBrLibCodificacao); reintroduce;

    procedure Processar(const A: TinfoAdicRet);
  published
    property nrReciboPGCC: String read FnrReciboPGCC write FnrReciboPGCC;
    property nrReciboBalancete: String read FnrReciboBalancete write FnrReciboBalancete;
    property nrReciboAplicFin: String read FnrReciboAplicFin write FnrReciboAplicFin;
    property nrReciboOperTitPub: String read FnrReciboOperTitPub write FnrReciboOperTitPub;
    property nrReciboRelDedu: String read FnrReciboRelDedu write FnrReciboRelDedu;
  end;

  { TDeRETotCodTribResposta - gTotalCodTrib }

  TDeRETotCodTribResposta = class(TACBrLibRespostaBase)
  private
    FcodTrib: Integer;
    FindTribISS: Integer;
    FvApurTot: Double;
    FvTotSaldoInic: Double;
    FvTotSaldoFinal: Double;
  public
    constructor Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
      const AFormato: TACBrLibCodificacao); reintroduce;

    procedure Processar(const A: TgTotalCodTribCollectionItemRet);
  published
    property codTrib: Integer read FcodTrib write FcodTrib;
    property indTribISS: Integer read FindTribISS write FindTribISS;
    property vApurTot: Double read FvApurTot write FvApurTot;
    property vTotSaldoInic: Double read FvTotSaldoInic write FvTotSaldoInic;
    property vTotSaldoFinal: Double read FvTotSaldoFinal write FvTotSaldoFinal;
  end;

  { TDeRETotVApurResposta - infoTotAplicFin / infoTotTitOfPub }

  TDeRETotVApurResposta = class(TACBrLibRespostaBase)
  private
    FvApurTot: Double;
  public
    constructor Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
      const AFormato: TACBrLibCodificacao); reintroduce;

    procedure Processar(const A: TinfoTotVApurRet);
  published
    property vApurTot: Double read FvApurTot write FvApurTot;
  end;

  { TDeREDetBCResposta - detBC }

  TDeREDetBCResposta = class(TACBrLibRespostaBase)
  private
    FcodBC: String;
    FxDetBC: String;
    FmemoriaCalculo: String;
  public
    constructor Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
      const AFormato: TACBrLibCodificacao); reintroduce;

    procedure Processar(const A: TdetBCCollectionItemRet);
  published
    property codBC: String read FcodBC write FcodBC;
    property xDetBC: String read FxDetBC write FxDetBC;
    property memoriaCalculo: String read FmemoriaCalculo write FmemoriaCalculo;
  end;

  { TDeRECoeficientesResposta - gCoeficientes }

  TDeRECoeficientesResposta = class(TACBrLibRespostaBase)
  private
    FpRateioDespCapt: Double;
    FpRevDedAtoCoop: Double;
    FpExportIaV: Double;
    FpExportVI: Double;
    FpExportIX: Double;
    FpExportXI: Double;
    FpExportXIII: Double;
    FpExportXIV: Double;
    FpExportProg: Double;
  public
    constructor Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
      const AFormato: TACBrLibCodificacao); reintroduce;

    procedure Processar(const A: TgCoeficientesRet);
  published
    property pRateioDespCapt: Double read FpRateioDespCapt write FpRateioDespCapt;
    property pRevDedAtoCoop: Double read FpRevDedAtoCoop write FpRevDedAtoCoop;
    property pExportIaV: Double read FpExportIaV write FpExportIaV;
    property pExportVI: Double read FpExportVI write FpExportVI;
    property pExportIX: Double read FpExportIX write FpExportIX;
    property pExportXI: Double read FpExportXI write FpExportXI;
    property pExportXIII: Double read FpExportXIII write FpExportXIII;
    property pExportXIV: Double read FpExportXIV write FpExportXIV;
    property pExportProg: Double read FpExportProg write FpExportProg;
  end;

  { TDeREBCIBSResposta - gBCIBS }

  TDeREBCIBSResposta = class(TACBrLibRespostaBase)
  private
    FvBCIBS: Double;
    FvBCNIBS: Double;
    FvDedBCN: Double;
    FvBCApurIBS: Double;
    FpIBSMun: Double;
    FvIBSMun: Double;
    FpIBSUF: Double;
    FvIBSUF: Double;
    FpIBS: Double;
    FvIBSTot: Double;
  public
    constructor Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
      const AFormato: TACBrLibCodificacao); reintroduce;

    procedure Processar(const A: TgBCIBSRet);
  published
    property vBCIBS: Double read FvBCIBS write FvBCIBS;
    property vBCNIBS: Double read FvBCNIBS write FvBCNIBS;
    property vDedBCN: Double read FvDedBCN write FvDedBCN;
    property vBCApurIBS: Double read FvBCApurIBS write FvBCApurIBS;
    property pIBSMun: Double read FpIBSMun write FpIBSMun;
    property vIBSMun: Double read FvIBSMun write FvIBSMun;
    property pIBSUF: Double read FpIBSUF write FpIBSUF;
    property vIBSUF: Double read FvIBSUF write FvIBSUF;
    property pIBS: Double read FpIBS write FpIBS;
    property vIBSTot: Double read FvIBSTot write FvIBSTot;
  end;

  { TDeREBCCBSResposta - gBCCBS }

  TDeREBCCBSResposta = class(TACBrLibRespostaBase)
  private
    FvBCCBS: Double;
    FvBCNCBS: Double;
    FvDedBCN: Double;
    FvBCApurCBS: Double;
    FpCBS: Double;
    FvCBS: Double;
  public
    constructor Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
      const AFormato: TACBrLibCodificacao); reintroduce;

    procedure Processar(const A: TgBCCBSRet);
  published
    property vBCCBS: Double read FvBCCBS write FvBCCBS;
    property vBCNCBS: Double read FvBCNCBS write FvBCNCBS;
    property vDedBCN: Double read FvDedBCN write FvDedBCN;
    property vBCApurCBS: Double read FvBCApurCBS write FvBCApurCBS;
    property pCBS: Double read FpCBS write FpCBS;
    property vCBS: Double read FvCBS write FvCBS;
  end;

  { TDeREBCISResposta - gBCIS }

  TDeREBCISResposta = class(TACBrLibRespostaBase)
  private
    FvBCIS: Double;
    FvBCApurIS: Double;
    FpIS: Double;
    FvIS: Double;
  public
    constructor Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
      const AFormato: TACBrLibCodificacao); reintroduce;

    procedure Processar(const A: TgBCISRet);
  published
    property vBCIS: Double read FvBCIS write FvBCIS;
    property vBCApurIS: Double read FvBCApurIS write FvBCApurIS;
    property pIS: Double read FpIS write FpIS;
    property vIS: Double read FvIS write FvIS;
  end;

  { TDeREBCNResposta - gBCNIBS / gBCNCBS }

  TDeREBCNResposta = class(TACBrLibRespostaBase)
  private
    FcodBCNRaiz: String;
    FvSaldoAnt: Double;
    FvUtilPer: Double;
    FvSaldoFinal: Double;
    FqtdOrigens: Integer;
  public
    constructor Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
      const AFormato: TACBrLibCodificacao); reintroduce;

    procedure Processar(const A: TgBCNRet);
  published
    property codBCNRaiz: String read FcodBCNRaiz write FcodBCNRaiz;
    property vSaldoAnt: Double read FvSaldoAnt write FvSaldoAnt;
    property vUtilPer: Double read FvUtilPer write FvUtilPer;
    property vSaldoFinal: Double read FvSaldoFinal write FvSaldoFinal;
    property qtdOrigens: Integer read FqtdOrigens write FqtdOrigens;
  end;

  { TDeREDetBCNResposta - detBCN }

  TDeREDetBCNResposta = class(TACBrLibRespostaBase)
  private
    FcodBCN: String;
    FperOrigem: String;
    FvOrigemIni: Double;
    FvSaldoAnt: Double;
    FvUtilPer: Double;
    FvSaldoFinal: Double;
  public
    constructor Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
      const AFormato: TACBrLibCodificacao); reintroduce;

    procedure Processar(const A: TdetBCNCollectionItemRet);
  published
    property codBCN: String read FcodBCN write FcodBCN;
    property perOrigem: String read FperOrigem write FperOrigem;
    property vOrigemIni: Double read FvOrigemIni write FvOrigemIni;
    property vSaldoAnt: Double read FvSaldoAnt write FvSaldoAnt;
    property vUtilPer: Double read FvUtilPer write FvUtilPer;
    property vSaldoFinal: Double read FvSaldoFinal write FvSaldoFinal;
  end;

  { TDeRETotalTributosResposta - totalTributos }

  TDeRETotalTributosResposta = class(TACBrLibRespostaBase)
  private
    FvIS: Double;
    FvIBSMun: Double;
    FvIBSUF: Double;
    FvIBSTot: Double;
    FvCBS: Double;
  public
    constructor Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
      const AFormato: TACBrLibCodificacao); reintroduce;

    procedure Processar(const A: TtotalTributosRet);
  published
    property vIS: Double read FvIS write FvIS;
    property vIBSMun: Double read FvIBSMun write FvIBSMun;
    property vIBSUF: Double read FvIBSUF write FvIBSUF;
    property vIBSTot: Double read FvIBSTot write FvIBSTot;
    property vCBS: Double read FvCBS write FvCBS;
  end;

  { TDeREDetEventoResposta - extratoEventos/detEvento }

  TDeREDetEventoResposta = class(TACBrLibRespostaBase)
  private
    FnrRecibo: String;
    FiniValid: TDateTime;
    FfimValid: TDateTime;
    FfimValidEfetiva: TDateTime;
    FindAjusteAuto: Integer;
  public
    constructor Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
      const AFormato: TACBrLibCodificacao); reintroduce;

    procedure Processar(const A: TdetEventoCollectionItem);
  published
    property nrRecibo: String read FnrRecibo write FnrRecibo;
    property iniValid: TDateTime read FiniValid write FiniValid;
    property fimValid: TDateTime read FfimValid write FfimValid;
    property fimValidEfetiva: TDateTime read FfimValidEfetiva write FfimValidEfetiva;
    property indAjusteAuto: Integer read FindAjusteAuto write FindAjusteAuto;
  end;

  { TDeREDetLacunaResposta - extratoEventos/detLacuna }

  TDeREDetLacunaResposta = class(TACBrLibRespostaBase)
  private
    FiniLacuna: TDateTime;
    FfimLacuna: TDateTime;
  public
    constructor Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
      const AFormato: TACBrLibCodificacao); reintroduce;

    procedure Processar(const A: TdetLacunaCollectionItem);
  published
    property iniLacuna: TDateTime read FiniLacuna write FiniLacuna;
    property fimLacuna: TDateTime read FfimLacuna write FfimLacuna;
  end;

  { TRespostas - monta a resposta completa (envio / consulta do lote e eventos de retorno) }

  TRespostas = class
  private
    FACBrDeRE: TACBrDeRE;
    FTpResp: TACBrLibRespostaTipo;
    FFormato: TACBrLibCodificacao;
    FResposta: AnsiString;

    procedure AdicionarResposta(const AResp: TACBrLibRespostaBase);

    procedure RespostaLoteRetorno(const ALote: TretornoLoteDeRE);
    procedure RespostaOcorrencias(const ANome, ASeqEvento: String; const ALista: TOcorrenciaCollection);
    procedure RespostaIdeStatus(const ASeqEvento: String; const AItem: TideStatus);
    procedure RespostaInfoRecEv(const ASeqEvento: String; const AItem: TinfoRecEv);
    procedure RespostaTotalTributos(const ANome, ASeq: String; const AItem: TtotalTributosRet);
    procedure RespostaInfoTotMensal(const AGrupo, ASeqEvento: String; const AItem: TinfoTotMensalRet);
    procedure RespostaBCN(const ANome, ASeq: String; const AItem: TgBCNRet);
    procedure RespostaRetornoDeRE(const ASeqEvento: String; const AItem: TevtRetornoDeRE);
    procedure RespostaRetornoTabela(const ASeqEvento: String; const AItem: TevtRetornoTabela);
    procedure RespostaRetornoEvento(const ACont: Integer; const AItem: TRetornoEventoCollectionItem);
  public
    constructor Create(const AACBrDeRE: TACBrDeRE; const ATipo: TACBrLibRespostaTipo;
      const AFormato: TACBrLibCodificacao);

    procedure RespostaEnvio;
    procedure RespostaConsulta;
    procedure RespostaToken;
    procedure RespostaLimpeza;

    property Resposta: AnsiString read FResposta write FResposta;
    property TpResp: TACBrLibRespostaTipo read FTpResp;
    property Formato: TACBrLibCodificacao read FFormato;
  end;

implementation

// Sequencia de 3 digitos (base 1) usada no nome das sessoes: NomeDaSessao + Sequencia.
// Sessoes dentro de um evento levam a sequencia do evento; quando forem lista
// (ocorrencias, gTotalCodTrib, detBC...) levam tambem a sequencia do item.
function SeqResp(const AIndice: Integer): String;
begin
  Result := IntToStrZero(Int64(AIndice + 1), 3);
end;

{ TDeREEnvioResposta }

constructor TDeREEnvioResposta.Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
  const AFormato: TACBrLibCodificacao);
begin
  inherited Create(ASessao, ATipo, AFormato);
end;

procedure TDeREEnvioResposta.Processar(const A: TACBrDeRE);
begin
  FProtocolo := A.WebServices.EnvioLote.Protocolo;
  FQtdEventos := A.Eventos.Gerados.Count;
end;

{ TDeRETokenResposta }

constructor TDeRETokenResposta.Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
  const AFormato: TACBrLibCodificacao);
begin
  inherited Create(ASessao, ATipo, AFormato);
end;

procedure TDeRETokenResposta.Processar(const A: TACBrDeRE);
begin
  FToken := A.WebServices.Token;
  FTokenExpira := A.WebServices.TokenExpira;
  FRetornoJson := A.WebServices.ObterToken.RetornoToken;
  FHttpCodigo := A.WebServices.ObterToken.HttpCodigo;
  FMensagemErro := A.WebServices.ObterToken.Msg;
end;

{ TDeRELimpezaResposta }

constructor TDeRELimpezaResposta.Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
  const AFormato: TACBrLibCodificacao);
begin
  inherited Create(ASessao, ATipo, AFormato);
end;

procedure TDeRELimpezaResposta.Processar(const A: TACBrDeRE);
begin
  FnrInsc := A.WebServices.LimpezaDados.nrInsc;
  FHttpCodigo := A.WebServices.LimpezaDados.HttpCodigo;
  FMensagem := A.WebServices.LimpezaDados.Msg;
  FRetorno := A.WebServices.LimpezaDados.RetWS;
end;

{ TDeRELoteResposta }

constructor TDeRELoteResposta.Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
  const AFormato: TACBrLibCodificacao);
begin
  inherited Create(ASessao, ATipo, AFormato);
end;

procedure TDeRELoteResposta.Processar(const A: TretornoLoteDeRE);
begin
  Fid := A.id;
  FnrInsc := A.nrInsc;
  FniTransmissor := A.niTransmissor;
  FcdResposta := StrToIntDef(cdRespostaLoteDeREToStr(A.status.cdResposta), 0);
  FdescResposta := A.status.descResposta;
  Fprotocolo := A.dadosRecepcaoLote.protocolo;
  FdhRecepcao := A.dadosRecepcaoLote.dhRecepcao;
  FversaoAplicativoRecepcao := A.dadosRecepcaoLote.versaoAplicativoRecepcao;
  FdhProcessamento := A.dadosProcessamentoLote.dhProcessamento;
  FversaoAplicativoProcessamento := A.dadosProcessamentoLote.versaoAplicativoProcessamento;
  FqtdEventos := A.retornoEventos.Count;
end;

{ TDeREOcorrenciaResposta }

constructor TDeREOcorrenciaResposta.Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
  const AFormato: TACBrLibCodificacao);
begin
  inherited Create(ASessao, ATipo, AFormato);
end;

procedure TDeREOcorrenciaResposta.Processar(const A: TOcorrenciaCollectionItem);
begin
  Ftipo := StrToIntDef(tipoOcorrenciaDeREToStr(A.tipo), 0);
  Fcodigo := A.codigo;
  Fdescricao := A.descricao;
  Flocalizacao := A.localizacao;
end;

{ TDeREEventoResposta }

constructor TDeREEventoResposta.Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
  const AFormato: TACBrLibCodificacao);
begin
  inherited Create(ASessao, ATipo, AFormato);
end;

procedure TDeREEventoResposta.Processar(const A: TRetornoEventoCollectionItem);
begin
  Fid := A.id;
  FtipoRetorno := tipoRetornoDeREToStr(A.TipoRetorno);
end;

{ TDeREIdeStatusResposta }

constructor TDeREIdeStatusResposta.Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
  const AFormato: TACBrLibCodificacao);
begin
  inherited Create(ASessao, ATipo, AFormato);
end;

procedure TDeREIdeStatusResposta.Processar(const A: TideStatus);
begin
  FcdRetorno := StrToIntDef(cdRetornoDeREToStr(A.cdRetorno), 0);
  FdescRetorno := descRetornoDeREToStr(A.descRetorno);
end;

{ TDeREInfoRecEvResposta }

constructor TDeREInfoRecEvResposta.Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
  const AFormato: TACBrLibCodificacao);
begin
  inherited Create(ASessao, ATipo, AFormato);
end;

procedure TDeREInfoRecEvResposta.Processar(const A: TinfoRecEv);
begin
  FnrRecibo := A.nrRecibo;
  FseqEvento := A.seqEvento;
  FprotocoloLote := A.protocoloLote;
  FdhRecepcao := A.dhRecepcao;
  FdhProcess := A.dhProcess;
  FtpEv := A.tpEvStr;
  Fhash := A.hash;
end;

{ TDeREIdePeriodoApurResposta }

constructor TDeREIdePeriodoApurResposta.Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
  const AFormato: TACBrLibCodificacao);
begin
  inherited Create(ASessao, ATipo, AFormato);
end;

procedure TDeREIdePeriodoApurResposta.Processar(const A: TidePeriodoApur);
begin
  FperApur := A.perApur;
end;

{ TDeREIdePeriodoResposta }

constructor TDeREIdePeriodoResposta.Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
  const AFormato: TACBrLibCodificacao);
begin
  inherited Create(ASessao, ATipo, AFormato);
end;

procedure TDeREIdePeriodoResposta.Processar(const A: TidePeriodo);
begin
  FiniValid := A.iniValid;
  FfimValid := A.fimValid;
end;

{ TDeREInfoAdicResposta }

constructor TDeREInfoAdicResposta.Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
  const AFormato: TACBrLibCodificacao);
begin
  inherited Create(ASessao, ATipo, AFormato);
end;

procedure TDeREInfoAdicResposta.Processar(const A: TinfoAdicRet);
begin
  FnrReciboPGCC := A.nrReciboPGCC;
  FnrReciboBalancete := A.nrReciboBalancete;
  FnrReciboAplicFin := A.nrReciboAplicFin;
  FnrReciboOperTitPub := A.nrReciboOperTitPub;
  FnrReciboRelDedu := StringReplace(Trim(A.nrReciboRelDedu.Text), sLineBreak, '|', [rfReplaceAll]);
end;

{ TDeRETotCodTribResposta }

constructor TDeRETotCodTribResposta.Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
  const AFormato: TACBrLibCodificacao);
begin
  inherited Create(ASessao, ATipo, AFormato);
end;

procedure TDeRETotCodTribResposta.Processar(const A: TgTotalCodTribCollectionItemRet);
begin
  FcodTrib := A.codTrib;
  FindTribISS := Ord(A.indTribISS);
  FvApurTot := A.vApurTot;
  FvTotSaldoInic := A.vTotSaldoInic;
  FvTotSaldoFinal := A.vTotSaldoFinal;
end;

{ TDeRETotVApurResposta }

constructor TDeRETotVApurResposta.Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
  const AFormato: TACBrLibCodificacao);
begin
  inherited Create(ASessao, ATipo, AFormato);
end;

procedure TDeRETotVApurResposta.Processar(const A: TinfoTotVApurRet);
begin
  FvApurTot := A.vApurTot;
end;

{ TDeREDetBCResposta }

constructor TDeREDetBCResposta.Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
  const AFormato: TACBrLibCodificacao);
begin
  inherited Create(ASessao, ATipo, AFormato);
end;

procedure TDeREDetBCResposta.Processar(const A: TdetBCCollectionItemRet);
begin
  FcodBC := A.codBC;
  FxDetBC := A.xDetBC;
  FmemoriaCalculo := A.memoriaCalculo;
end;

{ TDeRECoeficientesResposta }

constructor TDeRECoeficientesResposta.Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
  const AFormato: TACBrLibCodificacao);
begin
  inherited Create(ASessao, ATipo, AFormato);
end;

procedure TDeRECoeficientesResposta.Processar(const A: TgCoeficientesRet);
begin
  FpRateioDespCapt := A.pRateioDespCapt;
  FpRevDedAtoCoop := A.pRevDedAtoCoop;
  FpExportIaV := A.pExportIaV;
  FpExportVI := A.pExportVI;
  FpExportIX := A.pExportIX;
  FpExportXI := A.pExportXI;
  FpExportXIII := A.pExportXIII;
  FpExportXIV := A.pExportXIV;
  FpExportProg := A.pExportProg;
end;

{ TDeREBCIBSResposta }

constructor TDeREBCIBSResposta.Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
  const AFormato: TACBrLibCodificacao);
begin
  inherited Create(ASessao, ATipo, AFormato);
end;

procedure TDeREBCIBSResposta.Processar(const A: TgBCIBSRet);
begin
  FvBCIBS := A.vBCIBS;
  FvBCNIBS := A.vBCNIBS;
  FvDedBCN := A.vDedBCN;
  FvBCApurIBS := A.vBCApurIBS;
  FpIBSMun := A.pIBSMun;
  FvIBSMun := A.vIBSMun;
  FpIBSUF := A.pIBSUF;
  FvIBSUF := A.vIBSUF;
  FpIBS := A.pIBS;
  FvIBSTot := A.vIBSTot;
end;

{ TDeREBCCBSResposta }

constructor TDeREBCCBSResposta.Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
  const AFormato: TACBrLibCodificacao);
begin
  inherited Create(ASessao, ATipo, AFormato);
end;

procedure TDeREBCCBSResposta.Processar(const A: TgBCCBSRet);
begin
  FvBCCBS := A.vBCCBS;
  FvBCNCBS := A.vBCNCBS;
  FvDedBCN := A.vDedBCN;
  FvBCApurCBS := A.vBCApurCBS;
  FpCBS := A.pCBS;
  FvCBS := A.vCBS;
end;

{ TDeREBCISResposta }

constructor TDeREBCISResposta.Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
  const AFormato: TACBrLibCodificacao);
begin
  inherited Create(ASessao, ATipo, AFormato);
end;

procedure TDeREBCISResposta.Processar(const A: TgBCISRet);
begin
  FvBCIS := A.vBCIS;
  FvBCApurIS := A.vBCApurIS;
  FpIS := A.pIS;
  FvIS := A.vIS;
end;

{ TDeREBCNResposta }

constructor TDeREBCNResposta.Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
  const AFormato: TACBrLibCodificacao);
begin
  inherited Create(ASessao, ATipo, AFormato);
end;

procedure TDeREBCNResposta.Processar(const A: TgBCNRet);
begin
  FcodBCNRaiz := A.codBCNRaiz;
  FvSaldoAnt := A.vSaldoAnt;
  FvUtilPer := A.vUtilPer;
  FvSaldoFinal := A.vSaldoFinal;
  FqtdOrigens := A.qtdOrigens;
end;

{ TDeREDetBCNResposta }

constructor TDeREDetBCNResposta.Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
  const AFormato: TACBrLibCodificacao);
begin
  inherited Create(ASessao, ATipo, AFormato);
end;

procedure TDeREDetBCNResposta.Processar(const A: TdetBCNCollectionItemRet);
begin
  FcodBCN := A.codBCN;
  FperOrigem := A.perOrigem;
  FvOrigemIni := A.vOrigemIni;
  FvSaldoAnt := A.vSaldoAnt;
  FvUtilPer := A.vUtilPer;
  FvSaldoFinal := A.vSaldoFinal;
end;

{ TDeRETotalTributosResposta }

constructor TDeRETotalTributosResposta.Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
  const AFormato: TACBrLibCodificacao);
begin
  inherited Create(ASessao, ATipo, AFormato);
end;

procedure TDeRETotalTributosResposta.Processar(const A: TtotalTributosRet);
begin
  FvIS := A.vIS;
  FvIBSMun := A.vIBSMun;
  FvIBSUF := A.vIBSUF;
  FvIBSTot := A.vIBSTot;
  FvCBS := A.vCBS;
end;

{ TDeREDetEventoResposta }

constructor TDeREDetEventoResposta.Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
  const AFormato: TACBrLibCodificacao);
begin
  inherited Create(ASessao, ATipo, AFormato);
end;

procedure TDeREDetEventoResposta.Processar(const A: TdetEventoCollectionItem);
begin
  FnrRecibo := A.nrRecibo;
  FiniValid := A.iniValid;
  FfimValid := A.fimValid;
  FfimValidEfetiva := A.fimValidEfetiva;
  FindAjusteAuto := Ord(A.indAjusteAuto);
end;

{ TDeREDetLacunaResposta }

constructor TDeREDetLacunaResposta.Create(const ASessao: String; const ATipo: TACBrLibRespostaTipo;
  const AFormato: TACBrLibCodificacao);
begin
  inherited Create(ASessao, ATipo, AFormato);
end;

procedure TDeREDetLacunaResposta.Processar(const A: TdetLacunaCollectionItem);
begin
  FiniLacuna := A.iniLacuna;
  FfimLacuna := A.fimLacuna;
end;

{ TRespostas }

constructor TRespostas.Create(const AACBrDeRE: TACBrDeRE; const ATipo: TACBrLibRespostaTipo;
  const AFormato: TACBrLibCodificacao);
begin
  inherited Create;

  FACBrDeRE := AACBrDeRE;
  FTpResp := ATipo;
  FFormato := AFormato;
  FResposta := '';
end;

procedure TRespostas.AdicionarResposta(const AResp: TACBrLibRespostaBase);
begin
  try
    FResposta := FResposta + AResp.Gerar;
  finally
    AResp.Free;
  end;
end;

procedure TRespostas.RespostaEnvio;
var
  Resp: TDeREEnvioResposta;
begin
  Resp := TDeREEnvioResposta.Create(CSessaoRespEnvioLote, FTpResp, FFormato);
  Resp.Processar(FACBrDeRE);
  AdicionarResposta(Resp);
end;

procedure TRespostas.RespostaToken;
var
  Resp: TDeRETokenResposta;
begin
  Resp := TDeRETokenResposta.Create(CSessaoRespToken, FTpResp, FFormato);
  Resp.Processar(FACBrDeRE);
  AdicionarResposta(Resp);
end;

procedure TRespostas.RespostaLimpeza;
var
  Resp: TDeRELimpezaResposta;
begin
  Resp := TDeRELimpezaResposta.Create(CSessaoRespLimpeza, FTpResp, FFormato);
  Resp.Processar(FACBrDeRE);
  AdicionarResposta(Resp);
end;

procedure TRespostas.RespostaConsulta;
begin
  RespostaLoteRetorno(FACBrDeRE.WebServices.ConsultaLote.RetornoLote);
end;

procedure TRespostas.RespostaLoteRetorno(const ALote: TretornoLoteDeRE);
var
  Resp: TDeRELoteResposta;
  i: Integer;
begin
  Resp := TDeRELoteResposta.Create(CSessaoRespRetornoLote, FTpResp, FFormato);
  Resp.Processar(ALote);
  AdicionarResposta(Resp);

  // ocorrencias do lote: ocorrencias001, ocorrencias002...
  RespostaOcorrencias(CSessaoRespOcorrencias, '', ALote.status.ocorrencias);

  for i := 0 to ALote.retornoEventos.Count - 1 do
    RespostaRetornoEvento(i, ALote.retornoEventos.Items[i]);
end;

// Sessao = ANome + sequencia do evento (vazia no nivel do lote) + sequencia da ocorrencia
// Ex.: ocorrencias001 (lote) e ocorrencias001001 (evento 001, ocorrencia 001)
procedure TRespostas.RespostaOcorrencias(const ANome, ASeqEvento: String; const ALista: TOcorrenciaCollection);
var
  Resp: TDeREOcorrenciaResposta;
  i: Integer;
begin
  for i := 0 to ALista.Count - 1 do
  begin
    Resp := TDeREOcorrenciaResposta.Create(ANome + ASeqEvento + SeqResp(i), FTpResp, FFormato);
    Resp.Processar(ALista.Items[i]);
    AdicionarResposta(Resp);
  end;
end;

procedure TRespostas.RespostaIdeStatus(const ASeqEvento: String; const AItem: TideStatus);
var
  Resp: TDeREIdeStatusResposta;
begin
  Resp := TDeREIdeStatusResposta.Create(CSessaoRespideStatus + ASeqEvento, FTpResp, FFormato);
  Resp.Processar(AItem);
  AdicionarResposta(Resp);

  RespostaOcorrencias(CSessaoRespOcorrencias, ASeqEvento, AItem.ocorrencias);
end;

procedure TRespostas.RespostaInfoRecEv(const ASeqEvento: String; const AItem: TinfoRecEv);
var
  Resp: TDeREInfoRecEvResposta;
begin
  Resp := TDeREInfoRecEvResposta.Create(CSessaoRespinfoRecEv + ASeqEvento, FTpResp, FFormato);
  Resp.Processar(AItem);
  AdicionarResposta(Resp);
end;

procedure TRespostas.RespostaTotalTributos(const ANome, ASeq: String; const AItem: TtotalTributosRet);
var
  Resp: TDeRETotalTributosResposta;
begin
  Resp := TDeRETotalTributosResposta.Create(ANome + ASeq, FTpResp, FFormato);
  Resp.Processar(AItem);
  AdicionarResposta(Resp);
end;

// ANome = nome da sessao sem sequencia; ASeq = sequencias (evento + itens pais) ja concatenadas
procedure TRespostas.RespostaBCN(const ANome, ASeq: String; const AItem: TgBCNRet);
var
  Resp: TDeREBCNResposta;
  RespDet: TDeREDetBCNResposta;
  i: Integer;
begin
  Resp := TDeREBCNResposta.Create(ANome + ASeq, FTpResp, FFormato);
  Resp.Processar(AItem);
  AdicionarResposta(Resp);

  for i := 0 to AItem.detBCN.Count - 1 do
  begin
    RespDet := TDeREDetBCNResposta.Create(ANome + CSessaoRespdetBCN + ASeq + SeqResp(i), FTpResp, FFormato);
    RespDet.Processar(AItem.detBCN.Items[i]);
    AdicionarResposta(RespDet);
  end;
end;

// AGrupo = infoTotFinanceiro, infoTotSaude ou infoTotProg (identifica a lista de detBC)
procedure TRespostas.RespostaInfoTotMensal(const AGrupo, ASeqEvento: String; const AItem: TinfoTotMensalRet);
var
  i: Integer;
  SBase, SSeq: String;
  RespBC: TDeREDetBCResposta;
  RespCoef: TDeRECoeficientesResposta;
  RespIBS: TDeREBCIBSResposta;
  RespCBS: TDeREBCCBSResposta;
  RespIS: TDeREBCISResposta;
begin
  SBase := AGrupo + CSessaoRespdetBC;

  for i := 0 to AItem.detBC.Count - 1 do
  begin
    // sequencia do evento + sequencia do detBC
    SSeq := ASeqEvento + SeqResp(i);

    RespBC := TDeREDetBCResposta.Create(SBase + SSeq, FTpResp, FFormato);
    RespBC.Processar(AItem.detBC.Items[i]);
    AdicionarResposta(RespBC);

    if AItem.detBC.Items[i].TemgCoeficientes then
    begin
      RespCoef := TDeRECoeficientesResposta.Create(SBase + CSessaoRespgCoeficientes + SSeq, FTpResp, FFormato);
      RespCoef.Processar(AItem.detBC.Items[i].gCoeficientes);
      AdicionarResposta(RespCoef);
    end;

    RespIBS := TDeREBCIBSResposta.Create(SBase + CSessaoRespgBCIBS + SSeq, FTpResp, FFormato);
    RespIBS.Processar(AItem.detBC.Items[i].gBCIBS);
    AdicionarResposta(RespIBS);

    RespCBS := TDeREBCCBSResposta.Create(SBase + CSessaoRespgBCCBS + SSeq, FTpResp, FFormato);
    RespCBS.Processar(AItem.detBC.Items[i].gBCCBS);
    AdicionarResposta(RespCBS);

    if AItem.detBC.Items[i].TemgBCIS then
    begin
      RespIS := TDeREBCISResposta.Create(SBase + CSessaoRespgBCIS + SSeq, FTpResp, FFormato);
      RespIS.Processar(AItem.detBC.Items[i].gBCIS);
      AdicionarResposta(RespIS);
    end;

    if AItem.detBC.Items[i].TeminfoBCN then
    begin
      RespostaBCN(SBase + CSessaoRespgBCNIBS, SSeq, AItem.detBC.Items[i].infoBCN.gBCNIBS);
      RespostaBCN(SBase + CSessaoRespgBCNCBS, SSeq, AItem.detBC.Items[i].infoBCN.gBCNCBS);
    end;
  end;

  RespostaTotalTributos(AGrupo + CSessaoResptotalTributos, ASeqEvento, AItem.totalTributos);
end;

procedure TRespostas.RespostaRetornoDeRE(const ASeqEvento: String; const AItem: TevtRetornoDeRE);
var
  RespPer: TDeREIdePeriodoApurResposta;
  RespAdic: TDeREInfoAdicResposta;
  RespTot: TDeRETotCodTribResposta;
  RespVApur: TDeRETotVApurResposta;
  i: Integer;
begin
  RespostaIdeStatus(ASeqEvento, AItem.ideStatus);
  RespostaInfoRecEv(ASeqEvento, AItem.infoRecEv);

  if AItem.TemInfoEvento then
  begin
    RespPer := TDeREIdePeriodoApurResposta.Create(CSessaoRespidePeriodo + ASeqEvento, FTpResp, FFormato);
    RespPer.Processar(AItem.idePeriodo);
    AdicionarResposta(RespPer);
  end;

  if AItem.TeminfoAdic then
  begin
    RespAdic := TDeREInfoAdicResposta.Create(CSessaoRespinfoAdic + ASeqEvento, FTpResp, FFormato);
    RespAdic.Processar(AItem.infoAdic);
    AdicionarResposta(RespAdic);
  end;

  // D-9101: totalizadores por codigo de tributacao
  if AItem.TeminfoTotBalan then
    for i := 0 to AItem.infoTotBalan.Count - 1 do
    begin
      RespTot := TDeRETotCodTribResposta.Create(CSessaoRespgTotalCodTrib + ASeqEvento + SeqResp(i), FTpResp, FFormato);
      RespTot.Processar(AItem.infoTotBalan.Items[i]);
      AdicionarResposta(RespTot);
    end;

  // D-9106
  if AItem.TeminfoTotAplicFin then
  begin
    RespVApur := TDeRETotVApurResposta.Create(CSessaoRespinfoTotAplicFin + ASeqEvento, FTpResp, FFormato);
    RespVApur.Processar(AItem.infoTotAplicFin);
    AdicionarResposta(RespVApur);
  end;

  // D-9121
  if AItem.TeminfoTotTitOfPub then
  begin
    RespVApur := TDeRETotVApurResposta.Create(CSessaoRespinfoTotTitOfPub + ASeqEvento, FTpResp, FFormato);
    RespVApur.Processar(AItem.infoTotTitOfPub);
    AdicionarResposta(RespVApur);
  end;

  // D-9199: totalizadores do fechamento mensal
  if AItem.TeminfoTotFinanceiro then
    RespostaInfoTotMensal(CSessaoRespinfoTotFinanceiro, ASeqEvento, AItem.infoTotFinanceiro);

  if AItem.TeminfoTotSaude then
    RespostaInfoTotMensal(CSessaoRespinfoTotSaude, ASeqEvento, AItem.infoTotSaude);

  if AItem.TeminfoTotProg then
    RespostaInfoTotMensal(CSessaoRespinfoTotProg, ASeqEvento, AItem.infoTotProg);

  if AItem.TemtotalTributosGeral then
    RespostaTotalTributos(CSessaoResptotalTributosGeral, ASeqEvento, AItem.totalTributosGeral);
end;

procedure TRespostas.RespostaRetornoTabela(const ASeqEvento: String; const AItem: TevtRetornoTabela);
var
  RespPer: TDeREIdePeriodoResposta;
  RespDet: TDeREDetEventoResposta;
  RespLac: TDeREDetLacunaResposta;
  i: Integer;
begin
  RespostaIdeStatus(ASeqEvento, AItem.ideStatus);
  RespostaInfoRecEv(ASeqEvento, AItem.infoRecEv);

  if AItem.infoEvento.TemInfoEvento then
  begin
    RespPer := TDeREIdePeriodoResposta.Create(CSessaoRespidePeriodo + ASeqEvento, FTpResp, FFormato);
    RespPer.Processar(AItem.infoEvento.idePeriodo);
    AdicionarResposta(RespPer);
  end;

  if AItem.extratoEventos.TemExtrato then
  begin
    for i := 0 to AItem.extratoEventos.detEvento.Count - 1 do
    begin
      RespDet := TDeREDetEventoResposta.Create(CSessaoRespextratoDetEvento + ASeqEvento + SeqResp(i), FTpResp, FFormato);
      RespDet.Processar(AItem.extratoEventos.detEvento.Items[i]);
      AdicionarResposta(RespDet);
    end;

    for i := 0 to AItem.extratoEventos.detLacuna.Count - 1 do
    begin
      RespLac := TDeREDetLacunaResposta.Create(CSessaoRespextratoDetLacuna + ASeqEvento + SeqResp(i), FTpResp, FFormato);
      RespLac.Processar(AItem.extratoEventos.detLacuna.Items[i]);
      AdicionarResposta(RespLac);
    end;
  end;
end;

procedure TRespostas.RespostaRetornoEvento(const ACont: Integer; const AItem: TRetornoEventoCollectionItem);
var
  Resp: TDeREEventoResposta;
  SSeq: String;
begin
  SSeq := SeqResp(ACont);

  // Evento001, Evento002...
  Resp := TDeREEventoResposta.Create(CSessaoRespEvento + SSeq, FTpResp, FFormato);
  Resp.Processar(AItem);
  AdicionarResposta(Resp);

  // as demais sessoes do evento levam a mesma sequencia no final do nome
  if Assigned(AItem.Retorno) then
    RespostaRetornoDeRE(SSeq, AItem.Retorno)
  else
  if Assigned(AItem.RetornoTabela) then
    RespostaRetornoTabela(SSeq, AItem.RetornoTabela);
end;

end.
