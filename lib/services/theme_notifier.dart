import 'package:flutter/material.dart';

class ThemeNotifier with ChangeNotifier {
  ThemeData _themeData;

  ThemeNotifier(this._themeData);

  getTheme() => _themeData;

  setTheme(ThemeData themeData) async {
    _themeData = themeData;
    notifyListeners();
  }
}

final darkTheme = ThemeData(
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  backgroundColor: Colors.black,
  accentColor: Colors.white,
  accentIconTheme: IconThemeData(color: Colors.white),
  dividerColor: Colors.black12,
  iconTheme: IconThemeData(color: Colors.white),
  scaffoldBackgroundColor: Colors.black,
  bottomAppBarTheme: BottomAppBarTheme(color: Colors.black),
  cardColor: Colors.black,
  dividerTheme: DividerThemeData(
    color: Colors.grey[700],
    thickness: 0.6,
  ),
  tabBarTheme: TabBarTheme(unselectedLabelColor: Colors.white),
);

//  ThemeData.light().copyWith(
//   dividerTheme: DividerThemeData(
//     color: Colors.grey[700],
//     thickness: 1,
//   ),
//   iconTheme: IconThemeData(color: Colors.black),
// );
final lightTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.white,
  brightness: Brightness.light,
  backgroundColor: const Color(0xFFE5E5E5),
  accentColor: Colors.black,
  accentIconTheme: IconThemeData(color: Colors.black),
  dividerColor: Colors.black,
);
