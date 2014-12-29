{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit PCN2;

interface

uses
  pcnAuxiliar, pcnCabecalho, pcnCadEmiDFe, pcnCancNFe, pcnConsCad, 
  pcnConsDPEC, pcnConsReciNFe, pcnConsSitNFe, pcnConsStatServ, pcnConversao, 
  pcnEnvDPEC, pcnEnvEventoNFe, pcnEnvNFe, pcnGerador, pcnInutNFe, 
  pcnLayoutTXT, pcnLeitor, pcnNFe, pcnNFeR, pcnNFeRTXT, pcnNFeW, pcnProcNFe, 
  pcnRetAtuCadEmiDFe, pcnRetCancNFe, pcnRetConsCad, pcnRetConsReciNFe, 
  pcnRetConsSitNFe, pcnRetConsStatServ, pcnRetDPEC, pcnRetEnvEventoNFe, 
  pcnRetEnvNFe, pcnRetInutNFe, pcnSignature, pcnCCeNFe, pcnRetCCeNFe, 
  pcnDownloadNFe, pcnConsNFeDest, pcnRetConsNFeDest, pcnRetDownloadNFe, 
  pcnAdmCSCNFCe, pcnRetAdmCSCNFCe, pcnDistDFeInt, pcnRetDistDFeInt, 
  LazarusPackageIntf;

implementation

procedure Register;
begin
end;

initialization
  RegisterPackage('PCN2', @Register);
end.
