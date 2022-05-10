import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:letsdrop/blocs/theme/theme_bloc.dart';
import 'package:letsdrop/constants/assets.dart';
import 'package:letsdrop/constants/token.dart';
import 'package:letsdrop/models/spotify_artist.dart';
import 'package:letsdrop/utils/addVerticalSpace.dart';
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
      required this.onSave
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Artist',
                    style: Theme.of(context).textTheme.overline,
                  ),
                  DropdownSearch<SpotifyArtist>(
                    mode: Mode.BOTTOM_SHEET,
                    dropdownSearchDecoration: InputDecoration(
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
                    validator: (value) => index == 0 && value == null ? "Please select at least one artist" : null,
                    onSaved: onSave,
                  )
                ],
              ),
            ),
            (() {
              if (index != 0) {
                return IconButton(
                    onPressed: () {
                      removeInput(index);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 40,
                    ),
                    );
              }

              return addVerticalSpace(0);
            }())
          ],
        );
      },
    );
  }

  Widget _artistDropdownItem(BuildContext context, SpotifyArtist? item) {

    if(item == null) {
      return Container();
    }

    return Container(
      height: 38,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  _getArtistImage(item),
                  fit: BoxFit.fill,
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
          const Spacer(flex: 1,),
          Expanded(
            flex: 4,
            child: Text(
              item.name,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headline2
            ),
          )
        ],
      ),
    );
  }

  String _getArtistImage(SpotifyArtist? artist) {

    return artist?.image ?? AppAssets.NoAlbumImage;

  }
}
