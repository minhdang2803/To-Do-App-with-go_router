import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/navigations/app_route.dart';
import 'package:todoapp/providers/providers.dart';
import 'package:todoapp/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final todoThemeProvider =
      TodoThemeManager(isDarkMode: prefs.getBool('isDarkTheme') ?? false);
  runApp(
    ChangeNotifierProvider(
      create: (context) => todoThemeProvider,
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
  final ThemeData theme = TodoThemeManager.light();

  final _listManager = TaskManager();

  final _appStateManager = AppStateManager();

  late AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _appRouter = AppRouter(
      appStateManager: _appStateManager,
      taskManager: _listManager,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => _listManager),
        ChangeNotifierProvider(create: (context) => _appStateManager),
      ],
      child: Consumer<TodoThemeManager>(
        builder: ((context, value, child) => MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: value.getTheme,
              title: 'To Do App',
              home: Router(
                routerDelegate: _appRouter,
                backButtonDispatcher: RootBackButtonDispatcher(),
              ),
            )),
      ),
    );
  }
}
