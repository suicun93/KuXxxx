import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../../../common/const.dart';
import '../../../../../../../controllers/home_controller.dart';
import '../../examination_schedule/controllers/examination_schedule_controller.dart';

class ExaminationAddController extends GetxController {
  final vaccineDateController = TextEditingController();
  final revaccineDateController = TextEditingController();
  final ready = true.obs;
  final date = ''.obs;

  get submit => date.value.isEmpty ? null : () => addVaccine();

  // @override
  // void onInit() {
  //   super.onInit();
  // }
  //
  @override
  void onReady() {
    super.onReady();
    vaccineDateController.addListener(listenVaccineDate);
  }

  @override
  void onClose() {
    vaccineDateController.removeListener(listenVaccineDate);
  }

  void listenVaccineDate() => date.value = vaccineDateController.text;

  back() => HomeController.instance.back();

  addVaccine() async {
    ready.value = false;
    Future.delayed(Duration(milliseconds: 1500), () {
      showSnackBar('Add successfully');
      ready.value = true;
      if (HomeController.instance.back() != MainView.examinationSchedule) {
        HomeController.instance.changeMainView(MainView.examinationSchedule);
      }
      Get.find<ExaminationScheduleController>().onReady();
    });
  }
}
