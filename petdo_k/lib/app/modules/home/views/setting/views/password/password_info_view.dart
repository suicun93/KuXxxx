import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:petdo_k/app/common/const.dart';
import 'package:petdo_k/app/modules/home/controllers/home_controller.dart';
import 'package:petdo_k/app/modules/home/views/setting/views/password/password_controller.dart';
import 'package:petdo_k/generated/locales.g.dart';

class PasswordInfoView extends GetView<PasswordController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => controller.back(),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: LoaderOverlay(
          child: Column(
            children: [
              _appbar,
              Expanded(
                child: Obx(() => Container(
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
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget main({required BuildContext context}) {
    return Column(
      children: [
        SizedBox(height: 40),

        /// old password
        TextFormField(
          validator: (v) =>
              !(v?.isPassword == null) ? LocaleKeys.password_invalid.tr : null,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: Get.textTheme.titleLarge,
          initialValue: controller.password.value,
          cursorColor: subPrimaryColor,
          obscureText: controller.hidePassword.value,
          keyboardType: TextInputType.text,
          onChanged: (_) => controller.password.value = _,
          decoration: InputDecoration(
            labelText: LocaleKeys.old_password.tr,
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
        SizedBox(height: 24),

        //new password
        TextFormField(
          validator: (v) =>
              !(v?.isPassword == null) ? LocaleKeys.password_invalid.tr : null,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: Get.textTheme.headline6,
          cursorColor: subPrimaryColor,
          obscureText: controller.hidePassword.value,
          keyboardType: TextInputType.text,
          onChanged: (_) => controller.newPassword.value = _,
          decoration: InputDecoration(
            labelText: LocaleKeys.new_password.tr,
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

        SizedBox(height: 24),
        //confirm password
        TextFormField(
          validator: (v) => !((v?.isPassword == null) &&
                  v.toString() == controller.newPassword.value)
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
        Container(
          width: double.infinity,
          child: ElevatedButton(
            child: Text(LocaleKeys.edit.tr),
            onPressed: checkEdit(context),
            // onPressed: null,
          ),
        ),
        SizedBox(height: 100),
      ],
    );
  }

  Container get _appbar => Container(
        color: Colors.transparent,
        margin: EdgeInsets.only(
          top: Get.mediaQuery.viewPadding.top + 16,
          bottom: 16,
        ),
        alignment: Alignment.bottomCenter,
        child: Row(
          children: [
            GestureDetector(
              onTap: () => HomeController.instance.back(),
              child: SizedBox(
                width: 60,
                child: Image.asset('images/ic_back.png', width: 16, height: 16),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(LocaleKeys.change_password.tr,
                    style: Get.textTheme.subtitle2),
              ),
            ),
            SizedBox(width: 60),
          ],
        ),
      );

  VoidCallback? checkEdit(BuildContext context) {
    if (controller.validToSubmit) {
      return () {
        context.loaderOverlay.show();
        controller.submit.then((value) {
          context.loaderOverlay.hide();
          if (value) {
            Fluttertoast.showToast(msg: LocaleKeys.change_password_success.tr);
            HomeController.instance.back();
          }
        });
      };
    } else {
      return null;
    }
  }
}
