import 'package:flutter/material.dart';
import 'package:letsdrop/constants/colors.dart';

class AppThemes {
  AppThemes._();

  static final appThemeData = {
    AppTheme.light: ThemeData(
      backgroundColor: AppColors.lightSeaGreen,
      textTheme: const TextTheme(
        headline2: TextStyle(
          color: AppColors.darkGreenBlue
        ),
        headline3: TextStyle(
          color: AppColors.greenBlue
        ),
        subtitle1: TextStyle(
          color: AppColors.skyGrey
        ),

      ),
      dividerColor: AppColors.darkGreenBlue
    ),
    AppTheme.dark: ThemeData(
      backgroundColor: AppColors.skyBlue,
      textTheme: const TextTheme(
        headline2: TextStyle(
          color: AppColors.darkShadeBlueMagenta
        ),
        headline3: TextStyle(
          color: AppColors.darkBlue
        ),
        subtitle1: TextStyle(
          color: AppColors.skyViolet
        ),
      ),
      dividerColor: AppColors.darkShadeBlueMagenta
    )
  };
}

enum AppTheme {
  light,
  dark
}