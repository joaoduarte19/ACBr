object frmPrincipal: TfrmPrincipal
  Left = 308
  Top = 26
  Caption = 'Programa Exemplo ACBr - V'#237'nculo Fiscal'
  ClientHeight = 860
  ClientWidth = 1024
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  object pnpTitulo: TPanel
    Left = 0
    Top = 0
    Width = 1024
    Height = 70
    Align = alTop
    BevelOuter = bvNone
    Caption = 'pnpTitulo'
    TabOrder = 0
    inline FrameTitulo1: TFrameTitulo
      Left = 0
      Top = 0
      Width = 1024
      Height = 70
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      inherited Shape1: TShape
        Width = 1024
        Height = 70
      end
      inherited lblTitulo: TLabel
        Width = 591
        Caption = 'Programa Exemplo - V'#237'nculo Fiscal (NFe + TEF/PIX)'
      end
      inherited lblACBr: TLabel
        Color = clBtnFace
      end
    end
  end
  object pnpFundo: TPanel
    Left = 0
    Top = 70
    Width = 1024
    Height = 790
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object pnpMenuEsquerdo: TPanel
      Left = 0
      Top = 0
      Width = 170
      Height = 790
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      inline frameMenuEsquerdo1: TframeMenuEsquerdo
        Left = 0
        Top = 0
        Width = 170
        Height = 790
        Align = alClient
        Color = clGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentBackground = False
        ParentColor = False
        ParentFont = False
        TabOrder = 0
        inherited btnPDV: TSpeedButton
          Width = 154
          OnClick = btnPDVClick
        end
        inherited btnCfgNFCe: TSpeedButton
          Width = 154
          OnClick = btnCfgNFCeClick
        end
        inherited btnConfTEF: TSpeedButton
          Width = 154
          OnClick = btnConfTEFClick
        end
        inherited btnCfgPIX: TSpeedButton
          Width = 154
          OnClick = btnCfgPIXClick
        end
        inherited btnSAIR: TSpeedButton
          Top = 734
          Width = 154
        end
      end
    end
    object pnpPrincipal: TPanel
      Left = 170
      Top = 0
      Width = 854
      Height = 790
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
    end
  end
  object ACBrEnterTab1: TACBrEnterTab
    EnterAsTab = True
    Left = 433
    Top = 137
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '.*-nfe.XML'
    Filter = 
      'Arquivos NFE (*-nfe.XML)|*-nfe.XML|Arquivos XML (*.XML)|*.XML|To' +
      'dos os Arquivos (*.*)|*.*'
    Title = 'Selecione a NFe'
    Left = 586
    Top = 147
  end
  object ACBrNFe1: TACBrNFe
    OnStatusChange = ACBrNFe1StatusChange
    Configuracoes.Geral.SSLLib = libNone
    Configuracoes.Geral.SSLCryptLib = cryNone
    Configuracoes.Geral.SSLHttpLib = httpNone
    Configuracoes.Geral.SSLXmlSignLib = xsNone
    Configuracoes.Geral.FormatoAlerta = 'TAG:%TAGNIVEL% ID:%ID%/%TAG%(%DESCRICAO%) - %MSG%.'
    Configuracoes.Geral.VersaoDF = ve200
    Configuracoes.Geral.AtualizarXMLCancelado = True
    Configuracoes.Geral.VersaoQRCode = veqr000
    Configuracoes.Arquivos.OrdenacaoPath = <>
    Configuracoes.WebServices.UF = 'SP'
    Configuracoes.WebServices.AguardarConsultaRet = 15000
    Configuracoes.WebServices.AjustaAguardaConsultaRet = True
    Configuracoes.WebServices.TimeOut = 20000
    Configuracoes.WebServices.QuebradeLinha = '|'
    Configuracoes.RespTec.IdCSRT = 0
    DANFE = ACBrNFeDANFeESCPOS1
    Left = 666
    Top = 147
  end
  object ACBrNFeDANFeRL1: TACBrNFeDANFeRL
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
    LogoemCima = True
    Left = 666
    Top = 205
  end
  object ACBrNFeDANFCeFortes1: TACBrNFeDANFCeFortes
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
    FonteLinhaItem.Charset = DEFAULT_CHARSET
    FonteLinhaItem.Color = clWindowText
    FonteLinhaItem.Height = -12
    FonteLinhaItem.Name = 'Lucida Console'
    FonteLinhaItem.Style = []
    Left = 666
    Top = 262
  end
  object ACBrPosPrinter1: TACBrPosPrinter
    Modelo = ppEscPosEpson
    Porta = 'COM9'
    PaginaDeCodigo = pc1252
    EspacoEntreLinhas = 30
    ConfigBarras.MostrarCodigo = False
    ConfigBarras.LarguraLinha = 0
    ConfigBarras.Altura = 0
    ConfigBarras.Margem = 0
    ConfigQRCode.Tipo = 2
    ConfigQRCode.LarguraModulo = 4
    ConfigQRCode.ErrorLevel = 0
    LinhasEntreCupons = 5
    ArqLOG = 'posprinter.txt'
    Left = 666
    Top = 314
  end
  object ACBrNFeDANFeESCPOS1: TACBrNFeDANFeESCPOS
    Logo = 'C:\Testes\MonoCromatico\logo_monol.bmp'
    Sistema = 'Projeto ACBr - www.projetoacbr.com.br'
    MargemInferior = 0.800000000000000000
    MargemSuperior = 0.800000000000000000
    MargemEsquerda = 0.600000000000000000
    MargemDireita = 0.510000000000000000
    ExpandeLogoMarcaConfig.Altura = 0
    ExpandeLogoMarcaConfig.Esquerda = 0
    ExpandeLogoMarcaConfig.Topo = 0
    ExpandeLogoMarcaConfig.Largura = 0
    ExpandeLogoMarcaConfig.Dimensionar = False
    ExpandeLogoMarcaConfig.Esticar = True
    CasasDecimais.Formato = tdetInteger
    CasasDecimais.qCom = 4
    CasasDecimais.vUnCom = 4
    CasasDecimais.MaskqCom = '###,###,###,##0.00'
    CasasDecimais.MaskvUnCom = '###,###,###,##0.00'
    CasasDecimais.Aliquota = 2
    CasasDecimais.MaskAliquota = ',0.00'
    ACBrNFe = ACBrNFe1
    TipoDANFE = tiSemGeracao
    FormularioContinuo = True
    PosPrinter = ACBrPosPrinter1
    Left = 672
    Top = 371
  end
  object ACBrTEFAPI1: TACBrTEFAPI
    DadosAutomacao.AutoAtendimento = False
    DadosTerminal.Ambiente = ambNaoDefinido
    DadosTerminal.GravarLogTEF = False
    Left = 243
    Top = 346
  end
  object ImageList1: TImageList
    Left = 243
    Top = 282
  end
  object ACBrAbecsPinPad1: TACBrAbecsPinPad
    Left = 243
    Top = 224
  end
  object ACBrPixCD1: TACBrPixCD
    Recebedor.CodCategoriaComerciante = 0
    Left = 242
    Top = 414
  end
end
