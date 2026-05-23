{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2020 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:  André Ferreira de Moraes                       }
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

unit ACBrDFeOpenSSL;

interface

uses
  Classes, SysUtils,
  ACBrDFeSSL,
  OpenSSLExt;

resourcestring
  sErrCarregarOpenSSL = 'Erro ao carregar bibliotecas do OpenSSL';
  sErrUtilizePFX = 'Utilize "ArquivoPFX" ou "DadosPFX"';
  sErrCertNaoInformado = 'Certificado não informado.' ;
  sErrCertNaoSuportado = 'TDFeOpenSSL não suporta Leitura de Certificado pelo Número de Série.';
  sErrCertNaoEncontrado = 'Arquivo: %s não encontrado, e DadosPFX não informado';
  sErrCertCarregar =  'Erro ao Carregar Certificado';
  sErrCertSenhaErrada = 'Erro ao ler informações do Certificado.'+sLineBreak+
                        'Provavelmente a senha está errada'; 

type
  { TDFeOpenSSL }

  TDFeOpenSSL = class(TDFeSSLCryptClass)
  private
    FStoreWinApi: Pointer;
    FCertContextWinApi: Pointer;
    FPrivKey: pEVP_PKEY;
    FCert: pX509;
    FVersion: String;
    FOldVersion: Boolean;

    procedure GetCertInfo(cert: pX509);
    procedure DestroyKey;
    procedure DestroyCert;
  protected

    function GetCertContextWinApi: Pointer; override;
    function LerPFXInfo(const PFXData: Ansistring): Boolean;
    procedure CarregarCertificadoDeDadosPFX; override;

  public
    constructor Create(ADFeSSL: TDFeSSL); override;
    destructor Destroy; override;
    procedure Clear; override;

    function Versao: String; override;
    function CalcHash( const AStream : TStream;
       const Digest: TSSLDgst;
       const Assina: Boolean =  False): AnsiString; override;

    function ValidarHash( const AStream : TStream;
       const Digest: TSSLDgst;
       const Hash: AnsiString;
       const Assinado: Boolean =  False): Boolean; override;

    procedure DescarregarCertificado; override;
    function CarregarCertificadoPublico(const DadosX509Base64: Ansistring): Boolean; override;

    function OpenSSLVersion: String;
    function OpenSSLOldVersion: Boolean;
    property Certificado: pX509 read FCert;
  end;

implementation

uses
  strutils, dateutils, typinfo, synautil, synacode,
  ACBrOpenSSLUtils,
  ACBrUtil.FilesIO,
  ACBrDFeException;

{ TDFeOpenSSL }

constructor TDFeOpenSSL.Create(ADFeSSL: TDFeSSL);
begin
  inherited Create(ADFeSSL);
  FPrivKey := nil;
  FCert := nil;
  FStoreWinApi := Nil;
  FCertContextWinApi := Nil;
  Clear;
end;

destructor TDFeOpenSSL.Destroy;
begin
  DescarregarCertificado;
  inherited Destroy;
end;

procedure TDFeOpenSSL.Clear;
begin
  inherited Clear;
  FVersion := '';
  FOldVersion := False;
end;

function TDFeOpenSSL.Versao: String;
begin
  if not InitSSLInterface then
    Result := sErrCarregarOpenSSL 
  else
    Result := OpenSSLVersion;
end;

procedure TDFeOpenSSL.DestroyKey;
begin
  if (FPrivKey <> Nil) then
  begin
    EvpPkeyFree(FPrivKey);
    FPrivKey := nil;
  end;
end;

procedure TDFeOpenSSL.DestroyCert;
begin
  if (FCert <> Nil) then
  begin
    X509free(FCert);
    FCert := Nil;
  end;
end;

procedure TDFeOpenSSL.GetCertInfo(cert: pX509);
begin
  with FpDadosCertificado do
  begin
    Clear;
    NumeroSerie := GetSerialNumber( cert );
    ThumbPrint  := GetThumbPrint( cert );
    SubjectName := GetSubjectName( cert );
    if CNPJ = '' then  // Não tem CNPJ/CPF no SubjectName, lendo das Extensões
      CNPJ := GetTaxIDFromExtensions( cert );

    DataVenc := GetNotAfter( cert );
    DataInicioValidade := GetNotBefore( cert );
    IssuerName := GetIssuerName( cert );
    DERBase64 := CertToDERBase64( cert );
    Tipo := tpcA1;  // OpenSSL somente suporta A1
  end;
end;

function TDFeOpenSSL.GetCertContextWinApi: Pointer;
begin
  FCertContextWinApi := Nil;

  Result := FCertContextWinApi;
end;

procedure TDFeOpenSSL.DescarregarCertificado;
begin
  DestroyKey;
  DestroyCert;

  FCertContextWinApi := Nil;
  FStoreWinApi := Nil;

  inherited DescarregarCertificado;
end;

function TDFeOpenSSL.LerPFXInfo(const PFXData: Ansistring): Boolean;
var
  ca, p12: Pointer;
  b: PBIO;
begin
  Result := False;
  DestroyKey;

  b := BioNew(BioSMem);
  try
    BioWrite(b, PFXData, Length(PFXData));
    p12 := d2iPKCS12bio(b, nil);
    if not Assigned(p12) then
      Exit;

    try
      ca := nil;
      DestroyCert;
      DestroyKey;
      if (PKCS12parse(p12, FpDFeSSL.Senha, FPrivKey, FCert, ca) > 0) then
      begin
        if (FCert <> nil) then
        begin
          GetCertInfo( FCert );
          Result := True;
        end;
      end;
    finally
      PKCS12free(p12);
      OPENSSL_sk_pop_free(ca, @X509free);
    end;
  finally
    BioFreeAll(b);
  end;
end;

procedure TDFeOpenSSL.CarregarCertificadoDeDadosPFX;
begin
  if not InitSSLInterface then
    raise EACBrDFeException.Create(sErrCarregarOpenSSL);

  if not LerPFXInfo(FpDFeSSL.DadosPFX) then
    raise EACBrDFeException.Create(sErrCertSenhaErrada + sLineBreak + GetLastOpenSSLError);
end;

function TDFeOpenSSL.CarregarCertificadoPublico(const DadosX509Base64: Ansistring): Boolean;
var
  b: PBIO;
  BinaryX509: AnsiString;
begin
  Result := False;
  DescarregarCertificado;

  BinaryX509 := DecodeBase64( DadosX509Base64 );

  b := BioNew(BioSMem);
  try
    BioWrite(b, BinaryX509, Length(BinaryX509));
    FCert := d2iX509bio(b, FCert);
    if Assigned( FCert ) then
    begin
      GetCertInfo( FCert );
      Result := True;
    end;
  finally
    BioFreeAll(b);
  end;
end;

function TDFeOpenSSL.OpenSSLVersion: String;
begin
  OpenSSLOldVersion;
  Result := OpenSSLExt.OpenSSLVersion(0);
end;

function TDFeOpenSSL.OpenSSLOldVersion: Boolean;
var
  VersaoStr: String;
  VersaoNum: Integer;
  P1, P2: Integer;
begin
  if (FVersion = '') then
  begin
    VersaoNum := OpenSSLExt.OpenSSLVersionNum;
    if (VersaoNum > 0) then
    begin
      VersaoStr := IntToHex(VersaoNum, 9);
      FVersion := copy(VersaoStr,1,2)+'.'+copy(VersaoStr,3,2)+'.'+copy(VersaoStr,5,2)+'.'+copy(VersaoStr,7,10);
    end
    else
    begin
      VersaoStr := OpenSSLExt.OpenSSLVersion(0);

      P1 := pos(' ', VersaoStr);
      if P1 > 0 then
      begin
        P2 := PosEx(' ', VersaoStr, P1+1 );
        if P2 = 0 then
          P2 := Length(VersaoStr);

        FVersion := Trim(copy(VersaoStr, P1, P2-P1));
      end;
    end;

    FOldVersion := (CompareVersions(FVersion, '1.1.0') < 0);
  end;

  Result := FOldVersion;
end;

{ Método clonado de ACBrEAD }
function TDFeOpenSSL.CalcHash(const AStream: TStream; const Digest: TSSLDgst;
  const Assina: Boolean): AnsiString;
Var
  md : PEVP_MD ;
  md_len: cardinal;
  md_ctx: EVP_MD_CTX;
  pmd_ctx: PEVP_MD_CTX;
  md_value_bin : array [0..1023] of AnsiChar;
  NameDgst : PAnsiChar;
  ABinStr: AnsiString;
  Memory: Pointer;
  PosStream: Int64;
  BytesRead: LongInt;
begin
  NameDgst := '';
  case Digest of
    dgstMD2    : NameDgst := 'md2';
    dgstMD4    : NameDgst := 'md4';
    dgstMD5    : NameDgst := 'md5';
    dgstRMD160 : NameDgst := 'rmd160';
    dgstSHA    : NameDgst := 'sha';
    dgstSHA1   : NameDgst := 'sha1';
    dgstSHA256 : NameDgst := 'sha256';
    dgstSHA512 : NameDgst := 'sha512';
  end ;

  if Assina and (FPrivKey = Nil) then
    CarregarCertificado;

  pmd_ctx := Nil;
  PosStream := 0;
  AStream.Position := 0;
  GetMem(Memory, CBufferSize);
  try
    md_len := 0;
    md := EVP_get_digestbyname( NameDgst );
    if md = Nil then
      raise EACBrDFeException.Create('Erro ao carregar Digest: '+NameDgst + sLineBreak + GetLastOpenSSLError);

    if OpenSSLOldVersion then
      pmd_ctx := @md_ctx
    else
      pmd_ctx := EVP_MD_CTX_new();

    EVP_DigestInit( pmd_ctx, md );

    while (PosStream < AStream.Size) do
    begin
       BytesRead := AStream.Read(Memory^, CBufferSize);
       if BytesRead <= 0 then
          Break;

       EVP_DigestUpdate( pmd_ctx, Memory, BytesRead ) ;
       PosStream := PosStream + BytesRead;
    end;

    if Assina then
       EVP_SignFinal( pmd_ctx, @md_value_bin, md_len, FPrivKey)
    else
       EVP_DigestFinal( pmd_ctx, @md_value_bin, @md_len);

    SetString( ABinStr, md_value_bin, md_len);
    Result := ABinStr;
  finally
    if (not OpenSSLOldVersion) and (pmd_ctx <> nil) then
      EVP_MD_CTX_free( pmd_ctx );

    Freemem(Memory);
  end;
end;

function TDFeOpenSSL.ValidarHash( const AStream : TStream;
       const Digest: TSSLDgst;
       const Hash: AnsiString;
       const Assinado: Boolean =  False): Boolean;
Var
  md : PEVP_MD ;
  md_len: cardinal;
  md_ctx: EVP_MD_CTX;
  pmd_ctx: PEVP_MD_CTX;
  md_value_bin : array [0..1023] of AnsiChar;
  NameDgst : PAnsiChar;
  HashResult: AnsiString;
  Memory: Pointer;
  PosStream: Int64;
  Ret, BytesRead: LongInt;
  pubKey: pEVP_PKEY;
begin
{$IFNDEF COMPILER25_UP}
  Result := False;
{$ENDIF}
  NameDgst := '';
  case Digest of
    dgstMD2    : NameDgst := 'md2';
    dgstMD4    : NameDgst := 'md4';
    dgstMD5    : NameDgst := 'md5';
    dgstRMD160 : NameDgst := 'rmd160';
    dgstSHA    : NameDgst := 'sha';
    dgstSHA1   : NameDgst := 'sha1';
    dgstSHA256 : NameDgst := 'sha256';
    dgstSHA512 : NameDgst := 'sha512';
  end ;

  if Assinado and (FCert = nil) then
    CarregarCertificado;

  PosStream := 0;
  AStream.Position := 0;
  GetMem(Memory, CBufferSize);
  pmd_ctx := Nil;
  try
    md_len := 0;
    md := EVP_get_digestbyname( NameDgst );
    if md = Nil then
      raise EACBrDFeException.Create('Erro ao carregar Digest: '+NameDgst + sLineBreak + GetLastOpenSSLError);

    if OpenSSLOldVersion then
      pmd_ctx := @md_ctx
    else
      pmd_ctx := EVP_MD_CTX_new();

    EVP_DigestInit( pmd_ctx, md );

    while (PosStream < AStream.Size) do
    begin
      BytesRead := AStream.Read(Memory^, CBufferSize);
      if BytesRead <= 0 then
        Break;

      EVP_DigestUpdate( pmd_ctx, Memory, BytesRead ) ;
      PosStream := PosStream + BytesRead;
    end;

    if Assinado then
    begin
      pubKey := X509GetPubkey(FCert);
      Ret := EVP_VerifyFinal( pmd_ctx, PAnsiChar(Hash), Length(Hash), pubKey) ;
      Result := (Ret = 1);
    end
    else
    begin
      EVP_DigestFinal( pmd_ctx, @md_value_bin, @md_len);
      SetString( HashResult, md_value_bin, md_len);
      Result := (Pos( HashResult, Hash ) > 0) ;
    end;
  finally
    if (not OpenSSLOldVersion) and (pmd_ctx <> nil) then
      EVP_MD_CTX_free( pmd_ctx );

    Freemem(Memory);
  end;
end;

end.


