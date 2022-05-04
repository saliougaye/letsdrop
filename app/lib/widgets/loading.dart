import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letsdrop/blocs/theme/theme_bloc.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).indicatorColor,
          ),
        );
      },
    );
  }
}