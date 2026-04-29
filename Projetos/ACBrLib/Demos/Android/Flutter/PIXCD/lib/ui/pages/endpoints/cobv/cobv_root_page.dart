import 'package:demo_acbrpixcd_flutter/plugin/acbrpixcd_plugin.dart';
import 'package:demo_acbrpixcd_flutter/ui/pages/endpoints/cobv/cancelar_cobranca_page.dart';
import 'package:demo_acbrpixcd_flutter/ui/pages/endpoints/cobv/consultar_cobranca_page.dart';
import 'package:demo_acbrpixcd_flutter/ui/pages/endpoints/cobv/consultar_cobrancas_cobv_page.dart';
import 'package:demo_acbrpixcd_flutter/ui/pages/endpoints/cobv/criar_cobranca_page.dart';
import 'package:demo_acbrpixcd_flutter/ui/pages/endpoints/cobv/revisar_cobranca_page.dart';
import 'package:demo_acbrpixcd_flutter/ui/widgets/drawer_tab_scaffold.dart';
import 'package:flutter/material.dart';

class CobVRootPage extends StatelessWidget {
  const CobVRootPage({super.key, required this.plugin});

  final ACBrPixCDPlugin plugin;

  @override
  Widget build(BuildContext context) {
    return DrawerTabScaffold(
      items: const [
        DrawerTabItem(title: 'Criar Cobrança', icon: Icons.add_circle_outline),
        DrawerTabItem(title: 'Consultar Cobrança', icon: Icons.search),
        DrawerTabItem(title: 'Consultar Cobranças CobV', icon: Icons.list),
        DrawerTabItem(title: 'Revisar Cobrança', icon: Icons.edit),
        DrawerTabItem(title: 'Cancelar Cobrança', icon: Icons.cancel),
      ],
      pages: [
        CriarCobrancaPage(plugin: plugin),
        ConsultarCobrancaPage(plugin: plugin),
        ConsultarCobrancasCobVPage(plugin: plugin),
        RevisarCobrancaPage(plugin: plugin),
        CancelarCobrancaPage(plugin: plugin),
      ],
    );
  }
}

