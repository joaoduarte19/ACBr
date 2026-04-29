import 'package:demo_acbrpixcd_flutter/plugin/acbrpixcd_plugin.dart';
import 'package:demo_acbrpixcd_flutter/ui/widgets/response_box.dart';
import 'package:flutter/material.dart';

class CancelarCobrancaPage extends StatefulWidget {
  const CancelarCobrancaPage({super.key, required this.plugin});

  final ACBrPixCDPlugin plugin;

  @override
  State<CancelarCobrancaPage> createState() => _CancelarCobrancaPageState();
}

class _CancelarCobrancaPageState extends State<CancelarCobrancaPage> {
  final TextEditingController _txIdController = TextEditingController();
  final TextEditingController _respController = TextEditingController();

  @override
  void dispose() {
    _txIdController.dispose();
    _respController.dispose();
    super.dispose();
  }

  Future<void> _executar() async {
    _respController.text = '';
    setState(() {});
    try {
      // No demo Java, este comando também chama CancelarCobrancaImediata.
      final r = await widget.plugin.cancelarCobrancaImediata(txId: _txIdController.text.trim());
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
        FilledButton(onPressed: _executar, child: const Text('Cancelar Cobrança')),
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

