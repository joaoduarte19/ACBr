import 'package:flutter/material.dart';

class DrawerTabItem {
  const DrawerTabItem({required this.title, required this.icon});

  final String title;
  final IconData icon;
}

class DrawerTabScaffold extends StatefulWidget {
  const DrawerTabScaffold({
    super.key,
    required this.items,
    required this.pages,
  }) : assert(items.length == pages.length);

  final List<DrawerTabItem> items;
  final List<Widget> pages;

  @override
  State<DrawerTabScaffold> createState() => _DrawerTabScaffoldState();
}

class _DrawerTabScaffoldState extends State<DrawerTabScaffold> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int _index = 0;

  void _select(int index) {
    setState(() => _index = index);
    _scaffoldKey.currentState?.closeDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            children: [
              for (int i = 0; i < widget.items.length; i++)
                ListTile(
                  leading: Icon(widget.items[i].icon),
                  title: Text(widget.items[i].title),
                  selected: i == _index,
                  onTap: () => _select(i),
                ),
            ],
          ),
        ),
      ),
      body: DefaultTabController(
        length: widget.items.length,
        initialIndex: _index,
        child: Builder(
          builder: (context) {
            final tabController = DefaultTabController.of(context);
            if (tabController.index != _index) {
              tabController.index = _index;
            }
            tabController.addListener(() {
              if (!tabController.indexIsChanging && tabController.index != _index) {
                setState(() => _index = tabController.index);
              }
            });

            return Column(
              children: [
                Material(
                  color: Theme.of(context).colorScheme.primary,
                  child: TabBar(
                    isScrollable: true,
                    indicatorColor: Colors.white,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white70,
                    tabs: [
                      for (final item in widget.items) Tab(text: item.title),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(children: widget.pages),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

