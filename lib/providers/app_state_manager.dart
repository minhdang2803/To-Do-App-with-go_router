import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStateManager extends ChangeNotifier {
  SharedPreferences prefs;
  AppStateManager(this.prefs);
  bool splashScreen = false;
  bool _onBoardingScreen = false;
  bool _noteScreen = false;
  bool _editingScreen = false;
  int _selectedTab = 0;

  bool get isSplashScreen => splashScreen;
  bool get isOnboardingScreen => _onBoardingScreen;
  bool get isOnNoteScreen => _noteScreen;
  bool get isOnEditngScreen => _editingScreen;
  int get currentIndex => _selectedTab;

  void initializeApp() {
    Timer(const Duration(seconds: 3), () {
      splashScreen = true;
      notifyListeners();
    });
  }

  void isOnBoardingScreenDone() {
    _onBoardingScreen = true;
    prefs.setBool('onboarding', true);
    notifyListeners();
  }

  void goToTab(index) {
    _selectedTab = index;
    notifyListeners();
  }

  void gotoNoteScreen(bool selected) {
    _noteScreen = selected;
    notifyListeners();
  }

  void gotoEditingScreen(bool selected) {
    _editingScreen = selected;
    notifyListeners();
  }

  void logout() {
    _onBoardingScreen = false;
    splashScreen = false;
    _selectedTab = 0;
    initializeApp();
    notifyListeners();
  }

  void checkFirstTime() {
    _onBoardingScreen = prefs.getBool('onboarding') ?? false;
  }
}
