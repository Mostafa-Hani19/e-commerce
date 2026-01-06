import 'package:flutter/material.dart';

class AppTheme {
  static const Color orangeColor = Color(0xffFA6E21);
  static const Color blackColor = Colors.black;
  static const Color whiteColor = Colors.white;
  static const Color greyColor = Colors.grey;
  static const Color redColor = Colors.red;

  static const Color darkBackgroundColor = Color(0xff121212);
  static const Color darkSurfaceColor = Color(0xff1E1E1E);

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: orangeColor,
      scaffoldBackgroundColor: whiteColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: whiteColor,
        elevation: 0,
        iconTheme: IconThemeData(color: blackColor),
        titleTextStyle: TextStyle(
          color: blackColor,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: orangeColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: orangeColor),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xffF3F4F6),
        hintStyle: const TextStyle(color: Colors.grey),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: orangeColor),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: orangeColor,
      scaffoldBackgroundColor: darkBackgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: darkBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: whiteColor),
        titleTextStyle: TextStyle(
          color: whiteColor,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: orangeColor,
          foregroundColor: whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      colorScheme: const ColorScheme.dark(
        primary: orangeColor,
        secondary: orangeColor,
        surface: darkSurfaceColor,
        background: darkBackgroundColor,
        onBackground: whiteColor,
        onSurface: whiteColor,
      ),
      // Ensure text is white on dark background by default
      textTheme: ThemeData.dark().textTheme.apply(
        bodyColor: whiteColor,
        displayColor: whiteColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: darkSurfaceColor,
        hintStyle: const TextStyle(color: Colors.grey),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: orangeColor),
        ),
      ),
    );
  }
}
