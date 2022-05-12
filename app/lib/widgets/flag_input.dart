import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letsdrop/blocs/countries/countries_bloc.dart';
import 'package:letsdrop/models/country.dart';
import 'package:letsdrop/widgets/loading.dart';

class FlagInput extends StatelessWidget {

  final void Function(Country?) onSaveCountry;

  const FlagInput({Key? key, required this.onSaveCountry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CountriesBloc, CountriesState>(
      builder: (context, state) {
        Widget field = state is CountriesLoaded
            ? (

              DropdownSearch<Country>(
                mode: Mode.BOTTOM_SHEET,
                items: state.countries,
                dropdownSearchDecoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 10, right: 10),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                            color: Theme.of(context).cardColor)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                            color: Theme.of(context).cardColor)),
                  ),
                itemAsString: (item) => item?.name ?? "",
                onChanged: print,
                showSearchBox: true,
                showSelectedItems: true,
                compareFn: (item, selectedItem) {
                  return item?.name == selectedItem?.name;
                },
                dropdownBuilder:_flagDropdownItem,
                validator: (value) => value == null ? "Please select a country" : null,
                onSaved: onSaveCountry,
              )
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
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                  'Country',
                  style: Theme.of(context).textTheme.overline,
                ),
            ),
            field
          ],
        );
      },
    );
  }

  Widget _flagDropdownItem(BuildContext context, Country? item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            item?.flag ?? "",
            style: Theme.of(context).textTheme.headline2?.copyWith(fontSize: 25),
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(
            item?.name ?? "",
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headline2
          ),
        )
      ],
    );
  }
}