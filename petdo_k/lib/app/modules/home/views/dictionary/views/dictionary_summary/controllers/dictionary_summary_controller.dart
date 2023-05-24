import 'package:get/get.dart';

import '../../../../../controllers/home_controller.dart';
import '../../../controllers/dictionary_controller.dart';

class DictionarySummaryController extends GetxController {
  /// Selected drop box
  final image = ''.obs;
  final name = ''.obs;
  final expanding = false.obs;

  final carouselIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    image.value = HomeController.instance.selectedAnimalImage;
    name.value = HomeController.instance.selectedAnimalName;
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  @override
  void onClose() {}

  back() => HomeController.instance.back();
}
