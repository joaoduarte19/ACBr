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

unit ACBrDFeWinCrypt;

interface

uses
  Classes, SysUtils, Windows,
  ACBrDFeSSL, ACBrDFeException,
  ACBr_WinCrypt, ACBr_NCrypt ;

type
  EACBrDFeWrongPINException = EACBrDFeException;

  { TDFeWinCrypt }

  TDFeWinCrypt = class(TDFeSSLCryptClass)
  private
    procedure GetCertContextInfo(ADadosCertificado: TDadosCertificado;
      ACertContext: PCCERT_CONTEXT; CheckIsHardware: Boolean);
    procedure OpenSystemStore;
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

{ TDFeWinCrypt }

constructor TDFeWinCrypt.Create(ADFeSSL: TDFeSSL);
begin
  inherited Create(ADFeSSL);

  FpCertContext := Nil;
  FpStore := Nil;
  FpPFXData := '';

  Clear;
end;

destructor TDFeWinCrypt.Destroy;
begin
  DescarregarCertificado;

  inherited Destroy;
end;

function TDFeWinCrypt.Versao: String;
begin
  Result := Crypt32 + ' '+ GetFileVersion(Crypt32);
end;

procedure TDFeWinCrypt.OpenSystemStore;
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

function TDFeWinCrypt.GetCertContextWinApi: Pointer;
begin
  CarregarCertificadoSeNecessario;
  Result := FpCertContext;
end;

function TDFeWinCrypt.GetCertPFXData: AnsiString;
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

procedure TDFeWinCrypt.CarregarCertificadoDeDadosPFX;
begin
  OpenSystemStore;
  PFXDataToCertContextWinApi( FpDFeSSL.DadosPFX,
                              FpDFeSSL.Senha,
                              FpStore,
                              Pointer(FpCertContext))
end;

procedure TDFeWinCrypt.CarregarCertificadoDeNumeroSerie;
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

procedure TDFeWinCrypt.LerInfoCertificadoCarregado;
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

procedure TDFeWinCrypt.GetCertContextInfo(ADadosCertificado: TDadosCertificado;
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

function TDFeWinCrypt.SelecionarCertificado: String;
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

procedure TDFeWinCrypt.LerCertificadosStore;
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

procedure TDFeWinCrypt.DescarregarCertificado;
var
  CryptProv: HCRYPTPROV;
  ProviderType: Cardinal;
  ProviderName, ContainerName: {$IfDef UNICODE}WideString{$Else}String{$EndIf};
  Ok: BOOL;
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

  // Limpando objetos da MS CryptoAPI //
  if Assigned(FpCertContext) then
  begin
    if (FpDadosCertificado.Tipo = tpcA1) and
       (FpDFeSSL.NumeroSerie = '') and (FpDFeSSL.DadosPFX <> '') then
    begin
      // Autor: Arimateia Jr
      // Data: 23/09/2024
      // Descrição: If the PKCS12_NO_PERSIST_KEY flag is *not* set, keys are
      //            persisted on disk. If you do not want to persist the keys
      //            beyond their usage, you must delete them by calling the
      //            CryptAcquireContext function with the CRYPT_DELETEKEYSET
      //            flag set in the dwFlags parameter.
      OK := GetProviderInfo(FpCertContext, ProviderType, ProviderName, ContainerName, False);
      if OK then
        Ok := CryptAcquireContext( CryptProv,
                                   {$IfDef UNICODE}LPWSTR{$Else}LPSTR{$EndIf}(ContainerName),
                                   {$IfDef UNICODE}LPWSTR{$Else}LPSTR{$EndIf}(ProviderName),
                                   ProviderType, CRYPT_DELETEKEYSET);
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

function TDFeWinCrypt.CarregarCertificadoPublico(const DadosX509Base64: Ansistring
  ): Boolean;
var
  BinaryX509: AnsiString;
  mCryptProvider: HCRYPTPROV;
begin
  DescarregarCertificado;

  BinaryX509 := DecodeBase64( DadosX509Base64 );

  OpenSystemStore;

  mCryptProvider := 0;
  if not CryptAcquireContext( mCryptProvider, Nil, Nil,
                              PROV_RSA_AES, CRYPT_VERIFYCONTEXT) then
    raise EACBrDFeException.Create('CryptAcquireContext: '+MsgErroGetCryptProvider);

  FpCertContext := CertCreateCertificateContext( X509_ASN_ENCODING,
                                                 PBYTE(BinaryX509),
                                                 Length(BinaryX509) );
  GetCertContextInfo(FpDadosCertificado, FpCertContext, False);
  Result := (FpDadosCertificado.SubjectName <> '');
end;

function TDFeWinCrypt.CalcHash(const AStream: TStream; const Digest: TSSLDgst;
  const Assina: Boolean): AnsiString;
var
  mCryptProvider, mCryptProviderCert: HCRYPTPROV;
  mHash, aHashType: HCRYPTHASH;
  hRSAKey, hSessKey, hExpKey: HCRYPTKEY;
  I: Integer;
  mTotal: Int64;
  mBytesLen, mRead, dwKeySpec, WinErro: DWORD;
  Memory: Pointer;
  mHashBuffer: array [0..1023] of AnsiChar;  // 1024 - Tamanho máximo do maior Hash atual
  pfCallerFreeProv: LongBool;
begin
  Result := '';

  case Digest of
    dgstMD2    : aHashType := CALG_MD2;
    dgstMD4    : aHashType := CALG_MD4;
    dgstMD5    : aHashType := CALG_MD5;
    dgstSHA    : aHashType := CALG_SHA;
    dgstSHA1   : aHashType := CALG_SHA1;
    dgstSHA256 : aHashType := CALG_SHA_256;
    dgstSHA512 : aHashType := CALG_SHA_512;
  else
    raise EACBrDFeException.Create( 'Digest '+GetEnumName(TypeInfo(TSSLDgst),Integer(Digest))+
                                    ' não suportado em '+ClassName);
  end ;

  mCryptProvider := 0;
  mCryptProviderCert := 0;
  mHash := 0;
  hRSAKey := 0;
  hExpKey := 0;
  hSessKey := 0;
  pfCallerFreeProv := False;
  dwKeySpec := AT_KEYEXCHANGE;

  try
    try
      // Obtendo Contexto de Provedor de Criptografia, com suporte a SHA256 //
      if not CryptAcquireContext( mCryptProvider, Nil, Nil, //PAnsiChar(MS_ENH_RSA_AES_PROV),
                                 PROV_RSA_AES, CRYPT_VERIFYCONTEXT) then
        raise Exception.Create('CryptAcquireContext: '+MsgErroGetCryptProvider);

      if Assina then
      begin
        CarregarCertificadoSeNecessario;

        if not Assigned(FpCertContext) then
          raise Exception.Create('Certificado não pode ser carregado po MS CryptoAPI');

        // TODO: Adicionar suporte a certificados CNG
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
            // Obtendo as chaves do Certificado //
            if CryptGetUserKey(mCryptProviderCert, dwKeySpec, hRSAKey) then
            begin
              // Tentando copiar a chave do Certificado para o nosso Provedor de Criptografia //
              try
                mBytesLen := 0;
                if CryptExportKey( hRSAKey, hSessKey, PRIVATEKEYBLOB, 0, Nil, mBytesLen ) then  // Calcula mBytesLen
                begin
                  Memory := AllocMem(mBytesLen);  // Aloca a memória para receber o Blob
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
                { Não foi capaz de Exportar/Copiar a Chave para o nosso Provedor
                  de Criptografia, então vamos usar o Provedor de Criptografia do
                  Certificado }

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
      end;

      if CryptCreateHash(mCryptProvider, aHashType, 0, 0, mHash) then
      begin
        Memory := Allocmem(CBufferSize);
        try
          mTotal := AStream.Size;
          AStream.Position := 0;
          repeat
            mRead := AStream.Read(Memory^, CBufferSize);
            if mRead > 0 then
            begin
              if not CryptHashData(mHash, Memory, mRead, 0) then
                raise Exception.Create('CryptHashData');
            end;

            mTotal := mTotal - mRead;
          until mTotal < 1;
        finally
          FreeMem(Memory);
        end;

        mBytesLen := Length(mHashBuffer);
        FillChar(mHashBuffer, mBytesLen, #0);

        if Assina then
        begin
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
        end
        else
        begin
          // Obtendo o Hash //
          if CryptGetHashParam(mHash, HP_HASHVAL, @mHashBuffer, mBytesLen, 0) then
            SetString( Result, mHashBuffer, mBytesLen)
          else
            raise Exception.Create('CryptGetHashParam');
        end;
      end
      else
      begin
         WinErro := GetLastError;
         if WinErro = DWORD( NTE_BAD_ALGID  ) then
            raise Exception.Create('O Provedor de Criptografia não suporta o algoritmo: '+
                                   GetEnumName(TypeInfo(TSSLDgst),Integer(Digest)))
         else
           raise Exception.Create('CryptCreateHash');
      end;

    except
      On E: Exception do
      begin
        raise EACBrDFeException.Create(E.Message+' , erro: $'+ GetLastErrorAsHexaStr);
      end;
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

function TDFeWinCrypt.ValidarHash( const AStream : TStream;
       const Digest: TSSLDgst;
       const Hash: AnsiString;
       const Assinado: Boolean =  False): Boolean;
var
  mCryptProvider: HCRYPTPROV;
  mHash, aHashType: HCRYPTHASH;
  hExpKey: HCRYPTKEY;
  mTotal: Int64;
  mBytesLen, mRead, WinErro: DWORD;
  Memory: Pointer;
  mHashBuffer: array [0..1023] of AnsiChar;
  HashResult, ReverseHash: AnsiString;
begin
{$IFNDEF COMPILER25_UP}
  Result := False;
{$ENDIF}

  case Digest of
    dgstMD2    : aHashType := CALG_MD2;
    dgstMD4    : aHashType := CALG_MD4;
    dgstMD5    : aHashType := CALG_MD5;
    dgstSHA    : aHashType := CALG_SHA;
    dgstSHA1   : aHashType := CALG_SHA1;
    dgstSHA256 : aHashType := CALG_SHA_256;
    dgstSHA512 : aHashType := CALG_SHA_512;
  else
    raise EACBrDFeException.Create( 'Digest '+GetEnumName(TypeInfo(TSSLDgst),Integer(Digest))+
                                    ' não suportado em '+ClassName);
  end ;

  if Assinado and (not Assigned(FpCertContext)) then
    CarregarCertificado;

  mCryptProvider := 0;
  mHash := 0;
  hExpKey := 0;

  try
    try
      if not CryptAcquireContext( mCryptProvider, Nil, Nil,
                                  PROV_RSA_AES, CRYPT_VERIFYCONTEXT) then
        raise EACBrDFeException.Create('CryptAcquireContext: '+MsgErroGetCryptProvider);

      if CryptCreateHash(mCryptProvider, aHashType, 0, 0, mHash) then
      begin
        Memory := Allocmem(CBufferSize);
        try
          mTotal := AStream.Size;
          AStream.Position := 0;
          repeat
            mRead := AStream.Read(Memory^, CBufferSize);
            if mRead > 0 then
            begin
              if not CryptHashData(mHash, Memory, mRead, 0) then
                raise Exception.Create('CryptHashData');
            end;

            mTotal := mTotal - mRead;
          until mTotal < 1;
        finally
          FreeMem(Memory);
        end;

        if Assinado then
        begin
          if not CryptImportPublicKeyInfo( mCryptProvider,
                                           X509_ASN_ENCODING,
                                           @FpCertContext.pCertInfo.SubjectPublicKeyInfo,
                                           hExpKey) then
            raise Exception.Create('CryptImportPublicKeyInfo');

          // Invertendo por que MS Crypto usa litle endian
          ReverseHash := AnsiReverseString(Hash);
          Result := CryptVerifySignature( mHash, PBYTE(ReverseHash), Length(ReverseHash),
                                          hExpKey, nil, 0);
        end
        else
        begin
          mBytesLen := Length(mHashBuffer);
          FillChar(mHashBuffer, mBytesLen, 0);
          // Obtendo o Hash //
          if not CryptGetHashParam(mHash, HP_HASHVAL, @mHashBuffer, mBytesLen, 0) then
            raise Exception.Create('CryptGetHashParam');

          SetString( HashResult, mHashBuffer, mBytesLen);
          Result := (Pos( HashResult, Hash ) > 0) ;
        end;
      end
      else
      begin
        WinErro := GetLastError;
         if WinErro = DWORD( NTE_BAD_ALGID  ) then
           raise Exception.Create('O Provedor de Criptografia não suporta o algoritmo: '+
                                  GetEnumName(TypeInfo(TSSLDgst),Integer(Digest)))
       else
         raise Exception.Create('CryptCreateHash');
      end;
    except
      On E: Exception do
      begin
        raise EACBrDFeException.Create(E.Message+' , erro: $'+ GetLastErrorAsHexaStr);
      end;
    end;
  finally
    if mHash <> 0 then
      CryptDestroyHash(mHash);

    if hExpKey <> 0 then
      CryptDestroyKey( hExpKey );

    if mCryptProvider <> 0 then
      CryptReleaseContext(mCryptProvider, 0);
  end;
end;

initialization
  CertificadosA3ComPin := '';

finalization
  CertificadosA3ComPin := '';

end.

