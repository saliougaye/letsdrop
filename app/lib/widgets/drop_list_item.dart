import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:letsdrop/blocs/theme/theme_bloc.dart';
import 'package:letsdrop/constants/assets.dart';
import 'package:letsdrop/constants/colors.dart';
import 'package:letsdrop/models/drop.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:skeletons/skeletons.dart';
class DropItem extends StatelessWidget {
  final Drop drop;
  final parser = EmojiParser();
  DropItem({Key? key, required this.drop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (themeContext, state) {
        return Container(
          padding: const EdgeInsets.only(right: 15, left: 15, bottom: 18),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Theme.of(themeContext).cardColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // image
                    Container(
                      width: 65,
                      height: 65,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          _getAlbumImage(),
                          fit: BoxFit.fill,
                          scale: 0.8,
                          loadingBuilder: (context, child, loadingProgress) => const Skeleton(
                            isLoading: true,
                            skeleton: SkeletonAvatar(),
                            child: SkeletonAvatar(),
                          ),
                        ),
                      ),
                    ),

                    // album title and artists links
                    Container(
                        padding: const EdgeInsets.only(left: 10, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(drop.album,
                                style: Theme.of(themeContext).textTheme.headline3),
                            RichText(
                                text: TextSpan(
                                    children: drop.artists
                                        .map((e) => TextSpan(
                                            style: Theme.of(themeContext).textTheme.subtitle1,
                                            text: e.name,
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () => _onArtistTap(
                                                  context, e.link)))
                                        .toList()))
                          ],
                        )),
                    // flag
                    Text(
                      drop.country.flag,
                      style: TextStyle(fontSize: 30),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _onArtistTap(BuildContext context, String link) async {
    if (await canLaunchUrlString(link)) {
      await launchUrlString(link);
    } else {
      const snackBar = SnackBar(content: Text("Can't Launch Url"));

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  String _getAlbumImage() {
    final artistWithImage =
        drop.artists.where((element) => element.image != null).toList();

    if (artistWithImage.isEmpty) {
      return AppAssets.NoAlbumImage;
    }

    return artistWithImage[0].image!;
  }
}
