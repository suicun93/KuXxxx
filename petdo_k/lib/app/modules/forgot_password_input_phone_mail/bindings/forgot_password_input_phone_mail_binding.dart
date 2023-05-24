import 'package:get/get.dart';

import '../controllers/forgot_password_input_phone_mail_controller.dart';

class ForgotPasswordInputPhoneMailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordInputPhoneMailController>(
      () => ForgotPasswordInputPhoneMailController(),
    );
  }
}
