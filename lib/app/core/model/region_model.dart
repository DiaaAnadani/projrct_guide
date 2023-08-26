import 'dart:convert';

import 'package:hive/hive.dart';
part 'region_model.g.dart';
@HiveType(typeId: 1)
class Region extends HiveObject{
   @HiveField(0)
  int id;
   @HiveField(1)
  String name;

  Region({
    required this.id,
    required this.name,
  });

  factory Region.fromJson(Map<String, dynamic> json) => Region(
    id: json["id"] ,
    name: json["name"],
  );

}
