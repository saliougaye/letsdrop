
class Country {

    
    String name;
    String code;
    String flag;

    Country({
        required this.name,
        required this.code,
        required this.flag,
    });


    factory Country.fromJson(Map<String, dynamic> json) => Country(
        name: json["name"],
        code: json["code"],
        flag: json["flag"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
        "flag": flag,
    };
}
