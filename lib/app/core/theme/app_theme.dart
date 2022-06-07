import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_fonts.dart';

abstract class AppTheme {
  ThemeData get getAppTheme;
}

class DefaultAppTheme implements AppTheme {
  static const double defaultBorderWidth = 2.0;
  static const double defaultCheckboxBorderWidth = 0.5;
  static const double defaultElevation = 4.0;
  static const double defaultRadius = 8.0;
  static const double defaultCheckboxRadius = 4.0;

  @override
  ThemeData get getAppTheme => ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.backgroundSecondary,
          elevation: defaultElevation,
          foregroundColor: AppColors.foregroundPrimary,
          titleTextStyle: TextStyle(
            color: AppColors.foregroundPrimary,
            fontFamily: AppFonts.title,
            fontSize: 36.0,
            fontWeight: FontWeight.w700,
          ),
          centerTitle: false,
          actionsIconTheme: IconThemeData(
            color: AppColors.foregroundPrimary,
            size: 28.0,
          ),
          shadowColor: AppColors.shadow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(defaultRadius),
              bottomRight: Radius.circular(defaultRadius),
            ),
          ),
        ),
        // Elevated Button Theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith(
              (states) => AppColors.backgroungTertiary,
            ),
            elevation: MaterialStateProperty.resolveWith(
              (states) => defaultElevation,
            ),
            foregroundColor: MaterialStateProperty.resolveWith(
              (states) => AppColors.foregroundTertiary,
            ),
            fixedSize: MaterialStateProperty.resolveWith(
              (states) => const Size(250, 60),
            ),
            shape: MaterialStateProperty.resolveWith(
              (states) => RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(defaultRadius),
                side: const BorderSide(
                  color: AppColors.backgroungTertiary,
                  width: defaultBorderWidth,
                ),
              ),
            ),
          ),
        ),
        // Text Themes
        textTheme: const TextTheme(
          /// Button Text
          ///
          /// [AppColors.backgroundSecondary] - #575656
          /// [AppFonts.primary] - Oxanium
          /// [FontSize] - 20
          /// [FontWeight.w700] - Bold
          button: TextStyle(
            color: AppColors.backgroundSecondary,
            fontFamily: AppFonts.primary,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),

          /// Main Title
          ///
          /// [AppColors.foregroundPrimary] - White
          /// [AppFonts.title] - Caveat
          /// [FontSize] - 96
          /// [FontWeight.w700] - Bold
          headline1: TextStyle(
            color: AppColors.foregroundPrimary,
            fontFamily: AppFonts.title,
            fontSize: 96.0,
            fontWeight: FontWeight.w700,
          ),

          /// AppBar Title
          ///
          /// [AppColors.foregroundPrimary] - White
          /// [AppFonts.title] - Caveat
          /// [FontSize] - 36
          /// [FontWeight.w700] - Bold
          headline2: TextStyle(
            color: AppColors.foregroundPrimary,
            fontFamily: AppFonts.title,
            fontSize: 36.0,
            fontWeight: FontWeight.w700,
          ),

          /// Default Text
          ///
          /// [AppColors.foregroundPrimary] - White
          /// [AppFonts.primary] - Oxanium
          /// [FontSize] - 20
          /// [FontWeight.w700] - Bold
          bodyText1: TextStyle(
            color: AppColors.foregroundPrimary,
            fontFamily: AppFonts.primary,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),

          /// Dialog Text
          ///
          /// [AppColors.foregroundPrimary] - White
          /// [AppFonts.primary] - Oxanium
          /// [FontSize] - 24
          /// [FontWeight.w700] - Bold
          bodyText2: TextStyle(
            color: AppColors.foregroundPrimary,
            fontFamily: AppFonts.primary,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),

          /// Dropdown Button Text
          ///
          /// [AppColors.foregroundPrimary] - White
          /// [AppFonts.secondary] - Arial
          /// [FontSize] - 18
          /// [FontWeight.w700] - Bold
          subtitle1: TextStyle(
            fontFamily: AppFonts.secondary,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),

          /// Board Text
          ///
          /// [AppColors.foregroundPrimary] - White
          /// [AppFonts.secondary] - Arial
          /// [FontSize] - 24
          /// [FontWeight.w700] - Bold
          caption: TextStyle(
            fontFamily: AppFonts.secondary,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        // TextField Theme
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
          constraints: const BoxConstraints(
            maxWidth: 250,
            minWidth: 250,
            minHeight: 60,
          ),
          // Enabled Text and Border Style
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.foregroundSecondary,
              width: defaultBorderWidth,
            ),
            borderRadius: BorderRadius.circular(defaultRadius),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.foregroundSecondary,
              width: defaultBorderWidth,
            ),
            borderRadius: BorderRadius.circular(defaultRadius),
          ),
          hintStyle: const TextStyle(
            color: AppColors.foregroundSecondary,
            fontFamily: AppFonts.primary,
            fontSize: 12.0,
          ),
          // Focused Text and Border Style
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.foregroundPrimary,
              width: defaultBorderWidth,
            ),
            borderRadius: BorderRadius.circular(defaultRadius),
          ),
          focusColor: AppColors.foregroundPrimary,
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.errorPrimary,
              width: defaultBorderWidth,
            ),
            borderRadius: BorderRadius.circular(defaultRadius),
          ),
          // Error Text and Border Style
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.errorSecondary,
              width: defaultBorderWidth,
            ),
            borderRadius: BorderRadius.circular(defaultRadius),
          ),
          errorStyle: const TextStyle(
            color: AppColors.errorPrimary,
            fontFamily: AppFonts.secondary,
            fontSize: 12.0,
          ),
          suffixIconColor: AppColors.foregroundSecondary,
        ),
        // Colors
        primaryColor: AppColors.foregroundPrimary,
        backgroundColor: AppColors.backgroundPrimary,
        scaffoldBackgroundColor: AppColors.backgroundPrimary,
        brightness: Brightness.dark,
        // Dialog
        dialogBackgroundColor: AppColors.shadow,
        dialogTheme: const DialogTheme(
          alignment: Alignment.center,
          titleTextStyle: TextStyle(
            color: AppColors.foregroundPrimary,
            fontFamily: AppFonts.primary,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: AppColors.backgroungTertiary, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
          ),
          backgroundColor: AppColors.backgroundSecondary,
        ),
      );
}
