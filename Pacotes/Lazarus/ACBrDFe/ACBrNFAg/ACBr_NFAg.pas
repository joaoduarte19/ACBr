{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit ACBr_NFAg;

{$warn 5023 off : no warning about unused units}
interface

uses
  ACBrNFAg, ACBrNFAgReg, ACBrNFAgNotasFiscais, ACBrNFAgConfiguracoes, 
  ACBrNFAgWebServices, ACBrNFAgDANFAgClass, ACBrNFAg.ConsSit, 
  ACBrNFAg.EnvEvento, ACBrNFAg.EventoClass, ACBrNFAg.Classes, ACBrNFAg.XmlReader, 
  ACBrNFAg.XmlWriter, ACBrNFAg.RetConsSit, ACBrNFAg.RetEnvEvento, 
  ACBrNFAg.Conversao, ACBrNFAg.Consts, ACBrNFAg.IniReader, ACBrNFAg.IniWriter, 
  LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('ACBrNFAgReg', @ACBrNFAgReg.Register);
end;

initialization
  RegisterPackage('ACBr_NFAg', @Register);
end.
