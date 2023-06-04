import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petdo_k/app/model/pet_vaccine.dart';
import 'package:petdo_k/app/modules/home/views/health_record/controllers/health_record_controller.dart';
import 'package:petdo_k/app/modules/home/views/health_record/views/health_record_detail/controllers/health_record_detail_controller.dart';
import 'package:petdo_k/utils.dart';

import '../../../../../../../../../common/const.dart';
import '../../../../../../../controllers/home_controller.dart';
import '../../vaccine_schedule/controllers/vaccine_schedule_controller.dart';

class VaccineAddController extends GetxController {
  final vaccineDateController = TextEditingController();
  final revaccineDateController = TextEditingController();
  final ready = true.obs;
  final date = ''.obs;
  final temp = ''.obs;
  final weight = ''.obs;
  final vaccineType = ''.obs;
  final doctor = ''.obs;
  final location = ''.obs;

  final healthController = Get.find<HealthRecordController>();

  get submit => date.value.isEmpty ? null : () => addVaccine();

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
    final vaccineDoc = dbHealth
        .doc(healthController.selectedId.value)
        .collection(vaccineCollection)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());
    await vaccineDoc.set(PetVaccine(
            date: vaccineDateController.text,
            bodyTemp: temp.value,
            weight: weight.value,
            vaccineType: vaccineType.value,
            returnDate: revaccineDateController.text,
            doctor: doctor.value,
            location: location.value)
        .toJson()).whenComplete(() {
      showSnackBar('Add successfully');
      ready.value = true;
      if (HomeController.instance.back() != MainView.vaccineSchedule) {
        HomeController.instance.changeMainView(MainView.vaccineSchedule);
      }
      HomeController.instance.back();
    });
  }
}
