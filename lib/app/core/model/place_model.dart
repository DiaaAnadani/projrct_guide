
class PlaceModel {
  int id;
  int categoryId;
  int subCategoryId;
  String placeName;
  String phone;
  String details;
  String workTime;
  String image;
  String tags;
  Links? links;
  double latitud;
  double longitude;
  double rate;
  bool? saved;

  PlaceModel({
    required this.id,
    required this.categoryId,
    required this.subCategoryId,
    required this.placeName,
    required this.phone,
    required this.details,
    required this.workTime,
    required this.image,
    required this.tags,
    required this.links,
    required this.latitud,
    required this.longitude,
    required this.rate,
     this.saved,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) => PlaceModel(
    id: json["id"],
    categoryId: json["categoryId"],
    subCategoryId: json["subCategoryId"] ??0,
    placeName: json["placeName"],
    phone: json["phone"],
    details: json["details"] ?? "null",
    workTime: json["workTime"],
    image: json["image"]??"https://img.freepik.com/free-vector/large-school-building-scene_1308-32058.jpg",
    tags: json["tags"] ?? "null",
      links:json["links"]!=null? Links.fromJson(json["links"]):null,
    // links:json["links"]== null ? Links(
    //   facebook: "https://www.facebook.com/i.t.Plus.Aleppo?mibextid=ZbWKwL",
    //   whats: "956381149",
    //   instagram:"https://www.instagram.com/reel/CtPbvVUIiyY/?igshid=NjZiM2M3MzIxNA==",
    // ):
    // Links.fromJson(json["links"]),
    latitud: json["latitud"] ?? 36.2177138,
    longitude: json["longitude"] ?? 37.1268097,
    rate: json["rate"] ?? 0.0,
    saved: json["saved"],
  );


  Map<String, dynamic> toJson() => {
    "id": id,
    "categoryId": categoryId,
    "subCategoryId": subCategoryId,
    "placeName": placeName,
    "phone": phone,
    "details": details,
    "workTime": workTime,
    "image": image,
    "tags": tags,
    "links": links!.toJson(),
    "latitud": latitud,
    "longitude": longitude,
    "rate": rate,
    "saved": saved,
  };
}

class Links {
  String facebook;
  String whats;
  String instagram;

  Links({
    required this.facebook,
    required this.whats,
    required this.instagram,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
       facebook: json["facebook"],
      whats: json["whats"],
      instagram: json["instagram"],
   // facebook: json["facebook"]=="Null" ?  "https://www.facebook.com/i.t.Plus.Aleppo?mibextid=ZbWKwL":json["facebook"],
   // whats: json["whats"]=="Null" ?  "956381149":json["whats"],
   // instagram: json["instagram"]=="Null" ?  "https://www.instagram.com/reel/CtPbvVUIiyY/?igshid=NjZiM2M3MzIxNA==":json["instagram"],
  );
  

  Map<String, dynamic> toJson() => {
    "facebook": facebook,
    "whats": whats,
    "instagram": instagram,
  };
}


// // To parse this JSON data, do
// //
// //     final placeDetailsModel = placeDetailsModelFromJson(jsonString);

// import 'dart:convert';

// PlaceDetailsModel placeDetailsModelFromJson(String str) =>
//     PlaceDetailsModel.fromJson(json.decode(str));

// String placeDetailsModelToJson(PlaceDetailsModel data) =>
//     json.encode(data.toJson());

// class PlaceDetailsModel {
//   int id;
//   String placeName;
//   String phone;
//   String details;
//   String workTime;
//   String image;
//   String tags;
//   Links? links;
//   double latitud;
//   double longitude;
//   double rate;

//   PlaceDetailsModel({
//     required this.id,
//     required this.placeName,
//     required this.phone,
//     required this.details,
//     required this.workTime,
//     required this.image,
//     required this.tags,
//     required this.links,
//     required this.latitud,
//     required this.longitude,
//     required this.rate,
//   });

//   factory PlaceDetailsModel.fromJson(Map<String, dynamic> json) =>
//       PlaceDetailsModel(
//         id: json["id"],
//         placeName: json["placeName"],
//         phone: json["phone"],
//         details: json["details"] ?? "null",
//         workTime: json["workTime"],
//         image: json["image"]??"https://img.freepik.com/free-vector/large-school-building-scene_1308-32058.jpg",
//         tags: json["tags"] ?? "null",
//         // links: Links.fromJson(json["links"]),
//             links:json["links"]!=null? Links.fromJson(json["links"]):null,
//         latitud: json["latitud"] ?? 36.2077164,
//         longitude: json["longitude"] ?? 37.1268219,
//         rate: json["rate"] ?? 0.0,
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "placeName": placeName,
//         "phone": phone,
//         "details": details,
//         "workTime": workTime,
//         "image": image,
//         "tags": tags,
//         "links": links!.toJson(),
//         "latitud": latitud,
//         "longitude": longitude,
//         "rate": rate,
//       };
// }

// class Links {
//   String facebook;
//   String whats;
//   String instagram;

//   Links({
//     required this.facebook,
//     required this.whats,
//     required this.instagram,
//   });

  // factory Links.fromJson(Map<String, dynamic> json) => Links(
  //    facebook: json["facebook"],
  //     whats: json["whats"],
  //     instagram: json["instagram"],
  //       //facebook: json["facebook"]=="Null" ?  "https://www.facebook.com/i.t.Plus.Aleppo?mibextid=ZbWKwL":json["facebook"],
  //       //whats: json["whats"]=="Null" ?  "956381149":json["whats"],
  //     //  instagram: json["instagram"]=="Null" ?  "https://www.instagram.com/reel/CtPbvVUIiyY/?igshid=NjZiM2M3MzIxNA==":json["instagram"],
  //     );

//   Map<String, dynamic> toJson() => {
//         "facebook": facebook,
//         "whats": whats,
//         "instagram": instagram,
//       };
// }

