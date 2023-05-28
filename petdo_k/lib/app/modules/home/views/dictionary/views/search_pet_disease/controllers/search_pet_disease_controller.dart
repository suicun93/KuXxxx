import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../../../views/dropdown_list.dart';
import '../../../../../controllers/home_controller.dart';

class SearchPetDiseaseController extends GetxController {
  var searchTextEditingController = TextEditingController();

  final ready = true.obs;
  final searchText = ''.obs;
  final showMore = false.obs;

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
    // HomeController.instance.selectedDog = image;
    // HomeController.instance.selectedCat = name;
    HomeController.instance.changeMainView(MainView.dictionarySummary);
  }

  back() => HomeController.instance.back();
}
