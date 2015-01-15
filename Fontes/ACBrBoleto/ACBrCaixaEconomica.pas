{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2009 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:   João Elson                                    }
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
{ Daniel Simões de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Praça Anita Costa, 34 - Tatuí - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{Convênio SIGCB Carteira 1 ou 2 Registrada ou Sem Registro} 

{$I ACBr.inc}

unit ACBrCaixaEconomica;

interface

uses
  Classes, SysUtils, ACBrBoleto,
  {$IFDEF COMPILER6_UP} DateUtils {$ELSE} ACBrD5, FileCtrl {$ENDIF};

type

  { TACBrCaixaEconomica}

  TACBrCaixaEconomica = class(TACBrBancoClass)
   protected
   private
    fValorTotalDocs:Double;
    function FormataNossoNumero(const ACBrTitulo :TACBrTitulo): String;
   public
    Constructor create(AOwner: TACBrBanco);
    function CalcularDigitoVerificador(const ACBrTitulo: TACBrTitulo ): String; override;
    function CalcularDVCedente(const ACBrTitulo: TACBrTitulo ): String;
    function MontarCodigoBarras(const ACBrTitulo : TACBrTitulo): String; override;
    function MontarCampoCodigoCedente(const ACBrTitulo: TACBrTitulo): String; override;
    function MontarCampoNossoNumero(const ACBrTitulo :TACBrTitulo): String; override;
    function GerarRegistroHeader240(NumeroRemessa : Integer): String; override;
    function GerarRegistroTransacao240(ACBrTitulo : TACBrTitulo): String; override;
    function GerarRegistroTrailler240(ARemessa : TStringList): String;  override;
    procedure LerRetorno240(ARetorno: TStringList); override;
    function CodMotivoRejeicaoToDescricao(const TipoOcorrencia: TACBrTipoOcorrencia; CodMotivo: Integer): string; override;
    function TipoOcorrenciaToDescricao(const TipoOcorrencia: TACBrTipoOcorrencia): String; override;
    function CodOcorrenciaToTipo(const CodOcorrencia: Integer): TACBrTipoOcorrencia; override;
    function TipoOCorrenciaToCod(const TipoOcorrencia: TACBrTipoOcorrencia): String; override;
    function CodigoLiquidacao_Descricao( CodLiquidacao : Integer) : String;
   end;

implementation

uses ACBrUtil, StrUtils, Variants;

constructor TACBrCaixaEconomica.create(AOwner: TACBrBanco);
begin
   inherited create(AOwner);
   fpDigito := 0;
   fpNome   := 'Caixa Economica Federal';
   fpNumero:= 104;
   fpTamanhoAgencia :=  5;
   fpTamanhoMaximoNossoNum := 15;

   fValorTotalDocs:= 0;

   fpOrientacoesBanco.Clear;
   
   // DONE -oJacinto Junior: Ajustar a mensagem a ser apresentada nos boletos.
//   fpOrientacoesBanco.Add(ACBrStr('SAC CAIXA: 0800 726 0101 (informações,reclamações e elogios) ' + sLineBreak+
//                          'Para pessoas com deficiência auditiva ou de fala: 0800 726 2492 ' + sLineBreak +
//                          'Ouvidoria: 0800 725 7474 (reclamações não solucionadas e denúncias)') + sLineBreak+
//                          '     caixa.gov.br      ');
   fpOrientacoesBanco.Add(ACBrStr(
                          'SAC CAIXA: 0800 726 0101 (informações, reclamações, sugestões e elogios) ' + sLineBreak +
                          'Para pessoas com deficiência auditiva ou de fala: 0800 726 2492 ' + sLineBreak +
                          'Ouvidoria: 0800 725 7474 (reclamações não solucionadas e denúncias) ') + sLineBreak +
                          'caixa.gov.br ');
end;

function TACBrCaixaEconomica.CalcularDigitoVerificador(const ACBrTitulo: TACBrTitulo ): String;
var
  Num, ACarteira, ANossoNumero, Res :String;
begin
   Result := '0';
   if (ACBrTitulo.Carteira = 'RG') then
      ACarteira := '1'
   else if (ACBrTitulo.Carteira = 'SR')then
      ACarteira := '2'
   else
      raise Exception.Create( ACBrStr('Carteira Inválida.'+sLineBreak+'Utilize "RG" ou "SR"') ) ;

   ANossoNumero := OnlyNumber(ACBrTitulo.NossoNumero);

   if ACBrTitulo.CarteiraEnvio = tceCedente then //O Cedente é quem envia o boleto
      Num := ACarteira + '4' + PadR(ANossoNumero, 15, '0')
   else
      Num := ACarteira + '1' + PadR(ANossoNumero, 15, '0'); //o Banco é quem Envia

   Modulo.CalculoPadrao;
   Modulo.MultiplicadorFinal   := 2;
   Modulo.MultiplicadorInicial := 9;
   Modulo.Documento := Num;
   Modulo.Calcular;

   Res:= IntToStr(Modulo.ModuloFinal);

   if Length(Res) > 1 then
      Result := '0'
   else
      Result := Res[1];

end;

function TACBrCaixaEconomica.CalcularDVCedente(const ACBrTitulo: TACBrTitulo): String;
var
  Num, Res: string;
begin 
    Num := ACBrTitulo.ACBrBoleto.Cedente.CodigoCedente;
    Modulo.CalculoPadrao;
    Modulo.MultiplicadorFinal   := 2;
    Modulo.MultiplicadorInicial := 9;
    Modulo.Documento := Num;
    Modulo.Calcular;
    Res := intTostr(Modulo.ModuloFinal);

    if Length(Res) > 1 then
       Result := '0'
    else
       Result := Res[1];
end;

function TACBrCaixaEconomica.FormataNossoNumero(const ACBrTitulo :TACBrTitulo): String;
var
  ANossoNumero :String;
begin
   with ACBrTitulo do
   begin
      ANossoNumero := OnlyNumber(NossoNumero);

      if (ACBrTitulo.Carteira = 'RG') then
      begin         {carterira registrada}
        if ACBrTitulo.CarteiraEnvio = tceCedente then
          ANossoNumero := '14'+padR(ANossoNumero, 15, '0')
        else
          ANossoNumero := '11'+padR(ANossoNumero, 15, '0')
      end
      else if (ACBrTitulo.Carteira = 'SR')then     {carteira 2 sem registro}
      begin
        if ACBrTitulo.CarteiraEnvio = tceCedente then
          ANossoNumero := '24'+padR(ANossoNumero, 15, '0')
        else
          ANossoNumero := '21'+padR(ANossoNumero, 15, '0')
      end
      else
         raise Exception.Create( ACBrStr('Carteira Inválida.'+sLineBreak+'Utilize "RG" ou "SR"') ) ;
   end;

   Result := ANossoNumero;
end;

function TACBrCaixaEconomica.MontarCodigoBarras(const ACBrTitulo : TACBrTitulo): String;
var
  CodigoBarras, FatorVencimento, DigitoCodBarras :String;
  CampoLivre,DVCampoLivre, ANossoNumero : String;
begin

    FatorVencimento := CalcularFatorVencimento(ACBrTitulo.Vencimento);
    
    ANossoNumero := FormataNossoNumero(ACBrTitulo);

    {Montando Campo Livre}
    CampoLivre := padR(ACBrTitulo.ACBrBoleto.Cedente.CodigoCedente,6,'0') +
                  CalcularDVCedente(ACBrTitulo) + Copy(ANossoNumero,3,3)  +
                  Copy(ANossoNumero,1,1) + Copy(ANossoNumero,6,3)         +
                  '4' + Copy(ANossoNumero,9,9);

    Modulo.CalculoPadrao;
    Modulo.MultiplicadorFinal   := 2;
    Modulo.MultiplicadorInicial := 9;
    Modulo.Documento := CampoLivre;
    Modulo.Calcular;
    DVCampoLivre := intTostr(Modulo.ModuloFinal);

    if Length(DVCampoLivre) > 1 then
       DVCampoLivre := '0';

    CampoLivre := CampoLivre + DVCampoLivre;
    
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
    Result:= copy( CodigoBarras, 1, 4) + DigitoCodBarras + copy( CodigoBarras, 5, 44);
end;

function TACBrCaixaEconomica.TipoOCorrenciaToCod(const TipoOcorrencia: TACBrTipoOcorrencia): String;
begin
  // DONE -oJacinto Junior: Ajustar para utilizar as ocorrências corretas.
  // TODO -oJacinto Junior: Definir ocorrências pendentes.
  case TipoOcorrencia of
//                                                   : Result := '01'; // Solicitação de Impressão de Títulos Confirmada
    toRetornoRegistroConfirmado                    : Result := '02';
    toRetornoRegistroRecusado                      : Result := '03';
//                                                   : Result := '04'; // Transferência de Carteira/Entrada
//                                                   : Result := '05'; // Transferência de Carteira/Baixa
    toRetornoLiquidado                             : Result := '06';
    toRetornoRecebimentoInstrucaoConcederDesconto  : Result := '07';
    toRetornoRecebimentoInstrucaoCancelarDesconto  : Result := '08';
    toRetornoBaixado                               : Result := '09';
//    toRetornoAbatimentoConcedido                   : Result := '12';
    toRetornoRecebimentoInstrucaoConcederAbatimento: Result := '12';
//    toRetornoAbatimentoCancelado                   : Result := '13';
    toRetornoRecebimentoInstrucaoCancelarAbatimento: Result := '13';
//    toRetornoVencimentoAlterado                    : Result := '14';
    toRetornoRecebimentoInstrucaoAlterarVencimento : Result := '14';
    toRetornoRecebimentoInstrucaoProtestar         : Result := '19';
    toRetornoRecebimentoInstrucaoSustarProtesto    : Result := '20';
    toRetornoEntradaEmCartorio                     : Result := '23';
    toRetornoRetiradoDeCartorio                    : Result := '24';
    toRetornoBaixaPorProtesto                      : Result := '25';
    toRetornoInstrucaoRejeitada                    : Result := '26';
//                                                   : Result := '27'; // Confirmação do Pedido de Alteração de Outros Dados
    toRetornoDebitoTarifas                         : Result := '28';
    toRetornoAlteracaoOutrosDadosRejeitada         : Result := '30';
//                                                   : Result := '35'; // Confirmação de Inclusão Banco de Sacado
//                                                   : Result := '36'; // Confirmação de Alteração Banco de Sacado
//                                                   : Result := '37'; // Confirmação de Exclusão Banco de Sacado
//                                                   : Result := '38'; // Emissão de Bloquetos de Banco de Sacado
//                                                   : Result := '39'; // Manutenção de Sacado Rejeitada
//                                                   : Result := '40'; // Entrada de Título via Banco de Sacado Rejeitada
//                                                   : Result := '41'; // Manutenção de Banco de Sacado Rejeitada
    toRetornoBaixaOuLiquidacaoEstornada            : Result := '44';
    toRetornoRecebimentoInstrucaoAlterarDados      : Result := '45';
  else
    Result := '00';
  end;

  // Implementação obsoleta.
  {***
//escol
  case TipoOcorrencia of
    toRetornoRegistroConfirmado                 : Result := '02';
    toRetornoRegistroRecusado                   : Result := '03';
    toRetornoLiquidado                          : Result := '06';
    toRetornoAbatimentoConcedido                : Result := '12';
    toRetornoAbatimentoCancelado                : Result := '13';
    toRetornoVencimentoAlterado                 : Result := '14';
    toRetornoRecebimentoInstrucaoProtestar      : Result := '19';
    toRetornoRecebimentoInstrucaoSustarProtesto : Result := '20';
    toRetornoInstrucaoRejeitada                 : Result:=  '26';
    toRetornoDebitoTarifas                      : Result := '28';
    toRetornoALteracaoOutrosDadosRejeitada      : Result := '30';
    toRetornoRecebimentoInstrucaoAlterarDados   : Result := '45';
  else
    Result := '00';
  end;
  ***}
end;

function TACBrCaixaEconomica.MontarCampoCodigoCedente (
   const ACBrTitulo: TACBrTitulo ) : String;
begin
  Result := RightStr(ACBrTitulo.ACBrBoleto.Cedente.Agencia,4)+ '/' +
            ACBrTitulo.ACBrBoleto.Cedente.CodigoCedente+ '-' +
                CalcularDVCedente(ACBrTitulo);
end;

function TACBrCaixaEconomica.MontarCampoNossoNumero (const ACBrTitulo: TACBrTitulo ) : String;
var ANossoNumero : string;
begin
    ANossoNumero := FormataNossoNumero(ACBrTitulo);

    Result := ANossoNumero + '-' + CalcularDigitoVerificador(ACBrTitulo);
end;

function TACBrCaixaEconomica.GerarRegistroHeader240(NumeroRemessa : Integer): String;
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
               padL('', 9, ' ')                        + //9 a 17 Uso exclusivo FEBRABAN/CNAB
               ATipoInscricao                          + //18 - Tipo de inscrição do cedente
               padR(OnlyNumber(CNPJCPF), 14, '0')      + //19 a 32 -Número de inscrição do cedente
               //padL(CodigoCedente, 18, '0') + '  '     + //33 a 52 - Código do convênio no banco [ Alterado conforme instruções da CSO Brasília ] 27-07-09
               padL('',20, '0')                        +  //33 a 52 - Código do convênio no banco
               padR(OnlyNumber(Agencia), 5, '0')       + //53 a 57 - Código da agência do cedente
               padL(AgenciaDigito, 1 , '0')            + //58 - Dígito da agência do cedente
               padR(CodigoCedente, 6, '0')             + //59 a 64 - Código Cedente (Código do Convênio no Banco)
               padL('', 7, '0')                        + //65 a 71 - Uso Exclusivo CAIXA
               '0'                                     + //72 - Uso Exclusivo CAIXA
               padL(Nome, 30, ' ')                     + //73 a 102 - Nome do cedente
               padL('CAIXA ECONOMICA FEDERAL', 30, ' ') + //103 a 132 - Nome do banco
               padL('', 10, ' ')                       + //133 a 142 - Uso exclusivo FEBRABAN/CNAB
               '1'                                     + //143 - Código de Remessa (1) / Retorno (2)
               FormatDateTime('ddmmyyyy', Now)         + //144 a 151 - Data do de geração do arquivo
               FormatDateTime('hhmmss', Now)           + //152 a 157 - Hora de geração do arquivo
               padR(IntToStr(NumeroRemessa), 6, '0')   + //158 a 163 - Número seqüencial do arquivo
               '050'                                   + //164 a 166 - Número da versão do layout do arquivo
               padL('',  5, '0')                       + //167 a 171 - Densidade de gravação do arquivo (BPI)
               Space(20)                               + // 172 a 191 - Uso reservado do banco
               padL('REMESSA-PRODUCAO', 20, ' ')       + // 192 a 211 - Uso reservado da empresa
               padL('', 4, ' ')                        + // 212 a 215 - Versao Aplicativo Caixa
               padL('', 25, ' ');                        // 216 a 240 - Uso Exclusivo FEBRABAN / CNAB

          { GERAR REGISTRO HEADER DO LOTE }

      Result:= Result + #13#10 +
               IntToStrZero(ACBrBanco.Numero, 3)       + //1 a 3 - Código do banco
               '0001'                                  + //4 a 7 - Lote de serviço
               '1'                                     + //8 - Tipo de registro - Registro header de arquivo
               'R'                                     + //9 - Tipo de operação: R (Remessa) ou T (Retorno)
               '01'                                    + //10 a 11 - Tipo de serviço: 01 (Cobrança)
               '00'                                    + //12 a 13 - Forma de lançamento: preencher com ZEROS no caso de cobrança
               '030'                                   + //14 a 16 - Número da versão do layout do lote
               ' '                                     + //17 - Uso exclusivo FEBRABAN/CNAB
               ATipoInscricao                          + //18 - Tipo de inscrição do cedente
               padR(OnlyNumber(CNPJCPF), 15, '0')      + //19 a 33 -Número de inscrição do cedente
               padR(CodigoCedente, 6, '0')             + //34 a 39 - Código do convênio no banco (código do cedente)
               padL('', 14, '0')                       + //40 a 53 - Uso Exclusivo Caixa
               padR(OnlyNumber(Agencia), 5 , '0')      + //54 a 58 - Dígito da agência do cedente
               padL(AgenciaDigito, 1 , '0')            + //59 - Dígito da agência do cedente
               padR(CodigoCedente, 6, '0')             + //60 a 65 - Código do convênio no banco (código do cedente)
               padL('',7,'0')                          + //66 a 72 - Código do Modelo Personalizado (Código fornecido pela CAIXA/gráfica, utilizado somente quando o modelo do bloqueto for personalizado)
               '0'                                     + //73 - Uso Exclusivo Caixa
               padL(Nome, 30, ' ')                     + //74 a 103 - Nome do cedente
               padL('', 40, ' ')                       + //104 a 143 - Mensagem 1 para todos os boletos do lote
               padL('', 40, ' ')                       + //144 a 183 - Mensagem 2 para todos os boletos do lote
               padR(IntToStr(NumeroRemessa), 8, '0')   + //184 a 191 - Número do arquivo
               FormatDateTime('ddmmyyyy', Now)         + //192 a 199 - Data de geração do arquivo
               padL('', 8, '0')                        + //200 a 207 - Data do crédito - Só para arquivo retorno
               padL('', 33, ' ');                        //208 a 240 - Uso exclusivo FEBRABAN/CNAB
   end;
end;

function TACBrCaixaEconomica.GerarRegistroTransacao240(ACBrTitulo : TACBrTitulo): String;
var
  ATipoOcorrencia, ATipoBoleto, ADataMoraJuros         : String;
  ADataDesconto, ANossoNumero, ATipoAceite, AEspecieDoc: String;
begin
   with ACBrTitulo do
   begin
      ANossoNumero := FormataNossoNumero(ACBrTitulo);

      {SEGMENTO P}

      {Pegando o Tipo de Ocorrencia}
      case OcorrenciaOriginal.Tipo of
        toRemessaBaixar                        : ATipoOcorrencia := '02';
        toRemessaConcederAbatimento            : ATipoOcorrencia := '04';
        toRemessaCancelarAbatimento            : ATipoOcorrencia := '05';
        toRemessaAlterarVencimento             : ATipoOcorrencia := '06';
        toRemessaConcederDesconto              : ATipoOcorrencia := '07';
        toRemessaCancelarDesconto              : ATipoOcorrencia := '08';
        toRemessaProtestar                     : ATipoOcorrencia := '09';
        toRemessaCancelarInstrucaoProtestoBaixa: ATipoOcorrencia := '10';
        toRemessaCancelarInstrucaoProtesto     : ATipoOcorrencia := '11';
        toRemessaDispensarJuros                : ATipoOcorrencia := '13';
        toRemessaAlterarNomeEnderecoSacado     : ATipoOcorrencia := '31';
      else
        ATipoOcorrencia := '01';
      end;

      { Pegando o Aceite do Titulo }
      case Aceite of
         atSim :  ATipoAceite := 'A';
         atNao :  ATipoAceite := 'N';
      end;

      if AnsiSameText(EspecieDoc, 'CH') then
        AEspecieDoc := '01'
      else if AnsiSameText(EspecieDoc, 'DM') then
        AEspecieDoc := '02'
      else if AnsiSameText(EspecieDoc, 'DMI') then
        AEspecieDoc := '03'
      else if AnsiSameText(EspecieDoc, 'DS') then
        AEspecieDoc := '04'
      else if AnsiSameText(EspecieDoc, 'DSI') then
        AEspecieDoc := '05'
      else if AnsiSameText(EspecieDoc, 'DR') then
        AEspecieDoc := '06'
      else if AnsiSameText(EspecieDoc, 'LC') then
        AEspecieDoc := '07'
      else if AnsiSameText(EspecieDoc, 'NCC') then
        AEspecieDoc := '08'
      else if AnsiSameText(EspecieDoc, 'NCE') then
        AEspecieDoc := '09'
      else if AnsiSameText(EspecieDoc, 'NCI') then
        AEspecieDoc := '10'
      else if AnsiSameText(EspecieDoc, 'NCR') then
        AEspecieDoc := '11'
      else if AnsiSameText(EspecieDoc, 'NP') then
        AEspecieDoc := '12'
      else if AnsiSameText(EspecieDoc, 'NPR') then
        AEspecieDoc := '13'
      else if AnsiSameText(EspecieDoc, 'TM') then
        AEspecieDoc := '14'
      else if AnsiSameText(EspecieDoc, 'TS') then
        AEspecieDoc := '15'
      else if AnsiSameText(EspecieDoc, 'NS') then
        AEspecieDoc := '16'
      else if AnsiSameText(EspecieDoc, 'RC') then
        AEspecieDoc := '17'
      else if AnsiSameText(EspecieDoc, 'FAT') then
        AEspecieDoc := '18'
      else if AnsiSameText(EspecieDoc, 'ND') then
        AEspecieDoc := '19'
      else if AnsiSameText(EspecieDoc, 'AP') then
        AEspecieDoc := '20'
      else if AnsiSameText(EspecieDoc, 'ME') then
        AEspecieDoc := '21'
      else if AnsiSameText(EspecieDoc, 'PC') then
        AEspecieDoc := '22'
      else if AnsiSameText(EspecieDoc, 'NF') then
        AEspecieDoc := '23'
      else if AnsiSameText(EspecieDoc, 'DD') then
        AEspecieDoc := '24'
      else if AnsiSameText(EspecieDoc, 'CPR') then
        AEspecieDoc := '25'
      else
        AEspecieDoc := '99';

      {Pegando Tipo de Boleto} //Quem emite e quem distribui o boleto?
      case ACBrBoleto.Cedente.ResponEmissao of
         tbBancoEmite      : ATipoBoleto := '1' + '1';
         tbCliEmite        : ATipoBoleto := '2' + '0';
         tbBancoReemite    : ATipoBoleto := '4' + '1';
         tbBancoNaoReemite : ATipoBoleto := '5' + '2';
      end;

      {Mora Juros}
      if (ValorMoraJuros > 0) then
       begin
         if DataMoraJuros <> 0 then
            ADataMoraJuros := FormatDateTime('ddmmyyyy', DataMoraJuros)
         else
            ADataMoraJuros := padL('', 8, '0');
       end
      else
         ADataMoraJuros := padL('', 8, '0');

      {Descontos}
      if (ValorDesconto > 0) then
       begin
         if (DataDesconto <> Null) then
            ADataDesconto := FormatDateTime('ddmmyyyy', DataDesconto)
         else
            ADataDesconto := padL('', 8, '0');
       end
      else
         ADataDesconto := padL('', 8, '0');

      fValorTotalDocs:= fValorTotalDocs  + ValorDocumento;
      Result:= IntToStrZero(ACBrBanco.Numero, 3)                          + //1 a 3 - Código do banco
               '0001'                                                     + //4 a 7 - Lote de serviço
               '3'                                                        + //8 - Tipo do registro: Registro detalhe
               IntToStrZero((3*ACBrBoleto.ListadeBoletos.IndexOf(ACBrTitulo))+1,5) + //9 a 13 - Número seqüencial do registro no lote - Cada título tem 2 registros (P e Q)
               'P'                                                        + //14 - Código do segmento do registro detalhe
               ' '                                                        + //15 - Uso exclusivo FEBRABAN/CNAB: Branco
               ATipoOcorrencia                                            + //16 a 17 - Código de movimento
               padR(OnlyNumber(ACBrBoleto.Cedente.Agencia), 5, '0')       + //18 a 22 - Agência mantenedora da conta
               padL(ACBrBoleto.Cedente.AgenciaDigito, 1 , '0')            + //23 -Dígito verificador da agência
               padL(ACBrBoleto.Cedente.CodigoCedente, 6, '0')             + //24 a 29 - Código do Convênio no Banco (Codigo do cedente)
               padL('', 11, '0')                                          + //30 a 40 - Uso Exclusivo da CAIXA
               '14'                                                       + //41 a 42 - Modalidade da Carteira
               padR(Copy(ANossoNumero,3,17), 15, '0')                     + //43 a 57 - Nosso número - identificação do título no banco
               '1'                                                        + //58 - Cobrança Simples
               '1'                                                        + //59 - Forma de cadastramento do título no banco: com cadastramento  1-cobrança Registrada
               '2'                                                        + //60 - Tipo de documento: Tradicional
               ATipoBoleto                                                + //61 e 62(juntos)- Quem emite e quem distribui o boleto?
               padL(NumeroDocumento, 11, ' ')                             + //63 a 73 - Número que identifica o título na empresa
               padL('', 4, ' ')                                           + //74 a 77 - Uso Exclusivo Caixa
               FormatDateTime('ddmmyyyy', Vencimento)                     + //78 a 85 - Data de vencimento do título
               IntToStrZero( round( ValorDocumento * 100), 15)            + //86 a 100 - Valor nominal do título
               padL('', 5, '0')                                           + //101 a 105 - Agência cobradora. Se ficar em branco, a caixa determina automaticamente pelo CEP do sacado
               '0'                                                        + //106 - Dígito da agência cobradora
               padL(AEspecieDoc, 2)                                       + // 107 a 108 - Espécie do documento
               ATipoAceite                                                + //109 - Identificação de título Aceito / Não aceito
               FormatDateTime('ddmmyyyy', DataDocumento)                  + //110 a 117 - Data da emissão do documento
               IfThen(ValorMoraJuros > 0, '1', '0')                       + //118 - Código de juros de mora: Valor por dia
               ADataMoraJuros                                             + //119 a 126 - Data a partir da qual serão cobrados juros
               IfThen(ValorMoraJuros > 0, IntToStrZero( round(ValorMoraJuros * 100), 15), padL('', 15, '0')) + //127 a 141 - Valor de juros de mora por dia
               IfThen(ValorDesconto > 0, '1', '0')                        + //142 - Código de desconto: Valor fixo até a data informada
               ADataDesconto                                              + //143 a 150 - Data do desconto
               IfThen(ValorDesconto > 0, IntToStrZero( round(ValorDesconto * 100), 15),padL('', 15, '0'))+ //151 a 165 - Valor do desconto por dia
               IntToStrZero( round(ValorIOF * 100), 15)                   + //166 a 180 - Valor do IOF a ser recolhido
               IntToStrZero( round(ValorAbatimento * 100), 15)            + //181 a 195 - Valor do abatimento
               padL(IfThen(SeuNumero<>'',SeuNumero,NumeroDocumento), 25, ' ') + //196 a 220 - Identificação do título na empresa
               IfThen((DataProtesto <> 0) and (DataProtesto > Vencimento), '1', '3') + //221 - Código de protesto: Protestar em XX dias corridos
               IfThen((DataProtesto <> 0) and (DataProtesto > Vencimento),
                    padR(IntToStr(DaysBetween(DataProtesto, Vencimento)), 2, '0'), '00') + //222 a 223 - Prazo para protesto (em dias corridos)
               IfThen((DataBaixa <> 0) and (DataBaixa > Vencimento), '1', '2') + //224 - Código para baixa/devolução: Não baixar/não devolver
               IfThen((DataBaixa <> 0) and (DataBaixa > Vencimento),
                 padR(IntToStr(DaysBetween(DataBaixa, Vencimento)), 3, '0'), '000') + //225 a 227 - Prazo para baixa/devolução (em dias corridos)

               '09'                                                       + //228 a 229 - Código da moeda: Real
               padL('', 10 , '0')                                         + //230 a 239 - Uso Exclusivo CAIXA
               ' ';                                                         //240 - Uso exclusivo FEBRABAN/CNAB

      {SEGMENTO Q}
      Result:= Result + #13#10 +
               IntToStrZero(ACBrBanco.Numero, 3)                          + //1 a 3 - Código do banco
               '0001'                                                     + //4 a 7 - Número do lote
               '3'                                                        + //8 - Tipo do registro: Registro detalhe
               IntToStrZero((3 * ACBrBoleto.ListadeBoletos.IndexOf(ACBrTitulo))+ 2 ,5) + //9 a 13 - Número seqüencial do registro no lote - Cada título tem 2 registros (P e Q)
               'Q'                                                        + //14 - Código do segmento do registro detalhe
               ' '                                                        + //15 - Uso exclusivo FEBRABAN/CNAB: Branco
               ATipoOcorrencia                                            + //16 a 17 - Código de movimento
                   {Dados do sacado}
               IfThen(Sacado.Pessoa = pJuridica,'2','1')                  + //18 - Tipo inscricao
               padR(OnlyNumber(Sacado.CNPJCPF), 15, '0')                  + //19 a 33 - Número de Inscrição
               padL(Sacado.NomeSacado, 40, ' ')                           + //34 a 73 - Nome sacado
               padL(Sacado.Logradouro +' '+ Sacado.Numero +' '+ Sacado.Complemento , 40, ' ') + //74 a 113 - Endereço
               padL(Sacado.Bairro, 15, ' ')                               + // 114 a 128 - bairro sacado
               padR(OnlyNumber(Sacado.CEP), 8, '0')                                   + // 129 a 133 e 134 a 136- cep sacado prefixo e sufixo sem o traço"-" somente numeros
               padL(Sacado.Cidade, 15, ' ')                               + // 137 a 151 - cidade sacado
               padL(Sacado.UF, 2, ' ')                                    + // 152 a 153 - UF sacado
                        {Dados do sacador/avalista}
               '0'                                                                            + // 154 a 154 - Tipo de inscrição: Não informado
               padL('', 15, '0')                                                              + // 155 a 169 - Número de inscrição
               padL('', 40, ' ')                                                              + // 170 a 209 - Nome do sacador/avalista
               padL('', 3, ' ')                                                               + // 210 a 212 - Uso exclusivo FEBRABAN/CNAB
               padL('',20, ' ')                                                               + // 213 a 232 - Uso exclusivo FEBRABAN/CNAB
               padL('', 8, ' ');                                                                // 233 a 240 - Uso exclusivo FEBRABAN/CNAB

 {SEGMENTO R}
      Result:= Result + #13#10 +
               IntToStrZero(ACBrBanco.Numero, 3)                                           + //   1 a 3   - Código do banco
               '0001'                                                                      + //   4 a 7   - Número do lote
               '3'                                                                         + //   8 a 8   - Tipo do registro: Registro detalhe
               IntToStrZero((3 * ACBrBoleto.ListadeBoletos.IndexOf(ACBrTitulo))+ 3 ,5)     + //   9 a 13  - Número seqüencial do registro no lote - Cada título tem 2 registros (P e Q)
               'R'                                                                         + //  14 a 14  - Código do segmento do registro detalhe
               ' '                                                                         + //  15 a 15  - Uso exclusivo FEBRABAN/CNAB: Branco
               ATipoOcorrencia                                                             + //  16 a 17  - Tipo Ocorrencia
               padR('', 1,  '0')                                                           + //  18 a 18  - Codigo do Desconto 2
               padR('', 8,  ' ')                                                           + //  19 a 26  - Data do Desconto 2
               padR('', 15, '0')                                                           + //  27 a 41  - Valor/Percentual a ser concedido
               padR('', 1,  '0')                                                           + //  42 a 42  - Código do Desconto 3
               padR('', 8,  ' ')                                                           + //  43 a 50  - Data do Desconto 3
               padR('', 15, '0')                                                           + //  51 a 65  - Valor/Percentual a ser concedido
               IfThen((PercentualMulta <> null) and (PercentualMulta > 0), '2', '0')       + //  66 a 66  - Código da Multa
               FormatDateTime('ddmmyyyy',Vencimento)                                       + //  67 a 74  - Data da Multa
               IfThen(PercentualMulta > 0, IntToStrZero(round(PercentualMulta * 100), 15),
                      padL('', 15, '0'))                                                   + //  75 a 89  - Valor/Percentual a ser aplicado
               PadL('', 10, ' ')                                                           + //  90 a 99  - Informação ao Sacado
               PadL('', 40, ' ')                                                           + // 100 a 139 - Mensagem 3
               PadL('', 40, ' ')                                                           + // 140 a 179 - Mensagem 4
               PadL('', 50, ' ')                                                           + // 180 a 229 - Email do Sacado P/ Envio de Informacoes
               PadL('', 11, ' ');                                                            // 230 a 240 - Uso Exclusivo Febraban/CNAB
      end;
end;

function TACBrCaixaEconomica.GerarRegistroTrailler240( ARemessa : TStringList ): String;
var
  wQTDTitulos: Integer;
begin

   wQTDTitulos := ARemessa.Count - 1;
   {REGISTRO TRAILER DO LOTE}
   Result:= IntToStrZero(ACBrBanco.Numero, 3)                          + //Código do banco
            '0001'                                                     + //Lote de Serviço
            '5'                                                        + //Tipo do registro: Registro trailer do lote
            Space(9)                                                   + //Uso exclusivo FEBRABAN/CNAB
            IntToStrZero((3* wQTDTitulos + 2 ), 6)                     + //Quantidade de Registro no Lote (Registros P,Q,R, header e trailer do lote)
            IntToStrZero((wQTDTitulos), 6)                             + //Quantidade títulos em cobrança
            IntToStrZero( round( fValorTotalDocs * 100), 17)           + //Valor dos títulos em carteiras}
            padL('', 6, '0')                                           + //Quantidade títulos em cobrança
            padL('',17, '0')                                           + //Valor dos títulos em carteiras}
            padL('',6,  '0')                                           + //Quantidade títulos em cobrança
            padL('',17, '0')                                           + //Quantidade de Títulos em Carteiras
            padL('',31, ' ')                                           + //Uso exclusivo FEBRABAN/CNAB
            padL('',117,' ')                                           ; //Uso exclusivo FEBRABAN/CNAB}

   {GERAR REGISTRO TRAILER DO ARQUIVO}
   Result:= Result + #13#10 +
            IntToStrZero(ACBrBanco.Numero, 3)                          + //Código do banco
            '9999'                                                     + //Lote de serviço
            '9'                                                        + //Tipo do registro: Registro trailer do arquivo
            padL('',9,' ')                                             + //Uso exclusivo FEBRABAN/CNAB}
            '000001'                                                   + //Quantidade de lotes do arquivo (Registros P,Q,R, header e trailer do lote e do arquivo)
            IntToStrZero((3* wQTDTitulos)+4, 6)                        + //Quantidade de registros do arquivo, inclusive este registro que está sendo criado agora}
            padL('',6,' ')                                             + //Uso exclusivo FEBRABAN/CNAB}
            padL('',205,' ');                                            //Uso exclusivo FEBRABAN/CNAB}
end;
procedure TACBrCaixaEconomica.LerRetorno240(ARetorno: TStringList);
var
  ContLinha: Integer;
  Titulo   : TACBrTitulo;
  Linha, rCedente, rCNPJCPF: String;
  rAgencia, rConta,rDigitoConta: String;
  MotivoLinha, I, CodMotivo: Integer;
begin
   ContLinha := 0;

   if (copy(ARetorno.Strings[0],1,3) <> '104') then
      raise Exception.Create(ACBrStr(ACBrBanco.ACBrBoleto.NomeArqRetorno +
                             'não é um arquivo de retorno do '+ Nome));

   rCedente := trim(Copy(ARetorno[0],73,30));
   rAgencia := trim(Copy(ARetorno[0],53,5));
   rConta   := trim(Copy(ARetorno[0],59,5));
   rDigitoConta := Copy(ARetorno[0],64,1);
   ACBrBanco.ACBrBoleto.NumeroArquivo := StrToIntDef(Copy(ARetorno[0], 158, 6), 0);

   ACBrBanco.ACBrBoleto.DataArquivo   := StringToDateTimeDef(Copy(ARetorno[1],192,2)+'/'+
                                                             Copy(ARetorno[1],194,2)+'/'+
                                                             Copy(ARetorno[1],198,2),0, 'DD/MM/YY' );

   if StrToIntDef(Copy(ARetorno[1],200,6),0) <> 0 then
      ACBrBanco.ACBrBoleto.DataCreditoLanc := StringToDateTimeDef(Copy(ARetorno[1],200,2)+'/'+
                                                                  Copy(ARetorno[1],202,2)+'/'+
                                                                  Copy(ARetorno[1],204,4),0, 'DD/MM/YY' );
   rCNPJCPF := trim( Copy(ARetorno[0],19,14)) ;

   if ACBrBanco.ACBrBoleto.Cedente.TipoInscricao = pJuridica then
    begin
      rCNPJCPF := trim( Copy(ARetorno[1],19,15));
      rCNPJCPF := RightStr(rCNPJCPF,14) ;
    end
   else
    begin
      rCNPJCPF := trim( Copy(ARetorno[1],23,11));
      rCNPJCPF := RightStr(rCNPJCPF,11) ;
    end;


   with ACBrBanco.ACBrBoleto do
   begin

      if (not LeCedenteRetorno) and (rCNPJCPF <> OnlyNumber(Cedente.CNPJCPF)) then
         raise Exception.Create(ACBrStr('CNPJ\CPF do arquivo inválido'));

      if (not LeCedenteRetorno) and ((rAgencia <> OnlyNumber(Cedente.Agencia)) or
          (rConta+rDigitoConta  <> OnlyNumber(Cedente.CodigoCedente))) then
         raise Exception.Create(ACBrStr('Agencia\Conta do arquivo inválido'));

      if LeCedenteRetorno then
      begin
         Cedente.Nome    := rCedente;
         Cedente.CNPJCPF := rCNPJCPF;
         Cedente.Agencia := rAgencia;
         Cedente.AgenciaDigito:= '0';
         Cedente.Conta   := rConta;
         Cedente.ContaDigito:= rDigitoConta;
         Cedente.CodigoCedente:= rConta+rDigitoConta;

         case StrToIntDef(Copy(ARetorno[1],18,1),0) of
            1: Cedente.TipoInscricao:= pFisica;
            2: Cedente.TipoInscricao:= pJuridica;
            else
               Cedente.TipoInscricao:= pJuridica;
         end;
      end;

      ACBrBanco.ACBrBoleto.ListadeBoletos.Clear;
   end;

   for ContLinha := 1 to ARetorno.Count - 2 do
   begin
      Linha := ARetorno[ContLinha] ;

      {Segmento T - Só cria após passar pelo seguimento T depois U}
      if Copy(Linha,14,1)= 'T' then
         Titulo := ACBrBanco.ACBrBoleto.CriarTituloNaLista;

      with Titulo do
      begin
         {Segmento T}
         if Copy(Linha,14,1)= 'T' then
          begin
            SeuNumero                   := copy(Linha,59,11);
            NumeroDocumento             := copy(Linha,59,11);
            OcorrenciaOriginal.Tipo     := CodOcorrenciaToTipo(StrToIntDef(copy(Linha,16,2),0));

            //05 = Liquidação Sem Registro
            Vencimento := StringToDateTimeDef( Copy(Linha,74,2)+'/'+
                                               Copy(Linha,76,2)+'/'+
                                               Copy(Linha,80,2),0, 'DD/MM/YY' );

            ValorDocumento       := StrToFloatDef(Copy(Linha,82,15),0)/100;
            ValorDespesaCobranca := StrToFloatDef(Copy(Linha,199,15),0)/100;
            NossoNumero          := Copy(Linha,42,15);  
            Carteira             := Copy(Linha,40,2);
            CodigoLiquidacao     := Copy(Linha,214,02);
            CodigoLiquidacaoDescricao := CodigoLiquidacao_Descricao( StrToIntDef(CodigoLiquidacao,0) );

            // DONE -oJacinto Junior: Implementar a leitura dos motivos das ocorrências.
            MotivoLinha := 214;

            for I := 0 to 4 do
            begin
              CodMotivo := StrToIntDef(IfThen(Copy(Linha, MotivoLinha, 2) = '00', '00', Copy(Linha, MotivoLinha, 2)), 0);

              if CodMotivo <> 0 then
              begin
                MotivoRejeicaoComando.Add(IfThen(Copy(Linha, MotivoLinha, 2) = '00', '00', Copy(Linha, MotivoLinha, 2)));
                DescricaoMotivoRejeicaoComando.Add(CodMotivoRejeicaoToDescricao(OcorrenciaOriginal.Tipo, CodMotivo));
              end;

              MotivoLinha := MotivoLinha + 2; // Incrementa a coluna dos motivos.
            end;
          end
         {Ssegmento U}
         else if Copy(Linha,14,1)= 'U' then
          begin

            if StrToIntDef(Copy(Linha,138,6),0) <> 0 then
               DataOcorrencia := StringToDateTimeDef( Copy(Linha,138,2)+'/'+
                                                      Copy(Linha,140,2)+'/'+
                                                      Copy(Linha,142,4),0, 'DD/MM/YYYY' );

            if StrToIntDef(Copy(Linha,146,6),0) <> 0 then
               DataCredito:= StringToDateTimeDef( Copy(Linha,146,2)+'/'+
                                                  Copy(Linha,148,2)+'/'+
                                                  Copy(Linha,150,4),0, 'DD/MM/YYYY' );

            ValorMoraJuros       := StrToFloatDef(Copy(Linha,18,15),0)/100;
            ValorDesconto        := StrToFloatDef(Copy(Linha,33,15),0)/100;
            ValorAbatimento      := StrToFloatDef(Copy(Linha,48,15),0)/100;
            ValorIOF             := StrToFloatDef(Copy(Linha,63,15),0)/100;
            ValorRecebido        := StrToFloatDef(Copy(Linha,93,15),0)/100;
            ValorOutrasDespesas  := StrToFloatDef(Copy(Linha,108,15),0)/100;
            ValorOutrosCreditos  := StrToFloatDef(Copy(Linha,123,15),0)/100;
         end
        {Segmento W}
        else if Copy(Linha, 14, 1) = 'W' then
         begin
           //verifica o motivo de rejeição
           MotivoRejeicaoComando.Add(copy(Linha,29,2));
           DescricaoMotivoRejeicaoComando.Add(CodMotivoRejeicaoToDescricao(
                                              CodOcorrenciaToTipo(
                                              StrToIntDef(copy(Linha, 16, 2), 0)),
                                              StrToInt(Copy(Linha, 29, 2))));
         end;
      end;
   end;

end;
function TACBrCaixaEconomica.CodOcorrenciaToTipo(
  const CodOcorrencia: Integer): TACBrTipoOcorrencia;
begin
  // DONE -oJacinto Junior: Ajustar para utilizar as ocorrências corretas.
  // TODO -oJacinto Junior: Definir ocorrências pendentes.
  case CodOcorrencia of
//    01: Result := ; // Solicitação de Impressão de Títulos Confirmada
    02: Result := toRetornoRegistroConfirmado;
    03: Result := toRetornoRegistroRecusado;
//    04: Result := ; // Transferência de Carteira/Entrada
//    05: Result := ; // Transferência de Carteira/Baixa
    06: Result := toRetornoLiquidado;
    07: Result := toRetornoRecebimentoInstrucaoConcederDesconto;
    08: Result := toRetornoRecebimentoInstrucaoCancelarDesconto;
    09: Result := toRetornoBaixado;
//    12: Result := toRetornoAbatimentoConcedido;
    12: Result := toRetornoRecebimentoInstrucaoConcederAbatimento;
//    13: Result := toRetornoAbatimentoCancelado;
    13: Result := toRetornoRecebimentoInstrucaoCancelarAbatimento;
//    14: Result := toRetornoVencimentoAlterado;
    14: Result := toRetornoRecebimentoInstrucaoAlterarVencimento;
    19: Result := toRetornoRecebimentoInstrucaoProtestar;
    20: Result := toRetornoRecebimentoInstrucaoSustarProtesto;
    23: Result := toRetornoEntradaEmCartorio;
    24: Result := toRetornoRetiradoDeCartorio;
    25: Result := toRetornoBaixaPorProtesto;
    26: Result := toRetornoInstrucaoRejeitada;
//    27: Result := ; // Confirmação do Pedido de Alteração de Outros Dados
    28: Result := toRetornoDebitoTarifas;
    30: Result := toRetornoAlteracaoOutrosDadosRejeitada;
//    35: Result := ; // Confirmação de Inclusão Banco de Sacado
//    36: Result := ; // Confirmação de Alteração Banco de Sacado
//    37: Result := ; // Confirmação de Exclusão Banco de Sacado
//    38: Result := ; // Emissão de Bloquetos de Banco de Sacado
//    39: Result := ; // Manutenção de Sacado Rejeitada
//    40: Result := ; // Entrada de Título via Banco de Sacado Rejeitada
//    41: Result := ; // Manutenção de Banco de Sacado Rejeitada
    44: Result := toRetornoBaixaOuLiquidacaoEstornada;
    45: Result := toRetornoRecebimentoInstrucaoAlterarDados;
  else
    Result := toRetornoOutrasOcorrencias;
  end;

  // Implementação obsoleta.
  {***
  case CodOcorrencia of
    02: Result := toRetornoRegistroConfirmado;
    03: Result := toRetornoRegistroRecusado;
    06: Result := toRetornoLiquidado;
    12: Result := toRetornoAbatimentoConcedido;
    13: Result := toRetornoAbatimentoCancelado;
    14: Result := toRetornoVencimentoAlterado;
    19: Result := toRetornoRecebimentoInstrucaoProtestar;
    20: Result := toRetornoRecebimentoInstrucaoSustarProtesto;
    26: Result := toRetornoInstrucaoRejeitada;
    28: Result := toRetornoDebitoTarifas;
    30: Result := toRetornoALteracaoOutrosDadosRejeitada;
    45: Result := toRetornoRecebimentoInstrucaoAlterarDados;
  else
    Result := toRetornoOutrasOcorrencias;
  end;
  ***}
end;

function TACBrCaixaEconomica.CodMotivoRejeicaoToDescricao(const TipoOcorrencia: TACBrTipoOcorrencia; CodMotivo: Integer): string;
begin
  // DONE -oJacinto Junior: Ajustar para utilizar as descrições corretas conforme a ocorrência.
  case TipoOcorrencia of
    toRetornoRegistroConfirmado, toRetornoRegistroRecusado,
      toRetornoInstrucaoRejeitada, toRetornoALteracaoOutrosDadosRejeitada:
    case CodMotivo of
      01: Result := '01-Código do Banco Inválido';
      02: Result := '02-Código do Registro Inválido';
      03: Result := '03-Código do Segmento Inválido';
      04: Result := '04-Código do Movimento não Permitido p/ Carteira';
      05: Result := '05-Código do Movimento Inválido';
      06: Result := '06-Tipo Número Inscrição Cedente Inválido';
      07: Result := '07-Agencia/Conta/DV Inválidos';
      08: Result := '08-Nosso Número Inválido';
      09: Result := '09-Nosso Número Duplicado';
      10: Result := '10-Carteira Inválida';
      11: Result := '11-Data de Geração Inválida';
      12: Result := '12-Tipo de Documento Inválido';
      13: Result := '13-Identif. Da Emissão do Bloqueto Inválida';
      14: Result := '14-Identif. Da Distribuição do Bloqueto Inválida';
      15: Result := '15-Características Cobrança Incompatíveis';
      16: Result := '16-Data de Vencimento Inválida';
      17: Result := '17-Data de Vencimento Anterior a Data de Emissão';
      18: Result := '18-Vencimento fora do prazo de operação';
      19: Result := '19-Título a Cargo de Bco Correspondentes c/ Vencto Inferior a XX Dias';
      20: Result := '20-Valor do Título Inválido';
      21: Result := '21-Espécie do Título Inválida';
      22: Result := '22-Espécie do Título Não Permitida para a Carteira';
      23: Result := '23-Aceite Inválido';
      24: Result := '24-Data da Emissão Inválida';
      25: Result := '25-Data da Emissão Posterior a Data de Entrada';
      26: Result := '26-Código de Juros de Mora Inválido';
      27: Result := '27-Valor/Taxa de Juros de Mora Inválido';
      28: Result := '28-Código do Desconto Inválido';
      29: Result := '29-Valor do Desconto Maior ou Igual ao Valor do Título';
      30: Result := '30-Desconto a Conceder Não Confere';
      31: Result := '31-Concessão de Desconto - Já Existe Desconto Anterior';
      32: Result := '32-Valor do IOF Inválido';
      33: Result := '33-Valor do Abatimento Inválido';
      34: Result := '34-Valor do Abatimento Maior ou Igual ao Valor do Título';
      35: Result := '35-Valor Abatimento a Conceder Não Confere';
      36: Result := '36-Concessão de Abatimento - Já Existe Abatimento Anterior';
      37: Result := '37-Código para Protesto Inválido';
      38: Result := '38-Prazo para Protesto Inválido';
      39: Result := '39-Pedido de Protesto Não Permitido para o Título';
      40: Result := '40-Título com Ordem de Protesto Emitida';
      41: Result := '41-Pedido Cancelamento/Sustação p/ Títulos sem Instrução Protesto';
      42: Result := '42-Código para Baixa/Devolução Inválido';
      43: Result := '43-Prazo para Baixa/Devolução Inválido';
      44: Result := '44-Código da Moeda Inválido';
      45: Result := '45-Nome do Sacado Não Informado';
      46: Result := '46-Tipo/Número de Inscrição do Sacado Inválidos';
      47: Result := '47-Endereço do Sacado Não Informado';
      48: Result := '48-CEP Inválido';
      49: Result := '49-CEP Sem Praça de Cobrança (Não Localizado)';
      50: Result := '50-CEP Referente a um Banco Correspondente';
      51: Result := '51-CEP incompatível com a Unidade da Federação';
      52: Result := '52-Unidade da Federação Inválida';
      53: Result := '53-Tipo/Número de Inscrição do Sacador/Avalista Inválidos';
      54: Result := '54-Sacador/Avalista Não Informado';
      55: Result := '55-Nosso número no Banco Correspondente Não Informado';
      56: Result := '56-Código do Banco Correspondente Não Informado';
      57: Result := '57-Código da Multa Inválido';
      58: Result := '58-Data da Multa Inválida';
      59: Result := '59-Valor/Percentual da Multa Inválido';
      60: Result := '60-Movimento para Título Não Cadastrado. Erro genérico para as situações:' + #13#10
                      + '"Cedente não cadastrado" ou' + #13#10
                      + '"Agência Cedente não cadastrada ou desativada"';
      61: Result := '61-Alteração da Agência Cobradora/DV Inválida';
      62: Result := '62-Tipo de Impressão Inválido';
      63: Result := '63-Entrada para Título já Cadastrado';
      64: Result := '64-Entrada Inválida para Cobrança Caucionada';
      65: Result := '65-CEP do Sacado não encontrado';
      66: Result := '66-Agencia Cobradora não encontrada';
      67: Result := '67-Agencia Cedente não encontrada';
      68: Result := '68-Movimentação inválida para título';
      69: Result := '69-Alteração de dados inválida';
      70: Result := '70-Apelido do cliente não cadastrado';
      71: Result := '71-Erro na composição do arquivo';
      72: Result := '72-Lote de serviço inválido';
      73: Result := '73-Código do Cedente inválido';
      74: Result := '74-Cedente não pertencente a Cobrança Eletrônica';
      75: Result := '75-Nome da Empresa inválido';
      76: Result := '76-Nome do Banco inválido';
      77: Result := '77-Código da Remessa inválido';
      78: Result := '78-Data/Hora Geração do arquivo inválida';
      79: Result := '79-Número Sequencial do arquivo inválido';
      80: Result := '80-Versão do Lay out do arquivo inválido';
      81: Result := '81-Literal REMESSA-TESTE - Válido só p/ fase testes';
      82: Result := '82-Literal REMESSA-TESTE - Obrigatório p/ fase testes';
      83: Result := '83-Tp Número Inscrição Empresa inválido';
      84: Result := '84-Tipo de Operação inválido';
      85: Result := '85-Tipo de serviço inválido';
      86: Result := '86-Forma de lançamento inválido';
      87: Result := '87-Número da remessa inválido';
      88: Result := '88-Número da remessa menor/igual remessa anterior';
      89: Result := '89-Lote de serviço divergente';
      90: Result := '90-Número sequencial do registro inválido';
      91: Result := '91-Erro seq de segmento do registro detalhe';
      92: Result := '92-Cod movto divergente entre grupo de segm';
      93: Result := '93-Qtde registros no lote inválido';
      94: Result := '94-Qtde registros no lote divergente';
      95: Result := '95-Qtde lotes no arquivo inválido';
      96: Result := '96-Qtde lotes no arquivo divergente';
      97: Result := '97-Qtde registros no arquivo inválido';
      98: Result := '98-Qtde registros no arquivo divergente';
      99: Result := '99-Código de DDD inválido';
    else
      Result := IntToStrZero(CodMotivo, 2) + ' - Outros Motivos';
    end;

    toRetornoDebitoTarifas:
    case CodMotivo of
      01: Result := '01-Tarifa de Extrato de Posição';
      02: Result := '02-Tarifa de Manutenção de Título Vencido';
      03: Result := '03-Tarifa de Sustação';
      04: Result := '04-Tarifa de Protesto';
      05: Result := '05-Tarifa de Outras Instruções';
      06: Result := '06-Tarifa de Outras Ocorrências';
      07: Result := '07-Tarifa de Envio de Duplicata ao Sacado';
      08: Result := '08-Custas de Protesto';
      09: Result := '09-Custas de Sustação de Protesto';
      10: Result := '10-Custas de Cartório Distribuidor';
      11: Result := '11-Custas de Edital';
      12: Result := '12-Redisponibilização de Arquivo Retorno Eletrônico';
      13: Result := '13-Tarifa Sobre Registro Cobrada na Baixa/Liquidação';
      14: Result := '14-Tarifa Sobre Reapresentação Automática';
      15: Result := '15-Banco de Sacados';
      16: Result := '16-Tarifa Sobre Informações Via Fax';
      17: Result := '17-Entrega Aviso Disp Bloqueto via e-amail ao sacado (s/ emissão Bloqueto)';
      18: Result := '18-Emissão de Bloqueto Pré-impresso CAIXA matricial';
      19: Result := '19-Emissão de Bloqueto Pré-impresso CAIXA A4';
      20: Result := '20-Emissão de Bloqueto Padrão CAIXA';
      21: Result := '21-Emissão de Bloqueto/Carnê';
      31: Result := '31-Emissão de Aviso de Vencido';
      42: Result := '42-Alteração cadastral de dados do título - sem emissão de aviso';
      45: Result := '45-Emissão de 2ª via de Bloqueto Cobrança Registrada';
    else
      Result := IntToStrZero(CodMotivo, 2) + ' - Outros Motivos';
    end;

    toRetornoLiquidado, toRetornoBaixado:
    case CodMotivo of
      02: Result := '02-Casa Lotérica';
      03: Result := '03-Agências CAIXA';
      04: Result := '04-Compensação Eletrônica';
      05: Result := '05-Compensação Convencional';
      06: Result := '06-Internet Banking';
      07: Result := '07-Correspondente Bancário';
      08: Result := '08-Em Cartório';
      09: Result := '09-Comandada Banco';
      10: Result := '10-Comandada Cliente via Arquivo';
      11: Result := '11-Comandada Cliente On-line';
      12: Result := '12-Decurso Prazo - Cliente';
      13: Result := '13-Decurso Prazo - Banco';
      14: Result := '14-Protestado';
    else
      Result := IntToStrZero(CodMotivo, 2) + ' - Outros Motivos';
    end;
  end;

  {***
  case TipoOcorrencia of
    toRetornoRegistroConfirmado,
      toRetornoRegistroRecusado,
      toRetornoInstrucaoRejeitada,
      toRetornoALteracaoOutrosDadosRejeitada:
      case CodMotivo of
        01: Result := '01-Código do banco inválido';
        02: Result := '02-Código do registro inválido';
        03: Result := '03-Código do segmento inválido';
        05: Result := '05-Código de movimento inválido';
        06: Result := '06-Tipo/número de inscrição do cedente inválido';
        07: Result := '07-Agência/Conta/DV inválido';
        08: Result := '08-Nosso número inválido';
        09: Result := '09-Nosso número duplicado';
        10: Result := '10-Carteira inválida';
        11: Result := '11-Forma de cadastramento do título inválido';
        12: Result := '12-Tipo de documento inválido';
        13: Result := '13-Identificação da emissão do bloqueto inválida';
        14: Result := '14-Identificação da distribuição do bloqueto inválida';
        15: Result := '15-Características da cobrança incompatíveis';
        16: Result := '16-Data de vencimento inválida';
        20: Result := '20-Valor do título inválido';
        21: Result := '21-Espécie do título inválida';
        23: Result := '23-Aceite inválido';
        24: Result := '24-Data da emissão inválida';
        26: Result := '26-Código de juros de mora inválido';
        27: Result := '27-Valor/Taxa de juros de mora inválido';
        28: Result := '28-Código do desconto inválido';
        29: Result := '29-Valor do desconto maior ou igual ao valor do título';
        30: Result := '30-Desconto a conceder não confere';
        32: Result := '32-Valor do IOF inválido';
        33: Result := '33-Valor do abatimento inválido';
        37: Result := '37-Código para protesto inválido';
        38: Result := '38-Prazo para protesto inválido';
        40: Result := '40-Título com ordem de protesto emitida';
        42: Result := '42-Código para baixa/devolução inválido';
        43: Result := '43-Prazo para baixa/devolução inválido';
        44: Result := '44-Código da moeda inválido';
        45: Result := '45-Nome do sacado não informado';
        46: Result := '46-Tipo/número de inscrição do sacado inválido';
        47: Result := '47-Endereço do sacado não informado';
        48: Result := '48-CEP inválido';
        49: Result := '49-CEP sem praça de cobrança (não localizado)';
        52: Result := '52-Unidade da federação inválida';
        53: Result := '53-Tipo/número de inscrição do sacador/avalista inválido';
        57: Result := '57-Código da multa inválido';
        58: Result := '58-Data da multa inválida';
        59: Result := '59-Valor/Percentual da multa inválido';
        60: Result := '60-Movimento para título não cadastrado. Erro genérico para as situações:' + #13#10 +
          '“Cedente não cadastrado” ou' + #13#10 +
            '“Agência Cedente não cadastrada ou desativada”';
        61: Result := '61-Agência cobradora inválida';
        62: Result := '62-Tipo de impressão inválido';
        63: Result := '63-Entrada para título já cadastrado';
        68: Result := '68-Movimentação inválida para o título';
        69: Result := '69-Alteração de dados inválida';
        70: Result := '70-Apelido do cliente não cadastrado';
        71: Result := '71-Erro na composição do arquivo';
        72: Result := '72-Lote de serviço inválido';
        73: Result := '73-Código do cedente inválido';
        74: Result := '74-Cedente não pertence a cobrança eletrônica/apelido não confere com cedente';
        75: Result := '75-Nome da empresa inválido';
        76: Result := '76-Nome do banco inválido';
        77: Result := '77-Código da remessa inválido';
        78: Result := '78-Data/Hora de geração do arquivo inválida';
        79: Result := '79-Número seqüencial do arquivo inválido';
        80: Result := '80-Número da versão do Layout do arquivo/lote inválido';
        81: Result := '81-Literal ‘REMESSA-TESTE’ válida somente para fase de testes';
        82: Result := '82-Literal ‘REMESSA-TESTE’ obrigatório para fase de testes';
        83: Result := '83-Tipo/número de inscrição da empresa inválido';
        84: Result := '84-Tipo de operação inválido';
        85: Result := '85-Tipo de serviço inválido';
        86: Result := '86-Forma de lançamento inválido';
        87: Result := '87-Número da remessa inválido';
        88: Result := '88-Número da remessa menor/igual que da remessa anterior';
        89: Result := '89-Lote de serviço divergente';
        90: Result := '90-Número seqüencial do registro inválido';
        91: Result := '91-Erro na seqüência de segmento do registro detalhe';
        92: Result := '92-Código de movimento divergente entre grupo de segmentos';
        93: Result := '93-Quantidade de registros no lote inválido';
        94: Result := '94-Quantidade de registros no lote divergente';
        95: Result := '95-Quantidade de lotes do arquivo inválido';
        96: Result := '96-Quantidade de lotes no arquivo divergente';
        97: Result := '97-Quantidade de registros no arquivo inválido';
        98: Result := '98-Quantidade de registros no arquivo divergente';
        99: Result := '99-Código de DDD inválido';
      else
        Result := IntToStrZero(CodMotivo, 2) + ' - Outros Motivos';
      end;
    toRetornoDebitoTarifas:
      case CodMotivo of
        01: Result := '01-Tarifa de Extrato de Posição';
        02: Result := '02-Tarifa de Manutenção de Título Vencido';
        03: Result := '03-Tarifa de Sustação';
        04: Result := '04-Tarifa de Protesto';
        05: Result := '05-Tarifa de Outras Instruções';
        06: Result := '06-Tarifa de Outras Ocorrências';
        07: Result := '07-Tarifa de Envio de Duplicata ao Sacado';
        08: Result := '08-Custas de Protesto';
        09: Result := '09-Custas de Sustação de Protesto';
        10: Result := '10-Custas de Cartório Distribuidor';
        11: Result := '11-Custas de Edital';
        12: Result := '12-Redisponibilização de Arquivo Retorno Eletrônico';
        13: Result := 'Tarifa Sobre Registro Cobrada na Baixa/Liquidação';
        14: Result := 'Tarifa Sobre Reapresentação Automática';
        15: Result := 'Banco de Sacados';
        16: Result := 'Tarifa Sobre Informações Via Fax';
        17: Result := 'Entrega Aviso Disp Bloqueto via e-amail ao sacado (s/ emissão Bloqueto)';
        18: Result := 'Emissão de Bloqueto Pré-impresso CAIXA matricial';
        19: Result := 'Emissão de Bloqueto Pré-impresso CAIXA A4';
        20: Result := 'Emissão de Bloqueto Padrão CAIXA';
      end;
  end;
  ***}
end;

function TACBrCaixaEconomica.TipoOcorrenciaToDescricao(const TipoOcorrencia: TACBrTipoOcorrencia): String;
var
  CodOcorrencia: Integer;
begin
  // DONE -oJacinto Junior: Ajustar para utilizar as ocorrências e descrições corretas.
  CodOcorrencia := StrToIntDef(TipoOCorrenciaToCod(TipoOcorrencia),0);
  case CodOcorrencia of
    01: Result := '01-Solicitação de Impressão de Títulos Confirmada';
    02: Result := '02-Entrada Confirmada';
    03: Result := '03-Entrada Rejeitada';
    04: Result := '04-Transferência de Carteira/Entrada';
    05: Result := '05-Transferência de Carteira/Baixa';
    06: Result := '06-Liquidação';
    07: Result := '07-Confirmação do Recebimento da Instrução de Desconto';
    08: Result := '08-Confirmação do Recebimento do Cancelamento do Desconto';
    09: Result := '09-Baixa';
    12: Result := '12-Confirmação Recebimento Instrução de Abatimento';
    13: Result := '13-Confirmação Recebimento Instrução de Cancelamento Abatimento';
    14: Result := '14-Confirmação Recebimento Instrução Alteração deVencimento';
    19: Result := '19-Confirmação Recebimento Instrução de Protesto';
    20: Result := '20-Confirmação Recebimento Instrução de Sustação/Cancelamento de Protesto';
    23: Result := '23-Remessa a Cartório';
    24: Result := '24-Retirada de Cartório';
    25: Result := '25-Protestado e Baixado (Baixa por Ter Sido Protestado)';
    26: Result := '26-Instrução Rejeitada';
    27: Result := '27-Confirmação do Pedido de Alteração de Outros Dados';
    28: Result := '28-Débito de Tarifas/Custas';
    30: Result := '30-Alteração de Dados Rejeitada';
    35: Result := '35-Confirmação de Inclusão Banco de Sacado';
    36: Result := '36-Confirmação de Alteração Banco de Sacado';
    37: Result := '37-Confirmação de Exclusão Banco de Sacado';
    38: Result := '38-Emissão de Bloquetos de Banco de Sacado';
    39: Result := '39-Manutenção de Sacado Rejeitada';
    40: Result := '40-Entrada de Título via Banco de Sacado Rejeitada';
    41: Result := '41-Manutenção de Banco de Sacado Rejeitada';
    44: Result := '44-Estorno de Baixa / Liquidação';
    45: Result := '45-Alteração de Dados';
    
    // Implementação obsoleta.
    {***
    02: Result := '02-Entrada Confirmada';
    03: Result := '03-Entrada Rejeitada';
    04: Result := '04-Transferência de Carteira/Entrada';
    05: Result := '05-Transferência de Carteira/Baixa';
    06: Result := '06-Liquidação';
    09: Result := '09-Baixa';
    12: Result := '12-Confirmação Recebimento Instrução de Abatimento';
    13: Result := '13-Confirmação Recebimento Instrução de Cancelamento Abatimento';
    14: Result := '14-Confirmação Recebimento Instrução Alteração de Vencimento';
    17: Result := '17-Liquidação Após Baixa ou Liquidação Título Não Registrado';
    19: Result := '19-Confirmação Recebimento Instrução de Protesto';
    20: Result := '20-Confirmação Recebimento Instrução de Sustação/Cancelamento de Protesto';
    23: Result := '23-Remessa a Cartório (Aponte em Cartório)';
    24: Result := '24-Retirada de Cartório e Manutenção em Carteira';
    25: Result := '25-Protestado e Baixado (Baixa por Ter Sido Protestado)';
    26: Result := '26-Instrução Rejeitada';
    27: Result := '27-Confirmação do Pedido de Alteração de Outros Dados';
    28: Result := '28-Débito de Tarifas/Custas';
    30: Result := '30-Alteração de Dados Rejeitada';
    36: Result := '36-Confirmação de envio de e-mail/SMS';
    37: Result := '37-Envio de e-mail/SMS rejeitado';
    43: Result := '43-Estorno de Protesto/Sustação';
    44: Result := '44-Estorno de Baixa/Liquidação';
    45: Result := '45-Alteração de dados';
    51: Result := '51-Título DDA reconhecido pelo sacado';
    52: Result := '52-Título DDA não reconhecido pelo sacado';
    53: Result := '53-Título DDA recusado pela CIP';
    ***}
  end;
end;

function TACBrCaixaEconomica.CodigoLiquidacao_Descricao(CodLiquidacao: Integer): String;
begin
  case CodLiquidacao of
    02 : result := 'Casa Lotérica';
    03 : result := 'Agências CAIXA';
    04 : result := 'Compensação Eletrônica';
    05 : result := 'Compensação Convencional';
    06 : result := 'Internet Banking';
    07 : result := 'Correspondente Bancário';
    08 : result := 'Em Cartório'
  end;
end;

end.
