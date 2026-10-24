unit uPIXUtils;

{
  PIX DINÂMICO VIA PSP (ACBrPIXCD) - rotinas de apoio do PDV

  É o "uTEFUtils" do PIX:
    - ConfigurarPIXPeloINI: aplica no ACBrPixCD a configuração gravada pela
      tela uframeConfigPIX (mesmas chaves de INI do exemplo do ACBrPIXCD) e
      CRIA, em tempo de execução, o componente do PSP escolhido. Assim o
      frmPrincipal só precisa do ACBrPixCD1 (sem 21 componentes de PSP).
    - Cobrança imediata (cob), igual ao "Fluxo de Pagamento" do exemplo:

        PIXCriarCobranca      -> TxId + QR Code (pixCopiaECola)
        PIXConsultarCobranca  -> repete até CONCLUIDA; devolve o e2eid
        PIXCancelarCobranca   -> cliente desistiu antes de pagar
        PIXDevolver           -> estorno de um PIX já pago (NFC-e falhou)

  Vínculo com a NFC-e (ver uVinculoPagamentoNFCe):
    tPag = 17 | tpIntegra = 1 | CNPJ = CNPJ do PSP | cAut = e2eid (endToEndId)
}

interface

uses
  Classes, SysUtils, IniFiles,
  ACBrPIXCD, ACBrPIXBase,
  uClassePagamento;   // TListaPagamentos

type
  EPIXErro = class(Exception);

  TPIXCobranca = record
    TxId: String;        // identificador da cobrança (gerado pelo PDV)
    QRCode: String;      // "pix copia e cola" exibido em QR Code
  end;

// O operador ligou o PIX via PSP na tela de configuração?
function PIXHabilitado(const AArqINI: String): Boolean;

// Nome do PSP configurado (ex.: "Banco do Brasil")
function PIXNomePSP(const AArqINI: String): String;

// Tempo de expiração da cobrança, em segundos ([Cobranca] Expiracao)
function PIXExpiracaoCobranca(const AArqINI: String): Integer;

// Aplica a configuração do INI no componente (e cria o PSP)
procedure ConfigurarPIXPeloINI(APixCD: TACBrPixCD; const AArqINI: String);

// Cobrança imediata
function PIXCriarCobranca(APixCD: TACBrPixCD; AValor: Currency;
  AExpiracao: Integer): TPIXCobranca;
function PIXConsultarCobranca(APixCD: TACBrPixCD; const ATxId: String;
  out AEndToEndId: String): TACBrPIXStatusCobranca;
function PIXCancelarCobranca(APixCD: TACBrPixCD; const ATxId: String): Boolean;
function PIXDevolver(APixCD: TACBrPixCD; const AEndToEndId: String;
  AValor: Currency): Boolean;

// Devolve TODOS os PIX (PSP) não cancelados da venda (ex.: NFC-e não autorizada).
// Marca os devolvidos como Cancelados; gera EPIXErro se algum falhar.
function PIXDevolverPagamentos(APixCD: TACBrPixCD; APagamentos: TListaPagamentos): Integer;

implementation

uses
  synacode,
  ACBrUtil.Strings, ACBrUtil.Base, ACBrUtil.FilesIO, ACBrPIXUtil, ACBrPIXSchemasCob,
  ACBrPIXSchemasProblema,
  ACBrPIXSchemasDevolucao,
  ACBrPIXPSPShipay, ACBrPIXPSPBancoDoBrasil, ACBrPIXPSPItau, ACBrPIXPSPSantander,
  ACBrPIXPSPSicredi, ACBrPIXPSPSicoob, ACBrPIXPSPPagSeguro, ACBrPIXPSPGerenciaNet,
  ACBrPIXPSPBradesco, ACBrPIXPSPPixPDV, ACBrPIXPSPInter, ACBrPIXPSPAilos,
  ACBrPIXPSPMatera, ACBrPIXPSPCielo, ACBrPIXPSPMercadoPago, ACBrPIXPSPGate2All,
  ACBrPIXPSPBanrisul, ACBrPIXPSPC6Bank, ACBrPIXPSPAppLess, ACBrPIXPSPQQPag,
  ACBrPIXPSPCrediSIS;

const
  CURL_ACBR = 'https://projetoacbr.com.br/tef/';   // chave usada pelo exemplo p/ cifrar senhas

  // Mesma ordem do combo "PSP Atual" (abas da tela uframeConfigPIX)
  CNomesPSP: array[0..20] of String = (
    'Shipay', 'Banco do Brasil', 'Itaú', 'Santander', 'Sicredi', 'Sicoob',
    'PagSeguro', 'GerenciaNet', 'Bradesco', 'PIXPDV', 'Inter', 'Ailos', 'Matera',
    'Cielo', 'Mercado Pago', 'Gate2All', 'Banrisul', 'C6 Bank', 'AppLess',
    'Quero Quero Pag', 'CrediSis');

function AbrirINI(const AArqINI: String): TIniFile;
begin
  Result := TIniFile.Create(AArqINI);
end;

function PIXHabilitado(const AArqINI: String): Boolean;
var
  Ini: TIniFile;
begin
  Ini := AbrirINI(AArqINI);
  try
    Result := Ini.ReadBool('PIX', 'Habilitado', False);
  finally
    Ini.Free;
  end;
end;

function PIXNomePSP(const AArqINI: String): String;
var
  Ini: TIniFile;
  LIndice: Integer;
begin
  Ini := AbrirINI(AArqINI);
  try
    LIndice := Ini.ReadInteger('PIX', 'PSP', 0);
  finally
    Ini.Free;
  end;
  if (LIndice >= Low(CNomesPSP)) and (LIndice <= High(CNomesPSP)) then
    Result := CNomesPSP[LIndice]
  else
    Result := '';
end;

function PIXExpiracaoCobranca(const AArqINI: String): Integer;
var
  Ini: TIniFile;
begin
  Ini := AbrirINI(AArqINI);
  try
    Result := Ini.ReadInteger('Cobranca', 'Expiracao', 3600);
  finally
    Ini.Free;
  end;
end;

{ ------------------------------ Configuração ------------------------------- }

// Cria o componente do PSP escolhido (mesma ordem do combo da configuração)
function CriarPSP(AIndice: Integer; AOwner: TComponent): TACBrPSP;
begin
  case AIndice of
    0: Result := TACBrPSPShipay.Create(AOwner);
    1: Result := TACBrPSPBancoDoBrasil.Create(AOwner);
    2: Result := TACBrPSPItau.Create(AOwner);
    3: Result := TACBrPSPSantander.Create(AOwner);
    4: Result := TACBrPSPSicredi.Create(AOwner);
    5: Result := TACBrPSPSicoob.Create(AOwner);
    6: Result := TACBrPSPPagSeguro.Create(AOwner);
    7: Result := TACBrPSPGerenciaNet.Create(AOwner);
    8: Result := TACBrPSPBradesco.Create(AOwner);
    9: Result := TACBrPSPPixPDV.Create(AOwner);
    10: Result := TACBrPSPInter.Create(AOwner);
    11: Result := TACBrPSPAilos.Create(AOwner);
    12: Result := TACBrPSPMatera.Create(AOwner);
    13: Result := TACBrPSPCielo.Create(AOwner);
    14: Result := TACBrPSPMercadoPago.Create(AOwner);
    15: Result := TACBrPSPGate2All.Create(AOwner);
    16: Result := TACBrPSPBanrisul.Create(AOwner);
    17: Result := TACBrPSPC6Bank.Create(AOwner);
    18: Result := TACBrPSPAppLess.Create(AOwner);
    19: Result := TACBrPSPQQPag.Create(AOwner);
    20: Result := TACBrPSPCrediSIS.Create(AOwner);
  else
    raise EPIXErro.Create('PSP configurado é inválido: ' + IntToStr(AIndice));
  end;
end;

// Credenciais do PSP: mesmas chaves e regras do ConfigurarACBrPSPs do exemplo
procedure ConfigurarPSPPeloINI(APSP: TACBrPSP; Ini: TIniFile);
begin
  if (APSP is TACBrPSPShipay) then
    with TACBrPSPShipay(APSP) do
    begin
      ClientID := Ini.ReadString('Shipay', 'ClientID', '');
      SecretKey := Ini.ReadString('Shipay', 'SecretKey', '');
      AccessKey := Ini.ReadString('Shipay', 'AccessKey', '');
    end

  else if (APSP is TACBrPSPBancoDoBrasil) then
    with TACBrPSPBancoDoBrasil(APSP) do
    begin
      ChavePIX := Ini.ReadString('BancoBrasil', 'ChavePIX', '');
      ClientID := Ini.ReadString('BancoBrasil', 'ClientID', '');
      ClientSecret := Ini.ReadString('BancoBrasil', 'ClientSecret', '');
      DeveloperApplicationKey := Ini.ReadString('BancoBrasil', 'DeveloperApplicationKey', '');
      BBAPIVersao := TACBrBBAPIVersao(Ini.ReadInteger('BancoBrasil', 'VersaoAPI', 0));
      if (BBAPIVersao = apiVersao2) then
      begin
        if (Ini.ReadInteger('BancoBrasil', 'TipoCertificado', 0) = 0) then  // PFX
        begin
          ArquivoPFX := Ini.ReadString('BancoBrasil', 'ArqPFX', '');
          SenhaPFX := Ini.ReadString('BancoBrasil', 'SenhaPFX', '');
        end
        else  // Certificado PEM + Chave Privada
        begin
          ArquivoChavePrivada := Ini.ReadString('BancoBrasil', 'ArqChavePrivada', '');
          ArquivoCertificado := Ini.ReadString('BancoBrasil', 'ArqCertificado', '');
        end;
      end;
    end

  else if (APSP is TACBrPSPItau) then
    with TACBrPSPItau(APSP) do
    begin
      ChavePIX := Ini.ReadString('Itau', 'ChavePIX', '');
      ClientID := Ini.ReadString('Itau', 'ClientID', '');
      ClientSecret := Ini.ReadString('Itau', 'ClientSecret', '');
      ArquivoChavePrivada := Ini.ReadString('Itau', 'ArqChavePrivada', '');
      ArquivoCertificado := Ini.ReadString('Itau', 'ArqCertificado', '');
    end

  else if (APSP is TACBrPSPSantander) then
    with TACBrPSPSantander(APSP) do
    begin
      ChavePIX := Ini.ReadString('Santander', 'ChavePIX', '');
      ConsumerKey := Ini.ReadString('Santander', 'ConsumerKey', '');
      ConsumerSecret := Ini.ReadString('Santander', 'ConsumerSecret', '');
      SenhaPFX := Ini.ReadString('Santander', 'SenhaCertificadoPFX', '');
      ArquivoPFX := Ini.ReadString('Santander', 'ArqCertificadoPFX', '');
    end

  else if (APSP is TACBrPSPSicredi) then
    with TACBrPSPSicredi(APSP) do
    begin
      ChavePIX := Ini.ReadString('Sicredi', 'ChavePIX', '');
      ClientID := Ini.ReadString('Sicredi', 'ClientID', '');
      ClientSecret := Ini.ReadString('Sicredi', 'ClientSecret', '');
      ArquivoChavePrivada := Ini.ReadString('Sicredi', 'ArqChavePrivada', '');
      ArquivoCertificado := Ini.ReadString('Sicredi', 'ArqCertificado', '');
    end

  else if (APSP is TACBrPSPSicoob) then
    with TACBrPSPSicoob(APSP) do
    begin
      ChavePIX := Ini.ReadString('Sicoob', 'ChavePIX', '');
      ClientID := Ini.ReadString('Sicoob', 'ClientID', '');
      TokenSandbox := Ini.ReadString('Sicoob', 'TokenSandbox', '');
      ArquivoChavePrivada := Ini.ReadString('Sicoob', 'ArqChavePrivada', '');
      ArquivoCertificado := Ini.ReadString('Sicoob', 'ArqCertificado', '');
    end

  else if (APSP is TACBrPSPPagSeguro) then
    with TACBrPSPPagSeguro(APSP) do
    begin
      ChavePIX := Ini.ReadString('PagSeguro', 'ChavePIX', '');
      ClientID := Ini.ReadString('PagSeguro', 'ClientID', '');
      TokenPay := Ini.ReadString('PagSeguro', 'Token', '');
      ClientSecret := Ini.ReadString('PagSeguro', 'ClientSecret', '');
      ArquivoChavePrivada := Ini.ReadString('PagSeguro', 'ArqChavePrivada', '');
      ArquivoCertificado := Ini.ReadString('PagSeguro', 'ArqCertificado', '');
    end

  else if (APSP is TACBrPSPGerenciaNet) then
    with TACBrPSPGerenciaNet(APSP) do
    begin
      ChavePIX := Ini.ReadString('GerenciaNet', 'ChavePIX', '');
      ClientID := Ini.ReadString('GerenciaNet', 'ClientID', '');
      ClientSecret := Ini.ReadString('GerenciaNet', 'ClientSecret', '');
      ArquivoPFX := Ini.ReadString('GerenciaNet', 'ArqPFX', '');
    end

  else if (APSP is TACBrPSPBradesco) then
    with TACBrPSPBradesco(APSP) do
    begin
      ChavePIX := Ini.ReadString('Bradesco', 'ChavePIX', '');
      ClientID := Ini.ReadString('Bradesco', 'ClientID', '');
      ClientSecret := Ini.ReadString('Bradesco', 'ClientSecret', '');
      APIVersao := TACBrBradescoAPIVersao(Ini.ReadInteger('Bradesco', 'APIVersao', 0));
      if (Ini.ReadInteger('Bradesco', 'TipoCertificado', 1) = 0) then  // PFX
      begin
        ArquivoPFX := Ini.ReadString('Bradesco', 'ArqPFX', '');
        SenhaPFX := Ini.ReadString('Bradesco', 'SenhaPFX', '');
      end
      else  // Certificado PEM + Chave Privada
      begin
        ArquivoChavePrivada := Ini.ReadString('Bradesco', 'ArqChavePrivada', '');
        ArquivoCertificado := Ini.ReadString('Bradesco', 'ArqCertificado', '');
      end;
    end

  else if (APSP is TACBrPSPPixPDV) then
    with TACBrPSPPixPDV(APSP) do
    begin
      CNPJ := Ini.ReadString('PixPDV', 'CNPJ', '');
      Token := Ini.ReadString('PixPDV', 'Token', '');
      ClientSecret := Ini.ReadString('PixPDV', 'SecretKey', '');
      APIVersao := TACBrPIXPDVAPIVersao(Ini.ReadInteger('PixPDV', 'VersaoAPI', 0));
    end

  else if (APSP is TACBrPSPInter) then
    with TACBrPSPInter(APSP) do
    begin
      ChavePIX := Ini.ReadString('Inter', 'ChavePIX', '');
      ClientID := Ini.ReadString('Inter', 'ClientID', '');
      ClientSecret := Ini.ReadString('Inter', 'ClientSecret', '');
      ArquivoChavePrivada := Ini.ReadString('Inter', 'ArqChavePrivada', '');
      ArquivoCertificado := Ini.ReadString('Inter', 'ArqCertificado', '');
    end

  else if (APSP is TACBrPSPAilos) then
    with TACBrPSPAilos(APSP) do
    begin
      ChavePIX := Ini.ReadString('Ailos', 'ChavePIX', '');
      ClientID := Ini.ReadString('Ailos', 'ClientID', '');
      ClientSecret := Ini.ReadString('Ailos', 'ClientSecret', '');
      ArquivoChavePrivada := Ini.ReadString('Ailos', 'ArqChavePrivada', '');
      ArquivoCertificado := Ini.ReadString('Ailos', 'ArqCertificado', '');
      RootCrt := Ini.ReadString('Ailos', 'ArqCertificadoRoot', '');
    end

  else if (APSP is TACBrPSPMatera) then
    with TACBrPSPMatera(APSP) do
    begin
      ChavePIX := Ini.ReadString('Matera', 'ChavePIX', '');
      ClientID := Ini.ReadString('Matera', 'ClientID', '');
      AccountId := Ini.ReadString('Matera', 'AccountID', '');
      SecretKey := Ini.ReadString('Matera', 'SecretKey', '');
      MediatorFee := Ini.ReadFloat('Matera', 'MediatorFee', 0);
      ClientSecret := Ini.ReadString('Matera', 'ClientSecret', '');
      ArquivoCertificado := Ini.ReadString('Matera', 'ArqCertificado', '');
      ArquivoChavePrivada := Ini.ReadString('Matera', 'ArqChavePrivada', '');
    end

  else if (APSP is TACBrPSPCielo) then
    with TACBrPSPCielo(APSP) do
    begin
      ChavePIX := Ini.ReadString('Cielo', 'ChavePIX', '');
      ClientID := Ini.ReadString('Cielo', 'ClientID', '');
      ClientSecret := Ini.ReadString('Cielo', 'ClientSecret', '');
    end

  else if (APSP is TACBrPSPMercadoPago) then
    with TACBrPSPMercadoPago(APSP) do
    begin
      ChavePIX := Ini.ReadString('MercadoPago', 'ChavePix', '');
      AccessToken := Ini.ReadString('MercadoPago', 'AccessToken', '');
      TipoChave := TACBrPIXTipoChave(Ini.ReadInteger('MercadoPago', 'TipoChave', 0));
    end

  else if (APSP is TACBrPSPGate2All) then
    with TACBrPSPGate2All(APSP) do
    begin
      AuthenticationApi := Ini.ReadString('Gate2All', 'AuthenticationApi', '');
      AuthenticationKey := Ini.ReadString('Gate2All', 'AuthenticationKey', '');
    end

  else if (APSP is TACBrPSPBanrisul) then
    with TACBrPSPBanrisul(APSP) do
    begin
      ChavePIX := Ini.ReadString('Banrisul', 'ChavePIX', '');
      ClientID := Ini.ReadString('Banrisul', 'ClientID', '');
      ClientSecret := Ini.ReadString('Banrisul', 'ClientSecret', '');
      ArquivoPFX := Ini.ReadString('Banrisul', 'ArqCertificadoPFX', '');
      SenhaPFX := Ini.ReadString('Banrisul', 'SenhaCertificadoPFX', '');
    end

  else if (APSP is TACBrPSPC6Bank) then
    with TACBrPSPC6Bank(APSP) do
    begin
      ChavePIX := Ini.ReadString('C6Bank', 'ChavePIX', '');
      ClientID := Ini.ReadString('C6Bank', 'ClientID', '');
      ClientSecret := Ini.ReadString('C6Bank', 'ClientSecret', '');
      ArquivoChavePrivada := Ini.ReadString('C6Bank', 'ArqChavePrivada', '');
      ArquivoCertificado := Ini.ReadString('C6Bank', 'ArqCertificado', '');
    end

  else if (APSP is TACBrPSPAppLess) then
    with TACBrPSPAppLess(APSP) do
    begin
      ClientID := Ini.ReadString('AppLess', 'ClientId', '');
      ClientSecret := Ini.ReadString('AppLess', 'ClientSecret', '');
      SecretKeyHMAC := Ini.ReadString('AppLess', 'HMAC', '');
    end

  else if (APSP is TACBrPSPQQPag) then
    with TACBrPSPQQPag(APSP) do
    begin
      ChavePIX := Ini.ReadString('QQPag', 'ChavePIX', '');
      ClientID := Ini.ReadString('QQPag', 'ClientID', '');
      ClientSecret := Ini.ReadString('QQPag', 'ClientSecret', '');
    end

  else if (APSP is TACBrPSPCrediSIS) then
    with TACBrPSPCrediSIS(APSP) do
    begin
      Agencia := Ini.ReadString('CrediSis', 'Agencia', '');
      Conta := Ini.ReadString('CrediSis', 'Conta', '');
      ChavePIX := Ini.ReadString('CrediSis', 'ChavePIX', '');
      ClientID := Ini.ReadString('CrediSis', 'ClientID', '');
      ClientSecret := Ini.ReadString('CrediSis', 'ClientSecret', '');
    end;
end;

procedure ConfigurarPIXPeloINI(APixCD: TACBrPixCD; const AArqINI: String);
var
  Ini: TIniFile;
  LPSPAnterior, LPSP: TACBrPSP;
begin
  Ini := AbrirINI(AArqINI);
  try
    // Quem recebe (aparece no QR Code)
    APixCD.Recebedor.Nome := Ini.ReadString('Recebedor', 'Nome', '');
    APixCD.Recebedor.CEP := Ini.ReadString('Recebedor', 'CEP', '');
    APixCD.Recebedor.Cidade := Ini.ReadString('Recebedor', 'Cidade', '');
    APixCD.Recebedor.UF := Ini.ReadString('Recebedor', 'UF', '');

    APixCD.Ambiente := TACBrPixCDAmbiente(Ini.ReadInteger('PIX', 'Ambiente', 0));
    APixCD.TimeOut := Ini.ReadInteger('PIX', 'TimeOut', APixCD.TimeOut);

    APixCD.Proxy.Host := Ini.ReadString('PIXProxy', 'Host', '');
    APixCD.Proxy.Port := Ini.ReadString('PIXProxy', 'Porta', '');
    APixCD.Proxy.User := Ini.ReadString('PIXProxy', 'User', '');
    APixCD.Proxy.Pass := StrCrypt(DecodeBase64(Ini.ReadString('PIXProxy', 'Pass', '')), CURL_ACBR);

    APixCD.ArqLOG := Ini.ReadString('PIXLog', 'Arquivo', '');
    APixCD.NivelLog := Ini.ReadInteger('PIXLog', 'Nivel', 1);

    // Software house / aplicação: os mesmos dados informados no TEF
    APixCD.DadosAutomacao.NomeSoftwareHouse := Ini.ReadString('SwHouse', 'RazaoSocial', '');
    APixCD.DadosAutomacao.CNPJSoftwareHouse := Ini.ReadString('SwHouse', 'CNPJ', '');
    APixCD.DadosAutomacao.NomeAplicacao := Ini.ReadString('Aplicacao', 'Nome', '');
    APixCD.DadosAutomacao.VersaoAplicacao := Ini.ReadString('Aplicacao', 'Versao', '');

    // PSP: cria o componente escolhido e preenche as credenciais.
    // Criado SEM dono: se a configuração falhar (ex.: chave PIX inválida),
    // o PSP atual continua valendo.
    LPSP := CriarPSP(Ini.ReadInteger('PIX', 'PSP', 0), nil);
    try
      ConfigurarPSPPeloINI(LPSP, Ini);
    except
      LPSP.Free;
      raise;
    end;

    // PSP criado por nós numa configuração anterior: desliga e libera.
    // (o ACBrPixCD esquece o PSP atual quando QUALQUER PSP é destruído,
    //  por isso desligamos antes de liberar)
    LPSPAnterior := APixCD.PSP;
    if Assigned(LPSPAnterior) and (LPSPAnterior.Owner = APixCD) then
    begin
      APixCD.PSP := nil;
      LPSPAnterior.Free;
    end;

    APixCD.InsertComponent(LPSP);   // o ACBrPixCD passa a ser o dono (libera no fim)
    APixCD.PSP := LPSP;
  finally
    Ini.Free;
  end;
end;

{ ------------------------------- Cobrança ---------------------------------- }

function DescreverProblema(const AOperacao: String; AProblema: TACBrPIXProblema): String;
begin
  Result := AOperacao + sLineBreak + AProblema.title + sLineBreak + AProblema.detail;
end;

function PIXCriarCobranca(APixCD: TACBrPixCD; AValor: Currency;
  AExpiracao: Integer): TPIXCobranca;
begin
  if not Assigned(APixCD.PSP) then
    raise EPIXErro.Create('PIX: nenhum PSP configurado.');

  with APixCD.PSP.epCob.CobSolicitada do
  begin
    Clear;
    chave := APixCD.PSP.ChavePIX;
    calendario.expiracao := AExpiracao;
    valor.original := AValor;
  end;

  // TxId gerado pelo PDV: identifica a cobrança nas consultas
  if not APixCD.PSP.epCob.CriarCobrancaImediata(CriarTxId) then
    raise EPIXErro.Create(DescreverProblema('Falha ao criar a cobrança PIX',
      APixCD.PSP.epCob.Problema));

  Result.TxId := APixCD.PSP.epCob.CobGerada.txId;
  Result.QRCode := Trim(APixCD.PSP.epCob.CobGerada.pixCopiaECola);
  if (Result.QRCode = '') then   // alguns PSPs só devolvem a "location"
    Result.QRCode := APixCD.GerarQRCodeDinamico(APixCD.PSP.epCob.CobGerada.location);
end;

function PIXConsultarCobranca(APixCD: TACBrPixCD; const ATxId: String;
  out AEndToEndId: String): TACBrPIXStatusCobranca;
begin
  AEndToEndId := '';
  if not APixCD.PSP.epCob.ConsultarCobrancaImediata(ATxId) then
    raise EPIXErro.Create(DescreverProblema('Falha ao consultar a cobrança PIX',
      APixCD.PSP.epCob.Problema));

  Result := APixCD.PSP.epCob.CobCompleta.status;
  // Pago: o PIX recebido traz o endToEndId (e2eid) -> vai no cAut da NFC-e
  if (APixCD.PSP.epCob.CobCompleta.pix.Count > 0) then
    AEndToEndId := APixCD.PSP.epCob.CobCompleta.pix[0].endToEndId;
end;

function PIXCancelarCobranca(APixCD: TACBrPixCD; const ATxId: String): Boolean;
begin
  APixCD.PSP.epCob.CobRevisada.Clear;
  APixCD.PSP.epCob.CobRevisada.status := stcREMOVIDA_PELO_USUARIO_RECEBEDOR;
  Result := APixCD.PSP.epCob.RevisarCobrancaImediata(ATxId);
end;

function PIXDevolver(APixCD: TACBrPixCD; const AEndToEndId: String;
  AValor: Currency): Boolean;
begin
  with APixCD.PSP.epPix do
  begin
    DevolucaoSolicitada.Clear;
    DevolucaoSolicitada.valor := AValor;
    DevolucaoSolicitada.natureza := ndORIGINAL;
    DevolucaoSolicitada.descricao := 'Devolucao da Venda';
    // Id da devolução: o próprio e2eid trocando "E" por "D" (igual ao exemplo)
    Result := SolicitarDevolucaoPix(AEndToEndId,
      StringReplace(AEndToEndId, 'E', 'D', [rfReplaceAll]));
  end;
end;

function PIXDevolverPagamentos(APixCD: TACBrPixCD; APagamentos: TListaPagamentos): Integer;
var
  I: Integer;
  LFalhas: String;
begin
  Result := 0;
  LFalhas := '';
  for I := 0 to APagamentos.Count - 1 do
    with APagamentos[I] do
      if (not Cancelada) and (Origem = opPSP) and (EndToEndId <> '') then
      begin
        if PIXDevolver(APixCD, EndToEndId, ValorPago) then
        begin
          Cancelada := True;
          Inc(Result);
        end
        else
          LFalhas := LFalhas + sLineBreak + EndToEndId + ': ' +
            APixCD.PSP.epPix.Problema.title + ' ' + APixCD.PSP.epPix.Problema.detail;
      end;

  if (LFalhas <> '') then
    raise EPIXErro.Create('Falha ao devolver PIX:' + LFalhas);
end;

end.
