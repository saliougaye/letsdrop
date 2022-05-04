class Artist {
    
    String id;
    String name;
    String? image;
    String link;

    
    Artist({
        required this.id,
        required this.name,
        this.image,
        required this.link,
    });


    factory Artist.fromJson(Map<String, dynamic> json) => Artist(
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