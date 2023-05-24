import 'package:get/get.dart';

import '../controllers/register_verify_phone_controller.dart';

class RegisterVerifyPhoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterVerifyPhoneController>(
      () => RegisterVerifyPhoneController(),
    );
  }
}
