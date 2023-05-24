import 'package:get/get.dart';

import '../controllers/forgot_password_input_new_controller.dart';

class ForgotPasswordInputNewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordInputNewController>(
      () => ForgotPasswordInputNewController(),
    );
  }
}
