{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2020 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Juliana Tamizou, André Ferreira de Moraes,      }
{ José M S Junior                                                              }
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

unit ACBrBancoBradescoMoneyPlus;

interface

uses
  Classes, Contnrs, SysUtils, ACBrBoleto, ACBrBoletoConversao;

type

  { TACBrBancoBradescoMoneyPlus }

  TACBrBancoBradescoMoneyPlus = class(TACBrBancoClass)
  private
    function ConverterMultaPercentual(const ACBrTitulo: TACBrTitulo): Double;
  protected
    function ConverterDigitoModuloFinal(): String; override;
    function DefineCampoLivreCodigoBarras(const ACBrTitulo: TACBrTitulo): String; override;
    function DefineEspecieDoc(const ACBrTitulo: TACBrTitulo): String; override;
    function DefinePosicaoAgenciaRetorno:Integer; override;           //Define posição para leitura de Retorno campo: Agencia
    function DefinePosicaoContaRetorno:Integer; override;             //Define posição para leitura de Retorno campo: Conta


  public
    Constructor create(AOwner: TACBrBanco);
    function MontarCampoNossoNumero(const ACBrTitulo :TACBrTitulo): String; override;
    function MontarCampoCodigoCedente(const ACBrTitulo: TACBrTitulo): String; override;
    procedure GerarRegistroTransacao400(ACBrTitulo : TACBrTitulo; aRemessa: TStringList); override;
    function  GerarRegistroTransacao240(ACBrTitulo: TACBrTitulo): String; override;

    function TipoOcorrenciaToDescricao(const TipoOcorrencia: TACBrTipoOcorrencia) : String; override;
    function CodOcorrenciaToTipo(const CodOcorrencia:Integer): TACBrTipoOcorrencia; override;
    function TipoOcorrenciaToCod(const TipoOcorrencia: TACBrTipoOcorrencia):String; override;
    function CodMotivoRejeicaoToDescricao(const TipoOcorrencia:TACBrTipoOcorrencia; CodMotivo:Integer): String; override;

    function CodOcorrenciaToTipoRemessa(const CodOcorrencia:Integer): TACBrTipoOcorrencia; override;
    function TipoOcorrenciaToCodRemessa(const TipoOcorrencia: TACBrTipoOcorrencia): String; override;
end;

implementation

uses {$IFDEF COMPILER6_UP} dateutils {$ELSE} ACBrD5 {$ENDIF},
  StrUtils, ACBrUtil.Base, ACBrUtil.Strings, ACBrUtil.DateTime ;

{ TACBrBancoBradescoMoneyPlus }

function TACBrBancoBradescoMoneyPlus.ConverterDigitoModuloFinal(): String;
begin
  if Modulo.ModuloFinal = 1 then
      Result:= 'P'
   else
      Result:= IntToStr(Modulo.DigitoFinal);
end;

function TACBrBancoBradescoMoneyPlus.DefineCampoLivreCodigoBarras(
  const ACBrTitulo: TACBrTitulo): String;
begin
  with ACBrTitulo.ACBrBoleto do
  begin
    Result := PadLeft(OnlyNumber(Cedente.Agencia), fpTamanhoAgencia, '0') +
                      ACBrTitulo.Carteira +
                      ACBrTitulo.NossoNumero +
                      PadLeft(RightStr(Cedente.Conta,7),7,'0') + '0';
  end;
end;

function TACBrBancoBradescoMoneyPlus.DefineEspecieDoc( const ACBrTitulo: TACBrTitulo ): String;
begin
  with ACBrTitulo do
  begin
    if ACBrBanco.ACBrBoleto.LayoutRemessa = c240 then
    begin
      if AnsiSameText(EspecieDoc, 'CH') then
        Result := '01'
      else
      if AnsiSameText(EspecieDoc, 'DM') then
        Result := '02'
      else
      if AnsiSameText(EspecieDoc, 'DMI') then
        Result := '03'
      else
      if AnsiSameText(EspecieDoc, 'DS') then
        Result := '04'
      else
      if AnsiSameText(EspecieDoc, 'DSI') then
        Result := '05'
      else
      if AnsiSameText(EspecieDoc, 'DR') then
        Result := '06'
      else
      if AnsiSameText(EspecieDoc, 'LC') then
        Result := '07'
      else
      if AnsiSameText(EspecieDoc, 'NCC') then
        Result := '08'
      else
      if AnsiSameText(EspecieDoc, 'NCE') then
        Result := '09'
      else
      if AnsiSameText(EspecieDoc, 'NCI') then
        Result := '10'
      else
      if AnsiSameText(EspecieDoc, 'NCR') then
        Result := '11'
      else
      if AnsiSameText(EspecieDoc, 'NP') then
        Result := '12'
      else
      if AnsiSameText(EspecieDoc, 'NPR') then
        Result := '13'
      else
      if AnsiSameText(EspecieDoc, 'TM') then
        Result := '14'
      else
      if AnsiSameText(EspecieDoc, 'TS') then
        Result := '15'
      else
      if AnsiSameText(EspecieDoc, 'NS') then
        Result := '16'
      else
      if AnsiSameText(EspecieDoc, 'RC') then
        Result := '17'
      else
      if AnsiSameText(EspecieDoc, 'FAT') then
        Result := '18'
      else
      if AnsiSameText(EspecieDoc, 'ND') then
        Result := '19'
      else
      if AnsiSameText(EspecieDoc, 'AP') then
        Result := '20'
      else
      if AnsiSameText(EspecieDoc, 'ME') then
        Result := '21'
      else
      if AnsiSameText(EspecieDoc, 'PC') then
        Result := '22'
      else
      if AnsiSameText(EspecieDoc, 'NF') then
        Result := '23'
      else
      if AnsiSameText(EspecieDoc, 'DD') then
        Result := '24'
      else
      if AnsiSameText(EspecieDoc, 'CPR') then
        Result := '25'
      else
        Result := '99';
    end
    else
    begin
      if LayoutVersaoArquivo <> 002 then
      begin
        {Layout_CNAB_400_V9_2-2.pdf}
        if AnsiSameText(EspecieDoc,'CH') then
           Result:= '01'
        else if AnsiSameText(EspecieDoc, 'DM') then
           Result:= '02'
        else if AnsiSameText(EspecieDoc, 'DMI') then
           Result:= '03'
        else if AnsiSameText(EspecieDoc, 'DS') then
           Result:= '04'
        else if AnsiSameText(EspecieDoc, 'DSI') then
           Result:= '05'
        else if AnsiSameText(EspecieDoc, 'DR') then
           Result:= '06'
        else if AnsiSameText(EspecieDoc, 'LC') then
           Result:= '07'
        else if AnsiSameText(EspecieDoc, 'NCC') then
           Result:= '08'
        else if AnsiSameText(EspecieDoc, 'NCE') then
           Result:= '09'
        else if AnsiSameText(EspecieDoc, 'NCI') then
           Result:= '10'
        else if AnsiSameText(EspecieDoc, 'NCR') then
           Result:= '11'
        else if AnsiSameText(EspecieDoc, 'NP') then
           Result:= '12'
        else if AnsiSameText(EspecieDoc, 'NPR') then
           Result:= '13'
        else if AnsiSameText(EspecieDoc, 'TM') then
           Result:= '14'
        else if AnsiSameText(EspecieDoc, 'TS') then
           Result:= '15'
        else if AnsiSameText(EspecieDoc, 'NS') then
           Result:= '16'
        else if AnsiSameText(EspecieDoc, 'RC') then
           Result:= '17'
        else if AnsiSameText(EspecieDoc, 'FAT') then
           Result:= '18'
        else if AnsiSameText(EspecieDoc, 'ND') then
           Result:= '19'
        else if AnsiSameText(EspecieDoc, 'AP') then
           Result:= '20'
        else if AnsiSameText(EspecieDoc, 'ME') then
           Result:= '21'
        else if AnsiSameText(EspecieDoc, 'PC') then
           Result:= '22'
        else if AnsiSameText(EspecieDoc, 'PF') then
           Result:= '23'
        else if AnsiSameText(EspecieDoc, 'DD') then
           Result:= '24'
        else if AnsiSameText(EspecieDoc, 'CPR') then
           Result:= '25'
        else if AnsiSameText(EspecieDoc, 'WT') then
           Result:= '26'
        else if AnsiSameText(EspecieDoc, 'DAE') then
           Result:= '27'
        else if AnsiSameText(EspecieDoc, 'DAM') then
           Result:= '28'
        else if AnsiSameText(EspecieDoc, 'DAU') then
           Result:= '29'
        else if AnsiSameText(EspecieDoc, 'EC') then
           Result:= '30'
        else if AnsiSameText(EspecieDoc, 'CC') then
           Result:= '31'
        else if AnsiSameText(EspecieDoc, 'BP') then
           Result:= '32'
        else if AnsiSameText(EspecieDoc, 'OU') then
           Result:= '99'
      end
      else
      begin
        if AnsiSameText(EspecieDoc,'DM') then
           Result:= '01'
        else if AnsiSameText(EspecieDoc, 'NP') then
           Result:= '02'
        else if AnsiSameText(EspecieDoc, 'NS') then
           Result:= '03'
        else if AnsiSameText(EspecieDoc, 'CS') then
           Result:= '04'
        else if AnsiSameText(EspecieDoc, 'REC') then
           Result:= '05'
        else if AnsiSameText(EspecieDoc, 'LC') then
           Result:= '10'
        else if AnsiSameText(EspecieDoc, 'ND') then
           Result:= '11'
        else if AnsiSameText(EspecieDoc, 'DS') then
           Result:= '12'
        else if AnsiSameText(EspecieDoc, 'BDP') then
           Result:= '32'
        else if AnsiSameText(EspecieDoc, 'OU') then
           Result:= '99'
        else
           Result := EspecieDoc;
      end;
    end;
  end;

end;

function TACBrBancoBradescoMoneyPlus.DefinePosicaoAgenciaRetorno: Integer;
begin
  if ACBrBanco.ACBrBoleto.LayoutRemessa = c240 then
    Result := 53
  else
    Result := 24;
end;

function TACBrBancoBradescoMoneyPlus.DefinePosicaoContaRetorno: Integer;
begin
  if ACBrBanco.ACBrBoleto.LayoutRemessa = c240 then
    Result := 59
  else
    Result := 28;
end;

function TACBrBancoBradescoMoneyPlus.ConverterMultaPercentual(
  const ACBrTitulo: TACBrTitulo): Double;
begin
  with ACBrTitulo do
  begin
    if MultaValorFixo then
        if (ValorDocumento > 0) then
          Result := (PercentualMulta / ValorDocumento) * 100
        else
          Result := 0
      else
        Result := PercentualMulta;
  end;

end;

constructor TACBrBancoBradescoMoneyPlus.create(AOwner: TACBrBanco);
begin
   inherited create(AOwner);
   fpDigito                 := 7;
   fpNome                   := 'MONEYPLUS';
   fpNumero                 := 274;
   fpTamanhoMaximoNossoNum  := 11;
   fpTamanhoAgencia         := 4;
   fpTamanhoConta           := 7;
   fpTamanhoCarteira        := 2;
   fpLayoutVersaoArquivo    := 84;
   fpLayoutVersaoLote       := 42;
   fpDensidadeGravacao      := '06250';
   fpModuloMultiplicadorInicial:= 2;
   fpModuloMultiplicadorFinal  := 7;
   fpCodParametroMovimento     := 'MX';
   FDigitosSequencialArquivoRemessa := 7;
end;

function TACBrBancoBradescoMoneyPlus.MontarCampoCodigoCedente( const ACBrTitulo: TACBrTitulo): String;
begin
  Result := RightStr(ACBrTitulo.ACBrBoleto.Cedente.Agencia,4)+' / '+
            IntToStr(StrToInt64Def(ACBrTitulo.ACBrBoleto.Cedente.Conta,0))+'-'+
            ACBrTitulo.ACBrBoleto.Cedente.ContaDigito;
end;

function TACBrBancoBradescoMoneyPlus.MontarCampoNossoNumero (
   const ACBrTitulo: TACBrTitulo ) : String;
begin
   Result:= ACBrTitulo.Carteira+'/'+ACBrTitulo.NossoNumero+'-'+CalcularDigitoVerificador(ACBrTitulo);
end;

function TACBrBancoBradescoMoneyPlus.GerarRegistroTransacao240(ACBrTitulo: TACBrTitulo): String;
var
  ATipoOcorrencia,
  ATipoBoleto,
  ADataMoraJuros,
  ACodigoMoraJuros,
  ACodigoDesconto: String;
  ADataDesconto,
  ACodigoMulta,
  ADataMulta,
  ATipoAceite,
  AEspecieDoc: String;

  Fsequencia:Integer;
  FdigitoNossoNumero: String;
  FcodCarteira: String;
  ACodProtesto: String;
  ListTransacao: TStringList;

begin
  Fsequencia     := 3 * ACBrTitulo.ACBrBoleto.ListadeBoletos.IndexOf(ACBrTitulo);

  //Caracteristica Título
  FcodCarteira := DefineCaracTitulo(ACBrTitulo);

  //Digito Nosso Número
  FdigitoNossoNumero := CalcularDigitoVerificador(ACBrTitulo);

  {Código para Protesto}
  ACodProtesto := DefineTipoDiasProtesto(ACBrTitulo);

  {Tipo de Ocorrencia}
  ATipoOcorrencia := TipoOcorrenciaToCodRemessa(ACBrTitulo.OcorrenciaOriginal.Tipo);

  {Aceite do Titulo }
  ATipoAceite := DefineAceite(ACBrTitulo);

  {Especie Documento}
  AEspecieDoc := DefineEspecieDoc(ACBrTitulo);

  {Responsavel Emissão}
  ATipoBoleto := DefineResponsEmissao;

  {Código Mora}
  ACodigoMoraJuros := DefineCodigoMoraJuros(ACBrTitulo);

  {Data Mora}
  ADataMoraJuros := DefineDataMoraJuros(ACBrTitulo);

  {Código Desconto}
  ACodigoDesconto := DefineCodigoDesconto(ACBrTitulo);

  {Data Desconto}
  ADataDesconto := DefineDataDesconto(ACBrTitulo);

  {Código Multa}
  ACodigoMulta := DefineCodigoMulta(ACBrTitulo);

  {Data Multa}
  ADataMulta := DefineDataMulta(ACBrTitulo);

  ListTransacao:= TStringList.Create;
  try

    with ACBrTitulo do
    begin
      {REGISTRO P}
      ListTransacao.Add(IntToStrZero(ACBrBanco.Numero, 3)    + //1 a 3 - Código do banco
        '0001'                                               + //4 a 7 - Lote de serviço
        '3'                                                  + //8 - Tipo do registro: Registro detalhe
        IntToStrZero(Fsequencia+1,5)                         + //Nº Sequencial do Registro no Lote 9 13 5 - Num *G038
        'P'                                                  + //14 - Código do segmento do registro detalhe
        ' '                                                  + //15 - Uso exclusivo FEBRABAN/CNAB: Branco
        ATipoOcorrencia                                      + //Código de Movimento Remessa 16 17 2 - Num *C004
        PadLeft(OnlyNumber(ACBrTitulo.ACBrBoleto.Cedente.Agencia), 5, '0') + //18 a 22 - Agência mantenedora da conta
        PadRight(ACBrBoleto.Cedente.AgenciaDigito, 1 , '0')  + //23 -Dígito verificador da agência
        PadLeft(ACBrBoleto.Cedente.Conta, 12, '0')           + //24 a 35 - Número da Conta Corrente
        Padleft(ACBrBoleto.Cedente.ContaDigito, 1 , '0')     + //36 a 36 Dígito Verificador da Conta Alfa *G011
        ' '                                                  + //Retornaram que deve gravar vazio .. contrario ao layout
        //PadLeft(Copy(Fconta,Length(Fconta) ,1 ),1, ' ')    + //37-37Dígito Verificador da Ag/Conta 37 37 1 - Alfa *G012
        PadLeft(ACBrTitulo.Carteira, 3, '0')                 + //38-40 Identificação do Produto 38 40 3 Num *G069
        PadLeft('0', 5, '0')                                 + //Zeros 41 45 5 Num *G069
        PadLeft(NossoNumero, 11, '0')                        + //Nosso Número 46 56 11 Num *G069
        PadLeft(FdigitoNossoNumero,1,'0')                    + //Digito do nosso Número 57 57 1 Num *G069
        PadLeft(FcodCarteira,1,'0' )                         + //Código da Carteira 58 58 1 - Num *C006
        '1'                                                  + //Forma de Cadastr. do Título no Banco 59 59 1 - Num *C007   1-cobrança Registrada
        '1'                                                  + //Tipo de Documento 60 60 1 - Alfa C008    -1-Tradicional
        ATipoBoleto                                          + //Identificação da Emissão do Bloqueto 61 61 1 - Num *C009
        ATipoBoleto                                          +//Identificação da Distribuição 62 62 1 - Alfa C010  -Quem emite que distribua...
        PadRight(NumeroDocumento, 15, ' ')                   + //Número do Documento de Cobrança 63 77 15 - Alfa *C011
        FormatDateTime('ddmmyyyy', Vencimento)               + //Data de Vencimento do Título 78 85 8 - Num *C012
        IntToStrZero( round( ValorDocumento * 100), 15)      + //Valor Nominal do Título 86 100 13 2 Num *G070
        Padleft('0', 5, '0')                                 + //Agência Encarregada da Cobrança 101 105 5 - Num *C014
        '0'                                                  + //Dígito Verificador da Agência 106 106 1 - Alfa *G009
        PadRight(AEspecieDoc, 2)                             + //Espécie do Título 107 108 2 - Num *C015
        ATipoAceite                                          + //Identific. de Título Aceito/Não Aceito 109 109 1 - Alfa C016
        FormatDateTime('ddmmyyyy', DataDocumento)            + //Data da Emissão do Título 110 117 8 - Num G071
        ACodigoMoraJuros                                     + //Código do Juros de Mora 118 118 1 - Num *C018  '1' = Valor por Dia'2' = Taxa Mensal '3' = Isento
        ADataMoraJuros                                       + //Data do Juros de Mora 119 126 8 - Num *C019
        IfThen(ValorMoraJuros > 0, IntToStrZero(round(ValorMoraJuros * 100), 15),PadRight('', 15, '0')) + //juros de Mora por Dia/Taxa 127 141 13 2 Num C020
        ACodigoDesconto                                      + //Código do Desconto 1 142 142 1 - Num *C021
        ADataDesconto                                        + //Data do Desconto 1 143 150 8 - Num C022
        IfThen(ValorDesconto > 0, IntToStrZero(
        round(ValorDesconto * 100), 15),PadRight('', 15, '0'))
                                                             + //Valor/Percentual a ser Concedido 151 165 13 2 Num C023
        IntToStrZero( round(ValorIOF * 100), 15)             + //Valor do IOF a ser Recolhido 166 180 13 2 Num C024
        IntToStrZero( round(ValorAbatimento * 100), 15)      + //Valor do Abatimento 181 195 13 2 Num G045

        PadRight(IfThen(SeuNumero <> '',SeuNumero,NumeroDocumento), 25, ' ')                + //Identificação do Título na Empresa 196 220 25 - Alfa G072

        IfThen((DataProtesto <> 0) and (DiasDeProtesto > 0), ACodProtesto, '3')            + //Código para Protesto 221 221 1 - Num C026

        IfThen((DataProtesto <> 0) and (DiasDeProtesto > 0),
                        PadLeft(IntToStr(DiasDeProtesto), 2, '0'), '00')                   + //Número de Dias para Protesto 222 223 2 - Num C027

        IfThen((DataBaixa <> 0) and (DataBaixa > Vencimento), '1', '2')                    + //Código para Baixa/Devolução 224 224 1 - Num C028

        IfThen((DataBaixa <> 0) and (DataBaixa > Vencimento),PadLeft(IntToStr(DaysBetween(DataBaixa, Vencimento)), 3, '0'), '000') + //Número de Dias para Baixa/Devolução 225 227 3 - Alfa C029
        '09'                                                + //Código da Moeda 228 229 2 - Num *G065   '09' = Real
        PadRight('', 10 , '0')                              + //Nº do Contrato da Operação de Créd. 230 239 10 - Num C030
        ' ');                                                 //240 - Uso exclusivo FEBRABAN/CNAB

      {SEGMENTO Q}
      ListTransacao.Add(IntToStrZero(ACBrBanco.Numero, 3) + //Código do Banco na Compensação 1 3 3 - Num G001
        '0001'                                              + //Lote Lote de Serviço 4 7 4 - Num *G002
        '3'                                                 + //Tipo de Registro 8 8 1 - Num ‘3’ *G003
        IntToStrZero(Fsequencia+ 2 ,5)                      + //Nº Sequencial do Registro no Lote 9 13 5 - Num *G038
        'Q'                                                 + //Cód. Segmento do Registro Detalhe 14 14 1 - Alfa ‘Q’ *G039
        ' '                                                 + //Uso Exclusivo FEBRABAN/CNAB 15 15 1 - Alfa Brancos G004
        ATipoOcorrencia                                     + //Código de Movimento Remessa 16 17 2 - Num *C004

        {Dados do sacado}
        IfThen(Sacado.Pessoa = pJuridica,'2','1')           + //Tipo Tipo de Inscrição 18 18 1 - Num *G005
        PadLeft(OnlyCPFCNPJAlphaNum(Sacado.CNPJCPF), 15, '0')        + //Número Número de Inscrição 19 33 15 - Num *G006
        PadRight(Sacado.NomeSacado, 40, ' ')                + //Nome 34 73 40 - Alfa G013
        PadRight(Sacado.Logradouro + ' ' + Sacado.Numero +' ' + Sacado.Complemento , 40, ' ') + //Endereço 74 113 40 - Alfa G032
        PadRight(Sacado.Bairro, 15, ' ')                    + //Bairro 114 128 15 - Alfa G032
        PadLeft(OnlyNumber(ACBrTitulo.Sacado.CEP), 8, '0')  + //CEP 129 133 5 - Num G034    + //Sufixo do CEP 134 136 3 - Num G035
        PadRight(Sacado.Cidade, 15, ' ')                    + // Cidade 137 151 15 - Alfa G033
        PadRight(Sacado.UF, 2, ' ')                         + //Unidade da Federação 152 153 2 - Alfa G036
        {Dados do sacador/avalista}
        '0'                                                 + // 154 a 154 - Tipo de Inscrição 154 154 1 - Num *G005
        PadRight('', 15, '0')                               + // Número de Inscrição 155 169 15 - Num *G006
        PadRight('', 40, ' ')                               + // Nome do Pagadorr/Avalista 170 209 40 - Alfa G013
        PadRight('0', 3, '0')                               + // Cód. Bco. Corresp. na Compensação 210 212 3 - Num *C031
        PadRight('',20, ' ')                                + // Nosso Nº no Banco Correspondente 213 232 20 - Alfa *C032
        PadRight('', 8, ' '));                                 // FEBRABAN/CNAB 233 240 8 - Alfa Brancos G004

    {SEGMENTO R OPCIONAL }
      ListTransacao.Add(IntToStrZero(ACBrBanco.Numero, 3)    + //Código do Banco na Compensação 1 3 3 - Num G001
        '0001'                                               + //Lote de Serviço 4 7 4 - Num *G002
        '3'                                                  + //Tipo de Registro 8 8 1 - Num ‘3’ *G003
        IntToStrZero(Fsequencia+ 3 ,5)                       + //Nº Sequencial do Registro no Lote 9 13 5 - Num *G038
        'R'                                                  + //Cód. Segmento do Registro Detalhe 14 14 1 - Alfa ‘R’ *G039
        ' '                                                  + //CNAB Uso Exclusivo FEBRABAN/CNAB 15 15 1 - Alfa Brancos G004
        ATipoOcorrencia                                      + //Código de Movimento Remessa 16 17 2 - Num *C004
        PadLeft('', 1,  '0')                                 + //Código do Desconto 2 18 18 1 - Num *C021
        PadLeft('', 8,  '0')                                 + //Data do Desconto 2 19 26 8 - Num C022
        PadLeft('', 15, '0')                                 + //Valor/Percentual a ser Concedido 27 41 13 2 Num C023
        PadLeft('', 1,  '0')                                 + //Código do Desconto 3 42 42 1 - Num *C021
        PadLeft('', 8,  '0')                                 + //Data do Desconto 3 43 50 8 - Num C022
        PadLeft('', 15, '0')                                 + //Valor/Percentual a Ser Concedido 51 65 13 2 Num C023
        ACodigoMulta                                         + //Código da Multa 66 66 1 - Alfa G073
        ADataMulta                                           + //Data da Multa 67 74 8 - Num G074
        IfThen(PercentualMulta > 0,
          IntToStrZero(round(PercentualMulta * 100), 15),
        PadRight('', 15, '0'))                               + //Multa Valor/Percentual a Ser Aplicado 75 89 13 2 Num G075
        PadRight('', 10, ' ')                                + //Informação ao Pagador Informação ao Pagador 90 99 10 - Alfa *C036
        PadRight('', 40, ' ')                                + //Informação 3 Mensagem 3 100 139 40 - Alfa *C037
        PadRight('', 40, ' ')                                + //Mensagem 4 140 179 40 - Alfa *C037
        PadRight('', 20, ' ')                                + //CNAB Uso Exclusivo FEBRABAN/CNAB 180 199 20 - Alfa Brancos G004
        PadLeft('', 8, '0')                                  +//Cód. Ocor. do Pagador 200 207 8 - Num *C038
        PadLeft('', 3, '0')                                  +//Cód. do Banco na Conta do Débito 208 210 3 - Num G001
        PadLeft('', 5, '0')                                  +//Código da Agência do Débito 211 215 5 - Num *G008
        PadLeft('', 1, ' ')                                  +//Dígito Verificador da Agência 216 216 1 - Alfa *G009
        PadLeft('', 12, '0')                                 +//Corrente para Débito 217 228 12 - Num *G010
        PadLeft('', 1, ' ')                                  +//Dígito Verificador da Conta 229 229 1 - Alfa *G011
        PadLeft('', 1, ' ')                                  +//DV Dígito Verificador Ag/Conta 230 230 1 - Alfa *G012
        PadLeft('', 1, '3')                                  +//Ident. da Emissão do Aviso Déb. Aviso para Débito Automático 231 231 1 - Num *C039
        PadLeft('',9, ' '));                                  //CNAB Uso Exclusivo FEBRABAN/CNAB 232 240 9 - Alfa Brancos G004

    end;
    Result := RemoverQuebraLinhaFinal(ListTransacao.Text);
  finally
    ListTransacao.Free;
  end;
end;

procedure TACBrBancoBradescoMoneyPlus.GerarRegistroTransacao400(ACBrTitulo :TACBrTitulo; aRemessa: TStringList);
var
  sOcorrencia, sEspecie, aAgencia: String;
  sProtesto, sTipoSacado, MensagemCedente, aConta, aDigitoConta: String;
  aCarteira, wLinha, sNossoNumero, sDigitoNossoNumero, sTipoBoleto: String;
  aPercMulta: Double;
  LBanco, LTipoEmissaoBoleto, LAvisoDebitoAuto, LQtdePagamento, LInstrucoesProtesto,
  LMensagemCedente, LDebitoAutomatico, LTipoAvalista : String;
  LChaveNFE : String;
  I: TACBrTitulo;
  J:Integer;
begin
   with ACBrTitulo do
   begin
     ValidaNossoNumeroResponsavel(sNossoNumero, sDigitoNossoNumero, ACBrTitulo);

     aAgencia := IntToStrZero(StrToIntDef(OnlyNumber(ACBrBoleto.Cedente.Agencia),0),5);
     aConta   := IntToStrZero(StrToIntDef(OnlyNumber(ACBrBoleto.Cedente.Conta),0),7);
     aCarteira:= IntToStrZero(StrToIntDef(trim(Carteira),0), 3);
     aDigitoConta := PadLeft(trim(ACBrBoleto.Cedente.ContaDigito),1,'0');

     {Código da Ocorrencia}
     sOcorrencia:= TipoOcorrenciaToCodRemessa(OcorrenciaOriginal.Tipo);

     {Tipo de Boleto}
     sTipoBoleto:= DefineTipoBoleto(ACBrTitulo);

     {Especie}
     sEspecie:= DefineEspecieDoc(ACBrTitulo);

     {Intruções}
     sProtesto:= InstrucoesProtesto(ACBrTitulo);

     {Tipo de Sacado}
     sTipoSacado := DefineTipoSacado(ACBrTitulo);

     { Converte valor em moeda para percentual, pois o arquivo só permite % }
     aPercMulta := ConverterMultaPercentual(ACBrTitulo);

     {Tipo de Avalista}
     LTipoAvalista := DefineTipoSacadoAvalista(ACBrTitulo);

      if LayoutVersaoArquivo = 002 then // Grafeno
      begin
        LBanco              := '274';
        LQtdePagamento      := '01';
        LDebitoAutomatico   := ' ';
        LMensagemCedente    := PadRight( MensagemCedente, 60 );
      end
      else
      begin
        LTipoEmissaoBoleto  := sTipoBoleto;
        LAvisoDebitoAuto    := '2';
        LDebitoAutomatico   := 'N';
        LInstrucoesProtesto := sProtesto;
        LMensagemCedente    := LTipoAvalista                                             + // 335 a 335 - Tipo de Inscrição 0 isento 1 cpf 2 cnpj 3 pis/pasep 9 outros
                               PadLeft(OnlyCPFCNPJAlphaNum(Sacado.SacadoAvalista.CNPJCPF),14,'0') + // 336 a 350 - Número de Inscrição do Avalista
                               PadRight(Sacado.SacadoAvalista.NomeAvalista, 40, ' ');      // 351 a 394 - Nome do Avalista
      end;

     if ACBrTitulo.ListaDadosNFe.Count>0 then
       LChaveNFe := ACBrTitulo.ListaDadosNFe[0].ChaveNFe
     else
       LChaveNFe := '';

     with ACBrBoleto do
     begin
       if Mensagem.Text <> '' then
          MensagemCedente:= Mensagem[0];

       wLinha:= '1'                                            +  // 001 a 001 - ID Registro
       StringOfChar( '0', 05)                                  +  // 002 a 006 - Dados p/ Débito Automático
       StringOfChar( '0', 01)                                  +  // 007 a 007 - Dados p/ Débito Automático
       StringOfChar( '0', 05)                                  +  // 008 a 012 - Dados p/ Débito Automático
       StringOfChar( '0', 07)                                  +  // 013 a 019 - Dados p/ Débito Automático
       StringOfChar( '0', 01)                                  +  // 020 a 020 - Dados p/ Débito Automático
       '0'                                                     +  // 021 a 021 - Zero
       aCarteira                                               +  // 022 a 024 - Codigos da carteira
       aAgencia                                                +  // 025 a 029 - Agencia beneficiario sem o digito
       aConta                                                  +  // 030 a 036 - conta corrente
       aDigitoConta                                            +  // 037 a 037 - Digito da conta
       PadRight( SeuNumero,15,' ')                             +  // 038 a 052 - Numero de Controle do Participante
       StringOfChar(' ', 10)                                   +  // 053 a 062 - Numero de Controle do Participante
       PadRight(LBanco,3, '0')                                 +  // 063 a 065 - Código do Banco
       IfThen( PercentualMulta > 0, '2', '0')                  +  // 066 a 066 - Indica se exite Multa ou não
       IntToStrZero( round( aPercMulta * 100 ) , 4)            +  // 067 a 070 - Percentual de Multa formatado com 2 casas decimais
       sNossoNumero                                            +  // 071 a 081 - Identificação do Titulo
       sDigitoNossoNumero                                      +  // 082 a 082 - Digito Identificação do Titulo
       IntToStrZero( round( ValorDescontoAntDia * 100), 10)    +  // 083 a 092 - Desconto Bonificação por dia
       PadRight(LTipoEmissaoBoleto,1)                          +  // 093 a 093 - Condicao para emissao da papeleta cobranca  Tipo Boleto(Quem emite)
       LDebitoAutomatico                                       +  // 094 a 094 - Identificação se emite boleto para débito automático
       Space(10)                                               +  // 095 a 104 - Identificação Operação do Banco
       ' '                                                     +  // 105 a 105 - Ind. Rateio de Credito
       PadRight(LAvisoDebitoAuto,1)                            +  // 106 a 106 - Aviso de Debito Aut.: 2=Não emite aviso
       PadRight(LQtdePagamento,2)                              +  // 107 a 108 - BRANCO
       sOcorrencia                                             +  // 109 a 110 - Ocorrência
       PadRight( NumeroDocumento,  10)                         +  // 111 a 120 - Numero Documento
       FormatDateTime( 'ddmmyy', Vencimento)                   +  // 121 a 126 - Data Vencimento
       IntToStrZero( Round( ValorDocumento * 100 ), 13)        +  // 127 a 139 - Valo Titulo
       StringOfChar('0',3)                                     +  // 140 a 142 - Zeros
       StringOfChar('0',5)                                     +  // 143 a 147 - zeros
       PadRight(sEspecie,2)                                    +  // 148 a 149 - Especie do documento
       'N'                                                     +  // 140 a 150 - Identificação(valor fixo N)
       FormatDateTime( 'ddmmyy', DataDocumento )               +  // 151 a 156 - Data de Emissão
       PadRight(LInstrucoesProtesto,4)                         +  // 157 a 160 - Intruções de Protesto (1 e 2 instrucoes)
       IntToStrZero( round(ValorMoraJuros * 100 ), 13)         +  // 161 a 173 - Valor a ser cobrado por dia de atraso
       IfThen(DataDesconto < EncodeDate(2000,01,01),'000000',
              FormatDateTime( 'ddmmyy', DataDesconto))         +  // 174 a 179 - Data limite para concessão desconto
       IntToStrZero( round( ValorDesconto * 100 ), 13)         +  // 180 a 192 - Valor Desconto
       IntToStrZero( round( ValorIOF * 100 ), 13)              +  // 193 a 205 - Valor IOF
       IntToStrZero( round( ValorAbatimento * 100 ), 13)       +  // 206 a 218 - Valor Abatimento
       sTipoSacado                                             +  // 219 a 220 - Tipo de Inscrição 01 cpf 02 cnpj
       PadLeft(OnlyCPFCNPJAlphaNum(Sacado.CNPJCPF),14,'0')              +  // 221 a 234 - Número de Inscrição do Pagador
       PadRight( Sacado.NomeSacado, 40, ' ')                   +  // 235 a 274 - Nome do Pagador
       PadRight(Sacado.Logradouro + ' ' + Sacado.Numero + ' '  +
         Sacado.Complemento, 40)                               +  // 275 a 314
       PadRight( Sacado.Mensagem, 12, ' ')                     +  // 315 a 326 - 1ª Mensagem
       PadRight( Sacado.CEP, 8 )                               +  // 327 a 334 - CEP + Sufixo CEP
       PadRight(LMensagemCedente,60)                           +  // 335 a 394 - 2ª Mensagem
       IntToStrZero(aRemessa.Count + 1, 6)                     +  // Nº SEQÜENCIAL DO REGISTRO NO ARQUIVO
       LChaveNFe;                                                          // 401 a 444 Chave NFe
       aRemessa.Add(UpperCase(wLinha));
       wLinha := MontaInstrucoesCNAB400(ACBrTitulo, aRemessa.Count );

       if not(wLinha = EmptyStr) then
         aRemessa.Add(UpperCase(wLinha));


       if (DataProtesto > Vencimento) and (LayoutVersaoArquivo = 003) then
       begin
         wLinha := '2';                                                         // 001 a 001 - Tipo do Registro
            for J := 0 to 3 do
            begin
                                                                                // 002 a 081 Mensagem 1 080
                                                                                // 082 a 161 Mensagem 2 080
                                                                                // 162 a 241 Mensagem 3 080
                                                                                // 242 a 321 Mensagem 4 080
              if (ACBrTitulo.Mensagem.Count > J) then
                wLinha := wLinha + PadRight(ACBrTitulo.Mensagem[J], 80)
              else
                wLinha := wLinha + Space(80);
            end;
         wLinha := wLinha
            + PadRight(Sacado.Numero,6)                                         // 322 a 327 Número Pagador 006
            + PadRight(Sacado.Bairro, 20)                                       // 328 a 347 Bairro Pagador 020
            + PadRight(Sacado.UF, 2)                                            // 348 a 349 UF Pagador 002
            + PadRight(Sacado.Cidade, 30)                                       // 350 a 379 Cidade Pagador 030
            + Space(15)                                                         // 380 a 394 Branco 015
            + IntToStrZero(aRemessa.Count + 1, 6);                              // 395 a 400 Nº Sequencial de Registro 006

         if not(wLinha = EmptyStr) then
           aRemessa.Add(UpperCase(wLinha));
       end;

       if (Sacado.SacadoAvalista.NomeAvalista <> '') and (LayoutVersaoArquivo = 002) then
       begin
          wLinha := '7'                                                     + // 001 a 001 - Identificação do registro detalhe (7)
          PadRight(Sacado.SacadoAvalista.Logradouro, 45, ' ')               + // 002 a 046 - Endereço Sacador/Avalista
          PadRight( OnlyNumber(Sacado.SacadoAvalista.CEP), 8 )              + // 047 a 054 - CEP + Sufixo do CEP
          PadRight(Sacado.SacadoAvalista.Cidade, 45, ' ')                   + // 055 a 074 - Cidade
          PadRight(Sacado.SacadoAvalista.UF, 5, ' ')                        + // 075 a 076 - UF
          PadRight('', 290, ' ')                                            + // 077 a 366 - Reserva
          PadLeft(ACBrTitulo.Carteira, 3, '0')                              + // 367 a 369 - Carteira
          PadLeft(OnlyNumber(ACBrTitulo.ACBrBoleto.Cedente.Agencia), 5, '0')+ // 370 a 374 - Agência mantenedora da conta
          PadLeft(ACBrBoleto.Cedente.Conta, 7, '0')                         + // 375 a 381 - Número da Conta Corrente
          Padleft(ACBrBoleto.Cedente.ContaDigito, 1 , '0')                  + // 382 a 382 - Dígito Verificador da Conta Alfa
          PadLeft(NossoNumero, 11, '0')                                     + // 383 a 393 - Nosso Número
          PadLeft(sDigitoNossoNumero ,1,'0')                                + // 394 a 394 - Digito Nosso Número
          IntToStrZero( ARemessa.Count + 1, 6);                               // 395 a 400 - Número sequencial do registro

          ARemessa.Text:= ARemessa.Text + UpperCase(wLinha);
       end;
     end;
   end;

end;

function TACBrBancoBradescoMoneyPlus.TipoOcorrenciaToDescricao(const TipoOcorrencia: TACBrTipoOcorrencia): String;
var
  CodOcorrencia: Integer;
begin
  Result := '';
  CodOcorrencia := StrToIntDef(TipoOcorrenciaToCod(TipoOcorrencia),0);

  if (ACBrBanco.ACBrBoleto.LayoutRemessa = c240) then
  begin
    case CodOcorrencia of
      04: Result := '04-Transferência de Carteira/Entrada';
      05: Result := '05-Transferência de Carteira/Baixa';
      07: Result := '07-Confirmação do Recebimento da Instrução de Desconto';
      08: Result := '08-Confirmação do Recebimento do Cancelamento do Desconto';
      15: Result := '15-Franco de Pagamento';
      24: Result := '24-Retirada de Cartório e Manutenção em Carteira';
      25: Result := '25-Protestado e Baixado';
      26: Result := '26-Instrução Rejeitada';
      27: Result := '27-Confirmação do Pedido de Alteração de Outros Dados';
      33: Result := '33-Confirmação da Alteração dos Dados do Rateio de Crédito';
      34: Result := '34-Confirmação do Cancelamento dos Dados do Rateio de Crédito';
      36: Result := '36-Confirmação de Envio de E-mail/SMS';
      37: Result := '37-Envio de E-mail/SMS Rejeitado';
      38: Result := '38-Confirmação de Alteração do Prazo Limite de Recebimento';
      39: Result := '39-Confirmação de Dispensa de Prazo Limite de Recebimento';
      40: Result := '40-Confirmação da Alteração do Número do Título Dado pelo Beneficiario';
      41: Result := '41-Confirmação da Alteração do Número Controle do Participante';
      42: Result := '42-Confirmação da Alteração dos Dados do Pagador';
      43: Result := '43-Confirmação da Alteração dos Dados do Sacador/Avalista';
      44: Result := '44-Título Pago com Cheque Devolvido';
      45: Result := '45-Título Pago com Cheque Compensado';
      46: Result := '46-Instrução para Cancelar Protesto Confirmada';
      47: Result := '47-Instrução para Protesto para Fins Falimentares Confirmada';
      48: Result := '48-Confirmação de Instrução de Transferência de Carteira/Modalidade de Cobrança';
      49: Result := '49-Alteração de Contrato de Cobrança';
      50: Result := '50-Título Pago com Cheque Pendente de Liquidação';
      51: Result := '51-Título DDA Reconhecido pelo Pagador';
      52: Result := '52-Título DDA não Reconhecido pelo Pagador';
      53: Result := '53-Título DDA recusado pela CIP';
      54: Result := '54-Confirmação da Instrução de Baixa de Título Negativado sem Protesto';
    end;
  end
  else
  begin
    case CodOcorrencia of
      10: Result := '10-Baixado Conforme Instruções da Agência';
      15: Result := '15-Liquidação em Cartório';
      16: Result := '16-Titulo Pago em Cheque - Vinculado';
      18: Result := '18-Acerto de Depositária';
      21: Result := '21-Acerto do Controle do Participante';
      22: Result := '22-Titulo com Pagamento Cancelado';
      24: Result := '24-Entrada Rejeitada por CEP Irregular';
      25: Result := '25-Confirmação Recebimento Instrução de Protesto Falimentar';
      27: Result := '27-Baixa Rejeitada';
      32: Result := '32-Instrução Rejeitada';
      33: Result := '33-Confirmação Pedido Alteração Outros Dados';
      34: Result := '34-Retirado de Cartório e Manutenção Carteira';
      40: Result := '40-Estorno de Pagamento';
      55: Result := '55-Sustado Judicial';
      68: Result := '68-Acerto dos Dados do Rateio de Crédito';
      69: Result := '69-Cancelamento dos Dados do Rateio';
      74: Result := '74-Confirmação Pedido de Exclusão de Negatativação';
    end;
  end;

  if (Result <> '') then
    Exit;

  case CodOcorrencia of
    02: Result := '02-Entrada Confirmada';
    03: Result := '03-Entrada Rejeitada';
    06: Result := '06-Liquidação Normal';
    09: Result := '09-Baixado Automaticamente via Arquivo';
    11: Result := '11-Em Ser - Arquivo de Títulos Pendentes';
    12: Result := '12-Abatimento Concedido';
    13: Result := '13-Abatimento Cancelado';
    14: Result := '14-Vencimento Alterado';
    17: Result := '17-Liquidação após baixa ou Título não registrado';
    19: Result := '19-Confirmação Recebimento Instrução de Protesto';
    20: Result := '20-Confirmação Recebimento Instrução Sustação de Protesto';
    23: Result := '23-Entrada do Título em Cartório';
    28: Result := '28-Débito de tarifas/custas';
    29: Result := '29-Ocorrências do Pagador';
    30: Result := '30-Alteração de Outros Dados Rejeitados';
    35: Result := '35-Desagendamento do débito automático';
    73: Result := '73-Confirmação Recebimento Pedido de Negativação';
  end;
end;

function TACBrBancoBradescoMoneyPlus.CodOcorrenciaToTipo(const CodOcorrencia:
   Integer ) : TACBrTipoOcorrencia;
begin
  Result := toTipoOcorrenciaNenhum;

  if (ACBrBanco.ACBrBoleto.LayoutRemessa = c240) then
  begin
    case CodOcorrencia of
      04: Result := toRetornoTransferenciaCarteiraEntrada;
      05: Result := toRetornoTransferenciaCarteiraBaixa;
      07: Result := toRetornoRecebimentoInstrucaoConcederDesconto;
      08: Result := toRetornoRecebimentoInstrucaoCancelarDesconto;
      15: Result := toRetornoBaixadoFrancoPagamento;
      24: Result := toRetornoRetiradoDeCartorio;
      25: Result := toRetornoBaixaPorProtesto;
      26: Result := toRetornoComandoRecusado;
      27: Result := toRetornoRecebimentoInstrucaoAlterarDados;
      33: Result := toRetornoAcertoDadosRateioCredito;
      34: Result := toRetornoCancelamentoDadosRateio;
      36: Result := toRetornoConfirmacaoEmailSMS;
      37: Result := toRetornoEmailSMSRejeitado;
      38: Result := toRetornoAlterarPrazoLimiteRecebimento;
      39: Result := toRetornoDispensarPrazoLimiteRecebimento;
      40: Result := toRetornoAlteracaoSeuNumero;
      41: Result := toRetornoAcertoControleParticipante;
      42: Result := toRetornoRecebimentoInstrucaoAlterarNomeSacado;
      43: Result := toRetornoAlterarSacadorAvalista;
      44: Result := toRetornoChequeDevolvido;
      45: Result := toRetornoChequeCompensado;
      46: Result := toRetornoRecebimentoInstrucaoSustarProtesto;
      47: Result := toRetornoProtestoImediatoFalencia;
      48: Result := toRemessaTransferenciaCarteira;
      49: Result := toRetornoTipoCobrancaAlterado;
      50: Result := toRetornoChequePendenteCompensacao;
      51: Result := toRetornoTituloDDAReconhecidoPagador;
      52: Result := toRetornoTituloDDANaoReconhecidoPagador;
      53: Result := toRetornoTituloDDARecusadoCIP;
      54: Result := toRetornoBaixaTituloNegativadoSemProtesto;
    end;
  end
  else
  begin
    case CodOcorrencia of
      10: Result := toRetornoBaixadoInstAgencia;
      15: Result := toRetornoLiquidadoEmCartorio;
      16: Result := toRetornoTituloPagoEmCheque;
      18: Result := toRetornoAcertoDepositaria;
      21: Result := toRetornoAcertoControleParticipante;
      22: Result := toRetornoTituloPagamentoCancelado;
      24: Result := toRetornoEntradaRejeitaCEPIrregular;
      25: Result := toRetornoProtestoImediatoFalencia;
      27: Result := toRetornoBaixaRejeitada;
      32: Result := toRetornoComandoRecusado;
      33: Result := toRetornoRecebimentoInstrucaoAlterarDados;
      34: Result := toRetornoRetiradoDeCartorio;
      40: Result := toRetornoEstornoPagamento;
      55: Result := toRetornoTituloSustadoJudicialmente;
      68: Result := toRetornoAcertoDadosRateioCredito;
      69: Result := toRetornoCancelamentoDadosRateio;
      74: Result := toRetornoConfirmacaoPedidoExclNegativacao;
    end;
  end;

  if (Result <> toTipoOcorrenciaNenhum) then
    Exit;

  case CodOcorrencia of
    02: Result := toRetornoRegistroConfirmado;
    03: Result := toRetornoRegistroRecusado;
    06: Result := toRetornoLiquidado;
    09: Result := toRetornoBaixadoViaArquivo;
    11: Result := toRetornoTituloEmSer;
    12: Result := toRetornoAbatimentoConcedido;
    13: Result := toRetornoAbatimentoCancelado;
    14: Result := toRetornoVencimentoAlterado;
    17: Result := toRetornoLiquidadoAposBaixaouNaoRegistro;
    19: Result := toRetornoRecebimentoInstrucaoProtestar;
    20: Result := toRetornoRecebimentoInstrucaoSustarProtesto;
    23: Result := toRetornoEncaminhadoACartorio;
    28: Result := toRetornoDebitoTarifas;
    29: Result := toRetornoOcorrenciasdoSacado;
    30: Result := toRetornoAlteracaoOutrosDadosRejeitada;
    35: Result := toRetornoDesagendamentoDebitoAutomatico;
    73: Result := toRetornoConfirmacaoRecebPedidoNegativacao;
  else
    Result := toRetornoOutrasOcorrencias;
  end;
end;

function TACBrBancoBradescoMoneyPlus.TipoOcorrenciaToCod(
  const TipoOcorrencia: TACBrTipoOcorrencia): String;
begin
  Result := '';

  if (ACBrBanco.ACBrBoleto.LayoutRemessa = c240) then
  begin
    case TipoOcorrencia of
      toRetornoTransferenciaCarteiraEntrada                 : Result := '04';
      toRetornoTransferenciaCarteiraBaixa                   : Result := '05';
      toRetornoRecebimentoInstrucaoConcederDesconto         : Result := '07';
      toRetornoRecebimentoInstrucaoCancelarDesconto         : Result := '08';
      toRetornoBaixadoFrancoPagamento                       : Result := '15';
      toRetornoRetiradoDeCartorio                           : Result := '24';
      toRetornoBaixaPorProtesto                             : Result := '25';
      toRetornoComandoRecusado                              : Result := '26';
      toRetornoRecebimentoInstrucaoAlterarDados             : Result := '27';
      toRetornoAcertoDadosRateioCredito                     : Result := '33';
      toRetornoCancelamentoDadosRateio                      : Result := '34';
      toRetornoConfirmacaoEmailSMS                          : Result := '36';
      toRetornoEmailSMSRejeitado                            : Result := '37';
      toRetornoAlterarPrazoLimiteRecebimento                : Result := '38';
      toRetornoDispensarPrazoLimiteRecebimento              : Result := '39';
      toRetornoAlteracaoSeuNumero                           : Result := '40';
      toRetornoAcertoControleParticipante                   : Result := '41';
      toRetornoRecebimentoInstrucaoAlterarNomeSacado        : Result := '42';
      toRetornoAlterarSacadorAvalista                       : Result := '43';
      toRetornoChequeDevolvido                              : Result := '44';
      toRetornoChequeCompensado                             : Result := '45';
      toRetornoRecebimentoInstrucaoSustarProtesto           : Result := '46';
      toRetornoProtestoImediatoFalencia                     : Result := '47';
      toRemessaTransferenciaCarteira                        : Result := '48';
      toRetornoTipoCobrancaAlterado                         : Result := '49';
      toRetornoChequePendenteCompensacao                    : Result := '50';
      toRetornoTituloDDAReconhecidoPagador                  : Result := '51';
      toRetornoTituloDDANaoReconhecidoPagador               : Result := '52';
      toRetornoTituloDDARecusadoCIP                         : Result := '53';
      toRetornoBaixaTituloNegativadoSemProtesto             : Result := '54';
    end;
  end
  else
  begin
    case TipoOcorrencia of
      toRetornoBaixadoInstAgencia                           : Result := '10';
      toRetornoLiquidadoEmCartorio                          : Result := '15';
      toRetornoTituloPagoEmCheque                           : Result := '16';
      toRetornoAcertoDepositaria                            : Result := '18';
      toRetornoAcertoControleParticipante                   : Result := '21';
      toRetornoTituloPagamentoCancelado                     : Result := '22';
      toRetornoEntradaRejeitaCEPIrregular                   : Result := '24';
      toRetornoProtestoImediatoFalencia                     : Result := '25';
      toRetornoBaixaRejeitada                               : Result := '27';
      toRetornoComandoRecusado                              : Result := '32';
      toRetornoRecebimentoInstrucaoAlterarDados             : Result := '33';
      toRetornoRetiradoDeCartorio                           : Result := '34';
      toRetornoEstornoPagamento                             : Result := '40';
      toRetornoTituloSustadoJudicialmente                   : Result := '55';
      toRetornoAcertoDadosRateioCredito                     : Result := '68';
      toRetornoCancelamentoDadosRateio                      : Result := '69';
      toRetornoConfirmacaoPedidoExclNegativacao             : Result := '74';
    end;
  end;

  if (Result <> '') then
    Exit;

  case TipoOcorrencia of
    toRetornoRegistroConfirmado                             : Result := '02';
    toRetornoRegistroRecusado                               : Result := '03';
    toRetornoLiquidado                                      : Result := '06';
    toRetornoBaixadoViaArquivo                              : Result := '09';
    toRetornoTituloEmSer                                    : Result := '11';
    toRetornoAbatimentoConcedido                            : Result := '12';
    toRetornoAbatimentoCancelado                            : Result := '13';
    toRetornoVencimentoAlterado                             : Result := '14';
    toRetornoLiquidadoAposBaixaouNaoRegistro                : Result := '17';
    toRetornoRecebimentoInstrucaoProtestar                  : Result := '19';
    toRetornoRecebimentoInstrucaoSustarProtesto             : Result := '20';
    toRetornoEncaminhadoACartorio                           : Result := '23';
    toRetornoDebitoTarifas                                  : Result := '28';
    toRetornoOcorrenciasdoSacado                            : Result := '29';
    toRetornoAlteracaoOutrosDadosRejeitada                  : Result := '30';
    toRetornoDesagendamentoDebitoAutomatico                 : Result := '35';
    toRetornoConfirmacaoRecebPedidoNegativacao              : Result := '73';
  else
    Result := '02';
  end;
end;

function TACBrBancoBradescoMoneyPlus.CodMotivoRejeicaoToDescricao(
  const TipoOcorrencia: TACBrTipoOcorrencia; CodMotivo: Integer): String;
begin
   case TipoOcorrencia of
      toRetornoRegistroConfirmado:
      case CodMotivo  of
         00: Result := '00-Ocorrencia aceita';
         01: Result := '01-Codigo de banco inválido';
         04: Result := '04-Cod. movimentacao nao permitido p/ a carteira';
         15: Result := '15-Caracteristicas de Cobranca Imcompativeis';
         17: Result := '17-Data de vencimento anterior a data de emissão';
         21: Result := '21-Espécie do Título inválido';
         24: Result := '24-Data da emissão inválida';
         38: Result := '38-Prazo para protesto inválido';
         39: Result := '39-Pedido para protesto não permitido para título';
         43: Result := '43-Prazo para baixa e devolução inválido';
         45: Result := '45-Nome do Sacado inválido';
         46: Result := '46-Tipo/num. de inscrição do Sacado inválidos';
         47: Result := '47-Endereço do Sacado não informado';
         48: Result := '48-CEP invalido';
         50: Result := '50-CEP referente a Banco correspondente';
         53: Result := '53-Nº de inscrição do Sacador/avalista inválidos (CPF/CNPJ)';
         54: Result := '54-Sacador/avalista não informado';
         67: Result := '67-Débito automático agendado';
         68: Result := '68-Débito não agendado - erro nos dados de remessa';
         69: Result := '69-Débito não agendado - Sacado não consta no cadastro de autorizante';
         70: Result := '70-Débito não agendado - Cedente não autorizado pelo Sacado';
         71: Result := '71-Débito não agendado - Cedente não participa da modalidade de débito automático';
         72: Result := '72-Débito não agendado - Código de moeda diferente de R$';
         73: Result := '73-Débito não agendado - Data de vencimento inválida';
         75: Result := '75-Débito não agendado - Tipo do número de inscrição do sacado debitado inválido';
         76: Result := '76-Pagador Eletrônico DDA (NOVO)- Esse motivo somente será disponibilizado no arquivo retorno para as empresas cadastradas nessa condição';
         86: Result := '86-Seu número do documento inválido';
         89: Result := '89-Email sacado nao enviado - Titulo com debito automatico';
         90: Result := '90-Email sacado nao enviado - Titulo com cobranca sem registro';
      else
         Result:= IntToStrZero(CodMotivo,2) +' - Outros Motivos';
      end;
      toRetornoRegistroRecusado:
      case CodMotivo of
         02: Result:= '02-Codigo do registro detalhe invalido';
         03: Result:= '03-Codigo da Ocorrencia Invalida';
         04: Result:= '04-Codigo da Ocorrencia nao permitida para a carteira';
         05: Result:= '05-Codigo de Ocorrencia nao numerico';
         07: Result:= 'Agencia\Conta\Digito invalido';
         08: Result:= 'Nosso numero invalido';
         09: Result:= 'Nosso numero duplicado';
         10: Result:= 'Carteira invalida';
         13: Result:= 'Idetificacao da emissao do boleto invalida';
         16: Result:= 'Data de vencimento invalida';
         18: Result:= 'Vencimento fora do prazo de operacao';
         20: Result:= 'Valor do titulo invalido';
         21: Result:= 'Especie do titulo invalida';
         22: Result:= 'Especie nao permitida para a carteira';
         24: Result:= 'Data de emissao invalida';
         28: Result:= 'Codigo de desconto invalido';
         38: Result:= 'Prazo para protesto invalido';
         44: Result:= 'Agencia cedente nao prevista';
         45: Result:= 'Nome cedente nao informado';
         46: Result:= 'Tipo/numero inscricao sacado invalido';
         47: Result:= 'Endereco sacado nao informado';
         48: Result:= 'CEP invalido';
         50: Result:= 'CEP irregular - Banco correspondente';
         63: Result:= 'Entrada para titulo ja cadastrado';
         65: Result:= 'Limite excedido';
         66: Result:= 'Numero autorizacao inexistente';
         68: Result:= 'Debito nao agendado - Erro nos dados da remessa';
         69: Result:= 'Debito nao agendado - Sacado nao consta no cadastro de autorizante';
         70: Result:= 'Debito nao agendado - Cedente nao autorizado pelo sacado';
         71: Result:= 'Debito nao agendado - Cedente nao participa de debito automatico';
         72: Result:= 'Debito nao agendado - Codigo de moeda diferente de R$';
         73: Result:= 'Debito nao agendado - Data de vencimento invalida';
         74: Result:= 'Debito nao agendado - Conforme seu pedido titulo nao registrado';
         75: Result:= 'Debito nao agendado - Tipo de numero de inscricao de debitado invalido';
      else
         Result:= IntToStrZero(CodMotivo,2) +' - Outros Motivos';
      end;
      toRetornoLiquidado:
      case CodMotivo of
         00: Result:= '00-Titulo pago com dinheiro';
         15: Result:= '15-Titulo pago com cheque';
         42: Result:= '42-Rateio nao efetuado';
      else
         Result:= IntToStrZero(CodMotivo,2) +' - Outros Motivos';
      end;
      toRetornoBaixadoViaArquivo:
      case CodMotivo of
         00: Result:= '00-Ocorrencia aceita';
         10: Result:= '10=Baixa comandada pelo cliente';
      else
         Result:= IntToStrZero(CodMotivo,2) +' - Outros Motivos';
      end;
      toRetornoBaixadoInstAgencia:
         case CodMotivo of
            00: Result:= '00-Baixado conforme instrucoes na agencia';
            14: Result:= '14-Titulo protestado';
            15: Result:= '15-Titulo excluido';
            16: Result:= '16-Titulo baixado pelo banco por decurso de prazo';
            20: Result:= '20-Titulo baixado e transferido para desconto';
         else
            Result:= IntToStrZero(CodMotivo,2) +' - Outros Motivos';
         end;
      toRetornoLiquidadoAposBaixaouNaoRegistro:
      case CodMotivo of
         00: Result:= '00-Pago com dinheiro';
         15: Result:= '15-Pago com cheque';
      else
         Result:= IntToStrZero(CodMotivo,2) +' - Outros Motivos';
      end;

      toRetornoLiquidadoEmCartorio:
      case CodMotivo of
         00: Result:= '00-Pago com dinheiro';
         15: Result:= '15-Pago com cheque';
      else
         Result:= IntToStrZero(CodMotivo,2) +' - Outros Motivos';
      end;

      toRetornoEntradaRejeitaCEPIrregular:
      case CodMotivo of
         48: Result:= '48-CEP invalido';
      else
         Result:= IntToStrZero(CodMotivo,2) +' - Outros Motivos';
      end;

      toRetornoBaixaRejeitada:
      case CodMotivo of
         04: Result:= '04-Codigo de ocorrencia nao permitido para a carteira';
         07: Result:= '07-Agencia\Conta\Digito invalidos';
         08: Result:= '08-Nosso numero invalido';
         10: Result:= '10-Carteira invalida';
         15: Result:= '15-Carteira\Agencia\Conta\NossoNumero invalidos';
         40: Result:= '40-Titulo com ordem de protesto emitido';
         42: Result:= '42-Codigo para baixa/devolucao via Telebradesco invalido';
         60: Result:= '60-Movimento para titulo nao cadastrado';
         77: Result:= '70-Transferencia para desconto nao permitido para a carteira';
         85: Result:= '85-Titulo com pagamento vinculado';
      else
         Result:= IntToStrZero(CodMotivo,2) +' - Outros Motivos';
      end;

      toRetornoDebitoTarifas:
      case CodMotivo of
         02: Result:= '02-Tarifa de permanência título cadastrado';
         03: Result:= '03-Tarifa de sustação';
         04: Result:= '04-Tarifa de protesto';
         05: Result:= '05-Tarifa de outras instrucoes';
         06: Result:= '06-Tarifa de outras ocorrências';
         08: Result:= '08-Custas de protesto';
         12: Result:= '12-Tarifa de registro';
         13: Result:= '13-Tarifa titulo pago no Bradesco';
         14: Result:= '14-Tarifa titulo pago compensacao';
         15: Result:= '15-Tarifa título baixado não pago';
         16: Result:= '16-Tarifa alteracao de vencimento';
         17: Result:= '17-Tarifa concessão abatimento';
         18: Result:= '18-Tarifa cancelamento de abatimento';
         19: Result:= '19-Tarifa concessão desconto';
         20: Result:= '20-Tarifa cancelamento desconto';
         21: Result:= '21-Tarifa título pago cics';
         22: Result:= '22-Tarifa título pago Internet';
         23: Result:= '23-Tarifa título pago term. gerencial serviços';
         24: Result:= '24-Tarifa título pago Pág-Contas';
         25: Result:= '25-Tarifa título pago Fone Fácil';
         26: Result:= '26-Tarifa título Déb. Postagem';
         27: Result:= '27-Tarifa impressão de títulos pendentes';
         28: Result:= '28-Tarifa título pago BDN';
         29: Result:= '29-Tarifa título pago Term. Multi Funcao';
         30: Result:= '30-Impressão de títulos baixados';
         31: Result:= '31-Impressão de títulos pagos';
         32: Result:= '32-Tarifa título pago Pagfor';
         33: Result:= '33-Tarifa reg/pgto – guichê caixa';
         34: Result:= '34-Tarifa título pago retaguarda';
         35: Result:= '35-Tarifa título pago Subcentro';
         36: Result:= '36-Tarifa título pago Cartao de Credito';
         37: Result:= '37-Tarifa título pago Comp Eletrônica';
         38: Result:= '38-Tarifa título Baix. Pg. Cartorio';
         39: Result:='39-Tarifa título baixado acerto BCO';
         40: Result:='40-Baixa registro em duplicidade';
         41: Result:='41-Tarifa título baixado decurso prazo';
         42: Result:='42-Tarifa título baixado Judicialmente';
         43: Result:='43-Tarifa título baixado via remessa';
         44: Result:='44-Tarifa título baixado rastreamento';
         45: Result:='45-Tarifa título baixado conf. Pedido';
         46: Result:='46-Tarifa título baixado protestado';
         47: Result:='47-Tarifa título baixado p/ devolucao';
         48: Result:='48-Tarifa título baixado franco pagto';
         49: Result:='49-Tarifa título baixado SUST/RET/CARTÓRIO';
         50: Result:='50-Tarifa título baixado SUS/SEM/REM/CARTÓRIO';
         51: Result:='51-Tarifa título transferido desconto';
         52: Result:='52-Cobrado baixa manual';
         53: Result:='53-Baixa por acerto cliente';
         54: Result:='54-Tarifa baixa por contabilidade';
         55: Result:='55-BIFAX';
         56: Result:='56-Consulta informações via internet';
         57: Result:='57-Arquivo retorno via internet';
         58: Result:='58-Tarifa emissão Papeleta';
         59: Result:='59-Tarifa fornec papeleta semi preenchida';
         60: Result:='60-Acondicionador de papeletas (RPB)S';
         61: Result:='61-Acond. De papelatas (RPB)s PERSONAL';
         62: Result:='62-Papeleta formulário branco';
         63: Result:='63-Formulário A4 serrilhado';
         64: Result:='64-Fornecimento de softwares transmiss';
         65: Result:='65-Fornecimento de softwares consulta';
         66: Result:='66-Fornecimento Micro Completo';
         67: Result:='67-Fornecimento MODEN';
         68: Result:='68-Fornecimento de máquina FAX';
         69: Result:='69-Fornecimento de maquinas oticas';
         70: Result:='70-Fornecimento de Impressoras';
         71: Result:='71-Reativação de título';
         72: Result:='72-Alteração de produto negociado';
         73: Result:='73-Tarifa emissao de contra recibo';
         74: Result:='74-Tarifa emissao 2ª via papeleta';
         75: Result:='75-Tarifa regravação arquivo retorno';
         76: Result:='76-Arq. Títulos a vencer mensal';
         77: Result:='77-Listagem auxiliar de crédito';
         78: Result:='78-Tarifa cadastro cartela instrução permanente';
         79: Result:='79-Canalização de Crédito';
         80: Result:='80-Cadastro de Mensagem Fixa';
         81: Result:='81-Tarifa reapresentação automática título';
         82: Result:='82-Tarifa registro título déb. Automático';
         83: Result:='83-Tarifa Rateio de Crédito';
         84: Result:='84-Emissão papeleta sem valor';
         85: Result:='85-Sem uso';
         86: Result:='86-Cadastro de reembolso de diferença';
         87: Result:='87-Relatório fluxo de pagto';
         88: Result:='88-Emissão Extrato mov. Carteira';
         89: Result:='89-Mensagem campo local de pagto';
         90: Result:='90-Cadastro Concessionária serv. Publ.';
         91: Result:='91-Classif. Extrato Conta Corrente';
         92: Result:='92-Contabilidade especial';
         93: Result:='93-Realimentação pagto';
         94: Result:='94-Repasse de Créditos';
         95: Result:='95-Tarifa reg. pagto Banco Postal';
         96: Result:='96-Tarifa reg. Pagto outras mídias';
         97: Result:='97-Tarifa Reg/Pagto – Net Empresa';
         98: Result:='98-Tarifa título pago vencido';
         99: Result:='99-TR Tít. Baixado por decurso prazo';
         100: Result:='100-Arquivo Retorno Antecipado';
         101: Result:='101-Arq retorno Hora/Hora';
         102: Result:='102-TR. Agendamento Déb Aut';
         103: Result:='103-TR. Tentativa cons Déb Aut';
         104: Result:='104-TR Crédito on-line';
         105: Result:='105-TR. Agendamento rat. Crédito';
         106: Result:='106-TR Emissão aviso rateio';
         107: Result:='107-Extrato de protesto';
         110: Result:='110-Tarifa reg/pagto Bradesco Expresso';
      else
         Result:= IntToStrZero(CodMotivo,2) +' - Outros Motivos';
      end;

      toRetornoOcorrenciasdoSacado:
      case CodMotivo of
         78 : Result:= '78-Sacado alega que faturamento e indevido';
         116: Result:= '116-Sacado aceita/reconhece o faturamento';
      else
         Result:= IntToStrZero(CodMotivo,2) +' - Outros Motivos';
      end;

      toRetornoALteracaoOutrosDadosRejeitada:
      case CodMotivo of
         01: Result:= '01-Código do Banco inválido';
         04: Result:= '04-Código de ocorrência não permitido para a carteira';
         05: Result:= '05-Código da ocorrência não numérico';
         08: Result:= '08-Nosso número inválido';
         15: Result:= '15-Característica da cobrança incompatível';
         16: Result:= '16-Data de vencimento inválido';
         17: Result:= '17-Data de vencimento anterior a data de emissão';
         18: Result:= '18-Vencimento fora do prazo de operação';
         24: Result:= '24-Data de emissão Inválida';
         26: Result:= '26-Código de juros de mora inválido';
         27: Result:= '27-Valor/taxa de juros de mora inválido';
         28: Result:= '28-Código de desconto inválido';
         29: Result:= '29-Valor do desconto maior/igual ao valor do Título';
         30: Result:= '30-Desconto a conceder não confere';
         31: Result:= '31-Concessão de desconto já existente ( Desconto anterior )';
         32: Result:= '32-Valor do IOF inválido';
         33: Result:= '33-Valor do abatimento inválido';
         34: Result:= '34-Valor do abatimento maior/igual ao valor do Título';
         38: Result:= '38-Prazo para protesto inválido';
         39: Result:= '39-Pedido de protesto não permitido para o Título';
         40: Result:= '40-Título com ordem de protesto emitido';
         42: Result:= '42-Código para baixa/devolução inválido';
         46: Result:= '46-Tipo/número de inscrição do sacado inválidos';
         48: Result:= '48-Cep Inválido';
         53: Result:= '53-Tipo/Número de inscrição do sacador/avalista inválidos';
         54: Result:= '54-Sacador/avalista não informado';
         57: Result:= '57-Código da multa inválido';
         58: Result:= '58-Data da multa inválida';
         60: Result:= '60-Movimento para Título não cadastrado';
         79: Result:= '79-Data de Juros de mora Inválida';
         80: Result:= '80-Data do desconto inválida';
         85: Result:= '85-Título com Pagamento Vinculado.';
         88: Result:= '88-E-mail Sacado não lido no prazo 5 dias';
         91: Result:= '91-E-mail sacado não recebido';
      else
         Result:= IntToStrZero(CodMotivo,2) +' - Outros Motivos';
      end;

      toRetornoComandoRecusado:
      case CodMotivo of
         01 : Result:= '01-Código do Banco inválido';
         02 : Result:= '02-Código do registro detalhe inválido';
         04 : Result:= '04-Código de ocorrência não permitido para a carteira';
         05 : Result:= '05-Código de ocorrência não numérico';
         07 : Result:= '07-Agência/Conta/dígito inválidos';
         08 : Result:= '08-Nosso número inválido';
         10 : Result:= '10-Carteira inválida';
         15 : Result:= '15-Características da cobrança incompatíveis';
         16 : Result:= '16-Data de vencimento inválida';
         17 : Result:= '17-Data de vencimento anterior a data de emissão';
         18 : Result:= '18-Vencimento fora do prazo de operação';
         20 : Result:= '20-Valor do título inválido';
         21 : Result:= '21-Espécie do Título inválida';
         22 : Result:= '22-Espécie não permitida para a carteira';
         24 : Result:= '24-Data de emissão inválida';
         28 : Result:= '28-Código de desconto via Telebradesco inválido';
         29 : Result:= '29-Valor do desconto maior/igual ao valor do Título';
         30 : Result:= '30-Desconto a conceder não confere';
         31 : Result:= '31-Concessão de desconto - Já existe desconto anterior';
         33 : Result:= '33-Valor do abatimento inválido';
         34 : Result:= '34-Valor do abatimento maior/igual ao valor do Título';
         36 : Result:= '36-Concessão abatimento - Já existe abatimento anterior';
         38 : Result:= '38-Prazo para protesto inválido';
         39 : Result:= '39-Pedido de protesto não permitido para o Título';
         40 : Result:= '40-Título com ordem de protesto emitido';
         41 : Result:= '41-Pedido cancelamento/sustação para Título sem instrução de protesto';
         42 : Result:= '42-Código para baixa/devolução inválido';
         45 : Result:= '45-Nome do Sacado não informado';
         46 : Result:= '46-Tipo/número de inscrição do Sacado inválidos';
         47 : Result:= '47-Endereço do Sacado não informado';
         48 : Result:= '48-CEP Inválido';
         50 : Result:= '50-CEP referente a um Banco correspondente';
         53 : Result:= '53-Tipo de inscrição do sacador avalista inválidos';
         60 : Result:= '60-Movimento para Título não cadastrado';
         85 : Result:= '85-Título com pagamento vinculado';
         86 : Result:= '86-Seu número inválido';
         94 : Result:= '94-Título Penhorado – Instrução Não Liberada pela Agência';

      else
         Result:= IntToStrZero(CodMotivo,2) +' - Outros Motivos';
      end;

      toRetornoDesagendamentoDebitoAutomatico:
      case CodMotivo of
         81 : Result:= '81-Tentativas esgotadas, baixado';
         82 : Result:= '82-Tentativas esgotadas, pendente';
         83 : Result:= '83-Cancelado pelo Sacado e Mantido Pendente, conforme negociação';
         84 : Result:= '84-Cancelado pelo sacado e baixado, conforme negociação';
      else
         Result:= IntToStrZero(CodMotivo,2) +' - Outros Motivos';
      end;
   else
      Result:= IntToStrZero(CodMotivo,2) +' - Outros Motivos';
   end;

end;

function TACBrBancoBradescoMoneyPlus.CodOcorrenciaToTipoRemessa(const CodOcorrencia:Integer): TACBrTipoOcorrencia;
begin
  case CodOcorrencia of
    02 : Result:= toRemessaBaixar;                          {Pedido de Baixa}
    03 : Result:= toRemessaProtestoFinsFalimentares;        {Pedido de Protesto Falimentar}
    04 : Result:= toRemessaConcederAbatimento;              {Concessão de Abatimento}
    05 : Result:= toRemessaCancelarAbatimento;              {Cancelamento de Abatimento concedido}
    06 : Result:= toRemessaAlterarVencimento;               {Alteração de vencimento}
    07 : Result:= toRemessaAlterarControleParticipante;     {Alteração do controle do participante}
    08 : Result:= toRemessaAlterarNumeroControle;           {Alteração de seu número}
    09 : Result:= toRemessaProtestar;                       {Pedido de protesto}
    18 : Result:= toRemessaCancelarInstrucaoProtestoBaixa;  {Sustar protesto e baixar}
    19 : Result:= toRemessaCancelarInstrucaoProtesto;       {Sustar protesto e manter na carteira}
    22 : Result:= toRemessaTransfCessaoCreditoIDProd10;     {Transferência Cessão crédito ID. Prod.10}
    23 : Result:= toRemessaTransferenciaCarteira;           {Transferência entre Carteiras}
    24 : Result:= toRemessaDevTransferenciaCarteira;        {Dev. Transferência entre Carteiras}
    31 : Result:= toRemessaOutrasOcorrencias;               {Alteração de Outros Dados}
    68 : Result:= toRemessaAcertarRateioCredito;            {Acerto nos dados do rateio de Crédito}
    69 : Result:= toRemessaCancelarRateioCredito;           {Cancelamento do rateio de crédito.}
  else
     Result:= toRemessaRegistrar;                           {Remessa}
  end;

end;

function TACBrBancoBradescoMoneyPlus.TipoOcorrenciaToCodRemessa(
  const TipoOcorrencia: TACBrTipoOcorrencia): String;
begin
  if (ACBrBanco.ACBrBoleto.LayoutRemessa = c240) then
  begin
    case TipoOcorrencia of
        toRemessaBaixar                           : Result := '02';
        toRemessaConcederAbatimento               : Result := '04';
        toRemessaCancelarAbatimento               : Result := '05';
        toRemessaAlterarVencimento                : Result := '06';
        toRemessaConcederDesconto                 : Result := '07';
        toRemessaCancelarDesconto                 : Result := '08';
        toRemessaProtestar                        : Result := '09';
        toRemessaCancelarInstrucaoProtestoBaixa   : Result := '10';
        toRemessaCancelarInstrucaoProtesto        : Result := '11';
        toRemessaDispensarJuros                   : Result := '13';
        toRemessaAlterarNomeEnderecoSacado        : Result := '31';
        toRemessaDispensarMulta                   : Result := '15';
        toRemessaNegativacaoSemProtesto           : Result := '45';
        toRemessaBaixaTituloNegativadoSemProtesto : Result := '46';
      else
        Result := '01';
    end;

  end
  else
  begin
    case TipoOcorrencia of
        toRemessaBaixar                         : Result := '02'; {Pedido de Baixa}
        toRemessaProtestoFinsFalimentares       : Result := '03'; {Pedido de Protesto Falimentar}
        toRemessaConcederAbatimento             : Result := '04'; {Concessão de Abatimento}
        toRemessaCancelarAbatimento             : Result := '05'; {Cancelamento de Abatimento concedido}
        toRemessaAlterarVencimento              : Result := '06'; {Alteração de vencimento}
        toRemessaAlterarControleParticipante    : Result := '07'; {Alteração do controle do participante}
        toRemessaAlterarNumeroControle          : Result := '08'; {Alteração de seu número}
        toRemessaProtestar                      : Result := '09'; {Pedido de protesto}
        toRemessaCancelarInstrucaoProtestoBaixa : Result := '18'; {Sustar protesto e baixar}
        toRemessaCancelarInstrucaoProtesto      : Result := '19'; {Sustar protesto e manter na carteira}
        toRemessaAlterarValorTitulo             : Result := '20'; {Alteração de valor}
        toRemessaTransferenciaCarteira          : Result := '23'; {Transferência entre carteiras}
        toRemessaDevTransferenciaCarteira       : Result := '24'; {Dev. Transferência entre carteiras}
        toRemessaOutrasOcorrencias              : Result := '31'; {Alteração de Outros Dados}
      else
        Result := '01';                                           {Remessa}
    end;

  end;

end;


end.


