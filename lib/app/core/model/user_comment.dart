// To parse this JSON data, do
//
//     final userCommentModel = userCommentModelFromJson(jsonString);

import 'dart:convert';

UserCommentModel userCommentModelFromJson(String str) => UserCommentModel.fromJson(json.decode(str));

String userCommentModelToJson(UserCommentModel data) => json.encode(data.toJson());

class UserCommentModel {
  int id;
  int placeId;
  String content;
  int rate;
  String placeName;
  String details;
  String image;

  UserCommentModel({
    required this.id,
    required this.placeId,
    required this.content,
    required this.rate,
    required this.placeName,
    required this.details,
    required this.image,
  });

  factory UserCommentModel.fromJson(Map<String, dynamic> json) => UserCommentModel(
    id: json["id"],
    placeId: json["placeId"],
    content: json["content"],
    rate: json["rate"],
    placeName: json["placeName"],
    details: json["details"]??"stand",
    image: json["image"]??"https://img.freepik.com/free-vector/large-school-building-scene_1308-32058.jpg",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "placeId": placeId,
    "content": content,
    "rate": rate,
    "placeName": placeName,
    "details": details,
    "image": image,
  };
}
