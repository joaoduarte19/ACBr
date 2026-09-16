import 'package:flutter/material.dart';
import '../../../model/cep.dart';

class CardResponse extends StatelessWidget {
  final Cep result;
  final double width;

  const CardResponse({super.key, required this.result, required this.width});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: width,
          child: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: 8),
                TextFormField(
                  initialValue: result.cep,
                  decoration: const InputDecoration(
                    labelText: 'CEP',
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  initialValue: result.logradouro,
                  decoration: const InputDecoration(
                    labelText: 'Logradouro',
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  initialValue: result.bairro,
                  decoration: const InputDecoration(
                    labelText: 'Bairro',
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  initialValue: result.municipio,
                  decoration: const InputDecoration(
                    labelText: 'Município',
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  initialValue: result.uf,
                  decoration: const InputDecoration(
                    labelText: 'UF',
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  initialValue: result.codigoIbgeMunicipio,
                  decoration: const InputDecoration(
                    labelText: 'Código IBGE Município',
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  initialValue: result.codigoIbgeUf,
                  decoration: const InputDecoration(
                    labelText: 'Código IBGE UF',
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true,
                ),
              ],
            ),
          ),
        )
    );
  }
}
