object frmSelecionarCertificado: TfrmSelecionarCertificado
  Left = 284
  Height = 229
  Top = 183
  Width = 656
  ActiveControl = StringGrid1
  Caption = 'Selecionar Certificado'
  ClientHeight = 229
  ClientWidth = 656
  Color = clBtnFace
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object StringGrid1: TStringGrid
    Left = 0
    Height = 184
    Top = 0
    Width = 656
    Align = alClient
    FixedCols = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goColSizing]
    RowCount = 2
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Height = 45
    Top = 184
    Width = 656
    Align = alBottom
    ParentBackground = False
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 434
      Height = 30
      Top = 5
      Width = 88
      Anchors = [akTop, akRight]
      Cancel = True
      ModalResult = 2
      NumGlyphs = 2
      TabOrder = 0
    end
    object BitBtn2: TBitBtn
      Left = 546
      Height = 30
      Top = 5
      Width = 88
      Anchors = [akTop, akRight]
      Default = True
      ModalResult = 1
      NumGlyphs = 2
      TabOrder = 1
    end
  end
end
