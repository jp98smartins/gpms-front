import 'package:flutter/material.dart';

abstract class AppColors {
  // Background Colors ----
  static const Color backgroundPrimary = Color(0xFF333333);
  static const Color backgroundSecondary = Color(0xFF575656);
  static const Color backgroungTertiary = Color(0xFFFFFFFF);

  // Foreground Colors ----
  static const Color foregroundPrimary = Color(0xFFFFFFFF);
  static const Color foregroundSecondary = Color(0xFFC4C4C4);
  static const Color foregroundTertiary = Color(0xFF000000);

  // Error Colors ----
  static const Color errorPrimary = Color(0xFFE50000);
  static const Color errorSecondary = Color(0x99E50000);

  // Success Colors ----
  static const Color successPrimary = Color(0xFF1EA534);
  static const Color successSecondary = Color(0x991EA534);

  // Transparent, Overlay and Shadow Colors ----
  static const Color overlay = Color(0x99575656);
  static const Color transparent = Color(0x00FFFFFF);
  static const Color shadow = Color(0x80FFFFFF);

  // Board Colors -----
  static const Color lightBoardPosition = Color(0xFFCDD4D7);
  static const Color darkBoardPosition = Color(0xFF7599BA);
}
