import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petdo_k/app/model/health.dart';
import 'package:petdo_k/app/modules/home/views/health_record/controllers/health_record_controller.dart';
import 'package:petdo_k/app/modules/home/views/health_record/views/health_record_detail/controllers/health_record_detail_controller.dart';
import 'package:petdo_k/utils.dart';

import '../../../../../../controllers/home_controller.dart';

class EditPetController extends GetxController {
  final ready = true.obs;
  final isDog = true.obs;
  final RxnBool gender = RxnBool(false);
  final birthdayController = TextEditingController();
  final nameController = TextEditingController();
  final typeController = TextEditingController();
  final weightController = TextEditingController();
  final date = ''.obs;
  final Rxn<XFile> image = Rxn();
  final petName = ''.obs;
  final imageUrl = ''.obs;
  final petWeight = 0.0.obs;
  final type = ''.obs;
  final petController = Get.find<HealthRecordController>();
  final petDetailController = Get.find<HealthRecordDetailController>();

  VoidCallback? get edit => date.value.isEmpty
      ? null
      : () async {
          ready.value = false;
          if (image.value?.path != null) {
            final imageId =
                '${DateTime.now().millisecondsSinceEpoch}_${image.value?.name}';
            final imageStorage = storageRef.child(imageId);
            await imageStorage.putFile(File(image.value!.path));
            final imageUrl = await imageStorage.getDownloadURL();
            final petHealth = PetHealth(
                imageUrl: imageUrl,
                imageId: imageId,
                type: type.value,
                isDog: isDog.value,
                name: petName.value,
                birthDay: birthdayController.text,
                isMale: gender.value ?? false,
                weight: petWeight.value);
            petController.editPet(petHealth).whenComplete(() {
              petDetailController.selectedPet.value = petHealth;
              petController.onReady();
              petController.selectedPet.value = petHealth;
              back();
            });
          } else {
            final petHealth = PetHealth(
                imageUrl: imageUrl.value,
                imageId: petController.selectedPet.value?.imageId ?? '',
                type: type.value,
                isDog: isDog.value,
                name: petName.value,
                birthDay: birthdayController.text,
                isMale: gender.value ?? false,
                weight: petWeight.value);
            petController.editPet(petHealth).whenComplete(() {
              petController.selectedPet.value = petHealth;
              petController.onReady();
              petDetailController.selectedPet.value = petHealth;
              back();
            });
          }
        };

  get getImage => () async {
        final ImagePicker _picker = ImagePicker();
        image.value = await _picker.pickImage(source: ImageSource.gallery);
      };

  @override
  void onReady() {
    super.onReady();
    petName.value = petController.selectedPet.value?.name ?? '';
    nameController.text = petController.selectedPet.value?.name ?? '';
    isDog.value = petController.selectedPet.value?.isDog ?? false;
    type.value = petController.selectedPet.value?.type ?? '';
    typeController.text = petController.selectedPet.value?.type ?? '';
    date.value = petController.selectedPet.value?.birthDay ?? '';
    birthdayController.text = petController.selectedPet.value?.birthDay ?? '';
    petWeight.value = petController.selectedPet.value?.weight ?? 0.0;
    weightController.text =
        (petController.selectedPet.value?.weight ?? 0.0).toString();
    imageUrl.value = petController.selectedPet.value?.imageUrl ?? '';
    gender.value = petController.selectedPet.value?.isMale;
    birthdayController.addListener(listenDate);
  }

  @override
  void onClose() {
    birthdayController.removeListener(listenDate);
  }

  void listenDate() => date.value = birthdayController.text;

  back() => HomeController.instance.back();
}
