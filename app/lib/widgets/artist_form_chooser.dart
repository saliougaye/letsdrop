import 'package:flutter/material.dart';
import 'package:letsdrop/models/artist.dart';
import 'package:letsdrop/utils/addVerticalSpace.dart';
import 'package:letsdrop/widgets/artist_select.dart';

class ArtistInput extends StatefulWidget {
  final Future<List<Artist>> Function(String) fetchArtist;
  final void Function(Artist?) onSaveArtist;

  const ArtistInput({Key? key, required this.fetchArtist, required this.onSaveArtist}) : super(key: key);

  @override
  State<ArtistInput> createState() => _ArtistInputState();
}

class _ArtistInputState extends State<ArtistInput> {
  final List<ArtistSelect> _artistsSelect = List.empty(growable: true);
  

  @override
  void initState() {
    setState(() {
      _artistsSelect
          .add(ArtistSelect(fetchArtist: widget.fetchArtist, index: 0, removeInput: _removeInput, onSave: widget.onSaveArtist,));
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
    return Column(
      children: [
        ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: _artistsSelect.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                _artistsSelect[index],
                addVerticalSpace(10)
              ],
            );
          },
        ),
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
