import 'dart:convert';


class Street {
  int id;
  String name;

  Street({
    required this.id,
    required this.name,
  });

  factory Street.fromJson(Map<String, dynamic> json) => Street(
    id: json["id"] ,
    name: json["name"],
  );

}
