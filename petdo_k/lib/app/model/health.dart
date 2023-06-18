import 'dart:convert';

List<PetHealth> petsFromJson(List list) =>
    list.map((x) => PetHealth.fromJson(x)).toList();

String petsToJson(List<PetHealth> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PetHealth {
  final String imageUrl;
  final String imageId;
  final String type;
  final String name;
  final String birthDay;
  final bool isMale;
  final bool isDog;
  final double weight;

  PetHealth(
      {required this.imageUrl,
      required this.imageId,
      required this.type,
      required this.name,
      required this.birthDay,
      required this.isMale,
      required this.isDog,
      required this.weight});

  factory PetHealth.fromJson(Map<String, dynamic> json) => PetHealth(
        imageUrl: json["imageUrl"],
        imageId: json["imageId"],
        type: json["type"],
        name: json["name"],
        birthDay: json["birthDay"],
        isMale: json["isMale"] ?? false,
        isDog: json["isDog"] ?? false,
        weight: json["weight"],
      );

  Map<String, dynamic> toJson() => {
        "imageUrl": imageUrl,
        "imageId": imageId,
        "type": type,
        "name": name,
        "birthDay": birthDay,
        "isMale": isMale,
        "isDog": isDog,
        "weight": weight,
      };
}
