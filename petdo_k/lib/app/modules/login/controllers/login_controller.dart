import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../utils.dart';
import '../../../common/my_get_controller.dart';
import '../../../common/preferences.dart';
import '../../../routes/app_pages.dart';
import '../providers/login_provider.dart';

class LoginController extends MyGetxController<LoginProvider> {
  final loginByPhone = true.obs;
  final hidePassword = true.obs;
  final saveLogin = false.obs;
  final phoneNumber = ''.obs;
  final email = ''.obs;
  final password = ''.obs;
  final wrongPassword = false.obs;
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

  Future<bool> get submit => validToSubmit ? login() : Future.value(false);

  Future<bool> login() async {
    String? phone;
    if (saveLogin.isTrue) {
      await Preference.setSaveLogin(true);
      await Preference.setToken('save');
    } else {
      await Preference.setSaveLogin(false);
      await Preference.setToken('not save');
    }
    if(phoneNumber.value.isPhoneNumber && !phoneNumber.value.startsWith('0')) {
      phone = '0${phoneNumber.value}';
    }
    await Preference.setPhoneNumber(
        phoneNumber.value.isPhoneNumber ? (phone ?? phoneNumber.value) : '');
    await Preference.setEmail(email.value);
    await Preference.setPassword(password.value);
    final result = await dbWelCome
        .doc(loginDocument)
        .collection(
            phoneNumber.value.isPhoneNumber ? phoneCollection : emailCollection)
        .doc(phoneNumber.value.isPhoneNumber ? '+${phone ?? phoneNumber.value}' : email.value)
        .get();
    if (result.data()?[passwordField] == password.string) {
      return true;
    } else {
      wrongPassword.value = true;
      return false;
    }
  }

  forgotPass() => Get.toNamed(Routes.FORGOT_PASSWORD_INPUT_PHONE_MAIL);
}
