unit uTestNFe02GeracaoXML;

{ Criação de XML "do zero" por cenário (NT / tipo de operação).

  Código do cenário: <modelo>_<RTC|SemRTC>_<INT|IES|EXT>_<CF|NCF>[_ENT][_RET]
    RTC    = com grupos da Reforma Tributária (IBS/CBS)
    INT    = operação interna (idDest=1)       IES = interestadual (idDest=2)
    EXT    = exportação (idDest=3)             CF/NCF = consumidor final ou não
    ENT    = grupo <entrega>                   RET = grupo <retirada>

  Cada cenário passa por: GerarXML, estrutura esperada, texto preservado,
  chave/DV, Assinar + VerificarAssinatura, Validar (schema) e
  ValidarRegrasdeNegocios. }

interface

uses
  DUnitX.TestFramework, SysUtils, Classes, ACBrNFe;

type
  [TestFixture]
  TTestNFeGeracaoXML = class
  private
    FNFe: TACBrNFe;
    procedure Preparar(const ACodigo: string);
  public
    [TearDown] procedure TearDown;

    [Test]
    [TestCase('55 RTC interna',                 '55_RTC_INT_NCF')]
    [TestCase('55 sem RTC interna',             '55_SemRTC_INT_NCF')]
    [TestCase('55 RTC interna cons.final',      '55_RTC_INT_CF')]
    [TestCase('55 RTC interestadual',           '55_RTC_IES_NCF')]
    [TestCase('55 RTC interestadual DIFAL',     '55_RTC_IES_CF')]
    [TestCase('55 sem RTC interestadual DIFAL', '55_SemRTC_IES_CF')]
    [TestCase('55 RTC exportacao',              '55_RTC_EXT_NCF')]
    [TestCase('55 sem RTC exportacao',          '55_SemRTC_EXT_NCF')]
    [TestCase('55 RTC com entrega',             '55_RTC_INT_NCF_ENT')]
    [TestCase('55 RTC com retirada',            '55_RTC_INT_NCF_RET')]
    [TestCase('55 RTC IES entrega+retirada',    '55_RTC_IES_CF_ENT_RET')]
    [TestCase('65 NFCe RTC',                    '65_RTC_INT_CF')]
    [TestCase('65 NFCe sem RTC',                '65_SemRTC_INT_CF')]
    procedure GerarXML_EstruturaDoCenario(const ACodigo: string);

    [Test]
    [TestCase('55 RTC interna',             '55_RTC_INT_NCF')]
    [TestCase('55 sem RTC interestadual',   '55_SemRTC_IES_CF')]
    [TestCase('55 RTC exportacao',          '55_RTC_EXT_NCF')]
    [TestCase('55 RTC entrega+retirada',    '55_RTC_IES_CF_ENT_RET')]
    [TestCase('65 NFCe RTC',                '65_RTC_INT_CF')]
    procedure GerarXML_TextoEspecialPreservado(const ACodigo: string);

    [Test]
    [TestCase('55 RTC interna',             '55_RTC_INT_NCF')]
    [TestCase('55 sem RTC interna',         '55_SemRTC_INT_NCF')]
    [TestCase('55 RTC exportacao',          '55_RTC_EXT_NCF')]
    [TestCase('65 NFCe RTC',                '65_RTC_INT_CF')]
    procedure ChaveDeAcesso_DigitoVerificador(const ACodigo: string);

    [Test]
    [TestCase('55 RTC interna',             '55_RTC_INT_NCF')]
    [TestCase('55 sem RTC interestadual',   '55_SemRTC_IES_CF')]
    [TestCase('55 RTC exportacao',          '55_RTC_EXT_NCF')]
    [TestCase('55 RTC entrega+retirada',    '55_RTC_IES_CF_ENT_RET')]
    [TestCase('65 NFCe RTC',                '65_RTC_INT_CF')]
    [TestCase('65 NFCe sem RTC',            '65_SemRTC_INT_CF')]
    procedure Assinar_AssinaturaValidaETextoPreservado(const ACodigo: string);

    [Test]
    [TestCase('55 RTC interna',             '55_RTC_INT_NCF')]
    [TestCase('55 sem RTC interna',         '55_SemRTC_INT_NCF')]
    [TestCase('55 RTC interestadual DIFAL', '55_RTC_IES_CF')]
    [TestCase('55 RTC exportacao',          '55_RTC_EXT_NCF')]
    [TestCase('55 RTC entrega+retirada',    '55_RTC_IES_CF_ENT_RET')]
    [TestCase('65 NFCe RTC',                '65_RTC_INT_CF')]
    procedure Validar_Schema(const ACodigo: string);

    [Test]
    [TestCase('55 RTC interna',             '55_RTC_INT_NCF')]
    [TestCase('55 RTC interestadual DIFAL', '55_RTC_IES_CF')]
    [TestCase('55 RTC exportacao',          '55_RTC_EXT_NCF')]
    [TestCase('65 NFCe RTC',                '65_RTC_INT_CF')]
    procedure ValidarRegrasdeNegocios(const ACodigo: string);

    [Test] procedure NFCe_Assinar_GeraQRCodeEUrlChave;
    [Test] procedure RetirarAcentos_True_RemoveAcentosDoXML;
    [Test] procedure CaracteresReservados_SaoEscapadosNoXML;
    [Test] procedure NotasFiscais_GerarNFe_GeraTodas;
    [Test] procedure NotaFiscal_GerarTXT_ComACBrXmlDocument_RetornaVazio;
    [Test] procedure Validar_SimbolosCP1252ForaDoLatin1_RejeitadosPeloSchema;
    [Test] procedure NotaFiscal_Alertas_CampoAcimaDoTamanho;
    [Test] procedure NotaFiscal_CalcularNomeArquivoCompleto;
    [Test] procedure NotaFiscal_NumID_IgualChave;
  end;

implementation

uses
  StrUtils,
  ACBrNFe.Conversao, ACBrDFe.Conversao, ACBrNFe.Classes, ACBrNFeNotasFiscais,
  ACBrDFeUtil, ACBrUtil.XMLHTML, ACBrUtil.Strings,
  uNFeTesteBase, uXmlTesteHelpers;

procedure TTestNFeGeracaoXML.Preparar(const ACodigo: string);
var
  C: TCenarioNFe;
begin
  FreeAndNil(FNFe);
  C := CenarioPorCodigo(ACodigo);
  FNFe := CriarACBrNFe(C.Modelo, nil, 'geracao\' + ACodigo);
  PreencherNFe(FNFe, C);
end;

procedure TTestNFeGeracaoXML.TearDown;
begin
  FreeAndNil(FNFe);
end;

procedure TTestNFeGeracaoXML.GerarXML_EstruturaDoCenario(const ACodigo: string);
var
  C: TCenarioNFe;
  X: string;
  procedure Tem(const ATag: string; AEsperado: Boolean);
  begin
    Assert.AreEqual(AEsperado, Pos(ATag, X) > 0,
      Format('%s: tag %s presente=%s', [ACodigo, ATag, BoolToStr(not AEsperado, True)]));
  end;
begin
  C := CenarioPorCodigo(ACodigo);
  Preparar(ACodigo);
  X := FNFe.NotasFiscais.Items[0].GerarXML;
  LogLinha(Format('  [%s] XML gerado: %d caracteres; alertas: %s',
    [ACodigo, Length(X), StringReplace(FNFe.NotasFiscais.Items[0].Alertas, sLineBreak, ' | ', [rfReplaceAll])]));

  Tem('<mod>' + IntToStr(C.Modelo) + '</mod>', True);
  Tem('<IBSCBS>', C.Reforma);
  Tem('<IBSCBSTot>', C.Reforma);
  Tem('<entrega>', C.ComEntrega);
  Tem('<retirada>', C.ComRetirada);
  Tem('<exporta>', C.Destino = doExterior);
  Tem('<idEstrangeiro>', C.Destino = doExterior);
  Tem('<ICMSUFDest>', (C.Destino = doInterestadual) and C.ConsumidorFinal);
  if C.Modelo = 55 then
    Tem('<idDest>' + IntToStr(Ord(C.Destino) + 1) + '</idDest>', True);
  Tem('<indFinal>' + IfThen(C.ConsumidorFinal or (C.Modelo = 65), '1', '0') + '</indFinal>', True);
  Tem('<transporta>', C.ComTransportadora);
  Tem('<cobr>', C.ComCobranca);
  Tem('<pag>', True);
  Tem('<infRespTec>', True);
  Assert.IsTrue(XmlEhUTF8(X), 'XMLOriginal deve ter declaração UTF-8');
end;

procedure TTestNFeGeracaoXML.GerarXML_TextoEspecialPreservado(const ACodigo: string);
var
  N2: TACBrNFe;
  C: TCenarioNFe;
  Dif: string;
  Cod: TCodificacao;
begin
  C := CenarioPorCodigo(ACodigo);
  Preparar(ACodigo);
  FNFe.NotasFiscais.Items[0].GerarXML;
  Cod := ClassificarStringACBr(FNFe.NotasFiscais.Items[0].XMLOriginal, 'ÀÈÌÒÙ âêîôû');
  LogEtapa(ACodigo, 'GerarXML -> XMLOriginal', Cod);
  Assert.AreEqual(NOMES_COD[cdUTF8Correto], NOMES_COD[Cod]);

  N2 := CriarACBrNFe(C.Modelo, nil, 'geracao\' + ACodigo);
  try
    N2.NotasFiscais.LoadFromString(FNFe.NotasFiscais.Items[0].XMLOriginal);
    Dif := CompararCampos(FNFe.NotasFiscais.Items[0].NFe, N2.NotasFiscais.Items[0].NFe);
    Assert.AreEqual('', Dif, 'Campos alterados após GerarXML -> LoadFromString:' + Dif);
  finally
    N2.Free;
  end;
end;

procedure TTestNFeGeracaoXML.ChaveDeAcesso_DigitoVerificador(const ACodigo: string);
var
  NF: NotaFiscal;
  Chave: string;
  DV: Integer;
begin
  Preparar(ACodigo);
  NF := FNFe.NotasFiscais.Items[0];
  NF.GerarXML;
  Chave := NF.NumID;
  Assert.AreEqual(44, Length(Chave), 'Chave com 44 dígitos');
  Assert.AreEqual('35', Copy(Chave, 1, 2), 'cUF');
  Assert.AreEqual(CNPJ_EMIT, Copy(Chave, 7, 14), 'CNPJ');
  Assert.AreEqual(Format('%.2d', [NF.NFe.Ide.modelo]), Copy(Chave, 21, 2), 'modelo');
  Assert.IsTrue(GerarDigito(DV, Copy(Chave, 1, 43)), 'GerarDigito');
  Assert.AreEqual(IntToStr(DV), Copy(Chave, 44, 1), 'DV');
  Assert.AreEqual(DV, NF.NFe.Ide.cDV, 'Ide.cDV');
end;

procedure TTestNFeGeracaoXML.Assinar_AssinaturaValidaETextoPreservado(const ACodigo: string);
var
  NF: NotaFiscal;
  Cod: TCodificacao;
begin
  Preparar(ACodigo);
  FNFe.NotasFiscais.Assinar;
  NF := FNFe.NotasFiscais.Items[0];
  Cod := ClassificarStringACBr(NF.XMLAssinado, 'ÀÈÌÒÙ âêîôû');
  LogEtapa(ACodigo, 'Assinar -> XMLAssinado', Cod);
  Assert.AreEqual(NOMES_COD[cdUTF8Correto], NOMES_COD[Cod]);
  Assert.IsTrue(Pos('<Signature', NF.XMLAssinado) > 0, 'Signature');
  Assert.IsTrue(NF.VerificarAssinatura, 'VerificarAssinatura: ' + NF.ErroValidacao);
end;

procedure TTestNFeGeracaoXML.Validar_Schema(const ACodigo: string);
var
  NF: NotaFiscal;
  Ok: Boolean;
begin
  Preparar(ACodigo);
  FNFe.NotasFiscais.Assinar;
  NF := FNFe.NotasFiscais.Items[0];
  Ok := True;
  try
    NF.Validar;
  except
    Ok := False;
  end;
  if not Ok then
    LogLinha('  [' + ACodigo + '] Validar: ' + NF.ErroValidacaoCompleto);
  Assert.IsTrue(Ok, 'Schema: ' + NF.ErroValidacao);
end;

procedure TTestNFeGeracaoXML.ValidarRegrasdeNegocios(const ACodigo: string);
var
  NF: NotaFiscal;
  Ok: Boolean;
  Erros: string;
begin
  Preparar(ACodigo);
  FNFe.NotasFiscais.Assinar;
  NF := FNFe.NotasFiscais.Items[0];
  Ok := FNFe.NotasFiscais.ValidarRegrasdeNegocios(Erros);
  if not Ok then
    LogLinha('  [' + ACodigo + '] Regras de negócio: ' + StringReplace(Erros, sLineBreak, ' | ', [rfReplaceAll]));
  Assert.IsTrue(Ok, Erros);
  Assert.IsTrue(NF.ValidarRegrasdeNegocios, NF.ErroRegrasdeNegocios);
end;

procedure TTestNFeGeracaoXML.NFCe_Assinar_GeraQRCodeEUrlChave;
var
  NF: NotaFiscal;
begin
  Preparar('65_RTC_INT_CF');
  FNFe.NotasFiscais.Assinar;
  NF := FNFe.NotasFiscais.Items[0];
  Assert.IsTrue(Pos('<infNFeSupl>', NF.XMLAssinado) > 0, 'infNFeSupl');
  Assert.IsTrue(Pos('<qrCode>', NF.XMLAssinado) > 0, 'qrCode');
  Assert.IsTrue(Pos('<urlChave>', NF.XMLAssinado) > 0, 'urlChave');
  Assert.IsTrue(NF.NFe.infNFeSupl.qrCode <> '', 'NFe.infNFeSupl.qrCode');
  Assert.IsTrue(NF.VerificarAssinatura, NF.ErroValidacao);
end;

procedure TTestNFeGeracaoXML.RetirarAcentos_True_RemoveAcentosDoXML;
var
  X: string;
begin
  Preparar('55_RTC_INT_NCF');
  FNFe.Configuracoes.Geral.RetirarAcentos := True;
  X := UTF8ToNativeString(AnsiString(FNFe.NotasFiscais.Items[0].GerarXML));
  Assert.AreEqual(0, Pos('Ç', X) + Pos('ã', X) + Pos('é', X), 'Ainda há acentos no XML');
  Assert.IsTrue(Pos('ACAO', UpperCase(X)) > 0, 'Texto sem acento esperado (ACAO)');
end;

procedure TTestNFeGeracaoXML.CaracteresReservados_SaoEscapadosNoXML;
var
  X: string;
begin
  Preparar('55_RTC_INT_NCF');
  X := FNFe.NotasFiscais.Items[0].GerarXML;
  Assert.IsTrue(Pos('&amp;', X) > 0, '& deve virar &amp;');
  Assert.IsTrue(Pos('&lt;Ltda&gt;', X) > 0, '<Ltda> deve virar &lt;Ltda&gt;');
  Assert.AreEqual(0, Pos('<Ltda>', X), '"<Ltda>" não pode aparecer cru no XML');
end;

procedure TTestNFeGeracaoXML.NotasFiscais_GerarNFe_GeraTodas;
var
  i: Integer;
begin
  Preparar('55_RTC_INT_NCF');
  PreencherNFe(FNFe, CenarioPorCodigo('55_SemRTC_IES_CF'), 2);
  PreencherNFe(FNFe, CenarioPorCodigo('55_RTC_EXT_NCF'), 3);
  FNFe.NotasFiscais.GerarNFe;
  Assert.AreEqual(3, FNFe.NotasFiscais.Count);
  for i := 0 to 2 do
    Assert.IsTrue(FNFe.NotasFiscais.Items[i].XMLOriginal <> '', 'Nota ' + IntToStr(i));
  Assert.AreNotEqual(FNFe.NotasFiscais.Items[0].NumID, FNFe.NotasFiscais.Items[1].NumID);
end;

procedure TTestNFeGeracaoXML.NotaFiscal_GerarTXT_ComACBrXmlDocument_RetornaVazio;
var
  T: string;
begin
  { ACHADO: com USE_ACBr_XMLDOCUMENT (padrão do ACBr.inc) GerarTXT não é
    implementado e devolve '' sem exceção nem alerta. GravarTXT grava arquivo vazio. }
  Preparar('55_SemRTC_INT_NCF');
  T := FNFe.NotasFiscais.Items[0].GerarTXT;
  LogLinha('  ACHADO GerarTXT: ' + IntToStr(Length(T)) + ' caracteres (USE_ACBr_XMLDOCUMENT)');
  Assert.AreEqual('', T, 'Comportamento mudou: GerarTXT passou a gerar conteúdo');
end;

procedure TTestNFeGeracaoXML.Validar_SimbolosCP1252ForaDoLatin1_RejeitadosPeloSchema;
var
  NF: NotaFiscal;
  Ok: Boolean;
begin
  { € e – existem no CP1252 mas estão fora do Latin-1: o schema da SEFAZ
    (padrão [!-ÿ]) os rejeita. O ACBr gera o XML, mas a validação deve falhar. }
  Preparar('55_RTC_INT_NCF');
  NF := FNFe.NotasFiscais.Items[0];
  NF.NFe.InfAdic.infCpl := 'Preço € 10 – promoção';
  FNFe.NotasFiscais.Assinar;
  Ok := True;
  try
    NF.Validar;
  except
    Ok := False;
  end;
  Assert.IsFalse(Ok, 'Schema deveria rejeitar caracteres fora do Latin-1');
  Assert.IsTrue(Pos('infCpl', NF.ErroValidacaoCompleto) > 0, NF.ErroValidacaoCompleto);
end;

procedure TTestNFeGeracaoXML.NotaFiscal_Alertas_CampoAcimaDoTamanho;
var
  NF: NotaFiscal;
begin
  Preparar('55_RTC_INT_NCF');
  NF := FNFe.NotasFiscais.Items[0];
  NF.NFe.Ide.natOp := StringOfChar('A', 70);   // máximo 60
  NF.GerarXML;
  LogLinha('  Alertas: ' + StringReplace(NF.Alertas, sLineBreak, ' | ', [rfReplaceAll]));
  Assert.IsTrue(Pos('natOp', NF.Alertas) > 0, 'Deveria alertar natOp > 60');
end;

procedure TTestNFeGeracaoXML.NotaFiscal_CalcularNomeArquivoCompleto;
var
  NF: NotaFiscal;
  S: string;
begin
  Preparar('55_RTC_INT_NCF');
  NF := FNFe.NotasFiscais.Items[0];
  NF.GerarXML;
  S := NF.CalcularNomeArquivoCompleto;
  Assert.IsTrue(Pos(NF.NumID + '-nfe.xml', S) > 0, S);
  S := NF.CalcularNomeArquivoCompleto('meu.xml', 'C:\temp\');
  Assert.AreEqual('C:\temp\meu.xml', S);
end;

procedure TTestNFeGeracaoXML.NotaFiscal_NumID_IgualChave;
var
  NF: NotaFiscal;
begin
  Preparar('55_RTC_INT_NCF');
  NF := FNFe.NotasFiscais.Items[0];
  NF.GerarXML;
  Assert.AreEqual('NFe' + NF.NumID, NF.NFe.infNFe.ID);
end;

initialization
  TDUnitX.RegisterTestFixture(TTestNFeGeracaoXML);

end.
