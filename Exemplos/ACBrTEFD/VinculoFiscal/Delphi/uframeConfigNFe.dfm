object frameConfigNfe: TframeConfigNfe
  Left = 0
  Top = 0
  Width = 789
  Height = 668
  Align = alClient
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object pgPrincipal: TPageControl
    Left = 0
    Top = 0
    Width = 789
    Height = 409
    ActivePage = tsConfigura
    Align = alTop
    TabOrder = 0
    object tsConfigura: TTabSheet
      Caption = 'Configura'#231#245'es'
      object pcConfig: TPageControl
        Left = 0
        Top = 0
        Width = 781
        Height = 381
        ActivePage = tsConfCertificado
        Align = alClient
        MultiLine = True
        TabOrder = 0
        object tsConfCertificado: TTabSheet
          Caption = 'Certificado'
          object lSSLLib: TLabel
            Left = 43
            Top = 16
            Width = 30
            Height = 13
            Alignment = taRightJustify
            Caption = 'SSLLib'
            Color = clBtnFace
            ParentColor = False
            Transparent = True
          end
          object lCryptLib: TLabel
            Left = 33
            Top = 43
            Width = 40
            Height = 13
            Alignment = taRightJustify
            Caption = 'CryptLib'
            Color = clBtnFace
            ParentColor = False
            Transparent = True
          end
          object lHttpLib: TLabel
            Left = 41
            Top = 70
            Width = 34
            Height = 13
            Alignment = taRightJustify
            Caption = 'HttpLib'
            Color = clBtnFace
            ParentColor = False
            Transparent = True
          end
          object lXmlSign: TLabel
            Left = 27
            Top = 97
            Width = 52
            Height = 13
            Alignment = taRightJustify
            Caption = 'XMLSignLib'
            Color = clBtnFace
            ParentColor = False
            Transparent = True
          end
          object gbCertificado: TGroupBox
            Left = 6
            Top = 134
            Width = 280
            Height = 219
            Caption = 'Certificado'
            ParentBackground = False
            TabOrder = 0
            object Label1: TLabel
              Left = 11
              Top = 70
              Width = 41
              Height = 13
              Caption = 'Caminho'
              Transparent = True
            end
            object Label2: TLabel
              Left = 11
              Top = 110
              Width = 30
              Height = 13
              Caption = 'Senha'
              Transparent = True
            end
            object sbtnCaminhoCert: TSpeedButton
              Left = 238
              Top = 86
              Width = 23
              Height = 24
              Glyph.Data = {
                76010000424D7601000000000000760000002800000020000000100000000100
                04000000000000010000130B0000130B00001000000000000000000000000000
                800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
                333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
                0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
                07333337F3FF3FFF7F333330F00F000F07333337F77377737F333330FFFFFFFF
                07333FF7F3FFFF3F7FFFBBB0F0000F0F0BB37777F7777373777F3BB0FFFFFFFF
                0BBB3777F3FF3FFF77773330F00F000003333337F773777773333330FFFF0FF0
                33333337F3FF7F37F3333330F08F0F0B33333337F7737F77FF333330FFFF003B
                B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
                3BB33773333773333773B333333B3333333B7333333733333337}
              NumGlyphs = 2
              OnClick = sbtnCaminhoCertClick
            end
            object Label25: TLabel
              Left = 11
              Top = 150
              Width = 79
              Height = 13
              Caption = 'N'#250'mero de S'#233'rie'
              Transparent = True
            end
            object sbtnGetCert: TSpeedButton
              Left = 238
              Top = 164
              Width = 23
              Height = 24
              Glyph.Data = {
                76010000424D7601000000000000760000002800000020000000100000000100
                04000000000000010000130B0000130B00001000000000000000000000000000
                800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
                333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
                0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
                07333337F3FF3FFF7F333330F00F000F07333337F77377737F333330FFFFFFFF
                07333FF7F3FFFF3F7FFFBBB0F0000F0F0BB37777F7777373777F3BB0FFFFFFFF
                0BBB3777F3FF3FFF77773330F00F000003333337F773777773333330FFFF0FF0
                33333337F3FF7F37F3333330F08F0F0B33333337F7737F77FF333330FFFF003B
                B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
                3BB33773333773333773B333333B3333333B7333333733333337}
              NumGlyphs = 2
              OnClick = sbtnGetCertClick
            end
            object sbtnNumSerie: TSpeedButton
              Left = 209
              Top = 164
              Width = 23
              Height = 24
              Glyph.Data = {
                76010000424D7601000000000000760000002800000020000000100000000100
                04000000000000010000130B0000130B00001000000000000000000000000000
                800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
                333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
                0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
                07333337F3FF3FFF7F333330F00F000F07333337F77377737F333330FFFFFFFF
                07333FF7F3FFFF3F7FFFBBB0F0000F0F0BB37777F7777373777F3BB0FFFFFFFF
                0BBB3777F3FF3FFF77773330F00F000003333337F773777773333330FFFF0FF0
                33333337F3FF7F37F3333330F08F0F0B33333337F7737F77FF333330FFFF003B
                B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
                3BB33773333773333773B333333B3333333B7333333733333337}
              NumGlyphs = 2
              OnClick = sbtnNumSerieClick
            end
            object Label51: TLabel
              Left = 11
              Top = 27
              Width = 65
              Height = 13
              Caption = 'URL para PFX'
              Transparent = True
            end
            object edtCaminho: TEdit
              Left = 11
              Top = 86
              Width = 225
              Height = 21
              TabOrder = 1
            end
            object edtSenha: TEdit
              Left = 11
              Top = 126
              Width = 249
              Height = 21
              PasswordChar = '*'
              TabOrder = 2
            end
            object edtNumSerie: TEdit
              Left = 11
              Top = 166
              Width = 193
              Height = 21
              TabOrder = 3
            end
            object edtURLPFX: TEdit
              Left = 11
              Top = 43
              Width = 249
              Height = 21
              TabOrder = 0
            end
          end
          object btnSubName: TButton
            Left = 295
            Top = 42
            Width = 99
            Height = 25
            Caption = 'Subject Name'
            TabOrder = 2
            OnClick = btnSubNameClick
          end
          object btnCNPJ: TButton
            Left = 400
            Top = 42
            Width = 73
            Height = 25
            Caption = 'CNPJ'
            TabOrder = 3
            OnClick = btnCNPJClick
          end
          object btnIssuerName: TButton
            Left = 478
            Top = 11
            Width = 76
            Height = 25
            Caption = 'Issuer Name'
            TabOrder = 1
            OnClick = btnIssuerNameClick
          end
          object GroupBox1: TGroupBox
            Left = 292
            Top = 131
            Width = 263
            Height = 113
            Caption = 'Calculo de Hash e assinatura'
            ParentBackground = False
            TabOrder = 5
            object Edit1: TEdit
              Left = 7
              Top = 32
              Width = 249
              Height = 21
              TabOrder = 0
              Text = '0548133600013704583493000190'
            end
            object btnSha256: TButton
              Left = 7
              Top = 64
              Width = 99
              Height = 25
              Caption = 'SHA256+RSA'
              TabOrder = 1
            end
            object cbAssinar: TCheckBox
              Left = 140
              Top = 70
              Width = 54
              Height = 19
              Caption = 'Assinar'
              Checked = True
              State = cbChecked
              TabOrder = 2
            end
          end
          object btnHTTPS: TButton
            Left = 296
            Top = 258
            Width = 128
            Height = 25
            Caption = 'HTTPS sem Certificado'
            TabOrder = 6
            OnClick = btnHTTPSClick
          end
          object btnLeituraX509: TButton
            Left = 432
            Top = 258
            Width = 115
            Height = 25
            Caption = 'Leitura de X509'
            TabOrder = 7
            OnClick = btnLeituraX509Click
          end
          object cbSSLLib: TComboBox
            Left = 80
            Top = 8
            Width = 160
            Height = 21
            Style = csDropDownList
            TabOrder = 8
            OnChange = cbSSLLibChange
          end
          object cbCryptLib: TComboBox
            Left = 80
            Top = 35
            Width = 160
            Height = 21
            Style = csDropDownList
            TabOrder = 9
            OnChange = cbCryptLibChange
          end
          object cbHttpLib: TComboBox
            Left = 80
            Top = 62
            Width = 160
            Height = 21
            Style = csDropDownList
            TabOrder = 10
            OnChange = cbHttpLibChange
          end
          object cbXmlSignLib: TComboBox
            Left = 80
            Top = 90
            Width = 160
            Height = 21
            Style = csDropDownList
            TabOrder = 11
            OnChange = cbXmlSignLibChange
          end
          object btVersao: TButton
            Left = 478
            Top = 42
            Width = 76
            Height = 25
            Caption = 'Ver.SSL Lib'
            TabOrder = 4
            OnClick = btVersaoClick
          end
          object btnDataValidade: TButton
            Left = 378
            Top = 11
            Width = 99
            Height = 25
            Caption = 'Data de Validade'
            TabOrder = 12
            OnClick = btnDataValidadeClick
          end
          object btnNumSerie: TButton
            Left = 295
            Top = 11
            Width = 73
            Height = 25
            Caption = 'Num.S'#233'rie'
            TabOrder = 13
            OnClick = btnNumSerieClick
          end
        end
        object tsConfGeral: TTabSheet
          Caption = 'Geral'
          object GroupBox3: TGroupBox
            Left = 3
            Top = 12
            Width = 764
            Height = 464
            Caption = 'Geral'
            ParentBackground = False
            TabOrder = 0
            object sbtnPathSalvar: TSpeedButton
              Left = 529
              Top = 22
              Width = 23
              Height = 24
              Glyph.Data = {
                76010000424D7601000000000000760000002800000020000000100000000100
                04000000000000010000130B0000130B00001000000000000000000000000000
                800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
                333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
                0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
                07333337F3FF3FFF7F333330F00F000F07333337F77377737F333330FFFFFFFF
                07333FF7F3FFFF3F7FFFBBB0F0000F0F0BB37777F7777373777F3BB0FFFFFFFF
                0BBB3777F3FF3FFF77773330F00F000003333337F773777773333330FFFF0FF0
                33333337F3FF7F37F3333330F08F0F0B33333337F7737F77FF333330FFFF003B
                B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
                3BB33773333773333773B333333B3333333B7333333733333337}
              NumGlyphs = 2
              OnClick = sbtnPathSalvarClick
            end
            object Label29: TLabel
              Left = 22
              Top = 90
              Width = 86
              Height = 13
              Caption = 'Forma de Emiss'#227'o'
              Transparent = True
            end
            object Label31: TLabel
              Left = 22
              Top = 52
              Width = 72
              Height = 13
              Caption = 'Formato Alerta'
              Transparent = True
            end
            object Label30: TLabel
              Left = 22
              Top = 128
              Width = 120
              Height = 13
              Caption = 'Modelo Documento Fiscal'
              Transparent = True
            end
            object Label32: TLabel
              Left = 22
              Top = 167
              Width = 59
              Height = 13
              Caption = 'Vers'#227'o DF-e'
              Transparent = True
            end
            object Label33: TLabel
              Left = 299
              Top = 85
              Width = 184
              Height = 13
              Caption = 'IdToken/IdCSC (Somente para NFC-e)'
              Transparent = True
            end
            object Label34: TLabel
              Left = 298
              Top = 125
              Width = 164
              Height = 13
              Caption = 'Token/CSC (Somente para NFC-e)'
              Transparent = True
            end
            object Label42: TLabel
              Left = 22
              Top = 262
              Width = 198
              Height = 13
              Caption = 'Diret'#243'rios com os arquivos XSD(Schemas)'
              Transparent = True
            end
            object spPathSchemas: TSpeedButton
              Left = 252
              Top = 278
              Width = 23
              Height = 24
              Glyph.Data = {
                76010000424D7601000000000000760000002800000020000000100000000100
                04000000000000010000130B0000130B00001000000000000000000000000000
                800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
                333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
                0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
                07333337F3FF3FFF7F333330F00F000F07333337F77377737F333330FFFFFFFF
                07333FF7F3FFFF3F7FFFBBB0F0000F0F0BB37777F7777373777F3BB0FFFFFFFF
                0BBB3777F3FF3FFF77773330F00F000003333337F773777773333330FFFF0FF0
                33333337F3FF7F37F3333330F08F0F0B33333337F7737F77FF333330FFFF003B
                B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
                3BB33773333773333773B333333B3333333B7333333733333337}
              NumGlyphs = 2
              OnClick = spPathSchemasClick
            end
            object Label41: TLabel
              Left = 299
              Top = 164
              Width = 140
              Height = 13
              Caption = 'IdCSRT (Somente SEFAZ-PR)'
              Transparent = True
            end
            object Label46: TLabel
              Left = 298
              Top = 204
              Width = 130
              Height = 13
              Caption = 'CSRT (Somente SEFAZ-PR)'
              Transparent = True
            end
            object Label53: TLabel
              Left = 147
              Top = 167
              Width = 80
              Height = 13
              Caption = 'Vers'#227'o QR-Code'
              Transparent = True
            end
            object edtPathLogs: TEdit
              Left = 299
              Top = 25
              Width = 228
              Height = 21
              TabOrder = 0
            end
            object ckSalvar: TCheckBox
              Left = 22
              Top = 225
              Width = 208
              Height = 19
              Caption = 'Salvar Arquivos de Envio e Resposta'
              TabOrder = 1
            end
            object cbFormaEmissao: TComboBox
              Left = 22
              Top = 106
              Width = 248
              Height = 21
              TabOrder = 2
            end
            object cbxAtualizarXML: TCheckBox
              Left = 22
              Top = 18
              Width = 90
              Height = 19
              Caption = 'Atualizar XML'
              TabOrder = 3
            end
            object cbxExibirErroSchema: TCheckBox
              Left = 22
              Top = 34
              Width = 116
              Height = 19
              Caption = 'Exibir Erro Schema'
              TabOrder = 4
            end
            object edtFormatoAlerta: TEdit
              Left = 22
              Top = 68
              Width = 248
              Height = 21
              TabOrder = 5
            end
            object cbModeloDF: TComboBox
              Left = 22
              Top = 144
              Width = 248
              Height = 21
              TabOrder = 6
            end
            object cbxRetirarAcentos: TCheckBox
              Left = 22
              Top = 207
              Width = 202
              Height = 19
              Caption = 'Retirar Acentos dos XMLs enviados'
              TabOrder = 7
            end
            object cbVersaoDF: TComboBox
              Left = 22
              Top = 183
              Width = 113
              Height = 21
              TabOrder = 8
            end
            object edtIdToken: TEdit
              Left = 299
              Top = 101
              Width = 248
              Height = 21
              TabOrder = 9
            end
            object edtToken: TEdit
              Left = 298
              Top = 141
              Width = 248
              Height = 21
              TabOrder = 10
            end
            object edtPathSchemas: TEdit
              Left = 22
              Top = 278
              Width = 228
              Height = 21
              TabOrder = 11
            end
            object edtIdCSRT: TEdit
              Left = 299
              Top = 180
              Width = 248
              Height = 21
              TabOrder = 12
            end
            object edtCSRT: TEdit
              Left = 298
              Top = 220
              Width = 248
              Height = 21
              TabOrder = 13
            end
            object cbVersaoQRCode: TComboBox
              Left = 147
              Top = 183
              Width = 113
              Height = 21
              TabOrder = 14
            end
          end
        end
        object tsConfWebService: TTabSheet
          Caption = 'WebService'
          object GroupBox4: TGroupBox
            Left = 5
            Top = 4
            Width = 265
            Height = 190
            Caption = 'WebService'
            ParentBackground = False
            TabOrder = 0
            object Label6: TLabel
              Left = 7
              Top = 17
              Width = 126
              Height = 13
              Caption = 'Selecione UF do Emitente:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              Transparent = True
            end
            object lSSLLib1: TLabel
              Left = 19
              Top = 169
              Width = 41
              Height = 13
              Alignment = taRightJustify
              Caption = 'SSLType'
              Color = clBtnFace
              ParentColor = False
              Transparent = True
            end
            object lTimeOut: TLabel
              Left = 166
              Top = 117
              Width = 40
              Height = 13
              Caption = 'TimeOut'
              Color = clBtnFace
              ParentColor = False
              Transparent = True
            end
            object cbxVisualizar: TCheckBox
              Left = 7
              Top = 119
              Width = 129
              Height = 19
              Caption = 'Visualizar Mensagem'
              TabOrder = 0
            end
            object cbUF: TComboBox
              Left = 7
              Top = 33
              Width = 249
              Height = 24
              Style = csDropDownList
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ItemIndex = 24
              ParentFont = False
              TabOrder = 1
              Text = 'SP'
              Items.Strings = (
                'AC'
                'AL'
                'AP'
                'AM'
                'BA'
                'CE'
                'DF'
                'ES'
                'GO'
                'MA'
                'MT'
                'MS'
                'MG'
                'PA'
                'PB'
                'PR'
                'PE'
                'PI'
                'RJ'
                'RN'
                'RS'
                'RO'
                'RR'
                'SC'
                'SP'
                'SE'
                'TO')
            end
            object rgTipoAmb: TRadioGroup
              Left = 7
              Top = 62
              Width = 249
              Height = 52
              Caption = 'Selecione o Ambiente de Destino'
              Columns = 2
              ItemIndex = 0
              Items.Strings = (
                'Produ'#231#227'o'
                'Homologa'#231#227'o')
              ParentBackground = False
              TabOrder = 2
            end
            object cbxSalvarSOAP: TCheckBox
              Left = 7
              Top = 137
              Width = 134
              Height = 19
              Caption = 'Salvar envelope SOAP'
              TabOrder = 3
            end
            object cbSSLType: TComboBox
              Left = 71
              Top = 161
              Width = 160
              Height = 21
              Hint = 'Depende de configura'#231#227'o de  SSL.HttpLib'
              Style = csDropDownList
              TabOrder = 4
            end
            object seTimeOut: TSpinEdit
              Left = 166
              Top = 133
              Width = 66
              Height = 22
              Increment = 10
              MaxValue = 999999
              MinValue = 1000
              TabOrder = 5
              Value = 5000
            end
          end
          object gbProxy: TGroupBox
            Left = 275
            Top = 13
            Width = 265
            Height = 104
            Caption = 'Proxy'
            ParentBackground = False
            TabOrder = 1
            object Label8: TLabel
              Left = 6
              Top = 14
              Width = 22
              Height = 13
              Caption = 'Host'
              Transparent = True
            end
            object Label9: TLabel
              Left = 206
              Top = 14
              Width = 26
              Height = 13
              Caption = 'Porta'
              Transparent = True
            end
            object Label10: TLabel
              Left = 6
              Top = 54
              Width = 36
              Height = 13
              Caption = 'Usu'#225'rio'
              Transparent = True
            end
            object Label11: TLabel
              Left = 136
              Top = 54
              Width = 30
              Height = 13
              Caption = 'Senha'
              Transparent = True
            end
            object edtProxyHost: TEdit
              Left = 6
              Top = 30
              Width = 193
              Height = 21
              TabOrder = 0
            end
            object edtProxyPorta: TEdit
              Left = 206
              Top = 30
              Width = 50
              Height = 21
              TabOrder = 1
            end
            object edtProxyUser: TEdit
              Left = 6
              Top = 70
              Width = 123
              Height = 21
              TabOrder = 2
            end
            object edtProxySenha: TEdit
              Left = 133
              Top = 70
              Width = 123
              Height = 21
              PasswordChar = '*'
              TabOrder = 3
            end
          end
          object gbxRetornoEnvio: TGroupBox
            Left = 5
            Top = 200
            Width = 265
            Height = 115
            Caption = 'Retorno de Envio'
            ParentBackground = False
            TabOrder = 2
            object Label36: TLabel
              Left = 91
              Top = 48
              Width = 51
              Height = 13
              Caption = 'Tentativas'
              Transparent = True
            end
            object Label37: TLabel
              Left = 174
              Top = 48
              Width = 44
              Height = 13
              Caption = 'Intervalo'
              Transparent = True
            end
            object Label38: TLabel
              Left = 6
              Top = 48
              Width = 45
              Height = 13
              Hint = 
                'Aguardar quantos segundos para primeira consulta de retorno de e' +
                'nvio'
              Caption = 'Aguardar'
              Transparent = True
            end
            object cbxAjustarAut: TCheckBox
              Left = 7
              Top = 29
              Width = 246
              Height = 19
              Caption = 'Ajustar Automaticamente prop. "Aguardar"'
              TabOrder = 0
            end
            object edtTentativas: TEdit
              Left = 91
              Top = 64
              Width = 57
              Height = 21
              TabOrder = 2
            end
            object edtIntervalo: TEdit
              Left = 174
              Top = 64
              Width = 57
              Height = 21
              TabOrder = 3
            end
            object edtAguardar: TEdit
              Left = 6
              Top = 64
              Width = 57
              Height = 21
              Hint = 
                'Aguardar quantos segundos para primeira consulta de retorno de e' +
                'nvio'
              TabOrder = 1
            end
          end
        end
        object tsConfEmitente: TTabSheet
          Caption = 'Emitente'
          object Label12: TLabel
            Left = 8
            Top = 4
            Width = 25
            Height = 13
            Caption = 'CNPJ'
            Transparent = True
          end
          object Label13: TLabel
            Left = 136
            Top = 4
            Width = 43
            Height = 13
            Caption = 'Insc.Est.'
            Transparent = True
          end
          object Label14: TLabel
            Left = 8
            Top = 44
            Width = 60
            Height = 13
            Caption = 'Raz'#227'o Social'
            Transparent = True
          end
          object Label15: TLabel
            Left = 8
            Top = 84
            Width = 41
            Height = 13
            Caption = 'Fantasia'
            Transparent = True
          end
          object Label16: TLabel
            Left = 8
            Top = 164
            Width = 55
            Height = 13
            Caption = 'Logradouro'
            Transparent = True
          end
          object Label17: TLabel
            Left = 208
            Top = 164
            Width = 37
            Height = 13
            Caption = 'N'#250'mero'
            Transparent = True
          end
          object Label18: TLabel
            Left = 8
            Top = 204
            Width = 65
            Height = 13
            Caption = 'Complemento'
            Transparent = True
          end
          object Label19: TLabel
            Left = 136
            Top = 204
            Width = 28
            Height = 13
            Caption = 'Bairro'
            Transparent = True
          end
          object Label20: TLabel
            Left = 8
            Top = 244
            Width = 62
            Height = 13
            Caption = 'C'#243'd. Cidade '
            Transparent = True
          end
          object Label21: TLabel
            Left = 76
            Top = 244
            Width = 33
            Height = 13
            Caption = 'Cidade'
            Transparent = True
          end
          object Label22: TLabel
            Left = 225
            Top = 244
            Width = 13
            Height = 13
            Caption = 'UF'
            Transparent = True
          end
          object Label23: TLabel
            Left = 136
            Top = 124
            Width = 19
            Height = 13
            Caption = 'CEP'
            Transparent = True
          end
          object Label24: TLabel
            Left = 8
            Top = 124
            Width = 24
            Height = 13
            Caption = 'Fone'
            Transparent = True
          end
          object Label52: TLabel
            Left = 8
            Top = 289
            Width = 83
            Height = 13
            Caption = 'Tipo de Empresa:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object edtEmitCNPJ: TEdit
            Left = 8
            Top = 20
            Width = 123
            Height = 21
            TabOrder = 0
          end
          object edtEmitIE: TEdit
            Left = 137
            Top = 20
            Width = 123
            Height = 21
            TabOrder = 1
          end
          object edtEmitRazao: TEdit
            Left = 8
            Top = 60
            Width = 252
            Height = 21
            TabOrder = 2
          end
          object edtEmitFantasia: TEdit
            Left = 8
            Top = 100
            Width = 252
            Height = 21
            TabOrder = 3
          end
          object edtEmitFone: TEdit
            Left = 8
            Top = 140
            Width = 125
            Height = 21
            TabOrder = 4
          end
          object edtEmitCEP: TEdit
            Left = 137
            Top = 140
            Width = 123
            Height = 21
            TabOrder = 5
          end
          object edtEmitLogradouro: TEdit
            Left = 8
            Top = 180
            Width = 196
            Height = 21
            TabOrder = 6
          end
          object edtEmitNumero: TEdit
            Left = 210
            Top = 180
            Width = 50
            Height = 21
            TabOrder = 7
          end
          object edtEmitComp: TEdit
            Left = 8
            Top = 220
            Width = 123
            Height = 21
            TabOrder = 8
          end
          object edtEmitBairro: TEdit
            Left = 137
            Top = 220
            Width = 123
            Height = 21
            TabOrder = 9
          end
          object edtEmitCodCidade: TEdit
            Left = 8
            Top = 260
            Width = 61
            Height = 21
            TabOrder = 10
          end
          object edtEmitCidade: TEdit
            Left = 76
            Top = 260
            Width = 142
            Height = 21
            TabOrder = 11
          end
          object edtEmitUF: TEdit
            Left = 225
            Top = 260
            Width = 35
            Height = 21
            TabOrder = 12
          end
          object cbTipoEmpresa: TComboBox
            Left = 8
            Top = 305
            Width = 249
            Height = 24
            Style = csDropDownList
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 13
            Items.Strings = (
              'Simples Nacional'
              'Simples Nacional, excesso sublimite de receita bruta'
              'Regime Normal')
          end
        end
        object TabArquivos: TTabSheet
          Caption = 'Arquivos'
          object sbPathNFe: TSpeedButton
            Left = 247
            Top = 131
            Width = 23
            Height = 24
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000130B0000130B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
              333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
              0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
              07333337F3FF3FFF7F333330F00F000F07333337F77377737F333330FFFFFFFF
              07333FF7F3FFFF3F7FFFBBB0F0000F0F0BB37777F7777373777F3BB0FFFFFFFF
              0BBB3777F3FF3FFF77773330F00F000003333337F773777773333330FFFF0FF0
              33333337F3FF7F37F3333330F08F0F0B33333337F7737F77FF333330FFFF003B
              B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
              3BB33773333773333773B333333B3333333B7333333733333337}
            NumGlyphs = 2
            OnClick = sbPathNFeClick
          end
          object Label35: TLabel
            Left = 6
            Top = 116
            Width = 94
            Height = 13
            Caption = 'Pasta Arquivos NFe'
            Transparent = True
          end
          object Label40: TLabel
            Left = 6
            Top = 202
            Width = 129
            Height = 13
            Caption = 'Pasta Arquivos Inutiliza'#231#227'o'
            Transparent = True
          end
          object sbPathInu: TSpeedButton
            Left = 247
            Top = 217
            Width = 23
            Height = 24
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000130B0000130B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
              333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
              0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
              07333337F3FF3FFF7F333330F00F000F07333337F77377737F333330FFFFFFFF
              07333FF7F3FFFF3F7FFFBBB0F0000F0F0BB37777F7777373777F3BB0FFFFFFFF
              0BBB3777F3FF3FFF77773330F00F000003333337F773777773333330FFFF0FF0
              33333337F3FF7F37F3333330F08F0F0B33333337F7737F77FF333330FFFF003B
              B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
              3BB33773333773333773B333333B3333333B7333333733333337}
            NumGlyphs = 2
            OnClick = sbPathInuClick
          end
          object Label47: TLabel
            Left = 6
            Top = 159
            Width = 109
            Height = 13
            Caption = 'Pasta Arquivos Evento'
            Transparent = True
          end
          object sbPathEvento: TSpeedButton
            Left = 247
            Top = 174
            Width = 23
            Height = 24
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000130B0000130B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
              333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
              0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
              07333337F3FF3FFF7F333330F00F000F07333337F77377737F333330FFFFFFFF
              07333FF7F3FFFF3F7FFFBBB0F0000F0F0BB37777F7777373777F3BB0FFFFFFFF
              0BBB3777F3FF3FFF77773330F00F000003333337F773777773333330FFFF0FF0
              33333337F3FF7F37F3333330F08F0F0B33333337F7737F77FF333330FFFF003B
              B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
              3BB33773333773333773B333333B3333333B7333333733333337}
            NumGlyphs = 2
            OnClick = sbPathEventoClick
          end
          object Label39: TLabel
            Left = 6
            Top = 245
            Width = 94
            Height = 13
            Caption = 'Pasta Arquivos PDF'
            Transparent = True
          end
          object sbPathPDF: TSpeedButton
            Left = 247
            Top = 260
            Width = 23
            Height = 24
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000130B0000130B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
              333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
              0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
              07333337F3FF3FFF7F333330F00F000F07333337F77377737F333330FFFFFFFF
              07333FF7F3FFFF3F7FFFBBB0F0000F0F0BB37777F7777373777F3BB0FFFFFFFF
              0BBB3777F3FF3FFF77773330F00F000003333337F773777773333330FFFF0FF0
              33333337F3FF7F37F3333330F08F0F0B33333337F7737F77FF333330FFFF003B
              B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
              3BB33773333773333773B333333B3333333B7333333733333337}
            NumGlyphs = 2
            OnClick = sbPathPDFClick
          end
          object cbxSalvarArqs: TCheckBox
            Left = 6
            Top = 0
            Width = 98
            Height = 19
            Caption = 'Salvar Arquivos'
            TabOrder = 0
          end
          object cbxPastaMensal: TCheckBox
            Left = 6
            Top = 16
            Width = 152
            Height = 19
            Caption = 'Criar Pastas Mensalmente'
            TabOrder = 1
          end
          object cbxAdicionaLiteral: TCheckBox
            Left = 6
            Top = 32
            Width = 213
            Height = 19
            Caption = 'Adicionar Literal no nome das pastas'
            TabOrder = 2
          end
          object cbxEmissaoPathNFe: TCheckBox
            Left = 6
            Top = 48
            Width = 274
            Height = 19
            Caption = 'Salvar Documento pelo campo Data de Emiss'#227'o'
            TabOrder = 3
          end
          object cbxSalvaPathEvento: TCheckBox
            Left = 6
            Top = 64
            Width = 159
            Height = 19
            Caption = 'Salvar Arquivos de Eventos'
            TabOrder = 4
          end
          object cbxSepararPorCNPJ: TCheckBox
            Left = 6
            Top = 80
            Width = 221
            Height = 19
            Caption = 'Separar Arqs pelo CNPJ do Certificado'
            TabOrder = 5
          end
          object edtPathNFe: TEdit
            Left = 6
            Top = 132
            Width = 235
            Height = 21
            TabOrder = 7
          end
          object edtPathInu: TEdit
            Left = 6
            Top = 218
            Width = 235
            Height = 21
            TabOrder = 9
          end
          object edtPathEvento: TEdit
            Left = 6
            Top = 175
            Width = 235
            Height = 21
            TabOrder = 8
          end
          object cbxSepararPorModelo: TCheckBox
            Left = 6
            Top = 96
            Width = 240
            Height = 19
            Caption = 'Separar Arqs pelo Modelo do Documento'
            TabOrder = 6
          end
          object edtPathPDF: TEdit
            Left = 6
            Top = 261
            Width = 235
            Height = 21
            TabOrder = 10
          end
        end
      end
    end
    object tbDocAuxiliar: TTabSheet
      Caption = 'Documento Auxiliar'
      object Label7: TLabel
        Left = 8
        Top = 8
        Width = 55
        Height = 13
        Caption = 'Logo Marca'
        Transparent = True
      end
      object sbtnLogoMarca: TSpeedButton
        Left = 238
        Top = 22
        Width = 23
        Height = 24
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
          333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
          0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
          07333337F3FF3FFF7F333330F00F000F07333337F77377737F333330FFFFFFFF
          07333FF7F3FFFF3F7FFFBBB0F0000F0F0BB37777F7777373777F3BB0FFFFFFFF
          0BBB3777F3FF3FFF77773330F00F000003333337F773777773333330FFFF0FF0
          33333337F3FF7F37F3333330F08F0F0B33333337F7737F77FF333330FFFF003B
          B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
          3BB33773333773333773B333333B3333333B7333333733333337}
        NumGlyphs = 2
      end
      object edtLogoMarca: TEdit
        Left = 8
        Top = 24
        Width = 228
        Height = 21
        TabOrder = 0
      end
      object rgTipoDanfe: TRadioGroup
        Left = 8
        Top = 56
        Width = 257
        Height = 58
        Caption = 'DANFE'
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          'Retrato'
          'Paisagem'
          'Simplificado'
          'Simplificado Tipo 2')
        ParentBackground = False
        TabOrder = 1
      end
      object rgDANFCE: TRadioGroup
        Left = 8
        Top = 128
        Width = 257
        Height = 49
        Caption = 'DANFCE'
        Columns = 3
        ItemIndex = 0
        Items.Strings = (
          'Fortes'
          'EscPos'
          'A4')
        ParentBackground = False
        TabOrder = 2
      end
      object gbEscPos: TGroupBox
        Left = 275
        Top = 13
        Width = 257
        Height = 233
        Caption = 'EscPos'
        ParentBackground = False
        TabOrder = 3
        object Label43: TLabel
          Left = 6
          Top = 10
          Width = 34
          Height = 13
          Caption = 'Modelo'
          Color = clBtnFace
          ParentColor = False
          Transparent = True
        end
        object Label44: TLabel
          Left = 6
          Top = 58
          Width = 26
          Height = 13
          Caption = 'Porta'
          Color = clBtnFace
          ParentColor = False
          Transparent = True
        end
        object Label45: TLabel
          Left = 6
          Top = 170
          Width = 55
          Height = 13
          Caption = 'Pag.Codigo'
          Color = clBtnFace
          ParentColor = False
          Transparent = True
        end
        object Label48: TLabel
          Left = 6
          Top = 122
          Width = 38
          Height = 13
          Caption = 'Colunas'
          Color = clBtnFace
          ParentColor = False
          Transparent = True
        end
        object Label49: TLabel
          Left = 78
          Top = 106
          Width = 39
          Height = 26
          Caption = 'Espa'#231'os'#13#10'Linhas'
          Color = clBtnFace
          ParentColor = False
          Transparent = True
        end
        object Label50: TLabel
          Left = 142
          Top = 106
          Width = 30
          Height = 26
          Caption = 'Linhas'#13#10'Pular'
          Color = clBtnFace
          ParentColor = False
          Transparent = True
        end
        object btSerial: TBitBtn
          Left = 214
          Top = 74
          Width = 22
          Height = 22
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            1800000000000003000000000000000000000000000000000000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF323232
            3232323E3E3E565656FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3E3E3EFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFF565656FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3E3E3EFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFF503200FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            565656565656FFFFFFFFFFFF3232322626262626262626262626265032005032
            000000504873FFFFFFFFFFFFFFFFFFFF6E6E6EFFFFFFFFFFFFFFFFFFFFFFFF6E
            6E6E32323232323232323232323250320000005025AAFFFFFFFFFFFFFF565656
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5656563232323232326E6E6E5032005032
            008FFF6B8ED4FFFFFFFFFFFFFFFFFFFF3E3E3EFFFFFFFFFFFF50320050320056
            56564A4A4A5050003232325032005032008FFF6B8ED4FFFFFFFFFFFFFFFFFFFF
            FFFFFF5656563E3E3E2626265032006262625656565050003232325032005032
            008FFF6B8ED4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5050005050006E
            6E6E5656565050003250005032005032008FFF6B8ED4FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8686865656565656563250005032005032
            008FFF6B48B8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3232323E
            3E3EA4A0A08686866E6E6E565656503200C0C0C02557FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFF5050004A4A4A3232323232323232323232325032
            00FFFFFF6B8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
          Layout = blGlyphTop
          ModalResult = 1
          TabOrder = 0
        end
        object cbxModeloPosPrinter: TComboBox
          Left = 6
          Top = 26
          Width = 233
          Height = 21
          Style = csDropDownList
          TabOrder = 1
        end
        object cbxPorta: TComboBox
          Left = 6
          Top = 74
          Width = 201
          Height = 21
          TabOrder = 2
        end
        object btProcuraPortas: TButton
          Left = 210
          Top = 73
          Width = 29
          Height = 23
          Hint = 'Procurar portas (seriais e impressoras do Windows)'
          Caption = '...'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 8
          OnClick = btProcuraPortasClick
        end
        object cbxPagCodigo: TComboBox
          Left = 6
          Top = 186
          Width = 101
          Height = 21
          Style = csDropDownList
          TabOrder = 3
        end
        object seColunas: TSpinEdit
          Left = 6
          Top = 138
          Width = 49
          Height = 22
          MaxValue = 9999
          MinValue = 0
          TabOrder = 4
          Value = 0
        end
        object seEspLinhas: TSpinEdit
          Left = 78
          Top = 138
          Width = 49
          Height = 22
          MaxValue = 9999
          MinValue = 0
          TabOrder = 5
          Value = 0
        end
        object seLinhasPular: TSpinEdit
          Left = 142
          Top = 138
          Width = 49
          Height = 22
          MaxValue = 9999
          MinValue = 0
          TabOrder = 6
          Value = 0
        end
        object cbCortarPapel: TCheckBox
          Left = 141
          Top = 182
          Width = 82
          Height = 19
          Hint = 
            'Conecta a Porta Serial a cada comando enviado'#13#10'Desconecta da Por' +
            'ta Serial ap'#243's o envio'
          Caption = 'Cortar Papel'
          Checked = True
          State = cbChecked
          TabOrder = 7
        end
      end
    end
  end
  object pnpRodape: TPanel
    Left = 0
    Top = 618
    Width = 789
    Height = 50
    Align = alBottom
    ParentBackground = False
    TabOrder = 1
    inline frameRodape1: TframeRodape
      Left = 1
      Top = 1
      Width = 787
      Height = 48
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
        Left = 642
        OnClick = btnSalvarClick
      end
      inherited lblTexto: TLabel
      end
    end
  end
end
