import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petdo_k/app/model/pet_vaccine.dart';
import 'package:petdo_k/app/modules/home/views/health_record/controllers/health_record_controller.dart';
import 'package:petdo_k/generated/locales.g.dart';
import 'package:petdo_k/utils.dart';

import '../../../../../../../../../common/const.dart';
import '../../../../../../../controllers/home_controller.dart';
import '../../vaccine_schedule/controllers/vaccine_schedule_controller.dart';

class VaccineEditController extends GetxController {
  final vaccineDateController = TextEditingController();
  final revaccineDateController = TextEditingController();
  final thanNhietController = TextEditingController();
  final canNangController = TextEditingController();
  final loaiVaccineController = TextEditingController();
  final bacSyController = TextEditingController();
  final coSoController = TextEditingController();
  final ready = false.obs;
  final date = ''.obs;
  final editMode = false.obs;
  final title = ''.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  // }
  //
  @override
  void onReady() {
    super.onReady();
    ready.value = false;
    Future.delayed(Duration(milliseconds: 1500), () => ready.value = true);
    final vaccineData =
        Get.find<VaccineScheduleController>().selected.values.first;
    title.value =
        '${LocaleKeys.number.tr} ${Get.find<VaccineScheduleController>().vaccineCount.value}';
    // Date time
    vaccineDateController.text = vaccineData.date ?? '';
    revaccineDateController.text = vaccineData.returnDate ?? '';
    date.value = vaccineDateController.text;
    // Thong tin khac
    thanNhietController.text = '${vaccineData.bodyTemp}°C';
    canNangController.text = '${vaccineData.weight} kg';
    loaiVaccineController.text = vaccineData.vaccineType ?? '';
    bacSyController.text = vaccineData.doctor ?? '';
    coSoController.text = vaccineData.location ?? '';
    ever<bool>(editMode, (_) {
      if (_) {
        ready.value = false;
        Future.delayed(
          Duration(milliseconds: 500),
          () => ready.value = true,
        );
      }
    });
  }

  @override
  void onClose() {}

  back() => HomeController.instance.back();

  callAPIDelete() async {
    ready.value = false;
    dbHealth
        .doc(Get.find<HealthRecordController>().selectedId.value)
        .collection(vaccineCollection)
        .doc(Get.find<VaccineScheduleController>().selected.keys.first)
        .delete()
        .then((_) {
      showSnackBar('Successfully');
      ready.value = true;
      if (HomeController.instance.back() != MainView.vaccineSchedule) {
        HomeController.instance.changeMainView(MainView.vaccineSchedule);
      }
      Get.find<VaccineScheduleController>().onReady();
    });
  }

  callAPIEdit() async {
    ready.value = false;
    dbHealth
        .doc(Get.find<HealthRecordController>().selectedId.value)
        .collection(vaccineCollection)
        .doc(Get.find<VaccineScheduleController>().selected.keys.first)
        .update(PetVaccine(
                date: vaccineDateController.text,
                returnDate: revaccineDateController.text,
                location: coSoController.text,
                doctor: bacSyController.text,
                vaccineType: loaiVaccineController.text,
                weight:
                    canNangController.text.replaceAll(RegExp(r'[^0-9]'), ''),
                bodyTemp:
                    thanNhietController.text.replaceAll(RegExp(r'[^0-9]'), ''))
            .toJson())
        .then((_) {
      showSnackBar('Successfully');
      ready.value = true;
      if (HomeController.instance.back() != MainView.vaccineSchedule) {
        HomeController.instance.changeMainView(MainView.vaccineSchedule);
      }
      Get.find<VaccineScheduleController>().onReady();
    });
  }

  VoidCallback deleteButton(Function(VoidCallback) showDialog) {
    return editMode.value
        ? () => editMode.value = false
        : () => showDialog(() => callAPIDelete());
  }

  get editButton =>
      editMode.value ? () => callAPIEdit() : () => editMode.value = true;
}
