import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letsdrop/blocs/theme/theme_bloc.dart';

class AlbumNameInput extends StatelessWidget {
  const AlbumNameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Album Name',
                    style: Theme.of(context).textTheme.overline,
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                            color: Theme.of(context).cardColor)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                            color: Theme.of(context).cardColor)),
                  ),
                  style: Theme.of(context).textTheme.headline2,
                  cursorColor: Theme.of(context).splashColor,
                )
              ],
            )
          ],
        );
      },
    );
  }
}
