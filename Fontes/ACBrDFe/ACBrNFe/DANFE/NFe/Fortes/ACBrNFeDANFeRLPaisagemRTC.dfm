inherited frlDANFeRLPaisagemRTC: TfrlDANFeRLPaisagemRTC
  Left = 234
  Top = 0
  Caption = 'frlDANFeRLPaisagemRTC'
  inherited RLNFe: TRLReport
    Width = 1123
    Height = 794
    Margins.LeftMargin = 7.000000000000000000
    Margins.TopMargin = 7.000000000000000000
    Margins.RightMargin = 7.000000000000000000
    Margins.BottomMargin = 7.000000000000000000
    AdjustableMargins = True
    PrintDialog = False
    Title = 'DANFE Paisagem RTC'
    BeforePrint = RLNFeBeforePrint
    OnDataRecord = RLNFeDataRecord
    PageSetup.Orientation = poLandscape
    object rlpCanhoto: TRLPanel
      Left = 1036
      Top = 26
      Width = 61
      Height = 742
      Align = faRightMost
      object rlpCanhotoRecebemos: TRLPanel
        Left = 0
        Top = 0
        Width = 30
        Height = 593
        Borders.Sides = sdAll
        object rllRecebemosDe: TRLAngleLabel
          Left = 3
          Top = 3
          Width = 10
          Height = 587
          Angle = 90.000000000000000000
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Layout = tlBottom
          ParentFont = False
        end
        object rllResumo: TRLAngleLabel
          Left = 16
          Top = 3
          Width = 10
          Height = 587
          Angle = 90.000000000000000000
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Layout = tlBottom
          ParentFont = False
        end
      end
      object rlpCanhotoAssinatura: TRLPanel
        Left = 29
        Top = 0
        Width = 32
        Height = 297
        Borders.Sides = sdAll
        object rllTitCanhotoAssinatura: TRLAngleLabel
          Left = 2
          Top = 3
          Width = 9
          Height = 291
          Angle = 90.000000000000000000
          AutoSize = False
          Caption = 'IDENTIFICA'#199#195'O E ASSINATURA DO RECEBEDOR'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Layout = tlBottom
          ParentFont = False
        end
      end
      object rlpCanhotoData: TRLPanel
        Left = 29
        Top = 296
        Width = 32
        Height = 297
        Borders.Sides = sdAll
        object rllTitCanhotoData: TRLAngleLabel
          Left = 2
          Top = 3
          Width = 9
          Height = 291
          Angle = 90.000000000000000000
          AutoSize = False
          Caption = 'DATA DE RECEBIMENTO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Layout = tlBottom
          ParentFont = False
        end
      end
      object rlpCanhotoNFe: TRLPanel
        Left = 0
        Top = 592
        Width = 61
        Height = 150
        Borders.Sides = sdAll
        object rllCanhotoNFe: TRLAngleLabel
          Left = 4
          Top = 3
          Width = 18
          Height = 144
          Angle = 90.000000000000000000
          AutoSize = False
          Caption = 'NF-e'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Layout = tlCenter
          ParentFont = False
        end
        object rllCanhotoNumero: TRLAngleLabel
          Left = 24
          Top = 3
          Width = 14
          Height = 144
          Angle = 90.000000000000000000
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Layout = tlCenter
          ParentFont = False
        end
        object rllCanhotoSerie: TRLAngleLabel
          Left = 40
          Top = 3
          Width = 14
          Height = 144
          Angle = 90.000000000000000000
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Layout = tlCenter
          ParentFont = False
        end
      end
    end
    object rlpDivisaoCanhoto: TRLPanel
      Left = 1024
      Top = 26
      Width = 12
      Height = 742
      Align = faRightMost
      object rliDivisaoCanhoto: TRLDraw
        Left = 5
        Top = 0
        Width = 2
        Height = 742
        Align = faHeight
        Angle = 90.000000000000000000
        DrawKind = dkLine
        Pen.Style = psDot
      end
    end
    object rlbEmitente: TRLBand
      Left = 26
      Top = 26
      Width = 998
      Height = 148
      BandType = btHeader
      BeforePrint = rlbEmitenteBeforePrint
      object rlpEmitente: TRLPanel
        Left = 0
        Top = 0
        Width = 314
        Height = 88
        Borders.Sides = sdAll
        object rliLogo: TRLImage
          Left = 4
          Top = 9
          Width = 70
          Height = 70
          Center = True
          Scaled = True
        end
        object rlmEmitente: TRLMemo
          Left = 78
          Top = 8
          Width = 232
          Height = 28
          Alignment = taCenter
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object rlmEndereco: TRLMemo
          Left = 78
          Top = 38
          Width = 232
          Height = 46
          Alignment = taCenter
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpDANFE: TRLPanel
        Left = 313
        Top = 0
        Width = 161
        Height = 88
        Borders.Sides = sdAll
        object rllDANFE: TRLLabel
          Left = 3
          Top = 2
          Width = 155
          Height = 16
          Alignment = taCenter
          AutoSize = False
          Caption = 'DANFE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -14
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object rlmDocumento: TRLMemo
          Left = 3
          Top = 19
          Width = 155
          Height = 16
          Alignment = taCenter
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Lines.Strings = (
            'DOCUMENTO AUXILIAR DA'
            'NOTA FISCAL ELETR'#212'NICA')
          ParentFont = False
        end
        object rlpTipoNF: TRLPanel
          Left = 69
          Top = 36
          Width = 22
          Height = 18
          Borders.Sides = sdAll
          object rllTipoNF: TRLLabel
            Left = 1
            Top = 2
            Width = 20
            Height = 13
            Alignment = taCenter
            AutoSize = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
        end
        object rllEntradaSaida: TRLLabel
          Left = 3
          Top = 57
          Width = 155
          Height = 9
          Alignment = taCenter
          AutoSize = False
          Caption = '0 - ENTRADA   1 - SA'#205'DA'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllNumNF: TRLLabel
          Left = 3
          Top = 67
          Width = 155
          Height = 9
          Alignment = taCenter
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object rllSerie: TRLLabel
          Left = 3
          Top = 77
          Width = 64
          Height = 9
          Alignment = taRightJustify
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rlsPagina: TRLSystemInfo
          Left = 70
          Top = 77
          Width = 53
          Height = 9
          Alignment = taRightJustify
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Info = itPageNumber
          ParentFont = False
          Text = 'FOLHA '
        end
        object rlsUltimaPagina: TRLSystemInfo
          Left = 124
          Top = 77
          Width = 34
          Height = 9
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Info = itLastPageNumber
          ParentFont = False
          Text = '/'
        end
      end
      object rlpChave: TRLPanel
        Left = 473
        Top = 0
        Width = 525
        Height = 88
        Borders.Sides = sdAll
        object rlbCodigoBarras: TRLBarcode
          Left = 69
          Top = 3
          Width = 386
          Height = 30
          Margins.LeftMargin = 1.000000000000000000
          Margins.RightMargin = 1.000000000000000000
          Alignment = taCenter
          AutoSize = False
          BarcodeType = bcCode128
        end
        object rliChave1: TRLDraw
          Left = 0
          Top = 35
          Width = 524
          Height = 1
          DrawKind = dkLine
        end
        object rllTitChave: TRLLabel
          Left = 3
          Top = 37
          Width = 519
          Height = 8
          AutoSize = False
          Caption = 'CHAVE DE ACESSO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllChave: TRLLabel
          Left = 3
          Top = 47
          Width = 519
          Height = 12
          Alignment = taCenter
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object rliChave2: TRLDraw
          Left = 0
          Top = 61
          Width = 524
          Height = 1
          DrawKind = dkLine
        end
        object rlmConsulta: TRLMemo
          Left = 4
          Top = 63
          Width = 516
          Height = 22
          Alignment = taCenter
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Lines.Strings = (
            'Consulta de autenticidade no portal nacional da NF-e'
            'www.nfe.fazenda.gov.br/portal ou no site da Sefaz Autorizadora')
          ParentFont = False
        end
        object rllXmotivo: TRLLabel
          Left = 3
          Top = 7
          Width = 519
          Height = 22
          Alignment = taCenter
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
        end
      end
      object rlpNatOp: TRLPanel
        Left = 0
        Top = 87
        Width = 474
        Height = 21
        Borders.Sides = sdAll
        object rllTitNatOp: TRLLabel
          Left = 3
          Top = 1
          Width = 469
          Height = 8
          AutoSize = False
          Caption = 'NATUREZA DA OPERA'#199#195'O'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllNatOp: TRLLabel
          Left = 4
          Top = 9
          Width = 466
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpProtocolo: TRLPanel
        Left = 473
        Top = 87
        Width = 525
        Height = 21
        Borders.Sides = sdAll
        object rllTitProtocolo: TRLLabel
          Left = 3
          Top = 1
          Width = 519
          Height = 8
          AutoSize = False
          Caption = 'PROTOCOLO DE AUTORIZA'#199#195'O DE USO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllProtocolo: TRLLabel
          Left = 4
          Top = 9
          Width = 516
          Height = 11
          Alignment = taRightJustify
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpIE: TRLPanel
        Left = 0
        Top = 107
        Width = 391
        Height = 21
        Borders.Sides = sdAll
        object rllTitIE: TRLLabel
          Left = 3
          Top = 1
          Width = 385
          Height = 8
          AutoSize = False
          Caption = 'INSCRI'#199#195'O ESTADUAL'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllIE: TRLLabel
          Left = 4
          Top = 9
          Width = 383
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpIEST: TRLPanel
        Left = 390
        Top = 107
        Width = 329
        Height = 21
        Borders.Sides = sdAll
        object rllTitIEST: TRLLabel
          Left = 3
          Top = 1
          Width = 323
          Height = 8
          AutoSize = False
          Caption = 'INSCRI'#199#195'O ESTADUAL DO SUBSTITUTO TRIBUT'#193'RIO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllIEST: TRLLabel
          Left = 4
          Top = 9
          Width = 321
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpCNPJ: TRLPanel
        Left = 718
        Top = 107
        Width = 280
        Height = 21
        Borders.Sides = sdAll
        object rllTitCNPJ: TRLLabel
          Left = 3
          Top = 1
          Width = 274
          Height = 8
          AutoSize = False
          Caption = 'CNPJ / CPF'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllCNPJ: TRLLabel
          Left = 4
          Top = 9
          Width = 271
          Height = 11
          Alignment = taRightJustify
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpCRT: TRLPanel
        Left = 0
        Top = 127
        Width = 542
        Height = 21
        Borders.Sides = sdAll
        object rllTitCRT: TRLLabel
          Left = 3
          Top = 1
          Width = 536
          Height = 8
          AutoSize = False
          Caption = 'C'#211'DIGO DO REGIME TRIBUT'#193'RIO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllCRT: TRLLabel
          Left = 4
          Top = 9
          Width = 534
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpRegimeApuracao: TRLPanel
        Left = 541
        Top = 127
        Width = 457
        Height = 21
        Borders.Sides = sdAll
        object rllTitRegimeApuracao: TRLLabel
          Left = 3
          Top = 1
          Width = 451
          Height = 8
          AutoSize = False
          Caption = 'TIPO DE REGIME DE APURA'#199#195'O DO IBS E DA CBS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllRegimeApuracao: TRLLabel
          Left = 4
          Top = 9
          Width = 449
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
    end
    object rlbDestinatario: TRLBand
      Left = 26
      Top = 174
      Width = 998
      Height = 74
      BandType = btTitle
      object rllSecDestinatario: TRLLabel
        Left = 0
        Top = 0
        Width = 998
        Height = 14
        AutoSize = False
        Caption = ' DESTINAT'#193'RIO / REMETENTE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Color = 14540253
        Transparent = False
        Layout = tlCenter
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = False
        Borders.DrawRight = True
        Borders.DrawBottom = True
      end
      object rlpDestNome: TRLPanel
        Left = 0
        Top = 13
        Width = 565
        Height = 21
        Borders.Sides = sdAll
        object rllTitDestNome: TRLLabel
          Left = 3
          Top = 1
          Width = 559
          Height = 8
          AutoSize = False
          Caption = 'NOME / RAZ'#195'O SOCIAL'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllDestNome: TRLLabel
          Left = 4
          Top = 9
          Width = 557
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpDestCNPJ: TRLPanel
        Left = 564
        Top = 13
        Width = 241
        Height = 21
        Borders.Sides = sdAll
        object rllTitDestCNPJ: TRLLabel
          Left = 3
          Top = 1
          Width = 236
          Height = 8
          AutoSize = False
          Caption = 'CNPJ / CPF'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllDestCNPJ: TRLLabel
          Left = 4
          Top = 9
          Width = 234
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpDestEmissao: TRLPanel
        Left = 804
        Top = 13
        Width = 194
        Height = 21
        Borders.Sides = sdAll
        object rllTitDestEmissao: TRLLabel
          Left = 3
          Top = 1
          Width = 188
          Height = 8
          AutoSize = False
          Caption = 'DATA DE EMISS'#195'O'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllDestEmissao: TRLLabel
          Left = 4
          Top = 9
          Width = 185
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpDestEndereco: TRLPanel
        Left = 0
        Top = 33
        Width = 484
        Height = 21
        Borders.Sides = sdAll
        object rllTitDestEndereco: TRLLabel
          Left = 3
          Top = 1
          Width = 478
          Height = 8
          AutoSize = False
          Caption = 'ENDERE'#199'O'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllDestEndereco: TRLLabel
          Left = 4
          Top = 9
          Width = 476
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpDestBairro: TRLPanel
        Left = 483
        Top = 33
        Width = 215
        Height = 21
        Borders.Sides = sdAll
        object rllTitDestBairro: TRLLabel
          Left = 3
          Top = 1
          Width = 209
          Height = 8
          AutoSize = False
          Caption = 'BAIRRO / DISTRITO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllDestBairro: TRLLabel
          Left = 4
          Top = 9
          Width = 207
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpDestCEP: TRLPanel
        Left = 697
        Top = 33
        Width = 108
        Height = 21
        Borders.Sides = sdAll
        object rllTitDestCEP: TRLLabel
          Left = 3
          Top = 1
          Width = 103
          Height = 8
          AutoSize = False
          Caption = 'CEP'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllDestCEP: TRLLabel
          Left = 4
          Top = 9
          Width = 101
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpDestSaida: TRLPanel
        Left = 804
        Top = 33
        Width = 194
        Height = 21
        Borders.Sides = sdAll
        object rllTitDestSaida: TRLLabel
          Left = 3
          Top = 1
          Width = 188
          Height = 8
          AutoSize = False
          Caption = 'DATA DE ENTRADA / SA'#205'DA'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllDestSaida: TRLLabel
          Left = 4
          Top = 9
          Width = 185
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpDestMunicipio: TRLPanel
        Left = 0
        Top = 53
        Width = 302
        Height = 21
        Borders.Sides = sdAll
        object rllTitDestMunicipio: TRLLabel
          Left = 3
          Top = 1
          Width = 297
          Height = 8
          AutoSize = False
          Caption = 'MUNIC'#205'PIO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllDestMunicipio: TRLLabel
          Left = 4
          Top = 9
          Width = 294
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpDestFone: TRLPanel
        Left = 301
        Top = 53
        Width = 168
        Height = 21
        Borders.Sides = sdAll
        object rllTitDestFone: TRLLabel
          Left = 3
          Top = 1
          Width = 162
          Height = 8
          AutoSize = False
          Caption = 'FONE / FAX'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllDestFone: TRLLabel
          Left = 4
          Top = 9
          Width = 160
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpDestUF: TRLPanel
        Left = 468
        Top = 53
        Width = 54
        Height = 21
        Borders.Sides = sdAll
        object rllTitDestUF: TRLLabel
          Left = 3
          Top = 1
          Width = 48
          Height = 8
          AutoSize = False
          Caption = 'UF'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllDestUF: TRLLabel
          Left = 4
          Top = 9
          Width = 45
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpDestIE: TRLPanel
        Left = 521
        Top = 53
        Width = 284
        Height = 21
        Borders.Sides = sdAll
        object rllTitDestIE: TRLLabel
          Left = 3
          Top = 1
          Width = 279
          Height = 8
          AutoSize = False
          Caption = 'INSCRI'#199#195'O ESTADUAL'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllDestIE: TRLLabel
          Left = 4
          Top = 9
          Width = 277
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpDestHoraSaida: TRLPanel
        Left = 804
        Top = 53
        Width = 194
        Height = 21
        Borders.Sides = sdAll
        object rllTitDestHoraSaida: TRLLabel
          Left = 3
          Top = 1
          Width = 188
          Height = 8
          AutoSize = False
          Caption = 'HORA DE SA'#205'DA'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllDestHoraSaida: TRLLabel
          Left = 4
          Top = 9
          Width = 185
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
    end
    object rlbRetirada: TRLBand
      Left = 26
      Top = 248
      Width = 998
      Height = 74
      BandType = btTitle
      object rllSecRetirada: TRLLabel
        Left = 0
        Top = 0
        Width = 998
        Height = 14
        AutoSize = False
        Caption = ' INFORMA'#199#213'ES DO LOCAL DE RETIRADA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Color = 14540253
        Transparent = False
        Layout = tlCenter
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = False
        Borders.DrawRight = True
        Borders.DrawBottom = True
      end
      object rlpRetiradaNome: TRLPanel
        Left = 0
        Top = 13
        Width = 565
        Height = 21
        Borders.Sides = sdAll
        object rllTitRetiradaNome: TRLLabel
          Left = 3
          Top = 1
          Width = 559
          Height = 8
          AutoSize = False
          Caption = 'NOME / RAZ'#195'O SOCIAL'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllRetiradaNome: TRLLabel
          Left = 4
          Top = 9
          Width = 557
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpRetiradaCNPJ: TRLPanel
        Left = 564
        Top = 13
        Width = 241
        Height = 21
        Borders.Sides = sdAll
        object rllTitRetiradaCNPJ: TRLLabel
          Left = 3
          Top = 1
          Width = 236
          Height = 8
          AutoSize = False
          Caption = 'CNPJ / CPF'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllRetiradaCNPJ: TRLLabel
          Left = 4
          Top = 9
          Width = 234
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpRetiradaIE: TRLPanel
        Left = 804
        Top = 13
        Width = 194
        Height = 21
        Borders.Sides = sdAll
        object rllTitRetiradaIE: TRLLabel
          Left = 3
          Top = 1
          Width = 188
          Height = 8
          AutoSize = False
          Caption = 'INSCRI'#199#195'O ESTADUAL'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllRetiradaIE: TRLLabel
          Left = 4
          Top = 9
          Width = 185
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpRetiradaEndereco: TRLPanel
        Left = 0
        Top = 33
        Width = 484
        Height = 21
        Borders.Sides = sdAll
        object rllTitRetiradaEndereco: TRLLabel
          Left = 3
          Top = 1
          Width = 478
          Height = 8
          AutoSize = False
          Caption = 'ENDERE'#199'O'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllRetiradaEndereco: TRLLabel
          Left = 4
          Top = 9
          Width = 476
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpRetiradaBairro: TRLPanel
        Left = 483
        Top = 33
        Width = 322
        Height = 21
        Borders.Sides = sdAll
        object rllTitRetiradaBairro: TRLLabel
          Left = 3
          Top = 1
          Width = 317
          Height = 8
          AutoSize = False
          Caption = 'BAIRRO / DISTRITO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllRetiradaBairro: TRLLabel
          Left = 4
          Top = 9
          Width = 314
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpRetiradaCEP: TRLPanel
        Left = 804
        Top = 33
        Width = 194
        Height = 21
        Borders.Sides = sdAll
        object rllTitRetiradaCEP: TRLLabel
          Left = 3
          Top = 1
          Width = 188
          Height = 8
          AutoSize = False
          Caption = 'CEP'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllRetiradaCEP: TRLLabel
          Left = 4
          Top = 9
          Width = 185
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpRetiradaMunicipio: TRLPanel
        Left = 0
        Top = 53
        Width = 484
        Height = 21
        Borders.Sides = sdAll
        object rllTitRetiradaMunicipio: TRLLabel
          Left = 3
          Top = 1
          Width = 478
          Height = 8
          AutoSize = False
          Caption = 'MUNIC'#205'PIO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllRetiradaMunicipio: TRLLabel
          Left = 4
          Top = 9
          Width = 476
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpRetiradaFone: TRLPanel
        Left = 483
        Top = 53
        Width = 242
        Height = 21
        Borders.Sides = sdAll
        object rllTitRetiradaFone: TRLLabel
          Left = 3
          Top = 1
          Width = 236
          Height = 8
          AutoSize = False
          Caption = 'FONE / FAX'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllRetiradaFone: TRLLabel
          Left = 4
          Top = 9
          Width = 234
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpRetiradaUF: TRLPanel
        Left = 724
        Top = 53
        Width = 274
        Height = 21
        Borders.Sides = sdAll
        object rllTitRetiradaUF: TRLLabel
          Left = 3
          Top = 1
          Width = 268
          Height = 8
          AutoSize = False
          Caption = 'UF'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllRetiradaUF: TRLLabel
          Left = 4
          Top = 9
          Width = 266
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
    end
    object rlbEntrega: TRLBand
      Left = 26
      Top = 322
      Width = 998
      Height = 74
      BandType = btTitle
      object rllSecEntrega: TRLLabel
        Left = 0
        Top = 0
        Width = 998
        Height = 14
        AutoSize = False
        Caption = ' INFORMA'#199#213'ES DO LOCAL DE ENTREGA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Color = 14540253
        Transparent = False
        Layout = tlCenter
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = False
        Borders.DrawRight = True
        Borders.DrawBottom = True
      end
      object rlpEntregaNome: TRLPanel
        Left = 0
        Top = 13
        Width = 565
        Height = 21
        Borders.Sides = sdAll
        object rllTitEntregaNome: TRLLabel
          Left = 3
          Top = 1
          Width = 559
          Height = 8
          AutoSize = False
          Caption = 'NOME / RAZ'#195'O SOCIAL'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllEntregaNome: TRLLabel
          Left = 4
          Top = 9
          Width = 557
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpEntregaCNPJ: TRLPanel
        Left = 564
        Top = 13
        Width = 241
        Height = 21
        Borders.Sides = sdAll
        object rllTitEntregaCNPJ: TRLLabel
          Left = 3
          Top = 1
          Width = 236
          Height = 8
          AutoSize = False
          Caption = 'CNPJ / CPF'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllEntregaCNPJ: TRLLabel
          Left = 4
          Top = 9
          Width = 234
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpEntregaIE: TRLPanel
        Left = 804
        Top = 13
        Width = 194
        Height = 21
        Borders.Sides = sdAll
        object rllTitEntregaIE: TRLLabel
          Left = 3
          Top = 1
          Width = 188
          Height = 8
          AutoSize = False
          Caption = 'INSCRI'#199#195'O ESTADUAL'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllEntregaIE: TRLLabel
          Left = 4
          Top = 9
          Width = 185
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpEntregaEndereco: TRLPanel
        Left = 0
        Top = 33
        Width = 484
        Height = 21
        Borders.Sides = sdAll
        object rllTitEntregaEndereco: TRLLabel
          Left = 3
          Top = 1
          Width = 478
          Height = 8
          AutoSize = False
          Caption = 'ENDERE'#199'O'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllEntregaEndereco: TRLLabel
          Left = 4
          Top = 9
          Width = 476
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpEntregaBairro: TRLPanel
        Left = 483
        Top = 33
        Width = 322
        Height = 21
        Borders.Sides = sdAll
        object rllTitEntregaBairro: TRLLabel
          Left = 3
          Top = 1
          Width = 317
          Height = 8
          AutoSize = False
          Caption = 'BAIRRO / DISTRITO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllEntregaBairro: TRLLabel
          Left = 4
          Top = 9
          Width = 314
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpEntregaCEP: TRLPanel
        Left = 804
        Top = 33
        Width = 194
        Height = 21
        Borders.Sides = sdAll
        object rllTitEntregaCEP: TRLLabel
          Left = 3
          Top = 1
          Width = 188
          Height = 8
          AutoSize = False
          Caption = 'CEP'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllEntregaCEP: TRLLabel
          Left = 4
          Top = 9
          Width = 185
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpEntregaMunicipio: TRLPanel
        Left = 0
        Top = 53
        Width = 484
        Height = 21
        Borders.Sides = sdAll
        object rllTitEntregaMunicipio: TRLLabel
          Left = 3
          Top = 1
          Width = 478
          Height = 8
          AutoSize = False
          Caption = 'MUNIC'#205'PIO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllEntregaMunicipio: TRLLabel
          Left = 4
          Top = 9
          Width = 476
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpEntregaFone: TRLPanel
        Left = 483
        Top = 53
        Width = 242
        Height = 21
        Borders.Sides = sdAll
        object rllTitEntregaFone: TRLLabel
          Left = 3
          Top = 1
          Width = 236
          Height = 8
          AutoSize = False
          Caption = 'FONE / FAX'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllEntregaFone: TRLLabel
          Left = 4
          Top = 9
          Width = 234
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpEntregaUF: TRLPanel
        Left = 724
        Top = 53
        Width = 274
        Height = 21
        Borders.Sides = sdAll
        object rllTitEntregaUF: TRLLabel
          Left = 3
          Top = 1
          Width = 268
          Height = 8
          AutoSize = False
          Caption = 'UF'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllEntregaUF: TRLLabel
          Left = 4
          Top = 9
          Width = 266
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
    end
    object rlbFatura: TRLBand
      Left = 26
      Top = 396
      Width = 998
      Height = 14
      BandType = btTitle
      object rllSecFatura: TRLLabel
        Left = 0
        Top = 0
        Width = 998
        Height = 14
        AutoSize = False
        Caption = ' FATURA / DUPLICATAS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Color = 14540253
        Transparent = False
        Layout = tlCenter
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = False
        Borders.DrawRight = True
        Borders.DrawBottom = True
      end
    end
    object rlbTotalNota: TRLBand
      Left = 26
      Top = 410
      Width = 998
      Height = 54
      BandType = btTitle
      object rllSecTotalNota: TRLLabel
        Left = 0
        Top = 0
        Width = 998
        Height = 14
        AutoSize = False
        Caption = ' TOTAL DOS PRODUTOS E TOTAL DA NOTA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Color = 14540253
        Transparent = False
        Layout = tlCenter
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = False
        Borders.DrawRight = True
        Borders.DrawBottom = True
      end
      object rlpTotProdutos: TRLPanel
        Left = 0
        Top = 13
        Width = 222
        Height = 21
        Borders.Sides = sdAll
        object rllTitTotProdutos: TRLLabel
          Left = 3
          Top = 1
          Width = 216
          Height = 8
          AutoSize = False
          Caption = 'VALOR TOTAL DOS PRODUTOS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllTotProdutos: TRLLabel
          Left = 4
          Top = 9
          Width = 214
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpTotFrete: TRLPanel
        Left = 221
        Top = 13
        Width = 197
        Height = 21
        Borders.Sides = sdAll
        object rllTitTotFrete: TRLLabel
          Left = 3
          Top = 1
          Width = 192
          Height = 8
          AutoSize = False
          Caption = 'VALOR DO FRETE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllTotFrete: TRLLabel
          Left = 4
          Top = 9
          Width = 189
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpTotSeguro: TRLPanel
        Left = 417
        Top = 13
        Width = 197
        Height = 21
        Borders.Sides = sdAll
        object rllTitTotSeguro: TRLLabel
          Left = 3
          Top = 1
          Width = 192
          Height = 8
          AutoSize = False
          Caption = 'VALOR DO SEGURO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllTotSeguro: TRLLabel
          Left = 4
          Top = 9
          Width = 189
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpTotDesconto: TRLPanel
        Left = 613
        Top = 13
        Width = 184
        Height = 21
        Borders.Sides = sdAll
        object rllTitTotDesconto: TRLLabel
          Left = 3
          Top = 1
          Width = 178
          Height = 8
          AutoSize = False
          Caption = 'DESCONTO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllTotDesconto: TRLLabel
          Left = 4
          Top = 9
          Width = 176
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpTotOutras: TRLPanel
        Left = 796
        Top = 13
        Width = 202
        Height = 21
        Borders.Sides = sdAll
        object rllTitTotOutras: TRLLabel
          Left = 3
          Top = 1
          Width = 196
          Height = 8
          AutoSize = False
          Caption = 'OUTRAS DESPESAS ACESS'#211'RIAS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllTotOutras: TRLLabel
          Left = 4
          Top = 9
          Width = 193
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpTotNota: TRLPanel
        Left = 0
        Top = 33
        Width = 998
        Height = 21
        Borders.Sides = sdAll
        object rllTitTotNota: TRLLabel
          Left = 3
          Top = 1
          Width = 992
          Height = 8
          AutoSize = False
          Caption = 'VALOR TOTAL DA NOTA'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllTotNota: TRLLabel
          Left = 4
          Top = 9
          Width = 990
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
    end
    object rlbTotalICMSIPI: TRLBand
      Left = 26
      Top = 464
      Width = 998
      Height = 34
      BandType = btTitle
      object rllSecTotalICMSIPI: TRLLabel
        Left = 0
        Top = 0
        Width = 998
        Height = 14
        AutoSize = False
        Caption = ' TOTAL DO ICMS / IPI'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Color = 14540253
        Transparent = False
        Layout = tlCenter
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = False
        Borders.DrawRight = True
        Borders.DrawBottom = True
      end
      object rlpBaseICMS: TRLPanel
        Left = 0
        Top = 13
        Width = 222
        Height = 21
        Borders.Sides = sdAll
        object rllTitBaseICMS: TRLLabel
          Left = 3
          Top = 1
          Width = 216
          Height = 8
          AutoSize = False
          Caption = 'BASE DE C'#193'LCULO DO ICMS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllBaseICMS: TRLLabel
          Left = 4
          Top = 9
          Width = 214
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpValorICMS: TRLPanel
        Left = 221
        Top = 13
        Width = 197
        Height = 21
        Borders.Sides = sdAll
        object rllTitValorICMS: TRLLabel
          Left = 3
          Top = 1
          Width = 192
          Height = 8
          AutoSize = False
          Caption = 'VALOR DO ICMS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllValorICMS: TRLLabel
          Left = 4
          Top = 9
          Width = 189
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpBaseICMSST: TRLPanel
        Left = 417
        Top = 13
        Width = 197
        Height = 21
        Borders.Sides = sdAll
        object rllTitBaseICMSST: TRLLabel
          Left = 3
          Top = 1
          Width = 192
          Height = 8
          AutoSize = False
          Caption = 'BASE DE C'#193'LCULO DO ICMS ST'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllBaseICMSST: TRLLabel
          Left = 4
          Top = 9
          Width = 189
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpValorICMSST: TRLPanel
        Left = 613
        Top = 13
        Width = 184
        Height = 21
        Borders.Sides = sdAll
        object rllTitValorICMSST: TRLLabel
          Left = 3
          Top = 1
          Width = 178
          Height = 8
          AutoSize = False
          Caption = 'VALOR DO ICMS ST'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllValorICMSST: TRLLabel
          Left = 4
          Top = 9
          Width = 176
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpValorIPI: TRLPanel
        Left = 796
        Top = 13
        Width = 202
        Height = 21
        Borders.Sides = sdAll
        object rllTitValorIPI: TRLLabel
          Left = 3
          Top = 1
          Width = 196
          Height = 8
          AutoSize = False
          Caption = 'VALOR DO IPI'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllValorIPI: TRLLabel
          Left = 4
          Top = 9
          Width = 193
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
    end
    object rlbICMSFCPDifal: TRLBand
      Left = 26
      Top = 498
      Width = 998
      Height = 21
      BandType = btTitle
      object rlpFCP: TRLPanel
        Left = 0
        Top = 0
        Width = 248
        Height = 21
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = False
        Borders.DrawRight = True
        Borders.DrawBottom = True
        Borders.DrawLeft = True
        Borders.DrawTop = False
        Borders.DrawRight = True
        Borders.DrawBottom = True
        object rllTitFCP: TRLLabel
          Left = 3
          Top = 1
          Width = 243
          Height = 8
          AutoSize = False
          Caption = 'VALOR DO FCP'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllFCP: TRLLabel
          Left = 4
          Top = 9
          Width = 240
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpFCPST: TRLPanel
        Left = 247
        Top = 0
        Width = 223
        Height = 21
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = False
        Borders.DrawRight = True
        Borders.DrawBottom = True
        Borders.DrawLeft = True
        Borders.DrawTop = False
        Borders.DrawRight = True
        Borders.DrawBottom = True
        object rllTitFCPST: TRLLabel
          Left = 3
          Top = 1
          Width = 217
          Height = 8
          AutoSize = False
          Caption = 'VALOR DO FCP RETIDO POR ST'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllFCPST: TRLLabel
          Left = 4
          Top = 9
          Width = 215
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpICMSUFDest: TRLPanel
        Left = 469
        Top = 0
        Width = 249
        Height = 21
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = False
        Borders.DrawRight = True
        Borders.DrawBottom = True
        Borders.DrawLeft = True
        Borders.DrawTop = False
        Borders.DrawRight = True
        Borders.DrawBottom = True
        object rllTitICMSUFDest: TRLLabel
          Left = 3
          Top = 1
          Width = 243
          Height = 8
          AutoSize = False
          Caption = 'VALOR DO DIFAL NA UF DE DESTINO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllICMSUFDest: TRLLabel
          Left = 4
          Top = 9
          Width = 240
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpFCPUFDest: TRLPanel
        Left = 717
        Top = 0
        Width = 281
        Height = 21
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = False
        Borders.DrawRight = True
        Borders.DrawBottom = True
        Borders.DrawLeft = True
        Borders.DrawTop = False
        Borders.DrawRight = True
        Borders.DrawBottom = True
        object rllTitFCPUFDest: TRLLabel
          Left = 3
          Top = 1
          Width = 275
          Height = 8
          AutoSize = False
          Caption = 'VALOR DO FCP NA UF DE DESTINO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllFCPUFDest: TRLLabel
          Left = 4
          Top = 9
          Width = 273
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
    end
    object rlbICMSMonofasico: TRLBand
      Left = 26
      Top = 519
      Width = 998
      Height = 21
      BandType = btTitle
      object rlpBCICMSMono: TRLPanel
        Left = 0
        Top = 0
        Width = 248
        Height = 21
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = False
        Borders.DrawRight = True
        Borders.DrawBottom = True
        Borders.DrawLeft = True
        Borders.DrawTop = False
        Borders.DrawRight = True
        Borders.DrawBottom = True
        object rllTitBCICMSMono: TRLLabel
          Left = 3
          Top = 1
          Width = 243
          Height = 8
          AutoSize = False
          Caption = 'BC DO ICMS MONOF'#193'SICO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllBCICMSMono: TRLLabel
          Left = 4
          Top = 9
          Width = 240
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpICMSMono: TRLPanel
        Left = 247
        Top = 0
        Width = 223
        Height = 21
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = False
        Borders.DrawRight = True
        Borders.DrawBottom = True
        Borders.DrawLeft = True
        Borders.DrawTop = False
        Borders.DrawRight = True
        Borders.DrawBottom = True
        object rllTitICMSMono: TRLLabel
          Left = 3
          Top = 1
          Width = 217
          Height = 8
          AutoSize = False
          Caption = 'VALOR DO ICMS MONOF'#193'SICO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllICMSMono: TRLLabel
          Left = 4
          Top = 9
          Width = 215
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpBCICMSMonoReten: TRLPanel
        Left = 469
        Top = 0
        Width = 249
        Height = 21
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = False
        Borders.DrawRight = True
        Borders.DrawBottom = True
        Borders.DrawLeft = True
        Borders.DrawTop = False
        Borders.DrawRight = True
        Borders.DrawBottom = True
        object rllTitBCICMSMonoReten: TRLLabel
          Left = 3
          Top = 1
          Width = 243
          Height = 8
          AutoSize = False
          Caption = 'BC DO ICMS MONOF'#193'SICO POR RETEN'#199#195'O'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllBCICMSMonoReten: TRLLabel
          Left = 4
          Top = 9
          Width = 240
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpICMSMonoReten: TRLPanel
        Left = 717
        Top = 0
        Width = 281
        Height = 21
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = False
        Borders.DrawRight = True
        Borders.DrawBottom = True
        Borders.DrawLeft = True
        Borders.DrawTop = False
        Borders.DrawRight = True
        Borders.DrawBottom = True
        object rllTitICMSMonoReten: TRLLabel
          Left = 3
          Top = 1
          Width = 275
          Height = 8
          AutoSize = False
          Caption = 'VALOR DO ICMS MONOF'#193'SICO POR RETEN'#199#195'O'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllICMSMonoReten: TRLLabel
          Left = 4
          Top = 9
          Width = 273
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
    end
    object rlbTotalIBSCBSIS: TRLBand
      Left = 26
      Top = 540
      Width = 998
      Height = 34
      BandType = btTitle
      object rllSecTotalIBSCBSIS: TRLLabel
        Left = 0
        Top = 0
        Width = 998
        Height = 14
        AutoSize = False
        Caption = ' TOTAL DO IBS / CBS / IS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Color = 14540253
        Transparent = False
        Layout = tlCenter
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = False
        Borders.DrawRight = True
        Borders.DrawBottom = True
      end
      object rlpCBS: TRLPanel
        Left = 0
        Top = 13
        Width = 269
        Height = 21
        Borders.Sides = sdAll
        object rllTitCBS: TRLLabel
          Left = 3
          Top = 1
          Width = 263
          Height = 8
          AutoSize = False
          Caption = 'VALOR DA CBS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllCBS: TRLLabel
          Left = 4
          Top = 9
          Width = 261
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpIBSUF: TRLPanel
        Left = 268
        Top = 13
        Width = 243
        Height = 21
        Borders.Sides = sdAll
        object rllTitIBSUF: TRLLabel
          Left = 3
          Top = 1
          Width = 237
          Height = 8
          AutoSize = False
          Caption = 'VALOR DO IBS UF'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllIBSUF: TRLLabel
          Left = 4
          Top = 9
          Width = 235
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpIBSMun: TRLPanel
        Left = 510
        Top = 13
        Width = 247
        Height = 21
        Borders.Sides = sdAll
        object rllTitIBSMun: TRLLabel
          Left = 3
          Top = 1
          Width = 241
          Height = 8
          AutoSize = False
          Caption = 'VALOR DO IBS MUNIC'#205'PIO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllIBSMun: TRLLabel
          Left = 4
          Top = 9
          Width = 239
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpIS: TRLPanel
        Left = 756
        Top = 13
        Width = 242
        Height = 21
        Borders.Sides = sdAll
        object rllTitIS: TRLLabel
          Left = 3
          Top = 1
          Width = 236
          Height = 8
          AutoSize = False
          Caption = 'VALOR DO IMPOSTO SELETIVO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllIS: TRLLabel
          Left = 4
          Top = 9
          Width = 234
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
    end
    object rlbIBSCBSMonofasico: TRLBand
      Left = 26
      Top = 574
      Width = 998
      Height = 21
      BandType = btTitle
      object rlpIBSMono: TRLPanel
        Left = 0
        Top = 0
        Width = 248
        Height = 21
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = False
        Borders.DrawRight = True
        Borders.DrawBottom = True
        Borders.DrawLeft = True
        Borders.DrawTop = False
        Borders.DrawRight = True
        Borders.DrawBottom = True
        object rllTitIBSMono: TRLLabel
          Left = 3
          Top = 1
          Width = 243
          Height = 8
          AutoSize = False
          Caption = 'VALOR DO IBS MONOF'#193'SICO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllIBSMono: TRLLabel
          Left = 4
          Top = 9
          Width = 240
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpCBSMono: TRLPanel
        Left = 247
        Top = 0
        Width = 172
        Height = 21
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = False
        Borders.DrawRight = True
        Borders.DrawBottom = True
        Borders.DrawLeft = True
        Borders.DrawTop = False
        Borders.DrawRight = True
        Borders.DrawBottom = True
        object rllTitCBSMono: TRLLabel
          Left = 3
          Top = 1
          Width = 166
          Height = 8
          AutoSize = False
          Caption = 'VALOR DA CBS MONOF'#193'SICA'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllCBSMono: TRLLabel
          Left = 4
          Top = 9
          Width = 164
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpIBSMonoReten: TRLPanel
        Left = 418
        Top = 0
        Width = 328
        Height = 21
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = False
        Borders.DrawRight = True
        Borders.DrawBottom = True
        Borders.DrawLeft = True
        Borders.DrawTop = False
        Borders.DrawRight = True
        Borders.DrawBottom = True
        object rllTitIBSMonoReten: TRLLabel
          Left = 3
          Top = 1
          Width = 322
          Height = 8
          AutoSize = False
          Caption = 'VALOR DO IBS MONOF'#193'SICO POR RETEN'#199#195'O'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllIBSMonoReten: TRLLabel
          Left = 4
          Top = 9
          Width = 320
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpCBSMonoReten: TRLPanel
        Left = 745
        Top = 0
        Width = 253
        Height = 21
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = False
        Borders.DrawRight = True
        Borders.DrawBottom = True
        Borders.DrawLeft = True
        Borders.DrawTop = False
        Borders.DrawRight = True
        Borders.DrawBottom = True
        object rllTitCBSMonoReten: TRLLabel
          Left = 3
          Top = 1
          Width = 247
          Height = 8
          AutoSize = False
          Caption = 'VALOR DA CBS MONOF'#193'SICA POR RETEN'#199#195'O'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllCBSMonoReten: TRLLabel
          Left = 4
          Top = 9
          Width = 244
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
    end
    object rlbISSQN: TRLBand
      Left = 26
      Top = 595
      Width = 998
      Height = 34
      BandType = btTitle
      object rllSecISSQN: TRLLabel
        Left = 0
        Top = 0
        Width = 998
        Height = 14
        AutoSize = False
        Caption = ' C'#193'LCULO DO ISSQN'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Color = 14540253
        Transparent = False
        Layout = tlCenter
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = False
        Borders.DrawRight = True
        Borders.DrawBottom = True
      end
      object rlpISSQNInscricao: TRLPanel
        Left = 0
        Top = 13
        Width = 279
        Height = 21
        Borders.Sides = sdAll
        object rllTitISSQNInscricao: TRLLabel
          Left = 3
          Top = 1
          Width = 274
          Height = 8
          AutoSize = False
          Caption = 'INSCRI'#199#195'O MUNICIPAL'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllISSQNInscricao: TRLLabel
          Left = 4
          Top = 9
          Width = 271
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpISSQNServicos: TRLPanel
        Left = 278
        Top = 13
        Width = 239
        Height = 21
        Borders.Sides = sdAll
        object rllTitISSQNServicos: TRLLabel
          Left = 3
          Top = 1
          Width = 233
          Height = 8
          AutoSize = False
          Caption = 'VALOR TOTAL DOS SERVI'#199'OS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllISSQNServicos: TRLLabel
          Left = 4
          Top = 9
          Width = 231
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpISSQNBase: TRLPanel
        Left = 516
        Top = 13
        Width = 240
        Height = 21
        Borders.Sides = sdAll
        object rllTitISSQNBase: TRLLabel
          Left = 3
          Top = 1
          Width = 233
          Height = 8
          AutoSize = False
          Caption = 'BASE DE C'#193'LCULO DO ISSQN'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllISSQNBase: TRLLabel
          Left = 4
          Top = 9
          Width = 231
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpISSQNValor: TRLPanel
        Left = 755
        Top = 13
        Width = 243
        Height = 21
        Borders.Sides = sdAll
        object rllTitISSQNValor: TRLLabel
          Left = 3
          Top = 1
          Width = 237
          Height = 8
          AutoSize = False
          Caption = 'VALOR DO ISSQN'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllISSQNValor: TRLLabel
          Left = 4
          Top = 9
          Width = 235
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
    end
    object rlbTransportador: TRLBand
      Left = 26
      Top = 629
      Width = 998
      Height = 74
      BandType = btTitle
      object rllSecTransportador: TRLLabel
        Left = 0
        Top = 0
        Width = 998
        Height = 14
        AutoSize = False
        Caption = ' TRANSPORTADOR / VOLUMES TRANSPORTADOS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Color = 14540253
        Transparent = False
        Layout = tlCenter
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = False
        Borders.DrawRight = True
        Borders.DrawBottom = True
      end
      object rlpTransNome: TRLPanel
        Left = 0
        Top = 13
        Width = 300
        Height = 21
        Borders.Sides = sdAll
        object rllTitTransNome: TRLLabel
          Left = 3
          Top = 1
          Width = 294
          Height = 8
          AutoSize = False
          Caption = 'RAZ'#195'O SOCIAL'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllTransNome: TRLLabel
          Left = 4
          Top = 9
          Width = 292
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpTransModFrete: TRLPanel
        Left = 299
        Top = 13
        Width = 138
        Height = 21
        Borders.Sides = sdAll
        object rllTitTransModFrete: TRLLabel
          Left = 3
          Top = 1
          Width = 133
          Height = 8
          AutoSize = False
          Caption = 'FRETE POR CONTA'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllTransModFrete: TRLLabel
          Left = 4
          Top = 9
          Width = 130
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpTransANTT: TRLPanel
        Left = 436
        Top = 13
        Width = 139
        Height = 21
        Borders.Sides = sdAll
        object rllTitTransANTT: TRLLabel
          Left = 3
          Top = 1
          Width = 134
          Height = 8
          AutoSize = False
          Caption = 'C'#211'DIGO ANTT'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllTransANTT: TRLLabel
          Left = 4
          Top = 9
          Width = 132
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpTransPlaca: TRLPanel
        Left = 574
        Top = 13
        Width = 139
        Height = 21
        Borders.Sides = sdAll
        object rllTitTransPlaca: TRLLabel
          Left = 3
          Top = 1
          Width = 133
          Height = 8
          AutoSize = False
          Caption = 'PLACA DO VE'#205'CULO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllTransPlaca: TRLLabel
          Left = 4
          Top = 9
          Width = 130
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpTransUFPlaca: TRLPanel
        Left = 712
        Top = 13
        Width = 81
        Height = 21
        Borders.Sides = sdAll
        object rllTitTransUFPlaca: TRLLabel
          Left = 3
          Top = 1
          Width = 76
          Height = 8
          AutoSize = False
          Caption = 'UF'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllTransUFPlaca: TRLLabel
          Left = 4
          Top = 9
          Width = 74
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpTransCNPJ: TRLPanel
        Left = 792
        Top = 13
        Width = 206
        Height = 21
        Borders.Sides = sdAll
        object rllTitTransCNPJ: TRLLabel
          Left = 3
          Top = 1
          Width = 200
          Height = 8
          AutoSize = False
          Caption = 'CNPJ / CPF'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllTransCNPJ: TRLLabel
          Left = 4
          Top = 9
          Width = 197
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpTransEndereco: TRLPanel
        Left = 0
        Top = 33
        Width = 399
        Height = 21
        Borders.Sides = sdAll
        object rllTitTransEndereco: TRLLabel
          Left = 3
          Top = 1
          Width = 393
          Height = 8
          AutoSize = False
          Caption = 'ENDERE'#199'O'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllTransEndereco: TRLLabel
          Left = 4
          Top = 9
          Width = 391
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpTransMunicipio: TRLPanel
        Left = 398
        Top = 33
        Width = 241
        Height = 21
        Borders.Sides = sdAll
        object rllTitTransMunicipio: TRLLabel
          Left = 3
          Top = 1
          Width = 235
          Height = 8
          AutoSize = False
          Caption = 'MUNIC'#205'PIO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllTransMunicipio: TRLLabel
          Left = 4
          Top = 9
          Width = 232
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpTransUF: TRLPanel
        Left = 638
        Top = 33
        Width = 77
        Height = 21
        Borders.Sides = sdAll
        object rllTitTransUF: TRLLabel
          Left = 3
          Top = 1
          Width = 72
          Height = 8
          AutoSize = False
          Caption = 'UF'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllTransUF: TRLLabel
          Left = 4
          Top = 9
          Width = 70
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpTransIE: TRLPanel
        Left = 714
        Top = 33
        Width = 284
        Height = 21
        Borders.Sides = sdAll
        object rllTitTransIE: TRLLabel
          Left = 3
          Top = 1
          Width = 278
          Height = 8
          AutoSize = False
          Caption = 'INSCRI'#199#195'O ESTADUAL'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllTransIE: TRLLabel
          Left = 4
          Top = 9
          Width = 275
          Height = 11
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpVolQtde: TRLPanel
        Left = 0
        Top = 53
        Width = 160
        Height = 21
        Borders.Sides = sdAll
        object rllTitVolQtde: TRLLabel
          Left = 3
          Top = 1
          Width = 154
          Height = 8
          AutoSize = False
          Caption = 'QUANTIDADE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rlmVolQtde: TRLMemo
          Left = 4
          Top = 9
          Width = 152
          Height = 11
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpVolEspecie: TRLPanel
        Left = 159
        Top = 53
        Width = 198
        Height = 21
        Borders.Sides = sdAll
        object rllTitVolEspecie: TRLLabel
          Left = 3
          Top = 1
          Width = 193
          Height = 8
          AutoSize = False
          Caption = 'ESP'#201'CIE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rlmVolEspecie: TRLMemo
          Left = 4
          Top = 9
          Width = 191
          Height = 11
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpVolMarca: TRLPanel
        Left = 356
        Top = 53
        Width = 160
        Height = 21
        Borders.Sides = sdAll
        object rllTitVolMarca: TRLLabel
          Left = 3
          Top = 1
          Width = 154
          Height = 8
          AutoSize = False
          Caption = 'MARCA'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rlmVolMarca: TRLMemo
          Left = 4
          Top = 9
          Width = 152
          Height = 11
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpVolNumeracao: TRLPanel
        Left = 515
        Top = 53
        Width = 179
        Height = 21
        Borders.Sides = sdAll
        object rllTitVolNumeracao: TRLLabel
          Left = 3
          Top = 1
          Width = 173
          Height = 8
          AutoSize = False
          Caption = 'NUMERA'#199#195'O'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rlmVolNumeracao: TRLMemo
          Left = 4
          Top = 9
          Width = 171
          Height = 11
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpVolPesoBruto: TRLPanel
        Left = 693
        Top = 53
        Width = 149
        Height = 21
        Borders.Sides = sdAll
        object rllTitVolPesoBruto: TRLLabel
          Left = 3
          Top = 1
          Width = 143
          Height = 8
          AutoSize = False
          Caption = 'PESO BRUTO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rlmVolPesoBruto: TRLMemo
          Left = 4
          Top = 9
          Width = 141
          Height = 11
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpVolPesoLiquido: TRLPanel
        Left = 841
        Top = 53
        Width = 157
        Height = 21
        Borders.Sides = sdAll
        object rllTitVolPesoLiquido: TRLLabel
          Left = 3
          Top = 1
          Width = 151
          Height = 8
          AutoSize = False
          Caption = 'PESO L'#205'QUIDO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rlmVolPesoLiquido: TRLMemo
          Left = 4
          Top = 9
          Width = 149
          Height = 11
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
    end
    object rlbCanceladaDenegada: TRLBand
      Left = 26
      Top = 703
      Width = 998
      Height = 24
      BandType = btColumnHeader
      object rllCanceladaDenegada: TRLLabel
        Left = 0
        Top = 3
        Width = 998
        Height = 20
        Alignment = taCenter
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Color = clGray
        Transparent = False
        Layout = tlCenter
      end
    end
    object rlbAvisoContingencia: TRLBand
      Left = 26
      Top = 727
      Width = 998
      Height = 37
      BandType = btColumnHeader
      object rllAvisoContingencia: TRLLabel
        Left = 0
        Top = 3
        Width = 998
        Height = 20
        Alignment = taCenter
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Color = clGray
        Transparent = False
        Layout = tlCenter
      end
      object rlmContingencia: TRLMemo
        Left = 0
        Top = 24
        Width = 998
        Height = 11
        Alignment = taCenter
        AutoSize = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
    end
    object rlbCabecalhoItens: TRLBand
      Left = 26
      Top = 764
      Width = 998
      Height = 33
      BandType = btColumnHeader
      object rllSecItens: TRLLabel
        Left = 0
        Top = 0
        Width = 998
        Height = 14
        AutoSize = False
        Caption = ' DADOS DOS PRODUTOS / SERVI'#199'OS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Color = 14540253
        Transparent = False
        Layout = tlCenter
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = False
        Borders.DrawRight = True
        Borders.DrawBottom = True
      end
      object rlpCabDescricao: TRLPanel
        Left = 0
        Top = 13
        Width = 322
        Height = 20
        Borders.Sides = sdAll
        object rlmCabDescricao: TRLMemo
          Left = 4
          Top = 5
          Width = 314
          Height = 9
          Alignment = taCenter
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Lines.Strings = (
            'DESCRI'#199#195'O DO PRODUTO / SERVI'#199'O')
          ParentFont = False
        end
      end
      object rlpCabCSTCFOP: TRLPanel
        Left = 321
        Top = 13
        Width = 68
        Height = 20
        Borders.Sides = sdAll
        object rlmCabCSTCFOP: TRLMemo
          Left = 3
          Top = 1
          Width = 62
          Height = 18
          Alignment = taCenter
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Lines.Strings = (
            'CST /'
            'CFOP')
          ParentFont = False
        end
      end
      object rlpCabQuantidade: TRLPanel
        Left = 388
        Top = 13
        Width = 76
        Height = 20
        Borders.Sides = sdAll
        object rlmCabQuantidade: TRLMemo
          Left = 3
          Top = 5
          Width = 70
          Height = 9
          Alignment = taCenter
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Lines.Strings = (
            'QTD / UN')
          ParentFont = False
        end
      end
      object rlpCabValorUnitario: TRLPanel
        Left = 463
        Top = 13
        Width = 76
        Height = 20
        Borders.Sides = sdAll
        object rlmCabValorUnitario: TRLMemo
          Left = 2
          Top = 5
          Width = 72
          Height = 9
          Alignment = taCenter
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Lines.Strings = (
            'VLR UNIT')
          ParentFont = False
        end
      end
      object rlpCabValorTotal: TRLPanel
        Left = 538
        Top = 13
        Width = 69
        Height = 20
        Borders.Sides = sdAll
        object rlmCabValorTotal: TRLMemo
          Left = 2
          Top = 5
          Width = 65
          Height = 9
          Alignment = taCenter
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Lines.Strings = (
            'VLR TOTAL')
          ParentFont = False
        end
      end
      object rlpCabBases: TRLPanel
        Left = 606
        Top = 13
        Width = 105
        Height = 20
        Borders.Sides = sdAll
        object rlmCabBases: TRLMemo
          Left = 2
          Top = 5
          Width = 101
          Height = 9
          Alignment = taCenter
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Lines.Strings = (
            'BASES DE C'#193'LCULO')
          ParentFont = False
        end
      end
      object rlpCabAliquotas: TRLPanel
        Left = 710
        Top = 13
        Width = 124
        Height = 20
        Borders.Sides = sdAll
        object rlmCabAliquotas: TRLMemo
          Left = 2
          Top = 5
          Width = 120
          Height = 9
          Alignment = taCenter
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Lines.Strings = (
            'AL'#205'QUOTAS')
          ParentFont = False
        end
      end
      object rlpCabValores: TRLPanel
        Left = 833
        Top = 13
        Width = 165
        Height = 20
        Borders.Sides = sdAll
        object rlmCabValores: TRLMemo
          Left = 2
          Top = 5
          Width = 161
          Height = 9
          Alignment = taCenter
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Lines.Strings = (
            'VALOR DOS TRIBUTOS')
          ParentFont = False
        end
      end
    end
    object subItens: TRLSubDetail
      Left = 26
      Top = 797
      Width = 998
      Height = 40
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = False
      Borders.DrawRight = False
      Borders.DrawBottom = False
      OnDataRecord = subItensDataRecord
      object rlbItem: TRLBand
        Left = 0
        Top = 0
        Width = 998
        Height = 38
        Borders.Sides = sdCustom
        Borders.DrawLeft = False
        Borders.DrawTop = False
        Borders.DrawRight = False
        Borders.DrawBottom = False
        BeforePrint = rlbItemBeforePrint
        object rliItemEsquerda: TRLDraw
          Left = 0
          Top = 0
          Width = 1
          Height = 12
          Align = faHeight
          Angle = 90.000000000000000000
          DrawKind = dkLine
          HoldStyle = hsRelatively
        end
        object rliItemDireita: TRLDraw
          Left = 997
          Top = 0
          Width = 1
          Height = 12
          Align = faHeight
          Angle = 90.000000000000000000
          DrawKind = dkLine
          HoldStyle = hsRelatively
        end
        object rliItemBase: TRLDraw
          Left = 0
          Top = 37
          Width = 998
          Height = 1
          Align = faBottomOnly
          DrawKind = dkLine
          HoldStyle = hsRelatively
        end
        object rliItemColuna1: TRLDraw
          Left = 321
          Top = 0
          Width = 1
          Height = 12
          Align = faHeight
          Angle = 90.000000000000000000
          DrawKind = dkLine
          HoldStyle = hsRelatively
        end
        object rliItemColuna2: TRLDraw
          Left = 388
          Top = 0
          Width = 1
          Height = 12
          Align = faHeight
          Angle = 90.000000000000000000
          DrawKind = dkLine
          HoldStyle = hsRelatively
        end
        object rliItemColuna3: TRLDraw
          Left = 463
          Top = 0
          Width = 1
          Height = 12
          Align = faHeight
          Angle = 90.000000000000000000
          DrawKind = dkLine
          HoldStyle = hsRelatively
        end
        object rliItemColuna4: TRLDraw
          Left = 538
          Top = 0
          Width = 1
          Height = 12
          Align = faHeight
          Angle = 90.000000000000000000
          DrawKind = dkLine
          HoldStyle = hsRelatively
        end
        object rliItemColuna5: TRLDraw
          Left = 606
          Top = 0
          Width = 1
          Height = 12
          Align = faHeight
          Angle = 90.000000000000000000
          DrawKind = dkLine
          HoldStyle = hsRelatively
        end
        object rliItemColuna6: TRLDraw
          Left = 710
          Top = 0
          Width = 1
          Height = 12
          Align = faHeight
          Angle = 90.000000000000000000
          DrawKind = dkLine
          HoldStyle = hsRelatively
        end
        object rliItemColuna7: TRLDraw
          Left = 833
          Top = 0
          Width = 1
          Height = 12
          Align = faHeight
          Angle = 90.000000000000000000
          DrawKind = dkLine
          HoldStyle = hsRelatively
        end
        object rlmXProd: TRLMemo
          Left = 4
          Top = 1
          Width = 314
          Height = 9
          AutoSize = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rlmInfAdProd: TRLMemo
          Left = 4
          Top = 10
          Width = 314
          Height = 9
          AutoSize = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllClassificacao: TRLLabel
          Left = 4
          Top = 28
          Width = 314
          Height = 9
          Alignment = taRightJustify
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllCST: TRLLabel
          Left = 324
          Top = 1
          Width = 62
          Height = 9
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllCFOP: TRLLabel
          Left = 324
          Top = 10
          Width = 62
          Height = 9
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rlmQuantidade: TRLMemo
          Left = 391
          Top = 1
          Width = 70
          Height = 18
          Alignment = taCenter
          AutoSize = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rlmValorUnitario: TRLMemo
          Left = 465
          Top = 1
          Width = 72
          Height = 9
          Alignment = taRightJustify
          AutoSize = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllValorTotal: TRLLabel
          Left = 540
          Top = 1
          Width = 65
          Height = 9
          Alignment = taRightJustify
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllBaseRotulo0: TRLLabel
          Left = 608
          Top = 1
          Width = 101
          Height = 9
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllBaseValor0: TRLLabel
          Left = 675
          Top = 1
          Width = 41
          Height = 9
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllBaseRotulo1: TRLLabel
          Left = 608
          Top = 10
          Width = 101
          Height = 9
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllBaseValor1: TRLLabel
          Left = 675
          Top = 10
          Width = 41
          Height = 9
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllBaseRotulo2: TRLLabel
          Left = 608
          Top = 19
          Width = 101
          Height = 9
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllBaseValor2: TRLLabel
          Left = 675
          Top = 19
          Width = 41
          Height = 9
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllBaseRotulo3: TRLLabel
          Left = 608
          Top = 28
          Width = 101
          Height = 9
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllBaseValor3: TRLLabel
          Left = 675
          Top = 28
          Width = 41
          Height = 9
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllAliqRotulo00: TRLLabel
          Left = 712
          Top = 1
          Width = 57
          Height = 9
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllAliqValor00: TRLLabel
          Left = 738
          Top = 1
          Width = 31
          Height = 9
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllAliqRotulo01: TRLLabel
          Left = 775
          Top = 1
          Width = 57
          Height = 9
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllAliqValor01: TRLLabel
          Left = 801
          Top = 1
          Width = 31
          Height = 9
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllAliqBarra0: TRLLabel
          Left = 769
          Top = 1
          Width = 6
          Height = 9
          Alignment = taCenter
          AutoSize = False
          Caption = '/'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllAliqRotulo10: TRLLabel
          Left = 712
          Top = 10
          Width = 57
          Height = 9
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllAliqValor10: TRLLabel
          Left = 738
          Top = 10
          Width = 31
          Height = 9
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllAliqRotulo11: TRLLabel
          Left = 775
          Top = 10
          Width = 57
          Height = 9
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllAliqValor11: TRLLabel
          Left = 801
          Top = 10
          Width = 31
          Height = 9
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllAliqBarra1: TRLLabel
          Left = 769
          Top = 10
          Width = 6
          Height = 9
          Alignment = taCenter
          AutoSize = False
          Caption = '/'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllAliqRotulo20: TRLLabel
          Left = 712
          Top = 19
          Width = 57
          Height = 9
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllAliqValor20: TRLLabel
          Left = 738
          Top = 19
          Width = 31
          Height = 9
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllAliqRotulo21: TRLLabel
          Left = 775
          Top = 19
          Width = 57
          Height = 9
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllAliqValor21: TRLLabel
          Left = 801
          Top = 19
          Width = 31
          Height = 9
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllAliqBarra2: TRLLabel
          Left = 769
          Top = 19
          Width = 6
          Height = 9
          Alignment = taCenter
          AutoSize = False
          Caption = '/'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllValRotulo00: TRLLabel
          Left = 835
          Top = 1
          Width = 77
          Height = 9
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllValValor00: TRLLabel
          Left = 878
          Top = 1
          Width = 34
          Height = 9
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllValRotulo01: TRLLabel
          Left = 918
          Top = 1
          Width = 77
          Height = 9
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllValValor01: TRLLabel
          Left = 962
          Top = 1
          Width = 33
          Height = 9
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllValBarra0: TRLLabel
          Left = 912
          Top = 1
          Width = 6
          Height = 9
          Alignment = taCenter
          AutoSize = False
          Caption = '/'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllValRotulo10: TRLLabel
          Left = 835
          Top = 10
          Width = 77
          Height = 9
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllValValor10: TRLLabel
          Left = 878
          Top = 10
          Width = 34
          Height = 9
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllValRotulo11: TRLLabel
          Left = 918
          Top = 10
          Width = 77
          Height = 9
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllValValor11: TRLLabel
          Left = 962
          Top = 10
          Width = 33
          Height = 9
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllValBarra1: TRLLabel
          Left = 912
          Top = 10
          Width = 6
          Height = 9
          Alignment = taCenter
          AutoSize = False
          Caption = '/'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllValRotulo20: TRLLabel
          Left = 835
          Top = 19
          Width = 77
          Height = 9
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllValValor20: TRLLabel
          Left = 878
          Top = 19
          Width = 34
          Height = 9
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllValRotulo21: TRLLabel
          Left = 918
          Top = 19
          Width = 77
          Height = 9
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllValValor21: TRLLabel
          Left = 962
          Top = 19
          Width = 33
          Height = 9
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllValBarra2: TRLLabel
          Left = 912
          Top = 19
          Width = 6
          Height = 9
          Alignment = taCenter
          AutoSize = False
          Caption = '/'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
    end
    object rlbDadosAdicionais: TRLBand
      Left = 26
      Top = 837
      Width = 998
      Height = 102
      BandType = btFooter
      AutoExpand = False
      BeforePrint = rlbDadosAdicionaisBeforePrint
      object rllSecDadosAdicionais: TRLLabel
        Left = 0
        Top = 2
        Width = 867
        Height = 14
        AutoSize = False
        Caption = ' DADOS ADICIONAIS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Color = 14540253
        Transparent = False
        Layout = tlCenter
        Borders.Sides = sdAll
      end
      object rlpInfCompl: TRLPanel
        Left = 0
        Top = 15
        Width = 448
        Height = 86
        Borders.Sides = sdAll
        object rllTitInfCompl: TRLLabel
          Left = 3
          Top = 1
          Width = 442
          Height = 8
          AutoSize = False
          Caption = 'INFORMA'#199#213'ES COMPLEMENTARES'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rlmDadosAdicionais: TRLMemo
          Left = 4
          Top = 10
          Width = 440
          Height = 74
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpFisco: TRLPanel
        Left = 447
        Top = 15
        Width = 420
        Height = 86
        Borders.Sides = sdAll
        object rllTitFisco: TRLLabel
          Left = 2
          Top = 1
          Width = 416
          Height = 8
          AutoSize = False
          Caption = 'RESERVADO AO FISCO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rlmDadosFisco: TRLMemo
          Left = 3
          Top = 10
          Width = 414
          Height = 74
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpQRCode: TRLPanel
        Left = 872
        Top = 2
        Width = 126
        Height = 99
        Borders.Sides = sdAll
        object rllTitQRCode: TRLLabel
          Left = 1
          Top = 1
          Width = 124
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = 'QR CODE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Color = 14540253
          Transparent = False
          Layout = tlCenter
        end
        object rliQRCodeLinha: TRLDraw
          Left = 0
          Top = 14
          Width = 126
          Height = 1
          DrawKind = dkLine
        end
        object rliQRCode: TRLImage
          Left = 20
          Top = 16
          Width = 86
          Height = 80
          Center = True
          Scaled = True
        end
      end
      object rlmDadosAdicionaisAuxiliar: TRLMemo
        Left = 4
        Top = 25
        Width = 440
        Height = 9
        AutoSize = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object rllHomologacao: TRLLabel
        Left = 0
        Top = 45
        Width = 998
        Height = 24
        Alignment = taCenter
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
      end
    end
    object rlbRodape: TRLBand
      Left = 26
      Top = 939
      Width = 998
      Height = 12
      BandType = btFooter
      object rllUsuario: TRLLabel
        Left = 0
        Top = 1
        Width = 497
        Height = 9
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -6
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllSistema: TRLLabel
        Left = 500
        Top = 1
        Width = 498
        Height = 9
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -6
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
    end
    object rlbContinuacao: TRLBand
      Left = 26
      Top = 951
      Width = 998
      Height = 36
      BandType = btSummary
      BeforePrint = rlbContinuacaoBeforePrint
      object rllSecContinuacao: TRLLabel
        Left = 0
        Top = 2
        Width = 998
        Height = 14
        AutoSize = False
        Caption = ' CONTINUA'#199#195'O DAS INFORMA'#199#213'ES COMPLEMENTARES'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Color = 14540253
        Transparent = False
        Layout = tlCenter
        Borders.Sides = sdAll
      end
      object rlpContinuacao: TRLPanel
        Left = 0
        Top = 15
        Width = 998
        Height = 20
        Borders.Sides = sdAll
        object rlmContinuacaoDadosAdicionais: TRLMemo
          Left = 4
          Top = 2
          Width = 990
          Height = 16
          AutoSize = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
    end
  end
end
