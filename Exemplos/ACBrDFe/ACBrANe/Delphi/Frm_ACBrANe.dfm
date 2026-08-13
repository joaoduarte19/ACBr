object frmACBrANe: TfrmACBrANe
  Left = 249
  Top = 82
  Margins.Left = 4
  Margins.Top = 4
  Margins.Right = 4
  Margins.Bottom = 4
  Caption = 'ACBrANe - Programa Exemplo'
  ClientHeight = 765
  ClientWidth = 1083
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 120
  TextHeight = 17
  object pnlMenus: TPanel
    Left = 0
    Top = 0
    Width = 371
    Height = 765
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alLeft
    TabOrder = 0
    object lblColaborador: TLabel
      Left = 23
      Top = 675
      Width = 324
      Height = 16
      Cursor = crHandPoint
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Veja a lista de Colaboradores do Projeto ACBr'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -14
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = lblColaboradorClick
    end
    object lblPatrocinador: TLabel
      Left = 20
      Top = 694
      Width = 326
      Height = 16
      Cursor = crHandPoint
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Veja a lista de Patrocinadores do Projeto ACBr'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -14
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = lblPatrocinadorClick
    end
    object lblDoar1: TLabel
      Left = 26
      Top = 713
      Width = 311
      Height = 16
      Cursor = crHandPoint
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Para se tornar Patrocinador do Projeto ACBr,'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = lblDoar1Click
    end
    object lblDoar2: TLabel
      Left = 146
      Top = 729
      Width = 77
      Height = 16
      Cursor = crHandPoint
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'clique aqui'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = lblDoar2Click
    end
    object PageControl1: TPageControl
      Left = 1
      Top = 1
      Width = 369
      Height = 630
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      ActivePage = TabSheet1
      TabOrder = 0
      object TabSheet1: TTabSheet
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = 'Configura'#231#245'es'
        object PageControl4: TPageControl
          Left = 0
          Top = 0
          Width = 361
          Height = 598
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          ActivePage = TabSheet4
          Align = alClient
          MultiLine = True
          TabOrder = 0
          ExplicitHeight = 602
          object TabSheet3: TTabSheet
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Caption = 'Certificado'
            object lSSLLib: TLabel
              Left = 46
              Top = 20
              Width = 40
              Height = 17
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Alignment = taRightJustify
              Caption = 'SSLLib'
              Color = clBtnFace
              ParentColor = False
            end
            object lCryptLib: TLabel
              Left = 34
              Top = 54
              Width = 52
              Height = 17
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Alignment = taRightJustify
              Caption = 'CryptLib'
              Color = clBtnFace
              ParentColor = False
            end
            object lHttpLib: TLabel
              Left = 42
              Top = 88
              Width = 44
              Height = 17
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Alignment = taRightJustify
              Caption = 'HttpLib'
              Color = clBtnFace
              ParentColor = False
            end
            object lXmlSign: TLabel
              Left = 18
              Top = 121
              Width = 68
              Height = 17
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Alignment = taRightJustify
              Caption = 'XMLSignLib'
              Color = clBtnFace
              ParentColor = False
            end
            object gbCertificado: TGroupBox
              Left = 3
              Top = 148
              Width = 328
              Height = 180
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Caption = 'Certificado'
              TabOrder = 0
              object Label1: TLabel
                Left = 10
                Top = 20
                Width = 54
                Height = 17
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = 'Caminho'
              end
              object Label2: TLabel
                Left = 10
                Top = 70
                Width = 38
                Height = 17
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = 'Senha'
              end
              object sbtnCaminhoCert: TSpeedButton
                Left = 294
                Top = 40
                Width = 29
                Height = 30
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
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
                Left = 10
                Top = 120
                Width = 101
                Height = 17
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = 'N'#250'mero de S'#233'rie'
              end
              object sbtnGetCert: TSpeedButton
                Left = 294
                Top = 138
                Width = 29
                Height = 30
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
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
                Left = 258
                Top = 138
                Width = 28
                Height = 30
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
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
                Left = 10
                Top = 40
                Width = 281
                Height = 25
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                TabOrder = 0
              end
              object edtSenha: TEdit
                Left = 10
                Top = 90
                Width = 311
                Height = 25
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                PasswordChar = '*'
                TabOrder = 1
              end
              object edtNumSerie: TEdit
                Left = 10
                Top = 140
                Width = 241
                Height = 25
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                TabOrder = 2
              end
            end
            object btnDataValidade: TButton
              Left = 10
              Top = 333
              Width = 124
              Height = 31
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Caption = 'Data de Validade'
              TabOrder = 1
              OnClick = btnDataValidadeClick
            end
            object btnNumSerie: TButton
              Left = 140
              Top = 333
              Width = 91
              Height = 31
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Caption = 'Num.S'#233'rie'
              TabOrder = 2
              OnClick = btnNumSerieClick
            end
            object btnSubName: TButton
              Left = 10
              Top = 373
              Width = 124
              Height = 31
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Caption = 'Subject Name'
              TabOrder = 3
              OnClick = btnSubNameClick
            end
            object btnCNPJ: TButton
              Left = 140
              Top = 373
              Width = 91
              Height = 31
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Caption = 'CNPJ'
              TabOrder = 4
              OnClick = btnCNPJClick
            end
            object btnIssuerName: TButton
              Left = 235
              Top = 373
              Width = 95
              Height = 31
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Caption = 'Issuer Name'
              TabOrder = 5
              OnClick = btnIssuerNameClick
            end
            object btnLeituraX509: TButton
              Left = 10
              Top = 408
              Width = 144
              Height = 31
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Caption = 'Leitura de X509'
              TabOrder = 6
              OnClick = btnLeituraX509Click
            end
            object cbSSLLib: TComboBox
              Left = 100
              Top = 10
              Width = 200
              Height = 25
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Style = csDropDownList
              TabOrder = 7
              OnChange = cbSSLLibChange
            end
            object cbCryptLib: TComboBox
              Left = 100
              Top = 44
              Width = 200
              Height = 25
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Style = csDropDownList
              TabOrder = 8
              OnChange = cbCryptLibChange
            end
            object cbHttpLib: TComboBox
              Left = 100
              Top = 78
              Width = 200
              Height = 25
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Style = csDropDownList
              TabOrder = 9
              OnChange = cbHttpLibChange
            end
            object cbXmlSignLib: TComboBox
              Left = 100
              Top = 111
              Width = 200
              Height = 25
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Style = csDropDownList
              TabOrder = 10
              OnChange = cbXmlSignLibChange
            end
          end
          object TabSheet4: TTabSheet
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Caption = 'Geral'
            ImageIndex = 1
            object GroupBox3: TGroupBox
              Left = 4
              Top = 5
              Width = 331
              Height = 526
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Caption = 'Geral'
              TabOrder = 0
              object sbtnPathSalvar: TSpeedButton
                Left = 298
                Top = 295
                Width = 28
                Height = 30
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
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
                Left = 10
                Top = 158
                Width = 111
                Height = 17
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = 'Forma de Emiss'#227'o'
              end
              object Label31: TLabel
                Left = 10
                Top = 110
                Width = 90
                Height = 17
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = 'Formato Alerta'
              end
              object Label32: TLabel
                Left = 10
                Top = 206
                Width = 153
                Height = 17
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = 'Vers'#227'o Documento Fiscal'
              end
              object Label42: TLabel
                Left = 10
                Top = 325
                Width = 258
                Height = 17
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = 'Diret'#243'rios com os arquivos XSD(Schemas)'
              end
              object spPathSchemas: TSpeedButton
                Left = 298
                Top = 345
                Width = 28
                Height = 30
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
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
              object Label30: TLabel
                Left = 10
                Top = 395
                Width = 45
                Height = 17
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = 'Usu'#225'rio'
              end
              object Label7: TLabel
                Left = 173
                Top = 395
                Width = 38
                Height = 17
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = 'Senha'
              end
              object Label33: TLabel
                Left = 10
                Top = 443
                Width = 73
                Height = 17
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = 'C'#243'digo ATM'
              end
              object Label34: TLabel
                Left = 169
                Top = 443
                Width = 72
                Height = 16
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = 'Seguradora'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -14
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
              end
              object edtPathLogs: TEdit
                Left = 10
                Top = 299
                Width = 285
                Height = 25
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                TabOrder = 0
              end
              object ckSalvar: TCheckBox
                Left = 10
                Top = 279
                Width = 261
                Height = 19
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = 'Salvar Arquivos de Envio e Resposta'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -14
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 1
              end
              object cbFormaEmissao: TComboBox
                Left = 10
                Top = 178
                Width = 310
                Height = 25
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                TabOrder = 2
              end
              object cbxAtualizarXML: TCheckBox
                Left = 10
                Top = 68
                Width = 121
                Height = 21
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = 'Atualizar XML'
                TabOrder = 3
              end
              object cbxExibirErroSchema: TCheckBox
                Left = 10
                Top = 88
                Width = 161
                Height = 21
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = 'Exibir Erro Schema'
                TabOrder = 4
              end
              object edtFormatoAlerta: TEdit
                Left = 10
                Top = 130
                Width = 310
                Height = 25
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                TabOrder = 5
              end
              object cbxRetirarAcentos: TCheckBox
                Left = 10
                Top = 256
                Width = 241
                Height = 22
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = 'Retirar Acentos dos XMLs enviados'
                TabOrder = 6
              end
              object cbVersaoDF: TComboBox
                Left = 10
                Top = 226
                Width = 310
                Height = 25
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                TabOrder = 7
              end
              object edtPathSchemas: TEdit
                Left = 10
                Top = 345
                Width = 285
                Height = 25
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                TabOrder = 8
              end
              object rgAverbar: TRadioGroup
                Left = 10
                Top = 20
                Width = 311
                Height = 41
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = ' Averbar '
                Columns = 3
                ItemIndex = 0
                Items.Strings = (
                  'NF-e'
                  'CT-e'
                  'MDF-e')
                TabOrder = 9
              end
              object edtUsuarioATM: TEdit
                Left = 10
                Top = 415
                Width = 154
                Height = 25
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                TabOrder = 10
              end
              object edtSenhaATM: TEdit
                Left = 169
                Top = 415
                Width = 154
                Height = 25
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                PasswordChar = '*'
                TabOrder = 11
              end
              object edtCodATM: TEdit
                Left = 10
                Top = 463
                Width = 154
                Height = 25
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                TabOrder = 12
              end
              object cbSeguradora: TComboBox
                Left = 169
                Top = 463
                Width = 152
                Height = 28
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Style = csDropDownList
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -16
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ItemIndex = 0
                ParentFont = False
                TabOrder = 13
                Text = 'ATM'
                Items.Strings = (
                  'ATM'
                  'ELT')
              end
            end
          end
          object TabSheet7: TTabSheet
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Caption = 'WebService'
            ImageIndex = 2
            object GroupBox4: TGroupBox
              Left = 6
              Top = 5
              Width = 332
              Height = 238
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Caption = 'WebService'
              TabOrder = 0
              object Label6: TLabel
                Left = 10
                Top = 20
                Width = 159
                Height = 16
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = 'Selecione UF do Emitente:'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -14
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
              end
              object lTimeOut: TLabel
                Left = 209
                Top = 145
                Width = 52
                Height = 17
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = 'TimeOut'
                Color = clBtnFace
                ParentColor = False
              end
              object lSSLLib1: TLabel
                Left = 21
                Top = 210
                Width = 54
                Height = 17
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Alignment = taRightJustify
                Caption = 'SSLType'
                Color = clBtnFace
                ParentColor = False
              end
              object cbxVisualizar: TCheckBox
                Left = 10
                Top = 148
                Width = 191
                Height = 21
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = 'Visualizar Mensagem'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -14
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 0
              end
              object cbUF: TComboBox
                Left = 10
                Top = 40
                Width = 311
                Height = 28
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Style = csDropDownList
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -16
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
                Left = 10
                Top = 76
                Width = 311
                Height = 65
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = 'Selecione o Ambiente de Destino'
                Columns = 2
                ItemIndex = 0
                Items.Strings = (
                  'Produ'#231#227'o'
                  'Homologa'#231#227'o')
                TabOrder = 2
              end
              object cbxSalvarSOAP: TCheckBox
                Left = 10
                Top = 170
                Width = 191
                Height = 21
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = 'Salvar envelope SOAP'
                TabOrder = 3
              end
              object seTimeOut: TSpinEdit
                Left = 209
                Top = 165
                Width = 82
                Height = 27
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Increment = 10
                MaxValue = 999999
                MinValue = 1000
                TabOrder = 4
                Value = 5000
              end
              object cbSSLType: TComboBox
                Left = 90
                Top = 200
                Width = 200
                Height = 25
                Hint = 'Depende de configura'#231#227'o de  SSL.HttpLib'
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Style = csDropDownList
                TabOrder = 5
                OnChange = cbSSLTypeChange
              end
            end
            object gbProxy: TGroupBox
              Left = 6
              Top = 354
              Width = 332
              Height = 130
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Caption = 'Proxy'
              TabOrder = 1
              object Label8: TLabel
                Left = 10
                Top = 20
                Width = 28
                Height = 17
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = 'Host'
              end
              object Label9: TLabel
                Left = 260
                Top = 20
                Width = 33
                Height = 17
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = 'Porta'
              end
              object Label10: TLabel
                Left = 10
                Top = 70
                Width = 45
                Height = 17
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = 'Usu'#225'rio'
              end
              object Label11: TLabel
                Left = 173
                Top = 70
                Width = 38
                Height = 17
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = 'Senha'
              end
              object edtProxyHost: TEdit
                Left = 10
                Top = 40
                Width = 241
                Height = 25
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                TabOrder = 0
              end
              object edtProxyPorta: TEdit
                Left = 260
                Top = 40
                Width = 63
                Height = 25
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                TabOrder = 1
              end
              object edtProxyUser: TEdit
                Left = 10
                Top = 90
                Width = 154
                Height = 25
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                TabOrder = 2
              end
              object edtProxySenha: TEdit
                Left = 169
                Top = 90
                Width = 154
                Height = 25
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                PasswordChar = '*'
                TabOrder = 3
              end
            end
            object gbxRetornoEnvio: TGroupBox
              Left = 6
              Top = 250
              Width = 332
              Height = 96
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Caption = 'Retorno de Envio'
              TabOrder = 2
              object Label36: TLabel
                Left = 116
                Top = 34
                Width = 63
                Height = 17
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = 'Tentativas'
              end
              object Label37: TLabel
                Left = 220
                Top = 34
                Width = 54
                Height = 17
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = 'Intervalo'
              end
              object Label38: TLabel
                Left = 10
                Top = 34
                Width = 56
                Height = 17
                Hint = 
                  'Aguardar quantos segundos para primeira consulta de retorno de e' +
                  'nvio'
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = 'Aguardar'
              end
              object cbxAjustarAut: TCheckBox
                Left = 10
                Top = 15
                Width = 293
                Height = 21
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = 'Ajustar Automaticamente prop. "Aguardar"'
                TabOrder = 0
              end
              object edtTentativas: TEdit
                Left = 116
                Top = 54
                Width = 72
                Height = 25
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                TabOrder = 2
              end
              object edtIntervalo: TEdit
                Left = 220
                Top = 54
                Width = 71
                Height = 25
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                TabOrder = 3
              end
              object edtAguardar: TEdit
                Left = 10
                Top = 54
                Width = 71
                Height = 25
                Hint = 
                  'Aguardar quantos segundos para primeira consulta de retorno de e' +
                  'nvio'
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                TabOrder = 1
              end
            end
          end
          object TabSheet12: TTabSheet
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Caption = 'Emitente'
            ImageIndex = 3
            object Label12: TLabel
              Left = 10
              Top = 5
              Width = 32
              Height = 17
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Caption = 'CNPJ'
            end
            object Label13: TLabel
              Left = 170
              Top = 5
              Width = 52
              Height = 17
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Caption = 'Insc.Est.'
            end
            object Label14: TLabel
              Left = 10
              Top = 55
              Width = 75
              Height = 17
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Caption = 'Raz'#227'o Social'
            end
            object Label15: TLabel
              Left = 10
              Top = 105
              Width = 49
              Height = 17
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Caption = 'Fantasia'
            end
            object Label16: TLabel
              Left = 10
              Top = 205
              Width = 72
              Height = 17
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Caption = 'Logradouro'
            end
            object Label17: TLabel
              Left = 260
              Top = 205
              Width = 49
              Height = 17
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Caption = 'N'#250'mero'
            end
            object Label18: TLabel
              Left = 10
              Top = 255
              Width = 86
              Height = 17
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Caption = 'Complemento'
            end
            object Label19: TLabel
              Left = 170
              Top = 255
              Width = 35
              Height = 17
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Caption = 'Bairro'
            end
            object Label20: TLabel
              Left = 10
              Top = 305
              Width = 78
              Height = 17
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Caption = 'C'#243'd. Cidade '
            end
            object Label21: TLabel
              Left = 95
              Top = 305
              Width = 41
              Height = 17
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Caption = 'Cidade'
            end
            object Label22: TLabel
              Left = 281
              Top = 305
              Width = 16
              Height = 17
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Caption = 'UF'
            end
            object Label23: TLabel
              Left = 170
              Top = 155
              Width = 25
              Height = 17
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Caption = 'CEP'
            end
            object Label24: TLabel
              Left = 10
              Top = 155
              Width = 30
              Height = 17
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Caption = 'Fone'
            end
            object edtEmitCNPJ: TEdit
              Left = 10
              Top = 25
              Width = 154
              Height = 25
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              TabOrder = 0
            end
            object edtEmitIE: TEdit
              Left = 171
              Top = 25
              Width = 154
              Height = 25
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              TabOrder = 1
            end
            object edtEmitRazao: TEdit
              Left = 10
              Top = 75
              Width = 315
              Height = 25
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              TabOrder = 2
            end
            object edtEmitFantasia: TEdit
              Left = 10
              Top = 125
              Width = 315
              Height = 25
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              TabOrder = 3
            end
            object edtEmitFone: TEdit
              Left = 10
              Top = 175
              Width = 156
              Height = 25
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              TabOrder = 4
            end
            object edtEmitCEP: TEdit
              Left = 171
              Top = 175
              Width = 154
              Height = 25
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              TabOrder = 5
            end
            object edtEmitLogradouro: TEdit
              Left = 10
              Top = 225
              Width = 245
              Height = 25
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              TabOrder = 6
            end
            object edtEmitNumero: TEdit
              Left = 263
              Top = 225
              Width = 62
              Height = 25
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              TabOrder = 7
            end
            object edtEmitComp: TEdit
              Left = 10
              Top = 275
              Width = 154
              Height = 25
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              TabOrder = 8
            end
            object edtEmitBairro: TEdit
              Left = 171
              Top = 275
              Width = 154
              Height = 25
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              TabOrder = 9
            end
            object edtEmitCodCidade: TEdit
              Left = 10
              Top = 325
              Width = 76
              Height = 25
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              TabOrder = 10
            end
            object edtEmitCidade: TEdit
              Left = 95
              Top = 325
              Width = 178
              Height = 25
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              TabOrder = 11
            end
            object edtEmitUF: TEdit
              Left = 281
              Top = 325
              Width = 44
              Height = 25
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              TabOrder = 12
            end
          end
          object TabSheet13: TTabSheet
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Caption = 'Arquivos'
            ImageIndex = 4
            object sbPathANe: TSpeedButton
              Left = 309
              Top = 164
              Width = 29
              Height = 30
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
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
              OnClick = sbPathANeClick
            end
            object Label35: TLabel
              Left = 8
              Top = 145
              Width = 118
              Height = 17
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Caption = 'Pasta Arquivos ANe'
            end
            object cbxSalvarArqs: TCheckBox
              Left = 8
              Top = 0
              Width = 262
              Height = 21
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Caption = 'Salvar Arquivos em Pastas Separadas'
              TabOrder = 0
            end
            object cbxPastaMensal: TCheckBox
              Left = 8
              Top = 20
              Width = 262
              Height = 21
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Caption = 'Criar Pastas Mensalmente'
              TabOrder = 1
            end
            object cbxAdicionaLiteral: TCheckBox
              Left = 8
              Top = 40
              Width = 262
              Height = 21
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Caption = 'Adicionar Literal no nome das pastas'
              TabOrder = 2
            end
            object cbxEmissaoPathANe: TCheckBox
              Left = 8
              Top = 60
              Width = 313
              Height = 21
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Caption = 'Salvar Documento pelo campo Data de Emiss'#227'o'
              TabOrder = 3
            end
            object cbxSepararPorCNPJ: TCheckBox
              Left = 8
              Top = 80
              Width = 291
              Height = 21
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Caption = 'Separar Arqs pelo CNPJ do Certificado'
              TabOrder = 4
            end
            object edtPathANe: TEdit
              Left = 8
              Top = 165
              Width = 293
              Height = 25
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              TabOrder = 5
            end
            object cbxSepararPorModelo: TCheckBox
              Left = 8
              Top = 100
              Width = 313
              Height = 21
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Caption = 'Separar Arqs pelo Modelo do Documento'
              TabOrder = 6
            end
          end
        end
      end
      object TabSheet14: TTabSheet
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = 'Email'
        ImageIndex = 2
        object Label3: TLabel
          Left = 10
          Top = 10
          Width = 89
          Height = 17
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'Servidor SMTP'
        end
        object Label4: TLabel
          Left = 258
          Top = 10
          Width = 33
          Height = 17
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'Porta'
        end
        object Label5: TLabel
          Left = 10
          Top = 60
          Width = 45
          Height = 17
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'Usu'#225'rio'
        end
        object Label26: TLabel
          Left = 171
          Top = 60
          Width = 38
          Height = 17
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'Senha'
        end
        object Label27: TLabel
          Left = 10
          Top = 110
          Width = 155
          Height = 17
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'Assunto do email enviado'
        end
        object Label28: TLabel
          Left = 10
          Top = 200
          Width = 120
          Height = 17
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'Mensagem do Email'
        end
        object edtSmtpHost: TEdit
          Left = 10
          Top = 30
          Width = 241
          Height = 25
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          TabOrder = 0
        end
        object edtSmtpPort: TEdit
          Left = 258
          Top = 30
          Width = 63
          Height = 25
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          TabOrder = 1
        end
        object edtSmtpUser: TEdit
          Left = 10
          Top = 80
          Width = 150
          Height = 25
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          TabOrder = 2
        end
        object edtSmtpPass: TEdit
          Left = 171
          Top = 80
          Width = 150
          Height = 25
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          TabOrder = 3
        end
        object edtEmailAssunto: TEdit
          Left = 10
          Top = 130
          Width = 311
          Height = 25
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          TabOrder = 4
        end
        object cbEmailSSL: TCheckBox
          Left = 13
          Top = 170
          Width = 208
          Height = 21
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'SMTP exige conex'#227'o segura'
          TabOrder = 5
        end
        object mmEmailMsg: TMemo
          Left = 10
          Top = 220
          Width = 311
          Height = 163
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          TabOrder = 6
        end
      end
    end
    object btnSalvarConfig: TBitBtn
      Left = 98
      Top = 644
      Width = 191
      Height = 31
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
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
    Left = 371
    Top = 0
    Width = 712
    Height = 765
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alClient
    TabOrder = 1
    object pgcBotoes: TPageControl
      Left = 1
      Top = 1
      Width = 710
      Height = 90
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      ActivePage = tsEnvios
      Align = alTop
      TabOrder = 0
      object tsEnvios: TTabSheet
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = 'Envios'
        ImageIndex = 2
        object btnEnviar: TButton
          Left = 4
          Top = 4
          Width = 221
          Height = 31
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'Enviar'
          TabOrder = 0
          OnClick = btnEnviarClick
        end
        object btnEnviarANeEmail: TButton
          Left = 233
          Top = 4
          Width = 221
          Height = 31
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'Enviar ANe Email'
          TabOrder = 1
          OnClick = btnEnviarANeEmailClick
        end
        object btnConsultar: TButton
          Left = 461
          Top = 4
          Width = 222
          Height = 31
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'Consultar'
          TabOrder = 2
          OnClick = btnConsultarClick
        end
      end
    end
    object pgRespostas: TPageControl
      Left = 1
      Top = 91
      Width = 710
      Height = 673
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      ActivePage = TabSheet8
      Align = alClient
      TabOrder = 1
      object TabSheet8: TTabSheet
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = 'Log'
        ImageIndex = 2
        object memoLog: TMemo
          Left = 0
          Top = 0
          Width = 702
          Height = 641
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Align = alClient
          ScrollBars = ssVertical
          TabOrder = 0
          ExplicitWidth = 699
          ExplicitHeight = 638
        end
      end
      object TabSheet5: TTabSheet
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = 'XML de Envio'
        object WBXmlEnvio: TWebBrowser
          Left = 0
          Top = 0
          Width = 702
          Height = 641
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Align = alClient
          TabOrder = 0
          ExplicitWidth = 699
          ExplicitHeight = 638
          ControlData = {
            4C0000000B3A0000003500000000000000000000000000000000000000000000
            000000004C000000000000000000000001000000E0D057007335CF11AE690800
            2B2E126200000000000000004C0000000114020000000000C000000000000046
            8000000000000000000000000000000000000000000000000000000000000000
            00000000000000000100000000000000000000000000000000000000}
        end
      end
      object TabSheet6: TTabSheet
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = 'XML de Retorno'
        ImageIndex = 1
        object WBXmlRetorno: TWebBrowser
          Left = 0
          Top = 0
          Width = 702
          Height = 641
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Align = alClient
          TabOrder = 0
          ExplicitWidth = 699
          ExplicitHeight = 638
          ControlData = {
            4C0000000B3A0000003500000000000000000000000000000000000000000000
            000000004C000000000000000000000001000000E0D057007335CF11AE690800
            2B2E126200000000000000004C0000000114020000000000C000000000000046
            8000000000000000000000000000000000000000000000000000000000000000
            00000000000000000100000000000000000000000000000000000000}
        end
      end
    end
  end
  object ACBrMail1: TACBrMail
    Host = '127.0.0.1'
    Port = '25'
    SetSSL = False
    SetTLS = False
    Attempts = 3
    DefaultCharset = UTF_8
    IDECharset = CP1252
    Left = 440
    Top = 128
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '*-nfe.XML'
    Filter = 
      'Arquivos NFE (*-nfe.XML)|*-nfe.XML|Arquivos XML (*.XML)|*.XML|To' +
      'dos os Arquivos (*.*)|*.*'
    Title = 'Selecione a NFe'
    Left = 352
    Top = 200
  end
  object ACBrANe1: TACBrANe
    Configuracoes.Geral.SSLLib = libNone
    Configuracoes.Geral.SSLCryptLib = cryNone
    Configuracoes.Geral.SSLHttpLib = httpNone
    Configuracoes.Geral.SSLXmlSignLib = xsNone
    Configuracoes.Geral.FormatoAlerta = 'TAG:%TAGNIVEL% ID:%ID%/%TAG%(%DESCRICAO%) - %MSG%.'
    Configuracoes.Geral.TipoDoc = tdCTe
    Configuracoes.Geral.Seguradora = segATM
    Configuracoes.Arquivos.OrdenacaoPath = <>
    Configuracoes.WebServices.UF = 'SP'
    Configuracoes.WebServices.AguardarConsultaRet = 0
    Configuracoes.WebServices.QuebradeLinha = '|'
    Left = 350
    Top = 129
  end
end
