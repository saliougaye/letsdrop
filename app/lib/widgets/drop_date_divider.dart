import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:letsdrop/blocs/theme/theme_bloc.dart';
import 'package:letsdrop/utils/addVerticalSpace.dart';

class DropDateDivider extends StatelessWidget {
  final DateTime date;

  const DropDateDivider({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "${DateTime.now().difference(date).inDays.abs()} days left",
                      style: Theme.of(context).textTheme.headline2,
                    )
                  ],
                ),
                Column(
                  children: [
                    Text(
                      DateFormat(DateFormat.MONTH_WEEKDAY_DAY).format(date),
                      style: Theme.of(context).textTheme.subtitle2,
                    )
                  ],
                )
              ],
            ),
            Divider(
              color: Theme.of(context).dividerColor,
            ),
            addVerticalSpace(10)
          ],
        );
      },
    );
  }
}
