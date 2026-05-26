object FNFSe: TFNFSe
  Left = 0
  Top = 0
  Margins.Left = 4
  Margins.Top = 4
  Margins.Right = 4
  Margins.Bottom = 4
  Caption = 'NFS-e'
  ClientHeight = 508
  ClientWidth = 706
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Microsoft Sans Serif'
  Font.Style = []
  Position = poDefault
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 18
  object G: TGroupBox
    Left = 10
    Top = 10
    Width = 671
    Height = 481
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'NFS-e'
    TabOrder = 0
    object ckVariosItens: TCheckBox
      Left = 189
      Top = 389
      Width = 161
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'For'#231'ar V'#225'rios Itens'
      TabOrder = 4
    end
    object rgTipoImpressao: TRadioGroup
      Left = 189
      Top = 70
      Width = 161
      Height = 165
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Formato da Impress'#227'o'
      ItemIndex = 0
      Items.Strings = (
        'Autom'#225'tico'
        'Retrato'
        'Paisagem'
        'Simplificado'
        'Etiqueta')
      TabOrder = 1
    end
    object Button1: TButton
      Left = 14
      Top = 31
      Width = 94
      Height = 32
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'DANFSE'
      TabOrder = 0
      OnClick = Button1Click
    end
    object rgStatus: TRadioGroup
      Left = 358
      Top = 70
      Width = 197
      Height = 165
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Situa'#231#227'o'
      ItemIndex = 0
      Items.Strings = (
        'Autom'#225'tico'
        'Sem protocolo'
        'Cancelada'
        'Denegada')
      TabOrder = 2
    end
    object gbLogomarca: TGroupBox
      Left = 189
      Top = 243
      Width = 217
      Height = 128
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Op'#231#245'es'
      TabOrder = 3
      object ckLogomarcaPrefeitura: TCheckBox
        Left = 20
        Top = 30
        Width = 181
        Height = 21
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = 'Logomarca Prefeitura'
        TabOrder = 0
      end
      object ckLogomarcaPrestador: TCheckBox
        Left = 20
        Top = 59
        Width = 171
        Height = 21
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = 'Logomarca Prestador'
        TabOrder = 1
      end
      object ckQRCode: TCheckBox
        Left = 20
        Top = 88
        Width = 101
        Height = 21
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = 'QR Code'
        TabOrder = 2
      end
    end
    object ckHomologacao: TCheckBox
      Left = 189
      Top = 418
      Width = 181
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'For'#231'ar Homologa'#231#227'o'
      TabOrder = 5
    end
    object rbProvedor: TRadioGroup
      Left = 14
      Top = 70
      Width = 167
      Height = 391
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Provedor'
      ItemIndex = 0
      Items.Strings = (
        'ISS Curitiba'
        'ISSDSF'
        'ISS S'#227'o Paulo'
        'Betha'
        'Ginfes'
        'Tiplan'
        'Padr'#227'o Nacional')
      TabOrder = 6
    end
    object ckOutrasInformacoes: TCheckBox
      Left = 189
      Top = 446
      Width = 201
      Height = 22
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'For'#231'ar Outras Informa'#231#245'es'
      TabOrder = 7
    end
  end
  object ACBrNFSeX1: TACBrNFSeX
    Configuracoes.Geral.SSLLib = libNone
    Configuracoes.Geral.SSLCryptLib = cryNone
    Configuracoes.Geral.SSLHttpLib = httpNone
    Configuracoes.Geral.SSLXmlSignLib = xsNone
    Configuracoes.Geral.FormatoAlerta = 'TAG:%TAGNIVEL% ID:%ID%/%TAG%(%DESCRICAO%) - %MSG%.'
    Configuracoes.Geral.CodigoMunicipio = 0
    Configuracoes.Geral.Provedor = proNenhum
    Configuracoes.Geral.Versao = ve100
    Configuracoes.Geral.GerarTodasSecoes = False
    Configuracoes.Geral.Documentar = False
    Configuracoes.Arquivos.OrdenacaoPath = <>
    Configuracoes.WebServices.UF = 'SP'
    Configuracoes.WebServices.AguardarConsultaRet = 0
    Configuracoes.WebServices.QuebradeLinha = '|'
    Left = 240
    Top = 24
  end
  object ACBrIBGE1: TACBrIBGE
    ProxyPort = '8080'
    ContentsEncodingCompress = []
    NivelLog = 0
    CacheArquivo = 'ACBrIBGE.txt'
    Left = 352
    Top = 32
  end
end
