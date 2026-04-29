import 'package:demo_acbrpixcd_flutter/plugin/acbrpixcd_plugin.dart';
import 'package:demo_acbrpixcd_flutter/ui/pages/endpoints/pix/consultar_devolucao_pix_page.dart';
import 'package:demo_acbrpixcd_flutter/ui/pages/endpoints/pix/consultar_pix_page.dart';
import 'package:demo_acbrpixcd_flutter/ui/pages/endpoints/pix/consultar_pix_recebidos_page.dart';
import 'package:demo_acbrpixcd_flutter/ui/pages/endpoints/pix/solicitar_devolucao_pix_page.dart';
import 'package:demo_acbrpixcd_flutter/ui/widgets/drawer_tab_scaffold.dart';
import 'package:flutter/material.dart';

class PixRootPage extends StatelessWidget {
  const PixRootPage({super.key, required this.plugin});

  final ACBrPixCDPlugin plugin;

  @override
  Widget build(BuildContext context) {
    return DrawerTabScaffold(
      items: const [
        DrawerTabItem(title: 'Consultar Pix', icon: Icons.search),
        DrawerTabItem(title: 'Consultar Pix Recebidos', icon: Icons.list),
        DrawerTabItem(title: 'Solicitar Devolução Pix', icon: Icons.undo),
        DrawerTabItem(title: 'Consultar Devolução Pix', icon: Icons.manage_search),
      ],
      pages: [
        ConsultarPixPage(plugin: plugin),
        ConsultarPixRecebidosPage(plugin: plugin),
        SolicitarDevolucaoPixPage(plugin: plugin),
        ConsultarDevolucaoPixPage(plugin: plugin),
      ],
    );
  }
}

