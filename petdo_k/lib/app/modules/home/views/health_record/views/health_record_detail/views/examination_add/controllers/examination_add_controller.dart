import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petdo_k/app/model/pet_vet.dart';
import 'package:petdo_k/app/modules/home/views/health_record/controllers/health_record_controller.dart';
import 'package:petdo_k/utils.dart';

import '../../../../../../../../../common/const.dart';
import '../../../../../../../controllers/home_controller.dart';
import '../../examination_schedule/controllers/examination_schedule_controller.dart';

class ExaminationAddController extends GetxController {
  final vaccineDateController = TextEditingController();
  final revaccineDateController = TextEditingController();
  final ready = true.obs;
  final date = ''.obs;
  final temp = ''.obs;
  final weight = ''.obs;
  final symptom = ''.obs;
  final illness = ''.obs;
  final drug = ''.obs;
  final phone = ''.obs;
  final doctor = ''.obs;
  final location = ''.obs;

  final healthController = Get.find<HealthRecordController>();

  get submit => date.value.isEmpty ? null : () => addExam();

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

  addExam() async {
    ready.value = false;
    final vetDoc = dbHealth
        .doc(healthController.selectedId.value)
        .collection(vetCollection)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());
    await vetDoc.set(PetVet(
        date: vaccineDateController.text,
        bodyTemp: temp.value,
        weight: weight.value,
        drug: drug.value,
        illness: illness.value,
        phone: phone.value,
        symptom: symptom.value,
        returnDate: revaccineDateController.text,
        doctor: doctor.value,
        location: location.value)
        .toJson()).whenComplete(() {
      showSnackBar('Add successfully');
      ready.value = true;
      if (HomeController.instance.back() != MainView.examinationSchedule) {
        HomeController.instance.changeMainView(MainView.examinationSchedule);
      }
      HomeController.instance.back();
    });
  }
}
