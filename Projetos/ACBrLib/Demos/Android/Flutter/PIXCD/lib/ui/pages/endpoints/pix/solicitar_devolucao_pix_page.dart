import 'package:demo_acbrpixcd_flutter/plugin/acbrpixcd_plugin.dart';
import 'package:demo_acbrpixcd_flutter/ui/widgets/response_box.dart';
import 'package:flutter/material.dart';

class SolicitarDevolucaoPixPage extends StatefulWidget {
  const SolicitarDevolucaoPixPage({super.key, required this.plugin});

  final ACBrPixCDPlugin plugin;

  @override
  State<SolicitarDevolucaoPixPage> createState() => _SolicitarDevolucaoPixPageState();
}

class _SolicitarDevolucaoPixPageState extends State<SolicitarDevolucaoPixPage> {
  final TextEditingController _iniController = TextEditingController();
  final TextEditingController _e2eIdController = TextEditingController();
  final TextEditingController _idDevolucaoController = TextEditingController();
  final TextEditingController _respController = TextEditingController();

  @override
  void dispose() {
    _iniController.dispose();
    _e2eIdController.dispose();
    _idDevolucaoController.dispose();
    _respController.dispose();
    super.dispose();
  }

  Future<void> _executar() async {
    _respController.text = '';
    setState(() {});
    try {
      final r = await widget.plugin.solicitarDevolucaoPix(
        solicitarDevolucaoPIX: _iniController.text,
        e2eId: _e2eIdController.text.trim(),
        idDevolucao: _idDevolucaoController.text.trim(),
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
        const Text('Ini para Solicitar Devolução PIX'),
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
        const Text('e2eId'),
        const SizedBox(height: 6),
        TextField(
          controller: _e2eIdController,
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ),
        const SizedBox(height: 10),
        const Text('ID Devolução'),
        const SizedBox(height: 6),
        TextField(
          controller: _idDevolucaoController,
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ),
        const SizedBox(height: 10),
        FilledButton(onPressed: _executar, child: const Text('Solicitar Devolução PIX')),
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

