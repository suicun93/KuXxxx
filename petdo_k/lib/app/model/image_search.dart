// To parse this JSON data, do
//
//     final dogImageSearch = dogImageSearchFromJson(jsonString);

import 'dart:convert';

List<ImageSearch> imageSearchFromJson(List list) =>
    list.map((x) => ImageSearch.fromJson(x)).toList();

String imageSearchToJson(List<ImageSearch> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ImageSearch {
  final String id;
  final String url;
  final int width;
  final int height;

  ImageSearch({
    required this.id,
    required this.url,
    required this.width,
    required this.height,
  });

  factory ImageSearch.fromJson(Map<String, dynamic> json) => ImageSearch(
        id: json["id"],
        url: json["url"],
        width: json["width"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "width": width,
        "height": height,
      };
}
