import 'package:get/get.dart';
import 'package:petdo_k/app/views/popup_service.dart';

import '../controllers/initial_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InitialController>(
      () => InitialController(),
    );
    Get.put(PopupService());
  }
}
