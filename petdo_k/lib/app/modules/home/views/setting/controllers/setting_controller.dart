import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petdo_k/app/common/preferences.dart';
import 'package:petdo_k/utils.dart';

import '../../../controllers/home_controller.dart';

class SettingController extends GetxController {
  final token = RxnString();
  final ready = false.obs;
  final name = ''.obs;
  final phone = ''.obs;
  final email = ''.obs;
  final imageUrl = ''.obs;
  final Rxn<XFile> image = Rxn();

  void deleteLocalInfo() async {
    await Preference.clearAll();
  }


  @override
  void onReady() async{
    token.value = await Preference.getEmail();
    if (token.value?.isEmpty == true) {
      ready.value = true;
    } else {
      getInfo();
    }
  }

  Future<void> getInfo() async {
    phone.value = await Preference.getPhoneNumber();
    email.value = await Preference.getEmail();
    final documentResult = await dbWelCome
        .doc(infoDocument)
        .collection(
        phone.value.isNotEmpty ? phoneCollection : emailCollection)
        .doc(phone.value.isNotEmpty
        ? phone.value
        : email.value)
        .get();
    imageUrl.value = documentResult.data()?['image'] ?? '';
    ready.value = true;
  }

  Future<bool> uploadImage() async {
    final phonePref = await Preference.getPhoneNumber();
    final emailPref = await Preference.getEmail();
    final documentInfo = dbWelCome
        .doc(infoDocument)
        .collection(phonePref.isNotEmpty ? phoneCollection : emailCollection)
        .doc(phonePref.isNotEmpty ? phonePref : emailPref);
    final imageId = '${DateTime.now().millisecondsSinceEpoch}_${image.value?.name}';
    final imageStorage = storageRef.child(imageId);
    await imageStorage.putFile(File(image.value!.path));
    final imageUrl = await imageStorage.getDownloadURL();
    final map = {'image': imageUrl};
    await documentInfo.update(map);
    return true;
  }

   Future<void> getImage () async {
    final ImagePicker _picker = ImagePicker();
    image.value = await _picker.pickImage(source: ImageSource.gallery);
    if (image.value != null){
      isImageUploading = true;
      await uploadImage();
      isImageUploading= false;
    }
  }

  back() => HomeController.instance.back();
}
