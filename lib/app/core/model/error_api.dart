// To parse this JSON data, do
//
//     final placeCommentsModel = placeCommentsModelFromJson(jsonString);

import 'dart:convert';

PlaceCommentsModel placeCommentsModelFromJson(String str) => PlaceCommentsModel.fromJson(json.decode(str));

String placeCommentsModelToJson(PlaceCommentsModel data) => json.encode(data.toJson());

class PlaceCommentsModel {
  String id;
  String content;
  String rate;
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
