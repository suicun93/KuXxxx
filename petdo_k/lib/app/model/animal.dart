import 'package:petdo_k/app/views/animal_item.dart';

class AnimalResponse {
  final String imageUrl;
  final String name;
  final String origin;
  final String temperament;

  AnimalResponse(this.imageUrl, this.name, this.origin, this.temperament);
}