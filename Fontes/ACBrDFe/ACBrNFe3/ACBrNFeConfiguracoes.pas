{******************************************************************************}
{ Projeto: Componente ACBrNFe                                                  }
{  Biblioteca multiplataforma de componentes Delphi para emissão de Nota Fiscal}
{ eletrônica - NFe - http://www.nfe.fazenda.gov.br                             }

{ Direitos Autorais Reservados (c) 2008 Wemerson Souto                         }
{                                       Daniel Simoes de Almeida               }
{                                       André Ferreira de Moraes               }

{ Colaboradores nesse arquivo:                                                 }

{  Você pode obter a última versão desse arquivo na pagina do Projeto ACBr     }
{ Componentes localizado em http://www.sourceforge.net/projects/acbr           }


{  Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la }
{ sob os termos da Licença Pública Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a versão 2.1 da Licença, ou (a seu critério) }
{ qualquer versão posterior.                                                   }

{  Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU      }
{ ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENÇA.TXT ou LICENSE.TXT)              }

{  Você deve ter recebido uma cópia da Licença Pública Geral Menor do GNU junto}
{ com esta biblioteca; se não, escreva para a Free Software Foundation, Inc.,  }
{ no endereço 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Você também pode obter uma copia da licença em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }

{ Daniel Simões de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Praça Anita Costa, 34 - Tatuí - SP - 18270-410                  }

{******************************************************************************}

{$I ACBr.inc}

unit ACBrNFeConfiguracoes;

interface

uses
  {$IFDEF MSWINDOWS}
  Windows, ActiveX, ACBrCAPICOM_TLB, JwaWinCrypt, ACBrMSXML2_TLB,
  {$ENDIF}
  Classes, SysUtils, pcnConversao;

{$IFDEF MSWINDOWS}
const
  CAPICOM_STORE_NAME = 'My'; //My CA Root AddressBook
{$ENDIF}

type

  TCryptoLib = (libOpenSSL, libCapicom);

  { TCertificadosConf }

  TCertificadosConf = class(TComponent)
  private
    FSenhaCert: AnsiString;
    FCNPJ: String;
    FPathCertificadoPFX: String;

    {$IFDEF MSWINDOWS}
    PCertCarregado: ICertificate2;
    FNumeroSerie: String;
    FDataVenc: TDateTime;
    FSubjectName: String;
    procedure SetNumeroSerie(const Value: String);
    function GetNumeroSerie: String;
    function GetDataVenc: TDateTime;
    function GetSubjectName: String;
    {$ENDIF}
    function GetCNPJ: String;
  public
    constructor Create(AOwner: TComponent); override;
    {$IFDEF MSWINDOWS}
    function SelecionarCertificado: String;
    function GetCertificado: ICertificate2;
    {$ENDIF}
  published
    property PathCertificadoPFX: String read FPathCertificadoPFX
      write FPathCertificadoPFX;
    {$IFDEF MSWINDOWS}
    property NumeroSerie: String read GetNumeroSerie write SetNumeroSerie;
    property DataVenc: TDateTime read GetDataVenc;
    property SubjectName: String read GetSubjectName;
    {$ENDIF}
    property CNPJ: String read GetCNPJ;
    property Senha: AnsiString read FSenhaCert write FSenhaCert;
  end;

  TWebServicesConf = class(TComponent)
  private
    FVisualizar: boolean;
    FUF: String;
    FUFCodigo: integer;
    FAmbiente: TpcnTipoAmbiente;
    FAmbienteCodigo: integer;
    FProxyHost: String;
    FProxyPort: String;
    FProxyUser: String;
    FProxyPass: String;
    FAguardarConsultaRet: cardinal;
    FTentativas: integer;
    FIntervaloTentativas: cardinal;
    FAjustaAguardaConsultaRet: boolean;
    FSalvar: boolean;

    procedure SetUF(AValue: String);
    procedure SetAmbiente(AValue: TpcnTipoAmbiente);
    procedure SetTentativas(const Value: integer);
    procedure SetIntervaloTentativas(const Value: cardinal);
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Visualizar: boolean read FVisualizar write FVisualizar default False;
    property UF: String read FUF write SetUF;
    property UFCodigo: integer read FUFCodigo;
    property Ambiente: TpcnTipoAmbiente
      read FAmbiente write SetAmbiente default taHomologacao;
    property AmbienteCodigo: integer read FAmbienteCodigo;
    property ProxyHost: String read FProxyHost write FProxyHost;
    property ProxyPort: String read FProxyPort write FProxyPort;
    property ProxyUser: String read FProxyUser write FProxyUser;
    property ProxyPass: String read FProxyPass write FProxyPass;
    property AguardarConsultaRet: cardinal read FAguardarConsultaRet
      write FAguardarConsultaRet;
    property Tentativas: integer read FTentativas write SetTentativas default 5;
    property IntervaloTentativas: cardinal read FIntervaloTentativas
      write SetIntervaloTentativas default 1000;
    property AjustaAguardaConsultaRet: boolean
      read FAjustaAguardaConsultaRet write FAjustaAguardaConsultaRet default False;
    property Salvar: boolean read FSalvar write FSalvar default False;
  end;

  { TGeralConf }

  TGeralConf = class(TComponent)
  private
    FCryptoLib: TCryptoLib;
    FFormaEmissao: TpcnTipoEmissao;
    FFormaEmissaoCodigo: integer;
    FSalvar: boolean;
    FAtualizarXMLCancelado: boolean;
    FPathSalvar: String;
    FPathSchemas: String;
    FExibirErroSchema: boolean;
    FFormatoAlerta: String;
    FRetirarAcentos: boolean;
    FIniFinXMLSECAutomatico: boolean;
    FModeloDF: TpcnModeloDF;
    FVersaoDF: TpcnVersaoDF;
    FModeloDFCodigo: integer;
    FIdToken: String;
    FToken: String;
    FValidarDigest: boolean;

    procedure SetCryptoLib(AValue: TCryptoLib);
    procedure SetFormaEmissao(AValue: TpcnTipoEmissao);
    function GetPathSalvar: String;
    procedure SetModeloDF(AValue: TpcnModeloDF);
    function GetFormatoAlerta: String;
    procedure SetVersaoDF(const Value: TpcnVersaoDF);
  public
    constructor Create(AOwner: TComponent); override;
    function Save(AXMLName: String; AXMLFile: String; aPath: String = ''): boolean;
  published
    property CryptoLib: TCryptoLib read FCryptoLib write SetCryptoLib;
    property FormaEmissao: TpcnTipoEmissao read FFormaEmissao
      write SetFormaEmissao default teNormal;
    property FormaEmissaoCodigo: integer read FFormaEmissaoCodigo;
    property Salvar: boolean read FSalvar write FSalvar default False;
    property AtualizarXMLCancelado: boolean
      read FAtualizarXMLCancelado write FAtualizarXMLCancelado default True;
    property PathSalvar: String read GetPathSalvar write FPathSalvar;
    property PathSchemas: String read FPathSchemas write FPathSchemas;
    property ExibirErroSchema: boolean read FExibirErroSchema write FExibirErroSchema;
    property FormatoAlerta: String read GetFormatoAlerta write FFormatoAlerta;
    property RetirarAcentos: boolean read FRetirarAcentos write FRetirarAcentos;
    property IniFinXMLSECAutomatico: boolean
      read FIniFinXMLSECAutomatico write FIniFinXMLSECAutomatico;
    property ModeloDF: TpcnModeloDF read FModeloDF write SetModeloDF default moNFe;
    property VersaoDF: TpcnVersaoDF read FVersaoDF write SetVersaoDF default ve200;
    property ModeloDFCodigo: integer read FModeloDFCodigo;
    property IdToken: String read FIdToken write FIdToken;
    property Token: String read FToken write FToken;
    property ValidarDigest: boolean
      read FValidarDigest write FValidarDigest default True;
  end;

  { TArquivosConf }

  TArquivosConf = class(TComponent)
  private
    FSalvar: boolean;
    FMensal: boolean;
    FLiteral: boolean;
    FEmissaoPathNFe: boolean;
    FSalvarEvento: boolean;
    FSepararCNPJ: boolean;
    FSepararModelo: boolean;
    FSalvarApenasNFeProcessadas: boolean;
    FPathNFe: String;
    FPathCan: String;
    FPathInu: String;
    FPathDPEC: String;
    FPathCCe: String;
    FPathMDe: String;
    FPathEvento: String;
  private
    function GetPath(APath: String = ''; ALiteral: String = ''): String;

  public
    constructor Create(AOwner: TComponent); override;

    function GetPathCan(CNPJ: String = ''): String;
    function GetPathDPEC(CNPJ: String = ''): String;
    function GetPathInu(CNPJ: String = ''): String;
    function GetPathNFe(Data: TDateTime = 0; CNPJ: String = ''): String;
    function GetPathCCe(CNPJ: String = ''): String;
    function GetPathMDe(CNPJ: String = ''): String;
    function GetPathEvento(tipoEvento: TpcnTpEvento; CNPJ: String = ''): String;
  published
    property Salvar: boolean read FSalvar write FSalvar default False;
    property PastaMensal: boolean read FMensal write FMensal default False;
    property AdicionarLiteral: boolean read FLiteral write FLiteral default False;
    property EmissaoPathNFe: boolean read FEmissaoPathNFe
      write FEmissaoPathNFe default False;
    property SalvarCCeCanEvento: boolean read FSalvarEvento
      write FSalvarEvento default False;
    property SepararPorCNPJ: boolean read FSepararCNPJ write FSepararCNPJ default False;
    property SepararPorModelo: boolean read FSepararModelo
      write FSepararModelo default False;
    property SalvarApenasNFeProcessadas: boolean
      read FSalvarApenasNFeProcessadas write FSalvarApenasNFeProcessadas default False;
    property PathNFe: String read FPathNFe write FPathNFe;
    property PathCan: String read FPathCan write FPathCan;
    property PathInu: String read FPathInu write FPathInu;
    property PathDPEC: String read FPathDPEC write FPathDPEC;
    property PathCCe: String read FPathCCe write FPathCCe;
    property PathMDe: String read FPathMDe write FPathMDe;
    property PathEvento: String read FPathEvento write FPathEvento;
  end;

  TConfiguracoes = class(TComponent)
  private
    FGeral: TGeralConf;
    FWebServices: TWebServicesConf;
    FCertificados: TCertificadosConf;
    FArquivos: TArquivosConf;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Geral: TGeralConf read FGeral;
    property WebServices: TWebServicesConf read FWebServices;
    property Certificados: TCertificadosConf read FCertificados;
    property Arquivos: TArquivosConf read FArquivos;
  end;

implementation

uses
  ACBrNFe, ACBrNFeUtil, pcnGerador, Math, StrUtils, ACBrUtil, ACBrDFeUtil,
  DateUtils;

{ TConfiguracoes }

constructor TConfiguracoes.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FGeral := TGeralConf.Create(Self);
  FGeral.Name := 'GeralConf';
  {$IFDEF COMPILER6_UP}
  FGeral.SetSubComponent(True);{ para gravar no DFM/XFM }
  {$ENDIF}

  FWebServices := TWebServicesConf.Create(self);
  FWebServices.Name := 'WebServicesConf';
  {$IFDEF COMPILER6_UP}
  FWebServices.SetSubComponent(True);{ para gravar no DFM/XFM }
  {$ENDIF}

  FCertificados := TCertificadosConf.Create(self);
  FCertificados.Name := 'CertificadosConf';
  {$IFDEF COMPILER6_UP}
  FCertificados.SetSubComponent(True);{ para gravar no DFM/XFM }
  {$ENDIF}

  FArquivos := TArquivosConf.Create(self);
  FArquivos.Name := 'ArquivosConf';
  {$IFDEF COMPILER6_UP}
  FArquivos.SetSubComponent(True);{ para gravar no DFM/XFM }
  {$ENDIF}
end;

destructor TConfiguracoes.Destroy;
begin
  FGeral.Free;
  FWebServices.Free;
  FCertificados.Free;
  FArquivos.Free;

  inherited;
end;

{ TGeralConf }

constructor TGeralConf.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FCryptoLib := libCapicom;
  {$IFNDEF MSWINDOWS}
  FCryptoLib := libOpenSSL;
  {$ENDIF}

  FFormaEmissao := teNormal;
  FFormaEmissaoCodigo := StrToInt(TpEmisToStr(FFormaEmissao));
  FSalvar := False;
  FAtualizarXMLCancelado := True;
  FPathSalvar := '';
  FPathSchemas := '';
  FExibirErroSchema := True;
  FFormatoAlerta := 'TAG:%TAGNIVEL% ID:%ID%/%TAG%(%DESCRICAO%) - %MSG%.';
  // O Formato da mensagem de erro pode ser alterado pelo usuario alterando-se a property FFormatoAlerta: onde;
  // %TAGNIVEL%  : Representa o Nivel da TAG; ex: <transp><vol><lacres>
  // %TAG%       : Representa a TAG; ex: <nLacre>
  // %ID%        : Representa a ID da TAG; ex X34
  // %MSG%       : Representa a mensagem de alerta
  // %DESCRICAO% : Representa a Descrição da TAG
  FRetirarAcentos := False;
  FIniFinXMLSECAutomatico := True;
  FModeloDF := moNFe;
  FModeloDFCodigo := StrToInt(ModeloDFToStr(FModeloDF));
  FVersaoDF := ve200;
end;

function TGeralConf.GetFormatoAlerta: String;
begin
  if (FFormatoAlerta = '') or ((pos('%TAGNIVEL%', FFormatoAlerta) <= 0) and
    (pos('%TAG%', FFormatoAlerta) <= 0) and (pos('%ID%', FFormatoAlerta) <= 0) and
    (pos('%MSG%', FFormatoAlerta) <= 0) and
    (pos('%DESCRICAO%', FFormatoAlerta) <= 0)) then
    Result := 'TAG:%TAGNIVEL% ID:%ID%/%TAG%(%DESCRICAO%) - %MSG%.'
  else
    Result := FFormatoAlerta;
end;

function TGeralConf.GetPathSalvar: String;
begin
  if DFeUtil.EstaVazio(FPathSalvar) then
    Result := NotaUtil.PathAplication
  else
    Result := FPathSalvar;

  Result := PathWithDelim(Trim(Result));
end;

function TGeralConf.Save(AXMLName: String; AXMLFile: String;
  aPath: String = ''): boolean;
var
  UTF8Str: String;
begin
  Result := False;
  try
    if DFeUtil.NaoEstaVazio(ExtractFilePath(AXMLName)) then
    begin
      aPath := ExtractFilePath(AXMLName);
      AXMLName := StringReplace(AXMLName, aPath, '', [rfIgnoreCase]);
    end
    else
    begin
      if DFeUtil.EstaVazio(aPath) then
        aPath := PathSalvar
      else
        aPath := PathWithDelim(aPath);
    end;

    AXMLFile := StringReplace(AXMLFile, '<-><->', '', [rfReplaceAll]);
    { Sempre salva o Arquivo em UTF8, independente de qual seja a IDE...
      FPC já trabalha com UTF8 de forma nativa }
    UTF8Str := NotaUtil.ConverteXMLtoUTF8(AXMLFile);

    if not DirectoryExists(aPath) then
      ForceDirectories(aPath);

    WriteToTXT(aPath + AXMLName, UTF8Str, False, False);
    Result := True;
  except
    on E: Exception do
      raise EACBrNFeException.Create('Erro ao salvar .' + E.Message);
  end;
end;

procedure TGeralConf.SetFormaEmissao(AValue: TpcnTipoEmissao);
begin
  FFormaEmissao := AValue;
  FFormaEmissaoCodigo := StrToInt(TpEmisToStr(FFormaEmissao));
end;

procedure TGeralConf.SetCryptoLib(AValue: TCryptoLib);
begin
  {$IFNDEF MSWINDOWS}
  FCryptoLib := libOpenSSL;  // Linux, Mac, apenas OpenSSL é suportado
  {$ELSE}
  FCryptoLib := AValue;
  {$ENDIF}
end;

procedure TGeralConf.SetModeloDF(AValue: TpcnModeloDF);
begin
  FModeloDF := AValue;
  FModeloDFCodigo := StrToInt(ModeloDFToStr(FModeloDF));
end;

procedure TGeralConf.SetVersaoDF(const Value: TpcnVersaoDF);
begin
  FVersaoDF := Value;
end;

{ TWebServicesConf }

constructor TWebServicesConf.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FUF := NFeUF[24];
  FUFCodigo := NFeUFCodigo[24];
  FAmbiente := taHomologacao;
  FAmbienteCodigo := StrToInt(TpAmbToStr(FAmbiente));
  FVisualizar := False;
  FProxyHost := '';
  FProxyPort := '';
  FProxyUser := '';
  FProxyPass := '';
  FAguardarConsultaRet := 0;
  FTentativas := 5;
  FIntervaloTentativas := 1000;
  FAjustaAguardaConsultaRet := False;
  FSalvar := False;
end;

procedure TWebServicesConf.SetAmbiente(AValue: TpcnTipoAmbiente);
begin
  FAmbiente := AValue;
  FAmbienteCodigo := StrToInt(TpAmbToStr(AValue));
end;

procedure TWebServicesConf.SetIntervaloTentativas(const Value: cardinal);
begin
  if (Value > 0) and (Value < 1000) then
    FIntervaloTentativas := 1000
  else
    FIntervaloTentativas := Value;
end;

procedure TWebServicesConf.SetTentativas(const Value: integer);
begin
  if Value <= 0 then
    FTentativas := 5
  else
    FTentativas := Value;
end;

procedure TWebServicesConf.SetUF(AValue: String);
var
  Codigo, i: integer;
begin
  Codigo := -1;
  for i := 0 to High(NFeUF) do
  begin
    if NFeUF[I] = AValue then
      Codigo := NFeUFCodigo[I];
  end;

  if Codigo < 0 then
    raise EACBrNFeException.Create('UF inválida');

  FUF := AValue;
  FUFCodigo := Codigo;
end;

{ TCertificadosConf }

constructor TCertificadosConf.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FSenhaCert := '';
  FCNPJ := '';
  FPathCertificadoPFX := '';

  {$IFDEF MSWINDOWS}
  PCertCarregado := nil;
  FNumeroSerie := '';
  FDataVenc := 0;
  FSubjectName := '';
  {$ENDIF}
end;


{$IFDEF MSWINDOWS}
function TCertificadosConf.GetCertificado: ICertificate2;
var
  Store: IStore3;
  Certs: ICertificates2;
  Cert: ICertificate2;
  Extension: IExtension;
  i, j, k: integer;

  xmldoc: IXMLDOMDocument3;
  xmldsig: IXMLDigitalSignature;
  dsigKey: IXMLDSigKey;
  SigKey: IXMLDSigKeyEx;
  PrivateKey: IPrivateKey;
  hCryptProvider: ULONG_PTR;
  XML, Propriedades: String;
  Lista: TStringList;
begin
  if (PCertCarregado <> nil) and (NumCertCarregado = FNumeroSerie) then
    Result := PCertCarregado
  else
  begin
    CoInitialize(nil); // PERMITE O USO DE THREAD
    try
      if DFeUtil.EstaVazio(FNumeroSerie) then
        raise EACBrNFeException.Create(
          'Número de Série do Certificado Digital não especificado !');

      Result := nil;
      Store := CoStore.Create;
      Store.Open(CAPICOM_CURRENT_USER_STORE, CAPICOM_STORE_NAME,
        CAPICOM_STORE_OPEN_READ_ONLY);

      Certs := Store.Certificates as ICertificates2;
      for i := 1 to Certs.Count do
      begin
        Cert := IInterface(Certs.Item[i]) as ICertificate2;
        if Cert.SerialNumber = FNumeroSerie then
        begin
          if DFeUtil.EstaVazio(NumCertCarregado) then
            NumCertCarregado := Cert.SerialNumber;

          PrivateKey := Cert.PrivateKey;

          if CertStoreMem = nil then
          begin
            CertStoreMem := CoStore.Create;
            CertStoreMem.Open(CAPICOM_MEMORY_STORE, 'MemoriaACBr',
              CAPICOM_STORE_OPEN_READ_ONLY);
            CertStoreMem.Add(Cert);

            if (FSenhaCert <> '') and PrivateKey.IsHardwareDevice then
            begin
              XML := XML +
                '<Signature xmlns="http://www.w3.org/2000/09/xmldsig#"><SignedInfo><CanonicalizationMethod Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315"/><SignatureMethod Algorithm="http://www.w3.org/2000/09/xmldsig#rsa-sha1" />';
              XML := XML + '<Reference URI="#">';
              XML := XML +
                '<Transforms><Transform Algorithm="http://www.w3.org/2000/09/xmldsig#enveloped-signature" /><Transform Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315" /></Transforms><DigestMethod Algorithm="http://www.w3.org/2000/09/xmldsig#sha1" />';
              XML := XML +
                '<DigestValue></DigestValue></Reference></SignedInfo><SignatureValue></SignatureValue><KeyInfo></KeyInfo></Signature>';

              xmldoc := CoDOMDocument50.Create;
              xmldoc.async := False;
              xmldoc.validateOnParse := False;
              xmldoc.preserveWhiteSpace := True;
              xmldoc.loadXML(XML);
              xmldoc.setProperty('SelectionNamespaces', DSIGNS);

              xmldsig := CoMXDigitalSignature50.Create;
              xmldsig.signature := xmldoc.selectSingleNode('.//ds:Signature');
              xmldsig.store := CertStoreMem;

              dsigKey := xmldsig.createKeyFromCSP(PrivateKey.ProviderType,
                PrivateKey.ProviderName, PrivateKey.ContainerName, 0);
              if (dsigKey = nil) then
                raise EACBrNFeException.Create('Erro ao criar a chave do CSP.');

              SigKey := dsigKey as IXMLDSigKeyEx;
              SigKey.getCSPHandle(hCryptProvider);

              try
                CryptSetProvParam(hCryptProvider, PP_SIGNATURE_PIN,
                  Windows.PBYTE(FSenhaCert), 0);
              finally
                CryptReleaseContext(hCryptProvider, 0);
              end;

              SigKey := nil;
              dsigKey := nil;
              xmldsig := nil;
              xmldoc := nil;
            end;
          end;

          Result := Cert;
          PCertCarregado := Result;
          FDataVenc := Cert.ValidToDate;
          FSubjectName := Cert.SubjectName;

          for J := 1 to Cert.Extensions.Count do
          begin
            Extension := IInterface(Cert.Extensions.Item[J]) as IExtension;
            Propriedades := Extension.EncodedData.Format(True);
            if (Pos('2.16.76.1.3.3', Propriedades) > 0) then
            begin
              Lista := TStringList.Create;
              try
                Lista.Text := Propriedades;
                for K := 0 to Lista.Count - 1 do
                begin
                  if (Pos('2.16.76.1.3.3', Lista.Strings[K]) > 0) then
                  begin
                    FCNPJ :=
                      StringReplace(Lista.Strings[K], '2.16.76.1.3.3=', '',
                      [rfIgnoreCase]);

                    FCNPJ := OnlyNumber(HexToAscii(RemoveString(' ', FCNPJ)));
                    break;
                  end;
                end;
              finally
                Lista.Free;
              end;
              break;
            end;
            Extension := nil;
          end;

          break;
        end;
      end;

      if not (Assigned(Result)) then
        raise EACBrNFeException.Create('Certificado Digital não encontrado!');
    finally
      CoUninitialize;
    end;
  end;
end;

function TCertificadosConf.GetNumeroSerie: String;
begin
  Result := FNumeroSerie;
end;

procedure TCertificadosConf.SetNumeroSerie(const Value: String);
begin
  FNumeroSerie := Trim(UpperCase(StringReplace(Value, ' ', '', [rfReplaceAll])));
end;

function TCertificadosConf.SelecionarCertificado: String;
var
  Store: IStore3;
  Certs: ICertificates2;
  Certs2: ICertificates2;
  Cert: ICertificate2;
begin
  Store := CoStore.Create;
  Store.Open(CAPICOM_CURRENT_USER_STORE, CAPICOM_STORE_NAME,
    CAPICOM_STORE_OPEN_READ_ONLY);

  Certs := Store.Certificates as ICertificates2;
  Certs2 := Certs.Select('Certificado(s) Digital(is) disponível(is)',
    'Selecione o Certificado Digital para uso no aplicativo', False);

  if not (Certs2.Count = 0) then
  begin
    Cert := IInterface(Certs2.Item[1]) as ICertificate2;
    FNumeroSerie := Cert.SerialNumber;
    FDataVenc := Cert.ValidToDate;
    FSubjectName := Cert.SubjectName;
  end;

  Result := FNumeroSerie;
end;

function TCertificadosConf.GetDataVenc: TDateTime;
begin
  if DFeUtil.NaoEstaVazio(FNumeroSerie) then
  begin
    if FDataVenc = 0 then
      GetCertificado;
    Result := FDataVenc;
  end
  else
    Result := 0;
end;

function TCertificadosConf.GetSubjectName: String;
begin
  if DFeUtil.NaoEstaVazio(FNumeroSerie) then
  begin
    if FSubjectName = '' then
      GetCertificado;
    Result := FSubjectName;
  end
  else
    Result := '';
end;

{$ENDIF}

function TCertificadosConf.GetCNPJ: String;
begin
{$IFDEF MSWINDOWS}
  if DFeUtil.NaoEstaVazio(FNumeroSerie) then
  begin
    if FCNPJ = '' then
      GetCertificado;
    Result := FCNPJ;
  end
  else
    Result := FCNPJ;
{$ELSE}
  Result := FCNPJ;
{$ENDIF}
end;

{ TArquivosConf }

constructor TArquivosConf.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FSalvar := False;
  FMensal := False;
  FLiteral := False;
  FEmissaoPathNFe := False;
  FSalvarEvento := False;
  FSepararCNPJ := False;
  FSepararModelo := False;
  FSalvarApenasNFeProcessadas := False;
  FPathNFe := '';
  FPathCan := '';
  FPathInu := '';
  FPathDPEC := '';
  FPathCCe := '';
  FPathMDe := '';
  FPathEvento := '';
end;

function TArquivosConf.GetPath(APath: String; ALiteral: String): String;
var
  wDia, wMes, wAno: word;
  Dir, Modelo, AnoMes: String;
  Data: TDateTime;
  LenLiteral: integer;
begin
  if DFeUtil.EstaVazio(APath) then
    Dir := TConfiguracoes(Self.Owner).Geral.PathSalvar
  else
    Dir := APath;

  if FSepararCNPJ then
    Dir := PathWithDelim(Dir) + TConfiguracoes(Self.Owner).Certificados.CNPJ;

  if FSepararModelo then
  begin
    if TConfiguracoes(Self.Owner).Geral.ModeloDF = moNFCe then
      Modelo := 'NFCe'
    else
      Modelo := 'NFe';

    Dir := PathWithDelim(Dir) + Modelo;
  end;

  if FMensal then
  begin
    Data := Now;
    DecodeDate(Data, wAno, wMes, wDia);
    AnoMes := IntToStr(wAno) + IntToStrZero(wMes, 2);

    if Pos(AnoMes, Dir) <= 0 then
      Dir := PathWithDelim(Dir) + AnoMes;
  end;

  LenLiteral := Length(ALiteral);
  if FLiteral and (LenLiteral > 0) then
  begin
    if RightStr(Dir, LenLiteral) <> ALiteral then
      Dir := PathWithDelim(Dir) + ALiteral;
  end;

  if not DirectoryExists(Dir) then
    ForceDirectories(Dir);

  Result := Dir;
end;

function TArquivosConf.GetPathCan(CNPJ: String = ''): String;
begin
  Result := GetPath(FPathCan, 'Can');
end;

function TArquivosConf.GetPathCCe(CNPJ: String = ''): String;
begin
  Result := GetPath(FPathCCe, 'CCe');
end;

function TArquivosConf.GetPathDPEC(CNPJ: String = ''): String;
begin
  Result := GetPath(FPathDPEC, 'DPEC');
end;

function TArquivosConf.GetPathEvento(tipoEvento: TpcnTpEvento;
  CNPJ: String = ''): String;
var
  Dir, Evento: String;
begin
  Dir := GetPath(FPathEvento, 'Evento');

  if FLiteral then
  begin
    case tipoEvento of
      teCCe: Evento := 'CCe';
      teCancelamento: Evento := 'Cancelamento';
      teManifDestConfirmacao: Evento := 'Confirmacao';
      teManifDestCiencia: Evento := 'Ciencia';
      teManifDestDesconhecimento: Evento := 'Desconhecimento';
      teManifDestOperNaoRealizada: Evento := 'NaoRealizada';
    end;

    Dir := PathWithDelim(Dir) + Evento;
  end;

  if not DirectoryExists(Dir) then
    ForceDirectories(Dir);

  Result := Dir;
end;


function TArquivosConf.GetPathInu(CNPJ: String = ''): String;
begin
  Result := GetPath(FPathInu, 'Inu');
end;

function TArquivosConf.GetPathMDe(CNPJ: String = ''): String;
begin
  Result := GetPath(FPathMDe, 'MDe');
end;

function TArquivosConf.GetPathNFe(Data: TDateTime = 0; CNPJ: String = ''): String;
begin
  Result := GetPath(FPathNFe, 'NFe');
end;


end.
