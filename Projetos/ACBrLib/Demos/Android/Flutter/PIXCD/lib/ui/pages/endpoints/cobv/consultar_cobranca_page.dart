import 'package:demo_acbrpixcd_flutter/plugin/acbrpixcd_plugin.dart';
import 'package:demo_acbrpixcd_flutter/ui/widgets/response_box.dart';
import 'package:flutter/material.dart';

class ConsultarCobrancaPage extends StatefulWidget {
  const ConsultarCobrancaPage({super.key, required this.plugin});

  final ACBrPixCDPlugin plugin;

  @override
  State<ConsultarCobrancaPage> createState() => _ConsultarCobrancaPageState();
}

class _ConsultarCobrancaPageState extends State<ConsultarCobrancaPage> {
  final TextEditingController _txIdController = TextEditingController();
  final TextEditingController _revisaoController = TextEditingController();
  final TextEditingController _respController = TextEditingController();

  @override
  void dispose() {
    _txIdController.dispose();
    _revisaoController.dispose();
    _respController.dispose();
    super.dispose();
  }

  Future<void> _executar() async {
    _respController.text = '';
    setState(() {});
    try {
      final revisao = int.tryParse(_revisaoController.text.trim()) ?? 0;
      final r = await widget.plugin.consultarCobranca(
        txId: _txIdController.text.trim(),
        revisao: revisao,
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
        const Text('TxId'),
        const SizedBox(height: 6),
        TextField(
          controller: _txIdController,
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ),
        const SizedBox(height: 10),
        const Text('Revisão'),
        const SizedBox(height: 6),
        TextField(
          controller: _revisaoController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ),
        const SizedBox(height: 10),
        FilledButton(onPressed: _executar, child: const Text('Consultar Cobrança')),
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

