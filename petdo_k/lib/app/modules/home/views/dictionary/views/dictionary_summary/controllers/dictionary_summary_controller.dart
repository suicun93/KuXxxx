import 'package:get/get.dart';
import 'package:petdo_k/app/model/cat_response.dart';
import 'package:petdo_k/app/model/dog_response.dart';
import 'package:petdo_k/app/model/image_search.dart';

import '../../../../../controllers/home_controller.dart';
import 'dictionary_summary_provider.dart';

class DictionarySummaryController extends GetxController {
  /// Selected drop box
  final dogResponse = DogResponse().obs;
  final catResponse = CatResponse().obs;
  final imageUrl = <ImageSearch>[].obs;
  final expanding = false.obs;

  final carouselIndex = 0.obs;
  final provider = Get.find<DictionarySummaryProvider>();

  @override
  void onReady() {
    super.onReady();
    imageUrl.clear();
    if (HomeController.instance.selectedDog != null) {
      dogResponse.value = HomeController.instance.selectedDog!;
      provider.getDogImages(dogResponse.value.id.toString()).then((value) {
        imageUrl.value = value.body?.take(3).toList() ?? [];
      });
    }
    if (HomeController.instance.selectedCat != null) {
      catResponse.value = HomeController.instance.selectedCat!;
      provider.getCatImages(catResponse.value.id.toString()).then((value) {
        imageUrl.value = value.body?.take(3).toList() ?? [];
      });
    }
  }

  @override
  void onClose() {}

  back() => HomeController.instance.back();
}
