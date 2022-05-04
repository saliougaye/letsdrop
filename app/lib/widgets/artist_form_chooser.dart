import 'package:flutter/material.dart';
import 'package:letsdrop/models/artist.dart';
import 'package:letsdrop/widgets/artist_select.dart';

class ArtistInput extends StatefulWidget {
  final Future<List<Artist>> Function(String) fetchArtist;

  const ArtistInput({Key? key, required this.fetchArtist}) : super(key: key);

  @override
  State<ArtistInput> createState() => _ArtistInputState();
}

class _ArtistInputState extends State<ArtistInput> {
  final List<ArtistSelect> _artistsSelect = List.empty(growable: true);

  @override
  void initState() {
    setState(() {
      _artistsSelect
          .add(ArtistSelect(fetchArtist: widget.fetchArtist, index: 0));
    });

    super.initState();
  }

  _addArtist() {
    setState(() {
      _artistsSelect.add(ArtistSelect(
        fetchArtist: widget.fetchArtist,
        index: _artistsSelect.length,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ..._artistsSelect,
        InkWell(
          onTap: () {
            _addArtist();
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.add_circle_outline_outlined,
                color: Colors.green,
              ),
              Text(
                'Add Artist',
                style: Theme.of(context).textTheme.headline2,
              ),
            ],
          ),
        )
      ],
    );
  }
}
