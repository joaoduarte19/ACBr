unit ACBrBALI9ID12BTest;

{$IFDEF FPC}
{$mode objfpc}{$H+}
{$ENDIF}

{$I ACBr.inc}

interface

uses
  Classes, SysUtils, ACBrTests.Util, ACBrBAL;

type
  TACBrBALI9ID12BTest = class(TTestCase)
  private
    fBAL: TACBrBAL;
    fComando: AnsiString;
    procedure EnviarComando(const cmd: AnsiString);
    procedure ReceberPeso(const NumBytes, ATimeOut: Integer; var Retorno: AnsiString);
    procedure VerificarPeso(const aResposta: AnsiString; aPeso: Double);
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure Modelo;
    procedure LeituraPorComando;
    procedure CasasDecimais;
    procedure SeparadorDecimal;
    procedure TiposDePeso;
    procedure PesoInteiro;
    procedure PesoNegativo;
    procedure PesoEmLibras;
    procedure RespostasInvalidas;
    procedure TransmissaoContinua;
  end;

implementation

uses ACBrConsts, ACBrBALI9ID12B;

procedure TACBrBALI9ID12BTest.SetUp;
begin
  inherited SetUp;
  fBAL := TACBrBAL.Create(nil);
  fBAL.Modelo := balI9ID12B;
end;

procedure TACBrBALI9ID12BTest.TearDown;
begin
  fBAL.Free;
  inherited TearDown;
end;

procedure TACBrBALI9ID12BTest.VerificarPeso(const aResposta: AnsiString; aPeso: Double);
begin
  CheckEquals(aPeso, fBAL.InterpretarRepostaPeso(aResposta), 0.00000001, String(aResposta));
end;

procedure TACBrBALI9ID12BTest.Modelo;
begin
  CheckTrue(fBAL.BAL is TACBrBALI9ID12B);
  CheckEquals('I9 ID-12B', fBAL.ModeloStr);
end;

procedure TACBrBALI9ID12BTest.EnviarComando(const cmd: AnsiString);
begin
  fComando := cmd;
end;

procedure TACBrBALI9ID12BTest.ReceberPeso(const NumBytes, ATimeOut: Integer;
  var Retorno: AnsiString);
begin
  Retorno := 'wn00146.8kg' + #13#10;
end;

procedure TACBrBALI9ID12BTest.LeituraPorComando;
begin
  fComando := '';
  fBAL.Porta := 'DLL';
  fBAL.Device.HookEnviaString := EnviarComando;
  fBAL.Device.HookLeString := ReceberPeso;
  CheckEquals(146.8, fBAL.LePeso(1000), 0.00000001);
  CheckEquals('R', String(fComando));
  CheckEquals(146.8, fBAL.UltimoPesoLido, 0.00000001);
  CheckEquals('wn00146.8kg', String(fBAL.UltimaResposta));
end;

procedure TACBrBALI9ID12BTest.CasasDecimais;
begin
  VerificarPeso('wn00146.8kg' + #13#10, 146.8);
  VerificarPeso('wn00049.5kg' + #13#10, 49.5);
  VerificarPeso('wn000.005kg' + #13#10, 0.005);
  VerificarPeso('wn0014.68kg' + #13#10, 14.68);
  VerificarPeso('wn000.000kg' + #13#10, 0);
end;

procedure TACBrBALI9ID12BTest.SeparadorDecimal;
var
  wSeparador: Char;
begin
  wSeparador := {$IFDEF HAS_FORMATSETTINGS}FormatSettings.{$ENDIF}DecimalSeparator;
  try
    {$IFDEF HAS_FORMATSETTINGS}FormatSettings.{$ENDIF}DecimalSeparator := ',';
    CasasDecimais;
    VerificarPeso('wn00146,8kg', 146.8);
    {$IFDEF HAS_FORMATSETTINGS}FormatSettings.{$ENDIF}DecimalSeparator := '.';
    CasasDecimais;
    VerificarPeso('wn00146,8kg', 146.8);
  finally
    {$IFDEF HAS_FORMATSETTINGS}FormatSettings.{$ENDIF}DecimalSeparator := wSeparador;
  end;
end;

procedure TACBrBALI9ID12BTest.TiposDePeso;
begin
  VerificarPeso('ww00146.8kg', 146.8);
  VerificarPeso('wn00146.8kg', 146.8);
  VerificarPeso('wt00146.8kg', 146.8);
end;

procedure TACBrBALI9ID12BTest.PesoInteiro;
begin
  VerificarPeso('wn000146kg', 146);
end;

procedure TACBrBALI9ID12BTest.PesoNegativo;
begin
  VerificarPeso('wn-001.500kg', -2);
end;

procedure TACBrBALI9ID12BTest.PesoEmLibras;
begin
  VerificarPeso('wn0001.000lb', 0.45359237);
end;

procedure TACBrBALI9ID12BTest.RespostasInvalidas;
begin
  VerificarPeso('', 0);
  VerificarPeso(#13#10, 0);
  VerificarPeso('w', 0);
  VerificarPeso('wn', 0);
  VerificarPeso('wnkg', 0);
  VerificarPeso('wn00146.', 0);
  VerificarPeso('wn00146.8g', 0);
  VerificarPeso('xx00146.8kg', 0);
  VerificarPeso('wn001.46.8kg', 0);
  VerificarPeso('wn1E3kg', 0);
  VerificarPeso('wn00146.8XYZkg', 0);
end;

procedure TACBrBALI9ID12BTest.TransmissaoContinua;
begin
  VerificarPeso('wn00146.8kg' + #13#10 + 'wn00049.5kg' + #13#10, 49.5);
end;

initialization
  _RegisterTest('ACBrSerial.ACBrBAL.I9ID12B', TACBrBALI9ID12BTest);
end.
