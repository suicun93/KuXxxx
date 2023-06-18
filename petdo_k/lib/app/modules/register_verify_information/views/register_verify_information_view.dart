import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../generated/locales.g.dart';
import '../../../common/const.dart';
import '../../../routes/app_pages.dart';
import '../controllers/register_verify_information_controller.dart';

class RegisterVerifyInformationView
    extends GetView<RegisterVerifyInformationController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: LoaderOverlay(
        child: Scaffold(
          appBar: AppBar(
            title: Text(LocaleKeys.register_btn.tr),
            toolbarHeight: toolbarHeight,
            leading: InkWell(
              onTap: () => Get.back(),
              child: Icon(CupertinoIcons.arrow_left),
            ),
            leadingWidth: 60,
          ),
          body: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: SingleChildScrollView(
              // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: EdgeInsets.only(left: 40, right: 40),
              child: main(context: context),
            ),
          ),
        ),
      ),
    );
  }

  Widget main({required BuildContext context}) {
    return Obx(
      () => Column(
        children: [
          SizedBox(height: 40),

          /// Name
          TextFormField(
            validator: (v) =>
                !(v?.isNotEmpty ?? false) ? LocaleKeys.name_invalid.tr : null,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: Get.textTheme.titleLarge,
            cursorColor: subPrimaryColor,
            keyboardType: TextInputType.name,
            onChanged: (_) => controller.name.value = _,
            decoration: InputDecoration(
              labelText: LocaleKeys.name.tr,
              contentPadding: EdgeInsets.only(left: 21),
            ),
          ),
          SizedBox(height: 24),

          /// Phone
          /// Email
          controller.registerByPhone.value
              ? TextFormField(
                  validator: (v) => !(v?.isPhoneNumber ?? false)
                      ? LocaleKeys.phone_number_invalid.tr
                      : null,
                  autovalidateMode: AutovalidateMode.always,
                  style: Get.textTheme.headline6,
                  cursorColor: subPrimaryColor,
                  keyboardType: TextInputType.phone,
                  onChanged: (_) => controller.phone.value = _,
                  controller: controller.phoneController,
                  decoration: InputDecoration(
                    labelText: LocaleKeys.phone.tr,
                    hintText: LocaleKeys.enter_your_phone.tr,
                    contentPadding: EdgeInsets.only(left: 21),
                  ),
                )
              : TextFormField(
                  validator: (v) => !(v?.isEmail ?? false)
                      ? LocaleKeys.email_invalid.tr
                      : null,
                  autovalidateMode: AutovalidateMode.always,
                  style: Get.textTheme.headline6,
                  cursorColor: subPrimaryColor,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (_) => controller.email.value = _,
                  controller: controller.emailController,
                  decoration: InputDecoration(
                    labelText: LocaleKeys.email.tr,
                    hintText: LocaleKeys.enter_your_mail.tr,
                    contentPadding: EdgeInsets.only(left: 21),
                  ),
                ),

          SizedBox(height: 24),

          /// Password
          TextFormField(
            validator: (v) => v.isPassword,
            autovalidateMode: AutovalidateMode.always,
            style: Get.textTheme.headline6,
            cursorColor: subPrimaryColor,
            obscureText: controller.hidePassword.value,
            keyboardType: TextInputType.visiblePassword,
            onChanged: (_) => controller.password.value = _,
            decoration: InputDecoration(
              labelText: LocaleKeys.password.tr,
              hintText: LocaleKeys.password_hint.tr,
              errorMaxLines: 3,
              contentPadding: EdgeInsets.only(left: 21),
              suffixIcon: GestureDetector(
                onTap: () => controller.hidePassword.toggle(),
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.remove_red_eye_rounded,
                    color: controller.hidePassword.value
                        ? buttonDisableColor
                        : subPrimaryColor,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 24),
          TextFormField(
            validator: (v) => !((v?.isNotEmpty ?? false) &&
                    v.toString() == controller.password.value)
                ? LocaleKeys.password_not_match.tr
                : null,
            autovalidateMode: AutovalidateMode.always,
            style: Get.textTheme.headline6,
            cursorColor: subPrimaryColor,
            obscureText: controller.hidePassword.value,
            keyboardType: TextInputType.visiblePassword,
            onChanged: (_) => controller.confirmPassword.value = _,
            decoration: InputDecoration(
              labelText: LocaleKeys.confirmPassword.tr,
              errorMaxLines: 2,
              contentPadding: EdgeInsets.only(left: 21),
              suffixIcon: GestureDetector(
                onTap: () => controller.hidePassword.toggle(),
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.remove_red_eye_rounded,
                    color: controller.hidePassword.value
                        ? buttonDisableColor
                        : subPrimaryColor,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 46),

          /// Agree with ...
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () => controller.agreeWithTermAndCondition.toggle(),
              child: Text.rich(
                TextSpan(
                  children: [
                    WidgetSpan(
                      child: Icon(
                        controller.agreeWithTermAndCondition.value
                            ? CupertinoIcons.checkmark_square_fill
                            : CupertinoIcons.square_fill,
                        size: 17,
                        color: controller.agreeWithTermAndCondition.value
                            ? subPrimaryColor
                            : buttonDisableColor,
                      ),
                    ),
                    WidgetSpan(child: SizedBox(width: 7)),
                    TextSpan(
                      text: LocaleKeys.register_i_agree_with.tr,
                      style: Get.textTheme.bodyText1,
                    ),
                    TextSpan(
                      text: LocaleKeys.register_terms_and_conditions.tr,
                      style: Get.textTheme.button?.copyWith(
                        color: subPrimaryColor,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => showSnackBar(
                              LocaleKeys.not_supported_yet.tr,
                            ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
                maxLines: 4,
              ),
            ),
          ),
          SizedBox(height: 25),

          /// Continue Button
          Container(
            width: double.infinity,
            child: ElevatedButton(
              child: Text(LocaleKeys.continue_btn.tr),
              onPressed: checkRegister(context),
              // onPressed: null,
            ),
          ),
          SizedBox(height: 32),

          /// Have phone already
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: LocaleKeys.register_you_had_account_already.tr,
                  style: Get.textTheme.bodyText1,
                ),
                TextSpan(
                  text: LocaleKeys.login_btn.tr,
                  style: Get.textTheme.button?.copyWith(
                    color: subPrimaryColor,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => Get.offAllNamed(Routes.LOGIN),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 300),
        ],
      ),
    );
  }

  VoidCallback? checkRegister(BuildContext context) {
    if (controller.validToSubmit) {
      return () {
        context.loaderOverlay.show();
        controller.submit.then((done) {
          context.loaderOverlay.hide();
          if (done) {
            Fluttertoast.showToast(msg: LocaleKeys.create_account_success.tr);
            Get.offNamed(Routes.LOGIN);
          } else {
            Fluttertoast.showToast(msg: LocaleKeys.something_wrong.tr);
          }
        });
      };
    } else {
      return null;
    }
  }
}
