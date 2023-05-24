import 'package:flutter/services.dart';
import 'package:get/get.dart';

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
    Future.delayed(
      Duration(milliseconds: 1500),
      login,
    );
  }

  login() async {
    final token = await Preference.getToken();
    if (token.isEmpty) {
      Get.offAndToNamed(Routes.WELCOME);
    } else {
      Get.offAndToNamed(Routes.HOME);
    }
  }

  @override
  void onClose() {
    SystemChrome.setSystemUIOverlayStyle(defaultSystemUiOverlayStyle);
  }
}
