{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit ACBr_DeRE;

{$warn 5023 off : no warning about unused units}
interface

uses
  ACBrDeREEventos, ACBrDeRE.Consts, ACBrDeRE.Conversao, ACBrDeRE.Classes, 
  ACBrDeRE.D1001.Classes, ACBrDeRE.D1011.Classes, ACBrDeRE.D1101.Classes, ACBrDeRE.D1106.Classes, 
  ACBrDeRE.D1121.Classes, ACBrDeRE.D1198.Classes, ACBrDeRE.D1199.Classes, ACBrDeRE.D2101.Classes, ACBrDeRE.D2102.Classes, ACBrDeRE.D2201.Classes, ACBrDeRE.D2202.Classes, ACBrDeRE.D2211.Classes, ACBrDeRE.D2221.Classes, ACBrDeRE.D2231.Classes, ACBrDeRE.D2241.Classes, ACBrDeRE.D2242.Classes, ACBrDeRE.D2251.Classes, ACBrDeRE.D2252.Classes, ACBrDeRE.D3201.Classes, ACBrDeRE.D4201.Classes, ACBrDeRE.Classes.Retorno, ACBrDeRE.XmlWriter, 
  ACBrDeRE.D1001.XmlWriter, ACBrDeRE.D1011.XmlWriter, ACBrDeRE.D1101.XmlWriter, ACBrDeRE.D1106.XmlWriter, 
  ACBrDeRE.D1121.XmlWriter, ACBrDeRE.D1198.XmlWriter, ACBrDeRE.D1199.XmlWriter, ACBrDeRE.D2101.XmlWriter, ACBrDeRE.D2102.XmlWriter, ACBrDeRE.D2201.XmlWriter, ACBrDeRE.D2202.XmlWriter, ACBrDeRE.D2211.XmlWriter, ACBrDeRE.D2221.XmlWriter, ACBrDeRE.D2231.XmlWriter, ACBrDeRE.D2241.XmlWriter, ACBrDeRE.D2242.XmlWriter, ACBrDeRE.D2251.XmlWriter, ACBrDeRE.D2252.XmlWriter, ACBrDeRE.D3201.XmlWriter, ACBrDeRE.D4201.XmlWriter, ACBrDeRE.D1199.IniWriter, ACBrDeRE.D1199.IniReader, ACBrDeRE.D1199.XmlReader, ACBrDeRE.D2101.IniWriter, ACBrDeRE.D2101.IniReader, ACBrDeRE.D2101.XmlReader, ACBrDeRE.D2102.IniWriter, ACBrDeRE.D2102.IniReader, ACBrDeRE.D2102.XmlReader, ACBrDeRE.D2201.IniWriter, ACBrDeRE.D2201.IniReader, ACBrDeRE.D2201.XmlReader, ACBrDeRE.D2202.IniWriter, ACBrDeRE.D2202.IniReader, ACBrDeRE.D2202.XmlReader, ACBrDeRE.D2211.IniWriter, ACBrDeRE.D2211.IniReader, ACBrDeRE.D2211.XmlReader, ACBrDeRE.D2221.IniWriter, ACBrDeRE.D2221.IniReader, ACBrDeRE.D2221.XmlReader, ACBrDeRE.D2231.IniWriter, ACBrDeRE.D2231.IniReader, ACBrDeRE.D2231.XmlReader, ACBrDeRE.D2241.IniWriter, ACBrDeRE.D2241.IniReader, ACBrDeRE.D2241.XmlReader, ACBrDeRE.D2242.IniWriter, ACBrDeRE.D2242.IniReader, ACBrDeRE.D2242.XmlReader, ACBrDeRE.D2251.IniWriter, ACBrDeRE.D2251.IniReader, ACBrDeRE.D2251.XmlReader, ACBrDeRE.D2252.IniWriter, ACBrDeRE.D2252.IniReader, ACBrDeRE.D2252.XmlReader, ACBrDeRE.D3201.IniWriter, ACBrDeRE.D3201.IniReader, ACBrDeRE.D3201.XmlReader, ACBrDeRE.D4201.IniWriter, ACBrDeRE.D4201.IniReader, ACBrDeRE.D4201.XmlReader, ACBrDeRE.D1198.IniWriter, ACBrDeRE.D1198.IniReader, ACBrDeRE.D1198.XmlReader, ACBrDeRE.D1011.IniWriter, ACBrDeRE.D1011.IniReader, ACBrDeRE.D1011.XmlReader, ACBrDeRE.D1101.IniWriter, ACBrDeRE.D1101.IniReader, ACBrDeRE.D1101.XmlReader, ACBrDeRE.D1106.IniWriter, ACBrDeRE.D1106.IniReader, ACBrDeRE.D1106.XmlReader, ACBrDeRE.D1121.IniWriter, ACBrDeRE.D1121.IniReader, ACBrDeRE.D1121.XmlReader, ACBrDeRE.IniWriter, ACBrDeRE.IniReader, ACBrDeRE.D1001.IniWriter, ACBrDeRE.D1001.IniReader, ACBrDeRE.D1001.XmlReader, ACBrDeRE.XmlReader, ACBrDeRE.XmlReader.Retorno, ACBrDeRE.ObterToken, ACBrDeRE.RetObterToken, ACBrDeRE.EnvLote, ACBrDeRE.ConsLote, ACBrDeRE.RetEnvLote, ACBrDeRE.Limpeza, ACBrDeRE.RetLimpeza, ACBrDeREReg, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('ACBrDeREReg', @ACBrDeREReg.Register);
end;

initialization
  RegisterPackage('ACBr_DeRE', @Register);
end.
