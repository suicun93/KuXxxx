import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:petdo_k/utils.dart';

import '../../../common/const.dart';
import '../../register_verify_phone/controllers/register_verify_phone_controller.dart';

class RegisterVerifyInformationController extends GetxController {
  final hidePassword = true.obs;
  final registerByPhone = true.obs;
  final name = ''.obs;
  final phone = ''.obs;
  final email = ''.obs;
  final password = ''.obs;
  final confirmPassword = ''.obs;
  final agreeWithTermAndCondition = false.obs;

  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  // Register type
  bool get registerEmail => registerByPhone.isFalse;

  bool get registerPhone => registerByPhone.isTrue;

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onReady() {
    super.onReady();
    final params = Get.parameters;
    registerByPhone.value =
        params[RegisterVerifyPhoneController.registerTypeKey] ==
            RegisterVerifyPhoneController.phoneKey;
    phoneController.text = params[RegisterVerifyPhoneController.phoneKey] ?? '';
    phone.value = phoneController.text.toString();
    if(!phone.value.startsWith('0')) {
      phoneController.text ='0${phone.value}';
    }
    emailController.text = params[RegisterVerifyPhoneController.emailKey] ?? '';
    email.value = emailController.text.toString();
  }

  @override
  void onClose() {}

  bool get validToSubmit =>
      ((registerPhone && phone.value.isPhoneNumber) ||
          (registerEmail && email.value.isEmail)) &&
      password.value.isPassword == null &&
      confirmPassword.value.isNotEmpty &&
      password.value == confirmPassword.value &&
      agreeWithTermAndCondition.isTrue;

  Future<bool> get submit => validToSubmit ? tiepTuc() : Future.value(false);

  Future<bool> tiepTuc() async {
    String? phoneNumber;
    if(!phone.value.startsWith('0')) {
      phoneNumber = '0${phone.value}';
    }
    final documentInfo = dbWelCome
        .doc(infoDocument)
        .collection(
            phone.value.isPhoneNumber ? phoneCollection : emailCollection)
        .doc(phone.value.isPhoneNumber ? '+${phoneNumber ?? phone.value}' : email.value);
    await documentInfo.set({
      'name': name.value,
    });
    final documentLogin = dbWelCome
        .doc(loginDocument)
        .collection(
            phone.value.isPhoneNumber ? phoneCollection : emailCollection)
        .doc(phone.value.isPhoneNumber ? '+${phoneNumber ?? phone.value}' : email.value);
    await documentLogin.set({'password': password.value});
    return true;
  }

  static const emailKey = 'email_key';
  static const phoneKey = 'phone_key';
  static const registerTypeKey = 'register_type_key';
  static const nameKey = 'name_key';
  static const addressKey = 'address_key';
  static const passwordKey = 'password_key';
}
