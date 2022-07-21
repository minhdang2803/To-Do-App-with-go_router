import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoThemeManager extends ChangeNotifier {
  late ThemeData _selectedTheme;
  late bool _isDark;
  Future<void> swapTheme(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value == true) {
      _isDark = true;
      _selectedTheme = dark();
      prefs.setBool('isDarkTheme', true);
    } else {
      _isDark = false;
      _selectedTheme = light();
      prefs.setBool('isDarkTheme', false);
    }
    notifyListeners();
  }

  TodoThemeManager({required bool isDarkMode}) {
    if (isDarkMode) {
      _isDark = true;
      _selectedTheme = dark();
    } else {
      _isDark = false;
      _selectedTheme = light();
    }
  }

  bool get getDarkMode => _isDark;
  ThemeData get getTheme => _selectedTheme;
  static const Color normalChipColor = Color(0xffc0aee0);
  static const Color importantChipColor = Color(0xffa28ad2);
  static const Color veryImportantChipCplor = Color(0xff8565c4);
  static TextTheme lightTextTheme = TextTheme(
    bodyText1: GoogleFonts.nunitoSans(
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    headline1: GoogleFonts.nunitoSans(
      fontSize: 30.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headline2: GoogleFonts.nunitoSans(
      fontSize: 21.0,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    headline3: GoogleFonts.nunitoSans(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    headline6: GoogleFonts.nunitoSans(
      fontSize: 10.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  );

  static TextTheme darkTextTheme = TextTheme(
    bodyText1: GoogleFonts.nunitoSans(
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    headline1: GoogleFonts.nunitoSans(
      fontSize: 30.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    headline2: GoogleFonts.nunitoSans(
      fontSize: 21.0,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    headline3: GoogleFonts.nunitoSans(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    headline6: GoogleFonts.nunitoSans(
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  );

  static ThemeData light() {
    return ThemeData(
        brightness: Brightness.light,
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateColor.resolveWith((states) {
            return Colors.black;
          }),
        ),
        appBarTheme: const AppBarTheme(
          foregroundColor: Color(0xff86829D),
          backgroundColor: Colors.white,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          foregroundColor: Colors.white,
          backgroundColor: Color(0xff86829D),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Color(0xff86829D),
        ),
        textTheme: lightTextTheme,
        primaryColor: Colors.white);
  }

  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(
        foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 72, 66, 112),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 72, 66, 112),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Color.fromARGB(255, 72, 66, 112),
      ),
      textTheme: darkTextTheme,
      primaryColor: Colors.black54,
    );
  }
}
