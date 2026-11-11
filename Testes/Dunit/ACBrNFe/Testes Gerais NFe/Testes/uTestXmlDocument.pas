unit uTestXmlDocument;

{ Testes do TACBrXmlDocument (libxml2) com acentuação.
  O mesmo fonte é compilado duas vezes:
   - TestXMLAcentuado_Trunk.exe : ACBrXmlDocument.pas do trunk (Fontes\ACBrLibXML2)
   - TestXMLAcentuado_Local.exe : ACBrXmlDocument.pas da pasta C:\teste\XMLAcentuado
     (GetOuterXml/GetInnerXml com UTF8ToNativeString)

  Contrato que os CONSUMIDORES do ACBr esperam de OuterXml/InnerXml:
   - ACBrNFe.RetConsSit: XMLprotNFe := OuterXml  -> concatenado com XMLAssinado
     (UTF8 ACBr) em TProcDFe.GerarXML;
   - ACBrDFeComum.RetDistDFeInt: docZip.XML := OuterXml -> gravado/recarregado;
   - NFSe: CarregarXmlNfse(OuterXml) -> re-parse com libxml2 (AnsiString(..)).
  Ou seja: OuterXml deve poder ser re-parseado e concatenado com strings UTF8 ACBr. }

interface

uses
  DUnitX.TestFramework, ACBrXmlDocument;

type
  [TestFixture]
  TTestACBrXmlDocument = class
  private
    FDoc: TACBrXmlDocument;
    FXmlUTF8: AnsiString;
  public
    [Setup]    procedure Setup;
    [TearDown] procedure TearDown;

    [Test] procedure Content_RetornaStringNativaCorreta;
    [Test] procedure AtributoContent_RetornaStringNativaCorreta;
    [Test] procedure Xml_RetornaBytesUTF8Corretos;
    [Test] procedure OuterXml_Classificacao;
    [Test] procedure InnerXml_Classificacao;
    [Test] procedure OuterXml_RecarregadoEmOutroDocumento_PreservaAcentos;
    [Test] procedure OuterXml_ConcatenadoComXMLAssinado_GeraNfeProcValido;
    [Test] procedure SetContent_TextoNativo_GravaUTF8;
  end;

implementation

uses
  SysUtils, Classes,
  ACBrUtil.Strings, ACBrUtil.XMLHTML,
  uXmlTesteHelpers;

{ TTestACBrXmlDocument }

procedure TTestACBrXmlDocument.Setup;
begin
  FXmlUTF8 := NativeStringToUTF8(
    '<?xml version="1.0" encoding="UTF-8"?>' +
    '<protNFe versao="4.00"><infProt Id="ID1">' +
    '<xMotivo>' + TXT_ACENTOS + '</xMotivo>' +
    '<xMsg obs="' + TXT_XPROD + '">' + TXT_NATOP + '</xMsg>' +
    '</infProt></protNFe>');
  FDoc := TACBrXmlDocument.Create;
  FDoc.LoadFromXml(FXmlUTF8);
end;

procedure TTestACBrXmlDocument.TearDown;
begin
  FDoc.Free;
end;

procedure TTestACBrXmlDocument.Content_RetornaStringNativaCorreta;
var
  S: string;
begin
  S := FDoc.Root.Childrens.FindAnyNs('infProt').Childrens.FindAnyNs('xMotivo').Content;
  LogEtapa('XmlDocument.Content', 'xMotivo (string nativa)', ClassificarStringNativa(S, TXT_ACENTOS));
  Assert.AreEqual(TXT_ACENTOS, S);
end;

procedure TTestACBrXmlDocument.AtributoContent_RetornaStringNativaCorreta;
var
  S: string;
begin
  S := FDoc.Root.Childrens.FindAnyNs('infProt').Childrens.FindAnyNs('xMsg').Attributes.Items['obs'].Content;
  Assert.AreEqual(TXT_XPROD, S);
end;

procedure TTestACBrXmlDocument.Xml_RetornaBytesUTF8Corretos;
var
  C: TCodificacao;
begin
  C := ClassificarBytes(RawByteString(FDoc.Xml), TXT_ACENTOS);
  LogEtapa('XmlDocument.Xml', 'AnsiString do documento', C);
  Assert.AreEqual(NOMES_COD[cdUTF8Correto], NOMES_COD[C]);
end;

procedure TTestACBrXmlDocument.OuterXml_Classificacao;
var
  S: string;
  CAcbr, CNativa: TCodificacao;
begin
  S := FDoc.Root.OuterXml;
  CAcbr := ClassificarStringACBr(S, TXT_ACENTOS);
  CNativa := ClassificarStringNativa(S, TXT_ACENTOS);
  LogEtapa('XmlDocument.OuterXml', 'lido como string UTF8 ACBr (AnsiString(S))', CAcbr);
  LogEtapa('XmlDocument.OuterXml', 'lido como string nativa', CNativa);
  { O contrato usado por TProcDFe/RetConsSit é "UTF8 ACBr" }
  Assert.AreEqual(NOMES_COD[cdUTF8Correto], NOMES_COD[CAcbr],
    'OuterXml não está na convenção UTF8 ACBr esperada pelos consumidores (TProcDFe, RetConsSit, NFSe)');
end;

procedure TTestACBrXmlDocument.InnerXml_Classificacao;
var
  S: string;
  C: TCodificacao;
begin
  S := FDoc.Root.InnerXml;
  C := ClassificarStringACBr(S, TXT_ACENTOS);
  LogEtapa('XmlDocument.InnerXml', 'lido como string UTF8 ACBr', C);
  Assert.AreEqual(NOMES_COD[cdUTF8Correto], NOMES_COD[C]);
end;

procedure TTestACBrXmlDocument.OuterXml_RecarregadoEmOutroDocumento_PreservaAcentos;
var
  Doc2: TACBrXmlDocument;
  S: string;
begin
  { Padrão usado em NFSe (CarregarXmlNfse(ANode.OuterXml)) e RetDistDFeInt }
  Doc2 := TACBrXmlDocument.Create;
  try
    try
      Doc2.LoadFromXml(AnsiString(FDoc.Root.OuterXml));
      S := Doc2.Root.Childrens.FindAnyNs('infProt').Childrens.FindAnyNs('xMotivo').Content;
    except
      on E: Exception do
        S := 'EXCEÇÃO: ' + E.Message;
    end;
    LogLinha('  [XmlDocument re-parse        ] Content após recarregar OuterXml = "' + S + '"');
    Assert.AreEqual(TXT_ACENTOS, S);
  finally
    Doc2.Free;
  end;
end;

procedure TTestACBrXmlDocument.OuterXml_ConcatenadoComXMLAssinado_GeraNfeProcValido;
var
  XMLAssinado, Proc: string;
  C: TCodificacao;
begin
  { Simula TProcDFe.GerarXML: XML_DFe (UTF8 ACBr) + XML_Prot (OuterXml) }
  XMLAssinado := string(NativeStringToUTF8('<NFe xmlns="x"><natOp>' + TXT_NATOP + '</natOp></NFe>'));
  Proc := '<nfeProc>' + XMLAssinado + FDoc.Root.OuterXml + '</nfeProc>';
  C := ClassificarStringACBr(Proc, TXT_ACENTOS);   // parte vinda do OuterXml
  LogEtapa('nfeProc (NFe + OuterXml)', 'trecho do protNFe (xMotivo)', C);
  Assert.AreEqual(NOMES_COD[cdUTF8Correto], NOMES_COD[C],
    'Trecho do protNFe ficou em codificação diferente do trecho da NFe');
  Assert.AreEqual(NOMES_COD[cdUTF8Correto], NOMES_COD[ClassificarStringACBr(Proc, TXT_NATOP)]);
end;

procedure TTestACBrXmlDocument.SetContent_TextoNativo_GravaUTF8;
var
  Doc: TACBrXmlDocument;
  N: TACBrXmlNode;
  C: TCodificacao;
  X: AnsiString;
  R: string;
begin
  { Contrato REAL do writer (TACBrXmlWriter): Content recebe texto NATIVO,
    SaveOptions = [xmlNoEmpty, xmlNoDecl]. Doc.Xml sai em bytes CP1252 e SEM
    declaração; NotaFiscal.SetXMLOriginal -> ConverteXMLtoUTF8 converte UMA vez.
    (Obs.: caracteres fora do CP1252 se perdem nesse caminho.) }
  Doc := TACBrXmlDocument.Create;
  try
    Doc.SaveOptions := [xmlNoEmpty, xmlNoDecl];
    N := Doc.CreateElement('teste');
    Doc.Root := N;
    N.Content := TXT_ACENTOS;
    X := Doc.Xml;
    LogEtapa('XmlDocument.SetContent', 'texto nativo -> Doc.Xml (xmlNoDecl)',
      ClassificarBytes(RawByteString(X), TXT_ACENTOS));
    R := ConverteXMLtoUTF8(string(X));       // o que SetXMLOriginal faz
    C := ClassificarStringACBr(R, TXT_ACENTOS);
    LogEtapa('XmlDocument.SetContent', '... -> ConverteXMLtoUTF8 (SetXMLOriginal)', C);
    Assert.AreEqual(NOMES_COD[cdUTF8Correto], NOMES_COD[C]);
  finally
    Doc.Free;
  end;
end;

initialization
  TDUnitX.RegisterTestFixture(TTestACBrXmlDocument);

end.
