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
        id: json["_id"],
        album: json["album"],
        dropDate: json["dropDate"],
        country: Country.fromJson(json["country"]),
        artists: List<Artist>.from(json["artists"].map((x) => Artist.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "album": album,
        "dropDate": dropDate,
        "country": country.toJson(),
        "artists": List<dynamic>.from(artists.map((x) => x.toJson())),
    };
}
