class SpotifyArtist {
    
    String id;
    String name;
    String? image;
    String link;

    
    SpotifyArtist({
        required this.id,
        required this.name,
        this.image,
        required this.link,
    });


    factory SpotifyArtist.fromSpotifyJson(Map<String, dynamic> json) => SpotifyArtist(
        id: json["id"],
        name: json["name"],
        image: json["images"].length != 0 ?  json["images"][0]['url'] : null,
        link: json["external_urls"]["spotify"],
    );

    factory SpotifyArtist.fromJson(Map<String, dynamic> json) => SpotifyArtist(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        link: json["link"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "link": link,
    };
}