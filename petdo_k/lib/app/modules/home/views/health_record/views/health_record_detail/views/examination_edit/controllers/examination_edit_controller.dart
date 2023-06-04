import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petdo_k/app/model/pet_vet.dart';
import 'package:petdo_k/app/modules/home/views/health_record/controllers/health_record_controller.dart';
import 'package:petdo_k/generated/locales.g.dart';
import 'package:petdo_k/utils.dart';

import '../../../../../../../../../common/const.dart';
import '../../../../../../../controllers/home_controller.dart';
import '../../examination_schedule/controllers/examination_schedule_controller.dart';

class ExaminationEditController extends GetxController {
  final vaccineDateController = TextEditingController();
  final revaccineDateController = TextEditingController();
  final thanNhietController = TextEditingController();
  final canNangController = TextEditingController();
  final trieuChungController = TextEditingController();
  final chanDoanBenhController = TextEditingController();
  final cacLoaiThuocController = TextEditingController();
  final doctorPhoneController = TextEditingController();
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
    final vetData =
        Get.find<ExaminationScheduleController>().selected.values.first;
    title.value =
    '${LocaleKeys.number.tr} ${Get.find<ExaminationScheduleController>().vetCount.value}';
    // Date time
    vaccineDateController.text = vetData.date ?? '';
    revaccineDateController.text = vetData.returnDate ?? '';
    date.value = vaccineDateController.text;
    // Thong tin khac
    thanNhietController.text = '${vetData.bodyTemp}°C';
    canNangController.text = '${vetData.weight} kg';
    trieuChungController.text = vetData.symptom ?? '';
    chanDoanBenhController.text = vetData.illness ?? '';
    cacLoaiThuocController.text = vetData.drug ?? '';
    doctorPhoneController.text = vetData.phone ?? '';
    bacSyController.text = vetData.doctor ?? '';
    coSoController.text = vetData.location ?? '';
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
        .collection(vetCollection)
        .doc(Get.find<ExaminationScheduleController>().selected.keys.first)
        .delete()
        .then((_) {
      showSnackBar('Successfully');
      ready.value = true;
      if (HomeController.instance.back() != MainView.examinationSchedule) {
        HomeController.instance.changeMainView(MainView.examinationSchedule);
      }
      Get.find<ExaminationScheduleController>().onReady();
    });
  }

  callAPIEdit() async {
    ready.value = false;
    dbHealth
        .doc(Get.find<HealthRecordController>().selectedId.value)
        .collection(vetCollection)
        .doc(Get.find<ExaminationScheduleController>().selected.keys.first)
        .update(PetVet(
        date: vaccineDateController.text,
        returnDate: revaccineDateController.text,
        location: coSoController.text,
        doctor: bacSyController.text,
        symptom: trieuChungController.text,
        phone: doctorPhoneController.text,
        drug: cacLoaiThuocController.text,
        illness: chanDoanBenhController.text,
        weight:
        canNangController.text.replaceAll(RegExp(r'[^0-9]'), ''),
        bodyTemp:
        thanNhietController.text.replaceAll(RegExp(r'[^0-9]'), ''))
        .toJson())
        .then((_) {
      showSnackBar('Successfully');
      ready.value = true;
      if (HomeController.instance.back() != MainView.examinationSchedule) {
        HomeController.instance.changeMainView(MainView.examinationSchedule);
      }
      Get.find<ExaminationScheduleController>().onReady();
    }).onError((error, stackTrace) {
      showSnackBar('Failed');
      ready.value = true;
      if (HomeController.instance.back() != MainView.examinationSchedule) {
        HomeController.instance.changeMainView(MainView.examinationSchedule);
      }
      Get.find<ExaminationScheduleController>().onReady();
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
