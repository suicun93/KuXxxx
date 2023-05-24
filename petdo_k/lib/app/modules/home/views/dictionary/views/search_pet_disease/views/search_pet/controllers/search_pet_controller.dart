import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../../../../../views/dropdown_list.dart';
import '../../../../../../../controllers/home_controller.dart';

class SearchPetController extends GetxController {
  var searchTextEditingController = TextEditingController();

  List<DropboxItem> get animalType => [
        DropboxItem('c', 'Chó'),
        DropboxItem('m', 'Mèo'),
        DropboxItem('d', 'Cá sấu'),
        DropboxItem('e', 'Cá sấu'),
      ];

  List<DropboxItem> get moneyType => [
        DropboxItem('a', '100->200'),
        DropboxItem('b', '200->300'),
        DropboxItem('c', 'Free'),
      ];

  List<DropboxItem> get originalType => [
        DropboxItem('c', 'Đan Mạch'),
        DropboxItem('m', 'England'),
        DropboxItem('d', 'America'),
      ];

  /// Selected drop box
  final selectedType = Rxn<DropboxItem>();
  final selectedMoney = Rxn<DropboxItem>();
  final selectedOriginal = Rxn<DropboxItem>();

  final ready = true.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  // }
  //
  @override
  void onReady() async {
    super.onReady();
    ready.value = false;
    await Future.delayed(
      Duration(milliseconds: 2000),
      () => ready.value = true,
    );
  }

  @override
  void onClose() {}

  void toSummary({
    required String name,
    required String image,
  }) {
    HomeController.instance.selectedAnimalImage = image;
    HomeController.instance.selectedAnimalName = name;
    HomeController.instance.changeMainView(MainView.dictionarySummary);
  }

  back() => HomeController.instance.back();
}
