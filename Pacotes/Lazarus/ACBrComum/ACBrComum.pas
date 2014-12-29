{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit ACBrComum;

interface

uses
  ACBrBase, ACBrConsts, ACBrTXTClass, ACBrUtil, ACBrReg, ACBrEAD, ACBrAAC, ACBrPAFClass, 
  ACBrDFeUtil, OpenSSLExt, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('ACBrReg', @ACBrReg.Register);
end;

initialization
  RegisterPackage('ACBrComum', @Register);
end.
