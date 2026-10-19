{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2020 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la }
{ sob os termos da Licença Pública Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a versão 2.1 da Licença, ou (a seu critério) }
{ qualquer versão posterior.                                                   }
{                                                                              }
{  Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU      }
{ ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENÇA.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Você deve ter recebido uma cópia da Licença Pública Geral Menor do GNU junto}
{ com esta biblioteca; se não, escreva para a Free Software Foundation, Inc.,  }
{ no endereço 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Você também pode obter uma copia da licença em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Simões de Almeida - daniel@projetoacbr.com.br - www.projetoacbr.com.br}
{       Rua Coronel Aureliano de Camargo, 963 - Tatuí - SP - 18270-170         }
{******************************************************************************}

{$I ACBr.inc}

unit pcnCIOTW_ANTT;

interface

uses
  SysUtils,
  Classes,
  pcnCIOTW,
  pcnCIOT,
  ACBrCIOTConversao,
  ACBrJSON;

type
  { Tipo de localizacao usado nos pares Origem/Destino (regras B109 a B111) }
  TTipoLocalizacaoANTT = (tlNenhum, tlMunicipio, tlCep, tlLatLong);

  TLocalizacaoANTT = record
    CodigoMunicipio: Integer;
    Cep: string;
    Latitude: Double;
    Longitude: Double;
  end;

  { TCIOTW_ANTT }

  TCIOTW_ANTT = class(TCIOTWClass)
  private
    FVersaoDF: TVersaoCIOT;

    function TipoOperacaoANTT: Integer;
    function TipoPagamentoANTT(APagamento: TPagamentoCollectionItem): Integer;
    function IndPagamentoANTT(const AIndicadorPagamento: string): Integer;
    function DataHoraANTT(const AValue: TDateTime): string;
    function DecimalANTT(const AValue: Double; const ADecimais: Integer): string;
    function InteiroANTT(const AValue: Integer): string;
    function BooleanoANTT(const AValue: Boolean): string;
    function FormatarRNTRC(const AValue: string): string;

    function Localizacao(const ACodigoMunicipio: Integer; const ACep: string;
      const ALatitude, ALongitude: Double): TLocalizacaoANTT;
    function PossuiLocalizacao(const ALocal: TLocalizacaoANTT;
      const ATipo: TTipoLocalizacaoANTT): Boolean;
    function TipoLocalizacaoMaisEspecifico(const ALocal: TLocalizacaoANTT): TTipoLocalizacaoANTT;
    function GerarLocalizacao(const ASufixo: string; const ALocal: TLocalizacaoANTT;
      const ATipo: TTipoLocalizacaoANTT): TACBrJSONObject;
    procedure GerarOrigemDestino(AJSon: TACBrJSONObject;
      const AOrigem, ADestino: TLocalizacaoANTT);
    function GerarItemOrigemDestino(AViagem: TViagemCollectionItem;
      const AComDistancia, AComQtdViagens: Boolean): TACBrJSONObject;
    function GerarPagamento(APagamento: TPagamentoCollectionItem): TACBrJSONObject;

    function GerarConsultarSituacaoTransportador: TACBrJSONObject;
    function GerarConsultarFrotaTransportador: TACBrJSONObject;
    function GerarDeclaracaoOperacaoTransporte: TACBrJSONObject;
    function GerarCancelamentoOperacaoTransporte: TACBrJSONObject;
    function GerarRetificacaoOperacaoTransporte: TACBrJSONObject;
    function GerarEncerramentoOperacaoTransporte: TACBrJSONObject;
    function GerarConsultarExcecao: TACBrJSONObject;
    function GerarConsultarCIOTGerado: TACBrJSONObject;
  public
    constructor Create(ACIOTW: TCIOTW); override;

    property VersaoDF: TVersaoCIOT read FVersaoDF write FVersaoDF;

    function ObterNomeArquivo: String; override;
    function GerarXml: Boolean; override;
  end;

implementation

uses
  ACBrUtil.Base,
  ACBrUtil.Strings;

const
  // Tipos de operacao de transporte da ANTT
  cOperacaoCargaLotacao    = 1;
  cOperacaoCargaFracionada = 2;
  cOperacaoTACAgregado     = 3;

  // Tipos de pagamento da ANTT
  cPagamentoIP            = 1;
  cPagamentoContaCorrente = 2;
  cPagamentoContaPoupanca = 3;
  cPagamentoContaPagto    = 4;
  cPagamentoOutros        = 5;
  cPagamentoPix           = 6;

{ TCIOTW_ANTT }

constructor TCIOTW_ANTT.Create(ACIOTW: TCIOTW);
begin
  inherited Create(ACIOTW);
end;

function TCIOTW_ANTT.ObterNomeArquivo: String;
begin
  Result := '';
end;

function TCIOTW_ANTT.DataHoraANTT(const AValue: TDateTime): string;
begin
  Result := FormatDateTime('yyyy-mm-dd"T"hh:nn:ss', AValue);
end;

function TCIOTW_ANTT.DecimalANTT(const AValue: Double;
  const ADecimais: Integer): string;
begin
  // Os campos decimais sao enviados como string, com ponto decimal e sem
  // separador de milhar. Valor zero gera string vazia (campo omitido).
  if AValue = 0 then
    Result := ''
  else
    Result := FloatToString(AValue, '.', FloatMask(ADecimais, False));
end;

function TCIOTW_ANTT.InteiroANTT(const AValue: Integer): string;
begin
  if AValue = 0 then
    Result := ''
  else
    Result := IntToStr(AValue);
end;

function TCIOTW_ANTT.BooleanoANTT(const AValue: Boolean): string;
begin
  if AValue then
    Result := 'true'
  else
    Result := 'false';
end;

function TCIOTW_ANTT.FormatarRNTRC(const AValue: string): string;
begin
  // Regra B60: RNTRC com 8 digitos deve ser completado com zero a esquerda.
  Result := OnlyNumber(AValue);

  if Result <> '' then
    Result := PadLeft(Result, 9, '0');
end;

function TCIOTW_ANTT.TipoOperacaoANTT: Integer;
begin
  case CIOT.AdicionarOperacao.TipoViagem of
    Padrao:       Result := cOperacaoCargaLotacao;
    Fracionado:   Result := cOperacaoCargaFracionada;
    TAC_Agregado: Result := cOperacaoTACAgregado;
  else
    begin
      Result := 0;
      Gerador.wAlerta('', 'TipoOperacao', 'Tipo de Operacao',
        'Tipo de viagem invalido para a integradora ANTT. Utilize Padrao, Fracionado ou TAC_Agregado.');
    end;
  end;
end;

function TCIOTW_ANTT.TipoPagamentoANTT(APagamento: TPagamentoCollectionItem): Integer;
begin
  if APagamento.ValorChavePix <> '' then
    Result := cPagamentoPix
  else
  begin
    case APagamento.TipoPagamento of
      TransferenciaBancaria:
        case APagamento.InformacoesBancarias.TipoConta of
          tcContaPoupanca:   Result := cPagamentoContaPoupanca;
          tcContaPagamentos: Result := cPagamentoContaPagto;
        else
          Result := cPagamentoContaCorrente;
        end;

      eFRETE, Parceiro:
        Result := cPagamentoIP;
    else // Outros, DepositoAgendado
      Result := cPagamentoOutros;
    end;
  end;
end;

function TCIOTW_ANTT.IndPagamentoANTT(const AIndicadorPagamento: string): Integer;
begin
  // 0 = a vista / 1 = a prazo
  if (AIndicadorPagamento = '1') or SameText(AIndicadorPagamento, 'APrazo') or
     SameText(AIndicadorPagamento, 'A Prazo') then
    Result := 1
  else
    Result := 0;
end;

function TCIOTW_ANTT.Localizacao(const ACodigoMunicipio: Integer;
  const ACep: string; const ALatitude, ALongitude: Double): TLocalizacaoANTT;
begin
  Result.CodigoMunicipio := ACodigoMunicipio;
  Result.Cep := OnlyNumber(ACep);
  Result.Latitude := ALatitude;
  Result.Longitude := ALongitude;
end;

function TCIOTW_ANTT.PossuiLocalizacao(const ALocal: TLocalizacaoANTT;
  const ATipo: TTipoLocalizacaoANTT): Boolean;
begin
  case ATipo of
    tlLatLong:   Result := (ALocal.Latitude <> 0) and (ALocal.Longitude <> 0);
    tlCep:       Result := (ALocal.Cep <> '');
    tlMunicipio: Result := (ALocal.CodigoMunicipio > 0);
  else
    Result := False;
  end;
end;

function TCIOTW_ANTT.TipoLocalizacaoMaisEspecifico(
  const ALocal: TLocalizacaoANTT): TTipoLocalizacaoANTT;
begin
  if PossuiLocalizacao(ALocal, tlLatLong) then
    Result := tlLatLong
  else if PossuiLocalizacao(ALocal, tlCep) then
    Result := tlCep
  else if PossuiLocalizacao(ALocal, tlMunicipio) then
    Result := tlMunicipio
  else
    Result := tlNenhum;
end;

function TCIOTW_ANTT.GerarLocalizacao(const ASufixo: string;
  const ALocal: TLocalizacaoANTT; const ATipo: TTipoLocalizacaoANTT): TACBrJSONObject;
begin
  Result := TACBrJSONObject.Create;

  case ATipo of
    tlMunicipio:
      Result.AddPair('CodigoMunicipio' + ASufixo, InteiroANTT(ALocal.CodigoMunicipio));

    tlCep:
      Result.AddPair('Cep' + ASufixo, ALocal.Cep);

    tlLatLong:
      Result
        .AddPair('Latitude' + ASufixo, DecimalANTT(ALocal.Latitude, 6))
        .AddPair('Longitude' + ASufixo, DecimalANTT(ALocal.Longitude, 6));
  end;
end;

procedure TCIOTW_ANTT.GerarOrigemDestino(AJSon: TACBrJSONObject;
  const AOrigem, ADestino: TLocalizacaoANTT);
var
  LTipo, LTipoOrigem, LTipoDestino: TTipoLocalizacaoANTT;
begin
  // Regras B109 a B111: origem e destino devem usar o mesmo tipo de
  // localizacao, sempre o mais especifico: LatLong -> CEP -> Municipio.
  LTipo := tlLatLong;

  while (LTipo > tlNenhum) and
        not (PossuiLocalizacao(AOrigem, LTipo) and PossuiLocalizacao(ADestino, LTipo)) do
    LTipo := Pred(LTipo);

  if LTipo <> tlNenhum then
  begin
    LTipoOrigem := LTipo;
    LTipoDestino := LTipo;
  end
  else
  begin
    Gerador.wAlerta('', 'OrigemDestino', 'Origem/Destino',
      'Origem e destino devem ser informados com o mesmo tipo de localizacao (municipio, CEP ou coordenadas).');

    LTipoOrigem := TipoLocalizacaoMaisEspecifico(AOrigem);
    LTipoDestino := TipoLocalizacaoMaisEspecifico(ADestino);
  end;

  AJSon
    .AddPair('Origem', GerarLocalizacao('Origem', AOrigem, LTipoOrigem))
    .AddPair('Destino', GerarLocalizacao('Destino', ADestino, LTipoDestino));
end;

function TCIOTW_ANTT.GerarItemOrigemDestino(AViagem: TViagemCollectionItem;
  const AComDistancia, AComQtdViagens: Boolean): TACBrJSONObject;
begin
  Result := TACBrJSONObject.Create;

  GerarOrigemDestino(Result,
    Localizacao(AViagem.CodigoMunicipioOrigem, AViagem.CepOrigem,
      AViagem.LatitudeOrigem, AViagem.LongitudeOrigem),
    Localizacao(AViagem.CodigoMunicipioDestino, AViagem.CepDestino,
      AViagem.LatitudeDestino, AViagem.LongitudeDestino));

  if AComDistancia then
    Result.AddPair('DistanciaPercorrida', AViagem.DistanciaPercorrida, False);

  if AComQtdViagens then
    Result.AddPair('QtdViagens', AViagem.QtdViagens, False);
end;

function TCIOTW_ANTT.GerarPagamento(APagamento: TPagamentoCollectionItem): TACBrJSONObject;
var
  LTipoPagamento: Integer;
  LNumeroConta: string;
begin
  LTipoPagamento := TipoPagamentoANTT(APagamento);

  Result := TACBrJSONObject.Create;
  Result.AddPair('TipoPagamento', LTipoPagamento);

  // Regras B92 e B99: campos bancarios somente para os tipos 1 a 4 e campos
  // PIX somente para o tipo 6.
  with APagamento.InformacoesBancarias do
  begin
    if LTipoPagamento in [cPagamentoIP..cPagamentoContaPagto] then
    begin
      LNumeroConta := Conta;

      if (LTipoPagamento = cPagamentoIP) and (LNumeroConta = '') then
        LNumeroConta := Cartao.Numero;

      Result.AddPair('CodigoInstituicaoFinanceira', OnlyNumber(InstituicaoBancaria), False);

      if LTipoPagamento <> cPagamentoIP then
        Result.AddPair('NumeroAgencia', Agencia, False);

      Result.AddPair('NumeroConta', LNumeroConta, False);
    end;
  end;

  if LTipoPagamento = cPagamentoPix then
  begin
    Result
      .AddPair('ChavePix', APagamento.ValorChavePix, False)
      .AddPair('IdentificadorPix', APagamento.IdentificadorPix, False);
  end;

  Result
    .AddPair('CpfCnpjCreditado', OnlyCPFCNPJAlphaNum(APagamento.CpfCnpjCreditado))
    .AddPair('CodigoPagamento', APagamento.CodigoPagamento, False)
    .AddPair('IndPagamento', IntToStr(IndPagamentoANTT(APagamento.IndicadorPagamento)));

  // Regras B105 e B106: dados de parcelamento somente quando a prazo.
  if IndPagamentoANTT(APagamento.IndicadorPagamento) = 1 then
  begin
    Result
      .AddPair('NumeroParcela', InteiroANTT(APagamento.NumeroParcela), False)
      .AddPairISODate('DataVencimento', APagamento.DataDeLiberacao, False)
      .AddPair('ValorParcela', DecimalANTT(APagamento.Valor, 2), False);
  end;
end;

function TCIOTW_ANTT.GerarConsultarSituacaoTransportador: TACBrJSONObject;
begin
  Result := TACBrJSONObject.Create;

  with CIOT.ConsultarTransportador do
  begin
    Result
      .AddPair('CpfCnpjInteressado', OnlyCPFCNPJAlphaNum(CpfCnpjInteressado))
      .AddPair('CpfCnpjTransportador', OnlyCPFCNPJAlphaNum(CpfCnpjTransportador))
      .AddPair('RNTRCTransportador', FormatarRNTRC(RNTRCTransportador));
  end;
end;

function TCIOTW_ANTT.GerarConsultarFrotaTransportador: TACBrJSONObject;
var
  LPlacas: TACBrJSONArray;
  i: Integer;
begin
  Result := GerarConsultarSituacaoTransportador;

  LPlacas := TACBrJSONArray.Create;

  for i := 0 to CIOT.ConsultarTransportador.Placas.Count - 1 do
    LPlacas.AddElement(CIOT.ConsultarTransportador.Placas[i].Placa);

  Result.AddPair('Placas', LPlacas);
end;

function TCIOTW_ANTT.GerarDeclaracaoOperacaoTransporte: TACBrJSONObject;
var
  LTipoOperacao, i: Integer;
  LDataDeclaracao: TDateTime;
  LVeiculos, LOrigemDestino, LInfPagamento, LContratantes: TACBrJSONArray;
  LVeiculo, LDadosCarga, LIndicadores: TACBrJSONObject;
begin
  LTipoOperacao := TipoOperacaoANTT;

  Result := TACBrJSONObject.Create;

  with CIOT.AdicionarOperacao do
  begin
    if IdOperacaoCliente = '' then
      Gerador.wAlerta('', 'IdOperacaoTransporte', 'Id da Operacao de Transporte',
        'O Codigo Identificador da Operacao de Transporte (IdOperacaoCliente) deve ser informado.');

    if Veiculos.Count = 0 then
      Gerador.wAlerta('', 'Veiculos', 'Veiculos',
        'Deve ser informado ao menos um veiculo.');

    if Pagamentos.Count = 0 then
      Gerador.wAlerta('', 'InfPagamento', 'Informacoes do Pagamento',
        'Deve ser informado ao menos um pagamento.');

    if IndContingencia and (JustificativaContingencia = '') then
      Gerador.wAlerta('', 'JustificativaContingencia', 'Justificativa da Contingencia',
        'A justificativa deve ser informada quando IndContingencia = true.');

    // Regra B11: a data da declaracao deve estar proxima da data/hora atual.
    LDataDeclaracao := DataDeclaracao;

    if LDataDeclaracao = 0 then
      LDataDeclaracao := Now;

    Result
      .AddPair('IdOperacaoTransporte', IdOperacaoCliente)
      .AddPair('TipoOperacao', LTipoOperacao)
      .AddPair('CpfCnpjContratado', OnlyCPFCNPJAlphaNum(Contratado.CpfOuCnpj))
      .AddPair('RNTRCContratado', FormatarRNTRC(Contratado.RNTRC))
      .AddPair('CpfCnpjContratante', OnlyCPFCNPJAlphaNum(Contratante.CpfOuCnpj))
      .AddPair('RNTRCContratante', FormatarRNTRC(Contratante.RNTRC), False);

    // O destinatario nao deve ser informado para TAC-Agregado.
    if LTipoOperacao <> cOperacaoTACAgregado then
      Result.AddPair('CpfCnpjDestinatario', OnlyCPFCNPJAlphaNum(Destinatario.CpfOuCnpj), False);

    Result
      .AddPair('ValorFrete', DecimalANTT(ValorFrete, 2))
      .AddPair('DataDeclaracao', DataHoraANTT(LDataDeclaracao))
      .AddPair('IndContingencia', BooleanoANTT(IndContingencia));

    // Regras B103 e B104: justificativa somente em contingencia.
    if IndContingencia then
      Result.AddPair('JustificativaContingencia', JustificativaContingencia, False);

    // Regra B56: para TAC-Agregado a data de inicio da viagem nao deve ser informada.
    if LTipoOperacao <> cOperacaoTACAgregado then
      Result.AddPairISODate('DataInicioViagem', DataInicioViagem, False);

    Result.AddPairISODate('DataFimViagem', DataFimViagem, False);

    LVeiculos := TACBrJSONArray.Create;

    for i := 0 to Veiculos.Count - 1 do
    begin
      LVeiculo := TACBrJSONObject.Create;
      LVeiculo
        .AddPair('Placa', Veiculos[i].Placa)
        .AddPair('RNTRC', FormatarRNTRC(Veiculos[i].RNTRC), False)
        .AddPair('NumeroEixos', InteiroANTT(Veiculos[i].NumeroEixos), False);

      LVeiculos.AddElementJSON(LVeiculo);
    end;

    Result.AddPair('Veiculos', LVeiculos);

    // Regra B62: Origem/Destino e dados da carga nao se aplicam a TAC-Agregado
    // na declaracao.
    if LTipoOperacao <> cOperacaoTACAgregado then
    begin
      if Viagens.Count > 0 then
      begin
        LOrigemDestino := TACBrJSONArray.Create;

        for i := 0 to Viagens.Count - 1 do
          LOrigemDestino.AddElementJSON(GerarItemOrigemDestino(Viagens[i], True, False));

        Result.AddPair('OrigemDestino', LOrigemDestino);
      end;

      LDadosCarga := TACBrJSONObject.Create;
      LDadosCarga
        .AddPair('CodigoNaturezaCarga', InteiroANTT(CodigoNCMNaturezaCarga), False)
        .AddPair('PesoCarga', DecimalANTT(PesoCarga, 2), False)
        .AddPair('CodigoTipoCarga', InteiroANTT(StrToIntDef(TipoCargaToStr(CodigoTipoCarga), 0)), False);

      if (LTipoOperacao = cOperacaoCargaFracionada) and
         (ContratantesCargaFracionada.Count > 0) then
      begin
        LContratantes := TACBrJSONArray.Create;

        for i := 0 to ContratantesCargaFracionada.Count - 1 do
          LContratantes.AddElement(OnlyCPFCNPJAlphaNum(ContratantesCargaFracionada[i].CpfOuCnpj));

        // Nome conforme o exemplo JSON do manual (a tabela cita
        // "ContratantesCargaFrac"). Validar em homologacao.
        LDadosCarga.AddPair('ContratantesCargFrac', LContratantes);
      end;

      Result.AddPair('DadosCarga', LDadosCarga);
    end;

    if Pagamentos.Count > 0 then
    begin
      LInfPagamento := TACBrJSONArray.Create;

      for i := 0 to Pagamentos.Count - 1 do
        LInfPagamento.AddElementJSON(GerarPagamento(Pagamentos[i]));

      Result.AddPair('InfPagamento', LInfPagamento);
    end;

    // Indicadores operacionais sao obrigatorios somente para Carga Lotacao.
    if LTipoOperacao = cOperacaoCargaLotacao then
    begin
      LIndicadores := TACBrJSONObject.Create;
      LIndicadores
        .AddPair('IndAltoDesempenho', BooleanoANTT(AltoDesempenho))
        .AddPair('IndRetornoVazio', BooleanoANTT(RetornoVazio))
        .AddPair('ComposicaoVeicular', BooleanoANTT(ComposicaoVeicular));

      Result.AddPair('InfIndicadoresOperacionais', LIndicadores);
    end;
  end;
end;

function TCIOTW_ANTT.GerarCancelamentoOperacaoTransporte: TACBrJSONObject;
begin
  Result := TACBrJSONObject.Create;

  with CIOT.CancelarOperacao do
  begin
    Result
      .AddPair('CodigoIdentificacaoOperacao', CodigoIdentificacaoOperacao)
      .AddPair('MotivoCancelamento', Motivo);
  end;
end;

function TCIOTW_ANTT.GerarRetificacaoOperacaoTransporte: TACBrJSONObject;
var
  LOrigem, LDestino: TLocalizacaoANTT;
  LOrigemDestino: TACBrJSONArray;
  LItemOD, LDadosCarga: TACBrJSONObject;
begin
  Result := TACBrJSONObject.Create;

  with CIOT.RetificarOperacao do
  begin
    Result
      .AddPair('CodigoIdentificacaoOperacao', CodigoIdentificacaoOperacao)
      .AddPair('ValorFrete', DecimalANTT(ValorFrete, 2), False)
      .AddPairISODate('DataFimViagem', DataFimViagem, False);

    LOrigem := Localizacao(CodigoMunicipioOrigem, CepOrigem,
      LatitudeOrigem, LongitudeOrigem);
    LDestino := Localizacao(CodigoMunicipioDestino, CepDestino,
      LatitudeDestino, LongitudeDestino);

    if (TipoLocalizacaoMaisEspecifico(LOrigem) <> tlNenhum) or
       (TipoLocalizacaoMaisEspecifico(LDestino) <> tlNenhum) then
    begin
      LItemOD := TACBrJSONObject.Create;
      GerarOrigemDestino(LItemOD, LOrigem, LDestino);

      LOrigemDestino := TACBrJSONArray.Create;
      LOrigemDestino.AddElementJSON(LItemOD);

      Result.AddPair('OrigemDestino', LOrigemDestino);
    end;

    if (CodigoNCMNaturezaCarga > 0) or (PesoCarga > 0) or
       (CodigoTipoCarga <> tpNaoAplicavel) then
    begin
      LDadosCarga := TACBrJSONObject.Create;
      LDadosCarga
        .AddPair('CodigoNaturezaCarga', InteiroANTT(CodigoNCMNaturezaCarga), False)
        .AddPair('PesoCarga', DecimalANTT(PesoCarga, 2), False)
        .AddPair('CodigoTipoCarga', InteiroANTT(StrToIntDef(TipoCargaToStr(CodigoTipoCarga), 0)), False);

      Result.AddPair('DadosCarga', LDadosCarga);
    end;
  end;
end;

function TCIOTW_ANTT.GerarEncerramentoOperacaoTransporte: TACBrJSONObject;
var
  LOrigemDestino: TACBrJSONArray;
  LDadosCarga: TACBrJSONObject;
  i: Integer;
begin
  Result := TACBrJSONObject.Create;

  with CIOT.EncerrarOperacao do
  begin
    Result.AddPair('CodigoIdentificacaoOperacao', CodigoIdentificacaoOperacao);

    // Origem/Destino e obrigatorio somente para TAC-Agregado (regra B58).
    if Viagens.Count > 0 then
    begin
      LOrigemDestino := TACBrJSONArray.Create;

      for i := 0 to Viagens.Count - 1 do
        LOrigemDestino.AddElementJSON(GerarItemOrigemDestino(Viagens[i], True, True));

      Result.AddPair('OrigemDestino', LOrigemDestino);
    end;

    // Peso da carga e obrigatorio somente para Carga Lotacao (regra B65).
    if PesoCarga > 0 then
    begin
      LDadosCarga := TACBrJSONObject.Create;
      LDadosCarga.AddPair('PesoTotalCarga', DecimalANTT(PesoCarga, 2));

      Result.AddPair('DadosCarga', LDadosCarga);
    end;
  end;
end;

function TCIOTW_ANTT.GerarConsultarExcecao: TACBrJSONObject;
begin
  // Servico consumido via GET com query parameter; o JSON gerado aqui serve
  // somente para registro/log do envio.
  Result := TACBrJSONObject.Create;
  Result.AddPair('CPFCNPJTransportador',
    OnlyCPFCNPJAlphaNum(CIOT.ConsultarTransportador.CpfCnpjTransportador));
end;

function TCIOTW_ANTT.GerarConsultarCIOTGerado: TACBrJSONObject;
begin
  Result := TACBrJSONObject.Create;

  with CIOT.ObterCodigoOperacaoTransporte do
  begin
    Result
      .AddPair('CodigoIdentificacaoOperacao', CodigoIdentificacaoOperacao)
      .AddPair('AnoDeclaracao', AnoDeclaracao, False);
  end;
end;

function TCIOTW_ANTT.GerarXml: Boolean;
var
  LJSon: TACBrJSONObject;
begin
  Gerador.ListaDeAlertas.Clear;
  Gerador.ArquivoFormatoXML := '';
  Gerador.LayoutArquivoTXT.Clear;
  Gerador.ArquivoFormatoTXT := '';

  LJSon := nil;

  case CIOT.Integradora.Operacao of
    opConsultarSituacaoTransportador:
      LJSon := GerarConsultarSituacaoTransportador;

    opConsultarFrota:
      LJSon := GerarConsultarFrotaTransportador;

    opAdicionar:
      LJSon := GerarDeclaracaoOperacaoTransporte;

    opCancelar:
      LJSon := GerarCancelamentoOperacaoTransporte;

    opRetificar:
      LJSon := GerarRetificacaoOperacaoTransporte;

    opEncerrar:
      LJSon := GerarEncerramentoOperacaoTransporte;

    opConsultarExcecao:
      LJSon := GerarConsultarExcecao;

    opObterCodigoIOT,
    opConsultarCIOTGerado:
      LJSon := GerarConsultarCIOTGerado;
  else
    Gerador.wAlerta('', 'Operacao', 'Operacao',
      'Operacao nao disponivel para a integradora ANTT.');
  end;

  if Assigned(LJSon) then
  begin
    try
      Gerador.ArquivoFormatoXML := LJSon.ToJSON;
    finally
      LJSon.Free;
    end;
  end;

  Result := (Gerador.ListaDeAlertas.Count = 0);
end;

end.
