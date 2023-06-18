import 'package:get/get.dart';
import 'package:petdo_k/app/model/health.dart';
import 'package:petdo_k/app/model/pet_vaccine.dart';
import 'package:petdo_k/app/model/pet_vet.dart';
import 'package:petdo_k/utils.dart';

import '../../../../../controllers/home_controller.dart';
import '../../../../health_record/controllers/health_record_controller.dart';

class HealthRecordDetailController extends GetxController {
  final selectedPet = Rxn<PetHealth>();
  final ready = false.obs;
  final backController = Get.find<HealthRecordController>();
  final vaccineMap = <Map<String, PetVaccine>>[].obs;
  final vetMap = <Map<String, PetVet>>[].obs;

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
    vaccineMap.clear();
    vetMap.clear();
    selectedPet.value = backController.selectedPet.value;
    getAllVaccine();
    getAllExam();
  }

  Future<void> getAllExam() async {
    final dbVaccine = await dbHealth
        .doc(Get.find<HealthRecordController>().selectedId.value)
        .collection(vetCollection)
        .get();
    final List<Map<String, PetVet>> data = dbVaccine.docs
        .map((snapshot) => {snapshot.id: PetVet.fromJson(snapshot.data())})
        .toList();
    vetMap.addAll(data.reversed);
    ready.value = true;
  }

  Future<void> getAllVaccine() async {
    final dbVaccine = await dbHealth
        .doc(backController.selectedId.value)
        .collection(vaccineCollection)
        .get();
    final data = dbVaccine.docs
        .map((snapshot) => {snapshot.id: PetVaccine.fromJson(snapshot.data())})
        .toList();
    vaccineMap.addAll(data.reversed);
  }

  @override
  void onClose() {}

  Future<void> removePet() async {
    await backController.deletePet();
  }

  back() => HomeController.instance.back();
}
