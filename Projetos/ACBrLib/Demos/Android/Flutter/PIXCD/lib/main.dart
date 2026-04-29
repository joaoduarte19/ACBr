import 'package:flutter/material.dart';
import 'package:demo_acbrpixcd_flutter/ui/pages/qrcode_estatico_page.dart';
import 'package:demo_acbrpixcd_flutter/ui/pages/config/configuracoes_root_page.dart';
import 'package:demo_acbrpixcd_flutter/ui/pages/endpoints/cob/cob_root_page.dart';
import 'package:demo_acbrpixcd_flutter/ui/pages/endpoints/cobv/cobv_root_page.dart';
import 'package:demo_acbrpixcd_flutter/ui/pages/endpoints/pix/pix_root_page.dart';
import 'package:demo_acbrpixcd_flutter/utils/acbrlib_pixcd_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ACBrLibPixCDHelper().acbrpixcdplugin.inicializar();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF1E88E5);
    return MaterialApp(
      title: 'ACBrPIXCD Demo Flutter',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          primary: primaryColor,
          secondary: primaryColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          centerTitle: false,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.black54,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      home: const PixCDHomeShell(),
    );
  }
}

class PixCDHomeShell extends StatefulWidget {
  const PixCDHomeShell({super.key});

  @override
  State<PixCDHomeShell> createState() => _PixCDHomeShellState();
}

class _PixCDHomeShellState extends State<PixCDHomeShell> {
  final _plugin = ACBrLibPixCDHelper().acbrpixcdplugin;
  int _index = 0;

  late final List<Widget> _pages = [
    QrCodeEstaticoPage(plugin: _plugin),
    PixRootPage(plugin: _plugin),
    CobRootPage(plugin: _plugin),
    CobVRootPage(plugin: _plugin),
    ConfiguracoesRootPage(plugin: _plugin),
  ];

  @override
  Widget build(BuildContext context) {
    final title = switch (_index) {
      0 => 'QRCode',
      1 => 'EndPoint Pix',
      2 => 'EndPoint Cob',
      3 => 'EndPoint CobV',
      _ => 'Configurações',
    };

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: IndexedStack(
        index: _index,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: 'QRCode'),
          BottomNavigationBarItem(icon: Icon(Icons.payments), label: 'Pix'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'Cob'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt), label: 'CobV'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Configurações'),
        ],
      ),
    );
  }
}
