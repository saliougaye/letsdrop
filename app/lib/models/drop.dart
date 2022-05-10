import 'package:intl/intl.dart';
import 'package:letsdrop/models/country.dart';

import 'spotify_artist.dart';

class Drop {
    String id;
    String album;
    DateTime dropDate;
    Country country;
    List<SpotifyArtist> artists;


    
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
        dropDate: DateTime.parse(json["dropDate"]),
        country: Country.fromJson(json["country"]),
        artists: List<SpotifyArtist>.from(json["artists"].map((x) => SpotifyArtist.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "album": album,
        "dropDate": DateFormat("yyyy-MM-dd").format(dropDate),
        "country": country.toJson(),
        "artists": List<Map<String, dynamic>>.from(artists.map((x) => x.toJson())),
    };
}
