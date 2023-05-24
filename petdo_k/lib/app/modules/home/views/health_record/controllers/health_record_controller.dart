import 'package:get/get.dart';

import '../../../../../common/preferences.dart';
import '../../../controllers/home_controller.dart';

class HealthRecordController extends GetxController {
  final token = RxnString();
  final ready = false.obs;
  final noPet = true.obs;
  final selectedImage = ''.obs;
  final selectedName = ''.obs;

  @override
  void onReady() async {
    super.onReady();
    // token.value = await Preference.getToken();
    Preference.getToken();
    token.value = 'abc';
    ready.value = false;
    Future.delayed(Duration(milliseconds: 1500), () => ready.value = true);
  }

  @override
  void onClose() {}

  void toDetail({required String image, required String name}) {
    selectedImage.value = image;
    selectedName.value = name;
    HomeController.instance.changeMainView(MainView.healthRecordDetail);
  }
}
