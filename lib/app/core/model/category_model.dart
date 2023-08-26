// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
    int id;
    String name;
    dynamic svg;

    CategoryModel({
        required this.id,
        required this.name,
        this.svg,
    });

    factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        name: json["name"],
        svg: json["svg"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "svg": svg,
    };
}
