unit uTestNFe08FusoHorario;

{ Fuso horário (offset) nas datas/horas da NF-e: dhEmi, dhSaiEnt, dhEvento, dhRecbto.

  Como o ACBr trabalha:
   - Geração: o offset vem do TimeZoneConf GLOBAL (ACBrUtil.DateTime), copiado de
     Configuracoes.WebServices.TimeZoneConf em NotaFiscal.GerarXML. Modos:
       tzSistema = fuso do Windows | tzPCN = pela UF | tzManual = TimeZoneStr
   - Leitura: ParseDataHora DESCARTA o offset; o objeto guarda só a hora de relógio.
     Ao gerar de novo, o offset vem da configuração ATUAL, não do XML original.

  Verifica: offset gerado em cada modo, horário de verão (até 2018), validação do
  TimeZoneStr, preservação do offset ao recarregar/regerar/assinar, INI/JSON,
  protocolo (dhRecbto), evento (dhEvento) e isolamento entre componentes. }

interface

uses
  DUnitX.TestFramework, SysUtils, Classes, ACBrNFe, uSefazMock;

type
  [TestFixture]
  TTestNFeFusoHorario = class
  private
    FNFe: TACBrNFe;
    FMock: TSefazMock;
    procedure Configurar(ANFe: TACBrNFe; const AModo: string; const AOffset: string = '');
    function GerarComOffset(const AOffset: string): string;
  public
    [Setup]    procedure Setup;
    [TearDown] procedure TearDown;

    // ---- Geração ----
    [Test] procedure Sistema_UsaFusoDoWindows;

    [Test]
    [TestCase('SP', 'SP,35,-03:00')]
    [TestCase('RJ', 'RJ,33,-03:00')]
    [TestCase('DF', 'DF,53,-03:00')]
    [TestCase('PA', 'PA,15,-03:00')]
    [TestCase('RS', 'RS,43,-03:00')]
    [TestCase('AM', 'AM,13,-04:00')]
    [TestCase('MS', 'MS,50,-04:00')]
    [TestCase('MT', 'MT,51,-04:00')]
    [TestCase('RO', 'RO,11,-04:00')]
    [TestCase('RR', 'RR,14,-04:00')]
    [TestCase('AC', 'AC,12,-05:00')]
    procedure PorUF_OffsetDaUF(const AUF: string; ACUF: Integer; const AEsperado: string);

    [Test]
    [TestCase('-02:00', '-02:00')]
    [TestCase('-03:00', '-03:00')]
    [TestCase('-04:00', '-04:00')]
    [TestCase('-05:00', '-05:00')]
    [TestCase('+00:00', '+00:00')]
    [TestCase('-03:30', '-03:30')]
    procedure Manual_dhEmiEdhSaiEntUsamOffsetConfigurado(const AOffset: string);

    [Test] procedure Manual_TimeZoneStrAntesDoModo_EhDescartado;

    [Test]
    [TestCase('sem sinal',  '03:00')]
    [TestCase('sem zero',   '-3:00')]
    [TestCase('texto',      'abc')]
    [TestCase('sem dois pontos', '-0300')]
    procedure Manual_TimeZoneStrInvalido_GeraExcecao(const AOffset: string);

    [Test]
    [TestCase('SP 2018 verao',      'SP,35,2018,12,10,-02:00')]
    [TestCase('MS 2018 verao',      'MS,50,2018,12,10,-03:00')]
    [TestCase('AM 2018 sem verao',  'AM,13,2018,12,10,-04:00')]
    [TestCase('SP 2026 extinto',    'SP,35,2026,12,10,-03:00')]
    [TestCase('MS 2026 extinto',    'MS,50,2026,12,10,-04:00')]
    procedure PorUF_HorarioDeVerao(const AUF: string; ACUF, AAno, AMes, ADia: Integer; const AEsperado: string);

    // ---- Leitura / preservação ----
    [Test] procedure Leitura_GuardaHoraDeRelogioEDescartaOffset;
    [Test] procedure Leitura_XMLOriginalPreservaOffset;
    [Test] procedure Regerar_LoadFromStringAGerarNFe_PreservaOffset;
    [Test] procedure Assinar_NotaCarregadaDeOutroFuso_PreservaOffset;

    [Test]
    [TestCase('INI',  'INI')]
    [TestCase('JSON', 'JSON')]
    procedure IdaEVolta_PreservaOffset(const AFormato: string);

    // ---- Protocolo / evento / isolamento ----
    [Test] procedure Protocolo_dhRecbtoComOffsetDaSEFAZ_PreservadoNoNfeProc;
    [Test] procedure Evento_dhEventoUsaOffsetDoComponente;
    [Test] procedure DoisComponentes_OffsetsIndependentes;
  end;

implementation

uses
  StrUtils, ACBrNFeNotasFiscais, ACBrNFe.Classes, ACBrDFe.Conversao, ACBrUtil.DateTime,
  ACBrUtil.Strings, ACBrUtil.XMLHTML,
  uNFeTesteBase, uXmlTesteHelpers;

{ Offset no fim do conteúdo da tag, ex.: <dhEmi>2026-11-10T10:00:00-05:00</dhEmi> -> -05:00 }
function OffsetDe(const AXML, ATag: string): string;
var
  V: string;
begin
  V := RetornarConteudoEntre(AXML, '<' + ATag + '>', '</' + ATag + '>');
  Result := Copy(V, Length(V) - 5, 6);
end;

function HoraDe(const AXML, ATag: string): string;
var
  V: string;
begin
  V := RetornarConteudoEntre(AXML, '<' + ATag + '>', '</' + ATag + '>');
  Result := Copy(V, 12, 8);
end;

{ TTestNFeFusoHorario }

procedure TTestNFeFusoHorario.Setup;
begin
  FMock := TSefazMock.Create;
  FNFe := CriarACBrNFe(55, FMock, 'fuso');
end;

procedure TTestNFeFusoHorario.TearDown;
begin
  FreeAndNil(FNFe);
  FreeAndNil(FMock);
  // não deixar o TimeZoneConf global "sujo" para os demais fixtures
  TimeZoneConf.ModoDeteccao := tzSistema;
end;

procedure TTestNFeFusoHorario.Configurar(ANFe: TACBrNFe; const AModo, AOffset: string);
begin
  with ANFe.Configuracoes.WebServices.TimeZoneConf do
    if AModo = 'manual' then
    begin
      ModoDeteccao := tzManual;      // o modo PRECISA vir antes do TimeZoneStr
      TimeZoneStr := AOffset;
    end
    else if AModo = 'uf' then
      ModoDeteccao := tzPCN
    else
      ModoDeteccao := tzSistema;
end;

function TTestNFeFusoHorario.GerarComOffset(const AOffset: string): string;
var
  N: TACBrNFe;
begin
  { NF-e gerada e assinada "em outro fuso" (ex.: emitente do Acre) }
  N := CriarACBrNFe(55, nil, 'fuso');
  try
    Configurar(N, 'manual', AOffset);
    PreencherNFe(N, CenarioPorCodigo('55_RTC_INT_NCF'));
    N.NotasFiscais.Assinar;
    Result := N.NotasFiscais.Items[0].XMLAssinado;
  finally
    N.Free;
  end;
end;

// ------------------------------------------------------------------ Geração

procedure TTestNFeFusoHorario.Sistema_UsaFusoDoWindows;
var
  X: string;
begin
  Configurar(FNFe, 'sistema');
  PreencherNFe(FNFe, CenarioPadrao);
  X := FNFe.NotasFiscais.Items[0].GerarXML;
  LogLinha('  [Fuso sistema] Windows=' + GetUTCSistema + ' dhEmi=' +
    RetornarConteudoEntre(X, '<dhEmi>', '</dhEmi>'));
  Assert.AreEqual(GetUTCSistema, OffsetDe(X, 'dhEmi'));
end;

procedure TTestNFeFusoHorario.PorUF_OffsetDaUF(const AUF: string; ACUF: Integer; const AEsperado: string);
var
  NF: NotaFiscal;
  X: string;
begin
  Configurar(FNFe, 'uf');
  NF := PreencherNFe(FNFe, CenarioPadrao);
  NF.NFe.Ide.cUF := ACUF;
  NF.NFe.Emit.EnderEmit.UF := AUF;
  X := NF.GerarXML;
  Assert.AreEqual(AEsperado, OffsetDe(X, 'dhEmi'), 'dhEmi ' + AUF);
  Assert.AreEqual(AEsperado, OffsetDe(X, 'dhSaiEnt'), 'dhSaiEnt ' + AUF);
end;

procedure TTestNFeFusoHorario.Manual_dhEmiEdhSaiEntUsamOffsetConfigurado(const AOffset: string);
var
  X: string;
begin
  Configurar(FNFe, 'manual', AOffset);
  PreencherNFe(FNFe, CenarioPadrao);
  X := FNFe.NotasFiscais.Items[0].GerarXML;
  Assert.AreEqual(AOffset, OffsetDe(X, 'dhEmi'), 'dhEmi');
  Assert.AreEqual(AOffset, OffsetDe(X, 'dhSaiEnt'), 'dhSaiEnt');
  Assert.AreEqual('10:00:00', HoraDe(X, 'dhEmi'), 'hora de relógio não deve mudar');
end;

procedure TTestNFeFusoHorario.Manual_TimeZoneStrAntesDoModo_EhDescartado;
var
  X: string;
begin
  { ACHADO (documentado): TTimeZoneConf.SetTimeZoneStr ignora o valor quando o modo
    ainda não é tzManual. Atribuir TimeZoneStr ANTES de ModoDeteccao perde o offset. }
  with FNFe.Configuracoes.WebServices.TimeZoneConf do
  begin
    TimeZoneStr := '-05:00';
    ModoDeteccao := tzManual;
  end;
  PreencherNFe(FNFe, CenarioPadrao);
  X := FNFe.NotasFiscais.Items[0].GerarXML;
  LogLinha('  ACHADO: TimeZoneStr antes do modo -> dhEmi com ' + OffsetDe(X, 'dhEmi') + ' (pedido -05:00)');
  Assert.AreNotEqual('-05:00', OffsetDe(X, 'dhEmi'),
    'Comportamento mudou: TimeZoneStr atribuído antes do modo passou a valer');
end;

procedure TTestNFeFusoHorario.Manual_TimeZoneStrInvalido_GeraExcecao(const AOffset: string);
begin
  FNFe.Configuracoes.WebServices.TimeZoneConf.ModoDeteccao := tzManual;
  Assert.WillRaiseAny(procedure begin
    FNFe.Configuracoes.WebServices.TimeZoneConf.TimeZoneStr := AOffset;
  end);
end;

procedure TTestNFeFusoHorario.PorUF_HorarioDeVerao(const AUF: string; ACUF, AAno, AMes, ADia: Integer;
  const AEsperado: string);
var
  NF: NotaFiscal;
  X: string;
begin
  Configurar(FNFe, 'uf');
  NF := PreencherNFe(FNFe, CenarioPadrao);
  NF.NFe.Ide.cUF := ACUF;
  NF.NFe.Emit.EnderEmit.UF := AUF;
  NF.NFe.Ide.dEmi := EncodeDate(AAno, AMes, ADia) + EncodeTime(10, 0, 0, 0);
  NF.NFe.Ide.dSaiEnt := NF.NFe.Ide.dEmi;
  X := NF.GerarXML;
  Assert.AreEqual(AEsperado, OffsetDe(X, 'dhEmi'));
end;

// ------------------------------------------------------------------ Leitura

procedure TTestNFeFusoHorario.Leitura_GuardaHoraDeRelogioEDescartaOffset;
var
  X: string;
  H, M, S, MS: Word;
begin
  X := GerarComOffset('-05:00');            // 10:00:00-05:00 (= 12:00 em Brasília)
  Configurar(FNFe, 'sistema');
  FNFe.NotasFiscais.LoadFromString(X);
  DecodeTime(FNFe.NotasFiscais.Items[0].NFe.Ide.dEmi, H, M, S, MS);
  LogLinha(Format('  [Leitura] dhEmi=%s -> Ide.dEmi=%.2d:%.2d (offset não fica no objeto)',
    [RetornarConteudoEntre(X, '<dhEmi>', '</dhEmi>'), H, M]));
  Assert.AreEqual(10, Integer(H), 'Ide.dEmi guarda a hora de relógio do XML (sem converter fuso)');
end;

procedure TTestNFeFusoHorario.Leitura_XMLOriginalPreservaOffset;
var
  X: string;
begin
  X := GerarComOffset('-05:00');
  Configurar(FNFe, 'sistema');
  FNFe.NotasFiscais.LoadFromString(X);
  Assert.AreEqual('-05:00', OffsetDe(FNFe.NotasFiscais.Items[0].XMLOriginal, 'dhEmi'),
    'XMLOriginal (sem regerar) mantém o offset original');
  Assert.IsTrue(FNFe.NotasFiscais.Items[0].VerificarAssinatura);
end;

procedure TTestNFeFusoHorario.Regerar_LoadFromStringAGerarNFe_PreservaOffset;
var
  X, R: string;
begin
  X := GerarComOffset('-05:00');
  Configurar(FNFe, 'sistema');                 // máquina em -03:00
  FNFe.NotasFiscais.LoadFromString(X, True);   // AGerarNFe = True
  R := FNFe.NotasFiscais.Items[0].XMLOriginal;
  LogLinha(Format('  [Regerar] original %s -> regerado %s',
    [RetornarConteudoEntre(X, '<dhEmi>', '</dhEmi>'), RetornarConteudoEntre(R, '<dhEmi>', '</dhEmi>')]));
  Assert.AreEqual('-05:00', OffsetDe(R, 'dhEmi'),
    'Ao regerar, o offset do XML original foi trocado pelo da configuração: o instante da emissão mudou');
end;

procedure TTestNFeFusoHorario.Assinar_NotaCarregadaDeOutroFuso_PreservaOffset;
var
  X, R: string;
begin
  { Cenário real: XML assinado em outro fuso, carregado e enviado (Enviar chama
    Assinar, que REGERA o XML a partir do objeto). }
  X := GerarComOffset('-05:00');
  Configurar(FNFe, 'sistema');
  FNFe.NotasFiscais.LoadFromString(X);
  FNFe.NotasFiscais.Assinar;
  R := FNFe.NotasFiscais.Items[0].XMLAssinado;
  LogLinha(Format('  [Assinar nota carregada] original %s -> reassinado %s',
    [RetornarConteudoEntre(X, '<dhEmi>', '</dhEmi>'), RetornarConteudoEntre(R, '<dhEmi>', '</dhEmi>')]));
  Assert.AreEqual('-05:00', OffsetDe(R, 'dhEmi'),
    'Assinar uma nota carregada trocou o offset do dhEmi');
end;

procedure TTestNFeFusoHorario.IdaEVolta_PreservaOffset(const AFormato: string);
var
  N1: TACBrNFe;
  T, R: string;
begin
  N1 := CriarACBrNFe(55, nil, 'fuso');
  try
    Configurar(N1, 'manual', '-05:00');
    PreencherNFe(N1, CenarioPadrao);
    N1.NotasFiscais.Items[0].GerarXML;
    if AFormato = 'INI' then T := N1.NotasFiscais.Items[0].GerarNFeIni
    else T := N1.NotasFiscais.Items[0].GerarJSON;
  finally
    N1.Free;
  end;
  Configurar(FNFe, 'sistema');
  if AFormato = 'INI' then FNFe.NotasFiscais.LoadFromIni(T)
  else FNFe.NotasFiscais.LoadFromJSON(T);
  R := FNFe.NotasFiscais.Items[0].GerarXML;
  LogLinha(Format('  [%s] dhEmi gerado -05:00 -> após ida e volta: %s (%s)', [AFormato,
    RetornarConteudoEntre(R, '<dhEmi>', '</dhEmi>'),
    IfThen(Pos('-05:00', T) > 0, 'offset presente no ' + AFormato, 'offset AUSENTE no ' + AFormato)]));
  Assert.AreEqual('-05:00', OffsetDe(R, 'dhEmi'), AFormato + ' não preserva o offset do dhEmi');
end;

// ------------------------------------------------------------------ Protocolo / evento

procedure TTestNFeFusoHorario.Protocolo_dhRecbtoComOffsetDaSEFAZ_PreservadoNoNfeProc;
var
  NF: NotaFiscal;
  H, M, S, MS: Word;
begin
  Configurar(FNFe, 'sistema');
  FMock.DhRecbtoProtocolo := '2026-11-10T09:00:38-04:00';   // SEFAZ-AM
  PreencherNFe(FNFe, CenarioPadrao);
  Assert.IsTrue(FNFe.Enviar(1, False, True));
  NF := FNFe.NotasFiscais.Items[0];
  Assert.IsTrue(Pos('<dhRecbto>2026-11-10T09:00:38-04:00</dhRecbto>', NF.XMLOriginal) > 0,
    'nfeProc deve manter o dhRecbto da SEFAZ com o offset original');
  DecodeTime(NF.NFe.procNFe.dhRecbto, H, M, S, MS);
  Assert.AreEqual(9, Integer(H), 'procNFe.dhRecbto guarda a hora de relógio');
end;

procedure TTestNFeFusoHorario.Evento_dhEventoUsaOffsetDoComponente;
var
  N2: TACBrNFe;
  Off: string;
begin
  { O XML do evento usa o TimeZoneConf GLOBAL; ele só é atualizado a partir da
    configuração do componente em NotaFiscal.GerarXML. }
  N2 := CriarACBrNFe(55, nil, 'fuso');      // "outro" componente, gera NF-e em -02:00
  try
    Configurar(N2, 'manual', '-02:00');
    PreencherNFe(N2, CenarioPadrao);
    N2.NotasFiscais.Items[0].GerarXML;
  finally
    N2.Free;
  end;

  Configurar(FNFe, 'manual', '-05:00');     // este componente quer -05:00
  with FNFe.EventoNFe.Evento.New do
  begin
    infEvento.cOrgao := 35;
    infEvento.chNFe := '35261118760540000139550030000000831312257860';
    infEvento.CNPJ := CNPJ_EMIT;
    infEvento.dhEvento := EncodeDate(2026, 11, 10) + EncodeTime(11, 0, 0, 0);
    infEvento.tpEvento := teCCe;
    infEvento.nSeqEvento := 1;
    infEvento.detEvento.xCorrecao := 'Correção do endereço do destinatário';
  end;
  Assert.IsTrue(FNFe.EnviarEvento(1));
  Off := OffsetDe(FMock.UltimosDados, 'dhEvento');
  LogLinha('  [Evento] componente -05:00 -> dhEvento enviado com ' + Off);
  Assert.AreEqual('-05:00', Off, 'dhEvento não usou o fuso configurado no componente');
end;

procedure TTestNFeFusoHorario.DoisComponentes_OffsetsIndependentes;
var
  A, B: TACBrNFe;
  XA1, XB, XA2: string;
begin
  A := CriarACBrNFe(55, nil, 'fuso');
  B := CriarACBrNFe(55, nil, 'fuso');
  try
    Configurar(A, 'manual', '-05:00');
    Configurar(B, 'manual', '-02:00');
    PreencherNFe(A, CenarioPadrao);
    PreencherNFe(B, CenarioPadrao);
    XA1 := A.NotasFiscais.Items[0].GerarXML;
    XB := B.NotasFiscais.Items[0].GerarXML;
    XA2 := A.NotasFiscais.Items[0].GerarXML;
    Assert.AreEqual('-05:00', OffsetDe(XA1, 'dhEmi'), 'A antes de B');
    Assert.AreEqual('-02:00', OffsetDe(XB, 'dhEmi'), 'B');
    Assert.AreEqual('-05:00', OffsetDe(XA2, 'dhEmi'), 'A depois de B');
  finally
    B.Free;
    A.Free;
  end;
end;

initialization
  TDUnitX.RegisterTestFixture(TTestNFeFusoHorario);

end.
