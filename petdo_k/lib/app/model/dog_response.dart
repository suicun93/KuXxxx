// To parse this JSON data, do
//
//     final dogsResponse = dogsResponseFromJson(jsonString);

import 'dart:convert';

List<DogsResponse> dogsResponseFromJson(List list) => list.map((x) => DogsResponse.fromJson(x)).toList();

String dogsResponseToJson(List<DogsResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DogsResponse {
  Eight? weight;
  Eight? height;
  int? id;
  String? name;
  String? bredFor;
  String? breedGroup;
  String? lifeSpan;
  String? temperament;
  String? origin;
  String? referenceImageId;
  Image? image;
  String? countryCode;
  String? description;
  String? history;

  DogsResponse({
    this.weight,
    this.height,
    this.id,
    this.name,
    this.bredFor,
    this.breedGroup,
    this.lifeSpan,
    this.temperament,
    this.origin,
    this.referenceImageId,
    this.image,
    this.countryCode,
    this.description,
    this.history,
  });

  factory DogsResponse.fromJson(Map<String, dynamic> json) => DogsResponse(
    weight: json["weight"] == null ? null : Eight.fromJson(json["weight"]),
    height: json["height"] == null ? null : Eight.fromJson(json["height"]),
    id: json["id"],
    name: json["name"],
    bredFor: json["bred_for"],
    breedGroup: json["breed_group"],
    lifeSpan: json["life_span"],
    temperament: json["temperament"],
    origin: json["origin"],
    referenceImageId: json["reference_image_id"],
    image: json["image"] == null ? null : Image.fromJson(json["image"]),
    countryCode: json["country_code"],
    description: json["description"],
    history: json["history"],
  );

  Map<String, dynamic> toJson() => {
    "weight": weight?.toJson(),
    "height": height?.toJson(),
    "id": id,
    "name": name,
    "bred_for": bredFor,
    "breed_group": breedGroup,
    "life_span": lifeSpan,
    "temperament": temperament,
    "origin": origin,
    "reference_image_id": referenceImageId,
    "image": image?.toJson(),
    "country_code": countryCode,
    "description": description,
    "history": history,
  };
}

class Eight {
  String? imperial;
  String? metric;

  Eight({
    this.imperial,
    this.metric,
  });

  factory Eight.fromJson(Map<String, dynamic> json) => Eight(
    imperial: json["imperial"],
    metric: json["metric"],
  );

  Map<String, dynamic> toJson() => {
    "imperial": imperial,
    "metric": metric,
  };
}

class Image {
  String? id;
  int? width;
  int? height;
  String? url;

  Image({
    this.id,
    this.width,
    this.height,
    this.url,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    id: json["id"],
    width: json["width"],
    height: json["height"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "width": width,
    "height": height,
    "url": url,
  };
}
