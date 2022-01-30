import 'package:flutter/material.dart';

class Themes {
  static const primaryColor = Colors.redAccent;
  static const backgroundColor = Color(0xff1a1924);
  static const darkBackgroundColor = Color(0xff6E7698);
  static const uiBlue = Colors.redAccent;
  static const uiBackground = Color(0xff252525);
  static final Color _whiteOnSurface = Colors.white.withOpacity(0.87);
  static BuildContext? context;
  static final lightTheme = ThemeData(
    indicatorColor: Colors.green,
    appBarTheme: const AppBarTheme(color: primaryColor),
    brightness: Brightness.light,
    primaryColor: primaryColor,
    accentColor: Colors.redAccent,
    iconTheme: const IconThemeData(color: Colors.black),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith(
        (states) {
          // If the button is pressed, return green, otherwise blue
          return states.contains(MaterialState.pressed)
              ? primaryColor.withOpacity(0.8)
              : primaryColor.withOpacity(0.8);
        },
      ),
      trackColor:
          MaterialStateProperty.all(Colors.grey.shade400), // voor nu goed
    ),
    hintColor: Colors.black,
    focusColor: primaryColor,
  );
  static final darkTheme = ThemeData(
    indicatorColor: Colors.green,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xff272727),
        showUnselectedLabels: false,
        selectedIconTheme: IconThemeData(
          color: primaryColor,
        ),
        selectedLabelStyle: TextStyle(color: primaryColor),
        elevation: 0,
        showSelectedLabels: false,
        unselectedIconTheme: IconThemeData(color: Themes.primaryColor),
        type: BottomNavigationBarType.fixed),
    scaffoldBackgroundColor: const Color(0xff121212),
    //scaffoldBackgroundColor: Colors.black,
    inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xff272727),
        hintStyle: TextStyle(color: _whiteOnSurface)),
    textTheme:
        TextTheme(bodyText2: TextStyle(color: Colors.white.withOpacity(0.87))),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(primaryColor),
        foregroundColor: MaterialStateProperty.all(Colors.white), // text color
      ),
    ),
    appBarTheme: const AppBarTheme(color: Color(0xff272727)),
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(primaryColor),
      trackColor: MaterialStateProperty.all(Colors.grey.shade500),
    ),

    //     MaterialStateProperty.resolveWith((states) {
    //   // If the button is pressed, return green, otherwise blue
    //   return states.contains(MaterialState.pressed)
    //       ? Colors.green
    //       : primaryColor.withOpacity(0.8);
    // }
  );
}
