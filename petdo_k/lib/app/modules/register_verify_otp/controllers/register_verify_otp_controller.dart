import 'package:get/get.dart';

import '../../../common/my_get_controller.dart';
import '../../../routes/app_pages.dart';
import '../../register_verify_information/controllers/register_verify_information_controller.dart';
import '../providers/register_verify_otp_provider.dart';

class RegisterVerifyOtpController
    extends MyGetxController<RegisterVerifyOtpProvider> {
  final registerByPhone = true.obs;
  final phone = ''.obs;
  final email = ''.obs;
  final code = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    final params = Get.parameters;
    registerByPhone.value =
        params[RegisterVerifyInformationController.registerTypeKey] ==
            RegisterVerifyInformationController.phoneKey;
    phone.value = params[RegisterVerifyInformationController.phoneKey] ?? '';
    email.value = params[RegisterVerifyInformationController.emailKey] ?? '';
  }

  @override
  void onClose() {}

  confirmCode() {
    // Call API
    Get.offAllNamed(Routes.REGISTER_SUCCESS);
  }
}
