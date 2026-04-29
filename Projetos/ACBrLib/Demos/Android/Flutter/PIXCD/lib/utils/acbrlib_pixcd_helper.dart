import 'dart:io';

import 'package:demo_acbrpixcd_flutter/plugin/acbrpixcd_plugin.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

/// Classe Singleton para gerenciar uma instância do plugin ACBrLibPIXCD.
///
/// Essa classe garante que apenas uma instância do plugin seja criada e utilizada
/// em toda a aplicação, seguindo o padrão do demo BAL.
class ACBrLibPixCDHelper {
  ACBrLibPixCDHelper._privateConstructor();

  static final ACBrLibPixCDHelper _instance =
      ACBrLibPixCDHelper._privateConstructor();

  factory ACBrLibPixCDHelper() => _instance;

  final ACBrPixCDPlugin _acbrpixcdplugin = ACBrPixCDPlugin();

  ACBrPixCDPlugin get acbrpixcdplugin => _acbrpixcdplugin;

  Future<String?> pickFile({
    String title = 'Selecione um arquivo',
    required String suggestedFileName,
    List<String> mimeTypes = const [],
  }) async {
    // Picker 100% Flutter (sem ActivityAware no plugin Android).
    final result = await FilePicker.platform.pickFiles(
      dialogTitle: title,
      allowMultiple: false,
      withData: true,
      type: FileType.any,
    );

    if (result == null || result.files.isEmpty) return null;
    final file = result.files.single;

    final bytes =
        file.bytes ?? (file.path != null ? await File(file.path!).readAsBytes() : null);
    if (bytes == null) {
      throw PlatformException(
        code: 'PICKER_NO_BYTES',
        message: 'Não foi possível ler o arquivo selecionado.',
      );
    }

    final baseDir = await getApplicationSupportDirectory();
    final dir = Directory(
      '${baseDir.path}${Platform.pathSeparator}certificados',
    );
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }

    final safeName = suggestedFileName.trim().isEmpty
        ? (file.name.isNotEmpty ? file.name : 'arquivo')
        : suggestedFileName;
    final outFile = File('${dir.path}${Platform.pathSeparator}$safeName');
    await outFile.writeAsBytes(bytes, flush: true);
    return outFile.path;
  }
}

