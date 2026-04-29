import 'package:flutter/services.dart';

class ACBrPixCDPlugin {
  static const MethodChannel _channel =
      MethodChannel('acbrlib_pixcd_flutter');

  Future<int> inicializar() async {
    final int result = await _channel.invokeMethod('inicializar');
    return result;
  }

  Future<int> finalizar() async {
    final int result = await _channel.invokeMethod('finalizar');
    return result;
  }

  Future<int> configGravar() async {
    final int result = await _channel.invokeMethod('configGravar');
    return result;
  }

  Future<int> configLer({String? eArqConfig}) async {
    final int result = await _channel.invokeMethod(
      'configLer',
      {'eArqConfig': eArqConfig},
    );
    return result;
  }

  Future<int> configGravarValor({
    required String sessao,
    required String chave,
    required String valor,
  }) async {
    final int result = await _channel.invokeMethod(
      'configGravarValor',
      {'sessao': sessao, 'chave': chave, 'valor': valor},
    );
    return result;
  }

  Future<String> configLerValor({
    required String sessao,
    required String chave,
  }) async {
    final String result = await _channel.invokeMethod(
      'configLerValor',
      {'sessao': sessao, 'chave': chave},
    );
    return result;
  }

  Future<double> convertDateToTDateTime(int epochMillis) async {
    final double result = await _channel.invokeMethod(
      'convertDateToTDateTime',
      {'epochMillis': epochMillis},
    );
    return result;
  }

  Future<String> gerarQRCodeEstatico({
    required String valor,
    String informacoesAdicionais = '',
    required String txId,
  }) async {
    final String result = await _channel.invokeMethod(
      'GerarQRCodeEstatico',
      {
        'valor': valor,
        'informacoesAdicionais': informacoesAdicionais,
        'txId': txId,
      },
    );
    return result;
  }

  Future<String> criarCobrancaImediata({
    required String criarCobrancaImediata,
    required String txId,
  }) async {
    final String result = await _channel.invokeMethod(
      'CriarCobrancaImediata',
      {'criarCobrancaImediata': criarCobrancaImediata, 'txId': txId},
    );
    return result;
  }

  Future<String> revisarCobrancaImediata({
    required String revisarCobrancaImediata,
    required String txId,
  }) async {
    final String result = await _channel.invokeMethod(
      'RevisarCobrancaImediata',
      {'revisarCobrancaImediata': revisarCobrancaImediata, 'txId': txId},
    );
    return result;
  }

  Future<String> consultarCobrancaImediata({
    required String txId,
    required int revisao,
  }) async {
    final String result = await _channel.invokeMethod(
      'ConsultarCobrancaImediata',
      {'txId': txId, 'revisao': revisao},
    );
    return result;
  }

  Future<String> cancelarCobrancaImediata({required String txId}) async {
    final String result = await _channel.invokeMethod(
      'CancelarCobrancaImediata',
      {'txId': txId},
    );
    return result;
  }

  Future<String> consultarCobrancasCob({
    required double tDateTimeInicial,
    required double tDateTimeFinal,
    required String cpfCnpj,
    required bool location,
    required int status,
    required int pagAtual,
    required int itensPorPagina,
  }) async {
    final String result = await _channel.invokeMethod(
      'ConsultarCobrancasCob',
      {
        'tDateTimeInicial': tDateTimeInicial,
        'tDateTimeFinal': tDateTimeFinal,
        'cpfCnpj': cpfCnpj,
        'location': location,
        'status': status,
        'pagAtual': pagAtual,
        'itensPorPagina': itensPorPagina,
      },
    );
    return result;
  }

  Future<String> criarCobranca({
    required String criarCobranca,
    required String txId,
  }) async {
    final String result = await _channel.invokeMethod(
      'CriarCobranca',
      {'criarCobranca': criarCobranca, 'txId': txId},
    );
    return result;
  }

  Future<String> revisarCobranca({
    required String revisarCobranca,
    required String txId,
  }) async {
    final String result = await _channel.invokeMethod(
      'RevisarCobranca',
      {'revisarCobranca': revisarCobranca, 'txId': txId},
    );
    return result;
  }

  Future<String> consultarCobranca({
    required String txId,
    required int revisao,
  }) async {
    final String result = await _channel.invokeMethod(
      'ConsultarCobranca',
      {'txId': txId, 'revisao': revisao},
    );
    return result;
  }

  Future<String> consultarCobrancasCobV({
    required double tDateTimeInicial,
    required double tDateTimeFinal,
    required String cpfCnpj,
    required bool location,
    required int status,
    required int pagAtual,
    required int itensPorPagina,
  }) async {
    final String result = await _channel.invokeMethod(
      'ConsultarCobrancasCobV',
      {
        'tDateTimeInicial': tDateTimeInicial,
        'tDateTimeFinal': tDateTimeFinal,
        'cpfCnpj': cpfCnpj,
        'location': location,
        'status': status,
        'pagAtual': pagAtual,
        'itensPorPagina': itensPorPagina,
      },
    );
    return result;
  }

  Future<String> consultarPix({required String e2eId}) async {
    final String result = await _channel.invokeMethod(
      'ConsultarPix',
      {'e2eId': e2eId},
    );
    return result;
  }

  Future<String> consultarPixRecebidos({
    required double tDateTimeInicial,
    required double tDateTimeFinal,
    required String txId,
    required String cpfCnpj,
    required int pagAtual,
    required int itensPorPagina,
  }) async {
    final String result = await _channel.invokeMethod(
      'ConsultarPixRecebidos',
      {
        'tDateTimeInicial': tDateTimeInicial,
        'tDateTimeFinal': tDateTimeFinal,
        'txId': txId,
        'cpfCnpj': cpfCnpj,
        'pagAtual': pagAtual,
        'itensPorPagina': itensPorPagina,
      },
    );
    return result;
  }

  Future<String> solicitarDevolucaoPix({
    required String solicitarDevolucaoPIX,
    required String e2eId,
    required String idDevolucao,
  }) async {
    final String result = await _channel.invokeMethod(
      'SolicitarDevolucaoPix',
      {
        'solicitarDevolucaoPIX': solicitarDevolucaoPIX,
        'e2eId': e2eId,
        'idDevolucao': idDevolucao,
      },
    );
    return result;
  }

  Future<String> consultarDevolucaoPix({
    required String e2eId,
    required String idDevolucao,
  }) async {
    final String result = await _channel.invokeMethod(
      'ConsultarDevolucaoPix',
      {'e2eId': e2eId, 'idDevolucao': idDevolucao},
    );
    return result;
  }
}

