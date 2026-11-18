{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit ACBr_NFeABI;

{$warn 5023 off : no warning about unused units}
interface

uses
  ACBrNFeABI, ACBrNFeABIConfiguracoes, ACBrNFeABINotasFiscais, ACBrNFeABIReg, 
  ACBrNFeABIWebServices, ACBrNFeABI.Classes, ACBrNFeABI.Consts, 
  ACBrNFeABI.Conversao, ACBrNFeABI.IniReader, ACBrNFeABI.IniWriter, 
  ACBrNFeABI.ValidarRegrasdeNegocio, ACBrNFeABI.XmlReader, 
  ACBrNFeABI.XmlWriter, ACBrNFeABI.ConsSit, ACBrNFeABI.EnvEvento, 
  ACBrNFeABI.EventoClass, ACBrNFeABI.RetConsSit, ACBrNFeABI.RetEnvEvento, 
  LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('ACBrNFeABIReg', @ACBrNFeABIReg.Register);
end;

initialization
  RegisterPackage('ACBr_NFeABI', @Register);
end.
