import 'package:get/get.dart';
import 'package:petdo_k/app/model/pet_vaccine.dart';
import 'package:petdo_k/app/modules/home/views/health_record/controllers/health_record_controller.dart';
import 'package:petdo_k/app/modules/home/views/health_record/views/health_record_detail/controllers/health_record_detail_controller.dart';
import 'package:petdo_k/utils.dart';

import '../../../../../../../controllers/home_controller.dart';

class VaccineScheduleController extends GetxController {
  final ready = false.obs;
  final selected = <String, PetVaccine>{}.obs;
  final vaccineCount = 0.obs;
  final vaccineMap = <Map<String, PetVaccine>>[].obs;
  final healthDetailController = Get.find<HealthRecordDetailController>();

  @override
  void onReady() {
    super.onReady();
    vaccineMap.clear();
    ready.value = false;
    getAllVaccine();
  }

  Future<void> getAllVaccine() async{
    final dbVaccine = await dbHealth.doc(Get.find<HealthRecordController>().selectedId.value).collection(vaccineCollection).get();
    final List<Map<String, PetVaccine>> data = dbVaccine.docs.map((snapshot) => {snapshot.id: PetVaccine.fromJson(snapshot.data())}).toList();
    vaccineMap.addAll(data.reversed);
    ready.value = true;
  }

  back() => HomeController.instance.back();
}
