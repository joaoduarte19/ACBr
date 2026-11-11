unit uTestNFe07CoberturaPropriedades;

{ Cobertura de TODAS as propriedades via RTTI (uRttiCobertura).

  1) Configurações do componente (TACBrNFe.Configuracoes):
       preenche todas as propriedades -> GravarIni (arquivo em disco)
       -> componente NOVO -> LerIni -> compara todas.
  2) Dados da NF-e (TNFe, com objetos aninhados e coleções):
       cenário completo + preenche todas as propriedades restantes
       -> GerarNFeIni (arquivo em disco) -> LoadFromIni -> compara todas.
     Idem com GerarJSON/LoadFromJSON, como referência.

  Relatórios CSV (status;propriedade;esperado;obtido) em bin\saida\cobertura\.
  Status: PRESERVADA | PERDIDA (voltou ao padrão) | ALTERADA. }

interface

uses
  DUnitX.TestFramework, SysUtils, Classes, IniFiles, ACBrNFe, uRttiCobertura;

type
  [TestFixture]
  TTestNFeCoberturaPropriedades = class
  private
    procedure Relatar(const ANome: string; const R: TResultadoComparacao;
      ARelatorio, AFalhas: TStrings);
    procedure CoberturaNFe(const ACenario, AFormato: string);
  public
    [Test] procedure Configuracoes_GravarIni_LerIni_TodasPropriedades;

    [Test]
    [TestCase('NFe 55 RTC IES entrega+retirada', '55_RTC_IES_CF_ENT_RET')]
    [TestCase('NFe 55 sem RTC exportacao',       '55_SemRTC_EXT_NCF')]
    [TestCase('NFCe 65 RTC',                     '65_RTC_INT_CF')]
    procedure NFe_GerarNFeIni_LoadFromIni_TodasPropriedades(const ACenario: string);

    [Test]
    [TestCase('NFe 55 RTC IES entrega+retirada', '55_RTC_IES_CF_ENT_RET')]
    [TestCase('NFCe 65 RTC',                     '65_RTC_INT_CF')]
    procedure NFe_GerarJSON_LoadFromJSON_TodasPropriedades(const ACenario: string);

    [Test]
    [TestCase('INI refNFe',    'INI,refNFe')]
    [TestCase('INI refNFeSig', 'INI,refNFeSig')]
    [TestCase('INI refCTe',    'INI,refCTe')]
    [TestCase('INI RefNF',     'INI,RefNF')]
    [TestCase('INI RefNFP',    'INI,RefNFP')]
    [TestCase('INI RefECF',    'INI,RefECF')]
    [TestCase('JSON refNFe',   'JSON,refNFe')]
    [TestCase('JSON refNFeSig','JSON,refNFeSig')]
    [TestCase('JSON refCTe',   'JSON,refCTe')]
    [TestCase('JSON RefNF',    'JSON,RefNF')]
    [TestCase('JSON RefNFP',   'JSON,RefNFP')]
    [TestCase('JSON RefECF',   'JSON,RefECF')]
    procedure NFref_PorTipo(const AFormato, ATipo: string);
  end;

implementation

uses
  StrUtils, ACBrNFeNotasFiscais, ACBrNFe.Classes, ACBrNFe.Conversao,
  uNFeTesteBase, uXmlTesteHelpers;

const
  MAX_FALHAS_MSG = 40;

procedure TTestNFeCoberturaPropriedades.Relatar(const ANome: string;
  const R: TResultadoComparacao; ARelatorio, AFalhas: TStrings);
var
  Arq: string;
  i: Integer;
begin
  Arq := PastaSaidaTeste('cobertura') + ANome + '.csv';
  ARelatorio.SaveToFile(Arq, TEncoding.UTF8);
  LogLinha(Format('  [Cobertura %s] propriedades: %d | preservadas: %d | PERDIDAS: %d | ALTERADAS: %d  -> %s',
    [ANome, R.Total, R.Preservadas, R.Perdidas, R.Alteradas, ExtractFileName(Arq)]));
  for i := 0 to AFalhas.Count - 1 do
    LogLinha('      ' + AFalhas[i]);
end;

function MensagemFalhas(AFalhas: TStrings): string;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to AFalhas.Count - 1 do
  begin
    if i >= MAX_FALHAS_MSG then
    begin
      Result := Result + sLineBreak + Format('  ... e mais %d (ver CSV)', [AFalhas.Count - MAX_FALHAS_MSG]);
      Break;
    end;
    Result := Result + sLineBreak + '  ' + AFalhas[i];
  end;
end;

{ ------------------------------------------------------------------ Configurações }

procedure TTestNFeCoberturaPropriedades.Configuracoes_GravarIni_LerIni_TodasPropriedades;
var
  N1, N2: TACBrNFe;
  Cob: TCoberturaRTTI;
  Esp, Obt, Rel, Falhas: TStringList;
  Ini: TMemIniFile;
  Arq: string;
  R: TResultadoComparacao;
begin
  Arq := PastaSaidaTeste('cobertura') + 'configuracoes.ini';
  DeleteFile(Arq);
  N1 := TACBrNFe.Create(nil);
  N2 := TACBrNFe.Create(nil);
  Cob := TCoberturaRTTI.Create(
    function(const C: string): Boolean
    begin
      // dados binários / chave de criptografia do próprio INI
      Result := (C = 'Configuracoes.ChaveCryptINI') or (C = 'Configuracoes.Certificados.DadosPFX');
    end, False);
  Esp := nil; Obt := nil;
  Rel := TStringList.Create;
  Falhas := TStringList.Create;
  try
    Cob.Preencher(N1.Configuracoes, 'Configuracoes');
    LogLinha(Format('  [Cobertura Configuracoes] %d propriedades preenchidas; %d recusaram o valor (mantêm o padrão)',
      [Cob.Preenchidas, Cob.FalhasAtribuicao.Count]));
    Esp := Cob.Listar(N1.Configuracoes, 'Configuracoes');

    Ini := TMemIniFile.Create(Arq, TEncoding.UTF8);
    try
      N1.Configuracoes.GravarIni(Ini);
      Ini.UpdateFile;                     // grava em disco
    finally
      Ini.Free;
    end;
    Assert.IsTrue(FileExists(Arq), 'INI não gravado');

    Ini := TMemIniFile.Create(Arq, TEncoding.UTF8);   // relê do disco
    try
      N2.Configuracoes.LerIni(Ini);
    finally
      Ini.Free;
    end;
    Obt := Cob.Listar(N2.Configuracoes, 'Configuracoes');

    R := CompararListas(Esp, Obt, Rel, Falhas);
    Relatar('configuracoes_ini', R, Rel, Falhas);
    Assert.IsTrue(R.Total > 50, 'Poucas propriedades encontradas via RTTI: ' + IntToStr(R.Total));
    Assert.AreEqual(0, R.Perdidas + R.Alteradas,
      Format('%d de %d propriedades das Configurações não sobrevivem a GravarIni/LerIni:%s',
        [R.Perdidas + R.Alteradas, R.Total, MensagemFalhas(Falhas)]));
  finally
    Falhas.Free; Rel.Free; Obt.Free; Esp.Free;
    Cob.Free; N2.Free; N1.Free;
  end;
end;

{ ------------------------------------------------------------------ NFe }

function IgnorarNFe(const C: string): Boolean;
begin
  { Campos que definem/derivam da chave e campos que não são dados de entrada }
  Result :=
    (C = 'NFe.infNFe.ID') or (C = 'NFe.infNFe.Versao') or
    (C = 'NFe.Ide.cUF') or (C = 'NFe.Ide.modelo') or (C = 'NFe.Ide.serie') or
    (C = 'NFe.Ide.nNF') or (C = 'NFe.Ide.cNF') or (C = 'NFe.Ide.cDV') or
    (C = 'NFe.Ide.tpEmis') or (C = 'NFe.Ide.tpAmb') or (C = 'NFe.Ide.dEmi') or
    (C = 'NFe.Emit.CNPJCPF') or
    (Pos('NFe.signature.', C) = 1) or        // assinatura não faz parte do INI
    (Pos('NFe.infNFeSupl.', C) = 1) or       // QR-Code: recalculado ao assinar
    (Pos('NFe.procNFe.', C) = 1) or          // protocolo: saída da SEFAZ (coberto no fixture 06)
    // NFref: cada item é de UM tipo (refNFe | refNFeSig | refCTe | RefNF | RefNFP | RefECF);
    // coberto tipo a tipo em NFref_PorTipo
    ((Pos('NFe.Ide.NFref[', C) = 1) and (Pos('.refNFe', C) = 0));
end;

procedure TTestNFeCoberturaPropriedades.CoberturaNFe(const ACenario, AFormato: string);
{ Usa o XML oficial como referência do que é aplicável ao cenário:
    APLICÁVEL     = propriedade preservada em GerarXML -> LoadFromString
    NÃO APLICÁVEL = o XML também não a carrega (ex.: campos de ICMS de outro CST)
  O formato testado (INI/JSON) deve preservar TODAS as aplicáveis. }
var
  C: TCenarioNFe;
  N1, NX, N2: TACBrNFe;
  NF: NotaFiscal;
  Cob: TCoberturaRTTI;
  Esp, LX, LF, Rel, Falhas, Arquivo: TStringList;
  ArqDisco, Conteudo, Nome, E, VX, VF, Status: string;
  i, Aplic, Preserv, Perd, Alter, NaoAplic, SoNoFormato: Integer;
begin
  C := CenarioPorCodigo(ACenario);
  N1 := CriarACBrNFe(C.Modelo, nil, 'cobertura');
  NX := CriarACBrNFe(C.Modelo, nil, 'cobertura');
  N2 := CriarACBrNFe(C.Modelo, nil, 'cobertura');
  Cob := TCoberturaRTTI.Create(IgnorarNFe, True);   // só preenche o que ainda está vazio
  Esp := nil; LX := nil; LF := nil;
  Rel := TStringList.Create;
  Falhas := TStringList.Create;
  Arquivo := TStringList.Create;
  try
    NF := PreencherNFe(N1, C);
    Cob.Preencher(NF.NFe, 'NFe');
    NF.GerarXML;          // calcula chave/DV (GerarNFeIni exige chave válida)
    LogLinha(Format('  [Cobertura NFe %s/%s] %d propriedades preenchidas; chave %s',
      [ACenario, AFormato, Cob.Preenchidas, NF.NumID]));
    Esp := Cob.Listar(NF.NFe, 'NFe');

    // Referência: XML oficial
    NX.NotasFiscais.LoadFromString(NF.XMLOriginal);
    LX := Cob.Listar(NX.NotasFiscais.Items[0].NFe, 'NFe');
    LX.Sorted := True;

    // Formato testado: grava em disco e relê
    if AFormato = 'INI' then Conteudo := NF.GerarNFeIni else Conteudo := NF.GerarJSON;
    ArqDisco := PastaSaidaTeste('cobertura') + 'nfe_' + ACenario + '.' + LowerCase(AFormato);
    Arquivo.Text := Conteudo;
    Arquivo.SaveToFile(ArqDisco, TEncoding.UTF8);
    Arquivo.Clear;
    Arquivo.LoadFromFile(ArqDisco, TEncoding.UTF8);
    if AFormato = 'INI' then
      N2.NotasFiscais.LoadFromIni(Arquivo.Text)
    else
      N2.NotasFiscais.LoadFromJSON(Arquivo.Text);
    Assert.AreEqual(1, N2.NotasFiscais.Count, 'nota não carregada');
    LF := Cob.Listar(N2.NotasFiscais.Items[0].NFe, 'NFe');
    LF.Sorted := True;

    Aplic := 0; Preserv := 0; Perd := 0; Alter := 0; NaoAplic := 0; SoNoFormato := 0;
    Rel.Add('status;propriedade;esperado;xml;' + LowerCase(AFormato));
    for i := 0 to Esp.Count - 1 do
    begin
      Nome := Esp.Names[i];
      E := Esp.ValueFromIndex[i];
      if LX.IndexOfName(Nome) >= 0 then VX := LX.Values[Nome] else VX := '<ausente>';
      if LF.IndexOfName(Nome) >= 0 then VF := LF.Values[Nome] else VF := '<ausente>';
      if VX <> E then
      begin
        if VF = E then
        begin
          Status := 'SO_NO_' + AFormato;   // o formato preserva algo que o XML não carrega
          Inc(SoNoFormato);
        end
        else
        begin
          Status := 'NAO_APLICAVEL';
          Inc(NaoAplic);
        end;
      end
      else
      begin
        Inc(Aplic);
        if VF = E then
        begin
          Status := 'PRESERVADA';
          Inc(Preserv);
        end
        else if (VF = '') or (VF = '0') or (VF = 'False') or (VF = '<ausente>') then
        begin
          Status := 'PERDIDA';
          Inc(Perd);
          Falhas.Add(Format('PERDIDA   %s: esperado "%s" obtido "%s"', [Nome, E, VF]));
        end
        else
        begin
          Status := 'ALTERADA';
          Inc(Alter);
          Falhas.Add(Format('ALTERADA  %s: esperado "%s" obtido "%s"', [Nome, E, VF]));
        end;
      end;
      Rel.Add(Status + ';' + Nome + ';' + E + ';' + VX + ';' + VF);
    end;

    Rel.SaveToFile(PastaSaidaTeste('cobertura') + 'nfe_' + LowerCase(AFormato) + '_' + ACenario + '.csv', TEncoding.UTF8);
    LogLinha(Format('  [Cobertura NFe %s/%s] propriedades: %d | aplicáveis (no XML): %d | ' +
      'preservadas: %d | PERDIDAS: %d | ALTERADAS: %d | não aplicáveis: %d | só no %s: %d',
      [ACenario, AFormato, Esp.Count, Aplic, Preserv, Perd, Alter, NaoAplic, AFormato, SoNoFormato]));
    for i := 0 to Falhas.Count - 1 do
      LogLinha('      ' + Falhas[i]);

    Assert.IsTrue(Aplic > 250, 'Poucas propriedades aplicáveis: ' + IntToStr(Aplic));
    Assert.AreEqual(0, Perd + Alter,
      Format('%s: %d de %d propriedades aplicáveis (preservadas pelo XML) não sobrevivem a Gerar/Load:%s',
        [AFormato, Perd + Alter, Aplic, MensagemFalhas(Falhas)]));
  finally
    Arquivo.Free; Falhas.Free; Rel.Free; LF.Free; LX.Free; Esp.Free;
    Cob.Free; N2.Free; NX.Free; N1.Free;
  end;
end;

procedure TTestNFeCoberturaPropriedades.NFref_PorTipo(const AFormato, ATipo: string);
{ Uma nota referenciada de cada tipo; compara todos os campos do NFref[0]
  depois de Gerar(INI|JSON) -> disco -> Load. Referência: XML. }
var
  N1, NX, N2: TACBrNFe;
  NF: NotaFiscal;
  Cob: TCoberturaRTTI;
  Esp, LX, LF, Arq: TStringList;
  i: Integer;
  Nome, Dif, NaoXML: string;
  ArqDisco: string;
begin
  N1 := CriarACBrNFe(55, nil, 'cobertura');
  NX := CriarACBrNFe(55, nil, 'cobertura');
  N2 := CriarACBrNFe(55, nil, 'cobertura');
  Cob := TCoberturaRTTI.Create(
    function(const C: string): Boolean
    begin
      Result := Pos('NFe.Ide.NFref', C) <> 1;   // só o grupo NFref
    end, False);
  Esp := nil; LX := nil; LF := nil;
  Arq := TStringList.Create;
  try
    NF := PreencherNFe(N1, CenarioPorCodigo('55_RTC_INT_NCF'));
    with NF.NFe.Ide.NFref.New do
      if ATipo = 'refNFe' then
        refNFe := '35261118760540000139550010000000011000000016'
      else if ATipo = 'refNFeSig' then
        refNFeSig := '35261118760540000139550010000000011000000016'
      else if ATipo = 'refCTe' then
        refCTe := '35261118760540000139570010000000011000000013'
      else if ATipo = 'RefNF' then
      begin
        RefNF.cUF := 35; RefNF.AAMM := '2611'; RefNF.CNPJ := '11222333000181';
        RefNF.modelo := 1; RefNF.serie := 2; RefNF.nNF := 123;
      end
      else if ATipo = 'RefNFP' then
      begin
        RefNFP.cUF := 35; RefNFP.AAMM := '2611'; RefNFP.CNPJCPF := '12345678909';
        RefNFP.IE := '687097034118'; RefNFP.modelo := '04'; RefNFP.serie := 3; RefNFP.nNF := 456;
      end
      else if ATipo = 'RefECF' then
      begin
        RefECF.modelo := ECFModRef2D; RefECF.nECF := '001'; RefECF.nCOO := '000123';
      end;
    NF.GerarXML;
    Esp := Cob.Listar(NF.NFe, 'NFe');

    NX.NotasFiscais.LoadFromString(NF.XMLOriginal);
    LX := Cob.Listar(NX.NotasFiscais.Items[0].NFe, 'NFe');

    ArqDisco := PastaSaidaTeste('cobertura') + 'nfref_' + ATipo + '.' + LowerCase(AFormato);
    if AFormato = 'INI' then Arq.Text := NF.GerarNFeIni else Arq.Text := NF.GerarJSON;
    Arq.SaveToFile(ArqDisco, TEncoding.UTF8);
    Arq.LoadFromFile(ArqDisco, TEncoding.UTF8);
    if AFormato = 'INI' then
      N2.NotasFiscais.LoadFromIni(Arq.Text)
    else
      N2.NotasFiscais.LoadFromJSON(Arq.Text);
    LF := Cob.Listar(N2.NotasFiscais.Items[0].NFe, 'NFe');

    Dif := ''; NaoXML := '';
    for i := 0 to Esp.Count - 1 do
    begin
      Nome := Esp.Names[i];
      if LX.Values[Nome] <> Esp.ValueFromIndex[i] then
        NaoXML := NaoXML + ' ' + Nome
      else if LF.Values[Nome] <> Esp.ValueFromIndex[i] then
        Dif := Dif + sLineBreak + Format('  %s: esperado "%s" obtido "%s"',
          [Nome, Esp.ValueFromIndex[i], LF.Values[Nome]]);
    end;
    LogLinha(Format('  [NFref %s/%s] %s', [AFormato, ATipo,
      IfThen(Dif = '', 'preservado', 'DIVERGÊNCIAS:' + Dif)]));
    Assert.AreEqual('', NaoXML, 'XML não preservou:' + NaoXML);
    Assert.AreEqual('', Dif, AFormato + ' perdeu a nota referenciada ' + ATipo + ':' + Dif);
  finally
    Arq.Free; LF.Free; LX.Free; Esp.Free;
    Cob.Free; N2.Free; NX.Free; N1.Free;
  end;
end;

procedure TTestNFeCoberturaPropriedades.NFe_GerarNFeIni_LoadFromIni_TodasPropriedades(const ACenario: string);
begin
  CoberturaNFe(ACenario, 'INI');
end;

procedure TTestNFeCoberturaPropriedades.NFe_GerarJSON_LoadFromJSON_TodasPropriedades(const ACenario: string);
begin
  CoberturaNFe(ACenario, 'JSON');
end;

initialization
  TDUnitX.RegisterTestFixture(TTestNFeCoberturaPropriedades);

end.
