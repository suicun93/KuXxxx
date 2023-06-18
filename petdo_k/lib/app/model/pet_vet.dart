import 'dart:convert';

List<PetVet> petsFromJson(List list) =>
    list.map((x) => PetVet.fromJson(x)).toList();

String petsToJson(List<PetVet> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PetVet {
  final String? date;
  final String? bodyTemp;
  final String? weight;
  final String? symptom;
  final String? illness;
  final String? drug;
  final String? returnDate;
  final String? doctor;
  final String? phone;
  final String? location;

  PetVet(
      {this.date,
      this.bodyTemp,
      this.weight,
      this.symptom,
      this.illness,
      this.drug,
      this.returnDate,
      this.doctor,
      this.phone,
      this.location});

  factory PetVet.fromJson(Map<String, dynamic> json) => PetVet(
        date: json["date"],
        bodyTemp: json["bodyTemp"],
        weight: json["weight"],
        symptom: json["symptom"],
        illness: json["illness"],
        drug: json["drug"],
        returnDate: json["returnDate"],
        doctor: json["doctor"],
        phone: json["phone"],
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "bodyTemp": bodyTemp,
        "weight": weight,
        "symptom": symptom,
        "illness": illness,
        "drug": drug,
        "returnDate": returnDate,
        "doctor": doctor,
        "phone": phone,
        "location": location,
      };
}
