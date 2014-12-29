{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit PCN2;

interface

uses
  pcnAuxiliar, pcnCabecalho, pcnConversao, pcnGerador, pcnLeitor, 
  pcnSignature, pcnValidador, LazarusPackageIntf;

implementation

procedure Register;
begin
end;

initialization
  RegisterPackage('PCN2', @Register);
end.
