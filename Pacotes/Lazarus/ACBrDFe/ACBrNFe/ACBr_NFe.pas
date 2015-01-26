{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit ACBr_NFe;

interface

uses
  ACBrNFe, ACBrNFeReg, ACBrNFeNotasFiscais, ACBrNFeConfiguracoes, 
  ACBrNFeWebServices, ACBrNFeUtil, ACBrNFeDANFEClass, pcnAdmCSCNFCe, 
  pcnCadEmiDFe, pcnCancNFe, pcnCCeNFe, pcnConsCad, pcnConsDPEC, 
  pcnConsNFeDest, pcnConsReciNFe, pcnConsSitNFe, pcnConsStatServ, 
  pcnDistDFeInt, pcnDownloadNFe, pcnEnvDPEC, pcnEnvEventoNFe, pcnEnvNFe, 
  pcnEventoNFe, pcnInutNFe, pcnLayoutTXT, pcnNFe, pcnNFeR, pcnNFeRTXT, 
  pcnNFeW, pcnProcNFe, pcnRetAdmCSCNFCe, pcnRetAtuCadEmiDFe, pcnRetCancNFe, 
  pcnRetCCeNFe, pcnRetConsCad, pcnRetConsNFeDest, pcnRetConsReciNFe, 
  pcnRetConsSitNFe, pcnRetConsStatServ, pcnRetDistDFeInt, pcnRetDownloadNFe, 
  pcnRetDPEC, pcnRetEnvEventoNFe, pcnRetEnvNFe, pcnRetInutNFe, 
  LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('ACBrNFeReg', @ACBrNFeReg.Register);
end;

initialization
  RegisterPackage('ACBr_NFe', @Register);
end.
