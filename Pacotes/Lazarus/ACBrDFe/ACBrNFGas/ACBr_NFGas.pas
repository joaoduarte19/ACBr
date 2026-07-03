{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit ACBr_NFGas;

{$warn 5023 off : no warning about unused units}
interface

uses
  ACBrNFGas, ACBrNFGasReg, ACBrNFGasNotasFiscais, ACBrNFGasConfiguracoes, 
  ACBrNFGasWebServices, ACBrNFGasDANFGasClass, ACBrNFGas.ConsSit, 
  ACBrNFGas.EnvEvento, ACBrNFGas.EventoClass, ACBrNFGas.Classes, ACBrNFGas.XmlReader, 
  ACBrNFGas.XmlWriter, ACBrNFGas.RetConsSit, ACBrNFGas.RetEnvEvento, 
  ACBrNFGas.Conversao, ACBrNFGas.Consts, ACBrNFGas.IniReader, ACBrNFGas.IniWriter, 
  ACBrNFGas.ValidarRegrasdeNegocio, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('ACBrNFGasReg', @ACBrNFGasReg.Register);
end;

initialization
  RegisterPackage('ACBr_NFGas', @Register);
end.
