import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    title.value = 'Lần ${Get.find<VaccineScheduleController>().selected.value}';
    // Date time
    final example = formatterFullDate(DateTime.now())!;
    vaccineDateController.text = example;
    revaccineDateController.text = example;
    date.value = vaccineDateController.text;
    // Thong tin khac
    thanNhietController.text = '38°C';
    canNangController.text = '4.9 kg';
    loaiVaccineController.text = 'Astra Zeneca';
    bacSyController.text = 'Đức Hoàng';
    coSoController.text = 'Thu Cúc, Hà Nội';
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

  callAPI() async {
    ready.value = false;
    Future.delayed(Duration(milliseconds: 1500), () {
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
        : () => showDialog(() => callAPI());
  }

  get editButton =>
      editMode.value ? () => callAPI() : () => editMode.value = true;
}
