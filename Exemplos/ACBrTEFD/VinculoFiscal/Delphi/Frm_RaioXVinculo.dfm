object frmRaioXVinculo: TfrmRaioXVinculo
  Left = 0
  Top = 0
  Caption = 'Raio-X do V'#237'nculo: resposta do TEF -> tags da NFC-e'
  ClientHeight = 640
  ClientWidth = 940
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnCreate = FormCreate
  TextHeight = 15
  object pnlTopo: TPanel
    Left = 0
    Top = 0
    Width = 940
    Height = 48
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lblTitulo: TLabel
      Left = 12
      Top = 4
      Width = 600
      Height = 21
      Caption = 'De onde veio cada tag do grupo <pag> (YA) da NFC-e'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblChave: TLabel
      Left = 12
      Top = 27
      Width = 600
      Height = 15
      Caption = 'NFC-e:'
    end
  end
  object sgVinculo: TStringGrid
    Left = 0
    Top = 48
    Width = 940
    Height = 289
    Align = alClient
    ColCount = 5
    DefaultRowHeight = 20
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goRowSelect]
    TabOrder = 1
  end
  object Splitter1: TSplitter
    Left = 0
    Top = 337
    Width = 940
    Height = 4
    Cursor = crVSplit
    Align = alBottom
  end
  object pnlBaixo: TPanel
    Left = 0
    Top = 341
    Width = 940
    Height = 255
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object gbComprovante: TGroupBox
      Left = 0
      Top = 0
      Width = 440
      Height = 255
      Align = alLeft
      Caption = ' Comprovante do TEF x conte'#250'do m'#237'nimo da norma '
      TabOrder = 0
      object mmComprovante: TMemo
        Left = 2
        Top = 17
        Width = 436
        Height = 236
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Consolas'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
    object gbXML: TGroupBox
      Left = 440
      Top = 0
      Width = 500
      Height = 255
      Align = alClient
      Caption = ' Trecho <pag> do XML enviado '#224' SEFAZ '
      TabOrder = 1
      object mmXML: TMemo
        Left = 2
        Top = 17
        Width = 496
        Height = 236
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Consolas'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssBoth
        WordWrap = False
        TabOrder = 0
      end
    end
  end
  object pnlRodape: TPanel
    Left = 0
    Top = 596
    Width = 940
    Height = 44
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    DesignSize = (
      940
      44)
    object btnFechar: TButton
      Left = 832
      Top = 8
      Width = 96
      Height = 28
      Anchors = [akTop, akRight]
      Caption = 'Fechar'
      TabOrder = 0
      OnClick = btnFecharClick
    end
  end
end
