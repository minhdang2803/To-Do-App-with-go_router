import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/components/todo_path.dart';
import 'package:todoapp/providers/providers.dart';
import 'package:todoapp/screens/screens.dart';
import '../models/models.dart';

class AppRouter extends ChangeNotifier {
  final AppStateManager appStateManager;

  AppRouter({required this.appStateManager});

  late final router = GoRouter(
      refreshListenable: appStateManager,
      debugLogDiagnostics: true,
      urlPathStrategy: UrlPathStrategy.path,
      routes: [
        GoRoute(
          path: TodoPages.splashPath,
          name: TodoPages.splashPath,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              SplashScreen.page(),
        ),
        GoRoute(
            path: TodoPages.onboardingPath,
            name: TodoPages.onboardingPath,
            pageBuilder: (BuildContext context, GoRouterState state) =>
                OnboardingScreen.page()),
        GoRoute(
          path: '/home',
          name: TodoPages.home,
          pageBuilder: (BuildContext context, GoRouterState state) {
            int index = int.parse(state.queryParams['tab']!);
            return Homepage.page(index);
          },
        ),
        GoRoute(
            path: '/home/add',
            name: TodoPages.item,
            pageBuilder: (context, state) {
              return AddingScreen.page();
            }),
        GoRoute(
            path: '/home/detail',
            name: TodoPages.editing,
            pageBuilder: (context, state) {
              return EditingScreen.page(state.extra! as Task);
            }),
      ],
      errorPageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey,
            child: ErrorPage(error: state.error),
          ),
      redirect: (state) {
        if (state.subloc == '/' && !appStateManager.isSplashScreen) {
          appStateManager.initializeApp();
          return state.namedLocation(TodoPages.splashPath);
        }
        if (appStateManager.isSplashScreen &&
            !appStateManager.isOnboardingScreen &&
            state.subloc == TodoPages.splashPath) {
          appStateManager.checkFirstTime();
          if (appStateManager.isOnboardingScreen == true) {
            return null;
          } else {
            return state.namedLocation(TodoPages.onboardingPath);
          }
        }
        if (appStateManager.isOnboardingScreen &&
            state.subloc == TodoPages.onboardingPath) {
          return state.namedLocation(TodoPages.home, params: {'tab': 'list'});
        }
        return null;
      });
}
