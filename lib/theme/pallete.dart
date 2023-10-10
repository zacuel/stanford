import 'package:flutter/material.dart';

class Pallete {
  static const pastelBackground = Color(0xFFffefcb);
  static const pastelRed = Color(0xFFFAA0A0);
  static const pastelOrange = Color(0xFFFAC898);
  static const pastelYellow = Color(0xFFFDFD96);
  static const pastelGreen = Color(0xFF77DD77);
  static const pastelBlue = Color(0xFFAEC6CF);
  static const pastelIndigo = Color(0xFF8686af);
  static const pastelViolet = Color(0xFFC3B1E1);

  static var pastelTheme = ThemeData.light().copyWith(
      scaffoldBackgroundColor: pastelBackground,
      appBarTheme: const AppBarTheme(
        backgroundColor: pastelIndigo,
        iconTheme: IconThemeData(color: pastelGreen),
      ),
      primaryColor: pastelOrange,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(backgroundColor: pastelOrange),
      ),
      inputDecorationTheme:
          const InputDecorationTheme(fillColor: pastelYellow));
}
