import 'package:get/get.dart';

import '../../../../../../../controllers/home_controller.dart';

class SearchDiseaseController extends GetxController {
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
    // HomeController.instance.selectedDog = image;
    // HomeController.instance.selectedCat = name;
    HomeController.instance.changeMainView(MainView.dictionarySummary);
  }

  back() => HomeController.instance.back();
}
