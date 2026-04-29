import 'package:demo_acbrpixcd_flutter/plugin/acbrpixcd_plugin.dart';
import 'package:demo_acbrpixcd_flutter/ui/widgets/response_box.dart';
import 'package:flutter/material.dart';

class CriarCobrancaPage extends StatefulWidget {
  const CriarCobrancaPage({super.key, required this.plugin});

  final ACBrPixCDPlugin plugin;

  @override
  State<CriarCobrancaPage> createState() => _CriarCobrancaPageState();
}

class _CriarCobrancaPageState extends State<CriarCobrancaPage> {
  final TextEditingController _iniController = TextEditingController();
  final TextEditingController _txIdController = TextEditingController();
  final TextEditingController _respController = TextEditingController();

  @override
  void dispose() {
    _iniController.dispose();
    _txIdController.dispose();
    _respController.dispose();
    super.dispose();
  }

  Future<void> _executar() async {
    _respController.text = '';
    setState(() {});
    try {
      final r = await widget.plugin.criarCobranca(
        criarCobranca: _iniController.text,
        txId: _txIdController.text.trim(),
      );
      _respController.text = r;
    } catch (e) {
      _respController.text = e.toString();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(15),
      children: [
        const Text('Ini para Criar Cobrança'),
        const SizedBox(height: 10),
        SizedBox(
          height: 350,
          child: TextField(
            controller: _iniController,
            maxLines: null,
            expands: true,
            style: const TextStyle(fontSize: 12),
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
        ),
        const SizedBox(height: 10),
        const Text('TxId'),
        const SizedBox(height: 6),
        TextField(
          controller: _txIdController,
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ),
        const SizedBox(height: 10),
        FilledButton(onPressed: _executar, child: const Text('Criar Cobrança')),
        const SizedBox(height: 10),
        ResponseBox(
          controller: _respController,
          onClear: () {
            _respController.clear();
            setState(() {});
          },
        ),
      ],
    );
  }
}

