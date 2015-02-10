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

unit ACBrMDFeManifestos;

interface

uses
  Classes, Sysutils, Dialogs, Forms, StrUtils,
  ACBrMDFeUtil, ACBrMDFeConfiguracoes,
  //{$IFDEF FPC}
     //ACBrMDFeDMLaz,
  //{$ELSE}
     ACBrMDFeDAMDFeClass,
  //{$ENDIF}
  smtpsend, ssl_openssl, mimemess, mimepart, // units para enviar email
  pcnConversao, pcnAuxiliar, pmdfeConversao, pcnLeitor,
  pmdfeMDFe, pmdfeMDFeR, pmdfeMDFeW;

type

  Manifesto = class(TCollectionItem)
  private
    FMDFe: TMDFe;
    FXML: AnsiString;
    FXMLOriginal: AnsiString;
    FConfirmada: Boolean;
    FMsg: AnsiString;
    FAlertas: AnsiString;
    FErroValidacao: AnsiString;
    FErroValidacaoCompleto: AnsiString;
    FNomeArq: String;

    function GetMDFeXML: AnsiString;
    function GerarXML(var XML: String; var Alertas: String): String;
  public
    constructor Create(Collection2: TCollection); override;
    destructor Destroy; override;
    procedure Imprimir;
    procedure ImprimirPDF;
    function SaveToFile(CaminhoArquivo: String = ''): Boolean;
    function SaveToStream(Stream: TStringStream): Boolean;
    procedure EnviarEmail(const sSmtpHost,
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
                                TLS: Boolean = True;
                                UsarThread: Boolean = True;
                                HTML: Boolean = False);

    property MDFe: TMDFe                       read FMDFe                  write FMDFe;
    property XML: AnsiString                   read GetMDFeXML             write FXML;
    property XMLOriginal: AnsiString           read FXMLOriginal           write FXMLOriginal;
    property Confirmada: Boolean               read FConfirmada            write FConfirmada;
    property Msg: AnsiString                   read FMsg                   write FMsg;
    property Alertas: AnsiString               read FAlertas               write FAlertas;
    property ErroValidacao: AnsiString         read FErroValidacao         write FErroValidacao;
    property ErroValidacaoCompleto: AnsiString read FErroValidacaoCompleto write FErroValidacaoCompleto;
    property NomeArq: String                   read FNomeArq               write FNomeArq;
  end;

  TManifestos = class(TOwnedCollection)
  private
    FConfiguracoes: TConfiguracoes;
    FACBrMDFe: TComponent;

    function GetItem(Index: Integer): Manifesto;
    procedure SetItem(Index: Integer; const Value: Manifesto);
  public
    constructor Create(AOwner: TPersistent; ItemClass: TCollectionItemClass);

    procedure GerarMDFe;
    procedure Assinar;
    procedure Valida;
    function ValidaAssinatura(out Msg: String): Boolean;
    procedure Imprimir;
    procedure ImprimirPDF;
    function  Add: Manifesto;
    function Insert(Index: Integer): Manifesto;
    function GetNamePath: String; override;
    function LoadFromFile(CaminhoArquivo: String; AGerarMDFe: Boolean = True): Boolean;
    function LoadFromStream(Stream: TStringStream; AGerarMDFe: Boolean = True): Boolean;
    function LoadFromString(AString: String; AGerarMDFe: Boolean = True): Boolean;
    function SaveToFile(PathArquivo: String = ''): Boolean;

    property Items[Index: Integer]: Manifesto read GetItem         write SetItem;
    property Configuracoes: TConfiguracoes    read FConfiguracoes  write FConfiguracoes;
    property ACBrMDFe: TComponent             read FACBrMDFe;
  end;

  TSendMailThread = class(TThread)
  private
    FException: Exception;
    // FOwner: Manifesto;
    procedure DoHandleException;
  public
    OcorreramErros: Boolean;
    Terminado: Boolean;
    smtp: TSMTPSend;
    sFrom: String;
    sTo: String;
    sCC: TStrings;
    slmsg_Lines: TStrings;

    constructor Create; //(AOwner: Manifesto);
    destructor Destroy; override;
  protected
    procedure Execute; override;
    procedure HandleException;
  end;


implementation

uses
   ACBrUtil, ACBrDFeUtil, pcnGerador, ACBrMDFe;

{ Manifesto }

constructor Manifesto.Create(Collection2: TCollection);
begin
  inherited Create(Collection2);

  FMDFe := TMDFe.Create;

  FMDFe.Ide.modelo  := '58';
  FMDFe.Ide.verProc := 'ACBrMDFe';
  FMDFe.Ide.tpAmb   := TACBrMDFe(TManifestos(Collection).ACBrMDFe).Configuracoes.WebServices.Ambiente;
  FMDFe.Ide.tpEmis  := TACBrMDFe(TManifestos(Collection).ACBrMDFe).Configuracoes.Geral.FormaEmissao;
end;

destructor Manifesto.Destroy;
begin
  FMDFe.Free;
  inherited Destroy;
end;

procedure Manifesto.Imprimir;
begin
  if not Assigned(TACBrMDFe(TManifestos(Collection).ACBrMDFe).DAMDFe) then
     raise Exception.Create('Componente DAMDFe não associado.')
  else
     TACBrMDFe(TManifestos(Collection).ACBrMDFe).DAMDFe.ImprimirDAMDFe(MDFe);
end;

procedure Manifesto.ImprimirPDF;
begin
  if not Assigned(TACBrMDFe(TManifestos(Collection).ACBrMDFe).DAMDFe) then
     raise Exception.Create('Componente DAMDFe não associado.')
  else
     TACBrMDFe(TManifestos(Collection).ACBrMDFe).DAMDFe.ImprimirDAMDFePDF(MDFe);
end;

function Manifesto.SaveToFile(CaminhoArquivo: String = ''): Boolean;
var
  ArqXML, Alertas, ArqTXT : String;
begin
  try
     Result := True;
     ArqTXT := GerarXML(ArqXML, Alertas);
     if DFeUtil.EstaVazio(CaminhoArquivo) then
        CaminhoArquivo := PathWithDelim(TACBrMDFe(TManifestos(Collection).ACBrMDFe).Configuracoes.Geral.PathSalvar) + copy(MDFe.infMDFe.ID, (length(MDFe.infMDFe.ID)-44)+1, 44)+'-mdfe.xml';

     if DFeUtil.EstaVazio(CaminhoArquivo) or not DirectoryExists(ExtractFilePath(CaminhoArquivo)) then
        raise EACBrMDFeException.Create('Caminho Inválido: ' + CaminhoArquivo);

     WriteToTXT(CaminhoArquivo, ArqXML, False, False);

     NomeArq := CaminhoArquivo;
  except
     raise;
     Result := False;
  end;
end;

function Manifesto.SaveToStream(Stream: TStringStream): Boolean;
var
  ArqXML, Alertas : String;
begin
  try
     Result := True;
     GerarXML(ArqXML, Alertas);
     Stream.WriteString(ArqXML);
  except
     Result := False;
  end;
end;

procedure Manifesto.EnviarEmail(const sSmtpHost,
                                      sSmtpPort,
                                      sSmtpUser,
                                      sSmtpPasswd,
                                      sFrom,
                                      sTo,
                                      sAssunto: String;
                                      sMensagem: TStrings;
                                      SSL: Boolean;
                                      EnviaPDF: Boolean = true;
                                      sCC: TStrings=nil;
                                      Anexos:TStrings=nil;
                                      PedeConfirma: Boolean = False;
                                      AguardarEnvio: Boolean = False;
                                      NomeRemetente: String = '';
                                      TLS: Boolean = True;
                                      UsarThread: Boolean = True;
                                      HTML: Boolean = False);
var
 NomeArq: String;
 AnexosEmail: TStrings;
 StreamMDFe: TStringStream;
begin
 AnexosEmail := TStringList.Create;
 StreamMDFe  := TStringStream.Create('');
 try
    AnexosEmail.Clear;
    if Anexos <> nil then
      AnexosEmail.Text := Anexos.Text;
    if NomeArq <> '' then
     begin
       SaveToFile(NomeArq);
       AnexosEmail.Add(NomeArq);
     end
    else
     begin
       SaveToStream(StreamMDFe);
     end;
    if (EnviaPDF) then
    begin
       if TACBrMDFe(TManifestos(Collection).ACBrMDFe).DAMDFE <> nil then
       begin
          TACBrMDFe(TManifestos(Collection).ACBrMDFe).DAMDFE.ImprimirDAMDFEPDF(MDFe);
          NomeArq := StringReplace(MDFe.infMDFe.ID,'MDFe', '', [rfIgnoreCase]);
          NomeArq := PathWithDelim(TACBrMDFe(TManifestos(Collection).ACBrMDFe).DAMDFE.PathPDF) + NomeArq + '-mdfe.pdf';
          AnexosEmail.Add(NomeArq);
       end;
    end;
    TACBrMDFe(TManifestos(Collection).ACBrMDFe).EnviaEmail(sSmtpHost, sSmtpPort,
                                                           sSmtpUser, sSmtpPasswd,
                                                           sFrom, sTo, sAssunto,
                                                           sMensagem, SSL, sCC,
                                                           AnexosEmail, PedeConfirma,
                                                           AguardarEnvio, NomeRemetente,
                                                           TLS, StreamMDFe,
                                                           copy(MDFe.infMDFe.ID, (length(MDFe.infMDFe.ID)-44)+1, 44) + '-mdfe.xml',
                                                           UsarThread, HTML);
 finally
    AnexosEmail.Free;
    StreamMDFe.Free;
 end;
end;

function Manifesto.GetMDFeXML: AnsiString;
var
 ArqXML, Alertas: String;
begin
 GerarXML(ArqXML, Alertas);
 Result := ArqXML;
end;

function Manifesto.GerarXML(var XML, Alertas: String): String;
var
  LocMDFeW : TMDFeW;
begin
  LocMDFeW := TMDFeW.Create(Self.MDFe);
  try
     LocMDFeW.Gerador.Opcoes.FormatoAlerta  := TACBrMDFe(TManifestos(Collection).ACBrMDFe).Configuracoes.Geral.FormatoAlerta;
     LocMDFeW.Gerador.Opcoes.RetirarAcentos := TACBrMDFe(TManifestos(Collection).ACBrMDFe).Configuracoes.Geral.RetirarAcentos;
     LocMDFeW.VersaoDF                      := TACBrMDFe(TManifestos(Collection).ACBrMDFe).Configuracoes.Geral.VersaoDF;

     LocMDFeW.GerarXml;
     XML     := LocMDFeW.Gerador.ArquivoFormatoXML;
     Alertas := LocMDFeW.Gerador.ListaDeAlertas.Text;
     Result  := '';
  finally
     LocMDFeW.Free;
  end;
end;

{ TManifestos }

constructor TManifestos.Create(AOwner: TPersistent;
  ItemClass: TCollectionItemClass);
begin
  if not (AOwner is TACBrMDFe) then
     raise Exception.Create('AOwner deve ser do tipo TACBrMDFe');

  inherited;

  FACBrMDFe := TACBrMDFe(AOwner);
end;

function TManifestos.Add: Manifesto;
begin
  Result := Manifesto(inherited Add);

  Result.MDFe.Ide.tpAmb := Configuracoes.WebServices.Ambiente;
end;

procedure TManifestos.Assinar;
var
  i: Integer;
  vAssinada: AnsiString;
  ArqXML, Alertas: String;
  Leitor: TLeitor;
  FMsg: AnsiString;
begin
  for i:= 0 to Self.Count-1 do
   begin
     Self.Items[i].GerarXML(ArqXML, Alertas);
     Self.Items[i].Alertas := Alertas;

{$IFDEF ACBrMDFeOpenSSL}
     if not(MDFeUtil.Assinar(ArqXML, FConfiguracoes.Certificados.Certificado , FConfiguracoes.Certificados.Senha, vAssinada, FMsg)) then
       raise Exception.Create('Falha ao assinar Manifesto Eletrônico de Documentos Fiscais '+
                                   IntToStr(Self.Items[i].MDFe.Ide.cMDF)+FMsg);
{$ELSE}
     if not(MDFeUtil.Assinar(ArqXML, FConfiguracoes.Certificados.GetCertificado , vAssinada, FMsg)) then
       raise Exception.Create('Falha ao assinar Manifesto Eletrônico de Documentos Fiscais '+
                                   IntToStr(Self.Items[i].MDFe.Ide.cMDF)+FMsg);
{$ENDIF}
     vAssinada := StringReplace(vAssinada, '<'+ENCODING_UTF8_STD+'>', '', [rfReplaceAll]);
     vAssinada := StringReplace(vAssinada, '<?xml version="1.0"?>', '', [rfReplaceAll]);
     Self.Items[i].XML := vAssinada;

     Leitor := TLeitor.Create;
     try
       leitor.Grupo := vAssinada;
       Self.Items[i].MDFe.signature.URI := Leitor.rAtributo('Reference URI=');
       Self.Items[i].MDFe.signature.DigestValue := Leitor.rCampo(tcStr, 'DigestValue');
       Self.Items[i].MDFe.signature.SignatureValue := Leitor.rCampo(tcStr, 'SignatureValue');
       Self.Items[i].MDFe.signature.X509Certificate := Leitor.rCampo(tcStr, 'X509Certificate');
     finally
       Leitor.Free;
     end;

     if FConfiguracoes.Geral.Salvar then
       FConfiguracoes.Geral.Save(StringReplace(Self.Items[i].MDFe.infMDFe.ID, 'MDFe', '', [rfIgnoreCase]) + '-mdfe.xml', vAssinada);

     if DFeUtil.NaoEstaVazio(Self.Items[i].NomeArq) then
       FConfiguracoes.Geral.Save(ExtractFileName(Self.Items[i].NomeArq), vAssinada, ExtractFilePath(Self.Items[i].NomeArq));
   end;
end;

procedure TManifestos.GerarMDFe;
var
 i: Integer;
 ArqXML, Alertas: String;
begin
 for i:= 0 to Self.Count-1 do
  begin
    Self.Items[i].GerarXML(ArqXML, Alertas);
    Self.Items[i].XML := UTF8Encode(ArqXML);
    Self.Items[i].Alertas := Alertas;
  end;
end;

function TManifestos.GetItem(Index: Integer): Manifesto;
begin
  Result := Manifesto(inherited Items[Index]);
end;

function TManifestos.GetNamePath: String;
begin
  Result := 'Manifesto';
end;

procedure TManifestos.Imprimir;
begin
  if not Assigned(TACBrMDFe(FACBrMDFe).DAMDFe) then
     raise Exception.Create('Componente DAMDFe não associado.')
  else
     TACBrMDFe(FACBrMDFe).DAMDFe.ImprimirDAMDFe(nil);
end;

procedure TManifestos.ImprimirPDF;
begin
  if not Assigned(TACBrMDFe(FACBrMDFe).DAMDFe) then
     raise Exception.Create('Componente DAMDFe não associado.')
  else
     TACBrMDFe(FACBrMDFe).DAMDFe.ImprimirDAMDFePDF(nil);
end;

function TManifestos.Insert(Index: Integer): Manifesto;
begin
  Result := Manifesto(inherited Insert(Index));
end;

procedure TManifestos.SetItem(Index: Integer; const Value: Manifesto);
begin
  Items[Index].Assign(Value);
end;

procedure TManifestos.Valida;
var
 i: Integer;
 FMsg: AnsiString;
begin
  for i:= 0 to Self.Count-1 do
   begin
     if pos('<Signature', Self.Items[i].XML) = 0 then
        Assinar;
     if not(MDFeUtil.Valida(('<MDFe xmlns' + RetornarConteudoEntre(Self.Items[i].XML, '<MDFe xmlns', '</MDFe>')+ '</MDFe>'),
                            FMsg, Self.FConfiguracoes.Geral.PathSchemas)) then
      begin
        Self.Items[i].ErroValidacaoCompleto := 'Falha na validação dos dados do Manifesto ' +
                                               IntToStr(Self.Items[i].MDFe.Ide.nMDF) + sLineBreak +
                                               Self.Items[i].Alertas + FMsg;
        Self.Items[i].ErroValidacao := 'Falha na validação dos dados do Manifesto ' +
                                       IntToStr(Self.Items[i].MDFe.Ide.nMDF) + sLineBreak +
                                       Self.Items[i].Alertas +
                                       IfThen(Self.FConfiguracoes.Geral.ExibirErroSchema, FMsg, '');
        raise Exception.Create(Self.Items[i].ErroValidacao);
      end;
  end;

end;

function TManifestos.ValidaAssinatura(out Msg: String): Boolean;
var
 i: Integer;
 FMsg: AnsiString;
begin
  Result := True;
  for i:= 0 to Self.Count-1 do
   begin
     if not(MDFeUtil.ValidaAssinatura(Self.Items[i].XMLOriginal, FMsg)) then
      begin
        Result := False;
        Msg := 'Falha na validação da assinatura do Manifesto ' +
               IntToStr(Self.Items[i].MDFe.Ide.nMDF) + sLineBreak + FMsg;
      end
     else
       Result := True;
  end;
end;

function TManifestos.LoadFromFile(CaminhoArquivo: String; AGerarMDFe: Boolean = True): Boolean;
var
 LocMDFeR: TMDFeR;
 ArquivoXML: TStringList;
 XML, XMLOriginal: AnsiString;
begin
 try
    ArquivoXML := TStringList.Create;
    try
      ArquivoXML.LoadFromFile(CaminhoArquivo {$IFDEF DELPHI2009_UP}, TEncoding.UTF8{$ENDIF});
      XMLOriginal := ArquivoXML.Text;
      Result := True;
      while pos('</MDFe>', ArquivoXML.Text) > 0 do
       begin
         if pos('</mdfeProc>', ArquivoXML.Text) > 0  then
          begin
            XML := copy(ArquivoXML.Text, 1, pos('</mdfeProc>', ArquivoXML.Text) + 5);
            ArquivoXML.Text := Trim(copy(ArquivoXML.Text, pos('</mdfeProc>', ArquivoXML.Text) + 10, length(ArquivoXML.Text)));
          end
         else
          begin
            XML := copy(ArquivoXML.Text, 1, pos('</MDFe>', ArquivoXML.Text) + 5);
            ArquivoXML.Text := Trim(copy(ArquivoXML.Text, pos('</MDFe>', ArquivoXML.Text) + 6, length(ArquivoXML.Text)));
          end;
         LocMDFeR := TMDFeR.Create(Self.Add.MDFe);
         try
            LocMDFeR.Leitor.Arquivo := XML;
            LocMDFeR.LerXml;
            Items[Self.Count-1].XML := LocMDFeR.Leitor.Arquivo;
            Items[Self.Count-1].XMLOriginal := XMLOriginal;
            Items[Self.Count-1].NomeArq := CaminhoArquivo;

            if AGerarMDFe then GerarMDFe;
         finally
            LocMDFeR.Free;
         end;
       end;
     finally
       ArquivoXML.Free;
     end;
 except
    raise;
    Result := False;
 end;
end;

function TManifestos.LoadFromStream(Stream: TStringStream; AGerarMDFe: Boolean = True): Boolean;
var
 LocMDFeR: TMDFeR;
begin
  try
    Result  := True;
    LocMDFeR := TMDFeR.Create(Self.Add.MDFe);
    try
       LocMDFeR.Leitor.CarregarArquivo(Stream);
       LocMDFeR.LerXml;
       Items[Self.Count-1].XML := LocMDFeR.Leitor.Arquivo;
       Items[Self.Count-1].XMLOriginal := Stream.DataString;
       if AGerarMDFe then GerarMDFe;
    finally
       LocMDFeR.Free
    end;
  except
    Result := False;
  end;
end;

function TManifestos.SaveToFile(PathArquivo: String = ''): Boolean;
var
 i: integer;
 CaminhoArquivo: String;
begin
 Result := True;
 try
    for i:= 0 to TACBrMDFe(FACBrMDFe).Manifestos.Count-1 do
     begin
        if DFeUtil.EstaVazio(PathArquivo) then
           PathArquivo := TACBrMDFe(FACBrMDFe).Configuracoes.Geral.PathSalvar
        else
           PathArquivo := ExtractFilePath(PathArquivo);
        CaminhoArquivo := PathWithDelim(PathArquivo) + copy(TACBrMDFe(FACBrMDFe).Manifestos.Items[i].MDFe.inFMDFe.ID, (length(TACBrMDFe(FACBrMDFe).Manifestos.Items[i].MDFe.inFMDFe.ID)-44)+1, 44)+'-mdfe.xml';
        TACBrMDFe(FACBrMDFe).Manifestos.Items[i].SaveToFile(CaminhoArquivo)
     end;
 except
    Result := False;
 end;
end;

function TManifestos.LoadFromString(AString: String; AGerarMDFe: Boolean = True): Boolean;
var
  XMLMDFe: TStringStream;
begin
  try
    XMLMDFe := TStringStream.Create('');
    try
      XMLMDFe.WriteString(AString);
      Result := LoadFromStream(XMLMDFe, AGerarMDFe);
    finally
      XMLMDFe.Free;
    end;
  except
    Result := False;
  end;
end;

{ TSendMailThread }

procedure TSendMailThread.DoHandleException;
begin
  // TACBrMDFe(TManifestos(FOwner.GetOwner).ACBrMDFe).SetStatus(stMDFeIdle);

  // FOwner.Alertas := FException.Message;

  if FException is Exception then
    Application.ShowException(FException)
  else
    SysUtils.ShowException(FException, nil);
end;

constructor TSendMailThread.Create; //(AOwner: Manifesto);
begin
  smtp        := TSMTPSend.Create;
  slmsg_Lines := TStringList.Create;
  sCC         := TStringList.Create;
  sFrom       := '';
  sTo         := '';

  FreeOnTerminate := True;

  inherited Create(True);
end;

destructor TSendMailThread.Destroy;
begin
  slmsg_Lines.Free;
  sCC.Free;
  smtp.Free;

  inherited;
end;

procedure TSendMailThread.Execute;
var
 i: integer;
begin
  inherited;

  try
    Terminado := False;
    try
      if not smtp.Login() then
        raise Exception.Create('SMTP ERROR: Login:' + smtp.EnhCodeString + sLineBreak+smtp.FullResult.Text);

      if not smtp.MailFrom(sFrom, Length(sFrom)) then
        raise Exception.Create('SMTP ERROR: MailFrom:' + smtp.EnhCodeString + sLineBreak+smtp.FullResult.Text);

      if not smtp.MailTo(sTo) then
        raise Exception.Create('SMTP ERROR: MailTo:' + smtp.EnhCodeString + sLineBreak+smtp.FullResult.Text);

      if (sCC <> nil) then
      begin
        for I := 0 to sCC.Count - 1 do
        begin
          if not smtp.MailTo(sCC.Strings[i]) then
            raise Exception.Create('SMTP ERROR: MailTo:' + smtp.EnhCodeString + sLineBreak+smtp.FullResult.Text);
        end;
      end;

      if not smtp.MailData(slmsg_Lines) then
        raise Exception.Create('SMTP ERROR: MailData:' + smtp.EnhCodeString + sLineBreak+smtp.FullResult.Text);

      if not smtp.Logout() then
        raise Exception.Create('SMTP ERROR: Logout:' + smtp.EnhCodeString + sLineBreak+smtp.FullResult.Text);
    finally
      try
        smtp.Sock.CloseSocket;
      except
      end;
      Terminado := True;
    end;
  except
    Terminado := True;
    HandleException;
  end;
end;

procedure TSendMailThread.HandleException;
begin
  FException := Exception(ExceptObject);
  try
    // Não mostra mensagens de EAbort
    if not (FException is EAbort) then
      Synchronize(DoHandleException);
  finally
    FException := nil;
  end;
end;

end.
