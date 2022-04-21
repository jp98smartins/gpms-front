import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_fonts.dart';

abstract class AppTheme {
  ThemeData get getAppTheme;
}

class LightAppTheme implements AppTheme {
  static const double defaultBorderWidth = 2.0;
  static const double defaultCheckboxBorderWidth = 0.5;
  static const double defaultElevation = 4.0;
  static const double defaultRadius = 8.0;
  static const double defaultCheckboxRadius = 4.0;

  @override
  ThemeData get getAppTheme => ThemeData(
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
          /// BUTTON -----
          ///
          /// KANIT - BOLD - 16
          button: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            fontFamily: AppFonts.getPrimaryFont,
          ),

          /// KANIT - BOLD - 18 - VERMELHO
          headline1: TextStyle(
            fontFamily: AppFonts.getPrimaryFont,
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),

          /// KANIT - BOLD - 16 - VERMELHO
          headline2: TextStyle(
            fontFamily: AppFonts.getPrimaryFont,
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),

          /// KANIT - BOLD - 14 - VERMELHO
          headline3: TextStyle(
            fontFamily: AppFonts.getPrimaryFont,
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),

          /// KANIT - BOLD - 12 - VERMELHO
          headline4: TextStyle(
            fontFamily: AppFonts.getPrimaryFont,
            fontSize: 12.0,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),

          /// KANIT - SEMIBOLD - 16 - VERMELHO
          headline5: TextStyle(
            fontFamily: AppFonts.getPrimaryFont,
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),

          /// KANIT - SEMIBOLD - 14 - VERMELHO
          headline6: TextStyle(
            fontFamily: AppFonts.getPrimaryFont,
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),

          /// BODIES -----
          ///
          /// KANIT - BOLD - 12
          bodyText1: TextStyle(
            fontFamily: AppFonts.getPrimaryFont,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),

          /// KANIT - SEMIBOLD - 12
          bodyText2: TextStyle(
            fontFamily: AppFonts.getPrimaryFont,
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),

          /// SUBTITLES -----
          ///
          /// KANIT - LIGHT - 12
          subtitle1: TextStyle(
            fontFamily: AppFonts.getPrimaryFont,
            fontSize: 12.0,
            fontWeight: FontWeight.w300,
          ),

          /// KANIT - LIGHT - 12 - UNDERLIDED
          subtitle2: TextStyle(
            fontFamily: AppFonts.getPrimaryFont,
            fontSize: 12.0,
            fontWeight: FontWeight.w300,
            decoration: TextDecoration.underline,
          ),

          /// CAPTION -----
          ///
          /// KANIT - LIGHT - 11
          caption: TextStyle(
            fontFamily: AppFonts.getPrimaryFont,
            fontSize: 11.0,
            fontWeight: FontWeight.w300,
          ),
        ),
        // TextField Theme
        inputDecorationTheme: InputDecorationTheme(
          // Enabled Text and Border Style
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.foregroundSecondary,
              width: defaultBorderWidth,
            ),
            borderRadius: BorderRadius.circular(defaultRadius),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.foregroundPrimary,
              width: defaultBorderWidth,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(defaultRadius),
              bottomRight: Radius.circular(defaultRadius),
            ),
          ),
          hintStyle: TextStyle(
            color: AppColors.foregroundTertiary,
            fontFamily: AppFonts.getPrimaryFont,
            fontSize: 12.0,
          ),
          // Focused Text and Border Style
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.primary,
              width: defaultBorderWidth,
            ),
            borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
          ),
          focusColor: AppColors.foregroundTertiary,
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.error,
              width: defaultBorderWidth,
            ),
            borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
          ),
          // Error Text and Border Style
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.error,
              width: defaultBorderWidth,
            ),
            borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
          ),
          errorStyle: TextStyle(
            color: AppColors.error,
            fontFamily: AppFonts.getSecondaryFont,
            fontSize: 10.0,
          ),
          contentPadding: EdgeInsets.only(left: 10.0),
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: AppColors.info15,
        ),
        // Colors
        primaryColor: AppColors.primary,
        backgroundColor: AppColors.backgroundPrimary,
        scaffoldBackgroundColor: AppColors.backgroundPrimary,
        brightness: Brightness.dark,
        // CheckBox
        checkboxTheme: CheckboxThemeData(
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: AppColors.foregroundTertiary,
              width: defaultCheckboxBorderWidth,
            ),
            borderRadius: BorderRadius.circular(defaultCheckboxRadius),
          ),
        ),
        // Dialog
        dialogBackgroundColor: AppColors.shadow,
        dialogTheme: const DialogTheme(
          backgroundColor: AppColors.backgroundPrimary,
        ),
      );
}
