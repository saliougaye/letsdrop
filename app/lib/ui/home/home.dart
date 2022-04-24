import 'package:flutter/material.dart';
import 'package:letsdrop/models/artist.dart';
import 'package:letsdrop/models/country.dart';
import 'package:letsdrop/models/drop.dart';
import 'package:letsdrop/widgets/drop_list_item.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: DropItem(
            drop: Drop(
                id: "626470bdd75503294520811a",
                album: "Mr. Morale & The Big Steppers",
                dropDate: "2022-05-06",
                country:
                    Country(
                      name: "United States", 
                      code: "840", 
                      flag: "https://flagcdn.com/us.svg"
                    ),
                artists: [
                  Artist(
                    id: "2YZyLoL8N0Wb9xBt1NhZWg", 
                    name: "Kendrick Lamar", 
                    link: "https://open.spotify.com/artist/2YZyLoL8N0Wb9xBt1NhZWg",
                    image: "https://i.scdn.co/image/ab6761610000e5ebee29d711d7afd1e882486e1a",
                  )
                ])),
      ),
    );
  }
}
