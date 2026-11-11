unit uTestFluxoNFe;

{ Testes do fluxo REAL do componente TACBrNFe, sem acesso à SEFAZ:
  a transmissão é interceptada pelo evento TACBrNFe.OnTransmit, que devolve
  uma resposta SOAP montada aqui (cStat 104/100, digVal = DigestValue enviado).

  Etapas verificadas (cada uma registrada em bin\rastreio_etapas.log):
   E1  LoadFromFile                    -> Items[0].XMLOriginal / NFe.Ide.natOp
   E2  GerarXML + Assinar              -> Items[0].XMLAssinado
   E3  XML preparado p/ envio          -> Dados recebidos em OnTransmit (envelope SOAP)
   E4  Retorno processado              -> WebServices.Enviar.RetWS / XMLprotNFe
   E5  nfeProc em NotasFiscais.Items[0]-> XMLOriginal / XML
   E6  Arquivo gravado pelo ACBr       -> bytes do <chave>-nfe.xml
   E7  Gravação em "banco"             -> padrões comuns de persistência
   E8  Assinatura do XML final         -> VerificarAssinatura }

interface

uses
  DUnitX.TestFramework, Classes, SysUtils, ACBrNFe;

type
  TModoRetorno = (mrSincrono, mrAssincrono, mrConsulta);

  [TestFixture]
  TTestFluxoNFe = class
  private
    FNFe: TACBrNFe;
    FDadosEnviados: string;
    FModo: TModoRetorno;
    FDigestEnviado: string;
    FChave: string;
    FDeclaracaoNaResposta: Boolean;
    FxMotivo: string;
    procedure Configurar;
    procedure OnTransmit(const Dados, URL, SoapAction, MimeType: String;
      var Resposta: String; var HTTPResultCode: Integer; var InternalErrorCode: Integer);
    function ProtNFe: string;
    function Envelope(const AConteudo: string): string;
    function CopiarEntrada(const ANome: string): string;
    procedure CarregarEAcentuar;
    procedure EnviarSincrono;
    function ArquivoGravado: string;
  public
    [Setup]    procedure Setup;
    [TearDown] procedure TearDown;

    // ---- Carregamento ----
    [Test] procedure E1_LoadFromFile_XMLCorreto_XMLOriginalUTF8EObjetoNativo;
    [Test] procedure E1_LoadFromFile_XMLCorrompido_AssinaturaInvalida;
    [Test] procedure E1_LoadFromFile_NFeAssinadaSemDeclaracao;
    [Test] procedure E1_LoadFromString_XMLNativoSemDeclaracao;
    [Test] procedure E1_LoadFromFile_GravarXML_RoundTripIdentico;

    // ---- Geração / Assinatura / Envio ----
    [Test] procedure E2_Assinar_XMLAssinadoUTF8EAssinaturaValida;
    [Test] procedure E3_Envio_DadosTransmitidosUTF8Correto;

    // ---- Retorno ----
    [Test] procedure E4_RetornoSincrono_RetWSUTF8Correto;
    [Test] procedure E5_RetornoSincrono_ItemsXMLOriginal_NaoDeveDuplicar;
    [Test] procedure E6_RetornoSincrono_ArquivoGravado_NaoDeveDuplicar;
    [Test] procedure E5_RetornoSincrono_XMLProtocolo_XMLAssinado_XML_Integros;
    [Test] procedure E8_RetornoSincrono_AssinaturaDoNfeProcContinuaValida;
    [Test] procedure E5_RetornoAssincrono_ItemsXMLOriginal_NaoDeveDuplicar;
    [Test] procedure E4_RetornoAssincrono_xMotivoAcentuado_DeveSerLido;
    [Test]
    [TestCase('Sincrono',   'S')]
    [TestCase('Assincrono', 'A')]
    procedure E4_Retorno_xMotivoComEntidadesXML_DeveSerLido(const AModo: string);
    [Test] procedure E5_Consulta_ItemsXMLOriginal_NaoDeveDuplicar;

    // ---- Persistência ----
    [Test] procedure E7_Banco_BlobComBytesDoXMLOriginal;
    [Test] procedure E7_Banco_AntiPadrao_MemoUnicodeComXMLOriginal_DuplicaCodificacao;
    [Test] procedure E7_Banco_MemoUnicodeComUTF8ToNativeString;

    // ---- Rastreio consolidado ----
    [Test] procedure Rastreio_FluxoCompleto;
  end;

implementation

uses
  Windows, ACBrDFeSSL, ACBrUtil.Strings, ACBrUtil.XMLHTML, ACBrUtil.FilesIO, ACBrNFeNotasFiscais,
  ACBrDFe.Conversao,
  uXmlTesteHelpers;

const
  NS = 'http://www.portalfiscal.inf.br/nfe';
  ARQ_CORRETO    = 'nfeProc_correto.xml';
  ARQ_CORROMPIDO = 'nfeProc_corrompido.xml';
  XMOTIVO_PROT   = 'Autorizado o uso da NF-e (homologação: ação)';

{ TTestFluxoNFe }

procedure TTestFluxoNFe.Setup;
begin
  FNFe := TACBrNFe.Create(nil);
  FModo := mrSincrono;
  FDadosEnviados := '';
  FDeclaracaoNaResposta := True;
  FxMotivo := XMOTIVO_PROT;
  Configurar;
end;

procedure TTestFluxoNFe.TearDown;
begin
  FNFe.Free;
end;

procedure TTestFluxoNFe.Configurar;
var
  Saida: string;
begin
  Saida := PastaSaida;
  with FNFe.Configuracoes do
  begin
    Geral.SSLLib := libCustom;
    Geral.SSLCryptLib := cryOpenSSL;
    Geral.SSLHttpLib := httpOpenSSL;
    Geral.SSLXmlSignLib := xsLibXml2;
    Geral.ValidarDigest := True;
    Geral.RetirarAcentos := False;            // padrão do ACBr é True (removeria os acentos)
    Certificados.ArquivoPFX := PastaDados + 'cert_teste.pfx';
    Certificados.Senha := '1234';

    WebServices.UF := 'SP';
    WebServices.Ambiente := taHomologacao;
    WebServices.Visualizar := False;
    WebServices.Salvar := True;               // grava envelopes de envio/retorno
    WebServices.AguardarConsultaRet := 0;
    WebServices.IntervaloTentativas := 0;
    WebServices.Tentativas := 1;

    Arquivos.Salvar := True;
    Arquivos.PathSalvar := Saida + 'ws\';
    Arquivos.PathNFe := Saida + 'nfe\';
    Arquivos.PathSchemas := DiretorioACBr + 'Exemplos\ACBrDFe\Schemas\NFe\';
    Arquivos.IniServicos := DiretorioACBr + 'Fontes\ACBrDFe\ACBrNFe\ACBrNFeServicos.ini';
    Arquivos.SepararPorMes := False;
    Arquivos.SalvarApenasNFeProcessadas := False;
  end;
  FNFe.OnTransmit := OnTransmit;
end;

function TTestFluxoNFe.CopiarEntrada(const ANome: string): string;
begin
  { Copia para a pasta de saída: o ACBr regrava o arquivo carregado (NomeArq) após o retorno }
  Result := PastaSaida + 'entrada_' + ANome;
  ForceDirectories(ExtractFilePath(Result));
  CopyFile(PChar(PastaDados + ANome), PChar(Result), False);
end;

procedure TTestFluxoNFe.CarregarEAcentuar;
begin
  FNFe.NotasFiscais.Clear;
  FNFe.NotasFiscais.LoadFromFile(CopiarEntrada(ARQ_CORRETO));
  with FNFe.NotasFiscais.Items[0].NFe do
  begin
    Ide.natOp := TXT_NATOP;
    Det[0].Prod.xProd := TXT_XPROD;
    InfAdic.infCpl := TXT_ACENTOS;
  end;
end;

procedure TTestFluxoNFe.EnviarSincrono;
begin
  CarregarEAcentuar;
  FModo := mrSincrono;
  FNFe.NotasFiscais.Assinar;
  Assert.IsTrue(FNFe.WebServices.Envia(1, True), 'Envio síncrono simulado não foi processado');
end;

function TTestFluxoNFe.ArquivoGravado: string;
begin
  Result := FNFe.NotasFiscais.Items[0].NomeArq;
end;

function TTestFluxoNFe.ProtNFe: string;
begin
  Result :=
    '<protNFe versao="4.00"><infProt>' +
      '<tpAmb>2</tpAmb><verAplic>SP_NFE_PL009_V4</verAplic>' +
      '<chNFe>' + FChave + '</chNFe>' +
      '<dhRecbto>2026-11-10T09:00:38-03:00</dhRecbto>' +
      '<nProt>135260009910632</nProt>' +
      '<digVal>' + FDigestEnviado + '</digVal>' +
      '<cStat>100</cStat><xMotivo>' + FxMotivo + '</xMotivo>' +
    '</infProt></protNFe>';
end;

function TTestFluxoNFe.Envelope(const AConteudo: string): string;
begin
  Result :=
    '<soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" ' +
    'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
    '<soap:Body><nfeResultMsg xmlns="http://www.portalfiscal.inf.br/nfe/wsdl/x">' +
    AConteudo + '</nfeResultMsg></soap:Body></soap:Envelope>';
  if FDeclaracaoNaResposta then
    Result := '<?xml version="1.0" encoding="utf-8"?>' + Result;
end;

procedure TTestFluxoNFe.OnTransmit(const Dados, URL, SoapAction, MimeType: String;
  var Resposta: String; var HTTPResultCode: Integer; var InternalErrorCode: Integer);
var
  R: string;
begin
  if Pos('<DigestValue>', Dados) > 0 then
  begin
    FDadosEnviados := Dados;
    FDigestEnviado := RetornarConteudoEntre(Dados, '<DigestValue>', '</DigestValue>');
    FChave := RetornarConteudoEntre(Dados, 'Id="NFe', '"');
  end;
  if FChave = '' then
    FChave := RetornarConteudoEntre(Dados, '<chNFe>', '</chNFe>');

  if (FModo = mrConsulta) then
    R := '<retConsSitNFe xmlns="' + NS + '" versao="4.00"><tpAmb>2</tpAmb>' +
         '<verAplic>SP_NFE_PL009_V4</verAplic><cStat>100</cStat>' +
         '<xMotivo>Autorizado o uso da NF-e</xMotivo><cUF>35</cUF>' +
         '<dhRecbto>2026-11-10T09:01:00-03:00</dhRecbto><chNFe>' + FChave + '</chNFe>' +
         ProtNFe + '</retConsSitNFe>'
  else if (FModo = mrAssincrono) and (Pos('<consReciNFe', Dados) = 0) then
    R := '<retEnviNFe xmlns="' + NS + '" versao="4.00"><tpAmb>2</tpAmb>' +
         '<verAplic>SP_NFE_PL009_V4</verAplic><cStat>103</cStat>' +
         '<xMotivo>Lote recebido com sucesso</xMotivo><cUF>35</cUF>' +
         '<dhRecbto>2026-11-10T09:00:38-03:00</dhRecbto>' +
         '<infRec><nRec>351000000000001</nRec><tMed>1</tMed></infRec></retEnviNFe>'
  else if (FModo = mrAssincrono) then
    R := '<retConsReciNFe xmlns="' + NS + '" versao="4.00"><tpAmb>2</tpAmb>' +
         '<verAplic>SP_NFE_PL009_V4</verAplic><nRec>351000000000001</nRec>' +
         '<cStat>104</cStat><xMotivo>Lote processado</xMotivo><cUF>35</cUF>' +
         '<dhRecbto>2026-11-10T09:00:39-03:00</dhRecbto>' + ProtNFe + '</retConsReciNFe>'
  else
    R := '<retEnviNFe xmlns="' + NS + '" versao="4.00"><tpAmb>2</tpAmb>' +
         '<verAplic>SP_NFE_PL009_V4</verAplic><cStat>104</cStat>' +
         '<xMotivo>Lote processado</xMotivo><cUF>35</cUF>' +
         '<dhRecbto>2026-11-10T09:00:38-03:00</dhRecbto>' + ProtNFe + '</retEnviNFe>';

  // Igual ao HTTP real: bytes UTF-8 lidos para String via ReadStrFromStream (UTF8 ACBr)
  Resposta := string(NativeStringToUTF8(Envelope(R)));
  HTTPResultCode := 200;
  InternalErrorCode := 0;
end;

{ ---------------- E1: Carregamento ---------------- }

procedure TTestFluxoNFe.E1_LoadFromFile_XMLCorreto_XMLOriginalUTF8EObjetoNativo;
var
  It: NotaFiscal;
  C: TCodificacao;
begin
  FNFe.NotasFiscais.LoadFromFile(CopiarEntrada(ARQ_CORRETO));
  It := FNFe.NotasFiscais.Items[0];
  C := ClassificarStringACBr(It.XMLOriginal, TXT_NATOP);
  LogEtapa('E1 LoadFromFile(correto)', 'Items[0].XMLOriginal', C);
  Assert.AreEqual(NOMES_COD[cdUTF8Correto], NOMES_COD[C]);
  Assert.AreEqual(TXT_NATOP, It.NFe.Ide.natOp, 'Objeto NFe deve ter string nativa correta');
  Assert.AreEqual(TXT_XPROD, It.NFe.Det[0].Prod.xProd);
  Assert.IsTrue(It.VerificarAssinatura, 'Assinatura do XML correto deveria ser válida: ' + It.ErroValidacao);
end;

procedure TTestFluxoNFe.E1_LoadFromFile_XMLCorrompido_AssinaturaInvalida;
var
  It: NotaFiscal;
begin
  { Comprova que os XMLs anexados como "inválidos" têm assinatura quebrada:
    o DigestValue foi calculado sobre o texto CORRETO, a corrupção veio depois. }
  FNFe.NotasFiscais.LoadFromFile(CopiarEntrada(ARQ_CORROMPIDO));
  It := FNFe.NotasFiscais.Items[0];
  LogEtapa('E1 LoadFromFile(corrompido)', 'NFe.Ide.natOp = "' + It.NFe.Ide.natOp + '"',
    ClassificarStringNativa(It.NFe.Ide.natOp, TXT_NATOP));
  LogLinha('  [E1 LoadFromFile(corrompido)] VerificarAssinatura = ' +
    BoolToStr(It.VerificarAssinatura, True));
  Assert.IsFalse(It.VerificarAssinatura,
    'XML corrompido deveria ter assinatura inválida (conteúdo alterado após assinar)');
  Assert.AreNotEqual(TXT_NATOP, It.NFe.Ide.natOp);
end;

procedure TTestFluxoNFe.E1_LoadFromFile_NFeAssinadaSemDeclaracao;
var
  Conteudo: RawByteString;
  Arq: string;
  FS: TFileStream;
  C: TCodificacao;
  P1, P2: Integer;
begin
  { Somente <NFe>...</NFe> (assinada), bytes UTF-8, SEM declaração <?xml?> }
  Conteudo := BytesDeArquivo(PastaDados + ARQ_CORRETO);
  P1 := Pos(AnsiString('<NFe '), Conteudo);
  P2 := Pos(AnsiString('</NFe>'), Conteudo);
  Conteudo := Copy(Conteudo, P1, P2 - P1 + 6);
  Arq := PastaSaida + 'nfe_assinada_sem_declaracao.xml';
  FS := TFileStream.Create(Arq, fmCreate);
  try
    FS.WriteBuffer(Conteudo[1], Length(Conteudo));
  finally
    FS.Free;
  end;

  FNFe.NotasFiscais.LoadFromFile(Arq);
  C := ClassificarStringACBr(FNFe.NotasFiscais.Items[0].XMLOriginal, TXT_NATOP);
  LogEtapa('E1 LoadFromFile(sem decl.)', 'Items[0].XMLOriginal', C,
    'natOp="' + FNFe.NotasFiscais.Items[0].NFe.Ide.natOp + '"');
  Assert.AreEqual(TXT_NATOP, FNFe.NotasFiscais.Items[0].NFe.Ide.natOp);
  Assert.AreEqual(NOMES_COD[cdUTF8Correto], NOMES_COD[C]);
  Assert.IsTrue(FNFe.NotasFiscais.Items[0].VerificarAssinatura,
    'Assinatura deveria continuar válida: ' + FNFe.NotasFiscais.Items[0].ErroValidacao);
end;

procedure TTestFluxoNFe.E1_LoadFromString_XMLNativoSemDeclaracao;
var
  Nativo: string;
  C: TCodificacao;
begin
  { XML como string nativa (ex.: lido de um campo Unicode do banco), sem declaração }
  Nativo := RemoverDeclaracaoXML(UTF8ToNativeString(AnsiString(BytesDeArquivo(PastaDados + ARQ_CORRETO))));
  FNFe.NotasFiscais.LoadFromString(Nativo);
  C := ClassificarStringACBr(FNFe.NotasFiscais.Items[0].XMLOriginal, TXT_NATOP);
  LogEtapa('E1 LoadFromString(nativo)', 'Items[0].XMLOriginal', C);
  Assert.AreEqual(TXT_NATOP, FNFe.NotasFiscais.Items[0].NFe.Ide.natOp);
  Assert.AreEqual(NOMES_COD[cdUTF8Correto], NOMES_COD[C]);
end;

procedure TTestFluxoNFe.E1_LoadFromFile_GravarXML_RoundTripIdentico;
var
  Orig, Gravado: RawByteString;
  Arq: string;
  MS: TMemoryStream;
  Bs: RawByteString;
begin
  FNFe.NotasFiscais.LoadFromFile(CopiarEntrada(ARQ_CORRETO));
  Arq := PastaSaida + 'roundtrip_gravarxml.xml';
  FNFe.NotasFiscais.Items[0].GravarXML(ExtractFileName(Arq), ExtractFilePath(Arq));
  Orig := BytesDeArquivo(PastaDados + ARQ_CORRETO);
  Gravado := BytesDeArquivo(Arq);
  LogEtapa('E1 GravarXML (round-trip)', 'bytes do arquivo regravado', ClassificarBytes(Gravado, TXT_NATOP),
    'idêntico ao original: ' + BoolToStr(Orig = Gravado, True));
  Assert.IsTrue(Orig = Gravado, 'GravarXML alterou os bytes do XML carregado');

  MS := TMemoryStream.Create;
  try
    FNFe.NotasFiscais.Items[0].GravarStream(MS);
    SetLength(Bs, MS.Size);
    MS.Position := 0;
    MS.ReadBuffer(Bs[1], MS.Size);
    Assert.AreEqual(NOMES_COD[cdUTF8Correto], NOMES_COD[ClassificarBytes(Bs, TXT_NATOP)], 'GravarStream');
  finally
    MS.Free;
  end;
end;

{ ---------------- E2/E3: Assinatura e envio ---------------- }

procedure TTestFluxoNFe.E2_Assinar_XMLAssinadoUTF8EAssinaturaValida;
var
  It: NotaFiscal;
  C: TCodificacao;
begin
  CarregarEAcentuar;
  FNFe.NotasFiscais.Assinar;
  It := FNFe.NotasFiscais.Items[0];
  C := ClassificarStringACBr(It.XMLAssinado, TXT_ACENTOS);
  LogEtapa('E2 Assinar', 'Items[0].XMLAssinado', C,
    'declaração: ' + BoolToStr(XmlEhUTF8(It.XMLAssinado), True));
  Assert.AreEqual(NOMES_COD[cdUTF8Correto], NOMES_COD[C]);
  Assert.IsTrue(It.VerificarAssinatura, 'Assinatura recém-gerada inválida: ' + It.ErroValidacao);
end;

procedure TTestFluxoNFe.E3_Envio_DadosTransmitidosUTF8Correto;
var
  C: TCodificacao;
begin
  EnviarSincrono;
  C := ClassificarStringACBr(FDadosEnviados, TXT_ACENTOS);
  LogEtapa('E3 Envio (OnTransmit.Dados)', 'envelope SOAP enviado à SEFAZ', C);
  Assert.AreEqual(NOMES_COD[cdUTF8Correto], NOMES_COD[C]);
end;

{ ---------------- E4/E5/E6/E8: Retorno ---------------- }

procedure TTestFluxoNFe.E4_RetornoSincrono_RetWSUTF8Correto;
var
  C: TCodificacao;
begin
  EnviarSincrono;
  C := ClassificarStringACBr(FNFe.WebServices.Enviar.RetWS, XMOTIVO_PROT);
  LogEtapa('E4 Retorno (RetWS)', 'WebServices.Enviar.RetWS', C);
  Assert.AreEqual(NOMES_COD[cdUTF8Correto], NOMES_COD[C]);
  Assert.AreEqual(100, FNFe.NotasFiscais.Items[0].NFe.procNFe.cStat);
end;

procedure TTestFluxoNFe.E5_RetornoSincrono_ItemsXMLOriginal_NaoDeveDuplicar;
var
  It: NotaFiscal;
  C, CProt: TCodificacao;
begin
  EnviarSincrono;
  It := FNFe.NotasFiscais.Items[0];
  C := ClassificarStringACBr(It.XMLOriginal, TXT_ACENTOS);
  CProt := ClassificarStringACBr(It.XMLOriginal, XMOTIVO_PROT);
  LogEtapa('E5 Retorno síncrono', 'Items[0].XMLOriginal (trecho NFe)', C,
    'bytes: ' + HexTrecho(BytesDeStringACBr(It.XMLOriginal), TXT_ACENTOS));
  LogEtapa('E5 Retorno síncrono', 'Items[0].XMLOriginal (trecho protNFe)', CProt);
  Assert.AreEqual(NOMES_COD[cdUTF8Correto], NOMES_COD[C],
    'nfeProc em NotasFiscais.Items[0].XMLOriginal foi recodificado após o retorno');
  Assert.AreEqual(NOMES_COD[cdUTF8Correto], NOMES_COD[CProt], 'trecho protNFe');
end;

procedure TTestFluxoNFe.E6_RetornoSincrono_ArquivoGravado_NaoDeveDuplicar;
var
  C: TCodificacao;
begin
  EnviarSincrono;
  C := ClassificarBytes(BytesDeArquivo(ArquivoGravado), TXT_ACENTOS);
  LogEtapa('E6 Arquivo gravado', ExtractFileName(ArquivoGravado), C);
  Assert.AreEqual(NOMES_COD[cdUTF8Correto], NOMES_COD[C]);
end;

procedure TTestFluxoNFe.E5_RetornoSincrono_XMLProtocolo_XMLAssinado_XML_Integros;
var
  It: NotaFiscal;
  N2: TACBrNFe;
begin
  EnviarSincrono;
  It := FNFe.NotasFiscais.Items[0];
  LogEtapa('E5 XML protocolo', 'NFe.procNFe.XML_prot', ClassificarStringACBr(It.NFe.procNFe.XML_prot, XMOTIVO_PROT));
  LogEtapa('E5 XML protocolo', 'WebServices.Enviar... xMotivo (nativo)', ClassificarStringNativa(It.NFe.procNFe.xMotivo, XMOTIVO_PROT));
  LogEtapa('E5 XMLAssinado', 'Items[0].XMLAssinado após retorno', ClassificarStringACBr(It.XMLAssinado, TXT_ACENTOS));
  LogEtapa('E5 XML', 'Items[0].XML após retorno', ClassificarStringACBr(It.XML, TXT_ACENTOS));
  Assert.AreEqual(NOMES_COD[cdUTF8Correto], NOMES_COD[ClassificarStringACBr(It.NFe.procNFe.XML_prot, XMOTIVO_PROT)], 'XML_prot');
  Assert.AreEqual(XMOTIVO_PROT, It.NFe.procNFe.xMotivo, 'procNFe.xMotivo');
  Assert.AreEqual(NOMES_COD[cdUTF8Correto], NOMES_COD[ClassificarStringACBr(It.XMLAssinado, TXT_ACENTOS)], 'XMLAssinado');
  Assert.AreEqual(NOMES_COD[cdUTF8Correto], NOMES_COD[ClassificarStringACBr(It.XML, TXT_ACENTOS)], 'XML');
  Assert.AreEqual(1, Pos('<?xml version="1.0" encoding="UTF-8"?>', It.XMLOriginal), 'declaração no início');
  Assert.AreEqual(0, Pos('<?xml', Copy(It.XMLOriginal, 2, MaxInt)), 'declaração duplicada');
  // Recarregar o nfeProc gerado: objeto com acentos corretos e assinatura válida
  N2 := TACBrNFe.Create(nil);
  try
    N2.Configuracoes.Geral.SSLLib := libCustom;
    N2.Configuracoes.Geral.SSLCryptLib := cryOpenSSL;
    N2.Configuracoes.Geral.SSLXmlSignLib := xsLibXml2;
    N2.NotasFiscais.LoadFromString(It.XMLOriginal);
    Assert.AreEqual(TXT_ACENTOS, N2.NotasFiscais.Items[0].NFe.InfAdic.infCpl, 'infCpl recarregado');
    Assert.AreEqual(XMOTIVO_PROT, N2.NotasFiscais.Items[0].NFe.procNFe.xMotivo, 'xMotivo recarregado');
    Assert.IsTrue(N2.NotasFiscais.Items[0].VerificarAssinatura, 'assinatura do nfeProc recarregado');
  finally
    N2.Free;
  end;
end;

procedure TTestFluxoNFe.E8_RetornoSincrono_AssinaturaDoNfeProcContinuaValida;
var
  N2: TACBrNFe;
  Ok: Boolean;
begin
  EnviarSincrono;
  N2 := TACBrNFe.Create(nil);
  try
    N2.Configuracoes.Geral.SSLLib := libCustom;
    N2.Configuracoes.Geral.SSLCryptLib := cryOpenSSL;
    N2.Configuracoes.Geral.SSLXmlSignLib := xsLibXml2;
    N2.NotasFiscais.LoadFromFile(ArquivoGravado);
    Ok := N2.NotasFiscais.Items[0].VerificarAssinatura;
    LogLinha('  [E8 Assinatura nfeProc gravado] VerificarAssinatura = ' + BoolToStr(Ok, True));
    Assert.IsTrue(Ok, 'Assinatura do nfeProc gravado ficou inválida: ' + N2.NotasFiscais.Items[0].ErroValidacao);
  finally
    N2.Free;
  end;
end;

procedure TTestFluxoNFe.E5_RetornoAssincrono_ItemsXMLOriginal_NaoDeveDuplicar;
var
  C: TCodificacao;
begin
  { xMotivo SEM acento no retorno, para isolar a montagem do nfeProc
    (TNFeRetRecepcao.TratarRespostaFinal) do problema de leitura do retorno }
  FxMotivo := 'Autorizado o uso da NF-e';
  CarregarEAcentuar;
  FModo := mrAssincrono;
  FNFe.NotasFiscais.Assinar;
  Assert.IsTrue(FNFe.WebServices.Envia(1, False), 'Envio assíncrono simulado não foi processado');
  C := ClassificarStringACBr(FNFe.NotasFiscais.Items[0].XMLOriginal, TXT_ACENTOS);
  LogEtapa('E5 Retorno assíncrono', 'Items[0].XMLOriginal (TNFeRetRecepcao)', C);
  Assert.AreEqual(NOMES_COD[cdUTF8Correto], NOMES_COD[C]);
end;

procedure TTestFluxoNFe.E4_Retorno_xMotivoComEntidadesXML_DeveSerLido(const AModo: string);
const
  ESPERADO = 'Autorizado: A & B <teste> "ok" ação';
var
  Msg, Lido: string;
  C: TCodificacao;
begin
  { Retorno com entidades XML no xMotivo. Se algo decodificar as entidades ANTES
    do libxml2 (ParseText/DecodeHTMLEntities), o XML fica inválido ou misto. }
  FxMotivo := 'Autorizado: A &amp; B &lt;teste&gt; &quot;ok&quot; a&#231;&#227;o';
  CarregarEAcentuar;
  if AModo = 'A' then FModo := mrAssincrono else FModo := mrSincrono;
  FNFe.NotasFiscais.Assinar;
  Msg := '';
  try
    FNFe.WebServices.Envia(1, AModo = 'S');
  except
    on E: Exception do
      Msg := E.ClassName + ': ' + E.Message;
  end;
  Lido := FNFe.NotasFiscais.Items[0].NFe.procNFe.xMotivo;
  C := ClassificarStringACBr(FNFe.NotasFiscais.Items[0].XMLOriginal, TXT_ACENTOS);
  LogLinha('  [E4 Entidades ' + AModo + '] exceção="' + Msg + '" xMotivo="' + Lido +
    '" nfeProc=' + NOMES_COD[C]);
  Assert.AreEqual('', Msg, 'Retorno com entidades XML não pôde ser lido');
  Assert.AreEqual(ESPERADO, Lido, 'xMotivo');
  Assert.AreEqual(NOMES_COD[cdUTF8Correto], NOMES_COD[C], 'nfeProc');
end;

procedure TTestFluxoNFe.E4_RetornoAssincrono_xMotivoAcentuado_DeveSerLido;
var
  Msg: string;
begin
  { TNFeRetRecepcao.TratarResposta faz UTF8ToNativeString(ParseText(FPRetWS)) e
    TRetConsReciDFe.LerXml chama Document.LoadFromXml(AnsiString(nativa)) ->
    bytes CP1252 -> libxml2 rejeita ("Input is not proper UTF-8"). }
  FxMotivo := XMOTIVO_PROT;
  CarregarEAcentuar;
  FModo := mrAssincrono;
  FNFe.NotasFiscais.Assinar;
  Msg := '';
  try
    FNFe.WebServices.Envia(1, False);
  except
    on E: Exception do
      Msg := E.ClassName + ': ' + E.Message;
  end;
  LogLinha('  [E4 Retorno assíncrono c/ acento] exceção = "' + Msg + '"; xMotivo lido = "' +
    FNFe.WebServices.Retorno.xMotivo + '"');
  Assert.AreEqual('', Msg, 'Retorno assíncrono com acento não pôde ser lido');
  Assert.AreEqual(100, FNFe.NotasFiscais.Items[0].NFe.procNFe.cStat);
end;

procedure TTestFluxoNFe.E5_Consulta_ItemsXMLOriginal_NaoDeveDuplicar;
var
  It: NotaFiscal;
  C: TCodificacao;
begin
  FNFe.NotasFiscais.LoadFromFile(CopiarEntrada(ARQ_CORRETO));
  It := FNFe.NotasFiscais.Items[0];
  FChave := It.NumID;
  FDigestEnviado := It.NFe.signature.DigestValue;
  FModo := mrConsulta;
  FNFe.Consultar;
  C := ClassificarStringACBr(It.XMLOriginal, TXT_NATOP);
  LogEtapa('E5 Consulta', 'Items[0].XMLOriginal (TNFeConsulta)', C);
  Assert.AreEqual(NOMES_COD[cdUTF8Correto], NOMES_COD[C]);
end;

{ ---------------- E7: Persistência ("banco de dados") ---------------- }

procedure TTestFluxoNFe.E7_Banco_BlobComBytesDoXMLOriginal;
var
  Blob: TBytesStream;
  B: RawByteString;
begin
  { Campo BLOB/VARBINARY recebendo os bytes: AnsiString(XMLOriginal) }
  FNFe.NotasFiscais.LoadFromFile(CopiarEntrada(ARQ_CORRETO));  // XML íntegro (isola o padrão de persistência)
  B := BytesDeStringACBr(FNFe.NotasFiscais.Items[0].XMLOriginal);
  Blob := TBytesStream.Create;
  try
    Blob.WriteBuffer(B[1], Length(B));
    SetString(B, PAnsiChar(Blob.Bytes), Blob.Size);
    LogEtapa('E7 Banco BLOB', 'AnsiString(Items[0].XMLOriginal)', ClassificarBytes(B, TXT_NATOP));
    Assert.AreEqual(NOMES_COD[cdUTF8Correto], NOMES_COD[ClassificarBytes(B, TXT_NATOP)]);
  finally
    Blob.Free;
  end;
end;

procedure TTestFluxoNFe.E7_Banco_AntiPadrao_MemoUnicodeComXMLOriginal_DuplicaCodificacao;
var
  CampoMemo: string;     // simula NVARCHAR/WideMemo/TEXT UTF-8
  SL: TStringList;
  Arq: string;
  C: TCodificacao;
begin
  { Padrão de APLICAÇÃO frequente: grava Items[0].XML (string "UTF8 ACBr") num
    campo texto Unicode e depois exporta com TEncoding.UTF8.
    Mesmo com o ACBr correto, isto gera dupla codificação. }
  FNFe.NotasFiscais.LoadFromFile(CopiarEntrada(ARQ_CORRETO));  // XML íntegro (isola o padrão de persistência)
  CampoMemo := FNFe.NotasFiscais.Items[0].XML;
  SL := TStringList.Create;
  try
    SL.Text := CampoMemo;
    Arq := PastaSaida + 'banco_memo_xml_direto.xml';
    SL.WriteBOM := False;
    SL.SaveToFile(Arq, TEncoding.UTF8);
  finally
    SL.Free;
  end;
  C := ClassificarBytes(BytesDeArquivo(Arq), TXT_NATOP);
  LogEtapa('E7 Banco MEMO Unicode', 'campo := Items[0].XML; SaveToFile(UTF8)', C);
  { DOCUMENTA um anti-padrão de aplicação (independente do bug do ACBr) }
  Assert.AreEqual(NOMES_COD[cdUTF8Duplo], NOMES_COD[C]);
end;

procedure TTestFluxoNFe.E7_Banco_MemoUnicodeComUTF8ToNativeString;
var
  CampoMemo: string;
  SL: TStringList;
  Arq: string;
  C: TCodificacao;
begin
  { Forma correta para campo texto Unicode: converter para string nativa antes }
  FNFe.NotasFiscais.LoadFromFile(CopiarEntrada(ARQ_CORRETO));  // XML íntegro (isola o padrão de persistência)
  CampoMemo := UTF8ToNativeString(AnsiString(FNFe.NotasFiscais.Items[0].XML));
  SL := TStringList.Create;
  try
    SL.Text := CampoMemo;
    Arq := PastaSaida + 'banco_memo_nativo.xml';
    SL.WriteBOM := False;
    SL.SaveToFile(Arq, TEncoding.UTF8);
  finally
    SL.Free;
  end;
  C := ClassificarBytes(BytesDeArquivo(Arq), TXT_NATOP);
  LogEtapa('E7 Banco MEMO nativo', 'campo := UTF8ToNativeString(XML)', C);
  Assert.AreEqual(NOMES_COD[cdUTF8Correto], NOMES_COD[C]);
end;

{ ---------------- Rastreio consolidado ---------------- }

procedure TTestFluxoNFe.Rastreio_FluxoCompleto;
var
  It: NotaFiscal;
  Falhas: string;

  procedure Etapa(const ANome, ADesc: string; ACod: TCodificacao);
  begin
    LogEtapa(ANome, ADesc, ACod);
    if ACod <> cdUTF8Correto then
      Falhas := Falhas + sLineBreak + '  -> ' + ANome + ': ' + ADesc + ' = ' + NOMES_COD[ACod];
  end;

begin
  Falhas := '';
  LogLinha('');
  LogLinha('========== RASTREIO DO FLUXO (texto: "' + TXT_ACENTOS + '") ==========');
  CarregarEAcentuar;
  It := FNFe.NotasFiscais.Items[0];
  Etapa('1 Load', 'Items[0].XMLOriginal (natOp do arquivo)', ClassificarStringACBr(It.XMLOriginal, TXT_NATOP));
  Etapa('1 Load', 'NFe.Ide.natOp (objeto, nativo)', ClassificarStringNativa(It.NFe.Ide.natOp, TXT_NATOP));

  It.GerarXML;
  Etapa('2 GerarXML', 'Items[0].XMLOriginal', ClassificarStringACBr(It.XMLOriginal, TXT_ACENTOS));

  FNFe.NotasFiscais.Assinar;
  Etapa('3 Assinar', 'Items[0].XMLAssinado', ClassificarStringACBr(It.XMLAssinado, TXT_ACENTOS));

  FModo := mrSincrono;
  FNFe.WebServices.Envia(1, True);
  Etapa('4 Envio', 'WebServices.Enviar.DadosMsg', ClassificarStringACBr(FNFe.WebServices.Enviar.DadosMsg, TXT_ACENTOS));
  Etapa('4 Envio', 'OnTransmit.Dados (envelope)', ClassificarStringACBr(FDadosEnviados, TXT_ACENTOS));
  Etapa('5 Retorno', 'WebServices.Enviar.RetWS', ClassificarStringACBr(FNFe.WebServices.Enviar.RetWS, XMOTIVO_PROT));
  Etapa('5 Retorno', 'NFe.procNFe.xMotivo (nativo)', ClassificarStringNativa(It.NFe.procNFe.xMotivo, XMOTIVO_PROT));
  Etapa('6 Items[0]', 'XMLOriginal (nfeProc) trecho NFe', ClassificarStringACBr(It.XMLOriginal, TXT_ACENTOS));
  Etapa('6 Items[0]', 'XMLOriginal (nfeProc) trecho protNFe', ClassificarStringACBr(It.XMLOriginal, XMOTIVO_PROT));
  Etapa('6 Items[0]', 'XMLAssinado', ClassificarStringACBr(It.XMLAssinado, TXT_ACENTOS));
  Etapa('7 Arquivo', ExtractFileName(ArquivoGravado), ClassificarBytes(BytesDeArquivo(ArquivoGravado), TXT_ACENTOS));
  Etapa('8 Banco BLOB', 'AnsiString(Items[0].XML)', ClassificarBytes(BytesDeStringACBr(It.XML), TXT_ACENTOS));
  LogLinha('=================================================================');

  Assert.AreEqual('', Falhas, 'Corrupção detectada nas etapas:' + Falhas);
end;

initialization
  TDUnitX.RegisterTestFixture(TTestFluxoNFe);

end.
