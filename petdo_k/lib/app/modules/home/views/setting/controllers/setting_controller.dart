import 'package:get/get.dart';
import 'package:petdo_k/app/common/preferences.dart';

class SettingController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void deleteLocalInfo() async{
    await Preference.clearAll();
  }
}
