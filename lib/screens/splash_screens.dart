import 'package:flutter/material.dart';
import 'package:todoapp/components/todo_path.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static MaterialPage page() {
    return MaterialPage(
      child: const SplashScreen(),
      key: ValueKey(TodoPages.splashPath),
      name: TodoPages.splashPath,
    );
  }

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(image: AssetImage('assets/logo.png')),
            Text(
              'What To Doooo!',
              style: Theme.of(context).textTheme.headline1,
            )
          ],
        )),
      ),
    );
  }
}
