import 'package:get/get.dart';

import '../modules/change_language/bindings/change_language_binding.dart';
import '../modules/change_language/views/change_language_view.dart';
import '../modules/forgot_password_input_new/bindings/forgot_password_input_new_binding.dart';
import '../modules/forgot_password_input_new/views/forgot_password_input_new_view.dart';
import '../modules/forgot_password_input_phone_mail/bindings/forgot_password_input_phone_mail_binding.dart';
import '../modules/forgot_password_input_phone_mail/views/forgot_password_input_phone_mail_view.dart';
import '../modules/forgot_password_success/bindings/forgot_password_success_binding.dart';
import '../modules/forgot_password_success/views/forgot_password_success_view.dart';
import '../modules/forgot_password_verify_otp/bindings/forgot_password_verify_otp_binding.dart';
import '../modules/forgot_password_verify_otp/views/forgot_password_verify_otp_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/initial/bindings/initial_binding.dart';
import '../modules/initial/views/initial_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/register_success/bindings/register_success_binding.dart';
import '../modules/register_success/views/register_success_view.dart';
import '../modules/register_verify_information/bindings/register_verify_information_binding.dart';
import '../modules/register_verify_information/views/register_verify_information_view.dart';
import '../modules/register_verify_otp/bindings/register_verify_otp_binding.dart';
import '../modules/register_verify_otp/views/register_verify_otp_view.dart';
import '../modules/register_verify_phone/bindings/register_verify_phone_binding.dart';
import '../modules/register_verify_phone/views/register_verify_phone_view.dart';
import '../modules/welcome/bindings/welcome_binding.dart';
import '../modules/welcome/views/welcome_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.INITIAL;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.INITIAL,
      page: () => InitialView(),
      binding: InitialBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.WELCOME,
      page: () => WelcomeView(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER_VERIFY_PHONE,
      page: () => RegisterVerifyPhoneView(),
      binding: RegisterVerifyPhoneBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER_VERIFY_INFORMATION,
      page: () => RegisterVerifyInformationView(),
      binding: RegisterVerifyInformationBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER_VERIFY_OTP,
      page: () => RegisterVerifyOtpView(),
      binding: RegisterVerifyOtpBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER_SUCCESS,
      page: () => RegisterSuccessView(),
      binding: RegisterSuccessBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD_INPUT_NEW,
      page: () => ForgotPasswordInputNewView(),
      binding: ForgotPasswordInputNewBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD_SUCCESS,
      page: () => ForgotPasswordSuccessView(),
      binding: ForgotPasswordSuccessBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD_VERIFY_OTP,
      page: () => ForgotPasswordVerifyOtpView(),
      binding: ForgotPasswordVerifyOtpBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD_INPUT_PHONE_MAIL,
      page: () => ForgotPasswordInputPhoneMailView(),
      binding: ForgotPasswordInputPhoneMailBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_LANGUAGE,
      page: () => const ChangeLanguageView(),
      binding: ChangeLanguageBinding(),
    ),
  ];
}
