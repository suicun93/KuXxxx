import 'dart:convert';

List<PetVaccine> petsFromJson(List list) =>
    list.map((x) => PetVaccine.fromJson(x)).toList();

String petsToJson(List<PetVaccine> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PetVaccine {
  final String? date;
  final String? bodyTemp;
  final String? weight;
  final String? vaccineType;
  final String? returnDate;
  final String? doctor;
  final String? location;

  PetVaccine(
      {this.date,
      this.bodyTemp,
      this.weight,
      this.vaccineType,
      this.returnDate,
      this.doctor,
      this.location});

  factory PetVaccine.fromJson(Map<String, dynamic> json) => PetVaccine(
        date: json["date"],
        bodyTemp: json["bodyTemp"],
        weight: json["weight"],
        vaccineType: json["vaccineType"],
        returnDate: json["returnDate"],
        doctor: json["doctor"],
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "bodyTemp": bodyTemp,
        "weight": weight,
        "vaccineType": vaccineType,
        "returnDate": returnDate,
        "doctor": doctor,
        "location": location,
      };
}
