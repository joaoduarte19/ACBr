{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2021 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Juliomar Marchetti                              }
{                              Victor Hugo Gonzales - Pandaaa                  }
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
unit ACBrNFSeXDANFSeFR;

interface

uses
  SysUtils,
  Classes,
  ACBrBase,
  ACBrNFSeX,
  ACBrNFSeXDANFSeClass,
  ACBrNFSeXClass,
  frxClass,
  DB,
  frxDBSet,
  frxExportPDF,
  frxBarcode,
  ACBrValidador,
  ACBrUtil.FR;

type
  EACBrNFSeXDANFSeFR = class(Exception);
  {$IFDEF RTL230_UP}
  [ComponentPlatformsAttribute(piacbrAllPlatforms)]
  {$ENDIF RTL230_UP}

  TACBrNFSeXDANFSeFR = class(TACBrNFSeXDANFSeClass)
  private
    FFastFile         : string;
    FEspessuraBorda   : Integer;
    FDANFSeXClassOwner: TACBrNFSeXDANFSeClass;
    FFastEmbutido     : Boolean;
    function GetPreparedReport: TfrxReport;
    function PrepareReport(ANFSe: TNFSe = nil): Boolean;
    procedure CriarDataSetsFrx;
    procedure CarregaDados(ANFSe: TNFSe);
    procedure CarregaIdentificacao(ANFSe: TNFSe);
    procedure CarregaItensServico(ANFSe: TNFSe);
    procedure CarregaParametros(ANFSe: TNFSe);
    procedure CarregaPrestador(ANFSe: TNFSe);
    procedure CarregaServicos(ANFSe: TNFSe);
    procedure CarregaTomador(ANFSe: TNFSe);
    procedure CarregaItermediario(ANFSe: TNFSe);
    procedure CarregaDestinatario(ANFSe: TNFSe);
    procedure CarregaTransportadora(ANFSe: TNFSe);
    procedure CarregaCondicaoPagamento(ANFSe: TNFSe);
    procedure CarregaCondicaoPagamentoParcelas(ANFSe: TNFSe);
    procedure CarregaLogoPrefeitura;
    procedure CarregaLogoPadraoNacional;
    procedure CarregaImagemPrestadora;

    function ManterDocumento(const sCpfCnpj: string): string;
    procedure frxReportBeforePrint(Sender: TfrxReportComponent);
    procedure SetDataSetsToFrxReport;
    procedure AjustaMargensReports;
    function GetACBrNFSe: TACBrNFSeX;
    function SuprimeTexto(const ATexto: String; const ATamMax: Integer): String;

  protected
    property ACBrNFSe: TACBrNFSeX read GetACBrNFSe;
  public
    frxReport: TfrxReport;

    frxPDFExport: TfrxPDFExport;

    cdsIdentificacao            : TACBrFRDataSet;
    cdsPrestador                : TACBrFRDataSet;
    cdsServicos                 : TACBrFRDataSet;
    cdsParametros               : TACBrFRDataSet;
    cdsTomador                  : TACBrFRDataSet;
    cdsIntermediario            : TACBrFRDataSet;
    cdsDestinatario             : TACBrFRDataSet;
    cdsTransportadora           : TACBrFRDataSet;
    cdsItensServico             : TACBrFRDataSet;
    cdsCondicaoPagamento        : TACBrFRDataSet;
    cdsCondicaoPagamentoParcelas: TACBrFRDataSet;


    frxIdentificacao            : TfrxDBDataset;
    frxPrestador                : TfrxDBDataset;
    frxTomador                  : TfrxDBDataset;
    frxIntermediario            : TfrxDBDataset;
    frxDestinatario             : TfrxDBDataset;
    frxTransportadora           : TfrxDBDataset;
    frxServicos                 : TfrxDBDataset;
    frxParametros               : TfrxDBDataset;
    frxItensServico             : TfrxDBDataset;
    frxCondicaoPagamento        : TfrxDBDataset;
    frxCondicaoPagamentoParcelas: TfrxDBDataset;

    FIncorporarFontesPdf    : Boolean;
    FIncorporarBackgroundPdf: Boolean;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ImprimirDANFSe(NFSe: TNFSe = nil); override;
    procedure ImprimirDANFSePDF(NFSe: TNFSe = nil); overload; override;
    procedure ImprimirDANFSePDF(AStream: TStream; NFSe: TNFSe = nil); overload;
      override;
    property PreparedReport: TfrxReport read GetPreparedReport;
    property DANFSeXClassOwner: TACBrNFSeXDANFSeClass read FDANFSeXClassOwner;
  published
    property FastFile    : string read FFastFile write FFastFile;
    property FastEmbutido: Boolean read FFastEmbutido write FFastEmbutido default
      False;
    property EspessuraBorda     : Integer read FEspessuraBorda write FEspessuraBorda;
    property IncorporarFontesPdf: Boolean read FIncorporarFontesPdf write
      FIncorporarFontesPdf;
    property IncorporarBackgroundPdf: Boolean read FIncorporarBackgroundPdf write
      FIncorporarBackgroundPdf;
  end;

implementation

uses
  StrUtils,
  DateUtils,
  Math,
  ACBrUtil.Strings,
  ACBrDFeUtil,
  ACBrUtil.Math,
  ACBrUtil.FilesIO,
  ACBrUtil.Base,
  ACBrUtil.DateTime,
  ACBrUtil.XMLHTML,
  ACBrNFSeXConversao,
  ACBrNFSeXInterface,
  ACBrImage,
  ACBrDelphiZXingQRCode,
  ACBrNFSeXConfiguracoes,
  ACBrDFe.Conversao
  // , FastReportFramework
  // , NFSeBuilder
  // , FastReportConstants
    ;

constructor TACBrNFSeXDANFSeFR.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDANFSeXClassOwner := TACBrNFSeXDANFSeClass(Self);
  FFastFile          := '';
  FEspessuraBorda    := 1;
  CriarDataSetsFrx;
  FIncorporarFontesPdf     := False;
  FIncorporarBackgroundPdf := False;
  FFastEmbutido            := False;
end;

destructor TACBrNFSeXDANFSeFR.Destroy;
begin
  frxIdentificacao.Free;
  frxPrestador.Free;
  frxTomador.Free;
  frxIntermediario.Free;
  frxDestinatario.Free;
  frxTransportadora.Free;
  frxServicos.Free;
  frxParametros.Free;
  frxItensServico.Free;
  frxCondicaoPagamento.Free;
  frxCondicaoPagamentoParcelas.Free;

  cdsIdentificacao.Free;
  cdsPrestador.Free;
  cdsServicos.Free;
  cdsParametros.Free;
  cdsTomador.Free;
  cdsIntermediario.Free;
  cdsDestinatario.Free;
  cdsTransportadora.Free;
  cdsItensServico.Free;
  cdsCondicaoPagamento.Free;
  cdsCondicaoPagamentoParcelas.Free;

  frxReport.Free;
  frxPDFExport.Free;

  inherited Destroy;
end;

function TACBrNFSeXDANFSeFR.GetACBrNFSe: TACBrNFSeX;
begin
  Result := TACBrNFSeX(FDANFSeXClassOwner.ACBrNFSe);
end;

function TACBrNFSeXDANFSeFR.GetPreparedReport: TfrxReport;
begin
  if Trim(FFastFile) = '' then
    Result := nil
  else
  begin
    if PrepareReport(nil) then
      Result := frxReport
    else
      Result := nil;
  end;
end;

procedure TACBrNFSeXDANFSeFR.ImprimirDANFSe(NFSe: TNFSe);
begin
  RemoveExportFastReportPDFDuplicate;
  Provedor := TACBrNFSeX(ACBrNFSe).Configuracoes.Geral.Provedor;

  DANFSeXClassOwner.FIndexImpressaoIndividual := -1;
  if PrepareReport(NFSe) then
  begin
    if MostraPreview then
      frxReport.ShowPreparedReport
    else
      frxReport.Print;
  end;
end;

procedure TACBrNFSeXDANFSeFR.ImprimirDANFSePDF(AStream: TStream; NFSe: TNFSe);
const
  TITULO_PDF = 'Nota Fiscal de Serviço Eletrônica';
var
  I             : Integer;
  LArquivoPDF   : string;
  LOldShowDialog: Boolean;
begin
  Provedor := TACBrNFSeX(ACBrNFSe).Configuracoes.Geral.Provedor;

  if PrepareReport(NFSe) then
  begin
    frxPDFExport.Author        := Sistema;
    frxPDFExport.Creator       := Sistema;
    frxPDFExport.Subject       := TITULO_PDF;
    frxPDFExport.EmbeddedFonts := False;
    frxPDFExport.Background    := IncorporarBackgroundPdf;
    frxPDFExport.EmbeddedFonts := IncorporarFontesPdf;

    LOldShowDialog := frxPDFExport.ShowDialog;
    try
      frxPDFExport.ShowDialog := False;

      frxPDFExport.Stream := AStream;
      frxReport.Export(frxPDFExport);
    finally
      frxPDFExport.ShowDialog := LOldShowDialog;
    end;
  end;
end;

procedure TACBrNFSeXDANFSeFR.ImprimirDANFSePDF(NFSe: TNFSe);
const
  TITULO_PDF = 'Nota Fiscal de Serviço Eletrônica';
var
  I            : Integer;
  LArquivoPDF  : string;
  OldShowDialog: Boolean;
begin
  Provedor := TACBrNFSeX(ACBrNFSe).Configuracoes.Geral.Provedor;

  for I := 1 to TACBrNFSeX(ACBrNFSe).NotasFiscais.Count do
  begin
    DANFSeXClassOwner.FIndexImpressaoIndividual := I;
    if PrepareReport(NFSe) then
    begin
      frxPDFExport.Author        := Sistema;
      frxPDFExport.Creator       := Sistema;
      frxPDFExport.Subject       := TITULO_PDF;
      frxPDFExport.EmbeddedFonts := False;
      frxPDFExport.Background    := IncorporarBackgroundPdf;
      frxPDFExport.EmbeddedFonts := IncorporarFontesPdf;

      OldShowDialog := frxPDFExport.ShowDialog;
      try
        frxPDFExport.ShowDialog := False;
        LArquivoPDF             := Trim(DANFSeXClassOwner.NomeDocumento);

        if EstaVazio(LArquivoPDF) then
          if Assigned(NFSe) then
            LArquivoPDF := TACBrNFSeX(ACBrNFSe).NumID[NFSe] + '-nfse.pdf'
          else
            LArquivoPDF :=
              TACBrNFSeX(ACBrNFSe).NumID[TACBrNFSeX(ACBrNFSe).NotasFiscais.Items[I
              - 1].NFSe] + '-nfse.pdf';

        frxPDFExport.FileName := PathWithDelim(DANFSeXClassOwner.PathPDF) +
          LArquivoPDF;

        if not DirectoryExists(ExtractFileDir(frxPDFExport.FileName)) then
          ForceDirectories(ExtractFileDir(frxPDFExport.FileName));

        frxReport.Export(frxPDFExport);

        FPArquivoPDF := frxPDFExport.FileName;
        if Assigned(NFSe) then
          Break;
      finally
        frxPDFExport.ShowDialog := OldShowDialog;
      end;
    end;
  end;
end;

procedure TACBrNFSeXDANFSeFR.AjustaMargensReports;
var
  Page: TfrxReportPage;
  I   : Integer;
begin
  for I := 0 to (frxReport.PreviewPages.Count - 1) do
  begin
    Page := frxReport.PreviewPages.Page[I];
    if (MargemSuperior > 0) and (MargemSuperior <> 8) then
      Page.TopMargin := MargemSuperior;
    if (MargemInferior > 0) and (MargemInferior <> 8) then
      Page.BottomMargin := MargemInferior;
    if (MargemEsquerda > 0) and (MargemEsquerda <> 6) then
      Page.LeftMargin := MargemEsquerda;
    if (MargemDireita > 0) and (MargemDireita <> 5.1) then
      Page.RightMargin := MargemDireita;
    frxReport.PreviewPages.ModifyPage(I, Page);
  end;
end;

procedure TACBrNFSeXDANFSeFR.SetDataSetsToFrxReport;
begin
  frxReport.EnabledDataSets.Clear;
  frxReport.EnabledDataSets.Add(frxIdentificacao);
  frxReport.EnabledDataSets.Add(frxPrestador);
  frxReport.EnabledDataSets.Add(frxTomador);
  frxReport.EnabledDataSets.Add(frxIntermediario);
  frxReport.EnabledDataSets.Add(frxDestinatario);
  frxReport.EnabledDataSets.Add(frxTransportadora);
  frxReport.EnabledDataSets.Add(frxServicos);
  frxReport.EnabledDataSets.Add(frxParametros);
  frxReport.EnabledDataSets.Add(frxItensServico);
  frxReport.EnabledDataSets.Add(frxCondicaoPagamento);
  frxReport.EnabledDataSets.Add(frxCondicaoPagamentoParcelas);
end;

function TACBrNFSeXDANFSeFR.PrepareReport(ANFSe: TNFSe): Boolean;
var
  I             : Integer;
  wProjectStream: TStringStream;
  // LBuilder: TNFSeBuilder;
begin
  Result := False;

  SetDataSetsToFrxReport;
  // if FFastEmbutido then
  // begin
  // // Cria builder
  // LBuilder := TNFSeBuilder
  // .Create(
  // TFastReportFramework
  // .Create(feAutoDetect)
  // .GetAdapter);
  // end
  // else
  // begin
  if Trim(FastFile) <> '' then
  begin
    if not(uppercase(copy(FastFile, length(FastFile) - 3, 4)) = '.FR3') then
    begin
      wProjectStream          := TStringStream.Create(FastFile);
      frxReport.FileName      := '';
      wProjectStream.Position := 0;
      frxReport.LoadFromStream(wProjectStream);
      wProjectStream.Free;
    end
    else
    begin
      if FileExists(FastFile) then
        frxReport.LoadFromFile(FastFile)
      else
        raise
          EACBrNFSeXDANFSeFR.CreateFmt('Caminho do arquivo de impressão do DANFSe "%s" inválido.', [FastFile]);
    end;
  end
  else
    raise
      EACBrNFSeXDANFSeFR.Create('Caminho do arquivo de impressão do DANFSe não assinalado.');
  // end;
  frxReport.ShowProgress             := MostraStatus;
  frxReport.PreviewOptions.AllowEdit := False;

  // Define a impressora
  if EstaVazio(Impressora) then
    SetDefaultPrinter(frxReport)
  else
    frxReport.PrintOptions.Printer := Impressora;

  frxReport.PrintOptions.Copies     := NumCopias;
  frxReport.PrintOptions.ShowDialog := MostraSetup;

  if Assigned(ANFSe) then
  begin
    CarregaDados(ANFSe);
    // if FastEmbutido then
    // // Gera relatório
    // frxReport := LBuilder.BuildNFSe(
    // Self.cdsIdentificacao,
    // Self.cdsParametros,
    // Self.cdsPrestador,
    // Self.cdsTomador,
    // Self.cdsServicos
    // );
    Result := frxReport.PrepareReport;
  end
  else
  begin
    if Assigned(ACBrNFSe) then
    begin
      if DANFSeXClassOwner.FIndexImpressaoIndividual > 0 then
      begin
        CarregaDados(TACBrNFSeX(ACBrNFSe).NotasFiscais.Items[DANFSeXClassOwner.FIndexImpressaoIndividual - 1].NFSe);
        // if FastEmbutido then
        // // Gera relatório
        // frxReport := LBuilder.BuildNFSe(
        // Self.cdsIdentificacao,
        // Self.cdsParametros,
        // Self.cdsPrestador,
        // Self.cdsTomador,
        // Self.cdsServicos
        // );
        Result :=
          frxReport.PrepareReport(DANFSeXClassOwner.FIndexImpressaoIndividual >
          0);
      end
      else
      begin
        for I := 0 to TACBrNFSeX(ACBrNFSe).NotasFiscais.Count - 1 do
        begin
          CarregaDados(TACBrNFSeX(ACBrNFSe).NotasFiscais.Items[I].NFSe);
          // if FastEmbutido then
          // // Gera relatório
          // frxReport := LBuilder.BuildNFSe(
          // Self.cdsIdentificacao,
          // Self.cdsParametros,
          // Self.cdsPrestador,
          // Self.cdsTomador,
          // Self.cdsServicos
          // );
          Result := frxReport.PrepareReport(not(I > 0));
        end;
      end;
    end
    else
      raise EACBrNFSeXDANFSeFR.Create('Propriedade ACBrNFSe não assinalada.');
  end;

  AjustaMargensReports;
end;

procedure TACBrNFSeXDANFSeFR.CriarDataSetsFrx;
begin
  frxReport                        := TfrxReport.Create(nil);
  frxReport.PreviewOptions.Buttons := [pbPrint, pbLoad, pbSave, pbExport,
    pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbNavigator, pbExportQuick];
  frxReport.EngineOptions.UseGlobalDataSetList := False;

  frxReport.Tag := 1;

  frxReport.DotMatrixReport        := False;
  frxReport.IniFile                := '\Software\Fast Reports';
  frxReport.PreviewOptions.Buttons := [pbPrint, pbZoom, pbFind, pbNavigator,
    pbExportQuick];
  frxReport.PreviewOptions.Zoom       := 1.000000000000000000;
  frxReport.PrintOptions.PrintOnSheet := 0;
  frxReport.ScriptLanguage            := 'PascalScript';
  frxReport.StoreInDFM                := False;
  frxReport.OnBeforePrint             := frxReportBeforePrint;
  frxReport.OnReportPrint             := 'frxReportOnReportPrint';

  frxPDFExport := TfrxPDFExport.Create(nil);

  frxPDFExport.UseFileCache    := True;
  frxPDFExport.ShowProgress    := True;
  frxPDFExport.OverwritePrompt := False;
  frxPDFExport.PrintOptimized  := True;
  frxPDFExport.Outline         := False;
  frxPDFExport.Background      := True;
  frxPDFExport.HTMLTags        := True;
  frxPDFExport.Author          := 'FastReport';
  frxPDFExport.Subject         := 'Exportando o DANFSe para PDF';
  frxPDFExport.HideToolbar     := False;
  frxPDFExport.HideMenubar     := False;
  frxPDFExport.HideWindowUI    := False;
  frxPDFExport.FitWindow       := False;
  frxPDFExport.CenterWindow    := False;
  frxPDFExport.PrintScaling    := False;

  RttiSetProp(frxPDFExport, 'Transparency', 'False');

  cdsIdentificacao := TACBrFRDataSet.Create(nil);

  cdsIdentificacao.Close;

  cdsIdentificacao.FieldDefs.Clear;
  cdsIdentificacao.FieldDefs.Add('id', ftString, 10);
  cdsIdentificacao.FieldDefs.Add('Numero', ftString, 16);
  cdsIdentificacao.FieldDefs.Add('Serie', ftString, 5);
  cdsIdentificacao.FieldDefs.Add('Tipo', ftString, 1);
  cdsIdentificacao.FieldDefs.Add('Competencia', ftString, 20);
  cdsIdentificacao.FieldDefs.Add('NumeroNFSe', ftString, 16);
  cdsIdentificacao.FieldDefs.Add('NFSeSubstituida', ftString, 16);
  cdsIdentificacao.FieldDefs.Add('DataEmissao', ftString, 19);
  cdsIdentificacao.FieldDefs.Add('dhProc', ftString, 19);
  cdsIdentificacao.FieldDefs.Add('CodigoVerificacao', ftString, 50);
  cdsIdentificacao.FieldDefs.Add('LinkNFSe', ftString, 500);
  cdsIdentificacao.FieldDefs.Add('tpAmb', ftString, 1);
  cdsIdentificacao.FieldDefs.Add('xtpAmb', ftString, 11);
  cdsIdentificacao.FieldDefs.Add('tpEmit', ftString, 1);
  cdsIdentificacao.FieldDefs.Add('xtpEmit', ftString, 25);
  cdsIdentificacao.FieldDefs.Add('xsitNFSe', ftString, 40);
  cdsIdentificacao.FieldDefs.Add('xfinNFSe', ftString, 40);
  cdsIdentificacao.FieldDefs.Add('xambGer', ftString, 25);

  cdsIdentificacao.CreateDataSet;
  {$IFNDEF FPC}
  cdsIdentificacao.LogChanges := False;
  {$ELSE}
  cdsIdentificacao.Open;
  {$ENDIF}
  cdsPrestador := TACBrFRDataSet.Create(nil);

  cdsPrestador.Close;

  cdsPrestador.FieldDefs.Clear;
  cdsPrestador.FieldDefs.Add('Cnpj', ftString, 18);
  cdsPrestador.FieldDefs.Add('InscricaoMunicipal', ftString, 15);
  cdsPrestador.FieldDefs.Add('InscricaoEstadual', ftString, 20);
  cdsPrestador.FieldDefs.Add('RazaoSocial', ftString, 80);
  cdsPrestador.FieldDefs.Add('NomeFantasia', ftString, 60);
  cdsPrestador.FieldDefs.Add('Endereco', ftString, 60);
  cdsPrestador.FieldDefs.Add('Numero', ftString, 60);
  cdsPrestador.FieldDefs.Add('Complemento', ftString, 60);
  cdsPrestador.FieldDefs.Add('Bairro', ftString, 60);
  cdsPrestador.FieldDefs.Add('CodigoMunicipio', ftString, 7);
  cdsPrestador.FieldDefs.Add('UF', ftString, 2);
  cdsPrestador.FieldDefs.Add('CEP', ftString, 9);
  cdsPrestador.FieldDefs.Add('xMunicipio', ftString, 60);
  cdsPrestador.FieldDefs.Add('CodigoPais', ftString, 4);
  cdsPrestador.FieldDefs.Add('Telefone', ftString, 15);
  cdsPrestador.FieldDefs.Add('Email', ftString, 60);
  cdsPrestador.FieldDefs.Add('RegimeApuracao', ftString, 80);

  cdsPrestador.CreateDataSet;

  {$IFNDEF FPC}
  cdsPrestador.LogChanges := False;
  {$ELSE}
  cdsPrestador.Open;
  {$ENDIF}
  cdsServicos := TACBrFRDataSet.Create(nil);

  cdsServicos.Close;

  cdsServicos.FieldDefs.Clear;
  cdsServicos.FieldDefs.Add('ItemListaServico', ftString, 8);
  cdsServicos.FieldDefs.Add('CodigoCnae', ftString, 15);
  cdsServicos.FieldDefs.Add('CodigoNbs', ftString, 9);
  cdsServicos.FieldDefs.Add('CodigoTributacaoMunicipio', ftString, 20);
  cdsServicos.FieldDefs.Add('Discriminacao', ftString, 1300);
  cdsServicos.FieldDefs.Add('ExigibilidadeISS', ftString, 40);
  cdsServicos.FieldDefs.Add('CodigoMunicipio', ftString, 60);
  cdsServicos.FieldDefs.Add('MunicipioIncidencia', ftString, 60);
  cdsServicos.FieldDefs.Add('CodigoPais', ftString, 4);
  cdsServicos.FieldDefs.Add('xNomePais', ftString, 50);
  cdsServicos.FieldDefs.Add('xSiglaPais', ftString, 5);
  cdsServicos.FieldDefs.Add('NumeroProcesso', ftString, 10);
  cdsServicos.FieldDefs.Add('xItemListaServico', ftString, 170);
  cdsServicos.FieldDefs.Add('ResponsavelRetencao', ftString, 1);
  cdsServicos.FieldDefs.Add('Descricao', ftString, 80);
  cdsServicos.FieldDefs.Add('ValorServicos', ftCurrency);
  cdsServicos.FieldDefs.Add('ValorDeducoes', ftCurrency);
  cdsServicos.FieldDefs.Add('ValorPis', ftCurrency);
  cdsServicos.FieldDefs.Add('ValorCofins', ftCurrency);
  cdsServicos.FieldDefs.Add('ValorInss', ftCurrency);
  cdsServicos.FieldDefs.Add('ValorIr', ftCurrency);
  cdsServicos.FieldDefs.Add('ValorCsll', ftCurrency);
  cdsServicos.FieldDefs.Add('IssRetido', ftString, 30);
  cdsServicos.FieldDefs.Add('ValorIss', ftCurrency);
  cdsServicos.FieldDefs.Add('OutrasRetencoes', ftCurrency);
  cdsServicos.FieldDefs.Add('BaseCalculo', ftCurrency);
  cdsServicos.FieldDefs.Add('Aliquota', ftCurrency);
  cdsServicos.FieldDefs.Add('ValorLiquidoNfse', ftCurrency);
  cdsServicos.FieldDefs.Add('ValorIssRetido', ftCurrency);
  cdsServicos.FieldDefs.Add('DescontoCondicionado', ftCurrency);
  cdsServicos.FieldDefs.Add('DescontoIncondicionado', ftCurrency);
  cdsServicos.FieldDefs.Add('TotalServicos', ftCurrency);
  cdsServicos.FieldDefs.Add('TotalNota', ftCurrency);
  cdsServicos.FieldDefs.Add('Tributacao', ftString, 1);
  cdsServicos.FieldDefs.Add('OutrosDescontos', ftCurrency);
  cdsServicos.FieldDefs.Add('DescricaoTotalRetDemo', ftString, 19);
  cdsServicos.FieldDefs.Add('DescriçãoTributosFederais', ftString, 35);
  cdsServicos.FieldDefs.Add('ValorTotalNotaFiscal', ftCurrency);
  cdsServicos.FieldDefs.Add('xtpBM', ftString, 40);


  cdsServicos.FieldDefs.Add('ValorCargaTributaria', ftCurrency);
  cdsServicos.FieldDefs.Add('PercentualCargaTributaria', ftCurrency);
  cdsServicos.FieldDefs.Add('FonteCargaTributaria', ftString, 10);


  cdsServicos.FieldDefs.Add('tribISSQN', ftString, 25);
  cdsServicos.FieldDefs.Add('xtpImunidade', ftString, 40);
  cdsServicos.FieldDefs.Add('tpRetISSQN', ftString, 25);
  cdsServicos.FieldDefs.Add('CST', ftString, 2);
  cdsServicos.FieldDefs.Add('vBCPisCofins', ftCurrency);
  cdsServicos.FieldDefs.Add('pAliqPis', ftCurrency);
  cdsServicos.FieldDefs.Add('pAliqCofins', ftCurrency);
  cdsServicos.FieldDefs.Add('tpRetPisCofins', ftString, 1);
  cdsServicos.FieldDefs.Add('DescRetPisCofins', ftString, 40);
  cdsServicos.FieldDefs.Add('pTotTribFed', ftCurrency);
  cdsServicos.FieldDefs.Add('vTotTribFed', ftCurrency);
  cdsServicos.FieldDefs.Add('pTotTribEst', ftCurrency);
  cdsServicos.FieldDefs.Add('vTotTribEst', ftCurrency);
  cdsServicos.FieldDefs.Add('pTotTribMun', ftCurrency);
  cdsServicos.FieldDefs.Add('vTotTribMun', ftCurrency);

  cdsServicos.CreateDataSet;
  {$IFNDEF FPC}
  cdsServicos.LogChanges := False;
  {$ELSE}
  cdsServicos.Open;
  {$ENDIF}
  cdsParametros := TACBrFRDataSet.Create(nil);

  cdsParametros.Close;

  cdsParametros.FieldDefs.Clear;
  cdsParametros.FieldDefs.Add('ExigibilidadeISS', ftString, 40);
  cdsParametros.FieldDefs.Add('CodigoMunicipio', ftString, 60);
  cdsParametros.FieldDefs.Add('MunicipioIncidencia', ftString, 60);
  cdsParametros.FieldDefs.Add('xMunicipioIncidencia', ftString, 60);
  cdsParametros.FieldDefs.Add('MunicipioPrestacao', ftString, 60);
  cdsParametros.FieldDefs.Add('OutrasInformacoes', ftString, 2000);
  cdsParametros.FieldDefs.Add('InformacoesComplementares', ftString, 1000);
  cdsParametros.FieldDefs.Add('CodigoObra', ftString, 60);
  cdsParametros.FieldDefs.Add('Art', ftString, 60);
  cdsParametros.FieldDefs.Add('Imagem', ftString, 256);
  cdsParametros.FieldDefs.Add('LogoExpandido', ftString, 1);
  cdsParametros.FieldDefs.Add('LogoCarregado', ftBlob);
  cdsParametros.FieldDefs.Add('imgPrefeitura', ftString, 256);
  cdsParametros.FieldDefs.Add('imgLogoNFSe', ftString, 256);
  cdsParametros.FieldDefs.Add('LogoPrefExpandido', ftString, 1);
  cdsParametros.FieldDefs.Add('LogoPrefCarregado', ftBlob);
  cdsParametros.FieldDefs.Add('LogoNFSe', ftBlob);
  cdsParametros.FieldDefs.Add('Nome_Prefeitura', ftString, 256);
  cdsParametros.FieldDefs.Add('Mensagem0', ftString, 60);
  cdsParametros.FieldDefs.Add('Sistema', ftString, 150);
  cdsParametros.FieldDefs.Add('Usuario', ftString, 50);
  cdsParametros.FieldDefs.Add('Site', ftString, 50);
  cdsParametros.FieldDefs.Add('NaturezaOperacao', ftString, 50);
  cdsParametros.FieldDefs.Add('RegimeEspecialTributacao', ftString, 80);
  cdsParametros.FieldDefs.Add('OptanteSimplesNacional', ftString, 40);
  cdsParametros.FieldDefs.Add('IncentivadorCultural', ftString, 10);
  cdsParametros.FieldDefs.Add('TipoRecolhimento', ftString, 15);
  cdsParametros.FieldDefs.Add('id_sis_legado', ftInteger);
  //
  cdsParametros.FieldDefs.Add('ValorCredito', ftCurrency);

  cdsParametros.CreateDataSet;
  {$IFNDEF FPC}
  cdsParametros.LogChanges := False;
  {$ELSE}
  cdsParametros.Open;
  {$ENDIF}
  cdsTomador := TACBrFRDataSet.Create(nil);

  cdsTomador.Close;

  cdsTomador.FieldDefs.Clear;
  cdsTomador.FieldDefs.Add('CpfCnpj', ftString, 18);
  cdsTomador.FieldDefs.Add('InscricaoMunicipal', ftString, 15);
  cdsTomador.FieldDefs.Add('InscricaoEstadual', ftString, 20);
  cdsTomador.FieldDefs.Add('RazaoSocial', ftString, 80);
  cdsTomador.FieldDefs.Add('NomeFantasia', ftString, 60);
  cdsTomador.FieldDefs.Add('Endereco', ftString, 60);
  cdsTomador.FieldDefs.Add('Numero', ftString, 60);
  cdsTomador.FieldDefs.Add('Complemento', ftString, 60);
  cdsTomador.FieldDefs.Add('Bairro', ftString, 60);
  cdsTomador.FieldDefs.Add('CodigoMunicipio', ftString, 7);
  cdsTomador.FieldDefs.Add('UF', ftString, 2);
  cdsTomador.FieldDefs.Add('CEP', ftString, 9);
  cdsTomador.FieldDefs.Add('xMunicipio', ftString, 60);
  cdsTomador.FieldDefs.Add('CodigoPais', ftString, 4);
  cdsTomador.FieldDefs.Add('Telefone', ftString, 15);
  cdsTomador.FieldDefs.Add('Email', ftString, 60);

  cdsTomador.CreateDataSet;
  {$IFNDEF FPC}
  cdsTomador.LogChanges := False;
  {$ELSE}
  cdsTomador.Open;
  {$ENDIF}
  cdsIntermediario := TACBrFRDataSet.Create(nil);

  cdsIntermediario.Close;

  cdsIntermediario.FieldDefs.Clear;
  cdsIntermediario.FieldDefs.Add('CpfCnpj', ftString, 18);
  cdsIntermediario.FieldDefs.Add('InscricaoMunicipal', ftString, 15);
  cdsIntermediario.FieldDefs.Add('InscricaoEstadual', ftString, 20);
  cdsIntermediario.FieldDefs.Add('RazaoSocial', ftString, 80);
  cdsIntermediario.FieldDefs.Add('NomeFantasia', ftString, 60);
  cdsIntermediario.FieldDefs.Add('Endereco', ftString, 60);
  cdsIntermediario.FieldDefs.Add('Numero', ftString, 60);
  cdsIntermediario.FieldDefs.Add('Complemento', ftString, 60);
  cdsIntermediario.FieldDefs.Add('Bairro', ftString, 60);
  cdsIntermediario.FieldDefs.Add('CodigoMunicipio', ftString, 7);
  cdsIntermediario.FieldDefs.Add('UF', ftString, 2);
  cdsIntermediario.FieldDefs.Add('CEP', ftString, 9);
  cdsIntermediario.FieldDefs.Add('xMunicipio', ftString, 60);
  cdsIntermediario.FieldDefs.Add('CodigoPais', ftString, 4);
  cdsIntermediario.FieldDefs.Add('Telefone', ftString, 15);
  cdsIntermediario.FieldDefs.Add('Email', ftString, 60);

  cdsIntermediario.CreateDataSet;
  {$IFNDEF FPC}
  cdsIntermediario.LogChanges := False;
  {$ELSE}
  cdsIntermediario.Open;
  {$ENDIF}
  cdsDestinatario := TACBrFRDataSet.Create(nil);

  cdsDestinatario.Close;

  cdsDestinatario.FieldDefs.Clear;
  cdsDestinatario.FieldDefs.Add('CpfCnpj', ftString, 18);
  cdsDestinatario.FieldDefs.Add('InscricaoMunicipal', ftString, 15);
  cdsDestinatario.FieldDefs.Add('InscricaoEstadual', ftString, 20);
  cdsDestinatario.FieldDefs.Add('RazaoSocial', ftString, 80);
  cdsDestinatario.FieldDefs.Add('NomeFantasia', ftString, 60);
  cdsDestinatario.FieldDefs.Add('Endereco', ftString, 60);
  cdsDestinatario.FieldDefs.Add('Numero', ftString, 60);
  cdsDestinatario.FieldDefs.Add('Complemento', ftString, 60);
  cdsDestinatario.FieldDefs.Add('Bairro', ftString, 60);
  cdsDestinatario.FieldDefs.Add('CodigoMunicipio', ftString, 7);
  cdsDestinatario.FieldDefs.Add('UF', ftString, 2);
  cdsDestinatario.FieldDefs.Add('CEP', ftString, 9);
  cdsDestinatario.FieldDefs.Add('xMunicipio', ftString, 60);
  cdsDestinatario.FieldDefs.Add('CodigoPais', ftString, 4);
  cdsDestinatario.FieldDefs.Add('Telefone', ftString, 15);
  cdsDestinatario.FieldDefs.Add('Email', ftString, 60);

  cdsDestinatario.CreateDataSet;
  {$IFNDEF FPC}
  cdsDestinatario.LogChanges := False;
  {$ELSE}
  cdsDestinatario.Open;
  {$ENDIF}
  cdsTransportadora := TACBrFRDataSet.Create(nil);

  cdsTransportadora.Close;

  cdsTransportadora.FieldDefs.Clear;
  cdsTransportadora.FieldDefs.Add('Cnpj', ftString, 18);
  cdsTransportadora.FieldDefs.Add('InscicaoEstadual', ftString, 15);
  cdsTransportadora.FieldDefs.Add('RazaoSocial', ftString, 80);
  cdsTransportadora.FieldDefs.Add('Placa', ftString, 7);
  cdsTransportadora.FieldDefs.Add('Endereco', ftString, 60);
  cdsTransportadora.FieldDefs.Add('CodigoMunicipio', ftInteger);
  cdsTransportadora.FieldDefs.Add('NomeMunicipio', ftString, 60);
  cdsTransportadora.FieldDefs.Add('Sigla', ftString, 2);
  cdsTransportadora.FieldDefs.Add('BacenPais', ftInteger);
  cdsTransportadora.FieldDefs.Add('NomePais', ftString, 60);
  cdsTransportadora.FieldDefs.Add('TipoFrete', ftInteger);

  cdsTransportadora.CreateDataSet;
  {$IFNDEF FPC}
  cdsTransportadora.LogChanges := False;
  {$ELSE}
  cdsTransportadora.Open;
  {$ENDIF}
  cdsItensServico := TACBrFRDataSet.Create(nil);
  cdsItensServico.Close;
  cdsItensServico.FieldDefs.Clear;
  cdsItensServico.FieldDefs.Add('DiscriminacaoServico', ftString, 4000);
  cdsItensServico.FieldDefs.Add('Quantidade', ftString, 10);
  cdsItensServico.FieldDefs.Add('ValorUnitario', ftString, 30);
  cdsItensServico.FieldDefs.Add('ValorTotal', ftString, 30);
  cdsItensServico.FieldDefs.Add('Tributavel', ftString, 1);
  cdsItensServico.FieldDefs.Add('Unidade', ftString, 3);
  cdsItensServico.FieldDefs.Add('Aliquota', ftString, 30);
  cdsItensServico.FieldDefs.Add('AliquotaISSST', ftString, 30);
  cdsItensServico.FieldDefs.Add('ValorISSST', ftString, 30);
  cdsItensServico.FieldDefs.Add('DescontoIncondicionado', ftString, 30);

  cdsItensServico.CreateDataSet;
  {$IFNDEF FPC}
  cdsItensServico.LogChanges := False;
  {$ELSE}
  cdsItensServico.Open;
  {$ENDIF}
  cdsCondicaoPagamento := TACBrFRDataSet.Create(nil);

  cdsCondicaoPagamento.Close;

  cdsCondicaoPagamento.FieldDefs.Clear;

  cdsCondicaoPagamento.FieldDefs.Add('Condicao', ftString, 30);
  cdsCondicaoPagamento.FieldDefs.Add('Parcela', ftString, 10);

  cdsCondicaoPagamento.CreateDataSet;
  {$IFNDEF FPC}
  cdsCondicaoPagamento.LogChanges := False;
  {$ELSE}
  cdsCondicaoPagamento.Open;
  {$ENDIF}
  cdsCondicaoPagamentoParcelas := TACBrFRDataSet.Create(nil);

  cdsCondicaoPagamentoParcelas.Close;

  cdsCondicaoPagamentoParcelas.FieldDefs.Clear;

  cdsCondicaoPagamentoParcelas.FieldDefs.Add('Condicao', ftString, 30);
  cdsCondicaoPagamentoParcelas.FieldDefs.Add('Parcela', ftString, 10);
  cdsCondicaoPagamentoParcelas.FieldDefs.Add('DataVencimento', ftString, 19);
  cdsCondicaoPagamentoParcelas.FieldDefs.Add('Valor', ftCurrency);

  cdsCondicaoPagamentoParcelas.CreateDataSet;
  {$IFNDEF FPC}
  cdsCondicaoPagamentoParcelas.LogChanges := False;
  {$ELSE}
  cdsCondicaoPagamentoParcelas.Open;
  {$ENDIF}
  frxIdentificacao := TfrxDBDataset.Create(Self);

  frxIdentificacao.UserName        := 'Identificacao';
  frxIdentificacao.Enabled         := False;
  frxIdentificacao.CloseDataSource := False;
  frxIdentificacao.OpenDataSource  := False;

  frxIdentificacao.FieldAliases.Clear;
  frxIdentificacao.FieldAliases.Add('id=id');
  frxIdentificacao.FieldAliases.Add('Numero=Numero');
  frxIdentificacao.FieldAliases.Add('Serie=Serie');
  frxIdentificacao.FieldAliases.Add('Tipo=Tipo');
  frxIdentificacao.FieldAliases.Add('Competencia=Competencia');
  frxIdentificacao.FieldAliases.Add('NumeroNFSe=NumeroNFSe');
  frxIdentificacao.FieldAliases.Add('NFSeSubstituida=NFSeSubstituida');
  frxIdentificacao.FieldAliases.Add('DataEmissao=DataEmissao');
  frxIdentificacao.FieldAliases.Add('dhProc=dhProc');
  frxIdentificacao.FieldAliases.Add('CodigoVerificacao=CodigoVerificacao');
  frxIdentificacao.FieldAliases.Add('LinkNFSe=LinkNFSe');
  frxIdentificacao.FieldAliases.Add('tpAmb=tpAmb');
  frxIdentificacao.FieldAliases.Add('xtpAmb=xtpAmb');
  frxIdentificacao.FieldAliases.Add('tpEmit=tpEmit');
  frxIdentificacao.FieldAliases.Add('xtpEmit=xtpEmit');
  frxIdentificacao.FieldAliases.Add('xsitNFSe=xsitNFSe');
  frxIdentificacao.FieldAliases.Add('xfinNFSe=xfinNFSe');
  frxIdentificacao.FieldAliases.Add('xambGer=xambGer');

  frxIdentificacao.DataSet       := cdsIdentificacao;
  frxIdentificacao.BCDToCurrency := False;

  frxCondicaoPagamento := TfrxDBDataset.Create(Self);

  frxCondicaoPagamento.UserName        := 'CondicaoPagamento';
  frxCondicaoPagamento.Enabled         := False;
  frxCondicaoPagamento.CloseDataSource := False;
  frxCondicaoPagamento.OpenDataSource  := False;
  frxCondicaoPagamento.FieldAliases.Clear;
  frxCondicaoPagamento.FieldAliases.Add('Condicao=Condicao');
  frxCondicaoPagamento.FieldAliases.Add('Parcela=Parcela');

  frxCondicaoPagamento.DataSet       := cdsCondicaoPagamento;
  frxCondicaoPagamento.BCDToCurrency := False;

  frxCondicaoPagamentoParcelas                 := TfrxDBDataset.Create(Self);
  frxCondicaoPagamentoParcelas.UserName        := 'CondicaoPagamentoParcelas';
  frxCondicaoPagamentoParcelas.Enabled         := False;
  frxCondicaoPagamentoParcelas.CloseDataSource := False;
  frxCondicaoPagamentoParcelas.OpenDataSource  := False;

  frxCondicaoPagamentoParcelas.FieldAliases.Clear;
  frxCondicaoPagamentoParcelas.FieldAliases.Add('Condicao=Condicao');
  frxCondicaoPagamentoParcelas.FieldAliases.Add('Parcela=Parcela');
  frxCondicaoPagamentoParcelas.FieldAliases.Add('DataVencimento=DataVencimento');
  frxCondicaoPagamentoParcelas.FieldAliases.Add('Valor=Valor');

  frxCondicaoPagamentoParcelas.DataSet       := cdsCondicaoPagamentoParcelas;
  frxCondicaoPagamentoParcelas.BCDToCurrency := False;

  frxPrestador := TfrxDBDataset.Create(Self);

  frxPrestador.UserName        := 'Prestador';
  frxPrestador.Enabled         := False;
  frxPrestador.CloseDataSource := False;
  frxPrestador.OpenDataSource  := False;

  frxPrestador.FieldAliases.Clear;
  frxPrestador.FieldAliases.Add('Cnpj=Cnpj');
  frxPrestador.FieldAliases.Add('InscricaoMunicipal=InscricaoMunicipal');
  frxPrestador.FieldAliases.Add('InscricaoEstadual=InscricaoEstadual');
  frxPrestador.FieldAliases.Add('RazaoSocial=RazaoSocial');
  frxPrestador.FieldAliases.Add('NomeFantasia=NomeFantasia');
  frxPrestador.FieldAliases.Add('Endereco=Endereco');
  frxPrestador.FieldAliases.Add('Numero=Numero');
  frxPrestador.FieldAliases.Add('Complemento=Complemento');
  frxPrestador.FieldAliases.Add('Bairro=Bairro');
  frxPrestador.FieldAliases.Add('CodigoMunicipio=CodigoMunicipio');
  frxPrestador.FieldAliases.Add('UF=UF');
  frxPrestador.FieldAliases.Add('CEP=CEP');
  frxPrestador.FieldAliases.Add('xMunicipio=xMunicipio');
  frxPrestador.FieldAliases.Add('CodigoPais=CodigoPais');
  frxPrestador.FieldAliases.Add('Telefone=Telefone');
  frxPrestador.FieldAliases.Add('Email=Email');
  frxPrestador.FieldAliases.Add('RegimeApuracao=RegimeApuracao');
  frxPrestador.DataSet       := cdsPrestador;
  frxPrestador.BCDToCurrency := False;

  frxTomador := TfrxDBDataset.Create(Self);

  frxTomador.UserName        := 'Tomador';
  frxTomador.Enabled         := False;
  frxTomador.CloseDataSource := False;
  frxTomador.OpenDataSource  := False;

  frxTomador.FieldAliases.Clear;
  frxTomador.FieldAliases.Add('CpfCnpj=CpfCnpj');
  frxTomador.FieldAliases.Add('InscricaoMunicipal=InscricaoMunicipal');
  frxTomador.FieldAliases.Add('InscricaoEstadual=InscricaoEstadual');
  frxTomador.FieldAliases.Add('RazaoSocial=RazaoSocial');
  frxTomador.FieldAliases.Add('NomeFantasia=NomeFantasia');
  frxTomador.FieldAliases.Add('Endereco=Endereco');
  frxTomador.FieldAliases.Add('Numero=Numero');
  frxTomador.FieldAliases.Add('Complemento=Complemento');
  frxTomador.FieldAliases.Add('Bairro=Bairro');
  frxTomador.FieldAliases.Add('CodigoMunicipio=CodigoMunicipio');
  frxTomador.FieldAliases.Add('UF=UF');
  frxTomador.FieldAliases.Add('CEP=CEP');
  frxTomador.FieldAliases.Add('xMunicipio=xMunicipio');
  frxTomador.FieldAliases.Add('CodigoPais=CodigoPais');
  frxTomador.FieldAliases.Add('Telefone=Telefone');
  frxTomador.FieldAliases.Add('Email=Email');

  frxTomador.DataSet       := cdsTomador;
  frxTomador.BCDToCurrency := False;

  frxIntermediario := TfrxDBDataset.Create(Self);

  frxIntermediario.UserName        := 'Intermediario';
  frxIntermediario.CloseDataSource := False;
  frxIntermediario.OpenDataSource  := False;

  frxIntermediario.FieldAliases.Clear;
  frxIntermediario.FieldAliases.Add('CpfCnpj=CpfCnpj');
  frxIntermediario.FieldAliases.Add('InscricaoMunicipal=InscricaoMunicipal');
  frxIntermediario.FieldAliases.Add('InscricaoEstadual=InscricaoEstadual');
  frxIntermediario.FieldAliases.Add('RazaoSocial=RazaoSocial');
  frxIntermediario.FieldAliases.Add('NomeFantasia=NomeFantasia');
  frxIntermediario.FieldAliases.Add('Endereco=Endereco');
  frxIntermediario.FieldAliases.Add('Numero=Numero');
  frxIntermediario.FieldAliases.Add('Complemento=Complemento');
  frxIntermediario.FieldAliases.Add('Bairro=Bairro');
  frxIntermediario.FieldAliases.Add('CodigoMunicipio=CodigoMunicipio');
  frxIntermediario.FieldAliases.Add('UF=UF');
  frxIntermediario.FieldAliases.Add('CEP=CEP');
  frxIntermediario.FieldAliases.Add('xMunicipio=xMunicipio');
  frxIntermediario.FieldAliases.Add('CodigoPais=CodigoPais');
  frxIntermediario.FieldAliases.Add('Telefone=Telefone');
  frxIntermediario.FieldAliases.Add('Email=Email');

  frxIntermediario.DataSet       := cdsIntermediario;
  frxIntermediario.BCDToCurrency := False;

  frxDestinatario := TfrxDBDataset.Create(Self);

  frxDestinatario.UserName        := 'Destinatario';
  frxDestinatario.CloseDataSource := False;
  frxDestinatario.OpenDataSource  := False;

  frxDestinatario.FieldAliases.Clear;
  frxDestinatario.FieldAliases.Add('CpfCnpj=CpfCnpj');
  frxDestinatario.FieldAliases.Add('InscricaoMunicipal=InscricaoMunicipal');
  frxDestinatario.FieldAliases.Add('InscricaoEstadual=InscricaoEstadual');
  frxDestinatario.FieldAliases.Add('RazaoSocial=RazaoSocial');
  frxDestinatario.FieldAliases.Add('NomeFantasia=NomeFantasia');
  frxDestinatario.FieldAliases.Add('Endereco=Endereco');
  frxDestinatario.FieldAliases.Add('Numero=Numero');
  frxDestinatario.FieldAliases.Add('Complemento=Complemento');
  frxDestinatario.FieldAliases.Add('Bairro=Bairro');
  frxDestinatario.FieldAliases.Add('CodigoMunicipio=CodigoMunicipio');
  frxDestinatario.FieldAliases.Add('UF=UF');
  frxDestinatario.FieldAliases.Add('CEP=CEP');
  frxDestinatario.FieldAliases.Add('xMunicipio=xMunicipio');
  frxDestinatario.FieldAliases.Add('CodigoPais=CodigoPais');
  frxDestinatario.FieldAliases.Add('Telefone=Telefone');
  frxDestinatario.FieldAliases.Add('Email=Email');

  frxDestinatario.DataSet       := cdsDestinatario;
  frxDestinatario.BCDToCurrency := False;

  frxTransportadora := TfrxDBDataset.Create(Self);

  frxTransportadora.UserName        := 'Transportadora';
  frxTransportadora.CloseDataSource := False;
  frxTransportadora.OpenDataSource  := False;

  frxTransportadora.FieldAliases.Clear;
  frxTransportadora.FieldAliases.Add('Cnpj=Cnpj');
  frxTransportadora.FieldAliases.Add('InscicaoEstadual=InscicaoEstadual');
  frxTransportadora.FieldAliases.Add('RazaoSocial=RazaoSocial');
  frxTransportadora.FieldAliases.Add('Placa=Placa');
  frxTransportadora.FieldAliases.Add('Endereco=Endereco');
  frxTransportadora.FieldAliases.Add('CodigoMunicipio=CodigoMunicipio');
  frxTransportadora.FieldAliases.Add('NomeMunicipio=NomeMunicipio');
  frxTransportadora.FieldAliases.Add('Sigla=Sigla');
  frxTransportadora.FieldAliases.Add('BacenPais=BacenPais');
  frxTransportadora.FieldAliases.Add('NomePais=NomePais');
  frxTransportadora.FieldAliases.Add('TipoFrete=TipoFrete');

  frxTransportadora.DataSet       := cdsTransportadora;
  frxTransportadora.BCDToCurrency := False;

  frxServicos := TfrxDBDataset.Create(Self);

  frxServicos.UserName        := 'Servicos';
  frxServicos.Enabled         := False;
  frxServicos.CloseDataSource := False;
  frxServicos.OpenDataSource  := False;

  frxServicos.FieldAliases.Clear;
  frxServicos.FieldAliases.Add('ItemListaServico=ItemListaServico');
  frxServicos.FieldAliases.Add('CodigoCnae=CodigoCnae');
  frxServicos.FieldAliases.Add('CodigoNbs=CodigoNbs');
  frxServicos.FieldAliases.Add('CodigoTributacaoMunicipio=CodigoTributacaoMunicipio');
  frxServicos.FieldAliases.Add('Discriminacao=Discriminacao');
  frxServicos.FieldAliases.Add('CodigoMunicipio=CodigoMunicipio');
  frxServicos.FieldAliases.Add('CodigoPais=CodigoPais');
  frxServicos.FieldAliases.Add('xNomePais=xNomePais');
  frxServicos.FieldAliases.Add('xSiglaPais=xSiglaPais');
  frxServicos.FieldAliases.Add('ExigibilidadeISS=ExigibilidadeISS');
  frxServicos.FieldAliases.Add('MunicipioIncidencia=MunicipioIncidencia');
  frxServicos.FieldAliases.Add('NumeroProcesso=NumeroProcesso');
  frxServicos.FieldAliases.Add('xItemListaServico=xItemListaServico');
  frxServicos.FieldAliases.Add('ResponsavelRetencao=ResponsavelRetencao');
  frxServicos.FieldAliases.Add('Descricao=Descricao');
  frxServicos.FieldAliases.Add('ValorServicos=ValorServicos');
  frxServicos.FieldAliases.Add('ValorDeducoes=ValorDeducoes');
  frxServicos.FieldAliases.Add('ValorPis=ValorPis');
  frxServicos.FieldAliases.Add('ValorCofins=ValorCofins');
  frxServicos.FieldAliases.Add('ValorInss=ValorInss');
  frxServicos.FieldAliases.Add('ValorIr=ValorIr');
  frxServicos.FieldAliases.Add('ValorCsll=ValorCsll');
  frxServicos.FieldAliases.Add('IssRetido=IssRetido');
  frxServicos.FieldAliases.Add('ValorIss=ValorIss');
  frxServicos.FieldAliases.Add('OutrasRetencoes=OutrasRetencoes');
  frxServicos.FieldAliases.Add('BaseCalculo=BaseCalculo');
  frxServicos.FieldAliases.Add('Aliquota=Aliquota');
  frxServicos.FieldAliases.Add('ValorLiquidoNfse=ValorLiquidoNfse');
  frxServicos.FieldAliases.Add('ValorIssRetido=ValorIssRetido');
  frxServicos.FieldAliases.Add('DescontoCondicionado=DescontoCondicionado');
  frxServicos.FieldAliases.Add('DescontoIncondicionado=DescontoIncondicionado');
  frxServicos.FieldAliases.Add('TotalNota=TotalNota');
  frxServicos.FieldAliases.Add('Tributacao=Tributacao');
  frxServicos.FieldAliases.Add('OutrosDescontos=OutrosDescontos');
  frxServicos.FieldAliases.Add('DescricaoTotalRetDemo=DescricaoTotalRetDemo');
  frxServicos.FieldAliases.Add('DescriçãoTributosFederais=DescriçãoTributosFederais');
  frxServicos.FieldAliases.Add('ValorTotalNotaFiscal=ValorTotalNotaFiscal');
  // Provedor SP
  frxServicos.FieldAliases.Add('ValorCargaTributaria=ValorCargaTributaria');
  frxServicos.FieldAliases.Add('PercentualCargaTributaria=PercentualCargaTributaria');
  frxServicos.FieldAliases.Add('FonteCargaTributaria=FonteCargaTributaria');

  // Padrao Nacional
  frxServicos.FieldAliases.Add('tribISSQN=tribISSQN');
  frxServicos.FieldAliases.Add('xtpImunidade=xtpImunidade');
  frxServicos.FieldAliases.Add('xtpBM=xtpBM');
  frxServicos.FieldAliases.Add('tpRetISSQN=tpRetISSQN');
  frxServicos.FieldAliases.Add('CST=CST');
  frxServicos.FieldAliases.Add('vBCPisCofins=vBCPisCofins');
  frxServicos.FieldAliases.Add('pAliqPis=pAliqPis');
  frxServicos.FieldAliases.Add('pAliqCofins=pAliqCofins');
  frxServicos.FieldAliases.Add('tpRetPisCofins=tpRetPisCofins');
  frxServicos.FieldAliases.Add('DescRetPisCofins=DescRetPisCofins');
  frxServicos.FieldAliases.Add('pTotTribFed=pTotTribFed');
  frxServicos.FieldAliases.Add('vTotTribFed=vTotTribFed');
  frxServicos.FieldAliases.Add('pTotTribEst=pTotTribEst');
  frxServicos.FieldAliases.Add('vTotTribEst=vTotTribEst');
  frxServicos.FieldAliases.Add('pTotTribMun=pTotTribMun');
  frxServicos.FieldAliases.Add('vTotTribMun=vTotTribMun');

  frxServicos.DataSet       := cdsServicos;
  frxServicos.BCDToCurrency := False;

  frxParametros := TfrxDBDataset.Create(Self);

  frxParametros.UserName        := 'Parametros';
  frxParametros.Enabled         := False;
  frxParametros.CloseDataSource := False;
  frxParametros.OpenDataSource  := False;

  frxParametros.FieldAliases.Clear;
  frxParametros.FieldAliases.Add('ExigibilidadeISS=ExigibilidadeISS');
  frxParametros.FieldAliases.Add('CodigoMunicipio=CodigoMunicipio');
  frxParametros.FieldAliases.Add('MunicipioIncidencia=MunicipioIncidencia');
  frxParametros.FieldAliases.Add('xMunicipioIncidencia=xMunicipioIncidencia');
  frxParametros.FieldAliases.Add('MunicipioPrestacao=MunicipioPrestacao');
  frxParametros.FieldAliases.Add('OutrasInformacoes=OutrasInformacoes');
  frxParametros.FieldAliases.Add('InformacoesComplementares=InformacoesComplementares');
  frxParametros.FieldAliases.Add('CodigoObra=CodigoObra');
  frxParametros.FieldAliases.Add('Art=Art');
  frxParametros.FieldAliases.Add('Imagem=Imagem');
  frxParametros.FieldAliases.Add('LogoExpandido=LogoExpandido');
  frxParametros.FieldAliases.Add('LogoCarregado=LogoCarregado');
  frxParametros.FieldAliases.Add('imgPrefeitura=imgPrefeitura');
  frxParametros.FieldAliases.Add('imgLogoNFSe=imgLogoNFSe');
  frxParametros.FieldAliases.Add('LogoPrefExpandido=LogoPrefExpandido');
  frxParametros.FieldAliases.Add('LogoPrefCarregado=LogoPrefCarregado');
  frxParametros.FieldAliases.Add('LogoNFSe=LogoNFSe');
  frxParametros.FieldAliases.Add('Nome_Prefeitura=Nome_Prefeitura');
  frxParametros.FieldAliases.Add('Mensagem0=Mensagem0');
  frxParametros.FieldAliases.Add('Sistema=Sistema');
  frxParametros.FieldAliases.Add('Usuario=Usuario');
  frxParametros.FieldAliases.Add('Site=Site');
  frxParametros.FieldAliases.Add('IncentivadorCultural=IncentivadorCultural');
  frxParametros.FieldAliases.Add('OptanteSimplesNacional=OptanteSimplesNacional');
  frxParametros.FieldAliases.Add('RegimeEspecialTributacao=RegimeEspecialTributacao');
  frxParametros.FieldAliases.Add('NaturezaOperacao=NaturezaOperacao');
  frxParametros.FieldAliases.Add('TipoRecolhimento=TipoRecolhimento');
  frxParametros.FieldAliases.Add('ValorCredito=ValorCredito');
  frxParametros.FieldAliases.Add('id_sis_legado=id_sis_legado');

  frxParametros.DataSet       := cdsParametros;
  frxParametros.BCDToCurrency := False;

  frxItensServico := TfrxDBDataset.Create(Self);

  frxItensServico.UserName        := 'ItensServico';
  frxItensServico.Enabled         := False;
  frxItensServico.CloseDataSource := False;
  frxItensServico.OpenDataSource  := False;

  frxItensServico.FieldAliases.Clear;
  frxItensServico.FieldAliases.Add('DiscriminacaoServico=DiscriminacaoServico');
  frxItensServico.FieldAliases.Add('Quantidade=Quantidade');
  frxItensServico.FieldAliases.Add('ValorUnitario=ValorUnitario');
  frxItensServico.FieldAliases.Add('ValorTotal=ValorTotal');
  frxItensServico.FieldAliases.Add('Tributavel=Tributavel');
  frxItensServico.FieldAliases.Add('Unidade=Unidade');
  frxItensServico.FieldAliases.Add('Aliquota=Aliquota');
  frxItensServico.FieldAliases.Add('AliquotaISSST=AliquotaISSST');
  frxItensServico.FieldAliases.Add('ValorISSST=ValorISSST');
  frxItensServico.FieldAliases.Add('DescontoIncondicionado=DescontoIncondicionado');

  frxItensServico.DataSet       := cdsItensServico;
  frxItensServico.BCDToCurrency := False;
end;

procedure TACBrNFSeXDANFSeFR.CarregaCondicaoPagamento(ANFSe: TNFSe);
var
  LCDS     : TACBrFRDataSet;
  FProvider: IACBrNFSeXProvider;
begin
  FProvider := TACBrNFSeX(FACBrNFSe).Provider;

  LCDS := cdsCondicaoPagamento;
  LCDS.EmptyDataSet;
  LCDS.Append;
  LCDS.FieldByName('Condicao').AsString :=
    FProvider.CondicaoPagToStr(ANFSe.CondicaoPagamento.Condicao);
  LCDS.FieldByName('Parcela').AsString :=
    IntToStr(ANFSe.CondicaoPagamento.QtdParcela);
  LCDS.Post;
end;

procedure TACBrNFSeXDANFSeFR.CarregaCondicaoPagamentoParcelas(ANFSe: TNFSe);
var
  I        : Integer;
  LCDS     : TACBrFRDataSet;
  FProvider: IACBrNFSeXProvider;
begin
  FProvider := TACBrNFSeX(FACBrNFSe).Provider;

  LCDS := cdsCondicaoPagamentoParcelas;
  LCDS.EmptyDataSet;

  for I := 0 to Pred(ANFSe.CondicaoPagamento.Parcelas.Count) do
  begin
    LCDS.Append;
    LCDS.FieldByName('Condicao').AsString :=
      FProvider.CondicaoPagToStr(ANFSe.CondicaoPagamento.Parcelas[I].Condicao);
    LCDS.FieldByName('Parcela').AsString :=
      ANFSe.CondicaoPagamento.Parcelas[I].Parcela;
    LCDS.FieldByName('DataVencimento').AsString :=
      FormatDateBr(ANFSe.CondicaoPagamento.Parcelas[I].DataVencimento);
    LCDS.FieldByName('Valor').AsFloat :=
      ANFSe.CondicaoPagamento.Parcelas[I].Valor;
    LCDS.Post;
  end;

end;

procedure TACBrNFSeXDANFSeFR.CarregaDados(ANFSe: TNFSe);
begin
  CarregaIdentificacao(ANFSe);
  CarregaPrestador(ANFSe);
  CarregaTomador(ANFSe);
  CarregaItermediario(ANFSe);
  CarregaDestinatario(ANFSe);
  CarregaServicos(ANFSe);
  CarregaItensServico(ANFSe);
  CarregaParametros(ANFSe);
  CarregaTransportadora(ANFSe);
  CarregaCondicaoPagamento(ANFSe);
  CarregaCondicaoPagamentoParcelas(ANFSe);
end;

procedure TACBrNFSeXDANFSeFR.CarregaIdentificacao(ANFSe: TNFSe);
var
  LCDS: TACBrFRDataSet;
begin
  LCDS := cdsIdentificacao;

  LCDS.EmptyDataSet;
  LCDS.Append;

  LCDS.FieldByName('Id').AsString := ANFSe.IdentificacaoRps.Numero +
    ANFSe.IdentificacaoRps.Serie;

  if (FormatarNumeroDocumentoNFSe) then
    LCDS.FieldByName('Numero').AsString :=
      FormatarNumeroDocumentoFiscalNFSe(ANFSe.IdentificacaoRps.Numero)
  else
    LCDS.FieldByName('Numero').AsString := ANFSe.IdentificacaoRps.Numero;

  LCDS.FieldByName('Serie').AsString := ANFSe.IdentificacaoRps.Serie;

  if (Provedor = proISSNet) or (Provedor = proPadraoNacional) then
    LCDS.FieldByName('Competencia').AsString := FormatDateTime('dd/mm/yyyy',
      ANFSe.Competencia)
  else
    LCDS.FieldByName('Competencia').AsString := FormatDateTime('mm/yyyy',
      ANFSe.Competencia);

  if (FormatarNumeroDocumentoNFSe) then
    LCDS.FieldByName('NFSeSubstituida').AsString :=
      FormatarNumeroDocumentoFiscalNFSe(ANFSe.NfseSubstituida)
  else
    LCDS.FieldByName('NFSeSubstituida').AsString := ANFSe.NfseSubstituida;

  if (FormatarNumeroDocumentoNFSe) then
    LCDS.FieldByName('NumeroNFSe').AsString :=
      FormatarNumeroDocumentoFiscalNFSe(ANFSe.Numero)
  else
    LCDS.FieldByName('NumeroNFSe').AsString := ANFSe.Numero;

  if HourOf(ANFSe.DataEmissao) <> 0 then
    LCDS.FieldByName('DataEmissao').AsString :=
      FormatDateTimeBr(ANFSe.DataEmissao)
  else
    LCDS.FieldByName('DataEmissao').AsString := FormatDateBr(ANFSe.DataEmissao);

  if ANFSe.Numero = '' then
  begin
    if frxReport.findcomponent('Memo12') <> nil then
      TfrxMemoView(frxReport.findcomponent('Memo12')).Text := 'Data do RPS';

    LCDS.FieldByName('DataEmissao').AsString :=
      FormatDateBr(ANFSe.DataEmissaoRps);
  end;

  if HourOf(ANFSe.infNFSe.dhProc) <> 0 then
    LCDS.FieldByName('dhProc').AsString := FormatDateTimeBr(ANFSe.infNFSe.dhProc)
  else
    LCDS.FieldByName('dhProc').AsString := FormatDateBr(ANFSe.infNFSe.dhProc);

  LCDS.FieldByName('CodigoVerificacao').AsString := ANFSe.CodigoVerificacao;
  LCDS.FieldByName('LinkNFSe').AsString          := ANFSe.Link;

  if (ANFSe.Producao = TnfseSimNao.snSim) then
  begin
    LCDS.FieldByName('tpAmb').AsString  := '1';
    LCDS.FieldByName('xtpAmb').AsString := 'Produção';
  end
  else
  begin
    LCDS.FieldByName('tpAmb').AsString  := '2';
    LCDS.FieldByName('xtpAmb').AsString := 'Homologação';
  end;

  LCDS.FieldByName('tpEmit').AsString := IntToStr(Ord(ANFSe.tpEmit));
  case ANFSe.tpEmit of
    TtpEmit.tePrestador:
      LCDS.FieldByName('xtpEmit').AsString := 'Prestador do Serviço';
    TtpEmit.teTomador:
      LCDS.FieldByName('xtpEmit').AsString := 'Tomador do Serviço';
    TtpEmit.teIntermediario:
      LCDS.FieldByName('xtpEmit').AsString := 'Intermediário do Serviço';
  end;

  case ANFSe.infNFSe.cStat of
    100:
      LCDS.FieldByName('xsitNFSe').AsString := 'NFS-e autorizada';
    101:
      LCDS.FieldByName('xsitNFSe').AsString := 'NFS-e Subst. autorizada';
    102:
      LCDS.FieldByName('xsitNFSe').AsString := 'NFS-e Des.Jud. ou Adm. autorizada';
    201:
      LCDS.FieldByName('xsitNFSe').AsString := 'NFS-e Cancelada';
  else
    LCDS.FieldByName('xsitNFSe').AsString := '-';
  end;
  LCDS.FieldByName('xsitNFSe').AsString := SuprimeTexto(LCDS.FieldByName('xsitNFSe').AsString, 40);

  case ANFSe.IBSCBS.finNFSe of
    TfinNFSe.fnfsRegular:
      LCDS.FieldByName('xfinNFSe').AsString := 'NFS-e regular';
    TfinNFSe.fnfsCredito:
      LCDS.FieldByName('xfinNFSe').AsString := 'NFS-e crédito';
    TfinNFSe.fnfsDebito:
      LCDS.FieldByName('xfinNFSe').AsString := 'NFS-e débito';
  end;
  LCDS.FieldByName('xfinNFSe').AsString := SuprimeTexto(LCDS.FieldByName('xfinNFSe').AsString, 40);

  case ANFSe.infNFSe.ambGer of
    TambGer.agPrefeitura:
      LCDS.FieldByName('xambGer').AsString := 'Emissor da Prefeitura';
    TambGer.agSistemaNacional:
      LCDS.FieldByName('xambGer').AsString := 'Emissor Nacional da NFS-e';
  end;

  LCDS.Post;
end;

procedure TACBrNFSeXDANFSeFR.CarregaDestinatario(ANFSe: TNFSe);
var
  LCDS         : TACBrFRDataSet;
  LEndereco    : TEnder;
  LContato     : TContato;
  LDestinatario: TDadosdaPessoa;
begin
  LDestinatario := ANFSe.IBSCBS.dest;
  LEndereco     := LDestinatario.ender;

  LCDS := cdsDestinatario;
  LCDS.EmptyDataSet;
  LCDS.Append;

  LCDS.FieldByName('RazaoSocial').AsString := SuprimeTexto(LDestinatario.xNome, 80);

  LCDS.FieldByName('CpfCnpj').AsString            := ManterDocumento(LDestinatario.CNPJCPF);
  LCDS.FieldByName('InscricaoMunicipal').AsString := LDestinatario.IM;
  LCDS.FieldByName('InscricaoEstadual').AsString  := LDestinatario.IE;

  LCDS.FieldByName('Endereco').AsString    := LEndereco.xLgr;
  LCDS.FieldByName('Numero').AsString      := LEndereco.nro;
  LCDS.FieldByName('Complemento').AsString := LEndereco.xCpl;
  LCDS.FieldByName('Bairro').AsString      := LEndereco.xBairro;

  LCDS.FieldByName('Telefone').AsString := FormatarFone(LDestinatario.fone);
  LCDS.FieldByName('Email').AsString    := LDestinatario.email;

  if (ANFSe.IBSCBS.OperExterior = TIndicador.tiSim) then
  begin
    LCDS.FieldByName('CEP').AsString             := LEndereco.endExt.cEndPost;
    LCDS.FieldByName('UF').AsString              := LEndereco.endExt.xEstProvReg;
    LCDS.FieldByName('CodigoMunicipio').AsString := '-';
    LCDS.FieldByName('xMunicipio').AsString      := LEndereco.endExt.xCidade;
    LCDS.FieldByName('CodigoPais').AsString      := IntToStr(LEndereco.endExt.cPais);
  end
  else
  begin
    LCDS.FieldByName('CEP').AsString             := FormatarCEP(LEndereco.endNac.CEP);
    LCDS.FieldByName('UF').AsString              := LEndereco.UF;
    LCDS.FieldByName('CodigoMunicipio').AsString := IntToStr(LEndereco.endNac.cMun);
    LCDS.FieldByName('xMunicipio').AsString      := LEndereco.DescricaoMunicipio;
    LCDS.FieldByName('CodigoPais').AsString      := '-';
  end;

  LCDS.Post;
end;

procedure TACBrNFSeXDANFSeFR.CarregaItensServico(ANFSe: TNFSe);
var
  I            : Integer;
  FProvider    : IACBrNFSeXProvider;
  LCDS         : TACBrFRDataSet;
  LItemsServico: TItemServicoCollection;
begin
  FProvider     := TACBrNFSeX(FACBrNFSe).Provider;
  LItemsServico := ANFSe.Servico.ItemServico;

  LCDS := cdsItensServico;
  LCDS.EmptyDataSet;

  for I := 0 to LItemsServico.Count - 1 do
  begin
    LCDS.Append;
    LCDS.FieldByName('DiscriminacaoServico').AsString :=
      LItemsServico.Items[I].Descricao;
    LCDS.FieldByName('Quantidade').AsString :=
      FloatToStr(LItemsServico.Items[I].Quantidade);
    LCDS.FieldByName('ValorUnitario').AsString :=
      FormatFloatBr(LItemsServico.Items[I].ValorUnitario, ',0.00');
    LCDS.FieldByName('ValorTotal').AsString :=
      FormatFloatBr(LItemsServico.Items[I].ValorTotal, ',0.00');
    LCDS.FieldByName('Tributavel').AsString :=
      FProvider.SimNaoDescricao(LItemsServico.Items[I].Tributavel);
    LCDS.FieldByName('Aliquota').AsString :=
      FormatFloatBr(LItemsServico.Items[I].Aliquota, '0.00');
    LCDS.FieldByName('Unidade').AsString       := LItemsServico.Items[I].Unidade;
    LCDS.FieldByName('AliquotaISSST').AsString :=
      FormatFloatBr(LItemsServico.Items[I].AliqISSST, '0.00');
    LCDS.FieldByName('ValorISSST').AsString :=
      FormatFloatBr(LItemsServico.Items[I].ValorISSST, '0.00');
    LCDS.FieldByName('DescontoIncondicionado').AsString :=
      FormatFloatBr(LItemsServico.Items[I].DescontoIncondicionado, '0.00');
    LCDS.Post;
  end;
end;

procedure TACBrNFSeXDANFSeFR.CarregaItermediario(ANFSe: TNFSe);
var
  LCDS          : TACBrFRDataSet;
  LEndereco     : TEndereco;
  LContato      : TContato;
  LIntermediario: TDadosIntermediario;
begin
  LIntermediario := ANFSe.Intermediario;
  LEndereco      := LIntermediario.Endereco;
  LContato       := LIntermediario.Contato;

  LCDS := cdsIntermediario;
  LCDS.EmptyDataSet;
  LCDS.Append;

  LCDS.FieldByName('RazaoSocial').AsString := LIntermediario.RazaoSocial;
  SuprimeTexto(LCDS.FieldByName('RazaoSocial').AsString, 80);

  LCDS.FieldByName('CpfCnpj').AsString            := ManterDocumento(LIntermediario.Identificacao.CpfCnpj);
  LCDS.FieldByName('InscricaoMunicipal').AsString := LIntermediario.Identificacao.InscricaoMunicipal;
  LCDS.FieldByName('InscricaoEstadual').AsString  := LIntermediario.Identificacao.InscricaoEstadual;

  LCDS.FieldByName('Endereco').AsString        := LEndereco.Endereco;
  LCDS.FieldByName('Numero').AsString          := LEndereco.Numero;
  LCDS.FieldByName('Complemento').AsString     := LEndereco.Complemento;
  LCDS.FieldByName('Bairro').AsString          := LEndereco.Bairro;
  LCDS.FieldByName('CodigoMunicipio').AsString := LEndereco.CodigoMunicipio;
  LCDS.FieldByName('UF').AsString              := LEndereco.UF;
  LCDS.FieldByName('CEP').AsString             := FormatarCEP(LEndereco.CEP);
  LCDS.FieldByName('xMunicipio').AsString      := LEndereco.xMunicipio;
  LCDS.FieldByName('CodigoPais').AsString      := IntToStr(LEndereco.CodigoPais);

  LCDS.FieldByName('Telefone').AsString := FormatarFone(LContato.Telefone);
  LCDS.FieldByName('Email').AsString    := LContato.email;

  LCDS.Post;
end;

procedure TACBrNFSeXDANFSeFR.CarregaParametros(ANFSe: TNFSe);
var
  FProvider                : IACBrNFSeXProvider;
  CodigoIBGE               : Integer;
  LMunicipio, LUF          : string;
  LDadosServico            : TDadosServico;
  LCDS                     : TACBrFRDataSet;
  LRegimeEspecialTributacao: string;
begin
  FProvider := TACBrNFSeX(FACBrNFSe).Provider;
  LCDS      := cdsParametros;

  LCDS.EmptyDataSet;
  LCDS.Append;

  LDadosServico := ANFSe.Servico;

  LCDS.FieldByName('id_sis_legado').AsInteger := ANFSe.id_sis_legado;

  LCDS.FieldByName('OutrasInformacoes').AsString := ANFSe.OutrasInformacoes;
  SuprimeTexto(LCDS.FieldByName('OutrasInformacoes').AsString, 2000);

  LCDS.FieldByName('NaturezaOperacao').AsString :=
    FProvider.NaturezaOperacaoDescricao(ANFSe.NaturezaOperacao);
  LCDS.FieldByName('RegimeEspecialTributacao').AsString :=
    FProvider.RegimeEspecialTributacaoDescricao(ANFSe.RegimeEspecialTributacao);
  case ANFSe.OptanteSN of
    osnNaoOptante:
      LCDS.FieldByName('OptanteSimplesNacional').AsString := 'Não Optante';
    osnOptanteMEI:
      LCDS.FieldByName('OptanteSimplesNacional').AsString := 'Optante - Microempreendedor Individual (MEI)';
  else
    LCDS.FieldByName('OptanteSimplesNacional').AsString := 'Optante - MicroEmpresa EPP';
  end;
  SuprimeTexto(LCDS.FieldByName('OptanteSimplesNacional').AsString, 40);

  LCDS.FieldByName('IncentivadorCultural').AsString :=
    FProvider.SimNaoDescricao(ANFSe.IncentivadorCultural);
  LCDS.FieldByName('CodigoMunicipio').AsString :=
    IntToStr(LDadosServico.MunicipioIncidencia);
  LCDS.FieldByName('ExigibilidadeISS').AsString :=
    FProvider.ExigibilidadeISSDescricao(LDadosServico.ExigibilidadeISS);

  SuprimeTexto(LCDS.FieldByName('ExigibilidadeISS').AsString, 40);

  if (Trim(LDadosServico.xMunicipioIncidencia) <> '') then
    LCDS.FieldByName('xMunicipioIncidencia').AsString := LDadosServico.xMunicipioIncidencia
  else
    LCDS.FieldByName('xMunicipioIncidencia').AsString := 'Nenhum';

  LCDS.FieldByName('TipoRecolhimento').AsString := ANFSe.TipoRecolhimento;
  LCDS.FieldByName('MunicipioPrestacao').AsString :=
    LDadosServico.MunicipioPrestacaoServico;
  LCDS.FieldByName('CodigoObra').AsString := ANFSe.ConstrucaoCivil.CodigoObra;
  LCDS.FieldByName('Art').AsString        := ANFSe.ConstrucaoCivil.Art;

  LCDS.FieldByName('InformacoesComplementares').AsString :=
    ANFSe.InformacoesComplementares;
  LCDS.FieldByName('ValorCredito').AsCurrency := ANFSe.ValorCredito;

  CarregaLogoPrefeitura;
  CarregaLogoPadraoNacional;
  CarregaImagemPrestadora;

  LCDS.FieldByName('Sistema').AsString := IfThen(DANFSeXClassOwner.Sistema <>
    '', DANFSeXClassOwner.Sistema, 'Projeto ACBr - http://acbr.sf.net');
  LCDS.FieldByName('Usuario').AsString := DANFSeXClassOwner.Usuario;
  LCDS.FieldByName('Site').AsString    := DANFSeXClassOwner.Site;

  if FDANFSeXClassOwner.Cancelada
    or (ANFSe.NfseCancelamento.DataHora <> 0)
    or (ANFSe.SituacaoNfse = TStatusNFSe.snCancelado)
    or (ANFSe.StatusRps = TStatusRps.srCancelado) then
  begin
    LCDS.FieldByName('Mensagem0').AsString := 'CANCELADA';
  end;

  if (ANFSe.NfseSubstituidora <> '')
    or (ANFSe.SituacaoNfse = TStatusNFSe.snSubstituido) then
  begin
    LCDS.FieldByName('Mensagem0').AsString := 'SUBSTITUÍDA';
  end;

  LCDS.Post;
end;

procedure TACBrNFSeXDANFSeFR.CarregaPrestador(ANFSe: TNFSe);
var
  LCDS             : TACBrFRDataSet;
  LPrestador       : TDadosPrestador;
  LConfiguracaoNFSE: TGeralConfNFSe;
begin
  LCDS := cdsPrestador;

  LCDS.EmptyDataSet;
  LCDS.Append;

  LPrestador := ANFSe.Prestador;

  LCDS.FieldByName('RazaoSocial').AsString := LPrestador.RazaoSocial;
  SuprimeTexto(LCDS.FieldByName('RazaoSocial').AsString, 80);

  LCDS.FieldByName('NomeFantasia').AsString := LPrestador.NomeFantasia;

  LCDS.FieldByName('Cnpj').AsString :=
    FormatarCNPJ(LPrestador.IdentificacaoPrestador.Cnpj);
  LCDS.FieldByName('InscricaoMunicipal').AsString :=
    LPrestador.IdentificacaoPrestador.InscricaoMunicipal;
  LCDS.FieldByName('InscricaoEstadual').AsString :=
    FormatarIE(LPrestador.IdentificacaoPrestador.InscricaoEstadual,
    LPrestador.Endereco.UF);

  LCDS.FieldByName('Endereco').AsString        := LPrestador.Endereco.Endereco;
  LCDS.FieldByName('Numero').AsString          := LPrestador.Endereco.Numero;
  LCDS.FieldByName('Complemento').AsString     := LPrestador.Endereco.Complemento;
  LCDS.FieldByName('Bairro').AsString          := LPrestador.Endereco.Bairro;
  LCDS.FieldByName('CodigoMunicipio').AsString :=
    LPrestador.Endereco.CodigoMunicipio;
  LCDS.FieldByName('UF').AsString         := LPrestador.Endereco.UF;
  LCDS.FieldByName('CEP').AsString        := FormatarCEP(LPrestador.Endereco.CEP);
  LCDS.FieldByName('xMunicipio').AsString := LPrestador.Endereco.xMunicipio;
  LCDS.FieldByName('CodigoPais').AsString :=
    IntToStr(LPrestador.Endereco.CodigoPais);

  LCDS.FieldByName('Telefone').AsString :=
    FormatarFone(LPrestador.Contato.Telefone);
  LCDS.FieldByName('Email').AsString := LPrestador.Contato.email;

  LConfiguracaoNFSE :=
    TACBrNFSeX(DANFSeXClassOwner.ACBrNFSe).Configuracoes.Geral;

  if ANFSe.OptanteSN = osnOptanteMEEPP then
  begin
    case ANFSe.RegimeApuracaoSN of
      raFederaisMunicipalpeloSN:
        LCDS.FieldByName('RegimeApuracao').AsString := 'Federais e Municipal pelo SN';
      raFederaisSN:
        LCDS.FieldByName('RegimeApuracao').AsString := 'Federais pelo SN';
    else
      LCDS.FieldByName('RegimeApuracao').AsString := 'Federais e Municipal fora SN';
    end;
  end
  else
    LCDS.FieldByName('RegimeApuracao').AsString := '-';

  SuprimeTexto(LCDS.FieldByName('RegimeApuracao').AsString, 80);

  LCDS.Post;

end;

procedure TACBrNFSeXDANFSeFR.CarregaServicos(ANFSe: TNFSe);
var
  FProvider   : IACBrNFSeXProvider;
  LCDS        : TACBrFRDataSet;
  LServico    : TDadosServico;
  LValores    : TValores;
  LValoresNFSe: TValoresNfse;
begin
  FProvider := TACBrNFSeX(FACBrNFSe).Provider;

  LServico     := ANFSe.Servico;
  LValores     := LServico.Valores;
  LValoresNFSe := ANFSe.ValoresNfse;

  LCDS := cdsServicos;

  LCDS.EmptyDataSet;
  LCDS.Append;

  if LServico.ItemServico.Count > 0 then
  begin
    LCDS.FieldByName('ItemListaServico').AsString :=
      LServico.ItemServico.Items[0].ItemListaServico;
    LCDS.FieldByName('xItemListaServico').AsString :=
      LServico.ItemServico.Items[0].xItemListaServico;
  end;

  if LCDS.FieldByName('xItemListaServico').AsString = '' then
  begin
    LCDS.FieldByName('ItemListaServico').AsString  := LServico.ItemListaServico;
    LCDS.FieldByName('xItemListaServico').AsString :=
      LServico.xItemListaServico;
  end;

  SuprimeTexto(LCDS.FieldByName('xItemListaServico').AsString, 170);

  LCDS.FieldByName('CodigoCnae').AsString                := LServico.CodigoCnae;
  LCDS.FieldByName('CodigoNbs').AsString                 := LServico.CodigoNBS;
  LCDS.FieldByName('CodigoTributacaoMunicipio').AsString :=
    LServico.CodigoTributacaoMunicipio;
  LCDS.FieldByName('Discriminacao').AsString :=
    StringReplace(LServico.Discriminacao,
    TACBrNFSeX(DANFSeXClassOwner.ACBrNFSe).Provider.ConfigGeral.QuebradeLinha,
    #13,
    [rfReplaceAll, rfIgnoreCase]);

  SuprimeTexto(LCDS.FieldByName('Discriminacao').AsString, 1300);

  LCDS.FieldByName('CodigoPais').AsString := IntToStr(ANFSe.Servico.CodigoPais);
  LCDS.FieldByName('xNomePais').AsString  := CodIBGEPaisToDescricao(ANFSe.Servico.CodigoPais);
  LCDS.FieldByName('xSiglaPais').AsString := CodIBGEPaisToSiglaISO2(ANFSe.Servico.CodigoPais);


  if (LCDS.FieldByName('xNomePais').AsString = '') then
    LCDS.FieldByName('xNomePais').AsString    := '-';
  LCDS.FieldByName('NumeroProcesso').AsString := LServico.NumeroProcesso;

  case LServico.Valores.tribMun.tpBM of
    TtpBM.tbIsencao:
      LCDS.FieldByName('xtpBM').AsString := 'Isenção';
    TtpBM.tbReducaoBCperc:
      LCDS.FieldByName('xtpBM').AsString := 'Redução da Base de Cálculo (em porcentagem)';
    TtpBM.tbReducaoBCvalor:
      LCDS.FieldByName('xtpBM').AsString := 'Redução da Base de Cálculo (em valor)';
    TtpBM.tbAliquota:
      LCDS.FieldByName('xtpBM').AsString := 'Alíquota Diferenciada';
    TtpBM.tbNenhum:
      LCDS.FieldByName('xtpBM').AsString := '-';
  end;
  SuprimeTexto(LCDS.FieldByName('xtpBM').AsString, 40);

  LCDS.FieldByName('Descricao').AsString           := LServico.Descricao;
  LCDS.FieldByName('ResponsavelRetencao').AsString :=
    FProvider.ResponsavelRetencaoToStr(LServico.ResponsavelRetencao);
  LCDS.FieldByName('Tributacao').AsString :=
    FProvider.TributacaoToStr(LServico.Tributacao);

  LCDS.FieldByName('ValorServicos').AsFloat := LValores.ValorServicos;
  LCDS.FieldByName('ValorDeducoes').AsFloat := LValores.ValorDeducoes;
  LCDS.FieldByName('ValorPis').AsFloat      := LValores.ValorPis;
  LCDS.FieldByName('ValorCofins').AsFloat   := LValores.ValorCofins;
  LCDS.FieldByName('ValorInss').AsFloat     := LValores.ValorInss;
  LCDS.FieldByName('ValorIr').AsFloat       := LValores.ValorIr;
  LCDS.FieldByName('ValorCsll').AsFloat     := LValores.ValorCsll;
  LCDS.FieldByName('IssRetido').AsString    :=
    FProvider.SituacaoTributariaDescricao(LValores.IssRetido);
  LCDS.FieldByName('ValorIss').AsFloat             := LValores.ValorIss;
  LCDS.FieldByName('OutrasRetencoes').AsFloat      := LValores.OutrasRetencoes;
  LCDS.FieldByName('BaseCalculo').AsFloat          := LValores.BaseCalculo;
  LCDS.FieldByName('Aliquota').AsFloat             := LValores.Aliquota;
  LCDS.FieldByName('ValorLiquidoNfse').AsFloat     := LValores.ValorLiquidoNfse;
  LCDS.FieldByName('ValorIssRetido').AsFloat       := LValores.ValorIssRetido;
  LCDS.FieldByName('DescontoCondicionado').AsFloat :=
    LValores.DescontoCondicionado;
  LCDS.FieldByName('DescontoIncondicionado').AsFloat :=
    LValores.DescontoIncondicionado;
  LCDS.FieldByName('OutrosDescontos').AsCurrency      := LValores.OutrosDescontos;
  LCDS.FieldByName('ValorTotalNotaFiscal').AsCurrency :=
    LValores.ValorTotalNotaFiscal;

  if LValores.IssRetido = stRetencao then
  begin
    LCDS.FieldByName('DescricaoTotalRetDemo').AsString     := 'TOTAL RETENÇÕES';
    LCDS.FieldByName('DescriçãoTributosFederais').AsString :=
      'RETENÇÕES DOS TRIBUTOS FEDERAIS';
  end
  else
  begin
    LCDS.FieldByName('DescricaoTotalRetDemo').AsString     := 'TOTAL DEMONSTRATIVO';
    LCDS.FieldByName('DescriçãoTributosFederais').AsString :=
      'DEMONSTRATIVO DOS TRIBUTOS FEDERAIS';
  end;

  LCDS.FieldByName('ValorCargaTributaria').AsCurrency :=
    LServico.ValorCargaTributaria;
  LCDS.FieldByName('PercentualCargaTributaria').AsCurrency :=
    LServico.PercentualCargaTributaria;
  LCDS.FieldByName('FonteCargaTributaria').AsString :=
    LServico.FonteCargaTributaria;

  if LValoresNFSe.ValorIss > 0 then
  begin
    LCDS.FieldByName('ValorServicos').AsFloat := LValores.ValorServicos;
    LCDS.FieldByName('ValorIss').AsFloat      := LValoresNFSe.ValorIss;
    LCDS.FieldByName('BaseCalculo').AsFloat   := LValoresNFSe.BaseCalculo;
    if LValoresNFSe.Aliquota <> 0 then
      LCDS.FieldByName('Aliquota').AsFloat := LValoresNFSe.Aliquota;

    if (LValoresNFSe.ValorLiquidoNfse = 0) and (LValores.ValorLiquidoNfse = 0)
    then
      LValoresNFSe.ValorLiquidoNfse := LValoresNFSe.BaseCalculo
    else if (LValoresNFSe.ValorLiquidoNfse = 0) and (LValores.ValorLiquidoNfse >
      0) then
      LValoresNFSe.ValorLiquidoNfse := LValores.ValorLiquidoNfse;

    LCDS.FieldByName('ValorLiquidoNfse').AsFloat :=
      LValoresNFSe.ValorLiquidoNfse;
  end;

  LCDS.FieldByName('ExigibilidadeISS').AsString :=
    FProvider.ExigibilidadeISSDescricao(LServico.ExigibilidadeISS);
  SuprimeTexto(LCDS.FieldByName('ExigibilidadeISS').AsString, 40);

  LCDS.FieldByName('xtpImunidade').AsString := '-';
  case ANFSe.Servico.Valores.tribMun.tribISSQN of
    tiOperacaoTributavel:
      LCDS.FieldByName('tribISSQN').AsString := 'Operação Tributável';
    tiImunidade:
      begin
        LCDS.FieldByName('tribISSQN').AsString := 'Imunidade';
        case ANFSe.Servico.Valores.tribMun.tpImunidade of
          TtpImunidade.timPatrimonio:
            LCDS.FieldByName('xtpImunidade').AsString := 'Patrimônio, renda ou serviços, uns dos outros (CF/88, art. 150, VI, a)';
          TtpImunidade.timTemplos:
            LCDS.FieldByName('xtpImunidade').AsString := 'Templos de qualquer culto (CF/88, art. 150, VI, b)';
          TtpImunidade.timPatrimonioPartidos:
            LCDS.FieldByName('xtpImunidade').AsString := 'Partidos políticos, entidades sindicais, instituições de educação e '
              + 'assistência social sem fins lucrativos (CF/88, art. 150, VI, c';
          TtpImunidade.timLivros:
            LCDS.FieldByName('xtpImunidade').AsString := 'Livros, jornais, periódicos e o papel destinado à sua '
              + 'impressão (CF/88, art. 150, VI, d)';
          TtpImunidade.timFonogramas:
            LCDS.FieldByName('xtpImunidade').AsString := 'Fonogramas e videofonogramas musicais produzidos no Brasil '
              + '(CF/88, art. 150, VI, e)';
        end;
      end;
    tiExportacao:
      LCDS.FieldByName('tribISSQN').AsString := 'Exportação';
  else
    LCDS.FieldByName('tribISSQN').AsString := 'Não Incidência';
  end;

  SuprimeTexto(LCDS.FieldByName('xtpImunidade').AsString, 40);

  case LValores.tribMun.tpRetISSQN of
    TtpRetISSQN.trNaoRetido:
      LCDS.FieldByName('tpRetISSQN').AsString := 'Não Retido';
    TtpRetISSQN.trRetidoPeloTomador:
      LCDS.FieldByName('tpRetISSQN').AsString := 'Retido pelo Tomador';
    TtpRetISSQN.trRetidoPeloIntermediario:
      LCDS.FieldByName('tpRetISSQN').AsString := 'Retido pelo Intermediário';
  else
    LCDS.FieldByName('tpRetISSQN').AsString := '-';
  end;

  LCDS.FieldByName('CST').AsString            := CSTToStr(LValores.tribFed.CST);
  LCDS.FieldByName('vBCPisCofins').AsCurrency := LValores.tribFed.vBCPisCofins;
  LCDS.FieldByName('pAliqPis').AsCurrency     := LValores.tribFed.pAliqPis;
  LCDS.FieldByName('pAliqCofins').AsCurrency  := LValores.tribFed.pAliqCofins;
  LCDS.FieldByName('tpRetPisCofins').AsString :=
    tpRetPisCofinsToStr(LValores.tribFed.tpRetPisCofins);
  LCDS.FieldByName('DescRetPisCofins').AsString :=
    tpRetPisCofinsDescricao(LValores.tribFed.tpRetPisCofins);
  LCDS.FieldByName('pTotTribFed').AsCurrency := LValores.totTrib.pTotTribFed;
  LCDS.FieldByName('vTotTribFed').AsCurrency := LValores.totTrib.vTotTribFed;
  LCDS.FieldByName('pTotTribEst').AsCurrency := LValores.totTrib.pTotTribEst;
  LCDS.FieldByName('vTotTribEst').AsCurrency := LValores.totTrib.vTotTribEst;
  LCDS.FieldByName('pTotTribMun').AsCurrency := LValores.totTrib.pTotTribMun;
  LCDS.FieldByName('vTotTribMun').AsCurrency := LValores.totTrib.vTotTribMun;

  LCDS.Post;
end;

procedure TACBrNFSeXDANFSeFR.CarregaTomador(ANFSe: TNFSe);
var
  LCDS     : TACBrFRDataSet;
  LTomador : TDadosTomador;
  LEndereco: TEndereco;
  LContato : TContato;
begin

  LTomador  := ANFSe.Tomador;
  LEndereco := LTomador.Endereco;
  LContato  := LTomador.Contato;

  LCDS := cdsTomador;
  LCDS.EmptyDataSet;
  LCDS.Append;

  LCDS.FieldByName('RazaoSocial').AsString := LTomador.RazaoSocial;
  SuprimeTexto(LCDS.FieldByName('RazaoSocial').AsString, 80);

  LCDS.FieldByName('CpfCnpj').AsString :=
    ManterDocumento(LTomador.IdentificacaoTomador.CpfCnpj);
  LCDS.FieldByName('InscricaoMunicipal').AsString :=
    LTomador.IdentificacaoTomador.InscricaoMunicipal;
  LCDS.FieldByName('InscricaoEstadual').AsString :=
    LTomador.IdentificacaoTomador.InscricaoEstadual;

  LCDS.FieldByName('Endereco').AsString        := LEndereco.Endereco;
  LCDS.FieldByName('Numero').AsString          := LEndereco.Numero;
  LCDS.FieldByName('Complemento').AsString     := LEndereco.Complemento;
  LCDS.FieldByName('Bairro').AsString          := LEndereco.Bairro;
  LCDS.FieldByName('CodigoMunicipio').AsString := LEndereco.CodigoMunicipio;
  LCDS.FieldByName('UF').AsString              := LEndereco.UF;
  LCDS.FieldByName('CEP').AsString             := FormatarCEP(LEndereco.CEP);
  LCDS.FieldByName('xMunicipio').AsString      := LEndereco.xMunicipio;
  LCDS.FieldByName('CodigoPais').AsString      := IntToStr(LEndereco.CodigoPais);

  LCDS.FieldByName('Telefone').AsString := FormatarFone(LContato.Telefone);
  LCDS.FieldByName('Email').AsString    := LContato.email;

  LCDS.Post;

end;

procedure TACBrNFSeXDANFSeFR.CarregaTransportadora(ANFSe: TNFSe);
var
  LCDS           : TACBrFRDataSet;
  LTransportadora: TDadosTransportadora;
begin
  LCDS            := cdsTransportadora;
  LTransportadora := ANFSe.Transportadora;

  LCDS.EmptyDataSet;
  LCDS.Append;

  LCDS.FieldByName('Cnpj').AsString        := LTransportadora.xCpfCnpjTrans;
  LCDS.FieldByName('RazaoSocial').AsString := LTransportadora.xNomeTrans;
  SuprimeTexto(LCDS.FieldByName('RazaoSocial').AsString, 80);

  LCDS.FieldByName('InscicaoEstadual').AsString :=
    LTransportadora.xInscEstTrans;
  LCDS.FieldByName('Placa').AsString            := LTransportadora.xPlacaTrans;
  LCDS.FieldByName('Endereco').AsString         := LTransportadora.xEndTrans;
  LCDS.FieldByName('CodigoMunicipio').AsInteger := LTransportadora.cMunTrans;
  LCDS.FieldByName('NomeMunicipio').AsString    := LTransportadora.xMunTrans;
  LCDS.FieldByName('Sigla').AsString            := LTransportadora.xUFTrans;
  LCDS.FieldByName('NomePais').AsString         := LTransportadora.xPaisTrans;
  LCDS.FieldByName('BacenPais').AsInteger       := LTransportadora.cPaisTrans;
  LCDS.FieldByName('TipoFrete').AsInteger       :=
    Ord(LTransportadora.vTipoFreteTrans);

  LCDS.Post;
end;

procedure TACBrNFSeXDANFSeFR.CarregaLogoPadraoNacional;
var
  LStream      : TMemoryStream;
  LStringStream: TStringStream;
begin
  if NaoEstaVazio(DANFSeXClassOwner.LogoNFSe) then
  begin
    cdsParametros.FieldByName('imgLogoNFSe').AsString := LogoNFSe;
    LStream                                           := TMemoryStream.Create;
    try
      if FileExists(LogoNFSe) then
        LStream.LoadFromFile(LogoNFSe)
      else
      begin
        LStringStream := TStringStream.Create(LogoNFSe);
        try
          LStream.LoadFromStream(LStringStream);
        finally
          LStringStream.Free;
        end;
      end;
      LStream.Position := 0;
      TBlobField(cdsParametros.FieldByName('LogoNFSe')).LoadFromStream(LStream);
    finally
      LStream.Free;
    end;
  end;
end;

procedure TACBrNFSeXDANFSeFR.CarregaLogoPrefeitura;
var
  vStream      : TMemoryStream;
  vStringStream: TStringStream;
begin
  cdsParametros.FieldByName('LogoPrefExpandido').AsString :=
    IfThen(ExpandeLogoMarca, '0', '1');
  cdsParametros.FieldByName('Nome_Prefeitura').AsString := Prefeitura;
  if NaoEstaVazio(DANFSeXClassOwner.Logo) then
  begin
    cdsParametros.FieldByName('imgPrefeitura').AsString := Logo;
    vStream                                             := TMemoryStream.Create;
    try
      if FileExists(Logo) then
        vStream.LoadFromFile(Logo)
      else
      begin
        vStringStream := TStringStream.Create(Logo);
        try
          vStream.LoadFromStream(vStringStream);
        finally
          vStringStream.Free;
        end;
      end;
      vStream.Position := 0;
      TBlobField(cdsParametros.FieldByName('LogoPrefCarregado')).LoadFromStream(vStream);
    finally
      vStream.Free;
    end;
  end;
end;

procedure TACBrNFSeXDANFSeFR.CarregaImagemPrestadora;
var
  vStream      : TMemoryStream;
  vStringStream: TStringStream;
begin
  cdsParametros.FieldByName('LogoExpandido').AsString := IfThen(ExpandeLogoMarca,
    '0', '1'); // Prestador

  if NaoEstaVazio(Prestador.Logo) then
  begin
    cdsParametros.FieldByName('Imagem').AsString := Prestador.Logo;

    vStream := TMemoryStream.Create;
    try
      if FileExists(Prestador.Logo) then
        vStream.LoadFromFile(Prestador.Logo)
      else
      begin
        vStringStream := TStringStream.Create(Prestador.Logo);
        try
          vStream.LoadFromStream(vStringStream);
        finally
          vStringStream.Free;
        end;
      end;
      vStream.Position := 0;
      TBlobField(cdsParametros.FieldByName('LogoCarregado')).LoadFromStream(vStream);
    finally
      vStream.Free;
    end;
  end;
end;

function TACBrNFSeXDANFSeFR.ManterDocumento(const sCpfCnpj: string): string;
begin
  Result := sCpfCnpj;
  if NaoEstaVazio(Result) then
  begin
    if length(Result) > 11 then
      Result := FormatarCNPJ(Result)
    else
      Result := FormatarCPF(Result);
  end;
end;

procedure TACBrNFSeXDANFSeFR.frxReportBeforePrint(Sender: TfrxReportComponent);
var
  LQrCode, LOutrasInformacoes: string;
  LOutrasInformacoesLength   : Integer;
  LDiscriminacao, LNomeArqFr3: string;
  LNFSe                      : TNFSe;
begin
  if Provedor <> proEL then
  begin

    if frxReport.FindObject('Memo23') <> nil then
      frxReport.FindObject('Memo23').Visible :=
        DANFSeXClassOwner.ImprimeCanhoto;
    if frxReport.FindObject('Memo75') <> nil then
      frxReport.FindObject('Memo75').Visible :=
        DANFSeXClassOwner.ImprimeCanhoto;
    if frxReport.FindObject('Memo77') <> nil then
      frxReport.FindObject('Memo77').Visible :=
        DANFSeXClassOwner.ImprimeCanhoto;
    if frxReport.FindObject('Memo68') <> nil then
      frxReport.FindObject('Memo68').Visible :=
        DANFSeXClassOwner.ImprimeCanhoto;
    if frxReport.FindObject('Memo73') <> nil then
      frxReport.FindObject('Memo73').Visible :=
        DANFSeXClassOwner.ImprimeCanhoto;
    if frxReport.FindObject('mHomologacao') <> nil then
      frxReport.FindObject('mHomologacao').Visible :=
        ACBrNFSe.Configuracoes.WebServices.AmbienteCodigo = 2;
    if frxReport.FindObject('FilhaCanhoto') <> nil then
      frxReport.FindObject('FilhaCanhoto').Visible :=
        DANFSeXClassOwner.ImprimeCanhoto;
  end;

  if frxReport.FindObject('Memo13') <> nil then
    frxReport.FindObject('Memo13').Visible := (not((cdsItensServico.RecordCount
      > 0) and (frxReport.FindObject('Page2') <> nil)) or
      (frxReport.FindObject('Page2') = nil));

  LOutrasInformacoes :=
    LowerCase(cdsParametros.FieldByName('outrasinformacoes').Value);
  LOutrasInformacoesLength := length(LOutrasInformacoes);

  LQrCode := cdsIdentificacao.FieldByName('LinkNFSe').Value;

  if Assigned(Sender) and (Sender.Name = 'imgQrCode') then
  begin
    TfrxPictureView(Sender).Visible := not(LQrCode = '');
    if (LQrCode <> '') then
      PintarQRCode(LQrCode, TfrxPictureView(Sender).Picture.Bitmap, qrAuto);
  end;

  if (frxReport.FindObject('FilhaSemIntermediario') <> nil) and
    (frxReport.FindObject('FilhaComIntermediario') <> nil) then
  begin
    frxReport.FindObject('FilhaSemIntermediario').Visible := (Trim(cdsIntermediario.FieldByName('CpfCnpj').AsString) = '');
    frxReport.FindObject('FilhaComIntermediario').Visible := not frxReport.FindObject('FilhaSemIntermediario').Visible;
  end;

  LNFSe := ACBrNFSe.NotasFiscais.Items[0].NFSe;
  if (frxReport.FindObject('FilhaDestinarioTomador') <> nil) and
    (frxReport.FindObject('FilhaSemDestinatario') <> nil) and
    (frxReport.FindObject('FilhaComDestinatario') <> nil) then
  begin
    frxReport.FindObject('FilhaDestinarioTomador').Visible := False;
    frxReport.FindObject('FilhaComDestinatario').Visible   := False;
    frxReport.FindObject('FilhaSemDestinatario').Visible   := False;

    if (LNFSe.IBSCBS.indDest = TindDest.idTomadorAdquirenteDestinatarioIguais) then
      frxReport.FindObject('FilhaDestinarioTomador').Visible := True
    else if (LNFSe.IBSCBS.indDest <> TindDest.idTomadorAdquirenteDestinatarioIguais)
      and (LNFSe.IBSCBS.dest.CNPJCPF = '') then
      frxReport.FindObject('FilhaSemDestinatario').Visible := True
    else
      frxReport.FindObject('FilhaComDestinatario').Visible := True;
  end;
end;


function TACBrNFSeXDANFSeFR.SuprimeTexto(const ATexto: String; const ATamMax: Integer): String;
var
  tamSuprimido: Integer;
begin
  Result := ATexto;

  if (Provedor = proPadraoNacional) then
  begin
    if(Length(ATexto) > ATamMax) then
    begin
      tamSuprimido := Length(ATexto) - 3;
      Result := Copy(ATexto, 1, tamSuprimido) +'...';
    end;
  end;
end;

end.
