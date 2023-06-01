import 'package:get/get.dart';
import 'package:petdo_k/app/model/health.dart';

import '../../../../../controllers/home_controller.dart';
import '../../../../health_record/controllers/health_record_controller.dart';

class HealthRecordDetailController extends GetxController {
  final selectedPet = Rxn<PetHealth>();
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
    ready.value = false;
    selectedPet.value = backController.selectedPet.value;
    Future.delayed(Duration(milliseconds: 1500), () => ready.value = true);
  }

  @override
  void onClose() {}

  Future<void> removePet() async{
    await backController.deletePet();
  }

  back() => HomeController.instance.back();
}
