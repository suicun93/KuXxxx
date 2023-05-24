import 'package:get/get.dart';

import '../controllers/register_verify_information_controller.dart';

class RegisterVerifyInformationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterVerifyInformationController>(
      () => RegisterVerifyInformationController(),
    );
  }
}
