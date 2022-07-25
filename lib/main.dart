import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/navigations/app_route.dart';
import 'package:todoapp/providers/providers.dart';
import 'package:todoapp/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final listManager = TaskManager();
  final appStateManager = AppStateManager(prefs);
  final todoThemeProvider =
      TodoThemeManager(isDarkMode: prefs.getBool('isDarkTheme') ?? false);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => listManager),
        ChangeNotifierProvider(create: (context) => todoThemeProvider),
        ChangeNotifierProvider(create: (context) => appStateManager),
        ChangeNotifierProvider<AppRouter>(
          lazy: false,
          create: (BuildContext createContext) =>
              AppRouter(appStateManager: appStateManager),
        ),
      ],
      child: const MyTodo(),
    ),
  );
}

class MyTodo extends StatefulWidget {
  const MyTodo({Key? key}) : super(key: key);

  @override
  State<MyTodo> createState() => _MyTodoState();
}

class _MyTodoState extends State<MyTodo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final router = Provider.of<AppRouter>(context, listen: false).router;
    return Consumer<TodoThemeManager>(
      builder: ((context, value, child) => MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: value.getTheme,
            title: 'To Do App',
            routerDelegate: router.routerDelegate,
            routeInformationParser: router.routeInformationParser,
            routeInformationProvider: router.routeInformationProvider,
          )),
    );
  }
}
