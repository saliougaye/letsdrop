import 'package:letsdrop/models/country.dart';

import 'artist.dart';

class Drop {
    String id;
    String album;
    String dropDate;
    Country country;
    List<Artist> artists;


    
    Drop({
        required this.id,
        required this.album,
        required this.dropDate,
        required this.country,
        required this.artists,
    });

    

    factory Drop.fromJson(Map<String, dynamic> json) => Drop(
        id: json["id"],
        album: json["album"],
        dropDate: json["dropDate"],
        country: Country.fromJson(json["state"]),
        artists: List<Artist>.from(json["artists"].map((x) => Artist.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "album": album,
        "dropDate": dropDate,
        "state": country.toJson(),
        "artists": List<dynamic>.from(artists.map((x) => x.toJson())),
    };
}
