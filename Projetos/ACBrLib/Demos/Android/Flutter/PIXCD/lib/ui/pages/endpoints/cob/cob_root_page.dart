import 'package:demo_acbrpixcd_flutter/plugin/acbrpixcd_plugin.dart';
import 'package:demo_acbrpixcd_flutter/ui/pages/endpoints/cob/cancelar_cobranca_imediata_page.dart';
import 'package:demo_acbrpixcd_flutter/ui/pages/endpoints/cob/consultar_cobranca_imediata_page.dart';
import 'package:demo_acbrpixcd_flutter/ui/pages/endpoints/cob/consultar_cobrancas_cob_page.dart';
import 'package:demo_acbrpixcd_flutter/ui/pages/endpoints/cob/criar_cobranca_imediata_page.dart';
import 'package:demo_acbrpixcd_flutter/ui/pages/endpoints/cob/revisar_cobranca_imediata_page.dart';
import 'package:demo_acbrpixcd_flutter/ui/widgets/drawer_tab_scaffold.dart';
import 'package:flutter/material.dart';

class CobRootPage extends StatelessWidget {
  const CobRootPage({super.key, required this.plugin});

  final ACBrPixCDPlugin plugin;

  @override
  Widget build(BuildContext context) {
    return DrawerTabScaffold(
      items: const [
        DrawerTabItem(title: 'Criar Cobranca Imediata', icon: Icons.add_circle_outline),
        DrawerTabItem(title: 'Consultar Cobranca Imediata', icon: Icons.search),
        DrawerTabItem(title: 'Consultar Cobrancas Cob', icon: Icons.list),
        DrawerTabItem(title: 'Revisar Cobranca Imediata', icon: Icons.edit),
        DrawerTabItem(title: 'Cancelar Cobranca Imediata', icon: Icons.cancel),
      ],
      pages: [
        CriarCobrancaImediataPage(plugin: plugin),
        ConsultarCobrancaImediataPage(plugin: plugin),
        ConsultarCobrancasCobPage(plugin: plugin),
        RevisarCobrancaImediataPage(plugin: plugin),
        CancelarCobrancaImediataPage(plugin: plugin),
      ],
    );
  }
}

