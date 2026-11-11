unit uNFeTesteBase;

{ Base dos testes do TACBrNFe:
   - CriarACBrNFe   : componente configurado (certificado de teste, OpenSSL,
                      LibXml2, SEFAZ simulada, pastas de saída)
   - TCenarioNFe    : combinações de NT / operação usadas nos testes
   - PreencherNFe   : monta uma NF-e / NFC-e completa "do zero"
   - CamposTexto    : extrai os campos de texto livre para comparação
                      (detecta quebra de acentuação e caracteres especiais) }

interface

uses
  SysUtils, Classes,
  ACBrNFe, ACBrNFeNotasFiscais, ACBrNFe.Classes, ACBrNFe.Conversao,
  ACBrDFe.Conversao, uSefazMock;

type
  TCenarioNFe = record
    Nome: string;
    Modelo: Integer;            // 55 NF-e | 65 NFC-e
    Reforma: Boolean;           // grupos da Reforma Tributária (IBS/CBS - NT 2025.002)
    Destino: TDestinoOperacao;  // interna | interestadual | exterior
    ConsumidorFinal: Boolean;
    ComEntrega: Boolean;        // grupo <entrega>
    ComRetirada: Boolean;       // grupo <retirada>
    ComTransportadora: Boolean;
    ComCobranca: Boolean;
    Texto: string;              // texto livre aplicado nos campos alfanuméricos
  end;

const
  // Caracteres especiais (todos representáveis em CP1252)
  // Caracteres especiais aceitos pelo schema da SEFAZ (padrão [!-ÿ] = Latin-1)
  TXT_ESPECIAL =
    'Ação & Cia <Ltda> "aspas" ''apóstrofo'' nº 1º/2ª - São João D''Ávila ' +
    'ÀÈÌÒÙ âêîôû äëïöü ñÑ çÇ ãõ ÃÕ ¹²³ ½ ©®';
  // Existem no CP1252 mas NÃO no Latin-1: o schema da SEFAZ rejeita
  TXT_SIMBOLOS_CP1252 = '€ – — ™ • …';
  TXT_ESPECIAL_CURTO = 'Ação & Cia <Ltda> "nº" ''São'' ÁÉÍÓÚ ãõç';   // <= 60 chars
  // Fora do CP1252 (testa a limitação do caminho ANSI do writer)
  TXT_FORA_CP1252 = 'Łódź – Ελλάδα ✓';

  CNPJ_EMIT = '18760540000139';
  IE_EMIT = '687097034118';
  COD_MUN_TATUI = 3554003;
  COD_MUN_BH = 3106200;

function CenarioPadrao: TCenarioNFe;
function Cenario(const ANome: string; AModelo: Integer; AReforma: Boolean;
  ADestino: TDestinoOperacao; AConsFinal, AEntrega, ARetirada: Boolean): TCenarioNFe;
function CenarioPorCodigo(const ACodigo: string): TCenarioNFe;

function CriarACBrNFe(AModelo: Integer = 55; AMock: TSefazMock = nil;
  const ASubPasta: string = ''): TACBrNFe;
function PreencherNFe(ANFe: TACBrNFe; const C: TCenarioNFe; ANumero: Integer = 1): NotaFiscal;

{ Campos de texto livre do objeto NFe (nome=valor), usados para comparar
  o conteúdo antes e depois de cada método de manipulação de XML }
function CamposTexto(ANFe: TNFe; AIgnorarHomologacao: Boolean = True): TStringList;
function CompararCampos(AEsperado, AObtido: TNFe): string;   // '' = iguais

function PastaSaidaTeste(const ASub: string): string;
function LerArquivoBytes(const AArquivo: string): RawByteString;
function ContarOcorrencias(const ASub, S: string): Integer;
procedure GravarBytesArquivo(const AArquivo: string; const ABytes: RawByteString);

implementation

uses
  Math, ACBrDFeSSL, ACBrDFeUtil, ACBrUtil.Strings, ACBrUtil.Base,
  uXmlTesteHelpers;

type
  TBloqueioRede = class
    procedure OnTransmit(const Dados, URL, SoapAction, MimeType: String;
      var Resposta: String; var HTTPResultCode: Integer; var InternalErrorCode: Integer);
  end;

var
  GBloqueioRede: TBloqueioRede;

procedure TBloqueioRede.OnTransmit(const Dados, URL, SoapAction, MimeType: String;
  var Resposta: String; var HTTPResultCode: Integer; var InternalErrorCode: Integer);
begin
  raise Exception.Create('TESTE: transmissão bloqueada (componente sem SEFAZ simulada). URL: ' + URL);
end;

function PastaSaidaTeste(const ASub: string): string;
begin
  Result := PastaSaida + ASub;
  if (Result <> '') and (Result[Length(Result)] <> '\') then
    Result := Result + '\';
  ForceDirectories(Result);
end;

function LerArquivoBytes(const AArquivo: string): RawByteString;
begin
  Result := BytesDeArquivo(AArquivo);
end;

function ContarOcorrencias(const ASub, S: string): Integer;
var
  P: Integer;
begin
  Result := 0;
  P := Pos(ASub, S);
  while P > 0 do
  begin
    Inc(Result);
    P := Pos(ASub, S, P + Length(ASub));
  end;
end;

procedure GravarBytesArquivo(const AArquivo: string; const ABytes: RawByteString);
var
  FS: TFileStream;
begin
  ForceDirectories(ExtractFilePath(AArquivo));
  FS := TFileStream.Create(AArquivo, fmCreate);
  try
    if Length(ABytes) > 0 then
      FS.WriteBuffer(ABytes[1], Length(ABytes));
  finally
    FS.Free;
  end;
end;

function Cenario(const ANome: string; AModelo: Integer; AReforma: Boolean;
  ADestino: TDestinoOperacao; AConsFinal, AEntrega, ARetirada: Boolean): TCenarioNFe;
begin
  Result.Nome := ANome;
  Result.Modelo := AModelo;
  Result.Reforma := AReforma;
  Result.Destino := ADestino;
  Result.ConsumidorFinal := AConsFinal;
  Result.ComEntrega := AEntrega;
  Result.ComRetirada := ARetirada;
  Result.ComTransportadora := (AModelo = 55);
  Result.ComCobranca := (AModelo = 55);
  Result.Texto := TXT_ESPECIAL;
end;

function CenarioPadrao: TCenarioNFe;
begin
  Result := Cenario('NFe55_Interna_RTC', 55, True, doInterna, False, False, False);
end;

{ Código: <modelo>_<RTC|SemRTC>_<INT|IES|EXT>_<CF|NCF>[_ENT][_RET]
  Ex.: '55_RTC_IES_CF_ENT_RET' }
function CenarioPorCodigo(const ACodigo: string): TCenarioNFe;
var
  Modelo: Integer;
  Dest: TDestinoOperacao;
begin
  Modelo := StrToIntDef(Copy(ACodigo, 1, 2), 55);
  if Pos('_EXT', ACodigo) > 0 then
    Dest := doExterior
  else if Pos('_IES', ACodigo) > 0 then
    Dest := doInterestadual
  else
    Dest := doInterna;
  Result := Cenario(ACodigo, Modelo, Pos('_RTC', ACodigo) > 0, Dest,
    Pos('_CF', ACodigo) > 0, Pos('_ENT', ACodigo) > 0, Pos('_RET', ACodigo) > 0);
end;

function CriarACBrNFe(AModelo: Integer; AMock: TSefazMock; const ASubPasta: string): TACBrNFe;
var
  Saida: string;
begin
  Result := TACBrNFe.Create(nil);
  Saida := PastaSaidaTeste(ASubPasta);
  with Result.Configuracoes do
  begin
    Geral.SSLLib := libCustom;
    Geral.SSLCryptLib := cryOpenSSL;
    Geral.SSLHttpLib := httpOpenSSL;
    Geral.SSLXmlSignLib := xsLibXml2;
    Geral.RetirarAcentos := False;          // padrão do ACBr é True
    Geral.ValidarDigest := True;
    Geral.VersaoDF := ve400;
    if AModelo = 65 then
    begin
      Geral.ModeloDF := moNFCe;
      Geral.IdCSC := '000001';
      Geral.CSC := '0123456789ABCDEF0123456789ABCDEF0123';
      Geral.VersaoQRCode := veqr200;
    end
    else
      Geral.ModeloDF := moNFe;

    Certificados.ArquivoPFX := PastaDados + 'cert_teste.pfx';
    Certificados.Senha := '1234';

    WebServices.UF := 'SP';
    WebServices.Ambiente := taHomologacao;
    WebServices.Visualizar := False;
    WebServices.Salvar := True;
    WebServices.AguardarConsultaRet := 0;
    WebServices.IntervaloTentativas := 0;
    WebServices.Tentativas := 1;

    Arquivos.Salvar := True;
    Arquivos.PathSalvar := Saida + 'ws\';
    Arquivos.PathNFe := Saida + 'nfe\';
    Arquivos.PathEvento := Saida + 'evento\';
    Arquivos.PathInu := Saida + 'inut\';
    Arquivos.PathSchemas := DiretorioACBr + 'Exemplos\ACBrDFe\Schemas\NFe\';
    Arquivos.IniServicos := DiretorioACBr + 'Fontes\ACBrDFe\ACBrNFe\ACBrNFeServicos.ini';
    Arquivos.SepararPorMes := False;
    Arquivos.SalvarApenasNFeProcessadas := False;
  end;
  { Nenhum teste fala com a SEFAZ: com OnTransmit atribuído o ACBr não usa
    SSL.Enviar (ACBrDFeWebService.EnviarDados). Sem mock, instala um bloqueio
    que gera exceção em qualquer tentativa de transmissão. }
  if Assigned(AMock) then
    Result.OnTransmit := AMock.OnTransmit
  else
    Result.OnTransmit := GBloqueioRede.OnTransmit;
end;

function PreencherNFe(ANFe: TACBrNFe; const C: TCenarioNFe; ANumero: Integer): NotaFiscal;
var
  NF: NotaFiscal;
  Item: TDetCollectionItem;
  i, QtdItens: Integer;
  vItem, vICMS, pICMS: Currency;
  CFOP: string;
begin
  NF := ANFe.NotasFiscais.Add;
  Result := NF;

  case C.Destino of
    doInterestadual: begin CFOP := '6102'; pICMS := 12; end;
    doExterior:      begin CFOP := '7102'; pICMS := 0;  end;
  else
    CFOP := '5102'; pICMS := 18;
  end;
  if (C.Destino = doInterestadual) and C.ConsumidorFinal then
    CFOP := '6108';

  QtdItens := 2;
  vItem := 50;
  vICMS := 0;

  with NF.NFe do
  begin
    // ---------------- Identificação ----------------
    Ide.cUF := 35;
    Ide.natOp := Copy('VENDA PRODUÇÃO - AÇÃO & CIA', 1, 60);
    Ide.modelo := C.Modelo;
    Ide.serie := 1;
    Ide.nNF := ANumero;
    Ide.cNF := GerarCodigoDFe(ANumero);
    if C.Modelo = 65 then
      Ide.dEmi := Now               // NFC-e: emissão atual (rej. 704) e sem dSaiEnt (rej. 705)
    else
    begin
      Ide.dEmi := EncodeDate(2026, 11, 10) + EncodeTime(10, 0, 0, 0);
      Ide.dSaiEnt := Ide.dEmi;
    end;
    Ide.tpNF := tnSaida;
    Ide.tpEmis := teNormal;
    Ide.tpAmb := taHomologacao;
    Ide.verProc := 'TestesNFe 1.0';
    Ide.cMunFG := COD_MUN_TATUI;
    Ide.finNFe := fnNormal;
    Ide.idDest := C.Destino;
    if C.ConsumidorFinal or (C.Modelo = 65) then
      Ide.indFinal := cfConsumidorFinal
    else
      Ide.indFinal := cfNao;
    if C.Modelo = 65 then
    begin
      Ide.tpImp := tiNFCe;
      Ide.indPres := pcPresencial;
      Ide.idDest := doInterna;
    end
    else
    begin
      Ide.tpImp := tiRetrato;
      Ide.indPres := pcNao;
    end;
    if C.Reforma then
      Ide.cMunFGIBS := COD_MUN_TATUI;

    // ---------------- Emitente ----------------
    Emit.CNPJCPF := CNPJ_EMIT;
    Emit.IE := IE_EMIT;
    Emit.xNome := 'EMITENTE AÇÃO & COMÉRCIO LTDA';
    Emit.xFant := 'LOJA DO JOÃO <TESTE>';
    Emit.EnderEmit.xLgr := 'RUA CORONEL AURELIANO DE CAMARGO - ÁREA ''A''';
    Emit.EnderEmit.nro := '973';
    Emit.EnderEmit.xCpl := 'SALA 1º ANDAR';
    Emit.EnderEmit.xBairro := 'CENTRO HISTÓRICO';
    Emit.EnderEmit.cMun := COD_MUN_TATUI;
    Emit.EnderEmit.xMun := 'TATUÍ';
    Emit.EnderEmit.UF := 'SP';
    Emit.EnderEmit.CEP := 18270170;
    Emit.EnderEmit.cPais := 1058;
    Emit.EnderEmit.xPais := 'BRASIL';
    Emit.EnderEmit.fone := '1532599600';
    Emit.CRT := crtRegimeNormal;

    // ---------------- Destinatário ----------------
    if C.Modelo = 65 then
    begin
      Dest.CNPJCPF := '12345678909';
      Dest.xNome := 'CONSUMIDOR JOSÉ DA CONCEIÇÃO';
      Dest.indIEDest := inNaoContribuinte;
    end
    else
      case C.Destino of
        doInterna:
          begin
            Dest.CNPJCPF := '05481336000137';
            Dest.IE := '687138770110';
            Dest.indIEDest := inContribuinte;
            Dest.xNome := 'DESTINATÁRIO PAULISTA & CIA';
            Dest.EnderDest.xLgr := 'RUA SÃO JOSÉ';
            Dest.EnderDest.nro := '100';
            Dest.EnderDest.xBairro := 'JARDIM SÃO PAULO';
            Dest.EnderDest.cMun := COD_MUN_TATUI;
            Dest.EnderDest.xMun := 'TATUÍ';
            Dest.EnderDest.UF := 'SP';
            Dest.EnderDest.CEP := 18270170;
            Dest.EnderDest.cPais := 1058;
            Dest.EnderDest.xPais := 'BRASIL';
          end;
        doInterestadual:
          begin
            if C.ConsumidorFinal then
            begin
              Dest.CNPJCPF := '12345678909';
              Dest.indIEDest := inNaoContribuinte;
            end
            else
            begin
              Dest.CNPJCPF := '17255010000124';
              Dest.IE := '0623079040081';
              Dest.indIEDest := inContribuinte;
            end;
            Dest.xNome := 'DESTINATÁRIO MINEIRO - CONFIANÇA';
            Dest.EnderDest.xLgr := 'AVENIDA AFONSO PENA';
            Dest.EnderDest.nro := '1500';
            Dest.EnderDest.xBairro := 'CENTRO';
            Dest.EnderDest.cMun := COD_MUN_BH;
            Dest.EnderDest.xMun := 'BELO HORIZONTE';
            Dest.EnderDest.UF := 'MG';
            Dest.EnderDest.CEP := 30130000;
            Dest.EnderDest.cPais := 1058;
            Dest.EnderDest.xPais := 'BRASIL';
          end;
        doExterior:
          begin
            Dest.CNPJCPF := '';
            Dest.idEstrangeiro := 'AR20123456789';
            Dest.indIEDest := inNaoContribuinte;
            Dest.xNome := 'IMPORTADORA SEÑOR MUÑOZ S.A.';
            Dest.EnderDest.xLgr := 'AVENIDA CORRIENTES';
            Dest.EnderDest.nro := '1234';
            Dest.EnderDest.xBairro := 'SAN NICOLÁS';
            Dest.EnderDest.cMun := 9999999;
            Dest.EnderDest.xMun := 'EXTERIOR';
            Dest.EnderDest.UF := 'EX';
            Dest.EnderDest.cPais := 639;
            Dest.EnderDest.xPais := 'ARGENTINA';
            exporta.UFSaidaPais := 'SP';
            exporta.xLocExporta := 'PORTO DE SANTOS - ARMAZÉM 1';
          end;
      end;

    // ---------------- Retirada / Entrega ----------------
    if C.ComRetirada then
    begin
      Retirada.CNPJCPF := '18760540000139';
      Retirada.xNome := 'DEPÓSITO DA AÇÃO';
      Retirada.xLgr := 'RUA DA RETIRADA - GALPÃO';
      Retirada.nro := '10';
      Retirada.xCpl := 'FUNDOS';
      Retirada.xBairro := 'DISTRITO INDUSTRIAL';
      Retirada.cMun := COD_MUN_TATUI;
      Retirada.xMun := 'TATUÍ';
      Retirada.UF := 'SP';
    end;
    if C.ComEntrega then
    begin
      Entrega.CNPJCPF := '05481336000137';
      Entrega.xNome := 'LOJA DE ENTREGA - JOÃO & MARIA';
      Entrega.xLgr := 'RUA DA ENTREGA Nº 5';
      Entrega.nro := '20';
      Entrega.xCpl := 'LOJA ''B''';
      Entrega.xBairro := 'VILA SÃO JOÃO';
      if C.Destino = doInterestadual then
      begin
        Entrega.cMun := COD_MUN_BH;
        Entrega.xMun := 'BELO HORIZONTE';
        Entrega.UF := 'MG';
      end
      else
      begin
        Entrega.cMun := COD_MUN_TATUI;
        Entrega.xMun := 'TATUÍ';
        Entrega.UF := 'SP';
      end;
    end;

    // ---------------- Itens ----------------
    for i := 1 to QtdItens do
    begin
      Item := Det.New;
      Item.Prod.nItem := i;
      Item.Prod.cProd := 'PROD' + IntToStr(i);
      Item.Prod.cEAN := 'SEM GTIN';
      Item.Prod.cEANTrib := 'SEM GTIN';
      Item.Prod.xProd := Copy('Item ' + IntToStr(i) + ' - ' + C.Texto, 1, 120);
      Item.Prod.NCM := '61051000';
      Item.Prod.CFOP := CFOP;
      Item.Prod.uCom := 'UN';
      Item.Prod.qCom := 1;
      Item.Prod.vUnCom := vItem;
      Item.Prod.vProd := vItem;
      Item.Prod.uTrib := 'UN';
      Item.Prod.qTrib := 1;
      Item.Prod.vUnTrib := vItem;
      Item.Prod.indTot := itSomaTotalNFe;
      Item.infAdProd := 'Informação adicional do item: ' + C.Texto;

      with Item.Imposto do
      begin
        ICMS.orig := oeNacional;
        if C.Destino = doExterior then
          ICMS.CST := cst41
        else
        begin
          ICMS.CST := cst00;
          ICMS.modBC := dbiValorOperacao;
          ICMS.vBC := vItem;
          ICMS.pICMS := pICMS;
          ICMS.vICMS := vItem * pICMS / 100;
          vICMS := vICMS + ICMS.vICMS;
        end;

        if (C.Destino = doInterestadual) and C.ConsumidorFinal then
        begin
          ICMSUFDest.vBCUFDest := vItem;
          ICMSUFDest.vBCFCPUFDest := vItem;
          ICMSUFDest.pFCPUFDest := 0;
          ICMSUFDest.pICMSUFDest := 18;
          ICMSUFDest.pICMSInter := 12;
          ICMSUFDest.pICMSInterPart := 100;
          ICMSUFDest.vFCPUFDest := 0;
          ICMSUFDest.vICMSUFDest := vItem * 6 / 100;
          ICMSUFDest.vICMSUFRemet := 0;
        end;

        PIS.CST := pis99;
        PIS.vBC := 0; PIS.pPIS := 0; PIS.vPIS := 0;
        COFINS.CST := cof99;
        COFINS.vBC := 0; COFINS.pCOFINS := 0; COFINS.vCOFINS := 0;

        if C.Reforma then
        begin
          IBSCBS.CST := cst410;
          IBSCBS.cClassTrib := '410009';
        end;
      end;
      if C.Reforma then
        Item.vItem := vItem;
    end;

    // ---------------- Totais ----------------
    Total.ICMSTot.vBC := IfThen(C.Destino = doExterior, 0, vItem * QtdItens);
    Total.ICMSTot.vICMS := vICMS;
    Total.ICMSTot.vProd := vItem * QtdItens;
    Total.ICMSTot.vNF := vItem * QtdItens;
    if (C.Destino = doInterestadual) and C.ConsumidorFinal then
      Total.ICMSTot.vICMSUFDest := vItem * QtdItens * 6 / 100;
    if C.Reforma then
    begin
      Total.IBSCBSTot.vBCIBSCBS := 0;
      Total.vNFTot := vItem * QtdItens;
    end;

    // ---------------- Transporte ----------------
    if C.ComTransportadora then
    begin
      Transp.modFrete := mfContaEmitente;
      Transp.Transporta.CNPJCPF := '11222333000181';
      Transp.Transporta.xNome := 'TRANSPORTADORA VIAÇÃO RÁPIDA & CIA';
      Transp.Transporta.IE := 'ISENTO';
      Transp.Transporta.xEnder := 'RODOVIA CASTELLO BRANCO KM 100 - PÁTIO';
      Transp.Transporta.xMun := 'SÃO PAULO';
      Transp.Transporta.UF := 'SP';
      with Transp.Vol.New do
      begin
        qVol := 1;
        esp := 'CAIXA DE PAPELÃO';
        marca := 'MARCA ÇÃO';
        nVol := '1';
        pesoL := 10;
        pesoB := 11;
      end;
    end
    else
      Transp.modFrete := mfSemFrete;

    // ---------------- Cobrança ----------------
    if C.ComCobranca then
    begin
      Cobr.Fat.nFat := 'FAT-001';
      Cobr.Fat.vOrig := vItem * QtdItens;
      Cobr.Fat.vDesc := 0;
      Cobr.Fat.vLiq := vItem * QtdItens;
      with Cobr.Dup.New do
      begin
        nDup := '001';
        dVenc := EncodeDate(2026, 12, 10);
        vDup := vItem * QtdItens;
      end;
    end;

    // ---------------- Pagamento ----------------
    with pag.New do
    begin
      if C.ComCobranca then
      begin
        indPag := ipPrazo;
        tPag := fpBoletoBancario;
      end
      else
      begin
        indPag := ipVista;
        tPag := fpDinheiro;
      end;
      vPag := vItem * QtdItens;
    end;

    // ---------------- Informações adicionais ----------------
    InfAdic.infCpl := 'Informações complementares: ' + C.Texto;
    InfAdic.infAdFisco := 'Fisco: observação com acentuação - ção';
    with InfAdic.obsCont.New do
    begin
      xCampo := 'Observacao';
      xTexto := Copy('Obs: ' + C.Texto, 1, 60);
    end;

    infRespTec.CNPJ := '18760540000139';
    infRespTec.xContato := 'JOÃO DA SILVA';
    infRespTec.email := 'teste@exemplo.com.br';
    infRespTec.fone := '1532599600';
  end;
end;

function CamposTexto(ANFe: TNFe; AIgnorarHomologacao: Boolean): TStringList;
var
  i: Integer;
begin
  Result := TStringList.Create;
  with ANFe do
  begin
    Result.Values['Ide.natOp'] := Ide.natOp;
    Result.Values['Emit.xNome'] := Emit.xNome;
    Result.Values['Emit.xFant'] := Emit.xFant;
    Result.Values['Emit.xLgr'] := Emit.EnderEmit.xLgr;
    Result.Values['Emit.xCpl'] := Emit.EnderEmit.xCpl;
    Result.Values['Emit.xBairro'] := Emit.EnderEmit.xBairro;
    Result.Values['Emit.xMun'] := Emit.EnderEmit.xMun;
    if not AIgnorarHomologacao then   // em homologação a SEFAZ exige texto fixo
      Result.Values['Dest.xNome'] := Dest.xNome;
    Result.Values['Dest.xLgr'] := Dest.EnderDest.xLgr;
    Result.Values['Dest.xBairro'] := Dest.EnderDest.xBairro;
    Result.Values['Dest.xMun'] := Dest.EnderDest.xMun;
    Result.Values['Retirada.xNome'] := Retirada.xNome;
    Result.Values['Retirada.xLgr'] := Retirada.xLgr;
    Result.Values['Retirada.xBairro'] := Retirada.xBairro;
    Result.Values['Entrega.xNome'] := Entrega.xNome;
    Result.Values['Entrega.xLgr'] := Entrega.xLgr;
    Result.Values['Entrega.xCpl'] := Entrega.xCpl;
    Result.Values['Entrega.xBairro'] := Entrega.xBairro;
    Result.Values['exporta.xLocExporta'] := exporta.xLocExporta;
    for i := 0 to Det.Count - 1 do
    begin
      // NFC-e em homologação: o 1º item recebe texto fixo exigido pela SEFAZ
      if not (AIgnorarHomologacao and (Ide.modelo = 65) and (i = 0)) then
        Result.Values['Det[' + IntToStr(i) + '].xProd'] := Det[i].Prod.xProd;
      Result.Values['Det[' + IntToStr(i) + '].infAdProd'] := Det[i].infAdProd;
    end;
    Result.Values['Transporta.xNome'] := Transp.Transporta.xNome;
    Result.Values['Transporta.xEnder'] := Transp.Transporta.xEnder;
    Result.Values['Transporta.xMun'] := Transp.Transporta.xMun;
    for i := 0 to Transp.Vol.Count - 1 do
    begin
      Result.Values['Vol[' + IntToStr(i) + '].esp'] := Transp.Vol[i].esp;
      Result.Values['Vol[' + IntToStr(i) + '].marca'] := Transp.Vol[i].marca;
    end;
    Result.Values['InfAdic.infCpl'] := InfAdic.infCpl;
    Result.Values['InfAdic.infAdFisco'] := InfAdic.infAdFisco;
    for i := 0 to InfAdic.obsCont.Count - 1 do
      Result.Values['obsCont[' + IntToStr(i) + '].xTexto'] := InfAdic.obsCont[i].xTexto;
    Result.Values['infRespTec.xContato'] := infRespTec.xContato;
  end;
end;

function CompararCampos(AEsperado, AObtido: TNFe): string;
var
  E, O: TStringList;
  i: Integer;
  Nome: string;
begin
  Result := '';
  E := CamposTexto(AEsperado);
  O := CamposTexto(AObtido);
  try
    for i := 0 to E.Count - 1 do
    begin
      Nome := E.Names[i];
      if E.ValueFromIndex[i] <> O.Values[Nome] then
        Result := Result + sLineBreak + '  ' + Nome + ': esperado "' +
          E.ValueFromIndex[i] + '" obtido "' + O.Values[Nome] + '"';
    end;
  finally
    E.Free;
    O.Free;
  end;
end;

initialization
  GBloqueioRede := TBloqueioRede.Create;

finalization
  GBloqueioRede.Free;

end.
