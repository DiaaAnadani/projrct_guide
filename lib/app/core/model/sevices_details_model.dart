class ServiceDetailsModel {
  int id;
  int placeId;
  String title;
  String content;
  List<Gallery> gallery;
  Place place;
  bool? saved;

  ServiceDetailsModel({
    required this.id,
    required this.placeId,
    required this.title,
    required this.content,
    required this.gallery,
    required this.place,
     this.saved,
  });

  factory ServiceDetailsModel.fromJson(Map<String, dynamic> json) => ServiceDetailsModel(
    id: json["id"],
    placeId: json["placeId"],
    title: json["title"],
    content: json["content"],
    saved: json["saved"],
    gallery: List<Gallery>.from(json["gallery"].map((x) => Gallery.fromJson(x))),
    place: Place.fromJson(json["place"]),
  );

  Map<String, dynamic> toJson() => {
    "id":id,
    "saved":saved,
    "placeId": placeId,
    "title": title,
    "content": content,
    "gallery": List<dynamic>.from(gallery.map((x) => x.toJson())),
    "place": place.toJson(),
  };
}

class Gallery {
  String url;

  Gallery({
    required this.url,
  });

  factory Gallery.fromJson(Map<String, dynamic> json) => Gallery(
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
  };
}

class Place {
  Links? links;

  Place({
    required this.links,
  });

  factory Place.fromJson(Map<String, dynamic> json) => Place(
    links:json["links"]!=null? Links.fromJson(json["links"]):null,
  );

  Map<String, dynamic> toJson() => {
    "links": links!.toJson(),
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
    facebook: json["facebook"]=="Null" ?  "https://www.facebook.com/i.t.Plus.Aleppo?mibextid=ZbWKwL":json["facebook"],
    whats: json["whats"]=="Null" ?  "956381149":json["whats"],
    instagram: json["instagram"]=="Null" ?  "https://www.instagram.com/reel/CtPbvVUIiyY/?igshid=NjZiM2M3MzIxNA==":json["instagram"],
  );

  Map<String, dynamic> toJson() => {
    "facebook": facebook,
    "whats": whats,
    "instagram": instagram,
  };
}
