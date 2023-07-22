import 'package:flutter/material.dart';

class AppTheme {
  final bool isDarkmode;

  AppTheme({this.isDarkmode = false});

  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        colorScheme: isDarkmode
            ? const ColorScheme(
                brightness: Brightness.dark,
                primary: Colors.white,
                onPrimary: Colors.black,
                secondary: Colors.cyan,
                onSecondary: Colors.white,
                error: Colors.red,
                onError: Colors.black,
                background: Color.fromARGB(255, 28, 29, 29),
                onBackground: Colors.white,
                surface: Color.fromARGB(255, 28, 29, 29),
                onSurface: Colors.white,
              )
            : const ColorScheme(
                brightness: Brightness.light,
                primary: Colors.blueAccent,
                onPrimary: Colors.white,
                secondary: Colors.grey,
                onSecondary: Colors.black,
                error: Colors.red,
                onError: Colors.white,
                background: Colors.white,
                onBackground: Colors.black,
                surface: Colors.white,
                onSurface: Colors.black,
              ),
        //brightness: isDarkmode ? Brightness.dark : Brightness.light,
      );

  AppTheme copyWith({
    bool? isDarkmode,
  }) =>
      AppTheme(
        isDarkmode: isDarkmode ?? this.isDarkmode,
      );
}
