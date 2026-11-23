object frmACBrDeRE: TfrmACBrDeRE
  Left = 226
  Top = 114
  Caption = 'ACBrDeRE - Programa Exemplo'
  ClientHeight = 752
  ClientWidth = 1099
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 13
  object pnlMenus: TPanel
    Left = 0
    Top = 0
    Width = 297
    Height = 752
    Align = alLeft
    TabOrder = 0
    object lblColaborador: TLabel
      Left = 18
      Top = 540
      Width = 261
      Height = 13
      Cursor = crHandPoint
      Caption = 'Veja a lista de Colaboradores do Projeto ACBr'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = lblColaboradorClick
    end
    object lblPatrocinador: TLabel
      Left = 16
      Top = 555
      Width = 265
      Height = 13
      Cursor = crHandPoint
      Caption = 'Veja a lista de Patrocinadores do Projeto ACBr'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = lblPatrocinadorClick
    end
    object lblDoar1: TLabel
      Left = 21
      Top = 570
      Width = 255
      Height = 13
      Cursor = crHandPoint
      Caption = 'Para se tornar Patrocinador do Projeto ACBr,'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = lblDoar1Click
    end
    object lblDoar2: TLabel
      Left = 117
      Top = 583
      Width = 63
      Height = 13
      Cursor = crHandPoint
      Caption = 'clique aqui'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = lblDoar2Click
    end
    object pgPrincipal: TPageControl
      Left = 1
      Top = 1
      Width = 295
      Height = 504
      ActivePage = tsConfig
      TabOrder = 0
      object tsConfig: TTabSheet
        Caption = 'Configura'#231#245'es'
        object pgConfig: TPageControl
          Left = 0
          Top = 0
          Width = 287
          Height = 476
          ActivePage = tsCertificado
          Align = alClient
          MultiLine = True
          TabOrder = 0
          object tsCertificado: TTabSheet
            Caption = 'Certificado'
            object lblSSLLib: TLabel
              Left = 39
              Top = 16
              Width = 30
              Height = 13
              Alignment = taRightJustify
              Caption = 'SSLLib'
              Color = clBtnFace
              ParentColor = False
            end
            object lblCryptLib: TLabel
              Left = 29
              Top = 43
              Width = 40
              Height = 13
              Alignment = taRightJustify
              Caption = 'CryptLib'
              Color = clBtnFace
              ParentColor = False
            end
            object lblHttpLib: TLabel
              Left = 35
              Top = 70
              Width = 34
              Height = 13
              Alignment = taRightJustify
              Caption = 'HttpLib'
              Color = clBtnFace
              ParentColor = False
            end
            object lblXmlSignLib: TLabel
              Left = 17
              Top = 97
              Width = 52
              Height = 13
              Alignment = taRightJustify
              Caption = 'XMLSignLib'
              Color = clBtnFace
              ParentColor = False
            end
            object gbCertificado: TGroupBox
              Left = 2
              Top = 118
              Width = 263
              Height = 144
              Caption = 'Certificado'
              TabOrder = 4
              object lblCaminhoCert: TLabel
                Left = 8
                Top = 16
                Width = 41
                Height = 13
                Caption = 'Caminho'
              end
              object lblSenhaCert: TLabel
                Left = 8
                Top = 56
                Width = 30
                Height = 13
                Caption = 'Senha'
              end
              object sbtnCaminhoCert: TSpeedButton
                Left = 235
                Top = 32
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
              object lblNumSerie: TLabel
                Left = 8
                Top = 96
                Width = 79
                Height = 13
                Caption = 'N'#250'mero de S'#233'rie'
              end
              object sbtnGetCert: TSpeedButton
                Left = 235
                Top = 110
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
                Left = 206
                Top = 110
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
              object edtCaminho: TEdit
                Left = 8
                Top = 32
                Width = 225
                Height = 21
                TabOrder = 0
              end
              object edtSenha: TEdit
                Left = 8
                Top = 72
                Width = 249
                Height = 21
                PasswordChar = '*'
                TabOrder = 1
              end
              object edtNumSerie: TEdit
                Left = 8
                Top = 112
                Width = 193
                Height = 21
                TabOrder = 2
              end
            end
            object btnDataValidade: TButton
              Left = 8
              Top = 266
              Width = 99
              Height = 25
              Caption = 'Data de Validade'
              TabOrder = 5
              OnClick = btnDataValidadeClick
            end
            object btnNumSerie: TButton
              Left = 112
              Top = 266
              Width = 73
              Height = 25
              Caption = 'Num.S'#233'rie'
              TabOrder = 6
              OnClick = btnNumSerieClick
            end
            object btnRazaoSocial: TButton
              Left = 8
              Top = 298
              Width = 99
              Height = 25
              Caption = 'Raz'#227'o Social'
              TabOrder = 7
              OnClick = btnRazaoSocialClick
            end
            object btnCNPJ: TButton
              Left = 112
              Top = 298
              Width = 73
              Height = 25
              Caption = 'CNPJ'
              TabOrder = 8
              OnClick = btnCNPJClick
            end
            object cbSSLLib: TComboBox
              Left = 80
              Top = 8
              Width = 160
              Height = 21
              Style = csDropDownList
              TabOrder = 0
              OnChange = cbSSLLibChange
            end
            object cbCryptLib: TComboBox
              Left = 80
              Top = 35
              Width = 160
              Height = 21
              Style = csDropDownList
              TabOrder = 1
              OnChange = cbCryptLibChange
            end
            object cbHttpLib: TComboBox
              Left = 80
              Top = 62
              Width = 160
              Height = 21
              Style = csDropDownList
              TabOrder = 2
              OnChange = cbHttpLibChange
            end
            object cbXmlSignLib: TComboBox
              Left = 80
              Top = 89
              Width = 160
              Height = 21
              Style = csDropDownList
              TabOrder = 3
              OnChange = cbXmlSignLibChange
            end
          end
          object tsGeral: TTabSheet
            Caption = 'Geral'
            ImageIndex = 1
            object gbGeral: TGroupBox
              Left = 3
              Top = 12
              Width = 265
              Height = 389
              Caption = 'Geral'
              TabOrder = 0
              object lblFormatoAlerta: TLabel
                Left = 8
                Top = 50
                Width = 72
                Height = 13
                Caption = 'Formato Alerta'
              end
              object lblVersaoDF: TLabel
                Left = 8
                Top = 92
                Width = 119
                Height = 13
                Caption = 'Vers'#227'o Documento Fiscal'
              end
              object lblPathSchemas: TLabel
                Left = 8
                Top = 198
                Width = 193
                Height = 13
                Caption = 'Diret'#243'rio com os arquivos XSD(Schemas)'
              end
              object sbtnPathLogs: TSpeedButton
                Left = 238
                Top = 167
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
                OnClick = sbtnPathLogsClick
              end
              object sbtnPathSchemas: TSpeedButton
                Left = 238
                Top = 214
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
                OnClick = sbtnPathSchemasClick
              end
              object cbxAtualizarXML: TCheckBox
                Left = 8
                Top = 16
                Width = 97
                Height = 17
                Caption = 'Atualizar XML'
                TabOrder = 0
              end
              object cbxExibirErroSchema: TCheckBox
                Left = 8
                Top = 32
                Width = 129
                Height = 17
                Caption = 'Exibir Erro Schema'
                TabOrder = 1
              end
              object edtFormatoAlerta: TEdit
                Left = 8
                Top = 66
                Width = 248
                Height = 21
                TabOrder = 2
              end
              object cbVersaoDF: TComboBox
                Left = 8
                Top = 108
                Width = 248
                Height = 21
                Style = csDropDownList
                TabOrder = 3
              end
              object cbxRetirarAcentos: TCheckBox
                Left = 8
                Top = 136
                Width = 193
                Height = 17
                Caption = 'Retirar Acentos dos XMLs enviados'
                TabOrder = 4
              end
              object cbxSalvar: TCheckBox
                Left = 8
                Top = 154
                Width = 209
                Height = 17
                Caption = 'Salvar Arquivos de Envio e Resposta'
                TabOrder = 5
              end
              object edtPathLogs: TEdit
                Left = 8
                Top = 170
                Width = 228
                Height = 21
                TabOrder = 6
              end
              object edtPathSchemas: TEdit
                Left = 8
                Top = 214
                Width = 228
                Height = 21
                TabOrder = 7
              end
            end
          end
          object tsWebService: TTabSheet
            Caption = 'WebService'
            ImageIndex = 2
            object gbWebService: TGroupBox
              Left = 5
              Top = 4
              Width = 265
              Height = 128
              Caption = 'WebService'
              TabOrder = 0
              object lblTimeOut: TLabel
                Left = 8
                Top = 76
                Width = 40
                Height = 13
                Caption = 'TimeOut'
                Color = clBtnFace
                ParentColor = False
              end
              object lblSSLType: TLabel
                Left = 110
                Top = 76
                Width = 41
                Height = 13
                Caption = 'SSLType'
                Color = clBtnFace
                ParentColor = False
              end
              object rgTipoAmb: TRadioGroup
                Left = 8
                Top = 16
                Width = 249
                Height = 52
                Caption = 'Selecione o Ambiente de Destino'
                Columns = 2
                ItemIndex = 1
                Items.Strings = (
                  'Produ'#231#227'o'
                  'Produ'#231#227'o Restrita')
                TabOrder = 0
              end
              object seTimeOut: TSpinEdit
                Left = 8
                Top = 92
                Width = 90
                Height = 22
                Increment = 10
                MaxValue = 300000
                MinValue = 0
                TabOrder = 1
                Value = 30000
              end
              object cbSSLType: TComboBox
                Left = 110
                Top = 92
                Width = 147
                Height = 21
                Hint = 'Depende de configura'#231#227'o de  SSL.HttpLib'
                Style = csDropDownList
                TabOrder = 2
                OnChange = cbSSLTypeChange
              end
            end
            object gbProxy: TGroupBox
              Left = 5
              Top = 140
              Width = 265
              Height = 104
              Caption = 'Proxy'
              TabOrder = 1
              object lblProxyHost: TLabel
                Left = 8
                Top = 16
                Width = 22
                Height = 13
                Caption = 'Host'
              end
              object lblProxyPorta: TLabel
                Left = 208
                Top = 16
                Width = 26
                Height = 13
                Caption = 'Porta'
              end
              object lblProxyUser: TLabel
                Left = 8
                Top = 56
                Width = 36
                Height = 13
                Caption = 'Usu'#225'rio'
              end
              object lblProxySenha: TLabel
                Left = 138
                Top = 56
                Width = 30
                Height = 13
                Caption = 'Senha'
              end
              object edtProxyHost: TEdit
                Left = 8
                Top = 32
                Width = 193
                Height = 21
                TabOrder = 0
              end
              object edtProxyPorta: TEdit
                Left = 208
                Top = 32
                Width = 50
                Height = 21
                TabOrder = 1
              end
              object edtProxyUser: TEdit
                Left = 8
                Top = 72
                Width = 123
                Height = 21
                TabOrder = 2
              end
              object edtProxySenha: TEdit
                Left = 135
                Top = 72
                Width = 123
                Height = 21
                PasswordChar = '*'
                TabOrder = 3
              end
            end
          end
          object tsEmitente: TTabSheet
            Caption = 'Emitente'
            ImageIndex = 3
            object gbContribuinte: TGroupBox
              Left = 5
              Top = 14
              Width = 263
              Height = 64
              Caption = 'Dados Contribuinte'
              TabOrder = 0
              object lblIdContribuinte: TLabel
                Left = 8
                Top = 18
                Width = 102
                Height = 13
                Caption = 'CNPJ do Contribuinte'
              end
              object edtIdContribuinte: TEdit
                Left = 7
                Top = 34
                Width = 248
                Height = 21
                TabOrder = 0
              end
            end
            object gbApi: TGroupBox
              Left = 5
              Top = 88
              Width = 263
              Height = 110
              Caption = 'API REST DeRE (Receita Integra)'
              TabOrder = 1
              object lblClientId: TLabel
                Left = 8
                Top = 18
                Width = 37
                Height = 13
                Caption = 'ClientId'
              end
              object lblClientSecret: TLabel
                Left = 8
                Top = 58
                Width = 58
                Height = 13
                Caption = 'ClientSecret'
              end
              object edtClientId: TEdit
                Left = 7
                Top = 34
                Width = 248
                Height = 21
                TabOrder = 0
              end
              object edtClientSecret: TEdit
                Left = 7
                Top = 74
                Width = 248
                Height = 21
                PasswordChar = '*'
                TabOrder = 1
              end
            end
            object gbToken: TGroupBox
              Left = 5
              Top = 250
              Width = 263
              Height = 110
              Caption = 'Token de Acesso'
              TabOrder = 2
              object lblToken: TLabel
                Left = 8
                Top = 18
                Width = 31
                Height = 13
                Caption = 'Token'
              end
              object lblTokenExpira: TLabel
                Left = 8
                Top = 58
                Width = 99
                Height = 13
                Caption = 'Validade (TokenExpira)'
              end
              object edtToken: TEdit
                Left = 7
                Top = 34
                Width = 248
                Height = 21
                PasswordChar = '*'
                TabOrder = 0
              end
              object edtTokenExpira: TEdit
                Left = 7
                Top = 74
                Width = 248
                Height = 21
                TabOrder = 1
              end
            end
          end
          object tsArquivos: TTabSheet
            Caption = 'Arquivos'
            ImageIndex = 4
            object sbtnPathDeRE: TSpeedButton
              Left = 247
              Top = 71
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
              OnClick = sbtnPathDeREClick
            end
            object lblPathDeRE: TLabel
              Left = 6
              Top = 56
              Width = 101
              Height = 13
              Caption = 'Pasta Arquivos DeRE'
            end
            object cbxSepararPorMes: TCheckBox
              Left = 6
              Top = 0
              Width = 210
              Height = 17
              Caption = 'Criar Pastas Mensalmente'
              TabOrder = 0
            end
            object cbxSepararPorCNPJ: TCheckBox
              Left = 6
              Top = 16
              Width = 210
              Height = 17
              Caption = 'Separar Arqs pelo CNPJ do Certificado'
              TabOrder = 1
            end
            object cbxEmissaoPathDeRE: TCheckBox
              Left = 6
              Top = 32
              Width = 251
              Height = 17
              Caption = 'Salvar Documento pelo campo Data de Emiss'#227'o'
              TabOrder = 2
            end
            object edtPathDeRE: TEdit
              Left = 6
              Top = 72
              Width = 235
              Height = 21
              TabOrder = 3
            end
          end
        end
      end
    end
    object btnSalvarConfig: TBitBtn
      Left = 78
      Top = 515
      Width = 153
      Height = 25
      Caption = 'Salvar Configura'#231#245'es'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333330070
        7700333333337777777733333333008088003333333377F73377333333330088
        88003333333377FFFF7733333333000000003FFFFFFF77777777000000000000
        000077777777777777770FFFFFFF0FFFFFF07F3333337F3333370FFFFFFF0FFF
        FFF07F3FF3FF7FFFFFF70F00F0080CCC9CC07F773773777777770FFFFFFFF039
        99337F3FFFF3F7F777F30F0000F0F09999937F7777373777777F0FFFFFFFF999
        99997F3FF3FFF77777770F00F000003999337F773777773777F30FFFF0FF0339
        99337F3FF7F3733777F30F08F0F0337999337F7737F73F7777330FFFF0039999
        93337FFFF7737777733300000033333333337777773333333333}
      NumGlyphs = 2
      TabOrder = 1
      OnClick = btnSalvarConfigClick
    end
  end
  object pnlCentral: TPanel
    Left = 297
    Top = 0
    Width = 802
    Height = 752
    Align = alClient
    TabOrder = 1
    object pgEventos: TPageControl
      Left = 1
      Top = 1
      Width = 800
      Height = 420
      ActivePage = tsEventosTabela
      Align = alTop
      TabOrder = 0
      object tsEventosTabela: TTabSheet
        Caption = 'Eventos de Tabela'
        object cbD1001: TCheckBox
          Left = 12
          Top = 12
          Width = 300
          Height = 17
          Caption = 'D-1001 Informa'#231#245'es do Contribuinte'
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 0
        end
        object cbD1011: TCheckBox
          Left = 12
          Top = 35
          Width = 300
          Height = 17
          Caption = 'D-1011 Plano Geral de Contas Comentado'
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 1
        end
      end
      object tsEventosPeriodicos: TTabSheet
        Caption = 'Eventos Peri'#243'dicos'
        ImageIndex = 1
        object cbD1101: TCheckBox
          Left = 12
          Top = 12
          Width = 300
          Height = 17
          Caption = 'D-1101 Balancete'
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 0
        end
        object cbD1106: TCheckBox
          Left = 12
          Top = 35
          Width = 300
          Height = 17
          Caption = 'D-1106 Identifica'#231#227'o de Aplica'#231#245'es Financeiras'
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 1
        end
        object cbD1121: TCheckBox
          Left = 12
          Top = 58
          Width = 300
          Height = 17
          Caption = 'D-1121 Rela'#231#227'o de Dedu'#231#245'es'
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 2
        end
        object cbD1198: TCheckBox
          Left = 12
          Top = 81
          Width = 300
          Height = 17
          Caption = 'D-1198 Reabertura Mensal'
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 3
        end
        object cbD1199: TCheckBox
          Left = 12
          Top = 104
          Width = 300
          Height = 17
          Caption = 'D-1199 Fechamento Mensal'
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 4
        end
      end
      object tsEventosTransacionais: TTabSheet
        Caption = 'Eventos Transacionais'
        ImageIndex = 2
        object cbD2101: TCheckBox
          Left = 12
          Top = 12
          Width = 300
          Height = 17
          Caption = 'D-2101 D'#233'bito Mensal de Opera'#231#245'es com T'#237'tulos de D'#237'vida'
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 0
        end
        object cbD2102: TCheckBox
          Left = 12
          Top = 35
          Width = 300
          Height = 17
          Caption = 'D-2102 Informa'#231#245'es de Cotistas de Fundos'
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 1
        end
        object cbD2201: TCheckBox
          Left = 12
          Top = 58
          Width = 300
          Height = 17
          Caption = 'D-2201 Servi'#231'os Remunerados por Pre'#231'o'
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 2
        end
        object cbD2202: TCheckBox
          Left = 12
          Top = 81
          Width = 300
          Height = 17
          Caption = 'D-2202 Tarifas do Regime Geral'
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 3
        end
        object cbD2211: TCheckBox
          Left = 12
          Top = 104
          Width = 300
          Height = 17
          Caption = 'D-2211 Opera'#231#245'es de Cr'#233'dito e Valores Mobili'#225'rios'
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 4
        end
        object cbD2221: TCheckBox
          Left = 12
          Top = 127
          Width = 300
          Height = 17
          Caption = 'D-2221 Antecipa'#231#227'o de Receb'#237'veis'
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 5
        end
        object cbD2231: TCheckBox
          Left = 12
          Top = 150
          Width = 300
          Height = 17
          Caption = 'D-2231 Arrendamento Mercantil'
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 6
        end
        object cbD2241: TCheckBox
          Left = 12
          Top = 173
          Width = 300
          Height = 17
          Caption = 'D-2241 Arranjos de Pagamento - Credenciados'
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 7
        end
        object cbD2242: TCheckBox
          Left = 12
          Top = 196
          Width = 300
          Height = 17
          Caption = 'D-2242 Arranjos de Pagamento - Participantes'
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 8
        end
        object cbD2251: TCheckBox
          Left = 12
          Top = 219
          Width = 300
          Height = 17
          Caption = 'D-2251 Seguros, Previd'#234'ncia e Capitaliza'#231#227'o'
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 9
        end
        object cbD2252: TCheckBox
          Left = 12
          Top = 242
          Width = 300
          Height = 17
          Caption = 'D-2252 Seguros sem Cobertura por Sobreviv'#234'ncia'
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 10
        end
        object cbD3201: TCheckBox
          Left = 12
          Top = 265
          Width = 300
          Height = 17
          Caption = 'D-3201 Planos de Assist'#234'ncia '#224' Sa'#250'de'
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 11
        end
        object cbD4201: TCheckBox
          Left = 12
          Top = 288
          Width = 300
          Height = 17
          Caption = 'D-4201 Concursos de Progn'#243'sticos'
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 12
        end
      end
    end
    object pgRespostas: TPageControl
      Left = 1
      Top = 421
      Width = 800
      Height = 330
      ActivePage = tsComandos
      Align = alClient
      TabOrder = 1
      object tsComandos: TTabSheet
        Caption = 'Comandos'
        object lblProtocolo: TLabel
          Left = 10
          Top = 80
          Width = 45
          Height = 13
          Caption = 'Protocolo'
        end
        object btnGerar: TButton
          Left = 15
          Top = 12
          Width = 109
          Height = 25
          Caption = 'Gerar'
          TabOrder = 0
          OnClick = btnGerarClick
        end
        object btnCarregarXML: TButton
          Left = 130
          Top = 12
          Width = 109
          Height = 25
          Caption = 'Carregar XML'
          TabOrder = 1
          OnClick = btnCarregarXMLClick
        end
        object btnCarregarINI: TButton
          Left = 250
          Top = 12
          Width = 109
          Height = 25
          Caption = 'Carregar INI'
          TabOrder = 2
          OnClick = btnCarregarINIClick
        end
        object btnEnviar: TButton
          Left = 15
          Top = 43
          Width = 109
          Height = 25
          Caption = 'Enviar Lote'
          TabOrder = 3
          OnClick = btnEnviarClick
        end
        object btnGravarINI: TButton
          Left = 130
          Top = 43
          Width = 109
          Height = 25
          Caption = 'Gravar INI'
          TabOrder = 6
          OnClick = btnGravarINIClick
        end
        object btnObterToken: TButton
          Left = 250
          Top = 43
          Width = 109
          Height = 25
          Caption = 'Obter Token'
          TabOrder = 7
          OnClick = btnObterTokenClick
        end
        object btnLimparDados: TButton
          Left = 370
          Top = 43
          Width = 170
          Height = 25
          Caption = 'Limpar Dados (Homolog.)'
          TabOrder = 8
          OnClick = btnLimparDadosClick
        end
        object edProtocolo: TEdit
          Left = 10
          Top = 96
          Width = 229
          Height = 21
          TabOrder = 4
        end
        object btnConsultar: TButton
          Left = 250
          Top = 94
          Width = 109
          Height = 25
          Caption = 'Consultar Lote'
          TabOrder = 5
          OnClick = btnConsultarClick
        end
      end
      object tsLog: TTabSheet
        Caption = 'Log'
        ImageIndex = 1
        object memoLog: TMemo
          Left = 0
          Top = 0
          Width = 792
          Height = 302
          Align = alClient
          ScrollBars = ssBoth
          TabOrder = 0
          WordWrap = False
        end
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 661
    Top = 590
  end
  object ACBrDeRE1: TACBrDeRE
    OnStatusChange = ACBrDeRE1StatusChange
    OnGerarLog = ACBrDeRE1GerarLog
    Configuracoes.Geral.SSLLib = libNone
    Configuracoes.Geral.SSLCryptLib = cryNone
    Configuracoes.Geral.SSLHttpLib = httpNone
    Configuracoes.Geral.SSLXmlSignLib = xsNone
    Configuracoes.Geral.FormatoAlerta = 'TAG:%TAGNIVEL% ID:%ID%/%TAG%(%DESCRICAO%) - %MSG%.'
    Configuracoes.Arquivos.OrdenacaoPath = <>
    Configuracoes.WebServices.UF = 'SP'
    Configuracoes.WebServices.AguardarConsultaRet = 0
    Configuracoes.WebServices.QuebradeLinha = '|'
    Left = 630
    Top = 590
  end
end
