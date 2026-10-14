using System;
using System.IO;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using ACBrLib;
using ACBrLib.Core;
using ACBrLib.Core.IMendes;
using ACBrLib.IMendes;

namespace ACBrLibIMendes.Demo
{
    public partial class FrmMain : Form
    {
        #region Fields

        private IACBrLibIMendes acbrIMendes;

        #endregion Fields

        #region Constructors

        public FrmMain()
        {
            InitializeComponent();

            // Inicializando a classe e carregando a dll
            acbrIMendes = new ACBrIMendes();
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
                cmbAmbiente.EnumDataSource(Ambiente.imaHomologacao);
                cmbTipoResposta.EnumDataSource(TipoResposta.fmtINI);
                cmbTipoDescricao.SelectedIndex = 0;

                // Altera as config de log
                acbrIMendes.Config.Principal.LogNivel = NivelLog.logParanoico;

                var logPath = Path.Combine(Application.StartupPath, "Logs");
                if (!Directory.Exists(logPath))
                    Directory.CreateDirectory(logPath);

                acbrIMendes.Config.Principal.LogPath = logPath;
                acbrIMendes.ConfigGravar();

                LoadConfig();

                txtIniSaneamento.Text = IniSaneamentoExemplo();
            }
            finally
            {
                SplashScreenManager.Close();
            }
        }

        private void FrmMain_FormClosing(object sender, FormClosingEventArgs e)
        {
            // Liberando a dll
            acbrIMendes.Dispose();
        }

        #endregion EventHandlers

        #region Configuracoes

        private void btnLerConfig_Click(object sender, EventArgs e)
        {
            var file = Helpers.OpenFile("Arquivos Ini (*.ini)|*.ini|Todos os Arquivos (*.*)|*.*");
            if (!File.Exists(file)) return;

            LoadConfig(file);
        }

        private void btnGravarConfig_Click(object sender, EventArgs e)
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

        private void btnArqLog_Click(object sender, EventArgs e)
        {
            var file = Helpers.SaveFile("Arquivos Log (*.log)|*.log|Todos os Arquivos (*.*)|*.*");
            if (string.IsNullOrEmpty(file)) return;

            txtArqLog.Text = file;
        }

        private void SalvarConfig()
        {
            SplashScreenManager.Show<FrmWait>();
            SplashScreenManager.ShowInfo(SplashInfo.Message, "Salvando...");

            try
            {
                acbrIMendes.Config.Principal.TipoResposta = cmbTipoResposta.GetSelectedValue<TipoResposta>();

                acbrIMendes.Config.Ambiente = cmbAmbiente.GetSelectedValue<Ambiente>();
                acbrIMendes.Config.CNPJ = txtCNPJ.Text;
                acbrIMendes.Config.Senha = txtSenha.Text;
                acbrIMendes.Config.ArqLog = txtArqLog.Text;
                acbrIMendes.Config.NivelLog = (int)nudNivelLog.Value;
                acbrIMendes.Config.Timeout = (int)nudTimeout.Value;
                acbrIMendes.Config.MaxProdutosPorEnvio = (int)nudMaxProdutos.Value;

                acbrIMendes.Config.Proxy.Servidor = txtProxyServidor.Text;
                acbrIMendes.Config.Proxy.Porta = txtProxyPorta.Text;
                acbrIMendes.Config.Proxy.Usuario = txtProxyUsuario.Text;
                acbrIMendes.Config.Proxy.Senha = txtProxySenha.Text;

                acbrIMendes.ConfigGravar();

                Application.DoEvents();
            }
            finally
            {
                SplashScreenManager.Close();
            }
        }

        private void LoadConfig(string file = "ACBrLib.ini")
        {
            acbrIMendes.ConfigLer(file);

            cmbTipoResposta.SetSelectedValue(acbrIMendes.Config.Principal.TipoResposta);

            cmbAmbiente.SetSelectedValue(acbrIMendes.Config.Ambiente);
            txtCNPJ.Text = acbrIMendes.Config.CNPJ;
            txtSenha.Text = acbrIMendes.Config.Senha;
            txtArqLog.Text = acbrIMendes.Config.ArqLog;
            nudNivelLog.Value = Limitar(acbrIMendes.Config.NivelLog, nudNivelLog);
            nudTimeout.Value = Limitar(acbrIMendes.Config.Timeout, nudTimeout);
            nudMaxProdutos.Value = Limitar(acbrIMendes.Config.MaxProdutosPorEnvio, nudMaxProdutos);

            txtProxyServidor.Text = acbrIMendes.Config.Proxy.Servidor;
            txtProxyPorta.Text = acbrIMendes.Config.Proxy.Porta;
            txtProxyUsuario.Text = acbrIMendes.Config.Proxy.Usuario;
            txtProxySenha.Text = acbrIMendes.Config.Proxy.Senha;
        }

        private static decimal Limitar(int valor, NumericUpDown nud)
        {
            return Math.Max(nud.Minimum, Math.Min(nud.Maximum, valor));
        }

        #endregion Configuracoes

        #region Consultas

        private void btnConsultarDescricao_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtDescricao.Text))
            {
                MessageBox.Show("Informe a descrição !");
                return;
            }

            Executar(() => acbrIMendes.ConsultarDescricao(txtDescricao.Text, txtCNPJConsulta.Text, cmbTipoDescricao.SelectedIndex));
        }

        private void btnConsultarAlterados_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtUFAlterados.Text))
            {
                MessageBox.Show("Informe a UF !");
                return;
            }

            Executar(() => acbrIMendes.ConsultarAlterados(txtUFAlterados.Text, txtCNPJConsulta.Text, (int)nudLimite.Value));
        }

        private void btnHistoricoAcesso_Click(object sender, EventArgs e)
        {
            Executar(() => acbrIMendes.HistoricoAcesso(txtCNPJConsulta.Text));
        }

        private void btnConsultarRegimes_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtUFRegimes.Text))
            {
                MessageBox.Show("Informe a UF !");
                return;
            }

            Executar(() => acbrIMendes.ConsultarRegimesEspeciais(txtUFRegimes.Text, chkIncludeTrib.Checked));
        }

        #endregion Consultas

        #region Saneamento

        private void btnCarregarIni_Click(object sender, EventArgs e)
        {
            var file = Helpers.OpenFile("Arquivos Ini (*.ini)|*.ini|Todos os Arquivos (*.*)|*.*");
            if (!File.Exists(file)) return;

            txtIniSaneamento.Text = File.ReadAllText(file);
        }

        private void btnSaneamento_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtIniSaneamento.Text))
            {
                MessageBox.Show("Informe o INI de entrada !");
                return;
            }

            // Pode ser informado o caminho do arquivo INI ou o conteúdo INI
            Executar(() => acbrIMendes.SaneamentoGrades(txtIniSaneamento.Text));
        }

        private static string IniSaneamentoExemplo()
        {
            var ini = new StringBuilder();
            ini.AppendLine("[Emitente]");
            ini.AppendLine("amb=1");
            ini.AppendLine("cnpj=00000000000000");
            ini.AppendLine("crt=3");
            ini.AppendLine("regimeTrib=LR");
            ini.AppendLine("uf=SP");
            ini.AppendLine("cnae=4639701");
            ini.AppendLine();
            ini.AppendLine("[Perfil]");
            ini.AppendLine("uf=PR|SP");
            ini.AppendLine("caracTrib=3");
            ini.AppendLine("cfop=6403");
            ini.AppendLine("finalidade=0");
            ini.AppendLine("origem=0");
            ini.AppendLine();
            ini.AppendLine("[Produto001]");
            ini.AppendLine("codigo=07898278710058");
            ini.AppendLine("codInterno=N");
            ini.AppendLine("descricao=MORTADELA");
            ini.AppendLine("ncm=16010000");
            return ini.ToString();
        }

        #endregion Saneamento

        #region Produtos

        private void btnInativar_Click(object sender, EventArgs e)
        {
            var codigos = Linhas(txtInativarCodigos.Text);
            if (codigos.Length == 0)
            {
                MessageBox.Show("Informe os códigos dos produtos (um por linha) !");
                return;
            }

            // Sem cnpj no INI a biblioteca utiliza o CNPJ da configuração [IMendes]
            var ini = new StringBuilder();
            ini.AppendLine("[Inativar]");
            for (var i = 0; i < codigos.Length; i++)
            {
                ini.AppendLine($"[Produto{i + 1:000}]");
                ini.AppendLine($"codigo={codigos[i]}");
                ini.AppendLine($"interno={(chkCodigosInternos.Checked ? "S" : "N")}");
            }

            Executar(() => acbrIMendes.Inativar(ini.ToString()));
        }

        private void btnRemoveDevolvidos_Click(object sender, EventArgs e)
        {
            var ids = Linhas(txtRemoveIds.Text);
            if (ids.Length == 0)
            {
                MessageBox.Show("Informe os IDs dos produtos (um por linha) !");
                return;
            }

            // Sem cnpj no INI a biblioteca utiliza o CNPJ da configuração [IMendes]
            var ini = new StringBuilder();
            ini.AppendLine("[RemoveDevolvidos]");
            for (var i = 0; i < ids.Length; i++)
            {
                ini.AppendLine($"[Produto{i + 1:000}]");
                ini.AppendLine($"id={ids[i]}");
            }

            Executar(() => acbrIMendes.RemoveDevolvidos(ini.ToString()));
        }

        private static string[] Linhas(string texto)
        {
            return texto.Split(new[] { "\r\n", "\n" }, StringSplitOptions.RemoveEmptyEntries)
                        .Select(x => x.Trim())
                        .Where(x => x.Length > 0)
                        .ToArray();
        }

        #endregion Produtos

        #region Respostas

        private void btnLimparRespostas_Click(object sender, EventArgs e)
        {
            rtbRespostas.Clear();
        }

        private void Executar(Func<string> metodo)
        {
            try
            {
                rtbRespostas.Clear();
                var ret = metodo();
                rtbRespostas.AppendText(ret);
            }
            catch (Exception exception)
            {
                rtbRespostas.AppendText(exception.Message);
                MessageBox.Show(exception.Message, @"Erro", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        #endregion Respostas

        #endregion Methods
    }
}
