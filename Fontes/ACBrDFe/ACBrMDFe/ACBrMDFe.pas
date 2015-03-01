{******************************************************************************}
{ Projeto: Componente ACBrMDFe                                                 }
{  Biblioteca multiplataforma de componentes Delphi                            }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do Projeto ACBr     }
{ Componentes localizado em http://www.sourceforge.net/projects/acbr           }
{                                                                              }
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
{ Daniel Simões de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Praça Anita Costa, 34 - Tatuí - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{*******************************************************************************
|* Historico
|*
|* 01/08/2012: Italo Jurisato Junior
|*  - Doação do componente para o Projeto ACBr
*******************************************************************************}

{$I ACBr.inc}

unit ACBrMDFe;

interface

uses
  Classes, Sysutils,
{$IFDEF VisualCLX}
  QDialogs,
{$ELSE}
  Dialogs,
{$ENDIF}
  Forms,
  smtpsend, ssl_openssl, mimemess, mimepart, // units para enviar email
  pcnConversao, pmdfeMDFe,
  pmdfeEnvEventoMDFe, pmdfeRetEnvEventoMDFe,
  ACBrMDFeManifestos, ACBrMDFeConfiguracoes, ACBrUtil, 
  ACBrMDFeWebServices, ACBrMDFeUtil, ACBrDFeUtil, ACBrMDFeDAMDFeClass;

const
  ACBRMDFe_VERSAO = '0.2.0';

type
  TACBrMDFeAboutInfo = (ACBrMDFeAbout);

  EACBrMDFeException = class(Exception)
  public
    constructor Create(const Msg: string);
  end;

  { Evento para gerar log das mensagens do Componente }
  TACBrMDFeLog = procedure(const Mensagem: String) of object;

  TACBrMDFe = class(TComponent)
  private
    fsAbout: TACBrMDFeAboutInfo;
    FDAMDFe: TACBrMDFeDAMDFeClass;
    FManifestos: TManifestos;
    FEventoMDFe: TEventoMDFe;
    FWebServices: TWebServices;
    FConfiguracoes: TConfiguracoes;
    FStatus: TStatusACBrMDFe;
    FOnStatusChange: TNotifyEvent;
    FOnGerarLog: TACBrMDFeLog;

  	procedure SetDAMDFe(const Value: TACBrMDFeDAMDFeClass);

    procedure EnviaEmailThread(const sSmtpHost,
                               sSmtpPort,
                               sSmtpUser,
                               sSmtpPasswd,
                               sFrom,
                               sTo,
                               sAssunto: String;
                               sMensagem: TStrings;
                               SSL: Boolean;
                               sCC,
                               Anexos: TStrings;
                               PedeConfirma,
                               AguardarEnvio: Boolean;
                               NomeRemetente: String;
                               TLS: Boolean;
                               StreamMDFe: TStringStream;
                               NomeArq: String;
                               HTML: Boolean = False);

    procedure EnviarEmailNormal(const sSmtpHost,
                                sSmtpPort,
                                sSmtpUser,
                                sSmtpPasswd,
                                sFrom,
                                sTo,
                                sAssunto: String;
                                sMensagem: TStrings;
                                SSL: Boolean;
                                sCC,
                                Anexos: TStrings;
                                PedeConfirma,
                                AguardarEnvio: Boolean;
                                NomeRemetente: String;
                                TLS: Boolean;
                                StreamMDFe: TStringStream;
                                NomeArq: String;
                                HTML: Boolean = False);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Enviar(ALote: Integer; Imprimir:Boolean = True): Boolean; overload;
    function Enviar(ALote: String; Imprimir: Boolean = True): Boolean; overload;
    function Consultar: Boolean;
    function ConsultarMDFeNaoEnc(ACNPJ: String): Boolean;
    function EnviarEventoMDFe(idLote: Integer): Boolean;

    property WebServices: TWebServices read FWebServices write FWebServices;
    property Manifestos: TManifestos   read FManifestos  write FManifestos;
    property EventoMDFe: TEventoMDFe   read FEventoMDFe  write FEventoMDFe;
    property Status: TStatusACBrMDFe   read FStatus;

    procedure SetStatus(const stNewStatus: TStatusACBrMDFe);
    procedure ImprimirEvento;
    procedure ImprimirEventoPDF;

    procedure EnviarEmailEvento(const sSmtpHost,
                                sSmtpPort,
                                sSmtpUser,
                                sSmtpPasswd,
                                sFrom,
                                sTo,
                                sAssunto: String;
                                sMensagem: TStrings;
                                SSL: Boolean;
                                EnviaPDF: Boolean = true;
                                sCC: TStrings = nil;
                                Anexos:TStrings=nil;
                                PedeConfirma: Boolean = False;
                                AguardarEnvio: Boolean = False;
                                NomeRemetente: String = '';
                                TLS: Boolean = True);

    procedure EnviaEmail(const sSmtpHost,
                         sSmtpPort,
                         sSmtpUser,
                         sSmtpPasswd,
                         sFrom,
                         sTo,
                         sAssunto: String;
                         sMensagem: TStrings;
                         SSL: Boolean;
                         sCC: TStrings = nil;
                         Anexos:TStrings=nil;
                         PedeConfirma: Boolean = False;
                         AguardarEnvio: Boolean = False;
                         NomeRemetente: String = '';
                         TLS: Boolean = True;
                         StreamMDFe: TStringStream = nil;
                         NomeArq: String = '';
                         UsarThread: Boolean = True;
                         HTML: Boolean = False);
  published
    property Configuracoes: TConfiguracoes     read FConfiguracoes  write FConfiguracoes;
    property OnStatusChange: TNotifyEvent      read FOnStatusChange write FOnStatusChange;
  	property DAMDFe: TACBrMDFeDAMDFeClass      read FDAMDFe         write SetDAMDFe;
    property AboutACBrMDFe: TACBrMDFeAboutInfo read fsAbout         write fsAbout stored False;
    property OnGerarLog: TACBrMDFeLog          read FOnGerarLog     write FOnGerarLog;
  end;

procedure ACBrAboutDialog;

implementation

procedure ACBrAboutDialog;
var
 Msg: String;
begin
  Msg := 'Componente ACBrMDFe' + #10 +
         'Versão: ' + ACBRMDFe_VERSAO + #10 + #10 +
         'Automação Comercial Brasil' + #10 + #10 +
         'http://acbr.sourceforge.net' + #10 + #10 +
         'Projeto Cooperar - PCN' + #10 + #10 +
         'http://www.projetocooperar.org/pcn/';

  MessageDlg(Msg, mtInformation, [mbOk], 0);
end;

{ TACBrMDFe }

constructor TACBrMDFe.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FConfiguracoes      := TConfiguracoes.Create(self);
  FConfiguracoes.Name := 'Configuracoes';

{$IFDEF COMPILER6_UP}
  FConfiguracoes.SetSubComponent(true); { para gravar no DFM/XFM }
{$ENDIF}

  FManifestos               := TManifestos.Create(Self, Manifesto);
  FManifestos.Configuracoes := FConfiguracoes;
  FEventoMDFe               := TEventoMDFe.Create;
  FWebServices              := TWebServices.Create(Self);

  if FConfiguracoes.WebServices.Tentativas <= 0
   then FConfiguracoes.WebServices.Tentativas := 5;

{$IFDEF ACBrMDFeOpenSSL}
  if FConfiguracoes.Geral.IniFinXMLSECAutomatico then
    MDFeUtil.InitXmlSec;
{$ENDIF}

  FOnGerarLog := nil;
end;

destructor TACBrMDFe.Destroy;
begin
  FConfiguracoes.Free;
  FManifestos.Free;
  FEventoMDFe.Free;
  FWebServices.Free;

{$IFDEF ACBrMDFeOpenSSL}
  if FConfiguracoes.Geral.IniFinXMLSECAutomatico then
    MDFeUtil.ShutDownXmlSec;
{$ENDIF}

  inherited;
end;

procedure TACBrMDFe.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);

  if (Operation = opRemove) and (FDAMDFe <> nil) and (AComponent is TACBrMDFeDAMDFeClass) then
   FDAMDFe := nil;
end;

procedure TACBrMDFe.SetDAMDFe(const Value: TACBrMDFeDAMDFeClass);
var
 OldValue: TACBrMDFeDAMDFeClass;
begin
  if Value <> FDAMDFe then
  begin
    if Assigned(FDAMDFe) then
     FDAMDFe.RemoveFreeNotification(Self);

    OldValue  := FDAMDFe;   // Usa outra variavel para evitar Loop Infinito
    FDAMDFe   := Value;    // na remoção da associação dos componentes

    if Assigned(OldValue) then
     if Assigned(OldValue.ACBrMDFe) then
      OldValue.ACBrMDFe := nil;

    if Value <> nil then
     begin
       Value.FreeNotification(self);
       Value.ACBrMDFe := self;
     end;
  end;
end;

procedure TACBrMDFe.SetStatus(const stNewStatus: TStatusACBrMDFe);
begin
  if (stNewStatus <> FStatus) then
  begin
    FStatus := stNewStatus;
    if Assigned(fOnStatusChange) then
     FOnStatusChange(Self);
  end;
end;

function TACBrMDFe.Consultar: Boolean;
var
 i: Integer;
begin
  if Self.Manifestos.Count = 0 then
  begin
    if Assigned(Self.OnGerarLog)
     then Self.OnGerarLog('ERRO: Nenhum Manifesto Eletrônico de Documentos Fiscais Informado!');
     raise Exception.Create('Nenhum Manifesto Eletrônico de Documentos Fiscais Informado!');
  end;

  for i := 0 to Self.Manifestos.Count-1 do
  begin
    WebServices.Consulta.MDFeChave := copy(self.Manifestos.Items[i].MDFe.infMDFe.ID,
     (length(self.Manifestos.Items[i].MDFe.infMDFe.ID)-44)+1, 44);
    WebServices.Consulta.Executar;
  end;

  Result := True;
end;

function TACBrMDFe.ConsultarMDFeNaoEnc(ACNPJ: String): Boolean;
begin
  Result := WebServices.ConsultaMDFeNaoEnc(ACNPJ);
end;

function TACBrMDFe.Enviar(ALote: Integer; Imprimir:Boolean = True): Boolean;
begin
  Result := Enviar(IntToStr(ALote), Imprimir);
end;

function TACBrMDFe.Enviar(ALote: String; Imprimir:Boolean = True): Boolean;
var
 i: Integer;
begin
  if Manifestos.Count <= 0 then
  begin
    if Assigned(Self.OnGerarLog)
     then Self.OnGerarLog('ERRO: Nenhum MDF-e adicionado ao Lote');
     raise Exception.Create('ERRO: Nenhum MDF-e adicionado ao Lote');
    exit;
  end;

  if Manifestos.Count > 1 then
  begin
    if Assigned(Self.OnGerarLog)
     then Self.OnGerarLog('ERRO: Conjunto de MDF-e transmitidos (máximo de 1 MDF-e) excedido. Quantidade atual: '+IntToStr(Manifestos.Count));
     raise Exception.Create('ERRO: Conjunto de MDF-e transmitidos (máximo de 1 MDF-e) excedido. Quantidade atual: '+IntToStr(Manifestos.Count));
    exit;
  end;

  Manifestos.Assinar;
  Manifestos.Valida;

  Result := WebServices.Envia(ALote);

  if DAMDFe <> nil then
  begin
    for i:= 0 to Manifestos.Count-1 do
    begin
      if Manifestos.Items[i].Confirmada and Imprimir then
      begin
        Manifestos.Items[i].Imprimir;
      end;
    end;
  end;

end;

procedure TACBrMDFe.EnviaEmailThread(const sSmtpHost, sSmtpPort, sSmtpUser,
  sSmtpPasswd, sFrom, sTo, sAssunto: String; sMensagem: TStrings;
  SSL: Boolean; sCC, Anexos: TStrings; PedeConfirma,
  AguardarEnvio: Boolean; NomeRemetente: String; TLS: Boolean;
  StreamMDFe: TStringStream; NomeArq: String; HTML: Boolean = False);
var
 ThreadSMTP: TSendMailThread;
 m: TMimemess;
 p: TMimepart;
 i: Integer;
begin
 m := TMimemess.create;

 ThreadSMTP := TSendMailThread.Create;  // Não Libera, pois usa FreeOnTerminate := True;
 try
    p := m.AddPartMultipart('mixed', nil);
    if sMensagem <> nil then
    begin
       if HTML = true then
          m.AddPartHTML(sMensagem, p)
       else
          m.AddPartText(sMensagem, p);
    end;

    if StreamMDFe <> nil then
      m.AddPartBinary(StreamMDFe,NomeArq, p);

    if assigned(Anexos) then
      for i := 0 to Anexos.Count - 1 do
      begin
        m.AddPartBinaryFromFile(Anexos[i], p);
      end;

    m.header.tolist.add(sTo);

    if Trim(NomeRemetente) <> '' then
      m.header.From := Format('%s<%s>', [NomeRemetente, sFrom])
    else
      m.header.From := sFrom;

    m.header.subject:= sAssunto;
    m.Header.ReplyTo := sFrom;
    if PedeConfirma then
       m.Header.CustomHeaders.Add('Disposition-Notification-To: '+sFrom);
    m.EncodeMessage;

    ThreadSMTP.sFrom := sFrom;
    ThreadSMTP.sTo   := sTo;
    if sCC <> nil then
       ThreadSMTP.sCC.AddStrings(sCC);
    ThreadSMTP.slmsg_Lines.AddStrings(m.Lines);

    ThreadSMTP.smtp.UserName := sSmtpUser;
    ThreadSMTP.smtp.Password := sSmtpPasswd;

    ThreadSMTP.smtp.TargetHost := sSmtpHost;
    if not EstaVazio(sSmtpPort) then     // Usa default
       ThreadSMTP.smtp.TargetPort := sSmtpPort;

    ThreadSMTP.smtp.FullSSL := SSL;
    ThreadSMTP.smtp.AutoTLS := TLS;

    if (TLS) then
      ThreadSMTP.smtp.StartTLS;

    SetStatus(stMDFeEmail);
    ThreadSMTP.Resume; // inicia a thread
    if AguardarEnvio then
    begin
      repeat
        Sleep(1000);
        Application.ProcessMessages;
      until ThreadSMTP.Terminado;
    end;
    SetStatus(stMDFeIdle);
 finally
    m.free;
 end;
end;

procedure TACBrMDFe.EnviarEmailNormal(const sSmtpHost, sSmtpPort, sSmtpUser,
  sSmtpPasswd, sFrom, sTo, sAssunto: String; sMensagem: TStrings;
  SSL: Boolean; sCC, Anexos: TStrings; PedeConfirma,
  AguardarEnvio: Boolean; NomeRemetente: String; TLS: Boolean;
  StreamMDFe: TStringStream; NomeArq: String; HTML: Boolean);
var
  smtp: TSMTPSend;
  msg_lines: TStringList;
  m: TMimemess;
  p: TMimepart;
  I: Integer;
  CorpoEmail: TStringList;
begin
  SetStatus(stMDFeEmail);

  msg_lines  := TStringList.Create;
  CorpoEmail := TStringList.Create;
  smtp       := TSMTPSend.Create;
  m          := TMimemess.create;
  
  try
    p := m.AddPartMultipart('mixed', nil);
    if sMensagem <> nil then
     begin
//        CorpoEmail.Text := sMensagem.Text;
//        m.AddPartText(CorpoEmail, p);
       if HTML = true then
         m.AddPartHTML(sMensagem, p)
       else
         m.AddPartText(sMensagem, p);
     end;

    if StreamMDFe <> nil then
      m.AddPartBinary(StreamMDFe, NomeArq, p);

    if assigned(Anexos) then
     for i := 0 to Anexos.Count - 1 do
     begin
        m.AddPartBinaryFromFile(Anexos[i], p);
     end;

    m.header.tolist.add(sTo);

    if Trim(NomeRemetente) <> '' then
      m.header.From := Format('%s<%s>', [NomeRemetente, sFrom])
    else
      m.header.From := sFrom;

    m.header.subject := sAssunto;
    m.EncodeMessage;
    msg_lines.Add(m.Lines.Text);

    smtp.UserName := sSmtpUser;
    smtp.Password := sSmtpPasswd;

    smtp.TargetHost := sSmtpHost;
    smtp.TargetPort := sSmtpPort;

    smtp.FullSSL := SSL;
    smtp.AutoTLS := TLS;

    if (TLS) then
      smtp.StartTLS;

    if not smtp.Login then
      raise Exception.Create('SMTP ERROR: Login: ' + smtp.EnhCodeString+sLineBreak+smtp.FullResult.Text);

    if not smtp.MailFrom(sFrom, Length(sFrom)) then
      raise Exception.Create('SMTP ERROR: MailFrom: ' + smtp.EnhCodeString+sLineBreak+smtp.FullResult.Text);

    if not smtp.MailTo(sTo) then
      raise Exception.Create('SMTP ERROR: MailTo: ' + smtp.EnhCodeString+sLineBreak+smtp.FullResult.Text);

    if sCC <> nil then
     begin
       for I := 0 to sCC.Count - 1 do
       begin
         if not smtp.MailTo(sCC.Strings[i]) then
           raise Exception.Create('SMTP ERROR: MailTo: ' + smtp.EnhCodeString+sLineBreak+smtp.FullResult.Text);
       end;
     end;

    if not smtp.MailData(msg_lines) then
      raise Exception.Create('SMTP ERROR: MailData: ' + smtp.EnhCodeString+sLineBreak+smtp.FullResult.Text);

    if not smtp.Logout then
      raise Exception.Create('SMTP ERROR: Logout: ' + smtp.EnhCodeString+sLineBreak+smtp.FullResult.Text);
  finally
    msg_lines.Free;
    CorpoEmail.Free;
    smtp.Free;
    m.free;
    SetStatus(stMDFeIdle);
  end;
end;

procedure TACBrMDFe.EnviaEmail(const sSmtpHost, sSmtpPort, sSmtpUser,
  sSmtpPasswd, sFrom, sTo, sAssunto: String; sMensagem: TStrings;
  SSL: Boolean; sCC, Anexos: TStrings; PedeConfirma,
  AguardarEnvio: Boolean; NomeRemetente: String; TLS: Boolean;
  StreamMDFe: TStringStream; NomeArq: String; UsarThread: Boolean; HTML: Boolean);
begin
  if UsarThread then
  begin
    EnviaEmailThread(sSmtpHost, sSmtpPort, sSmtpUser, sSmtpPasswd, sFrom, sTo,
                     sAssunto, sMensagem, SSL, sCC, Anexos, PedeConfirma,
                     AguardarEnvio, NomeRemetente, TLS, StreamMDFe, NomeArq, HTML);
  end
  else
  begin
    EnviarEmailNormal(sSmtpHost, sSmtpPort, sSmtpUser, sSmtpPasswd, sFrom, sTo,
                      sAssunto, sMensagem, SSL, sCC, Anexos, PedeConfirma,
                      AguardarEnvio, NomeRemetente, TLS, StreamMDFe, NomeArq, HTML);
  end;
end;

function TACBrMDFe.EnviarEventoMDFe(idLote: Integer): Boolean;
var
  i: integer;
begin
  if EventoMDFe.Evento.Count <= 0 then
   begin
      if Assigned(Self.OnGerarLog) then
         Self.OnGerarLog('ERRO: Nenhum Evento adicionado ao Lote');
      raise EACBrMDFeException.Create('ERRO: Nenhum Evento adicionado ao Lote');
     exit;
   end;

  if EventoMDFe.Evento.Count > 1 then
   begin
      if Assigned(Self.OnGerarLog) then
         Self.OnGerarLog('ERRO: Conjunto de Eventos transmitidos (máximo de 1) excedido. Quantidade atual: '+IntToStr(EventoMDFe.Evento.Count));
      raise EACBrMDFeException.Create('ERRO: Conjunto de Eventos transmitidos (máximo de 1) excedido. Quantidade atual: '+IntToStr(EventoMDFe.Evento.Count));
     exit;
   end;

  WebServices.EnvEvento.idLote := idLote;

  {Atribuir nSeqEvento, CNPJ, Chave e/ou Protocolo quando não especificar}
  for i:= 0 to EventoMDFe.Evento.Count -1 do
  begin
    try
      if EventoMDFe.Evento.Items[i].InfEvento.nSeqEvento = 0 then
        EventoMDFe.Evento.Items[i].infEvento.nSeqEvento := 1;
      if self.Manifestos.Count > 0 then
       begin
         if trim(EventoMDFe.Evento.Items[i].InfEvento.CNPJ) = '' then
           EventoMDFe.Evento.Items[i].InfEvento.CNPJ := self.Manifestos.Items[i].MDFe.Emit.CNPJ;
         if trim(EventoMDFe.Evento.Items[i].InfEvento.chMDFe) = '' then
           EventoMDFe.Evento.Items[i].InfEvento.chMDFe := copy(self.Manifestos.Items[i].MDFe.infMDFe.ID, (length(self.Manifestos.Items[i].MDFe.infMDFe.ID)-44)+1, 44);
         if trim(EventoMDFe.Evento.Items[i].infEvento.detEvento.nProt) = '' then
         begin
           if EventoMDFe.Evento.Items[i].infEvento.tpEvento = teCancelamento then
            begin
              EventoMDFe.Evento.Items[i].infEvento.detEvento.nProt := self.Manifestos.Items[i].MDFe.procMDFe.nProt;
              if trim(EventoMDFe.Evento.Items[i].infEvento.detEvento.nProt) = '' then
               begin
                  WebServices.Consulta.MDFeChave := EventoMDFe.Evento.Items[i].InfEvento.chMDFe;
                  if not WebServices.Consulta.Executar then
                    raise Exception.Create(WebServices.Consulta.Msg);
                  EventoMDFe.Evento.Items[i].infEvento.detEvento.nProt := WebServices.Consulta.Protocolo;
               end;
            end;
         end;
       end;
    except
    end;
  end;

  Result := WebServices.EnvEvento.Executar;
  if not Result then
  begin
    if Assigned(Self.OnGerarLog) then
      Self.OnGerarLog(WebServices.EnvEvento.Msg);
    if WebServices.EnvEvento.Msg <> ''
     then raise EACBrMDFeException.Create(WebServices.EnvEvento.Msg)
     else raise EACBrMDFeException.Create('Erro Desconhecido ao Enviar Evento de MDF-e!')
  end;
end;

procedure TACBrMDFe.EnviarEmailEvento(const sSmtpHost, sSmtpPort,
  sSmtpUser, sSmtpPasswd, sFrom, sTo, sAssunto: String;
  sMensagem: TStrings; SSL, EnviaPDF: Boolean; sCC, Anexos: TStrings;
  PedeConfirma, AguardarEnvio: Boolean; NomeRemetente: String;
  TLS: Boolean);
var
  NomeArq: String;
  AnexosEmail: TStrings;
begin
  AnexosEmail := TStringList.Create;
  try
    AnexosEmail.Clear;
    if Anexos <> nil then
      AnexosEmail.Text := Anexos.Text;

    if (EnviaPDF) then
    begin
      if DAMDFE <> nil then
      begin
        ImprimirEventoPDF;
        NomeArq := OnlyNumber(EventoMDFe.Evento[0].InfEvento.Id);
//        NomeArq := Copy(EventoMDFe.Evento[0].InfEvento.id, 09, 44) +
//                   Copy(EventoMDFe.Evento[0].InfEvento.id, 03, 06) +
//                   Copy(EventoMDFe.Evento[0].InfEvento.id, 53, 02);
        NomeArq := PathWithDelim(DAMDFE.PathPDF) + NomeArq + '-procEventoMDFe.pdf';
        AnexosEmail.Add(NomeArq);
      end;
    end;

    EnviaEmail(sSmtpHost, sSmtpPort, sSmtpUser, sSmtpPasswd, sFrom, sTo,
               sAssunto, sMensagem, SSL, sCC, AnexosEmail, PedeConfirma,
               AguardarEnvio, NomeRemetente, TLS);
  finally
    AnexosEmail.Free;
  end;
end;

procedure TACBrMDFe.ImprimirEvento;
begin
  if not Assigned(DAMDFE) then
     raise EACBrMDFeException.Create('Componente DAMDFE não associado.')
  else
     DAMDFE.ImprimirEVENTO(nil);
end;

procedure TACBrMDFe.ImprimirEventoPDF;
begin
  if not Assigned(DAMDFE) then
     raise EACBrMDFeException.Create('Componente DAMDFE não associado.')
  else
     DAMDFE.ImprimirEVENTOPDF(nil);
end;

{ EACBrMDFeException }

constructor EACBrMDFeException.Create(const Msg: string);
begin
  inherited Create( ACBrStr(Msg) );
end;

end.
