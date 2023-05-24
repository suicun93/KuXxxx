import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../forgot_password_input_phone_mail/controllers/forgot_password_input_phone_mail_controller.dart';

class ForgotPasswordVerifyOtpController extends GetxController {
  final loginByPhone = true.obs;
  final phone = ''.obs;
  final email = ''.obs;
  final code = ''.obs;

  @override
  void onInit() {
    super.onInit();
    final params = Get.parameters;
    loginByPhone.value =
        params[ForgotPasswordInputPhoneMailController.registerTypeKey] ==
            ForgotPasswordInputPhoneMailController.phoneKey;
    phone.value = params[ForgotPasswordInputPhoneMailController.phoneKey] ?? '';
    email.value = params[ForgotPasswordInputPhoneMailController.emailKey] ?? '';
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  @override
  void onClose() {}

  confirmCode() {
    // Call API
    Get.toNamed(Routes.FORGOT_PASSWORD_INPUT_NEW);
  }
}
