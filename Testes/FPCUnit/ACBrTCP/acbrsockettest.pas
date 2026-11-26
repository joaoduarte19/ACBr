unit ACBrSocketTest;

{$IFDEF FPC}
{$mode objfpc}{$H+}
{$ENDIF}

interface

uses
  Classes,
  SysUtils, ACBrTests.Util;

type

  { Funcoes }

  Funcoes = class(TTestCase)
  published
    procedure IsAbsoluteURL_URLComProtocolo_RetornaTrue;
    procedure IsAbsoluteURL_URLAbsolutaRelativaAoProtocolo_RetornaTrue;
    procedure IsAbsoluteURL_URLRelativa_RetornaFalse;
  end;

implementation

uses ACBrSocket;

{ Funcoes }

procedure Funcoes.IsAbsoluteURL_URLComProtocolo_RetornaTrue;
begin
  CheckTrue(ACBrSocket.LocationIsAbsoluteURL('http://www.google.com.br'));
  CheckTrue(ACBrSocket.LocationIsAbsoluteURL('HTTP://WWW.projetoacbr.com.br/forum/'));
  CheckTrue(ACBrSocket.LocationIsAbsoluteURL('https://www.google.com.br'));
  CheckTrue(ACBrSocket.LocationIsAbsoluteURL('ftp://www.exemplo.com.br/pasta/arquivo/Leiame.txt'));
end;

procedure Funcoes.IsAbsoluteURL_URLAbsolutaRelativaAoProtocolo_RetornaTrue;
begin
  CheckTrue(ACBrSocket.LocationIsAbsoluteURL('//cdn.example.com/lib.js'));
end;

procedure Funcoes.IsAbsoluteURL_URLRelativa_RetornaFalse;
begin
  CheckFalse(ACBrSocket.LocationIsAbsoluteURL('/minhaPasta/index.html'));
  CheckFalse(ACBrSocket.LocationIsAbsoluteURL('../../OutraPasta/Cadastro.htm'));
end;

initialization

  _RegisterTest('ACBrTCP.ACBrSocket', Funcoes);
end.
