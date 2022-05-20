// To parse this JSON data, do
//
//     final cart = cartFromJson(jsonString);

import 'dart:convert';

List<Cart> cartFromJson(String str) => List<Cart>.from(json.decode(str).map((x) => Cart.fromJson(x)));

String cartToJson(List<Cart> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Cart {
    Cart({
        required this.id,
        required this.noteid,
        required this.item,
        required this.status,
    });

    int id;
    int noteid;
    String item;
    int status;

    factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["id"],
        noteid: json["noteid"],
        item: json["item"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "noteid": noteid,
        "item": item,
        "status": status,
    };
}
