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

type

  TSSLLib = (libNone, libOpenSSL, libCapicom, libCapicomDelphiSoap);

  TConfiguracoes = class;

  { TCertificadosConf }

  TCertificadosConf = class(TComponent)
  private
    FConfiguracoes: TConfiguracoes;
    FCNPJ: String;
    FDadosPFX: String;
    FSenha: AnsiString;
    FNumeroSerie: String;
    FArquivoPFX: String;

    procedure SetNumeroSerie(const Value: String);
  public
    constructor Create(AConfiguracoes: TConfiguracoes); reintroduce; overload;
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
    FConfiguracoes: TConfiguracoes;
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
    FParams: TStrings;

    procedure SetUF(AValue: String);
    procedure SetAmbiente(AValue: TpcnTipoAmbiente);
    procedure SetTentativas(const Value: integer);
    procedure SetIntervaloTentativas(const Value: cardinal);
    procedure SetParams(const AValue: TStrings);

  protected
    function LerParamsIniServicos: AnsiString; virtual;
    function LerParamsInterno: AnsiString; virtual;
  public
    constructor Create(AConfiguracoes: TConfiguracoes); reintroduce; overload;
    destructor Destroy; override;

    procedure LerParams; virtual;

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
    property Params: TStrings read FParams write SetParams;
  end;

  { TGeralConf }

  TGeralConf = class(TComponent)
  private
    FConfiguracoes: TConfiguracoes;
    FSSLLib: TSSLLib;
    FFormaEmissao: TpcnTipoEmissao;
    FFormaEmissaoCodigo: integer;
    FSalvar: Boolean;
    FExibirErroSchema: Boolean;
    FFormatoAlerta: String;
    FRetirarAcentos: Boolean;
    FIdToken: String;
    FToken: String;
    FUnloadSSLLib: Boolean;
    FValidarDigest: Boolean;

    procedure SetSSLLib(AValue: TSSLLib);
    procedure SetFormaEmissao(AValue: TpcnTipoEmissao);
    function GetFormatoAlerta: String;
  public
    constructor Create(AConfiguracoes: TConfiguracoes); reintroduce; overload; virtual;
  published
    property SSLLib: TSSLLib read FSSLLib write SetSSLLib;
    property UnloadSSLLib: Boolean read FUnloadSSLLib write FUnloadSSLLib default True;
    property FormaEmissao: TpcnTipoEmissao read FFormaEmissao
      write SetFormaEmissao default teNormal;
    property FormaEmissaoCodigo: integer read FFormaEmissaoCodigo;
    property Salvar: Boolean read FSalvar write FSalvar default False;
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
    FConfiguracoes: TConfiguracoes;

    FPathSalvar: String;
    FPathSchemas: String;
    FIniServicos: String;

    FSalvar: Boolean;
    FAdicionarLiteral: Boolean;
    FSepararCNPJ: Boolean;
    FSepararModelo: Boolean;
    FSepararPorMes: Boolean;
  private

    function GetIniServicos: String;
    function GetPathSalvar: String;
    function GetPathSchemas: String;
  public
    constructor Create(AConfiguracoes: TConfiguracoes); reintroduce; overload; virtual;

    function GetPath(APath: String; ALiteral: String): String; virtual;
  published
    property PathSalvar: String read GetPathSalvar write FPathSalvar;
    property PathSchemas: String read GetPathSchemas write FPathSchemas;
    property IniServicos: String read GetIniServicos write FIniServicos;
    property Salvar: Boolean read FSalvar write FSalvar default False;
    property AdicionarLiteral: Boolean read FAdicionarLiteral
      write FAdicionarLiteral default False;
    property SepararPorCNPJ: Boolean read FSepararCNPJ write FSepararCNPJ default False;
    property SepararPorModelo: Boolean read FSepararModelo
      write FSepararModelo default False;
    property SepararPorMes: Boolean
      read FSepararPorMes write FSepararPorMes default False;
  end;

  { TConfiguracoes }

  TConfiguracoes = class(TComponent)
  protected
    FPGeral: TGeralConf;
    FPWebServices: TWebServicesConf;
    FPCertificados: TCertificadosConf;
    FPArquivos: TArquivosConf;
  protected
    procedure CreateGeralConf; virtual;
    procedure CreateWebServicesConf; virtual;
    procedure CreateCertificadosConf; virtual;
    procedure CreateArquivosConf; virtual;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure LerParams(NomeArqParams: String = '');

    property Geral: TGeralConf read FPGeral;
    property WebServices: TWebServicesConf read FPWebServices;
    property Certificados: TCertificadosConf read FPCertificados;
    property Arquivos: TArquivosConf read FPArquivos;
  end;

implementation

uses
  Math,
  ACBrDFe, ACBrDFeUtil,
  ACBrUtil, DateUtils;

{ TConfiguracoes }

constructor TConfiguracoes.Create(AOwner: TComponent);
begin
  if not (AOwner is TACBrDFe) then
    raise EACBrDFeException.Create('Owner de TConfiguracoes deve ser do tipo TACBrDFe');

  inherited Create(AOwner);

  CreateGeralConf;
  FPGeral.Name := 'GeralConf';
  {$IFDEF COMPILER6_UP}
  FPGeral.SetSubComponent(True);{ para gravar no DFM/XFM }
  {$ENDIF}

  CreateWebServicesConf;
  FPWebServices.Name := 'WebServicesConf';
  {$IFDEF COMPILER6_UP}
  FPWebServices.SetSubComponent(True);{ para gravar no DFM/XFM }
  {$ENDIF}

  CreateCertificadosConf;
  FPCertificados.Name := 'CertificadosConf';
  {$IFDEF COMPILER6_UP}
  FPCertificados.SetSubComponent(True);{ para gravar no DFM/XFM }
  {$ENDIF}

  CreateArquivosConf;
  FPArquivos.Name := 'ArquivosConf';
  {$IFDEF COMPILER6_UP}
  FPArquivos.SetSubComponent(True);{ para gravar no DFM/XFM }
  {$ENDIF}
end;

procedure TConfiguracoes.CreateGeralConf;
begin
  FPGeral := TGeralConf.Create(Self);
end;

procedure TConfiguracoes.CreateWebServicesConf;
begin
  FPWebServices := TWebServicesConf.Create(self);
end;

procedure TConfiguracoes.CreateCertificadosConf;
begin
  FPCertificados := TCertificadosConf.Create(self);
end;

procedure TConfiguracoes.CreateArquivosConf;
begin
  FPArquivos := TArquivosConf.Create(self);
end;

destructor TConfiguracoes.Destroy;
begin
  FPGeral.Free;
  FPWebServices.Free;
  FPCertificados.Free;
  FPArquivos.Free;

  inherited;
end;

procedure TConfiguracoes.LerParams(NomeArqParams: String);
var
  SL: TStringList;
begin
  if not FileExists(NomeArqParams) then
    raise EACBrDFeException.Create('Arquivo de Parâmetro não encontrado: ' +
      NomeArqParams);

  SL := TStringList.Create;
  try
    FPWebServices.Params := SL;
  finally
    SL.Free;
  end;
end;

{ TGeralConf }

constructor TGeralConf.Create(AConfiguracoes: TConfiguracoes);
begin
  inherited Create(AConfiguracoes);

  FConfiguracoes := AConfiguracoes;
  {$IFNDEF MSWINDOWS}
  FSSLLib := libOpenSSL;
  {$ELSE}
  FSSLLib := libCapicom;
  {$ENDIF}
  FUnloadSSLLib := True;
  FFormaEmissao := teNormal;
  FFormaEmissaoCodigo := StrToInt(TpEmisToStr(FFormaEmissao));
  FSalvar := False;
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

procedure TGeralConf.SetFormaEmissao(AValue: TpcnTipoEmissao);
begin
  FFormaEmissao := AValue;
  FFormaEmissaoCodigo := StrToInt(TpEmisToStr(FFormaEmissao));
end;

procedure TGeralConf.SetSSLLib(AValue: TSSLLib);
begin
  {$IFNDEF MSWINDOWS}
  FSSLLib := libOpenSSL;  // Linux, Mac, apenas OpenSSL é suportado
  {$ELSE}
  FSSLLib := AValue;
  {$IFDEF FPC}
  if AValue = libCapicomDelphiSoap then
    FSSLLib := libCapicom;
  {$ENDIF}
  {$ENDIF}
end;


{ TWebServicesConf }

constructor TWebServicesConf.Create(AConfiguracoes: TConfiguracoes);
begin
  inherited Create(AConfiguracoes);

  FConfiguracoes := AConfiguracoes;
  FParams := TStringList.Create;

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

destructor TWebServicesConf.Destroy;
begin
  FParams.Free;
  inherited;
end;

procedure TWebServicesConf.LerParams;
var
  ConteudoParams: AnsiString;
begin
  ConteudoParams := LerParamsIniServicos;

  if ConteudoParams = '' then
    ConteudoParams := LerParamsInterno;

  FParams.Text := ConteudoParams;
end;

procedure TWebServicesConf.SetAmbiente(AValue: TpcnTipoAmbiente);
begin
  FAmbiente := AValue;
  FAmbienteCodigo := StrToInt(TpAmbToStr(AValue));
end;

procedure TWebServicesConf.SetIntervaloTentativas(const Value: cardinal);
begin
  FIntervaloTentativas := max(Value, 1000);
end;

procedure TWebServicesConf.SetParams(const AValue: TStrings);
begin
  FParams.Assign(AValue);
end;

function TWebServicesConf.LerParamsIniServicos: AnsiString;
var
  SL: TStringList;
begin
  Result := '';

  if (FConfiguracoes.Arquivos.IniServicos <> '') and
    FileExists(FConfiguracoes.Arquivos.IniServicos) then
  begin
    SL := TStringList.Create;
    try
      SL.LoadFromFile(FConfiguracoes.Arquivos.IniServicos);
      Result := SL.Text;
    finally
      SL.Free;
    end;
  end;
end;

function TWebServicesConf.LerParamsInterno: AnsiString;
begin
  { SOBRESCREVER NAS CLASSES FILHAS, informando o conteudo DEFAULT do arquivo }
  Result := '';
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
    raise EACBrDFeException.Create('UF inválida');

  FUF := AValue;
  FUFCodigo := Codigo;
end;

{ TCertificadosConf }

constructor TCertificadosConf.Create(AConfiguracoes: TConfiguracoes);
begin
  inherited Create(AConfiguracoes);

  FConfiguracoes := AConfiguracoes;
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

constructor TArquivosConf.Create(AConfiguracoes: TConfiguracoes);
begin
  inherited Create(AConfiguracoes);

  FConfiguracoes := AConfiguracoes;
  FSalvar := False;
  FPathSalvar := '';
  FPathSchemas := '';
  FIniServicos := '';

  FSepararPorMes := False;
  FAdicionarLiteral := False;
  FSepararCNPJ := False;
  FSepararModelo := False;
end;

function TArquivosConf.GetPathSalvar: String;
begin
  if FPathSalvar = '' then
    if not (csDesigning in FConfiguracoes.Owner.ComponentState) then
      FPathSalvar := ApplicationPath + PathDelim + 'Docs';

  FPathSalvar := PathWithDelim(Trim(FPathSalvar));
  Result := FPathSalvar;
end;

function TArquivosConf.GetPathSchemas: String;
begin
  if FPathSchemas = '' then
    if not (csDesigning in FConfiguracoes.Owner.ComponentState) then
      FPathSchemas := ApplicationPath + PathDelim + 'Schemas';

  FPathSchemas := PathWithDelim(Trim(FPathSchemas));
  Result := FPathSchemas;
end;

function TArquivosConf.GetIniServicos: String;
begin
  if FIniServicos = '' then
    if not (csDesigning in FConfiguracoes.Owner.ComponentState) then
      FIniServicos := ApplicationPath + 'ACBrServicos.ini';

  Result := FIniServicos;
end;

function TArquivosConf.GetPath(APath: String; ALiteral: String): String;
var
  wDia, wMes, wAno: word;
  Dir, Modelo, AnoMes: String;
  Data: TDateTime;
  LenLiteral: integer;
begin
  if EstaVazio(APath) then
    Dir := PathSalvar
  else
    Dir := APath;

  if SepararPorCNPJ and NaoEstaVazio(FConfiguracoes.Certificados.CNPJ) then
    Dir := PathWithDelim(Dir) + FConfiguracoes.Certificados.CNPJ;

  if SepararPorModelo then
  begin
    Modelo := TACBrDFe(FConfiguracoes.Owner).GetNomeModeloDFe;
    Dir := PathWithDelim(Dir) + Modelo;
  end;

  if SepararPorMes then
  begin
    Data := Now;
    DecodeDate(Data, wAno, wMes, wDia);
    AnoMes := IntToStr(wAno) + IntToStrZero(wMes, 2);

    if Pos(AnoMes, Dir) <= 0 then
      Dir := PathWithDelim(Dir) + AnoMes;
  end;

  LenLiteral := Length(ALiteral);
  if AdicionarLiteral and (LenLiteral > 0) then
  begin
    if RightStr(Dir, LenLiteral) <> ALiteral then
      Dir := PathWithDelim(Dir) + ALiteral;
  end;

  if not DirectoryExists(Dir) then
    ForceDirectories(Dir);

  Result := Dir;
end;


end.
(*

TODO: MOVER


function Save(AXMLName: String; AXMLFile: String; aPath: String = ''): boolean;


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
      if EstaVazio(APath) then
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
