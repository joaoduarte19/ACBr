object frameConfigPIX: TframeConfigPIX
  Left = 0
  Top = 0
  Width = 1000
  Height = 790
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object pnpRodape: TPanel
    Left = 0
    Top = 728
    Width = 1000
    Height = 62
    Align = alBottom
    TabOrder = 3
    inline frameRodape1: TframeRodape
      Left = 1
      Top = 1
      Width = 998
      Height = 60
      Align = alClient
      Color = 3355443
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentBackground = False
      ParentColor = False
      ParentFont = False
      TabOrder = 0
      inherited btnSalvar: TSpeedButton
        Left = 853
        OnClick = btnSalvarClick
      end
      inherited lblTexto: TLabel
        Width = 260
        Caption = 'Configura'#231#245'es PIX (ACBrPIXCD)'
      end
    end
  end
  object pnlLog: TPanel
    Left = 0
    Top = 638
    Width = 1000
    Height = 90
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 4
    object mLog: TMemo
      Left = 0
      Top = 0
      Width = 1000
      Height = 90
      Align = alClient
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object gbUsoPDV: TGroupBox
    Left = 0
    Top = 0
    Width = 1000
    Height = 64
    Align = alTop
    Caption = ' Uso no PDV - v'#237'nculo do PIX com a NFC-e '
    TabOrder = 2
    object cbPIXHabilitado: TCheckBox
      Left = 12
      Top = 30
      Width = 330
      Height = 17
      Caption = 'Usar PIX Din'#226'mico via PSP (ACBrPIXCD) no PDV'
      TabOrder = 0
    end
  end
  object pBotoesConfiguracao: TPanel
    Left = 0
    Top = 601
    Width = 1000
    Height = 37
    Align = alBottom
    TabOrder = 1
    object btSalvarParametros: TBitBtn
      Left = 16
      Top = 4
      Width = 136
      Height = 28
      Caption = 'Salvar Par'#226'metros'
      TabOrder = 0
      OnClick = btSalvarParametrosClick
    end
    object btLerParametros: TBitBtn
      Left = 176
      Top = 4
      Width = 136
      Height = 28
      Caption = 'Ler Par'#226'metros'
      TabOrder = 1
      OnClick = btLerParametrosClick
    end
  end
  object pgConfPixPSP: TPageControl
    Left = 0
    Top = 64
    Width = 1000
    Height = 537
    ActivePage = tsPIX
    Align = alClient
    Images = ImageList1
    TabHeight = 25
    TabOrder = 0
    TabWidth = 200
    object tsPIX: TTabSheet
      Caption = 'PIX'
      DesignSize = (
        992
        502)
      object pConfPIX: TPanel
        Left = 208
        Top = 34
        Width = 592
        Height = 440
        Anchors = []
        BevelOuter = bvSpace
        TabOrder = 0
        object gbRecebedor: TGroupBox
          Left = 16
          Top = 16
          Width = 560
          Height = 120
          Caption = 'Recebedor'
          TabOrder = 0
          object pnRecebedor: TPanel
            Left = 2
            Top = 15
            Width = 556
            Height = 103
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 0
            DesignSize = (
              556
              103)
            object imgErrCEP: TImage
              Left = 532
              Top = 19
              Width = 16
              Height = 16
              Anchors = [akTop, akRight]
              Visible = False
            end
            object Label14: TLabel
              Left = 8
              Top = 0
              Width = 28
              Height = 13
              Caption = 'Nome'
              Color = clBtnFace
              ParentColor = False
            end
            object Label16: TLabel
              Left = 8
              Top = 48
              Width = 33
              Height = 13
              Caption = 'Cidade'
              Color = clBtnFace
              ParentColor = False
            end
            object Label18: TLabel
              Left = 416
              Top = 0
              Width = 21
              Height = 13
              Anchors = [akTop, akRight]
              Caption = 'CEP'
              Color = clBtnFace
              ParentColor = False
            end
            object sbConsultaCEP: TSpeedButton
              Left = 529
              Top = 16
              Width = 24
              Height = 23
              Anchors = [akTop, akRight]
              Flat = True
              Visible = False
              OnClick = sbConsultaCEPClick
            end
            object imgErrNome: TImage
              Left = 394
              Top = 19
              Width = 16
              Height = 16
              Anchors = [akTop, akRight]
              Visible = False
            end
            object Label42: TLabel
              Left = 416
              Top = 48
              Width = 14
              Height = 13
              Caption = 'UF'
              Color = clBtnFace
              ParentColor = False
            end
            object edtRecebedorNome: TEdit
              Left = 8
              Top = 16
              Width = 384
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 0
              OnChange = edtRecebedorNomeChange
            end
            object edtRecebedorCidade: TEdit
              Left = 8
              Top = 64
              Width = 384
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 2
            end
            object edtRecebedorCEP: TEdit
              Left = 416
              Top = 16
              Width = 113
              Height = 21
              Anchors = [akTop, akRight]
              TabOrder = 1
              OnChange = edtRecebedorCEPChange
              OnExit = edtRecebedorCEPExit
              OnKeyPress = edOnlyNumbersKeyPress
            end
            object cbxRecebedorUF: TComboBox
              Left = 416
              Top = 64
              Width = 113
              Height = 21
              Style = csDropDownList
              TabOrder = 3
              OnChange = cbxPSPAtualChange
            end
          end
        end
        object gbProxy: TGroupBox
          Left = 16
          Top = 304
          Width = 280
          Height = 108
          Caption = 'Proxy'
          TabOrder = 2
          object pnProxy: TPanel
            Left = 2
            Top = 15
            Width = 276
            Height = 91
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 0
            DesignSize = (
              276
              91)
            object Label8: TLabel
              Left = 8
              Top = 0
              Width = 22
              Height = 13
              Caption = 'Host'
              Color = clBtnFace
              ParentColor = False
            end
            object Label9: TLabel
              Left = 168
              Top = 0
              Width = 25
              Height = 13
              Anchors = [akTop, akRight]
              Caption = 'Porta'
              Color = clBtnFace
              ParentColor = False
            end
            object Label10: TLabel
              Left = 8
              Top = 42
              Width = 36
              Height = 13
              Caption = 'Usu'#225'rio'
              Color = clBtnFace
              ParentColor = False
            end
            object Label36: TLabel
              Left = 168
              Top = 40
              Width = 31
              Height = 13
              Anchors = [akTop, akRight]
              Caption = 'Senha'
              Color = clBtnFace
              ParentColor = False
            end
            object sbVerSenhaProxy: TSpeedButton
              Left = 244
              Top = 58
              Width = 23
              Height = 23
              AllowAllUp = True
              Anchors = [akTop, akRight]
              GroupIndex = 1
              Flat = True
              OnClick = sbVerSenhaProxyClick
            end
            object edtProxyHost: TEdit
              Left = 8
              Top = 16
              Width = 146
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 0
            end
            object edtProxyUser: TEdit
              Left = 8
              Top = 58
              Width = 146
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 1
            end
            object edtProxySenha: TEdit
              Left = 168
              Top = 58
              Width = 74
              Height = 21
              Anchors = [akTop, akRight]
              PasswordChar = '*'
              TabOrder = 2
            end
            object seProxyPorta: TSpinEdit
              Left = 168
              Top = 16
              Width = 74
              Height = 22
              Anchors = [akTop, akRight]
              MaxValue = 999999
              MinValue = 0
              TabOrder = 3
              Value = 0
            end
          end
        end
        object gbLog: TGroupBox
          Left = 320
          Top = 304
          Width = 256
          Height = 108
          Caption = 'Log'
          TabOrder = 3
          object pnLog: TPanel
            Left = 2
            Top = 15
            Width = 252
            Height = 91
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 0
            DesignSize = (
              252
              91)
            object Label11: TLabel
              Left = 8
              Top = 0
              Width = 36
              Height = 13
              Caption = 'Arquivo'
              Color = clBtnFace
              ParentColor = False
            end
            object Label12: TLabel
              Left = 8
              Top = 42
              Width = 26
              Height = 13
              Caption = 'N'#237'vel'
              Color = clBtnFace
              ParentColor = False
            end
            object sbArqLog: TSpeedButton
              Left = 225
              Top = 16
              Width = 24
              Height = 23
              Hint = 'Abrir Arquivo de Log'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              OnClick = sbArqLogClick
            end
            object edtArqLog: TEdit
              Left = 8
              Top = 16
              Width = 217
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 0
            end
            object cbxNivelLog: TComboBox
              Left = 8
              Top = 61
              Width = 217
              Height = 21
              Style = csDropDownList
              ItemIndex = 2
              TabOrder = 1
              Text = 'Normal'
              Items.Strings = (
                'Nenhum'
                'Baixo'
                'Normal'
                'Alto'
                'Muito Alto')
            end
          end
        end
        object gbPSP: TGroupBox
          Left = 16
          Top = 144
          Width = 560
          Height = 72
          Caption = 'PSP'
          TabOrder = 1
          object pnPSP: TPanel
            Left = 2
            Top = 15
            Width = 556
            Height = 55
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 0
            DesignSize = (
              556
              55)
            object Label13: TLabel
              Left = 8
              Top = 3
              Width = 48
              Height = 13
              Caption = 'PSP Atual'
              Color = clBtnFace
              ParentColor = False
            end
            object Label15: TLabel
              Left = 224
              Top = 3
              Width = 44
              Height = 13
              Caption = 'Ambiente'
              Color = clBtnFace
              ParentColor = False
            end
            object Label17: TLabel
              Left = 416
              Top = 3
              Width = 38
              Height = 13
              Caption = 'Timeout'
              Color = clBtnFace
              ParentColor = False
            end
            object imgErrPSP: TImage
              Left = 192
              Top = 23
              Width = 16
              Height = 16
              Anchors = [akTop, akRight]
              Visible = False
            end
            object cbxPSPAtual: TComboBox
              Left = 8
              Top = 19
              Width = 182
              Height = 21
              Style = csDropDownList
              TabOrder = 0
              OnChange = cbxPSPAtualChange
            end
            object cbxAmbiente: TComboBox
              Left = 224
              Top = 19
              Width = 170
              Height = 21
              Style = csDropDownList
              TabOrder = 1
              OnChange = cbxAmbienteChange
            end
            object seTimeout: TSpinEdit
              Left = 416
              Top = 19
              Width = 113
              Height = 22
              Increment = 10
              MaxValue = 999999
              MinValue = 0
              TabOrder = 2
              Value = 0
            end
          end
        end
        object gbCobranca: TGroupBox
          Left = 16
          Top = 224
          Width = 280
          Height = 72
          Caption = 'Cobran'#231'a'
          TabOrder = 4
          object pnCobranca: TPanel
            Left = 2
            Top = 15
            Width = 276
            Height = 55
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 0
            object Label47: TLabel
              Left = 8
              Top = 3
              Width = 47
              Height = 13
              Caption = 'Expira'#231#227'o'
              Color = clBtnFace
              ParentColor = False
            end
            object seCobrancaExpiracao: TSpinEdit
              Left = 8
              Top = 19
              Width = 234
              Height = 22
              Increment = 10
              MaxValue = 999999
              MinValue = 0
              TabOrder = 0
              Value = 3600
            end
          end
        end
        object gbAutenticacaoManual: TGroupBox
          Left = 320
          Top = 224
          Width = 256
          Height = 72
          TabOrder = 5
          object pnAutenticacaoManual: TPanel
            Left = 2
            Top = 15
            Width = 252
            Height = 55
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 0
            object cbAutenticacaoManual: TCheckBox
              Left = 16
              Top = 16
              Width = 184
              Height = 19
              Caption = 'Controlar Autentica'#231#227'o Manual'
              TabOrder = 0
            end
          end
        end
      end
    end
    object tsPSP: TTabSheet
      Caption = 'PSPs'
      ImageIndex = 3
      object pgPSPs: TPageControl
        Left = 0
        Top = 0
        Width = 992
        Height = 502
        ActivePage = tsShipay
        Align = alClient
        TabOrder = 0
        TabWidth = 100
        object tsShipay: TTabSheet
          Caption = 'Shipay'
          DesignSize = (
            984
            474)
          object pConfPSPBB3: TPanel
            Left = 26
            Top = 117
            Width = 929
            Height = 240
            Anchors = [akLeft, akRight]
            BevelOuter = bvNone
            TabOrder = 0
            DesignSize = (
              929
              240)
            object Label48: TLabel
              Left = 24
              Top = 40
              Width = 40
              Height = 13
              Caption = 'Client ID'
              Color = clBtnFace
              ParentColor = False
            end
            object Label49: TLabel
              Left = 24
              Top = 96
              Width = 52
              Height = 13
              Caption = 'Secret Key'
              Color = clBtnFace
              ParentColor = False
            end
            object Label50: TLabel
              Left = 24
              Top = 152
              Width = 56
              Height = 13
              Caption = 'Access Key'
              Color = clBtnFace
              ParentColor = False
            end
            object edtShipayClientID: TEdit
              Left = 24
              Top = 59
              Width = 881
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 0
            end
            object edtShipaySecretKey: TEdit
              Left = 24
              Top = 115
              Width = 881
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 1
            end
            object edtShipayAccessKey: TEdit
              Left = 24
              Top = 171
              Width = 881
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 2
            end
          end
        end
        object tsBB: TTabSheet
          Caption = 'Banco do Brasil'
          object pgBBConfig: TPageControl
            Left = 8
            Top = 32
            Width = 960
            Height = 426
            ActivePage = tsBBConfigGeral
            TabOrder = 0
            object tsBBConfigGeral: TTabSheet
              Caption = 'Geral'
              object pnBBConfig: TPanel
                Left = 0
                Top = 0
                Width = 952
                Height = 398
                Align = alClient
                Anchors = [akLeft, akRight]
                BevelOuter = bvNone
                TabOrder = 0
                DesignSize = (
                  952
                  398)
                object lbBBChavePIX: TLabel
                  Left = 25
                  Top = 20
                  Width = 51
                  Height = 13
                  Caption = 'Chave PIX'
                  Color = clBtnFace
                  ParentColor = False
                end
                object lbBBTipoChave: TLabel
                  Left = 734
                  Top = 20
                  Width = 55
                  Height = 13
                  Caption = 'Tipo Chave'
                  Color = clBtnFace
                  ParentColor = False
                end
                object lbBBClientID: TLabel
                  Left = 25
                  Top = 70
                  Width = 40
                  Height = 13
                  Caption = 'Client ID'
                  Color = clBtnFace
                  ParentColor = False
                end
                object lbBBClientSecret: TLabel
                  Left = 25
                  Top = 120
                  Width = 60
                  Height = 13
                  Caption = 'Client Secret'
                  Color = clBtnFace
                  ParentColor = False
                end
                object lbBBDevAppKey: TLabel
                  Left = 25
                  Top = 170
                  Width = 125
                  Height = 13
                  Caption = 'Developer Application Key'
                  Color = clBtnFace
                  ParentColor = False
                end
                object imgBBErroChavePIX: TImage
                  Left = 920
                  Top = 39
                  Width = 16
                  Height = 16
                  Visible = False
                end
                object lbBBVersaoAPI: TLabel
                  Left = 734
                  Top = 70
                  Width = 53
                  Height = 13
                  Caption = 'Vers'#227'o API'
                  Color = clBtnFace
                  ParentColor = False
                end
                object edtBBChavePIX: TEdit
                  Left = 25
                  Top = 35
                  Width = 691
                  Height = 21
                  Anchors = [akLeft, akTop, akRight]
                  TabOrder = 2
                  OnChange = edtBBChavePIXChange
                end
                object cbxBBTipoChave: TComboBox
                  Left = 734
                  Top = 35
                  Width = 184
                  Height = 21
                  Style = csDropDownList
                  TabOrder = 1
                  TabStop = False
                end
                object edtBBClientID: TEdit
                  Left = 25
                  Top = 85
                  Width = 691
                  Height = 21
                  Anchors = [akLeft, akTop, akRight]
                  TabOrder = 3
                end
                object edtBBClientSecret: TEdit
                  Left = 25
                  Top = 135
                  Width = 691
                  Height = 21
                  Anchors = [akLeft, akTop, akRight]
                  TabOrder = 4
                end
                object edtBBDevAppKey: TEdit
                  Left = 25
                  Top = 185
                  Width = 692
                  Height = 21
                  TabOrder = 5
                end
                object cbBBVersaoAPI: TComboBox
                  Left = 734
                  Top = 85
                  Width = 184
                  Height = 21
                  Style = csDropDownList
                  TabOrder = 0
                  TabStop = False
                  OnChange = cbBBVersaoAPIChange
                end
                object rgBBTipoCertificado: TRadioGroup
                  Left = 734
                  Top = 120
                  Width = 184
                  Height = 58
                  Caption = 'Tipo Certificado'
                  Columns = 2
                  ItemIndex = 0
                  Items.Strings = (
                    'PFX'
                    'Chave/Certificado')
                  TabOrder = 6
                  OnClick = rgBBTipoCertificadoClick
                end
                object pnBBCertificados: TPanel
                  Left = 0
                  Top = 223
                  Width = 952
                  Height = 175
                  Align = alBottom
                  TabOrder = 7
                  object pcBBCertificados: TPageControl
                    Left = 1
                    Top = 1
                    Width = 950
                    Height = 173
                    ActivePage = tsBBPFX
                    Align = alClient
                    TabOrder = 0
                    Visible = False
                    object tsBBPFX: TTabSheet
                      Caption = 'PFX'
                      object pnBBPFX: TPanel
                        Left = 0
                        Top = 0
                        Width = 942
                        Height = 145
                        Align = alClient
                        BevelOuter = bvNone
                        TabOrder = 0
                        DesignSize = (
                          942
                          145)
                        object imBBErroPFX: TImage
                          Left = 8
                          Top = 35
                          Width = 16
                          Height = 16
                          Visible = False
                        end
                        object lbBBArqPFX: TLabel
                          Left = 24
                          Top = 15
                          Width = 59
                          Height = 13
                          Caption = 'Arquivo PFX'
                          Color = clBtnFace
                          ParentColor = False
                        end
                        object lbBBErroPFX: TLabel
                          Left = 24
                          Top = 56
                          Width = 108
                          Height = 13
                          Caption = 'lbBBErroChavePrivada'
                          Color = clBtnFace
                          ParentColor = False
                        end
                        object sbBBAcharPFX: TSpeedButton
                          Left = 683
                          Top = 32
                          Width = 24
                          Height = 23
                          Anchors = [akTop, akRight]
                          Flat = True
                          Font.Charset = DEFAULT_CHARSET
                          Font.Color = clWindowText
                          Font.Height = -11
                          Font.Name = 'MS Sans Serif'
                          Font.Style = []
                          ParentFont = False
                          ParentShowHint = False
                          ShowHint = True
                          OnClick = sbBBAcharPFXClick
                        end
                        object lbBBSenhaPFX: TLabel
                          Left = 728
                          Top = 16
                          Width = 84
                          Height = 13
                          Caption = 'Senha Certificado'
                          Color = clBtnFace
                          ParentColor = False
                        end
                        object btBBVerSenhaPFX: TSpeedButton
                          Left = 903
                          Top = 32
                          Width = 23
                          Height = 23
                          AllowAllUp = True
                          Anchors = [akTop, akRight]
                          GroupIndex = 1
                          Flat = True
                          OnClick = btBBVerSenhaPFXClick
                        end
                        object edBBArqPFX: TEdit
                          Left = 24
                          Top = 32
                          Width = 658
                          Height = 23
                          Anchors = [akLeft, akTop, akRight]
                          AutoSize = False
                          TabOrder = 0
                          OnChange = edBBArqPFXChange
                          OnExit = edBBArqPFXExit
                        end
                        object edBBSenhaPFX: TEdit
                          Left = 728
                          Top = 32
                          Width = 171
                          Height = 21
                          Anchors = [akLeft, akTop, akRight]
                          PasswordChar = '*'
                          TabOrder = 1
                          OnExit = edBBSenhaPFXExit
                        end
                      end
                    end
                    object tsBBChaveECertificado: TTabSheet
                      Caption = 'Chave Privada/Certificado'
                      object pnBBChaveECert: TPanel
                        Left = 0
                        Top = 0
                        Width = 942
                        Height = 145
                        Align = alClient
                        BevelOuter = bvNone
                        TabOrder = 0
                        Visible = False
                        DesignSize = (
                          942
                          145)
                        object imBBErroChavePrivada: TImage
                          Left = 8
                          Top = 35
                          Width = 16
                          Height = 16
                          Visible = False
                        end
                        object lbBBArqChavePrivada: TLabel
                          Left = 24
                          Top = 15
                          Width = 109
                          Height = 13
                          Caption = 'Arquivo Chave Privada'
                          Color = clBtnFace
                          ParentColor = False
                        end
                        object lbBBErroChavePrivada: TLabel
                          Left = 24
                          Top = 56
                          Width = 108
                          Height = 13
                          Caption = 'lbBBErroChavePrivada'
                          Color = clBtnFace
                          ParentColor = False
                        end
                        object sbBBAcharChavePrivada: TSpeedButton
                          Left = 910
                          Top = 32
                          Width = 24
                          Height = 23
                          Anchors = [akTop, akRight]
                          Flat = True
                          Font.Charset = DEFAULT_CHARSET
                          Font.Color = clWindowText
                          Font.Height = -11
                          Font.Name = 'MS Sans Serif'
                          Font.Style = []
                          ParentFont = False
                          ParentShowHint = False
                          ShowHint = True
                          OnClick = sbBBAcharChavePrivadaClick
                        end
                        object sbBBAcharArqCertificado: TSpeedButton
                          Left = 910
                          Top = 96
                          Width = 24
                          Height = 23
                          Anchors = [akTop, akRight]
                          Flat = True
                          Font.Charset = DEFAULT_CHARSET
                          Font.Color = clWindowText
                          Font.Height = -11
                          Font.Name = 'MS Sans Serif'
                          Font.Style = []
                          ParentFont = False
                          ParentShowHint = False
                          ShowHint = True
                          OnClick = sbBBAcharArqCertificadoClick
                        end
                        object lbBBArqCertificado: TLabel
                          Left = 24
                          Top = 80
                          Width = 89
                          Height = 13
                          Caption = 'Arquivo Certificado'
                          Color = clBtnFace
                          ParentColor = False
                        end
                        object imBBErroCertificado: TImage
                          Left = 8
                          Top = 98
                          Width = 16
                          Height = 16
                          Visible = False
                        end
                        object lbBBErroCertificado: TLabel
                          Left = 24
                          Top = 118
                          Width = 91
                          Height = 13
                          Caption = 'lbBBErroCertificado'
                          Color = clBtnFace
                          ParentColor = False
                        end
                        object edBBArqChavePrivada: TEdit
                          Left = 24
                          Top = 32
                          Width = 884
                          Height = 23
                          Anchors = [akLeft, akTop, akRight]
                          AutoSize = False
                          TabOrder = 0
                          OnChange = edBBArqsChange
                          OnExit = edBBArqChavePrivadaExit
                        end
                        object edBBArqCertificado: TEdit
                          Left = 24
                          Top = 96
                          Width = 884
                          Height = 23
                          Anchors = [akLeft, akTop, akRight]
                          AutoSize = False
                          TabOrder = 1
                          OnChange = edBBArqsChange
                          OnExit = edBBArqCertificadoExit
                        end
                      end
                    end
                  end
                end
              end
            end
            object tsBBConfigTokenManual: TTabSheet
              Caption = 'Token Manual'
              object pnBBConfigTokenManual: TPanel
                Left = 0
                Top = 0
                Width = 952
                Height = 398
                Align = alClient
                BevelOuter = bvNone
                TabOrder = 0
                object gbBBConfigTokenManual: TGroupBox
                  Left = 25
                  Top = 25
                  Width = 899
                  Height = 144
                  TabOrder = 0
                  object pnBBConfigTokenManualGerar: TPanel
                    Left = 2
                    Top = 15
                    Width = 895
                    Height = 127
                    Align = alClient
                    BevelOuter = bvNone
                    Enabled = False
                    TabOrder = 0
                    object lbBBConfigTokenValidade: TLabel
                      Left = 32
                      Top = 64
                      Width = 41
                      Height = 13
                      Caption = 'Validade'
                    end
                    object lbBBConfigTokenManual: TLabel
                      Left = 200
                      Top = 8
                      Width = 31
                      Height = 13
                      Caption = 'Token'
                    end
                    object mmBBConfigTokenManual: TMemo
                      Left = 200
                      Top = 23
                      Width = 665
                      Height = 79
                      Lines.Strings = (
                        ''
                        '')
                      TabOrder = 0
                    end
                    object edBBConfigTokenValidade: TDateTimePicker
                      Left = 32
                      Top = 79
                      Width = 145
                      Height = 21
                      Date = 45993.000000000000000000
                      Time = 45993.000000000000000000
                      MaxDate = 2958465.999988426000000000
                      MinDate = -53780.000000000000000000
                      TabOrder = 1
                    end
                    object btBBConfigTokenManualGerar: TButton
                      Left = 32
                      Top = 23
                      Width = 145
                      Height = 25
                      Caption = 'Gerar Novo Token'
                      TabOrder = 2
                      OnClick = btBBConfigTokenManualGerarClick
                    end
                  end
                  object cbBBConfigTokenManual: TCheckBox
                    Left = 8
                    Top = -20
                    Width = 133
                    Height = 19
                    Caption = 'Utilizar Token Manual'
                    TabOrder = 1
                    OnClick = cbBBConfigTokenManualClick
                  end
                end
              end
            end
          end
        end
        object tsItau: TTabSheet
          Caption = 'Ita'#250
          DesignSize = (
            984
            474)
          object pgPSPItau: TPageControl
            Left = 16
            Top = 24
            Width = 947
            Height = 444
            ActivePage = tsItauChave
            Anchors = [akLeft, akTop, akRight, akBottom]
            Images = ImageList1
            TabOrder = 0
            object tsItauChave: TTabSheet
              Caption = 'Chave e Client ID'
              DesignSize = (
                939
                415)
              object pConfPSPBB1: TPanel
                Left = 0
                Top = 82
                Width = 929
                Height = 206
                Anchors = [akLeft, akRight]
                BevelOuter = bvNone
                TabOrder = 0
                DesignSize = (
                  929
                  206)
                object Label25: TLabel
                  Left = 48
                  Top = 21
                  Width = 51
                  Height = 13
                  Caption = 'Chave PIX'
                  Color = clBtnFace
                  ParentColor = False
                end
                object Label26: TLabel
                  Left = 747
                  Top = 21
                  Width = 55
                  Height = 13
                  Anchors = [akTop, akRight]
                  Caption = 'Tipo Chave'
                  Color = clBtnFace
                  ParentColor = False
                end
                object Label27: TLabel
                  Left = 48
                  Top = 72
                  Width = 40
                  Height = 13
                  Caption = 'Client ID'
                  Color = clBtnFace
                  ParentColor = False
                end
                object Label28: TLabel
                  Left = 48
                  Top = 128
                  Width = 60
                  Height = 13
                  Caption = 'Client Secret'
                  Color = clBtnFace
                  ParentColor = False
                end
                object imgItauErroChavePIX: TImage
                  Left = 29
                  Top = 44
                  Width = 16
                  Height = 16
                  Visible = False
                end
                object imgItauErroClientID: TImage
                  Left = 29
                  Top = 95
                  Width = 16
                  Height = 16
                  Visible = False
                end
                object imgItauErroClientSecret: TImage
                  Left = 29
                  Top = 151
                  Width = 16
                  Height = 16
                  Visible = False
                end
                object edtItauChavePIX: TEdit
                  Left = 48
                  Top = 40
                  Width = 692
                  Height = 21
                  Anchors = [akLeft, akTop, akRight]
                  TabOrder = 1
                  OnChange = edtItauChavePIXChange
                end
                object cbxItauTipoChave: TComboBox
                  Left = 747
                  Top = 40
                  Width = 158
                  Height = 21
                  Style = csDropDownList
                  Anchors = [akTop, akRight]
                  TabOrder = 0
                  TabStop = False
                end
                object edtItauClientID: TEdit
                  Left = 48
                  Top = 91
                  Width = 857
                  Height = 21
                  Anchors = [akLeft, akTop, akRight]
                  TabOrder = 2
                  OnChange = edtItauClientIDChange
                end
                object edtItauClientSecret: TEdit
                  Left = 48
                  Top = 147
                  Width = 857
                  Height = 21
                  Anchors = [akLeft, akTop, akRight]
                  TabOrder = 3
                  OnChange = edtItauClientSecretChange
                end
              end
            end
            object tsItauCertificado: TTabSheet
              Caption = 'Chave  e Certificado'
              DesignSize = (
                939
                415)
              object pgPSPItauChaveCertificado: TPageControl
                Left = 19
                Top = 24
                Width = 901
                Height = 372
                ActivePage = tsItauChaveCertificadoArquivos
                Anchors = [akLeft, akTop, akRight, akBottom]
                TabOrder = 0
                OnChange = pgPSPItauChaveCertificadoChange
                object tsItauChaveCertificadoArquivos: TTabSheet
                  Caption = 'Arquivos'
                  DesignSize = (
                    893
                    344)
                  object lItauAvisoChaveCertificadoDesabilitado: TLabel
                    Left = 35
                    Top = 16
                    Width = 172
                    Height = 13
                    Caption = 'Desabilitado em Homologa'#231#227'o'
                    Color = clBtnFace
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = [fsBold]
                    ParentColor = False
                    ParentFont = False
                    Visible = False
                  end
                  object Panel7: TPanel
                    Left = 35
                    Top = 76
                    Width = 802
                    Height = 186
                    Anchors = [akLeft, akRight]
                    BevelOuter = bvNone
                    TabOrder = 0
                    DesignSize = (
                      802
                      186)
                    object Label41: TLabel
                      Left = 90
                      Top = 56
                      Width = 109
                      Height = 13
                      Caption = 'Arquivo Chave Privada'
                      Color = clBtnFace
                      ParentColor = False
                    end
                    object imgItauErroChavePrivada: TImage
                      Left = 72
                      Top = 76
                      Width = 16
                      Height = 16
                      Visible = False
                    end
                    object lItauErroChavePrivada: TLabel
                      Left = 90
                      Top = 96
                      Width = 106
                      Height = 13
                      Caption = 'lItauErroChavePrivada'
                      Color = clBtnFace
                      ParentColor = False
                    end
                    object sbItauAcharArqChavePrivada: TSpeedButton
                      Left = 728
                      Top = 72
                      Width = 24
                      Height = 23
                      Hint = 'Abrir Arquivo de Log'
                      Anchors = [akTop, akRight]
                      Font.Charset = DEFAULT_CHARSET
                      Font.Color = clWindowText
                      Font.Height = -11
                      Font.Name = 'MS Sans Serif'
                      Font.Style = []
                      ParentFont = False
                      ParentShowHint = False
                      ShowHint = True
                      OnClick = sbItauAcharArqChavePrivadaClick
                    end
                    object Label40: TLabel
                      Left = 90
                      Top = 130
                      Width = 89
                      Height = 13
                      Caption = 'Arquivo Certificado'
                      Color = clBtnFace
                      ParentColor = False
                    end
                    object imgItauErroCertificado: TImage
                      Left = 72
                      Top = 154
                      Width = 16
                      Height = 16
                      Visible = False
                    end
                    object lItauErroCertificado: TLabel
                      Left = 90
                      Top = 172
                      Width = 89
                      Height = 13
                      Caption = 'lErroItauCertificado'
                      Color = clBtnFace
                      ParentColor = False
                    end
                    object sbItauAcharArqCertificado: TSpeedButton
                      Left = 728
                      Top = 147
                      Width = 24
                      Height = 23
                      Hint = 'Abrir Arquivo de Log'
                      Anchors = [akTop, akRight]
                      Font.Charset = DEFAULT_CHARSET
                      Font.Color = clWindowText
                      Font.Height = -11
                      Font.Name = 'MS Sans Serif'
                      Font.Style = []
                      ParentFont = False
                      ParentShowHint = False
                      ShowHint = True
                      OnClick = sbItauAcharArqCertificadoClick
                    end
                    object edtItauArqChavePrivada: TEdit
                      Left = 90
                      Top = 72
                      Width = 638
                      Height = 23
                      Anchors = [akLeft, akTop, akRight]
                      AutoSize = False
                      TabOrder = 0
                      Text = 'ItauChavePrivada.pem'
                      OnChange = edtItauArqChavePrivadaChange
                    end
                    object edtItauArqCertificado: TEdit
                      Left = 90
                      Top = 147
                      Width = 638
                      Height = 23
                      Anchors = [akLeft, akTop, akRight]
                      AutoSize = False
                      TabOrder = 1
                      Text = 'ItauCertificado.pem'
                      OnChange = edtItauArqChavePrivadaChange
                    end
                    object btItauValidarChaveCertificado: TBitBtn
                      Left = 541
                      Top = 16
                      Width = 187
                      Height = 26
                      Anchors = [akTop, akRight]
                      Caption = 'Validar Chave e Certificado'
                      TabOrder = 2
                      Visible = False
                      OnClick = btItauValidarChaveCertificadoClick
                    end
                  end
                end
                object tsItauGerarChaveCertificado: TTabSheet
                  Caption = 'Gerar Chave e Certificado'
                  DesignSize = (
                    893
                    344)
                  object pgPSPItauGerarChaveCertificado: TPageControl
                    Left = 16
                    Top = 16
                    Width = 844
                    Height = 324
                    ActivePage = tsItauCertPasso1
                    Anchors = [akLeft, akTop, akRight, akBottom]
                    TabOrder = 0
                    object tsItauCertPasso1: TTabSheet
                      Caption = 'Passo 1 - Definir Chave Privada'
                      DesignSize = (
                        836
                        296)
                      object Label39: TLabel
                        Left = 16
                        Top = 24
                        Width = 109
                        Height = 13
                        Caption = 'Arquivo Chave Privada'
                        Color = clBtnFace
                        ParentColor = False
                      end
                      object edtItauArqChavePrivada2: TEdit
                        Left = 16
                        Top = 40
                        Width = 628
                        Height = 21
                        TabStop = False
                        Anchors = [akLeft, akTop, akRight]
                        ReadOnly = True
                        TabOrder = 0
                        Text = 'ItauChavePrivada.pem'
                      end
                      object btItauGerarChavePrivada: TBitBtn
                        Left = 660
                        Top = 37
                        Width = 152
                        Height = 26
                        Anchors = [akTop, akRight]
                        Caption = 'Gerar Chave Privada'
                        TabOrder = 1
                        OnClick = btItauGerarChavePrivadaClick
                      end
                      object mItauChavePrivadaPEM: TMemo
                        Left = 16
                        Top = 72
                        Width = 796
                        Height = 207
                        Anchors = [akLeft, akTop, akRight, akBottom]
                        Font.Charset = DEFAULT_CHARSET
                        Font.Color = clWindowText
                        Font.Height = -11
                        Font.Name = 'Lucida Console'
                        Font.Style = []
                        ParentFont = False
                        ReadOnly = True
                        ScrollBars = ssBoth
                        TabOrder = 2
                        WantReturns = False
                        WordWrap = False
                      end
                    end
                    object tsItauCertPasso3: TTabSheet
                      Caption = 'Passo 2 - Solicitar Certificado'
                      object pItauEditCertificado: TPanel
                        Left = 0
                        Top = 0
                        Width = 836
                        Height = 56
                        Align = alTop
                        BevelOuter = bvNone
                        TabOrder = 0
                        DesignSize = (
                          836
                          56)
                        object Label43: TLabel
                          Left = 16
                          Top = 4
                          Width = 89
                          Height = 13
                          Caption = 'Arquivo Certificado'
                          Color = clBtnFace
                          ParentColor = False
                        end
                        object btItauSolicitarCertificado: TBitBtn
                          Left = 663
                          Top = 18
                          Width = 149
                          Height = 26
                          Anchors = [akTop, akRight]
                          Caption = 'Solicitar Certificado'
                          TabOrder = 0
                          OnClick = btItauSolicitarCertificadoClick
                        end
                        object edtItauArqCertificado2: TEdit
                          Left = 16
                          Top = 21
                          Width = 634
                          Height = 23
                          TabStop = False
                          Anchors = [akLeft, akTop, akRight]
                          AutoSize = False
                          ReadOnly = True
                          TabOrder = 1
                          Text = 'ItauCertificado.pem'
                          OnChange = edtItauArqChavePrivadaChange
                        end
                      end
                      object pItauTokentemporario: TPanel
                        Left = 0
                        Top = 56
                        Width = 836
                        Height = 80
                        Align = alTop
                        BevelOuter = bvNone
                        TabOrder = 1
                        object lTokenTemporario: TLabel
                          Left = 0
                          Top = 0
                          Width = 87
                          Height = 13
                          Align = alTop
                          Caption = 'Token Tempor'#225'rio'
                          Color = clBtnFace
                          ParentColor = False
                        end
                        object mItauTokenTemporario: TMemo
                          Left = 0
                          Top = 13
                          Width = 836
                          Height = 67
                          Align = alClient
                          Font.Charset = DEFAULT_CHARSET
                          Font.Color = clWindowText
                          Font.Height = -11
                          Font.Name = 'Lucida Console'
                          Font.Style = []
                          ParentFont = False
                          ScrollBars = ssBoth
                          TabOrder = 0
                        end
                      end
                      object pItauCertificadoRecebido: TPanel
                        Left = 0
                        Top = 136
                        Width = 836
                        Height = 160
                        Align = alClient
                        BevelOuter = bvNone
                        TabOrder = 2
                        object Label6: TLabel
                          Left = 0
                          Top = 0
                          Width = 99
                          Height = 13
                          Align = alTop
                          Caption = 'Certificado Recebido'
                          Color = clBtnFace
                          ParentColor = False
                        end
                        object mItauCertificadoPEM: TMemo
                          Left = 0
                          Top = 13
                          Width = 836
                          Height = 148
                          Align = alClient
                          Font.Charset = DEFAULT_CHARSET
                          Font.Color = clWindowText
                          Font.Height = -11
                          Font.Name = 'Lucida Console'
                          Font.Style = []
                          ParentFont = False
                          ReadOnly = True
                          ScrollBars = ssBoth
                          TabOrder = 0
                          WantReturns = False
                        end
                      end
                    end
                  end
                end
                object tsItauRenovarChaveCertificado: TTabSheet
                  Caption = 'Renovar Certificado'
                  object pnItauRenovarCertificadoPEM: TPanel
                    Left = 16
                    Top = 56
                    Width = 862
                    Height = 284
                    BevelOuter = bvNone
                    TabOrder = 0
                    object lbItauRenovarCertificadoPEM: TLabel
                      Left = 0
                      Top = 0
                      Width = 128
                      Height = 13
                      Align = alTop
                      Caption = 'Novo Certificado Recebido'
                      Color = clBtnFace
                      ParentColor = False
                    end
                    object mmItauRenovarCertificadoPEM: TMemo
                      Left = 0
                      Top = 13
                      Width = 862
                      Height = 271
                      Align = alClient
                      Font.Charset = DEFAULT_CHARSET
                      Font.Color = clWindowText
                      Font.Height = -11
                      Font.Name = 'Lucida Console'
                      Font.Style = []
                      ParentFont = False
                      ReadOnly = True
                      ScrollBars = ssBoth
                      TabOrder = 0
                      WantReturns = False
                    end
                  end
                  object pItauEditCertificado1: TPanel
                    Left = 0
                    Top = 0
                    Width = 893
                    Height = 56
                    Align = alTop
                    BevelOuter = bvNone
                    TabOrder = 1
                    DesignSize = (
                      893
                      56)
                    object lbItauRenovarCertificadoArq: TLabel
                      Left = 16
                      Top = 4
                      Width = 89
                      Height = 13
                      Caption = 'Arquivo Certificado'
                      Color = clBtnFace
                      ParentColor = False
                    end
                    object edItauRenovarCertificadoArq: TEdit
                      Left = 16
                      Top = 21
                      Width = 700
                      Height = 23
                      TabStop = False
                      Anchors = [akLeft, akTop, akRight]
                      AutoSize = False
                      ReadOnly = True
                      TabOrder = 0
                      Text = 'ItauCertificadoNovo.pem'
                      OnChange = edtItauArqChavePrivadaChange
                    end
                    object btItauRenovarCertificado: TBitBtn
                      Left = 732
                      Top = 18
                      Width = 149
                      Height = 26
                      Anchors = [akTop, akRight]
                      Caption = 'Renovar Certificado'
                      TabOrder = 1
                      OnClick = btItauRenovarCertificadoClick
                    end
                  end
                end
              end
            end
          end
        end
        object tsSantander: TTabSheet
          Caption = 'Santander'
          object pgSantander: TPageControl
            Left = 48
            Top = 56
            Width = 888
            Height = 368
            ActivePage = tsSantanderCredenciais
            TabOrder = 0
            object tsSantanderCredenciais: TTabSheet
              Caption = 'Credenciais'
              object pConfPSPSantander: TPanel
                Left = 0
                Top = 0
                Width = 880
                Height = 340
                Align = alClient
                Anchors = [akLeft, akRight]
                BevelOuter = bvNone
                TabOrder = 0
                DesignSize = (
                  880
                  340)
                object lbSantanderChavePIX: TLabel
                  Left = 24
                  Top = 24
                  Width = 51
                  Height = 13
                  Caption = 'Chave PIX'
                  Color = clBtnFace
                  ParentColor = False
                end
                object lbSantanderTipoChave: TLabel
                  Left = 688
                  Top = 24
                  Width = 55
                  Height = 13
                  Anchors = [akTop, akRight]
                  Caption = 'Tipo Chave'
                  Color = clBtnFace
                  ParentColor = False
                end
                object lbSantanderConsumerKey: TLabel
                  Left = 24
                  Top = 75
                  Width = 68
                  Height = 13
                  Caption = 'Consumer Key'
                  Color = clBtnFace
                  ParentColor = False
                end
                object lbSantanderConsumerSecret: TLabel
                  Left = 24
                  Top = 131
                  Width = 81
                  Height = 13
                  Caption = 'Consumer Secret'
                  Color = clBtnFace
                  ParentColor = False
                end
                object imSantanderErroChavePIX: TImage
                  Left = 856
                  Top = 44
                  Width = 16
                  Height = 16
                  Anchors = [akTop, akRight]
                  Visible = False
                end
                object sbSantanderAcharCertificadoPFX: TSpeedButton
                  Left = 640
                  Top = 197
                  Width = 24
                  Height = 23
                  Anchors = [akTop, akRight]
                  Flat = True
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                  ParentShowHint = False
                  ShowHint = True
                  OnClick = sbSantanderAcharCertificadoPFXClick
                end
                object lbSantanderArqCertificadoPFX: TLabel
                  Left = 24
                  Top = 181
                  Width = 112
                  Height = 13
                  Caption = 'Arquivo Certificado PFX'
                  Color = clBtnFace
                  ParentColor = False
                end
                object lbSantanderErroCertificadoPFX: TLabel
                  Left = 24
                  Top = 222
                  Width = 146
                  Height = 13
                  Caption = 'lbSantanderErroCertificadoPFX'
                  Color = clBtnFace
                  ParentColor = False
                end
                object imSantanderErroCertificadoPFX: TImage
                  Left = 3
                  Top = 200
                  Width = 16
                  Height = 16
                  Visible = False
                end
                object lbSantanderSenhaCertificado: TLabel
                  Left = 688
                  Top = 181
                  Width = 84
                  Height = 13
                  Caption = 'Senha Certificado'
                  Color = clBtnFace
                  ParentColor = False
                end
                object sbSantanderVerSenhaPFX: TSpeedButton
                  Left = 856
                  Top = 197
                  Width = 23
                  Height = 23
                  AllowAllUp = True
                  Anchors = [akTop, akRight]
                  GroupIndex = 1
                  Flat = True
                  OnClick = sbSantanderVerSenhaPFXClick
                end
                object edSantanderChavePIX: TEdit
                  Left = 24
                  Top = 40
                  Width = 640
                  Height = 21
                  Anchors = [akLeft, akTop, akRight]
                  TabOrder = 1
                  OnChange = edSantanderChavePIXChange
                end
                object cbSantanderTipoChave: TComboBox
                  Left = 688
                  Top = 40
                  Width = 164
                  Height = 21
                  Style = csDropDownList
                  Anchors = [akTop, akRight]
                  TabOrder = 0
                  TabStop = False
                end
                object edSantanderConsumerKey: TEdit
                  Left = 24
                  Top = 91
                  Width = 828
                  Height = 21
                  Anchors = [akLeft, akTop, akRight]
                  TabOrder = 2
                end
                object edSantanderConsumerSecret: TEdit
                  Left = 24
                  Top = 147
                  Width = 828
                  Height = 21
                  Anchors = [akLeft, akTop, akRight]
                  TabOrder = 3
                end
                object edSantanderArqCertificadoPFX: TEdit
                  Left = 24
                  Top = 197
                  Width = 616
                  Height = 23
                  Anchors = [akLeft, akTop, akRight]
                  AutoSize = False
                  TabOrder = 4
                  OnChange = edSantanderArqCertificadoPFXChange
                end
                object edSantanderSenhaCertificadoPFX: TEdit
                  Left = 688
                  Top = 197
                  Width = 164
                  Height = 21
                  Anchors = [akLeft, akTop, akRight]
                  PasswordChar = '*'
                  TabOrder = 5
                end
              end
            end
            object tsSantanderExtrairCertificado: TTabSheet
              Caption = 'Extrair Certificado'
              object pnSantanderExtrairCertificado: TPanel
                Left = 0
                Top = 0
                Width = 880
                Height = 340
                Align = alClient
                BevelOuter = bvNone
                TabOrder = 0
                DesignSize = (
                  880
                  340)
                object sbSantanderExtrairCertificadoPFX: TSpeedButton
                  Left = 600
                  Top = 56
                  Width = 24
                  Height = 23
                  Anchors = [akTop, akRight]
                  Flat = True
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                  ParentShowHint = False
                  ShowHint = True
                  OnClick = sbSantanderExtrairCertificadoPFXClick
                end
                object lbSantanderExtrairCertificadoPFX: TLabel
                  Left = 40
                  Top = 40
                  Width = 112
                  Height = 13
                  Caption = 'Arquivo Certificado PFX'
                  Color = clBtnFace
                  ParentColor = False
                end
                object lbSantanderExtrairCertificadoPEM: TLabel
                  Left = 40
                  Top = 160
                  Width = 115
                  Height = 13
                  Caption = 'Arquivo Certificado PEM'
                  Color = clBtnFace
                  ParentColor = False
                end
                object lbSantanderExtrairCertificadoSenhaPFX: TLabel
                  Left = 640
                  Top = 40
                  Width = 84
                  Height = 13
                  Caption = 'Senha Certificado'
                  Color = clBtnFace
                  ParentColor = False
                end
                object sbSantanderExtrairCertificadoVerSenhaPFX: TSpeedButton
                  Left = 808
                  Top = 56
                  Width = 23
                  Height = 23
                  AllowAllUp = True
                  Anchors = [akTop, akRight]
                  GroupIndex = 1
                  Flat = True
                  OnClick = sbSantanderExtrairCertificadoVerSenhaPFXClick
                end
                object sbSantanderExtrairCertificadoInfo: TSpeedButton
                  Left = 224
                  Top = 104
                  Width = 30
                  Height = 30
                  AllowAllUp = True
                  Anchors = [akTop, akRight]
                  GroupIndex = 1
                  Flat = True
                  OnClick = sbSantanderExtrairCertificadoInfoClick
                end
                object edSantanderExtrairCertificadoPFX: TEdit
                  Left = 40
                  Top = 56
                  Width = 560
                  Height = 23
                  Anchors = [akLeft, akTop, akRight]
                  AutoSize = False
                  TabOrder = 0
                end
                object btSantanderExtrairPEM: TBitBtn
                  Left = 40
                  Top = 104
                  Width = 179
                  Height = 30
                  Caption = 'Extrair Certificado PEM'
                  TabOrder = 1
                  OnClick = btSantanderExtrairPEMClick
                end
                object edSantanderExtrairCertificadoPEM: TEdit
                  Left = 40
                  Top = 176
                  Width = 791
                  Height = 23
                  Anchors = [akLeft, akTop, akRight]
                  AutoSize = False
                  TabOrder = 2
                  Text = 'SantanderCertificado.pem'
                end
                object edSantanderExtrairCertificadoSenhaPFX: TEdit
                  Left = 640
                  Top = 56
                  Width = 164
                  Height = 21
                  Anchors = [akLeft, akTop, akRight]
                  PasswordChar = '*'
                  TabOrder = 3
                end
              end
            end
          end
        end
        object tsSicredi: TTabSheet
          Caption = 'Sicredi'
          object pgSicredi: TPageControl
            Left = 48
            Top = 56
            Width = 888
            Height = 368
            ActivePage = tsSicrediCredenciais
            TabOrder = 0
            object tsSicrediCredenciais: TTabSheet
              Caption = 'Credenciais'
              object pnSicrediCredenciais: TPanel
                Left = 0
                Top = 0
                Width = 880
                Height = 340
                Align = alClient
                BevelOuter = bvNone
                TabOrder = 0
                DesignSize = (
                  880
                  340)
                object sbSicrediAcharChavePrivada: TSpeedButton
                  Left = 630
                  Top = 197
                  Width = 24
                  Height = 23
                  Anchors = [akTop, akRight]
                  Flat = True
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                  ParentShowHint = False
                  ShowHint = True
                  OnClick = sbSicrediAcharChavePrivadaClick
                end
                object sbSicrediAcharArqCertificado: TSpeedButton
                  Left = 836
                  Top = 267
                  Width = 24
                  Height = 23
                  Anchors = [akTop, akRight]
                  Flat = True
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                  ParentShowHint = False
                  ShowHint = True
                  OnClick = sbSicrediAcharArqCertificadoClick
                end
                object lbSicrediTipoChave: TLabel
                  Left = 675
                  Top = 24
                  Width = 55
                  Height = 13
                  Anchors = [akTop, akRight]
                  Caption = 'Tipo Chave'
                  Color = clBtnFace
                  ParentColor = False
                end
                object lbSicrediErroChavePrivada: TLabel
                  Left = 24
                  Top = 222
                  Width = 126
                  Height = 13
                  Caption = 'lbSicrediErroChavePrivada'
                  Color = clBtnFace
                  ParentColor = False
                end
                object lbSicrediErroCertificado: TLabel
                  Left = 24
                  Top = 294
                  Width = 109
                  Height = 13
                  Caption = 'lbSicrediErroCertificado'
                  Color = clBtnFace
                  ParentColor = False
                end
                object lbSicrediClientSecret: TLabel
                  Left = 24
                  Top = 132
                  Width = 60
                  Height = 13
                  Caption = 'Client Secret'
                  Color = clBtnFace
                  ParentColor = False
                end
                object lbSicrediClientID: TLabel
                  Left = 24
                  Top = 75
                  Width = 40
                  Height = 13
                  Caption = 'Client ID'
                  Color = clBtnFace
                  ParentColor = False
                end
                object lbSicrediChavePIX: TLabel
                  Left = 24
                  Top = 24
                  Width = 51
                  Height = 13
                  Caption = 'Chave PIX'
                  Color = clBtnFace
                  ParentColor = False
                end
                object lbSicrediArqChavePrivada: TLabel
                  Left = 24
                  Top = 181
                  Width = 109
                  Height = 13
                  Caption = 'Arquivo Chave Privada'
                  Color = clBtnFace
                  ParentColor = False
                end
                object lbSicrediArqCertificado: TLabel
                  Left = 24
                  Top = 251
                  Width = 221
                  Height = 13
                  Caption = 'Arquivo Certificado (GERADO PELO SICREDI)'
                  Color = clBtnFace
                  ParentColor = False
                end
                object imSicrediErroChavePrivada: TImage
                  Left = 3
                  Top = 200
                  Width = 16
                  Height = 16
                  Visible = False
                end
                object imSicrediErroChavePix: TImage
                  Left = 836
                  Top = 44
                  Width = 16
                  Height = 16
                  Anchors = [akTop, akRight]
                  Visible = False
                end
                object imSicrediErroCertificado: TImage
                  Left = 3
                  Top = 271
                  Width = 16
                  Height = 16
                  Visible = False
                end
                object btSicrediSenhaChavePrivada: TSpeedButton
                  Left = 836
                  Top = 197
                  Width = 24
                  Height = 23
                  AllowAllUp = True
                  Anchors = [akTop, akRight]
                  GroupIndex = 1
                  Flat = True
                  OnClick = btSicrediSenhaChavePrivadaClick
                end
                object lbSicrediSenhaChavePrivada: TLabel
                  Left = 674
                  Top = 181
                  Width = 118
                  Height = 13
                  Anchors = [akTop, akRight]
                  Caption = 'Senha (Se criptografada)'
                  Color = clBtnFace
                  ParentColor = False
                end
                object edSicrediClientSecret: TEdit
                  Left = 24
                  Top = 147
                  Width = 808
                  Height = 21
                  Anchors = [akLeft, akTop, akRight]
                  TabOrder = 3
                end
                object edSicrediClientID: TEdit
                  Left = 24
                  Top = 91
                  Width = 808
                  Height = 21
                  Anchors = [akLeft, akTop, akRight]
                  TabOrder = 2
                end
                object edSicrediChavePIX: TEdit
                  Left = 24
                  Top = 40
                  Width = 630
                  Height = 21
                  Anchors = [akLeft, akTop, akRight]
                  TabOrder = 0
                  OnChange = edSicrediChavePIXChange
                end
                object edSicrediArqChavePrivada: TEdit
                  Left = 24
                  Top = 197
                  Width = 602
                  Height = 23
                  Anchors = [akLeft, akTop, akRight]
                  AutoSize = False
                  TabOrder = 4
                  Text = 'SicrediChavePrivada.key'
                  OnChange = edSicrediArqsChange
                  OnExit = edSicrediArqChavePrivadaExit
                end
                object edSicrediArqCertificado: TEdit
                  Left = 24
                  Top = 267
                  Width = 808
                  Height = 23
                  Anchors = [akLeft, akTop, akRight]
                  AutoSize = False
                  TabOrder = 5
                  Text = 'SicrediCertificado.cer'
                  OnChange = edSicrediArqsChange
                  OnExit = edSicrediArqCertificadoExit
                end
                object cbSicrediTipoChave: TComboBox
                  Left = 674
                  Top = 40
                  Width = 158
                  Height = 21
                  Style = csDropDownList
                  Anchors = [akTop, akRight]
                  TabOrder = 1
                  TabStop = False
                end
                object edSicrediSenhaChavePrivada: TEdit
                  Left = 674
                  Top = 197
                  Width = 158
                  Height = 21
                  Anchors = [akTop, akRight]
                  PasswordChar = '*'
                  TabOrder = 6
                end
              end
            end
            object tsSicrediGerarChaveCSR: TTabSheet
              Caption = 'Gerar Chave/CSR'
              ImageIndex = 1
              OnShow = tsSicrediGerarChaveCSRShow
              object pnSicrediGerarChaveCSR: TPanel
                Left = 0
                Top = 0
                Width = 880
                Height = 340
                Align = alClient
                BevelOuter = bvNone
                TabOrder = 0
                DesignSize = (
                  880
                  340)
                object lbSicrediGerarChavePrivada: TLabel
                  Left = 24
                  Top = 21
                  Width = 70
                  Height = 13
                  Caption = 'Chave Privada'
                  Color = clBtnFace
                  ParentColor = False
                end
                object lbSicrediGerarCSR: TLabel
                  Left = 24
                  Top = 181
                  Width = 22
                  Height = 13
                  Caption = 'CSR'
                  Color = clBtnFace
                  ParentColor = False
                end
                object btSicrediGerarChaveInfo: TSpeedButton
                  Left = 112
                  Top = 8
                  Width = 30
                  Height = 30
                  Anchors = [akTop, akRight]
                  Flat = True
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                  ParentShowHint = False
                  ShowHint = True
                  OnClick = btSicrediGerarChaveCertificadoInfoClick
                end
                object btSicrediGerarCSRInfo: TSpeedButton
                  Left = 56
                  Top = 168
                  Width = 30
                  Height = 30
                  Anchors = [akTop, akRight]
                  Flat = True
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                  ParentShowHint = False
                  ShowHint = True
                  OnClick = btSicrediGerarChaveCertificadoInfoClick
                end
                object lbSicrediGerarCSREmail: TLabel
                  Left = 448
                  Top = 181
                  Width = 28
                  Height = 13
                  Caption = 'E-mail'
                  Color = clBtnFace
                  ParentColor = False
                end
                object sbSicrediAcharChavePrivada2: TSpeedButton
                  Left = 672
                  Top = 37
                  Width = 24
                  Height = 23
                  Anchors = [akTop, akRight]
                  Flat = True
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                  ParentShowHint = False
                  ShowHint = True
                  OnClick = sbSicrediAcharChavePrivadaClick
                end
                object edSicrediGerarChavePrivada: TEdit
                  Left = 24
                  Top = 37
                  Width = 648
                  Height = 23
                  Anchors = [akLeft, akTop, akRight]
                  AutoSize = False
                  TabOrder = 0
                  Text = 'SicrediChavePrivada.key'
                end
                object mmSicrediGerarChavePrivada: TMemo
                  Left = 24
                  Top = 72
                  Width = 824
                  Height = 89
                  Anchors = [akLeft, akTop, akRight, akBottom]
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'Lucida Console'
                  Font.Style = []
                  ParentFont = False
                  ReadOnly = True
                  TabOrder = 1
                  WantReturns = False
                  WordWrap = False
                end
                object btSicrediGerarChavePrivada: TBitBtn
                  Left = 712
                  Top = 32
                  Width = 137
                  Height = 33
                  Caption = 'Gerar Chave Privada'
                  TabOrder = 2
                  OnClick = btSicrediGerarChavePrivadaClick
                end
                object edSicrediGerarCSR: TEdit
                  Left = 24
                  Top = 197
                  Width = 408
                  Height = 23
                  Anchors = [akLeft, akTop, akRight]
                  AutoSize = False
                  TabOrder = 3
                  Text = 'SicrediCertificado.csr'
                end
                object mmSicrediGerarCSR: TMemo
                  Left = 24
                  Top = 232
                  Width = 824
                  Height = 89
                  Anchors = [akLeft, akTop, akRight, akBottom]
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'Lucida Console'
                  Font.Style = []
                  ParentFont = False
                  ReadOnly = True
                  TabOrder = 4
                  WantReturns = False
                  WordWrap = False
                end
                object btSicrediGerarCSR: TBitBtn
                  Left = 712
                  Top = 192
                  Width = 137
                  Height = 33
                  Caption = 'Gerar CSR'
                  TabOrder = 5
                  OnClick = btSicrediGerarCSRClick
                end
                object edSicrediGerarCSREmail: TEdit
                  Left = 448
                  Top = 197
                  Width = 248
                  Height = 23
                  Anchors = [akLeft, akTop, akRight]
                  AutoSize = False
                  TabOrder = 6
                end
              end
            end
          end
        end
        object tsSicoob: TTabSheet
          Caption = 'Sicoob'
          object pgSicoob: TPageControl
            Left = 48
            Top = 56
            Width = 888
            Height = 368
            ActivePage = tsSicoobCredenciais
            TabOrder = 0
            object tsSicoobCredenciais: TTabSheet
              Caption = 'Credenciais'
              object pnSicoobCredenciais: TPanel
                Left = 0
                Top = 0
                Width = 880
                Height = 340
                Align = alClient
                BevelOuter = bvNone
                TabOrder = 0
                object pnConfPSPSicoob: TPanel
                  Left = 0
                  Top = 0
                  Width = 880
                  Height = 340
                  Align = alClient
                  BevelOuter = bvNone
                  TabOrder = 0
                  DesignSize = (
                    880
                    340)
                  object lbSicoobChavePix: TLabel
                    Left = 24
                    Top = 24
                    Width = 51
                    Height = 13
                    Caption = 'Chave PIX'
                    Color = clBtnFace
                    ParentColor = False
                  end
                  object lbSicoobTipoChave: TLabel
                    Left = 670
                    Top = 24
                    Width = 55
                    Height = 13
                    Anchors = [akTop, akRight]
                    Caption = 'Tipo Chave'
                    Color = clBtnFace
                    ParentColor = False
                  end
                  object lbSicoobClientID: TLabel
                    Left = 24
                    Top = 83
                    Width = 40
                    Height = 13
                    Caption = 'Client ID'
                    Color = clBtnFace
                    ParentColor = False
                  end
                  object lbSicoobArquivoChavePrivada: TLabel
                    Left = 24
                    Top = 137
                    Width = 109
                    Height = 13
                    Caption = 'Arquivo Chave Privada'
                    Color = clBtnFace
                    ParentColor = False
                  end
                  object imSicoobErroChavePrivada: TImage
                    Left = 3
                    Top = 156
                    Width = 16
                    Height = 16
                    Visible = False
                  end
                  object lbSicoobErroChavePrivada: TLabel
                    Left = 24
                    Top = 178
                    Width = 127
                    Height = 13
                    Caption = 'lbSicoobErroChavePrivada'
                    Color = clBtnFace
                    ParentColor = False
                    Visible = False
                  end
                  object lbSicoobArquivoCertificado: TLabel
                    Left = 24
                    Top = 207
                    Width = 89
                    Height = 13
                    Caption = 'Arquivo Certificado'
                    Color = clBtnFace
                    ParentColor = False
                  end
                  object imSicoobErroCertificado: TImage
                    Left = 3
                    Top = 227
                    Width = 16
                    Height = 16
                    Visible = False
                  end
                  object lbSicoobErroCertificado: TLabel
                    Left = 24
                    Top = 250
                    Width = 110
                    Height = 13
                    Caption = 'lbSicoobErroCertificado'
                    Color = clBtnFace
                    ParentColor = False
                    Visible = False
                  end
                  object imSicoobErroChavePIX: TImage
                    Left = 836
                    Top = 42
                    Width = 16
                    Height = 16
                    Anchors = [akTop, akRight]
                    Visible = False
                  end
                  object sbSicoobAcharChavePrivada: TSpeedButton
                    Left = 836
                    Top = 153
                    Width = 24
                    Height = 23
                    Anchors = [akTop, akRight]
                    Flat = True
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                    ParentShowHint = False
                    ShowHint = True
                    OnClick = sbSicoobAcharChavePrivadaClick
                  end
                  object sbSicoobAcharArqCertificado: TSpeedButton
                    Left = 836
                    Top = 223
                    Width = 24
                    Height = 23
                    Anchors = [akTop, akRight]
                    Flat = True
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                    ParentShowHint = False
                    ShowHint = True
                    OnClick = sbSicoobAcharArqCertificadoClick
                  end
                  object lbSicoobTokenSandbox: TLabel
                    Left = 24
                    Top = 280
                    Width = 176
                    Height = 13
                    Caption = 'Access Token (APENAS SANDBOX)'
                    Color = clBtnFace
                    ParentColor = False
                  end
                  object edSicoobChavePIX: TEdit
                    Left = 24
                    Top = 40
                    Width = 630
                    Height = 21
                    Anchors = [akLeft, akTop, akRight]
                    TabOrder = 0
                    OnChange = edSicoobChavePIXChange
                  end
                  object cbSicoobTipoChave: TComboBox
                    Left = 675
                    Top = 40
                    Width = 157
                    Height = 21
                    Style = csDropDownList
                    Anchors = [akTop, akRight]
                    TabOrder = 1
                    TabStop = False
                  end
                  object edSicoobClientID: TEdit
                    Left = 24
                    Top = 99
                    Width = 808
                    Height = 21
                    Anchors = [akLeft, akTop, akRight]
                    TabOrder = 2
                  end
                  object edSicoobArqChavePrivada: TEdit
                    Left = 24
                    Top = 153
                    Width = 808
                    Height = 23
                    Anchors = [akLeft, akTop, akRight]
                    AutoSize = False
                    TabOrder = 3
                    Text = 'SicoobChavePrivada.key'
                    OnChange = edSicoobArqsChange
                    OnExit = edSicoobArqChavePrivadaExit
                  end
                  object edSicoobArqCertificado: TEdit
                    Left = 24
                    Top = 223
                    Width = 808
                    Height = 23
                    Anchors = [akLeft, akTop, akRight]
                    AutoSize = False
                    TabOrder = 4
                    Text = 'SicoobCertificado.pem'
                    OnChange = edSicoobArqsChange
                    OnExit = edSicoobArqCertificadoExit
                  end
                  object edSicoobTokenSandbox: TEdit
                    Left = 24
                    Top = 296
                    Width = 808
                    Height = 21
                    Anchors = [akLeft, akTop, akRight]
                    TabOrder = 5
                  end
                end
              end
            end
            object tsSicoobExtrairChaveCertificado: TTabSheet
              Caption = 'Extrair Chave/Certificado'
              ImageIndex = 1
              object pnSicoobExtrairChaveCertificado: TPanel
                Left = 0
                Top = 0
                Width = 880
                Height = 340
                Align = alClient
                BevelOuter = bvNone
                TabOrder = 0
                DesignSize = (
                  880
                  340)
                object lbSicoobExtrairChaveCertificadoArqPFX: TLabel
                  Left = 40
                  Top = 40
                  Width = 112
                  Height = 13
                  Caption = 'Arquivo Certificado PFX'
                  Color = clBtnFace
                  ParentColor = False
                end
                object btSicoobExtrairChaveCertificadoArqPFX: TSpeedButton
                  Left = 600
                  Top = 56
                  Width = 24
                  Height = 23
                  Anchors = [akTop, akRight]
                  Flat = True
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                  ParentShowHint = False
                  ShowHint = True
                  OnClick = btSicoobExtrairChaveCertificadoArqPFXClick
                end
                object lbSicoobExtrairChaveCertificadoSenhaPFX: TLabel
                  Left = 640
                  Top = 40
                  Width = 84
                  Height = 13
                  Caption = 'Senha Certificado'
                  Color = clBtnFace
                  ParentColor = False
                end
                object btSicoobExtrairChaveCertificadoVerSenhaPFX: TSpeedButton
                  Left = 808
                  Top = 56
                  Width = 23
                  Height = 23
                  AllowAllUp = True
                  Anchors = [akTop, akRight]
                  GroupIndex = 1
                  Flat = True
                  OnClick = btSicoobExtrairChaveCertificadoVerSenhaPFXClick
                end
                object lbSicoobExtrairChavePrivada: TLabel
                  Left = 40
                  Top = 160
                  Width = 109
                  Height = 13
                  Caption = 'Arquivo Chave Privada'
                  Color = clBtnFace
                  ParentColor = False
                end
                object btSicoobExtrairChaveCertificadoInfo: TSpeedButton
                  Left = 224
                  Top = 104
                  Width = 30
                  Height = 30
                  Anchors = [akTop, akRight]
                  Flat = True
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                  ParentShowHint = False
                  ShowHint = True
                  OnClick = btSicoobExtrairChaveCertificadoInfoClick
                end
                object lbSicoobExtrairCertificado: TLabel
                  Left = 40
                  Top = 216
                  Width = 115
                  Height = 13
                  Caption = 'Arquivo Certificado PEM'
                  Color = clBtnFace
                  ParentColor = False
                end
                object edSicoobExtrairChaveCertificadoArqPFX: TEdit
                  Left = 40
                  Top = 56
                  Width = 560
                  Height = 23
                  Anchors = [akLeft, akTop, akRight]
                  AutoSize = False
                  TabOrder = 0
                end
                object edSicoobExtrairChaveCertificadoSenhaPFX: TEdit
                  Left = 640
                  Top = 56
                  Width = 164
                  Height = 21
                  Anchors = [akLeft, akTop, akRight]
                  PasswordChar = '*'
                  TabOrder = 1
                end
                object btSicoobExtrairChaveCertificado: TBitBtn
                  Left = 40
                  Top = 104
                  Width = 179
                  Height = 30
                  Caption = 'Extrair Chave/Certificado'
                  TabOrder = 2
                  OnClick = btSicoobExtrairChaveCertificadoClick
                end
                object edSicoobExtrairChavePrivada: TEdit
                  Left = 40
                  Top = 176
                  Width = 791
                  Height = 23
                  Anchors = [akLeft, akTop, akRight]
                  AutoSize = False
                  TabOrder = 3
                  Text = 'SicoobChavePrivada.key'
                end
                object edSicoobExtrairCertificado: TEdit
                  Left = 40
                  Top = 232
                  Width = 791
                  Height = 23
                  Anchors = [akLeft, akTop, akRight]
                  AutoSize = False
                  TabOrder = 4
                  Text = 'SicoobCertificado.pem'
                end
              end
            end
          end
        end
        object tsPagSeguro: TTabSheet
          Caption = 'PagSeguro'
          object pgPagSeguro: TPageControl
            Left = 54
            Top = 40
            Width = 866
            Height = 424
            ActivePage = tsPagSeguroConfigCredenciais
            TabHeight = 25
            TabOrder = 0
            TabWidth = 150
            object tsPagSeguroConfigCredenciais: TTabSheet
              Caption = 'Config Credenciais'
              object pnPagSeguroConfigCredenciais: TPanel
                Left = 0
                Top = 0
                Width = 858
                Height = 389
                Align = alClient
                BevelOuter = bvNone
                TabOrder = 0
                DesignSize = (
                  858
                  389)
                object sbPagSeguroAcharChavePrivada: TSpeedButton
                  Left = 814
                  Top = 197
                  Width = 24
                  Height = 23
                  Anchors = [akTop, akRight]
                  Flat = True
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                  ParentShowHint = False
                  ShowHint = True
                  OnClick = sbPagSeguroAcharChavePrivadaClick
                end
                object sbPagSeguroAcharArqCertificado: TSpeedButton
                  Left = 814
                  Top = 267
                  Width = 24
                  Height = 23
                  Anchors = [akTop, akRight]
                  Flat = True
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                  ParentShowHint = False
                  ShowHint = True
                  OnClick = sbPagSeguroAcharArqCertificadoClick
                end
                object lbPagSeguroTipoChave: TLabel
                  Left = 652
                  Top = 24
                  Width = 55
                  Height = 13
                  Anchors = [akTop, akRight]
                  Caption = 'Tipo Chave'
                  Color = clBtnFace
                  ParentColor = False
                end
                object lbPagSeguroErroChavePrivada: TLabel
                  Left = 24
                  Top = 222
                  Width = 147
                  Height = 13
                  Caption = 'lbPagSeguroErroChavePrivada'
                  Color = clBtnFace
                  ParentColor = False
                end
                object lbPagSeguroErroCertificado: TLabel
                  Left = 24
                  Top = 294
                  Width = 130
                  Height = 13
                  Caption = 'lbPagSeguroErroCertificado'
                  Color = clBtnFace
                  ParentColor = False
                end
                object lbPagSeguroClientSecret1: TLabel
                  Left = 344
                  Top = 131
                  Width = 60
                  Height = 13
                  Caption = 'Client Secret'
                  Color = clBtnFace
                  ParentColor = False
                end
                object lbPagSeguroClientID1: TLabel
                  Left = 24
                  Top = 131
                  Width = 40
                  Height = 13
                  Caption = 'Client ID'
                  Color = clBtnFace
                  ParentColor = False
                end
                object lbPagSeguroChavePIX: TLabel
                  Left = 24
                  Top = 24
                  Width = 51
                  Height = 13
                  Caption = 'Chave PIX'
                  Color = clBtnFace
                  ParentColor = False
                end
                object lbPagSeguroArqChavePrivada: TLabel
                  Left = 24
                  Top = 181
                  Width = 109
                  Height = 13
                  Caption = 'Arquivo Chave Privada'
                  Color = clBtnFace
                  ParentColor = False
                end
                object lbPagSeguroArqCertificado: TLabel
                  Left = 24
                  Top = 251
                  Width = 115
                  Height = 13
                  Caption = 'Arquivo Certificado PEM'
                  Color = clBtnFace
                  ParentColor = False
                end
                object imPagSeguroErroChavePrivada: TImage
                  Left = 3
                  Top = 200
                  Width = 16
                  Height = 16
                  Visible = False
                end
                object imPagSeguroErroChavePix: TImage
                  Left = 814
                  Top = 44
                  Width = 16
                  Height = 16
                  Anchors = [akTop, akRight]
                  Visible = False
                end
                object imPagSeguroErroCertificado: TImage
                  Left = 3
                  Top = 271
                  Width = 16
                  Height = 16
                  Visible = False
                end
                object lbPagSeguroTokenPay1: TLabel
                  Left = 344
                  Top = 75
                  Width = 31
                  Height = 13
                  Caption = 'Token'
                  Color = clBtnFace
                  ParentColor = False
                end
                object lbPagSeguroNomeApp: TLabel
                  Left = 24
                  Top = 75
                  Width = 78
                  Height = 13
                  Caption = 'Nome Aplica'#231#227'o'
                  Color = clBtnFace
                  ParentColor = False
                end
                object edPagSeguroClientSecret1: TEdit
                  Left = 344
                  Top = 147
                  Width = 466
                  Height = 21
                  Anchors = [akLeft, akTop, akRight]
                  TabOrder = 3
                end
                object edPagSeguroClientID1: TEdit
                  Left = 24
                  Top = 147
                  Width = 306
                  Height = 21
                  Anchors = [akLeft, akTop, akRight]
                  TabOrder = 2
                end
                object edPagSeguroChavePIX: TEdit
                  Left = 24
                  Top = 40
                  Width = 608
                  Height = 21
                  Anchors = [akLeft, akTop, akRight]
                  TabOrder = 0
                  OnChange = edPagSeguroChavePIXChange
                end
                object edPagSeguroArqChavePrivada: TEdit
                  Left = 24
                  Top = 197
                  Width = 786
                  Height = 23
                  Anchors = [akLeft, akTop, akRight]
                  AutoSize = False
                  TabOrder = 4
                  Text = 'PagSeguroChavePrivada.key'
                  OnChange = edPagSeguroArqsChange
                  OnExit = edPagSeguroArqChavePrivadaExit
                end
                object edPagSeguroArqCertificado: TEdit
                  Left = 24
                  Top = 267
                  Width = 786
                  Height = 23
                  Anchors = [akLeft, akTop, akRight]
                  AutoSize = False
                  TabOrder = 5
                  Text = 'PagSeguroCertificado.pem'
                  OnChange = edPagSeguroArqsChange
                  OnExit = edPagSeguroArqCertificadoExit
                end
                object cbPagSeguroTipoChave: TComboBox
                  Left = 653
                  Top = 40
                  Width = 157
                  Height = 21
                  Style = csDropDownList
                  Anchors = [akTop, akRight]
                  TabOrder = 1
                  TabStop = False
                end
                object edPagSeguroToken1: TEdit
                  Left = 344
                  Top = 91
                  Width = 466
                  Height = 21
                  Anchors = [akLeft, akTop, akRight]
                  TabOrder = 6
                end
                object edPagSeguroNomeApp1: TEdit
                  Left = 24
                  Top = 91
                  Width = 306
                  Height = 21
                  Anchors = [akLeft, akTop, akRight]
                  TabOrder = 7
                end
              end
            end
            object tsPagSeguroGerarCredenciais: TTabSheet
              Caption = 'Gerar Credenciais'
              object pnPagSeguroGerarCredenciais: TPanel
                Left = 0
                Top = 0
                Width = 858
                Height = 389
                Align = alClient
                BevelOuter = bvNone
                TabOrder = 0
                object pgPagSeguroGerarCredenciais: TPageControl
                  Left = 0
                  Top = 0
                  Width = 858
                  Height = 389
                  ActivePage = tsPagSeguroGerarCredenciaisClients
                  Align = alClient
                  TabHeight = 25
                  TabOrder = 0
                  TabWidth = 150
                  object tsPagSeguroGerarCredenciaisClients: TTabSheet
                    Caption = 'ClientID / ClientSecret'
                    object pnPagSeguroGerarCredenciaisClients: TPanel
                      Left = 0
                      Top = 0
                      Width = 850
                      Height = 354
                      Align = alClient
                      BevelOuter = bvNone
                      TabOrder = 0
                      DesignSize = (
                        850
                        354)
                      object lbPagSeguroNomeApp1: TLabel
                        Left = 24
                        Top = 24
                        Width = 78
                        Height = 13
                        Caption = 'Nome Aplica'#231#227'o'
                        Color = clBtnFace
                        ParentColor = False
                      end
                      object lbPagSeguroTokenPay2: TLabel
                        Left = 344
                        Top = 24
                        Width = 31
                        Height = 13
                        Caption = 'Token'
                        Color = clBtnFace
                        ParentColor = False
                      end
                      object lbPagSeguroClientID2: TLabel
                        Left = 24
                        Top = 126
                        Width = 40
                        Height = 13
                        Caption = 'Client ID'
                        Color = clBtnFace
                        ParentColor = False
                      end
                      object lbPagSeguroClientSecret2: TLabel
                        Left = 344
                        Top = 126
                        Width = 60
                        Height = 13
                        Caption = 'Client Secret'
                        Color = clBtnFace
                        ParentColor = False
                      end
                      object edPagSeguroNomeApp2: TEdit
                        Left = 24
                        Top = 40
                        Width = 306
                        Height = 21
                        Anchors = [akLeft, akTop, akRight]
                        TabOrder = 0
                      end
                      object edPagSeguroToken2: TEdit
                        Left = 344
                        Top = 40
                        Width = 466
                        Height = 21
                        Anchors = [akLeft, akTop, akRight]
                        TabOrder = 1
                      end
                      object edPagSeguroClientID2: TEdit
                        Left = 24
                        Top = 142
                        Width = 306
                        Height = 21
                        Anchors = [akLeft, akTop, akRight]
                        Enabled = False
                        TabOrder = 2
                      end
                      object edPagSeguroClientSecret2: TEdit
                        Left = 344
                        Top = 142
                        Width = 466
                        Height = 21
                        Anchors = [akLeft, akTop, akRight]
                        Enabled = False
                        TabOrder = 3
                      end
                      object btPagSeguroGerarClients: TBitBtn
                        Left = 23
                        Top = 78
                        Width = 160
                        Height = 26
                        Anchors = [akTop, akRight]
                        Caption = 'Gerar Credenciais'
                        TabOrder = 4
                        OnClick = btPagSeguroGerarClientsClick
                      end
                    end
                  end
                  object tsPagSeguroGerarChaves: TTabSheet
                    Caption = 'Gerar Chaves'
                    object pnPagSeguroGerarChaves: TPanel
                      Left = 0
                      Top = 0
                      Width = 850
                      Height = 354
                      Align = alClient
                      BevelOuter = bvNone
                      TabOrder = 0
                      DesignSize = (
                        850
                        354)
                      object lbPagSeguroPublicKey: TLabel
                        Left = 24
                        Top = 24
                        Width = 69
                        Height = 13
                        Caption = 'Chave P'#250'blica'
                        Color = clBtnFace
                        ParentColor = False
                      end
                      object lbPagSeguroPrivateKey: TLabel
                        Left = 424
                        Top = 24
                        Width = 70
                        Height = 13
                        Caption = 'Chave Privada'
                        Color = clBtnFace
                        ParentColor = False
                      end
                      object btPagSeguroGerarChaves: TBitBtn
                        Left = 23
                        Top = 78
                        Width = 160
                        Height = 26
                        Anchors = [akTop, akRight]
                        Caption = 'Gerar Chaves'
                        TabOrder = 0
                        OnClick = btPagSeguroGerarChavesClick
                      end
                      object edPagSeguroPublicKey: TEdit
                        Left = 24
                        Top = 40
                        Width = 383
                        Height = 21
                        Anchors = [akLeft, akTop, akRight]
                        TabOrder = 1
                        Text = 'PagSeguro_Public.key'
                      end
                      object edPagSeguroPrivateKey: TEdit
                        Left = 424
                        Top = 40
                        Width = 386
                        Height = 21
                        Anchors = [akLeft, akTop, akRight]
                        TabOrder = 2
                        Text = 'PagSeguro_Private.key'
                      end
                      object mmPagSeguroPublicKey: TMemo
                        Left = 24
                        Top = 120
                        Width = 383
                        Height = 216
                        Anchors = [akLeft, akTop, akRight, akBottom]
                        Font.Charset = DEFAULT_CHARSET
                        Font.Color = clWindowText
                        Font.Height = -11
                        Font.Name = 'Lucida Console'
                        Font.Style = []
                        ParentFont = False
                        ReadOnly = True
                        ScrollBars = ssBoth
                        TabOrder = 3
                        WantReturns = False
                        WordWrap = False
                      end
                      object mmPagSeguroPrivateKey: TMemo
                        Left = 424
                        Top = 120
                        Width = 386
                        Height = 216
                        Anchors = [akLeft, akTop, akRight, akBottom]
                        Font.Charset = DEFAULT_CHARSET
                        Font.Color = clWindowText
                        Font.Height = -11
                        Font.Name = 'Lucida Console'
                        Font.Style = []
                        ParentFont = False
                        ReadOnly = True
                        ScrollBars = ssBoth
                        TabOrder = 4
                        WantReturns = False
                        WordWrap = False
                      end
                    end
                  end
                  object tsPagSeguroChallenge: TTabSheet
                    Caption = 'Challenge'
                    object pnPagSeguroChallenge: TPanel
                      Left = 0
                      Top = 0
                      Width = 850
                      Height = 354
                      Align = alClient
                      BevelOuter = bvNone
                      TabOrder = 0
                      DesignSize = (
                        850
                        354)
                      object lbPagSeguroChallengePrivateKey: TLabel
                        Left = 24
                        Top = 160
                        Width = 70
                        Height = 13
                        Caption = 'Chave Privada'
                        Color = clBtnFace
                        ParentColor = False
                      end
                      object lbPagSeguroChallengeToken: TLabel
                        Left = 216
                        Top = 7
                        Width = 151
                        Height = 13
                        Caption = 'Token (Valido por 30 segundos)'
                        Color = clBtnFace
                        ParentColor = False
                      end
                      object btPagSeguroChallengeSolic: TBitBtn
                        Left = 23
                        Top = 20
                        Width = 168
                        Height = 26
                        Anchors = [akTop, akRight]
                        Caption = 'Solicitar Token e Desafio'
                        TabOrder = 0
                        OnClick = btPagSeguroChallengeSolicClick
                      end
                      object edPagSeguroChallengePrivateKey: TEdit
                        Left = 24
                        Top = 176
                        Width = 623
                        Height = 21
                        Anchors = [akLeft, akTop, akRight]
                        TabOrder = 1
                        Text = 'PagSeguro_Private.key'
                      end
                      object mmPagSeguroChallengeCript: TMemo
                        Left = 24
                        Top = 56
                        Width = 799
                        Height = 82
                        Anchors = [akLeft, akTop, akRight, akBottom]
                        Font.Charset = DEFAULT_CHARSET
                        Font.Color = clWindowText
                        Font.Height = -11
                        Font.Name = 'Lucida Console'
                        Font.Style = []
                        ParentFont = False
                        ScrollBars = ssBoth
                        TabOrder = 2
                        WantReturns = False
                      end
                      object mmPagSeguroChallenge: TMemo
                        Left = 24
                        Top = 216
                        Width = 799
                        Height = 120
                        Anchors = [akLeft, akTop, akRight, akBottom]
                        Font.Charset = DEFAULT_CHARSET
                        Font.Color = clWindowText
                        Font.Height = -11
                        Font.Name = 'Lucida Console'
                        Font.Style = []
                        ParentFont = False
                        ReadOnly = True
                        ScrollBars = ssBoth
                        TabOrder = 3
                        WantReturns = False
                        WordWrap = False
                      end
                      object btPagSeguroChallengeDecript: TBitBtn
                        Left = 663
                        Top = 173
                        Width = 160
                        Height = 26
                        Anchors = [akTop, akRight]
                        Caption = 'Descriptografar'
                        TabOrder = 4
                        OnClick = btPagSeguroChallengeDecriptClick
                      end
                      object edPagSeguroChallengeToken: TEdit
                        Left = 216
                        Top = 23
                        Width = 607
                        Height = 21
                        Anchors = [akLeft, akTop, akRight]
                        TabOrder = 5
                      end
                    end
                  end
                  object tsPagSeguroCertificado: TTabSheet
                    Caption = 'Certificado'
                    object pnPagSeguroCertificado: TPanel
                      Left = 0
                      Top = 0
                      Width = 850
                      Height = 354
                      Align = alClient
                      BevelOuter = bvNone
                      TabOrder = 0
                      DesignSize = (
                        850
                        354)
                      object lbPagSeguroChallengeToken2: TLabel
                        Left = 24
                        Top = 24
                        Width = 151
                        Height = 13
                        Caption = 'Token (V'#225'lido por 30 segundos)'
                        Color = clBtnFace
                        ParentColor = False
                      end
                      object lbPagSeguroCertificadoChallenge: TLabel
                        Left = 424
                        Top = 24
                        Width = 137
                        Height = 13
                        Caption = 'Challenge (Descriptografado)'
                        Color = clBtnFace
                        ParentColor = False
                      end
                      object lbPagSeguroPublicKey1: TLabel
                        Left = 24
                        Top = 120
                        Width = 75
                        Height = 13
                        Caption = 'Certificado Final'
                        Color = clBtnFace
                        ParentColor = False
                      end
                      object lbPagSeguroPrivateKey1: TLabel
                        Left = 424
                        Top = 120
                        Width = 95
                        Height = 13
                        Caption = 'Chave Privada Final'
                        Color = clBtnFace
                        ParentColor = False
                      end
                      object btPagSeguroCertificadoGerar: TBitBtn
                        Left = 23
                        Top = 78
                        Width = 160
                        Height = 26
                        Anchors = [akTop, akRight]
                        Caption = 'Gerar Certificado'
                        TabOrder = 0
                        OnClick = btPagSeguroCertificadoGerarClick
                      end
                      object edPagSeguroChallengeToken2: TEdit
                        Left = 24
                        Top = 40
                        Width = 383
                        Height = 21
                        Anchors = [akLeft, akTop, akRight]
                        TabOrder = 1
                      end
                      object edPagSeguroCertificadoChallenge: TEdit
                        Left = 424
                        Top = 40
                        Width = 386
                        Height = 21
                        Anchors = [akLeft, akTop, akRight]
                        TabOrder = 2
                      end
                      object edPagSeguroCertificadoFinal: TEdit
                        Left = 24
                        Top = 136
                        Width = 383
                        Height = 21
                        Anchors = [akLeft, akTop, akRight]
                        TabOrder = 3
                        Text = 'PagSeguro_CertificadoFinal.pem'
                      end
                      object edPagSeguroPrivateKeyFinal: TEdit
                        Left = 424
                        Top = 136
                        Width = 386
                        Height = 21
                        Anchors = [akLeft, akTop, akRight]
                        TabOrder = 4
                        Text = 'PagSeguro_PrivateFinal.key'
                      end
                    end
                  end
                end
              end
            end
          end
        end
        object tsGerenciaNet: TTabSheet
          Caption = 'GerenciaNet'
          ImageIndex = 7
          DesignSize = (
            984
            474)
          object pnGerenciaNet: TPanel
            Left = 40
            Top = 79
            Width = 880
            Height = 256
            Anchors = [akLeft, akRight]
            BevelOuter = bvNone
            TabOrder = 0
            DesignSize = (
              880
              256)
            object sbGerenciaNetAcharPFX: TSpeedButton
              Left = 852
              Top = 192
              Width = 24
              Height = 23
              Anchors = [akTop, akRight]
              Flat = True
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              OnClick = sbGerenciaNetAcharPFXClick
            end
            object lbGerenciaNetTipoChave: TLabel
              Left = 687
              Top = 19
              Width = 55
              Height = 13
              Anchors = [akTop, akRight]
              Caption = 'Tipo Chave'
              Color = clBtnFace
              ParentColor = False
            end
            object lbGerenciaNetErroPFX: TLabel
              Left = 32
              Top = 214
              Width = 107
              Height = 13
              Caption = 'lbGerenciaNetErroPFX'
              Color = clBtnFace
              ParentColor = False
            end
            object lbGerenciaNetClientSecret: TLabel
              Left = 32
              Top = 127
              Width = 60
              Height = 13
              Caption = 'Client Secret'
              Color = clBtnFace
              ParentColor = False
            end
            object lbGerenciaNetClientID: TLabel
              Left = 32
              Top = 68
              Width = 40
              Height = 13
              Caption = 'Client ID'
              Color = clBtnFace
              ParentColor = False
            end
            object lbGerenciaNetChave: TLabel
              Left = 32
              Top = 19
              Width = 51
              Height = 13
              Caption = 'Chave PIX'
              Color = clBtnFace
              ParentColor = False
            end
            object lbGerenciaNetPFX: TLabel
              Left = 32
              Top = 176
              Width = 148
              Height = 13
              Caption = 'Arquivo Certificado (P12 / PFX)'
              Color = clBtnFace
              ParentColor = False
            end
            object imGerenciaNetErroPFX: TImage
              Left = 10
              Top = 192
              Width = 16
              Height = 16
              Visible = False
            end
            object imGerenciaNetErroChavePix: TImage
              Left = 852
              Top = 38
              Width = 16
              Height = 17
              Anchors = [akTop, akRight]
              Visible = False
            end
            object edGerenciaNetClientSecret: TEdit
              Left = 32
              Top = 143
              Width = 816
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 0
            end
            object edGerenciaNetClientID: TEdit
              Left = 32
              Top = 83
              Width = 816
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 1
            end
            object edGerenciaNetChavePIX: TEdit
              Left = 32
              Top = 35
              Width = 639
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 2
              OnChange = edGerenciaNetChavePIXChange
            end
            object edGerenciaNetArqPFX: TEdit
              Left = 32
              Top = 192
              Width = 816
              Height = 23
              Anchors = [akLeft, akTop, akRight]
              AutoSize = False
              TabOrder = 3
              Text = 'GerenciaNet.p12'
              OnChange = edGerenciaNetArqPFXChange
              OnExit = edGerenciaNetArqPFXExit
            end
            object cbGerenciaNetTipoChave: TComboBox
              Left = 689
              Top = 35
              Width = 158
              Height = 21
              Style = csDropDownList
              Anchors = [akTop, akRight]
              TabOrder = 4
              TabStop = False
            end
          end
        end
        object tsBradesco: TTabSheet
          Caption = 'Bradesco'
          DesignSize = (
            984
            474)
          object pnBradesco: TPanel
            Left = 40
            Top = 79
            Width = 880
            Height = 353
            Anchors = [akLeft, akRight]
            BevelOuter = bvNone
            TabOrder = 0
            DesignSize = (
              880
              353)
            object lbBradescoTipoChave: TLabel
              Left = 677
              Top = 20
              Width = 55
              Height = 13
              Anchors = [akTop, akRight]
              Caption = 'Tipo Chave'
              Color = clBtnFace
              ParentColor = False
            end
            object lbBradescoClientSecret: TLabel
              Left = 32
              Top = 127
              Width = 60
              Height = 13
              Caption = 'Client Secret'
              Color = clBtnFace
              ParentColor = False
            end
            object lbBradescoClientKey: TLabel
              Left = 32
              Top = 68
              Width = 47
              Height = 13
              Caption = 'Client Key'
              Color = clBtnFace
              ParentColor = False
            end
            object lbBradescoChave: TLabel
              Left = 32
              Top = 20
              Width = 51
              Height = 13
              Caption = 'Chave PIX'
              Color = clBtnFace
              ParentColor = False
            end
            object imBradescoErroChavePix: TImage
              Left = 852
              Top = 38
              Width = 16
              Height = 17
              Anchors = [akTop, akRight]
              Visible = False
            end
            object lbBradescoAPIVersao: TLabel
              Left = 679
              Top = 68
              Width = 53
              Height = 13
              Anchors = [akTop, akRight]
              Caption = 'Versao API'
              Color = clBtnFace
              ParentColor = False
            end
            object edBradescoClientSecret: TEdit
              Left = 32
              Top = 143
              Width = 616
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 0
            end
            object edBradescoClientID: TEdit
              Left = 32
              Top = 83
              Width = 616
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 1
            end
            object edBradescoChavePIX: TEdit
              Left = 32
              Top = 35
              Width = 616
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 2
              OnChange = edBradescoChavePIXChange
            end
            object cbBradescoTipoChave: TComboBox
              Left = 679
              Top = 35
              Width = 169
              Height = 21
              Style = csDropDownList
              Anchors = [akTop, akRight]
              TabOrder = 4
              TabStop = False
            end
            object rgBradescoTipoCertificado: TRadioGroup
              Left = 679
              Top = 116
              Width = 189
              Height = 58
              Anchors = [akTop, akRight]
              Caption = 'Tipo Certificado'
              Columns = 2
              ItemIndex = 0
              Items.Strings = (
                'PFX'
                'Chave/Certificado')
              TabOrder = 5
              OnClick = rgBradescoTipoCertificadoClick
            end
            object pnBradescoCertificados: TPanel
              Left = 0
              Top = 182
              Width = 880
              Height = 171
              Align = alBottom
              BevelOuter = bvNone
              TabOrder = 6
              object pcBradescoCertificados: TPageControl
                Left = 0
                Top = 0
                Width = 880
                Height = 171
                ActivePage = tsBradescoPFX
                Align = alClient
                TabOrder = 0
                Visible = False
                object tsBradescoPFX: TTabSheet
                  Caption = 'PFX'
                  object pnBradescoPFX: TPanel
                    Left = 0
                    Top = 0
                    Width = 872
                    Height = 143
                    Align = alClient
                    BevelOuter = bvNone
                    TabOrder = 0
                    DesignSize = (
                      872
                      143)
                    object sbBradescoAcharPFX: TSpeedButton
                      Left = 638
                      Top = 39
                      Width = 24
                      Height = 23
                      Anchors = [akTop, akRight]
                      Flat = True
                      Font.Charset = DEFAULT_CHARSET
                      Font.Color = clWindowText
                      Font.Height = -11
                      Font.Name = 'MS Sans Serif'
                      Font.Style = []
                      ParentFont = False
                      ParentShowHint = False
                      ShowHint = True
                      OnClick = sbBradescoAcharPFXClick
                    end
                    object lbBradescoErroPFX: TLabel
                      Left = 30
                      Top = 64
                      Width = 92
                      Height = 13
                      Caption = 'lbBradescoErroPFX'
                      Color = clBtnFace
                      ParentColor = False
                      Visible = False
                    end
                    object lbBradescoPFX: TLabel
                      Left = 30
                      Top = 24
                      Width = 59
                      Height = 13
                      Caption = 'Arquivo PFX'
                      Color = clBtnFace
                      ParentColor = False
                    end
                    object imBradescoErroPFX: TImage
                      Left = 11
                      Top = 46
                      Width = 16
                      Height = 16
                      Visible = False
                    end
                    object sbBradescoVerSenhaPFX: TSpeedButton
                      Left = 840
                      Top = 39
                      Width = 23
                      Height = 23
                      AllowAllUp = True
                      Anchors = [akTop, akRight]
                      GroupIndex = 1
                      Flat = True
                      OnClick = sbBradescoVerSenhaPFXClick
                    end
                    object lbBradescoSenhaPFX: TLabel
                      Left = 678
                      Top = 24
                      Width = 84
                      Height = 13
                      Caption = 'Senha Certificado'
                      Color = clBtnFace
                      ParentColor = False
                    end
                    object edBradescoArqPFX: TEdit
                      Left = 30
                      Top = 39
                      Width = 608
                      Height = 23
                      Anchors = [akLeft, akTop, akRight]
                      AutoSize = False
                      TabOrder = 0
                      Text = 'Bradesco.pfx'
                      OnChange = edBradescoArqPFXChange
                      OnExit = edBradescoValidarPFXExit
                    end
                    object edBradescoSenhaPFX: TEdit
                      Left = 678
                      Top = 39
                      Width = 161
                      Height = 21
                      Anchors = [akLeft, akTop, akRight]
                      PasswordChar = '*'
                      TabOrder = 1
                      OnExit = edBradescoValidarPFXExit
                    end
                  end
                end
                object tsBradescoChaveECertificado: TTabSheet
                  Caption = 'Chave Privada/Certificado'
                  object pnBradescoChaveECert: TPanel
                    Left = 0
                    Top = 0
                    Width = 872
                    Height = 143
                    Align = alClient
                    BevelOuter = bvNone
                    TabOrder = 0
                    Visible = False
                    DesignSize = (
                      872
                      143)
                    object imBradescoErroChavePrivada: TImage
                      Left = 16
                      Top = 35
                      Width = 16
                      Height = 16
                      Visible = False
                    end
                    object lbBradescoArqChavePrivada: TLabel
                      Left = 32
                      Top = 15
                      Width = 109
                      Height = 13
                      Caption = 'Arquivo Chave Privada'
                      Color = clBtnFace
                      ParentColor = False
                    end
                    object lbBradescoErroChavePrivada: TLabel
                      Left = 32
                      Top = 56
                      Width = 108
                      Height = 13
                      Caption = 'lbBBErroChavePrivada'
                      Color = clBtnFace
                      ParentColor = False
                      Visible = False
                    end
                    object sbBradescoAcharChavePrivada: TSpeedButton
                      Left = 847
                      Top = 32
                      Width = 24
                      Height = 23
                      Anchors = [akTop, akRight]
                      Flat = True
                      Font.Charset = DEFAULT_CHARSET
                      Font.Color = clWindowText
                      Font.Height = -11
                      Font.Name = 'MS Sans Serif'
                      Font.Style = []
                      ParentFont = False
                      ParentShowHint = False
                      ShowHint = True
                      OnClick = sbBradescoAcharChavePrivadaClick
                    end
                    object sbBradescoAcharArqCertificado: TSpeedButton
                      Left = 847
                      Top = 96
                      Width = 24
                      Height = 23
                      Anchors = [akTop, akRight]
                      Flat = True
                      Font.Charset = DEFAULT_CHARSET
                      Font.Color = clWindowText
                      Font.Height = -11
                      Font.Name = 'MS Sans Serif'
                      Font.Style = []
                      ParentFont = False
                      ParentShowHint = False
                      ShowHint = True
                      OnClick = sbBradescoAcharArqCertificadoClick
                    end
                    object lbBradescoArqCertificado: TLabel
                      Left = 32
                      Top = 80
                      Width = 89
                      Height = 13
                      Caption = 'Arquivo Certificado'
                      Color = clBtnFace
                      ParentColor = False
                    end
                    object imBradescoErroCertificado: TImage
                      Left = 16
                      Top = 98
                      Width = 16
                      Height = 16
                      Visible = False
                    end
                    object lbBradescoErroCertificado: TLabel
                      Left = 32
                      Top = 118
                      Width = 91
                      Height = 13
                      Caption = 'lbBBErroCertificado'
                      Color = clBtnFace
                      ParentColor = False
                      Visible = False
                    end
                    object edBradescoArqChavePrivada: TEdit
                      Left = 32
                      Top = 32
                      Width = 814
                      Height = 23
                      Anchors = [akLeft, akTop, akRight]
                      AutoSize = False
                      TabOrder = 0
                      OnChange = edBradescoArqsChange
                      OnExit = edBradescoArqChavePrivadaExit
                    end
                    object edBradescoArqCertificado: TEdit
                      Left = 32
                      Top = 96
                      Width = 814
                      Height = 23
                      Anchors = [akLeft, akTop, akRight]
                      AutoSize = False
                      TabOrder = 1
                      OnChange = edBradescoArqsChange
                      OnExit = edBradescoArqCertificadoExit
                    end
                  end
                end
              end
            end
            object cbBradescoAPIVersao: TComboBox
              Left = 679
              Top = 83
              Width = 169
              Height = 21
              Style = csDropDownList
              Anchors = [akTop, akRight]
              TabOrder = 3
              TabStop = False
            end
          end
        end
        object tsPIXPDV: TTabSheet
          Caption = 'PIXPDV'
          DesignSize = (
            984
            474)
          object pnPixPDV: TPanel
            Left = 34
            Top = 124
            Width = 933
            Height = 240
            Anchors = [akLeft, akRight]
            BevelOuter = bvNone
            TabOrder = 0
            DesignSize = (
              933
              240)
            object lbPixPDVCNPJ: TLabel
              Left = 24
              Top = 50
              Width = 27
              Height = 13
              Caption = 'CNPJ'
              Color = clBtnFace
              ParentColor = False
            end
            object lbPixPDVToken: TLabel
              Left = 24
              Top = 101
              Width = 31
              Height = 13
              Caption = 'Token'
              Color = clBtnFace
              ParentColor = False
            end
            object lbPixPDVSecretKey: TLabel
              Left = 24
              Top = 157
              Width = 52
              Height = 13
              Caption = 'Secret Key'
              Color = clBtnFace
              ParentColor = False
            end
            object lbPIXPDVVersaoAPI: TLabel
              Left = 750
              Top = 50
              Width = 53
              Height = 13
              Caption = 'Vers'#227'o API'
              Color = clBtnFace
              ParentColor = False
            end
            object edPixPDVCNPJ: TEdit
              Left = 24
              Top = 64
              Width = 705
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 1
            end
            object edPixPDVToken: TEdit
              Left = 24
              Top = 115
              Width = 885
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 2
            end
            object edPixPDVSecretKey: TEdit
              Left = 24
              Top = 171
              Width = 885
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 3
            end
            object cbPIXPDVVersaoAPI: TComboBox
              Left = 750
              Top = 64
              Width = 158
              Height = 21
              Style = csDropDownList
              TabOrder = 0
              TabStop = False
            end
          end
        end
        object tsInter: TTabSheet
          Caption = 'Inter'
          DesignSize = (
            984
            474)
          object pnInter: TPanel
            Left = 48
            Top = 72
            Width = 880
            Height = 323
            Anchors = [akLeft, akRight]
            BevelOuter = bvNone
            TabOrder = 0
            DesignSize = (
              880
              323)
            object lbInterTipoChave: TLabel
              Left = 680
              Top = 24
              Width = 55
              Height = 13
              Anchors = [akTop, akRight]
              Caption = 'Tipo Chave'
              Color = clBtnFace
              ParentColor = False
            end
            object lbInterClientSecret: TLabel
              Left = 24
              Top = 132
              Width = 60
              Height = 13
              Caption = 'Client Secret'
              Color = clBtnFace
              ParentColor = False
            end
            object lbInterClientID: TLabel
              Left = 24
              Top = 75
              Width = 40
              Height = 13
              Caption = 'Client ID'
              Color = clBtnFace
              ParentColor = False
            end
            object lbInterChave: TLabel
              Left = 24
              Top = 24
              Width = 51
              Height = 13
              Caption = 'Chave PIX'
              Color = clBtnFace
              ParentColor = False
            end
            object imInterErroChavePix: TImage
              Left = 844
              Top = 43
              Width = 16
              Height = 17
              Anchors = [akTop, akRight]
              Visible = False
            end
            object lbInterChavePrivada: TLabel
              Left = 24
              Top = 181
              Width = 109
              Height = 13
              Caption = 'Arquivo Chave Privada'
              Color = clBtnFace
              ParentColor = False
            end
            object lbInterErroChavePrivada: TLabel
              Left = 24
              Top = 222
              Width = 115
              Height = 13
              Caption = 'lbInterErroChavePrivada'
              Color = clBtnFace
              ParentColor = False
            end
            object imInterErroChavePrivada: TImage
              Left = 3
              Top = 200
              Width = 16
              Height = 16
              Visible = False
            end
            object btInterAcharChavePrivada: TSpeedButton
              Left = 844
              Top = 197
              Width = 24
              Height = 23
              Anchors = [akTop, akRight]
              Flat = True
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              OnClick = btInterAcharChavePrivadaClick
            end
            object btInterAcharCertificado: TSpeedButton
              Left = 844
              Top = 267
              Width = 24
              Height = 23
              Anchors = [akTop, akRight]
              Flat = True
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              OnClick = btInterAcharCertificadoClick
            end
            object imInterErroCertificado: TImage
              Left = 3
              Top = 271
              Width = 16
              Height = 16
              Visible = False
            end
            object lbInterErroCertificado: TLabel
              Left = 24
              Top = 294
              Width = 98
              Height = 13
              Caption = 'lbInterErroCertificado'
              Color = clBtnFace
              ParentColor = False
            end
            object lbInterCertificado: TLabel
              Left = 24
              Top = 251
              Width = 115
              Height = 13
              Caption = 'Arquivo Certificado PEM'
              Color = clBtnFace
              ParentColor = False
            end
            object edInterClientSecret: TEdit
              Left = 24
              Top = 148
              Width = 816
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 3
            end
            object edInterClientID: TEdit
              Left = 24
              Top = 90
              Width = 816
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 2
            end
            object edInterChavePIX: TEdit
              Left = 24
              Top = 40
              Width = 639
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 0
              OnChange = edInterChavePIXChange
            end
            object cbInterTipoChave: TComboBox
              Left = 681
              Top = 40
              Width = 158
              Height = 21
              Style = csDropDownList
              Anchors = [akTop, akRight]
              TabOrder = 1
              TabStop = False
            end
            object edInterChavePrivada: TEdit
              Left = 24
              Top = 197
              Width = 816
              Height = 23
              Anchors = [akLeft, akTop, akRight]
              AutoSize = False
              TabOrder = 4
              Text = 'InterChavePrivada.key'
              OnChange = edInterArqsChange
              OnExit = edInterChavePrivadaExit
            end
            object edInterCertificado: TEdit
              Left = 24
              Top = 267
              Width = 816
              Height = 23
              Anchors = [akLeft, akTop, akRight]
              AutoSize = False
              TabOrder = 5
              Text = 'InterCertificado.pem'
              OnChange = edInterArqsChange
              OnExit = edInterCertificadoExit
            end
          end
        end
        object tsAilos: TTabSheet
          Caption = 'Ailos'
          object pnAilos: TPanel
            Left = 48
            Top = 56
            Width = 888
            Height = 625
            Align = alCustom
            BevelOuter = bvNone
            TabOrder = 0
            DesignSize = (
              888
              625)
            object lbAilosTipoChave: TLabel
              Left = 682
              Top = 24
              Width = 55
              Height = 13
              Anchors = [akTop, akRight]
              Caption = 'Tipo Chave'
              Color = clBtnFace
              ParentColor = False
            end
            object lbAilosErroChavePrivada: TLabel
              Left = 24
              Top = 222
              Width = 116
              Height = 13
              Caption = 'lbAilosErroChavePrivada'
              Color = clBtnFace
              ParentColor = False
            end
            object lbAilosErroCertificadoRoot: TLabel
              Left = 24
              Top = 371
              Width = 122
              Height = 13
              Caption = 'lbAilosErroCertificadoRoot'
              Color = clBtnFace
              ParentColor = False
            end
            object lbAilosClientSecret: TLabel
              Left = 24
              Top = 132
              Width = 60
              Height = 13
              Caption = 'Client Secret'
              Color = clBtnFace
              ParentColor = False
            end
            object lbAilosClienteID: TLabel
              Left = 24
              Top = 75
              Width = 40
              Height = 13
              Caption = 'Client ID'
              Color = clBtnFace
              ParentColor = False
            end
            object lbAilosChave: TLabel
              Left = 24
              Top = 24
              Width = 51
              Height = 13
              Caption = 'Chave PIX'
              Color = clBtnFace
              ParentColor = False
            end
            object lbAilosChavePrivada: TLabel
              Left = 24
              Top = 181
              Width = 109
              Height = 13
              Caption = 'Arquivo Chave Privada'
              Color = clBtnFace
              ParentColor = False
            end
            object lbAilosCertificadoRoot: TLabel
              Left = 24
              Top = 328
              Width = 115
              Height = 13
              Caption = 'Arquivo Certificado Root'
              Color = clBtnFace
              ParentColor = False
            end
            object imAilosErroChavePIX: TImage
              Left = 844
              Top = 44
              Width = 16
              Height = 16
              Anchors = [akTop, akRight]
              Visible = False
            end
            object imAilosErroCertificadoRoot: TImage
              Left = 3
              Top = 348
              Width = 16
              Height = 16
              Visible = False
            end
            object imAilosErroChavePrivada: TImage
              Left = 3
              Top = 200
              Width = 16
              Height = 16
              Visible = False
            end
            object imAilosErroCertificado: TImage
              Left = 3
              Top = 274
              Width = 16
              Height = 16
              Visible = False
            end
            object lbAilosCertificado: TLabel
              Left = 24
              Top = 254
              Width = 104
              Height = 13
              Caption = 'Arquivo Certificado crt'
              Color = clBtnFace
              ParentColor = False
            end
            object lbAilosErroCertificado: TLabel
              Left = 24
              Top = 297
              Width = 99
              Height = 13
              Caption = 'lbAilosErroCertificado'
              Color = clBtnFace
              ParentColor = False
            end
            object btAilosAcharCertificado: TSpeedButton
              Left = 845
              Top = 270
              Width = 24
              Height = 23
              Anchors = [akTop, akRight]
              Flat = True
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              OnClick = btAilosAcharCertificadoClick
            end
            object btAilosAcharchavePrivada: TSpeedButton
              Left = 845
              Top = 197
              Width = 24
              Height = 23
              Anchors = [akTop, akRight]
              Flat = True
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              OnClick = btAilosAcharchavePrivadaClick
            end
            object btAilosAcharCertificadoRoot: TSpeedButton
              Left = 845
              Top = 344
              Width = 24
              Height = 23
              Anchors = [akTop, akRight]
              Flat = True
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              OnClick = btAilosAcharCertificadoRootClick
            end
            object edAilosClientSecret: TEdit
              Left = 24
              Top = 147
              Width = 816
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 3
            end
            object edAilosClientID: TEdit
              Left = 24
              Top = 91
              Width = 816
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 2
            end
            object edAilosChavePIX: TEdit
              Left = 24
              Top = 40
              Width = 638
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 0
              OnChange = edAilosChavePIXChange
            end
            object edAilosChavePrivada: TEdit
              Left = 24
              Top = 197
              Width = 816
              Height = 23
              Anchors = [akLeft, akTop, akRight]
              AutoSize = False
              TabOrder = 4
              Text = 'AilosChavePrivada.key'
              OnChange = edAilosArqsChange
              OnExit = edAilosChavePrivadaExit
            end
            object edAilosCertificadoRoot: TEdit
              Left = 24
              Top = 344
              Width = 816
              Height = 23
              Anchors = [akLeft, akTop, akRight]
              AutoSize = False
              TabOrder = 6
              Text = 'AilosCertificadoRoot.crt'
              OnExit = edAilosCertificadoRootExit
            end
            object cbAilosTipoChave: TComboBox
              Left = 683
              Top = 40
              Width = 157
              Height = 21
              Style = csDropDownList
              Anchors = [akTop, akRight]
              TabOrder = 1
              TabStop = False
            end
            object edAilosCertificado: TEdit
              Left = 24
              Top = 270
              Width = 816
              Height = 23
              Anchors = [akLeft, akTop, akRight]
              AutoSize = False
              TabOrder = 5
              Text = 'AilosCertificado.crt'
              OnChange = edAilosArqsChange
              OnExit = edAilosCertificadoExit
            end
          end
        end
        object tsMatera: TTabSheet
          Caption = 'Matera'
          object pnMatera: TPanel
            Left = 0
            Top = 0
            Width = 984
            Height = 474
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 0
            object lbMateraClientID: TLabel
              Left = 496
              Top = 88
              Width = 40
              Height = 13
              Caption = 'Client ID'
              Color = clBtnFace
              ParentColor = False
            end
            object lbMateraErroCertificado: TLabel
              Left = 87
              Top = 365
              Width = 110
              Height = 13
              Caption = 'lbMateraErroCertificado'
              Color = clBtnFace
              ParentColor = False
            end
            object lbMateraArqCertificado: TLabel
              Left = 87
              Top = 325
              Width = 89
              Height = 13
              Caption = 'Arquivo Certificado'
              Color = clBtnFace
              ParentColor = False
            end
            object imMateraErroCertificado: TImage
              Left = 64
              Top = 343
              Width = 16
              Height = 16
              Visible = False
            end
            object btMateraAcharArqCertificado: TSpeedButton
              Left = 848
              Top = 341
              Width = 24
              Height = 23
              Flat = True
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              OnClick = btMateraAcharArqCertificadoClick
            end
            object btMateraAcharChavePrivada: TSpeedButton
              Left = 848
              Top = 269
              Width = 24
              Height = 23
              Flat = True
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              OnClick = btMateraAcharChavePrivadaClick
            end
            object lbMateraArqChavePrivada: TLabel
              Left = 87
              Top = 253
              Width = 109
              Height = 13
              Caption = 'Arquivo Chave Privada'
              Color = clBtnFace
              ParentColor = False
            end
            object lbMateraErroChavePrivada: TLabel
              Left = 87
              Top = 293
              Width = 127
              Height = 13
              Caption = 'lbMateraErroChavePrivada'
              Color = clBtnFace
              ParentColor = False
            end
            object imMateraErroChavePrivada: TImage
              Left = 64
              Top = 272
              Width = 16
              Height = 16
              Visible = False
            end
            object lbMateraSecretKey: TLabel
              Left = 496
              Top = 144
              Width = 52
              Height = 13
              Caption = 'Secret Key'
              Color = clBtnFace
              ParentColor = False
            end
            object lbMateraAccountId: TLabel
              Left = 87
              Top = 197
              Width = 52
              Height = 13
              Caption = 'Account Id'
              Color = clBtnFace
              ParentColor = False
            end
            object lbMateraChavePIX: TLabel
              Left = 87
              Top = 88
              Width = 51
              Height = 13
              Caption = 'Chave PIX'
              Color = clBtnFace
              ParentColor = False
            end
            object lbMateraClientSecret: TLabel
              Left = 87
              Top = 144
              Width = 60
              Height = 13
              Caption = 'Client Secret'
              Color = clBtnFace
              ParentColor = False
            end
            object lbMateraMediatorFee: TLabel
              Left = 727
              Top = 197
              Width = 62
              Height = 13
              Caption = 'Mediator Fee'
              Color = clBtnFace
              ParentColor = False
            end
            object edMateraClientID: TEdit
              Left = 496
              Top = 103
              Width = 376
              Height = 21
              PasswordChar = '*'
              TabOrder = 0
            end
            object edMateraArqCertificado: TEdit
              Left = 87
              Top = 341
              Width = 761
              Height = 23
              AutoSize = False
              TabOrder = 1
              OnExit = edMateraArqCertificadoExit
            end
            object edMateraArqChavePrivada: TEdit
              Left = 87
              Top = 269
              Width = 761
              Height = 23
              AutoSize = False
              TabOrder = 2
              OnExit = edMateraArqChavePrivadaExit
            end
            object edMateraSecretKey: TEdit
              Left = 496
              Top = 159
              Width = 376
              Height = 21
              PasswordChar = '*'
              TabOrder = 3
            end
            object edMateraAccountId: TEdit
              Left = 87
              Top = 212
              Width = 617
              Height = 21
              TabOrder = 4
            end
            object edMateraChavePIX: TEdit
              Left = 87
              Top = 103
              Width = 385
              Height = 21
              TabOrder = 5
            end
            object edMateraClientSecret: TEdit
              Left = 87
              Top = 159
              Width = 385
              Height = 21
              PasswordChar = '*'
              TabOrder = 6
            end
            object edMateraMediatorFee: TEdit
              Left = 727
              Top = 212
              Width = 145
              Height = 21
              TabOrder = 7
              Text = '0,10'
            end
          end
        end
        object tsCielo: TTabSheet
          Caption = 'Cielo'
          DesignSize = (
            984
            474)
          object pnCielo: TPanel
            Left = 48
            Top = 72
            Width = 880
            Height = 323
            Anchors = [akLeft, akRight]
            BevelOuter = bvNone
            TabOrder = 0
            DesignSize = (
              880
              323)
            object lbCieloTipoChave: TLabel
              Left = 680
              Top = 24
              Width = 55
              Height = 13
              Anchors = [akTop, akRight]
              Caption = 'Tipo Chave'
              Color = clBtnFace
              ParentColor = False
            end
            object lbCieloClientSecret: TLabel
              Left = 24
              Top = 132
              Width = 60
              Height = 13
              Caption = 'Client Secret'
              Color = clBtnFace
              ParentColor = False
            end
            object lbCieloClientID: TLabel
              Left = 24
              Top = 75
              Width = 40
              Height = 13
              Caption = 'Client ID'
              Color = clBtnFace
              ParentColor = False
            end
            object lbCieloChave: TLabel
              Left = 24
              Top = 24
              Width = 51
              Height = 13
              Caption = 'Chave PIX'
              Color = clBtnFace
              ParentColor = False
            end
            object imCieloErroChavePix: TImage
              Left = 844
              Top = 43
              Width = 16
              Height = 17
              Anchors = [akTop, akRight]
              Visible = False
            end
            object lbCieloArqChavePrivada: TLabel
              Left = 24
              Top = 181
              Width = 109
              Height = 13
              Caption = 'Arquivo Chave Privada'
              Color = clBtnFace
              ParentColor = False
            end
            object lbCieloArqCertificado: TLabel
              Left = 24
              Top = 251
              Width = 89
              Height = 13
              Caption = 'Arquivo Certificado'
              Color = clBtnFace
              ParentColor = False
            end
            object sbCieloAcharChavePrivada: TSpeedButton
              Left = 836
              Top = 197
              Width = 24
              Height = 23
              Anchors = [akTop, akRight]
              Flat = True
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              OnClick = sbCieloAcharChavePrivadaClick
            end
            object sbCieloAcharArqCertificado: TSpeedButton
              Left = 836
              Top = 267
              Width = 24
              Height = 23
              Anchors = [akTop, akRight]
              Flat = True
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              OnClick = sbCieloAcharArqCertificadoClick
            end
            object lbCieloErroChavePrivada: TLabel
              Left = 24
              Top = 222
              Width = 117
              Height = 13
              Caption = 'lbCieloErroChavePrivada'
              Color = clBtnFace
              ParentColor = False
            end
            object lbCieloErroCertificado: TLabel
              Left = 24
              Top = 294
              Width = 100
              Height = 13
              Caption = 'lbCieloErroCertificado'
              Color = clBtnFace
              ParentColor = False
            end
            object imCieloErroChavePrivada: TImage
              Left = 3
              Top = 200
              Width = 16
              Height = 16
              Visible = False
            end
            object imCieloErroCertificado: TImage
              Left = 3
              Top = 271
              Width = 16
              Height = 16
              Visible = False
            end
            object edCieloClientSecret: TEdit
              Left = 24
              Top = 148
              Width = 816
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 3
            end
            object edCieloClientID: TEdit
              Left = 24
              Top = 90
              Width = 816
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 2
            end
            object edCieloChavePIX: TEdit
              Left = 24
              Top = 40
              Width = 639
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 0
              OnChange = edCieloChavePIXChange
            end
            object cbCieloTipoChave: TComboBox
              Left = 681
              Top = 40
              Width = 158
              Height = 21
              Style = csDropDownList
              Anchors = [akTop, akRight]
              TabOrder = 1
              TabStop = False
            end
            object edCieloArqChavePrivada: TEdit
              Left = 24
              Top = 197
              Width = 808
              Height = 23
              Anchors = [akLeft, akTop, akRight]
              AutoSize = False
              TabOrder = 4
              Text = 'CieloChavePrivada.key'
              OnChange = edCieloArqChavePrivadaChange
              OnExit = edCieloArqChavePrivadaExit
            end
            object edCieloArqCertificado: TEdit
              Left = 24
              Top = 267
              Width = 808
              Height = 23
              Anchors = [akLeft, akTop, akRight]
              AutoSize = False
              TabOrder = 5
              Text = 'CieloCertificado.cer'
              OnChange = edCieloArqCertificadoChange
              OnExit = edCieloArqCertificadoExit
            end
          end
        end
        object tsMercadoPago: TTabSheet
          Caption = 'Mercado Pago'
          DesignSize = (
            984
            474)
          object pnMercadoPago: TPanel
            Left = 48
            Top = 72
            Width = 880
            Height = 323
            Anchors = [akLeft, akRight]
            BevelOuter = bvNone
            TabOrder = 0
            DesignSize = (
              880
              323)
            object lbMercadoPagoTipoChave: TLabel
              Left = 680
              Top = 24
              Width = 55
              Height = 13
              Anchors = [akTop, akRight]
              Caption = 'Tipo Chave'
              Color = clBtnFace
              ParentColor = False
            end
            object lbMercadoPagoAccessToken: TLabel
              Left = 24
              Top = 75
              Width = 69
              Height = 13
              Caption = 'Access Token'
              Color = clBtnFace
              ParentColor = False
            end
            object lbMercadoPagoChavePIX: TLabel
              Left = 24
              Top = 24
              Width = 51
              Height = 13
              Caption = 'Chave PIX'
              Color = clBtnFace
              ParentColor = False
            end
            object imMercadoPagoErroChavePix: TImage
              Left = 844
              Top = 43
              Width = 16
              Height = 17
              Anchors = [akTop, akRight]
              Visible = False
            end
            object edMercadoPagoAccessToken: TEdit
              Left = 24
              Top = 90
              Width = 816
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 2
            end
            object edMercadoPagoChavePIX: TEdit
              Left = 24
              Top = 40
              Width = 639
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 0
              OnChange = edMercadoPagoChavePIXChange
            end
            object cbMercadoPagoTipoChave: TComboBox
              Left = 681
              Top = 40
              Width = 158
              Height = 21
              Style = csDropDownList
              Anchors = [akTop, akRight]
              TabOrder = 1
              TabStop = False
            end
          end
        end
        object tsGate2All: TTabSheet
          Caption = 'Gate2All'
          DesignSize = (
            984
            474)
          object pnGate2All: TPanel
            Left = 48
            Top = 72
            Width = 880
            Height = 192
            Anchors = [akLeft, akRight]
            BevelOuter = bvNone
            TabOrder = 0
            DesignSize = (
              880
              192)
            object lbGate2AllAuthenticationKey: TLabel
              Left = 24
              Top = 75
              Width = 86
              Height = 13
              Caption = 'AuthenticationKey'
              Color = clBtnFace
              ParentColor = False
            end
            object lbGate2AllAuthenticationApi: TLabel
              Left = 24
              Top = 24
              Width = 85
              Height = 13
              Caption = 'AuthenticationAPI'
              Color = clBtnFace
              ParentColor = False
            end
            object edGate2AllAuthenticationKey: TEdit
              Left = 24
              Top = 90
              Width = 816
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 1
            end
            object edGate2AllAuthenticationApi: TEdit
              Left = 24
              Top = 40
              Width = 816
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 0
              OnChange = edCieloChavePIXChange
            end
          end
        end
        object tsBanrisul: TTabSheet
          Caption = 'Banrisul'
          DesignSize = (
            984
            474)
          object pnBanrisul: TPanel
            Left = 48
            Top = 114
            Width = 911
            Height = 321
            Anchors = [akLeft, akRight]
            BevelOuter = bvNone
            TabOrder = 0
            DesignSize = (
              911
              321)
            object lbBanrisulTipoChave: TLabel
              Left = 711
              Top = 24
              Width = 55
              Height = 13
              Anchors = [akTop, akRight]
              Caption = 'Tipo Chave'
              Color = clBtnFace
              ParentColor = False
            end
            object lbBanrisulClientSecret: TLabel
              Left = 24
              Top = 132
              Width = 60
              Height = 13
              Caption = 'Client Secret'
              Color = clBtnFace
              ParentColor = False
            end
            object lbBanrisulClientID: TLabel
              Left = 24
              Top = 75
              Width = 40
              Height = 13
              Caption = 'Client ID'
              Color = clBtnFace
              ParentColor = False
            end
            object lbBanrisulChave: TLabel
              Left = 24
              Top = 24
              Width = 51
              Height = 13
              Caption = 'Chave PIX'
              Color = clBtnFace
              ParentColor = False
            end
            object imBanrisulErroChavePix: TImage
              Left = 871
              Top = 43
              Width = 16
              Height = 17
              Anchors = [akTop, akRight]
              Visible = False
            end
            object lbBanrisulSenhaCertificado: TLabel
              Left = 688
              Top = 181
              Width = 84
              Height = 13
              Caption = 'Senha Certificado'
              Color = clBtnFace
              ParentColor = False
            end
            object sbBanrisulVerSenhaPFX: TSpeedButton
              Left = 871
              Top = 197
              Width = 24
              Height = 23
              AllowAllUp = True
              Anchors = [akTop, akRight]
              GroupIndex = 1
              Flat = True
              OnClick = sbBanrisulVerSenhaPFXClick
            end
            object sbBanrisulAcharCertificadoPFX: TSpeedButton
              Left = 651
              Top = 197
              Width = 24
              Height = 23
              Anchors = [akTop, akRight]
              Flat = True
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              OnClick = sbBanrisulAcharCertificadoPFXClick
            end
            object lbBanrisulArqCertificadoPFX: TLabel
              Left = 24
              Top = 181
              Width = 112
              Height = 13
              Caption = 'Arquivo Certificado PFX'
              Color = clBtnFace
              ParentColor = False
            end
            object lbBanrisulErroCertificadoPFX: TLabel
              Left = 24
              Top = 222
              Width = 134
              Height = 13
              Caption = 'lbBanrisulErroCertificadoPFX'
              Color = clBtnFace
              ParentColor = False
            end
            object imBanrisulErroCertificadoPFX: TImage
              Left = 3
              Top = 200
              Width = 16
              Height = 16
              Visible = False
            end
            object edBanrisulClientSecret: TEdit
              Left = 24
              Top = 148
              Width = 847
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 3
            end
            object edBanrisulClientID: TEdit
              Left = 24
              Top = 90
              Width = 847
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 2
            end
            object edBanrisulChavePIX: TEdit
              Left = 24
              Top = 40
              Width = 668
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 0
              OnChange = edBanrisulChavePIXChange
            end
            object cbBanrisulTipoChave: TComboBox
              Left = 711
              Top = 40
              Width = 157
              Height = 21
              Style = csDropDownList
              Anchors = [akTop, akRight]
              TabOrder = 1
              TabStop = False
            end
            object edBanrisulSenhaCertificadoPFX: TEdit
              Left = 688
              Top = 197
              Width = 180
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              PasswordChar = '*'
              TabOrder = 4
              OnExit = edBanrisulSenhaCertificadoPFXExit
            end
            object edBanrisulArqCertificadoPFX: TEdit
              Left = 24
              Top = 197
              Width = 625
              Height = 23
              Anchors = [akLeft, akTop, akRight]
              AutoSize = False
              TabOrder = 5
              OnChange = edBanrisulArqCertificadoPFXChange
              OnExit = edBanrisulArqCertificadoPFXExit
            end
          end
        end
        object tsC6Bank: TTabSheet
          Caption = 'C6 Bank'
          DesignSize = (
            984
            474)
          object pnC6Bank: TPanel
            Left = 48
            Top = 72
            Width = 880
            Height = 323
            Anchors = [akLeft, akRight]
            BevelOuter = bvNone
            TabOrder = 0
            DesignSize = (
              880
              323)
            object lbC6BankTipoChave: TLabel
              Left = 680
              Top = 24
              Width = 55
              Height = 13
              Anchors = [akTop, akRight]
              Caption = 'Tipo Chave'
              Color = clBtnFace
              ParentColor = False
            end
            object lbC6BankClientSecret: TLabel
              Left = 24
              Top = 132
              Width = 60
              Height = 13
              Caption = 'Client Secret'
              Color = clBtnFace
              ParentColor = False
            end
            object lbC6BankClientID: TLabel
              Left = 24
              Top = 75
              Width = 40
              Height = 13
              Caption = 'Client ID'
              Color = clBtnFace
              ParentColor = False
            end
            object lbC6BankChave: TLabel
              Left = 24
              Top = 24
              Width = 51
              Height = 13
              Caption = 'Chave PIX'
              Color = clBtnFace
              ParentColor = False
            end
            object imC6BankErroChavePix: TImage
              Left = 844
              Top = 43
              Width = 16
              Height = 17
              Anchors = [akTop, akRight]
              Visible = False
            end
            object lbC6BankChavePrivada: TLabel
              Left = 24
              Top = 181
              Width = 109
              Height = 13
              Caption = 'Arquivo Chave Privada'
              Color = clBtnFace
              ParentColor = False
            end
            object lbC6BankErroChavePrivada: TLabel
              Left = 24
              Top = 222
              Width = 132
              Height = 13
              Caption = 'lbC6BankErroChavePrivada'
              Color = clBtnFace
              ParentColor = False
            end
            object imC6BankErroChavePrivada: TImage
              Left = 3
              Top = 200
              Width = 16
              Height = 16
              Visible = False
            end
            object btC6BankAcharChavePrivada: TSpeedButton
              Left = 844
              Top = 197
              Width = 24
              Height = 23
              Anchors = [akTop, akRight]
              Flat = True
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              OnClick = btC6BankAcharChavePrivadaClick
            end
            object btC6BankAcharCertificado: TSpeedButton
              Left = 844
              Top = 267
              Width = 24
              Height = 23
              Anchors = [akTop, akRight]
              Flat = True
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              OnClick = btC6BankAcharCertificadoClick
            end
            object imC6BankErroCertificado: TImage
              Left = 3
              Top = 271
              Width = 16
              Height = 16
              Visible = False
            end
            object lbC6BankErroCertificado: TLabel
              Left = 24
              Top = 294
              Width = 115
              Height = 13
              Caption = 'lbC6BankErroCertificado'
              Color = clBtnFace
              ParentColor = False
            end
            object lbC6BankCertificado: TLabel
              Left = 24
              Top = 251
              Width = 89
              Height = 13
              Caption = 'Arquivo Certificado'
              Color = clBtnFace
              ParentColor = False
            end
            object edC6BankClientSecret: TEdit
              Left = 24
              Top = 148
              Width = 816
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 3
            end
            object edC6BankClientID: TEdit
              Left = 24
              Top = 90
              Width = 816
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 2
            end
            object edC6BankChavePIX: TEdit
              Left = 24
              Top = 40
              Width = 639
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 0
              OnChange = edC6BankChavePIXChange
            end
            object cbC6BankTipoChave: TComboBox
              Left = 681
              Top = 40
              Width = 158
              Height = 21
              Style = csDropDownList
              Anchors = [akTop, akRight]
              TabOrder = 1
              TabStop = False
            end
            object edC6BankChavePrivada: TEdit
              Left = 24
              Top = 197
              Width = 816
              Height = 23
              Anchors = [akLeft, akTop, akRight]
              AutoSize = False
              TabOrder = 4
              Text = 'C6BankChavePrivada.key'
              OnChange = edC6BankArqsChange
              OnExit = edC6BankChavePrivadaExit
            end
            object edC6BankCertificado: TEdit
              Left = 24
              Top = 267
              Width = 816
              Height = 23
              Anchors = [akLeft, akTop, akRight]
              AutoSize = False
              TabOrder = 5
              Text = 'C6BankCertificado.pem'
              OnExit = edC6BankCertificadoExit
            end
          end
        end
        object tsAppLess: TTabSheet
          Caption = 'AppLess'
          DesignSize = (
            984
            474)
          object pnAppLess: TPanel
            Left = 48
            Top = 72
            Width = 880
            Height = 192
            Anchors = [akLeft, akRight]
            BevelOuter = bvNone
            TabOrder = 0
            DesignSize = (
              880
              192)
            object lbAppLessClientSecret: TLabel
              Left = 24
              Top = 75
              Width = 60
              Height = 13
              Caption = 'Client Secret'
              Color = clBtnFace
              ParentColor = False
            end
            object lbAppLessClientId: TLabel
              Left = 24
              Top = 24
              Width = 38
              Height = 13
              Caption = 'Client Id'
              Color = clBtnFace
              ParentColor = False
            end
            object lbAppLessHMAC: TLabel
              Left = 24
              Top = 126
              Width = 86
              Height = 13
              Caption = 'Secret Key HMAC'
              Color = clBtnFace
              ParentColor = False
            end
            object edAppLessClientSecret: TEdit
              Left = 24
              Top = 90
              Width = 816
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 1
            end
            object edAppLessClientId: TEdit
              Left = 24
              Top = 40
              Width = 816
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 0
              OnChange = edCieloChavePIXChange
            end
            object edAppLessHMAC: TEdit
              Left = 24
              Top = 141
              Width = 816
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 2
            end
          end
        end
        object tsQQPag: TTabSheet
          Caption = 'Quero Quero Pag'
          ImageIndex = 19
          DesignSize = (
            984
            474)
          object pnQQPag: TPanel
            Left = 56
            Top = 79
            Width = 880
            Height = 323
            Anchors = [akLeft, akRight]
            BevelOuter = bvNone
            TabOrder = 0
            DesignSize = (
              880
              323)
            object lbQQPagTipoChave: TLabel
              Left = 680
              Top = 24
              Width = 55
              Height = 13
              Anchors = [akTop, akRight]
              Caption = 'Tipo Chave'
              Color = clBtnFace
              ParentColor = False
            end
            object imQQPagErroChavePix: TImage
              Left = 831
              Top = 47
              Width = 16
              Height = 17
              Anchors = [akTop, akRight]
            end
            object lbQQPagClientSecret: TLabel
              Left = 24
              Top = 132
              Width = 60
              Height = 13
              Caption = 'Client Secret'
            end
            object lbQQPagClientID: TLabel
              Left = 24
              Top = 75
              Width = 40
              Height = 13
              Caption = 'Client ID'
            end
            object lbQQPagChave: TLabel
              Left = 24
              Top = 24
              Width = 51
              Height = 13
              Caption = 'Chave PIX'
            end
            object edQQPagChavePIX: TEdit
              Left = 24
              Top = 43
              Width = 641
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 0
              OnChange = edQQPagChavePIXChange
            end
            object edQQPagClientID: TEdit
              Left = 24
              Top = 94
              Width = 801
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 1
            end
            object edQQPagClientSecret: TEdit
              Left = 24
              Top = 151
              Width = 801
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 2
            end
            object cbQQPagTipoChave: TComboBox
              Left = 680
              Top = 43
              Width = 145
              Height = 21
              Anchors = [akTop, akRight]
              TabOrder = 3
            end
          end
        end
        object tsCrediSis: TTabSheet
          Caption = 'CrediSis'
          ImageIndex = 20
          DesignSize = (
            984
            474)
          object pnCrediSis: TPanel
            Left = 60
            Top = 83
            Width = 880
            Height = 323
            Anchors = [akLeft, akRight]
            BevelOuter = bvNone
            TabOrder = 0
            DesignSize = (
              880
              323)
            object lbCrediSisTipoChave: TLabel
              Left = 680
              Top = 24
              Width = 55
              Height = 13
              Anchors = [akTop, akRight]
              Caption = 'Tipo Chave'
              Color = clBtnFace
              ParentColor = False
            end
            object imCrediSisErroChavePix: TImage
              Left = 831
              Top = 47
              Width = 16
              Height = 17
              Anchors = [akTop, akRight]
            end
            object lbCrediSisClientSecret: TLabel
              Left = 24
              Top = 132
              Width = 60
              Height = 13
              Caption = 'Client Secret'
            end
            object lbCrediSisClientID: TLabel
              Left = 24
              Top = 75
              Width = 40
              Height = 13
              Caption = 'Client ID'
            end
            object lbCrediSisChavePIX: TLabel
              Left = 219
              Top = 24
              Width = 51
              Height = 13
              Caption = 'Chave PIX'
            end
            object lbCrediSisAgencia: TLabel
              Left = 24
              Top = 24
              Width = 39
              Height = 13
              Caption = 'Ag'#234'ncia'
            end
            object lbCrediSisConta: TLabel
              Left = 96
              Top = 24
              Width = 28
              Height = 13
              Caption = 'Conta'
            end
            object edCrediSisChavePIX: TEdit
              Left = 219
              Top = 43
              Width = 446
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 2
              OnChange = edCrediSisChavePIXChange
            end
            object edCrediSisClientID: TEdit
              Left = 24
              Top = 94
              Width = 801
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 4
            end
            object edCrediSisClientSecret: TEdit
              Left = 24
              Top = 151
              Width = 801
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 5
            end
            object cbCrediSisTipoChave: TComboBox
              Left = 680
              Top = 43
              Width = 145
              Height = 21
              Anchors = [akTop, akRight]
              TabOrder = 3
            end
            object edCrediSisAgencia: TEdit
              Left = 24
              Top = 43
              Width = 60
              Height = 21
              TabOrder = 0
              OnChange = edQQPagChavePIXChange
            end
            object edCrediSisConta: TEdit
              Left = 96
              Top = 43
              Width = 109
              Height = 21
              TabOrder = 1
              OnChange = edQQPagChavePIXChange
            end
          end
        end
      end
    end
  end
  object ImageList1: TImageList
    Left = 112
    Top = 480
    Bitmap = {
      494C010122002700040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000009000000001002000000000000090
      0000000000000000000000000000000000000000000000000000000000000000
      0000F2C4F200B2B2B200737373003D3D3D003D3D3D0073737300B2B2B200F5B2
      F500000000000000000000000000000000000000000000000000000000000000
      0000FB83FB00BBBBBB0094949400585858005858580094949400BBBBBB00FB83
      FB00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000AFAF
      AF0055555500BDBDBD00E8E8E8000000000000000000E8E8E800BDBDBD005555
      5500B0B0B000000000000000000000000000000000000000000000000000C5C5
      C500353535006A6A6A00A3A3A300C5C5C500C5C5C500A3A3A3006A6A6A003535
      3500C5C5C5000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008C8C8C009A9A
      9A00000000000000000000000000000000000000000000000000000000000000
      0000999999008D8D8D0000000000000000000000000000000000939393002E2E
      2E00C3C3C3000000000000000000E4E4E400E4E4E4000000000000000000C3C3
      C3002E2E2E009393930000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AEAEAE009A9A9A000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000098989800B0B0B0000000000000000000C5C5C5002E2E2E00E8E8
      E8000000000000000000000000009E9E9E009E9E9E0000000000000000000000
      0000E8E8E8002E2E2E00C5C5C500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F2C4F20056565600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000055555500F5B2F500FB83FB0035353500C3C3C3000000
      00000000000000000000D6D6D6004040400045454500E2E2E200000000000000
      000000000000C3C3C30035353500FB83FB000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B1B1B100BDBDBD00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000BCBCBC00B2B2B200BBBBBB006A6A6A00000000000000
      000000000000000000001C1C1C00A0A0A000A9A9A90038383800000000000000
      000000000000000000006A6A6A00BCBCBC000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000071717100EBE2EB00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000E8E8E8007373730094949400A3A3A300000000000000
      000000000000D6D6D60000000000000000000000000000000000FB83FB000000
      00000000000000000000A3A3A300949494000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004040400000000000000000000000
      0000C5C5C500B6B6B600B6B6B600B6B6B600B6B6B600B6B6B600B6B6B600C5C5
      C5000000000000000000000000004242420058585800C5C5C500000000000000
      0000000000000000000000000000CECECE00717171007E7E7E00000000000000
      00000000000000000000C5C5C500585858000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003D3D3D0000000000000000000000
      0000CACACA00C1C1C100C1C1C100C1C1C100C1C1C100C1C1C100C1C1C100CACA
      CA000000000000000000000000004040400058585800C5C5C500000000000000
      00000000000000000000A9A9A9002E2E2E00A3A3A30000000000000000000000
      00000000000000000000C5C5C500585858000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000071717100EBE2EB00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000E8E8E8007373730094949400A3A3A300000000000000
      000000000000FB83FB0000000000E4E4E400000000009E9E9E00E4E4E4000000
      00000000000000000000A3A3A300949494000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B0B0B000BEBEBE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000BDBDBD00B2B2B200BBBBBB006A6A6A00000000000000
      0000000000000000000000000000D0D0D000CACACA0000000000EED4EE000000
      000000000000000000006A6A6A00BCBCBC000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F2C4F20058585800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000056565600F2C4F200FB83FB0035353500C3C3C3000000
      00000000000000000000CBCBCB001C1C1C0000000000ADADAD00000000000000
      000000000000C3C3C30035353500FB83FB000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000ADADAD009B9B9B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009A9A9A00AFAFAF000000000000000000C5C5C5002E2E2E00E8E8
      E8000000000000000000000000009B9B9B009797970000000000000000000000
      0000E8E8E8002E2E2E00C5C5C500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008B8B8B009B9B
      9B00000000000000000000000000000000000000000000000000000000000000
      00009A9A9A008C8C8C0000000000000000000000000000000000939393002E2E
      2E00C3C3C3000000000000000000E4E4E400E4E4E4000000000000000000C3C3
      C3002E2E2E009393930000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000ADAD
      AD0056565600BEBEBE00EBE2EB000000000000000000E8E8E800BEBEBE005656
      5600AEAEAE00000000000000000000000000000000000000000000000000C5C5
      C500353535006A6A6A00A3A3A300C5C5C500C5C5C500A3A3A3006A6A6A003535
      3500C5C5C5000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F2C4F200B0B0B000727272003B3B3B003B3B3B0072727200B0B0B000F2C4
      F200000000000000000000000000000000000000000000000000000000000000
      0000FB83FB00BBBBBB0094949400585858005858580094949400BBBBBB00FB83
      FB00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F2C4F200B2B2B200737373003D3D3D003D3D3D0073737300B2B2B200F5B2
      F500000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000AFAF
      AF0055555500BDBDBD00E8E8E8000000000000000000E8E8E800BDBDBD005555
      5500B0B0B0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D7D7D7002A2A2A000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000016161600D7D7D700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D6D6D600D5D5
      D500D5D5D50000000000000000000000000000000000000000008C8C8C009A9A
      9A00000000000000000000000000000000000000000000000000000000000000
      0000999999008D8D8D0000000000000000000000000000000000FB83FB00BDBD
      BD00A2A2A200AEAEAE00DDDDDD00000000000000000000000000E5E5E5009C9C
      9C009C9C9C009C9C9C00C5C5C50000000000000000009F9F9F0081818100D5D5
      D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5
      D500D5D5D500818181009F9F9F00000000000000000000000000000000004B4B
      4B00C3C3C3000000000000000000000000000000000000000000BDBDBD000000
      000000000000D5D5D500000000000000000000000000AEAEAE009A9A9A000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000098989800B0B0B0000000000000000000CCCCCC00404040006262
      62009696960081818100222222009B9B9B000000000000000000D5D5D5002A2A
      2A00979797005D5D5D009C9C9C0000000000000000009C9C9C009C9C9C00E5E5
      E500D5D5D500D5D5D500E5E5E500000000000000000000000000000000000000
      0000000000009C9C9C009C9C9C0000000000000000000000000000000000C3C3
      C3002A2A2A00C2C2C20000000000000000000000000000000000C6C6C6000D0D
      0D0000000000D5D5D5000000000000000000F2C4F20056565600000000000000
      0000000000000000000000000000C7C7C700C7C7C70000000000000000000000
      0000000000000000000055555500F5B2F500DFDFDF002A2A2A00BABABA000000
      00000000000000000000E1E1E1004F4F4F00ABABAB0000000000D0D0D0004D4D
      4D00000000009C9C9C009898980000000000000000009C9C9C009C9C9C00A3A3
      A3004242420042424200A3A3A300000000000000000000000000000000000000
      0000000000009C9C9C009C9C9C00000000000000000000000000000000000000
      0000C5C5C5001C1C1C00C2C2C2000000000000000000C4C4C40022222200C4C4
      C400BDBDBD00D6D6D6000000000000000000B1B1B100BDBDBD00000000000000
      0000000000000000000000000000BBBBBB00BBBBBB0000000000000000000000
      00000000000000000000BCBCBC00B2B2B2008F8F8F009393930000000000AFAF
      AF00515151008282820000000000CECECE001616160042424200353535004D4D
      4D00000000009C9C9C002222220042424200000000009C9C9C009C9C9C000000
      00000000000000000000000000000000000000000000ADADAD00CBCBCB000000
      0000000000009C9C9C009C9C9C00000000000000000000000000000000000000
      000000000000C6C6C6002E2E2E00C2C2C20000000000A7A7A700C2C2C2000000
      00000000000000000000000000000000000071717100EBE2EB00000000000000
      0000000000000000000000000000BBBBBB00BBBBBB0000000000000000000000
      00000000000000000000E8E8E8007373730040404000CCCCCC00E4E4E4002626
      2600C0C0C00065656500B0B0B00000000000D5D5D500D5D5D500D5D5D500D9D9
      D90000000000E5E5E500B2B2B20000000000000000009C9C9C009C9C9C00C5C5
      C5009C9C9C009C9C9C00C5C5C50000000000ABABAB001C1C1C0022222200CDCD
      CD00000000009C9C9C009C9C9C00000000000000000000000000000000000000
      00000000000000000000C2C2C20026262600C5C5C50000000000000000000000
      0000000000000000000000000000000000004040400000000000000000000000
      0000C5C5C500B6B6B600B6B6B6008484840084848400B6B6B600B6B6B600C5C5
      C5000000000000000000000000004242420040404000CCCCCC00E4E4E4002626
      2600C0C0C00065656500B0B0B00000000000D5D5D500D5D5D500D5D5D500D5D5
      D500D5D5D500D5D5D500B2B2B20000000000000000009C9C9C009C9C9C00C5C5
      C5009C9C9C009C9C9C00C5C5C50000000000CECECE00D9D9D900BDBDBD002A2A
      2A00CBCBCB009B9B9B009C9C9C00000000000000000000000000000000000000
      0000000000000000000000000000C5C5C50026262600C2C2C200000000000000
      0000000000000000000000000000000000003D3D3D0000000000000000000000
      0000CACACA00C1C1C100C1C1C1008D8D8D008D8D8D00C1C1C100C1C1C100CACA
      CA00000000000000000000000000404040008F8F8F009393930000000000AFAF
      AF00515151008282820000000000CECECE001616160042424200424242004242
      420042424200424242004242420042424200000000009C9C9C009C9C9C000000
      000000000000000000000000000000000000000000000000000000000000BBBB
      BB00BFBFBF009B9B9B009C9C9C00000000000000000000000000000000000000
      000000000000C6C6C600A7A7A70000000000C2C2C2002A2A2A00C2C2C2000000
      00000000000000000000000000000000000071717100EBE2EB00000000000000
      0000000000000000000000000000BBBBBB00BBBBBB0000000000000000000000
      00000000000000000000E8E8E80073737300E0E0E0002A2A2A00B7B7B7000000
      00000000000000000000DFDFDF0045454500AFAFAF0000000000000000000000
      000000000000000000000000000000000000000000009C9C9C009C9C9C009C9C
      9C0000000000000000009C9C9C00000000000000000000000000000000000000
      0000000000009C9C9C009C9C9C00000000000000000000000000000000000000
      0000C2C2C20016161600C5C5C5000000000000000000C5C5C5001C1C1C00C1C1
      C100B9B9B900D6D6D6000000000000000000B0B0B000BEBEBE00000000000000
      0000000000000000000000000000BBBBBB00BBBBBB0000000000000000000000
      00000000000000000000BDBDBD00B2B2B20000000000CCCCCC00404040006262
      62009696960081818100222222009C9C9C000000000000000000000000000000
      000000000000000000000000000000000000000000009C9C9C009C9C9C00E5E5
      E500D5D5D500D5D5D500E5E5E500000000000000000000000000000000000000
      0000000000009C9C9C009C9C9C0000000000000000000000000000000000C3C3
      C3002A2A2A00C2C2C20000000000000000000000000000000000C4C4C4000000
      000000000000D5D5D5000000000000000000F2C4F20058585800000000000000
      0000000000000000000000000000C7C7C700C7C7C70000000000000000000000
      0000000000000000000056565600F2C4F2000000000000000000FB83FB00BDBD
      BD00A2A2A200AEAEAE00DDDDDD00000000000000000000000000000000000000
      000000000000000000000000000000000000000000009F9F9F0081818100D5D5
      D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5
      D500D5D5D500818181009F9F9F00000000000000000000000000000000004B4B
      4B00C3C3C3000000000000000000000000000000000000000000BDBDBD000000
      000000000000D5D5D500000000000000000000000000ADADAD009B9B9B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009A9A9A00AFAFAF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D8D8D800515151004242
      4200424242004242420042424200424242004242420042424200424242004242
      4200424242004B4B4B00D8D8D800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D6D6D600D5D5
      D500D5D5D50000000000000000000000000000000000000000008B8B8B009B9B
      9B00000000000000000000000000000000000000000000000000000000000000
      00009A9A9A008C8C8C0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000ADAD
      AD0056565600BEBEBE00EBE2EB000000000000000000E8E8E800BEBEBE005656
      5600AEAEAE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F2C4F200B0B0B000727272003B3B3B003B3B3B0072727200B0B0B000F2C4
      F200000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000E8E8E800EBE2EB0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000BFBF
      BF009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C00BBBBBB000000000000000000000000000000000000000000000000000000
      000000000000E0E0E000898989001C1C1C00353535008F8F8F00E4E4E4000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E4E4E400BCBCBC00A1A1A100A3A3A300BEBEBE00E6E6E6000000
      0000000000000000000000000000000000000000000000000000ADADAD006262
      62005D5D5D005D5D5D005D5D5D005D5D5D005D5D5D005D5D5D005D5D5D005D5D
      5D005F5F5F00B4B4B40000000000000000000000000000000000DADADA001616
      1600000000000000000000000000000000000000000000000000000000000000
      000032323200E3E3E30000000000000000000000000000000000000000000000
      0000CFCFCF00474747000000000000000000DEDEDE008D8D8D0051515100D5D5
      D500000000000000000000000000000000000000000000000000000000000000
      00009B9B9B003D3D3D007575750097979700969696007171710040404000A1A1
      A1000000000000000000000000000000000000000000000000005F5F5F000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000006565650000000000000000000000000000000000D5D5D5000000
      000082828200CACACA004D4D4D00B2B2B200B2B2B2004D4D4D00CACACA008282
      82001C1C1C00DBDBDB000000000000000000000000000000000000000000E0E0
      E000323232000000000000000000000000000000000000000000ACACAC004040
      4000E6E6E6000000000000000000000000000000000000000000000000007878
      780068686800DBDBDB0000000000000000000000000000000000D7D7D7005F5F
      5F008383830000000000000000000000000000000000000000005D5D5D000000
      0000000000009C9C9C00D5D5D500D5D5D5009C9C9C00000000005D5D5D000000
      0000000000005D5D5D0000000000000000000000000000000000D5D5D5000000
      000082828200CACACA004D4D4D00D5D5D500D5D5D5004D4D4D00CACACA008282
      82001C1C1C00DBDBDB0000000000000000000000000000000000000000007070
      7000000000000000000000000000000000000000000000000000000000009292
      92007979790000000000000000000000000000000000000000009B9B9B006868
      6800000000000000000000000000E5E5E500E5E5E50000000000000000000000
      00005D5D5D00A4A4A400000000000000000000000000000000005D5D5D000000
      00009C9C9C005D5D5D0081818100818181005D5D5D0094949400353535000000
      0000000000005F5F5F0000000000000000000000000000000000D5D5D5000000
      000035353500585858001C1C1C00CACACA00CACACA001C1C1C00585858003535
      35001C1C1C00DBDBDB0000000000000000000000000000000000CDCDCD001616
      160000000000000000000000000000000000000000000000000000000000F5B2
      F50035353500D4D4D400000000000000000000000000E4E4E4003D3D3D00DBDB
      DB00000000000000000000000000ABABAB00ABABAB0000000000000000000000
      0000D5D5D50042424200EBE2EB00000000000000000000000000888888000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008D8D8D0000000000000000000000000000000000D5D5D5000000
      000094949400E6E6E600585858004D4D4D004D4D4D0058585800E6E6E6009494
      94001C1C1C00DBDBDB0000000000000000000000000000000000949494000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000909090009F9F9F00000000000000000000000000BCBCBC00757575000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000066666600C5C5C50000000000000000000000000000000000D9D9
      D900D5D5D500D5D5D500D5D5D500D5D5D500D5D5D500CACACA004D4D4D00B2B2
      B200DBDBDB000000000000000000000000000000000000000000D5D5D5000000
      00009C9C9C00000000005D5D5D00B2B2B200B2B2B2005D5D5D00000000009C9C
      9C001C1C1C00DBDBDB00000000000000000000000000000000006D6D6D000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C2C2C20076767600000000000000000000000000A2A2A200979797000000
      0000000000000000000000000000C5C5C500C5C5C50000000000000000000000
      0000000000008E8E8E00ACACAC00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000005D5D5D00D5D5
      D500000000000000000000000000000000000000000000000000D5D5D5000000
      000082828200CACACA004D4D4D00B2B2B200B2B2B2004D4D4D00CACACA008282
      82001C1C1C00DBDBDB00000000000000000000000000000000005D5D5D00D5D5
      D500000000000000000000000000000000000000000000000000000000000000
      00000000000063636300000000000000000000000000A3A3A300969696000000
      00000000000000000000000000009C9C9C009C9C9C0000000000000000000000
      0000000000008D8D8D00ADADAD00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007E7E7E00DBDB
      DB00000000000000000000000000000000000000000000000000D5D5D5000000
      0000000000000000000000000000000000000000000000000000000000000000
      00001C1C1C00DBDBDB00000000000000000000000000000000005D5D5D00D5D5
      D500000000000000000000000000000000000000000000000000000000000000
      0000000000005D5D5D00000000000000000000000000BEBEBE00717171000000
      00000000000000000000000000009C9C9C009C9C9C0000000000000000000000
      00000000000063636300C7C7C700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000DEDEDE002626
      2600000000000000000000000000000000000000000000000000000000000000
      00001C1C1C00DBDBDB00000000000000000000000000000000005D5D5D00D5D5
      D500000000000000000000000000000000000000000000000000000000000000
      0000000000005D5D5D00000000000000000000000000E6E6E60040404000D7D7
      D7000000000000000000000000009C9C9C009C9C9C0000000000000000000000
      0000D1D1D10047474700F2C4F200000000000000000000000000000000000000
      000000000000000000000000000000000000DEDEDE009A9A9A00CACACA00B2B2
      B200B6B6B600000000000000000000000000000000000000000000000000C0C0
      C000000000000000000000000000000000000000000000000000000000000000
      00001C1C1C00DBDBDB00000000000000000000000000000000005D5D5D00CECE
      CE00000000000000000000000000000000000000000000000000000000000000
      0000000000005D5D5D0000000000000000000000000000000000A1A1A1005F5F
      5F00000000000000000000000000E5E5E500E5E5E5000000000000000000FB83
      FB0055555500AAAAAA0000000000000000000000000000000000000000000000
      0000000000000000000000000000CDCDCD00C0C0C000DBDBDB00C4C4C400D2D2
      D200D5D5D500B1B1B10000000000000000000000000000000000000000000000
      0000C0C0C0002626260000000000000000000000000000000000000000000000
      00001C1C1C00DBDBDB0000000000000000000000000000000000868686002A2A
      2A0097979700DFDFDF0000000000000000000000000000000000000000000000
      0000262626008888880000000000000000000000000000000000000000008181
      81005D5D5D00D5D5D50000000000000000000000000000000000D1D1D1005555
      55008C8C8C000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C7C7C700949494009C9C9C009595
      9500B4B4B4000000000000000000000000000000000000000000000000000000
      000000000000BFBFBF002E2E2E00000000000000000000000000000000000000
      00002E2E2E00E1E1E1000000000000000000000000000000000000000000D6D6
      D6008B8B8B004040400083838300CFCFCF000000000000000000383838008F8F
      8F00D9D9D9000000000000000000000000000000000000000000000000000000
      0000A4A4A40042424200666666008E8E8E008D8D8D006363630047474700AAAA
      AA00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C7C7C7009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C00CBCBCB000000000000000000000000000000000000000000000000000000
      000000000000E2E2E200A3A3A3004242420047474700A7A7A700E4E4E4000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000EBE2EB00C5C5C500ACACAC00ADADAD00C7C7C700F2C4F2000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FD5FFD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E5E5E500D5D5D500D5D5D500D5D5D500D5D5D500E5E5E5000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000ABABAB005D5D5D005D5D5D005D5D5D005D5D5D00ABABAB000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000DDDDDD00D5D5
      D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5
      D500D5D5D500DBDBDB0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C0C0C00080808000636363006363630083838300C5C5C5000000
      0000000000000000000000000000000000000000000000000000ADADAD006262
      62005D5D5D005D5D5D005D5D5D005D5D5D005D5D5D005D5D5D005D5D5D005D5D
      5D005F5F5F00B4B4B400000000000000000000000000B8B8B800222222000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000001C1C1C00C7C7C700000000000000000000000000000000000000
      0000D8D8D800A0A0A0009C9C9C009C9C9C009C9C9C009C9C9C009E9E9E00D9D9
      D900000000000000000000000000000000000000000000000000000000000000
      0000767676004B4B4B00AEAEAE00D1D1D100D0D0D000AAAAAA00454545007E7E
      7E000000000000000000000000000000000000000000000000005F5F5F00B2B2
      B200D5D5D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5
      D500B2B2B200656565000000000000000000000000009C9C9C00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009C9C9C00000000000000000000000000000000000000
      00002E2E2E000000000000000000000000000000000000000000000000005A5A
      5A00000000000000000000000000000000000000000000000000000000007676
      7600838383000000000000000000000000000000000000000000FD5FFD007A7A
      7A008080800000000000000000000000000000000000000000005D5D5D00D5D5
      D500000000000000000000000000000000000000000000000000000000000000
      0000D5D5D5005D5D5D000000000000000000000000009C9C9C00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009C9C9C00000000000000000000000000000000000000
      0000000000004D4D4D005D5D5D005D5D5D005D5D5D005D5D5D004D4D4D000000
      0000000000000000000000000000000000000000000000000000C0C0C0004B4B
      4B0000000000000000000000000000000000000000000000000000000000FB83
      FB0040404000C8C8C800000000000000000000000000000000005D5D5D00D5D5
      D500000000000000000000000000000000000000000000000000000000000000
      0000D5D5D5005D5D5D000000000000000000000000009C9C9C00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009C9C9C00000000000000000000000000000000000000
      000000000000CACACA0000000000000000000000000000000000CACACA000000
      000000000000000000000000000000000000000000000000000080808000AEAE
      AE00000000000000000000000000000000000000000000000000000000000000
      0000A3A3A3008B8B8B00000000000000000000000000000000005D5D5D00D5D5
      D500000000000000000000000000000000000000000000000000000000000000
      0000D5D5D5005D5D5D000000000000000000000000009C9C9C00000000000000
      0000000000000000000022222200A8A8A800A1A1A10016161600000000000000
      000000000000000000009C9C9C00000000000000000000000000000000000000
      000000000000D5D5D50000000000000000000000000000000000D5D5D5000000
      000000000000000000000000000000000000000000000000000063636300D1D1
      D100000000000000000000000000C5C5C500C5C5C50000000000000000000000
      0000C9C9C9006C6C6C00000000000000000000000000000000005D5D5D008686
      8600D1D1D100CDCDCD00A3A3A300D0D0D000CBCBCB00A3A3A300CFCFCF00CDCD
      CD00858585005D5D5D000000000000000000000000009C9C9C00000000000000
      0000161616007E7E7E00E1E1E100FB83FB0000000000DDDDDD00767676000D0D
      0D0000000000000000009C9C9C00000000000000000000000000000000000000
      000000000000D5D5D50000000000000000000000000000000000D5D5D5000000
      000000000000000000000000000000000000000000000000000060606000D2D2
      D2000000000000000000000000009C9C9C009C9C9C0000000000000000000000
      0000C7C7C7006A6A6A00000000000000000000000000C8C8C800323232008787
      87001C1C1C0035353500838383002A2A2A0032323200838383002A2A2A002626
      26008787870032323200D4D4D40000000000000000009C9C9C00000000004D4D
      4D00C0C0C00000000000C4C4C400515151005A5A5A00CACACA0000000000BBBB
      BB0047474700000000009C9C9C00000000000000000000000000000000000000
      000000000000D5D5D50000000000000000000000000000000000D5D5D5000000
      000000000000000000000000000000000000000000000000000080808000ADAD
      AD000000000000000000000000009C9C9C009C9C9C0000000000000000000000
      00009E9E9E008A8A8A000000000000000000000000009F9F9F008F8F8F000000
      00008585850093939300000000008B8B8B009393930000000000858585009393
      93000000000085858500AFAFAF0000000000000000009C9C9C0072727200EBE2
      EB00E1E1E100858585001616160000000000000000001C1C1C008D8D8D00E5E5
      E500E6E6E600707070009C9C9C00000000000000000000000000000000000000
      000000000000D5D5D50000000000000000000000000000000000D5D5D5000000
      0000000000000000000000000000000000000000000000000000C3C3C3004949
      4900FB83FB0000000000000000009C9C9C009C9C9C000000000000000000EBE2
      EB003B3B3B00CBCBCB00000000000000000000000000B9B9B9007C7C7C000000
      0000A9A9A9008C8C8C00000000009C9C9C009C9C9C000000000080808000B3B3
      B300000000006E6E6E00C3C3C30000000000000000009C9C9C008F8F8F00B2B2
      B200383838000000000000000000000000000000000000000000000000004040
      4000B9B9B900919191009C9C9C00000000000000000000000000000000000000
      000000000000D5D5D50000000000000000000000000000000000D5D5D5000000
      0000000000000000000000000000000000000000000000000000000000007C7C
      7C008A8A8A0000000000000000009C9C9C009C9C9C0000000000000000008080
      80008686860000000000000000000000000000000000DCDCDC003B3B3B000000
      0000BEBEBE0076767600000000009C9C9C009C9C9C00000000006D6D6D00C7C7
      C700F89DF8002E2E2E00E2E2E2000000000000000000C4C4C400262626000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000032323200C4C4C400000000000000000000000000000000000000
      000000000000B2B2B200D5D5D500D5D5D500D5D5D500D5D5D500B2B2B2000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000EBE2EB0000000000000000009C9C9C009C9C9C000000000000000000EBE2
      EB0000000000000000000000000000000000000000000000000058585800BABA
      BA00ADADAD0053535300CDCDCD008282820082828200C9C9C90049494900B3B3
      B300B0B0B0006363630000000000000000000000000000000000DEDEDE00D5D5
      D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5
      D500D5D5D500E3E3E30000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000D0D
      0D00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000ABABAB00ABABAB0000000000000000000000
      0000000000000000000000000000000000000000000000000000BABABA006C6C
      6C00686868006868680068686800686868006868680068686800686868006868
      68006C6C6C00C0C0C00000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007F7F7F000000000000000000000000000000000000000000000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000DEDEDE00DDDDDD00DDDDDD00DDDDDD00DDDDDD00E1E1E1000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E4E4E400BCBCBC00A2A2A200A3A3A300BEBEBE00E6E6E6000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E4E4E400BCBCBC00A2A2A200A3A3A300BEBEBE00E6E6E6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009B9B9B0035353500000000000000000000000000000000003B3B3B00A1A1
      A100000000000000000000000000000000000000000000000000000000000000
      00009B9B9B0035353500000000000000000000000000000000003B3B3B00A0A0
      A00000000000000000000000000000000000000000000000000000000000D7D7
      D700D5D5D500D5D5D500D5D5D500DADADA000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007979
      7900000000000000000000000000000000000000000000000000000000000000
      0000828282000000000000000000000000000000000000000000000000007878
      7800000000000000000000000000000000000000000000000000000000000000
      0000828282000000000000000000000000000000000000000000808080000D0D
      0D0000000000000000000000000016161600C7C7C70000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009B9B9B000000
      00000000000000000000666666002A2A2A000000000000000000000000000000
      000000000000A4A4A400000000000000000000000000000000009B9B9B000000
      00000D0D0D006A6A6A001C1C1C00000000000000000022222200696969000D0D
      0D0000000000A4A4A400000000000000000000000000000000005D5D5D000000
      0000000000000000000000000000000000009C9C9C00000000005D5D5D000000
      00009C9C9C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E4E4E400353535000000
      0000000000009191910000000000C0C0C0001C1C1C0000000000000000000000
      00000000000040404000EBE2EB000000000000000000E4E4E400353535000000
      00006A6A6A0000000000B2B2B2001C1C1C0022222200B9B9B900000000005F5F
      5F000000000040404000EBE2EB000000000000000000000000005D5D5D000000
      0000000000000000000000000000000000009C9C9C0000000000DBDBDB00D5D5
      D500E5E5E5000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BCBCBC00000000000000
      00008F8F8F0000000000E2E2E20000000000BEBEBE0022222200000000000000
      00000000000000000000C5C5C5000000000000000000BCBCBC00000000000000
      00001C1C1C00B2B2B20000000000B2B2B200BABABA0000000000AAAAAA001616
      16000000000000000000C5C5C5000000000000000000000000005D5D5D000000
      0000000000000000000000000000000000009C9C9C0000000000DBDBDB00D5D5
      D500D5D5D500DBDBDB0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A2A2A200000000008686
      860000000000CECECE0040404000A6A6A60000000000BEBEBE001C1C1C000000
      00000000000000000000ACACAC000000000000000000A2A2A200000000000000
      0000000000001C1C1C00B2B2B2000000000000000000A9A9A900161616000000
      00000000000000000000ACACAC000000000000000000000000005D5D5D000000
      0000000000000000000000000000000000009C9C9C00000000005D5D5D000000
      0000000000005D5D5D0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A3A3A300000000007D7D
      7D00C6C6C600262626000000000000000000A6A6A60000000000C0C0C0002A2A
      2A000000000000000000ADADAD000000000000000000A3A3A300000000000000
      00000000000022222200BABABA000000000000000000B2B2B2001C1C1C000000
      00000000000000000000ADADAD000000000000000000000000005D5D5D000000
      0000000000000000000000000000000000009C9C9C0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BEBEBE00000000000000
      00000000000000000000000000000000000016161600A8A8A80000000000C0C0
      C0001C1C1C0000000000C7C7C7000000000000000000BEBEBE00000000000000
      000022222200B9B9B90000000000A9A9A900B2B2B20000000000B2B2B2001C1C
      1C000000000000000000C7C7C7000000000000000000000000005D5D5D000000
      0000000000000000000000000000000000009C9C9C0000000000ABABAB009C9C
      9C009C9C9C009C9C9C00C5C5C500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E6E6E6003B3B3B000000
      0000000000000000000000000000000000000000000016161600A8A8A8000000
      0000A3A3A30045454500F2C4F2000000000000000000E6E6E6003B3B3B000000
      00006969690000000000AAAAAA00161616001C1C1C00B2B2B200FB83FB005D5D
      5D000000000045454500F2C4F200000000000000000000000000ABABAB009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C00C5C5C50000000000ABABAB009C9C
      9C009C9C9C009C9C9C00C5C5C500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A1A1A1000000
      0000000000000000000000000000000000000000000000000000161616009595
      950047474700AAAAAA0000000000000000000000000000000000A0A0A0000000
      00000D0D0D005F5F5F001616160000000000000000001C1C1C005D5D5D000D0D
      0D0000000000AAAAAA00000000000000000000000000C5C5C5009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C00E5E5E500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008282
      8200000000000000000000000000000000000000000000000000000000000000
      00008B8B8B000000000000000000000000000000000000000000000000008181
      8100000000000000000000000000000000000000000000000000000000000000
      00008A8A8A0000000000000000000000000000000000C5C5C5009C9C9C007979
      7900000000000000000026262600929292009C9C9C00E5E5E500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000A4A4A400404040000000000000000000000000000000000045454500AAAA
      AA00000000000000000000000000000000000000000000000000000000000000
      0000A4A4A400404040000000000000000000000000000000000045454500AAAA
      AA00000000000000000000000000000000000000000000000000000000000000
      0000D5D5D500D5D5D500DEDEDE00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000EBE2EB00C5C5C500ADADAD00ADADAD00C7C7C700F2C4F2000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000EBE2EB00C5C5C500ADADAD00ADADAD00C7C7C700F2C4F2000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000D4D4D400D2D2D200D2D2D200D2D2D200D2D2D200D2D2D200D2D2
      D200D4D4D400E5E5E50000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000727272005555550068686800686868006868680068686800686868006868
      6800555555000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00005D5D5D00D5D5D50000000000000000000000000000000000000000000000
      0000D4D4D4001C1C1C00FD5FFD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000DDDDDD00D5D5
      D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5
      D500D5D5D500DBDBDB0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00005D5D5D00D5D5D50000000000000000000000000000000000000000000000
      0000D4D4D4001C1C1C00FD5FFD00000000000000000000000000000000000000
      000000000000DBDBDB0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B6B6B600222222000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000001C1C1C00C7C7C700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E5E5E500E2E2E2000000
      00005D5D5D00D5D5D50000000000000000000000000000000000000000000000
      0000D4D4D4001C1C1C00FD5FFD00000000000000000000000000000000000000
      0000000000009C9C9C0063636300D7D7D7000000000000000000000000000000
      000000000000000000000000000000000000000000009C9C9C009C9C9C000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009C9C9C009C9C9C000000000000000000C5C5C5009C9C9C009C9C
      9C009C9C9C009C9C9C00B1B1B100000000000000000000000000000000000000
      000000000000C3C3C300DBDBDB000000000000000000A7A7A700989898000000
      00005D5D5D00D5D5D50000000000000000000000000000000000000000000000
      0000D4D4D4001C1C1C00FD5FFD00000000000000000000000000000000000000
      0000000000009C9C9C000000000016161600A3A3A300FB83FB00000000000000
      000000000000000000000000000000000000000000009C9C9C009C9C9C000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009C9C9C009C9C9C0000000000000000009C9C9C00000000000000
      0000000000005C5C5C00E1E1E100000000000000000000000000000000000000
      0000DFDFDF00323232009F9F9F000000000000000000A7A7A700989898000000
      00005D5D5D00D5D5D50000000000000000000000000000000000000000000000
      0000D4D4D4001C1C1C00FD5FFD00000000000000000000000000000000000000
      0000000000009C9C9C0000000000000000000000000060606000CACACA000000
      000000000000000000000000000000000000000000009C9C9C009C9C9C000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009C9C9C009C9C9C0000000000000000009C9C9C00000000000000
      000035353500DCDCDC000000000000000000000000000000000000000000F5B2
      F500626262004B4B4B00E8E8E8000000000000000000A7A7A700989898000000
      00005D5D5D00D5D5D50000000000000000000000000000000000000000000000
      0000D4D4D4001C1C1C00FD5FFD00000000000000000000000000000000000000
      0000000000009C9C9C0000000000000000000000000000000000222222008C8C
      8C00FB83FB00000000000000000000000000000000009C9C9C009C9C9C000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009C9C9C009C9C9C0000000000000000009C9C9C00000000003D3D
      3D000D0D0D0073737300CFCFCF000000000000000000E8E8E800B7B7B7004040
      400045454500D5D5D500000000000000000000000000A7A7A700989898000000
      00005D5D5D00D5D5D50000000000000000000000000000000000000000000000
      0000D4D4D4001C1C1C00FD5FFD00000000000000000000000000000000000000
      0000000000009C9C9C0000000000000000000000000000000000262626009797
      970000000000000000000000000000000000000000009C9C9C00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009C9C9C0000000000000000009C9C9C0063636300E3E3
      E300BBBBBB005656560000000000161616003535350000000000222222007E7E
      7E00E0E0E00000000000000000000000000000000000A7A7A700989898000000
      00005D5D5D00D5D5D50000000000000000000000000000000000000000000000
      0000D4D4D4001C1C1C00FD5FFD00000000000000000000000000000000000000
      0000000000009C9C9C000000000000000000000000006A6A6A00D2D2D2000000
      000000000000000000000000000000000000000000009C9C9C00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009C9C9C000000000000000000B5B5B500E5E5E5000000
      00000000000000000000CECECE00AEAEAE00A8A8A800BBBBBB00DDDDDD000000
      00000000000000000000000000000000000000000000A7A7A700989898000000
      00005D5D5D00D5D5D50000000000000000000000000000000000000000000000
      0000D4D4D4001C1C1C00FD5FFD00000000000000000000000000000000000000
      0000000000009C9C9C000000000022222200ADADAD0000000000000000000000
      000000000000000000000000000000000000000000009C9C9C005D5D5D009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C005D5D5D009C9C9C00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A7A7A700989898000000
      0000717171004B4B4B005C5C5C005C5C5C005C5C5C005C5C5C005C5C5C005C5C
      5C00494949001616160000000000000000000000000000000000000000000000
      0000000000009C9C9C0071717100DDDDDD000000000000000000000000000000
      000000000000000000000000000000000000000000009C9C9C009C9C9C000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009C9C9C009C9C9C00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A7A7A700989898000000
      0000DEDEDE00A3A3A3009F9F9F009F9F9F009F9F9F009F9F9F009F9F9F009F9F
      9F00A2A2A200C1C1C10000000000000000000000000000000000000000000000
      000000000000E0E0E00000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C3C3C300262626000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000032323200C3C3C300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A8A8A8008E8E8E00FD5F
      FD00FD5FFD00FD5FFD00FD5FFD00FD5FFD00FD5FFD00FD5FFD00FD5FFD000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000DEDEDE00D5D5
      D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5
      D500D5D5D500E3E3E30000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D4D4D4003B3B3B002626
      2600262626002626260026262600262626002626260026262600262626000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D9D9D900D2D2
      D200D2D2D200D2D2D200D2D2D200D2D2D200D2D2D200D2D2D200D2D2D2000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CCCCCC000000000000000000000000000000000000000000DFDFDF00D5D5
      D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5
      D500D5D5D500E0E0E00000000000000000000000000000000000ADADAD006262
      62005D5D5D005D5D5D005D5D5D005D5D5D005D5D5D005D5D5D005D5D5D005D5D
      5D005F5F5F00B4B4B40000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000B9B9
      B90035353500D6D6D600000000000000000000000000E8E8E800353535000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000003D3D3D00EED4EE000000000000000000000000005F5F5F000000
      0000000000000000000065656500C8C8C800C5C5C5005C5C5C00000000000000
      0000000000006565650000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B6B6B6003232
      3200C8C8C80000000000000000000000000000000000E5E5E500000000008888
      8800C5C5C500C5C5C500C5C5C500C5C5C500C5C5C500C5C5C500C5C5C500C5C5
      C5008888880000000000E5E5E5000000000000000000000000005D5D5D000000
      00000000000035353500E3E3E3000000000000000000DEDEDE00262626000000
      0000000000005D5D5D0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000DBDBDB00ACACAC009E9E9E00BBBBBB00FB83FB00C2C2C2003D3D3D00C5C5
      C5000000000000000000000000000000000000000000E5E5E50000000000B2B2
      B200000000000000000000000000000000000000000000000000000000000000
      0000B2B2B20000000000E5E5E5000000000000000000000000005D5D5D000000
      00000000000053535300FD5FFD000000000000000000F5B2F500454545000000
      0000000000005D5D5D00000000000000000000000000D7D7D700C6C6C6000000
      00000000000000000000000000000000000000000000ADADAD009C9C9C009C9C
      9C009C9C9C009C9C9C00C5C5C50000000000000000000000000000000000AAAA
      AA003B3B3B008888880096969600666666005353530078787800CBCBCB000000
      00000000000000000000000000000000000000000000E5E5E50000000000B2B2
      B200000000000000000000000000000000000000000000000000000000000000
      0000B2B2B20000000000E5E5E5000000000000000000000000005D5D5D000000
      00000000000016161600C2C2C2000000000000000000BBBBBB000D0D0D000000
      0000000000005D5D5D000000000000000000000000009696960040404000E5E5
      E5000000000000000000000000000000000000000000DCDCDC00515151000000
      000000000000000000009C9C9C00000000000000000000000000C7C7C7002A2A
      2A00DADADA00000000000000000000000000A3A3A3005A5A5A00FD5FFD000000
      00000000000000000000000000000000000000000000E5E5E50000000000B2B2
      B200000000000000000000000000000000000000000000000000000000000000
      0000B2B2B20000000000E5E5E5000000000000000000000000005D5D5D000000
      000000000000000000002A2A2A007C7C7C007878780026262600000000000000
      0000000000005D5D5D00000000000000000000000000E4E4E400424242006C6C
      6C00000000000000000000000000000000000000000000000000D6D6D6002E2E
      2E0000000000000000009C9C9C0000000000000000000000000078787800ADAD
      AD00000000000000000000000000000000000000000065656500C1C1C1000000
      00000000000000000000000000000000000000000000E5E5E50000000000B2B2
      B200000000000000000000000000000000000000000000000000000000000000
      0000B2B2B20000000000E5E5E5000000000000000000000000005D5D5D000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000005D5D5D0000000000000000000000000000000000D0D0D0004040
      400049494900BCBCBC00EED4EE000000000000000000CDCDCD006C6C6C001616
      16003B3B3B00000000009C9C9C000000000000000000000000005F5F5F00D1D1
      D100000000000000000000000000000000000000000090909000A9A9A9000000
      00000000000000000000000000000000000000000000E5E5E500000000009F9F
      9F00E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5
      E5009F9F9F0000000000E5E5E5000000000000000000000000005D5D5D004D4D
      4D005D5D5D005D5D5D005D5D5D005D5D5D005D5D5D00585858001C1C1C000000
      0000000000005D5D5D000000000000000000000000000000000000000000DCDC
      DC00777777001C1C1C000D0D0D003535350022222200000000005C5C5C00C0C0
      C000DFDFDF005C5C5C009C9C9C000000000000000000000000006D6D6D00C2C2
      C200000000000000000000000000000000000000000072727200B8B8B8000000
      00000000000000000000000000000000000000000000E5E5E500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000026262600E7E7E7000000000000000000000000005D5D5D00CACA
      CA000000000000000000000000000000000000000000E6E6E600585858000000
      0000000000005D5D5D0000000000000000000000000000000000000000000000
      000000000000DBDBDB00B9B9B900A8A8A800AFAFAF00D0D0D000000000000000
      000000000000E1E1E100B1B1B100000000000000000000000000ADADAD005F5F
      5F0000000000000000000000000000000000CBCBCB003D3D3D00E3E3E3000000
      00000000000000000000000000000000000000000000E5E5E500000000000000
      00000000000000000000000000000000000070707000B2B2B200B2B2B200B2B2
      B200B2B2B200CACACA00000000000000000000000000000000005D5D5D00D5D5
      D5000000000000000000000000000000000000000000000000005D5D5D000000
      0000000000009292920000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007D7D
      7D0051515100B5B5B500CACACA00A3A3A30032323200B9B9B900000000000000
      00000000000000000000000000000000000000000000EBE2EB003D3D3D000000
      0000000000000000000000000000787878000000000000000000000000000000
      000000000000000000000000000000000000000000000000000062626200B2B2
      B200D5D5D500D5D5D500D5D5D500D5D5D500D5D5D500CACACA004D4D4D000000
      0000909090000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000B2B2B200767676006A6A6A0085858500D2D2D20000000000000000000000
      0000000000000000000000000000000000000000000000000000E2E2E200D5D5
      D500D5D5D500D5D5D500D5D5D500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B2B2B2006262
      62005D5D5D005D5D5D005D5D5D005D5D5D005D5D5D005D5D5D005D5D5D009292
      9200000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E8E8E800B4B4B400929292008A8A8A00B4B4B400E1E1E1000000
      00000000000000000000000000000000000000000000E5E5E500E5E5E500E5E5
      E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5
      E500E5E5E500E5E5E500E5E5E500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000D9D9
      D900D5D5D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5
      D500D6D6D600E2E2E2000000000000000000000000000000000000000000FD5F
      FD00737373001C1C1C0070707000AAAAAA00B2B2B20070707000262626004545
      4500FD5FFD00000000000000000000000000E8E8E80040404000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000004B4B4B00F5B2F5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C2C2C200515151001616
      1600000000000000000000000000000000000000000000000000000000000000
      0000000000002E2E2E008F8F8F00000000000000000000000000000000007C7C
      7C004D4D4D00D0D0D00000000000000000000000000000000000E0E0E0007373
      73007C7C7C00FD5FFD00000000000000000000000000B2B2B200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000BABABA00000000000000000000000000000000000000
      0000E6E6E600A8A8A8006A6A6A0053535300535353006E6E6E00ACACAC00EBE2
      EB0000000000000000000000000000000000CECECE000D0D0D00000000000000
      0000000000000000000026262600C0C0C000C0C0C00026262600000000000000
      0000000000000000000000000000A8A8A80000000000000000009E9E9E007373
      7300000000000000000000000000E8E8E800DFDFDF0000000000000000000000
      0000737373004545450000000000000000000000000000000000686868000000
      0000000000000000000000000000A9A9A900A9A9A90000000000000000000000
      000000000000737373000000000000000000000000000000000000000000ABAB
      AB00000000000000000055555500949494009292920051515100000000001616
      1600B2B2B2000000000000000000000000007272720000000000000000000000
      0000000000002E2E2E00BFBFBF000000000000000000BFBFBF002E2E2E000000
      000000000000000000000000000056565600000000000000000022222200E1E1
      E100000000000000000000000000B2B2B2008C8C8C0000000000000000000000
      0000E1E1E10026262600E1E1E100000000000000000000000000CCCCCC002222
      2200000000000000000000000000000000000000000000000000000000000000
      000026262600D3D3D30000000000000000000000000000000000939393000000
      00000000000095959500000000000000000000000000FD5FFD008D8D8D000000
      00000D0D0D009B9B9B0000000000000000001616160000000000000000000000
      000026262600BFBFBF0000000000000000000000000000000000BFBFBF002626
      26000000000000000000000000005858580000000000D5D5D5004F4F4F000000
      0000000000000000000000000000B2B2B2008C8C8C0000000000000000000000
      0000000000006E6E6E00B4B4B400000000000000000000000000000000008585
      85000000000000000000000000009F9F9F009F9F9F0000000000000000000000
      00008F8F8F0000000000000000000000000000000000B2B2B2000D0D0D000000
      00005555550000000000D2D2D2007171710073737300D8D8D800FB83FB004B4B
      4B000000000016161600BBBBBB00000000005555550000000000000000000000
      00004747470099999900C5C5C5000000000000000000C5C5C500999999004747
      4700000000000000000000000000AEAEAE0000000000B4B4B4008D8D8D000000
      0000000000000000000000000000B2B2B2008C8C8C0000000000000000000000
      000000000000B2B2B2008A8A8A0000000000000000000000000000000000E4E4
      E4000D0D0D000000000000000000B2B2B200B2B2B20000000000000000001C1C
      1C00EED4EE00000000000000000000000000F2C4F2003B3B3B00000000000000
      0000949494000000000071717100000000000000000079797900000000008787
      8700000000000000000047474700FD5FFD00B6B6B60000000000000000000000
      000000000000000000009C9C9C0000000000000000009C9C9C00000000000000
      0000000000003D3D3D009B9B9B000000000000000000B9B9B900868686000000
      0000000000000000000000000000D9D9D900CACACA0000000000000000000000
      000000000000ABABAB0091919100000000000000000000000000000000000000
      0000A7A7A7000000000000000000B2B2B200B2B2B2000000000000000000B1B1
      B10000000000000000000000000000000000F89DF80040404000000000000000
      000092929200000000007373730000000000000000007D7D7D00000000008484
      840000000000000000004D4D4D000000000000000000959595001C1C1C000000
      0000000000000000000094949400000000000000000094949400000000000000
      000073737300E8E8E800000000000000000000000000D5D5D5004F4F4F000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000006E6E6E00B4B4B400000000000000000000000000000000000000
      00000000000056565600000000006A6A6A006A6A6A0000000000626262000000
      00000000000000000000000000000000000000000000B9B9B9000D0D0D000000
      000051515100FD5FFD00D8D8D800797979007D7D7D00DDDDDD00F2C4F2004747
      4700000000001C1C1C00C0C0C000000000000000000000000000D5D5D5009494
      94000000000000000000353535005D5D5D005D5D5D0035353500000000000000
      0000C6C6C60000000000000000000000000000000000000000004B4B4B00D0D0
      D000000000000000000000000000B2B2B2008C8C8C0000000000000000000000
      0000D0D0D0001C1C1C00E8E8E800000000000000000000000000000000000000
      000000000000C2C2C2000D0D0D00000000000000000016161600CACACA000000
      00000000000000000000000000000000000000000000000000009B9B9B000D0D
      0D00000000008D8D8D00FB83FB000000000000000000F2C4F200858585000000
      00000D0D0D00A3A3A30000000000000000000000000000000000000000000000
      00007A7A7A000000000000000000000000000000000000000000000000008888
      8800000000000000000000000000000000000000000000000000B6B6B6004D4D
      4D00E0E0E0000000000000000000000000000000000000000000000000000000
      00004D4D4D007373730000000000000000000000000000000000000000000000
      0000000000000000000079797900000000000000000083838300000000000000
      000000000000000000000000000000000000000000000000000000000000B5B5
      B5001C1C1C00000000004B4B4B00868686008484840047474700000000002626
      2600BBBBBB000000000000000000000000000000000000000000000000000000
      000000000000A5A5A5004B4B4B0022222200262626004F4F4F00ADADAD000000
      0000000000000000000000000000000000000000000000000000000000007C7C
      7C004D4D4D00D0D0D00000000000000000000000000000000000E0E0E0007373
      73007C7C7C00FD5FFD0000000000000000000000000000000000000000000000
      00000000000000000000DADADA002E2E2E0038383800E0E0E000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F5B2F500B2B2B20078787800585858005A5A5A007C7C7C00B6B6B600FB83
      FB00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000DDDDDD00DEDEDE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000B6B6B6004949490051515100858585008D8D8D0051515100222222009E9E
      9E00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000009A9A9A00A3A3A30000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000D5D5D500B9B9B900B3B3B300D5D5D500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FB83FB000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FD5FFD00F2C4F20000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000F89DF800A9A9A9009A9A9A00F89DF800000000000000
      000000000000000000000000000000000000000000000000000000000000FD5F
      FD00FD5FFD00FD5FFD0000000000000000000000000000000000000000000000
      0000FD5FFD00FD5FFD0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000E8E8
      E8005A5A5A0051515100DCDCDC00000000000000000000000000FD5FFD00FD5F
      FD00FD5FFD00FD5FFD00FD5FFD00FD5FFD00FD5FFD00FD5FFD00FD5FFD00FD5F
      FD00FD5FFD00FD5FFD0000000000000000000000000000000000000000000000
      000000000000F5B2F5002E2E2E00000000000000000032323200DDDDDD000000
      0000000000000000000000000000000000000000000000000000686868002E2E
      2E002E2E2E000D0D0D000000000000000000DEDEDE004D4D4D0000000000A0A0
      A0000D0D0D001C1C1C00FD5FFD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E7E7E7006565
      6500000000000000000053535300FD5FFD0000000000A9A9A9001C1C1C001C1C
      1C001C1C1C001C1C1C001C1C1C001C1C1C001C1C1C001C1C1C001C1C1C001C1C
      1C001C1C1C001C1C1C00FD5FFD00000000000000000000000000000000000000
      000000000000737373000000000000000000000000000000000032323200E7E7
      E70000000000000000000000000000000000000000000000000068686800D2D2
      D200CBCBCB006666660000000000D1D1D100AFAFAF00D6D6D600000000009898
      980083838300D2D2D20000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E8E8E800656565000000
      00000000000000000000787878000000000000000000E6E6E600D4D4D400D4D4
      D400D4D4D400D4D4D400D4D4D400D4D4D400D4D4D400D4D4D400D4D4D400D4D4
      D400D4D4D400D4D4D40000000000000000000000000000000000000000000000
      0000D0D0D0009F9F9F00222222000000000000000000000000006D6D6D00C3C3
      C30000000000000000000000000000000000000000000000000068686800CDCD
      CD00C7C7C7006363630000000000B2B2B2008C8C8C0000000000474747000000
      00009F9F9F000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E7E7E7005A5A5A00000000000000
      0000000000007F7F7F000000000000000000000000000000000000000000D4D4
      D400FB83FB000000000000000000D7D7D700000000000000000000000000DADA
      DA00000000000000000000000000000000000000000000000000F5B2F5003232
      320000000000A5A5A500C0C0C0002E2E2E0000000000A9A9A900E4E4E4002A2A
      2A002A2A2A00D8D8D80000000000000000000000000000000000797979004747
      4700474747004747470000000000B2B2B2008C8C8C0000000000000000000000
      0000D4D4D4001C1C1C00FD5FFD00000000000000000000000000000000000000
      0000000000000000000000000000E8E8E8005A5A5A0000000000000000000000
      00007F7F7F000000000000000000000000000000000000000000000000003232
      3200CACACA00000000000000000055555500D4D4D40000000000000000006A6A
      6A00D1D1D1000000000000000000000000000000000000000000787878000000
      00000000000000000000BEBEBE00BEBEBE008D8D8D00CDCDCD004D4D4D000000
      0000000000002A2A2A00F5B2F50000000000000000000000000000000000DADA
      DA00CDCDCD0000000000D4D4D400B9B9B900B0B0B000D1D1D100D1D1D1000000
      0000D4D4D4001C1C1C00FD5FFD0000000000000000000000000000000000F89D
      F800D3D3D300D5D5D500DADADA00656565000000000000000000000000007878
      7800000000000000000000000000000000000000000000000000000000003232
      3200CACACA00000000000000000055555500D4D4D40000000000000000006A6A
      6A00D1D1D10000000000000000000000000000000000BFBFBF00000000000000
      00000000000000000000000000009F9F9F00CCCCCC002E2E2E00000000000000
      000000000000000000009797970000000000000000000000000000000000A8A8
      A80082828200FB83FB0042424200B7B7B700D5D5D5006C6C6C006C6C6C00CCCC
      CC00CDCDCD006E6E6E0000000000000000000000000000000000B2B2B2004949
      4900000000000D0D0D002A2A2A00000000000000000000000000787878000000
      0000000000000000000000000000000000000000000000000000000000003232
      3200CACACA00000000000000000055555500D4D4D40000000000000000006A6A
      6A00D1D1D10000000000000000000000000000000000CBCBCB00000000000000
      0000000000000000000032323200C1C1C100EBE2EB004F4F4F00000000000000
      00000000000000000000A8A8A80000000000000000000000000070707000D5D5
      D500000000002E2E2E002E2E2E002E2E2E00929292000000000000000000A3A3
      A300A3A3A30000000000000000000000000000000000B0B0B000000000000000
      000000000000000000000000000000000000000000007F7F7F00000000000000
      0000000000000000000000000000000000000000000000000000000000004545
      4500CBCBCB0000000000000000005F5F5F00D6D6D60000000000000000007272
      7200D3D3D3000000000000000000000000000000000000000000767676000000
      00000000000000000000BEBEBE00BEBEBE008D8D8D00CBCBCB004B4B4B000000
      0000000000002E2E2E00F5B2F500000000000000000000000000D1D1D100EBE2
      EB0000000000C8C8C800CDCDCD00C8C8C800D6D6D6000000000000000000DADA
      DA00DADADA00000000000000000000000000FB83FB003B3B3B00000000002626
      26001C1C1C0000000000000000000000000035353500E3E3E300000000000000
      000000000000000000000000000000000000000000000000000000000000D3D3
      D300FB83FB000000000000000000D6D6D600000000000000000000000000D9D9
      D900000000000000000000000000000000000000000000000000000000008686
      860075757500C3C3C300A3A3A300161616000000000088888800E0E0E0008787
      870086868600F2C4F20000000000000000000000000000000000686868006262
      62006363630022222200C8C8C8002E2E2E0000000000C8C8C800474747005C5C
      5C00626262000D0D0D00FD5FFD0000000000D5D5D500000000002A2A2A00C4C4
      C400BEBEBE0022222200000000000000000016161600DADADA00000000000000
      00000000000000000000000000000000000000000000E7E7E700D5D5D500D5D5
      D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5
      D500D5D5D500D5D5D50000000000000000000000000000000000000000000000
      0000DADADA006A6A6A000000000000000000000000000000000000000000BCBC
      BC0000000000000000000000000000000000000000000000000068686800D0D0
      D000C5C5C5006A6A6A00C8C8C8002E2E2E00E2E2E2000000000047474700C5C5
      C500D0D0D00032323200FD5FFD0000000000D4D4D40026262600C5C5C5000000
      000000000000BEBEBE001C1C1C00000000001C1C1C00DCDCDC00000000000000
      00000000000000000000000000000000000000000000B1B1B1000D0D0D000000
      00002E2E2E005C5C5C005D5D5D005D5D5D005D5D5D005D5D5D00565656000D0D
      0D00000000002A2A2A0000000000000000000000000000000000000000000000
      00000000000077777700000000000000000000000000000000002E2E2E00E5E5
      E50000000000000000000000000000000000000000000000000068686800DBDB
      DB00D5D5D5006A6A6A00DADADA00A3A3A300CDCDCD00EBE2EB0047474700D0D0
      D000DBDBDB0032323200FD5FFD000000000000000000CECECE00000000000000
      000000000000B6B6B60016161600000000005A5A5A0000000000000000000000
      0000000000000000000000000000000000000000000000000000ADADAD002A2A
      2A0051515100C0C0C000000000000000000000000000DCDCDC009B9B9B002222
      220083838300CECECE0000000000000000000000000000000000000000000000
      0000000000000000000079797900000000000000000076767600EED4EE000000
      00000000000000000000000000000000000000000000000000008B8B8B006868
      6800686868006868680000000000000000008D8D8D00D1D1D100797979006868
      6800686868006868680000000000000000000000000000000000000000000000
      0000B6B6B60016161600000000001C1C1C00C8C8C80000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F89D
      F800AFAFAF00474747007D7D7D00D0D0D000ACACAC002E2E2E0076767600D4D4
      D400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000CDCDCD00BEBEBE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C7C7
      C700161616000000000066666600C8C8C8000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000A0A0A0004F4F4F0071717100E3E3E300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E7E7E700EED4EE0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000E2E2E2000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000900000000100010000000000800400000000000000000000
      000000000000000000000000FFFFFF00F00FF00F00000000E187E00700000000
      CFF3C663000000009FF98E71000000003FFC1C38000000003FFC3C3C00000000
      3FFC399C00000000700E3E3C00000000700E3C7C000000003FFC389C00000000
      3FFC3C1C000000003FFC1C38000000009FF98E7100000000CFF3C66300000000
      E187E00700000000F00FF00F00000000FFFFFFFFFFFFF00FFFFFFFFFFFFFE187
      FFFF8001FFC7CFF3C1C18001E7C39FF980C181F9E3C33E7C1C4981F9F1833E7C
      22089F99F89F3E7C01088109FC7F700E01008101FE3F700E22009FE1F91F3E7C
      1C7F81F9F1833E7C80FF81F9E3C33E7CC1FF8001E7C39FF9FFFF8001FFC7CFF3
      FFFFFFFFFFFFE187FFFFFFFFFFFFF00FFFFFFFFFFE7FFFFFFFFFE007F81FF81F
      C003C003F00FF00FC003C003E0C7E3C7C843C003E0E7CE73C003C003C0E38E71
      C003C003C0F39FF9E007C423C0F39E79FFCFC003CF039E79FFCFC003CF039E79
      FFFFC003CF038E71FF07E003CF03CE63FE03F003C303E3C7FF07F803E007F00F
      FFFFFC07F81FF81FFFFFFFFFFEFFFFFFFFFFF81FFFFFFFFFFFFFF81FFFFFFFFF
      C003FFFFF81FC0038001F00FF00FC0038001F00FE7C7CFF38001F00FCFE3CFF3
      8001F3CFCFF3CFF38001F3CFCE73C0038081F3CFCE7380018421F3CFCE739249
      8001F3CFC66392498001F3CFE66792418001F00FF66FC003C003F00FFE7FC003
      FFFFF00FFFFFFFFFFFFFF81FFFFFFFFFFFFFFFFFFFFFFFFFF81FF81FFFFFFFFF
      F00FF00FE0FFFFFFE007E007C07FFFFFC003C003C047F00F82018421C047F00F
      85018241C043F00F88818181C043F00F80418181C07FF00F80218241C041F00F
      80118401C041F00FC003C003803FF00FE007E007803FFFFFF00FF00FF1FFFFFF
      F81FF81FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF803FFFFFFFFFFFFF003FFFFFFFF
      FFFFF3F1FFFFC003FFFFF3F1FBFF8001FFFF93F1F8FF9FF981F993F1F83F9FF9
      81F193F1F81F9FF983E193F1F8079FF9818393F1F80F8001800793F1F81F8001
      9C1F93F1F87F8001FFFF9003F8FF9FF9FFFF9003FBFF8001FFFF801FFFFFC003
      FFFF801FFFFFFFFFFFFFC01FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFF7C003C003FFFFFFE38001C003FFFFFFC78001C183FFFFF00F8FF1C1839F81
      E01F8FF1C1838F81C71F8FF1C0038FC1CF9F8FF1C003C181CF9F8001C003E001
      CF9F8001CF83F839CF1F8003CFC3FFFFE03F80FFC007FFFFF07FC1FFC00FFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF81F8001FFFF
      E003E0070000FFFF8001E3C38001F00F0000CE73C003E0070180CE71C003C383
      03C09E79E007840101809E79E007042001819E79F00F042181839FF9F81F8001
      C007CE71F81FC183F00FC7F3FC3FE007F81FE3C3FC3FF00FFE7FF00FFE7FFFFF
      FFFFFC3FFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3FFFFFC3FE3F3FFE1C003
      F81FC321FFC08001F80FC223FF818003F00FC247FF03E6EFC003C271FE07E667
      C001E411E00FE6678001E003C01FE6678001C867803FE667C001C867003FE6EF
      E003C001003F8003F00FC041183F8003F80FC001B87FC383FC1FC303F07FE00F
      FE7FFFFFE0FFFC3FFFFFFFFFF3FFFEFF00000000000000000000000000000000
      000000000000}
  end
  object OpenDialog1: TOpenDialog
    Left = 192
    Top = 560
  end
  object ACBrCEP1: TACBrCEP
    ProxyPort = '8080'
    ContentsEncodingCompress = []
    NivelLog = 0
    WebService = wsCorreios
    PesquisarIBGE = True
    Left = 160
    Top = 560
  end
  object ACBrOpenSSLUtils1: TACBrOpenSSLUtils
    Left = 224
    Top = 560
  end
  object ACBrPixCD1: TACBrPixCD
    Recebedor.CodCategoriaComerciante = 0
    PSP = ACBrPSPBancoDoBrasil1
    QuandoGravarLog = ACBrPixCD1QuandoGravarLog
    OnQuandoAlterarPSP = ACBrPixCD1QuandoAlterarPSP
    Left = 140
    Top = 472
  end
  object ACBrPSPShipay1: TACBrPSPShipay
    Scopes = [scCobWrite, scCobRead, scPixWrite, scPixRead]
    URLProducao = 'https://api.shipay.com.br'
    URLSandBox = 'https://api-staging.shipay.com.br'
    Left = 224
    Top = 416
  end
  object ACBrPSPBancoDoBrasil1: TACBrPSPBancoDoBrasil
    ACBrPixCD = ACBrPixCD1
    Scopes = [scCobWrite, scCobRead, scPixWrite, scPixRead]
    QuandoReceberRespostaHttp = ACBrPSPBancoDoBrasil1QuandoReceberRespostaHttp
    BBAPIVersao = apiVersao2
    Left = 168
    Top = 416
  end
  object ACBrPSPItau1: TACBrPSPItau
    Scopes = [scCobWrite, scCobRead, scPixWrite, scPixRead]
    Left = 196
    Top = 416
  end
  object ACBrPSPSantander1: TACBrPSPSantander
    Scopes = [scCobWrite, scCobRead, scPixWrite, scPixRead]
    Left = 140
    Top = 416
  end
  object ACBrPSPSicredi1: TACBrPSPSicredi
    Scopes = [scCobWrite, scCobRead, scPixWrite, scPixRead]
    Left = 256
    Top = 416
  end
  object ACBrPSPSicoob1: TACBrPSPSicoob
    Scopes = [scCobWrite, scCobRead, scPixWrite, scPixRead]
    Left = 288
    Top = 416
  end
  object ACBrPSPPagSeguro1: TACBrPSPPagSeguro
    Scopes = [scCobWrite, scCobRead, scPixWrite, scPixRead]
    Left = 318
    Top = 416
  end
  object ACBrPSPGerenciaNet1: TACBrPSPGerenciaNet
    Scopes = [scCobWrite, scCobRead, scPixWrite, scPixRead]
    Left = 349
    Top = 416
  end
  object ACBrPSPBradesco1: TACBrPSPBradesco
    Scopes = [scCobWrite, scCobRead, scPixWrite, scPixRead]
    Left = 379
    Top = 416
  end
  object ACBrPSPPixPDV1: TACBrPSPPixPDV
    Scopes = [scCobWrite, scCobRead, scPixWrite, scPixRead]
    APIVersao = apiVersao1
    Left = 411
    Top = 416
  end
  object ACBrPSPInter1: TACBrPSPInter
    Scopes = [scCobWrite, scCobRead, scPixWrite, scPixRead]
    Left = 443
    Top = 416
  end
  object ACBrPSPAilos1: TACBrPSPAilos
    Scopes = [scCobWrite, scCobRead, scPixWrite, scPixRead]
    Left = 474
    Top = 416
  end
  object ACBrPSPMatera1: TACBrPSPMatera
    Scopes = [scCobWrite, scCobRead, scPixWrite, scPixRead]
    Left = 506
    Top = 416
  end
  object ACBrPSPCielo1: TACBrPSPCielo
    Scopes = [scCobWrite, scCobRead, scPixWrite, scPixRead]
    Left = 536
    Top = 416
  end
  object ACBrPSPMercadoPago1: TACBrPSPMercadoPago
    Scopes = [scCobWrite, scCobRead, scPixWrite, scPixRead]
    Left = 568
    Top = 416
  end
  object ACBrPSPGate2All1: TACBrPSPGate2All
    Scopes = [scCobWrite, scCobRead, scPixWrite, scPixRead]
    Left = 600
    Top = 416
  end
  object ACBrPSPBanrisul1: TACBrPSPBanrisul
    Scopes = [scCobWrite, scCobRead, scPixWrite, scPixRead]
    Left = 632
    Top = 416
  end
  object ACBrPSPC6Bank1: TACBrPSPC6Bank
    Scopes = [scCobWrite, scCobRead, scPixWrite, scPixRead]
    Left = 664
    Top = 416
  end
  object ACBrPSPAppLess1: TACBrPSPAppLess
    Scopes = [scCobWrite, scCobRead, scPixWrite, scPixRead]
    Left = 704
    Top = 416
  end
  object ACBrPSPQQPag1: TACBrPSPQQPag
    Scopes = [scCobWrite, scCobRead, scPixWrite, scPixRead]
    Left = 738
    Top = 416
  end
  object ACBrPSPCrediSIS1: TACBrPSPCrediSIS
    Scopes = [scCobWrite, scCobRead, scPixWrite, scPixRead]
    Left = 770
    Top = 416
  end
end
