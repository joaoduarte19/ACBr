inherited frlXDANFSeRLPadraoNacional: TfrlXDANFSeRLPadraoNacional
  Left = 1035
  Top = 279
  Caption = 'frlXDANFSeRLPadraoNacional'
  ClientHeight = 988
  TextHeight = 13
  inherited RLNFSe: TRLReport
    Left = 16
    Top = 52
    Margins.LeftMargin = 6.000000000000000000
    Margins.TopMargin = 5.000000000000000000
    Margins.RightMargin = 5.099999999999999000
    Margins.BottomMargin = 5.000000000000000000
    BeforePrint = RLNFSeBeforePrint
    object rlbBanda02_Ide_NFSe: TRLBand
      Left = 28
      Top = 93
      Width = 940
      Height = 120
      BandType = btHeader
      Borders.Sides = sdCustom
      Borders.DrawLeft = True
      Borders.DrawTop = True
      Borders.DrawRight = True
      Borders.DrawBottom = True
      BeforePrint = rlbBanda02_Ide_NFSeBeforePrint
      object rllNumNF0: TRLLabel
        Left = 4
        Top = 45
        Width = 140
        Height = 18
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel13: TRLLabel
        Left = 4
        Top = 35
        Width = 89
        Height = 11
        Caption = 'N'#218'MERO DA NFS-E'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel12: TRLLabel
        Left = 328
        Top = 35
        Width = 168
        Height = 11
        Caption = 'DATA E HORA DA EMISS'#195'O DA NFS-E'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllEmissaoNFSe: TRLLabel
        Left = 328
        Top = 45
        Width = 140
        Height = 18
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel7: TRLLabel
        Left = 195
        Top = 35
        Width = 115
        Height = 11
        Caption = 'COMPET'#202'NCIA DA NFS-E'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllCompetencia: TRLLabel
        Left = 195
        Top = 45
        Width = 72
        Height = 13
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel18: TRLLabel
        Left = 4
        Top = 62
        Width = 80
        Height = 11
        Caption = 'N'#218'MERO DA DPS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllNumeroDPS: TRLLabel
        Left = 5
        Top = 74
        Width = 118
        Height = 15
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object rllCodigoChave: TRLLabel
        Left = 4
        Top = 4
        Width = 136
        Height = 11
        Caption = 'CHAVE DE ACESSO DA NFS-E'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllChaveAcesso: TRLLabel
        Left = 4
        Top = 17
        Width = 506
        Height = 17
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel16: TRLLabel
        Left = 195
        Top = 62
        Width = 68
        Height = 11
        Caption = 'S'#201'RIE DA DPS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllSerieDPS: TRLLabel
        Left = 196
        Top = 74
        Width = 118
        Height = 15
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel22: TRLLabel
        Left = 328
        Top = 62
        Width = 159
        Height = 11
        Caption = 'DATA E HORA DA EMISS'#195'O DA DPS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllEmissaoDPS: TRLLabel
        Left = 329
        Top = 74
        Width = 140
        Height = 18
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object RLMemo1: TRLMemo
        Left = 540
        Top = 88
        Width = 209
        Height = 28
        Alignment = taCenter
        AutoSize = False
        Behavior = [beSiteExpander]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        Lines.Strings = (
          'A autenticidade desta NFS-e pode ser verificada'
          'pela leitura deste c'#243'digo QR ou pela consulta da'
          'chave de acesso no portal nacional da NFS-e')
        ParentFont = False
        Transparent = False
      end
      object RLLabel23: TRLLabel
        Left = 4
        Top = 92
        Width = 94
        Height = 11
        Caption = 'EMITENTE DA NFS-E'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllEmitente: TRLLabel
        Left = 5
        Top = 104
        Width = 51
        Height = 13
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel15: TRLLabel
        Left = 195
        Top = 92
        Width = 94
        Height = 11
        Caption = 'SITUA'#199#195'O DA NFS-E'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel19: TRLLabel
        Left = 329
        Top = 92
        Width = 58
        Height = 11
        Caption = 'FINALIDADE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllSituacao: TRLLabel
        Left = 196
        Top = 104
        Width = 52
        Height = 13
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object rllFinalidade: TRLLabel
        Left = 329
        Top = 104
        Width = 58
        Height = 13
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object imgQRCode: TRLImage
        Left = 607
        Top = 5
        Width = 80
        Height = 80
        Center = True
        Scaled = True
      end
    end
    object rlbBanda03_Emitente: TRLBand
      Left = 28
      Top = 213
      Width = 940
      Height = 110
      BandType = btTitle
      Borders.Sides = sdCustom
      Borders.DrawLeft = True
      Borders.DrawTop = False
      Borders.DrawRight = True
      Borders.DrawBottom = True
      BeforePrint = rlbBanda03_EmitenteBeforePrint
      object RLLabel30: TRLLabel
        Left = 408
        Top = 0
        Width = 92
        Height = 11
        Caption = 'Inscri'#231#227'o Municipal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel32: TRLLabel
        Left = 264
        Top = 2
        Width = 86
        Height = 14
        Caption = 'CNPJ / CPF / NIF'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllEmitenteInscMunicipal: TRLLabel
        Left = 408
        Top = 15
        Width = 104
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object rllEmitenteCNPJ: TRLLabel
        Left = 264
        Top = 15
        Width = 127
        Height = 13
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel1: TRLLabel
        Left = 4
        Top = 31
        Width = 121
        Height = 11
        Caption = 'Nome / Nome Empresarial'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllEmitenteNome: TRLLabel
        Left = 4
        Top = 43
        Width = 71
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel2: TRLLabel
        Left = 607
        Top = 2
        Width = 41
        Height = 11
        Caption = 'Telefone'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllEmitenteTelefone: TRLLabel
        Left = 607
        Top = 15
        Width = 81
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel24: TRLLabel
        Left = 4
        Top = 58
        Width = 46
        Height = 11
        Caption = 'Endere'#231'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllEmitenteEndereco: TRLLabel
        Left = 4
        Top = 70
        Width = 85
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel29: TRLLabel
        Left = 408
        Top = 58
        Width = 31
        Height = 11
        Caption = 'E-mail'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllEmitenteEmail: TRLLabel
        Left = 408
        Top = 70
        Width = 69
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel31: TRLLabel
        Left = 408
        Top = 31
        Width = 96
        Height = 11
        Caption = 'Munic'#237'pio / Sigla UF'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllEmitenteMunicipio: TRLLabel
        Left = 408
        Top = 43
        Width = 86
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel55: TRLLabel
        Left = 607
        Top = 31
        Width = 90
        Height = 11
        Caption = 'C'#243'digo IBGE / CEP'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllEmitenteCEP: TRLLabel
        Left = 607
        Top = 43
        Width = 65
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel60: TRLLabel
        Left = 4
        Top = 83
        Width = 195
        Height = 11
        Caption = 'Simples Nacional na Data de Compet'#234'ncia'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllEmitenteSimplesNacional: TRLLabel
        Left = 3
        Top = 95
        Width = 115
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel69: TRLLabel
        Left = 408
        Top = 83
        Width = 182
        Height = 11
        Caption = 'Regime de Apura'#231#227'o Tribut'#225'ria pelo SN'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllEmitenteRegimeApuracao: TRLLabel
        Left = 408
        Top = 95
        Width = 118
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel21: TRLLabel
        Left = 4
        Top = 2
        Width = 146
        Height = 14
        Caption = 'PRESTADOR / FORNECEDOR'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
    end
    object rlbBanda04_Tomador: TRLBand
      Left = 28
      Top = 323
      Width = 940
      Height = 84
      BandType = btTitle
      Borders.Sides = sdCustom
      Borders.DrawLeft = True
      Borders.DrawTop = False
      Borders.DrawRight = True
      Borders.DrawBottom = True
      BeforePrint = rlbBanda04_TomadorBeforePrint
      object rllTomaCNPJ: TRLLabel
        Left = 264
        Top = 16
        Width = 57
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object rllTomaInscMunicipal: TRLLabel
        Left = 408
        Top = 16
        Width = 90
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object rllTomaNome: TRLLabel
        Left = 4
        Top = 42
        Width = 57
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object rllTomaEndereco: TRLLabel
        Left = 5
        Top = 68
        Width = 71
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object rllTomaMunicipio: TRLLabel
        Left = 408
        Top = 42
        Width = 72
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object rllTomaEmail: TRLLabel
        Left = 408
        Top = 68
        Width = 55
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object rllTomaTelefone: TRLLabel
        Left = 607
        Top = 16
        Width = 67
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel4: TRLLabel
        Left = 4
        Top = 2
        Width = 133
        Height = 14
        Caption = 'TOMADOR / ADQUIRENTE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel70: TRLLabel
        Left = 4
        Top = 30
        Width = 121
        Height = 11
        Caption = 'Nome / Nome Empresarial'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel71: TRLLabel
        Left = 4
        Top = 56
        Width = 46
        Height = 11
        Caption = 'Endere'#231'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel72: TRLLabel
        Left = 264
        Top = 2
        Width = 86
        Height = 14
        Caption = 'CNPJ / CPF / NIF'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel73: TRLLabel
        Left = 408
        Top = 2
        Width = 92
        Height = 11
        Caption = 'Inscri'#231#227'o Municipal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel75: TRLLabel
        Left = 408
        Top = 56
        Width = 31
        Height = 11
        Caption = 'E-mail'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel76: TRLLabel
        Left = 408
        Top = 30
        Width = 96
        Height = 11
        Caption = 'Munic'#237'pio / Sigla UF'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel77: TRLLabel
        Left = 607
        Top = 2
        Width = 41
        Height = 11
        Caption = 'Telefone'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel78: TRLLabel
        Left = 607
        Top = 30
        Width = 90
        Height = 11
        Caption = 'C'#243'digo IBGE / CEP'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllTomaCEP: TRLLabel
        Left = 608
        Top = 42
        Width = 51
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
      end
    end
    object rlbBanda07_ServicoPrestado: TRLBand
      Left = 28
      Top = 577
      Width = 940
      Height = 84
      BandType = btTitle
      Borders.Sides = sdCustom
      Borders.DrawLeft = True
      Borders.DrawTop = False
      Borders.DrawRight = True
      Borders.DrawBottom = True
      BeforePrint = rlbBanda07_ServicoPrestadoBeforePrint
      object RLLabel14: TRLLabel
        Left = 4
        Top = 2
        Width = 120
        Height = 15
        Caption = 'SERVI'#199'O PRESTADO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel61: TRLLabel
        Left = 170
        Top = 2
        Width = 197
        Height = 11
        Caption = 'C'#243'digo de Tributa'#231#227'o Nacional / Munic'#237'pal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel92: TRLLabel
        Left = 408
        Top = 3
        Width = 59
        Height = 11
        Caption = 'C'#243'digo NBS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllLocalPrestacao: TRLLabel
        Left = 540
        Top = 15
        Width = 74
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel94: TRLLabel
        Left = 539
        Top = 2
        Width = 165
        Height = 11
        Caption = 'Local da Presta'#231#227'o / SIgla UF / Pa'#237's'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllCodigoNBS: TRLLabel
        Left = 409
        Top = 15
        Width = 58
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel96: TRLLabel
        Left = 4
        Top = 56
        Width = 100
        Height = 11
        Caption = 'Descri'#231#227'o do Servi'#231'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rlmDescServico: TRLMemo
        Left = 4
        Top = 69
        Width = 733
        Height = 12
        Behavior = [beSiteExpander]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        Lines.Strings = (
          'rlmDescServico')
        ParentFont = False
        Transparent = False
      end
      object rlmCodTribNac: TRLMemo
        Left = 4
        Top = 29
        Width = 733
        Height = 26
        AutoSize = False
        Behavior = [beSiteExpander]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        Lines.Strings = (
          'rlmCodTribNac')
        ParentFont = False
        Transparent = False
      end
    end
    object rlbBanda14_InformacoesComplementares: TRLBand
      Left = 28
      Top = 1050
      Width = 940
      Height = 59
      BandType = btSummary
      Borders.Sides = sdCustom
      Borders.DrawLeft = True
      Borders.DrawTop = False
      Borders.DrawRight = True
      Borders.DrawBottom = True
      BeforePrint = rlbBanda14_InformacoesComplementaresBeforePrint
      object rlmDadosAdicionais: TRLMemo
        Left = 5
        Top = 21
        Width = 743
        Height = 12
        Behavior = [beSiteExpander]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        Lines.Strings = (
          'Dados Adicionais....')
        ParentFont = False
      end
      object RLLabel6: TRLLabel
        Left = 4
        Top = 2
        Width = 230
        Height = 16
        Caption = 'INFORMA'#199#213'ES COMPLEMENTARES'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllMsgTeste: TRLLabel
        Left = 24
        Top = 24
        Width = 724
        Height = 31
        Alignment = taCenter
        Caption = 'AMBIENTE DE HOMOLOGA'#199#195'O - SEM VALOR FISCAL'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -27
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object rlbBanda08_ItensDetalhado: TRLBand
      Left = 28
      Top = 661
      Width = 940
      Height = 20
      BandType = btColumnHeader
      Borders.Sides = sdCustom
      Borders.DrawLeft = True
      Borders.DrawTop = False
      Borders.DrawRight = True
      Borders.DrawBottom = True
      object RLLabel65: TRLLabel
        Left = 460
        Top = 1
        Width = 36
        Height = 14
        Alignment = taRightJustify
        Caption = 'Qtde'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel66: TRLLabel
        Left = 4
        Top = 1
        Width = 48
        Height = 14
        Caption = 'Descri'#231#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel67: TRLLabel
        Left = 670
        Top = 1
        Width = 76
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor ISS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel68: TRLLabel
        Left = 384
        Top = 1
        Width = 70
        Height = 14
        Caption = 'Valor Unit'#225'rio'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel5: TRLLabel
        Left = 504
        Top = 1
        Width = 85
        Height = 14
        Caption = 'Valor do Servi'#231'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel9: TRLLabel
        Left = 590
        Top = 1
        Width = 76
        Height = 14
        Caption = 'Base C'#225'lc. (%)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
    end
    object rlbBanda09_SubItens: TRLSubDetail
      Left = 28
      Top = 681
      Width = 940
      Height = 19
      Borders.Sides = sdCustom
      Borders.DrawLeft = True
      Borders.DrawTop = False
      Borders.DrawRight = True
      Borders.DrawBottom = True
      OnDataRecord = rlbBanda09_SubItensDataRecord
      object rlbBanda08_ItensServico: TRLBand
        Left = 1
        Top = 0
        Width = 938
        Height = 16
        BeforePrint = rlbBanda08_ItensServicoBeforePrint
        object txtServicoQtde: TRLLabel
          Left = 460
          Top = 1
          Width = 36
          Height = 14
          Alignment = taCenter
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = False
        end
        object rlmServicoDescricao: TRLMemo
          Left = 4
          Top = 1
          Width = 373
          Height = 14
          Behavior = [beSiteExpander]
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = False
        end
        object txtServicoUnitario: TRLLabel
          Left = 384
          Top = 1
          Width = 70
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = False
        end
        object txtServicoTotal: TRLLabel
          Left = 504
          Top = 1
          Width = 85
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = False
        end
        object txtBaseCalculo: TRLLabel
          Left = 590
          Top = 1
          Width = 76
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = False
        end
        object txtISS: TRLLabel
          Left = 670
          Top = 1
          Width = 76
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = False
        end
      end
    end
    object rlbBanda16_Sistema: TRLBand
      Left = 28
      Top = 1109
      Width = 940
      Height = 18
      BandType = btSummary
      BeforePrint = rlbBanda16_SistemaBeforePrint
      object rllDataHoraImpressao: TRLLabel
        Left = 2
        Top = 3
        Width = 76
        Height = 10
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object rllSistema: TRLLabel
        Left = 356
        Top = 2
        Width = 392
        Height = 11
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
    end
    object rlbBanda10_TributacaoMunicipal: TRLBand
      Left = 28
      Top = 700
      Width = 940
      Height = 115
      BandType = btSummary
      Borders.Sides = sdCustom
      Borders.DrawLeft = True
      Borders.DrawTop = True
      Borders.DrawRight = True
      Borders.DrawBottom = True
      BeforePrint = rlbBanda10_TributacaoMunicipalBeforePrint
      object RLLabel10: TRLLabel
        Left = 4
        Top = 2
        Width = 190
        Height = 15
        Caption = 'TRIBUTA'#199#195'O MUNICIPAL (ISSQN)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel11: TRLLabel
        Left = 204
        Top = 2
        Width = 135
        Height = 11
        Caption = 'Tipo de Tributa'#231#227'o do ISSQN'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllTribISSQN: TRLLabel
        Left = 205
        Top = 14
        Width = 54
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel17: TRLLabel
        Left = 204
        Top = 29
        Width = 135
        Height = 11
        Caption = 'Tipo de Imunidade do ISSQN'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllTipoImunidade: TRLLabel
        Left = 204
        Top = 42
        Width = 70
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel25: TRLLabel
        Left = 4
        Top = 85
        Width = 49
        Height = 11
        Caption = 'BC ISSQN'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllValorBCISSQN: TRLLabel
        Left = 4
        Top = 98
        Width = 73
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel90: TRLLabel
        Left = 365
        Top = 29
        Width = 177
        Height = 11
        Caption = 'Suspens'#227'o da Exigibilidade do ISSQN'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllSuspensao: TRLLabel
        Left = 365
        Top = 42
        Width = 56
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel93: TRLLabel
        Left = 573
        Top = 57
        Width = 127
        Height = 11
        Caption = 'Desconto Incondicionando'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllValorDescIncond: TRLLabel
        Left = 573
        Top = 70
        Width = 81
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel97: TRLLabel
        Left = 204
        Top = 85
        Width = 81
        Height = 11
        Caption = 'Al'#237'quota Aplicada'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllAliquotaAplicada: TRLLabel
        Left = 203
        Top = 98
        Width = 78
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel99: TRLLabel
        Left = 365
        Top = 2
        Width = 235
        Height = 11
        Caption = 'Munic'#237'pio / Sigla UF / Pais de Incid'#234'ncia do ISSQN'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllMunicipioIncidencia: TRLLabel
        Left = 365
        Top = 14
        Width = 90
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel101: TRLLabel
        Left = 573
        Top = 29
        Width = 139
        Height = 11
        Caption = 'N'#250'm. do Processo Suspens'#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllNumeroProcesso: TRLLabel
        Left = 573
        Top = 42
        Width = 82
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel103: TRLLabel
        Left = 365
        Top = 57
        Width = 119
        Height = 11
        Caption = 'Total Dedu'#231#245'es/Redu'#231#245'es'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllValorTotalDedRed: TRLLabel
        Left = 365
        Top = 70
        Width = 85
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel105: TRLLabel
        Left = 365
        Top = 85
        Width = 92
        Height = 11
        Caption = 'Reten'#231#227'o do ISSQN'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllRetencaoISSQN: TRLLabel
        Left = 365
        Top = 98
        Width = 79
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel111: TRLLabel
        Left = 204
        Top = 57
        Width = 70
        Height = 11
        Caption = 'C'#225'lculo do BM'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllCalculoBM: TRLLabel
        Left = 204
        Top = 70
        Width = 54
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel113: TRLLabel
        Left = 573
        Top = 85
        Width = 73
        Height = 11
        Caption = 'ISSQN Apurado'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllValorISSQNApurado: TRLLabel
        Left = 573
        Top = 98
        Width = 94
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel109: TRLLabel
        Left = 4
        Top = 57
        Width = 93
        Height = 11
        Caption = 'Beneficio Municipal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllBeneficioMunic: TRLLabel
        Left = 4
        Top = 70
        Width = 73
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel107: TRLLabel
        Left = 4
        Top = 29
        Width = 143
        Height = 11
        Caption = 'Regime Especial de Tributa'#231#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllRegimeEspecial: TRLLabel
        Left = 4
        Top = 42
        Width = 77
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
    end
    object rlbBanda01_Logos: TRLBand
      Left = 28
      Top = 24
      Width = 940
      Height = 69
      AutoSize = True
      BandType = btHeader
      Borders.Sides = sdCustom
      Borders.DrawLeft = True
      Borders.DrawTop = True
      Borders.DrawRight = True
      Borders.DrawBottom = True
      BeforePrint = rlbBanda01_LogosBeforePrint
      object RLLabel74: TRLLabel
        Left = 327
        Top = 3
        Width = 74
        Height = 15
        Alignment = taCenter
        Caption = 'DANFSe v2.0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel8: TRLLabel
        Left = 285
        Top = 18
        Width = 168
        Height = 15
        Alignment = taCenter
        Caption = 'Documento Auxiliar da NFS-e'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rliLogoNFSe: TRLImage
        Left = 2
        Top = 2
        Width = 228
        Height = 46
        Center = True
        Picture.Data = {
          0A544A504547496D616765C00F0000FFD8FFE000104A46494600010100000100
          010000FFDB0084000303030303030404040405050505050707060607070B0809
          0809080B110B0C0B0B0C0B110F120F0E0F120F1B151313151B1F1A191A1F2622
          2226302D303E3E54010303030303030404040405050505050707060607070B08
          090809080B110B0C0B0B0C0B110F120F0E0F120F1B151313151B1F1A191A1F26
          222226302D303E3E54FFC2001108004700EC03012200021101031101FFC4001D
          000002020203010000000000000000000000010208060704050903FFDA000801
          0100000000F53D21924E2264924D481C1A60D098C22C09249A903834C24BCC4C
          BF44E3BE8E534EF6D1D6CE75DACF989036110601E537DAC855FB95AC6F4559D7
          376F95F7411630706A4291E51DC0AD188DC8A6B995E7AB1AD337CAF38D95F0FA
          64BABB39ECFAFEA7B3D98300F28FD55F2F714BB7AC6F461796D2FD69B87636C4
          7CA92FB63BDB9F2C93932FA125E7A7A15A42A5DADC0EDA681AC9DE661C2CD36C
          755C65C8E5707A4C8FA5EEBE5916C30481B0880D892F972008830040493880DA
          1030710670BFFFC4001B01010001050100000000000000000000000001020304
          050607FFDA000A020210031000000000000000E53CD2AEEF77C8DDD9D38195DA
          CDD0000C1E0F97C0EA32B23A4B5A6EB76BADDD61DD22654A990B7ADA716ABF56
          659D1EEF758B7ECD42509853200000007FFFC4002D1000020202000601020505
          0100000000000304020501060007111213143510151621222340202431325053
          FFDA0008010100010C01FF0093D3F898E2F6E6D897561D5E6718D67617E67F51
          86CD3E36E8EC15368C17DD7BD54EC2D989871EFB798F329C693A45FD73103955
          9D85E9CA0A9AC4F2F5775FFC2E785EE9DD734A40AE40997BCFB06CADE4789B0E
          14B57B4507EFE44DAF8D61F62CE85068F9EE2FF0B1C5AF4FC40E75C75C5D571E
          82E9857AE712AE7216298CF8E9C5963A5C318C71CD3F84538E557CC58FD399A3
          9E41585C633D9A3EC08D232C8DBFD0301C0D0B04092051C2311C7118E311C7F0
          B1C5BFCF3BC732A8BDD4236618FEEEAD61EBB795679FD169F34CF1CD3F84538A
          C95BE0B3FB67B9E4C937AE99F9DE15AEFBAEB4A2969094A76FA25BD766535B1E
          E06BECEC69CFE450D30CEE371D936C7EB35FA6CFA04CF28D58633E96C4FC6D39
          6DB458DC01FABB6FCEC1A75A4EF8A7EF9C95ABB1B13ACB2CBC2053AD74CB2D49
          8EE08D2A9B32BC568251F6CD439E148674837A533DE9542D879C1886186EC550
          C305F57CF52F66C6C7D8E9284587DD72481A308416ABBD3589C1FDACF00FA638
          C7D71C5BFCF3BC10702C6509C7128EC54E4D7EE0CAFE7DA63CDA77CF3FF6E69F
          C229C72ABE62C7E8FDF55D634059B3E05384A248E250CE251E63FA1F735FC3DB
          EC72F4E10EF81813A773FCAE3BBB539730BE6958EABA129AA583AF41F71B2918
          5216261C1429CDF63A7F1055C0B11C16AEAD89E3B851CF092AA28D1A20113BB0
          9D5E6BBD5C78FD5955213218A51E4992A75439D787B4C4E201A9A8090F1EC143
          1535533C0F8847BAAC097EE1571183C10F1842328C644C778F13CC3BE3DD09C0
          91C4A32C4A3FD161A5ECE7BA649043A8F8DDF589EC288E4B623EDAFA1ED73643
          1921E38F302A2C6E6A571200F31397BAE5D53583A77D5F0438DCF566EF240614
          9C3CB9D736A53398450723C5768BB03E4C798584C7B3F2C8B9F41FD70DE0B08E
          C5CE2C43D6FC36B64DA26ABB5D3D8BF657967834AD97608CE089AA7836B54B11
          B6914F163AAF52E57D2D6954563F70350B218100B8FCA38C04DCD37435592A73
          ABB0FC34BA7FE4C3A96E325E4089C791D0312AD6C5901B073D419B23C512DEB4
          DBA965A133EB56FA8362A4C37CDEAAD18AE24DC5916C58AD891CA055857361E4
          11070FE274EB8E99C7101C050C4211C463FF001CA718A5D259E9C7FFC4003E10
          00020004040205070A0603000000000001020003111204132131224114325161
          71051015234281B233405062728391A1B1C220304352B3D192A2D2FFDA000801
          01000D3F01FA79715355409ACA005620000436B2999C9208E513E633CA9827CC
          B45DADA75D0882F2EA73DF6B877C4CC605628D69202934D21455965BCC7207B8
          C7DF4382892E756EAD49ABF3D0411715068AA3F255103FA92DEA078D84C4C955
          66DABAD2BF34F493D47766EB12275D29BEAEE8618712F630DC474D3F1C74EFD8
          D1D0D3E3F32BCE56F16A11FA462427ADA56D29DBDDAC36CCA430303603E69E91
          7FF2C613499DF28FFE4C4FEAF738FF0071D34FC71D3BF6345BC7D1AFBADEFB39
          47DFC3E125675DD70F6EFF0068181CD3E5078AFF00A80789791A726531894AE2
          A7A9ECD5C823508A3DE4E90A97898D306FDA557880F7C793265931F9BAD4AF17
          D60450C49938513E5D74559A5BD681F548E2EE818533A64C9CE75ABB2A814EDA
          6FCA3D1727136CCA82B7DDB91E1AF744832B8AD740CB305470BEA22C6F5CD8B6
          B5EB3A9C20312BF8461D5CCB95C41E68042860C786D35E5B44D72111166BD405
          A9A05D4F8ED13BC918399656B6967990DE5759694737912CB2D5B96A46D18847
          64712E60B29D5BD9805370ECFE47A45FFCB0C0AB29E60EE214DF21FB50F54FBA
          264F566F12D1D3BF6347434F8FCD3D4B293D5D34D4F283B11A88CA6E936FFD6E
          EF89B80C52A78D55BF458C43338C816CF42DECE657AB18B9616619F6F26BABA0
          DCC3CB94B88280155435B435C4769DA24C932D112632B651DD4D0D4A9EF8E8F9
          1606A032BFB4A8D0815D3B2262233CE672F7DB5502AC49A88DA97E9D6BB7AF6C
          4C4746CC76750AFAB0018D141E7489D326092F9EED6D25D48BAEADA42D29186C
          3A4973756C972AA557DD58CFCE4F586DCC3ED2AD6953CE04C65CB6736716B554
          B8A8AFE30D31538286849A6BDC39C015A575A76C1D88351FC2F8E6757CD4B6D3
          32EAEF5F361C9CBAE81D4EEB5FD23352E769A94500EFA12613157B2DC174B48F
          6A2661D112AEAC49BABECD7CD2659432DF4B856BA1ED8E796743FF00131ED3CD
          20B7B9473F18C0AA8E36A675BB35DC9FF2314A679B69E3F2948C64B15C3A3B4C
          01EEADC49A0D361481961314AEAB2EDAD48982BC4A3B29031B367ACE4126C656
          AD016EBEC6D2230AA0B2540BDA6258F7373E47DD0B81C14B3C4173F2A733CD43
          F6C18CA9CBD1AD94087623D65B5A6B4B7B4421945E5821AA8AF76582FA1A0D35
          D0C1C4E21D8CD12932CBE1F2C30595A5098F473490AC24096EFA1D0A6AC6A342
          D0FE4C952B0B75A0CA7E3B9786B6EFB887C249926455066309A1ABC069445E7C
          E0E33C9D3542DAA3D51F58D4F0A41CD2712C25BACEBDEB5D4D6B4F64E913710A
          F283D95A65807497A0D7E6C3600500FA22958FFFC40023100100020202020203
          010100000000000001001121314151617181911020A1F0E1FFDA000801010001
          3F10AC40DCA9512044656A5351254A812B311892B12A54A8112566232A54A810
          226656206E53D32A53D301E9FC53D329AD3F80596E9812B311892B12A54A8112
          566232A54A81022665E398A31A036BEC00008A697DEF36EB91324A91D0713B31
          494B7AC176B33DE343808B16346AC8191ECC4D0A6021FF002E169B7A85258E13
          510A7939D5C00B9AFF003B401EE107A34018B098C84BCF317DC5F72F1CCB972E
          0FB8BEE5E798BEE5CB9707DC1F7173CCE36CF94442EC7B9307C93C9628A9FE58
          3FD2ADC603FA601800200A027F9DF8AFCD731F012B80BEE0A21AD04A1728266F
          03FE3FAE459067980C003802237CC5F2C5F738E67DCFB9F707CB1F6C7E63F33E
          E7DCFB87CC3E63BE6595CCF94FF0FBCCA01A2197EFE4BF4B30A8E65E97D31020
          232FF1A567B0FC831CD94DAB46106EF0E8215BC41BAEA3007F7F72A6AE3E658C
          7C8917AAEA0ACD1AA1A11104FB25AF0AD7BC90F857A28681A6D749BA46B8EFA4
          83CA683926A1D57553B5810BF4751179F955FA25C0840BAB81184466546B3AA2
          AB8AE6982A5A355E999CBA9BDB9C5D75A6340961C38823A2553A9331547B059E
          5451BE24A6A8140E7D0457C389F73EE52F994BE6357CCC573369FE1F78578F0B
          0F487490EE92F39760F7A3E495A02BED5059FCE9633FC6D87E095402F0ECEAE0
          FD5B58876244CED3629D95A75B9B28DFDFED2930C8016608B096C66DB5B1B495
          9CAC755BBE035769102D4A039814B94696CB12F4A135B858C99058DAC948ADA3
          490695E652057F3EE0EEF68445F5831794650041B1406B1AD3600B4C634E0A28
          44B729D1B8D18850E495C4732833048A97465081636E800E109E598969720B3D
          88B0059B20EC2EEBCC20C1864F4908CAC69847AF5CAAACCB823B6581096F31F8
          77038EF29B5543928894576F85039634DA944EFC28AC6985BA8825E9DB5017CE
          9BF353065FB7E515F57D84228F2DB3B5AA7B4A200E58C7DE13B805FB5B4D1460
          30DD9AA8E5741793F139BAD9607556A8418EC3EAAEEAA395788401B68AED10E9
          C95C3707A61E9D13BE8D5B06339B6E112E24570531AE73C18C28A2A19BB6352F
          64DC0D3023AD7013A6EE8A15C3A232356B02AB544A041A368BA8B9E4B45CA416
          EE5579A33B1626DE04081A8B540736976B74B6103C3133CCA6B4C07387F29018
          8F4CA7186535A7F15E2542E567511E988F4CA6B4FE10D60444791842D40601C0
          101F311E994DE988F4FE80F4C07A62674CE21FA11FC71FAF318CE3F423F87F42
          10739346171A9FFFC4002E110001030302020709000000000000000001020311
          00041205211331060714324041511520223033426281A1FFDA0008010201013F
          00F01AEE99ED9D36EAD8ACA0AC1C1C060A17F699AE8475A5A85FDA39A25F694D
          22FB4D612D2AE67BF87C12511DEA7415DC04E44020570CB29528289DA9B682C4
          E472A1200F94CA0381D49F38A674545A748AE7526C01DA6DC21D1F9A15B2BF62
          9D4E57204C48A4361B925520FAD3AD06C66954455A5E166DEDDB0F26CD3D9B32
          AE1E7C55E446FCCC55FAED1CBC7576C25B5007BA5201204C03C84D12D9276FE5
          6490A300C122A507CAA520CC18A544EC3DC43496CA889DE9C61B715268B492E0
          5EF229490A106BB3A2799A6B5352586D975865F4B5F4CB80CA47A48236AB9BB7
          2E9F2F2C20120084A7148036E42B88AACCD059028B8A35C45564608F5F03FFC4
          0028110002010402000504030000000000000001020300040511122106132231
          5110404281142030FFDA0008010301013F00FB0C5E5AF711971905679238AE75
          2A12486563D8D1AF19DAC189B5B6C9D8CE6482FDF71A9FC030E559689EF3C451
          DAF9AE8AE8A3609EBADD3635F076B757515CCB23F95C406F61B23BAC662E1C95
          BF9CD7928B9D9274C095A851A3863466E4CAA016F9207BFF00960ED23BE8F2D0
          3FB3BA68FC1EF46AF32D3B60E1C35CEF9D95EB18CFC230D11FA3595B7FE5F896
          383CC68F9AA0E6BEE3D35678A87182569AE9A4491421129F4F7597C3438F88DD
          DACAD19561A5E5F3F06B1B24B7D631CF2A79B23368FAB8E80EB62A059444A243
          EA15EAAD6EBBFA0FE98FC5C18E69DA267633302DC8FC6FDAAFB01637F722790C
          8AFA1CB89001D54988B7932297C5DFCC5D697638F4355776B0DEC0D0CA0946D6
          F4747AA4F0BD9061CE699D07E048D50B38E3EA22D10D0042F43AA8E358D38827
          F6775C6B8D6857115C456BEC7FFFD9}
      end
      object rlmPrefeitura: TRLMemo
        Left = 540
        Top = 4
        Width = 204
        Height = 14
        Behavior = [beSiteExpander]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object rlbHomologacao: TRLLabel
        Left = 279
        Top = 34
        Width = 184
        Height = 15
        Alignment = taCenter
        Caption = 'NFS-e emitida em Homologa'#231#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel33: TRLLabel
        Left = 540
        Top = 54
        Width = 42
        Height = 14
        Caption = 'P'#225'gina:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLSystemInfo1: TRLSystemInfo
        Left = 585
        Top = 54
        Width = 72
        Height = 14
        Alignment = taRightJustify
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Info = itPageNumber
        ParentFont = False
        Text = ''
      end
      object RLLabel62: TRLLabel
        Left = 659
        Top = 53
        Width = 7
        Height = 15
        Caption = '/'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLSystemInfo2: TRLSystemInfo
        Left = 669
        Top = 54
        Width = 50
        Height = 14
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Info = itLastPageNumber
        ParentFont = False
        Text = ''
      end
    end
    object rlbBanda06_Intermediario: TRLBand
      Left = 28
      Top = 490
      Width = 940
      Height = 87
      BandType = btTitle
      Borders.Sides = sdCustom
      Borders.DrawLeft = True
      Borders.DrawTop = False
      Borders.DrawRight = True
      Borders.DrawBottom = True
      BeforePrint = rlbBanda06_IntermediarioBeforePrint
      object rllInterCNPJ: TRLLabel
        Left = 264
        Top = 17
        Width = 54
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object rllInterInscMunicipal: TRLLabel
        Left = 408
        Top = 18
        Width = 85
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object rllInterNome: TRLLabel
        Left = 4
        Top = 44
        Width = 54
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object rllInterEndereco: TRLLabel
        Left = 4
        Top = 71
        Width = 68
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object rllInterMunicipio: TRLLabel
        Left = 408
        Top = 44
        Width = 67
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllInterEmail: TRLLabel
        Left = 409
        Top = 71
        Width = 52
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object rllInterTelefone: TRLLabel
        Left = 607
        Top = 18
        Width = 65
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel81: TRLLabel
        Left = 4
        Top = 2
        Width = 166
        Height = 14
        Caption = 'INTERMEDI'#193'RIO DA OPERA'#199#195'O'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel82: TRLLabel
        Left = 4
        Top = 31
        Width = 121
        Height = 11
        Caption = 'Nome / Nome Empresarial'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel83: TRLLabel
        Left = 4
        Top = 58
        Width = 46
        Height = 11
        Caption = 'Endere'#231'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel84: TRLLabel
        Left = 264
        Top = 2
        Width = 86
        Height = 14
        Caption = 'CNPJ / CPF / NIF'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel85: TRLLabel
        Left = 408
        Top = 6
        Width = 92
        Height = 11
        Caption = 'Inscri'#231#227'o Municipal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel86: TRLLabel
        Left = 408
        Top = 58
        Width = 31
        Height = 11
        Caption = 'E-mail'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel87: TRLLabel
        Left = 408
        Top = 31
        Width = 96
        Height = 11
        Caption = 'Munic'#237'pio / Sigla UF'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel88: TRLLabel
        Left = 607
        Top = 6
        Width = 41
        Height = 11
        Caption = 'Telefone'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel89: TRLLabel
        Left = 607
        Top = 32
        Width = 90
        Height = 11
        Caption = 'C'#243'digo IBGE / CEP'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllInterCEP: TRLLabel
        Left = 607
        Top = 44
        Width = 48
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllIntermediarioNaoIdentificado: TRLLabel
        Left = 279
        Top = 0
        Width = 382
        Height = 16
        Align = faCenterTop
        Alignment = taCenter
        Caption = 'INTERMEDI'#193'RIO DO SERVI'#199'O N'#195'O IDENTIFICADO NA NFS-e'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
    end
    object rlbBanda11_TributacaoFederal: TRLBand
      Left = 28
      Top = 815
      Width = 940
      Height = 60
      BandType = btSummary
      Borders.Sides = sdCustom
      Borders.DrawLeft = True
      Borders.DrawTop = True
      Borders.DrawRight = True
      Borders.DrawBottom = True
      BeforePrint = rlbBanda11_TributacaoFederalBeforePrint
      object RLLabel115: TRLLabel
        Left = 4
        Top = 2
        Width = 215
        Height = 15
        Caption = 'TRIBUTA'#199#195'O FEDERAL (EXCETO CBS)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel116: TRLLabel
        Left = 238
        Top = 5
        Width = 26
        Height = 11
        Caption = 'IRRF'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllValorIRRF: TRLLabel
        Left = 239
        Top = 18
        Width = 54
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel118: TRLLabel
        Left = 4
        Top = 31
        Width = 138
        Height = 11
        Caption = 'PIS - D'#233'bito Apura'#231#227'o Pr'#243'pria'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllValorPIS: TRLLabel
        Left = 3
        Top = 42
        Width = 46
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel124: TRLLabel
        Left = 377
        Top = 5
        Width = 163
        Height = 11
        Caption = 'Contribui'#231#227'o Previdenci'#225'ria-Retida'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllValorCP: TRLLabel
        Left = 376
        Top = 18
        Width = 44
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel126: TRLLabel
        Left = 238
        Top = 31
        Width = 153
        Height = 11
        Caption = 'COFINS-D'#233'bito Apura'#231#227'o Pr'#243'pria'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllValorCOFINS: TRLLabel
        Left = 237
        Top = 44
        Width = 67
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel132: TRLLabel
        Left = 574
        Top = 3
        Width = 140
        Height = 11
        Caption = 'Contribui'#231#245'es Sociais-Retidas'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllValorCSLL: TRLLabel
        Left = 574
        Top = 16
        Width = 54
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel134: TRLLabel
        Left = 426
        Top = 31
        Width = 162
        Height = 11
        Caption = 'Descri'#231#227'o Contrib. Sociais-Retidas'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllDescCSLL: TRLLabel
        Left = 426
        Top = 44
        Width = 55
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
    end
    object rlbBanda13_ValorTotaNFSe: TRLBand
      Left = 28
      Top = 987
      Width = 940
      Height = 63
      BandType = btSummary
      Borders.Sides = sdCustom
      Borders.DrawLeft = True
      Borders.DrawTop = True
      Borders.DrawRight = True
      Borders.DrawBottom = True
      BeforePrint = rlbBanda13_ValorTotaNFSeBeforePrint
      object RLLabel3: TRLLabel
        Left = 4
        Top = 2
        Width = 139
        Height = 15
        Caption = 'VALOR TOTAL DA NFS-E'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel26: TRLLabel
        Left = 227
        Top = 2
        Width = 130
        Height = 11
        Caption = 'Valor da Opera'#231#227'o / Servi'#231'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllValorTotalServico: TRLLabel
        Left = 227
        Top = 16
        Width = 83
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel35: TRLLabel
        Left = 557
        Top = 3
        Width = 114
        Height = 11
        Caption = 'Desconto Condicionado'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllValorTotalDescCond: TRLLabel
        Left = 557
        Top = 16
        Width = 95
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel37: TRLLabel
        Left = 392
        Top = 31
        Width = 82
        Height = 11
        Caption = 'Total do IBS/CBS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllValorTotalIBSCBS: TRLLabel
        Left = 392
        Top = 46
        Width = 85
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel39: TRLLabel
        Left = 392
        Top = 3
        Width = 121
        Height = 11
        Caption = 'Desconto Incondicionado'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllValorTotalDescIncond: TRLLabel
        Left = 392
        Top = 16
        Width = 101
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel41: TRLLabel
        Left = 4
        Top = 31
        Width = 179
        Height = 11
        Caption = 'Total das Reten'#231#245'es (ISSQN / Federais)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllValorTotalISSQNRetido: TRLLabel
        Left = 4
        Top = 46
        Width = 107
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel43: TRLLabel
        Left = 227
        Top = 31
        Width = 110
        Height = 11
        Caption = 'Valor L'#237'quido da NFS-e'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllValorTotalLiq: TRLLabel
        Left = 227
        Top = 46
        Width = 63
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel20: TRLLabel
        Left = 557
        Top = 31
        Width = 160
        Height = 11
        Caption = 'Valor L'#237'quido da NFS-e + IBS/CBS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllValorLiqIBSCBS: TRLLabel
        Left = 557
        Top = 46
        Width = 77
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
    end
    object rlbBanda05_Destinatario: TRLBand
      Left = 28
      Top = 407
      Width = 940
      Height = 83
      BandType = btTitle
      Borders.Sides = sdCustom
      Borders.DrawLeft = True
      Borders.DrawTop = False
      Borders.DrawRight = True
      Borders.DrawBottom = True
      BeforePrint = rlbBanda05_DestinatarioBeforePrint
      object rllDestCNPJ: TRLLabel
        Left = 264
        Top = 16
        Width = 54
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object rllDestInscMunicipal: TRLLabel
        Left = 408
        Top = 16
        Width = 87
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object rllDestNome: TRLLabel
        Left = 4
        Top = 42
        Width = 54
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object rllDestEndereco: TRLLabel
        Left = 4
        Top = 68
        Width = 68
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object rllDestMunicipio: TRLLabel
        Left = 409
        Top = 42
        Width = 69
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object rllDestEmail: TRLLabel
        Left = 409
        Top = 68
        Width = 52
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object rllDestTelefone: TRLLabel
        Left = 607
        Top = 16
        Width = 64
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel42: TRLLabel
        Left = 4
        Top = 2
        Width = 162
        Height = 14
        Caption = 'DESTINAT'#193'RIO DA OPERA'#199#195'O'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel44: TRLLabel
        Left = 4
        Top = 29
        Width = 121
        Height = 11
        Caption = 'Nome / Nome Empresarial'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel47: TRLLabel
        Left = 4
        Top = 56
        Width = 46
        Height = 11
        Caption = 'Endere'#231'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel48: TRLLabel
        Left = 264
        Top = 2
        Width = 86
        Height = 14
        Caption = 'CNPJ / CPF / NIF'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel49: TRLLabel
        Left = 408
        Top = 2
        Width = 92
        Height = 11
        Caption = 'Inscri'#231#227'o Municipal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel51: TRLLabel
        Left = 409
        Top = 56
        Width = 31
        Height = 11
        Caption = 'E-mail'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel52: TRLLabel
        Left = 408
        Top = 29
        Width = 96
        Height = 11
        Caption = 'Munic'#237'pio / Sigla UF'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel53: TRLLabel
        Left = 607
        Top = 2
        Width = 41
        Height = 11
        Caption = 'Telefone'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel56: TRLLabel
        Left = 607
        Top = 29
        Width = 90
        Height = 11
        Caption = 'C'#243'digo IBGE / CEP'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllDestCEP: TRLLabel
        Left = 608
        Top = 42
        Width = 48
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object rllDestinatarioNaoIdentificado: TRLLabel
        Left = 282
        Top = 0
        Width = 376
        Height = 16
        Align = faCenterTop
        Alignment = taCenter
        Caption = 'DESTINAT'#193'RIO DO SERVI'#199'O N'#195'O IDENTIFICADO NA NFS-e'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
    end
    object rlbBanda12_TributacaoFederalIBSCBS: TRLBand
      Left = 28
      Top = 875
      Width = 940
      Height = 112
      BandType = btSummary
      Borders.Sides = sdCustom
      Borders.DrawLeft = True
      Borders.DrawTop = True
      Borders.DrawRight = True
      Borders.DrawBottom = True
      BeforePrint = rlbBanda12_TributacaoFederalIBSCBSBeforePrint
      object RLLabel27: TRLLabel
        Left = 4
        Top = 2
        Width = 132
        Height = 15
        Caption = 'TRIBUTA'#199#195'O IBS / CBS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel28: TRLLabel
        Left = 186
        Top = 3
        Width = 78
        Height = 11
        Caption = 'CST / cClassTrib'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllCST: TRLLabel
        Left = 185
        Top = 15
        Width = 28
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel34: TRLLabel
        Left = 4
        Top = 29
        Width = 134
        Height = 11
        Caption = 'Exclus'#245'es e Redu'#231#245'es da BC'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllExcRedBC: TRLLabel
        Left = 4
        Top = 41
        Width = 56
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel38: TRLLabel
        Left = 292
        Top = 2
        Width = 377
        Height = 11
        Caption = 
          'Indicador de Opera'#231#227'o / C'#243'digo IBGE Incid'#234'ncia / Munic'#237'pio Incid' +
          #234'ncia / Sigla UF'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllcIndOp: TRLLabel
        Left = 292
        Top = 15
        Width = 40
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel57: TRLLabel
        Left = 186
        Top = 29
        Width = 144
        Height = 11
        Caption = 'BC ap'#243's Exclus'#245'es e Redu'#231#245'es'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllValorBC: TRLLabel
        Left = 186
        Top = 41
        Width = 44
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel59: TRLLabel
        Left = 374
        Top = 56
        Width = 123
        Height = 11
        Caption = 'Al'#237'q. Efetiva Estadual - IBS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllAliqEfetIBSUF: TRLLabel
        Left = 374
        Top = 69
        Width = 71
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel63: TRLLabel
        Left = 374
        Top = 29
        Width = 176
        Height = 11
        Caption = 'Red. Al'#237'quota IBS / Red. Al'#237'quota CBS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllRedAliquota: TRLLabel
        Left = 374
        Top = 41
        Width = 60
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel79: TRLLabel
        Left = 4
        Top = 56
        Width = 128
        Height = 11
        Caption = 'Al'#237'q. Efetiva Munic'#237'pal - IBS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllAliqEfetIBSMun: TRLLabel
        Left = 4
        Top = 69
        Width = 75
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel91: TRLLabel
        Left = 4
        Top = 83
        Width = 118
        Height = 11
        Caption = 'Valor Total Apurado - IBS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllValorApurIBS: TRLLabel
        Left = 4
        Top = 95
        Width = 65
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel98: TRLLabel
        Left = 186
        Top = 56
        Width = 140
        Height = 11
        Caption = 'Valor Apurado Municipal - IBS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllValorApurIBSMun: TRLLabel
        Left = 186
        Top = 69
        Width = 82
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel102: TRLLabel
        Left = 186
        Top = 83
        Width = 69
        Height = 11
        Caption = 'Al'#237'quota - CBS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllAliquotaCBS: TRLLabel
        Left = 186
        Top = 95
        Width = 62
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel106: TRLLabel
        Left = 374
        Top = 83
        Width = 85
        Height = 11
        Caption = 'Al'#237'q. Efetiva - CBS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllAliqEfetCBS: TRLLabel
        Left = 374
        Top = 95
        Width = 62
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel110: TRLLabel
        Left = 580
        Top = 29
        Width = 111
        Height = 11
        Caption = 'Al'#237'q. - IBS UF / IBS Mun'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllAliquotaIBS: TRLLabel
        Left = 580
        Top = 41
        Width = 58
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel114: TRLLabel
        Left = 580
        Top = 56
        Width = 135
        Height = 11
        Caption = 'Valor Apurado Estadual - IBS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllValorApurIBSUF: TRLLabel
        Left = 580
        Top = 69
        Width = 78
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel119: TRLLabel
        Left = 580
        Top = 83
        Width = 122
        Height = 11
        Caption = 'Valor Total Apurado - CBS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllValorApurCBS: TRLLabel
        Left = 580
        Top = 95
        Width = 69
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
    end
    object rlbCanhoto: TRLBand
      Left = 28
      Top = 1127
      Width = 940
      Height = 55
      BandType = btSummary
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = False
      Borders.DrawRight = False
      Borders.DrawBottom = False
      BeforePrint = rlbCanhotoBeforePrint
      object RLDraw7: TRLDraw
        Left = 3
        Top = 6
        Width = 751
        Height = 48
      end
      object rllNumChave: TRLLabel
        Left = 402
        Top = 33
        Width = 345
        Height = 18
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel50: TRLLabel
        Left = 403
        Top = 13
        Width = 135
        Height = 15
        Caption = 'N. NFS-e / Chave NFS-e'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel54: TRLLabel
        Left = 151
        Top = 14
        Width = 225
        Height = 15
        Caption = 'Identifica'#231#227'o e Assinatura do Recebedor'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLDraw5: TRLDraw
        Left = 150
        Top = 48
        Width = 248
        Height = 1
        Brush.Style = bsClear
        DrawKind = dkLine
      end
      object RLLabel121: TRLLabel
        Left = 5
        Top = 14
        Width = 33
        Height = 15
        Caption = 'DATA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLLabel122: TRLLabel
        Left = 4
        Top = 38
        Width = 136
        Height = 12
        Caption = '_______ / _______ / __________'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object rllNumNFSe: TRLLabel
        Left = 558
        Top = 14
        Width = 58
        Height = 14
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
    end
  end
  inherited RLPDFFilter1: TRLPDFFilter
    Left = 160
    Top = 16
  end
end
