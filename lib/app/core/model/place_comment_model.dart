// To parse this JSON data, do
//
//     final placeCommentsModel = placeCommentsModelFromJson(jsonString);

import 'dart:convert';



class PlaceCommentsModel {
  int id;
  String content;
  int rate;
  String fullName;

  PlaceCommentsModel({
    required this.id,
    required this.content,
    required this.rate,
    required this.fullName,
  });

  factory PlaceCommentsModel.fromJson(Map<String, dynamic> json) => PlaceCommentsModel(
    id: json["id"],
    content: json["content"],
    rate: json["rate"],
    fullName: json["fullName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "content": content,
    "rate": rate,
    "fullName": fullName,
  };
}
