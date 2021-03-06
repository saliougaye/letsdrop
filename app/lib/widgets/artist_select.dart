import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:letsdrop/constants/assets.dart';
import 'package:letsdrop/models/spotify_artist.dart';
import 'package:skeletons/skeletons.dart';

class ArtistSelect extends StatelessWidget {
  final int index;
  final Future<List<SpotifyArtist>> Function(String) fetchArtist;
  final void Function(int) removeInput;
  final void Function(SpotifyArtist?) onSave;

  const ArtistSelect(
      {Key? key,
      required this.fetchArtist,
      required this.index,
      required this.removeInput,
      required this.onSave})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Artist',
                  style: Theme.of(context).textTheme.overline,
                ),
              ),
              DropdownSearch<SpotifyArtist>(
                mode: Mode.BOTTOM_SHEET,
                dropdownSearchDecoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          BorderSide(color: Theme.of(context).cardColor)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          BorderSide(color: Theme.of(context).cardColor)),
                ),
                itemAsString: (item) => item?.name ?? "",
                onChanged: print,
                showSearchBox: true,
                showClearButton: true,
                showSelectedItems: true,
                compareFn: (item, selectedItem) {
                  return item?.id == selectedItem?.id;
                },
                dropdownBuilder: _artistDropdownItem,
                onFind: (text) async {
                  if (text == null || text == "") return [];

                  return fetchArtist(text);
                },
                isFilteredOnline: true,
                validator: (value) => index == 0 && value == null
                    ? "Please select at least one artist"
                    : null,
                onSaved: onSave,
              )
            ],
          ),
        ),
        (() {
          if (index != 0) {
            return IconButton(
              padding: const EdgeInsets.only(top: 15),
              onPressed: () {
                removeInput(index);
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
                size: 30,
              ),
            );
          }

          return const SizedBox(width: 45,);
        }())
      ],
    );
  }

  Widget _artistDropdownItem(BuildContext context, SpotifyArtist? item) {
    if (item == null) {
      return Container();
    }

    return Row(
      children: [
        Expanded(
          flex: 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              _getArtistImage(item),
              fit: BoxFit.fitHeight,
              scale: 0.8,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }

                return const Skeleton(
                    isLoading: true,
                    skeleton: SkeletonAvatar(),
                    child: SkeletonAvatar());
              },
            ),
          ),
        ),
        const SizedBox(width: 20,),
        Expanded(
          flex: 3,
          child: Text(item.name,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headline2),
        )
      ],
    );
  }

  String _getArtistImage(SpotifyArtist? artist) {
    return artist?.image ?? AppAssets.NoAlbumImage;
  }
}
