inherited frlDANFeRLRetratoRTC: TfrlDANFeRLRetratoRTC
  Left = 234
  Top = 0
  Caption = 'frlDANFeRLRetratoRTC'
  inherited RLNFe: TRLReport
    Margins.LeftMargin = 7.000000000000000000
    Margins.TopMargin = 7.000000000000000000
    Margins.RightMargin = 7.000000000000000000
    Margins.BottomMargin = 7.000000000000000000
    AdjustableMargins = True
    PrintDialog = False
    Title = 'DANFE Retrato RTC'
    BeforePrint = RLNFeBeforePrint
    OnDataRecord = RLNFeDataRecord
    object rlbCanhoto: TRLBand
      Left = 26
      Top = 26
      Width = 742
      Height = 58
      BandType = btHeader
      BeforePrint = rlbCanhotoBeforePrint
      object rlpCanhotoRecebemos: TRLPanel
        Left = 0
        Top = 0
        Width = 621
        Height = 30
        Borders.Sides = sdAll
        object rllRecebemosDe: TRLLabel
          Left = 3
          Top = 3
          Width = 615
          Height = 9
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object rllResumo: TRLLabel
          Left = 3
          Top = 16
          Width = 615
          Height = 9
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpCanhotoData: TRLPanel
        Left = 0
        Top = 29
        Width = 176
        Height = 29
        Borders.Sides = sdAll
        object rllTitCanhotoData: TRLLabel
          Left = 2
          Top = 1
          Width = 172
          Height = 8
          AutoSize = False
          Caption = 'DATA DE RECEBIMENTO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpCanhotoAssinatura: TRLPanel
        Left = 175
        Top = 29
        Width = 446
        Height = 29
        Borders.Sides = sdAll
        object rllTitCanhotoAssinatura: TRLLabel
          Left = 2
          Top = 1
          Width = 442
          Height = 8
          AutoSize = False
          Caption = 'IDENTIFICA'#199#195'O E ASSINATURA DO RECEBEDOR'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpCanhotoNFe: TRLPanel
        Left = 620
        Top = 0
        Width = 122
        Height = 58
        Borders.Sides = sdAll
        object rllCanhotoNFe: TRLLabel
          Left = 3
          Top = 8
          Width = 116
          Height = 16
          Alignment = taCenter
          AutoSize = False
          Caption = 'NF-e'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object rllCanhotoNumero: TRLLabel
          Left = 3
          Top = 27
          Width = 116
          Height = 11
          Alignment = taCenter
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllCanhotoSerie: TRLLabel
          Left = 3
          Top = 39
          Width = 116
          Height = 11
          Alignment = taCenter
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
    object rlbDivisaoCanhoto: TRLBand
      Left = 26
      Top = 84
      Width = 742
      Height = 12
      BandType = btHeader
      BeforePrint = rlbCanhotoBeforePrint
      object rliDivisaoCanhoto: TRLDraw
        Left = 0
        Top = 2
        Width = 742
        Height = 8
        DrawKind = dkLine
        HoldStyle = hsHorizontally
        Pen.Style = psDot
      end
    end
    object rlbEmitente: TRLBand
      Left = 26
      Top = 96
      Width = 742
      Height = 160
      BandType = btHeader
      BeforePrint = rlbEmitenteBeforePrint
      object rlpEmitente: TRLPanel
        Left = 0
        Top = 0
        Width = 234
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
          Width = 152
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
          Width = 152
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
        Left = 233
        Top = 0
        Width = 120
        Height = 88
        Borders.Sides = sdAll
        object rllDANFE: TRLLabel
          Left = 2
          Top = 2
          Width = 116
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
          Left = 2
          Top = 19
          Width = 116
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
          Left = 49
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
          Left = 2
          Top = 57
          Width = 116
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
          Left = 2
          Top = 67
          Width = 116
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
          Left = 2
          Top = 77
          Width = 48
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
          Left = 52
          Top = 77
          Width = 40
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
          Left = 92
          Top = 77
          Width = 26
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
        Left = 352
        Top = 0
        Width = 390
        Height = 88
        Borders.Sides = sdAll
        object rlbCodigoBarras: TRLBarcode
          Left = 2
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
          Width = 390
          Height = 1
          DrawKind = dkLine
        end
        object rllTitChave: TRLLabel
          Left = 2
          Top = 37
          Width = 386
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
          Left = 2
          Top = 47
          Width = 386
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
          Width = 390
          Height = 1
          DrawKind = dkLine
        end
        object rlmConsulta: TRLMemo
          Left = 3
          Top = 63
          Width = 384
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
          Left = 2
          Top = 7
          Width = 386
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
        Width = 353
        Height = 24
        Borders.Sides = sdAll
        object rllTitNatOp: TRLLabel
          Left = 2
          Top = 1
          Width = 349
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
          Left = 3
          Top = 10
          Width = 347
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpProtocolo: TRLPanel
        Left = 352
        Top = 87
        Width = 390
        Height = 24
        Borders.Sides = sdAll
        object rllTitProtocolo: TRLLabel
          Left = 2
          Top = 1
          Width = 386
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
          Left = 3
          Top = 10
          Width = 384
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpIE: TRLPanel
        Left = 0
        Top = 110
        Width = 291
        Height = 24
        Borders.Sides = sdAll
        object rllTitIE: TRLLabel
          Left = 2
          Top = 1
          Width = 287
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
          Left = 3
          Top = 10
          Width = 285
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpIEST: TRLPanel
        Left = 290
        Top = 110
        Width = 245
        Height = 24
        Borders.Sides = sdAll
        object rllTitIEST: TRLLabel
          Left = 2
          Top = 1
          Width = 241
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
          Left = 3
          Top = 10
          Width = 239
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpCNPJ: TRLPanel
        Left = 534
        Top = 110
        Width = 208
        Height = 24
        Borders.Sides = sdAll
        object rllTitCNPJ: TRLLabel
          Left = 2
          Top = 1
          Width = 204
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
          Left = 3
          Top = 10
          Width = 202
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpCRT: TRLPanel
        Left = 0
        Top = 133
        Width = 403
        Height = 24
        Borders.Sides = sdAll
        object rllTitCRT: TRLLabel
          Left = 2
          Top = 1
          Width = 399
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
          Left = 3
          Top = 10
          Width = 397
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpRegimeApuracao: TRLPanel
        Left = 402
        Top = 133
        Width = 340
        Height = 24
        Borders.Sides = sdAll
        object rllTitRegimeApuracao: TRLLabel
          Left = 2
          Top = 1
          Width = 336
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
          Left = 3
          Top = 10
          Width = 334
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
    end
    object rlbDestinatario: TRLBand
      Left = 26
      Top = 256
      Width = 742
      Height = 85
      BandType = btTitle
      object rllSecDestinatario: TRLLabel
        Left = 0
        Top = 2
        Width = 742
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
        Borders.Sides = sdAll
      end
      object rlpDestNome: TRLPanel
        Left = 0
        Top = 15
        Width = 420
        Height = 24
        Borders.Sides = sdAll
        object rllTitDestNome: TRLLabel
          Left = 2
          Top = 1
          Width = 416
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
          Left = 3
          Top = 10
          Width = 414
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpDestCNPJ: TRLPanel
        Left = 419
        Top = 15
        Width = 180
        Height = 24
        Borders.Sides = sdAll
        object rllTitDestCNPJ: TRLLabel
          Left = 2
          Top = 1
          Width = 176
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
          Left = 3
          Top = 10
          Width = 174
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpDestEmissao: TRLPanel
        Left = 598
        Top = 15
        Width = 144
        Height = 24
        Borders.Sides = sdAll
        object rllTitDestEmissao: TRLLabel
          Left = 2
          Top = 1
          Width = 140
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
          Left = 3
          Top = 10
          Width = 138
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpDestEndereco: TRLPanel
        Left = 0
        Top = 38
        Width = 360
        Height = 24
        Borders.Sides = sdAll
        object rllTitDestEndereco: TRLLabel
          Left = 2
          Top = 1
          Width = 356
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
          Left = 3
          Top = 10
          Width = 354
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpDestBairro: TRLPanel
        Left = 359
        Top = 38
        Width = 160
        Height = 24
        Borders.Sides = sdAll
        object rllTitDestBairro: TRLLabel
          Left = 2
          Top = 1
          Width = 156
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
          Left = 3
          Top = 10
          Width = 154
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpDestCEP: TRLPanel
        Left = 518
        Top = 38
        Width = 81
        Height = 24
        Borders.Sides = sdAll
        object rllTitDestCEP: TRLLabel
          Left = 2
          Top = 1
          Width = 77
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
          Left = 3
          Top = 10
          Width = 75
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpDestSaida: TRLPanel
        Left = 598
        Top = 38
        Width = 144
        Height = 24
        Borders.Sides = sdAll
        object rllTitDestSaida: TRLLabel
          Left = 2
          Top = 1
          Width = 140
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
          Left = 3
          Top = 10
          Width = 138
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpDestMunicipio: TRLPanel
        Left = 0
        Top = 61
        Width = 225
        Height = 24
        Borders.Sides = sdAll
        object rllTitDestMunicipio: TRLLabel
          Left = 2
          Top = 1
          Width = 221
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
          Left = 3
          Top = 10
          Width = 219
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpDestFone: TRLPanel
        Left = 224
        Top = 61
        Width = 125
        Height = 24
        Borders.Sides = sdAll
        object rllTitDestFone: TRLLabel
          Left = 2
          Top = 1
          Width = 121
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
          Left = 3
          Top = 10
          Width = 119
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpDestUF: TRLPanel
        Left = 348
        Top = 61
        Width = 40
        Height = 24
        Borders.Sides = sdAll
        object rllTitDestUF: TRLLabel
          Left = 2
          Top = 1
          Width = 36
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
          Left = 3
          Top = 10
          Width = 34
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpDestIE: TRLPanel
        Left = 387
        Top = 61
        Width = 212
        Height = 24
        Borders.Sides = sdAll
        object rllTitDestIE: TRLLabel
          Left = 2
          Top = 1
          Width = 208
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
          Left = 3
          Top = 10
          Width = 206
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpDestHoraSaida: TRLPanel
        Left = 598
        Top = 61
        Width = 144
        Height = 24
        Borders.Sides = sdAll
        object rllTitDestHoraSaida: TRLLabel
          Left = 2
          Top = 1
          Width = 140
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
          Left = 3
          Top = 10
          Width = 138
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
    end
    object rlbRetirada: TRLBand
      Left = 26
      Top = 341
      Width = 742
      Height = 85
      BandType = btTitle
      object rllSecRetirada: TRLLabel
        Left = 0
        Top = 2
        Width = 742
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
        Borders.Sides = sdAll
      end
      object rlpRetiradaNome: TRLPanel
        Left = 0
        Top = 15
        Width = 420
        Height = 24
        Borders.Sides = sdAll
        object rllTitRetiradaNome: TRLLabel
          Left = 2
          Top = 1
          Width = 416
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
          Left = 3
          Top = 10
          Width = 414
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpRetiradaCNPJ: TRLPanel
        Left = 419
        Top = 15
        Width = 180
        Height = 24
        Borders.Sides = sdAll
        object rllTitRetiradaCNPJ: TRLLabel
          Left = 2
          Top = 1
          Width = 176
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
          Left = 3
          Top = 10
          Width = 174
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpRetiradaIE: TRLPanel
        Left = 598
        Top = 15
        Width = 144
        Height = 24
        Borders.Sides = sdAll
        object rllTitRetiradaIE: TRLLabel
          Left = 2
          Top = 1
          Width = 140
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
          Left = 3
          Top = 10
          Width = 138
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpRetiradaEndereco: TRLPanel
        Left = 0
        Top = 38
        Width = 360
        Height = 24
        Borders.Sides = sdAll
        object rllTitRetiradaEndereco: TRLLabel
          Left = 2
          Top = 1
          Width = 356
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
          Left = 3
          Top = 10
          Width = 354
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpRetiradaBairro: TRLPanel
        Left = 359
        Top = 38
        Width = 240
        Height = 24
        Borders.Sides = sdAll
        object rllTitRetiradaBairro: TRLLabel
          Left = 2
          Top = 1
          Width = 236
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
          Left = 3
          Top = 10
          Width = 234
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpRetiradaCEP: TRLPanel
        Left = 598
        Top = 38
        Width = 144
        Height = 24
        Borders.Sides = sdAll
        object rllTitRetiradaCEP: TRLLabel
          Left = 2
          Top = 1
          Width = 140
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
          Left = 3
          Top = 10
          Width = 138
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpRetiradaMunicipio: TRLPanel
        Left = 0
        Top = 61
        Width = 360
        Height = 24
        Borders.Sides = sdAll
        object rllTitRetiradaMunicipio: TRLLabel
          Left = 2
          Top = 1
          Width = 356
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
          Left = 3
          Top = 10
          Width = 354
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpRetiradaFone: TRLPanel
        Left = 359
        Top = 61
        Width = 180
        Height = 24
        Borders.Sides = sdAll
        object rllTitRetiradaFone: TRLLabel
          Left = 2
          Top = 1
          Width = 176
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
          Left = 3
          Top = 10
          Width = 174
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpRetiradaUF: TRLPanel
        Left = 538
        Top = 61
        Width = 204
        Height = 24
        Borders.Sides = sdAll
        object rllTitRetiradaUF: TRLLabel
          Left = 2
          Top = 1
          Width = 200
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
          Left = 3
          Top = 10
          Width = 198
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
    end
    object rlbEntrega: TRLBand
      Left = 26
      Top = 426
      Width = 742
      Height = 85
      BandType = btTitle
      object rllSecEntrega: TRLLabel
        Left = 0
        Top = 2
        Width = 742
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
        Borders.Sides = sdAll
      end
      object rlpEntregaNome: TRLPanel
        Left = 0
        Top = 15
        Width = 420
        Height = 24
        Borders.Sides = sdAll
        object rllTitEntregaNome: TRLLabel
          Left = 2
          Top = 1
          Width = 416
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
          Left = 3
          Top = 10
          Width = 414
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpEntregaCNPJ: TRLPanel
        Left = 419
        Top = 15
        Width = 180
        Height = 24
        Borders.Sides = sdAll
        object rllTitEntregaCNPJ: TRLLabel
          Left = 2
          Top = 1
          Width = 176
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
          Left = 3
          Top = 10
          Width = 174
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpEntregaIE: TRLPanel
        Left = 598
        Top = 15
        Width = 144
        Height = 24
        Borders.Sides = sdAll
        object rllTitEntregaIE: TRLLabel
          Left = 2
          Top = 1
          Width = 140
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
          Left = 3
          Top = 10
          Width = 138
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpEntregaEndereco: TRLPanel
        Left = 0
        Top = 38
        Width = 360
        Height = 24
        Borders.Sides = sdAll
        object rllTitEntregaEndereco: TRLLabel
          Left = 2
          Top = 1
          Width = 356
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
          Left = 3
          Top = 10
          Width = 354
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpEntregaBairro: TRLPanel
        Left = 359
        Top = 38
        Width = 240
        Height = 24
        Borders.Sides = sdAll
        object rllTitEntregaBairro: TRLLabel
          Left = 2
          Top = 1
          Width = 236
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
          Left = 3
          Top = 10
          Width = 234
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpEntregaCEP: TRLPanel
        Left = 598
        Top = 38
        Width = 144
        Height = 24
        Borders.Sides = sdAll
        object rllTitEntregaCEP: TRLLabel
          Left = 2
          Top = 1
          Width = 140
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
          Left = 3
          Top = 10
          Width = 138
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpEntregaMunicipio: TRLPanel
        Left = 0
        Top = 61
        Width = 360
        Height = 24
        Borders.Sides = sdAll
        object rllTitEntregaMunicipio: TRLLabel
          Left = 2
          Top = 1
          Width = 356
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
          Left = 3
          Top = 10
          Width = 354
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpEntregaFone: TRLPanel
        Left = 359
        Top = 61
        Width = 180
        Height = 24
        Borders.Sides = sdAll
        object rllTitEntregaFone: TRLLabel
          Left = 2
          Top = 1
          Width = 176
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
          Left = 3
          Top = 10
          Width = 174
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpEntregaUF: TRLPanel
        Left = 538
        Top = 61
        Width = 204
        Height = 24
        Borders.Sides = sdAll
        object rllTitEntregaUF: TRLLabel
          Left = 2
          Top = 1
          Width = 200
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
          Left = 3
          Top = 10
          Width = 198
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
    end
    object rlbFatura: TRLBand
      Left = 26
      Top = 511
      Width = 742
      Height = 39
      BandType = btTitle
      object rllSecFatura: TRLLabel
        Left = 0
        Top = 2
        Width = 742
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
        Borders.Sides = sdAll
      end
    end
    object rlbTotalNota: TRLBand
      Left = 26
      Top = 589
      Width = 742
      Height = 62
      BandType = btTitle
      object rllSecTotalNota: TRLLabel
        Left = 0
        Top = 2
        Width = 742
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
        Borders.Sides = sdAll
      end
      object rlpTotProdutos: TRLPanel
        Left = 0
        Top = 15
        Width = 165
        Height = 24
        Borders.Sides = sdAll
        object rllTitTotProdutos: TRLLabel
          Left = 2
          Top = 1
          Width = 161
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
          Left = 3
          Top = 10
          Width = 159
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpTotFrete: TRLPanel
        Left = 164
        Top = 15
        Width = 147
        Height = 24
        Borders.Sides = sdAll
        object rllTitTotFrete: TRLLabel
          Left = 2
          Top = 1
          Width = 143
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
          Left = 3
          Top = 10
          Width = 141
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpTotSeguro: TRLPanel
        Left = 310
        Top = 15
        Width = 147
        Height = 24
        Borders.Sides = sdAll
        object rllTitTotSeguro: TRLLabel
          Left = 2
          Top = 1
          Width = 143
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
          Left = 3
          Top = 10
          Width = 141
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpTotDesconto: TRLPanel
        Left = 456
        Top = 15
        Width = 137
        Height = 24
        Borders.Sides = sdAll
        object rllTitTotDesconto: TRLLabel
          Left = 2
          Top = 1
          Width = 133
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
          Left = 3
          Top = 10
          Width = 131
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpTotOutras: TRLPanel
        Left = 592
        Top = 15
        Width = 150
        Height = 24
        Borders.Sides = sdAll
        object rllTitTotOutras: TRLLabel
          Left = 2
          Top = 1
          Width = 146
          Height = 8
          AutoSize = False
          Caption = 'OUTRAS DESPESAS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object rllTotOutras: TRLLabel
          Left = 3
          Top = 10
          Width = 144
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpTotNota: TRLPanel
        Left = 0
        Top = 38
        Width = 742
        Height = 24
        Borders.Sides = sdAll
        object rllTitTotNota: TRLLabel
          Left = 2
          Top = 1
          Width = 738
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
          Left = 3
          Top = 10
          Width = 736
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
    end
    object rlbTotalICMSIPI: TRLBand
      Left = 26
      Top = 651
      Width = 742
      Height = 39
      BandType = btTitle
      object rllSecTotalICMSIPI: TRLLabel
        Left = 0
        Top = 2
        Width = 742
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
        Borders.Sides = sdAll
      end
      object rlpBaseICMS: TRLPanel
        Left = 0
        Top = 15
        Width = 165
        Height = 24
        Borders.Sides = sdAll
        object rllTitBaseICMS: TRLLabel
          Left = 2
          Top = 1
          Width = 161
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
          Left = 3
          Top = 10
          Width = 159
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpValorICMS: TRLPanel
        Left = 164
        Top = 15
        Width = 147
        Height = 24
        Borders.Sides = sdAll
        object rllTitValorICMS: TRLLabel
          Left = 2
          Top = 1
          Width = 143
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
          Left = 3
          Top = 10
          Width = 141
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpBaseICMSST: TRLPanel
        Left = 310
        Top = 15
        Width = 147
        Height = 24
        Borders.Sides = sdAll
        object rllTitBaseICMSST: TRLLabel
          Left = 2
          Top = 1
          Width = 143
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
          Left = 3
          Top = 10
          Width = 141
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpValorICMSST: TRLPanel
        Left = 456
        Top = 15
        Width = 137
        Height = 24
        Borders.Sides = sdAll
        object rllTitValorICMSST: TRLLabel
          Left = 2
          Top = 1
          Width = 133
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
          Left = 3
          Top = 10
          Width = 131
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpValorIPI: TRLPanel
        Left = 592
        Top = 15
        Width = 150
        Height = 24
        Borders.Sides = sdAll
        object rllTitValorIPI: TRLLabel
          Left = 2
          Top = 1
          Width = 146
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
          Left = 3
          Top = 10
          Width = 144
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
    end
    object rlbICMSFCPDifal: TRLBand
      Left = 26
      Top = 690
      Width = 742
      Height = 24
      BandType = btTitle
      object rlpFCP: TRLPanel
        Left = 0
        Top = 0
        Width = 185
        Height = 24
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = False
        Borders.DrawRight = True
        Borders.DrawBottom = True
        object rllTitFCP: TRLLabel
          Left = 2
          Top = 1
          Width = 181
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
          Left = 3
          Top = 10
          Width = 179
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpFCPST: TRLPanel
        Left = 184
        Top = 0
        Width = 166
        Height = 24
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = False
        Borders.DrawRight = True
        Borders.DrawBottom = True
        object rllTitFCPST: TRLLabel
          Left = 2
          Top = 1
          Width = 162
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
          Left = 3
          Top = 10
          Width = 160
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpICMSUFDest: TRLPanel
        Left = 349
        Top = 0
        Width = 185
        Height = 24
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = False
        Borders.DrawRight = True
        Borders.DrawBottom = True
        object rllTitICMSUFDest: TRLLabel
          Left = 2
          Top = 1
          Width = 181
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
          Left = 3
          Top = 10
          Width = 179
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpFCPUFDest: TRLPanel
        Left = 533
        Top = 0
        Width = 209
        Height = 24
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = False
        Borders.DrawRight = True
        Borders.DrawBottom = True
        object rllTitFCPUFDest: TRLLabel
          Left = 2
          Top = 1
          Width = 205
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
          Left = 3
          Top = 10
          Width = 203
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
    end
    object rlbICMSMonofasico: TRLBand
      Left = 26
      Top = 714
      Width = 742
      Height = 24
      BandType = btTitle
      object rlpBCICMSMono: TRLPanel
        Left = 0
        Top = 0
        Width = 185
        Height = 24
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = False
        Borders.DrawRight = True
        Borders.DrawBottom = True
        object rllTitBCICMSMono: TRLLabel
          Left = 2
          Top = 1
          Width = 181
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
          Left = 3
          Top = 10
          Width = 179
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpICMSMono: TRLPanel
        Left = 184
        Top = 0
        Width = 166
        Height = 24
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = False
        Borders.DrawRight = True
        Borders.DrawBottom = True
        object rllTitICMSMono: TRLLabel
          Left = 2
          Top = 1
          Width = 162
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
          Left = 3
          Top = 10
          Width = 160
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpBCICMSMonoReten: TRLPanel
        Left = 349
        Top = 0
        Width = 185
        Height = 24
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = False
        Borders.DrawRight = True
        Borders.DrawBottom = True
        object rllTitBCICMSMonoReten: TRLLabel
          Left = 2
          Top = 1
          Width = 181
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
          Left = 3
          Top = 10
          Width = 179
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpICMSMonoReten: TRLPanel
        Left = 533
        Top = 0
        Width = 209
        Height = 24
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = False
        Borders.DrawRight = True
        Borders.DrawBottom = True
        object rllTitICMSMonoReten: TRLLabel
          Left = 2
          Top = 1
          Width = 205
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
          Left = 3
          Top = 10
          Width = 203
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
    end
    object rlbTotalIBSCBSIS: TRLBand
      Left = 26
      Top = 738
      Width = 742
      Height = 39
      BandType = btTitle
      object rllSecTotalIBSCBSIS: TRLLabel
        Left = 0
        Top = 2
        Width = 742
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
        Borders.Sides = sdAll
      end
      object rlpCBS: TRLPanel
        Left = 0
        Top = 15
        Width = 200
        Height = 24
        Borders.Sides = sdAll
        object rllTitCBS: TRLLabel
          Left = 2
          Top = 1
          Width = 196
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
          Left = 3
          Top = 10
          Width = 194
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpIBSUF: TRLPanel
        Left = 199
        Top = 15
        Width = 181
        Height = 24
        Borders.Sides = sdAll
        object rllTitIBSUF: TRLLabel
          Left = 2
          Top = 1
          Width = 177
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
          Left = 3
          Top = 10
          Width = 175
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpIBSMun: TRLPanel
        Left = 379
        Top = 15
        Width = 184
        Height = 24
        Borders.Sides = sdAll
        object rllTitIBSMun: TRLLabel
          Left = 2
          Top = 1
          Width = 180
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
          Left = 3
          Top = 10
          Width = 178
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpIS: TRLPanel
        Left = 562
        Top = 15
        Width = 180
        Height = 24
        Borders.Sides = sdAll
        object rllTitIS: TRLLabel
          Left = 2
          Top = 1
          Width = 176
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
          Left = 3
          Top = 10
          Width = 174
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
    end
    object rlbIBSCBSMonofasico: TRLBand
      Left = 26
      Top = 777
      Width = 742
      Height = 24
      BandType = btTitle
      object rlpIBSMono: TRLPanel
        Left = 0
        Top = 0
        Width = 185
        Height = 24
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = False
        Borders.DrawRight = True
        Borders.DrawBottom = True
        object rllTitIBSMono: TRLLabel
          Left = 2
          Top = 1
          Width = 181
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
          Left = 3
          Top = 10
          Width = 179
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpCBSMono: TRLPanel
        Left = 184
        Top = 0
        Width = 128
        Height = 24
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = False
        Borders.DrawRight = True
        Borders.DrawBottom = True
        object rllTitCBSMono: TRLLabel
          Left = 2
          Top = 1
          Width = 124
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
          Left = 3
          Top = 10
          Width = 122
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpIBSMonoReten: TRLPanel
        Left = 311
        Top = 0
        Width = 244
        Height = 24
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = False
        Borders.DrawRight = True
        Borders.DrawBottom = True
        object rllTitIBSMonoReten: TRLLabel
          Left = 2
          Top = 1
          Width = 240
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
          Left = 3
          Top = 10
          Width = 238
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpCBSMonoReten: TRLPanel
        Left = 554
        Top = 0
        Width = 188
        Height = 24
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = False
        Borders.DrawRight = True
        Borders.DrawBottom = True
        object rllTitCBSMonoReten: TRLLabel
          Left = 2
          Top = 1
          Width = 184
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
          Left = 3
          Top = 10
          Width = 182
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
    end
    object rlbISSQN: TRLBand
      Left = 26
      Top = 801
      Width = 742
      Height = 39
      BandType = btTitle
      object rllSecISSQN: TRLLabel
        Left = 0
        Top = 2
        Width = 742
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
        Borders.Sides = sdAll
      end
      object rlpISSQNInscricao: TRLPanel
        Left = 0
        Top = 15
        Width = 208
        Height = 24
        Borders.Sides = sdAll
        object rllTitISSQNInscricao: TRLLabel
          Left = 2
          Top = 1
          Width = 204
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
          Left = 3
          Top = 10
          Width = 202
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpISSQNServicos: TRLPanel
        Left = 207
        Top = 15
        Width = 178
        Height = 24
        Borders.Sides = sdAll
        object rllTitISSQNServicos: TRLLabel
          Left = 2
          Top = 1
          Width = 174
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
          Left = 3
          Top = 10
          Width = 172
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpISSQNBase: TRLPanel
        Left = 384
        Top = 15
        Width = 178
        Height = 24
        Borders.Sides = sdAll
        object rllTitISSQNBase: TRLLabel
          Left = 2
          Top = 1
          Width = 174
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
          Left = 3
          Top = 10
          Width = 172
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpISSQNValor: TRLPanel
        Left = 561
        Top = 15
        Width = 181
        Height = 24
        Borders.Sides = sdAll
        object rllTitISSQNValor: TRLLabel
          Left = 2
          Top = 1
          Width = 177
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
          Left = 3
          Top = 10
          Width = 175
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
    end
    object rlbTransportador: TRLBand
      Left = 26
      Top = 840
      Width = 742
      Height = 85
      BandType = btTitle
      object rllSecTransportador: TRLLabel
        Left = 0
        Top = 2
        Width = 742
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
        Borders.Sides = sdAll
      end
      object rlpTransNome: TRLPanel
        Left = 0
        Top = 15
        Width = 223
        Height = 24
        Borders.Sides = sdAll
        object rllTitTransNome: TRLLabel
          Left = 2
          Top = 1
          Width = 219
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
          Left = 3
          Top = 10
          Width = 217
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpTransModFrete: TRLPanel
        Left = 222
        Top = 15
        Width = 103
        Height = 24
        Borders.Sides = sdAll
        object rllTitTransModFrete: TRLLabel
          Left = 2
          Top = 1
          Width = 99
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
          Left = 3
          Top = 10
          Width = 97
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpTransANTT: TRLPanel
        Left = 324
        Top = 15
        Width = 104
        Height = 24
        Borders.Sides = sdAll
        object rllTitTransANTT: TRLLabel
          Left = 2
          Top = 1
          Width = 100
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
          Left = 3
          Top = 10
          Width = 98
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpTransPlaca: TRLPanel
        Left = 427
        Top = 15
        Width = 103
        Height = 24
        Borders.Sides = sdAll
        object rllTitTransPlaca: TRLLabel
          Left = 2
          Top = 1
          Width = 99
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
          Left = 3
          Top = 10
          Width = 97
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpTransUFPlaca: TRLPanel
        Left = 529
        Top = 15
        Width = 61
        Height = 24
        Borders.Sides = sdAll
        object rllTitTransUFPlaca: TRLLabel
          Left = 2
          Top = 1
          Width = 57
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
          Left = 3
          Top = 10
          Width = 55
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpTransCNPJ: TRLPanel
        Left = 589
        Top = 15
        Width = 153
        Height = 24
        Borders.Sides = sdAll
        object rllTitTransCNPJ: TRLLabel
          Left = 2
          Top = 1
          Width = 149
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
          Left = 3
          Top = 10
          Width = 147
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpTransEndereco: TRLPanel
        Left = 0
        Top = 38
        Width = 297
        Height = 24
        Borders.Sides = sdAll
        object rllTitTransEndereco: TRLLabel
          Left = 2
          Top = 1
          Width = 293
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
          Left = 3
          Top = 10
          Width = 291
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpTransMunicipio: TRLPanel
        Left = 296
        Top = 38
        Width = 179
        Height = 24
        Borders.Sides = sdAll
        object rllTitTransMunicipio: TRLLabel
          Left = 2
          Top = 1
          Width = 175
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
          Left = 3
          Top = 10
          Width = 173
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpTransUF: TRLPanel
        Left = 474
        Top = 38
        Width = 58
        Height = 24
        Borders.Sides = sdAll
        object rllTitTransUF: TRLLabel
          Left = 2
          Top = 1
          Width = 54
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
          Left = 3
          Top = 10
          Width = 52
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpTransIE: TRLPanel
        Left = 531
        Top = 38
        Width = 211
        Height = 24
        Borders.Sides = sdAll
        object rllTitTransIE: TRLLabel
          Left = 2
          Top = 1
          Width = 207
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
          Left = 3
          Top = 10
          Width = 205
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpVolQtde: TRLPanel
        Left = 0
        Top = 61
        Width = 119
        Height = 24
        Borders.Sides = sdAll
        object rllTitVolQtde: TRLLabel
          Left = 2
          Top = 1
          Width = 115
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
          Left = 3
          Top = 10
          Width = 113
          Height = 13
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpVolEspecie: TRLPanel
        Left = 118
        Top = 61
        Width = 148
        Height = 24
        Borders.Sides = sdAll
        object rllTitVolEspecie: TRLLabel
          Left = 2
          Top = 1
          Width = 144
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
          Left = 3
          Top = 10
          Width = 142
          Height = 13
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpVolMarca: TRLPanel
        Left = 265
        Top = 61
        Width = 119
        Height = 24
        Borders.Sides = sdAll
        object rllTitVolMarca: TRLLabel
          Left = 2
          Top = 1
          Width = 115
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
          Left = 3
          Top = 10
          Width = 113
          Height = 13
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpVolNumeracao: TRLPanel
        Left = 383
        Top = 61
        Width = 133
        Height = 24
        Borders.Sides = sdAll
        object rllTitVolNumeracao: TRLLabel
          Left = 2
          Top = 1
          Width = 129
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
          Left = 3
          Top = 10
          Width = 127
          Height = 13
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpVolPesoBruto: TRLPanel
        Left = 515
        Top = 61
        Width = 111
        Height = 24
        Borders.Sides = sdAll
        object rllTitVolPesoBruto: TRLLabel
          Left = 2
          Top = 1
          Width = 107
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
          Left = 3
          Top = 10
          Width = 105
          Height = 13
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlpVolPesoLiquido: TRLPanel
        Left = 625
        Top = 61
        Width = 117
        Height = 24
        Borders.Sides = sdAll
        object rllTitVolPesoLiquido: TRLLabel
          Left = 2
          Top = 1
          Width = 113
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
          Left = 3
          Top = 10
          Width = 111
          Height = 13
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -10
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
    end
    object rlbCanceladaDenegada: TRLBand
      Left = 26
      Top = 925
      Width = 742
      Height = 24
      BandType = btColumnHeader
      object rllCanceladaDenegada: TRLLabel
        Left = 0
        Top = 3
        Width = 742
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
      Top = 949
      Width = 742
      Height = 37
      BandType = btColumnHeader
      object rllAvisoContingencia: TRLLabel
        Left = 0
        Top = 3
        Width = 742
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
        Width = 742
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
      Top = 986
      Width = 742
      Height = 37
      BandType = btColumnHeader
      object rllSecItens: TRLLabel
        Left = 0
        Top = 2
        Width = 742
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
        Borders.Sides = sdAll
      end
      object rlpCabDescricao: TRLPanel
        Left = 0
        Top = 15
        Width = 150
        Height = 22
        Borders.Sides = sdAll
        object rlmCabDescricao: TRLMemo
          Left = 2
          Top = 6
          Width = 146
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
        Left = 149
        Top = 15
        Width = 47
        Height = 22
        Borders.Sides = sdAll
        object rlmCabCSTCFOP: TRLMemo
          Left = 2
          Top = 2
          Width = 43
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
        Left = 195
        Top = 15
        Width = 57
        Height = 22
        Borders.Sides = sdAll
        object rlmCabQuantidade: TRLMemo
          Left = 2
          Top = 6
          Width = 53
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
        Left = 251
        Top = 15
        Width = 64
        Height = 22
        Borders.Sides = sdAll
        object rlmCabValorUnitario: TRLMemo
          Left = 2
          Top = 6
          Width = 60
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
        Left = 314
        Top = 15
        Width = 65
        Height = 22
        Borders.Sides = sdAll
        object rlmCabValorTotal: TRLMemo
          Left = 2
          Top = 6
          Width = 61
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
        Left = 378
        Top = 15
        Width = 95
        Height = 22
        Borders.Sides = sdAll
        object rlmCabBases: TRLMemo
          Left = 2
          Top = 6
          Width = 91
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
        Left = 472
        Top = 15
        Width = 122
        Height = 22
        Borders.Sides = sdAll
        object rlmCabAliquotas: TRLMemo
          Left = 2
          Top = 6
          Width = 118
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
        Left = 593
        Top = 15
        Width = 149
        Height = 22
        Borders.Sides = sdAll
        object rlmCabValores: TRLMemo
          Left = 2
          Top = 6
          Width = 145
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
      Top = 1023
      Width = 742
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
        Width = 742
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
          Left = 741
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
          Width = 742
          Height = 1
          Align = faBottomOnly
          DrawKind = dkLine
          HoldStyle = hsRelatively
        end
        object rliItemColuna1: TRLDraw
          Left = 149
          Top = 0
          Width = 1
          Height = 12
          Align = faHeight
          Angle = 90.000000000000000000
          DrawKind = dkLine
          HoldStyle = hsRelatively
        end
        object rliItemColuna2: TRLDraw
          Left = 195
          Top = 0
          Width = 1
          Height = 12
          Align = faHeight
          Angle = 90.000000000000000000
          DrawKind = dkLine
          HoldStyle = hsRelatively
        end
        object rliItemColuna3: TRLDraw
          Left = 251
          Top = 0
          Width = 1
          Height = 12
          Align = faHeight
          Angle = 90.000000000000000000
          DrawKind = dkLine
          HoldStyle = hsRelatively
        end
        object rliItemColuna4: TRLDraw
          Left = 314
          Top = 0
          Width = 1
          Height = 12
          Align = faHeight
          Angle = 90.000000000000000000
          DrawKind = dkLine
          HoldStyle = hsRelatively
        end
        object rliItemColuna5: TRLDraw
          Left = 378
          Top = 0
          Width = 1
          Height = 12
          Align = faHeight
          Angle = 90.000000000000000000
          DrawKind = dkLine
          HoldStyle = hsRelatively
        end
        object rliItemColuna6: TRLDraw
          Left = 472
          Top = 0
          Width = 1
          Height = 12
          Align = faHeight
          Angle = 90.000000000000000000
          DrawKind = dkLine
          HoldStyle = hsRelatively
        end
        object rliItemColuna7: TRLDraw
          Left = 593
          Top = 0
          Width = 1
          Height = 12
          Align = faHeight
          Angle = 90.000000000000000000
          DrawKind = dkLine
          HoldStyle = hsRelatively
        end
        object rlmXProd: TRLMemo
          Left = 2
          Top = 1
          Width = 146
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
          Left = 2
          Top = 10
          Width = 146
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
          Left = 2
          Top = 28
          Width = 146
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
          Left = 151
          Top = 1
          Width = 43
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
          Left = 151
          Top = 10
          Width = 43
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
          Left = 197
          Top = 1
          Width = 53
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
          Left = 253
          Top = 1
          Width = 60
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
          Left = 316
          Top = 1
          Width = 61
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
          Left = 380
          Top = 1
          Width = 91
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
          Left = 440
          Top = 1
          Width = 38
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
          Left = 380
          Top = 10
          Width = 91
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
          Left = 440
          Top = 10
          Width = 38
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
          Left = 380
          Top = 19
          Width = 91
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
          Left = 440
          Top = 19
          Width = 38
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
          Left = 380
          Top = 28
          Width = 91
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
          Left = 440
          Top = 28
          Width = 38
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
          Left = 474
          Top = 1
          Width = 56
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
          Left = 500
          Top = 1
          Width = 30
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
          Left = 536
          Top = 1
          Width = 56
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
          Left = 562
          Top = 1
          Width = 30
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
          Left = 530
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
          Left = 474
          Top = 10
          Width = 56
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
          Left = 500
          Top = 10
          Width = 30
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
          Left = 536
          Top = 10
          Width = 56
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
          Left = 562
          Top = 10
          Width = 30
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
          Left = 530
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
          Left = 474
          Top = 19
          Width = 56
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
          Left = 500
          Top = 19
          Width = 30
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
          Left = 536
          Top = 19
          Width = 56
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
          Left = 562
          Top = 19
          Width = 30
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
          Left = 530
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
          Left = 595
          Top = 1
          Width = 69
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
          Left = 634
          Top = 1
          Width = 30
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
          Left = 670
          Top = 1
          Width = 69
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
          Left = 709
          Top = 1
          Width = 30
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
          Left = 664
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
          Left = 595
          Top = 10
          Width = 69
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
          Left = 634
          Top = 10
          Width = 30
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
          Left = 670
          Top = 10
          Width = 69
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
          Left = 709
          Top = 10
          Width = 30
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
          Left = 664
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
          Left = 595
          Top = 19
          Width = 69
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
          Left = 634
          Top = 19
          Width = 30
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
          Left = 670
          Top = 19
          Width = 69
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
          Left = 709
          Top = 19
          Width = 30
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
          Left = 664
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
      Top = 1063
      Width = 742
      Height = 102
      BandType = btFooter
      AutoExpand = False
      BeforePrint = rlbDadosAdicionaisBeforePrint
      object rllSecDadosAdicionais: TRLLabel
        Left = 0
        Top = 2
        Width = 611
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
        Width = 333
        Height = 86
        Borders.Sides = sdAll
        object rllTitInfCompl: TRLLabel
          Left = 2
          Top = 1
          Width = 329
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
          Left = 3
          Top = 10
          Width = 327
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
        Left = 332
        Top = 15
        Width = 279
        Height = 86
        Borders.Sides = sdAll
        object rllTitFisco: TRLLabel
          Left = 2
          Top = 1
          Width = 275
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
          Width = 273
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
        Left = 616
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
        Left = 3
        Top = 25
        Width = 327
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
        Width = 742
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
      Top = 1165
      Width = 742
      Height = 12
      BandType = btFooter
      object rllUsuario: TRLLabel
        Left = 0
        Top = 1
        Width = 370
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
        Left = 372
        Top = 1
        Width = 370
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
      Top = 1177
      Width = 742
      Height = 36
      BandType = btSummary
      BeforePrint = rlbContinuacaoBeforePrint
      object rllSecContinuacao: TRLLabel
        Left = 0
        Top = 2
        Width = 742
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
        Width = 742
        Height = 20
        Borders.Sides = sdAll
        object rlmContinuacaoDadosAdicionais: TRLMemo
          Left = 3
          Top = 2
          Width = 736
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
