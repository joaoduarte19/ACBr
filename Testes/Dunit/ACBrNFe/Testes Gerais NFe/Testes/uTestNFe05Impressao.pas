unit uTestNFe05Impressao;

{ Impressão do DANFE sem impressora física:
   - NF-e  : TACBrNFeDANFeFPDF  (PDF em arquivo e em stream, resumido, evento, inutilização)
   - NFC-e : TACBrNFCeDANFeFPDF (PDF) e TACBrNFeDANFeESCPOS (ESC/POS gravado em arquivo)
  Os métodos que enviam para impressora (Imprimir, ImprimirResumido...) são
  exercitados via ESC/POS em arquivo; os de impressora do Windows ficam
  [Ignore] para não imprimir durante a execução automatizada. }

interface

uses
  DUnitX.TestFramework, SysUtils, Classes, ACBrNFe, uSefazMock;

type
  [TestFixture]
  TTestNFeImpressao = class
  private
    FNFe: TACBrNFe;
    FMock: TSefazMock;
    FDANFE: TComponent;
    FPos: TComponent;
    procedure CriarNFeComDANFEFPDF(const ACenario: string);
    procedure AssertPDF(const AArquivo: string);
    procedure AssertPDFStream(AStream: TStream);
    procedure AssertPDFEvento(const ATpEvento: string);
  public
    [Setup]    procedure Setup;
    [TearDown] procedure TearDown;

    [Test]
    [TestCase('55 RTC interna',          '55_RTC_INT_NCF')]
    [TestCase('55 sem RTC IES DIFAL',    '55_SemRTC_IES_CF_ENT_RET')]
    [TestCase('55 RTC exportacao',       '55_RTC_EXT_NCF')]
    procedure NFe_ImprimirPDF_Arquivo(const ACenario: string);

    [Test] procedure NFe_ImprimirPDF_Stream;
    [Test] procedure NFe_NotaFiscal_ImprimirPDF_Stream;
    [Test] procedure NFe_ImprimirResumidoPDF_FPDFNaoImplementa;
    [Test] procedure NFe_ImprimirPDF_NfeProcAutorizado;
    [Test] procedure NFe_ImprimirPDF_XMLAnexadoCorreto;
    [Test] procedure NFe_ImprimirEventoPDF_Cancelamento;
    [Test] procedure NFe_ImprimirEventoPDF_CCe;
    [Test] procedure NFe_ImprimirInutilizacaoPDF_FPDFNaoImplementa;
    [Test] procedure NFCe_ImprimirPDF_FPDF;
    [Test] procedure NFCe_ESCPOS_Imprimir_EmArquivo;
    [Test] procedure NFCe_ESCPOS_ImprimirResumido_EmArquivo;
    [Test] procedure NFCe_ESCPOS_ImprimirCancelado_EmArquivo;

    [Test]
    [Ignore('Envia para a impressora padrão do Windows - executar manualmente')]
    procedure NFe_Imprimir_ImpressoraWindows;
  end;

implementation

uses
  ACBrNFeNotasFiscais, ACBrNFe.Classes, ACBrNFe.Conversao, ACBrDFe.Conversao,
  ACBrNFeDANFeFPDF, ACBrNFCeDANFeFPDF, ACBrNFeDANFeESCPOS, ACBrPosPrinter,
  ACBrNFe.EventoClass,
  uNFeTesteBase, uXmlTesteHelpers;

procedure TTestNFeImpressao.Setup;
begin
  FMock := TSefazMock.Create;
  FNFe := nil;
  FDANFE := nil;
  FPos := nil;
end;

procedure TTestNFeImpressao.TearDown;
begin
  if Assigned(FNFe) then
    FNFe.DANFE := nil;
  FreeAndNil(FDANFE);
  FreeAndNil(FPos);
  FreeAndNil(FNFe);
  FreeAndNil(FMock);
end;

procedure TTestNFeImpressao.CriarNFeComDANFEFPDF(const ACenario: string);
var
  C: TCenarioNFe;
  D: TACBrNFeDANFeFPDF;
begin
  C := CenarioPorCodigo(ACenario);
  FNFe := CriarACBrNFe(C.Modelo, FMock, 'impressao\' + ACenario);
  D := TACBrNFeDANFeFPDF.Create(nil);
  D.PathPDF := PastaSaidaTeste('impressao\' + ACenario + '\pdf');
  D.MostraPreview := False;
  D.MostraStatus := False;
  FDANFE := D;
  FNFe.DANFE := D;
  PreencherNFe(FNFe, C);
end;

procedure TTestNFeImpressao.AssertPDF(const AArquivo: string);
var
  B: RawByteString;
begin
  Assert.IsTrue(FileExists(AArquivo), 'PDF não gerado: ' + AArquivo);
  B := LerArquivoBytes(AArquivo);
  LogLinha(Format('  PDF %s (%d bytes)', [ExtractFileName(AArquivo), Length(B)]));
  Assert.AreEqual(AnsiString('%PDF'), AnsiString(Copy(B, 1, 4)), 'Assinatura %PDF');
  Assert.IsTrue(Length(B) > 1024, 'PDF muito pequeno');
  Assert.IsTrue(Pos(AnsiString('%%EOF'), B) > 0, 'PDF sem %%EOF');
end;

procedure TTestNFeImpressao.AssertPDFStream(AStream: TStream);
var
  B: RawByteString;
begin
  Assert.IsTrue(AStream.Size > 1024, 'Stream PDF vazio/pequeno');
  SetLength(B, 4);
  AStream.Position := 0;
  AStream.ReadBuffer(B[1], 4);
  Assert.AreEqual(AnsiString('%PDF'), AnsiString(B));
end;

procedure TTestNFeImpressao.AssertPDFEvento(const ATpEvento: string);
var
  SR: TSearchRec;
  Pasta, Arq: string;
begin
  { ACHADO: TACBrNFeDANFeFPDF.ImprimirEVENTOPDF gera o arquivo mas não preenche
    DANFE.ArquivoPDF. O arquivo é localizado pelo padrão <tpEvento><chave>*.pdf }
  if TACBrNFeDANFeFPDF(FDANFE).ArquivoPDF = '' then
    LogLinha('  ACHADO: DANFE.ArquivoPDF vazio após ImprimirEventoPDF (FPDF)');
  Pasta := IncludeTrailingPathDelimiter(TACBrNFeDANFeFPDF(FDANFE).PathPDF);
  Arq := '';
  if FindFirst(Pasta + ATpEvento + FNFe.NotasFiscais.Items[0].NumID + '*.pdf', faAnyFile, SR) = 0 then
  begin
    Arq := Pasta + SR.Name;
    FindClose(SR);
  end;
  AssertPDF(Arq);
end;

procedure TTestNFeImpressao.NFe_ImprimirPDF_Arquivo(const ACenario: string);
begin
  CriarNFeComDANFEFPDF(ACenario);
  FNFe.NotasFiscais.Assinar;
  FNFe.NotasFiscais.ImprimirPDF;
  AssertPDF(TACBrNFeDANFeFPDF(FDANFE).ArquivoPDF);
end;

procedure TTestNFeImpressao.NFe_ImprimirPDF_Stream;
var
  MS: TMemoryStream;
begin
  CriarNFeComDANFEFPDF('55_RTC_INT_NCF');
  FNFe.NotasFiscais.Assinar;
  MS := TMemoryStream.Create;
  try
    FNFe.NotasFiscais.ImprimirPDF(MS);
    AssertPDFStream(MS);
  finally
    MS.Free;
  end;
end;

procedure TTestNFeImpressao.NFe_NotaFiscal_ImprimirPDF_Stream;
var
  MS: TMemoryStream;
begin
  CriarNFeComDANFEFPDF('55_RTC_INT_NCF');
  FNFe.NotasFiscais.Assinar;
  MS := TMemoryStream.Create;
  try
    Assert.IsTrue(FNFe.NotasFiscais.Items[0].ImprimirPDF(MS));
    AssertPDFStream(MS);
  finally
    MS.Free;
  end;
end;

procedure TTestNFeImpressao.NFe_ImprimirResumidoPDF_FPDFNaoImplementa;
begin
  { ACHADO: TACBrNFeDANFeFPDF não implementa ImprimirDANFEResumidoPDF }
  CriarNFeComDANFEFPDF('55_RTC_INT_NCF');
  FNFe.NotasFiscais.Assinar;
  Assert.WillRaiseAny(procedure begin FNFe.NotasFiscais.ImprimirResumidoPDF end);
end;

procedure TTestNFeImpressao.NFe_ImprimirPDF_NfeProcAutorizado;
begin
  CriarNFeComDANFEFPDF('55_RTC_INT_NCF');
  Assert.IsTrue(FNFe.Enviar(1, False, True), 'envio simulado');
  FNFe.NotasFiscais.ImprimirPDF;
  AssertPDF(TACBrNFeDANFeFPDF(FDANFE).ArquivoPDF);
end;

procedure TTestNFeImpressao.NFe_ImprimirPDF_XMLAnexadoCorreto;
begin
  CriarNFeComDANFEFPDF('55_RTC_INT_NCF');
  FNFe.NotasFiscais.Clear;
  FNFe.NotasFiscais.LoadFromFile(PastaDados + 'nfeProc_correto.xml');
  FNFe.NotasFiscais.ImprimirPDF;
  AssertPDF(TACBrNFeDANFeFPDF(FDANFE).ArquivoPDF);
end;

procedure TTestNFeImpressao.NFe_ImprimirEventoPDF_Cancelamento;
begin
  CriarNFeComDANFEFPDF('55_RTC_INT_NCF');
  FNFe.Enviar(1, False, True);
  Assert.IsTrue(FNFe.Cancelamento('Cancelamento de teste - ação', 1));
  FNFe.ImprimirEventoPDF;
  AssertPDFEvento('110111');
end;

procedure TTestNFeImpressao.NFe_ImprimirEventoPDF_CCe;
begin
  CriarNFeComDANFEFPDF('55_RTC_INT_NCF');
  FNFe.Enviar(1, False, True);
  FNFe.EventoNFe.Evento.Clear;
  with FNFe.EventoNFe.Evento.New do
  begin
    infEvento.chNFe := FNFe.NotasFiscais.Items[0].NumID;
    infEvento.CNPJ := CNPJ_EMIT;
    infEvento.cOrgao := 35;
    infEvento.dhEvento := Now;
    infEvento.tpEvento := teCCe;
    infEvento.nSeqEvento := 1;
    infEvento.detEvento.xCorrecao := 'Correção: endereço São João - nº 10 & cia';
  end;
  Assert.IsTrue(FNFe.EnviarEvento(1));
  FNFe.ImprimirEventoPDF;
  AssertPDFEvento('110110');
end;

procedure TTestNFeImpressao.NFe_ImprimirInutilizacaoPDF_FPDFNaoImplementa;
begin
  { ACHADO: TACBrNFeDANFeFPDF não implementa ImprimirINUTILIZACAOPDF }
  CriarNFeComDANFEFPDF('55_RTC_INT_NCF');
  FNFe.Inutilizar(CNPJ_EMIT, 'Inutilização por quebra de sequência - ação', 26, 1, 10, 12);
  Assert.WillRaiseAny(procedure begin FNFe.ImprimirInutilizacaoPDF end);
end;

procedure TTestNFeImpressao.NFCe_ImprimirPDF_FPDF;
var
  D: TACBrNFCeDANFeFPDF;
begin
  FNFe := CriarACBrNFe(65, FMock, 'impressao\nfce');
  D := TACBrNFCeDANFeFPDF.Create(nil);
  D.PathPDF := PastaSaidaTeste('impressao\nfce\pdf');
  D.MostraPreview := False;
  D.MostraStatus := False;
  FDANFE := D;
  FNFe.DANFE := D;
  PreencherNFe(FNFe, CenarioPorCodigo('65_RTC_INT_CF'));
  FNFe.NotasFiscais.Assinar;
  FNFe.NotasFiscais.ImprimirPDF;
  AssertPDF(D.ArquivoPDF);
end;

function CriarESCPOS(ANFe: TACBrNFe; const AArquivo: string; out APos: TComponent): TComponent;
var
  P: TACBrPosPrinter;
  D: TACBrNFeDANFeESCPOS;
begin
  P := TACBrPosPrinter.Create(nil);
  P.Modelo := ppEscPosEpson;
  P.Porta := AArquivo;            // ACBrDevice grava em arquivo quando a porta é um caminho
  P.ColunasFonteNormal := 48;
  P.PaginaDeCodigo := pc850;
  D := TACBrNFeDANFeESCPOS.Create(nil);
  D.PosPrinter := P;
  ANFe.DANFE := D;
  APos := P;
  Result := D;
end;

procedure TTestNFeImpressao.NFCe_ESCPOS_Imprimir_EmArquivo;
var
  Arq: string;
  B: RawByteString;
begin
  FNFe := CriarACBrNFe(65, FMock, 'impressao\escpos');
  Arq := PastaSaidaTeste('impressao\escpos') + 'danfce.prn';
  DeleteFile(Arq);
  FDANFE := CriarESCPOS(FNFe, Arq, FPos);
  PreencherNFe(FNFe, CenarioPorCodigo('65_RTC_INT_CF'));
  FNFe.NotasFiscais.Assinar;
  FNFe.NotasFiscais.Imprimir;
  TACBrPosPrinter(FPos).Desativar;
  Assert.IsTrue(FileExists(Arq), 'arquivo ESC/POS');
  B := LerArquivoBytes(Arq);
  LogLinha(Format('  ESC/POS: %d bytes', [Length(B)]));
  Assert.IsTrue(Length(B) > 200, 'ESC/POS muito pequeno');
  Assert.IsTrue(Pos(AnsiString(Copy(FNFe.NotasFiscais.Items[0].NumID, 1, 4)), B) > 0, 'chave no cupom');
end;

procedure TTestNFeImpressao.NFCe_ESCPOS_ImprimirResumido_EmArquivo;
var
  Arq: string;
begin
  FNFe := CriarACBrNFe(65, FMock, 'impressao\escpos');
  Arq := PastaSaidaTeste('impressao\escpos') + 'danfce-resumido.prn';
  DeleteFile(Arq);
  FDANFE := CriarESCPOS(FNFe, Arq, FPos);
  PreencherNFe(FNFe, CenarioPorCodigo('65_RTC_INT_CF'));
  FNFe.NotasFiscais.Assinar;
  FNFe.NotasFiscais.ImprimirResumido;
  TACBrPosPrinter(FPos).Desativar;
  Assert.IsTrue(FileExists(Arq) and (Length(LerArquivoBytes(Arq)) > 100), 'arquivo ESC/POS resumido');
end;

procedure TTestNFeImpressao.NFCe_ESCPOS_ImprimirCancelado_EmArquivo;
var
  Arq: string;
begin
  FNFe := CriarACBrNFe(65, FMock, 'impressao\escpos');
  Arq := PastaSaidaTeste('impressao\escpos') + 'danfce-cancelado.prn';
  DeleteFile(Arq);
  FDANFE := CriarESCPOS(FNFe, Arq, FPos);
  PreencherNFe(FNFe, CenarioPorCodigo('65_RTC_INT_CF'));
  FNFe.NotasFiscais.Assinar;
  FNFe.NotasFiscais.ImprimirCancelado;
  TACBrPosPrinter(FPos).Desativar;
  Assert.IsTrue(FileExists(Arq) and (Length(LerArquivoBytes(Arq)) > 100), 'arquivo ESC/POS cancelado');
end;

procedure TTestNFeImpressao.NFe_Imprimir_ImpressoraWindows;
begin
  CriarNFeComDANFEFPDF('55_RTC_INT_NCF');
  FNFe.NotasFiscais.Assinar;
  FNFe.NotasFiscais.Imprimir;
  Assert.Pass('Conferir a impressão manualmente');
end;

initialization
  TDUnitX.RegisterTestFixture(TTestNFeImpressao);

end.
