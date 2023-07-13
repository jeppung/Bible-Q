import 'dart:convert';

PassageResponse passageResponseFromJson(String str) => PassageResponse.fromJson(json.decode(str));

String passageResponseToJson(Passage data) => json.encode(data.toJson());

class PassageResponse {
    List<Passage> data;

    PassageResponse({
        required this.data,
    });

    factory PassageResponse.fromJson(Map<String, dynamic> json) => PassageResponse(
        data: List<Passage>.from(json["data"].map((x) => Passage.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Passage {
    int no;
    String abbr;
    String name;
    int chapter;

    Passage({
        required this.no,
        required this.abbr,
        required this.name,
        required this.chapter,
    });

    factory Passage.fromJson(Map<String, dynamic> json) => Passage(
        no: json["no"],
        abbr: json["abbr"],
        name: json["name"],
        chapter: json["chapter"],
    );

    Map<String, dynamic> toJson() => {
        "no": no,
        "abbr": abbr,
        "name": name,
        "chapter": chapter,
    };
}
