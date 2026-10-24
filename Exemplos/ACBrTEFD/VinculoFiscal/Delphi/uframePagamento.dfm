object framePagamento: TframePagamento
  Left = 0
  Top = 0
  Width = 917
  Height = 480
  Align = alClient
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  OnResize = FrameResize
  object pnlTotais: TPanel
    Left = 0
    Top = 0
    Width = 917
    Height = 64
    Align = alTop
    BevelOuter = bvNone
    Color = clSilver
    ParentBackground = False
    TabOrder = 0
    object lblTotalTit: TLabel
      Left = 12
      Top = 6
      Width = 77
      Height = 15
      Caption = 'Total da venda'
    end
    object lblTotal: TLabel
      Left = 12
      Top = 26
      Width = 66
      Height = 25
      Caption = 'R$ 0,00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblPagoTit: TLabel
      Left = 230
      Top = 6
      Width = 56
      Height = 15
      Caption = 'Total pago'
    end
    object lblPago: TLabel
      Left = 230
      Top = 26
      Width = 66
      Height = 25
      Caption = 'R$ 0,00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblRestanteTit: TLabel
      Left = 448
      Top = 6
      Width = 45
      Height = 15
      Caption = 'Restante'
    end
    object lblRestante: TLabel
      Left = 448
      Top = 26
      Width = 66
      Height = 25
      Caption = 'R$ 0,00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object pnlTEF: TPanel
    Left = 597
    Top = 64
    Width = 320
    Height = 416
    Align = alRight
    Visible = False
    BevelOuter = bvNone
    TabOrder = 1
    object gbQRCode: TGroupBox
      Left = 0
      Top = 0
      Width = 320
      Height = 416
      Align = alClient
      Caption = ' QR Code - leia com o app do banco '
      TabOrder = 0
      Visible = False
      object imgQRCode: TImage
        Left = 27
        Top = 77
        Width = 256
        Height = 256
        Stretch = True
      end
    end
  end
  object pnpPrincipal: TPanel
    Left = 0
    Top = 64
    Width = 597
    Height = 416
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object lblStatusTEF: TLabel
      Left = 8
      Top = 283
      Width = 19
      Height = 15
      Anchors = [akLeft, akBottom]
      Caption = 'TEF'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object sgPagamentos: TStringGrid
      Left = 8
      Top = 77
      Width = 574
      Height = 165
      Anchors = [akLeft, akTop, akRight, akBottom]
      ColCount = 7
      DefaultColWidth = 30
      DefaultRowHeight = 20
      FixedCols = 0
      RowCount = 1
      FixedRows = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
      TabOrder = 0
    end
    object btnRemover: TButton
      Left = 8
      Top = 247
      Width = 110
      Height = 30
      Anchors = [akLeft, akBottom]
      Caption = 'Remover'
      TabOrder = 1
      OnClick = btnRemoverClick
    end
    object btnConfirmar: TButton
      Left = 356
      Top = 247
      Width = 110
      Height = 30
      Anchors = [akRight, akBottom]
      Caption = 'Confirmar'
      TabOrder = 2
      OnClick = btnConfirmarClick
    end
    object btnCancelar: TButton
      Left = 472
      Top = 247
      Width = 110
      Height = 30
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = 'Cancelar'
      TabOrder = 3
      OnClick = btnCancelarClick
    end
    object gbForma: TGroupBox
      Left = 8
      Top = 5
      Width = 574
      Height = 64
      Anchors = [akLeft, akTop, akRight]
      Caption = ' Forma de pagamento '
      TabOrder = 4
      object lblForma: TLabel
        Left = 12
        Top = 18
        Width = 34
        Height = 15
        Caption = 'Forma'
      end
      object lblValor: TLabel
        Left = 284
        Top = 18
        Width = 50
        Height = 15
        Caption = 'Valor (R$)'
      end
      object cbxForma: TComboBox
        Left = 12
        Top = 34
        Width = 260
        Height = 23
        Style = csDropDownList
        TabOrder = 0
      end
      object edtValor: TEdit
        Left = 284
        Top = 34
        Width = 130
        Height = 23
        TabOrder = 1
        OnKeyPress = edtValorKeyPress
      end
      object btnAdicionar: TButton
        Left = 428
        Top = 32
        Width = 110
        Height = 27
        Caption = 'Adicionar'
        TabOrder = 2
        OnClick = btnAdicionarClick
      end
    end
    object gbLog: TGroupBox
      Left = 0
      Top = 304
      Width = 597
      Height = 112
      Align = alBottom
      Caption = ' Log TEF / PIX '
      TabOrder = 5
      object mLog: TMemo
        Left = 2
        Top = 17
        Width = 593
        Height = 93
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Consolas'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssBoth
        TabOrder = 0
        WordWrap = False
      end
    end
  end
end
