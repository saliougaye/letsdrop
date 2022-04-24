part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  
  final ThemeData appTheme;
  
  const ThemeState({ required this.appTheme });
  
  @override
  List<Object> get props => [appTheme];
}
