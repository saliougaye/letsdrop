class SpotifyUser {
  final String name;
  final String profileImage;

  SpotifyUser({ required this.name, required  this.profileImage});


  factory SpotifyUser.fromSpotifyJson(Map<String, dynamic> json) => SpotifyUser(
    name: json['display_name'], 
    profileImage: json['images'][0]['url']
  );



}