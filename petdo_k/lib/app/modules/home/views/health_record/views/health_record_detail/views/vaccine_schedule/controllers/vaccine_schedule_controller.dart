import 'package:get/get.dart';

import '../../../../../../../controllers/home_controller.dart';

class VaccineScheduleController extends GetxController {
  final ready = false.obs;

  final selected = 0.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onReady() {
    super.onReady();
    ready.value = false;
    Future.delayed(Duration(milliseconds: 1500), () => ready.value = true);
  }

  @override
  void onClose() {}

  back() => HomeController.instance.back();
}
