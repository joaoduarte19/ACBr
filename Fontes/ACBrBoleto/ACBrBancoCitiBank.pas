{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2020 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Luiz Carlos Rodrigues                           }
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

unit ACBrBancoCitiBank;

interface

uses
  Classes,
  SysUtils,
  Contnrs,
  ACBrBoleto,
  ACBrBoletoConversao;

type

  { TACBrBancoCitiBank }
  TACBrBancoCitiBank = class(TACBrBancoClass)
  private
    fValorTotalDocs: Double;
    function ConverterMultaPercentual(const ACBrTitulo: TACBrTitulo): Double;
    function ConverterJurosValorDiario(const ACBrTitulo: TACBrTitulo): Double;
  protected
    procedure EhObrigatorioContaDV; override;
    procedure EhObrigatorioAgenciaDV; override;
    function MontaInstrucoesCNAB400(const ACBrTitulo :TACBrTitulo; const nRegistro: Integer ): String; override;
    function GerarLinhaRegistroTransacao400(ACBrTitulo : TACBrTitulo; aRemessa: TStringList): String;
    procedure LerRetorno400(ARetorno:TStringList); override;
  public
    constructor Create(AOwner: TACBrBanco);
    function CalcularDigitoVerificador(const ACBrTitulo: TACBrTitulo): String; override;
    function MontarCodigoBarras(const ACBrTitulo: TACBrTitulo): String; override;
    function MontarCampoCodigoCedente(const ACBrTitulo: TACBrTitulo): String; override;
    function MontarCampoNossoNumero( const ACBrTitulo: TACBrTitulo): String; override;
    function GerarRegistroHeader240(NumeroRemessa: Integer): String; override;
    function GerarRegistroTransacao240(ACBrTitulo: TACBrTitulo): String; override;
    function GerarRegistroTrailler240(ARemessa: TStringList): String; override;
    Procedure LerRetorno400Transacao4(ACBrTitulo :TACBrTitulo; ALinha:String); override;
    procedure GerarRegistroTransacao400(ACBrTitulo : TACBrTitulo; aRemessa: TStringList); override;
    procedure GerarRegistroHeader400(NumeroRemessa : Integer; aRemessa: TStringList); override;

    // Codigos extraidos do "CITIBANK Manual CNAB-400 Standard v2.8",
    // pos 109/110 do registro detalhe (Codigo de Ocorrencia).
    function CodOcorrenciaToTipo(const ACodOcorrencia: Integer): TACBrTipoOcorrencia; override;
    function TipoOcorrenciaToCod(const ATipoOcorrencia: TACBrTipoOcorrencia): String; override;
    function TipoOcorrenciaToDescricao(const ATipoOcorrencia: TACBrTipoOcorrencia): String; override;
  end;

implementation

uses
  StrUtils,
  Variants,
  {$IFDEF COMPILER6_UP} DateUtils
  {$ELSE} ACBrD5, FileCtrl {$ENDIF},
  ACBrUtil.Base,
  ACBrUtil.Strings,
  ACBrUtil.DateTime;

constructor TACBrBancoCitiBank.Create(AOwner: TACBrBanco);
begin
  inherited Create(AOwner);
  fpDigito := 5;
  fpNome   := 'CITIBANK';
  fpNumero := 745;
  fpTamanhoMaximoNossoNum := 11;
  fpTamanhoAgencia := 5;
  fpTamanhoConta   := 12;
  fpTamanhoCarteira:= 3;
  fValorTotalDocs  := 0;
end;

procedure TACBrBancoCitiBank.EhObrigatorioAgenciaDV;
begin
  //sem validação
end;

procedure TACBrBancoCitiBank.EhObrigatorioContaDV;
begin
  //sem validação
end;

function TACBrBancoCitiBank.CalcularDigitoVerificador(const ACBrTitulo: TACBrTitulo): String;
begin
  Modulo.CalculoPadrao;
  Modulo.MultiplicadorFinal := 9;
  Modulo.Documento := ACBrTitulo.NossoNumero;
  Modulo.Calcular;

  Result:= IntToStr(Modulo.DigitoFinal);
end;

function TACBrBancoCitiBank.MontarCodigoBarras(const ACBrTitulo: TACBrTitulo): String;
var CodigoBarras, DigitoCodBarras, FatorVencimento, DVNossoNumero, CampoLivre: String;
begin
  FatorVencimento := CalcularFatorVencimento(ACBrTitulo.Vencimento);
  DVNossoNumero   := CalcularDigitoVerificador(ACBrTitulo);

  {Montando Campo Livre}
  CampoLivre := OnlyNumber(ACBrTitulo.ACBrBoleto.Cedente.Conta+ACBrTitulo.ACBrBoleto.Cedente.ContaDigito);
  CampoLivre := '3'+                                                            // Cobrança com registro / sem registro.
                PadLeft(ACBrTitulo.Carteira, 3,'0')+                             // Carteira/Portfólio
                Copy(CampoLivre,2,9)+                                           // Base+Sequência+Dígito da Conta Cosmos
                Copy(ACBrTitulo.NossoNumero+DVNossoNumero,1,12);


  {Codigo de Barras}
  with ACBrTitulo.ACBrBoleto do
  begin
    CodigoBarras := IntToStrZero(Banco.Numero, 3) +
                    '9' +
                    FatorVencimento +
                    IntToStrZero(Round(ACBrTitulo.ValorDocumento * 100), 10) +
                    CampoLivre;
  end;

  DigitoCodBarras := CalcularDigitoCodigoBarras(CodigoBarras);
  Result := Copy(CodigoBarras, 1, 4) + DigitoCodBarras + Copy(CodigoBarras, 5, 44);
end;

function TACBrBancoCitiBank.MontarCampoCodigoCedente (
   const ACBrTitulo: TACBrTitulo ) : String;
begin
  Result := RightStr(ACBrTitulo.ACBrBoleto.Cedente.Agencia,5)+
            IfThen(Trim(ACBrTitulo.ACBrBoleto.Cedente.AgenciaDigito) <> '','-','')+
            ACBrTitulo.ACBrBoleto.Cedente.AgenciaDigito+'/'+
            ACBrTitulo.ACBrBoleto.Cedente.Conta+
            IfThen(Trim(ACBrTitulo.ACBrBoleto.Cedente.ContaDigito) <> '','-','')+
            ACBrTitulo.ACBrBoleto.Cedente.ContaDigito;
end;

function TACBrBancoCitiBank.MontarCampoNossoNumero(const ACBrTitulo: TACBrTitulo): String;
begin
  Result := ACBrTitulo.NossoNumero + '-' + CalcularDigitoVerificador(ACBrTitulo);
end;

function TACBrBancoCitiBank.GerarRegistroHeader240(NumeroRemessa: Integer): String;
var
  ATipoInscricao: string;
begin
  with ACBrBanco.ACBrBoleto.Cedente do
  begin
    case TipoInscricao of
      pFisica  : ATipoInscricao := '1';
      pJuridica: ATipoInscricao := '2';
    end;

    { GERAR REGISTRO-HEADER DO ARQUIVO }

    Result:= IntToStrZero(ACBrBanco.Numero, 3)       + //1 a 3 - Código do banco
             '0000'                                  + //4 a 7 - Lote de serviço
             '0'                                     + //8 - Tipo de registro - Registro header de arquivo
             Space(9)                                + //9 a 17 Uso exclusivo FEBRABAN/CNAB
             ATipoInscricao                          + //18 - Tipo de inscrição do cedente
             PadLeft(OnlyCPFCNPJAlphaNum(CNPJCPF), 14, '0')   + //19 a 32 -Número de inscrição do cedente
             PadRight(CodigoCedente, 20, ' ')        + //33 a 52 - Código do convênio no banco
             PadLeft('', 5, '0')                     + //53 a 57 - Código da agência mantenedora da conta (Zeros)
             ' '                                     + //58 - Dígito da agência (Branco)
             PadLeft(OnlyNumber(Conta), 12, '0')     + //59 a 70 - Número da conta cosmos
             ' '                                     + //071 a 071 - DV Conta
             ' '                                     + //72 a 72 - Dígito verificador da ag
             PadRight(Nome, 30)                      + //73  a 102 - Nome da empresa
             PadRight('CITIBANK', 30, ' ')           + //103 a 132 - Nome do banco
             Space(10)                               + //133 a 142 - Uso exclusivo FEBRABAN/CNAB
             '1'                                     + //143 - Código de Remessa (1) / Retorno (2)
             FormatDateTime('ddmmyyyy', Now)         + //144 a 151 - Data do de geração do arquivo
             FormatDateTime('hhmmss', Now)           + //152 a 157 - Hora de geração do arquivo
             PadLeft(IntToStr(NumeroRemessa), 6, '0')+ //158 a 163 - Número seqüencial do arquivo
             '040'                                   + //164 a 166 - Número da versão do layout do arquivo
             '01600'                                 + //167 a 171 - Densidade de gravação do arquivo = "01600"
             Space(20)                               + //172 a 191 - Para uso reservado do banco
             Space(20)                               + //192 a 211 - Para uso reservado da empresa
             Space(29);                                // 212 a 240 - Uso exclusivo FEBRABAN/CNAB

    { GERAR REGISTRO HEADER DO LOTE }

    Result:= Result + #13#10 +
             IntToStrZero(ACBrBanco.Numero, 3)       + //1 a 3 - Código do banco
             '0001'                                  + //4 a 7 - Lote de serviço
             '1'                                     + //8 - Tipo de registro = "1" HEADER LOTE
             'R'                                     + //9 - Tipo de operação: R (Remessa) ou T (Retorno)
             '01'                                    + //10 a 11 - Tipo de serviço: 01 (Cobrança)
             Space(2)                                + //012 a 013 - Uso exclusivo FEBRABAN/CNAB
             '041'                                   + //14 a 16 - Número da versão do layout do lote    
             ' '                                     + //17 - Uso exclusivo FEBRABAN/CNAB
             ATipoInscricao                          + //18 - Tipo de inscrição do cedente
             PadLeft(OnlyCPFCNPJAlphaNum(CNPJCPF), 15, '0')   + //19 a 33 -Número de inscrição do cedente
             PadRight(CodigoCedente, 20, ' ')        + //34 a 53 - Código do convênio no banco
             PadLeft('', 5, '0')                     + //54 a 58 - Código da agência mantenedora da conta (Zeros)
             ' '                                     + //59 - Dígito da agência (Branco)
             PadLeft(OnlyNumber(Conta), 12, '0')     + //60 a 71 - Número da conta cosmos
             ' '                                     + //72 a 72 - DV Conta
             ' '                                     + //73 a 73 - Dígito verificador da ag
             PadRight(Nome, 30, ' ')                 + //74  a 103 - Nome do cedente
             Space(40)                               + //104 a 143 - Mensagem 1
             Space(40)                               + //144 a 183 - Mensagem 2
             '00000000'                              + //184 a 191 - Número remessa/retorno
             FormatDateTime('ddmmyyyy', Now)         + //192 a 199 - Data de gravação rem./ret.
             PadRight('', 8, '0')                    + //200 a 207 - Data do crédito - Só para arquivo retorno
             PadRight('', 33, ' ');                    //208 a 240 - Uso exclusivo FEBRABAN/CNAB
  end;
end;

function TACBrBancoCitiBank.GerarRegistroTransacao240(ACBrTitulo : TACBrTitulo): String;
var
  ATipoOcorrencia, ATipoBoleto, CodProtesto, DiasProtesto: String;
  DigitoNossoNumero, ATipoAceite, AEspecieDoc, TipoSacado, EndSacado: String;
  TipoAvalista: Char;
begin
  with ACBrTitulo do
  begin
    {Nosso Número}
    DigitoNossoNumero := CalcularDigitoVerificador(ACBrTitulo);

    {Aceite}
    case Aceite of
      atSim: ATipoAceite := 'A';
      atNao: ATipoAceite := 'N';
    end;

    {Espécie}
    if AnsiSameText(EspecieDoc, 'DM') then
      AEspecieDoc := '03'
    else if AnsiSameText(EspecieDoc, 'DMI') then
      AEspecieDoc := '03'
    else
      AEspecieDoc := '99';

    {Pegando o Tipo de Ocorrencia}
    case OcorrenciaOriginal.Tipo of
      toRemessaBaixar             : ATipoOcorrencia := '02';
      toRemessaConcederAbatimento : ATipoOcorrencia := '04';
      toRemessaAlterarVencimento  : ATipoOcorrencia := '06';
      toRemessaConcederDesconto   : ATipoOcorrencia := '07';
      toRemessaProtestar          : ATipoOcorrencia := '09';
      toRemessaSustarProtesto     : ATipoOcorrencia := '11';
    else
      ATipoOcorrencia := '01';
    end;

    {Protesto}
    CodProtesto := '3';
    DiasProtesto := '00';
    if (DataProtesto > 0) and (DataProtesto > Vencimento) then
    begin
      CodProtesto := '1';
      DiasProtesto := PadLeft(IntToStr(DaysBetween(DataProtesto, Vencimento)), 2, '0');
    end;

    {Pegando Tipo de Boleto} //Quem emite e quem distribui o boleto?
    case ACBrBoleto.Cedente.ResponEmissao of
       tbBancoEmite : ATipoBoleto := '1';
       tbCliEmite   : ATipoBoleto := '2';
    end;

    {Sacado}
    case Sacado.Pessoa of
      pFisica:   TipoSacado := '1';
      pJuridica: TipoSacado := '2';
    else
      TipoSacado := '9';
    end;

    EndSacado := Sacado.Logradouro;
    if (Sacado.Numero <> '') then
      EndSacado := EndSacado + ', ' + Sacado.Numero;
    EndSacado := PadRight(trim(EndSacado), 40);

    {Avalista}
    if PadRight(Sacado.SacadoAvalista.CNPJCPF, 15, '0') = PadRight('0', 15, '0') then
      TipoAvalista := '0'
    else
      case Sacado.SacadoAvalista.Pessoa of
        pFisica:   TipoAvalista := '1';
        pJuridica: TipoAvalista := '2';
      else
        TipoAvalista := '9';
      end;

    {SEGMENTO P}
    fValorTotalDocs:= fValorTotalDocs  + ValorDocumento;
    Result:= IntToStrZero(ACBrBanco.Numero, 3)                          + //1 a 3 - Código do banco
             '0001'                                                     + //4 a 7 - Lote de serviço
             '3'                                                        + //8 - Tipo do registro: Registro detalhe
             IntToStrZero((2 * ACBrBoleto.ListadeBoletos.IndexOf(ACBrTitulo))+1,5) + //9 a 13 - Número seqüencial do registro no lote - Cada título tem 2 registros (P e Q)
             'P'                                                        + //14 - Código do segmento do registro detalhe
             ' '                                                        + //15 - Uso exclusivo FEBRABAN/CNAB: Branco
             ATipoOcorrencia                                            + //16 a 17 - Código de movimento
             PadLeft('', 5, '0')                                        + //18 a 22 - Agência mantenedora da conta (Zeros)
             ' '                                                        + //23 -Dígito verificador da agência
             PadLeft(OnlyNumber(ACBrBoleto.Cedente.Conta), 12, '0')     + //24 a 35 - Número da conta cosmos
             ' '                                                        + //36 a 36 - Dígito verificador da conta
             ' '                                                        + //37 a 37 - Dígito verificador da ag/conta
             PadRight(NossoNumero + DigitoNossoNumero, 12, ' ')         + //38 a 49 - Identificação do título no banco
             Space(8)                                                   + //50 a 57 - Brancos
             Copy(ACBrBoleto.Cedente.Modalidade+' ',1,1)                + //58 - Código da Carteira (característica dos títulos dentro das modalidades de cobrança: '1' = Cobrança Simples '3' = Cobrança Caucionada)
             '1'                                                        + //59 - Forma de cadastramento do título no banco (1=Cobrança Registrada, 2=Cobrança sem Registro)
             ' '                                                        + //60 - Tipo de documento: Brancos
             ATipoBoleto                                                + //61 - Quem emite
             ATipoBoleto                                                + //62 - Quem distribui
             PadRight(NumeroDocumento, 10)                              + //63 a 72 - Nº do documento de cobrança
             Space(5)                                                   + //73 a 77 - Brancos
             FormatDateTime('ddmmyyyy', Vencimento)                     + //78 a 85 - Data de vencimento do título
             IntToStrZero( Round( ValorDocumento * 100), 15)            + //86 a 100 - Valor nominal do título
             '00000'                                                    + //101 a 105 - Agência cobradora. Se ficar em branco, o CITIBANK determina automaticamente pelo CEP do sacado
             ' '                                                        + //106 - Dígito da agência cobradora
             PadRight(AEspecieDoc, 2)                                   + //107 a 108 - Espécie do documento
             ATipoAceite                                                + //109 - Identificação de título Aceito / Não aceito
             FormatDateTime('ddmmyyyy', DataDocumento)                  + //110 a 117 - Data da emissão do documento
             '1'                                                        + //118 - Código do juro de mora
             '00000000'                                                 + //119 a 126 - Data do juro de mora
             IntToStrZero(Round(ValorMoraJuros * 100), 15)              + //127 a 141 - Juros de mora por dia/taxa
             '1'                                                        + //142 a 142 - Código do desconto 1
             IfThen(ValorDesconto = 0, '00000000', FormatDateTime('ddmmyyyy', Vencimento)) + // 143 a 150 - Data do desconto 1
             IntToStrZero(Round(ValorDesconto * 100), 15)               + //151 a 165 - Valor percentual a ser concedido
             IntToStrZero(Round(ValorIOF * 100), 15)                    + //166 a 180 - Valor do IOF a ser recolhido
             IntToStrZero(Round(ValorAbatimento * 100), 15)             + //181 a 195 - Valor do abatimento
             PadRight(NumeroDocumento, 25)                              + //196 a 220 - Identificação do título na empresa
             CodProtesto                                                + //221 a 221 - Código para protesto
             DiasProtesto                                               + //222 a 223 - Número de dias para protesto
             IfThen((DataBaixa <> 0) and (DataBaixa > Vencimento), '1', '2') + //224 - Código para baixa/devolução: Não baixar/não devolver
             '   '                                                      + //225 a 227 - Brancos
             '09'                                                       + //228 a 229 - Código da moeda: Real
             PadRight('', 10 , '0')                                     + //230 a 239 - Uso Exclusivo CITIBANK
             ' ';                                                         //240 - Uso exclusivo FEBRABAN/CNAB

    {SEGMENTO Q}
    Result:= Result + #13#10 +
             IntToStrZero(ACBrBanco.Numero, 3)                          + //1 a 3 - Código do banco
             '0001'                                                     + //4 a 7 - Número do lote
             '3'                                                        + //8 - Tipo do registro: Registro detalhe
             IntToStrZero((2 * ACBrBoleto.ListadeBoletos.IndexOf(ACBrTitulo))+ 2 ,5) + //9 a 13 - Número seqüencial do registro no lote - Cada título tem 2 registros (P e Q)
             'Q'                                                        + //14 - Código do segmento do registro detalhe
             ' '                                                        + //15 - Uso exclusivo FEBRABAN/CNAB: Branco
             ATipoOcorrencia                                            + //16 a 17 - Código de movimento
             TipoSacado                                                 + //018 - Tipo de inscrição
             PadLeft(OnlyCPFCNPJAlphaNum(Sacado.CNPJCPF), 15, '0')               + //19 a 33 - Número de Inscrição
             PadRight(Sacado.NomeSacado, 40, ' ')                       + //34 a 73 - Nome sacado
             EndSacado                                                  + //74 a 113 - Endereço
             PadRight(Sacado.Bairro, 15, ' ')                           + //114 a 128 - bairro sacado
             Copy(PadLeft(OnlyNumber(Sacado.CEP),8,'0'),1,5)            + //129 a 133 - CEP
             Copy(PadLeft(OnlyNumber(Sacado.CEP),8,'0'),6,3)            + //134 a 136 - Sufixo do CEP
             PadRight(Sacado.Cidade, 15, ' ')                           + //137 a 151 - cidade sacado
             PadRight(Sacado.UF, 2, ' ')                                + //152 a 153 - UF sacado
             TipoAvalista                                               + //154 a 154 - Tipo de inscrição sacador/avalista
             PadRight(Sacado.SacadoAvalista.CNPJCPF, 15, '0')           + //155 a 169 - Número de inscrição
             PadRight(Sacado.SacadoAvalista.NomeAvalista,40,' ')        + //170 a 209 - Nome do sacador/avalista
             PadRight('', 3, '0')                                       + //210 a 212 - Portfolio de Cobrança Simples
             PadRight('', 3, '0')                                       + //213 a 215 - Número do carnê
             PadRight('', 3, '0')                                       + //216 a 218 - Número da parcela
             Space(14)                                                  + //219 a 232 - Brancos
             Space(8);                                                    //233 a 240 - Uso exclusivo FEBRABAN/CNAB
  end;
end;

function TACBrBancoCitiBank.GerarRegistroTrailler240( ARemessa : TStringList ): String;
var
  wQTDTitulos: Integer;
begin
  wQTDTitulos := ARemessa.Count - 1;
  {REGISTRO TRAILER DO LOTE}
  Result:= IntToStrZero(ACBrBanco.Numero, 3)                          + //Código do banco
           '0001'                                                     + //Lote de Serviço
           '5'                                                        + //Tipo do registro: Registro trailer do lote
           Space(9)                                                   + //Uso exclusivo FEBRABAN/CNAB
           IntToStrZero((2 * wQTDTitulos + 2 ), 6)                    + //Quantidade de Registro no Lote (Registros P,Q header e trailer do lote)
           IntToStrZero((wQTDTitulos), 6)                             + //Quantidade títulos em cobrança
           IntToStrZero(Round(fValorTotalDocs * 100), 17)             + //Valor dos títulos em carteiras}
           PadRight('', 6, '0')                                       + //Quantidade títulos em cobrança
           PadRight('',17, '0')                                       + //Valor dos títulos em carteiras}
           PadRight('',6,  '0')                                       + //Quantidade títulos em cobrança
           PadRight('',17, '0')                                       + //Quantidade de Títulos em Carteiras
           PadRight('',6,  '0')                                       + //Quantidade títulos em cobrança
           PadRight('',17, '0')                                       + //Quantidade de Títulos em Carteiras
           Space(8)                                                   + //Número do aviso de lançamento
           Space(117);                                                  //Uso exclusivo FEBRABAN/CNAB

  {GERAR REGISTRO TRAILER DO ARQUIVO}
  Result:= Result + #13#10 +
           IntToStrZero(ACBrBanco.Numero, 3)                          + //Código do banco
           '9999'                                                     + //Lote de serviço
           '9'                                                        + //Tipo do registro: Registro trailer do arquivo
           PadRight('',9,' ')                                         + //Uso exclusivo FEBRABAN/CNAB}
           '000001'                                                   + //Quantidade de lotes do arquivo (Registros P,Q header e trailer do lote e do arquivo)
           IntToStrZero((2 * wQTDTitulos)+4, 6)                       + //Quantidade de registros do arquivo, inclusive este registro que está sendo criado agora}
           PadRight('',6,'0')                                         + //Uso exclusivo FEBRABAN/CNAB}
           PadRight('',205,' ');                                        //Uso exclusivo FEBRABAN/CNAB}
end;

procedure TACBrBancoCitiBank.GerarRegistroHeader400(NumeroRemessa : Integer; aRemessa: TStringList);
var
  wLinha: String;
begin
   with ACBrBanco.ACBrBoleto.Cedente do
   begin
      wLinha:= '0'                                        + // ID do Registro
               '1'                                        + // ID do Arquivo( 1 - Remessa)
               'REMESSA'                                  + // Literal de Remessa
               '01'                                       + // Código do Tipo de serviço
               PadRight( 'COBRANCA', 15 )                 + // Descrição do tipo de serviço
               PadLeft( Convenio, 20, '0')                + // Codigo da Empresa no Banco
               PadRight( Nome, 30)                        + // Nome da Empresa
               IntToStrZero(fpNumero, 3)                  + // Codigo
               PadRight('CITIBANK', 15)                  + // Nome do Banco(745 - CitiBank)
               FormatDateTime('ddmmyy',Now)               + // Data de geração do arquivo + brancos
               '01600'                                    + //101-105 = Densidade de gravação
               'BPI'                                      + //106-104 = Unidade de densidade de gravação
               Space(286)                                   +  { brancos }
               IntToStrZero(1,6);                           // Nr. Sequencial de Remessa + brancos + Contador

      ARemessa.Add(UpperCase(wLinha));
   end;
end;

function TACBrBancoCitiBank.MontaInstrucoesCNAB400( const ACBrTitulo: TACBrTitulo; const nRegistro: Integer): String;
var 
  LNossoNumero,LDigitoNossoNumero : String;
begin
  Result := '';

  ValidaNossoNumeroResponsavel(LNossoNumero, LDigitoNossoNumero, ACBrTitulo);

  With ACBrTitulo, ACBrBoleto do begin
    Mensagem.Text := TiraAcentos(AnsiUpperCase(Mensagem.Text));
    {Primeira instrução vai no registro 1}
    if Mensagem.Count <= 1 then begin
       Result := '';
       Exit;
    end;

    Result := '2'               +                                                                          // 001-001 Identificação DO LAYOUT PARA O REGISTRO
              Copy(PadRight(Mensagem[1], 80, ' '), 1, 80);                                                 // 002-081 CONTEÚDO DA 1ª LINHA DE IMPRESSÃO DA ÁREA "INSTRUÇÕES" DO BOLETO

    if Mensagem.Count >= 3 then
      Result := Result +
                Copy(PadRight(Mensagem[2], 80, ' '), 1, 80)                                                // 082-161 CONTEÚDO DA 2ª LINHA DE IMPRESSÃO DA ÁREA "INSTRUÇÕES" DO BOLETO
    else
      Result := Result + PadRight('', 80, ' ');                                                            // 082-161 CONTEÚDO DO RESTANTE DAS LINHAS

    if Mensagem.Count >= 4 then
      Result := Result +
                Copy(PadRight(Mensagem[3], 80, ' '), 1, 80)                                                // 162-241 CONTEÚDO DA 3ª LINHA DE IMPRESSÃO DA ÁREA "INSTRUÇÕES" DO BOLETO
    else
      Result := Result + PadRight('', 80, ' ');                                                            // 162-241 CONTEÚDO DO RESTANTE DAS LINHAS

    if Mensagem.Count >= 5 then
      Result := Result +
                Copy(PadRight(Mensagem[4], 80, ' '), 1, 80)                                                // 242-321 CONTEÚDO DA 4ª LINHA DE IMPRESSÃO DA ÁREA "INSTRUÇÕES" DO BOLETO
    else
      Result := Result + PadRight('', 80, ' ');                                                            // 242-321 CONTEÚDO DO RESTANTE DAS LINHAS


    Result := Result
              + IfThen(DataDesconto2 > 0,FormatDateTime( 'ddmmyy', DataDesconto2),PadLeft('', 6, '0'))     // 322-327 Data limite para concessão de Desconto 2
              + IntToStrZero( round( ValorDesconto2 * 100 ), 13)                                           // 328-340 Valor do Desconto 2
              + IfThen(DataDesconto3 > 0, FormatDateTime( 'ddmmyy', DataDesconto3) ,PadLeft('', 6, '0'))   // 341-346 Data limite para concessão de Desconto 3
              + IntToStrZero( round( ValorDesconto3 * 100 ), 13)                                           // 347-359 Valor do Desconto 3
              + space(7)                                                                                   // 360-366 Filler
              + IntToStrZero(StrToIntDef(trim(Carteira), 0), 3)                                            // 367-369 Num. da Carteira
              + IntToStrZero(StrToIntDef(OnlyNumber(ACBrBoleto.Cedente.Agencia), 0), 5)                    // 370-374 Código da agência Beneficiário
              + IntToStrZero(StrToIntDef(OnlyNumber(ACBrBoleto.Cedente.Conta)  , 0), 7)                    // 375-381 Num. da Conta-Corrente
              + Cedente.ContaDigito                                                                        // 382-382 DAC C/C
              + LNossoNumero                                                                               // 383-393 Nosso Número
              + LDigitoNossoNumero                                                                         // 394-394 DAC Nosso Número
              + IntToStrZero( nRegistro + 1, 6);                                                           // 395-400 Num. Sequencial do Registro
  end;
end;

function TACBrBancoCitiBank.GerarLinhaRegistroTransacao400(ACBrTitulo :TACBrTitulo; aRemessa: TStringList): String;
var
  LOcorrencia, LEspecie, LAgencia: String;
  LProtesto, LTipoSacado, LMensagemCedente, LConta, LDigitoConta: String;
  LCarteira, wLinha, LNossoNumero, LDigitoNossoNumero, LTipoBoleto: String;
  LPercMulta, LValorMoraJuros: Double;
  LChaveNFE : String;
  LEspecieDoc : String;
  LCartInt : Integer;
begin
   Result := '';
   with ACBrTitulo do
   begin
     ValidaNossoNumeroResponsavel(LNossoNumero, LDigitoNossoNumero, ACBrTitulo);

     LAgencia := IntToStrZero(StrToIntDef(OnlyNumber(ACBrBoleto.Cedente.Agencia),0),5);
     LConta   := IntToStrZero(StrToIntDef(OnlyNumber(ACBrBoleto.Cedente.Conta),0),7);
     LCarteira:= IntToStrZero(StrToIntDef(trim(Carteira),0), 3);
     LDigitoConta := PadLeft(trim(ACBrBoleto.Cedente.ContaDigito),1,'0');

     LCartInt := StrToInt(LCarteira);

     {Código da Ocorrencia}
     LOcorrencia:= TipoOcorrenciaToCodRemessa(OcorrenciaOriginal.Tipo);

     {Tipo de Boleto}
     LTipoBoleto:= DefineTipoBoleto(ACBrTitulo);

     {Especie}
     LEspecie:= DefineEspecieDoc(ACBrTitulo);

     {Intruções}
     LProtesto:= InstrucoesProtesto(ACBrTitulo);

     {Tipo de Sacado}
     LTipoSacado := DefineTipoSacado(ACBrTitulo);

     { Converte valor em moeda para percentual, pois o arquivo só permite % }
     LPercMulta := ConverterMultaPercentual(ACBrTitulo);

     { Converte valor em moeda para valor diário, pois o arquivo só permite juros em R$ diário }
     LValorMoraJuros := ConverterJurosValorDiario(ACBrTitulo);

     {Chave da NFe}
     if ACBrTitulo.ListaDadosNFe.Count>0 then
       LChaveNFe := ACBrTitulo.ListaDadosNFe[0].ChaveNFe
     else
       LChaveNFe := '';

     LMensagemCedente := '';

      {Espécie}
     if AnsiSameText(EspecieDoc, 'DM') then
       LEspecieDoc := '02'
     else if AnsiSameText(EspecieDoc, 'DMI') then
       LEspecieDoc := '00'
     else
       LEspecieDoc := '99';

     with ACBrBoleto do
     begin
       if Sacado.SacadoAvalista.CNPJCPF <> '' then
       begin
         LMensagemCedente := PadLeft(OnlyCPFCNPJAlphaNum(Sacado.SacadoAvalista.CNPJCPF), 15, '0') +  // 335 a 349 - CNPJ do beneficiário final
         '  ' +                                                                            // 350 a 351 - Brancos
         PadRight(Sacado.SacadoAvalista.NomeAvalista, 43);                                 // 352 a 394 - Nome do beneficiário final
       end
       else if Mensagem.Text <> '' then
          LMensagemCedente := Mensagem[0];

       wLinha:= '1'                                             +  // 001 a 001 - ID Registro
       '0' + DefineTipoInscricao                                +  // 002 a 003 -  Tipo de inscrição da Empresa
       PadLeft(OnlyCPFCNPJAlphaNum(Cedente.CNPJCPF), 14, '0')            + // 004 a 017 - Número de inscrição do cedente
       PadLeft( Cedente.Convenio, 20, '0')                      + // 018 a 037 - Identificação da empresa no Citibank / Codigo da Empresa no Banco
       PadLeft(SeuNumero, 25, '0')                              +  // 038 a 062 - Numero de Controle do Participante           //0001000091158850000000000
       LEspecieDoc                                              + // 063 A 064 - Identificação da espécie do título // 02 = DM
       PadLeft(SeuNumero, 12, '0')                              + // 065 a 076 - Número Bancário  (Nosso Número)
       Space(5)                                                 + // 077 a 081 - Brancos
       '0'                                                      + // 082 Tipo de Código de Barras
       IfThen(DataDesconto2 > 0,FormatDateTime( 'ddmmyy', DataDesconto2),PadLeft('', 6, '0')) + // 083 a 088 - Data do segundo desconto
       IntToStrZero( round( ValorDesconto2 * 100 ), 13)         + // 089 a 101 Valor do Desconto 2
       Space(6)                                                 + // 102 a 107  - Brancos
       IntToStr(LCartInt)                                       + // 108 a 108 - Código da Carteira
       LOcorrencia                                              + // 109 a 110 - Código ocorrencia
       PadLeft(NumeroDocumento, 10, '0')                        +  // 111 a 120 - Numero Documento
       FormatDateTime( 'ddmmyy', Vencimento)                    +  // 121 a 126 - Data Vencimento
       IntToStrZero( Round( ValorDocumento * 100 ), 13)         +  // 127 a 139 - Valo Titulo
       '745'                                                    + // 140 a 142 - Número do Citibank na Compensação
       '00000'                                                  + // 143 a 147 - zeros a pedido do banco em 21-08-2025
       '01'                                                     + // 148 a 149 - Tipo de Emissão
       'N'                                                      + // 150 a 150 - Aceite
       FormatDateTime( 'ddmmyy', DataDocumento )                +  // 151 a 156 - Data de Emissão
       LProtesto                                                +  // 157 a 160 - Intruções de Protesto
       IntToStrZero( round(LValorMoraJuros * 100 ), 13)          +  // 161 a 173 - Valor a ser cobrado por dia de atraso
       IfThen(DataDesconto < EncodeDate(2000,01,01),'000000',
              FormatDateTime( 'ddmmyy', DataDesconto))          + // 174 a 179 - Data limite para concessão desconto
       IntToStrZero( round( ValorDesconto * 100 ), 13)          + // 180 a 192 - Valor Desconto
       Space(4)                                                 + // 193 a 196
       IntToStrZero( round( ValorIOF * 100 ), 9)                + // 197 a 205 - Valor IOF
       IntToStrZero( round( ValorAbatimento * 100 ), 13)        + // 206 a 218 - Valor Abatimento
       LTipoSacado + PadLeft(OnlyCPFCNPJAlphaNum(Sacado.CNPJCPF),14,'0') + // 219 a 234 - Tipo de inscrição + Número de inscrição do Pagador
       PadRight( Sacado.NomeSacado, 40, ' ')                    + // 235 a 274 - Nome do Pagador
       PadRight(Sacado.Logradouro + ' ' + Sacado.Numero + ' '   +
         Sacado.Complemento + ' ' , 40)                         + // 275 a 314 - Endereço completo do pagador
       PadRight( Sacado.Bairro, 12, ' ')                        + // 315 a 326 -  Bairro do endereço do sacado
       PadRight( Sacado.CEP, 8, ' ')                            + // 327 a 334 - CEP
       PadRight( Sacado.Cidade, 15, ' ')                        + // 335 a 349 - Nome da cidade
       PadRight( Sacado.UF, 2, ' ')                             + // 350 a 351 - UF sacado
       PadRight( LMensagemCedente, 42 )                          + // 352 a 393 - Beneficiário final ou 2ª Mensagem
       '9'                                                      + // 394 - Código de Moeda
       IntToStrZero(aRemessa.Count + 1, 6)                      ; // 395 a 400 - NÓ sequencial DO REGISTRO NO ARQUIVO

       Result := UpperCase(wLinha);

      end;
   end;

end;

procedure TACBrBancoCitiBank.GerarRegistroTransacao400(ACBrTitulo :TACBrTitulo; ARemessa: TStringList);
var
  LLinha, LNossoNumero, LDigitoNossoNumero : String;
begin
  ARemessa.Add(UpperCase(GerarLinhaRegistroTransacao400(ACBrTitulo, ARemessa)));
  LLinha := MontaInstrucoesCNAB400(ACBrTitulo, ARemessa.Count );

  if not(LLinha = EmptyStr) then
    aRemessa.Add(UpperCase(LLinha));

  if (ACBrTitulo.Sacado.SacadoAvalista.NomeAvalista <> '') then
  begin
    ValidaNossoNumeroResponsavel(LNossoNumero, LDigitoNossoNumero, ACBrTitulo);
    LLinha := '7'                                                                + // 001 a 001 - Identificação do registro detalhe (7)
    PadRight(Trim(ACBrTitulo.Sacado.SacadoAvalista.Logradouro + ' ' +
                  ACBrTitulo.Sacado.SacadoAvalista.Numero     + ' ' +
                  ACBrTitulo.Sacado.SacadoAvalista.Bairro)  , 45, ' ')           + // 002 a 046 - Endereço Beneficiario Final
    PadRight(OnlyNumber(ACBrTitulo.Sacado.SacadoAvalista.CEP), 8, '0' )          + // 047 a 054 - CEP + Sufixo do CEP
    PadRight(ACBrTitulo.Sacado.SacadoAvalista.Cidade, 20, ' ')                   + // 055 a 074 - Cidade
    PadRight(ACBrTitulo.Sacado.SacadoAvalista.UF, 2, ' ')                        + // 075 a 076 - UF
    PadRight('', 290, ' ')                                                       + // 077 a 366 - Reserva Filer
    PadLeft(ACBrTitulo.Carteira, 3, '0')                                         + // 367 a 369 - Carteira
    PadLeft(OnlyNumber(ACBrTitulo.ACBrBoleto.Cedente.Agencia), 5, '0')           + // 370 a 374 - agência mantenedora da conta
    PadLeft(ACBrTitulo.ACBrBoleto.Cedente.Conta, 7, '0')                         + // 375 a 381 - Número da Conta Corrente
    Padleft(ACBrTitulo.ACBrBoleto.Cedente.ContaDigito, 1 , ' ')                  + // 382 a 382 - Dígito Verificador da Conta DAC
    PadLeft(LNossoNumero, 11, '0')                                               + // 383 a 393 - Nosso Número
    PadLeft(LDigitoNossoNumero ,1,' ')                                           + // 394 a 394 - Digito Nosso Número
    IntToStrZero( ARemessa.Count + 1, 6);                                          // 395 a 400 - Número sequencial do registro

    ARemessa.Add(UpperCase(LLinha));
  end;
end;

procedure TACBrBancoCitiBank.LerRetorno400(ARetorno: TStringList);
var 
  LTamanhoMaximoNossoNum : Integer;
begin
  LTamanhoMaximoNossoNum := TamanhoMaximoNossoNum;
  try
    if ACBrBanco.ACBrBoleto.LerNossoNumeroCompleto then
      fpTamanhoMaximoNossoNum := LTamanhoMaximoNossoNum+1;
    inherited;
  finally
    fpTamanhoMaximoNossoNum := LTamanhoMaximoNossoNum;
  end;
end;

procedure TACBrBancoCitiBank.LerRetorno400Transacao4(ACBrTitulo :TACBrTitulo; ALinha: String);
var
  LURL, LtxId: string;
begin
  inherited;
  LURL := Trim(Copy(ALinha, 29,77));
  LtxId := Trim(Copy(ALinha,106,35));
  if NaoEstaVazio(lURL) and NaoEstaVazio(LtxId) then
     ACBrTitulo.QrCode.PIXQRCodeDinamico(Lurl, LtxId, ACBrTitulo);
end;

function TACBrBancoCitiBank.ConverterMultaPercentual(const ACBrTitulo: TACBrTitulo): Double;
begin
  if ACBrTitulo.MultaValorFixo then
      if (ACBrTitulo.ValorDocumento > 0) then
        Result := (ACBrTitulo.PercentualMulta / ACBrTitulo.ValorDocumento) * 100
      else
        Result := 0
    else
      Result := ACBrTitulo.PercentualMulta;
end;

function TACBrBancoCitiBank.ConverterJurosValorDiario( const ACBrTitulo: TACBrTitulo): Double;
begin
  case ACBrTitulo.CodigoMoraJuros of
    cjValorDia: Result := ACBrTitulo.ValorMoraJuros;
    cjTaxaMensal: Result := (ACBrTitulo.ValorMoraJuros * ACBrTitulo.ValorDocumento / 100 / 30);
    cjIsento: Result := 0;
    cjValorMensal: Result := (ACBrTitulo.ValorMoraJuros / 30);
    cjTaxaDiaria: Result := (ACBrTitulo.ValorMoraJuros * ACBrTitulo.ValorDocumento / 100);
  end;
end;

function TACBrBancoCitiBank.CodOcorrenciaToTipo(const ACodOcorrencia: Integer): TACBrTipoOcorrencia;
begin
  case ACodOcorrencia of
    02: Result := toRetornoRegistroConfirmado;                  // Entrada confirmada
    03: Result := toRetornoRegistroRecusado;                    // Transacao rejeitada (motivo na pos 302/321)
    06: Result := toRetornoLiquidado;                           // Liquidacao / pagamento
    07: Result := toRetornoDescontoConcedido;                   // Desconto concedido
    10: Result := toRetornoBaixadoPorDevolucao;                 // Baixa / Devolucao (forma na pos 302/321)
    11: Result := toRetornoTituloEmSer;                         // Em ser (a vencer)
    12: Result := toRetornoAbatimentoConcedido;                 // Abatimento concedido
    14: Result := toRetornoVencimentoAlterado;                  // Vencimento e/ou valor alterado
    15: Result := toRetornoLiquidadoEmCartorio;                 // Pago em cartorio
    17: Result := toRetornoLiquidadoAposBaixaOuNaoRegistro;     // Liquidacao apos baixa
    18: Result := toRetornoBaixadoPorDevolucao;                 // Devolucao por decurso de prazo
    19: Result := toRetornoConfInstrucaoProtesto;               // Confirmacao instrucao de protesto
    20: Result := toRetornoConfInstrucaoSustacaoProtesto;       // Confirmacao sustacao de protesto
    21: Result := toRetornoConfRecPedidoExclusaoNegativacao;    // Confirmacao Pedido Exclusao Serasa
    22: Result := toRetornoConfRecPedidoNegativacao;            // Titulo enviado para negativacao
    23: Result := toRetornoEncaminhadoACartorio;                // Titulo enviado a cartorio
    26: Result := toRetornoInstrucaoRejeitada;                  // Instrucao rejeitada
    29: Result := toRetornoAlegacaoDoSacado;                    // Alegacao do Sacado
    31: Result := toRetornoConfEntradaNegativacao;              // Titulo negativado na Serasa
    34: Result := toRetornoRetiradoDeCartorio;                  // Titulo retirado de cartorio
    51: Result := toRetornoCustasCartorioDistribuidor;          // Custa de distribuicao
    52: Result := toRetornoCustasSustacao;                      // Custa de sustacao
    53: Result := toRetornoCustasProtesto;                      // Custa de protesto
    95: Result := toRetornoConfEntradaNegativacao;              // Instrucao Negativacao Cumprida
  else
    Result := toRemessaRegistrar;
  end;
end;

function TACBrBancoCitiBank.TipoOcorrenciaToCod( const ATipoOcorrencia: TACBrTipoOcorrencia): String;
begin
  case ATipoOcorrencia of
    toRetornoRegistroConfirmado:                  Result := '02';
    toRetornoRegistroRecusado:                    Result := '03';
    toRetornoLiquidado:                           Result := '06';
    toRetornoDescontoConcedido:                   Result := '07';
    toRetornoBaixadoPorDevolucao:                 Result := '10';
    toRetornoTituloEmSer:                         Result := '11';
    toRetornoAbatimentoConcedido:                 Result := '12';
    toRetornoVencimentoAlterado:                  Result := '14';
    toRetornoLiquidadoEmCartorio:                 Result := '15';
    toRetornoLiquidadoAposBaixaOuNaoRegistro:     Result := '17';
    toRetornoConfInstrucaoProtesto:               Result := '19';
    toRetornoConfInstrucaoSustacaoProtesto:       Result := '20';
    toRetornoConfRecPedidoExclusaoNegativacao:    Result := '21';
    toRetornoConfRecPedidoNegativacao:            Result := '22';
    toRetornoEncaminhadoACartorio:                Result := '23';
    toRetornoInstrucaoRejeitada:                  Result := '26';
    toRetornoAlegacaoDoSacado:                    Result := '29';
    toRetornoConfEntradaNegativacao:              Result := '31';
    toRetornoRetiradoDeCartorio:                  Result := '34';
    toRetornoCustasCartorioDistribuidor:          Result := '51';
    toRetornoCustasSustacao:                      Result := '52';
    toRetornoCustasProtesto:                      Result := '53';
  else
    Result := '';
  end;
end;

function TACBrBancoCitiBank.TipoOcorrenciaToDescricao(const ATipoOcorrencia: TACBrTipoOcorrencia): String;
begin
  case ATipoOcorrencia of
    toRetornoRegistroConfirmado:                  Result := '02 - Entrada Confirmada';
    toRetornoRegistroRecusado:                    Result := '03 - Transacao Rejeitada';
    toRetornoLiquidado:                           Result := '06 - Liquidacao / Pagamento';
    toRetornoDescontoConcedido:                   Result := '07 - Desconto Concedido';
    toRetornoBaixadoPorDevolucao:                 Result := '10 - Baixa / Devolucao';
    toRetornoTituloEmSer:                         Result := '11 - Em Ser (a vencer)';
    toRetornoAbatimentoConcedido:                 Result := '12 - Abatimento Concedido';
    toRetornoVencimentoAlterado:                  Result := '14 - Vencimento e/ou Valor Alterado';
    toRetornoLiquidadoEmCartorio:                 Result := '15 - Pago em Cartorio';
    toRetornoLiquidadoAposBaixaOuNaoRegistro:     Result := '17 - Liquidacao apos Baixa';
    toRetornoConfInstrucaoProtesto:               Result := '19 - Confirmacao Instrucao de Protesto';
    toRetornoConfInstrucaoSustacaoProtesto:       Result := '20 - Confirmacao Sustacao de Protesto';
    toRetornoConfRecPedidoExclusaoNegativacao:    Result := '21 - Confirmacao Exclusao Serasa';
    toRetornoConfRecPedidoNegativacao:            Result := '22 - Titulo Enviado para Negativacao';
    toRetornoEncaminhadoACartorio:                Result := '23 - Titulo Enviado a Cartorio';
    toRetornoInstrucaoRejeitada:                  Result := '26 - Instrucao Rejeitada';
    toRetornoAlegacaoDoSacado:                    Result := '29 - Alegacao do Sacado';
    toRetornoConfEntradaNegativacao:              Result := '31 - Titulo Negativado na Serasa';
    toRetornoRetiradoDeCartorio:                  Result := '34 - Titulo Retirado de Cartorio';
    toRetornoCustasCartorioDistribuidor:          Result := '51 - Custa de Distribuicao';
    toRetornoCustasSustacao:                      Result := '52 - Custa de Sustacao';
    toRetornoCustasProtesto:                      Result := '53 - Custa de Protesto';
  else
    Result := '';
  end;
end;

end.
