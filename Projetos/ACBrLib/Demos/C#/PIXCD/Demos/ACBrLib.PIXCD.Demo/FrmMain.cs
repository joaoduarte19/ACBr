using System;
using System.IO;
using System.Windows.Forms;
using ACBrLib;
using ACBrLib.Core;
using ACBrLib.Core.DFe;
using ACBrLib.Core.Extensions;
using ACBrLib.PIXCD;
using ACBrLib.Core.Config;
using System.Linq;
using ACBrLib.Core.PIXCD;

namespace ACBrLibPIXCD.Demo
{
    public partial class FrmMain : Form
    {
        #region Fields

        private IACBrLibPIXCD acbr_pixcd;

        #endregion Fields

        #region Constructors

        public FrmMain()
        {
            InitializeComponent();

            // Inicializando a classe e carregando a dll
            acbr_pixcd = new ACBrPIXCD();
        }

        #endregion Constructors

        #region Methods

        #region EventHandlers

        private void FrmMain_Shown(object sender, EventArgs e)
        {
            SplashScreenManager.Show<FrmWait>();
            SplashScreenManager.ShowInfo(SplashInfo.Message, "Carregando...");

            try
            {
                cmbPSP.EnumDataSource(PSP.pspBradesco);
                cmbAmbiente.EnumDataSource(Ambiente.ambTeste);
                cmbBBAPIVersao.EnumDataSource(BBAPIVersao.apiVersao1);
                cmbBradescoAPIVersao.EnumDataSource(BradescoAPIVersao.braVersao1);
                cmbPixPDVAPIVersao.EnumDataSource(PixPDVAPIVersao.apiVersao1);
                cmbNivelLogPSP.EnumDataSource(NivelLogPSP.logPSPNenhum);
                cmbTipoChave.EnumDataSource(TipoChave.tchNenhuma);
                acbr_pixcd.Config.ProxyPort = 0;
                
                // Altera as config de log
                acbr_pixcd.Config.Principal.LogNivel = NivelLog.logParanoico;

                var logPath = Path.Combine(Application.StartupPath, "Logs");
                if (!Directory.Exists(logPath))
                    Directory.CreateDirectory(logPath);

                acbr_pixcd.Config.Principal.LogPath = logPath;
                acbr_pixcd.ConfigGravar();

                LoadConfig();
            }
            finally
            {
                SplashScreenManager.Close();
            }
        }

        private void FrmMain_FormClosing(object sender, FormClosingEventArgs e)
        {
            // Liberando a dll
            acbr_pixcd.Dispose();
        }

        #endregion EventHandlers

        #endregion Methods

        private void btnSalvarConfiguracoes_Click(object sender, EventArgs e)
        {
            try
            {
                SalvarConfig();
            }
            catch (Exception exception)
            {
                MessageBox.Show(exception.Message, @"Erro", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void SalvarConfig()
        {
            SplashScreenManager.Show<FrmWait>();
            SplashScreenManager.ShowInfo(SplashInfo.Message, "Salvando...");

            try
            {
                //PIXCD
                acbr_pixcd.Config.Ambiente = cmbAmbiente.GetSelectedValue<Ambiente>();
                acbr_pixcd.Config.ArqLog = txtArqLogPSP.Text;
                acbr_pixcd.Config.NivelLog = cmbNivelLogPSP.GetSelectedValue<NivelLogPSP>();
                acbr_pixcd.Config.TipoChave = cmbTipoChave.GetSelectedValue<TipoChave>();
                acbr_pixcd.Config.PSP = cmbPSP.GetSelectedValue<PSP>();
                acbr_pixcd.Config.Timeout = (int)nudPSPTimeout.Value;
                acbr_pixcd.Config.ProxyHost = txtProxyServidor.Text;
                acbr_pixcd.Config.ProxyPass = txtProxySenha.Text;
                acbr_pixcd.Config.ProxyPort = (int)nudProxyPorta.Value;
                acbr_pixcd.Config.ProxyUser = txtProxyUsuario.Text;
                acbr_pixcd.Config.CEPRecebedor = txtCEPRecebedor.Text;
                acbr_pixcd.Config.CidadeRecebedor = txtCidadeRecebedor.Text;
                acbr_pixcd.Config.NomeRecebedor = txtNomeRecebedor.Text;
                acbr_pixcd.Config.UFRecebedor = txtUFRecebedor.Text;

                //Bradesco
                acbr_pixcd.Config.Bradesco.ChavePIX = txtChavePIXBradesco.Text;
                acbr_pixcd.Config.Bradesco.ClientID = txtClientIDBradesco.Text;
                acbr_pixcd.Config.Bradesco.ClientSecret = txtClientSecretBradesco.Text;
                acbr_pixcd.Config.Bradesco.ArqPFX = txtArquivoPFXBradesco.Text;
                acbr_pixcd.Config.Bradesco.SenhaPFX = txtSenhaCertificadoBradesco.Text;
                acbr_pixcd.Config.Bradesco.Scopes = txtScopesBradesco.Text;
                acbr_pixcd.Config.Bradesco.ArqChavePrivada = txtArquivoChavePrivadaBradesco.Text;
                acbr_pixcd.Config.Bradesco.ArqCertificado = txtArquivoCertificadoBradesco.Text;
                acbr_pixcd.Config.Bradesco.APIVersao = cmbBradescoAPIVersao.GetSelectedValue<BradescoAPIVersao>();

                //Sicredi
                acbr_pixcd.Config.Sicredi.ChavePIX = txtChavePIXSicredi.Text;
                acbr_pixcd.Config.Sicredi.ClientID = txtClientIDSicredi.Text;
                acbr_pixcd.Config.Sicredi.ClientSecret = txtClientSecretSicredi.Text;
                acbr_pixcd.Config.Sicredi.ArqChavePrivada = txtArquivoChavePrivadaSicredi.Text;
                acbr_pixcd.Config.Sicredi.ArqCertificado = txtArquivoCertificadoSicredi.Text;
                acbr_pixcd.Config.Sicredi.Scopes = txtScopesSicredi.Text;

                //Sicoob
                acbr_pixcd.Config.Sicoob.ChavePIX = txtChavePIXSicoob.Text;
                acbr_pixcd.Config.Sicoob.ClientID = txtClientIDSicoob.Text;
                acbr_pixcd.Config.Sicoob.TokenSandbox = txtTokenSandboxSicoob.Text;
                acbr_pixcd.Config.Sicoob.ArqChavePrivada = txtArquivoChavePrivadaSicoob.Text;
                acbr_pixcd.Config.Sicoob.ArqCertificado = txtArquivoCertificadoSicoob.Text;
                acbr_pixcd.Config.Sicoob.Scopes = txtScopesSicoob.Text;

                //Shipay
                acbr_pixcd.Config.Shipay.ClientID = txtClientIDShipay.Text;
                acbr_pixcd.Config.Shipay.SecretKey = txtSecretKeyShipay.Text;
                acbr_pixcd.Config.Shipay.AccessKey = txtAccessKeyShipay.Text;
                acbr_pixcd.Config.Shipay.Scopes = txtScopesShipay.Text;

                //Santander
                acbr_pixcd.Config.Santander.ChavePIX = txtChavePIXSantander.Text;
                acbr_pixcd.Config.Santander.ConsumerKey = txtConsumerKeySantander.Text;
                acbr_pixcd.Config.Santander.ConsumerSecret = txtConsumerSecretSantander.Text;
                acbr_pixcd.Config.Santander.ArqCertificadoPFX = txtArquivoCertificadoPFXSantander.Text;
                acbr_pixcd.Config.Santander.SenhaCertificadoPFX = txtSenhaCertificadoPFXSantander.Text;
                acbr_pixcd.Config.Santander.Scopes = txtScopesSantander.Text;

                //PixPDV
                acbr_pixcd.Config.PixPDV.CNPJ = txtCNPJPixPDV.Text;
                acbr_pixcd.Config.PixPDV.Token = txtPixPDVToken.Text;
                acbr_pixcd.Config.PixPDV.SecretKey = txtSecretKeyPixPDV.Text;
                acbr_pixcd.Config.PixPDV.PixPDVAPIVersao = cmbPixPDVAPIVersao.GetSelectedValue<PixPDVAPIVersao>();
                acbr_pixcd.Config.PixPDV.Scopes = txtScopesPixPDV.Text;

                //PagSeguro
                acbr_pixcd.Config.PagSeguro.ChavePIX = txtChavePIXPagSeguro.Text;
                acbr_pixcd.Config.PagSeguro.ClientID = txtClientIDPagSeguro.Text;
                acbr_pixcd.Config.PagSeguro.ClientSecret = txtClientSecretPagSeguro.Text;
                acbr_pixcd.Config.PagSeguro.ArqChavePrivada = txtArquivoChavePrivadaPagSeguro.Text;
                acbr_pixcd.Config.PagSeguro.ArqCertificado = txtArquivoCertificadoPagSeguro.Text;
                acbr_pixcd.Config.PagSeguro.Scopes = txtScopesPagSeguro.Text;

                //Itau
                acbr_pixcd.Config.Itau.ChavePIX = txtChavePIXItau.Text;
                acbr_pixcd.Config.Itau.ClientID = txtClientIDItau.Text;
                acbr_pixcd.Config.Itau.ClientSecret = txtClientSecretItau.Text;
                acbr_pixcd.Config.Itau.ArqChavePrivada = txtArquivoChavePrivadaItau.Text;
                acbr_pixcd.Config.Itau.ArqCertificado = txtArquivoCertificadoItau.Text;
                acbr_pixcd.Config.Itau.Scopes = txtScopesItau.Text;

                //Inter
                acbr_pixcd.Config.Inter.ChavePIX = txtChavePIXInter.Text;
                acbr_pixcd.Config.Inter.ClientID = txtClientIDInter.Text;
                acbr_pixcd.Config.Inter.ClientSecret = txtClientSecretInter.Text;
                acbr_pixcd.Config.Inter.ArqChavePrivada = txtArquivoChavePrivadaInter.Text;
                acbr_pixcd.Config.Inter.ArqCertificado = txtArquivoCertificadoInter.Text;
                acbr_pixcd.Config.Inter.Scopes = txtScopesInter.Text;

                //GerenciaNet
                acbr_pixcd.Config.GerenciaNet.ChavePIX = txtChavePIXGerenciaNet.Text;
                acbr_pixcd.Config.GerenciaNet.ClientID = txtClientIDGerenciaNet.Text;
                acbr_pixcd.Config.GerenciaNet.ClientSecret = txtClientSecretGerenciaNet.Text;
                acbr_pixcd.Config.GerenciaNet.ArqPFX = txtArquivoCertificadoGerenciaNet.Text;
                acbr_pixcd.Config.GerenciaNet.Scopes = txtScopesGerenciaNet.Text;

                //BancoBrasil
                acbr_pixcd.Config.BancoBrasil.ChavePIX = txtChavePIXBancoBrasil.Text;
                acbr_pixcd.Config.BancoBrasil.ClientID = txtClientIDBancoBrasil.Text;
                acbr_pixcd.Config.BancoBrasil.ClientSecret = txtClientSecretBancoBrasil.Text;
                acbr_pixcd.Config.BancoBrasil.DeveloperApplicationKey = txtDeveloperApplicationKeyBancoBrasil.Text;
                acbr_pixcd.Config.BancoBrasil.ArqChavePrivada = txtArquivoChavePrivadaBancoBrasil.Text;
                acbr_pixcd.Config.BancoBrasil.ArqCertificado = txtArquivoCertificadoBancoBrasil.Text;
                acbr_pixcd.Config.BancoBrasil.ArqPFX = txtArquivoPXFBancoBrasil.Text;
                acbr_pixcd.Config.BancoBrasil.SenhaPFX = txtSenhaPFXBancoBrasil.Text;
                acbr_pixcd.Config.BancoBrasil.BBAPIVersao = cmbBBAPIVersao.GetSelectedValue<BBAPIVersao>();
                acbr_pixcd.Config.BancoBrasil.Scopes = txtScopesBancoBrasil.Text;

                //Ailos
                acbr_pixcd.Config.Ailos.ChavePIX = txtChavePIXAilos.Text;
                acbr_pixcd.Config.Ailos.ClientID = txtClientIDAilos.Text;
                acbr_pixcd.Config.Ailos.ClientSecret = txtClientSecretAilos.Text;
                acbr_pixcd.Config.Ailos.ArqChavePrivada = txtArquivoChavePrivadaAilos.Text;
                acbr_pixcd.Config.Ailos.ArqCertificado = txtArquivoCertificadoAilos.Text;
                acbr_pixcd.Config.Ailos.ArqCertificadoRoot = txtArquivoCeriticadoRootAilos.Text;
                acbr_pixcd.Config.Ailos.Scopes = txtScopesAilos.Text;

                //Matera
                acbr_pixcd.Config.Matera.ChavePIX = txtChavePIXMatera.Text;
                acbr_pixcd.Config.Matera.ClientID = txtClientIDMatera.Text;
                acbr_pixcd.Config.Matera.SecretKey = txtSecretKeyMatera.Text;
                acbr_pixcd.Config.Matera.ClientSecret = txtClientSecretMatera.Text;
                acbr_pixcd.Config.Matera.ArqCertificado = txtArquivoCertificadoMatera.Text;
                acbr_pixcd.Config.Matera.ArqChavePrivada = txtArquivoChavePrivadaMatera.Text;
                acbr_pixcd.Config.Matera.AccountID = txtAccountIDMatera.Text;
                acbr_pixcd.Config.Matera.MediatorFee = txtMediatorFeeMatera.Text;
                acbr_pixcd.Config.Matera.Scopes = txtScopesMatera.Text;

                //Cielo
                acbr_pixcd.Config.Cielo.ChavePIX = txtChavePIXCielo.Text;
                acbr_pixcd.Config.Cielo.ClientID = txtClientIDCielo.Text;
                acbr_pixcd.Config.Cielo.ClientSecret = txtClientSecretCielo.Text;
                acbr_pixcd.Config.Cielo.ArqChavePrivada = txtArquivoChavePrivadaCielo.Text;
                acbr_pixcd.Config.Cielo.ArqCertificado = txtArquivoCertificadoCielo.Text;
                acbr_pixcd.Config.Cielo.Scopes = txtScopesCielo.Text;

                //MercadoPago
                acbr_pixcd.Config.MercadoPago.ChavePIX = txtChavePIXMercadoPago.Text;
                acbr_pixcd.Config.MercadoPago.AccessToken = txtAccessTokenMercadoPago.Text;
                acbr_pixcd.Config.MercadoPago.Scopes = txtScopesMercadoPago.Text;

                //AppLess
                acbr_pixcd.Config.AppLess.ClientID = txtClientIDAppLess.Text;
                acbr_pixcd.Config.AppLess.ClientSecret = txtClientSecretAppLess.Text;
                acbr_pixcd.Config.AppLess.SecretKeyHMAC = txtSecretKeyHMACAppLess.Text;
                acbr_pixcd.Config.AppLess.Scopes = txtScopesAppLess.Text;

                acbr_pixcd.ConfigGravar();

                Application.DoEvents();
            }
            finally
            {
                SplashScreenManager.Close();
            }
        }

        private void btnCarregarConfiguracoes_Click(object sender, EventArgs e)
        {
            var file = Helpers.OpenFile("Arquivos Ini (*.ini)|*.ini|Todos os Arquivos (*.*)|*.*");
            if (!File.Exists(file)) return;

            LoadConfig(file);
        }

        private void LoadConfig(string file = "ACBrLib.ini")
        {
            acbr_pixcd.ConfigLer(file);

            //PIXCD
            cmbAmbiente.SetSelectedValue(acbr_pixcd.Config.Ambiente);
            txtArqLogPSP.Text = acbr_pixcd.Config.ArqLog;
            cmbNivelLogPSP.SetSelectedValue(acbr_pixcd.Config.NivelLog);
            cmbTipoChave.SetSelectedValue(acbr_pixcd.Config.TipoChave);
            cmbPSP.SetSelectedValue(acbr_pixcd.Config.PSP);
            nudPSPTimeout.Value = acbr_pixcd.Config.Timeout;
            txtProxyServidor.Text = acbr_pixcd.Config.ProxyHost;
            txtProxySenha.Text = acbr_pixcd.Config.ProxyPass;
            nudProxyPorta.Value = acbr_pixcd.Config.ProxyPort;
            txtProxyUsuario.Text = acbr_pixcd.Config.ProxyUser;
            txtCEPRecebedor.Text = acbr_pixcd.Config.CEPRecebedor;
            txtCidadeRecebedor.Text = acbr_pixcd.Config.CidadeRecebedor;
            txtNomeRecebedor.Text = acbr_pixcd.Config.NomeRecebedor;
            txtUFRecebedor.Text = acbr_pixcd.Config.UFRecebedor;

            //Bradesco
            txtChavePIXBradesco.Text = acbr_pixcd.Config.Bradesco.ChavePIX;
            txtClientIDBradesco.Text = acbr_pixcd.Config.Bradesco.ClientID;
            txtClientSecretBradesco.Text = acbr_pixcd.Config.Bradesco.ClientSecret;
            txtArquivoPFXBradesco.Text = acbr_pixcd.Config.Bradesco.ArqPFX;
            txtSenhaCertificadoBradesco.Text = acbr_pixcd.Config.Bradesco.SenhaPFX;
            txtScopesBradesco.Text = acbr_pixcd.Config.Bradesco.Scopes;
            txtArquivoChavePrivadaBradesco.Text = acbr_pixcd.Config.Bradesco.ArqChavePrivada;
            txtArquivoCertificadoBradesco.Text = acbr_pixcd.Config.Bradesco.ArqCertificado;
            cmbBradescoAPIVersao.SetSelectedValue(acbr_pixcd.Config.Bradesco.APIVersao);

            //Sicredi
            txtChavePIXSicredi.Text = acbr_pixcd.Config.Sicredi.ChavePIX;
            txtClientIDSicredi.Text = acbr_pixcd.Config.Sicredi.ClientID;
            txtClientSecretSicredi.Text = acbr_pixcd.Config.Sicredi.ClientSecret;
            txtArquivoChavePrivadaSicredi.Text = acbr_pixcd.Config.Sicredi.ArqChavePrivada;
            txtArquivoCertificadoSicredi.Text = acbr_pixcd.Config.Sicredi.ArqCertificado;
            txtScopesSicredi.Text = acbr_pixcd.Config.Sicredi.Scopes;

            //Sicoob
            txtChavePIXSicoob.Text = acbr_pixcd.Config.Sicoob.ChavePIX;
            txtClientIDSicoob.Text = acbr_pixcd.Config.Sicoob.ClientID;
            txtTokenSandboxSicoob.Text = acbr_pixcd.Config.Sicoob.TokenSandbox;
            txtArquivoChavePrivadaSicoob.Text = acbr_pixcd.Config.Sicoob.ArqChavePrivada;
            txtArquivoCertificadoSicoob.Text = acbr_pixcd.Config.Sicoob.ArqCertificado;
            txtScopesSicoob.Text = acbr_pixcd.Config.Sicoob.Scopes;

            //Shipay
            txtClientIDShipay.Text = acbr_pixcd.Config.Shipay.ClientID;
            txtSecretKeyShipay.Text = acbr_pixcd.Config.Shipay.SecretKey;
            txtAccessKeyShipay.Text = acbr_pixcd.Config.Shipay.AccessKey;
            txtScopesShipay.Text = acbr_pixcd.Config.Shipay.Scopes;

            //Santander
            txtChavePIXSantander.Text = acbr_pixcd.Config.Santander.ChavePIX;
            txtConsumerKeySantander.Text = acbr_pixcd.Config.Santander.ConsumerKey;
            txtConsumerSecretSantander.Text = acbr_pixcd.Config.Santander.ConsumerSecret;
            txtArquivoCertificadoPFXSantander.Text = acbr_pixcd.Config.Santander.ArqCertificadoPFX;
            txtSenhaCertificadoPFXSantander.Text = acbr_pixcd.Config.Santander.SenhaCertificadoPFX;
            txtScopesSantander.Text = acbr_pixcd.Config.Santander.Scopes;

            //PixPDV
            txtCNPJPixPDV.Text = acbr_pixcd.Config.PixPDV.CNPJ;
            txtPixPDVToken.Text = acbr_pixcd.Config.PixPDV.Token;
            txtSecretKeyPixPDV.Text = acbr_pixcd.Config.PixPDV.SecretKey;
            cmbPixPDVAPIVersao.SetSelectedValue(acbr_pixcd.Config.PixPDV.PixPDVAPIVersao);
            txtScopesPixPDV.Text = acbr_pixcd.Config.PixPDV.Scopes;

            //PagSeguro
            txtChavePIXPagSeguro.Text = acbr_pixcd.Config.PagSeguro.ChavePIX;
            txtClientIDPagSeguro.Text = acbr_pixcd.Config.PagSeguro.ClientID;
            txtClientSecretPagSeguro.Text = acbr_pixcd.Config.PagSeguro.ClientSecret;
            txtArquivoChavePrivadaPagSeguro.Text = acbr_pixcd.Config.PagSeguro.ArqChavePrivada;
            txtArquivoCertificadoPagSeguro.Text = acbr_pixcd.Config.PagSeguro.ArqCertificado;
            txtScopesPagSeguro.Text = acbr_pixcd.Config.PagSeguro.Scopes;

            //Itau
            txtChavePIXItau.Text = acbr_pixcd.Config.Itau.ChavePIX;
            txtClientIDItau.Text = acbr_pixcd.Config.Itau.ClientID;
            txtClientSecretItau.Text = acbr_pixcd.Config.Itau.ClientSecret;
            txtArquivoChavePrivadaItau.Text = acbr_pixcd.Config.Itau.ArqChavePrivada;
            txtArquivoCertificadoItau.Text = acbr_pixcd.Config.Itau.ArqCertificado;
            txtScopesItau.Text = acbr_pixcd.Config.Itau.Scopes;

            //Inter
            txtChavePIXInter.Text = acbr_pixcd.Config.Inter.ChavePIX;
            txtClientIDInter.Text = acbr_pixcd.Config.Inter.ClientID;
            txtClientSecretInter.Text = acbr_pixcd.Config.Inter.ClientSecret;
            txtArquivoChavePrivadaInter.Text = acbr_pixcd.Config.Inter.ArqChavePrivada;
            txtArquivoCertificadoInter.Text = acbr_pixcd.Config.Inter.ArqCertificado;
            txtScopesInter.Text = acbr_pixcd.Config.Inter.Scopes;

            //GerenciaNet
            txtChavePIXGerenciaNet.Text = acbr_pixcd.Config.GerenciaNet.ChavePIX;
            txtClientIDGerenciaNet.Text = acbr_pixcd.Config.GerenciaNet.ClientID;
            txtClientSecretGerenciaNet.Text = acbr_pixcd.Config.GerenciaNet.ClientSecret;
            txtArquivoCertificadoGerenciaNet.Text = acbr_pixcd.Config.GerenciaNet.ArqPFX;
            txtScopesGerenciaNet.Text = acbr_pixcd.Config.GerenciaNet.Scopes;

            //BancoBrasil
            txtChavePIXBancoBrasil.Text = acbr_pixcd.Config.BancoBrasil.ChavePIX;
            txtClientIDBancoBrasil.Text = acbr_pixcd.Config.BancoBrasil.ClientID;
            txtClientSecretBancoBrasil.Text = acbr_pixcd.Config.BancoBrasil.ClientSecret;
            txtDeveloperApplicationKeyBancoBrasil.Text = acbr_pixcd.Config.BancoBrasil.DeveloperApplicationKey;
            txtArquivoChavePrivadaBancoBrasil.Text = acbr_pixcd.Config.BancoBrasil.ArqChavePrivada;
            txtArquivoCertificadoBancoBrasil.Text = acbr_pixcd.Config.BancoBrasil.ArqCertificado;
            txtArquivoPXFBancoBrasil.Text = acbr_pixcd.Config.BancoBrasil.ArqPFX;
            txtSenhaPFXBancoBrasil.Text = acbr_pixcd.Config.BancoBrasil.SenhaPFX;
            cmbBBAPIVersao.SetSelectedValue(acbr_pixcd.Config.BancoBrasil.BBAPIVersao);
            txtScopesBancoBrasil.Text = acbr_pixcd.Config.BancoBrasil.Scopes;           

            //Ailos
            txtChavePIXAilos.Text = acbr_pixcd.Config.Ailos.ChavePIX;
            txtClientIDAilos.Text = acbr_pixcd.Config.Ailos.ClientID;
            txtClientSecretAilos.Text = acbr_pixcd.Config.Ailos.ClientSecret;
            txtArquivoChavePrivadaAilos.Text = acbr_pixcd.Config.Ailos.ArqChavePrivada;
            txtArquivoCertificadoAilos.Text = acbr_pixcd.Config.Ailos.ArqCertificado;
            txtArquivoCeriticadoRootAilos.Text = acbr_pixcd.Config.Ailos.ArqCertificadoRoot;
            txtScopesAilos.Text = acbr_pixcd.Config.Ailos.Scopes;

            //Matera
            txtChavePIXMatera.Text = acbr_pixcd.Config.Matera.ChavePIX;
            txtClientIDMatera.Text = acbr_pixcd.Config.Matera.ClientID;
            txtSecretKeyMatera.Text = acbr_pixcd.Config.Matera.SecretKey;
            txtClientSecretMatera.Text = acbr_pixcd.Config.Matera.ClientSecret;
            txtArquivoCertificadoMatera.Text = acbr_pixcd.Config.Matera.ArqCertificado;
            txtArquivoChavePrivadaMatera.Text = acbr_pixcd.Config.Matera.ArqChavePrivada;
            txtAccountIDMatera.Text = acbr_pixcd.Config.Matera.AccountID;
            txtMediatorFeeMatera.Text = acbr_pixcd.Config.Matera.MediatorFee;
            txtScopesMatera.Text = acbr_pixcd.Config.Matera.Scopes;

            //Cielo
            txtChavePIXCielo.Text = acbr_pixcd.Config.Cielo.ChavePIX;
            txtClientIDCielo.Text = acbr_pixcd.Config.Cielo.ClientID;
            txtClientSecretCielo.Text = acbr_pixcd.Config.Cielo.ClientSecret;
            txtArquivoChavePrivadaCielo.Text = acbr_pixcd.Config.Cielo.ArqChavePrivada;
            txtArquivoCertificadoCielo.Text = acbr_pixcd.Config.Cielo.ArqCertificado;
            txtScopesCielo.Text = acbr_pixcd.Config.Cielo.Scopes;

            //MercadoPago
            txtChavePIXMercadoPago.Text = acbr_pixcd.Config.MercadoPago.ChavePIX;
            txtAccessTokenMercadoPago.Text = acbr_pixcd.Config.MercadoPago.AccessToken;
            txtScopesMercadoPago.Text = acbr_pixcd.Config.MercadoPago.Scopes;

            //AppLess
            txtClientIDAppLess.Text = acbr_pixcd.Config.AppLess.ClientID;
            txtClientSecretAppLess.Text = acbr_pixcd.Config.AppLess.ClientSecret;
            txtSecretKeyHMACAppLess.Text = acbr_pixcd.Config.AppLess.SecretKeyHMAC;
            txtScopesAppLess.Text = acbr_pixcd.Config.AppLess.Scopes;
        }

        private void btnCertificadoBradesco_Click(object sender, EventArgs e)
        {
            txtArquivoPFXBradesco.Text = Helpers.OpenFile("Arquivos PFX (*.pfx)|*.pfx|Todos os Arquivos (*.*)|*.*");
        }

        private void btnArquivoChavePrivadaSicredi_Click(object sender, EventArgs e)
        {
            txtArquivoChavePrivadaSicredi.Text = Helpers.OpenFile("Arquivos KEY (*.key)|*.key|Todos os Arquivos (*.*)|*.*");
        }

        private void btnArquivoCertificadoSicredi_Click(object sender, EventArgs e)
        {
            txtArquivoCertificadoSicredi.Text = Helpers.OpenFile("Arquivos CER (*.cer)|*.cer|Todos os Arquivos (*.*)|*.*");
        }

        private void btnArquivoChavePrivadaSicoob_Click(object sender, EventArgs e)
        {
            txtArquivoChavePrivadaSicoob.Text = Helpers.OpenFile("Arquivos KEY (*.key)|*.key|Todos os Arquivos (*.*)|*.*");
        }

        private void btnArquivoCertificadoSicoob_Click(object sender, EventArgs e)
        {
            txtArquivoCertificadoSicoob.Text = Helpers.OpenFile("Arquivos PEM (*.pem)|*.pem|Todos os Arquivos (*.*)|*.*");
        }

        private void btnArquivoCertificadoPFXSantander_Click(object sender, EventArgs e)
        {
            txtArquivoCertificadoPFXSantander.Text = Helpers.OpenFile("Arquivos PFX (*.pfx)|*.pfx|Todos os Arquivos (*.*)|*.*");
        }

        private void btnArquivoChavePrivadaPagSeguro_Click(object sender, EventArgs e)
        {
            txtArquivoChavePrivadaPagSeguro.Text = Helpers.OpenFile("Arquivos KEY (*.key)|*.key|Todos os Arquivos (*.*)|*.*");
        }

        private void btnArquivoCertificadoPagSeguro_Click(object sender, EventArgs e)
        {
            txtArquivoCertificadoPagSeguro.Text = Helpers.OpenFile("Arquivos PEM (*.pem)|*.pem|Todos os Arquivos (*.*)|*.*");
        }

        private void btnArquivoChavePrivadaItau_Click(object sender, EventArgs e)
        {
            txtArquivoChavePrivadaItau.Text = Helpers.OpenFile("Arquivos KEY (*.key)|*.key|Todos os Arquivos (*.*)|*.*");
        }

        private void btnArquivoCertificadoItau_Click(object sender, EventArgs e)
        {
            txtArquivoCertificadoItau.Text = Helpers.OpenFile("Arquivos PEM (*.pem)|*.pem|Todos os Arquivos (*.*)|*.*");
        }

        private void btnArquivoChavePrivadaInter_Click(object sender, EventArgs e)
        {
            txtArquivoChavePrivadaInter.Text = Helpers.OpenFile("Arquivos KEY (*.key)|*.key|Todos os Arquivos (*.*)|*.*");
        }

        private void btnArquivoCertificadoInter_Click(object sender, EventArgs e)
        {
            txtArquivoCertificadoInter.Text = Helpers.OpenFile("Arquivos PEM (*.pem)|*.pem|Todos os Arquivos (*.*)|*.*");
        }

        private void btnArquivoCertificadoGerenciaNet_Click(object sender, EventArgs e)
        {
            txtArquivoCertificadoGerenciaNet.Text = Helpers.OpenFile("Arquivos P12 (*.p12)|*.p12|Todos os Arquivos (*.*)|*.*");
        }

        private void btnArquivoChavePrivadaBancoBrasil_Click(object sender, EventArgs e)
        {
            txtArquivoChavePrivadaBancoBrasil.Text = Helpers.OpenFile("Arquivos KEY (*.key)|*.key|Todos os Arquivos (*.*)|*.*");
        }

        private void btnArquivoCertificadoBancoBrasil_Click(object sender, EventArgs e)
        {
            txtArquivoCertificadoBancoBrasil.Text = Helpers.OpenFile("Arquivos PEM (*.pem)|*.pem|Todos os Arquivos (*.*)|*.*");
        }

        private void btnArquivoPXFBancoBrasil_Click(object sender, EventArgs e)
        {
            txtArquivoPXFBancoBrasil.Text = Helpers.OpenFile("Arquivos PFX (*.pfx)|*.pfx|Todos os Arquivos (*.*)|*.*");
        }

        private void btnArquivoChavePrivadaAilos_Click(object sender, EventArgs e)
        {
            txtArquivoChavePrivadaAilos.Text = Helpers.OpenFile("Arquivos KEY (*.key)|*.key|Todos os Arquivos (*.*)|*.*");
        }

        private void btnArquivoCertificadoAilos_Click(object sender, EventArgs e)
        {
            txtArquivoCertificadoAilos.Text = Helpers.OpenFile("Arquivos PEM (*.pem)|*.pem|Todos os Arquivos (*.*)|*.*");
        }

        private void btnArquivoCeriticadoRootAilos_Click(object sender, EventArgs e)
        {
            txtArquivoCeriticadoRootAilos.Text = Helpers.OpenFile("Arquivos CRT (*.crt)|*.crt|Todos os Arquivos (*.*)|*.*");
        }

        private void btnArquivoChavePrivadaMatera_Click(object sender, EventArgs e)
        {
            txtArquivoChavePrivadaMatera.Text = Helpers.OpenFile("Arquivos KEY (*.key)|*.key|Todos os Arquivos (*.*)|*.*");
        }

        private void btnArquivoCertificadoMatera_Click(object sender, EventArgs e)
        {
            txtArquivoCertificadoMatera.Text = Helpers.OpenFile("Arquivos PEM (*.pem)|*.pem|Todos os Arquivos (*.*)|*.*");
        }
        private void btnArquivoChavePrivadaCielo_Click(object sender, EventArgs e)
        {
            txtArquivoChavePrivadaCielo.Text = Helpers.OpenFile("Arquivos KEY (*.key)|*.key|Todos os Arquivos (*.*)|*.*");
        }

        private void btnArquivoCertificadoCielo_Click(object sender, EventArgs e)
        {
            txtArquivoCertificadoCielo.Text = Helpers.OpenFile("Arquivos CER (*.cer)|*.cer|Todos os Arquivos (*.*)|*.*");
        }
        private void btnGerarQRCodeEstatico_Click(object sender, EventArgs e)
        {
            try
            {
                var ret = acbr_pixcd.GerarQRCodeEstatico(double.Parse(txtValor.Text), txtInformacoesAdicionais.Text, txtTxIdQRCodeEstatico.Text);
                rtbRespostas.AppendText(ret);
            } 
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, @"Erro", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void btnConsultarPix_Click(object sender, EventArgs e)
        {
            try
            {
                var ret = acbr_pixcd.ConsultarPix(txte2eidConsultarPIX.Text);
                rtbRespostas.AppendText(ret);
            } 
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, @"Erro", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void btnConsultarPixRecebidos_Click(object sender, EventArgs e)
        {
            try
            { 
                var ret = acbr_pixcd.ConsultarPixRecebidos(DateTime.Parse(txtDataInicialConsultarPIXRecebidos.Text), DateTime.Parse(txtDataFinalConsultarPIXRecebidos.Text), txtTxIdConsultarPIXRecebidos.Text, txtCPFCNPJConsultarPIXRecebidos.Text, (int)nudPagAtualConsultarPIXRecebidos.Value, (int)nudItensPorPaginaConsultarPIXRecebidos.Value);
                rtbRespostas.AppendText(ret);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, @"Erro", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void btnSolicitarDevolucaoPix_Click(object sender, EventArgs e)
        {
            try
            {
                var ret = acbr_pixcd.SolicitarDevolucaoPix(rtbSolicitarDevolucaoPIX.Text, txte2eidSolicitarDevolucaoPIX.Text, txtIdDevolucaoSolicitarDevolucaoPIX.Text);
                rtbRespostas.AppendText(ret);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, @"Erro", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void btnConsultarDevolucaoPix_Click(object sender, EventArgs e)
        {
            try
            {
                var ret = acbr_pixcd.ConsultarDevolucaoPix(txte2eidConsultarDevolucaoPIX.Text, txtIdDevolucaoConsultarDevolucaoPIX.Text);
                rtbRespostas.AppendText(ret);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, @"Erro", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void btnCriarCobrancaImediata_Click(object sender, EventArgs e)
        {
            try
            {
                var ret = acbr_pixcd.CriarCobrancaImediata(rtbCriarCobrancaImediata.Text, txtTxIdCriarCobrancaImediata.Text);
                rtbRespostas.AppendText(ret);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, @"Erro", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void btnConsultarCobrancaImediata_Click(object sender, EventArgs e)
        {
            try
            {
                var ret = acbr_pixcd.ConsultarCobrancaImediata(txtTxIdConsultarCobrancaImediata.Text, int.Parse(txtRevisaoConsultarCobrancaImediata.Text));
                rtbRespostas.AppendText(ret);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, @"Erro", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void btnConsultarCobrancasCob_Click(object sender, EventArgs e)
        {
            try
            {
                var ret = acbr_pixcd.ConsultarCobrancasCob(DateTime.Parse(txtDataInicialConsultarCobrancasCob.Text), DateTime.Parse(txtDataFinalConsultarCobrancasCob.Text), txtCPFCNPJConsultarCobrancasCob.Text, ckbLocationConsultarCobrancasCob.Checked, cmbStatusConsultarCobrancasCob.SelectedIndex, (int)nudPagAtualConsultarCobrancasCob.Value, (int)nudItensPorPaginaConsultarCobrancasCob.Value);
                rtbRespostas.AppendText(ret);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, @"Erro", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void btnConsultarCobrancasCobV_Click(object sender, EventArgs e)
        {
            try
            {
                var ret = acbr_pixcd.ConsultarCobrancasCobV(DateTime.Parse(txtDataInicialConsultarCobrancasCobV.Text), DateTime.Parse(txtDataFinalConsultarCobrancasCobV.Text), txtCPFCNPJConsultarCobrancasCobV.Text, ckbLocationConsultarCobrancasCobV.Checked, cmbStatusConsultarCobrancasCobV.SelectedIndex, (int)nudPagAtualConsultarCobrancasCobV.Value, (int)nudItensPorPaginaConsultarCobrancasCobV.Value);
                rtbRespostas.AppendText(ret);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, @"Erro", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void btnRevisarCobrancaImediata_Click(object sender, EventArgs e)
        {
            try
            {
                var ret = acbr_pixcd.RevisarCobrancaImediata(rtbRevisarCobrancaImediata.Text, txtTxIdRevisarCobrancaImediata.Text);
                rtbRespostas.AppendText(ret);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, @"Erro", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void btnCancelarCobrancaImediata_Click(object sender, EventArgs e)
        {
            try
            {
                var ret = acbr_pixcd.CancelarCobrancaImediata(txtTxIdCancelarCobrancaImediata.Text);
                rtbRespostas.AppendText(ret);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, @"Erro", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void btnCriarCobranca_Click(object sender, EventArgs e)
        {
            try
            {
                var ret = acbr_pixcd.CriarCobranca(rtbCriarCobranca.Text, txtTxIdCriarCobranca.Text);
                rtbRespostas.AppendText(ret);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, @"Erro", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void btnConsultarCobranca_Click(object sender, EventArgs e)
        {
            try
            {
                var ret = acbr_pixcd.ConsultarCobranca(txtTxIdConsultarCobranca.Text, int.Parse(txtRevisaoConsultarCobranca.Text));
                rtbRespostas.AppendText(ret);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, @"Erro", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void btnRevisarCobranca_Click(object sender, EventArgs e)
        {
            try
            {
                var ret = acbr_pixcd.RevisarCobranca(rtbRevisarCobranca.Text, txtTxIdRevisarCobranca.Text);
                rtbRespostas.AppendText(ret);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, @"Erro", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void btnCancelarCobranca_Click(object sender, EventArgs e)
        {
            try
            {
                var ret = acbr_pixcd.CancelarCobranca(txtTxIdCancelarCobranca.Text);
                rtbRespostas.AppendText(ret);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, @"Erro", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void btnOpenSSLInfo_Click(object sender, EventArgs e)
        {
            var ret = acbr_pixcd.OpenSSLInfo();
            rtbRespostas.AppendText(ret);
        }

        private void btnLimparRespostas_Click(object sender, EventArgs e)
        {
            rtbRespostas.Clear();
        }

        private void btnChavePrivadaBradesco_Click(object sender, EventArgs e)
        {
            txtArquivoChavePrivadaBradesco.Text = Helpers.OpenFile("Arquivos pem (*.pem)|*.pem|Todos os Arquivos (*.*)|*.*");
        }

        private void btnArqCertificadoBradesco_Click(object sender, EventArgs e)
        {
            txtArquivoCertificadoBradesco.Text = Helpers.OpenFile("Arquivos cer (*.cer)|*.cer|Todos os Arquivos (*.*)|*.*");
        }
    }
}