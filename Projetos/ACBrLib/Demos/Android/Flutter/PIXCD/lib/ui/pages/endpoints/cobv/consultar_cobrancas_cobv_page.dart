import 'package:demo_acbrpixcd_flutter/plugin/acbrpixcd_plugin.dart';
import 'package:demo_acbrpixcd_flutter/ui/widgets/response_box.dart';
import 'package:flutter/material.dart';

class ConsultarCobrancasCobVPage extends StatefulWidget {
  const ConsultarCobrancasCobVPage({super.key, required this.plugin});

  final ACBrPixCDPlugin plugin;

  @override
  State<ConsultarCobrancasCobVPage> createState() => _ConsultarCobrancasCobVPageState();
}

class _ConsultarCobrancasCobVPageState extends State<ConsultarCobrancasCobVPage> {
  static const statusItems = [
    'Nenhum',
    'Ativa',
    'Concluída',
    'Removida Pelo Usuário Recebedor',
    'Removida Pelo PSP',
  ];

  DateTime _inicio = DateTime.now();
  DateTime _fim = DateTime.now();
  final TextEditingController _cpfCnpjController = TextEditingController();
  int _statusIndex = 0;
  bool _location = false;
  final TextEditingController _pagAtualController = TextEditingController();
  final TextEditingController _itensPorPaginaController = TextEditingController();
  final TextEditingController _respController = TextEditingController();

  @override
  void dispose() {
    _cpfCnpjController.dispose();
    _pagAtualController.dispose();
    _itensPorPaginaController.dispose();
    _respController.dispose();
    super.dispose();
  }

  Future<void> _pickDate({required bool isInicio}) async {
    final initial = isInicio ? _inicio : _fim;
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDate: initial,
    );
    if (picked == null) return;
    setState(() {
      if (isInicio) {
        _inicio = DateTime(picked.year, picked.month, picked.day);
      } else {
        _fim = DateTime(picked.year, picked.month, picked.day);
      }
    });
  }

  int _intOrZero(String s) => int.tryParse(s.trim()) ?? 0;

  Future<void> _executar() async {
    _respController.text = '';
    setState(() {});
    try {
      final tIni = await widget.plugin.convertDateToTDateTime(
        DateTime(_inicio.year, _inicio.month, _inicio.day).millisecondsSinceEpoch,
      );
      final tFim = await widget.plugin.convertDateToTDateTime(
        DateTime(_fim.year, _fim.month, _fim.day).millisecondsSinceEpoch,
      );
      final r = await widget.plugin.consultarCobrancasCobV(
        tDateTimeInicial: tIni,
        tDateTimeFinal: tFim,
        cpfCnpj: _cpfCnpjController.text.trim(),
        location: _location,
        status: _statusIndex,
        pagAtual: _intOrZero(_pagAtualController.text),
        itensPorPagina: _intOrZero(_itensPorPaginaController.text),
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
        OutlinedButton.icon(
          onPressed: () => _pickDate(isInicio: true),
          icon: const Icon(Icons.date_range),
          label: Align(
            alignment: Alignment.centerLeft,
            child: Text('Data Inicial: ${_formatDate(_inicio)}'),
          ),
        ),
        const SizedBox(height: 10),
        OutlinedButton.icon(
          onPressed: () => _pickDate(isInicio: false),
          icon: const Icon(Icons.date_range),
          label: Align(
            alignment: Alignment.centerLeft,
            child: Text('Data Final: ${_formatDate(_fim)}'),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _cpfCnpjController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'CPF ou CNPJ',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        DropdownButtonFormField<int>(
          initialValue: _statusIndex,
          items: List.generate(
            statusItems.length,
            (i) => DropdownMenuItem(value: i, child: Text(statusItems[i])),
          ),
          onChanged: (v) => setState(() => _statusIndex = v ?? 0),
          decoration: const InputDecoration(
            labelText: 'Status',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        CheckboxListTile(
          value: _location,
          onChanged: (v) => setState(() => _location = v ?? false),
          title: const Text('Location'),
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: EdgeInsets.zero,
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _pagAtualController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Página Atual',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _itensPorPaginaController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Itens Por Página',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        FilledButton(
          onPressed: _executar,
          child: const Text('Consultar Cobrancas Cob'),
        ),
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

  String _formatDate(DateTime d) {
    final dd = d.day.toString().padLeft(2, '0');
    final mm = d.month.toString().padLeft(2, '0');
    final yyyy = d.year.toString();
    return '$dd/$mm/$yyyy';
  }
}

