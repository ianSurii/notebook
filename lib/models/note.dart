// To parse this JSON data, do
//
//     final note = noteFromJson(jsonString);

import 'dart:convert';

List<Note> noteFromJson(String str) =>
    List<Note>.from(json.decode(str).map((x) => Note.fromJson(x)));

String noteToJson(List<Note> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Note {
  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.type,
  });

  int? id;
  String? title;
  String? content;
  String? date;
  int? type;
  
   Note.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    this.title = map["title"];
    this.content = map["content"];
    this.date = map["date"];
    this.type = map["type"];
  }

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        date: json["date"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "date": date,
        "type": type,
      };

  //to map
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["id"] = id;
    map["title"] = title;
    map["content"] = content;
    map["date"] = date;
    map["type"] = type;
    return map;
  }
  //from map
 
}
