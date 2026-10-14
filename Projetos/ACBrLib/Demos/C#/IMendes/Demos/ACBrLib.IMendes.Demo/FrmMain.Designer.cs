namespace ACBrLibIMendes.Demo
{
    partial class FrmMain
    {
        /// <summary>
        /// Variável de designer necessária.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Limpar os recursos que estão sendo usados.
        /// </summary>
        /// <param name="disposing">true se for necessário descartar os recursos gerenciados; caso contrário, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Código gerado pelo Windows Form Designer

        /// <summary>
        /// Método necessário para suporte ao Designer - não modifique
        /// o conteúdo deste método com o editor de código.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(FrmMain));
            this.tabControl1 = new System.Windows.Forms.TabControl();
            this.tabConsultas = new System.Windows.Forms.TabPage();
            this.grpRegimes = new System.Windows.Forms.GroupBox();
            this.btnConsultarRegimes = new System.Windows.Forms.Button();
            this.chkIncludeTrib = new System.Windows.Forms.CheckBox();
            this.txtUFRegimes = new System.Windows.Forms.TextBox();
            this.lblUFRegimes = new System.Windows.Forms.Label();
            this.grpHistorico = new System.Windows.Forms.GroupBox();
            this.btnHistoricoAcesso = new System.Windows.Forms.Button();
            this.grpAlterados = new System.Windows.Forms.GroupBox();
            this.btnConsultarAlterados = new System.Windows.Forms.Button();
            this.nudLimite = new System.Windows.Forms.NumericUpDown();
            this.lblLimite = new System.Windows.Forms.Label();
            this.txtUFAlterados = new System.Windows.Forms.TextBox();
            this.lblUFAlterados = new System.Windows.Forms.Label();
            this.grpDescricao = new System.Windows.Forms.GroupBox();
            this.btnConsultarDescricao = new System.Windows.Forms.Button();
            this.cmbTipoDescricao = new System.Windows.Forms.ComboBox();
            this.lblTipoDescricao = new System.Windows.Forms.Label();
            this.txtDescricao = new System.Windows.Forms.TextBox();
            this.lblDescricao = new System.Windows.Forms.Label();
            this.lblCNPJConsultaInfo = new System.Windows.Forms.Label();
            this.txtCNPJConsulta = new System.Windows.Forms.TextBox();
            this.lblCNPJConsulta = new System.Windows.Forms.Label();
            this.tabSaneamento = new System.Windows.Forms.TabPage();
            this.btnSaneamento = new System.Windows.Forms.Button();
            this.btnCarregarIni = new System.Windows.Forms.Button();
            this.txtIniSaneamento = new System.Windows.Forms.TextBox();
            this.lblIniSaneamento = new System.Windows.Forms.Label();
            this.tabProdutos = new System.Windows.Forms.TabPage();
            this.grpRemoveDevolvidos = new System.Windows.Forms.GroupBox();
            this.btnRemoveDevolvidos = new System.Windows.Forms.Button();
            this.txtRemoveIds = new System.Windows.Forms.TextBox();
            this.lblRemoveIds = new System.Windows.Forms.Label();
            this.grpInativar = new System.Windows.Forms.GroupBox();
            this.btnInativar = new System.Windows.Forms.Button();
            this.chkCodigosInternos = new System.Windows.Forms.CheckBox();
            this.txtInativarCodigos = new System.Windows.Forms.TextBox();
            this.lblInativarCodigos = new System.Windows.Forms.Label();
            this.tabConfiguracao = new System.Windows.Forms.TabPage();
            this.grpProxy = new System.Windows.Forms.GroupBox();
            this.txtProxySenha = new System.Windows.Forms.TextBox();
            this.lblProxySenha = new System.Windows.Forms.Label();
            this.txtProxyUsuario = new System.Windows.Forms.TextBox();
            this.lblProxyUsuario = new System.Windows.Forms.Label();
            this.txtProxyPorta = new System.Windows.Forms.TextBox();
            this.lblProxyPorta = new System.Windows.Forms.Label();
            this.txtProxyServidor = new System.Windows.Forms.TextBox();
            this.lblProxyServidor = new System.Windows.Forms.Label();
            this.grpIMendes = new System.Windows.Forms.GroupBox();
            this.nudMaxProdutos = new System.Windows.Forms.NumericUpDown();
            this.lblMaxProdutos = new System.Windows.Forms.Label();
            this.nudTimeout = new System.Windows.Forms.NumericUpDown();
            this.lblTimeout = new System.Windows.Forms.Label();
            this.nudNivelLog = new System.Windows.Forms.NumericUpDown();
            this.lblNivelLog = new System.Windows.Forms.Label();
            this.btnArqLog = new System.Windows.Forms.Button();
            this.txtArqLog = new System.Windows.Forms.TextBox();
            this.lblArqLog = new System.Windows.Forms.Label();
            this.txtSenha = new System.Windows.Forms.TextBox();
            this.lblSenha = new System.Windows.Forms.Label();
            this.txtCNPJ = new System.Windows.Forms.TextBox();
            this.lblCNPJ = new System.Windows.Forms.Label();
            this.cmbAmbiente = new System.Windows.Forms.ComboBox();
            this.lblAmbiente = new System.Windows.Forms.Label();
            this.cmbTipoResposta = new System.Windows.Forms.ComboBox();
            this.lblTipoResposta = new System.Windows.Forms.Label();
            this.btnGravarConfig = new System.Windows.Forms.Button();
            this.btnLerConfig = new System.Windows.Forms.Button();
            this.grpRespostas = new System.Windows.Forms.GroupBox();
            this.btnLimparRespostas = new System.Windows.Forms.Button();
            this.rtbRespostas = new System.Windows.Forms.RichTextBox();
            this.tabControl1.SuspendLayout();
            this.tabConsultas.SuspendLayout();
            this.grpRegimes.SuspendLayout();
            this.grpHistorico.SuspendLayout();
            this.grpAlterados.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.nudLimite)).BeginInit();
            this.grpDescricao.SuspendLayout();
            this.tabSaneamento.SuspendLayout();
            this.tabProdutos.SuspendLayout();
            this.grpRemoveDevolvidos.SuspendLayout();
            this.grpInativar.SuspendLayout();
            this.tabConfiguracao.SuspendLayout();
            this.grpProxy.SuspendLayout();
            this.grpIMendes.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.nudMaxProdutos)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.nudTimeout)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.nudNivelLog)).BeginInit();
            this.grpRespostas.SuspendLayout();
            this.SuspendLayout();
            //
            // tabControl1
            //
            this.tabControl1.Controls.Add(this.tabConsultas);
            this.tabControl1.Controls.Add(this.tabSaneamento);
            this.tabControl1.Controls.Add(this.tabProdutos);
            this.tabControl1.Controls.Add(this.tabConfiguracao);
            this.tabControl1.Location = new System.Drawing.Point(12, 12);
            this.tabControl1.Name = "tabControl1";
            this.tabControl1.SelectedIndex = 0;
            this.tabControl1.Size = new System.Drawing.Size(470, 486);
            this.tabControl1.TabIndex = 0;
            //
            // tabConsultas
            //
            this.tabConsultas.Controls.Add(this.grpRegimes);
            this.tabConsultas.Controls.Add(this.grpHistorico);
            this.tabConsultas.Controls.Add(this.grpAlterados);
            this.tabConsultas.Controls.Add(this.grpDescricao);
            this.tabConsultas.Controls.Add(this.lblCNPJConsultaInfo);
            this.tabConsultas.Controls.Add(this.txtCNPJConsulta);
            this.tabConsultas.Controls.Add(this.lblCNPJConsulta);
            this.tabConsultas.Location = new System.Drawing.Point(4, 22);
            this.tabConsultas.Name = "tabConsultas";
            this.tabConsultas.Padding = new System.Windows.Forms.Padding(3);
            this.tabConsultas.Size = new System.Drawing.Size(462, 460);
            this.tabConsultas.TabIndex = 0;
            this.tabConsultas.Text = "Consultas";
            this.tabConsultas.UseVisualStyleBackColor = true;
            //
            // lblCNPJConsulta
            //
            this.lblCNPJConsulta.AutoSize = true;
            this.lblCNPJConsulta.Location = new System.Drawing.Point(6, 9);
            this.lblCNPJConsulta.Name = "lblCNPJConsulta";
            this.lblCNPJConsulta.Size = new System.Drawing.Size(34, 13);
            this.lblCNPJConsulta.TabIndex = 0;
            this.lblCNPJConsulta.Text = "CNPJ";
            //
            // txtCNPJConsulta
            //
            this.txtCNPJConsulta.Location = new System.Drawing.Point(9, 25);
            this.txtCNPJConsulta.Name = "txtCNPJConsulta";
            this.txtCNPJConsulta.Size = new System.Drawing.Size(150, 20);
            this.txtCNPJConsulta.TabIndex = 1;
            //
            // lblCNPJConsultaInfo
            //
            this.lblCNPJConsultaInfo.AutoSize = true;
            this.lblCNPJConsultaInfo.Location = new System.Drawing.Point(165, 28);
            this.lblCNPJConsultaInfo.Name = "lblCNPJConsultaInfo";
            this.lblCNPJConsultaInfo.Size = new System.Drawing.Size(196, 13);
            this.lblCNPJConsultaInfo.TabIndex = 2;
            this.lblCNPJConsultaInfo.Text = "(vazio = CNPJ da configuração [IMendes])";
            //
            // grpDescricao
            //
            this.grpDescricao.Controls.Add(this.btnConsultarDescricao);
            this.grpDescricao.Controls.Add(this.cmbTipoDescricao);
            this.grpDescricao.Controls.Add(this.lblTipoDescricao);
            this.grpDescricao.Controls.Add(this.txtDescricao);
            this.grpDescricao.Controls.Add(this.lblDescricao);
            this.grpDescricao.Location = new System.Drawing.Point(9, 55);
            this.grpDescricao.Name = "grpDescricao";
            this.grpDescricao.Size = new System.Drawing.Size(444, 95);
            this.grpDescricao.TabIndex = 3;
            this.grpDescricao.TabStop = false;
            this.grpDescricao.Text = "Consultar Descrição";
            //
            // lblDescricao
            //
            this.lblDescricao.AutoSize = true;
            this.lblDescricao.Location = new System.Drawing.Point(6, 20);
            this.lblDescricao.Name = "lblDescricao";
            this.lblDescricao.Size = new System.Drawing.Size(55, 13);
            this.lblDescricao.TabIndex = 0;
            this.lblDescricao.Text = "Descrição";
            //
            // txtDescricao
            //
            this.txtDescricao.Location = new System.Drawing.Point(9, 36);
            this.txtDescricao.Name = "txtDescricao";
            this.txtDescricao.Size = new System.Drawing.Size(270, 20);
            this.txtDescricao.TabIndex = 1;
            //
            // lblTipoDescricao
            //
            this.lblTipoDescricao.AutoSize = true;
            this.lblTipoDescricao.Location = new System.Drawing.Point(286, 20);
            this.lblTipoDescricao.Name = "lblTipoDescricao";
            this.lblTipoDescricao.Size = new System.Drawing.Size(28, 13);
            this.lblTipoDescricao.TabIndex = 2;
            this.lblTipoDescricao.Text = "Tipo";
            //
            // cmbTipoDescricao
            //
            this.cmbTipoDescricao.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cmbTipoDescricao.FormattingEnabled = true;
            this.cmbTipoDescricao.Items.AddRange(new object[] {
            "0 - Contém",
            "1 - Inicia com",
            "2 - Termina com",
            "3 - Igual a"});
            this.cmbTipoDescricao.Location = new System.Drawing.Point(289, 35);
            this.cmbTipoDescricao.Name = "cmbTipoDescricao";
            this.cmbTipoDescricao.Size = new System.Drawing.Size(145, 21);
            this.cmbTipoDescricao.TabIndex = 3;
            //
            // btnConsultarDescricao
            //
            this.btnConsultarDescricao.Location = new System.Drawing.Point(289, 62);
            this.btnConsultarDescricao.Name = "btnConsultarDescricao";
            this.btnConsultarDescricao.Size = new System.Drawing.Size(145, 23);
            this.btnConsultarDescricao.TabIndex = 4;
            this.btnConsultarDescricao.Text = "Consultar Descrição";
            this.btnConsultarDescricao.UseVisualStyleBackColor = true;
            this.btnConsultarDescricao.Click += new System.EventHandler(this.btnConsultarDescricao_Click);
            //
            // grpAlterados
            //
            this.grpAlterados.Controls.Add(this.btnConsultarAlterados);
            this.grpAlterados.Controls.Add(this.nudLimite);
            this.grpAlterados.Controls.Add(this.lblLimite);
            this.grpAlterados.Controls.Add(this.txtUFAlterados);
            this.grpAlterados.Controls.Add(this.lblUFAlterados);
            this.grpAlterados.Location = new System.Drawing.Point(9, 156);
            this.grpAlterados.Name = "grpAlterados";
            this.grpAlterados.Size = new System.Drawing.Size(444, 70);
            this.grpAlterados.TabIndex = 4;
            this.grpAlterados.TabStop = false;
            this.grpAlterados.Text = "Consultar Alterados";
            //
            // lblUFAlterados
            //
            this.lblUFAlterados.AutoSize = true;
            this.lblUFAlterados.Location = new System.Drawing.Point(6, 20);
            this.lblUFAlterados.Name = "lblUFAlterados";
            this.lblUFAlterados.Size = new System.Drawing.Size(21, 13);
            this.lblUFAlterados.TabIndex = 0;
            this.lblUFAlterados.Text = "UF";
            //
            // txtUFAlterados
            //
            this.txtUFAlterados.CharacterCasing = System.Windows.Forms.CharacterCasing.Upper;
            this.txtUFAlterados.Location = new System.Drawing.Point(9, 36);
            this.txtUFAlterados.MaxLength = 2;
            this.txtUFAlterados.Name = "txtUFAlterados";
            this.txtUFAlterados.Size = new System.Drawing.Size(40, 20);
            this.txtUFAlterados.TabIndex = 1;
            this.txtUFAlterados.Text = "SP";
            //
            // lblLimite
            //
            this.lblLimite.AutoSize = true;
            this.lblLimite.Location = new System.Drawing.Point(62, 20);
            this.lblLimite.Name = "lblLimite";
            this.lblLimite.Size = new System.Drawing.Size(130, 13);
            this.lblLimite.TabIndex = 2;
            this.lblLimite.Text = "Limite (0 = sem limite)";
            //
            // nudLimite
            //
            this.nudLimite.Location = new System.Drawing.Point(65, 36);
            this.nudLimite.Maximum = new decimal(new int[] {
            99999,
            0,
            0,
            0});
            this.nudLimite.Name = "nudLimite";
            this.nudLimite.Size = new System.Drawing.Size(80, 20);
            this.nudLimite.TabIndex = 3;
            //
            // btnConsultarAlterados
            //
            this.btnConsultarAlterados.Location = new System.Drawing.Point(289, 34);
            this.btnConsultarAlterados.Name = "btnConsultarAlterados";
            this.btnConsultarAlterados.Size = new System.Drawing.Size(145, 23);
            this.btnConsultarAlterados.TabIndex = 4;
            this.btnConsultarAlterados.Text = "Consultar Alterados";
            this.btnConsultarAlterados.UseVisualStyleBackColor = true;
            this.btnConsultarAlterados.Click += new System.EventHandler(this.btnConsultarAlterados_Click);
            //
            // grpHistorico
            //
            this.grpHistorico.Controls.Add(this.btnHistoricoAcesso);
            this.grpHistorico.Location = new System.Drawing.Point(9, 232);
            this.grpHistorico.Name = "grpHistorico";
            this.grpHistorico.Size = new System.Drawing.Size(444, 55);
            this.grpHistorico.TabIndex = 5;
            this.grpHistorico.TabStop = false;
            this.grpHistorico.Text = "Histórico de Acesso";
            //
            // btnHistoricoAcesso
            //
            this.btnHistoricoAcesso.Location = new System.Drawing.Point(289, 19);
            this.btnHistoricoAcesso.Name = "btnHistoricoAcesso";
            this.btnHistoricoAcesso.Size = new System.Drawing.Size(145, 23);
            this.btnHistoricoAcesso.TabIndex = 0;
            this.btnHistoricoAcesso.Text = "Histórico de Acesso";
            this.btnHistoricoAcesso.UseVisualStyleBackColor = true;
            this.btnHistoricoAcesso.Click += new System.EventHandler(this.btnHistoricoAcesso_Click);
            //
            // grpRegimes
            //
            this.grpRegimes.Controls.Add(this.btnConsultarRegimes);
            this.grpRegimes.Controls.Add(this.chkIncludeTrib);
            this.grpRegimes.Controls.Add(this.txtUFRegimes);
            this.grpRegimes.Controls.Add(this.lblUFRegimes);
            this.grpRegimes.Location = new System.Drawing.Point(9, 293);
            this.grpRegimes.Name = "grpRegimes";
            this.grpRegimes.Size = new System.Drawing.Size(444, 70);
            this.grpRegimes.TabIndex = 6;
            this.grpRegimes.TabStop = false;
            this.grpRegimes.Text = "Consultar Regimes Especiais";
            //
            // lblUFRegimes
            //
            this.lblUFRegimes.AutoSize = true;
            this.lblUFRegimes.Location = new System.Drawing.Point(6, 20);
            this.lblUFRegimes.Name = "lblUFRegimes";
            this.lblUFRegimes.Size = new System.Drawing.Size(21, 13);
            this.lblUFRegimes.TabIndex = 0;
            this.lblUFRegimes.Text = "UF";
            //
            // txtUFRegimes
            //
            this.txtUFRegimes.CharacterCasing = System.Windows.Forms.CharacterCasing.Upper;
            this.txtUFRegimes.Location = new System.Drawing.Point(9, 36);
            this.txtUFRegimes.MaxLength = 2;
            this.txtUFRegimes.Name = "txtUFRegimes";
            this.txtUFRegimes.Size = new System.Drawing.Size(40, 20);
            this.txtUFRegimes.TabIndex = 1;
            this.txtUFRegimes.Text = "SP";
            //
            // chkIncludeTrib
            //
            this.chkIncludeTrib.AutoSize = true;
            this.chkIncludeTrib.Location = new System.Drawing.Point(65, 38);
            this.chkIncludeTrib.Name = "chkIncludeTrib";
            this.chkIncludeTrib.Size = new System.Drawing.Size(185, 17);
            this.chkIncludeTrib.TabIndex = 2;
            this.chkIncludeTrib.Text = "Incluir regimes de Substituto ICMS";
            this.chkIncludeTrib.UseVisualStyleBackColor = true;
            //
            // btnConsultarRegimes
            //
            this.btnConsultarRegimes.Location = new System.Drawing.Point(289, 34);
            this.btnConsultarRegimes.Name = "btnConsultarRegimes";
            this.btnConsultarRegimes.Size = new System.Drawing.Size(145, 23);
            this.btnConsultarRegimes.TabIndex = 3;
            this.btnConsultarRegimes.Text = "Consultar Regimes";
            this.btnConsultarRegimes.UseVisualStyleBackColor = true;
            this.btnConsultarRegimes.Click += new System.EventHandler(this.btnConsultarRegimes_Click);
            //
            // tabSaneamento
            //
            this.tabSaneamento.Controls.Add(this.btnSaneamento);
            this.tabSaneamento.Controls.Add(this.btnCarregarIni);
            this.tabSaneamento.Controls.Add(this.txtIniSaneamento);
            this.tabSaneamento.Controls.Add(this.lblIniSaneamento);
            this.tabSaneamento.Location = new System.Drawing.Point(4, 22);
            this.tabSaneamento.Name = "tabSaneamento";
            this.tabSaneamento.Padding = new System.Windows.Forms.Padding(3);
            this.tabSaneamento.Size = new System.Drawing.Size(462, 460);
            this.tabSaneamento.TabIndex = 1;
            this.tabSaneamento.Text = "Saneamento";
            this.tabSaneamento.UseVisualStyleBackColor = true;
            //
            // lblIniSaneamento
            //
            this.lblIniSaneamento.AutoSize = true;
            this.lblIniSaneamento.Location = new System.Drawing.Point(6, 9);
            this.lblIniSaneamento.Name = "lblIniSaneamento";
            this.lblIniSaneamento.Size = new System.Drawing.Size(278, 13);
            this.lblIniSaneamento.TabIndex = 0;
            this.lblIniSaneamento.Text = "INI de entrada ([Emitente], [Perfil] e [ProdutoNNN])";
            //
            // txtIniSaneamento
            //
            this.txtIniSaneamento.Font = new System.Drawing.Font("Consolas", 9F);
            this.txtIniSaneamento.Location = new System.Drawing.Point(9, 25);
            this.txtIniSaneamento.Multiline = true;
            this.txtIniSaneamento.Name = "txtIniSaneamento";
            this.txtIniSaneamento.ScrollBars = System.Windows.Forms.ScrollBars.Both;
            this.txtIniSaneamento.Size = new System.Drawing.Size(444, 395);
            this.txtIniSaneamento.TabIndex = 1;
            this.txtIniSaneamento.WordWrap = false;
            //
            // btnCarregarIni
            //
            this.btnCarregarIni.Location = new System.Drawing.Point(9, 426);
            this.btnCarregarIni.Name = "btnCarregarIni";
            this.btnCarregarIni.Size = new System.Drawing.Size(145, 23);
            this.btnCarregarIni.TabIndex = 2;
            this.btnCarregarIni.Text = "Carregar INI";
            this.btnCarregarIni.UseVisualStyleBackColor = true;
            this.btnCarregarIni.Click += new System.EventHandler(this.btnCarregarIni_Click);
            //
            // btnSaneamento
            //
            this.btnSaneamento.Location = new System.Drawing.Point(308, 426);
            this.btnSaneamento.Name = "btnSaneamento";
            this.btnSaneamento.Size = new System.Drawing.Size(145, 23);
            this.btnSaneamento.TabIndex = 3;
            this.btnSaneamento.Text = "Saneamento Grades";
            this.btnSaneamento.UseVisualStyleBackColor = true;
            this.btnSaneamento.Click += new System.EventHandler(this.btnSaneamento_Click);
            //
            // tabProdutos
            //
            this.tabProdutos.Controls.Add(this.grpRemoveDevolvidos);
            this.tabProdutos.Controls.Add(this.grpInativar);
            this.tabProdutos.Location = new System.Drawing.Point(4, 22);
            this.tabProdutos.Name = "tabProdutos";
            this.tabProdutos.Padding = new System.Windows.Forms.Padding(3);
            this.tabProdutos.Size = new System.Drawing.Size(462, 460);
            this.tabProdutos.TabIndex = 2;
            this.tabProdutos.Text = "Produtos";
            this.tabProdutos.UseVisualStyleBackColor = true;
            //
            // grpInativar
            //
            this.grpInativar.Controls.Add(this.btnInativar);
            this.grpInativar.Controls.Add(this.chkCodigosInternos);
            this.grpInativar.Controls.Add(this.txtInativarCodigos);
            this.grpInativar.Controls.Add(this.lblInativarCodigos);
            this.grpInativar.Location = new System.Drawing.Point(9, 6);
            this.grpInativar.Name = "grpInativar";
            this.grpInativar.Size = new System.Drawing.Size(218, 445);
            this.grpInativar.TabIndex = 0;
            this.grpInativar.TabStop = false;
            this.grpInativar.Text = "Inativar Produtos";
            //
            // lblInativarCodigos
            //
            this.lblInativarCodigos.AutoSize = true;
            this.lblInativarCodigos.Location = new System.Drawing.Point(6, 20);
            this.lblInativarCodigos.Name = "lblInativarCodigos";
            this.lblInativarCodigos.Size = new System.Drawing.Size(124, 13);
            this.lblInativarCodigos.TabIndex = 0;
            this.lblInativarCodigos.Text = "Códigos (um por linha)";
            //
            // txtInativarCodigos
            //
            this.txtInativarCodigos.Location = new System.Drawing.Point(9, 36);
            this.txtInativarCodigos.Multiline = true;
            this.txtInativarCodigos.Name = "txtInativarCodigos";
            this.txtInativarCodigos.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            this.txtInativarCodigos.Size = new System.Drawing.Size(200, 342);
            this.txtInativarCodigos.TabIndex = 1;
            //
            // chkCodigosInternos
            //
            this.chkCodigosInternos.AutoSize = true;
            this.chkCodigosInternos.Location = new System.Drawing.Point(9, 386);
            this.chkCodigosInternos.Name = "chkCodigosInternos";
            this.chkCodigosInternos.Size = new System.Drawing.Size(106, 17);
            this.chkCodigosInternos.TabIndex = 2;
            this.chkCodigosInternos.Text = "Códigos internos";
            this.chkCodigosInternos.UseVisualStyleBackColor = true;
            //
            // btnInativar
            //
            this.btnInativar.Location = new System.Drawing.Point(9, 410);
            this.btnInativar.Name = "btnInativar";
            this.btnInativar.Size = new System.Drawing.Size(200, 23);
            this.btnInativar.TabIndex = 3;
            this.btnInativar.Text = "Inativar";
            this.btnInativar.UseVisualStyleBackColor = true;
            this.btnInativar.Click += new System.EventHandler(this.btnInativar_Click);
            //
            // grpRemoveDevolvidos
            //
            this.grpRemoveDevolvidos.Controls.Add(this.btnRemoveDevolvidos);
            this.grpRemoveDevolvidos.Controls.Add(this.txtRemoveIds);
            this.grpRemoveDevolvidos.Controls.Add(this.lblRemoveIds);
            this.grpRemoveDevolvidos.Location = new System.Drawing.Point(235, 6);
            this.grpRemoveDevolvidos.Name = "grpRemoveDevolvidos";
            this.grpRemoveDevolvidos.Size = new System.Drawing.Size(218, 445);
            this.grpRemoveDevolvidos.TabIndex = 1;
            this.grpRemoveDevolvidos.TabStop = false;
            this.grpRemoveDevolvidos.Text = "Remover Devolvidos";
            //
            // lblRemoveIds
            //
            this.lblRemoveIds.AutoSize = true;
            this.lblRemoveIds.Location = new System.Drawing.Point(6, 20);
            this.lblRemoveIds.Name = "lblRemoveIds";
            this.lblRemoveIds.Size = new System.Drawing.Size(103, 13);
            this.lblRemoveIds.TabIndex = 0;
            this.lblRemoveIds.Text = "IDs (um por linha)";
            //
            // txtRemoveIds
            //
            this.txtRemoveIds.Location = new System.Drawing.Point(9, 36);
            this.txtRemoveIds.Multiline = true;
            this.txtRemoveIds.Name = "txtRemoveIds";
            this.txtRemoveIds.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            this.txtRemoveIds.Size = new System.Drawing.Size(200, 366);
            this.txtRemoveIds.TabIndex = 1;
            //
            // btnRemoveDevolvidos
            //
            this.btnRemoveDevolvidos.Location = new System.Drawing.Point(9, 410);
            this.btnRemoveDevolvidos.Name = "btnRemoveDevolvidos";
            this.btnRemoveDevolvidos.Size = new System.Drawing.Size(200, 23);
            this.btnRemoveDevolvidos.TabIndex = 2;
            this.btnRemoveDevolvidos.Text = "Remover";
            this.btnRemoveDevolvidos.UseVisualStyleBackColor = true;
            this.btnRemoveDevolvidos.Click += new System.EventHandler(this.btnRemoveDevolvidos_Click);
            //
            // tabConfiguracao
            //
            this.tabConfiguracao.Controls.Add(this.grpProxy);
            this.tabConfiguracao.Controls.Add(this.grpIMendes);
            this.tabConfiguracao.Controls.Add(this.cmbTipoResposta);
            this.tabConfiguracao.Controls.Add(this.lblTipoResposta);
            this.tabConfiguracao.Controls.Add(this.btnGravarConfig);
            this.tabConfiguracao.Controls.Add(this.btnLerConfig);
            this.tabConfiguracao.Location = new System.Drawing.Point(4, 22);
            this.tabConfiguracao.Name = "tabConfiguracao";
            this.tabConfiguracao.Padding = new System.Windows.Forms.Padding(3);
            this.tabConfiguracao.Size = new System.Drawing.Size(462, 460);
            this.tabConfiguracao.TabIndex = 3;
            this.tabConfiguracao.Text = "Configuração";
            this.tabConfiguracao.UseVisualStyleBackColor = true;
            //
            // lblTipoResposta
            //
            this.lblTipoResposta.AutoSize = true;
            this.lblTipoResposta.Location = new System.Drawing.Point(6, 9);
            this.lblTipoResposta.Name = "lblTipoResposta";
            this.lblTipoResposta.Size = new System.Drawing.Size(88, 13);
            this.lblTipoResposta.TabIndex = 0;
            this.lblTipoResposta.Text = "Tipo de Resposta";
            //
            // cmbTipoResposta
            //
            this.cmbTipoResposta.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cmbTipoResposta.FormattingEnabled = true;
            this.cmbTipoResposta.Location = new System.Drawing.Point(9, 25);
            this.cmbTipoResposta.Name = "cmbTipoResposta";
            this.cmbTipoResposta.Size = new System.Drawing.Size(150, 21);
            this.cmbTipoResposta.TabIndex = 1;
            //
            // grpIMendes
            //
            this.grpIMendes.Controls.Add(this.nudMaxProdutos);
            this.grpIMendes.Controls.Add(this.lblMaxProdutos);
            this.grpIMendes.Controls.Add(this.nudTimeout);
            this.grpIMendes.Controls.Add(this.lblTimeout);
            this.grpIMendes.Controls.Add(this.nudNivelLog);
            this.grpIMendes.Controls.Add(this.lblNivelLog);
            this.grpIMendes.Controls.Add(this.btnArqLog);
            this.grpIMendes.Controls.Add(this.txtArqLog);
            this.grpIMendes.Controls.Add(this.lblArqLog);
            this.grpIMendes.Controls.Add(this.txtSenha);
            this.grpIMendes.Controls.Add(this.lblSenha);
            this.grpIMendes.Controls.Add(this.txtCNPJ);
            this.grpIMendes.Controls.Add(this.lblCNPJ);
            this.grpIMendes.Controls.Add(this.cmbAmbiente);
            this.grpIMendes.Controls.Add(this.lblAmbiente);
            this.grpIMendes.Location = new System.Drawing.Point(9, 55);
            this.grpIMendes.Name = "grpIMendes";
            this.grpIMendes.Size = new System.Drawing.Size(444, 200);
            this.grpIMendes.TabIndex = 2;
            this.grpIMendes.TabStop = false;
            this.grpIMendes.Text = "IMendes";
            //
            // lblAmbiente
            //
            this.lblAmbiente.AutoSize = true;
            this.lblAmbiente.Location = new System.Drawing.Point(6, 20);
            this.lblAmbiente.Name = "lblAmbiente";
            this.lblAmbiente.Size = new System.Drawing.Size(51, 13);
            this.lblAmbiente.TabIndex = 0;
            this.lblAmbiente.Text = "Ambiente";
            //
            // cmbAmbiente
            //
            this.cmbAmbiente.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cmbAmbiente.FormattingEnabled = true;
            this.cmbAmbiente.Location = new System.Drawing.Point(9, 36);
            this.cmbAmbiente.Name = "cmbAmbiente";
            this.cmbAmbiente.Size = new System.Drawing.Size(130, 21);
            this.cmbAmbiente.TabIndex = 1;
            //
            // lblCNPJ
            //
            this.lblCNPJ.AutoSize = true;
            this.lblCNPJ.Location = new System.Drawing.Point(146, 20);
            this.lblCNPJ.Name = "lblCNPJ";
            this.lblCNPJ.Size = new System.Drawing.Size(34, 13);
            this.lblCNPJ.TabIndex = 2;
            this.lblCNPJ.Text = "CNPJ";
            //
            // txtCNPJ
            //
            this.txtCNPJ.Location = new System.Drawing.Point(149, 37);
            this.txtCNPJ.Name = "txtCNPJ";
            this.txtCNPJ.Size = new System.Drawing.Size(140, 20);
            this.txtCNPJ.TabIndex = 3;
            //
            // lblSenha
            //
            this.lblSenha.AutoSize = true;
            this.lblSenha.Location = new System.Drawing.Point(296, 20);
            this.lblSenha.Name = "lblSenha";
            this.lblSenha.Size = new System.Drawing.Size(38, 13);
            this.lblSenha.TabIndex = 4;
            this.lblSenha.Text = "Senha";
            //
            // txtSenha
            //
            this.txtSenha.Location = new System.Drawing.Point(299, 37);
            this.txtSenha.Name = "txtSenha";
            this.txtSenha.Size = new System.Drawing.Size(135, 20);
            this.txtSenha.TabIndex = 5;
            this.txtSenha.UseSystemPasswordChar = true;
            //
            // lblArqLog
            //
            this.lblArqLog.AutoSize = true;
            this.lblArqLog.Location = new System.Drawing.Point(6, 66);
            this.lblArqLog.Name = "lblArqLog";
            this.lblArqLog.Size = new System.Drawing.Size(196, 13);
            this.lblArqLog.TabIndex = 6;
            this.lblArqLog.Text = "Arquivo de Log da comunicação (ArqLog)";
            //
            // txtArqLog
            //
            this.txtArqLog.Location = new System.Drawing.Point(9, 82);
            this.txtArqLog.Name = "txtArqLog";
            this.txtArqLog.Size = new System.Drawing.Size(390, 20);
            this.txtArqLog.TabIndex = 7;
            //
            // btnArqLog
            //
            this.btnArqLog.Location = new System.Drawing.Point(405, 80);
            this.btnArqLog.Name = "btnArqLog";
            this.btnArqLog.Size = new System.Drawing.Size(29, 23);
            this.btnArqLog.TabIndex = 8;
            this.btnArqLog.Text = "...";
            this.btnArqLog.UseVisualStyleBackColor = true;
            this.btnArqLog.Click += new System.EventHandler(this.btnArqLog_Click);
            //
            // lblNivelLog
            //
            this.lblNivelLog.AutoSize = true;
            this.lblNivelLog.Location = new System.Drawing.Point(6, 112);
            this.lblNivelLog.Name = "lblNivelLog";
            this.lblNivelLog.Size = new System.Drawing.Size(82, 13);
            this.lblNivelLog.TabIndex = 9;
            this.lblNivelLog.Text = "Nível Log (0 a 4)";
            //
            // nudNivelLog
            //
            this.nudNivelLog.Location = new System.Drawing.Point(9, 128);
            this.nudNivelLog.Maximum = new decimal(new int[] {
            4,
            0,
            0,
            0});
            this.nudNivelLog.Name = "nudNivelLog";
            this.nudNivelLog.Size = new System.Drawing.Size(80, 20);
            this.nudNivelLog.TabIndex = 10;
            this.nudNivelLog.Value = new decimal(new int[] {
            1,
            0,
            0,
            0});
            //
            // lblTimeout
            //
            this.lblTimeout.AutoSize = true;
            this.lblTimeout.Location = new System.Drawing.Point(146, 112);
            this.lblTimeout.Name = "lblTimeout";
            this.lblTimeout.Size = new System.Drawing.Size(70, 13);
            this.lblTimeout.TabIndex = 11;
            this.lblTimeout.Text = "Timeout (ms)";
            //
            // nudTimeout
            //
            this.nudTimeout.Increment = new decimal(new int[] {
            1000,
            0,
            0,
            0});
            this.nudTimeout.Location = new System.Drawing.Point(149, 128);
            this.nudTimeout.Maximum = new decimal(new int[] {
            9999999,
            0,
            0,
            0});
            this.nudTimeout.Name = "nudTimeout";
            this.nudTimeout.Size = new System.Drawing.Size(100, 20);
            this.nudTimeout.TabIndex = 12;
            this.nudTimeout.Value = new decimal(new int[] {
            300000,
            0,
            0,
            0});
            //
            // lblMaxProdutos
            //
            this.lblMaxProdutos.AutoSize = true;
            this.lblMaxProdutos.Location = new System.Drawing.Point(296, 112);
            this.lblMaxProdutos.Name = "lblMaxProdutos";
            this.lblMaxProdutos.Size = new System.Drawing.Size(138, 13);
            this.lblMaxProdutos.TabIndex = 13;
            this.lblMaxProdutos.Text = "Máx. Produtos por Envio";
            //
            // nudMaxProdutos
            //
            this.nudMaxProdutos.Location = new System.Drawing.Point(299, 128);
            this.nudMaxProdutos.Maximum = new decimal(new int[] {
            300,
            0,
            0,
            0});
            this.nudMaxProdutos.Minimum = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this.nudMaxProdutos.Name = "nudMaxProdutos";
            this.nudMaxProdutos.Size = new System.Drawing.Size(80, 20);
            this.nudMaxProdutos.TabIndex = 14;
            this.nudMaxProdutos.Value = new decimal(new int[] {
            300,
            0,
            0,
            0});
            //
            // grpProxy
            //
            this.grpProxy.Controls.Add(this.txtProxySenha);
            this.grpProxy.Controls.Add(this.lblProxySenha);
            this.grpProxy.Controls.Add(this.txtProxyUsuario);
            this.grpProxy.Controls.Add(this.lblProxyUsuario);
            this.grpProxy.Controls.Add(this.txtProxyPorta);
            this.grpProxy.Controls.Add(this.lblProxyPorta);
            this.grpProxy.Controls.Add(this.txtProxyServidor);
            this.grpProxy.Controls.Add(this.lblProxyServidor);
            this.grpProxy.Location = new System.Drawing.Point(9, 261);
            this.grpProxy.Name = "grpProxy";
            this.grpProxy.Size = new System.Drawing.Size(444, 115);
            this.grpProxy.TabIndex = 3;
            this.grpProxy.TabStop = false;
            this.grpProxy.Text = "Proxy";
            //
            // lblProxyServidor
            //
            this.lblProxyServidor.AutoSize = true;
            this.lblProxyServidor.Location = new System.Drawing.Point(6, 20);
            this.lblProxyServidor.Name = "lblProxyServidor";
            this.lblProxyServidor.Size = new System.Drawing.Size(46, 13);
            this.lblProxyServidor.TabIndex = 0;
            this.lblProxyServidor.Text = "Servidor";
            //
            // txtProxyServidor
            //
            this.txtProxyServidor.Location = new System.Drawing.Point(9, 36);
            this.txtProxyServidor.Name = "txtProxyServidor";
            this.txtProxyServidor.Size = new System.Drawing.Size(320, 20);
            this.txtProxyServidor.TabIndex = 1;
            //
            // lblProxyPorta
            //
            this.lblProxyPorta.AutoSize = true;
            this.lblProxyPorta.Location = new System.Drawing.Point(336, 20);
            this.lblProxyPorta.Name = "lblProxyPorta";
            this.lblProxyPorta.Size = new System.Drawing.Size(32, 13);
            this.lblProxyPorta.TabIndex = 2;
            this.lblProxyPorta.Text = "Porta";
            //
            // txtProxyPorta
            //
            this.txtProxyPorta.Location = new System.Drawing.Point(339, 36);
            this.txtProxyPorta.Name = "txtProxyPorta";
            this.txtProxyPorta.Size = new System.Drawing.Size(95, 20);
            this.txtProxyPorta.TabIndex = 3;
            //
            // lblProxyUsuario
            //
            this.lblProxyUsuario.AutoSize = true;
            this.lblProxyUsuario.Location = new System.Drawing.Point(6, 63);
            this.lblProxyUsuario.Name = "lblProxyUsuario";
            this.lblProxyUsuario.Size = new System.Drawing.Size(43, 13);
            this.lblProxyUsuario.TabIndex = 4;
            this.lblProxyUsuario.Text = "Usuário";
            //
            // txtProxyUsuario
            //
            this.txtProxyUsuario.Location = new System.Drawing.Point(9, 79);
            this.txtProxyUsuario.Name = "txtProxyUsuario";
            this.txtProxyUsuario.Size = new System.Drawing.Size(210, 20);
            this.txtProxyUsuario.TabIndex = 5;
            //
            // lblProxySenha
            //
            this.lblProxySenha.AutoSize = true;
            this.lblProxySenha.Location = new System.Drawing.Point(226, 63);
            this.lblProxySenha.Name = "lblProxySenha";
            this.lblProxySenha.Size = new System.Drawing.Size(38, 13);
            this.lblProxySenha.TabIndex = 6;
            this.lblProxySenha.Text = "Senha";
            //
            // txtProxySenha
            //
            this.txtProxySenha.Location = new System.Drawing.Point(229, 79);
            this.txtProxySenha.Name = "txtProxySenha";
            this.txtProxySenha.Size = new System.Drawing.Size(205, 20);
            this.txtProxySenha.TabIndex = 7;
            this.txtProxySenha.UseSystemPasswordChar = true;
            //
            // btnLerConfig
            //
            this.btnLerConfig.Location = new System.Drawing.Point(9, 426);
            this.btnLerConfig.Name = "btnLerConfig";
            this.btnLerConfig.Size = new System.Drawing.Size(145, 23);
            this.btnLerConfig.TabIndex = 4;
            this.btnLerConfig.Text = "Ler Configurações";
            this.btnLerConfig.UseVisualStyleBackColor = true;
            this.btnLerConfig.Click += new System.EventHandler(this.btnLerConfig_Click);
            //
            // btnGravarConfig
            //
            this.btnGravarConfig.Location = new System.Drawing.Point(308, 426);
            this.btnGravarConfig.Name = "btnGravarConfig";
            this.btnGravarConfig.Size = new System.Drawing.Size(145, 23);
            this.btnGravarConfig.TabIndex = 5;
            this.btnGravarConfig.Text = "Gravar Configurações";
            this.btnGravarConfig.UseVisualStyleBackColor = true;
            this.btnGravarConfig.Click += new System.EventHandler(this.btnGravarConfig_Click);
            //
            // grpRespostas
            //
            this.grpRespostas.Controls.Add(this.btnLimparRespostas);
            this.grpRespostas.Controls.Add(this.rtbRespostas);
            this.grpRespostas.Location = new System.Drawing.Point(488, 12);
            this.grpRespostas.Name = "grpRespostas";
            this.grpRespostas.Size = new System.Drawing.Size(434, 486);
            this.grpRespostas.TabIndex = 1;
            this.grpRespostas.TabStop = false;
            this.grpRespostas.Text = "Respostas";
            //
            // rtbRespostas
            //
            this.rtbRespostas.Font = new System.Drawing.Font("Consolas", 9F);
            this.rtbRespostas.Location = new System.Drawing.Point(6, 19);
            this.rtbRespostas.Name = "rtbRespostas";
            this.rtbRespostas.ReadOnly = true;
            this.rtbRespostas.Size = new System.Drawing.Size(422, 428);
            this.rtbRespostas.TabIndex = 0;
            this.rtbRespostas.Text = "";
            this.rtbRespostas.WordWrap = false;
            //
            // btnLimparRespostas
            //
            this.btnLimparRespostas.Location = new System.Drawing.Point(283, 453);
            this.btnLimparRespostas.Name = "btnLimparRespostas";
            this.btnLimparRespostas.Size = new System.Drawing.Size(145, 23);
            this.btnLimparRespostas.TabIndex = 1;
            this.btnLimparRespostas.Text = "Limpar";
            this.btnLimparRespostas.UseVisualStyleBackColor = true;
            this.btnLimparRespostas.Click += new System.EventHandler(this.btnLimparRespostas_Click);
            //
            // FrmMain
            //
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(934, 510);
            this.Controls.Add(this.grpRespostas);
            this.Controls.Add(this.tabControl1);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.MaximizeBox = false;
            this.Name = "FrmMain";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "ACBrLibIMendes Demo";
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.FrmMain_FormClosing);
            this.Shown += new System.EventHandler(this.FrmMain_Shown);
            this.tabControl1.ResumeLayout(false);
            this.tabConsultas.ResumeLayout(false);
            this.tabConsultas.PerformLayout();
            this.grpRegimes.ResumeLayout(false);
            this.grpRegimes.PerformLayout();
            this.grpHistorico.ResumeLayout(false);
            this.grpAlterados.ResumeLayout(false);
            this.grpAlterados.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.nudLimite)).EndInit();
            this.grpDescricao.ResumeLayout(false);
            this.grpDescricao.PerformLayout();
            this.tabSaneamento.ResumeLayout(false);
            this.tabSaneamento.PerformLayout();
            this.tabProdutos.ResumeLayout(false);
            this.grpRemoveDevolvidos.ResumeLayout(false);
            this.grpRemoveDevolvidos.PerformLayout();
            this.grpInativar.ResumeLayout(false);
            this.grpInativar.PerformLayout();
            this.tabConfiguracao.ResumeLayout(false);
            this.tabConfiguracao.PerformLayout();
            this.grpProxy.ResumeLayout(false);
            this.grpProxy.PerformLayout();
            this.grpIMendes.ResumeLayout(false);
            this.grpIMendes.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.nudMaxProdutos)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.nudTimeout)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.nudNivelLog)).EndInit();
            this.grpRespostas.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.TabControl tabControl1;
        private System.Windows.Forms.TabPage tabConsultas;
        private System.Windows.Forms.Label lblCNPJConsulta;
        private System.Windows.Forms.TextBox txtCNPJConsulta;
        private System.Windows.Forms.Label lblCNPJConsultaInfo;
        private System.Windows.Forms.GroupBox grpDescricao;
        private System.Windows.Forms.Label lblDescricao;
        private System.Windows.Forms.TextBox txtDescricao;
        private System.Windows.Forms.Label lblTipoDescricao;
        private System.Windows.Forms.ComboBox cmbTipoDescricao;
        private System.Windows.Forms.Button btnConsultarDescricao;
        private System.Windows.Forms.GroupBox grpAlterados;
        private System.Windows.Forms.Label lblUFAlterados;
        private System.Windows.Forms.TextBox txtUFAlterados;
        private System.Windows.Forms.Label lblLimite;
        private System.Windows.Forms.NumericUpDown nudLimite;
        private System.Windows.Forms.Button btnConsultarAlterados;
        private System.Windows.Forms.GroupBox grpHistorico;
        private System.Windows.Forms.Button btnHistoricoAcesso;
        private System.Windows.Forms.GroupBox grpRegimes;
        private System.Windows.Forms.Label lblUFRegimes;
        private System.Windows.Forms.TextBox txtUFRegimes;
        private System.Windows.Forms.CheckBox chkIncludeTrib;
        private System.Windows.Forms.Button btnConsultarRegimes;
        private System.Windows.Forms.TabPage tabSaneamento;
        private System.Windows.Forms.Label lblIniSaneamento;
        private System.Windows.Forms.TextBox txtIniSaneamento;
        private System.Windows.Forms.Button btnCarregarIni;
        private System.Windows.Forms.Button btnSaneamento;
        private System.Windows.Forms.TabPage tabProdutos;
        private System.Windows.Forms.GroupBox grpInativar;
        private System.Windows.Forms.Label lblInativarCodigos;
        private System.Windows.Forms.TextBox txtInativarCodigos;
        private System.Windows.Forms.CheckBox chkCodigosInternos;
        private System.Windows.Forms.Button btnInativar;
        private System.Windows.Forms.GroupBox grpRemoveDevolvidos;
        private System.Windows.Forms.Label lblRemoveIds;
        private System.Windows.Forms.TextBox txtRemoveIds;
        private System.Windows.Forms.Button btnRemoveDevolvidos;
        private System.Windows.Forms.TabPage tabConfiguracao;
        private System.Windows.Forms.Label lblTipoResposta;
        private System.Windows.Forms.ComboBox cmbTipoResposta;
        private System.Windows.Forms.GroupBox grpIMendes;
        private System.Windows.Forms.Label lblAmbiente;
        private System.Windows.Forms.ComboBox cmbAmbiente;
        private System.Windows.Forms.Label lblCNPJ;
        private System.Windows.Forms.TextBox txtCNPJ;
        private System.Windows.Forms.Label lblSenha;
        private System.Windows.Forms.TextBox txtSenha;
        private System.Windows.Forms.Label lblArqLog;
        private System.Windows.Forms.TextBox txtArqLog;
        private System.Windows.Forms.Button btnArqLog;
        private System.Windows.Forms.Label lblNivelLog;
        private System.Windows.Forms.NumericUpDown nudNivelLog;
        private System.Windows.Forms.Label lblTimeout;
        private System.Windows.Forms.NumericUpDown nudTimeout;
        private System.Windows.Forms.Label lblMaxProdutos;
        private System.Windows.Forms.NumericUpDown nudMaxProdutos;
        private System.Windows.Forms.GroupBox grpProxy;
        private System.Windows.Forms.Label lblProxyServidor;
        private System.Windows.Forms.TextBox txtProxyServidor;
        private System.Windows.Forms.Label lblProxyPorta;
        private System.Windows.Forms.TextBox txtProxyPorta;
        private System.Windows.Forms.Label lblProxyUsuario;
        private System.Windows.Forms.TextBox txtProxyUsuario;
        private System.Windows.Forms.Label lblProxySenha;
        private System.Windows.Forms.TextBox txtProxySenha;
        private System.Windows.Forms.Button btnLerConfig;
        private System.Windows.Forms.Button btnGravarConfig;
        private System.Windows.Forms.GroupBox grpRespostas;
        private System.Windows.Forms.RichTextBox rtbRespostas;
        private System.Windows.Forms.Button btnLimparRespostas;
    }
}
