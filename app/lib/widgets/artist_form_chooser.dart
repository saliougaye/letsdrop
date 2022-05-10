import 'package:flutter/material.dart';
import 'package:letsdrop/models/spotify_artist.dart';
import 'package:letsdrop/utils/addVerticalSpace.dart';
import 'package:letsdrop/widgets/artist_select.dart';

class ArtistInput extends StatefulWidget {
  final Future<List<SpotifyArtist>> Function(String) fetchArtist;
  final void Function(SpotifyArtist?) onSaveArtist;

  const ArtistInput(
      {Key? key, required this.fetchArtist, required this.onSaveArtist})
      : super(key: key);

  @override
  State<ArtistInput> createState() => _ArtistInputState();
}

class _ArtistInputState extends State<ArtistInput> {
  final List<ArtistSelect> _artistsSelect = List.empty(growable: true);

  @override
  void initState() {
    setState(() {
      _artistsSelect.add(ArtistSelect(
        fetchArtist: widget.fetchArtist,
        index: 0,
        removeInput: _removeInput,
        onSave: widget.onSaveArtist,
      ));
    });

    super.initState();
  }

  _addArtist() {
    setState(() {
      _artistsSelect.add(ArtistSelect(
        fetchArtist: widget.fetchArtist,
        index: _artistsSelect.length,
        removeInput: _removeInput,
        onSave: widget.onSaveArtist,
      ));
    });
  }

  _removeInput(int index) {
    setState(() {
      _artistsSelect.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ..._artistsSelect.map((e) => Column(
            children: [e, addVerticalSpace(10)],
          )),
      addVerticalSpace(10),
      InkWell(
        onTap: () {
          _addArtist();
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.add_circle_outline_outlined,
              color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
            ),
            Text(
              'Add Artist',
              style: Theme.of(context).textTheme.headline2,
            ),
          ],
        ),
      ),
      addVerticalSpace(30),
    ]);
  }
}
