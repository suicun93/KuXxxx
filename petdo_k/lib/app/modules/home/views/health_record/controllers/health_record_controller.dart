import 'package:get/get.dart';
import 'package:petdo_k/app/common/preferences.dart';
import 'package:petdo_k/app/model/health.dart';
import 'package:petdo_k/utils.dart';

import '../../../controllers/home_controller.dart';

class HealthRecordController extends GetxController {
  final token = RxnString();
  final ready = false.obs;
  final noPet = true.obs;
  final selectedPet = Rxn<PetHealth>();
  final pets = <PetHealth>[].obs;
  final ids = <String>[];

  final selectedId = Rxn<String>();

  @override
  void onReady() async {
    super.onReady();
    token.value = await Preference.getEmail();
    ready.value = false;
    _getAllHealthRecord();
  }

  @override
  void onClose() {}

  _getAllHealthRecord() async {
    pets.clear();
    ids.clear();
    final result = await dbHealth.get();
    ids.addAll(result.docs.map((e) => e.id));
    pets.value = petsFromJson(result.docs.map((e) => e.data()).toList());
    ready.value = true;
    noPet.value = pets.isNotEmpty;
  }

  Future<void> deletePet() async {
    final petIndex = pets.indexOf(selectedPet.value);
    await dbHealth.doc(ids[petIndex]).delete();
   if (selectedPet.value?.imageId.isNotEmpty == true) {
     await storageRef.child(selectedPet.value?.imageId ?? '').delete();
   }
   ids.removeAt(petIndex);
   pets.removeAt(petIndex);
   noPet.value = pets.isNotEmpty;
  }

  Future<void> editPet(PetHealth petHealth) async{
    final petIndex = pets.indexOf(selectedPet.value);
    final petRef = dbHealth.doc(ids[petIndex]);
    await petRef.update(petHealth.toJson());
  }

  void toDetail({required PetHealth pet}) {
    selectedPet.value = pet;
    selectedId.value = ids[pets.indexOf(selectedPet.value)];
    HomeController.instance.changeMainView(MainView.healthRecordDetail);
  }
}
