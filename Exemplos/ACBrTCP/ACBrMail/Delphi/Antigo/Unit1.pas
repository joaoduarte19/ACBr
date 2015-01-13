unit Unit1;


interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ComCtrls, ACBrMail, types, ACBrBase;

type

  { TForm1 }

  TForm1 = class(TForm)
    ACBrMail1: TACBrMail;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Memo1: TMemo;
    ProgressBar1: TProgressBar;
    procedure ACBrMail1MailProcess(const aStatus: TMailStatus);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  ProgressBar1.Position := 1;
  Sleep(500);
  ACBrMail1.From := 'seu_email';
  ACBrMail1.FromName := 'seu_nome_opcional';
  ACBrMail1.Host := 'smtp.gmail.com'; // troque pelo seu servidor smtp
  ACBrMail1.Username := 'seu_usuario';
  ACBrMail1.Password := 'sua_senha';
  ACBrMail1.Port := '465'; // troque pela porta do seu servidor smtp
  ACBrMail1.AddAddress('um_email','um_nome_opcional');
  ACBrMail1.AddCC('um_email'); // opcional
  ACBrMail1.AddReplyTo('um_email'); // opcional
  ACBrMail1.AddBCC('um_email'); // opcional
  ACBrMail1.Subject := 'Teste de Envio'; // assunto
  ACBrMail1.IsHTML := True; // define que a mensagem é html
  // mensagem principal do e-mail. pode ser html ou texto puro
  ACBrMail1.Body.Text :=
  '<html>'+#13+#10+
  '<head>'+#13+#10+#13+#10+
  '  <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">'+#13+#10+
  '</head>'+#13+#10+
  '<body text="#000000" bgcolor="#FFFFFF">'+#13+#10+
  '<h1>Texto em HTML.</h1><br>'+#13+#10+
  '</body>'+#13+#10+
  '</html>'+#13+#10;
  ACBrMail1.AltBody.Text := 'Texto puro alternativo.';
  ACBrMail1.AddAttachment('um_arquivo','um_nome_opcional');
  ACBrMail1.Send;
end;

procedure TForm1.ACBrMail1MailProcess(const aStatus: TMailStatus);
begin
  ProgressBar1.Position := Integer( aStatus );

  case aStatus of
    pmsStartProcess:
    begin
      Memo1.Lines.Clear;
      Memo1.Lines.Add('Iniciando processo de envio.');
    end;
    pmsConfigHeaders:
      Memo1.Lines.Add('Configurando o cabeçalho do e-mail.');
    pmsLoginSMTP:
      Memo1.Lines.Add('Logando no servidor de e-mail.');
    pmsStartSends:
      Memo1.Lines.Add('Iniciando os envios.');
    pmsSendTo:
      Memo1.Lines.Add('Processando lista de destinatários.');
    pmsSendCC:
      Memo1.Lines.Add('Processando lista CC.');
    pmsSendBCC:
      Memo1.Lines.Add('Processando lista BCC.');
    pmsSendReplyTo:
      Memo1.Lines.Add('Processando lista ReplyTo.');
    pmsSendData:
      Memo1.Lines.Add('Enviando dados.');
    pmsLogoutSMTP:
      Memo1.Lines.Add('Fazendo Logout no servidor de e-mail.');
    pmsDone:
    begin
      Memo1.Lines.Add('Terminando e limpando.');
      ProgressBar1.Position := ProgressBar1.Max;
    end;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  ProgressBar1.Position := 1;
  Sleep(500);
  ACBrMail1.From := 'seu_email';
  ACBrMail1.FromName := 'seu_nome_opcional';
  ACBrMail1.Host := 'smtp.gmail.com'; // troque pelo seu servidor smtp
  ACBrMail1.Username := 'seu_usuario';
  ACBrMail1.Password := 'sua_senha';
  ACBrMail1.Port := '465'; // troque pela porta do seu servidor smtp
  ACBrMail1.AddAddress('um_email','um_nome_opcional');
  ACBrMail1.AddCC('um_email'); // opcional
  ACBrMail1.AddReplyTo('um_email'); // opcional
  ACBrMail1.AddBCC('um_email'); // opcional
  ACBrMail1.Subject := 'Teste de Envio'; // assunto
  ACBrMail1.IsHTML := False; // define que a mensagem é texto puro
  // mensagem principal do e-mail. pode ser html ou texto puro
  ACBrMail1.ReadingConfirmation := True; // solicita confirmação de leitura
  ACBrMail1.Body.Text := 'Mensagem em texto puro.';
  ACBrMail1.Send;
end;

end.

