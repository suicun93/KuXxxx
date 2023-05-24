import 'dart:ui';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class ForgotPasswordInputPhoneMailController extends GetxController {
  final input = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  bool get validToSubmit =>
      input.value.isNotEmpty &&
      (input.value.isPhoneNumber || input.value.isEmail);

  VoidCallback? get submit => validToSubmit ? () => forgotPass() : null;

  forgotPass() {
    Get.toNamed(
      Routes.FORGOT_PASSWORD_VERIFY_OTP,
      parameters: {
        registerTypeKey: emailKey,
        emailKey: input.value,
        phoneKey: input.value.isEmail ? input.value : 'duchoang191@gmail.com',
      },
    );
  }

  static const emailKey = 'email_key';
  static const phoneKey = 'phone_key';
  static const registerTypeKey = 'register_type_key';
}
