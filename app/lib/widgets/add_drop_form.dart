import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:letsdrop/blocs/countries/countries_bloc.dart';
import 'package:letsdrop/blocs/theme/theme_bloc.dart';
import 'package:letsdrop/constants/token.dart';
import 'package:letsdrop/models/artist.dart';
import 'package:letsdrop/models/country.dart';
import 'package:letsdrop/services/api_service.dart';
import 'package:letsdrop/widgets/album_name_input.dart';
import 'package:letsdrop/widgets/artist_form_chooser.dart';
import 'package:letsdrop/widgets/loading.dart';
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
          children: [
            const AlbumNameInput(),
            const SizedBox(
              height: 20,
            ),
            ArtistInput(fetchArtist: _fetchArtist)
             //_flagChooser(context)
          ],
        ));
      },
    );
  }

  Future<List<Artist>> _fetchArtist(String value) {
    return apiService.getArtists(value, Token.token);
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
            : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Loading()
              ],
            );
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Country',
                style: Theme.of(themeContext).textTheme.overline,
              ),
            field
          ],
        );
      },
    );
  }
}
