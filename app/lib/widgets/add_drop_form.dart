import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:letsdrop/blocs/countries/countries_bloc.dart';
import 'package:letsdrop/blocs/theme/theme_bloc.dart';
import 'package:letsdrop/constants/token.dart';
import 'package:letsdrop/models/artist.dart';
import 'package:letsdrop/models/country.dart';
import 'package:letsdrop/services/api_service.dart';
import 'package:letsdrop/utils/addVerticalSpace.dart';
import 'package:letsdrop/widgets/album_name_input.dart';
import 'package:letsdrop/widgets/artist_form_chooser.dart';
import 'package:letsdrop/widgets/loading.dart';
import 'package:letsdrop/widgets/text_divider.dart';
import 'package:dropdown_search/dropdown_search.dart';

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
            addVerticalSpace(10),
            _flagChooser(context),
            addVerticalSpace(10),
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

              DropdownSearch<Country>(
                mode: Mode.BOTTOM_SHEET,
                items: state.countries,
                dropdownSearchDecoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                            color: Theme.of(themeContext).cardColor)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                            color: Theme.of(themeContext).cardColor)),
                  ),
                itemAsString: (item) => item?.name ?? "",
                onChanged: print,
                showSearchBox: true,
                showClearButton: true,
                showSelectedItems: true,
                compareFn: (item, selectedItem) {
                  return item?.name == selectedItem?.name;
                },
                selectedItem: state.countries[0],
                dropdownBuilder:_flagDropdownItem,
                
              )
              
              //  DropdownButtonFormField<Country>(
              //       items: state.countries.map((e) {
              //         return DropdownMenuItem<Country>(
              //             child: Row(
              //           children: [
              //             Text(e.flag ?? "no flag"),
              //             Text(e.name),
              //           ],
              //         ),
              //         value: e,
              //         );
              //       }).toList(),
              //       onChanged: (value) {
              //         print(value);
              //       })
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

  Widget _flagDropdownItem(BuildContext context, Country? item) {
    return Container(
      height: 38,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              item?.flag ?? "",
              style: const TextStyle(fontSize: 30),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              item?.name ?? "<>",
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headline2
            ),
          )
        ],
      ),
    );
  }
}
