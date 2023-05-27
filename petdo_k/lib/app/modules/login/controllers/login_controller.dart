import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../common/my_get_controller.dart';
import '../../../common/preferences.dart';
import '../../../constant.dart';
import '../../../routes/app_pages.dart';
import '../providers/login_provider.dart';

class LoginController extends MyGetxController<LoginProvider> {
  final loginByPhone = true.obs;
  final hidePassword = true.obs;
  final saveLogin = false.obs;
  final phoneNumber = ''.obs;
  final email = ''.obs;
  final password = ''.obs;
  final country = Rxn(
    CountryCode(
      name: "Việt Nam",
      code: "VN",
      dialCode: "+84",
      flagUri: 'flags/vn.png',
    ),
  );

  // Controller for editing text
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  bool get registerEmail => loginByPhone.isFalse;

  bool get registerPhone => loginByPhone.isTrue;

  @override
  Future<void> onInit() async {
    super.onInit();
    final saveLoginBefore = await Preference.getSaveLogin();
    if (saveLoginBefore) {
      phoneController.text = await Preference.getPhoneNumber();
      emailController.text = await Preference.getEmail();
      passwordController.text = await Preference.getPassword();
      phoneNumber.value = phoneController.text.toString();
      email.value = emailController.text.toString();
      password.value = passwordController.text.toString();
      saveLogin.value = true;
    }
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    ever<bool>(
      loginByPhone,
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

  bool get validToSubmit =>
      ((registerPhone &&
              country.value != null &&
              phoneNumber.value.isPhoneNumber) ||
          (registerEmail && email.value.isEmail)) &&
      password.value.isNotEmpty;

  bool get validToForgot =>
      (registerPhone &&
          country.value != null &&
          phoneNumber.value.isPhoneNumber) ||
      (registerEmail && email.value.isEmail);

  VoidCallback? get submit => validToSubmit ? () => login() : null;

  void login() async {
    if (saveLogin.isTrue) {
      await Preference.setPhoneNumber(
          phoneNumber.value.isPhoneNumber ? phoneNumber.value : '');
      await Preference.setEmail(email.value);
      await Preference.setPassword(password.value);
      await Preference.setSaveLogin(true);
    } else {
      await Preference.setPhoneNumber('');
      await Preference.setEmail('');
      await Preference.setPassword('');
      await Preference.setSaveLogin(false);
    }
    dbWelCome.doc(loginDocument).collection(emailCollection).where(email, isEqualTo: true).get().then((value) {
      for (final doc in value.docs) {
      }
    });
    Get.offAndToNamed(Routes.HOME);
  }

  forgotPass() => Get.toNamed(Routes.FORGOT_PASSWORD_INPUT_PHONE_MAIL);
}
