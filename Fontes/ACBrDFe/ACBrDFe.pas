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

unit ACBrDFe;

interface

uses
  Classes, SysUtils, IniFiles,
  ACBrBase, ACBrDFeConfiguracoes, ACBrMail, ACBrDFeSSL, pcnConversao,
  {$IFDEF FPC}
     PropEdits
  {$ELSE}
    {$IFNDEF COMPILER6_UP}
       DsgnIntf
    {$ELSE}
       DesignIntf,
       DesignEditors
    {$ENDIF}
  {$ENDIF} ;


const
  ACBRDFE_VERSAO = '0.1.0a';

type

  { EACBrDFeException }

  EACBrDFeException = class(Exception)
  public
    constructor Create(const Msg: String);
  end;

  { TACBrUFProperty }

  TACBrUFProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc : TGetStrProc) ; override;
  end;

  { TACBrDFe }

  TACBrDFe = class(TACBrComponent)
  private
    FMAIL: TACBrMail;
    FSSL: TDFeSSL;
    FOnStatusChange: TNotifyEvent;
    FOnGerarLog: TACBrGravarLog;
    procedure SetAbout(AValue: String);
    procedure SetMAIL(AValue: TACBrMail);
  protected
    FPConfiguracoes: TConfiguracoes;
    FPIniParams: TMemIniFile;

    function GetAbout: String; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    function GetNomeArquivoServicos: String; virtual;
    function CreateConfiguracoes: TConfiguracoes; virtual;

    procedure LerParamsIni; virtual;

  public
    property SSL: TDFeSSL read FSSL;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function NomeModeloDFe: String; virtual;
    function GetNameSpaceURI: String; virtual;

    function Gravar(NomeArquivo: String; ConteudoXML: String; aPath: String = ''): Boolean;
    procedure EnviarEmail(const sSmtpHost, sSmtpPort, sSmtpUser,
      sSmtpPasswd, sFrom, sTo, sAssunto: String; sMensagem: TStrings;
      SSL: Boolean; sCC: TStrings = nil; Anexos: TStrings = nil;
      PedeConfirma: Boolean = False; AguardarEnvio: Boolean = False;
      NomeRemetente: String = ''; TLS: Boolean = True;
      StreamNFe: TStringStream = nil; NomeArq: String = '';
      UsarThread: Boolean = True; HTML: Boolean = False);

    procedure LerServicoDeParams(const ModeloDFe, UF: String;
      const TipoAmbiente: TpcnTipoAmbiente; const NomeServico: String;
      var Versao: Double; var URL: String);
    function LerVersaoDeParams(const ModeloDFe, UF: String;
      const TipoAmbiente: TpcnTipoAmbiente; const NomeServico: String;
      VersaoBase: Double): Double; virtual;
    function LerURLDeParams(const ModeloDFe, UF: String;
      const TipoAmbiente: TpcnTipoAmbiente; const NomeServico: String;
      VersaoBase: Double): String; virtual;

    procedure FazerLog(const Msg: AnsiString; out Tratado: Boolean);
    procedure GerarException(Msg: String);

  published
    property Configuracoes: TConfiguracoes read FPConfiguracoes write FPConfiguracoes;
    property MAIL: TACBrMail read FMAIL write SetMAIL;
    property OnStatusChange: TNotifyEvent read FOnStatusChange write FOnStatusChange;
    property About: String read GetAbout write SetAbout stored False;
    property OnGerarLog: TACBrGravarLog read FOnGerarLog write FOnGerarLog;
  end;

implementation

uses ACBrUtil, ACBrDFeUtil, strutils;

{ TACBrUFProperty }

function TACBrUFProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paAutoUpdate];
end;

procedure TACBrUFProperty.GetValues(Proc: TGetStrProc);
var
 i : Integer;
begin
  inherited;
  for i:= 0 to High(NFeUF) do
    Proc(NFeUF[i]);
end;

{ EACBrDFeException }

constructor EACBrDFeException.Create(const Msg: String);
begin
  inherited Create(ACBrStr(Msg));
end;

{ TACBrDFe }

constructor TACBrDFe.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FPConfiguracoes := CreateConfiguracoes;
  FPConfiguracoes.Name := 'Configuracoes';
  {$IFDEF COMPILER6_UP}
  FPConfiguracoes.SetSubComponent(True);{ para gravar no DFM/XFM }
  {$ENDIF}

  FSSL := TDFeSSL.Create(Self);
  FOnGerarLog := nil;

  FPIniParams := TMemIniFile.Create(Configuracoes.Arquivos.IniServicos);
end;

function TACBrDFe.CreateConfiguracoes: TConfiguracoes;
begin
  Result := TConfiguracoes.Create(self);
end;

destructor TACBrDFe.Destroy;
begin
  {$IFDEF ACBrNFeOpenSSL}
  if FConfiguracoes.Geral.IniFinXMLSECAutomatico then
    NotaUtil.ShutDownXmlSec;
  {$ENDIF}

  FPConfiguracoes.Free;
  FPIniParams.Free;

  inherited;
end;

function TACBrDFe.NomeModeloDFe: String;
begin
  Result := '';
end;

function TACBrDFe.GetNameSpaceURI: String;
begin
  Result := '';
end;

function TACBrDFe.GetAbout: String;
begin
  Result := 'ACBrDFe Ver: ' + ACBRDFE_VERSAO;
end;

procedure TACBrDFe.SetAbout(AValue: String);
begin

end;


function TACBrDFe.Gravar(NomeArquivo: String; ConteudoXML: String; aPath: String
  ): Boolean;
var
  UTF8Str, SoNome, SoPath: String;
begin
  Result := False;
  try
    SoNome := ExtractFileName(NomeArquivo);
    if DFeUtil.EstaVazio(SoNome) then
      raise EACBrDFeException.Create('Nome de arquivo não informado');

    SoPath := ExtractFilePath(NomeArquivo);
    if DFeUtil.EstaVazio(SoPath) then
      SoPath := aPath;
    if DFeUtil.EstaVazio(SoPath) then
      SoPath := FPConfiguracoes.Arquivos.PathSalvar;

    aPath := PathWithDelim(aPath);

    ConteudoXML := StringReplace(ConteudoXML, '<-><->', '', [rfReplaceAll]);
    { Sempre salva o Arquivo em UTF8, independente de qual seja a IDE...
      FPC já trabalha com UTF8 de forma nativa }
    UTF8Str := DFeUtil.ConverteXMLtoUTF8(ConteudoXML);

    if not DirectoryExists(SoPath) then
      ForceDirectories(SoPath);

    NomeArquivo := SoPath + SoNome;

    WriteToTXT(NomeArquivo, UTF8Str, False, False);
    Result := True;
  except
    on E: Exception do
      GerarException('Erro ao salvar.' + E.Message);
  end;
end;

procedure TACBrDFe.EnviarEmail(
  const sSmtpHost, sSmtpPort, sSmtpUser, sSmtpPasswd, sFrom, sTo, sAssunto: String;
  sMensagem: TStrings; SSL: Boolean; sCC: TStrings; Anexos: TStrings;
  PedeConfirma: Boolean; AguardarEnvio: Boolean; NomeRemetente: String;
  TLS: Boolean; StreamNFe: TStringStream; NomeArq: String; UsarThread: Boolean;
  HTML: Boolean);
begin
  // TODO: Fazer envio de e-mail usando ACBrMail
end;

function TACBrDFe.GetNomeArquivoServicos: String;
begin
  Result := 'ACBrServicosDFe.ini';
  raise EACBrDFeException.Create(
    'GetNomeArquivoServicos não implementado para: ' + ClassName);
end;

procedure TACBrDFe.LerParamsIni;
begin
  if FPIniParams.Stream.Size = 0 then
  begin
    if Configuracoes.WebServices.Params.Count = 0 then
      Configuracoes.WebServices.LerParams;

    FPIniParams.SetStrings(Configuracoes.WebServices.Params);
  end;
end;

procedure TACBrDFe.LerServicoDeParams(const ModeloDFe, UF: String;
  const TipoAmbiente: TpcnTipoAmbiente; const NomeServico: String;
  var Versao: Double; var URL: String);
var
  Sessao, Chave, K: String;
  SL: TStringList;
  I: integer;
  VersaoAtual, VersaoAchada: Double;
begin
  VersaoAchada := 0;
  URL := '';
  VersaoAtual := Versao;
  LerParamsIni;

  Sessao := ModeloDFe + '_' + UF + IfThen(TipoAmbiente = taProducao, 'P', 'H');

  if not FPIniParams.SectionExists(Sessao) then
    exit;

  Chave := NomeServico + '_' + FormatFloat('0.00', VersaoAtual);

  // Achou com busca exata ? (mesma versao) //
  if DFeUtil.NaoEstaVazio(FPIniParams.ReadString(Sessao, Chave, '')) then
    VersaoAchada := VersaoAtual;

  if VersaoAchada = 0 then
  begin
    // Procure por serviço com o mesmo nome, mas com versão inferior //
    Chave := NomeServico + '_';
    SL := TStringList.Create;
    try
      FPIniParams.ReadSection(Sessao, SL);
      for I := 0 to SL.Count do
      begin
        K := SL[I];

        if copy(K, 1, Length(Chave)) = Chave then
        begin
          VersaoAtual := StrToFloatDef(copy(K, Length(Chave) + 1, Length(K)), 0);

          if (VersaoAtual > VersaoAchada) and (VersaoAtual <= Versao) then
          begin
            VersaoAchada := VersaoAtual;
            Chave := K;
          end;
        end;
      end;
    finally
      SL.Free;
    end;
  end;

  Versao := VersaoAchada;
  if Versao > 0 then
    URL := FPIniParams.ReadString(Sessao, Chave, '')
end;

function TACBrDFe.LerVersaoDeParams(const ModeloDFe, UF: String;
  const TipoAmbiente: TpcnTipoAmbiente; const NomeServico: String;
  VersaoBase: Double): Double;
var
  Versao: Double;
  URL: String;
begin
  Versao := VersaoBase;
  URL := '';

  LerServicoDeParams(ModeloDFe, UF, TipoAmbiente, NomeServico, Versao, URL);
  Result := Versao;
end;

function TACBrDFe.LerURLDeParams(const ModeloDFe, UF: String;
  const TipoAmbiente: TpcnTipoAmbiente; const NomeServico: String;
  VersaoBase: Double): String;
var
  Versao: Double;
  URL: String;
begin
  Versao := VersaoBase;
  URL := '';

  LerServicoDeParams(ModeloDFe, UF, TipoAmbiente, NomeServico, Versao, URL);
  Result := URL;
end;


procedure TACBrDFe.FazerLog(const Msg: AnsiString; out Tratado: Boolean);
begin
  Tratado := False;
  if (Msg <> '') then
  begin
    if Assigned(OnGerarLog) then
      OnGerarLog(Msg, Tratado);
  end;
end;

procedure TACBrDFe.GerarException(Msg: String);
var
  Tratado: Boolean;
begin
  Tratado := False;
  FazerLog('ERRO: ' + Msg, Tratado);

  if not Tratado then
    raise EACBrDFeException.Create(Msg);
end;

procedure TACBrDFe.SetMAIL(AValue: TACBrMail);
begin
  if AValue <> FMAIL then
  begin
    if Assigned(FMAIL) then
      FMAIL.RemoveFreeNotification(Self);

    FMAIL := AValue;

    if AValue <> nil then
      AValue.FreeNotification(self);
  end;
end;

procedure TACBrDFe.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);

  if (Operation = opRemove) and (FMAIL <> nil) and (AComponent is TACBrMail) then
    FMAIL := nil;
end;

end.
