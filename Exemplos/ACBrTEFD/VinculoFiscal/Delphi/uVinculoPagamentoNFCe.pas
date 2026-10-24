unit uVinculoPagamentoNFCe;

{
  VÍNCULO DO MEIO DE PAGAMENTO COM A NFC-e  (grupo YA - <pag>/<detPag>)

  Cada pagamento da venda vira um <detPag> na NFC-e. Para cartão e PIX, os
  dados da transação (resposta do TEF) também vão para a nota, ligando o
  documento fiscal ao dinheiro recebido:

    Resposta do TEF (TACBrTEFResp)        Tag da NFC-e    Significado
    ------------------------------------  --------------  ------------------------------
    (sempre integrado neste PDV)          tpIntegra = 1   Pagamento integrado à automação
    Rede (tabela de credenciadoras)       CNPJ            Instituição de pagamento / adquirente
    NFCeSAT.Bandeira                      tBand           Bandeira do cartão (não há no PIX)
    NSU  (cartão)                         cAut            Código de autorização
    EndToEndID  (PIX)                     cAut            Identificador e2eid do Bacen
    SerialPOS                             idTermPag       Terminal (PinPad) do pagamento
    (hora do pagamento na venda)          dPag            Data/hora do pagamento
    (CNPJ do emitente)                    CNPJReceb       Estabelecimento beneficiário

  PIX Dinâmico direto no PSP (ACBrPIXCD), sem TEF:

    Cobrança paga no PSP                  Tag da NFC-e
    ------------------------------------  --------------
    (sempre integrado neste PDV)          tpIntegra = 1
    Nome do PSP (tabela credenciadoras)   CNPJ
    pix[0].endToEndId (e2eid)             cAut
    TxId da cobrança                      (não vai na NFC-e; identifica a cobrança no PSP)

  Regras (ex.: IN SEFAZ-CE 87/2025, IN GSE-GO 1608/2025):
    - Cartão de crédito = 03, débito = 04, PIX dinâmico = 17.
    - tpIntegra = 1: o pagamento é integrado ao sistema de automação (TEF).
    - cAut deve ser o mesmo número impresso no comprovante.
    - No PIX, cAut = endToEndId (e2eid).

  Neste PDV todo pagamento em cartão/PIX passa pelo TEF, então tpIntegra é
  SEMPRE 1. Se algum dado obrigatório do vínculo faltar, a NFC-e NÃO é
  emitida (EVinculoPagamento) e o PDV estorna os pagamentos TEF.
}

interface

uses
  Classes, SysUtils,
  ACBrNFe.Classes,     // TpagCollectionItem
  ACBrTEFComum,        // TACBrTEFResp
  pcnConversaoNFe,     // TpcnFormaPagamento, TpcnBandeiraCartao
  uClassePagamento;    // TPagamento

type
  // Falta algum dado obrigatório para vincular o pagamento à NFC-e
  EVinculoPagamento = class(Exception);

  // Uma linha do Raio-X: de onde veio o dado e em qual tag da NFC-e ele foi parar
  TLinhaVinculo = record
    Origem: String;        // campo da resposta do TEF (ou da venda)
    ValorOrigem: String;
    Tag: String;           // tag do <detPag>
    ValorTag: String;      // valor gravado na NFC-e
  end;
  TMapaVinculo = array of TLinhaVinculo;

// Preenche um <detPag> da NFC-e a partir do pagamento da venda.
// ATEFResp = resposta do TEF deste pagamento (nil para dinheiro, crédito loja...)
procedure PreencherPagamentoNFCe(APag: TpagCollectionItem; APagVenda: TPagamento;
  ATEFResp: TACBrTEFResp; const ACNPJEstabelecimento: String);

// "Tradução" da resposta do TEF para as tags da NFC-e
procedure DeduzirCredenciadoraNFCe(APag: TpagCollectionItem; const ARede: String);
procedure DeduzirBandeiraNFCe(APag: TpagCollectionItem; ATEFResp: TACBrTEFResp);
function CodigoAutorizacaoNFCe(ATEFResp: TACBrTEFResp; AForma: TpcnFormaPagamento): String;

{ ----- Raio-X (apoio didático: mostra o vínculo depois da NFC-e montada) ----- }

// Resposta do TEF -> tag da NFC-e, linha a linha, para um <detPag> já preenchido
function MapaVinculo(APag: TpagCollectionItem; APagVenda: TPagamento;
  ATEFResp: TACBrTEFResp): TMapaVinculo;

// Confere se o comprovante do TEF tem o conteúdo mínimo exigido pelas normas
// (código de autorização = cAut, valor, CNPJ do beneficiário, data e terminal)
procedure ConferirComprovante(APag: TpagCollectionItem; ATEFResp: TACBrTEFResp;
  AResultado: TStrings);

// Trecho <pag>...</pag> do XML da NFC-e, indentado para leitura
function ExtrairGrupoPagXML(const AXML: String): String;

implementation

uses
  DateUtils,           // MonthOf
  ACBrUtil.Strings,    // OnlyNumber
  ACBrDFe.Conversao;   // tiPagIntegrado

{ ------------------------- Tradução TEF -> NFC-e --------------------------- }

// Mesmos métodos do exemplo ACBr\Exemplos\ACBrTEFD\TEFAPI\Delphi (frPrincipal.pas)
procedure DeduzirBandeiraNFCe(APag: TpagCollectionItem;
  ATEFResp: TACBrTEFResp);
var
  p: Integer;
  Bandeira: String;
begin
  if  APag.tpIntegra = tiPagNaoIntegrado then
    Exit;

  Bandeira := LowerCase(Trim(ATEFResp.NFCeSAT.Bandeira));
  // Pega apenas a Perimeira Palavra
  p := pos(' ',Bandeira);
  if (p > 0) then
    Bandeira := copy(Bandeira,1, p-1);

  if (pos('visa',Bandeira) = 1) then
    APag.tBand := bcVisa
  else if (pos('mastercard',Bandeira) = 1) then
    APag.tBand := bcMasterCard
  else if (pos('american',Bandeira) = 1) or (pos('amex',Bandeira) = 1) then
    APag.tBand := bcAmericanExpress
  else if (pos('sorocred',Bandeira) = 1) then
    APag.tBand := bcSorocred
  else if (pos('diners',Bandeira) = 1) then
    APag.tBand := bcDinersClub
  else if (pos('elo',Bandeira) = 1) then
    APag.tBand := bcElo
  else if (pos('hipercard',Bandeira) = 1) then
    APag.tBand := bcHipercard
  else if (pos('aura',Bandeira) = 1) then
    APag.tBand := bcAura
  else if (pos('cabal',Bandeira) = 1) then
    APag.tBand := bcCabal
  else
    APag.tBand := bcOutros;

end;

// Este método é apenas um exemplo e não contempla todas as credenciadoras e PSPs.
// Ao utilizar ou adaptar o método, inclua as instituições necessárias ou utilize
// uma tabela de credenciadoras e PSPs mantida pelo seu sistema.
procedure DeduzirCredenciadoraNFCe(APag: TpagCollectionItem;
  const ARede: String);
var
  CNPJ, Rede: String;
  p: Integer;
begin
  CNPJ := '';
  Rede := LowerCase(Trim(ARede));

  // Pega apenas a Perimeira Palavra
  p := pos(' ',Rede);
  if (p > 0) then
    Rede := copy(Rede,1, p-1);

  if (pos('bin', Rede) = 1) or (pos('sipag', Rede) = 1) then
    CNPJ := '02.038.232/0001-64'
  else if (pos('tribanco', Rede) = 1) then
    CNPJ := '17.351.180/0001-59'
  else if (pos('bigcard', Rede) = 1) then
    CNPJ := '04.627.085/0001-93'
  else if (pos('brasilcard', Rede) = 1) then
    CNPJ := '03.817.702/0001-50'
  else if (pos('cabal', Rede) = 1) then
    CNPJ := '03.766.873/0001-06'
  else if (pos('credpar', Rede) = 1) then
    CNPJ := '07.599.577/0001-00'
  else if (pos('ecx', Rede) = 1) then
    CNPJ := '71.225.700/0001-22'
  else if (pos('elavon', Rede) = 1) then
    CNPJ := '12.592.831/0001-89'
  else if (pos('ecofrotas', Rede) = 1) then
    CNPJ := '03.506.307/0001-57'
  else if (pos('jetpar', Rede) = 1) then
    CNPJ := '12.886.711/0001-94'
  else if (pos('usacard', Rede) = 1) then
    CNPJ := '08.011.683/0001-94'
  else if pos('rede', Rede) > 0 then
    CNPJ := '01.425.787/0001-04'
  else if (pos('repon', Rede) = 1) then
    CNPJ := '65.697.260/0001-03'
  else if (pos('senffnet', Rede) = 1) then
    CNPJ := '03.877.288/0001-75'
  else if (pos('siga', Rede) = 1) then
    CNPJ := '04.966.359/0001-79'
  else if (pos('sodexo', Rede) = 1) then
    CNPJ := '69.034.668/0001-56'
  else if (pos('stone', Rede) = 1) then
    CNPJ := '16.501.555/0001-57'
  else if (pos('tecban', Rede) = 1) then
    CNPJ := '51.427.102/0001-29'
  else if (pos('c6', Rede) = 1) then          // C6 PAY / C6BANK (Banco C6 S.A.)
    CNPJ := '31.872.495/0001-72'
  else if (pos('pix', Rede) = 1) and (pos('c6', LowerCase(ARede)) > 0) then  // ex.: "PIX C6" (procura C6 no nome todo)
    CNPJ := '31.872.495/0001-72'
  else if (pos('quero', Rede) = 1) then       // Quero Quero Pag (QQPag) - PSP do PIX
    CNPJ := '01.722.480/0001-67'
  else if (pos('ticket', Rede) = 1) then
    CNPJ := '47.866.934/0001-74'
  else if (pos('valeshop', Rede) = 1) then
    CNPJ := '02.561.118/0001-14'
  else if (pos('visa', Rede) = 1) then
    CNPJ := '01.027.058/0001-91';

  if (CNPJ='') then
    APag.tpIntegra := tiPagNaoIntegrado
  else
  begin
    APag.tpIntegra := tiPagIntegrado;
    APag.CNPJ := OnlyAlphaNum(CNPJ);
  end;

end;

// Código de autorização (tag cAut): o mesmo número do comprovante.
// Cartão = NSU da transação | PIX = endToEndId (e2eid)
function CodigoAutorizacaoNFCe(ATEFResp: TACBrTEFResp;
  AForma: TpcnFormaPagamento): String;
begin
  if (AForma = fpPagamentoInstantaneo) then
  begin
    Result := Trim(ATEFResp.EndToEndID);
    // PayGo: o e2eid vem no PWINFO_AUTEXTREF (NSU / NFCeSAT.Autorizacao)
    if (Result = '') then
      Result := Trim(ATEFResp.NFCeSAT.Autorizacao);
  end
  else
    Result := Trim(ATEFResp.NSU);
end;

{ ------------------------------ <detPag> ------------------------------------ }

// Grupo <card>: dados da transação que vinculam o pagamento à NFC-e
procedure PreencherGrupoCartao(APag: TpagCollectionItem; ATEFResp: TACBrTEFResp);
begin
  DeduzirCredenciadoraNFCe(APag, ATEFResp.Rede);                                       // tpIntegra + CNPJ (cartão e PIX)
  if (APag.tPag <> fpPagamentoInstantaneo) then           // PIX não tem bandeira
    DeduzirBandeiraNFCe(APag, ATEFResp);
  APag.cAut      := CodigoAutorizacaoNFCe(ATEFResp, APag.tPag);
end;

// Dados do recebimento: quando, quem recebeu e em qual terminal
procedure PreencherDadosRecebimento(APag: TpagCollectionItem;
  APagVenda: TPagamento; ATEFResp: TACBrTEFResp;
  const ACNPJEstabelecimento: String);
begin
  APag.dPag      := APagVenda.Hora;
  APag.CNPJReceb := OnlyNumber(ACNPJEstabelecimento);
  APag.idTermPag := Trim(ATEFResp.SerialPOS);   // ou numero do pdv , etc"
end;

// tpIntegra = 1 exige CNPJ da instituição e código de autorização.
// Sem eles a NFC-e sairia com o vínculo incompleto: melhor não emitir.
procedure ValidarVinculo(APag: TpagCollectionItem; const APagamento,
  AOrigemCNPJ: String);
begin
  if (Length(APag.CNPJ) <> 14) then
    raise EVinculoPagamento.Create(
      'Vínculo do pagamento incompleto: CNPJ da instituição de pagamento ' +
      'não identificado.' + sLineBreak + APagamento + sLineBreak + AOrigemCNPJ);

  if (APag.cAut = '') then
    raise EVinculoPagamento.Create(
      'Vínculo do pagamento incompleto: código de autorização (cAut) vazio.' +
      sLineBreak + APagamento);
end;

// PIX Dinâmico direto no PSP: os dados vêm da cobrança paga (sem TEF)
procedure PreencherGrupoPIXPSP(APag: TpagCollectionItem; APagVenda: TPagamento;
  const ACNPJEstabelecimento: String);
begin
  DeduzirCredenciadoraNFCe(APag, APagVenda.Rede);                                      // tpIntegra + CNPJ (tabela pelo nome do PSP)
  APag.cAut      := Trim(APagVenda.EndToEndId);           // e2eid do PIX pago
  APag.dPag      := APagVenda.Hora;
  APag.CNPJReceb := OnlyNumber(ACNPJEstabelecimento);
end;

procedure ValidarVinculoTEF(APag: TpagCollectionItem; ATEFResp: TACBrTEFResp);
begin
  ValidarVinculo(APag,
    FormaPagamentoToStr(APag.tPag) + ' - ' + FormaPagamentoToDescricao(APag.tPag, '') +
      ' (Rede: ' + ATEFResp.Rede + ', NSU: ' + ATEFResp.NSU + ')',
    'A Rede não está na tabela de credenciadoras (DeduzirCredenciadoraNFCe).');
end;

procedure PreencherPagamentoNFCe(APag: TpagCollectionItem; APagVenda: TPagamento;
  ATEFResp: TACBrTEFResp; const ACNPJEstabelecimento: String);
begin
  APag.indPag := ipVista;
  APag.tPag   := APagVenda.FormaPagamento;   // 01, 03, 04, 17...
  APag.vPag   := APagVenda.ValorPago;

  // Dinheiro, crédito loja...: só forma e valor, sem grupo <card>
  if not TPagamento.ExigeDadosCartao(APag.tPag) then
    Exit;

  // PIX (17) direto no PSP (ACBrPIXCD)
  if (APagVenda.Origem = opPSP) then
  begin
    PreencherGrupoPIXPSP(APag, APagVenda, ACNPJEstabelecimento);
    ValidarVinculo(APag, APagVenda.Descricao + ' (TxId: ' + APagVenda.TxId + ')',
      'O PSP "' + APagVenda.Rede + '" não está na tabela de credenciadoras ' +
      '(DeduzirCredenciadoraNFCe).');
    Exit;
  end;

  // Cartão (03, 04) e PIX (17) pelo TEF
  if not Assigned(ATEFResp) then
    raise EVinculoPagamento.Create(
      'Pagamento ' + APagVenda.Descricao + ' sem transação TEF correspondente.');

  PreencherGrupoCartao(APag, ATEFResp);
  PreencherDadosRecebimento(APag, APagVenda, ATEFResp, ACNPJEstabelecimento);
  ValidarVinculoTEF(APag, ATEFResp);
end;

{ --------------------------------- Raio-X ----------------------------------- }

function MapaVinculo(APag: TpagCollectionItem; APagVenda: TPagamento;
  ATEFResp: TACBrTEFResp): TMapaVinculo;

  procedure Adicionar(const AOrigem, AValorOrigem, ATag, AValorTag: String);
  var
    n: Integer;
  begin
    n := Length(Result);
    SetLength(Result, n + 1);
    Result[n].Origem := AOrigem;
    Result[n].ValorOrigem := AValorOrigem;
    Result[n].Tag := ATag;
    Result[n].ValorTag := AValorTag;
  end;

var
  LValor: String;
begin
  Result := nil;
  LValor := FormatFloat('0.00', APag.vPag);

  Adicionar('Forma de pagamento (venda)', FormaPagamentoToDescricao(APag.tPag, ''),
            'tPag', FormaPagamentoToStr(APag.tPag));
  Adicionar('Valor pago (venda)', LValor, 'vPag', LValor);

  // PIX Dinâmico direto no PSP: dados da cobrança paga
  if Assigned(APagVenda) and (APagVenda.Origem = opPSP) then
  begin
    Adicionar('Pagamento direto no PSP (ACBrPIXCD)', APagVenda.Rede,
              'tpIntegra', IntToStr(Ord(APag.tpIntegra)) + ' = integrado');
    Adicionar('Nome do PSP (tabela)', APagVenda.Rede, 'CNPJ', APag.CNPJ);
    Adicionar('Cobrança: TxId', APagVenda.TxId, '-', 'não vai na NFC-e');
    Adicionar('pix[0].endToEndId (e2eid)', APagVenda.EndToEndId, 'cAut', APag.cAut);
    Adicionar('Hora do pagamento (venda)', DateTimeToStr(APag.dPag),
              'dPag', DateTimeToStr(APag.dPag));
    Adicionar('CNPJ do emitente', APag.CNPJReceb, 'CNPJReceb', APag.CNPJReceb);
    Exit;
  end;

  if not Assigned(ATEFResp) then
  begin
    Adicionar('(sem TEF)', '', 'card', 'não se aplica');
    Exit;
  end;

  Adicionar('Pagamento feito pelo TEF', 'Sim',
            'tpIntegra', IntToStr(Ord(APag.tpIntegra)) + ' = integrado');

  Adicionar('Rede (tabela de credenciadoras)', ATEFResp.Rede, 'CNPJ', APag.CNPJ);

  if (APag.tPag = fpPagamentoInstantaneo) then
  begin
    if (Trim(ATEFResp.EndToEndID) <> '') then
      Adicionar('EndToEndID (e2eid do PIX)', ATEFResp.EndToEndID, 'cAut', APag.cAut)
    else  // PayGo: e2eid no PWINFO_AUTEXTREF
      Adicionar('NFCeSAT.Autorizacao (e2eid)', ATEFResp.NFCeSAT.Autorizacao, 'cAut', APag.cAut);
  end
  else
  begin
    Adicionar('NFCeSAT.Bandeira', ATEFResp.NFCeSAT.Bandeira, 'tBand',
              BandeiraCartaoToStr(APag.tBand) + ' - ' + BandeiraCartaoToDescStr(APag.tBand));
    Adicionar('NSU', ATEFResp.NSU, 'cAut', APag.cAut);
  end;

  Adicionar('Hora do pagamento (venda)', DateTimeToStr(APag.dPag),
            'dPag', DateTimeToStr(APag.dPag));
  Adicionar('SerialPOS (PinPad)', ATEFResp.SerialPOS, 'idTermPag', APag.idTermPag);
  Adicionar('CNPJ do emitente', APag.CNPJReceb, 'CNPJReceb', APag.CNPJReceb);
end;

procedure ConferirComprovante(APag: TpagCollectionItem; ATEFResp: TACBrTEFResp;
  AResultado: TStrings);
const
  CMesesAbrev: array[1..12] of String = ('JAN', 'FEV', 'MAR', 'ABR', 'MAI', 'JUN',
                                         'JUL', 'AGO', 'SET', 'OUT', 'NOV', 'DEZ');
var
  LTexto, LNumeros, LSemZeros, LMes: String;

  procedure Item(AOk: Boolean; const ADescricao: String);
  begin
    if AOk then
      AResultado.Add('  [OK] ' + ADescricao)
    else
      AResultado.Add('  [??] ' + ADescricao + ' - NÃO encontrado');
  end;

begin
  LTexto := ATEFResp.ImagemComprovante1aVia.Text + ATEFResp.ImagemComprovante2aVia.Text;
  if (Trim(LTexto) = '') then
  begin
    AResultado.Add('  [--] O TEF não devolveu o texto do comprovante');
    Exit;
  end;
  LNumeros := OnlyNumber(LTexto);

  // cAut: o MESMO número impresso no comprovante (NSU pode vir sem zeros à esquerda)
  LSemZeros := APag.cAut;
  while (Length(LSemZeros) > 1) and (LSemZeros[1] = '0') do
    Delete(LSemZeros, 1, 1);
  Item((APag.cAut <> '') and
       ((Pos(APag.cAut, LTexto) > 0) or (Pos(LSemZeros, LTexto) > 0)),
       'Código de autorização (cAut ' + APag.cAut + ')');

  Item((Pos(FormatFloat('#,##0.00', APag.vPag), LTexto) > 0) or
       (Pos(FormatFloat('0.00', APag.vPag), LTexto) > 0),
       'Valor (' + FormatFloat('#,##0.00', APag.vPag) + ')');

  Item((APag.CNPJReceb <> '') and (Pos(APag.CNPJReceb, LNumeros) > 0),
       'CNPJ do beneficiário (' + APag.CNPJReceb + ')');

  // Data: cada GP imprime de um jeito (12/10/26, 12.10.26, 12/10/2026, 12/OUT/26...)
  LMes := CMesesAbrev[MonthOf(APag.dPag)];
  Item((Pos(FormatDateTime('dd/mm/yy', APag.dPag), LTexto) > 0) or
       (Pos(FormatDateTime('dd.mm.yy', APag.dPag), LTexto) > 0) or
       (Pos(FormatDateTime('dd/mm/yyyy', APag.dPag), LTexto) > 0) or
       (Pos(FormatDateTime('dd', APag.dPag) + '/' + LMes + '/', UpperCase(LTexto)) > 0),
       'Data (' + FormatDateTime('dd/mm/yyyy', APag.dPag) + ')');

  if (APag.idTermPag <> '') then
    Item(Pos(APag.idTermPag, LTexto) > 0, 'Terminal (' + APag.idTermPag + ')')
  else
    AResultado.Add('  [--] Terminal: não informado pelo TEF (opcional)');
end;

function ExtrairGrupoPagXML(const AXML: String): String;
var
  LTrecho: String;
  LTokens: TStringList;
  LSaida: TStringList;
  I, LNivel, p, q: Integer;

  function EhAbertura(const AToken: String): Boolean;
  begin
    Result := (Copy(AToken, 1, 1) = '<') and (Copy(AToken, 1, 2) <> '</') and
              (Copy(AToken, Length(AToken) - 1, 2) <> '/>');
  end;

  function EhFechamento(const AToken: String): Boolean;
  begin
    Result := (Copy(AToken, 1, 2) = '</');
  end;

  function EhTexto(const AToken: String): Boolean;
  begin
    Result := (Copy(AToken, 1, 1) <> '<');
  end;

begin
  Result := '';
  p := Pos('<pag>', AXML);
  q := Pos('</pag>', AXML);
  if (p = 0) or (q < p) then
    Exit;
  LTrecho := Copy(AXML, p, q - p + Length('</pag>'));

  LTokens := TStringList.Create;
  LSaida := TStringList.Create;
  try
    // Quebra em tags e textos: "<detPag>", "<tPag>", "03", "</tPag>"...
    p := 1;
    while (p <= Length(LTrecho)) do
    begin
      if (LTrecho[p] = '<') then
        q := Pos('>', Copy(LTrecho, p, MaxInt)) + p - 1
      else
      begin
        q := Pos('<', Copy(LTrecho, p, MaxInt)) + p - 2;
        if (q < p) then
          q := Length(LTrecho);
      end;
      if (Trim(Copy(LTrecho, p, q - p + 1)) <> '') then
        LTokens.Add(Copy(LTrecho, p, q - p + 1));
      p := q + 1;
    end;

    // Monta as linhas: <tag>texto</tag> numa linha só; grupos indentados
    LNivel := 0;
    I := 0;
    while (I < LTokens.Count) do
    begin
      if EhAbertura(LTokens[I]) and (I + 2 < LTokens.Count) and
         EhTexto(LTokens[I + 1]) and EhFechamento(LTokens[I + 2]) then
      begin
        LSaida.Add(StringOfChar(' ', LNivel * 2) + LTokens[I] + LTokens[I + 1] + LTokens[I + 2]);
        Inc(I, 3);
        Continue;
      end;

      if EhFechamento(LTokens[I]) then
        Dec(LNivel);
      LSaida.Add(StringOfChar(' ', LNivel * 2) + LTokens[I]);
      if EhAbertura(LTokens[I]) then
        Inc(LNivel);
      Inc(I);
    end;

    Result := LSaida.Text;
  finally
    LSaida.Free;
    LTokens.Free;
  end;
end;

end.
