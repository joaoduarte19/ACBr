import 'package:demo_acbrpixcd_flutter/plugin/acbrpixcd_plugin.dart';
import 'package:demo_acbrpixcd_flutter/ui/widgets/response_box.dart';
import 'package:flutter/material.dart';

class ConsultarDevolucaoPixPage extends StatefulWidget {
  const ConsultarDevolucaoPixPage({super.key, required this.plugin});

  final ACBrPixCDPlugin plugin;

  @override
  State<ConsultarDevolucaoPixPage> createState() => _ConsultarDevolucaoPixPageState();
}

class _ConsultarDevolucaoPixPageState extends State<ConsultarDevolucaoPixPage> {
  final TextEditingController _e2eIdController = TextEditingController();
  final TextEditingController _idDevolucaoController = TextEditingController();
  final TextEditingController _respController = TextEditingController();

  @override
  void dispose() {
    _e2eIdController.dispose();
    _idDevolucaoController.dispose();
    _respController.dispose();
    super.dispose();
  }

  Future<void> _executar() async {
    _respController.text = '';
    setState(() {});
    try {
      final r = await widget.plugin.consultarDevolucaoPix(
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
        const Text('e2eid'),
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
        FilledButton(onPressed: _executar, child: const Text('Consultar Devolução PIX')),
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

