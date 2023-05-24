import 'dart:ui';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../common/const.dart';

class ForgotPasswordInputNewController extends GetxController {
  final hidePassword = true.obs;
  final password = ''.obs;
  final confirmPassword = ''.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  // }
  //
  // @override
  // void onReady() {
  //   super.onReady();
  // }

  @override
  void onClose() {}

  bool get validToSubmit =>
      password.value.isPassword == null &&
      confirmPassword.value.isNotEmpty &&
      password.value == confirmPassword.value;

  VoidCallback? get submit => validToSubmit ? () => tiepTuc() : null;

  void tiepTuc() {
    Get.offAllNamed(Routes.FORGOT_PASSWORD_SUCCESS);
  }
}
