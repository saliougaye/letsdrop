import 'package:flutter/material.dart';
import 'package:letsdrop/constants/colors.dart';
import 'package:letsdrop/constants/font_family.dart';

class AppThemes {
  AppThemes._();

  static final appThemeData = {
    AppTheme.light: ThemeData(
      backgroundColor: AppColors.lightSeaGreen,
      textTheme: TextTheme(
        headline1: TextStyle(
          color: Colors.white,
          fontFamily: AppFontFamily.proximaNova,
          fontSize: 24,
          fontWeight: FontWeight.w400
        ),
        headline2: TextStyle(
          color: AppColors.darkGreenBlue,
          fontFamily: AppFontFamily.proximaNova,
          fontSize: 18
        ),
        headline3: TextStyle(
          color: AppColors.lightSeaGreen,
          fontSize: 16,
          fontFamily: AppFontFamily.proximaNova
        ),
        subtitle1: TextStyle(
          color: AppColors.skyGrey,
          fontSize: 14,
          fontFamily: AppFontFamily.proximaNova,
          decoration: TextDecoration.underline
        ),
        subtitle2: TextStyle(
          color: AppColors.darkGreenBlue,
          fontFamily: AppFontFamily.proximaNova,
          fontSize: 14
        ),
        overline: TextStyle(
          color: AppColors.darkGreenBlue,
          fontFamily: AppFontFamily.proximaNova,
          fontSize: 15
        )
      ),
      cardColor: AppColors.darkGreenBlue.withOpacity(0.5),
      dividerColor: AppColors.darkGreenBlue,
      splashColor: AppColors.darkGreenBlue,
      indicatorColor: AppColors.greenBlue
      
    ),
    AppTheme.dark: ThemeData(
      backgroundColor: AppColors.skyBlue,
      textTheme: TextTheme(
        headline1: TextStyle(
          color: Colors.white,
          fontFamily: AppFontFamily.proximaNova,
          fontSize: 24,
          fontWeight: FontWeight.w400
        ),
        headline2: TextStyle(
          color: AppColors.darkShadeBlueMagenta,
          fontFamily: AppFontFamily.proximaNova,
          fontSize: 18
        ),
        headline3: TextStyle(
          color: AppColors.skyBlue,
          fontSize: 16,
          fontFamily: AppFontFamily.proximaNova
        ),
        subtitle1: TextStyle(
          color: AppColors.skyViolet,
          fontSize: 14,
          fontFamily: AppFontFamily.proximaNova,
          decoration: TextDecoration.underline
        ),
        subtitle2: TextStyle(
          color: AppColors.darkShadeBlueMagenta,
          fontFamily: AppFontFamily.proximaNova,
          fontSize: 14
        ),
        overline: TextStyle(
          color: AppColors.darkShadeBlueMagenta,
          fontFamily: AppFontFamily.proximaNova,
          fontSize: 18,
        ),
      ),
      cardColor: AppColors.darkShadeBlueMagenta.withOpacity(0.5),
      dividerColor: AppColors.darkShadeBlueMagenta,
      splashColor: AppColors.darkShadeBlueMagenta, // TODO remove
      indicatorColor: AppColors.darkBlue,

    )
  };
}

enum AppTheme {
  light,
  dark
}