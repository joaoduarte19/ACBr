unit uTestNFe04WebServices;

{ Todos os serviços SEFAZ do TACBrNFe com a SEFAZ simulada (uSefazMock).
  Em cada serviço verifica: requisição montada (bytes UTF-8 corretos),
  leitura do retorno (campos nativos com acentos) e efeitos colaterais
  (XMLOriginal/nfeProc, arquivos, eventos). }

interface

uses
  DUnitX.TestFramework, SysUtils, Classes, ACBrNFe, uSefazMock;

type
  [TestFixture]
  TTestNFeWebServices = class
  private
    FNFe: TACBrNFe;
    FMock: TSefazMock;
    procedure CriarComNota(const ACenario: string = '55_RTC_INT_NCF');
    procedure AssertRequisicaoUTF8(const ATexto: string);
  public
    [Setup]    procedure Setup;
    [TearDown] procedure TearDown;

    [Test] procedure StatusServico;

    [Test]
    [TestCase('55 RTC interna',           '55_RTC_INT_NCF')]
    [TestCase('55 sem RTC interestadual', '55_SemRTC_IES_CF')]
    [TestCase('55 RTC exportacao',        '55_RTC_EXT_NCF')]
    [TestCase('65 NFCe RTC',              '65_RTC_INT_CF')]
    procedure Enviar_Sincrono_Autorizada(const ACenario: string);

    [Test] procedure Enviar_Assincrono_Autorizada;
    [Test] procedure Enviar_Rejeicao_NaoConfirma;
    [Test] procedure Enviar_Denegada_NaoConfirmaNemProcessa;
    [Test] procedure Enviar_DigestDivergente_GeraExcecao;
    [Test] procedure Enviar_FalhaHTTP_GeraExcecao;
    [Test] procedure Enviar_RespostaSemDeclaracao;
    [Test] procedure Enviar_xMotivoComEntidades;
    [Test] procedure Enviar_SalvaArquivosDeEnvioERetorno;

    [Test] procedure Consultar_PorChave;

    { TACBrNFe.Consultar devolve True sempre que a SEFAZ responde; não olha o cStat.
      (TNFeConsulta.TratarResposta calcula o resultado, mas Consultar o ignora) }
    [Test]
    [TestCase('217 nao consta na base', '217')]
    [TestCase('302 denegada',           '302')]
    procedure Consultar_NotaNaoAutorizada_RetornoDoMetodo(const ACStat: Integer);
    [Test] procedure Consultar_NotaCarregada_AtualizaNfeProc;
    [Test] procedure Cancelamento_GeraEventoEVinculaNFe;
    [Test] procedure EnviarCartaCorrecao_TextoAcentuado;
    [Test] procedure EnviarEvento_ManifestacaoDestinatario;
    [Test] procedure Inutilizar;
    [Test] procedure ConsultaCadastro_NomeAcentuado;
    [Test] procedure DistribuicaoDFePorUltNSU;
    [Test] procedure DistribuicaoDFePorNSU;
    [Test] procedure DistribuicaoDFePorChaveNFe;
    [Test] procedure AdministrarCSC_NFCe;
    [Test] procedure ObterListaChaves_NFCeSP;
    [Test] procedure ObterDownloadXml_NFCeSP;
    [Test] procedure GravarStream_Evento;
  end;

implementation

uses
  ACBrNFeNotasFiscais, ACBrNFe.Classes, ACBrNFe.Conversao, ACBrDFe.Conversao,
  ACBrNFe.EventoClass, ACBrUtil.Strings, ACBrUtil.XMLHTML,
  uNFeTesteBase, uXmlTesteHelpers;

procedure TTestNFeWebServices.Setup;
begin
  FMock := TSefazMock.Create;
  FNFe := nil;
end;

procedure TTestNFeWebServices.TearDown;
begin
  FreeAndNil(FNFe);
  FreeAndNil(FMock);
end;

procedure TTestNFeWebServices.CriarComNota(const ACenario: string);
var
  C: TCenarioNFe;
begin
  FreeAndNil(FNFe);
  C := CenarioPorCodigo(ACenario);
  FNFe := CriarACBrNFe(C.Modelo, FMock, 'ws\' + ACenario);
  PreencherNFe(FNFe, C);
end;

procedure TTestNFeWebServices.AssertRequisicaoUTF8(const ATexto: string);
var
  C: TCodificacao;
begin
  C := ClassificarStringACBr(FMock.UltimosDados, ATexto);
  LogEtapa('Requisição ' + NomeServico(FMock.UltimoServico), 'envelope SOAP', C);
  Assert.AreEqual(NOMES_COD[cdUTF8Correto], NOMES_COD[C], 'Requisição ' + NomeServico(FMock.UltimoServico));
end;

procedure TTestNFeWebServices.StatusServico;
begin
  FNFe := CriarACBrNFe(55, FMock, 'ws');
  Assert.IsTrue(FNFe.WebServices.StatusServico.Executar);
  Assert.AreEqual(107, FNFe.WebServices.StatusServico.cStat);
  Assert.AreEqual('Serviço em Operação', FNFe.WebServices.StatusServico.xMotivo, 'xMotivo nativo');
  Assert.IsTrue(FMock.UltimoServico = ssStatus);
end;

procedure TTestNFeWebServices.Enviar_Sincrono_Autorizada(const ACenario: string);
var
  NF: NotaFiscal;
  C: TCodificacao;
begin
  CriarComNota(ACenario);
  FMock.xMotivoProtocolo := 'Autorizado o uso da NF-e – ação';
  Assert.IsTrue(FNFe.Enviar(1, False, True), 'Enviar: ' + FNFe.WebServices.Enviar.Msg);
  NF := FNFe.NotasFiscais.Items[0];
  AssertRequisicaoUTF8('ÀÈÌÒÙ âêîôû');
  Assert.IsTrue(NF.Confirmada, 'Confirmada');
  Assert.IsTrue(NF.Processada, 'Processada');
  Assert.AreEqual(100, NF.cStat);
  Assert.AreEqual(NPROT_TESTE, NF.NFe.procNFe.nProt);
  Assert.AreEqual(FMock.xMotivoProtocolo, NF.Msg, 'Msg (xMotivo nativo)');
  C := ClassificarStringACBr(NF.XMLOriginal, 'ÀÈÌÒÙ âêîôû');
  LogEtapa(ACenario, 'nfeProc em XMLOriginal', C);
  Assert.AreEqual(NOMES_COD[cdUTF8Correto], NOMES_COD[C], 'nfeProc');
  Assert.AreEqual(1, Pos('<?xml version="1.0" encoding="UTF-8"?><nfeProc', NF.XMLOriginal), 'início do nfeProc');
  Assert.AreEqual(1, ContarOcorrencias('<?xml', NF.XMLOriginal), 'uma declaração');
  Assert.IsTrue(NF.VerificarAssinatura, NF.ErroValidacao);
end;

procedure TTestNFeWebServices.Enviar_Assincrono_Autorizada;
var
  NF: NotaFiscal;
begin
  CriarComNota;
  Assert.IsTrue(FNFe.Enviar(1, False, False), FNFe.WebServices.Retorno.Msg);
  NF := FNFe.NotasFiscais.Items[0];
  Assert.AreEqual('Autorizacao,RetAutorizacao', FMock.Requisicoes.CommaText);
  Assert.AreEqual(NREC_TESTE, FNFe.WebServices.Retorno.Recibo);
  Assert.IsTrue(NF.Confirmada);
  Assert.AreEqual(NOMES_COD[cdUTF8Correto], NOMES_COD[ClassificarStringACBr(NF.XMLOriginal, 'ÀÈÌÒÙ âêîôû')]);
end;

procedure TTestNFeWebServices.Enviar_Rejeicao_NaoConfirma;
var
  NF: NotaFiscal;
begin
  CriarComNota;
  FMock.CStatProtocolo := 539;
  FMock.xMotivoProtocolo := 'Rejeição: Duplicidade de NF-e, com diferença na Chave de Acesso';
  // Enviar gera exceção com o xMotivo quando a nota não é autorizada
  Assert.WillRaiseWithMessage(procedure begin FNFe.Enviar(1, False, True) end,
    nil, FMock.xMotivoProtocolo);
  NF := FNFe.NotasFiscais.Items[0];
  Assert.IsFalse(NF.Confirmada, 'Não deveria estar confirmada');
  Assert.AreEqual(539, FNFe.WebServices.Enviar.cStat);
  Assert.AreEqual(FMock.xMotivoProtocolo, FNFe.WebServices.Enviar.xMotivo);
  Assert.AreEqual(0, Pos('<nfeProc', NF.XMLOriginal), 'Rejeitada não deve virar nfeProc');
end;

procedure TTestNFeWebServices.Enviar_Denegada_NaoConfirmaNemProcessa;
var
  NF: NotaFiscal;
begin
  CriarComNota;
  FMock.CStatProtocolo := 302;
  FMock.xMotivoProtocolo := 'Uso Denegado: Irregularidade fiscal do destinatário';
  Assert.WillRaiseWithMessage(procedure begin FNFe.Enviar(1, False, True) end,
    nil, FMock.xMotivoProtocolo);
  NF := FNFe.NotasFiscais.Items[0];
  // ACBr: CstatProcessado considera só 100/120/150 -> denegada não é "Processada"
  Assert.IsFalse(NF.Processada, 'Denegada (ACBr) não é Processada');
  Assert.IsFalse(NF.Confirmada, 'Denegada não é confirmada');
  Assert.AreEqual(302, FNFe.WebServices.Enviar.cStat);
end;

procedure TTestNFeWebServices.Enviar_DigestDivergente_GeraExcecao;
begin
  CriarComNota;
  FMock.DigestDivergente := True;
  Assert.WillRaiseAny(procedure begin FNFe.Enviar(1, False, True) end);
end;

procedure TTestNFeWebServices.Enviar_FalhaHTTP_GeraExcecao;
begin
  CriarComNota;
  FMock.FalharHTTP := True;
  Assert.WillRaiseAny(procedure begin FNFe.Enviar(1, False, True) end);
end;

procedure TTestNFeWebServices.Enviar_RespostaSemDeclaracao;
begin
  CriarComNota;
  FMock.SemDeclaracaoNaResposta := True;
  FMock.xMotivoProtocolo := 'Autorizado – resposta sem declaração';
  Assert.IsTrue(FNFe.Enviar(1, False, True));
  Assert.AreEqual(FMock.xMotivoProtocolo, FNFe.NotasFiscais.Items[0].NFe.procNFe.xMotivo);
  Assert.AreEqual(NOMES_COD[cdUTF8Correto],
    NOMES_COD[ClassificarStringACBr(FNFe.NotasFiscais.Items[0].XMLOriginal, 'ÀÈÌÒÙ âêîôû')]);
end;

procedure TTestNFeWebServices.Enviar_xMotivoComEntidades;
begin
  CriarComNota;
  FMock.xMotivoProtocolo := 'Autorizado: A &amp; B &lt;x&gt; &quot;ok&quot; a&#231;&#227;o';
  Assert.IsTrue(FNFe.Enviar(1, False, False), 'assíncrono');
  Assert.AreEqual('Autorizado: A & B <x> "ok" ação', FNFe.NotasFiscais.Items[0].NFe.procNFe.xMotivo);
end;

procedure TTestNFeWebServices.Enviar_SalvaArquivosDeEnvioERetorno;
var
  NF: NotaFiscal;
  Pasta: string;
begin
  CriarComNota;
  FNFe.Enviar(1, False, True);
  NF := FNFe.NotasFiscais.Items[0];
  Pasta := FNFe.Configuracoes.Arquivos.PathSalvar;
  Assert.IsTrue(FileExists(Pasta + '1-env-lot.xml'), 'env-lot');
  Assert.IsTrue(FileExists(Pasta + '1-rec.xml'), 'rec');
  Assert.IsTrue(FileExists(NF.NomeArq), 'nfeProc gravado: ' + NF.NomeArq);
  Assert.AreEqual(NOMES_COD[cdUTF8Correto],
    NOMES_COD[ClassificarBytes(LerArquivoBytes(NF.NomeArq), 'ÀÈÌÒÙ âêîôû')], 'arquivo nfeProc');
  Assert.AreEqual(NOMES_COD[cdUTF8Correto],
    NOMES_COD[ClassificarBytes(LerArquivoBytes(Pasta + '1-env-lot.xml'), 'ÀÈÌÒÙ âêîôû')], 'arquivo env-lot');
end;

procedure TTestNFeWebServices.Consultar_PorChave;
begin
  FNFe := CriarACBrNFe(55, FMock, 'ws');
  FMock.xMotivoProtocolo := 'Autorizado o uso da NF-e';
  Assert.IsTrue(FNFe.Consultar('35261118760540000139550030000000831312257860'));
  Assert.IsTrue(FMock.UltimoServico = ssConsulta);
  Assert.AreEqual(100, FNFe.WebServices.Consulta.cStat);
  Assert.AreEqual(NPROT_TESTE, FNFe.WebServices.Consulta.Protocolo);
end;

procedure TTestNFeWebServices.Consultar_NotaNaoAutorizada_RetornoDoMetodo(const ACStat: Integer);
var
  R, RExec: Boolean;
begin
  FNFe := CriarACBrNFe(55, FMock, 'ws');
  FMock.CStatProtocolo := ACStat;
  if ACStat = 217 then
    FMock.xMotivoProtocolo := 'Rejeição: NF-e não consta na base de dados da SEFAZ'
  else
    FMock.xMotivoProtocolo := 'Uso Denegado: Irregularidade fiscal do destinatário';
  R := FNFe.Consultar('35261118760540000139550030000000831312257860');
  RExec := FNFe.WebServices.Consulta.Executar;
  LogLinha(Format('  [Consulta cStat %d] Consultar=%s  WebServices.Consulta.Executar=%s  cStat=%d  xMotivo="%s"',
    [ACStat, BoolToStr(R, True), BoolToStr(RExec, True),
     FNFe.WebServices.Consulta.cStat, FNFe.WebServices.Consulta.XMotivo]));
  Assert.AreEqual(ACStat, FNFe.WebServices.Consulta.cStat, 'cStat');
  Assert.IsFalse(RExec, 'WebServices.Consulta.Executar deve indicar que a nota não está autorizada');
  Assert.IsTrue(R, 'Comportamento mudou: Consultar passou a refletir o cStat');
end;

procedure TTestNFeWebServices.Consultar_NotaCarregada_AtualizaNfeProc;
var
  NF: NotaFiscal;
begin
  CriarComNota;
  FNFe.NotasFiscais.Assinar;
  NF := FNFe.NotasFiscais.Items[0];
  FMock.xMotivoProtocolo := 'Autorizado – consulta';
  // a consulta compara o digest da nota com o digVal devolvido
  FMock.DefinirProtocolo(NF.NumID, NF.NFe.signature.DigestValue);
  Assert.IsTrue(FNFe.Consultar, FNFe.WebServices.Consulta.Msg);
  Assert.IsTrue(Pos('<nfeProc', NF.XMLOriginal) > 0, 'XMLOriginal deve virar nfeProc');
  Assert.AreEqual(NOMES_COD[cdUTF8Correto], NOMES_COD[ClassificarStringACBr(NF.XMLOriginal, 'ÀÈÌÒÙ âêîôû')]);
  Assert.IsTrue(NF.VerificarAssinatura, NF.ErroValidacao);
end;

procedure TTestNFeWebServices.Cancelamento_GeraEventoEVinculaNFe;
var
  Just: string;
begin
  CriarComNota;
  FNFe.Enviar(1, False, True);
  FMock.Requisicoes.Clear;
  Just := 'Cancelamento por erro de digitação - ação & teste';
  Assert.IsTrue(FNFe.Cancelamento(Just, 1), 'Cancelamento');
  Assert.AreEqual('Consulta,Evento', FMock.Requisicoes.CommaText);
  AssertRequisicaoUTF8('digitação');
  Assert.AreEqual(1, FNFe.EventoNFe.Evento.Count);
  Assert.AreEqual(135, FNFe.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.cStat);
  Assert.AreEqual(Just, FNFe.EventoNFe.Evento[0].InfEvento.detEvento.xJust);
end;

procedure TTestNFeWebServices.EnviarCartaCorrecao_TextoAcentuado;
const
  CORRECAO = 'Correção do endereço: Rua São João, nº 10 - Ação & Cia <teste>';
begin
  CriarComNota;
  FNFe.NotasFiscais.Assinar;
  with FNFe.CartaCorrecao.CCe.Evento.New do
  begin
    infEvento.chNFe := FNFe.NotasFiscais.Items[0].NumID;
    infEvento.CNPJ := CNPJ_EMIT;
    infEvento.cOrgao := 35;
    infEvento.dhEvento := Now;
    infEvento.nSeqEvento := 1;
    infEvento.detEvento.xCorrecao := CORRECAO;
  end;
  Assert.IsTrue(FNFe.EnviarCartaCorrecao(1));
  AssertRequisicaoUTF8('endereço');
  Assert.IsTrue(Pos('&amp;', FMock.UltimosDados) > 0, '& escapado na requisição');
  Assert.AreEqual(135, FNFe.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.cStat);
end;

procedure TTestNFeWebServices.EnviarEvento_ManifestacaoDestinatario;
begin
  FNFe := CriarACBrNFe(55, FMock, 'ws');
  FNFe.EventoNFe.Evento.Clear;
  with FNFe.EventoNFe.Evento.New do
  begin
    infEvento.cOrgao := 91;
    infEvento.chNFe := '35261118760540000139550030000000831312257860';
    infEvento.CNPJ := '05481336000137';
    infEvento.dhEvento := Now;
    infEvento.tpEvento := teManifDestOperNaoRealizada;
    infEvento.detEvento.xJust := 'Operação não realizada - mercadoria devolvida';
  end;
  Assert.IsTrue(FNFe.EnviarEvento(1));
  Assert.IsTrue(Pos('210240', FMock.UltimosDados) > 0, 'tpEvento 210240');
  AssertRequisicaoUTF8('Operação');
end;

procedure TTestNFeWebServices.Inutilizar;
begin
  FNFe := CriarACBrNFe(55, FMock, 'ws');
  FNFe.Inutilizar(CNPJ_EMIT, 'Inutilização por quebra de sequência - ação', 26, 1, 10, 12);
  Assert.IsTrue(FMock.UltimoServico = ssInutilizacao);
  AssertRequisicaoUTF8('sequência');
  Assert.AreEqual(102, FNFe.WebServices.Inutilizacao.cStat);
  Assert.AreEqual(NPROT_TESTE, FNFe.WebServices.Inutilizacao.Protocolo);
end;

procedure TTestNFeWebServices.ConsultaCadastro_NomeAcentuado;
begin
  FNFe := CriarACBrNFe(55, FMock, 'ws');
  FNFe.WebServices.ConsultaCadastro.UF := 'SP';
  FNFe.WebServices.ConsultaCadastro.CNPJ := CNPJ_EMIT;
  Assert.IsTrue(FNFe.WebServices.ConsultaCadastro.Executar);
  Assert.AreEqual(111, FNFe.WebServices.ConsultaCadastro.cStat);
  Assert.AreEqual(FMock.NomeEmitenteCadastro,
    FNFe.WebServices.ConsultaCadastro.RetConsCad.InfCad[0].xNome, 'xNome nativo');
  Assert.AreEqual('TATUÍ', FNFe.WebServices.ConsultaCadastro.RetConsCad.InfCad[0].xMun);
end;

procedure TTestNFeWebServices.DistribuicaoDFePorUltNSU;
begin
  FNFe := CriarACBrNFe(55, FMock, 'ws');
  Assert.IsTrue(FNFe.DistribuicaoDFePorUltNSU(35, CNPJ_EMIT, '0'));
  Assert.IsTrue(Pos('<ultNSU>', FMock.UltimosDados) > 0);
  with FNFe.WebServices.DistribuicaoDFe.retDistDFeInt do
  begin
    Assert.AreEqual(138, cStat);
    Assert.AreEqual(1, docZip.Count);
    Assert.AreEqual('EMITENTE AÇÃO LTDA', docZip[0].resDFe.xNome, 'xNome do resNFe (gzip/base64)');
  end;
end;

procedure TTestNFeWebServices.DistribuicaoDFePorNSU;
begin
  FNFe := CriarACBrNFe(55, FMock, 'ws');
  Assert.IsTrue(FNFe.DistribuicaoDFePorNSU(35, CNPJ_EMIT, '1'));
  Assert.IsTrue(Pos('<consNSU>', FMock.UltimosDados) > 0);
end;

procedure TTestNFeWebServices.DistribuicaoDFePorChaveNFe;
begin
  FNFe := CriarACBrNFe(55, FMock, 'ws');
  Assert.IsTrue(FNFe.DistribuicaoDFePorChaveNFe(35, CNPJ_EMIT, '35261118760540000139550030000000831312257860'));
  Assert.IsTrue(Pos('<consChNFe>', FMock.UltimosDados) > 0);
end;

procedure TTestNFeWebServices.AdministrarCSC_NFCe;
begin
  FNFe := CriarACBrNFe(65, FMock, 'ws');
  FNFe.Configuracoes.WebServices.UF := 'AM';
  Assert.IsTrue(FNFe.AdministrarCSC('18760540', ioConsultaCSC, 0, ''));
  Assert.IsTrue(FMock.UltimoServico = ssAdmCSC);
  Assert.AreEqual(150, FNFe.WebServices.AdministrarCSCNFCe.retAdmCSCNFCe.cStat);
end;

procedure TTestNFeWebServices.ObterListaChaves_NFCeSP;
begin
  FNFe := CriarACBrNFe(65, FMock, 'ws');
  FNFe.ObterListaChaves(EncodeDate(2026, 11, 10), EncodeDate(2026, 11, 10) + 0.99);
  Assert.IsTrue(FMock.UltimoServico = ssObterListagem, 'serviço chamado');
  Assert.AreEqual(2, FNFe.WebServices.ObterDFe.RetObterDFe.chNFCe.Count);
end;

procedure TTestNFeWebServices.ObterDownloadXml_NFCeSP;
begin
  FNFe := CriarACBrNFe(65, FMock, 'ws');
  FNFe.ObterDownloadXml('35261118760540000139650010000000011000000016');
  Assert.IsTrue(FMock.UltimoServico = ssObterDownload, 'serviço chamado');
  Assert.AreEqual(100, FNFe.WebServices.ObterDFe.RetObterDFe.cStat);
end;

procedure TTestNFeWebServices.GravarStream_Evento;
var
  MS: TMemoryStream;
  B: RawByteString;
begin
  FNFe := CriarACBrNFe(55, FMock, 'ws');
  with FNFe.EventoNFe.Evento.New do
  begin
    infEvento.cOrgao := 35;
    infEvento.chNFe := '35261118760540000139550030000000831312257860';
    infEvento.CNPJ := CNPJ_EMIT;
    infEvento.dhEvento := Now;
    infEvento.tpEvento := teCCe;
    infEvento.nSeqEvento := 1;
    infEvento.detEvento.xCorrecao := 'Correção da razão social do destinatário';
  end;
  MS := TMemoryStream.Create;
  try
    Assert.IsTrue(FNFe.GravarStream(MS));
    SetLength(B, MS.Size);
    MS.Position := 0;
    if MS.Size > 0 then
      MS.ReadBuffer(B[1], MS.Size);
  finally
    MS.Free;
  end;
  GravarBytesArquivo(PastaSaidaTeste('ws') + 'gravarstream-evento.xml', B);
  LogLinha('  GravarStream(evento): ' + string(Copy(B, 1, 200)));
  Assert.IsTrue(Pos(AnsiString('<envEvento'), B) > 0, 'envEvento no stream');
  { ACHADO: TACBrNFe.GravarStream chama EventoNFe.GerarXML sem aplicar as
    configurações do componente: RetirarAcentos fica no padrão (True) e versao="".
    O XML do stream difere do que é efetivamente enviado à SEFAZ. }
  Assert.AreEqual(0, Pos(AnsiString('versao=""'), B), 'ACHADO: evento no stream com versao vazia');
  Assert.AreEqual(NOMES_COD[cdUTF8Correto], NOMES_COD[ClassificarBytes(B, 'Correção')],
    'ACHADO: GravarStream remove os acentos do evento (RetirarAcentos não vem da configuração)');
end;

initialization
  TDUnitX.RegisterTestFixture(TTestNFeWebServices);

end.
