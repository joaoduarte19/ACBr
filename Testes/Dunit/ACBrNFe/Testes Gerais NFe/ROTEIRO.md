# Roteiro de testes — TACBrNFe (Delphi + DUnitX)

Testes automatizados do componente `TACBrNFe` usando os fontes reais do ACBr
(`C:\ACBr\Fontes`), sem acesso à SEFAZ e sem impressora.

- **296 testes** em 11 fixtures (cenários parametrizados com `[TestCase]`).
- **SEFAZ simulada** (`Base\uSefazMock.pas`): responde a todos os serviços da
  NF-e/NFC-e através do evento `TACBrNFe.OnTransmit`, no layout oficial.
- **Certificado de teste** autoassinado (`Dados\cert_teste.pfx`, senha `1234`):
  a assinatura é real (OpenSSL + LibXml2).
- **Impressão sem impressora**: DANFE FPDF (PDF em arquivo e em stream) e
  ESC/POS gravado em arquivo.
- **Detecção de quebra de acentuação**: cada etapa é classificada pelos bytes
  (`UTF-8 CORRETO`, `UTF-8 DUPLO`, `ANSI/CP1252`), e cada método de manipulação de
  XML é verificado com ida e volta campo a campo.

---

## 1. Estrutura

```
TestesNFe\
  TestesNFe.dpr                  programa DUnitX (console)
  build.sh                       compila bin\TestesNFe.exe
  ROTEIRO.md                     este documento
  Base\
    uXmlTesteHelpers.pas         classificação de codificação, log por etapa
    uSefazMock.pas               SEFAZ simulada (OnTransmit)
    uNFeTesteBase.pas            fábrica do componente, cenários, construtor de NF-e, comparação de campos
  Testes\
    uTestNFe01Componente.pas     métodos utilitários e pré-condições
    uTestNFe02GeracaoXML.pas     criação de XML por cenário/NT
    uTestNFe03ManipulacaoXML.pas ida e volta de todos os métodos de XML (dummy)
    uTestNFe04WebServices.pas    todos os serviços SEFAZ
    uTestNFe05Impressao.pas      DANFE NF-e/NFC-e, eventos, ESC/POS
    uTestConversoes.pas          rotinas de conversão UTF-8 (regressão)
    uTestXmlDocument.pas         TACBrXmlDocument com acentos (regressão)
    uTestFluxoNFe.pas            fluxo completo com rastreio por etapa (regressão)
  Dados\                         certificado de teste e XMLs reais (correto/corrompido)
  bin\                           gerado: executáveis, DLLs, saída e logs (não versionar)
  dcu\                           gerado: units compiladas (não versionar)
```

## 2. Como executar

**Pré-requisitos**
- Delphi 13 (Studio 37.0) com DUnitX (já vem com o Delphi).
- Fontes do ACBr. A raiz é lida da variável de ambiente `ACBR_DIR`
  (padrão `C:\ACBr`); dela vêm `Fontes\`, os schemas
  (`Exemplos\ACBrDFe\Schemas\NFe\`) e as DLLs.
- DLLs 32 bits em `bin\`: OpenSSL 3.1.3 (`DLLs\OpenSSL\3.1.3\x86`) e LibXml2
  (`DLLs\LibXml2\x86`). O `build.sh` as copia; pelo IDE, copie-as uma vez.

**No IDE:** abrir `TestesNFe.dproj` e executar (F9). O projeto é VCL, com saída
em `bin\` e Unit scope names incluindo `Vcl;Vcl.Imaging;Winapi;System.Win`
(o ACBr usa `Dialogs`, `Graphics` etc. sem prefixo). Os fontes do ACBr precisam
estar no Library Path do IDE.

**Linha de comando (Git Bash):**
```bash
bash build.sh                       # copia as DLLs e gera bin\TestesNFe.exe (gráfico) e bin\TestesNFe_Console.exe
ACBR_DIR=D:/ACBr bash build.sh      # ACBr em outra pasta
bin\TestesNFe.exe                   # runner GRÁFICO: árvore de testes, Run, detalhes da falha
bin\TestesNFe_Console.exe --exitbehavior:Continue             # console / CI
bin\TestesNFe_Console.exe --run:uTestNFe03ManipulacaoXML      # um fixture
```

O runner gráfico é o padrão do `TestesNFe.dpr`. O console é ativado com a
diretiva `CONSOLE_TESTRUNNER` e é o único que gera o XML NUnit. O `build.sh`
compila com `$R+ $Q+` (verificação de faixa e overflow), como o Debug do IDE.

Saídas em `bin\`:
- `TestesNFe_resultado.xml`: resultado no formato NUnit (CI).
- `rastreio_etapas.log`: classificação de codificação por etapa, achados e divergências.
- `saida\`: XMLs gerados, envelopes de envio/retorno, PDFs, ESC/POS, relatórios CSV de cobertura.

Nenhum teste acessa a rede: os serviços usam a SEFAZ simulada (`OnTransmit`) e
os componentes sem simulação recebem um bloqueio que gera exceção em qualquer
tentativa de transmissão.

**Arquivos a ignorar no SVN** (`svn:ignore`): `bin`, `dcu`, `__history`,
`__recovery`, `*.dproj.local`, `*.identcache`, `*.delphilsp.json`, `*.dcu`.

---

## 3. Cenários (NT / tipo de operação)

O construtor `PreencherNFe` monta uma NF-e completa "do zero". O cenário é
identificado por um código:

`<modelo>_<RTC|SemRTC>_<INT|IES|EXT>_<CF|NCF>[_ENT][_RET]`

| Parte | Significado | Efeito no XML |
|---|---|---|
| `55` / `65` | NF-e / NFC-e | `<mod>`, QR-Code e `infNFeSupl` na NFC-e |
| `RTC` / `SemRTC` | com/sem Reforma Tributária (NT 2025.002) | `<IBSCBS>`, `<IBSCBSTot>`, `cMunFGIBS`, `vItem`, `vNFTot` |
| `INT` | operação interna (idDest=1) | CFOP 5102, ICMS 18% |
| `IES` | interestadual (idDest=2) | CFOP 6102/6108, destinatário MG, ICMS 12% |
| `EXT` | exportação (idDest=3) | CFOP 7102, `idEstrangeiro`, `<exporta>`, ICMS CST 41 |
| `CF` / `NCF` | consumidor final ou não | `indFinal`, DIFAL `<ICMSUFDest>` quando IES+CF |
| `ENT` | endereço de entrega | `<entrega>` |
| `RET` | endereço de retirada | `<retirada>` |

Todos os cenários de NF-e incluem transportadora, volumes, cobrança (fatura e
duplicata), pagamento, informações complementares, `obsCont` e `infRespTec`.
Os campos de texto recebem caracteres especiais (`TXT_ESPECIAL`):

```
Ação & Cia <Ltda> "aspas" 'apóstrofo' nº 1º/2ª - São João D'Ávila ÀÈÌÒÙ âêîôû äëïöü ñÑ çÇ ãõ ÃÕ ¹²³ ½ ©®
```

> O schema da SEFAZ só aceita caracteres Latin-1 (padrão `[!-ÿ]`). `€ – — ™ • …`
> existem no CP1252, mas são rejeitados na validação. Há um teste específico para isso.

---

## 4. Fixtures e casos de teste

### 4.1 `uTestNFe01Componente`: métodos utilitários e pré-condições

| Caso | Método(s) | Verifica |
|---|---|---|
| GetNomeModeloDFe_NFe / _NFCe | `GetNomeModeloDFe` | `NFe` / `NFCe` |
| GetNameSpaceURI_PortalFiscal | `GetNameSpaceURI` | namespace oficial |
| CstatConfirmada (4 casos) | `CstatConfirmada` | 100/150 = True; 204/302 = False |
| CstatProcessado (7 casos) | `CstatProcessado` | 100/120/150 = True; denegadas = False (regra do ACBr) |
| CstatCancelada (5 casos) | `CstatCancelada` | 101/135/151/155 = True |
| EhAutorizacao_NFe400_SP | `EhAutorizacao` | layout 4.00 |
| LerVersaoDeParams / LerServicoDeParams | `LerVersaoDeParams`, `LerServicoDeParams` | versão 4.00 e URL de homologação SP |
| IdentificaSchema | `IdentificaSchema` | NFe, inutilização, cancelamento, CC-e |
| GerarNomeArqSchema / Evento | `GerarNomeArqSchema`, `GerarNomeArqSchemaEvento` | `nfe_v4.00.xsd`, `e110110_v1.00.xsd` |
| AjustarVersaoQRCode | `AjustarVersaoQRCode` | 4.00 → mínimo `veqr100`; 3.10 → `veqr000` |
| GetURLConsultaNFCe / GetURLQRCode | `GetURLConsultaNFCe`, `GetURLQRCode` | URL SP; QR-Code com chave e `p=` |
| GerarChaveContingencia_FSDA | `GerarChaveContingencia` | 36 dígitos |
| SetStatus_DisparaOnStatusChange | `SetStatus`, `Status`, `OnStatusChange` | evento disparado |
| Gravar_ArquivoUTF8ComDeclaracao | `TACBrDFe.Gravar` | UTF-8 com declaração, `ConteudoEhUTF8` True/False |
| Enviar_SemNotas / MaisDe50Notas | `Enviar` | exceção |
| EnviarEvento_SemEventos, Cancelamento_SemNotas | `EnviarEvento`, `Cancelamento` | exceção |
| Imprimir*PDF_SemDANFE, EnviarEmail_SemACBrMail | `ImprimirEventoPDF`, `ImprimirInutilizacaoPDF`, `ImprimirPDF`, `EnviarEmail` | exceção |

### 4.2 `uTestNFe02GeracaoXML`: criação de XML por cenário

| Caso | Cenários | Verifica |
|---|---|---|
| GerarXML_EstruturaDoCenario | 13 | grupos presentes/ausentes conforme o cenário (IBSCBS, entrega, retirada, exporta, ICMSUFDest, idDest, indFinal, transporta, cobr, pag, infRespTec) e declaração UTF-8 |
| GerarXML_TextoEspecialPreservado | 5 | `XMLOriginal` em UTF-8 correto; recarregar preserva todos os campos de texto |
| ChaveDeAcesso_DigitoVerificador | 4 | 44 dígitos, cUF, CNPJ, modelo, DV (`GerarDigito`) e `Ide.cDV` |
| Assinar_AssinaturaValidaETextoPreservado | 6 | `XMLAssinado` em UTF-8, `<Signature>`, `VerificarAssinatura` |
| Validar_Schema | 6 | `Validar` contra os XSD oficiais (`Exemplos\ACBrDFe\Schemas\NFe`) |
| ValidarRegrasdeNegocios | 4 | `TNotasFiscais.ValidarRegrasdeNegocios` e `NotaFiscal.ValidarRegrasdeNegocios` |
| NFCe_Assinar_GeraQRCodeEUrlChave | NFC-e | `infNFeSupl`, `qrCode`, `urlChave` |
| RetirarAcentos_True | — | XML sem acentos com `RetirarAcentos = True` |
| CaracteresReservados_SaoEscapadosNoXML | — | `&` → `&amp;`, `<` → `&lt;` |
| NotasFiscais_GerarNFe_GeraTodas | 3 notas | `GerarNFe`, chaves distintas |
| GerarTXT_ComACBrXmlDocument_RetornaVazio | — | **achado** documentado (ver §6) |
| Validar_SimbolosCP1252ForaDoLatin1 | — | schema rejeita `€ –` |
| Alertas / CalcularNomeArquivoCompleto / NumID | — | `Alertas` (natOp > 60), nome do arquivo, chave = `infNFe.ID` |

### 4.3 `uTestNFe03ManipulacaoXML`: ida e volta de todos os métodos de XML

Cada método recebe uma NF-e com `TXT_ESPECIAL`. O resultado é recarregado num
componente **novo** e comparado campo a campo (`CompararCampos`). Os bytes
produzidos também são classificados.

| Caso | Caminho testado |
|---|---|
| M01 | `GerarXML` → `LoadFromString` |
| M02 | `NotaFiscal.GravarXML` → `LoadFromFile` (+ `NomeArq`) |
| M03 | `TNotasFiscais.GravarXML` → `LoadFromFile` |
| M04 | `GravarStream` → `LoadFromStream` |
| M05 | `Assinar` → `XMLAssinado` → `LoadFromString` + assinatura válida |
| M06 | `Assinar` → `GravarXML` → `LoadFromFile` + `VerificarAssinatura` |
| M07 / M08 / M09 | setter `XML`, `LerXML`, setter `XMLOriginal` (sem reconversão) |
| M10 / M11 | `GerarNFeIni` / `GerarIni` → arquivo → `LoadFromIni` |
| M12 | `GerarJSON` → `LoadFromJSON` |
| M13 / M14 | `LoadFromString` / `LoadFromFile` com `AGerarNFe = True` (XML regenerado idêntico) |
| M15 | `GravarTXT` |
| M16 | `TACBrNFe.Gravar` (uma única declaração) |
| F01 a F04 | entrada UTF-8 com BOM, UTF-8 sem declaração, ISO-8859-1, string nativa |
| F05 | lote `enviNFe` com 2 NF-e (`LoadFromString` separa as notas) |
| F06 | nfeProc autorizado (mock) → `GravarXML` → `LoadFromFile` → `procNFe.xMotivo` e assinatura |
| F07 | XMLs anexados: correto (assinatura válida) e corrompido (assinatura inválida) |
| F08 | 5 ciclos carregar → gravar → recarregar sem degradação |
| C01 | `Add`, `Insert`, `Clear`, `Count`, `GetNamePath` |
| G (15 casos) | grupos de caracteres em XML + INI + JSON + assinatura: agudos, til, cedilha, circunflexo, crase, trema, ñ, `&`, `< >`, aspas, apóstrofo, ordinais, símbolos CP1252, sobrescritos, fora do CP1252 |

### 4.4 `uTestNFe04WebServices`: serviços SEFAZ (mock)

| Caso | Método(s) | Verifica |
|---|---|---|
| StatusServico | `WebServices.StatusServico.Executar` | cStat 107, `xMotivo` nativo com acento |
| Enviar_Sincrono_Autorizada (4 cenários) | `Enviar(lote, False, True)` | requisição em UTF-8, `Confirmada`, `Processada`, nProt, `Msg`, nfeProc com uma declaração, assinatura |
| Enviar_Assincrono_Autorizada | `Enviar(lote, False, False)` | sequência Autorização → RetAutorização, recibo |
| Enviar_Rejeicao_NaoConfirma | `Enviar` | exceção com `xMotivo`; não vira nfeProc |
| Enviar_Denegada_NaoConfirmaNemProcessa | `Enviar` | exceção; cStat 302 |
| Enviar_DigestDivergente | `Enviar` + `ValidarDigest` | exceção |
| Enviar_FalhaHTTP | `Enviar` | exceção |
| Enviar_RespostaSemDeclaracao | `Enviar` | retorno sem `<?xml?>` |
| Enviar_xMotivoComEntidades | `Enviar` assíncrono | `&amp; &lt; &#231;` decodificados corretamente |
| Enviar_SalvaArquivosDeEnvioERetorno | `Enviar` + `Arquivos.Salvar` | `env-lot`, `rec`, nfeProc gravados em UTF-8 |
| Consultar_PorChave | `Consultar(chave)` | cStat, protocolo |
| Consultar_NotaCarregada_AtualizaNfeProc | `Consultar` | `XMLOriginal` vira nfeProc em UTF-8 |
| Cancelamento_GeraEventoEVinculaNFe | `Cancelamento` | Consulta + Evento, `xJust` acentuado |
| EnviarCartaCorrecao_TextoAcentuado | `EnviarCartaCorrecao` | `xCorrecao` com acentos e `&` escapado |
| EnviarEvento_ManifestacaoDestinatario | `EnviarEvento` | tpEvento 210240, AN (cOrgao 91) |
| Inutilizar | `Inutilizar` | cStat 102, protocolo |
| ConsultaCadastro_NomeAcentuado | `WebServices.ConsultaCadastro` | `xNome` e `xMun` com acentos |
| DistribuicaoDFePorUltNSU / PorNSU / PorChaveNFe | `DistribuicaoDFe*` | docZip gzip/base64, `resNFe.xNome` acentuado |
| AdministrarCSC_NFCe | `AdministrarCSC` | UF AM, cStat 150 |
| ObterListaChaves / ObterDownloadXml | `ObterListaChaves`, `ObterDownloadXml` | NFC-e SP |
| GravarStream_Evento | `TACBrNFe.GravarStream` | **achado** (ver §6) |

### 4.5 `uTestNFe05Impressao`: DANFE e eventos

| Caso | Método(s) | Verifica |
|---|---|---|
| NFe_ImprimirPDF_Arquivo (3 cenários) | `NotasFiscais.ImprimirPDF` (FPDF) | `%PDF`, `%%EOF`, tamanho |
| NFe_ImprimirPDF_Stream / NotaFiscal_ImprimirPDF_Stream | `ImprimirPDF(AStream)` | PDF em stream |
| NFe_ImprimirPDF_NfeProcAutorizado / XMLAnexadoCorreto | `ImprimirPDF` | DANFE de nfeProc e do XML real |
| NFe_ImprimirEventoPDF_Cancelamento / CCe | `ImprimirEventoPDF` | PDF do evento |
| NFe_ImprimirResumidoPDF / InutilizacaoPDF | — | FPDF não implementa (exceção documentada) |
| NFCe_ImprimirPDF_FPDF | `ImprimirPDF` (TACBrNFCeDANFeFPDF) | PDF da NFC-e |
| NFCe_ESCPOS_Imprimir / Resumido / Cancelado | `Imprimir`, `ImprimirResumido`, `ImprimirCancelado` | ESC/POS gravado em arquivo |
| NFe_Imprimir_ImpressoraWindows | `Imprimir` | `[Ignore]`: executar manualmente |

### 4.6 `uTestNFe06ProtocoloMensagem`: protocolo 100/120/150 com mensagem da SEFAZ

A SEFAZ pode devolver no `<protNFe>` uma mensagem ao contribuinte (`cMsg`/`xMsg`).
O mock envia um `xMsg` com acentos e entidades (`&amp;`, `&lt;SEFAZ&gt;`).

| Caso | Modos | Verifica |
|---|---|---|
| Autorizacao_ComMensagemSEFAZ_Acentuada | 100/120/150 × síncrono, assíncrono, consulta (9 casos) | `Confirmada`, `Processada`, `cStat`, `procNFe.xMotivo/cMsg/xMsg` nativos; nfeProc com `<xMsg>` escapado, UTF-8 correto, uma declaração; assinatura |
| Autorizacao_ComMensagem_GravarERecarregar | 120 × S/A | `GravarXML` → `LoadFromFile`: cStat, cMsg, xMsg, xMotivo, campos da NF-e e assinatura |
| Autorizacao120_SemMensagem_NaoGeraTagXMsg | — | sem `cMsg` no retorno, o nfeProc não tem `<xMsg>` |
| Autorizacao120_DANFE_PDF | — | DANFE FPDF de nota com cStat 120 |

### 4.7 `uTestNFe07CoberturaPropriedades`: cobertura de todas as propriedades (INI/JSON)

O motor `Base\uRttiCobertura.pas` percorre **por RTTI todas as propriedades**
graváveis, inclusive objetos aninhados e coleções (adiciona um item via `New`).
Ele preenche cada propriedade com um valor distinto do padrão (texto com acento,
CNPJ/CPF válidos, números, datas, enums, boolean) e depois lista e compara
"caminho=valor". Propriedades novas no ACBr entram no teste automaticamente.

| Caso | Fluxo | Critério |
|---|---|---|
| Configuracoes_GravarIni_LerIni_TodasPropriedades | todas as propriedades de `Configuracoes` (Geral, WebServices, Certificados, Arquivos, RespTec) → `GravarIni` → arquivo → componente novo → `LerIni` | todas preservadas |
| NFe_GerarNFeIni_LoadFromIni_TodasPropriedades (3 cenários) | cenário completo + todas as propriedades vazias preenchidas → `GerarNFeIni` → arquivo → `LoadFromIni` | todas as **aplicáveis** preservadas |
| NFe_GerarJSON_LoadFromJSON_TodasPropriedades (2 cenários) | idem com `GerarJSON` / `LoadFromJSON` | idem |
| NFref_PorTipo (12 casos) | uma nota referenciada de cada tipo (refNFe, refNFeSig, refCTe, RefNF, RefNFP, RefECF) × INI/JSON | todos os campos do NFref |

**O que é "aplicável":** o XML oficial serve de referência. Uma propriedade é
aplicável ao cenário quando sobrevive a `GerarXML` → `LoadFromString`. Campos que
dependem de outro CST (ex.: `vICMSST` com CST 00) não vão para o XML e ficam
como `NAO_APLICAVEL`. O INI e o JSON precisam preservar tudo o que o XML preserva.
Ficam fora da comparação: chave e campos que a compõem, assinatura, QR-Code e
`procNFe` (protocolo é saída da SEFAZ, coberto no fixture 06).

Relatórios CSV em `bin\saida\cobertura\` (`status;propriedade;esperado;xml;ini|json`),
com os status PRESERVADA, PERDIDA, ALTERADA, NAO_APLICAVEL e SO_NO_INI/SO_NO_JSON.

Números por execução (NF-e 55 RTC, interestadual, entrega e retirada): 1072
propriedades, 634 aplicáveis no XML; INI preserva 615, JSON preserva 584.

### 4.8 `uTestNFe08FusoHorario`: fuso horário (offset) em dhEmi, dhSaiEnt, dhEvento e dhRecbto

Como o ACBr trabalha: na **geração**, o offset vem do `TimeZoneConf` global
(copiado de `Configuracoes.WebServices.TimeZoneConf` em `NotaFiscal.GerarXML`),
em três modos: `tzSistema` (fuso do Windows), `tzPCN` (pela UF) e `tzManual`
(`TimeZoneStr`). Na **leitura**, `ParseDataHora` descarta o offset e o objeto
guarda só a hora de relógio.

| Caso | Verifica |
|---|---|
| Sistema_UsaFusoDoWindows | `dhEmi` com o offset do Windows |
| PorUF_OffsetDaUF (11 UFs) | SP/RJ/DF/PA/RS −03:00; AM/MS/MT/RO/RR −04:00; AC −05:00 (`dhEmi` e `dhSaiEnt`) |
| Manual (6 offsets) | `dhEmi`/`dhSaiEnt` com o `TimeZoneStr` configurado; a hora de relógio não muda |
| Manual_TimeZoneStrAntesDoModo | `TimeZoneStr` atribuído antes de `ModoDeteccao := tzManual` é **descartado** (documentado) |
| Manual_TimeZoneStrInvalido (4 casos) | formatos inválidos geram exceção |
| PorUF_HorarioDeVerao (5 casos) | horário de verão até 2018 (SP −02:00, MS −03:00), extinto desde 2019 |
| Leitura_GuardaHoraDeRelogio | `Ide.dEmi` guarda 10:00 de `10:00:00-05:00`, sem converter |
| Leitura_XMLOriginalPreservaOffset | sem regerar, `XMLOriginal` mantém o offset e a assinatura |
| Regerar / Assinar nota carregada | ao regerar ou assinar, o offset deve continuar o do XML original |
| IdaEVolta (INI, JSON) | o offset do `dhEmi` sobrevive a Gerar/Load |
| Protocolo_dhRecbto | nfeProc mantém o `dhRecbto` da SEFAZ com o offset dela |
| Evento_dhEvento | evento usa o fuso do próprio componente, mesmo após outro componente gerar em outro fuso |
| DoisComponentes | componentes com fusos diferentes não interferem um no outro |

### 4.9 Regressão do bug de acentuação (dupla conversão UTF-8)

`uTestConversoes`, `uTestXmlDocument` e `uTestFluxoNFe` são os testes que
reproduziram e validaram a correção da dupla conversão no `TProcDFe.GerarXML`.
Eles rastreiam cada etapa (Load → GerarXML → Assinar → Envio → Retorno →
`Items[i]` → arquivo → banco). Detalhes em `bin\rastreio_etapas.log`.

---

## 5. Matriz de cobertura de métodos

| Classe | Método | Coberto em |
|---|---|---|
| TACBrNFe | Enviar (Int64 e String) | 01, 04, 05 |
| | Cancelamento | 01, 04, 05 |
| | Consultar | 04 |
| | EnviarCartaCorrecao | 04 |
| | EnviarEvento | 01, 04, 05 |
| | Inutilizar | 04, 05 |
| | DistribuicaoDFe / PorUltNSU / PorNSU / PorChaveNFe | 04 |
| | AdministrarCSC | 04 |
| | ObterDFe / ObterListaChaves / ObterDownloadXml | 04 |
| | ImprimirEvento / ImprimirEventoPDF | 01, 05 |
| | ImprimirInutilizacao / ImprimirInutilizacaoPDF | 01, 05 |
| | GravarStream | 04 |
| | EnviarEmail / EnviarEmailEvento | 01 (pré-condição) |
| | GetNomeModeloDFe, GetNameSpaceURI, EhAutorizacao | 01 |
| | CstatConfirmada / CstatProcessado / CstatCancelada | 01 |
| | LerServicoDeParams, LerVersaoDeParams | 01 |
| | AjustarVersaoQRCode, GetURLConsultaNFCe, GetURLQRCode | 01 |
| | IdentificaSchema, GerarNomeArqSchema, GerarNomeArqSchemaEvento | 01 |
| | GerarChaveContingencia, SetStatus | 01 |
| | Gravar (TACBrDFe) | 01, 03 |
| TNotasFiscais | Add, Insert, Clear, GetNamePath | 03 |
| | GerarNFe, Assinar, Validar, VerificarAssinatura, ValidarRegrasdeNegocios | 02, 03 |
| | LoadFromFile / Stream / String / Ini / JSON | 02, 03 |
| | GerarIni, GerarJSON, GravarXML, GravarTXT | 03 |
| | Imprimir, ImprimirCancelado, ImprimirResumido | 05 |
| | ImprimirPDF (arquivo e stream), ImprimirResumidoPDF | 01, 05 |
| NotaFiscal | GerarXML, LerXML, XML, XMLOriginal, XMLAssinado | 02, 03 |
| | Assinar, Validar, VerificarAssinatura, ValidarRegrasdeNegocios | 02, 03 |
| | GravarXML, GravarStream, GerarTXT, GravarTXT | 02, 03 |
| | GerarNFeIni, LerArqIni, GerarJSON, LerJSON | 03 |
| | ImprimirPDF (stream) | 05 |
| | CalcularNomeArquivoCompleto, NumID, Alertas, Confirmada, Processada, cStat, Msg | 02, 04 |

Fora do escopo automatizado: envio real de e-mail (exige servidor SMTP) e
impressão em impressora do Windows (`[Ignore]`).

---

## 6. Achados registrados pelos testes

Resultados com o ACBr r49091 + correção do `TProcDFe` (patch `correcao_utf8_nfe`):

| Testes | Passam | Falham | Ignorados |
|---|---|---|---|
| 296 | 279 | 16 | 1 |

**Defeitos do ACBr (testes falham até a correção):**

| Teste | Achado |
|---|---|
| M10 / M11 | `GerarNFeIni` → `LoadFromIni` **perde `Retirada.xNome`**. XML e JSON preservam. |
| GravarStream_Evento | `TACBrNFe.GravarStream` chama `EventoNFe.GerarXML` sem aplicar as configurações: o XML sai **sem acentos** e com `versao=""`, diferente do que é enviado à SEFAZ. |
| Cobertura INI: Configurações | `WebServices.ResourceName` não é gravado por `GravarIni` (volta a `ACBrNFeServicos`). |
| Cobertura INI: NF-e | `GerarNFeIni`/`LoadFromIni` perdem: **Retirada** (`xNome`, `CEP`, `fone`, `Email`; `cPais`/`xPais` voltam ao padrão), `Ide.gCompraGov.refDFeAnt[].refDFeChave`, `Det[].Prod.DI[].vAFRMM`, `Det[].Imposto.IBSCBS.gCredPresOper.gIBSCredPres/gCBSCredPres.vCredPresCondSus` e `Total.IBSCBSTot.gMono.*` (`vIBSMono`, `vCBSMono`, `vIBSMonoReten`, `vCBSMonoReten`, `vIBSMonoRet`, `vCBSMonoRet`). |
| Cobertura JSON: NF-e | `GerarJSON`/`LoadFromJSON` perdem: `Ide.dPrevEntrega`; **`exporta`** (`UFSaidaPais`, `xLocExporta`, `xLocDespacho`); `pgtoVinc.pgto[]` inteiro; `PIS.vPIS/qBCProd/vAliqProd`, `PISST` e `COFINSST` (`qBCProd`, `vAliqProd`); IBSCBS `gEstornoCred`, `gCredPresOper` (`vBCCredPres`, `pCredPres`, `vCredPresCondSus`, `cCredPres`), `indDoacao`, `tpCredPresIBSZFM`; `Total.IBSCBSTot.gEstornoCred` e `gTribSN`. E **troca `pCredPresumido` com `vCredPresumido`** em `Prod.CredPresumido[]`. |
| Autorizacao_ComMensagemSEFAZ_Acentuada.120 consulta | `ACBrNFe.RetConsSit.pas:196` só lê o `<protNFe>` quando o cStat da consulta está em `[100, 101, 104, 150, 151, 155]`, **sem o 120**. Consultar uma nota 120 perde `xMotivo`, `cMsg`, `xMsg`, `nProt` e `digVal`, e não atualiza o nfeProc, embora o ACBr trate 120 como autorizada. Correção: incluir 120 na lista (validada: o teste passa). |
| DANFE_ManterProtocolo_Contingencia (120 e 150) | `ACBrNFeDANFEClass.ManterProtocolo` (linha 754) só imprime o protocolo em contingência quando `cStat = 100`. Notas **120 (autorizada com alerta)** e **150 (autorizada fora de prazo, o caso típico de contingência)** saem sem protocolo no DANFE. |
| Fuso: Regerar / Assinar nota carregada / INI / JSON | O objeto NF-e não guarda o offset (`ParseDataHora` o descarta). Ao regerar o XML de uma nota carregada (`LoadFrom*` com `AGerarNFe`, `Assinar`, logo também `Enviar`) ou ao passar por INI/JSON, o offset vira o da configuração atual: `10:00:00-05:00` vira `10:00:00-03:00`, e o **instante da emissão muda em 2 horas**. |
| (análise estática, sem teste) | Mesmo padrão "só 100": `ACBrECFVirtualNFCe.pas:837/919` trata 120/150 como não autorizada; DANFE Fortes `Etiqueta:241/323` e `Simplificado:368/615` mostram o `xMotivo` como aviso e omitem o rótulo "Protocolo de Autorização" para 120/150. |

**Comportamentos documentados (testes passam, registrando o comportamento atual):**

| Teste | Comportamento |
|---|---|
| GerarTXT / M15 | Com `USE_ACBr_XMLDOCUMENT` (padrão), `GerarTXT` devolve `''` e `GravarTXT` grava um arquivo vazio, sem exceção nem alerta. |
| Grupo 15 | Caracteres fora do CP1252 (`Ł`, grego, `✓`) viram `?` no XML e no INI (o writer usa `AnsiString`). O JSON preserva. |
| Validar_SimbolosCP1252ForaDoLatin1 | `€ – — ™ • …` são gerados no XML, mas o schema da SEFAZ os rejeita. |
| CstatProcessado | Denegadas (110/301/302) não são "Processadas" para o ACBr. |
| Enviar (rejeição/denegada) | `Enviar` gera exceção com o `xMotivo`. |
| ImprimirEventoPDF (FPDF) | O PDF é gerado, mas `DANFE.ArquivoPDF` fica vazio. |
| ImprimirResumidoPDF / ImprimirInutilizacaoPDF | Não implementados no `TACBrNFeDANFeFPDF`. |
| GerarNFeIni | Exige `GerarXML` antes (senão: "NFe Inconsistente para gerar INI. Chave Inválida"). |

**Efeito do `ACBrXmlDocument.pas` alterado** (OuterXml/InnerXml com
`UTF8ToNativeString`): 8 falhas a mais. O `protNFe` é gravado em CP1252 dentro
do nfeProc (`homologação` vira `a??o` ao recarregar, F06), e o `OuterXml` não
pode mais ser re-parseado pela libxml2.
