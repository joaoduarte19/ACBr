{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{      Celso Marigo Junior                                                     }
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

unit ACBrNFeDANFeFPDFRTC;

interface

uses
  Classes,
  SysUtils,
  ACBr_fpdf,
  ACBr_fpdf_report,
  ACBrNFe.Classes,
  ACBrNFeUtilsFPDF,
  ACBrDFe.Conversao,
  pcnConversaoNFe,
  ACBrNFeDANFEClass,
  ACBrNFeDANFeRTC;

type
  { TNFeDANFeFPDFRTC }

  TNFeDANFeFPDFRTC = class(TFPDFReport)
  private
    FDANFEClassOwner: TACBrNFeDANFEClass;
    FNFeUtils: TNFeUtilsFPDF;
    FRTC: TACBrNFeDANFeRTC;
    FLogo: TMemoryStream;
    FInicializado: Boolean;
    FMensagemRodape: String;
    FPaisagem: Boolean;
    FAlturaLinha: Double;
    FAlturaTitulo: Double;
    FAlturaIdentificacao: Double;
    FFonteValor: Double;
    FFonteRotulo: Double;
    FMargemRotulo: Double;
    FDeslocamentoValor: Double;
    FTamanhoQRCode: Double;

    procedure DefinirMargens;
    procedure CarregarLogo;
  protected
    procedure OnStartReport(Args: TFPDFReportEventArgs); override;
  public
    constructor Create(ANFe: TNFe; ADANFEClassOwner: TACBrNFeDANFEClass); reintroduce;
    destructor Destroy; override;

    function NumeroNF: String;
    function SerieNF: String;

    property DANFEClassOwner: TACBrNFeDANFEClass read FDANFEClassOwner;
    property NFeUtils: TNFeUtilsFPDF read FNFeUtils;
    property RTC: TACBrNFeDANFeRTC read FRTC;
    property Logo: TMemoryStream read FLogo;
    property MensagemRodape: String read FMensagemRodape write FMensagemRodape;
    property Paisagem: Boolean read FPaisagem;
    property AlturaLinha: Double read FAlturaLinha;
    property AlturaTitulo: Double read FAlturaTitulo;
    property AlturaIdentificacao: Double read FAlturaIdentificacao;
    property FonteValor: Double read FFonteValor;
    property FonteRotulo: Double read FFonteRotulo;
    property MargemRotulo: Double read FMargemRotulo;
    property DeslocamentoValor: Double read FDeslocamentoValor;
    property TamanhoQRCode: Double read FTamanhoQRCode;
  end;

implementation

uses
  StrUtils,
  Math,
  ACBrDFeUtil,
  ACBrValidador,
  ACBrUtil.Base,
  ACBrUtil.Strings,
  ACBrUtil.DateTime;

const
  cAlturaCanhoto = 17;
  cMaxLinhasFatura = 8;
  cDuplicatasPorLinha = 3;
  cColunasItens = 8;

type
  TItemDesenhoRTC = record
    Descricao: TStringArray;
    Adicional: TStringArray;
    Classificacao: String;
    Quantidades: TStringArray;
    Unidades: TStringArray;
    ValoresUnitarios: TStringArray;
    ValorTotal: String;
    Altura: Double;
  end;

  { TBlocoRTC }

  TBlocoRTC = class(TFPDFBand)
  private
    FReport: TNFeDANFeFPDFRTC;
  protected
    function NFe: TNFe;
    procedure Titulo(const APDF: IFPDF; AX, AY, AW: Double; const ATexto: String;
      AAlinhamento: Char = 'L');
    procedure Campo(const APDF: IFPDF; AX, AY, AW, AH: Double; const ARotulo, AValor: String;
      AAlinhamento: Char = 'L'; const AEstilo: String = '');
    procedure Linha(const APDF: IFPDF; AY, ALargura: Double; const AProporcoes: array of Double;
      const ARotulos, AValores: array of String; const AAlinhamentos: String = '';
      const AEstilo: String = '');
    property Report: TNFeDANFeFPDFRTC read FReport;
  public
    constructor Create(ABandType: TFPDFBandType; AReport: TNFeDANFeFPDFRTC); reintroduce;
  end;

  { TBlocoCanhotoRTC }

  TBlocoCanhotoRTC = class(TBlocoRTC)
  private
    FPosicao: TPosRecibo;
    FDireita: Boolean;

    procedure DesenharCanhoto(const APDF: IFPDF; AX, AY, AW: Double; ANFePrimeiro: Boolean);
  protected
    procedure OnInit(Args: TFPDFBandInitArgs); override;
    procedure OnDraw(Args: TFPDFBandDrawArgs); override;
  public
    constructor Create(AReport: TNFeDANFeFPDFRTC); reintroduce;
  end;

  { TBlocoCabecalhoRTC }

  TBlocoCabecalhoRTC = class(TBlocoRTC)
  private
    procedure DesenharEmitente(Args: TFPDFBandDrawArgs; AX, AY, AW, AH: Double);
    procedure DesenharIdentificacao(Args: TFPDFBandDrawArgs; AX, AY, AW, AH: Double);
    procedure DesenharChave(const APDF: IFPDF; AX, AY, AW, AH: Double);
    function Protocolo(out ARotulo: String): String;
  protected
    procedure OnInit(Args: TFPDFBandInitArgs); override;
    procedure OnDraw(Args: TFPDFBandDrawArgs); override;
  public
    constructor Create(AReport: TNFeDANFeFPDFRTC); reintroduce;
  end;

  { TBlocoDestinatarioRTC }

  TBlocoDestinatarioRTC = class(TBlocoRTC)
  protected
    procedure OnInit(Args: TFPDFBandInitArgs); override;
    procedure OnDraw(Args: TFPDFBandDrawArgs); override;
  public
    constructor Create(AReport: TNFeDANFeFPDFRTC); reintroduce;
  end;

  { TBlocoLocalRTC }

  TBlocoLocalRTC = class(TBlocoRTC)
  private
    FEntrega: Boolean;
  protected
    procedure OnInit(Args: TFPDFBandInitArgs); override;
    procedure OnDraw(Args: TFPDFBandDrawArgs); override;
  public
    constructor Create(AReport: TNFeDANFeFPDFRTC; AEntrega: Boolean); reintroduce;
  end;

  { TBlocoFaturaRTC }

  TBlocoFaturaRTC = class(TBlocoRTC)
  private
    FLinhas: Integer;
  protected
    procedure OnInit(Args: TFPDFBandInitArgs); override;
    procedure OnDraw(Args: TFPDFBandDrawArgs); override;
  public
    constructor Create(AReport: TNFeDANFeFPDFRTC); reintroduce;
  end;

  { TBlocoTotalNotaRTC }

  TBlocoTotalNotaRTC = class(TBlocoRTC)
  protected
    procedure OnInit(Args: TFPDFBandInitArgs); override;
    procedure OnDraw(Args: TFPDFBandDrawArgs); override;
  public
    constructor Create(AReport: TNFeDANFeFPDFRTC); reintroduce;
  end;

  { TBlocoTotalICMSIPIRTC }

  TBlocoTotalICMSIPIRTC = class(TBlocoRTC)
  private
    FTotal: TACBrNFeDANFeRTCTotalICMSIPI;
  protected
    procedure OnInit(Args: TFPDFBandInitArgs); override;
    procedure OnDraw(Args: TFPDFBandDrawArgs); override;
  public
    constructor Create(AReport: TNFeDANFeFPDFRTC); reintroduce;
  end;

  { TBlocoTotalIBSCBSISRTC }

  TBlocoTotalIBSCBSISRTC = class(TBlocoRTC)
  private
    FTotal: TACBrNFeDANFeRTCTotalIBSCBSIS;
  protected
    procedure OnInit(Args: TFPDFBandInitArgs); override;
    procedure OnDraw(Args: TFPDFBandDrawArgs); override;
  public
    constructor Create(AReport: TNFeDANFeFPDFRTC); reintroduce;
  end;

  { TBlocoISSQNRTC }

  TBlocoISSQNRTC = class(TBlocoRTC)
  private
    FISSQN: TACBrNFeDANFeRTCISSQN;
  protected
    procedure OnInit(Args: TFPDFBandInitArgs); override;
    procedure OnDraw(Args: TFPDFBandDrawArgs); override;
  public
    constructor Create(AReport: TNFeDANFeFPDFRTC); reintroduce;
  end;

  { TBlocoTransporteRTC }

  TBlocoTransporteRTC = class(TBlocoRTC)
  protected
    procedure OnInit(Args: TFPDFBandInitArgs); override;
    procedure OnDraw(Args: TFPDFBandDrawArgs); override;
  public
    constructor Create(AReport: TNFeDANFeFPDFRTC); reintroduce;
  end;

  { TBlocoItensRTC }

  TBlocoItensRTC = class(TBlocoRTC)
  private
    FItemAtual: Integer;
    FX: array[0..cColunasItens] of Double;

    procedure CalcularColunas;
    procedure PrepararItem(const APDF: IFPDF; AIndex: Integer; out AItem: TItemDesenhoRTC);
    procedure DesenharItem(const APDF: IFPDF; AIndex: Integer; const AItem: TItemDesenhoRTC; AY: Double);
    procedure DesenharPares(const APDF: IFPDF; AColuna: Integer; AY, AAlturaLinha: Double;
      const APares: TACBrNFeDANFeRTCPares; AAliquota: Boolean);
  protected
    procedure OnInit(Args: TFPDFBandInitArgs); override;
    procedure OnDraw(Args: TFPDFBandDrawArgs); override;
  public
    constructor Create(AReport: TNFeDANFeFPDFRTC); reintroduce;
  end;

  { TBlocoDadosAdicionaisRTC }

  TBlocoDadosAdicionaisRTC = class(TBlocoRTC)
  private
    FExibeQRCode: Boolean;
    FTexto: String;

    function LarguraQRCode: Double;
  protected
    procedure OnInit(Args: TFPDFBandInitArgs); override;
    procedure OnDraw(Args: TFPDFBandDrawArgs); override;
  public
    constructor Create(AReport: TNFeDANFeFPDFRTC); reintroduce;
  end;

  { TBlocoRodapeRTC }

  TBlocoRodapeRTC = class(TBlocoRTC)
  protected
    procedure OnInit(Args: TFPDFBandInitArgs); override;
    procedure OnDraw(Args: TFPDFBandDrawArgs); override;
  public
    constructor Create(AReport: TNFeDANFeFPDFRTC); reintroduce;
  end;

  { TBlocoMarcaDaguaRTC }

  TBlocoMarcaDaguaRTC = class(TBlocoRTC)
  private
    procedure Marca(const APDF: IFPDF; AY: Double; const ATexto: String; ATamanho: Double);
  protected
    procedure OnDraw(Args: TFPDFBandDrawArgs); override;
  public
    constructor Create(AReport: TNFeDANFeFPDFRTC); reintroduce;
  end;

procedure DesenharTitulo(const APDF: IFPDF; AX, AY, AW, AH: Double; const ATexto: String;
  AAlinhamento: Char);
begin
  APDF.SetFillColor(235, 235, 235);
  APDF.Rect(AX, AY, AW, AH, 'DF');
  APDF.SetFont(7.5, 'B');
  APDF.TextBox(AX + 1, AY + 0.5, AW - 2, AH, ATexto, 'C', AAlinhamento, False, False, False);
end;

procedure DesenharCampo(const APDF: IFPDF; AReport: TNFeDANFeFPDFRTC; AX, AY, AW, AH: Double;
  const ARotulo, AValor: String; AAlinhamento: Char; const AEstilo: String);
begin
  APDF.Rect(AX, AY, AW, AH);
  APDF.SetFont(AReport.FonteRotulo, '');
  APDF.TextBox(AX + 0.5, AY + AReport.MargemRotulo, AW - 1, 3, ARotulo, 'T', 'L', False, False, False);
  APDF.SetFont(AReport.FonteValor, AEstilo);
  APDF.TextBox(AX + 0.5, AY + AReport.DeslocamentoValor, AW - 1, AH, AValor, 'B', AAlinhamento,
    False, False, False);
end;

function AlturaLinhaTexto(const APDF: IFPDF; ATamanho: Double): Double;
begin
  APDF.SetFont(ATamanho, '');
  Result := APDF.CurrentFontSize + 0.4;
end;

function LinhasTexto(const APDF: IFPDF; const ATexto: String; AW: Double): TStringArray;
var
  LTexto: String;
begin
  Result := nil;
  LTexto := Trim(ATexto);
  if LTexto = '' then
    Exit;

  APDF.WordWrap(LTexto, AW);
  Result := ACBr_fpdf.Split(LTexto, sLineBreak);
end;

function Pontilhado(const APDF: IFPDF; const ARotulo, AValor: String; AW: Double): String;
var
  LPontos: String;
begin
  LPontos := '';
  while APDF.GetStringWidth(ARotulo + LPontos + '.' + AValor) <= AW do
    LPontos := LPontos + '.';

  Result := ARotulo + LPontos + AValor;
end;

procedure DesenharLinhas(const APDF: IFPDF; AX, AY, AW, AAlturaLinha: Double;
  const ALinhas: TStringArray; AAlinhamento: Char);
var
  I: Integer;
begin
  for I := 0 to High(ALinhas) do
    APDF.TextBox(AX, AY + (I * AAlturaLinha), AW, AAlturaLinha, ALinhas[I], 'T', AAlinhamento,
      False, False, False);
end;

{ TBlocoRTC }

constructor TBlocoRTC.Create(ABandType: TFPDFBandType; AReport: TNFeDANFeFPDFRTC);
begin
  inherited Create(ABandType);
  FReport := AReport;
end;

function TBlocoRTC.NFe: TNFe;
begin
  Result := FReport.RTC.NFe;
end;

procedure TBlocoRTC.Titulo(const APDF: IFPDF; AX, AY, AW: Double; const ATexto: String;
  AAlinhamento: Char);
begin
  DesenharTitulo(APDF, AX, AY, AW, FReport.AlturaTitulo, ATexto, AAlinhamento);
end;

procedure TBlocoRTC.Campo(const APDF: IFPDF; AX, AY, AW, AH: Double; const ARotulo, AValor: String;
  AAlinhamento: Char; const AEstilo: String);
begin
  DesenharCampo(APDF, FReport, AX, AY, AW, AH, ARotulo, AValor, AAlinhamento, AEstilo);
end;

procedure TBlocoRTC.Linha(const APDF: IFPDF; AY, ALargura: Double; const AProporcoes: array of Double;
  const ARotulos, AValores: array of String; const AAlinhamentos: String; const AEstilo: String);
var
  I: Integer;
  LX, LW: Double;
  LAlinhamento: Char;
begin
  LX := 0;
  for I := 0 to High(ARotulos) do
  begin
    if I = High(ARotulos) then
      LW := ALargura - LX
    else
      LW := ALargura * AProporcoes[I];

    if I < Length(AAlinhamentos) then
      LAlinhamento := AAlinhamentos[I + 1]
    else
      LAlinhamento := 'L';

    Campo(APDF, LX, AY, LW, FReport.AlturaLinha, ARotulos[I], AValores[I], LAlinhamento, AEstilo);
    LX := LX + LW;
  end;
end;

{ TBlocoCanhotoRTC }

constructor TBlocoCanhotoRTC.Create(AReport: TNFeDANFeFPDFRTC);
begin
  FPosicao := AReport.DANFEClassOwner.PosCanhoto;

  if AReport.Paisagem and (FPosicao <> prEsquerda) then
  begin
    FDireita := True;
    inherited Create(btRightMargin, AReport);
    Exit;
  end;

  case FPosicao of
    prRodape:
      inherited Create(btBottomMargin, AReport);
    prEsquerda:
      inherited Create(btLeftMargin, AReport);
  else
    inherited Create(btTopMargin, AReport);
  end;
end;

procedure TBlocoCanhotoRTC.DesenharCanhoto(const APDF: IFPDF; AX, AY, AW: Double;
  ANFePrimeiro: Boolean);
var
  LWNF, LWRecebimento, LWData, LXNF: Double;
  LTexto: String;
begin
  if ANFePrimeiro then
    LWNF := AW * 0.13
  else
    LWNF := AW * 0.18;
  LWRecebimento := AW - LWNF;
  LWData := LWRecebimento * 0.25;

  LXNF := AX + LWRecebimento;
  if ANFePrimeiro then
  begin
    LXNF := AX;
    AX := AX + LWNF;
  end;

  APDF.Rect(AX, AY, LWRecebimento, 9);
  LTexto := 'RECEBEMOS DE ' + NativeStringToAnsi(NFe.Emit.xNome) +
    ' OS PRODUTOS/SERVIÇOS CONSTANTES DA NOTA FISCAL ELETRÔNICA INDICADA AO LADO';
  APDF.SetFont(7, 'B');
  if Report.DANFEClassOwner.ExibeResumoCanhoto then
  begin
    APDF.TextBox(AX + 1, AY + 0.3, LWRecebimento - 2, 6, LTexto, 'T', 'L', False, True, False);

    LTexto := Report.DANFEClassOwner.TextoResumoCanhoto;
    if LTexto = '' then
      LTexto := 'EMISSÃO: ' + FormatDateBr(NFe.Ide.dEmi) +
        '  -  DEST. / REM.: ' + NativeStringToAnsi(NFe.Dest.xNome) +
        '  -  VALOR TOTAL: R$ ' + Report.RTC.FormatarValor(Report.RTC.TotalNota.vNF)
    else
      LTexto := NativeStringToAnsi(LTexto);

    APDF.SetFont(6, '');
    APDF.TextBox(AX + 1, AY, LWRecebimento - 2, 9, LTexto, 'B', 'L', False, False, False);
  end
  else
    APDF.TextBox(AX + 1, AY, LWRecebimento - 2, 9, LTexto, 'C', 'L', False, True, False);

  Campo(APDF, AX, AY + 9, LWData, cAlturaCanhoto - 9, 'DATA DE RECEBIMENTO', '');
  Campo(APDF, AX + LWData, AY + 9, LWRecebimento - LWData, cAlturaCanhoto - 9,
    'IDENTIFICAÇÃO E ASSINATURA DO RECEBEDOR', '');

  APDF.Rect(LXNF, AY, LWNF, cAlturaCanhoto);
  APDF.SetFont(12, 'B');
  APDF.TextBox(LXNF, AY + 1.5, LWNF, 6, 'NF-e', 'T', 'C', False, False, False);
  APDF.SetFont(8, '');
  APDF.TextBox(LXNF, AY + 7.5, LWNF, 4, 'Nº ' + Report.NumeroNF, 'T', 'C', False, False, False);
  APDF.TextBox(LXNF, AY + 11, LWNF, 4, 'SÉRIE ' + Report.SerieNF, 'T', 'C', False, False, False);
end;

procedure TBlocoCanhotoRTC.OnInit(Args: TFPDFBandInitArgs);
begin
  if FDireita or (FPosicao = prEsquerda) then
    Width := cAlturaCanhoto + 3
  else
    Height := cAlturaCanhoto + 3;

  Visible := True;
end;

procedure TBlocoCanhotoRTC.OnDraw(Args: TFPDFBandDrawArgs);
var
  LPDF: IFPDF;
  LY: Double;
begin
  LPDF := Args.PDF;

  if FDireita then
  begin
    LPDF.Rotate(90, 0, Height);
    try
      LY := Height + 1.5;
      LPDF.DashedLine(0, LY, Height, LY);
      DesenharCanhoto(LPDF, 0, Height + 3, Height, True);
    finally
      LPDF.Rotate(0, 0, Height);
    end;

    Visible := False;
    Exit;
  end;

  case FPosicao of
    prEsquerda:
      begin
        LPDF.Rotate(90, 0, Height);
        try
          DesenharCanhoto(LPDF, 0, Height, Height, Report.Paisagem);
          LY := Height + cAlturaCanhoto + 1.5;
          LPDF.DashedLine(0, LY, Height, LY);
        finally
          LPDF.Rotate(0, 0, Height);
        end;
      end;

    prRodape:
      begin
        LPDF.DashedLine(0, 1.5, Width, 1.5);
        DesenharCanhoto(LPDF, 0, 3, Width, False);
      end;
  else
    DesenharCanhoto(LPDF, 0, 0, Width, False);
    LY := cAlturaCanhoto + 1.5;
    LPDF.DashedLine(0, LY, Width, LY);
  end;

  Visible := False;
end;

{ TBlocoCabecalhoRTC }

constructor TBlocoCabecalhoRTC.Create(AReport: TNFeDANFeFPDFRTC);
begin
  inherited Create(btPageHeader, AReport);
end;

procedure TBlocoCabecalhoRTC.DesenharEmitente(Args: TFPDFBandDrawArgs; AX, AY, AW, AH: Double);
var
  LPDF: IFPDF;
  LImageUtils: TImageUtils;
  LLogoW, LLogoH: Word;
  LTemLogo: Boolean;
  LImgX, LImgY, LImgW, LImgH, LEscala: Double;
  LTxtX, LTxtY, LTxtW, LTxtH: Double;
  LTamanho, LAlturaNome, LAlturaEndereco: Double;
  LNome, LEndereco: String;
  LOwner: TACBrNFeDANFEClass;
begin
  LPDF := Args.PDF;
  LOwner := Report.DANFEClassOwner;
  LPDF.Rect(AX, AY, AW, AH);

  LTxtX := AX + 1;
  LTxtY := AY + 1;
  LTxtW := AW - 2;
  LTxtH := AH - 2;
  LImgX := LTxtX;
  LImgY := LTxtY;
  LImgW := LTxtW;
  LImgH := LTxtH;

  LTemLogo := (Report.Logo.Size > 0);
  if LTemLogo then
  begin
    if LOwner.ExpandeLogoMarca then
      LTxtH := 0
    else if LOwner.LogoemCima then
    begin
      LImgH := AH * 0.4;
      LTxtY := LImgY + LImgH + 0.5;
      LTxtH := AH - LImgH - 2.5;
    end
    else
    begin
      LImgW := AW * 0.33;
      LTxtX := LImgX + LImgW + 1;
      LTxtW := AW - LImgW - 3;
    end;

    if Args.FinalPass then
    begin
      LImageUtils := TImageUtils.Create;
      try
        LLogoW := 0;
        LLogoH := 0;
        Report.Logo.Position := 0;
        if LImageUtils.GetImageSize(Report.Logo, LLogoW, LLogoH) and (LLogoW > 0) and (LLogoH > 0) then
        begin
          LEscala := LImgW / LLogoW;
          if (LImgH / LLogoH) < LEscala then
            LEscala := LImgH / LLogoH;
          LImgX := LImgX + ((LImgW - (LLogoW * LEscala)) / 2);
          LImgY := LImgY + ((LImgH - (LLogoH * LEscala)) / 2);
          Report.Logo.Position := 0;
          LPDF.Image(LImgX, LImgY, LLogoW * LEscala, LLogoH * LEscala, Report.Logo);
        end;
      finally
        LImageUtils.Free;
      end;
    end;
  end;

  if LTxtH <= 0 then
    Exit;

  LNome := NativeStringToAnsi(LOwner.ManterNomeImpresso(NFe.Emit.xNome, NFe.Emit.xFant));
  LEndereco := NativeStringToAnsi(
    NFe.Emit.EnderEmit.xLgr + ', ' + NFe.Emit.EnderEmit.nro +
    IfThen(NFe.Emit.EnderEmit.xCpl <> '', ' - ' + NFe.Emit.EnderEmit.xCpl) + sLineBreak +
    NFe.Emit.EnderEmit.xBairro + ' - ' + NFe.Emit.EnderEmit.xMun + '/' + NFe.Emit.EnderEmit.UF +
    IfThen(NFe.Emit.EnderEmit.CEP > 0, ' - CEP ' + FormatarCEP(NFe.Emit.EnderEmit.CEP)) +
    IfThen(NFe.Emit.EnderEmit.fone <> '', sLineBreak + 'Fone: ' + NFe.Emit.EnderEmit.fone));

  LPDF.SetFont(7, '');
  LAlturaEndereco := LPDF.GetStringHeight(LEndereco, LTxtW);

  LTamanho := 11;
  repeat
    LPDF.SetFont(LTamanho, 'B');
    LAlturaNome := LPDF.GetStringHeight(LNome, LTxtW);
    LTamanho := LTamanho - 0.5;
  until (LAlturaNome + LAlturaEndereco <= LTxtH) or (LTamanho < 7);

  LTxtY := LTxtY + ((LTxtH - (LAlturaNome + LAlturaEndereco)) / 2);
  LPDF.TextBox(LTxtX, LTxtY, LTxtW, LAlturaNome, LNome, 'T', 'C', False, True, False);
  LPDF.SetFont(7, '');
  LPDF.TextBox(LTxtX, LTxtY + LAlturaNome + 0.5, LTxtW, LAlturaEndereco, LEndereco, 'T', 'C',
    False, True, False);
end;

procedure TBlocoCabecalhoRTC.DesenharIdentificacao(Args: TFPDFBandDrawArgs; AX, AY, AW, AH: Double);
var
  LPDF: IFPDF;
  LX, LK: Double;
begin
  LPDF := Args.PDF;
  LK := AH / 32;
  LPDF.Rect(AX, AY, AW, AH);

  LPDF.SetFont(12, 'B');
  LPDF.TextBox(AX, AY + (1 * LK), AW, 5, 'DANFE', 'T', 'C', False, False, False);
  LPDF.SetFont(6, '');
  LPDF.TextBox(AX + 1, AY + (6.5 * LK), AW - 2, 5, 'DOCUMENTO AUXILIAR DA NOTA FISCAL ELETRÔNICA', 'T', 'C',
    False, True, False);

  LX := AX + ((AW - 7) / 2);
  LPDF.Rect(LX, AY + (12.5 * LK), 7, 6 * LK);
  LPDF.SetFont(11, 'B');
  LPDF.TextBox(LX, AY + (12.5 * LK), 7, 6 * LK, tpNFToStr(NFe.Ide.tpNF), 'C', 'C', False, False, False);

  LPDF.SetFont(7, '');
  LPDF.TextBox(AX, AY + (19.5 * LK), AW, 3.5, '0 - ENTRADA   1 - SAÍDA', 'T', 'C', False, False, False);
  LPDF.SetFont(8, 'B');
  LPDF.TextBox(AX, AY + (23 * LK), AW, 4, 'Nº ' + Report.NumeroNF, 'T', 'C', False, False, False);
  LPDF.SetFont(8, '');
  LPDF.TextBox(AX, AY + (27 * LK), AW, 4, 'SÉRIE ' + Report.SerieNF + '   FOLHA ' +
    IntToStr(LPDF.CurrentPage) + '/' + IntToStr(Args.TotalPages), 'T', 'C', False, False, False);
end;

procedure TBlocoCabecalhoRTC.DesenharChave(const APDF: IFPDF; AX, AY, AW, AH: Double);
var
  LWBarras, LY, LK: Double;
begin
  LK := AH / 32;
  APDF.Rect(AX, AY, AW, AH);

  LWBarras := AW - 8;
  if LWBarras > 85 then
    LWBarras := 85;
  APDF.SetFillColor(0, 0, 0);
  APDF.Code128(RemoverLiteralChave(NFe.infNFe.ID), AX + ((AW - LWBarras) / 2), AY + (1.5 * LK), 11 * LK, LWBarras);

  LY := AY + (14 * LK);
  APDF.Line(AX, LY, AX + AW, LY);
  APDF.SetFont(5.5, '');
  APDF.TextBox(AX + 0.5, LY + 0.2, AW - 1, 3, 'CHAVE DE ACESSO', 'T', 'L', False, False, False);
  APDF.SetFont(9, 'B');
  APDF.TextBox(AX + 1, LY + (3 * LK), AW - 2, 4, FormatarChaveAcesso(NFe.infNFe.ID), 'T', 'C',
    False, False, False);

  LY := AY + (22 * LK);
  APDF.Line(AX, LY, AX + AW, LY);
  if (NFe.Ide.tpEmis in [teContingencia, teFSDA]) and not Report.NFeUtils.NotaEPEC then
  begin
    APDF.SetFillColor(0, 0, 0);
    APDF.Code128(Report.NFeUtils.GetChaveContingencia, AX + ((AW - (LWBarras * 0.9)) / 2), LY + (1.5 * LK),
      7 * LK, LWBarras * 0.9);
  end
  else
  begin
    APDF.SetFont(6, '');
    APDF.TextBox(AX + 1, LY, AW - 2, AY + AH - LY,
      'Consulte a autenticidade no portal nacional da NF-e www.nfe.fazenda.gov.br/portal ' +
      'ou no site da SEFAZ autorizadora', 'C', 'C', False, True, False);
  end;
end;

function TBlocoCabecalhoRTC.Protocolo(out ARotulo: String): String;
begin
  Result := '';

  case NFe.Ide.tpEmis of
    teContingencia,
    teFSDA:
      begin
        ARotulo := 'DADOS DA NF-E';
        Result := Report.NFeUtils.GetChaveContingencia;
      end;

    teDPEC:
      if NFe.procNFe.nProt <> '' then
      begin
        ARotulo := 'PROTOCOLO DE AUTORIZAÇÃO DO EPEC';
        Result := NFe.procNFe.nProt + ' - ' + FormatDateTimeBr(NFe.procNFe.dhRecbto);
      end
      else
        ARotulo := 'NÚMERO DE REGISTRO DPEC';
  else
    if Report.NFeUtils.NotaDenegada then
      ARotulo := 'PROTOCOLO DE DENEGAÇÃO DE USO'
    else
      ARotulo := 'PROTOCOLO DE AUTORIZAÇÃO DE USO';

    if NFe.procNFe.nProt = '' then
      Result := 'NF-e sem Autorização de Uso da SEFAZ'
    else
      Result := NFe.procNFe.nProt + IfThen(NFe.procNFe.dhRecbto <> 0,
        ' - ' + FormatDateTimeBr(NFe.procNFe.dhRecbto));
  end;
end;

procedure TBlocoCabecalhoRTC.OnInit(Args: TFPDFBandInitArgs);
begin
  Height := Report.AlturaIdentificacao + (3 * Report.AlturaLinha);
end;

procedure TBlocoCabecalhoRTC.OnDraw(Args: TFPDFBandDrawArgs);
var
  LPDF: IFPDF;
  LW1, LW2, LY: Double;
  LRotulo, LValor: String;
  LEmitente: TACBrNFeDANFeRTCEmitente;
begin
  LPDF := Args.PDF;
  LEmitente := Report.RTC.Emitente;

  if Report.Paisagem then
  begin
    LW1 := Width * 0.33;
    LW2 := Width * 0.20;
  end
  else
  begin
    LW1 := Width * 0.36;
    LW2 := Width * 0.22;
  end;

  LY := Report.AlturaIdentificacao;
  DesenharEmitente(Args, 0, 0, LW1, LY);
  DesenharIdentificacao(Args, LW1, 0, LW2, LY);
  DesenharChave(LPDF, LW1 + LW2, 0, Width - LW1 - LW2, LY);

  LValor := Protocolo(LRotulo);
  Linha(LPDF, LY, Width, [(LW1 + LW2) / Width],
    ['NATUREZA DA OPERAÇÃO', LRotulo],
    [NativeStringToAnsi(NFe.Ide.natOp), LValor], 'LR');

  LY := LY + Report.AlturaLinha;
  Linha(LPDF, LY, Width, [0.36, 0.31],
    ['INSCRIÇÃO ESTADUAL', IfThen(Report.Paisagem, 'INSC. ESTADUAL DO SUBST. TRIBUTÁRIO',
      'INSCRIÇÃO ESTADUAL DO SUBSTITUTO TRIBUTÁRIO'), 'CNPJ / CPF'],
    [NFe.Emit.IE, NFe.Emit.IEST, FormatarCNPJouCPF(NFe.Emit.CNPJCPF)], 'LLR');

  LY := LY + Report.AlturaLinha;
  Linha(LPDF, LY, Width, [0.5],
    ['CÓDIGO DO REGIME TRIBUTÁRIO', 'TIPO DE REGIME DE APURAÇÃO DO IBS E DA CBS'],
    [LEmitente.CRT, LEmitente.TipoRegimeApuracao]);
end;

{ TBlocoDestinatarioRTC }

constructor TBlocoDestinatarioRTC.Create(AReport: TNFeDANFeFPDFRTC);
begin
  inherited Create(btData, AReport);
end;

procedure TBlocoDestinatarioRTC.OnInit(Args: TFPDFBandInitArgs);
begin
  Height := 1 + Report.AlturaTitulo + (3 * Report.AlturaLinha);
end;

procedure TBlocoDestinatarioRTC.OnDraw(Args: TFPDFBandDrawArgs);
var
  LPDF: IFPDF;
  LY: Double;
  LDocumento, LMunicipio, LHora: String;
  LDest: TDest;
begin
  LPDF := Args.PDF;
  LDest := NFe.Dest;

  if LDest.CNPJCPF <> '' then
    LDocumento := FormatarCNPJouCPF(LDest.CNPJCPF)
  else
    LDocumento := LDest.idEstrangeiro;

  LMunicipio := NativeStringToAnsi(LDest.EnderDest.xMun);
  if (UpperCase(Trim(LMunicipio)) = 'EXTERIOR') and (LDest.EnderDest.xPais <> '') then
    LMunicipio := LMunicipio + ' - ' + NativeStringToAnsi(LDest.EnderDest.xPais);

  LHora := '';
  if Frac(NFe.Ide.dSaiEnt) > 0 then
    LHora := FormatDateTime('hh:nn:ss', NFe.Ide.dSaiEnt);

  LY := 1;
  Titulo(LPDF, 0, LY, Width, 'DESTINATÁRIO / REMETENTE');

  LY := LY + Report.AlturaTitulo;
  Linha(LPDF, LY, Width, [0.52, 0.26],
    ['NOME / RAZÃO SOCIAL', 'CNPJ / CPF', 'DATA DE EMISSÃO'],
    [NativeStringToAnsi(LDest.xNome), LDocumento, FormatDateBr(NFe.Ide.dEmi)], 'LLC');

  LY := LY + Report.AlturaLinha;
  Linha(LPDF, LY, Width, [0.43, 0.22, 0.13],
    ['ENDEREÇO', 'BAIRRO / DISTRITO', 'CEP', 'DATA DE ENTRADA / SAÍDA'],
    [NativeStringToAnsi(LDest.EnderDest.xLgr + ', ' + LDest.EnderDest.nro +
       IfThen(LDest.EnderDest.xCpl <> '', ' - ' + LDest.EnderDest.xCpl)),
     NativeStringToAnsi(LDest.EnderDest.xBairro),
     IfThen(LDest.EnderDest.CEP > 0, FormatarCEP(LDest.EnderDest.CEP)),
     IfThen(NFe.Ide.dSaiEnt <> 0, FormatDateBr(NFe.Ide.dSaiEnt))], 'LLLC');

  LY := LY + Report.AlturaLinha;
  Linha(LPDF, LY, Width, [0.28, 0.17, 0.07, 0.26],
    ['MUNICÍPIO', 'FONE / FAX', 'UF', 'INSCRIÇÃO ESTADUAL', 'HORA DE SAÍDA'],
    [LMunicipio, LDest.EnderDest.fone, LDest.EnderDest.UF, LDest.IE, LHora], 'LLCLC');
end;

{ TBlocoLocalRTC }

constructor TBlocoLocalRTC.Create(AReport: TNFeDANFeFPDFRTC; AEntrega: Boolean);
begin
  inherited Create(btData, AReport);
  FEntrega := AEntrega;
end;

procedure TBlocoLocalRTC.OnInit(Args: TFPDFBandInitArgs);
begin
  if FEntrega then
    Visible := (NFe.Entrega.CNPJCPF <> '')
  else
    Visible := (NFe.Retirada.CNPJCPF <> '');

  Height := 1 + Report.AlturaTitulo + (3 * Report.AlturaLinha);
end;

procedure TBlocoLocalRTC.OnDraw(Args: TFPDFBandDrawArgs);
var
  LPDF: IFPDF;
  LY: Double;
  LTitulo, LCNPJCPF, LxNome, LIE, LEndereco, LxBairro, LxMun, LUF, LFone: String;
  LCEP: Integer;
begin
  LPDF := Args.PDF;

  if FEntrega then
  begin
    LTitulo := 'INFORMAÇÕES DO LOCAL DE ENTREGA';
    LCNPJCPF := NFe.Entrega.CNPJCPF;
    LxNome := NFe.Entrega.xNome;
    LIE := NFe.Entrega.IE;
    LEndereco := NFe.Entrega.xLgr + ', ' + NFe.Entrega.nro +
      IfThen(NFe.Entrega.xCpl <> '', ' - ' + NFe.Entrega.xCpl);
    LxBairro := NFe.Entrega.xBairro;
    LCEP := NFe.Entrega.CEP;
    LxMun := NFe.Entrega.xMun;
    LUF := NFe.Entrega.UF;
    LFone := NFe.Entrega.fone;
  end
  else
  begin
    LTitulo := 'INFORMAÇÕES DO LOCAL DE RETIRADA';
    LCNPJCPF := NFe.Retirada.CNPJCPF;
    LxNome := NFe.Retirada.xNome;
    LIE := NFe.Retirada.IE;
    LEndereco := NFe.Retirada.xLgr + ', ' + NFe.Retirada.nro +
      IfThen(NFe.Retirada.xCpl <> '', ' - ' + NFe.Retirada.xCpl);
    LxBairro := NFe.Retirada.xBairro;
    LCEP := NFe.Retirada.CEP;
    LxMun := NFe.Retirada.xMun;
    LUF := NFe.Retirada.UF;
    LFone := NFe.Retirada.fone;
  end;

  LY := 1;
  Titulo(LPDF, 0, LY, Width, LTitulo);

  LY := LY + Report.AlturaTitulo;
  Linha(LPDF, LY, Width, [0.52, 0.26],
    ['NOME / RAZÃO SOCIAL', 'CNPJ / CPF', 'INSCRIÇÃO ESTADUAL'],
    [NativeStringToAnsi(LxNome), FormatarCNPJouCPF(LCNPJCPF), LIE]);

  LY := LY + Report.AlturaLinha;
  Linha(LPDF, LY, Width, [0.52, 0.26],
    ['ENDEREÇO', 'BAIRRO / DISTRITO', 'CEP'],
    [NativeStringToAnsi(LEndereco), NativeStringToAnsi(LxBairro), IfThen(LCEP > 0, FormatarCEP(LCEP))]);

  LY := LY + Report.AlturaLinha;
  Linha(LPDF, LY, Width, [0.52, 0.06],
    ['MUNICÍPIO', 'UF', 'FONE / FAX'],
    [NativeStringToAnsi(LxMun), LUF, LFone], 'LCL');
end;

{ TBlocoFaturaRTC }

constructor TBlocoFaturaRTC.Create(AReport: TNFeDANFeFPDFRTC);
begin
  inherited Create(btData, AReport);
end;

procedure TBlocoFaturaRTC.OnInit(Args: TFPDFBandInitArgs);
var
  LQuantidade: Integer;
begin
  Visible := Report.RTC.ExibeFatura and Report.DANFEClassOwner.ExibeCampoFatura and
    Report.DANFEClassOwner.ExibeCampoDuplicata;
  if not Visible then
    Exit;

  LQuantidade := NFe.Cobr.Dup.Count;
  FLinhas := LQuantidade div cDuplicatasPorLinha;
  if (LQuantidade mod cDuplicatasPorLinha) > 0 then
    Inc(FLinhas);
  FLinhas := Min(FLinhas, cMaxLinhasFatura);

  Height := 1 + Report.AlturaTitulo + (FLinhas * Report.AlturaLinha);
end;

procedure TBlocoFaturaRTC.OnDraw(Args: TFPDFBandDrawArgs);
var
  LPDF: IFPDF;
  I, LQuantidade: Integer;
  LX, LY, LWGrupo: Double;
  LDup: TDupCollectionItem;
begin
  LPDF := Args.PDF;

  Titulo(LPDF, 0, 1, Width, 'FATURA / DUPLICATAS');

  LWGrupo := Width / cDuplicatasPorLinha;
  LQuantidade := Min(NFe.Cobr.Dup.Count, FLinhas * cDuplicatasPorLinha);
  for I := 0 to LQuantidade - 1 do
  begin
    LDup := NFe.Cobr.Dup[I];
    LX := (I mod cDuplicatasPorLinha) * LWGrupo;
    LY := 1 + Report.AlturaTitulo + ((I div cDuplicatasPorLinha) * Report.AlturaLinha);

    Campo(LPDF, LX, LY, LWGrupo * 0.4, Report.AlturaLinha, 'FATURA/DUPLICATA', LDup.nDup);
    Campo(LPDF, LX + (LWGrupo * 0.4), LY, LWGrupo * 0.3, Report.AlturaLinha, 'VENCIMENTO',
      FormatDateBr(LDup.dVenc), 'C');
    Campo(LPDF, LX + (LWGrupo * 0.7), LY, LWGrupo * 0.3, Report.AlturaLinha, 'VALOR',
      Report.RTC.FormatarValor(LDup.vDup), 'R');
  end;
end;

{ TBlocoTotalNotaRTC }

constructor TBlocoTotalNotaRTC.Create(AReport: TNFeDANFeFPDFRTC);
begin
  inherited Create(btData, AReport);
end;

procedure TBlocoTotalNotaRTC.OnInit(Args: TFPDFBandInitArgs);
begin
  Height := 1 + Report.AlturaTitulo + (2 * Report.AlturaLinha);
end;

procedure TBlocoTotalNotaRTC.OnDraw(Args: TFPDFBandDrawArgs);
var
  LPDF: IFPDF;
  LY: Double;
  LTotal: TACBrNFeDANFeRTCTotalNota;
  LRTC: TACBrNFeDANFeRTC;
begin
  LPDF := Args.PDF;
  LRTC := Report.RTC;
  LTotal := LRTC.TotalNota;

  LY := 1;
  Titulo(LPDF, 0, LY, Width, 'TOTAL DOS PRODUTOS E TOTAL DA NOTA');

  LY := LY + Report.AlturaTitulo;
  Linha(LPDF, LY, Width, [0.2, 0.2, 0.2, 0.2],
    ['VALOR TOTAL DOS PRODUTOS', 'VALOR DO FRETE', 'VALOR DO SEGURO', 'DESCONTO',
     IfThen(Report.Paisagem, 'OUTRAS DESPESAS ACESSÓRIAS', 'OUTRAS DESPESAS')],
    [LRTC.FormatarValor(LTotal.vProd), LRTC.FormatarValor(LTotal.vFrete),
     LRTC.FormatarValor(LTotal.vSeg), LRTC.FormatarValor(LTotal.vDesc),
     LRTC.FormatarValor(LTotal.vOutro)], 'RRRRR');

  LY := LY + Report.AlturaLinha;
  Linha(LPDF, LY, Width, [1], ['VALOR TOTAL DA NOTA'], [LRTC.FormatarValor(LTotal.vNF)], 'R', 'B');
end;

{ TBlocoTotalICMSIPIRTC }

constructor TBlocoTotalICMSIPIRTC.Create(AReport: TNFeDANFeFPDFRTC);
begin
  inherited Create(btData, AReport);
end;

procedure TBlocoTotalICMSIPIRTC.OnInit(Args: TFPDFBandInitArgs);
begin
  FTotal := Report.RTC.TotalICMSIPI;
  Height := 1 + Report.AlturaTitulo +
    ((1 + Ord(FTotal.ExibeFCPDifal) + Ord(FTotal.ExibeMonofasico)) * Report.AlturaLinha);
end;

procedure TBlocoTotalICMSIPIRTC.OnDraw(Args: TFPDFBandDrawArgs);
var
  LPDF: IFPDF;
  LY: Double;
  LRTC: TACBrNFeDANFeRTC;
begin
  LPDF := Args.PDF;
  LRTC := Report.RTC;

  LY := 1;
  Titulo(LPDF, 0, LY, Width, 'TOTAL DO ICMS / IPI');

  LY := LY + Report.AlturaTitulo;
  Linha(LPDF, LY, Width, [0.2, 0.2, 0.2, 0.2],
    ['BASE DE CÁLCULO DO ICMS', 'VALOR DO ICMS', 'BASE DE CÁLCULO DO ICMS ST', 'VALOR DO ICMS ST',
     'VALOR DO IPI'],
    [LRTC.FormatarValor(FTotal.vBC), LRTC.FormatarValor(FTotal.vICMS),
     LRTC.FormatarValor(FTotal.vBCST), LRTC.FormatarValor(FTotal.vST),
     LRTC.FormatarValor(FTotal.vIPI)], 'RRRRR');

  if FTotal.ExibeFCPDifal then
  begin
    LY := LY + Report.AlturaLinha;
    Linha(LPDF, LY, Width, [0.25, 0.25, 0.25],
      ['VALOR DO FCP', 'VALOR DO FCP RETIDO POR ST', 'VALOR DO DIFAL NA UF DE DESTINO',
       'VALOR DO FCP NA UF DE DESTINO'],
      [LRTC.FormatarValor(FTotal.vFCP), LRTC.FormatarValor(FTotal.vFCPST),
       LRTC.FormatarValor(FTotal.vICMSUFDest), LRTC.FormatarValor(FTotal.vFCPUFDest)], 'RRRR');
  end;

  if FTotal.ExibeMonofasico then
  begin
    LY := LY + Report.AlturaLinha;
    Linha(LPDF, LY, Width, [0.25, 0.25, 0.25],
      ['BC DO ICMS MONOFÁSICO', 'VALOR DO ICMS MONOFÁSICO', 'BC DO ICMS MONOFÁSICO POR RETENÇÃO',
       'VALOR DO ICMS MONOFÁSICO POR RETENÇÃO'],
      [LRTC.FormatarValor(FTotal.qBCMono), LRTC.FormatarValor(FTotal.vICMSMono),
       LRTC.FormatarValor(FTotal.qBCMonoReten), LRTC.FormatarValor(FTotal.vICMSMonoReten)], 'RRRR');
  end;
end;

{ TBlocoTotalIBSCBSISRTC }

constructor TBlocoTotalIBSCBSISRTC.Create(AReport: TNFeDANFeFPDFRTC);
begin
  inherited Create(btData, AReport);
end;

procedure TBlocoTotalIBSCBSISRTC.OnInit(Args: TFPDFBandInitArgs);
begin
  FTotal := Report.RTC.TotalIBSCBSIS;
  Height := 1 + Report.AlturaTitulo + ((1 + Ord(FTotal.ExibeMonofasico)) * Report.AlturaLinha);
end;

procedure TBlocoTotalIBSCBSISRTC.OnDraw(Args: TFPDFBandDrawArgs);
var
  LPDF: IFPDF;
  LY: Double;
  LRTC: TACBrNFeDANFeRTC;
begin
  LPDF := Args.PDF;
  LRTC := Report.RTC;

  LY := 1;
  Titulo(LPDF, 0, LY, Width, 'TOTAL DO IBS / CBS / IS');

  LY := LY + Report.AlturaTitulo;
  Linha(LPDF, LY, Width, [0.25, 0.25, 0.25],
    ['VALOR DA CBS', 'VALOR DO IBS UF', 'VALOR DO IBS MUNICÍPIO', 'VALOR DO IMPOSTO SELETIVO'],
    [LRTC.FormatarValor(FTotal.vCBS), LRTC.FormatarValor(FTotal.vIBSUF),
     LRTC.FormatarValor(FTotal.vIBSMun), LRTC.FormatarValor(FTotal.vIS)], 'RRRR');

  if FTotal.ExibeMonofasico then
  begin
    LY := LY + Report.AlturaLinha;
    Linha(LPDF, LY, Width, [0.25, 0.25, 0.25],
      ['VALOR DO IBS MONOFÁSICO', 'VALOR DA CBS MONOFÁSICA', 'VALOR DO IBS MONOFÁSICO POR RETENÇÃO',
       'VALOR DA CBS MONOFÁSICA POR RETENÇÃO'],
      [LRTC.FormatarValor(FTotal.vIBSMono), LRTC.FormatarValor(FTotal.vCBSMono),
       LRTC.FormatarValor(FTotal.vIBSMonoReten), LRTC.FormatarValor(FTotal.vCBSMonoReten)], 'RRRR');
  end;
end;

{ TBlocoISSQNRTC }

constructor TBlocoISSQNRTC.Create(AReport: TNFeDANFeFPDFRTC);
begin
  inherited Create(btData, AReport);
end;

procedure TBlocoISSQNRTC.OnInit(Args: TFPDFBandInitArgs);
begin
  FISSQN := Report.RTC.ISSQN;
  Visible := FISSQN.Exibe;
  Height := 1 + Report.AlturaTitulo + Report.AlturaLinha;
end;

procedure TBlocoISSQNRTC.OnDraw(Args: TFPDFBandDrawArgs);
var
  LPDF: IFPDF;
  LRTC: TACBrNFeDANFeRTC;
begin
  LPDF := Args.PDF;
  LRTC := Report.RTC;

  Titulo(LPDF, 0, 1, Width, 'CÁLCULO DO ISSQN');
  Linha(LPDF, 1 + Report.AlturaTitulo, Width, [0.25, 0.25, 0.25],
    ['INSCRIÇÃO MUNICIPAL', 'VALOR TOTAL DOS SERVIÇOS', 'BASE DE CÁLCULO DO ISSQN', 'VALOR DO ISSQN'],
    [FISSQN.IM, LRTC.FormatarValor(FISSQN.vServ), LRTC.FormatarValor(FISSQN.vBC),
     LRTC.FormatarValor(FISSQN.vISS)], 'LRRR');
end;

{ TBlocoTransporteRTC }

constructor TBlocoTransporteRTC.Create(AReport: TNFeDANFeFPDFRTC);
begin
  inherited Create(btData, AReport);
end;

procedure TBlocoTransporteRTC.OnInit(Args: TFPDFBandInitArgs);
begin
  Visible := Report.RTC.ExibeTransporte;
  Height := 1 + Report.AlturaTitulo + (3 * Report.AlturaLinha);
end;

procedure TBlocoTransporteRTC.OnDraw(Args: TFPDFBandDrawArgs);

  function Agrupar(const AAtual, ANovo: String): String;
  begin
    if (AAtual <> '') and (ANovo <> AAtual) then
      Result := 'VARIAS'
    else
      Result := ANovo;
  end;

var
  LPDF: IFPDF;
  I, LQuantidade: Integer;
  LY, LPesoBruto, LPesoLiquido: Double;
  LEspecie, LMarca, LNumero, LPlaca, LUFVeiculo: String;
  LVol: TVolCollectionItem;
  LTransp: TTransp;
  LOk: Boolean;
begin
  LPDF := Args.PDF;
  LTransp := NFe.Transp;

  LPlaca := LTransp.veicTransp.placa;
  LUFVeiculo := LTransp.veicTransp.UF;
  if (LPlaca = '') and (LTransp.Reboque.Count > 0) then
  begin
    LPlaca := LTransp.Reboque[0].placa;
    LUFVeiculo := LTransp.Reboque[0].UF;
  end;

  LQuantidade := 0;
  LPesoBruto := 0;
  LPesoLiquido := 0;
  LEspecie := '';
  LMarca := '';
  LNumero := '';
  for I := 0 to LTransp.Vol.Count - 1 do
  begin
    LVol := LTransp.Vol[I];
    LQuantidade := LQuantidade + LVol.qVol;
    LPesoBruto := LPesoBruto + LVol.pesoB;
    LPesoLiquido := LPesoLiquido + LVol.pesoL;
    LEspecie := Agrupar(LEspecie, LVol.esp);
    LMarca := Agrupar(LMarca, LVol.marca);
    LNumero := Agrupar(LNumero, LVol.nVol);
  end;

  LY := 1;
  Titulo(LPDF, 0, LY, Width, 'TRANSPORTADOR / VOLUMES TRANSPORTADOS');

  LY := LY + Report.AlturaTitulo;
  Linha(LPDF, LY, Width, [0.32, 0.14, 0.13, 0.13, 0.06],
    ['RAZÃO SOCIAL', 'FRETE POR CONTA', 'CÓDIGO ANTT', 'PLACA DO VEÍCULO', 'UF', 'CNPJ / CPF'],
    [NativeStringToAnsi(LTransp.Transporta.xNome),
     modFreteToDesStr(LTransp.modFrete, DblToVersaoDF(LOk, NFe.infNFe.Versao)),
     LTransp.veicTransp.RNTC, LPlaca, LUFVeiculo, FormatarCNPJouCPF(LTransp.Transporta.CNPJCPF)],
    'LLLLCL');

  LY := LY + Report.AlturaLinha;
  Linha(LPDF, LY, Width, [0.42, 0.30, 0.06],
    ['ENDEREÇO', 'MUNICÍPIO', 'UF', 'INSCRIÇÃO ESTADUAL'],
    [NativeStringToAnsi(LTransp.Transporta.xEnder), NativeStringToAnsi(LTransp.Transporta.xMun),
     LTransp.Transporta.UF, LTransp.Transporta.IE], 'LLCL');

  LY := LY + Report.AlturaLinha;
  Linha(LPDF, LY, Width, [0.13, 0.19, 0.19, 0.17, 0.16],
    ['QUANTIDADE', 'ESPÉCIE', 'MARCA', 'NUMERAÇÃO', 'PESO BRUTO', 'PESO LÍQUIDO'],
    [IfThen(LQuantidade > 0, IntToStr(LQuantidade)), NativeStringToAnsi(LEspecie),
     NativeStringToAnsi(LMarca), LNumero,
     IfThen(LPesoBruto > 0, FormatFloatBr(LPesoBruto, ',0.000') + ' kg'),
     IfThen(LPesoLiquido > 0, FormatFloatBr(LPesoLiquido, ',0.000') + ' kg')], 'RLLLRR');
end;

{ TBlocoItensRTC }

constructor TBlocoItensRTC.Create(AReport: TNFeDANFeFPDFRTC);
begin
  inherited Create(btData, AReport);
end;

procedure TBlocoItensRTC.CalcularColunas;
const
  cRetrato: array[0..cColunasItens - 2] of Double = (0.20, 0.06, 0.075, 0.08, 0.08, 0.14, 0.155);
  cPaisagem: array[0..cColunasItens - 2] of Double = (0.32, 0.065, 0.075, 0.075, 0.07, 0.105, 0.125);
var
  I: Integer;
  LProporcao: Double;
begin
  FX[0] := 0;
  for I := 0 to cColunasItens - 2 do
  begin
    if Report.Paisagem then
      LProporcao := cPaisagem[I]
    else
      LProporcao := cRetrato[I];
    FX[I + 1] := FX[I] + (Width * LProporcao);
  end;
  FX[cColunasItens] := Width;
end;

procedure TBlocoItensRTC.PrepararItem(const APDF: IFPDF; AIndex: Integer; out AItem: TItemDesenhoRTC);
var
  LDet: TDetCollectionItem;
  LOwner: TACBrNFeDANFEClass;
  LAdicional, LQuantidades, LUnidades, LValoresUnitarios: String;
  LWDescricao, LAltura7, LAltura6, LAltura55: Double;
  LAlturaDescricao, LAlturaQuantidade, LAlturaTributos: Double;
begin
  LDet := NFe.Det[AIndex];
  LOwner := Report.DANFEClassOwner;
  LWDescricao := FX[1] - FX[0] - 1;

  LAltura7 := AlturaLinhaTexto(APDF, 7);
  AItem.Descricao := LinhasTexto(APDF, NativeStringToAnsi(LDet.Prod.xProd), LWDescricao);

  LAdicional := Trim(LOwner.ManterinfAdProd(NFe, AIndex) + LOwner.ManterXPedNItemPed(NFe, AIndex));
  if Copy(LAdicional, 1, 1) = '-' then
    LAdicional := Trim(Copy(LAdicional, 2, MaxInt));

  LAltura6 := AlturaLinhaTexto(APDF, 6);
  AItem.Adicional := LinhasTexto(APDF, NativeStringToAnsi(LAdicional), LWDescricao);
  AItem.Classificacao := Report.RTC.ClassificacaoItem(AIndex);

  case LOwner.ImprimeValor of
    iuTributavel:
      begin
        LQuantidades := LOwner.FormatarQuantidade(LDet.Prod.qTrib);
        LUnidades := LDet.Prod.uTrib;
        LValoresUnitarios := LOwner.FormatarValorUnitario(LDet.Prod.vUnTrib);
      end;

    iuComercialETributavel:
      begin
        LQuantidades := LOwner.ManterQuantidades(LDet.Prod.qCom, LDet.Prod.qTrib);
        LUnidades := LOwner.ManterUnidades(LDet.Prod.uCom, LDet.Prod.uTrib);
        LValoresUnitarios := LOwner.ManterValoresUnitarios(LDet.Prod.vUnCom, LDet.Prod.vUnTrib);
      end;
  else
    LQuantidades := LOwner.FormatarQuantidade(LDet.Prod.qCom);
    LUnidades := LDet.Prod.uCom;
    LValoresUnitarios := LOwner.FormatarValorUnitario(LDet.Prod.vUnCom);
  end;

  AItem.Quantidades := ACBr_fpdf.Split(LQuantidades, sLineBreak);
  AItem.Unidades := ACBr_fpdf.Split('[' + StringReplace(Trim(LUnidades), sLineBreak, ']' + sLineBreak + '[',
    [rfReplaceAll]) + ']', sLineBreak);
  AItem.ValoresUnitarios := ACBr_fpdf.Split(LValoresUnitarios, sLineBreak);
  AItem.ValorTotal := Report.RTC.FormatarValor(LDet.Prod.vProd);

  LAltura55 := AlturaLinhaTexto(APDF, 5.5);
  LAlturaDescricao := (Length(AItem.Descricao) * LAltura7) +
    ((Length(AItem.Adicional) + Ord(AItem.Classificacao <> '')) * LAltura6);
  LAlturaQuantidade := (Length(AItem.Quantidades) + Length(AItem.Unidades)) * LAltura6;
  LAlturaTributos := (High(TACBrNFeDANFeRTCBases) + 1) * LAltura55;

  AItem.Altura := Max(LAlturaDescricao, Max(LAlturaQuantidade, LAlturaTributos)) + 1.5;
end;

procedure TBlocoItensRTC.DesenharPares(const APDF: IFPDF; AColuna: Integer; AY, AAlturaLinha: Double;
  const APares: TACBrNFeDANFeRTCPares; AAliquota: Boolean);
const
  cSeparador = ' / ';
var
  I, J: Integer;
  LW, LWPar: Double;
  LTexto: String;
  LValores: array[0..1] of String;
begin
  LW := FX[AColuna + 1] - FX[AColuna] - 1;
  LWPar := (LW - APDF.GetStringWidth(cSeparador)) / 2;

  for I := Low(APares) to High(APares) do
  begin
    for J := 0 to 1 do
    begin
      if AAliquota then
        LValores[J] := Report.RTC.FormatarAliquota(APares[I, J].Valor)
      else
        LValores[J] := Report.RTC.FormatarValor(APares[I, J].Valor);

      LValores[J] := Pontilhado(APDF, APares[I, J].Rotulo, LValores[J], LWPar);
    end;

    LTexto := LValores[0] + cSeparador + LValores[1];
    APDF.TextBox(FX[AColuna] + 0.5, AY + (I * AAlturaLinha), LW, AAlturaLinha, LTexto, 'T', 'L',
      False, False, False);
  end;
end;

procedure TBlocoItensRTC.DesenharItem(const APDF: IFPDF; AIndex: Integer; const AItem: TItemDesenhoRTC;
  AY: Double);
var
  I: Integer;
  LY, LW, LAltura: Double;
  LItem: TACBrNFeDANFeRTCItem;
  LRTC: TACBrNFeDANFeRTC;
begin
  LRTC := Report.RTC;
  LItem := LRTC.Item(AIndex);
  LY := AY + 0.5;
  LW := FX[1] - FX[0] - 1;

  LAltura := AlturaLinhaTexto(APDF, 7);
  DesenharLinhas(APDF, FX[0] + 0.5, LY, LW, LAltura, AItem.Descricao, 'L');
  LY := LY + (Length(AItem.Descricao) * LAltura);

  LAltura := AlturaLinhaTexto(APDF, 6);
  APDF.SetTextColor(100, 100, 100);
  DesenharLinhas(APDF, FX[0] + 0.5, LY, LW, LAltura, AItem.Adicional, 'L');
  APDF.SetTextColor(0, 0, 0);
  LY := LY + (Length(AItem.Adicional) * LAltura);
  APDF.TextBox(FX[0] + 0.5, LY, LW, LAltura, AItem.Classificacao, 'T', 'R', False, False, False);

  LY := AY + 0.5;
  LW := FX[2] - FX[1] - 1;
  APDF.TextBox(FX[1] + 0.5, LY, LW, LAltura, Pontilhado(APDF, 'CST', LItem.CST, LW), 'T', 'L',
    False, False, False);
  APDF.TextBox(FX[1] + 0.5, LY + LAltura, LW, LAltura, Pontilhado(APDF, 'CFOP', LItem.CFOP, LW), 'T', 'L',
    False, False, False);

  LW := FX[3] - FX[2] - 1;
  DesenharLinhas(APDF, FX[2] + 0.5, LY, LW, LAltura, AItem.Quantidades, 'C');
  DesenharLinhas(APDF, FX[2] + 0.5, LY + (Length(AItem.Quantidades) * LAltura), LW, LAltura,
    AItem.Unidades, 'C');

  DesenharLinhas(APDF, FX[3] + 0.5, LY, FX[4] - FX[3] - 1, LAltura, AItem.ValoresUnitarios, 'R');
  APDF.TextBox(FX[4] + 0.5, LY, FX[5] - FX[4] - 1, LAltura, AItem.ValorTotal, 'T', 'R', False, False, False);

  LAltura := AlturaLinhaTexto(APDF, 5.5);
  LW := FX[6] - FX[5] - 1;
  for I := Low(LItem.Bases) to High(LItem.Bases) do
    APDF.TextBox(FX[5] + 0.5, LY + (I * LAltura), LW, LAltura,
      Pontilhado(APDF, LItem.Bases[I].Rotulo, LRTC.FormatarValor(LItem.Bases[I].Valor), LW), 'T', 'L',
      False, False, False);

  DesenharPares(APDF, 6, LY, LAltura, LItem.Aliquotas, True);
  DesenharPares(APDF, 7, LY, LAltura, LItem.Valores, False);
end;

procedure TBlocoItensRTC.OnInit(Args: TFPDFBandInitArgs);
begin
  FItemAtual := 0;
  AutoHeight := True;
  Height := 12;
end;

procedure TBlocoItensRTC.OnDraw(Args: TFPDFBandDrawArgs);
const
  cTitulos: array[0..cColunasItens - 1] of String = ('DESCRIÇÃO DO PRODUTO / SERVIÇO', 'CST / CFOP',
    'QTD / UN', 'VLR UNIT', 'VLR TOTAL', 'BASES DE CÁLCULO', 'ALÍQUOTAS', 'VALOR DOS TRIBUTOS');
  cAlturaCabecalhoItens = 6;
var
  LPDF: IFPDF;
  I: Integer;
  LLimite, LTopo, LInicioItens, LY: Double;
  LItem: TItemDesenhoRTC;
begin
  LPDF := Args.PDF;

  if Height <= Args.FreeSpace - Args.ReservedSpace then
    LLimite := Args.FreeSpace - Args.ReservedSpace
  else
    LLimite := Args.FreeSpace;
  if LLimite <= 0 then
    Exit;

  CalcularColunas;

  LY := 1;
  Titulo(LPDF, 0, LY, Width, 'DADOS DOS PRODUTOS / SERVIÇOS');

  LTopo := LY + Report.AlturaTitulo;
  LPDF.SetFont(6, 'B');
  for I := 0 to cColunasItens - 1 do
    LPDF.TextBox(FX[I] + 0.5, LTopo, FX[I + 1] - FX[I] - 1, cAlturaCabecalhoItens, cTitulos[I], 'C', 'C',
      False, True, False);

  LInicioItens := LTopo + cAlturaCabecalhoItens;
  LY := LInicioItens;
  while FItemAtual < Report.RTC.QuantidadeItens do
  begin
    PrepararItem(LPDF, FItemAtual, LItem);
    if (LY + LItem.Altura > LLimite) and (LY > LInicioItens) then
      Break;

    LPDF.SetFont(7, '');
    DesenharItem(LPDF, FItemAtual, LItem, LY);
    LY := LY + LItem.Altura;
    LPDF.Line(0, LY, Width, LY);
    Inc(FItemAtual);
  end;

  LPDF.Rect(0, LTopo, Width, LY - LTopo);
  LPDF.Line(0, LInicioItens, Width, LInicioItens);
  for I := 1 to cColunasItens - 1 do
    LPDF.Line(FX[I], LTopo, FX[I], LY);

  Height := LY + 0.5;
  Args.DrawAgain := (FItemAtual < Report.RTC.QuantidadeItens);
end;

{ TBlocoDadosAdicionaisRTC }

constructor TBlocoDadosAdicionaisRTC.Create(AReport: TNFeDANFeFPDFRTC);
begin
  inherited Create(btPageFooter, AReport);
end;

function TBlocoDadosAdicionaisRTC.LarguraQRCode: Double;
begin
  Result := 0;
  if not FExibeQRCode then
    Exit;

  Result := Width * 0.2;
  if Result < (Report.TamanhoQRCode + 6) then
    Result := Report.TamanhoQRCode + 6;
end;

procedure TBlocoDadosAdicionaisRTC.OnInit(Args: TFPDFBandInitArgs);
var
  LPDF: TFPDFExt2;
  LLinhas: TStringArray;
  I, LQuantidade: Integer;
  LWTexto: Double;
begin
  Visible := True;
  FExibeQRCode := Report.RTC.ExibeQRCode;
  FTexto := Report.NFeUtils.GetTextoAdicional;

  LWTexto := Width - LarguraQRCode;
  if FExibeQRCode then
    LWTexto := LWTexto - 1.5;
  LWTexto := (LWTexto * 0.6) - 2;
  LPDF := TFPDFExt2.Create;
  try
    LPDF.SetFont('Times', '', 6);
    LLinhas := ACBr_fpdf.Split(FTexto, sLineBreak);
    LQuantidade := 0;
    for I := 0 to High(LLinhas) do
      LQuantidade := LQuantidade + LPDF.GetNumLines(LLinhas[I], LWTexto);

    Height := (LQuantidade * (LPDF.CurrentFontSize + 0.4)) + 10;
  finally
    LPDF.Free;
  end;

  if Height < (4 * Report.AlturaLinha) then
    Height := 4 * Report.AlturaLinha;

  if FExibeQRCode and (Height < (Report.TamanhoQRCode + 12)) then
    Height := Report.TamanhoQRCode + 12;
end;

procedure TBlocoDadosAdicionaisRTC.OnDraw(Args: TFPDFBandDrawArgs);
var
  LPDF: IFPDF;
  LWQRCode, LWDados, LWInformacoes, LXQRCode, LY, LH, LTamanho: Double;
begin
  LPDF := Args.PDF;
  LWQRCode := LarguraQRCode;
  LWDados := Width - LWQRCode;
  if FExibeQRCode then
    LWDados := LWDados - 1.5;
  LWInformacoes := LWDados * 0.6;

  LY := 1;
  Titulo(LPDF, 0, LY, LWDados, 'DADOS ADICIONAIS');
  LY := LY + Report.AlturaTitulo;
  LH := Height - LY - 0.5;

  Campo(LPDF, 0, LY, LWInformacoes, LH, 'INFORMAÇÕES COMPLEMENTARES', '');
  Campo(LPDF, LWInformacoes, LY, LWDados - LWInformacoes, LH, 'RESERVADO AO FISCO', '');
  LPDF.SetFont(6, '');
  LPDF.TextBox(1, LY + 3, LWInformacoes - 2, LH - 4, FTexto, 'T', 'L', False, True, False);

  if not FExibeQRCode then
    Exit;

  LXQRCode := Width - LWQRCode;
  Titulo(LPDF, LXQRCode, 1, LWQRCode, 'QR CODE', 'C');
  LPDF.Rect(LXQRCode, LY, LWQRCode, LH);

  LTamanho := Report.TamanhoQRCode;
  if LTamanho > (LH - 4) then
    LTamanho := LH - 4;
  LPDF.SetFillColor(0, 0, 0);
  LPDF.QRCode(LXQRCode + ((LWQRCode - LTamanho) / 2), LY + ((LH - LTamanho) / 2), LTamanho,
    Report.RTC.QRCode);
end;

{ TBlocoRodapeRTC }

constructor TBlocoRodapeRTC.Create(AReport: TNFeDANFeFPDFRTC);
begin
  inherited Create(btPageFooter, AReport);
end;

procedure TBlocoRodapeRTC.OnInit(Args: TFPDFBandInitArgs);
begin
  Visible := (Report.MensagemRodape <> '');
  Height := 4;
end;

procedure TBlocoRodapeRTC.OnDraw(Args: TFPDFBandDrawArgs);
begin
  Args.PDF.SetFont(6, 'I');
  Args.PDF.TextBox(0, 0.5, Width, 3, NativeStringToAnsi(Report.MensagemRodape), 'T', 'L',
    False, False, False);
end;

{ TBlocoMarcaDaguaRTC }

constructor TBlocoMarcaDaguaRTC.Create(AReport: TNFeDANFeFPDFRTC);
begin
  inherited Create(btWatermark, AReport);
end;

procedure TBlocoMarcaDaguaRTC.Marca(const APDF: IFPDF; AY: Double; const ATexto: String; ATamanho: Double);
begin
  APDF.SetTextColor(220, 220, 220);
  APDF.SetFont(ATamanho, 'B');
  APDF.TextBox(5, AY, Width - 10, 20, ATexto, 'C', 'C', False, True, False);
  APDF.SetTextColor(0, 0, 0);
end;

procedure TBlocoMarcaDaguaRTC.OnDraw(Args: TFPDFBandDrawArgs);
var
  LPDF: IFPDF;
  LY: Double;
  LUtils: TNFeUtilsFPDF;
begin
  LPDF := Args.PDF;
  LUtils := Report.NFeUtils;
  LY := Height / 2;

  if Report.DANFEClassOwner.Cancelada or LUtils.NotaCancelada then
    Marca(LPDF, LY - 40, 'NOTA CANCELADA', 48);

  if LUtils.NotaDenegada then
  begin
    Marca(LPDF, LY - 40, 'NF-e USO DENEGADO', 48);
    Marca(LPDF, LY - 20, 'SEM VALOR FISCAL', 36);
  end;

  if LUtils.NotaEPEC then
    Marca(LPDF, LY - 70, 'DANFE impresso em contingência - EPEC regularmente recebido pela Receita ' +
      'Federal do Brasil', 30);

  if NFe.Ide.tpAmb = taHomologacao then
  begin
    Marca(LPDF, LY, 'SEM VALOR FISCAL', 48);
    Marca(LPDF, LY + 18, 'AMBIENTE DE HOMOLOGAÇÃO', 30);
  end
  else if (NFe.Ide.tpEmis in [teContingencia, teFSDA]) and not LUtils.NotaEPEC then
  begin
    Marca(LPDF, LY, 'DANFE Emitido em Contingência', 48);
    Marca(LPDF, LY + 18, 'devido a problemas técnicos', 30);
  end
  else if (NFe.procNFe.nProt = '') and not LUtils.NotaEPEC then
  begin
    Marca(LPDF, LY, 'SEM VALOR FISCAL', 48);
    Marca(LPDF, LY + 18, 'FALTA PROTOCOLO DE AUTORIZAÇÃO DA SEFAZ', 30);
  end;
end;

{ TNFeDANFeFPDFRTC }

constructor TNFeDANFeFPDFRTC.Create(ANFe: TNFe; ADANFEClassOwner: TACBrNFeDANFEClass);
begin
  inherited Create;
  FDANFEClassOwner := ADANFEClassOwner;
  FRTC := TACBrNFeDANFeRTC.Create(ANFe);
  FNFeUtils := TNFeUtilsFPDF.Create(ANFe, ADANFEClassOwner);
  FLogo := TMemoryStream.Create;

  FPaisagem := (ADANFEClassOwner.TipoDANFE = tiPaisagem);
  //FPaisagem := (ANFe.Ide.tpImp = tiPaisagem);
  if FPaisagem then
  begin
    FAlturaLinha := 5.5;
    FAlturaTitulo := 4.5;
    FAlturaIdentificacao := 26;
    FFonteValor := 7;
    FFonteRotulo := 5;
    FMargemRotulo := 0.2;
    FDeslocamentoValor := 0.5;
    FTamanhoQRCode := 22;
  end
  else
  begin
    FAlturaLinha := 7;
    FAlturaTitulo := 5;
    FAlturaIdentificacao := 32;
    FFonteValor := 8;
    FFonteRotulo := 5.5;
    FMargemRotulo := 0.2;
    FDeslocamentoValor := 0;
    FTamanhoQRCode := 32;
  end;

  SetFont('Times');
  SetUTF8(False);
  EngineOptions.DoublePass := True;
end;

destructor TNFeDANFeFPDFRTC.Destroy;
begin
  FLogo.Free;
  FNFeUtils.Free;
  FRTC.Free;
  inherited Destroy;
end;

function TNFeDANFeFPDFRTC.NumeroNF: String;
begin
  Result := IntToStr(FRTC.NFe.Ide.nNF);
  if FDANFEClassOwner.FormatarNumeroDocumento then
    Result := FormatarNumeroDocumentoFiscal(Result);
end;

function TNFeDANFeFPDFRTC.SerieNF: String;
begin
  Result := Poem_Zeros(FRTC.NFe.Ide.serie, 3);
end;

procedure TNFeDANFeFPDFRTC.DefinirMargens;
var
  LEsquerda, LSuperior, LDireita, LInferior: Double;
begin
  LEsquerda := FDANFEClassOwner.MargemEsquerda;
  if LEsquerda = 6 then
    LEsquerda := 2;

  LSuperior := FDANFEClassOwner.MargemSuperior;
  if LSuperior = 8 then
    LSuperior := 2;

  LDireita := FDANFEClassOwner.MargemDireita;
  if LDireita = 5.1 then
    LDireita := 2;

  LInferior := FDANFEClassOwner.MargemInferior;
  if LInferior = 8 then
    LInferior := 2;

  SetMargins(LEsquerda, LSuperior, LDireita, LInferior);
end;

procedure TNFeDANFeFPDFRTC.CarregarLogo;
var
  LStringStream: TStringStream;
begin
  FLogo.Clear;
  if FDANFEClassOwner.Logo = '' then
    Exit;

  if FileExists(FDANFEClassOwner.Logo) then
    FLogo.LoadFromFile(FDANFEClassOwner.Logo)
  else
  begin
    LStringStream := TStringStream.Create(FDANFEClassOwner.Logo);
    try
      FLogo.LoadFromStream(LStringStream);
    finally
      LStringStream.Free;
    end;
  end;

  FLogo.Position := 0;
end;

procedure TNFeDANFeFPDFRTC.OnStartReport(Args: TFPDFReportEventArgs);
begin
  if FInicializado then
    Exit;

  DefinirMargens;
  CarregarLogo;

  if FPaisagem then
    AddPage(poLandscape)
  else
    AddPage(poPortrait);

  AddBand(TBlocoMarcaDaguaRTC.Create(Self));
  AddBand(TBlocoCanhotoRTC.Create(Self));
  AddBand(TBlocoCabecalhoRTC.Create(Self));
  AddBand(TBlocoDestinatarioRTC.Create(Self));
  AddBand(TBlocoLocalRTC.Create(Self, False));
  AddBand(TBlocoLocalRTC.Create(Self, True));
  if FRTC.ExibeFatura and FDANFEClassOwner.ExibeCampoFatura and FDANFEClassOwner.ExibeCampoDuplicata then
    AddBand(TBlocoFaturaRTC.Create(Self));
  AddBand(TBlocoTotalNotaRTC.Create(Self));
  AddBand(TBlocoTotalICMSIPIRTC.Create(Self));
  AddBand(TBlocoTotalIBSCBSISRTC.Create(Self));
  if FRTC.ISSQN.Exibe then
    AddBand(TBlocoISSQNRTC.Create(Self));
  if FRTC.ExibeTransporte then
    AddBand(TBlocoTransporteRTC.Create(Self));
  AddBand(TBlocoItensRTC.Create(Self));
  AddBand(TBlocoDadosAdicionaisRTC.Create(Self));
  AddBand(TBlocoRodapeRTC.Create(Self));

  FInicializado := True;
end;

end.
