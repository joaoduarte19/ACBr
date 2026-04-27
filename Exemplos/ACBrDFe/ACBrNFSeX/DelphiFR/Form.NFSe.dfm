object FNFSe: TFNFSe
  Left = 0
  Top = 0
  Caption = 'NFS-e'
  ClientHeight = 397
  ClientWidth = 545
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnCreate = FormCreate
  TextHeight = 15
  object G: TGroupBox
    Left = 8
    Top = 8
    Width = 537
    Height = 385
    Caption = 'NFS-e'
    TabOrder = 0
    object ckVariosItens: TCheckBox
      Left = 151
      Top = 167
      Width = 129
      Height = 17
      Caption = 'For'#231'ar V'#225'rios Itens'
      TabOrder = 1
    end
    object Button1: TButton
      Left = 11
      Top = 25
      Width = 75
      Height = 25
      Caption = 'DANFSE'
      TabOrder = 0
      OnClick = Button1Click
    end
    object ckHomologacao: TCheckBox
      Left = 151
      Top = 190
      Width = 145
      Height = 17
      Caption = 'For'#231'ar Homologa'#231#227'o'
      TabOrder = 2
    end
    object rbProvedor: TRadioGroup
      Left = 11
      Top = 56
      Width = 134
      Height = 313
      Caption = 'Provedor'
      ItemIndex = 0
      Items.Strings = (
        'Padr'#227'o Nacional')
      TabOrder = 3
    end
    object ckOutrasInformacoes: TCheckBox
      Left = 151
      Top = 213
      Width = 161
      Height = 17
      Caption = 'For'#231'ar Outras Informa'#231#245'es'
      TabOrder = 4
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
    Configuracoes.WebServices.Ambiente = taProducao
    Configuracoes.WebServices.AguardarConsultaRet = 0
    Configuracoes.WebServices.QuebradeLinha = '|'
    Left = 176
    Top = 288
  end
  object ACBrIBGE1: TACBrIBGE
    ProxyPort = '8080'
    ContentsEncodingCompress = []
    NivelLog = 0
    CacheArquivo = 'ACBrIBGE.txt'
    Left = 272
    Top = 288
  end
  object ACBrNFSeXDANFSeFR1: TACBrNFSeXDANFSeFR
    Sistema = 'Projeto ACBr - www.projetoacbr.com.br'
    MargemInferior = 8.000000000000000000
    MargemSuperior = 8.000000000000000000
    MargemEsquerda = 6.000000000000000000
    MargemDireita = 5.100000000000000000
    ExpandeLogoMarcaConfig.Altura = 0
    ExpandeLogoMarcaConfig.Esquerda = 0
    ExpandeLogoMarcaConfig.Topo = 0
    ExpandeLogoMarcaConfig.Largura = 0
    ExpandeLogoMarcaConfig.Dimensionar = False
    ExpandeLogoMarcaConfig.Esticar = True
    CasasDecimais.Formato = tdetInteger
    CasasDecimais.qCom = 2
    CasasDecimais.vUnCom = 2
    CasasDecimais.MaskqCom = ',0.00'
    CasasDecimais.MaskvUnCom = ',0.00'
    CasasDecimais.Aliquota = 2
    CasasDecimais.MaskAliquota = ',0.00'
    Cancelada = False
    TipoDANFSE = tpPadraoNacional
    TamanhoFonte = 6
    FormatarNumeroDocumentoNFSe = True
    Provedor = proPadraoNacional
    Producao = snSim
    EspessuraBorda = 1
    IncorporarFontesPdf = False
    IncorporarBackgroundPdf = False
    Left = 360
    Top = 288
  end
end
