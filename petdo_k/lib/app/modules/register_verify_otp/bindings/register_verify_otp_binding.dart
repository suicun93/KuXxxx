import 'package:get/get.dart';

import '../controllers/register_verify_otp_controller.dart';
import '../providers/register_verify_otp_provider.dart';

class RegisterVerifyOtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterVerifyOtpController>(
      () => RegisterVerifyOtpController(),
    );
    Get.lazyPut<RegisterVerifyOtpProvider>(
      () => RegisterVerifyOtpProvider(),
    );
  }
}
