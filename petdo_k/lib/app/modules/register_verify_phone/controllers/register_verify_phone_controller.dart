import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../common/const.dart';
import '../../../routes/app_pages.dart';

class RegisterVerifyPhoneController extends GetxController {
  final phoneNumber = ''.obs;
  final email = ''.obs;
  final country = Rxn(
    CountryCode(
      name: "Việt Nam",
      code: "VN",
      dialCode: "+84",
      flagUri: 'flags/vn.png',
    ),
  );

  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  /// Toggle
  final registerByPhone = true.obs;

  bool get registerEmail => registerByPhone.isFalse;

  bool get registerPhone => registerByPhone.isTrue;

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onReady() {
    super.onReady();
    ever<bool>(
      registerByPhone,
      (regByPhone) {
        if (regByPhone) {
          phoneController.text = phoneNumber.value;
        } else {
          emailController.text = email.value;
        }
      },
    );
  }

  @override
  void onClose() {}

  bool get validToContinue =>
      (registerPhone &&
          country.value != null &&
          phoneNumber.value.isPhoneNumber) ||
      (registerEmail && email.value.isEmail);

  VoidCallback? get submit => validToContinue ? () => tiepTuc() : null;

  void tiepTuc() => Get.toNamed(
        Routes.REGISTER_VERIFY_INFORMATION,
        parameters: {
          registerTypeKey: registerPhone ? phoneKey : emailKey,
          emailKey: email.value,
          phoneKey: '${country.value?.dialCode}${phoneNumber.value.remove0}',
        },
      );

  static const emailKey = 'email';
  static const phoneKey = 'phone';
  static const registerTypeKey = 'REGISTER_BY_PHONE';
}
