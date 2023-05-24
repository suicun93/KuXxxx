import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../common/const.dart';
import '../../../routes/app_pages.dart';
import '../../register_verify_phone/controllers/register_verify_phone_controller.dart';

class RegisterVerifyInformationController extends GetxController {
  final hidePassword = true.obs;
  final registerByPhone = true.obs;
  final name = ''.obs;
  final phone = ''.obs;
  final email = ''.obs;
  final address = ''.obs;
  final password = ''.obs;
  final confirmPassword = ''.obs;
  final agreeWithTermAndCondition = false.obs;

  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  // Register type
  bool get registerEmail => registerByPhone.isFalse;

  bool get registerPhone => registerByPhone.isTrue;

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onReady() {
    super.onReady();
    final params = Get.parameters;
    registerByPhone.value =
        params[RegisterVerifyPhoneController.registerTypeKey] ==
            RegisterVerifyPhoneController.phoneKey;
    phoneController.text =
        params[RegisterVerifyPhoneController.phoneKey] ?? '';
    phone.value = phoneController.text.toString();
    emailController.text =
        params[RegisterVerifyPhoneController.emailKey] ?? '';
    email.value = emailController.text.toString();
  }

  @override
  void onClose() {}

  bool get validToSubmit =>
      name.value.isNotEmpty &&
      ((registerPhone && phone.value.isPhoneNumber) ||
          (registerEmail && email.value.isEmail)) &&
      password.value.isPassword == null &&
      confirmPassword.value.isNotEmpty &&
      password.value == confirmPassword.value &&
      agreeWithTermAndCondition.isTrue;

  VoidCallback? get submit => validToSubmit ? () => tiepTuc() : null;

  void tiepTuc() => Get.toNamed(
        Routes.REGISTER_VERIFY_OTP,
        parameters: {
          registerTypeKey: registerPhone ? phoneKey : emailKey,
          emailKey: email.value,
          phoneKey: phone.value,
          nameKey: name.value,
          addressKey: address.value,
          passwordKey: password.value,
        },
      );

  static const emailKey = 'email_key';
  static const phoneKey = 'phone_key';
  static const registerTypeKey = 'register_type_key';
  static const nameKey = 'name_key';
  static const addressKey = 'address_key';
  static const passwordKey = 'password_key';
}
