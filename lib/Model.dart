
class Modeldata {
  Modeldata({
    required this.id,
    required this.title,
    required this.description,
  });

  String id;
  String title;
  String description;

  factory Modeldata.fromJson(Map<String, dynamic> json) => Modeldata(
    id: json["_id"],
    title: json["title"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "description": description,
  };
}
