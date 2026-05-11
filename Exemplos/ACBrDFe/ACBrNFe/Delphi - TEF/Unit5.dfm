object Form5: TForm5
  Left = 365
  Top = 160
  Caption = 'OnObtemCampo'
  ClientHeight = 163
  ClientWidth = 509
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -19
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poOwnerFormCenter
  DesignSize = (
    509
    163)
  TextHeight = 24
  object Edit1: TEdit
    Left = 32
    Top = 72
    Width = 443
    Height = 32
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
    ExplicitWidth = 441
  end
  object BitBtn1: TBitBtn
    Left = 84
    Top = 119
    Width = 70
    Height = 35
    Anchors = [akTop]
    Caption = '&OK'
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 1
  end
  object BitBtn2: TBitBtn
    Left = 187
    Top = 119
    Width = 102
    Height = 35
    Anchors = [akTop]
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 4
    ExplicitLeft = 186
  end
  object BitBtn3: TBitBtn
    Left = 323
    Top = 119
    Width = 102
    Height = 35
    Anchors = [akTop]
    Kind = bkRetry
    NumGlyphs = 2
    TabOrder = 2
    ExplicitLeft = 322
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 509
    Height = 50
    Align = alTop
    Caption = 'Panel1'
    TabOrder = 3
    ExplicitWidth = 507
  end
end
