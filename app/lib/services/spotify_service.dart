import 'dart:convert';

import 'package:letsdrop/constants/token.dart';
import 'package:letsdrop/models/spotify_artist.dart';
import 'package:letsdrop/models/user.dart';
import 'package:oauth2_client/oauth2_helper.dart';
import 'package:oauth2_client/spotify_oauth2_client.dart';

class SpotifyService {

  final SpotifyOAuth2Client client = SpotifyOAuth2Client(
      redirectUri: "com.example.letsdrop://oauth2redirect", 
      customUriScheme: "com.example.letsdrop"
  );
  late OAuth2Helper helper;

  SpotifyService() {
    helper = OAuth2Helper(
      client,
      grantType: OAuth2Helper.AUTHORIZATION_CODE,
      clientId: AppTokens.SpotifyClientId,
      clientSecret: AppTokens.SpotifyClientSecret,
      scopes: [ "user-read-private", "user-read-email"]
    );
  }

  Future<SpotifyUser> login() async{
    return getLoggedUser();
  
  }

  Future<SpotifyUser> getLoggedUser() async {
    final resp = await helper.get("https://api.spotify.com/v1/me");

    return SpotifyUser.fromSpotifyJson(jsonDecode(resp.body));
  }

  Future<SpotifyUser?> isLogged() async{

    final token = await helper.getTokenFromStorage();

    if(token == null || !token.isValid())  {
      return null;
    }


    return getLoggedUser();
  }

  Future<List<SpotifyArtist>> getArtists(String name) async {
    final resp = await helper.get("https://api.spotify.com/v1/search?type=artist&q=$name");

    final List<dynamic> items = jsonDecode(resp.body)['artists']['items'];

    final artists = items.map((e) => SpotifyArtist.fromSpotifyJson(e)).toList();

    return artists;

  }
}