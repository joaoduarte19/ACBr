object framePDV: TframePDV
  Left = 0
  Top = 0
  Width = 918
  Height = 617
  Align = alClient
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object pnlStatusCaixa: TPanel
    Left = 0
    Top = 0
    Width = 918
    Height = 50
    Align = alTop
    BevelOuter = bvNone
    Caption = 'CAIXA LIVRE'
    Color = clSilver
    Font.Charset = ANSI_CHARSET
    Font.Color = 3355443
    Font.Height = -30
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
  end
  object pnlCamposVenda: TPanel
    Left = 0
    Top = 50
    Width = 544
    Height = 493
    Align = alLeft
    TabOrder = 1
    object Label1: TLabel
      Left = 19
      Top = 9
      Width = 96
      Height = 32
      Caption = 'C'#243'digo'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label2: TLabel
      Left = 19
      Top = 94
      Width = 131
      Height = 32
      Caption = 'Descri'#231#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label3: TLabel
      Left = 19
      Top = 187
      Width = 151
      Height = 32
      Caption = 'Quantidade'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label4: TLabel
      Left = 208
      Top = 187
      Width = 105
      Height = 32
      Caption = 'Unit'#225'rio'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label6: TLabel
      Left = 216
      Top = 280
      Width = 154
      Height = 32
      Caption = 'Total Venda'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label5: TLabel
      Left = 121
      Top = 22
      Width = 122
      Height = 13
      Caption = '* Utilize c'#243'digo de 1 a 4 *'
    end
    object edtCodigo: TEdit
      Left = 19
      Top = 41
      Width = 170
      Height = 54
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -40
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnExit = edtCodigoExit
    end
    object edtDescricao: TEdit
      Tag = 1
      Left = 19
      Top = 128
      Width = 355
      Height = 54
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -40
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
    object edtQtde: TEdit
      Left = 19
      Top = 224
      Width = 170
      Height = 54
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -40
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnExit = edtQtdeExit
    end
    object edtUnitario: TEdit
      Tag = 1
      Left = 208
      Top = 224
      Width = 170
      Height = 54
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -40
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
    end
    object edtTotal: TEdit
      Tag = 1
      Left = 211
      Top = 320
      Width = 170
      Height = 54
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -40
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 4
    end
  end
  object pnlLog: TPanel
    Left = 544
    Top = 50
    Width = 374
    Height = 493
    Align = alClient
    TabOrder = 2
    object mmLOG: TRichEdit
      Left = 1
      Top = 1
      Width = 372
      Height = 491
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Courier New'
      Font.Pitch = fpFixed
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object pnlRodapePDV: TPanel
    Left = 0
    Top = 543
    Width = 918
    Height = 74
    Align = alBottom
    TabOrder = 3
    inline framePDVRodape1: TframePDVRodape
      Left = 1
      Top = 1
      Width = 916
      Height = 72
      Align = alClient
      Color = clGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBackground = False
      ParentColor = False
      ParentFont = False
      TabOrder = 0
      inherited btnIniciaVenda: TSpeedButton
        OnClick = btnIniciaVendaClick
      end
      inherited btnFinalizaVenda: TSpeedButton
        Left = 120
        Top = 5
        OnClick = btnFinalizaVendaClick
      end
      inherited btnSairPDV: TSpeedButton
        Left = 828
        OnClick = btnSairPDVClick
      end
      inherited btnCancelaVenda: TSpeedButton
        OnClick = framePDVRodape1btnCancelaVendaClick
      end
      inherited btnRaioX: TSpeedButton
        OnClick = btnRaioXClick
      end
      inherited btnMenuADM: TSpeedButton
        OnClick = btnMenuADMClick
      end
    end
  end
end
