{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2022 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:   Daniel de Morais InfoCotidiano                }
{                                                                              }
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

unit ACBrETQTspl;

interface

uses
  Classes,
  ACBrETQClass, ACBrDevice
  {$IFDEF NEXTGEN}
   ,ACBrBase
  {$ENDIF};

type

  { TACBrETQTspl }

  TACBrETQTspl = class(TACBrETQClass)
  private
    function ConverterOrientacao(aOrientacao: TACBrETQOrientacao): String;
    function ConverterMultiplicador(aMultiplicador: Integer): String;
    function ConverterCoordenadas(aVertical, aHorizontal: Integer): String;
    function ConverterFonte(const aFonte: String; var aTexto: String): String;
    function ConverterReverso(aImprimirReverso: Boolean; aHorizontal, aVertical, aLarguraTexto, aAlturaTexto: integer): String;
    function ConverterLarguraBarras(aBarraLarga, aBarraFina: Integer): String;
    function ConverterUnidadeAlturaBarras(aAlturaBarras: Integer): String;
    function ConverterPaginaDeCodigo(aPaginaDeCodigo: TACBrETQPaginaCodigo): String;

    function FormatarTexto(const aTexto: String): String;

    procedure VerificarTipoBarras(const aTipo: String; aBarraFina: Integer);

    function ConverterExibeCodigo(aExibeCodigo: TACBrETQBarraExibeCodigo): String;

    function CalcularEspessuraLinha(aVertical, aHorizontal: Integer): String;

    function AjustarNomeArquivoImagem( const aNomeImagem: String): String;
    function AlturaFonteEmDots(const aFonte: string; aMultVertical: Integer): Integer;
    function ComprimentoTextoEmDots(const aTexto, aFonte: string; aMultHorizontal: Integer): Integer;

  public
    constructor Create(AOwner: TComponent);

    function ComandoLimparMemoria: AnsiString; override;
    function ComandoAbertura: AnsiString; override;
    function ComandoGuilhotina: AnsiString; override;
    function ComandoBackFeed: AnsiString; override;
    function ComandoTemperatura: AnsiString; override;
    function ComandoPaginaDeCodigo: AnsiString; override;
    function ComandoOrigemCoordenadas: AnsiString; override;
    function ComandoVelocidade: AnsiString; override;

    function ComandoCopias(const NumCopias: Integer): AnsiString; override;

    function ComandoImprimirTexto(aOrientacao: TACBrETQOrientacao; aFonte: String;
      aMultHorizontal, aMultVertical, aVertical, aHorizontal: Integer; aTexto: String;
      aSubFonte: Integer = 0; aImprimirReverso: Boolean = False): AnsiString; override;

    function ConverterTipoBarras(TipoBarras: TACBrTipoCodBarra): String; override;

    function ComandoImprimirBarras(aOrientacao: TACBrETQOrientacao; aTipoBarras: String;
      aBarraLarga, aBarraFina, aVertical, aHorizontal: Integer; aTexto: String;
      aAlturaBarras: Integer; aExibeCodigo: TACBrETQBarraExibeCodigo = becPadrao
      ): AnsiString; override;

    function ComandoImprimirQRCode(aVertical, aHorizontal: Integer;
      const aTexto: String; aLarguraModulo: Integer; aErrorLevel: Integer;
      aTipo: Integer): AnsiString; override;

    function ComandoImprimirLinha(aVertical, aHorizontal, aLargura, aAltura: Integer
      ): AnsiString; override;

    function ComandoImprimirCaixa(aVertical, aHorizontal, aLargura, aAltura,
      aEspVertical, aEspHorizontal: Integer; aCanto: Integer = 0): AnsiString; override;

    function ComandoImprimirImagem(aMultImagem, aVertical, aHorizontal: Integer;
      aNomeImagem: String): AnsiString; override;
    function ComandoCarregarImagem(aStream: TStream; var aNomeImagem: String;
      aFlipped: Boolean; aTipo: String): AnsiString; override;
    function ComandoApagarImagem(const aNomeImagem: String = '*'): String; override;
  end;

implementation

uses
  math, SysUtils,
  {$IFDEF COMPILER6_UP} StrUtils {$ELSE} ACBrD5, Windows{$ENDIF},
  ACBrImage, ACBrConsts, synautil,
  ACBrUtil.Compatibilidade, ACBrUtil.Strings, ACBrUtil.Math;

{ TACBrETQTspl }

constructor TACBrETQTspl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Unidade := etqMilimetros;

  fpModeloStr    := 'TSPL';
  fpLimiteCopias := 65535;
end;

function TACBrETQTspl.FormatarTexto(const aTexto: String): String;
begin
  Result := aTexto;
  if Pos('\["]', Result) = 0 then   // verifica se o usuario mandou aspas formatado conforme manual
  begin
    Result := StringReplace(Result, '"', '\["]', [rfReplaceAll]);
  end;

  Result := '"' + Result + '"';
end;

function TACBrETQTspl.ConverterFonte(const aFonte: String; var aTexto: String
  ): String;
var
  cFonte: Char;
begin
  {Nem todas as fontes estão disponíveis para todos modelos, vide manual pagina 65}
  cFonte := PadLeft(aFonte,1,'3')[1];

  if not CharInSet(cFonte, ['0'..'8']) then
    raise Exception.Create('Fonte deve ser de "0" a "8"');

  Result := cFonte;
end;

function TACBrETQTspl.ConverterMultiplicador(aMultiplicador: Integer): String;
begin
  Result := '1';
  if (aMultiplicador < 1) or (aMultiplicador > 10) then
    raise Exception.Create('Multiplicador deve ser de 1 a 10');

  Result := IntToStr(aMultiplicador);
end;

function TACBrETQTspl.CalcularEspessuraLinha(aVertical, aHorizontal: Integer
  ): String;
var
  LEspessura: Integer;
begin
  Result := EmptyStr;
  LEspessura := Max(aHorizontal, aVertical);
  LEspessura := ConverterUnidade(etqDots, LEspessura);
  Result := IntToStr(max(LEspessura,1));
end;

function TACBrETQTspl.AjustarNomeArquivoImagem(const aNomeImagem: String): String;
begin
  Result := EmptyStr;
  Result := UpperCase(LeftStr(OnlyAlphaNum(aNomeImagem), 8));
end;

function TACBrETQTspl.ConverterUnidadeAlturaBarras(aAlturaBarras: Integer
  ): String;
begin
  Result := EmptyStr;
  Result := IntToStr(ConverterUnidade(etqDots, aAlturaBarras));
end;

function TACBrETQTspl.ConverterPaginaDeCodigo(
  aPaginaDeCodigo: TACBrETQPaginaCodigo): String;
begin
  Result := EmptyStr;
  {as páginas de código do Windows (1250 e 1252) são suportadas exclusivamente em impressoras com a linguagem TSPL2}
  case aPaginaDeCodigo of
    pce437 : Result := '437';
    pce850 : Result := '850';
    pce852 : Result := '852';
    pce860 : Result := '860';
    pce1250: Result := '1250';
    pce1252: Result := '1252';
  else
    Result := '437'; // existem diversos modelos, a mais comum é 437
  end;
end;

function TACBrETQTspl.ConverterOrientacao(aOrientacao: TACBrETQOrientacao
  ): String;
begin
  Result := '0';
  case aOrientacao of
    or270: Result := '270';
    or180: Result := '180';
    or90:  Result := '90';
  end;
end;

procedure TACBrETQTspl.VerificarTipoBarras(const aTipo: String; aBarraFina: Integer);
var
  LMinBarraFina, LMaxBarraFina: Integer;
begin
  LMinBarraFina := 1;
  LMaxBarraFina := 10;

  if (pos(aTipo, 'CODE128;CODE128M;EAN128;CODE39;CODE39C;CODE39S;CODE93;CODE93EXT') > 0) then
  begin
    LMinBarraFina := 2;
    LMaxBarraFina := 4;
    if aTipo = 'CODE128M' then
      LMinBarraFina := 3;
  end;

  if (aBarraFina < LMinBarraFina) or (aBarraFina > LMaxBarraFina) then
    raise Exception.CreateFmt('Barra Fina para o Cod.Barras %s deve ser de %d a %d',
                              [aTipo, LMinBarraFina, LMaxBarraFina]);
end;

function TACBrETQTspl.ConverterExibeCodigo(
  aExibeCodigo: TACBrETQBarraExibeCodigo): String;
begin
  Result := '0';
  if (aExibeCodigo = becSIM) then
    Result := '1';
end;

function TACBrETQTspl.ConverterLarguraBarras(aBarraLarga, aBarraFina: Integer): String;
begin
  Result := EmptyStr;
  if (aBarraFina < 1) or (aBarraFina > 10) then
    raise Exception.Create('Barra Fina deve ser de 1 a 10');

  if (aBarraLarga < 2) or (aBarraLarga > 30) then
    raise Exception.Create('Barra Larga deve ser de 2 a 30');

  if (aBarraFina > aBarraLarga) then
    raise Exception.Create('Barra Fina deve ser inferior ou Igual a Barra Larga');

  Result := IntToStr(aBarraFina) + ',' + IntToStr(aBarraLarga);
end;

function TACBrETQTspl.ConverterReverso(aImprimirReverso: Boolean; aHorizontal, aVertical, aLarguraTexto, aAlturaTexto:integer): String;
begin
  Result := EmptyStr;
  If aImprimirReverso then
     begin

      Result :=  LF+'REVERSE ' +
            IntToStr(aHorizontal) + ',' +
            IntToStr(aVertical) + ',' +
            IntToStr(aLarguraTexto) + ',' +
            IntToStr(aAlturaTexto);
     end;
end;

function TACBrETQTspl.ComandoOrigemCoordenadas: AnsiString;
begin
  if (Origem = ogTop) then
    Result := 'DIRECTION 0'
  else
    Result := 'DIRECTION 1';
end;

function TACBrETQTspl.ComandoLimparMemoria: AnsiString;
begin
  Result := 'CLS';
end;

function TACBrETQTspl.ComandoTemperatura: AnsiString;
begin
  Result := EmptyStr;

  if (Temperatura < 0) or (Temperatura > 15) then
    raise Exception.Create('Temperatura deve ser de 0 a 15');

  Result := 'DENSITY ' + IntToStr(Temperatura);
end;

function TACBrETQTspl.ComandoPaginaDeCodigo: AnsiString;
var
  APagCod: String;
begin
  Result := EmptyStr;
  APagCod := ConverterPaginaDeCodigo(PaginaDeCodigo);
  if (APagCod <> '') then
    Result := 'CODEPAGE '+APagCod
end;

function TACBrETQTspl.ComandoVelocidade: AnsiString;
begin
  Result := EmptyStr;

  if Velocidade <= 0 then
    Exit;

  case Velocidade of
    1,2,3,4,5,6,8,10,12:
      Result := 'SPEED ' + IntToStr(Velocidade);
  else
    raise Exception.Create(
      'Velocidade inválida. Valores permitidos: 1,2,3,4,5,6,8,10,12'
    );
  end;
end;

function TACBrETQTspl.ComandoCopias(const NumCopias: Integer): AnsiString;
begin
  inherited ComandoCopias(NumCopias);
  Result := 'PRINT ' + IntToStr(NumCopias);
end;

function TACBrETQTspl.ComandoBackFeed: AnsiString;
begin
  case BackFeed of
    bfOn : Result := 'SET BACK ON';
    bfOff: Result := 'SET BACK OFF';
  else
    Result := EmptyStr;
  end;
end;

function TACBrETQTspl.ComandoAbertura: AnsiString;
begin
  Result := 'SHIFT 0';

  // removido autodectec para evitar pular etiquetas  , pois ele vai detectar tamanho etiqueta
  // Result := 'AUTODETECT';

end;

function TACBrETQTspl.ComandoGuilhotina: AnsiString;
begin
  if Guilhotina then
    Result := 'SET CUTTER BATCH'  // Set printer to cut label at the end of printing job.
  else
    Result := 'SET CUTTER OFF';  // Disable cutter function
end;

function TACBrETQTspl.ComandoImprimirTexto(aOrientacao: TACBrETQOrientacao;
  aFonte: String; aMultHorizontal, aMultVertical, aVertical,
  aHorizontal: Integer; aTexto: String; aSubFonte: Integer;
  aImprimirReverso: Boolean): AnsiString;

var
  LLarguraTexto, LAlturaTexto: Integer;
  LCoordenadaHorizontal, LCoordenadaVertical: Integer;
begin
  // Coordenadas base
  LCoordenadaHorizontal := ConverterUnidade(etqDots, aHorizontal);
  LCoordenadaVertical   := ConverterUnidade(etqDots, aVertical);

  // Calcula dimensões do texto (em DOTS)
  LLarguraTexto := ComprimentoTextoEmDots(aTexto, aFonte, aMultHorizontal);
  LAlturaTexto  := AlturaFonteEmDots(aFonte, aMultVertical);

  // Ajustes finos do REVERSE (aproximadamente)
  Dec(LCoordenadaHorizontal, 3);
  Dec(LCoordenadaVertical, 1);
  Inc(LLarguraTexto, 8);
  Inc(LAlturaTexto, 3);

  // TEXT primeiro (conforme manual TSPL)
  Result := 'TEXT ' +
            IntToStr(ConverterUnidade(etqDots, aHorizontal)) + ',' +
            IntToStr(ConverterUnidade(etqDots, aVertical))   + ',' +
            '"' + ConverterFonte(aFonte, aTexto) + '"'       + ',' +
            ConverterOrientacao(aOrientacao)                 + ',' +
            ConverterMultiplicador(aMultHorizontal)          + ',' +
            ConverterMultiplicador(aMultVertical)            + ',' +
            FormatarTexto(aTexto) +
            ConverterReverso(aImprimirReverso, LCoordenadaHorizontal, LCoordenadaVertical, LLarguraTexto, LAlturaTexto); // Reverse deve se impresso apos o Texto
end;


function TACBrETQTspl.ConverterTipoBarras(TipoBarras: TACBrTipoCodBarra
  ): String;
begin
  Result := EmptyStr;
  case TipoBarras of
    barEAN13      : Result := 'EAN13';
    barEAN8       : Result := 'EAN8';
    barINTERLEAVED: Result := '25';
    barCODE128    : Result := '128';
    barCODE39     : Result := '39';
    barCODE93     : Result := '99';
    barUPCA       : Result := 'UPCA';
    barCODABAR    : Result := 'CODA';
    barMSI        : Result := 'MSI';
  end;
end;

function TACBrETQTspl.ComandoImprimirBarras(aOrientacao: TACBrETQOrientacao;
  aTipoBarras: String; aBarraLarga, aBarraFina, aVertical,
  aHorizontal: Integer; aTexto: String; aAlturaBarras: Integer;
  aExibeCodigo: TACBrETQBarraExibeCodigo): AnsiString;
begin
  VerificarTipoBarras(aTipoBarras, aBarraFina);

  Result := 'BARCODE ' +                                              // Barcode
            ConverterCoordenadas(aVertical, aHorizontal)    + ',' +   // Coordenadas Horizontal x Vertical
            '"'+aTipoBarras+'"'                             + ',' +   // Tipo Barras
            ConverterUnidadeAlturaBarras(aAlturaBarras)     + ',' +   // Altura
            ConverterExibeCodigo(aExibeCodigo)              + ',' +   // Exibe Codigo (human readable)
            ConverterOrientacao(aOrientacao)                + ',' +   // Rotacao
            ConverterLarguraBarras(aBarraLarga, aBarraFina) + ',' +   // Barra fina, Barra Larga
            FormatarTexto(aTexto);                                    // Texto
end;

function TACBrETQTspl.ComandoImprimirQRCode(aVertical, aHorizontal: Integer;
  const aTexto: String; aLarguraModulo: Integer; aErrorLevel: Integer;
  aTipo: Integer): AnsiString;
begin

 // QRCODE X  , Y, ECC Level, cell width, mode, rotation, [model, mask,]"Data string"
 // QRCODE 100,10, L        ,7          ,M    ,0          ,M1   ,S1    ,"ATHE FIRMWARE HAS BEEN UPDATED"
  result := 'QRCODE ' +                                          // qrcode
            ConverterCoordenadas(aVertical, aHorizontal) + ',' + //  X, Y,
            '7' + ',' +                                          // ECC Level
            IntToStr(aLarguraModulo) + ',' +                     //c ell width
            'A' + ',' +                                          // mode  A = Auto / manual encode
            '0' + ',' +                                          // rotation
            FormatarTexto(aTexto);                               // text
end;

function TACBrETQTspl.ComandoImprimirLinha(aVertical, aHorizontal, aLargura,
  aAltura: Integer): AnsiString;
begin
  Result := 'BAR' +
            ConverterCoordenadas(aVertical, aHorizontal) + ',' +
            ConverterCoordenadas(aAltura, aLargura);
end;

function TACBrETQTspl.ComandoImprimirCaixa(aVertical, aHorizontal, aLargura,
  aAltura, aEspVertical, aEspHorizontal: Integer; aCanto: Integer): AnsiString;
begin
  Result := 'BOX ' +
            ConverterCoordenadas(aVertical, aHorizontal)     + ',' +
            ConverterCoordenadas(aVertical+aAltura, aHorizontal+aLargura)  + ',' +
            CalcularEspessuraLinha(aEspVertical, aEspHorizontal);
end;

function TACBrETQTspl.ComandoImprimirImagem(aMultImagem, aVertical,
  aHorizontal: Integer; aNomeImagem: String): AnsiString;
begin
  Result := 'PUTPCX' +
            ConverterCoordenadas(aVertical, aHorizontal) + ',' +
            '"' + AjustarNomeArquivoImagem(aNomeImagem)+ '"';
end;

function TACBrETQTspl.ComandoCarregarImagem(aStream: TStream;
  var aNomeImagem: String; aFlipped: Boolean; aTipo: String): AnsiString;
var
  ImgData: AnsiString;
begin
  Result := EmptyStr;

  if (aTipo = '') then
     aTipo := 'PCX'
  else
    aTipo := UpperCase(RightStr(aTipo, 3));

  if (aTipo <> 'PCX') or (not IsPCX(aStream, True)) then
    raise Exception.Create(ACBrStr(cErrImgNotPCXMono));

  aStream.Position := 0;
  ImgData := ReadStrFromStream(aStream, aStream.Size);
  aNomeImagem := AjustarNomeArquivoImagem(aNomeImagem);

  Result := 'KILL F,"' + aNomeImagem + '"' + LF +      // Delete the specify file in FLASH.
            'DOWNLOAD F,"' + aNomeImagem + '",' + IntToStr(aStream.Size) + ',' + ImgData + LF;
end;

function TACBrETQTspl.ComandoApagarImagem(const aNomeImagem: String): String;
var
  LNomeImagem: String;
begin
  Result := EmptyStr;
  if (aNomeImagem = '*') then
  begin
    Result := 'KILL F,"*"' + LF;
  end
  else
  begin
    LNomeImagem := AjustarNomeArquivoImagem(aNomeImagem);
    Result := 'KILL F,"' + LNomeImagem + '"' + LF;
  end;
end;

function TACBrETQTspl.AlturaFonteEmDots(const aFonte: string; aMultVertical: Integer): Integer;
var
  LFonte: Integer;
  LAlturaBase: Integer;
begin
  Result := 20; // altura base padrao
  // tenta converter para número (fontes 1..8)
  if TryStrToInt(aFonte, LFonte) then
  begin
    case LFonte of
      1: LAlturaBase := 12;
      2: LAlturaBase := 20;
      3: LAlturaBase := 24;
      4: LAlturaBase := 32;
      5: LAlturaBase := 48;
      6: LAlturaBase := 14;
      7: LAlturaBase := 21;
      8: LAlturaBase := 27;
    end;

    Result := LAlturaBase * aMultVertical;
    Dec(Result, 7);
  end
  else
  begin
    // TTF / TSPL usa altura baseada no multiplicador aproximadamente
    Result := 24 * aMultVertical;
    // margem pequena
    Inc(Result, 2);
  end;
end;

function TACBrETQTspl.ComprimentoTextoEmDots(const aTexto, aFonte: string; aMultHorizontal: Integer): Integer;
var
  LFonte: Integer;
  LLarguraBase: Integer;
begin
  Result := 12; // Largura base padrao
  if TryStrToInt(aFonte, LFonte) then
  begin
    case LFonte of
      1: LLarguraBase := 8;
      2: LLarguraBase := 12;
      3: LLarguraBase := 16;
      4: LLarguraBase := 24;
      5: LLarguraBase := 32;
      6: LLarguraBase := 8;
      7: LLarguraBase := 12;
      8: LLarguraBase := 16;
    end;
    Result := Length(aTexto) * LLarguraBase * aMultHorizontal;
    Inc(Result, LLarguraBase+7);
  end
  else
  begin
    // TTF largura variável Aproximadamente
    LLarguraBase := 12;
    Result := Length(aTexto) * LLarguraBase * aMultHorizontal;
    Inc(Result, 6);
  end;
end;

function TACBrETQTspl.ConverterCoordenadas(aVertical, aHorizontal: Integer
  ): String;
begin
  Result := EmptyStr;
  Result := IntToStr(ConverterUnidade(etqDots, aHorizontal)) + ',' +
            IntToStr(ConverterUnidade(etqDots, aVertical));
end;



end.
