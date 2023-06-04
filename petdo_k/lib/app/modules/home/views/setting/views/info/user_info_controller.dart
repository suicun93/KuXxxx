import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petdo_k/app/common/const.dart';
import 'package:petdo_k/app/common/preferences.dart';
import 'package:petdo_k/utils.dart';

class UserInfoController extends GetxController {
  final hidePassword = true.obs;
  final name = ''.obs;
  final phone = ''.obs;
  final email = ''.obs;
  final address = ''.obs;
  final password = ''.obs;
  final newPassword = ''.obs;
  final confirmPassword = ''.obs;
  final editMode = false.obs;
  final ready = false.obs;

  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  bool get validToSubmit =>
      name.value.isNotEmpty &&
      password.value.isPassword == null &&
      confirmPassword.value.isNotEmpty &&
      password.value == confirmPassword.value;

  Future<bool> get submit =>
      validToSubmit ? callApiEdit() : Future.value(false);


  @override
  void onReady() {
    ready.value = false;
    editMode.value = false;
    getInfo();
  }

  Future<void> getInfo() async {
    phoneController.text = await Preference.getPhoneNumber();
    emailController.text = await Preference.getEmail();
    password.value = await Preference.getPassword();
    final documentResult = await dbWelCome
        .doc(infoDocument)
        .collection(
            phoneController.text.isNotEmpty ? phoneCollection : emailCollection)
        .doc(phoneController.text.isNotEmpty
            ? phoneController.text
            : emailController.text)
        .get();
    name.value = documentResult.data()?['name'] ?? '';
    address.value = documentResult.data()?['address'] ?? '';
    phoneController.text.isNotEmpty ? (emailController.text = documentResult.data()?['email'] ?? '') : (phoneController.text = documentResult.data()?['phone'] ?? '');
    ready.value = true;
  }

  Future<bool> callApiEdit() async {
    final phonePref = await Preference.getPhoneNumber();
    final emailPref = await Preference.getEmail();
    final documentInfo = dbWelCome
        .doc(infoDocument)
        .collection(phonePref.isNotEmpty ? phoneCollection : emailCollection)
        .doc(phonePref.isNotEmpty ? phonePref : emailPref);
    final map = {'name': name.value, 'address': address.value};
    phonePref.isNotEmpty ? map['email'] = emailController.text : map['phone'] = phoneController.text;
    await documentInfo.set(map);
    return true;
  }
}
