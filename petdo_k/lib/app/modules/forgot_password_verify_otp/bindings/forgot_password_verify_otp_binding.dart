import 'package:get/get.dart';

import '../controllers/forgot_password_verify_otp_controller.dart';

class ForgotPasswordVerifyOtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordVerifyOtpController>(
      () => ForgotPasswordVerifyOtpController(),
    );
  }
}
