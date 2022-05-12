class SpotifyUser {
  final String id;
  final String name;
  final String profileImage;
  

  SpotifyUser({ required this.id, required this.name, required  this.profileImage});


  factory SpotifyUser.fromSpotifyJson(Map<String, dynamic> json) => SpotifyUser(
    id: json['id'],
    name: json['display_name'], 
    profileImage: json['images'][0]['url']
  );



}