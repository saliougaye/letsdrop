import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:letsdrop/blocs/countries/countries_bloc.dart';
import 'package:letsdrop/blocs/theme/theme_bloc.dart';
import 'package:letsdrop/constants/token.dart';
import 'package:letsdrop/models/artist.dart';
import 'package:letsdrop/models/country.dart';
import 'package:letsdrop/services/api_service.dart';
import 'package:letsdrop/widgets/text_divider.dart';

class AddDropForm extends StatelessWidget {
  final ApiService apiService = ApiService();

  AddDropForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Form(
            child: Column(
          children: [_albumField(context), _flagChooser(context)],
        ));
      },
    );
  }

  Widget _albumField(BuildContext themeContext) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Album Name',
                style: Theme.of(themeContext).textTheme.overline,
              ),
            ),
            Flexible(
              child: TextFormField(
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          BorderSide(color: Theme.of(themeContext).cardColor)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          BorderSide(color: Theme.of(themeContext).cardColor)),
                ),
                style: Theme.of(themeContext).textTheme.headline2,
                cursorColor: Theme.of(themeContext).splashColor,
              ),
            )
          ],
        )
      ],
    );
  }

  Widget _flagChooser(BuildContext themeContext) {
    return BlocBuilder<CountriesBloc, CountriesState>(
      builder: (context, state) {
        Widget field = state is CountriesLoaded
            ? (
               DropdownButtonFormField<Country>(
                    items: state.countries.map((e) {
                      return DropdownMenuItem<Country>(
                          child: Row(
                        children: [
                          Text(e.flag),
                          Text(e.name),
                        ],
                      ));
                    }).toList(),
                    onChanged: (value) {
                      print(value);
                    })
              )
            : (const CircularProgressIndicator());
        return Column(
          children: [
            Text(
                'Album Name',
                style: Theme.of(themeContext).textTheme.overline,
              ),
            field
          ],
        );
      },
    );
  }

  Widget _artistChooser() {
    return Column(
      children: [
        Text('Album'),
        TypeAheadFormField<Artist>(onSuggestionSelected: (selected) {
          print(selected);
        }, itemBuilder: (context, itemData) {
          return ListTile(
            title: Text(itemData.name),
          );
        }, suggestionsCallback: (value) {
          print(value);
          return apiService.getArtists(value, Token.token);
        })
      ],
    );
  }
}
