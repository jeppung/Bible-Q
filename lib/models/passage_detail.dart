import 'dart:convert';

PassageDetailResponse passageDetailFromJson(String str) => PassageDetailResponse.fromJson(json.decode(str));

String passageDetailToJson(PassageDetail data) => json.encode(data.toJson());

class PassageDetailResponse {
    PassageDetail data;

    PassageDetailResponse({
        required this.data,
    });

    factory PassageDetailResponse.fromJson(Map<String, dynamic> json) => PassageDetailResponse(
        data: PassageDetail.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
    };
}

class PassageDetail {
    Book book;
    List<Verse> verses;

    PassageDetail({required this.book, required this.verses});


    factory PassageDetail.fromJson(Map<String, dynamic> json) => PassageDetail(
        book: Book.fromJson(json["book"]),
        verses: List<Verse>.from(json["verses"].map((x) => Verse.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "book": book.toJson(),
        "verses": List<dynamic>.from(verses.map((x) => x.toJson())),
    };
}

class Book {
    int no;
    String name;
    int chapter;

    Book({
        required this.no,
        required this.name,
        required this.chapter,
    });

    factory Book.fromJson(Map<String, dynamic> json) => Book(
        no: json["no"],
        name: json["name"],
        chapter: json["chapter"],
    );

    Map<String, dynamic> toJson() => {
        "no": no,
        "name": name,
        "chapter": chapter,
    };
}

class Verse {
    int verse;
    String type;
    String content;

    Verse({
        required this.verse,
        required this.type,
        required this.content,
    });

    factory Verse.fromJson(Map<String, dynamic> json) => Verse(
        verse: json["verse"],
        type: json["type"],
        content: json["content"],
    );

    Map<String, dynamic> toJson() => {
        "verse": verse,
        "type": type,
        "content": content,
    };
}
