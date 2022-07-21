import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/components/todo_path.dart';
import 'package:todoapp/providers/app_state_manager.dart';
import 'package:todoapp/providers/providers.dart';
import 'package:todoapp/screens/screens.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key, required this.currentTab}) : super(key: key);
  static MaterialPage page(int index) {
    return MaterialPage(
      child: Homepage(currentTab: index),
      name: TodoPages.home,
      key: ValueKey(TodoPages.home),
    );
  }

  final int currentTab;
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  static List<Widget> page = <Widget>[
    const ListScreen(),
    const SettingScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateManager>(
      builder: (context, appStateManager, child) {
        return Scaffold(
          body: SafeArea(
            child: IndexedStack(
              index: appStateManager.currentIndex,
              children: page,
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
              BottomNavigationBarItem(icon: Icon(Icons.add), label: 'New'),
            ],
            currentIndex: widget.currentTab,
            selectedItemColor: Colors.purple.shade400,
            onTap: (index) => appStateManager.goToTab(index),
          ),
        );
      },
    );
  }
}
