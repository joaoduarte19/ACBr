import 'package:demo_acbrpixcd_flutter/plugin/acbrpixcd_plugin.dart';
import 'package:demo_acbrpixcd_flutter/utils/acbrlib_pixcd_helper.dart';
import 'package:flutter/material.dart';

class ConfigFieldDef {
  const ConfigFieldDef({
    required this.keyName,
    required this.label,
    this.obscureText = false,
    this.keyboardType,
    this.isDropdown = false,
    this.dropdownItems = const [],
    this.isFilePicker = false,
    this.pickerTitle,
    this.suggestedFileName,
    this.mimeTypes = const [],
  });

  final String keyName;
  final String label;
  final bool obscureText;
  final TextInputType? keyboardType;

  final bool isDropdown;
  final List<String> dropdownItems;

  final bool isFilePicker;
  final String? pickerTitle;
  final String? suggestedFileName;
  final List<String> mimeTypes;
}

class PspConfigForm extends StatefulWidget {
  const PspConfigForm({
    super.key,
    required this.plugin,
    required this.sessao,
    required this.fields,
  });

  final ACBrPixCDPlugin plugin;
  final String sessao;
  final List<ConfigFieldDef> fields;

  @override
  State<PspConfigForm> createState() => _PspConfigFormState();
}

class _PspConfigFormState extends State<PspConfigForm> {
  final Map<String, TextEditingController> _controllers = {};
  final TextEditingController _saidaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    for (final f in widget.fields) {
      _controllers[f.keyName] = TextEditingController();
    }
    _carregar();
  }

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    _saidaController.dispose();
    super.dispose();
  }

  TextEditingController _c(String key) {
    final c = _controllers[key];
    if (c == null) {
      throw StateError('Controller não encontrado para chave: $key');
    }
    return c;
  }

  Future<void> _salvar() async {
    try {
      for (final f in widget.fields) {
        await widget.plugin.configGravarValor(
          sessao: widget.sessao,
          chave: f.keyName,
          valor: _c(f.keyName).text,
        );
      }
      final status = await widget.plugin.configGravar();
      _saidaController.text = 'Configurações gravadas. Status: $status';
    } catch (e) {
      _saidaController.text = e.toString();
    }
    if (mounted) setState(() {});
  }

  Future<void> _carregar() async {
    try {
      for (final f in widget.fields) {
        final v = await widget.plugin.configLerValor(sessao: widget.sessao, chave: f.keyName);
        _c(f.keyName).text = v;
      }
      _saidaController.text = 'Configurações carregadas.';
    } catch (e) {
      _saidaController.text = e.toString();
    }
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(15),
      children: [
        for (final f in widget.fields) ...[
          if (!f.isDropdown)
            TextField(
              controller: _c(f.keyName),
              obscureText: f.obscureText,
              keyboardType: f.keyboardType,
              decoration: InputDecoration(
                labelText: f.label,
                border: const OutlineInputBorder(),
                suffixIcon: f.isFilePicker
                    ? IconButton(
                        onPressed: () async {
                          final suggested = f.suggestedFileName ?? f.keyName;
                          final picked = await ACBrLibPixCDHelper().pickFile(
                            title: f.pickerTitle ?? 'Selecione um arquivo',
                            suggestedFileName: suggested,
                            mimeTypes: f.mimeTypes,
                          );
                          if (picked != null && picked.trim().isNotEmpty) {
                            _c(f.keyName).text = picked;
                            if (mounted) setState(() {});
                          }
                        },
                        icon: const Icon(Icons.attach_file),
                      )
                    : null,
              ),
            )
          else
            DropdownButtonFormField<int>(
              initialValue: int.tryParse(_c(f.keyName).text) ?? 0,
              items: List.generate(
                f.dropdownItems.length,
                (i) => DropdownMenuItem(value: i, child: Text(f.dropdownItems[i])),
              ),
              onChanged: (idx) {
                _c(f.keyName).text = (idx ?? 0).toString();
                setState(() {});
              },
              decoration: InputDecoration(
                labelText: f.label,
                border: const OutlineInputBorder(),
              ),
            ),
          const SizedBox(height: 10),
        ],
        FilledButton(
          onPressed: _salvar,
          child: const Text('Salvar Configurações'),
        ),
        const SizedBox(height: 10),
        OutlinedButton(
          onPressed: _carregar,
          child: const Text('Carregar Configurações'),
        ),
        const SizedBox(height: 8),
        const Text('Resposta:'),
        const SizedBox(height: 8),
        SizedBox(
          height: 215,
          child: TextField(
            controller: _saidaController,
            readOnly: true,
            maxLines: null,
            expands: true,
            style: const TextStyle(fontSize: 12),
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
        ),
      ],
    );
  }
}

