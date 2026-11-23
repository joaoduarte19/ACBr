{******************************************************************************}
{ Projeto: Componentes ACBr - ACBrNFeABI                                       }
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

unit ACBrNFeABI.DANFEABIFPDF;

interface

uses
  Classes,
  SysUtils,
  StrUtils,
  DateUtils,
  Math,
  ACBr_fpdf,
  ACBr_fpdf_ext,
  ACBr_fpdf_report,
  ACBrDFe.Conversao,
  ACBrDFe.RTC.Classes,
  ACBrNFeABI.Classes,
  ACBrNFeABI.Conversao,
  ACBrNFeABI.EnvEvento,
  ACBrNFeABI.EventoClass,
  ACBrValidador,
  ACBrUtil.Base,
  ACBrUtil.DateTime,
  ACBrUtil.Strings,
  ACBrUtil.FilesIO,
  ACBrDFeUtil,
  ACBrNFeABI,
  ACBrBase,
  ACBrNFeABI.UtilsFPDF,
  ACBrNFeABI.DANFEABIClass,
  ACBrUtil.Compatibilidade;

type
  { TNFeABIDANFeABIFPDF }

  TNFeABIDANFeABIFPDF = class(TFPDFReport)
  private
    FNFeABI: TNFeABI;
    FNFeABIUtils: TNFeABIUtilsFPDF;
    FDANFeABIClassOwner: TACBrNFeABIDANFEABIClass;
    FLogo: AnsiString;
    FLogoStretched: Boolean;
    FLogoAlign: TLogoAlign;
    FMensagemRodape: String;
    FInitialized: Boolean;

  protected
    procedure OnStartReport(Args: TFPDFReportEventArgs); override;

  public
    constructor Create(ANFeABI: TNFeABI; ADANFeABIClassOwner: TACBrNFeABIDANFEABIClass); reintroduce;
    destructor Destroy; override;

  public
    property LogoBytes: AnsiString read FLogo write FLogo;
    property LogoStretched: Boolean read FLogoStretched write FLogoStretched;
    property LogoAlign: TLogoAlign read FLogoAlign write FLogoAlign;
    property MensagemRodape: String read FMensagemRodape write FMensagemRodape;
  end;

type
  { TNFeABIDANFeABIEventoFPDF }

  TNFeABIDANFeABIEventoFPDF = class(TFPDFReport)
  private
    FNFeABI: TNFeABI;
    FEvento: TInfEventoCollectionItem;
    FMensagemRodape: String;
    FInitialized: Boolean;
  protected
    procedure OnStartReport(Args: TFPDFReportEventArgs); override;
  public
    constructor Create(ANFeABI: TNFeABI; AEvento: TInfEventoCollectionItem); reintroduce;

    property MensagemRodape: String read FMensagemRodape write FMensagemRodape;
  end;

type
  {$IFDEF RTL230_UP}
  [ComponentPlatformsAttribute(piacbrAllPlatforms)]
  {$ENDIF RTL230_UP}

  { TACBrNFeABIDANFeABIFPDF }

  TACBrNFeABIDANFeABIFPDF = class(TACBrNFeABIDANFEABIClass)
  private
    FFPDFReport: TNFeABIDANFeABIFPDF;
    FStream: TStream;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure ImprimirDANFeABI(ANFeABI: TNFeABI = nil); override;
    procedure ImprimirDANFeABIPDF(ANFeABI: TNFeABI = nil); override;
    procedure ImprimirDANFeABIPDF(AStream: TStream; ANFeABI: TNFeABI = nil); override;

    procedure ImprimirEVENTO(ANFeABI: TNFeABI = nil); override;
    procedure ImprimirEVENTOPDF(ANFeABI: TNFeABI = nil); override;
    procedure ImprimirEVENTOPDF(AStream: TStream; ANFeABI: TNFeABI = nil); override;
  published
  end;

implementation

const
  // Medidas do DANFE-ABI em milimetros (mm), extraidas do modelo de referencia (item 6.9 da NT 2026.001).

  // --- Formato retrato ---

  // Largura util da folha no formato retrato
  CLARG = 189.82;
  // Linha de base do texto do titulo de cada bloco, a partir do topo do bloco
  CBASE_TITULO = 3.51;
  // Altura da faixa de titulo de cada bloco
  CALT_TITULO = 4.52;
  // Recuo horizontal do texto dentro das celulas
  CPAD = 1.09;
  // Linha de base do rotulo (texto pequeno da celula), a partir do topo da celula
  CBASE_ROTULO = 2.58;
  // Linha de base da primeira linha do valor, a partir do topo da celula
  CBASE_VALOR = 5.63;
  // Altura de uma celula rotulo/valor de uma linha
  CALT_CAMPO = 6.48;
  // Distancia entre as linhas de texto de uma celula e dos dados adicionais
  CENTRELINHA = 3.03;
  // Altura do cabecalho das tabelas (transmitentes, adquirentes e pagamento)
  CALT_CAB_TAB = 6.09;
  // Altura de uma linha de dados das tabelas (uma linha de texto)
  CALT_LIN_TAB = 3.27;
  // Distancia entre as linhas de texto dentro de uma linha das tabelas
  CENTRELINHA_TAB = 2.89;
  // Linha de base do texto de uma linha das tabelas, a partir do topo da linha
  CBASE_LIN_TAB = 2.45;
  // Divisao da largura em quatro colunas iguais: fim da 1a coluna (1/4)
  C4A = 47.44;
  // Divisao da largura em quatro colunas iguais: fim da 2a coluna (2/4)
  C4B = 94.84;
  // Divisao da largura em quatro colunas iguais: fim da 3a coluna (3/4)
  C4C = 142.25;
  // Divisao da largura em seis colunas iguais: fim da 1a coluna (1/6)
  S1 = 31.63;
  // Divisao da largura em seis colunas iguais: fim da 2a coluna (2/6)
  S2 = 63.21;
  // Divisao da largura em seis colunas iguais: fim da 3a coluna (3/6)
  S3 = 94.84;
  // Divisao da largura em seis colunas iguais: fim da 4a coluna (4/6)
  S4 = 126.43;
  // Divisao da largura em seis colunas iguais: fim da 5a coluna (5/6)
  S5 = 158.06;
  // Posicao X da divisao entre o quadro do emitente e o quadro do titulo DANFE-ABI
  CVTIT = 79.03;
  // Posicao X do inicio do quadro da chave de acesso (divisao com o quadro do titulo)
  CVCH = 122.24;
  // Posicao X da divisao entre a modalidade e o detalhamento da operacao
  CVMOD = 63.21;
  // Posicao X da divisao entre o tipo do documento e a finalidade
  CVFIN = 158.06;
  // Altura minima do quadro do emitente
  CALT_EMITENTE = 23.89;
  // Largura do logo do emitente (sem expandir)
  CLOGO_LARG = 24;
  // Altura do logo do emitente (sem expandir)
  CLOGO_ALT = 18.34;
  // Texto dos campos sem informacao
  CVAZIO = '-';

  // --- Formato paisagem (item 6.10 da NT 2026.001): a largura util e dividida em 24 colunas iguais ---

  // Largura util da folha no formato paisagem
  CLARG_P = 271.77;
  // Posicao X da divisao depois da coluna 01 (de 24 colunas iguais) no formato paisagem
  PX01 = 11.32;
  // Posicao X da divisao depois da coluna 02 (de 24 colunas iguais) no formato paisagem
  PX02 = 22.65;
  // Posicao X da divisao depois da coluna 03 (de 24 colunas iguais) no formato paisagem
  PX03 = 33.97;
  // Posicao X da divisao depois da coluna 04 (de 24 colunas iguais) no formato paisagem
  PX04 = 45.29;
  // Posicao X da divisao depois da coluna 05 (de 24 colunas iguais) no formato paisagem
  PX05 = 56.62;
  // Posicao X da divisao depois da coluna 06 (de 24 colunas iguais) no formato paisagem
  PX06 = 67.94;
  // Posicao X da divisao depois da coluna 07 (de 24 colunas iguais) no formato paisagem
  PX07 = 79.27;
  // Posicao X da divisao depois da coluna 08 (de 24 colunas iguais) no formato paisagem
  PX08 = 90.59;
  // Posicao X da divisao depois da coluna 09 (de 24 colunas iguais) no formato paisagem
  PX09 = 101.91;
  // Posicao X da divisao depois da coluna 10 (de 24 colunas iguais) no formato paisagem
  PX10 = 113.24;
  // Posicao X da divisao depois da coluna 11 (de 24 colunas iguais) no formato paisagem
  PX11 = 124.56;
  // Posicao X da divisao depois da coluna 12 (de 24 colunas iguais) no formato paisagem
  PX12 = 135.88;
  // Posicao X da divisao depois da coluna 13 (de 24 colunas iguais) no formato paisagem
  PX13 = 147.21;
  // Posicao X da divisao depois da coluna 14 (de 24 colunas iguais) no formato paisagem
  PX14 = 158.53;
  // Posicao X da divisao depois da coluna 15 (de 24 colunas iguais) no formato paisagem
  PX15 = 169.86;
  // Posicao X da divisao depois da coluna 16 (de 24 colunas iguais) no formato paisagem
  PX16 = 181.18;
  // Posicao X da divisao depois da coluna 17 (de 24 colunas iguais) no formato paisagem
  PX17 = 192.5;
  // Posicao X da divisao depois da coluna 18 (de 24 colunas iguais) no formato paisagem
  PX18 = 203.83;
  // Posicao X da divisao depois da coluna 19 (de 24 colunas iguais) no formato paisagem
  PX19 = 215.15;
  // Posicao X da divisao depois da coluna 20 (de 24 colunas iguais) no formato paisagem
  PX20 = 226.47;
  // Posicao X da divisao depois da coluna 21 (de 24 colunas iguais) no formato paisagem
  PX21 = 237.8;
  // Altura do codigo de barras da chave de acesso
  CALT_BARRA_P = 10.3;
  // Altura do texto de consulta da chave de acesso, abaixo da chave
  CALT_CONSULTA_P = 5.29;
  // Altura da faixa cinza com os titulos de transmitentes e adquirentes lado a lado
  CALT_BANDA_TAB = 3.25;

type
  { Celulas rotulo/valor dos blocos de campos }

  TCelulaNFeABI = record
    X1: Double;
    X2: Double;
    Rotulo: string;
    Valor: string;
    Fundo: Boolean;
  end;

  TCelulasNFeABI = array of TCelulaNFeABI;
  TLinhasNFeABI = array of TCelulasNFeABI;

  { Tabela (transmitentes, adquirentes e pagamento previsto) }

  TTabelaNFeABI = class
  public
    Titulo: string;
    X0: Double;
    Larg: Double;
    XFim: array of Double;
    Rotulo1: array of string;
    Rotulo2: array of string;
    Alinhamento: array of Char;
    Quebra: array of Boolean;
    Linhas: array of array of string;
    constructor Create;
    procedure AddColuna(AXFim: Double; const ARotulo1, ARotulo2: string;
      AAlinhamento: Char; AQuebra: Boolean);
    procedure AddLinha(const ACelulas: array of string);
    function TotalColunas: Integer;
    function XIni(AColuna: Integer): Double;
  end;

  { TBlocoMarcaDaguaNFeABI }

  TBlocoMarcaDaguaNFeABI = class(TFPDFBand)
  private
    FNFeABIUtils: TNFeABIUtilsFPDF;
    FCancelada: Boolean;
    procedure Marca(Args: TFPDFBandDrawArgs; x, y, w, h: Double;
      const ATexto: string; ATamanho: Double);
  protected
    procedure OnDraw(Args: TFPDFBandDrawArgs); override;
  public
    constructor Create(ANFeABIUtils: TNFeABIUtilsFPDF; ACancelada: Boolean); reintroduce;
  end;

  { TBlocoCabecalhoNFeABI }

  TBlocoCabecalhoNFeABI = class(TFPDFBand)
  private
    FNFeABIUtils: TNFeABIUtilsFPDF;
    FLogo: AnsiString;
    FExpandeLogo: Boolean;
    FProtocolo: string;
    FTextoX: Double;
    FPaisagem: Boolean;
    procedure DesenharRetrato(Args: TFPDFBandDrawArgs);
    procedure DesenharPaisagem(Args: TFPDFBandDrawArgs);
  protected
    procedure OnInit(Args: TFPDFBandInitArgs); override;
    procedure OnDraw(Args: TFPDFBandDrawArgs); override;
  public
    constructor Create(ANFeABIUtils: TNFeABIUtilsFPDF; const ALogo: AnsiString;
      AExpandeLogo: Boolean; const AProtocolo: string; APaisagem: Boolean = False); reintroduce;
  end;

  { TBlocoTabelaNFeABI (base de Transmitentes, Adquirentes e Pagamento) }

  TBlocoTabelaNFeABI = class(TFPDFBand)
  private
    FNFeABIUtils: TNFeABIUtilsFPDF;
    FTabela: TTabelaNFeABI;
    FProximo: Integer;
  protected
    FPaisagem: Boolean;
    function CriarTabela: TTabelaNFeABI; virtual; abstract;
    procedure OnInit(Args: TFPDFBandInitArgs); override;
    procedure OnDraw(Args: TFPDFBandDrawArgs); override;
  public
    constructor Create(ANFeABIUtils: TNFeABIUtilsFPDF; APaisagem: Boolean = False); reintroduce;
    destructor Destroy; override;
  end;

  { TBlocoTransmitentesNFeABI }

  TBlocoTransmitentesNFeABI = class(TBlocoTabelaNFeABI)
  protected
    function CriarTabela: TTabelaNFeABI; override;
  end;

  { TBlocoAdquirentesNFeABI }

  TBlocoAdquirentesNFeABI = class(TBlocoTabelaNFeABI)
  protected
    function CriarTabela: TTabelaNFeABI; override;
  end;

  { TBlocoPagamentoNFeABI }

  TBlocoPagamentoNFeABI = class(TBlocoTabelaNFeABI)
  protected
    function CriarTabela: TTabelaNFeABI; override;
  end;

  { TBlocoPartesNFeABI (paisagem: transmitentes e adquirentes lado a lado) }

  TBlocoPartesNFeABI = class(TFPDFBand)
  private
    FNFeABIUtils: TNFeABIUtilsFPDF;
    FTransmit: TTabelaNFeABI;
    FAdquirente: TTabelaNFeABI;
    FProximo: Integer;
  protected
    procedure OnInit(Args: TFPDFBandInitArgs); override;
    procedure OnDraw(Args: TFPDFBandDrawArgs); override;
  public
    constructor Create(ANFeABIUtils: TNFeABIUtilsFPDF); reintroduce;
    destructor Destroy; override;
  end;

  { TBlocoCamposNFeABI (base de Imovel, Operacao e Calculo) }

  TBlocoCamposNFeABI = class(TFPDFBand)
  private
    FNFeABIUtils: TNFeABIUtilsFPDF;
    FTitulo: string;
    FAdiado: Boolean;
  protected
    FPaisagem: Boolean;
    function TemConteudo: Boolean; virtual; abstract;
    function MontarLinhasRetrato: TLinhasNFeABI; virtual; abstract;
    function MontarLinhasPaisagem: TLinhasNFeABI; virtual; abstract;
    function MontarLinhas: TLinhasNFeABI;
    procedure OnInit(Args: TFPDFBandInitArgs); override;
    procedure OnDraw(Args: TFPDFBandDrawArgs); override;
  public
    constructor Create(ANFeABIUtils: TNFeABIUtilsFPDF; const ATitulo: string;
      APaisagem: Boolean = False); reintroduce;
  end;

  { TBlocoImovelNFeABI }

  TBlocoImovelNFeABI = class(TBlocoCamposNFeABI)
  protected
    function TemConteudo: Boolean; override;
    function MontarLinhasRetrato: TLinhasNFeABI; override;
    function MontarLinhasPaisagem: TLinhasNFeABI; override;
  public
    constructor Create(ANFeABIUtils: TNFeABIUtilsFPDF; APaisagem: Boolean = False); reintroduce;
  end;

  { TBlocoOperacaoNFeABI }

  TBlocoOperacaoNFeABI = class(TBlocoCamposNFeABI)
  protected
    function TemConteudo: Boolean; override;
    function MontarLinhasRetrato: TLinhasNFeABI; override;
    function MontarLinhasPaisagem: TLinhasNFeABI; override;
  public
    constructor Create(ANFeABIUtils: TNFeABIUtilsFPDF; APaisagem: Boolean = False); reintroduce;
  end;

  { TBlocoCalculoNFeABI }

  TBlocoCalculoNFeABI = class(TBlocoCamposNFeABI)
  protected
    function TemConteudo: Boolean; override;
    function MontarLinhasRetrato: TLinhasNFeABI; override;
    function MontarLinhasPaisagem: TLinhasNFeABI; override;
  public
    constructor Create(ANFeABIUtils: TNFeABIUtilsFPDF; APaisagem: Boolean = False); reintroduce;
  end;

  { TBlocoObservacoesNFeABI (continuacao das Informacoes complementares) }

  TBlocoObservacoesNFeABI = class(TFPDFBand)
  private
    FNFeABIUtils: TNFeABIUtilsFPDF;
    FProximo: Integer;
    FPaisagem: Boolean;
  protected
    procedure OnInit(Args: TFPDFBandInitArgs); override;
    procedure OnDraw(Args: TFPDFBandDrawArgs); override;
  public
    constructor Create(ANFeABIUtils: TNFeABIUtilsFPDF; APaisagem: Boolean = False); reintroduce;
  end;

  { TBlocoDadosAdicionaisNFeABI }

  TBlocoDadosAdicionaisNFeABI = class(TFPDFBand)
  private
    FNFeABIUtils: TNFeABIUtilsFPDF;
    FQrGrande: Boolean;
    FQrTamanho: Double;
    FAltura: Double;
    FPaisagem: Boolean;
    procedure DefinirMedidasRetrato;
    procedure DefinirMedidasPaisagem;
    procedure DesenharConsultaRetrato(APDF: IFPDF);
    procedure DesenharConsultaPaisagem(APDF: IFPDF);
  protected
    procedure OnInit(Args: TFPDFBandInitArgs); override;
    procedure OnDraw(Args: TFPDFBandDrawArgs); override;
  public
    constructor Create(ABandType: TFPDFBandType; ANFeABIUtils: TNFeABIUtilsFPDF;
      APaisagem: Boolean = False); reintroduce;
  end;

  { TBlocoRodapeNFeABI }

  TBlocoRodapeNFeABI = class(TFPDFBand)
  private
    FMensagem: String;
  protected
    procedure OnDraw(Args: TFPDFBandDrawArgs); override;
    procedure OnInit(Args: TFPDFBandInitArgs); override;
  public
    constructor Create(const AMensagem: String); reintroduce;
  end;

  { TBlocoMarcaDaguaEventoNFeABI }

  TBlocoMarcaDaguaEventoNFeABI = class(TFPDFBand)
  private
    FEvento: TInfEventoCollectionItem;
    function Watermark(Args: TFPDFBandDrawArgs; x, y, w, h: double;
      const ATexto: string; AFontSize: Double = 48;
      const AFontStyle: string = 'B'): double;
  protected
    procedure OnDraw(Args: TFPDFBandDrawArgs); override;
  public
    constructor Create(AEvento: TInfEventoCollectionItem); reintroduce;
  end;

  { TBlocoCabecalhoEventoNFeABI }

  TBlocoCabecalhoEventoNFeABI = class(TFPDFBand)
  private
    FNFeABI: TNFeABI;
    FEvento: TInfEventoCollectionItem;
  protected
    procedure OnInit(Args: TFPDFBandInitArgs); override;
    procedure OnDraw(Args: TFPDFBandDrawArgs); override;
  public
    constructor Create(ANFeABI: TNFeABI; AEvento: TInfEventoCollectionItem); reintroduce;
  end;

  { TBlocoDadosNFeABIEventoNFeABI }

  TBlocoDadosNFeABIEventoNFeABI = class(TFPDFBand)
  private
    FNFeABI: TNFeABI;
  protected
    procedure OnInit(Args: TFPDFBandInitArgs); override;
    procedure OnDraw(Args: TFPDFBandDrawArgs); override;
  public
    constructor Create(ANFeABI: TNFeABI); reintroduce;
  end;

  { TBlocoEmitenteEventoNFeABI }

  TBlocoEmitenteEventoNFeABI = class(TFPDFBand)
  private
    FNFeABI: TNFeABI;
  protected
    procedure OnInit(Args: TFPDFBandInitArgs); override;
    procedure OnDraw(Args: TFPDFBandDrawArgs); override;
  public
    constructor Create(ANFeABI: TNFeABI); reintroduce;
  end;

  { TBlocoDadosEventoNFeABI }

  TBlocoDadosEventoNFeABI = class(TFPDFBand)
  private
    FNFeABI: TNFeABI;
    FEvento: TInfEventoCollectionItem;
  protected
    procedure OnInit(Args: TFPDFBandInitArgs); override;
    procedure OnDraw(Args: TFPDFBandDrawArgs); override;
  public
    constructor Create(ANFeABI: TNFeABI; AEvento: TInfEventoCollectionItem); reintroduce;
  end;

  { TBlocoJustificativaEventoNFeABI }

  TBlocoJustificativaEventoNFeABI = class(TFPDFBand)
  private
    FEvento: TInfEventoCollectionItem;
  protected
    procedure OnInit(Args: TFPDFBandInitArgs); override;
    procedure OnDraw(Args: TFPDFBandDrawArgs); override;
  public
    constructor Create(AEvento: TInfEventoCollectionItem); reintroduce;
  end;

procedure SetFontBoxHeaderNFeABI(PDF: IFPDF);
begin
  PDF.SetFont('Arial', '', 6);
end;

procedure SetFontBoxContentNFeABI(PDF: IFPDF);
begin
  PDF.SetFont('Arial', '', 9);
end;

procedure SetFontBoxContentBoldNFeABI(PDF: IFPDF);
begin
  PDF.SetFont('Arial', 'B', 9);
end;

const
  // Os codigos do leiaute que o componente guarda como Integer ou String (modOper, natOper, detOper,
  // espImovel, enquadramento, tpInstrumento e tPag) sao descritos por vetores indexados pelo proprio codigo
  // (posicao 0 = sem descricao); o codigo 99 (Outros) usa a ultima posicao do vetor.
  CESP_OUTROS = '99';
  CINSTRUMENTO_OUTROS = 99;

  CDescModOperNFeABI: array[0..4] of string = (
    '',
    'Alienação em geral',
    'Arrematação Judicial, Adjudicação ou Remição',
    'Cessão ou Transmissão de direitos',
    'Permuta');

  CDescNatOperNFeABI: array[0..15] of string = (
    '',
    'Compra e venda',
    'Dação em pagamento',
    'Operações realizadas pelo credor da garantia ou grupo de consórcios',
    'Atos societários',
    'Doações ou transferências gratuitas',
    'Arrematação em leilão judicial',
    'Adjudicação',
    'Remição',
    'Cessão de direitos relativos ao bem imóvel',
    'Enfiteuse ou direito de superfície',
    'Uso / usufruto',
    'Direitos reais não enquadrados nos itens anteriores',
    'Permuta envolvendo exclusivamente bens imóveis (com ou sem torna)',
    'Compra e venda quitada com confissão de dívida e promessa de dação em pagamento nos termos do art. 252, § 6° da LC 214/2025 (com ou sem torna)',
    'Permuta não enquadrada nos itens anteriores');

  CDescDetOperNFeABI: array[0..34] of string = (
    '',
    'Promessa / compromisso de compra e venda',
    'Compra e venda definitiva',
    'Promessa / compromisso de dação em pagamento',
    'Dação em pagamento definitiva',
    'Consolidação da propriedade pelo credor da garantia (art. 200 da LC 214/2025)',
    'Consolidação da propriedade pelo grupo de consórcios (art. 204, parag. 3° da LC 214/2025)',
    'Alienação pelo credor da garantia',
    'Alienação pelo grupo de consórcios',
    'Realização ou integralização de capital',
    'Incorporação societária',
    'Fusão',
    'Cisão total ou parcial',
    'Extinção de pessoa jurídica (baixa pelo encerramento da liquidação)',
    'Desincorporação de bem imóvel pertencente à pessoa jurídica em virtude de redução de capital',
    'Doação sem contraprestação em benefício do doador',
    'Doação com contraprestação em benefício do doador',
    'Cessão onerosa de direitos relativos a promessa ou compromisso de compra e venda',
    'Cessão onerosa de direitos sucessórios ou hereditários',
    'Cessão onerosa de direitos sobre o imóvel com alienação fiduciária',
    'Cessão de direitos do arrematante',
    'Cessão de direitos do adjudicatário',
    'Constituição de enfiteuse ou aforamento de imóveis dominiais da União',
    'Transmissão onerosa da enfiteuse ou do domínio útil',
    'Concessão onerosa do direito de superfície',
    'Cessão onerosa do direito de superfície',
    'Instituição onerosa do uso / usufruto',
    'Transmissão ou cessão onerosa do uso / usufruto',
    'Concessão onerosa do uso especial para fins de moradia',
    'Transmissão ou cessão onerosa do uso especial para fins de moradia',
    'Concessão onerosa do direito real de uso',
    'Transmissão ou cessão onerosa do direito real de uso',
    'Concessão onerosa do direito de laje',
    'Cessão onerosa do direito de laje',
    'Cessão onerosa de direitos oriundos da imissão provisória na posse');

  CDescTipoNFNFeABI: array[TtpNF] of string = (
    'Simplificado', 'Completo', 'Transição');

  CDescFinalidadeNFeABI: array[TfinNFe] of string = (
    'NF-e normal', 'NF-e de substituição');

  CDescTipoPagAntNFeABI: array[TtpPagAntABI] of string = (
    '', 'Pagamento antecipado', 'Fornecimento com pagamento realizado anteriormente');

  CDescTipoEmitenteNFeABI: array[TtpEmit] of string = (
    'Vendedor, Transmitente ou Cedente',
    'Comprador, Adquirente ou Cessionário',
    'Leiloeiro (em nome do arrematante)',
    'Tabelionato de Notas (em nome do vendedor ou transmitente)',
    'Junta Comercial (em nome do transmitente)',
    'Banco ou instituição financeira (em nome do vendedor ou transmitente)',
    'Organização gestora de fundo patrimonial',
    'Credor fiduciário (na consolidação da propriedade)',
    'Grupo de consórcio (na consolidação da propriedade)',
    'Sucessora em virtude de incorporação, cisão ou fusão',
    'Instituição administradora em nome do Fundo de Investimento (FII ou Fiagro)',
    'Outros Emitentes');

  CDescIndContribNFeABI: array[TindContrib] of string = (
    '', 'Não contribuinte', 'Regime regular', 'Optante do Simples Nacional');

  CDescTipoImovelNFeABI: array[Ttipo] of string = (
    'Urbano', 'Rural');

  CDescEspImovelNFeABI: array[0..13] of string = (
    '', 'Terreno', 'Casa', 'Apartamento', 'Vaga de garagem', 'Laje', 'Sala',
    'Conjunto de salas', 'Loja', 'Sobreloja', 'Estacionamento', 'Barraco',
    'Galpão', 'Outros');

  CDescEnquadramentoNFeABI: array[0..4] of string = (
    '', 'Imóvel residencial novo', 'Imóvel residencial usado', 'Lote residencial',
    'Não residencial');

  CDescUnidAreaNFeABI: array[TuareaTotal] of string = (
    'Metro quadrado', 'Hectares');

  CDescTipoInstrumentoNFeABI: array[0..12] of string = (
    '',
    'Contrato particular',
    'Contrato particular junto ao banco',
    'Escritura pública',
    'Auto de arrematação',
    'Auto de adjudicação',
    'Decisão judicial',
    'Averbação da consolidação de propriedade',
    'Contrato social',
    'Alteração contratual',
    'Ata de assembleia geral',
    'Distrato social',
    'Outros');

  CDescTipoEnteGovNFeABI: array[TtpEnteGov] of string = (
    '', 'União', 'Estados', 'Distrito Federal', 'Município', '', '');

  CDescTipoOperGovNFeABI: array[TtpOperGov] of string = (
    '', 'Fornecimento', 'Recebimento de pagamento', '', '');

  CDescTPagNFeABI: array[0..7] of string = (
    '', 'Recursos próprios', 'Recursos de terceiros', 'FGTS', 'Financiamento',
    'Consórcio imobiliário', 'Bens ou direitos', 'Outros');

{ Descricao do codigo informado no vetor (posicao = codigo; 99 = ultima posicao); fora do vetor, vazio }
function DescCodigoNFeABI(const ADescricoes: array of string; ACodigo: Integer): string;
begin
  if (ACodigo = 99) and (High(ADescricoes) > 0) then
    Result := ADescricoes[High(ADescricoes)]
  else if (ACodigo >= Low(ADescricoes)) and (ACodigo <= High(ADescricoes)) then
    Result := ADescricoes[ACodigo]
  else
    Result := '';
end;

{ Funcoes de apoio ao desenho (medidas em mm; fontes em pt) }

function LarguraNFeABI(APaisagem: Boolean): Double;
begin
  if APaisagem then
    Result := CLARG_P
  else
    Result := CLARG;
end;

{ Posicao do quadro de QR Code (dados adicionais) }
function XQrNFeABI(APaisagem: Boolean): Double;
begin
  if APaisagem then
    Result := PX18
  else
    Result := 126.43;
end;

function CapacComplNFeABI(APaisagem: Boolean): Integer;
begin
  if APaisagem then
    Result := 4
  else
    Result := 7;
end;

function CapacFiscoNFeABI(APaisagem: Boolean): Integer;
begin
  if APaisagem then
    Result := 3
  else
    Result := 4;
end;

function LarguraTextoComplNFeABI(APaisagem: Boolean): Double;
begin
  Result := XQrNFeABI(APaisagem) - 2 * CPAD;
end;

procedure PrepararTracoNFeABI(APDF: IFPDF);
begin
  APDF.SetDrawColor(0, 0, 0);
  APDF.SetFillColor(0, 0, 0);
  APDF.SetLineWidth(0.25);
end;

procedure FonteRotuloNFeABI(APDF: IFPDF);
begin
  APDF.SetFont('Arial', '', 5.5);
  APDF.SetTextColor(64, 64, 64);
end;

procedure FonteValorNFeABI(APDF: IFPDF);
begin
  APDF.SetFont('Arial', 'B', 7.5);
  APDF.SetTextColor(0, 0, 0);
end;

procedure FonteTextoNFeABI(APDF: IFPDF);
begin
  APDF.SetFont('Arial', '', 7);
  APDF.SetTextColor(0, 0, 0);
end;

procedure FonteTituloNFeABI(APDF: IFPDF);
begin
  APDF.SetFont('Arial', 'B', 7);
  APDF.SetTextColor(0, 0, 0);
end;

procedure LinhaHNFeABI(APDF: IFPDF; AX1, AX2, AY: Double);
begin
  APDF.Line(AX1, AY, AX2, AY);
end;

procedure LinhaVNFeABI(APDF: IFPDF; AX, AY1, AY2: Double);
begin
  APDF.Line(AX, AY1, AX, AY2);
end;

procedure TxtEsqNFeABI(APDF: IFPDF; AX, AY: Double; const ATexto: string);
begin
  APDF.Text(AX, AY, ATexto);
end;

procedure TxtCenNFeABI(APDF: IFPDF; AXCentro, AY: Double; const ATexto: string);
begin
  APDF.Text(AXCentro - APDF.GetStringWidth(ATexto) / 2, AY, ATexto);
end;

procedure TxtDirNFeABI(APDF: IFPDF; AXDireita, AY: Double; const ATexto: string);
begin
  APDF.Text(AXDireita - APDF.GetStringWidth(ATexto), AY, ATexto);
end;

{ Quebra o texto em linhas que caibam na largura (mm), na fonte corrente. }
procedure QuebrarTextoNFeABI(APDF: IFPDF; const ATexto: string; ALarguraMm: Double;
  ALinhas: TStrings);
var
  LTexto: string;
  LParagrafo: string;
  LLinha: string;
  LPalavra: string;
  LTentativa: string;
  LPos: Integer;
  LCorte: Integer;
begin
  ALinhas.Clear;
  LTexto := StringReplace(ATexto, #13#10, #10, [rfReplaceAll]);
  LTexto := StringReplace(LTexto, #13, #10, [rfReplaceAll]);

  while True do
  begin
    LPos := Pos(#10, LTexto);
    if LPos > 0 then
    begin
      LParagrafo := Copy(LTexto, 1, LPos - 1);
      Delete(LTexto, 1, LPos);
    end
    else
    begin
      LParagrafo := LTexto;
      LTexto := '';
    end;

    if LParagrafo = '' then
      ALinhas.Add('')
    else
    begin
      LLinha := '';
      while LParagrafo <> '' do
      begin
        LPos := Pos(' ', LParagrafo);
        if LPos > 0 then
        begin
          LPalavra := Copy(LParagrafo, 1, LPos - 1);
          Delete(LParagrafo, 1, LPos);
        end
        else
        begin
          LPalavra := LParagrafo;
          LParagrafo := '';
        end;

        if LPalavra = '' then
          Continue;

        if LLinha = '' then
          LTentativa := LPalavra
        else
          LTentativa := LLinha + ' ' + LPalavra;

        if APDF.GetStringWidth(LTentativa) <= ALarguraMm then
          LLinha := LTentativa
        else
        begin
          if LLinha <> '' then
            ALinhas.Add(LLinha);

          // palavra maior que a largura: quebra por caracteres
          LLinha := LPalavra;
          while (APDF.GetStringWidth(LLinha) > ALarguraMm) and (Length(LLinha) > 1) do
          begin
            LCorte := Length(LLinha) - 1;
            while (LCorte > 1) and (APDF.GetStringWidth(Copy(LLinha, 1, LCorte)) > ALarguraMm) do
              Dec(LCorte);
            ALinhas.Add(Copy(LLinha, 1, LCorte));
            LLinha := Copy(LLinha, LCorte + 1, Length(LLinha));
          end;
        end;
      end;
      ALinhas.Add(LLinha);
    end;

    if LTexto = '' then
      Break;
  end;
end;

procedure AddQuebradoNFeABI(APDF: IFPDF; ADestino: TStrings; const ATexto: string;
  ALarguraMm: Double);
var
  LTemp: TStringList;
begin
  if Trim(ATexto) = '' then
    Exit;
  LTemp := TStringList.Create;
  try
    QuebrarTextoNFeABI(APDF, ATexto, ALarguraMm, LTemp);
    ADestino.AddStrings(LTemp);
  finally
    LTemp.Free;
  end;
end;

{ Numero de linhas que o valor ocupa na celula (fonte do valor). }
function LinhasValorNFeABI(APDF: IFPDF; const AValor: string; ALarguraCelula: Double): Integer;
var
  LLinhas: TStringList;
begin
  FonteValorNFeABI(APDF);
  LLinhas := TStringList.Create;
  try
    QuebrarTextoNFeABI(APDF, AValor, ALarguraCelula - 2 * CPAD, LLinhas);
    Result := LLinhas.Count;
    if Result < 1 then
      Result := 1;
  finally
    LLinhas.Free;
  end;
end;

function AlturaLinhaCamposNFeABI(ALinhas: Integer): Double;
begin
  if ALinhas < 1 then
    ALinhas := 1;
  Result := CALT_CAMPO + (ALinhas - 1) * CENTRELINHA;
end;

procedure AddCelNFeABI(var ALinha: TCelulasNFeABI; AX1, AX2: Double; const ARotulo, AValor: string;
  AFundo: Boolean = False);
begin
  SetLength(ALinha, Length(ALinha) + 1);
  ALinha[High(ALinha)].X1 := AX1;
  ALinha[High(ALinha)].X2 := AX2;
  ALinha[High(ALinha)].Rotulo := ARotulo;
  ALinha[High(ALinha)].Valor := AValor;
  ALinha[High(ALinha)].Fundo := AFundo;
end;

procedure AddLinhaNFeABI(var ALinhas: TLinhasNFeABI; const ALinha: TCelulasNFeABI);
begin
  SetLength(ALinhas, Length(ALinhas) + 1);
  ALinhas[High(ALinhas)] := ALinha;
end;

function MaxLinhasCelulasNFeABI(APDF: IFPDF; const ACelulas: TCelulasNFeABI): Integer;
var
  I: Integer;
  N: Integer;
begin
  Result := 1;
  for I := 0 to High(ACelulas) do
  begin
    N := LinhasValorNFeABI(APDF, ACelulas[I].Valor, ACelulas[I].X2 - ACelulas[I].X1);
    if N > Result then
      Result := N;
  end;
end;

{ Desenha o logo dentro do quadro, mantendo a proporcao da imagem. }
procedure DesenharLogoNoQuadroNFeABI(APDF: IFPDF; const ALogo: AnsiString; AX, AY, ALarg,
  AAlt: Double; ACentralizar: Boolean);
var
  LStream: TMemoryStream;
  LUtils: TImageUtils;
  LLargPx: Word;
  LAltPx: Word;
  LEscala: Double;
  LLarg: Double;
  LAlt: Double;
  LX: Double;
begin
  LStream := TMemoryStream.Create;
  try
    LStream.Write(PAnsiChar(ALogo)^, Length(ALogo));
    LUtils := TImageUtils.Create;
    try
      LStream.Position := 0;
      if (not LUtils.GetImageSize(LStream, LLargPx, LAltPx)) or (LLargPx = 0) or (LAltPx = 0) then
        Exit;
    finally
      LUtils.Free;
    end;

    LStream.Position := 0;
    LEscala := Min(ALarg / LLargPx, AAlt / LAltPx);
    LLarg := LLargPx * LEscala;
    LAlt := LAltPx * LEscala;
    if ACentralizar then
      LX := AX + (ALarg - LLarg) / 2
    else
      LX := AX;

    APDF.Image(LX, AY + (AAlt - LAlt) / 2, LLarg,
      LAlt, LStream, 'T', 'L', True);
  finally
    LStream.Free;
  end;
end;

{ Consome o espaco restante da folha (sem desenhar nada visivel), para o engine
  quebrar a folha antes do proximo desenho do bloco. }
procedure ConsumirEspacoFolhaNFeABI(Args: TFPDFBandDrawArgs);
begin
  Args.PDF.SetDrawColor(255, 255, 255);
  Args.PDF.Line(0, Args.FreeSpace, 0.1, Args.FreeSpace);
  Args.DrawAgain := True;
end;

procedure DesenharTituloBlocoNFeABI(APDF: IFPDF; const ATitulo: string; AY: Double);
begin
  FonteTituloNFeABI(APDF);
  TxtEsqNFeABI(APDF, 0, AY + CBASE_TITULO, ATitulo);
end;

{ Desenha uma linha de celulas rotulo/valor: borda superior, bordas laterais,
  separadores verticais e textos. A borda inferior e desenhada pela linha seguinte
  (ou pelo fim do bloco). }
procedure DesenharLinhaCamposNFeABI(APDF: IFPDF; ATop: Double; const ACelulas: TCelulasNFeABI;
  AAltura, ALarg: Double);
var
  I: Integer;
  J: Integer;
  LLinhas: TStringList;
begin
  for I := 0 to High(ACelulas) do
    if ACelulas[I].Fundo then
    begin
      APDF.SetFillColor(242, 242, 242);
      APDF.Rect(ACelulas[I].X1, ATop, ACelulas[I].X2 - ACelulas[I].X1,
        AAltura, 'F');
    end;

  PrepararTracoNFeABI(APDF);
  LinhaHNFeABI(APDF, 0, ALarg, ATop);
  LinhaVNFeABI(APDF, 0, ATop, ATop + AAltura);
  LinhaVNFeABI(APDF, ALarg, ATop, ATop + AAltura);
  for I := 0 to High(ACelulas) do
    if ACelulas[I].X1 > 1 then
      LinhaVNFeABI(APDF, ACelulas[I].X1, ATop, ATop + AAltura);

  LLinhas := TStringList.Create;
  try
    for I := 0 to High(ACelulas) do
    begin
      FonteRotuloNFeABI(APDF);
      TxtEsqNFeABI(APDF, ACelulas[I].X1 + CPAD, ATop + CBASE_ROTULO, ACelulas[I].Rotulo);

      FonteValorNFeABI(APDF);
      QuebrarTextoNFeABI(APDF, ACelulas[I].Valor,
        ACelulas[I].X2 - ACelulas[I].X1 - 2 * CPAD, LLinhas);
      for J := 0 to LLinhas.Count - 1 do
        TxtEsqNFeABI(APDF, ACelulas[I].X1 + CPAD, ATop + CBASE_VALOR + J * CENTRELINHA, LLinhas[J]);
    end;
  finally
    LLinhas.Free;
  end;
end;

{ TTabelaNFeABI }

constructor TTabelaNFeABI.Create;
begin
  inherited Create;
  X0 := 0;
  Larg := CLARG;
end;

procedure TTabelaNFeABI.AddColuna(AXFim: Double; const ARotulo1, ARotulo2: string;
  AAlinhamento: Char; AQuebra: Boolean);
var
  N: Integer;
begin
  N := Length(XFim);
  SetLength(XFim, N + 1);
  SetLength(Rotulo1, N + 1);
  SetLength(Rotulo2, N + 1);
  SetLength(Alinhamento, N + 1);
  SetLength(Quebra, N + 1);
  XFim[N] := AXFim;
  Rotulo1[N] := ARotulo1;
  Rotulo2[N] := ARotulo2;
  Alinhamento[N] := AAlinhamento;
  Quebra[N] := AQuebra;
end;

procedure TTabelaNFeABI.AddLinha(const ACelulas: array of string);
var
  N: Integer;
  I: Integer;
begin
  N := Length(Linhas);
  SetLength(Linhas, N + 1);
  SetLength(Linhas[N], Length(ACelulas));
  for I := 0 to High(ACelulas) do
    Linhas[N][I] := ACelulas[I];
end;

function TTabelaNFeABI.TotalColunas: Integer;
begin
  Result := Length(XFim);
end;

function TTabelaNFeABI.XIni(AColuna: Integer): Double;
begin
  if AColuna <= 0 then
    Result := 0
  else
    Result := XFim[AColuna - 1];
end;

procedure DesenharCabecalhoTabelaNFeABI(APDF: IFPDF; ATabela: TTabelaNFeABI; ATop: Double);
var
  I: Integer;
  LFim: Double;
begin
  LFim := ATabela.X0 + ATabela.Larg;
  APDF.SetFillColor(242, 242, 242);
  APDF.Rect(ATabela.X0, ATop, ATabela.Larg, CALT_CAB_TAB, 'F');

  PrepararTracoNFeABI(APDF);
  LinhaHNFeABI(APDF, ATabela.X0, LFim, ATop);
  LinhaHNFeABI(APDF, ATabela.X0, LFim, ATop + CALT_CAB_TAB);
  LinhaVNFeABI(APDF, ATabela.X0, ATop, ATop + CALT_CAB_TAB);
  LinhaVNFeABI(APDF, LFim, ATop, ATop + CALT_CAB_TAB);

  for I := 0 to ATabela.TotalColunas - 1 do
  begin
    if I > 0 then
      LinhaVNFeABI(APDF, ATabela.X0 + ATabela.XIni(I), ATop, ATop + CALT_CAB_TAB);
    FonteRotuloNFeABI(APDF);
    TxtEsqNFeABI(APDF, ATabela.X0 + ATabela.XIni(I) + CPAD, ATop + CBASE_ROTULO, ATabela.Rotulo1[I]);
    if ATabela.Rotulo2[I] <> '' then
      TxtEsqNFeABI(APDF, ATabela.X0 + ATabela.XIni(I) + CPAD, ATop + CBASE_ROTULO + 2.82,
        ATabela.Rotulo2[I]);
  end;
end;

{ Altura da linha da tabela (uma linha ou mais, conforme a quebra do texto);
  ALinha fora da tabela corresponde a uma linha vazia (altura do modelo de referencia). }
function AlturaLinhaTabelaNFeABI(APDF: IFPDF; ATabela: TTabelaNFeABI; ALinha: Integer): Double;
var
  I: Integer;
  LMax: Integer;
  LLinhas: TStringList;
begin
  if (ALinha < 0) or (ALinha > High(ATabela.Linhas)) then
  begin
    Result := 5.03;
    Exit;
  end;

  LMax := 1;
  LLinhas := TStringList.Create;
  try
    FonteTextoNFeABI(APDF);
    for I := 0 to ATabela.TotalColunas - 1 do
      if ATabela.Quebra[I] and (I <= High(ATabela.Linhas[ALinha])) then
      begin
        QuebrarTextoNFeABI(APDF, ATabela.Linhas[ALinha][I],
          ATabela.XFim[I] - ATabela.XIni(I) - 2 * CPAD, LLinhas);
        if LLinhas.Count > LMax then
          LMax := LLinhas.Count;
      end;
  finally
    LLinhas.Free;
  end;
  Result := CALT_LIN_TAB + (LMax - 1) * CENTRELINHA_TAB;
end;

{ Desenha uma linha da tabela (bordas e textos); ALinha fora da tabela desenha somente as bordas. }
procedure DesenharLinhaTabelaNFeABI(APDF: IFPDF; ATabela: TTabelaNFeABI; ALinha: Integer;
  ATop, AAltura: Double);
var
  I: Integer;
  J: Integer;
  LLinhas: TStringList;
  LX1: Double;
  LX2: Double;
  LFim: Double;
begin
  LFim := ATabela.X0 + ATabela.Larg;
  PrepararTracoNFeABI(APDF);
  LinhaVNFeABI(APDF, ATabela.X0, ATop, ATop + AAltura);
  LinhaVNFeABI(APDF, LFim, ATop, ATop + AAltura);
  LinhaHNFeABI(APDF, ATabela.X0, LFim, ATop + AAltura);
  for I := 1 to ATabela.TotalColunas - 1 do
    LinhaVNFeABI(APDF, ATabela.X0 + ATabela.XIni(I), ATop, ATop + AAltura);

  if (ALinha < 0) or (ALinha > High(ATabela.Linhas)) then
    Exit;

  LLinhas := TStringList.Create;
  try
    FonteTextoNFeABI(APDF);
    for I := 0 to ATabela.TotalColunas - 1 do
    begin
      if I > High(ATabela.Linhas[ALinha]) then
        Continue;

      LX1 := ATabela.X0 + ATabela.XIni(I);
      LX2 := ATabela.X0 + ATabela.XFim[I];

      if ATabela.Quebra[I] then
        QuebrarTextoNFeABI(APDF, ATabela.Linhas[ALinha][I], LX2 - LX1 - 2 * CPAD, LLinhas)
      else
      begin
        LLinhas.Clear;
        LLinhas.Add(ATabela.Linhas[ALinha][I]);
      end;

      for J := 0 to LLinhas.Count - 1 do
        case ATabela.Alinhamento[I] of
          'C': TxtCenNFeABI(APDF, (LX1 + LX2) / 2, ATop + CBASE_LIN_TAB + J * CENTRELINHA_TAB, LLinhas[J]);
          'D': TxtDirNFeABI(APDF, LX2 - 0.88, ATop + CBASE_LIN_TAB + J * CENTRELINHA_TAB, LLinhas[J]);
        else
          TxtEsqNFeABI(APDF, LX1 + CPAD, ATop + CBASE_LIN_TAB + J * CENTRELINHA_TAB, LLinhas[J]);
        end;
    end;
  finally
    LLinhas.Free;
  end;
end;

{ Formatacao dos dados (mesmos recursos usados nos demais DFes) }

function CodigoDescricaoNFeABI(const ACodigo, ADescricao: string): string;
begin
  if ACodigo = '' then
    Result := CVAZIO
  else if ADescricao = '' then
    Result := ACodigo
  else
    Result := ACodigo + ' - ' + ADescricao;
end;

function TextoOuVazioNFeABI(const AValor: string): string;
begin
  if Trim(AValor) = '' then
    Result := CVAZIO
  else
    Result := Trim(AValor);
end;

function NumeroNFeABI(const AFormatSettings: TFormatSettings; AValor: Double;
  ACasas: Integer): string;
begin
  if ACasas > 0 then
    Result := FormatFloat('#,##0.' + StringOfChar('0', ACasas), AValor, AFormatSettings)
  else
    Result := FormatFloat('#,##0', AValor, AFormatSettings);
end;

function MoedaNFeABI(const AFormatSettings: TFormatSettings; AValor: Double): string;
begin
  Result := 'R$ ' + NumeroNFeABI(AFormatSettings, AValor, 2);
end;

function ValorOuVazioNFeABI(const AFormatSettings: TFormatSettings; AValor: Double): string;
begin
  if AValor = 0 then
    Result := CVAZIO
  else
    Result := MoedaNFeABI(AFormatSettings, AValor);
end;

function PercentualNFeABI(const AFormatSettings: TFormatSettings; AValor: Double): string;
begin
  Result := NumeroNFeABI(AFormatSettings, AValor, 4) + '%';
end;

function DataNFeABI(AValor: TDateTime): string;
begin
  if AValor <= 0 then
    Result := CVAZIO
  else
    Result := FormatDateTime('dd/mm/yyyy', AValor);
end;

function DataHoraNFeABI(AValor: TDateTime): string;
begin
  if AValor <= 0 then
    Result := CVAZIO
  else
    Result := FormatDateTime('dd/mm/yyyy hh:nn:ss', AValor);
end;

function DocumentoNFeABI(const ADocumento: string): string;
begin
  if Length(Trim(ADocumento)) > 11 then
    Result := FormatarCNPJ(Trim(ADocumento))
  else if Trim(ADocumento) <> '' then
    Result := FormatarCPF(Trim(ADocumento))
  else
    Result := CVAZIO;
end;

function SimNaoIndNFeABI(AValor: TIndicadorEx): string;
begin
  case AValor of
    tieNao: Result := 'Não';
    tieSim: Result := 'Sim';
  else
    Result := CVAZIO;
  end;
end;

function ContribuinteNFeABI(AValor: TindContrib): string;
begin
  if AValor = icNenhum then
    Result := CVAZIO
  else
    Result := CodigoDescricaoNFeABI(indContribToStr(AValor), CDescIndContribNFeABI[AValor]);
end;

function EnderecoLinha1NFeABI(AEnder: Tendereco): string;
begin
  Result := Trim(AEnder.xLgr);
  if Trim(AEnder.nro) <> '' then
    Result := Result + ', ' + Trim(AEnder.nro);
  if Trim(AEnder.xCpl) <> '' then
    Result := Result + ', ' + Trim(AEnder.xCpl);
  if Trim(AEnder.xBairro) <> '' then
    Result := Result + ' - ' + Trim(AEnder.xBairro);
end;

function EnderecoLinha2NFeABI(AEnder: Tendereco): string;
begin
  Result := Trim(AEnder.xMun);
  if Trim(AEnder.UF) <> '' then
    Result := Result + ' - ' + Trim(AEnder.UF);
  if Trim(AEnder.CEP) <> '' then
    Result := Result + ' - CEP ' + FormatarCEP(Trim(AEnder.CEP));
end;

function NumeroNotaNFeABI(ANumero: Integer): string;
var
  LValor: string;
begin
  LValor := Format('%.9d', [ANumero]);
  Result := Copy(LValor, 1, 3) + '.' + Copy(LValor, 4, 3) + '.' + Copy(LValor, 7, 3);
end;

function ProtocoloNFeABI(ANFeABI: TNFeABI; const AProtocoloInformado: string): string;
begin
  if Trim(ANFeABI.procNFeABI.nProt) <> '' then
    Result := Trim(ANFeABI.procNFeABI.nProt) + ' - ' + DataHoraNFeABI(ANFeABI.procNFeABI.dhRecbto)
  else if Trim(AProtocoloInformado) <> '' then
    Result := Trim(AProtocoloInformado)
  else if ANFeABI.Ide.tpEmis = teContingencia then
    Result := 'EMITIDA EM CONTINGÊNCIA OFF-LINE - PENDENTE DE AUTORIZAÇÃO'
  else
    Result := CVAZIO;
end;

{ Codigo do indicador de contribuinte (formato paisagem apresenta somente o codigo) }
function CodigoContribuinteNFeABI(AValor: TindContrib): string;
begin
  if AValor = icNenhum then
    Result := CVAZIO
  else
    Result := indContribToStr(AValor);
end;

{ Texto das Informacoes complementares: mensagens obrigatorias (item 6.2), dados do
  contribuinte, documentos referenciados e imoveis da torna. }
function TextoComplementarNFeABI(ANFeABI: TNFeABI): string;
var
  I: Integer;
  LImovel: TImovel;
  LDescricao: string;

  procedure AddLinha(const ALinha: string);
  begin
    if Result <> '' then
      Result := Result + #10;
    Result := Result + ALinha;
  end;

begin
  Result := '';

  if ANFeABI.Ide.tpAmb = taHomologacao then
    AddLinha('EMITIDA EM AMBIENTE DE HOMOLOGAÇÃO - SEM VALOR FISCAL');

  if ANFeABI.Ide.tpEmis = teContingencia then
  begin
    LDescricao := 'CONTINGÊNCIA OFF-LINE: entrada em ' + DataHoraNFeABI(ANFeABI.Ide.gCont.dhCont);
    if Trim(ANFeABI.Ide.gCont.xJust) <> '' then
      LDescricao := LDescricao + ' - ' + Trim(ANFeABI.Ide.gCont.xJust);
    AddLinha(LDescricao);
  end;

  if Trim(ANFeABI.InfAdic.infCpl) <> '' then
    AddLinha(StringReplace(Trim(ANFeABI.InfAdic.infCpl), '|', #10, [rfReplaceAll]));

  for I := 0 to ANFeABI.InfAdic.obsCont.Count - 1 do
    AddLinha(ANFeABI.InfAdic.obsCont[I].xCampo + ': ' + ANFeABI.InfAdic.obsCont[I].xTexto);

  if ANFeABI.NFref.Count > 0 then
  begin
    AddLinha('NF-E ABI REFERENCIADA:');
    for I := 0 to ANFeABI.NFref.Count - 1 do
      AddLinha(FormatarChaveAcesso(ANFeABI.NFref[I].refNFeABI));
  end;

  if ANFeABI.gPagAntecipado.Count > 0 then
  begin
    AddLinha('NF-E ABI DE PAGAMENTO ANTECIPADO:');
    for I := 0 to ANFeABI.gPagAntecipado.Count - 1 do
      AddLinha(FormatarChaveAcesso(ANFeABI.gPagAntecipado[I].chNFePagAnt));
  end;

  if (ANFeABI.Ide.tpNF <> tdTransicao) and (ANFeABI.infOper.indTorna = tiSim) and
     (ANFeABI.infOper.gTorna.imovelTorna.Count > 0) then
  begin
    AddLinha('IMÓVEIS TRANSMITIDOS JUNTO COM A TORNA:');
    for I := 0 to ANFeABI.infOper.gTorna.imovelTorna.Count - 1 do
    begin
      LImovel := ANFeABI.infOper.gTorna.imovelTorna[I].imovel;
      LDescricao := IntToStr(I + 1) + ') ' +
        CodigoDescricaoNFeABI(LImovel.espImovel,
          DescCodigoNFeABI(CDescEspImovelNFeABI, StrToIntDef(LImovel.espImovel, 0)));
      if Trim(LImovel.matricTransc) <> '' then
        LDescricao := LDescricao + ' - matrícula ' + Trim(LImovel.matricTransc);
      if Trim(LImovel.enderImovel.xLgr) <> '' then
        LDescricao := LDescricao + ' - ' + Trim(LImovel.enderImovel.xLgr) + ', ' +
          Trim(LImovel.enderImovel.nro);
      if Trim(LImovel.enderImovel.xMun) <> '' then
        LDescricao := LDescricao + ' - ' + Trim(LImovel.enderImovel.xMun) + '/' +
          Trim(LImovel.enderImovel.UF);
      AddLinha(LDescricao);
    end;
  end;
end;

{ Texto do quadro Reservado ao Fisco }
function TextoFiscoNFeABI(ANFeABI: TNFeABI): string;
var
  I: Integer;
begin
  Result := '';
  if Trim(ANFeABI.InfAdic.infAdFisco) <> '' then
    Result := StringReplace(Trim(ANFeABI.InfAdic.infAdFisco), '|', #10, [rfReplaceAll]);
  for I := 0 to ANFeABI.InfAdic.obsFisco.Count - 1 do
  begin
    if Result <> '' then
      Result := Result + #10;
    Result := Result + ANFeABI.InfAdic.obsFisco[I].xCampo + ': ' + ANFeABI.InfAdic.obsFisco[I].xTexto;
  end;
end;

{ Estimativa conservadora (sem PDF) do numero de linhas de um texto na largura (mm) }
function EstimarLinhasNFeABI(const ATexto: string; ALarguraMm: Double): Integer;
var
  LTexto: string;
  LPos: Integer;
  LParagrafo: string;
begin
  Result := 0;
  if Trim(ATexto) = '' then
    Exit;

  LTexto := StringReplace(ATexto, #13#10, #10, [rfReplaceAll]);
  while True do
  begin
    LPos := Pos(#10, LTexto);
    if LPos > 0 then
    begin
      LParagrafo := Copy(LTexto, 1, LPos - 1);
      Delete(LTexto, 1, LPos);
    end
    else
    begin
      LParagrafo := LTexto;
      LTexto := '';
    end;

    Inc(Result, Max(1, Ceil(Length(LParagrafo) * 1.48 / ALarguraMm)));

    if LTexto = '' then
      Break;
  end;
end;

{ TBlocoMarcaDaguaNFeABI }

constructor TBlocoMarcaDaguaNFeABI.Create(ANFeABIUtils: TNFeABIUtilsFPDF; ACancelada: Boolean);
begin
  inherited Create(btWatermark);
  FNFeABIUtils := ANFeABIUtils;
  FCancelada := ACancelada;
end;

procedure TBlocoMarcaDaguaNFeABI.Marca(Args: TFPDFBandDrawArgs; x, y, w, h: Double;
  const ATexto: string; ATamanho: Double);
begin
  Args.PDF.SetTextColor(230, 230, 230);
  Args.PDF.SetFont('Arial', 'B', ATamanho);
  Args.PDF.TextBox(x, y, w, h, ATexto, 'C', 'C', False, False, True);
  Args.PDF.SetTextColor(0, 0, 0);
end;

procedure TBlocoMarcaDaguaNFeABI.OnDraw(Args: TFPDFBandDrawArgs);
var
  LHomologacao: Boolean;
  x, y, w, m: Double;
begin
  LHomologacao := FNFeABIUtils.NFeABI.Ide.tpAmb = taHomologacao;
  if (not LHomologacao) and (not FCancelada) then
    Exit;

  m := 5;
  x := Args.LeftMargin + m;
  w := Width - (2 * m);
  y := RoundTo(Height / 2, 0);

  // Cancelada: acima da marca de homologacao (quando houver)
  if FCancelada then
  begin
    if LHomologacao then
      Marca(Args, x, y - 30, w, 5, 'NOTA CANCELADA', 48)
    else
      Marca(Args, x, y, w, 5, 'NOTA CANCELADA', 48);
  end;

  if LHomologacao then
  begin
    Marca(Args, x, y, w, 5, 'SEM VALOR FISCAL', 48);
    Marca(Args, x, y + 14, w, 5, 'AMBIENTE DE HOMOLOGAÇÃO', 30);
  end;
end;

{ TBlocoCabecalhoNFeABI }

constructor TBlocoCabecalhoNFeABI.Create(ANFeABIUtils: TNFeABIUtilsFPDF;
  const ALogo: AnsiString; AExpandeLogo: Boolean; const AProtocolo: string; APaisagem: Boolean);
begin
  inherited Create(btPageHeader);
  FNFeABIUtils := ANFeABIUtils;
  FPaisagem := APaisagem;
  FLogo := ALogo;
  FExpandeLogo := AExpandeLogo and (ALogo <> '');
  FProtocolo := AProtocolo;
  FTextoX := CPAD;
  if (FLogo <> '') and (not FExpandeLogo) then
    FTextoX := CPAD + CLOGO_LARG + 1.41;
end;

procedure TBlocoCabecalhoNFeABI.OnInit(Args: TFPDFBandInitArgs);
begin
  AutoHeight := True;
  if FPaisagem then
    Height := CALT_TITULO + CALT_BARRA_P + CALT_CAMPO + CALT_CONSULTA_P + 2 * CALT_CAMPO
  else
    Height := CALT_TITULO + CALT_EMITENTE + 3 * CALT_CAMPO;
end;

procedure TBlocoCabecalhoNFeABI.OnDraw(Args: TFPDFBandDrawArgs);
begin
  if FPaisagem then
    DesenharPaisagem(Args)
  else
    DesenharRetrato(Args);
end;

{ Identificacao no formato retrato }

procedure TBlocoCabecalhoNFeABI.DesenharRetrato(Args: TFPDFBandDrawArgs);
var
  LPDF: IFPDF;
  LNFeABI: TNFeABI;
  LCelulas: TCelulasNFeABI;
  LNomeLinhas: TStringList;
  LEnderecoLinhas: TStringList;
  LConsultaLinhas: TStringList;
  LChave: string;
  LTextoModal: string;
  LTextoDetal: string;
  LTextoNatureza: string;
  LTextoTipoEmitente: string;
  LTextoTipoPag: string;
  LTextoProtocolo: string;
  LTextoDataEmissao: string;
  LTextoTipoDoc: string;
  LTextoFinalidade: string;
  LLargEmitente: Double;
  LBaseDoc: Double;
  LAlt1, LAlt2, LAlt3, LAlt4: Double;
  yB, yC, yD, yE: Double;
  LBase: Double;
  LXTitulo: Double;
  LXChave: Double;
  LTotalFolhas: Integer;
  N: Integer;
  I: Integer;
begin
  LPDF := Args.PDF;
  LNFeABI := FNFeABIUtils.NFeABI;
  PrepararTracoNFeABI(LPDF);

  LNomeLinhas := TStringList.Create;
  LEnderecoLinhas := TStringList.Create;
  LConsultaLinhas := TStringList.Create;
  try
    // Textos da identificacao (codigo - descricao da Tabela de Codigos da NF-e ABI)
    LChave := RemoverLiteralChave(LNFeABI.infNFeABI.Id);
    LTextoProtocolo := ProtocoloNFeABI(LNFeABI, FProtocolo);
    LTextoDataEmissao := DataHoraNFeABI(LNFeABI.Ide.dhEmi);
    LTextoTipoDoc := CodigoDescricaoNFeABI(tpNFToStr(LNFeABI.Ide.tpNF),
      CDescTipoNFNFeABI[LNFeABI.Ide.tpNF]);
    LTextoFinalidade := CodigoDescricaoNFeABI(finNFeToStr(LNFeABI.Ide.finNFe),
      CDescFinalidadeNFeABI[LNFeABI.Ide.finNFe]);
    LTextoModal := CodigoDescricaoNFeABI(IntToStrZero(LNFeABI.Ide.gModNat.modOper, 2),
      DescCodigoNFeABI(CDescModOperNFeABI, LNFeABI.Ide.gModNat.modOper));
    LTextoDetal := CodigoDescricaoNFeABI(IntToStrZero(LNFeABI.Ide.gModNat.detOper, 2),
      DescCodigoNFeABI(CDescDetOperNFeABI, LNFeABI.Ide.gModNat.detOper));
    LTextoNatureza := CodigoDescricaoNFeABI(IntToStrZero(LNFeABI.Ide.gModNat.natOper, 2),
      DescCodigoNFeABI(CDescNatOperNFeABI, LNFeABI.Ide.gModNat.natOper));
    LTextoTipoEmitente := CodigoDescricaoNFeABI(tpEmitToStr(LNFeABI.Emit.tpEmit),
      CDescTipoEmitenteNFeABI[LNFeABI.Emit.tpEmit]);
    LTextoTipoPag := CodigoDescricaoNFeABI(tpPagAntABIToStr(LNFeABI.Ide.tpPagAnt),
      CDescTipoPagAntNFeABI[LNFeABI.Ide.tpPagAnt]);

    // Linha 1: emitente (o nome e o endereco podem ocupar mais de uma linha)
    LLargEmitente := CVTIT - FTextoX - CPAD;

    LPDF.SetFont('Arial', 'B', 8.5);
    QuebrarTextoNFeABI(LPDF, Trim(LNFeABI.Emit.xNome), LLargEmitente, LNomeLinhas);
    while LNomeLinhas.Count > 3 do
      LNomeLinhas.Delete(LNomeLinhas.Count - 1);

    FonteTextoNFeABI(LPDF);
    AddQuebradoNFeABI(LPDF, LEnderecoLinhas, EnderecoLinha1NFeABI(LNFeABI.Emit.enderEmit), LLargEmitente);
    AddQuebradoNFeABI(LPDF, LEnderecoLinhas, EnderecoLinha2NFeABI(LNFeABI.Emit.enderEmit), LLargEmitente);
    if FormatarFone(LNFeABI.Emit.enderEmit.fone) <> '' then
      AddQuebradoNFeABI(LPDF, LEnderecoLinhas,
        'Fone: ' + FormatarFone(LNFeABI.Emit.enderEmit.fone), LLargEmitente);

    LBaseDoc := 5.96 + (LNomeLinhas.Count - 1) * 3.6 + 3.07 + LEnderecoLinhas.Count * CENTRELINHA;
    LAlt1 := Max(CALT_EMITENTE, LBaseDoc + 5.79);

    // Linhas 2 a 4: altura conforme o texto
    N := LinhasValorNFeABI(LPDF, LTextoProtocolo, CVTIT);
    N := Max(N, LinhasValorNFeABI(LPDF, LTextoDataEmissao, CVCH - CVTIT));
    N := Max(N, LinhasValorNFeABI(LPDF, LTextoTipoDoc, CVFIN - CVCH));
    N := Max(N, LinhasValorNFeABI(LPDF, LTextoFinalidade, CLARG - CVFIN));
    LAlt2 := AlturaLinhaCamposNFeABI(N);

    N := LinhasValorNFeABI(LPDF, LTextoModal, CVMOD);
    N := Max(N, LinhasValorNFeABI(LPDF, LTextoDetal, CVCH - CVMOD));
    N := Max(N, LinhasValorNFeABI(LPDF, LTextoTipoEmitente, CLARG - CVCH));
    LAlt3 := AlturaLinhaCamposNFeABI(N);

    N := LinhasValorNFeABI(LPDF, LTextoNatureza, CVCH);
    N := Max(N, LinhasValorNFeABI(LPDF, LTextoTipoPag, CLARG - CVCH));
    LAlt4 := AlturaLinhaCamposNFeABI(N);

    yB := CALT_TITULO + LAlt1;
    yC := yB + LAlt2;
    yD := yC + LAlt3;
    yE := yD + LAlt4;

    DesenharTituloBlocoNFeABI(LPDF, 'IDENTIFICAÇÃO DA NF-E ABI', 0);

    // Moldura da linha 1 (emitente, titulo e chave de acesso)
    PrepararTracoNFeABI(LPDF);
    LinhaHNFeABI(LPDF, 0, CLARG, CALT_TITULO);
    LinhaVNFeABI(LPDF, 0, CALT_TITULO, yE);
    LinhaVNFeABI(LPDF, CLARG, CALT_TITULO, yE);
    LinhaVNFeABI(LPDF, CVTIT, CALT_TITULO, yC);
    LinhaVNFeABI(LPDF, CVCH, CALT_TITULO, yE);
    LinhaHNFeABI(LPDF, CVCH, CLARG, CALT_TITULO + 10.28);
    LinhaHNFeABI(LPDF, CVCH, CLARG, CALT_TITULO + 16.15);

    // Emitente (logo a esquerda, como nos demais DFes)
    FonteRotuloNFeABI(LPDF);
    TxtEsqNFeABI(LPDF, CPAD, CALT_TITULO + CBASE_ROTULO, 'EMITENTE');

    if FLogo <> '' then
    begin
      if FExpandeLogo then
        DesenharLogoNoQuadroNFeABI(LPDF, FLogo, CPAD, CALT_TITULO + 3.53, CVTIT - 2 * CPAD, LAlt1 - 4.59, True)
      else
        DesenharLogoNoQuadroNFeABI(LPDF, FLogo, CPAD, CALT_TITULO + 3.53, CLOGO_LARG, CLOGO_ALT, False);
    end;

    if not FExpandeLogo then
    begin
      LPDF.SetFont('Arial', 'B', 8.5);
      LPDF.SetTextColor(0, 0, 0);
      LBase := CALT_TITULO + 5.96;
      for I := 0 to LNomeLinhas.Count - 1 do
      begin
        TxtEsqNFeABI(LPDF, FTextoX, LBase, LNomeLinhas[I]);
        if I < LNomeLinhas.Count - 1 then
          LBase := LBase + 3.6;
      end;

      FonteTextoNFeABI(LPDF);
      LBase := LBase + 3.07;
      for I := 0 to LEnderecoLinhas.Count - 1 do
      begin
        TxtEsqNFeABI(LPDF, FTextoX, LBase, LEnderecoLinhas[I]);
        LBase := LBase + CENTRELINHA;
      end;

      FonteTituloNFeABI(LPDF);
      if Length(Trim(LNFeABI.Emit.CNPJCPF)) > 11 then
        TxtEsqNFeABI(LPDF, FTextoX, LBase, 'CNPJ: ' + DocumentoNFeABI(LNFeABI.Emit.CNPJCPF))
      else
        TxtEsqNFeABI(LPDF, FTextoX, LBase, 'CPF: ' + DocumentoNFeABI(LNFeABI.Emit.CNPJCPF));
    end;

    // Titulo, numero, serie e folha
    LXTitulo := (CVTIT + CVCH) / 2;
    LPDF.SetFont('Arial', 'B', 12);
    TxtCenNFeABI(LPDF, LXTitulo, CALT_TITULO + 6.25, 'DANFE-ABI');

    LPDF.SetFont('Arial', '', 6);
    TxtCenNFeABI(LPDF, LXTitulo, CALT_TITULO + 9.29, 'Documento Auxiliar da Nota Fiscal');
    TxtCenNFeABI(LPDF, LXTitulo, CALT_TITULO + 11.75, 'Eletrônica de Alienação de Bens Imóveis');

    LPDF.SetFont('Arial', 'B', 7.5);
    TxtCenNFeABI(LPDF, LXTitulo, CALT_TITULO + 14.85, 'Nº ' + NumeroNotaNFeABI(LNFeABI.Ide.nNF));
    TxtCenNFeABI(LPDF, LXTitulo, CALT_TITULO + 18.06, 'SÉRIE ' + Format('%.3d', [LNFeABI.Ide.serie]));

    LTotalFolhas := Args.TotalPages;
    if LTotalFolhas < LPDF.CurrentPage then
      LTotalFolhas := LPDF.CurrentPage;
    LPDF.SetFont('Arial', '', 6.5);
    TxtCenNFeABI(LPDF, LXTitulo, CALT_TITULO + 20.92, 'FOLHA ' + IntToStr(LPDF.CurrentPage) + '/' +
      IntToStr(LTotalFolhas));

    // Codigo de barras (Code 128) e chave de acesso
    if LChave <> '' then
    begin
      LPDF.SetFillColor(0, 0, 0);
      LPDF.Code128(LChave, CVCH + 2.84, CALT_TITULO + 0.71, 9.0, 61.88);
    end;

    FonteRotuloNFeABI(LPDF);
    TxtEsqNFeABI(LPDF, CVCH + CPAD + 0.07, CALT_TITULO + 10.28 + CBASE_ROTULO, 'CHAVE DE ACESSO');

    LXChave := (CVCH + CLARG) / 2;
    LPDF.SetFont('Arial', 'B', 6);
    LPDF.SetTextColor(0, 0, 0);
    TxtCenNFeABI(LPDF, LXChave, CALT_TITULO + 15.39, FormatarChaveAcesso(LChave));

    LPDF.SetFont('Arial', '', 6);
    QuebrarTextoNFeABI(LPDF, 'Consulta de autenticidade no Portal da NF-e ABI, pela chave de acesso ' +
      'ou pela leitura do QR Code, em', CLARG - CVCH - 2 * CPAD, LConsultaLinhas);
    LConsultaLinhas.Add('www.fazenda.pr.gov.br/nfeabi');
    for I := 0 to LConsultaLinhas.Count - 1 do
      TxtCenNFeABI(LPDF, LXChave, CALT_TITULO + 18.27 + I * 2.42, LConsultaLinhas[I]);

    // Linha 2
    LCelulas := nil;
    AddCelNFeABI(LCelulas, 0, CVTIT, 'PROTOCOLO DE AUTORIZAÇÃO DE USO', LTextoProtocolo);
    AddCelNFeABI(LCelulas, CVTIT, CVCH, 'DATA E HORA DE EMISSÃO', LTextoDataEmissao);
    AddCelNFeABI(LCelulas, CVCH, CVFIN, 'TIPO DO DOCUMENTO', LTextoTipoDoc);
    AddCelNFeABI(LCelulas, CVFIN, CLARG, 'FINALIDADE', LTextoFinalidade);
    DesenharLinhaCamposNFeABI(LPDF, yB, LCelulas, LAlt2, CLARG);

    // Linha 3
    LCelulas := nil;
    AddCelNFeABI(LCelulas, 0, CVMOD, 'MODALIDADE DA OPERAÇÃO', LTextoModal);
    AddCelNFeABI(LCelulas, CVMOD, CVCH, 'DETALHAMENTO DA OPERAÇÃO', LTextoDetal);
    AddCelNFeABI(LCelulas, CVCH, CLARG, 'TIPO DO EMITENTE', LTextoTipoEmitente);
    DesenharLinhaCamposNFeABI(LPDF, yC, LCelulas, LAlt3, CLARG);

    // Linha 4
    LCelulas := nil;
    AddCelNFeABI(LCelulas, 0, CVCH, 'NATUREZA DA OPERAÇÃO', LTextoNatureza);
    AddCelNFeABI(LCelulas, CVCH, CLARG, 'TIPO DE PAGAMENTO', LTextoTipoPag);
    DesenharLinhaCamposNFeABI(LPDF, yD, LCelulas, LAlt4, CLARG);

    PrepararTracoNFeABI(LPDF);
    LinhaHNFeABI(LPDF, 0, CLARG, yE);
  finally
    LNomeLinhas.Free;
    LEnderecoLinhas.Free;
    LConsultaLinhas.Free;
  end;
end;

{ Identificacao no formato paisagem (item 6.10 da NT 2026.001) }

procedure TBlocoCabecalhoNFeABI.DesenharPaisagem(Args: TFPDFBandDrawArgs);
var
  LPDF: IFPDF;
  LNFeABI: TNFeABI;
  LCelulas: TCelulasNFeABI;
  LNomeLinhas: TStringList;
  LEnderecoLinhas: TStringList;
  LConsultaLinhas: TStringList;
  LChave: string;
  LTextoProtocolo: string;
  LTextoDataEmissao: string;
  LTextoTipoDoc: string;
  LTextoFinalidade: string;
  LTextoModal: string;
  LTextoDetal: string;
  LTextoNatureza: string;
  LTextoTipoEmitente: string;
  LTextoTipoPag: string;
  LLargEmitente: Double;
  LBaseDoc: Double;
  LAlt1, LAlt2, LAlt3: Double;
  yB, yC, yD: Double;
  LBase: Double;
  LXTitulo: Double;
  LXChave: Double;
  LTotalFolhas: Integer;
  N: Integer;
  I: Integer;
begin
  LPDF := Args.PDF;
  LNFeABI := FNFeABIUtils.NFeABI;
  PrepararTracoNFeABI(LPDF);

  LNomeLinhas := TStringList.Create;
  LEnderecoLinhas := TStringList.Create;
  LConsultaLinhas := TStringList.Create;
  try
    // Textos da identificacao (codigo - descricao da Tabela de Codigos da NF-e ABI)
    LChave := RemoverLiteralChave(LNFeABI.infNFeABI.Id);
    LTextoProtocolo := ProtocoloNFeABI(LNFeABI, FProtocolo);
    LTextoDataEmissao := DataHoraNFeABI(LNFeABI.Ide.dhEmi);
    LTextoTipoDoc := CodigoDescricaoNFeABI(tpNFToStr(LNFeABI.Ide.tpNF),
      CDescTipoNFNFeABI[LNFeABI.Ide.tpNF]);
    LTextoFinalidade := CodigoDescricaoNFeABI(finNFeToStr(LNFeABI.Ide.finNFe),
      CDescFinalidadeNFeABI[LNFeABI.Ide.finNFe]);
    LTextoModal := CodigoDescricaoNFeABI(IntToStrZero(LNFeABI.Ide.gModNat.modOper, 2),
      DescCodigoNFeABI(CDescModOperNFeABI, LNFeABI.Ide.gModNat.modOper));
    LTextoDetal := CodigoDescricaoNFeABI(IntToStrZero(LNFeABI.Ide.gModNat.detOper, 2),
      DescCodigoNFeABI(CDescDetOperNFeABI, LNFeABI.Ide.gModNat.detOper));
    LTextoNatureza := CodigoDescricaoNFeABI(IntToStrZero(LNFeABI.Ide.gModNat.natOper, 2),
      DescCodigoNFeABI(CDescNatOperNFeABI, LNFeABI.Ide.gModNat.natOper));
    LTextoTipoEmitente := CodigoDescricaoNFeABI(tpEmitToStr(LNFeABI.Emit.tpEmit),
      CDescTipoEmitenteNFeABI[LNFeABI.Emit.tpEmit]);
    LTextoTipoPag := CodigoDescricaoNFeABI(tpPagAntABIToStr(LNFeABI.Ide.tpPagAnt),
      CDescTipoPagAntNFeABI[LNFeABI.Ide.tpPagAnt]);

    // Linha 1: emitente (o nome e o endereco podem ocupar mais de uma linha)
    LLargEmitente := PX08 - FTextoX - CPAD;

    LPDF.SetFont('Arial', 'B', 8.5);
    QuebrarTextoNFeABI(LPDF, Trim(LNFeABI.Emit.xNome), LLargEmitente, LNomeLinhas);
    while LNomeLinhas.Count > 3 do
      LNomeLinhas.Delete(LNomeLinhas.Count - 1);

    FonteTextoNFeABI(LPDF);
    AddQuebradoNFeABI(LPDF, LEnderecoLinhas, EnderecoLinha1NFeABI(LNFeABI.Emit.enderEmit), LLargEmitente);
    AddQuebradoNFeABI(LPDF, LEnderecoLinhas, EnderecoLinha2NFeABI(LNFeABI.Emit.enderEmit), LLargEmitente);
    if FormatarFone(LNFeABI.Emit.enderEmit.fone) <> '' then
      AddQuebradoNFeABI(LPDF, LEnderecoLinhas,
        'Fone: ' + FormatarFone(LNFeABI.Emit.enderEmit.fone), LLargEmitente);

    LBaseDoc := 5.96 + (LNomeLinhas.Count - 1) * 3.6 + 3.07 + LEnderecoLinhas.Count * CENTRELINHA;
    LAlt1 := Max(CALT_BARRA_P + CALT_CAMPO + CALT_CONSULTA_P, LBaseDoc + 3.95);

    // Linhas 2 e 3: altura conforme o texto
    N := LinhasValorNFeABI(LPDF, LTextoProtocolo, PX06);
    N := Max(N, LinhasValorNFeABI(LPDF, LTextoDataEmissao, PX10 - PX06));
    N := Max(N, LinhasValorNFeABI(LPDF, LTextoTipoDoc, PX13 - PX10));
    N := Max(N, LinhasValorNFeABI(LPDF, LTextoFinalidade, PX16 - PX13));
    N := Max(N, LinhasValorNFeABI(LPDF, LTextoTipoEmitente, PX21 - PX16));
    N := Max(N, LinhasValorNFeABI(LPDF, LTextoTipoPag, CLARG_P - PX21));
    LAlt2 := AlturaLinhaCamposNFeABI(N);

    N := LinhasValorNFeABI(LPDF, LTextoModal, PX05);
    N := Max(N, LinhasValorNFeABI(LPDF, LTextoDetal, PX12 - PX05));
    N := Max(N, LinhasValorNFeABI(LPDF, LTextoNatureza, CLARG_P - PX12));
    LAlt3 := AlturaLinhaCamposNFeABI(N);

    yB := CALT_TITULO + LAlt1;
    yC := yB + LAlt2;
    yD := yC + LAlt3;

    DesenharTituloBlocoNFeABI(LPDF, 'IDENTIFICAÇÃO DA NF-E ABI', 0);

    // Moldura da linha 1 (emitente, titulo e chave de acesso)
    PrepararTracoNFeABI(LPDF);
    LinhaHNFeABI(LPDF, 0, CLARG_P, CALT_TITULO);
    LinhaVNFeABI(LPDF, 0, CALT_TITULO, yB);
    LinhaVNFeABI(LPDF, CLARG_P, CALT_TITULO, yB);
    LinhaVNFeABI(LPDF, PX08, CALT_TITULO, yB);
    LinhaVNFeABI(LPDF, PX14, CALT_TITULO, yB);
    LinhaHNFeABI(LPDF, PX14, CLARG_P, CALT_TITULO + CALT_BARRA_P);
    LinhaHNFeABI(LPDF, PX14, CLARG_P, CALT_TITULO + CALT_BARRA_P + CALT_CAMPO);

    // Emitente (logo a esquerda, como nos demais DFes)
    FonteRotuloNFeABI(LPDF);
    TxtEsqNFeABI(LPDF, CPAD, CALT_TITULO + CBASE_ROTULO, 'EMITENTE');

    if FLogo <> '' then
    begin
      if FExpandeLogo then
        DesenharLogoNoQuadroNFeABI(LPDF, FLogo, CPAD, CALT_TITULO + 3.53, PX08 - 2 * CPAD, LAlt1 - 4.59, True)
      else
        DesenharLogoNoQuadroNFeABI(LPDF, FLogo, CPAD, CALT_TITULO + 3.53, CLOGO_LARG, CLOGO_ALT, False);
    end;

    if not FExpandeLogo then
    begin
      LPDF.SetFont('Arial', 'B', 8.5);
      LPDF.SetTextColor(0, 0, 0);
      LBase := CALT_TITULO + 5.96;
      for I := 0 to LNomeLinhas.Count - 1 do
      begin
        TxtEsqNFeABI(LPDF, FTextoX, LBase, LNomeLinhas[I]);
        if I < LNomeLinhas.Count - 1 then
          LBase := LBase + 3.6;
      end;

      FonteTextoNFeABI(LPDF);
      LBase := LBase + 3.07;
      for I := 0 to LEnderecoLinhas.Count - 1 do
      begin
        TxtEsqNFeABI(LPDF, FTextoX, LBase, LEnderecoLinhas[I]);
        LBase := LBase + CENTRELINHA;
      end;

      FonteTituloNFeABI(LPDF);
      if Length(Trim(LNFeABI.Emit.CNPJCPF)) > 11 then
        TxtEsqNFeABI(LPDF, FTextoX, LBase, 'CNPJ: ' + DocumentoNFeABI(LNFeABI.Emit.CNPJCPF))
      else
        TxtEsqNFeABI(LPDF, FTextoX, LBase, 'CPF: ' + DocumentoNFeABI(LNFeABI.Emit.CNPJCPF));
    end;

    // Titulo, numero, serie e folha
    LXTitulo := (PX08 + PX14) / 2;
    LPDF.SetFont('Arial', 'B', 12);
    TxtCenNFeABI(LPDF, LXTitulo, CALT_TITULO + 5.31, 'DANFE-ABI');

    LPDF.SetFont('Arial', '', 6);
    TxtCenNFeABI(LPDF, LXTitulo, CALT_TITULO + 8.4, 'Documento Auxiliar da Nota Fiscal Eletrônica de Alienação de Bens');
    TxtCenNFeABI(LPDF, LXTitulo, CALT_TITULO + 10.87, 'Imóveis');

    LPDF.SetFont('Arial', 'B', 7.5);
    TxtCenNFeABI(LPDF, LXTitulo, CALT_TITULO + 13.9, 'Nº ' + NumeroNotaNFeABI(LNFeABI.Ide.nNF));
    TxtCenNFeABI(LPDF, LXTitulo, CALT_TITULO + 17.14, 'SÉRIE ' + Format('%.3d', [LNFeABI.Ide.serie]));

    LTotalFolhas := Args.TotalPages;
    if LTotalFolhas < LPDF.CurrentPage then
      LTotalFolhas := LPDF.CurrentPage;
    LPDF.SetFont('Arial', '', 6.5);
    TxtCenNFeABI(LPDF, LXTitulo, CALT_TITULO + 20.07, 'FOLHA ' + IntToStr(LPDF.CurrentPage) + '/' +
      IntToStr(LTotalFolhas));

    // Codigo de barras (Code 128) e chave de acesso
    if LChave <> '' then
    begin
      LPDF.SetFillColor(0, 0, 0);
      LPDF.Code128(LChave, PX14 + (CLARG_P - PX14 - 79.83) / 2, CALT_TITULO + 0.85,
        9.0, 79.83);
    end;

    FonteRotuloNFeABI(LPDF);
    TxtEsqNFeABI(LPDF, PX14 + CPAD + 0.07, CALT_TITULO + CALT_BARRA_P + CBASE_ROTULO, 'CHAVE DE ACESSO');

    LXChave := (PX14 + CLARG_P) / 2;
    FonteValorNFeABI(LPDF);
    TxtCenNFeABI(LPDF, LXChave, CALT_TITULO + CALT_BARRA_P + CBASE_VALOR, FormatarChaveAcesso(LChave));

    LPDF.SetFont('Arial', '', 6);
    QuebrarTextoNFeABI(LPDF, 'Consulta de autenticidade no Portal da NF-e ABI, pela chave de acesso ' +
      'ou pela leitura do QR Code, em', CLARG_P - PX14 - 2 * CPAD, LConsultaLinhas);
    LConsultaLinhas.Add('www.fazenda.pr.gov.br/nfeabi');
    for I := 0 to LConsultaLinhas.Count - 1 do
      TxtCenNFeABI(LPDF, LXChave, CALT_TITULO + CALT_BARRA_P + CALT_CAMPO + 2.12 + I * 2.47, LConsultaLinhas[I]);

    // Linha 2
    LCelulas := nil;
    AddCelNFeABI(LCelulas, 0, PX06, 'PROTOCOLO DE AUTORIZAÇÃO DE USO', LTextoProtocolo);
    AddCelNFeABI(LCelulas, PX06, PX10, 'DATA E HORA DE EMISSÃO', LTextoDataEmissao);
    AddCelNFeABI(LCelulas, PX10, PX13, 'TIPO DO DOCUMENTO', LTextoTipoDoc);
    AddCelNFeABI(LCelulas, PX13, PX16, 'FINALIDADE', LTextoFinalidade);
    AddCelNFeABI(LCelulas, PX16, PX21, 'TIPO DO EMITENTE', LTextoTipoEmitente);
    AddCelNFeABI(LCelulas, PX21, CLARG_P, 'TIPO DE PAGAMENTO', LTextoTipoPag);
    DesenharLinhaCamposNFeABI(LPDF, yB, LCelulas, LAlt2, CLARG_P);

    // Linha 3
    LCelulas := nil;
    AddCelNFeABI(LCelulas, 0, PX05, 'MODALIDADE DA OPERAÇÃO', LTextoModal);
    AddCelNFeABI(LCelulas, PX05, PX12, 'DETALHAMENTO DA OPERAÇÃO', LTextoDetal);
    AddCelNFeABI(LCelulas, PX12, CLARG_P, 'NATUREZA DA OPERAÇÃO', LTextoNatureza);
    DesenharLinhaCamposNFeABI(LPDF, yC, LCelulas, LAlt3, CLARG_P);

    PrepararTracoNFeABI(LPDF);
    LinhaHNFeABI(LPDF, 0, CLARG_P, yD);
  finally
    LNomeLinhas.Free;
    LEnderecoLinhas.Free;
    LConsultaLinhas.Free;
  end;
end;

{ TBlocoTabelaNFeABI }

constructor TBlocoTabelaNFeABI.Create(ANFeABIUtils: TNFeABIUtilsFPDF; APaisagem: Boolean);
begin
  inherited Create(btData);
  FNFeABIUtils := ANFeABIUtils;
  FPaisagem := APaisagem;
end;

destructor TBlocoTabelaNFeABI.Destroy;
begin
  FTabela.Free;
  inherited;
end;

procedure TBlocoTabelaNFeABI.OnInit(Args: TFPDFBandInitArgs);
begin
  FProximo := 0;
  AutoHeight := True;
  FreeAndNil(FTabela);
  FTabela := CriarTabela;
  Visible := Length(FTabela.Linhas) > 0;
  Height := CALT_TITULO + CALT_CAB_TAB + CALT_LIN_TAB;
end;

procedure TBlocoTabelaNFeABI.OnDraw(Args: TFPDFBandDrawArgs);
var
  LPDF: IFPDF;
  LY: Double;
  LAltura: Double;
  LDesenhadas: Integer;
  LTitulo: string;
begin
  LPDF := Args.PDF;
  PrepararTracoNFeABI(LPDF);

  LTitulo := FTabela.Titulo;
  if FProximo > 0 then
    LTitulo := LTitulo + ' (CONTINUAÇÃO)';
  DesenharTituloBlocoNFeABI(LPDF, LTitulo, 0);
  DesenharCabecalhoTabelaNFeABI(LPDF, FTabela, CALT_TITULO);

  LY := CALT_TITULO + CALT_CAB_TAB;
  LDesenhadas := 0;
  while FProximo < Length(FTabela.Linhas) do
  begin
    LAltura := AlturaLinhaTabelaNFeABI(LPDF, FTabela, FProximo);
    if (LDesenhadas > 0) and (LY + LAltura > Args.FreeSpace) then
      Break;

    DesenharLinhaTabelaNFeABI(LPDF, FTabela, FProximo, LY, LAltura);
    LY := LY + LAltura;
    Inc(FProximo);
    Inc(LDesenhadas);
  end;

  Args.DrawAgain := FProximo < Length(FTabela.Linhas);
end;

{ Colunas das tabelas de transmitentes/adquirentes e de pagamento, por formato }

procedure DefinirColunasPartesRetrato(ATabela: TTabelaNFeABI; const ARotulo1, ARotulo2: string);
begin
  ATabela.AddColuna(7.4, 'Nº', '', 'C', False);
  ATabela.AddColuna(40.89, 'CPF/CNPJ', '', 'E', False);
  ATabela.AddColuna(115.82, 'NOME / RAZÃO SOCIAL', '', 'E', True);
  ATabela.AddColuna(142.25, ARotulo1, ARotulo2, 'D', False);
  ATabela.AddColuna(170.41, 'CONTRIBUINTE IBS/CBS', '', 'C', True);
  ATabela.AddColuna(CLARG, 'DECLARANTE', '', 'C', False);
end;

procedure DefinirColunasPartesPaisagem(ATabela: TTabelaNFeABI; const ARotulo1, ARotulo2: string);
begin
// Metade da largura (12 das 24 colunas), lado a lado com os adquirentes
  ATabela.Larg := PX12;
  ATabela.AddColuna(PX01, 'Nº', '', 'C', False);
  ATabela.AddColuna(PX04, 'CPF/CNPJ', '', 'E', False);
  ATabela.AddColuna(PX08, 'NOME / RAZÃO SOCIAL', '', 'E', True);
  ATabela.AddColuna(PX10, ARotulo1, ARotulo2, 'D', False);
  ATabela.AddColuna(PX11, 'CONTRIB.', '', 'C', False);
  ATabela.AddColuna(PX12, 'DECL.', '', 'C', False);
end;

procedure DefinirColunasPartesNFeABI(ATabela: TTabelaNFeABI; APaisagem: Boolean;
  const ARotulo1, ARotulo2: string);
begin
  if APaisagem then
    DefinirColunasPartesPaisagem(ATabela, ARotulo1, ARotulo2)
  else
    DefinirColunasPartesRetrato(ATabela, ARotulo1, ARotulo2);
end;

procedure DefinirColunasPagamentoRetrato(ATabela: TTabelaNFeABI);
begin
  ATabela.AddColuna(7.4, 'Nº', '', 'C', False);
  ATabela.AddColuna(59.97, 'TIPO DE PAGAMENTO / DE PARCELA', '', 'E', True);
  ATabela.AddColuna(142.25, 'DESCRIÇÃO / OBSERVAÇÕES', '', 'E', True);
  ATabela.AddColuna(CLARG, 'VALOR / PARCELAS', '', 'D', False);
end;

procedure DefinirColunasPagamentoPaisagem(ATabela: TTabelaNFeABI);
begin
  ATabela.Larg := CLARG_P;
  ATabela.AddColuna(PX01, 'Nº', '', 'C', False);
  ATabela.AddColuna(PX08, 'TIPO DE PAGAMENTO / DE PARCELA', '', 'E', True);
  ATabela.AddColuna(PX18, 'DESCRIÇÃO / OBSERVAÇÕES', '', 'E', True);
  ATabela.AddColuna(CLARG_P, 'VALOR / PARCELAS', '', 'D', False);
end;

procedure DefinirColunasPagamentoNFeABI(ATabela: TTabelaNFeABI; APaisagem: Boolean);
begin
  if APaisagem then
    DefinirColunasPagamentoPaisagem(ATabela)
  else
    DefinirColunasPagamentoRetrato(ATabela);
end;

{ Texto da coluna Contribuinte IBS/CBS: codigo no paisagem, codigo e descricao no retrato }

function TextoContribuinteNFeABI(AInd: TindContrib; APaisagem: Boolean): string;
begin
  if APaisagem then
    Result := CodigoContribuinteNFeABI(AInd)
  else
    Result := ContribuinteNFeABI(AInd);
end;

{ Tabelas de transmitentes, adquirentes e pagamento (retrato e paisagem) }

function CriarTabelaTransmitentesNFeABI(ANFeABIUtils: TNFeABIUtilsFPDF;
  APaisagem: Boolean): TTabelaNFeABI;
var
  I: Integer;
  LNFeABI: TNFeABI;
  LItem: TTransmitCollectionItem;
  LNumero: string;
  LPercentual: string;
  LContribuinte: string;
begin
  LNFeABI := ANFeABIUtils.NFeABI;

  Result := TTabelaNFeABI.Create;
  Result.Titulo := 'TRANSMITENTES';
  DefinirColunasPartesNFeABI(Result, APaisagem, 'PROPORÇÃO', 'TRANSMITIDA');

  for I := 0 to LNFeABI.Transmit.Count - 1 do
  begin
    LItem := LNFeABI.Transmit[I];
    LNumero := IntToStr(I + 1);
    if LNFeABI.Ide.tpNF = tdCompleto then
      LPercentual := PercentualNFeABI(ANFeABIUtils.FormatSettings, LItem.pTransIndiv)
    else
      LPercentual := CVAZIO;
    LContribuinte := TextoContribuinteNFeABI(LItem.indContrib, APaisagem);

    Result.AddLinha([LNumero, DocumentoNFeABI(LItem.CNPJCPF), LItem.xNome, LPercentual,
      LContribuinte, SimNaoIndNFeABI(LItem.indDeclarante)]);
  end;
end;

function CriarTabelaAdquirentesNFeABI(ANFeABIUtils: TNFeABIUtilsFPDF;
  APaisagem: Boolean): TTabelaNFeABI;
var
  I: Integer;
  LNFeABI: TNFeABI;
  LItem: TAdquirenteCollectionItem;
  LNumero: string;
  LPercentual: string;
  LContribuinte: string;
begin
  LNFeABI := ANFeABIUtils.NFeABI;

  Result := TTabelaNFeABI.Create;
  Result.Titulo := 'ADQUIRENTES';
  DefinirColunasPartesNFeABI(Result, APaisagem, 'PERCENTUAL DE', 'AQUISIÇÃO');

  for I := 0 to LNFeABI.Adquirente.Count - 1 do
  begin
    LItem := LNFeABI.Adquirente[I];
    LNumero := IntToStr(I + 1);
    if LItem.pAquisicao <> 0 then
      LPercentual := PercentualNFeABI(ANFeABIUtils.FormatSettings, LItem.pAquisicao)
    else
      LPercentual := CVAZIO;
    LContribuinte := TextoContribuinteNFeABI(LItem.indContrib, APaisagem);

    Result.AddLinha([LNumero, DocumentoNFeABI(LItem.CNPJCPF), LItem.xNome, LPercentual,
      LContribuinte, SimNaoIndNFeABI(LItem.indDeclarante)]);
  end;
end;

function CriarTabelaPagamentoNFeABI(ANFeABIUtils: TNFeABIUtilsFPDF;
  APaisagem: Boolean): TTabelaNFeABI;
var
  I: Integer;
  LNFeABI: TNFeABI;
  LImovel: TDetPagImovelCollectionItem;
  LLote: TDetPagIncorpLoteCollectionItem;
begin
  LNFeABI := ANFeABIUtils.NFeABI;

  Result := TTabelaNFeABI.Create;
  Result.Titulo := 'PAGAMENTO INICIALMENTE PREVISTO';
  DefinirColunasPagamentoNFeABI(Result, APaisagem);

  // O grupo pag nao e aberto na NF-e ABI de transicao
  if LNFeABI.Ide.tpNF = tdTransicao then
    Exit;

  for I := 0 to LNFeABI.pag.detPagImovel.Count - 1 do
  begin
    LImovel := LNFeABI.pag.detPagImovel[I];
    Result.AddLinha([IntToStr(I + 1),
      CodigoDescricaoNFeABI(IntToStrZero(LImovel.tPag, 2), DescCodigoNFeABI(CDescTPagNFeABI, LImovel.tPag)),
      TextoOuVazioNFeABI(LImovel.xPag), MoedaNFeABI(ANFeABIUtils.FormatSettings, LImovel.vPag)]);
  end;

  for I := 0 to LNFeABI.pag.detPagIncorpLote.Count - 1 do
  begin
    LLote := LNFeABI.pag.detPagIncorpLote[I];
    Result.AddLinha([IntToStr(I + 1),
      TextoOuVazioNFeABI(LLote.tParcela),
      TextoOuVazioNFeABI(LLote.xParcela), IntToStr(LLote.nParcela) + ' parcela(s)']);
  end;
end;

{ TBlocoTransmitentesNFeABI }

function TBlocoTransmitentesNFeABI.CriarTabela: TTabelaNFeABI;
begin
  Result := CriarTabelaTransmitentesNFeABI(FNFeABIUtils, FPaisagem);
end;

{ TBlocoAdquirentesNFeABI }

function TBlocoAdquirentesNFeABI.CriarTabela: TTabelaNFeABI;
begin
  Result := CriarTabelaAdquirentesNFeABI(FNFeABIUtils, FPaisagem);
end;

{ TBlocoPagamentoNFeABI }

function TBlocoPagamentoNFeABI.CriarTabela: TTabelaNFeABI;
begin
  Result := CriarTabelaPagamentoNFeABI(FNFeABIUtils, FPaisagem);
end;

{ TBlocoPartesNFeABI }

constructor TBlocoPartesNFeABI.Create(ANFeABIUtils: TNFeABIUtilsFPDF);
begin
  inherited Create(btData);
  FNFeABIUtils := ANFeABIUtils;
end;

destructor TBlocoPartesNFeABI.Destroy;
begin
  FTransmit.Free;
  FAdquirente.Free;
  inherited;
end;

procedure TBlocoPartesNFeABI.OnInit(Args: TFPDFBandInitArgs);
begin
  FProximo := 0;
  AutoHeight := True;
  FreeAndNil(FTransmit);
  FreeAndNil(FAdquirente);
  FTransmit := CriarTabelaTransmitentesNFeABI(FNFeABIUtils, True);
  FAdquirente := CriarTabelaAdquirentesNFeABI(FNFeABIUtils, True);
  FAdquirente.X0 := PX12;
  Visible := (Length(FTransmit.Linhas) + Length(FAdquirente.Linhas)) > 0;
  Height := CALT_TITULO + CALT_BANDA_TAB + CALT_CAB_TAB + CALT_LIN_TAB;
end;

procedure TBlocoPartesNFeABI.OnDraw(Args: TFPDFBandDrawArgs);
var
  LPDF: IFPDF;
  LY: Double;
  LAltura: Double;
  LTotal: Integer;
  LDesenhadas: Integer;
  LTitulo: string;
begin
  LPDF := Args.PDF;
  PrepararTracoNFeABI(LPDF);

  LTitulo := 'TRANSMITENTES E ADQUIRENTES';
  if FProximo > 0 then
    LTitulo := LTitulo + ' (CONTINUAÇÃO)';
  DesenharTituloBlocoNFeABI(LPDF, LTitulo, 0);

  // Faixa com o nome de cada tabela
  LPDF.SetFillColor(217, 217, 217);
  LPDF.Rect(0, CALT_TITULO, CLARG_P, CALT_BANDA_TAB, 'F');
  PrepararTracoNFeABI(LPDF);
  LinhaHNFeABI(LPDF, 0, CLARG_P, CALT_TITULO);
  LinhaVNFeABI(LPDF, 0, CALT_TITULO, CALT_TITULO + CALT_BANDA_TAB);
  LinhaVNFeABI(LPDF, PX12, CALT_TITULO, CALT_TITULO + CALT_BANDA_TAB);
  LinhaVNFeABI(LPDF, CLARG_P, CALT_TITULO, CALT_TITULO + CALT_BANDA_TAB);
  FonteRotuloNFeABI(LPDF);
  TxtEsqNFeABI(LPDF, CPAD, CALT_TITULO + CBASE_ROTULO, FTransmit.Titulo);
  TxtEsqNFeABI(LPDF, PX12 + CPAD, CALT_TITULO + CBASE_ROTULO, FAdquirente.Titulo);

  LY := CALT_TITULO + CALT_BANDA_TAB;
  DesenharCabecalhoTabelaNFeABI(LPDF, FTransmit, LY);
  DesenharCabecalhoTabelaNFeABI(LPDF, FAdquirente, LY);

  LY := LY + CALT_CAB_TAB;
  LTotal := Max(Length(FTransmit.Linhas), Length(FAdquirente.Linhas));
  LDesenhadas := 0;
  while FProximo < LTotal do
  begin
    // Uma linha de cada tabela lado a lado: a altura e a maior das duas
    LAltura := Max(AlturaLinhaTabelaNFeABI(LPDF, FTransmit, FProximo),
      AlturaLinhaTabelaNFeABI(LPDF, FAdquirente, FProximo));
    if (LDesenhadas > 0) and (LY + LAltura > Args.FreeSpace) then
      Break;

    DesenharLinhaTabelaNFeABI(LPDF, FTransmit, FProximo, LY, LAltura);
    DesenharLinhaTabelaNFeABI(LPDF, FAdquirente, FProximo, LY, LAltura);
    LY := LY + LAltura;
    Inc(FProximo);
    Inc(LDesenhadas);
  end;

  Args.DrawAgain := FProximo < LTotal;
end;

{ TBlocoCamposNFeABI }

constructor TBlocoCamposNFeABI.Create(ANFeABIUtils: TNFeABIUtilsFPDF; const ATitulo: string;
  APaisagem: Boolean);
begin
  inherited Create(btData);
  FNFeABIUtils := ANFeABIUtils;
  FTitulo := ATitulo;
  FPaisagem := APaisagem;
end;

function TBlocoCamposNFeABI.MontarLinhas: TLinhasNFeABI;
begin
  if FPaisagem then
    Result := MontarLinhasPaisagem
  else
    Result := MontarLinhasRetrato;
end;

procedure TBlocoCamposNFeABI.OnInit(Args: TFPDFBandInitArgs);
begin
  AutoHeight := True;
  FAdiado := False;
  Visible := TemConteudo;
  Height := CALT_TITULO + CALT_CAMPO;
end;

procedure TBlocoCamposNFeABI.OnDraw(Args: TFPDFBandDrawArgs);
var
  LPDF: IFPDF;
  LLinhas: TLinhasNFeABI;
  LAlturas: array of Double;
  I: Integer;
  LY: Double;
  LTotal: Double;
begin
  LPDF := Args.PDF;
  LLinhas := MontarLinhas;

  SetLength(LAlturas, Length(LLinhas));
  LTotal := CALT_TITULO;
  for I := 0 to High(LLinhas) do
  begin
    LAlturas[I] := AlturaLinhaCamposNFeABI(MaxLinhasCelulasNFeABI(LPDF, LLinhas[I]));
    LTotal := LTotal + LAlturas[I];
  end;

  // O bloco nao e dividido entre folhas: se nao cabe, segue inteiro na folha seguinte
  if (LTotal > Args.FreeSpace) and (not FAdiado) then
  begin
    FAdiado := True;
    ConsumirEspacoFolhaNFeABI(Args);
    Exit;
  end;
  FAdiado := False;

  PrepararTracoNFeABI(LPDF);
  DesenharTituloBlocoNFeABI(LPDF, FTitulo, 0);

  LY := CALT_TITULO;
  for I := 0 to High(LLinhas) do
  begin
    DesenharLinhaCamposNFeABI(LPDF, LY, LLinhas[I], LAlturas[I], LarguraNFeABI(FPaisagem));
    LY := LY + LAlturas[I];
  end;

  PrepararTracoNFeABI(LPDF);
  LinhaHNFeABI(LPDF, 0, LarguraNFeABI(FPaisagem), LY);
end;

{ TBlocoImovelNFeABI }

constructor TBlocoImovelNFeABI.Create(ANFeABIUtils: TNFeABIUtilsFPDF; APaisagem: Boolean);
begin
  inherited Create(ANFeABIUtils, 'IDENTIFICAÇÃO DO IMÓVEL', APaisagem);
end;

function TBlocoImovelNFeABI.TemConteudo: Boolean;
begin
  Result := FNFeABIUtils.NFeABI.Ide.tpNF <> tdTransicao;
end;

{ Textos do bloco de identificacao do imovel que dependem de tratamento (comuns aos dois formatos) }

function OutrasEspeciesImovelNFeABI(AImovel: TImovel): string;
begin
  if AImovel.espImovel = CESP_OUTROS then
    Result := TextoOuVazioNFeABI(AImovel.xOutrosEspecies)
  else
    Result := CVAZIO;
end;

function AreaImovelNFeABI(AImovel: TImovel; const AFormatSettings: TFormatSettings): string;
begin
  if AImovel.areaTotal <> 0 then
    Result := NumeroNFeABI(AFormatSettings, AImovel.areaTotal, 2)
  else
    Result := CVAZIO;
end;

function UnidadeAreaImovelNFeABI(AImovel: TImovel): string;
begin
  if AImovel.areaTotal = 0 then
    Result := CVAZIO
  else
    Result := CodigoDescricaoNFeABI(uareaTotalToStr(AImovel.uAreaTotal),
      CDescUnidAreaNFeABI[AImovel.uAreaTotal]);
end;

{ Numero do cadastro (IPTU, INCRA ou RIP): so aparece quando o indicador esta como Sim }
function CadastroImovelNFeABI(AInformado: Boolean; const ANumero: string): string;
begin
  if AInformado then
    Result := TextoOuVazioNFeABI(ANumero)
  else
    Result := CVAZIO;
end;

function MunicipioUFImovelNFeABI(AEnder: Tendereco): string;
begin
  if Trim(AEnder.xMun) = '' then
    Result := CVAZIO
  else if Trim(AEnder.UF) = '' then
    Result := Trim(AEnder.xMun)
  else
    Result := Trim(AEnder.xMun) + ' - ' + Trim(AEnder.UF);
end;

function CEPImovelNFeABI(AEnder: Tendereco): string;
begin
  if Trim(AEnder.CEP) = '' then
    Result := CVAZIO
  else
    Result := FormatarCEP(Trim(AEnder.CEP));
end;

function TBlocoImovelNFeABI.MontarLinhasPaisagem: TLinhasNFeABI;
var
  LImovel: TImovel;
  LEnder: Tendereco;
  LLinha: TCelulasNFeABI;
begin
  LImovel := FNFeABIUtils.NFeABI.imovel;
  LEnder := LImovel.enderImovel;

  Result := nil;

  LLinha := nil;
  AddCelNFeABI(LLinha, 0, PX03, 'TIPO DO IMÓVEL',
    CodigoDescricaoNFeABI(TipoToStr(LImovel.tipo), CDescTipoImovelNFeABI[LImovel.tipo]));
  AddCelNFeABI(LLinha, PX03, PX06, 'ESPÉCIE DO IMÓVEL',
    CodigoDescricaoNFeABI(LImovel.espImovel, DescCodigoNFeABI(CDescEspImovelNFeABI, StrToIntDef(LImovel.espImovel, 0))));
  AddCelNFeABI(LLinha, PX06, PX12, 'DESCRIÇÃO (OUTRAS ESPÉCIES)',
    OutrasEspeciesImovelNFeABI(LImovel));
  AddCelNFeABI(LLinha, PX12, PX18, 'ENQUADRAMENTO DO IMÓVEL',
    CodigoDescricaoNFeABI(LImovel.enquadramento,
      DescCodigoNFeABI(CDescEnquadramentoNFeABI, StrToIntDef(LImovel.enquadramento, 0))));
  AddCelNFeABI(LLinha, PX18, PX21, 'ÁREA TOTAL DO IMÓVEL',
    AreaImovelNFeABI(LImovel, FNFeABIUtils.FormatSettings));
  AddCelNFeABI(LLinha, PX21, CLARG_P, 'UNIDADE DE MEDIDA', UnidadeAreaImovelNFeABI(LImovel));
  AddLinhaNFeABI(Result, LLinha);

  LLinha := nil;
  AddCelNFeABI(LLinha, 0, PX03, 'MATRÍCULA OU TRANSCRIÇÃO',
    TextoOuVazioNFeABI(LImovel.matricTransc));
  AddCelNFeABI(LLinha, PX03, PX11, 'CARTÓRIO DE REGISTRO DE IMÓVEIS',
    TextoOuVazioNFeABI(LImovel.cartorioRegistro));
  AddCelNFeABI(LLinha, PX11, PX15, 'CIB', TextoOuVazioNFeABI(LImovel.cadastro.cCIB));
  AddCelNFeABI(LLinha, PX15, PX18, 'IPTU',
    CadastroImovelNFeABI(LImovel.cadastro.indIPTU = tiSim, LImovel.cadastro.nIptu));
  AddCelNFeABI(LLinha, PX18, PX21, 'INCRA',
    CadastroImovelNFeABI(LImovel.cadastro.indIncra = tiSim, LImovel.cadastro.nIncra));
  AddCelNFeABI(LLinha, PX21, CLARG_P, 'RIP',
    CadastroImovelNFeABI(LImovel.cadastro.indRIP = tieSim, LImovel.cadastro.nRIP));
  AddLinhaNFeABI(Result, LLinha);

  LLinha := nil;
  AddCelNFeABI(LLinha, 0, PX07, 'LOGRADOURO', TextoOuVazioNFeABI(LEnder.xLgr));
  AddCelNFeABI(LLinha, PX07, PX09, 'NÚMERO', TextoOuVazioNFeABI(LEnder.nro));
  AddCelNFeABI(LLinha, PX09, PX13, 'COMPLEMENTO', TextoOuVazioNFeABI(LEnder.xCpl));
  AddCelNFeABI(LLinha, PX13, PX17, 'BAIRRO / LOCALIDADE',
    TextoOuVazioNFeABI(LEnder.xBairro));
  AddCelNFeABI(LLinha, PX17, PX21, 'MUNICÍPIO / UF', MunicipioUFImovelNFeABI(LEnder));
  AddCelNFeABI(LLinha, PX21, CLARG_P, 'CEP', CEPImovelNFeABI(LEnder));
  AddLinhaNFeABI(Result, LLinha);

  if Trim(LImovel.obsLocalImovel) <> '' then
  begin
    LLinha := nil;
    AddCelNFeABI(LLinha, 0, CLARG_P, 'OBSERVAÇÕES SOBRE O LOCAL', Trim(LImovel.obsLocalImovel));
    AddLinhaNFeABI(Result, LLinha);
  end;
end;

function TBlocoImovelNFeABI.MontarLinhasRetrato: TLinhasNFeABI;
var
  LImovel: TImovel;
  LEnder: Tendereco;
  LLinha: TCelulasNFeABI;
begin
  LImovel := FNFeABIUtils.NFeABI.imovel;
  LEnder := LImovel.enderImovel;

  Result := nil;

  LLinha := nil;
  AddCelNFeABI(LLinha, 0, C4A, 'TIPO DO IMÓVEL',
    CodigoDescricaoNFeABI(TipoToStr(LImovel.tipo), CDescTipoImovelNFeABI[LImovel.tipo]));
  AddCelNFeABI(LLinha, C4A, C4B, 'ESPÉCIE DO IMÓVEL',
    CodigoDescricaoNFeABI(LImovel.espImovel, DescCodigoNFeABI(CDescEspImovelNFeABI, StrToIntDef(LImovel.espImovel, 0))));
  AddCelNFeABI(LLinha, C4B, CLARG, 'DESCRIÇÃO (OUTRAS ESPÉCIES)', OutrasEspeciesImovelNFeABI(LImovel));
  AddLinhaNFeABI(Result, LLinha);

  LLinha := nil;
  AddCelNFeABI(LLinha, 0, C4B, 'ENQUADRAMENTO DO IMÓVEL',
    CodigoDescricaoNFeABI(LImovel.enquadramento,
      DescCodigoNFeABI(CDescEnquadramentoNFeABI, StrToIntDef(LImovel.enquadramento, 0))));
  AddCelNFeABI(LLinha, C4B, C4C, 'ÁREA TOTAL DO IMÓVEL',
    AreaImovelNFeABI(LImovel, FNFeABIUtils.FormatSettings));
  AddCelNFeABI(LLinha, C4C, CLARG, 'UNIDADE DE MEDIDA', UnidadeAreaImovelNFeABI(LImovel));
  AddLinhaNFeABI(Result, LLinha);

  LLinha := nil;
  AddCelNFeABI(LLinha, 0, C4A, 'MATRÍCULA OU TRANSCRIÇÃO', TextoOuVazioNFeABI(LImovel.matricTransc));
  AddCelNFeABI(LLinha, C4A, CLARG, 'CARTÓRIO DE REGISTRO DE IMÓVEIS',
    TextoOuVazioNFeABI(LImovel.cartorioRegistro));
  AddLinhaNFeABI(Result, LLinha);

  LLinha := nil;
  AddCelNFeABI(LLinha, 0, C4A, 'CIB', TextoOuVazioNFeABI(LImovel.cadastro.cCIB));
  AddCelNFeABI(LLinha, C4A, C4B, 'IPTU',
    CadastroImovelNFeABI(LImovel.cadastro.indIPTU = tiSim, LImovel.cadastro.nIptu));
  AddCelNFeABI(LLinha, C4B, C4C, 'INCRA',
    CadastroImovelNFeABI(LImovel.cadastro.indIncra = tiSim, LImovel.cadastro.nIncra));
  AddCelNFeABI(LLinha, C4C, CLARG, 'RIP',
    CadastroImovelNFeABI(LImovel.cadastro.indRIP = tieSim, LImovel.cadastro.nRIP));
  AddLinhaNFeABI(Result, LLinha);

  LLinha := nil;
  AddCelNFeABI(LLinha, 0, C4B, 'LOGRADOURO', TextoOuVazioNFeABI(LEnder.xLgr));
  AddCelNFeABI(LLinha, C4B, S4, 'NÚMERO', TextoOuVazioNFeABI(LEnder.nro));
  AddCelNFeABI(LLinha, S4, CLARG, 'COMPLEMENTO', TextoOuVazioNFeABI(LEnder.xCpl));
  AddLinhaNFeABI(Result, LLinha);

  LLinha := nil;
  AddCelNFeABI(LLinha, 0, S2, 'BAIRRO / LOCALIDADE', TextoOuVazioNFeABI(LEnder.xBairro));
  AddCelNFeABI(LLinha, S2, C4C, 'MUNICÍPIO / UF', MunicipioUFImovelNFeABI(LEnder));
  AddCelNFeABI(LLinha, C4C, CLARG, 'CEP', CEPImovelNFeABI(LEnder));
  AddLinhaNFeABI(Result, LLinha);

  if Trim(LImovel.obsLocalImovel) <> '' then
  begin
    LLinha := nil;
    AddCelNFeABI(LLinha, 0, CLARG, 'OBSERVAÇÕES SOBRE O LOCAL', Trim(LImovel.obsLocalImovel));
    AddLinhaNFeABI(Result, LLinha);
  end;
end;

{ TBlocoOperacaoNFeABI }

constructor TBlocoOperacaoNFeABI.Create(ANFeABIUtils: TNFeABIUtilsFPDF; APaisagem: Boolean);
begin
  inherited Create(ANFeABIUtils, 'INFORMAÇÕES DA OPERAÇÃO', APaisagem);
end;

function TBlocoOperacaoNFeABI.TemConteudo: Boolean;
begin
  // O grupo infOper nao e aberto na NF-e ABI de transicao nem no pagamento antecipado
  Result := (FNFeABIUtils.NFeABI.Ide.tpNF <> tdTransicao) and
    (FNFeABIUtils.NFeABI.Ide.tpPagAnt <> tpabPagamentoAntecipado);
end;

{ Textos do bloco de informacoes da operacao que dependem de tratamento (comuns aos dois formatos) }

{ Descricao curta do instrumento, sem o codigo, como no modelo de referencia }
function InstrumentoOperacaoNFeABI(AOper: TInfOper): string;
begin
  Result := TextoOuVazioNFeABI(DescCodigoNFeABI(CDescTipoInstrumentoNFeABI, AOper.instrumento.tpInstrumento));
  if (AOper.instrumento.tpInstrumento = CINSTRUMENTO_OUTROS) and
     (Trim(AOper.instrumento.xOutrosInst) <> '') then
    Result := Trim(AOper.instrumento.xOutrosInst);
end;

function SimNaoNFeABI(AValor: TIndicador): string;
begin
  if AValor = tiSim then
    Result := 'Sim'
  else
    Result := 'Não';
end;

function TornaOperacaoNFeABI(AOper: TInfOper): string;
begin
  Result := SimNaoNFeABI(AOper.indTorna);
end;

function ValorTornaOperacaoNFeABI(AOper: TInfOper; const AFormatSettings: TFormatSettings): string;
begin
  if AOper.indTorna = tiSim then
    Result := MoedaNFeABI(AFormatSettings, AOper.gTorna.vTorna)
  else
    Result := CVAZIO;
end;

function RedutorSocialOperacaoNFeABI(AOper: TInfOper; const AFormatSettings: TFormatSettings): string;
begin
  Result := SimNaoNFeABI(AOper.indRedSocial);
  if (AOper.indRedSocial = tiSim) and (AOper.vRedSocial <> 0) then
    Result := Result + ' - ' + MoedaNFeABI(AFormatSettings, AOper.vRedSocial);
end;

function IncorpLoteOperacaoNFeABI(AOper: TInfOper): string;
begin
  case AOper.gIncorpLote.indIncorpLote of
    iilNao: Result := 'Não';
    iilIncorporacao: Result := 'Sim - Incorporação';
    iilLoteamento: Result := 'Sim - Loteamento';
  else
    Result := CVAZIO;
  end;
end;

function CNPJEmpreendimentoOperacaoNFeABI(AOper: TInfOper): string;
begin
  if Trim(AOper.gIncorpLote.CNPJempImob) <> '' then
    Result := FormatarCNPJ(Trim(AOper.gIncorpLote.CNPJempImob))
  else
    Result := CVAZIO;
end;

function TBlocoOperacaoNFeABI.MontarLinhasPaisagem: TLinhasNFeABI;
var
  LOper: TInfOper;
  LFS: TFormatSettings;
  LLinha: TCelulasNFeABI;
  LIntermed: string;
  I: Integer;
begin
  LOper := FNFeABIUtils.NFeABI.infOper;
  LFS := FNFeABIUtils.FormatSettings;

  Result := nil;

  LIntermed := SimNaoNFeABI(LOper.indIntermedCorret);

  LLinha := nil;
  AddCelNFeABI(LLinha, 0, PX03, 'PROPORÇÃO TRANSMITIDA', PercentualNFeABI(LFS, LOper.pTransImovel));
  AddCelNFeABI(LLinha, PX03, PX07, 'VALOR DA OPERAÇÃO',
    MoedaNFeABI(LFS, LOper.vTotalOperacao));
  AddCelNFeABI(LLinha, PX07, PX11, 'INSTRUMENTO', InstrumentoOperacaoNFeABI(LOper));
  AddCelNFeABI(LLinha, PX11, PX14, 'DATA DO INSTRUMENTO',
    DataNFeABI(LOper.instrumento.dtInstrumento));
  AddCelNFeABI(LLinha, PX14, PX16, 'PERMUTA C/ TORNA', TornaOperacaoNFeABI(LOper));
  AddCelNFeABI(LLinha, PX16, PX20, 'VALOR DA TORNA',
    ValorTornaOperacaoNFeABI(LOper, LFS));
  AddCelNFeABI(LLinha, PX20, CLARG_P, 'REDUTOR DE AJUSTE DO IMÓVEL',
    ValorOuVazioNFeABI(LFS, LOper.gRedAjusteImovel.vRedAjusteImovel));
  AddLinhaNFeABI(Result, LLinha);

  LLinha := nil;
  AddCelNFeABI(LLinha, 0, PX03, 'REDUTOR SOCIAL', RedutorSocialOperacaoNFeABI(LOper, LFS));
  AddCelNFeABI(LLinha, PX03, PX07, 'INCORPORAÇÃO / LOTEAMENTO',
    IncorpLoteOperacaoNFeABI(LOper));
  AddCelNFeABI(LLinha, PX07, PX11, 'CNPJ DO EMPREENDIMENTO',
    CNPJEmpreendimentoOperacaoNFeABI(LOper));
  AddCelNFeABI(LLinha, PX11, PX14, 'CIB DA OBRA',
    TextoOuVazioNFeABI(LOper.gIncorpLote.cCIBObra));
  AddCelNFeABI(LLinha, PX14, PX18, 'CNO', TextoOuVazioNFeABI(LOper.gIncorpLote.CNO));
  AddCelNFeABI(LLinha, PX18, CLARG_P, 'INTERMEDIAÇÃO / CORRETAGEM', LIntermed);
  AddLinhaNFeABI(Result, LLinha);

  // Intermediacao / corretagem: linha adicional do bloco, somente quando informada
  if LOper.indIntermedCorret = tiSim then
    for I := 0 to LOper.gIntermedCorret.Count - 1 do
    begin
      LLinha := nil;
      AddCelNFeABI(LLinha, 0, PX07, 'INTERMEDIAÇÃO - CPF/CNPJ',
        DocumentoNFeABI(LOper.gIntermedCorret[I].CNPJCPF));
      AddCelNFeABI(LLinha, PX07, PX18, 'INTERMEDIAÇÃO - NOME / RAZÃO SOCIAL',
        TextoOuVazioNFeABI(LOper.gIntermedCorret[I].xNome));
      AddCelNFeABI(LLinha, PX18, CLARG_P, 'VALOR DA CORRETAGEM',
        MoedaNFeABI(LFS, LOper.gIntermedCorret[I].vCorretagem));
      AddLinhaNFeABI(Result, LLinha);
    end;
end;

function TBlocoOperacaoNFeABI.MontarLinhasRetrato: TLinhasNFeABI;
var
  LOper: TInfOper;
  LFS: TFormatSettings;
  LLinha: TCelulasNFeABI;
  I: Integer;
begin
  LOper := FNFeABIUtils.NFeABI.infOper;
  LFS := FNFeABIUtils.FormatSettings;

  Result := nil;

  LLinha := nil;
  AddCelNFeABI(LLinha, 0, S1, 'PROPORÇÃO TRANSMITIDA', PercentualNFeABI(LFS, LOper.pTransImovel));
  AddCelNFeABI(LLinha, S1, CVTIT, 'VALOR DA OPERAÇÃO', MoedaNFeABI(LFS, LOper.vTotalOperacao));
  AddCelNFeABI(LLinha, CVTIT, C4C, 'INSTRUMENTO', InstrumentoOperacaoNFeABI(LOper));
  AddCelNFeABI(LLinha, C4C, CLARG, 'DATA DO INSTRUMENTO', DataNFeABI(LOper.instrumento.dtInstrumento));
  AddLinhaNFeABI(Result, LLinha);

  LLinha := nil;
  AddCelNFeABI(LLinha, 0, C4A, 'PERMUTA COM TORNA', TornaOperacaoNFeABI(LOper));
  AddCelNFeABI(LLinha, C4A, C4B, 'VALOR DA TORNA', ValorTornaOperacaoNFeABI(LOper, LFS));
  AddCelNFeABI(LLinha, C4B, C4C, 'REDUTOR DE AJUSTE DO IMÓVEL',
    ValorOuVazioNFeABI(LFS, LOper.gRedAjusteImovel.vRedAjusteImovel));
  AddCelNFeABI(LLinha, C4C, CLARG, 'REDUTOR SOCIAL', RedutorSocialOperacaoNFeABI(LOper, LFS));
  AddLinhaNFeABI(Result, LLinha);

  LLinha := nil;
  AddCelNFeABI(LLinha, 0, C4A, 'INCORPORAÇÃO / LOTEAMENTO', IncorpLoteOperacaoNFeABI(LOper));
  AddCelNFeABI(LLinha, C4A, C4B, 'CNPJ DO EMPREENDIMENTO', CNPJEmpreendimentoOperacaoNFeABI(LOper));
  AddCelNFeABI(LLinha, C4B, C4C, 'CIB DA OBRA', TextoOuVazioNFeABI(LOper.gIncorpLote.cCIBObra));
  AddCelNFeABI(LLinha, C4C, CLARG, 'CNO', TextoOuVazioNFeABI(LOper.gIncorpLote.CNO));
  AddLinhaNFeABI(Result, LLinha);

  // Intermediacao / corretagem: linha adicional do bloco, somente quando informada
  if LOper.indIntermedCorret = tiSim then
    for I := 0 to LOper.gIntermedCorret.Count - 1 do
    begin
      LLinha := nil;
      AddCelNFeABI(LLinha, 0, C4A, 'INTERMEDIAÇÃO - CPF/CNPJ',
        DocumentoNFeABI(LOper.gIntermedCorret[I].CNPJCPF));
      AddCelNFeABI(LLinha, C4A, C4C, 'INTERMEDIAÇÃO - NOME / RAZÃO SOCIAL',
        TextoOuVazioNFeABI(LOper.gIntermedCorret[I].xNome));
      AddCelNFeABI(LLinha, C4C, CLARG, 'VALOR DA CORRETAGEM',
        MoedaNFeABI(LFS, LOper.gIntermedCorret[I].vCorretagem));
      AddLinhaNFeABI(Result, LLinha);
    end;
end;

{ TBlocoCalculoNFeABI }

constructor TBlocoCalculoNFeABI.Create(ANFeABIUtils: TNFeABIUtilsFPDF; APaisagem: Boolean);
begin
  inherited Create(ANFeABIUtils, 'CÁLCULO DO IBS E DA CBS (DECLARANTE)', APaisagem);
end;

function TBlocoCalculoNFeABI.TemConteudo: Boolean;
begin
  Result := (FNFeABIUtils.NFeABI.Ide.tpNF <> tdTransicao) and
    (FNFeABIUtils.NFeABI.gInfTrib.IBSCBS.CST <> cstNenhum);
end;

{ Valores do bloco de calculo do IBS e da CBS que dependem de tratamento (comuns aos dois formatos) }

{ Havendo reducao, apresenta a aliquota efetiva }
function AliquotaEfetivaNFeABI(AAliquota, AAliquotaEfetiva: Double): Double;
begin
  if AAliquotaEfetiva <> 0 then
    Result := AAliquotaEfetiva
  else
    Result := AAliquota;
end;

{ Totais (grupo W): ausentes na incorporacao/loteamento }
function TotaisInformadosNFeABI(ANFeABI: TNFeABI): Boolean;
begin
  Result := not ((ANFeABI.Total.vNF = 0) and
    (ANFeABI.Total.vIBSUF + ANFeABI.Total.vIBSMun = 0) and
    (ANFeABI.Total.vCBS = 0));
end;

function TextoTotalIBSNFeABI(ANFeABI: TNFeABI; const AFormatSettings: TFormatSettings): string;
begin
  if TotaisInformadosNFeABI(ANFeABI) then
    Result := MoedaNFeABI(AFormatSettings, ANFeABI.Total.vIBSUF + ANFeABI.Total.vIBSMun)
  else
    Result := CVAZIO;
end;

function TextoTotalCBSNFeABI(ANFeABI: TNFeABI; const AFormatSettings: TFormatSettings): string;
begin
  if TotaisInformadosNFeABI(ANFeABI) then
    Result := MoedaNFeABI(AFormatSettings, ANFeABI.Total.vCBS)
  else
    Result := CVAZIO;
end;

function TextoTotalNFNFeABI(ANFeABI: TNFeABI; const AFormatSettings: TFormatSettings): string;
begin
  if TotaisInformadosNFeABI(ANFeABI) then
    Result := MoedaNFeABI(AFormatSettings, ANFeABI.Total.vNF)
  else
    Result := CVAZIO;
end;

type
  TExtrasCalculoNFeABI = array of array[0..1] of string;

{ Linhas adicionais do bloco (somente quando informados): rotulo e valor de cada campo }

function ExtrasCalculoNFeABI(AUtils: TNFeABIUtilsFPDF): TExtrasCalculoNFeABI;
var
  LNFeABI: TNFeABI;
  LFS: TFormatSettings;
  LIBSCBS: TIBSCBS;
  LValores: TgIBSCBS;

  procedure AddExtra(const ARotulo, AValor: string);
  begin
    SetLength(Result, Length(Result) + 1);
    Result[High(Result)][0] := ARotulo;
    Result[High(Result)][1] := AValor;
  end;

begin
  LNFeABI := AUtils.NFeABI;
  LFS := AUtils.FormatSettings;
  LIBSCBS := LNFeABI.gInfTrib.IBSCBS;
  LValores := LIBSCBS.gIBSCBS;

  Result := nil;
  if LValores.vTornaIndiv <> 0 then
    AddExtra('VALOR DA TORNA', NumeroNFeABI(LFS, LValores.vTornaIndiv, 2));

  if LNFeABI.gInfTrib.gCompraGov.tpEnteGov <> tcgNenhum then
  begin
    AddExtra('COMPRA GOVERNAMENTAL - ENTE',
      CodigoDescricaoNFeABI(tpEnteGovToStr(LNFeABI.gInfTrib.gCompraGov.tpEnteGov),
        CDescTipoEnteGovNFeABI[LNFeABI.gInfTrib.gCompraGov.tpEnteGov]));
    AddExtra('COMPRA GOVERNAMENTAL - REDUTOR',
      PercentualNFeABI(LFS, LNFeABI.gInfTrib.gCompraGov.pRedutor));
    AddExtra('COMPRA GOVERNAMENTAL - OPERAÇÃO',
      CodigoDescricaoNFeABI(tpOperGovToStr(LNFeABI.gInfTrib.gCompraGov.tpOperGov),
        CDescTipoOperGovNFeABI[LNFeABI.gInfTrib.gCompraGov.tpOperGov]));
  end;

  if (LIBSCBS.gEstornoCred.vIBSEstCred <> 0) or (LIBSCBS.gEstornoCred.vCBSEstCred <> 0) then
  begin
    AddExtra('ESTORNO DE CRÉDITO - IBS', MoedaNFeABI(LFS, LIBSCBS.gEstornoCred.vIBSEstCred));
    AddExtra('ESTORNO DE CRÉDITO - CBS', MoedaNFeABI(LFS, LIBSCBS.gEstornoCred.vCBSEstCred));
  end;

  if (LNFeABI.gInfTrib.gInfPagAntecip.vPagAntecip <> 0) or (LNFeABI.gInfTrib.gInfPagAntecip.dtPagAntecip > 0) then
  begin
    AddExtra('PAGAMENTO ANTECIPADO - VALOR', MoedaNFeABI(LFS, LNFeABI.gInfTrib.gInfPagAntecip.vPagAntecip));
    AddExtra('PAGAMENTO ANTECIPADO - DATA', DataNFeABI(LNFeABI.gInfTrib.gInfPagAntecip.dtPagAntecip));
    if Trim(LNFeABI.gInfTrib.gInfPagAntecip.CNPJempImob) <> '' then
      AddExtra('PAGAMENTO ANTECIPADO - CNPJ DO EMPREENDIMENTO',
        FormatarCNPJ(Trim(LNFeABI.gInfTrib.gInfPagAntecip.CNPJempImob)));
  end;
end;

function TBlocoCalculoNFeABI.MontarLinhasPaisagem: TLinhasNFeABI;
var
  LFS: TFormatSettings;
  LIBSCBS: TIBSCBS;
  LValores: TgIBSCBS;
  LLinha: TCelulasNFeABI;
  LExtras: TExtrasCalculoNFeABI;
  LColuna: Integer;
  I: Integer;
begin
  LFS := FNFeABIUtils.FormatSettings;
  LIBSCBS := FNFeABIUtils.NFeABI.gInfTrib.IBSCBS;
  LValores := LIBSCBS.gIBSCBS;

  Result := nil;

  LLinha := nil;
  AddCelNFeABI(LLinha, 0, PX02, 'CST', CSTIBSCBSToStr(LIBSCBS.CST));
  AddCelNFeABI(LLinha, PX02, PX04, 'CCLASSTRIB', LIBSCBS.cClassTrib);
  AddCelNFeABI(LLinha, PX04, PX07, 'VALOR DA OPERAÇÃO',
    NumeroNFeABI(LFS, LValores.vOperacIndiv, 2));
  AddCelNFeABI(LLinha, PX07, PX10, 'REDUTOR DE AJUSTE',
    NumeroNFeABI(LFS, LValores.vRedAjusteIndiv, 2));
  AddCelNFeABI(LLinha, PX10, PX12, 'REDUTOR SOCIAL',
    NumeroNFeABI(LFS, LValores.vRedSocialIndiv, 2));
  AddCelNFeABI(LLinha, PX12, PX15, 'BASE DE CÁLCULO', NumeroNFeABI(LFS, LValores.vBC, 2));
  AddCelNFeABI(LLinha, PX15, PX17, 'ALÍQ. IBS UF',
    PercentualNFeABI(LFS, AliquotaEfetivaNFeABI(LValores.gIBSUF.pIBSUF, LValores.gIBSUF.gRed.pAliqEfet)));
  AddCelNFeABI(LLinha, PX17, PX19, 'VALOR IBS UF',
    NumeroNFeABI(LFS, LValores.gIBSUF.vIBSUF, 2));
  AddCelNFeABI(LLinha, PX19, PX21, 'ALÍQ. IBS MUN.',
    PercentualNFeABI(LFS, AliquotaEfetivaNFeABI(LValores.gIBSMun.pIBSMun, LValores.gIBSMun.gRed.pAliqEfet)));
  AddCelNFeABI(LLinha, PX21, CLARG_P, 'VALOR IBS MUN.',
    NumeroNFeABI(LFS, LValores.gIBSMun.vIBSMun, 2));
  AddLinhaNFeABI(Result, LLinha);

  LLinha := nil;
  AddCelNFeABI(LLinha, 0, PX03, 'ALÍQ. CBS',
    PercentualNFeABI(LFS, AliquotaEfetivaNFeABI(LValores.gCBS.pCBS, LValores.gCBS.gRed.pAliqEfet)));
  AddCelNFeABI(LLinha, PX03, PX06, 'VALOR CBS', NumeroNFeABI(LFS, LValores.gCBS.vCBS, 2));
  AddCelNFeABI(LLinha, PX06, PX11, 'VALOR TOTAL DO IBS',
    TextoTotalIBSNFeABI(FNFeABIUtils.NFeABI, LFS));
  AddCelNFeABI(LLinha, PX11, PX16, 'VALOR TOTAL DA CBS',
    TextoTotalCBSNFeABI(FNFeABIUtils.NFeABI, LFS));
  AddCelNFeABI(LLinha, PX16, CLARG_P, 'VALOR TOTAL DA NF-E ABI',
    TextoTotalNFNFeABI(FNFeABIUtils.NFeABI, LFS), True);
  AddLinhaNFeABI(Result, LLinha);

  // Linhas adicionais: 4 campos por linha
  LExtras := ExtrasCalculoNFeABI(FNFeABIUtils);
  LLinha := nil;
  LColuna := 0;
  for I := 0 to High(LExtras) do
  begin
    case LColuna of
      0: AddCelNFeABI(LLinha, 0, PX06, LExtras[I][0], LExtras[I][1]);
      1: AddCelNFeABI(LLinha, PX06, PX12, LExtras[I][0], LExtras[I][1]);
      2: AddCelNFeABI(LLinha, PX12, PX18, LExtras[I][0], LExtras[I][1]);
    else
      AddCelNFeABI(LLinha, PX18, CLARG_P, LExtras[I][0], LExtras[I][1]);
    end;
    Inc(LColuna);
    if (LColuna = 4) or (I = High(LExtras)) then
    begin
      AddLinhaNFeABI(Result, LLinha);
      LLinha := nil;
      LColuna := 0;
    end;
  end;
end;

function TBlocoCalculoNFeABI.MontarLinhasRetrato: TLinhasNFeABI;
var
  LFS: TFormatSettings;
  LIBSCBS: TIBSCBS;
  LValores: TgIBSCBS;
  LLinha: TCelulasNFeABI;
  LExtras: TExtrasCalculoNFeABI;
  LColuna: Integer;
  I: Integer;
begin
  LFS := FNFeABIUtils.FormatSettings;
  LIBSCBS := FNFeABIUtils.NFeABI.gInfTrib.IBSCBS;
  LValores := LIBSCBS.gIBSCBS;

  Result := nil;

  LLinha := nil;
  AddCelNFeABI(LLinha, 0, S1, 'CST', CSTIBSCBSToStr(LIBSCBS.CST));
  AddCelNFeABI(LLinha, S1, S2, 'CCLASSTRIB', LIBSCBS.cClassTrib);
  AddCelNFeABI(LLinha, S2, S3, 'VALOR DA OPERAÇÃO', NumeroNFeABI(LFS, LValores.vOperacIndiv, 2));
  AddCelNFeABI(LLinha, S3, S4, 'REDUTOR DE AJUSTE', NumeroNFeABI(LFS, LValores.vRedAjusteIndiv, 2));
  AddCelNFeABI(LLinha, S4, S5, 'REDUTOR SOCIAL', NumeroNFeABI(LFS, LValores.vRedSocialIndiv, 2));
  AddCelNFeABI(LLinha, S5, CLARG, 'BASE DE CÁLCULO', NumeroNFeABI(LFS, LValores.vBC, 2));
  AddLinhaNFeABI(Result, LLinha);

  LLinha := nil;
  AddCelNFeABI(LLinha, 0, S1, 'ALÍQ. IBS UF',
    PercentualNFeABI(LFS, AliquotaEfetivaNFeABI(LValores.gIBSUF.pIBSUF, LValores.gIBSUF.gRed.pAliqEfet)));
  AddCelNFeABI(LLinha, S1, S2, 'VALOR IBS UF', NumeroNFeABI(LFS, LValores.gIBSUF.vIBSUF, 2));
  AddCelNFeABI(LLinha, S2, S3, 'ALÍQ. IBS MUN.',
    PercentualNFeABI(LFS, AliquotaEfetivaNFeABI(LValores.gIBSMun.pIBSMun, LValores.gIBSMun.gRed.pAliqEfet)));
  AddCelNFeABI(LLinha, S3, S4, 'VALOR IBS MUN.', NumeroNFeABI(LFS, LValores.gIBSMun.vIBSMun, 2));
  AddCelNFeABI(LLinha, S4, S5, 'ALÍQ. CBS',
    PercentualNFeABI(LFS, AliquotaEfetivaNFeABI(LValores.gCBS.pCBS, LValores.gCBS.gRed.pAliqEfet)));
  AddCelNFeABI(LLinha, S5, CLARG, 'VALOR CBS', NumeroNFeABI(LFS, LValores.gCBS.vCBS, 2));
  AddLinhaNFeABI(Result, LLinha);

  LLinha := nil;
  AddCelNFeABI(LLinha, 0, S2, 'VALOR TOTAL DO IBS', TextoTotalIBSNFeABI(FNFeABIUtils.NFeABI, LFS));
  AddCelNFeABI(LLinha, S2, S4, 'VALOR TOTAL DA CBS', TextoTotalCBSNFeABI(FNFeABIUtils.NFeABI, LFS));
  AddCelNFeABI(LLinha, S4, CLARG, 'VALOR TOTAL DA NF-E ABI', TextoTotalNFNFeABI(FNFeABIUtils.NFeABI, LFS),
    True);
  AddLinhaNFeABI(Result, LLinha);

  // Linhas adicionais: 3 campos por linha
  LExtras := ExtrasCalculoNFeABI(FNFeABIUtils);
  LLinha := nil;
  LColuna := 0;
  for I := 0 to High(LExtras) do
  begin
    case LColuna of
      0: AddCelNFeABI(LLinha, 0, S2, LExtras[I][0], LExtras[I][1]);
      1: AddCelNFeABI(LLinha, S2, S4, LExtras[I][0], LExtras[I][1]);
    else
      AddCelNFeABI(LLinha, S4, CLARG, LExtras[I][0], LExtras[I][1]);
    end;
    Inc(LColuna);
    if (LColuna = 3) or (I = High(LExtras)) then
    begin
      AddLinhaNFeABI(Result, LLinha);
      LLinha := nil;
      LColuna := 0;
    end;
  end;
end;

{ TBlocoObservacoesNFeABI }

constructor TBlocoObservacoesNFeABI.Create(ANFeABIUtils: TNFeABIUtilsFPDF; APaisagem: Boolean);
begin
  inherited Create(btData);
  FNFeABIUtils := ANFeABIUtils;
  FPaisagem := APaisagem;
end;

procedure TBlocoObservacoesNFeABI.OnInit(Args: TFPDFBandInitArgs);
begin
  // As (capacidade do quadro - 1) primeiras linhas ficam no quadro Informacoes complementares
  FProximo := CapacComplNFeABI(FPaisagem) - 1;
  AutoHeight := True;
  Visible := EstimarLinhasNFeABI(TextoComplementarNFeABI(FNFeABIUtils.NFeABI),
    LarguraTextoComplNFeABI(FPaisagem)) > CapacComplNFeABI(FPaisagem);
  Height := CALT_TITULO + 2.89 + 1.23;
end;

procedure TBlocoObservacoesNFeABI.OnDraw(Args: TFPDFBandDrawArgs);
var
  LPDF: IFPDF;
  LLinhas: TStringList;
  LInicio: Integer;
  LBaseUltima: Double;
  LLarg: Double;
begin
  LPDF := Args.PDF;

  LLinhas := TStringList.Create;
  try
    FonteTextoNFeABI(LPDF);
    QuebrarTextoNFeABI(LPDF, TextoComplementarNFeABI(FNFeABIUtils.NFeABI),
      LarguraTextoComplNFeABI(FPaisagem), LLinhas);
    if LLinhas.Count <= CapacComplNFeABI(FPaisagem) then
      Exit;

    // A continuacao so e impressa a partir da 2a folha: na 1a, consome o espaco restante
    // (sem desenhar nada visivel) para o engine quebrar a folha e repetir o bloco
    if LPDF.CurrentPage < 2 then
    begin
      ConsumirEspacoFolhaNFeABI(Args);
      Exit;
    end;

    PrepararTracoNFeABI(LPDF);

    DesenharTituloBlocoNFeABI(LPDF, 'INFORMAÇÕES COMPLEMENTARES (CONTINUAÇÃO)', 0);
  
    FonteTextoNFeABI(LPDF);
    LInicio := FProximo;
    LBaseUltima := CALT_TITULO + 2.89;
    while FProximo < LLinhas.Count do
    begin
      if (FProximo > LInicio) and (LBaseUltima + CENTRELINHA + 1.23 > Args.FreeSpace) then
        Break;

      if FProximo > LInicio then
        LBaseUltima := LBaseUltima + CENTRELINHA;
      TxtEsqNFeABI(LPDF, CPAD, LBaseUltima, LLinhas[FProximo]);
      Inc(FProximo);
    end;

    PrepararTracoNFeABI(LPDF);
    LLarg := LarguraNFeABI(FPaisagem);
    LinhaHNFeABI(LPDF, 0, LLarg, CALT_TITULO);
    LinhaVNFeABI(LPDF, 0, CALT_TITULO, LBaseUltima + 1.23);
    LinhaVNFeABI(LPDF, LLarg, CALT_TITULO, LBaseUltima + 1.23);
    LinhaHNFeABI(LPDF, 0, LLarg, LBaseUltima + 1.23);

    Args.DrawAgain := FProximo < LLinhas.Count;
  finally
    LLinhas.Free;
  end;
end;

{ TBlocoDadosAdicionaisNFeABI }

constructor TBlocoDadosAdicionaisNFeABI.Create(ABandType: TFPDFBandType;
  ANFeABIUtils: TNFeABIUtilsFPDF; APaisagem: Boolean);
begin
  inherited Create(ABandType);
  AutoHeight := False;
  FNFeABIUtils := ANFeABIUtils;
  FPaisagem := APaisagem;
end;

procedure TBlocoDadosAdicionaisNFeABI.OnInit(Args: TFPDFBandInitArgs);
begin
  // QR Code de contingencia (conteudo maior) precisa de um quadrado maior
  FQrGrande := Length(FNFeABIUtils.NFeABI.infNFeSupl.qrCode) > 300;
  if FPaisagem then
    DefinirMedidasPaisagem
  else
    DefinirMedidasRetrato;
  Height := CALT_TITULO + FAltura;
end;

procedure TBlocoDadosAdicionaisNFeABI.DefinirMedidasRetrato;
begin
  if FQrGrande then
  begin
    FQrTamanho := 35;
    FAltura := 47.8;
  end
  else
  begin
    FQrTamanho := 26.99;
    FAltura := 41.06;
  end;
end;

procedure TBlocoDadosAdicionaisNFeABI.DefinirMedidasPaisagem;
begin
  if FQrGrande then
  begin
    FQrTamanho := 32.38;
    FAltura := 38.73;
  end
  else
  begin
    FQrTamanho := 24.98;
    FAltura := 31.33;
  end;
end;

procedure TBlocoDadosAdicionaisNFeABI.OnDraw(Args: TFPDFBandDrawArgs);
var
  LPDF: IFPDF;
  LNFeABI: TNFeABI;
  LComplementares: TStringList;
  LFisco: TStringList;
  LBase: Double;
  LDivisao: Double;
  LLarg: Double;
  LXQr: Double;
  LAltCompl: Double;
  LCapCompl: Integer;
  LCapFisco: Integer;
  LMostrar: Integer;
  I: Integer;
begin
  LPDF := Args.PDF;
  LNFeABI := FNFeABIUtils.NFeABI;
  PrepararTracoNFeABI(LPDF);

  LLarg := LarguraNFeABI(FPaisagem);
  LXQr := XQrNFeABI(FPaisagem);
  LCapCompl := CapacComplNFeABI(FPaisagem);
  LCapFisco := CapacFiscoNFeABI(FPaisagem);
  if FPaisagem then
    LAltCompl := 17.99
  else
    LAltCompl := 24.91;

  LBase := CALT_TITULO + FAltura;
  LDivisao := CALT_TITULO + LAltCompl;

  DesenharTituloBlocoNFeABI(LPDF, 'DADOS ADICIONAIS', 0);

  // Indicacao de continuidade (somente quando o rodape se repete em varias folhas)
  if BandType = btPageFooter then
  begin
    if LPDF.CurrentPage < Args.TotalPages then
    begin
      FonteTituloNFeABI(LPDF);
      TxtDirNFeABI(LPDF, LLarg, CBASE_TITULO,
        'CONTINUA NA FOLHA ' + IntToStr(LPDF.CurrentPage + 1) + '/' + IntToStr(Args.TotalPages));
    end;
  end;

  // Moldura
  PrepararTracoNFeABI(LPDF);
  LinhaHNFeABI(LPDF, 0, LLarg, CALT_TITULO);
  LinhaHNFeABI(LPDF, 0, LXQr, LDivisao);
  LinhaHNFeABI(LPDF, 0, LLarg, LBase);
  LinhaVNFeABI(LPDF, 0, CALT_TITULO, LBase);
  LinhaVNFeABI(LPDF, LXQr, CALT_TITULO, LBase);
  LinhaVNFeABI(LPDF, LLarg, CALT_TITULO, LBase);

  LComplementares := TStringList.Create;
  LFisco := TStringList.Create;
  try
    FonteTextoNFeABI(LPDF);
    QuebrarTextoNFeABI(LPDF, TextoComplementarNFeABI(LNFeABI), LXQr - 2 * CPAD, LComplementares);
    QuebrarTextoNFeABI(LPDF, TextoFiscoNFeABI(LNFeABI), LXQr - 2 * CPAD, LFisco);
    // texto vazio gera uma linha em branco: nao ha o que imprimir
    if (LComplementares.Count = 1) and (LComplementares[0] = '') then
      LComplementares.Clear;
    if (LFisco.Count = 1) and (LFisco[0] = '') then
      LFisco.Clear;

    // Informacoes complementares
    FonteRotuloNFeABI(LPDF);
    TxtEsqNFeABI(LPDF, CPAD, CALT_TITULO + CBASE_ROTULO, 'INFORMAÇÕES COMPLEMENTARES');

    FonteTextoNFeABI(LPDF);
    if LComplementares.Count > LCapCompl then
      LMostrar := LCapCompl - 1
    else
      LMostrar := LComplementares.Count;
    for I := 0 to LMostrar - 1 do
      TxtEsqNFeABI(LPDF, CPAD, CALT_TITULO + 5.43 + I * CENTRELINHA, LComplementares[I]);

    if LComplementares.Count > LCapCompl then
    begin
      FonteTituloNFeABI(LPDF);
      TxtEsqNFeABI(LPDF, CPAD, CALT_TITULO + 5.43 + (LCapCompl - 1) * CENTRELINHA,
        'CONTINUA NO CORPO DA ÚLTIMA FOLHA');
    end;

    // Reservado ao Fisco
    FonteRotuloNFeABI(LPDF);
    TxtEsqNFeABI(LPDF, CPAD, LDivisao + CBASE_ROTULO, 'RESERVADO AO FISCO');

    FonteTextoNFeABI(LPDF);
    for I := 0 to Min(LFisco.Count, LCapFisco) - 1 do
      TxtEsqNFeABI(LPDF, CPAD, LDivisao + 5.43 + I * CENTRELINHA, LFisco[I]);
  finally
    LComplementares.Free;
    LFisco.Free;
  end;

  // Consulta via QR Code
  if FPaisagem then
    DesenharConsultaPaisagem(LPDF)
  else
    DesenharConsultaRetrato(LPDF);
end;

{ Quadro do QR Code no retrato: rotulo, QR Code e o texto de consulta em duas linhas }

procedure TBlocoDadosAdicionaisNFeABI.DesenharConsultaRetrato(APDF: IFPDF);
var
  LNFeABI: TNFeABI;
  LXQr: Double;
  LXCentro: Double;
  LQrY: Double;
  LDispTexto: Double;
  LTamFonte: Double;
begin
  LNFeABI := FNFeABIUtils.NFeABI;
  LXQr := XQrNFeABI(False);
  LXCentro := (LXQr + LarguraNFeABI(False)) / 2;
  LDispTexto := LarguraNFeABI(False) - LXQr - 2 * CPAD;

  FonteRotuloNFeABI(APDF);
  TxtEsqNFeABI(APDF, LXQr + CPAD, CALT_TITULO + 5.33, 'CONSULTA VIA QR CODE');

  if FQrGrande then
    LQrY := CALT_TITULO + 6.35
  else
    LQrY := CALT_TITULO + 6.22;

  if LNFeABI.infNFeSupl.qrCode <> '' then
  begin
    APDF.SetFillColor(0, 0, 0);
    APDF.QRCode(LXCentro - FQrTamanho / 2, LQrY, FQrTamanho,
      LNFeABI.infNFeSupl.qrCode);
  end;

  FonteRotuloNFeABI(APDF);
  TxtCenNFeABI(APDF, LXCentro, LQrY + FQrTamanho + 2.12, 'Consulte pela chave de acesso em:');
  if LNFeABI.infNFeSupl.urlChave <> '' then
  begin
    // Reduz a fonte se o endereco nao couber na largura do quadro
    LTamFonte := 5.5;
    if APDF.GetStringWidth(LNFeABI.infNFeSupl.urlChave) > LDispTexto then
      LTamFonte := 5.5 * LDispTexto / APDF.GetStringWidth(LNFeABI.infNFeSupl.urlChave);
    APDF.SetFont('Arial', '', LTamFonte);
    TxtCenNFeABI(APDF, LXCentro, LQrY + FQrTamanho + 4.34, LNFeABI.infNFeSupl.urlChave);
  end;
end;

{ Quadro do QR Code no paisagem: o QR Code segue a escala do modelo da NT e o texto de consulta
  fica em uma linha quando cabe no quadro; senao, o rotulo e o endereco em duas linhas }

procedure TBlocoDadosAdicionaisNFeABI.DesenharConsultaPaisagem(APDF: IFPDF);
var
  LNFeABI: TNFeABI;
  LXQr: Double;
  LXCentro: Double;
  LQrY: Double;
  LQrTam: Double;
  LDispTexto: Double;
  LTamFonte: Double;
  LTextoConsulta: string;
begin
  LNFeABI := FNFeABIUtils.NFeABI;
  LXQr := XQrNFeABI(True);
  LXCentro := (LXQr + LarguraNFeABI(True)) / 2;
  LDispTexto := LarguraNFeABI(True) - LXQr - 2 * CPAD;

  FonteRotuloNFeABI(APDF);
  TxtEsqNFeABI(APDF, LXQr + CPAD, CALT_TITULO + CBASE_ROTULO, 'CONSULTA VIA QR CODE');

  LTextoConsulta := 'Consulte pela chave de acesso em:';
  if LNFeABI.infNFeSupl.urlChave <> '' then
    LTextoConsulta := LTextoConsulta + ' ' + LNFeABI.infNFeSupl.urlChave;

  // O desenho do QR Code e menor que o espaco reservado e fica centralizado nele
  LQrTam := FQrTamanho * 0.875;
  LQrY := CALT_TITULO + 3.51 + (FQrTamanho - LQrTam) / 2;

  if LNFeABI.infNFeSupl.qrCode <> '' then
  begin
    APDF.SetFillColor(0, 0, 0);
    APDF.QRCode(LXCentro - LQrTam / 2, LQrY, LQrTam,
      LNFeABI.infNFeSupl.qrCode);
  end;

  FonteRotuloNFeABI(APDF);
  if APDF.GetStringWidth(LTextoConsulta) <= LDispTexto then
    TxtCenNFeABI(APDF, LXCentro, CALT_TITULO + FAltura - 0.53, LTextoConsulta)
  else
  begin
    TxtCenNFeABI(APDF, LXCentro, LQrY + LQrTam + 1.76, 'Consulte pela chave de acesso em:');
    if LNFeABI.infNFeSupl.urlChave <> '' then
    begin
      // Reduz a fonte se o endereco nao couber na largura do quadro
      LTamFonte := 5.5;
      if APDF.GetStringWidth(LNFeABI.infNFeSupl.urlChave) > LDispTexto then
        LTamFonte := 5.5 * LDispTexto / APDF.GetStringWidth(LNFeABI.infNFeSupl.urlChave);
      APDF.SetFont('Arial', '', LTamFonte);
      TxtCenNFeABI(APDF, LXCentro, CALT_TITULO + FAltura - 0.53, LNFeABI.infNFeSupl.urlChave);
    end;
  end;
end;

{ TBlocoRodapeNFeABI }

constructor TBlocoRodapeNFeABI.Create(const AMensagem: String);
begin
  inherited Create(btPageFooter);
  FMensagem := AMensagem;
end;

procedure TBlocoRodapeNFeABI.OnInit(Args: TFPDFBandInitArgs);
begin
  Height := 5;
end;

procedure TBlocoRodapeNFeABI.OnDraw(Args: TFPDFBandDrawArgs);
var
  LPDF: IFPDF;
  x, y, w, h: Double;
  Mensagens: TStringArray;
begin
  LPDF := Args.PDF;
  if FMensagem = '' then
    Exit;
  Mensagens := ACBr_fpdf.Split(FMensagem, '|');

  x := 0;
  y := 0;
  w := Width;
  h := Height;

  LPDF.SetFont(6, 'I');
  if Length(Mensagens) >= 1 then
    LPDF.TextBox(x, y, w, h, Mensagens[0], 'T', 'L', 0);
  if Length(Mensagens) >= 2 then
    LPDF.TextBox(x, y, w, h, Mensagens[1], 'T', 'C', 0);
  if Length(Mensagens) >= 3 then
    LPDF.TextBox(x, y, w, h, Mensagens[2], 'T', 'R', 0);
end;

function DescEventoNFeABI(const AInfEvento: TInfEvento): String;
begin
  case AInfEvento.tpEvento of
    teCancelamento: Result := 'Cancelamento';
    tePagamentoOperacao: Result := 'Pagamento de Parcela';
    teApropCredIndNFeABI: Result := 'Apropriacao de Creditos Individuais';
    teDesfazAlienacNFeABI: Result := 'Desfazimento da Alienacao';
  else
    Result := 'Evento (Tipo ' + AInfEvento.TipoEvento + ')';
  end;
end;

{ TBlocoMarcaDaguaEventoNFeABI }

constructor TBlocoMarcaDaguaEventoNFeABI.Create(AEvento: TInfEventoCollectionItem);
begin
  inherited Create(btWatermark);
  FEvento := AEvento;
end;

function TBlocoMarcaDaguaEventoNFeABI.Watermark(Args: TFPDFBandDrawArgs; x, y,
  w, h: double; const ATexto: string; AFontSize: Double;
  const AFontStyle: string): double;
begin
  Args.PDF.SetTextColor(230, 230, 230);
  Args.PDF.SetFont('Arial', AFontStyle, AFontSize);
  Args.PDF.TextBox(x, y, w, h, ATexto, 'C', 'C', False, False, True);
  Args.PDF.SetTextColor(0, 0, 0);
  Result := y;
end;

procedure TBlocoMarcaDaguaEventoNFeABI.OnDraw(Args: TFPDFBandDrawArgs);
var
  x, y, w, m: double;
begin
  if FEvento.InfEvento.tpAmb <> taHomologacao then
    Exit;

  m := 5;
  x := Args.LeftMargin + m;
  w := Width - (2 * m);

  y := Watermark(Args, x, RoundTo(Height / 2, 0), w, 5, 'SEM VALOR FISCAL', 48);
  Watermark(Args, x, y + 14, w, 5, 'AMBIENTE DE HOMOLOGACAO', 30);
end;

{ TBlocoCabecalhoEventoNFeABI }

constructor TBlocoCabecalhoEventoNFeABI.Create(ANFeABI: TNFeABI;
  AEvento: TInfEventoCollectionItem);
begin
  inherited Create(btPageHeader);
  FNFeABI := ANFeABI;
  FEvento := AEvento;
end;

procedure TBlocoCabecalhoEventoNFeABI.OnInit(Args: TFPDFBandInitArgs);
begin
  Height := 18;
end;

procedure TBlocoCabecalhoEventoNFeABI.OnDraw(Args: TFPDFBandDrawArgs);
var
  LPDF: IFPDF;
  x, y, w: Double;
  LTexto: String;
begin
  LPDF := Args.PDF;
  x := 0;
  y := 0;
  w := Args.Band.Width;

  LPDF.SetFont('Arial', 'B', 12);
  y := y + 2;
  y := y + LPDF.TextBox(x, y, w, 5, DescEventoNFeABI(FEvento.InfEvento), 'T', 'C', 0, '');
  y := y + 1;

  LPDF.SetFont('Arial', '', 10);
  LTexto := 'Nao possui valor fiscal, simples representacao do fato indicado abaixo.';
  y := y + LPDF.TextBox(x, y, w, 5, LTexto, 'T', 'C', 0, '');
  y := y + 1;

  LPDF.SetFont('Arial', '', 10);
  LTexto := 'CONSULTE A AUTENTICIDADE DA NF-e ABI NO SITE DA SEFAZ AUTORIZADORA.';
  LPDF.TextBox(x, y, w, 5, LTexto, 'T', 'C', 0, '');
end;

{ TBlocoDadosNFeABIEventoNFeABI }

constructor TBlocoDadosNFeABIEventoNFeABI.Create(ANFeABI: TNFeABI);
begin
  inherited Create(btData);
  FNFeABI := ANFeABI;
end;

procedure TBlocoDadosNFeABIEventoNFeABI.OnInit(Args: TFPDFBandInitArgs);
begin
  Height := 22;
end;

procedure TBlocoDadosNFeABIEventoNFeABI.OnDraw(Args: TFPDFBandDrawArgs);
var
  LPDF: IFPDF;
  oldX, maxW, x, y, w, h, w1, w2: Double;
  LTexto: String;
begin
  LPDF := Args.PDF;
  x := 0;
  y := 1;
  oldX := x;
  maxW := Args.Band.Width;

  LPDF.SetFont('Arial', 'B', 7);
  LPDF.TextBox(x, y, maxW, 4, 'NF-e ABI (NOTA FISCAL ELETRONICA DE ALIENACAO DE BENS IMOVEIS)', 'T', 'L', 0, '');
  y := y + 4;

  h := 8;
  w1 := RoundTo(maxW * 0.10, 0);
  w := w1;
  SetFontBoxHeaderNFeABI(LPDF);
  LPDF.TextBox(x, y, w, h, 'MODELO', 'T', 'C', 1, '');
  LTexto := IntToStr(FNFeABI.Ide.modelo);
  SetFontBoxContentNFeABI(LPDF);
  LPDF.TextBox(x, y, w, h, LTexto, 'B', 'C', 0, '');

  x := x + w;
  w2 := RoundTo(maxW * 0.20, 0);
  w := w2;
  SetFontBoxHeaderNFeABI(LPDF);
  LPDF.TextBox(x, y, w, h, 'DATA/HORA DE EMISSAO', 'T', 'L', 1, '');
  LTexto := FormatDateTimeBr(FNFeABI.Ide.dhEmi);
  SetFontBoxContentNFeABI(LPDF);
  LPDF.TextBox(x, y, w, h, LTexto, 'B', 'C', 0, '');

  x := x + w;
  w := maxW - w1 - w2;
  LPDF.TextBox(x, y, w, h);
  LPDF.SetFillColor(0, 0, 0);
  LPDF.Code128(RemoverLiteralChave(FNFeABI.infNFeABI.Id), x + 4, y + 1, h - 2, w - 8);

  x := oldX;
  y := y + h;
  w := maxW;
  SetFontBoxHeaderNFeABI(LPDF);
  LPDF.TextBox(x, y, w, h, 'CHAVE DE ACESSO', 'T', 'L', 1, '');
  LTexto := FormatarChaveAcesso(FNFeABI.infNFeABI.Id);
  SetFontBoxContentBoldNFeABI(LPDF);
  LPDF.TextBox(x, y, w, h, LTexto, 'B', 'L', 0, '');
end;

{ TBlocoEmitenteEventoNFeABI }

constructor TBlocoEmitenteEventoNFeABI.Create(ANFeABI: TNFeABI);
begin
  inherited Create(btData);
  FNFeABI := ANFeABI;
end;

procedure TBlocoEmitenteEventoNFeABI.OnInit(Args: TFPDFBandInitArgs);
begin
  Height := 22;
end;

procedure TBlocoEmitenteEventoNFeABI.OnDraw(Args: TFPDFBandDrawArgs);
var
  LPDF: IFPDF;
  oldX, maxW, x, y, w, h, w1, w2: Double;
  LTexto: String;
begin
  LPDF := Args.PDF;
  x := 0;
  y := 1;
  oldX := x;
  maxW := Args.Band.Width;

  LPDF.SetFont('Arial', 'B', 7);
  LPDF.TextBox(x, y, maxW, 4, 'EMITENTE', 'T', 'L', 0, '');
  y := y + 4;

  h := 8;
  w1 := RoundTo(maxW * 0.60, 0);
  w := w1;
  SetFontBoxHeaderNFeABI(LPDF);
  LPDF.TextBox(x, y, w, h, 'NOME / RAZAO SOCIAL', 'T', 'L', 1, '');
  SetFontBoxContentNFeABI(LPDF);
  LPDF.TextBox(x, y, w, h, FNFeABI.Emit.xNome, 'B', 'L', 0, '');

  x := x + w;
  w2 := maxW - w1;
  w := w2;
  SetFontBoxHeaderNFeABI(LPDF);
  LPDF.TextBox(x, y, w, h, 'CNPJ / CPF', 'T', 'L', 1, '');
  LTexto := FormatarCNPJouCPF(FNFeABI.Emit.CNPJCPF);
  SetFontBoxContentBoldNFeABI(LPDF);
  LPDF.TextBox(x, y, w, h, LTexto, 'B', 'C', 0, '');

  x := oldX;
  y := y + h;
  w1 := RoundTo(maxW * 0.46, 0);
  w := w1;
  SetFontBoxHeaderNFeABI(LPDF);
  LPDF.TextBox(x, y, w, h, 'ENDERECO', 'T', 'L', 1, '');
  LTexto := FNFeABI.Emit.EnderEmit.xLgr + ', ' + FNFeABI.Emit.EnderEmit.nro;
  if FNFeABI.Emit.EnderEmit.xCpl <> '' then
    LTexto := LTexto + ' - ' + FNFeABI.Emit.EnderEmit.xCpl;
  SetFontBoxContentNFeABI(LPDF);
  LPDF.TextBox(x, y, w, h, LTexto, 'B', 'L', 0, '');

  x := x + w;
  w2 := RoundTo(maxW * 0.30, 0);
  w := w2;
  SetFontBoxHeaderNFeABI(LPDF);
  LPDF.TextBox(x, y, w, h, 'MUNICIPIO / UF', 'T', 'L', 1, '');
  LTexto := FNFeABI.Emit.EnderEmit.xMun + ' / ' + FNFeABI.Emit.EnderEmit.UF;
  SetFontBoxContentNFeABI(LPDF);
  LPDF.TextBox(x, y, w, h, LTexto, 'B', 'L', 0, '');

  x := x + w;
  w := maxW - w1 - w2;
  SetFontBoxHeaderNFeABI(LPDF);
  LPDF.TextBox(x, y, w, h, 'CEP', 'T', 'L', 1, '');
  LTexto := FormatarCEP(FNFeABI.Emit.EnderEmit.CEP);
  SetFontBoxContentNFeABI(LPDF);
  LPDF.TextBox(x, y, w, h, LTexto, 'B', 'C', 0, '');
end;

{ TBlocoDadosEventoNFeABI }

constructor TBlocoDadosEventoNFeABI.Create(ANFeABI: TNFeABI;
  AEvento: TInfEventoCollectionItem);
begin
  inherited Create(btData);
  FNFeABI := ANFeABI;
  FEvento := AEvento;
end;

procedure TBlocoDadosEventoNFeABI.OnInit(Args: TFPDFBandInitArgs);
begin
  Height := 27;
end;

procedure TBlocoDadosEventoNFeABI.OnDraw(Args: TFPDFBandDrawArgs);
var
  LPDF: IFPDF;
  oldX, maxW, x, y, w, h, w1, w2, w3: Double;
  LTexto: String;
begin
  LPDF := Args.PDF;
  x := 0;
  y := 1;
  oldX := x;
  maxW := Args.Band.Width;

  LPDF.SetFont('Arial', 'B', 7);
  LPDF.TextBox(x, y, maxW, 4, 'DADOS DO EVENTO', 'T', 'L', 0, '');
  y := y + 4;
  h := 7;

  w1 := RoundTo(maxW * 0.12, 0);
  w := w1;
  SetFontBoxHeaderNFeABI(LPDF);
  LPDF.TextBox(x, y, w, h, 'ORGAO', 'T', 'C', 1, '');
  LTexto := CodigoUFparaUF(FEvento.InfEvento.cOrgao);
  SetFontBoxContentNFeABI(LPDF);
  LPDF.TextBox(x, y, w, h, LTexto, 'B', 'C', 0, '');

  x := x + w;
  w2 := RoundTo(maxW * 0.58, 0);
  w := w2;
  SetFontBoxHeaderNFeABI(LPDF);
  LPDF.TextBox(x, y, w, h, 'AMBIENTE', 'T', 'L', 1, '');
  LTexto := IfThen(FEvento.InfEvento.tpAmb = taProducao, '1 - PRODUCAO', '2 - HOMOLOGACAO (SEM VALOR FISCAL)');
  SetFontBoxContentNFeABI(LPDF);
  LPDF.TextBox(x, y, w, h, LTexto, 'B', 'L', 0, '');

  x := x + w;
  w := maxW - w1 - w2;
  SetFontBoxHeaderNFeABI(LPDF);
  LPDF.TextBox(x, y, w, h, 'DATA/HORA DO EVENTO', 'T', 'L', 1, '');
  LTexto := FormatDateTimeBr(FEvento.InfEvento.dhEvento);
  SetFontBoxContentNFeABI(LPDF);
  LPDF.TextBox(x, y, w, h, LTexto, 'B', 'C', 0, '');

  x := oldX;
  y := y + h;
  w1 := RoundTo(maxW * 0.14, 0);
  w := w1;
  SetFontBoxHeaderNFeABI(LPDF);
  LPDF.TextBox(x, y, w, h, 'EVENTO', 'T', 'L', 1, '');
  SetFontBoxContentNFeABI(LPDF);
  LPDF.TextBox(x, y, w, h, FEvento.InfEvento.TipoEvento, 'B', 'C', 0, '');

  x := x + w;
  w2 := RoundTo(maxW * 0.56, 0);
  w := w2;
  SetFontBoxHeaderNFeABI(LPDF);
  LPDF.TextBox(x, y, w, h, 'DESCRICAO DO EVENTO', 'T', 'L', 1, '');
  SetFontBoxContentNFeABI(LPDF);
  LPDF.TextBox(x, y, w, h, DescEventoNFeABI(FEvento.InfEvento), 'B', 'L', 0, '');

  x := x + w;
  w3 := RoundTo((maxW - w1 - w2) / 2, 0);
  w := w3;
  SetFontBoxHeaderNFeABI(LPDF);
  LPDF.TextBox(x, y, w, h, 'SEQUENCIAL', 'T', 'L', 1, '');
  SetFontBoxContentNFeABI(LPDF);
  LPDF.TextBox(x, y, w, h, IntToStr(FEvento.InfEvento.nSeqEvento), 'B', 'C', 0, '');

  x := x + w;
  w := maxW - w1 - w2 - w3;
  SetFontBoxHeaderNFeABI(LPDF);
  LPDF.TextBox(x, y, w, h, 'VERSAO', 'T', 'L', 1, '');
  SetFontBoxContentNFeABI(LPDF);
  LPDF.TextBox(x, y, w, h, FEvento.InfEvento.detEvento.versao, 'B', 'C', 0, '');

  x := oldX;
  y := y + h;
  w1 := RoundTo(maxW * 0.50, 0);
  w := w1;
  SetFontBoxHeaderNFeABI(LPDF);
  LPDF.TextBox(x, y, w, h, 'STATUS', 'T', 'L', 1, '');
  if FEvento.RetInfEvento.nProt <> '' then
    LTexto := Format('%d - %s', [FEvento.RetInfEvento.cStat, FEvento.RetInfEvento.xMotivo])
  else
    LTexto := 'Evento ainda nao registrado na SEFAZ';
  SetFontBoxContentNFeABI(LPDF);
  LPDF.TextBox(x, y, w, h, LTexto, 'B', 'L', 0, '');

  x := x + w;
  w2 := RoundTo((maxW - w1) / 2, 0);
  w := w2;
  SetFontBoxHeaderNFeABI(LPDF);
  LPDF.TextBox(x, y, w, h, 'PROTOCOLO DE REGISTRO DO EVENTO', 'T', 'L', 1, '');
  SetFontBoxContentBoldNFeABI(LPDF);
  LPDF.TextBox(x, y, w, h, FEvento.RetInfEvento.nProt, 'B', 'C', 0, '');

  x := x + w;
  w := maxW - w1 - w2;
  SetFontBoxHeaderNFeABI(LPDF);
  LPDF.TextBox(x, y, w, h, 'DATA/HORA DO REGISTRO', 'T', 'L', 1, '');
  LTexto := '';
  if FEvento.RetInfEvento.dhRegEvento > 0 then
    LTexto := FormatDateTimeBr(FEvento.RetInfEvento.dhRegEvento);
  SetFontBoxContentNFeABI(LPDF);
  LPDF.TextBox(x, y, w, h, LTexto, 'B', 'C', 0, '');
end;

{ TBlocoJustificativaEventoNFeABI }

constructor TBlocoJustificativaEventoNFeABI.Create(AEvento: TInfEventoCollectionItem);
begin
  inherited Create(btData);
  FEvento := AEvento;
end;

procedure TBlocoJustificativaEventoNFeABI.OnInit(Args: TFPDFBandInitArgs);
begin
  Height := 35;
end;

procedure TBlocoJustificativaEventoNFeABI.OnDraw(Args: TFPDFBandDrawArgs);
var
  LPDF: IFPDF;
  x, y, w, h: Double;
  LTitulo, LTexto: String;
begin
  LPDF := Args.PDF;
  x := 0;
  y := 1;
  w := Args.Band.Width;
  h := Args.Band.Height - y;

  if FEvento.InfEvento.tpEvento = teCancelamento then
  begin
    LTitulo := 'JUSTIFICATIVA DO CANCELAMENTO';
    LTexto := FEvento.InfEvento.detEvento.xJust;
  end
  else if FEvento.InfEvento.tpEvento = teDesfazAlienacNFeABI then
  begin
    LTitulo := 'DESFAZIMENTO DA ALIENACAO';
    LTexto := 'Tipo: ' + tpDesfazToStr(FEvento.InfEvento.detEvento.tpDesfaz) +
              ' - Data: ' + FormatDateTime('dd/mm/yyyy', FEvento.InfEvento.detEvento.dtDesfaz);
    if FEvento.InfEvento.detEvento.xDesfaz <> '' then
      LTexto := LTexto + ' - ' + FEvento.InfEvento.detEvento.xDesfaz;
  end
  else
  begin
    LTitulo := 'OBSERVACOES';
    LTexto := '';
  end;

  LPDF.SetFont('Arial', 'B', 7);
  LPDF.TextBox(x, y, w, 4, LTitulo, 'T', 'L', 0, '');
  y := y + 4;

  LPDF.Rect(x, y, w, h - 4);

  SetFontBoxContentNFeABI(LPDF);
  LPDF.TextBox(x + 2, y + 2, w - 4, h - 6, LTexto, 'T', 'L', 0, '', False);
end;

{ TNFeABIDANFeABIFPDF }

constructor TNFeABIDANFeABIFPDF.Create(ANFeABI: TNFeABI;
  ADANFeABIClassOwner: TACBrNFeABIDANFEABIClass);
var
  LFormatSettings: TFormatSettings;
begin
  inherited Create;
  FNFeABIUtils := TNFeABIUtilsFPDF.Create(ANFeABI, ADANFeABIClassOwner);
  FNFeABI := ANFeABI;
  FDANFeABIClassOwner := ADANFeABIClassOwner;
  FillChar(LFormatSettings, SizeOf(LFormatSettings), 0);
  {$IFDEF HAS_FORMATSETTINGS}
    LFormatSettings := CreateFormatSettings;
  {$ENDIF}
  LFormatSettings.DecimalSeparator := ',';
  LFormatSettings.ThousandSeparator := '.';
  FNFeABIUtils.FormatSettings := LFormatSettings;

  SetFont('Times');
  SetUTF8(False);
  EngineOptions.DoublePass := True;

  SetMargins(10, 10);
end;

destructor TNFeABIDANFeABIFPDF.Destroy;
begin
  FNFeABIUtils.Free;
  inherited;
end;

{ Estima se todo o conteudo cabe em uma unica folha. Nesse caso os "Dados
  adicionais" seguem logo abaixo do ultimo bloco, como no modelo de referencia;
  caso contrario ficam ancorados no rodape de cada folha (item 6.5 da NT). }
procedure TNFeABIDANFeABIFPDF.OnStartReport(Args: TFPDFReportEventArgs);
var
  LPaisagem: Boolean;
  LStream: TMemoryStream;
  LLogoStringStream: TStringStream;
begin
  if not FInitialized then
  begin
    if FNFeABI = nil then
      raise Exception.Create('NFeABI not initialized');

    if FNFeABI.Ide.tpNF = tdTransicao then
      raise Exception.Create('A NF-e ABI de transição (tpNF=2) não possui DANFE-ABI ' +
        '(tpImp deve ser 0 - Sem geração de DANFE)');

    if FDANFeABIClassOwner.Logo <> '' then
    begin
      LStream := TMemoryStream.Create;
      try
        if FileExists(FDANFeABIClassOwner.Logo) then
          LStream.LoadFromFile(FDANFeABIClassOwner.Logo)
        else
        begin
          LLogoStringStream := TStringStream.Create(FDANFeABIClassOwner.Logo);
          try
            LStream.LoadFromStream(LLogoStringStream);
            LStream.Position := 0;
          finally
            LLogoStringStream.Free;
          end;
        end;
        SetLength(FLogo, LStream.Size);
        LStream.Position := 0;
        LStream.Read(FLogo[1], LStream.Size);
      finally
        LStream.Free;
      end;
    end;

    LPaisagem := FNFeABI.Ide.tpImp = tiPaisagem;
    if LPaisagem then
    begin
      SetMargins(12.5, 10, 12.5, 10);
      AddPage(poLandscape);
    end
    else
      AddPage(poPortrait);

    AddBand(TBlocoMarcaDaguaNFeABI.Create(FNFeABIUtils, FDANFeABIClassOwner.Cancelada));
    AddBand(TBlocoCabecalhoNFeABI.Create(FNFeABIUtils, FLogo, FDANFeABIClassOwner.ExpandeLogoMarca,
      FDANFeABIClassOwner.Protocolo, LPaisagem));
    if LPaisagem then
      AddBand(TBlocoPartesNFeABI.Create(FNFeABIUtils))
    else
    begin
      AddBand(TBlocoTransmitentesNFeABI.Create(FNFeABIUtils));
      AddBand(TBlocoAdquirentesNFeABI.Create(FNFeABIUtils));
    end;
    AddBand(TBlocoImovelNFeABI.Create(FNFeABIUtils, LPaisagem));
    AddBand(TBlocoOperacaoNFeABI.Create(FNFeABIUtils, LPaisagem));
    AddBand(TBlocoPagamentoNFeABI.Create(FNFeABIUtils, LPaisagem));
    AddBand(TBlocoCalculoNFeABI.Create(FNFeABIUtils, LPaisagem));
    AddBand(TBlocoObservacoesNFeABI.Create(FNFeABIUtils, LPaisagem));
    // Ancorado no fim da folha (em todas as folhas quando o documento tem varias)
    AddBand(TBlocoDadosAdicionaisNFeABI.Create(btPageFooter, FNFeABIUtils, LPaisagem));
    AddBand(TBlocoRodapeNFeABI.Create(FMensagemRodape));

    FInitialized := True;
  end;
end;

{ TNFeABIDANFeABIEventoFPDF }

constructor TNFeABIDANFeABIEventoFPDF.Create(ANFeABI: TNFeABI;
  AEvento: TInfEventoCollectionItem);
begin
  inherited Create;
  FNFeABI := ANFeABI;
  FEvento := AEvento;

  SetFont('Times');
  SetUTF8(False);
  EngineOptions.DoublePass := True;

  SetMargins(10, 10);
end;

procedure TNFeABIDANFeABIEventoFPDF.OnStartReport(Args: TFPDFReportEventArgs);
begin
  if not FInitialized then
  begin
    if FNFeABI = nil then
      raise Exception.Create('NFeABI not initialized');
    if FEvento = nil then
      raise Exception.Create('Evento not initialized');

    AddPage(poPortrait);
    AddBand(TBlocoMarcaDaguaEventoNFeABI.Create(FEvento));
    AddBand(TBlocoCabecalhoEventoNFeABI.Create(FNFeABI, FEvento));
    AddBand(TBlocoDadosNFeABIEventoNFeABI.Create(FNFeABI));
    AddBand(TBlocoEmitenteEventoNFeABI.Create(FNFeABI));
    AddBand(TBlocoDadosEventoNFeABI.Create(FNFeABI, FEvento));
    AddBand(TBlocoJustificativaEventoNFeABI.Create(FEvento));
    AddBand(TBlocoRodapeNFeABI.Create(FMensagemRodape));

    FInitialized := True;
  end;
end;

{ TACBrNFeABIDANFeABIFPDF }

constructor TACBrNFeABIDANFeABIFPDF.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TACBrNFeABIDANFeABIFPDF.Destroy;
begin
  FFPDFReport.Free;
  inherited;
end;

procedure TACBrNFeABIDANFeABIFPDF.ImprimirDANFeABI(ANFeABI: TNFeABI);
begin
  inherited;
end;

procedure TACBrNFeABIDANFeABIFPDF.ImprimirDANFeABIPDF(ANFeABI: TNFeABI);
var
  Report: TFPDFReport;
  Engine: TFPDFEngine;
  I: Integer;
  LNFeABI: TNFeABI;
  LPath: String;
begin
  for I := 0 to TACBrNFeABI(ACBrNFeABI).NotasFiscais.Count - 1 do
  begin
    LNFeABI := TACBrNFeABI(ACBrNFeABI).NotasFiscais[I].NFeABI;
    Report := TNFeABIDANFeABIFPDF.Create(LNFeABI, TACBrNFeABIDANFEABIClass(TACBrNFeABI(ACBrNFeABI).DANFEABI));

    FIndexImpressaoIndividual := I;

    TNFeABIDANFeABIFPDF(Report).MensagemRodape := Self.Sistema;

    try
      Engine := TFPDFEngine.Create(Report, False);
      try
        Engine.Compressed := True;
        if Assigned(FStream) then
        begin
          FPArquivoPDF := RemoverLiteralChave(LNFeABI.infNFeABI.Id) + '-nfeabi.pdf';
          Engine.SaveToStream(FStream);
        end
        else
        begin
          LPath := DefinirNomeArquivo(TACBrNFeABI(ACBrNFeABI).DANFEABI.PathPDF,
                 RemoverLiteralChave(LNFeABI.infNFeABI.Id) + '-nfeabi.pdf',
                 TACBrNFeABI(ACBrNFeABI).DANFEABI.NomeDocumento);

          ForceDirectories(ExtractFilePath(LPath));

          Engine.SaveToFile(LPath);
          FPArquivoPDF := LPath;
        end;
      finally
        Engine.Free;
      end;
    finally
      Report.Free;
    end;
  end;
end;

procedure TACBrNFeABIDANFeABIFPDF.ImprimirDANFeABIPDF(AStream: TStream; ANFeABI: TNFeABI);
begin
  FStream := AStream;

  if not Assigned(FStream) then
    raise Exception.Create('Stream not initialized');

  ImprimirDANFeABIPDF(ANFeABI);
end;

procedure TACBrNFeABIDANFeABIFPDF.ImprimirEVENTO(ANFeABI: TNFeABI);
begin
  inherited;
end;

procedure TACBrNFeABIDANFeABIFPDF.ImprimirEVENTOPDF(ANFeABI: TNFeABI);
var
  Report: TFPDFReport;
  Engine: TFPDFEngine;
  I: Integer;
  LNFeABI: TNFeABI;
  LEvento: TInfEventoCollectionItem;
  LPath: String;
begin
  for I := 0 to TACBrNFeABI(ACBrNFeABI).EventoNFeABI.Evento.Count - 1 do
  begin
    LNFeABI := TACBrNFeABI(ACBrNFeABI).NotasFiscais[I].NFeABI;
    LEvento := TACBrNFeABI(ACBrNFeABI).EventoNFeABI.Evento[I];

    Report := TNFeABIDANFeABIEventoFPDF.Create(LNFeABI, LEvento);

    FIndexImpressaoIndividual := I;

    TNFeABIDANFeABIEventoFPDF(Report).MensagemRodape := Self.Sistema;

    try
      Engine := TFPDFEngine.Create(Report, False);
      try
        Engine.Compressed := True;
        if Assigned(FStream) then
        begin
          FPArquivoPDF := RemoverLiteralChave(LNFeABI.infNFeABI.Id) + '-' + LEvento.InfEvento.TipoEvento + '-evento.pdf';
          Engine.SaveToStream(FStream);
        end
        else
        begin
          LPath := DefinirNomeArquivo(TACBrNFeABI(ACBrNFeABI).DANFEABI.PathPDF,
                 RemoverLiteralChave(LNFeABI.infNFeABI.Id) + '-' + LEvento.InfEvento.TipoEvento + '-evento.pdf',
                 TACBrNFeABI(ACBrNFeABI).DANFEABI.NomeDocumento);

          ForceDirectories(ExtractFilePath(LPath));

          Engine.SaveToFile(LPath);
          FPArquivoPDF := LPath;
        end;
      finally
        Engine.Free;
      end;
    finally
      Report.Free;
    end;
  end;
end;

procedure TACBrNFeABIDANFeABIFPDF.ImprimirEVENTOPDF(AStream: TStream; ANFeABI: TNFeABI);
begin
  FStream := AStream;

  if not Assigned(FStream) then
    raise Exception.Create('Stream not initialized');

  ImprimirEVENTOPDF(ANFeABI);
end;

end.
