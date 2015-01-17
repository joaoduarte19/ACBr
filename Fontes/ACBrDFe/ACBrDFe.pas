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
  Classes, SysUtils,
  ACBrBase, ACBrDFeConfiguracoes, ACBrMail, ACBrDFeSSL;

const
  ACBRDFE_VERSAO = '0.1.0a';

type

  { EACBrDFeException }

  EACBrDFeException = class(Exception)
  public
    constructor Create(const Msg: String);
  end;

  { TACBrDFe }

  TACBrDFe = class(TACBrComponent)
  private
    FMAIL: TACBrMail;
    FDFeSSL: TDFeSSL;
    FConfiguracoes: TConfiguracoes;
    FOnStatusChange: TNotifyEvent;
    FOnGerarLog: TACBrGravarLog;
    procedure SetAbout(AValue: String);
    procedure SetMAIL(AValue: TACBrMail);
  protected
    function GetAbout: String; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

  public
    property DFeSSL: TDFeSSL read FDFeSSL;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function Gravar(NomeXML: String; ConteudoXML: String; aPath: String = ''): Boolean;
    procedure EnviarEmail(const sSmtpHost, sSmtpPort, sSmtpUser,
      sSmtpPasswd, sFrom, sTo, sAssunto: String; sMensagem: TStrings;
      SSL: Boolean; sCC: TStrings = nil; Anexos: TStrings = nil;
      PedeConfirma: Boolean = False; AguardarEnvio: Boolean = False;
      NomeRemetente: String = ''; TLS: Boolean = True;
      StreamNFe: TStringStream = nil; NomeArq: String = '';
      UsarThread: Boolean = True; HTML: Boolean = False);
  published
    property Configuracoes: TConfiguracoes read FConfiguracoes write FConfiguracoes;
    property MAIL: TACBrMail read FMAIL write SetMAIL;
    property OnStatusChange: TNotifyEvent read FOnStatusChange write FOnStatusChange;
    property About: String read GetAbout write SetAbout stored False;
    property OnGerarLog: TACBrGravarLog read FOnGerarLog write FOnGerarLog;
  end;

implementation

uses ACBrUtil, ACBrDFeUtil;

{ EACBrDFeException }

constructor EACBrDFeException.Create(const Msg: String);
begin
  inherited Create(ACBrStr(Msg));
end;

{ TACBrDFe }

constructor TACBrDFe.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FConfiguracoes := TConfiguracoes.Create(self);
  FConfiguracoes.Name := 'Configuracoes';
  {$IFDEF COMPILER6_UP}
  FConfiguracoes.SetSubComponent(True);{ para gravar no DFM/XFM }
  {$ENDIF}

  FDFeSSL := TDFeSSL.Create(Self);
  FOnGerarLog := nil;
end;

destructor TACBrDFe.Destroy;
begin
  {$IFDEF ACBrNFeOpenSSL}
  if FConfiguracoes.Geral.IniFinXMLSECAutomatico then
    NotaUtil.ShutDownXmlSec;
  {$ENDIF}
  FConfiguracoes.Free;

  inherited;
end;

function TACBrDFe.GetAbout: String;
begin
  Result := 'ACBrDFe Ver: ' + ACBRDFE_VERSAO;
end;

procedure TACBrDFe.SetAbout(AValue: String);
begin

end;


function TACBrDFe.Gravar(NomeXML: String; ConteudoXML: String; aPath: String
  ): Boolean;
var
  UTF8Str: String;
begin
  Result := False;
  try
    if DFeUtil.NaoEstaVazio(ExtractFilePath(NomeXML)) then
    begin
      aPath := ExtractFilePath(NomeXML);
      NomeXML := StringReplace(NomeXML, aPath, '', [rfIgnoreCase]);
    end
    else
    begin
      if DFeUtil.EstaVazio(aPath) then
        aPath := FConfiguracoes.Geral.PathSalvar
      else
        aPath := PathWithDelim(aPath);
    end;

    ConteudoXML := StringReplace(ConteudoXML, '<-><->', '', [rfReplaceAll]);
    { Sempre salva o Arquivo em UTF8, independente de qual seja a IDE...
      FPC já trabalha com UTF8 de forma nativa }
    UTF8Str := DFeUtil.ConverteXMLtoUTF8(ConteudoXML);

    if not DirectoryExists(aPath) then
      ForceDirectories(aPath);

    WriteToTXT(aPath + NomeXML, UTF8Str, False, False);
    Result := True;
  except
    on E: Exception do
      raise EACBrDFeException.Create('Erro ao salvar.' + E.Message);
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











(*

// TODO: Verificar para onde vai


{$IFNDEF NOGUI}
 {$IFDEF CLX} QDialogs, QForms,{$ELSE} Dialogs, Forms,{$ENDIF}
{$ENDIF}

if FConfiguracoes.Geral.IniFinXMLSECAutomatico then
  NotaUtil.OpenSSL_InitXmlSec;


procedure TACBrDFe.SetStatus(const stNewStatus: TStatusACBrNFe);
begin
  if stNewStatus <> FStatus then
  begin
    FStatus := stNewStatus;
    if Assigned(fOnStatusChange) then
      FOnStatusChange(Self);
  end;
end;

*)
