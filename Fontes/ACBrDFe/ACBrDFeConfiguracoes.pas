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

unit ACBrDFeConfiguracoes;

interface

uses
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
    FCNPJ: String;
    FDadosPFX: String;
    FSenha: AnsiString;
    FNumeroSerie: String;
    FArquivoPFX: String;

    procedure SetNumeroSerie(const Value: String);
  public
    constructor Create(AOwner: TComponent); override;
  published
    property ArquivoPFX: String read FArquivoPFX write FArquivoPFX;
    property DadosPFX: String read FDadosPFX write FDadosPFX;
    property NumeroSerie: String read FNumeroSerie write SetNumeroSerie;
    property Senha: AnsiString read FSenha write FSenha;
    property CNPJ: String read FCNPJ write FCNPJ;
  end;

  { TWebServicesConf }

  TWebServicesConf = class(TComponent)
  private
    FVisualizar: Boolean;
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
    FAjustaAguardaConsultaRet: Boolean;
    FSalvar: Boolean;

    procedure SetUF(AValue: String);
    procedure SetAmbiente(AValue: TpcnTipoAmbiente);
    procedure SetTentativas(const Value: integer);
    procedure SetIntervaloTentativas(const Value: cardinal);
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Visualizar: Boolean read FVisualizar write FVisualizar default False;
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
    property AjustaAguardaConsultaRet: Boolean
      read FAjustaAguardaConsultaRet write FAjustaAguardaConsultaRet default False;
    property Salvar: Boolean read FSalvar write FSalvar default False;
  end;

  { TGeralConf }

  TGeralConf = class(TComponent)
  private
    FCryptoLib: TCryptoLib;
    FFormaEmissao: TpcnTipoEmissao;
    FFormaEmissaoCodigo: integer;
    FSalvar: Boolean;
    FAtualizarXMLCancelado: Boolean;
    FPathSalvar: String;
    FPathSchemas: String;
    FExibirErroSchema: Boolean;
    FFormatoAlerta: String;
    FRetirarAcentos: Boolean;
    FIdToken: String;
    FToken: String;
    FValidarDigest: Boolean;

    procedure SetCryptoLib(AValue: TCryptoLib);
    procedure SetFormaEmissao(AValue: TpcnTipoEmissao);
    function GetPathSalvar: String;
    function GetFormatoAlerta: String;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property CryptoLib: TCryptoLib read FCryptoLib write SetCryptoLib;
    property FormaEmissao: TpcnTipoEmissao read FFormaEmissao
      write SetFormaEmissao default teNormal;
    property FormaEmissaoCodigo: integer read FFormaEmissaoCodigo;
    property Salvar: Boolean read FSalvar write FSalvar default False;
    property AtualizarXMLCancelado: Boolean
      read FAtualizarXMLCancelado write FAtualizarXMLCancelado default True;
    property PathSalvar: String read GetPathSalvar write FPathSalvar;
    property PathSchemas: String read FPathSchemas write FPathSchemas;
    property ExibirErroSchema: Boolean read FExibirErroSchema write FExibirErroSchema;
    property FormatoAlerta: String read GetFormatoAlerta write FFormatoAlerta;
    property RetirarAcentos: Boolean read FRetirarAcentos write FRetirarAcentos;
    property IdToken: String read FIdToken write FIdToken;
    property Token: String read FToken write FToken;
    property ValidarDigest: Boolean
      read FValidarDigest write FValidarDigest default True;
  end;

  { TArquivosConf }

  TArquivosConf = class(TComponent)
  private
    FSalvar: Boolean;
    FMensal: Boolean;
    FLiteral: Boolean;
    FEmissaoPathNFe: Boolean;
    FSalvarEvento: Boolean;
    FSepararCNPJ: Boolean;
    FSepararModelo: Boolean;
    FSalvarApenasNFeProcessadas: Boolean;
    FPathNFe: String;
    FPathCan: String;
    FPathInu: String;
    FPathDPEC: String;
    FPathCCe: String;
    FPathMDe: String;
    FPathEvento: String;
  private

  public
    constructor Create(AOwner: TComponent); override;

  published
    property Salvar: Boolean read FSalvar write FSalvar default False;
    property PastaMensal: Boolean read FMensal write FMensal default False;
    property AdicionarLiteral: Boolean read FLiteral write FLiteral default False;
    property EmissaoPathNFe: Boolean read FEmissaoPathNFe
      write FEmissaoPathNFe default False;
    property SalvarCCeCanEvento: Boolean read FSalvarEvento
      write FSalvarEvento default False;
    property SepararPorCNPJ: Boolean read FSepararCNPJ write FSepararCNPJ default False;
    property SepararPorModelo: Boolean read FSepararModelo
      write FSepararModelo default False;
    property SalvarApenasNFeProcessadas: Boolean
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
  pcnGerador, Math, StrUtils, ACBrUtil, ACBrDFeUtil, DateUtils;

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
  FIdToken := '';
  FToken := '';
  FValidarDigest := True;
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
    Result := DFeUtil.PathAplication
  else
    Result := FPathSalvar;

  Result := PathWithDelim(Trim(Result));
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
    raise Exception.Create(ACBrStr('UF inválida'));

  FUF := AValue;
  FUFCodigo := Codigo;
end;

{ TCertificadosConf }

constructor TCertificadosConf.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FSenha := '';
  FArquivoPFX := '';
  FDadosPFX := '';
  FNumeroSerie := '';
end;

procedure TCertificadosConf.SetNumeroSerie(const Value: String);
begin
  FNumeroSerie := Trim(UpperCase(StringReplace(Value, ' ', '', [rfReplaceAll])));
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


end.
(*

TODO: MOVER


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

{$IFDEF MSWINDOWS}
function SelecionarCertificado: String;
function GetCertificado: ICertificate2;
{$ENDIF}


function Save(AXMLName: String; AXMLFile: String; aPath: String = ''): boolean;



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
        raise Exception.Create( ACBrStr(
          'Número de Série do Certificado Digital não especificado !') );

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


FIniFinXMLSECAutomatico: Boolean;

property IniFinXMLSECAutomatico: Boolean
  read FIniFinXMLSECAutomatico write FIniFinXMLSECAutomatico;

    FIniFinXMLSECAutomatico := True;


    FModeloDFCodigo: integer;
    FModeloDF: TpcnModeloDF;
    FVersaoDF: TpcnVersaoDF;

    procedure SetModeloDF(AValue: TpcnModeloDF);
    procedure SetVersaoDF(const Value: TpcnVersaoDF);

    property ModeloDF: TpcnModeloDF read FModeloDF write SetModeloDF default moNFe;
    property ModeloDFCodigo: integer read FModeloDFCodigo;
    property VersaoDF: TpcnVersaoDF read FVersaoDF write SetVersaoDF default ve200;

    FModeloDF := moNFe;
    FModeloDFCodigo := StrToInt(ModeloDFToStr(FModeloDF));
    FVersaoDF := ve200;

    procedure TGeralConf.SetModeloDF(AValue: TpcnModeloDF);
    begin
      FModeloDF := AValue;
      FModeloDFCodigo := StrToInt(ModeloDFToStr(FModeloDF));
    end;

    procedure TGeralConf.SetVersaoDF(const Value: TpcnVersaoDF);
    begin
      FVersaoDF := Value;
    end;



    function GetPath(APath: String = ''; ALiteral: String = ''): String;
    function GetPathCan: String;
    function GetPathDPEC: String;
    function GetPathInu: String;
    function GetPathNFe(Data: TDateTime = 0): String;
    function GetPathCCe: String;
    function GetPathMDe: String;
    function GetPathEvento(tipoEvento: TpcnTpEvento): String;

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

    function TArquivosConf.GetPathCan: String;
    begin
      Result := GetPath(FPathCan, 'Can');
    end;

    function TArquivosConf.GetPathCCe: String;
    begin
      Result := GetPath(FPathCCe, 'CCe');
    end;

    function TArquivosConf.GetPathDPEC: String;
    begin
      Result := GetPath(FPathDPEC, 'DPEC');
    end;

    function TArquivosConf.GetPathEvento(tipoEvento: TpcnTpEvento): String;
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


    function TArquivosConf.GetPathInu: String;
    begin
      Result := GetPath(FPathInu, 'Inu');
    end;

    function TArquivosConf.GetPathMDe: String;
    begin
      Result := GetPath(FPathMDe, 'MDe');
    end;

    function TArquivosConf.GetPathNFe(Data: TDateTime): String;
    begin
      Result := GetPath(FPathNFe, 'NFe');
    end;


*)
