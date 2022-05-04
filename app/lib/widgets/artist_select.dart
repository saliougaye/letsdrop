import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:letsdrop/blocs/theme/theme_bloc.dart';
import 'package:letsdrop/constants/token.dart';
import 'package:letsdrop/models/artist.dart';
import 'package:letsdrop/utils/addVerticalSpace.dart';

class ArtistSelect extends StatelessWidget {
  final int index;
  final Future<List<Artist>> Function(String) fetchArtist;
  final void Function(int) removeInput;

  const ArtistSelect(
      {Key? key,
      required this.fetchArtist,
      required this.index,
      required this.removeInput
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Artist',
                    style: Theme.of(context).textTheme.overline,
                  ),
                  TypeAheadFormField<Artist>(
                    onSuggestionSelected: (selected) {},
                    itemBuilder: (context, itemData) {
                      return ListTile(
                        title: Text(itemData.name),
                      );
                    },
                    suggestionsCallback: (value) {
                      return fetchArtist(value);
                    },
                    textFieldConfiguration: TextFieldConfiguration(
                      style: Theme.of(context).textTheme.headline2,
                      cursorColor: Theme.of(context).splashColor,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                BorderSide(color: Theme.of(context).cardColor)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                BorderSide(color: Theme.of(context).cardColor)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            (() {
              if(index != 0) {
                return IconButton(
                  onPressed: () {
                    removeInput(index);
                  }, 
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  )
                );
              }

              return addVerticalSpace(0);
            }())
            
          ],
        );
      },
    );
  }
}
