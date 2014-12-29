{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit ACBr_NFe2;

interface

uses
  ACBrNFe, ACBrNFeConfiguracoes, ACBrNFeDANFEClass, ACBrNFeNotasFiscais, 
  ACBrNFeReg, ACBrNFeUtil, ACBrNFeWebServices, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('ACBrNFeReg', @ACBrNFeReg.Register);
end;

initialization
  RegisterPackage('ACBr_NFe2', @Register);
end.
