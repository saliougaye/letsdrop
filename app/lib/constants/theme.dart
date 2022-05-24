import 'package:flutter/material.dart';
import 'package:letsdrop/constants/colors.dart';
import 'package:letsdrop/constants/font_family.dart';

class AppThemes {
  AppThemes._();

  static final appThemeData = {
    AppTheme.light: ThemeData(
      backgroundColor: AppColors.lightFourthColor,
      textTheme: TextTheme(
        headline1: TextStyle(
          color: AppColors.lightSecondaryColor,
          fontFamily: AppFontFamily.montserrat,
          fontSize: 24,
          fontWeight: FontWeight.normal
        ),
        headline2: TextStyle(
          color: AppColors.lightPrimaryColor,
          fontFamily: AppFontFamily.proximaNova,
          fontSize: 22,
          fontWeight: FontWeight.w500
        ),
        headline3: TextStyle(
          color: AppColors.lightFifthColor,
          fontSize: 16,
          fontFamily: AppFontFamily.proximaNova
        ),
        subtitle1: TextStyle(
          color: AppColors.lightFourthColor,
          fontSize: 16,
          fontFamily: AppFontFamily.proximaNova,
          decoration: TextDecoration.underline
        ),
        subtitle2: TextStyle(
          color: AppColors.lightPrimaryColor,
          fontFamily: AppFontFamily.proximaNova,
          fontSize: 18,
          fontWeight: FontWeight.w400
        ),
        overline: TextStyle(
          color: AppColors.lightPrimaryColor,
          fontFamily: AppFontFamily.proximaNova,
          fontSize: 18,
          fontWeight: FontWeight.w700
        ),
        button: TextStyle(
          color: AppColors.lightSecondaryColor,
          fontFamily: AppFontFamily.proximaNova,
          fontSize: 18,
          wordSpacing: 2,
          letterSpacing: 1
        ),
      ),
      cardColor: AppColors.lightPrimaryColor.withOpacity(0.5),
      dividerColor: AppColors.lightPrimaryColor,
      splashColor: AppColors.lightPrimaryColor,
      indicatorColor: AppColors.lightSecondaryColor,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.lightSecondaryColor,
        foregroundColor: Colors.white
      ),
      highlightColor: AppColors.lightSecondaryColor,
      colorScheme: ColorScheme.light(
        secondary: AppColors.lightSecondaryColor
      )
    ),
    AppTheme.dark: ThemeData(
      backgroundColor: AppColors.darkThirdiaryColor,
      textTheme: TextTheme(
        headline1: TextStyle(
          color: AppColors.darkPrimaryColor,
          fontFamily: AppFontFamily.montserrat,
          fontSize: 24,
          fontWeight: FontWeight.normal
        ),
        headline2: TextStyle(
          color: AppColors.darkPrimaryColor,
          fontFamily: AppFontFamily.proximaNova,
          fontSize: 22,
          fontWeight: FontWeight.w500
        ),
        headline3: TextStyle(
          color: AppColors.darkFourthColor,
          fontSize: 16,
          fontFamily: AppFontFamily.proximaNova
        ),
        subtitle1: TextStyle(
          color: AppColors.darkThirdiaryColor,
          fontSize: 16,
          fontFamily: AppFontFamily.proximaNova,
          decoration: TextDecoration.underline
        ),
        subtitle2: TextStyle(
          color: AppColors.darkPrimaryColor,
          fontFamily: AppFontFamily.proximaNova,
          fontSize: 18,
          fontWeight: FontWeight.w400
        ),
        overline: TextStyle(
          color: AppColors.darkPrimaryColor,
          fontFamily: AppFontFamily.proximaNova,
          fontSize: 18,
          fontWeight: FontWeight.w700
        ),
        button: TextStyle(
          color: AppColors.darkSecondaryColor,
          fontFamily: AppFontFamily.proximaNova,
          fontSize: 18,
          wordSpacing: 2,
          letterSpacing: 1
        ),
      ),
      cardColor: AppColors.darkPrimaryColor.withOpacity(0.5),
      dividerColor: AppColors.darkPrimaryColor,
      splashColor: AppColors.darkPrimaryColor,
      indicatorColor: AppColors.darkSecondaryColor,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.darkPrimaryColor,
        foregroundColor: Colors.white
      ),
      highlightColor: AppColors.darkFifthColor,
      colorScheme: ColorScheme.dark(
        secondary: AppColors.darkPrimaryColor
      )
    )
  };
}

enum AppTheme {
  light,
  dark
}