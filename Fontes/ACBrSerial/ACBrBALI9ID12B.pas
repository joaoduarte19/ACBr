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

unit ACBrBALI9ID12B;

interface

uses
  Classes,
  ACBrBALClass
  {$IFDEF NEXTGEN}
   ,ACBrBase
  {$ENDIF};

type

  { TACBrBALI9ID12B }

  TACBrBALI9ID12B = class(TACBrBALClass)
  public
    constructor Create(AOwner: TComponent);

    procedure SolicitarPeso; override;
    procedure LeSerial(MillisecTimeOut: Integer = 500); override;

    function InterpretarRepostaPeso(const aResposta: AnsiString): Double; override;
  end;

implementation

uses
  SysUtils,
  ACBrConsts, ACBrUtil.Strings;

{ TACBrBALI9ID12B }

constructor TACBrBALI9ID12B.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  fpModeloStr := 'I9 ID-12B';
end;

procedure TACBrBALI9ID12B.SolicitarPeso;
begin
  GravarLog(' - ' + FormatDateTime('hh:nn:ss:zzz', Now) + ' TX -> R');
  fpDevice.Limpar;
  fpDevice.EnviaString('R');
end;

procedure TACBrBALI9ID12B.LeSerial(MillisecTimeOut: Integer);
begin
  fpUltimoPesoLido := 0;
  fpUltimaResposta := '';

  try
    { Aguarda a linha completa, mesmo quando recebida em partes. }
    fpUltimaResposta := fpDevice.LeString(MillisecTimeOut, 0, CR + LF);
    GravarLog(' - ' + FormatDateTime('hh:nn:ss:zzz', Now) + ' RX <- ' + fpUltimaResposta);

    fpUltimoPesoLido := InterpretarRepostaPeso(fpUltimaResposta);
  except
    { Peso nao foi recebido (TimeOut) }
    fpUltimoPesoLido := -9;
  end;

  GravarLog('              UltimoPesoLido: ' + FloatToStr(fpUltimoPesoLido) +
            ' - Resposta: ' + fpUltimaResposta);
end;

function TACBrBALI9ID12B.InterpretarRepostaPeso(const aResposta: AnsiString): Double;
var
  wResposta, wUnidade: AnsiString;
  wPosIni, wPosFim, I, wDecimais: Integer;
  wSeparador: Char;
begin
  Result := 0;

  { ww = peso bruto, wn = peso liquido, wt = tara.
    A posicao do ponto decimal depende da configuracao do indicador.
    No modo continuo, utiliza a ultima resposta recebida. }
  wPosIni := 0;
  for I := Length(aResposta) - 1 downto 1 do
  begin
    if (aResposta[I] = 'w') and (aResposta[I + 1] in ['w', 'n', 't']) then
    begin
      wPosIni := I;
      Break;
    end;
  end;

  if (wPosIni = 0) then
    Exit;

  wResposta := Trim(Copy(aResposta, wPosIni + 2, Length(aResposta)));
  wUnidade := Copy(wResposta, Length(wResposta) - 1, 2);
  if (wUnidade <> 'kg') and (wUnidade <> 'lb') then
    Exit;

  wResposta := Trim(Copy(wResposta, 1, Length(wResposta) - 2));
  if (wResposta = EmptyStr) then
    Exit;

  { Aceita somente o campo numerico, sem descartar a parte decimal. }
  wDecimais := 0;
  wPosFim := Length(wResposta);
  for I := 1 to wPosFim do
  begin
    case wResposta[I] of
      '0'..'9': ;
      '.', ',': Inc(wDecimais);
      '+', '-': if (I <> 1) or (wPosFim = 1) then Exit;
    else
      Exit;
    end;
  end;

  if (wDecimais > 1) then
    Exit;

  { Ajustando o separador de Decimal corretamente }
  wSeparador := {$IFDEF HAS_FORMATSETTINGS}FormatSettings.{$ENDIF}DecimalSeparator;
  wResposta := StringReplace(wResposta, '.', wSeparador, [rfReplaceAll]);
  wResposta := StringReplace(wResposta, ',', wSeparador, [rfReplaceAll]);

  try
    { Sem ponto decimal, o indicador transmite o peso inteiro. }
    Result := StrToFloat(wResposta);
    if (Result < 0) then
      Result := -2  { Peso Negativo }
    else if (wUnidade = 'lb') then
      Result := Result * 0.45359237;  { Peso em kg }
  except
    Result := 0;
  end;
end;

end.
