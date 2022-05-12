import 'package:letsdrop/models/country.dart';
import 'package:letsdrop/models/spotify_artist.dart';

class DropInput {
    String id;
    String album;
    DateTime dropDate;
    Country country;
    List<SpotifyArtist> artists;
    
    DropInput({
        required this.id,
        required this.album,
        required this.dropDate,
        required this.country,
        required this.artists,
    });
}