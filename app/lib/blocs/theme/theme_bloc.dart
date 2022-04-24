import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:letsdrop/constants/theme.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(
      ThemeState(
        appTheme: AppThemes.appThemeData[AppTheme.light]!
  )) {
    on<ThemeEvent>((event, emit) {
      emit(
        ThemeState(appTheme: AppThemes.appThemeData[event.appTheme]!)
      );
    });
  }
}
