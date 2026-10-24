unit uframeConfigPIX;

{
  CONFIGURAÇÃO DO PIX DINÂMICO (ACBrPIXCD)

  Esta tela é a MESMA aba "Configuração" do exemplo oficial:
    ACBr\Exemplos\ACBrPIXCD\Delphi\FrPrincipal.pas
  portada para um frame. Todos os PSPs do exemplo são configuráveis, com os
  mesmos campos, validações e assistentes (certificados Itaú, PagSeguro...).

  Diferenças para o exemplo:
    - grupo "Uso no PDV": liga o PIX via PSP no PDV e informa o CNPJ da
      instituição de pagamento, que vai na tag CNPJ do grupo <card> da NFC-e;
    - seções do INI [PIXProxy] e [PIXLog] (no exemplo: [Proxy] e [Log]), para
      não misturar com a configuração da NFC-e no mesmo arquivo;
    - o PDV NÃO usa os componentes desta tela: ele aplica a configuração
      gravada no INI em frmPrincipal.ACBrPixCD1 (unit uPIXUtils).
}

{$I ACBr.inc}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  ExtCtrls, Buttons, Spin, Grids, ACBrCEP, ACBrPIXCD, ACBrPIXPSPItau,
  ACBrPIXPSPBancoDoBrasil, ACBrPIXPSPSantander, ACBrPIXBase, ACBrPIXSchemasPix,
  ACBrPIXSchemasDevolucao, ACBrPIXSchemasCob, ACBrPIXPSPShipay,
  ACBrOpenSSLUtils, ACBrPIXPSPSicredi, ACBrPIXBRCode, ACBrSocket, ACBrBase,
  ImgList, ACBrPIXPSPSicoob, ACBrPIXPSPPagSeguro, ACBrPIXPSPGerenciaNet,
  ACBrPIXPSPBradesco, ACBrPIXPSPPixPDV, ACBrPIXPSPInter, ACBrPIXPSPAilos,
  ACBrPIXPSPMatera, ACBrPIXPSPCielo, ACBrPIXPSPMercadoPago, ACBrPIXPSPGate2All,
  ACBrPIXPSPBanrisul, ACBrPIXPSPC6Bank, ACBrPIXPSPAppLess, ACBrPIXPSPQQPag,
  ACBrPIXPSPCrediSIS,
  uframerodapeSalvar
  {$IFDEF DELPHIXE8_UP}, System.ImageList{$ENDIF};

type

  { TframeConfigPIX }

  TframeConfigPIX = class(TFrame)
    pnpRodape: TPanel;
    frameRodape1: TframeRodape;
    pnlLog: TPanel;
    mLog: TMemo;
    gbUsoPDV: TGroupBox;
    cbPIXHabilitado: TCheckBox;
    pBotoesConfiguracao: TPanel;
    btSalvarParametros: TBitBtn;
    btLerParametros: TBitBtn;
    pgConfPixPSP: TPageControl;
    tsPIX: TTabSheet;
    pConfPIX: TPanel;
    gbRecebedor: TGroupBox;
    pnRecebedor: TPanel;
    imgErrCEP: TImage;
    Label14: TLabel;
    Label16: TLabel;
    Label18: TLabel;
    sbConsultaCEP: TSpeedButton;
    imgErrNome: TImage;
    Label42: TLabel;
    edtRecebedorNome: TEdit;
    edtRecebedorCidade: TEdit;
    edtRecebedorCEP: TEdit;
    cbxRecebedorUF: TComboBox;
    gbProxy: TGroupBox;
    pnProxy: TPanel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label36: TLabel;
    sbVerSenhaProxy: TSpeedButton;
    edtProxyHost: TEdit;
    edtProxyUser: TEdit;
    edtProxySenha: TEdit;
    seProxyPorta: TSpinEdit;
    gbLog: TGroupBox;
    pnLog: TPanel;
    Label11: TLabel;
    Label12: TLabel;
    sbArqLog: TSpeedButton;
    edtArqLog: TEdit;
    cbxNivelLog: TComboBox;
    gbPSP: TGroupBox;
    pnPSP: TPanel;
    Label13: TLabel;
    Label15: TLabel;
    Label17: TLabel;
    imgErrPSP: TImage;
    cbxPSPAtual: TComboBox;
    cbxAmbiente: TComboBox;
    seTimeout: TSpinEdit;
    gbCobranca: TGroupBox;
    pnCobranca: TPanel;
    Label47: TLabel;
    seCobrancaExpiracao: TSpinEdit;
    gbAutenticacaoManual: TGroupBox;
    pnAutenticacaoManual: TPanel;
    cbAutenticacaoManual: TCheckBox;
    tsPSP: TTabSheet;
    pgPSPs: TPageControl;
    tsShipay: TTabSheet;
    pConfPSPBB3: TPanel;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    edtShipayClientID: TEdit;
    edtShipaySecretKey: TEdit;
    edtShipayAccessKey: TEdit;
    tsBB: TTabSheet;
    pgBBConfig: TPageControl;
    tsBBConfigGeral: TTabSheet;
    pnBBConfig: TPanel;
    lbBBChavePIX: TLabel;
    lbBBTipoChave: TLabel;
    lbBBClientID: TLabel;
    lbBBClientSecret: TLabel;
    lbBBDevAppKey: TLabel;
    imgBBErroChavePIX: TImage;
    lbBBVersaoAPI: TLabel;
    edtBBChavePIX: TEdit;
    cbxBBTipoChave: TComboBox;
    edtBBClientID: TEdit;
    edtBBClientSecret: TEdit;
    edtBBDevAppKey: TEdit;
    cbBBVersaoAPI: TComboBox;
    rgBBTipoCertificado: TRadioGroup;
    pnBBCertificados: TPanel;
    pcBBCertificados: TPageControl;
    tsBBPFX: TTabSheet;
    pnBBPFX: TPanel;
    imBBErroPFX: TImage;
    lbBBArqPFX: TLabel;
    lbBBErroPFX: TLabel;
    sbBBAcharPFX: TSpeedButton;
    lbBBSenhaPFX: TLabel;
    btBBVerSenhaPFX: TSpeedButton;
    edBBArqPFX: TEdit;
    edBBSenhaPFX: TEdit;
    tsBBChaveECertificado: TTabSheet;
    pnBBChaveECert: TPanel;
    imBBErroChavePrivada: TImage;
    lbBBArqChavePrivada: TLabel;
    lbBBErroChavePrivada: TLabel;
    sbBBAcharChavePrivada: TSpeedButton;
    sbBBAcharArqCertificado: TSpeedButton;
    lbBBArqCertificado: TLabel;
    imBBErroCertificado: TImage;
    lbBBErroCertificado: TLabel;
    edBBArqChavePrivada: TEdit;
    edBBArqCertificado: TEdit;
    tsBBConfigTokenManual: TTabSheet;
    pnBBConfigTokenManual: TPanel;
    gbBBConfigTokenManual: TGroupBox;
    pnBBConfigTokenManualGerar: TPanel;
    lbBBConfigTokenValidade: TLabel;
    lbBBConfigTokenManual: TLabel;
    mmBBConfigTokenManual: TMemo;
    edBBConfigTokenValidade: TDateTimePicker;
    btBBConfigTokenManualGerar: TButton;
    cbBBConfigTokenManual: TCheckBox;
    tsItau: TTabSheet;
    pgPSPItau: TPageControl;
    tsItauChave: TTabSheet;
    pConfPSPBB1: TPanel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    imgItauErroChavePIX: TImage;
    imgItauErroClientID: TImage;
    imgItauErroClientSecret: TImage;
    edtItauChavePIX: TEdit;
    cbxItauTipoChave: TComboBox;
    edtItauClientID: TEdit;
    edtItauClientSecret: TEdit;
    tsItauCertificado: TTabSheet;
    pgPSPItauChaveCertificado: TPageControl;
    tsItauChaveCertificadoArquivos: TTabSheet;
    lItauAvisoChaveCertificadoDesabilitado: TLabel;
    Panel7: TPanel;
    Label41: TLabel;
    imgItauErroChavePrivada: TImage;
    lItauErroChavePrivada: TLabel;
    sbItauAcharArqChavePrivada: TSpeedButton;
    Label40: TLabel;
    imgItauErroCertificado: TImage;
    lItauErroCertificado: TLabel;
    sbItauAcharArqCertificado: TSpeedButton;
    edtItauArqChavePrivada: TEdit;
    edtItauArqCertificado: TEdit;
    btItauValidarChaveCertificado: TBitBtn;
    tsItauGerarChaveCertificado: TTabSheet;
    pgPSPItauGerarChaveCertificado: TPageControl;
    tsItauCertPasso1: TTabSheet;
    Label39: TLabel;
    edtItauArqChavePrivada2: TEdit;
    btItauGerarChavePrivada: TBitBtn;
    mItauChavePrivadaPEM: TMemo;
    tsItauCertPasso3: TTabSheet;
    pItauEditCertificado: TPanel;
    Label43: TLabel;
    btItauSolicitarCertificado: TBitBtn;
    edtItauArqCertificado2: TEdit;
    pItauTokentemporario: TPanel;
    lTokenTemporario: TLabel;
    mItauTokenTemporario: TMemo;
    pItauCertificadoRecebido: TPanel;
    Label6: TLabel;
    mItauCertificadoPEM: TMemo;
    tsItauRenovarChaveCertificado: TTabSheet;
    pnItauRenovarCertificadoPEM: TPanel;
    lbItauRenovarCertificadoPEM: TLabel;
    mmItauRenovarCertificadoPEM: TMemo;
    pItauEditCertificado1: TPanel;
    lbItauRenovarCertificadoArq: TLabel;
    edItauRenovarCertificadoArq: TEdit;
    btItauRenovarCertificado: TBitBtn;
    tsSantander: TTabSheet;
    pgSantander: TPageControl;
    tsSantanderCredenciais: TTabSheet;
    pConfPSPSantander: TPanel;
    lbSantanderChavePIX: TLabel;
    lbSantanderTipoChave: TLabel;
    lbSantanderConsumerKey: TLabel;
    lbSantanderConsumerSecret: TLabel;
    imSantanderErroChavePIX: TImage;
    sbSantanderAcharCertificadoPFX: TSpeedButton;
    lbSantanderArqCertificadoPFX: TLabel;
    lbSantanderErroCertificadoPFX: TLabel;
    imSantanderErroCertificadoPFX: TImage;
    lbSantanderSenhaCertificado: TLabel;
    sbSantanderVerSenhaPFX: TSpeedButton;
    edSantanderChavePIX: TEdit;
    cbSantanderTipoChave: TComboBox;
    edSantanderConsumerKey: TEdit;
    edSantanderConsumerSecret: TEdit;
    edSantanderArqCertificadoPFX: TEdit;
    edSantanderSenhaCertificadoPFX: TEdit;
    tsSantanderExtrairCertificado: TTabSheet;
    pnSantanderExtrairCertificado: TPanel;
    sbSantanderExtrairCertificadoPFX: TSpeedButton;
    lbSantanderExtrairCertificadoPFX: TLabel;
    lbSantanderExtrairCertificadoPEM: TLabel;
    lbSantanderExtrairCertificadoSenhaPFX: TLabel;
    sbSantanderExtrairCertificadoVerSenhaPFX: TSpeedButton;
    sbSantanderExtrairCertificadoInfo: TSpeedButton;
    edSantanderExtrairCertificadoPFX: TEdit;
    btSantanderExtrairPEM: TBitBtn;
    edSantanderExtrairCertificadoPEM: TEdit;
    edSantanderExtrairCertificadoSenhaPFX: TEdit;
    tsSicredi: TTabSheet;
    pgSicredi: TPageControl;
    tsSicrediCredenciais: TTabSheet;
    pnSicrediCredenciais: TPanel;
    sbSicrediAcharChavePrivada: TSpeedButton;
    sbSicrediAcharArqCertificado: TSpeedButton;
    lbSicrediTipoChave: TLabel;
    lbSicrediErroChavePrivada: TLabel;
    lbSicrediErroCertificado: TLabel;
    lbSicrediClientSecret: TLabel;
    lbSicrediClientID: TLabel;
    lbSicrediChavePIX: TLabel;
    lbSicrediArqChavePrivada: TLabel;
    lbSicrediArqCertificado: TLabel;
    imSicrediErroChavePrivada: TImage;
    imSicrediErroChavePix: TImage;
    imSicrediErroCertificado: TImage;
    btSicrediSenhaChavePrivada: TSpeedButton;
    lbSicrediSenhaChavePrivada: TLabel;
    edSicrediClientSecret: TEdit;
    edSicrediClientID: TEdit;
    edSicrediChavePIX: TEdit;
    edSicrediArqChavePrivada: TEdit;
    edSicrediArqCertificado: TEdit;
    cbSicrediTipoChave: TComboBox;
    edSicrediSenhaChavePrivada: TEdit;
    tsSicrediGerarChaveCSR: TTabSheet;
    pnSicrediGerarChaveCSR: TPanel;
    lbSicrediGerarChavePrivada: TLabel;
    lbSicrediGerarCSR: TLabel;
    btSicrediGerarChaveInfo: TSpeedButton;
    btSicrediGerarCSRInfo: TSpeedButton;
    lbSicrediGerarCSREmail: TLabel;
    sbSicrediAcharChavePrivada2: TSpeedButton;
    edSicrediGerarChavePrivada: TEdit;
    mmSicrediGerarChavePrivada: TMemo;
    btSicrediGerarChavePrivada: TBitBtn;
    edSicrediGerarCSR: TEdit;
    mmSicrediGerarCSR: TMemo;
    btSicrediGerarCSR: TBitBtn;
    edSicrediGerarCSREmail: TEdit;
    tsSicoob: TTabSheet;
    pgSicoob: TPageControl;
    tsSicoobCredenciais: TTabSheet;
    pnSicoobCredenciais: TPanel;
    pnConfPSPSicoob: TPanel;
    lbSicoobChavePix: TLabel;
    lbSicoobTipoChave: TLabel;
    lbSicoobClientID: TLabel;
    lbSicoobArquivoChavePrivada: TLabel;
    imSicoobErroChavePrivada: TImage;
    lbSicoobErroChavePrivada: TLabel;
    lbSicoobArquivoCertificado: TLabel;
    imSicoobErroCertificado: TImage;
    lbSicoobErroCertificado: TLabel;
    imSicoobErroChavePIX: TImage;
    sbSicoobAcharChavePrivada: TSpeedButton;
    sbSicoobAcharArqCertificado: TSpeedButton;
    lbSicoobTokenSandbox: TLabel;
    edSicoobChavePIX: TEdit;
    cbSicoobTipoChave: TComboBox;
    edSicoobClientID: TEdit;
    edSicoobArqChavePrivada: TEdit;
    edSicoobArqCertificado: TEdit;
    edSicoobTokenSandbox: TEdit;
    tsSicoobExtrairChaveCertificado: TTabSheet;
    pnSicoobExtrairChaveCertificado: TPanel;
    lbSicoobExtrairChaveCertificadoArqPFX: TLabel;
    btSicoobExtrairChaveCertificadoArqPFX: TSpeedButton;
    lbSicoobExtrairChaveCertificadoSenhaPFX: TLabel;
    btSicoobExtrairChaveCertificadoVerSenhaPFX: TSpeedButton;
    lbSicoobExtrairChavePrivada: TLabel;
    btSicoobExtrairChaveCertificadoInfo: TSpeedButton;
    lbSicoobExtrairCertificado: TLabel;
    edSicoobExtrairChaveCertificadoArqPFX: TEdit;
    edSicoobExtrairChaveCertificadoSenhaPFX: TEdit;
    btSicoobExtrairChaveCertificado: TBitBtn;
    edSicoobExtrairChavePrivada: TEdit;
    edSicoobExtrairCertificado: TEdit;
    tsPagSeguro: TTabSheet;
    pgPagSeguro: TPageControl;
    tsPagSeguroConfigCredenciais: TTabSheet;
    pnPagSeguroConfigCredenciais: TPanel;
    sbPagSeguroAcharChavePrivada: TSpeedButton;
    sbPagSeguroAcharArqCertificado: TSpeedButton;
    lbPagSeguroTipoChave: TLabel;
    lbPagSeguroErroChavePrivada: TLabel;
    lbPagSeguroErroCertificado: TLabel;
    lbPagSeguroClientSecret1: TLabel;
    lbPagSeguroClientID1: TLabel;
    lbPagSeguroChavePIX: TLabel;
    lbPagSeguroArqChavePrivada: TLabel;
    lbPagSeguroArqCertificado: TLabel;
    imPagSeguroErroChavePrivada: TImage;
    imPagSeguroErroChavePix: TImage;
    imPagSeguroErroCertificado: TImage;
    lbPagSeguroTokenPay1: TLabel;
    lbPagSeguroNomeApp: TLabel;
    edPagSeguroClientSecret1: TEdit;
    edPagSeguroClientID1: TEdit;
    edPagSeguroChavePIX: TEdit;
    edPagSeguroArqChavePrivada: TEdit;
    edPagSeguroArqCertificado: TEdit;
    cbPagSeguroTipoChave: TComboBox;
    edPagSeguroToken1: TEdit;
    edPagSeguroNomeApp1: TEdit;
    tsPagSeguroGerarCredenciais: TTabSheet;
    pnPagSeguroGerarCredenciais: TPanel;
    pgPagSeguroGerarCredenciais: TPageControl;
    tsPagSeguroGerarCredenciaisClients: TTabSheet;
    pnPagSeguroGerarCredenciaisClients: TPanel;
    lbPagSeguroNomeApp1: TLabel;
    lbPagSeguroTokenPay2: TLabel;
    lbPagSeguroClientID2: TLabel;
    lbPagSeguroClientSecret2: TLabel;
    edPagSeguroNomeApp2: TEdit;
    edPagSeguroToken2: TEdit;
    edPagSeguroClientID2: TEdit;
    edPagSeguroClientSecret2: TEdit;
    btPagSeguroGerarClients: TBitBtn;
    tsPagSeguroGerarChaves: TTabSheet;
    pnPagSeguroGerarChaves: TPanel;
    lbPagSeguroPublicKey: TLabel;
    lbPagSeguroPrivateKey: TLabel;
    btPagSeguroGerarChaves: TBitBtn;
    edPagSeguroPublicKey: TEdit;
    edPagSeguroPrivateKey: TEdit;
    mmPagSeguroPublicKey: TMemo;
    mmPagSeguroPrivateKey: TMemo;
    tsPagSeguroChallenge: TTabSheet;
    pnPagSeguroChallenge: TPanel;
    lbPagSeguroChallengePrivateKey: TLabel;
    lbPagSeguroChallengeToken: TLabel;
    btPagSeguroChallengeSolic: TBitBtn;
    edPagSeguroChallengePrivateKey: TEdit;
    mmPagSeguroChallengeCript: TMemo;
    mmPagSeguroChallenge: TMemo;
    btPagSeguroChallengeDecript: TBitBtn;
    edPagSeguroChallengeToken: TEdit;
    tsPagSeguroCertificado: TTabSheet;
    pnPagSeguroCertificado: TPanel;
    lbPagSeguroChallengeToken2: TLabel;
    lbPagSeguroCertificadoChallenge: TLabel;
    lbPagSeguroPublicKey1: TLabel;
    lbPagSeguroPrivateKey1: TLabel;
    btPagSeguroCertificadoGerar: TBitBtn;
    edPagSeguroChallengeToken2: TEdit;
    edPagSeguroCertificadoChallenge: TEdit;
    edPagSeguroCertificadoFinal: TEdit;
    edPagSeguroPrivateKeyFinal: TEdit;
    tsGerenciaNet: TTabSheet;
    pnGerenciaNet: TPanel;
    sbGerenciaNetAcharPFX: TSpeedButton;
    lbGerenciaNetTipoChave: TLabel;
    lbGerenciaNetErroPFX: TLabel;
    lbGerenciaNetClientSecret: TLabel;
    lbGerenciaNetClientID: TLabel;
    lbGerenciaNetChave: TLabel;
    lbGerenciaNetPFX: TLabel;
    imGerenciaNetErroPFX: TImage;
    imGerenciaNetErroChavePix: TImage;
    edGerenciaNetClientSecret: TEdit;
    edGerenciaNetClientID: TEdit;
    edGerenciaNetChavePIX: TEdit;
    edGerenciaNetArqPFX: TEdit;
    cbGerenciaNetTipoChave: TComboBox;
    tsBradesco: TTabSheet;
    pnBradesco: TPanel;
    lbBradescoTipoChave: TLabel;
    lbBradescoClientSecret: TLabel;
    lbBradescoClientKey: TLabel;
    lbBradescoChave: TLabel;
    imBradescoErroChavePix: TImage;
    lbBradescoAPIVersao: TLabel;
    edBradescoClientSecret: TEdit;
    edBradescoClientID: TEdit;
    edBradescoChavePIX: TEdit;
    cbBradescoTipoChave: TComboBox;
    rgBradescoTipoCertificado: TRadioGroup;
    pnBradescoCertificados: TPanel;
    pcBradescoCertificados: TPageControl;
    tsBradescoPFX: TTabSheet;
    pnBradescoPFX: TPanel;
    sbBradescoAcharPFX: TSpeedButton;
    lbBradescoErroPFX: TLabel;
    lbBradescoPFX: TLabel;
    imBradescoErroPFX: TImage;
    sbBradescoVerSenhaPFX: TSpeedButton;
    lbBradescoSenhaPFX: TLabel;
    edBradescoArqPFX: TEdit;
    edBradescoSenhaPFX: TEdit;
    tsBradescoChaveECertificado: TTabSheet;
    pnBradescoChaveECert: TPanel;
    imBradescoErroChavePrivada: TImage;
    lbBradescoArqChavePrivada: TLabel;
    lbBradescoErroChavePrivada: TLabel;
    sbBradescoAcharChavePrivada: TSpeedButton;
    sbBradescoAcharArqCertificado: TSpeedButton;
    lbBradescoArqCertificado: TLabel;
    imBradescoErroCertificado: TImage;
    lbBradescoErroCertificado: TLabel;
    edBradescoArqChavePrivada: TEdit;
    edBradescoArqCertificado: TEdit;
    cbBradescoAPIVersao: TComboBox;
    tsPIXPDV: TTabSheet;
    pnPixPDV: TPanel;
    lbPixPDVCNPJ: TLabel;
    lbPixPDVToken: TLabel;
    lbPixPDVSecretKey: TLabel;
    lbPIXPDVVersaoAPI: TLabel;
    edPixPDVCNPJ: TEdit;
    edPixPDVToken: TEdit;
    edPixPDVSecretKey: TEdit;
    cbPIXPDVVersaoAPI: TComboBox;
    tsInter: TTabSheet;
    pnInter: TPanel;
    lbInterTipoChave: TLabel;
    lbInterClientSecret: TLabel;
    lbInterClientID: TLabel;
    lbInterChave: TLabel;
    imInterErroChavePix: TImage;
    lbInterChavePrivada: TLabel;
    lbInterErroChavePrivada: TLabel;
    imInterErroChavePrivada: TImage;
    btInterAcharChavePrivada: TSpeedButton;
    btInterAcharCertificado: TSpeedButton;
    imInterErroCertificado: TImage;
    lbInterErroCertificado: TLabel;
    lbInterCertificado: TLabel;
    edInterClientSecret: TEdit;
    edInterClientID: TEdit;
    edInterChavePIX: TEdit;
    cbInterTipoChave: TComboBox;
    edInterChavePrivada: TEdit;
    edInterCertificado: TEdit;
    tsAilos: TTabSheet;
    pnAilos: TPanel;
    lbAilosTipoChave: TLabel;
    lbAilosErroChavePrivada: TLabel;
    lbAilosErroCertificadoRoot: TLabel;
    lbAilosClientSecret: TLabel;
    lbAilosClienteID: TLabel;
    lbAilosChave: TLabel;
    lbAilosChavePrivada: TLabel;
    lbAilosCertificadoRoot: TLabel;
    imAilosErroChavePIX: TImage;
    imAilosErroCertificadoRoot: TImage;
    imAilosErroChavePrivada: TImage;
    imAilosErroCertificado: TImage;
    lbAilosCertificado: TLabel;
    lbAilosErroCertificado: TLabel;
    btAilosAcharCertificado: TSpeedButton;
    btAilosAcharchavePrivada: TSpeedButton;
    btAilosAcharCertificadoRoot: TSpeedButton;
    edAilosClientSecret: TEdit;
    edAilosClientID: TEdit;
    edAilosChavePIX: TEdit;
    edAilosChavePrivada: TEdit;
    edAilosCertificadoRoot: TEdit;
    cbAilosTipoChave: TComboBox;
    edAilosCertificado: TEdit;
    tsMatera: TTabSheet;
    pnMatera: TPanel;
    lbMateraClientID: TLabel;
    lbMateraErroCertificado: TLabel;
    lbMateraArqCertificado: TLabel;
    imMateraErroCertificado: TImage;
    btMateraAcharArqCertificado: TSpeedButton;
    btMateraAcharChavePrivada: TSpeedButton;
    lbMateraArqChavePrivada: TLabel;
    lbMateraErroChavePrivada: TLabel;
    imMateraErroChavePrivada: TImage;
    lbMateraSecretKey: TLabel;
    lbMateraAccountId: TLabel;
    lbMateraChavePIX: TLabel;
    lbMateraClientSecret: TLabel;
    lbMateraMediatorFee: TLabel;
    edMateraClientID: TEdit;
    edMateraArqCertificado: TEdit;
    edMateraArqChavePrivada: TEdit;
    edMateraSecretKey: TEdit;
    edMateraAccountId: TEdit;
    edMateraChavePIX: TEdit;
    edMateraClientSecret: TEdit;
    edMateraMediatorFee: TEdit;
    tsCielo: TTabSheet;
    pnCielo: TPanel;
    lbCieloTipoChave: TLabel;
    lbCieloClientSecret: TLabel;
    lbCieloClientID: TLabel;
    lbCieloChave: TLabel;
    imCieloErroChavePix: TImage;
    lbCieloArqChavePrivada: TLabel;
    lbCieloArqCertificado: TLabel;
    sbCieloAcharChavePrivada: TSpeedButton;
    sbCieloAcharArqCertificado: TSpeedButton;
    lbCieloErroChavePrivada: TLabel;
    lbCieloErroCertificado: TLabel;
    imCieloErroChavePrivada: TImage;
    imCieloErroCertificado: TImage;
    edCieloClientSecret: TEdit;
    edCieloClientID: TEdit;
    edCieloChavePIX: TEdit;
    cbCieloTipoChave: TComboBox;
    edCieloArqChavePrivada: TEdit;
    edCieloArqCertificado: TEdit;
    tsMercadoPago: TTabSheet;
    pnMercadoPago: TPanel;
    lbMercadoPagoTipoChave: TLabel;
    lbMercadoPagoAccessToken: TLabel;
    lbMercadoPagoChavePIX: TLabel;
    imMercadoPagoErroChavePix: TImage;
    edMercadoPagoAccessToken: TEdit;
    edMercadoPagoChavePIX: TEdit;
    cbMercadoPagoTipoChave: TComboBox;
    tsGate2All: TTabSheet;
    pnGate2All: TPanel;
    lbGate2AllAuthenticationKey: TLabel;
    lbGate2AllAuthenticationApi: TLabel;
    edGate2AllAuthenticationKey: TEdit;
    edGate2AllAuthenticationApi: TEdit;
    tsBanrisul: TTabSheet;
    pnBanrisul: TPanel;
    lbBanrisulTipoChave: TLabel;
    lbBanrisulClientSecret: TLabel;
    lbBanrisulClientID: TLabel;
    lbBanrisulChave: TLabel;
    imBanrisulErroChavePix: TImage;
    lbBanrisulSenhaCertificado: TLabel;
    sbBanrisulVerSenhaPFX: TSpeedButton;
    sbBanrisulAcharCertificadoPFX: TSpeedButton;
    lbBanrisulArqCertificadoPFX: TLabel;
    lbBanrisulErroCertificadoPFX: TLabel;
    imBanrisulErroCertificadoPFX: TImage;
    edBanrisulClientSecret: TEdit;
    edBanrisulClientID: TEdit;
    edBanrisulChavePIX: TEdit;
    cbBanrisulTipoChave: TComboBox;
    edBanrisulSenhaCertificadoPFX: TEdit;
    edBanrisulArqCertificadoPFX: TEdit;
    tsC6Bank: TTabSheet;
    pnC6Bank: TPanel;
    lbC6BankTipoChave: TLabel;
    lbC6BankClientSecret: TLabel;
    lbC6BankClientID: TLabel;
    lbC6BankChave: TLabel;
    imC6BankErroChavePix: TImage;
    lbC6BankChavePrivada: TLabel;
    lbC6BankErroChavePrivada: TLabel;
    imC6BankErroChavePrivada: TImage;
    btC6BankAcharChavePrivada: TSpeedButton;
    btC6BankAcharCertificado: TSpeedButton;
    imC6BankErroCertificado: TImage;
    lbC6BankErroCertificado: TLabel;
    lbC6BankCertificado: TLabel;
    edC6BankClientSecret: TEdit;
    edC6BankClientID: TEdit;
    edC6BankChavePIX: TEdit;
    cbC6BankTipoChave: TComboBox;
    edC6BankChavePrivada: TEdit;
    edC6BankCertificado: TEdit;
    tsAppLess: TTabSheet;
    pnAppLess: TPanel;
    lbAppLessClientSecret: TLabel;
    lbAppLessClientId: TLabel;
    lbAppLessHMAC: TLabel;
    edAppLessClientSecret: TEdit;
    edAppLessClientId: TEdit;
    edAppLessHMAC: TEdit;
    tsQQPag: TTabSheet;
    pnQQPag: TPanel;
    lbQQPagTipoChave: TLabel;
    imQQPagErroChavePix: TImage;
    lbQQPagClientSecret: TLabel;
    lbQQPagClientID: TLabel;
    lbQQPagChave: TLabel;
    edQQPagChavePIX: TEdit;
    edQQPagClientID: TEdit;
    edQQPagClientSecret: TEdit;
    cbQQPagTipoChave: TComboBox;
    tsCrediSis: TTabSheet;
    pnCrediSis: TPanel;
    lbCrediSisTipoChave: TLabel;
    imCrediSisErroChavePix: TImage;
    lbCrediSisClientSecret: TLabel;
    lbCrediSisClientID: TLabel;
    lbCrediSisChavePIX: TLabel;
    lbCrediSisAgencia: TLabel;
    lbCrediSisConta: TLabel;
    edCrediSisChavePIX: TEdit;
    edCrediSisClientID: TEdit;
    edCrediSisClientSecret: TEdit;
    cbCrediSisTipoChave: TComboBox;
    edCrediSisAgencia: TEdit;
    edCrediSisConta: TEdit;
    ImageList1: TImageList;
    OpenDialog1: TOpenDialog;
    ACBrCEP1: TACBrCEP;
    ACBrOpenSSLUtils1: TACBrOpenSSLUtils;
    ACBrPixCD1: TACBrPixCD;
    ACBrPSPShipay1: TACBrPSPShipay;
    ACBrPSPBancoDoBrasil1: TACBrPSPBancoDoBrasil;
    ACBrPSPItau1: TACBrPSPItau;
    ACBrPSPSantander1: TACBrPSPSantander;
    ACBrPSPSicredi1: TACBrPSPSicredi;
    ACBrPSPSicoob1: TACBrPSPSicoob;
    ACBrPSPPagSeguro1: TACBrPSPPagSeguro;
    ACBrPSPGerenciaNet1: TACBrPSPGerenciaNet;
    ACBrPSPBradesco1: TACBrPSPBradesco;
    ACBrPSPPixPDV1: TACBrPSPPixPDV;
    ACBrPSPInter1: TACBrPSPInter;
    ACBrPSPAilos1: TACBrPSPAilos;
    ACBrPSPMatera1: TACBrPSPMatera;
    ACBrPSPCielo1: TACBrPSPCielo;
    ACBrPSPMercadoPago1: TACBrPSPMercadoPago;
    ACBrPSPGate2All1: TACBrPSPGate2All;
    ACBrPSPBanrisul1: TACBrPSPBanrisul;
    ACBrPSPC6Bank1: TACBrPSPC6Bank;
    ACBrPSPAppLess1: TACBrPSPAppLess;
    ACBrPSPQQPag1: TACBrPSPQQPag;
    ACBrPSPCrediSIS1: TACBrPSPCrediSIS;
    procedure rgBBTipoCertificadoClick(Sender: TObject);
    procedure rgBradescoTipoCertificadoClick(Sender: TObject);
    procedure sbArqLogClick(Sender: TObject);
    procedure sbBanrisulAcharCertificadoPFXClick(Sender: TObject);
    procedure sbBanrisulVerSenhaPFXClick(Sender: TObject);
    procedure sbBBAcharArqCertificadoClick(Sender: TObject);
    procedure sbBBAcharChavePrivadaClick(Sender: TObject);
    procedure sbBBAcharPFXClick(Sender: TObject);
    procedure sbBradescoAcharArqCertificadoClick(Sender: TObject);
    procedure sbBradescoAcharChavePrivadaClick(Sender: TObject);
    procedure sbBradescoAcharPFXClick(Sender: TObject);
    procedure sbCieloAcharArqCertificadoClick(Sender: TObject);
    procedure sbCieloAcharChavePrivadaClick(Sender: TObject);
    procedure sbConsultaCEPClick(Sender: TObject);
    procedure sbGerenciaNetAcharPFXClick(Sender: TObject);
    procedure sbItauAcharArqCertificadoClick(Sender: TObject);
    procedure sbItauAcharArqChavePrivadaClick(Sender: TObject);
    procedure sbPagSeguroAcharArqCertificadoClick(Sender: TObject);
    procedure sbPagSeguroAcharChavePrivadaClick(Sender: TObject);
    procedure sbSantanderExtrairCertificadoPFXClick(Sender: TObject);
    procedure sbSantanderAcharCertificadoPFXClick(Sender: TObject);
    procedure sbSantanderExtrairCertificadoInfoClick(Sender: TObject);
    procedure sbSantanderExtrairCertificadoVerSenhaPFXClick(Sender: TObject);
    procedure sbBradescoVerSenhaPFXClick(Sender: TObject);
    procedure sbSantanderVerSenhaPFXClick(Sender: TObject);
    procedure sbSicoobAcharArqCertificadoClick(Sender: TObject);
    procedure sbSicoobAcharChavePrivadaClick(Sender: TObject);
    procedure sbSicrediAcharArqCertificadoClick(Sender: TObject);
    procedure sbSicrediAcharChavePrivadaClick(Sender: TObject);
    procedure sbVerSenhaProxyClick(Sender: TObject);
    procedure tsSicrediGerarChaveCSRShow(Sender: TObject);
    procedure edtRecebedorCEPChange(Sender: TObject);
    procedure ACBrPixCD1QuandoGravarLog(const ALogLine: String; var Tratado: Boolean);
    procedure ACBrPixCD1QuandoAlterarPSP(Sender: TObject);
    procedure ACBrPSPBancoDoBrasil1PrecisaAutenticar(var aToken: String; var aValidadeToken: TDateTime);
    procedure ACBrPSPBancoDoBrasil1QuandoReceberRespostaHttp( const AURL: String; const AMethod: String; RespHeaders: TStrings; var AResultCode: Integer; var RespostaHttp: AnsiString);
    procedure btAilosAcharCertificadoClick(Sender: TObject);
    procedure btAilosAcharCertificadoRootClick(Sender: TObject);
    procedure btAilosAcharchavePrivadaClick(Sender: TObject);
    procedure btBBConfigTokenManualGerarClick(Sender: TObject);
    procedure btBBVerSenhaPFXClick(Sender: TObject);
    procedure btC6BankAcharCertificadoClick(Sender: TObject);
    procedure btC6BankAcharChavePrivadaClick(Sender: TObject);
    procedure btInterAcharCertificadoClick(Sender: TObject);
    procedure btInterAcharChavePrivadaClick(Sender: TObject);
    procedure btMateraAcharArqCertificadoClick(Sender: TObject);
    procedure btMateraAcharChavePrivadaClick(Sender: TObject);
    procedure btPagSeguroCertificadoGerarClick(Sender: TObject);
    procedure btPagSeguroChallengeDecriptClick(Sender: TObject);
    procedure btPagSeguroChallengeSolicClick(Sender: TObject);
    procedure btPagSeguroGerarChavesClick(Sender: TObject);
    procedure btPagSeguroGerarClientsClick(Sender: TObject);
    procedure btSantanderExtrairPEMClick(Sender: TObject);
    procedure btItauGerarChavePrivadaClick(Sender: TObject);
    procedure btItauRenovarCertificadoClick(Sender: TObject);
    procedure btItauSolicitarCertificadoClick(Sender: TObject);
    procedure btItauValidarChaveCertificadoClick(Sender: TObject);
    procedure btLerParametrosClick(Sender: TObject);
    procedure btSalvarParametrosClick(Sender: TObject);
    procedure btSicoobExtrairChaveCertificadoArqPFXClick(Sender: TObject);
    procedure btSicoobExtrairChaveCertificadoClick(Sender: TObject);
    procedure btSicoobExtrairChaveCertificadoInfoClick(Sender: TObject);
    procedure btSicoobExtrairChaveCertificadoVerSenhaPFXClick(Sender: TObject);
    procedure btSicrediGerarChaveCertificadoInfoClick(Sender: TObject);
    procedure btSicrediGerarChavePrivadaClick(Sender: TObject);
    procedure btSicrediGerarCSRClick(Sender: TObject);
    procedure btSicrediSenhaChavePrivadaClick(Sender: TObject);
    procedure cbBBConfigTokenManualClick(Sender: TObject);
    procedure cbBBVersaoAPIChange(Sender: TObject);
    procedure cbxAmbienteChange(Sender: TObject);
    procedure cbxPSPAtualChange(Sender: TObject);
    procedure edAilosArqsChange(Sender: TObject);
    procedure edAilosCertificadoExit(Sender: TObject);
    procedure edAilosCertificadoRootExit(Sender: TObject);
    procedure edAilosChavePIXChange(Sender: TObject);
    procedure edAilosChavePrivadaExit(Sender: TObject);
    procedure edBanrisulArqCertificadoPFXChange(Sender: TObject);
    procedure edBanrisulArqCertificadoPFXExit(Sender: TObject);
    procedure edBanrisulChavePIXChange(Sender: TObject);
    procedure edBanrisulSenhaCertificadoPFXExit(Sender: TObject);
    procedure edBBArqPFXChange(Sender: TObject);
    procedure edBBArqPFXExit(Sender: TObject);
    procedure edBBArqsChange(Sender: TObject);
    procedure edBBArqCertificadoExit(Sender: TObject);
    procedure edBBArqChavePrivadaExit(Sender: TObject);
    procedure edBBSenhaPFXExit(Sender: TObject);
    procedure edBradescoArqCertificadoExit(Sender: TObject);
    procedure edBradescoArqsChange(Sender: TObject);
    procedure edBradescoArqChavePrivadaExit(Sender: TObject);
    procedure edBradescoArqPFXChange(Sender: TObject);
    procedure edBradescoValidarPFXExit(Sender: TObject);
    procedure edBradescoChavePIXChange(Sender: TObject);
    procedure edC6BankCertificadoExit(Sender: TObject);
    procedure edC6BankChavePIXChange(Sender: TObject);
    procedure edC6BankArqsChange(Sender: TObject);
    procedure edC6BankChavePrivadaExit(Sender: TObject);
    procedure edCieloArqCertificadoChange(Sender: TObject);
    procedure edCieloArqCertificadoExit(Sender: TObject);
    procedure edCieloArqChavePrivadaChange(Sender: TObject);
    procedure edCieloArqChavePrivadaExit(Sender: TObject);
    procedure edCieloChavePIXChange(Sender: TObject);
    procedure edCrediSisChavePIXChange(Sender: TObject);
    procedure edGerenciaNetChavePIXChange(Sender: TObject);
    procedure edGerenciaNetArqPFXExit(Sender: TObject);
    procedure edGerenciaNetArqPFXChange(Sender: TObject);
    procedure edPagSeguroArqCertificadoExit(Sender: TObject);
    procedure edPagSeguroArqsChange(Sender: TObject);
    procedure edPagSeguroArqChavePrivadaExit(Sender: TObject);
    procedure edPagSeguroChavePIXChange(Sender: TObject);
    procedure edQQPagChavePIXChange(Sender: TObject);
    procedure edSantanderArqCertificadoPFXChange(Sender: TObject);
    procedure edSicoobArqCertificadoExit(Sender: TObject);
    procedure edSicoobArqChavePrivadaExit(Sender: TObject);
    procedure edSicoobArqsChange(Sender: TObject);
    procedure edSicoobChavePIXChange(Sender: TObject);
    procedure edSicrediArqCertificadoExit(Sender: TObject);
    procedure edSicrediArqChavePrivadaExit(Sender: TObject);
    procedure edtRecebedorCEPExit(Sender: TObject);
    procedure edGerenciaNetArqCertificadoChange(Sender: TObject);
    procedure edInterCertificadoExit(Sender: TObject);
    procedure edInterChavePIXChange(Sender: TObject);
    procedure edInterArqsChange(Sender: TObject);
    procedure edInterChavePrivadaExit(Sender: TObject);
    procedure edMateraArqCertificadoExit(Sender: TObject);
    procedure edMateraArqChavePrivadaExit(Sender: TObject);
    procedure edMercadoPagoChavePIXChange(Sender: TObject);
    procedure edOnlyNumbersKeyPress(Sender: TObject; var Key: char);
    procedure edtItauArqChavePrivadaChange(Sender: TObject);
    procedure edtBBChavePIXChange(Sender: TObject);
    procedure edtItauChavePIXChange(Sender: TObject);
    procedure edtItauClientIDChange(Sender: TObject);
    procedure edtItauClientSecretChange(Sender: TObject);
    procedure edtRecebedorNomeChange(Sender: TObject);
    procedure edSantanderChavePIXChange(Sender: TObject);
    procedure edSicrediArqsChange(Sender: TObject);
    procedure edSicrediChavePIXChange(Sender: TObject);
    procedure pgPSPItauChaveCertificadoChange(Sender: TObject);
    procedure LigarAlertasdeErrosDeConfiguracao;
    procedure LigarAlertasdeErrosDeConfiguracaoPIXCD;
    procedure LigarAlertasdeErrosDeConfiguracaoPSPItau;
    procedure LigarAlertasdeErrosDeConfiguracaoPSPSicoob;
    procedure LigarAlertasdeErrosDeConfiguracaoPSPSicredi;
    procedure LigarAlertasdeErrosDeConfiguracaoPSPSantander;
    procedure LigarAlertasdeErrosDeConfiguracaoPSPGerenciaNet;
    procedure LigarAlertasdeErrosDeConfiguracaoPSPPagSeguro;
    procedure LigarAlertasdeErrosDeConfiguracaoPSPInter;
    procedure LigarAlertasdeErrosDeConfiguracaoPSPAilos;
    procedure LigarAlertasdeErrosDeConfiguracaoPSPBB;
    procedure LigarAlertasdeErrosDeConfiguracaoPSPBanrisul;
    procedure LigarAlertasdeErrosDeConfiguracaoPSPC6Bank;
    procedure VerificarConfiguracao;
    procedure VerificarConfiguracaoPSPItau;
    procedure ValidarChaveCertificadoPSPItau;
    procedure ValidarChavePSPSicredi;
    procedure ValidarChavePSPCielo;
    procedure ValidarChavePSPSicoob;
    procedure ValidarChavePSPPagSeguro;
    procedure ValidarChavePSPInter;
    procedure ValidarChavePSPAilos;
    procedure ValidarChavePSPBB;
    procedure ValidarChavePSPMatera;
    procedure ValidarChavePSPC6Bank;
    procedure ValidarChavePSPBradesco;
    procedure ValidarCertificadoPSPSicoob;
    procedure ValidarCertificadoPSPSicredi;
    procedure ValidarCertificadoPSPCielo;
    procedure ValidarCertificadoPSPSantander;
    procedure ValidarCertificadoPSPPagSeguro;
    procedure ValidarCertificadoPSPGerenciaNet;
    procedure ValidarCertificadoPSPBradesco;
    procedure ValidarCertificadoPSPInter;
    procedure ValidarCertificadoPSPAilos;
    procedure ValidarCertificadoRootPSPAilos;
    procedure ValidarCertificadoPSPMatera;
    procedure ValidarCertificadoPSPBB;
    procedure ValidarCertificadoPSPC6Bank;
    procedure ValidarPFXPSPBB;
    procedure ValidarPFXBanrisul;
    procedure ValidarPFXBradesco;
    procedure ValidarChavePSPItau;
    procedure ValidarCertificadoPSPItau;
    procedure LerConfiguracao;
    procedure GravarConfiguracao;
    procedure AplicarConfiguracao;
    procedure InicializarBitmaps;
    procedure ConfigurarACBrPIXCD;
    procedure ConfigurarACBrPSPs;
    function RemoverPathAplicacao(const AFileName: String): String;
    function AdicionarPathAplicacao(const AFileName: String): String;
    procedure DoAntesAutenticar(var aToken: String; var aValidadeToken: TDateTime);
    procedure DoDepoisAutenticar(const aToken: String; const aValidadeToken: TDateTime);
    procedure btnSalvarClick(Sender: TObject);
  private
    FOnFechar: TNotifyEvent;
    fTokenBB: String;
    fValidadeTokenBB: TDateTime;
    function GetNomeArquivoConfiguracao: String;
    procedure InicializarActivePages;
    procedure InicializarComponentesDefault;
    procedure AdicionarLinhaLog(AMensagem: String);
    procedure VerificarConfiguracaoPIXCD;
  public
    constructor Create(AOwner: TComponent); override;

    property NomeArquivoConfiguracao: String read GetNomeArquivoConfiguracao;
    property OnFechar: TNotifyEvent read FOnFechar write FOnFechar;
  end;

implementation

uses
  {$IFDEF DELPHIXE6_UP}JSON,
  {$IFNDEF DELPHIRIO_UP}REST.Json,{$ENDIF}
  {$ENDIF}
  TypInfo, Clipbrd, IniFiles, DateUtils, synacode, synautil,
  ACBrDelphiZXingQRCode, ACBrImage, ACBrValidador, ACBrPIXUtil, ACBrConsts,
  ACBrPIXSchemasCobV, ACBrPIXSchemasCobR, OpenSSLExt,
  ACBrJSON,
  ACBrDFe.Conversao,
  ACBrUtil.Base,
  ACBrUtil.FilesIO,
  ACBrUtil.Strings,
  ACBrUtil.DateTime,
  ACBrUtil.Compatibilidade;

const
  CURL_ACBR = 'https://projetoacbr.com.br/tef/';

{$R *.dfm}

{ TframeConfigPIX }

constructor TframeConfigPIX.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  // Igual ao FormCreate do exemplo (só a parte de configuração)
  InicializarBitmaps;
  InicializarActivePages;
  InicializarComponentesDefault;
  LerConfiguracao;
end;

function TframeConfigPIX.GetNomeArquivoConfiguracao: String;
begin
  // Mesmo INI do programa (NFC-e, TEF e PIX)
  Result := ChangeFileExt(Application.ExeName, '.ini');
end;

procedure TframeConfigPIX.btnSalvarClick(Sender: TObject);
begin
  btSalvarParametrosClick(Sender);   // GravarConfiguracao + AplicarConfiguracao
  if Assigned(FOnFechar) then
    FOnFechar(Self);
end;

procedure TframeConfigPIX.AdicionarLinhaLog(AMensagem: String);
begin
  if Assigned(mLog) then
    mLog.Lines.Add(AMensagem);
end;

procedure TframeConfigPIX.VerificarConfiguracaoPIXCD;
begin
  if imgErrNome.Visible or imgErrCEP.Visible or imgErrPSP.Visible then
  begin
    pgConfPixPSP.ActivePageIndex := 0;
    MessageDlg('Favor configurar os campos sinalizados', mtWarning, [mbOK], 0);
    Abort;
  end;
end;

procedure TframeConfigPIX.InicializarActivePages;
begin
  pgConfPixPSP.ActivePageIndex := 0;
  pgPSPs.ActivePageIndex := 0;
  pgPSPItau.ActivePageIndex := 0;
  pgPSPItauChaveCertificado.ActivePageIndex := 0;
  pgPSPItauGerarChaveCertificado.ActivePageIndex := 0;
  pgPagSeguro.ActivePageIndex := 0;
  pgPagSeguroGerarCredenciais.ActivePageIndex := 0;
end;

// Igual ao InicializarComponentesDefault do exemplo, só com os controles
// da configuração (as demais abas do exemplo não existem aqui)
procedure TframeConfigPIX.InicializarComponentesDefault;
var
  i: Integer;
  j: TACBrPixCDAmbiente;
  k: TACBrPIXTipoChave;
  q: TACBrBBAPIVersao;
  w: TACBrPIXPDVAPIVersao;
  x: TACBrBradescoAPIVersao;
begin
  cbxPSPAtual.Items.Clear;
  for i := 0 to pgPSPs.PageCount-1 do
     cbxPSPAtual.Items.Add( pgPSPs.Pages[i].Caption );

  cbxRecebedorUF.Items.Clear;
  for i := Low(DFeUF) to High(DFeUF) do
     cbxRecebedorUF.Items.Add( DFeUF[i] );

  cbxAmbiente.Items.Clear;
  for j := Low(TACBrPixCDAmbiente) to High(TACBrPixCDAmbiente) do
     cbxAmbiente.Items.Add( GetEnumName(TypeInfo(TACBrPixCDAmbiente), integer(j) ));

  cbxBBTipoChave.Items.Clear;
  for k := Low(TACBrPIXTipoChave) to High(TACBrPIXTipoChave) do
     cbxBBTipoChave.Items.Add( GetEnumName(TypeInfo(TACBrPIXTipoChave), integer(k) ));
  cbxItauTipoChave.Items.Assign(cbxBBTipoChave.Items);
  cbSantanderTipoChave.Items.Assign(cbxBBTipoChave.Items);
  cbSicrediTipoChave.Items.Assign(cbxBBTipoChave.Items);
  cbSicoobTipoChave.Items.Assign(cbxBBTipoChave.Items);
  cbPagSeguroTipoChave.Items.Assign(cbxBBTipoChave.Items);
  cbGerenciaNetTipoChave.Items.Assign(cbxBBTipoChave.Items);
  cbBradescoTipoChave.Items.Assign(cbxBBTipoChave.Items);
  cbInterTipoChave.Items.Assign(cbxBBTipoChave.Items);
  cbAilosTipoChave.Items.Assign(cbxBBTipoChave.Items);
  cbCieloTipoChave.Items.Assign(cbxBBTipoChave.Items);
  cbBanrisulTipoChave.Items.Assign(cbxBBTipoChave.Items);
  cbC6BankTipoChave.Items.Assign(cbxBBTipoChave.Items);
  cbMercadoPagoTipoChave.Items.Assign(cbxBBTipoChave.Items);
  cbQQPagTipoChave.Items.Assign(cbxBBTipoChave.Items);
  cbCrediSisTipoChave.Items.Assign(cbxBBTipoChave.Items);

  cbBBVersaoAPI.Items.Clear;
  for q := Low(TACBrBBAPIVersao) to High(TACBrBBAPIVersao) do
    cbBBVersaoAPI.Items.Add(GetEnumName(TypeInfo(TACBrBBAPIVersao), Integer(q)));
  cbBBVersaoAPI.ItemIndex := 0;
  cbBBVersaoAPIChange(Nil);

  cbPIXPDVVersaoAPI.Items.Clear;
  for w := Low(TACBrPIXPDVAPIVersao) to High(TACBrPIXPDVAPIVersao) do
    cbPIXPDVVersaoAPI.Items.Add(GetEnumName(TypeInfo(TACBrPIXPDVAPIVersao), Integer(w)));
  cbPIXPDVVersaoAPI.ItemIndex := 0;

  cbBradescoAPIVersao.Items.Clear;
  for x := Low(TACBrBradescoAPIVersao) to High(TACBrBradescoAPIVersao) do
    cbBradescoAPIVersao.Items.Add(GetEnumName(TypeInfo(TACBrBradescoAPIVersao), Integer(x)));
  cbBradescoAPIVersao.ItemIndex := 0;

  pnBBPFX.Parent := pnBBCertificados;
  pnBBChaveECert.Parent := pnBBCertificados;
  pnBradescoPFX.Parent := pnBradescoCertificados;
  pnBradescoChaveECert.Parent := pnBradescoCertificados;
  cbBBConfigTokenManual.Top := -2;
  {$IfDef DELPHIX_ALEXANDRIA_UP}edBBConfigTokenValidade.Kind := dtkDateTime;{$EndIf}

  fTokenBB := EmptyStr;
  fValidadeTokenBB := 0;
end;

{ ------------- Daqui para baixo: código do exemplo do ACBrPIXCD ------------- }

procedure TframeConfigPIX.rgBBTipoCertificadoClick(Sender: TObject);
begin
  pnBBPFX.Visible := (rgBBTipoCertificado.ItemIndex = 0);
  pnBBChaveECert.Visible := (rgBBTipoCertificado.ItemIndex = 1);
end;

procedure TframeConfigPIX.rgBradescoTipoCertificadoClick(Sender: TObject);
begin 
  pnBradescoPFX.Visible := (rgBradescoTipoCertificado.ItemIndex = 0);
  pnBradescoChaveECert.Visible := (rgBradescoTipoCertificado.ItemIndex = 1);
end;

procedure TframeConfigPIX.sbArqLogClick(Sender: TObject);
var
  AFileLog: String;
begin
  if (Trim(edtArqLog.Text) = '') then
  begin
    MessageDlg(ACBrStr('Arquivo de Log não informado'), mtError, [mbOK], 0);
    Exit;
  end;

  if pos(PathDelim,edtArqLog.Text) = 0 then
    AFileLog := ApplicationPath + edtArqLog.Text
  else
    AFileLog := edtArqLog.Text;

  if not FileExists(AFileLog) then
    MessageDlg(ACBrStr('Arquivo '+AFileLog+' não encontrado'), mtError, [mbOK], 0)
  else
    OpenURL(AFileLog);
end;

procedure TframeConfigPIX.sbBanrisulAcharCertificadoPFXClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
    edBanrisulArqCertificadoPFX.Text := RemoverPathAplicacao(OpenDialog1.FileName);
  ValidarPFXBanrisul;
end;

procedure TframeConfigPIX.sbBanrisulVerSenhaPFXClick(Sender: TObject);
begin
  {$IfDef FPC}
  if sbBanrisulVerSenhaPFX.Down then
    edBanrisulSenhaCertificadoPFX.EchoMode := emNormal
  else
    edBanrisulSenhaCertificadoPFX.EchoMode := emPassword;
  {$Else}
  if sbBanrisulVerSenhaPFX.Down then
    edBanrisulSenhaCertificadoPFX.PasswordChar := #0
  else
    edBanrisulSenhaCertificadoPFX.PasswordChar := '*';
  {$EndIf}
end;

procedure TframeConfigPIX.sbBBAcharArqCertificadoClick(Sender: TObject);
begin
  OpenDialog1.FileName := edBBArqCertificado.Text;
  if OpenDialog1.Execute then
    edBBArqCertificado.Text := RemoverPathAplicacao(OpenDialog1.FileName);
  ValidarCertificadoPSPBB;
end;

procedure TframeConfigPIX.sbBBAcharChavePrivadaClick(Sender: TObject);
begin
  OpenDialog1.FileName := edBBArqChavePrivada.Text;
  if OpenDialog1.Execute then
    edBBArqChavePrivada.Text := RemoverPathAplicacao(OpenDialog1.FileName);
  ValidarChavePSPBB;
end;

procedure TframeConfigPIX.sbBBAcharPFXClick(Sender: TObject);
begin
  OpenDialog1.FileName := edBBArqPFX.Text;
  if OpenDialog1.Execute then
    edBBArqPFX.Text := RemoverPathAplicacao(OpenDialog1.FileName);
  ValidarPFXPSPBB;
end;

procedure TframeConfigPIX.sbBradescoAcharArqCertificadoClick(Sender: TObject);
begin
  OpenDialog1.FileName := edBradescoArqCertificado.Text;
  if OpenDialog1.Execute then
    edBradescoArqCertificado.Text := RemoverPathAplicacao(OpenDialog1.FileName);
  ValidarCertificadoPSPBradesco;
end;

procedure TframeConfigPIX.sbBradescoAcharChavePrivadaClick(Sender: TObject);
begin
  OpenDialog1.FileName := edBradescoArqChavePrivada.Text;
  if OpenDialog1.Execute then
    edBradescoArqChavePrivada.Text := RemoverPathAplicacao(OpenDialog1.FileName);
  ValidarChavePSPBradesco;
end;

procedure TframeConfigPIX.sbBradescoAcharPFXClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
    edBradescoArqPFX.Text := RemoverPathAplicacao(OpenDialog1.FileName);
  ValidarPFXBradesco;
end;

procedure TframeConfigPIX.sbCieloAcharArqCertificadoClick(Sender: TObject);
begin
  OpenDialog1.FileName := edCieloArqCertificado.Text;
  if OpenDialog1.Execute then
    edCieloArqCertificado.Text := RemoverPathAplicacao(OpenDialog1.FileName);
  ValidarCertificadoPSPCielo;
end;

procedure TframeConfigPIX.sbCieloAcharChavePrivadaClick(Sender: TObject);
begin
  OpenDialog1.FileName := edCieloArqChavePrivada.Text;
  if OpenDialog1.Execute then
    edCieloArqChavePrivada.Text := RemoverPathAplicacao(OpenDialog1.FileName);
  ValidarChavePSPCielo;
end;

procedure TframeConfigPIX.sbConsultaCEPClick(Sender: TObject);
var
  EndAchado: TACBrCEPEndereco;
begin
  try
    ACBrCEP1.BuscarPorCEP(OnlyNumber(edtRecebedorCEP.Text));
    if (ACBrCEP1.Enderecos.Count > 0) then
    begin
      EndAchado := ACBrCEP1.Enderecos[0];
      edtRecebedorCidade.Text := EndAchado.Municipio;
      cbxRecebedorUF.ItemIndex := cbxRecebedorUF.Items.IndexOf(EndAchado.UF);
    end;
  except
    MessageDlg('Erro ao executar Consulta do CEP', mtError, [mbOK], 0);
  end;
end;

procedure TframeConfigPIX.sbGerenciaNetAcharPFXClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
    edGerenciaNetArqPFX.Text := RemoverPathAplicacao(OpenDialog1.FileName);
  ValidarCertificadoPSPGerenciaNet;
end;

procedure TframeConfigPIX.sbItauAcharArqCertificadoClick(Sender: TObject);
begin
  OpenDialog1.FileName := edtItauArqCertificado.Text;
  if OpenDialog1.Execute then
    edtItauArqCertificado.Text := RemoverPathAplicacao(OpenDialog1.FileName);
  ValidarCertificadoPSPItau;
end;

procedure TframeConfigPIX.sbItauAcharArqChavePrivadaClick(Sender: TObject);
begin
  OpenDialog1.FileName := edtItauArqChavePrivada.Text;
  if OpenDialog1.Execute then
    edtItauArqChavePrivada.Text := RemoverPathAplicacao(OpenDialog1.FileName);
  ValidarChavePSPItau;
end;

procedure TframeConfigPIX.sbPagSeguroAcharArqCertificadoClick(Sender: TObject);
begin
  OpenDialog1.FileName := edPagSeguroArqCertificado.Text;
  if OpenDialog1.Execute then
    edPagSeguroArqCertificado.Text := RemoverPathAplicacao(OpenDialog1.FileName);
  ValidarCertificadoPSPPagSeguro;
end;

procedure TframeConfigPIX.sbPagSeguroAcharChavePrivadaClick(Sender: TObject);
begin
  OpenDialog1.FileName := edPagSeguroArqChavePrivada.Text;
  if OpenDialog1.Execute then
    edPagSeguroArqChavePrivada.Text := RemoverPathAplicacao(OpenDialog1.FileName);
  ValidarChavePSPPagSeguro;
end;

procedure TframeConfigPIX.sbSantanderExtrairCertificadoPFXClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
    edSantanderExtrairCertificadoPFX.Text := RemoverPathAplicacao(OpenDialog1.FileName);
end;

procedure TframeConfigPIX.sbSantanderAcharCertificadoPFXClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
    edSantanderArqCertificadoPFX.Text := RemoverPathAplicacao(OpenDialog1.FileName);
  ValidarCertificadoPSPSantander;
end;

procedure TframeConfigPIX.sbSantanderExtrairCertificadoInfoClick(Sender: TObject);
begin
  MessageDlg(ACBrStr('PSP Santander solicita um arquivo em formato PEM para ' +
    'disponibilizar as credenciais Consumer Key e Consumer Secret.' + sLineBreak +
    'Após a geração do certificado PEM a liberação das credenciais deve ser ' +
    'feita no Internet Banking Santander!'), mtInformation, [mbOK], 0);
end;

procedure TframeConfigPIX.sbSantanderExtrairCertificadoVerSenhaPFXClick(Sender: TObject);
begin
  {$IfDef FPC}
  if sbSantanderExtrairCertificadoVerSenhaPFX.Down then
    edSantanderExtrairCertificadoSenhaPFX.EchoMode := emNormal
  else
    edSantanderExtrairCertificadoSenhaPFX.EchoMode := emPassword;
  {$Else}
  if sbSantanderExtrairCertificadoVerSenhaPFX.Down then
    edSantanderExtrairCertificadoSenhaPFX.PasswordChar := #0
  else
    edSantanderExtrairCertificadoSenhaPFX.PasswordChar := '*';
  {$EndIf}
end;

procedure TframeConfigPIX.sbBradescoVerSenhaPFXClick(Sender: TObject);
begin
  {$IfDef FPC}
  if sbBradescoVerSenhaPFX.Down then
    edBradescoSenhaPFX.EchoMode := emNormal
  else
    edBradescoSenhaPFX.EchoMode := emPassword;
  {$Else}
  if sbBradescoVerSenhaPFX.Down then
    edBradescoSenhaPFX.PasswordChar := #0
  else
    edBradescoSenhaPFX.PasswordChar := '*';
  {$EndIf}
end;

procedure TframeConfigPIX.sbSantanderVerSenhaPFXClick(Sender: TObject);
begin
  {$IfDef FPC}
  if sbSantanderVerSenhaPFX.Down then
    edSantanderSenhaCertificadoPFX.EchoMode := emNormal
  else
    edSantanderSenhaCertificadoPFX.EchoMode := emPassword;
  {$Else}
  if sbSantanderVerSenhaPFX.Down then
    edSantanderSenhaCertificadoPFX.PasswordChar := #0
  else
    edSantanderSenhaCertificadoPFX.PasswordChar := '*';
  {$EndIf}
end;

procedure TframeConfigPIX.sbSicoobAcharArqCertificadoClick(Sender: TObject);
begin
  OpenDialog1.FileName := edSicoobArqCertificado.Text;
  if OpenDialog1.Execute then
    edSicoobArqCertificado.Text := RemoverPathAplicacao(OpenDialog1.FileName);
  ValidarCertificadoPSPSicoob;
end;

procedure TframeConfigPIX.sbSicoobAcharChavePrivadaClick(Sender: TObject);
begin
  OpenDialog1.FileName := edSicoobArqChavePrivada.Text;
  if OpenDialog1.Execute then
    edSicoobArqChavePrivada.Text := RemoverPathAplicacao(OpenDialog1.FileName);
  ValidarChavePSPSicoob;
end;

procedure TframeConfigPIX.sbSicrediAcharArqCertificadoClick(Sender: TObject);
begin
  OpenDialog1.FileName := edSicrediArqCertificado.Text;
  if OpenDialog1.Execute then
    edSicrediArqCertificado.Text := RemoverPathAplicacao(OpenDialog1.FileName);
  ValidarCertificadoPSPSicredi;
end;

procedure TframeConfigPIX.sbSicrediAcharChavePrivadaClick(Sender: TObject);
begin
  OpenDialog1.FileName := edSicrediArqChavePrivada.Text;
  if OpenDialog1.Execute then
  begin
    edSicrediArqChavePrivada.Text := RemoverPathAplicacao(OpenDialog1.FileName);
    edSicrediGerarChavePrivada.Text := edSicrediArqChavePrivada.Text;
    mmSicrediGerarChavePrivada.Lines.LoadFromFile(OpenDialog1.FileName);
  end;
  ValidarChavePSPSicredi;
end;

procedure TframeConfigPIX.sbVerSenhaProxyClick(Sender: TObject);
begin
  {$IfDef FPC}
  if sbVerSenhaProxy.Down then
    edtProxySenha.EchoMode := emNormal
  else
    edtProxySenha.EchoMode := emPassword;
  {$Else}
  if sbVerSenhaProxy.Down then
    edtProxySenha.PasswordChar := #0
  else
    edtProxySenha.PasswordChar := '*';
  {$EndIf}
end;

procedure TframeConfigPIX.tsSicrediGerarChaveCSRShow(Sender: TObject);
var
  wSL: TStringList;
begin
  wSL := TStringList.Create;
  try
    if FileExists(edSicrediGerarChavePrivada.Text) then
    begin
      wSL.LoadFromFile(edSicrediGerarChavePrivada.Text);
      mmSicrediGerarChavePrivada.Text := wSL.Text;
    end;

    if FileExists(edSicrediGerarCSR.Text) then
    begin
      wSL.LoadFromFile(edSicrediGerarCSR.Text);
      mmSicrediGerarCSR.Text := wSL.Text;
    end;
  finally
    wSL.Free;
  end;
end;

procedure TframeConfigPIX.edtRecebedorCEPChange(Sender: TObject);
begin
  if (Length(edtRecebedorCEP.Text) > 5) then
  begin
    edtRecebedorCEP.Text := FormatarMascaraDinamica(OnlyNumber(edtRecebedorCEP.Text), '*****-***');
    edtRecebedorCEP.SelStart := Length(edtRecebedorCEP.Text);
  end;

  imgErrCEP.Visible := (Length(edtRecebedorCEP.Text) < 9);
  sbConsultaCEP.Visible := not imgErrCEP.Visible;
end;

procedure TframeConfigPIX.ACBrPixCD1QuandoGravarLog(const ALogLine: String; var Tratado: Boolean);
begin
  AdicionarLinhaLog(ALogLine);
  Tratado := False;
end;

procedure TframeConfigPIX.ACBrPixCD1QuandoAlterarPSP(Sender: TObject);
begin
  fTokenBB := EmptyStr;
  fValidadeTokenBB := 0;
end;

procedure TframeConfigPIX.ACBrPSPBancoDoBrasil1PrecisaAutenticar(var aToken: String; var aValidadeToken: TDateTime);
begin
  if ACBrPSPBancoDoBrasil1.GerarToken(fTokenBB, fValidadeTokenBB) then
  begin
    aToken := fTokenBB;
    aValidadeToken := fValidadeTokenBB;
  end
  else
    ShowMessage('Erro ao gerar Token');
end;

procedure TframeConfigPIX.ACBrPSPBancoDoBrasil1QuandoReceberRespostaHttp(
  const AURL: String; const AMethod: String; RespHeaders: TStrings;
  var AResultCode: Integer; var RespostaHttp: AnsiString);
var
  jsRet, js: TACBrJSONObject;
  ja, jsArr: TACBrJSONArray;
  I: Integer;

  function GetDetalhesPagador(aJson: TACBrJSONObject): String;
  var
    jPag: TACBrJSONObject;
  begin
    jPag := aJson.AsJSONObject['pagador'];
    if Assigned(jPag) then
      Result := aJson.AsString['infoPagador'] + ' ' + jPag.AsString['cpf'] +
        jPag.AsString['cnpj'] + ' - ' + jPag.AsString['nome'];
  end;

begin
  if (AMethod = ChttpMethodGET) and (AResultCode = HTTP_OK) and (Pos(cEndPointPix, AURL) > 0) then
  begin
    jsRet := TACBrJSONObject.Parse(String(RespostaHttp));
    jsArr :=  jsRet.AsJSONArray['pix'];
    try
      if Assigned(jsArr) and (jsArr.Count > 0) then
      begin
        ja := TACBrJSONArray.Create;

        for i := 0 to jsArr.Count - 1 do
        begin
          js := jsArr.ItemAsJSONObject[i];
          js.AddPair('infoPagador', GetDetalhesPagador(js));
          ja.AddElementJSONString(js.ToJSON);
        end;
        jsRet.AddPair('pix', ja);
      end
      else
        jsRet.AddPair('infoPagador', GetDetalhesPagador(jsRet));

      RespostaHttp := jsRet.ToJSON;
    finally
      jsRet.Free;
    end;
  end;
end;

procedure TframeConfigPIX.btAilosAcharCertificadoClick(Sender: TObject);
begin
  OpenDialog1.FileName := edAilosCertificado.Text;
  if OpenDialog1.Execute then
    edAilosCertificado.Text := RemoverPathAplicacao(OpenDialog1.FileName);
  ValidarCertificadoPSPAilos;
end;

procedure TframeConfigPIX.btAilosAcharCertificadoRootClick(Sender: TObject);
begin
  OpenDialog1.FileName := edAilosCertificadoRoot.Text;
  if OpenDialog1.Execute then
    edAilosCertificadoRoot.Text := RemoverPathAplicacao(OpenDialog1.FileName);
  ValidarCertificadoPSPAilos;
end;

procedure TframeConfigPIX.btAilosAcharchavePrivadaClick(Sender: TObject);
begin
  OpenDialog1.FileName := edAilosChavePrivada.Text;
  if OpenDialog1.Execute then
    edAilosChavePrivada.Text := RemoverPathAplicacao(OpenDialog1.FileName);
  ValidarChavePSPAilos;
end;

procedure TframeConfigPIX.btBBConfigTokenManualGerarClick(Sender: TObject);
begin
  if ACBrPSPBancoDoBrasil1.GerarToken(fTokenBB, fValidadeTokenBB) then
  begin
    mmBBConfigTokenManual.Lines.Text := fTokenBB;
    edBBConfigTokenValidade.DateTime := fValidadeTokenBB;
  end
  else
    ShowMessage('Erro ao gerar Token');
end;

procedure TframeConfigPIX.btBBVerSenhaPFXClick(Sender: TObject);
begin
  {$IfDef FPC}
  if btBBVerSenhaPFX.Down then
    edBBSenhaPFX.EchoMode := emNormal
  else
    edBBSenhaPFX.EchoMode := emPassword;
  {$Else}
  if btBBVerSenhaPFX.Down then
    edBBSenhaPFX.PasswordChar := #0
  else
    edBBSenhaPFX.PasswordChar := '*';
  {$EndIf}
end;

procedure TframeConfigPIX.btC6BankAcharCertificadoClick(Sender: TObject);
begin
  OpenDialog1.FileName := edC6BankCertificado.Text;
  if OpenDialog1.Execute then
    edC6BankCertificado.Text := RemoverPathAplicacao(OpenDialog1.FileName);
  ValidarCertificadoPSPC6Bank;
end;

procedure TframeConfigPIX.btC6BankAcharChavePrivadaClick(Sender: TObject);
begin
  OpenDialog1.FileName := edC6BankChavePrivada.Text;
  if OpenDialog1.Execute then
    edC6BankChavePrivada.Text := RemoverPathAplicacao(OpenDialog1.FileName);
  ValidarChavePSPC6Bank;
end;

procedure TframeConfigPIX.btInterAcharCertificadoClick(Sender: TObject);
begin
  OpenDialog1.FileName := edInterCertificado.Text;
  if OpenDialog1.Execute then
    edInterCertificado.Text := RemoverPathAplicacao(OpenDialog1.FileName);
  ValidarCertificadoPSPInter;
end;

procedure TframeConfigPIX.btInterAcharChavePrivadaClick(Sender: TObject);
begin
  OpenDialog1.FileName := edInterChavePrivada.Text;
  if OpenDialog1.Execute then
    edInterChavePrivada.Text := RemoverPathAplicacao(OpenDialog1.FileName);
  ValidarChavePSPInter;
end;

procedure TframeConfigPIX.btMateraAcharArqCertificadoClick(Sender: TObject);
begin
  OpenDialog1.FileName := edMateraArqCertificado.Text;
  if OpenDialog1.Execute then
    edMateraArqCertificado.Text := RemoverPathAplicacao(OpenDialog1.FileName);
  ValidarCertificadoPSPMatera;
end;

procedure TframeConfigPIX.btMateraAcharChavePrivadaClick(Sender: TObject);
begin
  OpenDialog1.FileName := edMateraArqChavePrivada.Text;
  if OpenDialog1.Execute then
    edMateraArqChavePrivada.Text := RemoverPathAplicacao(OpenDialog1.FileName);
  ValidarChavePSPMatera;
end;

procedure TframeConfigPIX.btPagSeguroCertificadoGerarClick(Sender: TObject);
var
  wErros: TStringList;
  wPathCert, wPathChave, idCert: String;
  wCertFinal, wChaveFinal: AnsiString;
  wSLCert, wSLChave: TStringList;
  ArquivosGerados: Boolean;
begin
  wErros := TStringList.Create;
  try
    wErros.Clear;
    if EstaVazio(edPagSeguroChallengeToken2.Text) then
      wErros.Add('- Token não informado');
    if EstaVazio(edPagSeguroCertificadoChallenge.Text) then
      wErros.Add('- Desafio não informado');
    if NaoEstaZerado(wErros.Count) then
      raise Exception.Create('Erros ao Gerar Certificado:' + sLineBreak + wErros.Text);

    wPathCert := AdicionarPathAplicacao(edPagSeguroCertificadoFinal.Text);
    wPathChave := AdicionarPathAplicacao(edPagSeguroPrivateKeyFinal.Text);
    if FilesExists(wPathCert) then
      wErros.Add('- Certificado já existe!');
    if FilesExists(wPathChave) then
      wErros.Add('- Chave Privada já existe!');
    if NaoEstaZerado(wErros.Count) then
      raise Exception.Create('Erros ao Gerar Certificado:' + sLineBreak + wErros.Text);
  finally
    wErros.Free;
  end;

  idCert := EmptyStr;
  wCertFinal := EmptyStr;
  wChaveFinal := EmptyStr;
  ArquivosGerados := ACBrPSPPagSeguro1.SolicitarCertificado(edPagSeguroChallengeToken2.Text,
                       edPagSeguroCertificadoChallenge.Text, idCert, wCertFinal, wChaveFinal);
  if ArquivosGerados then
  begin
    wSLCert := TStringList.Create;
    wSLChave := TStringList.Create;
    try
      wSLCert.Text := wCertFinal;
      wSLCert.SaveToFile(wPathCert);

      wSLChave.Text := wChaveFinal;
      wSLChave.SaveToFile(wPathChave);
      ShowMessage('Arquivos gerados com sucesso!');
    finally
      wSLCert.Free;
      wSLChave.Free;
    end;
  end
  else
    ShowMessage('Arquivos não foram gerados!');
end;

procedure TframeConfigPIX.btPagSeguroChallengeDecriptClick(Sender: TObject);
var
  wErros: TStringList;
  wPathPrivate, wChallenge: String;
begin
  wErros := TStringList.Create;
  try
    wErros.Clear;
    wPathPrivate := AdicionarPathAplicacao(edPagSeguroPrivateKey.Text);
    if not FilesExists(wPathPrivate) then
      wErros.Add('- Chave Privada não encontrada');
    if EstaVazio(mmPagSeguroChallengeCript.Lines.Text) then
      wErros.Add('- Desafio não encontrado');
    if NaoEstaZerado(wErros.Count) then
      raise Exception.Create('Erros ao descriptografar:' + sLineBreak + wErros.Text);
  finally
    wErros.Free;
  end;

  ACBrOpenSSLUtils1.LoadPrivateKeyFromFile(edPagSeguroChallengePrivateKey.Text);
  wChallenge := ACBrOpenSSLUtils1.PrivateDecryptFromString(
                  DecodeBase64(mmPagSeguroChallengeCript.Lines.Text),
                  algSHA256,
                  rsaPKCS1_OAEP_PADDING,
                  sttBinary);

  if NaoEstaVazio(wChallenge) then
  begin
    mmPagSeguroChallenge.Lines.Text := wChallenge;
    edPagSeguroCertificadoChallenge.Text := wChallenge;
  end;
end;

procedure TframeConfigPIX.btPagSeguroChallengeSolicClick(Sender: TObject);
var
  Challenge, TokenChallenge: String;
begin
  Challenge := EmptyStr;
  TokenChallenge := EmptyStr;
  if ACBrPSPPagSeguro1.SolicitarDesafioCertificado(Challenge, TokenChallenge) then
  begin
    mmPagSeguroChallengeCript.Text := Challenge;
    edPagSeguroChallengeToken.Text := TokenChallenge;
    edPagSeguroChallengeToken2.Text := TokenChallenge;
  end;
end;

procedure TframeConfigPIX.btPagSeguroGerarChavesClick(Sender: TObject);
var
  wErros: TStringList;
  wPathPublic, wPathPrivate, wPublicKey, wPrivateKey: String;
begin
  wErros := TStringList.Create;
  try
    wErros.Clear;
    wPathPublic := AdicionarPathAplicacao(edPagSeguroPublicKey.Text);
    wPathPrivate := AdicionarPathAplicacao(edPagSeguroPrivateKey.Text);
    if FilesExists(wPathPublic) then
      wErros.Add('- Chave Pública já existe!');
    if FilesExists(wPathPrivate) then
      wErros.Add('- Chave Privada já existe!');
    if NaoEstaZerado(wErros.Count) then
      raise Exception.Create('Erros ao gerar chaves:' + sLineBreak + wErros.Text);
  finally
    wErros.Free;
  end;

  wPublicKey := EmptyStr;
  wPrivateKey := EmptyStr;
  ACBrOpenSSLUtils.GenerateKeyPair(wPrivateKey, wPublicKey, EmptyStr, bit2048);
  mmPagSeguroPublicKey.Lines.Text := ChangeLineBreak(wPublicKey, sLineBreak);
  mmPagSeguroPublicKey.Lines.SaveToFile(wPathPublic);
  mmPagSeguroPrivateKey.Lines.Text := ChangeLineBreak(wPrivateKey, sLineBreak);
  mmPagSeguroPrivateKey.Lines.SaveToFile(wPathPrivate);
  edPagSeguroArqChavePrivada.Text := edPagSeguroPrivateKey.Text;
  edPagSeguroChallengePrivateKey.Text := edPagSeguroPrivateKey.Text;
  GravarConfiguracao;
end;

procedure TframeConfigPIX.btPagSeguroGerarClientsClick(Sender: TObject);
var
  wClientID, wClientSecret: String;
begin
  if EstaVazio(edPagSeguroToken2.Text) or EstaVazio(edPagSeguroNomeApp2.Text) then
    raise Exception.Create(ACBrStr('Informe o Token e Nome da Aplicação'));

  if EstaVazio(ACBrPSPPagSeguro1.TokenPay) then
    ACBrPSPPagSeguro1.TokenPay := edPagSeguroToken2.Text;

  wClientID := EmptyStr;
  wClientSecret := EmptyStr;
  if ACBrPSPPagSeguro1.SolicitarCredenciais(edPagSeguroNomeApp2.Text, wClientID, wClientSecret) then
  begin
    if NaoEstaVazio(wClientID) then
    begin
      edPagSeguroClientID1.Text := wClientID;
      edPagSeguroClientID2.Text := wClientID;
    end;
    if NaoEstaVazio(wClientSecret) then
    begin
      edPagSeguroClientSecret1.Text := wClientSecret;
      edPagSeguroClientSecret2.Text := wClientSecret;
    end;

    if EstaVazio(edPagSeguroNomeApp1.Text) then
      edPagSeguroNomeApp1.Text := edPagSeguroNomeApp2.Text;

    if EstaVazio(edPagSeguroToken1.Text) then
      edPagSeguroToken1.Text := edPagSeguroToken2.Text;

    GravarConfiguracao;
    ShowMessage('Credenciais geradas com Sucesso!');
  end;
end;

procedure TframeConfigPIX.btSantanderExtrairPEMClick(Sender: TObject);
var
  wArqPEM: String;
  wSL: TStringList;
begin
  if EstaVazio(edSantanderExtrairCertificadoPFX.Text) or
     (not FileExists(edSantanderExtrairCertificadoPFX.Text)) then
  begin
    MessageDlg(ACBrStr('Arquivo PFX não informado/existe'), mtError, [mbOK], 0);
    Exit;
  end;

  if EstaVazio(edSantanderExtrairCertificadoPEM.Text) then
  begin
    MessageDlg(ACBrStr('Arquivo de destino PEM não informado'), mtError, [mbOK], 0);
    Exit;
  end;

  wSL := TStringList.Create;
  try
    wArqPEM := edSantanderExtrairCertificadoPEM.Text;
    ACBrOpenSSLUtils1.LoadPFXFromFile(
      edSantanderExtrairCertificadoPFX.Text,
      edSantanderExtrairCertificadoSenhaPFX.Text);
    wSL.Text := ACBrOpenSSLUtils1.CertificateAsString;
    wSL.SaveToFile(wArqPEM);

    MessageDlg('Arquivo PEM gerado em: ' + wArqPEM, mtInformation, [mbOK], 0);
  finally
    wSL.Free;
  end;
end;

procedure TframeConfigPIX.btItauGerarChavePrivadaClick(Sender: TObject);
var
  aPrivateKey, aPublicKey: String;
begin
  if FileExists(edtItauArqChavePrivada2.Text) then
    if MessageDlg( 'A chave já existe, deseja realmente sobreescrecer ?',
                   mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
      Exit;

  ACBrOpenSSLUtils.GenerateKeyPair(aPrivateKey, aPublicKey, EmptyStr, bit2048);
  mItauChavePrivadaPEM.Lines.Text := ChangeLineBreak(aPrivateKey, sLineBreak);
  mItauChavePrivadaPEM.Lines.SaveToFile(edtItauArqChavePrivada2.Text);
end;

procedure TframeConfigPIX.btItauRenovarCertificadoClick(Sender: TObject);
var
  c: String;
begin
  ValidarChavePSPItau;
  if imgItauErroChavePrivada.Visible  then
  begin
    pgPSPItauChaveCertificado.ActivePageIndex := 0;
    pgPSPItauGerarChaveCertificado.ActivePageIndex := 0;
    MessageDlg('Favor configurar a Chave Privada', mtWarning, [mbOK], 0);
    Abort;
  end;

  c := ACBrPSPItau1.RenovarCertificado;
  mmItauRenovarCertificadoPEM.Lines.Text := ChangeLineBreak(c, sLineBreak);
  mmItauRenovarCertificadoPEM.Lines.SaveToFile(edItauRenovarCertificadoArq.Text);
end;

procedure TframeConfigPIX.btItauSolicitarCertificadoClick(Sender: TObject);
var
  wSL: TStringList;
  t, c, s: String;
  I: Integer;
begin
  ValidarChavePSPItau;
  if imgItauErroChavePrivada.Visible  then
  begin
    pgPSPItauChaveCertificado.ActivePageIndex := 0;
    pgPSPItauGerarChaveCertificado.ActivePageIndex := 0;
    MessageDlg('Favor configurar a Chave Privada', mtWarning, [mbOK], 0);
    Abort;
  end;

  t := Trim(mItauTokenTemporario.Lines.Text);
  if (t = '') then
  begin
    MessageDlg('Favor informar o Token temporário', mtWarning, [mbOK], 0);
    Abort;
  end;

  wSL := TStringList.Create;
  try
    c := ACBrPSPItau1.SolicitarCertificado(t);
    wSL.Text := ChangeLineBreak(c, sLineBreak);
    wSL.SaveToFile(edtItauArqCertificado2.Text);

    // Pega Client Secret que está na resposta
    for I := 0 to wSL.Count - 1 do
      if (Pos('Secret', wSL[I]) > 0) then
      begin
        s := wSL[I];
        wSL.Delete(I);
        Break;
      end;

    mItauCertificadoPEM.Lines.Text := wSL.Text;
    edtItauClientSecret.Text := Trim(Copy(s, Pos(':', s) + 1, Length(s)));
  finally
    wSL.Free;
  end;
end;

procedure TframeConfigPIX.btItauValidarChaveCertificadoClick(Sender: TObject);
begin
  ValidarChaveCertificadoPSPItau;
end;

procedure TframeConfigPIX.btLerParametrosClick(Sender: TObject);
begin
  LerConfiguracao;
end;

procedure TframeConfigPIX.btSalvarParametrosClick(Sender: TObject);
begin
  GravarConfiguracao;
  AplicarConfiguracao;
end;

procedure TframeConfigPIX.btSicoobExtrairChaveCertificadoArqPFXClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
    edSicoobExtrairChaveCertificadoArqPFX.Text := RemoverPathAplicacao(OpenDialog1.FileName);
end;

procedure TframeConfigPIX.btSicoobExtrairChaveCertificadoClick(Sender: TObject);
var
  wArqPEM, wChave: String;
  wSL: TStringList;
begin
  if EstaVazio(edSicoobExtrairChaveCertificadoArqPFX.Text) or
     (not FileExists(edSicoobExtrairChaveCertificadoArqPFX.Text)) then
  begin
    MessageDlg(ACBrStr('Arquivo PFX não informado/existe'), mtError, [mbOK], 0);
    Exit;
  end;

  if EstaVazio(edSicoobExtrairChavePrivada.Text) then
  begin
    MessageDlg(ACBrStr('Arquivo de destino da Chave Privada não informado'), mtError, [mbOK], 0);
    Exit;
  end;

  if EstaVazio(edSicoobExtrairCertificado.Text) then
  begin
    MessageDlg(ACBrStr('Arquivo de destino do Certificado PEM não informado'), mtError, [mbOK], 0);
    Exit;
  end;

  wSL := TStringList.Create;
  try
    wChave := edSicoobExtrairChavePrivada.Text;
    wArqPEM := edSicoobExtrairCertificado.Text;

    ACBrOpenSSLUtils1.LoadPFXFromFile(
      edSicoobExtrairChaveCertificadoArqPFX.Text,
      edSicoobExtrairChaveCertificadoSenhaPFX.Text);

    // Salvando arquivo Chave Privada
    wSL.Text := ACBrOpenSSLUtils1.PrivateKeyAsString;
    wSL.SaveToFile(wChave);
    edSicoobArqChavePrivada.Text := wChave;

    // Salvando arquivo Certificado
    wSL.Text := ACBrOpenSSLUtils1.CertificateAsString;
    wSL.SaveToFile(wArqPEM);
    edSicoobArqCertificado.Text := wArqPEM;

    MessageDlg(
      '- Chave Privada gerada em: ' + wChave + sLineBreak +
      '- Certificado PEM gerado em: ' + wArqPEM, mtInformation, [mbOK], 0);
  finally
    wSL.Free;
  end;
end;

procedure TframeConfigPIX.btSicoobExtrairChaveCertificadoInfoClick(Sender: TObject);
begin 
  MessageDlg(ACBrStr('Para utilizar o PSP Sicoob em ambiente de Produção é ' +
    'necessário extrair a Chave Privada e o Certificado PEM do Certificado PFX ' +
    sLineBreak + 'Após esse procedimento envie o arquivo PEM para o Sicoob pelo ' +
    'Internet Banking e receba seu Client ID para utilizar nas requisições'),
    mtInformation, [mbOk], 0);
end;

procedure TframeConfigPIX.btSicoobExtrairChaveCertificadoVerSenhaPFXClick(Sender: TObject);
begin
  {$IfDef FPC}
  if btSicoobExtrairChaveCertificadoVerSenhaPFX.Down then
    edSicoobExtrairChaveCertificadoSenhaPFX.EchoMode := emNormal
  else
    edSicoobExtrairChaveCertificadoSenhaPFX.EchoMode := emPassword;
  {$Else}
  if btSicoobExtrairChaveCertificadoVerSenhaPFX.Down then
    edSicoobExtrairChaveCertificadoSenhaPFX.PasswordChar := #0
  else
    edSicoobExtrairChaveCertificadoSenhaPFX.PasswordChar := '*';
  {$EndIf}
end;

procedure TframeConfigPIX.btSicrediGerarChaveCertificadoInfoClick(Sender: TObject);
begin
  MessageDlg(ACBrStr('Para utilizar o PSP Sicredi em ambiente de Produção é ' +
    'necessário gerar uma Chave Privada e um CSR. ' + sLineBreak +
    'Após esse procedimento envie esses arquivos para o Sicredi pelo Internet ' +
    'Banking e receba um novo arquivo certificado .CER para utilizar nas requisições'),
    mtInformation, [mbOk], 0);
end;

procedure TframeConfigPIX.btSicrediGerarChavePrivadaClick(Sender: TObject);
var
  wPrivateKey, wPublicKey: String;
begin
  if FileExists(edSicrediGerarChavePrivada.Text) and
     (MessageDlg(ACBrStr('Chave Privada já existe, deseja realmente sobreescrecer ?'),
       mtConfirmation, [mbYes, mbNo], 0) <> mrYes) then
    Exit;

  ACBrOpenSSLUtils.GenerateKeyPair(wPrivateKey, wPublicKey, EmptyStr, bit2048);
  mmSicrediGerarChavePrivada.Lines.Text := ChangeLineBreak(wPrivateKey, sLineBreak);
  mmSicrediGerarChavePrivada.Lines.SaveToFile(edSicrediGerarChavePrivada.Text);
  edSicrediArqChavePrivada.Text := edSicrediGerarChavePrivada.Text;
end;

procedure TframeConfigPIX.btSicrediGerarCSRClick(Sender: TObject);
var
  wErros, wCertificado: String;
begin
  if FileExists(edSicrediGerarCSR.Text) and
     (MessageDlg(ACBrStr('Certificado CSR já existe, deseja realmente sobreescrecer ?'),
       mtConfirmation, [mbYes, mbNo], 0) <> mrYes) then
    Exit;

  if EstaVazio(mmSicrediGerarChavePrivada.Text) then
  begin
    MessageDlg(ACBrStr('Antes de gerar o CSR é necessário gerar a Chave Privada'), mtInformation, [mbOK], 0);
    Exit;
  end;

  wErros := EmptyStr;
  if (Trim(edtRecebedorNome.Text) = EmptyStr) then
    wErros := sLineBreak + ACBrStr('- Campo Nome do Recebedor não informado');

  if EstaVazio(Trim(edSicrediGerarCSREmail.Text)) then
    wErros := wErros + sLineBreak + ACBrStr('- Campo E-mail não informado');

  if NaoEstaVazio(wErros) then
  begin
    MessageDlg('Erro ao gerar CSR:' + wErros, mtError, [mbOK], 0);
    Exit;
  end;

  ACBrOpenSSLUtils1.Clear;
  ACBrOpenSSLUtils1.LoadPrivateKeyFromString(mmSicrediGerarChavePrivada.Text);
  wCertificado := ACBrOpenSSLUtils1.CreateCertificateSignRequest(
                    'api-pix-' + OnlyAlphaNum(TiraAcentos(edtRecebedorNome.Text)),
                    'Confederacao Interestadual das Cooperativas Ligadas ao Sicredi',
                    'API PIX Sicredi',
                    'Porto Alegre',
                    'Rio Grande do Sul', 'BR',
                    edSicrediGerarCSREmail.Text, algSHA256);
  mmSicrediGerarCSR.Text := ChangeLineBreak(wCertificado, CRLF);
  mmSicrediGerarCSR.Lines.SaveToFile(edSicrediGerarCSR.Text);
end;

procedure TframeConfigPIX.btSicrediSenhaChavePrivadaClick(Sender: TObject);
begin
  {$IfDef FPC}
  if btSicrediSenhaChavePrivada.Down then
    edSicrediSenhaChavePrivada.EchoMode := emNormal
  else
    edSicrediSenhaChavePrivada.EchoMode := emPassword;
  {$Else}
  if btSicrediSenhaChavePrivada.Down then
    edSicrediSenhaChavePrivada.PasswordChar := #0
  else
    edSicrediSenhaChavePrivada.PasswordChar := '*';
  {$EndIf}
end;

procedure TframeConfigPIX.cbBBConfigTokenManualClick(Sender: TObject);
begin
  pnBBConfigTokenManualGerar.Enabled := cbBBConfigTokenManual.Checked;
  if cbBBConfigTokenManual.Checked then
    ACBrPSPBancoDoBrasil1.OnPrecisaAutenticar := ACBrPSPBancoDoBrasil1PrecisaAutenticar
  else
    ACBrPSPBancoDoBrasil1.OnPrecisaAutenticar := Nil;
end;

procedure TframeConfigPIX.cbBBVersaoAPIChange(Sender: TObject);
begin
  pnBBCertificados.Visible := (cbBBVersaoAPI.ItemIndex = 1);
  rgBBTipoCertificado.Visible := (cbBBVersaoAPI.ItemIndex = 1);
end;

procedure TframeConfigPIX.cbxAmbienteChange(Sender: TObject);
var
  wProducao: Boolean;
begin
  wProducao := (cbxAmbiente.ItemIndex = 1);

  tsItauCertificado.Enabled := wProducao;
  lItauAvisoChaveCertificadoDesabilitado.Visible := not tsItauCertificado.Enabled;

  edSicoobTokenSandbox.Enabled := (not wProducao);
end;

procedure TframeConfigPIX.cbxPSPAtualChange(Sender: TObject);
begin
  imgErrPSP.Visible := (cbxPSPAtual.ItemIndex < 0);
  if (cbxPSPAtual.ItemIndex >= 0) then
    pgPSPs.ActivePageIndex := cbxPSPAtual.ItemIndex;
end;

procedure TframeConfigPIX.edAilosArqsChange(Sender: TObject);
begin
  lbAilosErroChavePrivada.Caption := '';
  lbAilosErroCertificado.Caption := '';
end;

procedure TframeConfigPIX.edAilosCertificadoExit(Sender: TObject);
begin
  ValidarCertificadoPSPAilos;
end;

procedure TframeConfigPIX.edAilosCertificadoRootExit(Sender: TObject);
begin
  ValidarCertificadoRootPSPAilos;
end;

procedure TframeConfigPIX.edAilosChavePIXChange(Sender: TObject);
begin
  cbAilosTipoChave.ItemIndex := Integer(DetectarTipoChave(edAilosChavePIX.Text));
  imAilosErroChavePIX.Visible := NaoEstaVazio(edAilosChavePIX.Text) and (cbAilosTipoChave.ItemIndex = 0);
end;

procedure TframeConfigPIX.edAilosChavePrivadaExit(Sender: TObject);
begin
  ValidarChavePSPAilos;
end;

procedure TframeConfigPIX.edBanrisulArqCertificadoPFXChange(Sender: TObject);
begin
  lbBanrisulErroCertificadoPFX.Caption := EmptyStr;
end;

procedure TframeConfigPIX.edBanrisulArqCertificadoPFXExit(Sender: TObject);
begin
  if NaoEstaVazio(edBanrisulSenhaCertificadoPFX.Text) then
    ValidarPFXBanrisul;
end;

procedure TframeConfigPIX.edBanrisulChavePIXChange(Sender: TObject);
begin
  cbBanrisulTipoChave.ItemIndex := Integer(DetectarTipoChave(edBanrisulChavePIX.Text));
  imBanrisulErroChavePix.Visible := NaoEstaVazio(edBanrisulChavePIX.Text) and (cbBanrisulTipoChave.ItemIndex = 0);
end;

procedure TframeConfigPIX.edBanrisulSenhaCertificadoPFXExit(Sender: TObject);
begin
  if NaoEstaVazio(edBanrisulArqCertificadoPFX.Text) then
    ValidarPFXBanrisul;
end;

procedure TframeConfigPIX.edBBArqPFXChange(Sender: TObject);
begin
  lbBBErroPFX.Caption := EmptyStr;
end;

procedure TframeConfigPIX.edBBArqPFXExit(Sender: TObject);
begin
  ValidarPFXPSPBB;
end;

procedure TframeConfigPIX.edBBArqsChange(Sender: TObject);
begin
  lbBBErroChavePrivada.Caption := EmptyStr;
  lbBBErroCertificado.Caption := EmptyStr;
end;

procedure TframeConfigPIX.edBBArqCertificadoExit(Sender: TObject);
begin
  ValidarCertificadoPSPBB;
end;

procedure TframeConfigPIX.edBBArqChavePrivadaExit(Sender: TObject);
begin
  ValidarChavePSPBB;
end;

procedure TframeConfigPIX.edBBSenhaPFXExit(Sender: TObject);
begin
  if NaoEstaVazio(edBBSenhaPFX.Text) and (NaoEstaVazio(edBBArqPFX.Text)) then
    ValidarPFXPSPBB;
end;

procedure TframeConfigPIX.edBradescoArqCertificadoExit(Sender: TObject);
begin
  ValidarCertificadoPSPBradesco;
end;

procedure TframeConfigPIX.edBradescoArqsChange(Sender: TObject);
begin
  lbBradescoErroChavePrivada.Caption := EmptyStr;
  lbBradescoErroCertificado.Caption := EmptyStr;
end;

procedure TframeConfigPIX.edBradescoArqChavePrivadaExit(Sender: TObject);
begin
  ValidarChavePSPBradesco;
end;

procedure TframeConfigPIX.edBradescoArqPFXChange(Sender: TObject);
begin
  lbBradescoErroPFX.Caption := EmptyStr;
end;

procedure TframeConfigPIX.edBradescoValidarPFXExit(Sender: TObject);
begin
  if NaoEstaVazio(edBradescoSenhaPFX.Text) then
    ValidarPFXBradesco;
end;

procedure TframeConfigPIX.edBradescoChavePIXChange(Sender: TObject);
begin
  cbBradescoTipoChave.ItemIndex := Integer(DetectarTipoChave(edBradescoChavePIX.Text));
  imBradescoErroChavePix.Visible := NaoEstaVazio(edBradescoChavePIX.Text) and (cbBradescoTipoChave.ItemIndex = 0);
end;

procedure TframeConfigPIX.edC6BankCertificadoExit(Sender: TObject);
begin
  ValidarCertificadoPSPC6Bank;
end;

procedure TframeConfigPIX.edC6BankChavePIXChange(Sender: TObject);
begin
  cbC6BankTipoChave.ItemIndex := Integer(DetectarTipoChave(edC6BankChavePIX.Text));
  imC6BankErroChavePix.Visible := NaoEstaVazio(edC6BankChavePIX.Text) and (cbC6BankTipoChave.ItemIndex = 0);
end;

procedure TframeConfigPIX.edC6BankArqsChange(Sender: TObject);
begin
  lbC6BankErroChavePrivada.Caption := EmptyStr;
  lbC6BankErroCertificado.Caption := EmptyStr;
end;

procedure TframeConfigPIX.edC6BankChavePrivadaExit(Sender: TObject);
begin
  ValidarChavePSPC6Bank;
end;

procedure TframeConfigPIX.edCieloArqCertificadoChange(Sender: TObject);
begin
  lbCieloErroChavePrivada.Caption := '';
  lbCieloErroCertificado.Caption := '';
end;

procedure TframeConfigPIX.edCieloArqCertificadoExit(Sender: TObject);
begin
  ValidarCertificadoPSPCielo;
end;

procedure TframeConfigPIX.edCieloArqChavePrivadaChange(Sender: TObject);
begin
  lbCieloErroChavePrivada.Caption := '';
  lbCieloErroCertificado.Caption := '';
end;

procedure TframeConfigPIX.edCieloArqChavePrivadaExit(Sender: TObject);
begin
  ValidarChavePSPCielo;
end;

procedure TframeConfigPIX.edCieloChavePIXChange(Sender: TObject);
begin
  cbCieloTipoChave.ItemIndex := Integer(DetectarTipoChave(edCieloChavePIX.Text));
  imCieloErroChavePix.Visible := NaoEstaVazio(edCieloChavePIX.Text) and (cbCieloTipoChave.ItemIndex = 0);
end;

procedure TframeConfigPIX.edCrediSisChavePIXChange(Sender: TObject);
begin
  cbCrediSisTipoChave.ItemIndex := Integer(DetectarTipoChave(edCrediSisChavePIX.Text));
  imCrediSisErroChavePix.Visible := NaoEstaVazio(edCrediSisChavePIX.Text) and (cbCrediSisTipoChave.ItemIndex = 0);
end;

procedure TframeConfigPIX.edGerenciaNetChavePIXChange(Sender: TObject);
begin
  cbGerenciaNetTipoChave.ItemIndex := Integer(DetectarTipoChave(edGerenciaNetChavePIX.Text));
  imGerenciaNetErroChavePix.Visible := NaoEstaVazio(edGerenciaNetChavePIX.Text) and (cbGerenciaNetTipoChave.ItemIndex = 0);
end;

procedure TframeConfigPIX.edGerenciaNetArqPFXExit(Sender: TObject);
begin
  ValidarCertificadoPSPGerenciaNet;
end;

procedure TframeConfigPIX.edGerenciaNetArqPFXChange(Sender: TObject);
begin
  lbGerenciaNetErroPFX.Caption := EmptyStr;
end;

procedure TframeConfigPIX.edPagSeguroArqCertificadoExit(Sender: TObject);
begin
  ValidarCertificadoPSPPagSeguro;
end;

procedure TframeConfigPIX.edPagSeguroArqsChange(Sender: TObject);
begin
  lbPagSeguroErroChavePrivada.Caption := '';
  lbPagSeguroErroCertificado.Caption := '';
end;

procedure TframeConfigPIX.edPagSeguroArqChavePrivadaExit(Sender: TObject);
begin
  ValidarChavePSPPagSeguro;
end;

procedure TframeConfigPIX.edPagSeguroChavePIXChange(Sender: TObject);
begin
  cbPagSeguroTipoChave.ItemIndex := Integer(DetectarTipoChave(edPagSeguroChavePIX.Text));
  imPagSeguroErroChavePIX.Visible := NaoEstaVazio(edPagSeguroChavePIX.Text) and (cbPagSeguroTipoChave.ItemIndex = 0);
end;

procedure TframeConfigPIX.edQQPagChavePIXChange(Sender: TObject);
begin
  cbQQPagTipoChave.ItemIndex := Integer(DetectarTipoChave(edQQPagChavePIX.Text));
  imQQPagErroChavePix.Visible := NaoEstaVazio(edQQPagChavePIX.Text) and (cbQQPagTipoChave.ItemIndex = 0);
end;

procedure TframeConfigPIX.edSantanderArqCertificadoPFXChange(Sender: TObject);
begin
  lbSantanderErroCertificadoPFX.Caption := EmptyStr;
end;

procedure TframeConfigPIX.edSicoobArqCertificadoExit(Sender: TObject);
begin
  ValidarCertificadoPSPSicoob;
end;

procedure TframeConfigPIX.edSicoobArqChavePrivadaExit(Sender: TObject);
begin
  ValidarChavePSPSicoob;
end;

procedure TframeConfigPIX.edSicoobArqsChange(Sender: TObject);
begin
  lbSicoobErroChavePrivada.Caption := '';
  lbSicoobErroCertificado.Caption := '';
end;

procedure TframeConfigPIX.edSicoobChavePIXChange(Sender: TObject);
begin
  cbSicoobTipoChave.ItemIndex := Integer(DetectarTipoChave(edSicoobChavePIX.Text));
  imSicoobErroChavePIX.Visible := (edSicoobChavePIX.Text <> '') and (cbSicoobTipoChave.ItemIndex = 0);
end;

procedure TframeConfigPIX.edSicrediArqCertificadoExit(Sender: TObject);
begin
  ValidarCertificadoPSPSicredi;
end;

procedure TframeConfigPIX.edSicrediArqChavePrivadaExit(Sender: TObject);
begin
  ValidarChavePSPSicredi;
end;

procedure TframeConfigPIX.edtRecebedorCEPExit(Sender: TObject);
begin
  if (not imgErrCEP.Visible) and (edtRecebedorCidade.Text = '') then
    sbConsultaCEP.Click;
end;

procedure TframeConfigPIX.edGerenciaNetArqCertificadoChange(Sender: TObject);
begin
  lbGerenciaNetErroPFX.Caption := EmptyStr;
end;

procedure TframeConfigPIX.edInterCertificadoExit(Sender: TObject);
begin
  ValidarCertificadoPSPInter;
end;

procedure TframeConfigPIX.edInterChavePIXChange(Sender: TObject);
begin
  cbInterTipoChave.ItemIndex := Integer(DetectarTipoChave(edInterChavePIX.Text));
  imInterErroChavePix.Visible := NaoEstaVazio(edInterChavePIX.Text) and (cbInterTipoChave.ItemIndex = 0);
end;

procedure TframeConfigPIX.edInterArqsChange(Sender: TObject);
begin
  lbInterErroChavePrivada.Caption := '';
  lbInterErroCertificado.Caption := '';
end;

procedure TframeConfigPIX.edInterChavePrivadaExit(Sender: TObject);
begin
  ValidarChavePSPInter;
end;

procedure TframeConfigPIX.edMateraArqCertificadoExit(Sender: TObject);
begin
  ValidarCertificadoPSPMatera;
end;

procedure TframeConfigPIX.edMateraArqChavePrivadaExit(Sender: TObject);
begin
  ValidarChavePSPMatera;
end;

procedure TframeConfigPIX.edMercadoPagoChavePIXChange(Sender: TObject);
begin
  cbMercadoPagoTipoChave.ItemIndex := Integer(DetectarTipoChave(edMercadoPagoChavePIX.Text));
  imMercadoPagoErroChavePix.Visible := NaoEstaVazio(edMercadoPagoChavePIX.Text) and (cbMercadoPagoTipoChave.ItemIndex = 0);
end;

procedure TframeConfigPIX.edOnlyNumbersKeyPress(Sender: TObject; var Key: char);
begin
  if not CharInSet( Key, [#8,#13,'0'..'9'] ) then
    Key := #0;
end;

procedure TframeConfigPIX.edtItauArqChavePrivadaChange(Sender: TObject);
begin
  lItauErroChavePrivada.Caption := '';
  lItauErroCertificado.Caption := '';
  btItauValidarChaveCertificado.Visible :=
     imgItauErroChavePrivada.Visible or
     imgItauErroCertificado.Visible or
     (edtItauArqChavePrivada.Text <> ACBrPSPItau1.ArquivoChavePrivada) or
     (edtItauArqCertificado.Text <> ACBrPSPItau1.ArquivoCertificado);
end;

procedure TframeConfigPIX.edtBBChavePIXChange(Sender: TObject);
begin
  cbxBBTipoChave.ItemIndex := Integer(DetectarTipoChave(edtBBChavePIX.Text));
  imgBBErroChavePIX.Visible := (edtBBChavePIX.Text <> '') and (cbxBBTipoChave.ItemIndex = 0);
end;

procedure TframeConfigPIX.edtItauChavePIXChange(Sender: TObject);
begin
  cbxItauTipoChave.ItemIndex := Integer(DetectarTipoChave(edtItauChavePIX.Text));
  imgItauErroChavePIX.Visible := (edtItauChavePIX.Text <> '') and (cbxItauTipoChave.ItemIndex = 0);
end;

procedure TframeConfigPIX.edtItauClientIDChange(Sender: TObject);
begin
  imgItauErroClientID.Visible := not ValidarChaveAleatoria(edtItauClientID.Text);
end;

procedure TframeConfigPIX.edtItauClientSecretChange(Sender: TObject);
begin
  imgItauErroClientSecret.Visible := not ValidarChaveAleatoria(edtItauClientSecret.Text);
end;

procedure TframeConfigPIX.edtRecebedorNomeChange(Sender: TObject);
begin
  imgErrNome.Visible := (Length(Trim(edtRecebedorNome.Text)) < 5);
end;

procedure TframeConfigPIX.edSantanderChavePIXChange(Sender: TObject);
begin
  cbSantanderTipoChave.ItemIndex := Integer(DetectarTipoChave(edSantanderChavePIX.Text));
  imSantanderErroChavePIX.Visible := (edSantanderChavePIX.Text <> '') and (cbSantanderTipoChave.ItemIndex = 0);
end;

procedure TframeConfigPIX.edSicrediArqsChange(Sender: TObject);
begin
  lbSicrediErroChavePrivada.Caption := '';
  lbSicrediErroCertificado.Caption := '';
end;

procedure TframeConfigPIX.edSicrediChavePIXChange(Sender: TObject);
begin
  cbSicrediTipoChave.ItemIndex := Integer(DetectarTipoChave(edSicrediChavePIX.Text));
  imSicrediErroChavePIX.Visible := (edSicrediChavePIX.Text <> '') and (cbSicrediTipoChave.ItemIndex = 0);
end;

procedure TframeConfigPIX.pgPSPItauChaveCertificadoChange(Sender: TObject);
var
  a: String;
begin
  if (pgPSPItauChaveCertificado.ActivePageIndex = 1) then
  begin
    ValidarChavePSPItau;
    a := AdicionarPathAplicacao(edtItauArqChavePrivada.Text);
    if (a = '') then
      a := AdicionarPathAplicacao('ItauChavePrivada.pem');
    edtItauArqChavePrivada2.Text := a;
    if FileExists(a) then
    begin
      ACBrOpenSSLUtils1.LoadPrivateKeyFromFile(a);
      mItauChavePrivadaPEM.Lines.Text := ChangeLineBreak(ACBrOpenSSLUtils1.PrivateKeyAsString, sLineBreak);
    end
    else
      mItauChavePrivadaPEM.Lines.Text := ACBrStr('Arquivo: '+a+'  não encontrado');

    a := AdicionarPathAplicacao(edtItauArqCertificado.Text);
    if (a = '') then
      a := AdicionarPathAplicacao('ItauCertificado.pem');
    edtItauArqCertificado2.Text := a;
  end;
end;

procedure TframeConfigPIX.LigarAlertasdeErrosDeConfiguracao;
begin
  LigarAlertasdeErrosDeConfiguracaoPIXCD;
  LigarAlertasdeErrosDeConfiguracaoPSPItau;
  LigarAlertasdeErrosDeConfiguracaoPSPSicoob;
  LigarAlertasdeErrosDeConfiguracaoPSPSicredi;
  LigarAlertasdeErrosDeConfiguracaoPSPSantander;
  LigarAlertasdeErrosDeConfiguracaoPSPGerenciaNet;
  LigarAlertasdeErrosDeConfiguracaoPSPPagSeguro;
  LigarAlertasdeErrosDeConfiguracaoPSPInter;
  LigarAlertasdeErrosDeConfiguracaoPSPAilos;
  LigarAlertasdeErrosDeConfiguracaoPSPBB;
  LigarAlertasdeErrosDeConfiguracaoPSPBanrisul;
  LigarAlertasdeErrosDeConfiguracaoPSPC6Bank
end;

procedure TframeConfigPIX.LigarAlertasdeErrosDeConfiguracaoPIXCD;
begin
  edtRecebedorNomeChange(Nil);
  edtRecebedorCEPChange(Nil);
  cbxPSPAtualChange(Nil);
  cbxAmbienteChange(Nil)
end;

procedure TframeConfigPIX.LigarAlertasdeErrosDeConfiguracaoPSPItau;
begin
  edtItauChavePIXChange(Nil);
  edtItauClientIDChange(Nil);
  edtItauClientSecretChange(Nil);
  tsItauCertificado.Enabled := (ACBrPixCD1.Ambiente > ambTeste);
  ValidarChaveCertificadoPSPItau;
end;

procedure TframeConfigPIX.LigarAlertasdeErrosDeConfiguracaoPSPSicoob;
begin
  edSicoobChavePIXChange(Nil);
  edSicoobArqsChange(Nil);
  ValidarChavePSPSicoob;
  ValidarCertificadoPSPSicoob;
end;

procedure TframeConfigPIX.LigarAlertasdeErrosDeConfiguracaoPSPSicredi;
begin
  edSicrediChavePIXChange(Nil);
  edSicrediArqsChange(Nil);
  ValidarChavePSPSicredi;
  ValidarCertificadoPSPSicredi;
end;

procedure TframeConfigPIX.LigarAlertasdeErrosDeConfiguracaoPSPSantander;
begin
  edSantanderChavePIXChange(Nil);
  ValidarCertificadoPSPSantander;
end;

procedure TframeConfigPIX.LigarAlertasdeErrosDeConfiguracaoPSPGerenciaNet;
begin
  edGerenciaNetChavePIXChange(Nil);
  edGerenciaNetArqCertificadoChange(Nil);
  ValidarCertificadoPSPGerenciaNet;
end;

procedure TframeConfigPIX.LigarAlertasdeErrosDeConfiguracaoPSPPagSeguro;
begin
  edPagSeguroChavePIXChange(Nil);
  edPagSeguroArqsChange(Nil);
  ValidarCertificadoPSPPagSeguro;
  ValidarChavePSPPagSeguro;
end;

procedure TframeConfigPIX.LigarAlertasdeErrosDeConfiguracaoPSPInter;
begin
  edInterChavePIXChange(Nil);
  edInterArqsChange(Nil);
  ValidarCertificadoPSPInter;
  ValidarChavePSPInter;
end;

procedure TframeConfigPIX.LigarAlertasdeErrosDeConfiguracaoPSPAilos;
begin
  edAilosChavePIXChange(Nil);
  edAilosArqsChange(Nil);
  ValidarCertificadoPSPAilos;
  ValidarCertificadoRootPSPAilos;
  ValidarChavePSPAilos;
end;

procedure TframeConfigPIX.LigarAlertasdeErrosDeConfiguracaoPSPBB;
begin
  edtBBChavePIXChange(Nil);
  edBBArqsChange(Nil);
  ValidarCertificadoPSPBB;
  ValidarChavePSPBB;
  ValidarPFXPSPBB;
end;

procedure TframeConfigPIX.LigarAlertasdeErrosDeConfiguracaoPSPBanrisul;
begin
  edBanrisulChavePIXChange(Nil);
  edBanrisulArqCertificadoPFXChange(Nil);
  ValidarPFXBanrisul;
end;

procedure TframeConfigPIX.LigarAlertasdeErrosDeConfiguracaoPSPC6Bank;
begin
  edC6BankChavePIXChange(Nil);
  edC6BankArqsChange(Nil);
  ValidarCertificadoPSPC6Bank;
  ValidarChavePSPC6Bank;
end;

procedure TframeConfigPIX.VerificarConfiguracao;
begin
  VerificarConfiguracaoPIXCD;
  if (ACBrPixCD1.PSP = ACBrPSPItau1) then
    VerificarConfiguracaoPSPItau;
end;

procedure TframeConfigPIX.VerificarConfiguracaoPSPItau;
begin
  if imgItauErroChavePIX.Visible or imgItauErroClientID.Visible or imgItauErroClientSecret.Visible then
  begin
    pgConfPixPSP.ActivePageIndex := 1;
    pgPSPs.ActivePageIndex := 2;
    pgPSPItau.ActivePageIndex := 0;
    pgPSPItauChaveCertificado.ActivePageIndex := 0;
    pgPSPItauGerarChaveCertificado.ActivePageIndex := 0;
    MessageDlg('Favor configurar as credenciais de acesso ao Itaú', mtWarning, [mbOK], 0);
    Abort;
  end;

  if (ACBrPixCD1.Ambiente > ambTeste) then
  begin
    if imgItauErroChavePrivada.Visible or imgItauErroCertificado.Visible then
    begin
      pgConfPixPSP.ActivePageIndex := 1;
      pgPSPs.ActivePageIndex := 2;
      pgPSPItau.ActivePageIndex := 1;
      pgPSPItauChaveCertificado.ActivePageIndex := 0;
      pgPSPItauGerarChaveCertificado.ActivePageIndex := 0;
      MessageDlg('Favor configurar a Chave Privada e Certificado', mtWarning, [mbOK], 0);
      Abort;
    end;
  end;
end;

procedure TframeConfigPIX.ValidarChaveCertificadoPSPItau;
begin
  ValidarChavePSPItau;
  ValidarCertificadoPSPItau;
end;

procedure TframeConfigPIX.ValidarChavePSPSicredi;
var
  a, e: String;
begin
  a := AdicionarPathAplicacao(edSicrediArqChavePrivada.Text);
  e := 'OK';
  if (a = '') then
    e := ACBrStr('Arquivo não especificado')
  else if (not FileExists(a)) then
    e := ACBrStr('Arquivo não encontrado')
  else
  begin
    try
      ACBrOpenSSLUtils1.LoadPrivateKeyFromFile(a, edSicrediSenhaChavePrivada.Text);
    except
      On Ex: Exception do
        e := Ex.Message;
    end;
  end;

  lbSicrediErroChavePrivada.Caption := e;
  imSicrediErroChavePrivada.Visible := (e <> 'OK');
end;

procedure TframeConfigPIX.ValidarChavePSPCielo;
var
  a, e: String;
begin
  a := AdicionarPathAplicacao(edCieloArqChavePrivada.Text);
  e := 'OK';
  if (a = '') then
    e := ACBrStr('Arquivo não especificado')
  else if (not FileExists(a)) then
    e := ACBrStr('Arquivo não encontrado')
  else
  begin
    try
      ACBrOpenSSLUtils1.LoadPrivateKeyFromFile(a);
    except
      On Ex: Exception do
        e := Ex.Message;
    end;
  end;
  lbCieloErroChavePrivada.Caption := e;
  imCieloErroChavePrivada.Visible := (e <> 'OK');
end;

procedure TframeConfigPIX.ValidarChavePSPSicoob;
var
  a, e: String;
begin
  a := AdicionarPathAplicacao(edSicoobArqChavePrivada.Text);
  e := 'OK';
  if (a = '') then
    e := ACBrStr('Arquivo não especificado')
  else if (not FileExists(a)) then
    e := ACBrStr('Arquivo não encontrado')
  else
  begin
    try
      ACBrOpenSSLUtils1.LoadPrivateKeyFromFile(a);
    except
      On Ex: Exception do
        e := Ex.Message;
    end;
  end;

  lbSicoobErroChavePrivada.Caption := e;
  lbSicoobErroChavePrivada.Visible := True;
  imSicoobErroChavePrivada.Visible := (e <> 'OK');
end;

procedure TframeConfigPIX.ValidarChavePSPPagSeguro;
var
  a, e: String;
begin
  a := AdicionarPathAplicacao(edPagSeguroArqChavePrivada.Text);
  e := 'OK';
  if (a = '') then
    e := ACBrStr('Arquivo não especificado')
  else if (not FileExists(a)) then
    e := ACBrStr('Arquivo não encontrado')
  else
  begin
    try
      ACBrOpenSSLUtils1.LoadPrivateKeyFromFile(a);
    except
      On Ex: Exception do
        e := Ex.Message;
    end;
  end;

  lbPagSeguroErroChavePrivada.Caption := e;
  imPagSeguroErroChavePrivada.Visible := (e <> 'OK');
end;

procedure TframeConfigPIX.ValidarChavePSPInter;
var
  a, e: String;
begin
  a := AdicionarPathAplicacao(edInterChavePrivada.Text);
  e := 'OK';
  if (a = '') then
    e := ACBrStr('Arquivo não especificado')
  else if (not FileExists(a)) then
    e := ACBrStr('Arquivo não encontrado')
  else
  begin
    try
      ACBrOpenSSLUtils1.LoadPrivateKeyFromFile(a);
    except
      On Ex: Exception do
        e := Ex.Message;
    end;
  end;

  lbInterErroChavePrivada.Caption := e;
  imInterErroChavePrivada.Visible := (e <> 'OK');
end;

procedure TframeConfigPIX.ValidarChavePSPAilos;
var
  a, e: String;
begin
  a := AdicionarPathAplicacao(edAilosChavePrivada.Text);
  e := 'OK';
  if (a = '') then
    e := ACBrStr('Arquivo não especificado')
  else if (not FileExists(a)) then
    e := ACBrStr('Arquivo não encontrado')
  else
  begin
    try
      ACBrOpenSSLUtils1.LoadPrivateKeyFromFile(a);
    except
      On Ex: Exception do
        e := Ex.Message;
    end;
  end;

  lbAilosErroChavePrivada.Caption := e;
  imAilosErroChavePrivada.Visible := (e <> 'OK');
end;

procedure TframeConfigPIX.ValidarChavePSPBB;
var
  a, e: String;
begin
  a := AdicionarPathAplicacao(edBBArqChavePrivada.Text);
  e := 'OK';
  if (a = '') then
    e := ACBrStr('Arquivo não especificado')
  else if (not FileExists(a)) then
    e := ACBrStr('Arquivo não encontrado')
  else
  begin
    try
      ACBrOpenSSLUtils1.LoadPrivateKeyFromFile(a);
    except
      On Ex: Exception do
        e := Ex.Message;
    end;
  end;

  lbBBErroChavePrivada.Caption := e;
  imBBErroChavePrivada.Visible := (e <> 'OK');
end;

procedure TframeConfigPIX.ValidarChavePSPMatera;
var
  a, e: String;
begin
  a := AdicionarPathAplicacao(edMateraArqChavePrivada.Text);
  e := 'OK';
  if (a = '') then
    e := ACBrStr('Arquivo não especificado')
  else if (not FileExists(a)) then
    e := ACBrStr('Arquivo não encontrado')
  else
  begin
    try
      ACBrOpenSSLUtils1.LoadPrivateKeyFromFile(a);
    except
      On Ex: Exception do
        e := Ex.Message;
    end;
  end;

  lbMateraErroChavePrivada.Caption := e;
  imMateraErroChavePrivada.Visible := (e <> 'OK');
end;

procedure TframeConfigPIX.ValidarChavePSPC6Bank;
var
  a, e: String;
begin
  a := AdicionarPathAplicacao(edC6BankChavePrivada.Text);
  e := 'OK';
  if (a = '') then
    e := ACBrStr('Arquivo não especificado')
  else if (not FileExists(a)) then
    e := ACBrStr('Arquivo não encontrado')
  else
  begin
    try
      ACBrOpenSSLUtils1.LoadPrivateKeyFromFile(a);
    except
      On Ex: Exception do
        e := Ex.Message;
    end;
  end;

  lbC6BankErroChavePrivada.Caption := e;
  imC6BankErroChavePrivada.Visible := (e <> 'OK');
end;

procedure TframeConfigPIX.ValidarChavePSPBradesco;
var
  a, e: String;
begin
  a := AdicionarPathAplicacao(edBradescoArqChavePrivada.Text);
  e := 'OK';
  if (a = '') then
    e := ACBrStr('Arquivo não especificado')
  else if (not FileExists(a)) then
    e := ACBrStr('Arquivo não encontrado')
  else
  begin
    try
      ACBrOpenSSLUtils1.LoadPrivateKeyFromFile(a);
    except
      On Ex: Exception do
        e := Ex.Message;
    end;
  end;

  lbBradescoErroChavePrivada.Caption := e;
  lbBradescoErroChavePrivada.Visible := True;
  imBradescoErroChavePrivada.Visible := (e <> 'OK');
end;

procedure TframeConfigPIX.ValidarCertificadoPSPSicoob;
var
  a, e: String;
begin
  a := AdicionarPathAplicacao(edSicoobArqCertificado.Text);
  e := 'OK';
  if (a = '') then
    e := ACBrStr('Arquivo não especificado')
  else if (not FileExists(a)) then
    e := ACBrStr('Arquivo não encontrado')
  else
  begin
    try
      ACBrOpenSSLUtils1.LoadCertificateFromFile(a);  // Verifica se o arquivo de Chave é válido
    except
      On Ex: Exception do
        e := Ex.Message;
    end;
  end;

  lbSicoobErroCertificado.Caption := e;
  lbSicoobErroCertificado.Visible := True;
  imSicoobErroCertificado.Visible := (e <> 'OK');
end;

procedure TframeConfigPIX.ValidarCertificadoPSPSicredi;
var
  a, e: String;
begin
  a := AdicionarPathAplicacao(edSicrediArqCertificado.Text);
  e := 'OK';
  if (a = '') then
    e := ACBrStr('Arquivo não especificado')
  else if (not FileExists(a)) then
    e := ACBrStr('Arquivo não encontrado')
  else
  begin
    try
      ACBrOpenSSLUtils1.LoadCertificateFromFile(a);  // Verifica se o arquivo de Chave é válido
    except
      On Ex: Exception do
        e := Ex.Message;
    end;
  end;

  lbSicrediErroCertificado.Caption := e;
  imSicrediErroCertificado.Visible := (e <> 'OK');
end;

procedure TframeConfigPIX.ValidarCertificadoPSPCielo;
var
  a, e: String;
begin
  a := AdicionarPathAplicacao(edCieloArqCertificado.Text);
  e := 'OK';
  if (a = '') then
    e := ACBrStr('Arquivo não especificado')
  else if (not FileExists(a)) then
    e := ACBrStr('Arquivo não encontrado')
  else
  begin
    try
      ACBrOpenSSLUtils1.LoadPEMFromFile(a);
    except
      On Ex: Exception do
        e := Ex.Message;
    end;
  end;

  lbCieloErroCertificado.Caption := e;
  imCieloErroCertificado.Visible := (e <> 'OK');
end;

procedure TframeConfigPIX.ValidarCertificadoPSPSantander;
var
  a, e: String;
begin
  a := AdicionarPathAplicacao(edSantanderArqCertificadoPFX.Text);
  e := 'OK';
  if (a = '') then
    e := ACBrStr('Arquivo não informado')
  else if (not FileExists(a)) then
    e := ACBrStr('Arquivo não encontrado')
  else if EstaVazio(edSantanderSenhaCertificadoPFX.Text) then
    e := ACBrStr('Senha do Certificado PFX não informada')
  else
  begin
    try
      // Verifica se o arquivo PFX é válido
      ACBrOpenSSLUtils1.LoadPFXFromFile(a, edSantanderSenhaCertificadoPFX.Text);
    except
      On Ex: Exception do
        e := Ex.Message;
    end;
  end;

  lbSantanderErroCertificadoPFX.Caption := e;
  imSantanderErroCertificadoPFX.Visible := (e <> 'OK');
end;

procedure TframeConfigPIX.ValidarCertificadoPSPPagSeguro;
var
  a, e: String;
begin
  a := AdicionarPathAplicacao(edPagSeguroArqCertificado.Text);
  e := 'OK';
  if (a = '') then
    e := ACBrStr('Arquivo não especificado')
  else if (not FileExists(a)) then
    e := ACBrStr('Arquivo não encontrado')
  else
  begin
    try
      ACBrOpenSSLUtils1.LoadCertificateFromFile(a);  // Verifica se o arquivo de Chave é válido
    except
      On Ex: Exception do
        e := Ex.Message;
    end;
  end;

  lbPagSeguroErroCertificado.Caption := e;
  imPagSeguroErroCertificado.Visible := (e <> 'OK');
end;

procedure TframeConfigPIX.ValidarCertificadoPSPGerenciaNet;
var
  a, e: String;
begin
  a := AdicionarPathAplicacao(edGerenciaNetArqPFX.Text);
  e := 'OK';
  if (a = '') then
    e := ACBrStr('Arquivo não especificado')
  else if (not FileExists(a)) then
    e := ACBrStr('Arquivo não encontrado')
  else
  begin
    try
      ACBrOpenSSLUtils1.LoadPFXFromFile(a);
    except
      On Ex: Exception do
        e := Ex.Message;
    end;
  end;

  lbGerenciaNetErroPFX.Caption := e;
  imGerenciaNetErroPFX.Visible := (e <> 'OK');
end;

procedure TframeConfigPIX.ValidarCertificadoPSPBradesco;
var
  a, e: String;
begin
  a := AdicionarPathAplicacao(edBradescoArqCertificado.Text);
  e := 'OK';
  if (a = '') then
    e := ACBrStr('Arquivo não especificado')
  else if (not FileExists(a)) then
    e := ACBrStr('Arquivo não encontrado')
  else
  begin
    try
      ACBrOpenSSLUtils1.LoadPEMFromFile(a);
    except
      On Ex: Exception do
        e := Ex.Message;
    end;
  end;

  lbBradescoErroCertificado.Caption := e;
  lbBradescoErroCertificado.Visible := True;
  imBradescoErroCertificado.Visible := (e <> 'OK');
end;

procedure TframeConfigPIX.ValidarCertificadoPSPInter;
var
  a, e: String;
begin
  a := AdicionarPathAplicacao(edInterCertificado.Text);
  e := 'OK';
  if (a = '') then
    e := ACBrStr('Arquivo não especificado')
  else if (not FileExists(a)) then
    e := ACBrStr('Arquivo não encontrado')
  else
  begin
    try
      ACBrOpenSSLUtils1.LoadPEMFromFile(a);
    except
      On Ex: Exception do
        e := Ex.Message;
    end;
  end;

  lbInterErroCertificado.Caption := e;
  imInterErroCertificado.Visible := (e <> 'OK');
end;

procedure TframeConfigPIX.ValidarCertificadoPSPAilos;
var
  a, e: String;
begin
  a := AdicionarPathAplicacao(edAilosCertificado.Text);
  e := 'OK';
  if (a = '') then
    e := ACBrStr('Arquivo não especificado')
  else if (not FileExists(a)) then
    e := ACBrStr('Arquivo não encontrado')
  else
  begin
    try
      ACBrOpenSSLUtils1.LoadPEMFromFile(a);
    except
      On Ex: Exception do
        e := Ex.Message;
    end;
  end;

  lbAilosErroCertificado.Caption := e;
  imAilosErroCertificado.Visible := (e <> 'OK');
end;

procedure TframeConfigPIX.ValidarCertificadoRootPSPAilos;
var
  a, e: String;
begin
  a := AdicionarPathAplicacao(edAilosCertificadoRoot.Text);
  e := 'OK';
  if (a = '') then
    e := ACBrStr('Arquivo não especificado')
  else if (not FileExists(a)) then
    e := ACBrStr('Arquivo não encontrado');

  lbAilosErroCertificadoRoot.Caption := e;
  imAilosErroCertificadoRoot.Visible := (e <> 'OK');
end;

procedure TframeConfigPIX.ValidarCertificadoPSPMatera;
var
  a, e: String;
begin
  a := AdicionarPathAplicacao(edMateraArqCertificado.Text);
  e := 'OK';
  if (a = '') then
    e := 'Arquivo não especificado'
  else if (not FileExists(a)) then
    e := 'Arquivo não encontrado'
  else
  begin
    try
      ACBrOpenSSLUtils1.LoadPEMFromFile(a);
    except
      On Ex: Exception do
        e := Ex.Message;
    end;
  end;

  lbMateraErroCertificado.Caption := e;
  imMateraErroCertificado.Visible := (e <> 'OK');
end;

procedure TframeConfigPIX.ValidarCertificadoPSPBB;
var
  a, e: String;
begin
  a := AdicionarPathAplicacao(edBBArqCertificado.Text);
  e := 'OK';
  if (a = '') then
    e := ACBrStr('Arquivo não especificado')
  else if (not FileExists(a)) then
    e := ACBrStr('Arquivo não encontrado')
  else
  begin
    try
      ACBrOpenSSLUtils1.LoadPEMFromFile(a);
    except
      On Ex: Exception do
        e := Ex.Message;
    end;
  end;

  lbBBErroCertificado.Caption := e;
  imBBErroCertificado.Visible := (e <> 'OK');
end;

procedure TframeConfigPIX.ValidarCertificadoPSPC6Bank;
var
  a, e: String;
begin
  a := AdicionarPathAplicacao(edC6BankCertificado.Text);
  e := 'OK';
  if (a = '') then
    e := ACBrStr('Arquivo não especificado')
  else if (not FileExists(a)) then
    e := ACBrStr('Arquivo não encontrado')
  else
  begin
    try
      ACBrOpenSSLUtils1.LoadPEMFromFile(a);
    except
      On Ex: Exception do
        e := Ex.Message;
    end;
  end;

  lbC6BankErroCertificado.Caption := e;
  imC6BankErroCertificado.Visible := (e <> 'OK');
end;

procedure TframeConfigPIX.ValidarPFXPSPBB;
var
  a, e: String;
begin
  a := AdicionarPathAplicacao(edBBArqPFX.Text);
  e := 'OK';
  if (a = '') then
    e := ACBrStr('Arquivo não especificado')
  else if (not FileExists(a)) then
    e := ACBrStr('Arquivo não encontrado')
  else
  begin
    try
      ACBrOpenSSLUtils1.LoadPFXFromFile(a, edBBSenhaPFX.Text);
    except
      On Ex: Exception do
        e := Ex.Message;
    end;
  end;

  lbBBErroPFX.Caption := e;
  imBBErroPFX.Visible := (e <> 'OK');
end;

procedure TframeConfigPIX.ValidarPFXBanrisul;
var
  a, e: String;
begin
  a := AdicionarPathAplicacao(edBanrisulArqCertificadoPFX.Text);
  e := 'OK';
  if (a = '') then
    e := ACBrStr('Arquivo não informado')
  else if (not FileExists(a)) then
    e := ACBrStr('Arquivo não encontrado')
  else if EstaVazio(edBanrisulSenhaCertificadoPFX.Text) then
    e := ACBrStr('Senha do Certificado PFX não informada')
  else
  begin
    try
      // Verifica se o arquivo PFX é válido
      ACBrOpenSSLUtils1.LoadPFXFromFile(a, edBanrisulSenhaCertificadoPFX.Text);
    except
      On Ex: Exception do
        e := Ex.Message;
    end;
  end;

  lbBanrisulErroCertificadoPFX.Caption := e;
  imBanrisulErroCertificadoPFX.Visible := (e <> 'OK');
end;

procedure TframeConfigPIX.ValidarPFXBradesco;
var
  a, e: String;
begin
  a := AdicionarPathAplicacao(edBradescoArqPFX.Text);
  e := 'OK';
  if (a = '') then
    e := ACBrStr('Arquivo não especificado')
  else if (not FileExists(a)) then
    e := ACBrStr('Arquivo não encontrado')
  else
  begin
    try
      ACBrOpenSSLUtils1.LoadPFXFromFile(a, edBradescoSenhaPFX.Text);
    except
      On Ex: Exception do
        e := Ex.Message;
    end;
  end;

  lbBradescoErroPFX.Caption := e;
  lbBradescoErroPFX.Visible := True;
  imBradescoErroPFX.Visible := (e <> 'OK');
end;

procedure TframeConfigPIX.ValidarChavePSPItau;
var
  a, e: String;
begin
  a := AdicionarPathAplicacao(edtItauArqChavePrivada.Text);
  e := 'OK';
  if (a = '') then
    e := ACBrStr('Arquivo não especificado')
  else if (not FileExists(a)) then
    e := ACBrStr('Arquivo não encontrado')
  else
  begin
    try
      ACBrOpenSSLUtils1.LoadPrivateKeyFromFile(a);
    except
      On Ex: Exception do
        e := Ex.Message;
    end;
  end;

  lItauErroChavePrivada.Caption := e;
  imgItauErroChavePrivada.Visible := (e <> 'OK');
  btItauValidarChaveCertificado.Visible := imgItauErroChavePrivada.Visible;
end;

procedure TframeConfigPIX.ValidarCertificadoPSPItau;
var
  a, e: String;
begin
  a := AdicionarPathAplicacao(edtItauArqCertificado.Text);
  e := 'OK';
  if (a = '') then
    e := ACBrStr('Arquivo não especificado')
  else if (not FileExists(a)) then
    e := ACBrStr('Arquivo não encontrado')
  else
  begin
    try
      ACBrOpenSSLUtils1.LoadCertificateFromFile(a);  // Verifica se o arquivo de Chave é válido
    except
      On Ex: Exception do
        e := Ex.Message;
    end;
  end;

  lItauErroCertificado.Caption := e;
  imgItauErroCertificado.Visible := (e <> 'OK');
  btItauValidarChaveCertificado.Visible := imgItauErroCertificado.Visible;
end;

procedure TframeConfigPIX.LerConfiguracao;
var
  Ini: TIniFile;
begin
  AdicionarLinhaLog('- LerConfiguracao: '+NomeArquivoConfiguracao);
  Ini := TIniFile.Create(NomeArquivoConfiguracao);
  try
    edtRecebedorNome.Text := Ini.ReadString('Recebedor', 'Nome', '');
    edtRecebedorCEP.Text := Ini.ReadString('Recebedor', 'CEP', '');
    edtRecebedorCidade.Text := Ini.ReadString('Recebedor', 'Cidade', '');
    cbxRecebedorUF.ItemIndex := cbxRecebedorUF.Items.IndexOf(Ini.ReadString('Recebedor', 'UF', ''));

    cbAutenticacaoManual.Checked := Ini.ReadBool('Autenticar', 'Manual', False);

    cbxPSPAtual.ItemIndex := Ini.ReadInteger('PIX','PSP', 0);
    // Deste PDV (nao existem no exemplo do ACBrPIXCD)
    cbPIXHabilitado.Checked := Ini.ReadBool('PIX', 'Habilitado', False);
    cbxAmbiente.ItemIndex := Ini.ReadInteger('PIX','Ambiente', 0);
    seTimeout.Value := Ini.ReadInteger('PIX', 'TimeOut', ChttpTimeOutDef);

    seCobrancaExpiracao.Value := Ini.ReadInteger('Cobranca', 'Expiracao', seCobrancaExpiracao.Value);

    edtProxyHost.Text := Ini.ReadString('PIXProxy', 'Host', '');
    seProxyPorta.Text := Ini.ReadString('PIXProxy', 'Porta', '');
    edtProxyUser.Text := Ini.ReadString('PIXProxy', 'User', '');
    edtProxySenha.Text := StrCrypt(DecodeBase64(Ini.ReadString('PIXProxy', 'Pass', '')), CURL_ACBR);

    edtArqLog.Text := Ini.ReadString('PIXLog', 'Arquivo', '');
    cbxNivelLog.ItemIndex := Ini.ReadInteger('PIXLog', 'Nivel', 1);

    edtShipayClientID.Text := Ini.ReadString('Shipay', 'ClientID', '');
    edtShipaySecretKey.Text := Ini.ReadString('Shipay', 'SecretKey', '');
    edtShipayAccessKey.Text := Ini.ReadString('Shipay', 'AccessKey', '');

    edtBBChavePIX.Text := Ini.ReadString('BancoBrasil', 'ChavePIX', '');
    edtBBClientID.Text := Ini.ReadString('BancoBrasil', 'ClientID', '');
    edtBBClientSecret.Text := Ini.ReadString('BancoBrasil', 'ClientSecret', '');
    edtBBDevAppKey.Text := Ini.ReadString('BancoBrasil', 'DeveloperApplicationKey', '');
    edBBArqChavePrivada.Text := Ini.ReadString('BancoBrasil', 'ArqChavePrivada', edBBArqChavePrivada.Text);
    edBBArqCertificado.Text := Ini.ReadString('BancoBrasil', 'ArqCertificado', edBBArqCertificado.Text);
    edBBArqPFX.Text := Ini.ReadString('BancoBrasil', 'ArqPFX', edBBArqPFX.Text);
    edBBSenhaPFX.Text := Ini.ReadString('BancoBrasil', 'SenhaPFX', edBBSenhaPFX.Text);
    cbBBVersaoAPI.ItemIndex := Ini.ReadInteger('BancoBrasil', 'VersaoAPI', cbBBVersaoAPI.ItemIndex);
    rgBBTipoCertificado.ItemIndex := Ini.ReadInteger('BancoBrasil', 'TipoCertificado', rgBBTipoCertificado.ItemIndex);
    cbBBVersaoAPIChange(Nil);
    rgBBTipoCertificadoClick(Nil);

    edtItauChavePIX.Text := Ini.ReadString('Itau', 'ChavePIX', '');
    edtItauClientID.Text := Ini.ReadString('Itau', 'ClientID', '');
    edtItauClientSecret.Text := Ini.ReadString('Itau', 'ClientSecret', '');
    edtItauArqChavePrivada.Text := Ini.ReadString('Itau', 'ArqChavePrivada', edtItauArqChavePrivada.Text);
    edtItauArqCertificado.Text := Ini.ReadString('Itau', 'ArqCertificado', edtItauArqCertificado.Text);

    edSantanderChavePIX.Text := Ini.ReadString('Santander', 'ChavePIX', '');
    edSantanderConsumerKey.Text := Ini.ReadString('Santander', 'ConsumerKey', '');
    edSantanderConsumerSecret.Text := Ini.ReadString('Santander', 'ConsumerSecret', '');
    edSantanderArqCertificadoPFX.Text := Ini.ReadString('Santander', 'ArqCertificadoPFX', '');
    edSantanderSenhaCertificadoPFX.Text := Ini.ReadString('Santander', 'SenhaCertificadoPFX', '');

    edSicrediChavePIX.Text := Ini.ReadString('Sicredi', 'ChavePIX', '');
    edSicrediClientID.Text := Ini.ReadString('Sicredi', 'ClientID', '');
    edSicrediClientSecret.Text := Ini.ReadString('Sicredi', 'ClientSecret', '');
    edSicrediArqChavePrivada.Text := Ini.ReadString('Sicredi', 'ArqChavePrivada', edSicrediArqChavePrivada.Text);
    edSicrediArqCertificado.Text := Ini.ReadString('Sicredi', 'ArqCertificado', edSicrediArqCertificado.Text);
    edSicrediGerarCSR.Text := Ini.ReadString('Sicredi', 'CertificadoCSR', edSicrediGerarCSR.Text);
    edSicrediSenhaChavePrivada.Text := StrCrypt(DecodeBase64(Ini.ReadString('Sicredi', 'SenhaChavePrivada', '')), CURL_ACBR);
    edSicrediGerarChavePrivada.Text := edSicrediArqChavePrivada.Text;

    edSicoobChavePIX.Text := Ini.ReadString('Sicoob', 'ChavePIX', '');
    edSicoobClientID.Text := Ini.ReadString('Sicoob', 'ClientID', '');
    edSicoobTokenSandbox.Text := Ini.ReadString('Sicoob', 'TokenSandbox', '');
    edSicoobArqChavePrivada.Text := Ini.ReadString('Sicoob', 'ArqChavePrivada', edSicoobArqChavePrivada.Text);
    edSicoobArqCertificado.Text := Ini.ReadString('Sicoob', 'ArqCertificado', edSicoobArqCertificado.Text);

    edPagSeguroChavePIX.Text := Ini.ReadString('PagSeguro', 'ChavePIX', '');
    edPagSeguroToken1.Text := Ini.ReadString('PagSeguro', 'Token', '');
    edPagSeguroNomeApp1.Text := Ini.ReadString('PagSeguro', 'NomeApp', '');
    edPagSeguroClientID1.Text := Ini.ReadString('PagSeguro', 'ClientID', '');
    edPagSeguroClientSecret1.Text := Ini.ReadString('PagSeguro', 'ClientSecret', '');
    edPagSeguroArqChavePrivada.Text := Ini.ReadString('PagSeguro', 'ArqChavePrivada', edPagSeguroArqChavePrivada.Text);
    edPagSeguroArqCertificado.Text := Ini.ReadString('PagSeguro', 'ArqCertificado', edPagSeguroArqCertificado.Text);

    edGerenciaNetChavePIX.Text := Ini.ReadString('GerenciaNet', 'ChavePIX', '');
    edGerenciaNetClientID.Text := Ini.ReadString('GerenciaNet', 'ClientID', '');
    edGerenciaNetClientSecret.Text := Ini.ReadString('GerenciaNet', 'ClientSecret', '');
    edGerenciaNetArqPFX.Text := Ini.ReadString('GerenciaNet', 'ArqPFX', edGerenciaNetArqPFX.Text);

    edBradescoChavePIX.Text := Ini.ReadString('Bradesco', 'ChavePIX', '');
    edBradescoClientID.Text := Ini.ReadString('Bradesco', 'ClientID', '');
    edBradescoClientSecret.Text := Ini.ReadString('Bradesco', 'ClientSecret', '');
    cbBradescoAPIVersao.ItemIndex := Ini.ReadInteger('Bradesco', 'APIVersao', 0);
    rgBradescoTipoCertificado.ItemIndex := Ini.ReadInteger('Bradesco', 'TipoCertificado', 1);
    if EstaZerado(rgBradescoTipoCertificado.ItemIndex) then
    begin
      edBradescoArqPFX.Text := Ini.ReadString('Bradesco', 'ArqPFX', edBradescoArqPFX.Text);
      edBradescoSenhaPFX.Text := Ini.ReadString('Bradesco', 'SenhaPFX', '');
    end
    else
    begin
      edBradescoArqChavePrivada.Text := Ini.ReadString('Bradesco', 'ArqChavePrivada', edBradescoArqChavePrivada.Text);
      edBradescoArqCertificado.Text := Ini.ReadString('Bradesco', 'ArqCertificado', edBradescoArqCertificado.Text);
    end;

    edInterChavePIX.Text := Ini.ReadString('Inter', 'ChavePIX', '');
    edInterClientID.Text := Ini.ReadString('Inter', 'ClientID', '');
    edInterClientSecret.Text := Ini.ReadString('Inter', 'ClientSecret', '');
    edInterChavePrivada.Text := Ini.ReadString('Inter', 'ArqChavePrivada', edInterChavePrivada.Text);
    edInterCertificado.Text := Ini.ReadString('Inter', 'ArqCertificado', edInterCertificado.Text);

    edPixPDVCNPJ.Text := Ini.ReadString('PixPDV', 'CNPJ', '');
    edPixPDVToken.Text := Ini.ReadString('PixPDV', 'Token', '');
    edPixPDVSecretKey.Text := Ini.ReadString('PixPDV', 'SecretKey', '');
    cbPIXPDVVersaoAPI.ItemIndex := Ini.ReadInteger('PixPDV', 'VersaoAPI', cbPIXPDVVersaoAPI.ItemIndex);

    edAilosChavePIX.Text := Ini.ReadString('Ailos', 'ChavePIX', '');
    edAilosClientID.Text := Ini.ReadString('Ailos', 'ClientID', '');
    edAilosClientSecret.Text := Ini.ReadString('Ailos', 'ClientSecret', '');
    edAilosChavePrivada.Text := Ini.ReadString('Ailos', 'ArqChavePrivada', edAilosChavePrivada.Text);
    edAilosCertificado.Text := Ini.ReadString('Ailos', 'ArqCertificado', edAilosCertificadoRoot.Text);
    edAilosCertificadoRoot.Text := Ini.ReadString('Ailos', 'ArqCertificadoRoot', edAilosCertificadoRoot.Text);

    edMateraClientID.Text := Ini.ReadString('Matera', 'ClientID', '');
    edMateraSecretKey.Text := Ini.ReadString('Matera', 'SecretKey', '');
    edMateraClientSecret.Text := Ini.ReadString('Matera', 'ClientSecret', '');
    edMateraArqCertificado.Text := Ini.ReadString('Matera', 'ArqCertificado', '');
    edMateraArqChavePrivada.Text := Ini.ReadString('Matera', 'ArqChavePrivada', '');
    edMateraAccountId.Text := Ini.ReadString('Matera', 'AccountID', '');
    edMateraChavePIX.Text := Ini.ReadString('Matera', 'ChavePIX', '');
    edMateraMediatorFee.Text := FloatToString(Ini.ReadFloat('Matera', 'MediatorFee', 0));

    edCieloChavePIX.Text := Ini.ReadString('Cielo', 'ChavePIX', '');
    edCieloClientID.Text := Ini.ReadString('Cielo', 'ClientID', '');
    edCieloClientSecret.Text := Ini.ReadString('Cielo', 'ClientSecret', '');

    edMercadoPagoChavePIX.Text := Ini.ReadString('MercadoPago', 'ChavePix', '');
    edMercadoPagoAccessToken.Text := Ini.ReadString('MercadoPago', 'AccessToken', '');
    cbMercadoPagoTipoChave.ItemIndex := Ini.ReadInteger('MercadoPago', 'TipoChave', 0);

    edGate2AllAuthenticationApi.Text := Ini.ReadString('Gate2All', 'AuthenticationApi', '');
    edGate2AllAuthenticationKey.Text := Ini.ReadString('Gate2All', 'AuthenticationKey', '');

    edBanrisulChavePIX.Text := Ini.ReadString('Banrisul', 'ChavePIX', '');
    edBanrisulClientID.Text := Ini.ReadString('Banrisul', 'ClientID', '');
    edBanrisulClientSecret.Text := Ini.ReadString('Banrisul', 'ClientSecret', '');
    edBanrisulArqCertificadoPFX.Text := Ini.ReadString('Banrisul', 'ArqCertificadoPFX', '');
    edBanrisulSenhaCertificadoPFX.Text := Ini.ReadString('Banrisul', 'SenhaCertificadoPFX', '');

    edC6BankChavePIX.Text := Ini.ReadString('C6Bank', 'ChavePIX', '');
    edC6BankClientID.Text := Ini.ReadString('C6Bank', 'ClientID', '');
    edC6BankClientSecret.Text := Ini.ReadString('C6Bank', 'ClientSecret', '');
    edC6BankChavePrivada.Text := Ini.ReadString('C6Bank', 'ArqChavePrivada', edC6BankChavePrivada.Text);
    edC6BankCertificado.Text := Ini.ReadString('C6Bank', 'ArqCertificado', edC6BankCertificado.Text);

    edAppLessClientId.Text := Ini.ReadString('AppLess', 'ClientId', EmptyStr);
    edAppLessClientSecret.Text := Ini.ReadString('AppLess', 'ClientSecret', EmptyStr);
    edAppLessHMAC.Text := Ini.ReadString('AppLess', 'HMAC', EmptyStr);

    edQQPagChavePIX.Text := Ini.ReadString('QQPag', 'ChavePIX', '');
    edQQPagClientID.Text := Ini.ReadString('QQPag', 'ClientID', '');
    edQQPagClientSecret.Text := Ini.ReadString('QQPag', 'ClientSecret', '');

    edCrediSisAgencia.Text := Ini.ReadString('CrediSis', 'Agencia', '');
    edCrediSisConta.Text := Ini.ReadString('CrediSis', 'Conta', '');
    edCrediSisChavePIX.Text := Ini.ReadString('CrediSis', 'ChavePIX', '');
    edCrediSisClientID.Text := Ini.ReadString('CrediSis', 'ClientID', '');
    edCrediSisClientSecret.Text := Ini.ReadString('CrediSis', 'ClientSecret', '');
  finally
    Ini.Free;
  end;

  AplicarConfiguracao;
  LigarAlertasdeErrosDeConfiguracao;
end;

procedure TframeConfigPIX.GravarConfiguracao;
Var
  Ini : TIniFile ;
begin
  AdicionarLinhaLog('- GravarConfiguracao: '+NomeArquivoConfiguracao);
  Ini := TIniFile.Create(NomeArquivoConfiguracao);
  try
    Ini.WriteString('Recebedor', 'Nome', edtRecebedorNome.Text);
    Ini.WriteString('Recebedor', 'CEP', edtRecebedorCEP.Text);
    Ini.WriteString('Recebedor', 'Cidade', edtRecebedorCidade.Text);
    Ini.WriteString('Recebedor', 'UF', cbxRecebedorUF.Text);

    Ini.WriteBool('Autenticar', 'Manual', cbAutenticacaoManual.Checked);
    if (not cbAutenticacaoManual.Checked) then
    begin
      Ini.DeleteKey('Autenticar', 'Token');
      Ini.DeleteKey('Autenticar', 'Validade');
    end;

    Ini.WriteInteger('PIX','PSP', cbxPSPAtual.ItemIndex);

    // Deste PDV (nao existem no exemplo do ACBrPIXCD)

    Ini.WriteBool('PIX', 'Habilitado', cbPIXHabilitado.Checked);

    Ini.WriteInteger('PIX','Ambiente', cbxAmbiente.ItemIndex);
    Ini.WriteInteger('PIX', 'TimeOut', seTimeout.Value);

    Ini.WriteInteger('Cobranca', 'Expiracao', seCobrancaExpiracao.Value);

    Ini.WriteString('PIXProxy', 'Host', edtProxyHost.Text);
    Ini.WriteString('PIXProxy', 'Porta', seProxyPorta.Text);
    Ini.WriteString('PIXProxy', 'User', edtProxyUser.Text);
    Ini.WriteString('PIXProxy', 'Pass', EncodeBase64(StrCrypt(edtProxySenha.Text, CURL_ACBR)) );

    Ini.WriteString('PIXLog', 'Arquivo', edtArqLog.Text);
    Ini.WriteInteger('PIXLog', 'Nivel', cbxNivelLog.ItemIndex);

    Ini.WriteString('Shipay', 'ClientID', edtShipayClientID.Text);
    Ini.WriteString('Shipay', 'SecretKey', edtShipaySecretKey.Text);
    Ini.WriteString('Shipay', 'AccessKey', edtShipayAccessKey.Text);

    Ini.WriteString('BancoBrasil', 'ChavePIX', edtBBChavePIX.Text);
    Ini.WriteString('BancoBrasil', 'ClientID', edtBBClientID.Text);
    Ini.WriteString('BancoBrasil', 'ClientSecret', edtBBClientSecret.Text);
    Ini.WriteString('BancoBrasil', 'DeveloperApplicationKey', edtBBDevAppKey.Text);
    Ini.WriteString('BancoBrasil', 'ArqChavePrivada', edBBArqChavePrivada.Text);
    Ini.WriteString('BancoBrasil', 'ArqCertificado', edBBArqCertificado.Text);  
    Ini.WriteString('BancoBrasil', 'ArqPFX', edBBArqPFX.Text);
    Ini.WriteString('BancoBrasil', 'SenhaPFX', edBBSenhaPFX.Text);
    Ini.WriteInteger('BancoBrasil', 'VersaoAPI', cbBBVersaoAPI.ItemIndex);
    Ini.WriteInteger('BancoBrasil', 'TipoCertificado', rgBBTipoCertificado.ItemIndex);

    Ini.WriteString('Itau', 'ChavePIX', edtItauChavePIX.Text);
    Ini.WriteString('Itau', 'ClientID', edtItauClientID.Text);
    Ini.WriteString('Itau', 'ClientSecret', edtItauClientSecret.Text);
    Ini.WriteString('Itau', 'ArqChavePrivada', edtItauArqChavePrivada.Text);
    Ini.WriteString('Itau', 'ArqCertificado', edtItauArqCertificado.Text);

    Ini.WriteString('Santander', 'ChavePIX', edSantanderChavePIX.Text);
    Ini.WriteString('Santander', 'ConsumerKey', edSantanderConsumerKey.Text);
    Ini.WriteString('Santander', 'ConsumerSecret', edSantanderConsumerSecret.Text);
    Ini.WriteString('Santander', 'ArqCertificadoPFX', edSantanderArqCertificadoPFX.Text);
    Ini.WriteString('Santander', 'SenhaCertificadoPFX', edSantanderSenhaCertificadoPFX.Text);

    Ini.WriteString('Sicredi', 'ChavePIX', edSicrediChavePIX.Text);
    Ini.WriteString('Sicredi', 'ClientID', edSicrediClientID.Text);
    Ini.WriteString('Sicredi', 'ClientSecret', edSicrediClientSecret.Text);
    Ini.WriteString('Sicredi', 'ArqChavePrivada', edSicrediArqChavePrivada.Text);
    Ini.WriteString('Sicredi', 'SenhaChavePrivada', EncodeBase64(StrCrypt(edSicrediSenhaChavePrivada.Text, CURL_ACBR)));
    Ini.WriteString('Sicredi', 'ArqCertificado', edSicrediArqCertificado.Text);
    if FileExists(edSicrediGerarCSR.Text) then
      Ini.WriteString('Sicredi', 'CertificadoCSR', edSicrediGerarCSR.Text);

    Ini.WriteString('Sicoob', 'ChavePIX', edSicoobChavePIX.Text);
    Ini.WriteString('Sicoob', 'ClientID', edSicoobClientID.Text);
    Ini.WriteString('Sicoob', 'TokenSandbox', edSicoobTokenSandbox.Text);
    Ini.WriteString('Sicoob', 'ArqChavePrivada', edSicoobArqChavePrivada.Text);
    Ini.WriteString('Sicoob', 'ArqCertificado', edSicoobArqCertificado.Text);

    Ini.WriteString('PagSeguro', 'ChavePIX', edPagSeguroChavePIX.Text);
    Ini.WriteString('PagSeguro', 'ClientID', edPagSeguroToken1.Text);
    Ini.WriteString('PagSeguro', 'ClientID', edPagSeguroNomeApp1.Text);
    Ini.WriteString('PagSeguro', 'ClientSecret', edPagSeguroClientID1.Text);
    Ini.WriteString('PagSeguro', 'ClientSecret', edPagSeguroClientSecret1.Text);
    Ini.WriteString('PagSeguro', 'ArqChavePrivada', edPagSeguroArqChavePrivada.Text);
    Ini.WriteString('PagSeguro', 'ArqCertificado', edPagSeguroArqCertificado.Text);

    Ini.WriteString('GerenciaNet', 'ChavePIX', edGerenciaNetChavePIX.Text);
    Ini.WriteString('GerenciaNet', 'ClientID', edGerenciaNetClientID.Text);
    Ini.WriteString('GerenciaNet', 'ClientSecret', edGerenciaNetClientSecret.Text);
    Ini.WriteString('GerenciaNet', 'ArqPFX', edGerenciaNetArqPFX.Text);

    Ini.WriteString('Bradesco', 'ChavePIX', edBradescoChavePIX.Text);
    Ini.WriteString('Bradesco', 'ClientID', edBradescoClientID.Text);
    Ini.WriteString('Bradesco', 'ClientSecret', edBradescoClientSecret.Text);
    Ini.WriteInteger('Bradesco', 'APIVersao', cbBradescoAPIVersao.ItemIndex);
    Ini.WriteInteger('Bradesco', 'TipoCertificado', rgBradescoTipoCertificado.ItemIndex);
    Ini.WriteString('Bradesco', 'ArqPFX', edBradescoArqPFX.Text);
    Ini.WriteString('Bradesco', 'SenhaPFX', edBradescoSenhaPFX.Text);
    Ini.WriteString('Bradesco', 'ArqChavePrivada', edBradescoArqChavePrivada.Text);
    Ini.WriteString('Bradesco', 'ArqCertificado', edBradescoArqCertificado.Text);

    Ini.WriteString('Inter', 'ChavePIX', edInterChavePIX.Text);
    Ini.WriteString('Inter', 'ClientID', edInterClientID.Text);
    Ini.WriteString('Inter', 'ClientSecret', edInterClientSecret.Text);
    Ini.WriteString('Inter', 'ArqChavePrivada', edInterChavePrivada.Text);
    Ini.WriteString('Inter', 'ArqCertificado', edInterCertificado.Text);

    Ini.WriteString('PixPDV', 'CNPJ', edPixPDVCNPJ.Text);
    Ini.WriteString('PixPDV', 'Token', edPixPDVToken.Text);
    Ini.WriteString('PixPDV', 'SecretKey', edPixPDVSecretKey.Text);
    Ini.WriteInteger('PixPDV', 'VersaoAPI', cbPIXPDVVersaoAPI.ItemIndex);

    Ini.WriteString('Ailos', 'ChavePIX', edAilosChavePIX.Text);
    Ini.WriteString('Ailos', 'ClientID', edAilosClientID.Text);
    Ini.WriteString('Ailos', 'ClientSecret', edAilosClientSecret.Text);
    Ini.WriteString('Ailos', 'ArqChavePrivada', edAilosChavePrivada.Text);
    Ini.WriteString('Ailos', 'ArqCertificado', edAilosCertificado.Text);
    Ini.WriteString('Ailos', 'ArqCertificadoRoot', edAilosCertificadoRoot.Text);

    Ini.WriteString('Matera', 'ClientID', edMateraClientID.Text);
    Ini.WriteString('Matera', 'SecretKey', edMateraSecretKey.Text);
    Ini.WriteString('Matera', 'ClientSecret', edMateraClientSecret.Text);
    Ini.WriteString('Matera', 'ArqCertificado', edMateraArqCertificado.Text);
    Ini.WriteString('Matera', 'ArqChavePrivada', edMateraArqChavePrivada.Text);
    Ini.WriteString('Matera', 'AccountID', edMateraAccountId.Text);
    Ini.WriteString('Matera', 'ChavePIX', edMateraChavePIX.Text);
    Ini.WriteFloat('Matera', 'MediatorFee', StringToFloatDef(edMateraMediatorFee.Text, 0));

    Ini.WriteString('Cielo', 'ChavePIX', edCieloChavePIX.Text);
    Ini.WriteString('Cielo', 'ClientID', edCieloClientID.Text);
    Ini.WriteString('Cielo', 'ClientSecret', edCieloClientSecret.Text);

    Ini.WriteString('MercadoPago', 'ChavePix', edMercadoPagoChavePIX.Text);
    Ini.WriteString('MercadoPago', 'AccessToken', edMercadoPagoAccessToken.Text);
    Ini.WriteInteger('MercadoPago', 'TipoChave', cbMercadoPagoTipoChave.ItemIndex);

    Ini.WriteString('Gate2All', 'AuthenticationApi', edGate2AllAuthenticationApi.Text);
    Ini.WriteString('Gate2All', 'AuthenticationKey', edGate2AllAuthenticationKey.Text);

    Ini.WriteString('Banrisul', 'ChavePIX', edBanrisulChavePIX.Text);
    Ini.WriteString('Banrisul', 'ClientID', edBanrisulClientID.Text);
    Ini.WriteString('Banrisul', 'ClientSecret', edBanrisulClientSecret.Text);
    Ini.WriteString('Banrisul', 'ArqCertificadoPFX', edBanrisulArqCertificadoPFX.Text);
    Ini.WriteString('Banrisul', 'SenhaCertificadoPFX', edBanrisulSenhaCertificadoPFX.Text);

    Ini.WriteString('C6Bank', 'ChavePIX', edC6BankChavePIX.Text);
    Ini.WriteString('C6Bank', 'ClientID', edC6BankClientID.Text);
    Ini.WriteString('C6Bank', 'ClientSecret', edC6BankClientSecret.Text);
    Ini.WriteString('C6Bank', 'ArqChavePrivada', edC6BankChavePrivada.Text);
    Ini.WriteString('C6Bank', 'ArqCertificado', edC6BankCertificado.Text);

    Ini.WriteString('AppLess', 'ClientId', edAppLessClientId.Text);
    Ini.WriteString('AppLess', 'ClientSecret', edAppLessClientSecret.Text);
    Ini.WriteString('AppLess', 'HMAC', edAppLessHMAC.Text);

    Ini.WriteString('QQPag', 'ChavePIX', edQQPagChavePIX.Text);
    Ini.WriteString('QQPag', 'ClientID', edQQPagClientID.Text);
    Ini.WriteString('QQPag', 'ClientSecret', edQQPagClientSecret.Text);

    Ini.WriteString('CrediSis', 'Agencia', edCrediSisAgencia.Text);
    Ini.WriteString('CrediSis', 'Conta', edCrediSisConta.Text);
    Ini.WriteString('CrediSis', 'ChavePIX', edCrediSisChavePIX.Text);
    Ini.WriteString('CrediSis', 'ClientID', edCrediSisClientID.Text);
    Ini.WriteString('CrediSis', 'ClientSecret', edCrediSisClientSecret.Text);
  finally
     Ini.Free;
  end;

  LigarAlertasdeErrosDeConfiguracao;
end;

procedure TframeConfigPIX.AplicarConfiguracao;
begin
  AdicionarLinhaLog('- AplicarConfiguracao');
  ConfigurarACBrPIXCD;
  ConfigurarACBrPSPs;
end;

procedure TframeConfigPIX.InicializarBitmaps;
begin
  ImageList1.GetBitmap(6, imgErrNome.Picture.Bitmap);
  ImageList1.GetBitmap(6, imgErrCEP.Picture.Bitmap);
  ImageList1.GetBitmap(6, imgErrPSP.Picture.Bitmap);
  ImageList1.GetBitmap(6, imgBBErroChavePIX.Picture.Bitmap);
  ImageList1.GetBitmap(6, imBBErroPFX.Picture.Bitmap);
  ImageList1.GetBitmap(6, imBBErroCertificado.Picture.Bitmap);
  ImageList1.GetBitmap(6, imBBErroChavePrivada.Picture.Bitmap);

  ImageList1.GetBitmap(6, imgItauErroChavePIX.Picture.Bitmap);
  ImageList1.GetBitmap(6, imgItauErroClientID.Picture.Bitmap);
  ImageList1.GetBitmap(6, imgItauErroClientSecret.Picture.Bitmap);
  ImageList1.GetBitmap(6, imgItauErroChavePrivada.Picture.Bitmap);
  ImageList1.GetBitmap(6, imgItauErroCertificado.Picture.Bitmap);

  ImageList1.GetBitmap(6, imSicrediErroChavePix.Picture.Bitmap);
  ImageList1.GetBitmap(6, imSicrediErroCertificado.Picture.Bitmap);
  ImageList1.GetBitmap(6, imSicrediErroChavePrivada.Picture.Bitmap);

  ImageList1.GetBitmap(6, imSicoobErroChavePix.Picture.Bitmap);
  ImageList1.GetBitmap(6, imSicoobErroCertificado.Picture.Bitmap);
  ImageList1.GetBitmap(6, imSicoobErroChavePrivada.Picture.Bitmap);

  ImageList1.GetBitmap(6, imInterErroChavePix.Picture.Bitmap);
  ImageList1.GetBitmap(6, imInterErroCertificado.Picture.Bitmap);
  ImageList1.GetBitmap(6, imInterErroChavePrivada.Picture.Bitmap);
  ImageList1.GetBitmap(9, btInterAcharChavePrivada.Glyph);
  ImageList1.GetBitmap(9, btInterAcharCertificado.Glyph);

  ImageList1.GetBitmap(6, imAilosErroChavePix.Picture.Bitmap);
  ImageList1.GetBitmap(6, imAilosErroCertificado.Picture.Bitmap);
  ImageList1.GetBitmap(6, imAilosErroCertificadoRoot.Picture.Bitmap);
  ImageList1.GetBitmap(6, imAilosErroChavePrivada.Picture.Bitmap);
  ImageList1.GetBitmap(9, btAilosAcharChavePrivada.Glyph);
  ImageList1.GetBitmap(9, btAilosAcharCertificado.Glyph);
  ImageList1.GetBitmap(9, btAilosAcharCertificadoRoot.Glyph);

  ImageList1.GetBitmap(6, imSantanderErroChavePIX.Picture.Bitmap);
  ImageList1.GetBitmap(6, imSantanderErroCertificadoPFX.Picture.Bitmap);








  ImageList1.GetBitmap(5, btSicrediGerarChaveInfo.Glyph);
  ImageList1.GetBitmap(5, btSicrediGerarCSRInfo.Glyph);
  ImageList1.GetBitmap(5, btSicoobExtrairChaveCertificadoInfo.Glyph);

  ImageList1.GetBitmap(8, sbConsultaCEP.Glyph);
  ImageList1.GetBitmap(9, sbArqLog.Glyph);
  ImageList1.GetBitmap(7, sbVerSenhaProxy.Glyph);
  ImageList1.GetBitmap(7, sbSantanderVerSenhaPFX.Glyph);
  ImageList1.GetBitmap(7, sbSantanderExtrairCertificadoVerSenhaPFX.Glyph);
  ImageList1.GetBitmap(7, btSicoobExtrairChaveCertificadoVerSenhaPFX.Glyph);
  ImageList1.GetBitmap(9, sbGerenciaNetAcharPFX.Glyph);
  ImageList1.GetBitmap(9, sbBradescoAcharPFX.Glyph);
  ImageList1.GetBitmap(7, sbBradescoVerSenhaPFX.Glyph);
  ImageList1.GetBitmap(7, btBBVerSenhaPFX.Glyph);
  ImageList1.GetBitmap(7, btSicrediSenhaChavePrivada.Glyph);

  ImageList1.GetBitmap(16, btItauValidarChaveCertificado.Glyph);
  ImageList1.GetBitmap(9, sbItauAcharArqChavePrivada.Glyph);
  ImageList1.GetBitmap(9, sbItauAcharArqCertificado.Glyph);
  ImageList1.GetBitmap(28, btItauGerarChavePrivada.Glyph);
  ImageList1.GetBitmap(4, btItauSolicitarCertificado.Glyph);
  ImageList1.GetBitmap(4, btItauRenovarCertificado.Glyph);

  ImageList1.GetBitmap(10, btSalvarParametros.Glyph);
  ImageList1.GetBitmap(11, btLerParametros.Glyph);

  ImageList1.GetBitmap(9, sbBBAcharPFX.Glyph);
  ImageList1.GetBitmap(9, sbBBAcharChavePrivada.Glyph);
  ImageList1.GetBitmap(9, sbBBAcharArqCertificado.Glyph);
  ImageList1.GetBitmap(9, sbSicrediAcharChavePrivada.Glyph);
  ImageList1.GetBitmap(9, sbSicrediAcharArqCertificado.Glyph);
  ImageList1.GetBitmap(9, sbSicoobAcharChavePrivada.Glyph);
  ImageList1.GetBitmap(9, sbSicoobAcharArqCertificado.Glyph);
  ImageList1.GetBitmap(9, sbSantanderAcharCertificadoPFX.Glyph);
  ImageList1.GetBitmap(9, sbSantanderExtrairCertificadoPFX.Glyph);
  ImageList1.GetBitmap(9, btSicoobExtrairChaveCertificadoArqPFX.Glyph);
  ImageList1.GetBitmap(27, sbSantanderExtrairCertificadoInfo.Glyph);
                                                                 
  ImageList1.GetBitmap(7, sbBanrisulVerSenhaPFX.Glyph);
  ImageList1.GetBitmap(6, imBanrisulErroChavePix.Picture.Bitmap);
  ImageList1.GetBitmap(6, imBanrisulErroCertificadoPFX.Picture.Bitmap);
  ImageList1.GetBitmap(9, sbBanrisulAcharCertificadoPFX.Glyph);

  ImageList1.GetBitmap(6, imC6BankErroChavePix.Picture.Bitmap);
  ImageList1.GetBitmap(6, imC6BankErroCertificado.Picture.Bitmap);
  ImageList1.GetBitmap(6, imC6BankErroChavePrivada.Picture.Bitmap);
  ImageList1.GetBitmap(9, btC6BankAcharChavePrivada.Glyph);
  ImageList1.GetBitmap(9, btC6BankAcharCertificado.Glyph);
end;

procedure TframeConfigPIX.ConfigurarACBrPIXCD;
begin
  AdicionarLinhaLog('  - ConfigurarACBrPIXCD');
  ACBrPixCD1.Recebedor.Nome := edtRecebedorNome.Text;
  ACBrPixCD1.Recebedor.CEP := edtRecebedorCEP.Text;
  ACBrPixCD1.Recebedor.Cidade := edtRecebedorCidade.Text;
  ACBrPixCD1.Recebedor.UF := cbxRecebedorUF.Text;

  ACBrPixCD1.Ambiente := TACBrPixCDAmbiente(cbxAmbiente.ItemIndex);
  ACBrPixCD1.TimeOut := seTimeout.Value;

  ACBrPixCD1.Proxy.Host := edtProxyHost.Text;
  ACBrPixCD1.Proxy.Port := seProxyPorta.Text;
  ACBrPixCD1.Proxy.User := edtProxyUser.Text;
  ACBrPixCD1.Proxy.Pass := edtProxySenha.Text;

  ACBrPixCD1.ArqLOG := edtArqLog.Text;
  ACBrPixCD1.NivelLog := cbxNivelLog.ItemIndex;

  case cbxPSPAtual.ItemIndex of
    0: ACBrPixCD1.PSP := ACBrPSPShipay1;
    1: ACBrPixCD1.PSP := ACBrPSPBancoDoBrasil1;
    2: ACBrPixCD1.PSP := ACBrPSPItau1;
    3: ACBrPixCD1.PSP := ACBrPSPSantander1;
    4: ACBrPixCD1.PSP := ACBrPSPSicredi1;
    5: ACBrPixCD1.PSP := ACBrPSPSicoob1;
    6: ACBrPixCD1.PSP := ACBrPSPPagSeguro1;
    7: ACBrPixCD1.PSP := ACBrPSPGerenciaNet1;
    8: ACBrPixCD1.PSP := ACBrPSPBradesco1;
    9: ACBrPixCD1.PSP := ACBrPSPPixPDV1;
    10: ACBrPixCD1.PSP := ACBrPSPInter1;
    11: ACBrPixCD1.PSP := ACBrPSPAilos1;
    12: ACBrPixCD1.PSP := ACBrPSPMatera1;
    13: ACBrPixCD1.PSP := ACBrPSPCielo1;
    14: ACBrPixCD1.PSP := ACBrPSPMercadoPago1;
    15: ACBrPixCD1.PSP := ACBrPSPGate2All1;
    16: ACBrPixCD1.PSP := ACBrPSPBanrisul1;
    17: ACBrPixCD1.PSP := ACBrPSPC6Bank1;
    18: ACBrPixCD1.PSP := ACBrPSPAppLess1;
    19: ACBrPixCD1.PSP := ACBrPSPQQPag1;
    20: ACBrPixCD1.PSP := ACBrPSPCrediSIS1;
  else
    raise Exception.Create('PSP configurado é inválido');
  end;

  if cbAutenticacaoManual.Checked then
  begin
    ACBrPixCD1.PSP.OnAntesAutenticar := DoAntesAutenticar;
    ACBrPixCD1.PSP.OnDepoisAutenticar := DoDepoisAutenticar;
  end;
end;

procedure TframeConfigPIX.ConfigurarACBrPSPs;
begin
  AdicionarLinhaLog('  - ConfigurarACBrPSPs');

  ACBrPSPShipay1.ClientID := edtShipayClientID.Text;
  ACBrPSPShipay1.SecretKey := edtShipaySecretKey.Text;
  ACBrPSPShipay1.AccessKey := edtShipayAccessKey.Text;

  ACBrPSPBancoDoBrasil1.ChavePIX := edtBBChavePIX.Text;
  ACBrPSPBancoDoBrasil1.ClientID := edtBBClientID.Text;
  ACBrPSPBancoDoBrasil1.ClientSecret := edtBBClientSecret.Text;
  ACBrPSPBancoDoBrasil1.DeveloperApplicationKey := edtBBDevAppKey.Text;
  ACBrPSPBancoDoBrasil1.BBAPIVersao := TACBrBBAPIVersao(cbBBVersaoAPI.ItemIndex);

  if (ACBrPSPBancoDoBrasil1.BBAPIVersao = apiVersao2) then
  begin
    if (rgBBTipoCertificado.ItemIndex = 0) then  // Se usa PFX
    begin
      ACBrPSPBancoDoBrasil1.ArquivoPFX := edBBArqPFX.Text;
      ACBrPSPBancoDoBrasil1.SenhaPFX := edBBSenhaPFX.Text;
    end
    else  // Se usa Certificado PEM + Chave Privada
    begin
      ACBrPSPBancoDoBrasil1.ArquivoChavePrivada := edBBArqChavePrivada.Text;
      ACBrPSPBancoDoBrasil1.ArquivoCertificado := edBBArqCertificado.Text;
    end;
  end;

  ACBrPSPItau1.ChavePIX := edtItauChavePIX.Text;
  ACBrPSPItau1.ClientID := edtItauClientID.Text;
  ACBrPSPItau1.ClientSecret := edtItauClientSecret.Text;
  ACBrPSPItau1.ArquivoChavePrivada := edtItauArqChavePrivada.Text;
  ACBrPSPItau1.ArquivoCertificado := edtItauArqCertificado.Text;

  ACBrPSPSantander1.ChavePIX := edSantanderChavePIX.Text;
  ACBrPSPSantander1.ConsumerKey := edSantanderConsumerKey.Text;
  ACBrPSPSantander1.ConsumerSecret := edSantanderConsumerSecret.Text;
  ACBrPSPSantander1.SenhaPFX := edSantanderSenhaCertificadoPFX.Text;
  ACBrPSPSantander1.ArquivoPFX := edSantanderArqCertificadoPFX.Text;

  ACBrPSPSicredi1.ChavePIX := edSicrediChavePIX.Text;
  ACBrPSPSicredi1.ClientID := edSicrediClientID.Text;
  ACBrPSPSicredi1.ClientSecret := edSicrediClientSecret.Text;
  ACBrPSPSicredi1.ArquivoChavePrivada := edSicrediArqChavePrivada.Text;
  ACBrPSPSicredi1.ArquivoCertificado := edSicrediArqCertificado.Text;

  ACBrPSPSicoob1.ChavePIX := edSicoobChavePIX.Text;
  ACBrPSPSicoob1.ClientID := edSicoobClientID.Text;
  ACBrPSPSicoob1.TokenSandbox := edSicoobTokenSandbox.Text;
  ACBrPSPSicoob1.ArquivoChavePrivada := edSicoobArqChavePrivada.Text;
  ACBrPSPSicoob1.ArquivoCertificado := edSicoobArqCertificado.Text;

  ACBrPSPPagSeguro1.ChavePIX := edPagSeguroChavePIX.Text;
  ACBrPSPPagSeguro1.ClientID := edPagSeguroClientID1.Text;
  ACBrPSPPagSeguro1.TokenPay := edPagSeguroToken1.Text;
  ACBrPSPPagSeguro1.ClientSecret := edPagSeguroClientSecret1.Text;
  ACBrPSPPagSeguro1.ArquivoChavePrivada := edPagSeguroArqChavePrivada.Text;
  ACBrPSPPagSeguro1.ArquivoCertificado := edPagSeguroArqCertificado.Text;

  ACBrPSPGerenciaNet1.ChavePIX := edGerenciaNetChavePIX.Text;
  ACBrPSPGerenciaNet1.ClientID := edGerenciaNetClientID.Text;
  ACBrPSPGerenciaNet1.ClientSecret := edGerenciaNetClientSecret.Text;
  ACBrPSPGerenciaNet1.ArquivoPFX := edGerenciaNetArqPFX.Text;

  ACBrPSPBradesco1.ChavePIX := edBradescoChavePIX.Text;
  ACBrPSPBradesco1.ClientID := edBradescoClientID.Text;
  ACBrPSPBradesco1.ClientSecret := edBradescoClientSecret.Text;
  ACBrPSPBradesco1.APIVersao := TACBrBradescoAPIVersao(cbBradescoAPIVersao.ItemIndex);
  if (rgBradescoTipoCertificado.ItemIndex = 0) then  // Se usa PFX
  begin
    ACBrPSPBradesco1.ArquivoPFX := edBradescoArqPFX.Text;
    ACBrPSPBradesco1.SenhaPFX := edBradescoSenhaPFX.Text;
  end
  else  // Se usa Certificado PEM + Chave Privada
  begin
    ACBrPSPBradesco1.ArquivoChavePrivada := edBradescoArqChavePrivada.Text;
    ACBrPSPBradesco1.ArquivoCertificado := edBradescoArqCertificado.Text;
  end;

  ACBrPSPPixPDV1.CNPJ := edPixPDVCNPJ.Text;
  ACBrPSPPixPDV1.Token := edPixPDVToken.Text;
  ACBrPSPPixPDV1.ClientSecret := edPixPDVSecretKey.Text;
  ACBrPSPPixPDV1.APIVersao := TACBrPIXPDVAPIVersao(cbPIXPDVVersaoAPI.ItemIndex);

  ACBrPSPInter1.ChavePIX := edInterChavePIX.Text;
  ACBrPSPInter1.ClientID := edInterClientID.Text;
  ACBrPSPInter1.ClientSecret := edInterClientSecret.Text;
  ACBrPSPInter1.ArquivoChavePrivada := edInterChavePrivada.Text;
  ACBrPSPInter1.ArquivoCertificado := edInterCertificado.Text;

  ACBrPSPAilos1.ChavePIX := edAilosChavePIX.Text;
  ACBrPSPAilos1.ClientID := edAilosClientID.Text;
  ACBrPSPAilos1.ClientSecret := edAilosClientSecret.Text;
  ACBrPSPAilos1.ArquivoChavePrivada := edAilosChavePrivada.Text;
  ACBrPSPAilos1.ArquivoCertificado := edAilosCertificado.Text;
  ACBrPSPAilos1.RootCrt := edAilosCertificadoRoot.Text;
  
  ACBrPSPMatera1.ChavePIX := edMateraChavePIX.Text;
  ACBrPSPMatera1.ClientID := edMateraClientID.Text;
  ACBrPSPMatera1.AccountId := edMateraAccountId.Text;
  ACBrPSPMatera1.SecretKey := edMateraSecretKey.Text;
  ACBrPSPMatera1.MediatorFee := StringToFloatDef(edMateraMediatorFee.Text, 0);
  ACBrPSPMatera1.ClientSecret := edMateraClientSecret.Text;
  ACBrPSPMatera1.ArquivoCertificado := edMateraArqCertificado.Text;
  ACBrPSPMatera1.ArquivoChavePrivada := edMateraArqChavePrivada.Text;

  ACBrPSPCielo1.ChavePIX := edCieloChavePIX.Text;
  ACBrPSPCielo1.ClientID := edCieloClientID.Text;
  ACBrPSPCielo1.ClientSecret := edCieloClientSecret.Text;

  ACBrPSPMercadoPago1.ChavePIX := edMercadoPagoChavePIX.Text;
  ACBrPSPMercadoPago1.AccessToken := edMercadoPagoAccessToken.Text;
  ACBrPSPMercadoPago1.TipoChave := TACBrPIXTipoChave(cbMercadoPagoTipoChave.ItemIndex);

  ACBrPSPGate2All1.AuthenticationApi := edGate2AllAuthenticationApi.Text;
  ACBrPSPGate2All1.AuthenticationKey := edGate2AllAuthenticationKey.Text;

  ACBrPSPBanrisul1.ChavePIX := edBanrisulChavePIX.Text;
  ACBrPSPBanrisul1.ClientID := edBanrisulClientID.Text;
  ACBrPSPBanrisul1.ClientSecret := edBanrisulClientSecret.Text;
  ACBrPSPBanrisul1.ArquivoPFX := edBanrisulArqCertificadoPFX.Text;
  ACBrPSPBanrisul1.SenhaPFX := edBanrisulSenhaCertificadoPFX.Text;

  ACBrPSPC6Bank1.ChavePIX := edC6BankChavePIX.Text;
  ACBrPSPC6Bank1.ClientID := edC6BankClientID.Text;
  ACBrPSPC6Bank1.ClientSecret := edC6BankClientSecret.Text;
  ACBrPSPC6Bank1.ArquivoChavePrivada := edC6BankChavePrivada.Text;
  ACBrPSPC6Bank1.ArquivoCertificado := edC6BankCertificado.Text;

  ACBrPSPAppLess1.ClientID := edAppLessClientId.Text;
  ACBrPSPAppLess1.ClientSecret := edAppLessClientSecret.Text;
  ACBrPSPAppLess1.SecretKeyHMAC := edAppLessHMAC.Text;

  ACBrPSPQQPag1.ChavePIX := edQQPagChavePIX.Text;
  ACBrPSPQQPag1.ClientID := edQQPagClientID.Text;
  ACBrPSPQQPag1.ClientSecret := edQQPagClientSecret.Text;

  ACBrPSPCrediSIS1.Agencia := edCrediSisAgencia.Text;
  ACBrPSPCrediSIS1.Conta := edCrediSisConta.Text;
  ACBrPSPCrediSIS1.ChavePIX := edCrediSisChavePIX.Text;
  ACBrPSPCrediSIS1.ClientID := edCrediSisClientID.Text;
  ACBrPSPCrediSIS1.ClientSecret := edCrediSisClientSecret.Text;
end;

function TframeConfigPIX.RemoverPathAplicacao(const AFileName: String): String;
var
  s: String;
begin
  s := Trim(AFileName);
  if (pos(ApplicationPath, s) = 1) then
    Result := ExtractFileName(s)
  else
    Result := s;
end;

function TframeConfigPIX.AdicionarPathAplicacao(const AFileName: String): String;
var
  s: String;
begin
  s := Trim(AFileName);
  if (s = '') then
    Result := s
  else if (ExtractFilePath(AFileName) <> '') then
    Result := s
  else
    Result := ApplicationPath + s;
end;

procedure TframeConfigPIX.DoAntesAutenticar(var aToken: String;
  var aValidadeToken: TDateTime);
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(NomeArquivoConfiguracao);
  try
    aToken := Ini.ReadString('Autenticar', 'Token', EmptyStr);
    aValidadeToken := Ini.ReadDateTime('Autenticar', 'Validade', 0);
  finally
    Ini.Free;
  end;
end;

procedure TframeConfigPIX.DoDepoisAutenticar(const aToken: String;
  const aValidadeToken: TDateTime);
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(NomeArquivoConfiguracao);
  try
    Ini.WriteString('Autenticar', 'Token', aToken);
    Ini.WriteDateTime('Autenticar', 'Validade', aValidadeToken);
  finally
    Ini.Free;
  end;
end;

end.
