unit uTestConversoes;

{ Testes unitários das rotinas de conversão usadas no fluxo da NF-e.
  Os testes afirmam o comportamento CORRETO esperado. Um teste que FALHA
  aponta exatamente a rotina/combinação que provoca a corrupção. }

interface

uses
  DUnitX.TestFramework;

type
  [TestFixture]
  TTestRotinasConversao = class
  private
    FXmlNativoSemDecl: string;   // <NFe>... com acentos, string nativa, sem declaração
    FXmlUTF8ComDecl: string;     // mesmo XML na convenção "UTF8 ACBr", com declaração
    FXmlUTF8SemDecl: string;     // mesmo XML na convenção "UTF8 ACBr", SEM declaração
  public
    [Setup]
    procedure Setup;

    // ---- XmlEhUTF8 ----
    [Test] procedure XmlEhUTF8_ComDeclaracao_RetornaTrue;
    [Test] procedure XmlEhUTF8_SemDeclaracao_RetornaFalse;
    [Test] procedure Limitacao_XmlEhUTF8_SoDetectaPelaDeclaracao;
    [Test] procedure XmlEhUTF8_DeclaracaoISO88591_RetornaFalse;

    // ---- ConverteXMLtoUTF8 ----
    [Test] procedure ConverteXMLtoUTF8_NativoSemDeclaracao_ConverteUmaVez;
    [Test] procedure ConverteXMLtoUTF8_NativoComDeclaracaoISO_ConverteUmaVez;
    [Test] procedure ConverteXMLtoUTF8_UTF8ComDeclaracao_NaoAltera;
    [Test] procedure ConverteXMLtoUTF8_ChamadoDuasVezes_Idempotente;
    [Test] procedure Limitacao_ConverteXMLtoUTF8_UTF8SemDeclaracao_Recodifica;
    [Test]
    [TestCase('NFe',    'nfeProc,NFe,protNFe')]
    [TestCase('CTe',    'cteProc,CTe,protCTe')]
    [TestCase('MDFe',   'mdfeProc,MDFe,protMDFe')]
    [TestCase('BPe',    'bpeProc,BPe,protBPe')]
    [TestCase('DCe',    'dceProc,DCe,protDCe')]
    [TestCase('NFCom',  'nfcomProc,NFCom,protNFCom')]
    [TestCase('NFAg',   'nfagProc,NFAg,protNFAg')]
    [TestCase('NFGas',  'nfgasProc,NFGas,protNFGas')]
    procedure TProcDFe_TodosDFe_UTF8ComDeclaracaoSemDuplicar(const AGrupo, ADFe, AProt: string);
    [Test] procedure TProcDFe_GerarXML_DeveTerDeclaracaoUTF8;
    [Test] procedure TProcDFe_GerarXML_SetXMLOriginal_NaoDeveDuplicar;

    // ---- NativeStringToUTF8 / UTF8ToNativeString ----
    [Test] procedure NativeStringToUTF8_UTF8ToNativeString_RoundTrip;
    [Test] procedure NativeStringToUTF8_AplicadoDuasVezes_GeraDuploUTF8;

    // ---- ConverteXMLtoNativeString / RemoverDeclaracaoXML ----
    [Test] procedure ConverteXMLtoNativeString_ComDeclaracao_ConverteERemoveDeclaracao;
    [Test] procedure Limitacao_ConverteXMLtoNativeString_UTF8SemDeclaracao_NaoConverte;
    [Test] procedure RemoverDeclaracaoXML_NaoAlteraConteudo;

    // ---- Assinatura/Gravação de baixo nível ----
    [Test] procedure TACBrDFe_Gravar_StringUTF8SemDeclaracao_NaoDeveDuplicar;
  end;

implementation

uses
  SysUtils, Classes,
  ACBrUtil.Strings, ACBrUtil.XMLHTML, ACBrNFe, ACBrDFeComum.Proc,
  uXmlTesteHelpers;

const
  DECL = '<?xml version="1.0" encoding="UTF-8"?>';

{ TTestRotinasConversao }

procedure TTestRotinasConversao.Setup;
begin
  FXmlNativoSemDecl := '<NFe xmlns="http://www.portalfiscal.inf.br/nfe"><infNFe><xProd>' +
    TXT_ACENTOS + '</xProd></infNFe></NFe>';
  FXmlUTF8SemDecl := string(NativeStringToUTF8(FXmlNativoSemDecl));
  FXmlUTF8ComDecl := DECL + FXmlUTF8SemDecl;
end;

procedure TTestRotinasConversao.XmlEhUTF8_ComDeclaracao_RetornaTrue;
begin
  Assert.IsTrue(XmlEhUTF8(FXmlUTF8ComDecl));
end;

procedure TTestRotinasConversao.XmlEhUTF8_SemDeclaracao_RetornaFalse;
begin
  Assert.IsFalse(XmlEhUTF8(FXmlNativoSemDecl));
end;

procedure TTestRotinasConversao.Limitacao_XmlEhUTF8_SoDetectaPelaDeclaracao;
begin
  { DOCUMENTA a limitação (causa raiz): XmlEhUTF8 só verifica a DECLARAÇÃO nos
    primeiros 50 caracteres. Conteúdo já em UTF-8, sem declaração, NÃO é reconhecido.
    Logo, nenhum chamador pode entregar UTF-8 sem declaração a ConverteXMLtoUTF8. }
  LogLinha('XmlEhUTF8(UTF8 sem declaração) = ' + BoolToStr(XmlEhUTF8(FXmlUTF8SemDecl), True));
  Assert.IsFalse(XmlEhUTF8(FXmlUTF8SemDecl));
end;

procedure TTestRotinasConversao.XmlEhUTF8_DeclaracaoISO88591_RetornaFalse;
begin
  Assert.IsFalse(XmlEhUTF8('<?xml version="1.0" encoding="ISO-8859-1"?>' + FXmlNativoSemDecl));
end;

procedure TTestRotinasConversao.ConverteXMLtoUTF8_NativoSemDeclaracao_ConverteUmaVez;
var
  R: string;
begin
  R := ConverteXMLtoUTF8(FXmlNativoSemDecl);
  Assert.IsTrue(XmlEhUTF8(R), 'Deveria incluir a declaração UTF-8');
  Assert.AreEqual(NOMES_COD[cdUTF8Correto], NOMES_COD[ClassificarStringACBr(R, TXT_ACENTOS)]);
end;

procedure TTestRotinasConversao.ConverteXMLtoUTF8_NativoComDeclaracaoISO_ConverteUmaVez;
var
  R: string;
begin
  R := ConverteXMLtoUTF8('<?xml version="1.0" encoding="ISO-8859-1"?>' + FXmlNativoSemDecl);
  Assert.AreEqual(1, Pos('<?xml version="1.0" encoding="UTF-8"?>', R), 'Declaração deve ser trocada');
  Assert.AreEqual(0, Pos('ISO-8859-1', R), 'Declaração ISO não deve permanecer');
  Assert.AreEqual(NOMES_COD[cdUTF8Correto], NOMES_COD[ClassificarStringACBr(R, TXT_ACENTOS)]);
end;

procedure TTestRotinasConversao.ConverteXMLtoUTF8_UTF8ComDeclaracao_NaoAltera;
begin
  Assert.AreEqual(FXmlUTF8ComDecl, ConverteXMLtoUTF8(FXmlUTF8ComDecl));
end;

procedure TTestRotinasConversao.ConverteXMLtoUTF8_ChamadoDuasVezes_Idempotente;
var
  R1, R2: string;
begin
  R1 := ConverteXMLtoUTF8(FXmlNativoSemDecl);
  R2 := ConverteXMLtoUTF8(R1);
  Assert.AreEqual(R1, R2);
end;

procedure TTestRotinasConversao.Limitacao_ConverteXMLtoUTF8_UTF8SemDeclaracao_Recodifica;
var
  R: string;
  C: TCodificacao;
begin
  { DOCUMENTA o mecanismo da dupla conversão: UTF-8 sem declaração é recodificado }
  R := ConverteXMLtoUTF8(FXmlUTF8SemDecl);
  C := ClassificarStringACBr(R, TXT_ACENTOS);
  LogEtapa('ConverteXMLtoUTF8', 'entrada: UTF-8 SEM declaração', C,
    'bytes: ' + HexTrecho(BytesDeStringACBr(R), TXT_ACENTOS));
  Assert.AreEqual(NOMES_COD[cdUTF8Duplo], NOMES_COD[C]);
end;

function MontarProc(out AFinal: string): string;
var
  Proc: TProcDFe;
  Assinado: string;
begin
  { Reproduz exatamente TNFeRecepcao.TratarResposta (ACBrNFeWebServices.pas):
      AProcNFe.XML_DFe := RemoverDeclaracaoXML(XMLAssinado);
      AProcNFe.XML_Prot := ...XMLprotNFe;
      XMLOriginal := AProcNFe.GerarXML;   -> SetXMLOriginal -> ConverteXMLtoUTF8 }
  Assinado := ConverteXMLtoUTF8('<NFe xmlns="http://www.portalfiscal.inf.br/nfe"><infNFe><xProd>' +
    TXT_ACENTOS + '</xProd></infNFe></NFe>');
  Proc := TProcDFe.Create('4.00', 'xmlns="http://www.portalfiscal.inf.br/nfe"', 'nfeProc', 'NFe');
  try
    Proc.XML_DFe := RemoverDeclaracaoXML(Assinado);
    Proc.XML_Prot := '<protNFe versao="4.00"><infProt><cStat>100</cStat></infProt></protNFe>';
    Result := Proc.GerarXML;
  finally
    Proc.Free;
  end;
  AFinal := ConverteXMLtoUTF8(Result);   // o que NotaFiscal.SetXMLOriginal faz
end;

procedure TTestRotinasConversao.TProcDFe_TodosDFe_UTF8ComDeclaracaoSemDuplicar(
  const AGrupo, ADFe, AProt: string);
var
  Proc: TProcDFe;
  Assinado, Prot, R, F: string;
begin
  { Mesmo padrão de XxxWebServices: XML_DFe := RemoverDeclaracaoXML(XMLAssinado);
    XML_Prot := XMLprotDFe (OuterXml, UTF8); XMLOriginal := GerarXML }
  Assinado := ConverteXMLtoUTF8('<' + ADFe + ' xmlns="http://x"><inf><xNome>' +
    TXT_ACENTOS + '</xNome></inf></' + ADFe + '>');
  Prot := string(NativeStringToUTF8('<' + AProt + ' versao="1.00"><infProt><xMotivo>' +
    TXT_XPROD + '</xMotivo></infProt></' + AProt + '>'));
  Proc := TProcDFe.Create('1.00', 'xmlns="http://x"', AGrupo, ADFe);
  try
    Proc.XML_DFe := RemoverDeclaracaoXML(Assinado);
    Proc.XML_Prot := Prot;
    R := Proc.GerarXML;
  finally
    Proc.Free;
  end;
  F := ConverteXMLtoUTF8(R);   // SetXMLOriginal
  LogEtapa('TProcDFe ' + ADFe, AGrupo + ': DFe / prot',
    ClassificarStringACBr(F, TXT_ACENTOS), 'prot: ' + NOMES_COD[ClassificarStringACBr(F, TXT_XPROD)]);
  Assert.IsTrue(XmlEhUTF8(R), 'GerarXML sem declaração UTF-8');
  Assert.AreEqual(1, Pos('<?xml version="1.0" encoding="UTF-8"?><' + AGrupo, F), 'início do XML');
  Assert.AreEqual(0, Pos('<?xml', Copy(F, 2, MaxInt)), 'declaração duplicada');
  Assert.AreEqual(NOMES_COD[cdUTF8Correto], NOMES_COD[ClassificarStringACBr(F, TXT_ACENTOS)], 'trecho DFe');
  Assert.AreEqual(NOMES_COD[cdUTF8Correto], NOMES_COD[ClassificarStringACBr(F, TXT_XPROD)], 'trecho prot');
end;

procedure TTestRotinasConversao.TProcDFe_GerarXML_DeveTerDeclaracaoUTF8;
var
  R, F: string;
begin
  R := MontarProc(F);
  LogLinha('  [TProcDFe.GerarXML] início = "' + Copy(R, 1, 60) + '..."');
  Assert.IsTrue(XmlEhUTF8(R),
    'TProcDFe.GerarXML não emite <?xml ... encoding="UTF-8"?> (TProcNFe/TProcCTe/TProcMDFe emitiam)');
end;

procedure TTestRotinasConversao.TProcDFe_GerarXML_SetXMLOriginal_NaoDeveDuplicar;
var
  R, F: string;
  C: TCodificacao;
begin
  R := MontarProc(F);
  C := ClassificarStringACBr(F, TXT_ACENTOS);
  LogEtapa('TProcDFe+SetXMLOriginal', 'RemoverDecl(Assinado)->GerarXML->ConverteXMLtoUTF8', C,
    'bytes: ' + HexTrecho(BytesDeStringACBr(F), TXT_ACENTOS));
  Assert.AreEqual(NOMES_COD[cdUTF8Correto], NOMES_COD[C]);
end;

procedure TTestRotinasConversao.NativeStringToUTF8_UTF8ToNativeString_RoundTrip;
begin
  Assert.AreEqual(TXT_ACENTOS, UTF8ToNativeString(NativeStringToUTF8(TXT_ACENTOS)));
end;

procedure TTestRotinasConversao.NativeStringToUTF8_AplicadoDuasVezes_GeraDuploUTF8;
var
  Duas: AnsiString;
begin
  // Demonstração: este é o padrão de bytes encontrado nos XMLs corrompidos
  Duas := NativeStringToUTF8(string(NativeStringToUTF8(TXT_NATOP)));
  Assert.AreEqual(NOMES_COD[cdUTF8Duplo],
    NOMES_COD[ClassificarBytes(RawByteString(Duas), TXT_NATOP)]);
  LogLinha('  Dupla NativeStringToUTF8("' + TXT_NATOP + '") lida como UTF-8 = "' +
    UTF8ToNativeString(Duas) + '"');
end;

procedure TTestRotinasConversao.ConverteXMLtoNativeString_ComDeclaracao_ConverteERemoveDeclaracao;
var
  R: string;
begin
  R := ConverteXMLtoNativeString(FXmlUTF8ComDecl);
  Assert.AreEqual(FXmlNativoSemDecl, R);
end;

procedure TTestRotinasConversao.Limitacao_ConverteXMLtoNativeString_UTF8SemDeclaracao_NaoConverte;
var
  R: string;
begin
  { DOCUMENTA a mesma limitação no sentido inverso: sem declaração a string UTF-8
    é tratada como nativa (o objeto NFe receberia "Ã‡" em vez de "Ç"). }
  R := ConverteXMLtoNativeString(FXmlUTF8SemDecl);
  Assert.AreEqual(FXmlUTF8SemDecl, R);
end;

procedure TTestRotinasConversao.RemoverDeclaracaoXML_NaoAlteraConteudo;
begin
  Assert.AreEqual(FXmlUTF8SemDecl, RemoverDeclaracaoXML(FXmlUTF8ComDecl));
end;

procedure TTestRotinasConversao.TACBrDFe_Gravar_StringUTF8SemDeclaracao_NaoDeveDuplicar;
var
  NFe: TACBrNFe;
  Arq: string;
  C: TCodificacao;
begin
  { TACBrDFe.Gravar(..., ConteudoEhUTF8 = False [padrão]) chama ConverteXMLtoUTF8 }
  NFe := TACBrNFe.Create(nil);
  try
    Arq := PastaSaida + 'gravar_utf8_sem_decl.xml';
    NFe.Gravar(Arq, FXmlUTF8SemDecl);
    C := ClassificarBytes(BytesDeArquivo(Arq), TXT_ACENTOS);
    LogEtapa('TACBrDFe.Gravar', 'string UTF-8 sem declaração', C);
    Assert.AreEqual(NOMES_COD[cdUTF8Correto], NOMES_COD[C]);
  finally
    NFe.Free;
  end;
end;

initialization
  TDUnitX.RegisterTestFixture(TTestRotinasConversao);

end.
