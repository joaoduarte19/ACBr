{******************************************************************************}
{ Projeto: Componente ACBrCTe                                                  }
{  Biblioteca multiplataforma de componentes Delphi para emissão de Conhecimen-}
{ to de Transporte eletrônico - CTe - http://www.cte.fazenda.gov.br            }
{                                                                              }
{ Direitos Autorais Reservados (c) 2008 Wemerson Souto                         }
{                                       Wiliam Zacarias da Silva Rosa          }
{                                       Daniel Simoes de Almeida               }
{                                       André Ferreira de Moraes               }
{                                                                              }
{ Desenvolvimento                                                              }
{         de Cte: Wiliam Zacarias da Silva Rosa                                }
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
|* 16/12/2008: Wemerson Souto
|*  - Doação do componente para o Projeto ACBr
|* 26/09/2014: Italo Jurisao Junior
|*  - Refactoring, revisão e otimização
*******************************************************************************}

{$I ACBr.inc}

unit ACBrCTe;

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
  pcteCTe, pcnConversao, pcteEnvEventoCTe, pcteRetEnvEventoCTe,
  ACBrUtil, ACBrDFeUtil, ACBrCTeUtil, ACBrCTeConhecimentos, ACBrCTeConfiguracoes,
  ACBrCTeWebServices, ACBrCTeDACTeClass, pcteInutCTe, pcteRetInutCTe;

{$IFDEF PL_103}
const
  ACBRCTE_VERSAO = '0.6.0a XML 1.03';
{$ENDIF}
{$IFDEF PL_104}
const
  ACBRCTE_VERSAO = '0.6.0a XML 1.04';
{$ENDIF}
{$IFDEF PL_200}
const
  ACBRCTE_VERSAO = '0.8.0 XML 2.00';
{$ENDIF}

type
  TACBrCTeAboutInfo = (ACBrCTeAbout);
  
  EACBrCTeException = class(Exception)
  public
    constructor Create(const Msg: string);
  end;

  { Evento para gerar log das mensagens do Componente }
  TACBrCTeLog = procedure(const Mensagem : String) of object;

  TACBrCTe = class(TComponent)
  private
    fsAbout: TACBrCTeAboutInfo;
    FDACTe: TACBrCTeDACTeClass;
    FConhecimentos: TConhecimentos;
    FWebServices: TWebServices;
    FConfiguracoes: TConfiguracoes;
    FEventoCTe: TEventoCTe;
    FInutCTe: TInutCTe;
    FStatus: TStatusACBrCTe;
    FOnStatusChange: TNotifyEvent;
    FOnGerarLog: TACBrCTeLog;

  	procedure SetDACTe(const Value: TACBrCTeDACTeClass);

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
                                     StreamCTe: TStringStream;
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
                                      StreamCTe: TStringStream;
                                      NomeArq: String;
                                      HTML: Boolean = False);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Enviar(ALote: Integer; Imprimir: Boolean = True): Boolean;  overload;
    function Enviar(ALote: String; Imprimir: Boolean = True): Boolean;  overload;
    function Cancelamento(AJustificativa:WideString; ALote: Integer = 0): Boolean;
    function Consultar: Boolean;
    function EnviarEventoCTe(idLote: Integer): Boolean;

    property WebServices: TWebServices     read FWebServices   write FWebServices;
    property Conhecimentos: TConhecimentos read FConhecimentos write FConhecimentos;
    property EventoCTe: TEventoCTe         read FEventoCTe     write FEventoCTe;
    property InutCTe: TInutCTe             read FInutCTe       write FInutCTe;
    property Status: TStatusACBrCTe        read FStatus;

    procedure SetStatus(const stNewStatus: TStatusACBrCTe);

    procedure ImprimirEvento;
    procedure ImprimirEventoPDF;
    procedure ImprimirInutilizacao;
    procedure ImprimirInutilizacaoPDF;

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
                                      Anexos: TStrings = nil;
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
                               Anexos: TStrings = nil;
                               PedeConfirma: Boolean = False;
                               AguardarEnvio: Boolean = False;
                               NomeRemetente: String = '';
                               TLS: Boolean = True;
                               StreamCTe: TStringStream = nil;
                               NomeArq: String = '';
                               UsarThread: Boolean = True;
                               HTML: Boolean = False);
  published
    property Configuracoes: TConfiguracoes   read FConfiguracoes  write FConfiguracoes;
    property OnStatusChange: TNotifyEvent    read FOnStatusChange write FOnStatusChange;
  	property DACTe: TACBrCTeDACTeClass       read FDACTe          write SetDACTe;
    property AboutACBrCTe: TACBrCTeAboutInfo read fsAbout         write fsAbout stored false;
    property OnGerarLog: TACBrCTeLog         read FOnGerarLog     write FOnGerarLog;
  end;

procedure ACBrAboutDialog;

implementation

procedure ACBrAboutDialog;
var
  Msg: String;
begin
  Msg := 'Componente ACBrCTe' + #10 +
         'Versão: ' + ACBRCTe_VERSAO + #10 + #10 +
         'Automação Comercial Brasil' + #10 + #10 +
         'http://acbr.sourceforge.net' + #10 + #10 +
         'Projeto Cooperar - PCN' + #10 + #10 +
         'http://www.projetocooperar.org/pcn/';

  MessageDlg(Msg, mtInformation, [mbOk], 0);
end;

{ TACBrCTe }

constructor TACBrCTe.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FConfiguracoes := TConfiguracoes.Create(self);
  FConfiguracoes.Name := 'Configuracoes';
  {$IFDEF COMPILER6_UP}
   FConfiguracoes.SetSubComponent(true); { para gravar no DFM/XFM }
  {$ENDIF}

  FConhecimentos := TConhecimentos.Create(Self,Conhecimento);
  FConhecimentos.Configuracoes := FConfiguracoes;

  FEventoCTe   := TEventoCTe.Create;
  FInutCTe     := TInutCTe.Create;
  FWebServices := TWebServices.Create(Self);

  if FConfiguracoes.WebServices.Tentativas <= 0 then
     FConfiguracoes.WebServices.Tentativas := 5;
{$IFDEF ACBrCTeOpenSSL}
  if FConfiguracoes.Geral.IniFinXMLSECAutomatico then
   CteUtil.InitXmlSec;
{$ENDIF}
  FOnGerarLog := nil;
end;

destructor TACBrCTe.Destroy;
begin
{$IFDEF ACBrCTeOpenSSL}
  if FConfiguracoes.Geral.IniFinXMLSECAutomatico then
   CteUtil.ShutDownXmlSec;
{$ENDIF}
  FConfiguracoes.Free;
  FConhecimentos.Free;
  FEventoCTe.Free;
  FInutCTe.Free;
  FWebServices.Free;

  inherited;
end;

procedure TACBrCTe.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);

  if (Operation = opRemove) and (FDACTe <> nil) and (AComponent is TACBrCTeDACTeClass) then
     FDACTe := nil;
end;

procedure TACBrCTe.SetDACTe(const Value: TACBrCTeDACTeClass);
var
  OldValue: TACBrCTeDACTeClass;
begin
  if Value <> FDACTe then
  begin
     if Assigned(FDACTe) then
        FDACTe.RemoveFreeNotification(Self);

     OldValue := FDACTe;   // Usa outra variavel para evitar Loop Infinito
     FDACTe   := Value;    // na remoção da associação dos componentes

     if Assigned(OldValue) then
        if Assigned(OldValue.ACBrCTe) then
           OldValue.ACBrCTe := nil;

     if Value <> nil then
     begin
        Value.FreeNotification(self);
        Value.ACBrCTe := self;
     end;
  end;
end;

procedure TACBrCTe.SetStatus(const stNewStatus: TStatusACBrCTe);
begin
  if (stNewStatus <> FStatus) then
  begin
    FStatus := stNewStatus;
    if Assigned(fOnStatusChange) then
      FOnStatusChange(Self);
  end;
end;

function TACBrCTe.Consultar: Boolean;
var
  i: Integer;
begin
  if Self.Conhecimentos.Count = 0 then
   begin
      if Assigned(Self.OnGerarLog) then
         Self.OnGerarLog('ERRO: Nenhum Conhecimento de Transporte Eletrônico Informado!');
      raise Exception.Create('Nenhum Conhecimento de Transporte Eletrônico Informado!');
   end;

  for i := 0 to Self.Conhecimentos.Count-1 do
  begin
    WebServices.Consulta.CTeChave := copy(self.Conhecimentos.Items[i].CTe.infCTe.ID,
     (length(self.Conhecimentos.Items[i].CTe.infCTe.ID)-44)+1, 44);
    WebServices.Consulta.Executar;
  end;

  Result := True;
end;

function TACBrCTe.Enviar(ALote: Integer; Imprimir: Boolean = True): Boolean;
begin
  Result := Enviar(IntToStr(ALote), Imprimir);
end;

function TACBrCTe.Enviar(ALote: String; Imprimir: Boolean): Boolean;
var
  i: Integer;
begin
  if Conhecimentos.Count <= 0 then
   begin
      if Assigned(Self.OnGerarLog) then
         Self.OnGerarLog('ERRO: Nenhum CT-e adicionado ao Lote');
      raise Exception.Create('ERRO: Nenhum CT-e adicionado ao Lote');
     exit;
   end;

  if Conhecimentos.Count > 50 then
   begin
      if Assigned(Self.OnGerarLog) then
         Self.OnGerarLog('ERRO: Conjunto de CT-e transmitidos (máximo de 50 CT-e) excedido. Quantidade atual: ' + IntToStr(Conhecimentos.Count));
      raise Exception.Create('ERRO: Conjunto de CT-e transmitidos (máximo de 50 CT-e) excedido. Quantidade atual: ' + IntToStr(Conhecimentos.Count));
     exit;
   end;

  Conhecimentos.Assinar;
  Conhecimentos.Valida;

  Result := WebServices.Envia(ALote);

  if DACTe <> nil then
  begin
     for i := 0 to Conhecimentos.Count-1 do
     begin
       if Conhecimentos.Items[i].Confirmada and Imprimir then
       begin
         Conhecimentos.Items[i].Imprimir;
       end;
     end;
  end;
end;

function TACBrCTe.Cancelamento(AJustificativa: WideString;
  ALote: Integer): Boolean;
var
  i : Integer;
begin
  if Self.Conhecimentos.Count = 0 then
   begin
      if Assigned(Self.OnGerarLog) then
         Self.OnGerarLog('ERRO: Nenhum CT-e Informado!');
      raise EACBrCTeException.Create('Nenhum CT-e Informado!');
   end;

  for i:= 0 to self.Conhecimentos.Count-1 do
  begin
    Self.WebServices.Consulta.CTeChave := OnlyNumber(self.Conhecimentos.Items[i].CTe.infCTe.Id);

    if not Self.WebServices.Consulta.Executar then
      raise Exception.Create(Self.WebServices.Consulta.Msg);

    Self.EventoCTe.Evento.Clear;
    with Self.EventoCTe.Evento.Add do
     begin
       infEvento.CNPJ   := copy(DFeUtil.LimpaNumero(Self.WebServices.Consulta.CTeChave), 7, 14);
       infEvento.cOrgao := StrToIntDef(copy(OnlyNumber(Self.WebServices.Consulta.CTeChave), 1, 2), 0);
       infEvento.dhEvento := now;
       infEvento.tpEvento := teCancelamento;
       infEvento.chCTe := Self.WebServices.Consulta.CTeChave;
       infEvento.detEvento.nProt := Self.WebServices.Consulta.Protocolo;
       infEvento.detEvento.xJust := AJustificativa;
     end;
     try
        Self.EnviarEventoCTe(ALote);
     except
        raise Exception.Create(Self.WebServices.EnvEvento.EventoRetorno.xMotivo);
     end;
  end;
  Result := True;
end;

procedure TACBrCTe.EnviaEmailThread(const sSmtpHost, sSmtpPort, sSmtpUser,
  sSmtpPasswd, sFrom, sTo, sAssunto: String; sMensagem: TStrings;
  SSL: Boolean; sCC, Anexos: TStrings; PedeConfirma,
  AguardarEnvio: Boolean; NomeRemetente: String; TLS: Boolean;
  StreamCTe: TStringStream; NomeArq: String; HTML: Boolean = False);
var
  ThreadSMTP: TSendMailThread;
  m: TMimemess;
  p: TMimepart;
  i: Integer;
begin
 m          := TMimemess.create;
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

    if StreamCTe <> nil then
      m.AddPartBinary(StreamCTe,NomeArq, p);

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

    SetStatus(stCTeEmail);
    ThreadSMTP.Resume; // inicia a thread
    if AguardarEnvio then
    begin
      repeat
        Sleep(1000);
        Application.ProcessMessages;
      until ThreadSMTP.Terminado;
    end;
    SetStatus(stCTeIdle);
 finally
    m.free;
 end;
end;

procedure TACBrCTe.EnviarEmailNormal(const sSmtpHost, sSmtpPort, sSmtpUser,
  sSmtpPasswd, sFrom, sTo, sAssunto: String; sMensagem: TStrings;
  SSL: Boolean; sCC, Anexos: TStrings; PedeConfirma,
  AguardarEnvio: Boolean; NomeRemetente: String; TLS: Boolean;
  StreamCTe: TStringStream; NomeArq: String; HTML: Boolean);
var
  smtp: TSMTPSend;
  msg_lines: TStringList;
  m: TMimemess;
  p: TMimepart;
  I: Integer;
  CorpoEmail: TStringList;
begin
  SetStatus(stCTeEmail);

  msg_lines  := TStringList.Create;
  CorpoEmail := TStringList.Create;
  smtp       := TSMTPSend.Create;
  m          := TMimemess.create;

  try
     p := m.AddPartMultipart('mixed', nil);
     if sMensagem <> nil then
     begin
       if HTML = true then
         m.AddPartHTML(sMensagem, p)
       else
         m.AddPartText(sMensagem, p);
     end;

    if StreamCTe <> nil then
      m.AddPartBinary(StreamCTe, NomeArq, p);

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
     SetStatus(stCTeIdle);
  end;
end;

procedure TACBrCTe.EnviaEmail(const sSmtpHost, sSmtpPort, sSmtpUser,
  sSmtpPasswd, sFrom, sTo, sAssunto: String; sMensagem: TStrings;
  SSL: Boolean; sCC, Anexos: TStrings; PedeConfirma,
  AguardarEnvio: Boolean; NomeRemetente: String; TLS: Boolean;
  StreamCTe: TStringStream; NomeArq: String; UsarThread: Boolean; HTML: Boolean);
begin
  if UsarThread then
  begin
    EnviaEmailThread(sSmtpHost, sSmtpPort, sSmtpUser, sSmtpPasswd, sFrom, sTo,
                     sAssunto, sMensagem, SSL, sCC, Anexos, PedeConfirma,
                     AguardarEnvio, NomeRemetente, TLS, StreamCTe, NomeArq, HTML);
  end
  else
  begin
    EnviarEmailNormal(sSmtpHost, sSmtpPort, sSmtpUser, sSmtpPasswd, sFrom, sTo,
                      sAssunto, sMensagem, SSL, sCC, Anexos, PedeConfirma,
                      AguardarEnvio, NomeRemetente, TLS, StreamCTe, NomeArq, HTML);
  end;
end;

function TACBrCTe.EnviarEventoCTe(idLote: Integer): Boolean;
var
  i: Integer;
begin
  if EventoCTe.Evento.Count <= 0 then
   begin
      if Assigned(Self.OnGerarLog) then
         Self.OnGerarLog('ERRO: Nenhum Evento adicionado ao Lote');
      raise EACBrCTeException.Create('ERRO: Nenhum Evento adicionado ao Lote');
     exit;
   end;

  if EventoCTe.Evento.Count > 1 then
   begin
      if Assigned(Self.OnGerarLog) then
         Self.OnGerarLog('ERRO: Conjunto de Eventos transmitidos (máximo de 1) excedido. Quantidade atual: ' + IntToStr(EventoCTe.Evento.Count));
      raise EACBrCTeException.Create('ERRO: Conjunto de Eventos transmitidos (máximo de 1) excedido. Quantidade atual: ' + IntToStr(EventoCTe.Evento.Count));
     exit;
   end;

  WebServices.EnvEvento.idLote := idLote;

  {Atribuir nSeqEvento, CNPJ, Chave e/ou Protocolo quando não especificar}
  for i := 0 to EventoCTe.Evento.Count -1 do
  begin
    try
      if EventoCTe.Evento.Items[i].InfEvento.nSeqEvento = 0 then
        EventoCTe.Evento.Items[i].infEvento.nSeqEvento := 1;
      if self.Conhecimentos.Count > 0 then
       begin
         if trim(EventoCTe.Evento.Items[i].InfEvento.CNPJ) = '' then
           EventoCTe.Evento.Items[i].InfEvento.CNPJ := self.Conhecimentos.Items[i].CTe.Emit.CNPJ;
         if trim(EventoCTe.Evento.Items[i].InfEvento.chCTe) = '' then
           EventoCTe.Evento.Items[i].InfEvento.chCTe := copy(self.Conhecimentos.Items[i].CTe.infCTe.ID, (length(self.Conhecimentos.Items[i].CTe.infCTe.ID)-44)+1, 44);
         if trim(EventoCTe.Evento.Items[i].infEvento.detEvento.nProt) = '' then
         begin
           if EventoCTe.Evento.Items[i].infEvento.tpEvento = teCancelamento then
            begin
              EventoCTe.Evento.Items[i].infEvento.detEvento.nProt := self.Conhecimentos.Items[i].CTe.procCTe.nProt;
              if trim(EventoCTe.Evento.Items[i].infEvento.detEvento.nProt) = '' then
               begin
                  WebServices.Consulta.CTeChave := EventoCTe.Evento.Items[i].InfEvento.chCTe;
                  if not WebServices.Consulta.Executar then
                    raise Exception.Create(WebServices.Consulta.Msg);
                  EventoCTe.Evento.Items[i].infEvento.detEvento.nProt := WebServices.Consulta.Protocolo;
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
     then raise EACBrCTeException.Create(WebServices.EnvEvento.Msg)
     else raise EACBrCTeException.Create('Erro Desconhecido ao Enviar Evento de CT-e!')
  end;
end;

procedure TACBrCTe.ImprimirEvento;
begin
  if not Assigned(DACTE) then
     raise EACBrCTeException.Create('Componente DACTE não associado.')
  else
     DACTE.ImprimirEVENTO(nil);
end;

procedure TACBrCTe.ImprimirEventoPDF;
begin
  if not Assigned(DACTE) then
     raise EACBrCTeException.Create('Componente DACTE não associado.')
  else
     DACTE.ImprimirEVENTOPDF(nil);
end;

procedure TACBrCTe.ImprimirInutilizacao;
begin
  if not Assigned(DACTE) then
     raise EACBrCTeException.Create('Componente DACTE não associado.')
  else
     DACTE.ImprimirINUTILIZACAO(nil);
end;

procedure TACBrCTe.ImprimirInutilizacaoPDF;
begin
  if not Assigned(DACTE) then
     raise EACBrCTeException.Create('Componente DACTE não associado.')
  else
     DACTE.ImprimirINUTILIZACAOPDF(nil);
end;

procedure TACBrCTe.EnviarEmailEvento(const sSmtpHost, sSmtpPort, sSmtpUser,
  sSmtpPasswd, sFrom, sTo, sAssunto: String; sMensagem: TStrings; SSL,
  EnviaPDF: Boolean; sCC, Anexos: TStrings; PedeConfirma,
  AguardarEnvio: Boolean; NomeRemetente: String; TLS: Boolean);
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
      if DACTE <> nil then
      begin
        ImprimirEventoPDF;
        NomeArq := OnlyNumber(EventoCTe.Evento[0].InfEvento.Id);
//        NomeArq := Copy(EventoCTe.Evento[0].InfEvento.id, 09, 44) +
//                   Copy(EventoCTe.Evento[0].InfEvento.id, 03, 06) +
//                   Copy(EventoCTe.Evento[0].InfEvento.id, 53, 02);
        NomeArq := PathWithDelim(DACTE.PathPDF) + NomeArq + '-procEventoCTe.pdf';

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

{ EACBrCTeException }

constructor EACBrCTeException.Create(const Msg: string);
begin
  inherited Create( ACBrStr(Msg) );
end;

end.
