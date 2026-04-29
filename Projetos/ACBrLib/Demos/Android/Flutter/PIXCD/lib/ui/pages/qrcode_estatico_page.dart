import 'package:demo_acbrpixcd_flutter/plugin/acbrpixcd_plugin.dart';
import 'package:flutter/material.dart';
import 'package:demo_acbrpixcd_flutter/ui/widgets/response_box.dart';

class QrCodeEstaticoPage extends StatefulWidget {
  const QrCodeEstaticoPage({super.key, required this.plugin});

  final ACBrPixCDPlugin plugin;

  @override
  State<QrCodeEstaticoPage> createState() => _QrCodeEstaticoPageState();
}

class _QrCodeEstaticoPageState extends State<QrCodeEstaticoPage> {
  final TextEditingController _valorController = TextEditingController();
  final TextEditingController _infoController = TextEditingController();
  final TextEditingController _txIdController = TextEditingController();
  final TextEditingController _saidaController = TextEditingController();

  @override
  void dispose() {
    _valorController.dispose();
    _infoController.dispose();
    _txIdController.dispose();
    _saidaController.dispose();
    super.dispose();
  }

  Future<void> _gerar() async {
    final valor = _valorController.text.trim();
    final txId = _txIdController.text.trim();
    if (valor.isEmpty || txId.isEmpty) {
      _saidaController.text = 'Valor e TxId são obrigatórios.';
      setState(() {});
      return;
    }

    try {
      final retorno = await widget.plugin.gerarQRCodeEstatico(
        valor: valor,
        informacoesAdicionais: _infoController.text,
        txId: txId,
      );
      _saidaController.text = retorno;
    } catch (e) {
      _saidaController.text = e.toString();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(15),
      children: [
        TextField(
          controller: _valorController,
          decoration: const InputDecoration(
            labelText: 'Valor',
            border: OutlineInputBorder(),
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _txIdController,
          decoration: const InputDecoration(
            labelText: 'TxId',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _infoController,
          decoration: const InputDecoration(
            labelText: 'Informações adicionais',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        FilledButton(onPressed: _gerar, child: const Text('Gerar QRCode Estático')),
        const SizedBox(height: 10),
        ResponseBox(
          controller: _saidaController,
          onClear: () {
            _saidaController.clear();
            setState(() {});
          },
        ),
      ],
    );
  }
}

