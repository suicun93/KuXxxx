import 'package:get/get.dart';

class RegisterVerifyOtpProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }
}
