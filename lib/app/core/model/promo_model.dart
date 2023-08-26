// To parse this JSON data, do
//
//     final promoModel = promoModelFromJson(jsonString);

import 'dart:convert';

PromoModel promoModelFromJson(String str) => PromoModel.fromJson(json.decode(str));

String promoModelToJson(PromoModel data) => json.encode(data.toJson());

class PromoModel {
  String url;
  int placeId;

  PromoModel({
    required this.url,
    required this.placeId,
  });

  factory PromoModel.fromJson(Map<String, dynamic> json) => PromoModel(
    url: json["url"],
    placeId: json["placeId"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "placeId": placeId,
  };
}
