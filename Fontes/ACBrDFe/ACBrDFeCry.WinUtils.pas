{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2026 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la }
{ sob os termos da Licença Pública Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a versão 2.1 da Licença, ou (a seu critério) }
{ qualquer versão posterior.                                                   }
{                                                                              }
{  Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU      }
{ ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENÇA.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Você deve ter recebido uma cópia da Licença Pública Geral Menor do GNU junto}
{ com esta biblioteca; se não, escreva para a Free Software Foundation, Inc.,  }
{ no endereço 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Você também pode obter uma copia da licença em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Simões de Almeida - daniel@projetoacbr.com.br - www.projetoacbr.com.br}
{       Rua Coronel Aureliano de Camargo, 963 - Tatuí - SP - 18270-170         }
{******************************************************************************}

{$I ACBr.inc}

unit ACBrDFeCry.WinUtils;

interface

uses
  Classes, SysUtils, Windows,
  ACBrDFeSSL, ACBrDFeException,
  ACBr_WinCrypt, ACBr_NCrypt, ACBr_BCrypt ;

const
  sz_CERT_STORE_PROV_PKCS12 = 'PKCS12';
   SCARD_W_WRONG_CHV        = $8010006B;
   SCARD_W_CHV_BLOCKED      = $8010006C;

type
  EACBrDFeWrongPINException = EACBrDFeException;

function MsgErroGetCryptProvider(WinErro: DWORD = 0): String;

function GetSerialNumber(ACertContext: PCCERT_CONTEXT): String;
function GetThumbPrint(ACertContext: PCCERT_CONTEXT): String;
function GetSubjectName(ACertContext: PCCERT_CONTEXT): String;
function GetIssuerName(ACertContext: PCCERT_CONTEXT): String;
function GetNotBefore(ACertContext: PCCERT_CONTEXT): TDateTime;
function GetNotAfter(ACertContext: PCCERT_CONTEXT): TDateTime;
function GetCertIsHardware(ACertContext: PCCERT_CONTEXT): Boolean;

function GetProviderOrKeyIsHardware( ProviderOrKeyHandle: HCRYPTPROV_OR_NCRYPT_KEY_HANDLE;
                                     dwKeySpec: DWORD): Boolean;

function GetCSPProviderParamString(ACryptProvider: HCRYPTPROV; dwParam: DWORD): String;
function GetCSPProviderParamDWord(ACryptProvider: HCRYPTPROV; dwParam: DWORD): DWORD;
function GetCSPProviderIsHardware(ACryptProvider: HCRYPTPROV): Boolean;

function GetCNGProviderParamString(ACryptHandle: NCRYPT_HANDLE; dwParam: LPCWSTR): String;
function GetCNGProviderParamDWord(ACryptHandle: NCRYPT_HANDLE; dwParam: LPCWSTR): DWORD;
function GetCNGProviderIsHardware(ACryptHandle: NCRYPT_HANDLE): Boolean;

function GetProviderInfo(ACertContext: PCCERT_CONTEXT;
   out ProviderType: DWORD; out ProviderName, ContainerName: {$IfDef UNICODE}WideString{$Else}String{$EndIf};
   RaiseExceptions: Boolean = True): Boolean;

function GetCertExtension(ACertContext: PCCERT_CONTEXT; const ExtensionName: String): PCERT_EXTENSION;
function DecodeCertExtensionToNameInfo(AExtension: PCERT_EXTENSION; const ExtensionName: String): PCERT_ALT_NAME_INFO;
function GetOtherNameBlobFromNameInfo(ANameInfo: PCERT_ALT_NAME_INFO; const AExtensionName: String ): CERT_NAME_BLOB;
function AdjustAnsiOID(const aOID: AnsiString): AnsiString;
function GetTaxIDFromExtensions(ACertContext: PCCERT_CONTEXT): String;

function CertToDERBase64(ACertContext: PCCERT_CONTEXT): AnsiString;

procedure PFXDataToCertContextWinApi( const AData, APass: AnsiString; var AStore, ACertContext: Pointer);
function ExportCertContextToPFXData( ACertContext: PCCERT_CONTEXT; const APass: AnsiString): AnsiString;
procedure SetCertContextPassword(ACertContext: PCCERT_CONTEXT; const APass: AnsiString;
   RaiseUnknownErrors: Boolean = True);

implementation

uses
  strutils, typinfo, comobj,
  synautil, synacode,
  ACBrUtil.FilesIO;

function MsgErroGetCryptProvider(WinErro: DWORD): String;
begin
  if WinErro = 0 then
    WinErro := GetLastError;

  if WinErro = DWORD( NTE_KEYSET_NOT_DEF ) then
    Result := 'Provedor de Criptografia não encontrado. Verifique a configuração do Certificado'
  else if WinErro = DWORD( NTE_BAD_KEYSET ) then
    Result := 'O recipiente da chave não pôde ser aberto'
  else if WinErro = DWORD( NTE_KEYSET_ENTRY_BAD ) then
    Result := 'Estrutura de Chave obtida no Provedor de Criptografia está corrompida'
  else
    Result := 'Falha em obter Provedor de Criptografia do Certificado. Erro: '+GetLastErrorAsHexaStr(WinErro);
end;

function GetSerialNumber(ACertContext: PCCERT_CONTEXT): String;
var
  I: Integer;
  ByteArr: array of byte;
begin
  Result := '';
  if Assigned(ACertContext) then
  begin
    SetLength(ByteArr, ACertContext^.pCertInfo^.SerialNumber.cbData);
    Move(ACertContext^.pCertInfo^.SerialNumber.pbData^,
         ByteArr[0],
         ACertContext^.pCertInfo^.SerialNumber.cbData);

    For I := 0 to ACertContext^.pCertInfo^.SerialNumber.cbData-1 do
      Result := IntToHex(ByteArr[I], 2) + Result;

    Result := Trim(UpperCase(Result));
  end;
end;

function GetThumbPrint(ACertContext: PCCERT_CONTEXT): String;
var
  I: Integer;
  ByteArr: array of byte;
  pcbData: DWORD;
  pvData: Pointer;
begin
  Result := '';
  if Assigned(ACertContext) then
  begin
    if not CertGetCertificateContextProperty( ACertContext,
                                              CERT_HASH_PROP_ID,
                                              Nil,
                                              pcbData) then
        raise EACBrDFeException.Create( 'GetHashSHA1: Erro obtendo BufferSize de "CERT_HASH_PROP_ID"');


    pvData := AllocMem(pcbData);
    try
      //CryptHashCertificate(0, CALG_SHA1, 0, ACertContext^.pbCertEncoded,
      //     ACertContext^.cbCertEncoded, pvData, pcbData);
      if not CertGetCertificateContextProperty( ACertContext,
                                                CERT_HASH_PROP_ID,
                                                pvData,
                                                pcbData) then
        raise EACBrDFeException.Create( 'GetHashSHA1: Erro obtendo "CERT_HASH_PROP_ID"');

      SetLength(ByteArr, pcbData);
      Move(pvData^, ByteArr[0], pcbData);

      For I := 0 to pcbData-1 do
        Result := Result + IntToHex(ByteArr[I], 2);

      Result := Trim(UpperCase(Result));
    finally
      Freemem(pvData);
    end;
  end;
end;

function GetSubjectName(ACertContext: PCCERT_CONTEXT): String;
var
  CertName: {$IfDef UNICODE}WideString{$Else}String{$EndIf};
  BytesRead: DWORD;
begin
  Result := '';
  if Assigned(ACertContext) then
  begin
    SetLength(CertName, 1024);
    BytesRead := CertNameToStr( ACertContext^.dwCertEncodingType,
                      @ACertContext^.pCertInfo^.Subject,
                      CERT_X500_NAME_STR,
                      {$IfDef UNICODE}LPWSTR{$Else}LPSTR{$EndIf}(CertName),
                      1024);
    if BytesRead > 0 then
      SetLength(CertName, BytesRead-1)
    else
      raise EACBrDFeException.Create( 'Falha ao executar "CertNameToStr" em "GetSubjectName". Erro:'+GetLastErrorAsHexaStr);

    Result := String( CertName );
  end;
end;

function GetIssuerName(ACertContext: PCCERT_CONTEXT): String;
var
  CertName: {$IfDef UNICODE}WideString{$Else}String{$EndIf};
  BytesRead: DWORD;
begin
  Result := '';
  if Assigned(ACertContext) then
  begin
    SetLength(CertName, 1024);
    BytesRead := CertNameToStr( ACertContext^.dwCertEncodingType,
                      @ACertContext^.pCertInfo^.Issuer,
                      CERT_X500_NAME_STR,
                      {$IfDef UNICODE}LPWSTR{$Else}LPSTR{$EndIf}(CertName),
                      1024);
    if BytesRead > 0 then
      SetLength(CertName, BytesRead-1)
    else
      raise EACBrDFeException.Create( 'Falha ao executar "CertNameToStr" em "GetIssuerName". Erro:'+GetLastErrorAsHexaStr);

    Result := String( CertName );
  end;
end;

function GetNotBefore(ACertContext: PCCERT_CONTEXT): TDateTime;
var
  LocalFileTime: TFileTime;
  SystemTime: TSystemTime;
begin
  Result := 0;
  if Assigned(ACertContext) then
  begin
    FileTimeToLocalFileTime(TFILETIME(ACertContext^.pCertInfo^.NotBefore), LocalFileTime);
    FileTimeToSystemTime(LocalFileTime, SystemTime);
    Result := SystemTimeToDateTime(SystemTime);
  end;
end;

function GetNotAfter(ACertContext: PCCERT_CONTEXT): TDateTime;
var
  LocalFileTime: TFileTime;
  SystemTime: TSystemTime;
begin
  Result := 0;
  if Assigned(ACertContext) then
  begin
    FileTimeToLocalFileTime(TFILETIME(ACertContext^.pCertInfo^.NotAfter), LocalFileTime);
    FileTimeToSystemTime(LocalFileTime, SystemTime);
    Result := SystemTimeToDateTime(SystemTime);
  end;
end;

function GetCertIsHardware(ACertContext: PCCERT_CONTEXT): Boolean;
var
  dwKeySpec: DWORD;
  pfCallerFreeProv: LongBool;
  ProviderOrKeyHandle: HCRYPTPROV_OR_NCRYPT_KEY_HANDLE;
begin
  ProviderOrKeyHandle := 0;
  dwKeySpec := 0;
  pfCallerFreeProv := False;

  // Obtendo o Contexto do Provedor de Criptografia do Certificado //
  if not CryptAcquireCertificatePrivateKey( ACertContext,
                                            CRYPT_ACQUIRE_ALLOW_NCRYPT_KEY_FLAG,
                                            Nil,
                                            ProviderOrKeyHandle,
                                            dwKeySpec,
                                            pfCallerFreeProv) then
    raise EACBrDFeException.Create( MsgErroGetCryptProvider );

  try
    Result := GetProviderOrKeyIsHardware(ProviderOrKeyHandle, dwKeySpec);
  finally
    if pfCallerFreeProv then
    begin
      if dwKeySpec = CERT_NCRYPT_KEY_SPEC then
        NCryptFreeObject(ProviderOrKeyHandle)
      else
        CryptReleaseContext(ProviderOrKeyHandle, 0);
    end;
  end;
end;

function GetProviderOrKeyIsHardware(
  ProviderOrKeyHandle: HCRYPTPROV_OR_NCRYPT_KEY_HANDLE; dwKeySpec: DWORD
  ): Boolean;
begin
  if dwKeySpec = CERT_NCRYPT_KEY_SPEC then
    Result := GetCNGProviderIsHardware(ProviderOrKeyHandle)
  else
    Result := GetCSPProviderIsHardware(ProviderOrKeyHandle);
end;

function GetCSPProviderParamString(ACryptProvider: HCRYPTPROV; dwParam: DWORD): String;
var
  pdwDataLen: DWORD;
  pbData: PBYTE;
begin
  pdwDataLen := 0;
  if not CryptGetProvParam(ACryptProvider, dwParam, nil, pdwDataLen, 0) then
    raise EACBrDFeException.Create(
        'GetCSPProviderParamString: Falha ao obter BufferSize. Erro:'+GetLastErrorAsHexaStr);

  pbData := AllocMem(pdwDataLen);
  try
    SetLength(Result, pdwDataLen);
    if not CryptGetProvParam(ACryptProvider, dwParam, pbData, pdwDataLen, 0) then
      raise EACBrDFeException.Create(
          'GetCSPProviderParamString: Falha ao Ler Retorno. Erro:'+GetLastErrorAsHexaStr);

    SetLength(Result, pdwDataLen-1);
    Move(pbData^, Result[1], pdwDataLen-1);
  finally
    Freemem(pbData);
  end;
end;

function GetCSPProviderParamDWord(ACryptProvider: HCRYPTPROV; dwParam: DWORD
  ): DWORD;
var
  pdwDataLen: DWORD;
begin
  pdwDataLen := SizeOf(DWORD);
  if not CryptGetProvParam(ACryptProvider, dwParam, @Result, pdwDataLen, 0) then
    raise EACBrDFeException.Create('GetCSPProviderParamDWord. Erro:'+GetLastErrorAsHexaStr);
end;

function GetCSPProviderIsHardware(ACryptProvider: HCRYPTPROV): Boolean;
var
  ImpType: DWORD;
begin
  ImpType := GetCSPProviderParamDWord(ACryptProvider, PP_IMPTYPE);
  Result := ((ImpType and CRYPT_IMPL_HARDWARE) = CRYPT_IMPL_HARDWARE);
end;

function GetCNGProviderParamString(ACryptHandle: NCRYPT_HANDLE; dwParam: LPCWSTR
  ): String;
var
  pdwDataLen, pcbResult: DWORD;
  pbData: PBYTE;
  Ret: SECURITY_STATUS;
begin
  pdwDataLen := 0;
  Ret := NCryptGetProperty(ACryptHandle, dwParam, nil, pdwDataLen, pcbResult, 0);
  if (Ret <> ERROR_SUCCESS) then
    raise EACBrDFeException.Create(
        'GetCNGProviderParamString: Falha ao obter BufferSize. Erro:'+GetLastErrorAsHexaStr);

  pbData := AllocMem(pdwDataLen);
  try
    SetLength(Result, pdwDataLen);
    Ret := NCryptGetProperty(ACryptHandle, dwParam, pbData, pdwDataLen, pcbResult, 0);
    if (Ret <> ERROR_SUCCESS) then
      raise EACBrDFeException.Create(
          'GetCNGProviderParamString: Falha ao Ler Retorno. Erro:'+GetLastErrorAsHexaStr);

    SetLength(Result, pdwDataLen-1);
    Move(pbData^, Result[1], pdwDataLen-1);
  finally
    Freemem(pbData);
  end;
end;

function GetCNGProviderParamDWord(ACryptHandle: NCRYPT_HANDLE;
  dwParam: LPCWSTR): DWORD;
var
  pdwDataLen, pcbResult: DWORD;
  Ret: SECURITY_STATUS;
begin
  Result     := 0;
  pdwDataLen := SizeOf(DWORD);
  pcbResult  := 0;
  Ret := NCryptGetProperty(ACryptHandle, dwParam, @Result, pdwDataLen, pcbResult, 0);
  if (Ret <> ERROR_SUCCESS) then
    raise EACBrDFeException.Create('GetCNGProviderParamDWord. Erro: '+IntToHex(Ret, 8));
end;

function GetCNGProviderIsHardware(ACryptHandle: NCRYPT_HANDLE): Boolean;
var
  ImpType: DWORD;
  hProvider: NCRYPT_PROV_HANDLE;
  pcbResult: DWORD;
  Ret: SECURITY_STATUS;
begin
  try
    // Primeiro obtemos o provider handle a partir do key handle via NCRYPT_PROVIDER_HANDLE_PROPERTY.
    hProvider := 0;
    pcbResult := 0;
    Ret := NCryptGetProperty(ACryptHandle, NCRYPT_PROVIDER_HANDLE_PROPERTY,
             @hProvider, SizeOf(hProvider), pcbResult, 0);
    if Ret <> ERROR_SUCCESS then
      raise EACBrDFeException.Create('GetCNGProviderIsHardware: Erro ao obter Provider Handle: $'+IntToHex(Ret, 8));

    // Para usar com NCRYPT_IMPL_TYPE_PROPERTY, que requer o NCRYPT_PROV_HANDLE e não NCRYPT_KEY_HANDLE.
    try
      ImpType := GetCNGProviderParamDWord(hProvider, NCRYPT_IMPL_TYPE_PROPERTY);
      Result := ((ImpType and NCRYPT_IMPL_HARDWARE_FLAG) = NCRYPT_IMPL_HARDWARE_FLAG);
//      Result := Result or ((ImpType and NCRYPT_IMPL_HARDWARE_RNG_FLAG) = NCRYPT_IMPL_HARDWARE_RNG_FLAG);
    finally
      NCryptFreeObject(hProvider);
    end;
  except
    Result := True;
  end;
end;

function GetProviderInfo(ACertContext: PCCERT_CONTEXT; out
  ProviderType: DWORD; out ProviderName, ContainerName: {$IfDef UNICODE}WideString{$Else}String{$EndIf};
  RaiseExceptions: Boolean): Boolean;
var
  CryptKeyProvInfo: CRYPT_KEY_PROV_INFO;
  pcbData: DWORD;
  pvData: Pointer;
begin
  Result := False;
  ZeroMemory(@CryptKeyProvInfo, SizeOf(CryptKeyProvInfo));

  try
    if not CertGetCertificateContextProperty( ACertContext,
                                              CERT_KEY_PROV_INFO_PROP_ID,
                                              Nil,
                                              pcbData) then
      raise EACBrDFeException.Create( 'GetProviderInfo: Erro obtendo BufferSize de "CERT_KEY_PROV_INFO_PROP_ID"');

    pvData := AllocMem(pcbData);
    try
      if not CertGetCertificateContextProperty( ACertContext,
                                                CERT_KEY_PROV_INFO_PROP_ID,
                                                pvData,
                                                pcbData) then
        raise EACBrDFeException.Create( 'GetProviderInfo: Erro obtendo CERT_KEY_PROV_INFO_PROP_ID');

      CryptKeyProvInfo := CRYPT_KEY_PROV_INFO( pvData^ );
      ProviderType  := CryptKeyProvInfo.dwProvType;
      ProviderName  := {$IfDef UNICODE}WideString{$Else}String{$EndIf}(CryptKeyProvInfo.pwszProvName);
      ContainerName := {$IfDef UNICODE}WideString{$Else}String{$EndIf}(CryptKeyProvInfo.pwszContainerName);

      Result := True;
    finally
      Freemem(pvData);
    end;
  except
    if RaiseExceptions then
      Raise;
  end;
end;

function GetCertExtension(ACertContext: PCCERT_CONTEXT; const ExtensionName: String): PCERT_EXTENSION;
begin
  Result := nil;
  if Assigned(ACertContext) then
    Result := CertFindExtension( LPCSTR( AnsiString(ExtensionName) ),
                                 ACertContext^.pCertInfo^.cExtension,
                                 PCERT_EXTENSION(ACertContext^.pCertInfo^.rgExtension));
end;

function DecodeCertExtensionToNameInfo(AExtension: PCERT_EXTENSION; const ExtensionName: String): PCERT_ALT_NAME_INFO;
var
  BufferSize: DWORD;
begin
  Result := nil;
  if Assigned(AExtension) then
  begin
    BufferSize := 0;
    if not CryptDecodeObject( X509_ASN_ENCODING or PKCS_7_ASN_ENCODING,
                              LPCSTR( AnsiString(ExtensionName) ),
                              AExtension^.Value.pbData,
                              AExtension^.Value.cbData,
                              0,
                              Nil, BufferSize) then  // Pega Tamanho do Retorno
      raise EACBrDFeException.Create(
         'GetCertExtensionName: Falha ao obter BufferSize com "CryptDecodeObject". Erro:'+GetLastErrorAsHexaStr);

    Result := AllocMem(BufferSize);
    if not CryptDecodeObject( X509_ASN_ENCODING or PKCS_7_ASN_ENCODING,
                              LPCSTR( AnsiString(ExtensionName) ),
                              AExtension^.Value.pbData,
                              AExtension^.Value.cbData,
                              0,
                              Result, BufferSize) then
      raise EACBrDFeException.Create(
           'GetCertExtensionName: Falha ao executar "CryptDecodeObject". Erro:'+GetLastErrorAsHexaStr);
  end;
end;

function GetOtherNameBlobFromNameInfo(ANameInfo: PCERT_ALT_NAME_INFO; const AExtensionName: String ): CERT_NAME_BLOB;
type
  ArrCERT_ALT_NAME_ENTRY = array of CERT_ALT_NAME_ENTRY;
var
  I: Cardinal;
  CertNameEntry: CERT_ALT_NAME_ENTRY;
begin
  ZeroMemory(@Result, SizeOf(Result));
  I := 0;
  while (I <= ANameInfo^.cAltEntry) do
  begin
    CertNameEntry := ArrCERT_ALT_NAME_ENTRY(ANameInfo^.rgAltEntry)[I];
    if (CertNameEntry.dwAltNameChoice = CERT_ALT_NAME_OTHER_NAME) and
       (CertNameEntry.pOtherName^.pszObjId = AExtensionName) then
    begin
      Result := CertNameEntry.pOtherName^.Value;
      Break;
    end;

    Inc(I);
  end;
end;

function AdjustAnsiOID(const aOID: AnsiString): AnsiString;
var
  LenOID: Integer;
begin
  Result := aOID;
  LenOID := Length(aOID);
  if LenOID < 2 then Exit;
  if (ord(aOID[1]) <> 4) then Exit;   // Not ANSI

  LenOID := ord(aOID[2]);
  Result := copy(aOID,3,LenOID);
end;

function GetTaxIDFromExtensions(ACertContext: PCCERT_CONTEXT
  ): String;
var
  pExtension: PCERT_EXTENSION;
  pNameInfo: PCERT_ALT_NAME_INFO ;
  ABlob: CERT_NAME_BLOB;
  aOID: AnsiString;
begin
  Result := '';

  if Assigned(ACertContext) then
  begin
    pExtension := GetCertExtension(ACertContext, szOID_SUBJECT_ALT_NAME2);
    if pExtension <> Nil then
    begin
      pNameInfo := DecodeCertExtensionToNameInfo(pExtension, szOID_SUBJECT_ALT_NAME2);
      if pNameInfo <> Nil then
      begin
        try
          ABlob := GetOtherNameBlobFromNameInfo(pNameInfo, '2.16.76.1.3.3');  // Informações de P.F. ou P.J.
          if ABlob.cbData > 0 then
          begin
            aOID := PAnsiChar(ABlob.pbData);
            aOID := AdjustAnsiOID(aOID);
            Result := copy(Trim(aOID), 1, 14);
          end;

          if (Result = '') then
          begin
            ABlob := GetOtherNameBlobFromNameInfo(pNameInfo, '2.16.76.1.3.1');  // Informações de P.F.
            if ABlob.cbData > 0 then
            begin
              aOID := PAnsiChar(ABlob.pbData);
              aOID := AdjustAnsiOID(aOID);
              Result := copy(Trim(aOID), 9, 11);
            end;
          end;
        finally
          Freemem(pNameInfo);
        end;
      end;
    end;
  end;
end;

function CertToDERBase64(ACertContext: PCCERT_CONTEXT ): AnsiString;
var
  Buffer: AnsiString;
begin
  Result := '';
  if Assigned(ACertContext) then
  begin
    SetLength(Buffer, ACertContext^.cbCertEncoded);
    Move(ACertContext^.pbCertEncoded^, Buffer[1], ACertContext^.cbCertEncoded);
    Result := EncodeBase64(Buffer);
  end;
end;

procedure PFXDataToCertContextWinApi(const AData, APass: AnsiString; var AStore,
  ACertContext: Pointer);
var
  PFXBlob: CRYPT_DATA_BLOB;
  PFXCert: PCCERT_CONTEXT;
  wsPass: WideString;
  dwKeySpec: DWORD;
  pfCallerFreeProv: LongBool;
  ProviderOrKeyHandle: HCRYPTPROV_OR_NCRYPT_KEY_HANDLE;
begin
  PFXBlob.cbData := Length(AData);
  PFXBlob.pbData := PBYTE(AData);
  if not PFXIsPFXBlob(PFXBlob) then
    raise EACBrDFeException.Create('PFXDataToCertContextWinApi: DadosPFX informado não são válidos');

  wsPass := WideString( APass );
  if not PFXVerifyPassword(PFXBlob, LPCWSTR(wsPass), 0) then
    raise EACBrDFeException.Create('PFXDataToCertContextWinApi: Senha informada está errada');

  AStore := PFXImportCertStore( PFXBlob, LPCWSTR(wsPass),
                                CRYPT_EXPORTABLE {or
                                PKCS12_ALLOW_OVERWRITE_KEY or
                                PKCS12_PREFER_CNG_KSP or
                                PKCS12_INCLUDE_EXTENDED_PROPERTIES});
  if AStore = nil then
    raise EACBrDFeException.Create(
      'PFXDataToCertContextWinApi: Falha em "PFXImportCertStore" Erro: '+GetLastErrorAsHexaStr);

  // Varre cadeia de certificados lidos, e procura por Certificado do Cliente //
  ACertContext := Nil;
  PFXCert := Nil;
  PFXCert := CertEnumCertificatesInStore(AStore, PCCERT_CONTEXT(PFXCert)^);
  while (PFXCert <> Nil) and (ACertContext = Nil) do
  begin
    // Verificando se o Certificado tem Chave Privada
    pfCallerFreeProv := False;
    ProviderOrKeyHandle := 0;
    dwKeySpec := 0;
    if CryptAcquireCertificatePrivateKey( PFXCert,
                                          CRYPT_ACQUIRE_ALLOW_NCRYPT_KEY_FLAG,
                                          Nil,
                                          ProviderOrKeyHandle,
                                          dwKeySpec,
                                          pfCallerFreeProv) then
    begin
      ACertContext := PFXCert
    end;

    if pfCallerFreeProv and (ProviderOrKeyHandle <> 0) then
    begin
      if dwKeySpec = CERT_NCRYPT_KEY_SPEC then
        NCryptFreeObject(ProviderOrKeyHandle)
      else
        CryptReleaseContext(ProviderOrKeyHandle, 0);
    end;

    if ACertContext = Nil then
      PFXCert := CertEnumCertificatesInStore(AStore, PCCERT_CONTEXT(PFXCert)^);
  end;

  if (ACertContext = Nil) then
    raise EACBrDFeException.Create(
      'PFXDataToCertContextWinApi: Falha ao localizar o Certificado com a Chave Privada.');
end;

function ExportCertContextToPFXData(ACertContext: PCCERT_CONTEXT; const APass: AnsiString
  ): AnsiString;
type
  ArrPCERT_CHAIN_ELEMENT = array of PCERT_CHAIN_ELEMENT;
var
  PFXBlob: CRYPT_DATA_BLOB;
  dwFlags, I: DWORD;
  AStore: HCERTSTORE;
  Dummy: PCCERT_CONTEXT;
  AFileTime: TFileTime;
  ChainPara: CERT_CHAIN_PARA;
  pChainContext: PCCERT_CHAIN_CONTEXT;

  procedure AddCertContexToStoreMemory(NewCertContext: PCCERT_CONTEXT);
  begin
    // Adicionando o Certificado Atual, na nova Store
    Dummy := Nil;
    if not CertAddCertificateContextToStore( AStore, NewCertContext,
                                             CERT_STORE_ADD_REPLACE_EXISTING,
                                             Dummy ) then
      raise EACBrDFeException.Create(
        'ExportCertStoreToPFXData: Falha Importanto Certificado na Store. Erro: '+GetLastErrorAsHexaStr);
    CertFreeCertificateContext( Dummy );
  end;

begin
  // Criando uma Store em memória, para ser exportada
  AStore := CertOpenStore( CERT_STORE_PROV_MEMORY, 0, 0, 0, Nil );
  if (AStore = Nil) then
    raise EACBrDFeException.Create(
      'ExportCertStoreToPFXData: Falha Criando Store. Erro: '+GetLastErrorAsHexaStr);

  try
    // Adicionando o Certificado Recebido, no Store temporário  //
    AddCertContexToStoreMemory( ACertContext );

    // Verificando se o Certificado Informado, pode ter sua Chave Privada, Exportada //
    PFXBlob.cbData := 0;
    PFXBlob.pbData := Nil;
    dwFlags := (EXPORT_PRIVATE_KEYS or
                REPORT_NOT_ABLE_TO_EXPORT_PRIVATE_KEY or
                PKCS12_INCLUDE_EXTENDED_PROPERTIES);

    if not PFXExportCertStoreEx( AStore, PFXBlob,
                                 LPCWSTR(WideString( APass )),
                                 Nil, dwFlags) then
      raise EACBrDFeExceptionNoPrivateKey.Create('Certificado não permite Exportar Chave Privada.');

    // Obtendo a cadeia de Certificados ///
    Dummy := Nil;
    pChainContext := Nil;
    ZeroMemory(@ChainPara, SizeOf(ChainPara));
    ChainPara.cbSize := sizeof( CERT_CHAIN_PARA );
    ChainPara.RequestedUsage.dwType                     := USAGE_MATCH_TYPE_AND;
    ChainPara.RequestedUsage.Usage.cUsageIdentifier     := 0;
    ChainPara.RequestedUsage.Usage.rgpszUsageIdentifier := Nil;

    if not CertGetCertificateChain(
            HCCE_CURRENT_USER,  // use the default chain engine
            ACertContext,       // pointer to the end certificate
            AFileTime,          // use the default time
            Nil,                // ACertContext^.hCertStore,
            ChainPara,          // use AND logic and enhanced key usage as indicated in the ChainPara data structure
            0,                  // No Flags
            Dummy,              // currently reserved
            pChainContext) then
      raise EACBrDFeException.Create(
        'ExportCertStoreToPFXData: Falha obtendo a cadeia de Certificados. Erro: '+GetLastErrorAsHexaStr);

    // Adicionando todos Certificados da Cadeia, no Store temporário //
    try
      for I := 0 to pChainContext^.rgpChain^.cElement - 1 do
        AddCertContexToStoreMemory( ArrPCERT_CHAIN_ELEMENT(pChainContext^.rgpChain^.rgpElement)[I]^.pCertContext );
    finally
      CertFreeCertificateChain( pChainContext );
    end;

    // Adicionando o Certificado Recebido, no Store temporário (na ordem correta)  //
    AddCertContexToStoreMemory( ACertContext );

    // Exportando a Store, com todos os certificados //
    Result := '';
    PFXBlob.cbData := 0;
    PFXBlob.pbData := Nil;
    dwFlags := (EXPORT_PRIVATE_KEYS or
                PKCS12_INCLUDE_EXTENDED_PROPERTIES);

    if not PFXExportCertStoreEx( AStore, PFXBlob,
                                 LPCWSTR(WideString( APass )),
                                 Nil, dwFlags) then
      raise EACBrDFeException.Create(
        'ExportCertStoreToPFXData: Falha em calcular tamanho do buffer. Erro: '+GetLastErrorAsHexaStr);

    PFXBlob.pbData := AllocMem(PFXBlob.cbData);  // Aloca a memória para receber o Blob
    try
      if not PFXExportCertStoreEx( AStore, PFXBlob,
                                   LPCWSTR(WideString( APass )),
                                   Nil, dwFlags) then
        raise EACBrDFeException.Create(
          'ExportCertStoreToPFXData: Falha em "PFXExportCertStoreEx" Erro: '+GetLastErrorAsHexaStr);

      SetLength(Result, PFXBlob.cbData);
      Move(PFXBlob.pbData^, Result[1], PFXBlob.cbData);
    finally
      Freemem(PFXBlob.pbData);
    end;
  finally
    CertCloseStore(AStore, CERT_CLOSE_STORE_CHECK_FLAG);
  end;
end;

procedure SetCertContextPassword(ACertContext: PCCERT_CONTEXT; const APass: AnsiString;
  RaiseUnknownErrors: Boolean);
var
  dwKeySpec: DWORD;
  pfCallerFreeProv: LongBool;
  Ret: Longint;
  ProviderOrKeyHandle: HCRYPTPROV_OR_NCRYPT_KEY_HANDLE;
  PPass: PBYTE;

  procedure CheckPINError(WinErro: DWORD; RaiseUnknown: Boolean);
  begin
    case WinErro of
      NO_ERROR:
        Exit;

      ERROR_NO_TOKEN:
        Exit; // https://www.projetoacbr.com.br/forum/topic/36266-falha-ao-definir-pin-do-certificado-erro-80100004/?do=findComment&comment=237860

      //NTE_BAD_DATA:
      //  Exit;

      SCARD_W_WRONG_CHV:
        raise EACBrDFeWrongPINException.Create('O cartão não pode ser acessado porque o PIN errado foi apresentado.');

      SCARD_W_CHV_BLOCKED:
        raise EACBrDFeWrongPINException.Create('O cartão não pode ser acessado porque o número máximo de tentativas de entrada de PIN foi atingido');
    else
      if RaiseUnknown then
        raise EACBrDFeException.Create('Falha ao Definir PIN do Certificado. Erro: '+GetLastErrorAsHexaStr(WinErro));
    end;
  end;

begin
  ProviderOrKeyHandle := 0;
  dwKeySpec := 0;
  pfCallerFreeProv := False;

  if APass = '' then
    PPass := Nil
  else
    PPass := PBYTE(APass);

  // Obtendo o Contexto do Provedor de Criptografia do Certificado //
  if not CryptAcquireCertificatePrivateKey( ACertContext,
                                            CRYPT_ACQUIRE_ALLOW_NCRYPT_KEY_FLAG,
                                            Nil,
                                            ProviderOrKeyHandle,
                                            dwKeySpec,
                                            pfCallerFreeProv) then
    raise EACBrDFeException.Create( MsgErroGetCryptProvider );

  try
    if dwKeySpec = CERT_NCRYPT_KEY_SPEC then
    begin
      if not GetCNGProviderIsHardware(ProviderOrKeyHandle) then
        Exit;

      Ret := NCryptSetProperty( ProviderOrKeyHandle,    // Não testado...
                                NCRYPT_PIN_PROPERTY,
                                PBYTE(APass),
                                Length(APass)+1, 0);
      CheckPINError(Ret, RaiseUnknownErrors);
    end
    else
    begin
      if not GetCSPProviderIsHardware(ProviderOrKeyHandle) then
        Exit;

      CryptSetProvParam(ProviderOrKeyHandle, PP_SIGNATURE_PIN, PPass, 0);
      CheckPINError(GetLastError, False);

      CryptSetProvParam(ProviderOrKeyHandle, PP_KEYEXCHANGE_PIN, PPass, 0);
      CheckPINError(GetLastError, RaiseUnknownErrors);
    end;
  finally
    if pfCallerFreeProv then
    begin
      if dwKeySpec = CERT_NCRYPT_KEY_SPEC then
        NCryptFreeObject(ProviderOrKeyHandle)
      else
        CryptReleaseContext(ProviderOrKeyHandle, 0);
    end;
  end;
end;

end.
