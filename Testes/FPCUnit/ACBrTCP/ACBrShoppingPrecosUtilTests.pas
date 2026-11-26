{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
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

unit ACBrShoppingPrecosUtilTests;

interface

uses
  Classes,
  SysUtils,
  ACBrTests.Util;

type

  { Funcoes publicas de ACBrShoppingPrecosModelos e FormatDateTimeBr.
    Sem rede, sem relogio: datas fixas. }

  TSDPFuncoesTests = class(TTestCase)
  private
    FTimeSeparatorOriginal: Char;
    FDecimalSeparatorOriginal: Char;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure SDPQuote_TextoSimples_RetornaEntreAspas;
    procedure SDPQuote_AspasEBarra_RetornaEscapado;
    procedure SDPQuote_CaracteresDeControle_RetornaEscapado;
    procedure SDPNumero_Decimal_RetornaPontoSemZeros;
    procedure SDPNumero_Inteiro_RetornaSemPonto;
    procedure SDPNumero_SeparadorDecimalVirgula_RetornaPonto;
    procedure SDPBool_Valores_RetornaLiteralJSON;
    procedure SDPPar_DoisPares_RetornaSeparadosPorVirgula;
    procedure SDPIsNull_CampoNullEValor_DiferenciaNull;
    procedure SDPData_ISOCompleta_RetornaDataHora;
    procedure SDPData_SomenteData_RetornaDataSemHora;
    procedure SDPData_Vazia_RetornaZero;
    procedure SDPData_Curta_GeraExcecao;
    procedure SDPData_MesInvalido_GeraExcecao;
    procedure SDPData_ComLetras_GeraExcecao;
    procedure SDPData_DataZerada_RetornaZero;
    procedure SDPData_SeparadorT_RetornaDataHora;
    procedure SDPData_FracaoEFuso_MantemHoraDaAPI;
    procedure SDPData_FusoInvalido_GeraExcecao;
    procedure SDPData_SeparadorDeDataInvalido_GeraExcecao;
    procedure SDPQuote_TextoMisto_PreservaTrechosSemEscape;
    procedure FormatDateTimeBr_TimeSeparatorPonto_RetornaDoisPontos;
  end;

  { TSDPConfiguracoes, TSDPCadastroPlataformas e conversoes de enum }

  TSDPConfiguracoesTests = class(TTestCase)
  published
    procedure FormatoEtiqueta_ParaTexto_RetornaPDFouZPL;
    procedure FormatoEtiqueta_DeTexto_AceitaMinusculaEPadraoPDF;
    procedure CadastroPlataformas_CodigoConhecido_RetornaNome;
    procedure CadastroPlataformas_NomeComAcento_RetornaTextoNativo;
    procedure CadastroPlataformas_CodigoInexistente_RetornaVazioEIndiceNegativo;
    procedure CadastroPlataformas_MercadoLivre_UsaEtiquetaML;
    procedure CadastroPlataformas_IndiceInvalido_GeraExcecao;
    procedure Plataforma_CodigoForaDaTabela_AceitaSemValidar;
    procedure Assign_OutraConfiguracao_CopiaTodosOsCampos;
  end;

implementation

uses
  ACBrJSON,
  ACBrUtil.Strings,
  ACBrUtil.DateTime,
  ACBrShoppingPrecosModelos,
  ACBrShoppingPrecosConfiguracoes;

const
  CDataFixa = '2026-01-02 03:04:05';

function DataFixa: TDateTime;
begin
  Result := EncodeDate(2026, 1, 2) + EncodeTime(3, 4, 5, 0);
end;

{ TSDPFuncoesTests }

procedure TSDPFuncoesTests.SetUp;
begin
  inherited SetUp;
  {$IFDEF HAS_FORMATSETTINGS}
  FTimeSeparatorOriginal := FormatSettings.TimeSeparator;
  FDecimalSeparatorOriginal := FormatSettings.DecimalSeparator;
  {$ELSE}
  FTimeSeparatorOriginal := TimeSeparator;
  FDecimalSeparatorOriginal := DecimalSeparator;
  {$ENDIF}
end;

procedure TSDPFuncoesTests.TearDown;
begin
  {$IFDEF HAS_FORMATSETTINGS}
  FormatSettings.TimeSeparator := FTimeSeparatorOriginal;
  FormatSettings.DecimalSeparator := FDecimalSeparatorOriginal;
  {$ELSE}
  TimeSeparator := FTimeSeparatorOriginal;
  DecimalSeparator := FDecimalSeparatorOriginal;
  {$ENDIF}
  inherited TearDown;
end;

procedure TSDPFuncoesTests.SDPQuote_TextoSimples_RetornaEntreAspas;
begin
  CheckEquals('"ABC 123"', SDPQuote('ABC 123'));
  CheckEquals('""', SDPQuote(''));
end;

procedure TSDPFuncoesTests.SDPQuote_AspasEBarra_RetornaEscapado;
begin
  CheckEquals('"a\"b\\c"', SDPQuote('a"b\c'));
end;

procedure TSDPFuncoesTests.SDPQuote_CaracteresDeControle_RetornaEscapado;
begin
  CheckEquals('"\b\t\n\f\r"', SDPQuote(#8#9#10#12#13));
  CheckEquals('"x\u0001y"', SDPQuote('x' + #1 + 'y'));
end;

procedure TSDPFuncoesTests.SDPNumero_Decimal_RetornaPontoSemZeros;
begin
  CheckEquals('10.5', SDPNumero(10.5));
  CheckEquals('0.125', SDPNumero(0.125));
  CheckEquals('-1.25', SDPNumero(-1.25));
end;

procedure TSDPFuncoesTests.SDPNumero_Inteiro_RetornaSemPonto;
begin
  CheckEquals('3', SDPNumero(3));
  CheckEquals('0', SDPNumero(0));
end;

procedure TSDPFuncoesTests.SDPNumero_SeparadorDecimalVirgula_RetornaPonto;
begin
  {$IFDEF HAS_FORMATSETTINGS}
  FormatSettings.DecimalSeparator := ',';
  {$ELSE}
  DecimalSeparator := ',';
  {$ENDIF}
  CheckEquals('1234.56', SDPNumero(1234.56));
end;

procedure TSDPFuncoesTests.SDPBool_Valores_RetornaLiteralJSON;
begin
  CheckEquals('true', SDPBool(True));
  CheckEquals('false', SDPBool(False));
end;

procedure TSDPFuncoesTests.SDPPar_DoisPares_RetornaSeparadosPorVirgula;
var
  LJSON: string;
begin
  LJSON := '';
  SDPPar(LJSON, 'a', '1');
  SDPPar(LJSON, 'b', '"x"');
  CheckEquals('"a":1,"b":"x"', LJSON);
end;

procedure TSDPFuncoesTests.SDPIsNull_CampoNullEValor_DiferenciaNull;
var
  J: TACBrJSONObject;
begin
  J := TACBrJSONObject.Parse('{"a":null,"b":1,"c":""}');
  try
    CheckTrue(SDPIsNull(J, 'a'), 'campo null');
    CheckFalse(SDPIsNull(J, 'b'), 'campo numerico');
    CheckFalse(SDPIsNull(J, 'c'), 'string vazia nao e null');
  finally
    J.Free;
  end;
end;

procedure TSDPFuncoesTests.SDPData_ISOCompleta_RetornaDataHora;
begin
  CheckEquals(CDataFixa, FormatDateTimeBr(SDPData(CDataFixa), 'yyyy-mm-dd hh:nn:ss'));
end;

procedure TSDPFuncoesTests.SDPData_SomenteData_RetornaDataSemHora;
begin
  CheckEquals('2026-01-02 00:00:00', FormatDateTimeBr(SDPData('2026-01-02'), 'yyyy-mm-dd hh:nn:ss'));
end;

procedure TSDPFuncoesTests.SDPData_Vazia_RetornaZero;
begin
  CheckTrue(SDPData('') = 0, 'data vazia deve retornar 0');
end;

procedure TSDPFuncoesTests.SDPData_Curta_GeraExcecao;
var
  LGerouExcecao: Boolean;
begin
  LGerouExcecao := False;
  try
    SDPData('2026-01');
  except
    on E: EACBrShoppingPrecos do
      LGerouExcecao := True;
  end;
  CheckTrue(LGerouExcecao, 'Data curta deveria gerar EACBrShoppingPrecos');
end;

procedure TSDPFuncoesTests.SDPData_MesInvalido_GeraExcecao;
var
  LGerouExcecao: Boolean;
begin
  LGerouExcecao := False;
  try
    SDPData('2026-13-01 00:00:00');
  except
    on E: EACBrShoppingPrecos do
      LGerouExcecao := True;
  end;
  CheckTrue(LGerouExcecao, 'Mes 13 deveria gerar EACBrShoppingPrecos (e nao EConvertError)');
end;

procedure TSDPFuncoesTests.SDPData_ComLetras_GeraExcecao;
var
  LGerouExcecao: Boolean;
begin
  LGerouExcecao := False;
  try
    SDPData('abcd-ef-gh');
  except
    on E: EACBrShoppingPrecos do
      LGerouExcecao := True;
  end;
  CheckTrue(LGerouExcecao, 'Data com letras deveria gerar EACBrShoppingPrecos');
end;

procedure TSDPFuncoesTests.SDPData_DataZerada_RetornaZero;
begin
  { MySQL/PHP: data nao informada }
  CheckTrue(SDPData('0000-00-00') = 0, 'data zerada');
  CheckTrue(SDPData('0000-00-00 00:00:00') = 0, 'data e hora zeradas');
end;

procedure TSDPFuncoesTests.SDPData_SeparadorT_RetornaDataHora;
begin
  CheckEquals(CDataFixa, FormatDateTimeBr(SDPData('2026-01-02T03:04:05'), 'yyyy-mm-dd hh:nn:ss'));
end;

procedure TSDPFuncoesTests.SDPData_FracaoEFuso_MantemHoraDaAPI;
begin
  CheckEquals(CDataFixa, FormatDateTimeBr(SDPData('2026-01-02T03:04:05.123-03:00'), 'yyyy-mm-dd hh:nn:ss'));
  CheckEquals(CDataFixa, FormatDateTimeBr(SDPData('2026-01-02T03:04:05Z'), 'yyyy-mm-dd hh:nn:ss'));
  CheckEquals(CDataFixa, FormatDateTimeBr(SDPData('2026-01-02 03:04:05.000000'), 'yyyy-mm-dd hh:nn:ss'));
end;

procedure TSDPFuncoesTests.SDPData_FusoInvalido_GeraExcecao;
var
  LGerouExcecao: Boolean;
begin
  LGerouExcecao := False;
  try
    SDPData('2026-01-02 03:04:05XYZ');
  except
    on E: EACBrShoppingPrecos do
      LGerouExcecao := True;
  end;
  CheckTrue(LGerouExcecao, 'Sufixo que nao e fracao nem fuso deveria gerar EACBrShoppingPrecos');
end;

procedure TSDPFuncoesTests.SDPData_SeparadorDeDataInvalido_GeraExcecao;
var
  LGerouExcecao: Boolean;
begin
  LGerouExcecao := False;
  try
    SDPData('2026/01/02');
  except
    on E: EACBrShoppingPrecos do
      LGerouExcecao := True;
  end;
  CheckTrue(LGerouExcecao, 'Data com "/" deveria gerar EACBrShoppingPrecos');
end;

procedure TSDPFuncoesTests.SDPQuote_TextoMisto_PreservaTrechosSemEscape;
begin
  CheckEquals('"<p>a\"b</p>\n<p>c\\d</p>fim"', SDPQuote('<p>a"b</p>' + #10 + '<p>c\d</p>fim'));
end;

procedure TSDPFuncoesTests.FormatDateTimeBr_TimeSeparatorPonto_RetornaDoisPontos;
begin
  {$IFDEF HAS_FORMATSETTINGS}
  FormatSettings.TimeSeparator := '.';
  {$ELSE}
  TimeSeparator := '.';
  {$ENDIF}
  CheckEquals(CDataFixa, FormatDateTimeBr(DataFixa, 'yyyy-mm-dd hh:nn:ss'));
end;

{ TSDPConfiguracoesTests }

procedure TSDPConfiguracoesTests.FormatoEtiqueta_ParaTexto_RetornaPDFouZPL;
begin
  CheckEquals('PDF', FormatoEtiquetaToStr(sdpfPDF));
  CheckEquals('ZPL', FormatoEtiquetaToStr(sdpfZPL));
end;

procedure TSDPConfiguracoesTests.FormatoEtiqueta_DeTexto_AceitaMinusculaEPadraoPDF;
begin
  CheckTrue(StrToFormatoEtiqueta(' zpl ') = sdpfZPL, 'zpl minusculo com espacos');
  CheckTrue(StrToFormatoEtiqueta('PDF') = sdpfPDF, 'PDF');
  CheckTrue(StrToFormatoEtiqueta('XYZ') = sdpfPDF, 'valor desconhecido assume PDF');
end;

procedure TSDPConfiguracoesTests.CadastroPlataformas_CodigoConhecido_RetornaNome;
var
  C: TSDPConfiguracoes;
begin
  C := TSDPConfiguracoes.Create;
  try
    CheckEquals('Mercado Livre', C.CadastroPlataformas.Nome(1));
    CheckEquals('Amazon', C.CadastroPlataformas.Nome(4));
    CheckEquals(0, C.CadastroPlataformas.Indice(1));
  finally
    C.Free;
  end;
end;

procedure TSDPConfiguracoesTests.CadastroPlataformas_NomeComAcento_RetornaTextoNativo;
var
  C: TSDPConfiguracoes;
  I: Integer;
begin
  C := TSDPConfiguracoes.Create;
  try
    { 87 = 'Conecta Lá'; literal em CP1252 convertido pelo ACBrStr }
    CheckEquals(ACBrStr('Conecta L' + #$E1), C.CadastroPlataformas.Nome(87));
    I := C.CadastroPlataformas.Indice(87);
    CheckTrue(I >= 0, 'codigo 87 deve constar na tabela');
    CheckEquals(ACBrStr('Conecta L' + #$E1), C.CadastroPlataformas[I].Nome);
  finally
    C.Free;
  end;
end;

procedure TSDPConfiguracoesTests.CadastroPlataformas_CodigoInexistente_RetornaVazioEIndiceNegativo;
var
  C: TSDPConfiguracoes;
begin
  C := TSDPConfiguracoes.Create;
  try
    { 70 nao existe na tabela da API }
    CheckEquals(-1, C.CadastroPlataformas.Indice(70));
    CheckEquals('', C.CadastroPlataformas.Nome(70));
    CheckFalse(C.CadastroPlataformas.UsaEtiquetaMercadoLivre(70));
  finally
    C.Free;
  end;
end;

procedure TSDPConfiguracoesTests.CadastroPlataformas_MercadoLivre_UsaEtiquetaML;
var
  C: TSDPConfiguracoes;
begin
  C := TSDPConfiguracoes.Create;
  try
    CheckTrue(C.CadastroPlataformas.UsaEtiquetaMercadoLivre(1), 'Mercado Livre');
    CheckFalse(C.CadastroPlataformas.UsaEtiquetaMercadoLivre(4), 'Amazon');
  finally
    C.Free;
  end;
end;

procedure TSDPConfiguracoesTests.CadastroPlataformas_IndiceInvalido_GeraExcecao;
var
  C: TSDPConfiguracoes;
  LGerouExcecao: Boolean;
  LCodigo: Integer;
begin
  C := TSDPConfiguracoes.Create;
  try
    LGerouExcecao := False;
    try
      LCodigo := C.CadastroPlataformas[C.CadastroPlataformas.Count].Codigo;
      CheckEquals(-1, LCodigo, 'nao deveria chegar aqui');
    except
      on E: EListError do
        LGerouExcecao := True;
    end;
    CheckTrue(LGerouExcecao, 'Indice fora da tabela deveria gerar EListError');
  finally
    C.Free;
  end;
end;

procedure TSDPConfiguracoesTests.Plataforma_CodigoForaDaTabela_AceitaSemValidar;
var
  C: TSDPConfiguracoes;
begin
  C := TSDPConfiguracoes.Create;
  try
    C.Plataforma := 9999;
    CheckEquals(9999, Integer(C.Plataforma));
  finally
    C.Free;
  end;
end;

procedure TSDPConfiguracoesTests.Assign_OutraConfiguracao_CopiaTodosOsCampos;
var
  A, B: TSDPConfiguracoes;
begin
  A := TSDPConfiguracoes.Create;
  B := TSDPConfiguracoes.Create;
  try
    A.Plataforma := 4;
    A.Usuario := 'usuario.teste';
    A.Senha := 'senha-ficticia';
    A.Token := 'token-ficticio';
    A.IntegracaoID := '123';
    B.Assign(A);
    CheckEquals(4, Integer(B.Plataforma));
    CheckEquals('usuario.teste', B.Usuario);
    CheckEquals('senha-ficticia', B.Senha);
    CheckEquals('token-ficticio', B.Token);
    CheckEquals('123', B.IntegracaoID);
  finally
    B.Free;
    A.Free;
  end;
end;

initialization
  _RegisterTest('ACBrTCP.ShoppingPrecos.Funcoes', TSDPFuncoesTests);
  _RegisterTest('ACBrTCP.ShoppingPrecos.Configuracoes', TSDPConfiguracoesTests);

end.
