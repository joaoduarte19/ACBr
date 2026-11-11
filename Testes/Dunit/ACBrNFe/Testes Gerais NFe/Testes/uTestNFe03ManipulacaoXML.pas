unit uTestNFe03ManipulacaoXML;

{ Testes "dummy" de ida-e-volta de TODOS os métodos que manipulam XML.

  Para cada método: gera uma NF-e com caracteres especiais (TXT_ESPECIAL),
  passa pelo método, recarrega o resultado num componente NOVO e compara
  campo a campo (CompararCampos). Também verifica os bytes produzidos
  (UTF-8 correto, sem dupla conversão) e a assinatura quando aplicável.

  Métodos cobertos:
    NotaFiscal : GerarXML, LerXML, XML (setter), XMLOriginal (setter),
                 XMLAssinado, Assinar, GravarXML, GravarStream, GerarNFeIni,
                 LerArqIni, GerarJSON, LerJSON, GravarTXT
    TNotasFiscais: LoadFromFile, LoadFromStream, LoadFromString (com e sem
                 AGerarNFe), LoadFromIni, LoadFromJSON, GerarIni, GerarJSON,
                 GravarXML, Add, Insert, Clear
    TACBrNFe   : Gravar
  Formatos de entrada: UTF-8 c/ e s/ declaração, UTF-8 com BOM,
    ISO-8859-1, string nativa, lote com várias NF-e, nfeProc autorizado. }

interface

uses
  DUnitX.TestFramework, SysUtils, Classes, ACBrNFe, uSefazMock;

type
  [TestFixture]
  TTestNFeManipulacaoXML = class
  private
    FOrig: TACBrNFe;
    FNovo: TACBrNFe;
    function Novo: TACBrNFe;
    procedure AssertMesmoConteudo(const AMetodo: string; ACarregado: TACBrNFe; AIndice: Integer = 0);
    procedure AssertBytesUTF8(const AMetodo: string; const ABytes: RawByteString);
    function ArqSaida(const ANome: string): string;
    procedure GravarBytes(const AArquivo: string; const ABytes: RawByteString);
  public
    [Setup]    procedure Setup;
    [TearDown] procedure TearDown;

    // ---- NotaFiscal ----
    [Test] procedure M01_GerarXML_LoadFromString;
    [Test] procedure M02_GravarXML_LoadFromFile;
    [Test] procedure M03_NotasFiscais_GravarXML_LoadFromFile;
    [Test] procedure M04_GravarStream_LoadFromStream;
    [Test] procedure M05_Assinar_XMLAssinado_LoadFromString;
    [Test] procedure M06_Assinar_GravarXML_LoadFromFile_AssinaturaValida;
    [Test] procedure M07_PropriedadeXML_Setter;
    [Test] procedure M08_LerXML;
    [Test] procedure M09_PropriedadeXMLOriginal_Setter;
    // ACHADO: o INI não preserva Retirada.xNome (falham até o ACBr corrigir)
    [Test] procedure M10_GerarNFeIni_LoadFromIni;
    [Test] procedure M11_NotasFiscais_GerarIni_LoadFromIni;
    [Test] procedure M12_GerarJSON_LoadFromJSON;
    [Test] procedure M13_LoadFromString_AGerarNFe_Regenera;
    [Test] procedure M14_LoadFromFile_AGerarNFe_Regenera;
    [Test] procedure M15_GravarTXT;
    [Test] procedure M16_TACBrNFe_Gravar;

    // ---- Formatos de entrada ----
    [Test] procedure F01_ArquivoUTF8ComBOM;
    [Test] procedure F02_ArquivoUTF8SemDeclaracao;
    [Test] procedure F03_ArquivoISO88591;
    [Test] procedure F04_StringNativaSemDeclaracao;
    [Test] procedure F05_LoteComVariasNFe;
    [Test] procedure F06_NfeProcAutorizado_GravarELer;
    [Test] procedure F07_XMLsAnexados_CorretoECorrompido;
    [Test] procedure F08_EncadeamentoRepetido_SemDegradacao;

    // ---- Coleção ----
    [Test] procedure C01_Add_Insert_Clear_Count;

    // ---- Grupos de caracteres (ida e volta completa) ----
    [Test]
    [TestCase('Agudos',        '1')]
    [TestCase('Til',           '2')]
    [TestCase('Cedilha',       '3')]
    [TestCase('Circunflexo',   '4')]
    [TestCase('Crase',         '5')]
    [TestCase('Trema',         '6')]
    [TestCase('Enhe',          '7')]
    [TestCase('EComercial',    '8')]
    [TestCase('MenorMaior',    '9')]
    [TestCase('Aspas',         '10')]
    [TestCase('Apostrofo',     '11')]
    [TestCase('Ordinais',      '12')]
    [TestCase('Simbolos1252',  '13')]
    [TestCase('Sobrescritos',  '14')]
    [TestCase('ForaDoCP1252 (limitacao documentada)', '15')]
    procedure G_GrupoDeCaracteres_IdaEVoltaCompleta(const AGrupo: Integer);
  end;

implementation

uses
  StrUtils,
  ACBrNFeNotasFiscais, ACBrNFe.Classes, ACBrNFe.Conversao, ACBrDFe.Conversao,
  ACBrUtil.Strings, ACBrUtil.XMLHTML, ACBrUtil.FilesIO,
  uNFeTesteBase, uXmlTesteHelpers;

const
  GRUPOS: array[1..15] of string = (
    'á é í ó ú Á É Í Ó Ú',
    'ã õ Ã Õ',
    'ç Ç',
    'â ê î ô û Â Ê Î Ô Û',
    'à è ì ò ù À È Ì Ò Ù',
    'ä ë ï ö ü Ä Ë Ï Ö Ü',
    'ñ Ñ',
    'A & B && C',
    'A < B > C <tag>',
    'Texto "entre aspas"',
    'D''Ávila e O''Brien',
    'nº 1º 2ª Nº',
    '€ – — © ® ™ • …',
    '¹ ² ³ ½ ¼ ¾ µ',
    TXT_FORA_CP1252);

{ TTestNFeManipulacaoXML }

procedure TTestNFeManipulacaoXML.Setup;
begin
  FOrig := CriarACBrNFe(55, nil, 'manipulacao');
  PreencherNFe(FOrig, CenarioPorCodigo('55_RTC_IES_CF_ENT_RET'));
  FNovo := nil;
end;

procedure TTestNFeManipulacaoXML.TearDown;
begin
  FreeAndNil(FNovo);
  FreeAndNil(FOrig);
end;

function TTestNFeManipulacaoXML.Novo: TACBrNFe;
begin
  FreeAndNil(FNovo);
  FNovo := CriarACBrNFe(55, nil, 'manipulacao');
  Result := FNovo;
end;

function TTestNFeManipulacaoXML.ArqSaida(const ANome: string): string;
begin
  Result := PastaSaidaTeste('manipulacao') + ANome;
end;

procedure TTestNFeManipulacaoXML.GravarBytes(const AArquivo: string; const ABytes: RawByteString);
var
  FS: TFileStream;
begin
  FS := TFileStream.Create(AArquivo, fmCreate);
  try
    if Length(ABytes) > 0 then
      FS.WriteBuffer(ABytes[1], Length(ABytes));
  finally
    FS.Free;
  end;
end;

procedure TTestNFeManipulacaoXML.AssertMesmoConteudo(const AMetodo: string;
  ACarregado: TACBrNFe; AIndice: Integer);
var
  Dif: string;
begin
  Assert.IsTrue(ACarregado.NotasFiscais.Count > AIndice, AMetodo + ': nota não carregada');
  Dif := CompararCampos(FOrig.NotasFiscais.Items[0].NFe, ACarregado.NotasFiscais.Items[AIndice].NFe);
  LogLinha('  [' + AMetodo + '] ' + IfThen(Dif = '', 'campos preservados', 'DIVERGÊNCIAS:' + Dif));
  Assert.AreEqual('', Dif, AMetodo + ' alterou o conteúdo:' + Dif);
end;

procedure TTestNFeManipulacaoXML.AssertBytesUTF8(const AMetodo: string; const ABytes: RawByteString);
var
  C: TCodificacao;
begin
  C := ClassificarBytes(ABytes, 'ÀÈÌÒÙ âêîôû');
  LogEtapa(AMetodo, 'bytes produzidos', C);
  Assert.AreEqual(NOMES_COD[cdUTF8Correto], NOMES_COD[C], AMetodo);
end;

// ---------------------------------------------------------------- NotaFiscal

procedure TTestNFeManipulacaoXML.M01_GerarXML_LoadFromString;
var
  X: string;
begin
  X := FOrig.NotasFiscais.Items[0].GerarXML;
  AssertBytesUTF8('M01 GerarXML', BytesDeStringACBr(X));
  Novo.NotasFiscais.LoadFromString(X);
  AssertMesmoConteudo('M01 GerarXML->LoadFromString', FNovo);
end;

procedure TTestNFeManipulacaoXML.M02_GravarXML_LoadFromFile;
var
  Arq: string;
begin
  Arq := ArqSaida('m02.xml');
  Assert.IsTrue(FOrig.NotasFiscais.Items[0].GravarXML(ExtractFileName(Arq), ExtractFilePath(Arq)));
  AssertBytesUTF8('M02 GravarXML', LerArquivoBytes(Arq));
  Novo.NotasFiscais.LoadFromFile(Arq);
  AssertMesmoConteudo('M02 GravarXML->LoadFromFile', FNovo);
  Assert.AreEqual(Arq, FNovo.NotasFiscais.Items[0].NomeArq, 'NomeArq');
end;

procedure TTestNFeManipulacaoXML.M03_NotasFiscais_GravarXML_LoadFromFile;
var
  Arq: string;
begin
  Arq := ArqSaida('m03.xml');
  Assert.IsTrue(FOrig.NotasFiscais.GravarXML(Arq));
  AssertBytesUTF8('M03 NotasFiscais.GravarXML', LerArquivoBytes(Arq));
  Novo.NotasFiscais.LoadFromFile(Arq);
  AssertMesmoConteudo('M03 NotasFiscais.GravarXML->LoadFromFile', FNovo);
end;

procedure TTestNFeManipulacaoXML.M04_GravarStream_LoadFromStream;
var
  MS: TMemoryStream;
  SS: TStringStream;
  B: RawByteString;
begin
  MS := TMemoryStream.Create;
  try
    Assert.IsTrue(FOrig.NotasFiscais.Items[0].GravarStream(MS));
    SetLength(B, MS.Size);
    MS.Position := 0;
    MS.ReadBuffer(B[1], MS.Size);
  finally
    MS.Free;
  end;
  AssertBytesUTF8('M04 GravarStream', B);
  SS := TStringStream.Create(B);
  try
    Novo.NotasFiscais.LoadFromStream(SS);
  finally
    SS.Free;
  end;
  AssertMesmoConteudo('M04 GravarStream->LoadFromStream', FNovo);
end;

procedure TTestNFeManipulacaoXML.M05_Assinar_XMLAssinado_LoadFromString;
begin
  FOrig.NotasFiscais.Assinar;
  AssertBytesUTF8('M05 XMLAssinado', BytesDeStringACBr(FOrig.NotasFiscais.Items[0].XMLAssinado));
  Novo.NotasFiscais.LoadFromString(FOrig.NotasFiscais.Items[0].XMLAssinado);
  AssertMesmoConteudo('M05 XMLAssinado->LoadFromString', FNovo);
  Assert.IsTrue(FNovo.NotasFiscais.Items[0].VerificarAssinatura,
    'Assinatura após recarregar: ' + FNovo.NotasFiscais.Items[0].ErroValidacao);
end;

procedure TTestNFeManipulacaoXML.M06_Assinar_GravarXML_LoadFromFile_AssinaturaValida;
var
  Arq: string;
  Erros: string;
begin
  FOrig.NotasFiscais.Assinar;
  Arq := ArqSaida('m06-assinada.xml');
  FOrig.NotasFiscais.Items[0].GravarXML(ExtractFileName(Arq), ExtractFilePath(Arq));
  AssertBytesUTF8('M06 GravarXML(assinada)', LerArquivoBytes(Arq));
  Novo.NotasFiscais.LoadFromFile(Arq);
  AssertMesmoConteudo('M06 Assinada->GravarXML->LoadFromFile', FNovo);
  Assert.IsTrue(FNovo.NotasFiscais.VerificarAssinatura(Erros), 'Assinatura: ' + Erros);
end;

procedure TTestNFeManipulacaoXML.M07_PropriedadeXML_Setter;
begin
  FOrig.NotasFiscais.Items[0].GerarXML;
  Novo.NotasFiscais.Add.XML := FOrig.NotasFiscais.Items[0].XMLOriginal;
  AssertMesmoConteudo('M07 NotaFiscal.XML :=', FNovo);
end;

procedure TTestNFeManipulacaoXML.M08_LerXML;
begin
  FOrig.NotasFiscais.Items[0].GerarXML;
  Assert.IsTrue(Novo.NotasFiscais.Add.LerXML(FOrig.NotasFiscais.Items[0].XMLOriginal));
  AssertMesmoConteudo('M08 NotaFiscal.LerXML', FNovo);
end;

procedure TTestNFeManipulacaoXML.M09_PropriedadeXMLOriginal_Setter;
var
  NF: NotaFiscal;
begin
  FOrig.NotasFiscais.Items[0].GerarXML;
  NF := Novo.NotasFiscais.Add;
  NF.XMLOriginal := FOrig.NotasFiscais.Items[0].XMLOriginal;
  AssertBytesUTF8('M09 XMLOriginal :=', BytesDeStringACBr(NF.XMLOriginal));
  Assert.AreEqual(FOrig.NotasFiscais.Items[0].XMLOriginal, NF.XMLOriginal,
    'XMLOriginal deve ser preservado sem nova conversão');
end;

procedure TTestNFeManipulacaoXML.M10_GerarNFeIni_LoadFromIni;
var
  Ini: string;
begin
  // GerarNFeIni exige a chave calculada (GerarXML antes); senão: "NFe Inconsistente... Chave Inválida"
  FOrig.NotasFiscais.Items[0].GerarXML;
  Ini := FOrig.NotasFiscais.Items[0].GerarNFeIni;
  Assert.IsTrue(Ini <> '', 'INI vazio');
  Novo.NotasFiscais.LoadFromIni(Ini);
  AssertMesmoConteudo('M10 GerarNFeIni->LoadFromIni', FNovo);
end;

procedure TTestNFeManipulacaoXML.M11_NotasFiscais_GerarIni_LoadFromIni;
var
  Arq: string;
  SL: TStringList;
begin
  Arq := ArqSaida('m11.ini');
  FOrig.NotasFiscais.Items[0].GerarXML;
  SL := TStringList.Create;
  try
    SL.Text := FOrig.NotasFiscais.GerarIni;
    SL.SaveToFile(Arq, TEncoding.UTF8);   // gravado em disco e relido
    SL.Clear;
    SL.LoadFromFile(Arq, TEncoding.UTF8);
    Novo.NotasFiscais.LoadFromIni(SL.Text);
  finally
    SL.Free;
  end;
  AssertMesmoConteudo('M11 NotasFiscais.GerarIni->arquivo->LoadFromIni', FNovo);
end;

procedure TTestNFeManipulacaoXML.M12_GerarJSON_LoadFromJSON;
var
  J: string;
begin
  J := FOrig.NotasFiscais.GerarJSON;
  Assert.IsTrue(J <> '', 'JSON vazio');
  Assert.AreEqual(J, FOrig.NotasFiscais.Items[0].GerarJSON, 'NotasFiscais.GerarJSON = Items[0].GerarJSON');
  Novo.NotasFiscais.LoadFromJSON(J);
  AssertMesmoConteudo('M12 GerarJSON->LoadFromJSON', FNovo);
end;

procedure TTestNFeManipulacaoXML.M13_LoadFromString_AGerarNFe_Regenera;
var
  X: string;
begin
  X := FOrig.NotasFiscais.Items[0].GerarXML;
  Novo.NotasFiscais.LoadFromString(X, True);
  AssertMesmoConteudo('M13 LoadFromString(AGerarNFe=True)', FNovo);
  AssertBytesUTF8('M13 XML regenerado', BytesDeStringACBr(FNovo.NotasFiscais.Items[0].XMLOriginal));
  Assert.AreEqual(X, FNovo.NotasFiscais.Items[0].XMLOriginal, 'XML regenerado difere do original');
end;

procedure TTestNFeManipulacaoXML.M14_LoadFromFile_AGerarNFe_Regenera;
var
  Arq: string;
begin
  Arq := ArqSaida('m14.xml');
  FOrig.NotasFiscais.Items[0].GravarXML(ExtractFileName(Arq), ExtractFilePath(Arq));
  Novo.NotasFiscais.LoadFromFile(Arq, True);
  AssertMesmoConteudo('M14 LoadFromFile(AGerarNFe=True)', FNovo);
  AssertBytesUTF8('M14 XML regenerado', BytesDeStringACBr(FNovo.NotasFiscais.Items[0].XMLOriginal));
end;

procedure TTestNFeManipulacaoXML.M15_GravarTXT;
var
  Arq: string;
  Erro: string;
begin
  // ACHADO: com USE_ACBr_XMLDOCUMENT, GravarTXT grava arquivo VAZIO (GerarTXT = '')
  Arq := ArqSaida('m15.xml');
  Erro := '';
  try
    FOrig.NotasFiscais.Items[0].GravarTXT(ExtractFileName(Arq), ExtractFilePath(Arq));
  except
    on E: Exception do Erro := E.ClassName + ': ' + E.Message;
  end;
  LogLinha('  [M15 GravarTXT] ' + IfThen(Erro = '', 'ok', Erro));
  Assert.AreEqual('', Erro);
  Assert.IsTrue(FileExists(ChangeFileExt(Arq, '.txt')), 'arquivo .txt');
end;

procedure TTestNFeManipulacaoXML.M16_TACBrNFe_Gravar;
var
  Arq: string;
  B: RawByteString;
begin
  FOrig.NotasFiscais.Items[0].GerarXML;
  Arq := ArqSaida('m16.xml');
  Assert.IsTrue(FOrig.Gravar(Arq, FOrig.NotasFiscais.Items[0].XMLOriginal));
  B := LerArquivoBytes(Arq);
  AssertBytesUTF8('M16 TACBrNFe.Gravar', B);
  Assert.AreEqual(1, ContarOcorrencias('<?xml', string(B)), 'uma única declaração');
end;

// ---------------------------------------------------------------- Formatos

procedure TTestNFeManipulacaoXML.F01_ArquivoUTF8ComBOM;
var
  Arq: string;
begin
  FOrig.NotasFiscais.Items[0].GerarXML;
  Arq := ArqSaida('f01-bom.xml');
  GravarBytes(Arq, #$EF#$BB#$BF + BytesDeStringACBr(FOrig.NotasFiscais.Items[0].XMLOriginal));
  Novo.NotasFiscais.LoadFromFile(Arq);
  AssertMesmoConteudo('F01 UTF-8 com BOM', FNovo);
end;

procedure TTestNFeManipulacaoXML.F02_ArquivoUTF8SemDeclaracao;
var
  Arq: string;
begin
  FOrig.NotasFiscais.Items[0].GerarXML;
  Arq := ArqSaida('f02-semdecl.xml');
  GravarBytes(Arq, BytesDeStringACBr(RemoverDeclaracaoXML(FOrig.NotasFiscais.Items[0].XMLOriginal)));
  Novo.NotasFiscais.LoadFromFile(Arq);
  AssertMesmoConteudo('F02 UTF-8 sem declaração', FNovo);
  AssertBytesUTF8('F02 XMLOriginal', BytesDeStringACBr(FNovo.NotasFiscais.Items[0].XMLOriginal));
end;

procedure TTestNFeManipulacaoXML.F03_ArquivoISO88591;
var
  Arq, Nativo: string;
begin
  FOrig.NotasFiscais.Items[0].GerarXML;
  Nativo := UTF8ToNativeString(AnsiString(RemoverDeclaracaoXML(FOrig.NotasFiscais.Items[0].XMLOriginal)));
  Arq := ArqSaida('f03-iso.xml');
  GravarBytes(Arq, BytesANSI('<?xml version="1.0" encoding="ISO-8859-1"?>' + Nativo));
  Novo.NotasFiscais.LoadFromFile(Arq);
  AssertMesmoConteudo('F03 ISO-8859-1', FNovo);
  AssertBytesUTF8('F03 XMLOriginal (convertido p/ UTF-8)', BytesDeStringACBr(FNovo.NotasFiscais.Items[0].XMLOriginal));
end;

procedure TTestNFeManipulacaoXML.F04_StringNativaSemDeclaracao;
var
  Nativo: string;
begin
  FOrig.NotasFiscais.Items[0].GerarXML;
  Nativo := UTF8ToNativeString(AnsiString(RemoverDeclaracaoXML(FOrig.NotasFiscais.Items[0].XMLOriginal)));
  Novo.NotasFiscais.LoadFromString(Nativo);
  AssertMesmoConteudo('F04 string nativa', FNovo);
  AssertBytesUTF8('F04 XMLOriginal', BytesDeStringACBr(FNovo.NotasFiscais.Items[0].XMLOriginal));
end;

procedure TTestNFeManipulacaoXML.F05_LoteComVariasNFe;
var
  Lote: string;
begin
  PreencherNFe(FOrig, CenarioPorCodigo('55_RTC_IES_CF_ENT_RET'), 2);
  FOrig.NotasFiscais.Assinar;
  Lote := '<?xml version="1.0" encoding="UTF-8"?><enviNFe xmlns="http://www.portalfiscal.inf.br/nfe" versao="4.00">' +
          '<idLote>1</idLote><indSinc>1</indSinc>' +
          RemoverDeclaracaoXML(FOrig.NotasFiscais.Items[0].XMLAssinado) +
          RemoverDeclaracaoXML(FOrig.NotasFiscais.Items[1].XMLAssinado) + '</enviNFe>';
  Novo.NotasFiscais.LoadFromString(Lote);
  Assert.AreEqual(2, FNovo.NotasFiscais.Count, 'Quantidade de NF-e no lote');
  AssertMesmoConteudo('F05 lote item 0', FNovo, 0);
  AssertMesmoConteudo('F05 lote item 1', FNovo, 1);
end;

procedure TTestNFeManipulacaoXML.F06_NfeProcAutorizado_GravarELer;
var
  Mock: TSefazMock;
  Arq: string;
  Erros: string;
begin
  Mock := TSefazMock.Create;
  try
    Mock.xMotivoProtocolo := 'Autorizado o uso - ação &amp; teste';   // XML do retorno escapa o &
    FOrig.OnTransmit := Mock.OnTransmit;
    FOrig.NotasFiscais.Assinar;
    Assert.IsTrue(FOrig.WebServices.Envia(1, True), 'Envio simulado');
    AssertBytesUTF8('F06 nfeProc (XMLOriginal)', BytesDeStringACBr(FOrig.NotasFiscais.Items[0].XMLOriginal));
    Arq := ArqSaida('f06-nfeproc.xml');
    FOrig.NotasFiscais.Items[0].GravarXML(ExtractFileName(Arq), ExtractFilePath(Arq));
    Novo.NotasFiscais.LoadFromFile(Arq);
    AssertMesmoConteudo('F06 nfeProc->GravarXML->LoadFromFile', FNovo);
    Assert.AreEqual('Autorizado o uso - ação & teste', FNovo.NotasFiscais.Items[0].NFe.procNFe.xMotivo, 'xMotivo do protocolo');
    Assert.AreEqual(100, FNovo.NotasFiscais.Items[0].NFe.procNFe.cStat);
    Assert.IsTrue(FNovo.NotasFiscais.VerificarAssinatura(Erros), 'Assinatura do nfeProc: ' + Erros);
  finally
    FOrig.OnTransmit := nil;
    Mock.Free;
  end;
end;

procedure TTestNFeManipulacaoXML.F07_XMLsAnexados_CorretoECorrompido;
var
  Erros: string;
begin
  Novo.NotasFiscais.LoadFromFile(PastaDados + 'nfeProc_correto.xml');
  Assert.AreEqual(TXT_NATOP, FNovo.NotasFiscais.Items[0].NFe.Ide.natOp);
  Assert.IsTrue(FNovo.NotasFiscais.VerificarAssinatura(Erros), 'correto: ' + Erros);

  Novo.NotasFiscais.LoadFromFile(PastaDados + 'nfeProc_corrompido.xml');
  Assert.AreNotEqual(TXT_NATOP, FNovo.NotasFiscais.Items[0].NFe.Ide.natOp);
  Assert.IsFalse(FNovo.NotasFiscais.VerificarAssinatura(Erros),
    'O XML corrompido (dupla conversão) deve ter assinatura inválida');
end;

procedure TTestNFeManipulacaoXML.F08_EncadeamentoRepetido_SemDegradacao;
var
  i: Integer;
  X, Arq: string;
  N: TACBrNFe;
begin
  FOrig.NotasFiscais.Assinar;
  X := FOrig.NotasFiscais.Items[0].XMLAssinado;
  for i := 1 to 5 do
  begin
    N := CriarACBrNFe(55, nil, 'manipulacao');
    try
      N.NotasFiscais.LoadFromString(X);
      Arq := ArqSaida('f08-ciclo' + IntToStr(i) + '.xml');
      N.NotasFiscais.Items[0].GravarXML(ExtractFileName(Arq), ExtractFilePath(Arq));
      N.NotasFiscais.Clear;
      N.NotasFiscais.LoadFromFile(Arq);
      X := N.NotasFiscais.Items[0].XMLOriginal;
      Assert.AreEqual('', CompararCampos(FOrig.NotasFiscais.Items[0].NFe, N.NotasFiscais.Items[0].NFe),
        'Ciclo ' + IntToStr(i));
    finally
      N.Free;
    end;
  end;
  Assert.AreEqual(FOrig.NotasFiscais.Items[0].XMLAssinado, X, 'XML mudou após 5 ciclos');
end;

// ---------------------------------------------------------------- Coleção

procedure TTestNFeManipulacaoXML.C01_Add_Insert_Clear_Count;
var
  N: TACBrNFe;
  NF: NotaFiscal;
begin
  N := Novo;
  Assert.AreEqual(0, N.NotasFiscais.Count);
  N.NotasFiscais.Add.NFe.Ide.nNF := 1;
  N.NotasFiscais.Add.NFe.Ide.nNF := 3;
  NF := N.NotasFiscais.Insert(1);
  NF.NFe.Ide.nNF := 2;
  Assert.AreEqual(3, N.NotasFiscais.Count);
  Assert.AreEqual(2, N.NotasFiscais.Items[1].NFe.Ide.nNF, 'Insert(1)');
  Assert.AreEqual(3, N.NotasFiscais.Items[2].NFe.Ide.nNF);
  Assert.IsTrue(N.NotasFiscais.GetNamePath <> '');
  N.NotasFiscais.Clear;
  Assert.AreEqual(0, N.NotasFiscais.Count);
end;

// ---------------------------------------------------------------- Grupos

procedure TTestNFeManipulacaoXML.G_GrupoDeCaracteres_IdaEVoltaCompleta(const AGrupo: Integer);
var
  C: TCenarioNFe;
  Arq, Ini, J: string;
  NF: NotaFiscal;
  Erros, DifXML, DifINI, DifJSON: string;
  AssOk: Boolean;
begin
  FOrig.NotasFiscais.Clear;
  C := CenarioPorCodigo('55_RTC_INT_NCF_ENT_RET');
  C.Texto := GRUPOS[AGrupo];
  NF := PreencherNFe(FOrig, C);

  // Assinar -> GravarXML -> LoadFromFile
  FOrig.NotasFiscais.Assinar;
  Arq := ArqSaida('grupo' + IntToStr(AGrupo) + '.xml');
  NF.GravarXML(ExtractFileName(Arq), ExtractFilePath(Arq));
  Novo.NotasFiscais.LoadFromFile(Arq);
  DifXML := CompararCampos(NF.NFe, FNovo.NotasFiscais.Items[0].NFe);
  AssOk := FNovo.NotasFiscais.VerificarAssinatura(Erros);

  // INI
  Ini := NF.GerarNFeIni;
  Novo.NotasFiscais.LoadFromIni(Ini);
  // Retirada.xNome é perdido pelo INI (defeito do ACBr coberto em M10/M11); aqui o foco são os caracteres
  FNovo.NotasFiscais.Items[0].NFe.Retirada.xNome := NF.NFe.Retirada.xNome;
  DifINI := CompararCampos(NF.NFe, FNovo.NotasFiscais.Items[0].NFe);

  // JSON
  J := NF.GerarJSON;
  Novo.NotasFiscais.LoadFromJSON(J);
  DifJSON := CompararCampos(NF.NFe, FNovo.NotasFiscais.Items[0].NFe);

  LogLinha(Format('  [Grupo %d "%s"] XML: %s | INI: %s | JSON: %s | assinatura: %s',
    [AGrupo, GRUPOS[AGrupo], IfThen(DifXML = '', 'ok', 'DIVERGE'), IfThen(DifINI = '', 'ok', 'DIVERGE'),
     IfThen(DifJSON = '', 'ok', 'DIVERGE'), BoolToStr(AssOk, True)]));
  if AGrupo = 15 then
  begin
    { LIMITAÇÃO documentada: o writer grava o texto via CP1252 (SetContent/AnsiString);
      caracteres fora do CP1252 viram '?' no XML e no INI. O JSON preserva. }
    LogLinha('  LIMITAÇÃO: caracteres fora do CP1252 perdidos no XML/INI');
    Assert.IsTrue(DifXML <> '', 'Comportamento mudou: XML passou a preservar caracteres fora do CP1252');
    Assert.AreEqual('', DifJSON, 'JSON');
    Exit;
  end;
  Assert.AreEqual('', IfThen(DifXML <> '', sLineBreak + 'XML:' + DifXML) +
                      IfThen(DifINI <> '', sLineBreak + 'INI:' + DifINI) +
                      IfThen(DifJSON <> '', sLineBreak + 'JSON:' + DifJSON),
    'Grupo ' + IntToStr(AGrupo) + ' "' + GRUPOS[AGrupo] + '"');
  Assert.IsTrue(AssOk, 'Assinatura: ' + Erros);
end;

initialization
  TDUnitX.RegisterTestFixture(TTestNFeManipulacaoXML);

end.
