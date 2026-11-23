{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit ACBr_NFeABI_DANFeABIFPDF;

{$warn 5023 off : no warning about unused units}
interface

uses
  ACBrNFeABI.DANFEABIFPDFReg, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('ACBrNFeABI.DANFEABIFPDFReg', @ACBrNFeABI.DANFEABIFPDFReg.Register);
end;

initialization
  RegisterPackage('ACBr_NFeABI_DANFeABIFPDF', @Register);
end.
