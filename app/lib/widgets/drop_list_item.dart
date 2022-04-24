import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:letsdrop/models/drop.dart';

class DropItem extends StatelessWidget {
  final Drop drop;

  const DropItem({Key? key, required this.drop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          // image
          SizedBox(
            width: 50,
            height: 50,
            child: Image.network(
              "https://randomuser.me/api/portraits/men/31.jpg",
            ),
          ),

          // album title and artists links
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  drop.album,
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              RichText(
                text: TextSpan(
                  children: drop.artists.map((e) => TextSpan(
                    style: Theme.of(context).textTheme.subtitle1,
                    text: e.name,
                    recognizer: TapGestureRecognizer()..onTap = () => _onArtistTap(e.link)
                  )).toList()
                )
              )
            ],
          ),
          // flag
          SizedBox(
            width: 50,
            height: 50,
            child: Image.network(
              drop.country.flag
            ),
          )
        ],
      ),
    );
  }

  void _onArtistTap(String link) {
    print(link);
  }
}
