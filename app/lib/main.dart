import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letsdrop/blocs/countries/countries_bloc.dart';
import 'package:letsdrop/blocs/drops/drops_bloc.dart';
import 'package:letsdrop/blocs/theme/theme_bloc.dart';
import 'package:letsdrop/constants/theme.dart';
import 'package:letsdrop/services/api_service.dart';
import 'package:letsdrop/ui/home/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeBloc()
        ),
        BlocProvider(
          create: (context) => DropsBloc(apiService: apiService)..add(LoadDrops())
        )
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (BuildContext context, ThemeState state) {
          return MaterialApp(
            title: 'LetsDrop',
            theme: state.appThemeData,
            home: const Home(),
            debugShowCheckedModeBanner: false,
          );
        }
      ),
    );
  }
}
