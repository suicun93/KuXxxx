import 'package:get/get.dart';
import 'package:petdo_k/app/model/pet_vet.dart';
import 'package:petdo_k/app/modules/home/views/health_record/controllers/health_record_controller.dart';
import 'package:petdo_k/utils.dart';

import '../../../../../../../controllers/home_controller.dart';

class ExaminationScheduleController extends GetxController {
  final ready = false.obs;
  final selected = <String, PetVet>{}.obs;
  final vetCount = 0.obs;
  final vetMap = <Map<String, PetVet>>[].obs;

  @override
  void onReady() {
    super.onReady();
    ready.value = false;
    getAllExam();
  }

  Future<void> getAllExam() async{
    vetMap.clear();
    final dbVaccine = await dbHealth.doc(Get.find<HealthRecordController>().selectedId.value).collection(vetCollection).get();
    final List<Map<String, PetVet>> data = dbVaccine.docs.map((snapshot) => {snapshot.id: PetVet.fromJson(snapshot.data())}).toList();
    vetMap.addAll(data.reversed);
    ready.value = true;
  }

  @override
  void onClose() {}

  back() => HomeController.instance.back();
}
