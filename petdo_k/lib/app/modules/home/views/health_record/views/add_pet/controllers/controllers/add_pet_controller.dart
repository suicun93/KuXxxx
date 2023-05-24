import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../controllers/home_controller.dart';

class AddPetController extends GetxController {
  final ready = true.obs;
  final isDog = true.obs;
  final RxnBool gender = RxnBool();
  final birthdayController = TextEditingController();
  final date = ''.obs;
  final Rxn<XFile> image = Rxn();

  VoidCallback? get add => date.value.isEmpty
      ? null
      : () async {
          ready.value = false;
          await Future.delayed(Duration(seconds: 1));
          back();
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
