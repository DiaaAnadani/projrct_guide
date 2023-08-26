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
