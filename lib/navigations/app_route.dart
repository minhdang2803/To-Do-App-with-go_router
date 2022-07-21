import 'package:flutter/material.dart';
import 'package:todoapp/components/todo_path.dart';
import 'package:todoapp/providers/providers.dart';
import 'package:todoapp/screens/screens.dart';

import '../models/models.dart';

class AppRouter extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  @override
  GlobalKey<NavigatorState> navigatorKey;
  final AppStateManager appStateManager;
  final TaskManager taskManager;

  AppRouter({required this.appStateManager, required this.taskManager})
      : navigatorKey = GlobalKey<NavigatorState>() {
    appStateManager.addListener(notifyListeners);
    taskManager.addListener(notifyListeners);
  }

  @override
  void dispose() {
    super.dispose();
    appStateManager.removeListener(notifyListeners);
    taskManager.removeListener(notifyListeners);
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: _handleOnPop,
      pages: [
        //TODO SplashScreen
        if (!appStateManager.isSplashScreen) SplashScreen.page(),
        //TODO OnboardingScreen
        if (appStateManager.isSplashScreen &&
            appStateManager.isOnboardingScreen == false)
          OnboardingScreen.page(),
        //TODO: Goto HomePage
        if (appStateManager.isOnboardingScreen)
          Homepage.page(appStateManager.currentIndex),
        //TODO: Goto NoteScreen
        if (appStateManager.isOnNoteScreen) NoteScreen.page(),
        //TODO: Goto EditingScreen
        if (appStateManager.isOnEditngScreen)
          EditingScreen.page(Task(
            chipLabel: taskManager.getPriority(taskManager.getSelection),
            backgroundColor: taskManager.getColor.value,
            title: taskManager.getTitle,
            description: taskManager.getDescription,
            contextInside: taskManager.getContentInside,
          ))
      ],
    );
  }

  bool _handleOnPop(Route<dynamic> route, value) {
    if (!route.didPop(value)) {
      return false;
    }
    if (route.settings.name == TodoPages.onboardingPath) {
      appStateManager.logout();
    }
    if (route.settings.name == TodoPages.item) {
      appStateManager.gotoNoteScreen(false);
    }
    if (route.settings.name == TodoPages.editing) {
      appStateManager.gotoEditingScreen(false);
    }
    return true;
  }

  @override
  // ignore: avoid_returning_null_for_void
  Future<void> setNewRoutePath(configuration) async => null;
}
