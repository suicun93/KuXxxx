import 'package:get/get.dart';

import '../../../../../controllers/home_controller.dart';
import '../../../../health_record/controllers/health_record_controller.dart';

class HealthRecordDetailController extends GetxController {
  final selectedImage = ''.obs;
  final selectedName = ''.obs;
  final ready = false.obs;
  final backController = Get.find<HealthRecordController>();

  get addVaccine => () => HomeController.instance.changeMainView(
        MainView.vaccineAdd,
      );

  get showVaccine => () => HomeController.instance.changeMainView(
        MainView.vaccineSchedule,
      );

  get addExamination => () => HomeController.instance.changeMainView(
        MainView.examinationAdd,
      );

  get showExamination => () => HomeController.instance.changeMainView(
        MainView.examinationSchedule,
      );

  @override
  void onReady() {
    super.onReady();
    selectedImage.value = backController.selectedImage.value;
    selectedName.value = backController.selectedName.value;
    ready.value = false;
    Future.delayed(Duration(milliseconds: 1500), () => ready.value = true);
  }

  @override
  void onClose() {}

  back() => HomeController.instance.back();
}
