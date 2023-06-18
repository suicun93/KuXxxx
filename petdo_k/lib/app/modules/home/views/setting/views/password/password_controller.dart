import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:petdo_k/app/common/const.dart';
import 'package:petdo_k/app/common/preferences.dart';
import 'package:petdo_k/generated/locales.g.dart';
import 'package:petdo_k/utils.dart';

import '../../../../controllers/home_controller.dart';

class PasswordController extends GetxController {
  final hidePassword = true.obs;
  final password = ''.obs;
  final newPassword = ''.obs;
  final confirmPassword = ''.obs;

  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  bool get validToSubmit =>
      password.value.isPassword == null &&
      confirmPassword.value.isNotEmpty &&
      newPassword.value == confirmPassword.value;

  Future<bool> get submit =>
      validToSubmit ? callApiEdit() : Future.value(false);

  Future<bool> callApiEdit() async {
    final phonePref = await Preference.getPhoneNumber();
    final emailPref = await Preference.getEmail();
    final documentInfo = dbWelCome
        .doc(loginDocument)
        .collection(phonePref.isNotEmpty ? phoneCollection : emailCollection)
        .doc(phonePref.isNotEmpty ? phonePref : emailPref);
    if ((await documentInfo.get()).data()?[passwordField] != password.value) {
      Fluttertoast.showToast(msg: LocaleKeys.old_password_wrong.tr);
      return false;
    } else {
      await documentInfo.update({'passwordField': newPassword.value});
      await Preference.setPassword(newPassword.value);
      return true;
    }
  }

  back() => HomeController.instance.back();
}
