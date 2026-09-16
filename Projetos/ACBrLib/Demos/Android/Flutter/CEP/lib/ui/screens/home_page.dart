import 'dart:convert';

import 'package:demo_acbrcep_flutter/ui/screens/widgets/card_response.dart';
import 'package:demo_acbrcep_flutter/ui/_core/app_colors.dart';
import 'package:flutter/material.dart';

import '../../plugin/acbrcep_plugin.dart';
import '../../model/cep.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController cepTextController;
  late ACBrCepPlugin _cepAarPlugin;
  late String _result = _getJsonEmptyCep();

  @override
  Widget build(BuildContext context) {
    //layout buildr
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          title: const Text('Programa Exemplo ACBrCEP',
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Digite o CEP:',
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: constraints.maxWidth * 0.8,
                    child: TextField(
                      controller: cepTextController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Digite o CEP',
                        labelText: 'CEP',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Resultado:',
                ),
                CardResponse(
                  key: ValueKey(_result),
                  result: Cep.fromJson(jsonDecode(_result)),
                  width: constraints.maxWidth * 0.8,
                ),
                const SizedBox(height: 13.0),
                ElevatedButton.icon(
                  onPressed: onClickBuscarPorCep,
                  icon: const Icon(Icons.search),
                  label: const Text('Buscar',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  String _getJsonEmptyCep() {
    return '''
      {
        "CEP": {
          "Endereco1": {
            "Bairro": "",
            "CEP": "",
            "Complemento": "",
            "IBGE_Municipio": "",
            "IBGE_UF": "",
            "Logradouro": "",
            "Municipio": "",
            "Tipo_Logradouro": "",
            "UF": ""
          },
          "Quantidade": 1
        }
      }
      ''';
  }

  void onClickBuscarPorCep() async {
    String result = "";
    try {
      result = await _cepAarPlugin.buscarPorCep(cepTextController.text);
    } catch (e) {
      result = _getJsonEmptyCep();
      debugPrint("Erro: '${e.toString()}'.");
    } finally {
      setState(() {
        _result = result;
      });
    }
  }

  void inicializar() async {
    await _cepAarPlugin.inicializar();
    await _cepAarPlugin.configGravarValor("CEP", "WebService", "10");
    await _cepAarPlugin.configGravarValor("Principal", "TipoResposta", "2");
    await _cepAarPlugin.configGravar();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cepTextController = TextEditingController();
    cepTextController.text = '18270170';
    _cepAarPlugin = ACBrCepPlugin();
    inicializar();
  }

  @override
  void dispose() {
    cepTextController.dispose();
    super.dispose();
  }
}
