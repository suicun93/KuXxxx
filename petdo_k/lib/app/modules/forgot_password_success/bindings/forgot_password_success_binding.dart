import 'package:get/get.dart';

import '../controllers/forgot_password_success_controller.dart';

class ForgotPasswordSuccessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordSuccessController>(
      () => ForgotPasswordSuccessController(),
    );
  }
}
