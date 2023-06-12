import 'package:get/get.dart';
import 'package:petdo_k/app/common/preferences.dart';

import '../../../controllers/home_controller.dart';

class SettingController extends GetxController {
  void deleteLocalInfo() async {
    await Preference.clearAll();
  }

  back() => HomeController.instance.back();
}
