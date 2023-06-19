import 'package:get/get.dart';

import '../../../views/popup_service.dart';

class WelcomeController extends GetxController {
  final popUpService = Get.find<PopupService>();

  @override
  void onReady() {
    super.onReady();
    popUpService.init();
  }

  @override
  void onClose() {}
}
