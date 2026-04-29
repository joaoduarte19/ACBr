import 'package:demo_acbrpixcd_flutter/plugin/acbrpixcd_plugin.dart';
import 'package:demo_acbrpixcd_flutter/ui/widgets/response_box.dart';
import 'package:flutter/material.dart';

class ConsultarPixPage extends StatefulWidget {
  const ConsultarPixPage({super.key, required this.plugin});

  final ACBrPixCDPlugin plugin;

  @override
  State<ConsultarPixPage> createState() => _ConsultarPixPageState();
}

class _ConsultarPixPageState extends State<ConsultarPixPage> {
  final TextEditingController _e2eIdController = TextEditingController();
  final TextEditingController _respController = TextEditingController();

  @override
  void dispose() {
    _e2eIdController.dispose();
    _respController.dispose();
    super.dispose();
  }

  Future<void> _executar() async {
    _respController.text = '';
    setState(() {});
    try {
      final r = await widget.plugin.consultarPix(e2eId: _e2eIdController.text.trim());
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
        TextField(
          controller: _e2eIdController,
          decoration: const InputDecoration(
            labelText: 'e2eid',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        FilledButton(onPressed: _executar, child: const Text('Consultar Pix')),
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

