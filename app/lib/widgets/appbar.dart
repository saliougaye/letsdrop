import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letsdrop/blocs/theme/theme_bloc.dart';
import 'package:letsdrop/constants/theme.dart';
import 'package:letsdrop/utils/addVerticalSpace.dart';

class Appbar extends StatelessWidget {
  final String name;
  final String? avatar;

  const Appbar({Key? key, required this.name, this.avatar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            (() {
              if(avatar != null) {
                return CircleAvatar(
                  backgroundImage: NetworkImage(
                    avatar!,
                  ),
                );
              }
              return const SizedBox.shrink();
            }()),
            Text(
              name,
              style: Theme.of(context).textTheme.headline1,
            ),
            IconButton(
              onPressed: () {
                context.read<ThemeBloc>().add(ThemeEvent(
                    appTheme: state.appTheme == AppTheme.light
                        ? AppTheme.dark
                        : AppTheme.light));
              },
              icon: Icon(
                state.appTheme == AppTheme.light
                  ? Icons.wb_sunny
                  : Icons.nights_stay,
                color: Theme.of(context).textTheme.headline1?.color!,
                size: Theme.of(context).textTheme.headline1?.fontSize!,
              ),
            )
          ],
        );
      },
    );
  }
}
