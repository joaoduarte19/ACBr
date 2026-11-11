unit uTestNFe06ProtocoloMensagem;

{ Protocolo de autorização com MENSAGEM DA SEFAZ (cMsg/xMsg) acentuada.

  Para o ACBr, cStat 100, 120 e 150 são "autorizados" (CstatConfirmada,
  CstatProcessado e montagem do nfeProc). A SEFAZ pode devolver no <protNFe>
  uma mensagem ao contribuinte (cMsg/xMsg), por exemplo um alerta.

  Verifica, nos modos síncrono (S), assíncrono (A) e consulta (C):
    - NotaFiscal.Confirmada / Processada / cStat / Msg
    - NFe.procNFe.cMsg / xMsg / xMotivo (string nativa, acentos e & corretos)
    - nfeProc em XMLOriginal: UTF-8 correto, <xMsg> com & escapado, 1 declaração
    - assinatura válida; persistência (GravarXML -> LoadFromFile); DANFE PDF }

interface

uses
  DUnitX.TestFramework, SysUtils, Classes, ACBrNFe, uSefazMock;

type
  [TestFixture]
  TTestNFeProtocoloMensagem = class
  private
    FNFe: TACBrNFe;
    FMock: TSefazMock;
    procedure Autorizar(ACStat: Integer; const AModo: string);
  public
    [Setup]    procedure Setup;
    [TearDown] procedure TearDown;

    [Test]
    [TestCase('100 sincrono',   '100,S')]
    [TestCase('100 assincrono', '100,A')]
    [TestCase('100 consulta',   '100,C')]
    [TestCase('120 sincrono',   '120,S')]
    [TestCase('120 assincrono', '120,A')]
    [TestCase('120 consulta',   '120,C')]
    [TestCase('150 sincrono',   '150,S')]
    [TestCase('150 assincrono', '150,A')]
    [TestCase('150 consulta',   '150,C')]
    procedure Autorizacao_ComMensagemSEFAZ_Acentuada(const ACStat: Integer; const AModo: string);

    [Test]
    [TestCase('120 sincrono',   '120,S')]
    [TestCase('120 assincrono', '120,A')]
    procedure Autorizacao_ComMensagem_GravarERecarregar(const ACStat: Integer; const AModo: string);

    [Test] procedure Autorizacao120_SemMensagem_NaoGeraTagXMsg;
    [Test] procedure Autorizacao120_DANFE_PDF;

    { DANFE em contingência deve imprimir o protocolo de toda nota autorizada.
      ACBrNFeDANFEClass.ManterProtocolo só considera cStat = 100. }
    [Test]
    [TestCase('Contingencia FS-DA 100', '100')]
    [TestCase('Contingencia FS-DA 120', '120')]
    [TestCase('Contingencia FS-DA 150', '150')]
    procedure DANFE_ManterProtocolo_Contingencia_ImprimeProtocolo(const ACStat: Integer);
  end;

implementation

uses
  ACBrNFeNotasFiscais, ACBrNFe.Classes, ACBrUtil.XMLHTML, ACBrNFeDANFeFPDF,
  ACBrDFe.Conversao,
  uNFeTesteBase, uXmlTesteHelpers;

const
  // Como a SEFAZ envia (XML escapado) e como deve ficar no objeto (nativo)
  XMSG_XML    = 'Atenção: destinatário com situação cadastral irregular &amp; pendência de ' +
                'regularização no órgão &lt;SEFAZ&gt;. Ação requerida em até 30 dias.';
  XMSG_NATIVO = 'Atenção: destinatário com situação cadastral irregular & pendência de ' +
                'regularização no órgão <SEFAZ>. Ação requerida em até 30 dias.';
  CMSG = 777;

function XMotivoDoCStat(ACStat: Integer): string;
begin
  case ACStat of
    120: Result := 'Autorizado o uso da NF-e com alerta';   // texto oficial do cStat 120
    150: Result := 'Autorizado o uso da NF-e, autorização fora de prazo (contingência)';
  else
    Result := 'Autorizado o uso da NF-e';
  end;
end;

{ TTestNFeProtocoloMensagem }

procedure TTestNFeProtocoloMensagem.Setup;
begin
  FMock := TSefazMock.Create;
  FNFe := CriarACBrNFe(55, FMock, 'protocolo');
  PreencherNFe(FNFe, CenarioPorCodigo('55_RTC_INT_NCF'));
end;

procedure TTestNFeProtocoloMensagem.TearDown;
begin
  if Assigned(FNFe) then
    FNFe.DANFE := nil;
  FreeAndNil(FNFe);
  FreeAndNil(FMock);
end;

procedure TTestNFeProtocoloMensagem.Autorizar(ACStat: Integer; const AModo: string);
var
  NF: NotaFiscal;
begin
  FMock.CStatProtocolo := ACStat;
  FMock.xMotivoProtocolo := XMotivoDoCStat(ACStat);
  FMock.cMsgProtocolo := CMSG;
  FMock.xMsgProtocolo := XMSG_XML;
  if AModo = 'C' then
  begin
    FNFe.NotasFiscais.Assinar;
    NF := FNFe.NotasFiscais.Items[0];
    FMock.DefinirProtocolo(NF.NumID, NF.NFe.signature.DigestValue);
    Assert.IsTrue(FNFe.Consultar, 'Consultar: ' + FNFe.WebServices.Consulta.Msg);
  end
  else
    Assert.IsTrue(FNFe.Enviar(1, False, AModo = 'S'), 'Enviar ' + AModo);
end;

procedure TTestNFeProtocoloMensagem.Autorizacao_ComMensagemSEFAZ_Acentuada(
  const ACStat: Integer; const AModo: string);
var
  NF: NotaFiscal;
  C: TCodificacao;
begin
  Autorizar(ACStat, AModo);
  NF := FNFe.NotasFiscais.Items[0];

  LogLinha(Format('  [cStat %d/%s] procNFe.cStat=%d cMsg=%d xMsg="%s"',
    [ACStat, AModo, NF.NFe.procNFe.cStat, NF.NFe.procNFe.cMsg, NF.NFe.procNFe.xMsg]));

  // Situação da nota
  Assert.IsTrue(NF.Confirmada, 'Confirmada');
  Assert.IsTrue(NF.Processada, 'Processada');
  Assert.AreEqual(ACStat, NF.cStat, 'NotaFiscal.cStat');
  Assert.AreEqual(XMotivoDoCStat(ACStat), NF.NFe.procNFe.xMotivo, 'procNFe.xMotivo');

  // Mensagem da SEFAZ no objeto (nativo)
  Assert.AreEqual(CMSG, NF.NFe.procNFe.cMsg, 'procNFe.cMsg');
  Assert.AreEqual(XMSG_NATIVO, NF.NFe.procNFe.xMsg, 'procNFe.xMsg');

  // nfeProc
  Assert.IsTrue(Pos('<nfeProc', NF.XMLOriginal) > 0, 'XMLOriginal deve ser nfeProc');
  Assert.AreEqual(1, ContarOcorrencias('<?xml', NF.XMLOriginal), 'uma declaração');
  Assert.IsTrue(Pos('<cStat>' + IntToStr(ACStat) + '</cStat>', NF.XMLOriginal) > 0, 'cStat no nfeProc');
  Assert.IsTrue(Pos('<cMsg>' + IntToStr(CMSG) + '</cMsg>', NF.XMLOriginal) > 0, 'cMsg no nfeProc');
  Assert.IsTrue(Pos('&amp; pend', NF.XMLOriginal) > 0, '& deve continuar escapado no nfeProc');
  Assert.IsTrue(Pos('&lt;SEFAZ&gt;', NF.XMLOriginal) > 0, '<SEFAZ> deve continuar escapado');

  C := ClassificarStringACBr(NF.XMLOriginal, 'situação cadastral irregular');
  LogEtapa(Format('cStat %d/%s', [ACStat, AModo]), 'nfeProc: trecho xMsg', C);
  Assert.AreEqual(NOMES_COD[cdUTF8Correto], NOMES_COD[C], 'xMsg no nfeProc');
  Assert.AreEqual(NOMES_COD[cdUTF8Correto],
    NOMES_COD[ClassificarStringACBr(NF.XMLOriginal, 'ÀÈÌÒÙ âêîôû')], 'trecho NFe no nfeProc');
  Assert.IsTrue(NF.VerificarAssinatura, 'Assinatura: ' + NF.ErroValidacao);
end;

procedure TTestNFeProtocoloMensagem.Autorizacao_ComMensagem_GravarERecarregar(
  const ACStat: Integer; const AModo: string);
var
  Arq: string;
  N2: TACBrNFe;
  NF2: NotaFiscal;
  Erros: string;
begin
  Autorizar(ACStat, AModo);
  Arq := PastaSaidaTeste('protocolo') + Format('nfeproc-%d-%s.xml', [ACStat, AModo]);
  FNFe.NotasFiscais.Items[0].GravarXML(ExtractFileName(Arq), ExtractFilePath(Arq));
  Assert.AreEqual(NOMES_COD[cdUTF8Correto],
    NOMES_COD[ClassificarBytes(LerArquivoBytes(Arq), 'situação cadastral irregular')], 'arquivo');

  N2 := CriarACBrNFe(55, nil, 'protocolo');
  try
    N2.NotasFiscais.LoadFromFile(Arq);
    NF2 := N2.NotasFiscais.Items[0];
    Assert.AreEqual(ACStat, NF2.NFe.procNFe.cStat, 'cStat recarregado');
    Assert.AreEqual(CMSG, NF2.NFe.procNFe.cMsg, 'cMsg recarregado');
    Assert.AreEqual(XMSG_NATIVO, NF2.NFe.procNFe.xMsg, 'xMsg recarregado');
    Assert.AreEqual(XMotivoDoCStat(ACStat), NF2.NFe.procNFe.xMotivo, 'xMotivo recarregado');
    Assert.IsTrue(N2.NotasFiscais.VerificarAssinatura(Erros), 'Assinatura: ' + Erros);
    Assert.AreEqual('', CompararCampos(FNFe.NotasFiscais.Items[0].NFe, NF2.NFe), 'campos da NF-e');
  finally
    N2.Free;
  end;
end;

procedure TTestNFeProtocoloMensagem.Autorizacao120_SemMensagem_NaoGeraTagXMsg;
var
  NF: NotaFiscal;
begin
  FMock.CStatProtocolo := 120;
  FMock.xMotivoProtocolo := XMotivoDoCStat(120);
  Assert.IsTrue(FNFe.Enviar(1, False, True));
  NF := FNFe.NotasFiscais.Items[0];
  Assert.IsTrue(NF.Confirmada);
  Assert.AreEqual(0, NF.NFe.procNFe.cMsg);
  Assert.AreEqual('', NF.NFe.procNFe.xMsg);
  Assert.AreEqual(0, Pos('<xMsg>', NF.XMLOriginal), 'sem xMsg no retorno, o nfeProc não deve ter <xMsg>');
end;

procedure TTestNFeProtocoloMensagem.Autorizacao120_DANFE_PDF;
var
  D: TACBrNFeDANFeFPDF;
  B: RawByteString;
begin
  D := TACBrNFeDANFeFPDF.Create(nil);
  try
    D.PathPDF := PastaSaidaTeste('protocolo\pdf');
    D.MostraPreview := False;
    D.MostraStatus := False;
    FNFe.DANFE := D;
    Autorizar(120, 'S');
    FNFe.NotasFiscais.ImprimirPDF;
    Assert.IsTrue(FileExists(D.ArquivoPDF), 'PDF: ' + D.ArquivoPDF);
    B := LerArquivoBytes(D.ArquivoPDF);
    Assert.AreEqual(AnsiString('%PDF'), AnsiString(Copy(B, 1, 4)));
  finally
    FNFe.DANFE := nil;
    D.Free;
  end;
end;

procedure TTestNFeProtocoloMensagem.DANFE_ManterProtocolo_Contingencia_ImprimeProtocolo(const ACStat: Integer);
var
  D: TACBrNFeDANFeFPDF;
  NF: NotaFiscal;
  S: string;
begin
  NF := FNFe.NotasFiscais.Items[0];
  NF.NFe.Ide.tpEmis := teFSDA;
  NF.NFe.procNFe.cStat := ACStat;
  NF.NFe.procNFe.xMotivo := XMotivoDoCStat(ACStat);
  NF.NFe.procNFe.nProt := NPROT_TESTE;
  NF.NFe.procNFe.dhRecbto := EncodeDate(2026, 11, 10) + EncodeTime(9, 0, 38, 0);
  D := TACBrNFeDANFeFPDF.Create(nil);
  try
    S := D.ManterProtocolo(NF.NFe);
  finally
    D.Free;
  end;
  LogLinha(Format('  [ManterProtocolo cStat %d] "%s"', [ACStat, Trim(S)]));
  Assert.IsTrue(Pos(NPROT_TESTE, S) > 0,
    Format('DANFE em contingência não imprime o protocolo de nota autorizada com cStat %d', [ACStat]));
end;

initialization
  TDUnitX.RegisterTestFixture(TTestNFeProtocoloMensagem);

end.
