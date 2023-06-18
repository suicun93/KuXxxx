import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:petdo_k/utils.dart';

import '../../../common/const.dart';
import '../../../common/preferences.dart';
import '../../../routes/app_pages.dart';

class InitialController extends GetxController {
  var ready = true.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onReady() {
    super.onReady();
    login();
  }

  @override
  void onClose() {
    SystemChrome.setSystemUIOverlayStyle(defaultSystemUiOverlayStyle);
  }

  Future<void> login() async {
    final phoneNumber = await Preference.getPhoneNumber();
    final email = await Preference.getEmail();
    final password = await Preference.getPassword();
    if (phoneNumber.isNotEmpty || email.isNotEmpty) {
      final result = await dbWelCome
          .doc(loginDocument)
          .collection(
              phoneNumber.isNotEmpty ? phoneCollection : emailCollection)
          .doc(phoneNumber.isNotEmpty ? phoneNumber : email)
          .get();
      if (result.data()?[passwordField] == password) {
        Get.offAndToNamed(Routes.HOME);
      } else {
        Future.delayed(
            Duration(seconds: 1), () => Get.offAndToNamed(Routes.WELCOME));
      }
    } else {
      Future.delayed(
          Duration(seconds: 1), () => Get.offAndToNamed(Routes.WELCOME));
    }
  }
}
