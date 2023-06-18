import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petdo_k/app/model/health.dart';
import 'package:petdo_k/app/modules/home/views/health_record/controllers/health_record_controller.dart';
import 'package:petdo_k/utils.dart';

import '../../../../../../controllers/home_controller.dart';

class AddPetController extends GetxController {
  final ready = true.obs;
  final isDog = true.obs;
  final RxnBool gender = RxnBool(false);
  final birthdayController = TextEditingController();
  final date = ''.obs;
  final Rxn<XFile> image = Rxn();
  final petName = ''.obs;
  final petWeight = 0.0.obs;
  final type = ''.obs;
  final backController = Get.find<HealthRecordController>();

  VoidCallback? get add => date.value.isEmpty
      ? null
      : () async {
          ready.value = false;
          if (image.value?.path != null) {
            final imageId =
                '${DateTime.now().millisecondsSinceEpoch}_${image.value?.name}';
            final imageStorage = storageRef.child(imageId);
            await imageStorage.putFile(File(image.value!.path));
            final imageUrl = await imageStorage.getDownloadURL();
            final petInfo =
                dbHealth.doc(DateTime.now().millisecondsSinceEpoch.toString());
            petInfo
                .set(PetHealth(
                        imageUrl: imageUrl,
                        imageId: imageId,
                        type: type.value,
                        isDog: isDog.value,
                        name: petName.value,
                        birthDay: birthdayController.text,
                        isMale: gender.value ?? false,
                        weight: petWeight.value)
                    .toJson())
                .whenComplete(() {
              backController.onReady();
              back();
            });
          } else {
            final petInfo =
                dbHealth.doc(DateTime.now().millisecondsSinceEpoch.toString());
            petInfo
                .set(PetHealth(
                        imageUrl: '',
                        imageId: '',
                        type: type.value,
                        isDog: isDog.value,
                        name: petName.value,
                        birthDay: birthdayController.text,
                        isMale: gender.value ?? false,
                        weight: petWeight.value)
                    .toJson())
                .whenComplete(() {
              backController.onReady();
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
    birthdayController.addListener(listenDate);
  }

  @override
  void onClose() {
    birthdayController.removeListener(listenDate);
  }

  void listenDate() => date.value = birthdayController.text;

  back() => HomeController.instance.back();
}
