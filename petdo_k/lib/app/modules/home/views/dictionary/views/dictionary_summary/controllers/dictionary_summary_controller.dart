import 'package:get/get.dart';

import '../../../../../controllers/home_controller.dart';
import '../../../controllers/dictionary_controller.dart';
import 'dictionary_summary_provider.dart';

class DictionarySummaryController extends GetxController {
  /// Selected drop box
  final image = ''.obs;
  final name = ''.obs;
  final expanding = false.obs;

  final carouselIndex = 0.obs;
  final provider = Get.find<DictionarySummaryProvider>();

  @override
  void onReady() {
    super.onReady();
    image.value = HomeController.instance.selectedAnimalImage;
    name.value = HomeController.instance.selectedAnimalName;
    getCats();
  }

  @override
  void onClose() {}

  back() => HomeController.instance.back();

  void getCats() async{
    final response = await provider.getCats();
    print(response);
  }
}
