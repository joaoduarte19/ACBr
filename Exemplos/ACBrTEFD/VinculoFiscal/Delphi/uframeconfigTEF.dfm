object frameConfigTEF: TframeConfigTEF
  Left = 0
  Top = 0
  Width = 881
  Height = 557
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object pnpRodape: TPanel
    Left = 0
    Top = 495
    Width = 881
    Height = 62
    Align = alBottom
    TabOrder = 0
    inline frameRodape1: TframeRodape
      Left = 1
      Top = 1
      Width = 879
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
        Left = 734
        OnClick = btnSalvarClick
      end
      inherited lblTexto: TLabel
        Width = 182
        Caption = 'Configura'#231#245'es TEFAPI'
      end
    end
  end
  object pgConfiguracao: TPageControl
    Left = 0
    Top = 0
    Width = 881
    Height = 441
    ActivePage = tsConfTEF
    Align = alTop
    TabHeight = 33
    TabOrder = 1
    object tsConfTEF: TTabSheet
      Caption = 'Configura'#231#227'o TEF'
      object pConfiguracao: TPanel
        Left = 0
        Top = 0
        Width = 873
        Height = 398
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object pConfigImpSwHouseEstab: TPanel
          Left = 336
          Top = 0
          Width = 537
          Height = 398
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 0
          object gbDadosSwHouseAplicacao: TGroupBox
            Left = 0
            Top = 0
            Width = 537
            Height = 150
            Align = alTop
            Caption = 'Software House e Aplica'#231#227'o'
            TabOrder = 0
            DesignSize = (
              537
              150)
            object Label14: TLabel
              Left = 24
              Top = 14
              Width = 27
              Height = 13
              Caption = 'Nome'
              Color = clBtnFace
              ParentColor = False
              Transparent = True
            end
            object Label16: TLabel
              Left = 24
              Top = 56
              Width = 75
              Height = 13
              Caption = 'Nome Aplica'#231#227'o'
              Color = clBtnFace
              ParentColor = False
              Transparent = True
            end
            object Label19: TLabel
              Left = 257
              Top = 56
              Width = 33
              Height = 13
              Anchors = [akTop, akRight]
              Caption = 'Vers'#227'o'
              Color = clBtnFace
              ParentColor = False
              Transparent = True
            end
            object Label15: TLabel
              Left = 378
              Top = 14
              Width = 25
              Height = 13
              Anchors = [akTop, akRight]
              Caption = 'CNPJ'
              Color = clBtnFace
              ParentColor = False
              Transparent = True
            end
            object Label37: TLabel
              Left = 24
              Top = 102
              Width = 86
              Height = 13
              Caption = 'Mensagem PinPad'
              Color = clBtnFace
              ParentColor = False
              Transparent = True
            end
            object Label45: TLabel
              Left = 212
              Top = 56
              Width = 32
              Height = 13
              Caption = 'Idioma'
              Color = clBtnFace
              ParentColor = False
              Transparent = True
            end
            object Label46: TLabel
              Left = 310
              Top = 56
              Width = 32
              Height = 13
              Caption = 'Moeda'
              Color = clBtnFace
              ParentColor = False
              Transparent = True
            end
            object Label47: TLabel
              Left = 260
              Top = 102
              Width = 103
              Height = 13
              Caption = 'Par'#226'metros Aplica'#231#227'o'
              Color = clBtnFace
              ParentColor = False
              Transparent = True
            end
            object edRazaoSocialSwHouse: TEdit
              Left = 24
              Top = 30
              Width = 342
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 0
              Text = 'PROJETO ACBR'
            end
            object edNomeAplicacao: TEdit
              Left = 24
              Top = 72
              Width = 109
              Height = 21
              TabOrder = 2
              Text = 'TEFAPIDemo'
            end
            object edVersaoAplicacao: TEdit
              Left = 141
              Top = 72
              Width = 63
              Height = 21
              TabOrder = 3
              Text = '1.0'
            end
            object edCNPJSwHouse: TEdit
              Left = 378
              Top = 30
              Width = 141
              Height = 21
              Anchors = [akTop, akRight]
              TabOrder = 1
            end
            object edMsgPinPad: TEdit
              Left = 24
              Top = 118
              Width = 230
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 4
              Text = 'TEF ACBR.  SEJA NOSSO PARCEIRO'
            end
            object cbxIdioma: TComboBox
              Left = 212
              Top = 72
              Width = 89
              Height = 21
              Style = csDropDownList
              ItemIndex = 0
              TabOrder = 5
              Text = 'Portugu'#234's'
              Items.Strings = (
                'Portugu'#234's'
                'Ingl'#234's'
                'Espanhol')
            end
            object cbxMoeda: TComboBox
              Left = 310
              Top = 72
              Width = 208
              Height = 21
              Style = csDropDownList
              Anchors = [akLeft, akTop, akRight]
              ItemIndex = 0
              TabOrder = 6
              Text = 'REAL - 986'
              Items.Strings = (
                'REAL - 986'
                'DOLAR - 840'
                'EURO - 978')
            end
            object edParamAplic: TEdit
              Left = 260
              Top = 118
              Width = 258
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 7
            end
          end
          object gbDadosTerminal: TGroupBox
            Left = 0
            Top = 214
            Width = 537
            Height = 184
            Align = alClient
            Caption = 'Dados Terminal'
            TabOrder = 1
            DesignSize = (
              537
              184)
            object Label17: TLabel
              Left = 24
              Top = 23
              Width = 63
              Height = 13
              Caption = 'Cod.Terminal'
              Color = clBtnFace
              ParentColor = False
              Transparent = True
            end
            object Label21: TLabel
              Left = 398
              Top = 66
              Width = 61
              Height = 13
              Anchors = [akTop, akRight]
              Caption = 'Porta PinPad'
              Color = clBtnFace
              ParentColor = False
              Transparent = True
            end
            object Label23: TLabel
              Left = 123
              Top = 23
              Width = 88
              Height = 13
              Caption = 'Endere'#231'o Servidor'
              Color = clBtnFace
              ParentColor = False
              Transparent = True
            end
            object Label24: TLabel
              Left = 24
              Top = 66
              Width = 64
              Height = 13
              Caption = 'Cod.Empresa'
              Color = clBtnFace
              ParentColor = False
              Transparent = True
            end
            object Label30: TLabel
              Left = 123
              Top = 66
              Width = 20
              Height = 13
              Caption = 'Filial'
              Color = clBtnFace
              ParentColor = False
              Transparent = True
            end
            object Label31: TLabel
              Left = 398
              Top = 23
              Width = 45
              Height = 13
              Anchors = [akTop, akRight]
              Caption = 'Ambiente'
              Color = clBtnFace
              ParentColor = False
              Transparent = True
            end
            object Label32: TLabel
              Left = 24
              Top = 109
              Width = 121
              Height = 13
              Caption = 'Par'#226'metros Comunica'#231#227'o'
              Color = clBtnFace
              ParentColor = False
              Transparent = True
            end
            object edCodTerminal: TEdit
              Left = 24
              Top = 39
              Width = 83
              Height = 21
              TabOrder = 0
            end
            object edPortaPinPad: TEdit
              Left = 398
              Top = 82
              Width = 114
              Height = 21
              Anchors = [akTop, akRight]
              TabOrder = 5
            end
            object edEnderecoServidor: TEdit
              Left = 123
              Top = 39
              Width = 260
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 1
            end
            object edCodEmpresa: TEdit
              Left = 24
              Top = 82
              Width = 83
              Height = 21
              TabOrder = 3
            end
            object edCodFilial: TEdit
              Left = 123
              Top = 82
              Width = 260
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 4
              Text = '0001'
            end
            object cbxAmbiente: TComboBox
              Left = 398
              Top = 39
              Width = 114
              Height = 21
              Style = csDropDownList
              Anchors = [akTop, akRight]
              ItemIndex = 0
              TabOrder = 2
              Text = 'Nao Definido'
              Items.Strings = (
                'Nao Definido'
                'Homologa'#231#227'o'
                'Produ'#231#227'o')
            end
            object edParamComunic: TEdit
              Left = 24
              Top = 127
              Width = 359
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 6
            end
            object cbGravarLogTEF: TCheckBox
              Left = 440
              Top = 127
              Width = 58
              Height = 19
              Anchors = [akTop, akRight]
              Caption = 'Log TEF'
              Checked = True
              State = cbChecked
              TabOrder = 7
            end
          end
          object gbDadosEstabComercial: TGroupBox
            Left = 0
            Top = 150
            Width = 537
            Height = 64
            Align = alTop
            Caption = 'Estabelecimento Comercial'
            TabOrder = 2
            DesignSize = (
              537
              64)
            object Label20: TLabel
              Left = 24
              Top = 15
              Width = 60
              Height = 13
              Caption = 'Raz'#227'o Social'
              Color = clBtnFace
              ParentColor = False
              Transparent = True
            end
            object Label22: TLabel
              Left = 378
              Top = 15
              Width = 25
              Height = 13
              Anchors = [akTop, akRight]
              Caption = 'CNPJ'
              Color = clBtnFace
              ParentColor = False
              Transparent = True
            end
            object edRazaoSocialEstabelecimento: TEdit
              Left = 24
              Top = 31
              Width = 330
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 0
              Text = 'PROJETO ACBR'
            end
            object edCNPJEstabelecimento: TEdit
              Left = 378
              Top = 30
              Width = 141
              Height = 21
              Anchors = [akTop, akRight]
              TabOrder = 1
            end
          end
        end
        object pConfigTEF: TPanel
          Left = 0
          Top = 0
          Width = 336
          Height = 398
          Align = alLeft
          BevelOuter = bvNone
          TabOrder = 1
          object gbConfigTEF: TGroupBox
            Left = 0
            Top = 0
            Width = 336
            Height = 239
            Align = alClient
            Caption = 'TEF'
            TabOrder = 0
            object Label11: TLabel
              Left = 17
              Top = 59
              Width = 42
              Height = 13
              Alignment = taRightJustify
              Caption = 'Arq.Log:'
              Color = clBtnFace
              ParentColor = False
              Transparent = True
            end
            object SbArqLog: TSpeedButton
              Left = 155
              Top = 75
              Width = 24
              Height = 23
              Caption = '...'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              OnClick = SbArqLogClick
            end
            object Label9: TLabel
              Left = 182
              Top = 19
              Width = 40
              Height = 13
              Caption = 'QRCode'
              Color = clBtnFace
              ParentColor = False
              Transparent = True
            end
            object Label1: TLabel
              Left = 15
              Top = 19
              Width = 79
              Height = 13
              Caption = 'Gerenciador TEF'
              Color = clBtnFace
              ParentColor = False
              Transparent = True
            end
            object Label10: TLabel
              Left = 182
              Top = 59
              Width = 91
              Height = 13
              Caption = 'Imprimir Via Cliente'
              Color = clBtnFace
              ParentColor = False
              Transparent = True
            end
            object Label12: TLabel
              Left = 15
              Top = 102
              Width = 99
              Height = 13
              Caption = 'Transa'#231#227'o Pendente'
              Color = clBtnFace
              ParentColor = False
              Transparent = True
            end
            object Label18: TLabel
              Left = 182
              Top = 102
              Width = 124
              Height = 13
              Caption = 'Pendencia na Inicializa'#231#227'o'
              Color = clBtnFace
              ParentColor = False
              Transparent = True
            end
            object cbSuportaDesconto: TCheckBox
              Left = 205
              Top = 150
              Width = 112
              Height = 19
              Caption = 'Suporta Desconto'
              TabOrder = 0
            end
            object cbSuportaSaque: TCheckBox
              Left = 205
              Top = 175
              Width = 94
              Height = 19
              Caption = 'Suporta Saque'
              TabOrder = 1
            end
            object cbImprimirViaReduzida: TCheckBox
              Left = 19
              Top = 173
              Width = 135
              Height = 19
              Caption = 'Imprimir Via Reduzida'
              TabOrder = 2
            end
            object edLog: TEdit
              Left = 15
              Top = 75
              Width = 141
              Height = 21
              Cursor = crIBeam
              TabOrder = 3
              Text = 'ACBr-YYMMDD.txt'
            end
            object cbxQRCode: TComboBox
              Left = 182
              Top = 33
              Width = 135
              Height = 21
              Style = csDropDownList
              ItemIndex = 1
              TabOrder = 4
              Text = 'Auto'
              Items.Strings = (
                'N'#227'o Suportado'
                'Auto'
                'Exibir no PinPad'
                'Exibir na Tela'
                'Imprimir')
            end
            object cbConfirmarAutomaticamente: TCheckBox
              Left = 19
              Top = 195
              Width = 225
              Height = 19
              Caption = 'Confirmar Transa'#231#227'o Automaticamente'
              TabOrder = 5
            end
            object cbxGP: TComboBox
              Left = 15
              Top = 33
              Width = 141
              Height = 21
              Style = csDropDownList
              TabOrder = 6
              OnChange = cbxGPChange
            end
            object cbAutoAtendimento: TCheckBox
              Left = 20
              Top = 148
              Width = 180
              Height = 19
              Caption = 'Terminal de Auto atendimento'
              TabOrder = 7
            end
            object cbxImpressaoViaCliente: TComboBox
              Left = 182
              Top = 75
              Width = 135
              Height = 21
              Style = csDropDownList
              ItemIndex = 0
              TabOrder = 8
              Text = 'Imprimir'
              Items.Strings = (
                'Imprimir'
                'Perguntar'
                'N'#227'o Imprimir')
            end
            object cbxTransacaoPendente: TComboBox
              Left = 15
              Top = 118
              Width = 141
              Height = 21
              Style = csDropDownList
              ItemIndex = 0
              TabOrder = 9
              Text = 'Confirmar'
              Items.Strings = (
                'Confirmar'
                'Estornar'
                'Perguntar')
            end
            object cbxTransacaoPendenteInicializacao: TComboBox
              Left = 182
              Top = 118
              Width = 135
              Height = 21
              Style = csDropDownList
              ItemIndex = 1
              TabOrder = 10
              Text = 'Processar Pendentes'
              Items.Strings = (
                'N'#227'o Fazer nada'
                'Processar Pendentes'
                'Cancelar/Estornar')
            end
          end
          object gbDadosTEFTXT: TGroupBox
            Left = 0
            Top = 239
            Width = 336
            Height = 159
            Align = alBottom
            Caption = 'TEF TXT'
            Enabled = False
            TabOrder = 1
            DesignSize = (
              336
              159)
            object Label38: TLabel
              Left = 17
              Top = 58
              Width = 95
              Height = 13
              Caption = 'Diret'#243'rio Requisi'#231#227'o'
              Color = clBtnFace
              ParentColor = False
              Transparent = True
            end
            object Label39: TLabel
              Left = 175
              Top = 58
              Width = 89
              Height = 13
              Caption = 'Diret'#243'rio Resposta'
              Color = clBtnFace
              ParentColor = False
              Transparent = True
            end
            object sbDirReq: TSpeedButton
              Left = 144
              Top = 74
              Width = 24
              Height = 23
              Caption = '...'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              OnClick = sbDirReqClick
            end
            object sbDirResp: TSpeedButton
              Left = 302
              Top = 74
              Width = 24
              Height = 23
              Caption = '...'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              OnClick = sbDirRespClick
            end
            object Label40: TLabel
              Left = 16
              Top = 107
              Width = 72
              Height = 13
              Caption = 'Arq.Requisi'#231#227'o'
              Color = clBtnFace
              ParentColor = False
              Transparent = True
            end
            object Label41: TLabel
              Left = 123
              Top = 107
              Width = 52
              Height = 13
              Caption = 'Arq.Status'
              Color = clBtnFace
              ParentColor = False
              Transparent = True
            end
            object Label42: TLabel
              Left = 230
              Top = 107
              Width = 66
              Height = 13
              Caption = 'Arq.Resposta'
              Color = clBtnFace
              ParentColor = False
              Transparent = True
            end
            object Label43: TLabel
              Left = 258
              Top = 16
              Width = 43
              Height = 13
              Caption = 'Nivel Log'
              Color = clBtnFace
              ParentColor = False
              Transparent = True
            end
            object Label44: TLabel
              Left = 17
              Top = 18
              Width = 95
              Height = 13
              Caption = 'Modelo Gerenciador'
              Color = clBtnFace
              ParentColor = False
              Transparent = True
            end
            object edDirReq: TEdit
              Left = 17
              Top = 74
              Width = 126
              Height = 21
              TabOrder = 0
              Text = 'C:\Client\Req'
            end
            object edDirResp: TEdit
              Left = 175
              Top = 74
              Width = 126
              Height = 21
              TabOrder = 1
              Text = 'C:\Client\Resp'
            end
            object edArqReq: TEdit
              Left = 16
              Top = 123
              Width = 93
              Height = 21
              TabOrder = 2
              Text = 'IntPos.001'
            end
            object edArqSts: TEdit
              Left = 123
              Top = 123
              Width = 93
              Height = 21
              TabOrder = 3
              Text = 'IntPos.sts'
            end
            object edArqResp: TEdit
              Left = 230
              Top = 123
              Width = 93
              Height = 21
              TabOrder = 4
              Text = 'IntPos.001'
            end
            object seNivelLogTXT: TSpinEdit
              Left = 258
              Top = 32
              Width = 68
              Height = 22
              MaxValue = 3
              MinValue = 1
              TabOrder = 5
              Value = 3
            end
            object cbxGPTXT: TComboBox
              Left = 17
              Top = 32
              Width = 222
              Height = 21
              Style = csDropDownList
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 6
            end
          end
        end
      end
    end
    object tsConfImpressora: TTabSheet
      Caption = 'Configura'#231#227'o Impressora'
      object gbConfigImpressora: TGroupBox
        Left = 0
        Top = 80
        Width = 873
        Height = 118
        Align = alTop
        Caption = 'Impressora'
        Enabled = False
        TabOrder = 0
        DesignSize = (
          873
          118)
        object Label25: TLabel
          Left = 168
          Top = 51
          Width = 57
          Height = 13
          Caption = 'Linhas Pular'
          Color = clBtnFace
          ParentColor = False
          Transparent = True
        end
        object Label26: TLabel
          Left = 90
          Top = 51
          Width = 39
          Height = 13
          Caption = 'Espa'#231'os'
          Color = clBtnFace
          ParentColor = False
          Transparent = True
        end
        object Label27: TLabel
          Left = 9
          Top = 51
          Width = 38
          Height = 13
          Caption = 'Colunas'
          Color = clBtnFace
          ParentColor = False
          Transparent = True
        end
        object Label28: TLabel
          Left = 9
          Top = 0
          Width = 34
          Height = 13
          Caption = 'Modelo'
          Color = clBtnFace
          ParentColor = False
          Transparent = False
        end
        object Label7: TLabel
          Left = 168
          Top = 0
          Width = 26
          Height = 13
          Caption = 'Porta'
          Color = clBtnFace
          ParentColor = False
          Transparent = True
        end
        object Label29: TLabel
          Left = 248
          Top = 51
          Width = 71
          Height = 13
          Caption = 'P'#225'g. de c'#243'digo'
          Color = clBtnFace
          ParentColor = False
          Transparent = False
        end
        object btSerial: TSpeedButton
          Left = 853
          Top = 15
          Width = 25
          Height = 26
          Anchors = [akTop, akRight]
          OnClick = btSerialClick
        end
        object btProcuraImpressoras: TSpeedButton
          Left = 877
          Top = 15
          Width = 25
          Height = 26
          Anchors = [akTop, akRight]
          OnClick = btProcuraImpressorasClick
        end
        object seLinhasPular: TSpinEdit
          Left = 168
          Top = 68
          Width = 60
          Height = 22
          MaxValue = 255
          MinValue = 0
          TabOrder = 0
          Value = 0
        end
        object seEspLinhas: TSpinEdit
          Left = 90
          Top = 68
          Width = 60
          Height = 22
          MaxValue = 255
          MinValue = 0
          TabOrder = 1
          Value = 0
        end
        object seColunas: TSpinEdit
          Left = 9
          Top = 68
          Width = 60
          Height = 22
          MaxValue = 999
          MinValue = 1
          TabOrder = 2
          Value = 48
        end
        object cbxModeloPosPrinter: TComboBox
          Left = 9
          Top = 17
          Width = 145
          Height = 21
          Style = csDropDownList
          TabOrder = 3
        end
        object cbxPorta: TComboBox
          Left = 168
          Top = 17
          Width = 685
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 4
        end
        object cbxPagCodigo: TComboBox
          Left = 248
          Top = 68
          Width = 89
          Height = 21
          Hint = 'Pagina de c'#243'digo usada pela Impressora POS'
          Style = csDropDownList
          TabOrder = 5
        end
        object btTestarPosPrinter: TBitBtn
          Left = 915
          Top = 17
          Width = 57
          Height = 74
          Anchors = [akTop, akRight]
          Caption = 'Testar'
          Layout = blGlyphTop
          TabOrder = 6
          OnClick = btTestarPosPrinterClick
        end
      end
      object gbSaidaImpressao: TGroupBox
        Left = 0
        Top = 0
        Width = 873
        Height = 80
        Align = alTop
        Caption = 'Saida de Impress'#227'o'
        TabOrder = 1
        DesignSize = (
          873
          80)
        object Label8: TLabel
          Left = 232
          Top = 8
          Width = 119
          Height = 13
          Caption = 'Arquivo Saida Impress'#227'o'
          Color = clBtnFace
          ParentColor = False
          Transparent = True
        end
        object rbImpressora: TRadioButton
          Left = 24
          Top = 27
          Width = 75
          Height = 19
          Caption = 'Impressora'
          TabOrder = 1
          OnClick = rbImpressoraChange
        end
        object rbArquivo: TRadioButton
          Left = 136
          Top = 27
          Width = 58
          Height = 19
          Caption = 'Arquivo'
          Checked = True
          TabOrder = 0
          TabStop = True
          OnClick = rbImpressoraChange
        end
        object edArquivoImpressao: TEdit
          Left = 232
          Top = 27
          Width = 510
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 2
          Text = 'IMPYYMMDD.txt'
        end
      end
    end
  end
  object pBotaoConfig: TPanel
    Left = 0
    Top = 441
    Width = 881
    Height = 44
    Align = alTop
    TabOrder = 2
    object btTestarTEF: TBitBtn
      Left = 16
      Top = 5
      Width = 136
      Height = 28
      Caption = 'Testar TEF'
      TabOrder = 0
      OnClick = btTestarTEFClick
    end
    object btMenuAdministrativo: TBitBtn
      Left = 168
      Top = 5
      Width = 160
      Height = 28
      Caption = 'Menu Administrativo'
      TabOrder = 1
      OnClick = btMenuAdministrativoClick
    end
  end
  object ImageList1: TImageList
    Left = 230
    Top = 422
  end
end
