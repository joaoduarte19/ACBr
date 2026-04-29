import 'package:demo_acbrpixcd_flutter/plugin/acbrpixcd_plugin.dart';
import 'package:flutter/material.dart';

class ConfiguracoesPixCDPage extends StatefulWidget {
  const ConfiguracoesPixCDPage({super.key, required this.plugin});

  final ACBrPixCDPlugin plugin;

  @override
  State<ConfiguracoesPixCDPage> createState() => _ConfiguracoesPixCDPageState();
}

class _ConfiguracoesPixCDPageState extends State<ConfiguracoesPixCDPage> {
  static const ambienteItems = ['Teste', 'Produção', 'Pré-Produção'];
  static const nivelLogItems = ['Nenhum', 'Baixo', 'Normal', 'Alto', 'Muito Alto'];
  static const tipoChaveItems = ['Nenhum', 'Email', 'CPF', 'CNPJ', 'Celular', 'Aleatoria'];
  static const pspItems = [
    'Bradesco',
    'Itaú',
    'Banco do Brasil',
    'Santander',
    'Shipay',
    'Sicredi',
    'Sicoob',
    'PagSeguro',
    'GerenciaNet',
    'PixPDV',
    'Inter',
    'Ailos',
    'Matera',
    'Cielo',
    'Mercado Pago',
    'Gate2All',
    'Banrisul',
    'C6Bank',
    'AppLess',
    'QQPag'
  ];

  final TextEditingController _nomeRecebedor = TextEditingController();
  final TextEditingController _cidadeRecebedor = TextEditingController();
  final TextEditingController _cepRecebedor = TextEditingController();
  final TextEditingController _ufRecebedor = TextEditingController();

  int _pspIndex = 0;
  int _tipoChaveIndex = 0;
  int _ambienteIndex = 0;
  final TextEditingController _timeout = TextEditingController();

  final TextEditingController _arqLog = TextEditingController();
  int _nivelLogIndex = 0;

  final TextEditingController _proxyServidor = TextEditingController();
  final TextEditingController _proxyPorta = TextEditingController();
  final TextEditingController _proxyUsuario = TextEditingController();
  final TextEditingController _proxySenha = TextEditingController();

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  @override
  void dispose() {
    _nomeRecebedor.dispose();
    _cidadeRecebedor.dispose();
    _cepRecebedor.dispose();
    _ufRecebedor.dispose();
    _timeout.dispose();
    _arqLog.dispose();
    _proxyServidor.dispose();
    _proxyPorta.dispose();
    _proxyUsuario.dispose();
    _proxySenha.dispose();
    super.dispose();
  }

  Future<void> _salvar() async {
    try {
      await widget.plugin.configGravarValor(sessao: 'PIXCD', chave: 'Ambiente', valor: _ambienteIndex.toString());
      await widget.plugin.configGravarValor(sessao: 'PIXCD', chave: 'ArqLog', valor: _arqLog.text);
      await widget.plugin.configGravarValor(sessao: 'PIXCD', chave: 'NivelLog', valor: _nivelLogIndex.toString());
      await widget.plugin.configGravarValor(sessao: 'PIXCD', chave: 'TipoChave', valor: _tipoChaveIndex.toString());
      await widget.plugin.configGravarValor(sessao: 'PIXCD', chave: 'PSP', valor: _pspIndex.toString());
      await widget.plugin.configGravarValor(sessao: 'PIXCD', chave: 'Timeout', valor: _timeout.text);
      await widget.plugin.configGravarValor(sessao: 'PIXCD', chave: 'ProxyHost', valor: _proxyServidor.text);
      await widget.plugin.configGravarValor(sessao: 'PIXCD', chave: 'ProxyPort', valor: _proxyPorta.text);
      await widget.plugin.configGravarValor(sessao: 'PIXCD', chave: 'ProxyUser', valor: _proxyUsuario.text);
      await widget.plugin.configGravarValor(sessao: 'PIXCD', chave: 'ProxyPass', valor: _proxySenha.text);
      await widget.plugin.configGravarValor(sessao: 'PIXCD', chave: 'NomeRecebedor', valor: _nomeRecebedor.text);
      await widget.plugin.configGravarValor(sessao: 'PIXCD', chave: 'CidadeRecebedor', valor: _cidadeRecebedor.text);
      await widget.plugin.configGravarValor(sessao: 'PIXCD', chave: 'CEPRecebedor', valor: _cepRecebedor.text);
      await widget.plugin.configGravarValor(sessao: 'PIXCD', chave: 'UFRecebedor', valor: _ufRecebedor.text);

      await widget.plugin.configGravar();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Configurações salvas.')));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  int _parseIndex(String v, int fallback) {
    final i = int.tryParse(v.trim());
    if (i == null) return fallback;
    return i;
  }

  Future<void> _carregar() async {
    try {
      _ambienteIndex = _parseIndex(await widget.plugin.configLerValor(sessao: 'PIXCD', chave: 'Ambiente'), 0);
      _arqLog.text = await widget.plugin.configLerValor(sessao: 'PIXCD', chave: 'ArqLog');
      _nivelLogIndex = _parseIndex(await widget.plugin.configLerValor(sessao: 'PIXCD', chave: 'NivelLog'), 0);
      _tipoChaveIndex = _parseIndex(await widget.plugin.configLerValor(sessao: 'PIXCD', chave: 'TipoChave'), 0);
      _pspIndex = _parseIndex(await widget.plugin.configLerValor(sessao: 'PIXCD', chave: 'PSP'), 0);
      _timeout.text = await widget.plugin.configLerValor(sessao: 'PIXCD', chave: 'Timeout');
      _proxyServidor.text = await widget.plugin.configLerValor(sessao: 'PIXCD', chave: 'ProxyHost');
      _proxyPorta.text = await widget.plugin.configLerValor(sessao: 'PIXCD', chave: 'ProxyPort');
      _proxyUsuario.text = await widget.plugin.configLerValor(sessao: 'PIXCD', chave: 'ProxyUser');
      _proxySenha.text = await widget.plugin.configLerValor(sessao: 'PIXCD', chave: 'ProxyPass');
      _nomeRecebedor.text = await widget.plugin.configLerValor(sessao: 'PIXCD', chave: 'NomeRecebedor');
      _cidadeRecebedor.text = await widget.plugin.configLerValor(sessao: 'PIXCD', chave: 'CidadeRecebedor');
      _cepRecebedor.text = await widget.plugin.configLerValor(sessao: 'PIXCD', chave: 'CEPRecebedor');
      _ufRecebedor.text = await widget.plugin.configLerValor(sessao: 'PIXCD', chave: 'UFRecebedor');
    } catch (_) {
      // manter defensivo: não quebrar a tela se faltar alguma chave no ini
    }
    if (mounted) setState(() {});
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 30),
      ),
    );
  }

  Widget _outlinedField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    bool obscureText = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }

  Widget _spinnerLike({
    required String label,
    required List<String> items,
    required int value,
    required ValueChanged<int> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 10),
        Text(label),
        const SizedBox(height: 6),
        SizedBox(
          height: 40,
          child: DropdownButtonFormField<int>(
            initialValue: value.clamp(0, items.length - 1),
            items: List.generate(
              items.length,
              (i) => DropdownMenuItem(value: i, child: Text(items[i])),
            ),
            onChanged: (v) => onChanged(v ?? 0),
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(15),
      children: [
        _sectionTitle('Recebedor'),
        _outlinedField(controller: _nomeRecebedor, label: 'Nome'),
        _outlinedField(controller: _cidadeRecebedor, label: 'Cidade'),
        _outlinedField(controller: _cepRecebedor, label: 'CEP', keyboardType: TextInputType.number),
        _outlinedField(controller: _ufRecebedor, label: 'UF'),

        _sectionTitle('PSP'),
        _spinnerLike(
          label: 'PSP',
          items: pspItems,
          value: _pspIndex,
          onChanged: (v) => setState(() => _pspIndex = v),
        ),
        _spinnerLike(
          label: 'Tipo Chave',
          items: tipoChaveItems,
          value: _tipoChaveIndex,
          onChanged: (v) => setState(() => _tipoChaveIndex = v),
        ),
        _spinnerLike(
          label: 'Ambiente',
          items: ambienteItems,
          value: _ambienteIndex,
          onChanged: (v) => setState(() => _ambienteIndex = v),
        ),
        _outlinedField(controller: _timeout, label: 'Timeout', keyboardType: TextInputType.number),

        _sectionTitle('Log PSP'),
        const Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text('Arquivo'),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: TextField(
            controller: _arqLog,
            decoration: const InputDecoration(),
          ),
        ),
        _spinnerLike(
          label: 'Nível Log PSP',
          items: nivelLogItems,
          value: _nivelLogIndex,
          onChanged: (v) => setState(() => _nivelLogIndex = v),
        ),

        _sectionTitle('Proxy'),
        _outlinedField(controller: _proxyServidor, label: 'Servidor'),
        _outlinedField(controller: _proxyPorta, label: 'Porta', keyboardType: TextInputType.number),
        _outlinedField(controller: _proxyUsuario, label: 'Usuário'),
        _outlinedField(controller: _proxySenha, label: 'Senha', obscureText: true),

        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: FilledButton(
                onPressed: _salvar,
                child: const Text('Salvar'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: FilledButton.tonal(
                onPressed: _carregar,
                child: const Text('Carregar'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 72),
      ],
    );
  }
}

