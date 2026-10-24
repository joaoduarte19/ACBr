object frameMenuEsquerdo: TframeMenuEsquerdo
  Left = 0
  Top = 0
  Width = 305
  Height = 434
  Align = alClient
  Color = 3355443
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  ParentBackground = False
  ParentColor = False
  ParentFont = False
  TabOrder = 0
  DesignSize = (
    305
    434)
  object btnPDV: TSpeedButton
    Left = 8
    Top = 14
    Width = 289
    Height = 42
    Anchors = [akLeft, akTop, akRight]
    Caption = 'PDV'
  end
  object btnCfgNFCe: TSpeedButton
    Left = 8
    Top = 58
    Width = 289
    Height = 42
    Anchors = [akLeft, akTop, akRight]
    Caption = 'CONFIG. NFE'
    OnClick = btnCfgNFCeClick
  end
  object btnConfTEF: TSpeedButton
    Left = 8
    Top = 106
    Width = 289
    Height = 42
    Anchors = [akLeft, akTop, akRight]
    Caption = 'CONFIG. TEF'
  end
  object btnCfgPIX: TSpeedButton
    Left = 8
    Top = 154
    Width = 289
    Height = 42
    Anchors = [akLeft, akTop, akRight]
    Caption = 'CONFIG. PIX'
  end
  object cbUsarTEF: TCheckBox
    Left = 8
    Top = 330
    Width = 289
    Height = 17
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Usar TEF (03, 04, 17)'
    TabOrder = 0
    OnClick = cbUsarTEFClick
  end
  object cbUsarPIXCD: TCheckBox
    Left = 8
    Top = 352
    Width = 289
    Height = 17
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Usar PIX CD (17)'
    TabOrder = 1
    OnClick = cbUsarPIXCDClick
  end
  object btnSAIR: TSpeedButton
    Left = 8
    Top = 378
    Width = 289
    Height = 42
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'SAIR'
    OnClick = btnSAIRClick
  end
end
