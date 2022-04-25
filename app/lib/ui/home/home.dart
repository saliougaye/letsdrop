import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letsdrop/blocs/theme/theme_bloc.dart';
import 'package:letsdrop/constants/theme.dart';
import 'package:letsdrop/widgets/drop_list.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
        builder: (themeContext, state) {
          return Scaffold(
            backgroundColor: Theme.of(themeContext).backgroundColor,
            appBar: AppBar(
              title: Text(
                "Good Morning User",
                style: Theme.of(themeContext).textTheme.headline1,
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    themeContext.read<ThemeBloc>().add(ThemeEvent(
                        appTheme: state.appTheme == AppTheme.light
                            ? AppTheme.dark
                            : AppTheme.light));
                  },
                  icon: Icon(state.appTheme == AppTheme.light
                      ? Icons.wb_sunny
                      : Icons.nights_stay),
                )
              ],
              backgroundColor: const Color(0x44000000),
              elevation: 0,
            ),
            body: Container(
              padding: const EdgeInsets.only(top: 20, right: 15, left: 15),
              child: const DropList(),
            ),
          );
        },
    );
  }
}
