object Form1: TForm1
  Left = 331
  Top = 236
  Width = 792
  Height = 299
  Caption = 'Exemplo ACBrMail'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 142
    Width = 194
    Height = 30
    Alignment = taCenter
    AutoSize = False
    Caption = 'Altere os par'#226'metros no c'#243'digo'#13#10'antes de fazer os envios.'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object Button1: TButton
    Left = 8
    Top = 24
    Width = 194
    Height = 25
    Caption = 'Enviar como HTML e com Anexo'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 64
    Width = 194
    Height = 25
    Caption = 'Enviar Texto Puro'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Memo1: TMemo
    Left = 213
    Top = 24
    Width = 534
    Height = 191
    TabOrder = 1
  end
  object ProgressBar1: TProgressBar
    Left = 213
    Top = 224
    Width = 534
    Height = 20
    Max = 11
    Step = 1
    TabOrder = 3
  end
  object ACBrMail1: TACBrMail
    Host = '127.0.0.1'
    Port = '25'
    SetSSL = False
    SetTLS = False
    Attempts = 3
    OnMailProcess = ACBrMail1MailProcess
    Left = 88
    Top = 192
  end
end
