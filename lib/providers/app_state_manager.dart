import 'dart:async';
import 'package:flutter/material.dart';

class AppStateManager extends ChangeNotifier {
  bool _splashScreen = false;
  bool _onBoardingScreen = false;
  bool _noteScreen = false;
  bool _editingScreen = false;
  int _selectedTab = 0;

  bool get isSplashScreen => _splashScreen;
  bool get isOnboardingScreen => _onBoardingScreen;
  bool get isOnNoteScreen => _noteScreen;
  bool get isOnEditngScreen => _editingScreen;
  int get currentIndex => _selectedTab;

  void initializeApp() {
    Timer(const Duration(milliseconds: 2000), () {
      _splashScreen = true;
      notifyListeners();
    });
    // _splashScreen = true;
  }

  void isOnBoardingScreen() {
    _onBoardingScreen = true;
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
    _splashScreen = false;
    _selectedTab = 0;
    initializeApp();
    notifyListeners();
  }
}
