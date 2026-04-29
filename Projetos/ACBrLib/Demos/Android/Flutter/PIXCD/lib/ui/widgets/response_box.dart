import 'package:flutter/material.dart';

class ResponseBox extends StatelessWidget {
  const ResponseBox({
    super.key,
    required this.controller,
    this.height = 215,
    this.onClear,
  });

  final TextEditingController controller;
  final double height;
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('Resposta:'),
        const SizedBox(height: 8),
        SizedBox(
          height: height,
          child: TextField(
            controller: controller,
            maxLines: null,
            expands: true,
            readOnly: true,
            style: const TextStyle(fontSize: 12),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ),
        if (onClear != null) ...[
          const SizedBox(height: 10),
          FilledButton(
            onPressed: onClear,
            child: const Text('Limpar Resposta'),
          ),
        ],
      ],
    );
  }
}

