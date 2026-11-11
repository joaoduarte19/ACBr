unit uTestNFe01Componente;

{ Métodos utilitários do TACBrNFe que não dependem de transmissão:
  modelo/namespace, classificação de cStat, leitura de parâmetros e URLs,
  schemas, QR-Code, chave de contingência, status e gravação de arquivos.
  Inclui as validações de erro (pré-condições) dos métodos de serviço. }

interface

uses
  DUnitX.TestFramework, SysUtils, Classes, ACBrNFe;

type
  [TestFixture]
  TTestNFeComponente = class
  private
    FNFe: TACBrNFe;
    FMudouStatus: Integer;
    procedure StatusMudou(Sender: TObject);
  public
    [Setup]    procedure Setup;
    [TearDown] procedure TearDown;

    [Test] procedure GetNomeModeloDFe_NFe;
    [Test] procedure GetNomeModeloDFe_NFCe;
    [Test] procedure GetNameSpaceURI_PortalFiscal;

    [Test]
    [TestCase('100 Autorizada', '100,True')]
    [TestCase('150 Autorizada fora prazo', '150,True')]
    [TestCase('204 Duplicidade', '204,False')]
    [TestCase('302 Denegada', '302,False')]
    procedure CstatConfirmada(const ACStat: Integer; AEsperado: Boolean);

    [Test]
    [TestCase('100', '100,True')]
    [TestCase('120', '120,True')]
    [TestCase('150', '150,True')]
    [TestCase('110 Denegada (ACBr nao considera processada)', '110,False')]
    [TestCase('301 Denegada (ACBr nao considera processada)', '301,False')]
    [TestCase('302 Denegada (ACBr nao considera processada)', '302,False')]
    [TestCase('204', '204,False')]
    procedure CstatProcessado(const ACStat: Integer; AEsperado: Boolean);

    [Test]
    [TestCase('101 Cancelada', '101,True')]
    [TestCase('151 Cancelada fora prazo', '151,True')]
    [TestCase('155 Cancelada fora prazo', '155,True')]
    [TestCase('135 Evento vinculado', '135,True')]
    [TestCase('100 Autorizada', '100,False')]
    procedure CstatCancelada(const ACStat: Integer; AEsperado: Boolean);

    [Test] procedure EhAutorizacao_NFe400_SP;
    [Test] procedure LerVersaoDeParams_Autorizacao_400;
    [Test] procedure LerServicoDeParams_RetornaURLHomologacaoSP;
    [Test] procedure IdentificaSchema_NFe_Evento_Inutilizacao;
    [Test] procedure GerarNomeArqSchema_Autorizacao;
    [Test] procedure GerarNomeArqSchemaEvento_CCe;
    [Test] procedure AjustarVersaoQRCode_NFe400;
    [Test] procedure GetURLConsultaNFCe_SPHomologacao;
    [Test] procedure GetURLQRCode_NFCe_ContemChave;
    [Test] procedure GerarChaveContingencia_FSDA;
    [Test] procedure SetStatus_DisparaOnStatusChange;
    [Test] procedure Gravar_ArquivoUTF8ComDeclaracao;

    // Pré-condições dos métodos de serviço
    [Test] procedure Enviar_SemNotas_GeraExcecao;
    [Test] procedure Enviar_MaisDe50Notas_GeraExcecao;
    [Test] procedure EnviarEvento_SemEventos_GeraExcecao;
    [Test] procedure Cancelamento_SemNotas_GeraExcecao;
    [Test] procedure ImprimirEventoPDF_SemDANFE_GeraExcecao;
    [Test] procedure ImprimirInutilizacaoPDF_SemDANFE_GeraExcecao;
    [Test] procedure ImprimirPDF_SemDANFE_GeraExcecao;
    [Test] procedure EnviarEmail_SemACBrMail_GeraExcecao;
  end;

implementation

uses
  ACBrNFe.Conversao, ACBrDFe.Conversao, ACBrNFe.Classes, ACBrNFeNotasFiscais,
  ACBrUtil.XMLHTML, ACBrUtil.Strings, uNFeTesteBase, uXmlTesteHelpers;

procedure TTestNFeComponente.Setup;
begin
  FNFe := CriarACBrNFe(55, nil, 'componente');
  FMudouStatus := 0;
end;

procedure TTestNFeComponente.TearDown;
begin
  FNFe.Free;
end;

procedure TTestNFeComponente.StatusMudou(Sender: TObject);
begin
  Inc(FMudouStatus);
end;

procedure TTestNFeComponente.GetNomeModeloDFe_NFe;
begin
  Assert.AreEqual('NFe', FNFe.GetNomeModeloDFe);
end;

procedure TTestNFeComponente.GetNomeModeloDFe_NFCe;
begin
  FNFe.Configuracoes.Geral.ModeloDF := moNFCe;
  Assert.AreEqual('NFCe', FNFe.GetNomeModeloDFe);
end;

procedure TTestNFeComponente.GetNameSpaceURI_PortalFiscal;
begin
  Assert.AreEqual('http://www.portalfiscal.inf.br/nfe', FNFe.GetNameSpaceURI);
end;

procedure TTestNFeComponente.CstatConfirmada(const ACStat: Integer; AEsperado: Boolean);
begin
  Assert.AreEqual(AEsperado, FNFe.CstatConfirmada(ACStat));
end;

procedure TTestNFeComponente.CstatProcessado(const ACStat: Integer; AEsperado: Boolean);
begin
  Assert.AreEqual(AEsperado, FNFe.CstatProcessado(ACStat));
end;

procedure TTestNFeComponente.CstatCancelada(const ACStat: Integer; AEsperado: Boolean);
begin
  Assert.AreEqual(AEsperado, FNFe.CstatCancelada(ACStat));
end;

procedure TTestNFeComponente.EhAutorizacao_NFe400_SP;
begin
  Assert.IsTrue(FNFe.EhAutorizacao(ve400, moNFe, 35));
end;

procedure TTestNFeComponente.LerVersaoDeParams_Autorizacao_400;
begin
  Assert.AreEqual('4.00', FNFe.LerVersaoDeParams(LayNfeAutorizacao));
end;

procedure TTestNFeComponente.LerServicoDeParams_RetornaURLHomologacaoSP;
var
  Versao: Double;
  URL, Servico, SoapAction: string;
begin
  Versao := 0;
  FNFe.LerServicoDeParams(LayNfeAutorizacao, Versao, URL, Servico, SoapAction);
  LogLinha('  LerServicoDeParams(Autorizacao) = ' + URL);
  Assert.IsTrue(Pos('homologacao.nfe.fazenda.sp.gov.br', LowerCase(URL)) > 0, URL);
  Assert.AreEqual(4.0, Versao, 0.001);
end;

procedure TTestNFeComponente.IdentificaSchema_NFe_Evento_Inutilizacao;
begin
  Assert.IsTrue(FNFe.IdentificaSchema('<NFe xmlns="x"><infNFe versao="4.00"/></NFe>') = schNFe, 'NFe');
  Assert.IsTrue(FNFe.IdentificaSchema('<inutNFe versao="4.00"><infInut/></inutNFe>') = schInutNFe, 'Inut');
  Assert.IsTrue(FNFe.IdentificaSchema('<envEvento><evento><infEvento><tpEvento>110111</tpEvento></infEvento></evento></envEvento>') = schEnvEventoCancNFe, 'Canc');
  Assert.IsTrue(FNFe.IdentificaSchema('<envEvento><evento><infEvento><tpEvento>110110</tpEvento></infEvento></evento></envEvento>') = schEnvCCe, 'CCe');
end;

procedure TTestNFeComponente.GerarNomeArqSchema_Autorizacao;
var
  S: string;
begin
  S := FNFe.GerarNomeArqSchema(LayNfeAutorizacao, 4.00);
  LogLinha('  GerarNomeArqSchema = ' + S);
  Assert.IsTrue(Pos('nfe_v4.00.xsd', S) > 0, S);
end;

procedure TTestNFeComponente.GerarNomeArqSchemaEvento_CCe;
var
  S: string;
begin
  S := FNFe.GerarNomeArqSchemaEvento(schEnvCCe, 1.00);
  LogLinha('  GerarNomeArqSchemaEvento = ' + S);
  Assert.IsTrue(Pos('e110110_v1.00.xsd', S) > 0, S);
end;

procedure TTestNFeComponente.AjustarVersaoQRCode_NFe400;
begin
  // Para 4.00 a versão mínima é veqr100; versões maiores são mantidas
  Assert.IsTrue(FNFe.AjustarVersaoQRCode(veqr000, ve400) = veqr100, 'veqr000 -> veqr100');
  Assert.IsTrue(FNFe.AjustarVersaoQRCode(veqr200, ve400) = veqr200, 'veqr200 mantido');
  Assert.IsTrue(FNFe.AjustarVersaoQRCode(veqr200, ve310) = veqr000, '3.10 -> veqr000');
end;

procedure TTestNFeComponente.GetURLConsultaNFCe_SPHomologacao;
var
  S: string;
begin
  FNFe.Configuracoes.Geral.ModeloDF := moNFCe;
  S := FNFe.GetURLConsultaNFCe(35, taHomologacao, 4.00);
  LogLinha('  URL consulta NFC-e SP = ' + S);
  Assert.IsTrue(Pos('fazenda.sp.gov.br', LowerCase(S)) > 0, S);
end;

procedure TTestNFeComponente.GetURLQRCode_NFCe_ContemChave;
var
  N: TACBrNFe;
  NF: NotaFiscal;
  S: string;
begin
  N := CriarACBrNFe(65, nil, 'componente');
  try
    NF := PreencherNFe(N, CenarioPorCodigo('65_RTC_INT_CF'));
    NF.GerarXML;
    S := N.GetURLQRCode(NF.NFe);
    LogLinha('  QR-Code = ' + S);
    Assert.IsTrue(Pos(NF.NumID, S) > 0, 'QR-Code deve conter a chave');
    Assert.IsTrue(Pos('p=', S) > 0, 'QR-Code deve conter o parâmetro p=');
  finally
    N.Free;
  end;
end;

procedure TTestNFeComponente.GerarChaveContingencia_FSDA;
var
  NF: NotaFiscal;
  S: string;
begin
  NF := PreencherNFe(FNFe, CenarioPorCodigo('55_SemRTC_INT_NCF'));
  NF.NFe.Ide.tpEmis := teFSDA;
  NF.GerarXML;
  S := FNFe.GerarChaveContingencia(NF.NFe);
  LogLinha('  Chave contingência = ' + S);
  Assert.AreEqual(36, Length(S), 'Chave de contingência FS-DA tem 36 dígitos');
end;

procedure TTestNFeComponente.SetStatus_DisparaOnStatusChange;
begin
  FNFe.OnStatusChange := StatusMudou;
  FNFe.SetStatus(stNFeStatusServico);
  Assert.IsTrue(FNFe.Status = stNFeStatusServico);
  FNFe.SetStatus(stIdle);
  Assert.AreEqual(2, FMudouStatus);
end;

procedure TTestNFeComponente.Gravar_ArquivoUTF8ComDeclaracao;
var
  Arq: string;
  B: RawByteString;
begin
  Arq := PastaSaidaTeste('componente') + 'gravar.xml';
  // Padrão: ConteudoEhUTF8 = True -> conteúdo já deve estar em UTF-8 (convenção ACBr)
  Assert.IsTrue(FNFe.Gravar(Arq, string(NativeStringToUTF8('<teste>' + TXT_ESPECIAL_CURTO + '</teste>'))));
  B := LerArquivoBytes(Arq);
  Assert.AreEqual(1, Pos(AnsiString('<?xml version="1.0" encoding="UTF-8"?>'), B), 'declaração');
  Assert.AreEqual(NOMES_COD[cdUTF8Correto], NOMES_COD[ClassificarBytes(B, 'ÁÉÍÓÚ ãõç')], 'UTF-8');
  // ConteudoEhUTF8 = False -> string nativa é convertida
  Assert.IsTrue(FNFe.Gravar(Arq, '<teste>' + TXT_ESPECIAL_CURTO + '</teste>', '', False));
  B := LerArquivoBytes(Arq);
  Assert.AreEqual(NOMES_COD[cdUTF8Correto], NOMES_COD[ClassificarBytes(B, 'ÁÉÍÓÚ ãõç')], 'nativa');
end;

procedure TTestNFeComponente.Enviar_SemNotas_GeraExcecao;
begin
  Assert.WillRaiseAny(procedure begin FNFe.Enviar(1, False, True) end);
end;

procedure TTestNFeComponente.Enviar_MaisDe50Notas_GeraExcecao;
var
  i: Integer;
begin
  for i := 1 to 51 do
    FNFe.NotasFiscais.Add;
  Assert.WillRaiseAny(procedure begin FNFe.Enviar(1, False, False) end);
end;

procedure TTestNFeComponente.EnviarEvento_SemEventos_GeraExcecao;
begin
  Assert.WillRaiseAny(procedure begin FNFe.EnviarEvento(1) end);
end;

procedure TTestNFeComponente.Cancelamento_SemNotas_GeraExcecao;
begin
  Assert.WillRaiseAny(procedure begin FNFe.Cancelamento('Justificativa de teste') end);
end;

procedure TTestNFeComponente.ImprimirEventoPDF_SemDANFE_GeraExcecao;
begin
  Assert.WillRaiseAny(procedure begin FNFe.ImprimirEventoPDF end);
end;

procedure TTestNFeComponente.ImprimirInutilizacaoPDF_SemDANFE_GeraExcecao;
begin
  Assert.WillRaiseAny(procedure begin FNFe.ImprimirInutilizacaoPDF end);
end;

procedure TTestNFeComponente.ImprimirPDF_SemDANFE_GeraExcecao;
begin
  PreencherNFe(FNFe, CenarioPadrao);
  Assert.WillRaiseAny(procedure begin FNFe.NotasFiscais.ImprimirPDF end);
end;

procedure TTestNFeComponente.EnviarEmail_SemACBrMail_GeraExcecao;
begin
  PreencherNFe(FNFe, CenarioPadrao);
  Assert.WillRaiseAny(procedure begin
    FNFe.NotasFiscais.Items[0].EnviarEmail('destino@exemplo.com.br', 'Assunto', nil, False);
  end);
end;

initialization
  TDUnitX.RegisterTestFixture(TTestNFeComponente);

end.
