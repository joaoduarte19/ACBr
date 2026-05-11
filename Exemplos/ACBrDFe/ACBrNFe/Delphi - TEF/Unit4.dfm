object Form4: TForm4
  Left = 506
  Top = 178
  Caption = 'OnExibeMenu'
  ClientHeight = 352
  ClientWidth = 507
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -19
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poOwnerFormCenter
  OnShow = FormShow
  TextHeight = 24
  object Splitter1: TSplitter
    Left = 235
    Top = 50
    Width = 5
    Height = 252
    Align = alRight
    Visible = False
    ExplicitLeft = 237
    ExplicitHeight = 261
  end
  object ListBox1: TListBox
    Left = 0
    Top = 50
    Width = 235
    Height = 252
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ItemHeight = 24
    ParentFont = False
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 507
    Height = 50
    Align = alTop
    Caption = 'Panel1'
    TabOrder = 1
  end
  object Panel2: TPanel
    Left = 0
    Top = 302
    Width = 507
    Height = 50
    Align = alBottom
    TabOrder = 2
    DesignSize = (
      507
      50)
    object BitBtn1: TBitBtn
      Left = 78
      Top = 9
      Width = 70
      Height = 35
      Anchors = [akTop]
      Caption = '&OK'
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
    end
    object BitBtn2: TBitBtn
      Left = 186
      Top = 9
      Width = 102
      Height = 35
      Anchors = [akTop]
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 2
    end
    object BitBtn3: TBitBtn
      Left = 328
      Top = 9
      Width = 102
      Height = 35
      Anchors = [akTop]
      Kind = bkRetry
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object Memo1: TMemo
    Left = 240
    Top = 50
    Width = 267
    Height = 252
    Align = alRight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 3
    Visible = False
    WordWrap = False
  end
end
