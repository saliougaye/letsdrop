import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:letsdrop/blocs/countries/countries_bloc.dart';
import 'package:letsdrop/blocs/theme/theme_bloc.dart';
import 'package:letsdrop/constants/token.dart';
import 'package:letsdrop/models/spotify_artist.dart';
import 'package:letsdrop/models/country.dart';
import 'package:letsdrop/services/api_service.dart';
import 'package:letsdrop/services/spotify_service.dart';
import 'package:letsdrop/utils/addVerticalSpace.dart';
import 'package:letsdrop/widgets/album_name_input.dart';
import 'package:letsdrop/widgets/artist_form_chooser.dart';
import 'package:letsdrop/widgets/date_input.dart';
import 'package:letsdrop/widgets/flag_input.dart';
import 'package:letsdrop/widgets/loading.dart';
import 'package:letsdrop/widgets/text_divider.dart';
import 'package:dropdown_search/dropdown_search.dart';

class AddDropForm extends StatefulWidget {

  final void Function(Country?) onSaveCountry;
  final void Function(String?) onSaveAlbumName;
  final void Function(SpotifyArtist?) onSaveArtist;
  final void Function(DateTime?) onSaveDate;

  const AddDropForm({
    Key? key, 
    required this.onSaveCountry, 
    required this.onSaveAlbumName,
    required this.onSaveArtist,
    required this.onSaveDate
  }) : super(key: key);

  @override
  State<AddDropForm> createState() => _AddDropFormState();
}

class _AddDropFormState extends State<AddDropForm> {
  final SpotifyService apiService = SpotifyService();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Column(
          children: [
        AlbumNameInput(onSave: widget.onSaveAlbumName,),
        addVerticalSpace(10),
        FlagInput(onSaveCountry: widget.onSaveCountry),
        addVerticalSpace(10),
        DateInput(label: "Drop date", onSave: widget.onSaveDate,),
        addVerticalSpace(10),
        ArtistInput(
          fetchArtist: _fetchArtist,
          onSaveArtist: widget.onSaveArtist,
        )
          ],
        );
      },
    );
  }

  Future<List<SpotifyArtist>> _fetchArtist(String value) {
    return apiService.getArtists(value);
  }


}
