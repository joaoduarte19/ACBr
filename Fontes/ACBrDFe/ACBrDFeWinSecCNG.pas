{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2020 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:  André Ferreira de Moraes                       }
{                               Arimateia Jr (https://nuvemfiscal.com.br       }
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

unit ACBrDFeWinSecCNG;

interface

uses
  Classes, SysUtils, Windows,
  ACBrDFeSSL, ACBrDFeException,
  ACBr_WinCrypt, ACBr_NCrypt, ACBr_BCrypt;

type
  { TDFeWinCrypt }

  TDFeWinSecCNGCrypt = class(TDFeSSLCryptClass)
  private
    procedure GetCertContextInfo(ADadosCertificado: TDadosCertificado;
      ACertContext: PCCERT_CONTEXT; CheckIsHardware: Boolean);
    procedure OpenSystemStore;
    function SignHashCNG(const AHashValue: AnsiString; pszAlgId: LPCWSTR): AnsiString;
    function SignHashCSP(const AHashValue: AnsiString; aHashType: DWORD): AnsiString;
  protected
    FpCertContext: PCCERT_CONTEXT;
    FpStore: HCERTSTORE;
    FpPFXData: AnsiString;

    function GetCertContextWinApi: Pointer; override;
    function GetCertPFXData: AnsiString; override;

    procedure CarregarCertificadoDeDadosPFX; override;
    procedure CarregarCertificadoDeNumeroSerie; override;
    procedure LerInfoCertificadoCarregado; override;
  public
    constructor Create(ADFeSSL: TDFeSSL); override;
    destructor Destroy; override;

    function Versao: String; override;
    function CalcHash( const AStream : TStream;
       const Digest: TSSLDgst;
       const Assina: Boolean =  False): AnsiString; override;

    function ValidarHash( const AStream : TStream;
       const Digest: TSSLDgst;
       const Hash: AnsiString;
       const Assinado: Boolean =  False): Boolean; override;

    function SelecionarCertificado: String; override;
    procedure LerCertificadosStore; override;
    procedure DescarregarCertificado; override;
    function CarregarCertificadoPublico(const DadosX509Base64: Ansistring): Boolean; override;

    property Certificado: PCCERT_CONTEXT read FpCertContext;
  end;

Var
  CertificadosA3ComPin: String;

implementation

uses
  strutils, typinfo, comobj,
  synautil, synacode,
  ACBrUtil.FilesIO,
  ACBrDFeCry.WinUtils;

{ TDFeWinSecCNGCrypt }

constructor TDFeWinSecCNGCrypt.Create(ADFeSSL: TDFeSSL);
begin
  inherited Create(ADFeSSL);

  FpCertContext := Nil;
  FpStore := Nil;
  FpPFXData := '';

  Clear;
end;

destructor TDFeWinSecCNGCrypt.Destroy;
begin
  DescarregarCertificado;

  inherited Destroy;
end;

function TDFeWinSecCNGCrypt.Versao: String;
begin
  Result := Crypt32 + ' '+ GetFileVersion(Crypt32);
end;

procedure TDFeWinSecCNGCrypt.OpenSystemStore;
var
  StoreFlag: DWORD;
  StoreProvider: LPCSTR;
begin
  if (FpStore <> Nil) then
    Exit;

  //TODO: Mapeaer demais tipos
  case FpDFeSSL.StoreLocation of
    slLocalMachine : StoreFlag := CERT_SYSTEM_STORE_LOCAL_MACHINE;
  else
    StoreFlag := CERT_SYSTEM_STORE_CURRENT_USER;
  end;

  {$IfDef DELPHI2009_UP}
   StoreProvider := CERT_STORE_PROV_SYSTEM_W;
  {$ELSE}
   StoreProvider := CERT_STORE_PROV_SYSTEM_A;
  {$ENDIF};

  FpStore := CertOpenStore(
      StoreProvider, 0, 0,
      StoreFlag or CERT_STORE_READONLY_FLAG,
      LPCTSTR( FpDFeSSL.StoreName ) );
  //FpStore := CertOpenSystemStore( 0, LPCTSTR(FpDFeSSL.StoreName) );

  if (FpStore = Nil) then
    raise EACBrDFeException.Create(
      'TDFeWinCrypt. Erro ao abrir StoreName: ' + FpDFeSSL.StoreName +
      ' Location: ' + IntToStr(Integer(FpDFeSSL.StoreLocation)));

  //BufferSize := 0;
  //CertGetStoreProperty(FpStore, CERT_STORE_LOCALIZED_NAME_PROP_ID, nil, BufferSize);
  //SetLength(AStoreName, BufferSize);
  //CertGetStoreProperty(FpStore, CERT_STORE_LOCALIZED_NAME_PROP_ID, @AStoreName[1], BufferSize)
end;

function TDFeWinSecCNGCrypt.GetCertContextWinApi: Pointer;
begin
  CarregarCertificadoSeNecessario;
  Result := FpCertContext;
end;

function TDFeWinSecCNGCrypt.GetCertPFXData: AnsiString;
begin
  if FpPFXData = '' then
  begin
    CarregarCertificadoSeNecessario;
    if (FpDFeSSL.DadosPFX = '') then
      FpPFXData := ExportCertContextToPFXData(FpCertContext, FpDFeSSL.Senha)
    else
      FpPFXData := FpDFeSSL.DadosPFX;
  end;

  //DEBUG
  //WriteToFile('c:\temp\CertACBr.pfx', FpPFXData );
  Result := FpPFXData;
end;

procedure TDFeWinSecCNGCrypt.CarregarCertificadoDeDadosPFX;
begin
  OpenSystemStore;
  PFXDataToCertContextWinApi( FpDFeSSL.DadosPFX,
                              FpDFeSSL.Senha,
                              FpStore,
                              Pointer(FpCertContext))
end;

procedure TDFeWinSecCNGCrypt.CarregarCertificadoDeNumeroSerie;
var
  ACertContext: PCCERT_CONTEXT;
begin
  ACertContext := Nil;
  OpenSystemStore;
  ACertContext := CertEnumCertificatesInStore(FpStore, ACertContext^);
  while (ACertContext <> nil) and (FpCertContext = nil) do
  begin
    if (GetSerialNumber(ACertContext) = FpDFeSSL.NumeroSerie) then
      FpCertContext := ACertContext
    else
      ACertContext := CertEnumCertificatesInStore(FpStore, ACertContext^);  // Pega o próximo
  end;

  if (FpCertContext = Nil) then
    raise EACBrDFeException.Create('Certificado Série: "'+FpDFeSSL.NumeroSerie+'", não encontrado!');
end;

procedure TDFeWinSecCNGCrypt.LerInfoCertificadoCarregado;
begin
  // Não Achou ? //
  if (FpCertContext = Nil) then
    raise EACBrDFeException.Create('Certificado Digital não Carregado!');

  // Obtendo propriedades do Certificado //
  GetCertContextInfo( FpDadosCertificado, FpCertContext, True );
  FpCertificadoLido := True;

  // Se necessário atribui a Senha para o Certificado //
  if (FpDadosCertificado.Tipo = tpcA3) and
     (FpDFeSSL.Senha <> '') and
     (pos(FpDadosCertificado.NumeroSerie, CertificadosA3ComPin) = 0) then  // Se Atribuir novamente em outra instância causa conflito... //
  begin
    try
      SetCertContextPassword(FpCertContext, FpDFeSSL.Senha, False);
      CertificadosA3ComPin := CertificadosA3ComPin + FpDadosCertificado.NumeroSerie + ',';
    except
      On EACBrDFeWrongPINException do
      begin
        FpDFeSSL.Senha := '';  // A senha está errada... vamos remove-la para não tentar novamente...
        raise;
      end;

      On E: Exception do
        raise;
    end;
  end;
end;

procedure TDFeWinSecCNGCrypt.GetCertContextInfo(ADadosCertificado: TDadosCertificado;
  ACertContext: PCCERT_CONTEXT; CheckIsHardware: Boolean);
begin
  with ADadosCertificado do
  begin
    Clear;
    if CheckIsHardware then
    begin
      try
        if GetCertIsHardware(ACertContext) then  // Pode falhar com certificado CNG
          Tipo := tpcA3
        else
          Tipo := tpcA1;
      except
      end;
    end;

    NumeroSerie := GetSerialNumber(ACertContext);
    ThumbPrint  := GetThumbPrint(ACertContext);
    SubjectName := GetSubjectName(ACertContext);
    if CNPJ = '' then
      CNPJ := GetTaxIDFromExtensions(ACertContext);

    DataVenc   := GetNotAfter(ACertContext);
    DataInicioValidade := GetNotBefore(ACertContext);
    IssuerName := GetIssuerName(ACertContext);
    DERBase64  := CertToDERBase64(ACertContext);
  end;
end;

function TDFeWinSecCNGCrypt.SelecionarCertificado: String;
var
  ACertContext: PCCERT_CONTEXT;
begin
  Result := '';
  DescarregarCertificado;
  OpenSystemStore;

  ACertContext := CryptUIDlgSelectCertificateFromStore(
      FpStore,
      0,
      'Selecione um Certificado',
      'Selecione o Certificado que deseja utilizar:',
      CRYPTUI_SELECT_LOCATION_COLUMN or CRYPTUI_SELECT_ISSUEDBY_COLUMN or CRYPTUI_SELECT_INTENDEDUSE_COLUMN,
      0,
      Nil);

  if ACertContext <> Nil then
     Result := GetSerialNumber(ACertContext);

  DescarregarCertificado;

  if (Result <> '') then
  begin
    FpDFeSSL.NumeroSerie := Result;
    CarregarCertificado;
  end;
end;

procedure TDFeWinSecCNGCrypt.LerCertificadosStore;
var
  ACertContext: PCCERT_CONTEXT;
  ADadosCertificado: TDadosCertificado;
  FecharStore: Boolean;
begin
  FpListaCertificados.Clear;
  FecharStore := (FpStore = nil);
  OpenSystemStore;

  try
    ACertContext := nil;
    ACertContext := CertEnumCertificatesInStore(FpStore, ACertContext^);
    while (ACertContext <> nil) do
    begin
      ADadosCertificado := FpListaCertificados.New;
      GetCertContextInfo(ADadosCertificado, ACertContext, False);
      ACertContext := CertEnumCertificatesInStore(FpStore, ACertContext^);
    end;
  finally
    if FecharStore and Assigned(FpStore) then
    begin
      CertCloseStore(FpStore, CERT_CLOSE_STORE_CHECK_FLAG);
      FpStore := Nil;
    end;
  end;
end;

procedure TDFeWinSecCNGCrypt.DescarregarCertificado;
var
  CryptProv: HCRYPTPROV;
  ProviderType: Cardinal;
  ProviderName, ContainerName: {$IfDef UNICODE}WideString{$Else}String{$EndIf};
  Ok: BOOL;
  ProviderOrKeyHandle: HCRYPTPROV_OR_NCRYPT_KEY_HANDLE;
  dwKeySpec: DWORD;
  pfCallerFreeProv: LongBool;
  RetDeleteKey: SECURITY_STATUS;
begin
  if (FpDadosCertificado.NumeroSerie <> '') and (Pos(FpDadosCertificado.NumeroSerie, CertificadosA3ComPin) > 0) then
  begin
    try
      SetCertContextPassword( FpCertContext, '' );
      // Apenas Remove da lista de "CertificadosA3ComPin", se conseguiu limpar o Cache do PIN
      CertificadosA3ComPin := StringReplace( CertificadosA3ComPin, FpDadosCertificado.NumeroSerie + ',', '', [rfReplaceAll]);
    except
    end;
  end;

  // Limpando objetos de criptografia //
  if Assigned(FpCertContext) then
  begin
    // Chave foi importada de um arquivo PFX?
    if (FpDadosCertificado.Tipo = tpcA1) and
       (FpDFeSSL.NumeroSerie = '') and (FpDFeSSL.DadosPFX <> '') then
    begin
      // Se a chave foi importada via PFX sem PKCS12_NO_PERSIST_KEY, ela foi
      // persistida em disco. Precisamos removê-la ao descarregar.
      // Veja: PKCS12_NO_PERSIST_KEY na documentação sobre PFXImportCertStore
      // https://learn.microsoft.com/en-us/windows/win32/api/wincrypt/nf-wincrypt-pfximportcertstore
      ProviderOrKeyHandle := 0;
      dwKeySpec := 0;
      pfCallerFreeProv := False;

      if CryptAcquireCertificatePrivateKey( FpCertContext,
                                            CRYPT_ACQUIRE_ALLOW_NCRYPT_KEY_FLAG,
                                            Nil,
                                            ProviderOrKeyHandle,
                                            dwKeySpec,
                                            pfCallerFreeProv) then
      begin
        try
          if dwKeySpec = CERT_NCRYPT_KEY_SPEC then
          begin
            // Chave CNG: remover via NCryptDeleteKey também libera o handle automaticamente
            RetDeleteKey := NCryptDeleteKey(ProviderOrKeyHandle, 0);
            if RetDeleteKey <> ERROR_SUCCESS then
            begin
              //Note: The NCryptDeleteKey function deletes the key and frees the handle.
              //Applications may use NCryptFreeObject function to free the handle if NCryptDeleteKey fails.
              //https://learn.microsoft.com/en-us/windows/win32/api/ncrypt/nf-ncrypt-ncryptdeletekey
              //TODO: Tratar Erros
              //
              //NTE_BAD_FLAGS
              //NTE_INVALID_HANDLE
            end;

            pfCallerFreeProv := False;
          end
          else
          begin
            // Chave CSP: remover via CryptAcquireContext + CRYPT_DELETEKEYSET
            if pfCallerFreeProv then
              CryptReleaseContext(ProviderOrKeyHandle, 0);
            pfCallerFreeProv := False;

            OK := GetProviderInfo(FpCertContext, ProviderType, ProviderName, ContainerName, False);
            if OK then
              CryptAcquireContext( CryptProv,
                                   {$IfDef UNICODE}LPWSTR{$Else}LPSTR{$EndIf}(ContainerName),
                                   {$IfDef UNICODE}LPWSTR{$Else}LPSTR{$EndIf}(ProviderName),
                                   ProviderType, CRYPT_DELETEKEYSET);
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
    end;

    CertFreeCertificateContext(FpCertContext);
  end;

  if Assigned(FpStore) then
    CertCloseStore(FpStore, CERT_CLOSE_STORE_CHECK_FLAG);

  FpCertContext := Nil;
  FpStore := Nil;
  FpPFXData := '';

  inherited DescarregarCertificado;
end;

function TDFeWinSecCNGCrypt.CarregarCertificadoPublico(const DadosX509Base64: Ansistring
  ): Boolean;
var
  BinaryX509: AnsiString;
begin
  DescarregarCertificado;

  BinaryX509 := DecodeBase64( DadosX509Base64 );

  OpenSystemStore;

  FpCertContext := CertCreateCertificateContext( X509_ASN_ENCODING,
                                                 PBYTE(BinaryX509),
                                                 Length(BinaryX509) );
  GetCertContextInfo(FpDadosCertificado, FpCertContext, False);
  Result := (FpDadosCertificado.SubjectName <> '');
end;

function TDFeWinSecCNGCrypt.SignHashCNG(const AHashValue: AnsiString;
  pszAlgId: LPCWSTR): AnsiString;
var
  ProviderOrKeyHandle: HCRYPTPROV_OR_NCRYPT_KEY_HANDLE;
  dwKeySpec: DWORD;
  pfCallerFreeProv: LongBool;
  PaddingInfo: TBCryptPKCS1PaddingInfo;
  cbSignature, pcbResult: DWORD;
  Ret: SECURITY_STATUS;
begin
  Result := '';

  CarregarCertificadoSeNecessario;
  if not Assigned(FpCertContext) then
    raise EACBrDFeException.Create('Certificado não pode ser carregado');

  ProviderOrKeyHandle := 0;
  dwKeySpec := 0;
  pfCallerFreeProv := False;

  if not CryptAcquireCertificatePrivateKey( FpCertContext,
                                            CRYPT_ACQUIRE_PREFER_NCRYPT_KEY_FLAG,
                                            Nil,
                                            ProviderOrKeyHandle,
                                            dwKeySpec,
                                            pfCallerFreeProv) then
    raise EACBrDFeException.Create( MsgErroGetCryptProvider );

  try
    if dwKeySpec = CERT_NCRYPT_KEY_SPEC then
    begin
      // Assinatura via CNG (NCrypt) //
      PaddingInfo.pszAlgId := pszAlgId;

      // Obtendo o tamanho da assinatura //
      Ret := NCryptSignHash( ProviderOrKeyHandle, @PaddingInfo,
                              PBYTE(@AHashValue[1]), Length(AHashValue),
                              nil, 0, pcbResult,
                              NCRYPT_PAD_PKCS1_FLAG);
      if Ret <> 0 then
        raise EACBrDFeException.Create('NCryptSignHash (len): Erro $'+IntToHex(Ret, 8));

      cbSignature := pcbResult;
      SetLength(Result, cbSignature);

      // NCryptSignHash já retorna em Big Endian (não precisa inverter) //
      Ret := NCryptSignHash( ProviderOrKeyHandle, @PaddingInfo,
                              PBYTE(@AHashValue[1]), Length(AHashValue),
                              PBYTE(@Result[1]), cbSignature, pcbResult,
                              NCRYPT_PAD_PKCS1_FLAG);
      if Ret <> 0 then
        raise EACBrDFeException.Create('NCryptSignHash: Erro $'+IntToHex(Ret, 8));

      SetLength(Result, pcbResult);
    end
    else
    begin
      // Fallback: Assinatura via CSP legada //
      Result := SignHashCSP(AHashValue, dwKeySpec);
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

function TDFeWinSecCNGCrypt.SignHashCSP(const AHashValue: AnsiString;
  aHashType: DWORD): AnsiString;
var
  mCryptProvider, mCryptProviderCert: HCRYPTPROV;
  mHash, aCSPHashType: HCRYPTHASH;
  hRSAKey, hSessKey, hExpKey: HCRYPTKEY;
  I: Integer;
  mBytesLen, dwKeySpec: DWORD;
  Memory: Pointer;
  mHashBuffer: array [0..1023] of AnsiChar;
  pfCallerFreeProv: LongBool;
begin
  Result := '';

  CarregarCertificadoSeNecessario;
  if not Assigned(FpCertContext) then
    raise EACBrDFeException.Create('Certificado não pode ser carregado pela MS CryptoAPI');

  // aHashType aqui recebe dwKeySpec (AT_KEYEXCHANGE ou AT_SIGNATURE) //
  dwKeySpec := aHashType;

  mCryptProvider := 0;
  mCryptProviderCert := 0;
  mHash := 0;
  hRSAKey := 0;
  hExpKey := 0;
  hSessKey := 0;
  pfCallerFreeProv := False;

  try
    try
      if not CryptAcquireContext( mCryptProvider, Nil, Nil,
                                  PROV_RSA_AES, CRYPT_VERIFYCONTEXT) then
        raise Exception.Create('CryptAcquireContext: '+MsgErroGetCryptProvider);

      // Obtendo o Contexto do Provedor de Criptografia do Certificado //
      if CryptAcquireCertificatePrivateKey( FpCertContext, 0, Nil,
                                            mCryptProviderCert,
                                            dwKeySpec,
                                            pfCallerFreeProv) then
      begin
        if GetCSPProviderIsHardware( mCryptProviderCert ) then
        begin
          CryptReleaseContext(mCryptProvider, 0);
          mCryptProvider := mCryptProviderCert;
          pfCallerFreeProv := False;
        end
        else
        begin
          if CryptGetUserKey(mCryptProviderCert, dwKeySpec, hRSAKey) then
          begin
            try
              mBytesLen := 0;
              if CryptExportKey( hRSAKey, hSessKey, PRIVATEKEYBLOB, 0, Nil, mBytesLen ) then
              begin
                Memory := AllocMem(mBytesLen);
                try
                  if CryptExportKey( hRSAKey, hSessKey, PRIVATEKEYBLOB, 0, Memory, mBytesLen ) then
                  begin
                    if not CryptImportKey(mCryptProvider, Memory, mBytesLen, hSessKey, 0, hExpKey ) then
                      raise Exception.Create('CryptImportKey');
                  end
                  else
                    raise Exception.Create('CryptExportKey');
                finally
                  Freemem(Memory);
                end;
              end
              else
                raise Exception.Create('CryptExportKey - len');
            except
              CryptReleaseContext(mCryptProvider, 0);
              mCryptProvider := mCryptProviderCert;
              pfCallerFreeProv := False;
            end;
          end
          else
            raise Exception.Create('CryptGetUserKey');
        end
      end
      else
        raise Exception.Create( MsgErroGetCryptProvider );

      // Determinando o tipo de hash CSP correspondente //
      aCSPHashType := CALG_SHA_256;
      if Length(AHashValue) = 16 then aCSPHashType := CALG_MD5
      else if Length(AHashValue) = 20 then aCSPHashType := CALG_SHA1
      else if Length(AHashValue) = 32 then aCSPHashType := CALG_SHA_256
      else if Length(AHashValue) = 64 then aCSPHashType := CALG_SHA_512;

      // Criando o hash e definindo o valor já calculado //
      if not CryptCreateHash(mCryptProvider, aCSPHashType, 0, 0, mHash) then
        raise Exception.Create('CryptCreateHash');

      if not CryptSetHashParam(mHash, HP_HASHVAL, PBYTE(@AHashValue[1]), 0) then
        raise Exception.Create('CryptSetHashParam');

      // Assinando //
      mBytesLen := Length(mHashBuffer);
      FillChar(mHashBuffer, mBytesLen, #0);

      if CryptSignHash(mHash, dwKeySpec, Nil, 0, @mHashBuffer, mBytesLen ) then
      begin
        // MS CryptoAPI retorna assinatura em "Little Endian bit string", invertendo...
        Result := '';
        while (mBytesLen > 256) and (mHashBuffer[mBytesLen-1] = #0) do
          Dec(mBytesLen);

        for I := mBytesLen downto 1 do
          Result := Result + mHashBuffer[I-1];
      end
      else
        raise Exception.Create('CryptSignHash');

    except
      On E: Exception do
        raise EACBrDFeException.Create(E.Message+' , erro: $'+ GetLastErrorAsHexaStr);
    end;
  finally
    if mHash <> 0 then
      CryptDestroyHash(mHash);

    if hRSAKey <> 0 then
      CryptDestroyKey( hRSAKey );

    if hExpKey <> 0 then
      CryptDestroyKey( hExpKey );

    if pfCallerFreeProv then
      CryptReleaseContext(mCryptProviderCert, 0);

    if mCryptProvider <> 0 then
      CryptReleaseContext(mCryptProvider, 0);
  end;
end;

function TDFeWinSecCNGCrypt.CalcHash(const AStream: TStream; const Digest: TSSLDgst;
  const Assina: Boolean): AnsiString;
var
  hAlg: BCRYPT_ALG_HANDLE;
  hHash: BCRYPT_HASH_HANDLE;
  cbHashLen, cbRead, Ret: DWORD;
  mTotal: Int64;
  Memory: Pointer;
  HashValue: AnsiString;
  wsAlgId: WideString;
begin
  Result := '';

  case Digest of
    dgstMD2    : wsAlgId := BCRYPT_MD2_ALGORITHM;
    dgstMD4    : wsAlgId := BCRYPT_MD4_ALGORITHM;
    dgstMD5    : wsAlgId := BCRYPT_MD5_ALGORITHM;
    dgstSHA    : wsAlgId := BCRYPT_SHA1_ALGORITHM;
    dgstSHA1   : wsAlgId := BCRYPT_SHA1_ALGORITHM;
    dgstSHA256 : wsAlgId := BCRYPT_SHA256_ALGORITHM;
    dgstSHA512 : wsAlgId := BCRYPT_SHA512_ALGORITHM;
  else
    raise EACBrDFeException.Create( 'Digest '+GetEnumName(TypeInfo(TSSLDgst),Integer(Digest))+
                                    ' não suportado em '+ClassName);
  end ;

  hAlg := 0;
  hHash := 0;

  try
    try
      // Abrindo provedor de algoritmo BCrypt (CNG) //
      Ret := BCryptOpenAlgorithmProvider(hAlg, LPCWSTR(wsAlgId), nil, 0);
      if Ret <> 0 then
        raise Exception.Create('BCryptOpenAlgorithmProvider: Erro $'+IntToHex(Ret, 8));

      // Criando objeto de Hash //
      Ret := BCryptCreateHash(hAlg, hHash, nil, 0, nil, 0, 0);
      if Ret <> 0 then
        raise Exception.Create('BCryptCreateHash: Erro $'+IntToHex(Ret, 8));

      // Alimentando o Hash com os dados do Stream //
      Memory := Allocmem(CBufferSize);
      try
        mTotal := AStream.Size;
        AStream.Position := 0;
        repeat
          cbRead := AStream.Read(Memory^, CBufferSize);
          if cbRead > 0 then
          begin
            Ret := BCryptHashData(hHash, PUCHAR(Memory), cbRead, 0);
            if Ret <> 0 then
              raise Exception.Create('BCryptHashData: Erro $'+IntToHex(Ret, 8));
          end;

          mTotal := mTotal - cbRead;
        until mTotal < 1;
      finally
        FreeMem(Memory);
      end;

      // Obtendo o tamanho do Hash e finalizando //
      cbHashLen := 0;
      Ret := BCryptGetProperty(hAlg, BCRYPT_HASH_LENGTH, PUCHAR(@cbHashLen), SizeOf(cbHashLen), cbRead, 0);
      if Ret <> 0 then
        raise Exception.Create('BCryptGetProperty(BCRYPT_HASH_LENGTH): Erro $'+IntToHex(Ret, 8));

      SetLength(HashValue, cbHashLen);
      Ret := BCryptFinishHash(hHash, PUCHAR(@HashValue[1]), cbHashLen, 0);
      if Ret <> 0 then
        raise Exception.Create('BCryptFinishHash: Erro $'+IntToHex(Ret, 8));

      if Assina then
        Result := SignHashCNG(HashValue, LPCWSTR(wsAlgId))
      else
        Result := HashValue;

    except
      On E: Exception do
        raise EACBrDFeException.Create(E.Message+' , erro: $'+ GetLastErrorAsHexaStr);
    end;
  finally
    if hHash <> 0 then
      BCryptDestroyHash(hHash);

    if hAlg <> 0 then
      BCryptCloseAlgorithmProvider(hAlg, 0);
  end;
end;

function TDFeWinSecCNGCrypt.ValidarHash( const AStream : TStream;
       const Digest: TSSLDgst;
       const Hash: AnsiString;
       const Assinado: Boolean =  False): Boolean;
var
  hAlg: BCRYPT_ALG_HANDLE;
  hHash: BCRYPT_HASH_HANDLE;
  hKey: BCRYPT_KEY_HANDLE;
  cbHashLen, cbRead, Ret: DWORD;
  mTotal: Int64;
  Memory: Pointer;
  HashValue: AnsiString;
  wsAlgId: WideString;
  PaddingInfo: TBCryptPKCS1PaddingInfo;
begin
{$IFNDEF COMPILER25_UP}
  Result := False;
{$ENDIF}

  case Digest of
    dgstMD2    : wsAlgId := BCRYPT_MD2_ALGORITHM;
    dgstMD4    : wsAlgId := BCRYPT_MD4_ALGORITHM;
    dgstMD5    : wsAlgId := BCRYPT_MD5_ALGORITHM;
    dgstSHA    : wsAlgId := BCRYPT_SHA1_ALGORITHM;
    dgstSHA1   : wsAlgId := BCRYPT_SHA1_ALGORITHM;
    dgstSHA256 : wsAlgId := BCRYPT_SHA256_ALGORITHM;
    dgstSHA512 : wsAlgId := BCRYPT_SHA512_ALGORITHM;
  else
    raise EACBrDFeException.Create( 'Digest '+GetEnumName(TypeInfo(TSSLDgst),Integer(Digest))+
                                    ' não suportado em '+ClassName);
  end ;

  if Assinado and (not Assigned(FpCertContext)) then
    CarregarCertificado;

  hAlg := 0;
  hHash := 0;
  hKey := 0;

  try
    try
      // Abrindo provedor de algoritmo BCrypt (CNG) //
      Ret := BCryptOpenAlgorithmProvider(hAlg, LPCWSTR(wsAlgId), nil, 0);
      if Ret <> 0 then
        raise Exception.Create('BCryptOpenAlgorithmProvider: Erro $'+IntToHex(Ret, 8));

      // Criando objeto de Hash //
      Ret := BCryptCreateHash(hAlg, hHash, nil, 0, nil, 0, 0);
      if Ret <> 0 then
        raise Exception.Create('BCryptCreateHash: Erro $'+IntToHex(Ret, 8));

      // Alimentando o Hash com os dados do Stream //
      Memory := Allocmem(CBufferSize);
      try
        mTotal := AStream.Size;
        AStream.Position := 0;
        repeat
          cbRead := AStream.Read(Memory^, CBufferSize);
          if cbRead > 0 then
          begin
            Ret := BCryptHashData(hHash, PUCHAR(Memory), cbRead, 0);
            if Ret <> 0 then
              raise Exception.Create('BCryptHashData: Erro $'+IntToHex(Ret, 8));
          end;

          mTotal := mTotal - cbRead;
        until mTotal < 1;
      finally
        FreeMem(Memory);
      end;

      // Obtendo o tamanho do Hash e finalizando //
      cbHashLen := 0;
      Ret := BCryptGetProperty(hAlg, BCRYPT_HASH_LENGTH, PUCHAR(@cbHashLen), SizeOf(cbHashLen), cbRead, 0);
      if Ret <> 0 then
        raise Exception.Create('BCryptGetProperty(BCRYPT_HASH_LENGTH): Erro $'+IntToHex(Ret, 8));

      SetLength(HashValue, cbHashLen);
      Ret := BCryptFinishHash(hHash, PUCHAR(@HashValue[1]), cbHashLen, 0);
      if Ret <> 0 then
        raise Exception.Create('BCryptFinishHash: Erro $'+IntToHex(Ret, 8));

      if Assinado then
      begin
        // Importando a chave pública do certificado via BCrypt //
        if not CryptImportPublicKeyInfoEx2( X509_ASN_ENCODING,
                                            @FpCertContext.pCertInfo.SubjectPublicKeyInfo,
                                            0, nil, hKey) then
          raise Exception.Create('CryptImportPublicKeyInfoEx2: Erro $'+GetLastErrorAsHexaStr);

        try
          // BCryptVerifySignature espera Big Endian (padrão DFe) //
          PaddingInfo.pszAlgId := LPCWSTR(wsAlgId);
          Ret := BCryptVerifySignature( hKey, @PaddingInfo,
                                        PUCHAR(@HashValue[1]), Length(HashValue),
                                        PUCHAR(@Hash[1]), Length(Hash),
                                        BCRYPT_PAD_PKCS1);
          Result := (Ret = 0);
        finally
          BCryptDestroyKey(hKey);
          hKey := 0;
        end;
      end
      else
        Result := (Pos( HashValue, Hash ) > 0);

    except
      On E: Exception do
        raise EACBrDFeException.Create(E.Message+' , erro: $'+ GetLastErrorAsHexaStr);
    end;
  finally
    if hHash <> 0 then
      BCryptDestroyHash(hHash);

    if hAlg <> 0 then
      BCryptCloseAlgorithmProvider(hAlg, 0);
  end;
end;

initialization
  CertificadosA3ComPin := '';

finalization
  CertificadosA3ComPin := '';

end.

